#!/usr/bin/env python3
"""Structural checks over the carve, for things `make compare` cannot see.

A byte-perfect build only proves the bytes come back; it says nothing about
whether the *structure* the source claims is true. These are the invariants
that matter when the disassembly is used as a modding base, each one written
after a real defect broke it:

  lz        every declared LZ stream decodes exactly within its extent, and
            re-encodes to a stream that decodes back to the same bytes
  lz-labels no symbol lands inside a compressed stream (a curated name once
            truncated two streams by 29 and 160 bytes)
  text      every text_offsets word lands on a string start in its pool, so
            the `dw Pool.sN - Pool` rows name real strings
  regions   manifest regions stay inside their bank and do not overlap
  constants every constants.json entry lands on an instruction that really
            holds that value -- a mis-computed offset renders nothing and
            still passes `make compare`, so nothing else can see it
  scopes    no global label covers both actor-script bytecode and CPU code
            (a routine emitted after a script with nothing naming its entry)
  branches  no conditional branch targets the instruction that follows it --
            a branch that decides nothing, which is always either a deleted
            guarded block or an inverted condition (14 exist; the list is
            curated so a new one shows up as a failure)

Exit status is non-zero if any check fails.
"""
import bisect
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from extract import string_starts
from lz import compress, decompress
from sm83 import decode

ROOT = BANK = None
BANK_SIZE = 0x4000


def load_manifest():
    out = []
    for line in (ROOT / "data.manifest").read_text().splitlines():
        if not line.strip() or line.startswith("#"):
            continue
        f = line.split()
        out.append((f[0], int(f[1], 16), int(f[2], 16),
                    f[3] if len(f) > 3 else None))
    return out


def check_lz(rom, manifest, fail):
    streams = [(p, o, n) for p, o, n, _s in manifest if "/lz_" in p]
    for path, off, length in streams:
        try:
            data, used = decompress(rom, off, off + length)
        except ValueError as e:
            fail("lz", f"{path}: does not decode inside its {length}-byte "
                       f"extent ({e})")
            continue
        if used != length:
            fail("lz", f"{path}: decodes {used} bytes, extent says {length}")
        back, _ = decompress(compress(data), 0)
        if back != data:
            fail("lz", f"{path}: re-encoded stream does not decode back")
    return len(streams)


def check_lz_labels(labels, manifest, fail):
    spans = [(o, o + n, p) for p, o, n, _s in manifest if "/lz_" in p]
    spans.sort()
    for off in sorted(labels):
        for lo, hi, path in spans:
            if lo < off < hi:
                fail("lz-labels", f"{labels[off]} (0x{off:x}) is {off - lo} "
                                  f"bytes inside {path}, which truncates it")
            if lo > off:
                break
    return len(spans)


def check_text(rom, data_tables, manifest, fail):
    pairs = []
    for off in sorted(data_tables):
        if data_tables[off] != "text_offsets":
            continue
        pool = min((o for o in data_tables
                    if o > off and data_tables[o] == "text_pool"), default=None)
        if pool is None:
            fail("text", f"table at 0x{off:x} has no text_pool after it")
            continue
        pairs.append((off, pool))
    # the pool's real length bounds the check; deriving it from the entries
    # would let a bogus entry widen the window until it looked valid
    pool_len = {o: n for p, o, n, spec in manifest if spec == "text_pool"}
    for toff, pool in pairs:
        n = pool_len.get(pool)
        if n is None:
            fail("text", f"pool 0x{pool:x} is not an extracted region")
            continue
        starts = set(string_starts(rom[pool:pool + n]))
        # entry 0 addresses the pool's first string in all 13 banks, so a table
        # whose base has slipped a word still passes the per-entry test but
        # fails this one
        if (rom[toff] | (rom[toff + 1] << 8)) != 0:
            fail("text", f"offset table 0x{toff:x} does not start at its "
                         f"pool's first string")
        for o in range(toff, pool - 1, 2):
            w = rom[o] | (rom[o + 1] << 8)
            if w not in starts:
                fail("text", f"offset table 0x{toff:x} entry "
                             f"{(o - toff) // 2} (${w:04x}) is not a string "
                             f"start in its {n}-byte pool")
    return len(pairs)


_IMM8_RE = re.compile(r"\$([0-9a-f]{1,2})$")
_LDIMM_RE = re.compile(r"^ld (?:hl|de|bc|sp), \$([0-9a-f]{1,4})$")
_BITOP_RE = re.compile(r"^(?:bit|res|set) (\d+), ")


_MNEMONICS = frozenset(
    "adc add and bit call ccf cp cpl daa dec di ei halt inc jp jr ld ldd ldh "
    "ldi nop or pop push res ret reti rl rla rlc rlca rr rra rrc rrca rst sbc "
    "scf set sla sra srl stop sub swap xor".split())
_INSTR_LINE_RE = re.compile(r"^\t(\w+)[^;]*; \$([0-9a-f]{4})\s*$")


def instruction_starts():
    """Flat offsets of every emitted instruction, from the `; $addr` comments.

    A curated immediate has to sit on an instruction *boundary*: a byte one
    past the opcode still decodes as something, so decoding alone would accept
    an off-by-one that renders nothing. The mnemonic filter keeps `dw`/`db`
    rows out -- structured tables carry the same address comments and are not
    in the manifest's data regions."""
    starts = set()
    for path in sorted((ROOT / "src").glob("bank_*.asm")):
        bank = int(path.stem.split("_")[1], 16)
        base = bank * BANK_SIZE - (0x4000 if bank else 0)
        for line in path.read_text().split("\n"):
            m = _INSTR_LINE_RE.match(line)
            if m and m.group(1) in _MNEMONICS:
                starts.add(base + int(m.group(2), 16))
    return starts


def load_defs(path):
    """constants.inc `def NAME equ <value>` -> {name: value}.

    Unlike the generator's loader this also takes the decimal form, because the
    bit-index families (`def PADB_A equ 0`) are written that way and they are
    exactly the entries `bit/res/set` sites name."""
    defs = {}
    for m in re.finditer(r"^def\s+(\w+)\s+equ\s+(\$[0-9a-f]+|\d+)\b",
                         Path(path).read_text(), re.MULTILINE | re.IGNORECASE):
        v = m.group(2)
        defs[m.group(1)] = int(v[1:], 16) if v.startswith("$") else int(v)
    return defs


def _const_value(expr, defs):
    """`NAME` or `NAME | NAME | ...` -> its value, or None if a name is unknown.

    The `|` form is how the joypad masks are written; nothing else in
    constants.json composes, and anything richer should be a def of its own."""
    total = 0
    for term in expr.split("|"):
        v = defs.get(term.strip())
        if v is None:
            return None
        total |= v
    return total


def check_constants(rom, constants, defs, manifest, fail):
    """Every constants.json entry must name the value that is actually there.

    A curated entry is keyed by the flat ROM offset of the *instruction*, and
    `render_operand` applies it only to an 8-bit immediate, a `bit/res/set N`
    index or a `ld rr, n16`. Get the offset formula wrong
    (`bank * 0x4000 + cpu - 0x4000`) and the entry addresses a byte in the
    middle of some other instruction, where it renders nothing at all -- the
    build still matches the ROM, so the only symptom is a name that never
    appears. Same for an entry that lands inside an extracted data blob."""
    data_spans = sorted((o, o + n) for _p, o, n, _s in manifest)
    starts = instruction_starts()
    for off in sorted(constants):
        expr = constants[off]
        want = _const_value(expr, defs)
        if want is None:
            fail("constants", f"0x{off:x}: {expr} is not defined in "
                              "include/constants.inc")
            continue
        i = bisect.bisect_right(data_spans, (off, float("inf"))) - 1
        if i >= 0 and data_spans[i][0] <= off < data_spans[i][1]:
            lo, hi = data_spans[i]
            fail("constants", f"0x{off:x}: {expr} is inside an extracted data "
                              f"region (0x{lo:x}-0x{hi:x}), where no "
                              "instruction is rendered")
            continue
        if off not in starts:
            fail("constants", f"0x{off:x}: {expr} is not the offset of any "
                              "emitted instruction")
            continue
        bank = off // BANK_SIZE
        pc = off if bank == 0 else 0x4000 + off % BANK_SIZE
        ins = decode(rom, off, pc)
        text = ins.text
        m = (_BITOP_RE.match(text) or _LDIMM_RE.match(text)
             or _IMM8_RE.search(text))
        if not ins.valid or ins.target is not None or not m:
            fail("constants", f"0x{off:x}: {expr} is not on an instruction "
                              f"with a named-immediate operand "
                              f"(decodes as `{text}`)")
            continue
        base = 10 if _BITOP_RE.match(text) else 16
        got = int(m.group(1), base)
        if got != want:
            fail("constants", f"0x{off:x}: {expr} is ${want:02x} but "
                              f"`{text}` holds ${got:02x}")
    return len(constants)


# Routines that follow an actor-script blob with no label of their own, so
# their local labels bind to the *script's* scope. All fourteen that existed
# have been named, so this is empty and the check is now a ratchet: a new entry
# means a curation change stranded something that used to be named.
KNOWN_STRANDED_IN_SCRIPT = set()

_AS_RE = re.compile(r"^\tas_")


def check_stranded_scopes(fail):
    """No global label may cover both actor-script data and CPU instructions.

    An actor script is a blob of `as_*` bytecode; a routine emitted right after
    one, with nothing naming its entry, ends up inside the script's label scope,
    where its `.loop`/`.done` read as part of the script. The mix is the signal:
    the two never belong to one symbol."""
    found = {}
    for path in sorted((ROOT / "src").glob("bank_*.asm")):
        bank = int(path.stem.split("_")[1], 16)
        scope, kinds, entry = None, {}, {}
        for line in path.read_text().split("\n"):
            m = _GLOBAL_RE.match(line)
            if m:
                scope = m.group(1)
                kinds[scope] = set()
                continue
            if scope is None:
                continue
            if _AS_RE.match(line):
                kinds[scope].add("script")
                entry.pop(scope, None)     # code before the script is its header
                continue
            mi = _INSTR_LINE_RE.match(line)
            addr = _ADDR_RE.search(line)
            if mi and mi.group(1) in _MNEMONICS or (addr and "script_" in line):
                kinds[scope].add("code")
                if addr:
                    entry.setdefault(scope, int(addr.group(1), 16))
        for name, kind in kinds.items():
            if kind == {"script", "code"} and name in entry:
                found[(bank, entry[name])] = name
    for bank, at in sorted(set(found) - KNOWN_STRANDED_IN_SCRIPT):
        fail("scopes", f"${bank:02x}:${at:04x} ({found[(bank, at)]}) is code "
                       "inside an actor script's label scope -- name its entry")
    for bank, at in sorted(KNOWN_STRANDED_IN_SCRIPT - set(found)):
        fail("scopes", f"${bank:02x}:${at:04x} is no longer stranded -- drop it "
                       "from KNOWN_STRANDED_IN_SCRIPT")
    return len(found)


def check_regions(manifest, fail):
    spans = sorted((o, o + n, p) for p, o, n, _s in manifest)
    prev = None
    for lo, hi, path in spans:
        if lo // BANK_SIZE != (hi - 1) // BANK_SIZE:
            fail("regions", f"{path} crosses a bank boundary")
        if prev and lo < prev[1]:
            fail("regions", f"{path} overlaps {prev[2]}")
        prev = (lo, hi, path)
    return len(spans)


# Conditional branches whose taken and not-taken paths are the same address.
# Every one is a fossil: a guarded block deleted, or a condition inverted and
# its body removed. Three have consequences and are written up in
# docs/bugs.md; the rest are harmless, and are listed here so the set is
# pinned. A *new* one means a curation change invented a branch that decides
# nothing -- far more likely a mis-carve than a real discovery.
KNOWN_COLLAPSED_BRANCHES = {
    (0x00, 0x1bbf), (0x05, 0x62b0), (0x08, 0x516e), (0x08, 0x6feb),
    (0x0a, 0x42ff), (0x10, 0x6400), (0x12, 0x5844), (0x12, 0x5e35),
    (0x14, 0x42ff), (0x1b, 0x5a08), (0x27, 0x5803), (0x27, 0x5be5),
    (0x38, 0x67ef), (0x6b, 0x4be1),
}

_GLOBAL_RE = re.compile(r"^([A-Za-z_][\w]*):$")
_LOCAL_RE = re.compile(r"^(\.[A-Za-z_][\w.]*):$")
_ADDR_RE = re.compile(r"; \$([0-9a-f]{4})\s*$")
_BRANCH_RE = re.compile(r"^\t(jr|jp) (nz|z|nc|c), ([.A-Za-z_][\w.]*) ; \$([0-9a-f]{4})$")


def check_gfx(manifest, fail):
    """Every gfx-tagged blob with a PNG beside it encodes back to the bytes
    the PNG was decoded from: the image is a faithful, editable copy."""
    sys.path.insert(0, str(ROOT / "tools"))
    try:
        import gfx
        from PIL import Image
    except ImportError:
        return 0
    n = 0
    for path, off, length, spec in manifest:
        if spec != "gfx":
            continue
        binp = ROOT / "data" / path
        png = binp.with_suffix(".png")
        if not png.exists() or not binp.exists():
            continue
        n += 1
        raw = binp.read_bytes()
        want = gfx.lz.decompress(raw, 0)[0] if gfx.is_lz(binp) else raw
        img = Image.open(png)
        got = gfx.image_to_tiles(img, int(img.text.get("tiles", 0)) or None)
        if got != want:
            fail("gfx", f"{path}: PNG does not encode back to the blob "
                        f"({len(got)} vs {len(want)} bytes)")
    return n


def check_collapsed_branches(fail):
    """Find `jr cc, X` / `jp cc, X` where X is the very next instruction.

    Local labels repeat across functions -- `.done` appears 34 times in bank
    $00 -- so a target has to be resolved inside its own scope or the answer is
    whichever `.done` came first in the file."""
    found = set()
    for path in sorted((ROOT / "src").glob("bank_*.asm")):
        bank = int(path.stem.split("_")[1], 16)
        lines = path.read_text().split("\n")
        addr_of, scope = {}, None
        for i, line in enumerate(lines):
            g, lo = _GLOBAL_RE.match(line), _LOCAL_RE.match(line)
            if not (g or lo):
                continue
            name = g.group(1) if g else lo.group(1)
            key = (None, name) if g else (scope, name)
            for nxt in lines[i + 1:i + 4]:
                m = _ADDR_RE.search(nxt)
                if m:
                    addr_of[key] = int(m.group(1), 16)
                    break
            if g:
                scope = name
        scope = None
        for line in lines:
            g = _GLOBAL_RE.match(line)
            if g:
                scope = g.group(1)
                continue
            m = _BRANCH_RE.match(line)
            if not m:
                continue
            target, at = m.group(3), int(m.group(4), 16)
            size = 2 if m.group(1) == "jr" else 3
            key = (scope, target) if target.startswith(".") else (None, target)
            if addr_of.get(key) == at + size:
                found.add((bank, at))
    for bank, at in sorted(found - KNOWN_COLLAPSED_BRANCHES):
        fail("branches", f"new collapsed branch at ${bank:02x}:${at:04x}")
    for bank, at in sorted(KNOWN_COLLAPSED_BRANCHES - found):
        fail("branches", f"${bank:02x}:${at:04x} no longer collapsed -- "
                         "drop it from KNOWN_COLLAPSED_BRANCHES")
    return len(found)


def main():
    global ROOT
    ROOT = Path(__file__).resolve().parent.parent
    rom = (ROOT / "baserom.gbc").read_bytes()
    manifest = load_manifest()
    labels = {int(k, 0): v for k, v in
              json.loads((ROOT / "labels.json").read_text()).items()}
    data_tables = {int(k, 0): v for k, v in
                   json.loads((ROOT / "data_tables.json").read_text()).items()}
    constants = {int(k, 0): v for k, v in
                 json.loads((ROOT / "constants.json").read_text()).items()}
    const_defs = load_defs(ROOT / "include" / "constants.inc")

    failures = []

    def fail(check, msg):
        failures.append((check, msg))

    counts = {
        "lz": check_lz(rom, manifest, fail),
        "lz-labels": check_lz_labels(labels, manifest, fail),
        "text": check_text(rom, data_tables, manifest, fail),
        "constants": check_constants(rom, constants, const_defs, manifest,
                                     fail),
        "regions": check_regions(manifest, fail),
        "scopes": check_stranded_scopes(fail),
        "branches": check_collapsed_branches(fail),
        "gfx": check_gfx(manifest, fail),
    }
    by_check = {}
    for check, msg in failures:
        by_check.setdefault(check, []).append(msg)
    for name, n in counts.items():
        bad = by_check.get(name, [])
        print(f"{name:10s} {n:5d} checked, {len(bad)} failed")
        for msg in bad[:10]:
            print(f"    {msg}")
        if len(bad) > 10:
            print(f"    ... and {len(bad) - 10} more")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())

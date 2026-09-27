#!/usr/bin/env python3
"""Structural checks over the carve, for things `make compare` cannot see.

A byte-perfect build only proves the bytes come back; it says nothing about
whether the *structure* the source claims is true. These are the invariants
that matter when the disassembly is used as a modding base, each one written
after a real defect broke it:

  lz        every declared LZ stream decodes exactly within its extent, and
            re-encodes to a stream that decodes back to the same bytes
  lz-labels no assembled symbol (build/mariotennis.sym) lands inside a
            compressed stream (a name once truncated two streams by 29 and
            160 bytes)
  regions   manifest regions stay inside their bank and do not overlap
  scopes    no global label covers both actor-script bytecode and CPU code
            (a routine emitted after a script with nothing naming its entry)
  branches  no conditional branch targets the instruction that follows it --
            a branch that decides nothing, which is always either a deleted
            guarded block or an inverted condition (14 exist; the list is
            curated so a new one shows up as a failure)
  literals  no ROM address is written as a number where the source moves:
            a jp/call target, a macro argument that elsewhere always takes a
            label, or an ld rr/dw literal equal to a label in the same bank
            (96 as_calls once reached two unlabelled routines by number)

The lz-labels check reads the symbol file the build writes, so run `make`
first (`make check` does). Exit status is non-zero if any check fails.
"""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from banksrc import bank_lines, bank_of, holders
from lz import compress, decompress

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


def load_symbols():
    """ROM symbols from build/mariotennis.sym as {flat offset: name}.

    rgblink writes `BB:AAAA Name`; only ROM banks (an address below $8000)
    matter here. A local label is listed as `Parent.local`."""
    out = {}
    path = ROOT / "build" / "mariotennis.sym"
    if not path.exists():
        sys.exit("build/mariotennis.sym is missing: run `make` first")
    for line in path.read_text().splitlines():
        m = re.match(r"([0-9a-f]{2}):([0-9a-f]{4}) (\S+)", line, re.I)
        if not m:
            continue
        bank, addr = int(m.group(1), 16), int(m.group(2), 16)
        if addr >= 0x8000:
            continue
        off = addr if bank == 0 else bank * BANK_SIZE + addr - 0x4000
        out.setdefault(off, m.group(3))
    return out


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


_MNEMONICS = frozenset(
    "adc add and bit call ccf cp cpl daa dec di ei halt inc jp jr ld ldd ldh "
    "ldi nop or pop push res ret reti rl rla rlc rlca rr rra rrc rrca rst sbc "
    "scf set sla sra srl stop sub swap xor".split())
_INSTR_LINE_RE = re.compile(r"^\t(\w+)[^;]*; \$([0-9a-f]{4})\s*$")


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
    for path in holders():
        bank = bank_of(path)
        scope, kinds, entry = None, {}, {}
        for line in bank_lines(path)[0]:
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


def check_sound(rom, manifest, fail):
    """Every snd_script track decodes to whole commands over exactly its
    extent, with every snd_call target on a command, and renders to rows
    that encode back to the same bytes."""
    import snd
    n = 0
    for path, off, length, spec in manifest:
        if not (spec or "").startswith("snd_script"):
            continue
        n += 1
        data = rom[off:off + length]
        kind = spec.partition(":")[2] or "pulse"
        try:
            snd.decode(data)
        except ValueError as e:
            fail("sound", f"{path}: {e}")
            continue
        back = snd.encode(snd.render(data, Path(path).stem, kind))
        if back != data:
            fail("sound", f"{path}: rendering does not encode back to the track")
    return n


def check_traj(rom, manifest, fail):
    """Every traj table is whole rows of its width and renders to rows that
    parse back to the same bytes."""
    from extract import parse_traj, render_traj
    n = 0
    for path, off, length, spec in manifest:
        if not (spec or "").startswith("traj"):
            continue
        n += 1
        data = rom[off:off + length]
        try:
            text = render_traj(data, spec.partition(":")[2])
        except ValueError as e:
            fail("traj", f"{path}: {e}")
            continue
        if parse_traj(text) != data:
            fail("traj", f"{path}: rendering does not parse back to the table")
    return n


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
        if not (spec == "gfx" or (spec or "").startswith("gfx:")):
            continue
        binp = ROOT / "data" / path
        png = binp.with_suffix(".png")
        if not png.exists() or not binp.exists():
            continue
        n += 1
        raw = binp.read_bytes()
        want = gfx.lz.decompress(raw, 0)[0] if gfx.is_lz(binp) else raw
        layout = spec.partition(":")[2] or None
        if (Image.open(png).text.get("layout") or None) != layout:
            fail("gfx", f"{path}: PNG layout is not the manifest's {layout!r}")
            continue
        got = gfx.image_file_to_tiles(png)
        if got != want:
            fail("gfx", f"{path}: PNG does not encode back to the blob "
                        f"({len(got)} vs {len(want)} bytes)")
    return n


def check_tilemaps(manifest, fail):
    """Every tilemap:W blob with a grid beside it encodes back to the bytes
    the grid was decoded from."""
    sys.path.insert(0, str(ROOT / "tools"))
    import tilemap
    n = 0
    for path, off, length, spec in manifest:
        if not path.endswith(".bin") or not (spec or "").startswith("tilemap:"):
            continue
        binp = ROOT / "data" / path
        grid = binp.with_suffix(".tilemap")
        if not grid.exists() or not binp.exists():
            continue
        n += 1
        raw = binp.read_bytes()
        want = tilemap.lz.decompress(raw, 0)[0] if tilemap.is_lz(binp) else raw
        try:
            got = tilemap.grid_bytes(grid.read_text())
        except ValueError as e:
            fail("tilemap", f"{path}: {e}")
            continue
        if got != want:
            fail("tilemap", f"{path}: grid does not encode back to the blob "
                            f"({len(got)} vs {len(want)} bytes)")
    return n


def check_collapsed_branches(fail):
    """Find `jr cc, X` / `jp cc, X` where X is the very next instruction.

    Local labels repeat across functions -- `.done` appears 34 times in bank
    $00 -- so a target has to be resolved inside its own scope or the answer is
    whichever `.done` came first in the file."""
    found = set()
    for path in holders():
        bank = bank_of(path)
        lines = bank_lines(path)[0]
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


_NUM_RE = re.compile(r"\$[0-9a-fA-F]+|%[01]+|\d+")
_OPERAND_RE = re.compile(r"^\t([a-z_]\w*)\s+([^;]+)")
_NOT_MACROS = frozenset(_MNEMONICS | {"db", "dw", "ds", "lb", "text", "line", "page"})
_ROMX_WORD_RE = re.compile(r"\$[4-7][0-9a-fA-F]{3}")
# The ROM0 routines that take a (bank << 8) | slot pair in hl.
_SLOT_CONSUMERS = frozenset(
    "CopyDataFromBank DecompressDataFromBank FarCallVector FarCallIndexed1 "
    "FarCallIndexed2 FarCallIndexed3 FarCopyIndexed FarDispatchIndexed "
    "FarReadPtrIndexed".split())


def _is_label(arg):
    return arg.startswith(".") or (arg[0].isupper() and any(c.islower() for c in arg))


def check_literal_pointers(fail):
    """A ROM address written as a number stays put when the code around its
    target moves, so every place the source takes an address must name it.

    Three forms: a numeric jp/call/jr target; a number in a macro argument
    position that takes only labels everywhere else (as_call, map_actor's
    script, obj_template's routines, ...); and an `ld rr` or `dw` literal in
    $4000-$7fff equal to a label of the same bank. The `$40xx` slot labels are
    left out of the last: small words collide with them constantly."""
    banks = [(bank_of(h), [m for m in map(_OPERAND_RE.match, bank_lines(h)[0]) if m])
             for h in holders()]
    kinds = {}
    for _bank, lines in banks:
        for m in lines:
            if m.group(1) in _NOT_MACROS:
                continue
            for i, arg in enumerate(a.strip() for a in m.group(2).split(",")):
                k = "num" if _NUM_RE.fullmatch(arg) else "label" if _is_label(arg) else "other"
                kinds.setdefault((m.group(1), i), set()).add(k)
    label_only = {k for k, v in kinds.items() if "label" in v and "other" not in v}
    by_addr = {}
    for line in (ROOT / "build" / "mariotennis.sym").read_text().splitlines():
        m = re.match(r"([0-9a-f]{2}):([0-9a-f]{4}) (\S+)", line, re.I)
        if m and not m.group(3).startswith(("FarPtr_", "DataPtr_")):
            by_addr.setdefault((int(m.group(1), 16), int(m.group(2), 16)), m.group(3))
    n = 0
    for bank, lines in banks:
        pending_hl = None
        split_lo, split_hi = None, None
        for m in lines:
            op, args = m.group(1), [a.strip() for a in m.group(2).split(",")]
            where = f"${bank:02x}: {op} {m.group(2).strip()}"
            if op == "ld" and args[0] == "hl":
                pending_hl = where if _NUM_RE.fullmatch(args[1]) else None
            elif op in ("call", "jp") and args[-1] in _SLOT_CONSUMERS:
                n += 1
                if pending_hl:
                    fail("literals", f"{pending_hl} -- a (bank, slot) pair for "
                                     f"{args[-1]}: use ld_slot")
                pending_hl = None
            elif (op not in _MNEMONICS or op in ("call", "jp", "jr", "rst", "ret")
                  or args[0] in ("h", "l", "hl") or "hl" in args[1:] or "[hl+]" in args):
                pending_hl = None
            if op in ("jp", "call", "jr"):
                n += 1
                if _NUM_RE.fullmatch(args[-1]):
                    fail("literals", f"{where} -- a numeric branch target")
            for i, arg in enumerate(args):
                if (op, i) in label_only:
                    n += 1
                    if _NUM_RE.fullmatch(arg) and arg not in ("0", "$0000", "$ffff"):
                        fail("literals", f"{where} -- argument {i} takes a label everywhere else")
            if op == "add" and re.fullmatch(r"\$[0-9a-fA-F]{2}", args[-1]):
                split_lo = (int(args[-1][1:], 16), 3)
            elif split_lo and op == "ld" and args[0] == "a" and re.fullmatch(r"\$[4-7][0-9a-fA-F]", args[1]):
                split_hi = int(args[1][1:], 16)
            elif split_lo and op == "adc" and re.fullmatch(r"\$[4-7][0-9a-fA-F]", args[-1]):
                n += 1
                name = by_addr.get((bank, int(args[-1][1:], 16) << 8 | split_lo[0]))
                if name:
                    fail("literals", f"{where} -- add/adc spells {name} in halves: use ld_hl_indexed")
            elif split_lo and split_hi is not None and op == "adc" and args[-1] == "$00":
                n += 1
                name = by_addr.get((bank, split_hi << 8 | split_lo[0]))
                if name:
                    fail("literals", f"{where} -- add/adc spells {name} in halves")
            if op != "add":
                split_lo = (split_lo[0], split_lo[1] - 1) if split_lo and split_lo[1] > 1 else None
                if not split_lo:
                    split_hi = None
            if op == "dw" or (op == "ld" and args[0] in ("hl", "de", "bc", "sp")):
                for arg in args if op == "dw" else args[1:]:
                    if bank and _ROMX_WORD_RE.fullmatch(arg):
                        n += 1
                        name = by_addr.get((bank, int(arg[1:], 16)))
                        if name:
                            fail("literals", f"{where} -- {arg} is {name}")
    return n


def main():
    global ROOT
    ROOT = Path(__file__).resolve().parent.parent
    rom = (ROOT / "baserom.gbc").read_bytes()
    manifest = load_manifest()
    labels = load_symbols()

    failures = []

    def fail(check, msg):
        failures.append((check, msg))

    counts = {
        "lz": check_lz(rom, manifest, fail),
        "lz-labels": check_lz_labels(labels, manifest, fail),
        "regions": check_regions(manifest, fail),
        "sound": check_sound(rom, manifest, fail),
        "traj": check_traj(rom, manifest, fail),
        "scopes": check_stranded_scopes(fail),
        "branches": check_collapsed_branches(fail),
        "literals": check_literal_pointers(fail),
        "gfx": check_gfx(manifest, fail),
        "tilemap": check_tilemaps(manifest, fail),
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

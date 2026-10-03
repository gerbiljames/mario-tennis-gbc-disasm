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
  dma       every ROM label handed straight to a VRAM DMA routine is
            preceded by `ds ALIGN[4]`: the DMA ignores a source's low four
            bits, so an edit that unaligns one garbles what it copies
  literals  no ROM address is written as a number where the source moves:
            a jp/call target, a macro argument that elsewhere always takes a
            label, or an ld rr/dw literal equal to a label in the same bank
            (96 as_calls once reached two unlabelled routines by number)
  labels    code lives under the name of the routine it belongs to: a
            data-named label's scope does not run on into code (a routine's
            tail after a table is `Routine.local:`), a dw table does not
            dispatch to another routine's local that starts after a ret/jp
            (a case is a routine of its own), and no unreferenced label sits
            where code falls into it (it would split a routine in two)
  reach     a routine is named Unused exactly when nothing reachable from
            the reset, interrupt and rst vectors reaches it (tools/reach.py)
  slots     every ACTOR_<list>_<object> name a story script uses holds that
            actor in every map_actor list tools/actorslots.py finds can be
            active at that line (a name is a row number, so reordering or
            retargeting a list keeps the bytes and changes the actor)

The lz-labels check reads the symbol file the build writes, so run `make`
first (`make check` does). Exit status is non-zero if any check fails.
"""
import bisect
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from banksrc import bank_lines, bank_of, holders
from lz import compress, decompress
import actorslots
import reach

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


def check_lz(manifest, fail):
    """Every LZ stream the build includes (data/, after the mods/ overlay)
    decodes using exactly its bytes, and survives a re-encode."""
    streams = [p for p, _o, _n, _s in manifest if "/lz_" in p]
    for path in streams:
        blob = (ROOT / "data" / path).read_bytes()
        try:
            data, used = decompress(blob, 0, len(blob))
        except ValueError as e:
            fail("lz", f"{path}: does not decode inside its {len(blob)} bytes ({e})")
            continue
        if used != len(blob):
            fail("lz", f"{path}: decodes {used} bytes, the file has {len(blob)}")
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
    """No symbol lands inside a compressed stream, where the build put it:
    each stream is found by the label on its INCBIN, so the check holds for
    an edited build whose code has moved as well as for the original."""
    at = {}
    for line in (ROOT / "build" / "mariotennis.sym").read_text().splitlines():
        m = re.match(r"([0-9a-f]{2}):([0-9a-f]{4}) (\S+)", line, re.I)
        if m and int(m.group(2), 16) < 0x8000:
            bank, addr = int(m.group(1), 16), int(m.group(2), 16)
            at[m.group(3)] = addr if bank == 0 else bank * BANK_SIZE + addr - 0x4000
    streams = {p for p, _o, _n, _s in manifest if "/lz_" in p}
    spans = []
    for h in holders():
        lines, origin = bank_lines(h)
        for i, line in enumerate(lines):
            m = re.match(r'\tINCBIN "data/([^"]+)"', line)
            if not m or m.group(1) not in streams:
                continue
            label = next((re.match(r"^([A-Za-z_][\w.]*):", x).group(1) for x in reversed(lines[max(0, i - 3):i])
                          if re.match(r"^[A-Za-z_][\w.]*:", x)), None)
            if label not in at:
                fail("lz-labels", f"{m.group(1)}: no label on its INCBIN ({origin[i][0].name}:{origin[i][1]})")
                continue
            size = (ROOT / "data" / m.group(1)).stat().st_size
            spans.append((at[label], at[label] + size, m.group(1)))
    spans.sort()
    offs = sorted(labels)
    for lo, hi, path in spans:
        for off in offs[bisect.bisect_right(offs, lo):bisect.bisect_left(offs, hi)]:
            fail("lz-labels", f"{labels[off]} (0x{off:x}) is {off - lo} "
                              f"bytes inside {path}, which truncates it")
    return len(spans)


_MNEMONICS = frozenset(
    "adc add and bit call ccf cp cpl daa dec di ei halt inc jp jr ld ldd ldh "
    "ldi nop or pop push res ret reti rl rla rlc rlca rr rra rrc rrca rst sbc "
    "scf set sla sra srl stop sub swap xor".split())
_INSTR_LINE_RE = re.compile(r"^\t(\w+)\b")


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
            if mi and (mi.group(1) in _MNEMONICS or mi.group(1).startswith("script_")):
                kinds[scope].add("code")
                entry.setdefault(scope, True)
        for name, kind in kinds.items():
            if kind == {"script", "code"} and name in entry:
                found[(bank, name)] = name
    for bank, name in sorted(set(found) - KNOWN_STRANDED_IN_SCRIPT):
        fail("scopes", f"bank ${bank:02x}: {name} holds code inside an actor "
                       "script's label scope -- name its entry")
    for bank, name in sorted(KNOWN_STRANDED_IN_SCRIPT - set(found)):
        fail("scopes", f"bank ${bank:02x}: {name} is no longer stranded -- drop it "
                       "from KNOWN_STRANDED_IN_SCRIPT")
    return len(found)



_CODE_PREFIXES = ("script_", "farcall", "push_wram_bank", "pop_wram_bank", "wram_bank",
                  "ld_", "rect_", "sprite_", "map_cell", "test_flag", "set_flag",
                  "clear_flag", "sound", "wait_frames", "lb ")
_DATA_PREFIXES = ("db", "dw", "INCBIN", "map_actor", "map_actor_end", "map_entry",
                  "map_script", "map_tree", "as_", "anim_", "tilemap_", "oam_",
                  "palette", "snd_", "drill_", "court_", "story_location")
_UNCOND_RE = re.compile(r"^	(ret|reti|jp hl|jp [A-Za-z_$][\w.$+ ]*|jr [A-Za-z_.][\w.]*)\s*(;.*)?$")
_QUAL_DEF_RE = re.compile(r"^([A-Za-z_]\w*)\.(\w+):")
_LOCAL_DEF_RE = re.compile(r"^\.(\w+):")


def _line_kind(line):
    s = line.split(";")[0].strip()
    if not s or not line.startswith("\t"):
        return None
    w = s.split()[0]
    if w in _MNEMONICS or s.startswith(_CODE_PREFIXES):
        return "code"
    if s.startswith(_DATA_PREFIXES):
        return "data"
    return None


def check_label_scopes(fail):
    """Code sits under the name of the routine it belongs to (see the module
    docstring's `labels`)."""
    texts = {h: bank_lines(h)[0] for h in holders()}
    words = set()
    for lines in texts.values():
        for line in lines:
            if _GLOBAL_RE.match(line):
                continue
            words.update(re.findall(r"\b([A-Za-z_]\w*)\b", line.split(";")[0]))
    for inc in (ROOT / "include").glob("*.inc"):
        words.update(re.findall(r"\b([A-Za-z_]\w*)\b", inc.read_text()))
    n = 0
    for h, lines in texts.items():
        bank = bank_of(h)
        glob_, first, owner_shift, last = None, None, False, ""
        after_term = {}                       # (global, local) -> starts after ret/jp
        dw_refs = []                          # (table global, target global, local)
        for line in lines:
            m = _GLOBAL_RE.match(line)
            if m:
                name = m.group(1)
                if (last and _line_kind(last) == "code" and not _UNCOND_RE.match(last)
                        and name not in words and not name.startswith("Unused")):
                    fail("labels", f"bank ${bank:02x}: {name} is referenced nowhere and code "
                                   "falls into it -- it splits a routine")
                glob_, first, owner_shift, last = name, None, False, ""
                n += 1
                continue
            q = _QUAL_DEF_RE.match(line)
            if q:
                owner_shift, last = True, ""
                continue
            lo = _LOCAL_DEF_RE.match(line)
            if lo and glob_:
                after_term[(glob_, lo.group(1))] = bool(_UNCOND_RE.match(last))
                continue
            k = _line_kind(line)
            if k is None or glob_ is None:
                continue
            if first is None:
                first = k
            elif first == "data" and k == "code" and not owner_shift:
                fail("labels", f"bank ${bank:02x}: {glob_} is data but its scope runs on into "
                               f"code -- define the tail as Routine.local: ({line.strip()[:40]})")
                first = "reported"
            md = re.match(r"^\tdw ([A-Za-z_]\w*)\.(\w+)\b", line)
            if md:
                dw_refs.append((glob_, md.group(1), md.group(2)))
            last = line
        for table, g, l in dw_refs:
            if g != table and after_term.get((g, l)) and not re.search(r"Cases\d$", g):
                fail("labels", f"bank ${bank:02x}: {table} dispatches to {g}.{l}, a case that "
                               "starts after a ret/jp -- give it its own label")
    return n

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


def check_blob_pointers(rom, manifest, fail):
    """A blob that opens with two or more words pointing back into itself is
    a pointer table the assembler cannot move: split it into a `dw` table of
    labels over the pieces it points at."""
    n = 0
    for path, off, length, spec in manifest:
        if off < BANK_SIZE or length > 0x1000 or (spec or "").startswith(("text", "traj", "sound")):
            continue
        n += 1
        start = BANK_SIZE + off % BANK_SIZE
        heads = [rom[off + i] | rom[off + i + 1] << 8 for i in range(0, min(length, 8) - 1, 2)]
        if len(heads) >= 2 and all(start <= w < start + length for w in heads[:2]):
            fail("literals", f"{path}: opens with pointers into itself "
                             f"(${heads[0]:04x}, ${heads[1]:04x})")
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
    """Find `jr cc, X` / `jp cc, X` where X is the very next instruction:
    the branch is followed, past blank and comment lines and other labels,
    by its own target. Read from the source's structure, so an edited build
    is checked the same way; a known branch is identified by its address
    comment, a new one by its line."""
    found = {}
    for path in holders():
        bank = bank_of(path)
        lines, origin = bank_lines(path)
        scope = None
        for i, line in enumerate(lines):
            g = _GLOBAL_RE.match(line)
            if g:
                scope = g.group(1)
                continue
            m = re.match(r"^\t(jr|jp) (nz|z|nc|c), ([.A-Za-z_][\w.]*)", line)
            if not m:
                continue
            target = m.group(3)
            labels, crossed = set(), False
            for nxt in lines[i + 1:]:
                gl, lo = _GLOBAL_RE.match(nxt), _LOCAL_RE.match(nxt)
                if gl:
                    labels.add(gl.group(1))
                    crossed = True
                elif lo and not crossed:
                    labels.add(lo.group(1))
                elif nxt.strip() and not nxt.strip().startswith(";"):
                    break
            if target in labels:
                a = _ADDR_RE.search(line)
                key = (bank, int(a.group(1), 16)) if a else (bank, f"{origin[i][0].name}:{origin[i][1]}")
                found[key] = f"{origin[i][0].name}:{origin[i][1]}"
    for key in sorted(set(found) - KNOWN_COLLAPSED_BRANCHES, key=str):
        fail("branches", f"new collapsed branch at {found[key]}")
    return len(found)



_NUM_RE = re.compile(r"\$[0-9a-fA-F]+|%[01]+|\d+")
_OPERAND_RE = re.compile(r"^\t([a-z_]\w*)\s+([^;]+)")
_NOT_MACROS = frozenset(_MNEMONICS | {"db", "dw", "ds", "lb", "text", "line", "page"})
_ROMX_WORD_RE = re.compile(r"\$[4-7][0-9a-fA-F]{3}")
# The ROM0 routines that take a (bank << 8) | slot pair in hl.
_SLOT_CONSUMERS = frozenset(
    "CopyDataFromBank DecompressDataFromBank FarCallVector Unused_00_FarCallIndexed1 "
    "Unused_00_FarCallIndexed2 Unused_00_FarCallIndexed3 Unused_00_FarCopyIndexed Unused_00_FarDispatchIndexed "
    "Unused_00_FarReadPtrIndexed".split())


def _is_label(arg):
    return arg.startswith(".") or (arg[0].isupper() and any(c.islower() for c in arg))


def check_literal_pointers(fail):
    """A ROM address written as a number stays put when the code around its
    target moves, so every place the source takes an address must name it.

    Three forms: a numeric jp/call/jr target; a number in a macro argument
    position that takes only labels everywhere else (as_call, map_actor's
    script, obj_template's routines, ...); and an `ld rr` or `dw` literal in
    $4000-$7fff equal to a label of the same bank. The `$40xx` slot labels are
    left out of the last: small words collide with them constantly. A number
    stored through `ld hl, sp + n` is a return address built by hand, and an
    ld_*_indexed base that names a routine is a constant (a text id, say)
    that happened to fall on code. A number inside a data table (in ROM0 or
    the same bank) that the next instructions index or dereference is a
    pointer into that table."""
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
    routines, tables = set(), set()
    for h in holders():
        lines = bank_lines(h)[0]
        for i, line in enumerate(lines[:-1]):
            m = re.match(r"^([A-Za-z_]\w*):", line)
            op = re.match(r"^\t([a-z]+)\b", lines[i + 1])
            if m and op and op.group(1) in _MNEMONICS:
                routines.add(m.group(1))
            nxt = next((x for x in lines[i + 1:i + 4] if x.strip() and not x.strip().startswith(";")), "")
            if m and re.match(r"\t(dw|db|INCBIN)\b", nxt):
                tables.add(m.group(1))
    spans = {}
    for (b, a), name in sorted(by_addr.items()):
        if "." not in name and a < 0x8000:
            spans.setdefault(b, []).append((a, name))

    def table_at(bank, value):
        labels = spans.get(bank, [])
        i = bisect.bisect_right(labels, (value, "\uffff")) - 1
        if i >= 0 and labels[i][1] in tables and i + 1 < len(labels) and value < labels[i + 1][0]:
            return labels[i][1]
        return None
    n = 0
    for bank, lines in banks:
        pending_hl = stack_hl = None
        split_lo, split_hi = None, None
        for k, m in enumerate(lines):
            op, args = m.group(1), [a.strip() for a in m.group(2).split(",")]
            where = f"${bank:02x}: {op} {m.group(2).strip()}"
            if op == "ld" and args[0] == "hl" and args[1].startswith("sp"):
                stack_hl = True
            elif stack_hl and op == "ld" and args[0] in ("[hl]", "[hl+]"):
                n += 1
                if _NUM_RE.fullmatch(args[1]):
                    fail("literals", f"{where} -- a number stored into the stack")
            elif op not in ("inc", "dec") or args[0] != "hl":
                stack_hl = None
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
            if op == "ld" and args[0] in ("hl", "de", "bc") and _NUM_RE.fullmatch(args[1]):
                value = int(args[1].lstrip("$"), 16) if args[1].startswith("$") else None
                if value is not None and 0x150 <= value < 0x8000 and value & 0xff:
                    name = table_at(0 if value < 0x4000 else bank, value)
                    after = " ".join(x.group(0) for x in lines[k + 1:k + 4])
                    if name and (("[hl" in after) if args[0] == "hl" else f"add hl, {args[0]}" in after):
                        n += 1
                        fail("literals", f"{where} -- points into {name}")
            if re.fullmatch(r"ld_(hl|de|bc)_indexed", op):
                n += 1
                if re.match(r"\w+", args[0]).group(0) in routines:
                    fail("literals", f"{where} -- indexes into a routine")
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


_DMA_ROUTINES = frozenset({"QueueVRAMCopy", "StartVRAMDMATransfer", "StartVRAMDMAFromHL"})


def check_dma_alignment(fail):
    """A label passed as the source of a VRAM DMA must be declared aligned."""
    aligned, lines_of = set(), []
    for h in holders():
        lines = bank_lines(h)[0]
        lines_of.append((bank_of(h), lines))
        pending = False
        for line in lines:
            if line.strip() == "ds ALIGN[4]":
                pending = True
                continue
            m = _GLOBAL_RE.match(line)
            if m:
                if pending:
                    aligned.add(m.group(1))
                continue
            if line.strip() and not line.lstrip().startswith(";"):
                pending = False
    n = 0
    for bank, lines in lines_of:
        for i, line in enumerate(lines):
            m = re.match(r"\tld hl, ([A-Z]\w*)(?: \+ [^;]+)? ;", line)
            if not m or m.group(1).startswith(("w", "v", "h")):
                continue
            for nxt in lines[i + 1:i + 6]:
                c = re.match(r"\t(?:call|farcall|jp) (\w+)", nxt)
                if c:
                    if c.group(1) in _DMA_ROUTINES:
                        n += 1
                        if m.group(1) not in aligned:
                            fail("dma", f"${bank:02x}: {m.group(1)} is a DMA source "
                                        "without ds ALIGN[4] before it")
                    break
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
        "lz": check_lz(manifest, fail),
        "lz-labels": check_lz_labels(labels, manifest, fail),
        "regions": check_regions(manifest, fail),
        "sound": check_sound(rom, manifest, fail),
        "traj": check_traj(rom, manifest, fail),
        "scopes": check_stranded_scopes(fail),
        "labels": check_label_scopes(fail),
        "branches": check_collapsed_branches(fail),
        "literals": check_literal_pointers(fail) + check_blob_pointers(rom, manifest, fail),
        "dma": check_dma_alignment(fail),
        "gfx": check_gfx(manifest, fail),
        "tilemap": check_tilemaps(manifest, fail),
        "slots": actorslots.check(fail),
        "reach": reach.check(fail),
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

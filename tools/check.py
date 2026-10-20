#!/usr/bin/env python3
"""Structural checks over the carve, for things `make compare` cannot see.

A byte-perfect build only proves the bytes come back; it says nothing about
whether the *structure* the source claims is true. These are the invariants
that matter when the disassembly is used as a modding base, each one written
after a real defect broke it:

  lz        every declared LZ stream decodes exactly within its extent, and
            its decoded data re-encodes to the same stream
  lz-labels no assembled symbol (build/mariotennis.sym) lands inside a
            compressed stream (a name once truncated two streams by 29 and
            160 bytes)
  lz-names  no region outside lz_ is an LZ stream: one decoding over exactly
            its bytes, or on to the end of a later region (stray labels once
            cut two streams into eleven blobs)
  regions   manifest regions stay inside their bank and do not overlap
  text      a region without a spec rendered as .asm is NUL-terminated text
            (49 position tables once rendered as strings)
  db-words  a label holding only db rows has no little-endian word equal to
            a label of its bank: a pointer the assembler cannot move
  addr-words a label holding only raw db bytes does not hold words that are
            all VRAM- or WRAM-shaped ($80-$bf / $c0-$df high bytes, $a0-$bf
            being VRAM bank 1): such a table is addresses, written
            `dw wShadowAttrmap + ...` or `dw vTiles1 + VRAM_BANK1`
  records   a (records:N) region, or a word table (words, text_ids,
            ram_ptrs, save_flag_ids, mode_hooks), is whole records or ends in
            a $ff terminator (three stray `ret`s once sat after word tables)
  layout    data/ mirrors src/: a manifest file sits in the folder of the
            source file that INCBINs or INCLUDEs it
  sound     every snd_script track decodes to a header and whole commands
            over exactly its extent, every snd_call lands on a command, and
            its rows encode back to the same bytes
  traj      every traj table is whole rows of its width and its rows parse
            back to the same bytes
  macros    every target_script, move_curve, frame_place, blit_runs and
            scoreboard_columns region renders through its macros alone
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
            (96 as_calls once reached two unlabelled routines by number),
            and no blob opens with words pointing back into itself (a
            pointer table to split into a dw table of labels)
  labels    code lives under the name of the routine it belongs to: a
            data-named label's scope does not run on into code (a routine's
            tail after a table is `Routine.local:`), a dw table does not
            dispatch to another routine's local that starts after a ret/jp
            (a case is a routine of its own), and no unreferenced label sits
            where code falls into it (it would split a routine in two)
  headers   every non-fill region header (`; $xxxx, N bytes (...)`) sits
            right under a label: a region after a ret or a table's end is
            data under another label's name (seven such once hid there)
  gfx       every gfx blob with a PNG beside it encodes back to the bytes
            the PNG was decoded from
  gfx-specs graphics carry a gfx spec, so they get a PNG: no spec-less
            region named *Gfx*/*Tiles*, and no spec-less LZ stream of whole
            tiles that the source decompresses on to vTiles (192 graphics blobs
            once had no PNG); a gfx-tagged region the source indexes, reads
            element by element or decompresses into a tilemap row fails
  tilemap   every tilemap:W blob with a grid beside it encodes back to the
            bytes the grid was decoded from
  reach     a routine is named Unused exactly when nothing reachable from
            the reset, interrupt and rst vectors reaches it (tools/reach.py)
  unnamed   a data label no other label names is Unused_ (a slot-table
            row, padding and the few the hardware or a raw pointer finds
            are listed in tools/reach.py); routines are reach's
  slots     every ACTOR_<list>_<object> name a story script uses names a
            row of a map_actor list tools/actorslots.py finds can be active
            at that line, and holds that actor in every such list (a name is
            a row number, so reordering or retargeting a list keeps the
            bytes and changes the actor)
  entries   every story entry point with no way in carries a `; debug
            warp only` mark, and only those do (tools/routes.py)
  raw-ids   a raw cp/store operand on a variable whose other values are
            named from a constant family is not a member of that family
            (immediates every jump into a label loads into a reach the
            store or call after it, a routine's `ld a, <imm> / ret` stores
            into the variable its caller saves the result in, a cp after
            `and X_MASK` tests that field, a BASE_ID_ARGS base counts as an
            argument), a byte read through a known text pointer is not
            compared with a raw TX_* code, the macro and table rows RAW_ID_*
            lists name their ids, and a routine passed Text_* in hl/de at
            two or more sites is passed no raw number there, and no `bit n, r` on a joypad byte (loaded
            from hInput* / wCharInputBits, or tested with a PADB_ bit before)
            leaves n raw, nor does a bit/set/res on a FLAG_BYTES byte
            (wCharFlags, wCharBallReachFlags, wExpScreenBusyFlags, ...) or
            a FLAG_FIELDS record field (also via `ld a, FIELD / add l /
            ld l, a`) use anything but its family, and no Text_* id is the X of
            `ld hl, X / add hl, rr / ld e, l / ld d, h` (five scoreboard
            caption cells were), and no map_script / map_actor flag
            condition is a nonzero number (flag_cond FLAG_X / ~FLAG_X)
  fields    a routine that names a CHARREC_* / CREATEDCHAR_* / SLOTSUM_* /
            ACTORF_* / OBJSLOT_* / SCENEOBJ_* / WINDOW_* field adds no raw
            offset under $100 to a record pointer (`ld hl, n / add hl, rr`,
            `ld a, n / add_hl_a`, `ld a, n / add c|e / ld e|c, a`): 25 once reached a record by number beside the
            names (the record in de, bc named), as the created-character
            routines all did; `wActorObjDef + n` is an OBJDEF_* field;
            a wCharPosX operand that copies, clears, is passed or offset
            as the whole $df00 struct is wCharStruct
  templates every label handed to QueueSpriteTemplate in hl, directly or as
            a row of the pointer table hl is indexed into, is a
            sprite_template region (five were raw db rows)
  loops     a local named *loop* is the target of a branch or table row on a
            later line, in its routine or by full name, and some path from it
            (following branches, stopping at ret / jp out / as_halt) reaches
            that branch or a computed jump (18 named shared exits, store and
            speak tails, or another path's entry)
  localnames a .done / .exit / .finish local reaches no branch back to an
            earlier local of its routine (18 were next-item steps or the
            next prompt), and a .check<Var> local whose w<Var> / h<Var> is a
            RAM symbol names it in its first three instructions, before any
            branch (13 were pad tests or other paths), and a .store* local
            writes memory before it falls into another label or leaves by
            ret or jump (18 were register results, shared ret tails, or
            prompt redraws), and a .done / .exit / .finish local entered
            only by a jump runs no dialogue, movement or prompt macro before
            it leaves (22 were alternate branches or placement cases), and
            the z target after RunDialogueYesNoPrompt (0 = yes) is not named
            .declined / .no / .refuse*, nor the nz one .accepted / .yes* (two
            were swapped; one confirms a decline), and a local whose
            straight-line path returns a = 0 has no positive name (busy,
            found, ...), nor one returning 1 a negative name (none, idle,
            no*, ...) (two were swapped; two return a status or a score)
  mirrors   a direct `[wX]` operand on a ram_mirrored.inc symbol whose banks
            are listed does not follow (with no pop_wram_bank between) a
            `wram_bank` selecting a bank that lacks it (four read
            wMenuCursorRow under WRAM_TEXT as a char-data page cell)
  wram-ptrs a `ld bc/de/hl, wX` on a banked WRAMX symbol is not dereferenced
            (`[bc]`, `[de]`, `[hl]`, `[hl+]`, `[hl-]`, before it is rewritten)
            after a `wram_bank` selecting another bank (char-data bars drew
            through bank 6 names as wShadowTilemap cursors), nor passed by
            `call` to a listed tile-plane writer unless it is a bank-3 name
            (results/award text went to wScreenAttrmap names; char-data
            blit/patch cells to wScreenAttrmap and bank 6 names)

The lz-labels check reads the symbol file the build writes, so run `make`
first (`make check` does). Exit status is non-zero if any check fails.
"""
import bisect
import hashlib
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from banksrc import SYM, bank_lines, bank_of, holders, read_sym
from lz import compress, decompress
import actorslots
import reach
import routes

ROOT = BANK = None
BANK_SIZE = 0x4000
USA_SHA1 = "414ba58340a27fc27b127bc01455b32764151ff0"


class Skipped(str):
    """A check's return value when it does not apply to this build: the reason."""


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
    decodes using exactly its bytes, and re-encodes to exactly those bytes."""
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
        if compress(data) != blob:
            fail("lz", f"{path}: re-encoding its decoded data gives a different stream")
    return len(streams)


def load_symbols():
    """ROM symbols from build/mariotennis.sym as {flat offset: name}.

    Only ROM banks (an address below $8000) matter here."""
    out = {}
    if not SYM.exists():
        sys.exit("build/mariotennis.sym is missing: run `make` first")
    for bank, addr, name in read_sym(rom_only=True):
        off = addr if bank == 0 else bank * BANK_SIZE + addr - 0x4000
        out.setdefault(off, name)
    return out


def check_lz_labels(labels, manifest, fail):
    """No symbol lands inside a compressed stream, where the build put it:
    each stream is found by the label on its INCBIN, so the check holds for
    an edited build whose code has moved as well as for the original."""
    at = {}
    for bank, addr, name in read_sym(rom_only=True):
        at[name] = addr if bank == 0 else bank * BANK_SIZE + addr - 0x4000
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
    found, checked = {}, 0
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
        checked += sum("script" in kind for kind in kinds.values())
        for name, kind in kinds.items():
            if kind == {"script", "code"} and name in entry:
                found[(bank, name)] = name
    for bank, name in sorted(set(found) - KNOWN_STRANDED_IN_SCRIPT):
        fail("scopes", f"bank ${bank:02x}: {name} holds code inside an actor "
                       "script's label scope -- name its entry")
    for bank, name in sorted(KNOWN_STRANDED_IN_SCRIPT - set(found)):
        fail("scopes", f"bank ${bank:02x}: {name} is no longer stranded -- drop it "
                       "from KNOWN_STRANDED_IN_SCRIPT")
    return checked



_CODE_PREFIXES = ("script_", "farcall", "push_wram_bank", "pop_wram_bank", "wram_bank",
                  "ld_", "rect_", "sprite_", "map_cell", "test_flag", "set_flag",
                  "clear_flag", "sound", "wait_frames", "lb ", "add_hl_a", "add_de_a", "add_bc_a",
                  "neg_", "abs_", "sub_hl_", "rom_bank", "push_rom_bank", "pop_rom_bank", "sram_bank",
                  "jumptable", "frame_task")
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
    for inc in (ROOT / "include").rglob("*.inc"):
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
    """Every snd_script track decodes to a header and whole commands over
    exactly its extent, with every snd_call target on a command, and renders
    to rows that encode back to the same bytes."""
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


# Record kinds rendered wholly through their macros; a raw `db` row (other
# than a blit_runs list's $ff terminator) means the renderer met bytes outside
# the format and fell back. A blit_runs list must end in its $ff and a target
# script in tgt_end or tgt_jump.
MACRO_KINDS = ("target_script", "move_curve", "frame_place", "blit_runs",
               "scoreboard_columns")


def check_macro_kinds(rom, manifest, fail):
    """Every region of a MACRO_KINDS spec renders without a raw `db` row."""
    from extract import prepare_target_scripts, render_spec
    prepare_target_scripts(rom, manifest)
    n = 0
    for path, off, length, spec in manifest:
        if spec not in MACRO_KINDS:
            continue
        n += 1
        text = render_spec(rom[off:off + length], spec, Path(path).stem, off)
        if spec == "blit_runs":
            if not text.endswith("\n\tdb $ff\n"):
                fail("macros", f"{path}: blit_runs list has no $ff terminator")
            text = text[:-len("\tdb $ff\n")]
        if spec == "target_script":
            last = [l for l in text.splitlines() if l.startswith("\t")][-1]
            if not last.startswith(("\ttgt_end", "\ttgt_jump")):
                fail("macros", f"{path}: target script runs off its end")
        if "\tdb " in text:
            fail("macros", f"{path}: {spec} renders raw db rows")
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


# Byte pairs in db blocks that equal a label of their bank by coincidence:
# (label, byte offset) -> what the bytes really are.
KNOWN_DB_WORDS = {
    ("ArcTanTable", 6): "arctangent steps",
    ("WavePatterns", 30): "wave RAM samples",
    ("TextPageDescriptors_03", 116): "7-byte records, not word-aligned",
    ("ShotRecoilTable_07", 2): "recoil speeds",
    ("TargetShotZoneOverlayTiles", 32): "tile ids",
    ("StarWarpPathY", 146): "Y coordinates",
    ("ContinuePreviousGamePromptString", 6): "tile data",
    ("RankingMarkerFanfareCoordSet1", 8): "screen coordinates",
    ("DoublesRankingMarkerFanfareCoordSet1", 8): "screen coordinates",
    **{(f"CharDataScreenStatBar{n}", 2): "bar tile ids" for n in range(11, 16)},
    ("NameEntryCursorTable", 54): "cursor y, x pairs",
}


def check_db_pointers(manifest, fail):
    """A label whose body is only `db` rows (inline, or a `bytes` region it
    INCLUDEs) holds no little-endian word equal to a label of its own bank:
    that is a pointer the assembler cannot move. Words are read at even
    offsets up to the next symbol. The allow-list holds the original layout's
    coincidences, so a build other than the byte-perfect USA one is skipped."""
    built = ROOT / "mariotennis.gbc"
    rom = built.read_bytes() if built.exists() else b""
    if hashlib.sha1(rom).hexdigest() != USA_SHA1:
        return Skipped("mariotennis.gbc is not the byte-perfect USA build")
    specs = {p: s for p, _o, _n, s in manifest}
    at, by_addr = {}, {}
    for bank, addr, name in read_sym(rom_only=True):
        at[name] = (bank, addr)
        if not name.startswith(("FarPtr_", "DataPtr_")):
            by_addr.setdefault((bank, addr), name)
    starts = {}
    for b, a in by_addr:
        starts.setdefault(b, []).append(a)
    for v in starts.values():
        v.sort()
    found, n = set(), 0
    for h in holders():
        name, body = None, []
        for line in bank_lines(h)[0] + ["End:"]:
            m = _GLOBAL_RE.match(line)
            if not m:
                s = line.split(";")[0].strip()
                if s and not s.endswith(":"):
                    body.append(s)
                continue
            inc = re.fullmatch(r'INCLUDE "data/([^"]+)"', body[0]) if len(body) == 1 else None
            if name in at and body and (all(s.startswith("db ") for s in body) or (
                    inc and (specs.get(inc.group(1)) or "").startswith("bytes"))):
                n += 1
                b, a = at[name]
                nxt = starts[b][bisect.bisect_right(starts[b], a):] or [0x8000 if b else 0x4000]
                off = a if b == 0 else b * BANK_SIZE + a - 0x4000
                lo, hi = (0x4000, 0x8000) if b else (0x150, 0x4000)
                for k in range(0, nxt[0] - a - 1, 2):
                    w = rom[off + k] | rom[off + k + 1] << 8
                    if lo <= w < hi and (b, w) in by_addr:
                        found.add((name, k))
                        if (name, k) not in KNOWN_DB_WORDS:
                            fail("db-words", f"${b:02x}: {name}+{k} is ${w:04x}, "
                                             f"{by_addr[(b, w)]} -- a hidden pointer?")
            name, body = m.group(1), []
    for name, k in sorted(set(KNOWN_DB_WORDS) - found):
        fail("db-words", f"{name}+{k} no longer matches a label -- drop it from KNOWN_DB_WORDS")
    return n


# db tables whose words look like RAM/VRAM addresses but are not, with what
# they are.
KNOWN_ADDR_SHAPED = {
    "TennisDictionaryIndexCursorNormalTiles": "2x2 tile-id cells, $84 the blank tile",
    "MinigameHighScoreNumberTable": "sprite y, x pairs",
}
_DB_HEX_RE = re.compile(r"\$([0-9a-fA-F]{2})")


def _db_bytes(body, specs, rom, offsets):
    """The bytes of a label body that is only `db $xx` rows or one INCLUDE
    of a bytes-spec region; None for anything else."""
    inc = re.fullmatch(r'INCLUDE "data/([^"]+)"', body[0]) if len(body) == 1 else None
    if inc:
        path = inc.group(1)
        if not (specs.get(path) or "").startswith("bytes") or path not in offsets:
            return None
        off, length = offsets[path]
        return rom[off:off + length]
    out = []
    for s in body:
        if not s.startswith("db "):
            return None
        for tok in s[3:].split(","):
            m = _DB_HEX_RE.fullmatch(tok.strip())
            if not m:
                return None
            out.append(int(m.group(1), 16))
    return bytes(out)


def check_addr_shaped(rom, manifest, fail):
    """A table of raw bytes (inline `db` rows or a `bytes` region) whose
    words all look like VRAM ($80-$9f high byte, or $a0-$bf for a VRAM
    bank 1 destination) or WRAM ($c0-$df) addresses is a word table written
    as bytes: it wants `dw` rows of the RAM/VRAM symbols it addresses. $0000
    words (unused slots) are skipped."""
    specs = {p: s for p, _o, _n, s in manifest}
    offsets = {p: (o, n) for p, o, n, _s in manifest}
    found, n = set(), 0
    for h in holders():
        name, body = None, []
        for line in bank_lines(h)[0] + ["End:"]:
            m = _GLOBAL_RE.match(line)
            if not m:
                s = line.split(";")[0].strip()
                if s and not s.endswith(":"):
                    body.append(s)
                continue
            data = _db_bytes(body, specs, rom, offsets) if name and body else None
            if data and len(data) % 2 == 0:
                n += 1
                words = [w for w in (data[k] | data[k + 1] << 8 for k in range(0, len(data), 2)) if w]
                his = {w >> 8 for w in words}
                if len(words) >= 2 and (his <= set(range(0x80, 0xc0)) or his <= set(range(0xc0, 0xe0))):
                    found.add(name)
                    if name not in KNOWN_ADDR_SHAPED:
                        fail("addr-words", f"{name}: words " + " ".join(f"${w:04x}" for w in words[:6])
                             + " -- addresses written as bytes? (dw <symbol> + ...)")
            name, body = m.group(1), []
    for name in sorted(set(KNOWN_ADDR_SHAPED) - found):
        fail("addr-words", f"{name} is no longer address-shaped -- drop it from KNOWN_ADDR_SHAPED")
    return n


# (records:N) regions whose size is not whole records, with what the tail is.
# A tail of $ff bytes is a terminator and needs no entry.
KNOWN_RECORD_TAILS = {
    "VramTileset_09": "two $00 bytes of padding before the ALIGN[4] tile blob",
}
_RECORDS_HEADER_RE = re.compile(r"^\t(?:\w+ \".*\" )?; \$([0-9a-f]{4}), (\d+) bytes "
                                r"\((?:records:(\d+)|(?:words|text_ids|ram_ptrs|save_flag_ids|mode_hooks)\b)[^)]*\)$")


def check_record_tails(rom, fail):
    """A `(records:N)` region, or a region of a word-table kind, is whole
    records (N bytes, or 2), or ends in a $ff terminator: any other tail is a
    byte that belongs to what follows (three stray `ret`s once sat at the
    ends of word tables)."""
    found, n = set(), 0
    for h in holders():
        bank = bank_of(h)
        lines, origin = bank_lines(h)
        for i, line in enumerate(lines[1:], 1):
            m = _RECORDS_HEADER_RE.match(line)
            if not m:
                continue
            n += 1
            name = _GLOBAL_RE.match(lines[i - 1])
            name = name.group(1) if name else f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}"
            addr, size, width = int(m.group(1), 16), int(m.group(2)), int(m.group(3) or 2)
            tail = size % width
            if not tail:
                continue
            off = addr if bank == 0 else bank * BANK_SIZE + addr - BANK_SIZE
            if all(b == 0xff for b in rom[off + size - tail:off + size]):
                continue
            found.add(name)
            if name not in KNOWN_RECORD_TAILS:
                fail("records", f"{name}: {size} bytes is not whole {width}-byte records and "
                                f"does not end in $ff -- a stray byte to carve off?")
    for name in sorted(set(KNOWN_RECORD_TAILS) - found):
        fail("records", f"{name} is whole records now -- drop it from KNOWN_RECORD_TAILS")
    return n


def check_text_regions(rom, manifest, fail):
    """A spec-less .asm region is rendered as game text, so it must be text:
    printable characters and text codes in NUL-terminated strings of two or
    more bytes. Anything else wants a spec. A region declared `text` (a
    one-character string, an unterminated signature, NUL padding) need only
    hold text bytes and NULs."""
    from extract import SAFE, TEXT_CODES
    ok = SAFE | set(TEXT_CODES) | {0x01, 0x02, 0x03}
    n = 0
    for path, off, length, spec in manifest:
        if spec not in (None, "text") or not path.endswith(".asm"):
            continue
        n += 1
        data = rom[off:off + length]
        if spec == "text":
            if any(b not in ok for b in data if b):
                fail("text", f"{path}: declared text but holds non-text bytes")
            continue
        strings = data[:-1].split(b"\0")
        if (not data.endswith(b"\0") or any(len(s) < 2 for s in strings)
                or any(b not in ok for b in data[:-1] if b)):
            fail("text", f"{path}: not NUL-terminated text -- give it a render spec")
    return n


def check_unmarked_lz(rom, manifest, fail):
    """A region not named lz_ is not an LZ stream: one that decodes using
    exactly its bytes, or that runs on to end exactly where a later region
    does (a stream split by stray labels), is a stream under the wrong name."""
    rows = sorted((o, n, p) for p, o, n, _s in manifest)
    ends = {o + n for o, n, _p in rows}
    specs = {p: s for p, _o, _n, s in manifest}
    n = 0
    for off, length, path in rows:
        if "/lz_" in path or (specs[path] or "").startswith(("text", "sound", "snd")):
            continue
        n += 1
        try:
            data, used = decompress(rom, off, (off // BANK_SIZE + 1) * BANK_SIZE)
        except ValueError:
            continue
        if data and (used == length or (used > length and off + used in ends and len(data) >= 16)):
            fail("lz-names", f"{path}: an LZ stream of {used} bytes "
                             f"({len(data)} decoded) -- name it lz_")
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


def check_layout(manifest, fail):
    """data/ mirrors src/: each manifest file sits in the folder of the one
    source file that INCBINs or INCLUDEs it (src/data/X/ files in data/X/)."""
    owners = {}
    for f in [ROOT / "main.asm"] + sorted((ROOT / "src").rglob("*.asm")):
        for m in re.finditer(r'(?:INCBIN|INCLUDE)\s+"data/([^"]+)"', f.read_text()):
            owners.setdefault(m.group(1), set()).add(f.relative_to(ROOT))
    for path, off, length, spec in manifest:
        found = sorted(owners.get(path, ()))
        if len(found) != 1:
            fail("layout", f"{path}: referenced from {len(found)} source files, not one")
            continue
        parts = found[0].parent.parts[1:]
        want = "/".join(parts[1:] if parts[:1] == ("data",) else parts)
        if str(Path(path).parent) != want:
            fail("layout", f"{path}: belongs in data/{want}/ beside {found[0]}")
    return len(manifest)


def check_gfx(manifest, fail):
    """Every gfx-tagged blob with a PNG beside it encodes back to the bytes
    the PNG was decoded from: the image is a faithful, editable copy."""
    sys.path.insert(0, str(ROOT / "tools"))
    try:
        import gfx
        from PIL import Image
    except ImportError as e:
        fail("gfx", f"cannot check the PNGs: {e} (run with the venv's python, `make venv`)")
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
        stored = Image.open(png).text.get("layout")
        if stored is not None and (stored or None) != layout:
            fail("gfx", f"{path}: PNG layout is not the manifest's {layout!r}")
            continue
        got = gfx.image_file_to_tiles(png, len(want) // 16, layout)
        if got != want:
            fail("gfx", f"{path}: PNG does not encode back to the blob "
                        f"({len(got)} vs {len(want)} bytes)")
    if not n and any(spec == "gfx" or (spec or "").startswith("gfx:")
                     for _p, _o, _l, spec in manifest):
        fail("gfx", "no graphics PNGs in data/ (extract with Pillow: ./setup.sh)")
    return n


# Spec-less regions named like graphics that are not tiles, with the reason.
# Empty while every Gfx/Tiles name is tagged; an entry that stops matching
# fails, so the list cannot go stale.
UNTAGGED_GFX_NAMES = {}

_VRAM_DEST_RE = re.compile(r"^\tld de, vTiles")
_LOAD_HL_RE = re.compile(r"^\tld hl, (\w+)")


def check_gfx_specs(rom, manifest, fail):
    """Graphics get a gfx spec, so they get a PNG: a spec-less region named
    *Gfx* or *Tiles* fails, and so does a spec-less LZ stream decoding to
    whole tiles that the source loads with `ld hl, Stream` and then, before
    the next ROM pointer or `ret`, sends to `ld de, vTiles*`."""
    untagged = {}
    for path, off, length, spec in manifest:
        if spec:
            continue
        stem = Path(path).stem
        untagged[stem.removeprefix("lz_")] = (path, off, length)
    seen = set()
    for label, (path, off, length) in untagged.items():
        if "Gfx" not in label and "Tiles" not in label:
            continue
        if label in UNTAGGED_GFX_NAMES:
            seen.add(label)
            continue
        fail("gfx-specs", f"{path}: named as graphics but has no gfx spec")
    for label in sorted(set(UNTAGGED_GFX_NAMES) - seen):
        fail("gfx-specs", f"{label}: no longer a spec-less graphics name -- "
                          "drop it from UNTAGGED_GFX_NAMES")
    streams = {}
    for label, (path, off, length) in untagged.items():
        if "/lz_" not in path:
            continue
        try:
            data, _used = decompress(rom, off, off + length)
        except ValueError:
            continue
        if data and len(data) % 16 == 0:
            streams[label] = path
    for f in sorted((ROOT / "src").rglob("*.asm")):
        lines = f.read_text().splitlines()
        for i, line in enumerate(lines):
            m = _LOAD_HL_RE.match(line)
            if not m or m.group(1) not in streams:
                continue
            for nxt in lines[i + 1:i + 12]:
                m2 = _LOAD_HL_RE.match(nxt)
                if nxt.startswith("\tret") or (m2 and not m2.group(1).startswith("w")):
                    break
                if _VRAM_DEST_RE.match(nxt):
                    fail("gfx-specs", f"{streams[m.group(1)]}: decompressed to "
                                      f"VRAM tiles ({f.relative_to(ROOT)}) but has no gfx spec")
                    break
    check_gfx_tables(manifest, fail)
    return len(untagged)


# gfx-tagged regions the source reads as a table, with the reason.
TABLE_READ_GFX = {}

_TABLE_READ_RE = re.compile(r"^\t(add_hl_a\b|add hl, |ld \w, \[hl\+?\]|"
                            r"ld de, wDecompBuffer \+ .*TILEMAP_WIDTH)")
_SCAN_END_RE = re.compile(r"^\t(call|ret|jp|jr|rst)\b|^\tld hl, |^\S")


def check_gfx_tables(manifest, fail):
    """A gfx spec is for tiles: a gfx-tagged region the source loads with
    `ld hl, Label` and then indexes or reads element by element (add_hl_a,
    add hl, ld r,[hl]/[hl+]) before the next call, jump or `ld hl` is a
    table, and one decompressed to wDecompBuffer + n * TILEMAP_WIDTH is a
    tilemap."""
    gfx = {}
    for path, off, length, spec in manifest:
        if spec == "gfx" or (spec or "").startswith("gfx:"):
            gfx[Path(path).stem.removeprefix("lz_")] = path
    seen = set()
    for f in sorted((ROOT / "src").rglob("*.asm")):
        lines = f.read_text().splitlines()
        for i, line in enumerate(lines):
            m = _LOAD_HL_RE.match(line)
            if not m or m.group(1) not in gfx:
                continue
            label = m.group(1)
            for nxt in lines[i + 1:i + 8]:
                if _SCAN_END_RE.match(nxt):
                    break
                if _TABLE_READ_RE.match(nxt):
                    if label in TABLE_READ_GFX:
                        seen.add(label)
                    else:
                        fail("gfx-specs", f"{gfx[label]}: tagged gfx but read as "
                                          f"a table or tilemap ({f.relative_to(ROOT)}:{i + 1})")
                    break
    for label in sorted(set(TABLE_READ_GFX) - seen):
        fail("gfx-specs", f"{label}: no longer read as a table -- "
                          "drop it from TABLE_READ_GFX")


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


# Region headers that need no label of their own.
UNLABELLED_REGIONS = {
    "$0134": "the cart header: the hardware reads it at its fixed address",
}
_REGION_HDR_RE = re.compile(r"\s*; (\$[0-9a-f]{4}), \d+ bytes? \((?!fill\))")
_LABEL_LINE_RE = re.compile(r"[A-Za-z_.][\w.]*::?\s*(;.*)?$")


def check_region_headers(fail):
    """Every non-fill region header directly follows a label line."""
    n = 0
    for holder in holders():
        lines, origin = bank_lines(holder)
        for i, line in enumerate(lines):
            if not (m := _REGION_HDR_RE.match(line)):
                continue
            n += 1
            if i and _LABEL_LINE_RE.match(lines[i - 1]):
                continue
            if m.group(1) in UNLABELLED_REGIONS:
                continue
            where = f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}"
            fail("headers", f"{where}: {m.group(1)} has no label of its own -- "
                            f"name it (Unused_<bank>_*), or mark it (fill)")
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
        for i, line in enumerate(lines):
            if _GLOBAL_RE.match(line):
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
    for bank, addr in sorted(KNOWN_COLLAPSED_BRANCHES - set(found), key=str):
        fail("branches", f"${bank:02x}:${addr:04x} no longer branches to the next "
                         "instruction -- drop it from KNOWN_COLLAPSED_BRANCHES")
    return len(found)



_NUM_RE = re.compile(r"\$[0-9a-fA-F]+|%[01]+|\d+")
_OPERAND_RE = re.compile(r"^\t([a-z_]\w*)\s+([^;]+)")
_NOT_MACROS = frozenset(_MNEMONICS | {"db", "dw", "ds", "lb", "text", "line", "page"})
_ROMX_WORD_RE = re.compile(r"\$[4-7][0-9a-fA-F]{3}")
# The ROM0 routines that take a (bank << 8) | slot pair in hl.
_SLOT_CONSUMERS = frozenset(
    "CopyDataFromBank DecompressDataFromBank FarCallVector Unused_00_FarCallIndexed1 "
    "Unused_00_FarCallIndexed2 Unused_00_FarCallIndexed3 Unused_00_FarCopyIndexed Unused_00_FarDecompressIndexed "
    "Unused_00_FarReadPtrIndexed".split())


def _drop_unresolved(names, list_name, check, fail):
    syms = {name for _bank, _addr, name in read_sym()}
    for name in sorted(set(names) - syms):
        fail(check, f"{name}: no longer a symbol -- drop it from {list_name}")


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
    pointer into that table. An add/adc pair spelling a ROM label of the
    bank, or a WRAM label of any bank, in halves wants ld_*_indexed."""
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
    _drop_unresolved(_SLOT_CONSUMERS, "_SLOT_CONSUMERS", "literals", fail)
    by_addr, ram_by_addr = {}, {}
    for bank, addr, name in read_sym():
        if not name.startswith(("FarPtr_", "DataPtr_")):
            by_addr.setdefault((bank, addr), name)
        if 0xc000 <= addr < 0xe000:
            ram_by_addr.setdefault(addr, name)
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
            elif split_lo and op == "adc" and re.fullmatch(r"\$[4-7c-dC-D][0-9a-fA-F]", args[-1]):
                n += 1
                addr = int(args[-1][1:], 16) << 8 | split_lo[0]
                name = by_addr.get((bank, addr)) if addr < 0x8000 else ram_by_addr.get(addr)
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
    _drop_unresolved(_DMA_ROUTINES, "_DMA_ROUTINES", "dma", fail)
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
            m = re.match(r"\tld hl, ([A-Z]\w*)(?: \+ [^;]+)?(?: ;|$)", line)
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


# Variables whose ids name a different family per story location, so a raw
# value matching some family member there proves nothing.
_PER_LOCATION_VARS = {"wMapSceneStage", "wMapSceneStage2"}
# (variable, raw operand): raw values that equal a member of a family the
# variable also uses, but mean something else.
KNOWN_RAW_IDS = {
    ("wMinigameLevel", "$02"),     # Tennis Machine / Wall level 3: an index, not the Mario high-score level
    ("QueueSprite(b)", "0"),       # no attribute bits; OAM_PAL0 is the DMG palette bit, unused on CGB
}
# Data rows whose values are ids: a macro's argument by position (a macro
# keyed "<macro> <first arg>" counts only with that first argument), and tables
# by label or by the kind their header comment names.
RAW_ID_MACRO_ARGS = {
    ("story_location", 0): "STORYLOC_",
    ("script_set_active", 1): "ACTORMODE_",
    ("as_set_field ACTORF_MODE", 1): "ACTORMODE_",
    **{("court_positions", k): "COURTPOS_" for k in range(4)},
    **{("court_positions", k): "SERVEROLE_" for k in range(4, 8)},
}
RAW_ID_TABLE_KINDS = {"save_flag_ids": "SAVEFLAG_", "flag numbers": "FLAG_"}
RAW_ID_TABLES = {
    "MinigameSelectMenuTable": "MINIGAME_",
    "MinigameDrillIdTable": "MINIGAME_",
    "StorySlotBlockIds_03": "SAVEBLOCK_",
    "MinigameRulesTextIdBases": "Text_",
    "MinigameRulesTextIdBases_17": "Text_",
    "MainMenuCaptionTextIds": "Text_",
    "MinigameRecordSlotIds": "MGRECORD_",
}
# Families of variables and arguments with too few named sites to infer them.
# `and X_MASK` counts as a variable, so the cp after it names the field's values.
RAW_ID_FAMILIES = {
    "wStoryLocationBGM": "BGM",
    "TennisDictionaryScreen(a)": "TENNISDICT",
    "ShowRankingBoard(d)": "RANKINGBOARD",
    "LINKTAG_MASK": "LINKTAG",
    "wDrillPointJudgement": "WINLOSE",
    "ReadMinigameRecord(a)": "MGRECORD",
    "UpdateMinigameRecord(a)": "MGRECORD",
    "GetDefaultMinigameRecordValue(a)": "MGRECORD",
    "CheckUnlockCondition(a)": "MGRECORD",
    "RestoreMenuBgAndDrawPanel(b)": "PANELANIM",
    "FlushWram3MapRows(b)": "MAPROWS",
    "InitMatchRecordFromCharId(c)": "MATCHREC",
    "SetPendingExpAward(b)": "EXPAWARD",
}
# Routines whose argument is a base id plus an offset: `ld a, <base> / add c`
# or `add <base>` into that register counts as passing the base.
BASE_ID_ARGS = {
    "ReadSaveBlock": "b",
    "WriteSaveBlock": "b",
    "VerifySaveBlock": "b",
    "ClearSaveBlock": "b",
    "RestoreStoryBlockFromBackup": "b",
}
# Text pointers: a byte read through one is a text byte, so its compares name
# TX_* codes. Buffers by address loaded into hl; labels (Routine or
# Routine.local) by the register that holds the pointer there, or "a" where
# a jump target receives the byte itself.
TEXT_BUFFERS = {"wTextBuffer", "wShortTextBuffer", "wInlineTextBuffer", "wNameEntryBuffer", "wStoryMainName"}
TEXT_POINTER_LABELS = {
    "TextInterpreterLoop": "hl",
    "TextInterpreterLoop.readChar": "hl",
    "FitWindowToText.charLoop": "hl",
    "MeasureTextDimensions.loop": "hl",
    "RenderInlineString.charLoop": "hl",
    "WriteStringToWindow": "hl",
    "TextCodeLiteral_05.storeChar": "hl",
    "ProportionalTextCodeHandler5_05.glyph": "hl",
    "Unused_05_WriteStringToTilemapStreamed.storeChar": "hl",
    "Unused_05_WriteDialogueToTilemapStreamed.storeChar": "hl",
    "Unused_05_WriteStringToTilemap": "hl",
    "Unused_05_WriteStringToTilemapAlt": "hl",
    "Unused_05_WriteStringToTilemapStreamed": "hl",
    "Unused_05_WriteDialogueToTilemapStreamed": "hl",
    "WriteNameStringTiles": "hl",
    "RenderInlineString.checkMark": "hl",
    "WriteExpScreenStringTiles": "hl",
    "Unused_00_CopyTextString": "hl",
    "Unused_16_DrawCourtDiagramMarkers": "hl",
    "Unused_1a_CopyNameToTileBuffer": "hl",
    "Unused_1a_DrawStringToTileBuffer": "hl",
    "TextInterpreterLoop.compare": "a",
    "FitWindowToText.checkArgShortText": "a",
    "FitWindowToText.checkArgNumber": "a",
    "FitWindowToText.checkMainCharName": "a",
    "FitWindowToText.checkArgString": "a",
    "FitWindowToText.checkPartnerName": "a",
    "FitWindowToText.checkIndexedShortText": "a",
    "MeasureTextDimensions.notLineBreak": "a",
    "MeasureTextDimensions.notShortTextArg": "a",
}
_NUMBER_RE = re.compile(r"(\$[0-9a-fA-F]+|%[01]+|\d+)")
_TEXT_INDEX_RE = re.compile(r"Text_[0-9a-f]{2}_\d+$")
_VAR_RE = r"([wh][A-Z]\w*(?: \+ (?:\$[0-9a-fA-F]+|\d+|[A-Z][A-Z0-9_]*))?)"
_REGS8 = frozenset("abcdehl")
_PAIRS = {"bc": "bc", "de": "de", "hl": "hl", "af": "a"}
# Instructions that leave every register as it was.
_KEEPS_ALL_RE = re.compile(r"(cp |test_flag |set_flag |clear_flag |bit |push |nop$|ei$|di$|"
                           r"scf$|ccf$|halt$|and a$|or a$|"
                           r"(jr|jp) (n?z|n?c),|ret (n?z|n?c)$|ldh? \[[^\]]+\], [a-l]$|ld \[(bc|de)\], a$)")


def _number(op):
    return int(op[1:], 16) if op.startswith("$") else int(op[1:], 2) if op.startswith("%") else int(op)


def _clobber(regs, spent, r):
    for k in [k for k in regs if r in k or k in _PAIRS.get(r, r)]:
        del regs[k]
        spent.discard(k)


def _imms(v):
    """The immediates a register value stands for: several when it was
    carried to a label by jumps loading different ones ("|v1|v2")."""
    return v[1:].split("|") if v.startswith("|") else [v]


def _is_imm(v):
    return bool(v) and v[0] not in "=@+" and v not in _REGS8


def _var(operand):
    """wVar + n is wVar; wVar + FIELD is a variable of its own."""
    name, _, off = operand.partition(" + ")
    return operand if off[:1].isalpha() else name


def _twin_base(name):
    """A live twin's base name (tools/twins.py names them base + _<bank>)."""
    return re.sub(r"_[0-9a-f]{2}$", "", name)


def _local_label_refs(lines):
    """{Owner.local: number of instruction lines naming it}."""
    refs, owner = {}, ""
    for line in lines:
        if _GLOBAL_RE.match(line) or re.match(r"[A-Za-z_]", line):
            owner = re.match(r"\w+", line).group(0)
            continue
        t = line.split(";")[0].strip()
        if t.startswith("."):
            continue
        for m in re.finditer(r"(?<![\w.])(\w*)(\.\w+)", t):
            label = (m.group(1) or owner) + m.group(2)
            refs[label] = refs.get(label, 0) + 1
    return refs


def _raw_id_uses():
    """{variable or Routine(reg): [(operand, where)]} over every bank's code:
    a `cp` on a loaded variable, a store into one, and the immediates loaded
    into a routine's argument registers before a call or farcall."""
    uses = {}
    for holder in holders():
        lines, origin = bank_lines(holder)
        regs = {}      # register -> immediate, "=wVar" when it holds that variable, "@src" a text pointer
        spent = set()  # registers whose immediate was stored, so not an argument
        owner = ""
        refs = _local_label_refs(lines)
        jumps = {}     # local label -> a's "=wVar" state (or None) at each jump to it seen so far
        after_jump = False
        for i, line in enumerate(lines):
            if _GLOBAL_RE.match(line) or re.match(r"[A-Za-z_]", line):
                regs, spent = {}, set()
                owner = re.match(r"\w+", line).group(0)
                after_jump = False
                if r := TEXT_POINTER_LABELS.get(owner):
                    regs[r] = ("=text@" if r == "a" else "@") + owner
                continue
            t = line.split(";")[0].strip()
            if t.startswith("."):
                label = owner + t.rstrip(":")
                js = jumps.get(label, [])
                into = js + ([] if after_jump else [regs.get("a")])
                if (after_jump and js and js[0] and js[0][0] == "="
                        and js.count(js[0]) == len(js) == refs.get(label)):
                    # reached only by jumps that all agree on a
                    regs, spent = {"a": js[0]}, set()
                elif js and len(js) == refs.get(label) and all(_is_imm(v) for v in into):
                    # every way in loads an immediate into a
                    imms = list(dict.fromkeys(x for v in into for x in _imms(v)))
                    regs, spent = {"a": imms[0] if len(imms) == 1 else "|" + "|".join(imms)}, set()
                else:
                    # keep what a was loaded from and text pointers, drop immediates
                    regs = {r: v for r, v in regs.items() if v[0] in "=@"}
                after_jump = False
                if r := TEXT_POINTER_LABELS.get(label):
                    regs[r] = ("=text@" if r == "a" else "@") + label
                continue
            if not t:
                continue
            where = f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}"
            after_jump = bool(_NO_FALLTHROUGH_RE.match(t))
            if m := re.match(r"(?:jr|jp) (?:(?:n?z|n?c), )?(\.\w+)$", t):
                a = regs.get("a", "")
                jumps.setdefault(owner + m.group(1), []).append(a if a.startswith("=") or _is_imm(a) else None)
            if m := re.match(r"ld a, \[(hl[+-]?|de)\]$", t):
                ptr = regs.get(m.group(1)[:2], "")
                _clobber(regs, spent, "a")
                if ptr.startswith("@"):
                    regs["a"] = "=text@" + ptr[1:]
                    continue
            if m := re.match(r"(inc|dec) (hl|de)$", t):
                if regs.get(m.group(2), "").startswith("@"):
                    continue
            if "[hl]" in t:
                spent.add("hl")
            if re.search(r"\[hl[+-]\]", t):
                _clobber(regs, spent, "hl")
                if t.startswith("ld a,"):
                    _clobber(regs, spent, "a")
                continue
            if m := re.match(r"cp (.+)$", t):
                if regs.get("a", "").startswith("="):
                    uses.setdefault(regs["a"][1:], []).append((m.group(1), where))
                continue
            if m := re.match(rf"ldh? \[{_VAR_RE}\], a$", t):
                if regs.get("a", "=")[0] == "+":
                    del regs["a"]
                if "a" in regs and not regs["a"].startswith("="):
                    uses.setdefault(_var(m.group(1)), []).extend((v, where) for v in _imms(regs["a"]))
                    spent.add("a")
                elif "a" not in regs:
                    regs["a"] = "=" + _var(m.group(1))
                continue
            if m := re.match(r"ld \[hl\], (.+)$", t):
                if regs.get("hl", "").startswith("="):
                    v = regs.get("a") if m.group(1) == "a" else m.group(1)
                    if v and v[0] not in "=+" and v not in _REGS8:
                        uses.setdefault(regs["hl"][1:], []).extend((x, where) for x in _imms(v))
                        if m.group(1) == "a":
                            spent.add("a")
                continue
            if _KEEPS_ALL_RE.match(t):
                continue
            if m := re.match(r"and (\w+_MASK)$", t):
                _clobber(regs, spent, "a")
                regs["a"] = "=" + m.group(1)
                continue
            if m := re.match(r"add ([^\[\],]+)$", t):
                v = regs.get("a", "") if m.group(1) in _REGS8 else m.group(1)
                _clobber(regs, spent, "a")
                if _is_imm(v) and v[0] != "|":
                    regs["a"] = "+" + v
                continue
            if t == "add_hl_a" or re.match(r"add hl, (bc|de)$", t):
                if t == "add_hl_a":
                    _clobber(regs, spent, "a")
                continue
            if m := re.match(r"(call|farcall) (\w+)$", t):
                callee = _twin_base(m.group(2))
                for r, v in regs.items():
                    if v[0] == "+" and BASE_ID_ARGS.get(callee) == r and r not in spent:
                        uses.setdefault(f"{callee}({r})", []).append((v[1:], where))
                    elif v[0] not in "=@+" and r not in spent:
                        uses.setdefault(f"{callee}({r})", []).extend((x, where) for x in _imms(v))
                # the text engine's callees keep the text pointer
                regs, spent = {r: v for r, v in regs.items() if v[0] == "@"}, set()
                continue
            if re.match(r"(push_|pop_)?wram_bank\b", t):
                regs = {r: v for r, v in regs.items() if v[0] == "@"}
                continue
            if m := re.match(rf"ldh? a, \[{_VAR_RE}\]$", t):
                _clobber(regs, spent, "a")
                regs["a"] = "=" + _var(m.group(1))
                continue
            if m := re.match(rf"ld hl, {_VAR_RE}$", t):
                _clobber(regs, spent, "hl")
                regs["hl"] = ("@" if m.group(1) in TEXT_BUFFERS else "=") + _var(m.group(1))
                continue
            if m := re.match(r"ld ([a-ehl]|bc|de|hl), ([^\[]+)$", t):
                r, v = m.groups()
                if v in regs and r in _REGS8 and v in _REGS8:
                    val = regs[v]
                else:
                    val = None if v in _REGS8 or v in _PAIRS else v
                _clobber(regs, spent, r)
                if val:
                    regs[r] = val
                continue
            if m := re.match(r"(?:lb|ld_char_rec) (bc|de|hl), ([^,]+), (.+)$", t):
                _clobber(regs, spent, m.group(1))
                regs[m.group(1)[0]], regs[m.group(1)[1]] = m.group(2), m.group(3)
                continue
            m = re.match(r"(?:ldh? ([a-l]|bc|de|hl|sp), |(?:inc|dec|pop|swap|rlc?|rrc?|sla|sra|srl) "
                         r"([a-l]|bc|de|hl|af)$|(?:res|set) \w+, ([a-l])$|add (hl|sp), |"
                         r"(add|adc|sub|sbc|and|or|xor|cpl|rla|rra|rlca|rrca|daa)\b)", t)
            if m:
                r = next(g for g in m.groups() if g)
                _clobber(regs, spent, "a" if m.group(5) else r)
                continue
            regs, spent = {}, set()
    return uses


_TAIL_JUMP_RE = re.compile(r"(?:jp|jr) (?:(?:n?z|n?c), )?([A-Za-z_]\w*)(?:\.\w+)?$")
_NO_FALLTHROUGH_RE = re.compile(r"(ret|reti|jp [^,]+|jr [^,]+|jumptable\b.*|rst Rst00|"
                                r"(db|dw|ds|INCBIN|INCLUDE)\b.*)$")


def _return_uses():
    """{variable: [(operand, where)]} for `call R` / `farcall R` whose result
    is stored straight into a variable: every `ld a, <imm> / ret` in R, or in
    a routine R reaches by jumps, a jumptable row or falling through, is a
    store of that immediate."""
    rets, tails, links = {}, {}, []
    for holder in holders():
        lines, origin = bank_lines(holder)
        owner = prev = pending = called = None
        in_table = False
        for i, line in enumerate(lines):
            if m := _GLOBAL_RE.match(line):
                if owner and prev and not _NO_FALLTHROUGH_RE.match(prev):
                    tails[owner].add(m.group(1))
                owner = m.group(1)
                rets.setdefault(owner, [])
                tails.setdefault(owner, set())
                prev = pending = called = None
                in_table = False
                continue
            t = line.split(";")[0].strip()
            if not t or t.startswith(".") or owner is None:
                continue
            where = f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}"
            if t == "ret" and pending:
                rets[owner].append(pending)
            if called and (m := re.match(rf"ldh? \[{_VAR_RE}\], a$", t)):
                links.append((_var(m.group(1)), called))
            pending = (m.group(1), where) if (m := re.match(r"ld a, ([^\[\],]+)$", t)) else None
            called = m.group(2) if (m := re.match(r"(call|farcall) (\w+)$", t)) else None
            if in_table and (m := re.match(r"dw ([A-Za-z_]\w*)(?:\.\w+)?$", t)):
                tails[owner].add(m.group(1))
            else:
                in_table = t.startswith("jumptable")
            if m := _TAIL_JUMP_RE.match(t):
                tails[owner].add(m.group(1))
            prev = t
    uses = {}
    for var, routine in links:
        seen, todo = set(), [routine]
        while todo:
            r = todo.pop()
            if r not in seen:
                seen.add(r)
                todo += tails.get(r, ())
        ops = uses.setdefault(var, [])
        ops += [op for r in sorted(seen) for op in rets.get(r, ()) if op not in ops]
    return uses


def _raw_data_ids(seen):
    """[(family prefix, operand, where)] over the data rows RAW_ID_MACRO_ARGS,
    RAW_ID_TABLE_KINDS and RAW_ID_TABLES name; `seen` gets the keys used."""
    out = []
    for holder in holders():
        lines, origin = bank_lines(holder)
        table = None
        for i, line in enumerate(lines):
            if m := _GLOBAL_RE.match(line):
                table = RAW_ID_TABLES.get(m.group(1))
                if table:
                    seen.add(m.group(1))
                elif i + 1 < len(lines):
                    kind = re.search(r"\(([^)]*)\)\s*$", lines[i + 1])
                    key = kind and next((k for k in RAW_ID_TABLE_KINDS
                                         if kind.group(1).startswith(k)), None)
                    table = key and RAW_ID_TABLE_KINDS[key]
                    seen.add(key)
                continue
            t = line.split(";")[0].strip()
            if not t:
                continue
            where = f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}"
            word, _, rest = t.partition(" ")
            args = [a.strip() for a in rest.split(",")] if rest else []
            if table and word in ("db", "dw"):
                out += [(table, a, where) for a in args]
            elif word not in ("db", "dw", "table_width", "assert_table_length"):
                table = None
            for (macro, k), prefix in RAW_ID_MACRO_ARGS.items():
                if macro in (word, f"{word} {args[0] if args else ''}") and k < len(args):
                    out.append((prefix, args[k], where))
    return out


_PAD_SOURCE_RE = re.compile(r"ldh? ([abcdehl]), \[(?:hInput(?:Pressed|RisingEdge|RepeatButtons)|wCharInputBits)\]")
_PAD_BRANCH_RE = re.compile(r"(jr|jp) (?:(?:nz|z|nc|c), )?([\w.]+)")
_PAD_WRITE_RE = re.compile(r"(?:ldh?|inc|dec|swap|rlc?|rrc?|sla|sra|srl) ([abcdehl])\b|"
                           r"(?:and|or|xor|add|adc|sub|sbc|cpl|rlca|rrca|rla|rra)\b()|pop (af|bc|de|hl)|(?:push_)?wram_bank \w+()")
# Raw bit tests on a joypad byte left as numbers: (routine, bit).
KNOWN_RAW_PAD_BITS = set()


def _raw_pad_bits(fail):
    """A raw `bit n, r` on a register holding a joypad byte -- loaded from
    hInput* / wCharInputBits, or already tested with a PADB_ bit -- is a
    PADB_ name. The register's state follows branches to local labels."""
    n, seen = 0, set()
    for h in holders():
        lines, origin = bank_lines(h)
        scope = owner = None
        flags, pending = set(), {}
        for i, line in enumerate(lines):
            if m := _GLOBAL_RE.match(line):
                scope = owner = m.group(1)
                flags = set(pending.pop(scope, ()))
                continue
            if m := re.match(r"^(\w+)?(\.\w+):", line):
                owner = m.group(1) or scope
                flags |= pending.pop(owner + m.group(2), set())
                continue
            ins = line.split(";")[0].strip()
            if not ins:
                continue
            if m := _PAD_SOURCE_RE.fullmatch(ins):
                flags.add(m.group(1))
                continue
            if m := re.fullmatch(r"bit (\w+), ([abcdehl])", ins):
                if m.group(1).startswith("PADB_") or m.group(2) in flags:
                    n += 1
                if m.group(1).startswith("PADB_"):
                    flags.add(m.group(2))
                elif m.group(2) in flags and _NUMBER_RE.fullmatch(m.group(1)):
                    if (owner, m.group(1)) in KNOWN_RAW_PAD_BITS:
                        seen.add((owner, m.group(1)))
                    else:
                        where = f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}"
                        fail("raw-ids", f"{where}: {owner} bit {m.group(1)} on a joypad byte -- a PADB_ name?")
                continue
            if m := _PAD_BRANCH_RE.fullmatch(ins):
                target = scope + m.group(2) if m.group(2).startswith(".") else m.group(2)
                pending.setdefault(target, set()).update(flags)
                if "," not in ins:
                    flags = set()
                continue
            if ins in ("ret", "reti", "jp hl"):
                flags = set()
                continue
            if m := re.fullmatch(r"ld ([abcdehl]), ([abcdehl])", ins):
                (flags.add if m.group(2) in flags else flags.discard)(m.group(1))
                continue
            if m := _PAD_WRITE_RE.match(ins):
                if m.group(1):
                    flags.discard(m.group(1))
                elif m.group(3):
                    flags -= set(m.group(3).replace("f", ""))
                else:
                    flags.discard("a")
    for key in sorted(KNOWN_RAW_PAD_BITS - seen):
        fail("raw-ids", f"{key} is no longer tested raw -- drop it from KNOWN_RAW_PAD_BITS")
    return n


# Bit-flag bytes whose bits are a constant family: every bit/set/res on the
# byte (in a register loaded from it, through hl pointing at it, or on a
# register stored into it) names its bit, and an and/or/xor mask on a loaded
# value is a name of the family.
FLAG_BYTES = {
    "wCharBallReachFlags": "BALLREACHB_",
    "wCharFlags": "CHARB_",
    "wExpScreenBusyFlags": "EXPBUSYB_",
    "wTennisDictFlags": "TDICTFLAGB_",
    "wMessageSpeed": "MSGSPEEDB_",
    "wCharCourtPos": "COURTPOSB_",
    "wServingCharCourtPos": "COURTPOSB_",
    "wPrevCourtPos": "COURTPOSB_",
    "wCharServeRole": "SERVEROLEB_",
    "hMusicFlags": "MUSICB_",
    "wSoundOptionBits": "SOUNDOPTB_",
    "wCharSpriteDirty": "CHARSPRITEB_",
}
# Record fields of the same kind, reached through `ld hl, FIELD / add hl, rr`,
# `ld hl, wRecord + FIELD` or `ld a, FIELD / add l / ld l, a`.
FLAG_FIELDS = {
    "ACTORF_FLAGS": "ACTORFLAGB_",
    "ACTORF_STATUS": "ACTORSTATUSB_",
    "MGTARGET_FLAGS": "MGTARGETB_",
    "OBJSLOT_FLAGS": "OBJSLOTB_",
    "MGACTOR_FLAGS": "MGACTORB_",
}
# (field, bit) pairs still tested raw: the bit has no known meaning yet.
KNOWN_RAW_FIELD_BITS = {("ACTORF_FLAGS", "1"), ("ACTORF_STATUS", "1"), ("ACTORF_STATUS", "3")}
_FLAG_NAMES = "|".join(FLAG_BYTES)
_FLAG_FIELD_RE = re.compile(rf"ld hl, (?:\w+ \+ )?({'|'.join(FLAG_FIELDS)})")
_FLAG_FIELD_A_RE = re.compile(rf"ld a, ({'|'.join(FLAG_FIELDS)})")
# Calls that leave hl alone, so a tracked [hl] survives them.
HL_KEEPING_CALLS = {"WaitScriptFrames"}
_FLAG_LOAD_RE = re.compile(rf"ldh? ([abcdehl]), \[({_FLAG_NAMES})\]")
_FLAG_HL_RE = re.compile(rf"ld hl, ({_FLAG_NAMES})\b.*")
_FLAG_STORE_RE = re.compile(rf"ldh? \[({_FLAG_NAMES})\], ([abcdehl])")
_FLAG_BIT_RE = re.compile(r"(bit|set|res) (\w+), (\[hl\]|[abcdehl])")
_FLAG_HL_WRITE_RE = re.compile(r"(?:ld|pop|inc|dec) hl\b.*|ld [hl], .*|.*\[hl[+-]\].*")


def _raw_flag_bits(fail):
    """A bit/set/res on a FLAG_BYTES byte names its bit from the byte's
    family. State follows branches to local labels and is dropped at calls.
    FLAG_FIELDS record fields count the same way."""
    n = 0
    seen = set()
    for h in holders():
        lines, origin = bank_lines(h)
        scope = owner = None
        state, built, pending = {}, {}, {}
        field_off = None
        for i, line in enumerate(lines):
            if m := _GLOBAL_RE.match(line):
                scope = owner = m.group(1)
                state, built = dict(pending.pop(scope, {})), {}
                continue
            if m := re.match(r"^(\w+)?(\.\w+):", line):
                owner = m.group(1) or scope
                state.update(pending.pop(owner + m.group(2), {}))
                continue
            ins = line.split(";")[0].strip()
            if not ins:
                continue
            where = f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}"
            off, field_off = field_off, None
            if m := _FLAG_FIELD_A_RE.fullmatch(ins):
                field_off = (FLAG_FIELDS[m.group(1)], False)
            elif off and ins == "add l" and not off[1]:
                field_off = (off[0], True)
            elif off and ins == "ld l, a" and off[1]:
                state["[hl]"] = off[0]
                state.pop("h", None), state.pop("l", None)
                continue

            def judge(op, prefix):
                nonlocal n
                n += 1
                field = next((f for f, p in FLAG_FIELDS.items() if p == prefix), None)
                if (field, op) in KNOWN_RAW_FIELD_BITS:
                    seen.add((field, op))
                elif not op.startswith(prefix):
                    fail("raw-ids", f"{where}: {owner} bit {op} on a {prefix}* byte -- a {prefix} name?")

            if m := _FLAG_LOAD_RE.fullmatch(ins):
                state[m.group(1)] = FLAG_BYTES[m.group(2)]
                built.pop(m.group(1), None)
                continue
            if m := _FLAG_HL_RE.fullmatch(ins):
                state["[hl]"] = FLAG_BYTES[m.group(1)]
                state.pop("h", None), state.pop("l", None)
                continue
            if m := _FLAG_FIELD_RE.fullmatch(ins):
                state["[hl]"] = FLAG_FIELDS[m.group(1)]
                state.pop("h", None), state.pop("l", None)
                continue
            if m := _FLAG_STORE_RE.fullmatch(ins):
                for op, w in built.pop(m.group(2), []):
                    where = w
                    judge(op, FLAG_BYTES[m.group(1)])
                continue
            if (m := re.fullmatch(r"(?:and|or|xor) (.+)", ins)) and "a" in state and m.group(1) not in _REGS8:
                n += 1
                if not m.group(1).lstrip("~").startswith(state["a"].split("B_")[0]):
                    fail("raw-ids", f"{where}: {owner} mask {m.group(1)} on a {state['a']}* byte -- a name?")
            if m := _FLAG_BIT_RE.fullmatch(ins):
                if m.group(3) in state:
                    judge(m.group(2), state[m.group(3)])
                elif m.group(1) != "bit" and m.group(3) != "[hl]":
                    built.setdefault(m.group(3), []).append((m.group(2), where))
                continue
            if m := _PAD_BRANCH_RE.fullmatch(ins):
                target = scope + m.group(2) if m.group(2).startswith(".") else m.group(2)
                pending.setdefault(target, {}).update(state)
                if "," not in ins:
                    state, built = {}, {}
                continue
            if ins in ("ret", "reti", "jp hl") or ins.startswith(("call", "farcall", "rst")):
                keep = ins.split(" ")[-1] in HL_KEEPING_CALLS and "[hl]" in state
                state, built = ({"[hl]": state["[hl]"]} if keep else {}), {}
                continue
            if (m := re.fullmatch(r"ld ([abcde]), \[hl\]", ins)) and "[hl]" in state:
                state[m.group(1)] = state["[hl]"]
                built.pop(m.group(1), None)
                continue
            if _FLAG_HL_WRITE_RE.fullmatch(ins):
                state.pop("[hl]", None)
            if m := re.fullmatch(r"ld ([abcdehl]), ([abcdehl])", ins):
                if m.group(2) in state:
                    state[m.group(1)] = state[m.group(2)]
                else:
                    state.pop(m.group(1), None)
                built.pop(m.group(1), None)
                continue
            if m := _PAD_WRITE_RE.match(ins):
                regs = m.group(1) or (m.group(3) or "").replace("f", "") or "a"
                for r in regs:
                    state.pop(r, None)
                if m.group(1) or m.group(3) or m.group(4) is not None:
                    for r in regs:
                        built.pop(r, None)
    for key in sorted(KNOWN_RAW_FIELD_BITS - seen):
        fail("raw-ids", f"{key} is no longer tested raw -- drop it from KNOWN_RAW_FIELD_BITS")
    return n


def check_raw_ids(fail):
    """A raw cp/store operand on a variable (wVar + n counts as wVar) that
    names its other values from a constant family must not equal a member of
    that family. The immediates in a routine's argument registers at a call
    count as variables `Routine(reg)`, the immediates a routine returns as
    stores into the variable its caller saves the result in, and a byte read through a
    TEXT_BUFFERS / TEXT_POINTER_LABELS pointer as `text@source` in the TX
    family. Data rows of the macros and tables RAW_ID_* list must name their
    ids."""
    import consts
    values = consts.constants()
    uses = _raw_id_uses()
    for var, ops in _return_uses().items():
        uses.setdefault(var, []).extend(ops)
    n = 0

    def names_of(v, families):
        return sorted((k for k, x in values.items() if x == v and k.split("_")[0] in families
                       and not k.startswith("NUM_")), key=lambda k: bool(_TEXT_INDEX_RE.match(k)))

    for var, ops in uses.items():
        if var in _PER_LOCATION_VARS:
            continue
        families = {op.split("_")[0] for op, _ in ops
                    if op in values and "_" in op and not op.endswith("_SIZE")}
        families |= {RAW_ID_FAMILIES.get(var), "TX" if var.startswith("text@") else None} - {None}
        for op, where in ops:
            if not _NUMBER_RE.fullmatch(op):
                continue
            n += 1
            names = names_of(_number(op), families)
            if names and (var, op) not in KNOWN_RAW_IDS:
                fail("raw-ids", f"{where}: {var} {op} -- {names[0]}?")
            elif (var.endswith(("(hl)", "(de)")) and (var, op) not in KNOWN_RAW_IDS
                  and sum(o.startswith("Text_") for o, _ in ops) >= 2):
                fail("raw-ids", f"{where}: {var} {op} -- a text id with no Text_ name?")
    seen = set()
    for prefix, op, where in _raw_data_ids(seen):
        n += 1
        if _NUMBER_RE.fullmatch(op):
            names = [k for k, x in values.items() if x == _number(op) and k.startswith(prefix)]
            if names:
                fail("raw-ids", f"{where}: {op} -- {names[0]}?")
        elif op not in values or not op.startswith(prefix):
            fail("raw-ids", f"{where}: {op} is not a {prefix}* id")
    for key in sorted((set(RAW_ID_TABLES) | set(RAW_ID_TABLE_KINDS)) - seen):
        fail("raw-ids", f"{key}: matches no table -- drop it from RAW_ID_TABLES/_KINDS")
    for var in sorted(set(RAW_ID_FAMILIES) - set(uses)):
        fail("raw-ids", f"{var} is no longer used -- drop it from RAW_ID_FAMILIES")
    for routine, r in sorted(BASE_ID_ARGS.items()):
        if f"{routine}({r})" not in uses:
            fail("raw-ids", f"{routine}({r}) is never passed an id -- drop it from BASE_ID_ARGS")
    for var, op in sorted(KNOWN_RAW_IDS - {(v, o) for v, ops in uses.items() for o, _ in ops}):
        fail("raw-ids", f"{var} {op} is no longer used raw -- drop it from KNOWN_RAW_IDS")
    return (n + _raw_pad_bits(fail) + _raw_flag_bits(fail) + _text_cell_offsets(fail)
            + _raw_flag_conds(fail))


_FLAG_COND_ARG = {"map_actor": 0, "map_script": 2}


def _raw_flag_conds(fail):
    """A map_script / map_actor flag condition is 0 or a FLAG_ name."""
    n = 0
    for holder in holders():
        lines, origin = bank_lines(holder)
        for i, line in enumerate(lines):
            word, _, rest = line.split(";")[0].strip().partition(" ")
            if word not in _FLAG_COND_ARG:
                continue
            n += 1
            op = rest.split(",")[_FLAG_COND_ARG[word]].strip()
            if _NUMBER_RE.fullmatch(op) and _number(op):
                where = f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}"
                fail("raw-ids", f"{where}: {word} flag condition {op} -- FLAG_ or ~FLAG_ name?")
    return n


def _text_cell_offsets(fail):
    """`ld hl, X / add hl, rr / ld e, l / ld d, h` builds a cell or offset in
    de from X; a text id is never X."""
    n = 0
    for h in holders():
        lines, origin = bank_lines(h)
        code = [(i, c) for i, c in ((i, l.split(";")[0].strip()) for i, l in enumerate(lines)) if c]
        for k in range(len(code) - 3):
            if not (re.fullmatch(r"add hl, (bc|de)", code[k + 1][1]) and code[k + 2][1] == "ld e, l"
                    and code[k + 3][1] == "ld d, h"):
                continue
            m = re.fullmatch(r"ld hl, (\S+)", code[k][1])
            if not m:
                continue
            n += 1
            if m.group(1).startswith("Text_"):
                i = code[k][0]
                fail("raw-ids", f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}: {m.group(1)}"
                                " is added to a pointer as a cell or offset -- ld_cell?")
    return n


# Raw offsets a field-naming routine adds to a pointer that are not fields of
# a record: (routine, operand) -> what the number is.
KNOWN_RAW_FIELD_OFFSETS = {
    ("UpdateActorJumpPhysics", "$0010"): "gravity added to the vertical velocity",
    ("Unused_1b_DrawUnlockDebugMugshots", "$08"): "wCharSelectRoster entry stride",
}
_FIELD_FAMILY_RE = re.compile(r"\b(?:CHARREC|CREATEDCHAR|SLOTSUM|ACTORF|OBJSLOT|SCENEOBJ|WINDOW)_(?!SIZE\b)\w+")
_FIELD_HL_RE = re.compile(r"ld hl, ([^,]+)")
# Arrays whose entries are a constant family: `Array + n` names the entry.
INDEXED_ARRAYS = {
    "CHARREC_TRAIN_LEVELS": "TRAINSTAT_",
    "wCharDataLevels": "TRAINSTAT_",
    "wCharDataNewLevels": "TRAINSTAT_",
    "wCharDataStats": "CHARSTAT_",
    "wCharDataStatDeltas": "CHARSTAT_",
    "wCharDataStatsNoEquipment": "CHARSTAT_",
    "wCharDataEquipmentDeltas": "CHARSTAT_",
    "wActorObjDef": "OBJDEF_",
    "wBallHistory": "BALLHIST_",
    "wBGPalettes": ("PAL_SIZE", "COLOR_SIZE"),
    "wOBPalettes": ("PAL_SIZE", "COLOR_SIZE"),
    "wMasterPalettes": ("PAL_SIZE", "COLOR_SIZE"),
}
_INDEXED_ARRAY_RE = re.compile(rf"\b({'|'.join(INDEXED_ARRAYS)}) \+ ([^\],;]+)")
_FIELD_A_RE = re.compile(r"ld a, ([^,]+)")


def check_field_offsets(fail):
    """In a routine that names a CHARREC_* / CREATEDCHAR_* / SLOTSUM_* /
    ACTORF_* / OBJSLOT_* / SCENEOBJ_* / WINDOW_* field, an offset added to a
    record pointer (`ld hl, off / add hl, bc|de`, `ld a, off / add_hl_a`, or
    `ld a, off / add c|e / ld e|c, a`) is not a raw number under $100: the same record reached through another register is still
    that record. An offset into an INDEXED_ARRAYS array (or record buffer)
    is a member of its family."""
    n, seen = 0, set()
    for holder in holders():
        lines, origin = bank_lines(holder)
        routines, cur = [], None
        for i, line in enumerate(lines):
            for m in _INDEXED_ARRAY_RE.finditer(line.split(";")[0]):
                n += 1
                off = re.sub(r"^\d+ \* ", "", m.group(2).strip())
                fam = INDEXED_ARRAYS[m.group(1)]
                if not off.startswith(fam):
                    where = f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}"
                    fam = fam if isinstance(fam, str) else "/".join(fam)
                    fail("fields", f"{where}: {m.group(1)} + {m.group(2).strip()} -- "
                                   f"a {fam}* entry?")
            if m := re.match(r"^([A-Za-z_]\w*)::?$", line):
                cur = (m.group(1), [])
                routines.append(cur)
            elif cur and (ins := line.split(";")[0].strip()) and not ins.endswith(":"):
                cur[1].append((i, ins))
        for name, ins in routines:
            if not any(_FIELD_FAMILY_RE.search(t) for _, t in ins):
                continue
            for k, (i, t) in enumerate(ins):
                nxt = [u for _, u in ins[k + 1:k + 3]] + ["", ""]
                m = _FIELD_HL_RE.fullmatch(t)
                if not (m and re.fullmatch(r"add hl, (bc|de)", nxt[0])):
                    m = _FIELD_A_RE.fullmatch(t)
                    if not (m and (nxt[0] == "add_hl_a" or re.fullmatch(r"add [ce]", nxt[0])
                                   and re.fullmatch(r"ld [ce], a", nxt[1]))):
                        continue
                op = m.group(1).strip()
                n += 1
                if not _NUMBER_RE.fullmatch(op) or _number(op) >= 0x100:
                    continue
                if (name, op) in KNOWN_RAW_FIELD_OFFSETS:
                    seen.add((name, op))
                    continue
                where = f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}"
                fail("fields", f"{where}: {name} adds raw {op} to a record -- a field name?")
    for name, op in sorted(set(KNOWN_RAW_FIELD_OFFSETS) - seen):
        fail("fields", f"{name} {op} is no longer added raw -- drop it from KNOWN_RAW_FIELD_OFFSETS")
    return n + _char_record_bases(fail) + _char_struct_bases(fail)


_CHARREC_NAME_RE = re.compile(r"ld (bc|de|hl), ((?:wStory|wPlayer[12])(?:Main|Partner))Name")
_REG_COPIES = {("ld b, h", "ld c, l"): ("hl", "bc"), ("ld d, h", "ld e, l"): ("hl", "de"),
               ("ld h, b", "ld l, c"): ("bc", "hl"), ("ld h, d", "ld l, e"): ("de", "hl"),
               ("ld d, b", "ld e, c"): ("bc", "de"), ("ld b, d", "ld c, e"): ("de", "bc")}
# Routines that take a whole char record in a register.
_CHARREC_ARG_ROUTINES = {"RecomputeCharacterStats": "bc"}


def _char_record_bases(fail):
    """A `...Name` char-record operand is the name: one copied or cleared by
    CHAR_RECORD_SIZE, passed to a _CHARREC_ARG_ROUTINES routine or with a
    CHARREC_* field added to it within the next dozen instructions, is the
    whole record and takes the base label."""
    n = 0
    for h in holders():
        lines, origin = bank_lines(h)
        code = [(i, c) for i, c in ((i, l.split(";")[0].strip()) for i, l in enumerate(lines))
                if c and not c.endswith(":")]
        for k, (i, t) in enumerate(code):
            m = _CHARREC_NAME_RE.fullmatch(t)
            if not m:
                continue
            n += 1
            regs, why = {m.group(1)}, None
            window = [u for _, u in code[k + 1:k + 13]]
            for j, u in enumerate(window):
                if j < 3 and "CHAR_RECORD_SIZE" in u:
                    why = "is copied or cleared as a whole record"
                    break
                if src_dst := _REG_COPIES.get((u, window[j + 1] if j + 1 < len(window) else "")):
                    if src_dst[0] in regs:
                        regs.add(src_dst[1])
                    continue
                if (f := re.fullmatch(r"(?:far)?call (\w+)", u)) and _CHARREC_ARG_ROUTINES.get(f.group(1)) in regs:
                    why = f"is passed to {f.group(1)}"
                    break
                nxt = window[j + 1] if j + 1 < len(window) else ""
                if (f := re.fullmatch(r"ld hl, (CHARREC_\w+)", u)) and nxt in {f"add hl, {r}" for r in regs}:
                    why = f"has {f.group(1)} added"
                    break
                if (f := re.fullmatch(r"ld a, (CHARREC_\w+)", u)) and nxt == "add_hl_a" and "hl" in regs:
                    why = f"has {f.group(1)} added"
                    break
            if why:
                fail("fields", f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}: "
                               f"{m.group(2)}Name {why} -- {m.group(2)}?")
    return n

# Routines handed the whole $df00 char struct in a register.
_CHARSTRUCT_ARG_ROUTINES = {"SetCharAnimation": "bc", "StepCharAnimation": "bc",
                            "UpdateCharSelectCharSprite": "hl"}


def _char_struct_bases(fail):
    """`wCharPosX` is the first field only: an operand that copies or clears
    the struct, is passed to a _CHARSTRUCT_ARG_ROUTINES routine, has an offset
    added to it, or is subtracted from a field (`wX - wCharPosX`) means the
    whole struct, wCharStruct."""
    n = 0
    for h in holders():
        lines, origin = bank_lines(h)
        code = [(i, c) for i, c in ((i, l.split(";")[0].strip()) for i, l in enumerate(lines))
                if c and not c.endswith(":")]
        for k, (i, t) in enumerate(code):
            where = f"{Path(origin[i][0]).relative_to(ROOT)}:{origin[i][1]}"
            if re.search(r"-\s*wCharPosX\b", t):
                n += 1
                fail("fields", f"{where}: offset from wCharPosX -- wCharStruct?")
                continue
            m = re.fullmatch(r"ld (bc|de|hl), wCharPosX", t)
            if not m:
                continue
            n += 1
            regs, why = {m.group(1)}, None
            window = [u for _, u in code[k + 1:k + 13]]
            for j, u in enumerate(window):
                nxt = window[j + 1] if j + 1 < len(window) else ""
                if j < 3 and re.fullmatch(r"call (CopyMemoryFast|ClearMemory16)", u):
                    why = "is copied or cleared as a whole struct"
                    break
                if src_dst := _REG_COPIES.get((u, nxt)):
                    if src_dst[0] in regs:
                        regs.add(src_dst[1])
                    continue
                if (f := re.fullmatch(r"(?:far)?call (\w+)", u)) and _CHARSTRUCT_ARG_ROUTINES.get(f.group(1)) in regs:
                    why = f"is passed to {f.group(1)}"
                    break
                if j == 0 and u in {f"add hl, {r}" for r in regs - {"hl"}}:
                    why = "has an offset added"
                    break
                if re.fullmatch(r"ld hl, w\w+ - w\w+", u) and nxt in {f"add hl, {r}" for r in regs - {"hl"}}:
                    why = "has a field offset added"
                    break
            if why:
                fail("fields", f"{where}: wCharPosX {why} -- wCharStruct?")
    return n

_TEMPLATE_HL_RE = re.compile(r"\tld hl, ([A-Za-z_]\w*)(?: ;|$)")
_HL_READ_RE = re.compile(r"\[hl[+-]?\]|\badd hl\b|\badd_hl_a\b|\bpush hl\b")
# Dead code whose operand is a stale address: the same number is its LZ
# source and palette too, so the table that sits there is no template.
KNOWN_NON_TEMPLATES = {"UnlockDebugNavGridTable"}


def check_sprite_templates(fail):
    """A label handed to QueueSpriteTemplate in hl -- directly, or as a row of
    the pointer table hl is indexed into -- is a sprite_template region."""
    n = 0
    for h in holders():
        bank = bank_of(h)
        lines = bank_lines(h)[0]
        body = {}
        for i, line in enumerate(lines):
            m = _GLOBAL_RE.match(line)
            if m:
                body[m.group(1)] = i + 1

        def is_template(name):
            i = body.get(name)
            if i is None:
                return True
            first = lines[i]
            return "(sprite_template)" in first or first.startswith("\toam_sprite")

        def table_rows(name):
            out = []
            for line in lines[body.get(name, len(lines)):]:
                if line.startswith("\t;"):
                    continue
                m = re.match(r"\tdw (.*?)(?: ;|$)", line)
                if not m:
                    break
                out += [w.strip() for w in m.group(1).split(",")]
            return out

        for i, line in enumerate(lines):
            if not re.match(r"\tcall QueueSpriteTemplate\b", line):
                continue
            for j in range(i - 1, -1, -1):
                prev = lines[j]
                if (_GLOBAL_RE.match(prev) or re.match(r"\t(?:ret|jp|jr)\b(?!.*,)", prev)
                        or re.match(r"\t(?:call|farcall|rst|pop hl)\b", prev)):
                    break
                m = _TEMPLATE_HL_RE.match(prev)
                if not m:
                    if prev.startswith("\tld hl,"):
                        break
                    continue
                between = [l.split(";")[0] for l in lines[j + 1:i]]
                ptrs = any("ld a, [hl+]" in a and "ld h, [hl]" in b
                           for a, b in zip(between, between[1:]))
                if ptrs:
                    names = table_rows(m.group(1))
                elif any(_HL_READ_RE.search(l) for l in between):
                    break
                else:
                    names = [m.group(1)]
                for name in dict.fromkeys(names):
                    n += 1
                    if not is_template(name) and name not in KNOWN_NON_TEMPLATES:
                        fail("templates", f"${bank:02x}: {name} is queued by QueueSpriteTemplate "
                                          "but is not a sprite_template region")
                if ptrs:
                    break
    return n

def check_mirrored_operands(fail):
    """A direct `[wX]` operand on a ram_mirrored.inc symbol whose banks are
    listed is not preceded, in its bank's source, by a `wram_bank` (with no
    `pop_wram_bank` since) selecting a bank that lacks it."""
    mirrored, banks = {}, None
    for line in (ROOT / "include" / "ram_mirrored.inc").read_text().split("\n"):
        m = re.search(r"WRAM banks? (\$[0-9a-f]{2}(?:(?:/|, | and )\$[0-9a-f]{2})*)", line)
        if line.startswith(";") and m:
            banks = {int(b, 16) for b in re.findall(r"\$([0-9a-f]+)", m.group(1))}
        m = re.match(r"def (\w+) equ", line)
        if m:
            if banks:
                mirrored[m.group(1)] = banks
            banks = None
    consts = {name: int(v, 16) for name, v in re.findall(
        r"^\tconst (WRAM_\w+)\s*; \$([0-9a-f]+)", (ROOT / "include" / "constants" / "memory.inc").read_text(), re.M)}
    for h in holders():
        bank = bank_of(h)
        cur = None
        for line in bank_lines(h)[0]:
            code = line.split(";")[0]
            if re.match(r"\s*pop_wram_bank\b", code):
                cur = None
                continue
            m = re.match(r"\s*(?:push_)?wram_bank\s+(\w+)", code)
            if m:
                cur = consts.get(m.group(1))
                continue
            for name in re.findall(r"\[\s*(w\w+)", code):
                if name in mirrored and cur is not None and cur not in mirrored[name]:
                    fail("mirrors", f"${bank:02x}: [{name}] read or written with WRAM bank {cur} selected")
    return len(mirrored)


# Instructions and macros that leave de and hl alone.
_PTR_KEEPS = {"cp", "bit", "push", "nop", "jr", "halt", "di", "ei", "ldh", "cpl", "scf",
              "ccf", "rlca", "rrca", "rla", "rra", "daa"}
_PTR_WRITES = {"ld", "pop", "add", "adc", "sub", "sbc", "inc", "dec", "swap", "srl", "rr",
               "rl", "rrc", "rlc", "sla", "sra", "res", "set", "xor", "or", "and"}

# Routines that select WRAM_SCREEN themselves and write tile ids through the
# register (most also the attribute, under WRAM_COURT_PLANES at the same address), so
# a WRAMX destination passed in must be a bank-3 name. The bc routines read their
# source rows the same way. ShiftDestForLongName
# only steps de back before WriteTextToTilemap.
_TILE_PLANE_WRITERS = {
    "DrawProportionalTextLine": "de", "WriteTextToTilemap": "de", "FetchAndDrawDialogueText": "de",
    "FormatAndDrawNumber": "de", "CopyLabelTilesToTilemap": "de", "CopyTilesAndAttrsRun": "de",
    "WriteNameStringTiles": "de", "PlotTilesAtOffsets": "de", "ShiftDestForLongName": "de",
    "DrawContinuePromptText": "hl", "DrawSaveWarningTextLine1": "hl", "DrawSaveWarningTextLine2": "hl",
    "FillTilemapRun": "hl", "DrawFourTileFlagLabel": "hl",
    "CharDataScreen_WriteStatNumber": "de", "CharDataScreen_DrawStatBar": "de",
    "WriteExpScreenStringTiles": "de",
    "BlitTilemapRunsFromTable": "bc", "ApplyTilemapPatchList": "bc",
    "ApplyTilemapPatchList_1a": "bc", "ApplyTilemapPatchListExpScreen": "bc",
}


def check_wram_pointers(fail):
    """`ld bc/de/hl, wX` with wX in one WRAMX bank, then `[bc]`/`[de]`/`[hl]` in
    straight-line source after a `wram_bank` selecting another, or wX
    passed to a _TILE_PLANE_WRITERS routine that is not a bank-3 name. A global
    label, a call or an unknown macro forgets the pointers."""
    wbank = {n: b for b, a, n in read_sym() if 0xd000 <= a < 0xe000 and "." not in n}
    consts = {name: int(v, 16) for name, v in re.findall(
        r"^\tconst (WRAM_\w+)\s*; \$([0-9a-f]+)", (ROOT / "include" / "constants" / "memory.inc").read_text(), re.M)}
    sites = 0
    for h in holders():
        lines, origin = bank_lines(h)
        cur, ptr = None, {}
        for i, line in enumerate(lines):
            code = line.split(";")[0].strip()
            if re.match(r"[A-Za-z_]\w*:", line):
                cur, ptr = None, {}
                continue
            if not code or code.endswith(":"):
                continue
            if re.match(r"pop_wram_bank\b", code):
                cur = None
                continue
            m = re.match(r"(?:push_)?wram_bank\s+(\w+)", code)
            if m:
                cur = consts.get(m.group(1))
                continue
            m = re.match(r"ld (bc|de|hl), (w\w+)\b", code)
            if m:
                ptr.pop(m.group(1), None)
                if m.group(2) in wbank:
                    ptr[m.group(1)] = (m.group(2), wbank[m.group(2)], origin[i])
                    sites += 1
                continue
            for rr in ("bc", "de", "hl"):
                if rr in ptr and cur is not None and re.search(r"\[" + rr + r"[+-]?\]", code):
                    sym, b, (f, ln) = ptr[rr]
                    if b != cur:
                        fail("wram-ptrs", f"{Path(f).relative_to(ROOT)}:{ln}: {sym} (WRAM bank {b}) "
                                          f"dereferenced with bank {cur} selected")
                        del ptr[rr]
            op, _, args = code.partition(" ")
            rr = _TILE_PLANE_WRITERS.get(args) if op in ("call", "farcall") else None
            if rr in ptr:
                sym, b, (f, ln) = ptr[rr]
                if b != consts["WRAM_SCREEN"]:
                    fail("wram-ptrs", f"{Path(f).relative_to(ROOT)}:{ln}: {sym} (WRAM bank {b}) "
                                      f"passed to {args}, which writes the WRAM_SCREEN tile plane")
            if op in _PTR_WRITES:
                dst = args.split(",")[0].strip()
                for rr in ("bc", "de", "hl"):
                    if dst in (rr[0], rr[1]) or (dst == rr and op not in ("inc", "dec")):
                        ptr.pop(rr, None)
            elif op in ("lb", "ld_tile_run"):
                ptr.pop(args.split(",")[0].strip(), None)
            elif op == "ld_hl_indexed":
                ptr.pop("hl", None)
            elif op == "ld_de_indexed":
                ptr.pop("de", None)
            elif op == "ld_bc_indexed":
                ptr.pop("bc", None)
            elif op in ("ret", "reti", "jp") and "," not in args:
                ptr = {}
            elif op not in _PTR_KEEPS:
                ptr = {}
    return sites


# Routines whose "loop" locals name the domain, not the control flow.
KNOWN_LOOP_NAMES = {
    "RunSoundChannelScript": "the sound-script loop opcodes it interprets",
}


def check_loop_labels(fail):
    """A local named *loop* is the target of a branch or table row from a
    later line: its own routine's, or by full name from code after it."""
    n = 0
    seen = set()
    for h in holders():
        bank = bank_of(h)
        lines = bank_lines(h)[0]
        scope = None
        for i, line in enumerate(lines):
            m = _GLOBAL_RE.match(line)
            if m:
                scope = m.group(1)
                continue
            m = re.match(r"^(\w+)?(\.\w+):", line)
            if not m or "loop" not in m.group(2).lower():
                continue
            owner = m.group(1) or scope
            key = (owner, m.group(2))
            if key in seen or owner in KNOWN_LOOP_NAMES:
                continue
            seen.add(key)
            n += 1
            full = re.compile(rf"\b{owner}{re.escape(m.group(2))}\b")
            short = re.compile(rf"(?<![\w.]){re.escape(m.group(2))}\b")
            inside = True
            for later in lines[i + 1:]:
                if _GLOBAL_RE.match(later):
                    inside = False
                    continue
                code = later.split(";")[0]
                if full.search(code) or inside and short.search(code):
                    break
            else:
                fail("loops", f"${bank:02x}: {owner}{m.group(2)} is never branched back to")
                continue
            if not _loops_back(lines, i, owner, m.group(2)):
                fail("loops", f"${bank:02x}: {owner}{m.group(2)} runs to an exit without branching back")
    return n


_LOOP_BRANCH_RE = re.compile(r"^\s*(jr|jp|as_jump)\s+(?:(nz|z|nc|c)\s*,\s*)?([\w.]+)\s*$")
_LOOP_EXIT_RE = re.compile(r"^\s*(ret|reti|as_halt|as_end)\s*$")


def _loops_back(lines, start, owner, local):
    """Some path through the routine from `start` reaches a branch to the
    label, or leaves through a computed jump (jp hl) that might."""
    labels = {}
    scope = None
    for k, line in enumerate(lines):
        g = _GLOBAL_RE.match(line)
        if g:
            scope = g.group(1)
            labels[scope] = k
            continue
        lm = re.match(r"^(\w+)?(\.\w+):", line)
        if lm:
            labels[(lm.group(1) or scope) + lm.group(2)] = k
    target = labels[owner + local]
    todo, seen = [start + 1], set()
    while todo:
        k = todo.pop()
        while k < len(lines) and k not in seen:
            seen.add(k)
            code = lines[k].split(";")[0]
            if re.search(r"\bjp\s+(hl|\[)|^\s*(rst|jumptable)\b", code):
                return True
            b = _LOOP_BRANCH_RE.match(code)
            if b:
                name = b.group(3)
                dest = labels.get(owner + name if name.startswith(".") else name)
                if dest == target:
                    return True
                if dest is not None:
                    todo.append(dest)
                if not b.group(2):
                    break
            elif _LOOP_EXIT_RE.match(code):
                break
            else:
                for ref in re.findall(r"(?<![\w.])(\.\w+)\b", code):
                    if labels.get(owner + ref) == target:
                        return True
                    if owner + ref in labels:
                        todo.append(labels[owner + ref])
            k += 1
    return False


# Locals whose names hold despite the checks: (routine, local) -> why.
KNOWN_LOCAL_NAMES = {
    ("RecordDrillPointResultBits", ".storeBits"): "the store follows .rotateLoop",
    ("Unused_18_InitPlayerRecordForCharacter", ".storeRecord"): "the stores follow .partnerSlot",
}
_END_LOCAL_RE = re.compile(r"\.(?:done|exit|finish)\d*$")
# End locals entered only by a jump that run a scene: (routine, local) -> why.
KNOWN_END_SCENES = {
    ("TrainingCourtNpc07_15", ".done"): "the all-lessons-done line",
    ("TrainingCourtNpc12_15", ".done"): "the all-lessons-done line",
    ("TrainingCourtNpc0D_15", ".done"): "the all-lessons-done line",
    ("WaterSpriteSwingContestScene", ".finish"): "the contest's end, left from its swing loop",
}
_END_SCENE_RE = re.compile(r"(?:script_(?:set_text|speak\w*|move\w*|set_position|face\w*|follow|set_anim)"
                           r"|farcall (?:RunDialogueYesNoPrompt|WaitPlayerMoveDone))\b")
_UNCOND_EXIT_RE = re.compile(r"(?:ret|reti|as_end|as_halt|jumptable\b.*|(?:jr|jp) (?!(?:nz|z|nc|c),).*|d[bw] .*)")
# Yes/no branches whose target names hold anyway: (routine, target) -> why.
KNOWN_YES_NO_NAMES = {
    ("PromptChallengeRankingOpponent", ".declined"): "yes confirms the decline",
}
_YES_NAME_RE = re.compile(r"\.(?:accepted|yes)")
_NO_NAME_RE = re.compile(r"\.(?:declined|no(?![a-z])|refuse)")
_STORE_LOCAL_RE = re.compile(r"\.store(?![a-z])")
_STORE_RE = re.compile(r"^\s*(?:ldh?\s+\[|ld\s+\[|(?:inc|dec)\s+\[hl\]|(?:set|res)\s+\w+\s*,\s*\[hl\])")
_CHECK_LOCAL_RE = re.compile(r"\.check([A-Z]\w*?)\d*$")
# Locals whose return value contradicts their name, but hold anyway: (routine, local) -> why.
KNOWN_RETURN_NAMES = {
    ("EraseStorySlotSaveData", ".ok"): "a status code: 0 is success, .badSlot returns 1",
    ("LookupMinigameShotResult", ".noMatch"): "a is the score, 1 point when no rule matches",
}
_POS_WORDS = {"busy", "found", "reached", "pending", "selected", "yes", "accepted", "success", "valid", "taken",
              "ok", "hit", "active", "ready", "true", "allowed"}
_NEG_WORDS = {"none", "idle", "fail", "failed", "empty", "invalid", "miss", "missed", "false", "free", "skip",
              "declined", "inactive"}


def check_local_names(fail):
    """A `.done` / `.exit` / `.finish` local reaches no branch back to an
    earlier local of its routine (it is a next-item step, not the end), and a
    `.check<Var>` local, where w<Var> or h<Var> is a RAM symbol, names that
    symbol within its first three instructions, before any branch, and a
    `.store*` local writes memory before another label, ret or jump. A
    `.done` / `.exit` / `.finish` local the line above does not fall into
    runs no dialogue, movement or prompt macro before it leaves. The `jr z`
    target after a yes/no prompt is not named as a no, nor the `jr nz` one
    as a yes, and a local's constant 0 / 1 return agrees with its name."""
    ram = {name for _, addr, name in read_sym() if addr >= 0x8000 and "." not in name}
    ram |= set(re.findall(r"^def (\w+) equ", (ROOT / "include" / "ram_mirrored.inc").read_text(), re.M))
    n, seen, yes_no_used, return_used = 0, set(), set(), set()
    for h in holders():
        bank = bank_of(h)
        lines = bank_lines(h)[0]
        n += _yes_no_branch_names(fail, bank, lines, yes_no_used)
        n += _return_value_names(fail, bank, lines, return_used)
        labels, scope = {}, None
        for k, line in enumerate(lines):
            g = _GLOBAL_RE.match(line)
            if g:
                scope = g.group(1)
                labels[scope] = k
                continue
            lm = re.match(r"^(\w+)?(\.\w+):", line)
            if lm:
                labels[(lm.group(1) or scope) + lm.group(2)] = k
        scope = None
        for i, line in enumerate(lines):
            g = _GLOBAL_RE.match(line)
            if g:
                scope = g.group(1)
                continue
            m = re.match(r"^(\w+)?(\.\w+):", line)
            if not m:
                continue
            owner, local = m.group(1) or scope, m.group(2)
            key = (owner, local)
            if (bank, key) in seen:
                continue
            if _END_LOCAL_RE.match(local):
                seen.add((bank, key))
                n += 1
                back = _branches_back(lines, i, owner, labels)
                if back and key not in KNOWN_LOCAL_NAMES:
                    fail("localnames", f"${bank:02x}: {owner}{local} branches back to {back}")
                elif not back and key in KNOWN_LOCAL_NAMES:
                    fail("localnames", f"{owner}{local} no longer branches back -- drop it from KNOWN_LOCAL_NAMES")
                scene = _jump_only_scene(lines, i)
                if scene and key not in KNOWN_END_SCENES:
                    fail("localnames", f"${bank:02x}: {owner}{local} is entered only by a jump and runs {scene}"
                                       " -- a branch or scene name?")
                elif not scene and key in KNOWN_END_SCENES:
                    fail("localnames", f"{owner}{local} no longer runs a scene -- drop it from KNOWN_END_SCENES")
                continue
            if _STORE_LOCAL_RE.match(local):
                seen.add((bank, key))
                n += 1
                stores = _reaches_store(lines, i, owner, labels)
                if not stores and key not in KNOWN_LOCAL_NAMES:
                    fail("localnames", f"${bank:02x}: {owner}{local} reaches no store")
                elif stores and key in KNOWN_LOCAL_NAMES:
                    fail("localnames", f"{owner}{local} now stores -- drop it from KNOWN_LOCAL_NAMES")
                continue
            c = _CHECK_LOCAL_RE.match(local)
            if not c:
                continue
            syms = [p + c.group(1) for p in "wh" if p + c.group(1) in ram]
            if not syms:
                continue
            seen.add((bank, key))
            n += 1
            body = []
            for later in lines[i + 1:]:
                code = later.split(";")[0].strip()
                if not code or code.endswith(":"):
                    continue
                body.append(code)
                if len(body) == 3 or re.match(r"(jr|jp|call|ret)\b", code):
                    break
            named = any(re.search(rf"\b{s}\b", b) for s in syms for b in body)
            if not named and key not in KNOWN_LOCAL_NAMES:
                fail("localnames", f"${bank:02x}: {owner}{local} does not read {syms[0]}")
            elif named and key in KNOWN_LOCAL_NAMES:
                fail("localnames", f"{owner}{local} now reads {syms[0]} -- drop it from KNOWN_LOCAL_NAMES")
    for key in KNOWN_RETURN_NAMES.keys() - return_used:
        fail("localnames", f"{key[0]}{key[1]} no longer contradicts its return value -- drop it from KNOWN_RETURN_NAMES")
    for key in KNOWN_YES_NO_NAMES.keys() - yes_no_used:
        fail("localnames", f"{key[0]}{key[1]} is no longer a misnamed yes/no branch -- drop it from KNOWN_YES_NO_NAMES")
    return n


def _straight_return(lines, start, labels, owner):
    """The constant a (0 or 1) a local's straight-line path returns with, or
    None: the path follows fall-through and unconditional local jumps and
    gives up at a conditional branch, call or macro."""
    k, val, seen = start + 1, None, set()
    while k < len(lines) and k not in seen:
        seen.add(k)
        code = lines[k].split(";")[0].strip()
        k += 1
        if not code or code.endswith(":"):
            continue
        if code == "ret":
            return val
        if m := re.fullmatch(r"j[rp] (\.\w+)", code):
            k = labels.get(owner + m.group(1))
            if k is None:
                return None
            continue
        if code in ("xor a", "ld a, $00", "ld a, 0"):
            val = 0
        elif code in ("ld a, $01", "ld a, 1"):
            val = 1
        elif re.fullmatch(r"(?:pop (?:bc|de|hl)|push (?:af|bc|de|hl)|ld [bcdehl], [bcdehl]|ld \[\w+(?: \+ \w+)?\], a|nop)", code):
            continue
        elif re.fullmatch(r"(?:ldh?|inc|dec|add|adc|sub|sbc|and|or|xor|cpl|rlca|rrca|rla|rra|swap|res|set|bit|cp) .*", code) \
                and not re.match(r"(?:ldh? a|inc a|dec a|add|adc|sub|sbc|and|or|xor|cpl|rlca|rrca|rla|rra|swap a|pop af)\b", code):
            continue
        else:
            return None
    return None


def _name_words(local):
    words = [w.lower() for w in re.findall(r"[a-z]+|[A-Z][a-z]*", local[1:])]
    if words and words[0] in ("clear", "reset", "set", "mark", "store", "check", "test"):
        return False, False
    neg = bool(words) and (words[0] in ("no", "not") or any(w in _NEG_WORDS for w in words))
    pos = not neg and any(w in _POS_WORDS for w in words)
    return pos, neg


def _return_value_names(fail, bank, lines, used):
    """A local whose straight-line path returns a = 0 is not named as a
    positive (busy, found, ...), nor one returning a = 1 as a negative (none,
    idle, notFound, ...)."""
    labels, scope, locs = {}, None, []
    for k, line in enumerate(lines):
        if g := _GLOBAL_RE.match(line):
            scope = g.group(1)
            labels[scope] = k
            continue
        if lm := re.match(r"^(\w+)?(\.\w+):", line):
            key = (lm.group(1) or scope, lm.group(2))
            labels[key[0] + key[1]] = k
            locs.append((k, key))
    n = 0
    for k, key in locs:
        pos, neg = _name_words(key[1])
        if not (pos or neg):
            continue
        val = _straight_return(lines, k, labels, key[0])
        if val is None:
            continue
        n += 1
        if (val == 0 and pos) or (val == 1 and neg):
            used.add(key)
            if key not in KNOWN_RETURN_NAMES:
                fail("localnames", f"${bank:02x}: {key[0]}{key[1]} returns a = {val}")
    return n


def _yes_no_branch_names(fail, bank, lines, used):
    """RunDialogueYesNoPrompt returns 0 for yes: the `and a` / `jr z` target
    after it is not a no name, nor the `jr nz` target a yes name."""
    n, scope = 0, None
    for i, line in enumerate(lines):
        if g := _GLOBAL_RE.match(line):
            scope = g.group(1)
            continue
        if "farcall RunDialogueYesNoPrompt" not in line:
            continue
        for later in lines[i + 1:]:
            code = later.split(";")[0].strip()
            if not code or code == "and a" or not re.match(r"(?:j[rp]|ret)\b|[\w.]+:", code):
                continue
            m = re.fullmatch(r"j[rp] (n?z), (\w*)(\.\w+)", code)
            if m:
                n += 1
                key = (m.group(2) or scope, m.group(3))
                wrong = _NO_NAME_RE if m.group(1) == "z" else _YES_NAME_RE
                if wrong.match(key[1]):
                    used.add(key)
                    if key not in KNOWN_YES_NO_NAMES:
                        fail("localnames", f"${bank:02x}: {key[0]}{key[1]} is the {'yes' if m.group(1) == 'z' else 'no'}"
                                           " branch of a yes/no prompt")
            break
    return n


def _jump_only_scene(lines, start):
    """The first dialogue, movement or prompt macro a local runs before it
    leaves, when the line above it does not fall into it; else None."""
    for prev in reversed(lines[:start]):
        code = prev.split(";")[0].strip()
        if not code:
            continue
        if code.endswith(":") or not _UNCOND_EXIT_RE.fullmatch(code):
            return None
        break
    for later in lines[start + 1:]:
        if _GLOBAL_RE.match(later):
            return None
        code = later.split(";")[0].strip()
        if m := _END_SCENE_RE.match(code):
            return m.group(0)
        if _UNCOND_EXIT_RE.fullmatch(code):
            return None
    return None


def _reaches_store(lines, start, owner, labels):
    """Flow from `start` writes memory before it falls into another label or
    leaves by ret or jump; conditional branches are stepped over and
    unconditional jumps to the routine's locals followed."""
    k, seen = start + 1, set()
    while k < len(lines) and k not in seen:
        seen.add(k)
        if re.match(r"^[\w.]+:", lines[k]):
            return False
        code = lines[k].split(";")[0]
        if _STORE_RE.match(code):
            return True
        b = _LOOP_BRANCH_RE.match(code)
        if b and not b.group(2):
            name = b.group(3)
            full = owner + name if name.startswith(".") else name
            if not full.startswith(owner + ".") or full not in labels:
                return False
            k = labels[full] + 1
            continue
        if _LOOP_EXIT_RE.match(code) or re.match(r"\s*(jp\s+hl|rst|jumptable)\b", code):
            return False
        k += 1
    return False


def _branches_back(lines, start, owner, labels):
    """The first earlier local of `owner` that some path from `start`
    branches to, following branches within the routine."""
    todo, seen = [start + 1], set()
    while todo:
        k = todo.pop()
        while k < len(lines) and k not in seen:
            seen.add(k)
            if _GLOBAL_RE.match(lines[k]):
                break
            code = lines[k].split(";")[0]
            b = _LOOP_BRANCH_RE.match(code)
            refs = [b.group(3)] if b else re.findall(r"(?<![\w.])(\.\w+)\b", code)
            for name in refs:
                full = owner + name if name.startswith(".") else name
                if not full.startswith(owner + ".") or full not in labels:
                    continue
                dest = labels[full]
                if dest <= start:
                    return full[len(owner):]
                todo.append(dest)
            if b and not b.group(2) or _LOOP_EXIT_RE.match(code):
                break
            k += 1
    return None


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
        "lz-names": check_unmarked_lz(rom, manifest, fail),
        "regions": check_regions(manifest, fail),
        "text": check_text_regions(rom, manifest, fail),
        "db-words": check_db_pointers(manifest, fail),
        "addr-words": check_addr_shaped(rom, manifest, fail),
        "records": check_record_tails(rom, fail),
        "layout": check_layout(manifest, fail),
        "sound": check_sound(rom, manifest, fail),
        "traj": check_traj(rom, manifest, fail),
        "macros": check_macro_kinds(rom, manifest, fail),
        "scopes": check_stranded_scopes(fail),
        "labels": check_label_scopes(fail),
        "headers": check_region_headers(fail),
        "branches": check_collapsed_branches(fail),
        "literals": check_literal_pointers(fail) + check_blob_pointers(rom, manifest, fail),
        "dma": check_dma_alignment(fail),
        "gfx": check_gfx(manifest, fail),
        "gfx-specs": check_gfx_specs(rom, manifest, fail),
        "tilemap": check_tilemaps(manifest, fail),
        "slots": actorslots.check(fail),
        "reach": reach.check(fail),
        "unnamed": reach.check_unnamed(fail),
        "entries": routes.check(fail),
        "raw-ids": check_raw_ids(fail),
        "fields": check_field_offsets(fail),
        "templates": check_sprite_templates(fail),
        "loops": check_loop_labels(fail),
        "localnames": check_local_names(fail),
        "mirrors": check_mirrored_operands(fail),
        "wram-ptrs": check_wram_pointers(fail),
    }
    by_check = {}
    for check, msg in failures:
        by_check.setdefault(check, []).append(msg)
    for name, n in counts.items():
        bad = by_check.get(name, [])
        if isinstance(n, Skipped):
            print(f"{name:10s} skipped: {n}")
            continue
        print(f"{name:10s} {n:5d} checked, {len(bad)} failed")
        for msg in bad[:10]:
            print(f"    {msg}")
        if len(bad) > 10:
            print(f"    ... and {len(bad) - 10} more")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())

"""Rendering carved data tables as structured source.

Each renderer takes a proven region and returns source lines -- macro calls,
dw label references, annotated db rows -- that assemble back to the exact
bytes. Which renderer runs is declared per offset in data_tables.json.
"""
from .constants import (ACTOR_FACING_NAMES, CHAR_ROSTER, FACING_MASK_NAMES,
                        MAP_TREE_SLOTS, STORY_LOCATION_NAMES)
from .rom import BANK_SIZE, offset_to_cpu
from .textids import text_id_name


def render_enum_table(data, val2name, cols):
    """Render a byte table as rows of `cols` named constants (falling back to a
    bare $xx for any value with no constant), with the row's byte offset."""
    out = []
    for i in range(0, len(data), cols):
        row = data[i:i + cols]
        items = ", ".join(val2name.get(b, f"${b:02x}") for b in row)
        out.append(f"\tdb {items} ; {i:#04x}")
    return out


# Actor-script opcode -> (macro, operand kinds). 'b' = byte, 'w' = little-endian
# word, 'rel' = signed rel16 jump (relative to the operand address). Instruction
# size is 1 + sum(operand widths). Handlers live in bank $04 at the addresses in
# the comments; see MACROS_INC / docs/actor_script.md.
ACTOR_SCRIPT_OPS = {
    0x00: ("as_halt", []),          0x01: ("as_wait", ["b"]),
    0x02: ("as_wait_move", []),     0x03: ("as_set_pos", ["w", "w"]),
    0x04: ("as_set_target", ["w", "w"]), 0x05: ("as_halt5", []),
    0x06: ("as_target_rel", ["w", "w"]), 0x07: ("as_move", ["b", "w"]),
    0x08: ("as_move_rel", ["b", "w"]), 0x09: ("as_rand_box", ["b", "b"]),
    0x0a: ("as_step", []),          0x0b: ("as_follow_wp", []),
    0x0c: ("as_jump", ["rel"]),     0x0d: ("as_set_field", ["b", "w"]),
    0x0e: ("as_add_field", ["b", "w"]), 0x0f: ("as_halt15", []),
    0x10: ("as_anim", ["b"]),       0x11: ("as_sound", ["b"]),
    0x12: ("as_call", ["w"]),       0x13: ("as_begin_path", []),
    0x14: ("as_wait_move2", []),    0x15: ("as_flag", ["b", "b", "b"]),
}
ACTOR_SCRIPT_SIZE = {
    op: 1 + sum(2 if k in ("w", "rel") else 1 for k in spec)
    for op, (_m, spec) in ACTOR_SCRIPT_OPS.items()
}


def decode_actor_script(rom, start, end, labels=None):
    """Linearly decode the actor-script prefix of a blob into (instrs, targets,
    consumed). instrs is [(off, opcode, operand_bytes)]; targets is the set of
    in-prefix offsets that as_jump lands on (for local labels); consumed is the
    byte length of the decoded prefix. Decoding stops at the first byte that is
    not a valid opcode (or would overrun), so a script followed by an
    unclassified tail decodes up to the tail. Returns None if nothing decodes,
    or if an as_jump escapes to somewhere that is neither an in-prefix
    instruction boundary nor a known (curated) script label -- then the whole
    region is left unclassified. `labels` lets a jump cross into another
    labelled entry point of an overlapping script (rendered as a global ref)."""
    labels = labels or {}
    off, instrs, targets = start, [], set()
    while off < end:
        op = rom[off]
        if op not in ACTOR_SCRIPT_SIZE:
            break
        size = ACTOR_SCRIPT_SIZE[op]
        if off + size > end:
            break
        operand = rom[off + 1:off + size]
        instrs.append((off - start, op, operand))
        if op == 0x0c:
            rel = int.from_bytes(operand, "little", signed=True)
            targets.add((off + 1 - start) + rel)
        off += size
    consumed = off - start
    if not instrs:
        return None
    boundaries = {o for o, _, _ in instrs}
    for t in targets:
        internal = 0 <= t < consumed and t in boundaries
        if not (internal or (start + t) in labels):
            return None
    return instrs, targets, consumed


def render_actor_script(rom, start, end, bank, labels):
    """Render an actor-script bytecode blob as as_* macro calls, returning
    (rows, consumed). `consumed` is the decoded prefix length; when it is less
    than end-start the caller emits the remaining bytes as an unclassified tail.
    An as_jump into this segment becomes a local label (.L<off>); one that
    crosses into another labelled entry point emits that global label (execution
    falls through / jumps between the overlapping fragments of a shared script).
    as_call pointers resolve to a same-bank label when one exists. The parent
    label is emitted by the caller."""
    base = bank * BANK_SIZE
    decoded = decode_actor_script(rom, start, end, labels)
    if decoded is None:
        return None
    instrs, targets, consumed = decoded
    local = {t for t in targets if 0 <= t < consumed and (start + t) not in labels}
    out = []
    for off, op, operand in instrs:
        if off in local:
            out.append(f".L{off:x}:")
        macro, kinds = ACTOR_SCRIPT_OPS[op]
        args, i = [], 0
        for k in kinds:
            if k == "b":
                args.append(f"${operand[i]:02x}")
                i += 1
            elif k == "w":
                word = operand[i] | (operand[i + 1] << 8)
                ref = None
                if op == 0x12 and 0x4000 <= word < 0x8000:
                    ref = labels.get(base + word - 0x4000)
                elif op == 0x0d and args and args[0] == "$14":
                    # as_set_field $14 (the actor facing field) -> FACE_* value
                    ref = ACTOR_FACING_NAMES.get(word)
                args.append(ref or f"${word:04x}")
                i += 2
            elif k == "rel":
                rel = int.from_bytes(operand, "little", signed=True)
                tgt = off + 1 + rel
                args.append(labels.get(start + tgt) or f".L{tgt:x}")
                i += 2
        out.append(f"\t{macro} {', '.join(args)}" if args else f"\t{macro}")
    return out, consumed


def render_sprite_anim(rom, start, end):
    """A character animation script: mostly 2-byte entries, low byte a frame
    index or a command ($ff loop, $fe switch animation, $fb flip), high byte its
    operand.

    The hold command is one byte, not two. Both interpreters
    (StepCharAnimation $08:$77a8, AdvanceActorAnimation $04) fall through every
    command test to "set the delay to $ff and keep the current frame" without
    reading an operand, so any $f0-$fd other than $fb ends the script on the
    frame it is showing. That is why 211 of the 570 declared scripts used to
    fall back to `db`: a one-byte command leaves the rest of the region at an
    odd offset, and a script that is *only* a hold is an odd length outright.

    Still returns None for anything it cannot account for, so a mis-declared
    region falls back to plain bytes rather than rendering a lie."""
    out = []
    off = start
    held = False
    while off < end:
        op = rom[off]
        if 0xF0 <= op <= 0xFD and op != 0xFB:
            out.append(f"\tanim_hold ${op:02x}")
            off += 1
            held = True
            continue
        if off + 1 >= end:
            # Two shapes the data was authored in. A script written as pairs
            # ends `$fd, $00`: the hold is one byte to the interpreter, so
            # its "operand" is never read. And the five-byte walk script
            # `03 14 04 1e ff` ends on a bare loop command whose operand is
            # the first byte of the script that follows (always $00, a
            # frame-0 entry): the interpreter reads it, so the loop restarts
            # at +0, but the byte belongs to the next script's label.
            if held:
                out.append(f"\tdb ${op:02x} ; never read: the hold above ends the script")
                return out
            if op == 0xFF and end < len(rom):
                out.append(f"\tdb $ff ; anim_loop whose operand is the next"
                           f" script's first byte (${rom[end]:02x})")
                return out
            return None
        held = False
        arg = rom[off + 1]
        if op < 0xF0:
            out.append(f"\tanim_frame ${op:02x}, ${arg:02x}")
        elif op == 0xFF:
            out.append(f"\tanim_loop ${arg:02x}")
        elif op == 0xFE:
            out.append(f"\tanim_set ${arg:02x}")
        else:  # $fb
            out.append(f"\tanim_flip ${arg:02x}")
        off += 2
    return out


def render_ptr_records(rom, seg, end, stride, ptr_off, bank, labels):
    """Fixed-stride byte records with one embedded same-bank pointer at
    `ptr_off`: the byte fields render as `db`, the pointer as a `dw` label
    (raw when its target carries none). Spec form `records:<stride>:ptr<off>`,
    e.g. the bank $18 spawn tables, whose +$09 word is the per-object
    movement callback TaskUpdateObjects_18 dispatches through."""
    out = [f"; {(end - seg) // stride} records x {stride} bytes"
           f" (dw callback at +${ptr_off:x})"]
    for r in range(0, end - seg - stride + 1, stride):
        b = rom[seg + r:seg + r + stride]
        n = r // stride
        if ptr_off:
            out.append("\tdb " + ", ".join(f"${x:02x}" for x in b[:ptr_off])
                       + f" ; record {n}")
        w = b[ptr_off] | (b[ptr_off + 1] << 8)
        tgt = bank * 0x4000 + w - 0x4000 if 0x4000 <= w < 0x8000 else None
        out.append("\tdw " + (labels.get(tgt) or f"${w:04x}"))
        tail = b[ptr_off + 2:]
        if tail:
            out.append("\tdb " + ", ".join(f"${x:02x}" for x in tail))
    rem = (end - seg) % stride
    if rem:
        out.append("\tdb " + ", ".join(f"${x:02x}" for x in rom[end - rem:end]))
    return out


def render_drill_definition(rom, seg, end, bank, labels):
    """A training-drill definition for `StartDrillFromDefinition` ($0b:$4002):
    8 setup bytes then three same-bank pointers (mode hooks, point table, and
    an optional init routine run through JumpToHL), padded to 16."""
    out = []
    for r in range(0, end - seg, 16):
        b = rom[seg + r:seg + r + 16]
        if len(b) < 14:
            out.append("\tdb " + ", ".join(f"${x:02x}" for x in b))
            break
        out.append("\tdb " + ", ".join(f"${x:02x}" for x in b[:8])
                   + " ; opponent, court, chars, mode, story, bgm, -, player")
        refs = []
        for k in (8, 10, 12):
            w = b[k] | (b[k + 1] << 8)
            tgt = (bank * 0x4000 + w - 0x4000 if 0x4000 <= w < 0x8000
                   else None)
            refs.append(labels.get(tgt) or f"${w:04x}")
        out.append(f"\tdw {refs[0]}, {refs[1]}, {refs[2]}"
                   " ; mode hooks, point table, init")
        if len(b) > 14:
            out.append("\tdb " + ", ".join(f"${x:02x}" for x in b[14:]))
    return out


def render_actor_list(rom, seg, end, bank, labels):
    """A spawn list for `SpawnActorFromTemplate` ($04:$4c60): 14-byte records
    of {flag condition, script, x, y, facing, -, obj def, anim, extra, -}.
    `SpawnActorsFromList` copies 14 bytes per step and stops on a record whose
    byte 9 is $ff, so the stored terminator is only the 10 bytes up to it."""
    out, p, n = [], seg, 0
    while p < end:
        if end - p < 14 or rom[p + 9] == 0xFF:
            out.append("\tdb " + ", ".join(f"${b:02x}" for b in rom[p:end])
                       + " ; list end")
            break
        w = [rom[p + i] | (rom[p + i + 1] << 8) for i in (0, 2, 4, 6)]
        tgt = (bank * 0x4000 + w[1] - 0x4000 if 0x4000 <= w[1] < 0x8000
               else None)
        out.append(f"\tdw ${w[0]:04x}, {labels.get(tgt) or f'${w[1]:04x}'}, "
                   f"${w[2]:04x}, ${w[3]:04x}"
                   f" ; actor {n}: cond, script, x, y")
        b = rom[p + 8:p + 14]
        face = ACTOR_FACING_NAMES.get(b[0], f"${b[0]:02x}")
        out.append(f"\tdb {face}, " + ", ".join(f"${x:02x}" for x in b[1:])
                   + " ; facing, -, obj def, anim, extra, -")
        p += 14
        n += 1
    return out


def render_map_table(spec, rom, seg, end, bank, labels, role=None,
                     loc_names=None):
    """Render a story-mode map-script sub-table (map_actor/map_entry/
    map_script) as macro calls. Pointer fields (actor object defs, entry
    arrival scripts, script handlers/conditions) resolve to same-bank labels;
    positions and ids stay literal. Records run until the table's terminator
    ($ff), which plus any padding is emitted as raw db.

    One spec, `map_scripts`, covers four of the seven map_tree slots, and what
    a record's two trailing argument bytes mean is the slot's business, not the
    spec's -- so the slot is declared as a `role` (`map_scripts:exit`). Only
    role `exit` is defined: a map_tree's slot 1 is its ExitTriggers table by
    construction (MAP_TREE_SLOTS), and RunLocationExit ($0a:$5637) copies such
    a record's `arg0` straight into wStoryModeCurrentLocation, so that byte is
    a location id and nothing else. `arg1` goes to wStoryModeEntryPoint, an
    index into the *destination's* map_entry list -- a different id space, so it
    stays numeric."""
    if role not in (None, "exit"):
        raise ValueError(f"unknown map table role {role!r}")
    if role == "exit" and not loc_names:
        raise ValueError("map_scripts:exit needs the STORYLOC_* name map")
    base = bank * BANK_SIZE

    def word(o):
        return rom[o] | (rom[o + 1] << 8)

    def sym(o):
        v = word(o)
        if 0x4000 <= v < 0x8000 and base + v - 0x4000 in labels:
            return labels[base + v - 0x4000]
        return f"${v:04x}"

    def facing(v):
        return ACTOR_FACING_NAMES.get(v, f"${v:02x}")

    def facemask(v):
        return FACING_MASK_NAMES.get(v, f"${v:02x}")

    out, p = [], seg
    if spec == "map_tree":
        for r, role in enumerate(MAP_TREE_SLOTS):
            v = word(seg + r * 2)
            tgt = base + v - 0x4000 if 0x4000 <= v < 0x8000 else None
            ref = labels.get(tgt) if tgt else None
            out.append(f"\tdw {ref or f'${v:04x}'} ; slot {r} {role}")
        return out
    if spec == "map_actors":
        # A slot may hold several back-to-back actor lists (runtime-selected
        # variants), each ended by the 9x$00 + $ff sentinel the engine stops on
        # (SpawnActorsFromList $04:$4d10 halts when a record's byte +9 is $ff).
        # Emit every list until a run that isn't a clean sentinel is reached.
        def emit_actors():
            nonlocal p
            while p + 14 <= end and rom[p + 9] != 0xFF:
                out.append(f"\tmap_actor {sym(p)}, {sym(p + 2)}, ${word(p + 4):04x}, "
                           f"${word(p + 6):04x}, {facing(rom[p + 8])}, ${rom[p + 10]:02x}, "
                           f"${rom[p + 11]:02x}, ${rom[p + 12]:02x}")
                p += 14
        emit_actors()
        while p + 10 <= end and rom[p:p + 10] == b"\x00" * 9 + b"\xff":
            out.append("\tmap_actor_end")
            p += 10
            emit_actors()
    elif spec == "map_entries":
        while p + 8 <= end and rom[p] != 0xFF:
            out.append(f"\tmap_entry ${rom[p]:02x}, {facing(rom[p + 1])}, "
                       f"${word(p + 2):04x}, ${word(p + 4):04x}, {sym(p + 6)}")
            p += 8
    elif spec == "map_scripts":
        while p + 8 <= end and rom[p] != 0xFF:
            # handler < $4000 is a dialogue text id (RunStoryScriptOrDialogue
            # $0a:$541d routes it to ShowSpeakerDialogue), not a code pointer.
            handler = sym(p + 4)
            if handler.startswith("$"):
                handler = text_id_name(word(p + 4)) or handler
            arg0 = f"${rom[p + 6]:02x}"
            if role == "exit":
                arg0 = loc_names.get(rom[p + 6], arg0)
            out.append(f"\tmap_script ${rom[p]:02x}, {facemask(rom[p + 1])}, "
                       f"{sym(p + 2)}, {handler}, {arg0}, "
                       f"${rom[p + 7]:02x}")
            p += 8
    pad = spec == "map_actors" and p < end and not any(rom[p:end])
    while p < end:
        n = min(end - p, 8)
        out.append("\tdb " + ", ".join(f"${rom[p + k]:02x}" for k in range(n))
                   + (" ; padding after the list end" if pad else ""))
        p += n
    return out


def render_tilemap_scripts(rom, start, end):
    """Render the match-result tilemap-copy scripts (routine at $16:$4a71). A
    self-delimiting dw pointer table (one entry per result layout, selected by
    wCurrentMinigameStoryMatch's low byte at $c8f7) precedes a run of
    variable-length copy lists. Each list is a run of 5-byte `tilemap_copy
    dest, src, rows` records ended by an all-zero record (`tilemap_copy_end`):
    the routine stops when a record's dest word is $0000, and walks farcalling
    CopyTilemapRect (width fixed at 2 tiles) per record. Pointers become
    `.scriptN` local labels so they track their list bodies."""
    base = offset_to_cpu(start)
    first = rom[start] | (rom[start + 1] << 8)
    nptr = (first - base) // 2
    labels_at = {}
    out = []
    for i in range(nptr):
        v = rom[start + i * 2] | (rom[start + i * 2 + 1] << 8)
        labels_at.setdefault(v, []).append(i)
        out.append(f"\tdw .script{i} ; {i}")

    o = start + nptr * 2
    while o < end:
        for i in labels_at.get(offset_to_cpu(o), []):
            out.append(f".script{i}:")
        dest = rom[o] | (rom[o + 1] << 8)
        if dest == 0:
            out.append("\ttilemap_copy_end")
        else:
            src = rom[o + 2] | (rom[o + 3] << 8)
            out.append(f"\ttilemap_copy ${dest:04x}, ${src:04x}, {rom[o + 4]}")
        o += 5
    return out


def render_tilemap_dispatch(rom, start, end):
    """Render the two-level tilemap-assembly dispatch ($39:$4e60, indexer at
    $39:$4e11). A self-delimiting L1 pointer table (indexed by b) points at L2
    pointer tables (indexed by c) that point at lists of 6-byte
    {src, dest, height, width} records ended by a height-0 record. L1/L2 tables
    become `.l2_N`/`.rl_N` locals; records render as `tilemap_rect` macros."""
    base = offset_to_cpu(start)
    end_cpu = base + (end - start)

    def flat(cpu):
        return start + (cpu - base)

    def w(cpu):
        f = flat(cpu)
        return rom[f] | (rom[f + 1] << 8)

    # L1 and the packed L2 region each self-delimit at their lowest target.
    p, lo, l1 = base, 0xFFFF, []
    while p < lo:
        v = w(p); l1.append(v); lo = min(lo, v); p += 2
    l1_end = p
    q, lo2 = l1_end, 0xFFFF
    while q < lo2:
        lo2 = min(lo2, w(q)); q += 2
    rec_start = lo2
    l2_idx = {a: i for i, a in enumerate(sorted(set(l1)))}
    rl_targets = {w(c) for c in range(l1_end, rec_start, 2)}
    rl_idx = {a: i for i, a in enumerate(
        sorted(a for a in rl_targets if rec_start <= a < end_cpu))}

    out = [f"\tdw .l2_{l2_idx[v]} ; {i}" for i, v in enumerate(l1)]
    cpu = l1_end
    while cpu < rec_start:
        if cpu in l2_idx:
            out.append(f".l2_{l2_idx[cpu]}:")
        t = w(cpu)
        out.append(f"\tdw {'.rl_%d' % rl_idx[t] if t in rl_idx else f'${t:04x}'}")
        cpu += 2
    while cpu < end_cpu:
        if cpu in rl_idx:
            out.append(f".rl_{rl_idx[cpu]}:")
        f = flat(cpu)
        if rom[f + 4] == 0:
            if any(rom[f:f + 6]):
                out.append("\tdb " + ", ".join(f"${b:02x}" for b in rom[f:f + 6]))
            else:
                out.append("\ttilemap_rect_end")
        else:
            out.append(f"\ttilemap_rect ${rom[f] | (rom[f+1]<<8):04x}, "
                       f"${rom[f+2] | (rom[f+3]<<8):04x}, "
                       f"${rom[f+4]:02x}, ${rom[f+5]:02x}")
        cpu += 6
    return out


def render_gfx_ptr_table(rom, start, end, bank, data_labels):
    """Render the match-result graphics selector ($16:$4e9d, loader $16:$4e54).
    A self-delimiting dw pointer table indexes 6-byte descriptor records, each
    three dw pointers to LZ tile streams (decompressed to VRAM $8900/$8a40/
    $9140). Pointers become `.recN` locals; each record is a `gfx_set` of the
    three streams, resolved to their Lz_* blob labels."""
    fbase = bank * BANK_SIZE
    base = offset_to_cpu(start)

    def word(o):
        return rom[o] | (rom[o + 1] << 8)

    def sym(v):
        return data_labels.get(fbase + v - BANK_SIZE, f"${v:04x}")

    rec_start = min(word(start), word(start + 2))
    nptr = (rec_start - base) // 2
    out = []
    for i in range(nptr):
        v = word(start + i * 2)
        out.append(f"\tdw .rec{(v - rec_start) // 6} ; {i}")
    o = start + nptr * 2
    while o < end:
        out.append(f".rec{(offset_to_cpu(o) - rec_start) // 6}:")
        out.append(f"\tgfx_set {sym(word(o))}, {sym(word(o + 2))}, "
                   f"{sym(word(o + 4))}")
        o += 6
    return out


def render_lz_ptr_table(rom, start, end, bank, data_labels, roster=None):
    """Render a direct LZ pointer table (e.g. $16:$60f1, $16:$6968): a dw table
    of pointers straight to LZ tile streams, indexed by the portrait variant /
    character id. Each entry resolves to its Lz_* blob label. With a roster
    (the char_lz_ptr_table spec), the index is a character id and each row is
    commented with the character it selects."""
    fbase = bank * BANK_SIZE
    out = []
    for i, o in enumerate(range(start, end, 2)):
        v = rom[o] | (rom[o + 1] << 8)
        idx = f"${i:02x} {roster[i]}" if roster and i < len(roster) else f"{i}"
        out.append(f"\tdw {data_labels.get(fbase + v - BANK_SIZE, f'${v:04x}')}"
                   f" ; {idx}")
    return out


def render_mugshot_ptr_table(rom, start, end, bank, data_labels):
    """Render bank $1b's menu mugshot table ($4cec, read by
    DecompressCharMugshot $4e5c as table[charId].gfx). Each record is
    {dw gfx stream, dw trailer}; word 1 is the same constant for every record
    (the two 4-byte trailers it aims at sit right after the last record) and no
    code reads it, so the records self-delimit: the table runs up to the lowest
    word-1 target. Word 0 resolves to the pool's Lz_/Mugshot* blob label, and
    each row is commented with the character whose id indexes it. Ids $40-$42
    are reached only through the $3f story-hero remap (id $3f + save slot + 1)
    and hold the slot's numeral badge; ids with no portrait share the "?"
    stream."""
    fbase = bank * BANK_SIZE
    base = offset_to_cpu(start)

    def word(o):
        return rom[o] | (rom[o + 1] << 8)

    def sym(v):
        return data_labels.get(fbase + v - BANK_SIZE, f"${v:04x}")

    trailer, o = 0x8000, start
    while o < end and offset_to_cpu(o) < trailer:
        trailer = min(trailer, word(o + 2))
        o += 4
    locals_ = {trailer: ".unused", trailer + 4: ".unusedAlt"}
    out = []
    for i in range((trailer - base) // 4):
        o = start + i * 4
        if i < len(CHAR_ROSTER):
            who = CHAR_ROSTER[i]
        elif i == 0x3F:
            who = "story hero (remapped to $40 + save slot)"
        elif i >= 0x40:
            who = f"story hero, save slot {i - 0x3F}"
        else:
            who = "no character"
        out.append(f"\tdw {sym(word(o))}, "
                   f"{locals_.get(word(o + 2), f'${word(o + 2):04x}')}"
                   f" ; ${i:02x} {who}")
    o = start + ((trailer - base) // 4) * 4
    while o < end:
        cpu = offset_to_cpu(o)
        if cpu in locals_:
            out.append(f"{locals_[cpu]}:")
            out.append(f"\tdw ${word(o):04x}, ${word(o + 2):04x}")
            o += 4
            continue
        out.append(".trailer: ; unreferenced")
        out.append("\tdw " + ", ".join(f"${word(p):04x}"
                                       for p in range(o, end - 1, 2)))
        o = end - (end - o) % 2
        break
    if o < end:
        out.append("\tdb " + ", ".join(f"${b:02x}" for b in rom[o:end]))
    return out


def render_object_header(rom, off, data_labels, ptr_labels):
    """Render a 16-byte sprite/object header as committed db/dw source: an
    OAM attribute byte, the facing count, two bytes neither loader reads,
    then six pointers into the record's body. Bank $04's loader copies these
    to $dad0 and expands them into an actor struct (word 0 -> +$24 the frame
    array, word 1 -> +$28 the animation-script pointer array, word 2
    dereferenced for an 8-byte subrecord, word 3 -> +$38). Being structural (a count and
    pointers, like the DataPtr table above it) they live in the source, not
    the gitignored data blobs. Body pointers resolve to the labels of the
    sub-blobs split_object_bodies() carved; the rest stay literal (they aim
    inside the header itself, or at another record)."""
    b = rom[off:off + 16]
    base = (off // BANK_SIZE) * BANK_SIZE

    def lbl(w):
        tgt = base + w - BANK_SIZE
        if tgt == off + 0x0A:  # the inline frame-pointer array (words 3-5+)
            return ".frames"
        return data_labels.get(tgt) or ptr_labels.get(tgt) or f"${w:04x}"

    w = [b[4 + 2 * i] | (b[5 + 2 * i] << 8) for i in range(6)]
    return [f"\tdb ${b[0]:02x}, ${b[1]:02x}, ${b[2]:02x}, ${b[3]:02x} ; OAM attr, facing count, unread, unread",
            f"\tdw {lbl(w[0])}, {lbl(w[1])}, {lbl(w[2])} ; frame array, anim scripts, frame array",
            ".frames:",
            f"\tdw {lbl(w[3])}, {lbl(w[4])}, {lbl(w[5])} ; frame pointers (continue in body)"]


def render_flag_ids(rom, start, end, flag_names=None):
    """A list of wGameFlags ids in the same encoding the rst $20/$28/$30
    pseudo-ops take: low byte = bit << 5, high byte = flag byte index. A named
    flag renders through the `flag_id` macro; the rest keep the raw word with
    the byte/bit spelled out the way `set_flag`/`test_flag` print it."""
    out = []
    for r in range((end - start) // 2):
        ro = start + r * 2
        lo, hi = rom[ro], rom[ro + 1]
        name = (flag_names or {}).get(hi * 8 + (lo >> 5))
        if name and not (lo == 0 and hi == 0):
            out.append(f"\tflag_id {name} ; {r}")
            continue
        note = ("none" if lo == 0 and hi == 0 else "end" if lo == hi == 0xFF
                else f"flag ${hi:02x}, {lo >> 5}")
        out.append(f"\tdw ${lo | (hi << 8):04x} ; {r}: {note}")
    if (end - start) % 2:
        out.append(f"\tdb ${rom[end - 1]:02x}")
    return out


def render_save_flag_ids(rom, start, end, save_flag_names=None):
    """A list of *save*-flag ids (the words Test/Set/ClearSaveFlag take in de:
    high byte = array byte, low byte = bit << 5). Renders each as its
    SAVEFLAG_* constant where constants.inc names one."""
    out = []
    for r in range((end - start) // 2):
        ro = start + r * 2
        w = rom[ro] | (rom[ro + 1] << 8)
        name = (save_flag_names or {}).get(w)
        note = f"{r}" if name else f"{r}: flag ${w >> 8:02x}, {(w & 0xff) >> 5}"
        out.append(f"\tdw {name or f'${w:04x}'} ; {note}")
    if (end - start) % 2:
        out.append(f"\tdb ${rom[end - 1]:02x}")
    return out


def render_text_ids(rom, start, end):
    """A dw table of dialogue text ids, one per story-progress step. Renders
    each as its `Text_<bank>_<index>` constant (an EQU of the same value), so
    the row says which string it selects; $0000 is the no-text sentinel."""
    out = []
    for r in range((end - start) // 2):
        w = rom[start + r * 2] | (rom[start + r * 2 + 1] << 8)
        name = text_id_name(w)
        out.append(f"\tdw {name or f'${w:04x}'} ; record {r}")
    return out


def render_number_words(rom, start, end, per_row):
    """A dw table of *numbers* -- a maths table, not pointers. Same rows as
    render_pointer_words without the label lookup, which is the whole point:
    in ROM0 that lookup resolves any word below $4000, so a tangent of $0040
    rendered as `dw VBlankInterrupt` and an APU note period as
    `dw ClearVRAMCopyQueue`. Both assemble to the right bytes and both are
    lies about what the table holds."""
    out, stride = [], 2 * per_row
    for r in range((end - start) // stride):
        ro = start + r * stride
        ws = [rom[ro + k * 2] | (rom[ro + k * 2 + 1] << 8) for k in range(per_row)]
        out.append("\tdw " + ", ".join(f"${w:04x}" for w in ws) + f" ; record {r}")
    for b in rom[start + (end - start) // stride * stride:end]:
        out.append(f"\tdb ${b:02x}")
    return out


def render_pointer_words(rom, start, end, bank, labels, spec):
    """A dw table of same-bank pointers (records:2 tables are usually pointer
    tables; mode_hooks and minigame_configs always are). Words that hit a
    labeled offset render symbolically -- the same bytes at link time."""
    out = []
    for r in range((end - start) // 2):
        ro = start + r * 2
        w = rom[ro] | (rom[ro + 1] << 8)
        tgt = (bank * BANK_SIZE + w - BANK_SIZE
               if bank and BANK_SIZE <= w < 0x8000 else None)
        # Every mode_hooks slot is a code pointer, so a ROM0 word is the
        # always-mapped bank 0 (the shared do-nothing `ret`), not a stray value.
        if tgt is None and w < BANK_SIZE and (not bank or spec == "mode_hooks"):
            tgt = w
        ref = labels.get(tgt) if tgt else None
        out.append(f"\tdw {ref or f'${w:04x}'} ; record {r}")
    if (end - start) % 2:
        out.append(f"\tdb ${rom[end - 1]:02x}")
    return out


def render_ram_ptrs(rom, start, end, ramnames, ramscoped, wram_bank, zero_name):
    """A dw table whose words are RAM addresses rather than ROM pointers.

    `render_pointer_words` only resolves ROM labels, and the scoped RAM names
    it would need cannot resolve themselves here: a `wram_bank` scope is a
    compute_wram_bank fact about a *code* site, and a data word has no
    dataflow. So the spec states the bank -- `ram_ptrs:<bank>[:<zero name>]` --
    and every word resolves against it. rgbasm folds the result back to the
    same value, so `make compare` still checks the arithmetic, and a screen's
    cell table stops reading as unrelated addresses.

    Bank `0` asserts nothing (WRAM bank 0 is not selectable: writing 0 to rWBK
    picks bank 1). Use it for an unbanked WRAM0 table, or where the union that
    covers the addresses is scoped by the referencing code's ROM bank instead
    -- that scope matches on the word's own offset and needs no assertion.

    A word that resolves to nothing stays numeric; that is the signal the
    declared bank is wrong, or that the table is not all addresses."""
    out = []
    for r in range((end - start) // 2):
        ro = start + r * 2
        w = rom[ro] | (rom[ro + 1] << 8)
        if w == 0 and zero_name:
            ref = zero_name
        else:
            ref = ramnames.get(w) if ramnames else None
            if not ref and ramscoped:
                ref = ramscoped.resolve(w, ro, wram_bank=wram_bank)
        out.append(f"\tdw {ref or f'${w:04x}'} ; record {r}")
    if (end - start) % 2:
        out.append(f"\tdb ${rom[end - 1]:02x}")
    return out


def render_slot_records(rom, start, end, nwords, slot_ref):
    """A record table of (bank<<8|slot) words into other banks' $4000 tables.
    Each record renders as a `dslot` line of slot labels, so the words track
    their targets' curated names; a record whose entries aren't all labeled dw
    slots falls back to numeric words."""
    stride = 2 * nwords
    out = []
    for r in range((end - start) // stride):
        ro = start + r * stride
        ws = [rom[ro + k * 2] | (rom[ro + k * 2 + 1] << 8) for k in range(nwords)]
        refs = [slot_ref(w) for w in ws]
        if all(refs):
            out.append("\tdslot " + ", ".join(refs) + f" ; record {r}")
        else:
            out.append("\tdw " + ", ".join(f"${w:04x}" for w in ws)
                       + f" ; record {r}")
    tail = (end - start) % stride
    if tail:
        out.append("\tdb " + ", ".join(f"${b:02x}" for b in rom[end - tail:end]))
    return out


def render_story_locations(rom, start, end, slot_ref):
    """6-byte records: {id, scene, slot, bank, bgm, $00}. The (slot, bank) pair
    references the target bank's $4000 map-script directory, so render it as a
    dslot (DataPtr_* label) when that slot is a known data-pointer entry."""
    out = []
    for r in range((end - start) // 6):
        b = rom[start + r * 6:start + r * 6 + 6]
        nm = (f" {STORY_LOCATION_NAMES[r]}"
              if r < len(STORY_LOCATION_NAMES) else "")
        sr = slot_ref(b[2] | (b[3] << 8))
        if sr and b[5] == 0:
            out.append(f"\tstory_location ${b[0]:02x}, ${b[1]:02x}, {sr}, "
                       f"${b[4]:02x} ; loc {r}{nm}")
        else:
            out.append("\tdb " + ", ".join(f"${x:02x}" for x in b)
                       + f" ; loc {r} ${b[3]:02x}:${BANK_SIZE + b[2]:04x}{nm}")
    tail = (end - start) % 6
    if tail:
        out.append("\tdb " + ", ".join(f"${x:02x}" for x in rom[end - tail:end]))
    return out


def render_location_entries(rom, start, end, loc_names):
    """2-byte (location id, entry point) records, ended by a $ff first byte.

    The same pair RunLocationExit builds from an ExitTriggers record, but stored
    directly: RunEndingCreditsSequence's walker ($0a:$6e9f-$6eb0) reads byte 0
    into wStoryModeCurrentLocation and byte 1 into wStoryModeEntryPoint. Only
    byte 0 is a STORYLOC_* id -- byte 1 indexes the destination's own map_entry
    list, so it stays numeric."""
    out, p, n = [], start, 0
    while p + 2 <= end and rom[p] != 0xFF:
        loc = loc_names.get(rom[p], f"${rom[p]:02x}")
        out.append(f"\tdb {loc}, ${rom[p + 1]:02x} ; {n}")
        p += 2
        n += 1
    while p < end:
        k = min(end - p, 8)
        out.append("\tdb " + ", ".join(f"${rom[p + i]:02x}" for i in range(k))
                   + (" ; list end" if p == start + n * 2 else ""))
        p += k
    return out


def render_rules_pages(rom, start, end, width):
    """Fixed-width $ff-padded lists of rules-screen page ids. The macro
    rebuilds the padding, so a list without a clean $ff tail stays literal."""
    out = [f"\trules_pages_stride {width}"]
    for r in range((end - start) // width):
        rec = rom[start + r * width:start + r * width + width]
        n = rec.index(0xFF) if 0xFF in rec else width
        if n == width or any(x != 0xFF for x in rec[n:]):
            out.append("\tdb " + ", ".join(f"${x:02x}" for x in rec)
                       + f" ; list {r}")
            continue
        pages = ", ".join(f"${x:02x}" for x in rec[:n])
        out.append(f"\trules_pages {pages} ; list {r}")
    tail = (end - start) % width
    if tail:
        out.append("\tdb " + ", ".join(f"${x:02x}" for x in rom[end - tail:end]))
    return out


def render_menu_def(rom, start, end, val2name):
    """8-byte menu records: up to 4 entry ids, a count, then zero padding. Only
    a well-formed record (count in range, unused id slots and the tail zeroed)
    can take the macro, which rebuilds both."""
    out = []
    for r in range((end - start) // 8):
        b = rom[start + r * 8:start + r * 8 + 8]
        cnt = b[4]
        if not (1 <= cnt <= 4 and not any(b[5:8]) and not any(b[cnt:4])):
            out.append("\tdb " + ", ".join(f"${x:02x}" for x in b)
                       + f" ; menu {r}")
            continue
        ids = ", ".join(val2name.get(x, f"${x:02x}") for x in b[:cnt])
        out.append(f"\tmenu_def {ids} ; menu {r}")
    tail = (end - start) % 8
    if tail:
        out.append("\tdb " + ", ".join(f"${x:02x}" for x in rom[end - tail:end]))
    return out


def render_rect_ptrs(rom, start, end, bank, labels):
    """4-byte items: a pointer to a tilemap block and one to its attribute
    block, both in this bank."""
    out = []
    for r in range((end - start) // 4):
        b = rom[start + r * 4:start + r * 4 + 4]
        refs = _same_bank_refs(bank, labels, b[0] | (b[1] << 8),
                               b[2] | (b[3] << 8))
        out.append(f"\trect_ptrs {refs[0]}, {refs[1]} ; item {r}")
    tail = (end - start) % 4
    if tail:
        out.append("\tdb " + ", ".join(f"${x:02x}" for x in rom[end - tail:end]))
    return out


def render_rect_pair(rom, start, end, bank, labels):
    """6-byte records: {height, width, tiles, attrs}; the two blocks live in
    the same bank, so they resolve to the tilemap/attrmap labels."""
    out = []
    for r in range((end - start) // 6):
        b = rom[start + r * 6:start + r * 6 + 6]
        refs = _same_bank_refs(bank, labels, b[2] | (b[3] << 8),
                               b[4] | (b[5] << 8))
        out.append(f"\trect_pair {b[0]}, {b[1]}, {refs[0]}, {refs[1]}")
    tail = (end - start) % 6
    if tail:
        out.append("\tdb " + ", ".join(f"${x:02x}" for x in rom[end - tail:end]))
    return out


def _same_bank_refs(bank, labels, *words):
    """Each word as its same-bank label, or a literal when nothing is named."""
    refs = []
    for w in words:
        tgt = bank * BANK_SIZE + w - BANK_SIZE if BANK_SIZE <= w < 0x8000 else None
        refs.append(labels.get(tgt) or f"${w:04x}")
    return refs


def render_text_offsets(rom, start, end, base, base_label):
    """A string-offset table: each word is an offset from `base`, the pool that
    follows it (FetchText_<bank> does `hl = pool + table[id]`). The values are
    layout, not content, so they render as the difference of two labels and
    rgbasm recomputes them -- edit a string and every offset still lands. An
    entry that does not fall on a string start keeps its numeric value."""
    from extract import string_starts
    span = max((rom[o] | (rom[o + 1] << 8) for o in range(start, end - 1, 2)),
               default=0)
    index = {off: n for n, off in
             enumerate(string_starts(rom[base:base + span + 1]))}
    out = []
    for r, o in enumerate(range(start, end - 1, 2)):
        w = rom[o] | (rom[o + 1] << 8)
        n = index.get(w)
        ref = f"{base_label}.s{n} - {base_label}" if n is not None else f"${w:04x}"
        out.append(f"\tdw {ref} ; {r}")
    if (end - start) % 2:
        out.append(f"\tdb ${rom[end - 1]:02x}")
    return out

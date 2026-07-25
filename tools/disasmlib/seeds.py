"""Code targets that recursive descent cannot reach.

Handlers installed as pointers (frame tasks, actor handlers) or held in data
tables (map scripts, minigame mode hooks and config init routines) only ever
run through an indirect dispatch. Each scanner here yields their flat offsets
so the analysis can seed them as code and the referring table can name them.
pointer_load_targets covers the general case: `ld rr, imm` sites whose value is
provably used as a same-bank pointer.
"""
from .rom import BANK_SIZE, target_to_offset


# ROM0 helpers that take a task-function pointer in hl (`ld hl, fn; call ...`).
# Both are matched when *resolving* a pointer load, but only RegisterFrameTask
# targets are seeded/carved: RunFrameTasks executes the registered pointer, so
# it is guaranteed code, whereas an UnregisterFrameTask key may be a stale
# pointer into data (e.g. RulesScreenTiles, an LZ graphics stream).
FRAME_TASK_PTR_CALLS = ("RegisterFrameTask", "UnregisterFrameTask")
FRAME_TASK_REGISTER = ("RegisterFrameTask",)


def frame_task_targets(dis, call_targets):
    """Code targets of `ld hl, n16` immediately before a `call` to a frame-task
    helper (register/unregister) -- per-frame task functions reached only
    through the task dispatcher, so recursive descent never labels them. Seeding
    them lets the registration sites reference the task by name."""
    if not call_targets:
        return
    rom = dis.rom
    for o, ins in dis.instrs.items():
        if rom[o] != 0x21 or o + 3 not in dis.instrs or rom[o + 3] != 0xCD:
            continue  # ld hl, n16 ; call nn
        if target_to_offset(rom[o + 4] | (rom[o + 5] << 8), o + 3) not in call_targets:
            continue
        imm = rom[o + 1] | (rom[o + 2] << 8)
        b = (o // BANK_SIZE) * BANK_SIZE
        flat = imm if imm < 0x4000 else (b + imm - 0x4000 if b else None)
        if flat is not None and 0 <= flat < len(rom):
            yield flat


# Installers that stash a handler pointer for a dispatcher to call later. The
# pointer is stored rather than dereferenced at the load site, so the
# `_pointer_load_used` gate never fires and descent never reaches the handler.
ACTOR_HANDLER_INSTALL = ("SetMinigameActorHandler",)


def actor_handler_targets(dis, call_targets):
    """Code targets of the handler-install sites (see actor_handler_sites)."""
    return actor_handler_sites(dis, call_targets).values()


def actor_handler_sites(dis, call_targets):
    """{site_offset: target} for `ld de, n16` shortly before a `call` to a
    handler installer. The minigame actor engine calls the stored pointer each
    frame, so it is code; seeding it lets the install site name the handler.
    The pointer is stored rather than dereferenced locally, so
    pointer_load_targets' use-gate never fires for these sites."""
    out = {}
    if not call_targets:
        return out
    rom = dis.rom
    order = sorted(dis.instrs)
    idx = {o: i for i, o in enumerate(order)}
    for o in order:
        if rom[o] != 0x11 or dis.instrs[o].size != 3:
            continue  # ld de, n16
        i, prev_end = idx[o] + 1, o + 3
        for _ in range(4):  # de is set up a load or two before the call
            if i >= len(order) or order[i] != prev_end:
                break
            no = order[i]
            if rom[no] == 0xCD and target_to_offset(
                    rom[no + 1] | (rom[no + 2] << 8), no) in call_targets:
                imm = rom[o + 1] | (rom[o + 2] << 8)
                b = (o // BANK_SIZE) * BANK_SIZE
                flat = imm if imm < 0x4000 else (b + imm - 0x4000 if b else None)
                if flat is not None and 0 <= flat < len(rom):
                    out[o] = flat
                break
            if rom[no] == 0x11:
                break  # de reloaded -- this load is not the argument
            prev_end = no + dis.instrs[no].size
            i += 1
    return out


# `ld bc/de/hl, n16` opcodes -- a 16-bit immediate load whose value may be a
# same-bank pointer.
LD_IMM16_REG = {0x01: "bc", 0x11: "de", 0x21: "hl"}


def _pointer_load_used(dis, order, idx, o, reg):
    """Straight-line forward scan from a `ld reg, imm` at offset `o`: True if the
    loaded value is used as a pointer -- dereferenced (`[hl`/`[de]`/`[bc]`),
    dispatched through (`jp hl`), pushed for a computed-jump dispatch, or used as
    a table base (`add hl, de/bc` then the resulting hl is dereferenced). A
    coincidental numeric constant (e.g. `ld de, $4000` before `add hl, de; jr c`,
    an overflow check) is rejected because hl is never dereferenced."""
    ptr = {reg}
    i = idx[o] + 1
    prev_end = o + dis.instrs[o].size
    for _ in range(12):
        if i >= len(order):
            break
        no = order[i]
        if no != prev_end:
            break  # data gap -- no longer straight-line
        ins = dis.instrs[no]
        t = ins.text
        if (("hl" in ptr and ("[hl" in t or t == "jp hl"))
                or ("de" in ptr and "[de]" in t)
                or ("bc" in ptr and "[bc]" in t)):
            return True
        if t in ("push hl", "push de", "push bc") and t.split()[1] in ptr:
            return True
        if t in ("add hl, de", "add hl, bc") and t.split(", ")[1] in ptr:
            ptr = ptr | {"hl"}
        else:
            for r in ("hl", "de", "bc"):
                if r in ptr and (t.startswith(f"ld {r},")
                                 or t.startswith(f"ld {r[0]},")
                                 or t.startswith(f"ld {r[1]},")
                                 or t == f"pop {r}"):
                    ptr = ptr - {r}
        if not ptr or ins.ends_flow:
            break
        prev_end = no + ins.size
        i += 1
    return False


def pointer_load_targets(dis):
    """`ld bc/de/hl, imm` sites whose immediate is a same-bank pointer: the value
    lands on an instruction start or a data byte (never mid-instruction) and is
    provably used as a pointer (see `_pointer_load_used`). Returns
    {site_offset: target_flat_offset}. The pointer-use gate keeps coincidental
    16-bit constants that happen to alias an in-bank address from being named."""
    rom = dis.rom
    order = sorted(dis.instrs)
    idx = {o: i for i, o in enumerate(order)}
    out = {}
    for o in order:
        reg = LD_IMM16_REG.get(rom[o])
        if reg is None or dis.instrs[o].size != 3:
            continue
        imm = rom[o + 1] | (rom[o + 2] << 8)
        base = (o // BANK_SIZE) * BANK_SIZE
        if not (base and 0x4000 <= imm < 0x8000):
            continue  # same-bank window only
        flat = base + (imm - 0x4000)
        if flat not in dis.instrs and flat in dis.code_bytes:
            continue  # points mid-instruction -- not a real code pointer
        if not _pointer_load_used(dis, order, idx, o, reg):
            continue
        out[o] = flat
    return out


def map_script_code_targets(rom, data_tables):
    """Yield the in-bank code pointers embedded in map_scripts/map_entries
    tables (script-record handlers and entry arrival scripts). These handlers
    are only ever reached through an indirect dispatch (CallHLInBankA), so
    recursive descent never gives them a label; seeding them lets the record
    macros reference the handler by name instead of a bare address."""
    for start, spec in data_tables.items():
        if spec not in ("map_scripts", "map_entries"):
            continue
        bank = start // BANK_SIZE
        base = bank * BANK_SIZE
        pfield = 4 if spec == "map_scripts" else 6  # handler / arrival script
        p = start
        # tables are $ff-terminated; cap the walk at the bank end for safety
        while p + 8 <= base + BANK_SIZE and rom[p] != 0xFF:
            w = rom[p + pfield] | (rom[p + pfield + 1] << 8)
            if 0x4000 <= w < 0x8000:
                yield base + w - 0x4000
            p += 8


def mode_hook_code_targets(rom, data_tables):
    """Yield the in-bank code pointers held by mode_hooks tables. A minigame
    config's +$08 field points at one of these: 8 words indexed by CallModeHook
    ($08:$66f1) with d = the event slot (0 per-frame, 1 point start, 2 point
    end, 3 minigame start, 4 ball hit, 5 bounce, 6 rally tick, 7 draw). The
    handlers run only through that indirect dispatch, so descent never reaches
    them; seeding makes them code and lets the table name each one. Unused
    slots point at $00:$03ae, a bare `ret` in ROM0, and are skipped."""
    for start, spec in data_tables.items():
        if spec != "mode_hooks":
            continue
        base = (start // BANK_SIZE) * BANK_SIZE
        for r in range(8):
            p = start + r * 2
            w = rom[p] | (rom[p + 1] << 8)
            if 0x4000 <= w < 0x8000:
                yield base + w - 0x4000


def minigame_config_init_targets(rom, data_tables):
    """Yield the `+$0c` init routines of the minigame configs a
    `minigame_configs` pointer table points at. InitMinigameFromConfig calls
    the field through JumpToHL, so descent never reaches it and the routine
    otherwise stays inside the config's own INCBIN blob."""
    for start, spec in data_tables.items():
        if spec != "minigame_configs":
            continue
        base = (start // BANK_SIZE) * BANK_SIZE
        end = start
        while end + 1 < base + BANK_SIZE:
            w = rom[end] | (rom[end + 1] << 8)
            if not (0x4000 <= w < 0x8000):
                break
            end += 2
        for p in range(start, end, 2):
            w = rom[p] | (rom[p + 1] << 8)
            cfg = base + w - 0x4000
            init = rom[cfg + 0x0c] | (rom[cfg + 0x0d] << 8)
            if 0x4000 <= init < 0x8000:
                yield base + init - 0x4000

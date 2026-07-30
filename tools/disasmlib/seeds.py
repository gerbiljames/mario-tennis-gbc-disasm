"""Code targets that recursive descent cannot reach.

Handlers installed as pointers (frame tasks, actor handlers) or held in data
tables (map scripts, minigame mode hooks and config init routines) only ever
run through an indirect dispatch. Each scanner here yields their flat offsets
so the analysis can seed them as code and the referring table can name them.
pointer_load_targets covers the general case: `ld rr, imm` sites whose value is
provably used as a same-bank pointer.
"""
import re

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


def _pointer_load_used(dis, order, idx, o, reg, callees=None):
    """Straight-line forward scan from a `ld reg, imm` at offset `o`: True if the
    loaded value is used as a pointer -- dereferenced (`[hl`/`[de]`/`[bc]`),
    dispatched through (`jp hl`), pushed for a computed-jump dispatch, used as
    a table base (`add hl, de/bc` then the resulting hl is dereferenced), or
    handed to a routine that dereferences that register itself (`callees`). A
    coincidental numeric constant (e.g. `ld de, $4000` before `add hl, de; jr c`,
    an overflow check) is rejected because hl is never dereferenced."""
    return _scan_ptr_use(dis, order, idx[o] + 1,
                         o + dis.instrs[o].size, {reg}, callees or {})


REG_PAIRS = {"hl": ("h", "l"), "de": ("d", "e"), "bc": ("b", "c")}


def _call_target(dis, off, ins):
    """Where a call/jump at `off` goes, resolving the farcall convention."""
    if off in dis.farcalls:
        return dis.farcalls[off][3]
    if ins.target is None:
        return None
    return target_to_offset(ins.target, off)


def _scan_ptr_use(dis, order, i, prev_end, ptr, callees, limit=12,
                  push_is_use=True):
    added = None   # the pair whose low byte an `add <low>` just indexed
    copy = None    # a `ld <dst hi>, <src hi>` awaiting its low half
    depth, saved = 0, {}   # stack depth, and {depth: reg} for saved pointers
    for _ in range(limit):
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
        if t.startswith("push "):
            reg = t.split()[1]
            if push_is_use and reg in ptr:
                return True
            if reg in ptr:
                saved[depth] = reg
            depth += 1
        elif t.startswith("pop "):
            depth -= 1
            # A prologue saves the argument and restores it before using it;
            # `pop` normally clobbers, but a pop matching this push restores the
            # very value we are tracking (InitLocationActors holds the actor
            # list across its setup this way).
            if saved.pop(depth, None) == t.split()[1]:
                ptr = ptr | {t.split()[1]}
                prev_end = no + ins.size
                i += 1
                continue
        # Handing the value on: a call, or a tail call (`jp`/`jr` out of the
        # routine), which is how the VRAM DMA helpers pass their source
        # address down -- QueueVRAMCopy never touches hl itself, it
        # `jp`s to StartVRAMDMAFromHL.
        if callees and (ins.is_call or (ins.is_jump and not ins.is_cond)):
            # A farcall is `rst $18` and carries no target of its own -- the
            # bank/entry it resolves to lives in dis.farcalls, so it has to be
            # checked before the target test or every cross-bank argument is
            # invisible here.
            tgt = _call_target(dis, no, ins)
            if tgt is not None and ptr & callees.get(tgt, frozenset()):
                return True
        # `ld b, h; ld c, l` moves the pointer to another pair; the value is
        # the same address, so keep tracking it.
        copied, prev_copy, copy = None, copy, None
        for dst, (dhi, dlo) in REG_PAIRS.items():
            for src, (shi, slo) in REG_PAIRS.items():
                if dst == src:
                    continue
                if t == f"ld {dhi}, {shi}":
                    copy = (dst, src)
                elif prev_copy == (dst, src) and t == f"ld {dlo}, {slo}" \
                        and src in ptr:
                    copied = dst
        if t in ("add hl, de", "add hl, bc") and t.split(", ")[1] in ptr:
            ptr = ptr | {"hl"}
        else:
            # `add l; ld l, a; jr nc, .x; inc h` adds an index to the pair
            # rather than clobbering it -- the split-base indexing the game
            # uses everywhere for table lookups.
            indexed = added if added and t == f"ld {added[1]}, a" else None
            added = next((r for r in ptr if t == f"add {r[1]}"), None)
            for r in ("hl", "de", "bc"):
                if r in ptr and not (indexed and r == indexed) \
                        and (t.startswith(f"ld {r},")
                             or t.startswith(f"ld {r[0]},")
                             or t.startswith(f"ld {r[1]},")
                             or t == f"pop {r}"):
                    ptr = ptr - {r}
        if copied:
            ptr = ptr | {copied}
        if not ptr or ins.ends_flow:
            break
        prev_end = no + ins.size
        i += 1
    return False


# Routines whose argument is an address by construction, where the body never
# dereferences it so no scan can tell. StartVRAMDMATransfer writes bc into the
# VRAM DMA source registers ($ff51/$ff52), which is exactly "bc is an address".
POINTER_ARG_ROUTINES = {"StartVRAMDMATransfer": ("bc",)}


def callee_pointer_regs(dis, overrides=None, rounds=3):
    """{entry offset: the registers that routine dereferences on entry}. A
    `ld hl, table; call Helper` only reads as a pointer setup if the helper
    treats hl as one, so this is what lets the argument-passing sites resolve.
    Iterating lets a helper that forwards its argument to another helper count
    too -- QueueVRAMCopy tail-calls StartVRAMDMAFromHL, which copies hl into bc
    and tail-calls StartVRAMDMATransfer, so it takes three rounds to get from
    the seed below back up to the call sites."""
    order = sorted(dis.instrs)
    idx = {o: i for i, o in enumerate(order)}
    entries = set()
    for o, ins in dis.instrs.items():
        if ins.is_call or (ins.is_jump and not ins.is_cond):
            tgt = _call_target(dis, o, ins)
            if tgt in dis.instrs:
                entries.add(tgt)
    seed = {}
    for k, name in (overrides or {}).items():
        if name in POINTER_ARG_ROUTINES:
            seed[int(k, 0)] = frozenset(POINTER_ARG_ROUTINES[name])
    out = dict(seed)
    for _ in range(rounds):
        prev, out = out, dict(seed)
        for e in entries:
            # A helper often unpacks its other arguments before touching the
            # pointer, so give the entry scan a longer run than a call site's.
            # `push` does not count here: at a call site pushing the value is a
            # dispatch, but at an entry it is just a prologue saving a register
            # -- counting it made DrawDecimalNumberSprites look like it takes a
            # pointer in de, when de is a y/x pair.
            regs = set(seed.get(e, ())) | {
                r for r in ("hl", "de", "bc")
                if _scan_ptr_use(dis, order, idx[e], e, {r}, prev, 32,
                                 push_is_use=False)}
            if regs:
                out[e] = frozenset(regs)
        if out == prev:
            break
    return out


def pointer_load_targets(dis, overrides=None):
    """`ld bc/de/hl, imm` sites whose immediate is a same-bank pointer: the value
    lands on an instruction start or a data byte (never mid-instruction) and is
    provably used as a pointer (see `_pointer_load_used`). Returns
    {site_offset: target_flat_offset}. The pointer-use gate keeps coincidental
    16-bit constants that happen to alias an in-bank address from being named."""
    rom = dis.rom
    order = sorted(dis.instrs)
    idx = {o: i for i, o in enumerate(order)}
    callees = callee_pointer_regs(dis, overrides)
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
        if not _pointer_load_used(dis, order, idx, o, reg, callees):
            continue
        out[o] = flat
    return out


# Specs whose every word is a same-bank pointer (render_pointer_words renders
# them). Their targets are proven pointers, so each one can anchor a label.
POINTER_WORD_SPECS = ("records:2", "mode_hooks", "minigame_configs")


def pointer_table_targets(rom, data_tables, instrs=(), labels=()):
    """Yield the in-bank targets of every all-pointer word table. The table's
    extent is not known until emit lays the bank out, so the walk stops at the
    first word that is not an in-bank address, or at whatever claims the next
    offset (another declared table, decoded code, a curated label) -- the same
    boundaries emit's segment scan uses. Over-running would only cost a label
    at an offset nothing points at; under-running leaves the word numeric."""
    stops = set(data_tables) | set(instrs) | set(labels)
    for start, spec in data_tables.items():
        if spec not in POINTER_WORD_SPECS:
            continue
        base = (start // BANK_SIZE) * BANK_SIZE
        if not base:
            continue  # ROM0 has no bank window to resolve against
        # A mode_hooks table is always 8 slots, and an unused one points at the
        # shared ROM0 `ret` -- stopping at that word would hide the handlers
        # after it (bank $10's water-sprite hooks 4-6 are three `ret` stubs).
        limit = start + 16 if spec == "mode_hooks" else base + BANK_SIZE
        p = start
        while p + 1 < min(limit, base + BANK_SIZE):
            if p != start and p in stops:
                break
            w = rom[p] | (rom[p + 1] << 8)
            if not (BANK_SIZE <= w < 0x8000):
                if spec == "mode_hooks":
                    p += 2
                    continue
                break
            yield base + w - BANK_SIZE
            p += 2


def map_script_code_targets(rom, data_tables):
    """Yield the in-bank code pointers embedded in map_scripts/map_entries
    tables (script-record handlers and entry arrival scripts). These handlers
    are only ever reached through an indirect dispatch (CallHLInBankA), so
    recursive descent never gives them a label; seeding them lets the record
    macros reference the handler by name instead of a bare address."""
    for start, spec in data_tables.items():
        kind = spec.partition(":")[0]  # `map_scripts:<slot role>`
        if kind not in ("map_scripts", "map_entries"):
            continue
        bank = start // BANK_SIZE
        base = bank * BANK_SIZE
        pfield = 4 if kind == "map_scripts" else 6  # handler / arrival script
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


def split_base_targets(dis):
    """Addresses the `add LOW / ld l, a / adc HIGH / sub l / ld h, a`
    idiom builds, where hl is dereferenced afterwards. The address never appears
    as a word, so nothing else in the analysis sees these tables; yielding them
    lets them be labelled, which is also what lets emit render the two halves as
    LOW()/HIGH() instead of magic bytes."""
    order = sorted(dis.instrs)
    idx = {o: i for i, o in enumerate(order)}
    for o in order:
        ins = dis.instrs[o]
        m = re.match(r"^add \$([0-9a-f]{2})$", ins.text)
        if not m:
            continue
        i, prev_end, lo = idx[o] + 1, o + ins.size, int(m.group(1), 16)
        hi = has_l = has_h = None
        for _ in range(4):
            if i >= len(order) or order[i] != prev_end:
                break
            t = dis.instrs[order[i]].text
            if t == "ld l, a":
                has_l = True
            elif t == "ld h, a":
                has_h = True
            else:
                mh = re.match(r"^adc \$([0-9a-f]{2})$", t)
                if mh:
                    hi = int(mh.group(1), 16)
            prev_end = order[i] + dis.instrs[order[i]].size
            i += 1
        if hi is None or not has_l or not has_h:
            continue
        addr = hi << 8 | lo
        if not 0x0100 <= addr < 0x8000:
            continue
        # hl has to be read for the pair to have been an address
        j, end = i, prev_end
        deref = False
        for _ in range(6):
            if j >= len(order) or order[j] != end:
                break
            if "[hl" in dis.instrs[order[j]].text:
                deref = True
                break
            end = order[j] + dis.instrs[order[j]].size
            j += 1
        if not deref:
            continue
        bank = o // BANK_SIZE
        if bank and addr < BANK_SIZE:
            yield addr
        elif bank:
            yield bank * BANK_SIZE + addr - BANK_SIZE
        elif addr < BANK_SIZE:
            yield addr

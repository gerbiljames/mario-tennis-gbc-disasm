"""Naming every emitted symbol.

build_labels assigns one name per proven offset: curated names from
labels.json win, then the vector/entry names, then generated Func_/Label_/
Data_ names derived from how the offset is reached.
"""
import bisect
import sys

from .constants import is_splittable
from .rom import BANK_SIZE, offset_to_cpu, target_to_offset
from .seeds import (ACTOR_HANDLER_INSTALL, FRAME_TASK_REGISTER,
                    actor_handler_targets, frame_task_targets,
                    map_script_code_targets, minigame_config_init_targets,
                    pointer_table_targets, split_base_targets)


VECTOR_LABELS = {
    0x00: "Rst00", 0x08: "Rst08", 0x10: "Rst10", 0x18: "Rst18",
    0x20: "Rst20", 0x28: "Rst28", 0x30: "Rst30", 0x38: "Rst38",
    0x40: "VBlankInterrupt", 0x48: "LCDStatInterrupt", 0x50: "TimerInterrupt",
    0x58: "SerialInterrupt", 0x60: "JoypadInterrupt", 0x100: "EntryPoint",
}


AUTO_STEMS = ("Func_", "Label_", "Data_", "Lz_", "Fill_", "SpriteTemplate_",
              "OamPtrs_")


def _is_auto(name):
    """A generated name -- one that states an address rather than a meaning."""
    return name is not None and name.startswith(AUTO_STEMS)


def enclosing_function_lookup(labels, dis):
    """A `site -> owning global code label` function over `labels` as it
    stands. Snapshotted, so later additions cannot change earlier answers."""
    offs = sorted(off for off, n in labels.items()
                  if off in dis.instrs and not n.startswith("."))

    def owner_of(site):
        i = bisect.bisect_right(offs, site) - 1
        if i < 0 or offs[i] // BANK_SIZE != site // BANK_SIZE:
            return None
        return labels[offs[i]]

    return owner_of


def name_owned(out, targets, stem, sites, owner_of, reserved=()):
    """Name each of `targets` after its owner rather than its address.

    A target with exactly one owner whose own name is not auto-generated takes
    `<owner>_<stem>`, numbered when one owner holds several. Everything else --
    no owner, several owners, an owner that only states an address itself --
    falls back to `<stem>_<bank>_<N>`, an index within the bank. Either way the
    name carries no address, so inserting bytes ahead of it cannot make it lie.
    """
    owners = {}
    for t in targets:
        if t in out:
            continue
        names = {owner_of(s) for s in sites.get(t, ())}
        names.discard(None)
        owners[t] = names.pop() if len(names) == 1 else None
        if _is_auto(owners[t]):
            owners[t] = None
    taken = set(out.values()) | set(reserved)
    groups = {}
    for t in sorted(owners):
        groups.setdefault((owners[t], t // BANK_SIZE), []).append(t)
    for (owner, bank), items in sorted(groups.items(), key=lambda g: g[0][1]):
        if owner is None:
            continue
        for i, t in enumerate(items):
            n = f"{owner}_{stem}" if len(items) == 1 else \
                f"{owner}_{stem}{i:0{2 if len(items) >= 10 else 1}d}"
            if n not in taken:
                out[t] = n
                taken.add(n)
    rest = sorted(t for t in owners if t not in out)
    per_bank = {}
    for t in rest:
        per_bank.setdefault(t // BANK_SIZE, []).append(t)
    for bank, items in per_bank.items():
        for i, t in enumerate(items):
            n = f"{stem}_{bank:02x}" if len(items) == 1 else \
                f"{stem}_{bank:02x}_{i:0{2 if len(items) >= 10 else 1}d}"
            while n in taken:
                n += "_"
            out[t] = n
            taken.add(n)


def build_labels(dis, overrides=None, data_tables=None, ptr_sites=None):
    labels = {}
    for off, name in VECTOR_LABELS.items():
        if off in dis.instrs:
            labels[off] = name
    if overrides:
        for k, name in overrides.items():
            ok = (name[:1].isupper() and name.isidentifier()) or \
                 (name.startswith(".") and name[1:].isidentifier())
            if not ok:
                print(f"warning: labels.json: {k} name {name!r} should be "
                      f"PascalCase or a .local label", file=sys.stderr)
            labels[int(k, 0)] = name
    for off, ins in dis.instrs.items():
        if ins.target is None or not (ins.is_jump or ins.is_call):
            continue
        t = target_to_offset(ins.target, off)
        if t is None or t not in dis.instrs:
            continue
        cpu = offset_to_cpu(t)
        bank = t // BANK_SIZE
        name = f"Func_{bank:02x}_{cpu:04x}" if ins.is_call else f"Label_{bank:02x}_{cpu:04x}"
        prev = labels.get(t)
        if prev is None:
            labels[t] = name
        elif prev.startswith("Label_") and name.startswith("Func_"):
            labels[t] = name
    far_targets = [(bank, target) for off, (bank, _s, _e, target) in dis.farcalls.items()
                   if off in dis.instrs]
    far_targets += [(bank, target) for bank, _s, target in dis.inferred_entries.values()]
    for bank, target in far_targets:
        if target not in dis.instrs:
            continue
        name = f"Func_{bank:02x}_{offset_to_cpu(target):04x}"
        prev = labels.get(target)
        if prev is None or prev.startswith("Label_"):
            labels[target] = name
    for target in dis.jt_entries.values():
        if target in dis.instrs and target not in labels:
            labels[target] = f"Label_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
    for target, _note in dis.ptr_words.values():
        if target is not None and target in dis.instrs and target not in labels:
            labels[target] = f"Func_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
    for target in map_script_code_targets(dis.rom, data_tables or {}):
        if target in dis.instrs and target not in labels:
            labels[target] = f"Func_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
    for target in minigame_config_init_targets(dis.rom, data_tables or {}):
        if target in dis.instrs and target not in labels:
            labels[target] = f"Func_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
    rft = {int(k, 0) for k, n in (overrides or {}).items()
           if n in FRAME_TASK_REGISTER}
    for target in frame_task_targets(dis, rft):
        if target in dis.instrs and target not in labels:
            labels[target] = f"Func_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
    ahi = {int(k, 0) for k, n in (overrides or {}).items()
           if n in ACTOR_HANDLER_INSTALL}
    for target in actor_handler_targets(dis, ahi):
        if target in dis.instrs and target not in labels:
            labels[target] = f"Func_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
    # Name each carved sprite-template so the `ld hl` load sites resolve to it,
    # after the routine that loads it where there is only one such routine.
    name_owned(labels, dis.sprite_templates, "SpriteTemplate",
               {src: dis.sprite_template_sites.get(src, ())
                for src in dis.sprite_templates},
               enclosing_function_lookup(labels, dis))
    # An object header's OAM pointer array belongs to that record and nothing
    # else, so it is named for the header, like the record's Gfx/Oam blobs.
    # The name has to go back into ptr_labels: that is what the header's own
    # `dw` reads to reference the array, so both spellings move together.
    name_owned(dis.ptr_labels, set(dis.oam_arrays), "OamPtrs",
               {a: (h,) for a, h in dis.oam_arrays.items()},
               lambda header: labels.get(header),
               reserved=set(labels.values()))
    # Same-bank pointer-load targets (`ld hl, table` etc.) that recursive descent
    # never named. Code targets (instruction starts) get a Func_ label and
    # data-table starts (data_tables keys) a Data_ label -- both reliably emitted.
    dt = data_tables or {}
    for target in set((ptr_sites or {}).values()):
        if target in labels:
            continue
        if target in dis.instrs:
            labels[target] = f"Func_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
        elif target in dt:
            labels[target] = f"Data_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
    # Words of the all-pointer tables. Their code targets get a label the same
    # way a pointer load's does; the data targets join the set below, which is
    # what turns `dw $64a4` into `dw StatBarRow3`.
    table_ptrs = {t for t in pointer_table_targets(dis.rom, dt, dis.instrs,
                                                   labels)
                  if t in dis.instrs or t not in dis.code_bytes}
    # Tables reached by split-base arithmetic; their address is never a word,
    # so this is the only pass that sees them. Data only: the idiom builds a
    # table base, so a hit inside code is a false positive, and naming one
    # there re-parents any curated local after it into a region whose labels
    # are never emitted.
    table_ptrs |= {t for t in split_base_targets(dis)
                   if t not in dis.code_bytes}
    for target in table_ptrs:
        if target in labels:
            continue
        if target in dis.instrs:
            labels[target] = \
                f"Label_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
        elif target in dt:
            # The first record of a pointer table usually aims at the row array
            # directly after it, which is a declared table of its own and so is
            # never a cut point -- name it where it is declared instead.
            labels[target] = \
                f"Data_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
    # Pointers into unlabeled data: emit splits the enclosing region at these
    # and names them Data_* (see emit's seg-loop and _emit_pieces). A target
    # interior to a typed run is only usable if that run's rendering survives
    # being cut in two (see is_splittable); inside anything else -- bytecode, a
    # decoded header, a slot-record table -- the pointer stays numeric.
    typed = sorted(set(dt) | set(dis.slot_record_tables))
    instr_keys = sorted(dis.instrs)
    label_keys = sorted(labels)

    def in_unsplittable_run(target):
        i = bisect.bisect_right(typed, target) - 1
        if i < 0 or typed[i] == target:
            return False
        k = typed[i]
        end = (k // BANK_SIZE + 1) * BANK_SIZE
        for arr in (typed, instr_keys, label_keys):
            j = bisect.bisect_right(arr, k)
            if j < len(arr):
                end = min(end, arr[j])
        return target < end and not is_splittable(dt.get(k))

    ptr_data_targets = set()
    for target in set((ptr_sites or {}).values()) | table_ptrs:
        if target in labels or target in dis.instrs or target in dt:
            continue
        if not in_unsplittable_run(target):
            ptr_data_targets.add(target)
    return labels, ptr_data_targets


class LabelScopes:
    """RGBDS local-label scoping for the `.name` labels curated in labels.json.

    A `.name` definition binds to whatever global label precedes it, so it is
    only spellable as `.name` from inside that function; every other reference
    has to be written `Parent.name`. This resolves both forms and exposes the
    qualified name table the emitter uses wherever a label is referenced
    rather than defined."""

    def __init__(self, labels):
        self.labels = labels
        self.globals = sorted(o for o, n in labels.items()
                              if not n.startswith("."))
        self.parent = {}
        self.qualified = dict(labels)
        for off, name in sorted(labels.items()):
            if not name.startswith("."):
                continue
            owner = self.scope_of(off)
            if owner is None or owner // BANK_SIZE != off // BANK_SIZE:
                print(f"warning: local label {name} at ${off:06x} has no "
                      f"enclosing global label", file=sys.stderr)
                continue
            self.parent[off] = owner
            self.qualified[off] = labels[owner] + name

    def scope_of(self, off):
        """The offset of the global label a local label at `off` binds to."""
        i = bisect.bisect_right(self.globals, off) - 1
        return self.globals[i] if i >= 0 else None

    def ref(self, target, site):
        """How code at `site` spells a reference to the label at `target`."""
        owner = self.parent.get(target)
        if owner is None or owner == self.scope_of(site):
            return self.labels[target]
        return self.qualified[target]

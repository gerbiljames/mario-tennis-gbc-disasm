"""Naming every emitted symbol.

build_labels assigns one name per proven offset: curated names from
labels.json win, then the vector/entry names, then generated Func_/Label_/
Data_ names derived from how the offset is reached.
"""
import bisect
import sys

from .rom import BANK_SIZE, offset_to_cpu, target_to_offset
from .seeds import (ACTOR_HANDLER_INSTALL, FRAME_TASK_REGISTER,
                    actor_handler_targets, frame_task_targets,
                    map_script_code_targets, minigame_config_init_targets)


VECTOR_LABELS = {
    0x00: "Rst00", 0x08: "Rst08", 0x10: "Rst10", 0x18: "Rst18",
    0x20: "Rst20", 0x28: "Rst28", 0x30: "Rst30", 0x38: "Rst38",
    0x40: "VBlankInterrupt", 0x48: "LCDStatInterrupt", 0x50: "TimerInterrupt",
    0x58: "SerialInterrupt", 0x60: "JoypadInterrupt", 0x100: "EntryPoint",
}


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
    # Name each carved sprite-template so the `ld hl` load sites resolve to it.
    for src in dis.sprite_templates:
        if src not in labels:
            labels[src] = \
                f"SpriteTemplate_{src // BANK_SIZE:02x}_{offset_to_cpu(src):04x}"
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
    # Pointers into unlabeled raw data: emit splits the enclosing blob at these
    # and names them Data_* (see emit's seg-loop). Skip any target interior to a
    # typed run (data_tables spec or slot-record table) so its structured
    # rendering isn't truncated; text/special regions that never reach the raw
    # seg-loop simply stay unnamed (the load is left raw, never undefined).
    typed = sorted(set(dt) | set(dis.slot_record_tables))
    instr_keys = sorted(dis.instrs)
    label_keys = sorted(labels)

    def in_typed_run(target):
        i = bisect.bisect_right(typed, target) - 1
        if i < 0 or typed[i] == target:
            return False
        k = typed[i]
        end = (k // BANK_SIZE + 1) * BANK_SIZE
        for arr in (typed, instr_keys, label_keys):
            j = bisect.bisect_right(arr, k)
            if j < len(arr):
                end = min(end, arr[j])
        return target < end

    ptr_data_targets = set()
    for target in set((ptr_sites or {}).values()):
        if target in labels or target in dis.instrs or target in dt:
            continue
        if not in_typed_run(target):
            ptr_data_targets.add(target)
    return labels, ptr_data_targets

"""Dialogue text ids."""


# A 16-bit dialogue text id (passed in hl to FetchDialogueText, $05:$5c18) is not
# an address but a (fetcher, index) code: fetcher = (hi >> 2) & $0f selects a text
# bank via DialogueTextFetchers_05 ($05:$5c3b), and the string index within that
# bank = (hi & 3) * 256 + lo. So the raw id decodes to a bank:index coordinate.
# Rendering the id as the name `Text_<bank>_<index>` (an EQU whose value is the id,
# emitted to include/text_ids.inc) keeps the assembled bytes identical while making
# the operand point at the string; look it up with tools/strings.py --index --bank.
TEXT_FETCHER_BANKS = {0: 0x30, 1: 0x31, 2: 0x32, 3: 0x33, 4: 0x34, 5: 0x35,
                      6: 0x36, 7: 0x37, 8: 0x6e, 9: 0x1f, 10: 0x25, 11: 0x26,
                      12: 0x5e}
TEXT_IDS_USED = {}  # id value -> Text_ name (collected during emit)


def text_id_name(idv):
    """Name a dialogue text id `Text_<bank>_<index>`, or None if it isn't a
    plain text id (bit15 = SRAM string, or an out-of-range fetcher)."""
    if idv == 0 or idv & 0x8000:  # $0000 = "no script/text" sentinel, not a string
        return None
    bank = TEXT_FETCHER_BANKS.get((idv >> 10) & 0x0f)
    if bank is None:
        return None
    index = ((idv >> 8) & 3) * 256 + (idv & 0xff)
    name = f"Text_{bank:02x}_{index}"
    TEXT_IDS_USED[idv] = name
    return name


# Routines that take a dialogue text id in hl. Each was read to confirm it:
# FetchDialogueText and AddTextIdOffset both open `bit 7, h` (the SRAM-string
# flag of the id encoding), and CreateWindowWithTextId says so in its name.
# Everything else is derived -- a routine that hands hl straight to one of
# these takes an id too, which is what the wrappers in the menu banks do.
TEXT_ID_SINKS = ("FetchDialogueText", "AddTextIdOffset", "CreateWindowWithTextId")

_HL_CLOBBER = ("ld hl,", "ld h,", "ld l,", "pop hl")


_PUSH = {"push af": "af", "push bc": "bc", "push de": "de", "push hl": "hl"}
_POP = {"pop af": "af", "pop bc": "bc", "pop de": "de", "pop hl": "hl"}


def _forwards_hl(dis, order, idx, start, sinks, limit=24):
    """True if the routine at `start` reaches a sink with hl intact. A value
    parked with `push hl` and brought back by the matching `pop hl` counts as
    intact -- RenderProportionalTextAt saves the id, uses hl for the glyph
    write pointer, restores it and only then calls AddTextIdOffset."""
    from .seeds import _call_target
    i, prev_end = idx[start], start
    stack, live = [], True
    for _ in range(limit):
        if i >= len(order) or order[i] != prev_end:
            return False
        no = order[i]
        ins = dis.instrs[no]
        if ins.is_call and _call_target(dis, no, ins) in sinks:
            return live
        text = ins.text
        if text in _PUSH:
            stack.append((_PUSH[text], live if _PUSH[text] == "hl" else None))
        elif text in _POP:
            if not stack or stack[-1][0] != _POP[text]:
                return False   # unbalanced: give up rather than guess
            reg, saved = stack.pop()
            if reg == "hl":
                live = saved
        elif text.startswith(_HL_CLOBBER):
            live = False
        elif ins.ends_flow:
            return False
        if not live and not any(r == "hl" and sv for r, sv in stack):
            return False   # the id is gone and nothing on the stack has it
        prev_end = no + ins.size
        i += 1
    return False


def text_id_consumers(dis, overrides, rounds=4):
    """Offsets of every routine that treats hl as a text id, grown from the
    curated sinks through the wrappers that forward to them."""
    from .seeds import _call_target
    sinks = {int(k, 0) for k, n in (overrides or {}).items()
             if n in TEXT_ID_SINKS}
    if not sinks:
        return sinks
    order = sorted(dis.instrs)
    idx = {o: i for i, o in enumerate(order)}
    entries = set()
    for o, ins in dis.instrs.items():
        if ins.is_call:
            t = _call_target(dis, o, ins)
            if t in dis.instrs:
                entries.add(t)
    for _ in range(rounds):
        grew = False
        for e in sorted(entries - sinks):
            if _forwards_hl(dis, order, idx, e, sinks):
                sinks.add(e)
                grew = True
        if not grew:
            break
    return sinks


def text_id_load_sites(dis, overrides):
    """{`ld hl, n16` site -> Text_<bank>_<index>} for the loads that reach a
    text-id consumer. The id encoding is far too permissive to judge by value
    ($0001 and $0012 both "decode"), so the consumer is the whole test; the
    value only has to be a well-formed id once the consumer says it is one."""
    from .seeds import _call_target
    consumers = text_id_consumers(dis, overrides)
    if not consumers:
        return {}
    rom = dis.rom
    order = sorted(dis.instrs)
    idx = {o: i for i, o in enumerate(order)}
    out = {}
    for o in order:
        if rom[o] != 0x21 or dis.instrs[o].size != 3:
            continue  # ld hl, n16
        imm = rom[o + 1] | (rom[o + 2] << 8)
        i, prev_end = idx[o] + 1, o + 3
        for _ in range(5):
            if i >= len(order) or order[i] != prev_end:
                break
            no = order[i]
            ins = dis.instrs[no]
            if ins.is_call:
                if _call_target(dis, no, ins) in consumers:
                    name = text_id_name(imm)
                    if name:
                        out[o] = name
                break
            if ins.text.startswith(_HL_CLOBBER) or ins.ends_flow:
                break
            prev_end = no + ins.size
            i += 1
    return out

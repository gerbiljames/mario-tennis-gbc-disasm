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

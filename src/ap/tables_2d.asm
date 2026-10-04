; Archipelago: per-seed tables, written by the patch's tokens. Zero is vanilla.

; 16 random bytes per slot; their base64 is the slot's connect name.
ApSlotAuth:
	ds 16, 0

; A count per item id, granted from the start.
ApStartInventory:
	ds AP_NUM_ITEMS, 0

; Per location id, this world's item placed there, or AP_ITEM_NONE for
; another world's.
ApPlacements:
	ds AP_NUM_LOCATIONS, AP_ITEM_NONE

; Per location id, for another world's item: its name, then its player's
; (each AP_NAME_LENGTH characters at most, NUL-terminated), fitted to a
; message line by the patch. A blank player shows no message.
ApLocationNames:
	ds AP_NUM_LOCATIONS * AP_LOCATION_NAMES_SIZE, 0

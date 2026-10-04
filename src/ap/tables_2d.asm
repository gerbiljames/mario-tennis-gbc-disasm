; Archipelago: per-seed tables, written by the patch's tokens. Zero is vanilla.

; 16 random bytes per slot; their base64 is the slot's connect name.
ApSlotAuth::
	ds 16, 0

; A count per item id, granted from the start.
ApStartInventory::
	ds AP_NUM_ITEMS, 0

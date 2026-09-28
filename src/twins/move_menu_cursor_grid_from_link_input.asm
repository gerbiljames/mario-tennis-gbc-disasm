; MoveMenuCursorGridFromLinkInput_<bank>: one routine assembled into banks $16, $38, $3e through
; `twin_in move_menu_cursor_grid_from_link_input, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_MoveMenuCursorGridFromLinkInput where nothing calls it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin_in` line in each bank carries the member's address. Every member's
; note is above its `twin_in` line. A fix here lands in every bank.

{TWIN_LABEL}:
	ld a, [wMenuCursorX]
	ld d, a
	ld a, [wMenuCursorY]
	ld e, a
	ldh a, [hLinkInput]
	bit 4, a
	jr z, .checkLeft
	ld a, [wMenuCursorX]
	inc a
	add a
	jr nc, .wrapRight
	ld a, b
	dec a
	jr .storeRight
.wrapRight:
	rra
	cp b
	jr c, .storeRight
	xor a
.storeRight:
	ld [wMenuCursorX], a
	jr .compare
.checkLeft:
	bit 5, a
	jr z, .checkUp
	ld a, [wMenuCursorX]
	dec a
	add a
	jr nc, .wrapLeft
	ld a, b
	dec a
	jr .storeLeft
.wrapLeft:
	rra
	cp b
	jr c, .storeLeft
	xor a
.storeLeft:
	ld [wMenuCursorX], a
	jr .compare
.checkUp:
	bit 6, a
	jr z, .checkDown
	ld a, [wMenuCursorY]
	dec a
	add a
	jr nc, .wrapUp
	ld a, c
	dec a
	jr .storeUp
.wrapUp:
	rra
	cp c
	jr c, .storeUp
	xor a
.storeUp:
	ld [wMenuCursorY], a
	jr .compare
.checkDown:
	bit 7, a
	jr z, .compare
	ld a, [wMenuCursorY]
	inc a
	add a
	jr nc, .wrapDown
	ld a, c
	dec a
	jr .storeDown
.wrapDown:
	rra
	cp c
	jr c, .storeDown
	xor a
.storeDown:
	ld [wMenuCursorY], a
.compare:
	ld a, [wMenuCursorX]
	cp d
	jr nz, .moved
	ld a, [wMenuCursorY]
	cp e
	jr nz, .moved
	xor a
	ret
.moved:
	ld a, $01
	ret

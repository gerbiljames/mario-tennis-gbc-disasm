; MoveMenuCursorGridFromLinkInput_<bank>: one routine assembled into banks $17, $1b through
; `twin move_menu_cursor_grid_from_link_input_17, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

MoveMenuCursorGridFromLinkInput_{TWIN}:
	ld a, [wMenuCursorX]
	ld d, a
	ld a, [wMenuCursorY]
	ld e, a
	ldh a, [hLinkInput]
	bit 4, a
	jr z, .bit4Clear
	ld a, [wMenuCursorX]
	inc a
	add a
	jr nc, .noCarry5
	ld a, b
	dec a
	jr .store5
.noCarry5:
	rra
	cp b
	jr c, .store5
	xor a
.store5:
	ld [wMenuCursorX], a
	jr .checkMenuCursorX2
.bit4Clear:
	bit 5, a
	jr z, .bit5Clear2
	ld a, [wMenuCursorX]
	dec a
	add a
	jr nc, .noCarry6
	ld a, b
	dec a
	jr .store6
.noCarry6:
	rra
	cp b
	jr c, .store6
	xor a
.store6:
	ld [wMenuCursorX], a
	jr .checkMenuCursorX2
.bit5Clear2:
	bit 6, a
	jr z, .bit6Clear2
	ld a, [wMenuCursorY]
	dec a
	add a
	jr nc, .noCarry7
	ld a, c
	dec a
	jr .store7
.noCarry7:
	rra
	cp c
	jr c, .store7
	xor a
.store7:
	ld [wMenuCursorY], a
	jr .checkMenuCursorX2
.bit6Clear2:
	bit 7, a
	jr z, .checkMenuCursorX2
	ld a, [wMenuCursorY]
	inc a
	add a
	jr nc, .noCarry8
	ld a, c
	dec a
	jr .store8
.noCarry8:
	rra
	cp c
	jr c, .store8
	xor a
.store8:
	ld [wMenuCursorY], a
.checkMenuCursorX2:
	ld a, [wMenuCursorX]
	cp d
	jr nz, .checkMenuCursorX6
	ld a, [wMenuCursorY]
	cp e
	jr nz, .checkMenuCursorX6
	xor a
	ret
.checkMenuCursorX6:
	ld a, $01
	ret

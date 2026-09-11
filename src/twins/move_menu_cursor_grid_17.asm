; MoveMenuCursorGrid_<bank>: one routine assembled into banks $17, $1b through
; `twin move_menu_cursor_grid_17, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

MoveMenuCursorGrid_{TWIN}:
	ld a, [wMenuCursorX]
	ld d, a
	ld a, [wMenuCursorY]
	ld e, a
	ld a, [wMenuInputPressed]
	bit PADB_RIGHT, a
	jr z, .checkMenuCursorX4
	ld a, [wMenuCursorX]
	inc a
	add a
	jr nc, .noCarry
	ld a, b
	dec a
	jr .store
.noCarry:
	rra
	cp b
	jr c, .store
	xor a
.store:
	ld [wMenuCursorX], a
	jr .checkMenuCursorX
.checkMenuCursorX4:
	bit 5, a
	jr z, .bit5Clear
	ld a, [wMenuCursorX]
	dec a
	add a
	jr nc, .noCarry2
	ld a, b
	dec a
	jr .store2
.noCarry2:
	rra
	cp b
	jr c, .store2
	xor a
.store2:
	ld [wMenuCursorX], a
	jr .checkMenuCursorX
.bit5Clear:
	bit 6, a
	jr z, .bit6Clear
	ld a, [wMenuCursorY]
	dec a
	add a
	jr nc, .noCarry3
	ld a, c
	dec a
	jr .store3
.noCarry3:
	rra
	cp c
	jr c, .store3
	xor a
.store3:
	ld [wMenuCursorY], a
	jr .checkMenuCursorX
.bit6Clear:
	bit 7, a
	jr z, .checkMenuCursorX
	ld a, [wMenuCursorY]
	inc a
	add a
	jr nc, .noCarry4
	ld a, c
	dec a
	jr .store4
.noCarry4:
	rra
	cp c
	jr c, .store4
	xor a
.store4:
	ld [wMenuCursorY], a
.checkMenuCursorX:
	ld a, [wMenuCursorX]
	cp d
	jr nz, .checkMenuCursorX5
	ld a, [wMenuCursorY]
	cp e
	jr nz, .checkMenuCursorX5
	xor a
	ret
.checkMenuCursorX5:
	ld a, $01
	ret

; Shared by Unused_16_MoveMenuCursorGridFromLinkInput,
; Unused_38_MoveMenuCursorGridFromLinkInput,
; Unused_3b_MoveMenuCursorGridFromLinkInput,
; Unused_3e_MoveMenuCursorGridFromLinkInput (banks $16, $38, $3b, $3e).

{TWIN_LABEL}:
	ld a, [wMenuCursorX]
	ld d, a
	ld a, [wMenuCursorY]
	ld e, a
	ldh a, [hLinkInput]
	bit PADB_RIGHT, a
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
	bit PADB_LEFT, a
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
	bit PADB_UP, a
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
	bit PADB_DOWN, a
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

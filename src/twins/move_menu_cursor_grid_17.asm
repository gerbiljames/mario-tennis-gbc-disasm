; Shared by Unused_17_MoveMenuCursorGrid, MoveMenuCursorGrid_1b (banks $17,
; $1b).

{TWIN_LABEL}:
	ld a, [wMenuCursorX]
	ld d, a
	ld a, [wMenuCursorY]
	ld e, a
	ld a, [wMenuInputPressed]
	bit PADB_RIGHT, a
	jr z, .checkLeft
	ld a, [wMenuCursorX]
	inc a
	add a
	jr nc, .rightWrapCheck
	ld a, b
	dec a
	jr .storeX
.rightWrapCheck:
	rra
	cp b
	jr c, .storeX
	xor a
.storeX:
	ld [wMenuCursorX], a
	jr .checkMoved
.checkLeft:
	bit 5, a
	jr z, .checkUp
	ld a, [wMenuCursorX]
	dec a
	add a
	jr nc, .leftWrapCheck
	ld a, b
	dec a
	jr .storeX2
.leftWrapCheck:
	rra
	cp b
	jr c, .storeX2
	xor a
.storeX2:
	ld [wMenuCursorX], a
	jr .checkMoved
.checkUp:
	bit 6, a
	jr z, .checkDown
	ld a, [wMenuCursorY]
	dec a
	add a
	jr nc, .upWrapCheck
	ld a, c
	dec a
	jr .storeY
.upWrapCheck:
	rra
	cp c
	jr c, .storeY
	xor a
.storeY:
	ld [wMenuCursorY], a
	jr .checkMoved
.checkDown:
	bit 7, a
	jr z, .checkMoved
	ld a, [wMenuCursorY]
	inc a
	add a
	jr nc, .downWrapCheck
	ld a, c
	dec a
	jr .storeY2
.downWrapCheck:
	rra
	cp c
	jr c, .storeY2
	xor a
.storeY2:
	ld [wMenuCursorY], a
.checkMoved:
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

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
	jr .storeRight
.rightWrapCheck:
	rra
	cp b
	jr c, .storeRight
	xor a
.storeRight:
	ld [wMenuCursorX], a
	jr .checkMoved
.checkLeft:
	bit PADB_LEFT, a
	jr z, .checkUp
	ld a, [wMenuCursorX]
	dec a
	add a
	jr nc, .leftWrapCheck
	ld a, b
	dec a
	jr .storeLeft
.leftWrapCheck:
	rra
	cp b
	jr c, .storeLeft
	xor a
.storeLeft:
	ld [wMenuCursorX], a
	jr .checkMoved
.checkUp:
	bit PADB_UP, a
	jr z, .checkDown
	ld a, [wMenuCursorY]
	dec a
	add a
	jr nc, .upWrapCheck
	ld a, c
	dec a
	jr .storeUp
.upWrapCheck:
	rra
	cp c
	jr c, .storeUp
	xor a
.storeUp:
	ld [wMenuCursorY], a
	jr .checkMoved
.checkDown:
	bit PADB_DOWN, a
	jr z, .checkMoved
	ld a, [wMenuCursorY]
	inc a
	add a
	jr nc, .downWrapCheck
	ld a, c
	dec a
	jr .storeDown
.downWrapCheck:
	rra
	cp c
	jr c, .storeDown
	xor a
.storeDown:
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

; Shared by Unused_16_MoveMenuCursorGridRemote,
; Unused_38_MoveMenuCursorGridRemote, Unused_3b_MoveMenuCursorGridRemote,
; Unused_3e_MoveMenuCursorGridRemote (banks $16, $38, $3b, $3e).

{TWIN_LABEL}:
	ld a, [wMenuCursorX]
	ld d, a
	ld a, [wMenuCursorY]
	ld e, a
	ldh a, [hLinkState]
	cp LINKSTATE_SLAVE
	jr z, .asSlave
	cp LINKSTATE_MASTER
	jr z, .asMaster
	call LinkErrorReset
.asMaster:
	ldh a, [hLinkRemoteInputBuf]
	jr .haveInput
.asSlave:
	ldh a, [hLinkRemoteInput]
.haveInput:
	ld h, a
	ld a, [wMenuCursorLockFlags]
	and CURSORLOCKF_PRIMARY
	ld a, h
	jr nz, .checkLock
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
	jr z, .checkLock
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
	jr .compare
.checkLock:
	bit PADB_A, a
	jr z, .checkUnlock
	sound SFX_MENU_SELECT
	ld a, [wMenuCursorLockFlags]
	ld b, a
	and CURSORLOCKF_PRIMARY
	jr nz, .compare
	sound SFX_MENU_SELECT
	ld a, b
	or CURSORLOCKF_PRIMARY
	ld [wMenuCursorLockFlags], a
	jr .compare
.checkUnlock:
	bit PADB_B, a
	jr z, .compare
	sound SFX_MENU_CANCEL
	ld a, [wMenuCursorLockFlags]
	ld b, a
	and CURSORLOCKF_PRIMARY | CURSORLOCKF_SECONDARY
	ld a, b
	jr nz, .clearLock
	and ~(CURSORLOCKF_PRIMARY | CURSORLOCKF_PRIMARY_CANCEL)
	or CURSORLOCKF_PRIMARY_CANCEL
	jr .storeLock
.clearLock:
	and ~CURSORLOCKF_PRIMARY
.storeLock:
	ld [wMenuCursorLockFlags], a
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

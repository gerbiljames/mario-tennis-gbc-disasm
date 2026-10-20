; Shared by Unused_16_MoveMenuCursor2GridRemote,
; Unused_3b_MoveMenuCursor2GridRemote, Unused_3e_MoveMenuCursor2GridRemote
; (banks $16, $3b, $3e).

{TWIN_LABEL}:
	ld a, [wMenuCursor2X]
	ld d, a
	ld a, [wMenuCursor2Y]
	ld e, a
	ldh a, [hLinkState]
	cp LINKSTATE_SLAVE
	jr z, .asSlave
	cp LINKSTATE_MASTER
	jr z, .asMaster
	call LinkErrorReset
.asMaster:
	ldh a, [hLinkRemoteInput]
	jr .haveInput
.asSlave:
	ldh a, [hLinkRemoteInputBuf]
.haveInput:
	ld h, a
	ld a, [wMenuCursorLockFlags]
	and CURSORLOCKF_SECONDARY
	ld a, h
	jr nz, .checkLock
	bit PADB_RIGHT, a
	jr z, .checkLeft
	ld a, [wMenuCursor2X]
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
	ld [wMenuCursor2X], a
	jr .compare
.checkLeft:
	bit PADB_LEFT, a
	jr z, .checkUp
	ld a, [wMenuCursor2X]
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
	ld [wMenuCursor2X], a
	jr .compare
.checkUp:
	bit PADB_UP, a
	jr z, .checkDown
	ld a, [wMenuCursor2Y]
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
	ld [wMenuCursor2Y], a
	jr .compare
.checkDown:
	bit PADB_DOWN, a
	jr z, .checkLock
	ld a, [wMenuCursor2Y]
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
	ld [wMenuCursor2Y], a
	jr .compare
.checkLock:
	bit PADB_A, a
	jr z, .checkUnlock
	ld a, [wMenuCursorLockFlags]
	ld b, a
	and CURSORLOCKF_SECONDARY
	jr nz, .compare
	sound SFX_MENU_SELECT
	ld a, b
	or CURSORLOCKF_SECONDARY
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
	and ~(CURSORLOCKF_SECONDARY | CURSORLOCKF_SECONDARY_CANCEL)
	or CURSORLOCKF_SECONDARY_CANCEL
	jr .storeLock
.clearLock:
	and ~CURSORLOCKF_SECONDARY
.storeLock:
	ld [wMenuCursorLockFlags], a
.compare:
	ld a, [wMenuCursor2X]
	cp d
	jr nz, .moved
	ld a, [wMenuCursor2Y]
	cp e
	jr nz, .moved
	xor a
	ret
.moved:
	ld a, $01
	ret

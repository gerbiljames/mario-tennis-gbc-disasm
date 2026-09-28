; MoveMenuCursor2GridRemote_<bank>: one routine assembled into banks $16, $3e through
; `twin_in move_menu_cursor2_grid_remote, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_MoveMenuCursor2GridRemote where nothing calls it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin_in` line in each bank carries the member's address. Every member's
; note is above its `twin_in` line. A fix here lands in every bank.

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
	and $02
	ld a, h
	jr nz, .checkLock
	bit 4, a
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
	bit 5, a
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
	bit 6, a
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
	bit 7, a
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
	bit 0, a
	jr z, .checkUnlock
	ld a, [wMenuCursorLockFlags]
	ld b, a
	and $02
	jr nz, .compare
	sound SFX_MENU_SELECT
	ld a, b
	or $02
	ld [wMenuCursorLockFlags], a
	jr .compare
.checkUnlock:
	bit 1, a
	jr z, .compare
	sound SFX_MENU_CANCEL
	ld a, [wMenuCursorLockFlags]
	ld b, a
	and $03
	ld a, b
	jr nz, .clearLock
	and $f5
	or $08
	jr .storeLock
.clearLock:
	and $fd
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

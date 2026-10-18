; Shot items (ApOptShotItems): the effective inventory decides which shots
; the player's swings can play. Only input source 0, the player's pad, is
; gated, so the CPU, the tennis machine and a linked player keep every shot.
; The Ap*For routines take and return registers only, never a or hl
; (CallHLInBankA takes the bank and the address there), for tools/aptest.py.

; -> nz if the swing of the character whose WRAM bank is live is gated
ApShotsGated:
	ld a, [ApOptShotItems]
	and a
	ret z
	ld a, [wCharInputSource]
	and a
	jr nz, .no
	or 1
	ret
.no:
	xor a
	ret

; d = item id, e = a count -> nz if the player holds that many; keeps bc
ApHasShot:
	push bc
	call ApItemAtLeast
	pop bc
	ret

; From SelectRallyShotType: a locked button pair becomes the first stroke
; owned. Rewriting the buttons, not the type, keeps wLastShotButtons honest
; for Target Shot's score rules.
ApGateRallyButtons:
	call ApShotsGated
	ret z
	ld hl, wCharShotButton1
	ld b, [hl]
	inc hl
	ld c, [hl]
	call ApFilterRallyButtonsFor
	ld hl, wCharShotButton1
	ld [hl], b
	inc hl
	ld [hl], c
	ret

; b, c = wCharShotButton1, wCharShotButton2 (1 A, 2 B, 3 A+B) -> b, c, with
; a locked pair replaced by topspin (1, 0), slice (2, 0) or flat (3, 3), the
; first owned. (3, 3) is RallyShotTypeTable cell 15, SHOTTYPE_NEUTRAL; no
; real swing has 3 for its second button, so ApSmashAllowedFor knows it.
ApFilterRallyButtonsFor:
	ld e, 1
	ld a, b
	cp 3
	ld d, ITEM_FLAT_SHOT
	jr z, .test
	ld a, c
	and a
	jr nz, .combo
	ld a, b
	cp 2
	ld d, ITEM_TOPSPIN
	jr nz, .test
	ld d, ITEM_SLICE
	jr .test
.combo:
	cp b
	jr nz, .lobOrDrop
	inc e
	cp 1
	ld d, ITEM_TOPSPIN
	jr z, .test
	ld d, ITEM_SLICE
	jr .test
.lobOrDrop:
	cp 2
	ld d, ITEM_LOB
	jr z, .test
	ld d, ITEM_DROP_SHOT
.test:
	call ApHasShot
	ret nz
	ld bc, $0100
	ld de, ITEM_TOPSPIN << 8 | 1
	call ApHasShot
	ret nz
	ld b, 2
	ld d, ITEM_SLICE
	call ApHasShot
	ret nz
	ld d, ITEM_FLAT_SHOT
	call ApHasShot
	ld bc, $0303
	ret nz
	ld bc, $0100
	ret

; From ExecuteShotNeutral, before it turns an overhead swing into a smash:
; -> nz if the smash may be played
ApGateSmash:
	call ApShotsGated
	jr nz, .gated
	or 1
	ret
.gated:
	ld a, [wLastShotButtons]
	ld b, a
	jr ApSmashAllowedFor

; b = wLastShotButtons -> nz if the player may smash: the Flat Shot's second
; copy, and not a fallback swing
ApSmashAllowedFor:
	ld a, b
	cp $33
	jr z, .no
	ld de, ITEM_FLAT_SHOT << 8 | 2
	jp ApItemAtLeast
.no:
	xor a
	ret

; From SelectServeShotType: a serve with no copy of its item becomes the
; first one owned
ApGateServeButton:
	call ApShotsGated
	ret z
	ld hl, wCharShotButton1
	ld b, [hl]
	call ApFilterServeButtonFor
	ld a, b
	ld [wCharShotButton1], a
	ret

; b = wCharShotButton1 (0 or 1 topspin, 2 slice, 3 flat) -> b, the serve
; button to use: its own, else the first serve owned (topspin if none)
ApFilterServeButtonFor:
	ld a, b
	and a
	ld d, ITEM_TOPSPIN_SERVE
	jr z, .test
	add ITEM_TOPSPIN_SERVE - 1
	ld d, a
.test:
	ld e, 1
	call ApHasShot
	ret nz
	ld b, 1
	ld d, ITEM_TOPSPIN_SERVE
	call ApHasShot
	ret nz
	inc b
	inc d
	call ApHasShot
	ret nz
	inc b
	inc d
	call ApHasShot
	ret nz
	ld b, 1
	ret

; From ApServeBallPath: without the serve's second copy, a ball struck in the
; nice-serve band is lowered to the top of band 20
ApClampServeHeight:
	call ApShotsGated
	ret z
	ld hl, wBallHeight
	ld a, [hl+]
	ld d, [hl]
	ld e, a
	ld a, [wCurrentShotType]
	ld c, a
	call ApClampServeHeightFor
	ld a, e
	ld [wBallHeight], a
	ld a, d
	ld [wBallHeight + 1], a
	ret

; c = SHOTTYPE_SERVE_*, de = wBallHeight (negative up) -> de. Height band
; (-de >> 4) & $1f picks the serve's trajectory row and, from 21, the nice
; flag (SpecialShotFlagTable_07); without the item, bands 21-31 become 20.
ApClampServeHeightFor:
	push de
	ld a, c
	add ITEM_TOPSPIN_SERVE - SHOTTYPE_SERVE_TOPSPIN
	ld d, a
	ld e, 2
	call ApItemAtLeast
	pop de
	ret nz
	xor a
	sub e
	ld l, a
	sbc a
	sub d
	cp 1
	ret nz
	ld a, l
	cp $50
	ret c
	ld de, -$14f
	ret

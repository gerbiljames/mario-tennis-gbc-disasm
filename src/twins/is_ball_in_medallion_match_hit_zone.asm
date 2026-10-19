; Shared by IsBallInTreasureBoxHitZone, IsBallInMedallionMatchHitZone (bank
; $0d).

{TWIN_LABEL}:
	ld a, [wLastShotCharIndex]
	and $01
	jp nz, .returnZero
	ld hl, wMinigameSceneActor + MGACTOR_X
	ld a, [hl+]
	ld d, [hl]
	ld e, a
	ld hl, wBallX
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	ld a, l
	sub e
	ld l, a
	ld a, h
	sbc d
	ld h, a
	bit 7, h
	jr z, .positive
	xor a
	sub l
	ld l, a
	sbc a
	sub h
	ld h, a
.positive:
	ld de, $ffa0
	add hl, de
	jr c, .returnZero
	ld hl, wMinigameSceneActor + MGACTOR_DEPTH
	ld a, [hl+]
	ld d, [hl]
	ld e, a
	ld hl, wBallDepth
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	ld a, l
	sub e
	ld l, a
	ld a, h
	sbc d
	ld h, a
	bit 7, h
	jr z, .positive2
	xor a
	sub l
	ld l, a
	sbc a
	sub h
	ld h, a
.positive2:
	ld de, $ff80
	add hl, de
	jr c, .returnZero
	ld hl, wBallHeight
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	bit 7, h
	jr z, .positive3
	xor a
	sub l
	ld l, a
	sbc a
	sub h
	ld h, a
.positive3:
	ld de, $ff40
	add hl, de
	jr c, .returnZero
	ld a, $01
	ret
.returnZero:
	xor a
	ret

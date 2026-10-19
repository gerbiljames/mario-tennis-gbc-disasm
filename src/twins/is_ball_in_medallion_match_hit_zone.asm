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
	sub_hl_de
	abs_hl
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
	sub_hl_de
	abs_hl
	ld de, $ff80
	add hl, de
	jr c, .returnZero
	ld hl, wBallHeight
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	abs_hl
	ld de, $ff40
	add hl, de
	jr c, .returnZero
	ld a, $01
	ret
.returnZero:
	xor a
	ret

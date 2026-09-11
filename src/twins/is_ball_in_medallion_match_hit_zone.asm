; One body under 2 names (banks $0d, $0d), assembled through
; `twin_named is_ball_in_medallion_match_hit_zone, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	ld a, [wLastShotCharIndex]
	and $01
	jp nz, .returnZero
	ld hl, wMinigameSceneActor + 6
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
	ld hl, wMinigameSceneActor + 8
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

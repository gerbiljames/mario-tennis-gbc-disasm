; SnapCameraTo_<bank>, one copy in each of banks $08, $0d.

SnapCameraTo_{TWIN}:
	ld c, l
	ld b, h
	ld hl, wMatchCameraX
	ld a, c
	ld [hl+], a
	ld [hl], b
	ld hl, wMatchCameraTargetX
	ld a, c
	ld [hl+], a
	ld [hl], b
	ld hl, wMatchCameraY
	ld a, e
	ld [hl+], a
	ld [hl], d
	ld hl, wMatchCameraTargetY
	ld a, e
	ld [hl+], a
	ld [hl], d
	xor a
	ld [wCameraFollowBall], a
	ret

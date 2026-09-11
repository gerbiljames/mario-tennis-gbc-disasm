; One body under 2 names (banks $08, $0d), assembled through
; `twin_named snap_camera_to, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
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

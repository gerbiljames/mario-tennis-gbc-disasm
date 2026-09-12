; ShotBallPathSlice / ShotBallPathPowerSlice: one body under two names in
; banks $20 and $21,
; assembled through `twin_in shot_ball_path_slice, <Label>, <bank>` -- {TWIN_LABEL}
; is the bank's name for it and {TWIN} the bank suffix on the table and
; helper references. No per-instruction addresses: the twin_in line carries
; the copy's start. A fix here lands in both.

{TWIN_LABEL}:
	farcall ComputeShotPlacement
	push bc
	ld hl, BallPosData_{TWIN}
	ld bc, BallPosHeightOffsets_{TWIN}
	call LookupBallPosByHeight_{TWIN}
	ld bc, BallPosBlockOffsets_{TWIN}
	ld a, [wSlicePlacementIndex]
	call LookupBallPosByShotIndex_{TWIN}
	pop bc
	call ApplyBallTrajectory6Capped_{TWIN}
	ret

; ShotBallPathTopspin / ShotBallPathPowerTopspin: one body under two names in
; banks $22 and $23,
; assembled through `twin_in shot_ball_path_topspin, <Label>, <bank>` -- {TWIN_LABEL}
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
	ld a, [wTopspinPlacementIndex]
	call LookupBallPosByShotIndex_{TWIN}
	pop bc
	call ApplyBallTrajectory6Capped_{TWIN}
	ret

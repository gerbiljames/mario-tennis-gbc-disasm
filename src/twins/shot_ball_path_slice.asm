; Shared by ShotBallPathPowerSlice, ShotBallPathSlice (banks $20, $21).

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

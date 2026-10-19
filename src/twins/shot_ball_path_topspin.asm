; Shared by ShotBallPathPowerTopspin, ShotBallPathTopspin (banks $22, $23).

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

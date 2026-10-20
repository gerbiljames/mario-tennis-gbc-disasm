; Shared by ShotBallPathPowerTopspin, ShotBallPathTopspin (banks $22, $23).

{TWIN_LABEL}:
	farcall ComputeShotPlacement
	push bc
	ld hl, {BallPosData_{TWIN}_NAME}
	ld bc, {BallPosHeightOffsets_{TWIN}_NAME}
	call LookupBallPosByHeight_{TWIN}
	ld bc, {BallPosBlockOffsets_{TWIN}_NAME}
	ld a, [wTopspinPlacementIndex]
	call LookupBallPosByShotIndex_{TWIN}
	pop bc
	call ApplyBallTrajectory6Capped_{TWIN}
	ret

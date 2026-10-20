; Shared by ShotBallPathPowerSlice, ShotBallPathSlice (banks $20, $21).

{TWIN_LABEL}:
	farcall ComputeShotPlacement
	push bc
	ld hl, {BallPosData_{TWIN}_NAME}
	ld bc, {BallPosHeightOffsets_{TWIN}_NAME}
	call LookupBallPosByHeight_{TWIN}
	ld bc, {BallPosBlockOffsets_{TWIN}_NAME}
	ld a, [wSlicePlacementIndex]
	call LookupBallPosByShotIndex_{TWIN}
	pop bc
	call ApplyBallTrajectory6Capped_{TWIN}
	ret

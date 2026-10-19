; Shared by BananaBunchReflectBallAndRecordCell, FruitFantasyReflectBallAndRecordCell (bank $0d).

{TWIN_LABEL}:
	call ReflectBallVelocity
	call GetMinigameGridCellIndex
	ld [wMinigameLastHitCell], a
	ret

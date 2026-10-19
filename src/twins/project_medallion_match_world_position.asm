; Shared by ProjectTreasureBoxWorldPosition,
; ProjectMedallionMatchWorldPosition (bank $0d).

{TWIN_LABEL}:
	ld hl, wMinigameSceneActor + MGACTOR_SCREEN_X
	ld a, [hl+]
	ld e, a
	ld a, [hl+]
	ld d, a
	ld a, [hl+]
	ld c, a
	ld a, [hl+]
	ld b, a
	ld l, e
	ld h, d
	farcall ApplyCameraProjection
	ld b, $0f
	ret

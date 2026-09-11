; One body under 2 names (banks $0d, $0d), assembled through
; `twin_named project_medallion_match_world_position, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	ld hl, wMinigameSceneActor + 10
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

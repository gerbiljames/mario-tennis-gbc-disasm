; Shared by IslandOpenRoundSinglesNpc04_0f, IslandOpenRoundDoublesNpc04_0f
; (bank $0f).

{TWIN_LABEL}:
	script_set_text Text_TimeBeforeRoundTakeWalk
	ld a, [wMapSceneStage]
	dec a
	ld hl, Text_RoundNameRoundTwo
	add_hl_a
	call PushShortTextArg_0f
	script_speak ACTOR_ROLE_ISLAND_OPEN_ROUND_EMILY
	ret

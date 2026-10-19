; Shared by IslandOpenRoundSinglesNpc04_0f, IslandOpenRoundDoublesNpc04_0f
; (bank $0f).

{TWIN_LABEL}:
	script_set_text Text_TimeBeforeRoundTakeWalk
	ld a, [wMapSceneStage]
	dec a
	ld hl, Text_RoundNameRoundTwo
	add l
	ld l, a
	jr nc, .queue
	inc h
.queue:
	call PushShortTextArg_0f
	script_speak ACTOR_ROLE_ISLAND_OPEN_ROUND_B_COZ
	ret

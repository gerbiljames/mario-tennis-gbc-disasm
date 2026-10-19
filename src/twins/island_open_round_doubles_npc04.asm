; Shared by IslandOpenRoundSinglesNpc04_0f, IslandOpenRoundDoublesNpc04_0f
; (bank $0f).

{TWIN_LABEL}:
	script_set_text Text_25_73
	ld a, [wMapSceneStage]
	dec a
	ld hl, Text_25_98
	add l
	ld l, a
	jr nc, .queue
	inc h
.queue:
	call QueueShortText
	script_speak ACTOR_ROLE_ISLAND_OPEN_ROUND_B_COZ
	ret

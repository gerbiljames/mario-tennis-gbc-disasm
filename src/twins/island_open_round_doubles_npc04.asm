; One body under 2 names (banks $0f, $0f), assembled through
; `twin_named island_open_round_doubles_npc04, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

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

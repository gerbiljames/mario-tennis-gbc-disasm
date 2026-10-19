; Shared by DevelopmentFacing01_10, Test2Facing01_10, WallPracticeRoomFacing01_12, DormRoomFacing01_13 (banks $10, $12, $13).

{TWIN_LABEL}:
	farcall BeginCutsceneScriptMode
	script_fade_in 16
	script_set_text Text_DevMapSearchEvent
	script_speak ACTOR_PLAYER
	farcall EndCutsceneScriptMode
	ret

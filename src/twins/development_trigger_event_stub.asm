; Shared by DevelopmentTriggerEventStub_10, Test2TriggerEventStub_10 (bank $10).

{TWIN_LABEL}:
	farcall BeginCutsceneScriptMode
	script_set_text Text_DevMapTriggerEvent
	script_speak ACTOR_PLAYER
	farcall EndCutsceneScriptMode
	ret

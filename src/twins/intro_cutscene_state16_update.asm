; Shared by IntroCutsceneState16Update_6b, IntroCutsceneState17Update_6b (bank $6b).

{TWIN_LABEL}:
	ld a, [wCutsceneStepTimer]
	inc a
	ld [wCutsceneStepTimer], a
	cp $70
	jp z, DispatchCutsceneStateInit.loopB
	jp DispatchCutsceneStateInit.loop

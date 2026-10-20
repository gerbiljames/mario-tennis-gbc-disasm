; Shared by IntroCutsceneState13Update_6b, IntroCutsceneState14Update_6b (bank $6b).

{TWIN_LABEL}:
	ld a, [wCutsceneStepTimer]
	inc a
	ld [wCutsceneStepTimer], a
	cp $70
	jp z, DispatchCutsceneStateInit.runExit
	jp DispatchCutsceneStateInit.runUpdate

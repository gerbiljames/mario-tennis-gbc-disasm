; Shared by IntroCutsceneState06Update_6b, IntroCutsceneState13Update_6b (bank $6b).

{TWIN_LABEL}:
	ld a, [wCutsceneStepTimer]
	inc a
	ld [wCutsceneStepTimer], a
	cp $64
	jp z, DispatchCutsceneStateInit.runExit
	jp DispatchCutsceneStateInit.runUpdate

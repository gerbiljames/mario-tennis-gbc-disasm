; Shared by IntroCutsceneDiveUpdate_6b, IntroCutsceneGirlSwingUpdate_6b (bank $6b).

{TWIN_LABEL}:
	ld a, [wCutsceneStepTimer]
	inc a
	ld [wCutsceneStepTimer], a
	cp $2b
	jp z, DispatchCutsceneStateInit.runExit
	jp DispatchCutsceneStateInit.runUpdate

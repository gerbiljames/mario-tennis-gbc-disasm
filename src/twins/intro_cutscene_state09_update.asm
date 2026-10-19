; Shared by IntroCutsceneState09Update_6b, IntroCutsceneState10Update_6b (bank $6b).

{TWIN_LABEL}:
	ld a, [wCutsceneStepTimer]
	inc a
	ld [wCutsceneStepTimer], a
	cp $2b
	jp z, DispatchCutsceneStateInit.loopB
	jp DispatchCutsceneStateInit.loop

; Shared by IntroCutsceneAlexSwingExit_6b, IntroCutsceneNinaSwingExit_6b (bank $6b).

{TWIN_LABEL}:
	script_fade_out 6
	call WaitFadeEnd
	xor a
	ld [wCutsceneStepTimer], a
	jp DispatchCutsceneStateInit.nextState

; Shared by IntroCutsceneClosingTossUpdate_6b, IntroCutsceneOpeningTossUpdate_6b (bank
; $6b).

{TWIN_LABEL}:
	ld a, [wCutsceneStepTimer]
	inc a
	ld [wCutsceneStepTimer], a
	cp $80
	jp z, DispatchCutsceneStateInit.runExit
	cp $64
	jr nc, .updateBallY
	call AdvanceIntroBallSpinFrame
.updateBallY:
	call UpdateIntroBallY
	call UpdateIntroScrollY
	call SetCameraYFromScrollPos
	call QueueIntroSpinningBall
	call QueueCutsceneAnimatedSprites
	jp DispatchCutsceneStateInit.runUpdate

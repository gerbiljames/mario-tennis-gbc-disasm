; Shared by IntroCutsceneState19Update_6b, IntroCutsceneState00Update_6b (bank
; $6b).

{TWIN_LABEL}:
	ld a, [wCutsceneStepTimer]
	inc a
	ld [wCutsceneStepTimer], a
	cp $80
	jp z, DispatchCutsceneStateInit.runExit
	cp $64
	jr nc, .updateCutsceneScrollY
	call AdvanceSpriteAnimTimer
.updateCutsceneScrollY:
	call UpdateCutsceneScrollY
	call UpdateCutsceneScrollX
	call SetCameraYFromScrollPos
	call QueueScrollingSprite
	call QueueCutsceneAnimatedSprites
	jp DispatchCutsceneStateInit.runUpdate

; One body under 2 names (banks $6b, $6b), assembled through
; `twin_named intro_cutscene_state00_update, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	ld a, [wCutsceneStepTimer]
	inc a
	ld [wCutsceneStepTimer], a
	cp $80
	jp z, DispatchCutsceneStateInit.loopB
	cp $64
	jr nc, .updateCutsceneScrollY
	call AdvanceSpriteAnimTimer
.updateCutsceneScrollY:
	call UpdateCutsceneScrollY
	call UpdateCutsceneScrollX
	call SetCameraYFromScrollPos
	call QueueScrollingSprite
	call QueueCutsceneAnimatedSprites
	jp DispatchCutsceneStateInit.loop

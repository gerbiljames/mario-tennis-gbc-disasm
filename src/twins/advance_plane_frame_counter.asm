; Shared by AdvancePlaneFrameCounter_14, AdvancePlaneFrameCounter2_14 (bank $14).

{TWIN_LABEL}:
	ld a, [wCutsceneObjX]
	inc a
	ld [wCutsceneObjX], a
	ret

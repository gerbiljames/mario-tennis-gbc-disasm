; Shared by SetMenuCursorFromIndex_38, SetMenuCursorFromIndex_3b,
; Unused_16_SetMenuCursorFromIndex, SetMenuCursorFromIndex_3e (banks $16, $38,
; $3b, $3e).

{TWIN_LABEL}:
	ld d, $00
	ld a, c
.divLoop:
	cp b
	jr c, .store
	inc d
	sub b
	jr .divLoop
.store:
	ld [wMenuCursorX], a
	ld a, d
	ld [wMenuCursorY], a
	ret

; Shared by Unused_38_SetMenuCursorFromIndexToPtr,
; Unused_16_SetMenuCursorFromIndexToPtr, Unused_3e_SetMenuCursorFromIndexToPtr
; (banks $16, $38, $3e).

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
	ld [hl+], a
	ld a, d
	ld [hl], a
	ret

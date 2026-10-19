; Shared by MirrorPlayerSpriteIfLeftHanded, TogglePlayerSpriteXFlip (banks
; $0e, $15).

{TWIN_LABEL}:
	ld a, [wStoryMainLeftHanded]
	and a
	jr z, .done
	script_get_actor_state ACTOR_PLAYER
	ld c, l
	ld b, h
	ld hl, $0037
	add hl, bc
	ld a, [hl]
	xor $20
	ld [hl], a
.done:
	ret

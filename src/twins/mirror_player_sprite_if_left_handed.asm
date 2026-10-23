; Shared by MirrorPlayerSpriteIfLeftHanded, MirrorPlayerSpriteIfLeftHanded_15 (banks
; $0e, $15).

{TWIN_LABEL}:
	ld a, [wStoryMainLeftHanded]
	and a
	jr z, .done
	script_get_actor_state ACTOR_PLAYER
	ld c, l
	ld b, h
	ld hl, ACTORF_OAM_ATTR
	add hl, bc
	ld a, [hl]
	xor OAM_XFLIP
	ld [hl], a
.done:
	ret

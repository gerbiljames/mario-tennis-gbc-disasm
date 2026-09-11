; One body under 2 names (banks $0e, $15), assembled through
; `twin_named mirror_player_sprite_if_left_handed, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	ld a, [wStoryModeMainCharacterLeftHanded]
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

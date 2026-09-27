; One body under 2 names (banks $14, $15), assembled through
; `twin_named load_court_player_partner_obj_defs, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	test_flag FLAG_DOUBLES
	jp z, .notDoubles
	ld a, [wStoryModeGenderOfPartnerCharacter]
	ld d, OBJ_HARRY_B
	add d
	ld d, a
	script_get_actor_state ACTOR_PARTNER
	ld c, l
	ld b, h
	farcall LoadActorObjectDefIfValid
	script_set_anim ACTOR_PARTNER, $01
.notDoubles:
	ld a, [wStoryModeGenderOfMainCharacter]
	ld d, OBJ_ALEX_B
	add d
	ld d, a
	script_get_actor_state ACTOR_PLAYER
	ld c, l
	ld b, h
	farcall LoadActorObjectDefIfValid
	script_set_anim ACTOR_PLAYER, $01
	ret

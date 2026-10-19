; Shared by LoadCourtPlayerPartnerObjDefs_14, SetPlayerPartnerActorSprites
; (banks $14, $15).

{TWIN_LABEL}:
	test_flag FLAG_DOUBLES
	jp z, .notDoubles
	ld a, [wStoryPartnerGender]
	ld d, OBJ_HARRY_B
	add d
	ld d, a
	script_get_actor_state ACTOR_PARTNER
	ld c, l
	ld b, h
	farcall LoadActorObjectDefIfValid
	script_set_anim ACTOR_PARTNER, ANIM_WALK
.notDoubles:
	ld a, [wStoryMainGender]
	ld d, OBJ_ALEX_B
	add d
	ld d, a
	script_get_actor_state ACTOR_PLAYER
	ld c, l
	ld b, h
	farcall LoadActorObjectDefIfValid
	script_set_anim ACTOR_PLAYER, ANIM_WALK
	ret

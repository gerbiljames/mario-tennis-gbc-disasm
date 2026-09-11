QueueFinishedRoundNameText:
	test_flag FLAG_DOUBLES ; $78ec
	jr nz, .doubles ; $78ef
	ld a, [wMapSceneStage] ; $78f1
	dec a ; $78f4
	ld hl, $2861 ; $78f5
	add l ; $78f8
	ld l, a ; $78f9
	jr nc, .queue ; $78fa
	inc h ; $78fc
.queue:
	call QueueShortText ; $78fd
	ret ; $7900
.doubles:
	ld a, [wMapSceneStage] ; $7901
	dec a ; $7904
	ld hl, $2865 ; $7905
	add l ; $7908
	ld l, a ; $7909
	jr nc, .queueDoubles ; $790a
	inc h ; $790c
.queueDoubles:
	call QueueShortText ; $790d
	ret ; $7910
IslandOpenBreakCutscene:
	script_set_position $06, $1500, $1700 ; $7911
	script_set_position $07, $1700, $1700 ; $791c
	script_move_target $06, $2300, $1700 ; $7927
	script_move_target $07, $2500, $1700 ; $7932
	script_wait_move $07 ; $793d
	script_set_text Text_25_105 ; $7942
	script_move_player $2300, $1100 ; $7948
	farcall WaitPlayerMoveDone ; $7952
	script_face $03, FACE_DOWN ; $7955
	script_face $04, FACE_DOWN ; $795c
	script_face $05, FACE_DOWN ; $7963
	script_face ACTOR_PLAYER, FACE_DOWN ; $796a
	script_face ACTOR_PARTNER, FACE_DOWN ; $7971
	script_face $06, FACE_UP ; $7978
	script_face $07, FACE_UP ; $797f
	script_set_anim $06, $03 ; $7986
	script_wait_idle $06 ; $798d
	call QueueFinishedRoundNameText ; $7992
	script_speak $06 ; $7995
	script_set_anim $06, $03 ; $799a
	script_wait_idle $06 ; $79a1
	ld a, [wMapSceneStage] ; $79a6
	ld hl, $2861 ; $79a9
	add l ; $79ac
	ld l, a ; $79ad
	jr nc, .queue ; $79ae
	inc h ; $79b0
.queue:
	call QueueShortText ; $79b1
	script_speak $06 ; $79b4
	script_face_pair $07, $06 ; $79b9
	script_wait_frames $14 ; $79c1
	script_set_anim $06, $03 ; $79c8
	script_set_anim $07, $03 ; $79cf
	script_wait_idle $07 ; $79d6
	script_move_target $06, $1500, $1700 ; $79db
	script_move_target $07, $1700, $1700 ; $79e6
	script_wait_move $07 ; $79f1
	script_move_player_to_actor ACTOR_PLAYER ; $79f6
	script_set_position $06, $3f00, $3f00 ; $79fd
	script_set_position $07, $3f00, $3f00 ; $7a08
	farcall WaitPlayerMoveDone ; $7a13
	ret ; $7a16
ReplacePartnerWithStandInActor:
	call SetPlayerAndPartnerObjectDefs ; $7a17
	test_flag FLAG_DOUBLES ; $7a1a
	jr z, .noPartner ; $7a1d
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $7a1f
	or a ; $7a22
	jr nz, .female ; $7a23
	ld d, $58 ; $7a25
	jr .apply ; $7a27
.noPartner:
	ret ; $7a29
.female:
	ld d, $59 ; $7a2a
	jr .apply ; $7a2c
.apply:
	script_get_actor_state $05 ; $7a2e
	ld c, l ; $7a33
	ld b, h ; $7a34
	farcall LoadActorObjectDefIfValid ; $7a35
	script_set_anim $05, $01 ; $7a38
	script_null_script ACTOR_PARTNER ; $7a3f
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $7a44
	ret ; $7a4f
ActorScript_0f_07:
	; $7a50, 35 bytes (actor_script)
	as_flag $01, $05, $02
	as_set_field $06, $0010
.L8:
	as_target_rel $fe00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_wait $4b
	as_target_rel $0200, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_wait $4b
	as_jump .L8
ActorScript_0f_08:
	; $7a73, 27 bytes (actor_script)
	as_flag $01, $05, $02
	as_set_field $06, $0006
.L8:
	as_set_target $2700, $1300
	as_wait_move
	as_wait $4b
	as_set_target $2900, $1300
	as_wait_move
	as_wait $78
	as_jump .L8
QueueShortText:
	push_wram_bank $07 ; $7a8e
	ld de, wTextArgFetchBuffer ; $7a97
	wram_bank $05 ; $7a9a
	farcall FetchShortTextToBuffer ; $7aa0
	ld hl, wTextArgFetchBuffer ; $7aa3
	farcall PushTextArgString ; $7aa6
	pop_wram_bank ; $7aa9
	ret ; $7aae
WalkActorsInFromEntryPoint_0f:
	ld a, [wStoryModeEntryPoint] ; $7aaf
	cp STORYENTRY_NONE ; $7ab2
	jp z, .done ; $7ab4
	test_flag FLAG_DOUBLES ; $7ab7
	jr z, .walkOff ; $7aba
	script_set_speed ACTOR_PARTNER, $00ff ; $7abc
	ld a, [wStoryModeEntryPoint] ; $7ac4
	dec a ; $7ac7
	ld_hl_indexed WalkActorsInFromEntryPointFacings_0f + 5 ; $7ac8
	ld b, [hl] ; $7acf
	ld a, $02 ; $7ad0
	ld b, b ; $7ad2
	ld de, $0200 ; $7ad3
	farcall MoveActorByAngle ; $7ad6
	script_wait_move ACTOR_PARTNER ; $7ad9
	ld a, [wStoryModeEntryPoint] ; $7ade
	dec a ; $7ae1
	ld_hl_indexed WalkActorsInFromEntryPointFacings_0f ; $7ae2
	ld b, [hl] ; $7ae9
	ld a, $02 ; $7aea
	ld b, b ; $7aec
	farcall SetActorFacing ; $7aed
	script_set_speed ACTOR_PARTNER, $0010 ; $7af0
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $7af8
	ld a, [wStoryModeEntryPoint] ; $7b00
	dec a ; $7b03
	ld_hl_indexed WalkActorsInFromEntryPointFacings_0f ; $7b04
	ld b, [hl] ; $7b0b
	ld a, $00 ; $7b0c
	ld b, b ; $7b0e
	ld de, $0200 ; $7b0f
	farcall MoveActorByAngle ; $7b12
.done:
	ret ; $7b15
WalkActorsInFromEntryPointFacings_0f:
	; $7b16, 10 bytes (enum:FACE:10)
	db FACE_DOWN, FACE_DOWN, FACE_RIGHT, FACE_LEFT, FACE_UP, FACE_UP, FACE_UP, FACE_LEFT, FACE_RIGHT, FACE_DOWN ; 0x00
SetPlayerAndPartnerObjectDefs:
	test_flag FLAG_DOUBLES ; $7b20
	jp z, .mainChar ; $7b23
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $7b26
	ld d, $58 ; $7b29
	add d ; $7b2b
	ld d, a ; $7b2c
	script_get_actor_state ACTOR_PARTNER ; $7b2d
	ld c, l ; $7b32
	ld b, h ; $7b33
	farcall LoadActorObjectDefIfValid ; $7b34
	script_set_anim ACTOR_PARTNER, $01 ; $7b37
.mainChar:
	ld a, [wStoryModeGenderOfMainCharacter] ; $7b3e
	ld d, $56 ; $7b41
	add d ; $7b43
	ld d, a ; $7b44
	script_get_actor_state ACTOR_PLAYER ; $7b45
	ld c, l ; $7b4a
	ld b, h ; $7b4b
	farcall LoadActorObjectDefIfValid ; $7b4c
	script_set_anim ACTOR_PLAYER, $01 ; $7b4f
	ret ; $7b56
ActorScript_0f_09:
	; $7b57, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_0f_10:
	; $7b61, 20 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $02, $02
	as_wait_move2
	as_wait $28
	as_jump .L1
	as_begin_path
.Lb:
	as_rand_box $01, $02
	as_wait_move2
	as_wait $28
	as_jump .Lb
ActorScript_0f_11:
	; $7b75, 10 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $01, $01
	as_wait_move2
	as_wait $28
	as_jump .L1
MapScriptNopAlt_0f:
	ret ; $7b7f
MapScriptClearActiveFlag_0f:
	xor a ; $7b80
	ld [wStoryScriptRan], a ; $7b81
	ret ; $7b84
MapScriptPlaySoundA2_0f:
	sound SFX_STORY_CUE ; $7b85
	ret ; $7b87
MapScriptHideLocationName_0f:
	xor a ; $7b88
	ld [wStoryModeShowLocationName], a ; $7b89
	ret ; $7b8c
ActorScript_0f_12:
	; $7b8d, 438 bytes (actor_script)
	as_anim $01
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_jump ActorScript_0f_12
	as_anim $00
	as_wait $3c
.L67:
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_jump .L67
	as_anim $00
	as_wait $1e
.Lce:
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_jump .Lce
	as_anim $00
	as_wait $1e
	as_wait $3c
.L137:
	as_anim $01
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_jump .L137
.L19a:
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump .L19a
.L1a7:
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump .L1a7
ComputeRankingProgressIndex_0f:
	test_flag FLAG_DOUBLES ; $7d43
	jr nz, .doubles ; $7d46
	ld a, STORYRANK_SINGLES_ACADEMY ; $7d48
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7d4a
	jr z, .loop ; $7d4d
	ld a, STORYRANK_SINGLES_JUNIOR_CHAMP ; $7d4f
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7d51
	jr z, .loop ; $7d54
	ld a, STORYRANK_SINGLES_SENIOR_CHAMP ; $7d56
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7d58
	jr z, .loop ; $7d5b
	ld a, STORYRANK_SINGLES_ISLAND_OPEN ; $7d5d
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7d5f
	jr z, .loop ; $7d62
	ld a, STORYRANK_SINGLES_COMPLETE ; $7d64
.loop:
	ld [wMapSceneStage], a ; $7d66
	ret ; $7d69
.doubles:
	ld a, STORYRANK_DOUBLES_ACADEMY ; $7d6a
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7d6c
	jr z, .loop ; $7d6f
	ld a, STORYRANK_DOUBLES_JUNIOR_CHAMP ; $7d71
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7d73
	jr z, .loop ; $7d76
	ld a, STORYRANK_DOUBLES_SENIOR_CHAMP ; $7d78
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7d7a
	jr z, .loop ; $7d7d
	ld a, STORYRANK_DOUBLES_ISLAND_OPEN ; $7d7f
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7d81
	jr z, .loop ; $7d84
	ld a, STORYRANK_DOUBLES_COMPLETE ; $7d86
	jr .loop ; $7d88
; This bank's copy of ComputeStoryRankTier_13, identical instruction for instruction: the shared story include carried it into every story bank, and only bank $13's copy is called (by SetStoryRankTier). Nothing calls this one.
Unused_0f_ComputeStoryRankTier:
	ld a, $00 ; $7d8a
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7d8c
	jr z, .loopB ; $7d8f
	inc a ; $7d91
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7d92
	jr z, .loopB ; $7d95
	inc a ; $7d97
	test_flag FLAG_DOUBLES ; $7d98
	jr nz, .doublesIsland ; $7d9b
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7d9d
	jr z, .loopB ; $7da0
	inc a ; $7da2
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7da3
	jr z, .loopB ; $7da6
	inc a ; $7da8
.loopB:
	ld [wMapSceneStage], a ; $7da9
	ret ; $7dac
.doublesIsland:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7dad
	jr z, .loopB ; $7db0
	inc a ; $7db2
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7db3
	jr z, .loopB ; $7db6
	inc a ; $7db8
	jr .loopB ; $7db9
	; $7dbb, 581 bytes fill to bank end (linker-padded)

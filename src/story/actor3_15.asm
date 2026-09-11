ActorScript_15_16:
	; $7b96, 29 bytes (actor_script)
	as_set_target $2f00, $2900
	as_wait_move
	as_set_target $2f00, $2300
	as_wait_move
	as_set_target $2d00, $2300
	as_wait_move
	as_set_target $2700, $1f00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_15_17:
	; $7bb3, 11 bytes (actor_script)
	as_set_target $2900, $2f00
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_15_18:
	; $7bbe, 11 bytes (actor_script)
	as_set_target $2d00, $2d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ReturnCoachWalkToCourtAndStartLesson:
	script_null_script ACTOR_PARTNER ; $7bc9
	script_player_speed $0020 ; $7bce
	script_set_actor_script $0d, ActorScript_15_19 ; $7bd4
	script_set_actor_script ACTOR_PLAYER, ActorScript_15_20 ; $7bdf
	script_set_actor_script ACTOR_PARTNER, ActorScript_15_21 ; $7bea
	script_move_player $1800, $2700 ; $7bf5
	script_wait_actor_script ACTOR_PLAYER ; $7bff
	farcall WaitPlayerMoveDone ; $7c04
	script_wait_actor_script $0d ; $7c07
	script_wait_frames $05 ; $7c0c
	call PlayerPartnerGestureCutscene ; $7c13
	ld a, STORYLOC_TRAINING_COURT ; $7c16
	ld [wStoryModeCurrentLocation], a ; $7c18
	ld a, $0a ; $7c1b
	ld [wStoryModeEntryPoint], a ; $7c1d
	ld a, $ff ; $7c20
	ld [wUnusedExitTriggerIdMirror], a ; $7c22
	ld [wStoryModeExitTriggerRequest], a ; $7c25
	ld a, [wCurrentMinigameStoryMatch + 1] ; $7c28
	farcall RunTrainingDrillByID ; $7c2b
	ret ; $7c2e
ActorScript_15_19:
	; $7c2f, 29 bytes (actor_script)
	as_set_target $1100, $2900
	as_wait_move
	as_set_target $1100, $2500
	as_wait_move
	as_set_target $1300, $2500
	as_wait_move
	as_set_target $1700, $1f00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_15_20:
	; $7c4c, 11 bytes (actor_script)
	as_set_target $1900, $2f00
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_15_21:
	; $7c57, 11 bytes (actor_script)
	as_set_target $1300, $2d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
MovePartyToServeCoachSpot:
	script_set_speed ACTOR_PLAYER, $0010 ; $7c62
	script_set_speed ACTOR_PARTNER, $0010 ; $7c6a
	script_move_target ACTOR_PLAYER, $1300, $1300 ; $7c72
	test_flag FLAG_DOUBLES ; $7c7d
	jr z, .waitPlayer ; $7c80
	script_null_script ACTOR_PARTNER ; $7c82
	script_move_target ACTOR_PARTNER, $1300, $1100 ; $7c87
	script_wait_move ACTOR_PARTNER ; $7c92
.waitPlayer:
	script_wait_move ACTOR_PLAYER ; $7c97
	script_face ACTOR_PLAYER, FACE_RIGHT ; $7c9c
	script_face ACTOR_PARTNER, FACE_RIGHT ; $7ca3
	script_set_speed ACTOR_PLAYER, $0020 ; $7caa
	script_set_speed ACTOR_PARTNER, $0020 ; $7cb2
	ret ; $7cba
MovePartyToNetCoachSpot:
	script_set_speed ACTOR_PLAYER, $0010 ; $7cbb
	script_set_speed ACTOR_PARTNER, $0010 ; $7cc3
	script_move_target ACTOR_PLAYER, $2d00, $2b00 ; $7ccb
	test_flag FLAG_DOUBLES ; $7cd6
	jr z, .wait ; $7cd9
	script_null_script ACTOR_PARTNER ; $7cdb
	script_move_target ACTOR_PARTNER, $2f00, $2b00 ; $7ce0
	script_wait_move ACTOR_PARTNER ; $7ceb
.wait:
	script_wait_move ACTOR_PLAYER ; $7cf0
	script_face ACTOR_PLAYER, FACE_LEFT ; $7cf5
	script_face ACTOR_PARTNER, FACE_LEFT ; $7cfc
	script_set_speed ACTOR_PLAYER, $0020 ; $7d03
	script_set_speed ACTOR_PARTNER, $0020 ; $7d0b
	ret ; $7d13
MovePartyToReturnCoachSpot:
	script_set_speed ACTOR_PLAYER, $0010 ; $7d14
	script_set_speed ACTOR_PARTNER, $0010 ; $7d1c
	script_move_target ACTOR_PLAYER, $1300, $2b00 ; $7d24
	test_flag FLAG_DOUBLES ; $7d2f
	jr z, .wait ; $7d32
	script_null_script ACTOR_PARTNER ; $7d34
	script_move_target ACTOR_PARTNER, $1100, $2b00 ; $7d39
	script_wait_move ACTOR_PARTNER ; $7d44
.wait:
	script_wait_move ACTOR_PLAYER ; $7d49
	script_face ACTOR_PLAYER, FACE_RIGHT ; $7d4e
	script_face ACTOR_PARTNER, FACE_RIGHT ; $7d55
	script_set_speed ACTOR_PLAYER, $0020 ; $7d5c
	script_set_speed ACTOR_PARTNER, $0020 ; $7d64
	ret ; $7d6c
ActorScript_15_22:
	; $7d6d, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_15_23:
	; $7d77, 30 bytes (actor_script)
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
	as_begin_path
.L15:
	as_rand_box $01, $01
	as_wait_move2
	as_wait $28
	as_jump .L15
MapScriptNop_15:
	ret ; $7d95
MapScriptClearActiveFlag_15:
	xor a ; $7d96
	ld [wStoryScriptRan], a ; $7d97
	ret ; $7d9a
MapScriptPlaySoundA2_15:
	sound SFX_STORY_CUE ; $7d9b
	ret ; $7d9d
MapScriptHideLocationName_15:
	xor a ; $7d9e
	ld [wStoryModeShowLocationName], a ; $7d9f
	ret ; $7da2
ActorScript_15_24:
	; $7da3, 410 bytes (actor_script)
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
	as_jump ActorScript_15_24
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
ActorScript_15_25:
	; $7f3d, 28 bytes (actor_script)
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump ActorScript_15_25
.Ld:
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump .Ld
; Instruction-identical to ComputeRankingProgressIndex_13 and ComputeRankingProgressIndex_14 (one copy per bank); a change here belongs in every copy.
ComputeRankingProgressIndex_15:
	test_flag FLAG_DOUBLES ; $7f59
	jr nz, .isDoubles ; $7f5c
	ld a, STORYRANK_SINGLES_ACADEMY ; $7f5e
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7f60
	jr z, .loop ; $7f63
	ld a, STORYRANK_SINGLES_JUNIOR_CHAMP ; $7f65
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7f67
	jr z, .loop ; $7f6a
	ld a, STORYRANK_SINGLES_SENIOR_CHAMP ; $7f6c
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7f6e
	jr z, .loop ; $7f71
	ld a, STORYRANK_SINGLES_ISLAND_OPEN ; $7f73
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7f75
	jr z, .loop ; $7f78
	ld a, STORYRANK_SINGLES_COMPLETE ; $7f7a
.loop:
	ld [wMapSceneStage], a ; $7f7c
	ret ; $7f7f
.isDoubles:
	ld a, STORYRANK_DOUBLES_ACADEMY ; $7f80
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7f82
	jr z, .loop ; $7f85
	ld a, STORYRANK_DOUBLES_JUNIOR_CHAMP ; $7f87
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7f89
	jr z, .loop ; $7f8c
	ld a, STORYRANK_DOUBLES_SENIOR_CHAMP ; $7f8e
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7f90
	jr z, .loop ; $7f93
	ld a, STORYRANK_DOUBLES_ISLAND_OPEN ; $7f95
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7f97
	jr z, .loop ; $7f9a
	ld a, STORYRANK_DOUBLES_COMPLETE ; $7f9c
	jr .loop ; $7f9e
; Instruction-identical to ComputeStoryRankTier_13 (one copy per bank); a change here belongs in every copy.
ComputeStoryRankTier_15:
	ld a, $00 ; $7fa0
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7fa2
	jr z, .loop ; $7fa5
	inc a ; $7fa7
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7fa8
	jr z, .loop ; $7fab
	inc a ; $7fad
	test_flag FLAG_DOUBLES ; $7fae
	jr nz, .checkFlag ; $7fb1
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7fb3
	jr z, .loop ; $7fb6
	inc a ; $7fb8
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7fb9
	jr z, .loop ; $7fbc
	inc a ; $7fbe
.loop:
	ld [wMapSceneStage], a ; $7fbf
	ret ; $7fc2
.checkFlag:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7fc3
	jr z, .loop ; $7fc6
	inc a ; $7fc8
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7fc9
	jr z, .loop ; $7fcc
	inc a ; $7fce
	jr .loop ; $7fcf
	; $7fd1, 47 bytes fill to bank end (linker-padded)

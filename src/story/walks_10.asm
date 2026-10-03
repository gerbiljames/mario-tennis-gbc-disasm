; Instruction-identical to ReadSceneTilemapTile_0f (one copy per bank); a change here belongs in every copy.
	twin read_scene_tilemap_tile, 10 ; $7ac8 ReadSceneTilemapTile_10
MapExitWalkCurveRight_10:
	script_set_speed ACTOR_PLAYER, 0.5 ; $7ae6
	script_set_speed ACTOR_PARTNER, 0.5 ; $7aee
	script_move_angle ACTOR_PLAYER, FACE_UP, 1.0 ; $7af6
	script_wait_move ACTOR_PLAYER ; $7b00
	script_move_angle ACTOR_PLAYER, $e0, 0.5 ; $7b05
	script_wait_move ACTOR_PLAYER ; $7b0f
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, 0.75 ; $7b14
	ret ; $7b1e
MapExitWalkCurveLeft_10:
	ld a, [wStoryModeEntryPoint] ; $7b1f
	cp STORYENTRY_NONE ; $7b22
	jr z, .done ; $7b24
	script_set_speed ACTOR_PARTNER, 0.5 ; $7b26
	script_set_speed ACTOR_PLAYER, 0.5 ; $7b2e
	script_move_angle ACTOR_PLAYER, FACE_UP, 0.75 ; $7b36
	script_wait_move ACTOR_PLAYER ; $7b40
	script_move_angle ACTOR_PLAYER, $a0, 0.5 ; $7b45
	script_wait_move ACTOR_PLAYER ; $7b4f
	script_move_angle ACTOR_PLAYER, FACE_LEFT, 0.5 ; $7b54
.done:
	ret ; $7b5e
MapArrivalWalkPair_10:
	ld a, [wStoryModeEntryPoint] ; $7b5f
	cp STORYENTRY_NONE ; $7b62
	jr z, .done ; $7b64
	script_set_speed ACTOR_PLAYER, 0.5 ; $7b66
	script_set_speed ACTOR_PARTNER, 0.5 ; $7b6e
	script_move_angle ACTOR_PLAYER, FACE_DOWN, 2.5 ; $7b76
	script_move_angle ACTOR_PARTNER, FACE_DOWN, 2.0 ; $7b80
.done:
	ret ; $7b8a
ActorScript_10_1:
	; $7b8b, 43 bytes (actor_script)
	as_set_field $06, $0018
	as_flag $01, $05, $02
.L8:
	as_set_target 27.0, 23.125
	as_wait_move2
	as_wait 5
	as_set_target 29.0, 23.125
	as_wait_move2
	as_wait 10
	as_set_target 29.0, 22.0
	as_wait_move2
	as_wait 10
	as_set_target 29.0, 23.125
	as_wait_move2
	as_wait 5
	as_jump .L8
GetDoublesProgressStage_10:
	ld a, $00 ; $7bb6
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7bb8
	jr z, .done ; $7bbb
	inc a ; $7bbd
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7bbe
	jr z, .done ; $7bc1
	inc a ; $7bc3
	test_flag FLAG_WON_VARSITY_DOUBLES_RANK_2 ; $7bc4
	jr z, .done ; $7bc7
	inc a ; $7bc9
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7bca
	jr z, .done ; $7bcd
	inc a ; $7bcf
.done:
	ret ; $7bd0
ActorScript_10_2:
	; $7bd1, 10 bytes (actor_script)
	as_halt
	as_anim ANIM_STILL
	as_halt
.L4:
	as_step
	as_wait 1
	as_jump .L4
ActorScript_10_3:
	; $7bdb, 30 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $02, $02
	as_wait_move2
	as_wait 40
	as_jump .L1
	as_begin_path
.Lb:
	as_rand_box $01, $02
	as_wait_move2
	as_wait 40
	as_jump .Lb
	as_begin_path
.L15:
	as_rand_box $01, $01
	as_wait_move2
	as_wait 40
	as_jump .L15
MapScriptNop_10:
	ret ; $7bf9
Unused_10_MapScriptClearActiveFlag:
	xor a ; $7bfa
	ld [wStoryScriptRan], a ; $7bfb
	ret ; $7bfe
Unused_10_MapScriptPlaySoundA2:
	sound SFX_STORY_CUE ; $7bff
	ret ; $7c01
Unused_10_MapScriptHideLocationName:
	xor a ; $7c02
	ld [wStoryModeShowLocationName], a ; $7c03
	ret ; $7c06
ActorScript_10_4:
	; $7c07, 438 bytes (actor_script)
	as_anim ANIM_WALK
	as_target_rel 4.0, 2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel 4.0, -2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_jump ActorScript_10_4
	as_anim ANIM_STILL
	as_wait 60
.L67:
	as_anim ANIM_WALK
	as_target_rel -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel -4.0, -2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel -4.0, 2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_jump .L67
	as_anim ANIM_STILL
	as_wait 30
.Lce:
	as_anim ANIM_WALK
	as_target_rel 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel 4.0, 2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel 4.0, -2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_jump .Lce
	as_anim ANIM_STILL
	as_wait 30
	as_wait 60
.L137:
	as_anim ANIM_WALK
	as_target_rel -4.0, -2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel -4.0, 2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_jump .L137
.L19a:
	as_wait 240
	as_anim ANIM_NOD
	as_wait 80
	as_anim ANIM_NOD
	as_wait 60
	as_jump .L19a
.L1a7:
	as_wait 140
	as_anim ANIM_SHAKE
	as_wait 140
	as_anim ANIM_SHAKE
	as_wait 140
	as_anim ANIM_NOD
	as_jump .L1a7
SetStoryDialogueStage_10:
	test_flag FLAG_DOUBLES ; $7dbd
	jr nz, .doublesStage ; $7dc0
	ld a, STORYRANK_SINGLES_ACADEMY ; $7dc2
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7dc4
	jr z, .store ; $7dc7
	ld a, STORYRANK_SINGLES_JUNIOR_CHAMP ; $7dc9
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7dcb
	jr z, .store ; $7dce
	ld a, STORYRANK_SINGLES_SENIOR_CHAMP ; $7dd0
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7dd2
	jr z, .store ; $7dd5
	ld a, STORYRANK_SINGLES_ISLAND_OPEN ; $7dd7
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7dd9
	jr z, .store ; $7ddc
	ld a, STORYRANK_SINGLES_COMPLETE ; $7dde
.store:
	ld [wMapSceneStage], a ; $7de0
	ret ; $7de3
.doublesStage:
	ld a, STORYRANK_DOUBLES_ACADEMY ; $7de4
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7de6
	jr z, .store ; $7de9
	ld a, STORYRANK_DOUBLES_JUNIOR_CHAMP ; $7deb
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7ded
	jr z, .store ; $7df0
	ld a, STORYRANK_DOUBLES_SENIOR_CHAMP ; $7df2
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7df4
	jr z, .store ; $7df7
	ld a, STORYRANK_DOUBLES_ISLAND_OPEN ; $7df9
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7dfb
	jr z, .store ; $7dfe
	ld a, STORYRANK_DOUBLES_COMPLETE ; $7e00
	jr .store ; $7e02
; This bank's copy of ComputeStoryRankTier_13, identical instruction for instruction: the shared story include carried it into every story bank, and only bank $13's copy is called (by Unused_27_SetStoryRankTier). Nothing calls this one.
Unused_10_ComputeStoryRankTier:
	ld a, $00 ; $7e04
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7e06
	jr z, .storeIsland ; $7e09
	inc a ; $7e0b
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7e0c
	jr z, .storeIsland ; $7e0f
	inc a ; $7e11
	test_flag FLAG_DOUBLES ; $7e12
	jr nz, .doublesIsland ; $7e15
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7e17
	jr z, .storeIsland ; $7e1a
	inc a ; $7e1c
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7e1d
	jr z, .storeIsland ; $7e20
	inc a ; $7e22
.storeIsland:
	ld [wMapSceneStage], a ; $7e23
	ret ; $7e26
.doublesIsland:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7e27
	jr z, .storeIsland ; $7e2a
	inc a ; $7e2c
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7e2d
	jr z, .storeIsland ; $7e30
	inc a ; $7e32
	jr .storeIsland ; $7e33
	; $7e35, 459 bytes fill to bank end (linker-padded)

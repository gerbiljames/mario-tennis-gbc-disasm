ActorScript_27_26:
	; $7607, 7 bytes (actor_script)
	as_anim $02
	as_wait $50
	as_jump ActorScript_27_26
End1MainBldgGroupDepartureCutscene_27:
	script_set_position $06, $3f00, $3f00 ; $760e
	test_flag FLAG_DOUBLES ; $7619
	jp z, .checkStoryModeGenderOfMainCharacter ; $761c
	script_null_script ACTOR_PARTNER ; $761f
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $7624
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $762f
	ld d, OBJ_HARRY_B ; $7632
	add d ; $7634
	ld d, a ; $7635
	script_get_actor_state $0a ; $7636
	ld c, l ; $763b
	ld b, h ; $763c
	farcall LoadActorObjectDefIfValid ; $763d
	script_set_anim $0a, $01 ; $7640
	script_set_position $0c, $1a00, $1100 ; $7647
	script_face $0c, FACE_DOWN ; $7652
.checkStoryModeGenderOfMainCharacter:
	ld a, [wStoryModeGenderOfMainCharacter] ; $7659
	ld d, OBJ_ALEX_B ; $765c
	add d ; $765e
	ld d, a ; $765f
	script_get_actor_state ACTOR_PLAYER ; $7660
	ld c, l ; $7665
	ld b, h ; $7666
	farcall LoadActorObjectDefIfValid ; $7667
	script_set_anim ACTOR_PLAYER, $01 ; $766a
	script_set_position ACTOR_PLAYER, $1700, $1700 ; $7671
	script_face ACTOR_PLAYER, FACE_UP ; $767c
	script_fade_in $04 ; $7683
	call WaitFadeEnd ; $7688
	script_delay $3c ; $768b
	test_flag FLAG_DOUBLES ; $7690
	jp z, .face ; $7693
	script_face_pair $0a, ACTOR_PLAYER ; $7696
	script_delay $1e ; $769e
	script_set_anim ACTOR_PLAYER, $03 ; $76a3
	script_set_anim $0a, $03 ; $76aa
	script_wait_idle $0a ; $76b1
	script_delay $1e ; $76b6
	script_face $0a, FACE_UP ; $76bb
	script_delay $1e ; $76c2
	script_set_anim $0c, $02 ; $76c7
	script_wait_idle $0c ; $76ce
	script_delay $32 ; $76d3
	script_face_pair $0c, $08 ; $76d8
	script_set_anim $08, $03 ; $76e0
	script_set_anim $0c, $03 ; $76e7
	script_wait_idle $0c ; $76ee
	script_face $0c, FACE_DOWN ; $76f3
	script_face $08, FACE_DOWN ; $76fa
	jp .step ; $7701
.face:
	script_face_pair $0b, ACTOR_PLAYER ; $7704
	script_delay $1e ; $770c
	script_set_anim ACTOR_PLAYER, $03 ; $7711
	script_set_anim $0b, $03 ; $7718
	script_wait_idle $0b ; $771f
	script_delay $0a ; $7724
	script_face ACTOR_PLAYER, FACE_UP ; $7729
	script_face $0b, FACE_UP ; $7730
	script_delay $14 ; $7737
	script_set_anim $08, $03 ; $773c
	script_wait_idle $08 ; $7743
.step:
	script_delay $28 ; $7748
	script_set_anim $09, $03 ; $774d
	script_set_anim $0a, $03 ; $7754
	script_set_anim ACTOR_PLAYER, $03 ; $775b
	script_set_anim $0b, $03 ; $7762
	script_wait_idle $0b ; $7769
	script_delay $14 ; $776e
	script_face_pair $0b, ACTOR_PLAYER ; $7773
	script_face_pair $09, $0a ; $777b
	script_delay $0a ; $7783
	script_facing_lock ACTOR_PLAYER, $01 ; $7788
	script_facing_lock $0b, $01 ; $778f
	script_facing_lock $0a, $01 ; $7796
	script_facing_lock $09, $01 ; $779d
	script_move_target ACTOR_PLAYER, $1600, $1700 ; $77a4
	script_move_target $0b, $1a00, $1700 ; $77af
	script_move_target $0a, $1500, $1500 ; $77ba
	script_move_target $09, $1b00, $1500 ; $77c5
	script_wait_move $09 ; $77d0
	script_player_speed $0020 ; $77d5
	script_move_player $1800, $2f00 ; $77db
	script_move_target $08, $1800, $1900 ; $77e5
	script_wait_move $08 ; $77f0
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $77f5
	script_facing_lock $0b, FACE_RIGHT ; $77fc
	script_facing_lock $0a, FACE_RIGHT ; $7803
	script_facing_lock $09, FACE_RIGHT ; $780a
	script_move_target ACTOR_PLAYER, $1600, $1f00 ; $7811
	script_move_target $0b, $1a00, $1f00 ; $781c
	script_move_target $0a, $1500, $1d00 ; $7827
	script_move_target $09, $1b00, $1d00 ; $7832
	script_move_target $08, $1800, $2100 ; $783d
	script_wait_move $08 ; $7848
	ld a, $05 ; $784d
	ld [wUnusedExitTriggerIdMirror], a ; $784f
	ld [wStoryModeExitTriggerRequest], a ; $7852
	ret ; $7855
WaitScriptFramesSaveA:
	push af ; $7856
	ld a, a ; $7857
	farcall WaitScriptFrames ; $7858
	pop af ; $785b
	ret ; $785c
ActorScript_27_27:
	; $785d, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_27_28:
	; $7867, 20 bytes (actor_script)
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
ActorScript_27_29:
	; $787b, 10 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $01, $01
	as_wait_move2
	as_wait $28
	as_jump .L1
MapScriptNop_27:
	ret ; $7885
MapScriptClearActiveFlag_27:
	xor a ; $7886
	ld [wStoryScriptRan], a ; $7887
	ret ; $788a
MapScriptPlaySoundA2_27:
	sound SFX_STORY_CUE ; $788b
	ret ; $788d
MapScriptHideLocationName_27:
	xor a ; $788e
	ld [wStoryModeShowLocationName], a ; $788f
	ret ; $7892
ActorScript_27_30:
	; $7893, 99 bytes (actor_script)
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
	as_jump ActorScript_27_30
ActorScript_27_31:
	; $78f6, 103 bytes (actor_script)
	as_anim $00
	as_wait $3c
.L4:
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
	as_jump .L4
ActorScript_27_32:
	; $795d, 103 bytes (actor_script)
	as_anim $00
	as_wait $1e
.L4:
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
	as_jump .L4
ActorScript_27_33:
	; $79c4, 133 bytes (actor_script)
	as_anim $00
	as_wait $1e
	as_wait $3c
.L6:
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
	as_jump .L6
.L69:
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump .L69
.L76:
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump .L76
; Instruction-identical to ComputeRankingProgressIndex_0e, ComputeRankingProgressIndex_11 and ComputeRankingProgressIndex_12 (one copy per bank); a change here belongs in every copy.
	twin compute_ranking_progress_index, 27 ; $7a49 ComputeRankingProgressIndex_27
SetStoryRankTier:
	ld a, $00 ; $7a90
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7a92
	jr z, .store ; $7a95
	inc a ; $7a97
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7a98
	jr z, .store ; $7a9b
	inc a ; $7a9d
	test_flag FLAG_DOUBLES ; $7a9e
	jr nz, .doubles ; $7aa1
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7aa3
	jr z, .store ; $7aa6
	inc a ; $7aa8
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7aa9
	jr z, .store ; $7aac
	inc a ; $7aae
.store:
	ld [wMapSceneStage], a ; $7aaf
	ret ; $7ab2
.doubles:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7ab3
	jr z, .store ; $7ab6
	inc a ; $7ab8
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7ab9
	jr z, .store ; $7abc
	inc a ; $7abe
	jr .store ; $7abf
	; $7ac1, 1343 bytes fill to bank end (linker-padded)

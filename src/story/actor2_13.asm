RunTravelingTeamVictoryCutscene_13:
	test_flag FLAG_DOUBLES ; $7988
	jr z, .notDoubles ; $798b
	call DoublesTravelingTeamVictoryCutscene ; $798d
	ret ; $7990
.notDoubles:
	call SinglesTravelingTeamVictoryCutscene ; $7991
	ret ; $7994
RunTravelingTeamBracketIfWon_13:
	wram_bank WRAM_ACTORS ; $7995
	ld a, [wMatchWinLoseFlag] ; $799b
	cp WINLOSE_WIN ; $799e
	jp z, .eq01 ; $79a0
	ret ; $79a3
.eq01:
	ld a, STORYLOC_COURTYARD ; $79a4
	ld [wStoryModeCurrentLocation], a ; $79a6
	ld a, $0e ; $79a9
	ld [wStoryModeEntryPoint], a ; $79ab
	ld a, $ff ; $79ae
	ld [wUnusedExitTriggerIdMirror], a ; $79b0
	ld [wStoryModeExitTriggerRequest], a ; $79b3
	test_flag FLAG_DOUBLES ; $79b6
	jr nz, .isDoubles ; $79b9
	ldh a, [hRomBank] ; $79bb
	ld hl, SinglesTravelingTeamActors_13 ; $79bd
	farcall ScriptRespawnLocationActors ; $79c0
	farcall BeginCutsceneScriptMode ; $79c3
	script_fade_in $04 ; $79c6
	call WaitFadeEnd ; $79cb
	script_player_speed $0018 ; $79ce
	script_move_player $0900, $1300 ; $79d4
	farcall WaitPlayerMoveDone ; $79de
	call ShowStoryTournamentBracket_13 ; $79e1
	ret ; $79e4
.isDoubles:
	ldh a, [hRomBank] ; $79e5
	ld hl, DoublesTravelingTeamActors_13 ; $79e7
	farcall ScriptRespawnLocationActors ; $79ea
	farcall BeginCutsceneScriptMode ; $79ed
	call ApplyPartnerCharacterVariant_13 ; $79f0
	script_null_script ACTOR_PARTNER ; $79f3
	script_null_script ACTOR_PLAYER_SHADOW ; $79f8
	script_player_speed $0040 ; $79fd
	script_set_position ACTOR_PLAYER, $0b00, $1d00 ; $7a03
	script_set_position ACTOR_PARTNER, $0d00, $2300 ; $7a0e
	script_face ACTOR_PLAYER, FACE_UP ; $7a19
	script_face ACTOR_PARTNER, FACE_UP ; $7a20
	script_fade_in $04 ; $7a27
	call WaitFadeEnd ; $7a2c
	script_move_player $0900, $1300 ; $7a2f
	farcall WaitPlayerMoveDone ; $7a39
	call ShowStoryTournamentBracket_13 ; $7a3c
	ret ; $7a3f
ActorScript_13_20:
	; $7a40, 3 bytes (actor_script)
	as_anim ANIM_SWING_LOOP
	as_halt
ActorScript_13_21:
	; $7a43, 29 bytes (actor_script)
	as_set_target $1100, $1d00
	as_wait_move
	as_set_target $1100, $2300
	as_wait_move
	as_set_target $0a00, $2300
	as_wait_move
	as_set_target $0a00, $2100
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_13_22:
	; $7a60, 29 bytes (actor_script)
	as_set_target $1100, $1d00
	as_wait_move
	as_set_target $1100, $2300
	as_wait_move
	as_set_target $0c00, $2300
	as_wait_move
	as_set_target $0c00, $2100
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_13_23:
	; $7a7d, 35 bytes (actor_script)
	as_set_target $1900, $1d00
	as_wait_move
	as_set_target $1100, $1d00
	as_wait_move
	as_set_target $1100, $2300
	as_wait_move
	as_set_target $0c00, $2300
	as_wait_move
	as_set_target $0c00, $2100
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_13_24:
	; $7aa0, 7 bytes (actor_script)
	as_set_target $0d00, $1d00
	as_wait_move
	as_halt
ActorScript_13_25:
	; $7aa7, 34 bytes (actor_script)
	as_set_target $1100, $1d00
	as_wait_move
	as_set_target $1100, $2300
	as_wait_move
	as_set_target $0700, $2300
	as_wait_move
	as_set_target $0700, $1d00
	as_set_target $0900, $1d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_13_26:
	; $7ac9, 23 bytes (actor_script)
	as_set_target $0700, $1700
	as_wait_move
	as_set_target $0700, $1d00
	as_wait_move
	as_set_target $0900, $1d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ShowStoryTournamentBracket_13:
	ld c, $08 ; $7ae0
	call BeginFadeOut ; $7ae2
	call WaitFadeEnd ; $7ae5
	xor a ; $7ae8
	ldh [hBGColumnBlitPending], a ; $7ae9
	ldh [hBGRowBlitPending], a ; $7aeb
	ldh [hScrollY], a ; $7aed
	ldh [hScrollX], a ; $7aef
	ld [wCameraX + 1], a ; $7af1
	ld [wCameraY + 1], a ; $7af4
	call ClearFrameTasks ; $7af7
	test_flag FLAG_DOUBLES ; $7afa
	jr nz, .doublesBracket ; $7afd
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $7aff
	jr nz, .juniorBracket ; $7b02
	ld b, $00 ; $7b04
	ld c, $04 ; $7b06
	jr .show ; $7b08
.juniorBracket:
	ld b, $00 ; $7b0a
	ld c, $01 ; $7b0c
	jr .show ; $7b0e
.doublesBracket:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $7b10
	jr nz, .doublesFinal ; $7b13
	ld b, $01 ; $7b15
	ld c, $02 ; $7b17
	jr .show ; $7b19
.show:
	farcall ShowTournamentBracket ; $7b1b
	ret ; $7b1e
.doublesFinal:
	ld b, $01 ; $7b1f
	ld c, $01 ; $7b21
	jr .show ; $7b23
ActorScript_13_27:
	; $7b25, 10 bytes (actor_script)
	as_halt
	as_anim ANIM_STILL
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_13_28:
	; $7b2f, 30 bytes (actor_script)
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
MapScriptNop_13:
	ret ; $7b4d
Unused_13_MapScriptClearActiveFlag:
	xor a ; $7b4e
	ld [wStoryScriptRan], a ; $7b4f
	ret ; $7b52
MapScriptPlaySoundA2_13:
	sound SFX_STORY_CUE ; $7b53
	ret ; $7b55
Unused_13_MapScriptHideLocationName:
	xor a ; $7b56
	ld [wStoryModeShowLocationName], a ; $7b57
	ret ; $7b5a
ActorScript_13_29:
	; $7b5b, 410 bytes (actor_script)
	as_anim ANIM_WALK
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_jump ActorScript_13_29
	as_anim ANIM_STILL
	as_wait $3c
.L67:
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_jump .L67
	as_anim ANIM_STILL
	as_wait $1e
.Lce:
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_jump .Lce
	as_anim ANIM_STILL
	as_wait $1e
	as_wait $3c
.L137:
	as_anim ANIM_WALK
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_jump .L137
ActorScript_13_30:
	; $7cf5, 28 bytes (actor_script)
	as_wait $f0
	as_anim ANIM_NOD
	as_wait $50
	as_anim ANIM_NOD
	as_wait $3c
	as_jump ActorScript_13_30
.Ld:
	as_wait $8c
	as_anim ANIM_SHAKE
	as_wait $8c
	as_anim ANIM_SHAKE
	as_wait $8c
	as_anim ANIM_NOD
	as_jump .Ld
; Instruction-identical to ComputeRankingProgressIndex_14 and ComputeRankingProgressIndex_15 (one copy per bank); a change here belongs in every copy.
	twin compute_ranking_progress_index_13, 13 ; $7d11 ComputeRankingProgressIndex_13
; Instruction-identical to ComputeStoryRankTier_15 (one copy per bank); a change here belongs in every copy.
	twin compute_story_rank_tier, 13 ; $7d58 ComputeStoryRankTier_13
	; $7d89, 631 bytes fill to bank end (linker-padded)

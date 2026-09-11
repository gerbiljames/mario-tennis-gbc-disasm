RunTravelingTeamVictoryCutscene_13:
	test_flag FLAG_DOUBLES ; $7988
	jr z, .notDoubles ; $798b
	call DoublesTravelingTeamVictoryCutscene ; $798d
	ret ; $7990
.notDoubles:
	call SinglesTravelingTeamVictoryCutscene ; $7991
	ret ; $7994
RunTravelingTeamBracketIfWon_13:
	wram_bank $04 ; $7995
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
	as_anim $06
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
	as_set_field $14, FACE_UP
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
	as_set_field $14, FACE_UP
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
	as_set_field $14, FACE_UP
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
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_13_26:
	; $7ac9, 23 bytes (actor_script)
	as_set_target $0700, $1700
	as_wait_move
	as_set_target $0700, $1d00
	as_wait_move
	as_set_target $0900, $1d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
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
	as_anim $00
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
MapScriptClearActiveFlag_13:
	xor a ; $7b4e
	ld [wStoryScriptRan], a ; $7b4f
	ret ; $7b52
MapScriptPlaySoundA2_13:
	sound SFX_STORY_CUE ; $7b53
	ret ; $7b55
MapScriptHideLocationName_13:
	xor a ; $7b56
	ld [wStoryModeShowLocationName], a ; $7b57
	ret ; $7b5a
ActorScript_13_29:
	; $7b5b, 410 bytes (actor_script)
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
	as_jump ActorScript_13_29
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
ActorScript_13_30:
	; $7cf5, 28 bytes (actor_script)
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump ActorScript_13_30
.Ld:
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump .Ld
; Instruction-identical to ComputeRankingProgressIndex_14 and ComputeRankingProgressIndex_15 (one copy per bank); a change here belongs in every copy.
ComputeRankingProgressIndex_13:
	test_flag FLAG_DOUBLES ; $7d11
	jr nz, .isDoubles ; $7d14
	ld a, STORYRANK_SINGLES_ACADEMY ; $7d16
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7d18
	jr z, .loop ; $7d1b
	ld a, STORYRANK_SINGLES_JUNIOR_CHAMP ; $7d1d
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7d1f
	jr z, .loop ; $7d22
	ld a, STORYRANK_SINGLES_SENIOR_CHAMP ; $7d24
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7d26
	jr z, .loop ; $7d29
	ld a, STORYRANK_SINGLES_ISLAND_OPEN ; $7d2b
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7d2d
	jr z, .loop ; $7d30
	ld a, STORYRANK_SINGLES_COMPLETE ; $7d32
.loop:
	ld [wMapSceneStage], a ; $7d34
	ret ; $7d37
.isDoubles:
	ld a, STORYRANK_DOUBLES_ACADEMY ; $7d38
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7d3a
	jr z, .loop ; $7d3d
	ld a, STORYRANK_DOUBLES_JUNIOR_CHAMP ; $7d3f
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7d41
	jr z, .loop ; $7d44
	ld a, STORYRANK_DOUBLES_SENIOR_CHAMP ; $7d46
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7d48
	jr z, .loop ; $7d4b
	ld a, STORYRANK_DOUBLES_ISLAND_OPEN ; $7d4d
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7d4f
	jr z, .loop ; $7d52
	ld a, STORYRANK_DOUBLES_COMPLETE ; $7d54
	jr .loop ; $7d56
; Instruction-identical to ComputeStoryRankTier_15 (one copy per bank); a change here belongs in every copy.
ComputeStoryRankTier_13:
	ld a, $00 ; $7d58
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7d5a
	jr z, .loop ; $7d5d
	inc a ; $7d5f
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7d60
	jr z, .loop ; $7d63
	inc a ; $7d65
	test_flag FLAG_DOUBLES ; $7d66
	jr nz, .checkFlag ; $7d69
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7d6b
	jr z, .loop ; $7d6e
	inc a ; $7d70
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7d71
	jr z, .loop ; $7d74
	inc a ; $7d76
.loop:
	ld [wMapSceneStage], a ; $7d77
	ret ; $7d7a
.checkFlag:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7d7b
	jr z, .loop ; $7d7e
	inc a ; $7d80
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7d81
	jr z, .loop ; $7d84
	inc a ; $7d86
	jr .loop ; $7d87
	; $7d89, 631 bytes fill to bank end (linker-padded)

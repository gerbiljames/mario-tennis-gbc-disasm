VarsityCourtANpc03FaceUp_13:
	script_set_speed ACTOR_PLAYER, $0008 ; $6c13
	script_lock_facing ACTOR_PLAYER ; $6c1b
	script_move_target ACTOR_PLAYER, $0d00, $1f00 ; $6c22
	script_wait_move ACTOR_PLAYER ; $6c2d
	script_unlock_facing ACTOR_PLAYER ; $6c32
	script_face ACTOR_PLAYER, FACE_UP ; $6c39
VarsityCourtANpc03_13:
	script_set_text Text_30_544 ; $6c40
	ld a, $03 ; $6c46
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6c48
	farcall RunDialogueYesNoPrompt ; $6c4b
	farcall ScriptCloseDialogueWindow ; $6c4e
	script_wait_frames $05 ; $6c51
	and a ; $6c58
	jp nz, .stage3 ; $6c59
	farcall AdvanceDialogueTextCursor ; $6c5c
	script_set_speed ACTOR_PLAYER, $0010 ; $6c5f
	script_move_target ACTOR_PLAYER, $0d00, $1f00 ; $6c67
	script_wait_move ACTOR_PLAYER ; $6c72
	script_face_toward ACTOR_VARSITY_COURT_A_KEVIN, ACTOR_PLAYER ; $6c77
	script_wait_frames $1e ; $6c7f
	script_face_toward ACTOR_PLAYER, ACTOR_VARSITY_COURT_A_KEVIN ; $6c86
	script_speak ACTOR_VARSITY_COURT_A_KEVIN ; $6c8e
	script_set_speed ACTOR_PLAYER, $0020 ; $6c93
	script_wait_frames $0f ; $6c9b
	script_face_toward ACTOR_VARSITY_COURT_A_BOB, ACTOR_VARSITY_COURT_A_KEVIN ; $6ca2
	script_wait_frames $1e ; $6caa
	script_face_toward ACTOR_VARSITY_COURT_A_BOB, ACTOR_PLAYER ; $6cb1
	script_wait_frames $1e ; $6cb9
	script_player_speed $0020 ; $6cc0
	script_move_player_to_actor ACTOR_VARSITY_COURT_A_BOB ; $6cc6
	farcall WaitPlayerMoveDone ; $6ccd
	script_set_anim ACTOR_VARSITY_COURT_A_BOB, ANIM_NOD ; $6cd0
	script_wait_idle ACTOR_VARSITY_COURT_A_BOB ; $6cd7
	script_move_target ACTOR_VARSITY_COURT_A_BOB, $0b00, $1f00 ; $6cdc
	script_move_player_to_actor ACTOR_PLAYER ; $6ce7
	script_wait_move ACTOR_VARSITY_COURT_A_BOB ; $6cee
	script_face ACTOR_VARSITY_COURT_A_KEVIN, FACE_DOWN ; $6cf3
	script_wait_frames $0f ; $6cfa
	script_face ACTOR_VARSITY_COURT_A_BOB, FACE_UP ; $6d01
	script_face ACTOR_PLAYER, FACE_UP ; $6d08
	script_wait_frames $0f ; $6d0f
	script_set_anim ACTOR_VARSITY_COURT_A_KEVIN, ANIM_BOUNCE ; $6d16
	script_wait_idle ACTOR_VARSITY_COURT_A_KEVIN ; $6d1d
	ld a, $03 ; $6d22
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6d24
	farcall RunDialogueYesNoPrompt ; $6d27
	farcall ScriptCloseDialogueWindow ; $6d2a
	script_wait_frames $05 ; $6d2d
	and a ; $6d34
	jp nz, .speak ; $6d35
	script_set_anim ACTOR_VARSITY_COURT_A_KEVIN, ANIM_NOD ; $6d38
	script_wait_idle ACTOR_VARSITY_COURT_A_KEVIN ; $6d3f
.stage2:
	script_set_text Text_30_548 ; $6d44
	script_set_anim ACTOR_VARSITY_COURT_A_KEVIN, ANIM_NOD ; $6d4a
	script_wait_idle ACTOR_VARSITY_COURT_A_KEVIN ; $6d51
	script_speak ACTOR_VARSITY_COURT_A_KEVIN ; $6d56
	ld a, STORYLOC_COURTYARD ; $6d5b
	ld [wStoryModeCurrentLocation], a ; $6d5d
	ld a, $0d ; $6d60
	ld [wStoryModeEntryPoint], a ; $6d62
	ld a, $ff ; $6d65
	ld [wUnusedExitTriggerIdMirror], a ; $6d67
	ld [wStoryModeExitTriggerRequest], a ; $6d6a
	script_null_script ACTOR_VARSITY_COURT_A_BETH ; $6d6d
	script_set_speed ACTOR_PLAYER, $0020 ; $6d72
	script_set_speed ACTOR_PARTNER, $0020 ; $6d7a
	script_set_speed ACTOR_VARSITY_COURT_A_BETH, $0018 ; $6d82
	script_set_actor_script ACTOR_VARSITY_COURT_A_BOB, ActorScript_13_12 ; $6d8a
	script_set_actor_script ACTOR_PLAYER, ActorScript_13_16 ; $6d95
	script_set_actor_script ACTOR_VARSITY_COURT_A_BETH, ActorScript_13_08 ; $6da0
	script_set_actor_script ACTOR_VARSITY_COURT_A_KEVIN, ActorScript_13_04 ; $6dab
	script_set_actor_script ACTOR_VARSITY_COURT_A_FAY, ActorScript_13_05 ; $6db6
	script_set_actor_script ACTOR_VARSITY_COURT_A_CURT, ActorScript_13_06 ; $6dc1
	script_move_player $0c00, $1b00 ; $6dcc
	farcall WaitPlayerMoveDone ; $6dd6
	script_wait_actor_script ACTOR_VARSITY_COURT_A_BOB ; $6dd9
	farcall InitStoryMatchSettings ; $6dde
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_VARSITY_4 ; $6de1
	farcall RunStoryMatch ; $6dee
	farcall RestoreOverworldAfterMatch ; $6df1
	ret ; $6df4
.stage3:
	script_speak ACTOR_VARSITY_COURT_A_KEVIN ; $6df5
	ret ; $6dfa
.speak:
	farcall AdvanceDialogueTextCursor ; $6dfb
	ld a, $03 ; $6dfe
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6e00
	farcall RunDialogueYesNoPrompt ; $6e03
	farcall ScriptCloseDialogueWindow ; $6e06
	script_wait_frames $05 ; $6e09
	and a ; $6e10
	jr z, .done ; $6e11
	jp .stage2 ; $6e13
	ret ; $6e16
.done:
	script_speak ACTOR_VARSITY_COURT_A_KEVIN ; $6e17
	call ReturnVarsityCourtANpc04ToSpawn_13 ; $6e1c
	ret ; $6e1f
VarsityCourtBNpc03FaceUp_13:
	script_set_speed ACTOR_PLAYER, $0008 ; $6e20
	script_lock_facing ACTOR_PLAYER ; $6e28
	script_move_target ACTOR_PLAYER, $0d00, $1f00 ; $6e2f
	script_wait_move ACTOR_PLAYER ; $6e3a
	script_unlock_facing ACTOR_PLAYER ; $6e3f
	script_face ACTOR_PLAYER, FACE_UP ; $6e46
VarsityCourtBNpc03_13:
	script_null_script ACTOR_PARTNER ; $6e4d
	script_set_text Text_31_12 ; $6e52
	ld a, $03 ; $6e58
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6e5a
	farcall RunDialogueYesNoPrompt ; $6e5d
	farcall ScriptCloseDialogueWindow ; $6e60
	script_wait_frames $05 ; $6e63
	and a ; $6e6a
	jp nz, .stage3 ; $6e6b
	farcall AdvanceDialogueTextCursor ; $6e6e
	script_set_speed ACTOR_PLAYER, $0010 ; $6e71
	script_set_speed ACTOR_PARTNER, $0010 ; $6e79
	script_move_target ACTOR_PARTNER, $0d00, $2100 ; $6e81
	script_move_target ACTOR_PLAYER, $0d00, $1f00 ; $6e8c
	script_wait_move ACTOR_PLAYER ; $6e97
	script_face_toward ACTOR_VARSITY_COURT_B_KEVIN, ACTOR_PLAYER ; $6e9c
	script_wait_move ACTOR_PARTNER ; $6ea4
	script_face_toward ACTOR_VARSITY_COURT_B_KEVIN, ACTOR_PARTNER ; $6ea9
	script_wait_frames $1e ; $6eb1
	script_set_speed ACTOR_PLAYER, $0020 ; $6eb8
	script_set_speed ACTOR_PARTNER, $0020 ; $6ec0
	script_face_toward ACTOR_PLAYER, ACTOR_VARSITY_COURT_B_KEVIN ; $6ec8
	script_speak ACTOR_VARSITY_COURT_B_KEVIN ; $6ed0
	script_wait_frames $0f ; $6ed5
	script_face_toward ACTOR_VARSITY_COURT_B_BOB, ACTOR_VARSITY_COURT_B_KEVIN ; $6edc
	script_wait_frames $1e ; $6ee4
	script_face_toward ACTOR_VARSITY_COURT_B_MARK, ACTOR_PLAYER ; $6eeb
	script_face_toward ACTOR_VARSITY_COURT_B_BOB, ACTOR_PARTNER ; $6ef3
	script_wait_frames $1e ; $6efb
	script_player_speed $0020 ; $6f02
	script_move_player_to_actor ACTOR_VARSITY_COURT_B_BOB ; $6f08
	farcall WaitPlayerMoveDone ; $6f0f
	script_face_toward ACTOR_PLAYER, ACTOR_VARSITY_COURT_B_BOB ; $6f12
	script_face_toward ACTOR_PLAYER, ACTOR_VARSITY_COURT_B_MARK ; $6f1a
	script_set_anim ACTOR_VARSITY_COURT_B_BOB, ANIM_NOD ; $6f22
	script_wait_idle ACTOR_VARSITY_COURT_B_BOB ; $6f29
	script_move_target ACTOR_VARSITY_COURT_B_BOB, $0b00, $2100 ; $6f2e
	script_move_target ACTOR_VARSITY_COURT_B_MARK, $0b00, $1f00 ; $6f39
	script_move_player_to_actor ACTOR_PLAYER ; $6f44
	script_wait_frames $0f ; $6f4b
	script_face ACTOR_VARSITY_COURT_B_KEVIN, FACE_DOWN ; $6f52
	script_wait_frames $0f ; $6f59
	script_wait_move ACTOR_VARSITY_COURT_B_BOB ; $6f60
	script_face ACTOR_VARSITY_COURT_B_BOB, FACE_UP ; $6f65
	script_face ACTOR_VARSITY_COURT_B_MARK, FACE_UP ; $6f6c
	script_face ACTOR_PLAYER, FACE_UP ; $6f73
	script_face ACTOR_PARTNER, FACE_UP ; $6f7a
	script_wait_frames $0f ; $6f81
	script_set_anim ACTOR_VARSITY_COURT_B_KEVIN, ANIM_BOUNCE ; $6f88
	script_wait_idle ACTOR_VARSITY_COURT_B_KEVIN ; $6f8f
	ld a, $03 ; $6f94
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6f96
	farcall RunDialogueYesNoPrompt ; $6f99
	farcall ScriptCloseDialogueWindow ; $6f9c
	script_wait_frames $05 ; $6f9f
	and a ; $6fa6
	jp nz, .speak ; $6fa7
	script_set_anim ACTOR_VARSITY_COURT_B_KEVIN, ANIM_NOD ; $6faa
	script_wait_idle ACTOR_VARSITY_COURT_B_KEVIN ; $6fb1
.stage2:
	script_set_text Text_31_16 ; $6fb6
	script_set_anim ACTOR_VARSITY_COURT_B_KEVIN, ANIM_NOD ; $6fbc
	script_wait_idle ACTOR_VARSITY_COURT_B_KEVIN ; $6fc3
	script_speak ACTOR_VARSITY_COURT_B_KEVIN ; $6fc8
	ld a, STORYLOC_COURTYARD ; $6fcd
	ld [wStoryModeCurrentLocation], a ; $6fcf
	ld a, $0d ; $6fd2
	ld [wStoryModeEntryPoint], a ; $6fd4
	ld a, $ff ; $6fd7
	ld [wUnusedExitTriggerIdMirror], a ; $6fd9
	ld [wStoryModeExitTriggerRequest], a ; $6fdc
	script_set_speed ACTOR_PLAYER, $0020 ; $6fdf
	script_set_speed ACTOR_PARTNER, $0020 ; $6fe7
	script_set_actor_script ACTOR_VARSITY_COURT_B_BOB, ActorScript_13_13 ; $6fef
	script_set_actor_script ACTOR_VARSITY_COURT_B_MARK, ActorScript_13_14 ; $6ffa
	script_set_actor_script ACTOR_PLAYER, ActorScript_13_16 ; $7005
	script_set_actor_script ACTOR_PARTNER, ActorScript_13_15 ; $7010
	script_null_script ACTOR_VARSITY_COURT_B_BETH ; $701b
	script_set_speed ACTOR_VARSITY_COURT_B_BETH, $0018 ; $7020
	script_set_actor_script ACTOR_VARSITY_COURT_B_KEVIN, ActorScript_13_04 ; $7028
	script_set_actor_script ACTOR_VARSITY_COURT_B_FAY, ActorScript_13_05 ; $7033
	script_set_actor_script ACTOR_VARSITY_COURT_B_CURT, ActorScript_13_07 ; $703e
	script_set_actor_script ACTOR_VARSITY_COURT_B_BETH, ActorScript_13_09 ; $7049
	script_move_player $0c00, $1b00 ; $7054
	farcall WaitPlayerMoveDone ; $705e
	script_wait_actor_script ACTOR_VARSITY_COURT_B_BOB ; $7061
	farcall InitStoryMatchSettings ; $7066
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_VARSITY_2 ; $7069
	farcall RunStoryMatch ; $7076
	farcall RestoreOverworldAfterMatch ; $7079
	ret ; $707c
.stage3:
	script_speak ACTOR_VARSITY_COURT_B_KEVIN ; $707d
	script_get_actor_state ACTOR_PARTNER ; $7082
	ld c, l ; $7087
	ld b, h ; $7088
	ld de, wActors ; $7089
	farcall AttachActorStepMover ; $708c
	ret ; $708f
.speak:
	farcall AdvanceDialogueTextCursor ; $7090
	ld a, $03 ; $7093
	farcall ScriptShowSpeakerDialogueRestoreBG ; $7095
	farcall RunDialogueYesNoPrompt ; $7098
	farcall ScriptCloseDialogueWindow ; $709b
	script_wait_frames $05 ; $709e
	and a ; $70a5
	jr z, .done ; $70a6
	jp .stage2 ; $70a8
	ret ; $70ab
.done:
	script_speak ACTOR_VARSITY_COURT_B_KEVIN ; $70ac
	call ReturnVarsityCourtBNpcsToSpawn_13 ; $70b1
	script_wait_frames $3c ; $70b4
	script_get_actor_state ACTOR_PARTNER ; $70bb
	ld c, l ; $70c0
	ld b, h ; $70c1
	ld de, wActors ; $70c2
	farcall AttachActorStepMover ; $70c5
	ret ; $70c8
ReturnVarsityCourtANpc04ToSpawn_13:
	script_set_actor_script ACTOR_VARSITY_COURT_A_BOB, ActorScript_13_17 ; $70c9
	ret ; $70d4
ReturnVarsityCourtBNpcsToSpawn_13:
	script_set_actor_script ACTOR_VARSITY_COURT_B_BOB, ActorScript_13_18 ; $70d5
	script_set_actor_script ACTOR_VARSITY_COURT_B_MARK, ActorScript_13_19 ; $70e0
	ret ; $70eb
Unused_13_RunSinglesTravelingTeamVictoryIfWon:
	wram_bank WRAM_ACTORS ; $70ec
	ld a, [wMatchWinLoseFlag] ; $70f2
	cp WINLOSE_WIN ; $70f5
	jp z, SinglesTravelingTeamVictoryCutscene ; $70f7
	ret ; $70fa
SinglesTravelingTeamVictoryCutscene:
	wram_bank WRAM_SCENE ; $70fb
	ldh a, [hRomBank] ; $7101
	ld hl, SinglesTravelingTeamActors_13 ; $7103
	farcall ScriptRespawnLocationActors ; $7106
	script_null_script ACTOR_PLAYER_SHADOW ; $7109
	script_player_speed $0040 ; $710e
	call ApplyPartnerCharacterVariant_13 ; $7114
	script_set_position ACTOR_PLAYER, $0b00, $1d00 ; $7117
	script_set_position ACTOR_PARTNER, $0d00, $2300 ; $7122
	script_face ACTOR_PLAYER, FACE_UP ; $712d
	script_face ACTOR_PARTNER, FACE_UP ; $7134
	script_move_player $0b00, $1100 ; $713b
	farcall WaitPlayerMoveDone ; $7145
	script_fade_in $04 ; $7148
	call WaitFadeEnd ; $714d
	script_wait_frames $3c ; $7150
	script_set_text Text_30_554 ; $7157
	script_player_speed $0020 ; $715d
	script_move_player $0b00, $1700 ; $7163
	farcall WaitPlayerMoveDone ; $716d
	script_move_target ACTOR_SINGLES_TRAVELING_TEAM_BOB, $0b00, $1700 ; $7170
	script_wait_move ACTOR_SINGLES_TRAVELING_TEAM_BOB ; $717b
	script_speak ACTOR_SINGLES_TRAVELING_TEAM_BOB ; $7180
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $7185
	script_wait_idle ACTOR_PLAYER ; $718c
	script_speak ACTOR_SINGLES_TRAVELING_TEAM_KATE ; $7191
	script_set_position ACTOR_SINGLES_TRAVELING_TEAM_BALLOON_QUESTION, $0c40, $1bc0 ; $7196
	sound SFX_EMOTE ; $71a1
	script_wait_frames $28 ; $71a3
	script_set_position ACTOR_SINGLES_TRAVELING_TEAM_BALLOON_QUESTION, $3f00, $3f00 ; $71aa
	script_face ACTOR_PLAYER, FACE_RIGHT ; $71b5
	script_move_player_to_actor ACTOR_SINGLES_TRAVELING_TEAM_KATE ; $71bc
	farcall WaitPlayerMoveDone ; $71c3
	script_wait_frames $28 ; $71c6
	script_move_player_to_actor ACTOR_PLAYER ; $71cd
	script_set_actor_script ACTOR_SINGLES_TRAVELING_TEAM_EMILY, ActorScript_13_21 ; $71d4
	script_set_actor_script ACTOR_SINGLES_TRAVELING_TEAM_MARK, ActorScript_13_25 ; $71df
	script_set_actor_script ACTOR_SINGLES_TRAVELING_TEAM_KATE, ActorScript_13_24 ; $71ea
	script_wait_frames $0a ; $71f5
	script_set_actor_script ACTOR_SINGLES_TRAVELING_TEAM_KEVIN, ActorScript_13_23 ; $71fc
	farcall WaitPlayerMoveDone ; $7207
	script_wait_actor_script ACTOR_SINGLES_TRAVELING_TEAM_KEVIN ; $720a
	script_face_toward ACTOR_PLAYER, ACTOR_SINGLES_TRAVELING_TEAM_KATE ; $720f
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $7217
	jr z, .variantB ; $721a
	farcall AdvanceDialogueTextCursor ; $721c
	script_set_anim ACTOR_SINGLES_TRAVELING_TEAM_KATE, ANIM_BOUNCE ; $721f
	script_wait_idle ACTOR_SINGLES_TRAVELING_TEAM_KATE ; $7226
	script_speak ACTOR_SINGLES_TRAVELING_TEAM_KATE ; $722b
	script_face_toward ACTOR_SINGLES_TRAVELING_TEAM_KATE, ACTOR_PLAYER ; $7230
	script_set_anim ACTOR_SINGLES_TRAVELING_TEAM_KATE, ANIM_NOD ; $7238
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $723f
	script_wait_idle ACTOR_PLAYER ; $7246
	jr .celebrate ; $724b
.variantB:
	script_set_anim ACTOR_SINGLES_TRAVELING_TEAM_KATE, ANIM_BOUNCE ; $724d
	script_wait_idle ACTOR_SINGLES_TRAVELING_TEAM_KATE ; $7254
	script_speak ACTOR_SINGLES_TRAVELING_TEAM_KATE ; $7259
	script_face_toward ACTOR_SINGLES_TRAVELING_TEAM_KATE, ACTOR_PLAYER ; $725e
	script_set_anim ACTOR_SINGLES_TRAVELING_TEAM_KATE, ANIM_NOD ; $7266
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $726d
	script_wait_idle ACTOR_PLAYER ; $7274
	farcall AdvanceDialogueTextCursor ; $7279
.celebrate:
	script_face ACTOR_SINGLES_TRAVELING_TEAM_MARK, FACE_DOWN ; $727c
	script_set_anim ACTOR_SINGLES_TRAVELING_TEAM_MARK, ANIM_SHAKE ; $7283
	script_wait_idle ACTOR_SINGLES_TRAVELING_TEAM_MARK ; $728a
	script_face ACTOR_SINGLES_TRAVELING_TEAM_MARK, FACE_RIGHT ; $728f
	script_face_toward ACTOR_SINGLES_TRAVELING_TEAM_MARK, ACTOR_PLAYER ; $7296
	script_speak ACTOR_SINGLES_TRAVELING_TEAM_MARK ; $729e
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $72a3
	script_wait_idle ACTOR_PLAYER ; $72aa
	script_wait_frames $14 ; $72af
	script_move_target ACTOR_SINGLES_TRAVELING_TEAM_EMILY, $0a00, $1f00 ; $72b6
	script_wait_move ACTOR_SINGLES_TRAVELING_TEAM_EMILY ; $72c1
	script_wait_frames $14 ; $72c6
	script_face_toward ACTOR_SINGLES_TRAVELING_TEAM_EMILY, ACTOR_PLAYER ; $72cd
	script_face_toward ACTOR_SINGLES_TRAVELING_TEAM_EMILY, ACTOR_SINGLES_TRAVELING_TEAM_KATE ; $72d5
	script_wait_frames $14 ; $72dd
	script_set_anim ACTOR_SINGLES_TRAVELING_TEAM_EMILY, ANIM_NOD ; $72e4
	script_wait_idle ACTOR_SINGLES_TRAVELING_TEAM_EMILY ; $72eb
	script_speak ACTOR_SINGLES_TRAVELING_TEAM_EMILY ; $72f0
	script_wait_frames $14 ; $72f5
	script_move_target ACTOR_SINGLES_TRAVELING_TEAM_KEVIN, $0c00, $1f00 ; $72fc
	script_wait_move ACTOR_SINGLES_TRAVELING_TEAM_KEVIN ; $7307
	script_wait_frames $14 ; $730c
	script_set_anim ACTOR_SINGLES_TRAVELING_TEAM_KEVIN, ANIM_BOUNCE ; $7313
	script_wait_idle ACTOR_SINGLES_TRAVELING_TEAM_KEVIN ; $731a
	script_speak ACTOR_SINGLES_TRAVELING_TEAM_KEVIN ; $731f
	script_set_anim ACTOR_SINGLES_TRAVELING_TEAM_KATE, ANIM_BOUNCE ; $7324
	script_wait_idle ACTOR_SINGLES_TRAVELING_TEAM_KATE ; $732b
	script_face_toward ACTOR_PLAYER, ACTOR_SINGLES_TRAVELING_TEAM_KATE ; $7330
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $7338
	jr z, .done ; $733b
	farcall AdvanceDialogueTextCursor ; $733d
.done:
	script_speak ACTOR_SINGLES_TRAVELING_TEAM_KATE ; $7340
	script_face_toward ACTOR_SINGLES_TRAVELING_TEAM_KATE, ACTOR_PLAYER ; $7345
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $734d
	script_wait_idle ACTOR_PLAYER ; $7354
	script_wait_frames $0a ; $7359
	script_face_toward ACTOR_SINGLES_TRAVELING_TEAM_EMILY, ACTOR_PLAYER ; $7360
	script_wait_frames $0a ; $7368
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $736f
	ld c, $02 ; $7376
	call BeginFadeOut ; $7378
	call WaitFadeEnd ; $737b
	ld b, $00 ; $737e
	ld a, [wStoryModeGenderOfMainCharacter] ; $7380
	add $04 ; $7383
	ld c, a ; $7385
	farcall RunStorySceneByMode ; $7386
	ld a, STORYLOC_MAIN_MENU ; $7389
	ld [wStoryModeCurrentLocation], a ; $738b
	ld a, $0a ; $738e
	ld [wStoryModeEntryPoint], a ; $7390
	ld a, $ff ; $7393
	ld [wUnusedExitTriggerIdMirror], a ; $7395
	ld [wStoryModeExitTriggerRequest], a ; $7398
	ret ; $739b
SinglesTravelingTeamActors_13:
	; $739c, 164 bytes (map_actors)
	map_actor $0000, ActorScript_13_27, $1900, $1f00, FACE_LEFT, OBJ_KEVIN, ANIM_WALK, $00, SINGLES_TRAVELING_TEAM_KEVIN
	map_actor $0000, ActorScript_13_27, $0b00, $1300, FACE_DOWN, OBJ_BOB, ANIM_WALK, $07, SINGLES_TRAVELING_TEAM_BOB
	map_actor $0000, ActorScript_13_27, $1300, $2100, FACE_LEFT, OBJ_FAY, ANIM_WALK, $03, SINGLES_TRAVELING_TEAM_FAY
	map_actor $0000, ActorScript_13_27, $1300, $2300, FACE_LEFT, OBJ_CURT, ANIM_WALK, $06, SINGLES_TRAVELING_TEAM_CURT
	map_actor $0000, ActorScript_13_27, $1300, $1700, FACE_LEFT, OBJ_BETH, ANIM_WALK, $06, SINGLES_TRAVELING_TEAM_BETH
	map_actor $0000, ActorScript_13_27, $1b00, $1d00, FACE_LEFT, OBJ_EMILY, ANIM_WALK, $00, SINGLES_TRAVELING_TEAM_EMILY
	map_actor $0000, ActorScript_13_27, $1900, $1d00, FACE_LEFT, OBJ_MARK, ANIM_WALK, $00, SINGLES_TRAVELING_TEAM_MARK
	map_actor $0000, ActorScript_13_27, $3d00, $3d00, FACE_LEFT, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, SINGLES_TRAVELING_TEAM_BALLOON_SWEAT
	map_actor $0000, ActorScript_13_27, $3d00, $3d00, FACE_LEFT, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, SINGLES_TRAVELING_TEAM_BALLOON_EXCLAIM
	map_actor $0000, ActorScript_13_27, $3d00, $3d00, FACE_LEFT, OBJ_BALLOON_QUESTION, ANIM_WALK, $00, SINGLES_TRAVELING_TEAM_BALLOON_QUESTION
	map_actor $0000, ActorScript_13_27, $1700, $1d00, FACE_LEFT, OBJ_KATE, ANIM_WALK, $00, SINGLES_TRAVELING_TEAM_KATE
	map_actor_end
Unused_13_RunDoublesTravelingTeamVictoryIfWon:
	wram_bank WRAM_ACTORS ; $7440
	ld a, [wMatchWinLoseFlag] ; $7446
	cp WINLOSE_WIN ; $7449
	jp z, DoublesTravelingTeamVictoryCutscene ; $744b
	ret ; $744e
DoublesTravelingTeamVictoryCutscene:
	script_set_text Text_31_22 ; $744f
	ldh a, [hRomBank] ; $7455
	ld hl, DoublesTravelingTeamActors_13 ; $7457
	farcall ScriptRespawnLocationActors ; $745a
	farcall BeginCutsceneScriptMode ; $745d
	call ApplyPartnerCharacterVariant_13 ; $7460
	script_null_script ACTOR_PARTNER ; $7463
	script_null_script ACTOR_PLAYER_SHADOW ; $7468
	script_player_speed $0040 ; $746d
	script_set_position ACTOR_PLAYER, $0b00, $1d00 ; $7473
	script_set_position ACTOR_PARTNER, $0d00, $2300 ; $747e
	script_face ACTOR_PLAYER, FACE_UP ; $7489
	script_face ACTOR_PARTNER, FACE_UP ; $7490
	script_move_player $0b00, $1100 ; $7497
	farcall WaitPlayerMoveDone ; $74a1
	script_fade_in $04 ; $74a4
	call WaitFadeEnd ; $74a9
	script_wait_frames $3c ; $74ac
	script_player_speed $0020 ; $74b3
	script_move_player $0b00, $1700 ; $74b9
	farcall WaitPlayerMoveDone ; $74c3
	script_move_target ACTOR_PARTNER, $0d00, $1d00 ; $74c6
	script_move_target ACTOR_DOUBLES_TRAVELING_TEAM_MARK, $0b00, $1700 ; $74d1
	script_wait_move ACTOR_DOUBLES_TRAVELING_TEAM_MARK ; $74dc
	script_set_anim ACTOR_DOUBLES_TRAVELING_TEAM_MARK, ANIM_SHAKE ; $74e1
	script_wait_idle ACTOR_DOUBLES_TRAVELING_TEAM_MARK ; $74e8
	script_speak ACTOR_DOUBLES_TRAVELING_TEAM_MARK ; $74ed
	script_set_anim ACTOR_DOUBLES_TRAVELING_TEAM_BOB, ANIM_BOUNCE ; $74f2
	script_wait_idle ACTOR_DOUBLES_TRAVELING_TEAM_BOB ; $74f9
	script_speak ACTOR_DOUBLES_TRAVELING_TEAM_BOB ; $74fe
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $7503
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $750a
	script_wait_idle ACTOR_PLAYER ; $7511
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $7516
	script_wait_frames $1e ; $751e
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $7525
	script_wait_idle ACTOR_PARTNER ; $752c
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $7531
	jp z, .variantB ; $7534
	script_set_text Text_31_26 ; $7537
	script_speak ACTOR_PARTNER ; $753d
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $7542
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $754a
	script_wait_idle ACTOR_PARTNER ; $7551
	script_speak ACTOR_PARTNER ; $7556
	script_face ACTOR_PLAYER, FACE_LEFT ; $755b
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $7562
	script_set_position ACTOR_DOUBLES_TRAVELING_TEAM_BALLOON_SWEAT, $0c00, $1b80 ; $7569
	sound SFX_APPEAR2 ; $7574
	script_wait_frames $28 ; $7576
	script_set_position ACTOR_DOUBLES_TRAVELING_TEAM_BALLOON_SWEAT, $3f00, $3f00 ; $757d
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $7588
	script_wait_frames $0a ; $7590
	script_lock_facing ACTOR_PLAYER ; $7597
	script_wait_frames $0a ; $759e
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0100 ; $75a5
	script_wait_move ACTOR_PLAYER ; $75af
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $75b4
	script_wait_idle ACTOR_PLAYER ; $75bb
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0100 ; $75c0
	script_wait_move ACTOR_PLAYER ; $75ca
	script_get_actor_state ACTOR_PARTNER ; $75cf
	ld de, $0018 ; $75d4
	add hl, de ; $75d7
	ld [hl], $04 ; $75d8
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $75da
	script_wait_idle ACTOR_PARTNER ; $75e1
	script_face ACTOR_PARTNER, FACE_UP ; $75e6
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $75ed
	script_wait_idle ACTOR_PARTNER ; $75f4
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $75f9
	script_wait_idle ACTOR_PARTNER ; $7600
	script_face ACTOR_PARTNER, FACE_DOWN ; $7605
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $760c
	script_wait_idle ACTOR_PARTNER ; $7613
	script_face ACTOR_PARTNER, FACE_UP ; $7618
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $761f
	script_wait_idle ACTOR_PARTNER ; $7626
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $762b
	script_wait_idle ACTOR_PARTNER ; $7632
	script_get_actor_state ACTOR_PARTNER ; $7637
	ld de, $0018 ; $763c
	add hl, de ; $763f
	ld [hl], $01 ; $7640
	script_face ACTOR_PARTNER, FACE_LEFT ; $7642
	script_wait_frames $14 ; $7649
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $7650
	script_wait_idle ACTOR_PARTNER ; $7657
	script_wait_frames $14 ; $765c
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $7663
	script_wait_idle ACTOR_PLAYER ; $766a
	jp .celebrate ; $766f
.variantB:
	script_set_text Text_31_24 ; $7672
	script_speak ACTOR_PARTNER ; $7678
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $767d
	script_wait_idle ACTOR_PARTNER ; $7684
	script_speak ACTOR_PARTNER ; $7689
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $768e
	script_set_position ACTOR_DOUBLES_TRAVELING_TEAM_BALLOON_SWEAT, $0c00, $1b80 ; $7696
	sound SFX_APPEAR2 ; $76a1
	script_wait_frames $28 ; $76a3
	script_set_position ACTOR_DOUBLES_TRAVELING_TEAM_BALLOON_SWEAT, $3f00, $3f00 ; $76aa
	script_wait_frames $0a ; $76b5
	script_lock_facing ACTOR_PLAYER ; $76bc
	script_wait_frames $0a ; $76c3
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0100 ; $76ca
	script_wait_move ACTOR_PLAYER ; $76d4
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $76d9
	script_wait_idle ACTOR_PLAYER ; $76e0
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0100 ; $76e5
	script_wait_move ACTOR_PLAYER ; $76ef
	script_get_actor_state ACTOR_PARTNER ; $76f4
	ld de, $0018 ; $76f9
	add hl, de ; $76fc
	ld [hl], $03 ; $76fd
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $76ff
	script_wait_idle ACTOR_PARTNER ; $7706
	script_face ACTOR_PARTNER, FACE_DOWN ; $770b
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $7712
	script_wait_idle ACTOR_PARTNER ; $7719
	script_wait_frames $28 ; $771e
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $7725
	script_wait_idle ACTOR_PARTNER ; $772c
	script_get_actor_state ACTOR_PARTNER ; $7731
	ld de, $0018 ; $7736
	add hl, de ; $7739
	ld [hl], $01 ; $773a
	script_face ACTOR_PARTNER, FACE_LEFT ; $773c
	script_wait_frames $14 ; $7743
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $774a
	script_wait_idle ACTOR_PARTNER ; $7751
	script_wait_frames $14 ; $7756
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $775d
	script_wait_idle ACTOR_PLAYER ; $7764
.celebrate:
	script_set_text Text_31_28 ; $7769
	script_wait_frames $14 ; $776f
	script_speak ACTOR_DOUBLES_TRAVELING_TEAM_EMILY ; $7776
	script_unlock_facing ACTOR_PLAYER ; $777b
	script_face ACTOR_PLAYER, FACE_RIGHT ; $7782
	script_face ACTOR_PARTNER, FACE_RIGHT ; $7789
	script_set_actor_script ACTOR_DOUBLES_TRAVELING_TEAM_EMILY, ActorScript_13_21 ; $7790
	script_set_actor_script ACTOR_DOUBLES_TRAVELING_TEAM_KEVIN, ActorScript_13_22 ; $779b
	script_wait_frames $14 ; $77a6
	script_set_actor_script ACTOR_DOUBLES_TRAVELING_TEAM_MARK, ActorScript_13_26 ; $77ad
	script_move_player $0b00, $1d00 ; $77b8
	farcall WaitPlayerMoveDone ; $77c2
	script_wait_actor_script ACTOR_DOUBLES_TRAVELING_TEAM_MARK ; $77c5
	script_face_toward ACTOR_PLAYER, ACTOR_DOUBLES_TRAVELING_TEAM_MARK ; $77ca
	script_face_toward ACTOR_DOUBLES_TRAVELING_TEAM_KEVIN, ACTOR_PARTNER ; $77d2
	script_set_anim ACTOR_DOUBLES_TRAVELING_TEAM_MARK, ANIM_SHAKE ; $77da
	script_wait_idle ACTOR_DOUBLES_TRAVELING_TEAM_MARK ; $77e1
	script_face_toward ACTOR_DOUBLES_TRAVELING_TEAM_MARK, ACTOR_PLAYER ; $77e6
	script_speak ACTOR_DOUBLES_TRAVELING_TEAM_MARK ; $77ee
	script_move_target ACTOR_DOUBLES_TRAVELING_TEAM_EMILY, $0a00, $1f00 ; $77f3
	script_wait_move ACTOR_DOUBLES_TRAVELING_TEAM_EMILY ; $77fe
	script_face_toward ACTOR_DOUBLES_TRAVELING_TEAM_EMILY, ACTOR_PLAYER ; $7803
	script_face_toward ACTOR_DOUBLES_TRAVELING_TEAM_KEVIN, ACTOR_PARTNER ; $780b
	script_set_anim ACTOR_DOUBLES_TRAVELING_TEAM_EMILY, ANIM_NOD ; $7813
	script_wait_idle ACTOR_DOUBLES_TRAVELING_TEAM_EMILY ; $781a
	script_speak ACTOR_DOUBLES_TRAVELING_TEAM_EMILY ; $781f
	script_move_target ACTOR_DOUBLES_TRAVELING_TEAM_KEVIN, $0c00, $1f00 ; $7824
	script_wait_move ACTOR_DOUBLES_TRAVELING_TEAM_KEVIN ; $782f
	script_set_anim ACTOR_DOUBLES_TRAVELING_TEAM_KEVIN, ANIM_BOUNCE ; $7834
	script_wait_idle ACTOR_DOUBLES_TRAVELING_TEAM_KEVIN ; $783b
	script_speak ACTOR_DOUBLES_TRAVELING_TEAM_KEVIN ; $7840
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $7845
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $784d
	script_wait_idle ACTOR_PARTNER ; $7854
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $7859
	jr z, .done ; $785c
	farcall AdvanceDialogueTextCursor ; $785e
.done:
	script_speak ACTOR_PARTNER ; $7861
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $7866
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $786e
	script_wait_idle ACTOR_PLAYER ; $7875
	script_wait_frames $0a ; $787a
	script_face_toward ACTOR_DOUBLES_TRAVELING_TEAM_EMILY, ACTOR_PLAYER ; $7881
	script_face_toward ACTOR_DOUBLES_TRAVELING_TEAM_KEVIN, ACTOR_PARTNER ; $7889
	script_wait_frames $0a ; $7891
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $7898
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $789f
	ld c, $02 ; $78a6
	call BeginFadeOut ; $78a8
	call WaitFadeEnd ; $78ab
	call PlayDoublesTravelingTeamScreenSequence_13 ; $78ae
	ld a, STORYLOC_MAIN_MENU ; $78b1
	ld [wStoryModeCurrentLocation], a ; $78b3
	ld a, $0a ; $78b6
	ld [wStoryModeEntryPoint], a ; $78b8
	ld a, $ff ; $78bb
	ld [wUnusedExitTriggerIdMirror], a ; $78bd
	ld [wStoryModeExitTriggerRequest], a ; $78c0
	ret ; $78c3
PlayDoublesTravelingTeamScreenSequence_13:
	ld b, $00 ; $78c4
	ld a, [wStoryModeGenderOfMainCharacter] ; $78c6
	ld d, a ; $78c9
	sla a ; $78ca
	ld c, a ; $78cc
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $78cd
	xor d ; $78d0
	or c ; $78d1
	ld c, a ; $78d2
	farcall RunStorySceneByMode ; $78d3
	ret ; $78d6
DoublesTravelingTeamActors_13:
	; $78d7, 164 bytes (map_actors)
	map_actor $0000, ActorScript_13_27, $1900, $1d00, FACE_LEFT, OBJ_KEVIN, ANIM_WALK, $00, DOUBLES_TRAVELING_TEAM_KEVIN
	map_actor $0000, ActorScript_13_27, $0d00, $1700, FACE_DOWN, OBJ_BOB, ANIM_WALK, $07, DOUBLES_TRAVELING_TEAM_BOB
	map_actor $0000, ActorScript_13_27, $1300, $2100, FACE_LEFT, OBJ_FAY, ANIM_WALK, $03, DOUBLES_TRAVELING_TEAM_FAY
	map_actor $0000, ActorScript_13_27, $1300, $2300, FACE_LEFT, OBJ_CURT, ANIM_WALK, $06, DOUBLES_TRAVELING_TEAM_CURT
	map_actor $0000, ActorScript_13_27, $1300, $1700, FACE_LEFT, OBJ_BETH, ANIM_WALK, $06, DOUBLES_TRAVELING_TEAM_BETH
	map_actor $0000, ActorScript_13_27, $1700, $1d00, FACE_LEFT, OBJ_EMILY, ANIM_WALK, $00, DOUBLES_TRAVELING_TEAM_EMILY
	map_actor $0000, ActorScript_13_27, $0b00, $1300, FACE_DOWN, OBJ_MARK, ANIM_WALK, $00, DOUBLES_TRAVELING_TEAM_MARK
	map_actor $0000, ActorScript_13_27, $3d00, $3d00, FACE_LEFT, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, DOUBLES_TRAVELING_TEAM_BALLOON_SWEAT
	map_actor $0000, ActorScript_13_27, $3d00, $3d00, FACE_LEFT, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, DOUBLES_TRAVELING_TEAM_BALLOON_EXCLAIM_1
	map_actor $0000, ActorScript_13_27, $3d00, $3d00, FACE_LEFT, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, DOUBLES_TRAVELING_TEAM_BALLOON_EXCLAIM_2
	map_actor $0000, ActorScript_13_27, $3d00, $3d00, FACE_LEFT, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, DOUBLES_TRAVELING_TEAM_BALLOON_EXCLAIM_3
	map_actor_end
Unused_13_DoublesTravelingTeamInitScript:
	set_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $797b
	set_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $797e
	set_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7981
	set_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7984
	ret ; $7987

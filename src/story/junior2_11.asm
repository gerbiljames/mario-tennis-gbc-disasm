ActorScript_11_22:
	; $681f, 3 bytes (actor_script)
	as_anim $06
	as_halt
JuniorClassCourtSinglesMapScripts_11:
	; $6822, 14 bytes (map_tree)
	dw JuniorClassCourtSinglesEntryPoints_11 ; slot 0 EntryPoints
	dw JuniorClassCourtSinglesExitTriggers_11 ; slot 1 ExitTriggers
	dw JuniorClassCourtSinglesActors_11 ; slot 2 Actors
	dw JuniorClassCourtSinglesNpcScripts_11 ; slot 3 NpcScripts
	dw JuniorClassCourtSinglesFacingScripts_11 ; slot 4 FacingScripts
	dw JuniorClassCourtSinglesTileTriggers_11 ; slot 5 TileTriggers
	dw JuniorClassCourtSinglesInitScript_11 ; slot 6 InitScript
JuniorClassCourtSinglesActors_11:
	; $6830, 234 bytes (map_actors)
	map_actor $0000, ActorScript_11_45, $1300, $1300, FACE_DOWN, OBJ_WALK_72_00, $01, $00, JUNIOR_CLASS_COURT_SINGLES_WALK_72_00
	map_actor $0000, ActorScript_11_45, $2300, $1700, FACE_LEFT, OBJ_BOB, $01, $05, JUNIOR_CLASS_COURT_SINGLES_BOB
	map_actor $0000, ActorScript_11_45, $0500, $1500, FACE_RIGHT, OBJ_BETH, $01, $04, JUNIOR_CLASS_COURT_SINGLES_BETH
	map_actor $0000, ActorScript_11_45, $1300, $0d00, FACE_RIGHT, OBJ_CURT, $01, $07, JUNIOR_CLASS_COURT_SINGLES_CURT
	map_actor $0000, ActorScript_11_45, $1f00, $1500, FACE_LEFT, OBJ_PAM, $01, $07, JUNIOR_CLASS_COURT_SINGLES_PAM
	map_actor $0000, ActorScript_11_45, $2500, $0900, FACE_RIGHT, OBJ_BRIAN, $01, $03, JUNIOR_CLASS_COURT_SINGLES_BRIAN
	map_actor $0000, ActorScript_11_45, $3100, $1500, FACE_RIGHT, OBJ_FAY, $01, $06, JUNIOR_CLASS_COURT_SINGLES_FAY
	map_actor $0000, ActorScript_11_45, $3d00, $1900, FACE_LEFT, OBJ_ALLIE, $01, $04, JUNIOR_CLASS_COURT_SINGLES_ALLIE
	map_actor $0000, ActorScript_11_29, $3100, $0700, FACE_DOWN, OBJ_JOY, $01, $03, JUNIOR_CLASS_COURT_SINGLES_JOY
	map_actor $0000, ActorScript_11_50, $0800, $0b00, FACE_DOWN, OBJ_WALK_74_00, $01, $05, JUNIOR_CLASS_COURT_SINGLES_WALK_74_00_1
	map_actor $0000, ActorScript_11_51, $0c00, $1700, FACE_UP, OBJ_WALK_74_00, $01, $00, JUNIOR_CLASS_COURT_SINGLES_WALK_74_00_2
	map_actor $0000, ActorScript_11_48, $1800, $0b00, FACE_DOWN, OBJ_WALK_74_00, $01, $00, JUNIOR_CLASS_COURT_SINGLES_WALK_74_00_3
	map_actor $0000, ActorScript_11_49, $1c00, $1700, FACE_UP, OBJ_WALK_74_00, $01, $05, JUNIOR_CLASS_COURT_SINGLES_WALK_74_00_4
	map_actor $0000, ActorScript_11_50, $3400, $0b00, FACE_DOWN, OBJ_WALK_74_00, $01, $05, JUNIOR_CLASS_COURT_SINGLES_WALK_74_00_5
	map_actor $0000, ActorScript_11_51, $3800, $1700, FACE_UP, OBJ_WALK_74_00, $01, $00, JUNIOR_CLASS_COURT_SINGLES_WALK_74_00_6
	map_actor $0000, ActorScript_11_45, $4000, $4000, FACE_UP, OBJ_WALK_73_19, $01, $00, JUNIOR_CLASS_COURT_SINGLES_WALK_73_19
	map_actor_end
JuniorClassCourtSinglesEntryPoints_11:
	; $691a, 17 bytes (map_entries)
	map_entry $01, FACE_UP, $1300, $1d00, MapArrivalWalk_11
	map_entry $09, FACE_UP, $2d00, $1900, $0000
	db $ff
Unused_11_NullScriptC:
	ret ; $692b
JuniorClassCourtSinglesExitTriggers_11:
	; $692c, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_11, STORYLOC_RESTAURANT_PLAZA, $05
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_11, STORYLOC_JUNIOR_CLASS_COURT_SINGLES, $0f
	db $ff
JuniorClassCourtSinglesNpc03FaceUp_11:
	script_set_speed ACTOR_PLAYER, $0008 ; $693d
	script_lock_facing ACTOR_PLAYER ; $6945
	script_move_target ACTOR_PLAYER, $1300, $1500 ; $694c
	script_wait_move ACTOR_PLAYER ; $6957
	script_unlock_facing ACTOR_PLAYER ; $695c
	script_face ACTOR_PLAYER, FACE_UP ; $6963
JuniorClassCourtSinglesNpc03_11:
	call OfferSinglesRankingMatch ; $696a
	ret ; $696d
JuniorClassCourtSinglesNpc04_11:
	script_set_text Text_32_62 ; $696e
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $6974
	jr nz, .speak ; $6977
	farcall AdvanceDialogueTextCursor ; $6979
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_2 ; $697c
	jr nz, .speak ; $697f
	farcall AdvanceDialogueTextCursor ; $6981
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $6984
	ret ; $6989
JuniorClassCourtSinglesNpc05_11:
	script_set_text Text_32_65 ; $698a
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_2 ; $6990
	jr nz, .altText ; $6993
	farcall AdvanceDialogueTextCursor ; $6995
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_3 ; $6998
	jr nz, .speak ; $699b
	script_set_text Text_32_69 ; $699d
.altText:
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH ; $69a3
	ret ; $69a8
.speak:
	ld a, $05 ; $69a9
	farcall ScriptShowSpeakerDialogueRestoreBG ; $69ab
	farcall RunDialogueYesNoPrompt ; $69ae
	farcall ScriptCloseDialogueWindow ; $69b1
	script_wait_frames $05 ; $69b4
	and a ; $69bb
	jr z, .done ; $69bc
	farcall AdvanceDialogueTextCursor ; $69be
.done:
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH ; $69c1
	ret ; $69c6
JuniorClassCourtSinglesNpc06_11:
	script_set_text Text_32_70 ; $69c7
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_3 ; $69cd
	jr nz, .speak ; $69d0
	farcall AdvanceDialogueTextCursor ; $69d2
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $69d5
	jr nz, .speak ; $69d8
	farcall AdvanceDialogueTextCursor ; $69da
	ld a, $06 ; $69dd
	farcall ScriptShowSpeakerDialogueRestoreBG ; $69df
	farcall RunDialogueYesNoPrompt ; $69e2
	farcall ScriptCloseDialogueWindow ; $69e5
	script_wait_frames $05 ; $69e8
	and a ; $69ef
	jr z, .speak ; $69f0
	farcall AdvanceDialogueTextCursor ; $69f2
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT ; $69f5
	ret ; $69fa
JuniorClassCourtSinglesNpc07_11:
	script_set_text Text_32_75 ; $69fb
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $6a01
	jr nz, .speak ; $6a04
	farcall AdvanceDialogueTextCursor ; $6a06
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM ; $6a09
	ret ; $6a0e
JuniorClassCourtSinglesNpc08_11:
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $6a0f
	jr z, .altText ; $6a12
	script_set_text Text_32_86 ; $6a14
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_BRIAN ; $6a1a
	ret ; $6a1f
.altText:
	script_set_text Text_32_77 ; $6a20
	ld a, $08 ; $6a26
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6a28
	farcall RunDialogueYesNoPrompt ; $6a2b
	farcall ScriptCloseDialogueWindow ; $6a2e
	script_wait_frames $05 ; $6a31
	and a ; $6a38
	jr z, .done ; $6a39
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_BRIAN ; $6a3b
	ret ; $6a40
.done:
	farcall AdvanceDialogueTextCursor ; $6a41
	ld a, $08 ; $6a44
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6a46
	farcall RunDialogueYesNoPrompt ; $6a49
	farcall ScriptCloseDialogueWindow ; $6a4c
	script_wait_frames $05 ; $6a4f
	and a ; $6a56
	jr nz, .speak ; $6a57
	script_set_anim ACTOR_PLAYER, $03 ; $6a59
	script_wait_idle ACTOR_PLAYER ; $6a60
	script_move_player $2b00, $1100 ; $6a65
	script_move_target ACTOR_PLAYER, $2700, $1900 ; $6a6f
	script_wait_frames $1e ; $6a7a
	script_move_target ACTOR_JUNIOR_CLASS_COURT_SINGLES_BRIAN, $2b00, $0900 ; $6a81
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_SINGLES_BRIAN ; $6a8c
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_BRIAN, FACE_DOWN ; $6a91
	script_wait_move ACTOR_PLAYER ; $6a98
	script_move_target ACTOR_PLAYER, $2d00, $1900 ; $6a9d
	script_wait_move ACTOR_PLAYER ; $6aa8
	script_face ACTOR_PLAYER, FACE_UP ; $6aad
	script_wait_frames $3c ; $6ab4
	ld hl, wStoryModePlayersXPosition ; $6abb
	ld de, wStoryModeSpawnPosition ; $6abe
	ld bc, $0005 ; $6ac1
	call CopyMemoryBC ; $6ac4
	ld a, STORYENTRY_NONE ; $6ac7
	ld [wStoryModeEntryPoint], a ; $6ac9
	ld [wUnusedExitTriggerIdMirror], a ; $6acc
	ld [wStoryModeExitTriggerRequest], a ; $6acf
	farcall InitStoryMatchSettings ; $6ad2
	load_match_settings $0000 ; $6ad5
	farcall RunStoryMatch ; $6ae2
	farcall RestoreOverworldAfterMatch ; $6ae5
	ret ; $6ae8
JuniorClassCourtSinglesNpc09_11:
	script_set_text Text_32_81 ; $6ae9
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $6aef
	jr z, .speak ; $6af2
	script_set_text Text_32_87 ; $6af4
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_FAY ; $6afa
	ret ; $6aff
JuniorClassCourtSinglesNpc0A_11:
	script_set_text Text_32_82 ; $6b00
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $6b06
	jr z, .speak ; $6b09
	script_set_text Text_32_88 ; $6b0b
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE ; $6b11
	ret ; $6b16
JuniorClassCourtSinglesNpc0B_11:
	script_face_toward ACTOR_PLAYER, ACTOR_JUNIOR_CLASS_COURT_SINGLES_JOY ; $6b17
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $6b1f
	jr z, .setText ; $6b22
	script_set_text Text_32_89 ; $6b24
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_JOY ; $6b2a
	ret ; $6b2f
.setText:
	script_set_text Text_32_83 ; $6b30
	ld a, $0b ; $6b36
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6b38
	farcall RunDialogueYesNoPrompt ; $6b3b
	farcall ScriptCloseDialogueWindow ; $6b3e
	script_wait_frames $05 ; $6b41
	and a ; $6b48
	jr z, .speak ; $6b49
	farcall AdvanceDialogueTextCursor ; $6b4b
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_JOY ; $6b4e
	ret ; $6b53
JuniorClassCourtSinglesNpcScripts_11:
	; $6b54, 81 bytes (map_scripts)
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACEMASK_UP, $0000, JuniorClassCourtSinglesNpc03FaceUp_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc03_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc04_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc05_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc06_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc07_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BRIAN, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc08_11, NPC_FACE_PLAYER, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_FAY, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc09_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc0A_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_JOY, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc0B_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	db $ff
JuniorClassCourtSinglesNpcScriptsA_11:
	; $6ba5, 65 bytes (map_scripts)
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACEMASK_ANY, $0000, Text_32_137, NPC_FACE_PLAYER, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, FACEMASK_ANY, $0000, Text_32_138, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, FACEMASK_ANY, $0000, Text_32_139, NPC_FACE_PLAYER, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, FACEMASK_ANY, $0000, Text_32_140, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BRIAN, FACEMASK_ANY, $0000, Text_32_141, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_FAY, FACEMASK_ANY, $0000, Text_32_142, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE, FACEMASK_ANY, $0000, Text_32_143, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_JOY, FACEMASK_ANY, $0000, Text_32_144, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
JuniorClassCourtSinglesNpcScriptsB_11:
	; $6be6, 65 bytes (map_scripts)
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACEMASK_ANY, $0000, Text_32_154, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, FACEMASK_ANY, $0000, Text_32_155, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, FACEMASK_ANY, $0000, Text_32_156, NPC_FACE_PLAYER, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, FACEMASK_ANY, $0000, Text_32_157, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BRIAN, FACEMASK_ANY, $0000, Text_32_158, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_FAY, FACEMASK_ANY, $0000, Text_32_159, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE, FACEMASK_ANY, $0000, Text_32_160, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_JOY, FACEMASK_ANY, $0000, Text_32_161, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
JuniorClassCourtSinglesNpcScriptsC_11:
	; $6c27, 65 bytes (map_scripts)
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACEMASK_ANY, $0000, Text_32_171, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, FACEMASK_ANY, $0000, Text_32_172, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, FACEMASK_ANY, $0000, Text_32_173, NPC_FACE_PLAYER, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, FACEMASK_ANY, $0000, Text_32_174, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BRIAN, FACEMASK_ANY, $0000, Text_32_175, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_FAY, FACEMASK_ANY, $0000, Text_32_176, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE, FACEMASK_ANY, $0000, Text_32_177, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_JOY, FACEMASK_ANY, $0000, Text_32_181, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
JuniorClassCourtSinglesNpcScriptsD_11:
	; $6c68, 65 bytes (map_scripts)
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACEMASK_ANY, $0000, Text_33_9, NPC_FACE_PLAYER, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, FACEMASK_ANY, $0000, Text_33_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, FACEMASK_ANY, $0000, Text_33_11, NPC_FACE_PLAYER, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, FACEMASK_ANY, $0000, Text_33_12, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BRIAN, FACEMASK_ANY, $0000, Text_33_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_FAY, FACEMASK_ANY, $0000, Text_33_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE, FACEMASK_ANY, $0000, JuniorClassCourtSinglesDNpc0A_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_JOY, FACEMASK_ANY, $0000, Text_33_19, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
JuniorClassCourtSinglesDNpc0A_11:
	test_flag FLAG_JUNIOR_COURT_NPC0A_TALKED ; $6ca9
	jr nz, .altText ; $6cac
	script_set_text Text_33_15 ; $6cae
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE ; $6cb4
	ret ; $6cb9
.altText:
	script_set_text Text_33_16 ; $6cba
	ld a, $0a ; $6cc0
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6cc2
	farcall RunDialogueYesNoPrompt ; $6cc5
	farcall ScriptCloseDialogueWindow ; $6cc8
	script_wait_frames $05 ; $6ccb
	and a ; $6cd2
	jp z, .speak ; $6cd3
	farcall AdvanceDialogueTextCursor ; $6cd6
.speak:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $6cd9
	jr nz, .done ; $6cdc
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE ; $6cde
	ret ; $6ce3
.done:
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE, $03 ; $6ce4
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE ; $6ceb
	script_set_text Text_33_31 ; $6cf0
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE ; $6cf6
	ret ; $6cfb
JuniorClassCourtSinglesFacingScripts_11:
	ds 1, $ff ; $6cfc, fill
JuniorClassCourtSinglesTileTriggers_11:
	ds 1, $ff ; $6cfd, fill
JuniorClassCourtSinglesInitScript_11:
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $6cfe
	jr z, .stage2 ; $6d01
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, $2500, $0b00 ; $6d03
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, FACE_RIGHT ; $6d0e
.stage2:
	ld a, [wStoryModeEntryPoint] ; $6d15
	cp $0f ; $6d18
	jp z, JuniorClassCourtSinglesMatchReturn ; $6d1a
	cp $0e ; $6d1d
	jp z, JuniorClassCourtSinglesMatchReturn.eq012 ; $6d1f
	cp $0d ; $6d22
	jp z, JuniorClassCourtSinglesMatchReturn.storeStoryModeShowLocationName ; $6d24
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $6d27
	jr nz, .stage3 ; $6d2a
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $6d2c
	jr nz, .stage4 ; $6d2f
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $6d31
	jr nz, .placeActors ; $6d34
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $6d36
	jr nz, .done ; $6d39
	ret ; $6d3b
.stage3:
	ld hl, JuniorClassCourtSinglesNpcScriptsD_11 ; $6d3c
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $6d3f
	farcall WriteStoryStateWord ; $6d42
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, $3f00, $2900 ; $6d45
	ret ; $6d50
.stage4:
	ld hl, JuniorClassCourtSinglesNpcScriptsC_11 ; $6d51
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $6d54
	farcall WriteStoryStateWord ; $6d57
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, $3f00, $2900 ; $6d5a
	ret ; $6d65
.placeActors:
	ld hl, JuniorClassCourtSinglesNpcScriptsB_11 ; $6d66
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $6d69
	farcall WriteStoryStateWord ; $6d6c
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE, $3d00, $1100 ; $6d6f
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE, ActorScript_11_47 ; $6d7a
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, $3f00, $2900 ; $6d85
	ret ; $6d90
.done:
	ld hl, JuniorClassCourtSinglesNpcScriptsA_11 ; $6d91
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $6d94
	farcall WriteStoryStateWord ; $6d97
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE, $3d00, $1100 ; $6d9a
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_ALLIE, ActorScript_11_47 ; $6da5
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, $3f00, $2900 ; $6db0
	ret ; $6dbb
ActorScript_11_23:
	; $6dbc, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $1f00, $0d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_11_24:
	; $6dcb, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $1f00, $1300
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_11_25:
	; $6dda, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $0f00, $0d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_11_26:
	; $6de9, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $0f00, $1300
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_11_27:
	; $6df8, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $0500, $0d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_28:
	; $6e07, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $0500, $1300
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_29:
	; $6e16, 55 bytes (actor_script)
	as_flag $01, $05, $02
	as_set_field $06, $0008
.L8:
	as_set_target $2d00, $0700
	as_wait_move2
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_wait $c8
	as_wait $f0
	as_set_target $3300, $0700
	as_wait_move2
	as_wait $3c
	as_set_target $2d00, $0700
	as_wait_move2
	as_wait $3c
	as_set_target $3300, $0700
	as_wait_move2
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_wait $f0
	as_wait $f0
	as_jump .L8
JuniorClassCourtSinglesMatchReturn:
	wram_bank WRAM_ACTORS ; $6e4d
	ld a, [wMatchExitRequest] ; $6e53
	cp $01 ; $6e56
	jr z, .eq01 ; $6e58
	ld a, [wMatchWinLoseFlag] ; $6e5a
	cp WINLOSE_WIN ; $6e5d
	jp z, .eq012 ; $6e5f
.eq01:
	script_player_speed $0040 ; $6e62
	script_move_player $1300, $1500 ; $6e68
	script_set_position ACTOR_PLAYER, $1300, $1500 ; $6e72
	script_face ACTOR_PLAYER, FACE_UP ; $6e7d
	farcall WaitPlayerMoveDone ; $6e84
	ret ; $6e87
.eq012:
	ld a, STORYLOC_JUNIOR_CLASS_COURT_SINGLES ; $6e88
	ld [wStoryModeCurrentLocation], a ; $6e8a
	ld a, $0d ; $6e8d
	ld [wStoryModeEntryPoint], a ; $6e8f
	ld a, $ff ; $6e92
	ld [wUnusedExitTriggerIdMirror], a ; $6e94
	ld [wStoryModeExitTriggerRequest], a ; $6e97
	farcall StubNop_1e ; $6e9a
	ret ; $6e9d
.storeStoryModeShowLocationName:
	xor a ; $6e9e
	ld [wStoryModeShowLocationName], a ; $6e9f
	ld a, [wCurrentMinigameStoryMatch + 1] ; $6ea2
	sub $01 ; $6ea5
	ld a, a ; $6ea7
	rst Rst00 ; $6ea8
	dw JuniorClassCourtSinglesMatchReturn.parkMiddleCourtPracticePair ; $6ea9 jumptable
	dw JuniorClassCourtSinglesMatchReturn.parkLeftCourtPracticePairRightSide ; $6eab jumptable
	dw JuniorClassCourtSinglesMatchReturn.parkLeftCourtPracticePairRightSide2 ; $6ead jumptable
	dw JuniorClassCourtSinglesMatchReturn.waitPlayerMoveDone ; $6eaf jumptable
.parkMiddleCourtPracticePair:
	call ParkMiddleCourtPracticePair ; $6eb1
	script_player_speed $0040 ; $6eb4
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, $1a00, $0900 ; $6eba
	script_set_position ACTOR_PLAYER, $1a00, $1400 ; $6ec5
	script_move_player $1a00, $0f00 ; $6ed0
	farcall WaitPlayerMoveDone ; $6eda
	script_face ACTOR_PLAYER, FACE_UP ; $6edd
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, FACE_DOWN ; $6ee4
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACE_RIGHT ; $6eeb
	script_fade_in $04 ; $6ef2
	call WaitFadeEnd ; $6ef7
	script_set_text Text_32_51 ; $6efa
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM ; $6f00
	script_jump_velocity ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $ff80 ; $6f05
	ld a, $03 ; $6f0d
	farcall ScriptWaitActorJumpDone ; $6f0f
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $6f12
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, ActorScript_11_33 ; $6f17
	script_move_target ACTOR_PLAYER, $1300, $1500 ; $6f22
	script_wait_move ACTOR_PLAYER ; $6f2d
	script_face ACTOR_PLAYER, FACE_DOWN ; $6f32
	call ResumeMiddleCourtPractice ; $6f39
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACE_DOWN ; $6f3c
	ret ; $6f43
.parkLeftCourtPracticePairRightSide:
	call ParkLeftCourtPracticePairRightSide ; $6f44
	script_player_speed $0040 ; $6f47
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, $0900, $0900 ; $6f4d
	script_set_position ACTOR_PLAYER, $0b00, $1400 ; $6f58
	script_move_player $0b00, $0f00 ; $6f63
	farcall WaitPlayerMoveDone ; $6f6d
	script_face ACTOR_PLAYER, FACE_UP ; $6f70
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, FACE_DOWN ; $6f77
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACE_LEFT ; $6f7e
	script_fade_in $04 ; $6f85
	call WaitFadeEnd ; $6f8a
	script_set_text Text_32_70 ; $6f8d
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT ; $6f93
	script_jump_velocity ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $ff80 ; $6f98
	ld a, $03 ; $6fa0
	farcall ScriptWaitActorJumpDone ; $6fa2
	script_set_text Text_32_53 ; $6fa5
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $6fab
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, ActorScript_11_37 ; $6fb0
	script_move_target ACTOR_PLAYER, $1300, $1500 ; $6fbb
	script_wait_move ACTOR_PLAYER ; $6fc6
	script_face ACTOR_PLAYER, FACE_DOWN ; $6fcb
	call ResumeLeftCourtPractice ; $6fd2
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACE_DOWN ; $6fd5
	ret ; $6fdc
.parkLeftCourtPracticePairRightSide2:
	call ParkLeftCourtPracticePairRightSide ; $6fdd
	script_player_speed $0040 ; $6fe0
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, $0900, $0900 ; $6fe6
	script_set_position ACTOR_PLAYER, $0b00, $1400 ; $6ff1
	script_move_player $0b00, $0f00 ; $6ffc
	farcall WaitPlayerMoveDone ; $7006
	script_face ACTOR_PLAYER, FACE_UP ; $7009
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, FACE_DOWN ; $7010
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACE_LEFT ; $7017
	script_fade_in $04 ; $701e
	call WaitFadeEnd ; $7023
	script_set_text Text_32_65 ; $7026
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH ; $702c
	script_jump_velocity ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $ff80 ; $7031
	ld a, $03 ; $7039
	farcall ScriptWaitActorJumpDone ; $703b
	script_set_text Text_32_54 ; $703e
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $7044
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, ActorScript_11_40 ; $7049
	script_move_target ACTOR_PLAYER, $1300, $1500 ; $7054
	script_wait_move ACTOR_PLAYER ; $705f
	script_face ACTOR_PLAYER, FACE_DOWN ; $7064
	call ResumeLeftCourtPractice ; $706b
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACE_DOWN ; $706e
	ret ; $7075
.waitPlayerMoveDone:
	script_player_speed $0040 ; $7076
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $1300, $1f00 ; $707c
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, $1a00, $0b00 ; $7087
	script_set_position ACTOR_PLAYER, $1a00, $1400 ; $7092
	script_move_player $1a00, $1100 ; $709d
	farcall WaitPlayerMoveDone ; $70a7
	script_face ACTOR_PLAYER, FACE_UP ; $70aa
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, FACE_DOWN ; $70b1
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACE_UP ; $70b8
	call ParkMiddleCourtPracticePair ; $70bf
	script_fade_in $04 ; $70c2
	call WaitFadeEnd ; $70c7
	script_wait_frames $3c ; $70ca
	script_set_text Text_32_55 ; $70d1
	script_move_target ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, $1a00, $0d00 ; $70d7
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $70e2
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, $02 ; $70e7
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $70ee
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $03 ; $70f3
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $70fa
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, $02 ; $70ff
	script_set_anim ACTOR_PLAYER, $02 ; $7106
	script_face ACTOR_PLAYER, FACE_DOWN ; $710d
	script_player_speed $0010 ; $7114
	script_set_speed ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $0010 ; $711a
	script_move_player $1300, $1900 ; $7122
	script_move_target ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $1300, $1b00 ; $712c
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $7137
	farcall WaitPlayerMoveDone ; $713c
	script_move_player $1a00, $1400 ; $713f
	script_move_target ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $1a00, $1700 ; $7149
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $7154
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACE_UP ; $7159
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $02 ; $7160
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $7167
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $716c
	script_set_anim ACTOR_PLAYER, $03 ; $7171
	script_wait_idle ACTOR_PLAYER ; $7178
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $03 ; $717d
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $7184
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $7189
	script_move_target ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $1a00, $1600 ; $718e
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $7199
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $02 ; $719e
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $71a5
	script_wait_frames $1e ; $71aa
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $03 ; $71b1
	script_set_anim ACTOR_PLAYER, $03 ; $71b8
	script_wait_idle ACTOR_PLAYER ; $71bf
	script_speak ACTOR_PLAYER ; $71c4
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $02 ; $71c9
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $71d0
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $71d5
	script_set_anim ACTOR_PLAYER, $03 ; $71da
	script_wait_idle ACTOR_PLAYER ; $71e1
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $03 ; $71e6
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $71ed
	script_set_anim ACTOR_PLAYER, $02 ; $71f2
	script_wait_idle ACTOR_PLAYER ; $71f9
	script_face ACTOR_PLAYER, FACE_UP ; $71fe
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_73_19, $1b80, $1280 ; $7205
	sound SFX_APPEAR2 ; $7210
	script_wait_frames $28 ; $7212
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, $02 ; $7219
	script_wait_frames $28 ; $7220
	script_move_target ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, $1a00, $0e00 ; $7227
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $7232
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_73_19, $3f00, $3f00 ; $7237
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $7242
	ld a, STORYLOC_JUNIOR_CLASS_COURT_SINGLES ; $7247
	ld [wStoryModeCurrentLocation], a ; $7249
	ld a, $01 ; $724c
	ld [wStoryModeEntryPoint], a ; $724e
	ld a, $ff ; $7251
	ld [wUnusedExitTriggerIdMirror], a ; $7253
	ld [wStoryModeExitTriggerRequest], a ; $7256
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, $03 ; $7259
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $7260
	script_wait_frames $28 ; $7265
	script_set_anim ACTOR_PLAYER, $02 ; $726c
	script_wait_idle ACTOR_PLAYER ; $7273
	script_wait_frames $28 ; $7278
	ld c, $04 ; $727f
	call BeginFadeOut ; $7281
	call WaitFadeEnd ; $7284
	ret ; $7287

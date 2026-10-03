ActorList_11_0:
	; $537d, 94 bytes (map_actors)
	map_actor $0000, ActorScript_11_45, 24.0, 17.0, FACE_DOWN, OBJ_WALK_75_06, ANIM_WALK, $00, LIST_11_0_WALK_75_06
	map_actor $0000, ActorScript_11_45, 26.0, 21.0, FACE_UP, OBJ_WALK_74_08, ANIM_WALK, $00, LIST_11_0_WALK_74_08
	map_actor $0000, ActorScript_11_45, 22.0, 21.0, FACE_UP, OBJ_WALK_74_07, ANIM_WALK, $00, LIST_11_0_WALK_74_07
	map_actor $0000, ActorScript_11_45, 25.0, 23.0, FACE_UP, OBJ_WALK_74_06, ANIM_WALK, $00, LIST_11_0_WALK_74_06
	map_actor $0000, ActorScript_11_45, 1.0, 25.0, FACE_UP, OBJ_MARK, ANIM_WALK, $00, LIST_11_0_MARK
	map_actor $0000, ActorScript_11_45, 21.0, 47.0, FACE_RIGHT, OBJ_WALK_71_03, ANIM_WALK, $03, LIST_11_0_WALK_71_03
	map_actor_end
.scriptRespawnLocationActors2:
	ldh a, [hRomBank] ; $53db
	ld hl, ActorList_11_1 ; $53dd
	farcall ScriptRespawnLocationActors ; $53e0
	farcall BeginCutsceneScriptMode ; $53e3
	script_player_speed $00ff ; $53e6
	script_move_player 24.0, 47.0 ; $53ec
	farcall WaitPlayerMoveDone ; $53f6
	test_flag FLAG_DOUBLES ; $53f9
	jp z, .placeActors ; $53fc
	script_set_position ACTOR_PARTNER, 24.0, 29.0 ; $53ff
	script_move_target ACTOR_PARTNER, 24.0, 57.0 ; $540a
.placeActors:
	script_set_position ACTOR_PLAYER, 24.0, 31.0 ; $5415
	script_move_target ACTOR_PLAYER, 24.0, 59.0 ; $5420
	xor a ; $542b
	ld [wStoryModeShowLocationName], a ; $542c
	script_fade_in $04 ; $542f
	call WaitFadeEnd ; $5434
	script_wait_frames 60 ; $5437
	script_set_anim ACTOR_LIST_11_1_WALK_71_03, ANIM_NOD ; $543e
	script_wait_idle ACTOR_LIST_11_1_WALK_71_03 ; $5445
	script_wait_move ACTOR_PLAYER ; $544a
	ld c, $04 ; $544f
	call BeginFadeOut ; $5451
	call WaitFadeEnd ; $5454
	ld a, STORYLOC_ISLAND_SKY ; $5457
	ld [wStoryModeCurrentLocation], a ; $5459
	ld a, $0f ; $545c
	ld [wStoryModeEntryPoint], a ; $545e
	ld a, $ff ; $5461
	ld [wUnusedExitTriggerIdMirror], a ; $5463
	ld [wStoryModeExitTriggerRequest], a ; $5466
	ret ; $5469
ActorList_11_1:
	; $546a, 24 bytes (map_actors)
	map_actor $0000, ActorScript_11_45, 21.0, 47.0, FACE_RIGHT, OBJ_WALK_71_03, ANIM_WALK, $03, LIST_11_1_WALK_71_03
	map_actor_end
EnableAcademyCampusExit:
	test_flag FLAG_DOUBLES ; $5482
	jr nz, .checkFlag ; $5485
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $5487
	jr nz, .writeBehaviorMapCell ; $548a
	ret ; $548c
.checkFlag:
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $548d
	jr nz, .writeBehaviorMapCell ; $5490
	ret ; $5492
.writeBehaviorMapCell:
	ld a, BEHAVIOR_EXIT | 3 << 4 ; $5493
	map_cell 22, 52 ; $5495
	farcall WriteBehaviorMapCell ; $5499
	ld a, BEHAVIOR_EXIT | 3 << 4 ; $549c
	map_cell 24, 52 ; $549e
	farcall WriteBehaviorMapCell ; $54a2
	ret ; $54a5
MoveCampusGateGuardAside:
	ld a, [wMapSceneStage] ; $54a6
	cp STORYRANK_SINGLES_ISLAND_OPEN ; $54a9
	jr c, .done ; $54ab
	script_set_position ACTOR_ACADEMY_ARRIVAL_WALK_71_03_2, 21.0, 48.0 ; $54ad
	script_face ACTOR_ACADEMY_ARRIVAL_WALK_71_03_2, FACE_RIGHT ; $54b8
.done:
	ret ; $54bf
JuniorClassCourtDoublesMapScripts_11:
	; $54c0, 14 bytes (map_tree)
	dw JuniorClassCourtDoublesEntryPoints_11 ; slot 0 EntryPoints
	dw JuniorClassCourtDoublesExitTriggers_11 ; slot 1 ExitTriggers
	dw JuniorClassCourtDoublesActors_11 ; slot 2 Actors
	dw JuniorClassCourtDoublesNpcScripts_11 ; slot 3 NpcScripts
	dw JuniorClassCourtDoublesFacingScripts_11 ; slot 4 FacingScripts
	dw JuniorClassCourtDoublesTileTriggers_11 ; slot 5 TileTriggers
	dw JuniorClassCourtDoublesInitScript_11 ; slot 6 InitScript
JuniorClassCourtDoublesActors_11:
	; $54ce, 192 bytes (map_actors)
	map_actor $0000, ActorScript_11_45, 19.0, 19.0, FACE_DOWN, OBJ_WALK_72_00, ANIM_WALK, $00, JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00
	map_actor $0000, ActorScript_11_45, 35.0, 23.0, FACE_LEFT, OBJ_BOB, ANIM_WALK, $05, JUNIOR_CLASS_COURT_DOUBLES_BOB
	map_actor $0000, ActorScript_11_45, 5.0, 21.0, FACE_RIGHT, OBJ_BETH, ANIM_WALK, $04, JUNIOR_CLASS_COURT_DOUBLES_BETH
	map_actor $0000, ActorScript_11_45, 33.0, 21.0, FACE_DOWN, OBJ_CURT, ANIM_WALK, $07, JUNIOR_CLASS_COURT_DOUBLES_CURT
	map_actor $0000, ActorScript_11_45, 5.0, 19.0, FACE_RIGHT, OBJ_PAM, ANIM_WALK, $07, JUNIOR_CLASS_COURT_DOUBLES_PAM
	map_actor $0000, ActorScript_11_52, 27.0, 19.0, FACE_DOWN, OBJ_BRIAN, ANIM_WALK, $03, JUNIOR_CLASS_COURT_DOUBLES_BRIAN
	map_actor $0000, ActorScript_11_22, 27.0, 21.0, FACE_UP, OBJ_FAY, ANIM_WALK, $06, JUNIOR_CLASS_COURT_DOUBLES_FAY
	map_actor $0000, ActorScript_11_45, 55.0, 7.0, FACE_LEFT, OBJ_ALLIE, ANIM_WALK, $04, JUNIOR_CLASS_COURT_DOUBLES_ALLIE
	map_actor $0000, ActorScript_11_45, 53.0, 7.0, FACE_RIGHT, OBJ_JOY, ANIM_WALK, $03, JUNIOR_CLASS_COURT_DOUBLES_JOY
	map_actor $0000, ActorScript_11_50, 8.0, 11.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $05, JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_1
	map_actor $0000, ActorScript_11_51, 12.0, 23.0, FACE_UP, OBJ_RACKET_STUDENT, ANIM_WALK, $00, JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_2
	map_actor $0000, ActorScript_11_48, 42.0, 11.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $00, JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_3
	map_actor $0000, ActorScript_11_49, 46.0, 23.0, FACE_UP, OBJ_RACKET_STUDENT, ANIM_WALK, $05, JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_4
	map_actor_end
JuniorClassCourtDoublesEntryPoints_11:
	; $558e, 17 bytes (map_entries)
	map_entry $01, FACE_UP, 19.0, 29.0, MapArrivalWalk_11
	map_entry $09, FACE_UP, 55.0, 25.0, $0000
	db $ff
JuniorClassCourtDoublesExitTriggers_11:
	; $559f, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_11, STORYLOC_RESTAURANT_PLAZA, $05
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_11, STORYLOC_JUNIOR_CLASS_COURT_DOUBLES, $0f
	db $ff
JuniorClassCourtDoublesNpc04_11:
	script_set_text Text_32_105 ; $55b0
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $55b6
	jr nz, .speak ; $55b9
	farcall AdvanceDialogueTextCursor ; $55bb
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $55be
	jr nz, .speak ; $55c1
	farcall AdvanceDialogueTextCursor ; $55c3
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB ; $55c6
	ret ; $55cb
JuniorClassCourtDoublesNpc05_11:
	script_set_text Text_32_120 ; $55cc
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $55d2
	jr nz, .speak ; $55d5
	farcall AdvanceDialogueTextCursor ; $55d7
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $55da
	jr nz, .speak ; $55dd
	farcall AdvanceDialogueTextCursor ; $55df
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH ; $55e2
	ret ; $55e7
JuniorClassCourtDoublesNpc06_11:
	script_set_text Text_32_108 ; $55e8
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $55ee
	jr nz, .speak ; $55f1
	farcall AdvanceDialogueTextCursor ; $55f3
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $55f6
	jr nz, .speak ; $55f9
	farcall AdvanceDialogueTextCursor ; $55fb
	script_speak_restore ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT ; $55fe
	farcall RunDialogueYesNoPrompt ; $5603
	farcall ScriptCloseDialogueWindow ; $5606
	script_wait_frames 5 ; $5609
	and a ; $5610
	jr z, .speak ; $5611
	farcall AdvanceDialogueTextCursor ; $5613
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT ; $5616
	ret ; $561b
JuniorClassCourtDoublesNpc07_11:
	script_set_text Text_32_123 ; $561c
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $5622
	jr nz, .speak ; $5625
	farcall AdvanceDialogueTextCursor ; $5627
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $562a
	jr nz, .speak ; $562d
	farcall AdvanceDialogueTextCursor ; $562f
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM ; $5632
	ret ; $5637
JuniorClassCourtDoublesNpc08_11:
	script_set_text Text_32_126 ; $5638
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $563e
	jr nz, .loop ; $5641
	farcall AdvanceDialogueTextCursor ; $5643
.loop:
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN ; $5646
	ret ; $564b
JuniorClassCourtDoublesNpc09_11:
	script_set_text Text_32_128 ; $564c
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $5652
	jr nz, JuniorClassCourtDoublesNpc08_11.loop ; $5655
	farcall AdvanceDialogueTextCursor ; $5657
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY ; $565a
	ret ; $565f
.loop:
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $5660
	script_face_pair ACTOR_JUNIOR_CLASS_COURT_DOUBLES_JOY, ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $5665
	ret ; $566d
JuniorClassCourtDoublesNpc0A_11:
	script_set_text Text_32_135 ; $566e
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $5674
	jp nz, JuniorClassCourtDoublesNpc09_11.loop ; $5677
	script_set_text Text_32_131 ; $567a
	script_speak_restore ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $5680
	farcall RunDialogueYesNoPrompt ; $5685
	farcall ScriptCloseDialogueWindow ; $5688
	script_wait_frames 5 ; $568b
	and a ; $5692
	jr nz, JuniorClassCourtDoublesNpc09_11.loop ; $5693
	farcall AdvanceDialogueTextCursor ; $5695
	script_face_toward ACTOR_PLAYER, ACTOR_JUNIOR_CLASS_COURT_DOUBLES_JOY ; $5698
	script_speak_restore ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $56a0
	farcall RunDialogueYesNoPrompt ; $56a5
	farcall ScriptCloseDialogueWindow ; $56a8
	script_wait_frames 5 ; $56ab
	and a ; $56b2
	jr nz, JuniorClassCourtDoublesNpc09_11.loop ; $56b3
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $56b5
	script_null_script ACTOR_PARTNER ; $56bc
	script_set_speed ACTOR_PARTNER, $0020 ; $56c1
	script_set_speed ACTOR_PLAYER, $0020 ; $56c9
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_11 ; $56d1
	script_wait_frames 20 ; $56dc
	script_set_actor_script ACTOR_PARTNER, ActorScript_11_12 ; $56e3
	script_wait_frames 30 ; $56ee
	script_move_player 53.0, 17.0 ; $56f5
	script_move_target ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE, 55.0, 13.0 ; $56ff
	script_move_target ACTOR_JUNIOR_CLASS_COURT_DOUBLES_JOY, 53.0, 9.0 ; $570a
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $5715
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE, FACE_DOWN ; $571a
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_JOY, FACE_DOWN ; $5721
	script_wait_actor_script ACTOR_PLAYER ; $5728
	ld hl, wStoryModePlayersXPosition ; $572d
	ld de, wStoryModeSpawnPosition ; $5730
	ld bc, wStoryModeSpawnPosition_SIZE ; $5733
	call CopyMemoryBC ; $5736
	ld a, STORYENTRY_NONE ; $5739
	ld [wStoryModeEntryPoint], a ; $573b
	ld [wUnusedExitTriggerIdMirror], a ; $573e
	ld [wStoryModeExitTriggerRequest], a ; $5741
	farcall WaitPlayerMoveDone ; $5744
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE, ANIM_NOD ; $5747
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $574e
	script_wait_idle ACTOR_PLAYER ; $5755
	farcall InitStoryMatchSettings ; $575a
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_JUNIOR_PRACTICE ; $575d
	farcall RunStoryMatch ; $576a
	farcall RestoreOverworldAfterMatch ; $576d
	ret ; $5770
JuniorClassCourtDoublesNpc0B_11:
	script_set_text Text_32_136 ; $5771
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $5777
	jr nz, Unused_11_JuniorClassCourtDoublesNpcSpeech.speak ; $577a
	script_set_text Text_32_130 ; $577c
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_JOY ; $5782
	script_face_toward ACTOR_PLAYER, ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $5787
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE, ANIM_BOUNCE ; $578f
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $5796
	jp JuniorClassCourtDoublesNpc0A_11 ; $579b
Unused_11_JuniorClassCourtDoublesNpcSpeech:
	script_set_text Text_32_82 ; $579e
	script_face_toward ACTOR_PLAYER, $0a ; $57a4
	script_set_anim $0a, ANIM_SHAKE ; $57ac
	script_wait_idle $0a ; $57b3
	script_speak $0a ; $57b8
	script_face_toward $0b, $0a ; $57bd
	ret ; $57c5
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_JOY ; $57c6
	ret ; $57cb
JuniorClassCourtDoublesANpc0A_11:
	script_set_text Text_32_151 ; $57cc
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $57d2
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE, ANIM_SHAKE ; $57d7
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $57de
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $57e3
	ret ; $57e8
JuniorClassCourtDoublesNpc03FaceUp_11:
	script_set_speed ACTOR_PLAYER, $0008 ; $57e9
	script_lock_facing ACTOR_PLAYER ; $57f1
	script_move_target ACTOR_PLAYER, 19.0, 21.0 ; $57f8
	script_wait_move ACTOR_PLAYER ; $5803
	script_unlock_facing ACTOR_PLAYER ; $5808
	script_face ACTOR_PLAYER, FACE_UP ; $580f
JuniorClassCourtDoublesNpc03_11:
	call OfferDoublesRankingMatch ; $5816
	ret ; $5819
JuniorClassCourtDoublesNpcScripts_11:
	; $581a, 81 bytes (map_scripts)
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACEMASK_UP, $0000, JuniorClassCourtDoublesNpc03FaceUp_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc03_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc04_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc05_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc06_11, NPC_FACE_PLAYER, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc07_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc08_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc09_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc0A_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_JOY, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc0B_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
JuniorClassCourtDoublesNpcScriptsA_11:
	; $586b, 73 bytes (map_scripts)
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACEMASK_ANY, $0000, Text_32_137, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, FACEMASK_ANY, $0000, Text_32_145, NPC_FACE_PLAYER, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, FACEMASK_ANY, $0000, Text_32_147, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, FACEMASK_ANY, $0000, Text_32_146, NPC_FACE_PLAYER | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, FACEMASK_ANY, $0000, Text_32_148, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, FACEMASK_ANY, $0000, Text_32_149, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, FACEMASK_ANY, $0000, Text_32_150, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE, FACEMASK_ANY, $0000, JuniorClassCourtDoublesANpc0A_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_JOY, FACEMASK_ANY, $0000, Text_32_153, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
JuniorClassCourtDoublesNpcScriptsB_11:
	; $58b4, 73 bytes (map_scripts)
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACEMASK_ANY, $0000, Text_32_162, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, FACEMASK_ANY, $0000, Text_32_163, NPC_FACE_PLAYER, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, FACEMASK_ANY, $0000, Text_32_165, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, FACEMASK_ANY, $0000, Text_32_164, NPC_FACE_PLAYER | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, FACEMASK_ANY, $0000, Text_32_166, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, FACEMASK_ANY, $0000, Text_32_167, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, FACEMASK_ANY, $0000, Text_32_168, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE, FACEMASK_ANY, $0000, Text_32_169, NPC_FACE_PLAYER, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_JOY, FACEMASK_ANY, $0000, Text_32_170, NPC_FACE_PLAYER, $00
	db $ff
JuniorClassCourtDoublesNpcScriptsC_11:
	; $58fd, 73 bytes (map_scripts)
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACEMASK_ANY, $0000, Text_32_182, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, FACEMASK_ANY, $0000, Text_32_183, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, FACEMASK_ANY, $0000, Text_32_185, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, FACEMASK_ANY, $0000, Text_32_184, NPC_FACE_PLAYER | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, FACEMASK_ANY, $0000, JuniorClassCourtDoublesCNpc07_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, FACEMASK_ANY, $0000, Text_32_189, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, FACEMASK_ANY, $0000, Text_32_190, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE, FACEMASK_ANY, $0000, JuniorClassCourtDoublesCNpc0A_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_JOY, FACEMASK_ANY, $0000, Text_32_195, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
JuniorClassCourtDoublesCNpc07_11:
	script_set_text Text_32_186 ; $5946
	script_speak_restore ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM ; $594c
	farcall RunDialogueYesNoPrompt ; $5951
	farcall ScriptCloseDialogueWindow ; $5954
	script_wait_frames 5 ; $5957
	and a ; $595e
	jp z, .speak ; $595f
	farcall AdvanceDialogueTextCursor ; $5962
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM ; $5965
	ret ; $596a
JuniorClassCourtDoublesDNpc07_11:
	script_set_text Text_33_24 ; $596b
	script_speak_restore ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM ; $5971
	farcall RunDialogueYesNoPrompt ; $5976
	farcall ScriptCloseDialogueWindow ; $5979
	script_wait_frames 5 ; $597c
	and a ; $5983
	jp z, .speak ; $5984
	farcall AdvanceDialogueTextCursor ; $5987
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM ; $598a
	ret ; $598f
JuniorClassCourtDoublesCNpc0A_11:
	script_set_text Text_32_191 ; $5990
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $5996
	set_flag FLAG_JUNIOR_COURT_NPC0A_TALKED ; $599b
	ret ; $599e
JuniorClassCourtDoublesNpcScriptsD_11:
	; $599f, 73 bytes (map_scripts)
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACEMASK_ANY, $0000, Text_33_20, NPC_FACE_PLAYER, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, FACEMASK_ANY, $0000, Text_33_21, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, FACEMASK_ANY, $0000, Text_33_23, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, FACEMASK_ANY, $0000, Text_33_22, NPC_FACE_PLAYER | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, FACEMASK_ANY, $0000, JuniorClassCourtDoublesDNpc07_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, FACEMASK_ANY, $0000, Text_33_27, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, FACEMASK_ANY, $0000, Text_33_28, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE, FACEMASK_ANY, $0000, JuniorClassCourtDoublesDNpc0A_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_JOY, FACEMASK_ANY, $0000, Text_33_29, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
JuniorClassCourtDoublesDNpc0A_11:
	test_flag FLAG_JUNIOR_COURT_NPC0A_TALKED ; $59e8
	jr nz, .setText ; $59eb
	script_set_text Text_33_15 ; $59ed
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $59f3
	ret ; $59f8
.setText:
	script_set_text Text_33_30 ; $59f9
	script_speak_restore ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $59ff
	farcall RunDialogueYesNoPrompt ; $5a04
	farcall ScriptCloseDialogueWindow ; $5a07
	script_wait_frames 5 ; $5a0a
	and a ; $5a11
	jp z, .speak ; $5a12
	farcall AdvanceDialogueTextCursor ; $5a15
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE ; $5a18
	ret ; $5a1d
JuniorClassCourtDoublesFacingScripts_11:
	ds 1, $ff ; $5a1e, fill
Unused_11_NullScriptA:
	ret ; $5a1f
JuniorClassCourtDoublesTileTriggers_11:
	ds 1, $ff ; $5a20, fill
Unused_11_NullScriptB:
	ret ; $5a21
JuniorClassCourtDoublesInitScript_11:
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $5a22
	jr nz, .stage2 ; $5a25
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $5a27
	jr z, .stage2 ; $5a2a
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, 37.0, 9.0 ; $5a2c
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, FACE_RIGHT ; $5a37
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, ActorScript_11_45 ; $5a3e
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, 37.0, 11.0 ; $5a49
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, FACE_RIGHT ; $5a54
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, ActorScript_11_45 ; $5a5b
.stage2:
	ld a, [wStoryModeEntryPoint] ; $5a66
	cp $0f ; $5a69
	jp z, JuniorClassCourtDoublesMatchReturn ; $5a6b
	cp $0e ; $5a6e
	jp z, JuniorClassCourtDoublesEntry0eScene ; $5a70
	cp $0d ; $5a73
	jp z, JuniorClassCourtDoublesEntry0dScene ; $5a75
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $5a78
	jr nz, .stage3 ; $5a7b
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $5a7d
	jr nz, .stage4 ; $5a80
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $5a82
	jr nz, .placeActors ; $5a85
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $5a87
	jr nz, .done ; $5a8a
	ret ; $5a8c
.stage3:
	ld hl, JuniorClassCourtDoublesNpcScriptsD_11 ; $5a8d
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $5a90
	farcall WriteStoryStateWord ; $5a93
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, 32.0, 25.0 ; $5a96
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, ActorScript_11_46 ; $5aa1
	ret ; $5aac
.stage4:
	ld hl, JuniorClassCourtDoublesNpcScriptsC_11 ; $5aad
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $5ab0
	farcall WriteStoryStateWord ; $5ab3
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, 32.0, 25.0 ; $5ab6
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, ActorScript_11_46 ; $5ac1
	ret ; $5acc
.placeActors:
	ld hl, JuniorClassCourtDoublesNpcScriptsB_11 ; $5acd
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $5ad0
	farcall WriteStoryStateWord ; $5ad3
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, 32.0, 25.0 ; $5ad6
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, ActorScript_11_46 ; $5ae1
	ret ; $5aec
.done:
	ld hl, JuniorClassCourtDoublesNpcScriptsA_11 ; $5aed
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $5af0
	farcall WriteStoryStateWord ; $5af3
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, 32.0, 25.0 ; $5af6
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, ActorScript_11_46 ; $5b01
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_ALLIE, FACE_DOWN ; $5b0c
	ret ; $5b13
ActorScript_11_03:
	; $5b14, 20 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 27.0, 19.0
	as_wait_move
	as_set_target 27.0, 19.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_11_04:
	; $5b28, 26 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 39.0, 13.0
	as_wait_move
	as_set_target 39.0, 9.0
	as_wait_move
	as_set_target 37.0, 9.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_05:
	; $5b42, 20 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 27.0, 21.0
	as_wait_move
	as_set_target 27.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_11_06:
	; $5b56, 26 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 39.0, 13.0
	as_wait_move
	as_set_target 39.0, 11.0
	as_wait_move
	as_set_target 37.0, 11.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_07:
	; $5b70, 20 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 21.0, 9.0
	as_wait_move
	as_set_target 23.0, 9.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_11_08:
	; $5b84, 20 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 21.0, 14.0
	as_wait_move
	as_set_target 27.0, 14.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_11_09:
	; $5b98, 26 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 17.0, 10.0
	as_wait_move
	as_set_target 17.0, 10.0
	as_wait_move
	as_set_target 9.0, 9.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_11_10:
	; $5bb2, 20 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 17.0, 13.0
	as_wait_move
	as_set_target 11.0, 13.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_11_11:
	; $5bc6, 26 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 59.0, 10.0
	as_wait_move
	as_set_target 59.0, 25.0
	as_wait_move
	as_set_target 55.0, 25.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_11_12:
	; $5be0, 26 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 59.0, 9.0
	as_wait_move
	as_set_target 59.0, 21.0
	as_wait_move
	as_set_target 53.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_11_13:
	; $5bfa, 26 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 17.0, 25.0
	as_wait_move
	as_set_target 5.0, 25.0
	as_wait_move
	as_set_target 5.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_14:
	; $5c14, 26 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 9.0, 9.0
	as_wait_move
	as_set_target 5.0, 9.0
	as_wait_move
	as_set_target 5.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_15:
	; $5c2e, 23 bytes (actor_script)
	as_set_target 5.0, 25.0
	as_wait_move
	as_set_target 17.0, 25.0
	as_wait_move
	as_set_target 17.0, 23.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_16:
	; $5c45, 26 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 17.0, 25.0
	as_wait_move
	as_set_target 5.0, 25.0
	as_wait_move
	as_set_target 5.0, 19.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_17:
	; $5c5f, 32 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 11.0, 13.0
	as_wait_move
	as_set_target 11.0, 9.0
	as_wait_move
	as_set_target 5.0, 9.0
	as_wait_move
	as_set_target 5.0, 19.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_18:
	; $5c7f, 64 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 21.0, 25.0
	as_wait_move
	as_set_target 33.0, 25.0
	as_wait_move
	as_set_target 33.0, 23.0
	as_wait_move
	as_set_target 35.0, 23.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 25.0, 9.0
	as_wait_move
	as_set_target 39.0, 9.0
	as_wait_move
	as_set_target 37.0, 9.0
	as_wait_move
	as_set_target 37.0, 9.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_11_19:
	; $5cbf, 64 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 21.0, 25.0
	as_wait_move
	as_set_target 33.0, 25.0
	as_wait_move
	as_set_target 33.0, 23.0
	as_wait_move
	as_set_target 33.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
	as_anim ANIM_WALK
	as_wait_move
	as_set_target 39.0, 13.0
	as_wait_move
	as_set_target 39.0, 11.0
	as_wait_move
	as_set_target 37.0, 11.0
	as_wait_move
	as_set_target 37.0, 11.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_11_20:
	; $5cff, 40 bytes (actor_script)
	as_set_target 33.0, 25.0
	as_wait_move
	as_set_target 21.0, 25.0
	as_wait_move
	as_set_target 21.0, 23.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
	as_set_target 19.0, 25.0
	as_wait_move
	as_set_target 25.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_11_21:
	; $5d27, 17 bytes (actor_script)
	as_set_target 19.0, 25.0
	as_wait_move
	as_set_target 9.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt

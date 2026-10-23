DataPtr_TennisMachineRoomMapScripts_14:
	dw TennisMachineRoomMapScripts_14 ; $4000
DataPtr_Court2MapScripts_14:
	dw Court2MapScripts_14 ; $4002
DataPtr_Court1MapScripts_14:
	dw Court1MapScripts_14 ; $4004
DataPtr_IslandSkyMapScripts_14:
	dw IslandSkyMapScripts_14 ; $4006
TennisMachineRoomMapScripts_14:
	; $4008, 14 bytes (map_tree)
	dw TennisMachineRoomEntryPoints_14 ; slot 0 EntryPoints
	dw TennisMachineRoomExitTriggers_14 ; slot 1 ExitTriggers
	dw TennisMachineRoomActors_14 ; slot 2 Actors
	dw TennisMachineRoomNpcScripts_14 ; slot 3 NpcScripts
	dw TennisMachineRoomFacingScripts_14 ; slot 4 FacingScripts
	dw TennisMachineRoomTileTriggers_14 ; slot 5 TileTriggers
	dw TennisMachineRoomInitScript_14 ; slot 6 InitScript
TennisMachineRoomActors_14:
	; $4016, 52 bytes (map_actors)
	map_actor $0000, ActorScript_14_2, 43.0, 51.0, FACE_RIGHT, OBJ_MACHINE_ENGINEER, ANIM_WALK, $00, TENNIS_MACHINE_ROOM_MACHINE_ENGINEER_1
	map_actor $0000, ActorScript_14_2, 43.0, 49.0, FACE_RIGHT, OBJ_MACHINE_ENGINEER, ANIM_WALK, $00, TENNIS_MACHINE_ROOM_MACHINE_ENGINEER_2
	map_actor $0000, ActorScript_14_2, 45.0, 43.0, FACE_LEFT, OBJ_MACHINE_ATTENDANT, ANIM_WALK, $00, TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT
	map_actor_end
TennisMachineRoomEntryPoints_14:
	; $404a, 25 bytes (map_entries)
	map_entry $01, FACE_UP, 43.0, 57.0, TennisMachineRoomArrival01_14, TENNIS_MACHINE_ROOM_FROM_TRAINING_CENTER
	map_entry $05, FACE_UP, 56.0, 54.0, $0000, TENNIS_MACHINE_ROOM_LEVEL_RESULT
	map_entry $07, FACE_UP, 56.0, 54.0, $0000, TENNIS_MACHINE_ROOM_PRACTICE_RESULT
	db $ff
TennisMachineRoomArrival01_14:
	ld a, [wStoryModeEntryPoint] ; $4063
	cp STORYENTRY_NONE ; $4066
	jp z, .done ; $4068
	clear_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $406b
	test_flag FLAG_DOUBLES ; $406e
	jr z, .done ; $4071
	script_set_position ACTOR_PARTNER, 43.0, 59.0 ; $4073
	script_face ACTOR_PARTNER, FACE_UP ; $407e
.done:
	ret ; $4085
TennisMachineRoomExitTriggers_14:
	; $4086, 9 bytes (map_scripts:exit)
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_TRAINING_CENTER, ENTRY_TRAINING_CENTER_FROM_TENNIS_MACHINE_ROOM, TENNIS_MACHINE_ROOM_TO_TRAINING_CENTER
	db $ff
TennisMachineRoomNpc03MachineEngineer_14:
	ld a, [wMapSceneStage] ; $408f
	add a ; $4092
	ld_hl_indexed TennisMachineRoomNpc03MachineEngineerTextIds ; $4093
	ld a, [hl+] ; $409a
	ld h, [hl] ; $409b
	ld l, a ; $409c
	farcall InitDialogueTextCursor ; $409d
	script_speak ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ENGINEER_1 ; $40a0
	ret ; $40a5
TennisMachineRoomNpc03MachineEngineerTextIds:
	; $40a6, 14 bytes (text_ids)
	table_width 2
	dw Text_MachineEngineerLatestTech ; record 0
	dw Text_MachineEngineerHarderFromHere ; record 1
	dw Text_MachineEngineerLevelThreeHarder ; record 2
	dw Text_MachineEngineerWorkedHard ; record 3
	dw Text_MachineEngineerExpertUnlocked ; record 4
	dw Text_MachineEngineerRecordImpressive ; record 5
	dw Text_MachineEngineerExceededHopes ; record 6
	assert_table_length NUM_MACHINECOURTSTAGES
TennisMachineRoomNpc04MachineEngineer_14:
	ld a, [wMapSceneStage] ; $40b4
	add a ; $40b7
	ld_hl_indexed TennisMachineRoomNpc04MachineEngineerTextIds ; $40b8
	ld a, [hl+] ; $40bf
	ld h, [hl] ; $40c0
	ld l, a ; $40c1
	farcall InitDialogueTextCursor ; $40c2
	ld a, [wMapSceneStage] ; $40c5
	cp MACHINECOURTSTAGE_LEVEL2 ; $40c8
	jr z, .level2 ; $40ca
	jr .speak ; $40cc
.level2:
	script_speak_restore ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ENGINEER_2 ; $40ce
	farcall RunDialogueYesNoPrompt ; $40d3
	farcall ScriptCloseDialogueWindow ; $40d6
	script_wait_frames 5 ; $40d9
	and a ; $40e0
	jr z, .speak ; $40e1
	farcall AdvanceDialogueTextCursor ; $40e3
.speak:
	script_speak ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ENGINEER_2 ; $40e6
	ret ; $40eb
TennisMachineRoomNpc04MachineEngineerTextIds:
	; $40ec, 14 bytes (text_ids)
	table_width 2
	dw Text_MachineEngineerHundredAllStar ; record 0
	dw Text_MachineEngineerEasierThanThought ; record 1
	dw Text_MachineEngineerStrokeStronger ; record 2
	dw Text_MachineEngineerParWithVarsity ; record 3
	dw Text_MachineEngineerExpertSystem ; record 4
	dw Text_MachineEngineerBrokeExpertRecord ; record 5
	dw Text_MachineEngineerJohnHenry ; record 6
	assert_table_length NUM_MACHINECOURTSTAGES
TennisMachineRoomNpcScripts_14:
	; $40fa, 25 bytes (map_scripts)
	map_script ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ENGINEER_1, FACEMASK_ANY, $0000, TennisMachineRoomNpc03MachineEngineer_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ENGINEER_2, FACEMASK_ANY, $0000, TennisMachineRoomNpc04MachineEngineer_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT, FACEMASK_ANY, $0000, TennisMachineRoomNpc05MachineAttendant_14, $00, $00
	db $ff
MachineLevel1FailedPrompt:
	script_set_text Text_MachineLevelFailedRetry ; $4113
	ld hl, $000f ; $4119
	farcall PushTextArgNumber ; $411c
	ld hl, wMinigamesCurrentScore ; $411f
	ld a, [hl+] ; $4122
	ld h, [hl] ; $4123
	ld l, a ; $4124
	farcall PushTextArgNumber ; $4125
	jp MachineCourtHandleRetryChoice ; $4128
MachineLevel1ClearedScene:
	call MachineCourtWalkToAttendantCutscene ; $412b
	script_set_text Text_MachineClearedLevelOne ; $412e
	script_speak ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $4134
	script_follow ACTOR_PARTNER, ACTOR_PLAYER ; $4139
	ret ; $4146
MachineLevel2FailedPrompt:
	script_set_text Text_MachineLevelFailedRetry ; $4147
	ld hl, $001e ; $414d
	farcall PushTextArgNumber ; $4150
	ld hl, wMinigamesCurrentScore ; $4153
	ld a, [hl+] ; $4156
	ld h, [hl] ; $4157
	ld l, a ; $4158
	farcall PushTextArgNumber ; $4159
	jp MachineCourtHandleRetryChoice ; $415c
	ret ; $415f
MachineLevel2ClearedScene:
	call MachineCourtWalkToAttendantCutscene ; $4160
	script_set_text Text_MachineClearedLevelTwo ; $4163
	script_speak ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $4169
	script_follow ACTOR_PARTNER, ACTOR_PLAYER ; $416e
	ret ; $417b
MachineLevel3FailedPrompt:
	script_set_text Text_MachineLevelFailedRetry ; $417c
	ld hl, $003c ; $4182
	farcall PushTextArgNumber ; $4185
	ld hl, wMinigamesCurrentScore ; $4188
	ld a, [hl+] ; $418b
	ld h, [hl] ; $418c
	ld l, a ; $418d
	farcall PushTextArgNumber ; $418e
	jp MachineCourtHandleRetryChoice ; $4191
	ret ; $4194
MachineLevel3ClearedScene:
	call MachineCourtWalkToAttendantCutscene ; $4195
	script_set_text Text_MachineClearedLevelThree ; $4198
	script_speak ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $419e
	script_follow ACTOR_PARTNER, ACTOR_PLAYER ; $41a3
	ret ; $41b0
MachineLevel4FailedPrompt:
	script_set_text Text_MachineLevelFailedRetry ; $41b1
	ld hl, $0064 ; $41b7
	farcall PushTextArgNumber ; $41ba
	ld hl, wMinigamesCurrentScore ; $41bd
	ld a, [hl+] ; $41c0
	ld h, [hl] ; $41c1
	ld l, a ; $41c2
	farcall PushTextArgNumber ; $41c3
	jp MachineCourtHandleRetryChoice ; $41c6
	ret ; $41c9
MachineLevel4ClearedScene:
	call MachineCourtWalkToAttendantCutscene ; $41ca
	script_set_text Text_MachineClearedLevelFour ; $41cd
	script_speak ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $41d3
	script_follow ACTOR_PARTNER, ACTOR_PLAYER ; $41d8
	ret ; $41e5
TennisMachineRoomFacingScripts_14:
	db $ff ; $41e6
TennisMachineRoomTileTriggers_14:
	; $41e7, 41 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, ~FLAG_TEMP_SCENE_VARIANT_B, TennisMachineRoomTile01_14, $00, $00
	map_script $03, FACEMASK_ANY, $0000, TennisMachineRoomTile03_14, TILETRIGGER_PRESS_ONLY, $00
	map_script $04, FACEMASK_ANY, $0000, TennisMachineRoomTile04_14, TILETRIGGER_PRESS_ONLY, $00
	map_script $05, FACEMASK_ANY, $0000, TennisMachineRoomTile05_14, TILETRIGGER_PRESS_ONLY, $00
	map_script $06, FACEMASK_ANY, $0000, TennisMachineRoomTile06_14, TILETRIGGER_PRESS_ONLY, $00
	db $ff
TennisMachineRoomTile03_14:
	ld a, $00 ; $4210
	jp MachinePracticeLevelPrompt ; $4212
	ret ; $4215
TennisMachineRoomTile04_14:
	ld a, $01 ; $4216
	jp MachinePracticeLevelPrompt ; $4218
	ret ; $421b
TennisMachineRoomTile05_14:
	ld a, $02 ; $421c
	jp MachinePracticeLevelPrompt ; $421e
	ret ; $4221
TennisMachineRoomTile06_14:
	ld a, $03 ; $4222
	jp MachinePracticeLevelPrompt ; $4224
TennisMachineRoomTile01_14:
	clear_flag FLAG_TEMP_SCENE_VARIANT_B ; $4227
	clear_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $422a
	script_move_target ACTOR_PLAYER, 42.75, 43.0 ; $422d
	script_wait_move ACTOR_PLAYER ; $4238
	script_move_target ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT, 45.0, 43.0 ; $423d
	script_wait_move ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $4248
	script_wait_frames 5 ; $424d
	script_face ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT, FACE_LEFT ; $4254
	script_face ACTOR_PLAYER, FACE_RIGHT ; $425b
	script_follow ACTOR_PARTNER, ACTOR_PLAYER ; $4262
	ret ; $426f
Unused_14_TableAfterTennisMachineRoomTile01:
	; $4270, 8 bytes (bytes:16)
	db $12, $13, $14, $15, $1a, $1a, $1a, $1a ; 0x00
TennisMachineRoomInitScript_14:
	ld a, $26 ; $4278
	ld [wMapScrollMinX], a ; $427a
	ld a, $23 ; $427d
	ld [wMapScrollMinY], a ; $427f
	ld a, $40 ; $4282
	ld [wMapWidthTiles], a ; $4284
	ld a, $3c ; $4287
	ld [wMapHeightTiles], a ; $4289
	call DisableLCDSafely ; $428c
	ld a, SCENECOPY_FROM_PLAYER ; $428f
	farcall CopyScrolledSceneTilemapToVram ; $4291
	call EnableLCD ; $4294
	call ComputeMachineCourtProgress ; $4297
	farcall WaitPlayerMoveDone ; $429a
	ld a, [wStoryModeEntryPoint] ; $429d
	cp ENTRY_TENNIS_MACHINE_ROOM_LEVEL_RESULT ; $42a0
	jp z, MachineCourtResultScene ; $42a2
	cp ENTRY_TENNIS_MACHINE_ROOM_PRACTICE_RESULT ; $42a5
	jp z, MachinePracticeResultScene ; $42a7
	cp STORYENTRY_NONE ; $42aa
	jp z, TennisMachineRoomNoEntryScene ; $42ac
	ret ; $42af
MachineCourtResultScene:
	test_flag FLAG_DOUBLES ; $42b0
	jr z, .placeAttendant ; $42b3
	script_null_script ACTOR_PARTNER ; $42b5
	script_wait_frames 10 ; $42ba
	script_set_position ACTOR_PARTNER, 41.0, 43.0 ; $42c1
	script_face ACTOR_PARTNER, FACE_RIGHT ; $42cc
.placeAttendant:
	script_set_position ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT, 45.0, 41.0 ; $42d3
	script_face ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT, FACE_DOWN ; $42de
	script_fade_in 6 ; $42e5
	call WaitFadeEnd ; $42ea
	script_wait_frames 40 ; $42ed
	script_set_speed ACTOR_PLAYER, 1.0 ; $42f4
	test_flag FLAG_DOUBLES ; $42fc
	jr z, .clearShowLocationName ; $42ff
.clearShowLocationName:
	xor a ; $4301
	ld [wStoryModeShowLocationName], a ; $4302
	ld a, [wMatchExitRequest] ; $4305
	and a ; $4308
	jp nz, MachineCourtGameOverExitScene ; $4309
	ld a, [wPointWinLoseFlag] ; $430c
	cp WINLOSE_WIN ; $430f
	jr z, .levelCleared ; $4311
	ld a, [wMapSceneStage] ; $4313
	jumptable a ; $4316
	dw MachineLevel1FailedPrompt ; $4318 jumptable
	dw MachineLevel2FailedPrompt ; $431a jumptable
	dw MachineLevel3FailedPrompt ; $431c jumptable
	dw MachineLevel4FailedPrompt ; $431e jumptable
	dw MachineExpertResultScene ; $4320 jumptable
	dw MachineExpertResultScene ; $4322 jumptable
	dw MachineExpertResultScene ; $4324 jumptable
.levelCleared:
	ld a, [wMapSceneStage] ; $4326
	dec a ; $4329
	jumptable a ; $432a
	dw MachineLevel1ClearedScene ; $432c jumptable
	dw MachineLevel2ClearedScene ; $432e jumptable
	dw MachineLevel3ClearedScene ; $4330 jumptable
	dw MachineLevel4ClearedScene ; $4332 jumptable
	dw MachineExpertResultScene ; $4334 jumptable
	dw MachineExpertResultScene ; $4336 jumptable
	dw MachineExpertResultScene ; $4338 jumptable
MachineCourtGameOverExitScene:
	script_set_text Text_MachineGameOverLeaveCourt ; $433a
	script_speak ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $4340
	script_move_target ACTOR_PLAYER, 51.0, 54.0 ; $4345
	script_wait_move ACTOR_PLAYER ; $4350
	script_move_player 47.0, 45.0 ; $4355
	script_move_target ACTOR_PLAYER, 51.0, 43.0 ; $435f
	script_wait_move ACTOR_PLAYER ; $436a
	script_move_target ACTOR_PLAYER, 43.0, 43.0 ; $436f
	script_wait_move ACTOR_PLAYER ; $437a
	script_move_target ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT, 45.0, 43.0 ; $437f
	script_wait_move ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $438a
	script_face ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT, FACE_LEFT ; $438f
	script_follow ACTOR_PARTNER, ACTOR_PLAYER ; $4396
	ret ; $43a3
ComputeMachineCourtProgress:
	ld a, MACHINECOURTSTAGE_LEVEL1 ; $43a4
	test_flag FLAG_CLEARED_MACHINE_LEVEL_1 ; $43a6
	jp z, .storeStage ; $43a9
	script_copy_scene_rect 30, 44, 48, 44, 2, 2 ; $43ac
	ld a, MACHINECOURTSTAGE_LEVEL2 ; $43bb
	test_flag FLAG_CLEARED_MACHINE_LEVEL_2 ; $43bd
	jp z, .storeStage ; $43c0
	script_copy_scene_rect 30, 48, 48, 48, 2, 2 ; $43c3
	ld a, MACHINECOURTSTAGE_LEVEL3 ; $43d2
	test_flag FLAG_CLEARED_MACHINE_LEVEL_3 ; $43d4
	jr z, .storeStage ; $43d7
	script_copy_scene_rect 30, 52, 48, 52, 2, 2 ; $43d9
	ld a, MACHINECOURTSTAGE_LEVEL4 ; $43e8
	test_flag FLAG_CLEARED_MACHINE_LEVEL_4 ; $43ea
	jr z, .storeStage ; $43ed
	script_copy_scene_rect 30, 56, 48, 56, 2, 2 ; $43ef
	ld a, MACHINECOURTSTAGE_MASTER ; $43fe
	ld b, a ; $4400
	ld a, MGRECORD_MACHINE ; $4401
	farcall ReadMinigameRecord ; $4403
	push_wram_bank WRAM_SOUND ; $4406
	ld hl, wMinigameRecordValue ; $440f
	ld a, [hl+] ; $4412
	ld h, [hl] ; $4413
	ld l, a ; $4414
	pop_wram_bank ; $4415
	ld a, b ; $441a
	test_flag FLAG_CLEARED_MACHINE_MASTER ; $441b
	jr z, .storeStage ; $441e
	ld a, MACHINECOURTSTAGE_EXPERT ; $4420
	test_flag FLAG_CLEARED_MACHINE_EXPERT ; $4422
	jr z, .storeStage ; $4425
	ld a, MACHINECOURTSTAGE_COMPLETE ; $4427
.storeStage:
	ld [wMapSceneStage], a ; $4429
	ret ; $442c
TennisMachineRoomNpc05MachineAttendant_14:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $442d
	jp nz, MachineCourtStartLevelScene ; $4430
	ld a, [wMapSceneStage] ; $4433
	add a ; $4436
	ld_hl_indexed TennisMachineRoomNpc05MachineAttendantTextIds ; $4437
	ld a, [hl+] ; $443e
	ld h, [hl] ; $443f
	ld l, a ; $4440
	farcall InitDialogueTextCursor ; $4441
	ld a, [wMapSceneStage] ; $4444
	cp MACHINECOURTSTAGE_EXPERT ; $4447
	jr c, .prompt ; $4449
	push_wram_bank WRAM_SOUND ; $444b
	ld a, MGRECORD_MACHINE ; $4454
	farcall ReadMinigameRecord ; $4456
	ld hl, wMinigameRecordValue ; $4459
	ld a, [hl+] ; $445c
	ld h, [hl] ; $445d
	ld l, a ; $445e
	pop_wram_bank ; $445f
	farcall PushTextArgNumber ; $4464
.prompt:
	script_face ACTOR_PARTNER, FACE_RIGHT ; $4467
	script_face ACTOR_PLAYER, FACE_RIGHT ; $446e
	script_speak_restore ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $4475
	farcall RunDialogueYesNoPrompt ; $447a
	farcall ScriptCloseDialogueWindow ; $447d
	script_wait_frames 5 ; $4480
	and a ; $4487
	jr nz, .declined ; $4488
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $448a
	farcall AdvanceDialogueTextCursor ; $448d
	ld a, [wMapSceneStage] ; $4490
	and a ; $4493
	jr nz, .nodAndStart ; $4494
	script_speak ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $4496
.nodAndStart:
	script_set_anim ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT, ANIM_NOD ; $449b
	script_wait_idle ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $44a2
	jr nz, MachineCourtStartLevelScene ; $44a7
.declined:
	test_flag FLAG_CLEARED_MACHINE_LEVEL_1 ; $44a9
	jr z, .declinedReply ; $44ac
	script_set_text Text_MachineAttendantPracticeCleared ; $44ae
	script_speak_restore ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $44b4
	farcall RunDialogueYesNoPrompt ; $44b9
	farcall ScriptCloseDialogueWindow ; $44bc
	script_wait_frames 5 ; $44bf
	and a ; $44c6
	jp z, MachineCourtStartLevelScene.startPracticeSession ; $44c7
.declinedReply:
	ld a, [wMapSceneStage] ; $44ca
	add a ; $44cd
	ld_hl_indexed TennisMachineRoomNpc05MachineAttendantTextIds ; $44ce
	ld a, [hl+] ; $44d5
	ld h, [hl] ; $44d6
	ld l, a ; $44d7
	farcall InitDialogueTextCursor ; $44d8
	farcall AdvanceDialogueTextCursor ; $44db
	script_speak ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $44de
	ret ; $44e3
MachineCourtStartLevelScene:
	ld a, [wMapSceneStage]
	ld e, a
	ld d, ITEM_TENNIS_MACHINE
	apcall ApStageLocked
	jp nz, MachineLevelNotClearedMessage
	script_speak ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $44e4
	script_move_target ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT, 45.0, 41.0 ; $44e9
	script_wait_move ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $44f4
	script_face ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT, FACE_DOWN ; $44f9
	test_flag FLAG_DOUBLES ; $4500
	jr z, .playerWalkIn ; $4503
	script_null_script ACTOR_PARTNER ; $4505
	script_set_actor_script ACTOR_PARTNER, ActorScript_14_0 ; $450a
.playerWalkIn:
	script_set_speed ACTOR_PLAYER, 1.0 ; $4515
	script_move_player 56.0, 51.0 ; $451d
	script_move_target ACTOR_PLAYER, 51.0, 43.0 ; $4527
	script_wait_move ACTOR_PLAYER ; $4532
	script_move_target ACTOR_PLAYER, 51.0, 51.0 ; $4537
	script_wait_move ACTOR_PLAYER ; $4542
	script_move_target ACTOR_PLAYER, 56.0, 53.0 ; $4547
	script_wait_move ACTOR_PLAYER ; $4552
	script_face ACTOR_PLAYER, FACE_UP ; $4557
	script_wait_frames 10 ; $455e
	ld a, [wMapSceneStage] ; $4565
	cp MACHINECOURTSTAGE_MASTER ; $4568
	jr c, .notMaster ; $456a
	script_set_text Text_MachineCountdownBlastOff ; $456c
	script_speak ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $4572
.notMaster:
	script_fade_out 6 ; $4577
	call WaitFadeEnd ; $457c
	clear_flag FLAG_TEMP_SCENE_VARIANT_A ; $457f
	ld a, STORYLOC_TENNIS_MACHINE_ROOM ; $4582
	ld [wStoryModeCurrentLocation], a ; $4584
	ld a, ENTRY_TENNIS_MACHINE_ROOM_LEVEL_RESULT ; $4587
	ld [wStoryModeEntryPoint], a ; $4589
	ld a, EXITTRIGGER_DIRECT ; $458c
	ld [wUnusedExitTriggerIdMirror], a ; $458e
	ld [wStoryModeExitTriggerRequest], a ; $4591
	ld a, [wMapSceneStage] ; $4594
	ld_hl_indexed MachineStageDrillIds ; $4597
	ld a, [hl] ; $459e
	farcall RunTrainingDrillByID ; $459f
	farcall EndCutsceneScriptMode ; $45a2
	ret ; $45a5
.startPracticeSession:
	script_speak ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $45a6
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $45ab
	script_move_target ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT, 45.0, 41.0 ; $45ae
	script_wait_move ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT ; $45b9
	script_face ACTOR_TENNIS_MACHINE_ROOM_MACHINE_ATTENDANT, FACE_DOWN ; $45be
	script_null_script ACTOR_PARTNER ; $45c5
	script_set_speed ACTOR_PLAYER, 1.0 ; $45ca
	script_set_actor_script ACTOR_PARTNER, ActorScript_14_0 ; $45d2
	script_move_target ACTOR_PLAYER, 49.0, 43.0 ; $45dd
	script_wait_move ACTOR_PLAYER ; $45e8
	script_face ACTOR_PLAYER, FACE_DOWN ; $45ed
	set_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $45f4
	ret ; $45f7
MachineStageDrillIds:
	; $45f8, 7 bytes (bytes:7)
	table_width 1
	db MINIGAME_TENNIS_MACHINE_1, MINIGAME_TENNIS_MACHINE_2, MINIGAME_TENNIS_MACHINE_3, MINIGAME_TENNIS_MACHINE_4, MINIGAME_TENNIS_MACHINE_HIGH_SCORE, MINIGAME_TENNIS_MACHINE_HIGH_SCORE, MINIGAME_TENNIS_MACHINE_HIGH_SCORE
	assert_table_length NUM_MACHINECOURTSTAGES
MachineCourtStartLevelScene.deadRet:
	ret ; $45ff

DataPtr_TrainingGymMapScripts_0e:
	dw TrainingGymMapScripts_0e ; $4000
DataPtr_MarioWorldMapScripts_0e:
	dw MarioWorldMapScripts_0e ; $4002
DataPtr_SpecialCourtMapScripts_0e:
	dw SpecialCourtMapScripts_0e ; $4004
TrainingGymMapScripts_0e:
	; $4006, 14 bytes (map_tree)
	dw TrainingGymEntryPoints_0e ; slot 0 EntryPoints
	dw TrainingGymExitTriggers_0e ; slot 1 ExitTriggers
	dw TrainingGymActors_0e ; slot 2 Actors
	dw TrainingGymNpcScripts_0e ; slot 3 NpcScripts
	dw TrainingGymFacingScripts_0e ; slot 4 FacingScripts
	dw TrainingGymTileTriggers_0e ; slot 5 TileTriggers
	dw TrainingGymInitScript_0e ; slot 6 InitScript
TrainingGymActors_0e:
	; $4014, 178 bytes (map_actors)
	map_actor $0000, ActorScript_0e_22, 37.0, 13.0, FACE_DOWN, OBJ_WEIGHTLIFTER_A, ANIM_WALK, $00, TRAINING_GYM_WEIGHTLIFTER_A
	map_actor $0000, ActorScript_0e_22, 41.0, 15.0, FACE_DOWN, OBJ_WEIGHTLIFTER_B, ANIM_WALK, $05, TRAINING_GYM_WEIGHTLIFTER_B
	map_actor $0000, ActorScript_0e_22, 37.0, 21.0, FACE_DOWN, OBJ_SITUPS_A, ANIM_WALK, $07, TRAINING_GYM_SITUPS_A
	map_actor $0000, ActorScript_0e_22, 41.0, 19.0, FACE_DOWN, OBJ_SITUPS_B, ANIM_WALK, $05, TRAINING_GYM_SITUPS_B
	map_actor $0000, ActorScript_0e_22, 37.0, 5.0, FACE_DOWN, OBJ_JUMPING_JACKS_B, ANIM_WALK, $07, TRAINING_GYM_JUMPING_JACKS_B_1
	map_actor $0000, ActorScript_0e_22, 39.0, 7.0, FACE_DOWN, OBJ_JUMPING_JACKS_A, ANIM_WALK, $00, TRAINING_GYM_JUMPING_JACKS_A
	map_actor $0000, ActorScript_0e_22, 41.0, 5.0, FACE_DOWN, OBJ_JUMPING_JACKS_B, ANIM_WALK, $00, TRAINING_GYM_JUMPING_JACKS_B_2
	map_actor $0000, ActorScript_0e_00, 33.0, 12.0, FACE_DOWN, OBJ_STUDENT_BLACK_HAIR_BOY, ANIM_WALK, $00, TRAINING_GYM_STUDENT_BLACK_HAIR_BOY_1
	map_actor $0000, ActorScript_0e_01, 44.0, 11.0, FACE_LEFT, OBJ_STUDENT_HEADBAND_BOY, ANIM_WALK, $00, TRAINING_GYM_STUDENT_HEADBAND_BOY
	map_actor $0000, ActorScript_0e_02, 45.375, 23.0, FACE_RIGHT, OBJ_STUDENT_BLACK_HAIR_BOY, ANIM_WALK, $06, TRAINING_GYM_STUDENT_BLACK_HAIR_BOY_2
	map_actor $0000, ActorScript_0e_05, 25.0, 17.0, FACE_UP, OBJ_STUDENT_SIDE_PART_BOY, ANIM_WALK, $06, TRAINING_GYM_STUDENT_SIDE_PART_BOY_1
	map_actor $0000, ActorScript_0e_22, 13.0, 19.0, FACE_RIGHT, OBJ_STUDENT_SIDE_PART_BOY, ANIM_WALK, $07, TRAINING_GYM_STUDENT_SIDE_PART_BOY_2
	map_actor_end
TrainingGymEntryPoints_0e:
	; $40c6, 57 bytes (map_entries)
	map_entry $01, FACE_UP, 22.0, 24.0, TrainingGymArrival01_0e, TRAINING_CENTER_FROM_COURTYARD
	map_entry $02, FACE_DOWN, 11.0, 12.0, TrainingGymArrival02_0e, TRAINING_CENTER_FROM_WALL_PRACTICE_ROOM
	map_entry $03, FACE_DOWN, 21.0, 12.0, TrainingGymArrival03_0e, TRAINING_CENTER_FROM_TENNIS_MACHINE_ROOM
	map_entry $0b, FACE_DOWN, 13.0, 15.0, $0000, TRAINING_CENTER_REPAIR_COUNTER_A
	map_entry $0c, FACE_LEFT, 17.0, 19.0, $0000, TRAINING_CENTER_REPAIR_COUNTER_B
	map_entry $0d, FACE_DOWN, 13.0, 15.0, $0000, TRAINING_CENTER_REPAIR_COUNTER_A_CHANGED
	map_entry $0e, FACE_LEFT, 17.0, 19.0, $0000, TRAINING_CENTER_REPAIR_COUNTER_B_CHANGED
	db $ff
TrainingGymArrival01_0e:
	ld a, [wStoryModeEntryPoint] ; $40ff
	cp STORYENTRY_NONE ; $4102
	jp z, .done ; $4104
	test_flag FLAG_DOUBLES ; $4107
	jr z, .walkUp ; $410a
	script_set_speed ACTOR_PARTNER, 7.96875 ; $410c
	script_move_angle ACTOR_PARTNER, FACE_DOWN, 2.0 ; $4114
	script_wait_move ACTOR_PARTNER ; $411e
	script_face ACTOR_PARTNER, FACE_UP ; $4123
	script_set_speed ACTOR_PARTNER, 0.5 ; $412a
.walkUp:
	script_set_speed ACTOR_PLAYER, 0.5 ; $4132
	script_move_angle ACTOR_PLAYER, FACE_UP, 2.0 ; $413a
.done:
	ret ; $4144
TrainingGymArrival02_0e:
	ld a, [wStoryModeEntryPoint] ; $4145
	cp STORYENTRY_NONE ; $4148
	jp z, .done ; $414a
	script_set_speed ACTOR_PLAYER, 0.5 ; $414d
	script_set_speed ACTOR_PARTNER, 0.5 ; $4155
	farcall WaitPlayerMoveDone ; $415d
	script_copy_scene_rect 10, 10, 61, 12, 2, 2 ; $4160
	script_copy_scene_rect 61, 10, 10, 10, 2, 2 ; $416f
	script_wait_frames 2 ; $417e
	script_fade_in 8 ; $4185
	call WaitFadeEnd ; $418a
	script_move_target ACTOR_PLAYER, 11.0, 14.0 ; $418d
	script_wait_move ACTOR_PLAYER ; $4198
	sound SFX_DOOR ; $419d
	script_wait_frames 2 ; $419f
	script_copy_scene_rect 58, 10, 10, 10, 2, 2 ; $41a6
	script_wait_frames 2 ; $41b5
	script_copy_scene_rect 55, 10, 10, 10, 2, 2 ; $41bc
	script_wait_frames 2 ; $41cb
	script_copy_scene_rect 61, 12, 10, 10, 2, 2 ; $41d2
.done:
	ret ; $41e1
TrainingGymArrival03_0e:
	ld a, [wStoryModeEntryPoint] ; $41e2
	cp STORYENTRY_NONE ; $41e5
	jr z, TrainingGymArrival02_0e.done ; $41e7
	script_set_speed ACTOR_PLAYER, 0.5 ; $41e9
	script_set_speed ACTOR_PARTNER, 0.5 ; $41f1
	farcall WaitPlayerMoveDone ; $41f9
	script_copy_scene_rect 10, 10, 61, 12, 2, 2 ; $41fc
	script_copy_scene_rect 61, 10, 20, 10, 2, 2 ; $420b
	script_fade_in 8 ; $421a
	call WaitFadeEnd ; $421f
	script_move_target ACTOR_PLAYER, 21.0, 14.0 ; $4222
	script_wait_move ACTOR_PLAYER ; $422d
	sound SFX_DOOR ; $4232
	script_wait_frames 2 ; $4234
	script_copy_scene_rect 58, 10, 20, 10, 2, 2 ; $423b
	script_wait_frames 2 ; $424a
	script_copy_scene_rect 55, 10, 20, 10, 2, 2 ; $4251
	script_wait_frames 2 ; $4260
	script_copy_scene_rect 61, 12, 20, 10, 2, 2 ; $4267
	ret ; $4276
TrainingGymExitTriggers_0e:
	; $4277, 25 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_0e, STORYLOC_COURTYARD, ENTRY_COURTYARD_FROM_TRAINING_CENTER, TRAINING_CENTER_TO_COURTYARD
	map_script $03, FACEMASK_ANY, $0000, TrainingGymExit03_0e, STORYLOC_TENNIS_MACHINE_ROOM, ENTRY_TENNIS_MACHINE_ROOM_FROM_TRAINING_CENTER, TRAINING_CENTER_TO_TENNIS_MACHINE_ROOM
	map_script $02, FACEMASK_ANY, $0000, TrainingGymExit02_0e, STORYLOC_WALL_PRACTICE_ROOM, ENTRY_WALL_PRACTICE_ROOM_FROM_TRAINING_CENTER, TRAINING_CENTER_TO_WALL_PRACTICE_ROOM
	db $ff
TrainingGymExit02_0e:
	script_face ACTOR_PLAYER, FACE_UP ; $4290
	script_lock_facing ACTOR_PLAYER ; $4297
	script_set_speed ACTOR_PLAYER, 0.75 ; $429e
	script_move_target ACTOR_PLAYER, 11.0, 13.0 ; $42a6
	script_wait_move ACTOR_PLAYER ; $42b1
	farcall WaitPlayerMoveDone ; $42b6
	sound SFX_DOOR ; $42b9
	script_copy_scene_rect 55, 10, 10, 10, 2, 2 ; $42bb
	script_wait_frames 2 ; $42ca
	script_copy_scene_rect 58, 10, 10, 10, 2, 2 ; $42d1
	script_wait_frames 2 ; $42e0
	script_copy_scene_rect 61, 10, 10, 10, 2, 2 ; $42e7
	script_wait_frames 2 ; $42f6
	script_move_angle ACTOR_PLAYER, FACE_UP, 1.0 ; $42fd
	script_fade_out 8 ; $4307
	script_unlock_facing ACTOR_PLAYER ; $430c
	script_wait_frames 10 ; $4313
	ret ; $431a
TrainingGymExit03_0e:
	script_face ACTOR_PLAYER, FACE_UP ; $431b
	script_lock_facing ACTOR_PLAYER ; $4322
	script_set_speed ACTOR_PLAYER, 0.75 ; $4329
	script_move_target ACTOR_PLAYER, 21.0, 13.0 ; $4331
	script_wait_move ACTOR_PLAYER ; $433c
	farcall WaitPlayerMoveDone ; $4341
	sound SFX_DOOR ; $4344
	script_copy_scene_rect 55, 10, 20, 10, 2, 2 ; $4346
	script_wait_frames 2 ; $4355
	script_copy_scene_rect 58, 10, 20, 10, 2, 2 ; $435c
	script_wait_frames 2 ; $436b
	script_copy_scene_rect 61, 10, 20, 10, 2, 2 ; $4372
	script_wait_frames 2 ; $4381
	script_move_angle ACTOR_PLAYER, FACE_UP, 1.0 ; $4388
	script_fade_out 8 ; $4392
	script_unlock_facing ACTOR_PLAYER ; $4397
	script_wait_frames 10 ; $439e
	ret ; $43a5
TrainingGymNpc03_0e:
	ld a, [wMapSceneStage] ; $43a6
	add a ; $43a9
	ld_hl_indexed TrainingGymNpc03TextIds ; $43aa
	ld a, [hl+] ; $43b1
	ld h, [hl] ; $43b2
	ld l, a ; $43b3
	farcall InitDialogueTextCursor ; $43b4
	script_speak ACTOR_TRAINING_GYM_WEIGHTLIFTER_A ; $43b7
	ret ; $43bc
TrainingGymNpc03TextIds:
	; $43bd, 20 bytes (text_ids)
	table_width 2
	dw Text_GymLifterTooMuchMuscleSlows ; record 0
	dw Text_GymLifterTooMuchMuscleSlows ; record 1
	dw Text_GymLifterHeavyWeightsHurt ; record 2
	dw Text_GymLifterHeavyWeightsHurt ; record 3
	dw Text_GymLifterVarsitySkipBench ; record 4
	dw Text_GymLifterVarsityPairSkipBench ; record 5
	dw Text_GymLifterTravelingTeamIronGear ; record 6
	dw Text_GymLifterTryRepairCounter ; record 7
	dw Text_GymLifterHeyIslandOpenChamp ; record 8
	dw Text_GymLifterHeyIslandOpenChamp ; record 9
	assert_table_length NUM_STORYRANKS
TrainingGymNpc04_0e:
	ld a, [wMapSceneStage] ; $43d1
	sra a ; $43d4
	add a ; $43d6
	ld_hl_indexed TrainingGymNpc04TextIds ; $43d7
	ld a, [hl+] ; $43de
	ld h, [hl] ; $43df
	ld l, a ; $43e0
	farcall InitDialogueTextCursor ; $43e1
	script_speak ACTOR_TRAINING_GYM_WEIGHTLIFTER_B ; $43e4
	ret ; $43e9
TrainingGymNpc04TextIds:
	; $43ea, 10 bytes (text_ids)
	table_width 2
	dw Text_GymLifterGirlWantsMorePower ; record 0
	dw Text_GymLifterGirlUppingWeights ; record 1
	dw Text_GymLifterGirlVarsityExperience ; record 2
	dw Text_GymLifterGirlSeniorsUseRepair ; record 3
	dw Text_GymLifterGirlMuscleTone ; record 4
	assert_table_length NUM_STORYTIERS
TrainingGymNpc05_0e:
	ld a, [wMapSceneStage] ; $43f4
	add a ; $43f7
	ld_hl_indexed TrainingGymNpc05TextIds ; $43f8
	ld a, [hl+] ; $43ff
	ld h, [hl] ; $4400
	ld l, a ; $4401
	farcall InitDialogueTextCursor ; $4402
	script_speak ACTOR_TRAINING_GYM_SITUPS_A ; $4405
	ret ; $440a
TrainingGymNpc05TextIds:
	; $440b, 20 bytes (text_ids)
	table_width 2
	dw Text_GymSitupsOutlastOpponents ; record 0
	dw Text_GymSitupsOutlastOpponents ; record 1
	dw Text_GymSitupsEvenLegMuscle ; record 2
	dw Text_GymSitupsEvenLegMuscle ; record 3
	dw Text_GymSitupsVarsityFootrace ; record 4
	dw Text_GymSitupsVarsityFootracePair ; record 5
	dw Text_GymSitupsLegStrengthThink ; record 6
	dw Text_GymSitupsLegStrengthSay ; record 7
	dw Text_GymSitupsLookAtMyLegs ; record 8
	dw Text_GymSitupsLookAtMyLegs ; record 9
	assert_table_length NUM_STORYRANKS
TrainingGymNpc06_0e:
	ld a, [wMapSceneStage] ; $441f
	add a ; $4422
	ld_hl_indexed TrainingGymNpc06TextIds ; $4423
	ld a, [hl+] ; $442a
	ld h, [hl] ; $442b
	ld l, a ; $442c
	farcall InitDialogueTextCursor ; $442d
	script_speak ACTOR_TRAINING_GYM_SITUPS_B ; $4430
	ret ; $4435
TrainingGymNpc06TextIds:
	; $4436, 20 bytes (text_ids)
	table_width 2
	dw Text_GymSitupsMachineTrainingHelps ; record 0
	dw Text_GymSitupsMachineTrainingHelps ; record 1
	dw Text_GymSitupsRunningBuildsEndurance ; record 2
	dw Text_GymSitupsRunningBuildsEndurance ; record 3
	dw Text_GymSitupsAlmostReachedGoal ; record 4
	dw Text_GymSitupsAlmostReachedGoal ; record 5
	dw Text_GymSitupsAfraidToRest ; record 6
	dw Text_GymSitupsAfraidToRestPair ; record 7
	dw Text_GymSitupsHowLongToTrain ; record 8
	dw Text_GymSitupsHowLongToTrain ; record 9
	assert_table_length NUM_STORYRANKS
TrainingGymNpc07_0e:
	ld a, [wMapSceneStage] ; $444a
	sra a ; $444d
	cp STORYTIER_ISLAND_OPEN ; $444f
	jr z, TrainingGymNpc07_0e.speak ; $4451
	add a ; $4453
	ld_hl_indexed TrainingGymNpc07TextIds ; $4454
	ld a, [hl+] ; $445b
	ld h, [hl] ; $445c
	ld l, a ; $445d
	farcall InitDialogueTextCursor ; $445e
	script_speak ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1 ; $4461
	ret ; $4466
TrainingGymNpc07TextIds:
	; $4467, 10 bytes (text_ids)
	table_width 2
	dw Text_GymAerobicsRhythmTraining ; record 0
	dw Text_GymAerobicsMuscleElasticity ; record 1
	dw Text_GymAerobicsWhyNotJoinUs ; record 2
	dw Text_GymAerobicsOffTempo ; record 3
	dw Text_GymAerobicsIronShoesOff ; record 4
	assert_table_length NUM_STORYTIERS
TrainingGymNpc07_0e.speak:
	script_set_text Text_GymAerobicsOffTempo ; $4471
	script_speak_restore ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1 ; $4477
	farcall RunDialogueYesNoPrompt ; $447c
	farcall ScriptCloseDialogueWindow ; $447f
	script_wait_frames 5 ; $4482
	and a ; $4489
	jr z, TrainingGymNpc07_0e.speakLine ; $448a
	farcall AdvanceDialogueTextCursor ; $448c
TrainingGymNpc07_0e.speakLine:
	script_speak ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1 ; $448f
	ret ; $4494
TrainingGymNpc08_0e:
	ld a, [wMapSceneStage] ; $4495
	sra a ; $4498
	add a ; $449a
	ld_hl_indexed TrainingGymNpc08TextIds ; $449b
	ld a, [hl+] ; $44a2
	ld h, [hl] ; $44a3
	ld l, a ; $44a4
	farcall InitDialogueTextCursor ; $44a5
	script_speak ACTOR_TRAINING_GYM_JUMPING_JACKS_A ; $44a8
	ret ; $44ad
TrainingGymNpc08TextIds:
	; $44ae, 10 bytes (text_ids)
	table_width 2
	dw Text_GymAerobicsBreatheBurnFat ; record 0
	dw Text_GymAerobicsHeadbandHelps ; record 1
	dw Text_GymAerobicsAlreadySweaty ; record 2
	dw Text_GymAerobicsNoIronShoes ; record 3
	dw Text_GymAerobicsNoRhythmThrowsOff ; record 4
	assert_table_length NUM_STORYTIERS
TrainingGymNpc09_0e:
	ld a, [wMapSceneStage] ; $44b8
	sra a ; $44bb
	add a ; $44bd
	ld_hl_indexed TrainingGymNpc09TextIds ; $44be
	ld a, [hl+] ; $44c5
	ld h, [hl] ; $44c6
	ld l, a ; $44c7
	farcall InitDialogueTextCursor ; $44c8
	script_speak ACTOR_TRAINING_GYM_JUMPING_JACKS_B_2 ; $44cb
	ret ; $44d0
TrainingGymNpc09TextIds:
	; $44d1, 10 bytes (text_ids)
	table_width 2
	dw Text_GymAerobicsInviteToDance ; record 0
	dw Text_GymAerobicsWhyNotMorePeople ; record 1
	dw Text_GymAerobicsSelfConscious ; record 2
	dw Text_GymAerobicsWhoIsThatDancer ; record 3
	dw Text_GymAerobicsDancingWeirdRude ; record 4
	assert_table_length NUM_STORYTIERS
TrainingGymNpc0A_0e:
	ld a, [wMapSceneStage] ; $44db
	add a ; $44de
	ld_hl_indexed TrainingGymNpc0ATextIds ; $44df
	ld a, [hl+] ; $44e6
	ld h, [hl] ; $44e7
	ld l, a ; $44e8
	farcall InitDialogueTextCursor ; $44e9
	script_speak ACTOR_TRAINING_GYM_STUDENT_BLACK_HAIR_BOY_1 ; $44ec
	ret ; $44f1
TrainingGymNpc0ATextIds:
	; $44f2, 20 bytes (text_ids)
	table_width 2
	dw Text_GymRunnerTennisIsRunning ; record 0
	dw Text_GymRunnerTennisIsRunning ; record 1
	dw Text_GymRunnerCoolDownRun ; record 2
	dw Text_GymRunnerCoolDownRun ; record 3
	dw Text_GymRunnerYouMadeVarsity ; record 4
	dw Text_GymRunnerYouTwoMadeVarsity ; record 5
	dw Text_GymRunnerWatchCostelloTwins ; record 6
	dw Text_GymRunnerWatchCostelloTwins ; record 7
	dw Text_GymRunnerYouBecameChampion ; record 8
	dw Text_GymRunnerYouTwoBecameChamps ; record 9
	assert_table_length NUM_STORYRANKS
TrainingGymNpc0B_0e:
	ld a, [wMapSceneStage] ; $4506
	add a ; $4509
	ld_hl_indexed TrainingGymNpc0BTextIds ; $450a
	ld a, [hl+] ; $4511
	ld h, [hl] ; $4512
	ld l, a ; $4513
	farcall InitDialogueTextCursor ; $4514
	script_speak ACTOR_TRAINING_GYM_STUDENT_HEADBAND_BOY ; $4517
	ret ; $451c
TrainingGymNpc0BTextIds:
	; $451d, 20 bytes (text_ids)
	table_width 2
	dw Text_GymHeadbandBoyLazyPutOnFat ; record 0
	dw Text_GymHeadbandBoyLazyPutOnFat ; record 1
	dw Text_GymHeadbandBoyOutOfShape ; record 2
	dw Text_GymHeadbandBoyOutOfShape ; record 3
	dw Text_GymHeadbandBoyMadeVarsityToo ; record 4
	dw Text_GymHeadbandBoyMadeVarsityToo ; record 5
	dw Text_GymHeadbandBoyAllEntrantsGood ; record 6
	dw Text_GymHeadbandBoyTwinsDoubles ; record 7
	dw Text_GymHeadbandBoyCoachMeSingles ; record 8
	dw Text_GymHeadbandBoyCoachMeDoubles ; record 9
	assert_table_length NUM_STORYRANKS
TrainingGymNpc0C_0e:
	ld a, [wMapSceneStage] ; $4531
	sra a ; $4534
	add a ; $4536
	ld_hl_indexed TrainingGymNpc0CTextIds ; $4537
	ld a, [hl+] ; $453e
	ld h, [hl] ; $453f
	ld l, a ; $4540
	farcall InitDialogueTextCursor ; $4541
	script_speak ACTOR_TRAINING_GYM_STUDENT_BLACK_HAIR_BOY_2 ; $4544
	ret ; $4549
TrainingGymNpc0CTextIds:
	; $454a, 10 bytes (text_ids)
	table_width 2
	dw Text_GymCoachHopefulRunsOffStress ; record 0
	dw Text_GymCoachHopefulMissedTeam ; record 1
	dw Text_GymCoachHopefulProCoachDream ; record 2
	dw Text_GymCoachHopefulHeadmasterReturns ; record 3
	dw Text_GymCoachHopefulBackToNormal ; record 4
	assert_table_length NUM_STORYTIERS
TrainingGymNpcScripts_0e:
	; $4554, 89 bytes (map_scripts)
	map_script ACTOR_TRAINING_GYM_WEIGHTLIFTER_A, FACEMASK_ANY, $0000, TrainingGymNpc03_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_GYM_WEIGHTLIFTER_B, FACEMASK_ANY, $0000, TrainingGymNpc04_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_GYM_SITUPS_A, FACEMASK_ANY, $0000, TrainingGymNpc05_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_GYM_SITUPS_B, FACEMASK_ANY, $0000, TrainingGymNpc06_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1, FACEMASK_ANY, $0000, TrainingGymNpc07_0e, $00, $00
	map_script ACTOR_TRAINING_GYM_JUMPING_JACKS_A, FACEMASK_ANY, $0000, TrainingGymNpc08_0e, $00, $00
	map_script ACTOR_TRAINING_GYM_JUMPING_JACKS_B_2, FACEMASK_ANY, $0000, TrainingGymNpc09_0e, $00, $00
	map_script ACTOR_TRAINING_GYM_STUDENT_BLACK_HAIR_BOY_1, FACEMASK_ANY, $0000, TrainingGymNpc0A_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TRAINING_GYM_STUDENT_HEADBAND_BOY, FACEMASK_ANY, $0000, TrainingGymNpc0B_0e, NPC_FREEZE, $00
	map_script ACTOR_TRAINING_GYM_STUDENT_BLACK_HAIR_BOY_2, FACEMASK_ANY, $0000, TrainingGymNpc0C_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TRAINING_GYM_STUDENT_SIDE_PART_BOY_1, FACEMASK_ANY, $0000, Text_GymBoySuggestsRepairCounter, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
TrainingGymFacingScripts_0e:
	; $45ad, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, TrainingGymFacing01_0e, $00, $00
	map_script $02, FACEMASK_ANY, $0000, TrainingGymFacing02_0e, $00, $00
	db $ff
TrainingGymFacing01_0e:
	ld a, ENTRY_TRAINING_CENTER_REPAIR_COUNTER_A ; $45be
	ld [wMapSceneStage2], a ; $45c0
	script_player_speed 2.0 ; $45c3
	script_move_player 13.0, 19.0 ; $45c9
	farcall WaitPlayerMoveDone ; $45d3
	call RunRepairCounterDialogue ; $45d6
	ret ; $45d9
TrainingGymFacing02_0e:
	ld a, ENTRY_TRAINING_CENTER_REPAIR_COUNTER_B ; $45da
	ld [wMapSceneStage2], a ; $45dc
	script_player_speed 2.0 ; $45df
	script_move_player 13.0, 19.0 ; $45e5
	farcall WaitPlayerMoveDone ; $45ef
	call RunRepairCounterDialogue ; $45f2
	ret ; $45f5
TrainingGymTileTriggers_0e:
	; $45f6, 17 bytes (map_scripts)
	map_script $02, FACEMASK_UP, $0000, TrainingGymTile02_0e, $00, $00
	map_script $03, FACEMASK_UP, $0000, TrainingGymTile03_0e, $00, $00
	db $ff
TrainingGymTile02_0e:
	ld a, EXIT_TRAINING_CENTER_TO_WALL_PRACTICE_ROOM ; $4607
	ld [wUnusedExitTriggerIdMirror], a ; $4609
	ld [wStoryModeExitTriggerRequest], a ; $460c
	ret ; $460f
TrainingGymTile03_0e:
	ld a, EXIT_TRAINING_CENTER_TO_TENNIS_MACHINE_ROOM ; $4610
	ld [wUnusedExitTriggerIdMirror], a ; $4612
	ld [wStoryModeExitTriggerRequest], a ; $4615
	ret ; $4618
TrainingGymInitScript_0e:
	call ComputeRankingProgressIndex_0e ; $4619
	script_get_actor_state ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1 ; $461c
	ld a, $03 ; $4621
	ld e, l ; $4623
	ld d, h ; $4624
	ld hl, ACTORF_ANIM_RATE ; $4625
	add hl, de ; $4628
	ld [hl], a ; $4629
	script_get_actor_state ACTOR_TRAINING_GYM_JUMPING_JACKS_A ; $462a
	ld a, $03 ; $462f
	ld e, l ; $4631
	ld d, h ; $4632
	ld hl, ACTORF_ANIM_RATE ; $4633
	add hl, de ; $4636
	ld [hl], a ; $4637
	script_get_actor_state ACTOR_TRAINING_GYM_JUMPING_JACKS_B_2 ; $4638
	ld a, $03 ; $463d
	ld e, l ; $463f
	ld d, h ; $4640
	ld hl, ACTORF_ANIM_RATE ; $4641
	add hl, de ; $4644
	ld [hl], a ; $4645
	script_set_anim ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1, ANIM_EXERCISE ; $4646
	script_set_anim ACTOR_TRAINING_GYM_JUMPING_JACKS_A, ANIM_EXERCISE ; $464d
	script_set_anim ACTOR_TRAINING_GYM_JUMPING_JACKS_B_2, ANIM_EXERCISE ; $4654
	call SetupGymActorsForProgress ; $465b
	ld a, [wStoryModeEntryPoint] ; $465e
	cp ENTRY_TRAINING_CENTER_REPAIR_COUNTER_A ; $4661
	jr nz, .checkCounterB ; $4663
	call RepairCounterReturnA ; $4665
	ret ; $4668
.checkCounterB:
	cp ENTRY_TRAINING_CENTER_REPAIR_COUNTER_B ; $4669
	jr nz, .checkCounterAChanged ; $466b
	call RepairCounterReturnB ; $466d
	ret ; $4670
.checkCounterAChanged:
	cp ENTRY_TRAINING_CENTER_REPAIR_COUNTER_A_CHANGED ; $4671
	jr nz, .checkCounterBChanged ; $4673
	call RepairCounterChangedReturnA ; $4675
	ret ; $4678
.checkCounterBChanged:
	cp ENTRY_TRAINING_CENTER_REPAIR_COUNTER_B_CHANGED ; $4679
	jr nz, .done ; $467b
	call RepairCounterChangedReturnB ; $467d
.done:
	ret ; $4680

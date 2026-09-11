SECTION "ROM Bank $14", ROMX[$4000], BANK[$14]

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
	map_actor $0000, ActorScript_14_2, $2b00, $3300, FACE_RIGHT, $3d, $01, $00
	map_actor $0000, ActorScript_14_2, $2b00, $3100, FACE_RIGHT, $3d, $01, $00
	map_actor $0000, ActorScript_14_2, $2d00, $2b00, FACE_LEFT, $3e, $01, $00
	map_actor_end
TennisMachineRoomEntryPoints_14:
	; $404a, 25 bytes (map_entries)
	map_entry $01, FACE_UP, $2b00, $3900, TennisMachineRoomArrival01_14
	map_entry $05, FACE_UP, $3800, $3600, $0000
	map_entry $07, FACE_UP, $3800, $3600, $0000
	db $ff
TennisMachineRoomArrival01_14:
	ld a, [wStoryModeEntryPoint] ; $4063
	cp STORYENTRY_NONE ; $4066
	jp z, .done ; $4068
	clear_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $406b
	test_flag FLAG_DOUBLES ; $406e
	jr z, .done ; $4071
	script_set_position ACTOR_PARTNER, $2b00, $3b00 ; $4073
	script_face ACTOR_PARTNER, FACE_UP ; $407e
.done:
	ret ; $4085
TennisMachineRoomExitTriggers_14:
	; $4086, 9 bytes (map_scripts:exit)
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_TRAINING_CENTER, $03
	db $ff
TennisMachineRoomNpc03_14:
	ld a, [wMapSceneStage] ; $408f
	add a ; $4092
	ld_hl_indexed TennisMachineRoomNpc03TextIds ; $4093
	ld a, [hl+] ; $409a
	ld h, [hl] ; $409b
	ld l, a ; $409c
	farcall InitDialogueTextCursor ; $409d
	script_speak $03 ; $40a0
	ret ; $40a5
TennisMachineRoomNpc03TextIds:
	; $40a6, 14 bytes (text_ids)
	dw Text_6e_167 ; record 0
	dw Text_6e_176 ; record 1
	dw Text_6e_185 ; record 2
	dw Text_6e_192 ; record 3
	dw Text_6e_199 ; record 4
	dw Text_6e_207 ; record 5
	dw Text_6e_214 ; record 6
TennisMachineRoomNpc04_14:
	ld a, [wMapSceneStage] ; $40b4
	add a ; $40b7
	ld_hl_indexed TennisMachineRoomNpc04TextIds ; $40b8
	ld a, [hl+] ; $40bf
	ld h, [hl] ; $40c0
	ld l, a ; $40c1
	farcall InitDialogueTextCursor ; $40c2
	ld a, [wMapSceneStage] ; $40c5
	cp MACHINECOURTSTAGE_LEVEL2 ; $40c8
	jr z, .eq01 ; $40ca
	jr .speak ; $40cc
.eq01:
	ld a, $04 ; $40ce
	farcall ScriptShowSpeakerDialogueRestoreBG ; $40d0
	farcall RunDialogueYesNoPrompt ; $40d3
	farcall ScriptCloseDialogueWindow ; $40d6
	script_wait_frames $05 ; $40d9
	and a ; $40e0
	jr z, .speak ; $40e1
	farcall AdvanceDialogueTextCursor ; $40e3
.speak:
	script_speak $04 ; $40e6
	ret ; $40eb
TennisMachineRoomNpc04TextIds:
	; $40ec, 14 bytes (text_ids)
	dw Text_6e_168 ; record 0
	dw Text_6e_177 ; record 1
	dw Text_6e_186 ; record 2
	dw Text_6e_193 ; record 3
	dw Text_6e_200 ; record 4
	dw Text_6e_208 ; record 5
	dw Text_6e_215 ; record 6
TennisMachineRoomNpcScripts_14:
	; $40fa, 25 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, TennisMachineRoomNpc03_14, $03, $00
	map_script $04, FACEMASK_ANY, $0000, TennisMachineRoomNpc04_14, $03, $00
	map_script $05, FACEMASK_ANY, $0000, TennisMachineRoomNpc05_14, $00, $00
	db $ff
MachineLevel1FailedPrompt:
	script_set_text Text_6e_219 ; $4113
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
	script_set_text Text_6e_175 ; $412e
	script_speak $05 ; $4134
	script_get_actor_state ACTOR_PARTNER ; $4139
	ld c, l ; $413e
	ld b, h ; $413f
	ld de, wActors ; $4140
	farcall AttachActorStepMover ; $4143
	ret ; $4146
MachineLevel2FailedPrompt:
	script_set_text Text_6e_219 ; $4147
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
	script_set_text Text_6e_183 ; $4163
	script_speak $05 ; $4169
	script_get_actor_state ACTOR_PARTNER ; $416e
	ld c, l ; $4173
	ld b, h ; $4174
	ld de, wActors ; $4175
	farcall AttachActorStepMover ; $4178
	ret ; $417b
MachineLevel3FailedPrompt:
	script_set_text Text_6e_219 ; $417c
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
	script_set_text Text_6e_190 ; $4198
	script_speak $05 ; $419e
	script_get_actor_state ACTOR_PARTNER ; $41a3
	ld c, l ; $41a8
	ld b, h ; $41a9
	ld de, wActors ; $41aa
	farcall AttachActorStepMover ; $41ad
	ret ; $41b0
MachineLevel4FailedPrompt:
	script_set_text Text_6e_219 ; $41b1
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
	script_set_text Text_6e_197 ; $41cd
	script_speak $05 ; $41d3
	script_get_actor_state ACTOR_PARTNER ; $41d8
	ld c, l ; $41dd
	ld b, h ; $41de
	ld de, wActors ; $41df
	farcall AttachActorStepMover ; $41e2
	ret ; $41e5
TennisMachineRoomFacingScripts_14:
	ds 1, $ff ; $41e6, fill
TennisMachineRoomTileTriggers_14:
	; $41e7, 41 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $9c20, TennisMachineRoomTile01_14, $00, $00
	map_script $03, FACEMASK_ANY, $0000, TennisMachineRoomTile03_14, $01, $00
	map_script $04, FACEMASK_ANY, $0000, TennisMachineRoomTile04_14, $01, $00
	map_script $05, FACEMASK_ANY, $0000, TennisMachineRoomTile05_14, $01, $00
	map_script $06, FACEMASK_ANY, $0000, TennisMachineRoomTile06_14, $01, $00
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
	script_move_target ACTOR_PLAYER, $2ac0, $2b00 ; $422d
	script_wait_move ACTOR_PLAYER ; $4238
	script_move_target $05, $2d00, $2b00 ; $423d
	script_wait_move $05 ; $4248
	script_wait_frames $05 ; $424d
	script_face $05, FACE_LEFT ; $4254
	script_face ACTOR_PLAYER, FACE_RIGHT ; $425b
	script_get_actor_state ACTOR_PARTNER ; $4262
	ld c, l ; $4267
	ld b, h ; $4268
	ld de, wActors ; $4269
	farcall AttachActorStepMover ; $426c
	ret ; $426f
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
	ld a, $00 ; $428f
	farcall CopyScrolledSceneTilemapToVram ; $4291
	call EnableLCD ; $4294
	call ComputeMachineCourtProgress ; $4297
	farcall WaitPlayerMoveDone ; $429a
	ld a, [wStoryModeEntryPoint] ; $429d
	cp $05 ; $42a0
	jp z, MachineCourtResultScene ; $42a2
	cp $07 ; $42a5
	jp z, MachinePracticeResultScene ; $42a7
	cp STORYENTRY_NONE ; $42aa
	jp z, MachineCourtWalkToAttendantCutscene.practiceRoom ; $42ac
	ret ; $42af
MachineCourtResultScene:
	test_flag FLAG_DOUBLES ; $42b0
	jr z, .win ; $42b3
	script_null_script ACTOR_PARTNER ; $42b5
	script_wait_frames $0a ; $42ba
	script_set_position ACTOR_PARTNER, $2900, $2b00 ; $42c1
	script_face ACTOR_PARTNER, FACE_RIGHT ; $42cc
.win:
	script_set_position $05, $2d00, $2900 ; $42d3
	script_face $05, FACE_DOWN ; $42de
	script_fade_in $06 ; $42e5
	call WaitFadeEnd ; $42ea
	script_wait_frames $28 ; $42ed
	script_set_speed ACTOR_PLAYER, $0020 ; $42f4
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
	jr z, .done ; $4311
	ld a, [wMapSceneStage] ; $4313
	ld a, a ; $4316
	rst Rst00 ; $4317
	dw MachineLevel1FailedPrompt ; $4318 jumptable
	dw MachineLevel2FailedPrompt ; $431a jumptable
	dw MachineLevel3FailedPrompt ; $431c jumptable
	dw MachineLevel4FailedPrompt ; $431e jumptable
	dw MachineExpertResultScene ; $4320 jumptable
	dw MachineExpertResultScene ; $4322 jumptable
	dw MachineExpertResultScene ; $4324 jumptable
.done:
	ld a, [wMapSceneStage] ; $4326
	dec a ; $4329
	ld a, a ; $432a
	rst Rst00 ; $432b
	dw MachineLevel1ClearedScene ; $432c jumptable
	dw MachineLevel2ClearedScene ; $432e jumptable
	dw MachineLevel3ClearedScene ; $4330 jumptable
	dw MachineLevel4ClearedScene ; $4332 jumptable
	dw MachineExpertResultScene ; $4334 jumptable
	dw MachineExpertResultScene ; $4336 jumptable
	dw MachineExpertResultScene ; $4338 jumptable
MachineCourtGameOverExitScene:
	script_set_text Text_6e_220 ; $433a
	script_speak $05 ; $4340
	script_move_target ACTOR_PLAYER, $3300, $3600 ; $4345
	script_wait_move ACTOR_PLAYER ; $4350
	script_move_player $2f00, $2d00 ; $4355
	script_move_target ACTOR_PLAYER, $3300, $2b00 ; $435f
	script_wait_move ACTOR_PLAYER ; $436a
	script_move_target ACTOR_PLAYER, $2b00, $2b00 ; $436f
	script_wait_move ACTOR_PLAYER ; $437a
	script_move_target $05, $2d00, $2b00 ; $437f
	script_wait_move $05 ; $438a
	script_face $05, FACE_LEFT ; $438f
	script_get_actor_state ACTOR_PARTNER ; $4396
	ld c, l ; $439b
	ld b, h ; $439c
	ld de, wActors ; $439d
	farcall AttachActorStepMover ; $43a0
	ret ; $43a3
ComputeMachineCourtProgress:
	ld a, MACHINECOURTSTAGE_LEVEL1 ; $43a4
	test_flag FLAG_CLEARED_MACHINE_LEVEL_1 ; $43a6
	jp z, .machineCourtStartLevelScene ; $43a9
	script_copy_scene_rect $1e, $2c, $30, $2c, $02, $02 ; $43ac
	ld a, MACHINECOURTSTAGE_LEVEL2 ; $43bb
	test_flag FLAG_CLEARED_MACHINE_LEVEL_2 ; $43bd
	jp z, .machineCourtStartLevelScene ; $43c0
	script_copy_scene_rect $1e, $30, $30, $30, $02, $02 ; $43c3
	ld a, MACHINECOURTSTAGE_LEVEL3 ; $43d2
	test_flag FLAG_CLEARED_MACHINE_LEVEL_3 ; $43d4
	jr z, .machineCourtStartLevelScene ; $43d7
	script_copy_scene_rect $1e, $34, $30, $34, $02, $02 ; $43d9
	ld a, MACHINECOURTSTAGE_LEVEL4 ; $43e8
	test_flag FLAG_CLEARED_MACHINE_LEVEL_4 ; $43ea
	jr z, .machineCourtStartLevelScene ; $43ed
	script_copy_scene_rect $1e, $38, $30, $38, $02, $02 ; $43ef
	ld a, MACHINECOURTSTAGE_MASTER ; $43fe
	ld b, a ; $4400
	ld a, $01 ; $4401
	farcall ReadMinigameRecord ; $4403
	push_wram_bank $07 ; $4406
	ld hl, wMinigameRecordValue ; $440f
	ld a, [hl+] ; $4412
	ld h, [hl] ; $4413
	ld l, a ; $4414
	pop_wram_bank ; $4415
	ld a, b ; $441a
	test_flag FLAG_CLEARED_MACHINE_MASTER ; $441b
	jr z, .machineCourtStartLevelScene ; $441e
	ld a, MACHINECOURTSTAGE_EXPERT ; $4420
	test_flag FLAG_CLEARED_MACHINE_EXPERT ; $4422
	jr z, .machineCourtStartLevelScene ; $4425
	ld a, MACHINECOURTSTAGE_COMPLETE ; $4427
.machineCourtStartLevelScene:
	ld [wMapSceneStage], a ; $4429
	ret ; $442c
TennisMachineRoomNpc05_14:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $442d
	jp nz, MachineCourtStartLevelScene ; $4430
	ld a, [wMapSceneStage] ; $4433
	add a ; $4436
	ld_hl_indexed TennisMachineRoomNpc05TextIds ; $4437
	ld a, [hl+] ; $443e
	ld h, [hl] ; $443f
	ld l, a ; $4440
	farcall InitDialogueTextCursor ; $4441
	ld a, [wMapSceneStage] ; $4444
	cp MACHINECOURTSTAGE_EXPERT ; $4447
	jr c, .prompt ; $4449
	push_wram_bank $07 ; $444b
	ld a, $01 ; $4454
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
	ld a, $05 ; $4475
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4477
	farcall RunDialogueYesNoPrompt ; $447a
	farcall ScriptCloseDialogueWindow ; $447d
	script_wait_frames $05 ; $4480
	and a ; $4487
	jr nz, .accepted ; $4488
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $448a
	farcall AdvanceDialogueTextCursor ; $448d
	ld a, [wMapSceneStage] ; $4490
	and a ; $4493
	jr nz, .declined ; $4494
	script_speak $05 ; $4496
.declined:
	script_set_anim $05, $03 ; $449b
	script_wait_idle $05 ; $44a2
	jr nz, MachineCourtStartLevelScene ; $44a7
.accepted:
	test_flag FLAG_CLEARED_MACHINE_LEVEL_1 ; $44a9
	jr z, .done ; $44ac
	script_set_text Text_6e_222 ; $44ae
	ld a, $05 ; $44b4
	farcall ScriptShowSpeakerDialogueRestoreBG ; $44b6
	farcall RunDialogueYesNoPrompt ; $44b9
	farcall ScriptCloseDialogueWindow ; $44bc
	script_wait_frames $05 ; $44bf
	and a ; $44c6
	jp z, MachineCourtStartLevelScene.speak ; $44c7
.done:
	ld a, [wMapSceneStage] ; $44ca
	add a ; $44cd
	ld_hl_indexed TennisMachineRoomNpc05TextIds ; $44ce
	ld a, [hl+] ; $44d5
	ld h, [hl] ; $44d6
	ld l, a ; $44d7
	farcall InitDialogueTextCursor ; $44d8
	farcall AdvanceDialogueTextCursor ; $44db
	script_speak $05 ; $44de
	ret ; $44e3
MachineCourtStartLevelScene:
	script_speak $05 ; $44e4
	script_move_target $05, $2d00, $2900 ; $44e9
	script_wait_move $05 ; $44f4
	script_face $05, FACE_DOWN ; $44f9
	test_flag FLAG_DOUBLES ; $4500
	jr z, .walkOff ; $4503
	script_null_script ACTOR_PARTNER ; $4505
	script_set_actor_script ACTOR_PARTNER, ActorScript_14_0 ; $450a
.walkOff:
	script_set_speed ACTOR_PLAYER, $0020 ; $4515
	script_move_player $3800, $3300 ; $451d
	script_move_target ACTOR_PLAYER, $3300, $2b00 ; $4527
	script_wait_move ACTOR_PLAYER ; $4532
	script_move_target ACTOR_PLAYER, $3300, $3300 ; $4537
	script_wait_move ACTOR_PLAYER ; $4542
	script_move_target ACTOR_PLAYER, $3800, $3500 ; $4547
	script_wait_move ACTOR_PLAYER ; $4552
	script_face ACTOR_PLAYER, FACE_UP ; $4557
	script_wait_frames $0a ; $455e
	ld a, [wMapSceneStage] ; $4565
	cp MACHINECOURTSTAGE_MASTER ; $4568
	jr c, .lt04 ; $456a
	script_set_text Text_6e_204 ; $456c
	script_speak $05 ; $4572
.lt04:
	ld c, $06 ; $4577
	call BeginFadeOut ; $4579
	call WaitFadeEnd ; $457c
	clear_flag FLAG_TEMP_SCENE_VARIANT_A ; $457f
	ld a, STORYLOC_TENNIS_MACHINE_ROOM ; $4582
	ld [wStoryModeCurrentLocation], a ; $4584
	ld a, $05 ; $4587
	ld [wStoryModeEntryPoint], a ; $4589
	ld a, $ff ; $458c
	ld [wUnusedExitTriggerIdMirror], a ; $458e
	ld [wStoryModeExitTriggerRequest], a ; $4591
	ld a, [wMapSceneStage] ; $4594
	ld_hl_indexed MachineCourtStartLevelSceneTable ; $4597
	ld a, [hl] ; $459e
	farcall RunTrainingDrillByID ; $459f
	farcall EndCutsceneScriptMode ; $45a2
	ret ; $45a5
.speak:
	script_speak $05 ; $45a6
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $45ab
	script_move_target $05, $2d00, $2900 ; $45ae
	script_wait_move $05 ; $45b9
	script_face $05, FACE_DOWN ; $45be
	script_null_script ACTOR_PARTNER ; $45c5
	script_set_speed ACTOR_PLAYER, $0020 ; $45ca
	script_set_actor_script ACTOR_PARTNER, ActorScript_14_0 ; $45d2
	script_move_target ACTOR_PLAYER, $3100, $2b00 ; $45dd
	script_wait_move ACTOR_PLAYER ; $45e8
	script_face ACTOR_PLAYER, FACE_DOWN ; $45ed
	set_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $45f4
	ret ; $45f7
MachineCourtStartLevelSceneTable:
	; $45f8, 8 bytes (bytes:16)
	db $12, $13, $14, $15, $1a, $1a, $1a, $c9 ; 0x00
TennisMachineRoomNpc05TextIds:
	; $4600, 18 bytes (text_ids)
	dw Text_6e_169 ; record 0
	dw Text_6e_180 ; record 1
	dw Text_6e_187 ; record 2
	dw Text_6e_194 ; record 3
	dw Text_6e_201 ; record 4
	dw Text_6e_209 ; record 5
	dw Text_6e_216 ; record 6
	dw Text_6e_209 ; record 7
	dw Text_6e_216 ; record 8
MachinePracticeLevelPrompt:
	ld [wMapScratch + 6], a ; $4612
	call TestMachineLevelClearedFlag ; $4615
	jr z, MachineLevelNotClearedMessage ; $4618
	script_set_text Text_6e_224 ; $461a
	ld a, [wMapScratch + 6] ; $4620
	inc a ; $4623
	ld h, $00 ; $4624
	ld l, a ; $4626
	farcall PushTextArgNumber ; $4627
	ld a, $05 ; $462a
	farcall ScriptShowSpeakerDialogueRestoreBG ; $462c
	farcall RunDialogueYesNoPrompt ; $462f
	farcall ScriptCloseDialogueWindow ; $4632
	script_wait_frames $05 ; $4635
	and a ; $463c
	jr nz, .done ; $463d
	script_face $05, FACE_UP ; $463f
	script_set_speed ACTOR_PLAYER, $0020 ; $4646
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0200 ; $464e
	script_wait_move ACTOR_PLAYER ; $4658
	script_move_target ACTOR_PLAYER, $3500, $3500 ; $465d
	script_wait_move ACTOR_PLAYER ; $4668
	ld c, $08 ; $466d
	call BeginFadeOut ; $466f
	call WaitFadeEnd ; $4672
	ld a, STORYLOC_TENNIS_MACHINE_ROOM ; $4675
	ld [wStoryModeCurrentLocation], a ; $4677
	ld a, $07 ; $467a
	ld [wStoryModeEntryPoint], a ; $467c
	ld a, $ff ; $467f
	ld [wUnusedExitTriggerIdMirror], a ; $4681
	ld [wStoryModeExitTriggerRequest], a ; $4684
	ld a, [wMapScratch + 6] ; $4687
	add MINIGAME_TENNIS_MACHINE_1 ; $468a
	farcall RunTrainingDrillByID ; $468c
	farcall EndCutsceneScriptMode ; $468f
.done:
	ret ; $4692
MachineLevelNotClearedMessage:
	script_set_text Text_6e_225 ; $4693
	script_speak $05 ; $4699
	ret ; $469e
TestMachineLevelClearedFlag:
	add a ; $469f
	ld_hl_indexed TestMachineLevelClearedFlagTable ; $46a0
	ld a, [hl+] ; $46a7
	ld d, [hl] ; $46a8
	ld e, a ; $46a9
	call TestGameFlagByNumber ; $46aa
	ret ; $46ad
; TestMachineLevelClearedFlag with SetGameFlagByNumber in place of TestGameFlagByNumber over the same TestMachineLevelClearedFlagTable: the Set member of the pair. Nothing calls it; the level-cleared flags are set by the machine-room scene scripts directly.
Unused_14_SetMachineLevelClearedFlag:
	add a ; $46ae
	ld_hl_indexed TestMachineLevelClearedFlagTable ; $46af
	ld a, [hl+] ; $46b6
	ld d, [hl] ; $46b7
	ld e, a ; $46b8
	call SetGameFlagByNumber ; $46b9
	ret ; $46bc
TestMachineLevelClearedFlagTable:
	; $46bd, 8 bytes (records:2)
	dw $00d2 ; record 0
	dw $00d3 ; record 1
	dw $00d4 ; record 2
	dw $00d5 ; record 3
MachinePracticeResultScene:
	xor a ; $46c5
	ld [wStoryModeShowLocationName], a ; $46c6
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $46c9
	test_flag FLAG_DOUBLES ; $46cc
	jr z, .placeActors ; $46cf
	script_null_script ACTOR_PARTNER ; $46d1
	script_set_position ACTOR_PARTNER, $2900, $2b00 ; $46d6
	script_face ACTOR_PARTNER, FACE_RIGHT ; $46e1
	script_wait_frames $0a ; $46e8
.placeActors:
	script_set_position $05, $2d00, $2900 ; $46ef
	script_face $05, FACE_DOWN ; $46fa
	script_fade_in $06 ; $4701
	call WaitFadeEnd ; $4706
	script_wait_frames $28 ; $4709
	ld a, [wMatchExitRequest] ; $4710
	and a ; $4713
	jp nz, .done ; $4714
	script_set_text Text_6e_219 ; $4717
	ld hl, wMinigamesTargetScore ; $471d
	ld a, [hl+] ; $4720
	ld h, [hl] ; $4721
	ld l, a ; $4722
	farcall PushTextArgNumber ; $4723
	ld hl, wMinigamesCurrentScore ; $4726
	ld a, [hl+] ; $4729
	ld h, [hl] ; $472a
	ld l, a ; $472b
	farcall PushTextArgNumber ; $472c
	script_set_speed ACTOR_PLAYER, $0020 ; $472f
	ld a, $05 ; $4737
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4739
	farcall RunDialogueYesNoPrompt ; $473c
	farcall ScriptCloseDialogueWindow ; $473f
	script_wait_frames $05 ; $4742
	and a ; $4749
	jp z, MachineCourtRestartLevel ; $474a
.done:
	ret ; $474d
MachineCourtHandleRetryChoice:
	ld a, $05 ; $474e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4750
	farcall RunDialogueYesNoPrompt ; $4753
	farcall ScriptCloseDialogueWindow ; $4756
	script_wait_frames $05 ; $4759
	and a ; $4760
	jr z, MachineCourtRestartLevel ; $4761
	script_set_text Text_6e_220 ; $4763
	script_speak $05 ; $4769
	script_move_target ACTOR_PLAYER, $3300, $3600 ; $476e
	script_wait_move ACTOR_PLAYER ; $4779
	script_move_player $2f00, $2d00 ; $477e
	script_move_target ACTOR_PLAYER, $3300, $2b00 ; $4788
	script_wait_move ACTOR_PLAYER ; $4793
	script_move_target ACTOR_PLAYER, $2b00, $2b00 ; $4798
	script_wait_move ACTOR_PLAYER ; $47a3
	script_move_target $05, $2d00, $2b00 ; $47a8
	script_wait_move $05 ; $47b3
	script_face $05, FACE_LEFT ; $47b8
	script_get_actor_state ACTOR_PARTNER ; $47bf
	ld c, l ; $47c4
	ld b, h ; $47c5
	ld de, wActors ; $47c6
	farcall AttachActorStepMover ; $47c9
	ret ; $47cc
MachineCourtRestartLevel:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $47cd
	cp MINIGAME_TENNIS_MACHINE_HIGH_SCORE ; $47d0
	jr z, .storeStoryModeCurrentLocation ; $47d2
	sub MINIGAME_TENNIS_MACHINE_1 ; $47d4
	call TestMachineLevelClearedFlag ; $47d6
	jr z, .storeStoryModeCurrentLocation ; $47d9
	ld a, STORYLOC_TENNIS_MACHINE_ROOM ; $47db
	ld [wStoryModeCurrentLocation], a ; $47dd
	ld a, $07 ; $47e0
	ld [wStoryModeEntryPoint], a ; $47e2
	ld a, $ff ; $47e5
	ld [wUnusedExitTriggerIdMirror], a ; $47e7
	ld [wStoryModeExitTriggerRequest], a ; $47ea
	jr .runTrainingDrillByID ; $47ed
.storeStoryModeCurrentLocation:
	ld a, STORYLOC_TENNIS_MACHINE_ROOM ; $47ef
	ld [wStoryModeCurrentLocation], a ; $47f1
	ld a, $05 ; $47f4
	ld [wStoryModeEntryPoint], a ; $47f6
	ld a, $ff ; $47f9
	ld [wUnusedExitTriggerIdMirror], a ; $47fb
	ld [wStoryModeExitTriggerRequest], a ; $47fe
.runTrainingDrillByID:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4801
	farcall RunTrainingDrillByID ; $4804
	ret ; $4807
ActorScript_14_0:
	; $4808, 11 bytes (actor_script)
	as_set_target $2900, $2b00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
; Reads tennis-machine record $01 and then throws the result away, storing the constant $0050 into wMinigameRecordValue instead, before sending the player back to the machine room at entry point $01. Nothing calls it (no textual or ROM-wide pointer reference), and it never calls UpdateMinigameRecord, so even if it ran the 80 would not persist -- it reads as an abandoned debug helper. The name states what the body does, not what it was for
UnusedMachineRecordOverrideAndReturn_14:
	push_wram_bank $07 ; $4813
	ld a, $01 ; $481c
	farcall ReadMinigameRecord ; $481e
	ld de, $0050 ; $4821
	ld hl, wMinigameRecordValue ; $4824
	ld a, e ; $4827
	ld [hl+], a ; $4828
	ld [hl], d ; $4829
	pop_wram_bank ; $482a
	ld a, STORYLOC_TENNIS_MACHINE_ROOM ; $482f
	ld [wStoryModeCurrentLocation], a ; $4831
	ld a, $01 ; $4834
	ld [wStoryModeEntryPoint], a ; $4836
	ld a, $ff ; $4839
	ld [wUnusedExitTriggerIdMirror], a ; $483b
	ld [wStoryModeExitTriggerRequest], a ; $483e
	ret ; $4841
MachineExpertResultScene:
	test_flag FLAG_CLEARED_MACHINE_EXPERT ; $4842
	jr z, .notClearedMachineExpert ; $4845
	ld a, [wPointWinLoseFlag] ; $4847
	cp WINLOSE_WIN ; $484a
	jp z, MachineExpertCounterMaxScene ; $484c
.notClearedMachineExpert:
	ld bc, $0001 ; $484f
	push_wram_bank $07 ; $4852
	ld hl, wMinigamesCurrentScore ; $485b
	ld a, [hl+] ; $485e
	ld d, [hl] ; $485f
	ld e, a ; $4860
	pop_wram_bank ; $4861
	ld l, c ; $4866
	ld h, b ; $4867
	ld a, l ; $4868
	sub e ; $4869
	ld l, a ; $486a
	ld a, h ; $486b
	sbc d ; $486c
	ld h, a ; $486d
	jp nc, MachineExpertRetryPrompt ; $486e
	ld bc, $270f ; $4871
	push_wram_bank $07 ; $4874
	ld a, $01 ; $487d
	farcall ReadMinigameRecord ; $487f
	ld hl, wMinigameRecordValue ; $4882
	ld a, [hl+] ; $4885
	ld d, [hl] ; $4886
	ld e, a ; $4887
	pop_wram_bank ; $4888
	ld l, c ; $488d
	ld h, b ; $488e
	ld a, l ; $488f
	sub e ; $4890
	ld l, a ; $4891
	ld a, h ; $4892
	sbc d ; $4893
	ld h, a ; $4894
	jp z, MachineExpertRetryPrompt ; $4895
	ld hl, wMinigamesCurrentScore ; $4898
	ld a, [hl+] ; $489b
	ld b, [hl] ; $489c
	ld c, a ; $489d
	push_wram_bank $07 ; $489e
	ld hl, wMinigameRecordValue ; $48a7
	ld a, [hl+] ; $48aa
	ld d, [hl] ; $48ab
	ld e, a ; $48ac
	pop_wram_bank ; $48ad
	ld l, c ; $48b2
	ld h, b ; $48b3
	inc de ; $48b4
	ld a, l ; $48b5
	sub e ; $48b6
	ld l, a ; $48b7
	ld a, h ; $48b8
	sbc d ; $48b9
	ld h, a ; $48ba
	jp nc, MachineExpertNewRecordScene ; $48bb
MachineExpertRetryPrompt:
	script_set_text Text_6e_221 ; $48be
	ld hl, wMinigamesCurrentScore ; $48c4
	ld a, [hl+] ; $48c7
	ld h, [hl] ; $48c8
	ld l, a ; $48c9
	farcall PushTextArgNumber ; $48ca
	jp MachineCourtHandleRetryChoice ; $48cd
	ret ; $48d0
MachineExpertNewRecordScene:
	call SaveMachineExpertRecord ; $48d1
	script_set_text Text_6e_206 ; $48d4
	ld hl, wMinigamesCurrentScore ; $48da
	ld a, [hl+] ; $48dd
	ld h, [hl] ; $48de
	ld l, a ; $48df
	farcall PushTextArgNumber ; $48e0
	call MachineCourtWalkToAttendantCutscene ; $48e3
	script_speak $05 ; $48e6
	script_get_actor_state ACTOR_PARTNER ; $48eb
	ld c, l ; $48f0
	ld b, h ; $48f1
	ld de, wActors ; $48f2
	farcall AttachActorStepMover ; $48f5
	ret ; $48f8
MachineExpertCounterMaxScene:
	push_wram_bank $07 ; $48f9
	ld a, $01 ; $4902
	farcall ReadMinigameRecord ; $4904
	ld hl, wMinigameRecordValue ; $4907
	ld a, [hl+] ; $490a
	ld h, [hl] ; $490b
	ld l, a ; $490c
	pop_wram_bank ; $490d
	ld de, $270f ; $4912
	ld a, l ; $4915
	sub e ; $4916
	ld l, a ; $4917
	ld a, h ; $4918
	sbc d ; $4919
	ld h, a ; $491a
	jp z, MachineExpertRetryPrompt ; $491b
	call SaveMachineExpertRecord ; $491e
	script_set_text Text_6e_212 ; $4921
	ld hl, wMinigamesCurrentScore ; $4927
	ld a, [hl+] ; $492a
	ld h, [hl] ; $492b
	ld l, a ; $492c
	farcall PushTextArgNumber ; $492d
	script_set_text Text_6e_212 ; $4930
	call MachineCourtWalkToAttendantCutscene ; $4936
	script_speak $05 ; $4939
	script_speak $05 ; $493e
	script_get_actor_state ACTOR_PARTNER ; $4943
	ld c, l ; $4948
	ld b, h ; $4949
	ld de, wActors ; $494a
	farcall AttachActorStepMover ; $494d
	ret ; $4950
Unused_14_CompareMinigameScoreToRecord:
	ld hl, wMinigamesCurrentScore ; $4951
	ld a, [hl+] ; $4954
	ld b, [hl] ; $4955
	ld c, a ; $4956
	push_wram_bank $07 ; $4957
	ld hl, wMinigameRecordValue ; $4960
	ld a, [hl+] ; $4963
	ld d, [hl] ; $4964
	ld e, a ; $4965
	pop_wram_bank ; $4966
	ld l, c ; $496b
	ld h, b ; $496c
	ld a, l ; $496d
	sub e ; $496e
	ld l, a ; $496f
	ld a, h ; $4970
	sbc d ; $4971
	ld h, a ; $4972
	ret ; $4973
SaveMachineExpertRecord:
	push_wram_bank $07 ; $4974
	ld hl, wMinigamesCurrentScore ; $497d
	ld a, [hl+] ; $4980
	ld d, [hl] ; $4981
	ld e, a ; $4982
	ld hl, wMinigameRecordValue ; $4983
	ld a, e ; $4986
	ld [hl+], a ; $4987
	ld [hl], d ; $4988
	ld a, $01 ; $4989
	farcall UpdateMinigameRecord ; $498b
	pop_wram_bank ; $498e
	call ComputeMachineCourtProgress ; $4993
	ret ; $4996
MachineCourtWalkToAttendantCutscene:
	script_move_target ACTOR_PLAYER, $3300, $3600 ; $4997
	script_wait_move ACTOR_PLAYER ; $49a2
	script_move_player $2f00, $2d00 ; $49a7
	script_move_target ACTOR_PLAYER, $3300, $2b00 ; $49b1
	script_wait_move ACTOR_PLAYER ; $49bc
	script_move_target ACTOR_PLAYER, $2a80, $2b00 ; $49c1
	script_wait_move ACTOR_PLAYER ; $49cc
	script_move_target $05, $2d00, $2b00 ; $49d1
	script_wait_move $05 ; $49dc
	script_face ACTOR_PLAYER, FACE_RIGHT ; $49e1
	script_move_target ACTOR_PLAYER, $2b00, $2b00 ; $49e8
	script_wait_move ACTOR_PLAYER ; $49f3
	script_face $05, FACE_LEFT ; $49f8
	ret ; $49ff
.practiceRoom:
	test_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $4a00
	jr z, .done ; $4a03
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $4a05
	script_set_position $05, $2d00, $2900 ; $4a08
	script_face $05, FACE_DOWN ; $4a13
	script_null_script ACTOR_PARTNER ; $4a1a
	script_wait_frames $01 ; $4a1f
	script_set_position ACTOR_PARTNER, $2900, $2b00 ; $4a26
	script_face ACTOR_PARTNER, FACE_RIGHT ; $4a31
.done:
	ret ; $4a38
Court2MapScripts_14:
	; $4a39, 14 bytes (map_tree)
	dw Court2EntryPoints_14 ; slot 0 EntryPoints
	dw Court2ExitTriggers_14 ; slot 1 ExitTriggers
	dw Court2Actors_14 ; slot 2 Actors
	dw Court2NpcScripts_14 ; slot 3 NpcScripts
	dw Court2FacingScripts_14 ; slot 4 FacingScripts
	dw Court2TileTriggers_14 ; slot 5 TileTriggers
	dw Court2InitScript_14 ; slot 6 InitScript
Court2Actors_14:
	; $4a47, 248 bytes (map_actors)
	map_actor $0000, ActorScript_14_2, $1d00, $1500, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_14_2, $1900, $1800, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_14_2, $1b00, $1c00, FACE_LEFT, $30, $01, $05
	map_actor $0000, ActorScript_14_2, $1b00, $1a00, FACE_LEFT, $39, $01, $05
	map_actor $0000, ActorScript_14_3, $0700, $3100, FACE_RIGHT, $39, $01, $04
	map_actor $0000, ActorScript_14_2, $0900, $2300, FACE_RIGHT, $39, $01, $04
	map_actor $0000, ActorScript_14_2, $0b00, $2300, FACE_LEFT, $3a, $01, $00
	map_actor $0000, ActorScript_14_2, $0b00, $2b00, FACE_RIGHT, $23, $01, $00
	map_actor $0000, ActorScript_14_2, $0f00, $2b00, FACE_LEFT, $24, $01, $00
	map_actor $0000, ActorScript_14_2, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_14_2, $fd00, $0100, FACE_DOWN, $53, $01, $00
	map_actor $0000, ActorScript_14_2, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_14_2, $1b00, $0c00, FACE_LEFT, $39, $01, $00
	map_actor $0000, ActorScript_14_2, $1900, $0e00, FACE_LEFT, $39, $01, $06
	map_actor $0000, ActorScript_14_2, $1b00, $1000, FACE_LEFT, $3a, $01, $03
	map_actor $0000, ActorScript_14_2, $0500, $1b00, FACE_RIGHT, $33, $01, $00
	map_actor $0000, ActorScript_14_2, $0500, $1d00, FACE_RIGHT, $3a, $01, $04
	map_actor_end
Court2EntryPoints_14:
	; $4b3f, 17 bytes (map_entries)
	map_entry $01, FACE_LEFT, $2500, $1500, $0000
	map_entry $02, FACE_LEFT, $2500, $2500, $0000
	db $ff
Court2ExitTriggers_14:
	; $4b50, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_TOURNAMENT, $03
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_TOURNAMENT_COURTYARD, $02
	db $ff
Court2Npc03_14:
	script_set_text Text_1f_145 ; $4b61
	script_speak $03 ; $4b67
	ret ; $4b6c
Court2Npc04_14:
	ld a, [wMapSceneStage] ; $4b6d
	add a ; $4b70
	ld_hl_indexed Court2Npc04TextIds ; $4b71
	ld a, [hl+] ; $4b78
	ld h, [hl] ; $4b79
	ld l, a ; $4b7a
	farcall InitDialogueTextCursor ; $4b7b
	script_speak $04 ; $4b7e
	ret ; $4b83
Court2Npc04TextIds:
	; $4b84, 14 bytes (text_ids)
	dw Text_1f_146 ; record 0
	dw Text_1f_146 ; record 1
	dw Text_1f_146 ; record 2
	dw Text_1f_151 ; record 3
	dw Text_1f_146 ; record 4
	dw Text_1f_146 ; record 5
	dw Text_1f_151 ; record 6
Court2Npc05_14:
	ld a, [wMapSceneStage] ; $4b92
	add a ; $4b95
	ld_hl_indexed Court2Npc05TextIds ; $4b96
	ld a, [hl+] ; $4b9d
	ld h, [hl] ; $4b9e
	ld l, a ; $4b9f
	farcall InitDialogueTextCursor ; $4ba0
	script_speak $05 ; $4ba3
	ret ; $4ba8
Court2Npc05TextIds:
	; $4ba9, 14 bytes (text_ids)
	dw Text_1f_147 ; record 0
	dw Text_1f_147 ; record 1
	dw Text_1f_149 ; record 2
	dw Text_1f_152 ; record 3
	dw Text_1f_153 ; record 4
	dw Text_1f_155 ; record 5
	dw Text_1f_157 ; record 6
Court2Npc06_14:
	ld a, [wMapSceneStage] ; $4bb7
	add a ; $4bba
	ld_hl_indexed Court2Npc06TextIds ; $4bbb
	ld a, [hl+] ; $4bc2
	ld h, [hl] ; $4bc3
	ld l, a ; $4bc4
	farcall InitDialogueTextCursor ; $4bc5
	script_speak $06 ; $4bc8
	ret ; $4bcd
Court2Npc06TextIds:
	; $4bce, 14 bytes (text_ids)
	dw Text_1f_148 ; record 0
	dw Text_1f_148 ; record 1
	dw Text_1f_150 ; record 2
	dw Text_1f_150 ; record 3
	dw Text_1f_154 ; record 4
	dw Text_1f_156 ; record 5
	dw Text_1f_158 ; record 6
Court2SpectatorChat_14:
	test_flag FLAG_DOUBLES ; $4bdc
	jr z, .checkFlag ; $4bdf
	test_flag FLAG_COURT2_SPECTATORS_TALKED_DOUBLES ; $4be1
	jp nz, Court2SpectatorsRepeatChat ; $4be4
	set_flag FLAG_COURT2_SPECTATORS_TALKED_DOUBLES ; $4be7
	jr .step ; $4bea
.checkFlag:
	test_flag FLAG_COURT2_SPECTATORS_TALKED_SINGLES ; $4bec
	jp nz, Court2SpectatorsRepeatChat ; $4bef
	set_flag FLAG_COURT2_SPECTATORS_TALKED_SINGLES ; $4bf2
.step:
	ld a, [wMapSceneStage] ; $4bf5
	add a ; $4bf8
	ld_hl_indexed Court2SpectatorChatTextIds ; $4bf9
	ld a, [hl+] ; $4c00
	ld h, [hl] ; $4c01
	ld l, a ; $4c02
	farcall InitDialogueTextCursor ; $4c03
	script_set_anim $08, $04 ; $4c06
	script_wait_idle $08 ; $4c0d
	script_speak $08 ; $4c12
	script_set_position $0c, $0c80, $2180 ; $4c17
	sound $97 ; $4c22
	script_wait_frames $14 ; $4c24
	script_speak $09 ; $4c2b
	script_set_position $0c, $3f00, $3f00 ; $4c30
	script_set_anim $08, $03 ; $4c3b
	script_wait_idle $08 ; $4c42
	script_speak $08 ; $4c47
	script_set_anim $09, $02 ; $4c4c
	script_wait_idle $09 ; $4c53
	script_speak $09 ; $4c58
	script_face_toward ACTOR_PLAYER, $08 ; $4c5d
	script_wait_frames $14 ; $4c65
	script_set_position $0c, $0a80, $2180 ; $4c6c
	sound $97 ; $4c77
	script_set_anim $08, $02 ; $4c79
	script_wait_idle $08 ; $4c80
	script_set_position $0c, $3f00, $3f00 ; $4c85
	script_wait_frames $0a ; $4c90
	script_set_position $0d, $0a80, $2180 ; $4c97
	sound $96 ; $4ca2
	script_wait_frames $14 ; $4ca4
	script_speak $08 ; $4cab
	script_set_position $0d, $3f00, $3f00 ; $4cb0
	script_set_position $0e, $0c80, $2180 ; $4cbb
	sound $98 ; $4cc6
	script_wait_frames $3c ; $4cc8
	script_set_position $0e, $3f00, $3f00 ; $4ccf
	script_face_toward ACTOR_PLAYER, $09 ; $4cda
	script_wait_frames $14 ; $4ce2
	script_set_position $0c, $0c80, $2180 ; $4ce9
	sound $97 ; $4cf4
	script_set_anim $09, $02 ; $4cf6
	script_wait_idle $09 ; $4cfd
	script_set_position $0c, $3f00, $3f00 ; $4d02
	script_wait_frames $0a ; $4d0d
	script_set_position $0d, $0c80, $2180 ; $4d14
	sound $96 ; $4d1f
	script_wait_frames $14 ; $4d21
	script_speak $09 ; $4d28
	script_set_position $0d, $3f00, $3f00 ; $4d2d
	script_set_anim $08, $03 ; $4d38
	script_set_anim $09, $03 ; $4d3f
	script_wait_idle $09 ; $4d46
	script_set_anim $08, $03 ; $4d4b
	script_set_anim $09, $03 ; $4d52
	script_wait_idle $09 ; $4d59
	ret ; $4d5e
Court2SpectatorChatTextIds:
	; $4d5f, 14 bytes (text_ids)
	dw Text_1f_107 ; record 0
	dw Text_1f_107 ; record 1
	dw Text_1f_107 ; record 2
	dw Text_1f_114 ; record 3
	dw Text_1f_120 ; record 4
	dw Text_1f_120 ; record 5
	dw Text_1f_126 ; record 6
Court2SpectatorsRepeatChat:
	script_set_anim $08, $02 ; $4d6d
	script_wait_idle $08 ; $4d74
	script_face_toward ACTOR_PLAYER, $08 ; $4d79
	script_set_text Text_1f_111 ; $4d81
	script_speak $08 ; $4d87
	script_set_anim $09, $02 ; $4d8c
	script_wait_idle $09 ; $4d93
	script_face_toward ACTOR_PLAYER, $09 ; $4d98
	script_speak $09 ; $4da0
	script_set_anim $08, $03 ; $4da5
	script_set_anim $09, $03 ; $4dac
	script_wait_idle $09 ; $4db3
	script_set_anim $08, $03 ; $4db8
	script_set_anim $09, $03 ; $4dbf
	script_wait_idle $09 ; $4dc6
	ret ; $4dcb
Court2Npc0A_14:
	script_set_text Text_1f_106 ; $4dcc
	test_flag FLAG_DOUBLES ; $4dd2
	jr nz, .isDoubles ; $4dd5
	ld a, [wMapSceneStage] ; $4dd7
	cp ISLANDOPENSTAGE_SINGLES_FINAL ; $4dda
	jr nz, .speak ; $4ddc
	script_set_text Text_1f_113 ; $4dde
	jr .speak ; $4de4
.isDoubles:
	ld a, [wMapSceneStage] ; $4de6
	cp ISLANDOPENSTAGE_DOUBLES_FINAL ; $4de9
	jr nz, .speak ; $4deb
	script_set_text Text_1f_113 ; $4ded
.speak:
	script_speak $0a ; $4df3
	ret ; $4df8
Court2NpcScripts_14:
	; $4df9, 73 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Court2Npc03_14, $03, $00
	map_script $04, FACEMASK_ANY, $0000, Court2Npc04_14, $03, $00
	map_script $05, FACEMASK_ANY, $0000, Court2Npc05_14, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Court2Npc06_14, $13, $00
	map_script $07, FACEMASK_ANY, $0000, Text_1f_104, $13, $00
	map_script $08, FACEMASK_ANY, $0000, Court2SpectatorChat_14, $00, $00
	map_script $09, FACEMASK_ANY, $0000, Court2SpectatorChat_14, $00, $00
	map_script $0a, FACEMASK_ANY, $0000, Court2Npc0A_14, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_1f_105, $03, $00
	db $ff
Court2FacingScripts_14:
	; $4e42, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Court2Facing01_14, $00, $00
	db $ff
Court2Facing01_14:
	ret ; $4e4b
Court2TileTriggers_14:
	; $4e4c, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Court2Tile01_14, $00, $00
	db $ff
Court2Tile01_14:
	ret ; $4e55
Court2InitScript_14:
	call InitCourt2SceneVariant ; $4e56
	call LoadCourtPlayerPartnerObjDefs_14 ; $4e59
	call Court2EntryWalkIn ; $4e5c
	ret ; $4e5f
InitCourt2SceneVariant:
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND1 ; $4e60
	ld [wMapSceneStage], a ; $4e62
	test_flag FLAG_DOUBLES ; $4e65
	jr nz, .doubles ; $4e68
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $4e6a
	jr z, .stage1 ; $4e6d
	ldh a, [hRomBank] ; $4e6f
	ld hl, Court2ActorsAlt_14 ; $4e71
	farcall ScriptRespawnLocationActors ; $4e74
	farcall BeginCutsceneScriptMode ; $4e77
	ld a, ISLANDOPENSTAGE_SINGLES_FINAL ; $4e7a
	jr .stage3 ; $4e7c
.stage1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $4e7e
	jr z, .stage2 ; $4e81
	ld a, ISLANDOPENSTAGE_SINGLES_SEMIFINAL ; $4e83
	jr .stage3 ; $4e85
.stage2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $4e87
	jr z, .stage4 ; $4e8a
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND2 ; $4e8c
.stage3:
	ld [wMapSceneStage], a ; $4e8e
.stage4:
	ret ; $4e91
.doubles:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $4e92
	jr z, .doublesStage2 ; $4e95
	ldh a, [hRomBank] ; $4e97
	ld hl, Court2ActorsAlt_14 ; $4e99
	farcall ScriptRespawnLocationActors ; $4e9c
	farcall BeginCutsceneScriptMode ; $4e9f
	ld a, ISLANDOPENSTAGE_DOUBLES_FINAL ; $4ea2
	jr .stage3 ; $4ea4
.doublesStage2:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $4ea6
	jr z, .done ; $4ea9
	ld a, ISLANDOPENSTAGE_DOUBLES_SEMIFINAL ; $4eab
	jr .stage3 ; $4ead
.done:
	ld a, ISLANDOPENSTAGE_DOUBLES_ROUND1 ; $4eaf
	jr .stage3 ; $4eb1
	ret ; $4eb3
Court2ActorsAlt_14:
	; $4eb4, 178 bytes (map_actors)
	map_actor $0000, ActorScript_14_2, $1d00, $1500, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_14_2, $1b00, $2300, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_14_2, $1f00, $2d00, FACE_LEFT, $30, $01, $05
	map_actor $0000, ActorScript_14_3, $1d00, $3000, FACE_UP, $39, $01, $05
	map_actor $0000, ActorScript_14_3, $0700, $3100, FACE_RIGHT, $39, $01, $04
	map_actor $0000, ActorScript_14_2, $0900, $2300, FACE_RIGHT, $39, $01, $04
	map_actor $0000, ActorScript_14_2, $0b00, $2300, FACE_LEFT, $3a, $01, $00
	map_actor $0000, ActorScript_14_2, $0b00, $2b00, FACE_RIGHT, $23, $01, $00
	map_actor $0000, ActorScript_14_2, $0f00, $2b00, FACE_LEFT, $24, $01, $00
	map_actor $0000, ActorScript_14_2, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_14_2, $fd00, $0100, FACE_DOWN, $53, $01, $00
	map_actor $0000, ActorScript_14_2, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor_end
Court2EntryWalkIn:
	ld a, [wStoryModeEntryPoint] ; $4f66
	cp STORYENTRY_NONE ; $4f69
	jp z, .done ; $4f6b
	test_flag FLAG_DOUBLES ; $4f6e
	jr z, .walkOff ; $4f71
	script_set_speed ACTOR_PARTNER, $00ff ; $4f73
	script_move_angle ACTOR_PARTNER, FACE_RIGHT, $0200 ; $4f7b
	script_wait_move ACTOR_PARTNER ; $4f85
	script_face ACTOR_PARTNER, FACE_LEFT ; $4f8a
	script_set_speed ACTOR_PARTNER, $0010 ; $4f91
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $4f99
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0200 ; $4fa1
.done:
	ret ; $4fab
Court1MapScripts_14:
	; $4fac, 14 bytes (map_tree)
	dw Court1EntryPoints_14 ; slot 0 EntryPoints
	dw Court1ExitTriggers_14 ; slot 1 ExitTriggers
	dw Court1Actors_14 ; slot 2 Actors
	dw Court1NpcScripts_14 ; slot 3 NpcScripts
	dw Court1FacingScripts_14 ; slot 4 FacingScripts
	dw Court1TileTriggers_14 ; slot 5 TileTriggers
	dw Court1InitScript_14 ; slot 6 InitScript
Court1Actors_14:
	; $4fba, 136 bytes (map_actors)
	map_actor $0000, ActorScript_14_2, $0b00, $1500, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_14_2, $1100, $2300, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_14_2, $2300, $1900, FACE_LEFT, $39, $01, $03
	map_actor $0000, ActorScript_14_2, $2300, $1c00, FACE_LEFT, $32, $01, $03
	map_actor $0000, ActorScript_14_2, $0e00, $0d00, FACE_RIGHT, $39, $01, $00
	map_actor $0000, ActorScript_14_2, $0f00, $0f00, FACE_RIGHT, $39, $01, $06
	map_actor $0000, ActorScript_14_2, $0e00, $1100, FACE_RIGHT, $3a, $01, $03
	map_actor $0000, ActorScript_14_2, $2300, $0f00, FACE_LEFT, $33, $01, $00
	map_actor $0000, ActorScript_14_2, $2100, $1100, FACE_LEFT, $3a, $01, $04
	map_actor_end
Court1EntryPoints_14:
	; $5042, 17 bytes (map_entries)
	map_entry $01, FACE_RIGHT, $0300, $1500, $0000
	map_entry $02, FACE_RIGHT, $0300, $2500, $0000
	db $ff
Court1ExitTriggers_14:
	; $5053, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_TOURNAMENT, $04
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_TOURNAMENT_COURTYARD, $01
	db $ff
Court1Npc03_14:
	script_set_text Text_1f_132 ; $5064
	script_speak $03 ; $506a
	ret ; $506f
Court1Npc04_14:
	script_set_text Text_1f_133 ; $5070
	script_speak $04 ; $5076
	ret ; $507b
Court1Npc05_14:
	ld a, [wMapSceneStage] ; $507c
	add a ; $507f
	ld_hl_indexed Court1Npc05TextIds ; $5080
	ld a, [hl+] ; $5087
	ld h, [hl] ; $5088
	ld l, a ; $5089
	farcall InitDialogueTextCursor ; $508a
	script_speak $05 ; $508d
	ret ; $5092
Court1Npc05TextIds:
	; $5093, 14 bytes (text_ids)
	dw Text_1f_134 ; record 0
	dw Text_1f_134 ; record 1
	dw Text_1f_137 ; record 2
	dw Text_1f_139 ; record 3
	dw Text_1f_134 ; record 4
	dw Text_1f_141 ; record 5
	dw Text_1f_143 ; record 6
Court1Npc06_14:
	ld a, [wMapSceneStage] ; $50a1
	add a ; $50a4
	ld_hl_indexed Court1Npc06TextIds ; $50a5
	ld a, [hl+] ; $50ac
	ld h, [hl] ; $50ad
	ld l, a ; $50ae
	farcall InitDialogueTextCursor ; $50af
	script_speak $06 ; $50b2
	ret ; $50b7
Court1Npc06TextIds:
	; $50b8, 14 bytes (text_ids)
	dw Text_1f_135 ; record 0
	dw Text_1f_136 ; record 1
	dw Text_1f_138 ; record 2
	dw Text_1f_140 ; record 3
	dw Text_1f_135 ; record 4
	dw Text_1f_142 ; record 5
	dw Text_1f_144 ; record 6
Court1NpcScripts_14:
	; $50c6, 33 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Court1Npc03_14, $03, $00
	map_script $04, FACEMASK_ANY, $0000, Court1Npc04_14, $03, $00
	map_script $05, FACEMASK_ANY, $0000, Court1Npc05_14, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Court1Npc06_14, $03, $00
	db $ff
Court1FacingScripts_14:
	; $50e7, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Court1Facing01_14, $00, $00
	db $ff
Court1Facing01_14:
	ret ; $50f0
Court1TileTriggers_14:
	; $50f1, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Court1Tile01_14, $00, $00
	db $ff
Court1Tile01_14:
	ret ; $50fa
Court1InitScript_14:
	call InitCourt1SceneVariant ; $50fb
	call LoadCourtPlayerPartnerObjDefs_14 ; $50fe
	call Court1EntryWalkIn ; $5101
	ret ; $5104
InitCourt1SceneVariant:
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND1 ; $5105
	ld [wMapSceneStage], a ; $5107
	test_flag FLAG_DOUBLES ; $510a
	jr nz, .doubles ; $510d
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $510f
	jr z, .stage1 ; $5112
	ld a, ISLANDOPENSTAGE_SINGLES_FINAL ; $5114
	ld [wMapSceneStage], a ; $5116
	ldh a, [hRomBank] ; $5119
	ld hl, Court1ActorsAlt_14 ; $511b
	farcall ScriptRespawnLocationActors ; $511e
	farcall BeginCutsceneScriptMode ; $5121
	ret ; $5124
.stage1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $5125
	jr z, .stage2 ; $5128
	ld a, ISLANDOPENSTAGE_SINGLES_SEMIFINAL ; $512a
	ld [wMapSceneStage], a ; $512c
	ret ; $512f
.stage2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $5130
	jr z, .stage3 ; $5133
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND2 ; $5135
	ld [wMapSceneStage], a ; $5137
.stage3:
	ret ; $513a
.doubles:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $513b
	jr z, .doublesStage2 ; $513e
	ld a, ISLANDOPENSTAGE_DOUBLES_FINAL ; $5140
	ld [wMapSceneStage], a ; $5142
	ldh a, [hRomBank] ; $5145
	ld hl, Court1ActorsAlt_14 ; $5147
	farcall ScriptRespawnLocationActors ; $514a
	farcall BeginCutsceneScriptMode ; $514d
	ret ; $5150
.doublesStage2:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $5151
	jr z, .done ; $5154
	ld a, ISLANDOPENSTAGE_DOUBLES_SEMIFINAL ; $5156
	ld [wMapSceneStage], a ; $5158
	ret ; $515b
.done:
	ld a, ISLANDOPENSTAGE_DOUBLES_ROUND1 ; $515c
	ld [wMapSceneStage], a ; $515e
	ret ; $5161
Court1ActorsAlt_14:
	; $5162, 66 bytes (map_actors)
	map_actor $0000, ActorScript_14_2, $0b00, $1500, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_14_2, $1100, $2300, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_14_2, $1b00, $2300, FACE_DOWN, $39, $01, $03
	map_actor $0000, ActorScript_14_2, $1d00, $2300, FACE_DOWN, $32, $01, $03
	map_actor_end
Court1EntryWalkIn:
	ld a, [wStoryModeEntryPoint] ; $51a4
	cp STORYENTRY_NONE ; $51a7
	jp z, .done ; $51a9
	test_flag FLAG_DOUBLES ; $51ac
	jr z, .walkOff ; $51af
	script_set_speed ACTOR_PARTNER, $00ff ; $51b1
	script_move_angle ACTOR_PARTNER, FACE_LEFT, $0200 ; $51b9
	script_wait_move ACTOR_PARTNER ; $51c3
	script_face ACTOR_PARTNER, FACE_RIGHT ; $51c8
	script_set_speed ACTOR_PARTNER, $0010 ; $51cf
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $51d7
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0200 ; $51df
.done:
	ret ; $51e9
LoadCourtPlayerPartnerObjDefs_14:
	test_flag FLAG_DOUBLES ; $51ea
	jp z, .notDoubles ; $51ed
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $51f0
	ld d, $58 ; $51f3
	add d ; $51f5
	ld d, a ; $51f6
	script_get_actor_state ACTOR_PARTNER ; $51f7
	ld c, l ; $51fc
	ld b, h ; $51fd
	farcall LoadActorObjectDefIfValid ; $51fe
	script_set_anim ACTOR_PARTNER, $01 ; $5201
.notDoubles:
	ld a, [wStoryModeGenderOfMainCharacter] ; $5208
	ld d, $56 ; $520b
	add d ; $520d
	ld d, a ; $520e
	script_get_actor_state ACTOR_PLAYER ; $520f
	ld c, l ; $5214
	ld b, h ; $5215
	farcall LoadActorObjectDefIfValid ; $5216
	script_set_anim ACTOR_PLAYER, $01 ; $5219
	ret ; $5220
IslandSkyMapScripts_14:
	; $5221, 14 bytes (map_tree)
	dw IslandSkyEntryPoints_14 ; slot 0 EntryPoints
	dw IslandSkyExitTriggers_14 ; slot 1 ExitTriggers
	dw IslandSkyActors_14 ; slot 2 Actors
	dw IslandSkyNpcScripts_14 ; slot 3 NpcScripts
	dw IslandSkyFacingScripts_14 ; slot 4 FacingScripts
	dw IslandSkyTileTriggers_14 ; slot 5 TileTriggers
	dw IslandSkyInitScript_14 ; slot 6 InitScript
IslandSkyActors_14:
	; $522f, 66 bytes (map_actors)
	map_actor $0000, ActorScript_14_2, $0600, $2700, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_14_2, $0600, $2700, FACE_DOWN, $5c, $01, $00
	map_actor $0000, ActorScript_14_2, $0600, $2700, FACE_DOWN, $5b, $01, $00
	map_actor $0000, ActorScript_14_2, $0600, $2700, FACE_DOWN, $5a, $01, $00
	map_actor_end
IslandSkyEntryPoints_14:
	; $5271, 49 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0c00, $1200, $0000
	map_entry $02, FACE_UP, $0600, $2700, $0000
	map_entry $08, FACE_DOWN, $0600, $2700, $0000
	map_entry $0c, FACE_DOWN, $0600, $2700, $0000
	map_entry $0e, FACE_DOWN, $0c00, $0b00, $0000
	map_entry $0f, FACE_DOWN, $0c00, $1200, $0000
	db $ff
IslandSkyExitTriggers_14:
	; $52a2, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_RESTAURANT_PLAZA, $06
	db $ff
	ret ; $52ab
IslandSkyNpcScripts_14:
	; $52ac, 9 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_35_48, $00, $00
	db $ff
IslandSkyFacingScripts_14:
	ds 1, $ff ; $52b5, fill
IslandSkyTileTriggers_14:
	ds 1, $ff ; $52b6, fill
IslandSkyInitScript_14:
	script_set_position $03, $3f00, $3f00 ; $52b7
	script_set_position $04, $3f00, $3f00 ; $52c2
	script_set_position $05, $3f00, $3f00 ; $52cd
	script_set_position $06, $3f00, $3f00 ; $52d8
	ld a, [wStoryModeEntryPoint] ; $52e3
	cp $02 ; $52e6
	jp z, QueuePlaneSpriteByFrameCounter_14.loadScene ; $52e8
	cp $08 ; $52eb
	jp z, UpdateFirework1_14Table.scriptRespawnLocationActors ; $52ed
	cp $0e ; $52f0
	jp z, QueueTwinkleSprite_14.queue ; $52f2
	cp $0f ; $52f5
	jp z, AdvanceFirework1Ascent_14.loadScene ; $52f7
	cp $0d ; $52fa
	jp z, AdvanceFirework1Ascent_14.loadScene ; $52fc
	jp .loadScene ; $52ff
	ret ; $5302
.loadScene:
	set_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $5303
	call DisableLCDSafely ; $5306
	call LoadPlaneObjGfx_14 ; $5309
	call LoadWaterSplashObjGfx_14 ; $530c
	call EnableLCD ; $530f
	ld a, $50 ; $5312
	ld [wMapSceneStage], a ; $5314
	ld a, $88 ; $5317
	ld [wMapSceneStage2], a ; $5319
	ld a, $01 ; $531c
	ld hl, QueuePlaneSpriteByHeight_14 ; $531e
	call RegisterFrameTask ; $5321
	test_flag FLAG_DOUBLES ; $5324
	jp z, .setPlayerObjDef ; $5327
	script_null_script ACTOR_PARTNER ; $532a
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $532f
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $533a
	ld d, $58 ; $533d
	add d ; $533f
	ld d, a ; $5340
	script_get_actor_state $05 ; $5341
	ld c, l ; $5346
	ld b, h ; $5347
	farcall LoadActorObjectDefIfValid ; $5348
	script_set_anim $05, $01 ; $534b
.setPlayerObjDef:
	ld a, [wStoryModeGenderOfMainCharacter] ; $5352
	ld d, $56 ; $5355
	add d ; $5357
	ld d, a ; $5358
	script_get_actor_state ACTOR_PLAYER ; $5359
	ld c, l ; $535e
	ld b, h ; $535f
	farcall LoadActorObjectDefIfValid ; $5360
	script_set_anim ACTOR_PLAYER, $01 ; $5363
	script_set_active ACTOR_PLAYER, $00 ; $536a
	ld a, [wStoryModeEntryPoint] ; $5371
	cp $0c ; $5374
	jr nz, .fadeIn ; $5376
	script_set_position ACTOR_PLAYER, $0600, $2700 ; $5378
	xor a ; $5383
	ld [wStoryModeShowLocationName], a ; $5384
	script_fade_in $04 ; $5387
	call WaitFadeEnd ; $538c
	ld a, $3b ; $538f
	ld [wMapSceneStage], a ; $5391
	ld a, $a8 ; $5394
	ld [wMapSceneStage2], a ; $5396
	jp .afterFlight ; $5399
.fadeIn:
	xor a ; $539c
	ld [wStoryModeShowLocationName], a ; $539d
	script_fade_in $06 ; $53a0
	call WaitFadeEnd ; $53a5
	sound $7a ; $53a8
	script_wait_frames $3c ; $53aa
	script_set_position ACTOR_PLAYER, $0600, $2700 ; $53b1
	ld h, $08 ; $53bc
.planeLoop:
	script_wait_frames $06 ; $53be
	call PlayPlaneMoveSfx_14 ; $53c5
	ld a, [wMapSceneStage2] ; $53c8
	inc a ; $53cb
	ld [wMapSceneStage2], a ; $53cc
	dec h ; $53cf
	jr nz, .planeLoop ; $53d0
	ld h, $08 ; $53d2
.planeLoop2:
	script_wait_frames $05 ; $53d4
	call PlayPlaneMoveSfx_14 ; $53db
	ld a, h ; $53de
	and $01 ; $53df
	jr z, .advanceStage ; $53e1
	ld a, [wMapSceneStage] ; $53e3
	dec a ; $53e6
	ld [wMapSceneStage], a ; $53e7
.advanceStage:
	ld a, [wMapSceneStage2] ; $53ea
	inc a ; $53ed
	ld [wMapSceneStage2], a ; $53ee
	dec h ; $53f1
	jr nz, .planeLoop2 ; $53f2
	ld h, $08 ; $53f4
.checkStage:
	script_wait_frames $04 ; $53f6
	call PlayPlaneMoveSfx_14 ; $53fd
	ld a, [wMapSceneStage] ; $5400
	dec a ; $5403
	ld [wMapSceneStage], a ; $5404
	ld a, [wMapSceneStage2] ; $5407
	inc a ; $540a
	ld [wMapSceneStage2], a ; $540b
	dec h ; $540e
	jr nz, .checkStage ; $540f
	script_player_speed $0012 ; $5411
	script_move_player_to_actor ACTOR_PLAYER ; $5417
	ld h, $1c ; $541e
.descend:
	script_wait_frames $03 ; $5420
	call PlayPlaneMoveSfx_14 ; $5427
	ld a, h ; $542a
	and $01 ; $542b
	jr z, .landed ; $542d
	ld a, [wMapSceneStage] ; $542f
	dec a ; $5432
	ld [wMapSceneStage], a ; $5433
.landed:
	ld a, [wMapSceneStage2] ; $5436
	inc a ; $5439
	ld [wMapSceneStage2], a ; $543a
	dec h ; $543d
	jr nz, .descend ; $543e
.afterFlight:
	ld h, $00 ; $5440
.placeActors:
	script_wait_frames $03 ; $5442
	inc h ; $5449
	call PlayPlaneMoveSfx_14 ; $544a
	ld a, [wMapSceneStage2] ; $544d
	inc a ; $5450
	ld [wMapSceneStage2], a ; $5451
	and $03 ; $5454
	cp $03 ; $5456
	jr nz, .placeDoubles ; $5458
	ld a, [wMapSceneStage] ; $545a
	dec a ; $545d
	ld [wMapSceneStage], a ; $545e
.placeDoubles:
	ld a, [wMapSceneStage] ; $5461
	cp $20 ; $5464
	jr nz, .placeActors ; $5466
	ld h, $08 ; $5468
.walkOff:
	script_wait_frames $04 ; $546a
	call PlayPlaneMoveSfx_14 ; $5471
	ld a, [wMapSceneStage2] ; $5474
	inc a ; $5477
	ld [wMapSceneStage2], a ; $5478
	dec h ; $547b
	jr nz, .walkOff ; $547c
	sound SFX_PLANE ; $547e
	ld h, $08 ; $5480
.speak:
	script_wait_frames $06 ; $5482
	ld a, [wMapSceneStage2] ; $5489
	inc a ; $548c
	ld [wMapSceneStage2], a ; $548d
	dec h ; $5490
	jr nz, .speak ; $5491
	sound $7d ; $5493
	ld h, $04 ; $5495
.speakDoubles:
	script_wait_frames $08 ; $5497
	ld a, [wMapSceneStage2] ; $549e
	inc a ; $54a1
	ld [wMapSceneStage2], a ; $54a2
	dec h ; $54a5
	jr nz, .speakDoubles ; $54a6
	ld a, [wStoryModeEntryPoint] ; $54a8
	cp $0c ; $54ab
	jr z, .setLocation ; $54ad
	test_flag FLAG_DOUBLES ; $54af
	jr z, .fadeOut ; $54b2
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $54b4
	jp z, .setLocation ; $54b7
	jr .transition ; $54ba
.fadeOut:
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $54bc
	jr z, .setLocation ; $54bf
.transition:
	ld c, $04 ; $54c1
	call BeginFadeOut ; $54c3
	call WaitFadeEnd ; $54c6
	call ClearFrameTasks ; $54c9
	ld a, STORYLOC_TOURNAMENT_COURTYARD ; $54cc
	ld [wStoryModeCurrentLocation], a ; $54ce
	ld a, $04 ; $54d1
	ld [wStoryModeEntryPoint], a ; $54d3
	ld a, $ff ; $54d6
	ld [wUnusedExitTriggerIdMirror], a ; $54d8
	ld [wStoryModeExitTriggerRequest], a ; $54db
	ret ; $54de
.setLocation:
	ld a, $40 ; $54df
	ld [wCutsceneObjX], a ; $54e1
	ld a, $00 ; $54e4
	ld [wCutsceneObjY], a ; $54e6
	xor a ; $54e9
	ld [wCutsceneObjPhase], a ; $54ea
	ld a, $10 ; $54ed
	ld [wCutsceneObjRiseTimer], a ; $54ef
	ld a, $00 ; $54f2
	ld [wCutsceneObjActive], a ; $54f4
	ld a, $01 ; $54f7
	ld hl, UpdateWaterSplash0_14 ; $54f9
	call RegisterFrameTask ; $54fc
	script_wait_frames $0a ; $54ff
	ld a, $50 ; $5506
	ld [wCutsceneObjX + 1], a ; $5508
	ld a, $02 ; $550b
	ld [wCutsceneObjY + 1], a ; $550d
	xor a ; $5510
	ld [wCutsceneObjPhase + 1], a ; $5511
	ld a, $10 ; $5514
	ld [wCutsceneObjRiseTimer + 1], a ; $5516
	ld a, $00 ; $5519
	ld [wCutsceneObjActive + 1], a ; $551b
	ld a, $01 ; $551e
	ld hl, UpdateWaterSplash1_14 ; $5520
	call RegisterFrameTask ; $5523
	script_wait_frames $50 ; $5526
	script_set_position $03, $0600, $2900 ; $552d
	script_set_position $04, $0600, $2900 ; $5538
	script_set_position $05, $0600, $2900 ; $5543
	script_set_position $06, $0600, $2900 ; $554e
	script_set_actor_script $03, ActorScript_14_1 ; $5559
	script_wait_frames $1e ; $5564
	script_set_actor_script $04, ActorScript_14_1 ; $556b
	script_wait_frames $1e ; $5576
	script_set_actor_script $05, ActorScript_14_1 ; $557d
	script_wait_frames $1e ; $5588
	script_set_actor_script $06, ActorScript_14_1 ; $558f
	script_wait_frames $50 ; $559a
	script_set_position ACTOR_PLAYER, $0600, $2900 ; $55a1
	script_set_active ACTOR_PLAYER, $02 ; $55ac
	script_face ACTOR_PLAYER, FACE_DOWN ; $55b3
	script_wait_frames $1e ; $55ba
	script_move_target ACTOR_PLAYER, $0b00, $2900 ; $55c1
	script_wait_move ACTOR_PLAYER ; $55cc
	script_face ACTOR_PLAYER, FACE_UP ; $55d1
	script_wait_frames $1e ; $55d8
	script_set_anim ACTOR_PLAYER, $02 ; $55df
	script_wait_idle ACTOR_PLAYER ; $55e6
	ld a, [wStoryModeEntryPoint] ; $55eb
	cp $0c ; $55ee
	jr nz, .done ; $55f0
	ld a, $01 ; $55f2
	ld [wCutsceneObjActive], a ; $55f4
	ld [wCutsceneObjActive + 1], a ; $55f7
	ld a, $01 ; $55fa
	ld [wUnusedExitTriggerIdMirror], a ; $55fc
	ld [wStoryModeExitTriggerRequest], a ; $55ff
	ret ; $5602
.done:
	script_move_target ACTOR_PLAYER, $0b00, $2700 ; $5603
	script_wait_move ACTOR_PLAYER ; $560e
	script_set_active ACTOR_PLAYER, $00 ; $5613
	ld c, $04 ; $561a
	call BeginFadeOut ; $561c
	call WaitFadeEnd ; $561f
	call WaitFadeEnd ; $5622
	call ClearFrameTasks ; $5625
	ld a, STORYLOC_DORM_ROOM ; $5628
	ld [wStoryModeCurrentLocation], a ; $562a
	ld a, $09 ; $562d
	ld [wStoryModeEntryPoint], a ; $562f
	ld a, $ff ; $5632
	ld [wUnusedExitTriggerIdMirror], a ; $5634
	ld [wStoryModeExitTriggerRequest], a ; $5637
	ret ; $563a
ActorScript_14_1:
	; $563b, 21 bytes (actor_script)
	as_set_target $0b00, $2900
	as_wait_move
	as_set_target $0b00, $2700
	as_wait_move
	as_set_pos $0100, $0100
	as_halt
	as_halt
	as_halt
	as_halt
PlaneObjTiles_14:
	INCBIN "data/bank_014/d_5650.bin" ; $5650, 1024 bytes
IslandObjTiles_14:
	INCBIN "data/bank_014/d_5a50.bin" ; $5a50, 1024 bytes
SpriteTemplate_14_0:
	; $5e50, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite_end
IslandObjPalette_14:
	INCLUDE "data/bank_014/palettes_5e71.asm" ; $5e71, 8 bytes (palettes)
LoadPlaneObjGfx_14:
	push_wram_bank $01 ; $5e79
	ld hl, PlaneObjTiles_14 ; $5e82
	ld de, $8000 + VRAM_BANK1 ; $5e85
	ld c, $60 ; $5e88
	call QueueVRAMCopy ; $5e8a
	ld hl, IslandObjPalette_14 ; $5e8d
	ld de, $0801 ; $5e90
	call LoadPaletteShadow ; $5e93
	pop_wram_bank ; $5e96
	ret ; $5e9b
QueuePlaneSpriteByHeight_14:
	call GetSceneObjectScreenPos_14 ; $5e9c
	ld b, $00 ; $5e9f
	ld a, [wMapSceneStage2] ; $5ea1
	sub $88 ; $5ea4
	cp $0a ; $5ea6
	jr c, .queueSpriteTemplate ; $5ea8
	ld b, $10 ; $5eaa
	cp $14 ; $5eac
	jr c, .queueSpriteTemplate ; $5eae
	ld b, $20 ; $5eb0
	cp $1e ; $5eb2
	jr c, .queueSpriteTemplate ; $5eb4
	ld b, $30 ; $5eb6
	cp $50 ; $5eb8
	jr c, .queueSpriteTemplate ; $5eba
	ld b, $20 ; $5ebc
	cp $78 ; $5ebe
	jr c, .queueSpriteTemplate ; $5ec0
	ld b, $10 ; $5ec2
.queueSpriteTemplate:
	ld c, b ; $5ec4
	ld hl, SpriteTemplate_14_0 ; $5ec5
	ld b, $08 ; $5ec8
	call QueueSpriteTemplate ; $5eca
	ret ; $5ecd
	; $5ece, 2 bytes (fill)
	ds 2, $00
WaterSplashObjGfx:
	INCBIN "data/bank_014/d_5ed0.bin" ; $5ed0, 448 bytes
SpriteTemplate_14_1:
	; $6090, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
WaterSplashObjPalette_14:
	INCLUDE "data/bank_014/palettes_6099.asm" ; $6099, 8 bytes (palettes)
LoadWaterSplashObjGfx_14:
	push_wram_bank $01 ; $60a1
	ld hl, WaterSplashObjGfx ; $60aa
	ld de, $8200 ; $60ad
	ld c, (SpriteTemplate_14_1 - WaterSplashObjGfx) / 16 ; $60b0
	call QueueVRAMCopy ; $60b2
	ld hl, WaterSplashObjPalette_14 ; $60b5
	ld de, $0901 ; $60b8
	call LoadPaletteShadow ; $60bb
	pop_wram_bank ; $60be
	ret ; $60c3
UpdateWaterSplash0_14:
	ldh a, [hScrollX] ; $60c4
	ld b, a ; $60c6
	ld a, [wCutsceneObjX] ; $60c7
	sub b ; $60ca
	ld d, a ; $60cb
	ld a, [wCutsceneObjActive] ; $60cc
	and a ; $60cf
	jr nz, .checkHit ; $60d0
	call AdvanceWaterSplash0Rise_14 ; $60d2
.checkHit:
	ldh a, [hScrollY] ; $60d5
	ld b, a ; $60d7
	ld a, [wCutsceneObjY] ; $60d8
	add $20 ; $60db
	sub b ; $60dd
	ld e, a ; $60de
	ld a, [wCutsceneObjActive] ; $60df
	and a ; $60e2
	jp z, .hit ; $60e3
	ld a, [wCutsceneObjLimit] ; $60e6
	ld b, a ; $60e9
	ld a, [wCutsceneObjPhase] ; $60ea
	cp $14 ; $60ed
	jr c, .respawn ; $60ef
	cp b ; $60f1
	jr c, .done ; $60f2
.hit:
	ld a, [wCutsceneObjRiseTimer] ; $60f4
	and a ; $60f7
	jr z, .scorePoint ; $60f8
	ld a, $08 ; $60fa
	ld [wCutsceneObjTimer], a ; $60fc
	ld a, $00 ; $60ff
	ld [wCutsceneObjPhase], a ; $6101
	jp .respawn ; $6104
.scorePoint:
	ld a, [wCutsceneObjTimer] ; $6107
	inc a ; $610a
	ld [wCutsceneObjTimer], a ; $610b
	cp $08 ; $610e
	jr c, .advance ; $6110
	cp $08 ; $6112
	jr z, .playSfx ; $6114
	sound SFX_SPLASH ; $6116
.playSfx:
	ld a, [wCutsceneObjX] ; $6118
	inc a ; $611b
	ld [wCutsceneObjX], a ; $611c
	xor a ; $611f
	ld [wCutsceneObjTimer], a ; $6120
	ld a, [wCutsceneObjPhase] ; $6123
	add $04 ; $6126
	ld [wCutsceneObjPhase], a ; $6128
.advance:
	ld a, [wCutsceneObjLimit] ; $612b
	ld b, a ; $612e
	ld a, [wCutsceneObjPhase] ; $612f
	cp $14 ; $6132
	jr c, .respawn ; $6134
	cp b ; $6136
	jr c, .done ; $6137
	xor a ; $6139
	ld [wCutsceneObjPhase], a ; $613a
	call AdvanceRandomSeed ; $613d
	ld a, l ; $6140
	and $0f ; $6141
	add a ; $6143
	add $40 ; $6144
	ld [wCutsceneObjX], a ; $6146
	ld a, h ; $6149
	and $3c ; $614a
	ld [wCutsceneObjLimit], a ; $614c
	ld a, h ; $614f
	and $0f ; $6150
	ld [wCutsceneObjY], a ; $6152
	ld a, $10 ; $6155
	ld [wCutsceneObjRiseTimer], a ; $6157
	jr .done ; $615a
.respawn:
	ld a, [wCutsceneObjPhase] ; $615c
	add $20 ; $615f
	ld c, a ; $6161
	ld hl, SpriteTemplate_14_1 ; $6162
	ld b, $01 ; $6165
	call QueueSpriteTemplate ; $6167
.done:
	ret ; $616a
AdvanceWaterSplash0Rise_14:
	ld a, [wCutsceneObjRiseTimer] ; $616b
	and a ; $616e
	jr z, .done ; $616f
	dec a ; $6171
	ld [wCutsceneObjRiseTimer], a ; $6172
	ld a, [wCutsceneObjY] ; $6175
	sub $02 ; $6178
	ld [wCutsceneObjY], a ; $617a
.done:
	ret ; $617d
UpdateWaterSplash1_14:
	ldh a, [hScrollX] ; $617e
	ld b, a ; $6180
	ld a, [wCutsceneObjX + 1] ; $6181
	sub b ; $6184
	ld d, a ; $6185
	ld a, [wCutsceneObjActive + 1] ; $6186
	and a ; $6189
	jr nz, .checkHit ; $618a
	call AdvanceWaterSplash1Rise_14 ; $618c
.checkHit:
	ldh a, [hScrollY] ; $618f
	ld b, a ; $6191
	ld a, [wCutsceneObjY + 1] ; $6192
	add $20 ; $6195
	sub b ; $6197
	ld e, a ; $6198
	ld a, [wCutsceneObjActive + 1] ; $6199
	and a ; $619c
	jp z, .hit ; $619d
	ld a, [wCutsceneObjLimit + 1] ; $61a0
	ld b, a ; $61a3
	ld a, [wCutsceneObjPhase + 1] ; $61a4
	cp $14 ; $61a7
	jr c, .respawn ; $61a9
	cp b ; $61ab
	jr c, .done ; $61ac
.hit:
	ld a, [wCutsceneObjRiseTimer + 1] ; $61ae
	and a ; $61b1
	jr z, .scorePoint ; $61b2
	ld a, $08 ; $61b4
	ld [wCutsceneObjTimer + 1], a ; $61b6
	ld a, $00 ; $61b9
	ld [wCutsceneObjPhase + 1], a ; $61bb
	jp .respawn ; $61be
.scorePoint:
	ld a, [wCutsceneObjTimer + 1] ; $61c1
	inc a ; $61c4
	ld [wCutsceneObjTimer + 1], a ; $61c5
	cp $08 ; $61c8
	jr c, .advance ; $61ca
	cp $08 ; $61cc
	jr z, .playSfx ; $61ce
	sound SFX_SPLASH ; $61d0
.playSfx:
	ld a, [wCutsceneObjX + 1] ; $61d2
	inc a ; $61d5
	ld [wCutsceneObjX + 1], a ; $61d6
	xor a ; $61d9
	ld [wCutsceneObjTimer + 1], a ; $61da
	ld a, [wCutsceneObjPhase + 1] ; $61dd
	add $04 ; $61e0
	ld [wCutsceneObjPhase + 1], a ; $61e2
.advance:
	ld a, [wCutsceneObjLimit + 1] ; $61e5
	ld b, a ; $61e8
	ld a, [wCutsceneObjPhase + 1] ; $61e9
	cp $14 ; $61ec
	jr c, .respawn ; $61ee
	cp b ; $61f0
	jr c, .done ; $61f1
	xor a ; $61f3
	ld [wCutsceneObjPhase + 1], a ; $61f4
	call AdvanceRandomSeed ; $61f7
	ld a, l ; $61fa
	and $0f ; $61fb
	add a ; $61fd
	add $40 ; $61fe
	ld [wCutsceneObjX + 1], a ; $6200
	ld a, l ; $6203
	and $3f ; $6204
	ld [wCutsceneObjLimit + 1], a ; $6206
	ld a, h ; $6209
	and $0f ; $620a
	ld [wCutsceneObjY + 1], a ; $620c
	ld a, $10 ; $620f
	ld [wCutsceneObjRiseTimer + 1], a ; $6211
	jr .done ; $6214
.respawn:
	ld a, [wCutsceneObjPhase + 1] ; $6216
	add $20 ; $6219
	ld c, a ; $621b
	ld hl, SpriteTemplate_14_1 ; $621c
	ld b, $01 ; $621f
	call QueueSpriteTemplate ; $6221
.done:
	ret ; $6224
AdvanceWaterSplash1Rise_14:
	ld a, [wCutsceneObjRiseTimer + 1] ; $6225
	and a ; $6228
	jr z, .done ; $6229
	dec a ; $622b
	ld [wCutsceneObjRiseTimer + 1], a ; $622c
	ld a, [wCutsceneObjY + 1] ; $622f
	sub $02 ; $6232
	ld [wCutsceneObjY + 1], a ; $6234
.done:
	ret ; $6237
LoadPlaneObjGfx2_14:
	push_wram_bank $01 ; $6238
	ld hl, IslandObjTiles_14 ; $6241
	ld de, $8000 + VRAM_BANK1 ; $6244
	ld c, $60 ; $6247
	call QueueVRAMCopy ; $6249
	ld hl, IslandObjPalette_14 ; $624c
	ld de, $0801 ; $624f
	call LoadPaletteShadow ; $6252
	pop_wram_bank ; $6255
	ret ; $625a
QueuePlaneSpriteByFrameCounter_14:
	call GetSceneObjectScreenPos_14 ; $625b
	ld b, $10 ; $625e
	ld a, [wCutsceneObjX] ; $6260
	cp $14 ; $6263
	jr c, .queue ; $6265
	ld b, $20 ; $6267
	cp $1e ; $6269
	jr c, .queue ; $626b
	ld b, $30 ; $626d
	cp $5a ; $626f
	jr c, .queue ; $6271
	ld b, $20 ; $6273
	cp $78 ; $6275
	jr c, .queue ; $6277
	ld b, $10 ; $6279
	cp $8c ; $627b
	jr c, .queue ; $627d
	ld b, $00 ; $627f
.queue:
	ld c, b ; $6281
	ld hl, SpriteTemplate_14_0 ; $6282
	ld b, $08 ; $6285
	call QueueSpriteTemplate ; $6287
	ret ; $628a
.loadScene:
	clear_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $628b
	call DisableLCDSafely ; $628e
	call LoadPlaneObjGfx2_14 ; $6291
	call EnableLCD ; $6294
	ld a, $20 ; $6297
	ld [wMapSceneStage], a ; $6299
	ld a, $28 ; $629c
	ld [wMapSceneStage2], a ; $629e
	ld a, $00 ; $62a1
	ld [wCutsceneObjX], a ; $62a3
	ld a, $01 ; $62a6
	ld hl, QueuePlaneSpriteByFrameCounter_14 ; $62a8
	call RegisterFrameTask ; $62ab
	script_set_active ACTOR_PLAYER, $00 ; $62ae
	script_set_active $03, $00 ; $62b5
	test_flag FLAG_DOUBLES ; $62bc
	jp z, .fadeIn ; $62bf
	script_null_script ACTOR_PARTNER ; $62c2
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $62c7
.fadeIn:
	xor a ; $62d2
	ld [wStoryModeShowLocationName], a ; $62d3
	script_fade_in $06 ; $62d6
	call WaitFadeEnd ; $62db
	sound $7a ; $62de
	script_wait_frames $3c ; $62e0
	script_set_position ACTOR_PLAYER, $0c00, $1300 ; $62e7
	ld h, $08 ; $62f2
.planeLoop:
	script_wait_frames $06 ; $62f4
	call PlayPlaneMoveSfx_14 ; $62fb
	ld a, [wMapSceneStage2] ; $62fe
	dec a ; $6301
	ld [wMapSceneStage2], a ; $6302
	call AdvancePlaneFrameCounter_14 ; $6305
	dec h ; $6308
	jr nz, .planeLoop ; $6309
	ld h, $08 ; $630b
.planeLoop2:
	script_wait_frames $05 ; $630d
	call PlayPlaneMoveSfx_14 ; $6314
	ld a, h ; $6317
	and $01 ; $6318
	jr z, .planeArrived ; $631a
	ld a, [wMapSceneStage] ; $631c
	inc a ; $631f
	ld [wMapSceneStage], a ; $6320
.planeArrived:
	ld a, [wMapSceneStage2] ; $6323
	dec a ; $6326
	ld [wMapSceneStage2], a ; $6327
	call AdvancePlaneFrameCounter_14 ; $632a
	dec h ; $632d
	jr nz, .planeLoop2 ; $632e
	ld h, $08 ; $6330
.descend:
	script_wait_frames $04 ; $6332
	call PlayPlaneMoveSfx_14 ; $6339
	ld a, [wMapSceneStage] ; $633c
	inc a ; $633f
	ld [wMapSceneStage], a ; $6340
	ld a, [wMapSceneStage2] ; $6343
	dec a ; $6346
	ld [wMapSceneStage2], a ; $6347
	call AdvancePlaneFrameCounter_14 ; $634a
	dec h ; $634d
	jr nz, .descend ; $634e
	script_player_speed $0012 ; $6350
	script_move_player_to_actor ACTOR_PLAYER ; $6356
	ld h, $1c ; $635d
.land:
	script_wait_frames $03 ; $635f
	call PlayPlaneMoveSfx_14 ; $6366
	ld a, h ; $6369
	and $01 ; $636a
	jr z, .disembark ; $636c
	ld a, [wMapSceneStage] ; $636e
	inc a ; $6371
	ld [wMapSceneStage], a ; $6372
.disembark:
	ld a, [wMapSceneStage2] ; $6375
	dec a ; $6378
	ld [wMapSceneStage2], a ; $6379
	call AdvancePlaneFrameCounter_14 ; $637c
	dec h ; $637f
	jr nz, .land ; $6380
	ld h, $00 ; $6382
.walkOff:
	script_wait_frames $03 ; $6384
	inc h ; $638b
	call PlayPlaneMoveSfx_14 ; $638c
	ld a, [wMapSceneStage2] ; $638f
	dec a ; $6392
	ld [wMapSceneStage2], a ; $6393
	and $03 ; $6396
	cp $03 ; $6398
	jr nz, .speak ; $639a
	ld a, [wMapSceneStage] ; $639c
	inc a ; $639f
	ld [wMapSceneStage], a ; $63a0
.speak:
	call AdvancePlaneFrameCounter_14 ; $63a3
	ld a, [wMapSceneStage] ; $63a6
	cp $50 ; $63a9
	jr nz, .walkOff ; $63ab
	ld h, $08 ; $63ad
.speakDoubles:
	script_wait_frames $04 ; $63af
	call PlayPlaneMoveSfx_14 ; $63b6
	ld a, [wMapSceneStage2] ; $63b9
	dec a ; $63bc
	ld [wMapSceneStage2], a ; $63bd
	call AdvancePlaneFrameCounter_14 ; $63c0
	dec h ; $63c3
	jr nz, .speakDoubles ; $63c4
	ld h, $08 ; $63c6
.fadeOut:
	script_wait_frames $06 ; $63c8
	call PlayPlaneMoveSfx_14 ; $63cf
	ld a, [wMapSceneStage2] ; $63d2
	dec a ; $63d5
	ld [wMapSceneStage2], a ; $63d6
	call AdvancePlaneFrameCounter_14 ; $63d9
	dec h ; $63dc
	jr nz, .fadeOut ; $63dd
	ld h, $08 ; $63df
.done:
	script_wait_frames $08 ; $63e1
	call PlayPlaneMoveSfx_14 ; $63e8
	ld a, [wMapSceneStage2] ; $63eb
	dec a ; $63ee
	ld [wMapSceneStage2], a ; $63ef
	call AdvancePlaneFrameCounter_14 ; $63f2
	dec h ; $63f5
	jr nz, .done ; $63f6
	sound $7d ; $63f8
	script_wait_frames $32 ; $63fa
	ld c, $04 ; $6401
	call BeginFadeOut ; $6403
	call WaitFadeEnd ; $6406
	call ClearFrameTasks ; $6409
	ld a, STORYLOC_ACADEMY_ENTRANCE ; $640c
	ld [wStoryModeCurrentLocation], a ; $640e
	ld a, $02 ; $6411
	ld [wStoryModeEntryPoint], a ; $6413
	ld a, $ff ; $6416
	ld [wUnusedExitTriggerIdMirror], a ; $6418
	ld [wStoryModeExitTriggerRequest], a ; $641b
	ret ; $641e
AdvancePlaneFrameCounter_14:
	ld a, [wCutsceneObjX] ; $641f
	inc a ; $6422
	ld [wCutsceneObjX], a ; $6423
	ret ; $6426
LoadFireworkObjGfx_14:
	push_wram_bank $01 ; $6427
	ld hl, FireworkObjTiles_14 ; $6430
	ld de, $8100 ; $6433
	ld c, (SpriteTemplate_14_2 - FireworkObjTiles_14) / 16 ; $6436
	call QueueVRAMCopy ; $6438
	ld hl, FireworkObjPalettes_14 ; $643b
	ld de, $0904 ; $643e
	call LoadPaletteShadow ; $6441
	pop_wram_bank ; $6444
	ret ; $6449
UpdateFirework0_14:
	ld a, [wCutsceneObjPhase] ; $644a
	cp $04 ; $644d
	jp nc, .done ; $644f
	ld a, [wCutsceneObjPhase] ; $6452
	and a ; $6455
	jr nz, .draw ; $6456
	call AdvanceFirework0Ascent_14 ; $6458
.draw:
	ldh a, [hScrollX] ; $645b
	ld b, a ; $645d
	ld a, [wCutsceneObjX] ; $645e
	sub b ; $6461
	ld d, a ; $6462
	ldh a, [hScrollY] ; $6463
	ld b, a ; $6465
	ld a, [wCutsceneObjY] ; $6466
	sub b ; $6469
	ld e, a ; $646a
	ld a, [wCutsceneObjTimer] ; $646b
	dec a ; $646e
	ld [wCutsceneObjTimer], a ; $646f
	and a ; $6472
	jp nz, .burstSprite ; $6473
	ld a, [wCutsceneObjPhase] ; $6476
	inc a ; $6479
	ld [wCutsceneObjPhase], a ; $647a
	cp $04 ; $647d
	jp nc, .done ; $647f
	ld a, [wCutsceneObjPhase] ; $6482
	ld_hl_indexed Table_14 ; $6485
	ld a, [hl] ; $648c
	ld [wCutsceneObjTimer], a ; $648d
	ld a, [wCutsceneObjPhase] ; $6490
	cp $01 ; $6493
	jr nz, .burstSprite ; $6495
	ld a, [wCutsceneObjTimer] ; $6497
	cp $0c ; $649a
	jr nz, .burstSprite ; $649c
	sound SFX_FIREWORK ; $649e
.burstSprite:
	ld a, [wCutsceneObjPhase] ; $64a0
	ld_hl_indexed UpdateFirework0_14Table ; $64a3
	ld a, [hl] ; $64aa
	add $10 ; $64ab
	ld c, a ; $64ad
	ld a, [wCutsceneObjTimer] ; $64ae
	srl a ; $64b1
	and $03 ; $64b3
	inc a ; $64b5
	ld b, a ; $64b6
	ld hl, SpriteTemplate_14_2 ; $64b7
	call QueueSpriteTemplate ; $64ba
.done:
	ret ; $64bd
AdvanceFirework0Ascent_14:
	ld b, $03 ; $64be
	ld a, [wCutsceneObjTimer] ; $64c0
	cp $14 ; $64c3
	jr nc, .checkWaterSpriteMinigameTimer ; $64c5
	dec b ; $64c7
	cp $0a ; $64c8
	jr nc, .checkWaterSpriteMinigameTimer ; $64ca
	dec b ; $64cc
.checkWaterSpriteMinigameTimer:
	ld a, [wCutsceneObjY] ; $64cd
	sub b ; $64d0
	ld [wCutsceneObjY], a ; $64d1
	ret ; $64d4
Table_14:
	; $64d5, 4 bytes (bytes:4)
	db $00, $0c, $0e, $10 ; 0x00
UpdateFirework0_14Table:
	INCBIN "data/bank_014/d_64d9.bin" ; $64d9, 4 bytes
UpdateFirework1_14Table:
	INCBIN "data/bank_014/d_64dd.bin" ; $64dd, 4 bytes
.scriptRespawnLocationActors:
	ldh a, [hRomBank] ; $64e1
	ld hl, FireworkMapActors_14 ; $64e3
	farcall ScriptRespawnLocationActors ; $64e6
	farcall BeginCutsceneScriptMode ; $64e9
	call DisableLCDSafely ; $64ec
	call LoadFireworkObjGfx_14 ; $64ef
	call EnableLCD ; $64f2
	test_flag FLAG_DOUBLES ; $64f5
	jp z, .placeActors ; $64f8
	script_null_script ACTOR_PARTNER ; $64fb
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $6500
.placeActors:
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $650b
	xor a ; $6516
	ld [wStoryModeShowLocationName], a ; $6517
	script_fade_in $04 ; $651a
	call WaitFadeEnd ; $651f
	script_player_speed $0006 ; $6522
	script_move_player $0500, $2300 ; $6528
	farcall WaitPlayerMoveDone ; $6532
	script_wait_frames $32 ; $6535
	ld a, $50 ; $653c
	ld [wCutsceneObjX + 1], a ; $653e
	ld a, $28 ; $6541
	ld [wCutsceneObjY + 1], a ; $6543
	ld a, $00 ; $6546
	ld [wCutsceneObjPhase + 1], a ; $6548
	ld a, $1e ; $654b
	ld [wCutsceneObjTimer + 1], a ; $654d
	ld a, $01 ; $6550
	ld hl, UpdateFirework1_14 ; $6552
	call RegisterFrameTask ; $6555
	script_wait_frames $50 ; $6558
	ld a, $40 ; $655f
	ld [wCutsceneObjX], a ; $6561
	ld a, $20 ; $6564
	ld [wCutsceneObjY], a ; $6566
	ld a, $00 ; $6569
	ld [wCutsceneObjPhase], a ; $656b
	ld a, $1e ; $656e
	ld [wCutsceneObjTimer], a ; $6570
	ld a, $01 ; $6573
	ld hl, UpdateFirework0_14 ; $6575
	call RegisterFrameTask ; $6578
	script_wait_frames $50 ; $657b
	ld a, $48 ; $6582
	ld [wCutsceneObjX + 1], a ; $6584
	ld a, $28 ; $6587
	ld [wCutsceneObjY + 1], a ; $6589
	ld a, $00 ; $658c
	ld [wCutsceneObjPhase + 1], a ; $658e
	ld a, $1e ; $6591
	ld [wCutsceneObjTimer + 1], a ; $6593
	script_wait_frames $28 ; $6596
	ld a, $38 ; $659d
	ld [wCutsceneObjX], a ; $659f
	ld a, $20 ; $65a2
	ld [wCutsceneObjY], a ; $65a4
	ld a, $00 ; $65a7
	ld [wCutsceneObjPhase], a ; $65a9
	ld a, $1e ; $65ac
	ld [wCutsceneObjTimer], a ; $65ae
	script_wait_frames $28 ; $65b1
	ld a, $50 ; $65b8
	ld [wCutsceneObjX + 1], a ; $65ba
	ld a, $28 ; $65bd
	ld [wCutsceneObjY + 1], a ; $65bf
	ld a, $00 ; $65c2
	ld [wCutsceneObjPhase + 1], a ; $65c4
	ld a, $19 ; $65c7
	ld [wCutsceneObjTimer + 1], a ; $65c9
	script_wait_frames $28 ; $65cc
	ld a, $38 ; $65d3
	ld [wCutsceneObjX], a ; $65d5
	ld a, $20 ; $65d8
	ld [wCutsceneObjY], a ; $65da
	ld a, $00 ; $65dd
	ld [wCutsceneObjPhase], a ; $65df
	ld a, $1a ; $65e2
	ld [wCutsceneObjTimer], a ; $65e4
	script_wait_frames $28 ; $65e7
	ld a, $58 ; $65ee
	ld [wCutsceneObjX + 1], a ; $65f0
	ld a, $28 ; $65f3
	ld [wCutsceneObjY + 1], a ; $65f5
	ld a, $00 ; $65f8
	ld [wCutsceneObjPhase + 1], a ; $65fa
	ld a, $1c ; $65fd
	ld [wCutsceneObjTimer + 1], a ; $65ff
	script_wait_frames $28 ; $6602
	ld a, $40 ; $6609
	ld [wCutsceneObjX], a ; $660b
	ld a, $20 ; $660e
	ld [wCutsceneObjY], a ; $6610
	ld a, $00 ; $6613
	ld [wCutsceneObjPhase], a ; $6615
	ld a, $16 ; $6618
	ld [wCutsceneObjTimer], a ; $661a
	script_wait_frames $32 ; $661d
	ld a, $48 ; $6624
	ld [wCutsceneObjX + 1], a ; $6626
	ld a, $28 ; $6629
	ld [wCutsceneObjY + 1], a ; $662b
	ld a, $00 ; $662e
	ld [wCutsceneObjPhase + 1], a ; $6630
	ld a, $1c ; $6633
	ld [wCutsceneObjTimer + 1], a ; $6635
	script_wait_frames $48 ; $6638
	ld c, $04 ; $663f
	call BeginFadeOut ; $6641
	call WaitFadeEnd ; $6644
	call ClearFrameTasks ; $6647
	test_flag FLAG_DOUBLES ; $664a
	jr z, .notDoubles ; $664d
	ld a, STORYLOC_AWARDS_CEREMONY ; $664f
	ld [wStoryModeCurrentLocation], a ; $6651
	ld a, $0b ; $6654
	ld [wStoryModeEntryPoint], a ; $6656
	ld a, $ff ; $6659
	ld [wUnusedExitTriggerIdMirror], a ; $665b
	ld [wStoryModeExitTriggerRequest], a ; $665e
	ret ; $6661
.notDoubles:
	ld a, STORYLOC_AWARDS_CEREMONY ; $6662
	ld [wStoryModeCurrentLocation], a ; $6664
	ld a, $0a ; $6667
	ld [wStoryModeEntryPoint], a ; $6669
	ld a, $ff ; $666c
	ld [wUnusedExitTriggerIdMirror], a ; $666e
	ld [wStoryModeExitTriggerRequest], a ; $6671
	ret ; $6674
FireworkMapActors_14:
	; $6675, 11 bytes (map_actors)
	map_actor_end
	db $00
FireworkObjTiles_14:
	INCBIN "data/bank_014/d_6680.bin" ; $6680, 2048 bytes
SpriteTemplate_14_2:
	; $6e80, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite_end
FireworkObjPalettes_14:
	INCLUDE "data/bank_014/palettes_6ea1.asm" ; $6ea1, 32 bytes (palettes)
; Sits after FireworkObjPalettes_14's four palettes, unreferenced: when hInputRisingEdge bit 1 is newly pressed it resets both cutscene firework objects -- X $40/$68, Y $30/$38, phase 0, timer $1e each -- and returns. Nothing calls or jumps to it; UpdateFirework1_14, which follows, is the live routine.
Unused_14_ResetFireworkObjOnButton:
	ldh a, [hInputRisingEdge] ; $6ec1
	and $02 ; $6ec3
	jr z, .done ; $6ec5
	ld a, $40 ; $6ec7
	ld [wCutsceneObjX], a ; $6ec9
	ld a, $30 ; $6ecc
	ld [wCutsceneObjY], a ; $6ece
	ld a, $00 ; $6ed1
	ld [wCutsceneObjPhase], a ; $6ed3
	ld a, $1e ; $6ed6
	ld [wCutsceneObjTimer], a ; $6ed8
	ld a, $68 ; $6edb
	ld [wCutsceneObjX + 1], a ; $6edd
	ld a, $38 ; $6ee0
	ld [wCutsceneObjY + 1], a ; $6ee2
	ld a, $00 ; $6ee5
	ld [wCutsceneObjPhase + 1], a ; $6ee7
	ld a, $1e ; $6eea
	ld [wCutsceneObjTimer + 1], a ; $6eec
.done:
	ret ; $6eef
UpdateFirework1_14:
	ld a, [wCutsceneObjPhase + 1] ; $6ef0
	cp $04 ; $6ef3
	jp nc, .done ; $6ef5
	ld a, [wCutsceneObjPhase + 1] ; $6ef8
	and a ; $6efb
	jr nz, .draw ; $6efc
	call AdvanceFirework1Ascent_14 ; $6efe
.draw:
	ldh a, [hScrollX] ; $6f01
	ld b, a ; $6f03
	ld a, [wCutsceneObjX + 1] ; $6f04
	sub b ; $6f07
	ld d, a ; $6f08
	ldh a, [hScrollY] ; $6f09
	ld b, a ; $6f0b
	ld a, [wCutsceneObjY + 1] ; $6f0c
	sub b ; $6f0f
	ld e, a ; $6f10
	ld a, [wCutsceneObjTimer + 1] ; $6f11
	dec a ; $6f14
	ld [wCutsceneObjTimer + 1], a ; $6f15
	and a ; $6f18
	jp nz, .burstSprite ; $6f19
	ld a, [wCutsceneObjPhase + 1] ; $6f1c
	inc a ; $6f1f
	ld [wCutsceneObjPhase + 1], a ; $6f20
	cp $04 ; $6f23
	jp nc, .done ; $6f25
	ld a, [wCutsceneObjPhase + 1] ; $6f28
	ld_hl_indexed Table_14 ; $6f2b
	ld a, [hl] ; $6f32
	ld [wCutsceneObjTimer + 1], a ; $6f33
	ld a, [wCutsceneObjPhase + 1] ; $6f36
	cp $01 ; $6f39
	jr nz, .burstSprite ; $6f3b
	ld a, [wCutsceneObjTimer + 1] ; $6f3d
	cp $0c ; $6f40
	jr nz, .burstSprite ; $6f42
	sound SFX_FIREWORK ; $6f44
.burstSprite:
	ld a, [wCutsceneObjPhase + 1] ; $6f46
	ld_hl_indexed UpdateFirework1_14Table ; $6f49
	ld a, [hl] ; $6f50
	add $10 ; $6f51
	ld c, a ; $6f53
	ld a, [wCutsceneObjTimer + 1] ; $6f54
	srl a ; $6f57
	and $03 ; $6f59
	inc a ; $6f5b
	ld b, a ; $6f5c
	ld hl, SpriteTemplate_14_2 ; $6f5d
	call QueueSpriteTemplate ; $6f60
.done:
	ret ; $6f63
AdvanceFirework1Ascent_14:
	ld b, $03 ; $6f64
	ld a, [wCutsceneObjTimer + 1] ; $6f66
	cp $14 ; $6f69
	jr nc, .store ; $6f6b
	dec b ; $6f6d
	cp $0a ; $6f6e
	jr nc, .store ; $6f70
	dec b ; $6f72
.store:
	ld a, [wCutsceneObjY + 1] ; $6f73
	sub b ; $6f76
	ld [wCutsceneObjY + 1], a ; $6f77
	ret ; $6f7a
.loadScene:
	call DisableLCDSafely ; $6f7b
	call LoadPlaneObjGfx_14 ; $6f7e
	call LoadIslandSkyEffectObjGfx_14 ; $6f81
	call EnableLCD ; $6f84
	ld a, $50 ; $6f87
	ld [wMapSceneStage], a ; $6f89
	ld a, $88 ; $6f8c
	ld [wMapSceneStage2], a ; $6f8e
	ld a, $01 ; $6f91
	ld hl, QueuePlaneSpriteByHeight_14 ; $6f93
	call RegisterFrameTask ; $6f96
	ld a, $00 ; $6f99
	ld [wCutsceneObjLimit], a ; $6f9b
	ld [wCutsceneObjLimit + 1], a ; $6f9e
	ld [wCutsceneObjActive], a ; $6fa1
	ld a, $01 ; $6fa4
	ld hl, AnimateIslandSkyEffectSprites_14 ; $6fa6
	call RegisterFrameTask ; $6fa9
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $6fac
	test_flag FLAG_DOUBLES ; $6fb7
	jp z, .fadeIn ; $6fba
	script_null_script ACTOR_PARTNER ; $6fbd
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $6fc2
.fadeIn:
	xor a ; $6fcd
	ld [wStoryModeShowLocationName], a ; $6fce
	script_fade_in $06 ; $6fd1
	call WaitFadeEnd ; $6fd6
	sound $7a ; $6fd9
	script_wait_frames $3c ; $6fdb
	ld h, $08 ; $6fe2
.planeLoop:
	script_wait_frames $06 ; $6fe4
	call PlayPlaneMoveSfx_14 ; $6feb
	ld a, [wMapSceneStage2] ; $6fee
	inc a ; $6ff1
	ld [wMapSceneStage2], a ; $6ff2
	dec h ; $6ff5
	jr nz, .planeLoop ; $6ff6
	ld h, $08 ; $6ff8
.planeArrived:
	script_wait_frames $04 ; $6ffa
	call PlayPlaneMoveSfx_14 ; $7001
	ld a, [wMapSceneStage2] ; $7004
	inc a ; $7007
	ld [wMapSceneStage2], a ; $7008
	and $01 ; $700b
	ld b, a ; $700d
	ld a, [wMapSceneStage] ; $700e
	add b ; $7011
	ld [wMapSceneStage], a ; $7012
	dec h ; $7015
	jr nz, .planeArrived ; $7016
	ld h, $18 ; $7018
.descend:
	script_wait_frames $03 ; $701a
	call PlayPlaneMoveSfx_14 ; $7021
	ld a, [wMapSceneStage2] ; $7024
	inc a ; $7027
	ld [wMapSceneStage2], a ; $7028
	ld a, [wMapSceneStage] ; $702b
	inc a ; $702e
	ld [wMapSceneStage], a ; $702f
	dec h ; $7032
	jr nz, .descend ; $7033
	script_player_speed $0012 ; $7035
	script_move_player $0b00, $1800 ; $703b
	ld h, $18 ; $7045
.land:
	script_wait_frames $02 ; $7047
	call PlayPlaneMoveSfx_14 ; $704e
	ld a, [wMapSceneStage] ; $7051
	inc a ; $7054
	ld [wMapSceneStage], a ; $7055
	and $01 ; $7058
	ld b, a ; $705a
	ld a, [wMapSceneStage2] ; $705b
	add b ; $705e
	ld [wMapSceneStage2], a ; $705f
	dec h ; $7062
	jr nz, .land ; $7063
	ld h, $20 ; $7065
.disembark:
	script_wait_frames $02 ; $7067
	call PlayPlaneMoveSfx_14 ; $706e
	ld a, [wMapSceneStage] ; $7071
	inc a ; $7074
	ld [wMapSceneStage], a ; $7075
	and $03 ; $7078
	cp $03 ; $707a
	jr nz, .walkOff ; $707c
	ld a, [wMapSceneStage2] ; $707e
	inc a ; $7081
	ld [wMapSceneStage2], a ; $7082
.walkOff:
	dec h ; $7085
	jr nz, .disembark ; $7086
	ld hl, QueuePlaneSpriteByHeight_14 ; $7088
	call UnregisterFrameTask ; $708b
	ld h, $1e ; $708e
.doublesWalkOff:
	script_wait_frames $02 ; $7090
	call PlayPlaneMoveSfx_14 ; $7097
	dec h ; $709a
	jr nz, .doublesWalkOff ; $709b
	script_move_player $0b00, $0d00 ; $709d
	call LoadDistantPlaneObjGfx_14 ; $70a7
	ld a, $04 ; $70aa
	ld [wCutsceneObjPhase], a ; $70ac
	ld a, $a8 ; $70af
	ld [wMapSceneStage2], a ; $70b1
	ld a, $01 ; $70b4
	ld hl, QueueDistantPlaneSprite_14 ; $70b6
	call RegisterFrameTask ; $70b9
	ld h, $50 ; $70bc
.speak:
	script_wait_frames $02 ; $70be
	call PlayPlaneMoveSfx_14 ; $70c5
	ld a, [wMapSceneStage2] ; $70c8
	dec a ; $70cb
	ld [wMapSceneStage2], a ; $70cc
	ld a, [wMapSceneStage] ; $70cf
	dec a ; $70d2
	ld [wMapSceneStage], a ; $70d3
	ld a, h ; $70d6
	cp $1e ; $70d7
	jr nz, .speakDoubles ; $70d9
	ld a, $00 ; $70db
	ld [wCutsceneObjPhase], a ; $70dd
.speakDoubles:
	dec h ; $70e0
	jr nz, .speak ; $70e1
	ld hl, QueueDistantPlaneSprite_14 ; $70e3
	call UnregisterFrameTask ; $70e6
	call LoadTwinkleObjGfx_14 ; $70e9
	call PlayTwinkleAnimation_14 ; $70ec
	script_wait_frames $46 ; $70ef
	ld a, [wStoryModeEntryPoint] ; $70f6
	cp $0d ; $70f9
	jp nz, .fadeOut ; $70fb
	ld a, $01 ; $70fe
	ld [wCutsceneObjActive], a ; $7100
	ld a, $01 ; $7103
	ld [wUnusedExitTriggerIdMirror], a ; $7105
	ld [wStoryModeExitTriggerRequest], a ; $7108
	ret ; $710b
.fadeOut:
	test_flag FLAG_DOUBLES ; $710c
	jp z, .transition ; $710f
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7112
	jr nz, .doublesLocation ; $7115
	set_flag FLAG_STORY_COMPLETE_DOUBLES ; $7117
	jr .setLocation ; $711a
.transition:
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $711c
	jr nz, .storeLocation ; $711f
	set_flag FLAG_STORY_COMPLETE_SINGLES ; $7121
.setLocation:
	ld b, STORYLOC_PEACHS_CASTLE ; $7124
	ld c, $0f ; $7126
	farcall SaveStoryReturnPoint ; $7128
	farcall SaveStorySlotWithTimer ; $712b
	ld c, $01 ; $712e
	call BeginFadeOut ; $7130
	call WaitFadeEnd ; $7133
	ld a, STORYLOC_MAIN_MENU ; $7136
	ld [wStoryModeCurrentLocation], a ; $7138
	ld a, $0a ; $713b
	ld [wStoryModeEntryPoint], a ; $713d
	ld a, $ff ; $7140
	ld [wUnusedExitTriggerIdMirror], a ; $7142
	ld [wStoryModeExitTriggerRequest], a ; $7145
	ret ; $7148
.doublesLocation:
	test_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $7149
	jr z, .done ; $714c
	jr .finish ; $714e
.storeLocation:
	test_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $7150
	jr z, .done ; $7153
.finish:
	ld c, $04 ; $7155
	call BeginFadeOut ; $7157
	call WaitFadeEnd ; $715a
	ld a, STORYLOC_PEACHS_CASTLE ; $715d
	ld [wStoryModeCurrentLocation], a ; $715f
	ld a, $01 ; $7162
	ld [wStoryModeEntryPoint], a ; $7164
	ld a, $ff ; $7167
	ld [wUnusedExitTriggerIdMirror], a ; $7169
	ld [wStoryModeExitTriggerRequest], a ; $716c
	ret ; $716f
.done:
	ld c, $04 ; $7170
	call BeginFadeOut ; $7172
	call WaitFadeEnd ; $7175
	ld a, STORYLOC_PEACHS_CASTLE ; $7178
	ld [wStoryModeCurrentLocation], a ; $717a
	ld a, $0f ; $717d
	ld [wStoryModeEntryPoint], a ; $717f
	ld a, $ff ; $7182
	ld [wUnusedExitTriggerIdMirror], a ; $7184
	ld [wStoryModeExitTriggerRequest], a ; $7187
	ret ; $718a
	; $718b, 5 bytes (fill)
	ds 5, $00
IslandSkyTilesA_14:
	INCBIN "data/bank_014/d_7190.bin" ; $7190, 256 bytes
IslandSkyTilesB_14:
	INCBIN "data/bank_014/d_7290.bin" ; $7290, 192 bytes
IslandSkySpriteData_14:
	INCBIN "data/bank_014/d_7350.bin" ; $7350, 33 bytes
AnimateIslandSkyEffectSprites_14_SpriteTemplate:
	; $7371, 25 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite_end
IslandSkyPalettes_14:
	INCLUDE "data/bank_014/palettes_738a.asm" ; $738a, 32 bytes (palettes)
LoadIslandSkyEffectObjGfx_14:
	push_wram_bank $01 ; $73aa
	ld hl, IslandSkyTilesA_14 ; $73b3
	ld de, $8100 ; $73b6
	ld c, $40 ; $73b9
	call QueueVRAMCopy ; $73bb
	ld hl, IslandSkyTilesB_14 ; $73be
	ld de, $8200 ; $73c1
	ld c, $30 ; $73c4
	call QueueVRAMCopy ; $73c6
	ld hl, IslandSkyPalettes_14 ; $73c9
	ld de, $0903 ; $73cc
	call LoadPaletteShadow ; $73cf
	pop_wram_bank ; $73d2
	ret ; $73d7
AnimateIslandSkyEffectSprites_14:
	ldh a, [hScrollX] ; $73d8
	ld b, a ; $73da
	ld a, $40 ; $73db
	sub b ; $73dd
	ld d, a ; $73de
	ldh a, [hScrollY] ; $73df
	ld b, a ; $73e1
	ld a, $40 ; $73e2
	sub b ; $73e4
	ld e, a ; $73e5
	ld c, $10 ; $73e6
	ld hl, IslandSkySpriteData_14 ; $73e8
	ld a, [wCutsceneObjActive] ; $73eb
	and a ; $73ee
	jr nz, .nonZero ; $73ef
	ld a, [wCutsceneObjLimit] ; $73f1
	inc a ; $73f4
	ld [wCutsceneObjLimit], a ; $73f5
.nonZero:
	ld a, [wCutsceneObjLimit] ; $73f8
	swap a ; $73fb
	and $03 ; $73fd
	cp $03 ; $73ff
	jr nz, .ne03 ; $7401
	ld a, $00 ; $7403
	ld [wCutsceneObjLimit], a ; $7405
.ne03:
	inc a ; $7408
	ld b, a ; $7409
	call QueueSpriteTemplate ; $740a
	ldh a, [hScrollX] ; $740d
	ld b, a ; $740f
	ld a, $68 ; $7410
	sub b ; $7412
	ld d, a ; $7413
	ldh a, [hScrollY] ; $7414
	ld b, a ; $7416
	ld a, $50 ; $7417
	sub b ; $7419
	ld e, a ; $741a
	ld c, $20 ; $741b
	ld hl, AnimateIslandSkyEffectSprites_14_SpriteTemplate ; $741d
	ld a, [wCutsceneObjLimit] ; $7420
	swap a ; $7423
	and $03 ; $7425
	inc a ; $7427
	ld b, a ; $7428
	call QueueSpriteTemplate ; $7429
	ret ; $742c
	; $742d, 3 bytes (fill)
	ds 3, $00
DistantPlaneObjGfx:
	INCBIN "data/bank_014/d_7430.bin" ; $7430, 256 bytes
SpriteTemplate_14_3:
	; $7530, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadDistantPlaneObjGfx_14:
	push_wram_bank $01 ; $7539
	ld hl, DistantPlaneObjGfx ; $7542
	ld de, $8000 + VRAM_BANK1 ; $7545
	ld c, (SpriteTemplate_14_3 - DistantPlaneObjGfx) / 16 ; $7548
	call QueueVRAMCopy ; $754a
	ld hl, IslandObjPalette_14 ; $754d
	ld de, $0801 ; $7550
	call LoadPaletteShadow ; $7553
	pop_wram_bank ; $7556
	ret ; $755b
QueueDistantPlaneSprite_14:
	call GetSceneObjectScreenPos_14 ; $755c
	ld a, [wCutsceneObjPhase] ; $755f
	ld c, a ; $7562
	ld c, a ; $7563
	ld hl, SpriteTemplate_14_3 ; $7564
	ld b, $08 ; $7567
	call QueueSpriteTemplate ; $7569
	ret ; $756c
GetSceneObjectScreenPos_14:
	ldh a, [hScrollX] ; $756d
	ld b, a ; $756f
	ld a, [wMapSceneStage] ; $7570
	sub b ; $7573
	ld d, a ; $7574
	ldh a, [hScrollY] ; $7575
	ld b, a ; $7577
	ld a, [wMapSceneStage2] ; $7578
	sub b ; $757b
	ld e, a ; $757c
	ret ; $757d
	; $757e, 2 bytes (fill)
	ds 2, $00
TwinkleObjGfx:
	INCBIN "data/bank_014/d_7580.bin" ; $7580, 256 bytes
TwinkleObjPalette_14:
	INCLUDE "data/bank_014/palettes_7680.asm" ; $7680, 8 bytes (palettes)
LoadTwinkleObjGfx_14:
	push_wram_bank $01 ; $7688
	ld hl, TwinkleObjGfx ; $7691
	ld de, $8000 + VRAM_BANK1 ; $7694
	ld c, (TwinkleObjPalette_14 - TwinkleObjGfx) / 16 ; $7697
	call QueueVRAMCopy ; $7699
	ld hl, TwinkleObjPalette_14 ; $769c
	ld de, $0801 ; $769f
	call LoadPaletteShadow ; $76a2
	pop_wram_bank ; $76a5
	ret ; $76aa
QueueTwinkleSprite_14:
	ldh a, [hScrollX] ; $76ab
	ld b, a ; $76ad
	ld a, $54 ; $76ae
	sub b ; $76b0
	ld d, a ; $76b1
	ldh a, [hScrollY] ; $76b2
	ld b, a ; $76b4
	ld a, $58 ; $76b5
	sub b ; $76b7
	ld e, a ; $76b8
	ld a, [wCutsceneObjPhase] ; $76b9
	ld c, a ; $76bc
	ld hl, SpriteTemplate_14_3 ; $76bd
	ld b, $08 ; $76c0
	call QueueSpriteTemplate ; $76c2
	ret ; $76c5
.queue:
	call DisableLCDSafely ; $76c6
	call LoadIslandSkyEffectObjGfx_14 ; $76c9
	call LoadTwinkleObjGfx_14 ; $76cc
	call EnableLCD ; $76cf
	ld a, $00 ; $76d2
	ld [wCutsceneObjLimit], a ; $76d4
	ld [wCutsceneObjLimit + 1], a ; $76d7
	ld a, $01 ; $76da
	ld hl, AnimateIslandSkyEffectSprites_14 ; $76dc
	call RegisterFrameTask ; $76df
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $76e2
	test_flag FLAG_DOUBLES ; $76ed
	jp z, .loadScene ; $76f0
	script_null_script ACTOR_PARTNER ; $76f3
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $76f8
.loadScene:
	xor a ; $7703
	ld [wStoryModeShowLocationName], a ; $7704
	script_fade_in $06 ; $7707
	call WaitFadeEnd ; $770c
	script_wait_frames $3c ; $770f
	call PlayTwinkleAnimation_14 ; $7716
	script_wait_frames $1e ; $7719
	call LoadDistantPlaneObjGfx_14 ; $7720
	ld a, $08 ; $7723
	ld [wCutsceneObjPhase], a ; $7725
	ld a, $54 ; $7728
	ld [wMapSceneStage], a ; $772a
	ld a, $58 ; $772d
	ld [wMapSceneStage2], a ; $772f
	ld a, $01 ; $7732
	ld hl, QueueDistantPlaneSprite_14 ; $7734
	call RegisterFrameTask ; $7737
	ld h, $4b ; $773a
.fadeIn:
	script_wait_frames $02 ; $773c
	call PlayPlaneMoveSfx_14 ; $7743
	ld a, [wMapSceneStage2] ; $7746
	inc a ; $7749
	ld [wMapSceneStage2], a ; $774a
	ld a, [wMapSceneStage] ; $774d
	inc a ; $7750
	ld [wMapSceneStage], a ; $7751
	ld a, h ; $7754
	cp $2d ; $7755
	jr nz, .fireworkLoop ; $7757
	ld a, $0c ; $7759
	ld [wCutsceneObjPhase], a ; $775b
.fireworkLoop:
	dec h ; $775e
	jr nz, .fadeIn ; $775f
	ld hl, QueueDistantPlaneSprite_14 ; $7761
	call UnregisterFrameTask ; $7764
	script_player_speed $0012 ; $7767
	script_move_player $0b00, $1800 ; $776d
	ld h, $3c ; $7777
.burst:
	script_wait_frames $02 ; $7779
	call PlayPlaneMoveSfx_14 ; $7780
	dec h ; $7783
	jr nz, .burst ; $7784
	call LoadPlaneObjGfx2_14 ; $7786
	ld a, $a4 ; $7789
	ld [wMapSceneStage], a ; $778b
	ld a, $c6 ; $778e
	ld [wMapSceneStage2], a ; $7790
	ld a, $3c ; $7793
	ld [wCutsceneObjX], a ; $7795
	ld a, $01 ; $7798
	ld hl, QueuePlaneSpriteByFrameCounter_14 ; $779a
	call RegisterFrameTask ; $779d
	ld h, $20 ; $77a0
.nextBurst:
	script_wait_frames $02 ; $77a2
	call PlayPlaneMoveSfx_14 ; $77a9
	ld a, [wMapSceneStage] ; $77ac
	dec a ; $77af
	ld [wMapSceneStage], a ; $77b0
	and $03 ; $77b3
	cp $03 ; $77b5
	jr nz, .finale ; $77b7
	ld a, [wMapSceneStage2] ; $77b9
	dec a ; $77bc
	ld [wMapSceneStage2], a ; $77bd
.finale:
	call AdvancePlaneFrameCounter2_14 ; $77c0
	dec h ; $77c3
	jr nz, .nextBurst ; $77c4
	ld h, $18 ; $77c6
.finaleLoop:
	script_wait_frames $02 ; $77c8
	call PlayPlaneMoveSfx_14 ; $77cf
	ld a, [wMapSceneStage] ; $77d2
	dec a ; $77d5
	ld [wMapSceneStage], a ; $77d6
	and $01 ; $77d9
	ld b, a ; $77db
	ld a, [wMapSceneStage2] ; $77dc
	sub b ; $77df
	ld [wMapSceneStage2], a ; $77e0
	call AdvancePlaneFrameCounter2_14 ; $77e3
	dec h ; $77e6
	jr nz, .finaleLoop ; $77e7
	script_move_player $0b00, $1200 ; $77e9
	ld h, $18 ; $77f3
.speak:
	script_wait_frames $03 ; $77f5
	call PlayPlaneMoveSfx_14 ; $77fc
	ld a, [wMapSceneStage2] ; $77ff
	dec a ; $7802
	ld [wMapSceneStage2], a ; $7803
	ld a, [wMapSceneStage] ; $7806
	dec a ; $7809
	ld [wMapSceneStage], a ; $780a
	call AdvancePlaneFrameCounter2_14 ; $780d
	dec h ; $7810
	jr nz, .speak ; $7811
	ld h, $08 ; $7813
.fadeOut:
	script_wait_frames $04 ; $7815
	call PlayPlaneMoveSfx_14 ; $781c
	ld a, [wMapSceneStage2] ; $781f
	dec a ; $7822
	ld [wMapSceneStage2], a ; $7823
	and $01 ; $7826
	ld b, a ; $7828
	ld a, [wMapSceneStage] ; $7829
	sub b ; $782c
	ld [wMapSceneStage], a ; $782d
	call AdvancePlaneFrameCounter2_14 ; $7830
	dec h ; $7833
	jr nz, .fadeOut ; $7834
	ld h, $0c ; $7836
.done:
	script_wait_frames $06 ; $7838
	call PlayPlaneMoveSfx_14 ; $783f
	ld a, [wMapSceneStage2] ; $7842
	dec a ; $7845
	ld [wMapSceneStage2], a ; $7846
	call AdvancePlaneFrameCounter2_14 ; $7849
	dec h ; $784c
	jr nz, .done ; $784d
	sound $7d ; $784f
	script_wait_frames $46 ; $7851
	ld c, $04 ; $7858
	call BeginFadeOut ; $785a
	call WaitFadeEnd ; $785d
	ld a, STORYLOC_ACADEMY_ENTRANCE ; $7860
	ld [wStoryModeCurrentLocation], a ; $7862
	ld a, $02 ; $7865
	ld [wStoryModeEntryPoint], a ; $7867
	ld a, $ff ; $786a
	ld [wUnusedExitTriggerIdMirror], a ; $786c
	ld [wStoryModeExitTriggerRequest], a ; $786f
	ret ; $7872
AdvancePlaneFrameCounter2_14:
	ld a, [wCutsceneObjX] ; $7873
	inc a ; $7876
	ld [wCutsceneObjX], a ; $7877
	ret ; $787a
PlayTwinkleAnimation_14:
	xor a ; $787b
	ld [wCutsceneObjPhase], a ; $787c
	call AdvanceFrame ; $787f
	ld a, $01 ; $7882
	ld hl, QueueTwinkleSprite_14 ; $7884
	call RegisterFrameTask ; $7887
	sound SFX_TWINKLE ; $788a
	ld h, $04 ; $788c
.loop:
	script_wait_frames $04 ; $788e
	ld a, [wCutsceneObjPhase] ; $7895
	add $04 ; $7898
	ld [wCutsceneObjPhase], a ; $789a
	dec h ; $789d
	jr nz, .loop ; $789e
	ld hl, QueueTwinkleSprite_14 ; $78a0
	call UnregisterFrameTask ; $78a3
	ret ; $78a6
PlayPlaneMoveSfx_14:
	ld a, h ; $78a7
	srl a ; $78a8
	and $01 ; $78aa
	jr z, .done ; $78ac
	sound SFX_PLANE ; $78ae
.done:
	ret ; $78b0
ActorScript_14_2:
	; $78b1, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_14_3:
	; $78bb, 30 bytes (actor_script)
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
MapScriptNop_14:
	ret ; $78d9
MapScriptClearActiveFlag_14:
	xor a ; $78da
	ld [wStoryScriptRan], a ; $78db
	ret ; $78de
MapScriptPlaySoundA2_14:
	sound $a2 ; $78df
	ret ; $78e1
MapScriptHideLocationName_14:
	xor a ; $78e2
	ld [wStoryModeShowLocationName], a ; $78e3
	ret ; $78e6
ActorScript_14_4:
	; $78e7, 438 bytes (actor_script)
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
	as_jump ActorScript_14_4
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
.L19a:
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump .L19a
.L1a7:
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump .L1a7
ComputeRankingProgressIndex_14:
	test_flag FLAG_DOUBLES ; $7a9d
	jr nz, .isDoubles ; $7aa0
	ld a, STORYRANK_SINGLES_ACADEMY ; $7aa2
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7aa4
	jr z, .loop ; $7aa7
	ld a, STORYRANK_SINGLES_JUNIOR_CHAMP ; $7aa9
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7aab
	jr z, .loop ; $7aae
	ld a, STORYRANK_SINGLES_SENIOR_CHAMP ; $7ab0
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7ab2
	jr z, .loop ; $7ab5
	ld a, STORYRANK_SINGLES_ISLAND_OPEN ; $7ab7
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7ab9
	jr z, .loop ; $7abc
	ld a, STORYRANK_SINGLES_COMPLETE ; $7abe
.loop:
	ld [wMapSceneStage], a ; $7ac0
	ret ; $7ac3
.isDoubles:
	ld a, STORYRANK_DOUBLES_ACADEMY ; $7ac4
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7ac6
	jr z, .loop ; $7ac9
	ld a, STORYRANK_DOUBLES_JUNIOR_CHAMP ; $7acb
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7acd
	jr z, .loop ; $7ad0
	ld a, STORYRANK_DOUBLES_SENIOR_CHAMP ; $7ad2
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7ad4
	jr z, .loop ; $7ad7
	ld a, STORYRANK_DOUBLES_ISLAND_OPEN ; $7ad9
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7adb
	jr z, .loop ; $7ade
	ld a, STORYRANK_DOUBLES_COMPLETE ; $7ae0
	jr .loop ; $7ae2
; This bank's copy of ComputeStoryRankTier_13, identical instruction for instruction: the shared story include carried it into every story bank, and only bank $13's copy is called (by SetStoryRankTier). Nothing calls this one.
Unused_14_ComputeStoryRankTier:
	ld a, $00 ; $7ae4
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7ae6
	jr z, .loopB ; $7ae9
	inc a ; $7aeb
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7aec
	jr z, .loopB ; $7aef
	inc a ; $7af1
	test_flag FLAG_DOUBLES ; $7af2
	jr nz, .checkFlag ; $7af5
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7af7
	jr z, .loopB ; $7afa
	inc a ; $7afc
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7afd
	jr z, .loopB ; $7b00
	inc a ; $7b02
.loopB:
	ld [wMapSceneStage], a ; $7b03
	ret ; $7b06
.checkFlag:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7b07
	jr z, .loopB ; $7b0a
	inc a ; $7b0c
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7b0d
	jr z, .loopB ; $7b10
	inc a ; $7b12
	jr .loopB ; $7b13
	; $7b15, 1259 bytes fill to bank end (linker-padded)

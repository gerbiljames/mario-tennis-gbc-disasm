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
	map_actor $0000, ActorScript_14_78b1, $2b00, $3300, FACE_RIGHT, $3d, $01, $00
	map_actor $0000, ActorScript_14_78b1, $2b00, $3100, FACE_RIGHT, $3d, $01, $00
	map_actor $0000, ActorScript_14_78b1, $2d00, $2b00, FACE_LEFT, $3e, $01, $00
	map_actor_end
TennisMachineRoomEntryPoints_14:
	; $404a, 25 bytes (map_entries)
	map_entry $01, FACE_UP, $2b00, $3900, TennisMachineRoomArrival01_14
	map_entry $05, FACE_UP, $3800, $3600, $0000
	map_entry $07, FACE_UP, $3800, $3600, $0000
	db $ff
TennisMachineRoomArrival01_14:
	ld a, [wStoryModeEntryPoint] ; $4063
	cp a, $ff ; $4066
	jp z, Label_14_4085 ; $4068
	clear_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $406b
	test_flag FLAG_DOUBLES ; $406e
	jr z, Label_14_4085 ; $4071
	script_set_position ACTOR_PARTNER, $2b00, $3b00 ; $4073
	script_face ACTOR_PARTNER, FACE_UP ; $407e
Label_14_4085:
	ret ; $4085
TennisMachineRoomExitTriggers_14:
	; $4086, 9 bytes (map_scripts)
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_14, $11, $03
	db $ff
TennisMachineRoomNpc03_14:
	ld a, [$c2b0] ; $408f
	add a, a ; $4092
	add a, $a6 ; $4093
	ld l, a ; $4095
	adc a, $40 ; $4096
	sub a, l ; $4098
	ld h, a ; $4099
	ld a, [hl+] ; $409a
	ld h, [hl] ; $409b
	ld l, a ; $409c
	farcall InitDialogueTextCursor ; $409d
	script_speak $03 ; $40a0
	ret ; $40a5
	; $40a6, 14 bytes (records:2)
	dw $20a7 ; record 0
	dw $20b0 ; record 1
	dw $20b9 ; record 2
	dw $20c0 ; record 3
	dw $20c7 ; record 4
	dw $20cf ; record 5
	dw $20d6 ; record 6
TennisMachineRoomNpc04_14:
	ld a, [$c2b0] ; $40b4
	add a, a ; $40b7
	add a, $ec ; $40b8
	ld l, a ; $40ba
	adc a, $40 ; $40bb
	sub a, l ; $40bd
	ld h, a ; $40be
	ld a, [hl+] ; $40bf
	ld h, [hl] ; $40c0
	ld l, a ; $40c1
	farcall InitDialogueTextCursor ; $40c2
	ld a, [$c2b0] ; $40c5
	cp a, $01 ; $40c8
	jr z, Label_14_40ce ; $40ca
	jr Label_14_40e6 ; $40cc
Label_14_40ce:
	ld a, $04 ; $40ce
	farcall ScriptShowSpeakerDialogueRestoreBG ; $40d0
	farcall RunDialogueYesNoPrompt ; $40d3
	farcall ScriptCloseDialogueWindow ; $40d6
	script_wait_frames $05 ; $40d9
	and a, a ; $40e0
	jr z, Label_14_40e6 ; $40e1
	farcall AdvanceDialogueTextCursor ; $40e3
Label_14_40e6:
	script_speak $04 ; $40e6
	ret ; $40eb
	; $40ec, 14 bytes (records:2)
	dw $20a8 ; record 0
	dw $20b1 ; record 1
	dw $20ba ; record 2
	dw $20c1 ; record 3
	dw $20c8 ; record 4
	dw $20d0 ; record 5
	dw $20d7 ; record 6
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
	ld de, $d000 ; $4140
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
	ld de, $d000 ; $4175
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
	ld de, $d000 ; $41aa
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
	ld de, $d000 ; $41df
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
	ld de, $d000 ; $4269
	farcall AttachActorStepMover ; $426c
	ret ; $426f
	; $4270, 8 bytes (bytes:16)
	db $12, $13, $14, $15, $1a, $1a, $1a, $1a ; 0x00
TennisMachineRoomInitScript_14:
	ld a, $26 ; $4278
	ld [$c329], a ; $427a
	ld a, $23 ; $427d
	ld [$c32a], a ; $427f
	ld a, $40 ; $4282
	ld [$c32b], a ; $4284
	ld a, $3c ; $4287
	ld [$c32c], a ; $4289
	call DisableLCDSafely ; $428c
	ld a, $00 ; $428f
	farcall CopyScrolledSceneTilemapToVram ; $4291
	call EnableLCD ; $4294
	call ComputeMachineCourtProgress ; $4297
	farcall WaitPlayerMoveDone ; $429a
	ld a, [wStoryModeEntryPoint] ; $429d
	cp a, $05 ; $42a0
	jp z, MachineCourtResultScene ; $42a2
	cp a, $07 ; $42a5
	jp z, MachinePracticeResultScene ; $42a7
	cp a, $ff ; $42aa
	jp z, Label_14_4a00 ; $42ac
	ret ; $42af
MachineCourtResultScene:
	test_flag FLAG_DOUBLES ; $42b0
	jr z, Label_14_42d3 ; $42b3
	script_null_script ACTOR_PARTNER ; $42b5
	script_wait_frames $0a ; $42ba
	script_set_position ACTOR_PARTNER, $2900, $2b00 ; $42c1
	script_face ACTOR_PARTNER, FACE_RIGHT ; $42cc
Label_14_42d3:
	script_set_position $05, $2d00, $2900 ; $42d3
	script_face $05, FACE_DOWN ; $42de
	script_fade_in $06 ; $42e5
	call WaitFadeEnd ; $42ea
	script_wait_frames $28 ; $42ed
	script_set_speed ACTOR_PLAYER, $0020 ; $42f4
	test_flag FLAG_DOUBLES ; $42fc
	jr z, Label_14_4301 ; $42ff
Label_14_4301:
	xor a, a ; $4301
	ld [wStoryModeShowLocationName], a ; $4302
	ld a, [wMatchExitRequest] ; $4305
	and a, a ; $4308
	jp nz, MachineCourtGameOverExitScene ; $4309
	ld a, [wPointWinLoseFlag] ; $430c
	cp a, $01 ; $430f
	jr z, Label_14_4326 ; $4311
	ld a, [$c2b0] ; $4313
	ld a, a ; $4316
	rst Rst00 ; $4317
	dw MachineLevel1FailedPrompt ; $4318 jumptable
	dw MachineLevel2FailedPrompt ; $431a jumptable
	dw MachineLevel3FailedPrompt ; $431c jumptable
	dw MachineLevel4FailedPrompt ; $431e jumptable
	dw MachineExpertResultScene ; $4320 jumptable
	dw MachineExpertResultScene ; $4322 jumptable
	dw MachineExpertResultScene ; $4324 jumptable
Label_14_4326:
	ld a, [$c2b0] ; $4326
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
	ld de, $d000 ; $439d
	farcall AttachActorStepMover ; $43a0
	ret ; $43a3
ComputeMachineCourtProgress:
	ld a, $00 ; $43a4
	test_flag FLAG_CLEARED_MACHINE_LEVEL_1 ; $43a6
	jp z, Label_14_4429 ; $43a9
	script_copy_scene_rect $1e, $2c, $30, $2c, $02, $02 ; $43ac
	ld a, $01 ; $43bb
	test_flag FLAG_CLEARED_MACHINE_LEVEL_2 ; $43bd
	jp z, Label_14_4429 ; $43c0
	script_copy_scene_rect $1e, $30, $30, $30, $02, $02 ; $43c3
	ld a, $02 ; $43d2
	test_flag FLAG_CLEARED_MACHINE_LEVEL_3 ; $43d4
	jr z, Label_14_4429 ; $43d7
	script_copy_scene_rect $1e, $34, $30, $34, $02, $02 ; $43d9
	ld a, $03 ; $43e8
	test_flag FLAG_CLEARED_MACHINE_LEVEL_4 ; $43ea
	jr z, Label_14_4429 ; $43ed
	script_copy_scene_rect $1e, $38, $30, $38, $02, $02 ; $43ef
	ld a, $04 ; $43fe
	ld b, a ; $4400
	ld a, $01 ; $4401
	farcall ReadMinigameRecord ; $4403
	ldh a, [hWramBank] ; $4406
	push af ; $4408
	wram_bank $07 ; $4409
	ld hl, $de00 ; $440f
	ld a, [hl+] ; $4412
	ld h, [hl] ; $4413
	ld l, a ; $4414
	pop af ; $4415
	wram_bank ; $4416
	ld a, b ; $441a
	test_flag FLAG_CLEARED_MACHINE_MASTER ; $441b
	jr z, Label_14_4429 ; $441e
	ld a, $05 ; $4420
	test_flag FLAG_CLEARED_MACHINE_EXPERT ; $4422
	jr z, Label_14_4429 ; $4425
	ld a, $06 ; $4427
Label_14_4429:
	ld [$c2b0], a ; $4429
	ret ; $442c
TennisMachineRoomNpc05_14:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $442d
	jp nz, MachineCourtStartLevelScene ; $4430
	ld a, [$c2b0] ; $4433
	add a, a ; $4436
	add a, $00 ; $4437
	ld l, a ; $4439
	adc a, $46 ; $443a
	sub a, l ; $443c
	ld h, a ; $443d
	ld a, [hl+] ; $443e
	ld h, [hl] ; $443f
	ld l, a ; $4440
	farcall InitDialogueTextCursor ; $4441
	ld a, [$c2b0] ; $4444
	cp a, $05 ; $4447
	jr c, Label_14_4467 ; $4449
	ldh a, [hWramBank] ; $444b
	push af ; $444d
	wram_bank $07 ; $444e
	ld a, $01 ; $4454
	farcall ReadMinigameRecord ; $4456
	ld hl, $de00 ; $4459
	ld a, [hl+] ; $445c
	ld h, [hl] ; $445d
	ld l, a ; $445e
	pop af ; $445f
	wram_bank ; $4460
	farcall PushTextArgNumber ; $4464
Label_14_4467:
	script_face ACTOR_PARTNER, FACE_RIGHT ; $4467
	script_face ACTOR_PLAYER, FACE_RIGHT ; $446e
	ld a, $05 ; $4475
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4477
	farcall RunDialogueYesNoPrompt ; $447a
	farcall ScriptCloseDialogueWindow ; $447d
	script_wait_frames $05 ; $4480
	and a, a ; $4487
	jr nz, Label_14_44a9 ; $4488
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $448a
	farcall AdvanceDialogueTextCursor ; $448d
	ld a, [$c2b0] ; $4490
	and a, a ; $4493
	jr nz, Label_14_449b ; $4494
	script_speak $05 ; $4496
Label_14_449b:
	script_set_anim $05, $03 ; $449b
	script_wait_idle $05 ; $44a2
	jr nz, MachineCourtStartLevelScene ; $44a7
Label_14_44a9:
	test_flag FLAG_CLEARED_MACHINE_LEVEL_1 ; $44a9
	jr z, Label_14_44ca ; $44ac
	script_set_text Text_6e_222 ; $44ae
	ld a, $05 ; $44b4
	farcall ScriptShowSpeakerDialogueRestoreBG ; $44b6
	farcall RunDialogueYesNoPrompt ; $44b9
	farcall ScriptCloseDialogueWindow ; $44bc
	script_wait_frames $05 ; $44bf
	and a, a ; $44c6
	jp z, Label_14_45a6 ; $44c7
Label_14_44ca:
	ld a, [$c2b0] ; $44ca
	add a, a ; $44cd
	add a, $00 ; $44ce
	ld l, a ; $44d0
	adc a, $46 ; $44d1
	sub a, l ; $44d3
	ld h, a ; $44d4
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
	jr z, Label_14_4515 ; $4503
	script_null_script ACTOR_PARTNER ; $4505
	script_set_actor_script ACTOR_PARTNER, ActorScript_14_4808 ; $450a
Label_14_4515:
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
	ld a, [$c2b0] ; $4565
	cp a, $04 ; $4568
	jr c, Label_14_4577 ; $456a
	script_set_text Text_6e_204 ; $456c
	script_speak $05 ; $4572
Label_14_4577:
	ld c, $06 ; $4577
	call BeginFadeOut ; $4579
	call WaitFadeEnd ; $457c
	clear_flag FLAG_TEMP_SCENE_VARIANT_A ; $457f
	ld a, $12 ; $4582
	ld [wStoryModeCurrentLocation], a ; $4584
	ld a, $05 ; $4587
	ld [wStoryModeEntryPoint], a ; $4589
	ld a, $ff ; $458c
	ld [$c294], a ; $458e
	ld [wStoryModeExitLocationRequest], a ; $4591
	ld a, [$c2b0] ; $4594
	add a, $f8 ; $4597
	ld l, a ; $4599
	adc a, $45 ; $459a
	sub a, l ; $459c
	ld h, a ; $459d
	ld a, [hl] ; $459e
	farcall RunTrainingDrillByID ; $459f
	farcall EndCutsceneScriptMode ; $45a2
	ret ; $45a5
Label_14_45a6:
	script_speak $05 ; $45a6
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $45ab
	script_move_target $05, $2d00, $2900 ; $45ae
	script_wait_move $05 ; $45b9
	script_face $05, FACE_DOWN ; $45be
	script_null_script ACTOR_PARTNER ; $45c5
	script_set_speed ACTOR_PLAYER, $0020 ; $45ca
	script_set_actor_script ACTOR_PARTNER, ActorScript_14_4808 ; $45d2
	script_move_target ACTOR_PLAYER, $3100, $2b00 ; $45dd
	script_wait_move ACTOR_PLAYER ; $45e8
	script_face ACTOR_PLAYER, FACE_DOWN ; $45ed
	set_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $45f4
	ret ; $45f7
	; $45f8, 8 bytes (bytes:16)
	db $12, $13, $14, $15, $1a, $1a, $1a, $c9 ; 0x00
	; $4600, 18 bytes (records:2)
	dw $20a9 ; record 0
	dw $20b4 ; record 1
	dw $20bb ; record 2
	dw $20c2 ; record 3
	dw $20c9 ; record 4
	dw $20d1 ; record 5
	dw $20d8 ; record 6
	dw $20d1 ; record 7
	dw $20d8 ; record 8
MachinePracticeLevelPrompt:
	ld [$c2b8], a ; $4612
	call TestMachineLevelClearedFlag ; $4615
	jr z, MachineLevelNotClearedMessage ; $4618
	script_set_text Text_6e_224 ; $461a
	ld a, [$c2b8] ; $4620
	inc a ; $4623
	ld h, $00 ; $4624
	ld l, a ; $4626
	farcall PushTextArgNumber ; $4627
	ld a, $05 ; $462a
	farcall ScriptShowSpeakerDialogueRestoreBG ; $462c
	farcall RunDialogueYesNoPrompt ; $462f
	farcall ScriptCloseDialogueWindow ; $4632
	script_wait_frames $05 ; $4635
	and a, a ; $463c
	jr nz, Label_14_4692 ; $463d
	script_face $05, FACE_UP ; $463f
	script_set_speed ACTOR_PLAYER, $0020 ; $4646
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0200 ; $464e
	script_wait_move ACTOR_PLAYER ; $4658
	script_move_target ACTOR_PLAYER, $3500, $3500 ; $465d
	script_wait_move ACTOR_PLAYER ; $4668
	ld c, $08 ; $466d
	call BeginFadeOut ; $466f
	call WaitFadeEnd ; $4672
	ld a, $12 ; $4675
	ld [wStoryModeCurrentLocation], a ; $4677
	ld a, $07 ; $467a
	ld [wStoryModeEntryPoint], a ; $467c
	ld a, $ff ; $467f
	ld [$c294], a ; $4681
	ld [wStoryModeExitLocationRequest], a ; $4684
	ld a, [$c2b8] ; $4687
	add a, $12 ; $468a
	farcall RunTrainingDrillByID ; $468c
	farcall EndCutsceneScriptMode ; $468f
Label_14_4692:
	ret ; $4692
MachineLevelNotClearedMessage:
	script_set_text Text_6e_225 ; $4693
	script_speak $05 ; $4699
	ret ; $469e
TestMachineLevelClearedFlag:
	add a, a ; $469f
	add a, $bd ; $46a0
	ld l, a ; $46a2
	adc a, $46 ; $46a3
	sub a, l ; $46a5
	ld h, a ; $46a6
	ld a, [hl+] ; $46a7
	ld d, [hl] ; $46a8
	ld e, a ; $46a9
	call TestGameFlagByNumber ; $46aa
	ret ; $46ad
	add a, a ; $46ae
	add a, $bd ; $46af
	ld l, a ; $46b1
	adc a, $46 ; $46b2
	sub a, l ; $46b4
	ld h, a ; $46b5
	ld a, [hl+] ; $46b6
	ld d, [hl] ; $46b7
	ld e, a ; $46b8
	call SetGameFlagByNumber ; $46b9
	ret ; $46bc
	; $46bd, 8 bytes (records:2)
	dw $00d2 ; record 0
	dw $00d3 ; record 1
	dw $00d4 ; record 2
	dw $00d5 ; record 3
MachinePracticeResultScene:
	xor a, a ; $46c5
	ld [wStoryModeShowLocationName], a ; $46c6
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $46c9
	test_flag FLAG_DOUBLES ; $46cc
	jr z, Label_14_46ef ; $46cf
	script_null_script ACTOR_PARTNER ; $46d1
	script_set_position ACTOR_PARTNER, $2900, $2b00 ; $46d6
	script_face ACTOR_PARTNER, FACE_RIGHT ; $46e1
	script_wait_frames $0a ; $46e8
Label_14_46ef:
	script_set_position $05, $2d00, $2900 ; $46ef
	script_face $05, FACE_DOWN ; $46fa
	script_fade_in $06 ; $4701
	call WaitFadeEnd ; $4706
	script_wait_frames $28 ; $4709
	ld a, [wMatchExitRequest] ; $4710
	and a, a ; $4713
	jp nz, Label_14_474d ; $4714
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
	and a, a ; $4749
	jp z, MachineCourtRestartLevel ; $474a
Label_14_474d:
	ret ; $474d
MachineCourtHandleRetryChoice:
	ld a, $05 ; $474e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4750
	farcall RunDialogueYesNoPrompt ; $4753
	farcall ScriptCloseDialogueWindow ; $4756
	script_wait_frames $05 ; $4759
	and a, a ; $4760
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
	ld de, $d000 ; $47c6
	farcall AttachActorStepMover ; $47c9
	ret ; $47cc
MachineCourtRestartLevel:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $47cd
	cp a, $1a ; $47d0
	jr z, Label_14_47ef ; $47d2
	sub a, $12 ; $47d4
	call TestMachineLevelClearedFlag ; $47d6
	jr z, Label_14_47ef ; $47d9
	ld a, $12 ; $47db
	ld [wStoryModeCurrentLocation], a ; $47dd
	ld a, $07 ; $47e0
	ld [wStoryModeEntryPoint], a ; $47e2
	ld a, $ff ; $47e5
	ld [$c294], a ; $47e7
	ld [wStoryModeExitLocationRequest], a ; $47ea
	jr Label_14_4801 ; $47ed
Label_14_47ef:
	ld a, $12 ; $47ef
	ld [wStoryModeCurrentLocation], a ; $47f1
	ld a, $05 ; $47f4
	ld [wStoryModeEntryPoint], a ; $47f6
	ld a, $ff ; $47f9
	ld [$c294], a ; $47fb
	ld [wStoryModeExitLocationRequest], a ; $47fe
Label_14_4801:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4801
	farcall RunTrainingDrillByID ; $4804
	ret ; $4807
ActorScript_14_4808:
	; $4808, 11 bytes (actor_script)
	as_set_target $2900, $2b00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
	ldh a, [hWramBank] ; $4813
	push af ; $4815
	wram_bank $07 ; $4816
	ld a, $01 ; $481c
	farcall ReadMinigameRecord ; $481e
	ld de, $0050 ; $4821
	ld hl, $de00 ; $4824
	ld a, e ; $4827
	ld [hl+], a ; $4828
	ld [hl], d ; $4829
	pop af ; $482a
	wram_bank ; $482b
	ld a, $12 ; $482f
	ld [wStoryModeCurrentLocation], a ; $4831
	ld a, $01 ; $4834
	ld [wStoryModeEntryPoint], a ; $4836
	ld a, $ff ; $4839
	ld [$c294], a ; $483b
	ld [wStoryModeExitLocationRequest], a ; $483e
	ret ; $4841
MachineExpertResultScene:
	test_flag FLAG_CLEARED_MACHINE_EXPERT ; $4842
	jr z, Label_14_484f ; $4845
	ld a, [wPointWinLoseFlag] ; $4847
	cp a, $01 ; $484a
	jp z, MachineExpertCounterMaxScene ; $484c
Label_14_484f:
	ld bc, $0001 ; $484f
	ldh a, [hWramBank] ; $4852
	push af ; $4854
	wram_bank $07 ; $4855
	ld hl, wMinigamesCurrentScore ; $485b
	ld a, [hl+] ; $485e
	ld d, [hl] ; $485f
	ld e, a ; $4860
	pop af ; $4861
	wram_bank ; $4862
	ld l, c ; $4866
	ld h, b ; $4867
	ld a, l ; $4868
	sub a, e ; $4869
	ld l, a ; $486a
	ld a, h ; $486b
	sbc a, d ; $486c
	ld h, a ; $486d
	jp nc, MachineExpertRetryPrompt ; $486e
	ld bc, $270f ; $4871
	ldh a, [hWramBank] ; $4874
	push af ; $4876
	wram_bank $07 ; $4877
	ld a, $01 ; $487d
	farcall ReadMinigameRecord ; $487f
	ld hl, $de00 ; $4882
	ld a, [hl+] ; $4885
	ld d, [hl] ; $4886
	ld e, a ; $4887
	pop af ; $4888
	wram_bank ; $4889
	ld l, c ; $488d
	ld h, b ; $488e
	ld a, l ; $488f
	sub a, e ; $4890
	ld l, a ; $4891
	ld a, h ; $4892
	sbc a, d ; $4893
	ld h, a ; $4894
	jp z, MachineExpertRetryPrompt ; $4895
	ld hl, wMinigamesCurrentScore ; $4898
	ld a, [hl+] ; $489b
	ld b, [hl] ; $489c
	ld c, a ; $489d
	ldh a, [hWramBank] ; $489e
	push af ; $48a0
	wram_bank $07 ; $48a1
	ld hl, $de00 ; $48a7
	ld a, [hl+] ; $48aa
	ld d, [hl] ; $48ab
	ld e, a ; $48ac
	pop af ; $48ad
	wram_bank ; $48ae
	ld l, c ; $48b2
	ld h, b ; $48b3
	inc de ; $48b4
	ld a, l ; $48b5
	sub a, e ; $48b6
	ld l, a ; $48b7
	ld a, h ; $48b8
	sbc a, d ; $48b9
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
	ld de, $d000 ; $48f2
	farcall AttachActorStepMover ; $48f5
	ret ; $48f8
MachineExpertCounterMaxScene:
	ldh a, [hWramBank] ; $48f9
	push af ; $48fb
	wram_bank $07 ; $48fc
	ld a, $01 ; $4902
	farcall ReadMinigameRecord ; $4904
	ld hl, $de00 ; $4907
	ld a, [hl+] ; $490a
	ld h, [hl] ; $490b
	ld l, a ; $490c
	pop af ; $490d
	wram_bank ; $490e
	ld de, $270f ; $4912
	ld a, l ; $4915
	sub a, e ; $4916
	ld l, a ; $4917
	ld a, h ; $4918
	sbc a, d ; $4919
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
	ld de, $d000 ; $494a
	farcall AttachActorStepMover ; $494d
	ret ; $4950
	ld hl, wMinigamesCurrentScore ; $4951
	ld a, [hl+] ; $4954
	ld b, [hl] ; $4955
	ld c, a ; $4956
	ldh a, [hWramBank] ; $4957
	push af ; $4959
	wram_bank $07 ; $495a
	ld hl, $de00 ; $4960
	ld a, [hl+] ; $4963
	ld d, [hl] ; $4964
	ld e, a ; $4965
	pop af ; $4966
	wram_bank ; $4967
	ld l, c ; $496b
	ld h, b ; $496c
	ld a, l ; $496d
	sub a, e ; $496e
	ld l, a ; $496f
	ld a, h ; $4970
	sbc a, d ; $4971
	ld h, a ; $4972
	ret ; $4973
SaveMachineExpertRecord:
	ldh a, [hWramBank] ; $4974
	push af ; $4976
	wram_bank $07 ; $4977
	ld hl, wMinigamesCurrentScore ; $497d
	ld a, [hl+] ; $4980
	ld d, [hl] ; $4981
	ld e, a ; $4982
	ld hl, $de00 ; $4983
	ld a, e ; $4986
	ld [hl+], a ; $4987
	ld [hl], d ; $4988
	ld a, $01 ; $4989
	farcall UpdateMinigameRecord ; $498b
	pop af ; $498e
	wram_bank ; $498f
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
Label_14_4a00:
	test_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $4a00
	jr z, Label_14_4a38 ; $4a03
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $4a05
	script_set_position $05, $2d00, $2900 ; $4a08
	script_face $05, FACE_DOWN ; $4a13
	script_null_script ACTOR_PARTNER ; $4a1a
	script_wait_frames $01 ; $4a1f
	script_set_position ACTOR_PARTNER, $2900, $2b00 ; $4a26
	script_face ACTOR_PARTNER, FACE_RIGHT ; $4a31
Label_14_4a38:
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
	map_actor $0000, ActorScript_14_78b1, $1d00, $1500, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_14_78b1, $1900, $1800, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_14_78b1, $1b00, $1c00, FACE_LEFT, $30, $01, $05
	map_actor $0000, ActorScript_14_78b1, $1b00, $1a00, FACE_LEFT, $39, $01, $05
	map_actor $0000, ActorScript_14_78bb, $0700, $3100, FACE_RIGHT, $39, $01, $04
	map_actor $0000, ActorScript_14_78b1, $0900, $2300, FACE_RIGHT, $39, $01, $04
	map_actor $0000, ActorScript_14_78b1, $0b00, $2300, FACE_LEFT, $3a, $01, $00
	map_actor $0000, ActorScript_14_78b1, $0b00, $2b00, FACE_RIGHT, $23, $01, $00
	map_actor $0000, ActorScript_14_78b1, $0f00, $2b00, FACE_LEFT, $24, $01, $00
	map_actor $0000, ActorScript_14_78b1, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_14_78b1, $fd00, $0100, FACE_DOWN, $53, $01, $00
	map_actor $0000, ActorScript_14_78b1, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_14_78b1, $1b00, $0c00, FACE_LEFT, $39, $01, $00
	map_actor $0000, ActorScript_14_78b1, $1900, $0e00, FACE_LEFT, $39, $01, $06
	map_actor $0000, ActorScript_14_78b1, $1b00, $1000, FACE_LEFT, $3a, $01, $03
	map_actor $0000, ActorScript_14_78b1, $0500, $1b00, FACE_RIGHT, $33, $01, $00
	map_actor $0000, ActorScript_14_78b1, $0500, $1d00, FACE_RIGHT, $3a, $01, $04
	map_actor_end
Court2EntryPoints_14:
	; $4b3f, 17 bytes (map_entries)
	map_entry $01, FACE_LEFT, $2500, $1500, $0000
	map_entry $02, FACE_LEFT, $2500, $2500, $0000
	db $ff
Court2ExitTriggers_14:
	; $4b50, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_14, $19, $03
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_14, $15, $02
	db $ff
Court2Npc03_14:
	script_set_text Text_1f_145 ; $4b61
	script_speak $03 ; $4b67
	ret ; $4b6c
Court2Npc04_14:
	ld a, [$c2b0] ; $4b6d
	add a, a ; $4b70
	add a, $84 ; $4b71
	ld l, a ; $4b73
	adc a, $4b ; $4b74
	sub a, l ; $4b76
	ld h, a ; $4b77
	ld a, [hl+] ; $4b78
	ld h, [hl] ; $4b79
	ld l, a ; $4b7a
	farcall InitDialogueTextCursor ; $4b7b
	script_speak $04 ; $4b7e
	ret ; $4b83
	; $4b84, 14 bytes (records:2)
	dw $2492 ; record 0
	dw $2492 ; record 1
	dw $2492 ; record 2
	dw $2497 ; record 3
	dw $2492 ; record 4
	dw $2492 ; record 5
	dw $2497 ; record 6
Court2Npc05_14:
	ld a, [$c2b0] ; $4b92
	add a, a ; $4b95
	add a, $a9 ; $4b96
	ld l, a ; $4b98
	adc a, $4b ; $4b99
	sub a, l ; $4b9b
	ld h, a ; $4b9c
	ld a, [hl+] ; $4b9d
	ld h, [hl] ; $4b9e
	ld l, a ; $4b9f
	farcall InitDialogueTextCursor ; $4ba0
	script_speak $05 ; $4ba3
	ret ; $4ba8
	; $4ba9, 14 bytes (records:2)
	dw $2493 ; record 0
	dw $2493 ; record 1
	dw $2495 ; record 2
	dw $2498 ; record 3
	dw $2499 ; record 4
	dw $249b ; record 5
	dw $249d ; record 6
Court2Npc06_14:
	ld a, [$c2b0] ; $4bb7
	add a, a ; $4bba
	add a, $ce ; $4bbb
	ld l, a ; $4bbd
	adc a, $4b ; $4bbe
	sub a, l ; $4bc0
	ld h, a ; $4bc1
	ld a, [hl+] ; $4bc2
	ld h, [hl] ; $4bc3
	ld l, a ; $4bc4
	farcall InitDialogueTextCursor ; $4bc5
	script_speak $06 ; $4bc8
	ret ; $4bcd
	; $4bce, 14 bytes (records:2)
	dw $2494 ; record 0
	dw $2494 ; record 1
	dw $2496 ; record 2
	dw $2496 ; record 3
	dw $249a ; record 4
	dw $249c ; record 5
	dw $249e ; record 6
Court2SpectatorChat_14:
	test_flag FLAG_DOUBLES ; $4bdc
	jr z, Label_14_4bec ; $4bdf
	test_flag FLAG_COURT2_SPECTATORS_TALKED_DOUBLES ; $4be1
	jp nz, Court2SpectatorsRepeatChat ; $4be4
	set_flag FLAG_COURT2_SPECTATORS_TALKED_DOUBLES ; $4be7
	jr Label_14_4bf5 ; $4bea
Label_14_4bec:
	test_flag FLAG_COURT2_SPECTATORS_TALKED_SINGLES ; $4bec
	jp nz, Court2SpectatorsRepeatChat ; $4bef
	set_flag FLAG_COURT2_SPECTATORS_TALKED_SINGLES ; $4bf2
Label_14_4bf5:
	ld a, [$c2b0] ; $4bf5
	add a, a ; $4bf8
	add a, $5f ; $4bf9
	ld l, a ; $4bfb
	adc a, $4d ; $4bfc
	sub a, l ; $4bfe
	ld h, a ; $4bff
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
	; $4d5f, 14 bytes (records:2)
	dw $246b ; record 0
	dw $246b ; record 1
	dw $246b ; record 2
	dw $2472 ; record 3
	dw $2478 ; record 4
	dw $2478 ; record 5
	dw $247e ; record 6
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
	jr nz, Label_14_4de6 ; $4dd5
	ld a, [$c2b0] ; $4dd7
	cp a, $03 ; $4dda
	jr nz, Label_14_4df3 ; $4ddc
	script_set_text Text_1f_113 ; $4dde
	jr Label_14_4df3 ; $4de4
Label_14_4de6:
	ld a, [$c2b0] ; $4de6
	cp a, $06 ; $4de9
	jr nz, Label_14_4df3 ; $4deb
	script_set_text Text_1f_113 ; $4ded
Label_14_4df3:
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
	ld a, $00 ; $4e60
	ld [$c2b0], a ; $4e62
	test_flag FLAG_DOUBLES ; $4e65
	jr nz, Label_14_4e92 ; $4e68
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $4e6a
	jr z, Label_14_4e7e ; $4e6d
	ldh a, [hRomBank] ; $4e6f
	ld hl, Court2ActorsAlt_14 ; $4e71
	farcall ScriptRespawnLocationActors ; $4e74
	farcall BeginCutsceneScriptMode ; $4e77
	ld a, $03 ; $4e7a
	jr Label_14_4e8e ; $4e7c
Label_14_4e7e:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $4e7e
	jr z, Label_14_4e87 ; $4e81
	ld a, $02 ; $4e83
	jr Label_14_4e8e ; $4e85
Label_14_4e87:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $4e87
	jr z, Label_14_4e91 ; $4e8a
	ld a, $01 ; $4e8c
Label_14_4e8e:
	ld [$c2b0], a ; $4e8e
Label_14_4e91:
	ret ; $4e91
Label_14_4e92:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $4e92
	jr z, Label_14_4ea6 ; $4e95
	ldh a, [hRomBank] ; $4e97
	ld hl, Court2ActorsAlt_14 ; $4e99
	farcall ScriptRespawnLocationActors ; $4e9c
	farcall BeginCutsceneScriptMode ; $4e9f
	ld a, $06 ; $4ea2
	jr Label_14_4e8e ; $4ea4
Label_14_4ea6:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $4ea6
	jr z, Label_14_4eaf ; $4ea9
	ld a, $05 ; $4eab
	jr Label_14_4e8e ; $4ead
Label_14_4eaf:
	ld a, $04 ; $4eaf
	jr Label_14_4e8e ; $4eb1
	ret ; $4eb3
Court2ActorsAlt_14:
	; $4eb4, 178 bytes (map_actors)
	map_actor $0000, ActorScript_14_78b1, $1d00, $1500, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_14_78b1, $1b00, $2300, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_14_78b1, $1f00, $2d00, FACE_LEFT, $30, $01, $05
	map_actor $0000, ActorScript_14_78bb, $1d00, $3000, FACE_UP, $39, $01, $05
	map_actor $0000, ActorScript_14_78bb, $0700, $3100, FACE_RIGHT, $39, $01, $04
	map_actor $0000, ActorScript_14_78b1, $0900, $2300, FACE_RIGHT, $39, $01, $04
	map_actor $0000, ActorScript_14_78b1, $0b00, $2300, FACE_LEFT, $3a, $01, $00
	map_actor $0000, ActorScript_14_78b1, $0b00, $2b00, FACE_RIGHT, $23, $01, $00
	map_actor $0000, ActorScript_14_78b1, $0f00, $2b00, FACE_LEFT, $24, $01, $00
	map_actor $0000, ActorScript_14_78b1, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_14_78b1, $fd00, $0100, FACE_DOWN, $53, $01, $00
	map_actor $0000, ActorScript_14_78b1, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor_end
Court2EntryWalkIn:
	ld a, [wStoryModeEntryPoint] ; $4f66
	cp a, $ff ; $4f69
	jp z, Label_14_4fab ; $4f6b
	test_flag FLAG_DOUBLES ; $4f6e
	jr z, Label_14_4f99 ; $4f71
	script_set_speed ACTOR_PARTNER, $00ff ; $4f73
	script_move_angle ACTOR_PARTNER, FACE_RIGHT, $0200 ; $4f7b
	script_wait_move ACTOR_PARTNER ; $4f85
	script_face ACTOR_PARTNER, FACE_LEFT ; $4f8a
	script_set_speed ACTOR_PARTNER, $0010 ; $4f91
Label_14_4f99:
	script_set_speed ACTOR_PLAYER, $0010 ; $4f99
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0200 ; $4fa1
Label_14_4fab:
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
	map_actor $0000, ActorScript_14_78b1, $0b00, $1500, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_14_78b1, $1100, $2300, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_14_78b1, $2300, $1900, FACE_LEFT, $39, $01, $03
	map_actor $0000, ActorScript_14_78b1, $2300, $1c00, FACE_LEFT, $32, $01, $03
	map_actor $0000, ActorScript_14_78b1, $0e00, $0d00, FACE_RIGHT, $39, $01, $00
	map_actor $0000, ActorScript_14_78b1, $0f00, $0f00, FACE_RIGHT, $39, $01, $06
	map_actor $0000, ActorScript_14_78b1, $0e00, $1100, FACE_RIGHT, $3a, $01, $03
	map_actor $0000, ActorScript_14_78b1, $2300, $0f00, FACE_LEFT, $33, $01, $00
	map_actor $0000, ActorScript_14_78b1, $2100, $1100, FACE_LEFT, $3a, $01, $04
	map_actor_end
Court1EntryPoints_14:
	; $5042, 17 bytes (map_entries)
	map_entry $01, FACE_RIGHT, $0300, $1500, $0000
	map_entry $02, FACE_RIGHT, $0300, $2500, $0000
	db $ff
Court1ExitTriggers_14:
	; $5053, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_14, $19, $04
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_14, $15, $01
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
	ld a, [$c2b0] ; $507c
	add a, a ; $507f
	add a, $93 ; $5080
	ld l, a ; $5082
	adc a, $50 ; $5083
	sub a, l ; $5085
	ld h, a ; $5086
	ld a, [hl+] ; $5087
	ld h, [hl] ; $5088
	ld l, a ; $5089
	farcall InitDialogueTextCursor ; $508a
	script_speak $05 ; $508d
	ret ; $5092
	; $5093, 14 bytes (records:2)
	dw $2486 ; record 0
	dw $2486 ; record 1
	dw $2489 ; record 2
	dw $248b ; record 3
	dw $2486 ; record 4
	dw $248d ; record 5
	dw $248f ; record 6
Court1Npc06_14:
	ld a, [$c2b0] ; $50a1
	add a, a ; $50a4
	add a, $b8 ; $50a5
	ld l, a ; $50a7
	adc a, $50 ; $50a8
	sub a, l ; $50aa
	ld h, a ; $50ab
	ld a, [hl+] ; $50ac
	ld h, [hl] ; $50ad
	ld l, a ; $50ae
	farcall InitDialogueTextCursor ; $50af
	script_speak $06 ; $50b2
	ret ; $50b7
	; $50b8, 14 bytes (records:2)
	dw $2487 ; record 0
	dw $2488 ; record 1
	dw $248a ; record 2
	dw $248c ; record 3
	dw $2487 ; record 4
	dw $248e ; record 5
	dw $2490 ; record 6
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
	ld a, $00 ; $5105
	ld [$c2b0], a ; $5107
	test_flag FLAG_DOUBLES ; $510a
	jr nz, Label_14_513b ; $510d
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $510f
	jr z, Label_14_5125 ; $5112
	ld a, $03 ; $5114
	ld [$c2b0], a ; $5116
	ldh a, [hRomBank] ; $5119
	ld hl, Court1ActorsAlt_14 ; $511b
	farcall ScriptRespawnLocationActors ; $511e
	farcall BeginCutsceneScriptMode ; $5121
	ret ; $5124
Label_14_5125:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $5125
	jr z, Label_14_5130 ; $5128
	ld a, $02 ; $512a
	ld [$c2b0], a ; $512c
	ret ; $512f
Label_14_5130:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $5130
	jr z, Label_14_513a ; $5133
	ld a, $01 ; $5135
	ld [$c2b0], a ; $5137
Label_14_513a:
	ret ; $513a
Label_14_513b:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $513b
	jr z, Label_14_5151 ; $513e
	ld a, $06 ; $5140
	ld [$c2b0], a ; $5142
	ldh a, [hRomBank] ; $5145
	ld hl, Court1ActorsAlt_14 ; $5147
	farcall ScriptRespawnLocationActors ; $514a
	farcall BeginCutsceneScriptMode ; $514d
	ret ; $5150
Label_14_5151:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $5151
	jr z, Label_14_515c ; $5154
	ld a, $05 ; $5156
	ld [$c2b0], a ; $5158
	ret ; $515b
Label_14_515c:
	ld a, $04 ; $515c
	ld [$c2b0], a ; $515e
	ret ; $5161
Court1ActorsAlt_14:
	; $5162, 66 bytes (map_actors)
	map_actor $0000, ActorScript_14_78b1, $0b00, $1500, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_14_78b1, $1100, $2300, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_14_78b1, $1b00, $2300, FACE_DOWN, $39, $01, $03
	map_actor $0000, ActorScript_14_78b1, $1d00, $2300, FACE_DOWN, $32, $01, $03
	map_actor_end
Court1EntryWalkIn:
	ld a, [wStoryModeEntryPoint] ; $51a4
	cp a, $ff ; $51a7
	jp z, Label_14_51e9 ; $51a9
	test_flag FLAG_DOUBLES ; $51ac
	jr z, Label_14_51d7 ; $51af
	script_set_speed ACTOR_PARTNER, $00ff ; $51b1
	script_move_angle ACTOR_PARTNER, FACE_LEFT, $0200 ; $51b9
	script_wait_move ACTOR_PARTNER ; $51c3
	script_face ACTOR_PARTNER, FACE_RIGHT ; $51c8
	script_set_speed ACTOR_PARTNER, $0010 ; $51cf
Label_14_51d7:
	script_set_speed ACTOR_PLAYER, $0010 ; $51d7
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0200 ; $51df
Label_14_51e9:
	ret ; $51e9
LoadCourtPlayerPartnerObjDefs_14:
	test_flag FLAG_DOUBLES ; $51ea
	jp z, Label_14_5208 ; $51ed
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $51f0
	ld d, $58 ; $51f3
	add a, d ; $51f5
	ld d, a ; $51f6
	script_get_actor_state ACTOR_PARTNER ; $51f7
	ld c, l ; $51fc
	ld b, h ; $51fd
	farcall LoadActorObjectDefIfValid ; $51fe
	script_set_anim ACTOR_PARTNER, $01 ; $5201
Label_14_5208:
	ld a, [wStoryModeGenderOfMainCharacter] ; $5208
	ld d, $56 ; $520b
	add a, d ; $520d
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
	map_actor $0000, ActorScript_14_78b1, $0600, $2700, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_14_78b1, $0600, $2700, FACE_DOWN, $5c, $01, $00
	map_actor $0000, ActorScript_14_78b1, $0600, $2700, FACE_DOWN, $5b, $01, $00
	map_actor $0000, ActorScript_14_78b1, $0600, $2700, FACE_DOWN, $5a, $01, $00
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
	; $52a2, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_14, $08, $06
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
	cp a, $02 ; $52e6
	jp z, Label_14_628b ; $52e8
	cp a, $08 ; $52eb
	jp z, Label_14_64e1 ; $52ed
	cp a, $0e ; $52f0
	jp z, Label_14_76c6 ; $52f2
	cp a, $0f ; $52f5
	jp z, Label_14_6f7b ; $52f7
	cp a, $0d ; $52fa
	jp z, Label_14_6f7b ; $52fc
	jp Label_14_5303 ; $52ff
	ret ; $5302
Label_14_5303:
	set_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $5303
	call DisableLCDSafely ; $5306
	call LoadPlaneObjGfx_14 ; $5309
	call LoadWaterSplashObjGfx_14 ; $530c
	call EnableLCD ; $530f
	ld a, $50 ; $5312
	ld [$c2b0], a ; $5314
	ld a, $88 ; $5317
	ld [$c2b1], a ; $5319
	ld a, $01 ; $531c
	ld hl, QueuePlaneSpriteByHeight_14 ; $531e
	call RegisterFrameTask ; $5321
	test_flag FLAG_DOUBLES ; $5324
	jp z, Label_14_5352 ; $5327
	script_null_script ACTOR_PARTNER ; $532a
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $532f
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $533a
	ld d, $58 ; $533d
	add a, d ; $533f
	ld d, a ; $5340
	script_get_actor_state $05 ; $5341
	ld c, l ; $5346
	ld b, h ; $5347
	farcall LoadActorObjectDefIfValid ; $5348
	script_set_anim $05, $01 ; $534b
Label_14_5352:
	ld a, [wStoryModeGenderOfMainCharacter] ; $5352
	ld d, $56 ; $5355
	add a, d ; $5357
	ld d, a ; $5358
	script_get_actor_state ACTOR_PLAYER ; $5359
	ld c, l ; $535e
	ld b, h ; $535f
	farcall LoadActorObjectDefIfValid ; $5360
	script_set_anim ACTOR_PLAYER, $01 ; $5363
	script_set_active ACTOR_PLAYER, $00 ; $536a
	ld a, [wStoryModeEntryPoint] ; $5371
	cp a, $0c ; $5374
	jr nz, Label_14_539c ; $5376
	script_set_position ACTOR_PLAYER, $0600, $2700 ; $5378
	xor a, a ; $5383
	ld [wStoryModeShowLocationName], a ; $5384
	script_fade_in $04 ; $5387
	call WaitFadeEnd ; $538c
	ld a, $3b ; $538f
	ld [$c2b0], a ; $5391
	ld a, $a8 ; $5394
	ld [$c2b1], a ; $5396
	jp Label_14_5440 ; $5399
Label_14_539c:
	xor a, a ; $539c
	ld [wStoryModeShowLocationName], a ; $539d
	script_fade_in $06 ; $53a0
	call WaitFadeEnd ; $53a5
	sound $7a ; $53a8
	script_wait_frames $3c ; $53aa
	script_set_position ACTOR_PLAYER, $0600, $2700 ; $53b1
	ld h, $08 ; $53bc
Label_14_53be:
	script_wait_frames $06 ; $53be
	call PlayPlaneMoveSfx_14 ; $53c5
	ld a, [$c2b1] ; $53c8
	inc a ; $53cb
	ld [$c2b1], a ; $53cc
	dec h ; $53cf
	jr nz, Label_14_53be ; $53d0
	ld h, $08 ; $53d2
Label_14_53d4:
	script_wait_frames $05 ; $53d4
	call PlayPlaneMoveSfx_14 ; $53db
	ld a, h ; $53de
	and a, $01 ; $53df
	jr z, Label_14_53ea ; $53e1
	ld a, [$c2b0] ; $53e3
	dec a ; $53e6
	ld [$c2b0], a ; $53e7
Label_14_53ea:
	ld a, [$c2b1] ; $53ea
	inc a ; $53ed
	ld [$c2b1], a ; $53ee
	dec h ; $53f1
	jr nz, Label_14_53d4 ; $53f2
	ld h, $08 ; $53f4
Label_14_53f6:
	script_wait_frames $04 ; $53f6
	call PlayPlaneMoveSfx_14 ; $53fd
	ld a, [$c2b0] ; $5400
	dec a ; $5403
	ld [$c2b0], a ; $5404
	ld a, [$c2b1] ; $5407
	inc a ; $540a
	ld [$c2b1], a ; $540b
	dec h ; $540e
	jr nz, Label_14_53f6 ; $540f
	script_player_speed $0012 ; $5411
	script_move_player_to_actor ACTOR_PLAYER ; $5417
	ld h, $1c ; $541e
Label_14_5420:
	script_wait_frames $03 ; $5420
	call PlayPlaneMoveSfx_14 ; $5427
	ld a, h ; $542a
	and a, $01 ; $542b
	jr z, Label_14_5436 ; $542d
	ld a, [$c2b0] ; $542f
	dec a ; $5432
	ld [$c2b0], a ; $5433
Label_14_5436:
	ld a, [$c2b1] ; $5436
	inc a ; $5439
	ld [$c2b1], a ; $543a
	dec h ; $543d
	jr nz, Label_14_5420 ; $543e
Label_14_5440:
	ld h, $00 ; $5440
Label_14_5442:
	script_wait_frames $03 ; $5442
	inc h ; $5449
	call PlayPlaneMoveSfx_14 ; $544a
	ld a, [$c2b1] ; $544d
	inc a ; $5450
	ld [$c2b1], a ; $5451
	and a, $03 ; $5454
	cp a, $03 ; $5456
	jr nz, Label_14_5461 ; $5458
	ld a, [$c2b0] ; $545a
	dec a ; $545d
	ld [$c2b0], a ; $545e
Label_14_5461:
	ld a, [$c2b0] ; $5461
	cp a, $20 ; $5464
	jr nz, Label_14_5442 ; $5466
	ld h, $08 ; $5468
Label_14_546a:
	script_wait_frames $04 ; $546a
	call PlayPlaneMoveSfx_14 ; $5471
	ld a, [$c2b1] ; $5474
	inc a ; $5477
	ld [$c2b1], a ; $5478
	dec h ; $547b
	jr nz, Label_14_546a ; $547c
	sound $7b ; $547e
	ld h, $08 ; $5480
Label_14_5482:
	script_wait_frames $06 ; $5482
	ld a, [$c2b1] ; $5489
	inc a ; $548c
	ld [$c2b1], a ; $548d
	dec h ; $5490
	jr nz, Label_14_5482 ; $5491
	sound $7d ; $5493
	ld h, $04 ; $5495
Label_14_5497:
	script_wait_frames $08 ; $5497
	ld a, [$c2b1] ; $549e
	inc a ; $54a1
	ld [$c2b1], a ; $54a2
	dec h ; $54a5
	jr nz, Label_14_5497 ; $54a6
	ld a, [wStoryModeEntryPoint] ; $54a8
	cp a, $0c ; $54ab
	jr z, Label_14_54df ; $54ad
	test_flag FLAG_DOUBLES ; $54af
	jr z, Label_14_54bc ; $54b2
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $54b4
	jp z, Label_14_54df ; $54b7
	jr Label_14_54c1 ; $54ba
Label_14_54bc:
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $54bc
	jr z, Label_14_54df ; $54bf
Label_14_54c1:
	ld c, $04 ; $54c1
	call BeginFadeOut ; $54c3
	call WaitFadeEnd ; $54c6
	call ClearFrameTasks ; $54c9
	ld a, $15 ; $54cc
	ld [wStoryModeCurrentLocation], a ; $54ce
	ld a, $04 ; $54d1
	ld [wStoryModeEntryPoint], a ; $54d3
	ld a, $ff ; $54d6
	ld [$c294], a ; $54d8
	ld [wStoryModeExitLocationRequest], a ; $54db
	ret ; $54de
Label_14_54df:
	ld a, $40 ; $54df
	ld [$c2b2], a ; $54e1
	ld a, $00 ; $54e4
	ld [wWaterSpriteMinigameTimer], a ; $54e6
	xor a, a ; $54e9
	ld [wWaterSpriteMinigameSwingCount], a ; $54ea
	ld a, $10 ; $54ed
	ld [$c2bc], a ; $54ef
	ld a, $00 ; $54f2
	ld [$c2be], a ; $54f4
	ld a, $01 ; $54f7
	ld hl, UpdateWaterSplash0_14 ; $54f9
	call RegisterFrameTask ; $54fc
	script_wait_frames $0a ; $54ff
	ld a, $50 ; $5506
	ld [$c2b3], a ; $5508
	ld a, $02 ; $550b
	ld [wWaterSpriteMinigameTimer + 1], a ; $550d
	xor a, a ; $5510
	ld [wWaterSpriteMinigameSwingCount + 1], a ; $5511
	ld a, $10 ; $5514
	ld [$c2bd], a ; $5516
	ld a, $00 ; $5519
	ld [$c2bf], a ; $551b
	ld a, $01 ; $551e
	ld hl, UpdateWaterSplash1_14 ; $5520
	call RegisterFrameTask ; $5523
	script_wait_frames $50 ; $5526
	script_set_position $03, $0600, $2900 ; $552d
	script_set_position $04, $0600, $2900 ; $5538
	script_set_position $05, $0600, $2900 ; $5543
	script_set_position $06, $0600, $2900 ; $554e
	script_set_actor_script $03, ActorScript_14_563b ; $5559
	script_wait_frames $1e ; $5564
	script_set_actor_script $04, ActorScript_14_563b ; $556b
	script_wait_frames $1e ; $5576
	script_set_actor_script $05, ActorScript_14_563b ; $557d
	script_wait_frames $1e ; $5588
	script_set_actor_script $06, ActorScript_14_563b ; $558f
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
	cp a, $0c ; $55ee
	jr nz, Label_14_5603 ; $55f0
	ld a, $01 ; $55f2
	ld [$c2be], a ; $55f4
	ld [$c2bf], a ; $55f7
	ld a, $01 ; $55fa
	ld [$c294], a ; $55fc
	ld [wStoryModeExitLocationRequest], a ; $55ff
	ret ; $5602
Label_14_5603:
	script_move_target ACTOR_PLAYER, $0b00, $2700 ; $5603
	script_wait_move ACTOR_PLAYER ; $560e
	script_set_active ACTOR_PLAYER, $00 ; $5613
	ld c, $04 ; $561a
	call BeginFadeOut ; $561c
	call WaitFadeEnd ; $561f
	call WaitFadeEnd ; $5622
	call ClearFrameTasks ; $5625
	ld a, $0a ; $5628
	ld [wStoryModeCurrentLocation], a ; $562a
	ld a, $09 ; $562d
	ld [wStoryModeEntryPoint], a ; $562f
	ld a, $ff ; $5632
	ld [$c294], a ; $5634
	ld [wStoryModeExitLocationRequest], a ; $5637
	ret ; $563a
ActorScript_14_563b:
	; $563b, 175 bytes (actor_script)
	as_set_target $0b00, $2900
	as_wait_move
	as_set_target $0b00, $2700
	as_wait_move
	as_set_pos $0100, $0100
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_wait $01
	as_target_rel $0205, $0100
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
Gfx_14_56ea:
	INCBIN "data/bank_014/d_56ea.bin" ; $56ea, 870 bytes
IslandObjTiles_14:
	INCBIN "data/bank_014/d_5a50.bin" ; $5a50, 1024 bytes
SpriteTemplate_14_5e50:
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
	; $5e71, 8 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $3808, $7ffc, $294a, $001f ; pal 0: #410073 #e6ffff #525252 #ff0000
LoadPlaneObjGfx_14:
	ldh a, [hWramBank] ; $5e79
	push af ; $5e7b
	wram_bank $01 ; $5e7c
	ld hl, $5650 ; $5e82
	ld de, $a000 ; $5e85
	ld c, $60 ; $5e88
	call QueueVRAMCopy ; $5e8a
	ld hl, IslandObjPalette_14 ; $5e8d
	ld de, $0801 ; $5e90
	call LoadPaletteShadow ; $5e93
	pop af ; $5e96
	wram_bank ; $5e97
	ret ; $5e9b
QueuePlaneSpriteByHeight_14:
	call GetSceneObjectScreenPos_14 ; $5e9c
	ld b, $00 ; $5e9f
	ld a, [$c2b1] ; $5ea1
	sub a, $88 ; $5ea4
	cp a, $0a ; $5ea6
	jr c, Label_14_5ec4 ; $5ea8
	ld b, $10 ; $5eaa
	cp a, $14 ; $5eac
	jr c, Label_14_5ec4 ; $5eae
	ld b, $20 ; $5eb0
	cp a, $1e ; $5eb2
	jr c, Label_14_5ec4 ; $5eb4
	ld b, $30 ; $5eb6
	cp a, $50 ; $5eb8
	jr c, Label_14_5ec4 ; $5eba
	ld b, $20 ; $5ebc
	cp a, $78 ; $5ebe
	jr c, Label_14_5ec4 ; $5ec0
	ld b, $10 ; $5ec2
Label_14_5ec4:
	ld c, b ; $5ec4
	ld hl, SpriteTemplate_14_5e50 ; $5ec5
	ld b, $08 ; $5ec8
	call QueueSpriteTemplate ; $5eca
	ret ; $5ecd
	; $5ece, 2 bytes (fill)
	ds 2, $00
Gfx_14_5ed0:
	INCBIN "data/bank_014/d_5ed0.bin" ; $5ed0, 448 bytes
SpriteTemplate_14_6090:
	; $6090, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
Palette_14_6099:
	; $6099, 8 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $3808, $7ffc, $294a, $001f ; pal 0: #410073 #e6ffff #525252 #ff0000
LoadWaterSplashObjGfx_14:
	ldh a, [hWramBank] ; $60a1
	push af ; $60a3
	wram_bank $01 ; $60a4
	ld hl, Gfx_14_5ed0 ; $60aa
	ld de, $8200 ; $60ad
	ld c, $1c ; $60b0
	call QueueVRAMCopy ; $60b2
	ld hl, Palette_14_6099 ; $60b5
	ld de, $0901 ; $60b8
	call LoadPaletteShadow ; $60bb
	pop af ; $60be
	wram_bank ; $60bf
	ret ; $60c3
UpdateWaterSplash0_14:
	ldh a, [hScrollX] ; $60c4
	ld b, a ; $60c6
	ld a, [$c2b2] ; $60c7
	sub a, b ; $60ca
	ld d, a ; $60cb
	ld a, [$c2be] ; $60cc
	and a, a ; $60cf
	jr nz, Label_14_60d5 ; $60d0
	call AdvanceWaterSplash0Rise_14 ; $60d2
Label_14_60d5:
	ldh a, [hScrollY] ; $60d5
	ld b, a ; $60d7
	ld a, [wWaterSpriteMinigameTimer] ; $60d8
	add a, $20 ; $60db
	sub a, b ; $60dd
	ld e, a ; $60de
	ld a, [$c2be] ; $60df
	and a, a ; $60e2
	jp z, Label_14_60f4 ; $60e3
	ld a, [wWaterSpriteMinigameFlag] ; $60e6
	ld b, a ; $60e9
	ld a, [wWaterSpriteMinigameSwingCount] ; $60ea
	cp a, $14 ; $60ed
	jr c, Label_14_615c ; $60ef
	cp a, b ; $60f1
	jr c, Label_14_616a ; $60f2
Label_14_60f4:
	ld a, [$c2bc] ; $60f4
	and a, a ; $60f7
	jr z, Label_14_6107 ; $60f8
	ld a, $08 ; $60fa
	ld [$c2b8], a ; $60fc
	ld a, $00 ; $60ff
	ld [wWaterSpriteMinigameSwingCount], a ; $6101
	jp Label_14_615c ; $6104
Label_14_6107:
	ld a, [$c2b8] ; $6107
	inc a ; $610a
	ld [$c2b8], a ; $610b
	cp a, $08 ; $610e
	jr c, Label_14_612b ; $6110
	cp a, $08 ; $6112
	jr z, Label_14_6118 ; $6114
	sound $7e ; $6116
Label_14_6118:
	ld a, [$c2b2] ; $6118
	inc a ; $611b
	ld [$c2b2], a ; $611c
	xor a, a ; $611f
	ld [$c2b8], a ; $6120
	ld a, [wWaterSpriteMinigameSwingCount] ; $6123
	add a, $04 ; $6126
	ld [wWaterSpriteMinigameSwingCount], a ; $6128
Label_14_612b:
	ld a, [wWaterSpriteMinigameFlag] ; $612b
	ld b, a ; $612e
	ld a, [wWaterSpriteMinigameSwingCount] ; $612f
	cp a, $14 ; $6132
	jr c, Label_14_615c ; $6134
	cp a, b ; $6136
	jr c, Label_14_616a ; $6137
	xor a, a ; $6139
	ld [wWaterSpriteMinigameSwingCount], a ; $613a
	call AdvanceRandomSeed ; $613d
	ld a, l ; $6140
	and a, $0f ; $6141
	add a, a ; $6143
	add a, $40 ; $6144
	ld [$c2b2], a ; $6146
	ld a, h ; $6149
	and a, $3c ; $614a
	ld [wWaterSpriteMinigameFlag], a ; $614c
	ld a, h ; $614f
	and a, $0f ; $6150
	ld [wWaterSpriteMinigameTimer], a ; $6152
	ld a, $10 ; $6155
	ld [$c2bc], a ; $6157
	jr Label_14_616a ; $615a
Label_14_615c:
	ld a, [wWaterSpriteMinigameSwingCount] ; $615c
	add a, $20 ; $615f
	ld c, a ; $6161
	ld hl, SpriteTemplate_14_6090 ; $6162
	ld b, $01 ; $6165
	call QueueSpriteTemplate ; $6167
Label_14_616a:
	ret ; $616a
AdvanceWaterSplash0Rise_14:
	ld a, [$c2bc] ; $616b
	and a, a ; $616e
	jr z, Label_14_617d ; $616f
	dec a ; $6171
	ld [$c2bc], a ; $6172
	ld a, [wWaterSpriteMinigameTimer] ; $6175
	sub a, $02 ; $6178
	ld [wWaterSpriteMinigameTimer], a ; $617a
Label_14_617d:
	ret ; $617d
UpdateWaterSplash1_14:
	ldh a, [hScrollX] ; $617e
	ld b, a ; $6180
	ld a, [$c2b3] ; $6181
	sub a, b ; $6184
	ld d, a ; $6185
	ld a, [$c2bf] ; $6186
	and a, a ; $6189
	jr nz, Label_14_618f ; $618a
	call AdvanceWaterSplash1Rise_14 ; $618c
Label_14_618f:
	ldh a, [hScrollY] ; $618f
	ld b, a ; $6191
	ld a, [wWaterSpriteMinigameTimer + 1] ; $6192
	add a, $20 ; $6195
	sub a, b ; $6197
	ld e, a ; $6198
	ld a, [$c2bf] ; $6199
	and a, a ; $619c
	jp z, Label_14_61ae ; $619d
	ld a, [$c2bb] ; $61a0
	ld b, a ; $61a3
	ld a, [wWaterSpriteMinigameSwingCount + 1] ; $61a4
	cp a, $14 ; $61a7
	jr c, Label_14_6216 ; $61a9
	cp a, b ; $61ab
	jr c, Label_14_6224 ; $61ac
Label_14_61ae:
	ld a, [$c2bd] ; $61ae
	and a, a ; $61b1
	jr z, Label_14_61c1 ; $61b2
	ld a, $08 ; $61b4
	ld [$c2b9], a ; $61b6
	ld a, $00 ; $61b9
	ld [wWaterSpriteMinigameSwingCount + 1], a ; $61bb
	jp Label_14_6216 ; $61be
Label_14_61c1:
	ld a, [$c2b9] ; $61c1
	inc a ; $61c4
	ld [$c2b9], a ; $61c5
	cp a, $08 ; $61c8
	jr c, Label_14_61e5 ; $61ca
	cp a, $08 ; $61cc
	jr z, Label_14_61d2 ; $61ce
	sound $7e ; $61d0
Label_14_61d2:
	ld a, [$c2b3] ; $61d2
	inc a ; $61d5
	ld [$c2b3], a ; $61d6
	xor a, a ; $61d9
	ld [$c2b9], a ; $61da
	ld a, [wWaterSpriteMinigameSwingCount + 1] ; $61dd
	add a, $04 ; $61e0
	ld [wWaterSpriteMinigameSwingCount + 1], a ; $61e2
Label_14_61e5:
	ld a, [$c2bb] ; $61e5
	ld b, a ; $61e8
	ld a, [wWaterSpriteMinigameSwingCount + 1] ; $61e9
	cp a, $14 ; $61ec
	jr c, Label_14_6216 ; $61ee
	cp a, b ; $61f0
	jr c, Label_14_6224 ; $61f1
	xor a, a ; $61f3
	ld [wWaterSpriteMinigameSwingCount + 1], a ; $61f4
	call AdvanceRandomSeed ; $61f7
	ld a, l ; $61fa
	and a, $0f ; $61fb
	add a, a ; $61fd
	add a, $40 ; $61fe
	ld [$c2b3], a ; $6200
	ld a, l ; $6203
	and a, $3f ; $6204
	ld [$c2bb], a ; $6206
	ld a, h ; $6209
	and a, $0f ; $620a
	ld [wWaterSpriteMinigameTimer + 1], a ; $620c
	ld a, $10 ; $620f
	ld [$c2bd], a ; $6211
	jr Label_14_6224 ; $6214
Label_14_6216:
	ld a, [wWaterSpriteMinigameSwingCount + 1] ; $6216
	add a, $20 ; $6219
	ld c, a ; $621b
	ld hl, SpriteTemplate_14_6090 ; $621c
	ld b, $01 ; $621f
	call QueueSpriteTemplate ; $6221
Label_14_6224:
	ret ; $6224
AdvanceWaterSplash1Rise_14:
	ld a, [$c2bd] ; $6225
	and a, a ; $6228
	jr z, Label_14_6237 ; $6229
	dec a ; $622b
	ld [$c2bd], a ; $622c
	ld a, [wWaterSpriteMinigameTimer + 1] ; $622f
	sub a, $02 ; $6232
	ld [wWaterSpriteMinigameTimer + 1], a ; $6234
Label_14_6237:
	ret ; $6237
LoadPlaneObjGfx2_14:
	ldh a, [hWramBank] ; $6238
	push af ; $623a
	wram_bank $01 ; $623b
	ld hl, IslandObjTiles_14 ; $6241
	ld de, $a000 ; $6244
	ld c, $60 ; $6247
	call QueueVRAMCopy ; $6249
	ld hl, IslandObjPalette_14 ; $624c
	ld de, $0801 ; $624f
	call LoadPaletteShadow ; $6252
	pop af ; $6255
	wram_bank ; $6256
	ret ; $625a
QueuePlaneSpriteByFrameCounter_14:
	call GetSceneObjectScreenPos_14 ; $625b
	ld b, $10 ; $625e
	ld a, [$c2b2] ; $6260
	cp a, $14 ; $6263
	jr c, Label_14_6281 ; $6265
	ld b, $20 ; $6267
	cp a, $1e ; $6269
	jr c, Label_14_6281 ; $626b
	ld b, $30 ; $626d
	cp a, $5a ; $626f
	jr c, Label_14_6281 ; $6271
	ld b, $20 ; $6273
	cp a, $78 ; $6275
	jr c, Label_14_6281 ; $6277
	ld b, $10 ; $6279
	cp a, $8c ; $627b
	jr c, Label_14_6281 ; $627d
	ld b, $00 ; $627f
Label_14_6281:
	ld c, b ; $6281
	ld hl, SpriteTemplate_14_5e50 ; $6282
	ld b, $08 ; $6285
	call QueueSpriteTemplate ; $6287
	ret ; $628a
Label_14_628b:
	clear_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $628b
	call DisableLCDSafely ; $628e
	call LoadPlaneObjGfx2_14 ; $6291
	call EnableLCD ; $6294
	ld a, $20 ; $6297
	ld [$c2b0], a ; $6299
	ld a, $28 ; $629c
	ld [$c2b1], a ; $629e
	ld a, $00 ; $62a1
	ld [$c2b2], a ; $62a3
	ld a, $01 ; $62a6
	ld hl, QueuePlaneSpriteByFrameCounter_14 ; $62a8
	call RegisterFrameTask ; $62ab
	script_set_active ACTOR_PLAYER, $00 ; $62ae
	script_set_active $03, $00 ; $62b5
	test_flag FLAG_DOUBLES ; $62bc
	jp z, Label_14_62d2 ; $62bf
	script_null_script ACTOR_PARTNER ; $62c2
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $62c7
Label_14_62d2:
	xor a, a ; $62d2
	ld [wStoryModeShowLocationName], a ; $62d3
	script_fade_in $06 ; $62d6
	call WaitFadeEnd ; $62db
	sound $7a ; $62de
	script_wait_frames $3c ; $62e0
	script_set_position ACTOR_PLAYER, $0c00, $1300 ; $62e7
	ld h, $08 ; $62f2
Label_14_62f4:
	script_wait_frames $06 ; $62f4
	call PlayPlaneMoveSfx_14 ; $62fb
	ld a, [$c2b1] ; $62fe
	dec a ; $6301
	ld [$c2b1], a ; $6302
	call AdvancePlaneFrameCounter_14 ; $6305
	dec h ; $6308
	jr nz, Label_14_62f4 ; $6309
	ld h, $08 ; $630b
Label_14_630d:
	script_wait_frames $05 ; $630d
	call PlayPlaneMoveSfx_14 ; $6314
	ld a, h ; $6317
	and a, $01 ; $6318
	jr z, Label_14_6323 ; $631a
	ld a, [$c2b0] ; $631c
	inc a ; $631f
	ld [$c2b0], a ; $6320
Label_14_6323:
	ld a, [$c2b1] ; $6323
	dec a ; $6326
	ld [$c2b1], a ; $6327
	call AdvancePlaneFrameCounter_14 ; $632a
	dec h ; $632d
	jr nz, Label_14_630d ; $632e
	ld h, $08 ; $6330
Label_14_6332:
	script_wait_frames $04 ; $6332
	call PlayPlaneMoveSfx_14 ; $6339
	ld a, [$c2b0] ; $633c
	inc a ; $633f
	ld [$c2b0], a ; $6340
	ld a, [$c2b1] ; $6343
	dec a ; $6346
	ld [$c2b1], a ; $6347
	call AdvancePlaneFrameCounter_14 ; $634a
	dec h ; $634d
	jr nz, Label_14_6332 ; $634e
	script_player_speed $0012 ; $6350
	script_move_player_to_actor ACTOR_PLAYER ; $6356
	ld h, $1c ; $635d
Label_14_635f:
	script_wait_frames $03 ; $635f
	call PlayPlaneMoveSfx_14 ; $6366
	ld a, h ; $6369
	and a, $01 ; $636a
	jr z, Label_14_6375 ; $636c
	ld a, [$c2b0] ; $636e
	inc a ; $6371
	ld [$c2b0], a ; $6372
Label_14_6375:
	ld a, [$c2b1] ; $6375
	dec a ; $6378
	ld [$c2b1], a ; $6379
	call AdvancePlaneFrameCounter_14 ; $637c
	dec h ; $637f
	jr nz, Label_14_635f ; $6380
	ld h, $00 ; $6382
Label_14_6384:
	script_wait_frames $03 ; $6384
	inc h ; $638b
	call PlayPlaneMoveSfx_14 ; $638c
	ld a, [$c2b1] ; $638f
	dec a ; $6392
	ld [$c2b1], a ; $6393
	and a, $03 ; $6396
	cp a, $03 ; $6398
	jr nz, Label_14_63a3 ; $639a
	ld a, [$c2b0] ; $639c
	inc a ; $639f
	ld [$c2b0], a ; $63a0
Label_14_63a3:
	call AdvancePlaneFrameCounter_14 ; $63a3
	ld a, [$c2b0] ; $63a6
	cp a, $50 ; $63a9
	jr nz, Label_14_6384 ; $63ab
	ld h, $08 ; $63ad
Label_14_63af:
	script_wait_frames $04 ; $63af
	call PlayPlaneMoveSfx_14 ; $63b6
	ld a, [$c2b1] ; $63b9
	dec a ; $63bc
	ld [$c2b1], a ; $63bd
	call AdvancePlaneFrameCounter_14 ; $63c0
	dec h ; $63c3
	jr nz, Label_14_63af ; $63c4
	ld h, $08 ; $63c6
Label_14_63c8:
	script_wait_frames $06 ; $63c8
	call PlayPlaneMoveSfx_14 ; $63cf
	ld a, [$c2b1] ; $63d2
	dec a ; $63d5
	ld [$c2b1], a ; $63d6
	call AdvancePlaneFrameCounter_14 ; $63d9
	dec h ; $63dc
	jr nz, Label_14_63c8 ; $63dd
	ld h, $08 ; $63df
Label_14_63e1:
	script_wait_frames $08 ; $63e1
	call PlayPlaneMoveSfx_14 ; $63e8
	ld a, [$c2b1] ; $63eb
	dec a ; $63ee
	ld [$c2b1], a ; $63ef
	call AdvancePlaneFrameCounter_14 ; $63f2
	dec h ; $63f5
	jr nz, Label_14_63e1 ; $63f6
	sound $7d ; $63f8
	script_wait_frames $32 ; $63fa
	ld c, $04 ; $6401
	call BeginFadeOut ; $6403
	call WaitFadeEnd ; $6406
	call ClearFrameTasks ; $6409
	ld a, $14 ; $640c
	ld [wStoryModeCurrentLocation], a ; $640e
	ld a, $02 ; $6411
	ld [wStoryModeEntryPoint], a ; $6413
	ld a, $ff ; $6416
	ld [$c294], a ; $6418
	ld [wStoryModeExitLocationRequest], a ; $641b
	ret ; $641e
AdvancePlaneFrameCounter_14:
	ld a, [$c2b2] ; $641f
	inc a ; $6422
	ld [$c2b2], a ; $6423
	ret ; $6426
LoadFireworkObjGfx_14:
	ldh a, [hWramBank] ; $6427
	push af ; $6429
	wram_bank $01 ; $642a
	ld hl, FireworkObjTiles_14 ; $6430
	ld de, $8100 ; $6433
	ld c, $80 ; $6436
	call QueueVRAMCopy ; $6438
	ld hl, FireworkObjPalettes_14 ; $643b
	ld de, $0904 ; $643e
	call LoadPaletteShadow ; $6441
	pop af ; $6444
	wram_bank ; $6445
	ret ; $6449
UpdateFirework0_14:
	ld a, [wWaterSpriteMinigameSwingCount] ; $644a
	cp a, $04 ; $644d
	jp nc, Label_14_64bd ; $644f
	ld a, [wWaterSpriteMinigameSwingCount] ; $6452
	and a, a ; $6455
	jr nz, Label_14_645b ; $6456
	call AdvanceFirework0Ascent_14 ; $6458
Label_14_645b:
	ldh a, [hScrollX] ; $645b
	ld b, a ; $645d
	ld a, [$c2b2] ; $645e
	sub a, b ; $6461
	ld d, a ; $6462
	ldh a, [hScrollY] ; $6463
	ld b, a ; $6465
	ld a, [wWaterSpriteMinigameTimer] ; $6466
	sub a, b ; $6469
	ld e, a ; $646a
	ld a, [$c2b8] ; $646b
	dec a ; $646e
	ld [$c2b8], a ; $646f
	and a, a ; $6472
	jp nz, Label_14_64a0 ; $6473
	ld a, [wWaterSpriteMinigameSwingCount] ; $6476
	inc a ; $6479
	ld [wWaterSpriteMinigameSwingCount], a ; $647a
	cp a, $04 ; $647d
	jp nc, Label_14_64bd ; $647f
	ld a, [wWaterSpriteMinigameSwingCount] ; $6482
	add a, $d5 ; $6485
	ld l, a ; $6487
	adc a, $64 ; $6488
	sub a, l ; $648a
	ld h, a ; $648b
	ld a, [hl] ; $648c
	ld [$c2b8], a ; $648d
	ld a, [wWaterSpriteMinigameSwingCount] ; $6490
	cp a, $01 ; $6493
	jr nz, Label_14_64a0 ; $6495
	ld a, [$c2b8] ; $6497
	cp a, $0c ; $649a
	jr nz, Label_14_64a0 ; $649c
	sound $81 ; $649e
Label_14_64a0:
	ld a, [wWaterSpriteMinigameSwingCount] ; $64a0
	add a, $d9 ; $64a3
	ld l, a ; $64a5
	adc a, $64 ; $64a6
	sub a, l ; $64a8
	ld h, a ; $64a9
	ld a, [hl] ; $64aa
	add a, $10 ; $64ab
	ld c, a ; $64ad
	ld a, [$c2b8] ; $64ae
	srl a ; $64b1
	and a, $03 ; $64b3
	inc a ; $64b5
	ld b, a ; $64b6
	ld hl, SpriteTemplate_14_6e80 ; $64b7
	call QueueSpriteTemplate ; $64ba
Label_14_64bd:
	ret ; $64bd
AdvanceFirework0Ascent_14:
	ld b, $03 ; $64be
	ld a, [$c2b8] ; $64c0
	cp a, $14 ; $64c3
	jr nc, Label_14_64cd ; $64c5
	dec b ; $64c7
	cp a, $0a ; $64c8
	jr nc, Label_14_64cd ; $64ca
	dec b ; $64cc
Label_14_64cd:
	ld a, [wWaterSpriteMinigameTimer] ; $64cd
	sub a, b ; $64d0
	ld [wWaterSpriteMinigameTimer], a ; $64d1
	ret ; $64d4
Table_14_64d5:
	; $64d5, 12 bytes (bytes:4)
	db $00, $0c, $0e, $10 ; 0x00
	db $00, $20, $30, $40 ; 0x04
	db $00, $50, $60, $70 ; 0x08
Label_14_64e1:
	ldh a, [hRomBank] ; $64e1
	ld hl, FireworkMapActors_14 ; $64e3
	farcall ScriptRespawnLocationActors ; $64e6
	farcall BeginCutsceneScriptMode ; $64e9
	call DisableLCDSafely ; $64ec
	call LoadFireworkObjGfx_14 ; $64ef
	call EnableLCD ; $64f2
	test_flag FLAG_DOUBLES ; $64f5
	jp z, Label_14_650b ; $64f8
	script_null_script ACTOR_PARTNER ; $64fb
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $6500
Label_14_650b:
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $650b
	xor a, a ; $6516
	ld [wStoryModeShowLocationName], a ; $6517
	script_fade_in $04 ; $651a
	call WaitFadeEnd ; $651f
	script_player_speed $0006 ; $6522
	script_move_player $0500, $2300 ; $6528
	farcall WaitPlayerMoveDone ; $6532
	script_wait_frames $32 ; $6535
	ld a, $50 ; $653c
	ld [$c2b3], a ; $653e
	ld a, $28 ; $6541
	ld [wWaterSpriteMinigameTimer + 1], a ; $6543
	ld a, $00 ; $6546
	ld [wWaterSpriteMinigameSwingCount + 1], a ; $6548
	ld a, $1e ; $654b
	ld [$c2b9], a ; $654d
	ld a, $01 ; $6550
	ld hl, UpdateFirework1_14 ; $6552
	call RegisterFrameTask ; $6555
	script_wait_frames $50 ; $6558
	ld a, $40 ; $655f
	ld [$c2b2], a ; $6561
	ld a, $20 ; $6564
	ld [wWaterSpriteMinigameTimer], a ; $6566
	ld a, $00 ; $6569
	ld [wWaterSpriteMinigameSwingCount], a ; $656b
	ld a, $1e ; $656e
	ld [$c2b8], a ; $6570
	ld a, $01 ; $6573
	ld hl, UpdateFirework0_14 ; $6575
	call RegisterFrameTask ; $6578
	script_wait_frames $50 ; $657b
	ld a, $48 ; $6582
	ld [$c2b3], a ; $6584
	ld a, $28 ; $6587
	ld [wWaterSpriteMinigameTimer + 1], a ; $6589
	ld a, $00 ; $658c
	ld [wWaterSpriteMinigameSwingCount + 1], a ; $658e
	ld a, $1e ; $6591
	ld [$c2b9], a ; $6593
	script_wait_frames $28 ; $6596
	ld a, $38 ; $659d
	ld [$c2b2], a ; $659f
	ld a, $20 ; $65a2
	ld [wWaterSpriteMinigameTimer], a ; $65a4
	ld a, $00 ; $65a7
	ld [wWaterSpriteMinigameSwingCount], a ; $65a9
	ld a, $1e ; $65ac
	ld [$c2b8], a ; $65ae
	script_wait_frames $28 ; $65b1
	ld a, $50 ; $65b8
	ld [$c2b3], a ; $65ba
	ld a, $28 ; $65bd
	ld [wWaterSpriteMinigameTimer + 1], a ; $65bf
	ld a, $00 ; $65c2
	ld [wWaterSpriteMinigameSwingCount + 1], a ; $65c4
	ld a, $19 ; $65c7
	ld [$c2b9], a ; $65c9
	script_wait_frames $28 ; $65cc
	ld a, $38 ; $65d3
	ld [$c2b2], a ; $65d5
	ld a, $20 ; $65d8
	ld [wWaterSpriteMinigameTimer], a ; $65da
	ld a, $00 ; $65dd
	ld [wWaterSpriteMinigameSwingCount], a ; $65df
	ld a, $1a ; $65e2
	ld [$c2b8], a ; $65e4
	script_wait_frames $28 ; $65e7
	ld a, $58 ; $65ee
	ld [$c2b3], a ; $65f0
	ld a, $28 ; $65f3
	ld [wWaterSpriteMinigameTimer + 1], a ; $65f5
	ld a, $00 ; $65f8
	ld [wWaterSpriteMinigameSwingCount + 1], a ; $65fa
	ld a, $1c ; $65fd
	ld [$c2b9], a ; $65ff
	script_wait_frames $28 ; $6602
	ld a, $40 ; $6609
	ld [$c2b2], a ; $660b
	ld a, $20 ; $660e
	ld [wWaterSpriteMinigameTimer], a ; $6610
	ld a, $00 ; $6613
	ld [wWaterSpriteMinigameSwingCount], a ; $6615
	ld a, $16 ; $6618
	ld [$c2b8], a ; $661a
	script_wait_frames $32 ; $661d
	ld a, $48 ; $6624
	ld [$c2b3], a ; $6626
	ld a, $28 ; $6629
	ld [wWaterSpriteMinigameTimer + 1], a ; $662b
	ld a, $00 ; $662e
	ld [wWaterSpriteMinigameSwingCount + 1], a ; $6630
	ld a, $1c ; $6633
	ld [$c2b9], a ; $6635
	script_wait_frames $48 ; $6638
	ld c, $04 ; $663f
	call BeginFadeOut ; $6641
	call WaitFadeEnd ; $6644
	call ClearFrameTasks ; $6647
	test_flag FLAG_DOUBLES ; $664a
	jr z, Label_14_6662 ; $664d
	ld a, $1a ; $664f
	ld [wStoryModeCurrentLocation], a ; $6651
	ld a, $0b ; $6654
	ld [wStoryModeEntryPoint], a ; $6656
	ld a, $ff ; $6659
	ld [$c294], a ; $665b
	ld [wStoryModeExitLocationRequest], a ; $665e
	ret ; $6661
Label_14_6662:
	ld a, $1a ; $6662
	ld [wStoryModeCurrentLocation], a ; $6664
	ld a, $0a ; $6667
	ld [wStoryModeEntryPoint], a ; $6669
	ld a, $ff ; $666c
	ld [$c294], a ; $666e
	ld [wStoryModeExitLocationRequest], a ; $6671
	ret ; $6674
FireworkMapActors_14:
	; $6675, 11 bytes (map_actors)
	map_actor_end
	db $00
FireworkObjTiles_14:
	INCBIN "data/bank_014/d_6680.bin" ; $6680, 2048 bytes
SpriteTemplate_14_6e80:
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
	; $6ea1, 79 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0000, $7fe0, $03ff, $7c1f ; pal 0: #000000 #00ffff #ffff00 #ff00ff
	dw $0000, $7c1f, $7fe0, $03ff ; pal 1: #000000 #ff00ff #00ffff #ffff00
	dw $0000, $03ff, $7c1f, $7fe0 ; pal 2: #000000 #ffff00 #ff00ff #00ffff
	dw $0000, $7c1f, $7fe0, $03ff ; pal 3: #000000 #ff00ff #00ffff #ffff00
	dw $94f0, $02e6, $2828, $403e ; pal 4: #833929 #31bd00 #410852 #f60883
	dw $b2ea, $3ec2, $ea30, $c2b4 ; pal 5: #52bd62 #10b47b #838bd5 #a4ac83
	dw $003e, $b6ea, $3ec2, $ea1e ; pal 6: #f60800 #52bd6a #10b47b #f683d5
	dw $c2b8, $683e, $b3ea, $3ec2 ; pal 7: #c5ac83 #f608d5 #52ff62 #10b47b
	dw $ea38, $c2b5, $003e, $b7ea ; pal 8: #c58bd5 #acac83 #f60800 #52ff6a
	db $c2, $3e, $1e, $ea, $b9, $c2, $c9
UpdateFirework1_14:
	ld a, [wWaterSpriteMinigameSwingCount + 1] ; $6ef0
	cp a, $04 ; $6ef3
	jp nc, Label_14_6f63 ; $6ef5
	ld a, [wWaterSpriteMinigameSwingCount + 1] ; $6ef8
	and a, a ; $6efb
	jr nz, Label_14_6f01 ; $6efc
	call AdvanceFirework1Ascent_14 ; $6efe
Label_14_6f01:
	ldh a, [hScrollX] ; $6f01
	ld b, a ; $6f03
	ld a, [$c2b3] ; $6f04
	sub a, b ; $6f07
	ld d, a ; $6f08
	ldh a, [hScrollY] ; $6f09
	ld b, a ; $6f0b
	ld a, [wWaterSpriteMinigameTimer + 1] ; $6f0c
	sub a, b ; $6f0f
	ld e, a ; $6f10
	ld a, [$c2b9] ; $6f11
	dec a ; $6f14
	ld [$c2b9], a ; $6f15
	and a, a ; $6f18
	jp nz, Label_14_6f46 ; $6f19
	ld a, [wWaterSpriteMinigameSwingCount + 1] ; $6f1c
	inc a ; $6f1f
	ld [wWaterSpriteMinigameSwingCount + 1], a ; $6f20
	cp a, $04 ; $6f23
	jp nc, Label_14_6f63 ; $6f25
	ld a, [wWaterSpriteMinigameSwingCount + 1] ; $6f28
	add a, $d5 ; $6f2b
	ld l, a ; $6f2d
	adc a, $64 ; $6f2e
	sub a, l ; $6f30
	ld h, a ; $6f31
	ld a, [hl] ; $6f32
	ld [$c2b9], a ; $6f33
	ld a, [wWaterSpriteMinigameSwingCount + 1] ; $6f36
	cp a, $01 ; $6f39
	jr nz, Label_14_6f46 ; $6f3b
	ld a, [$c2b9] ; $6f3d
	cp a, $0c ; $6f40
	jr nz, Label_14_6f46 ; $6f42
	sound $81 ; $6f44
Label_14_6f46:
	ld a, [wWaterSpriteMinigameSwingCount + 1] ; $6f46
	add a, $dd ; $6f49
	ld l, a ; $6f4b
	adc a, $64 ; $6f4c
	sub a, l ; $6f4e
	ld h, a ; $6f4f
	ld a, [hl] ; $6f50
	add a, $10 ; $6f51
	ld c, a ; $6f53
	ld a, [$c2b9] ; $6f54
	srl a ; $6f57
	and a, $03 ; $6f59
	inc a ; $6f5b
	ld b, a ; $6f5c
	ld hl, SpriteTemplate_14_6e80 ; $6f5d
	call QueueSpriteTemplate ; $6f60
Label_14_6f63:
	ret ; $6f63
AdvanceFirework1Ascent_14:
	ld b, $03 ; $6f64
	ld a, [$c2b9] ; $6f66
	cp a, $14 ; $6f69
	jr nc, Label_14_6f73 ; $6f6b
	dec b ; $6f6d
	cp a, $0a ; $6f6e
	jr nc, Label_14_6f73 ; $6f70
	dec b ; $6f72
Label_14_6f73:
	ld a, [wWaterSpriteMinigameTimer + 1] ; $6f73
	sub a, b ; $6f76
	ld [wWaterSpriteMinigameTimer + 1], a ; $6f77
	ret ; $6f7a
Label_14_6f7b:
	call DisableLCDSafely ; $6f7b
	call LoadPlaneObjGfx_14 ; $6f7e
	call LoadIslandSkyEffectObjGfx_14 ; $6f81
	call EnableLCD ; $6f84
	ld a, $50 ; $6f87
	ld [$c2b0], a ; $6f89
	ld a, $88 ; $6f8c
	ld [$c2b1], a ; $6f8e
	ld a, $01 ; $6f91
	ld hl, QueuePlaneSpriteByHeight_14 ; $6f93
	call RegisterFrameTask ; $6f96
	ld a, $00 ; $6f99
	ld [wWaterSpriteMinigameFlag], a ; $6f9b
	ld [$c2bb], a ; $6f9e
	ld [$c2be], a ; $6fa1
	ld a, $01 ; $6fa4
	ld hl, AnimateIslandSkyEffectSprites_14 ; $6fa6
	call RegisterFrameTask ; $6fa9
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $6fac
	test_flag FLAG_DOUBLES ; $6fb7
	jp z, Label_14_6fcd ; $6fba
	script_null_script ACTOR_PARTNER ; $6fbd
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $6fc2
Label_14_6fcd:
	xor a, a ; $6fcd
	ld [wStoryModeShowLocationName], a ; $6fce
	script_fade_in $06 ; $6fd1
	call WaitFadeEnd ; $6fd6
	sound $7a ; $6fd9
	script_wait_frames $3c ; $6fdb
	ld h, $08 ; $6fe2
Label_14_6fe4:
	script_wait_frames $06 ; $6fe4
	call PlayPlaneMoveSfx_14 ; $6feb
	ld a, [$c2b1] ; $6fee
	inc a ; $6ff1
	ld [$c2b1], a ; $6ff2
	dec h ; $6ff5
	jr nz, Label_14_6fe4 ; $6ff6
	ld h, $08 ; $6ff8
Label_14_6ffa:
	script_wait_frames $04 ; $6ffa
	call PlayPlaneMoveSfx_14 ; $7001
	ld a, [$c2b1] ; $7004
	inc a ; $7007
	ld [$c2b1], a ; $7008
	and a, $01 ; $700b
	ld b, a ; $700d
	ld a, [$c2b0] ; $700e
	add a, b ; $7011
	ld [$c2b0], a ; $7012
	dec h ; $7015
	jr nz, Label_14_6ffa ; $7016
	ld h, $18 ; $7018
Label_14_701a:
	script_wait_frames $03 ; $701a
	call PlayPlaneMoveSfx_14 ; $7021
	ld a, [$c2b1] ; $7024
	inc a ; $7027
	ld [$c2b1], a ; $7028
	ld a, [$c2b0] ; $702b
	inc a ; $702e
	ld [$c2b0], a ; $702f
	dec h ; $7032
	jr nz, Label_14_701a ; $7033
	script_player_speed $0012 ; $7035
	script_move_player $0b00, $1800 ; $703b
	ld h, $18 ; $7045
Label_14_7047:
	script_wait_frames $02 ; $7047
	call PlayPlaneMoveSfx_14 ; $704e
	ld a, [$c2b0] ; $7051
	inc a ; $7054
	ld [$c2b0], a ; $7055
	and a, $01 ; $7058
	ld b, a ; $705a
	ld a, [$c2b1] ; $705b
	add a, b ; $705e
	ld [$c2b1], a ; $705f
	dec h ; $7062
	jr nz, Label_14_7047 ; $7063
	ld h, $20 ; $7065
Label_14_7067:
	script_wait_frames $02 ; $7067
	call PlayPlaneMoveSfx_14 ; $706e
	ld a, [$c2b0] ; $7071
	inc a ; $7074
	ld [$c2b0], a ; $7075
	and a, $03 ; $7078
	cp a, $03 ; $707a
	jr nz, Label_14_7085 ; $707c
	ld a, [$c2b1] ; $707e
	inc a ; $7081
	ld [$c2b1], a ; $7082
Label_14_7085:
	dec h ; $7085
	jr nz, Label_14_7067 ; $7086
	ld hl, QueuePlaneSpriteByHeight_14 ; $7088
	call UnregisterFrameTask ; $708b
	ld h, $1e ; $708e
Label_14_7090:
	script_wait_frames $02 ; $7090
	call PlayPlaneMoveSfx_14 ; $7097
	dec h ; $709a
	jr nz, Label_14_7090 ; $709b
	script_move_player $0b00, $0d00 ; $709d
	call LoadDistantPlaneObjGfx_14 ; $70a7
	ld a, $04 ; $70aa
	ld [wWaterSpriteMinigameSwingCount], a ; $70ac
	ld a, $a8 ; $70af
	ld [$c2b1], a ; $70b1
	ld a, $01 ; $70b4
	ld hl, QueueDistantPlaneSprite_14 ; $70b6
	call RegisterFrameTask ; $70b9
	ld h, $50 ; $70bc
Label_14_70be:
	script_wait_frames $02 ; $70be
	call PlayPlaneMoveSfx_14 ; $70c5
	ld a, [$c2b1] ; $70c8
	dec a ; $70cb
	ld [$c2b1], a ; $70cc
	ld a, [$c2b0] ; $70cf
	dec a ; $70d2
	ld [$c2b0], a ; $70d3
	ld a, h ; $70d6
	cp a, $1e ; $70d7
	jr nz, Label_14_70e0 ; $70d9
	ld a, $00 ; $70db
	ld [wWaterSpriteMinigameSwingCount], a ; $70dd
Label_14_70e0:
	dec h ; $70e0
	jr nz, Label_14_70be ; $70e1
	ld hl, QueueDistantPlaneSprite_14 ; $70e3
	call UnregisterFrameTask ; $70e6
	call LoadTwinkleObjGfx_14 ; $70e9
	call PlayTwinkleAnimation_14 ; $70ec
	script_wait_frames $46 ; $70ef
	ld a, [wStoryModeEntryPoint] ; $70f6
	cp a, $0d ; $70f9
	jp nz, Label_14_710c ; $70fb
	ld a, $01 ; $70fe
	ld [$c2be], a ; $7100
	ld a, $01 ; $7103
	ld [$c294], a ; $7105
	ld [wStoryModeExitLocationRequest], a ; $7108
	ret ; $710b
Label_14_710c:
	test_flag FLAG_DOUBLES ; $710c
	jp z, Label_14_711c ; $710f
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7112
	jr nz, Label_14_7149 ; $7115
	set_flag FLAG_STORY_COMPLETE_DOUBLES ; $7117
	jr Label_14_7124 ; $711a
Label_14_711c:
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $711c
	jr nz, Label_14_7150 ; $711f
	set_flag FLAG_STORY_COMPLETE_SINGLES ; $7121
Label_14_7124:
	ld b, $1d ; $7124
	ld c, $0f ; $7126
	farcall SaveStoryReturnPoint ; $7128
	farcall SaveStorySlotWithTimer ; $712b
	ld c, $01 ; $712e
	call BeginFadeOut ; $7130
	call WaitFadeEnd ; $7133
	ld a, $00 ; $7136
	ld [wStoryModeCurrentLocation], a ; $7138
	ld a, $0a ; $713b
	ld [wStoryModeEntryPoint], a ; $713d
	ld a, $ff ; $7140
	ld [$c294], a ; $7142
	ld [wStoryModeExitLocationRequest], a ; $7145
	ret ; $7148
Label_14_7149:
	test_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $7149
	jr z, Label_14_7170 ; $714c
	jr Label_14_7155 ; $714e
Label_14_7150:
	test_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $7150
	jr z, Label_14_7170 ; $7153
Label_14_7155:
	ld c, $04 ; $7155
	call BeginFadeOut ; $7157
	call WaitFadeEnd ; $715a
	ld a, $1d ; $715d
	ld [wStoryModeCurrentLocation], a ; $715f
	ld a, $01 ; $7162
	ld [wStoryModeEntryPoint], a ; $7164
	ld a, $ff ; $7167
	ld [$c294], a ; $7169
	ld [wStoryModeExitLocationRequest], a ; $716c
	ret ; $716f
Label_14_7170:
	ld c, $04 ; $7170
	call BeginFadeOut ; $7172
	call WaitFadeEnd ; $7175
	ld a, $1d ; $7178
	ld [wStoryModeCurrentLocation], a ; $717a
	ld a, $0f ; $717d
	ld [wStoryModeEntryPoint], a ; $717f
	ld a, $ff ; $7182
	ld [$c294], a ; $7184
	ld [wStoryModeExitLocationRequest], a ; $7187
	ret ; $718a
	; $718b, 5 bytes (fill)
	ds 5, $00
IslandSkyTilesA_14:
	INCBIN "data/bank_014/d_7190.bin" ; $7190, 256 bytes
IslandSkyTilesB_14:
	INCBIN "data/bank_014/d_7290.bin" ; $7290, 192 bytes
IslandSkySpriteData_14:
	INCBIN "data/bank_014/d_7350.bin" ; $7350, 33 bytes
SpriteTemplate_14_7371:
	; $7371, 25 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite_end
IslandSkyPalettes_14:
	; $738a, 32 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $2008, $201f, $035f, $1306 ; pal 0: #410041 #ff0041 #ffd500 #31c520
	dw $2008, $035f, $1306, $201f ; pal 1: #410041 #ffd500 #31c520 #ff0041
	dw $2008, $1306, $201f, $035f ; pal 2: #410041 #31c520 #ff0041 #ffd500
	dw $2008, $035f, $1306, $201f ; pal 3: #410041 #ffd500 #31c520 #ff0041
LoadIslandSkyEffectObjGfx_14:
	ldh a, [hWramBank] ; $73aa
	push af ; $73ac
	wram_bank $01 ; $73ad
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
	pop af ; $73d2
	wram_bank ; $73d3
	ret ; $73d7
AnimateIslandSkyEffectSprites_14:
	ldh a, [hScrollX] ; $73d8
	ld b, a ; $73da
	ld a, $40 ; $73db
	sub a, b ; $73dd
	ld d, a ; $73de
	ldh a, [hScrollY] ; $73df
	ld b, a ; $73e1
	ld a, $40 ; $73e2
	sub a, b ; $73e4
	ld e, a ; $73e5
	ld c, $10 ; $73e6
	ld hl, IslandSkySpriteData_14 ; $73e8
	ld a, [$c2be] ; $73eb
	and a, a ; $73ee
	jr nz, Label_14_73f8 ; $73ef
	ld a, [wWaterSpriteMinigameFlag] ; $73f1
	inc a ; $73f4
	ld [wWaterSpriteMinigameFlag], a ; $73f5
Label_14_73f8:
	ld a, [wWaterSpriteMinigameFlag] ; $73f8
	swap a ; $73fb
	and a, $03 ; $73fd
	cp a, $03 ; $73ff
	jr nz, Label_14_7408 ; $7401
	ld a, $00 ; $7403
	ld [wWaterSpriteMinigameFlag], a ; $7405
Label_14_7408:
	inc a ; $7408
	ld b, a ; $7409
	call QueueSpriteTemplate ; $740a
	ldh a, [hScrollX] ; $740d
	ld b, a ; $740f
	ld a, $68 ; $7410
	sub a, b ; $7412
	ld d, a ; $7413
	ldh a, [hScrollY] ; $7414
	ld b, a ; $7416
	ld a, $50 ; $7417
	sub a, b ; $7419
	ld e, a ; $741a
	ld c, $20 ; $741b
	ld hl, SpriteTemplate_14_7371 ; $741d
	ld a, [wWaterSpriteMinigameFlag] ; $7420
	swap a ; $7423
	and a, $03 ; $7425
	inc a ; $7427
	ld b, a ; $7428
	call QueueSpriteTemplate ; $7429
	ret ; $742c
	; $742d, 3 bytes (fill)
	ds 3, $00
Gfx_14_7430:
	INCBIN "data/bank_014/d_7430.bin" ; $7430, 256 bytes
SpriteTemplate_14_7530:
	; $7530, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadDistantPlaneObjGfx_14:
	ldh a, [hWramBank] ; $7539
	push af ; $753b
	wram_bank $01 ; $753c
	ld hl, Gfx_14_7430 ; $7542
	ld de, $a000 ; $7545
	ld c, $10 ; $7548
	call QueueVRAMCopy ; $754a
	ld hl, IslandObjPalette_14 ; $754d
	ld de, $0801 ; $7550
	call LoadPaletteShadow ; $7553
	pop af ; $7556
	wram_bank ; $7557
	ret ; $755b
QueueDistantPlaneSprite_14:
	call GetSceneObjectScreenPos_14 ; $755c
	ld a, [wWaterSpriteMinigameSwingCount] ; $755f
	ld c, a ; $7562
	ld c, a ; $7563
	ld hl, SpriteTemplate_14_7530 ; $7564
	ld b, $08 ; $7567
	call QueueSpriteTemplate ; $7569
	ret ; $756c
GetSceneObjectScreenPos_14:
	ldh a, [hScrollX] ; $756d
	ld b, a ; $756f
	ld a, [$c2b0] ; $7570
	sub a, b ; $7573
	ld d, a ; $7574
	ldh a, [hScrollY] ; $7575
	ld b, a ; $7577
	ld a, [$c2b1] ; $7578
	sub a, b ; $757b
	ld e, a ; $757c
	ret ; $757d
	; $757e, 2 bytes (fill)
	ds 2, $00
Gfx_14_7580:
	INCBIN "data/bank_014/d_7580.bin" ; $7580, 256 bytes
Palette_14_7680:
	; $7680, 8 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0000, $03ff, $7fe0, $001f ; pal 0: #000000 #ffff00 #00ffff #ff0000
LoadTwinkleObjGfx_14:
	ldh a, [hWramBank] ; $7688
	push af ; $768a
	wram_bank $01 ; $768b
	ld hl, Gfx_14_7580 ; $7691
	ld de, $a000 ; $7694
	ld c, $10 ; $7697
	call QueueVRAMCopy ; $7699
	ld hl, Palette_14_7680 ; $769c
	ld de, $0801 ; $769f
	call LoadPaletteShadow ; $76a2
	pop af ; $76a5
	wram_bank ; $76a6
	ret ; $76aa
QueueTwinkleSprite_14:
	ldh a, [hScrollX] ; $76ab
	ld b, a ; $76ad
	ld a, $54 ; $76ae
	sub a, b ; $76b0
	ld d, a ; $76b1
	ldh a, [hScrollY] ; $76b2
	ld b, a ; $76b4
	ld a, $58 ; $76b5
	sub a, b ; $76b7
	ld e, a ; $76b8
	ld a, [wWaterSpriteMinigameSwingCount] ; $76b9
	ld c, a ; $76bc
	ld hl, SpriteTemplate_14_7530 ; $76bd
	ld b, $08 ; $76c0
	call QueueSpriteTemplate ; $76c2
	ret ; $76c5
Label_14_76c6:
	call DisableLCDSafely ; $76c6
	call LoadIslandSkyEffectObjGfx_14 ; $76c9
	call LoadTwinkleObjGfx_14 ; $76cc
	call EnableLCD ; $76cf
	ld a, $00 ; $76d2
	ld [wWaterSpriteMinigameFlag], a ; $76d4
	ld [$c2bb], a ; $76d7
	ld a, $01 ; $76da
	ld hl, AnimateIslandSkyEffectSprites_14 ; $76dc
	call RegisterFrameTask ; $76df
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $76e2
	test_flag FLAG_DOUBLES ; $76ed
	jp z, Label_14_7703 ; $76f0
	script_null_script ACTOR_PARTNER ; $76f3
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $76f8
Label_14_7703:
	xor a, a ; $7703
	ld [wStoryModeShowLocationName], a ; $7704
	script_fade_in $06 ; $7707
	call WaitFadeEnd ; $770c
	script_wait_frames $3c ; $770f
	call PlayTwinkleAnimation_14 ; $7716
	script_wait_frames $1e ; $7719
	call LoadDistantPlaneObjGfx_14 ; $7720
	ld a, $08 ; $7723
	ld [wWaterSpriteMinigameSwingCount], a ; $7725
	ld a, $54 ; $7728
	ld [$c2b0], a ; $772a
	ld a, $58 ; $772d
	ld [$c2b1], a ; $772f
	ld a, $01 ; $7732
	ld hl, QueueDistantPlaneSprite_14 ; $7734
	call RegisterFrameTask ; $7737
	ld h, $4b ; $773a
Label_14_773c:
	script_wait_frames $02 ; $773c
	call PlayPlaneMoveSfx_14 ; $7743
	ld a, [$c2b1] ; $7746
	inc a ; $7749
	ld [$c2b1], a ; $774a
	ld a, [$c2b0] ; $774d
	inc a ; $7750
	ld [$c2b0], a ; $7751
	ld a, h ; $7754
	cp a, $2d ; $7755
	jr nz, Label_14_775e ; $7757
	ld a, $0c ; $7759
	ld [wWaterSpriteMinigameSwingCount], a ; $775b
Label_14_775e:
	dec h ; $775e
	jr nz, Label_14_773c ; $775f
	ld hl, QueueDistantPlaneSprite_14 ; $7761
	call UnregisterFrameTask ; $7764
	script_player_speed $0012 ; $7767
	script_move_player $0b00, $1800 ; $776d
	ld h, $3c ; $7777
Label_14_7779:
	script_wait_frames $02 ; $7779
	call PlayPlaneMoveSfx_14 ; $7780
	dec h ; $7783
	jr nz, Label_14_7779 ; $7784
	call LoadPlaneObjGfx2_14 ; $7786
	ld a, $a4 ; $7789
	ld [$c2b0], a ; $778b
	ld a, $c6 ; $778e
	ld [$c2b1], a ; $7790
	ld a, $3c ; $7793
	ld [$c2b2], a ; $7795
	ld a, $01 ; $7798
	ld hl, QueuePlaneSpriteByFrameCounter_14 ; $779a
	call RegisterFrameTask ; $779d
	ld h, $20 ; $77a0
Label_14_77a2:
	script_wait_frames $02 ; $77a2
	call PlayPlaneMoveSfx_14 ; $77a9
	ld a, [$c2b0] ; $77ac
	dec a ; $77af
	ld [$c2b0], a ; $77b0
	and a, $03 ; $77b3
	cp a, $03 ; $77b5
	jr nz, Label_14_77c0 ; $77b7
	ld a, [$c2b1] ; $77b9
	dec a ; $77bc
	ld [$c2b1], a ; $77bd
Label_14_77c0:
	call AdvancePlaneFrameCounter2_14 ; $77c0
	dec h ; $77c3
	jr nz, Label_14_77a2 ; $77c4
	ld h, $18 ; $77c6
Label_14_77c8:
	script_wait_frames $02 ; $77c8
	call PlayPlaneMoveSfx_14 ; $77cf
	ld a, [$c2b0] ; $77d2
	dec a ; $77d5
	ld [$c2b0], a ; $77d6
	and a, $01 ; $77d9
	ld b, a ; $77db
	ld a, [$c2b1] ; $77dc
	sub a, b ; $77df
	ld [$c2b1], a ; $77e0
	call AdvancePlaneFrameCounter2_14 ; $77e3
	dec h ; $77e6
	jr nz, Label_14_77c8 ; $77e7
	script_move_player $0b00, $1200 ; $77e9
	ld h, $18 ; $77f3
Label_14_77f5:
	script_wait_frames $03 ; $77f5
	call PlayPlaneMoveSfx_14 ; $77fc
	ld a, [$c2b1] ; $77ff
	dec a ; $7802
	ld [$c2b1], a ; $7803
	ld a, [$c2b0] ; $7806
	dec a ; $7809
	ld [$c2b0], a ; $780a
	call AdvancePlaneFrameCounter2_14 ; $780d
	dec h ; $7810
	jr nz, Label_14_77f5 ; $7811
	ld h, $08 ; $7813
Label_14_7815:
	script_wait_frames $04 ; $7815
	call PlayPlaneMoveSfx_14 ; $781c
	ld a, [$c2b1] ; $781f
	dec a ; $7822
	ld [$c2b1], a ; $7823
	and a, $01 ; $7826
	ld b, a ; $7828
	ld a, [$c2b0] ; $7829
	sub a, b ; $782c
	ld [$c2b0], a ; $782d
	call AdvancePlaneFrameCounter2_14 ; $7830
	dec h ; $7833
	jr nz, Label_14_7815 ; $7834
	ld h, $0c ; $7836
Label_14_7838:
	script_wait_frames $06 ; $7838
	call PlayPlaneMoveSfx_14 ; $783f
	ld a, [$c2b1] ; $7842
	dec a ; $7845
	ld [$c2b1], a ; $7846
	call AdvancePlaneFrameCounter2_14 ; $7849
	dec h ; $784c
	jr nz, Label_14_7838 ; $784d
	sound $7d ; $784f
	script_wait_frames $46 ; $7851
	ld c, $04 ; $7858
	call BeginFadeOut ; $785a
	call WaitFadeEnd ; $785d
	ld a, $14 ; $7860
	ld [wStoryModeCurrentLocation], a ; $7862
	ld a, $02 ; $7865
	ld [wStoryModeEntryPoint], a ; $7867
	ld a, $ff ; $786a
	ld [$c294], a ; $786c
	ld [wStoryModeExitLocationRequest], a ; $786f
	ret ; $7872
AdvancePlaneFrameCounter2_14:
	ld a, [$c2b2] ; $7873
	inc a ; $7876
	ld [$c2b2], a ; $7877
	ret ; $787a
PlayTwinkleAnimation_14:
	xor a, a ; $787b
	ld [wWaterSpriteMinigameSwingCount], a ; $787c
	call AdvanceFrame ; $787f
	ld a, $01 ; $7882
	ld hl, QueueTwinkleSprite_14 ; $7884
	call RegisterFrameTask ; $7887
	sound $84 ; $788a
	ld h, $04 ; $788c
Label_14_788e:
	script_wait_frames $04 ; $788e
	ld a, [wWaterSpriteMinigameSwingCount] ; $7895
	add a, $04 ; $7898
	ld [wWaterSpriteMinigameSwingCount], a ; $789a
	dec h ; $789d
	jr nz, Label_14_788e ; $789e
	ld hl, QueueTwinkleSprite_14 ; $78a0
	call UnregisterFrameTask ; $78a3
	ret ; $78a6
PlayPlaneMoveSfx_14:
	ld a, h ; $78a7
	srl a ; $78a8
	and a, $01 ; $78aa
	jr z, .done ; $78ac
	sound $7b ; $78ae
.done:
	ret ; $78b0
ActorScript_14_78b1:
	; $78b1, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_14_78bb:
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
	xor a, a ; $78da
	ld [$c2da], a ; $78db
	ret ; $78de
MapScriptPlaySoundA2_14:
	sound $a2 ; $78df
	ret ; $78e1
MapScriptHideLocationName_14:
	xor a, a ; $78e2
	ld [wStoryModeShowLocationName], a ; $78e3
	ret ; $78e6
ActorScript_14_78e7:
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
	as_jump ActorScript_14_78e7
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
	test_flag FLAG_DOUBLES ; $7a9d
	jr nz, Label_14_7ac4 ; $7aa0
	ld a, $00 ; $7aa2
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7aa4
	jr z, Label_14_7ac0 ; $7aa7
	ld a, $02 ; $7aa9
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7aab
	jr z, Label_14_7ac0 ; $7aae
	ld a, $04 ; $7ab0
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7ab2
	jr z, Label_14_7ac0 ; $7ab5
	ld a, $06 ; $7ab7
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7ab9
	jr z, Label_14_7ac0 ; $7abc
	ld a, $08 ; $7abe
Label_14_7ac0:
	ld [$c2b0], a ; $7ac0
	ret ; $7ac3
Label_14_7ac4:
	ld a, $01 ; $7ac4
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7ac6
	jr z, Label_14_7ac0 ; $7ac9
	ld a, $03 ; $7acb
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7acd
	jr z, Label_14_7ac0 ; $7ad0
	ld a, $05 ; $7ad2
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7ad4
	jr z, Label_14_7ac0 ; $7ad7
	ld a, $07 ; $7ad9
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7adb
	jr z, Label_14_7ac0 ; $7ade
	ld a, $09 ; $7ae0
	jr Label_14_7ac0 ; $7ae2
	ld a, $00 ; $7ae4
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7ae6
	jr z, Label_14_7b03 ; $7ae9
	inc a ; $7aeb
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7aec
	jr z, Label_14_7b03 ; $7aef
	inc a ; $7af1
	test_flag FLAG_DOUBLES ; $7af2
	jr nz, Label_14_7b07 ; $7af5
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7af7
	jr z, Label_14_7b03 ; $7afa
	inc a ; $7afc
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7afd
	jr z, Label_14_7b03 ; $7b00
	inc a ; $7b02
Label_14_7b03:
	ld [$c2b0], a ; $7b03
	ret ; $7b06
Label_14_7b07:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7b07
	jr z, Label_14_7b03 ; $7b0a
	inc a ; $7b0c
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7b0d
	jr z, Label_14_7b03 ; $7b10
	inc a ; $7b12
	jr Label_14_7b03 ; $7b13
	; $7b15, 1259 bytes fill to bank end (linker-padded)

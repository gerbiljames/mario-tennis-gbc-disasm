SECTION "ROM Bank $0e", ROMX[$4000], BANK[$0e]

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
	map_actor $0000, $7c6e, $2500, $0d00, $40, $42, $01, $00
	map_actor $0000, $7c6e, $2900, $0f00, $40, $45, $01, $05
	map_actor $0000, $7c6e, $2500, $1500, $40, $43, $01, $07
	map_actor $0000, $7c6e, $2900, $1300, $40, $44, $01, $05
	map_actor $0000, $7c6e, $2500, $0500, $40, $47, $01, $07
	map_actor $0000, $7c6e, $2700, $0700, $40, $46, $01, $00
	map_actor $0000, $7c6e, $2900, $0500, $40, $47, $01, $00
	map_actor $0000, $4712, $2100, $0c00, $40, $3b, $01, $00
	map_actor $0000, $48c9, $2c00, $0b00, $80, $3c, $01, $00
	map_actor $0000, $4a80, $2d60, $1700, $00, $3b, $01, $06
	map_actor $0000, $5225, $1900, $1100, $c0, $39, $01, $06
	map_actor $0000, $7c6e, $0d00, $1300, $00, $39, $01, $07
	map_actor_end
TrainingGymEntryPoints_0e:
	; $40c6, 57 bytes (map_entries)
	map_entry $01, $c0, $1600, $1800, Func_0e_40ff
	map_entry $02, $40, $0b00, $0c00, Func_0e_4145
	map_entry $03, $40, $1500, $0c00, Func_0e_41e2
	map_entry $0b, $40, $0d00, $0f00, $0000
	map_entry $0c, $80, $1100, $1300, $0000
	map_entry $0d, $40, $0d00, $0f00, $0000
	map_entry $0e, $80, $1100, $1300, $0000
	db $ff
Func_0e_40ff:
	ld a, [wStoryModeEntryPoint] ; $40ff
	cp a, $ff ; $4102
	jp z, Label_0e_4144 ; $4104
	test_flag $05, 7 ; $4107
	jr z, Label_0e_4132 ; $410a
	script_set_speed $02, $00ff ; $410c
	script_move_angle $02, $40, $0200 ; $4114
	script_wait_move $02 ; $411e
	script_face $02, $c0 ; $4123
	script_set_speed $02, $0010 ; $412a
Label_0e_4132:
	script_set_speed $00, $0010 ; $4132
	script_move_angle $00, $c0, $0200 ; $413a
Label_0e_4144:
	ret ; $4144
Func_0e_4145:
	ld a, [wStoryModeEntryPoint] ; $4145
	cp a, $ff ; $4148
	jp z, Label_0e_41e1 ; $414a
	script_set_speed $00, $0010 ; $414d
	script_set_speed $02, $0010 ; $4155
	farcall FarPtr_WaitPlayerMoveDone ; $415d
	ld b, $0a ; $4160
	ld c, $0a ; $4162
	ld d, $3d ; $4164
	ld e, $0c ; $4166
	ld h, $02 ; $4168
	ld l, $02 ; $416a
	farcall FarPtr_CopySceneTilemapRect ; $416c
	ld b, $3d ; $416f
	ld c, $0a ; $4171
	ld d, $0a ; $4173
	ld e, $0a ; $4175
	ld h, $02 ; $4177
	ld l, $02 ; $4179
	farcall FarPtr_CopySceneTilemapRect ; $417b
	script_wait_frames $02 ; $417e
	ld c, $08 ; $4185
	call BeginFadeIn ; $4187
	call WaitFadeEnd ; $418a
	script_move_target $00, $0b00, $0e00 ; $418d
	script_wait_move $00 ; $4198
	sound $71 ; $419d
	script_wait_frames $02 ; $419f
	ld b, $3a ; $41a6
	ld c, $0a ; $41a8
	ld d, $0a ; $41aa
	ld e, $0a ; $41ac
	ld h, $02 ; $41ae
	ld l, $02 ; $41b0
	farcall FarPtr_CopySceneTilemapRect ; $41b2
	script_wait_frames $02 ; $41b5
	ld b, $37 ; $41bc
	ld c, $0a ; $41be
	ld d, $0a ; $41c0
	ld e, $0a ; $41c2
	ld h, $02 ; $41c4
	ld l, $02 ; $41c6
	farcall FarPtr_CopySceneTilemapRect ; $41c8
	script_wait_frames $02 ; $41cb
	ld b, $3d ; $41d2
	ld c, $0c ; $41d4
	ld d, $0a ; $41d6
	ld e, $0a ; $41d8
	ld h, $02 ; $41da
	ld l, $02 ; $41dc
	farcall FarPtr_CopySceneTilemapRect ; $41de
Label_0e_41e1:
	ret ; $41e1
Func_0e_41e2:
	ld a, [wStoryModeEntryPoint] ; $41e2
	cp a, $ff ; $41e5
	jr z, Label_0e_41e1 ; $41e7
	script_set_speed $00, $0010 ; $41e9
	script_set_speed $02, $0010 ; $41f1
	farcall FarPtr_WaitPlayerMoveDone ; $41f9
	ld b, $0a ; $41fc
	ld c, $0a ; $41fe
	ld d, $3d ; $4200
	ld e, $0c ; $4202
	ld h, $02 ; $4204
	ld l, $02 ; $4206
	farcall FarPtr_CopySceneTilemapRect ; $4208
	ld b, $3d ; $420b
	ld c, $0a ; $420d
	ld d, $14 ; $420f
	ld e, $0a ; $4211
	ld h, $02 ; $4213
	ld l, $02 ; $4215
	farcall FarPtr_CopySceneTilemapRect ; $4217
	ld c, $08 ; $421a
	call BeginFadeIn ; $421c
	call WaitFadeEnd ; $421f
	script_move_target $00, $1500, $0e00 ; $4222
	script_wait_move $00 ; $422d
	sound $71 ; $4232
	script_wait_frames $02 ; $4234
	ld b, $3a ; $423b
	ld c, $0a ; $423d
	ld d, $14 ; $423f
	ld e, $0a ; $4241
	ld h, $02 ; $4243
	ld l, $02 ; $4245
	farcall FarPtr_CopySceneTilemapRect ; $4247
	script_wait_frames $02 ; $424a
	ld b, $37 ; $4251
	ld c, $0a ; $4253
	ld d, $14 ; $4255
	ld e, $0a ; $4257
	ld h, $02 ; $4259
	ld l, $02 ; $425b
	farcall FarPtr_CopySceneTilemapRect ; $425d
	script_wait_frames $02 ; $4260
	ld b, $3d ; $4267
	ld c, $0c ; $4269
	ld d, $14 ; $426b
	ld e, $0a ; $426d
	ld h, $02 ; $426f
	ld l, $02 ; $4271
	farcall FarPtr_CopySceneTilemapRect ; $4273
	ret ; $4276
TrainingGymExitTriggers_0e:
	; $4277, 25 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_0e, $07, $01
	map_script $03, $ff, $0000, Func_0e_431b, $12, $01
	map_script $02, $ff, $0000, Func_0e_4290, $13, $01
	db $ff
Func_0e_4290:
	script_face $00, $c0 ; $4290
	script_facing_lock $00, $01 ; $4297
	script_set_speed $00, $0018 ; $429e
	script_move_target $00, $0b00, $0d00 ; $42a6
	script_wait_move $00 ; $42b1
	farcall FarPtr_WaitPlayerMoveDone ; $42b6
	sound $71 ; $42b9
	ld b, $37 ; $42bb
	ld c, $0a ; $42bd
	ld d, $0a ; $42bf
	ld e, $0a ; $42c1
	ld h, $02 ; $42c3
	ld l, $02 ; $42c5
	farcall FarPtr_CopySceneTilemapRect ; $42c7
	script_wait_frames $02 ; $42ca
	ld b, $3a ; $42d1
	ld c, $0a ; $42d3
	ld d, $0a ; $42d5
	ld e, $0a ; $42d7
	ld h, $02 ; $42d9
	ld l, $02 ; $42db
	farcall FarPtr_CopySceneTilemapRect ; $42dd
	script_wait_frames $02 ; $42e0
	ld b, $3d ; $42e7
	ld c, $0a ; $42e9
	ld d, $0a ; $42eb
	ld e, $0a ; $42ed
	ld h, $02 ; $42ef
	ld l, $02 ; $42f1
	farcall FarPtr_CopySceneTilemapRect ; $42f3
	script_wait_frames $02 ; $42f6
	script_move_angle $00, $c0, $0100 ; $42fd
	ld c, $08 ; $4307
	call BeginFadeOut ; $4309
	script_facing_lock $00, $00 ; $430c
	script_wait_frames $0a ; $4313
	ret ; $431a
Func_0e_431b:
	script_face $00, $c0 ; $431b
	script_facing_lock $00, $01 ; $4322
	script_set_speed $00, $0018 ; $4329
	script_move_target $00, $1500, $0d00 ; $4331
	script_wait_move $00 ; $433c
	farcall FarPtr_WaitPlayerMoveDone ; $4341
	sound $71 ; $4344
	ld b, $37 ; $4346
	ld c, $0a ; $4348
	ld d, $14 ; $434a
	ld e, $0a ; $434c
	ld h, $02 ; $434e
	ld l, $02 ; $4350
	farcall FarPtr_CopySceneTilemapRect ; $4352
	script_wait_frames $02 ; $4355
	ld b, $3a ; $435c
	ld c, $0a ; $435e
	ld d, $14 ; $4360
	ld e, $0a ; $4362
	ld h, $02 ; $4364
	ld l, $02 ; $4366
	farcall FarPtr_CopySceneTilemapRect ; $4368
	script_wait_frames $02 ; $436b
	ld b, $3d ; $4372
	ld c, $0a ; $4374
	ld d, $14 ; $4376
	ld e, $0a ; $4378
	ld h, $02 ; $437a
	ld l, $02 ; $437c
	farcall FarPtr_CopySceneTilemapRect ; $437e
	script_wait_frames $02 ; $4381
	script_move_angle $00, $c0, $0100 ; $4388
	ld c, $08 ; $4392
	call BeginFadeOut ; $4394
	script_facing_lock $00, $00 ; $4397
	script_wait_frames $0a ; $439e
	ret ; $43a5
Func_0e_43a6:
	ld a, [$c2b0] ; $43a6
	add a, a ; $43a9
	add a, $bd ; $43aa
	ld l, a ; $43ac
	adc a, $43 ; $43ad
	sub a, l ; $43af
	ld h, a ; $43b0
	ld a, [hl+] ; $43b1
	ld h, [hl] ; $43b2
	ld l, a ; $43b3
	farcall FarPtr_InitDialogueTextCursor ; $43b4
	script_speak $03 ; $43b7
	ret ; $43bc
	; $43bd, 20 bytes (records:2)
	dw $14a9 ; record 0
	dw $14a9 ; record 1
	dw $14b3 ; record 2
	dw $14b3 ; record 3
	dw $14bd ; record 4
	dw $14be ; record 5
	dw $14cb ; record 6
	dw $14cc ; record 7
	dw $14db ; record 8
	dw $14db ; record 9
Func_0e_43d1:
	ld a, [$c2b0] ; $43d1
	sra a ; $43d4
	add a, a ; $43d6
	add a, $ea ; $43d7
	ld l, a ; $43d9
	adc a, $43 ; $43da
	sub a, l ; $43dc
	ld h, a ; $43dd
	ld a, [hl+] ; $43de
	ld h, [hl] ; $43df
	ld l, a ; $43e0
	farcall FarPtr_InitDialogueTextCursor ; $43e1
	script_speak $04 ; $43e4
	ret ; $43e9
	; $43ea, 10 bytes (records:2)
	dw $14aa ; record 0
	dw $14b4 ; record 1
	dw $14bf ; record 2
	dw $14cd ; record 3
	dw $14dc ; record 4
Func_0e_43f4:
	ld a, [$c2b0] ; $43f4
	add a, a ; $43f7
	add a, $0b ; $43f8
	ld l, a ; $43fa
	adc a, $44 ; $43fb
	sub a, l ; $43fd
	ld h, a ; $43fe
	ld a, [hl+] ; $43ff
	ld h, [hl] ; $4400
	ld l, a ; $4401
	farcall FarPtr_InitDialogueTextCursor ; $4402
	script_speak $05 ; $4405
	ret ; $440a
	; $440b, 20 bytes (records:2)
	dw $14ab ; record 0
	dw $14ab ; record 1
	dw $14b5 ; record 2
	dw $14b5 ; record 3
	dw $14c0 ; record 4
	dw $14c1 ; record 5
	dw $14ce ; record 6
	dw $14cf ; record 7
	dw $14dd ; record 8
	dw $14dd ; record 9
Func_0e_441f:
	ld a, [$c2b0] ; $441f
	add a, a ; $4422
	add a, $36 ; $4423
	ld l, a ; $4425
	adc a, $44 ; $4426
	sub a, l ; $4428
	ld h, a ; $4429
	ld a, [hl+] ; $442a
	ld h, [hl] ; $442b
	ld l, a ; $442c
	farcall FarPtr_InitDialogueTextCursor ; $442d
	script_speak $06 ; $4430
	ret ; $4435
	; $4436, 20 bytes (records:2)
	dw $14ac ; record 0
	dw $14ac ; record 1
	dw $14b6 ; record 2
	dw $14b6 ; record 3
	dw $14c2 ; record 4
	dw $14c2 ; record 5
	dw $14d0 ; record 6
	dw $14d1 ; record 7
	dw $14de ; record 8
	dw $14de ; record 9
Func_0e_444a:
	ld a, [$c2b0] ; $444a
	sra a ; $444d
	cp a, $03 ; $444f
	jr z, Label_0e_4471 ; $4451
	add a, a ; $4453
	add a, $67 ; $4454
	ld l, a ; $4456
	adc a, $44 ; $4457
	sub a, l ; $4459
	ld h, a ; $445a
	ld a, [hl+] ; $445b
	ld h, [hl] ; $445c
	ld l, a ; $445d
	farcall FarPtr_InitDialogueTextCursor ; $445e
	script_speak $07 ; $4461
	ret ; $4466
	; $4467, 10 bytes (records:2)
	dw $14ad ; record 0
	dw $14b7 ; record 1
	dw $14c3 ; record 2
	dw $14d2 ; record 3
	dw $14df ; record 4
Label_0e_4471:
	script_set_text $14d2 ; $4471
	ld a, $07 ; $4477
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4479
	farcall FarPtr_RunDialogueYesNoPrompt ; $447c
	farcall FarPtr_ScriptCloseDialogueWindow ; $447f
	script_wait_frames $05 ; $4482
	and a, a ; $4489
	jr z, Label_0e_448f ; $448a
	farcall FarPtr_AdvanceDialogueTextCursor ; $448c
Label_0e_448f:
	script_speak $07 ; $448f
	ret ; $4494
Func_0e_4495:
	ld a, [$c2b0] ; $4495
	sra a ; $4498
	add a, a ; $449a
	add a, $ae ; $449b
	ld l, a ; $449d
	adc a, $44 ; $449e
	sub a, l ; $44a0
	ld h, a ; $44a1
	ld a, [hl+] ; $44a2
	ld h, [hl] ; $44a3
	ld l, a ; $44a4
	farcall FarPtr_InitDialogueTextCursor ; $44a5
	script_speak $08 ; $44a8
	ret ; $44ad
	; $44ae, 10 bytes (records:2)
	dw $14ae ; record 0
	dw $14b8 ; record 1
	dw $14c4 ; record 2
	dw $14d5 ; record 3
	dw $14e0 ; record 4
Func_0e_44b8:
	ld a, [$c2b0] ; $44b8
	sra a ; $44bb
	add a, a ; $44bd
	add a, $d1 ; $44be
	ld l, a ; $44c0
	adc a, $44 ; $44c1
	sub a, l ; $44c3
	ld h, a ; $44c4
	ld a, [hl+] ; $44c5
	ld h, [hl] ; $44c6
	ld l, a ; $44c7
	farcall FarPtr_InitDialogueTextCursor ; $44c8
	script_speak $09 ; $44cb
	ret ; $44d0
	; $44d1, 10 bytes (records:2)
	dw $14af ; record 0
	dw $14b9 ; record 1
	dw $14c5 ; record 2
	dw $14d6 ; record 3
	dw $14e1 ; record 4
Func_0e_44db:
	ld a, [$c2b0] ; $44db
	add a, a ; $44de
	add a, $f2 ; $44df
	ld l, a ; $44e1
	adc a, $44 ; $44e2
	sub a, l ; $44e4
	ld h, a ; $44e5
	ld a, [hl+] ; $44e6
	ld h, [hl] ; $44e7
	ld l, a ; $44e8
	farcall FarPtr_InitDialogueTextCursor ; $44e9
	script_speak $0a ; $44ec
	ret ; $44f1
	; $44f2, 20 bytes (records:2)
	dw $14b0 ; record 0
	dw $14b0 ; record 1
	dw $14ba ; record 2
	dw $14ba ; record 3
	dw $14c6 ; record 4
	dw $14c7 ; record 5
	dw $14d7 ; record 6
	dw $14d7 ; record 7
	dw $14e2 ; record 8
	dw $14e3 ; record 9
Func_0e_4506:
	ld a, [$c2b0] ; $4506
	add a, a ; $4509
	add a, $1d ; $450a
	ld l, a ; $450c
	adc a, $45 ; $450d
	sub a, l ; $450f
	ld h, a ; $4510
	ld a, [hl+] ; $4511
	ld h, [hl] ; $4512
	ld l, a ; $4513
	farcall FarPtr_InitDialogueTextCursor ; $4514
	script_speak $0b ; $4517
	ret ; $451c
	; $451d, 20 bytes (records:2)
	dw $14b1 ; record 0
	dw $14b1 ; record 1
	dw $14bb ; record 2
	dw $14bb ; record 3
	dw $14c8 ; record 4
	dw $14c8 ; record 5
	dw $14d8 ; record 6
	dw $14d9 ; record 7
	dw $14e4 ; record 8
	dw $14e5 ; record 9
Func_0e_4531:
	ld a, [$c2b0] ; $4531
	sra a ; $4534
	add a, a ; $4536
	add a, $4a ; $4537
	ld l, a ; $4539
	adc a, $45 ; $453a
	sub a, l ; $453c
	ld h, a ; $453d
	ld a, [hl+] ; $453e
	ld h, [hl] ; $453f
	ld l, a ; $4540
	farcall FarPtr_InitDialogueTextCursor ; $4541
	script_speak $0c ; $4544
	ret ; $4549
	; $454a, 10 bytes (records:2)
	dw $14b2 ; record 0
	dw $14bc ; record 1
	dw $14c9 ; record 2
	dw $14da ; record 3
	dw $14e6 ; record 4
TrainingGymNpcScripts_0e:
	; $4554, 89 bytes (map_scripts)
	map_script $03, $ff, $0000, Func_0e_43a6, $03, $00
	map_script $04, $ff, $0000, Func_0e_43d1, $03, $00
	map_script $05, $ff, $0000, Func_0e_43f4, $03, $00
	map_script $06, $ff, $0000, Func_0e_441f, $03, $00
	map_script $07, $ff, $0000, Func_0e_444a, $00, $00
	map_script $08, $ff, $0000, Func_0e_4495, $00, $00
	map_script $09, $ff, $0000, Func_0e_44b8, $00, $00
	map_script $0a, $ff, $0000, Func_0e_44db, $13, $00
	map_script $0b, $ff, $0000, Func_0e_4506, $10, $00
	map_script $0c, $ff, $0000, Func_0e_4531, $13, $00
	map_script $0d, $ff, $0000, $20e2, $13, $00
	db $ff
TrainingGymFacingScripts_0e:
	; $45ad, 17 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_0e_45be, $00, $00
	map_script $02, $ff, $0000, Func_0e_45da, $00, $00
	db $ff
Func_0e_45be:
	ld a, $0b ; $45be
	ld [$c2b1], a ; $45c0
	script_player_speed $0040 ; $45c3
	script_move_player $0d00, $1300 ; $45c9
	farcall FarPtr_WaitPlayerMoveDone ; $45d3
	call RunRepairCounterDialogue ; $45d6
	ret ; $45d9
Func_0e_45da:
	ld a, $0c ; $45da
	ld [$c2b1], a ; $45dc
	script_player_speed $0040 ; $45df
	script_move_player $0d00, $1300 ; $45e5
	farcall FarPtr_WaitPlayerMoveDone ; $45ef
	call RunRepairCounterDialogue ; $45f2
	ret ; $45f5
TrainingGymTileTriggers_0e:
	; $45f6, 17 bytes (map_scripts)
	map_script $02, $40, $0000, Func_0e_4607, $00, $00
	map_script $03, $40, $0000, Func_0e_4610, $00, $00
	db $ff
Func_0e_4607:
	ld a, $02 ; $4607
	ld [$c294], a ; $4609
	ld [wStoryModeExitLocationRequest], a ; $460c
	ret ; $460f
Func_0e_4610:
	ld a, $03 ; $4610
	ld [$c294], a ; $4612
	ld [wStoryModeExitLocationRequest], a ; $4615
	ret ; $4618
TrainingGymInitScript_0e:
	call ComputeTrainingGymProgressIndex ; $4619
	ld a, $07 ; $461c
	farcall FarPtr_GetActorStateAddr ; $461e
	ld a, $03 ; $4621
	ld e, l ; $4623
	ld d, h ; $4624
	ld hl, $0018 ; $4625
	add hl, de ; $4628
	ld [hl], a ; $4629
	ld a, $08 ; $462a
	farcall FarPtr_GetActorStateAddr ; $462c
	ld a, $03 ; $462f
	ld e, l ; $4631
	ld d, h ; $4632
	ld hl, $0018 ; $4633
	add hl, de ; $4636
	ld [hl], a ; $4637
	ld a, $09 ; $4638
	farcall FarPtr_GetActorStateAddr ; $463a
	ld a, $03 ; $463d
	ld e, l ; $463f
	ld d, h ; $4640
	ld hl, $0018 ; $4641
	add hl, de ; $4644
	ld [hl], a ; $4645
	script_set_anim $07, $05 ; $4646
	script_set_anim $08, $05 ; $464d
	script_set_anim $09, $05 ; $4654
	call SetupGymActorsForProgress ; $465b
	ld a, [wStoryModeEntryPoint] ; $465e
	cp a, $0b ; $4661
	jr nz, Label_0e_4669 ; $4663
	call RepairCounterReturnA ; $4665
	ret ; $4668
Label_0e_4669:
	cp a, $0c ; $4669
	jr nz, Label_0e_4671 ; $466b
	call RepairCounterReturnB ; $466d
	ret ; $4670
Label_0e_4671:
	cp a, $0d ; $4671
	jr nz, Label_0e_4679 ; $4673
	call RepairCounterChangedReturnA ; $4675
	ret ; $4678
Label_0e_4679:
	cp a, $0e ; $4679
	jr nz, Label_0e_4680 ; $467b
	call RepairCounterChangedReturnB ; $467d
Label_0e_4680:
	ret ; $4680
SetupGymActorsForProgress:
	ld a, [$c2b0] ; $4681
	sra a ; $4684
	cp a, $01 ; $4686
	jr z, Label_0e_4693 ; $4688
	cp a, $03 ; $468a
	jr z, Label_0e_46b9 ; $468c
	cp a, $04 ; $468e
	jr z, Label_0e_46e9 ; $4690
	ret ; $4692
Label_0e_4693:
	script_set_objdef $34, $04 ; $4693
	script_set_anim $03, $01 ; $469f
	script_set_position $04, $2700, $0f00 ; $46a6
	script_face $04, $00 ; $46b1
	ret ; $46b8
Label_0e_46b9:
	script_set_position $07, $2900, $0700 ; $46b9
	script_set_position $08, $2700, $0500 ; $46c4
	script_set_position $09, $2500, $0700 ; $46cf
	ld a, $07 ; $46da
	farcall FarPtr_GetActorStateAddr ; $46dc
	ld a, $01 ; $46df
	ld e, l ; $46e1
	ld d, h ; $46e2
	ld hl, $0018 ; $46e3
	add hl, de ; $46e6
	ld [hl], a ; $46e7
	ret ; $46e8
Label_0e_46e9:
	script_set_position $07, $2900, $0700 ; $46e9
	script_set_position $08, $2700, $0500 ; $46f4
	script_set_position $09, $2500, $0700 ; $46ff
	script_set_anim $07, $02 ; $470a
	ret ; $4711
	INCBIN "data/bank_00e/d_4712.bin" ; $4712, 1317 bytes
	ld a, $0c ; $4c37
	farcall FarPtr_GetActorStateAddr ; $4c39
	ld c, l ; $4c3c
	ld b, h ; $4c3d
	ld hl, $000e ; $4c3e
	add hl, bc ; $4c41
	ld a, [hl+] ; $4c42
	ld d, [hl] ; $4c43
	ld e, a ; $4c44
	ld hl, wWaterSpriteMinigameTimer ; $4c45
	ld a, e ; $4c48
	ld [hl+], a ; $4c49
	ld [hl], d ; $4c4a
	ld hl, $000c ; $4c4b
	add hl, bc ; $4c4e
	ld a, [hl+] ; $4c4f
	ld d, [hl] ; $4c50
	ld e, a ; $4c51
	ld hl, $c2b2 ; $4c52
	ld a, e ; $4c55
	ld [hl+], a ; $4c56
	ld [hl], d ; $4c57
	ld a, $0a ; $4c58
	farcall FarPtr_GetActorStateAddr ; $4c5a
	ld c, l ; $4c5d
	ld b, h ; $4c5e
	ld hl, $000a ; $4c5f
	add hl, bc ; $4c62
	ld a, [hl+] ; $4c63
	ld d, [hl] ; $4c64
	ld e, a ; $4c65
	ld hl, $c2b8 ; $4c66
	ld a, e ; $4c69
	ld [hl+], a ; $4c6a
	ld [hl], d ; $4c6b
	ld hl, $0008 ; $4c6c
	add hl, bc ; $4c6f
	ld a, [hl+] ; $4c70
	ld d, [hl] ; $4c71
	ld e, a ; $4c72
	ld hl, wWaterSpriteMinigameSwingCount ; $4c73
	ld a, e ; $4c76
	ld [hl+], a ; $4c77
	ld [hl], d ; $4c78
	jp Label_0e_4d3c ; $4c79
	ld a, $0a ; $4c7c
	farcall FarPtr_GetActorStateAddr ; $4c7e
	ld c, l ; $4c81
	ld b, h ; $4c82
	ld hl, $0005 ; $4c83
	add hl, bc ; $4c86
	res 0, [hl] ; $4c87
	ld b, $00 ; $4c89
	ld a, $00 ; $4c8b
	ret ; $4c8d
	ld a, $0a ; $4c8e
	farcall FarPtr_GetActorStateAddr ; $4c90
	ld c, l ; $4c93
	ld b, h ; $4c94
	ld hl, $000e ; $4c95
	add hl, bc ; $4c98
	ld a, [hl+] ; $4c99
	ld d, [hl] ; $4c9a
	ld e, a ; $4c9b
	ld hl, wWaterSpriteMinigameTimer ; $4c9c
	ld a, e ; $4c9f
	ld [hl+], a ; $4ca0
	ld [hl], d ; $4ca1
	ld hl, $000c ; $4ca2
	add hl, bc ; $4ca5
	ld a, [hl+] ; $4ca6
	ld d, [hl] ; $4ca7
	ld e, a ; $4ca8
	ld hl, $c2b2 ; $4ca9
	ld a, e ; $4cac
	ld [hl+], a ; $4cad
	ld [hl], d ; $4cae
	ld a, $0b ; $4caf
	farcall FarPtr_GetActorStateAddr ; $4cb1
	ld c, l ; $4cb4
	ld b, h ; $4cb5
	ld hl, $000a ; $4cb6
	add hl, bc ; $4cb9
	ld a, [hl+] ; $4cba
	ld d, [hl] ; $4cbb
	ld e, a ; $4cbc
	ld hl, $c2b8 ; $4cbd
	ld a, e ; $4cc0
	ld [hl+], a ; $4cc1
	ld [hl], d ; $4cc2
	ld hl, $0008 ; $4cc3
	add hl, bc ; $4cc6
	ld a, [hl+] ; $4cc7
	ld d, [hl] ; $4cc8
	ld e, a ; $4cc9
	ld hl, wWaterSpriteMinigameSwingCount ; $4cca
	ld a, e ; $4ccd
	ld [hl+], a ; $4cce
	ld [hl], d ; $4ccf
	jp Label_0e_4d3c ; $4cd0
	ld a, $0b ; $4cd3
	farcall FarPtr_GetActorStateAddr ; $4cd5
	ld c, l ; $4cd8
	ld b, h ; $4cd9
	ld hl, $0005 ; $4cda
	add hl, bc ; $4cdd
	res 0, [hl] ; $4cde
	ld b, $00 ; $4ce0
	ld a, $00 ; $4ce2
	ret ; $4ce4
	ld a, $0b ; $4ce5
	farcall FarPtr_GetActorStateAddr ; $4ce7
	ld c, l ; $4cea
	ld b, h ; $4ceb
	ld hl, $000e ; $4cec
	add hl, bc ; $4cef
	ld a, [hl+] ; $4cf0
	ld d, [hl] ; $4cf1
	ld e, a ; $4cf2
	ld hl, wWaterSpriteMinigameTimer ; $4cf3
	ld a, e ; $4cf6
	ld [hl+], a ; $4cf7
	ld [hl], d ; $4cf8
	ld hl, $000c ; $4cf9
	add hl, bc ; $4cfc
	ld a, [hl+] ; $4cfd
	ld d, [hl] ; $4cfe
	ld e, a ; $4cff
	ld hl, $c2b2 ; $4d00
	ld a, e ; $4d03
	ld [hl+], a ; $4d04
	ld [hl], d ; $4d05
	ld a, $0c ; $4d06
	farcall FarPtr_GetActorStateAddr ; $4d08
	ld c, l ; $4d0b
	ld b, h ; $4d0c
	ld hl, $000a ; $4d0d
	add hl, bc ; $4d10
	ld a, [hl+] ; $4d11
	ld d, [hl] ; $4d12
	ld e, a ; $4d13
	ld hl, $c2b8 ; $4d14
	ld a, e ; $4d17
	ld [hl+], a ; $4d18
	ld [hl], d ; $4d19
	ld hl, $0008 ; $4d1a
	add hl, bc ; $4d1d
	ld a, [hl+] ; $4d1e
	ld d, [hl] ; $4d1f
	ld e, a ; $4d20
	ld hl, wWaterSpriteMinigameSwingCount ; $4d21
	ld a, e ; $4d24
	ld [hl+], a ; $4d25
	ld [hl], d ; $4d26
	jp Label_0e_4d3c ; $4d27
	ld a, $0c ; $4d2a
	farcall FarPtr_GetActorStateAddr ; $4d2c
	ld c, l ; $4d2f
	ld b, h ; $4d30
	ld hl, $0005 ; $4d31
	add hl, bc ; $4d34
	res 0, [hl] ; $4d35
	ld b, $00 ; $4d37
	ld a, $00 ; $4d39
	ret ; $4d3b
Label_0e_4d3c:
	ld hl, wWaterSpriteMinigameTimer ; $4d3c
	ld a, [hl+] ; $4d3f
	ld d, [hl] ; $4d40
	ld e, a ; $4d41
	ld hl, $c2b8 ; $4d42
	ld a, [hl+] ; $4d45
	ld h, [hl] ; $4d46
	ld l, a ; $4d47
	ld a, l ; $4d48
	sub a, e ; $4d49
	ld l, a ; $4d4a
	ld a, h ; $4d4b
	sbc a, d ; $4d4c
	ld h, a ; $4d4d
	bit 7, h ; $4d4e
	jr z, Label_0e_4d58 ; $4d50
	xor a, a ; $4d52
	sub a, l ; $4d53
	ld l, a ; $4d54
	sbc a, a ; $4d55
	sub a, h ; $4d56
	ld h, a ; $4d57
Label_0e_4d58:
	ld a, h ; $4d58
	cp a, $05 ; $4d59
	jr nc, Label_0e_4d83 ; $4d5b
	ld hl, $c2b2 ; $4d5d
	ld a, [hl+] ; $4d60
	ld d, [hl] ; $4d61
	ld e, a ; $4d62
	ld hl, wWaterSpriteMinigameSwingCount ; $4d63
	ld a, [hl+] ; $4d66
	ld h, [hl] ; $4d67
	ld l, a ; $4d68
	ld a, l ; $4d69
	sub a, e ; $4d6a
	ld l, a ; $4d6b
	ld a, h ; $4d6c
	sbc a, d ; $4d6d
	ld h, a ; $4d6e
	bit 7, h ; $4d6f
	jr z, Label_0e_4d79 ; $4d71
	xor a, a ; $4d73
	sub a, l ; $4d74
	ld l, a ; $4d75
	sbc a, a ; $4d76
	sub a, h ; $4d77
	ld h, a ; $4d78
Label_0e_4d79:
	ld a, h ; $4d79
	cp a, $05 ; $4d7a
	jr nc, Label_0e_4d83 ; $4d7c
	ld b, $01 ; $4d7e
	ld a, $01 ; $4d80
	ret ; $4d82
Label_0e_4d83:
	ld b, $00 ; $4d83
	ld a, $00 ; $4d85
	ret ; $4d87
RunRepairCounterDialogue:
	script_face_toward $00, $0e ; $4d88
	test_flag $0a, 3 ; $4d90
	jp z, Label_0e_4da5 ; $4d93
	test_flag $0a, 7 ; $4d96
	jp z, Label_0e_4e0d ; $4d99
	test_flag $0b, 0 ; $4d9c
	jp z, Label_0e_4de5 ; $4d9f
	jp Label_0e_4de5 ; $4da2
Label_0e_4da5:
	test_flag $05, 7 ; $4da5
	jr nz, Label_0e_4dcd ; $4da8
	test_flag $0f, 6 ; $4daa
	jr z, Label_0e_4db7 ; $4dad
	script_set_text $20e4 ; $4daf
	jr Label_0e_4dc0 ; $4db5
Label_0e_4db7:
	script_set_text $20e3 ; $4db7
	set_flag $0f, 6 ; $4dbd
Label_0e_4dc0:
	script_speak $0e ; $4dc0
	script_face $0e, $00 ; $4dc5
	ret ; $4dcc
Label_0e_4dcd:
	test_flag $0f, 6 ; $4dcd
	jr z, Label_0e_4dda ; $4dd0
	script_set_text $20e6 ; $4dd2
	jr Label_0e_4dc0 ; $4dd8
Label_0e_4dda:
	script_set_text $20e5 ; $4dda
	set_flag $0f, 6 ; $4de0
	jr Label_0e_4dc0 ; $4de3
Label_0e_4de5:
	set_flag $0c, 1 ; $4de5
	set_flag $0c, 2 ; $4de8
	set_flag $0d, 0 ; $4deb
	script_set_text $20e9 ; $4dee
	jr Label_0e_4e26 ; $4df4
	set_flag $0c, 1 ; $4df6
	set_flag $0c, 2 ; $4df9
	set_flag $0d, 0 ; $4dfc
	set_flag $0c, 3 ; $4dff
	set_flag $0c, 7 ; $4e02
	script_set_text $20e9 ; $4e05
	jr Label_0e_4e26 ; $4e0b
Label_0e_4e0d:
	set_flag $0c, 1 ; $4e0d
	test_flag $0f, 7 ; $4e10
	jr z, Label_0e_4e1d ; $4e13
	script_set_text $20e9 ; $4e15
	jr Label_0e_4e26 ; $4e1b
Label_0e_4e1d:
	script_set_text $20e7 ; $4e1d
	set_flag $0f, 7 ; $4e23
Label_0e_4e26:
	script_face_toward $00, $0e ; $4e26
	ld a, $0e ; $4e2e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4e30
	farcall FarPtr_RunDialogueYesNoPrompt ; $4e33
	farcall FarPtr_ScriptCloseDialogueWindow ; $4e36
	script_wait_frames $05 ; $4e39
	and a, a ; $4e40
	jr z, Label_0e_4e4f ; $4e41
RepairCounterFarewell:
	script_set_text $20ea ; $4e43
	script_speak $0e ; $4e49
	ret ; $4e4e
Label_0e_4e4f:
	script_set_text $20eb ; $4e4f
	script_speak $0e ; $4e55
	script_wait_frames $05 ; $4e5a
RepairCounterServiceMenu:
	ld hl, $20ec ; $4e61
	ld de, $0101 ; $4e64
	farcall FarPtr_RunMenuFromText ; $4e67
Label_0e_4e6a:
	ld [$c2bc], a ; $4e6a
	cp a, $ff ; $4e6d
	jp z, RepairCounterFarewell ; $4e6f
	cp a, $02 ; $4e72
	jp z, RepairCounterFarewell ; $4e74
	cp a, $00 ; $4e77
	jp z, RepairCounterChangeRackets ; $4e79
	test_flag $0a, 7 ; $4e7c
	jp nz, RepairCounterChangeShoes ; $4e7f
	script_set_text $20e8 ; $4e82
	script_speak $0e ; $4e88
	script_set_text $20f2 ; $4e8d
	ld a, $0e ; $4e93
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4e95
	farcall FarPtr_RunDialogueYesNoPrompt ; $4e98
	farcall FarPtr_ScriptCloseDialogueWindow ; $4e9b
	script_wait_frames $05 ; $4e9e
	and a, a ; $4ea5
	jr z, RepairCounterServiceMenu ; $4ea6
	jr RepairCounterFarewell ; $4ea8
	script_face $0e, $00 ; $4eaa
	ret ; $4eb1
PrepareEquipmentSelectScreen:
	ld a, [wEquippedRacket] ; $4eb2
	ld [wWaterSpriteMinigameFlag], a ; $4eb5
	ld a, $11 ; $4eb8
	ld [wStoryModeCurrentLocation], a ; $4eba
	ld a, [$c2b1] ; $4ebd
	ld [wStoryModeEntryPoint], a ; $4ec0
	ld a, $ff ; $4ec3
	ld [$c294], a ; $4ec5
	ld [wStoryModeExitLocationRequest], a ; $4ec8
	ld c, $10 ; $4ecb
	call BeginFadeOut ; $4ecd
	call WaitFadeEnd ; $4ed0
	call ClearFrameTasks ; $4ed3
	call DisableLCDSafely ; $4ed6
	farcall FarPtr_01_0a ; $4ed9
	xor a, a ; $4edc
	ldh [hBGColumnBlitPending], a ; $4edd
	ldh [hBGRowBlitPending], a ; $4edf
	ldh [hScrollY], a ; $4ee1
	ldh [hScrollX], a ; $4ee3
	ld [$c321], a ; $4ee5
	ret ; $4ee8
RepairCounterChangeRackets:
	script_set_text $20ed ; $4ee9
	script_speak $0e ; $4eef
	call PrepareEquipmentSelectScreen ; $4ef4
	farcall FarPtr_RunRacketSelectScreen ; $4ef7
	and a, a ; $4efa
	jr nz, Label_0e_4f1d ; $4efb
	jr RestoreScreenAfterEquipSelect ; $4efd
RepairCounterChangeShoes:
	script_set_text $20ee ; $4eff
	script_speak $0e ; $4f05
	call PrepareEquipmentSelectScreen ; $4f0a
	farcall FarPtr_RunShoesSelectScreen ; $4f0d
	and a, a ; $4f10
	jr nz, Label_0e_4f1d ; $4f11
RestoreScreenAfterEquipSelect:
	call DisableLCDSafely ; $4f13
	farcall FarPtr_01_0a ; $4f16
	call EnableLCD ; $4f19
	ret ; $4f1c
Label_0e_4f1d:
	ld a, [$c2b1] ; $4f1d
	add a, $02 ; $4f20
	ld [$c2b1], a ; $4f22
	ld a, $11 ; $4f25
	ld [wStoryModeCurrentLocation], a ; $4f27
	ld a, [$c2b1] ; $4f2a
	ld [wStoryModeEntryPoint], a ; $4f2d
	ld a, $ff ; $4f30
	ld [$c294], a ; $4f32
	ld [wStoryModeExitLocationRequest], a ; $4f35
	call RestoreScreenAfterEquipSelect ; $4f38
	ret ; $4f3b
FetchAndPushShortTextArg:
	ldh a, [hWramBank] ; $4f3c
	push af ; $4f3e
	wram_bank $07 ; $4f3f
	ld de, $df00 ; $4f45
	wram_bank $05 ; $4f48
	farcall FarPtr_FetchShortTextToBuffer ; $4f4e
	ld hl, $df00 ; $4f51
	farcall FarPtr_PushTextArgString ; $4f54
	pop af ; $4f57
	wram_bank ; $4f58
	ret ; $4f5c
GetEquippedRacketNibble:
	ld a, [$c2bc] ; $4f5d
	and a, a ; $4f60
	jr z, Label_0e_4f65 ; $4f61
	jr Label_0e_4f6b ; $4f63
Label_0e_4f65:
	ld a, [wEquippedRacket] ; $4f65
	and a, $0f ; $4f68
	ret ; $4f6a
Label_0e_4f6b:
	ld a, [wEquippedRacket] ; $4f6b
	and a, $f0 ; $4f6e
	swap a ; $4f70
	ret ; $4f72
PushEquipmentNameTextArg:
	ld a, [$c2bc] ; $4f73
	and a, a ; $4f76
	jr z, Label_0e_4f7b ; $4f77
	jr Label_0e_4f8a ; $4f79
Label_0e_4f7b:
	call GetEquippedRacketNibble ; $4f7b
	ld hl, $00e5 ; $4f7e
	add a, l ; $4f81
	ld l, a ; $4f82
	jr nc, Label_0e_4f86 ; $4f83
	inc h ; $4f85
Label_0e_4f86:
	call FetchAndPushShortTextArg ; $4f86
	ret ; $4f89
Label_0e_4f8a:
	call GetEquippedRacketNibble ; $4f8a
	ld hl, $00f4 ; $4f8d
	add a, l ; $4f90
	ld l, a ; $4f91
	jr nc, Label_0e_4f95 ; $4f92
	inc h ; $4f94
Label_0e_4f95:
	call FetchAndPushShortTextArg ; $4f95
	ret ; $4f98
InitEquipmentHandoutDialogue:
	ld a, [$c2bc] ; $4f99
	and a, a ; $4f9c
	jr z, Label_0e_4fa1 ; $4f9d
	jr Label_0e_4fb0 ; $4f9f
Label_0e_4fa1:
	call GetEquippedRacketNibble ; $4fa1
	ld hl, $2403 ; $4fa4
	add a, l ; $4fa7
	ld l, a ; $4fa8
	jr nc, Label_0e_4fac ; $4fa9
	inc h ; $4fab
Label_0e_4fac:
	farcall FarPtr_InitDialogueTextCursor ; $4fac
	ret ; $4faf
Label_0e_4fb0:
	call GetEquippedRacketNibble ; $4fb0
	ld hl, $240a ; $4fb3
	add a, l ; $4fb6
	ld l, a ; $4fb7
	jr nc, Label_0e_4fbb ; $4fb8
	inc h ; $4fba
Label_0e_4fbb:
	farcall FarPtr_InitDialogueTextCursor ; $4fbb
	ret ; $4fbe
RepairCounterReturnA:
	ld a, $0b ; $4fbf
	ld [$c2b1], a ; $4fc1
	script_face_toward $00, $0e ; $4fc4
	script_set_position $02, $0f00, $0f00 ; $4fcc
	jp RepairCounterCheckEquipChanged ; $4fd7
	ret ; $4fda
RepairCounterReturnB:
	ld a, $0c ; $4fdb
	ld [$c2b1], a ; $4fdd
	farcall FarPtr_WaitPlayerMoveDone ; $4fe0
	script_player_speed $00f0 ; $4fe3
	script_move_player $0d00, $1100 ; $4fe9
	farcall FarPtr_WaitPlayerMoveDone ; $4ff3
	script_set_position $02, $1300, $1300 ; $4ff6
	jp RepairCounterCheckEquipChanged ; $5001
	ret ; $5004
CompareEquippedRacketToMinigameFlag:
	ld a, [wWaterSpriteMinigameFlag] ; $5005
	ld b, a ; $5008
	ld a, [wEquippedRacket] ; $5009
	cp a, b ; $500c
	jr z, Label_0e_5012 ; $500d
	ld a, $00 ; $500f
	ret ; $5011
Label_0e_5012:
	ld a, $ff ; $5012
	ret ; $5014
RepairCounterCheckEquipChanged:
	xor a, a ; $5015
	ld [wStoryModeShowLocationName], a ; $5016
	ld c, $08 ; $5019
	call BeginFadeIn ; $501b
	call WaitFadeEnd ; $501e
	call CompareEquippedRacketToMinigameFlag ; $5021
	cp a, $ff ; $5024
	jp nz, Label_0e_5056 ; $5026
	ld a, [$c2bc] ; $5029
	ld hl, $2401 ; $502c
	add a, l ; $502f
	ld l, a ; $5030
	jr nc, Label_0e_5034 ; $5031
	inc h ; $5033
Label_0e_5034:
	farcall FarPtr_InitDialogueTextCursor ; $5034
	call PushEquipmentNameTextArg ; $5037
	ld a, $0e ; $503a
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $503c
	farcall FarPtr_RunDialogueYesNoPrompt ; $503f
	farcall FarPtr_ScriptCloseDialogueWindow ; $5042
	script_wait_frames $05 ; $5045
	and a, a ; $504c
	jp nz, Label_0e_5080 ; $504d
	ld a, [$c2bc] ; $5050
	jp Label_0e_4e6a ; $5053
Label_0e_5056:
	ld a, [wEquippedRacket] ; $5056
	ld [wWaterSpriteMinigameFlag], a ; $5059
	call InitEquipmentHandoutDialogue ; $505c
	script_speak $0e ; $505f
	call ShowEquipChangeConfirmation ; $5064
	set_flag $0f, 7 ; $5067
	script_face_toward $00, $0e ; $506a
	script_set_text $20f1 ; $5072
	call PushEquipmentNameTextArg ; $5078
	script_speak $0e ; $507b
Label_0e_5080:
	script_set_text $20f2 ; $5080
	ld a, $0e ; $5086
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5088
	farcall FarPtr_RunDialogueYesNoPrompt ; $508b
	farcall FarPtr_ScriptCloseDialogueWindow ; $508e
	script_wait_frames $05 ; $5091
	and a, a ; $5098
	jp z, RepairCounterServiceMenu ; $5099
	jp RepairCounterFarewell ; $509c
RepairCounterChangedReturnA:
	ld a, $0b ; $509f
	ld [$c2b1], a ; $50a1
	script_set_position $02, $0f00, $0f00 ; $50a4
	jp RepairCounterReopenServiceMenu ; $50af
	ret ; $50b2
RepairCounterChangedReturnB:
	ld a, $0c ; $50b3
	ld [$c2b1], a ; $50b5
	farcall FarPtr_WaitPlayerMoveDone ; $50b8
	script_player_speed $00f0 ; $50bb
	script_move_player $0d00, $1300 ; $50c1
	farcall FarPtr_WaitPlayerMoveDone ; $50cb
	script_set_position $02, $1300, $1300 ; $50ce
	jp RepairCounterReopenServiceMenu ; $50d9
	ret ; $50dc
RepairCounterReopenServiceMenu:
	xor a, a ; $50dd
	ld [wStoryModeShowLocationName], a ; $50de
	script_set_text $20ef ; $50e1
	ld hl, $00e6 ; $50e7
	call FetchAndPushShortTextArg ; $50ea
	set_flag $0f, 7 ; $50ed
	script_face_toward $00, $0e ; $50f0
	ld c, $08 ; $50f8
	call BeginFadeIn ; $50fa
	call WaitFadeEnd ; $50fd
	ld hl, $20ec ; $5100
	ld de, $0101 ; $5103
	farcall FarPtr_RunMenuFromText ; $5106
	ld [$c2bc], a ; $5109
	cp a, $ff ; $510c
	jp z, RepairCounterFarewell ; $510e
	cp a, $02 ; $5111
	jp z, RepairCounterFarewell ; $5113
	cp a, $00 ; $5116
	jp z, RepairCounterChangeRackets ; $5118
	test_flag $0a, 7 ; $511b
	jp nz, RepairCounterChangeShoes ; $511e
	script_set_text $20e8 ; $5121
	script_speak $0e ; $5127
	script_set_text $20f2 ; $512c
	ld a, $0e ; $5132
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5134
	farcall FarPtr_RunDialogueYesNoPrompt ; $5137
	farcall FarPtr_ScriptCloseDialogueWindow ; $513a
	script_wait_frames $05 ; $513d
	and a, a ; $5144
	jp z, RepairCounterServiceMenu ; $5145
	jp RepairCounterFarewell ; $5148
	script_face $0e, $00 ; $514b
	ret ; $5152
ShowEquipChangeConfirmation:
	ld a, [$c2bc] ; $5153
	ld hl, $20ef ; $5156
	add a, l ; $5159
	ld l, a ; $515a
	jr nc, Label_0e_515e ; $515b
	inc h ; $515d
Label_0e_515e:
	farcall FarPtr_InitDialogueTextCursor ; $515e
	call PushEquipmentNameTextArg ; $5161
	ld a, [$c2bc] ; $5164
	and a, a ; $5167
	jr nz, Label_0e_51a3 ; $5168
	call Func_0e_520f ; $516a
	script_set_anim $00, $09 ; $516d
	script_face $00, $40 ; $5174
	ldh a, [hRomBank] ; $517b
	ld b, a ; $517d
	ld a, $00 ; $517e
	ld de, $51d7 ; $5180
	farcall FarPtr_ScriptSetActorScript ; $5183
	script_speak $8c ; $5186
	ld a, $00 ; $518b
	farcall FarPtr_SetActorNullScript ; $518d
	script_set_anim $00, $01 ; $5190
	script_face_toward $0e, $00 ; $5197
	call Func_0e_520f ; $519f
	ret ; $51a2
Label_0e_51a3:
	script_face $00, $40 ; $51a3
	ldh a, [hRomBank] ; $51aa
	ld b, a ; $51ac
	ld a, $00 ; $51ad
	ld de, $51e4 ; $51af
	farcall FarPtr_ScriptSetActorScript ; $51b2
	script_speak $8c ; $51b5
	ld a, $00 ; $51ba
	farcall FarPtr_SetActorNullScript ; $51bc
	script_set_anim $00, $01 ; $51bf
	script_set_speed $00, $0020 ; $51c6
	script_face_toward $0e, $00 ; $51ce
	ret ; $51d6
	INCBIN "data/bank_00e/d_51d7.bin" ; $51d7, 56 bytes
Func_0e_520f:
	ld a, [$c90e] ; $520f
	and a, a ; $5212
	jr z, Label_0e_5224 ; $5213
	ld a, $00 ; $5215
	farcall FarPtr_GetActorStateAddr ; $5217
	ld c, l ; $521a
	ld b, h ; $521b
	ld hl, $0037 ; $521c
	add hl, bc ; $521f
	ld a, [hl] ; $5220
	xor a, $20 ; $5221
	ld [hl], a ; $5223
Label_0e_5224:
	ret ; $5224
	INCBIN "data/bank_00e/d_5225.bin" ; $5225, 35 bytes
MarioWorldMapScripts_0e:
	; $5248, 14 bytes (map_tree)
	dw MarioWorldEntryPoints_0e ; slot 0 EntryPoints
	dw MarioWorldExitTriggers_0e ; slot 1 ExitTriggers
	dw MarioWorldActors_0e ; slot 2 Actors
	dw MarioWorldNpcScripts_0e ; slot 3 NpcScripts
	dw MarioWorldFacingScripts_0e ; slot 4 FacingScripts
	dw MarioWorldTileTriggers_0e ; slot 5 TileTriggers
	dw MarioWorldInitScript_0e ; slot 6 InitScript
MarioWorldActors_0e:
	; $5256, 262 bytes (map_actors)
	map_actor $0000, $7c6e, $1500, $3d00, $00, $4c, $01, $00
	map_actor $0000, $7c6e, $1500, $3d00, $00, $53, $01, $00
	map_actor $0000, $7c6e, $1500, $3d00, $00, $53, $01, $00
	map_actor $0000, $7c6e, $1500, $3d00, $00, $53, $01, $00
	map_actor $0000, $7c6e, $1500, $3d00, $00, $4e, $01, $00
	map_actor $0000, $7c6e, $1200, $1300, $40, $2e, $01, $00
	map_actor $0000, $7c6e, $1800, $1200, $40, $2c, $01, $00
	map_actor $0000, $7c6e, $1800, $0f40, $40, $6f, $01, $00
	map_actor $0000, $7c6e, $1800, $0d00, $40, $6d, $01, $00
	map_actor $0000, $7c6e, $1700, $1400, $40, $6e, $01, $00
	map_actor $0000, $7c6e, $0a00, $0f00, $40, $73, $01, $00
	map_actor $0000, $7c6e, $0c00, $1100, $40, $2b, $01, $00
	map_actor $0000, $7c6e, $0c00, $0f00, $40, $2d, $01, $00
	map_actor $0000, $7c6e, $0c00, $0d00, $40, $48, $01, $00
	map_actor $0000, $7c6e, $0e00, $0b00, $40, $72, $01, $00
	map_actor $0000, $7c6e, $1600, $0b00, $40, $2a, $01, $00
	map_actor $0000, $7c6e, $0f00, $1f00, $40, $70, $01, $00
	map_actor $0000, $7c6e, $1500, $1f00, $40, $71, $01, $00
	map_actor_end
MarioWorldEntryPoints_0e:
	; $535c, 41 bytes (map_entries)
	map_entry $01, $c0, $1200, $2100, $0000
	map_entry $02, $40, $1b00, $0b00, $0000
	map_entry $0a, $c0, $1200, $0800, $0000
	map_entry $0e, $c0, $1200, $0f00, $0000
	map_entry $0f, $c0, $1200, $0800, $0000
	db $ff
MarioWorldExitTriggers_0e:
	; $5385, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_0e, $1b, $0e
	db $ff
Func_0e_538e:
	script_set_text $308e ; $538e
	script_speak $12 ; $5394
	ret ; $5399
Func_0e_539a:
	ld hl, $308f ; $539a
	ld a, [$c2b0] ; $539d
	add a, l ; $53a0
	ld l, a ; $53a1
	jr nc, Label_0e_53a5 ; $53a2
	inc h ; $53a4
Label_0e_53a5:
	farcall FarPtr_InitDialogueTextCursor ; $53a5
	script_speak $11 ; $53a8
	ret ; $53ad
Func_0e_53ae:
	ld hl, $3093 ; $53ae
	ld a, [$c2b0] ; $53b1
	add a, l ; $53b4
	ld l, a ; $53b5
	jr nc, Label_0e_53b9 ; $53b6
	inc h ; $53b8
Label_0e_53b9:
	farcall FarPtr_InitDialogueTextCursor ; $53b9
	script_speak $0b ; $53bc
	ret ; $53c1
Func_0e_53c2:
	script_set_text $3097 ; $53c2
	sound $87 ; $53c8
	script_speak $09 ; $53ca
	ret ; $53cf
Func_0e_53d0:
	script_set_text $3098 ; $53d0
	sound $89 ; $53d6
	script_speak $0a ; $53d8
	ret ; $53dd
Func_0e_53de:
	script_set_text $3099 ; $53de
	sound $88 ; $53e4
	script_speak $0c ; $53e6
	ret ; $53eb
Func_0e_53ec:
	script_set_text $309a ; $53ec
	sound $86 ; $53f2
	script_speak $0d ; $53f4
	ret ; $53f9
Func_0e_53fa:
	ld hl, $309b ; $53fa
	ld a, [$c2b0] ; $53fd
	add a, l ; $5400
	ld l, a ; $5401
	jr nc, Label_0e_5405 ; $5402
	inc h ; $5404
Label_0e_5405:
	farcall FarPtr_InitDialogueTextCursor ; $5405
	script_speak $0f ; $5408
	ret ; $540d
Func_0e_540e:
	ld hl, $309f ; $540e
	ld a, [$c2b0] ; $5411
	add a, l ; $5414
	ld l, a ; $5415
	jr nc, Label_0e_5419 ; $5416
	inc h ; $5418
Label_0e_5419:
	farcall FarPtr_InitDialogueTextCursor ; $5419
	script_speak $10 ; $541c
	ret ; $5421
Func_0e_5422:
	ld hl, $30a3 ; $5422
	ld a, [$c2b0] ; $5425
	add a, l ; $5428
	ld l, a ; $5429
	jr nc, Label_0e_542d ; $542a
	inc h ; $542c
Label_0e_542d:
	farcall FarPtr_InitDialogueTextCursor ; $542d
	script_speak $0e ; $5430
	ret ; $5435
Func_0e_5436:
	script_set_text $30a7 ; $5436
	script_speak $13 ; $543c
	ret ; $5441
Func_0e_5442:
	script_set_text $30a8 ; $5442
	script_speak $14 ; $5448
	ret ; $544d
MarioWorldNpcScripts_0e:
	; $544e, 129 bytes (map_scripts)
	map_script $08, $10, $0000, Func_0e_64a4, $00, $00
	map_script $08, $20, $0000, Func_0e_654f, $00, $00
	map_script $08, $40, $0000, Func_0e_63f4, $00, $00
	map_script $08, $80, $0000, Func_0e_633d, $03, $00
	map_script $11, $ff, $0000, Func_0e_539a, $03, $00
	map_script $0b, $ff, $0000, Func_0e_53ae, $03, $00
	map_script $09, $ff, $0000, Func_0e_53c2, $03, $00
	map_script $0a, $ff, $0000, Func_0e_53d0, $03, $00
	map_script $0c, $ff, $0000, Func_0e_53de, $03, $00
	map_script $0d, $ff, $0000, Func_0e_53ec, $03, $00
	map_script $0f, $ff, $0000, Func_0e_53fa, $03, $00
	map_script $10, $ff, $0000, Func_0e_540e, $03, $00
	map_script $0e, $ff, $0000, Func_0e_5422, $03, $00
	map_script $13, $ff, $0000, Func_0e_5436, $03, $00
	map_script $14, $ff, $0000, Func_0e_5442, $03, $00
	map_script $12, $ff, $0000, Func_0e_538e, $03, $00
	db $ff
MarioWorldFacingScripts_0e:
	ds 1, $ff ; $54cf, fill
MarioWorldTileTriggers_0e:
	db $ff ; $54d0
	ret ; $54d1
MarioWorldInitScript_0e:
	call ComputeMarioWorldProgressIndex ; $54d2
	ld a, [wStoryModeEntryPoint] ; $54d5
	cp a, $0a ; $54d8
	jp z, MarioWorldArrivalSingles ; $54da
	cp a, $0e ; $54dd
	jp z, Label_0e_69ad ; $54df
	cp a, $0f ; $54e2
	jp z, MarioWorldArrivalSingles ; $54e4
	test_flag $05, 7 ; $54e7
	jr nz, Label_0e_550c ; $54ea
	test_flag $16, 2 ; $54ec
	ret z ; $54ef
	ld a, [wStoryModeEntryPoint] ; $54f0
	inc a ; $54f3
	jr z, Label_0e_5509 ; $54f4
	script_set_speed $00, $0014 ; $54f6
	script_move_target $00, $1200, $1d00 ; $54fe
Label_0e_5509:
	jp Label_0e_69fb ; $5509
Label_0e_550c:
	test_flag $16, 3 ; $550c
	ret z ; $550f
	ld a, [wStoryModeEntryPoint] ; $5510
	inc a ; $5513
	jr z, Label_0e_5529 ; $5514
	script_set_speed $00, $0014 ; $5516
	script_move_target $00, $1200, $1d00 ; $551e
Label_0e_5529:
	jp Label_0e_69fb ; $5529
	INCBIN "data/bank_00e/d_552c.bin" ; $552c, 49 bytes
ComputeMarioWorldProgressIndex:
	test_flag $05, 7 ; $555d
	jr nz, Label_0e_556e ; $5560
	ld a, $00 ; $5562
	test_flag $07, 3 ; $5564
	jr z, Label_0e_556a ; $5567
	inc a ; $5569
Label_0e_556a:
	ld [$c2b0], a ; $556a
	ret ; $556d
Label_0e_556e:
	ld a, $02 ; $556e
	test_flag $06, 4 ; $5570
	jr z, Label_0e_556a ; $5573
	inc a ; $5575
	jr Label_0e_556a ; $5576
	ret ; $5578
MarioWorldArrivalSingles:
	test_flag $05, 7 ; $5579
	jp nz, MarioWorldArrivalDoubles ; $557c
	test_flag $0d, 6 ; $557f
	jr nz, Label_0e_558a ; $5582
	test_flag $16, 2 ; $5584
	jp nz, Label_0e_69b3 ; $5587
Label_0e_558a:
	script_set_position $00, $3f00, $3f00 ; $558a
	ld c, $04 ; $5595
	call BeginFadeIn ; $5597
	call WaitFadeEnd ; $559a
	script_wait_frames $28 ; $559d
	call Func_0e_6a51 ; $55a4
	script_set_position $00, $1200, $2500 ; $55a7
	script_set_speed $00, $0010 ; $55b2
	script_move_target $00, $1200, $2080 ; $55ba
	script_player_speed $0010 ; $55c5
	script_move_player $1200, $1b00 ; $55cb
	script_wait_frames $50 ; $55d5
	script_face $13, $c0 ; $55dc
	script_wait_frames $0a ; $55e3
	test_flag $0d, 6 ; $55ea
	jr nz, Label_0e_55ff ; $55ed
	script_set_text $304b ; $55ef
	script_speak $13 ; $55f5
	script_speak $13 ; $55fa
Label_0e_55ff:
	script_player_speed $0020 ; $55ff
	script_move_player $1200, $1800 ; $5605
	farcall FarPtr_WaitPlayerMoveDone ; $560f
	script_wait_frames $0a ; $5612
	script_set_anim $08, $03 ; $5619
	script_wait_idle $08 ; $5620
	test_flag $0d, 6 ; $5625
	jr nz, Label_0e_562f ; $5628
	script_speak $08 ; $562a
Label_0e_562f:
	script_player_speed $0014 ; $562f
	script_set_speed $00, $0014 ; $5635
	script_set_speed $13, $0014 ; $563d
	script_set_speed $08, $0014 ; $5645
	script_move_target $00, $1200, $1100 ; $564d
	script_move_target $13, $1200, $1700 ; $5658
	script_wait_frames $28 ; $5663
	script_move_player $1200, $0d00 ; $566a
	script_wait_move $13 ; $5674
	script_move_target $08, $1200, $0900 ; $5679
	script_move_target $13, $1200, $1300 ; $5684
	script_wait_move $13 ; $568f
	script_move_target $13, $0d00, $1300 ; $5694
	script_wait_move $08 ; $569f
	test_flag $0d, 6 ; $56a4
	jr z, Label_0e_56c0 ; $56a7
	script_face $08, $40 ; $56a9
	script_wait_frames $14 ; $56b0
	ld a, $01 ; $56b7
	ld [$c294], a ; $56b9
	ld [wStoryModeExitLocationRequest], a ; $56bc
	ret ; $56bf
Label_0e_56c0:
	call Func_0e_6ad4 ; $56c0
	script_set_speed $0f, $0020 ; $56c3
	script_set_speed $07, $0020 ; $56cb
	script_wait_frames $28 ; $56d3
	script_set_anim $0f, $02 ; $56da
	script_wait_idle $0f ; $56e1
	script_move_target $0f, $0f00, $0e00 ; $56e6
	script_move_target $07, $1000, $0c00 ; $56f1
	script_wait_move $07 ; $56fc
	script_set_position $07, $3f00, $3f00 ; $5701
	script_face $0f, $c0 ; $570c
	script_wait_frames $14 ; $5713
	script_speak $0f ; $571a
	script_wait_frames $14 ; $571f
	script_set_speed $10, $0020 ; $5726
	script_set_speed $0e, $0020 ; $572e
	script_move_target $0f, $1000, $0d00 ; $5736
	script_wait_move $0f ; $5741
	script_wait_frames $0a ; $5746
	script_face $10, $00 ; $574d
	script_move_target $10, $0d00, $0d00 ; $5754
	script_wait_move $10 ; $575f
	script_face $10, $c0 ; $5764
	script_wait_frames $0a ; $576b
	script_face $0e, $00 ; $5772
	script_move_target $0e, $0e00, $1000 ; $5779
	script_wait_move $0e ; $5784
	script_face $0e, $c0 ; $5789
	script_wait_frames $28 ; $5790
	sound $96 ; $5797
	script_set_position $04, $0f00, $0900 ; $5799
	script_wait_frames $04 ; $57a4
	sound $96 ; $57ab
	script_set_position $05, $1300, $0700 ; $57ad
	script_wait_frames $04 ; $57b8
	sound $96 ; $57bf
	script_set_position $06, $1700, $0900 ; $57c1
	script_wait_frames $04 ; $57cc
	script_face $0f, $00 ; $57d3
	script_move_target $0f, $1100, $0d00 ; $57da
	script_wait_move $0f ; $57e5
	script_face $0f, $c0 ; $57ea
	script_wait_frames $0a ; $57f1
	script_face $10, $00 ; $57f8
	script_move_target $10, $0f00, $0d00 ; $57ff
	script_wait_move $10 ; $580a
	script_face $10, $c0 ; $580f
	script_wait_frames $0a ; $5816
	script_face $0e, $00 ; $581d
	script_move_target $0e, $1100, $0f00 ; $5824
	script_wait_move $0e ; $582f
	script_face $0e, $c0 ; $5834
	script_wait_frames $0a ; $583b
	call Func_0e_6db7 ; $5842
	sound $96 ; $5845
	script_set_position $04, $1380, $0f80 ; $5847
	script_wait_frames $14 ; $5852
	script_face $12, $80 ; $5859
	script_wait_frames $28 ; $5860
	script_set_anim $08, $03 ; $5867
	script_set_anim $12, $03 ; $586e
	script_wait_idle $12 ; $5875
	script_wait_frames $0a ; $587a
	script_face $08, $40 ; $5881
	script_wait_frames $0a ; $5888
	script_set_speed $08, $0020 ; $588f
	script_move_target $08, $1200, $0b00 ; $5897
	script_wait_move $08 ; $58a2
	script_face $11, $40 ; $58a7
	script_face $12, $40 ; $58ae
	script_set_position $04, $3f00, $3f00 ; $58b5
	script_speak $08 ; $58c0
	script_wait_frames $0a ; $58c5
	call Func_0e_6f2b ; $58cc
	script_move_target $0f, $1300, $0f00 ; $58cf
	script_move_target $10, $1100, $0f00 ; $58da
	script_move_target $0e, $1400, $1100 ; $58e5
	script_wait_move $0e ; $58f0
	script_move_target $0e, $1300, $1300 ; $58f5
	script_wait_move $0e ; $5900
	script_face $0e, $c0 ; $5905
	script_wait_frames $28 ; $590c
	set_flag $16, 2 ; $5913
	farcall FarPtr_SaveStorySlotWithTimer ; $5916
	ld a, $08 ; $5919
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $591b
	farcall FarPtr_RunDialogueYesNoPrompt ; $591e
	farcall FarPtr_ScriptCloseDialogueWindow ; $5921
	script_wait_frames $05 ; $5924
	and a, a ; $592b
	jr z, ExhibitionAcceptedSingles ; $592c
	script_set_text $3060 ; $592e
	call ExhibitionDeclinedCutscene ; $5934
	ret ; $5937
ExhibitionAcceptedSingles:
	script_wait_frames $0a ; $5938
	script_set_anim $0f, $03 ; $593f
	script_wait_idle $0f ; $5946
	script_wait_frames $0a ; $594b
	script_set_text $3063 ; $5952
	script_speak $0f ; $5958
	script_speak $08 ; $595d
	script_face $0b, $c0 ; $5962
	script_wait_frames $04 ; $5969
	script_face $0f, $c0 ; $5970
	script_wait_frames $04 ; $5977
	script_face $10, $c0 ; $597e
	script_wait_frames $04 ; $5985
	script_face $0a, $c0 ; $598c
	script_wait_frames $04 ; $5993
	script_face $09, $c0 ; $599a
	script_wait_frames $04 ; $59a1
	script_face $0e, $c0 ; $59a8
	script_wait_frames $0a ; $59af
	script_set_anim $0f, $03 ; $59b6
	script_set_anim $10, $03 ; $59bd
	script_set_anim $0e, $03 ; $59c4
	script_set_anim $11, $03 ; $59cb
	script_set_anim $12, $03 ; $59d2
	script_set_anim $0b, $03 ; $59d9
	script_set_anim $0a, $03 ; $59e0
	script_set_anim $09, $03 ; $59e7
	script_set_anim $0c, $03 ; $59ee
	script_set_anim $13, $03 ; $59f5
	script_wait_idle $13 ; $59fc
	script_player_speed $0010 ; $5a01
	script_move_player $1500, $0d00 ; $5a07
	script_set_speed $08, $0014 ; $5a11
	script_set_speed $0f, $0014 ; $5a19
	script_set_speed $10, $0014 ; $5a21
	script_set_speed $0e, $0014 ; $5a29
	script_set_speed $11, $0014 ; $5a31
	script_set_speed $12, $0014 ; $5a39
	script_set_speed $0b, $0014 ; $5a41
	script_set_speed $0a, $0014 ; $5a49
	script_set_speed $09, $0014 ; $5a51
	script_set_speed $0d, $0014 ; $5a59
	script_set_speed $0c, $0014 ; $5a61
	script_set_speed $13, $0014 ; $5a69
	script_set_speed $00, $0014 ; $5a71
	ldh a, [hRomBank] ; $5a79
	ld b, a ; $5a7b
	ld a, $11 ; $5a7c
	ld de, $552d ; $5a7e
	farcall FarPtr_ScriptSetActorScript ; $5a81
	script_wait_frames $14 ; $5a84
	ldh a, [hRomBank] ; $5a8b
	ld b, a ; $5a8d
	ld a, $08 ; $5a8e
	ld de, $552d ; $5a90
	farcall FarPtr_ScriptSetActorScript ; $5a93
	script_wait_frames $14 ; $5a96
	ldh a, [hRomBank] ; $5a9d
	ld b, a ; $5a9f
	ld a, $12 ; $5aa0
	ld de, $552d ; $5aa2
	farcall FarPtr_ScriptSetActorScript ; $5aa5
	script_wait_frames $64 ; $5aa8
	ldh a, [hRomBank] ; $5aaf
	ld b, a ; $5ab1
	ld a, $0b ; $5ab2
	ld de, $552d ; $5ab4
	farcall FarPtr_ScriptSetActorScript ; $5ab7
	ldh a, [hRomBank] ; $5aba
	ld b, a ; $5abc
	ld a, $0a ; $5abd
	ld de, $552d ; $5abf
	farcall FarPtr_ScriptSetActorScript ; $5ac2
	ldh a, [hRomBank] ; $5ac5
	ld b, a ; $5ac7
	ld a, $09 ; $5ac8
	ld de, $552d ; $5aca
	farcall FarPtr_ScriptSetActorScript ; $5acd
	ldh a, [hRomBank] ; $5ad0
	ld b, a ; $5ad2
	ld a, $0c ; $5ad3
	ld de, $552d ; $5ad5
	farcall FarPtr_ScriptSetActorScript ; $5ad8
	ldh a, [hRomBank] ; $5adb
	ld b, a ; $5add
	ld a, $0d ; $5ade
	ld de, $552d ; $5ae0
	farcall FarPtr_ScriptSetActorScript ; $5ae3
	script_wait_frames $3c ; $5ae6
	ldh a, [hRomBank] ; $5aed
	ld b, a ; $5aef
	ld a, $0f ; $5af0
	ld de, $552d ; $5af2
	farcall FarPtr_ScriptSetActorScript ; $5af5
	ldh a, [hRomBank] ; $5af8
	ld b, a ; $5afa
	ld a, $10 ; $5afb
	ld de, $552d ; $5afd
	farcall FarPtr_ScriptSetActorScript ; $5b00
	script_wait_frames $28 ; $5b03
	ldh a, [hRomBank] ; $5b0a
	ld b, a ; $5b0c
	ld a, $0e ; $5b0d
	ld de, $552d ; $5b0f
	farcall FarPtr_ScriptSetActorScript ; $5b12
	ld a, $0e ; $5b15
	farcall FarPtr_WaitActorScriptDone ; $5b17
	script_move_player $1200, $0d00 ; $5b1a
	script_move_target $13, $1000, $0f00 ; $5b24
	script_wait_move $13 ; $5b2f
	script_move_target $13, $1200, $0f00 ; $5b34
	script_wait_move $13 ; $5b3f
	script_face $13, $40 ; $5b44
	script_wait_frames $14 ; $5b4b
	script_speak $13 ; $5b52
	script_wait_frames $0a ; $5b57
	script_set_anim $00, $03 ; $5b5e
	script_wait_idle $00 ; $5b65
	script_wait_frames $14 ; $5b6a
	ldh a, [hRomBank] ; $5b71
	ld b, a ; $5b73
	ld a, $13 ; $5b74
	ld de, $5545 ; $5b76
	farcall FarPtr_ScriptSetActorScript ; $5b79
	script_wait_frames $14 ; $5b7c
	ldh a, [hRomBank] ; $5b83
	ld b, a ; $5b85
	ld a, $00 ; $5b86
	ld de, $5545 ; $5b88
	farcall FarPtr_ScriptSetActorScript ; $5b8b
	script_wait_frames $3c ; $5b8e
	script_move_player $1500, $0d00 ; $5b95
	ld a, $00 ; $5b9f
	farcall FarPtr_WaitActorScriptDone ; $5ba1
	call Func_0e_7150 ; $5ba4
	ld a, $1c ; $5ba7
	ld [wStoryModeCurrentLocation], a ; $5ba9
	ld a, $01 ; $5bac
	ld [wStoryModeEntryPoint], a ; $5bae
	ld a, $ff ; $5bb1
	ld [$c294], a ; $5bb3
	ld [wStoryModeExitLocationRequest], a ; $5bb6
	ret ; $5bb9
MarioWorldArrivalDoubles:
	test_flag $0d, 6 ; $5bba
	jr nz, Label_0e_5bc5 ; $5bbd
	test_flag $16, 3 ; $5bbf
	jp nz, Label_0e_69c5 ; $5bc2
Label_0e_5bc5:
	ldh a, [hRomBank] ; $5bc5
	ld b, a ; $5bc7
	ld a, $02 ; $5bc8
	ld de, $7c6e ; $5bca
	farcall FarPtr_ScriptSetActorScript ; $5bcd
	script_set_position $00, $3f00, $3f00 ; $5bd0
	script_set_position $02, $3f00, $3f00 ; $5bdb
	ld c, $04 ; $5be6
	call BeginFadeIn ; $5be8
	call WaitFadeEnd ; $5beb
	script_wait_frames $28 ; $5bee
	call Func_0e_6a51 ; $5bf5
	script_set_position $00, $1100, $2500 ; $5bf8
	script_set_position $02, $1300, $2500 ; $5c03
	script_set_speed $00, $0010 ; $5c0e
	script_set_speed $02, $0010 ; $5c16
	script_move_target $00, $1100, $2080 ; $5c1e
	script_move_target $02, $1300, $2080 ; $5c29
	script_player_speed $0010 ; $5c34
	script_move_player $1200, $1b00 ; $5c3a
	script_wait_frames $50 ; $5c44
	script_face $13, $c0 ; $5c4b
	script_wait_frames $0a ; $5c52
	test_flag $0d, 6 ; $5c59
	jr nz, Label_0e_5c6e ; $5c5c
	script_set_text $3066 ; $5c5e
	script_speak $13 ; $5c64
	script_speak $13 ; $5c69
Label_0e_5c6e:
	script_player_speed $0020 ; $5c6e
	script_move_player $1200, $1800 ; $5c74
	farcall FarPtr_WaitPlayerMoveDone ; $5c7e
	script_wait_frames $0a ; $5c81
	script_set_anim $08, $03 ; $5c88
	script_wait_idle $08 ; $5c8f
	test_flag $0d, 6 ; $5c94
	jr nz, Label_0e_5c9e ; $5c97
	script_speak $08 ; $5c99
Label_0e_5c9e:
	script_player_speed $0014 ; $5c9e
	script_set_speed $00, $0014 ; $5ca4
	script_set_speed $02, $0014 ; $5cac
	script_set_speed $13, $0014 ; $5cb4
	script_set_speed $08, $0014 ; $5cbc
	script_move_target $13, $1200, $1700 ; $5cc4
	script_wait_frames $14 ; $5ccf
	script_move_target $00, $1100, $1100 ; $5cd6
	script_move_target $02, $1300, $1100 ; $5ce1
	script_wait_frames $28 ; $5cec
	script_move_player $1200, $0d00 ; $5cf3
	script_wait_move $13 ; $5cfd
	script_move_target $08, $1200, $0900 ; $5d02
	script_move_target $13, $1200, $1300 ; $5d0d
	script_wait_move $13 ; $5d18
	script_move_target $13, $0d00, $1300 ; $5d1d
	script_wait_move $08 ; $5d28
	test_flag $0d, 6 ; $5d2d
	jr z, Label_0e_5d49 ; $5d30
	script_face $08, $40 ; $5d32
	script_wait_frames $14 ; $5d39
	ld a, $01 ; $5d40
	ld [$c294], a ; $5d42
	ld [wStoryModeExitLocationRequest], a ; $5d45
	ret ; $5d48
Label_0e_5d49:
	call Func_0e_6ad4 ; $5d49
	script_set_position $07, $3f00, $3f00 ; $5d4c
	script_face $0f, $80 ; $5d57
	script_wait_frames $28 ; $5d5e
	script_speak $0f ; $5d65
	script_wait_frames $14 ; $5d6a
	ld a, $0d ; $5d71
	ld de, $ff80 ; $5d73
	farcall FarPtr_ScriptSetActorJumpVelocity ; $5d76
	script_wait_frames $14 ; $5d79
	ld a, $0d ; $5d80
	ld de, $ff80 ; $5d82
	farcall FarPtr_ScriptSetActorJumpVelocity ; $5d85
	script_wait_frames $28 ; $5d88
	sound $86 ; $5d8f
	script_speak $0d ; $5d91
	sound $99 ; $5d96
	script_set_position $07, $0f00, $0d00 ; $5d98
	script_set_speed $0f, $0020 ; $5da3
	script_set_speed $07, $0020 ; $5dab
	script_wait_frames $28 ; $5db3
	script_set_anim $0f, $02 ; $5dba
	script_wait_idle $0f ; $5dc1
	script_move_target $0f, $0f00, $0e00 ; $5dc6
	script_move_target $07, $1000, $0c00 ; $5dd1
	script_wait_move $07 ; $5ddc
	script_set_position $07, $3f00, $3f00 ; $5de1
	script_face $0f, $c0 ; $5dec
	script_wait_frames $14 ; $5df3
	script_speak $0f ; $5dfa
	script_set_speed $10, $0020 ; $5dff
	script_set_speed $0e, $0020 ; $5e07
	script_move_target $0f, $0f00, $0d00 ; $5e0f
	script_wait_move $0f ; $5e1a
	script_wait_frames $0a ; $5e1f
	script_face $10, $00 ; $5e26
	script_move_target $10, $0d80, $0d00 ; $5e2d
	script_wait_move $10 ; $5e38
	script_face $10, $c0 ; $5e3d
	script_wait_frames $0a ; $5e44
	script_face $0e, $00 ; $5e4b
	script_move_target $0e, $0f80, $0f80 ; $5e52
	script_wait_move $0e ; $5e5d
	script_face $0e, $c0 ; $5e62
	script_wait_frames $28 ; $5e69
	sound $99 ; $5e70
	script_set_position $04, $0f00, $0900 ; $5e72
	script_wait_frames $04 ; $5e7d
	sound $99 ; $5e84
	script_set_position $05, $1300, $0700 ; $5e86
	script_wait_frames $04 ; $5e91
	sound $99 ; $5e98
	script_set_position $06, $1700, $0900 ; $5e9a
	script_wait_frames $04 ; $5ea5
	script_face $0f, $00 ; $5eac
	script_move_target $0f, $1100, $0d00 ; $5eb3
	script_wait_move $0f ; $5ebe
	script_face $0f, $c0 ; $5ec3
	script_wait_frames $0a ; $5eca
	script_face $10, $00 ; $5ed1
	script_move_target $10, $0f00, $0d00 ; $5ed8
	script_wait_move $10 ; $5ee3
	script_face $10, $c0 ; $5ee8
	script_wait_frames $0a ; $5eef
	script_face $0e, $00 ; $5ef6
	script_move_target $0e, $1100, $0f00 ; $5efd
	script_wait_move $0e ; $5f08
	script_face $0e, $c0 ; $5f0d
	script_wait_frames $0a ; $5f14
	call Func_0e_6db7 ; $5f1b
	sound $96 ; $5f1e
	script_set_position $04, $1180, $0f80 ; $5f20
	script_set_position $05, $1380, $0f80 ; $5f2b
	script_face $00, $00 ; $5f36
	script_face $02, $80 ; $5f3d
	script_wait_frames $28 ; $5f44
	script_face $00, $c0 ; $5f4b
	script_face $02, $c0 ; $5f52
	script_wait_frames $14 ; $5f59
	script_set_position $04, $3f00, $3f00 ; $5f60
	script_set_position $05, $3f00, $3f00 ; $5f6b
	script_face $12, $80 ; $5f76
	script_wait_frames $28 ; $5f7d
	script_set_anim $08, $03 ; $5f84
	script_set_anim $12, $03 ; $5f8b
	script_wait_idle $12 ; $5f92
	script_wait_frames $0a ; $5f97
	script_face $08, $40 ; $5f9e
	script_wait_frames $0a ; $5fa5
	script_set_speed $08, $0020 ; $5fac
	script_move_target $08, $1200, $0b00 ; $5fb4
	script_wait_move $08 ; $5fbf
	script_face $11, $40 ; $5fc4
	script_face $12, $40 ; $5fcb
	script_speak $08 ; $5fd2
	call Func_0e_6f2b ; $5fd7
	script_move_target $0f, $1300, $0f00 ; $5fda
	script_move_target $10, $1100, $0f00 ; $5fe5
	script_move_target $0e, $1500, $0f00 ; $5ff0
	script_wait_move $0e ; $5ffb
	script_move_target $0e, $1500, $1300 ; $6000
	script_wait_move $0e ; $600b
	script_move_target $0e, $1300, $1300 ; $6010
	script_wait_move $0e ; $601b
	script_face $0e, $c0 ; $6020
	script_wait_frames $28 ; $6027
	set_flag $16, 3 ; $602e
	farcall FarPtr_SaveStorySlotWithTimer ; $6031
	ld a, $08 ; $6034
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6036
	farcall FarPtr_RunDialogueYesNoPrompt ; $6039
	farcall FarPtr_ScriptCloseDialogueWindow ; $603c
	script_wait_frames $05 ; $603f
	and a, a ; $6046
	jr z, ExhibitionAcceptedDoubles ; $6047
	script_set_text $307d ; $6049
	call ExhibitionDeclinedCutscene ; $604f
	ld a, $02 ; $6052
	farcall FarPtr_GetActorStateAddr ; $6054
	ld c, l ; $6057
	ld b, h ; $6058
	ld de, $d000 ; $6059
	farcall FarPtr_04_20 ; $605c
	ret ; $605f
ExhibitionAcceptedDoubles:
	script_wait_frames $0a ; $6060
	script_set_anim $0f, $03 ; $6067
	script_wait_idle $0f ; $606e
	script_wait_frames $0a ; $6073
	script_set_text $3080 ; $607a
	script_speak $0f ; $6080
	script_speak $08 ; $6085
	script_face $0b, $c0 ; $608a
	script_wait_frames $04 ; $6091
	script_face $0f, $c0 ; $6098
	script_wait_frames $04 ; $609f
	script_face $10, $c0 ; $60a6
	script_wait_frames $04 ; $60ad
	script_face $0a, $c0 ; $60b4
	script_wait_frames $04 ; $60bb
	script_face $09, $c0 ; $60c2
	script_wait_frames $04 ; $60c9
	script_face $0e, $c0 ; $60d0
	script_wait_frames $0a ; $60d7
	script_set_anim $0f, $03 ; $60de
	script_set_anim $10, $03 ; $60e5
	script_set_anim $0e, $03 ; $60ec
	script_set_anim $11, $03 ; $60f3
	script_set_anim $12, $03 ; $60fa
	script_set_anim $0b, $03 ; $6101
	script_set_anim $0a, $03 ; $6108
	script_set_anim $09, $03 ; $610f
	script_set_anim $0c, $03 ; $6116
	script_set_anim $13, $03 ; $611d
	script_wait_idle $13 ; $6124
	script_player_speed $0010 ; $6129
	script_move_player $1500, $0d00 ; $612f
	script_set_speed $08, $0014 ; $6139
	script_set_speed $0f, $0014 ; $6141
	script_set_speed $10, $0014 ; $6149
	script_set_speed $0e, $0014 ; $6151
	script_set_speed $11, $0014 ; $6159
	script_set_speed $12, $0014 ; $6161
	script_set_speed $0b, $0014 ; $6169
	script_set_speed $0a, $0014 ; $6171
	script_set_speed $09, $0014 ; $6179
	script_set_speed $0d, $0014 ; $6181
	script_set_speed $0c, $0014 ; $6189
	script_set_speed $13, $0014 ; $6191
	script_set_speed $00, $0014 ; $6199
	ldh a, [hRomBank] ; $61a1
	ld b, a ; $61a3
	ld a, $11 ; $61a4
	ld de, $552d ; $61a6
	farcall FarPtr_ScriptSetActorScript ; $61a9
	script_wait_frames $14 ; $61ac
	ldh a, [hRomBank] ; $61b3
	ld b, a ; $61b5
	ld a, $08 ; $61b6
	ld de, $552d ; $61b8
	farcall FarPtr_ScriptSetActorScript ; $61bb
	script_wait_frames $14 ; $61be
	ldh a, [hRomBank] ; $61c5
	ld b, a ; $61c7
	ld a, $12 ; $61c8
	ld de, $552d ; $61ca
	farcall FarPtr_ScriptSetActorScript ; $61cd
	script_wait_frames $64 ; $61d0
	ldh a, [hRomBank] ; $61d7
	ld b, a ; $61d9
	ld a, $0b ; $61da
	ld de, $552d ; $61dc
	farcall FarPtr_ScriptSetActorScript ; $61df
	ldh a, [hRomBank] ; $61e2
	ld b, a ; $61e4
	ld a, $0a ; $61e5
	ld de, $552d ; $61e7
	farcall FarPtr_ScriptSetActorScript ; $61ea
	ldh a, [hRomBank] ; $61ed
	ld b, a ; $61ef
	ld a, $09 ; $61f0
	ld de, $552d ; $61f2
	farcall FarPtr_ScriptSetActorScript ; $61f5
	ldh a, [hRomBank] ; $61f8
	ld b, a ; $61fa
	ld a, $0c ; $61fb
	ld de, $552d ; $61fd
	farcall FarPtr_ScriptSetActorScript ; $6200
	ldh a, [hRomBank] ; $6203
	ld b, a ; $6205
	ld a, $0d ; $6206
	ld de, $552d ; $6208
	farcall FarPtr_ScriptSetActorScript ; $620b
	script_wait_frames $3c ; $620e
	ldh a, [hRomBank] ; $6215
	ld b, a ; $6217
	ld a, $0f ; $6218
	ld de, $552d ; $621a
	farcall FarPtr_ScriptSetActorScript ; $621d
	ldh a, [hRomBank] ; $6220
	ld b, a ; $6222
	ld a, $10 ; $6223
	ld de, $552d ; $6225
	farcall FarPtr_ScriptSetActorScript ; $6228
	script_wait_frames $1e ; $622b
	script_move_target $0e, $1500, $1300 ; $6232
	script_wait_move $0e ; $623d
	ldh a, [hRomBank] ; $6242
	ld b, a ; $6244
	ld a, $0e ; $6245
	ld de, $552d ; $6247
	farcall FarPtr_ScriptSetActorScript ; $624a
	ld a, $0e ; $624d
	farcall FarPtr_WaitActorScriptDone ; $624f
	script_move_player $1200, $0d00 ; $6252
	script_move_target $13, $1000, $0f00 ; $625c
	script_wait_move $13 ; $6267
	script_move_target $13, $1200, $0f00 ; $626c
	script_wait_move $13 ; $6277
	script_face $13, $40 ; $627c
	script_wait_frames $14 ; $6283
	script_speak $13 ; $628a
	script_wait_frames $0a ; $628f
	script_set_anim $02, $03 ; $6296
	script_set_anim $00, $03 ; $629d
	script_wait_idle $00 ; $62a4
	script_wait_frames $14 ; $62a9
	ldh a, [hRomBank] ; $62b0
	ld b, a ; $62b2
	ld a, $13 ; $62b3
	ld de, $5545 ; $62b5
	farcall FarPtr_ScriptSetActorScript ; $62b8
	script_wait_frames $14 ; $62bb
	ldh a, [hRomBank] ; $62c2
	ld b, a ; $62c4
	ld a, $00 ; $62c5
	ld de, $5545 ; $62c7
	farcall FarPtr_ScriptSetActorScript ; $62ca
	script_wait_frames $32 ; $62cd
	ldh a, [hRomBank] ; $62d4
	ld b, a ; $62d6
	ld a, $02 ; $62d7
	ld de, $5545 ; $62d9
	farcall FarPtr_ScriptSetActorScript ; $62dc
	script_wait_frames $3c ; $62df
	script_move_player $1500, $0d00 ; $62e6
	ld a, $02 ; $62f0
	farcall FarPtr_WaitActorScriptDone ; $62f2
	call Func_0e_7150 ; $62f5
	ld a, $1c ; $62f8
	ld [wStoryModeCurrentLocation], a ; $62fa
	ld a, $04 ; $62fd
	ld [wStoryModeEntryPoint], a ; $62ff
	ld a, $ff ; $6302
	ld [$c294], a ; $6304
	ld [wStoryModeExitLocationRequest], a ; $6307
	ret ; $630a
	INCBIN "data/bank_00e/d_630b.bin" ; $630b, 50 bytes
Func_0e_633d:
	script_set_speed $00, $0018 ; $633d
	script_set_speed $02, $0018 ; $6345
	test_flag $05, 7 ; $634d
	jr nz, Label_0e_639b ; $6350
	script_move_target $00, $1000, $0900 ; $6352
	script_wait_move $00 ; $635d
	script_move_target $00, $1000, $0d00 ; $6362
	script_wait_move $00 ; $636d
	script_move_target $00, $1200, $0d00 ; $6372
	script_wait_move $00 ; $637d
	script_face $00, $c0 ; $6382
	script_face $08, $40 ; $6389
	script_set_speed $00, $0010 ; $6390
	jp PromptExhibitionMatch ; $6398
Label_0e_639b:
	ldh a, [hRomBank] ; $639b
	ld b, a ; $639d
	ld a, $02 ; $639e
	ld de, $7c6e ; $63a0
	farcall FarPtr_ScriptSetActorScript ; $63a3
	call MoveDoublesPartnerToPlayer ; $63a6
	script_face $08, $40 ; $63a9
	ldh a, [hRomBank] ; $63b0
	ld b, a ; $63b2
	ld a, $00 ; $63b3
	ld de, $630b ; $63b5
	farcall FarPtr_ScriptSetActorScript ; $63b8
	script_wait_frames $14 ; $63bb
	ldh a, [hRomBank] ; $63c2
	ld b, a ; $63c4
	ld a, $02 ; $63c5
	ld de, $6324 ; $63c7
	farcall FarPtr_ScriptSetActorScript ; $63ca
	ld a, $00 ; $63cd
	farcall FarPtr_WaitActorScriptDone ; $63cf
	ld a, $02 ; $63d2
	farcall FarPtr_WaitActorScriptDone ; $63d4
	jp PromptExhibitionMatch ; $63d7
	INCBIN "data/bank_00e/d_63da.bin" ; $63da, 26 bytes
Func_0e_63f4:
	script_set_speed $00, $0018 ; $63f4
	script_set_speed $02, $0018 ; $63fc
	test_flag $05, 7 ; $6404
	jr nz, Label_0e_643f ; $6407
	script_facing_lock $00, $01 ; $6409
	script_move_target $00, $1200, $0d00 ; $6410
	script_wait_move $00 ; $641b
	script_facing_lock $00, $00 ; $6420
	script_face $00, $c0 ; $6427
	script_face $00, $c0 ; $642e
	script_face $08, $40 ; $6435
	jp PromptExhibitionMatch ; $643c
Label_0e_643f:
	ldh a, [hRomBank] ; $643f
	ld b, a ; $6441
	ld a, $02 ; $6442
	ld de, $7c6e ; $6444
	farcall FarPtr_ScriptSetActorScript ; $6447
	call MoveDoublesPartnerToPlayer ; $644a
	script_face $08, $40 ; $644d
	ldh a, [hRomBank] ; $6454
	ld b, a ; $6456
	ld a, $00 ; $6457
	ld de, $63da ; $6459
	farcall FarPtr_ScriptSetActorScript ; $645c
	script_wait_frames $14 ; $645f
	ldh a, [hRomBank] ; $6466
	ld b, a ; $6468
	ld a, $02 ; $6469
	ld de, $63e7 ; $646b
	farcall FarPtr_ScriptSetActorScript ; $646e
	ld a, $00 ; $6471
	farcall FarPtr_WaitActorScriptDone ; $6473
	ld a, $02 ; $6476
	farcall FarPtr_WaitActorScriptDone ; $6478
	jp PromptExhibitionMatch ; $647b
	INCBIN "data/bank_00e/d_647e.bin" ; $647e, 38 bytes
Func_0e_64a4:
	script_set_speed $00, $0018 ; $64a4
	script_set_speed $02, $0018 ; $64ac
	test_flag $05, 7 ; $64b4
	jr nz, Label_0e_64ea ; $64b7
	script_move_target $00, $1000, $0d00 ; $64b9
	script_wait_move $00 ; $64c4
	script_move_target $00, $1200, $0d00 ; $64c9
	script_wait_move $00 ; $64d4
	script_face $00, $c0 ; $64d9
	script_face $08, $40 ; $64e0
	jp PromptExhibitionMatch ; $64e7
Label_0e_64ea:
	ldh a, [hRomBank] ; $64ea
	ld b, a ; $64ec
	ld a, $02 ; $64ed
	ld de, $7c6e ; $64ef
	farcall FarPtr_ScriptSetActorScript ; $64f2
	call MoveDoublesPartnerToPlayer ; $64f5
	script_face $08, $40 ; $64f8
	ldh a, [hRomBank] ; $64ff
	ld b, a ; $6501
	ld a, $00 ; $6502
	ld de, $647e ; $6504
	farcall FarPtr_ScriptSetActorScript ; $6507
	script_wait_frames $14 ; $650a
	ldh a, [hRomBank] ; $6511
	ld b, a ; $6513
	ld a, $02 ; $6514
	ld de, $6491 ; $6516
	farcall FarPtr_ScriptSetActorScript ; $6519
	ld a, $00 ; $651c
	farcall FarPtr_WaitActorScriptDone ; $651e
	ld a, $02 ; $6521
	farcall FarPtr_WaitActorScriptDone ; $6523
	jp PromptExhibitionMatch ; $6526
	INCBIN "data/bank_00e/d_6529.bin" ; $6529, 38 bytes
Func_0e_654f:
	script_set_speed $00, $0018 ; $654f
	script_set_speed $02, $0018 ; $6557
	test_flag $05, 7 ; $655f
	jr nz, Label_0e_6595 ; $6562
	script_move_target $00, $1400, $0d00 ; $6564
	script_wait_move $00 ; $656f
	script_move_target $00, $1200, $0d00 ; $6574
	script_wait_move $00 ; $657f
	script_face $00, $c0 ; $6584
	script_face $08, $40 ; $658b
	jp PromptExhibitionMatch ; $6592
Label_0e_6595:
	ldh a, [hRomBank] ; $6595
	ld b, a ; $6597
	ld a, $02 ; $6598
	ld de, $7c6e ; $659a
	farcall FarPtr_ScriptSetActorScript ; $659d
	call MoveDoublesPartnerToPlayer ; $65a0
	script_face $08, $40 ; $65a3
	ldh a, [hRomBank] ; $65aa
	ld b, a ; $65ac
	ld a, $00 ; $65ad
	ld de, $6529 ; $65af
	farcall FarPtr_ScriptSetActorScript ; $65b2
	script_wait_frames $14 ; $65b5
	ldh a, [hRomBank] ; $65bc
	ld b, a ; $65be
	ld a, $02 ; $65bf
	ld de, $653c ; $65c1
	farcall FarPtr_ScriptSetActorScript ; $65c4
	ld a, $00 ; $65c7
	farcall FarPtr_WaitActorScriptDone ; $65c9
	ld a, $02 ; $65cc
	farcall FarPtr_WaitActorScriptDone ; $65ce
	jp PromptExhibitionMatch ; $65d1
PromptExhibitionMatch:
	farcall FarPtr_BeginCutsceneScriptMode ; $65d4
	script_player_speed $0018 ; $65d7
	script_move_player $1200, $0d00 ; $65dd
	farcall FarPtr_WaitPlayerMoveDone ; $65e7
	ld a, $02 ; $65ea
	ld [wWaterSpriteMinigameTimer], a ; $65ec
	ld hl, $c2b2 ; $65ef
	ld de, $3083 ; $65f2
	ld a, e ; $65f5
	ld [hl+], a ; $65f6
	ld [hl], d ; $65f7
	test_flag $05, 7 ; $65f8
	jr z, Label_0e_660b ; $65fb
	ld a, $05 ; $65fd
	ld [wWaterSpriteMinigameTimer], a ; $65ff
	ld hl, $c2b2 ; $6602
	ld de, $3089 ; $6605
	ld a, e ; $6608
	ld [hl+], a ; $6609
	ld [hl], d ; $660a
Label_0e_660b:
	ld hl, $c2b2 ; $660b
	ld a, [hl+] ; $660e
	ld h, [hl] ; $660f
	ld l, a ; $6610
	farcall FarPtr_InitDialogueTextCursor ; $6611
	ld a, $08 ; $6614
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6616
	farcall FarPtr_RunDialogueYesNoPrompt ; $6619
	farcall FarPtr_ScriptCloseDialogueWindow ; $661c
	script_wait_frames $05 ; $661f
	and a, a ; $6626
	jr z, Label_0e_6644 ; $6627
	script_speak $08 ; $6629
	test_flag $05, 7 ; $662e
	jr z, Label_0e_6640 ; $6631
	ld a, $02 ; $6633
	farcall FarPtr_GetActorStateAddr ; $6635
	ld c, l ; $6638
	ld b, h ; $6639
	ld de, $d000 ; $663a
	farcall FarPtr_04_20 ; $663d
Label_0e_6640:
	farcall FarPtr_EndCutsceneScriptMode ; $6640
	ret ; $6643
Label_0e_6644:
	ld a, [$c2b0] ; $6644
	and a, $01 ; $6647
	jr z, Label_0e_666e ; $6649
	farcall FarPtr_AdvanceDialogueTextCursor ; $664b
	script_speak $08 ; $664e
	ld hl, $3088 ; $6653
	ld de, $0101 ; $6656
	ld a, $01 ; $6659
	farcall FarPtr_RunPagedTextMenu ; $665b
	cp a, $ff ; $665e
	jp z, Label_0e_660b ; $6660
	inc a ; $6663
	test_flag $05, 7 ; $6664
	jr z, Label_0e_666b ; $6667
	add a, $03 ; $6669
Label_0e_666b:
	ld [wWaterSpriteMinigameTimer], a ; $666b
Label_0e_666e:
	ld hl, $c2b2 ; $666e
	ld a, [hl+] ; $6671
	ld h, [hl] ; $6672
	ld l, a ; $6673
	ld a, $03 ; $6674
	add a, l ; $6676
	ld l, a ; $6677
	jr nc, Label_0e_667b ; $6678
	inc h ; $667a
Label_0e_667b:
	farcall FarPtr_InitDialogueTextCursor ; $667b
	script_speak $08 ; $667e
	script_face $0b, $c0 ; $6683
	script_wait_frames $04 ; $668a
	script_face $0f, $c0 ; $6691
	script_wait_frames $04 ; $6698
	script_face $10, $c0 ; $669f
	script_wait_frames $04 ; $66a6
	script_face $0a, $c0 ; $66ad
	script_wait_frames $04 ; $66b4
	script_face $09, $c0 ; $66bb
	script_wait_frames $04 ; $66c2
	script_face $0e, $c0 ; $66c9
	script_wait_frames $0a ; $66d0
	script_set_anim $0f, $03 ; $66d7
	script_set_anim $10, $03 ; $66de
	script_set_anim $0e, $03 ; $66e5
	script_set_anim $11, $03 ; $66ec
	script_set_anim $12, $03 ; $66f3
	script_set_anim $0b, $03 ; $66fa
	script_set_anim $0a, $03 ; $6701
	script_set_anim $09, $03 ; $6708
	script_set_anim $0c, $03 ; $670f
	script_set_anim $13, $03 ; $6716
	script_wait_idle $13 ; $671d
	script_player_speed $0018 ; $6722
	script_move_player $1500, $0d00 ; $6728
	script_set_speed $08, $0020 ; $6732
	script_set_speed $0f, $0020 ; $673a
	script_set_speed $10, $0020 ; $6742
	script_set_speed $0e, $0020 ; $674a
	script_set_speed $11, $0020 ; $6752
	script_set_speed $12, $0020 ; $675a
	script_set_speed $0b, $0020 ; $6762
	script_set_speed $0a, $0020 ; $676a
	script_set_speed $09, $0020 ; $6772
	script_set_speed $0d, $0020 ; $677a
	script_set_speed $0c, $0020 ; $6782
	script_set_speed $13, $0020 ; $678a
	script_set_speed $00, $0020 ; $6792
	script_face $12, $00 ; $679a
	script_wait_frames $0a ; $67a1
	script_face $08, $00 ; $67a8
	script_wait_frames $0a ; $67af
	script_face $11, $00 ; $67b6
	script_wait_frames $14 ; $67bd
	ldh a, [hRomBank] ; $67c4
	ld b, a ; $67c6
	ld a, $12 ; $67c7
	ld de, $552d ; $67c9
	farcall FarPtr_ScriptSetActorScript ; $67cc
	script_wait_frames $14 ; $67cf
	ldh a, [hRomBank] ; $67d6
	ld b, a ; $67d8
	ld a, $08 ; $67d9
	ld de, $552d ; $67db
	farcall FarPtr_ScriptSetActorScript ; $67de
	script_wait_frames $14 ; $67e1
	ldh a, [hRomBank] ; $67e8
	ld b, a ; $67ea
	ld a, $11 ; $67eb
	ld de, $552d ; $67ed
	farcall FarPtr_ScriptSetActorScript ; $67f0
	script_wait_frames $64 ; $67f3
	test_flag $05, 7 ; $67fa
	jr nz, Label_0e_680c ; $67fd
	script_move_target $00, $1200, $0900 ; $67ff
	jr Label_0e_682a ; $680a
Label_0e_680c:
	script_set_speed $02, $0020 ; $680c
	script_move_target $00, $1100, $0900 ; $6814
	script_move_target $02, $1300, $0900 ; $681f
Label_0e_682a:
	ldh a, [hRomBank] ; $682a
	ld b, a ; $682c
	ld a, $0b ; $682d
	ld de, $552d ; $682f
	farcall FarPtr_ScriptSetActorScript ; $6832
	ldh a, [hRomBank] ; $6835
	ld b, a ; $6837
	ld a, $0a ; $6838
	ld de, $552d ; $683a
	farcall FarPtr_ScriptSetActorScript ; $683d
	ldh a, [hRomBank] ; $6840
	ld b, a ; $6842
	ld a, $09 ; $6843
	ld de, $552d ; $6845
	farcall FarPtr_ScriptSetActorScript ; $6848
	ldh a, [hRomBank] ; $684b
	ld b, a ; $684d
	ld a, $0c ; $684e
	ld de, $552d ; $6850
	farcall FarPtr_ScriptSetActorScript ; $6853
	ldh a, [hRomBank] ; $6856
	ld b, a ; $6858
	ld a, $0d ; $6859
	ld de, $552d ; $685b
	farcall FarPtr_ScriptSetActorScript ; $685e
	script_wait_frames $1e ; $6861
	script_face $00, $40 ; $6868
	test_flag $05, 7 ; $686f
	jr z, Label_0e_687b ; $6872
	script_face $02, $40 ; $6874
Label_0e_687b:
	ldh a, [hRomBank] ; $687b
	ld b, a ; $687d
	ld a, $0f ; $687e
	ld de, $552d ; $6880
	farcall FarPtr_ScriptSetActorScript ; $6883
	script_wait_frames $28 ; $6886
	ldh a, [hRomBank] ; $688d
	ld b, a ; $688f
	ld a, $10 ; $6890
	ld de, $552d ; $6892
	farcall FarPtr_ScriptSetActorScript ; $6895
	script_wait_frames $14 ; $6898
	ldh a, [hRomBank] ; $689f
	ld b, a ; $68a1
	ld a, $0e ; $68a2
	ld de, $552d ; $68a4
	farcall FarPtr_ScriptSetActorScript ; $68a7
	ld a, $0e ; $68aa
	farcall FarPtr_WaitActorScriptDone ; $68ac
	script_move_player $1200, $0d00 ; $68af
	test_flag $05, 7 ; $68b9
	jr nz, Label_0e_68cb ; $68bc
	script_move_target $00, $1200, $0b00 ; $68be
	jr Label_0e_68e1 ; $68c9
Label_0e_68cb:
	script_move_target $00, $1100, $0b00 ; $68cb
	script_move_target $02, $1300, $0b00 ; $68d6
Label_0e_68e1:
	script_move_target $13, $1200, $0d00 ; $68e1
	script_wait_move $13 ; $68ec
	script_face $13, $c0 ; $68f1
	script_wait_frames $14 ; $68f8
	script_speak $13 ; $68ff
	script_wait_frames $0a ; $6904
	script_set_anim $00, $03 ; $690b
	test_flag $05, 7 ; $6912
	jr z, Label_0e_691e ; $6915
	script_set_anim $02, $03 ; $6917
Label_0e_691e:
	script_wait_idle $00 ; $691e
	script_wait_frames $14 ; $6923
	ldh a, [hRomBank] ; $692a
	ld b, a ; $692c
	ld a, $13 ; $692d
	ld de, $5545 ; $692f
	farcall FarPtr_ScriptSetActorScript ; $6932
	script_wait_frames $14 ; $6935
	ldh a, [hRomBank] ; $693c
	ld b, a ; $693e
	ld a, $00 ; $693f
	ld de, $5545 ; $6941
	farcall FarPtr_ScriptSetActorScript ; $6944
	test_flag $05, 7 ; $6947
	jr z, Label_0e_695e ; $694a
	script_wait_frames $28 ; $694c
	ldh a, [hRomBank] ; $6953
	ld b, a ; $6955
	ld a, $02 ; $6956
	ld de, $5545 ; $6958
	farcall FarPtr_ScriptSetActorScript ; $695b
Label_0e_695e:
	script_move_player $1500, $0d00 ; $695e
	ld a, $00 ; $6968
	farcall FarPtr_WaitActorScriptDone ; $696a
	call Func_0e_7150 ; $696d
	ld a, $1c ; $6970
	ld [wStoryModeCurrentLocation], a ; $6972
	ld a, [wWaterSpriteMinigameTimer] ; $6975
	ld [wStoryModeEntryPoint], a ; $6978
	ld a, $ff ; $697b
	ld [$c294], a ; $697d
	ld [wStoryModeExitLocationRequest], a ; $6980
	farcall FarPtr_EndCutsceneScriptMode ; $6983
	ret ; $6986
MoveDoublesPartnerToPlayer:
	wram_bank $04 ; $6987
	ld a, $00 ; $698d
	farcall FarPtr_GetActorStateAddr ; $698f
	ld c, l ; $6992
	ld b, h ; $6993
	ld hl, $000e ; $6994
	add hl, bc ; $6997
	ld a, [hl+] ; $6998
	ld d, [hl] ; $6999
	ld e, a ; $699a
	ld hl, $000c ; $699b
	add hl, bc ; $699e
	ld a, [hl+] ; $699f
	ld b, [hl] ; $69a0
	ld c, a ; $69a1
	ld a, $02 ; $69a2
	farcall FarPtr_ScriptSetActorMoveTarget ; $69a4
	script_wait_move $02 ; $69a7
	ret ; $69ac
Label_0e_69ad:
	test_flag $05, 7 ; $69ad
	jp nz, Label_0e_69c5 ; $69b0
Label_0e_69b3:
	test_flag $16, 2 ; $69b3
	ret z ; $69b6
	script_set_position $00, $1200, $0f00 ; $69b7
	jp Label_0e_69fb ; $69c2
Label_0e_69c5:
	test_flag $16, 3 ; $69c5
	ret z ; $69c8
	farcall FarPtr_BeginCutsceneScriptMode ; $69c9
	script_player_speed $0010 ; $69cc
	script_move_player $1100, $0f00 ; $69d2
	farcall FarPtr_WaitPlayerMoveDone ; $69dc
	script_set_position $00, $1100, $0f00 ; $69df
	script_set_position $02, $1300, $0f00 ; $69ea
	farcall FarPtr_EndCutsceneScriptMode ; $69f5
	jp Label_0e_69fb ; $69f8
Label_0e_69fb:
	script_set_position $08, $1200, $0b00 ; $69fb
	script_face $10, $00 ; $6a06
	script_face $0f, $00 ; $6a0d
	script_face $0d, $00 ; $6a14
	script_face $0e, $00 ; $6a1b
	script_face $0b, $80 ; $6a22
	script_face $0a, $80 ; $6a29
	script_face $09, $80 ; $6a30
	script_face $0c, $80 ; $6a37
	script_set_position $13, $0d00, $1300 ; $6a3e
	script_face $13, $00 ; $6a49
	ret ; $6a50
Func_0e_6a51:
	script_player_speed $0020 ; $6a51
	script_move_player $1200, $0f00 ; $6a57
	farcall FarPtr_WaitPlayerMoveDone ; $6a61
	script_wait_frames $28 ; $6a64
	script_player_speed $0040 ; $6a6b
	script_move_player $1200, $1900 ; $6a71
	farcall FarPtr_WaitPlayerMoveDone ; $6a7b
	sound $97 ; $6a7e
	script_set_position $03, $1000, $1d00 ; $6a80
	script_wait_frames $0a ; $6a8b
	ld a, $13 ; $6a92
	ld de, $ff80 ; $6a94
	farcall FarPtr_ScriptSetActorJumpVelocity ; $6a97
	ld a, $03 ; $6a9a
	ld de, $ff80 ; $6a9c
	farcall FarPtr_ScriptSetActorJumpVelocity ; $6a9f
	script_wait_frames $1e ; $6aa2
	script_set_position $03, $3f00, $3f00 ; $6aa9
	script_set_speed $13, $0040 ; $6ab4
	ld a, $13 ; $6abc
	ld bc, $0300 ; $6abe
	ld de, rJOYP ; $6ac1
	farcall FarPtr_MoveActorByDelta ; $6ac4
	script_wait_move $13 ; $6ac7
	script_face $13, $40 ; $6acc
	ret ; $6ad3
Func_0e_6ad4:
	script_wait_frames $0a ; $6ad4
	script_face $08, $40 ; $6adb
	script_wait_frames $04 ; $6ae2
	script_face $10, $00 ; $6ae9
	script_wait_frames $04 ; $6af0
	script_face $0f, $00 ; $6af7
	script_wait_frames $04 ; $6afe
	script_face $0d, $00 ; $6b05
	script_wait_frames $04 ; $6b0c
	script_face $0e, $00 ; $6b13
	script_wait_frames $04 ; $6b1a
	script_face $0b, $80 ; $6b21
	script_wait_frames $04 ; $6b28
	script_face $0a, $80 ; $6b2f
	script_wait_frames $04 ; $6b36
	script_face $09, $80 ; $6b3d
	script_wait_frames $04 ; $6b44
	script_face $13, $c0 ; $6b4b
	script_wait_frames $04 ; $6b52
	script_face $0c, $c0 ; $6b59
	script_wait_frames $14 ; $6b60
	script_set_anim $08, $03 ; $6b67
	script_wait_idle $08 ; $6b6e
	script_speak $08 ; $6b73
	script_wait_frames $14 ; $6b78
	script_set_anim $11, $03 ; $6b7f
	script_wait_idle $11 ; $6b86
	script_speak $11 ; $6b8b
	script_face $08, $80 ; $6b90
	script_wait_frames $0a ; $6b97
	script_face $11, $00 ; $6b9e
	script_wait_frames $14 ; $6ba5
	script_set_anim $11, $03 ; $6bac
	script_set_anim $08, $03 ; $6bb3
	script_wait_idle $08 ; $6bba
	script_wait_frames $0a ; $6bbf
	script_face $08, $40 ; $6bc6
	script_wait_frames $0a ; $6bcd
	script_face $11, $40 ; $6bd4
	script_wait_frames $1e ; $6bdb
	script_speak $08 ; $6be2
	script_face $08, $00 ; $6be7
	script_wait_frames $0a ; $6bee
	script_face $12, $80 ; $6bf5
	script_wait_frames $14 ; $6bfc
	script_set_anim $12, $03 ; $6c03
	script_set_anim $08, $03 ; $6c0a
	script_wait_idle $08 ; $6c11
	script_wait_frames $0a ; $6c16
	script_face $08, $40 ; $6c1d
	script_wait_frames $0a ; $6c24
	script_face $12, $40 ; $6c2b
	script_wait_frames $1e ; $6c32
	script_speak $08 ; $6c39
	script_wait_frames $14 ; $6c3e
	ld a, $10 ; $6c45
	ld de, $ff80 ; $6c47
	farcall FarPtr_ScriptSetActorJumpVelocity ; $6c4a
	script_wait_frames $14 ; $6c4d
	script_face $10, $c0 ; $6c54
	script_set_anim $10, $02 ; $6c5b
	script_wait_idle $10 ; $6c62
	script_speak $10 ; $6c67
	script_wait_frames $0a ; $6c6c
	ld a, $0e ; $6c73
	ld de, rLCDC ; $6c75
	farcall FarPtr_ScriptSetActorJumpVelocity ; $6c78
	script_wait_frames $28 ; $6c7b
	script_face $0e, $c0 ; $6c82
	script_set_anim $0e, $02 ; $6c89
	script_wait_idle $0e ; $6c90
	script_speak $0e ; $6c95
	script_wait_frames $14 ; $6c9a
	sound $96 ; $6ca1
	script_set_position $04, $0f00, $0900 ; $6ca3
	script_wait_frames $04 ; $6cae
	sound $96 ; $6cb5
	script_set_position $05, $1300, $0700 ; $6cb7
	script_wait_frames $04 ; $6cc2
	sound $96 ; $6cc9
	script_set_position $06, $1700, $0900 ; $6ccb
	script_wait_frames $28 ; $6cd6
	script_face $08, $80 ; $6cdd
	script_wait_frames $0a ; $6ce4
	script_face $11, $00 ; $6ceb
	script_wait_frames $28 ; $6cf2
	script_face $08, $00 ; $6cf9
	script_wait_frames $0a ; $6d00
	script_face $12, $80 ; $6d07
	script_wait_frames $3c ; $6d0e
	script_move_target $0f, $0e00, $0f00 ; $6d15
	script_wait_move $0f ; $6d20
	script_face $0f, $c0 ; $6d25
	script_wait_frames $04 ; $6d2c
	script_face $11, $40 ; $6d33
	script_wait_frames $04 ; $6d3a
	script_face $08, $40 ; $6d41
	script_wait_frames $04 ; $6d48
	script_face $12, $40 ; $6d4f
	script_wait_frames $14 ; $6d56
	script_set_position $04, $3f00, $3f00 ; $6d5d
	script_set_position $05, $3f00, $3f00 ; $6d68
	script_set_position $06, $3f00, $3f00 ; $6d73
	script_speak $0f ; $6d7e
	script_wait_frames $0a ; $6d83
	script_set_anim $0f, $04 ; $6d8a
	script_wait_idle $0f ; $6d91
	script_face $0f, $00 ; $6d96
	sound $99 ; $6d9d
	script_set_position $07, $0f00, $0d00 ; $6d9f
	script_wait_frames $14 ; $6daa
	script_speak $0f ; $6db1
	ret ; $6db6
Func_0e_6db7:
	ld a, $0b ; $6db7
	ld de, $ff80 ; $6db9
	farcall FarPtr_ScriptSetActorJumpVelocity ; $6dbc
	script_wait_frames $14 ; $6dbf
	script_speak $0b ; $6dc6
	script_set_position $04, $3f00, $3f00 ; $6dcb
	script_set_position $05, $3f00, $3f00 ; $6dd6
	script_set_position $06, $3f00, $3f00 ; $6de1
	script_wait_frames $0a ; $6dec
	script_face $0f, $00 ; $6df3
	script_wait_frames $04 ; $6dfa
	script_face $10, $00 ; $6e01
	script_wait_frames $04 ; $6e08
	script_face $0e, $00 ; $6e0f
	script_wait_frames $04 ; $6e16
	script_face $08, $00 ; $6e1d
	script_face $0a, $c0 ; $6e24
	script_wait_frames $04 ; $6e2b
	script_face $11, $00 ; $6e32
	script_face $09, $c0 ; $6e39
	script_set_speed $0b, $0020 ; $6e40
	script_move_target $0b, $1600, $0d00 ; $6e48
	script_wait_move $0b ; $6e53
	script_wait_frames $0a ; $6e58
	script_speak $0b ; $6e5f
	script_wait_frames $0a ; $6e64
	script_face $0f, $00 ; $6e6b
	sound $99 ; $6e72
	script_set_position $07, $1200, $0b00 ; $6e74
	script_wait_frames $0a ; $6e7f
	script_set_anim $0f, $02 ; $6e86
	script_wait_idle $0f ; $6e8d
	script_wait_frames $0a ; $6e92
	script_speak $0f ; $6e99
	script_face $10, $00 ; $6e9e
	script_face $0e, $00 ; $6ea5
	script_set_position $07, $3f00, $3f00 ; $6eac
	script_move_target $0f, $1300, $0d00 ; $6eb7
	script_wait_move $0f ; $6ec2
	script_wait_frames $0a ; $6ec7
	script_face $0a, $80 ; $6ece
	script_move_target $10, $1100, $0d00 ; $6ed5
	script_wait_frames $0a ; $6ee0
	script_face $09, $80 ; $6ee7
	script_move_target $0e, $1300, $0f00 ; $6eee
	script_wait_move $0e ; $6ef9
	script_wait_frames $0a ; $6efe
	script_facing_lock $0b, $01 ; $6f05
	script_move_target $0b, $1800, $0d00 ; $6f0c
	script_wait_move $0b ; $6f17
	script_face $0b, $80 ; $6f1c
	script_facing_lock $0b, $00 ; $6f23
	ret ; $6f2a
Func_0e_6f2b:
	script_face $10, $c0 ; $6f2b
	script_wait_frames $0a ; $6f32
	script_speak $10 ; $6f39
	script_wait_frames $0a ; $6f3e
	script_face $0f, $40 ; $6f45
	script_wait_frames $0a ; $6f4c
	script_face $0e, $c0 ; $6f53
	script_wait_frames $28 ; $6f5a
	script_set_anim $0f, $03 ; $6f61
	script_set_anim $0e, $03 ; $6f68
	script_wait_idle $0e ; $6f6f
	script_wait_frames $0a ; $6f74
	script_face $0f, $c0 ; $6f7b
	script_wait_frames $04 ; $6f82
	script_face $0e, $c0 ; $6f89
	script_wait_frames $0a ; $6f90
	ld a, $0e ; $6f97
	ld de, rLCDC ; $6f99
	farcall FarPtr_ScriptSetActorJumpVelocity ; $6f9c
	script_wait_frames $28 ; $6f9f
	script_speak $0e ; $6fa6
	script_wait_frames $0a ; $6fab
	sound $96 ; $6fb2
	script_set_position $04, $1300, $0900 ; $6fb4
	script_set_position $05, $1700, $0900 ; $6fbf
	script_wait_frames $14 ; $6fca
	script_face $08, $00 ; $6fd1
	script_wait_frames $0a ; $6fd8
	script_face $12, $80 ; $6fdf
	script_wait_frames $14 ; $6fe6
	script_set_position $04, $3f00, $3f00 ; $6fed
	script_set_position $05, $3f00, $3f00 ; $6ff8
	script_wait_frames $14 ; $7003
	script_set_anim $08, $03 ; $700a
	script_set_anim $12, $03 ; $7011
	script_wait_idle $12 ; $7018
	script_wait_frames $0a ; $701d
	script_face $08, $40 ; $7024
	script_wait_frames $0a ; $702b
	script_face $12, $40 ; $7032
	script_speak $08 ; $7039
	script_wait_frames $14 ; $703e
	script_set_anim $0f, $03 ; $7045
	script_set_anim $10, $03 ; $704c
	script_set_anim $0e, $03 ; $7053
	script_wait_idle $0e ; $705a
	script_wait_frames $14 ; $705f
	ld a, $10 ; $7066
	ld de, $ff80 ; $7068
	farcall FarPtr_ScriptSetActorJumpVelocity ; $706b
	script_wait_frames $28 ; $706e
	script_speak $10 ; $7075
	script_wait_frames $0a ; $707a
	ret ; $7081
ExhibitionDeclinedCutscene:
	script_wait_frames $0a ; $7082
	sound $99 ; $7089
	script_set_position $07, $1400, $0d00 ; $708b
	script_wait_frames $28 ; $7096
	script_speak $0f ; $709d
	script_wait_frames $14 ; $70a2
	script_set_position $07, $3f00, $3f00 ; $70a9
	script_set_anim $08, $02 ; $70b4
	script_wait_idle $08 ; $70bb
	script_speak $08 ; $70c0
	script_wait_frames $0a ; $70c5
	script_set_anim $08, $03 ; $70cc
	script_wait_idle $08 ; $70d3
	script_wait_frames $0a ; $70d8
	script_speak $08 ; $70df
	ld a, $0f ; $70e4
	ld de, $ff80 ; $70e6
	farcall FarPtr_ScriptSetActorJumpVelocity ; $70e9
	script_wait_frames $14 ; $70ec
	sound $70 ; $70f3
	ld a, $04 ; $70f5
	farcall FarPtr_SetScreenShake ; $70f7
	script_wait_frames $0a ; $70fa
	ld a, $00 ; $7101
	farcall FarPtr_SetScreenShake ; $7103
	script_wait_frames $1e ; $7106
	script_move_target $10, $0c00, $0d00 ; $710d
	script_move_target $0e, $0c00, $1100 ; $7118
	script_wait_frames $14 ; $7123
	script_move_target $0f, $0c00, $0f00 ; $712a
	script_wait_move $0f ; $7135
	script_face $10, $00 ; $713a
	script_face $0e, $00 ; $7141
	script_face $0f, $00 ; $7148
	ret ; $714f
Func_0e_7150:
	ldh a, [hWramBank] ; $7150
	push af ; $7152
	ld hl, $72ce ; $7153
	ld de, $0901 ; $7156
	call LoadPaletteShadow ; $7159
	ld hl, $72e0 ; $715c
	ld de, $a000 ; $715f
	ld c, $18 ; $7162
	call QueueVRAMCopy ; $7164
	ld hl, $7460 ; $7167
	ld de, $a180 ; $716a
	ld c, $02 ; $716d
	call QueueVRAMCopy ; $716f
	wram_bank $06 ; $7172
	xor a, a ; $7178
	ld hl, $d000 ; $7179
	ld [hl+], a ; $717c
	ld [hl+], a ; $717d
	ld a, $5a ; $717e
	ld [hl+], a ; $7180
	xor a, a ; $7181
	ld [hl+], a ; $7182
	ld [hl+], a ; $7183
	ld [hl+], a ; $7184
	ld [hl+], a ; $7185
	ld [hl+], a ; $7186
	ld [hl+], a ; $7187
	ld [hl+], a ; $7188
	ld [hl+], a ; $7189
	ld [hl+], a ; $718a
	ld [hl+], a ; $718b
	ld [hl+], a ; $718c
	ld [hl+], a ; $718d
	ld [hl+], a ; $718e
	ld [hl+], a ; $718f
	ld [hl+], a ; $7190
	ld [hl+], a ; $7191
	ld b, $00 ; $7192
	ld c, $2b ; $7194
	ld d, $1a ; $7196
	ld e, $0c ; $7198
	ld h, $04 ; $719a
	ld l, $02 ; $719c
	farcall FarPtr_CopySceneTilemapRect ; $719e
	ld b, $04 ; $71a1
	ld c, $2d ; $71a3
	ld d, $14 ; $71a5
	ld e, $14 ; $71a7
	ld h, $06 ; $71a9
	ld l, $02 ; $71ab
	farcall FarPtr_CopySceneTilemapRect ; $71ad
	ld b, $0a ; $71b0
	ld c, $2b ; $71b2
	ld d, $1a ; $71b4
	ld e, $12 ; $71b6
	ld h, $06 ; $71b8
	ld l, $02 ; $71ba
	farcall FarPtr_CopySceneTilemapRect ; $71bc
	sound $09 ; $71bf
	ld a, $01 ; $71c1
	ld hl, $71e9 ; $71c3
	call RegisterFrameTask ; $71c6
	wram_bank $06 ; $71c9
Label_0e_71cf:
	call AdvanceFrame ; $71cf
	ld a, [$d002] ; $71d2
	cp a, $1e ; $71d5
	jr z, Label_0e_71e2 ; $71d7
	or a, a ; $71d9
	jr nz, Label_0e_71cf ; $71da
	pop af ; $71dc
	wram_bank ; $71dd
	ret ; $71e1
Label_0e_71e2:
	ld c, $03 ; $71e2
	call BeginFadeOut ; $71e4
	jr Label_0e_71cf ; $71e7
	INCBIN "data/bank_00e/d_71e9.bin" ; $71e9, 1037 bytes
SpecialCourtMapScripts_0e:
	; $75f6, 14 bytes (map_tree)
	dw SpecialCourtEntryPoints_0e ; slot 0 EntryPoints
	dw SpecialCourtExitTriggers_0e ; slot 1 ExitTriggers
	dw SpecialCourtActors_0e ; slot 2 Actors
	dw SpecialCourtNpcScripts_0e ; slot 3 NpcScripts
	dw SpecialCourtFacingScripts_0e ; slot 4 FacingScripts
	dw SpecialCourtTileTriggers_0e ; slot 5 TileTriggers
	dw SpecialCourtInitScript_0e ; slot 6 InitScript
SpecialCourtActors_0e:
	; $7604, 206 bytes (map_actors)
	map_actor $0000, $7c6e, $0f00, $0500, $40, $2e, $01, $00
	map_actor $0000, $7c6e, $1700, $0d00, $80, $6d, $01, $00
	map_actor $0000, $7c6e, $1700, $0f00, $80, $6f, $01, $00
	map_actor $0000, $7c6e, $1700, $1100, $80, $2c, $01, $00
	map_actor $0000, $7c6e, $1700, $1900, $80, $6e, $01, $00
	map_actor $0000, $7c6e, $0480, $0f00, $00, $73, $01, $00
	map_actor $0000, $7c6e, $0500, $1100, $00, $2d, $01, $00
	map_actor $0000, $7c6e, $0500, $1900, $00, $48, $01, $00
	map_actor $0000, $7c6e, $0500, $1b00, $00, $2b, $01, $00
	map_actor $0000, $7c6e, $0d00, $0500, $40, $72, $01, $00
	map_actor $0000, $7c6e, $0d00, $1700, $40, $2a, $01, $00
	map_actor $0000, $7c6e, $0500, $1f00, $c0, $70, $01, $00
	map_actor $0000, $7c6e, $0500, $0d00, $00, $71, $01, $00
	map_actor $0000, $7c6e, $1700, $1b00, $80, $71, $01, $00
	map_actor_end
SpecialCourtEntryPoints_0e:
	; $76d2, 9 bytes (map_entries)
	map_entry $01, $c0, $0500, $2100, $0000
	db $ff
SpecialCourtExitTriggers_0e:
	; $76db, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_0e, $08, $06
	db $ff
SpecialCourtNpcScripts_0e:
	ds 1, $ff ; $76e4, fill
SpecialCourtFacingScripts_0e:
	ds 1, $ff ; $76e5, fill
SpecialCourtTileTriggers_0e:
	ds 1, $ff ; $76e6, fill
SpecialCourtInitScript_0e:
	ld a, [wStoryModeEntryPoint] ; $76e7
	cp a, $07 ; $76ea
	jr c, Label_0e_76f7 ; $76ec
	cp a, $0a ; $76ee
	jr z, Label_0e_76f3 ; $76f0
	ret ; $76f2
Label_0e_76f3:
	call HandleExhibitionMatchResult ; $76f3
	ret ; $76f6
Label_0e_76f7:
	call ExhibitionMatchIntroCutscene ; $76f7
	ret ; $76fa
ExhibitionMatchIntroCutscene:
	xor a, a ; $76fb
	ld [wStoryModeShowLocationName], a ; $76fc
	ld a, [wStoryModeEntryPoint] ; $76ff
	dec a ; $7702
	ld [wWaterSpriteMinigameTimer], a ; $7703
	test_flag $05, 7 ; $7706
	jp nz, Label_0e_7927 ; $7709
	script_set_speed $0e, $0014 ; $770c
	script_set_speed $00, $0014 ; $7714
	script_set_position $0e, $0500, $2300 ; $771c
	script_set_position $00, $0500, $2500 ; $7727
	script_set_position $02, $0500, $2500 ; $7732
	script_move_target $0e, $0500, $1f00 ; $773d
	script_move_target $00, $0500, $2100 ; $7748
	script_move_target $02, $0500, $2300 ; $7753
	script_player_speed $0014 ; $775e
	script_move_player $0e00, $1b00 ; $7764
	ld c, $04 ; $776e
	call BeginFadeIn ; $7770
	call WaitFadeEnd ; $7773
	script_wait_move $0e ; $7776
	ldh a, [hRomBank] ; $777b
	ld b, a ; $777d
	ld a, $0e ; $777e
	ld de, $7b11 ; $7780
	farcall FarPtr_ScriptSetActorScript ; $7783
	script_move_target $00, $0500, $1f00 ; $7786
	script_wait_move $00 ; $7791
	ldh a, [hRomBank] ; $7796
	ld b, a ; $7798
	ld a, $00 ; $7799
	ld de, $7b11 ; $779b
	farcall FarPtr_ScriptSetActorScript ; $779e
	script_wait_frames $5a ; $77a1
	script_move_player $0e00, $1700 ; $77a8
	ld a, $0e ; $77b2
	farcall FarPtr_WaitActorScriptDone ; $77b4
	script_set_speed $0e, $0020 ; $77b7
	ldh a, [hRomBank] ; $77bf
	ld b, a ; $77c1
	ld a, $0e ; $77c2
	ld de, $7b24 ; $77c4
	farcall FarPtr_ScriptSetActorScript ; $77c7
	ld a, $0e ; $77ca
	farcall FarPtr_WaitActorScriptDone ; $77cc
	script_wait_frames $3c ; $77cf
	script_set_anim $0d, $03 ; $77d6
	script_set_anim $00, $03 ; $77dd
	script_wait_idle $00 ; $77e4
	script_wait_frames $14 ; $77e9
	test_flag $0d, 6 ; $77f0
	jr z, Label_0e_77fe ; $77f3
	ld a, $01 ; $77f5
	ld [$c294], a ; $77f7
	ld [wStoryModeExitLocationRequest], a ; $77fa
	ret ; $77fd
Label_0e_77fe:
	script_move_target $00, $0f00, $1a00 ; $77fe
	script_wait_move $00 ; $7809
	script_move_target $00, $0f00, $1700 ; $780e
	script_wait_move $00 ; $7819
	script_face $0d, $c0 ; $781e
	script_wait_frames $14 ; $7825
	script_player_speed $0020 ; $782c
	script_move_player $0e00, $0900 ; $7832
	farcall FarPtr_WaitPlayerMoveDone ; $783c
	script_wait_frames $14 ; $783f
	script_set_speed $03, $0014 ; $7846
	script_move_target $03, $0f00, $0700 ; $784e
	script_wait_move $03 ; $7859
	script_set_anim $03, $03 ; $785e
	script_wait_idle $03 ; $7865
	script_set_text $30a9 ; $786a
	script_speak $03 ; $7870
	script_player_speed $0040 ; $7875
	script_move_player $0e00, $1400 ; $787b
	farcall FarPtr_WaitPlayerMoveDone ; $7885
	script_wait_frames $14 ; $7888
	script_face $0d, $00 ; $788f
	script_face $00, $80 ; $7896
	script_wait_frames $28 ; $789d
	script_set_anim $0d, $03 ; $78a4
	script_set_anim $00, $03 ; $78ab
	script_wait_idle $00 ; $78b2
	script_wait_frames $14 ; $78b7
	script_set_speed $00, $0020 ; $78be
	script_set_speed $0d, $0020 ; $78c6
	script_move_target $00, $0f00, $1d00 ; $78ce
	script_move_target $0d, $0900, $1700 ; $78d9
	script_wait_move $0d ; $78e4
	script_move_target $0d, $0900, $0d00 ; $78e9
	script_wait_move $00 ; $78f4
	script_face $00, $c0 ; $78f9
	script_wait_move $0d ; $7900
	script_move_target $0d, $0d00, $0d00 ; $7905
	script_wait_move $0d ; $7910
	script_face $0d, $40 ; $7915
	script_wait_frames $28 ; $791c
	call PrepareStoryMatch ; $7923
	ret ; $7926
Label_0e_7927:
	script_set_speed $0e, $0014 ; $7927
	script_set_speed $00, $0014 ; $792f
	script_set_speed $02, $0014 ; $7937
	script_set_position $03, $0f00, $1700 ; $793f
	ld a, $02 ; $794a
	farcall FarPtr_SetActorNullScript ; $794c
	script_set_position $0e, $0500, $2300 ; $794f
	script_set_position $00, $0500, $2500 ; $795a
	script_set_position $02, $0500, $2500 ; $7965
	script_move_target $0e, $0500, $1f00 ; $7970
	script_move_target $00, $0500, $2100 ; $797b
	script_move_target $02, $0500, $2300 ; $7986
	script_player_speed $0014 ; $7991
	script_move_player $0e00, $1b00 ; $7997
	ld c, $04 ; $79a1
	call BeginFadeIn ; $79a3
	call WaitFadeEnd ; $79a6
	script_wait_move $0e ; $79a9
	ldh a, [hRomBank] ; $79ae
	ld b, a ; $79b0
	ld a, $0e ; $79b1
	ld de, $7b11 ; $79b3
	farcall FarPtr_ScriptSetActorScript ; $79b6
	script_move_target $00, $0500, $1f00 ; $79b9
	script_move_target $02, $0500, $2100 ; $79c4
	script_wait_move $00 ; $79cf
	ldh a, [hRomBank] ; $79d4
	ld b, a ; $79d6
	ld a, $00 ; $79d7
	ld de, $7b11 ; $79d9
	farcall FarPtr_ScriptSetActorScript ; $79dc
	script_move_target $02, $0500, $1f00 ; $79df
	script_wait_move $02 ; $79ea
	ldh a, [hRomBank] ; $79ef
	ld b, a ; $79f1
	ld a, $02 ; $79f2
	ld de, $7b11 ; $79f4
	farcall FarPtr_ScriptSetActorScript ; $79f7
	script_wait_frames $5a ; $79fa
	script_move_player $0e00, $1700 ; $7a01
	ld a, $0e ; $7a0b
	farcall FarPtr_WaitActorScriptDone ; $7a0d
	script_set_speed $0e, $0020 ; $7a10
	ldh a, [hRomBank] ; $7a18
	ld b, a ; $7a1a
	ld a, $0e ; $7a1b
	ld de, $7b24 ; $7a1d
	farcall FarPtr_ScriptSetActorScript ; $7a20
	ldh a, [hRomBank] ; $7a23
	ld b, a ; $7a25
	ld a, $02 ; $7a26
	ld de, $7c6e ; $7a28
	farcall FarPtr_ScriptSetActorScript ; $7a2b
	script_move_target $02, $0f00, $1b00 ; $7a2e
	ld a, $0e ; $7a39
	farcall FarPtr_WaitActorScriptDone ; $7a3b
	script_wait_frames $3c ; $7a3e
	script_set_anim $03, $03 ; $7a45
	script_wait_idle $03 ; $7a4c
	script_wait_frames $14 ; $7a51
	test_flag $0d, 6 ; $7a58
	jr z, Label_0e_7a66 ; $7a5b
	ld a, $01 ; $7a5d
	ld [$c294], a ; $7a5f
	ld [wStoryModeExitLocationRequest], a ; $7a62
	ret ; $7a65
Label_0e_7a66:
	script_set_text $30aa ; $7a66
	script_speak $03 ; $7a6c
	script_wait_frames $14 ; $7a71
	script_set_anim $0d, $03 ; $7a78
	script_set_anim $03, $03 ; $7a7f
	script_set_anim $02, $03 ; $7a86
	script_set_anim $00, $03 ; $7a8d
	script_wait_idle $00 ; $7a94
	script_wait_frames $14 ; $7a99
	script_player_speed $0020 ; $7aa0
	script_move_player $0e00, $1400 ; $7aa6
	script_set_speed $00, $0020 ; $7ab0
	script_set_speed $02, $0020 ; $7ab8
	script_set_speed $0d, $0020 ; $7ac0
	script_set_speed $03, $0020 ; $7ac8
	ldh a, [hRomBank] ; $7ad0
	ld b, a ; $7ad2
	ld a, $0d ; $7ad3
	ld de, $7b2f ; $7ad5
	farcall FarPtr_ScriptSetActorScript ; $7ad8
	ldh a, [hRomBank] ; $7adb
	ld b, a ; $7add
	ld a, $03 ; $7ade
	ld de, $7b46 ; $7ae0
	farcall FarPtr_ScriptSetActorScript ; $7ae3
	ldh a, [hRomBank] ; $7ae6
	ld b, a ; $7ae8
	ld a, $00 ; $7ae9
	ld de, $7b5d ; $7aeb
	farcall FarPtr_ScriptSetActorScript ; $7aee
	ldh a, [hRomBank] ; $7af1
	ld b, a ; $7af3
	ld a, $02 ; $7af4
	ld de, $7b6e ; $7af6
	farcall FarPtr_ScriptSetActorScript ; $7af9
	ld a, $0d ; $7afc
	farcall FarPtr_WaitActorScriptDone ; $7afe
	ld a, $03 ; $7b01
	farcall FarPtr_WaitActorScriptDone ; $7b03
	script_wait_frames $3c ; $7b06
	call PrepareStoryMatch ; $7b0d
	ret ; $7b10
	INCBIN "data/bank_00e/d_7b11.bin" ; $7b11, 110 bytes
PrepareStoryMatch:
	ld a, $1c ; $7b7f
	ld [wStoryModeCurrentLocation], a ; $7b81
	ld a, $0a ; $7b84
	ld [wStoryModeEntryPoint], a ; $7b86
	ld a, $ff ; $7b89
	ld [$c294], a ; $7b8b
	ld [wStoryModeExitLocationRequest], a ; $7b8e
	farcall FarPtr_InitStoryMatchSettings ; $7b91
	ld a, [wWaterSpriteMinigameTimer] ; $7b94
	add a, a ; $7b97
	add a, $ac ; $7b98
	ld l, a ; $7b9a
	adc a, $7b ; $7b9b
	sub a, l ; $7b9d
	ld h, a ; $7b9e
	ld a, [hl+] ; $7b9f
	ld h, [hl] ; $7ba0
	ld l, a ; $7ba1
	call JumpToHL ; $7ba2
	farcall FarPtr_RunStoryMatch ; $7ba5
	farcall FarPtr_RestoreOverworldAfterMatch ; $7ba8
	ret ; $7bab
	dw LoadExhibitionMatchSettings0 ; $7bac
	dw LoadExhibitionMatchSettings1 ; $7bae
	dw LoadExhibitionMatchSettings2 ; $7bb0
	dw LoadExhibitionMatchSettings3 ; $7bb2
	dw LoadExhibitionMatchSettings4 ; $7bb4
	dw LoadExhibitionMatchSettings5 ; $7bb6
LoadExhibitionMatchSettings0:
	load_match_settings $0018 ; $7bb8
	ret ; $7bc5
LoadExhibitionMatchSettings1:
	load_match_settings $0017 ; $7bc6
	ret ; $7bd3
LoadExhibitionMatchSettings2:
	load_match_settings $0016 ; $7bd4
	ret ; $7be1
LoadExhibitionMatchSettings3:
	load_match_settings $0118 ; $7be2
	ret ; $7bef
LoadExhibitionMatchSettings4:
	load_match_settings $0117 ; $7bf0
	ret ; $7bfd
LoadExhibitionMatchSettings5:
	load_match_settings $0116 ; $7bfe
	ret ; $7c0b
HandleExhibitionMatchResult:
	ld a, [wMatchWinLoseFlag] ; $7c0c
	cp a, $01 ; $7c0f
	jr nz, Label_0e_7c24 ; $7c11
	test_flag $05, 7 ; $7c13
	jr nz, Label_0e_7c1f ; $7c16
	test_flag $07, 3 ; $7c18
	jr nz, Label_0e_7c37 ; $7c1b
	jr Label_0e_7c24 ; $7c1d
Label_0e_7c1f:
	test_flag $06, 4 ; $7c1f
	jr nz, Label_0e_7c37 ; $7c22
Label_0e_7c24:
	ld a, $1d ; $7c24
	ld [wStoryModeCurrentLocation], a ; $7c26
	ld a, $0e ; $7c29
	ld [wStoryModeEntryPoint], a ; $7c2b
	ld a, $ff ; $7c2e
	ld [$c294], a ; $7c30
	ld [wStoryModeExitLocationRequest], a ; $7c33
	ret ; $7c36
Label_0e_7c37:
	test_flag $05, 7 ; $7c37
	jr nz, Label_0e_7c49 ; $7c3a
	ld b, $02 ; $7c3c
	ld a, [$c90d] ; $7c3e
	add a, $04 ; $7c41
	ld c, a ; $7c43
	farcall FarPtr_18_8e ; $7c44
	jr Label_0e_7c5b ; $7c47
Label_0e_7c49:
	ld b, $02 ; $7c49
	ld a, [$c90d] ; $7c4b
	ld d, a ; $7c4e
	sla a ; $7c4f
	ld c, a ; $7c51
	ld a, [$c94d] ; $7c52
	xor a, d ; $7c55
	or a, c ; $7c56
	ld c, a ; $7c57
	farcall FarPtr_18_8e ; $7c58
Label_0e_7c5b:
	ld a, $00 ; $7c5b
	ld [wStoryModeCurrentLocation], a ; $7c5d
	ld a, $0a ; $7c60
	ld [wStoryModeEntryPoint], a ; $7c62
	ld a, $ff ; $7c65
	ld [$c294], a ; $7c67
	ld [wStoryModeExitLocationRequest], a ; $7c6a
	ret ; $7c6d
	INCBIN "data/bank_00e/d_7c6e.bin" ; $7c6e, 40 bytes
MapScriptNop_0e:
	ret ; $7c96
MapScriptClearActiveFlag_0e:
	xor a, a ; $7c97
	ld [$c2da], a ; $7c98
	ret ; $7c9b
MapScriptPlaySoundA2_0e:
	sound $a2 ; $7c9c
	ret ; $7c9e
MapScriptHideLocationName_0e:
	xor a, a ; $7c9f
	ld [wStoryModeShowLocationName], a ; $7ca0
	ret ; $7ca3
	INCBIN "data/bank_00e/d_7ca4.bin" ; $7ca4, 438 bytes
ComputeTrainingGymProgressIndex:
	test_flag $05, 7 ; $7e5a
	jr nz, Label_0e_7e81 ; $7e5d
	ld a, $00 ; $7e5f
	test_flag $0a, 3 ; $7e61
	jr z, Label_0e_7e7d ; $7e64
	ld a, $02 ; $7e66
	test_flag $0a, 7 ; $7e68
	jr z, Label_0e_7e7d ; $7e6b
	ld a, $04 ; $7e6d
	test_flag $15, 6 ; $7e6f
	jr z, Label_0e_7e7d ; $7e72
	ld a, $06 ; $7e74
	test_flag $16, 0 ; $7e76
	jr z, Label_0e_7e7d ; $7e79
	ld a, $08 ; $7e7b
Label_0e_7e7d:
	ld [$c2b0], a ; $7e7d
	ret ; $7e80
Label_0e_7e81:
	ld a, $01 ; $7e81
	test_flag $08, 2 ; $7e83
	jr z, Label_0e_7e7d ; $7e86
	ld a, $03 ; $7e88
	test_flag $08, 6 ; $7e8a
	jr z, Label_0e_7e7d ; $7e8d
	ld a, $05 ; $7e8f
	test_flag $15, 7 ; $7e91
	jr z, Label_0e_7e7d ; $7e94
	ld a, $07 ; $7e96
	test_flag $16, 1 ; $7e98
	jr z, Label_0e_7e7d ; $7e9b
	ld a, $09 ; $7e9d
	jr Label_0e_7e7d ; $7e9f
	ld a, $00 ; $7ea1
	test_flag $0a, 3 ; $7ea3
	jr z, Label_0e_7ec0 ; $7ea6
	inc a ; $7ea8
	test_flag $0a, 7 ; $7ea9
	jr z, Label_0e_7ec0 ; $7eac
	inc a ; $7eae
	test_flag $05, 7 ; $7eaf
	jr nz, Label_0e_7ec4 ; $7eb2
	test_flag $15, 6 ; $7eb4
	jr z, Label_0e_7ec0 ; $7eb7
	inc a ; $7eb9
	test_flag $16, 0 ; $7eba
	jr z, Label_0e_7ec0 ; $7ebd
	inc a ; $7ebf
Label_0e_7ec0:
	ld [$c2b0], a ; $7ec0
	ret ; $7ec3
Label_0e_7ec4:
	test_flag $15, 7 ; $7ec4
	jr z, Label_0e_7ec0 ; $7ec7
	inc a ; $7ec9
	test_flag $16, 1 ; $7eca
	jr z, Label_0e_7ec0 ; $7ecd
	inc a ; $7ecf
	jr Label_0e_7ec0 ; $7ed0
	ds 302, $ff ; $7ed2, fill

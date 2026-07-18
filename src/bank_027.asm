SECTION "ROM Bank $27", ROMX[$4000], BANK[$27]

DataPtr_End17AwardCeremonyMapScripts_27:
	dw End17AwardCeremonyMapScripts_27 ; $4000
DataPtr_End16BeforeFinalsMapScripts_27:
	dw End16BeforeFinalsMapScripts_27 ; $4002
DataPtr_End12PrincipalsOfficeMapScripts_27:
	dw End12PrincipalsOfficeMapScripts_27 ; $4004
DataPtr_End11TrainingCourtMapScripts_27:
	dw End11TrainingCourtMapScripts_27 ; $4006
DataPtr_End10VarsityCourtMapScripts_27:
	dw End10VarsityCourtMapScripts_27 ; $4008
DataPtr_End8SrCourtMapScripts_27:
	dw End8SrCourtMapScripts_27 ; $400a
DataPtr_End7TrainingCtrMapScripts_27:
	dw End7TrainingCtrMapScripts_27 ; $400c
DataPtr_End5ServiceAceMapScripts_27:
	dw End5ServiceAceMapScripts_27 ; $400e
DataPtr_End4JrCourtMapScripts_27:
	dw End4JrCourtMapScripts_27 ; $4010
DataPtr_End3DormEntMapScripts_27:
	dw End3DormEntMapScripts_27 ; $4012
DataPtr_EndRestaurantEntMapScripts_27:
	dw EndRestaurantEntMapScripts_27 ; $4014
DataPtr_End1MainBldgMapScripts_27:
	dw End1MainBldgMapScripts_27 ; $4016
End17AwardCeremonyMapScripts_27:
	; $4018, 14 bytes (map_tree)
	dw End17AwardCeremonyEntryPoints_27 ; slot 0 EntryPoints
	dw End17AwardCeremonyExitTriggers_27 ; slot 1 ExitTriggers
	dw End17AwardCeremonyActors_27 ; slot 2 Actors
	dw End17AwardCeremonyNpcScripts_27 ; slot 3 NpcScripts
	dw End17AwardCeremonyFacingScripts_27 ; slot 4 FacingScripts
	dw End17AwardCeremonyTileTriggers_27 ; slot 5 TileTriggers
	dw End17AwardCeremonyInitScript_27 ; slot 6 InitScript
End17AwardCeremonyActors_27:
	; $4026, 178 bytes (map_actors)
	map_actor $0000, $785d, $0f00, $1600, $c0, $25, $01, $00
	map_actor $0000, $785d, $0c00, $1300, $c0, $63, $01, $00
	map_actor $0000, $785d, $0e80, $17c0, $40, $74, $01, $00
	map_actor $0000, $785d, $0f00, $1600, $c0, $25, $01, $00
	map_actor $0000, $785d, $0e00, $0e40, $40, $5c, $01, $00
	map_actor $0000, $785d, $0a00, $0dc0, $40, $61, $01, $00
	map_actor $0000, $785d, $0c00, $0d40, $40, $26, $01, $00
	map_actor $0000, $785d, $0700, $0500, $40, $30, $01, $00
	map_actor $0000, $785d, $0f00, $0700, $40, $3a, $01, $00
	map_actor $0000, $785d, $0e80, $1b00, $c0, $62, $01, $00
	map_actor $0000, $785d, $0980, $1b00, $c0, $23, $01, $00
	map_actor $0000, $785d, $0800, $1940, $00, $25, $01, $05
	map_actor_end
End17AwardCeremonyActorsAlt_27:
	; $40d8, 178 bytes (map_actors)
	map_actor $0000, $785d, $0f00, $1600, $c0, $25, $01, $00
	map_actor $0000, $785d, $0e00, $1300, $c0, $63, $01, $00
	map_actor $0000, $785d, $0e80, $17c0, $40, $74, $01, $00
	map_actor $0000, $785d, $0f00, $1600, $c0, $25, $01, $00
	map_actor $0000, $785d, $0900, $0e00, $40, $62, $01, $00
	map_actor $0000, $785d, $0b00, $0e00, $40, $61, $01, $00
	map_actor $0000, $785d, $0d00, $0d60, $40, $26, $01, $00
	map_actor $0000, $785d, $0700, $0500, $40, $30, $01, $00
	map_actor $0000, $785d, $0f00, $0700, $40, $3a, $01, $00
	map_actor $0000, $785d, $0f00, $1b00, $c0, $5c, $01, $00
	map_actor $0000, $785d, $0900, $1b00, $c0, $23, $01, $00
	map_actor $0000, $785d, $0800, $1940, $00, $25, $01, $05
	map_actor_end
End17AwardCeremonyEntryPoints_27:
	; $418a, 9 bytes (map_entries)
	map_entry $01, $c0, $0c00, $1100, $0000
	db $ff
End17AwardCeremonyExitTriggers_27:
	; $4193, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_27, $08, $06
	db $ff
End17AwardCeremonyNpcScripts_27:
	ds 1, $ff ; $419c, fill
End17AwardCeremonyFacingScripts_27:
	ds 1, $ff ; $419d, fill
End17AwardCeremonyTileTriggers_27:
	ds 1, $ff ; $419e, fill
End17AwardCeremonyInitScript_27:
	test_flag $05, 7 ; $419f
	jr z, Label_27_41c0 ; $41a2
	ldh a, [hRomBank] ; $41a4
	ld hl, End17AwardCeremonyActorsAlt_27 ; $41a6
	farcall FarPtr_ScriptRespawnLocationActors ; $41a9
	ld b, $1a ; $41ac
	ld c, $0d ; $41ae
	ld d, $08 ; $41b0
	ld e, $0d ; $41b2
	ld h, $08 ; $41b4
	ld l, $03 ; $41b6
	farcall FarPtr_CopySceneTilemapRect ; $41b8
	farcall FarPtr_BeginCutsceneScriptMode ; $41bb
	jr Label_27_41c7 ; $41be
Label_27_41c0:
	ld a, $05 ; $41c0
	ld d, $06 ; $41c2
	farcall FarPtr_ScriptSetActorAnimation ; $41c4
Label_27_41c7:
	call Func_27_45be ; $41c7
	jr Label_27_41cd ; $41ca
	ret ; $41cc
Label_27_41cd:
	ld a, $03 ; $41cd
	ld bc, $3f00 ; $41cf
	ld de, $3f00 ; $41d2
	farcall FarPtr_ScriptSetActorPosition ; $41d5
	ld a, $00 ; $41d8
	ld bc, $3f00 ; $41da
	ld de, $3f00 ; $41dd
	farcall FarPtr_ScriptSetActorPosition ; $41e0
	xor a, a ; $41e3
	ld [wStoryModeShowLocationName], a ; $41e4
	ld c, $04 ; $41e7
	call BeginFadeIn ; $41e9
	call WaitFadeEnd ; $41ec
	test_flag $05, 7 ; $41ef
	jp nz, Label_27_43c2 ; $41f2
	ld a, $03 ; $41f5
	ld bc, $0010 ; $41f7
	farcall FarPtr_ScriptSetActorMoveSpeed ; $41fa
	ld a, $04 ; $41fd
	ld bc, $0010 ; $41ff
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4202
	ld a, $05 ; $4205
	ld bc, $0010 ; $4207
	farcall FarPtr_ScriptSetActorMoveSpeed ; $420a
	ld a, $06 ; $420d
	ld bc, $0010 ; $420f
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4212
	ld a, $06 ; $4215
	ld b, $40 ; $4217
	farcall FarPtr_SetActorFacing ; $4219
	ld a, $1e ; $421c
	call Func_27_7856 ; $421e
	ld a, $05 ; $4221
	ld bc, $0f80 ; $4223
	ld de, $1600 ; $4226
	farcall FarPtr_ScriptSetActorPosition ; $4229
	ld a, $1e ; $422c
	call Func_27_7856 ; $422e
	ld a, $06 ; $4231
	ld bc, $3f00 ; $4233
	ld de, $3f00 ; $4236
	farcall FarPtr_ScriptSetActorPosition ; $4239
	ld a, $03 ; $423c
	ld bc, $0f00 ; $423e
	ld de, $1600 ; $4241
	farcall FarPtr_ScriptSetActorPosition ; $4244
	ld a, $05 ; $4247
	ld bc, $0f00 ; $4249
	ld de, $1500 ; $424c
	farcall FarPtr_ScriptSetActorPosition ; $424f
	ld a, $03 ; $4252
	ld b, $c0 ; $4254
	farcall FarPtr_SetActorFacing ; $4256
	ld a, $05 ; $4259
	ld bc, $0f00 ; $425b
	ld de, $1200 ; $425e
	farcall FarPtr_ScriptSetActorMoveTarget ; $4261
	ld a, $03 ; $4264
	ld bc, $0f00 ; $4266
	ld de, $1300 ; $4269
	farcall FarPtr_ScriptSetActorMoveTarget ; $426c
	ld a, $03 ; $426f
	farcall FarPtr_ScriptWaitActorMoveDone ; $4271
	ld a, $03 ; $4274
	ld bc, $3f00 ; $4276
	ld de, $3f00 ; $4279
	farcall FarPtr_ScriptSetActorPosition ; $427c
	ld a, $06 ; $427f
	ld bc, $0f00 ; $4281
	ld de, $1300 ; $4284
	farcall FarPtr_ScriptSetActorPosition ; $4287
	ld a, $05 ; $428a
	ld bc, $0e00 ; $428c
	ld de, $1300 ; $428f
	farcall FarPtr_ScriptSetActorPosition ; $4292
	ld a, $06 ; $4295
	ld b, $80 ; $4297
	farcall FarPtr_SetActorFacing ; $4299
	ld a, $06 ; $429c
	ld bc, $0e00 ; $429e
	ld de, $1300 ; $42a1
	farcall FarPtr_ScriptSetActorMoveTarget ; $42a4
	ld a, $05 ; $42a7
	ld bc, $0d00 ; $42a9
	ld de, $1300 ; $42ac
	farcall FarPtr_ScriptSetActorMoveTarget ; $42af
	ld a, $05 ; $42b2
	farcall FarPtr_ScriptWaitActorMoveDone ; $42b4
	ld a, $06 ; $42b7
	ld b, $01 ; $42b9
	farcall FarPtr_ScriptSetActorFacingLock ; $42bb
	ld a, $06 ; $42be
	ld bc, $0f00 ; $42c0
	ld de, $1300 ; $42c3
	farcall FarPtr_ScriptSetActorMoveTarget ; $42c6
	ld a, $06 ; $42c9
	farcall FarPtr_ScriptWaitActorMoveDone ; $42cb
	ld a, $06 ; $42ce
	ld b, $00 ; $42d0
	farcall FarPtr_ScriptSetActorFacingLock ; $42d2
	ld a, $06 ; $42d5
	ld bc, $0f00 ; $42d7
	ld de, $1600 ; $42da
	farcall FarPtr_ScriptSetActorMoveTarget ; $42dd
	ld a, $06 ; $42e0
	farcall FarPtr_ScriptWaitActorMoveDone ; $42e2
	ld a, $06 ; $42e5
	ld b, $c0 ; $42e7
	farcall FarPtr_SetActorFacing ; $42e9
	ld a, $04 ; $42ec
	ld bc, $0c00 ; $42ee
	ld de, $1100 ; $42f1
	farcall FarPtr_ScriptSetActorMoveTarget ; $42f4
	ld a, $05 ; $42f7
	ld bc, $0c00 ; $42f9
	ld de, $1000 ; $42fc
	farcall FarPtr_ScriptSetActorMoveTarget ; $42ff
	ld a, $05 ; $4302
	farcall FarPtr_ScriptWaitActorMoveDone ; $4304
	ld a, $50 ; $4307
	call Func_27_7856 ; $4309
	ld a, $04 ; $430c
	ld bc, $0c00 ; $430e
	ld de, $0f80 ; $4311
	farcall FarPtr_ScriptSetActorMoveTarget ; $4314
	ld a, $05 ; $4317
	ld bc, $0c00 ; $4319
	ld de, $0e40 ; $431c
	farcall FarPtr_ScriptSetActorMoveTarget ; $431f
	ld a, $05 ; $4322
	farcall FarPtr_ScriptWaitActorMoveDone ; $4324
	ld a, $04 ; $4327
	ld b, $01 ; $4329
	farcall FarPtr_ScriptSetActorFacingLock ; $432b
	ld a, $04 ; $432e
	ld bc, $0c00 ; $4330
	ld de, $1100 ; $4333
	farcall FarPtr_ScriptSetActorMoveTarget ; $4336
	ld a, $04 ; $4339
	farcall FarPtr_ScriptWaitActorMoveDone ; $433b
	ld a, $04 ; $433e
	ld b, $00 ; $4340
	farcall FarPtr_ScriptSetActorFacingLock ; $4342
	ld a, $04 ; $4345
	ld b, $c0 ; $4347
	farcall FarPtr_SetActorFacing ; $4349
	ld a, $0e ; $434c
	ld d, $02 ; $434e
	farcall FarPtr_ScriptSetActorAnimation ; $4350
	ld a, $0e ; $4353
	farcall FarPtr_ScriptWaitActorIdle ; $4355
	ld a, $32 ; $4358
	call Func_27_7856 ; $435a
	ld a, $07 ; $435d
	ld b, $80 ; $435f
	farcall FarPtr_SetActorFacing ; $4361
	ld a, $08 ; $4364
	ld b, $00 ; $4366
	farcall FarPtr_SetActorFacing ; $4368
	ld a, $3c ; $436b
	call Func_27_7856 ; $436d
	ld a, $05 ; $4370
	ld bc, $0b40 ; $4372
	ld de, $0c40 ; $4375
	farcall FarPtr_ScriptSetActorPosition ; $4378
Label_27_437b:
	ld a, [$c90d] ; $437b
	ld d, $26 ; $437e
	add a, d ; $4380
	ld d, a ; $4381
	ld a, $09 ; $4382
	farcall FarPtr_GetActorStateAddr ; $4384
	ld c, l ; $4387
	ld b, h ; $4388
	farcall FarPtr_04_2c ; $4389
	ld a, $09 ; $438c
	ld d, $01 ; $438e
	farcall FarPtr_ScriptSetActorAnimation ; $4390
	ld a, $09 ; $4393
	ld b, $00 ; $4395
	farcall FarPtr_SetActorFacing ; $4397
	ld a, $09 ; $439a
	ld d, $08 ; $439c
	farcall FarPtr_ScriptSetActorAnimation ; $439e
	ld bc, $0006 ; $43a1
	farcall FarPtr_SetPlayerMoveSpeed ; $43a4
	xor a, a ; $43a7
	ld bc, $0c00 ; $43a8
	ld de, $0d00 ; $43ab
	farcall FarPtr_MovePlayerToPosition ; $43ae
	farcall FarPtr_WaitPlayerMoveDone ; $43b1
	ld a, $32 ; $43b4
	call Func_27_7856 ; $43b6
	ld a, $01 ; $43b9
	ld [$c294], a ; $43bb
	ld [wStoryModeExitLocationRequest], a ; $43be
	ret ; $43c1
Label_27_43c2:
	ld a, $03 ; $43c2
	ld bc, $0010 ; $43c4
	farcall FarPtr_ScriptSetActorMoveSpeed ; $43c7
	ld a, $04 ; $43ca
	ld bc, $0010 ; $43cc
	farcall FarPtr_ScriptSetActorMoveSpeed ; $43cf
	ld a, $05 ; $43d2
	ld bc, $0010 ; $43d4
	farcall FarPtr_ScriptSetActorMoveSpeed ; $43d7
	ld a, $06 ; $43da
	ld bc, $0010 ; $43dc
	farcall FarPtr_ScriptSetActorMoveSpeed ; $43df
	ld a, $06 ; $43e2
	ld bc, $0f00 ; $43e4
	ld de, $1600 ; $43e7
	farcall FarPtr_ScriptSetActorMoveTarget ; $43ea
	ld a, $06 ; $43ed
	farcall FarPtr_ScriptWaitActorMoveDone ; $43ef
	ld a, $06 ; $43f2
	ld b, $40 ; $43f4
	farcall FarPtr_SetActorFacing ; $43f6
	ld a, $14 ; $43f9
	call Func_27_7856 ; $43fb
	ld a, $05 ; $43fe
	ld bc, $0f80 ; $4400
	ld de, $1600 ; $4403
	farcall FarPtr_ScriptSetActorPosition ; $4406
	ld a, $14 ; $4409
	call Func_27_7856 ; $440b
	ld a, $06 ; $440e
	ld bc, $3f00 ; $4410
	ld de, $3f00 ; $4413
	farcall FarPtr_ScriptSetActorPosition ; $4416
	ld a, $03 ; $4419
	ld bc, $0f00 ; $441b
	ld de, $1600 ; $441e
	farcall FarPtr_ScriptSetActorPosition ; $4421
	ld a, $05 ; $4424
	ld bc, $0f00 ; $4426
	ld de, $1500 ; $4429
	farcall FarPtr_ScriptSetActorPosition ; $442c
	ld a, $03 ; $442f
	ld b, $c0 ; $4431
	farcall FarPtr_SetActorFacing ; $4433
	ld a, $05 ; $4436
	ld bc, $0f00 ; $4438
	ld de, $1300 ; $443b
	farcall FarPtr_ScriptSetActorMoveTarget ; $443e
	ld a, $03 ; $4441
	ld bc, $0f00 ; $4443
	ld de, $1400 ; $4446
	farcall FarPtr_ScriptSetActorMoveTarget ; $4449
	ld a, $03 ; $444c
	farcall FarPtr_ScriptWaitActorMoveDone ; $444e
	ld a, $06 ; $4451
	ld b, $c0 ; $4453
	farcall FarPtr_SetActorFacing ; $4455
	ld a, $03 ; $4458
	ld b, $01 ; $445a
	farcall FarPtr_ScriptSetActorFacingLock ; $445c
	ld a, $03 ; $445f
	ld bc, $0f00 ; $4461
	ld de, $1600 ; $4464
	farcall FarPtr_ScriptSetActorMoveTarget ; $4467
	ld a, $03 ; $446a
	farcall FarPtr_ScriptWaitActorMoveDone ; $446c
	ld a, $03 ; $446f
	ld b, $00 ; $4471
	farcall FarPtr_ScriptSetActorFacingLock ; $4473
	ld a, $03 ; $4476
	ld b, $c0 ; $4478
	farcall FarPtr_SetActorFacing ; $447a
	ld a, $05 ; $447d
	ld bc, $0ec0 ; $447f
	ld de, $1300 ; $4482
	farcall FarPtr_ScriptSetActorPosition ; $4485
	ld a, $04 ; $4488
	ld bc, $0f00 ; $448a
	ld de, $1300 ; $448d
	farcall FarPtr_ScriptSetActorMoveTarget ; $4490
	ld a, $05 ; $4493
	ld bc, $0fc0 ; $4495
	ld de, $1300 ; $4498
	farcall FarPtr_ScriptSetActorMoveTarget ; $449b
	ld a, $05 ; $449e
	farcall FarPtr_ScriptWaitActorMoveDone ; $44a0
	ld a, $04 ; $44a3
	ld bc, $0f00 ; $44a5
	ld de, $1100 ; $44a8
	farcall FarPtr_ScriptSetActorMoveTarget ; $44ab
	ld a, $05 ; $44ae
	ld bc, $0fc0 ; $44b0
	ld de, $1100 ; $44b3
	farcall FarPtr_ScriptSetActorMoveTarget ; $44b6
	ld a, $05 ; $44b9
	farcall FarPtr_ScriptWaitActorMoveDone ; $44bb
	ld a, $3c ; $44be
	call Func_27_7856 ; $44c0
	ld a, $02 ; $44c3
	ld d, $03 ; $44c5
	farcall FarPtr_ScriptSetActorAnimation ; $44c7
	ld a, $02 ; $44ca
	farcall FarPtr_ScriptWaitActorIdle ; $44cc
	ld a, $04 ; $44cf
	ld d, $03 ; $44d1
	farcall FarPtr_ScriptSetActorAnimation ; $44d3
	ld a, $04 ; $44d6
	farcall FarPtr_ScriptWaitActorIdle ; $44d8
	ld a, $3c ; $44db
	call Func_27_7856 ; $44dd
	ld a, $05 ; $44e0
	ld bc, $0e40 ; $44e2
	ld de, $1100 ; $44e5
	farcall FarPtr_ScriptSetActorPosition ; $44e8
	ld a, $04 ; $44eb
	ld bc, $0d00 ; $44ed
	ld de, $1100 ; $44f0
	farcall FarPtr_ScriptSetActorMoveTarget ; $44f3
	ld a, $05 ; $44f6
	ld bc, $0c40 ; $44f8
	ld de, $1100 ; $44fb
	farcall FarPtr_ScriptSetActorMoveTarget ; $44fe
	ld a, $05 ; $4501
	farcall FarPtr_ScriptWaitActorMoveDone ; $4503
	ld a, $04 ; $4506
	call Func_27_7856 ; $4508
	ld a, $04 ; $450b
	ld b, $c0 ; $450d
	farcall FarPtr_SetActorFacing ; $450f
	ld a, $05 ; $4512
	ld bc, $0d00 ; $4514
	ld de, $1000 ; $4517
	farcall FarPtr_ScriptSetActorMoveTarget ; $451a
	ld a, $05 ; $451d
	farcall FarPtr_ScriptWaitActorMoveDone ; $451f
	ld a, $32 ; $4522
	call Func_27_7856 ; $4524
	ld a, $04 ; $4527
	ld bc, $0d00 ; $4529
	ld de, $1000 ; $452c
	farcall FarPtr_ScriptSetActorMoveTarget ; $452f
	ld a, $05 ; $4532
	ld bc, $0d00 ; $4534
	ld de, $0e80 ; $4537
	farcall FarPtr_ScriptSetActorMoveTarget ; $453a
	ld a, $05 ; $453d
	farcall FarPtr_ScriptWaitActorMoveDone ; $453f
	ld a, $05 ; $4542
	call Func_27_7856 ; $4544
	ld a, $04 ; $4547
	ld b, $01 ; $4549
	farcall FarPtr_ScriptSetActorFacingLock ; $454b
	ld a, $04 ; $454e
	ld bc, $0d00 ; $4550
	ld de, $1100 ; $4553
	farcall FarPtr_ScriptSetActorMoveTarget ; $4556
	ld a, $04 ; $4559
	farcall FarPtr_ScriptWaitActorMoveDone ; $455b
	ld a, $04 ; $455e
	ld b, $00 ; $4560
	farcall FarPtr_ScriptSetActorFacingLock ; $4562
	ld a, $04 ; $4565
	ld b, $c0 ; $4567
	farcall FarPtr_SetActorFacing ; $4569
	ld a, $0e ; $456c
	ld d, $02 ; $456e
	farcall FarPtr_ScriptSetActorAnimation ; $4570
	ld a, $0e ; $4573
	farcall FarPtr_ScriptWaitActorIdle ; $4575
	ld a, $1e ; $4578
	call Func_27_7856 ; $457a
	ld a, $09 ; $457d
	ld d, $03 ; $457f
	farcall FarPtr_ScriptSetActorAnimation ; $4581
	ld a, $02 ; $4584
	ld d, $03 ; $4586
	farcall FarPtr_ScriptSetActorAnimation ; $4588
	ld a, $02 ; $458b
	farcall FarPtr_ScriptWaitActorIdle ; $458d
	ld a, $1e ; $4590
	call Func_27_7856 ; $4592
	ld a, $02 ; $4595
	ld b, $80 ; $4597
	farcall FarPtr_SetActorFacing ; $4599
	ld a, $07 ; $459c
	ld b, $00 ; $459e
	farcall FarPtr_SetActorFacing ; $45a0
	ld a, $08 ; $45a3
	ld b, $00 ; $45a5
	farcall FarPtr_SetActorFacing ; $45a7
	ld a, $3c ; $45aa
	call Func_27_7856 ; $45ac
	ld a, $05 ; $45af
	ld bc, $0c40 ; $45b1
	ld de, $0c60 ; $45b4
	farcall FarPtr_ScriptSetActorPosition ; $45b7
	jp Label_27_437b ; $45ba
	ret ; $45bd
Func_27_45be:
	test_flag $05, 7 ; $45be
	jp z, Label_27_45f3 ; $45c1
	ld a, [$c94d] ; $45c4
	ld d, $58 ; $45c7
	add a, d ; $45c9
	ld d, a ; $45ca
	ld a, $02 ; $45cb
	farcall FarPtr_GetActorStateAddr ; $45cd
	ld c, l ; $45d0
	ld b, h ; $45d1
	farcall FarPtr_04_2c ; $45d2
	ld a, $02 ; $45d5
	ld d, $01 ; $45d7
	farcall FarPtr_ScriptSetActorAnimation ; $45d9
	ld a, $02 ; $45dc
	farcall FarPtr_SetActorNullScript ; $45de
	ld a, $02 ; $45e1
	ld bc, $0f00 ; $45e3
	ld de, $0d60 ; $45e6
	farcall FarPtr_ScriptSetActorPosition ; $45e9
	ld a, $02 ; $45ec
	ld b, $40 ; $45ee
	farcall FarPtr_SetActorFacing ; $45f0
Label_27_45f3:
	ld a, [$c90d] ; $45f3
	ld d, $56 ; $45f6
	add a, d ; $45f8
	ld d, a ; $45f9
	ld a, $09 ; $45fa
	farcall FarPtr_GetActorStateAddr ; $45fc
	ld c, l ; $45ff
	ld b, h ; $4600
	farcall FarPtr_04_2c ; $4601
	ld a, $09 ; $4604
	ld d, $01 ; $4606
	farcall FarPtr_ScriptSetActorAnimation ; $4608
	ret ; $460b
End16BeforeFinalsMapScripts_27:
	; $460c, 14 bytes (map_tree)
	dw End16BeforeFinalsEntryPoints_27 ; slot 0 EntryPoints
	dw End16BeforeFinalsExitTriggers_27 ; slot 1 ExitTriggers
	dw End16BeforeFinalsActors_27 ; slot 2 Actors
	dw End16BeforeFinalsNpcScripts_27 ; slot 3 NpcScripts
	dw End16BeforeFinalsFacingScripts_27 ; slot 4 FacingScripts
	dw End16BeforeFinalsTileTriggers_27 ; slot 5 TileTriggers
	dw End16BeforeFinalsInitScript_27 ; slot 6 InitScript
End16BeforeFinalsActors_27:
	; $461a, 206 bytes (map_actors)
	map_actor $0000, $785d, $2700, $1100, $80, $25, $01, $00
	map_actor $0000, $785d, $1300, $0f00, $40, $25, $01, $00
	map_actor $0000, $785d, $0100, $0c00, $00, $25, $01, $00
	map_actor $0000, $785d, $2300, $1100, $c0, $5c, $01, $00
	map_actor $0000, $787b, $2300, $1700, $c0, $5b, $01, $00
	map_actor $0000, $785d, $2100, $1100, $00, $5a, $01, $00
	map_actor $0000, $785d, $2900, $1700, $80, $5f, $01, $00
	map_actor $0000, $785d, $1100, $1500, $40, $5d, $01, $00
	map_actor $0000, $785d, $1900, $1300, $40, $60, $01, $00
	map_actor $0000, $785d, $1700, $1300, $40, $61, $01, $00
	map_actor $0000, $785d, $0f00, $1300, $40, $62, $01, $00
	map_actor $0000, $785d, $1900, $1500, $40, $5e, $01, $00
	map_actor $0000, $785d, $1700, $1500, $40, $1e, $01, $00
	map_actor $0000, $785d, $1100, $1300, $40, $1f, $01, $00
	map_actor_end
End16BeforeFinalsEntryPoints_27:
	; $46e8, 9 bytes (map_entries)
	map_entry $01, $c0, $1c00, $2300, $0000
	db $ff
End16BeforeFinalsExitTriggers_27:
	; $46f1, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_27, $18, $01
	db $ff
End16BeforeFinalsNpcScripts_27:
	ds 1, $ff ; $46fa, fill
End16BeforeFinalsFacingScripts_27:
	ds 1, $ff ; $46fb, fill
End16BeforeFinalsTileTriggers_27:
	ds 1, $ff ; $46fc, fill
End16BeforeFinalsInitScript_27:
	test_flag $05, 7 ; $46fd
	jr nz, Label_27_470e ; $4700
	ldh a, [hRomBank] ; $4702
	ld hl, $471a ; $4704
	farcall FarPtr_ScriptRespawnLocationActors ; $4707
	call Func_27_490c ; $470a
	ret ; $470d
Label_27_470e:
	ldh a, [hRomBank] ; $470e
	ld hl, $47e8 ; $4710
	farcall FarPtr_ScriptRespawnLocationActors ; $4713
	call Func_27_490c ; $4716
	ret ; $4719
	INCBIN "data/bank_027/d_471a.bin" ; $471a, 398 bytes
Func_27_48a8:
	ld a, $00 ; $48a8
	ld bc, $1c00 ; $48aa
	ld de, $1900 ; $48ad
	farcall FarPtr_ScriptSetActorMoveTarget ; $48b0
	ld a, $00 ; $48b3
	farcall FarPtr_ScriptWaitActorMoveDone ; $48b5
	test_flag $05, 7 ; $48b8
	jr nz, Label_27_48f0 ; $48bb
	ldh a, [hRomBank] ; $48bd
	ld b, a ; $48bf
	ld a, $00 ; $48c0
	ld de, $48d9 ; $48c2
	farcall FarPtr_ScriptSetActorScript ; $48c5
	ld a, $00 ; $48c8
	farcall FarPtr_WaitActorScriptDone ; $48ca
	ret ; $48cd
	INCBIN "data/bank_027/d_48ce.bin" ; $48ce, 34 bytes
Label_27_48f0:
	ldh a, [hRomBank] ; $48f0
	ld b, a ; $48f2
	ld a, $00 ; $48f3
	ld de, $48ce ; $48f5
	farcall FarPtr_ScriptSetActorScript ; $48f8
	ldh a, [hRomBank] ; $48fb
	ld b, a ; $48fd
	ld a, $02 ; $48fe
	ld de, $48d9 ; $4900
	farcall FarPtr_ScriptSetActorScript ; $4903
	ld a, $00 ; $4906
	farcall FarPtr_WaitActorScriptDone ; $4908
	ret ; $490b
Func_27_490c:
	ld c, $08 ; $490c
	call BeginFadeIn ; $490e
	call WaitFadeEnd ; $4911
	call Func_27_48a8 ; $4914
	farcall FarPtr_BeginCutsceneScriptMode ; $4917
	xor a, a ; $491a
	ld bc, $1100 ; $491b
	ld de, $0f00 ; $491e
	farcall FarPtr_MovePlayerToPosition ; $4921
	farcall FarPtr_WaitPlayerMoveDone ; $4924
	ld a, $05 ; $4927
	ld bc, $0e00 ; $4929
	ld de, $0c00 ; $492c
	farcall FarPtr_ScriptSetActorMoveTarget ; $492f
	ld a, $05 ; $4932
	farcall FarPtr_ScriptWaitActorMoveDone ; $4934
	ld a, $05 ; $4937
	ld bc, $1300 ; $4939
	ld de, $0c00 ; $493c
	farcall FarPtr_ScriptSetActorMoveTarget ; $493f
	ld a, $05 ; $4942
	farcall FarPtr_ScriptWaitActorMoveDone ; $4944
	ld a, $05 ; $4947
	ld b, $40 ; $4949
	farcall FarPtr_SetActorFacing ; $494b
	ld a, $05 ; $494e
	ld d, $02 ; $4950
	farcall FarPtr_ScriptSetActorAnimation ; $4952
	ld a, $05 ; $4955
	farcall FarPtr_ScriptWaitActorIdle ; $4957
	ld a, $04 ; $495a
	ld b, $c0 ; $495c
	farcall FarPtr_SetActorFacing ; $495e
	ld a, $04 ; $4961
	ld d, $03 ; $4963
	farcall FarPtr_ScriptSetActorAnimation ; $4965
	ld a, $04 ; $4968
	farcall FarPtr_ScriptWaitActorIdle ; $496a
	ld a, $04 ; $496d
	ld b, $40 ; $496f
	farcall FarPtr_SetActorFacing ; $4971
	ld a, $04 ; $4974
	ld bc, $1300 ; $4976
	ld de, $1700 ; $4979
	farcall FarPtr_ScriptSetActorMoveTarget ; $497c
	ld a, $05 ; $497f
	ld bc, $1300 ; $4981
	ld de, $1700 ; $4984
	farcall FarPtr_ScriptSetActorMoveTarget ; $4987
	xor a, a ; $498a
	ld bc, $1100 ; $498b
	ld de, $1300 ; $498e
	farcall FarPtr_MovePlayerToPosition ; $4991
	ld a, $04 ; $4994
	farcall FarPtr_ScriptWaitActorMoveDone ; $4996
	ld a, $04 ; $4999
	ld bc, $1500 ; $499b
	ld de, $1700 ; $499e
	farcall FarPtr_ScriptSetActorMoveTarget ; $49a1
	ld a, $04 ; $49a4
	farcall FarPtr_ScriptWaitActorMoveDone ; $49a6
	ld a, $04 ; $49a9
	ld b, $c0 ; $49ab
	farcall FarPtr_SetActorFacing ; $49ad
	ld a, $05 ; $49b0
	farcall FarPtr_ScriptWaitActorMoveDone ; $49b2
	ld a, $05 ; $49b5
	ld b, $c0 ; $49b7
	farcall FarPtr_SetActorFacing ; $49b9
	ld a, $05 ; $49bc
	ld b, a ; $49be
	ld a, $04 ; $49bf
	farcall FarPtr_FaceActorsTowardEachOther ; $49c1
	ld a, $04 ; $49c4
	ld d, $03 ; $49c6
	farcall FarPtr_ScriptSetActorAnimation ; $49c8
	ld a, $04 ; $49cb
	farcall FarPtr_ScriptWaitActorIdle ; $49cd
	ld a, $05 ; $49d0
	ld bc, $1000 ; $49d2
	ld de, $1700 ; $49d5
	farcall FarPtr_ScriptSetActorMoveTarget ; $49d8
	ld a, $05 ; $49db
	farcall FarPtr_ScriptWaitActorMoveDone ; $49dd
	ld a, $05 ; $49e0
	ld b, $c0 ; $49e2
	farcall FarPtr_SetActorFacing ; $49e4
	test_flag $05, 7 ; $49e7
	jp nz, Label_27_4a88 ; $49ea
	ld a, $00 ; $49ed
	ld bc, $0020 ; $49ef
	farcall FarPtr_ScriptSetActorMoveSpeed ; $49f2
	ld a, $0a ; $49f5
	ld b, a ; $49f7
	ld a, $00 ; $49f8
	farcall FarPtr_FaceActorsTowardEachOther ; $49fa
	push af ; $49fd
	ld a, $1e ; $49fe
	farcall FarPtr_WaitScriptFrames ; $4a00
	pop af ; $4a03
	ld a, $00 ; $4a04
	ld b, $40 ; $4a06
	farcall FarPtr_SetActorFacing ; $4a08
	ld a, $0a ; $4a0b
	ld b, $40 ; $4a0d
	farcall FarPtr_SetActorFacing ; $4a0f
	ld a, $0a ; $4a12
	ld d, $03 ; $4a14
	farcall FarPtr_ScriptSetActorAnimation ; $4a16
	ld a, $00 ; $4a19
	ld d, $03 ; $4a1b
	farcall FarPtr_ScriptSetActorAnimation ; $4a1d
	ld a, $00 ; $4a20
	farcall FarPtr_ScriptWaitActorIdle ; $4a22
	ld a, $05 ; $4a25
	ld bc, $1300 ; $4a27
	ld de, $1700 ; $4a2a
	farcall FarPtr_ScriptSetActorMoveTarget ; $4a2d
	ld a, $05 ; $4a30
	farcall FarPtr_ScriptWaitActorMoveDone ; $4a32
	ldh a, [hRomBank] ; $4a35
	ld b, a ; $4a37
	ld a, $05 ; $4a38
	ld de, $4b67 ; $4a3a
	farcall FarPtr_ScriptSetActorScript ; $4a3d
	push af ; $4a40
	ld a, $14 ; $4a41
	farcall FarPtr_WaitScriptFrames ; $4a43
	pop af ; $4a46
	ldh a, [hRomBank] ; $4a47
	ld b, a ; $4a49
	ld a, $0a ; $4a4a
	ld de, $4b67 ; $4a4c
	farcall FarPtr_ScriptSetActorScript ; $4a4f
	push af ; $4a52
	ld a, $14 ; $4a53
	farcall FarPtr_WaitScriptFrames ; $4a55
	pop af ; $4a58
	ldh a, [hRomBank] ; $4a59
	ld b, a ; $4a5b
	ld a, $00 ; $4a5c
	ld de, $4b67 ; $4a5e
	farcall FarPtr_ScriptSetActorScript ; $4a61
	push af ; $4a64
	ld a, $14 ; $4a65
	farcall FarPtr_WaitScriptFrames ; $4a67
	pop af ; $4a6a
	xor a, a ; $4a6b
	ld bc, $1100 ; $4a6c
	ld de, $0d00 ; $4a6f
	farcall FarPtr_MovePlayerToPosition ; $4a72
	farcall FarPtr_WaitPlayerMoveDone ; $4a75
	push af ; $4a78
	ld a, $1e ; $4a79
	farcall FarPtr_WaitScriptFrames ; $4a7b
	pop af ; $4a7e
	ld a, $01 ; $4a7f
	ld [$c294], a ; $4a81
	ld [wStoryModeExitLocationRequest], a ; $4a84
	ret ; $4a87
Label_27_4a88:
	ld a, $02 ; $4a88
	ld b, a ; $4a8a
	ld a, $00 ; $4a8b
	farcall FarPtr_FaceActorsTowardEachOther ; $4a8d
	ld a, $00 ; $4a90
	ld bc, $0020 ; $4a92
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4a95
	ld a, $02 ; $4a98
	ld bc, $0020 ; $4a9a
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4a9d
	push af ; $4aa0
	ld a, $14 ; $4aa1
	farcall FarPtr_WaitScriptFrames ; $4aa3
	pop af ; $4aa6
	ld a, $02 ; $4aa7
	ld d, $03 ; $4aa9
	farcall FarPtr_ScriptSetActorAnimation ; $4aab
	ld a, $00 ; $4aae
	ld d, $03 ; $4ab0
	farcall FarPtr_ScriptSetActorAnimation ; $4ab2
	ld a, $00 ; $4ab5
	farcall FarPtr_ScriptWaitActorIdle ; $4ab7
	ld a, $00 ; $4aba
	ld b, $40 ; $4abc
	farcall FarPtr_SetActorFacing ; $4abe
	ld a, $02 ; $4ac1
	ld b, $40 ; $4ac3
	farcall FarPtr_SetActorFacing ; $4ac5
	ld a, $05 ; $4ac8
	ld bc, $1300 ; $4aca
	ld de, $1700 ; $4acd
	farcall FarPtr_ScriptSetActorMoveTarget ; $4ad0
	ld a, $05 ; $4ad3
	farcall FarPtr_ScriptWaitActorMoveDone ; $4ad5
	ldh a, [hRomBank] ; $4ad8
	ld b, a ; $4ada
	ld a, $05 ; $4adb
	ld de, $4b67 ; $4add
	farcall FarPtr_ScriptSetActorScript ; $4ae0
	push af ; $4ae3
	ld a, $14 ; $4ae4
	farcall FarPtr_WaitScriptFrames ; $4ae6
	pop af ; $4ae9
	ldh a, [hRomBank] ; $4aea
	ld b, a ; $4aec
	ld a, $00 ; $4aed
	ld de, $4b67 ; $4aef
	farcall FarPtr_ScriptSetActorScript ; $4af2
	push af ; $4af5
	ld a, $14 ; $4af6
	farcall FarPtr_WaitScriptFrames ; $4af8
	pop af ; $4afb
	ldh a, [hRomBank] ; $4afc
	ld b, a ; $4afe
	ld a, $02 ; $4aff
	ld de, $4b67 ; $4b01
	farcall FarPtr_ScriptSetActorScript ; $4b04
	push af ; $4b07
	ld a, $3c ; $4b08
	farcall FarPtr_WaitScriptFrames ; $4b0a
	pop af ; $4b0d
	ldh a, [hRomBank] ; $4b0e
	ld b, a ; $4b10
	ld a, $0b ; $4b11
	ld de, $4b80 ; $4b13
	farcall FarPtr_ScriptSetActorScript ; $4b16
	push af ; $4b19
	ld a, $14 ; $4b1a
	farcall FarPtr_WaitScriptFrames ; $4b1c
	pop af ; $4b1f
	ldh a, [hRomBank] ; $4b20
	ld b, a ; $4b22
	ld a, $0a ; $4b23
	ld de, $4b80 ; $4b25
	farcall FarPtr_ScriptSetActorScript ; $4b28
	xor a, a ; $4b2b
	ld bc, $1100 ; $4b2c
	ld de, $0d00 ; $4b2f
	farcall FarPtr_MovePlayerToPosition ; $4b32
	farcall FarPtr_WaitPlayerMoveDone ; $4b35
	ld a, $01 ; $4b38
	ld [$c294], a ; $4b3a
	ld [wStoryModeExitLocationRequest], a ; $4b3d
	ret ; $4b40
	INCBIN "data/bank_027/d_4b41.bin" ; $4b41, 123 bytes
End12PrincipalsOfficeMapScripts_27:
	; $4bbc, 14 bytes (map_tree)
	dw End12PrincipalsOfficeEntryPoints_27 ; slot 0 EntryPoints
	dw End12PrincipalsOfficeExitTriggers_27 ; slot 1 ExitTriggers
	dw End12PrincipalsOfficeActors_27 ; slot 2 Actors
	dw End12PrincipalsOfficeNpcScripts_27 ; slot 3 NpcScripts
	dw End12PrincipalsOfficeFacingScripts_27 ; slot 4 FacingScripts
	dw End12PrincipalsOfficeTileTriggers_27 ; slot 5 TileTriggers
	dw End12PrincipalsOfficeInitScript_27 ; slot 6 InitScript
End12PrincipalsOfficeActors_27:
	; $4bca, 122 bytes (map_actors)
	map_actor $0000, $785d, $fd00, $0100, $40, $4e, $01, $00
	map_actor $0000, $785d, $fd00, $0100, $40, $53, $01, $00
	map_actor $0000, $785d, $fd00, $0100, $40, $51, $01, $00
	map_actor $0000, $785d, $fd00, $0100, $40, $53, $01, $00
	map_actor $0000, $785d, $2000, $2f00, $40, $63, $01, $00
	map_actor $0000, $785d, $2200, $3300, $80, $4b, $01, $00
	map_actor $0000, $785d, $2000, $3300, $80, $4a, $01, $00
	map_actor $0000, $785d, $1e00, $3300, $00, $49, $01, $00
	map_actor_end
End12PrincipalsOfficeEntryPoints_27:
	; $4c44, 17 bytes (map_entries)
	map_entry $01, $80, $1f00, $3b00, $0000
	map_entry $02, $80, $1f00, $3b00, $0000
	db $ff
End12PrincipalsOfficeExitTriggers_27:
	; $4c55, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_27, $14, $01
	db $ff
End12PrincipalsOfficeNpcScripts_27:
	ds 1, $ff ; $4c5e, fill
End12PrincipalsOfficeFacingScripts_27:
	ds 1, $ff ; $4c5f, fill
End12PrincipalsOfficeTileTriggers_27:
	ds 1, $ff ; $4c60, fill
End12PrincipalsOfficeInitScript_27:
	ld a, $16 ; $4c61
	ld [$c329], a ; $4c63
	ld a, $28 ; $4c66
	ld [$c32a], a ; $4c68
	ld a, $40 ; $4c6b
	ld [$c32b], a ; $4c6d
	ld a, $3e ; $4c70
	ld [$c32c], a ; $4c72
	call DisableLCDSafely ; $4c75
	ld a, $00 ; $4c78
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $4c7a
	call EnableLCD ; $4c7d
	ld a, [wStoryModeEntryPoint] ; $4c80
	cp a, $02 ; $4c83
	jp z, Label_27_4ff0 ; $4c85
	jp Label_27_4c8c ; $4c88
	ret ; $4c8b
Label_27_4c8c:
	xor a, a ; $4c8c
	ld [wStoryModeShowLocationName], a ; $4c8d
	ld a, $00 ; $4c90
	ld bc, $2b00 ; $4c92
	ld de, $3b00 ; $4c95
	farcall FarPtr_ScriptSetActorPosition ; $4c98
	ld a, $02 ; $4c9b
	ld bc, $2b00 ; $4c9d
	ld de, $3b00 ; $4ca0
	farcall FarPtr_ScriptSetActorPosition ; $4ca3
	ld c, $04 ; $4ca6
	call BeginFadeIn ; $4ca8
	ld a, $14 ; $4cab
	call Func_27_7856 ; $4cad
	ld a, $07 ; $4cb0
	ld bc, $1e00 ; $4cb2
	ld de, $2f00 ; $4cb5
	farcall FarPtr_ScriptSetActorMoveTarget ; $4cb8
	ld a, $07 ; $4cbb
	farcall FarPtr_ScriptWaitActorMoveDone ; $4cbd
	ld a, $07 ; $4cc0
	ld b, $40 ; $4cc2
	farcall FarPtr_SetActorFacing ; $4cc4
	ld a, $1e ; $4cc7
	call Func_27_7856 ; $4cc9
	ld a, $07 ; $4ccc
	ld bc, $2200 ; $4cce
	ld de, $2f00 ; $4cd1
	farcall FarPtr_ScriptSetActorMoveTarget ; $4cd4
	ld a, $07 ; $4cd7
	farcall FarPtr_ScriptWaitActorMoveDone ; $4cd9
	ld a, $07 ; $4cdc
	ld b, $40 ; $4cde
	farcall FarPtr_SetActorFacing ; $4ce0
	ld a, $1e ; $4ce3
	call Func_27_7856 ; $4ce5
	ld a, $07 ; $4ce8
	ld bc, $2000 ; $4cea
	ld de, $2f00 ; $4ced
	farcall FarPtr_ScriptSetActorMoveTarget ; $4cf0
	ld a, $07 ; $4cf3
	farcall FarPtr_ScriptWaitActorMoveDone ; $4cf5
	ld a, $07 ; $4cf8
	ld b, $40 ; $4cfa
	farcall FarPtr_SetActorFacing ; $4cfc
	ld a, $0a ; $4cff
	call Func_27_7856 ; $4d01
	ld a, $07 ; $4d04
	ld d, $02 ; $4d06
	farcall FarPtr_ScriptSetActorAnimation ; $4d08
	ld a, $07 ; $4d0b
	farcall FarPtr_ScriptWaitActorIdle ; $4d0d
	ld a, $08 ; $4d10
	ld b, $c0 ; $4d12
	farcall FarPtr_SetActorFacing ; $4d14
	ld a, $09 ; $4d17
	ld b, $c0 ; $4d19
	farcall FarPtr_SetActorFacing ; $4d1b
	ld a, $0a ; $4d1e
	ld b, $c0 ; $4d20
	farcall FarPtr_SetActorFacing ; $4d22
	sound $96 ; $4d25
	ld a, $04 ; $4d27
	ld bc, $1f80 ; $4d29
	ld de, $3180 ; $4d2c
	farcall FarPtr_ScriptSetActorPosition ; $4d2f
	ld a, $28 ; $4d32
	call Func_27_7856 ; $4d34
	sound $96 ; $4d37
	ld a, $06 ; $4d39
	ld bc, $2180 ; $4d3b
	ld de, $3180 ; $4d3e
	farcall FarPtr_ScriptSetActorPosition ; $4d41
	ld a, $28 ; $4d44
	call Func_27_7856 ; $4d46
	sound $96 ; $4d49
	ld a, $04 ; $4d4b
	ld bc, $2380 ; $4d4d
	ld de, $3180 ; $4d50
	farcall FarPtr_ScriptSetActorPosition ; $4d53
	ld a, $28 ; $4d56
	call Func_27_7856 ; $4d58
	ld a, $06 ; $4d5b
	ld bc, $3f00 ; $4d5d
	ld de, $3f00 ; $4d60
	farcall FarPtr_ScriptSetActorPosition ; $4d63
	ld a, $28 ; $4d66
	call Func_27_7856 ; $4d68
	ld a, $04 ; $4d6b
	ld bc, $3f00 ; $4d6d
	ld de, $3f00 ; $4d70
	farcall FarPtr_ScriptSetActorPosition ; $4d73
	test_flag $05, 7 ; $4d76
	jp z, Label_27_4e13 ; $4d79
	ld a, $02 ; $4d7c
	farcall FarPtr_SetActorNullScript ; $4d7e
	ld a, $02 ; $4d81
	ld bc, $2d00 ; $4d83
	ld de, $3b00 ; $4d86
	farcall FarPtr_ScriptSetActorPosition ; $4d89
	ld a, $00 ; $4d8c
	ld bc, $2100 ; $4d8e
	ld de, $3b00 ; $4d91
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d94
	ld a, $02 ; $4d97
	ld bc, $2300 ; $4d99
	ld de, $3b00 ; $4d9c
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d9f
	ld a, $02 ; $4da2
	farcall FarPtr_ScriptWaitActorMoveDone ; $4da4
	push af ; $4da7
	ld a, $05 ; $4da8
	farcall FarPtr_WaitScriptFrames ; $4daa
	pop af ; $4dad
	ld a, $00 ; $4dae
	ld b, $c0 ; $4db0
	farcall FarPtr_SetActorFacing ; $4db2
	call Func_27_516b ; $4db5
	ld a, $00 ; $4db8
	ld bc, $2100 ; $4dba
	ld de, $3500 ; $4dbd
	farcall FarPtr_ScriptSetActorMoveTarget ; $4dc0
	ld a, $02 ; $4dc3
	ld bc, $2100 ; $4dc5
	ld de, $3b00 ; $4dc8
	farcall FarPtr_ScriptSetActorMoveTarget ; $4dcb
	ld a, $02 ; $4dce
	farcall FarPtr_ScriptWaitActorMoveDone ; $4dd0
	ld a, $00 ; $4dd3
	ld bc, $1f00 ; $4dd5
	ld de, $3500 ; $4dd8
	farcall FarPtr_ScriptSetActorMoveTarget ; $4ddb
	ld a, $02 ; $4dde
	ld bc, $2100 ; $4de0
	ld de, $3500 ; $4de3
	farcall FarPtr_ScriptSetActorMoveTarget ; $4de6
	ld a, $02 ; $4de9
	farcall FarPtr_ScriptWaitActorMoveDone ; $4deb
	ld a, $02 ; $4dee
	ld bc, $2100 ; $4df0
	ld de, $3500 ; $4df3
	farcall FarPtr_ScriptSetActorMoveTarget ; $4df6
	ld a, $02 ; $4df9
	farcall FarPtr_ScriptWaitActorMoveDone ; $4dfb
	ld a, $00 ; $4dfe
	ld b, $c0 ; $4e00
	farcall FarPtr_SetActorFacing ; $4e02
	ld a, $02 ; $4e05
	ld b, $c0 ; $4e07
	farcall FarPtr_SetActorFacing ; $4e09
	ld a, $01 ; $4e0c
	call Func_27_7856 ; $4e0e
	jr Label_27_4e59 ; $4e11
Label_27_4e13:
	ld a, $00 ; $4e13
	ld bc, $2100 ; $4e15
	ld de, $3b00 ; $4e18
	farcall FarPtr_ScriptSetActorMoveTarget ; $4e1b
	ld a, $00 ; $4e1e
	farcall FarPtr_ScriptWaitActorMoveDone ; $4e20
	ld a, $00 ; $4e23
	ld b, $c0 ; $4e25
	farcall FarPtr_SetActorFacing ; $4e27
	call Func_27_516b ; $4e2a
	ld a, $00 ; $4e2d
	ld bc, $2100 ; $4e2f
	ld de, $3500 ; $4e32
	farcall FarPtr_ScriptSetActorMoveTarget ; $4e35
	ld a, $00 ; $4e38
	farcall FarPtr_ScriptWaitActorMoveDone ; $4e3a
	ld a, $00 ; $4e3d
	ld bc, $2000 ; $4e3f
	ld de, $3500 ; $4e42
	farcall FarPtr_ScriptSetActorMoveTarget ; $4e45
	ld a, $00 ; $4e48
	farcall FarPtr_ScriptWaitActorMoveDone ; $4e4a
	ld a, $00 ; $4e4d
	ld b, $c0 ; $4e4f
	farcall FarPtr_SetActorFacing ; $4e51
	ld a, $01 ; $4e54
	call Func_27_7856 ; $4e56
Label_27_4e59:
	call Func_27_51a1 ; $4e59
	ld a, $07 ; $4e5c
	ld d, $02 ; $4e5e
	farcall FarPtr_ScriptSetActorAnimation ; $4e60
	ld a, $08 ; $4e63
	ld d, $02 ; $4e65
	farcall FarPtr_ScriptSetActorAnimation ; $4e67
	ld a, $09 ; $4e6a
	ld d, $02 ; $4e6c
	farcall FarPtr_ScriptSetActorAnimation ; $4e6e
	ld a, $0a ; $4e71
	ld d, $02 ; $4e73
	farcall FarPtr_ScriptSetActorAnimation ; $4e75
	ld a, $0a ; $4e78
	farcall FarPtr_ScriptWaitActorIdle ; $4e7a
	ld a, $1e ; $4e7d
	call Func_27_7856 ; $4e7f
	ld a, $0a ; $4e82
	ld bc, $1d00 ; $4e84
	ld de, $3500 ; $4e87
	farcall FarPtr_ScriptSetActorMoveTarget ; $4e8a
	ld a, $09 ; $4e8d
	ld bc, $2300 ; $4e8f
	ld de, $3500 ; $4e92
	farcall FarPtr_ScriptSetActorMoveTarget ; $4e95
	ld a, $08 ; $4e98
	ld bc, $2500 ; $4e9a
	ld de, $3500 ; $4e9d
	farcall FarPtr_ScriptSetActorMoveTarget ; $4ea0
	ld a, $08 ; $4ea3
	farcall FarPtr_ScriptWaitActorMoveDone ; $4ea5
	ld a, $0a ; $4ea8
	ld b, $00 ; $4eaa
	farcall FarPtr_SetActorFacing ; $4eac
	ld a, $09 ; $4eaf
	ld b, $80 ; $4eb1
	farcall FarPtr_SetActorFacing ; $4eb3
	ld a, $08 ; $4eb6
	ld b, $80 ; $4eb8
	farcall FarPtr_SetActorFacing ; $4eba
	ld a, $0a ; $4ebd
	call Func_27_7856 ; $4ebf
	test_flag $05, 7 ; $4ec2
	jp z, Label_27_4f62 ; $4ec5
	ld a, $3c ; $4ec8
	call Func_27_7856 ; $4eca
	ld a, $02 ; $4ecd
	ld b, a ; $4ecf
	ld a, $00 ; $4ed0
	farcall FarPtr_FaceActorTowardActor ; $4ed2
	ld a, $00 ; $4ed5
	ld d, $02 ; $4ed7
	farcall FarPtr_ScriptSetActorAnimation ; $4ed9
	ld a, $00 ; $4edc
	farcall FarPtr_ScriptWaitActorIdle ; $4ede
	ld a, $14 ; $4ee1
	call Func_27_7856 ; $4ee3
	ld a, $00 ; $4ee6
	ld b, a ; $4ee8
	ld a, $02 ; $4ee9
	farcall FarPtr_FaceActorTowardActor ; $4eeb
	ld a, $01 ; $4eee
	call Func_27_7856 ; $4ef0
	ld a, $02 ; $4ef3
	ld d, $03 ; $4ef5
	farcall FarPtr_ScriptSetActorAnimation ; $4ef7
	ld a, $02 ; $4efa
	farcall FarPtr_ScriptWaitActorIdle ; $4efc
	ld a, $14 ; $4eff
	call Func_27_7856 ; $4f01
	ld a, $00 ; $4f04
	ld b, $c0 ; $4f06
	farcall FarPtr_SetActorFacing ; $4f08
	ld a, $02 ; $4f0b
	ld b, $c0 ; $4f0d
	farcall FarPtr_SetActorFacing ; $4f0f
	ld a, $08 ; $4f12
	ld d, $03 ; $4f14
	farcall FarPtr_ScriptSetActorAnimation ; $4f16
	ld a, $09 ; $4f19
	ld d, $03 ; $4f1b
	farcall FarPtr_ScriptSetActorAnimation ; $4f1d
	ld a, $0a ; $4f20
	ld d, $03 ; $4f22
	farcall FarPtr_ScriptSetActorAnimation ; $4f24
	ld a, $0a ; $4f27
	farcall FarPtr_ScriptWaitActorIdle ; $4f29
	ld a, $28 ; $4f2c
	call Func_27_7856 ; $4f2e
	ld a, $00 ; $4f31
	ld d, $03 ; $4f33
	farcall FarPtr_ScriptSetActorAnimation ; $4f35
	ld a, $02 ; $4f38
	ld d, $03 ; $4f3a
	farcall FarPtr_ScriptSetActorAnimation ; $4f3c
	ld a, $02 ; $4f3f
	farcall FarPtr_ScriptWaitActorIdle ; $4f41
	ld a, $00 ; $4f44
	ld bc, $1f00 ; $4f46
	ld de, $3200 ; $4f49
	farcall FarPtr_ScriptSetActorMoveTarget ; $4f4c
	ld a, $02 ; $4f4f
	ld bc, $2100 ; $4f51
	ld de, $3200 ; $4f54
	farcall FarPtr_ScriptSetActorMoveTarget ; $4f57
	ld a, $02 ; $4f5a
	farcall FarPtr_ScriptWaitActorMoveDone ; $4f5c
	jp Label_27_4fe7 ; $4f5f
Label_27_4f62:
	sound $96 ; $4f62
	ld a, $04 ; $4f64
	ld bc, $2180 ; $4f66
	ld de, $3380 ; $4f69
	farcall FarPtr_ScriptSetActorPosition ; $4f6c
	ld a, $50 ; $4f6f
	call Func_27_7856 ; $4f71
	ld a, $04 ; $4f74
	ld bc, $3f00 ; $4f76
	ld de, $3f00 ; $4f79
	farcall FarPtr_ScriptSetActorPosition ; $4f7c
	ld a, $0a ; $4f7f
	ld b, a ; $4f81
	ld a, $00 ; $4f82
	farcall FarPtr_FaceActorTowardActor ; $4f84
	ld a, $28 ; $4f87
	call Func_27_7856 ; $4f89
	ld a, $00 ; $4f8c
	ld b, a ; $4f8e
	ld a, $0a ; $4f8f
	farcall FarPtr_FaceActorTowardActor ; $4f91
	ld a, $01 ; $4f94
	call Func_27_7856 ; $4f96
	ld a, $0a ; $4f99
	ld d, $03 ; $4f9b
	farcall FarPtr_ScriptSetActorAnimation ; $4f9d
	ld a, $0a ; $4fa0
	farcall FarPtr_ScriptWaitActorIdle ; $4fa2
	ld a, $14 ; $4fa5
	call Func_27_7856 ; $4fa7
	ld a, $00 ; $4faa
	ld b, $c0 ; $4fac
	farcall FarPtr_SetActorFacing ; $4fae
	ld a, $08 ; $4fb1
	ld d, $03 ; $4fb3
	farcall FarPtr_ScriptSetActorAnimation ; $4fb5
	ld a, $09 ; $4fb8
	ld d, $03 ; $4fba
	farcall FarPtr_ScriptSetActorAnimation ; $4fbc
	ld a, $0a ; $4fbf
	ld d, $03 ; $4fc1
	farcall FarPtr_ScriptSetActorAnimation ; $4fc3
	ld a, $0a ; $4fc6
	farcall FarPtr_ScriptWaitActorIdle ; $4fc8
	ld a, $28 ; $4fcb
	call Func_27_7856 ; $4fcd
	ld a, $00 ; $4fd0
	ld d, $03 ; $4fd2
	farcall FarPtr_ScriptSetActorAnimation ; $4fd4
	ld a, $00 ; $4fd7
	ld bc, $2000 ; $4fd9
	ld de, $3200 ; $4fdc
	farcall FarPtr_ScriptSetActorMoveTarget ; $4fdf
	ld a, $00 ; $4fe2
	farcall FarPtr_ScriptWaitActorMoveDone ; $4fe4
Label_27_4fe7:
	ld a, $01 ; $4fe7
	ld [$c294], a ; $4fe9
	ld [wStoryModeExitLocationRequest], a ; $4fec
	ret ; $4fef
Label_27_4ff0:
	ldh a, [hRomBank] ; $4ff0
	ld hl, $51dd ; $4ff2
	farcall FarPtr_ScriptRespawnLocationActors ; $4ff5
	farcall FarPtr_BeginCutsceneScriptMode ; $4ff8
	ld a, $04 ; $4ffb
	ld d, $06 ; $4ffd
	farcall FarPtr_ScriptSetActorAnimation ; $4fff
	test_flag $05, 7 ; $5002
	jp z, Label_27_503c ; $5005
	ld a, $02 ; $5008
	farcall FarPtr_SetActorNullScript ; $500a
	ld a, $00 ; $500d
	ld bc, $1f00 ; $500f
	ld de, $3400 ; $5012
	farcall FarPtr_ScriptSetActorPosition ; $5015
	ld a, $02 ; $5018
	ld bc, $2100 ; $501a
	ld de, $3400 ; $501d
	farcall FarPtr_ScriptSetActorPosition ; $5020
	ld a, $02 ; $5023
	ld b, $c0 ; $5025
	farcall FarPtr_SetActorFacing ; $5027
	test_flag $07, 4 ; $502a
	jr nz, Label_27_5057 ; $502d
	ld a, $04 ; $502f
	ld bc, $3f00 ; $5031
	ld de, $3f00 ; $5034
	farcall FarPtr_ScriptSetActorPosition ; $5037
	jr Label_27_5057 ; $503a
Label_27_503c:
	ld a, $00 ; $503c
	ld bc, $2000 ; $503e
	ld de, $3400 ; $5041
	farcall FarPtr_ScriptSetActorPosition ; $5044
	test_flag $06, 5 ; $5047
	jr nz, Label_27_5057 ; $504a
	ld a, $05 ; $504c
	ld bc, $3f00 ; $504e
	ld de, $3f00 ; $5051
	farcall FarPtr_ScriptSetActorPosition ; $5054
Label_27_5057:
	ld a, $00 ; $5057
	ld b, $c0 ; $5059
	farcall FarPtr_SetActorFacing ; $505b
	xor a, a ; $505e
	ld [wStoryModeShowLocationName], a ; $505f
	ld c, $04 ; $5062
	call BeginFadeIn ; $5064
	call WaitFadeEnd ; $5067
	test_flag $05, 7 ; $506a
	jp z, Label_27_50ff ; $506d
	ld a, $00 ; $5070
	ld d, $03 ; $5072
	farcall FarPtr_ScriptSetActorAnimation ; $5074
	ld a, $00 ; $5077
	farcall FarPtr_ScriptWaitActorIdle ; $5079
	ld a, $03 ; $507c
	ld d, $03 ; $507e
	farcall FarPtr_ScriptSetActorAnimation ; $5080
	ld a, $03 ; $5083
	farcall FarPtr_ScriptWaitActorIdle ; $5085
	ld a, $3c ; $5088
	call Func_27_7856 ; $508a
	ld a, $02 ; $508d
	ld b, a ; $508f
	ld a, $00 ; $5090
	farcall FarPtr_FaceActorsTowardEachOther ; $5092
	ld a, $1e ; $5095
	call Func_27_7856 ; $5097
	ld a, $00 ; $509a
	ld d, $03 ; $509c
	farcall FarPtr_ScriptSetActorAnimation ; $509e
	ld a, $02 ; $50a1
	ld d, $03 ; $50a3
	farcall FarPtr_ScriptSetActorAnimation ; $50a5
	ld a, $02 ; $50a8
	farcall FarPtr_ScriptWaitActorIdle ; $50aa
	ld a, $02 ; $50ad
	ld b, $40 ; $50af
	farcall FarPtr_SetActorFacing ; $50b1
	ld a, $00 ; $50b4
	ld bc, $2100 ; $50b6
	ld de, $3600 ; $50b9
	farcall FarPtr_ScriptSetActorMoveTarget ; $50bc
	ld a, $00 ; $50bf
	farcall FarPtr_ScriptWaitActorMoveDone ; $50c1
	ld a, $00 ; $50c4
	ld bc, $2100 ; $50c6
	ld de, $3700 ; $50c9
	farcall FarPtr_ScriptSetActorMoveTarget ; $50cc
	ld a, $02 ; $50cf
	ld bc, $2100 ; $50d1
	ld de, $3500 ; $50d4
	farcall FarPtr_ScriptSetActorMoveTarget ; $50d7
	ld a, $02 ; $50da
	farcall FarPtr_ScriptWaitActorMoveDone ; $50dc
	call Func_27_516b ; $50df
	ldh a, [hRomBank] ; $50e2
	ld b, a ; $50e4
	ld a, $00 ; $50e5
	ld de, SceneFrameDataHi_27 ; $50e7
	farcall FarPtr_ScriptSetActorScript ; $50ea
	ldh a, [hRomBank] ; $50ed
	ld b, a ; $50ef
	ld a, $02 ; $50f0
	ld de, SceneFrameDataHi_27 ; $50f2
	farcall FarPtr_ScriptSetActorScript ; $50f5
	ld a, $14 ; $50f8
	call Func_27_7856 ; $50fa
	jr Label_27_514f ; $50fd
Label_27_50ff:
	ld a, $00 ; $50ff
	ld d, $03 ; $5101
	farcall FarPtr_ScriptSetActorAnimation ; $5103
	ld a, $00 ; $5106
	farcall FarPtr_ScriptWaitActorIdle ; $5108
	ld a, $03 ; $510b
	ld d, $03 ; $510d
	farcall FarPtr_ScriptSetActorAnimation ; $510f
	ld a, $03 ; $5112
	farcall FarPtr_ScriptWaitActorIdle ; $5114
	ld a, $3c ; $5117
	call Func_27_7856 ; $5119
	ld a, $00 ; $511c
	ld bc, $2100 ; $511e
	ld de, $3400 ; $5121
	farcall FarPtr_ScriptSetActorMoveTarget ; $5124
	ld a, $00 ; $5127
	farcall FarPtr_ScriptWaitActorMoveDone ; $5129
	ld a, $00 ; $512c
	ld bc, $2100 ; $512e
	ld de, $3700 ; $5131
	farcall FarPtr_ScriptSetActorMoveTarget ; $5134
	ld a, $00 ; $5137
	farcall FarPtr_ScriptWaitActorMoveDone ; $5139
	call Func_27_516b ; $513c
	ldh a, [hRomBank] ; $513f
	ld b, a ; $5141
	ld a, $00 ; $5142
	ld de, SceneFrameDataHi_27 ; $5144
	farcall FarPtr_ScriptSetActorScript ; $5147
	ld a, $14 ; $514a
	call Func_27_7856 ; $514c
Label_27_514f:
	call Func_27_51a1 ; $514f
	ld a, $3c ; $5152
	call Func_27_7856 ; $5154
	set_flag $0d, 5 ; $5157
	ld c, $04 ; $515a
	call BeginFadeOut ; $515c
	call WaitFadeEnd ; $515f
	ld a, $01 ; $5162
	ld [$c294], a ; $5164
	ld [wStoryModeExitLocationRequest], a ; $5167
	ret ; $516a
Func_27_516b:
	push af ; $516b
	ld a, $0a ; $516c
	farcall FarPtr_WaitScriptFrames ; $516e
	pop af ; $5171
	sound $79 ; $5172
	ld b, $07 ; $5174
	ld c, $38 ; $5176
	ld d, $20 ; $5178
	ld e, $38 ; $517a
	ld h, $02 ; $517c
	ld l, $02 ; $517e
	farcall FarPtr_CopySceneTilemapRect ; $5180
	push af ; $5183
	ld a, $02 ; $5184
	farcall FarPtr_WaitScriptFrames ; $5186
	pop af ; $5189
	ld b, $0b ; $518a
	ld c, $38 ; $518c
	ld d, $20 ; $518e
	ld e, $38 ; $5190
	ld h, $02 ; $5192
	ld l, $02 ; $5194
	farcall FarPtr_CopySceneTilemapRect ; $5196
	push af ; $5199
	ld a, $04 ; $519a
	farcall FarPtr_WaitScriptFrames ; $519c
	pop af ; $519f
	ret ; $51a0
Func_27_51a1:
	sound $79 ; $51a1
	ld b, $07 ; $51a3
	ld c, $38 ; $51a5
	ld d, $20 ; $51a7
	ld e, $38 ; $51a9
	ld h, $02 ; $51ab
	ld l, $02 ; $51ad
	farcall FarPtr_CopySceneTilemapRect ; $51af
	push af ; $51b2
	ld a, $02 ; $51b3
	farcall FarPtr_WaitScriptFrames ; $51b5
	pop af ; $51b8
	ld b, $03 ; $51b9
	ld c, $38 ; $51bb
	ld d, $20 ; $51bd
	ld e, $38 ; $51bf
	ld h, $02 ; $51c1
	ld l, $02 ; $51c3
	farcall FarPtr_CopySceneTilemapRect ; $51c5
	push af ; $51c8
	ld a, $04 ; $51c9
	farcall FarPtr_WaitScriptFrames ; $51cb
	pop af ; $51ce
	ret ; $51cf
SceneFrameDataHi_27:
	INCBIN "data/bank_027/d_51d0.bin" ; $51d0, 65 bytes
End11TrainingCourtMapScripts_27:
	; $5211, 14 bytes (map_tree)
	dw End11TrainingCourtEntryPoints_27 ; slot 0 EntryPoints
	dw End11TrainingCourtExitTriggers_27 ; slot 1 ExitTriggers
	dw End11TrainingCourtActors_27 ; slot 2 Actors
	dw End11TrainingCourtNpcScripts_27 ; slot 3 NpcScripts
	dw End11TrainingCourtFacingScripts_27 ; slot 4 FacingScripts
	dw End11TrainingCourtTileTriggers_27 ; slot 5 TileTriggers
	dw End11TrainingCourtInitScript_27 ; slot 6 InitScript
End11TrainingCourtActors_27:
	; $521f, 52 bytes (map_actors)
	map_actor $0000, $785d, $3f00, $0500, $40, $6c, $01, $00
	map_actor $0000, $785d, $3f00, $0500, $40, $4d, $01, $00
	map_actor $0000, $785d, $3f00, $0500, $40, $4c, $01, $00
	map_actor_end
End11TrainingCourtEntryPoints_27:
	; $5253, 17 bytes (map_entries)
	map_entry $01, $40, $3300, $0d00, $0000
	map_entry $02, $c0, $1800, $1100, $0000
	db $ff
End11TrainingCourtExitTriggers_27:
	; $5264, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_27, $08, $00
	db $ff
End11TrainingCourtNpcScripts_27:
	ds 1, $ff ; $526d, fill
End11TrainingCourtFacingScripts_27:
	ds 1, $ff ; $526e, fill
End11TrainingCourtTileTriggers_27:
	ds 1, $ff ; $526f, fill
End11TrainingCourtInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $5270
	cp a, $01 ; $5273
	jp z, Label_27_527e ; $5275
	cp a, $02 ; $5278
	jp z, Label_27_53f9 ; $527a
	ret ; $527d
Label_27_527e:
	test_flag $05, 7 ; $527e
	jr z, Label_27_5299 ; $5281
	ldh a, [hRomBank] ; $5283
	ld b, a ; $5285
	ld a, $02 ; $5286
	ld de, $785d ; $5288
	farcall FarPtr_ScriptSetActorScript ; $528b
	ld a, $02 ; $528e
	ld bc, $3f00 ; $5290
	ld de, $3f00 ; $5293
	farcall FarPtr_ScriptSetActorPosition ; $5296
Label_27_5299:
	ld a, [$c90e] ; $5299
	and a, a ; $529c
	jr z, Label_27_52ae ; $529d
	ld a, $00 ; $529f
	farcall FarPtr_GetActorStateAddr ; $52a1
	ld c, l ; $52a4
	ld b, h ; $52a5
	ld hl, $0037 ; $52a6
	add hl, bc ; $52a9
	ld a, [hl] ; $52aa
	xor a, $20 ; $52ab
	ld [hl], a ; $52ad
Label_27_52ae:
	ld a, $00 ; $52ae
	ld b, $40 ; $52b0
	farcall FarPtr_SetActorFacing ; $52b2
	ldh a, [hRomBank] ; $52b5
	ld b, a ; $52b7
	ld a, $00 ; $52b8
	ld de, $555e ; $52ba
	farcall FarPtr_ScriptSetActorScript ; $52bd
	xor a, a ; $52c0
	ld [wStoryModeShowLocationName], a ; $52c1
	ld c, $04 ; $52c4
	call BeginFadeIn ; $52c6
	ld a, $78 ; $52c9
	call Func_27_7856 ; $52cb
	ld a, $00 ; $52ce
	farcall FarPtr_GetActorStateAddr ; $52d0
	ld a, $01 ; $52d3
	ld e, l ; $52d5
	ld d, h ; $52d6
	ld hl, $0018 ; $52d7
	add hl, de ; $52da
	ld [hl], a ; $52db
	ld a, $00 ; $52dc
	ld d, $02 ; $52de
	farcall FarPtr_ScriptSetActorAnimation ; $52e0
	ld a, $00 ; $52e3
	farcall FarPtr_ScriptWaitActorIdle ; $52e5
	ld a, $00 ; $52e8
	farcall FarPtr_SetActorNullScript ; $52ea
	ld a, $00 ; $52ed
	ld d, $01 ; $52ef
	farcall FarPtr_ScriptSetActorAnimation ; $52f1
	ld a, $3c ; $52f4
	call Func_27_7856 ; $52f6
	ld a, $00 ; $52f9
	ld b, $80 ; $52fb
	farcall FarPtr_SetActorFacing ; $52fd
	ld a, $1e ; $5300
	call Func_27_7856 ; $5302
	ld a, $00 ; $5305
	ld b, $00 ; $5307
	farcall FarPtr_SetActorFacing ; $5309
	ld a, $1e ; $530c
	call Func_27_7856 ; $530e
	ld a, $00 ; $5311
	ld b, $80 ; $5313
	farcall FarPtr_SetActorFacing ; $5315
	ld a, $1e ; $5318
	call Func_27_7856 ; $531a
	ld a, $00 ; $531d
	ld b, $00 ; $531f
	farcall FarPtr_SetActorFacing ; $5321
	ld a, $1e ; $5324
	call Func_27_7856 ; $5326
	ld a, $00 ; $5329
	ld b, $40 ; $532b
	farcall FarPtr_SetActorFacing ; $532d
	ld a, $1e ; $5330
	call Func_27_7856 ; $5332
	sound $98 ; $5335
	ld a, $04 ; $5337
	ld bc, $3480 ; $5339
	ld de, $0b80 ; $533c
	farcall FarPtr_ScriptSetActorPosition ; $533f
	ld a, $3c ; $5342
	call Func_27_7856 ; $5344
	ld a, $03 ; $5347
	ld bc, $3300 ; $5349
	ld de, $0700 ; $534c
	farcall FarPtr_ScriptSetActorPosition ; $534f
	ld a, $03 ; $5352
	ld b, $00 ; $5354
	farcall FarPtr_SetActorActive ; $5356
	ld bc, $0010 ; $5359
	farcall FarPtr_SetPlayerMoveSpeed ; $535c
	ld a, $03 ; $535f
	ld b, $00 ; $5361
	farcall FarPtr_MovePlayerToActor ; $5363
	ld hl, $5580 ; $5366
	ld de, $0206 ; $5369
	call LoadPalettesImmediate ; $536c
	ld a, $1e ; $536f
	call Func_27_7856 ; $5371
	ld hl, $55c0 ; $5374
	ld de, $0206 ; $5377
	call LoadPalettesImmediate ; $537a
	ld a, $10 ; $537d
Label_27_537f:
	ld d, a ; $537f
	ld a, $03 ; $5380
	ld b, $02 ; $5382
	farcall FarPtr_SetActorActive ; $5384
	push af ; $5387
	ld a, $04 ; $5388
	farcall FarPtr_WaitScriptFrames ; $538a
	pop af ; $538d
	ld a, $03 ; $538e
	ld b, $00 ; $5390
	farcall FarPtr_SetActorActive ; $5392
	push af ; $5395
	ld a, d ; $5396
	farcall FarPtr_WaitScriptFrames ; $5397
	pop af ; $539a
	ld a, d ; $539b
	sub a, $02 ; $539c
	jp nz, Label_27_537f ; $539e
	ld a, $03 ; $53a1
	ld b, $02 ; $53a3
	farcall FarPtr_SetActorActive ; $53a5
	ld a, $3c ; $53a8
	call Func_27_7856 ; $53aa
	ld a, $04 ; $53ad
	ld bc, $3f00 ; $53af
	ld de, $3f00 ; $53b2
	farcall FarPtr_ScriptSetActorPosition ; $53b5
	ld a, $00 ; $53b8
	ld b, $c0 ; $53ba
	farcall FarPtr_SetActorFacing ; $53bc
	ld a, $1e ; $53bf
	call Func_27_7856 ; $53c1
	sound $97 ; $53c4
	ld a, $05 ; $53c6
	ld bc, $3480 ; $53c8
	ld de, $0b80 ; $53cb
	farcall FarPtr_ScriptSetActorPosition ; $53ce
	ld a, $14 ; $53d1
	call Func_27_7856 ; $53d3
	ld a, $05 ; $53d6
	ld de, rLCDC ; $53d8
	farcall FarPtr_ScriptSetActorJumpVelocity ; $53db
	ld a, $00 ; $53de
	ld de, rLCDC ; $53e0
	farcall FarPtr_ScriptSetActorJumpVelocity ; $53e3
	ld a, $00 ; $53e6
	farcall FarPtr_ScriptWaitActorJumpDone ; $53e8
	ld a, $1e ; $53eb
	call Func_27_7856 ; $53ed
	ld a, $01 ; $53f0
	ld [$c294], a ; $53f2
	ld [wStoryModeExitLocationRequest], a ; $53f5
	ret ; $53f8
Label_27_53f9:
	ldh a, [hRomBank] ; $53f9
	ld hl, $5507 ; $53fb
	farcall FarPtr_ScriptRespawnLocationActors ; $53fe
	ld a, $00 ; $5401
	ld bc, $1800 ; $5403
	ld de, $1100 ; $5406
	farcall FarPtr_ScriptSetActorPosition ; $5409
	farcall FarPtr_BeginCutsceneScriptMode ; $540c
	ld a, $00 ; $540f
	ld b, $c0 ; $5411
	farcall FarPtr_SetActorFacing ; $5413
	ld a, $06 ; $5416
	ld bc, $1800 ; $5418
	ld de, $0d00 ; $541b
	farcall FarPtr_ScriptSetActorPosition ; $541e
	ld a, $06 ; $5421
	ld b, $40 ; $5423
	farcall FarPtr_SetActorFacing ; $5425
	ld a, $02 ; $5428
	farcall FarPtr_SetActorNullScript ; $542a
	ld a, $02 ; $542d
	ld bc, $1300 ; $542f
	ld de, $1100 ; $5432
	farcall FarPtr_ScriptSetActorPosition ; $5435
	ld a, $02 ; $5438
	ld b, $00 ; $543a
	farcall FarPtr_SetActorFacing ; $543c
	xor a, a ; $543f
	ld bc, $1800 ; $5440
	ld de, $0f00 ; $5443
	farcall FarPtr_MovePlayerToPosition ; $5446
	farcall FarPtr_WaitPlayerMoveDone ; $5449
	ld c, $08 ; $544c
	call BeginFadeIn ; $544e
	call WaitFadeEnd ; $5451
	push af ; $5454
	ld a, $1e ; $5455
	farcall FarPtr_WaitScriptFrames ; $5457
	pop af ; $545a
	ld a, $06 ; $545b
	ld d, $02 ; $545d
	farcall FarPtr_ScriptSetActorAnimation ; $545f
	ld a, $06 ; $5462
	farcall FarPtr_ScriptWaitActorIdle ; $5464
	ld a, $06 ; $5467
	ld b, $01 ; $5469
	farcall FarPtr_ScriptSetActorFacingLock ; $546b
	ld a, $06 ; $546e
	ld b, $c0 ; $5470
	ld de, $0100 ; $5472
	farcall FarPtr_MoveActorByAngle ; $5475
	ld a, $06 ; $5478
	farcall FarPtr_ScriptWaitActorMoveDone ; $547a
	push af ; $547d
	ld a, $28 ; $547e
	farcall FarPtr_WaitScriptFrames ; $5480
	pop af ; $5483
	ld a, $06 ; $5484
	ld b, $c0 ; $5486
	ld de, $0100 ; $5488
	farcall FarPtr_MoveActorByAngle ; $548b
	ld a, $06 ; $548e
	farcall FarPtr_ScriptWaitActorMoveDone ; $5490
	ld a, $06 ; $5493
	ld d, $02 ; $5495
	farcall FarPtr_ScriptSetActorAnimation ; $5497
	ld a, $06 ; $549a
	farcall FarPtr_ScriptWaitActorIdle ; $549c
	ld a, $06 ; $549f
	ld b, $00 ; $54a1
	farcall FarPtr_ScriptSetActorFacingLock ; $54a3
	ld a, $06 ; $54a6
	ld bc, $0030 ; $54a8
	farcall FarPtr_ScriptSetActorMoveSpeed ; $54ab
	ld a, $06 ; $54ae
	farcall FarPtr_GetActorStateAddr ; $54b0
	ld a, $04 ; $54b3
	ld e, l ; $54b5
	ld d, h ; $54b6
	ld hl, $0018 ; $54b7
	add hl, de ; $54ba
	ld [hl], a ; $54bb
	ld a, $06 ; $54bc
	ld bc, $1f00 ; $54be
	ld de, $0b00 ; $54c1
	farcall FarPtr_ScriptSetActorMoveTarget ; $54c4
	ld a, $06 ; $54c7
	farcall FarPtr_ScriptWaitActorMoveDone ; $54c9
	ld a, $06 ; $54cc
	ld bc, $1f00 ; $54ce
	ld de, $1100 ; $54d1
	farcall FarPtr_ScriptSetActorMoveTarget ; $54d4
	ld a, $06 ; $54d7
	farcall FarPtr_ScriptWaitActorMoveDone ; $54d9
	ld a, $00 ; $54dc
	ld b, $40 ; $54de
	farcall FarPtr_SetActorFacing ; $54e0
	ld a, $06 ; $54e3
	ld bc, $1f00 ; $54e5
	ld de, $1f00 ; $54e8
	farcall FarPtr_ScriptSetActorMoveTarget ; $54eb
	ld a, $06 ; $54ee
	farcall FarPtr_ScriptWaitActorMoveDone ; $54f0
	ld a, $06 ; $54f3
	ld bc, $3f00 ; $54f5
	ld de, $3f00 ; $54f8
	farcall FarPtr_ScriptSetActorPosition ; $54fb
	ld a, $01 ; $54fe
	ld [$c294], a ; $5500
	ld [wStoryModeExitLocationRequest], a ; $5503
	ret ; $5506
	INCBIN "data/bank_027/d_5507.bin" ; $5507, 233 bytes
End10VarsityCourtMapScripts_27:
	; $55f0, 14 bytes (map_tree)
	dw End10VarsityCourtEntryPoints_27 ; slot 0 EntryPoints
	dw End10VarsityCourtExitTriggers_27 ; slot 1 ExitTriggers
	dw End10VarsityCourtActors_27 ; slot 2 Actors
	dw End10VarsityCourtNpcScripts_27 ; slot 3 NpcScripts
	dw End10VarsityCourtFacingScripts_27 ; slot 4 FacingScripts
	dw End10VarsityCourtTileTriggers_27 ; slot 5 TileTriggers
	dw End10VarsityCourtInitScript_27 ; slot 6 InitScript
End10VarsityCourtActors_27:
	; $55fe, 10 bytes (map_actors)
	map_actor_end
End10VarsityCourtEntryPoints_27:
	; $5608, 9 bytes (map_entries)
	map_entry $01, $c0, $0f00, $1f00, $0000
	db $ff
End10VarsityCourtExitTriggers_27:
	; $5611, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, $0000, $25, $01
	db $ff
End10VarsityCourtNpcScripts_27:
	ds 1, $ff ; $561a, fill
End10VarsityCourtFacingScripts_27:
	ds 1, $ff ; $561b, fill
End10VarsityCourtTileTriggers_27:
	ds 1, $ff ; $561c, fill
End10VarsityCourtInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $561d
	cp a, $01 ; $5620
	jp z, Label_27_5643 ; $5622
	ret ; $5625
Func_27_5626:
	ld a, [$c94d] ; $5626
	or a, a ; $5629
	jr nz, Label_27_5642 ; $562a
	ld d, $28 ; $562c
	ld a, $0d ; $562e
	farcall FarPtr_GetActorStateAddr ; $5630
	ld c, l ; $5633
	ld b, h ; $5634
	farcall FarPtr_04_2c ; $5635
	ld a, $0d ; $5638
	ld d, $01 ; $563a
	farcall FarPtr_ScriptSetActorAnimation ; $563c
	set_flag $1c, 0 ; $563f
Label_27_5642:
	ret ; $5642
Label_27_5643:
	test_flag $05, 7 ; $5643
	jr z, Label_27_564b ; $5646
	jp Label_27_582c ; $5648
Label_27_564b:
	wram_bank $06 ; $564b
	ldh a, [hRomBank] ; $5651
	ld hl, $5ccd ; $5653
	farcall FarPtr_ScriptRespawnLocationActors ; $5656
	ld a, $01 ; $5659
	farcall FarPtr_SetActorNullScript ; $565b
	ld bc, $00f0 ; $565e
	farcall FarPtr_SetPlayerMoveSpeed ; $5661
	call Func_27_5626 ; $5664
	ld a, $00 ; $5667
	ld bc, $0b00 ; $5669
	ld de, $1d00 ; $566c
	farcall FarPtr_ScriptSetActorPosition ; $566f
	ld a, $02 ; $5672
	ld bc, $0d00 ; $5674
	ld de, $2300 ; $5677
	farcall FarPtr_ScriptSetActorPosition ; $567a
	ld a, $00 ; $567d
	ld b, $c0 ; $567f
	farcall FarPtr_SetActorFacing ; $5681
	ld a, $02 ; $5684
	ld b, $c0 ; $5686
	farcall FarPtr_SetActorFacing ; $5688
	xor a, a ; $568b
	ld bc, $0b00 ; $568c
	ld de, $1100 ; $568f
	farcall FarPtr_MovePlayerToPosition ; $5692
	farcall FarPtr_WaitPlayerMoveDone ; $5695
	ld c, $04 ; $5698
	call BeginFadeIn ; $569a
	ld bc, $0020 ; $569d
	farcall FarPtr_SetPlayerMoveSpeed ; $56a0
	xor a, a ; $56a3
	ld bc, $0b00 ; $56a4
	ld de, $1700 ; $56a7
	farcall FarPtr_MovePlayerToPosition ; $56aa
	farcall FarPtr_WaitPlayerMoveDone ; $56ad
	ld a, $04 ; $56b0
	ld bc, $0b00 ; $56b2
	ld de, $1700 ; $56b5
	farcall FarPtr_ScriptSetActorMoveTarget ; $56b8
	ld a, $04 ; $56bb
	farcall FarPtr_ScriptWaitActorMoveDone ; $56bd
	sound $98 ; $56c0
	ld a, $0c ; $56c2
	ld bc, $0c40 ; $56c4
	ld de, $1bc0 ; $56c7
	farcall FarPtr_ScriptSetActorPosition ; $56ca
	push af ; $56cd
	ld a, $28 ; $56ce
	farcall FarPtr_WaitScriptFrames ; $56d0
	pop af ; $56d3
	ld a, $0c ; $56d4
	ld bc, $3f00 ; $56d6
	ld de, $3f00 ; $56d9
	farcall FarPtr_ScriptSetActorPosition ; $56dc
	ld a, $00 ; $56df
	ld b, $00 ; $56e1
	farcall FarPtr_SetActorFacing ; $56e3
	ld a, $0d ; $56e6
	ld b, $00 ; $56e8
	farcall FarPtr_MovePlayerToActor ; $56ea
	ldh a, [hRomBank] ; $56ed
	ld b, a ; $56ef
	ld a, $08 ; $56f0
	ld de, $5c30 ; $56f2
	farcall FarPtr_ScriptSetActorScript ; $56f5
	ldh a, [hRomBank] ; $56f8
	ld b, a ; $56fa
	ld a, $09 ; $56fb
	ld de, $5c94 ; $56fd
	farcall FarPtr_ScriptSetActorScript ; $5700
	ldh a, [hRomBank] ; $5703
	ld b, a ; $5705
	ld a, $0d ; $5706
	ld de, $5c8d ; $5708
	farcall FarPtr_ScriptSetActorScript ; $570b
	push af ; $570e
	ld a, $0a ; $570f
	farcall FarPtr_WaitScriptFrames ; $5711
	pop af ; $5714
	ldh a, [hRomBank] ; $5715
	ld b, a ; $5717
	ld a, $03 ; $5718
	ld de, $5c6a ; $571a
	farcall FarPtr_ScriptSetActorScript ; $571d
	push af ; $5720
	ld a, $1e ; $5721
	farcall FarPtr_WaitScriptFrames ; $5723
	pop af ; $5726
	ld a, $00 ; $5727
	ld b, $00 ; $5729
	farcall FarPtr_MovePlayerToActor ; $572b
	farcall FarPtr_WaitPlayerMoveDone ; $572e
	ld a, $03 ; $5731
	farcall FarPtr_WaitActorScriptDone ; $5733
	ld a, $00 ; $5736
	ld b, a ; $5738
	ld a, $0d ; $5739
	farcall FarPtr_FaceActorTowardActor ; $573b
	test_flag $1c, 0 ; $573e
	jr z, Label_27_5759 ; $5741
	ld a, $0d ; $5743
	ld d, $02 ; $5745
	farcall FarPtr_ScriptSetActorAnimation ; $5747
	ld a, $0d ; $574a
	farcall FarPtr_ScriptWaitActorIdle ; $574c
	ld a, $0d ; $574f
	ld b, a ; $5751
	ld a, $00 ; $5752
	farcall FarPtr_FaceActorTowardActor ; $5754
	jr Label_27_576d ; $5757
Label_27_5759:
	ld a, $0d ; $5759
	ld d, $02 ; $575b
	farcall FarPtr_ScriptSetActorAnimation ; $575d
	ld a, $0d ; $5760
	farcall FarPtr_ScriptWaitActorIdle ; $5762
	ld a, $0d ; $5765
	ld b, a ; $5767
	ld a, $00 ; $5768
	farcall FarPtr_FaceActorTowardActor ; $576a
Label_27_576d:
	ld a, $09 ; $576d
	ld d, $04 ; $576f
	farcall FarPtr_ScriptSetActorAnimation ; $5771
	ld a, $09 ; $5774
	farcall FarPtr_ScriptWaitActorIdle ; $5776
	ld a, $09 ; $5779
	ld b, a ; $577b
	ld a, $00 ; $577c
	farcall FarPtr_FaceActorTowardActor ; $577e
	ld a, $00 ; $5781
	ld d, $02 ; $5783
	farcall FarPtr_ScriptSetActorAnimation ; $5785
	ld a, $00 ; $5788
	farcall FarPtr_ScriptWaitActorIdle ; $578a
	push af ; $578d
	ld a, $14 ; $578e
	farcall FarPtr_WaitScriptFrames ; $5790
	pop af ; $5793
	ld a, $08 ; $5794
	ld bc, $0a00 ; $5796
	ld de, $1f00 ; $5799
	farcall FarPtr_ScriptSetActorMoveTarget ; $579c
	ld a, $08 ; $579f
	farcall FarPtr_ScriptWaitActorMoveDone ; $57a1
	push af ; $57a4
	ld a, $14 ; $57a5
	farcall FarPtr_WaitScriptFrames ; $57a7
	pop af ; $57aa
	ld a, $08 ; $57ab
	ld b, a ; $57ad
	ld a, $00 ; $57ae
	farcall FarPtr_FaceActorTowardActor ; $57b0
	ld a, $08 ; $57b3
	ld b, a ; $57b5
	ld a, $0d ; $57b6
	farcall FarPtr_FaceActorTowardActor ; $57b8
	push af ; $57bb
	ld a, $14 ; $57bc
	farcall FarPtr_WaitScriptFrames ; $57be
	pop af ; $57c1
	push af ; $57c2
	ld a, $14 ; $57c3
	farcall FarPtr_WaitScriptFrames ; $57c5
	pop af ; $57c8
	ld a, $03 ; $57c9
	ld bc, $0c00 ; $57cb
	ld de, $1f00 ; $57ce
	farcall FarPtr_ScriptSetActorMoveTarget ; $57d1
	ld a, $03 ; $57d4
	farcall FarPtr_ScriptWaitActorMoveDone ; $57d6
	push af ; $57d9
	ld a, $14 ; $57da
	farcall FarPtr_WaitScriptFrames ; $57dc
	pop af ; $57df
	ld a, $03 ; $57e0
	ld d, $02 ; $57e2
	farcall FarPtr_ScriptSetActorAnimation ; $57e4
	ld a, $03 ; $57e7
	farcall FarPtr_ScriptWaitActorIdle ; $57e9
	ld a, $0d ; $57ec
	ld d, $02 ; $57ee
	farcall FarPtr_ScriptSetActorAnimation ; $57f0
	ld a, $0d ; $57f3
	farcall FarPtr_ScriptWaitActorIdle ; $57f5
	ld a, $00 ; $57f8
	ld b, a ; $57fa
	ld a, $0d ; $57fb
	farcall FarPtr_FaceActorTowardActor ; $57fd
	test_flag $1c, 0 ; $5800
	jr z, Label_27_5805 ; $5803
Label_27_5805:
	ld a, $0d ; $5805
	ld b, a ; $5807
	ld a, $00 ; $5808
	farcall FarPtr_FaceActorTowardActor ; $580a
	push af ; $580d
	ld a, $0a ; $580e
	farcall FarPtr_WaitScriptFrames ; $5810
	pop af ; $5813
	ld a, $08 ; $5814
	ld b, a ; $5816
	ld a, $00 ; $5817
	farcall FarPtr_FaceActorTowardActor ; $5819
	push af ; $581c
	ld a, $0a ; $581d
	farcall FarPtr_WaitScriptFrames ; $581f
	pop af ; $5822
	ld a, $01 ; $5823
	ld [$c294], a ; $5825
	ld [wStoryModeExitLocationRequest], a ; $5828
	ret ; $582b
Label_27_582c:
	ldh a, [hRomBank] ; $582c
	ld hl, $5d71 ; $582e
	farcall FarPtr_ScriptRespawnLocationActors ; $5831
	farcall FarPtr_BeginCutsceneScriptMode ; $5834
	call Func_27_5626 ; $5837
	ld a, $02 ; $583a
	farcall FarPtr_SetActorNullScript ; $583c
	ld a, $01 ; $583f
	farcall FarPtr_SetActorNullScript ; $5841
	ld bc, $00f0 ; $5844
	farcall FarPtr_SetPlayerMoveSpeed ; $5847
	ld a, $00 ; $584a
	ld bc, $0b00 ; $584c
	ld de, $1d00 ; $584f
	farcall FarPtr_ScriptSetActorPosition ; $5852
	ld a, $02 ; $5855
	ld bc, $0d00 ; $5857
	ld de, $2300 ; $585a
SceneSharedData_27:
	farcall FarPtr_ScriptSetActorPosition ; $585d
	ld a, $00 ; $5860
	ld b, $c0 ; $5862
	farcall FarPtr_SetActorFacing ; $5864
	ld a, $02 ; $5867
	ld b, $c0 ; $5869
	farcall FarPtr_SetActorFacing ; $586b
	xor a, a ; $586e
	ld bc, $0b00 ; $586f
	ld de, $1100 ; $5872
	farcall FarPtr_MovePlayerToPosition ; $5875
	farcall FarPtr_WaitPlayerMoveDone ; $5878
	ld c, $04 ; $587b
	call BeginFadeIn ; $587d
	ld bc, $0020 ; $5880
	farcall FarPtr_SetPlayerMoveSpeed ; $5883
	xor a, a ; $5886
	ld bc, $0b00 ; $5887
	ld de, $1700 ; $588a
	farcall FarPtr_MovePlayerToPosition ; $588d
	farcall FarPtr_WaitPlayerMoveDone ; $5890
	ld a, $02 ; $5893
	ld bc, $0d00 ; $5895
	ld de, $1d00 ; $5898
	farcall FarPtr_ScriptSetActorMoveTarget ; $589b
	ld a, $09 ; $589e
	ld bc, $0b00 ; $58a0
	ld de, $1700 ; $58a3
	farcall FarPtr_ScriptSetActorMoveTarget ; $58a6
	ld a, $09 ; $58a9
	farcall FarPtr_ScriptWaitActorMoveDone ; $58ab
	ld a, $09 ; $58ae
	ld d, $04 ; $58b0
	farcall FarPtr_ScriptSetActorAnimation ; $58b2
	ld a, $09 ; $58b5
	farcall FarPtr_ScriptWaitActorIdle ; $58b7
	ld a, $04 ; $58ba
	ld d, $02 ; $58bc
	farcall FarPtr_ScriptSetActorAnimation ; $58be
	ld a, $04 ; $58c1
	farcall FarPtr_ScriptWaitActorIdle ; $58c3
	ld a, $02 ; $58c6
	ld d, $03 ; $58c8
	farcall FarPtr_ScriptSetActorAnimation ; $58ca
	ld a, $00 ; $58cd
	ld d, $03 ; $58cf
	farcall FarPtr_ScriptSetActorAnimation ; $58d1
	ld a, $00 ; $58d4
	farcall FarPtr_ScriptWaitActorIdle ; $58d6
	ld a, $00 ; $58d9
	ld b, a ; $58db
	ld a, $02 ; $58dc
	farcall FarPtr_FaceActorTowardActor ; $58de
	push af ; $58e1
	ld a, $1e ; $58e2
	farcall FarPtr_WaitScriptFrames ; $58e4
	pop af ; $58e7
	ld a, $02 ; $58e8
	ld d, $03 ; $58ea
	farcall FarPtr_ScriptSetActorAnimation ; $58ec
	ld a, $02 ; $58ef
	farcall FarPtr_ScriptWaitActorIdle ; $58f1
	test_flag $1c, 0 ; $58f4
	jp z, Label_27_5a25 ; $58f7
	ld a, $02 ; $58fa
	ld b, a ; $58fc
	ld a, $00 ; $58fd
	farcall FarPtr_FaceActorTowardActor ; $58ff
	ld a, $02 ; $5902
	ld d, $02 ; $5904
	farcall FarPtr_ScriptSetActorAnimation ; $5906
	ld a, $02 ; $5909
	farcall FarPtr_ScriptWaitActorIdle ; $590b
	ld a, $00 ; $590e
	ld b, $80 ; $5910
	farcall FarPtr_SetActorFacing ; $5912
	ld a, $00 ; $5915
	ld d, $02 ; $5917
	farcall FarPtr_ScriptSetActorAnimation ; $5919
	sound $96 ; $591c
	ld a, $0a ; $591e
	ld bc, $0c00 ; $5920
	ld de, $1b80 ; $5923
	farcall FarPtr_ScriptSetActorPosition ; $5926
	push af ; $5929
	ld a, $28 ; $592a
	farcall FarPtr_WaitScriptFrames ; $592c
	pop af ; $592f
	ld a, $0a ; $5930
	ld bc, $3f00 ; $5932
	ld de, $3f00 ; $5935
	farcall FarPtr_ScriptSetActorPosition ; $5938
	ld a, $02 ; $593b
	ld b, a ; $593d
	ld a, $00 ; $593e
	farcall FarPtr_FaceActorTowardActor ; $5940
	push af ; $5943
	ld a, $0a ; $5944
	farcall FarPtr_WaitScriptFrames ; $5946
	pop af ; $5949
	ld a, $00 ; $594a
	ld b, $01 ; $594c
	farcall FarPtr_ScriptSetActorFacingLock ; $594e
	push af ; $5951
	ld a, $0a ; $5952
	farcall FarPtr_WaitScriptFrames ; $5954
	pop af ; $5957
	ld a, $00 ; $5958
	ld b, $00 ; $595a
	ld de, $0100 ; $595c
	farcall FarPtr_MoveActorByAngle ; $595f
	ld a, $00 ; $5962
	farcall FarPtr_ScriptWaitActorMoveDone ; $5964
	ld a, $00 ; $5967
	ld d, $02 ; $5969
	farcall FarPtr_ScriptSetActorAnimation ; $596b
	ld a, $00 ; $596e
	farcall FarPtr_ScriptWaitActorIdle ; $5970
	ld a, $00 ; $5973
	ld b, $80 ; $5975
	ld de, $0100 ; $5977
	farcall FarPtr_MoveActorByAngle ; $597a
	ld a, $00 ; $597d
	farcall FarPtr_ScriptWaitActorMoveDone ; $597f
	ld a, $02 ; $5982
	farcall FarPtr_GetActorStateAddr ; $5984
	ld de, $0018 ; $5987
	add hl, de ; $598a
	ld [hl], $04 ; $598b
	ld a, $02 ; $598d
	ld d, $02 ; $598f
	farcall FarPtr_ScriptSetActorAnimation ; $5991
	ld a, $02 ; $5994
	farcall FarPtr_ScriptWaitActorIdle ; $5996
	ld a, $02 ; $5999
	ld b, $c0 ; $599b
	farcall FarPtr_SetActorFacing ; $599d
	ld a, $02 ; $59a0
	ld d, $02 ; $59a2
	farcall FarPtr_ScriptSetActorAnimation ; $59a4
	ld a, $02 ; $59a7
	farcall FarPtr_ScriptWaitActorIdle ; $59a9
	ld a, $02 ; $59ac
	ld d, $02 ; $59ae
	farcall FarPtr_ScriptSetActorAnimation ; $59b0
	ld a, $02 ; $59b3
	farcall FarPtr_ScriptWaitActorIdle ; $59b5
	ld a, $02 ; $59b8
	ld b, $40 ; $59ba
	farcall FarPtr_SetActorFacing ; $59bc
	ld a, $02 ; $59bf
	ld d, $02 ; $59c1
	farcall FarPtr_ScriptSetActorAnimation ; $59c3
	ld a, $02 ; $59c6
	farcall FarPtr_ScriptWaitActorIdle ; $59c8
	ld a, $02 ; $59cb
	ld b, $c0 ; $59cd
	farcall FarPtr_SetActorFacing ; $59cf
	ld a, $02 ; $59d2
	ld d, $02 ; $59d4
	farcall FarPtr_ScriptSetActorAnimation ; $59d6
	ld a, $02 ; $59d9
	farcall FarPtr_ScriptWaitActorIdle ; $59db
	ld a, $02 ; $59de
	ld d, $02 ; $59e0
	farcall FarPtr_ScriptSetActorAnimation ; $59e2
	ld a, $02 ; $59e5
	farcall FarPtr_ScriptWaitActorIdle ; $59e7
	ld a, $02 ; $59ea
	farcall FarPtr_GetActorStateAddr ; $59ec
	ld de, $0018 ; $59ef
	add hl, de ; $59f2
	ld [hl], $01 ; $59f3
	ld a, $02 ; $59f5
	ld b, $80 ; $59f7
	farcall FarPtr_SetActorFacing ; $59f9
	push af ; $59fc
	ld a, $14 ; $59fd
	farcall FarPtr_WaitScriptFrames ; $59ff
	pop af ; $5a02
	ld a, $02 ; $5a03
	ld d, $03 ; $5a05
	farcall FarPtr_ScriptSetActorAnimation ; $5a07
	ld a, $02 ; $5a0a
	farcall FarPtr_ScriptWaitActorIdle ; $5a0c
	push af ; $5a0f
	ld a, $14 ; $5a10
	farcall FarPtr_WaitScriptFrames ; $5a12
	pop af ; $5a15
	ld a, $00 ; $5a16
	ld d, $03 ; $5a18
	farcall FarPtr_ScriptSetActorAnimation ; $5a1a
	ld a, $00 ; $5a1d
	farcall FarPtr_ScriptWaitActorIdle ; $5a1f
	jp Label_27_5b0c ; $5a22
Label_27_5a25:
	ld a, $02 ; $5a25
	ld d, $02 ; $5a27
	farcall FarPtr_ScriptSetActorAnimation ; $5a29
	ld a, $02 ; $5a2c
	farcall FarPtr_ScriptWaitActorIdle ; $5a2e
	ld a, $02 ; $5a31
	ld b, a ; $5a33
	ld a, $00 ; $5a34
	farcall FarPtr_FaceActorTowardActor ; $5a36
	sound $96 ; $5a39
	ld a, $0a ; $5a3b
	ld bc, $0c00 ; $5a3d
	ld de, $1b80 ; $5a40
	farcall FarPtr_ScriptSetActorPosition ; $5a43
	push af ; $5a46
	ld a, $28 ; $5a47
	farcall FarPtr_WaitScriptFrames ; $5a49
	pop af ; $5a4c
	ld a, $0a ; $5a4d
	ld bc, $3f00 ; $5a4f
	ld de, $3f00 ; $5a52
	farcall FarPtr_ScriptSetActorPosition ; $5a55
	push af ; $5a58
	ld a, $0a ; $5a59
	farcall FarPtr_WaitScriptFrames ; $5a5b
	pop af ; $5a5e
	ld a, $00 ; $5a5f
	ld b, $01 ; $5a61
	farcall FarPtr_ScriptSetActorFacingLock ; $5a63
	push af ; $5a66
	ld a, $0a ; $5a67
	farcall FarPtr_WaitScriptFrames ; $5a69
	pop af ; $5a6c
	ld a, $00 ; $5a6d
	ld b, $00 ; $5a6f
	ld de, $0100 ; $5a71
	farcall FarPtr_MoveActorByAngle ; $5a74
	ld a, $00 ; $5a77
	farcall FarPtr_ScriptWaitActorMoveDone ; $5a79
	ld a, $00 ; $5a7c
	ld d, $02 ; $5a7e
	farcall FarPtr_ScriptSetActorAnimation ; $5a80
	ld a, $00 ; $5a83
	farcall FarPtr_ScriptWaitActorIdle ; $5a85
	ld a, $00 ; $5a88
	ld b, $80 ; $5a8a
	ld de, $0100 ; $5a8c
	farcall FarPtr_MoveActorByAngle ; $5a8f
	ld a, $00 ; $5a92
	farcall FarPtr_ScriptWaitActorMoveDone ; $5a94
	ld a, $02 ; $5a97
	farcall FarPtr_GetActorStateAddr ; $5a99
	ld de, $0018 ; $5a9c
	add hl, de ; $5a9f
	ld [hl], $03 ; $5aa0
	ld a, $02 ; $5aa2
	ld d, $02 ; $5aa4
	farcall FarPtr_ScriptSetActorAnimation ; $5aa6
	ld a, $02 ; $5aa9
	farcall FarPtr_ScriptWaitActorIdle ; $5aab
	ld a, $02 ; $5aae
	ld b, $40 ; $5ab0
	farcall FarPtr_SetActorFacing ; $5ab2
	ld a, $02 ; $5ab5
	ld d, $02 ; $5ab7
	farcall FarPtr_ScriptSetActorAnimation ; $5ab9
	ld a, $02 ; $5abc
	farcall FarPtr_ScriptWaitActorIdle ; $5abe
	push af ; $5ac1
	ld a, $28 ; $5ac2
	farcall FarPtr_WaitScriptFrames ; $5ac4
	pop af ; $5ac7
	ld a, $02 ; $5ac8
	ld d, $02 ; $5aca
	farcall FarPtr_ScriptSetActorAnimation ; $5acc
	ld a, $02 ; $5acf
	farcall FarPtr_ScriptWaitActorIdle ; $5ad1
	ld a, $02 ; $5ad4
	farcall FarPtr_GetActorStateAddr ; $5ad6
	ld de, $0018 ; $5ad9
	add hl, de ; $5adc
	ld [hl], $01 ; $5add
	ld a, $02 ; $5adf
	ld b, $80 ; $5ae1
	farcall FarPtr_SetActorFacing ; $5ae3
	push af ; $5ae6
	ld a, $14 ; $5ae7
	farcall FarPtr_WaitScriptFrames ; $5ae9
	pop af ; $5aec
	ld a, $02 ; $5aed
	ld d, $03 ; $5aef
	farcall FarPtr_ScriptSetActorAnimation ; $5af1
	ld a, $02 ; $5af4
	farcall FarPtr_ScriptWaitActorIdle ; $5af6
	push af ; $5af9
	ld a, $14 ; $5afa
	farcall FarPtr_WaitScriptFrames ; $5afc
	pop af ; $5aff
	ld a, $00 ; $5b00
	ld d, $03 ; $5b02
	farcall FarPtr_ScriptSetActorAnimation ; $5b04
	ld a, $00 ; $5b07
	farcall FarPtr_ScriptWaitActorIdle ; $5b09
Label_27_5b0c:
	push af ; $5b0c
	ld a, $14 ; $5b0d
	farcall FarPtr_WaitScriptFrames ; $5b0f
	pop af ; $5b12
	ld a, $00 ; $5b13
	ld b, $00 ; $5b15
	farcall FarPtr_ScriptSetActorFacingLock ; $5b17
	ld a, $00 ; $5b1a
	ld b, $00 ; $5b1c
	farcall FarPtr_SetActorFacing ; $5b1e
	ld a, $02 ; $5b21
	ld b, $00 ; $5b23
	farcall FarPtr_SetActorFacing ; $5b25
	ldh a, [hRomBank] ; $5b28
	ld b, a ; $5b2a
	ld a, $08 ; $5b2b
	ld de, $5c30 ; $5b2d
	farcall FarPtr_ScriptSetActorScript ; $5b30
	ldh a, [hRomBank] ; $5b33
	ld b, a ; $5b35
	ld a, $03 ; $5b36
	ld de, $5c4d ; $5b38
	farcall FarPtr_ScriptSetActorScript ; $5b3b
	push af ; $5b3e
	ld a, $14 ; $5b3f
	farcall FarPtr_WaitScriptFrames ; $5b41
	pop af ; $5b44
	ldh a, [hRomBank] ; $5b45
	ld b, a ; $5b47
	ld a, $09 ; $5b48
	ld de, $5cb6 ; $5b4a
	farcall FarPtr_ScriptSetActorScript ; $5b4d
	xor a, a ; $5b50
	ld bc, $0b00 ; $5b51
	ld de, $1d00 ; $5b54
	farcall FarPtr_MovePlayerToPosition ; $5b57
	farcall FarPtr_WaitPlayerMoveDone ; $5b5a
	ld a, $09 ; $5b5d
	farcall FarPtr_WaitActorScriptDone ; $5b5f
	ld a, $00 ; $5b62
	ld b, a ; $5b64
	ld a, $09 ; $5b65
	farcall FarPtr_FaceActorTowardActor ; $5b67
	ld a, $03 ; $5b6a
	ld b, a ; $5b6c
	ld a, $02 ; $5b6d
	farcall FarPtr_FaceActorTowardActor ; $5b6f
	ld a, $09 ; $5b72
	ld d, $04 ; $5b74
	farcall FarPtr_ScriptSetActorAnimation ; $5b76
	ld a, $09 ; $5b79
	farcall FarPtr_ScriptWaitActorIdle ; $5b7b
	ld a, $09 ; $5b7e
	ld b, a ; $5b80
	ld a, $00 ; $5b81
	farcall FarPtr_FaceActorTowardActor ; $5b83
	ld a, $08 ; $5b86
	ld bc, $0a00 ; $5b88
	ld de, $1f00 ; $5b8b
	farcall FarPtr_ScriptSetActorMoveTarget ; $5b8e
	ld a, $08 ; $5b91
	farcall FarPtr_ScriptWaitActorMoveDone ; $5b93
	ld a, $08 ; $5b96
	ld b, a ; $5b98
	ld a, $00 ; $5b99
	farcall FarPtr_FaceActorTowardActor ; $5b9b
	ld a, $03 ; $5b9e
	ld b, a ; $5ba0
	ld a, $02 ; $5ba1
	farcall FarPtr_FaceActorTowardActor ; $5ba3
	ld a, $08 ; $5ba6
	ld d, $03 ; $5ba8
	farcall FarPtr_ScriptSetActorAnimation ; $5baa
	ld a, $08 ; $5bad
	farcall FarPtr_ScriptWaitActorIdle ; $5baf
	ld a, $03 ; $5bb2
	ld bc, $0c00 ; $5bb4
	ld de, $1f00 ; $5bb7
	farcall FarPtr_ScriptSetActorMoveTarget ; $5bba
	ld a, $03 ; $5bbd
	farcall FarPtr_ScriptWaitActorMoveDone ; $5bbf
	ld a, $03 ; $5bc2
	ld d, $02 ; $5bc4
	farcall FarPtr_ScriptSetActorAnimation ; $5bc6
	ld a, $03 ; $5bc9
	farcall FarPtr_ScriptWaitActorIdle ; $5bcb
	ld a, $00 ; $5bce
	ld b, a ; $5bd0
	ld a, $02 ; $5bd1
	farcall FarPtr_FaceActorTowardActor ; $5bd3
	ld a, $02 ; $5bd6
	ld d, $03 ; $5bd8
	farcall FarPtr_ScriptSetActorAnimation ; $5bda
	ld a, $02 ; $5bdd
	farcall FarPtr_ScriptWaitActorIdle ; $5bdf
	test_flag $1c, 0 ; $5be2
	jr z, Label_27_5be7 ; $5be5
Label_27_5be7:
	ld a, $02 ; $5be7
	ld b, a ; $5be9
	ld a, $00 ; $5bea
	farcall FarPtr_FaceActorTowardActor ; $5bec
	ld a, $00 ; $5bef
	ld d, $03 ; $5bf1
	farcall FarPtr_ScriptSetActorAnimation ; $5bf3
	ld a, $00 ; $5bf6
	farcall FarPtr_ScriptWaitActorIdle ; $5bf8
	push af ; $5bfb
	ld a, $0a ; $5bfc
	farcall FarPtr_WaitScriptFrames ; $5bfe
	pop af ; $5c01
	ld a, $08 ; $5c02
	ld b, a ; $5c04
	ld a, $00 ; $5c05
	farcall FarPtr_FaceActorTowardActor ; $5c07
	ld a, $03 ; $5c0a
	ld b, a ; $5c0c
	ld a, $02 ; $5c0d
	farcall FarPtr_FaceActorTowardActor ; $5c0f
	push af ; $5c12
	ld a, $0a ; $5c13
	farcall FarPtr_WaitScriptFrames ; $5c15
	pop af ; $5c18
	ld a, $00 ; $5c19
	ld d, $03 ; $5c1b
	farcall FarPtr_ScriptSetActorAnimation ; $5c1d
	ld a, $02 ; $5c20
	ld d, $03 ; $5c22
	farcall FarPtr_ScriptSetActorAnimation ; $5c24
	ld a, $01 ; $5c27
	ld [$c294], a ; $5c29
	ld [wStoryModeExitLocationRequest], a ; $5c2c
	ret ; $5c2f
	INCBIN "data/bank_027/d_5c30.bin" ; $5c30, 485 bytes
End8SrCourtMapScripts_27:
	; $5e15, 14 bytes (map_tree)
	dw End8SrCourtEntryPoints_27 ; slot 0 EntryPoints
	dw End8SrCourtExitTriggers_27 ; slot 1 ExitTriggers
	dw End8SrCourtActors_27 ; slot 2 Actors
	dw End8SrCourtNpcScripts_27 ; slot 3 NpcScripts
	dw End8SrCourtFacingScripts_27 ; slot 4 FacingScripts
	dw End8SrCourtTileTriggers_27 ; slot 5 TileTriggers
	dw End8SrCourtInitScript_27 ; slot 6 InitScript
End8SrCourtActors_27:
	; $5e23, 94 bytes (map_actors)
	map_actor $0000, $785d, $2b00, $2700, $c0, $49, $01, $00
	map_actor $0000, $785d, $2200, $0f00, $40, $65, $01, $07
	map_actor $0000, $785d, $2d00, $1300, $00, $69, $01, $04
	map_actor $0000, $785d, $1b00, $0d00, $80, $66, $01, $06
	map_actor $0000, $785d, $2900, $1300, $80, $54, $01, $05
	map_actor $0000, $785d, $2900, $1900, $80, $54, $01, $00
	map_actor_end
End8SrCourtActorsAlt_27:
	; $5e81, 66 bytes (map_actors)
	map_actor $0000, $785d, $2b00, $2700, $c0, $49, $01, $00
	map_actor $0000, $785d, $2500, $0f00, $40, $65, $01, $07
	map_actor $0000, $785d, $2300, $1300, $40, $64, $01, $05
	map_actor $0000, $785d, $1b00, $0d00, $80, $6b, $01, $05
	map_actor_end
End8SrCourtEntryPoints_27:
	; $5ec3, 9 bytes (map_entries)
	map_entry $01, $c0, $2400, $1500, $0000
	db $ff
End8SrCourtExitTriggers_27:
	; $5ecc, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_27, $24, $01
	db $ff
End8SrCourtNpcScripts_27:
	ds 1, $ff ; $5ed5, fill
End8SrCourtFacingScripts_27:
	ds 1, $ff ; $5ed6, fill
End8SrCourtTileTriggers_27:
	ds 1, $ff ; $5ed7, fill
End8SrCourtInitScript_27:
	test_flag $05, 7 ; $5ed8
	jp z, Label_27_6075 ; $5edb
	ldh a, [hRomBank] ; $5ede
	ld hl, End8SrCourtActorsAlt_27 ; $5ee0
	farcall FarPtr_ScriptRespawnLocationActors ; $5ee3
	farcall FarPtr_BeginCutsceneScriptMode ; $5ee6
	jr Label_27_5eec ; $5ee9
	ret ; $5eeb
Label_27_5eec:
	ld a, $02 ; $5eec
	farcall FarPtr_SetActorNullScript ; $5eee
	ld a, $00 ; $5ef1
	ld bc, $2500 ; $5ef3
	ld de, $1b00 ; $5ef6
	farcall FarPtr_ScriptSetActorPosition ; $5ef9
	ld a, $00 ; $5efc
	ld b, $c0 ; $5efe
	farcall FarPtr_SetActorFacing ; $5f00
	ld a, $02 ; $5f03
	ld bc, $2300 ; $5f05
	ld de, $1b00 ; $5f08
	farcall FarPtr_ScriptSetActorPosition ; $5f0b
	ld a, $02 ; $5f0e
	ld b, $c0 ; $5f10
	farcall FarPtr_SetActorFacing ; $5f12
	ld a, $03 ; $5f15
	ld b, $80 ; $5f17
	farcall FarPtr_SetActorFacing ; $5f19
	xor a, a ; $5f1c
	ld [wStoryModeShowLocationName], a ; $5f1d
	ld c, $04 ; $5f20
	call BeginFadeIn ; $5f22
	ld a, $04 ; $5f25
	ld bc, $2500 ; $5f27
	ld de, $1300 ; $5f2a
	farcall FarPtr_ScriptSetActorMoveTarget ; $5f2d
	ld a, $04 ; $5f30
	farcall FarPtr_ScriptWaitActorMoveDone ; $5f32
	ld a, $05 ; $5f35
	ld b, a ; $5f37
	ld a, $04 ; $5f38
	farcall FarPtr_FaceActorsTowardEachOther ; $5f3a
	ld a, $04 ; $5f3d
	ld d, $02 ; $5f3f
	farcall FarPtr_ScriptSetActorAnimation ; $5f41
	ld a, $32 ; $5f44
	call Func_27_7856 ; $5f46
	ld a, $05 ; $5f49
	ld b, $40 ; $5f4b
	farcall FarPtr_SetActorFacing ; $5f4d
	ld a, $05 ; $5f50
	ld d, $04 ; $5f52
	farcall FarPtr_ScriptSetActorAnimation ; $5f54
	ld a, $05 ; $5f57
	farcall FarPtr_ScriptWaitActorIdle ; $5f59
	ld a, $32 ; $5f5c
	call Func_27_7856 ; $5f5e
	ld a, $04 ; $5f61
	ld d, $02 ; $5f63
	farcall FarPtr_ScriptSetActorAnimation ; $5f65
	ld a, $05 ; $5f68
	ld d, $02 ; $5f6a
	farcall FarPtr_ScriptSetActorAnimation ; $5f6c
	ld a, $02 ; $5f6f
	ld d, $02 ; $5f71
	farcall FarPtr_ScriptSetActorAnimation ; $5f73
	ld a, $00 ; $5f76
	ld d, $02 ; $5f78
	farcall FarPtr_ScriptSetActorAnimation ; $5f7a
	ld a, $00 ; $5f7d
	ld b, $40 ; $5f7f
	farcall FarPtr_SetActorFacing ; $5f81
	ld a, $02 ; $5f84
	ld b, $40 ; $5f86
	farcall FarPtr_SetActorFacing ; $5f88
	ld a, $04 ; $5f8b
	ld b, $40 ; $5f8d
	farcall FarPtr_SetActorFacing ; $5f8f
	ld a, $1e ; $5f92
	call Func_27_7856 ; $5f94
	ld bc, $0030 ; $5f97
	farcall FarPtr_SetPlayerMoveSpeed ; $5f9a
	ld a, $03 ; $5f9d
	ld bc, $0010 ; $5f9f
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5fa2
	xor a, a ; $5fa5
	ld bc, $2b00 ; $5fa6
	ld de, $1f00 ; $5fa9
	farcall FarPtr_MovePlayerToPosition ; $5fac
	ld a, $03 ; $5faf
	ld bc, $2b00 ; $5fb1
	ld de, $2000 ; $5fb4
	farcall FarPtr_ScriptSetActorMoveTarget ; $5fb7
	ld a, $5a ; $5fba
	call Func_27_7856 ; $5fbc
	ld bc, $0010 ; $5fbf
	farcall FarPtr_SetPlayerMoveSpeed ; $5fc2
	xor a, a ; $5fc5
	ld bc, $2400 ; $5fc6
	ld de, $1b00 ; $5fc9
	farcall FarPtr_MovePlayerToPosition ; $5fcc
	ld a, $03 ; $5fcf
	ld bc, $2500 ; $5fd1
	ld de, $1f00 ; $5fd4
	farcall FarPtr_ScriptSetActorMoveTarget ; $5fd7
	ld a, $03 ; $5fda
	farcall FarPtr_ScriptWaitActorMoveDone ; $5fdc
	ld a, $03 ; $5fdf
	ld b, $c0 ; $5fe1
	farcall FarPtr_SetActorFacing ; $5fe3
	ld a, $03 ; $5fe6
	ld d, $02 ; $5fe8
	farcall FarPtr_ScriptSetActorAnimation ; $5fea
	ld a, $03 ; $5fed
	farcall FarPtr_ScriptWaitActorIdle ; $5fef
	ld a, $14 ; $5ff2
	call Func_27_7856 ; $5ff4
	ld a, $02 ; $5ff7
	ld b, a ; $5ff9
	ld a, $00 ; $5ffa
	farcall FarPtr_FaceActorsTowardEachOther ; $5ffc
	ld a, $28 ; $5fff
	call Func_27_7856 ; $6001
	ld a, $00 ; $6004
	ld b, $40 ; $6006
	farcall FarPtr_SetActorFacing ; $6008
	ld a, $02 ; $600b
	ld b, $40 ; $600d
	farcall FarPtr_SetActorFacing ; $600f
	ld a, $02 ; $6012
	ld d, $03 ; $6014
	farcall FarPtr_ScriptSetActorAnimation ; $6016
	ld a, $00 ; $6019
	ld d, $03 ; $601b
	farcall FarPtr_ScriptSetActorAnimation ; $601d
	ld a, $00 ; $6020
	farcall FarPtr_ScriptWaitActorIdle ; $6022
	ld a, $03 ; $6025
	ld d, $03 ; $6027
	farcall FarPtr_ScriptSetActorAnimation ; $6029
	ld a, $03 ; $602c
	farcall FarPtr_ScriptWaitActorIdle ; $602e
	ld a, $14 ; $6031
	call Func_27_7856 ; $6033
	ld a, $03 ; $6036
	ld bc, $2500 ; $6038
	ld de, $1d00 ; $603b
	farcall FarPtr_ScriptSetActorMoveTarget ; $603e
	ld a, $03 ; $6041
	farcall FarPtr_ScriptWaitActorMoveDone ; $6043
	ld a, $03 ; $6046
	ld d, $02 ; $6048
	farcall FarPtr_ScriptSetActorAnimation ; $604a
	ld a, $03 ; $604d
	farcall FarPtr_ScriptWaitActorIdle ; $604f
	push af ; $6052
	ld a, $1e ; $6053
	farcall FarPtr_WaitScriptFrames ; $6055
	pop af ; $6058
	ld a, $03 ; $6059
	ld d, $03 ; $605b
	farcall FarPtr_ScriptSetActorAnimation ; $605d
	ld a, $00 ; $6060
	ld d, $03 ; $6062
	farcall FarPtr_ScriptSetActorAnimation ; $6064
	ld a, $00 ; $6067
	farcall FarPtr_ScriptWaitActorIdle ; $6069
	ld a, $01 ; $606c
	ld [$c294], a ; $606e
	ld [wStoryModeExitLocationRequest], a ; $6071
	ret ; $6074
Label_27_6075:
	ld a, $04 ; $6075
	ld bc, $0018 ; $6077
	farcall FarPtr_ScriptSetActorMoveSpeed ; $607a
	ld a, $00 ; $607d
	ld bc, $2400 ; $607f
	ld de, $1b00 ; $6082
	farcall FarPtr_ScriptSetActorPosition ; $6085
	ld a, $00 ; $6088
	ld b, $c0 ; $608a
	farcall FarPtr_SetActorFacing ; $608c
	xor a, a ; $608f
	ld [wStoryModeShowLocationName], a ; $6090
	ld c, $04 ; $6093
	call BeginFadeIn ; $6095
	ld a, $04 ; $6098
	ld bc, $2400 ; $609a
	ld de, $1300 ; $609d
	farcall FarPtr_ScriptSetActorMoveTarget ; $60a0
	ld a, $04 ; $60a3
	farcall FarPtr_ScriptWaitActorMoveDone ; $60a5
	ld a, $14 ; $60a8
	call Func_27_7856 ; $60aa
	ld a, $28 ; $60ad
	call Func_27_7856 ; $60af
	ld a, $04 ; $60b2
	ld d, $02 ; $60b4
	farcall FarPtr_ScriptSetActorAnimation ; $60b6
	ld a, $00 ; $60b9
	ld d, $02 ; $60bb
	farcall FarPtr_ScriptSetActorAnimation ; $60bd
	ld a, $00 ; $60c0
	farcall FarPtr_ScriptWaitActorIdle ; $60c2
	ld a, $00 ; $60c5
	ld b, $40 ; $60c7
	farcall FarPtr_SetActorFacing ; $60c9
	ld a, $1e ; $60cc
	call Func_27_7856 ; $60ce
	ld bc, $0030 ; $60d1
	farcall FarPtr_SetPlayerMoveSpeed ; $60d4
	ld a, $03 ; $60d7
	ld bc, $0010 ; $60d9
	farcall FarPtr_ScriptSetActorMoveSpeed ; $60dc
	xor a, a ; $60df
	ld bc, $2b00 ; $60e0
	ld de, $1f00 ; $60e3
	farcall FarPtr_MovePlayerToPosition ; $60e6
	ld a, $03 ; $60e9
	ld bc, $2b00 ; $60eb
	ld de, $1f00 ; $60ee
	farcall FarPtr_ScriptSetActorMoveTarget ; $60f1
	ld a, $5a ; $60f4
	call Func_27_7856 ; $60f6
	ld bc, $0010 ; $60f9
	farcall FarPtr_SetPlayerMoveSpeed ; $60fc
	xor a, a ; $60ff
	ld bc, $2400 ; $6100
	ld de, $1b00 ; $6103
	farcall FarPtr_MovePlayerToPosition ; $6106
	ld a, $03 ; $6109
	farcall FarPtr_ScriptWaitActorMoveDone ; $610b
	ld a, $03 ; $610e
	ld bc, $2400 ; $6110
	ld de, $1f00 ; $6113
	farcall FarPtr_ScriptSetActorMoveTarget ; $6116
	ld a, $03 ; $6119
	farcall FarPtr_ScriptWaitActorMoveDone ; $611b
	ld a, $03 ; $611e
	ld bc, $2400 ; $6120
	ld de, $1e00 ; $6123
	farcall FarPtr_ScriptSetActorMoveTarget ; $6126
	ld a, $03 ; $6129
	farcall FarPtr_ScriptWaitActorMoveDone ; $612b
	ld a, $03 ; $612e
	ld bc, $2400 ; $6130
	ld de, $1d00 ; $6133
	farcall FarPtr_ScriptSetActorMoveTarget ; $6136
	ld a, $03 ; $6139
	farcall FarPtr_ScriptWaitActorMoveDone ; $613b
	ld a, $1e ; $613e
	call Func_27_7856 ; $6140
	ld a, $03 ; $6143
	ld d, $02 ; $6145
	farcall FarPtr_ScriptSetActorAnimation ; $6147
	ld a, $03 ; $614a
	farcall FarPtr_ScriptWaitActorIdle ; $614c
	ld a, $1e ; $614f
	call Func_27_7856 ; $6151
	ld a, $00 ; $6154
	ld d, $03 ; $6156
	farcall FarPtr_ScriptSetActorAnimation ; $6158
	ld a, $00 ; $615b
	farcall FarPtr_ScriptWaitActorIdle ; $615d
	ld a, $14 ; $6160
	call Func_27_7856 ; $6162
	ld a, $03 ; $6165
	ld d, $03 ; $6167
	farcall FarPtr_ScriptSetActorAnimation ; $6169
	ld a, $03 ; $616c
	farcall FarPtr_ScriptWaitActorIdle ; $616e
	ld a, $28 ; $6171
	call Func_27_7856 ; $6173
	ld a, $01 ; $6176
	ld [$c294], a ; $6178
	ld [wStoryModeExitLocationRequest], a ; $617b
	ret ; $617e
End7TrainingCtrMapScripts_27:
	; $617f, 14 bytes (map_tree)
	dw End7TrainingCtrEntryPoints_27 ; slot 0 EntryPoints
	dw End7TrainingCtrExitTriggers_27 ; slot 1 ExitTriggers
	dw End7TrainingCtrActors_27 ; slot 2 Actors
	dw End7TrainingCtrNpcScripts_27 ; slot 3 NpcScripts
	dw End7TrainingCtrFacingScripts_27 ; slot 4 FacingScripts
	dw End7TrainingCtrTileTriggers_27 ; slot 5 TileTriggers
	dw End7TrainingCtrInitScript_27 ; slot 6 InitScript
End7TrainingCtrActors_27:
	; $618d, 80 bytes (map_actors)
	map_actor $0000, $785d, $2b00, $3300, $00, $3d, $01, $00
	map_actor $0000, $785d, $2b00, $3100, $00, $3d, $01, $00
	map_actor $0000, $785d, $2d00, $2b00, $80, $3e, $01, $00
	map_actor $0000, $785d, $1900, $1100, $c0, $39, $01, $06
	map_actor $0000, $785d, $0d00, $1300, $00, $39, $01, $07
	map_actor_end
End7TrainingCtrEntryPoints_27:
	; $61dd, 17 bytes (map_entries)
	map_entry $01, $c0, $2b00, $3900, $0000
	map_entry $02, $c0, $1600, $1800, $0000
	db $ff
End7TrainingCtrExitTriggers_27:
	; $61ee, 17 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_27, $11, $03
	map_script $04, $ff, $0000, MapScriptNop_27, $11, $03
	db $ff
End7TrainingCtrNpcScripts_27:
	ds 1, $ff ; $61ff, fill
End7TrainingCtrFacingScripts_27:
	ds 1, $ff ; $6200, fill
End7TrainingCtrTileTriggers_27:
	ds 1, $ff ; $6201, fill
End7TrainingCtrInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $6202
	cp a, $01 ; $6205
	jr z, Label_27_6270 ; $6207
	cp a, $02 ; $6209
	jp z, Label_27_6370 ; $620b
	ret ; $620e
Func_27_620f:
	ld a, $00 ; $620f
	test_flag $1a, 2 ; $6211
	jp z, Label_27_626c ; $6214
	ld b, $1e ; $6217
	ld c, $2c ; $6219
	ld d, $30 ; $621b
	ld e, $2c ; $621d
	ld h, $02 ; $621f
	ld l, $02 ; $6221
	farcall FarPtr_CopySceneTilemapRect ; $6223
	ld a, $01 ; $6226
	test_flag $1a, 3 ; $6228
	jp z, Label_27_626c ; $622b
	ld b, $1e ; $622e
	ld c, $30 ; $6230
	ld d, $30 ; $6232
	ld e, $30 ; $6234
	ld h, $02 ; $6236
	ld l, $02 ; $6238
	farcall FarPtr_CopySceneTilemapRect ; $623a
	ld a, $02 ; $623d
	test_flag $1a, 4 ; $623f
	jr z, Label_27_626c ; $6242
	ld b, $1e ; $6244
	ld c, $34 ; $6246
	ld d, $30 ; $6248
	ld e, $34 ; $624a
	ld h, $02 ; $624c
	ld l, $02 ; $624e
	farcall FarPtr_CopySceneTilemapRect ; $6250
	ld a, $03 ; $6253
	test_flag $1a, 5 ; $6255
	jr z, Label_27_626c ; $6258
	ld b, $1e ; $625a
	ld c, $38 ; $625c
	ld d, $30 ; $625e
	ld e, $38 ; $6260
	ld h, $02 ; $6262
	ld l, $02 ; $6264
	farcall FarPtr_CopySceneTilemapRect ; $6266
	ld a, $04 ; $6269
	ld b, a ; $626b
Label_27_626c:
	ld [$c2b0], a ; $626c
	ret ; $626f
Label_27_6270:
	ld a, $26 ; $6270
	ld [$c329], a ; $6272
	ld a, $23 ; $6275
	ld [$c32a], a ; $6277
	ld a, $40 ; $627a
	ld [$c32b], a ; $627c
	ld a, $3c ; $627f
	ld [$c32c], a ; $6281
	call DisableLCDSafely ; $6284
	ld a, $00 ; $6287
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $6289
	call EnableLCD ; $628c
	call Func_27_620f ; $628f
	farcall FarPtr_WaitPlayerMoveDone ; $6292
	ld a, $00 ; $6295
	ld bc, $2900 ; $6297
	ld de, $3700 ; $629a
	farcall FarPtr_ScriptSetActorPosition ; $629d
	ld a, $02 ; $62a0
	ld bc, $2900 ; $62a2
	ld de, $3700 ; $62a5
	farcall FarPtr_ScriptSetActorPosition ; $62a8
	ld c, $04 ; $62ab
	call BeginFadeIn ; $62ad
	xor a, a ; $62b0
	ld bc, $2900 ; $62b1
	ld de, $2b00 ; $62b4
	farcall FarPtr_MovePlayerToPosition ; $62b7
	ld a, $00 ; $62ba
	ld bc, $2900 ; $62bc
	ld de, $2b00 ; $62bf
	farcall FarPtr_ScriptSetActorMoveTarget ; $62c2
	ld a, $00 ; $62c5
	farcall FarPtr_ScriptWaitActorMoveDone ; $62c7
	ld a, $00 ; $62ca
	ld bc, $2b00 ; $62cc
	ld de, $2b00 ; $62cf
	farcall FarPtr_ScriptSetActorMoveTarget ; $62d2
	ld a, $00 ; $62d5
	farcall FarPtr_ScriptWaitActorMoveDone ; $62d7
	ld a, $02 ; $62da
	ld b, $00 ; $62dc
	farcall FarPtr_SetActorFacing ; $62de
	ld a, $00 ; $62e1
	ld b, $00 ; $62e3
	farcall FarPtr_SetActorFacing ; $62e5
	push af ; $62e8
	ld a, $1e ; $62e9
	farcall FarPtr_WaitScriptFrames ; $62eb
	pop af ; $62ee
	ld a, $05 ; $62ef
	ld d, $03 ; $62f1
	farcall FarPtr_ScriptSetActorAnimation ; $62f3
	ld a, $05 ; $62f6
	farcall FarPtr_ScriptWaitActorIdle ; $62f8
	ld a, $05 ; $62fb
	ld bc, $2d00 ; $62fd
	ld de, $2900 ; $6300
	farcall FarPtr_ScriptSetActorMoveTarget ; $6303
	ld a, $05 ; $6306
	farcall FarPtr_ScriptWaitActorMoveDone ; $6308
	ld a, $05 ; $630b
	ld b, $40 ; $630d
	farcall FarPtr_SetActorFacing ; $630f
	ld a, $02 ; $6312
	farcall FarPtr_SetActorNullScript ; $6314
	ld a, $00 ; $6317
	ld bc, $0020 ; $6319
	farcall FarPtr_ScriptSetActorMoveSpeed ; $631c
	xor a, a ; $631f
	ld bc, $3800 ; $6320
	ld de, $3300 ; $6323
	farcall FarPtr_MovePlayerToPosition ; $6326
	ld a, $00 ; $6329
	ld bc, $3300 ; $632b
	ld de, $2b00 ; $632e
	farcall FarPtr_ScriptSetActorMoveTarget ; $6331
	ld a, $00 ; $6334
	farcall FarPtr_ScriptWaitActorMoveDone ; $6336
	ld a, $00 ; $6339
	ld bc, $3300 ; $633b
	ld de, $3300 ; $633e
	farcall FarPtr_ScriptSetActorMoveTarget ; $6341
	ld a, $00 ; $6344
	farcall FarPtr_ScriptWaitActorMoveDone ; $6346
	ld a, $00 ; $6349
	ld bc, $3800 ; $634b
	ld de, $3500 ; $634e
	farcall FarPtr_ScriptSetActorMoveTarget ; $6351
	ld a, $00 ; $6354
	farcall FarPtr_ScriptWaitActorMoveDone ; $6356
	ld a, $00 ; $6359
	ld b, $c0 ; $635b
	farcall FarPtr_SetActorFacing ; $635d
	push af ; $6360
	ld a, $0a ; $6361
	farcall FarPtr_WaitScriptFrames ; $6363
	pop af ; $6366
	ld a, $01 ; $6367
	ld [$c294], a ; $6369
	ld [wStoryModeExitLocationRequest], a ; $636c
	ret ; $636f
Label_27_6370:
	ld a, $02 ; $6370
	ld bc, $1600 ; $6372
	ld de, $1a00 ; $6375
	farcall FarPtr_ScriptSetActorPosition ; $6378
	ld a, $02 ; $637b
	ld bc, $0010 ; $637d
	farcall FarPtr_ScriptSetActorMoveSpeed ; $6380
	ld a, $00 ; $6383
	ld bc, $0010 ; $6385
	farcall FarPtr_ScriptSetActorMoveSpeed ; $6388
	ld bc, $0018 ; $638b
	farcall FarPtr_SetPlayerMoveSpeed ; $638e
	ld c, $04 ; $6391
	call BeginFadeIn ; $6393
	ld a, $00 ; $6396
	ld b, $c0 ; $6398
	ld de, $0400 ; $639a
	farcall FarPtr_MoveActorByAngle ; $639d
	ld a, $00 ; $63a0
	farcall FarPtr_ScriptWaitActorMoveDone ; $63a2
	xor a, a ; $63a5
	ld bc, $0f00 ; $63a6
	ld de, $1300 ; $63a9
	farcall FarPtr_MovePlayerToPosition ; $63ac
	ld a, $00 ; $63af
	ld bc, $1100 ; $63b1
	ld de, $1300 ; $63b4
	farcall FarPtr_ScriptSetActorMoveTarget ; $63b7
	ld a, $00 ; $63ba
	farcall FarPtr_ScriptWaitActorMoveDone ; $63bc
	ld a, $00 ; $63bf
	ld b, a ; $63c1
	ld a, $07 ; $63c2
	farcall FarPtr_FaceActorTowardActor ; $63c4
	push af ; $63c7
	ld a, $14 ; $63c8
	farcall FarPtr_WaitScriptFrames ; $63ca
	pop af ; $63cd
	ld a, $00 ; $63ce
	ld d, $02 ; $63d0
	farcall FarPtr_ScriptSetActorAnimation ; $63d2
	ld a, $00 ; $63d5
	farcall FarPtr_ScriptWaitActorIdle ; $63d7
	ld a, $07 ; $63da
	ld d, $03 ; $63dc
	farcall FarPtr_ScriptSetActorAnimation ; $63de
	ld a, $07 ; $63e1
	farcall FarPtr_ScriptWaitActorIdle ; $63e3
	ld a, $00 ; $63e6
	ld b, $40 ; $63e8
	farcall FarPtr_SetActorFacing ; $63ea
	ldh a, [hRomBank] ; $63ed
	ld b, a ; $63ef
	ld a, $00 ; $63f0
	ld de, $6424 ; $63f2
	farcall FarPtr_ScriptSetActorScript ; $63f5
	push af ; $63f8
	ld a, $78 ; $63f9
	farcall FarPtr_WaitScriptFrames ; $63fb
	pop af ; $63fe
	ld a, $00 ; $63ff
	farcall FarPtr_SetActorNullScript ; $6401
	ld a, $00 ; $6404
	ld d, $01 ; $6406
	farcall FarPtr_ScriptSetActorAnimation ; $6408
	ld a, $00 ; $640b
	ld bc, $0020 ; $640d
	farcall FarPtr_ScriptSetActorMoveSpeed ; $6410
	ld a, $07 ; $6413
	ld b, a ; $6415
	ld a, $00 ; $6416
	farcall FarPtr_FaceActorTowardActor ; $6418
	ld a, $01 ; $641b
	ld [$c294], a ; $641d
	ld [wStoryModeExitLocationRequest], a ; $6420
	ret ; $6423
	INCBIN "data/bank_027/d_6424.bin" ; $6424, 35 bytes
End5ServiceAceMapScripts_27:
	; $6447, 14 bytes (map_tree)
	dw End5ServiceAceEntryPoints_27 ; slot 0 EntryPoints
	dw End5ServiceAceExitTriggers_27 ; slot 1 ExitTriggers
	dw End5ServiceAceActors_27 ; slot 2 Actors
	dw End5ServiceAceNpcScripts_27 ; slot 3 NpcScripts
	dw End5ServiceAceFacingScripts_27 ; slot 4 FacingScripts
	dw End5ServiceAceTileTriggers_27 ; slot 5 TileTriggers
	dw End5ServiceAceInitScript_27 ; slot 6 InitScript
End5ServiceAceActors_27:
	; $6455, 248 bytes (map_actors)
	map_actor $0000, $785d, $1100, $1900, $80, $2f, $01, $00
	map_actor $0000, $785d, $2100, $1500, $c0, $2f, $01, $07
	map_actor $0000, $785d, $1600, $1300, $40, $30, $01, $00
	map_actor $0000, $785d, $1d00, $1700, $c0, $31, $01, $00
	map_actor $0000, $785d, $2900, $2900, $00, $4c, $01, $00
	map_actor $0000, $785d, $2100, $1100, $00, $33, $01, $00
	map_actor $0000, $785d, $0900, $0f00, $00, $34, $01, $00
	map_actor $0000, $7867, $0b00, $1900, $80, $30, $01, $06
	map_actor $0000, $785d, $0d00, $0f00, $80, $3a, $01, $00
	map_actor $0000, $785d, $1500, $0b00, $80, $33, $01, $00
	map_actor $0000, $785d, $1d00, $0b00, $80, $3c, $01, $04
	map_actor $0000, $785d, $1b00, $0900, $40, $3b, $01, $00
	map_actor $0000, $785d, $1d00, $0f00, $80, $3c, $01, $00
	map_actor $0000, $785d, $1900, $0f00, $00, $3b, $01, $06
	map_actor $0000, $785d, $2900, $2900, $00, $4f, $01, $00
	map_actor $0000, $785d, $1b00, $1200, $40, $3a, $01, $00
	map_actor $0000, $785d, $1900, $0900, $40, $35, $01, $00
	map_actor_end
End5ServiceAceEntryPoints_27:
	; $654d, 17 bytes (map_entries)
	map_entry $01, $00, $0d00, $1d00, $0000
	map_entry $02, $40, $0500, $1700, $0000
	db $ff
End5ServiceAceExitTriggers_27:
	; $655e, 17 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_27, $22, $01
	map_script $02, $ff, $0000, MapScriptNop_27, $0e, $01
	db $ff
Func_27_656f:
	farcall FarPtr_BeginCutsceneScriptMode ; $656f
	ld bc, $0010 ; $6572
	farcall FarPtr_SetPlayerMoveSpeed ; $6575
	xor a, a ; $6578
	ld bc, $0f00 ; $6579
	ld de, $1100 ; $657c
	farcall FarPtr_MovePlayerToPosition ; $657f
	ld c, $08 ; $6582
	call BeginFadeIn ; $6584
	ld a, $00 ; $6587
	ld bc, $0018 ; $6589
	farcall FarPtr_ScriptSetActorMoveSpeed ; $658c
	ld a, $00 ; $658f
	ld bc, $0d00 ; $6591
	ld de, $1700 ; $6594
	farcall FarPtr_ScriptSetActorMoveTarget ; $6597
	ld a, $00 ; $659a
	farcall FarPtr_ScriptWaitActorMoveDone ; $659c
	ld a, $00 ; $659f
	ld bc, $0f00 ; $65a1
	ld de, $1700 ; $65a4
	farcall FarPtr_ScriptSetActorMoveTarget ; $65a7
	ld a, $00 ; $65aa
	farcall FarPtr_ScriptWaitActorMoveDone ; $65ac
	ld a, $00 ; $65af
	ld bc, $0f00 ; $65b1
	ld de, $1100 ; $65b4
	farcall FarPtr_ScriptSetActorMoveTarget ; $65b7
	ld a, $00 ; $65ba
	farcall FarPtr_ScriptWaitActorMoveDone ; $65bc
	ld bc, $0018 ; $65bf
	farcall FarPtr_SetPlayerMoveSpeed ; $65c2
	xor a, a ; $65c5
	ld bc, $1900 ; $65c6
	ld de, $1100 ; $65c9
	farcall FarPtr_MovePlayerToPosition ; $65cc
	ld a, $00 ; $65cf
	ld bc, $1900 ; $65d1
	ld de, $1100 ; $65d4
	farcall FarPtr_ScriptSetActorMoveTarget ; $65d7
	ld a, $00 ; $65da
	farcall FarPtr_ScriptWaitActorMoveDone ; $65dc
	push af ; $65df
	ld a, $14 ; $65e0
	farcall FarPtr_WaitScriptFrames ; $65e2
	pop af ; $65e5
	ld a, $12 ; $65e6
	ld b, $80 ; $65e8
	farcall FarPtr_SetActorFacing ; $65ea
	push af ; $65ed
	ld a, $28 ; $65ee
	farcall FarPtr_WaitScriptFrames ; $65f0
	pop af ; $65f3
	sound $97 ; $65f4
	ld a, $07 ; $65f6
	ld bc, $1c00 ; $65f8
	ld de, $1100 ; $65fb
	farcall FarPtr_ScriptSetActorPosition ; $65fe
	ld a, $12 ; $6601
	ld d, $02 ; $6603
	farcall FarPtr_ScriptSetActorAnimation ; $6605
	push af ; $6608
	ld a, $3c ; $6609
	farcall FarPtr_WaitScriptFrames ; $660b
	pop af ; $660e
	ld a, $01 ; $660f
	ld [$c294], a ; $6611
	ld [wStoryModeExitLocationRequest], a ; $6614
	farcall FarPtr_EndCutsceneScriptMode ; $6617
	ret ; $661a
End5ServiceAceNpcScripts_27:
	ds 1, $ff ; $661b, fill
End5ServiceAceFacingScripts_27:
	ds 1, $ff ; $661c, fill
End5ServiceAceTileTriggers_27:
	ds 1, $ff ; $661d, fill
End5ServiceAceInitScript_27:
	call Func_27_656f ; $661e
	ret ; $6621
End4JrCourtMapScripts_27:
	; $6622, 14 bytes (map_tree)
	dw End4JrCourtEntryPoints_27 ; slot 0 EntryPoints
	dw End4JrCourtExitTriggers_27 ; slot 1 ExitTriggers
	dw End4JrCourtActors_27 ; slot 2 Actors
	dw End4JrCourtNpcScripts_27 ; slot 3 NpcScripts
	dw End4JrCourtFacingScripts_27 ; slot 4 FacingScripts
	dw End4JrCourtTileTriggers_27 ; slot 5 TileTriggers
	dw End4JrCourtInitScript_27 ; slot 6 InitScript
End4JrCourtActors_27:
	; $6630, 234 bytes (map_actors)
	map_actor $0000, $785d, $1300, $1300, $40, $37, $01, $00
	map_actor $0000, $785d, $2300, $1700, $80, $68, $01, $05
	map_actor $0000, $785d, $0500, $1500, $00, $6b, $01, $04
	map_actor $0000, $785d, $1300, $0d00, $00, $67, $01, $07
	map_actor $0000, $785d, $1f00, $1500, $80, $6a, $01, $07
	map_actor $0000, $785d, $2500, $0900, $00, $66, $01, $03
	map_actor $0000, $785d, $3100, $1500, $00, $65, $01, $06
	map_actor $0000, $785d, $3d00, $1900, $80, $64, $01, $04
	map_actor $0000, $682f, $3100, $0700, $40, $69, $01, $03
	map_actor $0000, $795d, $0800, $0b00, $40, $54, $01, $05
	map_actor $0000, $79c4, $0c00, $1700, $c0, $54, $01, $00
	map_actor $0000, $7893, $1800, $0b00, $40, $54, $01, $00
	map_actor $0000, $78f6, $1c00, $1700, $c0, $54, $01, $05
	map_actor $0000, $795d, $3400, $0b00, $40, $54, $01, $05
	map_actor $0000, $79c4, $3800, $1700, $c0, $54, $01, $00
	map_actor $0000, $785d, $4000, $4000, $c0, $53, $01, $00
	map_actor_end
End4JrCourtActorsAlt_27:
	; $671a, 192 bytes (map_actors)
	map_actor $0000, $785d, $1300, $1300, $40, $37, $01, $00
	map_actor $0000, $785d, $2300, $1700, $80, $68, $01, $05
	map_actor $0000, $785d, $0500, $1500, $00, $6b, $01, $04
	map_actor $0000, $785d, $2100, $1500, $40, $67, $01, $07
	map_actor $0000, $785d, $0500, $1300, $00, $6a, $01, $07
	map_actor $0000, $785d, $1b00, $1300, $40, $66, $01, $03
	map_actor $0000, $785d, $1b00, $1500, $c0, $65, $01, $06
	map_actor $0000, $785d, $3700, $0700, $80, $64, $01, $04
	map_actor $0000, $785d, $3500, $0700, $00, $69, $01, $03
	map_actor $0000, $795d, $0800, $0b00, $40, $54, $01, $05
	map_actor $0000, $79c4, $0c00, $1700, $c0, $54, $01, $00
	map_actor $0000, $7893, $2a00, $0b00, $40, $54, $01, $00
	map_actor $0000, $78f6, $2e00, $1700, $c0, $54, $01, $05
	map_actor_end
End4JrCourtEntryPoints_27:
	; $67da, 10 bytes (map_entries)
	map_entry $01, $c0, $1300, $2100, $0000
	db $ff, $c9
End4JrCourtExitTriggers_27:
	; $67e4, 17 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_27, $08, $05
	map_script $0f, $ff, $0000, MapScriptNop_27, $0b, $0f
	db $ff
End4JrCourtNpcScripts_27:
	ds 1, $ff ; $67f5, fill
End4JrCourtFacingScripts_27:
	ds 1, $ff ; $67f6, fill
End4JrCourtTileTriggers_27:
	ds 1, $ff ; $67f7, fill
End4JrCourtInitScript_27:
	test_flag $05, 7 ; $67f8
	jr z, Label_27_6808 ; $67fb
	ldh a, [hRomBank] ; $67fd
	ld hl, End4JrCourtActorsAlt_27 ; $67ff
	farcall FarPtr_ScriptRespawnLocationActors ; $6802
	farcall FarPtr_BeginCutsceneScriptMode ; $6805
Label_27_6808:
	ld a, [wStoryModeEntryPoint] ; $6808
	cp a, $01 ; $680b
	jp z, Label_27_6a54 ; $680d
	ret ; $6810
	INCBIN "data/bank_027/d_6811.bin" ; $6811, 85 bytes
Func_27_6866:
	push af ; $6866
	ld a, $0f ; $6867
	farcall FarPtr_WaitScriptFrames ; $6869
	pop af ; $686c
	ld a, $07 ; $686d
	ld b, a ; $686f
	ld a, $03 ; $6870
	farcall FarPtr_FaceActorTowardActor ; $6872
	push af ; $6875
	ld a, $0a ; $6876
	farcall FarPtr_WaitScriptFrames ; $6878
	pop af ; $687b
	ld a, $07 ; $687c
	ld b, a ; $687e
	ld a, $00 ; $687f
	farcall FarPtr_FaceActorTowardActor ; $6881
	push af ; $6884
	ld a, $1e ; $6885
	farcall FarPtr_WaitScriptFrames ; $6887
	pop af ; $688a
	ld bc, $0020 ; $688b
	farcall FarPtr_SetPlayerMoveSpeed ; $688e
	ld a, $07 ; $6891
	ld b, $00 ; $6893
	farcall FarPtr_MovePlayerToActor ; $6895
	farcall FarPtr_WaitPlayerMoveDone ; $6898
	ld a, $03 ; $689b
	ld b, a ; $689d
	ld a, $07 ; $689e
	farcall FarPtr_FaceActorTowardActor ; $68a0
	ld a, $07 ; $68a3
	ld d, $03 ; $68a5
	farcall FarPtr_ScriptSetActorAnimation ; $68a7
	ld a, $07 ; $68aa
	farcall FarPtr_ScriptWaitActorIdle ; $68ac
	ld a, $07 ; $68af
	ld b, $40 ; $68b1
	farcall FarPtr_SetActorFacing ; $68b3
	push af ; $68b6
	ld a, $0a ; $68b7
	farcall FarPtr_WaitScriptFrames ; $68b9
	pop af ; $68bc
	ldh a, [hRomBank] ; $68bd
	ld b, a ; $68bf
	ld a, $07 ; $68c0
	ld de, $6918 ; $68c2
	farcall FarPtr_ScriptSetActorScript ; $68c5
	push af ; $68c8
	ld a, $14 ; $68c9
	farcall FarPtr_WaitScriptFrames ; $68cb
	pop af ; $68ce
	ld a, $00 ; $68cf
	ld b, $00 ; $68d1
	farcall FarPtr_MovePlayerToActor ; $68d3
	ld a, $03 ; $68d6
	ld b, $40 ; $68d8
	farcall FarPtr_SetActorFacing ; $68da
	ld a, $00 ; $68dd
	ld b, $00 ; $68df
	farcall FarPtr_MovePlayerToActor ; $68e1
	ld a, $07 ; $68e4
	farcall FarPtr_WaitActorScriptDone ; $68e6
	ld a, $00 ; $68e9
	ld b, a ; $68eb
	ld a, $07 ; $68ec
	farcall FarPtr_FaceActorTowardActor ; $68ee
	ld a, $07 ; $68f1
	ld d, $02 ; $68f3
	farcall FarPtr_ScriptSetActorAnimation ; $68f5
	ld a, $07 ; $68f8
	farcall FarPtr_ScriptWaitActorIdle ; $68fa
	ld a, $07 ; $68fd
	ld d, $03 ; $68ff
	farcall FarPtr_ScriptSetActorAnimation ; $6901
	ld a, $07 ; $6904
	farcall FarPtr_ScriptWaitActorIdle ; $6906
	push af ; $6909
	ld a, $0f ; $690a
	farcall FarPtr_WaitScriptFrames ; $690c
	pop af ; $690f
	ld a, $07 ; $6910
	ld b, $c0 ; $6912
	farcall FarPtr_SetActorFacing ; $6914
	ret ; $6917
	INCBIN "data/bank_027/d_6918.bin" ; $6918, 57 bytes
Func_27_6951:
	farcall FarPtr_BeginCutsceneScriptMode ; $6951
	ld a, $03 ; $6954
	ld b, $40 ; $6956
	farcall FarPtr_SetActorFacing ; $6958
	call Func_27_6866 ; $695b
	ld a, $00 ; $695e
	ld b, $c0 ; $6960
	farcall FarPtr_SetActorFacing ; $6962
	push af ; $6965
	ld a, $0f ; $6966
	farcall FarPtr_WaitScriptFrames ; $6968
	pop af ; $696b
	ld a, $03 ; $696c
	ld d, $02 ; $696e
	farcall FarPtr_ScriptSetActorAnimation ; $6970
	ld a, $03 ; $6973
	farcall FarPtr_ScriptWaitActorIdle ; $6975
	ld a, $03 ; $6978
	ld b, $00 ; $697a
	farcall FarPtr_SetActorFacing ; $697c
	push af ; $697f
	ld a, $0f ; $6980
	farcall FarPtr_WaitScriptFrames ; $6982
	pop af ; $6985
	ld a, $00 ; $6986
	ld b, $00 ; $6988
	farcall FarPtr_SetActorFacing ; $698a
	ld a, $07 ; $698d
	ld b, $00 ; $698f
	farcall FarPtr_SetActorFacing ; $6991
	push af ; $6994
	ld a, $1e ; $6995
	farcall FarPtr_WaitScriptFrames ; $6997
	pop af ; $699a
	ldh a, [hRomBank] ; $699b
	ld b, a ; $699d
	ld a, $0e ; $699e
	ld de, $6811 ; $69a0
	farcall FarPtr_ScriptSetActorScript ; $69a3
	ldh a, [hRomBank] ; $69a6
	ld b, a ; $69a8
	ld a, $0f ; $69a9
	ld de, $6820 ; $69ab
	farcall FarPtr_ScriptSetActorScript ; $69ae
	ld a, $0f ; $69b1
	farcall FarPtr_WaitActorScriptDone ; $69b3
	xor a, a ; $69b6
	ld bc, $1700 ; $69b7
	ld de, $1100 ; $69ba
	farcall FarPtr_MovePlayerToPosition ; $69bd
	ldh a, [hRomBank] ; $69c0
	ld b, a ; $69c2
	ld a, $07 ; $69c3
	ld de, $692f ; $69c5
	farcall FarPtr_ScriptSetActorScript ; $69c8
	ldh a, [hRomBank] ; $69cb
	ld b, a ; $69cd
	ld a, $00 ; $69ce
	ld de, $6940 ; $69d0
	farcall FarPtr_ScriptSetActorScript ; $69d3
	farcall FarPtr_WaitPlayerMoveDone ; $69d6
	ld a, $07 ; $69d9
	farcall FarPtr_WaitActorScriptDone ; $69db
	push af ; $69de
	ld a, $14 ; $69df
	farcall FarPtr_WaitScriptFrames ; $69e1
	pop af ; $69e4
	ld a, $01 ; $69e5
	ld [$c294], a ; $69e7
	ld [wStoryModeExitLocationRequest], a ; $69ea
	ret ; $69ed
Label_27_69ee:
	farcall FarPtr_BeginCutsceneScriptMode ; $69ee
	ld a, $03 ; $69f1
	ld b, a ; $69f3
	ld a, $00 ; $69f4
	farcall FarPtr_FaceActorTowardActor ; $69f6
	push af ; $69f9
	ld a, $1e ; $69fa
	farcall FarPtr_WaitScriptFrames ; $69fc
	pop af ; $69ff
	ld a, $00 ; $6a00
	ld b, a ; $6a02
	ld a, $03 ; $6a03
	farcall FarPtr_FaceActorTowardActor ; $6a05
	call Func_27_6a7d ; $6a08
	ld a, $00 ; $6a0b
	ld b, $c0 ; $6a0d
	farcall FarPtr_SetActorFacing ; $6a0f
	push af ; $6a12
	ld a, $0f ; $6a13
	farcall FarPtr_WaitScriptFrames ; $6a15
	pop af ; $6a18
	ld a, $03 ; $6a19
	ld d, $02 ; $6a1b
	farcall FarPtr_ScriptSetActorAnimation ; $6a1d
	ld a, $03 ; $6a20
	farcall FarPtr_ScriptWaitActorIdle ; $6a22
	ld a, $03 ; $6a25
	ld b, $00 ; $6a27
	farcall FarPtr_SetActorFacing ; $6a29
	push af ; $6a2c
	ld a, $0f ; $6a2d
	farcall FarPtr_WaitScriptFrames ; $6a2f
	pop af ; $6a32
	ld a, $00 ; $6a33
	ld b, $00 ; $6a35
	farcall FarPtr_SetActorFacing ; $6a37
	ld a, $07 ; $6a3a
	ld b, $00 ; $6a3c
	farcall FarPtr_SetActorFacing ; $6a3e
	push af ; $6a41
	ld a, $1e ; $6a42
	farcall FarPtr_WaitScriptFrames ; $6a44
	pop af ; $6a47
	call Func_27_6b21 ; $6a48
	ld a, $01 ; $6a4b
	ld [$c294], a ; $6a4d
	ld [wStoryModeExitLocationRequest], a ; $6a50
	ret ; $6a53
Label_27_6a54:
	xor a, a ; $6a54
	ld bc, $1300 ; $6a55
	ld de, $1500 ; $6a58
	farcall FarPtr_MovePlayerToPosition ; $6a5b
	ld c, $04 ; $6a5e
	call BeginFadeIn ; $6a60
	ld a, $00 ; $6a63
	ld bc, $1300 ; $6a65
	ld de, $1500 ; $6a68
	farcall FarPtr_ScriptSetActorMoveTarget ; $6a6b
	ld a, $00 ; $6a6e
	farcall FarPtr_ScriptWaitActorMoveDone ; $6a70
	test_flag $05, 7 ; $6a73
	jp nz, Label_27_69ee ; $6a76
	call Func_27_6951 ; $6a79
	ret ; $6a7c
Func_27_6a7d:
	ld bc, $0020 ; $6a7d
	farcall FarPtr_SetPlayerMoveSpeed ; $6a80
	ld a, $03 ; $6a83
	ld b, $00 ; $6a85
	farcall FarPtr_SetActorFacing ; $6a87
	ld a, $08 ; $6a8a
	ld b, $00 ; $6a8c
	farcall FarPtr_MovePlayerToActor ; $6a8e
	farcall FarPtr_WaitPlayerMoveDone ; $6a91
	ld a, $00 ; $6a94
	ld b, $00 ; $6a96
	farcall FarPtr_SetActorFacing ; $6a98
	ld a, $02 ; $6a9b
	ld b, $00 ; $6a9d
	farcall FarPtr_SetActorFacing ; $6a9f
	ld a, $08 ; $6aa2
	farcall FarPtr_SetActorNullScript ; $6aa4
	ld a, $08 ; $6aa7
	ld b, $80 ; $6aa9
	farcall FarPtr_SetActorFacing ; $6aab
	ld a, $08 ; $6aae
	ld d, $02 ; $6ab0
	farcall FarPtr_ScriptSetActorAnimation ; $6ab2
	ld a, $08 ; $6ab5
	farcall FarPtr_ScriptWaitActorIdle ; $6ab7
	ld a, $00 ; $6aba
	ld b, $00 ; $6abc
	farcall FarPtr_MovePlayerToActor ; $6abe
	ld a, $08 ; $6ac1
	ld bc, $1500 ; $6ac3
	ld de, $1500 ; $6ac6
	farcall FarPtr_ScriptSetActorMoveTarget ; $6ac9
	ld a, $09 ; $6acc
	ld bc, $1500 ; $6ace
	ld de, $1700 ; $6ad1
	farcall FarPtr_ScriptSetActorMoveTarget ; $6ad4
	ld a, $09 ; $6ad7
	farcall FarPtr_ScriptWaitActorMoveDone ; $6ad9
	ld a, $09 ; $6adc
	ld b, $80 ; $6ade
	farcall FarPtr_SetActorFacing ; $6ae0
	ld a, $03 ; $6ae3
	ld b, $40 ; $6ae5
	farcall FarPtr_SetActorFacing ; $6ae7
	ld a, $08 ; $6aea
	ld d, $02 ; $6aec
	farcall FarPtr_ScriptSetActorAnimation ; $6aee
	ld a, $08 ; $6af1
	farcall FarPtr_ScriptWaitActorIdle ; $6af3
	ld a, $09 ; $6af6
	ld d, $03 ; $6af8
	farcall FarPtr_ScriptSetActorAnimation ; $6afa
	push af ; $6afd
	ld a, $0f ; $6afe
	farcall FarPtr_WaitScriptFrames ; $6b00
	pop af ; $6b03
	ld a, $00 ; $6b04
	ld b, $c0 ; $6b06
	farcall FarPtr_SetActorFacing ; $6b08
	ld a, $02 ; $6b0b
	ld b, $c0 ; $6b0d
	farcall FarPtr_SetActorFacing ; $6b0f
	ld a, $08 ; $6b12
	ld b, $c0 ; $6b14
	farcall FarPtr_SetActorFacing ; $6b16
	ld a, $09 ; $6b19
	ld b, $c0 ; $6b1b
	farcall FarPtr_SetActorFacing ; $6b1d
	ret ; $6b20
Func_27_6b21:
	ld a, $03 ; $6b21
	ld b, $00 ; $6b23
	farcall FarPtr_SetActorFacing ; $6b25
	push af ; $6b28
	ld a, $1e ; $6b29
	farcall FarPtr_WaitScriptFrames ; $6b2b
	pop af ; $6b2e
	ld a, $02 ; $6b2f
	farcall FarPtr_SetActorNullScript ; $6b31
	xor a, a ; $6b34
	ld bc, $1900 ; $6b35
	ld de, $1100 ; $6b38
	farcall FarPtr_MovePlayerToPosition ; $6b3b
	ldh a, [hRomBank] ; $6b3e
	ld b, a ; $6b40
	ld a, $08 ; $6b41
	ld de, $6bf0 ; $6b43
	farcall FarPtr_ScriptSetActorScript ; $6b46
	ldh a, [hRomBank] ; $6b49
	ld b, a ; $6b4b
	ld a, $09 ; $6b4c
	ld de, $6c04 ; $6b4e
	farcall FarPtr_ScriptSetActorScript ; $6b51
	ld a, $00 ; $6b54
	ld bc, $1b00 ; $6b56
	ld de, $1900 ; $6b59
	farcall FarPtr_ScriptSetActorMoveTarget ; $6b5c
	push af ; $6b5f
	ld a, $0a ; $6b60
	farcall FarPtr_WaitScriptFrames ; $6b62
	pop af ; $6b65
	ld a, $02 ; $6b66
	ld bc, $1900 ; $6b68
	ld de, $1500 ; $6b6b
	farcall FarPtr_ScriptSetActorMoveTarget ; $6b6e
	ld a, $00 ; $6b71
	farcall FarPtr_ScriptWaitActorMoveDone ; $6b73
	ld a, $00 ; $6b76
	ld b, $c0 ; $6b78
	farcall FarPtr_SetActorFacing ; $6b7a
	ld a, $02 ; $6b7d
	ld b, $c0 ; $6b7f
	farcall FarPtr_SetActorFacing ; $6b81
	push af ; $6b84
	ld a, $3c ; $6b85
	farcall FarPtr_WaitScriptFrames ; $6b87
	pop af ; $6b8a
	ld a, $0f ; $6b8b
	ld [$c294], a ; $6b8d
	ld [wStoryModeExitLocationRequest], a ; $6b90
	ret ; $6b93
	INCBIN "data/bank_027/d_6b94.bin" ; $6b94, 132 bytes
End3DormEntMapScripts_27:
	; $6c18, 14 bytes (map_tree)
	dw End3DormEntEntryPoints_27 ; slot 0 EntryPoints
	dw End3DormEntExitTriggers_27 ; slot 1 ExitTriggers
	dw End3DormEntActors_27 ; slot 2 Actors
	dw End3DormEntNpcScripts_27 ; slot 3 NpcScripts
	dw End3DormEntFacingScripts_27 ; slot 4 FacingScripts
	dw End3DormEntTileTriggers_27 ; slot 5 TileTriggers
	dw End3DormEntInitScript_27 ; slot 6 InitScript
End3DormEntActors_27:
	; $6c26, 66 bytes (map_actors)
	map_actor $0000, $785d, $0100, $0100, $40, $49, $01, $00
	map_actor $0000, $785d, $0100, $0100, $40, $29, $01, $00
	map_actor $0000, $785d, $0100, $0100, $40, $4c, $01, $00
	map_actor $0000, $785d, $0100, $0100, $40, $4d, $01, $00
	map_actor_end
End3DormEntEntryPoints_27:
	; $6c68, 25 bytes (map_entries)
	map_entry $01, $c0, $1600, $1b00, $0000
	map_entry $02, $40, $1600, $0d00, $0000
	map_entry $0f, $c0, $1600, $1b00, $0000
	db $ff
End3DormEntExitTriggers_27:
	ds 1, $ff ; $6c81, fill
End3DormEntNpcScripts_27:
	ds 1, $ff ; $6c82, fill
End3DormEntFacingScripts_27:
	ds 1, $ff ; $6c83, fill
End3DormEntTileTriggers_27:
	ds 1, $ff ; $6c84, fill
End3DormEntInitScript_27:
	farcall FarPtr_BeginCutsceneScriptMode ; $6c85
	ld a, [wStoryModeEntryPoint] ; $6c88
	cp a, $01 ; $6c8b
	call z, Func_27_6c94 ; $6c8d
	farcall FarPtr_EndCutsceneScriptMode ; $6c90
	ret ; $6c93
Func_27_6c94:
	test_flag $05, 7 ; $6c94
	jr z, Label_27_6caf ; $6c97
	ldh a, [hRomBank] ; $6c99
	ld b, a ; $6c9b
	ld a, $02 ; $6c9c
	ld de, $785d ; $6c9e
	farcall FarPtr_ScriptSetActorScript ; $6ca1
	ld a, $02 ; $6ca4
	ld bc, $3f00 ; $6ca6
	ld de, $3f00 ; $6ca9
	farcall FarPtr_ScriptSetActorPosition ; $6cac
Label_27_6caf:
	ld a, $03 ; $6caf
	ld bc, $0010 ; $6cb1
	farcall FarPtr_ScriptSetActorMoveSpeed ; $6cb4
	ld a, $04 ; $6cb7
	ld bc, $0010 ; $6cb9
	farcall FarPtr_ScriptSetActorMoveSpeed ; $6cbc
	ld a, $00 ; $6cbf
	ld bc, $0010 ; $6cc1
	farcall FarPtr_ScriptSetActorMoveSpeed ; $6cc4
	ld bc, $0010 ; $6cc7
	farcall FarPtr_SetPlayerMoveSpeed ; $6cca
	ld a, $00 ; $6ccd
	ld bc, $1600 ; $6ccf
	ld de, $1f00 ; $6cd2
	farcall FarPtr_ScriptSetActorPosition ; $6cd5
	ld a, $03 ; $6cd8
	ld bc, $1600 ; $6cda
	ld de, $1d00 ; $6cdd
	farcall FarPtr_ScriptSetActorPosition ; $6ce0
	ld a, $03 ; $6ce3
	ld b, $c0 ; $6ce5
	farcall FarPtr_SetActorFacing ; $6ce7
	ld c, $20 ; $6cea
	call BeginFadeIn ; $6cec
	ld a, $03 ; $6cef
	ld bc, $1600 ; $6cf1
	ld de, $1100 ; $6cf4
	farcall FarPtr_ScriptSetActorMoveTarget ; $6cf7
	xor a, a ; $6cfa
	ld bc, $1600 ; $6cfb
	ld de, $0f00 ; $6cfe
	farcall FarPtr_MovePlayerToPosition ; $6d01
	ld a, $00 ; $6d04
	ld bc, $1600 ; $6d06
	ld de, $1400 ; $6d09
	farcall FarPtr_ScriptSetActorMoveTarget ; $6d0c
	ld a, $00 ; $6d0f
	farcall FarPtr_ScriptWaitActorMoveDone ; $6d11
	ld a, $03 ; $6d14
	ld bc, $1600 ; $6d16
	ld de, $1100 ; $6d19
	farcall FarPtr_ScriptSetActorMoveTarget ; $6d1c
	ld a, $00 ; $6d1f
	ld bc, $1600 ; $6d21
	ld de, $1300 ; $6d24
	farcall FarPtr_ScriptSetActorMoveTarget ; $6d27
	ld a, $00 ; $6d2a
	farcall FarPtr_ScriptWaitActorMoveDone ; $6d2c
	push af ; $6d2f
	ld a, $14 ; $6d30
	farcall FarPtr_WaitScriptFrames ; $6d32
	pop af ; $6d35
	ld a, $03 ; $6d36
	farcall FarPtr_ScriptWaitActorMoveDone ; $6d38
	ld a, $00 ; $6d3b
	ld b, a ; $6d3d
	ld a, $03 ; $6d3e
	farcall FarPtr_FaceActorTowardActor ; $6d40
	ld a, $03 ; $6d43
	ld d, $03 ; $6d45
	farcall FarPtr_ScriptSetActorAnimation ; $6d47
	ld a, $03 ; $6d4a
	farcall FarPtr_ScriptWaitActorIdle ; $6d4c
	ld a, $00 ; $6d4f
	ld d, $02 ; $6d51
	farcall FarPtr_ScriptSetActorAnimation ; $6d53
	ld bc, $0018 ; $6d56
	farcall FarPtr_SetPlayerMoveSpeed ; $6d59
	xor a, a ; $6d5c
	ld bc, $1600 ; $6d5d
	ld de, $0b00 ; $6d60
	farcall FarPtr_MovePlayerToPosition ; $6d63
	farcall FarPtr_WaitPlayerMoveDone ; $6d66
	push af ; $6d69
	ld a, $14 ; $6d6a
	farcall FarPtr_WaitScriptFrames ; $6d6c
	pop af ; $6d6f
	xor a, a ; $6d70
	ld bc, $1100 ; $6d71
	ld de, $0b00 ; $6d74
	farcall FarPtr_MovePlayerToPosition ; $6d77
	farcall FarPtr_WaitPlayerMoveDone ; $6d7a
	push af ; $6d7d
	ld a, $0a ; $6d7e
	farcall FarPtr_WaitScriptFrames ; $6d80
	pop af ; $6d83
	xor a, a ; $6d84
	ld bc, $1a00 ; $6d85
	ld de, $0b00 ; $6d88
	farcall FarPtr_MovePlayerToPosition ; $6d8b
	farcall FarPtr_WaitPlayerMoveDone ; $6d8e
	push af ; $6d91
	ld a, $0a ; $6d92
	farcall FarPtr_WaitScriptFrames ; $6d94
	pop af ; $6d97
	xor a, a ; $6d98
	ld bc, $1600 ; $6d99
	ld de, $0b00 ; $6d9c
	farcall FarPtr_MovePlayerToPosition ; $6d9f
	farcall FarPtr_WaitPlayerMoveDone ; $6da2
	push af ; $6da5
	ld a, $1e ; $6da6
	farcall FarPtr_WaitScriptFrames ; $6da8
	pop af ; $6dab
	xor a, a ; $6dac
	ld bc, $1600 ; $6dad
	ld de, $1000 ; $6db0
	farcall FarPtr_MovePlayerToPosition ; $6db3
	ld a, $00 ; $6db6
	ld d, $02 ; $6db8
	farcall FarPtr_ScriptSetActorAnimation ; $6dba
	ld a, $00 ; $6dbd
	farcall FarPtr_ScriptWaitActorIdle ; $6dbf
	push af ; $6dc2
	ld a, $14 ; $6dc3
	farcall FarPtr_WaitScriptFrames ; $6dc5
	pop af ; $6dc8
	ld bc, $0010 ; $6dc9
	farcall FarPtr_SetPlayerMoveSpeed ; $6dcc
	sound $97 ; $6dcf
	ld a, $05 ; $6dd1
	ld bc, $1780 ; $6dd3
	ld de, $0f00 ; $6dd6
	farcall FarPtr_ScriptSetActorPosition ; $6dd9
	ld a, $03 ; $6ddc
	ld d, $02 ; $6dde
	farcall FarPtr_ScriptSetActorAnimation ; $6de0
	ld a, $03 ; $6de3
	farcall FarPtr_ScriptWaitActorIdle ; $6de5
	ld a, $05 ; $6de8
	ld bc, $0100 ; $6dea
	ld de, $0100 ; $6ded
	farcall FarPtr_ScriptSetActorPosition ; $6df0
	ld a, $03 ; $6df3
	ld bc, $1600 ; $6df5
	ld de, $0b00 ; $6df8
	farcall FarPtr_ScriptSetActorMoveTarget ; $6dfb
	ld a, $03 ; $6dfe
	farcall FarPtr_ScriptWaitActorMoveDone ; $6e00
	ld a, $04 ; $6e03
	ld bc, $1700 ; $6e05
	ld de, $0b00 ; $6e08
	farcall FarPtr_ScriptSetActorPosition ; $6e0b
	push af ; $6e0e
	ld a, $3c ; $6e0f
	farcall FarPtr_WaitScriptFrames ; $6e11
	pop af ; $6e14
	ld a, $00 ; $6e15
	ld b, $40 ; $6e17
	farcall FarPtr_SetActorFacing ; $6e19
	push af ; $6e1c
	ld a, $14 ; $6e1d
	farcall FarPtr_WaitScriptFrames ; $6e1f
	pop af ; $6e22
	ld a, $00 ; $6e23
	ld d, $04 ; $6e25
	farcall FarPtr_ScriptSetActorAnimation ; $6e27
	ld a, $00 ; $6e2a
	farcall FarPtr_ScriptWaitActorIdle ; $6e2c
	push af ; $6e2f
	ld a, $14 ; $6e30
	farcall FarPtr_WaitScriptFrames ; $6e32
	pop af ; $6e35
	ld a, $00 ; $6e36
	ld b, $c0 ; $6e38
	farcall FarPtr_SetActorFacing ; $6e3a
	ld a, $03 ; $6e3d
	ld b, $02 ; $6e3f
	farcall FarPtr_SetActorActive ; $6e41
	ld a, $03 ; $6e44
	ld bc, $1500 ; $6e46
	ld de, $0b00 ; $6e49
	farcall FarPtr_ScriptSetActorPosition ; $6e4c
	ld a, [$c94d] ; $6e4f
	or a, a ; $6e52
	jr nz, Label_27_6e68 ; $6e53
	ld d, $28 ; $6e55
	ld a, $04 ; $6e57
	farcall FarPtr_GetActorStateAddr ; $6e59
	ld c, l ; $6e5c
	ld b, h ; $6e5d
	farcall FarPtr_04_2c ; $6e5e
	ld a, $04 ; $6e61
	ld d, $01 ; $6e63
	farcall FarPtr_ScriptSetActorAnimation ; $6e65
Label_27_6e68:
	ld a, $03 ; $6e68
	ld bc, $1500 ; $6e6a
	ld de, $0f00 ; $6e6d
	farcall FarPtr_ScriptSetActorMoveTarget ; $6e70
	ld a, $03 ; $6e73
	farcall FarPtr_ScriptWaitActorMoveDone ; $6e75
	ld a, $04 ; $6e78
	ld bc, $1700 ; $6e7a
	ld de, $0f00 ; $6e7d
	farcall FarPtr_ScriptSetActorMoveTarget ; $6e80
	ld a, $04 ; $6e83
	farcall FarPtr_ScriptWaitActorMoveDone ; $6e85
	sound $98 ; $6e88
	ld a, $06 ; $6e8a
	ld bc, $1780 ; $6e8c
	ld de, $1100 ; $6e8f
	farcall FarPtr_ScriptSetActorPosition ; $6e92
	push af ; $6e95
	ld a, $3c ; $6e96
	farcall FarPtr_WaitScriptFrames ; $6e98
	pop af ; $6e9b
	ld a, $03 ; $6e9c
	ld d, $04 ; $6e9e
	farcall FarPtr_ScriptSetActorAnimation ; $6ea0
	ld a, $03 ; $6ea3
	farcall FarPtr_ScriptWaitActorIdle ; $6ea5
	ld a, $06 ; $6ea8
	ld bc, $0100 ; $6eaa
	ld de, $0100 ; $6ead
	farcall FarPtr_ScriptSetActorPosition ; $6eb0
	ld a, $04 ; $6eb3
	ld b, a ; $6eb5
	ld a, $03 ; $6eb6
	farcall FarPtr_FaceActorTowardActor ; $6eb8
	push af ; $6ebb
	ld a, $3c ; $6ebc
	farcall FarPtr_WaitScriptFrames ; $6ebe
	pop af ; $6ec1
	ld a, $00 ; $6ec2
	ld b, a ; $6ec4
	ld a, $03 ; $6ec5
	farcall FarPtr_FaceActorTowardActor ; $6ec7
	ld a, $04 ; $6eca
	ld d, $03 ; $6ecc
	farcall FarPtr_ScriptSetActorAnimation ; $6ece
	ld a, $04 ; $6ed1
	farcall FarPtr_ScriptWaitActorIdle ; $6ed3
	ld a, $0f ; $6ed6
	ld [$c294], a ; $6ed8
	ld [wStoryModeExitLocationRequest], a ; $6edb
	ret ; $6ede
EndRestaurantEntMapScripts_27:
	; $6edf, 14 bytes (map_tree)
	dw EndRestaurantEntEntryPoints_27 ; slot 0 EntryPoints
	dw EndRestaurantEntExitTriggers_27 ; slot 1 ExitTriggers
	dw EndRestaurantEntActors_27 ; slot 2 Actors
	dw EndRestaurantEntNpcScripts_27 ; slot 3 NpcScripts
	dw EndRestaurantEntFacingScripts_27 ; slot 4 FacingScripts
	dw EndRestaurantEntTileTriggers_27 ; slot 5 TileTriggers
	dw EndRestaurantEntInitScript_27 ; slot 6 InitScript
EndRestaurantEntActors_27:
	; $6eed, 10 bytes (map_actors)
	map_actor_end
EndRestaurantEntEntryPoints_27:
	; $6ef7, 9 bytes (map_entries)
	map_entry $01, $40, $0700, $0840, $0000
	db $ff
EndRestaurantEntExitTriggers_27:
	; $6f00, 73 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_27, $09, $01
	map_script $02, $ff, $0000, MapScriptNop_27, $0d, $01
	map_script $03, $ff, $0000, MapScriptNop_27, $10, $01
	map_script $04, $ff, $0000, MapScriptNop_27, $07, $02
	map_script $05, $ff, $0000, MapScriptNop_27, $0b, $01
	map_script $06, $ff, $0000, MapScriptNop_27, $0f, $01
	map_script $0d, $ff, $0000, MapScriptNop_27, $0c, $01
	map_script $0e, $ff, $0000, MapScriptNop_27, $09, $0f
	map_script $0f, $ff, $0000, MapScriptNop_27, $0f, $0f
	db $ff
EndRestaurantEntNpcScripts_27:
	ds 1, $ff ; $6f49, fill
EndRestaurantEntFacingScripts_27:
	ds 1, $ff ; $6f4a, fill
EndRestaurantEntTileTriggers_27:
	ds 1, $ff ; $6f4b, fill
EndRestaurantEntInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $6f4c
	cp a, $01 ; $6f4f
	jr nz, Label_27_6f56 ; $6f51
	call Func_27_6f57 ; $6f53
Label_27_6f56:
	ret ; $6f56
Func_27_6f57:
	ldh a, [hRomBank] ; $6f57
	ld hl, $710d ; $6f59
	farcall FarPtr_ScriptRespawnLocationActors ; $6f5c
	farcall FarPtr_BeginCutsceneScriptMode ; $6f5f
	test_flag $05, 7 ; $6f62
	jr z, Label_27_6f7d ; $6f65
	ldh a, [hRomBank] ; $6f67
	ld b, a ; $6f69
	ld a, $02 ; $6f6a
	ld de, $785d ; $6f6c
	farcall FarPtr_ScriptSetActorScript ; $6f6f
	ld a, $02 ; $6f72
	ld bc, $3f00 ; $6f74
	ld de, $3f00 ; $6f77
	farcall FarPtr_ScriptSetActorPosition ; $6f7a
Label_27_6f7d:
	ld a, $00 ; $6f7d
	ld bc, $3f00 ; $6f7f
	ld de, $3f00 ; $6f82
	farcall FarPtr_ScriptSetActorPosition ; $6f85
	ld a, $06 ; $6f88
	ld bc, $3f00 ; $6f8a
	ld de, $3f00 ; $6f8d
	farcall FarPtr_ScriptSetActorPosition ; $6f90
	ld a, $07 ; $6f93
	ld bc, $3f00 ; $6f95
	ld de, $3f00 ; $6f98
	farcall FarPtr_ScriptSetActorPosition ; $6f9b
	ld a, $08 ; $6f9e
	ld bc, $3f00 ; $6fa0
	ld de, $3f00 ; $6fa3
	farcall FarPtr_ScriptSetActorPosition ; $6fa6
	ld c, $04 ; $6fa9
	call BeginFadeIn ; $6fab
	ld a, $06 ; $6fae
	ld bc, $4100 ; $6fb0
	ld de, $0d00 ; $6fb3
	farcall FarPtr_ScriptSetActorPosition ; $6fb6
	ld a, $06 ; $6fb9
	ld bc, $1b00 ; $6fbb
	ld de, $0d00 ; $6fbe
	farcall FarPtr_ScriptSetActorMoveTarget ; $6fc1
	ld a, $00 ; $6fc4
	ld bc, $4300 ; $6fc6
	ld de, $0d00 ; $6fc9
	farcall FarPtr_ScriptSetActorPosition ; $6fcc
	ld a, $00 ; $6fcf
	ld bc, $1d00 ; $6fd1
	ld de, $0d00 ; $6fd4
	farcall FarPtr_ScriptSetActorMoveTarget ; $6fd7
	push af ; $6fda
	ld a, $0f ; $6fdb
	farcall FarPtr_WaitScriptFrames ; $6fdd
	pop af ; $6fe0
	xor a, a ; $6fe1
	ld bc, $1b00 ; $6fe2
	ld de, $0d00 ; $6fe5
	farcall FarPtr_MovePlayerToPosition ; $6fe8
	ld a, $00 ; $6feb
	farcall FarPtr_ScriptWaitActorMoveDone ; $6fed
	push af ; $6ff0
	ld a, $1e ; $6ff1
	farcall FarPtr_WaitScriptFrames ; $6ff3
	pop af ; $6ff6
	ld a, $00 ; $6ff7
	ld b, a ; $6ff9
	ld a, $06 ; $6ffa
	farcall FarPtr_FaceActorTowardActor ; $6ffc
	ld a, $00 ; $6fff
	ld d, $03 ; $7001
	farcall FarPtr_ScriptSetActorAnimation ; $7003
	ld a, $00 ; $7006
	farcall FarPtr_ScriptWaitActorIdle ; $7008
	ld a, $06 ; $700b
	ld b, $c0 ; $700d
	farcall FarPtr_SetActorFacing ; $700f
	push af ; $7012
	ld a, $0f ; $7013
	farcall FarPtr_WaitScriptFrames ; $7015
	pop af ; $7018
	ld a, $00 ; $7019
	ld b, $c0 ; $701b
	farcall FarPtr_SetActorFacing ; $701d
	ld a, $00 ; $7020
	ld d, $03 ; $7022
	farcall FarPtr_ScriptSetActorAnimation ; $7024
	ld a, $00 ; $7027
	farcall FarPtr_ScriptWaitActorIdle ; $7029
	push af ; $702c
	ld a, $1e ; $702d
	farcall FarPtr_WaitScriptFrames ; $702f
	pop af ; $7032
	call Func_27_716b ; $7033
	push af ; $7036
	ld a, $0f ; $7037
	farcall FarPtr_WaitScriptFrames ; $7039
	pop af ; $703c
	sound $97 ; $703d
	ld a, $03 ; $703f
	ld bc, $1c00 ; $7041
	ld de, $0b00 ; $7044
	farcall FarPtr_ScriptSetActorPosition ; $7047
	push af ; $704a
	ld a, $1e ; $704b
	farcall FarPtr_WaitScriptFrames ; $704d
	pop af ; $7050
	ld a, $03 ; $7051
	ld bc, $3f00 ; $7053
	ld de, $3f00 ; $7056
	farcall FarPtr_ScriptSetActorPosition ; $7059
	ld a, $06 ; $705c
	ld b, $80 ; $705e
	farcall FarPtr_SetActorFacing ; $7060
	push af ; $7063
	ld a, $0f ; $7064
	farcall FarPtr_WaitScriptFrames ; $7066
	pop af ; $7069
	ld a, $00 ; $706a
	ld b, $80 ; $706c
	farcall FarPtr_SetActorFacing ; $706e
	xor a, a ; $7071
	ld bc, $1800 ; $7072
	ld de, $0d00 ; $7075
	farcall FarPtr_MovePlayerToPosition ; $7078
	push af ; $707b
	ld a, $0f ; $707c
	farcall FarPtr_WaitScriptFrames ; $707e
	pop af ; $7081
	ld a, $07 ; $7082
	ld bc, $1500 ; $7084
	ld de, $0980 ; $7087
	farcall FarPtr_ScriptSetActorPosition ; $708a
	push af ; $708d
	ld a, $0f ; $708e
	farcall FarPtr_WaitScriptFrames ; $7090
	pop af ; $7093
	ld a, $07 ; $7094
	ld bc, $0010 ; $7096
	farcall FarPtr_ScriptSetActorMoveSpeed ; $7099
	ld a, $07 ; $709c
	ld bc, $1500 ; $709e
	ld de, $0d00 ; $70a1
	farcall FarPtr_ScriptSetActorMoveTarget ; $70a4
	ld a, $07 ; $70a7
	farcall FarPtr_ScriptWaitActorMoveDone ; $70a9
	ld a, $07 ; $70ac
	ld b, $00 ; $70ae
	farcall FarPtr_SetActorFacing ; $70b0
	ld a, $08 ; $70b3
	ld bc, $1500 ; $70b5
	ld de, $0900 ; $70b8
	farcall FarPtr_ScriptSetActorPosition ; $70bb
	push af ; $70be
	ld a, $0f ; $70bf
	farcall FarPtr_WaitScriptFrames ; $70c1
	pop af ; $70c4
	ld a, $08 ; $70c5
	ld bc, $0010 ; $70c7
	farcall FarPtr_ScriptSetActorMoveSpeed ; $70ca
	ld a, $08 ; $70cd
	ld bc, $1500 ; $70cf
	ld de, $0b00 ; $70d2
	farcall FarPtr_ScriptSetActorMoveTarget ; $70d5
	ld a, $08 ; $70d8
	farcall FarPtr_ScriptWaitActorMoveDone ; $70da
	call Func_27_71bf ; $70dd
	ld a, $08 ; $70e0
	ld b, $00 ; $70e2
	farcall FarPtr_SetActorFacing ; $70e4
	push af ; $70e7
	ld a, $0f ; $70e8
	farcall FarPtr_WaitScriptFrames ; $70ea
	pop af ; $70ed
	ld a, $06 ; $70ee
	ld d, $02 ; $70f0
	farcall FarPtr_ScriptSetActorAnimation ; $70f2
	ld a, $06 ; $70f5
	farcall FarPtr_ScriptWaitActorIdle ; $70f7
	ld a, $07 ; $70fa
	ld b, $40 ; $70fc
	farcall FarPtr_SetActorFacing ; $70fe
	ld a, $0e ; $7101
	ld [$c294], a ; $7103
	ld [wStoryModeExitLocationRequest], a ; $7106
	farcall FarPtr_EndCutsceneScriptMode ; $7109
	ret ; $710c
	INCBIN "data/bank_027/d_710d.bin" ; $710d, 94 bytes
Func_27_716b:
	sound $71 ; $716b
	ld b, $14 ; $716d
	ld c, $08 ; $716f
	ld d, $06 ; $7171
	ld e, $15 ; $7173
	ld h, $02 ; $7175
	ld l, $02 ; $7177
	farcall FarPtr_CopySceneTilemapRect ; $7179
	ld b, $00 ; $717c
	ld c, $15 ; $717e
	ld d, $14 ; $7180
	ld e, $08 ; $7182
	ld h, $02 ; $7184
	ld l, $02 ; $7186
	farcall FarPtr_CopySceneTilemapRect ; $7188
	push af ; $718b
	ld a, $02 ; $718c
	farcall FarPtr_WaitScriptFrames ; $718e
	pop af ; $7191
	ld b, $02 ; $7192
	ld c, $15 ; $7194
	ld d, $14 ; $7196
	ld e, $08 ; $7198
	ld h, $02 ; $719a
	ld l, $02 ; $719c
	farcall FarPtr_CopySceneTilemapRect ; $719e
	push af ; $71a1
	ld a, $02 ; $71a2
	farcall FarPtr_WaitScriptFrames ; $71a4
	pop af ; $71a7
	ld b, $04 ; $71a8
	ld c, $15 ; $71aa
	ld d, $14 ; $71ac
	ld e, $08 ; $71ae
	ld h, $02 ; $71b0
	ld l, $02 ; $71b2
	farcall FarPtr_CopySceneTilemapRect ; $71b4
	push af ; $71b7
	ld a, $02 ; $71b8
	farcall FarPtr_WaitScriptFrames ; $71ba
	pop af ; $71bd
	ret ; $71be
Func_27_71bf:
	sound $71 ; $71bf
	ld b, $04 ; $71c1
	ld c, $15 ; $71c3
	ld d, $14 ; $71c5
	ld e, $08 ; $71c7
	ld h, $02 ; $71c9
	ld l, $02 ; $71cb
	farcall FarPtr_CopySceneTilemapRect ; $71cd
	push af ; $71d0
	ld a, $01 ; $71d1
	farcall FarPtr_WaitScriptFrames ; $71d3
	pop af ; $71d6
	ld b, $02 ; $71d7
	ld c, $15 ; $71d9
	ld d, $14 ; $71db
	ld e, $08 ; $71dd
	ld h, $02 ; $71df
	ld l, $02 ; $71e1
	farcall FarPtr_CopySceneTilemapRect ; $71e3
	push af ; $71e6
	ld a, $01 ; $71e7
	farcall FarPtr_WaitScriptFrames ; $71e9
	pop af ; $71ec
	ld b, $00 ; $71ed
	ld c, $15 ; $71ef
	ld d, $14 ; $71f1
	ld e, $08 ; $71f3
	ld h, $02 ; $71f5
	ld l, $02 ; $71f7
	farcall FarPtr_CopySceneTilemapRect ; $71f9
	push af ; $71fc
	ld a, $01 ; $71fd
	farcall FarPtr_WaitScriptFrames ; $71ff
	pop af ; $7202
	ld b, $06 ; $7203
	ld c, $15 ; $7205
	ld d, $14 ; $7207
	ld e, $08 ; $7209
	ld h, $02 ; $720b
	ld l, $02 ; $720d
	farcall FarPtr_CopySceneTilemapRect ; $720f
	ret ; $7212
End1MainBldgMapScripts_27:
	; $7213, 14 bytes (map_tree)
	dw End1MainBldgEntryPoints_27 ; slot 0 EntryPoints
	dw End1MainBldgExitTriggers_27 ; slot 1 ExitTriggers
	dw End1MainBldgActors_27 ; slot 2 Actors
	dw End1MainBldgNpcScripts_27 ; slot 3 NpcScripts
	dw End1MainBldgFacingScripts_27 ; slot 4 FacingScripts
	dw End1MainBldgTileTriggers_27 ; slot 5 TileTriggers
	dw End1MainBldgInitScript_27 ; slot 6 InitScript
End1MainBldgActors_27:
	; $7221, 150 bytes (map_actors)
	map_actor $0000, $785d, $1500, $3d00, $00, $4d, $01, $00
	map_actor $0000, $785d, $1500, $3d00, $00, $4c, $01, $00
	map_actor $0000, $785d, $1500, $3d00, $00, $53, $01, $00
	map_actor $0000, $785d, $1500, $3d00, $40, $63, $01, $00
	map_actor $0000, $785d, $1500, $3d00, $00, $4f, $01, $00
	map_actor $0000, $785d, $1800, $1100, $40, $63, $01, $00
	map_actor $0000, $785d, $1a00, $1500, $c0, $5c, $01, $00
	map_actor $0000, $785d, $1600, $1500, $c0, $5b, $01, $00
	map_actor $0000, $785d, $1900, $1700, $c0, $5a, $01, $00
	map_actor $0000, $785d, $0100, $1900, $c0, $4a, $01, $00
	map_actor_end
End1MainBldgEntryPoints_27:
	; $72b7, 25 bytes (map_entries)
	map_entry $01, $40, $1800, $1100, $0000
	map_entry $02, $c0, $1800, $1100, $0000
	map_entry $0f, $c0, $1800, $2f00, $0000
	db $ff
End1MainBldgExitTriggers_27:
	; $72d0, 41 bytes (map_scripts)
	map_script $01, $ff, $0000, MapScriptNop_27, $05, $01
	map_script $02, $ff, $0000, MapScriptNop_27, $1b, $01
	map_script $03, $ff, $0000, MapScriptNop_27, $1b, $0f
	map_script $05, $ff, $0000, MapScriptNop_27, $1e, $02
	map_script $0f, $ff, $0000, MapScriptNop_27, $05, $0f
	db $ff
End1MainBldgNpcScripts_27:
	ds 1, $ff ; $72f9, fill
End1MainBldgFacingScripts_27:
	ds 1, $ff ; $72fa, fill
End1MainBldgTileTriggers_27:
	ds 1, $ff ; $72fb, fill
End1MainBldgInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $72fc
	cp a, $01 ; $72ff
	jp z, Label_27_730a ; $7301
	cp a, $02 ; $7304
	jp z, Label_27_760e ; $7306
	ret ; $7309
Label_27_730a:
	ld a, $00 ; $730a
	ld bc, $0010 ; $730c
	farcall FarPtr_ScriptSetActorMoveSpeed ; $730f
	xor a, a ; $7312
	ld [wStoryModeShowLocationName], a ; $7313
	ld a, $06 ; $7316
	ld bc, $1800 ; $7318
	ld de, $0d00 ; $731b
	farcall FarPtr_ScriptSetActorPosition ; $731e
	ld a, $00 ; $7321
	ld bc, $1800 ; $7323
	ld de, $3700 ; $7326
	farcall FarPtr_ScriptSetActorPosition ; $7329
	ld a, $0b ; $732c
	ld bc, $3f00 ; $732e
	ld de, $3f00 ; $7331
	farcall FarPtr_ScriptSetActorPosition ; $7334
	ld a, $0a ; $7337
	ld bc, $3f00 ; $7339
	ld de, $3f00 ; $733c
	farcall FarPtr_ScriptSetActorPosition ; $733f
	ld a, $09 ; $7342
	ld bc, $3f00 ; $7344
	ld de, $3f00 ; $7347
	farcall FarPtr_ScriptSetActorPosition ; $734a
	ld a, $08 ; $734d
	ld bc, $3f00 ; $734f
	ld de, $3f00 ; $7352
	farcall FarPtr_ScriptSetActorPosition ; $7355
	ld a, $0c ; $7358
	ld bc, $3f00 ; $735a
	ld de, $3f00 ; $735d
	farcall FarPtr_ScriptSetActorPosition ; $7360
	test_flag $05, 7 ; $7363
	jr z, Label_27_737e ; $7366
	ldh a, [hRomBank] ; $7368
	ld b, a ; $736a
	ld a, $02 ; $736b
	ld de, $785d ; $736d
	farcall FarPtr_ScriptSetActorScript ; $7370
	ld a, $02 ; $7373
	ld bc, $3f00 ; $7375
	ld de, $3f00 ; $7378
	farcall FarPtr_ScriptSetActorPosition ; $737b
Label_27_737e:
	ld bc, $0040 ; $737e
	farcall FarPtr_SetPlayerMoveSpeed ; $7381
	xor a, a ; $7384
	ld bc, $1800 ; $7385
	ld de, $1200 ; $7388
	farcall FarPtr_MovePlayerToPosition ; $738b
	farcall FarPtr_WaitPlayerMoveDone ; $738e
	ld c, $04 ; $7391
	call BeginFadeIn ; $7393
	call WaitFadeEnd ; $7396
	ld a, $00 ; $7399
	ld bc, $1800 ; $739b
	ld de, $2100 ; $739e
	farcall FarPtr_ScriptSetActorMoveTarget ; $73a1
	push af ; $73a4
	ld a, $14 ; $73a5
	farcall FarPtr_WaitScriptFrames ; $73a7
	pop af ; $73aa
	ld a, $00 ; $73ab
	ld bc, $1800 ; $73ad
	ld de, $2000 ; $73b0
	farcall FarPtr_ScriptSetActorPosition ; $73b3
	ld a, $00 ; $73b6
	ld b, $c0 ; $73b8
	farcall FarPtr_SetActorFacing ; $73ba
	ld a, $06 ; $73bd
	ld bc, $0024 ; $73bf
	farcall FarPtr_ScriptSetActorMoveSpeed ; $73c2
	ld a, $06 ; $73c5
	ld bc, $1800 ; $73c7
	ld de, $1400 ; $73ca
	farcall FarPtr_ScriptSetActorMoveTarget ; $73cd
	ld a, $06 ; $73d0
	farcall FarPtr_ScriptWaitActorMoveDone ; $73d2
	ld a, $06 ; $73d5
	ld d, $04 ; $73d7
	farcall FarPtr_ScriptSetActorAnimation ; $73d9
	ld a, $06 ; $73dc
	farcall FarPtr_ScriptWaitActorIdle ; $73de
	ld a, $06 ; $73e1
	ld b, $c0 ; $73e3
	farcall FarPtr_SetActorFacing ; $73e5
	ld a, $06 ; $73e8
	ld d, $03 ; $73ea
	farcall FarPtr_ScriptSetActorAnimation ; $73ec
	ld a, $06 ; $73ef
	farcall FarPtr_ScriptWaitActorIdle ; $73f1
	ld a, $06 ; $73f4
	ld bc, $0020 ; $73f6
	farcall FarPtr_ScriptSetActorMoveSpeed ; $73f9
	ld a, $06 ; $73fc
	ld b, $40 ; $73fe
	farcall FarPtr_SetActorFacing ; $7400
	ld a, $06 ; $7403
	ld de, $ff80 ; $7405
	farcall FarPtr_ScriptSetActorJumpVelocity ; $7408
	ld a, $06 ; $740b
	farcall FarPtr_ScriptWaitActorJumpDone ; $740d
	ld a, $06 ; $7410
	ld bc, $1800 ; $7412
	ld de, $1700 ; $7415
	farcall FarPtr_ScriptSetActorMoveTarget ; $7418
	ld a, $06 ; $741b
	farcall FarPtr_ScriptWaitActorMoveDone ; $741d
	sound $98 ; $7420
	ld a, $03 ; $7422
	ld bc, $1980 ; $7424
	ld de, $15c0 ; $7427
	farcall FarPtr_ScriptSetActorPosition ; $742a
	ld a, $06 ; $742d
	ld bc, $0010 ; $742f
	farcall FarPtr_ScriptSetActorMoveSpeed ; $7432
	ld a, $03 ; $7435
	ld bc, $0010 ; $7437
	farcall FarPtr_ScriptSetActorMoveSpeed ; $743a
	ld a, $03 ; $743d
	ld bc, $1980 ; $743f
	ld de, $18c0 ; $7442
	farcall FarPtr_ScriptSetActorMoveTarget ; $7445
	ld a, $06 ; $7448
	ld bc, $1800 ; $744a
	ld de, $1a00 ; $744d
	farcall FarPtr_ScriptSetActorMoveTarget ; $7450
	ld a, $06 ; $7453
	farcall FarPtr_ScriptWaitActorMoveDone ; $7455
	ld a, $03 ; $7458
	ld bc, $3f00 ; $745a
	ld de, $3f00 ; $745d
	farcall FarPtr_ScriptSetActorPosition ; $7460
	ld a, $06 ; $7463
	ld bc, $1800 ; $7465
	ld de, $1600 ; $7468
	farcall FarPtr_ScriptSetActorMoveTarget ; $746b
	ld a, $06 ; $746e
	farcall FarPtr_ScriptWaitActorMoveDone ; $7470
	push af ; $7473
	ld a, $1e ; $7474
	farcall FarPtr_WaitScriptFrames ; $7476
	pop af ; $7479
	ld a, $06 ; $747a
	ld d, $02 ; $747c
	farcall FarPtr_ScriptSetActorAnimation ; $747e
	sound $97 ; $7481
	ld a, $04 ; $7483
	ld bc, $1980 ; $7485
	ld de, $14c0 ; $7488
	farcall FarPtr_ScriptSetActorPosition ; $748b
	push af ; $748e
	ld a, $14 ; $748f
	farcall FarPtr_WaitScriptFrames ; $7491
	pop af ; $7494
	ld a, $04 ; $7495
	ld bc, $3f00 ; $7497
	ld de, $3f00 ; $749a
	farcall FarPtr_ScriptSetActorPosition ; $749d
	ld a, $06 ; $74a0
	ld bc, $0020 ; $74a2
	farcall FarPtr_ScriptSetActorMoveSpeed ; $74a5
	ld a, $06 ; $74a8
	ld de, $ff80 ; $74aa
	farcall FarPtr_ScriptSetActorJumpVelocity ; $74ad
	ld a, $06 ; $74b0
	farcall FarPtr_ScriptWaitActorJumpDone ; $74b2
	ld a, $06 ; $74b5
	ld bc, $1800 ; $74b7
	ld de, $2000 ; $74ba
	farcall FarPtr_ScriptSetActorMoveTarget ; $74bd
	push af ; $74c0
	ld a, $1e ; $74c1
	farcall FarPtr_WaitScriptFrames ; $74c3
	pop af ; $74c6
	ld bc, $d040 ; $74c7
	ld a, $06 ; $74ca
	farcall FarPtr_GetActorStateAddr ; $74cc
	ld e, l ; $74cf
	ld d, h ; $74d0
	farcall FarPtr_04_1e ; $74d1
	ld a, $00 ; $74d4
	ld bc, $1800 ; $74d6
	ld de, $1e00 ; $74d9
	farcall FarPtr_ScriptSetActorMoveTarget ; $74dc
	push af ; $74df
	ld a, $14 ; $74e0
	farcall FarPtr_WaitScriptFrames ; $74e2
	pop af ; $74e5
	call Func_27_7595 ; $74e6
	ld a, $06 ; $74e9
	farcall FarPtr_ScriptWaitActorMoveDone ; $74eb
	ld a, $06 ; $74ee
	ld d, $02 ; $74f0
	farcall FarPtr_ScriptSetActorAnimation ; $74f2
	sound $96 ; $74f5
	ld a, $05 ; $74f7
	ld bc, $1900 ; $74f9
	ld de, $1e00 ; $74fc
	farcall FarPtr_ScriptSetActorPosition ; $74ff
	push af ; $7502
	ld a, $3c ; $7503
	farcall FarPtr_WaitScriptFrames ; $7505
	pop af ; $7508
	ld a, $05 ; $7509
	ld bc, $3f00 ; $750b
	ld de, $3f00 ; $750e
	farcall FarPtr_ScriptSetActorPosition ; $7511
	ld a, $06 ; $7514
	ld bc, $1700 ; $7516
	ld de, $2200 ; $7519
	farcall FarPtr_ScriptSetActorMoveTarget ; $751c
	ld a, $06 ; $751f
	farcall FarPtr_ScriptWaitActorMoveDone ; $7521
	ld a, $00 ; $7524
	ld b, a ; $7526
	ld a, $06 ; $7527
	farcall FarPtr_FaceActorTowardActor ; $7529
	push af ; $752c
	ld a, $14 ; $752d
	farcall FarPtr_WaitScriptFrames ; $752f
	pop af ; $7532
	ld a, $06 ; $7533
	ld bc, $1900 ; $7535
	ld de, $2400 ; $7538
	farcall FarPtr_ScriptSetActorMoveTarget ; $753b
	ld a, $06 ; $753e
	farcall FarPtr_ScriptWaitActorMoveDone ; $7540
	ld a, $01 ; $7543
	farcall FarPtr_SetActorNullScript ; $7545
	ld a, $00 ; $7548
	ld b, a ; $754a
	ld a, $06 ; $754b
	farcall FarPtr_FaceActorTowardActor ; $754d
	ld a, $06 ; $7550
	ld d, $02 ; $7552
	farcall FarPtr_ScriptSetActorAnimation ; $7554
	ld a, $06 ; $7557
	farcall FarPtr_ScriptWaitActorIdle ; $7559
	push af ; $755c
	ld a, $14 ; $755d
	farcall FarPtr_WaitScriptFrames ; $755f
	pop af ; $7562
	ld a, $07 ; $7563
	ld bc, $1a80 ; $7565
	ld de, $2280 ; $7568
	farcall FarPtr_ScriptSetActorPosition ; $756b
	push af ; $756e
	ld a, $3c ; $756f
	farcall FarPtr_WaitScriptFrames ; $7571
	pop af ; $7574
	ld a, $07 ; $7575
	ld bc, $3f00 ; $7577
	ld de, $3f00 ; $757a
	farcall FarPtr_ScriptSetActorPosition ; $757d
	ld a, $06 ; $7580
	ld d, $02 ; $7582
	farcall FarPtr_ScriptSetActorAnimation ; $7584
	ld a, $06 ; $7587
	farcall FarPtr_ScriptWaitActorIdle ; $7589
	ld a, $01 ; $758c
	ld [$c294], a ; $758e
	ld [wStoryModeExitLocationRequest], a ; $7591
	ret ; $7594
Func_27_7595:
	sound $70 ; $7595
	ld a, $01 ; $7597
	farcall FarPtr_SetActorNullScript ; $7599
	ld a, $03 ; $759c
	farcall FarPtr_SetScreenShake ; $759e
	push af ; $75a1
	ld a, $0a ; $75a2
	farcall FarPtr_WaitScriptFrames ; $75a4
	pop af ; $75a7
	ld a, $00 ; $75a8
	farcall FarPtr_SetScreenShake ; $75aa
	ld a, $00 ; $75ad
	ld bc, $0040 ; $75af
	farcall FarPtr_ScriptSetActorMoveSpeed ; $75b2
	xor a, a ; $75b5
	ld bc, $1800 ; $75b6
	ld de, $2400 ; $75b9
	farcall FarPtr_MovePlayerToPosition ; $75bc
	ld a, $00 ; $75bf
	ld bc, $1700 ; $75c1
	ld de, $2400 ; $75c4
	farcall FarPtr_ScriptSetActorMoveTarget ; $75c7
	ld a, $00 ; $75ca
	ld de, rJOYP ; $75cc
	farcall FarPtr_ScriptSetActorJumpVelocity ; $75cf
	ld a, $00 ; $75d2
	farcall FarPtr_GetActorStateAddr ; $75d4
	ld c, l ; $75d7
	ld b, h ; $75d8
	ld hl, $0037 ; $75d9
	add hl, bc ; $75dc
	ld a, [hl] ; $75dd
	or a, $40 ; $75de
	ld [hl], a ; $75e0
	push af ; $75e1
	ld a, $1e ; $75e2
	farcall FarPtr_WaitScriptFrames ; $75e4
	pop af ; $75e7
	ld a, $00 ; $75e8
	ld d, $02 ; $75ea
	farcall FarPtr_ScriptSetActorAnimation ; $75ec
	ld a, $00 ; $75ef
	farcall FarPtr_ScriptWaitActorIdle ; $75f1
	push af ; $75f4
	ld a, $1e ; $75f5
	farcall FarPtr_WaitScriptFrames ; $75f7
	pop af ; $75fa
	ldh a, [hRomBank] ; $75fb
	ld b, a ; $75fd
	ld a, $00 ; $75fe
	ld de, $7607 ; $7600
	farcall FarPtr_ScriptSetActorScript ; $7603
	ret ; $7606
	INCBIN "data/bank_027/d_7607.bin" ; $7607, 7 bytes
Label_27_760e:
	ld a, $06 ; $760e
	ld bc, $3f00 ; $7610
	ld de, $3f00 ; $7613
	farcall FarPtr_ScriptSetActorPosition ; $7616
	test_flag $05, 7 ; $7619
	jp z, Label_27_7659 ; $761c
	ld a, $02 ; $761f
	farcall FarPtr_SetActorNullScript ; $7621
	ld a, $02 ; $7624
	ld bc, $3f00 ; $7626
	ld de, $3f00 ; $7629
	farcall FarPtr_ScriptSetActorPosition ; $762c
	ld a, [$c94d] ; $762f
	ld d, $58 ; $7632
	add a, d ; $7634
	ld d, a ; $7635
	ld a, $0a ; $7636
	farcall FarPtr_GetActorStateAddr ; $7638
	ld c, l ; $763b
	ld b, h ; $763c
	farcall FarPtr_04_2c ; $763d
	ld a, $0a ; $7640
	ld d, $01 ; $7642
	farcall FarPtr_ScriptSetActorAnimation ; $7644
	ld a, $0c ; $7647
	ld bc, $1a00 ; $7649
	ld de, $1100 ; $764c
	farcall FarPtr_ScriptSetActorPosition ; $764f
	ld a, $0c ; $7652
	ld b, $40 ; $7654
	farcall FarPtr_SetActorFacing ; $7656
Label_27_7659:
	ld a, [$c90d] ; $7659
	ld d, $56 ; $765c
	add a, d ; $765e
	ld d, a ; $765f
	ld a, $00 ; $7660
	farcall FarPtr_GetActorStateAddr ; $7662
	ld c, l ; $7665
	ld b, h ; $7666
	farcall FarPtr_04_2c ; $7667
	ld a, $00 ; $766a
	ld d, $01 ; $766c
	farcall FarPtr_ScriptSetActorAnimation ; $766e
	ld a, $00 ; $7671
	ld bc, $1700 ; $7673
	ld de, $1700 ; $7676
	farcall FarPtr_ScriptSetActorPosition ; $7679
	ld a, $00 ; $767c
	ld b, $c0 ; $767e
	farcall FarPtr_SetActorFacing ; $7680
	ld c, $04 ; $7683
	call BeginFadeIn ; $7685
	call WaitFadeEnd ; $7688
	ld a, $3c ; $768b
	call Func_27_7856 ; $768d
	test_flag $05, 7 ; $7690
	jp z, Label_27_7704 ; $7693
	ld a, $0a ; $7696
	ld b, a ; $7698
	ld a, $00 ; $7699
	farcall FarPtr_FaceActorsTowardEachOther ; $769b
	ld a, $1e ; $769e
	call Func_27_7856 ; $76a0
	ld a, $00 ; $76a3
	ld d, $03 ; $76a5
	farcall FarPtr_ScriptSetActorAnimation ; $76a7
	ld a, $0a ; $76aa
	ld d, $03 ; $76ac
	farcall FarPtr_ScriptSetActorAnimation ; $76ae
	ld a, $0a ; $76b1
	farcall FarPtr_ScriptWaitActorIdle ; $76b3
	ld a, $1e ; $76b6
	call Func_27_7856 ; $76b8
	ld a, $0a ; $76bb
	ld b, $c0 ; $76bd
	farcall FarPtr_SetActorFacing ; $76bf
	ld a, $1e ; $76c2
	call Func_27_7856 ; $76c4
	ld a, $0c ; $76c7
	ld d, $02 ; $76c9
	farcall FarPtr_ScriptSetActorAnimation ; $76cb
	ld a, $0c ; $76ce
	farcall FarPtr_ScriptWaitActorIdle ; $76d0
	ld a, $32 ; $76d3
	call Func_27_7856 ; $76d5
	ld a, $0c ; $76d8
	ld b, a ; $76da
	ld a, $08 ; $76db
	farcall FarPtr_FaceActorsTowardEachOther ; $76dd
	ld a, $08 ; $76e0
	ld d, $03 ; $76e2
	farcall FarPtr_ScriptSetActorAnimation ; $76e4
	ld a, $0c ; $76e7
	ld d, $03 ; $76e9
	farcall FarPtr_ScriptSetActorAnimation ; $76eb
	ld a, $0c ; $76ee
	farcall FarPtr_ScriptWaitActorIdle ; $76f0
	ld a, $0c ; $76f3
	ld b, $40 ; $76f5
	farcall FarPtr_SetActorFacing ; $76f7
	ld a, $08 ; $76fa
	ld b, $40 ; $76fc
	farcall FarPtr_SetActorFacing ; $76fe
	jp Label_27_7748 ; $7701
Label_27_7704:
	ld a, $0b ; $7704
	ld b, a ; $7706
	ld a, $00 ; $7707
	farcall FarPtr_FaceActorsTowardEachOther ; $7709
	ld a, $1e ; $770c
	call Func_27_7856 ; $770e
	ld a, $00 ; $7711
	ld d, $03 ; $7713
	farcall FarPtr_ScriptSetActorAnimation ; $7715
	ld a, $0b ; $7718
	ld d, $03 ; $771a
	farcall FarPtr_ScriptSetActorAnimation ; $771c
	ld a, $0b ; $771f
	farcall FarPtr_ScriptWaitActorIdle ; $7721
	ld a, $0a ; $7724
	call Func_27_7856 ; $7726
	ld a, $00 ; $7729
	ld b, $c0 ; $772b
	farcall FarPtr_SetActorFacing ; $772d
	ld a, $0b ; $7730
	ld b, $c0 ; $7732
	farcall FarPtr_SetActorFacing ; $7734
	ld a, $14 ; $7737
	call Func_27_7856 ; $7739
	ld a, $08 ; $773c
	ld d, $03 ; $773e
	farcall FarPtr_ScriptSetActorAnimation ; $7740
	ld a, $08 ; $7743
	farcall FarPtr_ScriptWaitActorIdle ; $7745
Label_27_7748:
	ld a, $28 ; $7748
	call Func_27_7856 ; $774a
	ld a, $09 ; $774d
	ld d, $03 ; $774f
	farcall FarPtr_ScriptSetActorAnimation ; $7751
	ld a, $0a ; $7754
	ld d, $03 ; $7756
	farcall FarPtr_ScriptSetActorAnimation ; $7758
	ld a, $00 ; $775b
	ld d, $03 ; $775d
	farcall FarPtr_ScriptSetActorAnimation ; $775f
	ld a, $0b ; $7762
	ld d, $03 ; $7764
	farcall FarPtr_ScriptSetActorAnimation ; $7766
	ld a, $0b ; $7769
	farcall FarPtr_ScriptWaitActorIdle ; $776b
	ld a, $14 ; $776e
	call Func_27_7856 ; $7770
	ld a, $0b ; $7773
	ld b, a ; $7775
	ld a, $00 ; $7776
	farcall FarPtr_FaceActorsTowardEachOther ; $7778
	ld a, $09 ; $777b
	ld b, a ; $777d
	ld a, $0a ; $777e
	farcall FarPtr_FaceActorsTowardEachOther ; $7780
	ld a, $0a ; $7783
	call Func_27_7856 ; $7785
	ld a, $00 ; $7788
	ld b, $01 ; $778a
	farcall FarPtr_ScriptSetActorFacingLock ; $778c
	ld a, $0b ; $778f
	ld b, $01 ; $7791
	farcall FarPtr_ScriptSetActorFacingLock ; $7793
	ld a, $0a ; $7796
	ld b, $01 ; $7798
	farcall FarPtr_ScriptSetActorFacingLock ; $779a
	ld a, $09 ; $779d
	ld b, $01 ; $779f
	farcall FarPtr_ScriptSetActorFacingLock ; $77a1
	ld a, $00 ; $77a4
	ld bc, $1600 ; $77a6
	ld de, $1700 ; $77a9
	farcall FarPtr_ScriptSetActorMoveTarget ; $77ac
	ld a, $0b ; $77af
	ld bc, $1a00 ; $77b1
	ld de, $1700 ; $77b4
	farcall FarPtr_ScriptSetActorMoveTarget ; $77b7
	ld a, $0a ; $77ba
	ld bc, $1500 ; $77bc
	ld de, $1500 ; $77bf
	farcall FarPtr_ScriptSetActorMoveTarget ; $77c2
	ld a, $09 ; $77c5
	ld bc, $1b00 ; $77c7
	ld de, $1500 ; $77ca
	farcall FarPtr_ScriptSetActorMoveTarget ; $77cd
	ld a, $09 ; $77d0
	farcall FarPtr_ScriptWaitActorMoveDone ; $77d2
	ld bc, $0020 ; $77d5
	farcall FarPtr_SetPlayerMoveSpeed ; $77d8
	xor a, a ; $77db
	ld bc, $1800 ; $77dc
	ld de, $2f00 ; $77df
	farcall FarPtr_MovePlayerToPosition ; $77e2
	ld a, $08 ; $77e5
	ld bc, $1800 ; $77e7
	ld de, $1900 ; $77ea
	farcall FarPtr_ScriptSetActorMoveTarget ; $77ed
	ld a, $08 ; $77f0
	farcall FarPtr_ScriptWaitActorMoveDone ; $77f2
	ld a, $00 ; $77f5
	ld b, $00 ; $77f7
	farcall FarPtr_ScriptSetActorFacingLock ; $77f9
	ld a, $0b ; $77fc
	ld b, $00 ; $77fe
	farcall FarPtr_ScriptSetActorFacingLock ; $7800
	ld a, $0a ; $7803
	ld b, $00 ; $7805
	farcall FarPtr_ScriptSetActorFacingLock ; $7807
	ld a, $09 ; $780a
	ld b, $00 ; $780c
	farcall FarPtr_ScriptSetActorFacingLock ; $780e
	ld a, $00 ; $7811
	ld bc, $1600 ; $7813
	ld de, $1f00 ; $7816
	farcall FarPtr_ScriptSetActorMoveTarget ; $7819
	ld a, $0b ; $781c
	ld bc, $1a00 ; $781e
	ld de, $1f00 ; $7821
	farcall FarPtr_ScriptSetActorMoveTarget ; $7824
	ld a, $0a ; $7827
	ld bc, $1500 ; $7829
	ld de, $1d00 ; $782c
	farcall FarPtr_ScriptSetActorMoveTarget ; $782f
	ld a, $09 ; $7832
	ld bc, $1b00 ; $7834
	ld de, $1d00 ; $7837
	farcall FarPtr_ScriptSetActorMoveTarget ; $783a
	ld a, $08 ; $783d
	ld bc, $1800 ; $783f
	ld de, $2100 ; $7842
	farcall FarPtr_ScriptSetActorMoveTarget ; $7845
	ld a, $08 ; $7848
	farcall FarPtr_ScriptWaitActorMoveDone ; $784a
	ld a, $05 ; $784d
	ld [$c294], a ; $784f
	ld [wStoryModeExitLocationRequest], a ; $7852
	ret ; $7855
Func_27_7856:
	push af ; $7856
	ld a, a ; $7857
	farcall FarPtr_WaitScriptFrames ; $7858
	pop af ; $785b
	ret ; $785c
	INCBIN "data/bank_027/d_785d.bin" ; $785d, 40 bytes
MapScriptNop_27:
	ret ; $7885
	INCBIN "data/bank_027/d_7886.bin" ; $7886, 571 bytes
	ds 1343, $ff ; $7ac1, fill

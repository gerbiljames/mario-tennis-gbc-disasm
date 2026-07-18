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
	script_set_anim $05, $06 ; $41c0
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
	script_set_speed $03, $0010 ; $41f5
	script_set_speed $04, $0010 ; $41fd
	script_set_speed $05, $0010 ; $4205
	script_set_speed $06, $0010 ; $420d
	script_face $06, $40 ; $4215
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
	script_face $03, $c0 ; $4252
	script_move_target $05, $0f00, $1200 ; $4259
	script_move_target $03, $0f00, $1300 ; $4264
	script_wait_move $03 ; $426f
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
	script_face $06, $80 ; $4295
	script_move_target $06, $0e00, $1300 ; $429c
	script_move_target $05, $0d00, $1300 ; $42a7
	script_wait_move $05 ; $42b2
	ld a, $06 ; $42b7
	ld b, $01 ; $42b9
	farcall FarPtr_ScriptSetActorFacingLock ; $42bb
	script_move_target $06, $0f00, $1300 ; $42be
	script_wait_move $06 ; $42c9
	ld a, $06 ; $42ce
	ld b, $00 ; $42d0
	farcall FarPtr_ScriptSetActorFacingLock ; $42d2
	script_move_target $06, $0f00, $1600 ; $42d5
	script_wait_move $06 ; $42e0
	script_face $06, $c0 ; $42e5
	script_move_target $04, $0c00, $1100 ; $42ec
	script_move_target $05, $0c00, $1000 ; $42f7
	script_wait_move $05 ; $4302
	ld a, $50 ; $4307
	call Func_27_7856 ; $4309
	script_move_target $04, $0c00, $0f80 ; $430c
	script_move_target $05, $0c00, $0e40 ; $4317
	script_wait_move $05 ; $4322
	ld a, $04 ; $4327
	ld b, $01 ; $4329
	farcall FarPtr_ScriptSetActorFacingLock ; $432b
	script_move_target $04, $0c00, $1100 ; $432e
	script_wait_move $04 ; $4339
	ld a, $04 ; $433e
	ld b, $00 ; $4340
	farcall FarPtr_ScriptSetActorFacingLock ; $4342
	script_face $04, $c0 ; $4345
	script_set_anim $0e, $02 ; $434c
	script_wait_idle $0e ; $4353
	ld a, $32 ; $4358
	call Func_27_7856 ; $435a
	script_face $07, $80 ; $435d
	script_face $08, $00 ; $4364
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
	script_set_anim $09, $01 ; $438c
	script_face $09, $00 ; $4393
	script_set_anim $09, $08 ; $439a
	script_player_speed $0006 ; $43a1
	script_move_player $0c00, $0d00 ; $43a7
	farcall FarPtr_WaitPlayerMoveDone ; $43b1
	ld a, $32 ; $43b4
	call Func_27_7856 ; $43b6
	ld a, $01 ; $43b9
	ld [$c294], a ; $43bb
	ld [wStoryModeExitLocationRequest], a ; $43be
	ret ; $43c1
Label_27_43c2:
	script_set_speed $03, $0010 ; $43c2
	script_set_speed $04, $0010 ; $43ca
	script_set_speed $05, $0010 ; $43d2
	script_set_speed $06, $0010 ; $43da
	script_move_target $06, $0f00, $1600 ; $43e2
	script_wait_move $06 ; $43ed
	script_face $06, $40 ; $43f2
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
	script_face $03, $c0 ; $442f
	script_move_target $05, $0f00, $1300 ; $4436
	script_move_target $03, $0f00, $1400 ; $4441
	script_wait_move $03 ; $444c
	script_face $06, $c0 ; $4451
	ld a, $03 ; $4458
	ld b, $01 ; $445a
	farcall FarPtr_ScriptSetActorFacingLock ; $445c
	script_move_target $03, $0f00, $1600 ; $445f
	script_wait_move $03 ; $446a
	ld a, $03 ; $446f
	ld b, $00 ; $4471
	farcall FarPtr_ScriptSetActorFacingLock ; $4473
	script_face $03, $c0 ; $4476
	ld a, $05 ; $447d
	ld bc, $0ec0 ; $447f
	ld de, $1300 ; $4482
	farcall FarPtr_ScriptSetActorPosition ; $4485
	script_move_target $04, $0f00, $1300 ; $4488
	script_move_target $05, $0fc0, $1300 ; $4493
	script_wait_move $05 ; $449e
	script_move_target $04, $0f00, $1100 ; $44a3
	script_move_target $05, $0fc0, $1100 ; $44ae
	script_wait_move $05 ; $44b9
	ld a, $3c ; $44be
	call Func_27_7856 ; $44c0
	script_set_anim $02, $03 ; $44c3
	script_wait_idle $02 ; $44ca
	script_set_anim $04, $03 ; $44cf
	script_wait_idle $04 ; $44d6
	ld a, $3c ; $44db
	call Func_27_7856 ; $44dd
	ld a, $05 ; $44e0
	ld bc, $0e40 ; $44e2
	ld de, $1100 ; $44e5
	farcall FarPtr_ScriptSetActorPosition ; $44e8
	script_move_target $04, $0d00, $1100 ; $44eb
	script_move_target $05, $0c40, $1100 ; $44f6
	script_wait_move $05 ; $4501
	ld a, $04 ; $4506
	call Func_27_7856 ; $4508
	script_face $04, $c0 ; $450b
	script_move_target $05, $0d00, $1000 ; $4512
	script_wait_move $05 ; $451d
	ld a, $32 ; $4522
	call Func_27_7856 ; $4524
	script_move_target $04, $0d00, $1000 ; $4527
	script_move_target $05, $0d00, $0e80 ; $4532
	script_wait_move $05 ; $453d
	ld a, $05 ; $4542
	call Func_27_7856 ; $4544
	ld a, $04 ; $4547
	ld b, $01 ; $4549
	farcall FarPtr_ScriptSetActorFacingLock ; $454b
	script_move_target $04, $0d00, $1100 ; $454e
	script_wait_move $04 ; $4559
	ld a, $04 ; $455e
	ld b, $00 ; $4560
	farcall FarPtr_ScriptSetActorFacingLock ; $4562
	script_face $04, $c0 ; $4565
	script_set_anim $0e, $02 ; $456c
	script_wait_idle $0e ; $4573
	ld a, $1e ; $4578
	call Func_27_7856 ; $457a
	script_set_anim $09, $03 ; $457d
	script_set_anim $02, $03 ; $4584
	script_wait_idle $02 ; $458b
	ld a, $1e ; $4590
	call Func_27_7856 ; $4592
	script_face $02, $80 ; $4595
	script_face $07, $00 ; $459c
	script_face $08, $00 ; $45a3
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
	script_set_anim $02, $01 ; $45d5
	ld a, $02 ; $45dc
	farcall FarPtr_SetActorNullScript ; $45de
	ld a, $02 ; $45e1
	ld bc, $0f00 ; $45e3
	ld de, $0d60 ; $45e6
	farcall FarPtr_ScriptSetActorPosition ; $45e9
	script_face $02, $40 ; $45ec
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
	script_set_anim $09, $01 ; $4604
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
	script_move_target $00, $1c00, $1900 ; $48a8
	script_wait_move $00 ; $48b3
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
	script_move_player $1100, $0f00 ; $491a
	farcall FarPtr_WaitPlayerMoveDone ; $4924
	script_move_target $05, $0e00, $0c00 ; $4927
	script_wait_move $05 ; $4932
	script_move_target $05, $1300, $0c00 ; $4937
	script_wait_move $05 ; $4942
	script_face $05, $40 ; $4947
	script_set_anim $05, $02 ; $494e
	script_wait_idle $05 ; $4955
	script_face $04, $c0 ; $495a
	script_set_anim $04, $03 ; $4961
	script_wait_idle $04 ; $4968
	script_face $04, $40 ; $496d
	script_move_target $04, $1300, $1700 ; $4974
	script_move_target $05, $1300, $1700 ; $497f
	script_move_player $1100, $1300 ; $498a
	script_wait_move $04 ; $4994
	script_move_target $04, $1500, $1700 ; $4999
	script_wait_move $04 ; $49a4
	script_face $04, $c0 ; $49a9
	script_wait_move $05 ; $49b0
	script_face $05, $c0 ; $49b5
	ld a, $05 ; $49bc
	ld b, a ; $49be
	ld a, $04 ; $49bf
	farcall FarPtr_FaceActorsTowardEachOther ; $49c1
	script_set_anim $04, $03 ; $49c4
	script_wait_idle $04 ; $49cb
	script_move_target $05, $1000, $1700 ; $49d0
	script_wait_move $05 ; $49db
	script_face $05, $c0 ; $49e0
	test_flag $05, 7 ; $49e7
	jp nz, Label_27_4a88 ; $49ea
	script_set_speed $00, $0020 ; $49ed
	ld a, $0a ; $49f5
	ld b, a ; $49f7
	ld a, $00 ; $49f8
	farcall FarPtr_FaceActorsTowardEachOther ; $49fa
	script_wait_frames $1e ; $49fd
	script_face $00, $40 ; $4a04
	script_face $0a, $40 ; $4a0b
	script_set_anim $0a, $03 ; $4a12
	script_set_anim $00, $03 ; $4a19
	script_wait_idle $00 ; $4a20
	script_move_target $05, $1300, $1700 ; $4a25
	script_wait_move $05 ; $4a30
	ldh a, [hRomBank] ; $4a35
	ld b, a ; $4a37
	ld a, $05 ; $4a38
	ld de, $4b67 ; $4a3a
	farcall FarPtr_ScriptSetActorScript ; $4a3d
	script_wait_frames $14 ; $4a40
	ldh a, [hRomBank] ; $4a47
	ld b, a ; $4a49
	ld a, $0a ; $4a4a
	ld de, $4b67 ; $4a4c
	farcall FarPtr_ScriptSetActorScript ; $4a4f
	script_wait_frames $14 ; $4a52
	ldh a, [hRomBank] ; $4a59
	ld b, a ; $4a5b
	ld a, $00 ; $4a5c
	ld de, $4b67 ; $4a5e
	farcall FarPtr_ScriptSetActorScript ; $4a61
	script_wait_frames $14 ; $4a64
	script_move_player $1100, $0d00 ; $4a6b
	farcall FarPtr_WaitPlayerMoveDone ; $4a75
	script_wait_frames $1e ; $4a78
	ld a, $01 ; $4a7f
	ld [$c294], a ; $4a81
	ld [wStoryModeExitLocationRequest], a ; $4a84
	ret ; $4a87
Label_27_4a88:
	ld a, $02 ; $4a88
	ld b, a ; $4a8a
	ld a, $00 ; $4a8b
	farcall FarPtr_FaceActorsTowardEachOther ; $4a8d
	script_set_speed $00, $0020 ; $4a90
	script_set_speed $02, $0020 ; $4a98
	script_wait_frames $14 ; $4aa0
	script_set_anim $02, $03 ; $4aa7
	script_set_anim $00, $03 ; $4aae
	script_wait_idle $00 ; $4ab5
	script_face $00, $40 ; $4aba
	script_face $02, $40 ; $4ac1
	script_move_target $05, $1300, $1700 ; $4ac8
	script_wait_move $05 ; $4ad3
	ldh a, [hRomBank] ; $4ad8
	ld b, a ; $4ada
	ld a, $05 ; $4adb
	ld de, $4b67 ; $4add
	farcall FarPtr_ScriptSetActorScript ; $4ae0
	script_wait_frames $14 ; $4ae3
	ldh a, [hRomBank] ; $4aea
	ld b, a ; $4aec
	ld a, $00 ; $4aed
	ld de, $4b67 ; $4aef
	farcall FarPtr_ScriptSetActorScript ; $4af2
	script_wait_frames $14 ; $4af5
	ldh a, [hRomBank] ; $4afc
	ld b, a ; $4afe
	ld a, $02 ; $4aff
	ld de, $4b67 ; $4b01
	farcall FarPtr_ScriptSetActorScript ; $4b04
	script_wait_frames $3c ; $4b07
	ldh a, [hRomBank] ; $4b0e
	ld b, a ; $4b10
	ld a, $0b ; $4b11
	ld de, $4b80 ; $4b13
	farcall FarPtr_ScriptSetActorScript ; $4b16
	script_wait_frames $14 ; $4b19
	ldh a, [hRomBank] ; $4b20
	ld b, a ; $4b22
	ld a, $0a ; $4b23
	ld de, $4b80 ; $4b25
	farcall FarPtr_ScriptSetActorScript ; $4b28
	script_move_player $1100, $0d00 ; $4b2b
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
	script_move_target $07, $1e00, $2f00 ; $4cb0
	script_wait_move $07 ; $4cbb
	script_face $07, $40 ; $4cc0
	ld a, $1e ; $4cc7
	call Func_27_7856 ; $4cc9
	script_move_target $07, $2200, $2f00 ; $4ccc
	script_wait_move $07 ; $4cd7
	script_face $07, $40 ; $4cdc
	ld a, $1e ; $4ce3
	call Func_27_7856 ; $4ce5
	script_move_target $07, $2000, $2f00 ; $4ce8
	script_wait_move $07 ; $4cf3
	script_face $07, $40 ; $4cf8
	ld a, $0a ; $4cff
	call Func_27_7856 ; $4d01
	script_set_anim $07, $02 ; $4d04
	script_wait_idle $07 ; $4d0b
	script_face $08, $c0 ; $4d10
	script_face $09, $c0 ; $4d17
	script_face $0a, $c0 ; $4d1e
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
	script_move_target $00, $2100, $3b00 ; $4d8c
	script_move_target $02, $2300, $3b00 ; $4d97
	script_wait_move $02 ; $4da2
	script_wait_frames $05 ; $4da7
	script_face $00, $c0 ; $4dae
	call Func_27_516b ; $4db5
	script_move_target $00, $2100, $3500 ; $4db8
	script_move_target $02, $2100, $3b00 ; $4dc3
	script_wait_move $02 ; $4dce
	script_move_target $00, $1f00, $3500 ; $4dd3
	script_move_target $02, $2100, $3500 ; $4dde
	script_wait_move $02 ; $4de9
	script_move_target $02, $2100, $3500 ; $4dee
	script_wait_move $02 ; $4df9
	script_face $00, $c0 ; $4dfe
	script_face $02, $c0 ; $4e05
	ld a, $01 ; $4e0c
	call Func_27_7856 ; $4e0e
	jr Label_27_4e59 ; $4e11
Label_27_4e13:
	script_move_target $00, $2100, $3b00 ; $4e13
	script_wait_move $00 ; $4e1e
	script_face $00, $c0 ; $4e23
	call Func_27_516b ; $4e2a
	script_move_target $00, $2100, $3500 ; $4e2d
	script_wait_move $00 ; $4e38
	script_move_target $00, $2000, $3500 ; $4e3d
	script_wait_move $00 ; $4e48
	script_face $00, $c0 ; $4e4d
	ld a, $01 ; $4e54
	call Func_27_7856 ; $4e56
Label_27_4e59:
	call Func_27_51a1 ; $4e59
	script_set_anim $07, $02 ; $4e5c
	script_set_anim $08, $02 ; $4e63
	script_set_anim $09, $02 ; $4e6a
	script_set_anim $0a, $02 ; $4e71
	script_wait_idle $0a ; $4e78
	ld a, $1e ; $4e7d
	call Func_27_7856 ; $4e7f
	script_move_target $0a, $1d00, $3500 ; $4e82
	script_move_target $09, $2300, $3500 ; $4e8d
	script_move_target $08, $2500, $3500 ; $4e98
	script_wait_move $08 ; $4ea3
	script_face $0a, $00 ; $4ea8
	script_face $09, $80 ; $4eaf
	script_face $08, $80 ; $4eb6
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
	script_set_anim $00, $02 ; $4ed5
	script_wait_idle $00 ; $4edc
	ld a, $14 ; $4ee1
	call Func_27_7856 ; $4ee3
	ld a, $00 ; $4ee6
	ld b, a ; $4ee8
	ld a, $02 ; $4ee9
	farcall FarPtr_FaceActorTowardActor ; $4eeb
	ld a, $01 ; $4eee
	call Func_27_7856 ; $4ef0
	script_set_anim $02, $03 ; $4ef3
	script_wait_idle $02 ; $4efa
	ld a, $14 ; $4eff
	call Func_27_7856 ; $4f01
	script_face $00, $c0 ; $4f04
	script_face $02, $c0 ; $4f0b
	script_set_anim $08, $03 ; $4f12
	script_set_anim $09, $03 ; $4f19
	script_set_anim $0a, $03 ; $4f20
	script_wait_idle $0a ; $4f27
	ld a, $28 ; $4f2c
	call Func_27_7856 ; $4f2e
	script_set_anim $00, $03 ; $4f31
	script_set_anim $02, $03 ; $4f38
	script_wait_idle $02 ; $4f3f
	script_move_target $00, $1f00, $3200 ; $4f44
	script_move_target $02, $2100, $3200 ; $4f4f
	script_wait_move $02 ; $4f5a
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
	script_set_anim $0a, $03 ; $4f99
	script_wait_idle $0a ; $4fa0
	ld a, $14 ; $4fa5
	call Func_27_7856 ; $4fa7
	script_face $00, $c0 ; $4faa
	script_set_anim $08, $03 ; $4fb1
	script_set_anim $09, $03 ; $4fb8
	script_set_anim $0a, $03 ; $4fbf
	script_wait_idle $0a ; $4fc6
	ld a, $28 ; $4fcb
	call Func_27_7856 ; $4fcd
	script_set_anim $00, $03 ; $4fd0
	script_move_target $00, $2000, $3200 ; $4fd7
	script_wait_move $00 ; $4fe2
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
	script_set_anim $04, $06 ; $4ffb
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
	script_face $02, $c0 ; $5023
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
	script_face $00, $c0 ; $5057
	xor a, a ; $505e
	ld [wStoryModeShowLocationName], a ; $505f
	ld c, $04 ; $5062
	call BeginFadeIn ; $5064
	call WaitFadeEnd ; $5067
	test_flag $05, 7 ; $506a
	jp z, Label_27_50ff ; $506d
	script_set_anim $00, $03 ; $5070
	script_wait_idle $00 ; $5077
	script_set_anim $03, $03 ; $507c
	script_wait_idle $03 ; $5083
	ld a, $3c ; $5088
	call Func_27_7856 ; $508a
	ld a, $02 ; $508d
	ld b, a ; $508f
	ld a, $00 ; $5090
	farcall FarPtr_FaceActorsTowardEachOther ; $5092
	ld a, $1e ; $5095
	call Func_27_7856 ; $5097
	script_set_anim $00, $03 ; $509a
	script_set_anim $02, $03 ; $50a1
	script_wait_idle $02 ; $50a8
	script_face $02, $40 ; $50ad
	script_move_target $00, $2100, $3600 ; $50b4
	script_wait_move $00 ; $50bf
	script_move_target $00, $2100, $3700 ; $50c4
	script_move_target $02, $2100, $3500 ; $50cf
	script_wait_move $02 ; $50da
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
	script_set_anim $00, $03 ; $50ff
	script_wait_idle $00 ; $5106
	script_set_anim $03, $03 ; $510b
	script_wait_idle $03 ; $5112
	ld a, $3c ; $5117
	call Func_27_7856 ; $5119
	script_move_target $00, $2100, $3400 ; $511c
	script_wait_move $00 ; $5127
	script_move_target $00, $2100, $3700 ; $512c
	script_wait_move $00 ; $5137
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
	script_wait_frames $0a ; $516b
	sound $79 ; $5172
	ld b, $07 ; $5174
	ld c, $38 ; $5176
	ld d, $20 ; $5178
	ld e, $38 ; $517a
	ld h, $02 ; $517c
	ld l, $02 ; $517e
	farcall FarPtr_CopySceneTilemapRect ; $5180
	script_wait_frames $02 ; $5183
	ld b, $0b ; $518a
	ld c, $38 ; $518c
	ld d, $20 ; $518e
	ld e, $38 ; $5190
	ld h, $02 ; $5192
	ld l, $02 ; $5194
	farcall FarPtr_CopySceneTilemapRect ; $5196
	script_wait_frames $04 ; $5199
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
	script_wait_frames $02 ; $51b2
	ld b, $03 ; $51b9
	ld c, $38 ; $51bb
	ld d, $20 ; $51bd
	ld e, $38 ; $51bf
	ld h, $02 ; $51c1
	ld l, $02 ; $51c3
	farcall FarPtr_CopySceneTilemapRect ; $51c5
	script_wait_frames $04 ; $51c8
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
	script_face $00, $40 ; $52ae
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
	script_set_anim $00, $02 ; $52dc
	script_wait_idle $00 ; $52e3
	ld a, $00 ; $52e8
	farcall FarPtr_SetActorNullScript ; $52ea
	script_set_anim $00, $01 ; $52ed
	ld a, $3c ; $52f4
	call Func_27_7856 ; $52f6
	script_face $00, $80 ; $52f9
	ld a, $1e ; $5300
	call Func_27_7856 ; $5302
	script_face $00, $00 ; $5305
	ld a, $1e ; $530c
	call Func_27_7856 ; $530e
	script_face $00, $80 ; $5311
	ld a, $1e ; $5318
	call Func_27_7856 ; $531a
	script_face $00, $00 ; $531d
	ld a, $1e ; $5324
	call Func_27_7856 ; $5326
	script_face $00, $40 ; $5329
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
	script_player_speed $0010 ; $5359
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
	script_wait_frames $04 ; $5387
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
	script_face $00, $c0 ; $53b8
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
	script_face $00, $c0 ; $540f
	ld a, $06 ; $5416
	ld bc, $1800 ; $5418
	ld de, $0d00 ; $541b
	farcall FarPtr_ScriptSetActorPosition ; $541e
	script_face $06, $40 ; $5421
	ld a, $02 ; $5428
	farcall FarPtr_SetActorNullScript ; $542a
	ld a, $02 ; $542d
	ld bc, $1300 ; $542f
	ld de, $1100 ; $5432
	farcall FarPtr_ScriptSetActorPosition ; $5435
	script_face $02, $00 ; $5438
	script_move_player $1800, $0f00 ; $543f
	farcall FarPtr_WaitPlayerMoveDone ; $5449
	ld c, $08 ; $544c
	call BeginFadeIn ; $544e
	call WaitFadeEnd ; $5451
	script_wait_frames $1e ; $5454
	script_set_anim $06, $02 ; $545b
	script_wait_idle $06 ; $5462
	ld a, $06 ; $5467
	ld b, $01 ; $5469
	farcall FarPtr_ScriptSetActorFacingLock ; $546b
	script_move_angle $06, $c0, $0100 ; $546e
	script_wait_move $06 ; $5478
	script_wait_frames $28 ; $547d
	script_move_angle $06, $c0, $0100 ; $5484
	script_wait_move $06 ; $548e
	script_set_anim $06, $02 ; $5493
	script_wait_idle $06 ; $549a
	ld a, $06 ; $549f
	ld b, $00 ; $54a1
	farcall FarPtr_ScriptSetActorFacingLock ; $54a3
	script_set_speed $06, $0030 ; $54a6
	ld a, $06 ; $54ae
	farcall FarPtr_GetActorStateAddr ; $54b0
	ld a, $04 ; $54b3
	ld e, l ; $54b5
	ld d, h ; $54b6
	ld hl, $0018 ; $54b7
	add hl, de ; $54ba
	ld [hl], a ; $54bb
	script_move_target $06, $1f00, $0b00 ; $54bc
	script_wait_move $06 ; $54c7
	script_move_target $06, $1f00, $1100 ; $54cc
	script_wait_move $06 ; $54d7
	script_face $00, $40 ; $54dc
	script_move_target $06, $1f00, $1f00 ; $54e3
	script_wait_move $06 ; $54ee
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
	script_set_anim $0d, $01 ; $5638
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
	script_player_speed $00f0 ; $565e
	call Func_27_5626 ; $5664
	ld a, $00 ; $5667
	ld bc, $0b00 ; $5669
	ld de, $1d00 ; $566c
	farcall FarPtr_ScriptSetActorPosition ; $566f
	ld a, $02 ; $5672
	ld bc, $0d00 ; $5674
	ld de, $2300 ; $5677
	farcall FarPtr_ScriptSetActorPosition ; $567a
	script_face $00, $c0 ; $567d
	script_face $02, $c0 ; $5684
	script_move_player $0b00, $1100 ; $568b
	farcall FarPtr_WaitPlayerMoveDone ; $5695
	ld c, $04 ; $5698
	call BeginFadeIn ; $569a
	script_player_speed $0020 ; $569d
	script_move_player $0b00, $1700 ; $56a3
	farcall FarPtr_WaitPlayerMoveDone ; $56ad
	script_move_target $04, $0b00, $1700 ; $56b0
	script_wait_move $04 ; $56bb
	sound $98 ; $56c0
	ld a, $0c ; $56c2
	ld bc, $0c40 ; $56c4
	ld de, $1bc0 ; $56c7
	farcall FarPtr_ScriptSetActorPosition ; $56ca
	script_wait_frames $28 ; $56cd
	ld a, $0c ; $56d4
	ld bc, $3f00 ; $56d6
	ld de, $3f00 ; $56d9
	farcall FarPtr_ScriptSetActorPosition ; $56dc
	script_face $00, $00 ; $56df
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
	script_wait_frames $0a ; $570e
	ldh a, [hRomBank] ; $5715
	ld b, a ; $5717
	ld a, $03 ; $5718
	ld de, $5c6a ; $571a
	farcall FarPtr_ScriptSetActorScript ; $571d
	script_wait_frames $1e ; $5720
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
	script_set_anim $0d, $02 ; $5743
	script_wait_idle $0d ; $574a
	ld a, $0d ; $574f
	ld b, a ; $5751
	ld a, $00 ; $5752
	farcall FarPtr_FaceActorTowardActor ; $5754
	jr Label_27_576d ; $5757
Label_27_5759:
	script_set_anim $0d, $02 ; $5759
	script_wait_idle $0d ; $5760
	ld a, $0d ; $5765
	ld b, a ; $5767
	ld a, $00 ; $5768
	farcall FarPtr_FaceActorTowardActor ; $576a
Label_27_576d:
	script_set_anim $09, $04 ; $576d
	script_wait_idle $09 ; $5774
	ld a, $09 ; $5779
	ld b, a ; $577b
	ld a, $00 ; $577c
	farcall FarPtr_FaceActorTowardActor ; $577e
	script_set_anim $00, $02 ; $5781
	script_wait_idle $00 ; $5788
	script_wait_frames $14 ; $578d
	script_move_target $08, $0a00, $1f00 ; $5794
	script_wait_move $08 ; $579f
	script_wait_frames $14 ; $57a4
	ld a, $08 ; $57ab
	ld b, a ; $57ad
	ld a, $00 ; $57ae
	farcall FarPtr_FaceActorTowardActor ; $57b0
	ld a, $08 ; $57b3
	ld b, a ; $57b5
	ld a, $0d ; $57b6
	farcall FarPtr_FaceActorTowardActor ; $57b8
	script_wait_frames $14 ; $57bb
	script_wait_frames $14 ; $57c2
	script_move_target $03, $0c00, $1f00 ; $57c9
	script_wait_move $03 ; $57d4
	script_wait_frames $14 ; $57d9
	script_set_anim $03, $02 ; $57e0
	script_wait_idle $03 ; $57e7
	script_set_anim $0d, $02 ; $57ec
	script_wait_idle $0d ; $57f3
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
	script_wait_frames $0a ; $580d
	ld a, $08 ; $5814
	ld b, a ; $5816
	ld a, $00 ; $5817
	farcall FarPtr_FaceActorTowardActor ; $5819
	script_wait_frames $0a ; $581c
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
	script_player_speed $00f0 ; $5844
	ld a, $00 ; $584a
	ld bc, $0b00 ; $584c
	ld de, $1d00 ; $584f
	farcall FarPtr_ScriptSetActorPosition ; $5852
	ld a, $02 ; $5855
	ld bc, $0d00 ; $5857
	ld de, $2300 ; $585a
SceneSharedData_27:
	farcall FarPtr_ScriptSetActorPosition ; $585d
	script_face $00, $c0 ; $5860
	script_face $02, $c0 ; $5867
	script_move_player $0b00, $1100 ; $586e
	farcall FarPtr_WaitPlayerMoveDone ; $5878
	ld c, $04 ; $587b
	call BeginFadeIn ; $587d
	script_player_speed $0020 ; $5880
	script_move_player $0b00, $1700 ; $5886
	farcall FarPtr_WaitPlayerMoveDone ; $5890
	script_move_target $02, $0d00, $1d00 ; $5893
	script_move_target $09, $0b00, $1700 ; $589e
	script_wait_move $09 ; $58a9
	script_set_anim $09, $04 ; $58ae
	script_wait_idle $09 ; $58b5
	script_set_anim $04, $02 ; $58ba
	script_wait_idle $04 ; $58c1
	script_set_anim $02, $03 ; $58c6
	script_set_anim $00, $03 ; $58cd
	script_wait_idle $00 ; $58d4
	ld a, $00 ; $58d9
	ld b, a ; $58db
	ld a, $02 ; $58dc
	farcall FarPtr_FaceActorTowardActor ; $58de
	script_wait_frames $1e ; $58e1
	script_set_anim $02, $03 ; $58e8
	script_wait_idle $02 ; $58ef
	test_flag $1c, 0 ; $58f4
	jp z, Label_27_5a25 ; $58f7
	ld a, $02 ; $58fa
	ld b, a ; $58fc
	ld a, $00 ; $58fd
	farcall FarPtr_FaceActorTowardActor ; $58ff
	script_set_anim $02, $02 ; $5902
	script_wait_idle $02 ; $5909
	script_face $00, $80 ; $590e
	script_set_anim $00, $02 ; $5915
	sound $96 ; $591c
	ld a, $0a ; $591e
	ld bc, $0c00 ; $5920
	ld de, $1b80 ; $5923
	farcall FarPtr_ScriptSetActorPosition ; $5926
	script_wait_frames $28 ; $5929
	ld a, $0a ; $5930
	ld bc, $3f00 ; $5932
	ld de, $3f00 ; $5935
	farcall FarPtr_ScriptSetActorPosition ; $5938
	ld a, $02 ; $593b
	ld b, a ; $593d
	ld a, $00 ; $593e
	farcall FarPtr_FaceActorTowardActor ; $5940
	script_wait_frames $0a ; $5943
	ld a, $00 ; $594a
	ld b, $01 ; $594c
	farcall FarPtr_ScriptSetActorFacingLock ; $594e
	script_wait_frames $0a ; $5951
	script_move_angle $00, $00, $0100 ; $5958
	script_wait_move $00 ; $5962
	script_set_anim $00, $02 ; $5967
	script_wait_idle $00 ; $596e
	script_move_angle $00, $80, $0100 ; $5973
	script_wait_move $00 ; $597d
	ld a, $02 ; $5982
	farcall FarPtr_GetActorStateAddr ; $5984
	ld de, $0018 ; $5987
	add hl, de ; $598a
	ld [hl], $04 ; $598b
	script_set_anim $02, $02 ; $598d
	script_wait_idle $02 ; $5994
	script_face $02, $c0 ; $5999
	script_set_anim $02, $02 ; $59a0
	script_wait_idle $02 ; $59a7
	script_set_anim $02, $02 ; $59ac
	script_wait_idle $02 ; $59b3
	script_face $02, $40 ; $59b8
	script_set_anim $02, $02 ; $59bf
	script_wait_idle $02 ; $59c6
	script_face $02, $c0 ; $59cb
	script_set_anim $02, $02 ; $59d2
	script_wait_idle $02 ; $59d9
	script_set_anim $02, $02 ; $59de
	script_wait_idle $02 ; $59e5
	ld a, $02 ; $59ea
	farcall FarPtr_GetActorStateAddr ; $59ec
	ld de, $0018 ; $59ef
	add hl, de ; $59f2
	ld [hl], $01 ; $59f3
	script_face $02, $80 ; $59f5
	script_wait_frames $14 ; $59fc
	script_set_anim $02, $03 ; $5a03
	script_wait_idle $02 ; $5a0a
	script_wait_frames $14 ; $5a0f
	script_set_anim $00, $03 ; $5a16
	script_wait_idle $00 ; $5a1d
	jp Label_27_5b0c ; $5a22
Label_27_5a25:
	script_set_anim $02, $02 ; $5a25
	script_wait_idle $02 ; $5a2c
	ld a, $02 ; $5a31
	ld b, a ; $5a33
	ld a, $00 ; $5a34
	farcall FarPtr_FaceActorTowardActor ; $5a36
	sound $96 ; $5a39
	ld a, $0a ; $5a3b
	ld bc, $0c00 ; $5a3d
	ld de, $1b80 ; $5a40
	farcall FarPtr_ScriptSetActorPosition ; $5a43
	script_wait_frames $28 ; $5a46
	ld a, $0a ; $5a4d
	ld bc, $3f00 ; $5a4f
	ld de, $3f00 ; $5a52
	farcall FarPtr_ScriptSetActorPosition ; $5a55
	script_wait_frames $0a ; $5a58
	ld a, $00 ; $5a5f
	ld b, $01 ; $5a61
	farcall FarPtr_ScriptSetActorFacingLock ; $5a63
	script_wait_frames $0a ; $5a66
	script_move_angle $00, $00, $0100 ; $5a6d
	script_wait_move $00 ; $5a77
	script_set_anim $00, $02 ; $5a7c
	script_wait_idle $00 ; $5a83
	script_move_angle $00, $80, $0100 ; $5a88
	script_wait_move $00 ; $5a92
	ld a, $02 ; $5a97
	farcall FarPtr_GetActorStateAddr ; $5a99
	ld de, $0018 ; $5a9c
	add hl, de ; $5a9f
	ld [hl], $03 ; $5aa0
	script_set_anim $02, $02 ; $5aa2
	script_wait_idle $02 ; $5aa9
	script_face $02, $40 ; $5aae
	script_set_anim $02, $02 ; $5ab5
	script_wait_idle $02 ; $5abc
	script_wait_frames $28 ; $5ac1
	script_set_anim $02, $02 ; $5ac8
	script_wait_idle $02 ; $5acf
	ld a, $02 ; $5ad4
	farcall FarPtr_GetActorStateAddr ; $5ad6
	ld de, $0018 ; $5ad9
	add hl, de ; $5adc
	ld [hl], $01 ; $5add
	script_face $02, $80 ; $5adf
	script_wait_frames $14 ; $5ae6
	script_set_anim $02, $03 ; $5aed
	script_wait_idle $02 ; $5af4
	script_wait_frames $14 ; $5af9
	script_set_anim $00, $03 ; $5b00
	script_wait_idle $00 ; $5b07
Label_27_5b0c:
	script_wait_frames $14 ; $5b0c
	ld a, $00 ; $5b13
	ld b, $00 ; $5b15
	farcall FarPtr_ScriptSetActorFacingLock ; $5b17
	script_face $00, $00 ; $5b1a
	script_face $02, $00 ; $5b21
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
	script_wait_frames $14 ; $5b3e
	ldh a, [hRomBank] ; $5b45
	ld b, a ; $5b47
	ld a, $09 ; $5b48
	ld de, $5cb6 ; $5b4a
	farcall FarPtr_ScriptSetActorScript ; $5b4d
	script_move_player $0b00, $1d00 ; $5b50
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
	script_set_anim $09, $04 ; $5b72
	script_wait_idle $09 ; $5b79
	ld a, $09 ; $5b7e
	ld b, a ; $5b80
	ld a, $00 ; $5b81
	farcall FarPtr_FaceActorTowardActor ; $5b83
	script_move_target $08, $0a00, $1f00 ; $5b86
	script_wait_move $08 ; $5b91
	ld a, $08 ; $5b96
	ld b, a ; $5b98
	ld a, $00 ; $5b99
	farcall FarPtr_FaceActorTowardActor ; $5b9b
	ld a, $03 ; $5b9e
	ld b, a ; $5ba0
	ld a, $02 ; $5ba1
	farcall FarPtr_FaceActorTowardActor ; $5ba3
	script_set_anim $08, $03 ; $5ba6
	script_wait_idle $08 ; $5bad
	script_move_target $03, $0c00, $1f00 ; $5bb2
	script_wait_move $03 ; $5bbd
	script_set_anim $03, $02 ; $5bc2
	script_wait_idle $03 ; $5bc9
	ld a, $00 ; $5bce
	ld b, a ; $5bd0
	ld a, $02 ; $5bd1
	farcall FarPtr_FaceActorTowardActor ; $5bd3
	script_set_anim $02, $03 ; $5bd6
	script_wait_idle $02 ; $5bdd
	test_flag $1c, 0 ; $5be2
	jr z, Label_27_5be7 ; $5be5
Label_27_5be7:
	ld a, $02 ; $5be7
	ld b, a ; $5be9
	ld a, $00 ; $5bea
	farcall FarPtr_FaceActorTowardActor ; $5bec
	script_set_anim $00, $03 ; $5bef
	script_wait_idle $00 ; $5bf6
	script_wait_frames $0a ; $5bfb
	ld a, $08 ; $5c02
	ld b, a ; $5c04
	ld a, $00 ; $5c05
	farcall FarPtr_FaceActorTowardActor ; $5c07
	ld a, $03 ; $5c0a
	ld b, a ; $5c0c
	ld a, $02 ; $5c0d
	farcall FarPtr_FaceActorTowardActor ; $5c0f
	script_wait_frames $0a ; $5c12
	script_set_anim $00, $03 ; $5c19
	script_set_anim $02, $03 ; $5c20
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
	script_face $00, $c0 ; $5efc
	ld a, $02 ; $5f03
	ld bc, $2300 ; $5f05
	ld de, $1b00 ; $5f08
	farcall FarPtr_ScriptSetActorPosition ; $5f0b
	script_face $02, $c0 ; $5f0e
	script_face $03, $80 ; $5f15
	xor a, a ; $5f1c
	ld [wStoryModeShowLocationName], a ; $5f1d
	ld c, $04 ; $5f20
	call BeginFadeIn ; $5f22
	script_move_target $04, $2500, $1300 ; $5f25
	script_wait_move $04 ; $5f30
	ld a, $05 ; $5f35
	ld b, a ; $5f37
	ld a, $04 ; $5f38
	farcall FarPtr_FaceActorsTowardEachOther ; $5f3a
	script_set_anim $04, $02 ; $5f3d
	ld a, $32 ; $5f44
	call Func_27_7856 ; $5f46
	script_face $05, $40 ; $5f49
	script_set_anim $05, $04 ; $5f50
	script_wait_idle $05 ; $5f57
	ld a, $32 ; $5f5c
	call Func_27_7856 ; $5f5e
	script_set_anim $04, $02 ; $5f61
	script_set_anim $05, $02 ; $5f68
	script_set_anim $02, $02 ; $5f6f
	script_set_anim $00, $02 ; $5f76
	script_face $00, $40 ; $5f7d
	script_face $02, $40 ; $5f84
	script_face $04, $40 ; $5f8b
	ld a, $1e ; $5f92
	call Func_27_7856 ; $5f94
	script_player_speed $0030 ; $5f97
	script_set_speed $03, $0010 ; $5f9d
	script_move_player $2b00, $1f00 ; $5fa5
	script_move_target $03, $2b00, $2000 ; $5faf
	ld a, $5a ; $5fba
	call Func_27_7856 ; $5fbc
	script_player_speed $0010 ; $5fbf
	script_move_player $2400, $1b00 ; $5fc5
	script_move_target $03, $2500, $1f00 ; $5fcf
	script_wait_move $03 ; $5fda
	script_face $03, $c0 ; $5fdf
	script_set_anim $03, $02 ; $5fe6
	script_wait_idle $03 ; $5fed
	ld a, $14 ; $5ff2
	call Func_27_7856 ; $5ff4
	ld a, $02 ; $5ff7
	ld b, a ; $5ff9
	ld a, $00 ; $5ffa
	farcall FarPtr_FaceActorsTowardEachOther ; $5ffc
	ld a, $28 ; $5fff
	call Func_27_7856 ; $6001
	script_face $00, $40 ; $6004
	script_face $02, $40 ; $600b
	script_set_anim $02, $03 ; $6012
	script_set_anim $00, $03 ; $6019
	script_wait_idle $00 ; $6020
	script_set_anim $03, $03 ; $6025
	script_wait_idle $03 ; $602c
	ld a, $14 ; $6031
	call Func_27_7856 ; $6033
	script_move_target $03, $2500, $1d00 ; $6036
	script_wait_move $03 ; $6041
	script_set_anim $03, $02 ; $6046
	script_wait_idle $03 ; $604d
	script_wait_frames $1e ; $6052
	script_set_anim $03, $03 ; $6059
	script_set_anim $00, $03 ; $6060
	script_wait_idle $00 ; $6067
	ld a, $01 ; $606c
	ld [$c294], a ; $606e
	ld [wStoryModeExitLocationRequest], a ; $6071
	ret ; $6074
Label_27_6075:
	script_set_speed $04, $0018 ; $6075
	ld a, $00 ; $607d
	ld bc, $2400 ; $607f
	ld de, $1b00 ; $6082
	farcall FarPtr_ScriptSetActorPosition ; $6085
	script_face $00, $c0 ; $6088
	xor a, a ; $608f
	ld [wStoryModeShowLocationName], a ; $6090
	ld c, $04 ; $6093
	call BeginFadeIn ; $6095
	script_move_target $04, $2400, $1300 ; $6098
	script_wait_move $04 ; $60a3
	ld a, $14 ; $60a8
	call Func_27_7856 ; $60aa
	ld a, $28 ; $60ad
	call Func_27_7856 ; $60af
	script_set_anim $04, $02 ; $60b2
	script_set_anim $00, $02 ; $60b9
	script_wait_idle $00 ; $60c0
	script_face $00, $40 ; $60c5
	ld a, $1e ; $60cc
	call Func_27_7856 ; $60ce
	script_player_speed $0030 ; $60d1
	script_set_speed $03, $0010 ; $60d7
	script_move_player $2b00, $1f00 ; $60df
	script_move_target $03, $2b00, $1f00 ; $60e9
	ld a, $5a ; $60f4
	call Func_27_7856 ; $60f6
	script_player_speed $0010 ; $60f9
	script_move_player $2400, $1b00 ; $60ff
	script_wait_move $03 ; $6109
	script_move_target $03, $2400, $1f00 ; $610e
	script_wait_move $03 ; $6119
	script_move_target $03, $2400, $1e00 ; $611e
	script_wait_move $03 ; $6129
	script_move_target $03, $2400, $1d00 ; $612e
	script_wait_move $03 ; $6139
	ld a, $1e ; $613e
	call Func_27_7856 ; $6140
	script_set_anim $03, $02 ; $6143
	script_wait_idle $03 ; $614a
	ld a, $1e ; $614f
	call Func_27_7856 ; $6151
	script_set_anim $00, $03 ; $6154
	script_wait_idle $00 ; $615b
	ld a, $14 ; $6160
	call Func_27_7856 ; $6162
	script_set_anim $03, $03 ; $6165
	script_wait_idle $03 ; $616c
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
	script_move_player $2900, $2b00 ; $62b0
	script_move_target $00, $2900, $2b00 ; $62ba
	script_wait_move $00 ; $62c5
	script_move_target $00, $2b00, $2b00 ; $62ca
	script_wait_move $00 ; $62d5
	script_face $02, $00 ; $62da
	script_face $00, $00 ; $62e1
	script_wait_frames $1e ; $62e8
	script_set_anim $05, $03 ; $62ef
	script_wait_idle $05 ; $62f6
	script_move_target $05, $2d00, $2900 ; $62fb
	script_wait_move $05 ; $6306
	script_face $05, $40 ; $630b
	ld a, $02 ; $6312
	farcall FarPtr_SetActorNullScript ; $6314
	script_set_speed $00, $0020 ; $6317
	script_move_player $3800, $3300 ; $631f
	script_move_target $00, $3300, $2b00 ; $6329
	script_wait_move $00 ; $6334
	script_move_target $00, $3300, $3300 ; $6339
	script_wait_move $00 ; $6344
	script_move_target $00, $3800, $3500 ; $6349
	script_wait_move $00 ; $6354
	script_face $00, $c0 ; $6359
	script_wait_frames $0a ; $6360
	ld a, $01 ; $6367
	ld [$c294], a ; $6369
	ld [wStoryModeExitLocationRequest], a ; $636c
	ret ; $636f
Label_27_6370:
	ld a, $02 ; $6370
	ld bc, $1600 ; $6372
	ld de, $1a00 ; $6375
	farcall FarPtr_ScriptSetActorPosition ; $6378
	script_set_speed $02, $0010 ; $637b
	script_set_speed $00, $0010 ; $6383
	script_player_speed $0018 ; $638b
	ld c, $04 ; $6391
	call BeginFadeIn ; $6393
	script_move_angle $00, $c0, $0400 ; $6396
	script_wait_move $00 ; $63a0
	script_move_player $0f00, $1300 ; $63a5
	script_move_target $00, $1100, $1300 ; $63af
	script_wait_move $00 ; $63ba
	ld a, $00 ; $63bf
	ld b, a ; $63c1
	ld a, $07 ; $63c2
	farcall FarPtr_FaceActorTowardActor ; $63c4
	script_wait_frames $14 ; $63c7
	script_set_anim $00, $02 ; $63ce
	script_wait_idle $00 ; $63d5
	script_set_anim $07, $03 ; $63da
	script_wait_idle $07 ; $63e1
	script_face $00, $40 ; $63e6
	ldh a, [hRomBank] ; $63ed
	ld b, a ; $63ef
	ld a, $00 ; $63f0
	ld de, $6424 ; $63f2
	farcall FarPtr_ScriptSetActorScript ; $63f5
	script_wait_frames $78 ; $63f8
	ld a, $00 ; $63ff
	farcall FarPtr_SetActorNullScript ; $6401
	script_set_anim $00, $01 ; $6404
	script_set_speed $00, $0020 ; $640b
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
	script_player_speed $0010 ; $6572
	script_move_player $0f00, $1100 ; $6578
	ld c, $08 ; $6582
	call BeginFadeIn ; $6584
	script_set_speed $00, $0018 ; $6587
	script_move_target $00, $0d00, $1700 ; $658f
	script_wait_move $00 ; $659a
	script_move_target $00, $0f00, $1700 ; $659f
	script_wait_move $00 ; $65aa
	script_move_target $00, $0f00, $1100 ; $65af
	script_wait_move $00 ; $65ba
	script_player_speed $0018 ; $65bf
	script_move_player $1900, $1100 ; $65c5
	script_move_target $00, $1900, $1100 ; $65cf
	script_wait_move $00 ; $65da
	script_wait_frames $14 ; $65df
	script_face $12, $80 ; $65e6
	script_wait_frames $28 ; $65ed
	sound $97 ; $65f4
	ld a, $07 ; $65f6
	ld bc, $1c00 ; $65f8
	ld de, $1100 ; $65fb
	farcall FarPtr_ScriptSetActorPosition ; $65fe
	script_set_anim $12, $02 ; $6601
	script_wait_frames $3c ; $6608
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
	script_wait_frames $0f ; $6866
	ld a, $07 ; $686d
	ld b, a ; $686f
	ld a, $03 ; $6870
	farcall FarPtr_FaceActorTowardActor ; $6872
	script_wait_frames $0a ; $6875
	ld a, $07 ; $687c
	ld b, a ; $687e
	ld a, $00 ; $687f
	farcall FarPtr_FaceActorTowardActor ; $6881
	script_wait_frames $1e ; $6884
	script_player_speed $0020 ; $688b
	ld a, $07 ; $6891
	ld b, $00 ; $6893
	farcall FarPtr_MovePlayerToActor ; $6895
	farcall FarPtr_WaitPlayerMoveDone ; $6898
	ld a, $03 ; $689b
	ld b, a ; $689d
	ld a, $07 ; $689e
	farcall FarPtr_FaceActorTowardActor ; $68a0
	script_set_anim $07, $03 ; $68a3
	script_wait_idle $07 ; $68aa
	script_face $07, $40 ; $68af
	script_wait_frames $0a ; $68b6
	ldh a, [hRomBank] ; $68bd
	ld b, a ; $68bf
	ld a, $07 ; $68c0
	ld de, $6918 ; $68c2
	farcall FarPtr_ScriptSetActorScript ; $68c5
	script_wait_frames $14 ; $68c8
	ld a, $00 ; $68cf
	ld b, $00 ; $68d1
	farcall FarPtr_MovePlayerToActor ; $68d3
	script_face $03, $40 ; $68d6
	ld a, $00 ; $68dd
	ld b, $00 ; $68df
	farcall FarPtr_MovePlayerToActor ; $68e1
	ld a, $07 ; $68e4
	farcall FarPtr_WaitActorScriptDone ; $68e6
	ld a, $00 ; $68e9
	ld b, a ; $68eb
	ld a, $07 ; $68ec
	farcall FarPtr_FaceActorTowardActor ; $68ee
	script_set_anim $07, $02 ; $68f1
	script_wait_idle $07 ; $68f8
	script_set_anim $07, $03 ; $68fd
	script_wait_idle $07 ; $6904
	script_wait_frames $0f ; $6909
	script_face $07, $c0 ; $6910
	ret ; $6917
	INCBIN "data/bank_027/d_6918.bin" ; $6918, 57 bytes
Func_27_6951:
	farcall FarPtr_BeginCutsceneScriptMode ; $6951
	script_face $03, $40 ; $6954
	call Func_27_6866 ; $695b
	script_face $00, $c0 ; $695e
	script_wait_frames $0f ; $6965
	script_set_anim $03, $02 ; $696c
	script_wait_idle $03 ; $6973
	script_face $03, $00 ; $6978
	script_wait_frames $0f ; $697f
	script_face $00, $00 ; $6986
	script_face $07, $00 ; $698d
	script_wait_frames $1e ; $6994
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
	script_move_player $1700, $1100 ; $69b6
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
	script_wait_frames $14 ; $69de
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
	script_wait_frames $1e ; $69f9
	ld a, $00 ; $6a00
	ld b, a ; $6a02
	ld a, $03 ; $6a03
	farcall FarPtr_FaceActorTowardActor ; $6a05
	call Func_27_6a7d ; $6a08
	script_face $00, $c0 ; $6a0b
	script_wait_frames $0f ; $6a12
	script_set_anim $03, $02 ; $6a19
	script_wait_idle $03 ; $6a20
	script_face $03, $00 ; $6a25
	script_wait_frames $0f ; $6a2c
	script_face $00, $00 ; $6a33
	script_face $07, $00 ; $6a3a
	script_wait_frames $1e ; $6a41
	call Func_27_6b21 ; $6a48
	ld a, $01 ; $6a4b
	ld [$c294], a ; $6a4d
	ld [wStoryModeExitLocationRequest], a ; $6a50
	ret ; $6a53
Label_27_6a54:
	script_move_player $1300, $1500 ; $6a54
	ld c, $04 ; $6a5e
	call BeginFadeIn ; $6a60
	script_move_target $00, $1300, $1500 ; $6a63
	script_wait_move $00 ; $6a6e
	test_flag $05, 7 ; $6a73
	jp nz, Label_27_69ee ; $6a76
	call Func_27_6951 ; $6a79
	ret ; $6a7c
Func_27_6a7d:
	script_player_speed $0020 ; $6a7d
	script_face $03, $00 ; $6a83
	ld a, $08 ; $6a8a
	ld b, $00 ; $6a8c
	farcall FarPtr_MovePlayerToActor ; $6a8e
	farcall FarPtr_WaitPlayerMoveDone ; $6a91
	script_face $00, $00 ; $6a94
	script_face $02, $00 ; $6a9b
	ld a, $08 ; $6aa2
	farcall FarPtr_SetActorNullScript ; $6aa4
	script_face $08, $80 ; $6aa7
	script_set_anim $08, $02 ; $6aae
	script_wait_idle $08 ; $6ab5
	ld a, $00 ; $6aba
	ld b, $00 ; $6abc
	farcall FarPtr_MovePlayerToActor ; $6abe
	script_move_target $08, $1500, $1500 ; $6ac1
	script_move_target $09, $1500, $1700 ; $6acc
	script_wait_move $09 ; $6ad7
	script_face $09, $80 ; $6adc
	script_face $03, $40 ; $6ae3
	script_set_anim $08, $02 ; $6aea
	script_wait_idle $08 ; $6af1
	script_set_anim $09, $03 ; $6af6
	script_wait_frames $0f ; $6afd
	script_face $00, $c0 ; $6b04
	script_face $02, $c0 ; $6b0b
	script_face $08, $c0 ; $6b12
	script_face $09, $c0 ; $6b19
	ret ; $6b20
Func_27_6b21:
	script_face $03, $00 ; $6b21
	script_wait_frames $1e ; $6b28
	ld a, $02 ; $6b2f
	farcall FarPtr_SetActorNullScript ; $6b31
	script_move_player $1900, $1100 ; $6b34
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
	script_move_target $00, $1b00, $1900 ; $6b54
	script_wait_frames $0a ; $6b5f
	script_move_target $02, $1900, $1500 ; $6b66
	script_wait_move $00 ; $6b71
	script_face $00, $c0 ; $6b76
	script_face $02, $c0 ; $6b7d
	script_wait_frames $3c ; $6b84
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
	script_set_speed $03, $0010 ; $6caf
	script_set_speed $04, $0010 ; $6cb7
	script_set_speed $00, $0010 ; $6cbf
	script_player_speed $0010 ; $6cc7
	ld a, $00 ; $6ccd
	ld bc, $1600 ; $6ccf
	ld de, $1f00 ; $6cd2
	farcall FarPtr_ScriptSetActorPosition ; $6cd5
	ld a, $03 ; $6cd8
	ld bc, $1600 ; $6cda
	ld de, $1d00 ; $6cdd
	farcall FarPtr_ScriptSetActorPosition ; $6ce0
	script_face $03, $c0 ; $6ce3
	ld c, $20 ; $6cea
	call BeginFadeIn ; $6cec
	script_move_target $03, $1600, $1100 ; $6cef
	script_move_player $1600, $0f00 ; $6cfa
	script_move_target $00, $1600, $1400 ; $6d04
	script_wait_move $00 ; $6d0f
	script_move_target $03, $1600, $1100 ; $6d14
	script_move_target $00, $1600, $1300 ; $6d1f
	script_wait_move $00 ; $6d2a
	script_wait_frames $14 ; $6d2f
	script_wait_move $03 ; $6d36
	ld a, $00 ; $6d3b
	ld b, a ; $6d3d
	ld a, $03 ; $6d3e
	farcall FarPtr_FaceActorTowardActor ; $6d40
	script_set_anim $03, $03 ; $6d43
	script_wait_idle $03 ; $6d4a
	script_set_anim $00, $02 ; $6d4f
	script_player_speed $0018 ; $6d56
	script_move_player $1600, $0b00 ; $6d5c
	farcall FarPtr_WaitPlayerMoveDone ; $6d66
	script_wait_frames $14 ; $6d69
	script_move_player $1100, $0b00 ; $6d70
	farcall FarPtr_WaitPlayerMoveDone ; $6d7a
	script_wait_frames $0a ; $6d7d
	script_move_player $1a00, $0b00 ; $6d84
	farcall FarPtr_WaitPlayerMoveDone ; $6d8e
	script_wait_frames $0a ; $6d91
	script_move_player $1600, $0b00 ; $6d98
	farcall FarPtr_WaitPlayerMoveDone ; $6da2
	script_wait_frames $1e ; $6da5
	script_move_player $1600, $1000 ; $6dac
	script_set_anim $00, $02 ; $6db6
	script_wait_idle $00 ; $6dbd
	script_wait_frames $14 ; $6dc2
	script_player_speed $0010 ; $6dc9
	sound $97 ; $6dcf
	ld a, $05 ; $6dd1
	ld bc, $1780 ; $6dd3
	ld de, $0f00 ; $6dd6
	farcall FarPtr_ScriptSetActorPosition ; $6dd9
	script_set_anim $03, $02 ; $6ddc
	script_wait_idle $03 ; $6de3
	ld a, $05 ; $6de8
	ld bc, $0100 ; $6dea
	ld de, $0100 ; $6ded
	farcall FarPtr_ScriptSetActorPosition ; $6df0
	script_move_target $03, $1600, $0b00 ; $6df3
	script_wait_move $03 ; $6dfe
	ld a, $04 ; $6e03
	ld bc, $1700 ; $6e05
	ld de, $0b00 ; $6e08
	farcall FarPtr_ScriptSetActorPosition ; $6e0b
	script_wait_frames $3c ; $6e0e
	script_face $00, $40 ; $6e15
	script_wait_frames $14 ; $6e1c
	script_set_anim $00, $04 ; $6e23
	script_wait_idle $00 ; $6e2a
	script_wait_frames $14 ; $6e2f
	script_face $00, $c0 ; $6e36
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
	script_set_anim $04, $01 ; $6e61
Label_27_6e68:
	script_move_target $03, $1500, $0f00 ; $6e68
	script_wait_move $03 ; $6e73
	script_move_target $04, $1700, $0f00 ; $6e78
	script_wait_move $04 ; $6e83
	sound $98 ; $6e88
	ld a, $06 ; $6e8a
	ld bc, $1780 ; $6e8c
	ld de, $1100 ; $6e8f
	farcall FarPtr_ScriptSetActorPosition ; $6e92
	script_wait_frames $3c ; $6e95
	script_set_anim $03, $04 ; $6e9c
	script_wait_idle $03 ; $6ea3
	ld a, $06 ; $6ea8
	ld bc, $0100 ; $6eaa
	ld de, $0100 ; $6ead
	farcall FarPtr_ScriptSetActorPosition ; $6eb0
	ld a, $04 ; $6eb3
	ld b, a ; $6eb5
	ld a, $03 ; $6eb6
	farcall FarPtr_FaceActorTowardActor ; $6eb8
	script_wait_frames $3c ; $6ebb
	ld a, $00 ; $6ec2
	ld b, a ; $6ec4
	ld a, $03 ; $6ec5
	farcall FarPtr_FaceActorTowardActor ; $6ec7
	script_set_anim $04, $03 ; $6eca
	script_wait_idle $04 ; $6ed1
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
	script_move_target $06, $1b00, $0d00 ; $6fb9
	ld a, $00 ; $6fc4
	ld bc, $4300 ; $6fc6
	ld de, $0d00 ; $6fc9
	farcall FarPtr_ScriptSetActorPosition ; $6fcc
	script_move_target $00, $1d00, $0d00 ; $6fcf
	script_wait_frames $0f ; $6fda
	script_move_player $1b00, $0d00 ; $6fe1
	script_wait_move $00 ; $6feb
	script_wait_frames $1e ; $6ff0
	ld a, $00 ; $6ff7
	ld b, a ; $6ff9
	ld a, $06 ; $6ffa
	farcall FarPtr_FaceActorTowardActor ; $6ffc
	script_set_anim $00, $03 ; $6fff
	script_wait_idle $00 ; $7006
	script_face $06, $c0 ; $700b
	script_wait_frames $0f ; $7012
	script_face $00, $c0 ; $7019
	script_set_anim $00, $03 ; $7020
	script_wait_idle $00 ; $7027
	script_wait_frames $1e ; $702c
	call Func_27_716b ; $7033
	script_wait_frames $0f ; $7036
	sound $97 ; $703d
	ld a, $03 ; $703f
	ld bc, $1c00 ; $7041
	ld de, $0b00 ; $7044
	farcall FarPtr_ScriptSetActorPosition ; $7047
	script_wait_frames $1e ; $704a
	ld a, $03 ; $7051
	ld bc, $3f00 ; $7053
	ld de, $3f00 ; $7056
	farcall FarPtr_ScriptSetActorPosition ; $7059
	script_face $06, $80 ; $705c
	script_wait_frames $0f ; $7063
	script_face $00, $80 ; $706a
	script_move_player $1800, $0d00 ; $7071
	script_wait_frames $0f ; $707b
	ld a, $07 ; $7082
	ld bc, $1500 ; $7084
	ld de, $0980 ; $7087
	farcall FarPtr_ScriptSetActorPosition ; $708a
	script_wait_frames $0f ; $708d
	script_set_speed $07, $0010 ; $7094
	script_move_target $07, $1500, $0d00 ; $709c
	script_wait_move $07 ; $70a7
	script_face $07, $00 ; $70ac
	ld a, $08 ; $70b3
	ld bc, $1500 ; $70b5
	ld de, $0900 ; $70b8
	farcall FarPtr_ScriptSetActorPosition ; $70bb
	script_wait_frames $0f ; $70be
	script_set_speed $08, $0010 ; $70c5
	script_move_target $08, $1500, $0b00 ; $70cd
	script_wait_move $08 ; $70d8
	call Func_27_71bf ; $70dd
	script_face $08, $00 ; $70e0
	script_wait_frames $0f ; $70e7
	script_set_anim $06, $02 ; $70ee
	script_wait_idle $06 ; $70f5
	script_face $07, $40 ; $70fa
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
	script_wait_frames $02 ; $718b
	ld b, $02 ; $7192
	ld c, $15 ; $7194
	ld d, $14 ; $7196
	ld e, $08 ; $7198
	ld h, $02 ; $719a
	ld l, $02 ; $719c
	farcall FarPtr_CopySceneTilemapRect ; $719e
	script_wait_frames $02 ; $71a1
	ld b, $04 ; $71a8
	ld c, $15 ; $71aa
	ld d, $14 ; $71ac
	ld e, $08 ; $71ae
	ld h, $02 ; $71b0
	ld l, $02 ; $71b2
	farcall FarPtr_CopySceneTilemapRect ; $71b4
	script_wait_frames $02 ; $71b7
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
	script_wait_frames $01 ; $71d0
	ld b, $02 ; $71d7
	ld c, $15 ; $71d9
	ld d, $14 ; $71db
	ld e, $08 ; $71dd
	ld h, $02 ; $71df
	ld l, $02 ; $71e1
	farcall FarPtr_CopySceneTilemapRect ; $71e3
	script_wait_frames $01 ; $71e6
	ld b, $00 ; $71ed
	ld c, $15 ; $71ef
	ld d, $14 ; $71f1
	ld e, $08 ; $71f3
	ld h, $02 ; $71f5
	ld l, $02 ; $71f7
	farcall FarPtr_CopySceneTilemapRect ; $71f9
	script_wait_frames $01 ; $71fc
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
	script_set_speed $00, $0010 ; $730a
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
	script_player_speed $0040 ; $737e
	script_move_player $1800, $1200 ; $7384
	farcall FarPtr_WaitPlayerMoveDone ; $738e
	ld c, $04 ; $7391
	call BeginFadeIn ; $7393
	call WaitFadeEnd ; $7396
	script_move_target $00, $1800, $2100 ; $7399
	script_wait_frames $14 ; $73a4
	ld a, $00 ; $73ab
	ld bc, $1800 ; $73ad
	ld de, $2000 ; $73b0
	farcall FarPtr_ScriptSetActorPosition ; $73b3
	script_face $00, $c0 ; $73b6
	script_set_speed $06, $0024 ; $73bd
	script_move_target $06, $1800, $1400 ; $73c5
	script_wait_move $06 ; $73d0
	script_set_anim $06, $04 ; $73d5
	script_wait_idle $06 ; $73dc
	script_face $06, $c0 ; $73e1
	script_set_anim $06, $03 ; $73e8
	script_wait_idle $06 ; $73ef
	script_set_speed $06, $0020 ; $73f4
	script_face $06, $40 ; $73fc
	ld a, $06 ; $7403
	ld de, $ff80 ; $7405
	farcall FarPtr_ScriptSetActorJumpVelocity ; $7408
	ld a, $06 ; $740b
	farcall FarPtr_ScriptWaitActorJumpDone ; $740d
	script_move_target $06, $1800, $1700 ; $7410
	script_wait_move $06 ; $741b
	sound $98 ; $7420
	ld a, $03 ; $7422
	ld bc, $1980 ; $7424
	ld de, $15c0 ; $7427
	farcall FarPtr_ScriptSetActorPosition ; $742a
	script_set_speed $06, $0010 ; $742d
	script_set_speed $03, $0010 ; $7435
	script_move_target $03, $1980, $18c0 ; $743d
	script_move_target $06, $1800, $1a00 ; $7448
	script_wait_move $06 ; $7453
	ld a, $03 ; $7458
	ld bc, $3f00 ; $745a
	ld de, $3f00 ; $745d
	farcall FarPtr_ScriptSetActorPosition ; $7460
	script_move_target $06, $1800, $1600 ; $7463
	script_wait_move $06 ; $746e
	script_wait_frames $1e ; $7473
	script_set_anim $06, $02 ; $747a
	sound $97 ; $7481
	ld a, $04 ; $7483
	ld bc, $1980 ; $7485
	ld de, $14c0 ; $7488
	farcall FarPtr_ScriptSetActorPosition ; $748b
	script_wait_frames $14 ; $748e
	ld a, $04 ; $7495
	ld bc, $3f00 ; $7497
	ld de, $3f00 ; $749a
	farcall FarPtr_ScriptSetActorPosition ; $749d
	script_set_speed $06, $0020 ; $74a0
	ld a, $06 ; $74a8
	ld de, $ff80 ; $74aa
	farcall FarPtr_ScriptSetActorJumpVelocity ; $74ad
	ld a, $06 ; $74b0
	farcall FarPtr_ScriptWaitActorJumpDone ; $74b2
	script_move_target $06, $1800, $2000 ; $74b5
	script_wait_frames $1e ; $74c0
	ld bc, $d040 ; $74c7
	ld a, $06 ; $74ca
	farcall FarPtr_GetActorStateAddr ; $74cc
	ld e, l ; $74cf
	ld d, h ; $74d0
	farcall FarPtr_04_1e ; $74d1
	script_move_target $00, $1800, $1e00 ; $74d4
	script_wait_frames $14 ; $74df
	call Func_27_7595 ; $74e6
	script_wait_move $06 ; $74e9
	script_set_anim $06, $02 ; $74ee
	sound $96 ; $74f5
	ld a, $05 ; $74f7
	ld bc, $1900 ; $74f9
	ld de, $1e00 ; $74fc
	farcall FarPtr_ScriptSetActorPosition ; $74ff
	script_wait_frames $3c ; $7502
	ld a, $05 ; $7509
	ld bc, $3f00 ; $750b
	ld de, $3f00 ; $750e
	farcall FarPtr_ScriptSetActorPosition ; $7511
	script_move_target $06, $1700, $2200 ; $7514
	script_wait_move $06 ; $751f
	ld a, $00 ; $7524
	ld b, a ; $7526
	ld a, $06 ; $7527
	farcall FarPtr_FaceActorTowardActor ; $7529
	script_wait_frames $14 ; $752c
	script_move_target $06, $1900, $2400 ; $7533
	script_wait_move $06 ; $753e
	ld a, $01 ; $7543
	farcall FarPtr_SetActorNullScript ; $7545
	ld a, $00 ; $7548
	ld b, a ; $754a
	ld a, $06 ; $754b
	farcall FarPtr_FaceActorTowardActor ; $754d
	script_set_anim $06, $02 ; $7550
	script_wait_idle $06 ; $7557
	script_wait_frames $14 ; $755c
	ld a, $07 ; $7563
	ld bc, $1a80 ; $7565
	ld de, $2280 ; $7568
	farcall FarPtr_ScriptSetActorPosition ; $756b
	script_wait_frames $3c ; $756e
	ld a, $07 ; $7575
	ld bc, $3f00 ; $7577
	ld de, $3f00 ; $757a
	farcall FarPtr_ScriptSetActorPosition ; $757d
	script_set_anim $06, $02 ; $7580
	script_wait_idle $06 ; $7587
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
	script_wait_frames $0a ; $75a1
	ld a, $00 ; $75a8
	farcall FarPtr_SetScreenShake ; $75aa
	script_set_speed $00, $0040 ; $75ad
	script_move_player $1800, $2400 ; $75b5
	script_move_target $00, $1700, $2400 ; $75bf
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
	script_wait_frames $1e ; $75e1
	script_set_anim $00, $02 ; $75e8
	script_wait_idle $00 ; $75ef
	script_wait_frames $1e ; $75f4
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
	script_set_anim $0a, $01 ; $7640
	ld a, $0c ; $7647
	ld bc, $1a00 ; $7649
	ld de, $1100 ; $764c
	farcall FarPtr_ScriptSetActorPosition ; $764f
	script_face $0c, $40 ; $7652
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
	script_set_anim $00, $01 ; $766a
	ld a, $00 ; $7671
	ld bc, $1700 ; $7673
	ld de, $1700 ; $7676
	farcall FarPtr_ScriptSetActorPosition ; $7679
	script_face $00, $c0 ; $767c
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
	script_set_anim $00, $03 ; $76a3
	script_set_anim $0a, $03 ; $76aa
	script_wait_idle $0a ; $76b1
	ld a, $1e ; $76b6
	call Func_27_7856 ; $76b8
	script_face $0a, $c0 ; $76bb
	ld a, $1e ; $76c2
	call Func_27_7856 ; $76c4
	script_set_anim $0c, $02 ; $76c7
	script_wait_idle $0c ; $76ce
	ld a, $32 ; $76d3
	call Func_27_7856 ; $76d5
	ld a, $0c ; $76d8
	ld b, a ; $76da
	ld a, $08 ; $76db
	farcall FarPtr_FaceActorsTowardEachOther ; $76dd
	script_set_anim $08, $03 ; $76e0
	script_set_anim $0c, $03 ; $76e7
	script_wait_idle $0c ; $76ee
	script_face $0c, $40 ; $76f3
	script_face $08, $40 ; $76fa
	jp Label_27_7748 ; $7701
Label_27_7704:
	ld a, $0b ; $7704
	ld b, a ; $7706
	ld a, $00 ; $7707
	farcall FarPtr_FaceActorsTowardEachOther ; $7709
	ld a, $1e ; $770c
	call Func_27_7856 ; $770e
	script_set_anim $00, $03 ; $7711
	script_set_anim $0b, $03 ; $7718
	script_wait_idle $0b ; $771f
	ld a, $0a ; $7724
	call Func_27_7856 ; $7726
	script_face $00, $c0 ; $7729
	script_face $0b, $c0 ; $7730
	ld a, $14 ; $7737
	call Func_27_7856 ; $7739
	script_set_anim $08, $03 ; $773c
	script_wait_idle $08 ; $7743
Label_27_7748:
	ld a, $28 ; $7748
	call Func_27_7856 ; $774a
	script_set_anim $09, $03 ; $774d
	script_set_anim $0a, $03 ; $7754
	script_set_anim $00, $03 ; $775b
	script_set_anim $0b, $03 ; $7762
	script_wait_idle $0b ; $7769
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
	script_move_target $00, $1600, $1700 ; $77a4
	script_move_target $0b, $1a00, $1700 ; $77af
	script_move_target $0a, $1500, $1500 ; $77ba
	script_move_target $09, $1b00, $1500 ; $77c5
	script_wait_move $09 ; $77d0
	script_player_speed $0020 ; $77d5
	script_move_player $1800, $2f00 ; $77db
	script_move_target $08, $1800, $1900 ; $77e5
	script_wait_move $08 ; $77f0
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
	script_move_target $00, $1600, $1f00 ; $7811
	script_move_target $0b, $1a00, $1f00 ; $781c
	script_move_target $0a, $1500, $1d00 ; $7827
	script_move_target $09, $1b00, $1d00 ; $7832
	script_move_target $08, $1800, $2100 ; $783d
	script_wait_move $08 ; $7848
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

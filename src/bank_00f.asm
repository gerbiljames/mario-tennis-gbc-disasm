SECTION "ROM Bank $0f", ROMX[$4000], BANK[$0f]

DataPtr_SmallCharTestMapScripts_0f:
	dw SmallCharTestMapScripts_0f ; $4000
DataPtr_AwardsCeremonyMapScripts_0f:
	dw AwardsCeremonyMapScripts_0f ; $4002
DataPtr_TournamentMapScripts_0f:
	dw TournamentMapScripts_0f ; $4004
SmallCharTestMapScripts_0f:
	; $4006, 14 bytes (map_tree)
	dw SmallCharTestEntryPoints_0f ; slot 0 EntryPoints
	dw SmallCharTestExitTriggers_0f ; slot 1 ExitTriggers
	dw SmallCharTestActors_0f ; slot 2 Actors
	dw SmallCharTestNpcScripts_0f ; slot 3 NpcScripts
	dw SmallCharTestFacingScripts_0f ; slot 4 FacingScripts
	dw SmallCharTestTileTriggers_0f ; slot 5 TileTriggers
	dw SmallCharTestInitScript_0f ; slot 6 InitScript
SmallCharTestActors_0f:
	; $4014, 178 bytes (map_actors)
	map_actor $0000, $7b57, $0700, $0300, $40, $26, $01, $00
	map_actor $0000, $7b57, $0d00, $0300, $40, $2b, $01, $00
	map_actor $0000, $7b57, $0700, $0700, $40, $2c, $01, $00
	map_actor $0000, $7b57, $0d00, $0700, $40, $2d, $01, $00
	map_actor $0000, $7b57, $0500, $0d00, $40, $70, $01, $00
	map_actor $0000, $7b57, $0900, $0d00, $40, $71, $01, $00
	map_actor $0000, $7b57, $0d00, $0d00, $40, $72, $01, $00
	map_actor $0000, $7b57, $1100, $0d00, $40, $73, $01, $00
	map_actor $0000, $7b57, $0500, $1100, $40, $6d, $01, $00
	map_actor $0000, $7b57, $0900, $1100, $40, $6e, $01, $00
	map_actor $0000, $7b57, $0d00, $1100, $40, $48, $01, $00
	map_actor $0000, $7b57, $1100, $1100, $40, $2b, $01, $00
	map_actor_end
SmallCharTestEntryPoints_0f:
	; $40c6, 9 bytes (map_entries)
	map_entry $01, $40, $0b00, $0b00, $0000
	db $ff
SmallCharTestExitTriggers_0f:
	ds 1, $ff ; $40cf, fill
	ld hl, $c2b0 ; $40d0
	ld a, [hl] ; $40d3
	dec a ; $40d4
	ld hl, $c2b1 ; $40d5
	add a, a ; $40d8
	jr nc, Label_0f_40df ; $40d9
	ld a, [hl] ; $40db
	dec a ; $40dc
	jr Label_0f_40e4 ; $40dd
Label_0f_40df:
	rra ; $40df
	cp a, [hl] ; $40e0
	jr c, Label_0f_40e4 ; $40e1
	xor a, a ; $40e3
Label_0f_40e4:
	cp a, $29 ; $40e4
	jr nc, Label_0f_40ec ; $40e6
	ld hl, $c2b1 ; $40e8
	ld a, [hl] ; $40eb
Label_0f_40ec:
	ld hl, $c2b0 ; $40ec
	ld [hl], a ; $40ef
	call SetPlayerActorObjectDef ; $40f0
	ret ; $40f3
Func_0f_40f4:
	ld hl, $c2b0 ; $40f4
	ld a, [hl] ; $40f7
	inc [hl] ; $40f8
	and a, $03 ; $40f9
	add a, $26 ; $40fb
	call SetPlayerActorObjectDef ; $40fd
	ret ; $4100
Func_0f_4101:
	ld hl, $c2b0 ; $4101
	ld a, [hl] ; $4104
	inc a ; $4105
	ld hl, $c2b1 ; $4106
	add a, a ; $4109
	jr nc, Label_0f_4110 ; $410a
	ld a, [hl] ; $410c
	dec a ; $410d
	jr Label_0f_4115 ; $410e
Label_0f_4110:
	rra ; $4110
	cp a, [hl] ; $4111
	jr c, Label_0f_4115 ; $4112
	xor a, a ; $4114
Label_0f_4115:
	cp a, $2a ; $4115
	jr nc, Label_0f_40ec ; $4117
	ld hl, $002a ; $4119
	ld a, l ; $411c
	jr Label_0f_40ec ; $411d
	ld hl, $c2b0 ; $411f
	ld [hl], a ; $4122
	call SetPlayerActorObjectDef ; $4123
	ret ; $4126
Func_0f_4127:
	script_set_anim $00, $03 ; $4127
	ret ; $412e
Func_0f_412f:
	script_set_anim $00, $04 ; $412f
	ret ; $4136
Func_0f_4137:
	ret ; $4137
SmallCharTestNpcScripts_0f:
	; $4138, 97 bytes (map_scripts)
	map_script $03, $ff, $0000, Func_0f_40f4, $00, $00
	map_script $04, $ff, $0000, Func_0f_4101, $00, $00
	map_script $05, $ff, $0000, Func_0f_4127, $00, $00
	map_script $06, $ff, $0000, Func_0f_412f, $00, $00
	map_script $07, $ff, $0000, Func_0f_4137, $01, $00
	map_script $08, $ff, $0000, Func_0f_4137, $01, $00
	map_script $09, $ff, $0000, Func_0f_4137, $01, $00
	map_script $0a, $ff, $0000, Func_0f_4137, $01, $00
	map_script $0b, $ff, $0000, Func_0f_4137, $01, $00
	map_script $0c, $ff, $0000, Func_0f_4137, $01, $00
	map_script $0d, $ff, $0000, Func_0f_4137, $01, $00
	map_script $0e, $ff, $0000, Func_0f_4137, $01, $00
	db $ff
SmallCharTestFacingScripts_0f:
	ds 1, $ff ; $4199, fill
Func_0f_419a:
	ret ; $419a
SmallCharTestTileTriggers_0f:
	; $419b, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_0f_419a, $00, $00
	db $ff
SmallCharTestInitScript_0f:
	xor a, a ; $41a4
	ld [$c2b0], a ; $41a5
	farcall FarPtr_GetObjectDefCount ; $41a8
	ld [$c2b1], a ; $41ab
	ld a, $01 ; $41ae
	ld hl, $41b7 ; $41b0
	call RegisterFrameTask ; $41b3
	ret ; $41b6
	ldh a, [hInputRisingEdge] ; $41b7
	and a, $f0 ; $41b9
	jr z, Label_0f_41c4 ; $41bb
	script_set_anim $00, $01 ; $41bd
Label_0f_41c4:
	ret ; $41c4
SetPlayerActorObjectDef:
	ld d, a ; $41c5
	wram_bank $04 ; $41c6
	ld hl, $dae9 ; $41cc
	ld [hl], $00 ; $41cf
	ld bc, $d000 ; $41d1
	farcall FarPtr_04_2c ; $41d4
	call RestorePalettesFromMaster ; $41d7
	ret ; $41da
AwardsCeremonyMapScripts_0f:
	; $41db, 14 bytes (map_tree)
	dw AwardsCeremonyEntryPoints_0f ; slot 0 EntryPoints
	dw AwardsCeremonyExitTriggers_0f ; slot 1 ExitTriggers
	dw AwardsCeremonyActors_0f ; slot 2 Actors
	dw AwardsCeremonyNpcScripts_0f ; slot 3 NpcScripts
	dw AwardsCeremonyFacingScripts_0f ; slot 4 FacingScripts
	dw AwardsCeremonyTileTriggers_0f ; slot 5 TileTriggers
	dw AwardsCeremonyInitScript_0f ; slot 6 InitScript
AwardsCeremonyActors_0f:
	; $41e9, 290 bytes (map_actors)
	map_actor $0000, $7b57, $0b00, $2700, $c0, $5c, $01, $00
	map_actor $0000, $7b57, $0d00, $2700, $c0, $61, $01, $00
	map_actor $0000, $7b57, $0e80, $1b00, $80, $62, $01, $00
	map_actor $0000, $7b57, $0800, $1f00, $00, $5d, $01, $00
	map_actor $0000, $7b57, $0700, $2100, $00, $5e, $01, $00
	map_actor $0000, $7b57, $0800, $1d00, $00, $5f, $01, $00
	map_actor $0000, $7b57, $0f00, $1d00, $80, $24, $01, $00
	map_actor $0000, $7b57, $0980, $1b00, $00, $23, $01, $00
	map_actor $0000, $7b57, $0800, $1940, $00, $25, $01, $05
	map_actor $0000, $7b57, $0800, $1700, $00, $63, $01, $00
	map_actor $0000, $7b57, $0ec0, $1780, $40, $74, $01, $00
	map_actor $0000, $7b57, $1040, $17c0, $40, $74, $01, $00
	map_actor $0000, $7b57, $1180, $17c0, $40, $74, $01, $00
	map_actor $0000, $7b57, $0f00, $1600, $80, $25, $01, $00
	map_actor $0000, $7b57, $1100, $2100, $80, $5b, $01, $00
	map_actor $0000, $7b57, $1000, $1f00, $80, $5a, $01, $00
	map_actor $0000, $7b57, $fd00, $0100, $40, $4e, $01, $00
	map_actor $0000, $7b57, $fd00, $0100, $40, $53, $01, $00
	map_actor $0000, $7b57, $fd00, $0100, $40, $4d, $01, $00
	map_actor $0000, $7b57, $fd00, $0100, $40, $26, $01, $00
	map_actor_end
AwardsCeremonyActorsDoubles_0f:
	; $430b, 290 bytes (map_actors)
	map_actor $0000, $7b57, $0f00, $1b00, $80, $5c, $01, $00
	map_actor $0000, $7b57, $0d00, $2700, $c0, $61, $01, $00
	map_actor $0000, $7b57, $0d00, $2900, $c0, $62, $01, $00
	map_actor $0000, $7b57, $0800, $1f00, $00, $5d, $01, $00
	map_actor $0000, $7b57, $0700, $2100, $00, $5e, $01, $00
	map_actor $0000, $7b57, $0800, $1d00, $00, $5f, $01, $00
	map_actor $0000, $7b57, $0f00, $1d00, $80, $24, $01, $00
	map_actor $0000, $7b57, $0900, $1b00, $00, $23, $01, $00
	map_actor $0000, $7b57, $0800, $1940, $00, $25, $01, $05
	map_actor $0000, $7b57, $0800, $1700, $00, $63, $01, $00
	map_actor $0000, $7b57, $0f00, $1780, $40, $74, $01, $00
	map_actor $0000, $7b57, $1100, $17c0, $40, $74, $01, $00
	map_actor $0000, $7b57, $2900, $2900, $40, $74, $01, $00
	map_actor $0000, $7b57, $0f00, $1600, $80, $25, $01, $00
	map_actor $0000, $7b57, $2f00, $2100, $80, $5b, $01, $00
	map_actor $0000, $7b57, $1000, $2000, $80, $5a, $01, $00
	map_actor $0000, $7b57, $fd00, $0100, $40, $4e, $01, $00
	map_actor $0000, $7b57, $fd00, $0100, $40, $53, $01, $00
	map_actor $0000, $7b57, $fd00, $0100, $40, $4d, $01, $00
	map_actor $0000, $7b57, $fd00, $0100, $40, $26, $01, $00
	map_actor_end
AwardsCeremonyEntryPoints_0f:
	; $442d, 25 bytes (map_entries)
	map_entry $01, $c0, $0c00, $2900, $0000
	map_entry $0a, $c0, $0c00, $2900, $0000
	map_entry $0b, $c0, $0b00, $2900, $0000
	db $ff
AwardsCeremonyExitTriggers_0f:
	ds 1, $ff ; $4446, fill
AwardsCeremonyNpcScripts_0f:
	; $4447, 81 bytes (map_scripts)
	map_script $03, $ff, $0000, $0000, $03, $00
	map_script $04, $ff, $0000, $2873, $03, $00
	map_script $05, $ff, $0000, $2884, $03, $00
	map_script $06, $ff, $0000, $287a, $03, $00
	map_script $07, $ff, $0000, $287c, $03, $00
	map_script $08, $ff, $0000, Func_0f_5628, $03, $00
	map_script $09, $ff, $0000, $2882, $03, $00
	map_script $0a, $ff, $0000, $2883, $03, $00
	map_script $11, $ff, $0000, $2879, $03, $00
	map_script $12, $ff, $0000, $287b, $03, $00
	db $ff
AwardsCeremonyFacingScripts_0f:
	; $4498, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_0f_44a1, $00, $00
	db $ff
Func_0f_44a1:
	ret ; $44a1
AwardsCeremonyTileTriggers_0f:
	; $44a2, 17 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_0f_44b3, $00, $00
	map_script $02, $ff, $0000, Func_0f_4725, $00, $00
	db $ff
Func_0f_44b3:
	ld b, $0a ; $44b3
	ld c, $1c ; $44b5
	ld d, $0a ; $44b7
	ld e, $1a ; $44b9
	ld h, $04 ; $44bb
	ld l, $02 ; $44bd
	farcall FarPtr_CopyBehaviorMapRect ; $44bf
	call CutsceneStompScreenShake ; $44c2
	call CutsceneStompScreenShake ; $44c5
	script_set_text $287e ; $44c8
	script_speak $08 ; $44ce
	test_flag $05, 7 ; $44d3
	jp z, Label_0f_45b6 ; $44d6
	set_flag $10, 4 ; $44d9
	script_set_text $28b4 ; $44dc
	ld a, $02 ; $44e2
	farcall FarPtr_SetActorNullScript ; $44e4
	script_move_target $02, $0d00, $1b00 ; $44e7
	script_wait_move $02 ; $44f2
	script_move_target $00, $0b00, $1b00 ; $44f7
	script_wait_move $00 ; $4502
	call ReplacePlayerWithStandInActor ; $4507
	ld a, $16 ; $450a
	ld bc, $0b00 ; $450c
	ld de, $1b00 ; $450f
	farcall FarPtr_ScriptSetActorPosition ; $4512
	ld a, [$c94d] ; $4515
	ld d, $58 ; $4518
	add a, d ; $451a
	ld d, a ; $451b
	ld a, $15 ; $451c
	farcall FarPtr_GetActorStateAddr ; $451e
	ld c, l ; $4521
	ld b, h ; $4522
	farcall FarPtr_04_2c ; $4523
	script_set_anim $15, $01 ; $4526
	ld a, $02 ; $452d
	ld bc, $3f00 ; $452f
	ld de, $3f00 ; $4532
	farcall FarPtr_ScriptSetActorPosition ; $4535
	ld a, $15 ; $4538
	ld bc, $0d00 ; $453a
	ld de, $1b00 ; $453d
	farcall FarPtr_ScriptSetActorPosition ; $4540
	script_face $16, $40 ; $4543
	script_face $15, $40 ; $454a
	script_move_target $08, $0c00, $1d00 ; $4551
	script_wait_move $08 ; $455c
	script_face $08, $c0 ; $4561
	ld a, $13 ; $4568
	ld bc, $0d80 ; $456a
	ld de, $1b00 ; $456d
	farcall FarPtr_ScriptSetActorPosition ; $4570
	sound $99 ; $4573
	script_speak $08 ; $4575
	ld a, $13 ; $457a
	ld bc, $3f00 ; $457c
	ld de, $3f00 ; $457f
	farcall FarPtr_ScriptSetActorPosition ; $4582
	script_set_anim $08, $02 ; $4585
	script_wait_idle $08 ; $458c
	script_speak $08 ; $4591
	ld a, $14 ; $4596
	ld bc, $0c80 ; $4598
	ld de, $1900 ; $459b
	farcall FarPtr_ScriptSetActorPosition ; $459e
	sound $96 ; $45a1
	ld a, $78 ; $45a3
	call DelayFrames ; $45a5
	ld a, $14 ; $45a8
	ld bc, $3f00 ; $45aa
	ld de, $3f00 ; $45ad
	farcall FarPtr_ScriptSetActorPosition ; $45b0
	jp Label_0f_4661 ; $45b3
Label_0f_45b6:
	set_flag $10, 3 ; $45b6
	ld a, $03 ; $45b9
	farcall FarPtr_SetActorNullScript ; $45bb
	script_move_target $00, $0b80, $1b00 ; $45be
	script_wait_move $00 ; $45c9
	call ReplacePlayerWithStandInActor ; $45ce
	ld a, $16 ; $45d1
	ld bc, $0b80 ; $45d3
	ld de, $1b00 ; $45d6
	farcall FarPtr_ScriptSetActorPosition ; $45d9
	script_move_target $03, $0d00, $1d00 ; $45dc
	script_wait_move $03 ; $45e7
	script_face $03, $80 ; $45ec
	ld a, $01 ; $45f3
	call DelayFrames ; $45f5
	script_move_target $08, $0b00, $1d00 ; $45f8
	script_wait_move $08 ; $4603
	script_face $16, $40 ; $4608
	script_face $08, $c0 ; $460f
	ld a, $13 ; $4616
	ld bc, $0c80 ; $4618
	ld de, $1b00 ; $461b
	farcall FarPtr_ScriptSetActorPosition ; $461e
	sound $99 ; $4621
	script_speak $08 ; $4623
	ld a, $13 ; $4628
	ld bc, $3f00 ; $462a
	ld de, $3f00 ; $462d
	farcall FarPtr_ScriptSetActorPosition ; $4630
	script_set_anim $08, $02 ; $4633
	script_wait_idle $08 ; $463a
	script_speak $08 ; $463f
	ld a, $14 ; $4644
	ld bc, $0d00 ; $4646
	ld de, $1900 ; $4649
	farcall FarPtr_ScriptSetActorPosition ; $464c
	sound $96 ; $464f
	ld a, $78 ; $4651
	call DelayFrames ; $4653
	ld a, $14 ; $4656
	ld bc, $3f00 ; $4658
	ld de, $3f00 ; $465b
	farcall FarPtr_ScriptSetActorPosition ; $465e
Label_0f_4661:
	call CutsceneStompScreenShake ; $4661
	call CutsceneStompScreenShake ; $4664
	script_speak $08 ; $4667
	call CutsceneStompScreenShake ; $466c
	call CutsceneStompScreenShake ; $466f
	script_move_target $08, $0900, $1d00 ; $4672
	script_wait_move $08 ; $467d
	script_face $08, $00 ; $4682
	ld a, $01 ; $4689
	call DelayFrames ; $468b
	ld a, $16 ; $468e
	ld bc, $3f00 ; $4690
	ld de, $3f00 ; $4693
	farcall FarPtr_ScriptSetActorPosition ; $4696
	test_flag $05, 7 ; $4699
	jp z, Label_0f_4700 ; $469c
	ld a, $15 ; $469f
	ld bc, $3f00 ; $46a1
	ld de, $3f00 ; $46a4
	farcall FarPtr_ScriptSetActorPosition ; $46a7
	ld d, $4d ; $46aa
	ld a, $15 ; $46ac
	farcall FarPtr_GetActorStateAddr ; $46ae
	ld c, l ; $46b1
	ld b, h ; $46b2
	farcall FarPtr_04_2c ; $46b3
	script_set_anim $15, $01 ; $46b6
	script_face $00, $40 ; $46bd
	ld a, $00 ; $46c4
	ld bc, $0b00 ; $46c6
	ld de, $1b00 ; $46c9
	farcall FarPtr_ScriptSetActorPosition ; $46cc
	ld a, $02 ; $46cf
	ld bc, $0d00 ; $46d1
	ld de, $1b00 ; $46d4
	farcall FarPtr_ScriptSetActorPosition ; $46d7
	ld a, $01 ; $46da
	call DelayFrames ; $46dc
	script_face $00, $40 ; $46df
	script_face $02, $40 ; $46e6
	ld a, $01 ; $46ed
	call DelayFrames ; $46ef
	ld a, $02 ; $46f2
	farcall FarPtr_GetActorStateAddr ; $46f4
	ld c, l ; $46f7
	ld b, h ; $46f8
	ld de, $d000 ; $46f9
	farcall FarPtr_04_20 ; $46fc
	ret ; $46ff
Label_0f_4700:
	ld a, $00 ; $4700
	ld bc, $0b80 ; $4702
	ld de, $1b00 ; $4705
	farcall FarPtr_ScriptSetActorPosition ; $4708
	script_face $00, $40 ; $470b
	ld a, $01 ; $4712
	call DelayFrames ; $4714
	ld a, $03 ; $4717
	farcall FarPtr_GetActorStateAddr ; $4719
	ld c, l ; $471c
	ld b, h ; $471d
	ld de, $d000 ; $471e
	farcall FarPtr_04_20 ; $4721
	ret ; $4724
Func_0f_4725:
	test_flag $05, 7 ; $4725
	jp nz, Label_0f_4ea7 ; $4728
	ld a, $03 ; $472b
	farcall FarPtr_SetActorNullScript ; $472d
	script_move_target $00, $0c00, $1900 ; $4730
	script_move_target $03, $0c00, $1b00 ; $473b
	script_wait_move $03 ; $4746
	ld a, $0a ; $474b
	call DelayFrames ; $474d
	ld a, $0b ; $4750
	ld b, a ; $4752
	ld a, $00 ; $4753
	farcall FarPtr_FaceActorTowardActor ; $4755
	script_face $03, $c0 ; $4758
	ld a, $3c ; $475f
	call DelayFrames ; $4761
	call AnnounceWinnersToPodiums ; $4764
	script_face $00, $40 ; $4767
	script_move_target $04, $0c00, $1d00 ; $476e
	script_wait_move $04 ; $4779
	ld a, $0a ; $477e
	call DelayFrames ; $4780
	call Func_0f_5c96 ; $4783
	script_set_speed $00, $0020 ; $4786
	script_set_speed $03, $0020 ; $478e
	script_set_speed $04, $0020 ; $4796
	ldh a, [hRomBank] ; $479e
	ld b, a ; $47a0
	ld a, $00 ; $47a1
	ld de, $5665 ; $47a3
	farcall FarPtr_ScriptSetActorScript ; $47a6
	ldh a, [hRomBank] ; $47a9
	ld b, a ; $47ab
	ld a, $03 ; $47ac
	ld de, $5665 ; $47ae
	farcall FarPtr_ScriptSetActorScript ; $47b1
	ldh a, [hRomBank] ; $47b4
	ld b, a ; $47b6
	ld a, $04 ; $47b7
	ld de, $5665 ; $47b9
	farcall FarPtr_ScriptSetActorScript ; $47bc
	ld a, $b4 ; $47bf
	call DelayFrames ; $47c1
	ld a, $00 ; $47c4
	ld bc, $0c00 ; $47c6
	ld de, $0d40 ; $47c9
	farcall FarPtr_ScriptSetActorPosition ; $47cc
	ld a, $03 ; $47cf
	ld bc, $0e00 ; $47d1
	ld de, $0e40 ; $47d4
	farcall FarPtr_ScriptSetActorPosition ; $47d7
	ld a, $04 ; $47da
	ld bc, $0a00 ; $47dc
	ld de, $0dc0 ; $47df
	farcall FarPtr_ScriptSetActorPosition ; $47e2
	call ReplacePlayerWithStandInActor ; $47e5
	ld a, $16 ; $47e8
	ld bc, $0c00 ; $47ea
	ld de, $0d40 ; $47ed
	farcall FarPtr_ScriptSetActorPosition ; $47f0
	script_face $16, $40 ; $47f3
	script_face $03, $40 ; $47fa
	script_face $04, $40 ; $4801
	script_player_speed $0006 ; $4808
	script_move_player $0c00, $1300 ; $480e
	farcall FarPtr_WaitPlayerMoveDone ; $4818
	call Func_0f_5ccf ; $481b
	script_move_target $0c, $0e00, $1300 ; $481e
	script_wait_move $0c ; $4829
	script_face $0c, $c0 ; $482e
	script_set_speed $0f, $0010 ; $4835
	script_set_speed $10, $0010 ; $483d
	script_move_target $10, $1100, $1600 ; $4845
	script_wait_move $10 ; $4850
	script_face $10, $40 ; $4855
	ld a, $14 ; $485c
	call DelayFrames ; $485e
	ld a, $0f ; $4861
	ld bc, $1180 ; $4863
	ld de, $1600 ; $4866
	farcall FarPtr_ScriptSetActorPosition ; $4869
	ld a, $14 ; $486c
	call DelayFrames ; $486e
	call Func_0f_5e4a ; $4871
	ld d, $5c ; $4874
	ld a, $11 ; $4876
	farcall FarPtr_GetActorStateAddr ; $4878
	ld c, l ; $487b
	ld b, h ; $487c
	farcall FarPtr_04_2c ; $487d
	script_set_anim $11, $01 ; $4880
	ld a, $03 ; $4887
	ld bc, $3f00 ; $4889
	ld de, $3f00 ; $488c
	farcall FarPtr_ScriptSetActorPosition ; $488f
	ld a, $11 ; $4892
	ld bc, $0e00 ; $4894
	ld de, $0e40 ; $4897
	farcall FarPtr_ScriptSetActorPosition ; $489a
	script_face $11, $40 ; $489d
	script_set_speed $0c, $0010 ; $48a4
	script_set_speed $0f, $0010 ; $48ac
	script_move_target $0c, $0e00, $1100 ; $48b4
	script_move_target $0f, $0e00, $1000 ; $48bf
	script_wait_move $0f ; $48ca
	ld a, $1e ; $48cf
	call DelayFrames ; $48d1
	script_speak $0c ; $48d4
	ld a, $1e ; $48d9
	call DelayFrames ; $48db
	script_move_target $0c, $0e00, $1040 ; $48de
	script_move_target $0f, $0e00, $0f40 ; $48e9
	script_wait_move $0f ; $48f4
	ld a, $05 ; $48f9
	call DelayFrames ; $48fb
	ld a, $0c ; $48fe
	ld b, $01 ; $4900
	farcall FarPtr_ScriptSetActorFacingLock ; $4902
	script_move_target $0c, $0e00, $1100 ; $4905
	script_wait_move $0c ; $4910
	ld a, $0c ; $4915
	ld b, $00 ; $4917
	farcall FarPtr_ScriptSetActorFacingLock ; $4919
	script_face $0c, $c0 ; $491c
	ld a, $14 ; $4923
	call DelayFrames ; $4925
	ld a, $0f ; $4928
	ld bc, $3f00 ; $492a
	ld de, $3f00 ; $492d
	farcall FarPtr_ScriptSetActorPosition ; $4930
	script_set_anim $11, $02 ; $4933
	script_wait_idle $11 ; $493a
	script_speak $11 ; $493f
	ld a, $15 ; $4944
	ld bc, $0f80 ; $4946
	ld de, $0f80 ; $4949
	farcall FarPtr_ScriptSetActorPosition ; $494c
	sound $98 ; $494f
	ld a, $78 ; $4951
	call DelayFrames ; $4953
	ld a, $15 ; $4956
	ld bc, $3f00 ; $4958
	ld de, $3f00 ; $495b
	farcall FarPtr_ScriptSetActorPosition ; $495e
	script_set_anim $11, $04 ; $4961
	script_wait_idle $11 ; $4968
	script_speak $11 ; $496d
	ld a, $16 ; $4972
	farcall FarPtr_GetActorStateAddr ; $4974
	ld a, $01 ; $4977
	ld e, l ; $4979
	ld d, h ; $497a
	ld hl, $0018 ; $497b
	add hl, de ; $497e
	ld [hl], a ; $497f
	ld a, $0c ; $4980
	farcall FarPtr_GetActorStateAddr ; $4982
	ld a, $01 ; $4985
	ld e, l ; $4987
	ld d, h ; $4988
	ld hl, $0018 ; $4989
	add hl, de ; $498c
	ld [hl], a ; $498d
	script_set_anim $16, $02 ; $498e
	script_wait_idle $16 ; $4995
	script_set_anim $0c, $03 ; $499a
	script_wait_idle $0c ; $49a1
	script_speak $0c ; $49a6
	ld a, $1e ; $49ab
	call DelayFrames ; $49ad
	script_move_target $0c, $0e00, $1300 ; $49b0
	script_wait_move $0c ; $49bb
	script_move_target $0c, $0a00, $1300 ; $49c0
	script_wait_move $0c ; $49cb
	script_face $0c, $c0 ; $49d0
	ld a, $14 ; $49d7
	call DelayFrames ; $49d9
	script_set_speed $0e, $0010 ; $49dc
	script_set_speed $10, $0010 ; $49e4
	script_move_target $10, $1000, $1600 ; $49ec
	script_wait_move $10 ; $49f7
	script_face $10, $40 ; $49fc
	ld a, $14 ; $4a03
	call DelayFrames ; $4a05
	ld a, $0e ; $4a08
	ld bc, $1080 ; $4a0a
	ld de, $1600 ; $4a0d
	farcall FarPtr_ScriptSetActorPosition ; $4a10
	ld a, $14 ; $4a13
	call DelayFrames ; $4a15
	ld d, $74 ; $4a18
	ld a, $10 ; $4a1a
	farcall FarPtr_GetActorStateAddr ; $4a1c
	ld c, l ; $4a1f
	ld b, h ; $4a20
	farcall FarPtr_04_2c ; $4a21
	script_set_anim $10, $01 ; $4a24
	ld d, $25 ; $4a2b
	ld a, $0e ; $4a2d
	farcall FarPtr_GetActorStateAddr ; $4a2f
	ld c, l ; $4a32
	ld b, h ; $4a33
	farcall FarPtr_04_2c ; $4a34
	script_set_anim $0e, $01 ; $4a37
	ld a, $0e ; $4a3e
	ld bc, $1000 ; $4a40
	ld de, $1600 ; $4a43
	farcall FarPtr_ScriptSetActorPosition ; $4a46
	ld a, $10 ; $4a49
	ld bc, $1000 ; $4a4b
	ld de, $1500 ; $4a4e
	farcall FarPtr_ScriptSetActorPosition ; $4a51
	script_face $0e, $c0 ; $4a54
	script_set_anim $10, $08 ; $4a5b
	script_move_target $10, $1000, $1200 ; $4a62
	script_move_target $0e, $1000, $1300 ; $4a6d
	script_wait_move $0e ; $4a78
	ld d, $25 ; $4a7d
	ld a, $10 ; $4a7f
	farcall FarPtr_GetActorStateAddr ; $4a81
	ld c, l ; $4a84
	ld b, h ; $4a85
	farcall FarPtr_04_2c ; $4a86
	script_set_anim $10, $01 ; $4a89
	ld d, $74 ; $4a90
	ld a, $0e ; $4a92
	farcall FarPtr_GetActorStateAddr ; $4a94
	ld c, l ; $4a97
	ld b, h ; $4a98
	farcall FarPtr_04_2c ; $4a99
	script_set_anim $0e, $01 ; $4a9c
	ld a, $10 ; $4aa3
	ld bc, $1000 ; $4aa5
	ld de, $1300 ; $4aa8
	farcall FarPtr_ScriptSetActorPosition ; $4aab
	ld a, $0e ; $4aae
	ld bc, $0f00 ; $4ab0
	ld de, $1300 ; $4ab3
	farcall FarPtr_ScriptSetActorPosition ; $4ab6
	script_face $10, $80 ; $4ab9
	script_set_anim $0e, $08 ; $4ac0
	script_move_target $10, $0c00, $1300 ; $4ac7
	script_move_target $0e, $0b00, $1300 ; $4ad2
	script_wait_move $0e ; $4add
	ld a, $10 ; $4ae2
	ld b, $01 ; $4ae4
	farcall FarPtr_ScriptSetActorFacingLock ; $4ae6
	script_move_target $10, $0e00, $1300 ; $4ae9
	script_wait_move $10 ; $4af4
	ld a, $10 ; $4af9
	ld b, $00 ; $4afb
	farcall FarPtr_ScriptSetActorFacingLock ; $4afd
	script_set_speed $10, $0020 ; $4b00
	script_move_target $10, $1000, $1600 ; $4b08
	script_wait_move $10 ; $4b13
	script_face $10, $c0 ; $4b18
	ld d, $61 ; $4b1f
	ld a, $12 ; $4b21
	farcall FarPtr_GetActorStateAddr ; $4b23
	ld c, l ; $4b26
	ld b, h ; $4b27
	farcall FarPtr_04_2c ; $4b28
	script_set_anim $12, $01 ; $4b2b
	ld a, $04 ; $4b32
	ld bc, $3f00 ; $4b34
	ld de, $3f00 ; $4b37
	farcall FarPtr_ScriptSetActorPosition ; $4b3a
	ld a, $12 ; $4b3d
	ld bc, $0a00 ; $4b3f
	ld de, $0dc0 ; $4b42
	farcall FarPtr_ScriptSetActorPosition ; $4b45
	script_face $12, $40 ; $4b48
	script_set_speed $0c, $0010 ; $4b4f
	script_set_speed $0e, $0010 ; $4b57
	script_move_target $0c, $0a00, $1100 ; $4b5f
	script_move_target $0e, $0a00, $1000 ; $4b6a
	script_wait_move $0e ; $4b75
	ld a, $1e ; $4b7a
	call DelayFrames ; $4b7c
	script_speak $0c ; $4b7f
	ld a, $1e ; $4b84
	call DelayFrames ; $4b86
	script_move_target $0c, $0a00, $0fc0 ; $4b89
	script_move_target $0e, $0a00, $0ec0 ; $4b94
	script_wait_move $0e ; $4b9f
	ld a, $05 ; $4ba4
	call DelayFrames ; $4ba6
	script_set_anim $12, $02 ; $4ba9
	script_wait_idle $12 ; $4bb0
	ld a, $0c ; $4bb5
	ld b, $01 ; $4bb7
	farcall FarPtr_ScriptSetActorFacingLock ; $4bb9
	script_move_target $0c, $0a00, $1100 ; $4bbc
	script_wait_move $0c ; $4bc7
	ld a, $0c ; $4bcc
	ld b, $00 ; $4bce
	farcall FarPtr_ScriptSetActorFacingLock ; $4bd0
	script_face $0c, $c0 ; $4bd3
	ld a, $14 ; $4bda
	call DelayFrames ; $4bdc
	ld a, $0e ; $4bdf
	ld bc, $3f00 ; $4be1
	ld de, $3f00 ; $4be4
	farcall FarPtr_ScriptSetActorPosition ; $4be7
	ld a, $13 ; $4bea
	ld bc, $0b80 ; $4bec
	ld de, $0c40 ; $4bef
	farcall FarPtr_ScriptSetActorPosition ; $4bf2
	sound $99 ; $4bf5
	script_speak $12 ; $4bf7
	ld a, $13 ; $4bfc
	ld bc, $3f00 ; $4bfe
	ld de, $3f00 ; $4c01
	farcall FarPtr_ScriptSetActorPosition ; $4c04
	ld a, $15 ; $4c07
	ld bc, $0b80 ; $4c09
	ld de, $0f80 ; $4c0c
	farcall FarPtr_ScriptSetActorPosition ; $4c0f
	sound $98 ; $4c12
	ld a, $78 ; $4c14
	call DelayFrames ; $4c16
	ld a, $15 ; $4c19
	ld bc, $3f00 ; $4c1b
	ld de, $3f00 ; $4c1e
	farcall FarPtr_ScriptSetActorPosition ; $4c21
	script_set_anim $12, $04 ; $4c24
	script_wait_idle $12 ; $4c2b
	script_speak $12 ; $4c30
	script_set_anim $0c, $03 ; $4c35
	script_wait_idle $0c ; $4c3c
	script_speak $0c ; $4c41
	ld a, $1e ; $4c46
	call DelayFrames ; $4c48
	script_move_target $0c, $0a00, $1300 ; $4c4b
	script_wait_move $0c ; $4c56
	script_move_target $0c, $0c00, $1300 ; $4c5b
	script_wait_move $0c ; $4c66
	script_face $0c, $c0 ; $4c6b
	script_set_speed $0d, $0010 ; $4c72
	script_set_speed $10, $0010 ; $4c7a
	script_move_target $10, $0f00, $1600 ; $4c82
	script_wait_move $10 ; $4c8d
	script_face $10, $40 ; $4c92
	ld a, $14 ; $4c99
	call DelayFrames ; $4c9b
	ld a, $0d ; $4c9e
	ld bc, $0f80 ; $4ca0
	ld de, $1600 ; $4ca3
	farcall FarPtr_ScriptSetActorPosition ; $4ca6
	ld a, $14 ; $4ca9
	call DelayFrames ; $4cab
	ld d, $74 ; $4cae
	ld a, $10 ; $4cb0
	farcall FarPtr_GetActorStateAddr ; $4cb2
	ld c, l ; $4cb5
	ld b, h ; $4cb6
	farcall FarPtr_04_2c ; $4cb7
	script_set_anim $10, $01 ; $4cba
	ld d, $25 ; $4cc1
	ld a, $0d ; $4cc3
	farcall FarPtr_GetActorStateAddr ; $4cc5
	ld c, l ; $4cc8
	ld b, h ; $4cc9
	farcall FarPtr_04_2c ; $4cca
	script_set_anim $0d, $01 ; $4ccd
	ld a, $0d ; $4cd4
	ld bc, $0f00 ; $4cd6
	ld de, $1600 ; $4cd9
	farcall FarPtr_ScriptSetActorPosition ; $4cdc
	ld a, $10 ; $4cdf
	ld bc, $0f00 ; $4ce1
	ld de, $1500 ; $4ce4
	farcall FarPtr_ScriptSetActorPosition ; $4ce7
	script_face $0d, $c0 ; $4cea
	script_set_anim $10, $06 ; $4cf1
	script_move_target $10, $0f00, $1200 ; $4cf8
	script_move_target $0d, $0f00, $1300 ; $4d03
	script_wait_move $0d ; $4d0e
	ld d, $25 ; $4d13
	ld a, $10 ; $4d15
	farcall FarPtr_GetActorStateAddr ; $4d17
	ld c, l ; $4d1a
	ld b, h ; $4d1b
	farcall FarPtr_04_2c ; $4d1c
	script_set_anim $10, $01 ; $4d1f
	ld d, $74 ; $4d26
	ld a, $0d ; $4d28
	farcall FarPtr_GetActorStateAddr ; $4d2a
	ld c, l ; $4d2d
	ld b, h ; $4d2e
	farcall FarPtr_04_2c ; $4d2f
	script_set_anim $0d, $01 ; $4d32
	ld a, $10 ; $4d39
	ld bc, $0f00 ; $4d3b
	ld de, $1300 ; $4d3e
	farcall FarPtr_ScriptSetActorPosition ; $4d41
	ld a, $0d ; $4d44
	ld bc, $0e00 ; $4d46
	ld de, $1300 ; $4d49
	farcall FarPtr_ScriptSetActorPosition ; $4d4c
	script_face $10, $80 ; $4d4f
	script_set_anim $0d, $06 ; $4d56
	script_move_target $10, $0e00, $1300 ; $4d5d
	script_move_target $0d, $0d00, $1300 ; $4d68
	script_wait_move $0d ; $4d73
	ld a, $10 ; $4d78
	ld b, $01 ; $4d7a
	farcall FarPtr_ScriptSetActorFacingLock ; $4d7c
	script_move_target $10, $0f00, $1300 ; $4d7f
	script_wait_move $10 ; $4d8a
	ld a, $10 ; $4d8f
	ld b, $00 ; $4d91
	farcall FarPtr_ScriptSetActorFacingLock ; $4d93
	script_set_speed $10, $0020 ; $4d96
	script_move_target $10, $0f00, $1600 ; $4d9e
	script_wait_move $10 ; $4da9
	script_face $10, $c0 ; $4dae
	script_move_target $0c, $0c00, $1100 ; $4db5
	script_move_target $0d, $0c00, $1000 ; $4dc0
	script_wait_move $0d ; $4dcb
	script_speak $0c ; $4dd0
	ld a, $14 ; $4dd5
	call DelayFrames ; $4dd7
	script_move_target $0c, $0c00, $0f80 ; $4dda
	script_move_target $0d, $0c00, $0e40 ; $4de5
	script_wait_move $0d ; $4df0
	ld a, $0c ; $4df5
	ld b, $01 ; $4df7
	farcall FarPtr_ScriptSetActorFacingLock ; $4df9
	script_move_target $0c, $0c00, $1100 ; $4dfc
	script_wait_move $0c ; $4e07
	ld a, $0c ; $4e0c
	ld b, $00 ; $4e0e
	farcall FarPtr_ScriptSetActorFacingLock ; $4e10
	script_face $0c, $c0 ; $4e13
	script_set_anim $0b, $02 ; $4e1a
	script_wait_idle $0b ; $4e21
	script_speak $16 ; $4e26
	script_face $11, $80 ; $4e2b
	script_face $12, $00 ; $4e32
	ld a, $3c ; $4e39
	call DelayFrames ; $4e3b
	ld a, [$c90d] ; $4e3e
	ld d, $26 ; $4e41
	add a, d ; $4e43
	ld d, a ; $4e44
	ld a, $16 ; $4e45
	farcall FarPtr_GetActorStateAddr ; $4e47
	ld c, l ; $4e4a
	ld b, h ; $4e4b
	farcall FarPtr_04_2c ; $4e4c
	script_set_anim $16, $01 ; $4e4f
	script_face $16, $00 ; $4e56
	script_set_anim $16, $08 ; $4e5d
	ld a, $0d ; $4e64
	ld bc, $0b40 ; $4e66
	ld de, $0c40 ; $4e69
	farcall FarPtr_ScriptSetActorPosition ; $4e6c
	script_move_player $0c00, $0d00 ; $4e6f
	farcall FarPtr_WaitPlayerMoveDone ; $4e79
	ld a, $b4 ; $4e7c
	call DelayFrames ; $4e7e
	ld c, $01 ; $4e81
	call BeginFadeOut ; $4e83
	call WaitFadeEnd ; $4e86
	ld b, $01 ; $4e89
	ld a, [$c90d] ; $4e8b
	add a, $04 ; $4e8e
	ld c, a ; $4e90
	farcall FarPtr_18_8e ; $4e91
	ld a, $06 ; $4e94
	ld [wStoryModeCurrentLocation], a ; $4e96
	ld a, $0f ; $4e99
	ld [wStoryModeEntryPoint], a ; $4e9b
	ld a, $ff ; $4e9e
	ld [$c294], a ; $4ea0
	ld [wStoryModeExitLocationRequest], a ; $4ea3
	ret ; $4ea6
Label_0f_4ea7:
	ld a, $02 ; $4ea7
	farcall FarPtr_SetActorNullScript ; $4ea9
	script_move_target $00, $0c00, $1900 ; $4eac
	script_move_target $02, $0c00, $1b00 ; $4eb7
	script_wait_move $02 ; $4ec2
	ld a, $0a ; $4ec7
	call DelayFrames ; $4ec9
	ld a, $0b ; $4ecc
	ld b, a ; $4ece
	ld a, $00 ; $4ecf
	farcall FarPtr_FaceActorTowardActor ; $4ed1
	script_face $02, $c0 ; $4ed4
	ld a, $3c ; $4edb
	call DelayFrames ; $4edd
	call AnnounceWinnersToPodiums ; $4ee0
	script_face $00, $40 ; $4ee3
	ld a, $05 ; $4eea
	farcall FarPtr_GetActorStateAddr ; $4eec
	ld c, l ; $4eef
	ld b, h ; $4ef0
	ld a, $04 ; $4ef1
	farcall FarPtr_GetActorStateAddr ; $4ef3
	ld e, l ; $4ef6
	ld d, h ; $4ef7
	farcall FarPtr_04_20 ; $4ef8
	script_move_target $04, $0c00, $1d00 ; $4efb
	script_wait_move $04 ; $4f06
	ld a, $0a ; $4f0b
	call DelayFrames ; $4f0d
	ld a, $05 ; $4f10
	farcall FarPtr_SetActorNullScript ; $4f12
	call Func_0f_5c96 ; $4f15
	script_face $03, $c0 ; $4f18
	script_set_speed $00, $0020 ; $4f1f
	script_set_speed $02, $0020 ; $4f27
	script_set_speed $04, $0020 ; $4f2f
	script_set_speed $05, $0020 ; $4f37
	ldh a, [hRomBank] ; $4f3f
	ld b, a ; $4f41
	ld a, $00 ; $4f42
	ld de, $5665 ; $4f44
	farcall FarPtr_ScriptSetActorScript ; $4f47
	ldh a, [hRomBank] ; $4f4a
	ld b, a ; $4f4c
	ld a, $02 ; $4f4d
	ld de, $5665 ; $4f4f
	farcall FarPtr_ScriptSetActorScript ; $4f52
	ldh a, [hRomBank] ; $4f55
	ld b, a ; $4f57
	ld a, $04 ; $4f58
	ld de, $5665 ; $4f5a
	farcall FarPtr_ScriptSetActorScript ; $4f5d
	ldh a, [hRomBank] ; $4f60
	ld b, a ; $4f62
	ld a, $05 ; $4f63
	ld de, $5665 ; $4f65
	farcall FarPtr_ScriptSetActorScript ; $4f68
	ld a, $b4 ; $4f6b
	call DelayFrames ; $4f6d
	call ReplacePlayerWithStandInActor ; $4f70
	ld a, $16 ; $4f73
	ld bc, $0d00 ; $4f75
	ld de, $0d60 ; $4f78
	farcall FarPtr_ScriptSetActorPosition ; $4f7b
	ld a, [$c94d] ; $4f7e
	ld d, $58 ; $4f81
	add a, d ; $4f83
	ld d, a ; $4f84
	ld a, $11 ; $4f85
	farcall FarPtr_GetActorStateAddr ; $4f87
	ld c, l ; $4f8a
	ld b, h ; $4f8b
	farcall FarPtr_04_2c ; $4f8c
	script_set_anim $11, $01 ; $4f8f
	ld a, $02 ; $4f96
	ld bc, $3f00 ; $4f98
	ld de, $3f00 ; $4f9b
	farcall FarPtr_ScriptSetActorPosition ; $4f9e
	ld a, $11 ; $4fa1
	ld bc, $0f00 ; $4fa3
	ld de, $0d60 ; $4fa6
	farcall FarPtr_ScriptSetActorPosition ; $4fa9
	ld d, $61 ; $4fac
	ld a, $13 ; $4fae
	farcall FarPtr_GetActorStateAddr ; $4fb0
	ld c, l ; $4fb3
	ld b, h ; $4fb4
	farcall FarPtr_04_2c ; $4fb5
	script_set_anim $13, $01 ; $4fb8
	ld d, $62 ; $4fbf
	ld a, $15 ; $4fc1
	farcall FarPtr_GetActorStateAddr ; $4fc3
	ld c, l ; $4fc6
	ld b, h ; $4fc7
	farcall FarPtr_04_2c ; $4fc8
	script_set_anim $15, $01 ; $4fcb
	ld a, $04 ; $4fd2
	ld bc, $3f00 ; $4fd4
	ld de, $3f00 ; $4fd7
	farcall FarPtr_ScriptSetActorPosition ; $4fda
	ld a, $05 ; $4fdd
	ld bc, $3f00 ; $4fdf
	ld de, $3f00 ; $4fe2
	farcall FarPtr_ScriptSetActorPosition ; $4fe5
	ld a, $13 ; $4fe8
	ld bc, $0b00 ; $4fea
	ld de, $0e00 ; $4fed
	farcall FarPtr_ScriptSetActorPosition ; $4ff0
	ld a, $15 ; $4ff3
	ld bc, $0900 ; $4ff5
	ld de, $0e00 ; $4ff8
	farcall FarPtr_ScriptSetActorPosition ; $4ffb
	ld d, $4e ; $4ffe
	ld a, $04 ; $5000
	farcall FarPtr_GetActorStateAddr ; $5002
	ld c, l ; $5005
	ld b, h ; $5006
	farcall FarPtr_04_2c ; $5007
	script_set_anim $04, $01 ; $500a
	ld d, $4d ; $5011
	ld a, $05 ; $5013
	farcall FarPtr_GetActorStateAddr ; $5015
	ld c, l ; $5018
	ld b, h ; $5019
	farcall FarPtr_04_2c ; $501a
	script_set_anim $05, $01 ; $501d
	script_face $16, $40 ; $5024
	script_face $11, $40 ; $502b
	script_face $13, $40 ; $5032
	script_face $15, $40 ; $5039
	script_player_speed $0006 ; $5040
	script_move_player $0c00, $1300 ; $5046
	farcall FarPtr_WaitPlayerMoveDone ; $5050
	call Func_0f_5ccf ; $5053
	script_move_target $0c, $0a00, $1300 ; $5056
	script_wait_move $0c ; $5061
	script_face $0c, $c0 ; $5066
	script_set_speed $10, $0010 ; $506d
	script_set_speed $09, $0010 ; $5075
	script_set_speed $0f, $0010 ; $507d
	script_move_target $10, $1100, $1600 ; $5085
	script_wait_move $10 ; $5090
	script_face $10, $40 ; $5095
	ld a, $14 ; $509c
	call DelayFrames ; $509e
	ld a, $0e ; $50a1
	ld bc, $3f00 ; $50a3
	ld de, $3f00 ; $50a6
	farcall FarPtr_ScriptSetActorPosition ; $50a9
	ld a, $0f ; $50ac
	ld bc, $1100 ; $50ae
	ld de, $1600 ; $50b1
	farcall FarPtr_ScriptSetActorPosition ; $50b4
	ld a, $14 ; $50b7
	call DelayFrames ; $50b9
	ld d, $25 ; $50bc
	ld a, $09 ; $50be
	farcall FarPtr_GetActorStateAddr ; $50c0
	ld c, l ; $50c3
	ld b, h ; $50c4
	farcall FarPtr_04_2c ; $50c5
	script_set_anim $09, $01 ; $50c8
	ld a, $10 ; $50cf
	ld bc, $3f00 ; $50d1
	ld de, $3f00 ; $50d4
	farcall FarPtr_ScriptSetActorPosition ; $50d7
	ld a, $09 ; $50da
	ld bc, $1100 ; $50dc
	ld de, $1600 ; $50df
	farcall FarPtr_ScriptSetActorPosition ; $50e2
	ld a, $0f ; $50e5
	ld bc, $1100 ; $50e7
	ld de, $1500 ; $50ea
	farcall FarPtr_ScriptSetActorPosition ; $50ed
	script_face $09, $c0 ; $50f0
	script_set_anim $0f, $08 ; $50f7
	script_move_target $0f, $1100, $1200 ; $50fe
	script_move_target $09, $1100, $1300 ; $5109
	script_wait_move $09 ; $5114
	ld a, $09 ; $5119
	ld bc, $3f00 ; $511b
	ld de, $3f00 ; $511e
	farcall FarPtr_ScriptSetActorPosition ; $5121
	ld a, $10 ; $5124
	ld bc, $1100 ; $5126
	ld de, $1300 ; $5129
	farcall FarPtr_ScriptSetActorPosition ; $512c
	ld a, $0f ; $512f
	ld bc, $1000 ; $5131
	ld de, $1300 ; $5134
	farcall FarPtr_ScriptSetActorPosition ; $5137
	script_face $10, $80 ; $513a
	script_move_target $10, $0c00, $1300 ; $5141
	script_move_target $0f, $0b00, $1300 ; $514c
	script_wait_move $0f ; $5157
	ld a, $10 ; $515c
	ld b, $01 ; $515e
	farcall FarPtr_ScriptSetActorFacingLock ; $5160
	script_move_target $10, $0f00, $1300 ; $5163
	script_wait_move $10 ; $516e
	ld a, $10 ; $5173
	ld b, $00 ; $5175
	farcall FarPtr_ScriptSetActorFacingLock ; $5177
	script_move_target $10, $1100, $1600 ; $517a
	script_wait_move $10 ; $5185
	script_face $10, $c0 ; $518a
	script_set_text $28b9 ; $5191
	script_set_speed $0c, $0010 ; $5197
	script_move_target $0c, $0a00, $1100 ; $519f
	script_move_target $0f, $0a00, $1000 ; $51aa
	script_wait_move $0f ; $51b5
	ld a, $1e ; $51ba
	call DelayFrames ; $51bc
	script_speak $0c ; $51bf
	ld a, $1e ; $51c4
	call DelayFrames ; $51c6
	script_move_target $0c, $0a00, $1000 ; $51c9
	script_move_target $0f, $0a00, $0f00 ; $51d4
	script_wait_move $0f ; $51df
	ld a, $05 ; $51e4
	call DelayFrames ; $51e6
	script_set_anim $13, $02 ; $51e9
	script_wait_idle $13 ; $51f0
	ld a, $0c ; $51f5
	ld b, $01 ; $51f7
	farcall FarPtr_ScriptSetActorFacingLock ; $51f9
	script_move_target $0c, $0a00, $1100 ; $51fc
	script_wait_move $0c ; $5207
	ld a, $0c ; $520c
	ld b, $00 ; $520e
	farcall FarPtr_ScriptSetActorFacingLock ; $5210
	script_face $0c, $c0 ; $5213
	ld a, $32 ; $521a
	call DelayFrames ; $521c
	ld a, $0f ; $521f
	ld bc, $3f00 ; $5221
	ld de, $3f00 ; $5224
	farcall FarPtr_ScriptSetActorPosition ; $5227
	ld a, $04 ; $522a
	ld bc, $0c80 ; $522c
	ld de, $0c80 ; $522f
	farcall FarPtr_ScriptSetActorPosition ; $5232
	sound $99 ; $5235
	ld a, $50 ; $5237
	call DelayFrames ; $5239
	ld a, $04 ; $523c
	ld bc, $3f00 ; $523e
	ld de, $3f00 ; $5241
	farcall FarPtr_ScriptSetActorPosition ; $5244
	script_speak $13 ; $5247
	script_set_anim $15, $02 ; $524c
	script_wait_idle $15 ; $5253
	script_speak $15 ; $5258
	ld a, $05 ; $525d
	ld bc, $0b80 ; $525f
	ld de, $0f80 ; $5262
	farcall FarPtr_ScriptSetActorPosition ; $5265
	sound $98 ; $5268
	ld a, $78 ; $526a
	call DelayFrames ; $526c
	ld a, $05 ; $526f
	ld bc, $3f00 ; $5271
	ld de, $3f00 ; $5274
	farcall FarPtr_ScriptSetActorPosition ; $5277
	script_set_anim $13, $04 ; $527a
	script_wait_idle $13 ; $5281
	script_speak $13 ; $5286
	script_set_anim $16, $02 ; $528b
	script_set_anim $11, $02 ; $5292
	script_wait_idle $11 ; $5299
	script_face $16, $80 ; $529e
	script_face $11, $80 ; $52a5
	ld a, $3c ; $52ac
	call DelayFrames ; $52ae
	script_face $16, $40 ; $52b1
	script_face $11, $40 ; $52b8
	script_set_anim $15, $02 ; $52bf
	script_wait_idle $15 ; $52c6
	script_speak $15 ; $52cb
	script_set_anim $0c, $03 ; $52d0
	script_wait_idle $0c ; $52d7
	script_speak $0c ; $52dc
	ld a, $1e ; $52e1
	call DelayFrames ; $52e3
	script_move_target $0c, $0a00, $1300 ; $52e6
	script_wait_move $0c ; $52f1
	script_move_target $0c, $0e00, $1300 ; $52f6
	script_wait_move $0c ; $5301
	script_face $0c, $c0 ; $5306
	ld a, $14 ; $530d
	call DelayFrames ; $530f
	script_set_speed $0d, $0010 ; $5312
	script_move_target $10, $0f00, $1600 ; $531a
	script_wait_move $10 ; $5325
	script_face $10, $40 ; $532a
	ld a, $14 ; $5331
	call DelayFrames ; $5333
	ld a, $0d ; $5336
	ld bc, $0f80 ; $5338
	ld de, $1600 ; $533b
	farcall FarPtr_ScriptSetActorPosition ; $533e
	ld a, $14 ; $5341
	call DelayFrames ; $5343
	ld a, $10 ; $5346
	ld bc, $3f00 ; $5348
	ld de, $3f00 ; $534b
	farcall FarPtr_ScriptSetActorPosition ; $534e
	ld a, $09 ; $5351
	ld bc, $0f00 ; $5353
	ld de, $1600 ; $5356
	farcall FarPtr_ScriptSetActorPosition ; $5359
	ld a, $0d ; $535c
	ld bc, $0f00 ; $535e
	ld de, $1500 ; $5361
	farcall FarPtr_ScriptSetActorPosition ; $5364
	script_face $09, $c0 ; $5367
	script_set_anim $0d, $08 ; $536e
	script_move_target $0d, $0f00, $1300 ; $5375
	script_move_target $09, $0f00, $1400 ; $5380
	script_wait_move $09 ; $538b
	ld a, $09 ; $5390
	ld bc, $3f00 ; $5392
	ld de, $3f00 ; $5395
	farcall FarPtr_ScriptSetActorPosition ; $5398
	ld a, $10 ; $539b
	ld bc, $0f00 ; $539d
	ld de, $1400 ; $53a0
	farcall FarPtr_ScriptSetActorPosition ; $53a3
	script_face $10, $c0 ; $53a6
	ld a, $10 ; $53ad
	ld b, $01 ; $53af
	farcall FarPtr_ScriptSetActorFacingLock ; $53b1
	script_move_target $10, $0f00, $1600 ; $53b4
	script_wait_move $10 ; $53bf
	ld a, $10 ; $53c4
	ld b, $00 ; $53c6
	farcall FarPtr_ScriptSetActorFacingLock ; $53c8
	script_face $10, $c0 ; $53cb
	ld a, $0d ; $53d2
	ld bc, $0ec0 ; $53d4
	ld de, $1300 ; $53d7
	farcall FarPtr_ScriptSetActorPosition ; $53da
	script_move_target $0c, $0f00, $1300 ; $53dd
	script_move_target $0d, $0fc0, $1300 ; $53e8
	script_wait_move $0d ; $53f3
	script_move_target $0c, $0f00, $1100 ; $53f8
	script_move_target $0d, $0fc0, $1100 ; $5403
	script_wait_move $0d ; $540e
	ld a, $1e ; $5413
	call DelayFrames ; $5415
	script_speak $0c ; $5418
	ld a, $0a ; $541d
	call DelayFrames ; $541f
	script_set_anim $11, $03 ; $5422
	script_wait_idle $11 ; $5429
	script_speak $11 ; $542e
	ld a, $14 ; $5433
	call DelayFrames ; $5435
	ld a, $0d ; $5438
	ld bc, $0e40 ; $543a
	ld de, $1100 ; $543d
	farcall FarPtr_ScriptSetActorPosition ; $5440
	script_move_target $0c, $0d00, $1100 ; $5443
	script_move_target $0d, $0c40, $1100 ; $544e
	script_wait_move $0d ; $5459
	ld a, $04 ; $545e
	call DelayFrames ; $5460
	script_face $0c, $c0 ; $5463
	script_move_target $0d, $0d00, $1000 ; $546a
	script_wait_move $0d ; $5475
	ld a, $14 ; $547a
	call DelayFrames ; $547c
	script_speak $0c ; $547f
	ld a, $1e ; $5484
	call DelayFrames ; $5486
	script_move_target $0c, $0d00, $1000 ; $5489
	script_move_target $0d, $0d00, $0e80 ; $5494
	script_wait_move $0d ; $549f
	ld a, $05 ; $54a4
	call DelayFrames ; $54a6
	ld a, $0c ; $54a9
	ld b, $01 ; $54ab
	farcall FarPtr_ScriptSetActorFacingLock ; $54ad
	script_move_target $0c, $0d00, $1100 ; $54b0
	script_wait_move $0c ; $54bb
	ld a, $0c ; $54c0
	ld b, $00 ; $54c2
	farcall FarPtr_ScriptSetActorFacingLock ; $54c4
	script_face $0c, $c0 ; $54c7
	script_set_anim $0b, $02 ; $54ce
	script_wait_idle $0b ; $54d5
	script_speak $16 ; $54da
	script_set_anim $16, $03 ; $54df
	script_set_anim $11, $03 ; $54e6
	script_wait_idle $11 ; $54ed
	script_speak $16 ; $54f2
	script_face $11, $80 ; $54f7
	script_face $13, $00 ; $54fe
	script_face $15, $00 ; $5505
	ld a, $3c ; $550c
	call DelayFrames ; $550e
	ld a, [$c90d] ; $5511
	ld d, $26 ; $5514
	add a, d ; $5516
	ld d, a ; $5517
	ld a, $16 ; $5518
	farcall FarPtr_GetActorStateAddr ; $551a
	ld c, l ; $551d
	ld b, h ; $551e
	farcall FarPtr_04_2c ; $551f
	script_set_anim $16, $01 ; $5522
	script_face $16, $00 ; $5529
	script_set_anim $16, $08 ; $5530
	ld a, $0d ; $5537
	ld bc, $0c40 ; $5539
	ld de, $0c60 ; $553c
	farcall FarPtr_ScriptSetActorPosition ; $553f
	script_move_player $0c00, $0d00 ; $5542
	farcall FarPtr_WaitPlayerMoveDone ; $554c
	ld a, $b4 ; $554f
	call DelayFrames ; $5551
	ld c, $01 ; $5554
	call BeginFadeOut ; $5556
	call WaitFadeEnd ; $5559
	ld b, $01 ; $555c
	ld a, [$c90d] ; $555e
	ld d, a ; $5561
	sla a ; $5562
	ld c, a ; $5564
	ld a, [$c94d] ; $5565
	xor a, d ; $5568
	or a, c ; $5569
	ld c, a ; $556a
	farcall FarPtr_18_8e ; $556b
	ld a, $06 ; $556e
	ld [wStoryModeCurrentLocation], a ; $5570
	ld a, $0f ; $5573
	ld [wStoryModeEntryPoint], a ; $5575
	ld a, $ff ; $5578
	ld [$c294], a ; $557a
	ld [wStoryModeExitLocationRequest], a ; $557d
	ret ; $5580
AwardsCeremonyInitScript_0f:
	test_flag $05, 7 ; $5581
	jr z, Label_0f_55a9 ; $5584
	ldh a, [hRomBank] ; $5586
	ld hl, AwardsCeremonyActorsDoubles_0f ; $5588
	farcall FarPtr_ScriptRespawnLocationActors ; $558b
	ld hl, AwardsCeremonyScriptsDoubles_0f ; $558e
	ld de, $000c ; $5591
	farcall FarPtr_WriteStoryStateWord ; $5594
	ld b, $1a ; $5597
	ld c, $0d ; $5599
	ld d, $08 ; $559b
	ld e, $0d ; $559d
	ld h, $08 ; $559f
	ld l, $03 ; $55a1
	farcall FarPtr_CopySceneTilemapRect ; $55a3
	farcall FarPtr_BeginCutsceneScriptMode ; $55a6
Label_0f_55a9:
	script_set_anim $0e, $08 ; $55a9
	script_set_anim $0f, $08 ; $55b0
	test_flag $05, 7 ; $55b7
	jr nz, Label_0f_55c3 ; $55ba
	script_set_anim $0d, $06 ; $55bc
Label_0f_55c3:
	call SetPlayerAndPartnerObjectDefs ; $55c3
	ld a, [wStoryModeEntryPoint] ; $55c6
	cp a, $0a ; $55c9
	jp z, Label_0f_56a8 ; $55cb
	cp a, $0b ; $55ce
	jp z, Label_0f_5889 ; $55d0
	call Func_0f_5f7a ; $55d3
	and a, $01 ; $55d6
	jr z, Label_0f_5600 ; $55d8
	script_move_target $08, $0900, $1d00 ; $55da
	script_wait_move $08 ; $55e5
	script_face $08, $00 ; $55ea
	ld b, $0a ; $55f1
	ld c, $1c ; $55f3
	ld d, $0a ; $55f5
	ld e, $1a ; $55f7
	ld h, $04 ; $55f9
	ld l, $02 ; $55fb
	farcall FarPtr_CopyBehaviorMapRect ; $55fd
Label_0f_5600:
	test_flag $05, 7 ; $5600
	jp nz, Label_0f_5627 ; $5603
	call SavePlayerActorPosition ; $5606
	ld hl, $c2b2 ; $5609
	ld a, [hl+] ; $560c
	ld b, [hl] ; $560d
	ld c, a ; $560e
	ld hl, wWaterSpriteMinigameTimer ; $560f
	ld a, [hl+] ; $5612
	ld d, [hl] ; $5613
	ld e, a ; $5614
	ld a, $03 ; $5615
	farcall FarPtr_ScriptSetActorPosition ; $5617
	ld a, $03 ; $561a
	farcall FarPtr_GetActorStateAddr ; $561c
	ld c, l ; $561f
	ld b, h ; $5620
	ld de, $d000 ; $5621
	farcall FarPtr_04_20 ; $5624
Label_0f_5627:
	ret ; $5627
Func_0f_5628:
	script_set_text $287d ; $5628
	call Func_0f_5f7a ; $562e
	and a, $01 ; $5631
	jr z, Label_0f_563b ; $5633
	script_set_text $2881 ; $5635
Label_0f_563b:
	script_speak $08 ; $563b
	ret ; $5640
ReplacePlayerWithStandInActor:
	ld a, [$c90d] ; $5641
	ld d, $56 ; $5644
	add a, d ; $5646
	ld d, a ; $5647
	ld a, $16 ; $5648
	farcall FarPtr_GetActorStateAddr ; $564a
	ld c, l ; $564d
	ld b, h ; $564e
	farcall FarPtr_04_2c ; $564f
	script_set_anim $16, $01 ; $5652
	ld a, $00 ; $5659
	ld bc, $3f00 ; $565b
	ld de, $3f00 ; $565e
	farcall FarPtr_ScriptSetActorPosition ; $5661
	ret ; $5664
	INCBIN "data/bank_00f/d_5665.bin" ; $5665, 19 bytes
DelayFrames:
	push af ; $5678
	ld a, a ; $5679
	farcall FarPtr_WaitScriptFrames ; $567a
	pop af ; $567d
	ret ; $567e
CutsceneStompScreenShake:
	ld a, $08 ; $567f
	ld de, $ff80 ; $5681
	farcall FarPtr_ScriptSetActorJumpVelocity ; $5684
	ld a, $08 ; $5687
	farcall FarPtr_ScriptWaitActorJumpDone ; $5689
	sound $83 ; $568c
	ld a, $02 ; $568e
	farcall FarPtr_SetScreenShake ; $5690
	ld a, $08 ; $5693
	call DelayFrames ; $5695
	ld a, $01 ; $5698
	farcall FarPtr_SetScreenShake ; $569a
	ld a, $08 ; $569d
	call DelayFrames ; $569f
	ld a, $00 ; $56a2
	farcall FarPtr_SetScreenShake ; $56a4
	ret ; $56a7
Label_0f_56a8:
	call Func_0f_5b4d ; $56a8
	script_set_anim $03, $02 ; $56ab
	script_wait_idle $03 ; $56b2
	ld a, $00 ; $56b7
	ld b, a ; $56b9
	ld a, $03 ; $56ba
	farcall FarPtr_FaceActorTowardActor ; $56bc
	ld a, $0a ; $56bf
	call DelayFrames ; $56c1
	script_set_text $286b ; $56c4
	script_speak $03 ; $56ca
	script_set_anim $03, $03 ; $56cf
	script_wait_idle $03 ; $56d6
	script_speak $03 ; $56db
	script_set_anim $00, $03 ; $56e0
	script_wait_idle $00 ; $56e7
	ld a, $03 ; $56ec
	ld b, a ; $56ee
	ld a, $04 ; $56ef
	farcall FarPtr_FaceActorTowardActor ; $56f1
	script_set_anim $04, $02 ; $56f4
	script_wait_idle $04 ; $56fb
	script_speak $04 ; $5700
	ld a, $13 ; $5705
	ld bc, $0c80 ; $5707
	ld de, $2580 ; $570a
	farcall FarPtr_ScriptSetActorPosition ; $570d
	sound $99 ; $5710
	ld a, $3c ; $5712
	call DelayFrames ; $5714
	ld a, $13 ; $5717
	ld bc, $3f00 ; $5719
	ld de, $3f00 ; $571c
	farcall FarPtr_ScriptSetActorPosition ; $571f
	script_set_anim $03, $02 ; $5722
	script_wait_idle $03 ; $5729
	ld a, $04 ; $572e
	ld b, a ; $5730
	ld a, $03 ; $5731
	farcall FarPtr_FaceActorTowardActor ; $5733
	script_speak $03 ; $5736
	script_set_anim $04, $02 ; $573b
	script_wait_idle $04 ; $5742
	script_speak $04 ; $5747
	ld a, $1e ; $574c
	call DelayFrames ; $574e
	script_face_pair $00, $03 ; $5751
	ld a, $50 ; $5759
	call DelayFrames ; $575b
	ld a, $04 ; $575e
	ld b, a ; $5760
	ld a, $03 ; $5761
	farcall FarPtr_FaceActorTowardActor ; $5763
	script_face_pair $04, $00 ; $5766
	ld a, $1e ; $576e
	call DelayFrames ; $5770
	script_set_anim $04, $04 ; $5773
	script_wait_idle $04 ; $577a
	script_speak $04 ; $577f
	ld a, $28 ; $5784
	call DelayFrames ; $5786
	script_speak $0b ; $5789
	script_face $03, $c0 ; $578e
	script_face $04, $c0 ; $5795
	ld a, $14 ; $579c
	call DelayFrames ; $579e
	script_player_speed $0018 ; $57a1
	script_move_player $0c00, $1300 ; $57a7
	farcall FarPtr_WaitPlayerMoveDone ; $57b1
	ld a, $1e ; $57b4
	call DelayFrames ; $57b6
	script_set_anim $0b, $02 ; $57b9
	script_wait_idle $0b ; $57c0
	script_speak $0b ; $57c5
	ld a, $28 ; $57ca
	call DelayFrames ; $57cc
	script_move_player $0c00, $2900 ; $57cf
	farcall FarPtr_WaitPlayerMoveDone ; $57d9
	script_face $04, $40 ; $57dc
	script_speak $04 ; $57e3
	script_face $03, $00 ; $57e8
	script_set_anim $04, $02 ; $57ef
	script_wait_idle $04 ; $57f6
	script_speak $04 ; $57fb
	script_set_anim $03, $02 ; $5800
	script_wait_idle $03 ; $5807
	script_face $04, $80 ; $580c
	script_speak $03 ; $5813
	ld a, $13 ; $5818
	ld bc, $0e80 ; $581a
	ld de, $2580 ; $581d
	farcall FarPtr_ScriptSetActorPosition ; $5820
	sound $99 ; $5823
	ld a, $3c ; $5825
	call DelayFrames ; $5827
	ld a, $13 ; $582a
	ld bc, $3f00 ; $582c
	ld de, $3f00 ; $582f
	farcall FarPtr_ScriptSetActorPosition ; $5832
	script_face $04, $c0 ; $5835
	ld a, $28 ; $583c
	call DelayFrames ; $583e
	script_face $03, $40 ; $5841
	script_speak $03 ; $5848
	script_set_anim $03, $02 ; $584d
	script_wait_idle $03 ; $5854
	script_speak $03 ; $5859
	script_set_anim $00, $02 ; $585e
	script_wait_idle $00 ; $5865
	script_speak $03 ; $586a
	script_set_anim $00, $03 ; $586f
	script_wait_idle $00 ; $5876
	ld a, $03 ; $587b
	farcall FarPtr_GetActorStateAddr ; $587d
	ld c, l ; $5880
	ld b, h ; $5881
	ld de, $d000 ; $5882
	farcall FarPtr_04_20 ; $5885
	ret ; $5888
Label_0f_5889:
	ld a, $02 ; $5889
	farcall FarPtr_SetActorNullScript ; $588b
	ld a, $02 ; $588e
	ld bc, $0b00 ; $5890
	ld de, $2700 ; $5893
	farcall FarPtr_ScriptSetActorPosition ; $5896
	script_face $02, $c0 ; $5899
	call Func_0f_5b4d ; $58a0
	script_set_text $2897 ; $58a3
	script_set_anim $02, $02 ; $58a9
	script_wait_idle $02 ; $58b0
	script_face $02, $40 ; $58b5
	call Func_0f_5aec ; $58bc
	script_set_anim $00, $03 ; $58bf
	script_wait_idle $00 ; $58c6
	script_set_anim $02, $03 ; $58cb
	script_wait_idle $02 ; $58d2
	call Func_0f_5aec ; $58d7
	script_set_anim $00, $03 ; $58da
	script_wait_idle $00 ; $58e1
	ld a, $02 ; $58e6
	ld b, a ; $58e8
	ld a, $04 ; $58e9
	farcall FarPtr_FaceActorTowardActor ; $58eb
	ld a, $0a ; $58ee
	call DelayFrames ; $58f0
	script_set_anim $04, $02 ; $58f3
	script_wait_idle $04 ; $58fa
	script_speak $04 ; $58ff
	ld a, $00 ; $5904
	ld b, a ; $5906
	ld a, $05 ; $5907
	farcall FarPtr_FaceActorTowardActor ; $5909
	script_speak $05 ; $590c
	ld a, $15 ; $5911
	ld bc, $0c80 ; $5913
	ld de, $2580 ; $5916
	farcall FarPtr_ScriptSetActorPosition ; $5919
	sound $98 ; $591c
	ld a, $3c ; $591e
	call DelayFrames ; $5920
	ld a, $15 ; $5923
	ld bc, $3f00 ; $5925
	ld de, $3f00 ; $5928
	farcall FarPtr_ScriptSetActorPosition ; $592b
	script_face $02, $00 ; $592e
	script_set_anim $02, $02 ; $5935
	script_wait_idle $02 ; $593c
	call Func_0f_5aec ; $5941
	script_set_anim $04, $02 ; $5944
	script_wait_idle $04 ; $594b
	script_speak $04 ; $5950
	script_set_anim $05, $02 ; $5955
	script_wait_idle $05 ; $595c
	script_speak $05 ; $5961
	ld a, $1e ; $5966
	call DelayFrames ; $5968
	script_face_pair $02, $00 ; $596b
	ld a, $3c ; $5973
	call DelayFrames ; $5975
	script_face $00, $00 ; $5978
	script_face $02, $00 ; $597f
	ld a, $1e ; $5986
	call DelayFrames ; $5988
	script_face $04, $40 ; $598b
	script_set_anim $04, $04 ; $5992
	script_wait_idle $04 ; $5999
	script_speak $04 ; $599e
	ld a, $28 ; $59a3
	call DelayFrames ; $59a5
	script_speak $0b ; $59a8
	script_face $00, $c0 ; $59ad
	script_face $02, $c0 ; $59b4
	script_face $04, $c0 ; $59bb
	script_face $05, $c0 ; $59c2
	ld a, $14 ; $59c9
	call DelayFrames ; $59cb
	script_player_speed $0018 ; $59ce
	script_move_player $0c00, $1300 ; $59d4
	farcall FarPtr_WaitPlayerMoveDone ; $59de
	ld a, $1e ; $59e1
	call DelayFrames ; $59e3
	script_set_anim $0b, $02 ; $59e6
	script_wait_idle $0b ; $59ed
	script_speak $0b ; $59f2
	ld a, $28 ; $59f7
	call DelayFrames ; $59f9
	script_move_player $0c00, $2900 ; $59fc
	farcall FarPtr_WaitPlayerMoveDone ; $5a06
	script_face $04, $80 ; $5a09
	script_speak $04 ; $5a10
	script_face $00, $00 ; $5a15
	script_face $02, $00 ; $5a1c
	script_set_anim $04, $02 ; $5a23
	script_wait_idle $04 ; $5a2a
	script_speak $04 ; $5a2f
	script_face $05, $80 ; $5a34
	script_set_anim $05, $02 ; $5a3b
	script_wait_idle $05 ; $5a42
	script_speak $05 ; $5a47
	script_set_anim $02, $02 ; $5a4c
	script_wait_idle $02 ; $5a53
	call Func_0f_5aec ; $5a58
	ld a, $13 ; $5a5b
	ld bc, $0e80 ; $5a5d
	ld de, $2580 ; $5a60
	farcall FarPtr_ScriptSetActorPosition ; $5a63
	sound $99 ; $5a66
	ld a, $3c ; $5a68
	call DelayFrames ; $5a6a
	ld a, $13 ; $5a6d
	ld bc, $0e80 ; $5a6f
	ld de, $2780 ; $5a72
	farcall FarPtr_ScriptSetActorPosition ; $5a75
	sound $99 ; $5a78
	ld a, $3c ; $5a7a
	call DelayFrames ; $5a7c
	ld a, $13 ; $5a7f
	ld bc, $3f00 ; $5a81
	ld de, $3f00 ; $5a84
	farcall FarPtr_ScriptSetActorPosition ; $5a87
	script_face $04, $c0 ; $5a8a
	script_face $05, $c0 ; $5a91
	ld a, $1e ; $5a98
	call DelayFrames ; $5a9a
	script_face_pair $00, $02 ; $5a9d
	call Func_0f_5aec ; $5aa5
	script_set_anim $02, $02 ; $5aa8
	script_wait_idle $02 ; $5aaf
	call Func_0f_5aec ; $5ab4
	script_set_anim $00, $02 ; $5ab7
	script_wait_idle $00 ; $5abe
	script_set_anim $02, $03 ; $5ac3
	script_wait_idle $02 ; $5aca
	call Func_0f_5aec ; $5acf
	script_set_anim $00, $03 ; $5ad2
	script_wait_idle $00 ; $5ad9
	ld a, $02 ; $5ade
	farcall FarPtr_GetActorStateAddr ; $5ae0
	ld c, l ; $5ae3
	ld b, h ; $5ae4
	ld de, $d000 ; $5ae5
	farcall FarPtr_04_20 ; $5ae8
	ret ; $5aeb
Func_0f_5aec:
	ld a, [$c94d] ; $5aec
	and a, a ; $5aef
	jr nz, Label_0f_5afb ; $5af0
	script_speak $02 ; $5af2
	farcall FarPtr_AdvanceDialogueTextCursor ; $5af7
	ret ; $5afa
Label_0f_5afb:
	farcall FarPtr_AdvanceDialogueTextCursor ; $5afb
	script_speak $02 ; $5afe
	ret ; $5b03
AwardsCeremonyScriptsDoubles_0f:
	; $5b04, 73 bytes (map_scripts)
	map_script $03, $ff, $0000, $28b7, $03, $00
	map_script $04, $ff, $0000, $28a5, $03, $00
	map_script $05, $ff, $0000, $28a6, $03, $00
	map_script $06, $ff, $0000, $28af, $03, $00
	map_script $07, $ff, $0000, $28b1, $03, $00
	map_script $08, $ff, $0000, Func_0f_5628, $03, $00
	map_script $09, $ff, $0000, $2882, $03, $00
	map_script $0a, $ff, $0000, $2883, $03, $00
	map_script $12, $ff, $0000, $28b0, $03, $00
	db $ff
Func_0f_5b4d:
	script_player_speed $00ff ; $5b4d
	script_move_player $0c00, $0b00 ; $5b53
	farcall FarPtr_WaitPlayerMoveDone ; $5b5d
	xor a, a ; $5b60
	ld [wStoryModeShowLocationName], a ; $5b61
	ld c, $04 ; $5b64
	call BeginFadeIn ; $5b66
	call WaitFadeEnd ; $5b69
	ld d, $30 ; $5b6c
	ld a, $13 ; $5b6e
	farcall FarPtr_GetActorStateAddr ; $5b70
	ld c, l ; $5b73
	ld b, h ; $5b74
	farcall FarPtr_04_2c ; $5b75
	script_set_anim $13, $01 ; $5b78
	ld d, $3a ; $5b7f
	ld a, $14 ; $5b81
	farcall FarPtr_GetActorStateAddr ; $5b83
	ld c, l ; $5b86
	ld b, h ; $5b87
	farcall FarPtr_04_2c ; $5b88
	script_set_anim $14, $01 ; $5b8b
	ld a, $13 ; $5b92
	ld bc, $0700 ; $5b94
	ld de, $0100 ; $5b97
	farcall FarPtr_ScriptSetActorPosition ; $5b9a
	ld a, $14 ; $5b9d
	ld bc, $0f00 ; $5b9f
	ld de, $0100 ; $5ba2
	farcall FarPtr_ScriptSetActorPosition ; $5ba5
	script_set_speed $13, $0020 ; $5ba8
	script_move_target $13, $0700, $0500 ; $5bb0
	script_wait_move $13 ; $5bbb
	script_set_anim $13, $04 ; $5bc0
	script_wait_idle $13 ; $5bc7
	ld a, $13 ; $5bcc
	ld de, $ff80 ; $5bce
	farcall FarPtr_ScriptSetActorJumpVelocity ; $5bd1
	ld a, $13 ; $5bd4
	farcall FarPtr_ScriptWaitActorJumpDone ; $5bd6
	script_set_speed $14, $0020 ; $5bd9
	script_move_target $14, $0f00, $0780 ; $5be1
	script_wait_move $14 ; $5bec
	ld a, $13 ; $5bf1
	ld de, $ff80 ; $5bf3
	farcall FarPtr_ScriptSetActorJumpVelocity ; $5bf6
	script_set_anim $14, $02 ; $5bf9
	script_player_speed $0010 ; $5c00
	ld a, $00 ; $5c06
	ld b, $00 ; $5c08
	farcall FarPtr_MovePlayerToActor ; $5c0a
	farcall FarPtr_WaitPlayerMoveDone ; $5c0d
	ld a, $1e ; $5c10
	call DelayFrames ; $5c12
	ld d, $4e ; $5c15
	ld a, $13 ; $5c17
	farcall FarPtr_GetActorStateAddr ; $5c19
	ld c, l ; $5c1c
	ld b, h ; $5c1d
	farcall FarPtr_04_2c ; $5c1e
	script_set_anim $13, $01 ; $5c21
	ld d, $53 ; $5c28
	ld a, $14 ; $5c2a
	farcall FarPtr_GetActorStateAddr ; $5c2c
	ld c, l ; $5c2f
	ld b, h ; $5c30
	farcall FarPtr_04_2c ; $5c31
	script_set_anim $14, $01 ; $5c34
	ld a, $13 ; $5c3b
	ld bc, $3f00 ; $5c3d
	ld de, $3f00 ; $5c40
	farcall FarPtr_ScriptSetActorPosition ; $5c43
	ld a, $14 ; $5c46
	ld bc, $3f00 ; $5c48
	ld de, $3f00 ; $5c4b
	farcall FarPtr_ScriptSetActorPosition ; $5c4e
	ret ; $5c51
AnnounceWinnersToPodiums:
	script_face_pair $0c, $0b ; $5c52
	ld a, $1e ; $5c5a
	call DelayFrames ; $5c5c
	script_set_anim $0b, $03 ; $5c5f
	script_wait_idle $0b ; $5c66
	script_set_anim $0c, $03 ; $5c6b
	script_wait_idle $0c ; $5c72
	ld a, $1e ; $5c77
	call DelayFrames ; $5c79
	script_face $0b, $00 ; $5c7c
	script_face $0c, $00 ; $5c83
	script_set_text $2885 ; $5c8a
	script_speak $0b ; $5c90
	ret ; $5c95
Func_0f_5c96:
	script_face $05, $c0 ; $5c96
	script_face $08, $c0 ; $5c9d
	script_face $09, $c0 ; $5ca4
	script_face $0a, $c0 ; $5cab
	script_face $06, $c0 ; $5cb2
	script_face $12, $c0 ; $5cb9
	script_face $07, $c0 ; $5cc0
	script_face $11, $c0 ; $5cc7
	ret ; $5cce
Func_0f_5ccf:
	ld a, $1e ; $5ccf
	call DelayFrames ; $5cd1
	script_speak $0b ; $5cd4
	script_set_anim $0b, $03 ; $5cd9
	script_wait_idle $0b ; $5ce0
	script_face $0b, $c0 ; $5ce5
	ld a, $1e ; $5cec
	call DelayFrames ; $5cee
	ld a, $0b ; $5cf1
	ld b, $01 ; $5cf3
	farcall FarPtr_ScriptSetActorFacingLock ; $5cf5
	script_move_target $0b, $0700, $1b00 ; $5cf8
	script_wait_move $0b ; $5d03
	ld a, $0b ; $5d08
	ld b, $00 ; $5d0a
	farcall FarPtr_ScriptSetActorFacingLock ; $5d0c
	script_face $0b, $00 ; $5d0f
	script_move_target $0c, $0800, $1900 ; $5d16
	script_wait_move $0c ; $5d21
	script_face $0c, $00 ; $5d26
	ld a, $1e ; $5d2d
	call DelayFrames ; $5d2f
	script_set_anim $0c, $03 ; $5d32
	script_wait_idle $0c ; $5d39
	script_speak $0c ; $5d3e
	script_set_anim $0c, $04 ; $5d43
	script_wait_idle $0c ; $5d4a
	script_speak $0c ; $5d4f
	script_set_anim $0c, $02 ; $5d54
	script_wait_idle $0c ; $5d5b
	script_speak $0c ; $5d60
	script_set_anim $0c, $04 ; $5d65
	script_wait_idle $0c ; $5d6c
	script_speak $0c ; $5d71
	script_set_anim $0c, $03 ; $5d76
	script_wait_idle $0c ; $5d7d
	script_speak $0c ; $5d82
	script_set_anim $0c, $03 ; $5d87
	script_wait_idle $0c ; $5d8e
	ld a, $3c ; $5d93
	call DelayFrames ; $5d95
	script_move_target $0c, $0800, $1700 ; $5d98
	script_wait_move $0c ; $5da3
	script_face $0c, $00 ; $5da8
	script_move_target $0b, $0800, $1900 ; $5daf
	script_wait_move $0b ; $5dba
	script_face $0b, $00 ; $5dbf
	ld a, $1e ; $5dc6
	call DelayFrames ; $5dc8
	script_speak $0b ; $5dcb
	ld d, $30 ; $5dd0
	ld a, $07 ; $5dd2
	farcall FarPtr_GetActorStateAddr ; $5dd4
	ld c, l ; $5dd7
	ld b, h ; $5dd8
	farcall FarPtr_04_2c ; $5dd9
	script_set_anim $07, $01 ; $5ddc
	ld d, $3a ; $5de3
	ld a, $14 ; $5de5
	farcall FarPtr_GetActorStateAddr ; $5de7
	ld c, l ; $5dea
	ld b, h ; $5deb
	farcall FarPtr_04_2c ; $5dec
	script_set_anim $14, $01 ; $5def
	ld a, $07 ; $5df6
	ld bc, $0700 ; $5df8
	ld de, $0500 ; $5dfb
	farcall FarPtr_ScriptSetActorPosition ; $5dfe
	ld a, $14 ; $5e01
	ld bc, $0f00 ; $5e03
	ld de, $0780 ; $5e06
	farcall FarPtr_ScriptSetActorPosition ; $5e09
	script_face $07, $40 ; $5e0c
	script_face $14, $40 ; $5e13
	ld a, $1e ; $5e1a
	call DelayFrames ; $5e1c
	script_move_player $0c00, $1100 ; $5e1f
	script_move_target $0c, $0c00, $1700 ; $5e29
	script_wait_move $0c ; $5e34
	script_move_target $0c, $0c00, $1300 ; $5e39
	script_wait_move $0c ; $5e44
	ret ; $5e49
Func_0f_5e4a:
	ld d, $74 ; $5e4a
	ld a, $10 ; $5e4c
	farcall FarPtr_GetActorStateAddr ; $5e4e
	ld c, l ; $5e51
	ld b, h ; $5e52
	farcall FarPtr_04_2c ; $5e53
	script_set_anim $10, $01 ; $5e56
	ld d, $25 ; $5e5d
	ld a, $0f ; $5e5f
	farcall FarPtr_GetActorStateAddr ; $5e61
	ld c, l ; $5e64
	ld b, h ; $5e65
	farcall FarPtr_04_2c ; $5e66
	script_set_anim $0f, $01 ; $5e69
	ld a, $0f ; $5e70
	ld bc, $1100 ; $5e72
	ld de, $1600 ; $5e75
	farcall FarPtr_ScriptSetActorPosition ; $5e78
	ld a, $10 ; $5e7b
	ld bc, $1100 ; $5e7d
	ld de, $1500 ; $5e80
	farcall FarPtr_ScriptSetActorPosition ; $5e83
	script_face $0f, $c0 ; $5e86
	script_set_anim $10, $08 ; $5e8d
	script_move_target $10, $1100, $1200 ; $5e94
	script_move_target $0f, $1100, $1300 ; $5e9f
	script_wait_move $0f ; $5eaa
	ld d, $25 ; $5eaf
	ld a, $10 ; $5eb1
	farcall FarPtr_GetActorStateAddr ; $5eb3
	ld c, l ; $5eb6
	ld b, h ; $5eb7
	farcall FarPtr_04_2c ; $5eb8
	script_set_anim $10, $01 ; $5ebb
	ld d, $74 ; $5ec2
	ld a, $0f ; $5ec4
	farcall FarPtr_GetActorStateAddr ; $5ec6
	ld c, l ; $5ec9
	ld b, h ; $5eca
	farcall FarPtr_04_2c ; $5ecb
	script_set_anim $0f, $01 ; $5ece
	ld a, $10 ; $5ed5
	ld bc, $1100 ; $5ed7
	ld de, $1300 ; $5eda
	farcall FarPtr_ScriptSetActorPosition ; $5edd
	ld a, $0f ; $5ee0
	ld bc, $1000 ; $5ee2
	ld de, $1300 ; $5ee5
	farcall FarPtr_ScriptSetActorPosition ; $5ee8
	script_face $10, $80 ; $5eeb
	script_set_anim $0f, $08 ; $5ef2
	script_move_target $10, $1000, $1300 ; $5ef9
	script_move_target $0f, $0f00, $1300 ; $5f04
	script_wait_move $0f ; $5f0f
	ld a, $10 ; $5f14
	ld b, $01 ; $5f16
	farcall FarPtr_ScriptSetActorFacingLock ; $5f18
	script_move_target $10, $1100, $1300 ; $5f1b
	script_wait_move $10 ; $5f26
	ld a, $10 ; $5f2b
	ld b, $00 ; $5f2d
	farcall FarPtr_ScriptSetActorFacingLock ; $5f2f
	script_set_speed $10, $0020 ; $5f32
	script_move_target $10, $1100, $1600 ; $5f3a
	script_wait_move $10 ; $5f45
	script_face $10, $c0 ; $5f4a
	ret ; $5f51
SavePlayerActorPosition:
	wram_bank $04 ; $5f52
	ld a, $00 ; $5f58
	farcall FarPtr_GetActorStateAddr ; $5f5a
	ld c, l ; $5f5d
	ld b, h ; $5f5e
	ld hl, $000c ; $5f5f
	add hl, bc ; $5f62
	ld a, [hl+] ; $5f63
	ld d, [hl] ; $5f64
	ld e, a ; $5f65
	ld hl, $c2b2 ; $5f66
	ld a, e ; $5f69
	ld [hl+], a ; $5f6a
	ld [hl], d ; $5f6b
	ld hl, $000e ; $5f6c
	add hl, bc ; $5f6f
	ld a, [hl+] ; $5f70
	ld d, [hl] ; $5f71
	ld e, a ; $5f72
	ld hl, wWaterSpriteMinigameTimer ; $5f73
	ld a, e ; $5f76
	ld [hl+], a ; $5f77
	ld [hl], d ; $5f78
	ret ; $5f79
Func_0f_5f7a:
	test_flag $05, 7 ; $5f7a
	jr z, Label_0f_5f8a ; $5f7d
	ld a, $00 ; $5f7f
	test_flag $10, 4 ; $5f81
	jr z, Label_0f_5f93 ; $5f84
	ld a, $01 ; $5f86
	jr Label_0f_5f93 ; $5f88
Label_0f_5f8a:
	ld a, $00 ; $5f8a
	test_flag $10, 3 ; $5f8c
	jr z, Label_0f_5f93 ; $5f8f
	ld a, $01 ; $5f91
Label_0f_5f93:
	ret ; $5f93
TournamentMapScripts_0f:
	; $5f94, 14 bytes (map_tree)
	dw TournamentEntryPoints_0f ; slot 0 EntryPoints
	dw TournamentExitTriggers_0f ; slot 1 ExitTriggers
	dw TournamentActors_0f ; slot 2 Actors
	dw TournamentNpcScripts_0f ; slot 3 NpcScripts
	dw TournamentFacingScripts_0f ; slot 4 FacingScripts
	dw TournamentTileTriggers_0f ; slot 5 TileTriggers
	dw TournamentInitScript_0f ; slot 6 InitScript
TournamentActors_0f:
	; $5fa2, 206 bytes (map_actors)
	map_actor $0000, $7b57, $2700, $1100, $80, $25, $01, $00
	map_actor $0000, $7b57, $1300, $0f00, $40, $25, $01, $00
	map_actor $0000, $7b57, $0100, $0c00, $00, $25, $01, $00
	map_actor $0000, $7b57, $2300, $1100, $c0, $5c, $01, $00
	map_actor $0000, $7b75, $2300, $1700, $c0, $5b, $01, $00
	map_actor $0000, $7b57, $2100, $1100, $00, $5a, $01, $00
	map_actor $0000, $7b57, $2900, $1700, $80, $5f, $01, $00
	map_actor $0000, $7b57, $1100, $1500, $40, $5d, $01, $00
	map_actor $0000, $7b57, $1900, $1300, $40, $60, $01, $00
	map_actor $0000, $7b57, $1700, $1300, $40, $61, $01, $00
	map_actor $0000, $7b57, $0f00, $1300, $40, $62, $01, $00
	map_actor $0000, $7b57, $1900, $1500, $40, $5e, $01, $00
	map_actor $0000, $7b57, $1700, $1500, $40, $1e, $01, $00
	map_actor $0000, $7b57, $1100, $1300, $40, $1f, $01, $00
	map_actor_end
TournamentEntryPoints_0f:
	; $6070, 65 bytes (map_entries)
	map_entry $01, $40, $0e00, $0900, $0000
	map_entry $02, $40, $2a00, $0900, $0000
	map_entry $03, $00, $0500, $0b00, $0000
	map_entry $04, $80, $3300, $0b00, $0000
	map_entry $05, $c0, $1c00, $2300, $0000
	map_entry $0a, $40, $2500, $1100, $0000
	map_entry $0b, $40, $2300, $1100, $0000
	map_entry $0f, $c0, $1b00, $3100, $0000
	db $ff
TournamentExitTriggers_0f:
	; $60b1, 41 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_0f_60da, $18, $01
	map_script $02, $ff, $0000, Func_0f_60da, $18, $02
	map_script $03, $ff, $0000, Func_0f_60da, $17, $01
	map_script $04, $ff, $0000, Func_0f_60da, $16, $01
	map_script $05, $ff, $0000, Func_0f_60da, $15, $03
	db $ff
Func_0f_60da:
	clear_flag $17, 1 ; $60da
	ret ; $60dd
Func_0f_60de:
	script_set_text $24a3 ; $60de
	ld a, $0b ; $60e4
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $60e6
	farcall FarPtr_RunDialogueYesNoPrompt ; $60e9
	farcall FarPtr_ScriptCloseDialogueWindow ; $60ec
	script_wait_frames $05 ; $60ef
	and a, a ; $60f6
	jr z, Label_0f_60fc ; $60f7
	farcall FarPtr_AdvanceDialogueTextCursor ; $60f9
Label_0f_60fc:
	script_speak $0b ; $60fc
	ret ; $6101
TournamentNpcScripts_0f:
	; $6102, 105 bytes (map_scripts)
	map_script $06, $ff, $0000, $249f, $03, $00
	map_script $07, $ff, $0000, $24a0, $13, $00
	map_script $08, $ff, $0000, $24a1, $03, $00
	map_script $09, $ff, $0000, $24a2, $03, $00
	map_script $0a, $ff, $0000, Func_0f_60de, $03, $00
	map_script $0b, $ff, $0000, $24a6, $03, $00
	map_script $0c, $ff, $0000, $24a7, $03, $00
	map_script $0d, $ff, $0000, $24a8, $03, $00
	map_script $0e, $ff, $0000, $24a9, $03, $00
	map_script $0f, $ff, $0000, $24aa, $03, $00
	map_script $10, $ff, $0000, $24ab, $03, $00
	map_script $03, $ff, $0000, Func_0f_6f3c, $03, $00
	map_script $04, $ff, $0000, Func_0f_6f71, $03, $00
	db $ff
TournamentFacingScripts_0f:
	; $616b, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_0f_6174, $00, $00
	db $ff
Func_0f_6174:
	xor a, a ; $6174
	ldh [hBGColumnBlitPending], a ; $6175
	ldh [hBGRowBlitPending], a ; $6177
	ldh [hScrollY], a ; $6179
	ldh [hScrollX], a ; $617b
	ld [$c321], a ; $617d
	ld [$c323], a ; $6180
	call ClearFrameTasks ; $6183
	call GetIslandOpenRoundParams ; $6186
	ld d, $03 ; $6189
	farcall FarPtr_ShowRankingBoard ; $618b
	ld hl, wStoryModePlayersXPosition ; $618e
	ld de, wStoryModeSpawnPosition ; $6191
	ld bc, $0005 ; $6194
	call CopyMemoryBC ; $6197
	ld a, $ff ; $619a
	ld [wStoryModeEntryPoint], a ; $619c
	ld [$c294], a ; $619f
	ld [wStoryModeExitLocationRequest], a ; $61a2
	ret ; $61a5
TournamentTileTriggers_0f:
	; $61a6, 17 bytes (map_scripts)
	map_script $0e, $ff, $0000, Func_0f_61b7, $00, $00
	map_script $0f, $ff, $0000, Func_0f_61f6, $00, $00
	db $ff
Func_0f_61b7:
	ld a, $01 ; $61b7
	ld [$c2b1], a ; $61b9
	ld a, $02 ; $61bc
	farcall FarPtr_SetActorNullScript ; $61be
	ldh a, [hRomBank] ; $61c1
	ld b, a ; $61c3
	ld a, $00 ; $61c4
	ld de, $61e0 ; $61c6
	farcall FarPtr_ScriptSetActorScript ; $61c9
	ldh a, [hRomBank] ; $61cc
	ld b, a ; $61ce
	ld a, $02 ; $61cf
	ld de, $61eb ; $61d1
	farcall FarPtr_ScriptSetActorScript ; $61d4
	ld a, $00 ; $61d7
	farcall FarPtr_WaitActorScriptDone ; $61d9
	call IslandOpenRoundCallCutscene ; $61dc
	ret ; $61df
	INCBIN "data/bank_00f/d_61e0.bin" ; $61e0, 22 bytes
Func_0f_61f6:
	ld a, $00 ; $61f6
	ld [$c2b1], a ; $61f8
	ldh a, [hRomBank] ; $61fb
	ld b, a ; $61fd
	ld a, $00 ; $61fe
	ld de, $61eb ; $6200
	farcall FarPtr_ScriptSetActorScript ; $6203
	ld a, $00 ; $6206
	farcall FarPtr_WaitActorScriptDone ; $6208
	call IslandOpenRoundCallCutscene ; $620b
	ret ; $620e
TournamentInitScript_0f:
	ld a, $01 ; $620f
	ld hl, $6310 ; $6211
	call RegisterFrameTask ; $6214
	ld a, [wStoryModeEntryPoint] ; $6217
	cp a, $ff ; $621a
	jr z, Label_0f_6221 ; $621c
	clear_flag $17, 1 ; $621e
Label_0f_6221:
	test_flag $17, 1 ; $6221
	jp z, Label_0f_62eb ; $6224
	call ComputeIslandOpenRound ; $6227
	ld a, [$c2b0] ; $622a
	and a, a ; $622d
	jr nz, Label_0f_628e ; $622e
	ldh a, [hRomBank] ; $6230
	ld hl, IslandOpenRoundActors_0f ; $6232
	farcall FarPtr_ScriptRespawnLocationActors ; $6235
	ld hl, IslandOpenRoundScripts_0f ; $6238
	ld de, $000c ; $623b
	farcall FarPtr_WriteStoryStateWord ; $623e
	farcall FarPtr_BeginCutsceneScriptMode ; $6241
	ld a, $03 ; $6244
	ld bc, $1c00 ; $6246
	ld de, $1c00 ; $6249
	farcall FarPtr_ScriptSetActorPosition ; $624c
	ld a, $04 ; $624f
	ld bc, $1c00 ; $6251
	ld de, $1f00 ; $6254
	farcall FarPtr_ScriptSetActorPosition ; $6257
	ld a, $05 ; $625a
	ld bc, $1d00 ; $625c
	ld de, $2100 ; $625f
	farcall FarPtr_ScriptSetActorPosition ; $6262
	script_face $03, $40 ; $6265
	script_face $04, $40 ; $626c
	script_face $05, $80 ; $6273
	test_flag $05, 7 ; $627a
	jr z, Label_0f_628a ; $627d
	ld a, $05 ; $627f
	ld bc, $3f00 ; $6281
	ld de, $3f00 ; $6284
	farcall FarPtr_ScriptSetActorPosition ; $6287
Label_0f_628a:
	call SetPlayerAndPartnerObjectDefs ; $628a
	ret ; $628d
Label_0f_628e:
	test_flag $05, 7 ; $628e
	jr nz, Label_0f_62c4 ; $6291
	ldh a, [hRomBank] ; $6293
	ld hl, IslandOpenRoundActorsSingles_0f ; $6295
	farcall FarPtr_ScriptRespawnLocationActors ; $6298
	ld hl, IslandOpenRoundScriptsSingles_0f ; $629b
	ld de, $000c ; $629e
	farcall FarPtr_WriteStoryStateWord ; $62a1
	farcall FarPtr_BeginCutsceneScriptMode ; $62a4
	call SetPlayerAndPartnerObjectDefs ; $62a7
	script_face $03, $00 ; $62aa
	ld a, $04 ; $62b1
	ld bc, $2700 ; $62b3
	ld de, $1300 ; $62b6
	farcall FarPtr_ScriptSetActorPosition ; $62b9
	script_face $04, $80 ; $62bc
	ret ; $62c3
Label_0f_62c4:
	ldh a, [hRomBank] ; $62c4
	ld hl, IslandOpenRoundActorsDoubles_0f ; $62c6
	farcall FarPtr_ScriptRespawnLocationActors ; $62c9
	ld hl, IslandOpenRoundScriptsDoubles_0f ; $62cc
	ld de, $000c ; $62cf
	farcall FarPtr_WriteStoryStateWord ; $62d2
	farcall FarPtr_BeginCutsceneScriptMode ; $62d5
	call SetPlayerAndPartnerObjectDefs ; $62d8
	ld a, $00 ; $62db
	ld b, a ; $62dd
	ld a, $04 ; $62de
	farcall FarPtr_FaceActorTowardActor ; $62e0
	script_face $03, $00 ; $62e3
	ret ; $62ea
Label_0f_62eb:
	ld a, [wStoryModeEntryPoint] ; $62eb
	cp a, $0f ; $62ee
	jr nz, Label_0f_62f6 ; $62f0
	call IslandOpenArrivalCutscene ; $62f2
	ret ; $62f5
Label_0f_62f6:
	cp a, $0a ; $62f6
	jr nz, Label_0f_62fe ; $62f8
	call IslandOpenSinglesMatchReturn ; $62fa
	ret ; $62fd
Label_0f_62fe:
	cp a, $0b ; $62fe
	jr nz, Label_0f_6306 ; $6300
	call $76a3 ; $6302
	ret ; $6305
Label_0f_6306:
	call LoadIslandOpenRoundNpcs ; $6306
	call SetPlayerAndPartnerObjectDefs ; $6309
	call Func_0f_7aaf ; $630c
	ret ; $630f
	ld a, $00 ; $6310
	call Func_0f_631f ; $6312
	test_flag $05, 7 ; $6315
	ret z ; $6318
	ld a, $02 ; $6319
	call Func_0f_631f ; $631b
	ret ; $631e
Func_0f_631f:
	ld h, a ; $631f
	ld l, $00 ; $6320
	push af ; $6322
	wram_bank $04 ; $6323
	srl h ; $6329
	rr l ; $632b
	srl h ; $632d
	rr l ; $632f
	ld bc, $d000 ; $6331
	add hl, bc ; $6334
	ld b, h ; $6335
	ld c, l ; $6336
	ld hl, $000c ; $6337
	add hl, bc ; $633a
	ld a, [hl+] ; $633b
	ld h, [hl] ; $633c
	ld l, a ; $633d
	ld de, $ffb0 ; $633e
	add hl, de ; $6341
	ld d, h ; $6342
	ld hl, $000e ; $6343
	add hl, bc ; $6346
	ld a, [hl+] ; $6347
	add a, $40 ; $6348
	ld a, [hl] ; $634a
	adc a, $00 ; $634b
	ld e, a ; $634d
	dec e ; $634e
	pop af ; $634f
	or a, a ; $6350
	jr z, Label_0f_6355 ; $6351
	dec e ; $6353
	dec e ; $6354
Label_0f_6355:
	push de ; $6355
	call Func_0f_6408 ; $6356
	pop de ; $6359
	and a, $87 ; $635a
	cp a, $05 ; $635c
	jr nz, Label_0f_636f ; $635e
	wram_bank $04 ; $6360
	ld hl, $0020 ; $6366
	add hl, bc ; $6369
	ld a, [hl] ; $636a
	xor a, $01 ; $636b
	ld [hl], a ; $636d
	ret ; $636e
Label_0f_636f:
	inc d ; $636f
	call Func_0f_6408 ; $6370
	and a, $07 ; $6373
	cp a, $05 ; $6375
	jr nz, Label_0f_6388 ; $6377
	wram_bank $04 ; $6379
	ld hl, $0020 ; $637f
	add hl, bc ; $6382
	ld a, [hl] ; $6383
	xor a, $01 ; $6384
	ld [hl], a ; $6386
	ret ; $6387
Label_0f_6388:
	wram_bank $04 ; $6388
	ld hl, $0020 ; $638e
	add hl, bc ; $6391
	ld a, $02 ; $6392
	ld [hl], a ; $6394
	ret ; $6395
	ld h, a ; $6396
	ld l, $00 ; $6397
	wram_bank $04 ; $6399
	srl h ; $639f
	rr l ; $63a1
	srl h ; $63a3
	rr l ; $63a5
	ld bc, $d000 ; $63a7
	add hl, bc ; $63aa
	ld b, h ; $63ab
	ld c, l ; $63ac
	ld hl, $000c ; $63ad
	add hl, bc ; $63b0
	ld a, [hl+] ; $63b1
	ld h, [hl] ; $63b2
	ld l, a ; $63b3
	ld de, $ffb0 ; $63b4
	add hl, de ; $63b7
	ld d, h ; $63b8
	ld hl, $000e ; $63b9
	add hl, bc ; $63bc
	ld a, [hl+] ; $63bd
	add a, $40 ; $63be
	ld a, [hl] ; $63c0
	adc a, $00 ; $63c1
	ld e, a ; $63c3
	dec e ; $63c4
	dec e ; $63c5
	dec e ; $63c6
	push de ; $63c7
	call Func_0f_6408 ; $63c8
	pop de ; $63cb
	and a, $87 ; $63cc
	cp a, $05 ; $63ce
	jr nz, Label_0f_63e1 ; $63d0
	wram_bank $04 ; $63d2
	ld hl, $0020 ; $63d8
	add hl, bc ; $63db
	ld a, [hl] ; $63dc
	xor a, $01 ; $63dd
	ld [hl], a ; $63df
	ret ; $63e0
Label_0f_63e1:
	inc d ; $63e1
	call Func_0f_6408 ; $63e2
	and a, $07 ; $63e5
	cp a, $05 ; $63e7
	jr nz, Label_0f_63fa ; $63e9
	wram_bank $04 ; $63eb
	ld hl, $0020 ; $63f1
	add hl, bc ; $63f4
	ld a, [hl] ; $63f5
	xor a, $01 ; $63f6
	ld [hl], a ; $63f8
	ret ; $63f9
Label_0f_63fa:
	wram_bank $04 ; $63fa
	ld hl, $0020 ; $6400
	add hl, bc ; $6403
	ld a, $02 ; $6404
	ld [hl], a ; $6406
	ret ; $6407
Func_0f_6408:
	wram_bank $02 ; $6408
	ld h, e ; $640e
	ld l, $00 ; $640f
	srl h ; $6411
	rr l ; $6413
	srl h ; $6415
	rr l ; $6417
	ld a, d ; $6419
	add a, l ; $641a
	ld l, a ; $641b
	jr nc, Label_0f_641f ; $641c
	inc h ; $641e
Label_0f_641f:
	ld d, h ; $641f
	ld e, l ; $6420
	ld l, c ; $6421
	ld h, b ; $6422
	add hl, de ; $6423
	ld a, [hl] ; $6424
	ret ; $6425
IslandOpenArrivalCutscene:
	set_flag $17, 1 ; $6426
	ldh a, [hRomBank] ; $6429
	ld hl, IslandOpenRoundActors_0f ; $642b
	farcall FarPtr_ScriptRespawnLocationActors ; $642e
	ld hl, IslandOpenRoundScripts_0f ; $6431
	ld de, $000c ; $6434
	farcall FarPtr_WriteStoryStateWord ; $6437
	farcall FarPtr_BeginCutsceneScriptMode ; $643a
	call Func_0f_7a17 ; $643d
	script_player_speed $00ff ; $6440
	script_move_player $1c00, $2500 ; $6446
	farcall FarPtr_WaitPlayerMoveDone ; $6450
	ld c, $04 ; $6453
	call BeginFadeIn ; $6455
	call WaitFadeEnd ; $6458
	script_player_speed $0018 ; $645b
	script_move_player $1c00, $1b00 ; $6461
	script_move_target $03, $1c00, $1c00 ; $646b
	script_move_target $04, $1c00, $1f00 ; $6476
	script_move_target $05, $1d00, $2100 ; $6481
	script_move_target $00, $1b00, $2100 ; $648c
	script_wait_move $00 ; $6497
	script_wait_frames $28 ; $649c
	script_face $03, $40 ; $64a3
	script_set_text $2415 ; $64aa
	script_face $00, $40 ; $64b0
	script_wait_frames $28 ; $64b7
	script_face $00, $80 ; $64be
	script_wait_frames $28 ; $64c5
	script_face $00, $c0 ; $64cc
	script_wait_frames $28 ; $64d3
	script_face $00, $00 ; $64da
	script_wait_frames $28 ; $64e1
	script_face $00, $40 ; $64e8
	script_wait_frames $28 ; $64ef
	script_set_anim $00, $02 ; $64f6
	script_wait_idle $00 ; $64fd
	script_face $04, $00 ; $6502
	script_face $04, $40 ; $6509
	script_face $05, $80 ; $6510
	script_wait_frames $14 ; $6517
	script_set_anim $04, $04 ; $651e
	script_wait_idle $04 ; $6525
	script_speak $04 ; $652a
	script_face $00, $c0 ; $652f
	script_wait_frames $28 ; $6536
	script_set_anim $00, $03 ; $653d
	script_wait_idle $00 ; $6544
	script_set_anim $03, $02 ; $6549
	script_wait_idle $03 ; $6550
	script_speak $03 ; $6555
	script_set_anim $00, $02 ; $655a
	script_wait_idle $00 ; $6561
	test_flag $05, 7 ; $6566
	jr nz, Label_0f_6582 ; $6569
	script_set_anim $05, $03 ; $656b
	script_wait_idle $05 ; $6572
	script_speak $05 ; $6577
	set_flag $15, 6 ; $657c
	jr Label_0f_65a6 ; $657f
	ret ; $6581
Label_0f_6582:
	farcall FarPtr_AdvanceDialogueTextCursor ; $6582
	script_set_anim $04, $03 ; $6585
	script_wait_idle $04 ; $658c
	script_speak $04 ; $6591
	ld a, $05 ; $6596
	farcall FarPtr_GetActorStateAddr ; $6598
	ld c, l ; $659b
	ld b, h ; $659c
	ld de, $d000 ; $659d
	farcall FarPtr_04_20 ; $65a0
	set_flag $15, 7 ; $65a3
Label_0f_65a6:
	script_player_speed $0018 ; $65a6
	script_move_player $1c00, $1d00 ; $65ac
	farcall FarPtr_WaitPlayerMoveDone ; $65b6
	ld a, $00 ; $65b9
	ld [$c2b0], a ; $65bb
	farcall FarPtr_SaveStorySlotWithTimer ; $65be
	ret ; $65c1
IslandOpenRoundActors_0f:
	; $65c2, 52 bytes (map_actors)
	map_actor $0000, $7b57, $1c00, $2c00, $c0, $5c, $01, $00
	map_actor $0000, $7b57, $1c00, $2f00, $c0, $5a, $01, $00
	map_actor $0000, $7b57, $1d00, $3100, $c0, $5b, $01, $00
	map_actor_end
IslandOpenRoundScripts_0f:
	; $65f6, 25 bytes (map_scripts)
	map_script $03, $ff, $0000, $2419, $03, $00
	map_script $04, $ff, $0000, $241a, $03, $00
	map_script $05, $ff, $0000, $241b, $03, $00
	db $ff
ComputeIslandOpenRound:
	test_flag $05, 7 ; $660f
	jr nz, Label_0f_663b ; $6612
	test_flag $07, 5 ; $6614
	jr z, Label_0f_661f ; $6617
	ld a, $03 ; $6619
	ld [$c2b0], a ; $661b
	ret ; $661e
Label_0f_661f:
	test_flag $07, 6 ; $661f
	jr z, Label_0f_662a ; $6622
	ld a, $02 ; $6624
	ld [$c2b0], a ; $6626
	ret ; $6629
Label_0f_662a:
	test_flag $07, 7 ; $662a
	jr z, Label_0f_6635 ; $662d
	ld a, $01 ; $662f
	ld [$c2b0], a ; $6631
	ret ; $6634
Label_0f_6635:
	ld a, $00 ; $6635
	ld [$c2b0], a ; $6637
	ret ; $663a
Label_0f_663b:
	test_flag $06, 6 ; $663b
	jr z, Label_0f_6646 ; $663e
	ld a, $03 ; $6640
	ld [$c2b0], a ; $6642
	ret ; $6645
Label_0f_6646:
	test_flag $06, 7 ; $6646
	jr z, Label_0f_6635 ; $6649
	ld a, $02 ; $664b
	ld [$c2b0], a ; $664d
	ret ; $6650
LoadIslandOpenRoundNpcs:
	ld a, $00 ; $6651
	ld [$c2b0], a ; $6653
	test_flag $05, 7 ; $6656
	jr nz, Label_0f_66b8 ; $6659
	ld a, $f1 ; $665b
	ld d, $0e ; $665d
	ld e, $14 ; $665f
	farcall FarPtr_WriteBehaviorMapCell ; $6661
	test_flag $07, 5 ; $6664
	jr z, Label_0f_6680 ; $6667
	ldh a, [hRomBank] ; $6669
	ld hl, IslandOpenRound3Actors_0f ; $666b
	farcall FarPtr_ScriptRespawnLocationActors ; $666e
	ld hl, IslandOpenRound3Scripts_0f ; $6671
	ld de, $000c ; $6674
	farcall FarPtr_WriteStoryStateWord ; $6677
	ld a, $03 ; $667a
	ld [$c2b0], a ; $667c
	ret ; $667f
Label_0f_6680:
	test_flag $07, 6 ; $6680
	jr z, Label_0f_669c ; $6683
	ldh a, [hRomBank] ; $6685
	ld hl, IslandOpenRound2Actors_0f ; $6687
	farcall FarPtr_ScriptRespawnLocationActors ; $668a
	ld hl, IslandOpenRound2Scripts_0f ; $668d
	ld de, $000c ; $6690
	farcall FarPtr_WriteStoryStateWord ; $6693
	ld a, $02 ; $6696
	ld [$c2b0], a ; $6698
	ret ; $669b
Label_0f_669c:
	test_flag $07, 7 ; $669c
	jr z, Label_0f_66b7 ; $669f
	ldh a, [hRomBank] ; $66a1
	ld hl, IslandOpenRound1Actors_0f ; $66a3
	farcall FarPtr_ScriptRespawnLocationActors ; $66a6
	ld hl, IslandOpenRound1Scripts_0f ; $66a9
	ld de, $000c ; $66ac
	farcall FarPtr_WriteStoryStateWord ; $66af
	ld a, $01 ; $66b2
	ld [$c2b0], a ; $66b4
Label_0f_66b7:
	ret ; $66b7
Label_0f_66b8:
	ld a, $e1 ; $66b8
	ld d, $0e ; $66ba
	ld e, $14 ; $66bc
	farcall FarPtr_WriteBehaviorMapCell ; $66be
	ld a, $e1 ; $66c1
	ld d, $10 ; $66c3
	ld e, $14 ; $66c5
	farcall FarPtr_WriteBehaviorMapCell ; $66c7
	test_flag $06, 6 ; $66ca
	jr z, Label_0f_66e6 ; $66cd
	ldh a, [hRomBank] ; $66cf
	ld hl, IslandOpenRound3ActorsDoubles_0f ; $66d1
	farcall FarPtr_ScriptRespawnLocationActors ; $66d4
	ld hl, IslandOpenRound3ScriptsDoubles_0f ; $66d7
	ld de, $000c ; $66da
	farcall FarPtr_WriteStoryStateWord ; $66dd
	ld a, $03 ; $66e0
	ld [$c2b0], a ; $66e2
	ret ; $66e5
Label_0f_66e6:
	test_flag $06, 7 ; $66e6
	jr z, Label_0f_6702 ; $66e9
	ldh a, [hRomBank] ; $66eb
	ld hl, IslandOpenRound2ActorsDoubles_0f ; $66ed
	farcall FarPtr_ScriptRespawnLocationActors ; $66f0
	ld hl, IslandOpenRound2ScriptsDoubles_0f ; $66f3
	ld de, $000c ; $66f6
	farcall FarPtr_WriteStoryStateWord ; $66f9
	ld a, $02 ; $66fc
	ld [$c2b0], a ; $66fe
	ret ; $6701
Label_0f_6702:
	ldh a, [hRomBank] ; $6702
	ld hl, IslandOpenRound1ActorsDoubles_0f ; $6704
	farcall FarPtr_ScriptRespawnLocationActors ; $6707
	ld hl, IslandOpenRound1ScriptsDoubles_0f ; $670a
	ld de, $000c ; $670d
	farcall FarPtr_WriteStoryStateWord ; $6710
	ret ; $6713
IslandOpenRound1Actors_0f:
	; $6714, 206 bytes (map_actors)
	map_actor $0000, $7b57, $2700, $1100, $80, $25, $01, $00
	map_actor $0000, $7b57, $1300, $0f00, $40, $25, $01, $00
	map_actor $0000, $7b57, $0100, $0b00, $00, $25, $01, $00
	map_actor $0000, $7b57, $1900, $1500, $40, $5c, $01, $00
	map_actor $0000, $7b57, $1900, $1300, $40, $5b, $01, $00
	map_actor $0000, $7b57, $1100, $1300, $40, $5a, $01, $00
	map_actor $0000, $7b57, $1d00, $1100, $00, $5d, $01, $00
	map_actor $0000, $7b57, $1100, $1500, $40, $5f, $01, $00
	map_actor $0000, $7b57, $2900, $1900, $80, $60, $01, $00
	map_actor $0000, $7b57, $1700, $1300, $40, $61, $01, $00
	map_actor $0000, $7b57, $0f00, $1300, $40, $62, $01, $00
	map_actor $0000, $7b57, $1d00, $1500, $40, $5e, $01, $00
	map_actor $0000, $7b57, $1700, $1500, $40, $1e, $01, $00
	map_actor $0000, $7a73, $2900, $1300, $40, $1f, $01, $00
	map_actor_end
IslandOpenRound1Scripts_0f:
	; $67e2, 105 bytes (map_scripts)
	map_script $06, $ff, $0000, $24b6, $03, $00
	map_script $07, $ff, $0000, $24b7, $03, $00
	map_script $08, $ff, $0000, $24b8, $03, $00
	map_script $09, $ff, $0000, $24b9, $03, $00
	map_script $0a, $ff, $0000, $24ba, $03, $00
	map_script $0b, $ff, $0000, $24bb, $03, $00
	map_script $0c, $ff, $0000, $24bc, $03, $00
	map_script $0d, $ff, $0000, $24bd, $03, $00
	map_script $0e, $ff, $0000, $24be, $03, $00
	map_script $0f, $ff, $0000, $24bf, $03, $00
	map_script $10, $ff, $0000, $24c0, $13, $00
	map_script $03, $ff, $0000, Func_0f_6f3c, $03, $00
	map_script $04, $ff, $0000, Func_0f_6f71, $03, $00
	db $ff
IslandOpenRound2Actors_0f:
	; $684b, 206 bytes (map_actors)
	map_actor $0000, $7b57, $2700, $1100, $80, $25, $01, $00
	map_actor $0000, $7b57, $1300, $0f00, $40, $25, $01, $00
	map_actor $0000, $7b57, $0100, $0b00, $00, $25, $01, $00
	map_actor $0000, $7b57, $1700, $1500, $40, $5c, $01, $00
	map_actor $0000, $7b75, $2300, $1700, $c0, $5b, $01, $00
	map_actor $0000, $7b57, $1d00, $1100, $00, $5d, $01, $00
	map_actor $0000, $7b57, $2900, $1700, $80, $5f, $01, $00
	map_actor $0000, $7b57, $1100, $1500, $40, $5a, $01, $00
	map_actor $0000, $7b57, $2900, $1900, $80, $60, $01, $00
	map_actor $0000, $7b57, $1900, $1500, $40, $61, $01, $00
	map_actor $0000, $7b61, $0700, $1f00, $40, $62, $01, $00
	map_actor $0000, $7b57, $1d00, $1300, $00, $5e, $01, $00
	map_actor $0000, $7b57, $0500, $2100, $40, $1e, $01, $00
	map_actor $0000, $7a73, $2900, $1300, $40, $1f, $01, $00
	map_actor_end
IslandOpenRound2Scripts_0f:
	; $6919, 105 bytes (map_scripts)
	map_script $06, $ff, $0000, $2804, $03, $00
	map_script $07, $ff, $0000, $2805, $13, $00
	map_script $08, $ff, $0000, $2806, $03, $00
	map_script $09, $ff, $0000, $2807, $03, $00
	map_script $0a, $ff, $0000, $2808, $03, $00
	map_script $0b, $ff, $0000, $2809, $03, $00
	map_script $0c, $ff, $0000, $280a, $03, $00
	map_script $0d, $ff, $0000, $280b, $13, $00
	map_script $0e, $ff, $0000, $280c, $03, $00
	map_script $0f, $ff, $0000, $280d, $03, $00
	map_script $10, $ff, $0000, $280e, $13, $00
	map_script $03, $ff, $0000, Func_0f_6f3c, $03, $00
	map_script $04, $ff, $0000, Func_0f_6f71, $03, $00
	db $ff
IslandOpenRound3Actors_0f:
	; $6982, 206 bytes (map_actors)
	map_actor $0000, $7b57, $2700, $1100, $80, $25, $01, $00
	map_actor $0000, $7b57, $1300, $0f00, $40, $25, $01, $00
	map_actor $0000, $7b57, $0e00, $0400, $00, $25, $01, $00
	map_actor $0000, $7b57, $2300, $1100, $c0, $5c, $01, $00
	map_actor $0000, $7b75, $2300, $1700, $c0, $5b, $01, $00
	map_actor $0000, $7b57, $1d00, $1100, $00, $5d, $01, $00
	map_actor $0000, $7b57, $2900, $1700, $80, $5f, $01, $00
	map_actor $0000, $7b57, $1100, $1500, $40, $61, $01, $00
	map_actor $0000, $7b57, $2100, $1100, $00, $5a, $01, $00
	map_actor $0000, $7b57, $2900, $1900, $80, $60, $01, $00
	map_actor $0000, $7b61, $0700, $1f00, $40, $62, $01, $00
	map_actor $0000, $7b57, $1d00, $1300, $00, $5e, $01, $00
	map_actor $0000, $7b57, $0500, $2100, $40, $1e, $01, $00
	map_actor $0000, $7a73, $2900, $1300, $40, $1f, $01, $00
	map_actor_end
IslandOpenRound3Scripts_0f:
	; $6a50, 105 bytes (map_scripts)
	map_script $06, $ff, $0000, $280f, $03, $00
	map_script $07, $ff, $0000, $2810, $13, $00
	map_script $08, $ff, $0000, $2811, $03, $00
	map_script $09, $ff, $0000, $2812, $03, $00
	map_script $0a, $ff, $0000, $2813, $03, $00
	map_script $0b, $ff, $0000, $2814, $03, $00
	map_script $0c, $ff, $0000, $2815, $03, $00
	map_script $0d, $ff, $0000, $2816, $13, $00
	map_script $0e, $ff, $0000, $2817, $03, $00
	map_script $0f, $ff, $0000, $2818, $03, $00
	map_script $10, $ff, $0000, $2819, $13, $00
	map_script $03, $ff, $0000, Func_0f_6f3c, $03, $00
	map_script $04, $ff, $0000, Func_0f_6f71, $03, $00
	db $ff
IslandOpenRound1ActorsDoubles_0f:
	; $6ab9, 192 bytes (map_actors)
	map_actor $0000, $7b57, $2700, $1100, $80, $25, $01, $00
	map_actor $0000, $7b57, $1300, $0f00, $40, $25, $01, $00
	map_actor $0000, $7b57, $0100, $0b00, $00, $25, $01, $00
	map_actor $0000, $7b57, $2300, $1100, $c0, $5c, $01, $00
	map_actor $0000, $7b75, $2300, $1700, $00, $5a, $01, $00
	map_actor $0000, $7b57, $2900, $1700, $80, $5f, $01, $00
	map_actor $0000, $7b57, $2900, $1900, $80, $60, $01, $00
	map_actor $0000, $7b57, $0f00, $1300, $40, $5d, $01, $00
	map_actor $0000, $7b57, $1100, $1300, $40, $5e, $01, $00
	map_actor $0000, $7b57, $1700, $1300, $c0, $61, $01, $00
	map_actor $0000, $7a50, $1900, $10c0, $80, $62, $01, $00
	map_actor $0000, $7b57, $1700, $1500, $40, $1f, $01, $00
	map_actor $0000, $7b57, $1900, $1500, $40, $1e, $01, $05
	map_actor_end
IslandOpenRound1ScriptsDoubles_0f:
	; $6b79, 97 bytes (map_scripts)
	map_script $06, $ff, $0000, $281a, $03, $00
	map_script $07, $ff, $0000, $281b, $13, $00
	map_script $08, $ff, $0000, $281c, $03, $00
	map_script $09, $ff, $0000, $281d, $03, $00
	map_script $0a, $ff, $0000, Func_0f_6bda, $03, $00
	map_script $0b, $ff, $0000, Func_0f_6bfe, $03, $00
	map_script $0c, $ff, $0000, $2824, $03, $00
	map_script $0d, $ff, $0000, Func_0f_6c22, $13, $00
	map_script $0e, $ff, $0000, $2828, $03, $00
	map_script $0f, $ff, $0000, $2829, $03, $00
	map_script $03, $ff, $0000, Func_0f_6f3c, $03, $00
	map_script $04, $ff, $0000, Func_0f_6f71, $03, $00
	db $ff
Func_0f_6bda:
	script_set_text $281e ; $6bda
	ld a, $0a ; $6be0
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6be2
	farcall FarPtr_RunDialogueYesNoPrompt ; $6be5
	farcall FarPtr_ScriptCloseDialogueWindow ; $6be8
	script_wait_frames $05 ; $6beb
	and a, a ; $6bf2
	jr z, Label_0f_6bf8 ; $6bf3
	farcall FarPtr_AdvanceDialogueTextCursor ; $6bf5
Label_0f_6bf8:
	script_speak $0a ; $6bf8
	ret ; $6bfd
Func_0f_6bfe:
	script_set_text $2821 ; $6bfe
	ld a, $0b ; $6c04
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6c06
	farcall FarPtr_RunDialogueYesNoPrompt ; $6c09
	farcall FarPtr_ScriptCloseDialogueWindow ; $6c0c
	script_wait_frames $05 ; $6c0f
	and a, a ; $6c16
	jr z, Label_0f_6c1c ; $6c17
	farcall FarPtr_AdvanceDialogueTextCursor ; $6c19
Label_0f_6c1c:
	script_speak $0b ; $6c1c
	ret ; $6c21
Func_0f_6c22:
	script_set_text $2825 ; $6c22
	ld a, $0d ; $6c28
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6c2a
	farcall FarPtr_RunDialogueYesNoPrompt ; $6c2d
	farcall FarPtr_ScriptCloseDialogueWindow ; $6c30
	script_wait_frames $05 ; $6c33
	and a, a ; $6c3a
	jr z, Label_0f_6c40 ; $6c3b
	farcall FarPtr_AdvanceDialogueTextCursor ; $6c3d
Label_0f_6c40:
	script_speak $0d ; $6c40
	ret ; $6c45
IslandOpenRound2ActorsDoubles_0f:
	; $6c46, 192 bytes (map_actors)
	map_actor $0000, $7b57, $2700, $1100, $80, $25, $01, $00
	map_actor $0000, $7b57, $1300, $0f00, $40, $25, $01, $00
	map_actor $0000, $7b57, $0100, $0b00, $00, $25, $01, $00
	map_actor $0000, $7b57, $1700, $1500, $40, $5c, $01, $00
	map_actor $0000, $7b57, $1900, $1500, $40, $5a, $01, $00
	map_actor $0000, $7b57, $1d00, $1100, $00, $5d, $01, $00
	map_actor $0000, $7b57, $1d00, $1500, $40, $5e, $01, $00
	map_actor $0000, $7b57, $0f00, $1300, $40, $5f, $01, $00
	map_actor $0000, $7b57, $1100, $1300, $40, $60, $01, $00
	map_actor $0000, $7b57, $1700, $1300, $c0, $61, $01, $00
	map_actor $0000, $7a50, $1900, $10c0, $80, $62, $01, $00
	map_actor $0000, $7b57, $2900, $1300, $c0, $1f, $01, $00
	map_actor $0000, $7b75, $2500, $1900, $40, $1e, $01, $05
	map_actor_end
IslandOpenRound2ScriptsDoubles_0f:
	; $6d06, 97 bytes (map_scripts)
	map_script $06, $ff, $0000, $282a, $03, $00
	map_script $07, $ff, $0000, $282b, $03, $00
	map_script $08, $ff, $0000, Func_0f_6d67, $03, $00
	map_script $09, $ff, $0000, $282f, $03, $00
	map_script $0a, $ff, $0000, $2830, $03, $00
	map_script $0b, $ff, $0000, $2831, $03, $00
	map_script $0c, $ff, $0000, $2832, $03, $00
	map_script $0d, $ff, $0000, Func_0f_6d8b, $13, $00
	map_script $0e, $ff, $0000, $2836, $13, $00
	map_script $0f, $ff, $0000, $2837, $13, $00
	map_script $03, $ff, $0000, Func_0f_6f3c, $03, $00
	map_script $04, $ff, $0000, Func_0f_6f71, $03, $00
	db $ff
Func_0f_6d67:
	script_set_text $282c ; $6d67
	ld a, $08 ; $6d6d
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6d6f
	farcall FarPtr_RunDialogueYesNoPrompt ; $6d72
	farcall FarPtr_ScriptCloseDialogueWindow ; $6d75
	script_wait_frames $05 ; $6d78
	and a, a ; $6d7f
	jr z, Label_0f_6d85 ; $6d80
	farcall FarPtr_AdvanceDialogueTextCursor ; $6d82
Label_0f_6d85:
	script_speak $08 ; $6d85
	ret ; $6d8a
Func_0f_6d8b:
	script_set_text $2833 ; $6d8b
	ld a, $0d ; $6d91
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6d93
	farcall FarPtr_RunDialogueYesNoPrompt ; $6d96
	farcall FarPtr_ScriptCloseDialogueWindow ; $6d99
	script_wait_frames $05 ; $6d9c
	and a, a ; $6da3
	jr z, Label_0f_6da9 ; $6da4
	farcall FarPtr_AdvanceDialogueTextCursor ; $6da6
Label_0f_6da9:
	script_speak $0d ; $6da9
	ret ; $6dae
IslandOpenRound3ActorsDoubles_0f:
	; $6daf, 192 bytes (map_actors)
	map_actor $0000, $7b57, $2700, $1100, $80, $25, $01, $00
	map_actor $0000, $7b57, $1300, $0f00, $40, $25, $01, $00
	map_actor $0000, $7b57, $0e00, $0400, $00, $25, $01, $00
	map_actor $0000, $7b57, $2300, $1100, $40, $5c, $01, $00
	map_actor $0000, $7b57, $2300, $1300, $c0, $5a, $01, $00
	map_actor $0000, $7b57, $2900, $1700, $80, $5f, $01, $00
	map_actor $0000, $7b57, $2900, $1900, $80, $60, $01, $00
	map_actor $0000, $7b57, $0f00, $1300, $40, $61, $01, $00
	map_actor $0000, $7b57, $1100, $1300, $40, $62, $01, $00
	map_actor $0000, $7b57, $1d00, $1100, $00, $5d, $01, $00
	map_actor $0000, $7b57, $1d00, $1500, $40, $5e, $01, $00
	map_actor $0000, $7b57, $2900, $1500, $40, $1f, $01, $00
	map_actor $0000, $7b75, $2400, $1800, $40, $1e, $01, $05
	map_actor_end
IslandOpenRound3ScriptsDoubles_0f:
	; $6e6f, 97 bytes (map_scripts)
	map_script $06, $ff, $0000, $2838, $03, $00
	map_script $07, $ff, $0000, $2839, $03, $00
	map_script $08, $ff, $0000, $283a, $03, $00
	map_script $09, $ff, $0000, $283b, $03, $00
	map_script $0a, $ff, $0000, $283c, $03, $00
	map_script $0b, $ff, $0000, Func_0f_6ef4, $03, $00
	map_script $0c, $ff, $0000, Func_0f_6ed0, $03, $00
	map_script $0d, $ff, $0000, $2843, $03, $00
	map_script $0e, $ff, $0000, $2844, $13, $00
	map_script $0f, $ff, $0000, $2845, $13, $00
	map_script $03, $ff, $0000, Func_0f_6f3c, $03, $00
	map_script $04, $ff, $0000, Func_0f_6f71, $03, $00
	db $ff
Func_0f_6ed0:
	script_set_text $2840 ; $6ed0
	ld a, $0c ; $6ed6
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6ed8
	farcall FarPtr_RunDialogueYesNoPrompt ; $6edb
	farcall FarPtr_ScriptCloseDialogueWindow ; $6ede
	script_wait_frames $05 ; $6ee1
	and a, a ; $6ee8
	jr z, Label_0f_6eee ; $6ee9
	farcall FarPtr_AdvanceDialogueTextCursor ; $6eeb
Label_0f_6eee:
	script_speak $0c ; $6eee
	ret ; $6ef3
Func_0f_6ef4:
	script_set_text $283d ; $6ef4
	ld a, $0b ; $6efa
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6efc
	farcall FarPtr_RunDialogueYesNoPrompt ; $6eff
	farcall FarPtr_ScriptCloseDialogueWindow ; $6f02
	script_wait_frames $05 ; $6f05
	and a, a ; $6f0c
	jr z, Label_0f_6f12 ; $6f0d
	farcall FarPtr_AdvanceDialogueTextCursor ; $6f0f
Label_0f_6f12:
	script_speak $0b ; $6f12
	ret ; $6f17
	script_set_text $24a3 ; $6f18
	ld a, $0b ; $6f1e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6f20
	farcall FarPtr_RunDialogueYesNoPrompt ; $6f23
	farcall FarPtr_ScriptCloseDialogueWindow ; $6f26
	script_wait_frames $05 ; $6f29
	and a, a ; $6f30
	jr z, Label_0f_6f36 ; $6f31
	farcall FarPtr_AdvanceDialogueTextCursor ; $6f33
Label_0f_6f36:
	script_speak $0b ; $6f36
	ret ; $6f3b
Func_0f_6f3c:
	script_set_text $24ac ; $6f3c
	ld a, $03 ; $6f42
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6f44
	farcall FarPtr_RunDialogueYesNoPrompt ; $6f47
	farcall FarPtr_ScriptCloseDialogueWindow ; $6f4a
	script_wait_frames $05 ; $6f4d
	and a, a ; $6f54
	jr nz, Label_0f_6f5d ; $6f55
	script_speak $03 ; $6f57
	ret ; $6f5c
Label_0f_6f5d:
	ld hl, $24ae ; $6f5d
	ld a, [$c2b0] ; $6f60
	add a, l ; $6f63
	ld l, a ; $6f64
	jr nc, Label_0f_6f68 ; $6f65
	inc h ; $6f67
Label_0f_6f68:
	farcall FarPtr_InitDialogueTextCursor ; $6f68
	script_speak $03 ; $6f6b
	ret ; $6f70
Func_0f_6f71:
	ld hl, $24b2 ; $6f71
	ld a, [$c2b0] ; $6f74
	add a, l ; $6f77
	ld l, a ; $6f78
	jr nc, Label_0f_6f7c ; $6f79
	inc h ; $6f7b
Label_0f_6f7c:
	farcall FarPtr_InitDialogueTextCursor ; $6f7c
	script_speak $04 ; $6f7f
	ret ; $6f84
Func_0f_6f85:
	test_flag $05, 7 ; $6f85
	jr z, Label_0f_6fc2 ; $6f88
	test_flag $06, 6 ; $6f8a
	jr nz, Label_0f_6fc2 ; $6f8d
	ld a, $0d ; $6f8f
	farcall FarPtr_SetActorNullScript ; $6f91
	script_move_target $0d, $1900, $1100 ; $6f94
	script_wait_move $0d ; $6f9f
	script_move_target $0d, $1900, $1300 ; $6fa4
	script_wait_move $0d ; $6faf
	script_face $0c, $40 ; $6fb4
	script_face $0d, $40 ; $6fbb
Label_0f_6fc2:
	ret ; $6fc2
IslandOpenRoundCallCutscene:
	script_set_text $285e ; $6fc3
	script_move_player $1100, $0f00 ; $6fc9
	farcall FarPtr_WaitPlayerMoveDone ; $6fd3
	script_move_target $05, $0e00, $0c00 ; $6fd6
	script_wait_move $05 ; $6fe1
	script_move_target $05, $1300, $0c00 ; $6fe6
	script_wait_move $05 ; $6ff1
	script_face $05, $40 ; $6ff6
	script_set_anim $05, $02 ; $6ffd
	script_wait_idle $05 ; $7004
	call QueueUpcomingRoundNameText ; $7009
	script_speak $05 ; $700c
	call Func_0f_6f85 ; $7011
	script_face $04, $c0 ; $7014
	script_set_anim $04, $03 ; $701b
	script_wait_idle $04 ; $7022
	script_face $04, $40 ; $7027
	script_move_target $04, $1300, $1700 ; $702e
	script_move_target $05, $1300, $1700 ; $7039
	script_move_player $1100, $1300 ; $7044
	script_wait_move $04 ; $704e
	script_move_target $04, $1500, $1700 ; $7053
	script_wait_move $04 ; $705e
	script_face $04, $c0 ; $7063
	script_wait_move $05 ; $706a
	script_face $05, $c0 ; $706f
	call QueueUpcomingRoundNameText ; $7076
	script_speak $04 ; $7079
	script_face_pair $05, $04 ; $707e
	script_set_anim $04, $03 ; $7086
	script_wait_idle $04 ; $708d
	script_move_target $05, $1000, $1700 ; $7092
	ld a, [$c2b0] ; $709d
	cp a, $03 ; $70a0
	jr z, Label_0f_70bb ; $70a2
	script_move_target $04, $1800, $1700 ; $70a4
	script_wait_move $04 ; $70af
	script_face $04, $c0 ; $70b4
Label_0f_70bb:
	script_wait_move $05 ; $70bb
	script_face $05, $c0 ; $70c0
	script_speak $04 ; $70c7
	test_flag $05, 7 ; $70cc
	jp nz, Label_0f_722f ; $70cf
	script_set_speed $00, $0020 ; $70d2
	script_face_pair $0a, $00 ; $70da
	script_wait_frames $1e ; $70e2
	script_face $00, $40 ; $70e9
	script_face $0a, $40 ; $70f0
	script_set_anim $0a, $03 ; $70f7
	script_set_anim $00, $03 ; $70fe
	script_wait_idle $00 ; $7105
	test_flag $07, 5 ; $710a
	jr z, Label_0f_716c ; $710d
	script_move_target $05, $1300, $1700 ; $710f
	script_wait_move $05 ; $711a
	ldh a, [hRomBank] ; $711f
	ld b, a ; $7121
	ld a, $05 ; $7122
	ld de, $73e4 ; $7124
	farcall FarPtr_ScriptSetActorScript ; $7127
	script_wait_frames $14 ; $712a
	ldh a, [hRomBank] ; $7131
	ld b, a ; $7133
	ld a, $0a ; $7134
	ld de, $73e4 ; $7136
	farcall FarPtr_ScriptSetActorScript ; $7139
	script_wait_frames $14 ; $713c
	ldh a, [hRomBank] ; $7143
	ld b, a ; $7145
	ld a, $00 ; $7146
	ld de, $73e4 ; $7148
	farcall FarPtr_ScriptSetActorScript ; $714b
	script_wait_frames $14 ; $714e
	script_move_player $1100, $0d00 ; $7155
	farcall FarPtr_WaitPlayerMoveDone ; $715f
	script_wait_frames $1e ; $7162
	jp Label_0f_71bf ; $7169
Label_0f_716c:
	script_move_target $05, $1300, $1700 ; $716c
	script_wait_move $05 ; $7177
	ldh a, [hRomBank] ; $717c
	ld b, a ; $717e
	ld a, $05 ; $717f
	ld de, $73be ; $7181
	farcall FarPtr_ScriptSetActorScript ; $7184
	script_wait_frames $14 ; $7187
	ldh a, [hRomBank] ; $718e
	ld b, a ; $7190
	ld a, $0a ; $7191
	ld de, $73be ; $7193
	farcall FarPtr_ScriptSetActorScript ; $7196
	script_wait_frames $14 ; $7199
	ldh a, [hRomBank] ; $71a0
	ld b, a ; $71a2
	ld a, $00 ; $71a3
	ld de, $73be ; $71a5
	farcall FarPtr_ScriptSetActorScript ; $71a8
	script_move_player $1100, $0d00 ; $71ab
	farcall FarPtr_WaitPlayerMoveDone ; $71b5
	script_wait_frames $3c ; $71b8
Label_0f_71bf:
	ld c, $10 ; $71bf
	call BeginFadeOut ; $71c1
	call WaitFadeEnd ; $71c4
	call Func_0f_7434 ; $71c7
	ld a, $19 ; $71ca
	ld [wStoryModeCurrentLocation], a ; $71cc
	ld a, $0a ; $71cf
	ld [wStoryModeEntryPoint], a ; $71d1
	ld a, $ff ; $71d4
	ld [$c294], a ; $71d6
	ld [wStoryModeExitLocationRequest], a ; $71d9
	farcall FarPtr_InitStoryMatchSettings ; $71dc
	test_flag $07, 5 ; $71df
	jr z, Label_0f_71f3 ; $71e2
	load_match_settings $0013 ; $71e4
	jr Label_0f_7228 ; $71f1
Label_0f_71f3:
	test_flag $07, 6 ; $71f3
	jr z, Label_0f_7207 ; $71f6
	load_match_settings $0012 ; $71f8
	jr Label_0f_7228 ; $7205
Label_0f_7207:
	test_flag $07, 7 ; $7207
	jr z, Label_0f_721b ; $720a
	load_match_settings $0011 ; $720c
	jr Label_0f_7228 ; $7219
Label_0f_721b:
	load_match_settings $0010 ; $721b
Label_0f_7228:
	farcall FarPtr_RunStoryMatch ; $7228
	farcall FarPtr_RestoreOverworldAfterMatch ; $722b
	ret ; $722e
Label_0f_722f:
	script_face_pair $02, $00 ; $722f
	script_set_speed $00, $0020 ; $7237
	script_set_speed $02, $0020 ; $723f
	script_wait_frames $14 ; $7247
	script_set_anim $02, $03 ; $724e
	script_set_anim $00, $03 ; $7255
	script_wait_idle $00 ; $725c
	script_face $00, $40 ; $7261
	script_face $02, $40 ; $7268
	test_flag $06, 6 ; $726f
	jp z, Label_0f_72e8 ; $7272
	script_move_target $05, $1300, $1700 ; $7275
	script_wait_move $05 ; $7280
	ldh a, [hRomBank] ; $7285
	ld b, a ; $7287
	ld a, $05 ; $7288
	ld de, $73e4 ; $728a
	farcall FarPtr_ScriptSetActorScript ; $728d
	script_wait_frames $14 ; $7290
	ldh a, [hRomBank] ; $7297
	ld b, a ; $7299
	ld a, $00 ; $729a
	ld de, $73e4 ; $729c
	farcall FarPtr_ScriptSetActorScript ; $729f
	script_wait_frames $14 ; $72a2
	ldh a, [hRomBank] ; $72a9
	ld b, a ; $72ab
	ld a, $02 ; $72ac
	ld de, $73e4 ; $72ae
	farcall FarPtr_ScriptSetActorScript ; $72b1
	script_wait_frames $3c ; $72b4
	ldh a, [hRomBank] ; $72bb
	ld b, a ; $72bd
	ld a, $0b ; $72be
	ld de, $73fd ; $72c0
	farcall FarPtr_ScriptSetActorScript ; $72c3
	script_wait_frames $14 ; $72c6
	ldh a, [hRomBank] ; $72cd
	ld b, a ; $72cf
	ld a, $0a ; $72d0
	ld de, $73fd ; $72d2
	farcall FarPtr_ScriptSetActorScript ; $72d5
	script_move_player $1100, $0d00 ; $72d8
	farcall FarPtr_WaitPlayerMoveDone ; $72e2
	jp Label_0f_735f ; $72e5
Label_0f_72e8:
	script_move_target $05, $1300, $1700 ; $72e8
	script_wait_move $05 ; $72f3
	ldh a, [hRomBank] ; $72f8
	ld b, a ; $72fa
	ld a, $05 ; $72fb
	ld de, $73be ; $72fd
	farcall FarPtr_ScriptSetActorScript ; $7300
	script_wait_frames $14 ; $7303
	ldh a, [hRomBank] ; $730a
	ld b, a ; $730c
	ld a, $00 ; $730d
	ld de, $73be ; $730f
	farcall FarPtr_ScriptSetActorScript ; $7312
	script_wait_frames $14 ; $7315
	ldh a, [hRomBank] ; $731c
	ld b, a ; $731e
	ld a, $02 ; $731f
	ld de, $73be ; $7321
	farcall FarPtr_ScriptSetActorScript ; $7324
	script_wait_frames $3c ; $7327
	ldh a, [hRomBank] ; $732e
	ld b, a ; $7330
	ld a, $0b ; $7331
	ld de, $73d1 ; $7333
	farcall FarPtr_ScriptSetActorScript ; $7336
	script_wait_frames $14 ; $7339
	ldh a, [hRomBank] ; $7340
	ld b, a ; $7342
	ld a, $0a ; $7343
	ld de, $73d1 ; $7345
	farcall FarPtr_ScriptSetActorScript ; $7348
	script_move_player $1100, $0d00 ; $734b
	farcall FarPtr_WaitPlayerMoveDone ; $7355
	script_wait_frames $3c ; $7358
Label_0f_735f:
	ld c, $10 ; $735f
	call BeginFadeOut ; $7361
	call WaitFadeEnd ; $7364
	call Func_0f_7434 ; $7367
	ld a, $19 ; $736a
	ld [wStoryModeCurrentLocation], a ; $736c
	ld a, $0b ; $736f
	ld [wStoryModeEntryPoint], a ; $7371
	ld a, $ff ; $7374
	ld [$c294], a ; $7376
	ld [wStoryModeExitLocationRequest], a ; $7379
	farcall FarPtr_InitStoryMatchSettings ; $737c
	test_flag $06, 6 ; $737f
	jp z, Label_0f_7394 ; $7382
	load_match_settings $0113 ; $7385
	jr Label_0f_73b7 ; $7392
Label_0f_7394:
	test_flag $06, 7 ; $7394
	jp z, Label_0f_73aa ; $7397
	load_match_settings $0112 ; $739a
	jp Label_0f_73b7 ; $73a7
Label_0f_73aa:
	load_match_settings $0111 ; $73aa
Label_0f_73b7:
	farcall FarPtr_RunStoryMatch ; $73b7
	farcall FarPtr_RestoreOverworldAfterMatch ; $73ba
	ret ; $73bd
	INCBIN "data/bank_00f/d_73be.bin" ; $73be, 88 bytes
GetIslandOpenRoundParams:
	test_flag $05, 7 ; $7416
	jr nz, Label_0f_7425 ; $7419
	ld b, $00 ; $741b
	ld a, [$c2b0] ; $741d
	inc a ; $7420
	ld c, a ; $7421
	ld d, $00 ; $7422
	ret ; $7424
Label_0f_7425:
	ld b, $01 ; $7425
	ld a, [$c2b0] ; $7427
	inc a ; $742a
	cp a, $03 ; $742b
	jr c, Label_0f_7430 ; $742d
	dec a ; $742f
Label_0f_7430:
	ld c, a ; $7430
	ld d, $00 ; $7431
	ret ; $7433
Func_0f_7434:
	xor a, a ; $7434
	ldh [hBGColumnBlitPending], a ; $7435
	ldh [hBGRowBlitPending], a ; $7437
	ldh [hScrollY], a ; $7439
	ldh [hScrollX], a ; $743b
	ld [$c321], a ; $743d
	ld [$c323], a ; $7440
	call ClearFrameTasks ; $7443
	call GetIslandOpenRoundParams ; $7446
	farcall FarPtr_ShowRankingBoard ; $7449
	ret ; $744c
QueueUpcomingRoundNameText:
	ld a, [$c2b0] ; $744d
	ld hl, $2861 ; $7450
	add a, l ; $7453
	ld l, a ; $7454
	jr nc, Label_0f_7458 ; $7455
	inc h ; $7457
Label_0f_7458:
	call QueueShortText ; $7458
	ret ; $745b
CheckIslandOpenVictoryTransition:
	test_flag $05, 7 ; $745c
	jr nz, Label_0f_7468 ; $745f
	test_flag $07, 4 ; $7461
	jr nz, Label_0f_746f ; $7464
	jr Label_0f_7484 ; $7466
Label_0f_7468:
	test_flag $06, 5 ; $7468
	jr nz, Label_0f_746f ; $746b
	jr Label_0f_7484 ; $746d
Label_0f_746f:
	ld a, $1b ; $746f
	ld [wStoryModeCurrentLocation], a ; $7471
	ld a, $08 ; $7474
	ld [wStoryModeEntryPoint], a ; $7476
	ld a, $ff ; $7479
	ld [$c294], a ; $747b
	ld [wStoryModeExitLocationRequest], a ; $747e
	ld a, $01 ; $7481
	ret ; $7483
Label_0f_7484:
	ld a, $00 ; $7484
	ret ; $7486
IslandOpenSinglesMatchReturn:
	wram_bank $04 ; $7487
	ld a, [wMatchExitRequest] ; $748d
	cp a, $01 ; $7490
	jr z, Label_0f_749c ; $7492
	ld a, [wMatchWinLoseFlag] ; $7494
	cp a, $01 ; $7497
	jp z, Label_0f_74a3 ; $7499
Label_0f_749c:
	call LoadIslandOpenRoundNpcs ; $749c
	call SetPlayerAndPartnerObjectDefs ; $749f
	ret ; $74a2
Label_0f_74a3:
	clear_flag $0e, 6 ; $74a3
	clear_flag $0f, 0 ; $74a6
	call CheckIslandOpenVictoryTransition ; $74a9
	and a, a ; $74ac
	jr z, Label_0f_74b0 ; $74ad
	ret ; $74af
Label_0f_74b0:
	ldh a, [hRomBank] ; $74b0
	ld hl, IslandOpenRoundActorsSingles_0f ; $74b2
	farcall FarPtr_ScriptRespawnLocationActors ; $74b5
	ld hl, IslandOpenRoundScriptsSingles_0f ; $74b8
	ld de, $000c ; $74bb
	farcall FarPtr_WriteStoryStateWord ; $74be
	call ComputeIslandOpenRound ; $74c1
	farcall FarPtr_BeginCutsceneScriptMode ; $74c4
	call SetPlayerAndPartnerObjectDefs ; $74c7
	ld a, $08 ; $74ca
	farcall FarPtr_GetActorStateAddr ; $74cc
	ld c, l ; $74cf
	ld b, h ; $74d0
	ld hl, $0037 ; $74d1
	add hl, bc ; $74d4
	ld a, [hl] ; $74d5
	xor a, $20 ; $74d6
	ld [hl], a ; $74d8
	ld c, $04 ; $74d9
	call BeginFadeIn ; $74db
	call WaitFadeEnd ; $74de
	ld a, [$c2b0] ; $74e1
	add a, a ; $74e4
	add a, $99 ; $74e5
	ld l, a ; $74e7
	adc a, $76 ; $74e8
	sub a, l ; $74ea
	ld h, a ; $74eb
	ld a, [hl+] ; $74ec
	ld h, [hl] ; $74ed
	ld l, a ; $74ee
	farcall FarPtr_InitDialogueTextCursor ; $74ef
	ld a, $08 ; $74f2
	ld bc, $2200 ; $74f4
	ld de, $0f80 ; $74f7
	farcall FarPtr_ScriptSetActorPosition ; $74fa
	sound $97 ; $74fd
	script_wait_frames $2d ; $74ff
	script_set_anim $03, $02 ; $7506
	script_wait_idle $03 ; $750d
	ld a, $03 ; $7512
	ld b, a ; $7514
	ld a, $00 ; $7515
	farcall FarPtr_FaceActorTowardActor ; $7517
	ld a, $08 ; $751a
	ld bc, $3f00 ; $751c
	ld de, $3f00 ; $751f
	farcall FarPtr_ScriptSetActorPosition ; $7522
	script_speak $03 ; $7525
	script_set_anim $05, $02 ; $752a
	script_wait_idle $05 ; $7531
	ld a, $05 ; $7536
	ld b, a ; $7538
	ld a, $00 ; $7539
	farcall FarPtr_FaceActorTowardActor ; $753b
	script_speak $05 ; $753e
	script_set_anim $04, $03 ; $7543
	script_wait_idle $04 ; $754a
	ld a, $04 ; $754f
	ld b, a ; $7551
	ld a, $00 ; $7552
	farcall FarPtr_FaceActorTowardActor ; $7554
	script_speak $04 ; $7557
	call IslandOpenBreakCutscene ; $755c
	script_set_text $2849 ; $755f
	ld a, [$c2b0] ; $7565
	dec a ; $7568
	ld hl, $2862 ; $7569
	add a, l ; $756c
	ld l, a ; $756d
	jr nc, Label_0f_7571 ; $756e
	inc h ; $7570
Label_0f_7571:
	call QueueShortText ; $7571
	script_face $04, $c0 ; $7574
	script_face $03, $00 ; $757b
	ld a, $04 ; $7582
	ld b, a ; $7584
	ld a, $00 ; $7585
	farcall FarPtr_FaceActorTowardActor ; $7587
	script_speak $04 ; $758a
	script_move_angle $04, $00, $0200 ; $758f
	script_wait_move $04 ; $7599
	script_wait_frames $0a ; $759e
	script_wait_frames $0a ; $75a5
	script_face $04, $80 ; $75ac
	set_flag $17, 1 ; $75b3
	ret ; $75b6
IslandOpenRoundActorsSingles_0f:
	; $75b7, 94 bytes (map_actors)
	map_actor $0000, $7b57, $2300, $1100, $00, $5c, $01, $00
	map_actor $0000, $7b57, $2500, $1300, $c0, $5a, $01, $00
	map_actor $0000, $7b57, $2700, $1100, $80, $5b, $01, $00
	map_actor $0000, $7b57, $0100, $3100, $c0, $25, $01, $00
	map_actor $0000, $7b57, $0100, $3100, $c0, $25, $01, $00
	map_actor $0000, $7b57, $0100, $3100, $c0, $4c, $01, $00
	map_actor_end
IslandOpenRoundScriptsSingles_0f:
	; $7615, 25 bytes (map_scripts)
	map_script $03, $ff, $0000, Func_0f_7649, $03, $00
	map_script $04, $ff, $0000, Func_0f_762e, $03, $00
	map_script $05, $ff, $0000, Func_0f_766c, $03, $00
	db $ff
Func_0f_762e:
	script_set_text $2849 ; $762e
	ld a, [$c2b0] ; $7634
	dec a ; $7637
	ld hl, $2862 ; $7638
	add a, l ; $763b
	ld l, a ; $763c
	jr nc, Label_0f_7640 ; $763d
	inc h ; $763f
Label_0f_7640:
	call QueueShortText ; $7640
	script_speak $04 ; $7643
	ret ; $7648
Func_0f_7649:
	ld a, [$c2b0] ; $7649
	add a, a ; $764c
	add a, $99 ; $764d
	ld l, a ; $764f
	adc a, $76 ; $7650
	sub a, l ; $7652
	ld h, a ; $7653
	ld a, [hl+] ; $7654
	ld h, [hl] ; $7655
	ld l, a ; $7656
	farcall FarPtr_InitDialogueTextCursor ; $7657
	script_set_anim $03, $03 ; $765a
	script_wait_idle $03 ; $7661
	script_speak $03 ; $7666
	ret ; $766b
Func_0f_766c:
	ld a, [$c2b0] ; $766c
	dec a ; $766f
	add a, a ; $7670
	add a, $91 ; $7671
	ld l, a ; $7673
	adc a, $76 ; $7674
	sub a, l ; $7676
	ld h, a ; $7677
	ld a, [hl+] ; $7678
	ld h, [hl] ; $7679
	ld l, a ; $767a
	farcall FarPtr_InitDialogueTextCursor ; $767b
	ld a, $05 ; $767e
	ld de, $ff80 ; $7680
	farcall FarPtr_ScriptSetActorJumpVelocity ; $7683
	ld a, $05 ; $7686
	farcall FarPtr_ScriptWaitActorJumpDone ; $7688
	script_speak $05 ; $768b
	ret ; $7690
	db $47 ; $7691
	; $7692, 18 bytes (records:2)
	dw $4b28 ; record 0
	dw $4f28 ; record 1
	dw $4f28 ; record 2
	dw $4628 ; record 3
	dw $4628 ; record 4
	dw $4a28 ; record 5
	dw $4e28 ; record 6
	dw $5228 ; record 7
	dw $3e28 ; record 8
	inc b ; $76a4
	wram_bank ; $76a5
	ld a, [wMatchExitRequest] ; $76a9
	cp a, $01 ; $76ac
	jr z, Label_0f_76b8 ; $76ae
	ld a, [wMatchWinLoseFlag] ; $76b0
	cp a, $01 ; $76b3
	jp z, $76e9 ; $76b5
Label_0f_76b8:
	call LoadIslandOpenRoundNpcs ; $76b8
	call SetPlayerAndPartnerObjectDefs ; $76bb
	ld a, $00 ; $76be
	ld bc, $2500 ; $76c0
	ld de, $1100 ; $76c3
	farcall FarPtr_ScriptSetActorPosition ; $76c6
	script_move_player $2500, $1100 ; $76c9
	ld a, $02 ; $76d3
	ld bc, $2500 ; $76d5
	ld de, $1300 ; $76d8
	farcall FarPtr_ScriptSetActorPosition ; $76db
	script_face $02, $c0 ; $76de
	farcall FarPtr_WaitPlayerMoveDone ; $76e5
	ret ; $76e8
	db $ef ; $76e9
	ldh [$ff0e], a ; $76ea
	clear_flag $0f, 1 ; $76ec
	call CheckIslandOpenVictoryTransition ; $76ef
	and a, a ; $76f2
	jr z, Label_0f_76f6 ; $76f3
	ret ; $76f5
Label_0f_76f6:
	ldh a, [hRomBank] ; $76f6
	ld hl, IslandOpenRoundActorsDoubles_0f ; $76f8
	farcall FarPtr_ScriptRespawnLocationActors ; $76fb
	farcall FarPtr_BeginCutsceneScriptMode ; $76fe
	ld hl, IslandOpenRoundScriptsDoubles_0f ; $7701
	ld de, $000c ; $7704
	farcall FarPtr_WriteStoryStateWord ; $7707
	call SetPlayerAndPartnerObjectDefs ; $770a
	ld a, $02 ; $770d
	farcall FarPtr_SetActorNullScript ; $770f
	ld a, $02 ; $7712
	ld bc, $2500 ; $7714
	ld de, $1100 ; $7717
	farcall FarPtr_ScriptSetActorPosition ; $771a
	script_face $02, $c0 ; $771d
	ld c, $04 ; $7724
	call BeginFadeIn ; $7726
	call WaitFadeEnd ; $7729
	call ComputeIslandOpenRound ; $772c
	farcall FarPtr_BeginCutsceneScriptMode ; $772f
	ld a, $00 ; $7732
	ld b, a ; $7734
	ld a, $02 ; $7735
	farcall FarPtr_FaceActorTowardActor ; $7737
	ld c, $04 ; $773a
	call BeginFadeIn ; $773c
	call WaitFadeEnd ; $773f
	ld a, [$c2b0] ; $7742
	dec a ; $7745
	add a, a ; $7746
	add a, $3a ; $7747
	ld l, a ; $7749
	adc a, $78 ; $774a
	sub a, l ; $774c
	ld h, a ; $774d
	ld a, [hl+] ; $774e
	ld h, [hl] ; $774f
	ld l, a ; $7750
	farcall FarPtr_InitDialogueTextCursor ; $7751
	ld a, [$c94d] ; $7754
	or a, a ; $7757
	jr nz, Label_0f_7763 ; $7758
	farcall FarPtr_AdvanceDialogueTextCursor ; $775a
	farcall FarPtr_AdvanceDialogueTextCursor ; $775d
	farcall FarPtr_AdvanceDialogueTextCursor ; $7760
Label_0f_7763:
	ld a, $08 ; $7763
	farcall FarPtr_GetActorStateAddr ; $7765
	ld c, l ; $7768
	ld b, h ; $7769
	ld hl, $0037 ; $776a
	add hl, bc ; $776d
	ld a, [hl] ; $776e
	xor a, $20 ; $776f
	ld [hl], a ; $7771
	ld a, $00 ; $7772
	ld b, a ; $7774
	ld a, $02 ; $7775
	farcall FarPtr_FaceActorTowardActor ; $7777
	ld a, $02 ; $777a
	ld de, $ff80 ; $777c
	farcall FarPtr_ScriptSetActorJumpVelocity ; $777f
	ld a, $02 ; $7782
	farcall FarPtr_ScriptWaitActorJumpDone ; $7784
	ld a, $02 ; $7787
	ld b, a ; $7789
	ld a, $00 ; $778a
	farcall FarPtr_FaceActorTowardActor ; $778c
	script_speak $02 ; $778f
	ld a, $08 ; $7794
	ld bc, $2000 ; $7796
	ld de, $0f80 ; $7799
	farcall FarPtr_ScriptSetActorPosition ; $779c
	sound $97 ; $779f
	script_wait_frames $2d ; $77a1
	script_set_anim $03, $02 ; $77a8
	script_wait_idle $03 ; $77af
	ld a, $08 ; $77b4
	ld bc, $3f00 ; $77b6
	ld de, $3f00 ; $77b9
	farcall FarPtr_ScriptSetActorPosition ; $77bc
	ld a, $03 ; $77bf
	ld b, a ; $77c1
	ld a, $00 ; $77c2
	farcall FarPtr_FaceActorTowardActor ; $77c4
	script_speak $03 ; $77c7
	script_set_anim $04, $03 ; $77cc
	script_wait_idle $04 ; $77d3
	ld a, $04 ; $77d8
	ld b, a ; $77da
	ld a, $00 ; $77db
	farcall FarPtr_FaceActorTowardActor ; $77dd
	ld a, $04 ; $77e0
	ld b, a ; $77e2
	ld a, $02 ; $77e3
	farcall FarPtr_FaceActorTowardActor ; $77e5
	script_speak $04 ; $77e8
	call IslandOpenBreakCutscene ; $77ed
	ld a, $00 ; $77f0
	ld b, a ; $77f2
	ld a, $04 ; $77f3
	farcall FarPtr_FaceActorTowardActor ; $77f5
	script_face $03, $00 ; $77f8
	script_set_text $2849 ; $77ff
	ld a, [$c2b0] ; $7805
	dec a ; $7808
	ld hl, $2862 ; $7809
	add a, l ; $780c
	ld l, a ; $780d
	jr nc, Label_0f_7811 ; $780e
	inc h ; $7810
Label_0f_7811:
	call QueueShortText ; $7811
	ld a, $04 ; $7814
	ld b, a ; $7816
	ld a, $00 ; $7817
	farcall FarPtr_FaceActorTowardActor ; $7819
	ld a, $04 ; $781c
	ld b, a ; $781e
	ld a, $02 ; $781f
	farcall FarPtr_FaceActorTowardActor ; $7821
	script_speak $03 ; $7824
	set_flag $17, 1 ; $7829
	ld a, $02 ; $782c
	farcall FarPtr_GetActorStateAddr ; $782e
	ld c, l ; $7831
	ld b, h ; $7832
	ld de, $d000 ; $7833
	farcall FarPtr_04_20 ; $7836
	ret ; $7839
	; $783a, 8 bytes (records:2)
	dw $2852 ; record 0
	dw $2852 ; record 1
	dw $2858 ; record 2
	dw $284e ; record 3
IslandOpenRoundActorsDoubles_0f:
	; $7842, 94 bytes (map_actors)
	map_actor $0000, $7b57, $2100, $1100, $00, $5c, $01, $00
	map_actor $0000, $7b57, $2700, $1100, $80, $5a, $01, $00
	map_actor $0000, $7b57, $3d00, $3d00, $c0, $5b, $01, $00
	map_actor $0000, $7b57, $0100, $3100, $c0, $25, $01, $00
	map_actor $0000, $7b57, $0100, $3100, $c0, $25, $01, $00
	map_actor $0000, $7b57, $0100, $3100, $c0, $4c, $01, $00
	map_actor_end
IslandOpenRoundScriptsDoubles_0f:
	; $78a0, 17 bytes (map_scripts)
	map_script $03, $ff, $0000, Func_0f_78cc, $03, $00
	map_script $04, $ff, $0000, Func_0f_78b1, $03, $00
	db $ff
Func_0f_78b1:
	script_set_text $2849 ; $78b1
	ld a, [$c2b0] ; $78b7
	dec a ; $78ba
	ld hl, $2862 ; $78bb
	add a, l ; $78be
	ld l, a ; $78bf
	jr nc, Label_0f_78c3 ; $78c0
	inc h ; $78c2
Label_0f_78c3:
	call QueueShortText ; $78c3
	script_speak $04 ; $78c6
	ret ; $78cb
Func_0f_78cc:
	ld a, [$c2b0] ; $78cc
	dec a ; $78cf
	add a, a ; $78d0
	add a, $e4 ; $78d1
	ld l, a ; $78d3
	adc a, $78 ; $78d4
	sub a, l ; $78d6
	ld h, a ; $78d7
	ld a, [hl+] ; $78d8
	ld h, [hl] ; $78d9
	ld l, a ; $78da
	farcall FarPtr_InitDialogueTextCursor ; $78db
	script_speak $03 ; $78de
	ret ; $78e3
	; $78e4, 8 bytes (records:2)
	dw $2853 ; record 0
	dw $2853 ; record 1
	dw $2859 ; record 2
	dw $284f ; record 3
QueueFinishedRoundNameText:
	test_flag $05, 7 ; $78ec
	jr nz, Label_0f_7901 ; $78ef
	ld a, [$c2b0] ; $78f1
	dec a ; $78f4
	ld hl, $2861 ; $78f5
	add a, l ; $78f8
	ld l, a ; $78f9
	jr nc, Label_0f_78fd ; $78fa
	inc h ; $78fc
Label_0f_78fd:
	call QueueShortText ; $78fd
	ret ; $7900
Label_0f_7901:
	ld a, [$c2b0] ; $7901
	dec a ; $7904
	ld hl, $2865 ; $7905
	add a, l ; $7908
	ld l, a ; $7909
	jr nc, Label_0f_790d ; $790a
	inc h ; $790c
Label_0f_790d:
	call QueueShortText ; $790d
	ret ; $7910
IslandOpenBreakCutscene:
	ld a, $06 ; $7911
	ld bc, $1500 ; $7913
	ld de, $1700 ; $7916
	farcall FarPtr_ScriptSetActorPosition ; $7919
	ld a, $07 ; $791c
	ld bc, $1700 ; $791e
	ld de, $1700 ; $7921
	farcall FarPtr_ScriptSetActorPosition ; $7924
	script_move_target $06, $2300, $1700 ; $7927
	script_move_target $07, $2500, $1700 ; $7932
	script_wait_move $07 ; $793d
	script_set_text $2869 ; $7942
	script_move_player $2300, $1100 ; $7948
	farcall FarPtr_WaitPlayerMoveDone ; $7952
	script_face $03, $40 ; $7955
	script_face $04, $40 ; $795c
	script_face $05, $40 ; $7963
	script_face $00, $40 ; $796a
	script_face $02, $40 ; $7971
	script_face $06, $c0 ; $7978
	script_face $07, $c0 ; $797f
	script_set_anim $06, $03 ; $7986
	script_wait_idle $06 ; $798d
	call QueueFinishedRoundNameText ; $7992
	script_speak $06 ; $7995
	script_set_anim $06, $03 ; $799a
	script_wait_idle $06 ; $79a1
	ld a, [$c2b0] ; $79a6
	ld hl, $2861 ; $79a9
	add a, l ; $79ac
	ld l, a ; $79ad
	jr nc, Label_0f_79b1 ; $79ae
	inc h ; $79b0
Label_0f_79b1:
	call QueueShortText ; $79b1
	script_speak $06 ; $79b4
	script_face_pair $07, $06 ; $79b9
	script_wait_frames $14 ; $79c1
	script_set_anim $06, $03 ; $79c8
	script_set_anim $07, $03 ; $79cf
	script_wait_idle $07 ; $79d6
	script_move_target $06, $1500, $1700 ; $79db
	script_move_target $07, $1700, $1700 ; $79e6
	script_wait_move $07 ; $79f1
	ld a, $00 ; $79f6
	ld b, $00 ; $79f8
	farcall FarPtr_MovePlayerToActor ; $79fa
	ld a, $06 ; $79fd
	ld bc, $3f00 ; $79ff
	ld de, $3f00 ; $7a02
	farcall FarPtr_ScriptSetActorPosition ; $7a05
	ld a, $07 ; $7a08
	ld bc, $3f00 ; $7a0a
	ld de, $3f00 ; $7a0d
	farcall FarPtr_ScriptSetActorPosition ; $7a10
	farcall FarPtr_WaitPlayerMoveDone ; $7a13
	ret ; $7a16
Func_0f_7a17:
	call SetPlayerAndPartnerObjectDefs ; $7a17
	test_flag $05, 7 ; $7a1a
	jr z, Label_0f_7a29 ; $7a1d
	ld a, [$c94d] ; $7a1f
	or a, a ; $7a22
	jr nz, Label_0f_7a2a ; $7a23
	ld d, $58 ; $7a25
	jr Label_0f_7a2e ; $7a27
Label_0f_7a29:
	ret ; $7a29
Label_0f_7a2a:
	ld d, $59 ; $7a2a
	jr Label_0f_7a2e ; $7a2c
Label_0f_7a2e:
	ld a, $05 ; $7a2e
	farcall FarPtr_GetActorStateAddr ; $7a30
	ld c, l ; $7a33
	ld b, h ; $7a34
	farcall FarPtr_04_2c ; $7a35
	script_set_anim $05, $01 ; $7a38
	ld a, $02 ; $7a3f
	farcall FarPtr_SetActorNullScript ; $7a41
	ld a, $02 ; $7a44
	ld bc, $3f00 ; $7a46
	ld de, $3f00 ; $7a49
	farcall FarPtr_ScriptSetActorPosition ; $7a4c
	ret ; $7a4f
	INCBIN "data/bank_00f/d_7a50.bin" ; $7a50, 62 bytes
QueueShortText:
	ldh a, [hWramBank] ; $7a8e
	push af ; $7a90
	wram_bank $07 ; $7a91
	ld de, $df00 ; $7a97
	wram_bank $05 ; $7a9a
	farcall FarPtr_FetchShortTextToBuffer ; $7aa0
	ld hl, $df00 ; $7aa3
	farcall FarPtr_PushTextArgString ; $7aa6
	pop af ; $7aa9
	wram_bank ; $7aaa
	ret ; $7aae
Func_0f_7aaf:
	ld a, [wStoryModeEntryPoint] ; $7aaf
	cp a, $ff ; $7ab2
	jp z, Label_0f_7b15 ; $7ab4
	test_flag $05, 7 ; $7ab7
	jr z, Label_0f_7af8 ; $7aba
	script_set_speed $02, $00ff ; $7abc
	ld a, [wStoryModeEntryPoint] ; $7ac4
	dec a ; $7ac7
	add a, $1b ; $7ac8
	ld l, a ; $7aca
	adc a, $7b ; $7acb
	sub a, l ; $7acd
	ld h, a ; $7ace
	ld b, [hl] ; $7acf
	ld a, $02 ; $7ad0
	ld b, b ; $7ad2
	ld de, $0200 ; $7ad3
	farcall FarPtr_MoveActorByAngle ; $7ad6
	script_wait_move $02 ; $7ad9
	ld a, [wStoryModeEntryPoint] ; $7ade
	dec a ; $7ae1
	add a, $16 ; $7ae2
	ld l, a ; $7ae4
	adc a, $7b ; $7ae5
	sub a, l ; $7ae7
	ld h, a ; $7ae8
	ld b, [hl] ; $7ae9
	ld a, $02 ; $7aea
	ld b, b ; $7aec
	farcall FarPtr_SetActorFacing ; $7aed
	script_set_speed $02, $0010 ; $7af0
Label_0f_7af8:
	script_set_speed $00, $0010 ; $7af8
	ld a, [wStoryModeEntryPoint] ; $7b00
	dec a ; $7b03
	add a, $16 ; $7b04
	ld l, a ; $7b06
	adc a, $7b ; $7b07
	sub a, l ; $7b09
	ld h, a ; $7b0a
	ld b, [hl] ; $7b0b
	ld a, $00 ; $7b0c
	ld b, b ; $7b0e
	ld de, $0200 ; $7b0f
	farcall FarPtr_MoveActorByAngle ; $7b12
Label_0f_7b15:
	ret ; $7b15
	INCBIN "data/bank_00f/d_7b16.bin" ; $7b16, 10 bytes
SetPlayerAndPartnerObjectDefs:
	test_flag $05, 7 ; $7b20
	jp z, Label_0f_7b3e ; $7b23
	ld a, [$c94d] ; $7b26
	ld d, $58 ; $7b29
	add a, d ; $7b2b
	ld d, a ; $7b2c
	ld a, $02 ; $7b2d
	farcall FarPtr_GetActorStateAddr ; $7b2f
	ld c, l ; $7b32
	ld b, h ; $7b33
	farcall FarPtr_04_2c ; $7b34
	script_set_anim $02, $01 ; $7b37
Label_0f_7b3e:
	ld a, [$c90d] ; $7b3e
	ld d, $56 ; $7b41
	add a, d ; $7b43
	ld d, a ; $7b44
	ld a, $00 ; $7b45
	farcall FarPtr_GetActorStateAddr ; $7b47
	ld c, l ; $7b4a
	ld b, h ; $7b4b
	farcall FarPtr_04_2c ; $7b4c
	script_set_anim $00, $01 ; $7b4f
	ret ; $7b56
	INCBIN "data/bank_00f/d_7b57.bin" ; $7b57, 612 bytes
	ds 581, $ff ; $7dbb, fill

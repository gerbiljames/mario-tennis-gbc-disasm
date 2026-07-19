SECTION "ROM Bank $11", ROMX[$4000], BANK[$11]

DataPtr_CenterCourtMapScripts_11:
	dw CenterCourtMapScripts_11 ; $4000
DataPtr_AcademyArrivalScene_11:
	dw AcademyArrivalScene_11 ; $4002
DataPtr_JuniorClassCourtDoublesScene_11:
	dw JuniorClassCourtDoublesScene_11 ; $4004
DataPtr_JuniorClassCourtSinglesScene_11:
	dw JuniorClassCourtSinglesScene_11 ; $4006
CenterCourtMapScripts_11:
	; $4008, 14 bytes (map_tree)
	dw CenterCourtEntryPoints_11 ; slot 0 EntryPoints
	dw CenterCourtExitTriggers_11 ; slot 1 ExitTriggers
	dw CenterCourtActors_11 ; slot 2 Actors
	dw CenterCourtNpcScripts_11 ; slot 3 NpcScripts
	dw CenterCourtFacingScripts_11 ; slot 4 FacingScripts
	dw CenterCourtTileTriggers_11 ; slot 5 TileTriggers
	dw CenterCourtInitScript_11 ; slot 6 InitScript
CenterCourtActors_11:
	; $4016, 66 bytes (map_actors)
	map_actor $0000, ActorObjDef_11_7ba9, $0f00, $2e00, $80, $25, $01, $00
	map_actor $0000, ActorObjDef_11_7ba9, $0d00, $1300, $40, $25, $01, $00
	map_actor $0000, ActorObjDef_11_7ba9, $1f00, $2e00, $00, $39, $01, $07
	map_actor $0000, ActorObjDef_11_7ba9, $2100, $2e00, $80, $32, $01, $07
	map_actor_end
CenterCourtEntryPoints_11:
	; $4058, 25 bytes (map_entries)
	map_entry $01, $c0, $0c00, $3100, $0000
	map_entry $02, $c0, $2400, $3100, $0000
	map_entry $0f, $c0, $0c00, $3100, $0000
	db $ff
CenterCourtExitTriggers_11:
	; $4071, 17 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_11_7bd1, $19, $01
	map_script $02, $ff, $0000, Func_11_7bd1, $19, $02
	db $ff
Func_11_4082:
	script_set_text $2450 ; $4082
	test_flag $05, 7 ; $4088
	jr nz, Label_11_409c ; $408b
	ld a, [$c2b0] ; $408d
	cp a, $03 ; $4090
	jr nz, Label_11_40a9 ; $4092
	script_set_text $245b ; $4094
	jr Label_11_40a9 ; $409a
Label_11_409c:
	ld a, [$c2b0] ; $409c
	cp a, $06 ; $409f
	jr nz, Label_11_40a9 ; $40a1
	script_set_text $245b ; $40a3
Label_11_40a9:
	script_speak $03 ; $40a9
	ret ; $40ae
Func_11_40af:
	test_flag $05, 7 ; $40af
	jr z, Label_11_40c9 ; $40b2
	script_set_text $2460 ; $40b4
	ld a, [$c2b0] ; $40ba
	cp a, $06 ; $40bd
	jr nz, Label_11_40fa ; $40bf
	script_set_text $2465 ; $40c1
	jr Label_11_40fa ; $40c7
Label_11_40c9:
	script_set_text $2451 ; $40c9
	ld a, $04 ; $40cf
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $40d1
	farcall FarPtr_RunDialogueYesNoPrompt ; $40d4
	farcall FarPtr_ScriptCloseDialogueWindow ; $40d7
	script_wait_frames $05 ; $40da
	and a, a ; $40e1
	jr z, Label_11_40ed ; $40e2
	farcall FarPtr_AdvanceDialogueTextCursor ; $40e4
	script_speak $04 ; $40e7
	ret ; $40ec
Label_11_40ed:
	ld a, [$c2b0] ; $40ed
	cp a, $03 ; $40f0
	jr nz, Label_11_40fa ; $40f2
	farcall FarPtr_AdvanceDialogueTextCursor ; $40f4
	farcall FarPtr_AdvanceDialogueTextCursor ; $40f7
Label_11_40fa:
	script_speak $04 ; $40fa
	ret ; $40ff
Func_11_4100:
	ld a, [$c2b0] ; $4100
	add a, a ; $4103
	add a, $3c ; $4104
	ld l, a ; $4106
	adc a, $41 ; $4107
	sub a, l ; $4109
	ld h, a ; $410a
	ld a, [hl+] ; $410b
	ld h, [hl] ; $410c
	ld l, a ; $410d
	farcall FarPtr_InitDialogueTextCursor ; $410e
	ld a, [$c2b0] ; $4111
	cp a, $03 ; $4114
	jr z, Label_11_411e ; $4116
	script_speak $05 ; $4118
	ret ; $411d
Label_11_411e:
	ld a, $05 ; $411e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4120
	farcall FarPtr_RunDialogueYesNoPrompt ; $4123
	farcall FarPtr_ScriptCloseDialogueWindow ; $4126
	script_wait_frames $05 ; $4129
	and a, a ; $4130
	jr z, Label_11_4136 ; $4131
	farcall FarPtr_AdvanceDialogueTextCursor ; $4133
Label_11_4136:
	script_speak $05 ; $4136
	ret ; $413b
	; $413c, 14 bytes (records:2)
	dw $2455 ; record 0
	dw $2457 ; record 1
	dw $2459 ; record 2
	dw $245c ; record 3
	dw $2461 ; record 4
	dw $2463 ; record 5
	dw $2466 ; record 6
Func_11_414a:
	ld a, [$c2b0] ; $414a
	add a, a ; $414d
	add a, $61 ; $414e
	ld l, a ; $4150
	adc a, $41 ; $4151
	sub a, l ; $4153
	ld h, a ; $4154
	ld a, [hl+] ; $4155
	ld h, [hl] ; $4156
	ld l, a ; $4157
	farcall FarPtr_InitDialogueTextCursor ; $4158
	script_speak $05 ; $415b
	ret ; $4160
	; $4161, 14 bytes (records:2)
	dw $2456 ; record 0
	dw $2458 ; record 1
	dw $245a ; record 2
	dw $245f ; record 3
	dw $2462 ; record 4
	dw $2464 ; record 5
	dw $2467 ; record 6
CenterCourtNpcScripts_11:
	; $416f, 33 bytes (map_scripts)
	map_script $03, $ff, $0000, Func_11_4082, $03, $00
	map_script $04, $ff, $0000, Func_11_40af, $03, $00
	map_script $05, $ff, $0000, Func_11_4100, $03, $00
	map_script $06, $ff, $0000, Func_11_414a, $03, $00
	db $ff
CenterCourtFacingScripts_11:
	; $4190, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_11_4199, $00, $00
	db $ff
Func_11_4199:
	ret ; $4199
CenterCourtTileTriggers_11:
	; $419a, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_11_41a3, $00, $00
	db $ff
Func_11_41a3:
	ret ; $41a3
CenterCourtInitScript_11:
	call Func_11_41b6 ; $41a4
	call Func_11_4343 ; $41a7
	ld a, [wStoryModeEntryPoint] ; $41aa
	cp a, $0f ; $41ad
	jp z, Label_11_437a ; $41af
	call Func_11_42fd ; $41b2
	ret ; $41b5
Func_11_41b6:
	ld a, $00 ; $41b6
	ld [$c2b0], a ; $41b8
	test_flag $05, 7 ; $41bb
	jr nz, Label_11_41ec ; $41be
	test_flag $07, 5 ; $41c0
	jr z, Label_11_41d6 ; $41c3
	ld a, $03 ; $41c5
	ld [$c2b0], a ; $41c7
	ldh a, [hRomBank] ; $41ca
	ld hl, $4213 ; $41cc
	farcall FarPtr_ScriptRespawnLocationActors ; $41cf
	farcall FarPtr_BeginCutsceneScriptMode ; $41d2
	ret ; $41d5
Label_11_41d6:
	test_flag $07, 6 ; $41d6
	jr z, Label_11_41e1 ; $41d9
	ld a, $02 ; $41db
	ld [$c2b0], a ; $41dd
	ret ; $41e0
Label_11_41e1:
	test_flag $07, 7 ; $41e1
	jr z, Label_11_41eb ; $41e4
	ld a, $01 ; $41e6
	ld [$c2b0], a ; $41e8
Label_11_41eb:
	ret ; $41eb
Label_11_41ec:
	test_flag $06, 6 ; $41ec
	jr z, Label_11_4202 ; $41ef
	ld a, $06 ; $41f1
	ld [$c2b0], a ; $41f3
	ldh a, [hRomBank] ; $41f6
	ld hl, $4213 ; $41f8
	farcall FarPtr_ScriptRespawnLocationActors ; $41fb
	farcall FarPtr_BeginCutsceneScriptMode ; $41fe
	ret ; $4201
Label_11_4202:
	test_flag $06, 7 ; $4202
	jr z, Label_11_420d ; $4205
	ld a, $05 ; $4207
	ld [$c2b0], a ; $4209
	ret ; $420c
Label_11_420d:
	ld a, $04 ; $420d
	ld [$c2b0], a ; $420f
	ret ; $4212
	; $4213, 234 bytes (bytes:14)
	db $00, $00, $a9, $7b, $00, $0f, $00, $2e, $80, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $a9, $7b, $00, $0d, $00, $27, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $a9, $7b, $00, $25, $00, $24, $80, $00, $39, $01, $07, $00 ; 0x1c
	db $00, $00, $a9, $7b, $00, $23, $00, $21, $80, $00, $32, $01, $07, $00 ; 0x2a
	db $00, $00, $a9, $7b, $00, $27, $00, $23, $80, $00, $23, $01, $04, $00 ; 0x38
	db $00, $00, $a9, $7b, $00, $27, $00, $21, $80, $00, $39, $01, $06, $00 ; 0x46
	db $00, $00, $a9, $7b, $00, $25, $00, $20, $80, $00, $3a, $01, $03, $00 ; 0x54
	db $00, $00, $a9, $7b, $00, $0b, $00, $24, $00, $00, $33, $01, $00, $00 ; 0x62
	db $00, $00, $a9, $7b, $00, $0d, $00, $21, $00, $00, $3a, $01, $04, $00 ; 0x70
	db $00, $00, $a9, $7b, $00, $09, $00, $23, $00, $00, $39, $01, $03, $00 ; 0x7e
	db $00, $00, $a9, $7b, $00, $05, $00, $20, $00, $00, $39, $01, $06, $00 ; 0x8c
	db $00, $00, $a9, $7b, $00, $09, $00, $21, $00, $00, $3a, $01, $03, $00 ; 0x9a
	db $00, $00, $a9, $7b, $00, $2b, $00, $22, $80, $00, $33, $01, $00, $00 ; 0xa8
	db $00, $00, $a9, $7b, $00, $2b, $00, $20, $80, $00, $3a, $01, $04, $00 ; 0xb6
	db $00, $00, $a9, $7b, $00, $2b, $00, $1e, $80, $00, $6b, $01, $00, $00 ; 0xc4
	db $00, $00, $a9, $7b, $00, $27, $00, $1d, $80, $00, $6a, $01, $04, $00 ; 0xd2
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xe0
Func_11_42fd:
	ld a, [wStoryModeEntryPoint] ; $42fd
	cp a, $ff ; $4300
	jp z, Label_11_4342 ; $4302
	test_flag $05, 7 ; $4305
	jr z, Label_11_4330 ; $4308
	script_set_speed $02, $00ff ; $430a
	script_move_angle $02, $40, $0200 ; $4312
	script_wait_move $02 ; $431c
	script_face $02, $c0 ; $4321
	script_set_speed $02, $0010 ; $4328
Label_11_4330:
	script_set_speed $00, $0010 ; $4330
	script_move_angle $00, $c0, $0200 ; $4338
Label_11_4342:
	ret ; $4342
Func_11_4343:
	test_flag $05, 7 ; $4343
	jp z, Label_11_4361 ; $4346
	ld a, [$c94d] ; $4349
	ld d, $58 ; $434c
	add a, d ; $434e
	ld d, a ; $434f
	ld a, $02 ; $4350
	farcall FarPtr_GetActorStateAddr ; $4352
	ld c, l ; $4355
	ld b, h ; $4356
	farcall FarPtr_LoadActorObjectDefIfValid ; $4357
	script_set_anim $02, $01 ; $435a
Label_11_4361:
	ld a, [$c90d] ; $4361
	ld d, $56 ; $4364
	add a, d ; $4366
	ld d, a ; $4367
	ld a, $00 ; $4368
	farcall FarPtr_GetActorStateAddr ; $436a
	ld c, l ; $436d
	ld b, h ; $436e
	farcall FarPtr_LoadActorObjectDefIfValid ; $436f
	script_set_anim $00, $01 ; $4372
	ret ; $4379
Label_11_437a:
	script_set_position $0a, $2500, $2400 ; $437a
	test_flag $05, 7 ; $4385
	jr z, Label_11_4395 ; $4388
	script_set_position $02, $0c00, $3300 ; $438a
Label_11_4395:
	xor a, a ; $4395
	ld [wStoryModeShowLocationName], a ; $4396
	script_fade_in $04 ; $4399
	script_set_actor_script $00, $43ed ; $439e
	script_wait_frames $50 ; $43a9
	script_set_anim $00, $03 ; $43b0
	script_wait_idle $00 ; $43b7
	script_wait_frames $1e ; $43bc
	ld a, $00 ; $43c3
	farcall FarPtr_WaitActorScriptDone ; $43c5
	script_move_player $2300, $2400 ; $43c8
	script_set_actor_script $00, $43f4 ; $43d2
	script_wait_frames $f0 ; $43dd
	ld a, $01 ; $43e4
	ld [$c294], a ; $43e6
	ld [wStoryModeExitLocationRequest], a ; $43e9
	ret ; $43ec
	INCBIN "data/bank_011/d_43ed.bin" ; $43ed, 20 bytes
AcademyArrivalScene_11:
	; $4401, 14 bytes (records:2)
	dw $4515 ; record 0
	dw $457c ; record 1
	dw $440f ; record 2
	dw $4682 ; record 3
	dw $46a3 ; record 4
	dw $46a4 ; record 5
	dw $46b1 ; record 6
	; $440f, 262 bytes (bytes:14)
	db $00, $00, $b3, $7b, $00, $19, $00, $19, $40, $00, $30, $01, $05, $00 ; 0x00
	db $00, $00, $a9, $7b, $00, $15, $00, $25, $80, $00, $32, $01, $00, $00 ; 0x0e
	db $00, $00, $a9, $7b, $00, $15, $00, $27, $80, $00, $39, $01, $00, $00 ; 0x1c
	db $00, $00, $df, $7b, $00, $01, $00, $1c, $40, $00, $54, $01, $03, $00 ; 0x2a
	db $00, $00, $42, $7c, $00, $05, $00, $28, $c0, $00, $54, $01, $04, $00 ; 0x38
	db $00, $00, $a9, $7c, $00, $0a, $00, $1c, $40, $00, $54, $01, $07, $00 ; 0x46
	db $00, $00, $10, $7d, $00, $0f, $00, $28, $c0, $00, $54, $01, $06, $00 ; 0x54
	db $00, $00, $df, $7b, $00, $22, $00, $1c, $40, $00, $54, $01, $06, $00 ; 0x62
	db $00, $00, $42, $7c, $00, $26, $00, $28, $c0, $00, $54, $01, $03, $00 ; 0x70
	db $00, $00, $a9, $7c, $00, $2c, $00, $1c, $40, $00, $54, $01, $07, $00 ; 0x7e
	db $00, $00, $10, $7d, $00, $30, $00, $28, $c0, $00, $54, $01, $04, $00 ; 0x8c
	db $00, $00, $a9, $7b, $00, $15, $00, $3d, $00, $00, $4d, $01, $00, $00 ; 0x9a
	db $00, $00, $a9, $7b, $00, $15, $00, $3d, $00, $00, $4c, $01, $00, $00 ; 0xa8
	db $00, $00, $a9, $7b, $00, $15, $00, $3d, $00, $00, $53, $01, $00, $00 ; 0xb6
	db $00, $00, $a9, $7b, $00, $15, $00, $3d, $40, $00, $63, $01, $00, $00 ; 0xc4
	db $00, $00, $a9, $7b, $00, $15, $00, $3d, $40, $00, $49, $01, $00, $00 ; 0xd2
	db $00, $00, $a9, $7b, $00, $15, $00, $3d, $00, $00, $4f, $01, $00, $00 ; 0xe0
	db $00, $00, $a9, $7b, $00, $18, $00, $33, $c0, $00, $30, $01, $03, $00 ; 0xee
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xfc
	; $4515, 103 bytes (bytes:16)
	db $01, $40, $00, $18, $00, $11, $36, $45, $02, $c0, $00, $18, $00, $33, $fd, $42 ; 0x00
	db $0c, $40, $00, $18, $00, $2f, $00, $00, $0f, $c0, $00, $18, $00, $2f, $00, $00 ; 0x10
	db $ff, $fa, $95, $c2, $fe, $ff, $ca, $7b, $45, $f7, $e0, $05, $28, $26, $3e, $02 ; 0x20
	db $01, $ff, $00, $df, $18, $0a, $3e, $02, $06, $c0, $11, $00, $02, $df, $2a, $0a ; 0x30
	db $3e, $02, $df, $20, $0a, $3e, $02, $06, $40, $df, $2e, $0a, $3e, $02, $01, $10 ; 0x40
	db $00, $df, $18, $0a, $3e, $00, $01, $10, $00, $df, $18, $0a, $3e, $00, $06, $40 ; 0x50
	db $11, $00, $02, $df, $2a, $0a, $c9 ; 0x60
	; $457c, 33 bytes (records:8)
; 4 records x 8 bytes
	dw $ff01, $0000, $7bd1, $0105 ; record 0
	dw $ff02, $0000, $7bd1, $011b ; record 1
	dw $ff03, $0000, $7bd1, $0f1b ; record 2
	dw $ff0f, $0000, $7bd1, $0f05 ; record 3
	db $ff
	ld a, [$c2b0] ; $459d
	add a, a ; $45a0
	add a, $e1 ; $45a1
	ld l, a ; $45a3
	adc a, $45 ; $45a4
	sub a, l ; $45a6
	ld h, a ; $45a7
	ld a, [hl+] ; $45a8
	ld h, [hl] ; $45a9
	ld l, a ; $45aa
	farcall FarPtr_InitDialogueTextCursor ; $45ab
	ld a, [$c2b0] ; $45ae
	cp a, $08 ; $45b1
	jr nc, Label_11_45bd ; $45b3
	cp a, $04 ; $45b5
	jr nc, Label_11_45c3 ; $45b7
	cp a, $02 ; $45b9
	jr c, Label_11_45c3 ; $45bb
Label_11_45bd:
	script_speak $03 ; $45bd
	ret ; $45c2
Label_11_45c3:
	ld a, $03 ; $45c3
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $45c5
	farcall FarPtr_RunDialogueYesNoPrompt ; $45c8
	farcall FarPtr_ScriptCloseDialogueWindow ; $45cb
	script_wait_frames $05 ; $45ce
	and a, a ; $45d5
	jr z, Label_11_45db ; $45d6
	farcall FarPtr_AdvanceDialogueTextCursor ; $45d8
Label_11_45db:
	script_speak $03 ; $45db
	ret ; $45e0
	; $45e1, 20 bytes (records:2)
	dw $1836 ; record 0
	dw $1839 ; record 1
	dw $183f ; record 2
	dw $183f ; record 3
	dw $1842 ; record 4
	dw $1842 ; record 5
	dw $1847 ; record 6
	dw $1847 ; record 7
	dw $184c ; record 8
	dw $184c ; record 9
	ld a, [$c2b0] ; $45f5
	add a, a ; $45f8
	add a, $0c ; $45f9
	ld l, a ; $45fb
	adc a, $46 ; $45fc
	sub a, l ; $45fe
	ld h, a ; $45ff
	ld a, [hl+] ; $4600
	ld h, [hl] ; $4601
	ld l, a ; $4602
	farcall FarPtr_InitDialogueTextCursor ; $4603
	script_speak $04 ; $4606
	ret ; $460b
	; $460c, 20 bytes (records:2)
	dw $183c ; record 0
	dw $183d ; record 1
	dw $1840 ; record 2
	dw $1840 ; record 3
	dw $1845 ; record 4
	dw $1845 ; record 5
	dw $184a ; record 6
	dw $184a ; record 7
	dw $184d ; record 8
	dw $184d ; record 9
	ld a, [$c2b0] ; $4620
	sra a ; $4623
	add a, a ; $4625
	add a, $39 ; $4626
	ld l, a ; $4628
	adc a, $46 ; $4629
	sub a, l ; $462b
	ld h, a ; $462c
	ld a, [hl+] ; $462d
	ld h, [hl] ; $462e
	ld l, a ; $462f
	farcall FarPtr_InitDialogueTextCursor ; $4630
	script_speak $05 ; $4633
	ret ; $4638
	; $4639, 10 bytes (records:2)
	dw $183e ; record 0
	dw $1841 ; record 1
	dw $1846 ; record 2
	dw $184b ; record 3
	dw $184e ; record 4
	script_set_text $1860 ; $4643
	test_flag $05, 7 ; $4649
	jr nz, Label_11_4670 ; $464c
	test_flag $15, 6 ; $464e
	jr z, Label_11_465e ; $4651
	farcall FarPtr_AdvanceDialogueTextCursor ; $4653
	test_flag $16, 0 ; $4656
	jr z, Label_11_465e ; $4659
	farcall FarPtr_AdvanceDialogueTextCursor ; $465b
Label_11_465e:
	script_set_anim $14, $04 ; $465e
	script_wait_idle $14 ; $4665
	script_speak $14 ; $466a
	ret ; $466f
Label_11_4670:
	test_flag $15, 7 ; $4670
	jr z, Label_11_465e ; $4673
	farcall FarPtr_AdvanceDialogueTextCursor ; $4675
	test_flag $16, 1 ; $4678
	jr z, Label_11_465e ; $467b
	farcall FarPtr_AdvanceDialogueTextCursor ; $467d
	jr Label_11_465e ; $4680
	; $4682, 34 bytes (records:8)
; 4 records x 8 bytes
	dw $ff03, $0000, $459d, $0013 ; record 0
	dw $ff04, $0000, $45f5, $0001 ; record 1
	dw $ff05, $0000, $4620, $0001 ; record 2
	dw $ff14, $0000, $4643, $0003 ; record 3
	db $ff, $ff
	; $46a4, 13 bytes (records:8)
; 1 records x 8 bytes
	dw $ff0f, $0000, $46ad, $0000 ; record 0
	db $ff, $cd, $40, $4f, $c9
	call ComputeRankingProgressIndex ; $46b1
	call Func_11_5482 ; $46b4
	call Func_11_54a6 ; $46b7
	ld a, [wStoryModeEntryPoint] ; $46ba
	cp a, $0a ; $46bd
	jp z, Label_11_4fcf ; $46bf
	cp a, $0c ; $46c2
	jp z, Label_11_53db ; $46c4
	cp a, $0f ; $46c7
	jr nz, Label_11_46ce ; $46c9
	call LateStudentCrashCutscene ; $46cb
Label_11_46ce:
	ret ; $46ce
LateStudentCrashCutscene:
	script_set_speed $00, $0010 ; $46cf
	xor a, a ; $46d7
	ld [wStoryModeShowLocationName], a ; $46d8
	script_set_position $11, $1800, $0d00 ; $46db
	script_set_position $00, $1800, $3700 ; $46e6
	script_set_position $14, $3f00, $3f00 ; $46f1
	script_set_position $03, $2280, $1500 ; $46fc
	script_face $03, $00 ; $4707
	script_set_position $04, $3300, $1500 ; $470e
	script_set_position $05, $3300, $1500 ; $4719
	script_fade_in $04 ; $4724
	call WaitFadeEnd ; $4729
	script_move_target $00, $1800, $2d00 ; $472c
	script_wait_move $00 ; $4737
	script_face $00, $00 ; $473c
	script_wait_frames $28 ; $4743
	script_face $00, $c0 ; $474a
	script_wait_frames $28 ; $4751
	script_face $00, $80 ; $4758
	script_wait_frames $28 ; $475f
	script_face $00, $c0 ; $4766
	script_wait_frames $28 ; $476d
	script_face $00, $00 ; $4774
	script_wait_frames $0a ; $477b
	script_face $00, $40 ; $4782
	script_wait_frames $3c ; $4789
	script_set_anim $00, $03 ; $4790
	script_wait_idle $00 ; $4797
	script_wait_frames $3c ; $479c
	script_move_target $00, $1800, $2100 ; $47a3
	script_player_speed $0040 ; $47ae
	script_move_player $1800, $1200 ; $47b4
	farcall FarPtr_WaitPlayerMoveDone ; $47be
	script_wait_frames $3c ; $47c1
	script_set_position $00, $1800, $2000 ; $47c8
	script_face $00, $c0 ; $47d3
	script_set_speed $11, $0024 ; $47da
	script_move_target $11, $1800, $1400 ; $47e2
	script_wait_move $11 ; $47ed
	script_set_anim $11, $04 ; $47f2
	script_wait_idle $11 ; $47f9
	script_face $11, $c0 ; $47fe
	script_set_text $184f ; $4805
	script_speak $11 ; $480b
	script_set_anim $11, $03 ; $4810
	script_wait_idle $11 ; $4817
	script_set_speed $11, $0020 ; $481c
	script_speak $11 ; $4824
	script_face $11, $40 ; $4829
	script_jump_velocity $11, $ff80 ; $4830
	ld a, $11 ; $4838
	farcall FarPtr_ScriptWaitActorJumpDone ; $483a
	script_move_target $11, $1800, $1700 ; $483d
	script_wait_move $11 ; $4848
	script_set_position $0e, $1980, $15c0 ; $484d
	sound $98 ; $4858
	script_set_speed $11, $0010 ; $485a
	script_set_speed $0e, $0010 ; $4862
	script_move_target $0e, $1980, $18c0 ; $486a
	script_move_target $11, $1800, $1a00 ; $4875
	script_wait_move $11 ; $4880
	script_speak $11 ; $4885
	script_set_position $0e, $3f00, $3f00 ; $488a
	script_move_target $11, $1800, $1600 ; $4895
	script_wait_move $11 ; $48a0
	script_wait_frames $1e ; $48a5
	script_set_anim $11, $02 ; $48ac
	script_set_position $0f, $1980, $14c0 ; $48b3
	sound $97 ; $48be
	script_wait_frames $14 ; $48c0
	script_speak $11 ; $48c7
	script_set_position $0f, $3f00, $3f00 ; $48cc
	script_set_speed $11, $0020 ; $48d7
	script_jump_velocity $11, $ff80 ; $48df
	ld a, $11 ; $48e7
	farcall FarPtr_ScriptWaitActorJumpDone ; $48e9
	script_move_target $11, $1800, $2000 ; $48ec
	script_wait_frames $1e ; $48f7
	ld bc, $d040 ; $48fe
	ld a, $11 ; $4901
	farcall FarPtr_GetActorStateAddr ; $4903
	ld e, l ; $4906
	ld d, h ; $4907
	farcall FarPtr_04_1e ; $4908
	script_move_target $00, $1800, $1e00 ; $490b
	script_wait_frames $14 ; $4916
	call LateStudentCrashImpact ; $491d
	script_wait_move $11 ; $4920
	script_set_anim $11, $02 ; $4925
	script_set_position $10, $1900, $1e00 ; $492c
	sound $96 ; $4937
	script_wait_frames $3c ; $4939
	script_set_position $10, $3f00, $3f00 ; $4940
	script_move_target $11, $1700, $2200 ; $494b
	script_wait_move $11 ; $4956
	script_face_toward $00, $11 ; $495b
	script_speak $11 ; $4963
	script_move_target $11, $1900, $2400 ; $4968
	script_wait_move $11 ; $4973
	ld a, $01 ; $4978
	farcall FarPtr_SetActorNullScript ; $497a
	script_face_toward $00, $11 ; $497d
	script_set_anim $11, $02 ; $4985
	script_wait_idle $11 ; $498c
	script_speak $11 ; $4991
	script_set_position $13, $1a80, $2280 ; $4996
	script_wait_frames $3c ; $49a1
	script_set_position $13, $3f00, $3f00 ; $49a8
	script_move_target $11, $1900, $2300 ; $49b3
	script_wait_move $11 ; $49be
	script_move_target $11, $1a00, $2300 ; $49c3
	script_wait_move $11 ; $49ce
	script_move_target $11, $1a00, $2400 ; $49d3
	script_wait_move $11 ; $49de
	script_move_target $11, $1900, $2400 ; $49e3
	script_wait_move $11 ; $49ee
	script_move_target $11, $1900, $2500 ; $49f3
	script_wait_move $11 ; $49fe
	script_move_target $11, $1a00, $2500 ; $4a03
	script_wait_move $11 ; $4a0e
	script_move_target $11, $1a00, $2400 ; $4a13
	script_wait_move $11 ; $4a1e
	script_move_target $11, $1900, $2400 ; $4a23
	script_wait_move $11 ; $4a2e
	script_face_toward $00, $11 ; $4a33
	script_wait_frames $3c ; $4a3b
	script_set_anim $11, $02 ; $4a42
	script_wait_idle $11 ; $4a49
	script_speak $11 ; $4a4e
	call Func_11_4d68 ; $4a53
	script_facing_lock $11, $01 ; $4a56
	script_set_anim $11, $05 ; $4a5d
	script_wait_frames $14 ; $4a64
	script_jump_velocity $11, $ff80 ; $4a6b
	script_move_target $11, $1b00, $2400 ; $4a73
	script_wait_frames $14 ; $4a7e
	script_face_toward $11, $00 ; $4a85
	script_wait_frames $14 ; $4a8d
	script_set_anim $00, $02 ; $4a94
	script_wait_idle $00 ; $4a9b
	script_set_anim $11, $02 ; $4aa0
	script_wait_idle $11 ; $4aa7
	script_face_toward $00, $11 ; $4aac
	script_move_target $11, $1a00, $2400 ; $4ab4
	script_wait_move $11 ; $4abf
	script_facing_lock $11, $00 ; $4ac4
	script_set_anim $00, $02 ; $4acb
	script_wait_idle $00 ; $4ad2
	script_set_anim $11, $02 ; $4ad7
	script_wait_idle $11 ; $4ade
	script_speak $11 ; $4ae3
	script_set_anim $11, $02 ; $4ae8
	script_wait_idle $11 ; $4aef
Label_11_4af4:
	script_set_text $1857 ; $4af4
	ld a, $11 ; $4afa
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4afc
	farcall FarPtr_RunDialogueYesNoPrompt ; $4aff
	farcall FarPtr_ScriptCloseDialogueWindow ; $4b02
	script_wait_frames $05 ; $4b05
	and a, a ; $4b0c
	jr z, Label_11_4b1d ; $4b0d
	script_set_anim $11, $02 ; $4b0f
	script_speak $11 ; $4b16
	jr Label_11_4af4 ; $4b1b
Label_11_4b1d:
	script_set_text $1859 ; $4b1d
	script_set_anim $11, $03 ; $4b23
	script_wait_idle $11 ; $4b2a
	script_speak $11 ; $4b2f
	script_wait_frames $3c ; $4b34
	script_set_position $0e, $1b80, $21c0 ; $4b3b
	sound $98 ; $4b46
	script_wait_frames $28 ; $4b48
	script_set_position $0e, $3f00, $3f00 ; $4b4f
	script_move_angle $11, $80, $0100 ; $4b5a
	script_wait_move $11 ; $4b64
	script_speak $11 ; $4b69
	script_set_anim $00, $03 ; $4b6e
	script_wait_idle $00 ; $4b75
	script_set_position $0e, $1a80, $21c0 ; $4b7a
	script_wait_frames $3c ; $4b85
	script_set_position $0e, $3f00, $3f00 ; $4b8c
	script_wait_frames $3c ; $4b97
	script_set_position $0f, $1a80, $21c0 ; $4b9e
	sound $97 ; $4ba9
	script_jump_velocity $11, $ff80 ; $4bab
	ld a, $11 ; $4bb3
	farcall FarPtr_ScriptWaitActorJumpDone ; $4bb5
	script_wait_frames $0a ; $4bb8
	script_set_position $0f, $3f00, $3f00 ; $4bbf
	script_speak $11 ; $4bca
	script_set_anim $11, $02 ; $4bcf
	script_wait_idle $11 ; $4bd6
	script_speak $11 ; $4bdb
	script_set_anim $00, $03 ; $4be0
	script_wait_idle $00 ; $4be7
	script_set_anim $11, $03 ; $4bec
	script_wait_idle $11 ; $4bf3
	script_speak $11 ; $4bf8
	script_wait_frames $0a ; $4bfd
	script_set_anim $00, $03 ; $4c04
	script_wait_idle $00 ; $4c0b
	script_wait_frames $3c ; $4c10
	script_player_speed $0060 ; $4c17
	script_face $11, $c0 ; $4c1d
	script_set_anim $11, $02 ; $4c24
	script_wait_idle $11 ; $4c2b
	script_set_position $0f, $1a80, $21c0 ; $4c30
	sound $97 ; $4c3b
	script_wait_frames $28 ; $4c3d
	script_set_position $0f, $3f00, $3f00 ; $4c44
	script_face $11, $c0 ; $4c4f
	script_set_anim $11, $02 ; $4c56
	script_move_player $1800, $0b00 ; $4c5d
	farcall FarPtr_WaitPlayerMoveDone ; $4c67
	script_set_active $11, $00 ; $4c6a
	script_set_position $11, $1900, $0600 ; $4c71
	script_speak $11 ; $4c7c
	script_set_position $11, $1900, $2400 ; $4c81
	script_set_active $11, $02 ; $4c8c
	script_move_player $1800, $2400 ; $4c93
	farcall FarPtr_WaitPlayerMoveDone ; $4c9d
	script_face_toward $00, $11 ; $4ca0
	script_speak $11 ; $4ca8
	script_set_anim $11, $03 ; $4cad
	script_wait_idle $11 ; $4cb4
	script_set_anim $00, $03 ; $4cb9
	script_wait_idle $00 ; $4cc0
	script_jump_velocity $11, $ff80 ; $4cc5
	ld a, $11 ; $4ccd
	farcall FarPtr_ScriptWaitActorJumpDone ; $4ccf
	script_move_target $11, $1800, $3300 ; $4cd2
	script_wait_frames $14 ; $4cdd
	script_face $00, $40 ; $4ce4
	script_wait_frames $5a ; $4ceb
	call AcademyArrivalGreetingScene ; $4cf2
	ret ; $4cf5
LateStudentCrashImpact:
	ld a, $01 ; $4cf6
	farcall FarPtr_SetActorNullScript ; $4cf8
	sound $70 ; $4cfb
	ld a, $03 ; $4cfd
	farcall FarPtr_SetScreenShake ; $4cff
	script_wait_frames $0a ; $4d02
	ld a, $00 ; $4d09
	farcall FarPtr_SetScreenShake ; $4d0b
	script_set_speed $00, $0040 ; $4d0e
	script_move_player $1800, $2400 ; $4d16
	script_move_target $00, $1700, $2400 ; $4d20
	script_jump_velocity $00, $ff00 ; $4d2b
	ld a, $00 ; $4d33
	farcall FarPtr_GetActorStateAddr ; $4d35
	ld c, l ; $4d38
	ld b, h ; $4d39
	ld hl, $0037 ; $4d3a
	add hl, bc ; $4d3d
	ld a, [hl] ; $4d3e
	or a, $40 ; $4d3f
	ld [hl], a ; $4d41
	script_wait_frames $1e ; $4d42
	script_set_anim $00, $02 ; $4d49
	script_wait_idle $00 ; $4d50
	script_wait_frames $1e ; $4d55
	script_set_actor_script $00, $4d8d ; $4d5c
	ret ; $4d67
Func_11_4d68:
	ld a, $00 ; $4d68
	farcall FarPtr_SetActorNullScript ; $4d6a
	script_set_speed $00, $0010 ; $4d6d
	script_jump_velocity $00, $ff80 ; $4d75
	ld a, $00 ; $4d7d
	farcall FarPtr_GetActorStateAddr ; $4d7f
	ld c, l ; $4d82
	ld b, h ; $4d83
	ld hl, $0037 ; $4d84
	add hl, bc ; $4d87
	ld a, [hl] ; $4d88
	xor a, $40 ; $4d89
	ld [hl], a ; $4d8b
	ret ; $4d8c
	INCBIN "data/bank_011/d_4d8d.bin" ; $4d8d, 7 bytes
AcademyArrivalGreetingScene:
	script_player_speed $0010 ; $4d94
	script_set_speed $00, $0018 ; $4d9a
	script_set_speed $12, $0018 ; $4da2
	script_move_player $1800, $1300 ; $4daa
	script_move_target $00, $1800, $2400 ; $4db4
	script_wait_move $00 ; $4dbf
	script_move_target $00, $1800, $1300 ; $4dc4
	script_set_text $01a3 ; $4dcf
	script_wait_frames $78 ; $4dd5
	script_set_position $12, $1800, $0f00 ; $4ddc
	script_wait_move $00 ; $4de7
	ld a, [$c90d] ; $4dec
	or a, a ; $4def
	jr z, Label_11_4df5 ; $4df0
	farcall FarPtr_AdvanceDialogueTextCursor ; $4df2
Label_11_4df5:
	script_speak $12 ; $4df5
	script_set_position $0f, $1940, $11c0 ; $4dfa
	sound $97 ; $4e05
	script_wait_frames $28 ; $4e07
	script_set_position $0f, $3f00, $3f00 ; $4e0e
	script_face_toward $12, $00 ; $4e19
	script_player_speed $0020 ; $4e21
	script_move_target $12, $1800, $1100 ; $4e27
	script_wait_frames $0f ; $4e32
	script_move_player $1800, $1100 ; $4e39
	farcall FarPtr_WaitPlayerMoveDone ; $4e43
	script_wait_frames $3c ; $4e46
	script_face_pair $00, $12 ; $4e4d
	script_wait_frames $1e ; $4e55
	script_set_anim $00, $03 ; $4e5c
	script_wait_idle $00 ; $4e63
	script_wait_frames $0f ; $4e68
	script_set_anim $12, $03 ; $4e6f
	script_wait_idle $12 ; $4e76
	script_set_text $01a5 ; $4e7b
	script_speak $03 ; $4e81
	script_set_position $0e, $1940, $11c0 ; $4e86
	sound $98 ; $4e91
	script_wait_frames $32 ; $4e93
	script_set_position $0e, $3f00, $3f00 ; $4e9a
	script_set_anim $12, $03 ; $4ea5
	script_wait_idle $12 ; $4eac
	script_speak $12 ; $4eb1
	script_wait_frames $0f ; $4eb6
	script_set_anim $12, $02 ; $4ebd
	script_wait_idle $12 ; $4ec4
	ld a, $12 ; $4ec9
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4ecb
	farcall FarPtr_RunDialogueYesNoPrompt ; $4ece
	farcall FarPtr_ScriptCloseDialogueWindow ; $4ed1
	script_wait_frames $05 ; $4ed4
	and a, a ; $4edb
	jr z, Label_11_4ee1 ; $4edc
	farcall FarPtr_AdvanceDialogueTextCursor ; $4ede
Label_11_4ee1:
	ld a, $12 ; $4ee1
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4ee3
	farcall FarPtr_RunDialogueYesNoPrompt ; $4ee6
	farcall FarPtr_ScriptCloseDialogueWindow ; $4ee9
	script_wait_frames $05 ; $4eec
	and a, a ; $4ef3
	jr z, Label_11_4f0c ; $4ef4
	xor a, a ; $4ef6
	ld [wStoryModeShowLocationName], a ; $4ef7
	script_set_text $01ab ; $4efa
	script_speak $12 ; $4f00
	set_flag $05, 6 ; $4f05
	call Func_11_4f1b ; $4f08
	ret ; $4f0b
Label_11_4f0c:
	script_set_text $01aa ; $4f0c
	script_speak $12 ; $4f12
	call FollowGuideIntoAcademy ; $4f17
	ret ; $4f1a
Func_11_4f1b:
	ld a, $f1 ; $4f1b
	ld d, $16 ; $4f1d
	ld e, $10 ; $4f1f
	farcall FarPtr_WriteBehaviorMapCell ; $4f21
	ld a, $f1 ; $4f24
	ld d, $18 ; $4f26
	ld e, $10 ; $4f28
	farcall FarPtr_WriteBehaviorMapCell ; $4f2a
	ld a, $f1 ; $4f2d
	ld d, $16 ; $4f2f
	ld e, $12 ; $4f31
	farcall FarPtr_WriteBehaviorMapCell ; $4f33
	ld a, $f1 ; $4f36
	ld d, $18 ; $4f38
	ld e, $12 ; $4f3a
	farcall FarPtr_WriteBehaviorMapCell ; $4f3c
	ret ; $4f3f
	script_set_anim $12, $02 ; $4f40
	script_wait_idle $12 ; $4f47
	script_move_target $00, $1800, $1300 ; $4f4c
	script_wait_move $00 ; $4f57
	script_face_toward $12, $00 ; $4f5c
	script_set_anim $12, $03 ; $4f64
	script_wait_idle $12 ; $4f6b
	script_set_text $01ac ; $4f70
	script_speak $12 ; $4f76
	script_speak $12 ; $4f7b
	call FollowGuideIntoAcademy ; $4f80
	ret ; $4f83
FollowGuideIntoAcademy:
	script_set_speed $00, $0018 ; $4f84
	script_set_speed $12, $0018 ; $4f8c
	clear_flag $05, 6 ; $4f94
	script_move_target $12, $1800, $0e00 ; $4f97
	script_move_target $00, $1800, $0e00 ; $4fa2
	script_wait_frames $1e ; $4fad
	ld a, $0f ; $4fb4
	ld [$c294], a ; $4fb6
	ld [wStoryModeExitLocationRequest], a ; $4fb9
	ld c, $04 ; $4fbc
	call BeginFadeOut ; $4fbe
	call WaitFadeEnd ; $4fc1
	ret ; $4fc4
	INCBIN "data/bank_011/d_4fc5.bin" ; $4fc5, 10 bytes
Label_11_4fcf:
	ldh a, [hRomBank] ; $4fcf
	ld hl, $537d ; $4fd1
	farcall FarPtr_ScriptRespawnLocationActors ; $4fd4
	farcall FarPtr_BeginCutsceneScriptMode ; $4fd7
	test_flag $05, 7 ; $4fda
	jp z, Label_11_501a ; $4fdd
	ld a, $02 ; $4fe0
	farcall FarPtr_SetActorNullScript ; $4fe2
	script_set_position $02, $3f00, $3f00 ; $4fe5
	ld a, [$c94d] ; $4ff0
	ld d, $58 ; $4ff3
	add a, d ; $4ff5
	ld d, a ; $4ff6
	ld a, $05 ; $4ff7
	farcall FarPtr_GetActorStateAddr ; $4ff9
	ld c, l ; $4ffc
	ld b, h ; $4ffd
	farcall FarPtr_LoadActorObjectDefIfValid ; $4ffe
	script_set_anim $05, $01 ; $5001
	script_set_position $07, $1a00, $1100 ; $5008
	script_face $07, $40 ; $5013
Label_11_501a:
	ld a, [$c90d] ; $501a
	ld d, $56 ; $501d
	add a, d ; $501f
	ld d, a ; $5020
	ld a, $00 ; $5021
	farcall FarPtr_GetActorStateAddr ; $5023
	ld c, l ; $5026
	ld b, h ; $5027
	farcall FarPtr_LoadActorObjectDefIfValid ; $5028
	script_set_anim $00, $01 ; $502b
	script_set_position $00, $1700, $1700 ; $5032
	script_face $00, $c0 ; $503d
	script_move_player_to_actor $03 ; $5044
	farcall FarPtr_WaitPlayerMoveDone ; $504b
	script_fade_in $08 ; $504e
	call WaitFadeEnd ; $5053
	script_wait_frames $3c ; $5056
	script_set_text $01ed ; $505d
	script_speak $03 ; $5063
	test_flag $05, 7 ; $5068
	jp z, Label_11_5158 ; $506b
	script_set_anim $04, $03 ; $506e
	script_set_anim $06, $03 ; $5075
	script_wait_idle $06 ; $507c
	script_wait_frames $1e ; $5081
	script_face_pair $05, $00 ; $5088
	script_wait_frames $1e ; $5090
	script_set_anim $00, $03 ; $5097
	script_set_anim $05, $03 ; $509e
	script_wait_idle $05 ; $50a5
	script_wait_frames $1e ; $50aa
	script_face $05, $c0 ; $50b1
	script_wait_frames $1e ; $50b8
	script_set_anim $00, $03 ; $50bf
	script_set_anim $05, $03 ; $50c6
	script_wait_idle $05 ; $50cd
	script_wait_frames $1e ; $50d2
	script_set_anim $03, $03 ; $50d9
	script_wait_idle $03 ; $50e0
	script_wait_frames $0a ; $50e5
	script_set_anim $07, $02 ; $50ec
	script_wait_idle $07 ; $50f3
	script_speak $07 ; $50f8
	script_set_anim $04, $03 ; $50fd
	script_set_anim $05, $03 ; $5104
	script_set_anim $00, $03 ; $510b
	script_set_anim $06, $03 ; $5112
	script_wait_idle $06 ; $5119
	script_wait_frames $1e ; $511e
	script_face_pair $07, $03 ; $5125
	script_set_anim $03, $03 ; $512d
	script_set_anim $07, $03 ; $5134
	script_wait_idle $07 ; $513b
	script_face $07, $40 ; $5140
	script_face $03, $40 ; $5147
	script_wait_frames $1e ; $514e
	jp Label_11_51d9 ; $5155
Label_11_5158:
	script_set_anim $04, $03 ; $5158
	script_set_anim $05, $03 ; $515f
	script_wait_idle $05 ; $5166
	script_wait_frames $1e ; $516b
	script_face_pair $06, $00 ; $5172
	script_wait_frames $1e ; $517a
	script_set_anim $00, $03 ; $5181
	script_set_anim $06, $03 ; $5188
	script_wait_idle $06 ; $518f
	script_wait_frames $1e ; $5194
	script_face $00, $c0 ; $519b
	script_face $06, $c0 ; $51a2
	script_wait_frames $1e ; $51a9
	script_set_anim $00, $03 ; $51b0
	script_set_anim $06, $03 ; $51b7
	script_wait_idle $06 ; $51be
	script_wait_frames $1e ; $51c3
	script_set_anim $03, $03 ; $51ca
	script_wait_idle $03 ; $51d1
	farcall FarPtr_AdvanceDialogueTextCursor ; $51d6
Label_11_51d9:
	script_speak $03 ; $51d9
	script_wait_frames $1e ; $51de
	script_set_anim $04, $03 ; $51e5
	script_set_anim $05, $03 ; $51ec
	script_set_anim $00, $03 ; $51f3
	script_set_anim $06, $03 ; $51fa
	script_wait_idle $06 ; $5201
	script_wait_frames $14 ; $5206
	script_face_pair $06, $00 ; $520d
	script_face_pair $04, $05 ; $5215
	script_wait_frames $0a ; $521d
	script_facing_lock $00, $01 ; $5224
	script_facing_lock $06, $01 ; $522b
	script_facing_lock $05, $01 ; $5232
	script_facing_lock $04, $01 ; $5239
	script_move_target $00, $1600, $1700 ; $5240
	script_move_target $06, $1a00, $1700 ; $524b
	script_move_target $05, $1500, $1500 ; $5256
	script_move_target $04, $1b00, $1500 ; $5261
	script_wait_move $04 ; $526c
	script_move_player $1800, $2f00 ; $5271
	script_move_target $03, $1800, $1900 ; $527b
	script_wait_move $03 ; $5286
	script_facing_lock $00, $00 ; $528b
	script_facing_lock $06, $00 ; $5292
	script_facing_lock $05, $00 ; $5299
	script_facing_lock $04, $00 ; $52a0
	script_move_target $00, $1600, $2b00 ; $52a7
	script_move_target $06, $1a00, $2b00 ; $52b2
	script_move_target $05, $1500, $2900 ; $52bd
	script_move_target $04, $1b00, $2900 ; $52c8
	script_move_target $03, $1800, $2d00 ; $52d3
	script_wait_move $03 ; $52de
	script_set_anim $08, $03 ; $52e3
	script_move_target $00, $1700, $2f00 ; $52ea
	script_move_target $06, $1900, $2f00 ; $52f5
	script_move_target $05, $1700, $2d00 ; $5300
	script_move_target $04, $1900, $2d00 ; $530b
	script_move_target $03, $1800, $3100 ; $5316
	script_wait_move $03 ; $5321
	script_move_target $00, $1700, $3b00 ; $5326
	script_move_target $06, $1900, $3b00 ; $5331
	script_move_target $05, $1700, $3900 ; $533c
	script_move_target $04, $1900, $3900 ; $5347
	script_move_target $03, $1800, $3d00 ; $5352
	script_wait_move $03 ; $535d
	ld c, $04 ; $5362
	call BeginFadeOut ; $5364
	call WaitFadeEnd ; $5367
	ld a, $1b ; $536a
	ld [wStoryModeCurrentLocation], a ; $536c
	ld a, $01 ; $536f
	ld [wStoryModeEntryPoint], a ; $5371
	ld a, $ff ; $5374
	ld [$c294], a ; $5376
	ld [wStoryModeExitLocationRequest], a ; $5379
	ret ; $537c
	; $537d, 94 bytes (bytes:14)
	db $00, $00, $a9, $7b, $00, $18, $00, $11, $40, $00, $63, $01, $00, $00 ; 0x00
	db $00, $00, $a9, $7b, $00, $1a, $00, $15, $c0, $00, $5c, $01, $00, $00 ; 0x0e
	db $00, $00, $a9, $7b, $00, $16, $00, $15, $c0, $00, $5b, $01, $00, $00 ; 0x1c
	db $00, $00, $a9, $7b, $00, $19, $00, $17, $c0, $00, $5a, $01, $00, $00 ; 0x2a
	db $00, $00, $a9, $7b, $00, $01, $00, $19, $c0, $00, $4a, $01, $00, $00 ; 0x38
	db $00, $00, $a9, $7b, $00, $15, $00, $2f, $00, $00, $30, $01, $03, $00 ; 0x46
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x54
Label_11_53db:
	ldh a, [hRomBank] ; $53db
	ld hl, $546a ; $53dd
	farcall FarPtr_ScriptRespawnLocationActors ; $53e0
	farcall FarPtr_BeginCutsceneScriptMode ; $53e3
	script_player_speed $00ff ; $53e6
	script_move_player $1800, $2f00 ; $53ec
	farcall FarPtr_WaitPlayerMoveDone ; $53f6
	test_flag $05, 7 ; $53f9
	jp z, Label_11_5415 ; $53fc
	script_set_position $02, $1800, $1d00 ; $53ff
	script_move_target $02, $1800, $3900 ; $540a
Label_11_5415:
	script_set_position $00, $1800, $1f00 ; $5415
	script_move_target $00, $1800, $3b00 ; $5420
	xor a, a ; $542b
	ld [wStoryModeShowLocationName], a ; $542c
	script_fade_in $04 ; $542f
	call WaitFadeEnd ; $5434
	script_wait_frames $3c ; $5437
	script_set_anim $03, $03 ; $543e
	script_wait_idle $03 ; $5445
	script_wait_move $00 ; $544a
	ld c, $04 ; $544f
	call BeginFadeOut ; $5451
	call WaitFadeEnd ; $5454
	ld a, $1b ; $5457
	ld [wStoryModeCurrentLocation], a ; $5459
	ld a, $0f ; $545c
	ld [wStoryModeEntryPoint], a ; $545e
	ld a, $ff ; $5461
	ld [$c294], a ; $5463
	ld [wStoryModeExitLocationRequest], a ; $5466
	ret ; $5469
	; $546a, 24 bytes (bytes:14)
	db $00, $00, $a9, $7b, $00, $15, $00, $2f, $00, $00, $30, $01, $03, $00 ; 0x00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x0e
Func_11_5482:
	test_flag $05, 7 ; $5482
	jr nz, Label_11_548d ; $5485
	test_flag $16, 0 ; $5487
	jr nz, Label_11_5493 ; $548a
	ret ; $548c
Label_11_548d:
	test_flag $16, 1 ; $548d
	jr nz, Label_11_5493 ; $5490
	ret ; $5492
Label_11_5493:
	ld a, $33 ; $5493
	ld d, $16 ; $5495
	ld e, $34 ; $5497
	farcall FarPtr_WriteBehaviorMapCell ; $5499
	ld a, $33 ; $549c
	ld d, $18 ; $549e
	ld e, $34 ; $54a0
	farcall FarPtr_WriteBehaviorMapCell ; $54a2
	ret ; $54a5
Func_11_54a6:
	ld a, [$c2b0] ; $54a6
	cp a, $06 ; $54a9
	jr c, Label_11_54bf ; $54ab
	script_set_position $14, $1500, $3000 ; $54ad
	script_face $14, $00 ; $54b8
Label_11_54bf:
	ret ; $54bf
JuniorClassCourtDoublesScene_11:
	; $54c0, 14 bytes (records:2)
	dw $558e ; record 0
	dw $559f ; record 1
	dw $54ce ; record 2
	dw $581a ; record 3
	dw $5a1e ; record 4
	dw $5a20 ; record 5
	dw $5a22 ; record 6
	; $54ce, 192 bytes (bytes:14)
	db $00, $00, $a9, $7b, $00, $13, $00, $13, $40, $00, $37, $01, $00, $00 ; 0x00
	db $00, $00, $a9, $7b, $00, $23, $00, $17, $80, $00, $68, $01, $05, $00 ; 0x0e
	db $00, $00, $a9, $7b, $00, $05, $00, $15, $00, $00, $6b, $01, $04, $00 ; 0x1c
	db $00, $00, $a9, $7b, $00, $21, $00, $15, $40, $00, $67, $01, $07, $00 ; 0x2a
	db $00, $00, $a9, $7b, $00, $05, $00, $13, $00, $00, $6a, $01, $07, $00 ; 0x38
	db $00, $00, $86, $7d, $00, $1b, $00, $13, $40, $00, $66, $01, $03, $00 ; 0x46
	db $00, $00, $1f, $68, $00, $1b, $00, $15, $c0, $00, $65, $01, $06, $00 ; 0x54
	db $00, $00, $a9, $7b, $00, $37, $00, $07, $80, $00, $64, $01, $04, $00 ; 0x62
	db $00, $00, $a9, $7b, $00, $35, $00, $07, $00, $00, $69, $01, $03, $00 ; 0x70
	db $00, $00, $a9, $7c, $00, $08, $00, $0b, $40, $00, $54, $01, $05, $00 ; 0x7e
	db $00, $00, $10, $7d, $00, $0c, $00, $17, $c0, $00, $54, $01, $00, $00 ; 0x8c
	db $00, $00, $df, $7b, $00, $2a, $00, $0b, $40, $00, $54, $01, $00, $00 ; 0x9a
	db $00, $00, $42, $7c, $00, $2e, $00, $17, $c0, $00, $54, $01, $05, $00 ; 0xa8
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xb6
	; $558e, 17 bytes (bytes:16)
	db $01, $c0, $00, $13, $00, $1d, $fd, $42, $09, $c0, $00, $37, $00, $19, $00, $00 ; 0x00
	db $ff ; 0x10
	; $559f, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $ff01, $0000, $7bd1, $0508 ; record 0
	dw $ff0f, $0000, $7bd1, $0f0c ; record 1
	db $ff
	script_set_text $0869 ; $55b0
	test_flag $08, 2 ; $55b6
	jr nz, Label_11_55c6 ; $55b9
	farcall FarPtr_AdvanceDialogueTextCursor ; $55bb
	test_flag $08, 1 ; $55be
	jr nz, Label_11_55c6 ; $55c1
	farcall FarPtr_AdvanceDialogueTextCursor ; $55c3
Label_11_55c6:
	script_speak $04 ; $55c6
	ret ; $55cb
	script_set_text $0878 ; $55cc
	test_flag $08, 1 ; $55d2
	jr nz, Label_11_55e2 ; $55d5
	farcall FarPtr_AdvanceDialogueTextCursor ; $55d7
	test_flag $08, 0 ; $55da
	jr nz, Label_11_55e2 ; $55dd
	farcall FarPtr_AdvanceDialogueTextCursor ; $55df
Label_11_55e2:
	script_speak $05 ; $55e2
	ret ; $55e7
	script_set_text $086c ; $55e8
	test_flag $08, 2 ; $55ee
	jr nz, Label_11_5616 ; $55f1
	farcall FarPtr_AdvanceDialogueTextCursor ; $55f3
	test_flag $08, 1 ; $55f6
	jr nz, Label_11_5616 ; $55f9
	farcall FarPtr_AdvanceDialogueTextCursor ; $55fb
	ld a, $06 ; $55fe
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5600
	farcall FarPtr_RunDialogueYesNoPrompt ; $5603
	farcall FarPtr_ScriptCloseDialogueWindow ; $5606
	script_wait_frames $05 ; $5609
	and a, a ; $5610
	jr z, Label_11_5616 ; $5611
	farcall FarPtr_AdvanceDialogueTextCursor ; $5613
Label_11_5616:
	script_speak $06 ; $5616
	ret ; $561b
	script_set_text $087b ; $561c
	test_flag $08, 1 ; $5622
	jr nz, Label_11_5632 ; $5625
	farcall FarPtr_AdvanceDialogueTextCursor ; $5627
	test_flag $08, 0 ; $562a
	jr nz, Label_11_5632 ; $562d
	farcall FarPtr_AdvanceDialogueTextCursor ; $562f
Label_11_5632:
	script_speak $07 ; $5632
	ret ; $5637
	script_set_text $087e ; $5638
	test_flag $08, 0 ; $563e
	jr nz, Label_11_5646 ; $5641
	farcall FarPtr_AdvanceDialogueTextCursor ; $5643
Label_11_5646:
	script_speak $08 ; $5646
	ret ; $564b
	script_set_text $0880 ; $564c
	test_flag $08, 0 ; $5652
	jr nz, Label_11_5646 ; $5655
	farcall FarPtr_AdvanceDialogueTextCursor ; $5657
	script_speak $09 ; $565a
	ret ; $565f
Label_11_5660:
	script_speak $0a ; $5660
	script_face_pair $0b, $0a ; $5665
	ret ; $566d
Label_11_566e:
	script_set_text $0887 ; $566e
	test_flag $08, 0 ; $5674
	jp nz, Label_11_5660 ; $5677
	script_set_text $0883 ; $567a
	ld a, $0a ; $5680
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5682
	farcall FarPtr_RunDialogueYesNoPrompt ; $5685
	farcall FarPtr_ScriptCloseDialogueWindow ; $5688
	script_wait_frames $05 ; $568b
	and a, a ; $5692
	jr nz, Label_11_5660 ; $5693
	farcall FarPtr_AdvanceDialogueTextCursor ; $5695
	script_face_toward $00, $0b ; $5698
	ld a, $0a ; $56a0
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $56a2
	farcall FarPtr_RunDialogueYesNoPrompt ; $56a5
	farcall FarPtr_ScriptCloseDialogueWindow ; $56a8
	script_wait_frames $05 ; $56ab
	and a, a ; $56b2
	jr nz, Label_11_5660 ; $56b3
	script_set_anim $00, $03 ; $56b5
	ld a, $02 ; $56bc
	farcall FarPtr_SetActorNullScript ; $56be
	script_set_speed $02, $0020 ; $56c1
	script_set_speed $00, $0020 ; $56c9
	script_set_actor_script $00, $5bc6 ; $56d1
	script_wait_frames $14 ; $56dc
	script_set_actor_script $02, $5be0 ; $56e3
	script_wait_frames $1e ; $56ee
	script_move_player $3500, $1100 ; $56f5
	script_move_target $0a, $3700, $0d00 ; $56ff
	script_move_target $0b, $3500, $0900 ; $570a
	script_wait_move $0a ; $5715
	script_face $0a, $40 ; $571a
	script_face $0b, $40 ; $5721
	ld a, $00 ; $5728
	farcall FarPtr_WaitActorScriptDone ; $572a
	ld hl, wStoryModePlayersXPosition ; $572d
	ld de, wStoryModeSpawnPosition ; $5730
	ld bc, $0005 ; $5733
	call CopyMemoryBC ; $5736
	ld a, $ff ; $5739
	ld [wStoryModeEntryPoint], a ; $573b
	ld [$c294], a ; $573e
	ld [wStoryModeExitLocationRequest], a ; $5741
	farcall FarPtr_WaitPlayerMoveDone ; $5744
	script_set_anim $0a, $03 ; $5747
	script_set_anim $00, $03 ; $574e
	script_wait_idle $00 ; $5755
	farcall FarPtr_InitStoryMatchSettings ; $575a
	load_match_settings $0100 ; $575d
	farcall FarPtr_RunStoryMatch ; $576a
	farcall FarPtr_RestoreOverworldAfterMatch ; $576d
	ret ; $5770
	script_set_text $0888 ; $5771
	test_flag $08, 0 ; $5777
	jr nz, Label_11_57c6 ; $577a
	script_set_text $0882 ; $577c
	script_speak $0b ; $5782
	script_face_toward $00, $0a ; $5787
	script_set_anim $0a, $02 ; $578f
	script_wait_idle $0a ; $5796
	jp Label_11_566e ; $579b
	script_set_text $0852 ; $579e
	script_face_toward $00, $0a ; $57a4
	script_set_anim $0a, $04 ; $57ac
	script_wait_idle $0a ; $57b3
	script_speak $0a ; $57b8
	script_face_toward $0b, $0a ; $57bd
	ret ; $57c5
Label_11_57c6:
	script_speak $0b ; $57c6
	ret ; $57cb
	script_set_text $0897 ; $57cc
	script_speak $0a ; $57d2
	script_set_anim $0a, $04 ; $57d7
	script_wait_idle $0a ; $57de
	script_speak $0a ; $57e3
	ret ; $57e8
	script_set_speed $00, $0008 ; $57e9
	script_facing_lock $00, $01 ; $57f1
	script_move_target $00, $1300, $1500 ; $57f8
	script_wait_move $00 ; $5803
	script_facing_lock $00, $00 ; $5808
	script_face $00, $c0 ; $580f
	call OfferDoublesRankingMatch ; $5816
	ret ; $5819
	; $581a, 81 bytes (records:8)
; 10 records x 8 bytes
	dw $4003, $0000, $57e9, $0003 ; record 0
	dw $ff03, $0000, $5816, $0003 ; record 1
	dw $ff04, $0000, $55b0, $0003 ; record 2
	dw $ff05, $0000, $55cc, $0003 ; record 3
	dw $ff06, $0000, $55e8, $0001 ; record 4
	dw $ff07, $0000, $561c, $0003 ; record 5
	dw $ff08, $0000, $5638, $001b ; record 6
	dw $ff09, $0000, $564c, $001b ; record 7
	dw $ff0a, $0000, $566e, $0003 ; record 8
	dw $ff0b, $0000, $5771, $0003 ; record 9
	db $ff
	; $586b, 73 bytes (records:8)
; 9 records x 8 bytes
	dw $ff03, $0000, $0889, $0003 ; record 0
	dw $ff04, $0000, $0891, $0001 ; record 1
	dw $ff05, $0000, $0893, $0003 ; record 2
	dw $ff06, $0000, $0892, $0011 ; record 3
	dw $ff07, $0000, $0894, $0003 ; record 4
	dw $ff08, $0000, $0895, $001b ; record 5
	dw $ff09, $0000, $0896, $001b ; record 6
	dw $ff0a, $0000, $57cc, $0003 ; record 7
	dw $ff0b, $0000, $0899, $0003 ; record 8
	db $ff
	; $58b4, 73 bytes (records:8)
; 9 records x 8 bytes
	dw $ff03, $0000, $08a2, $0003 ; record 0
	dw $ff04, $0000, $08a3, $0001 ; record 1
	dw $ff05, $0000, $08a5, $0003 ; record 2
	dw $ff06, $0000, $08a4, $0011 ; record 3
	dw $ff07, $0000, $08a6, $0003 ; record 4
	dw $ff08, $0000, $08a7, $001b ; record 5
	dw $ff09, $0000, $08a8, $001b ; record 6
	dw $ff0a, $0000, $08a9, $0001 ; record 7
	dw $ff0b, $0000, $08aa, $0001 ; record 8
	db $ff
	; $58fd, 73 bytes (records:8)
; 9 records x 8 bytes
	dw $ff03, $0000, $08b6, $0003 ; record 0
	dw $ff04, $0000, $08b7, $0003 ; record 1
	dw $ff05, $0000, $08b9, $0003 ; record 2
	dw $ff06, $0000, $08b8, $0011 ; record 3
	dw $ff07, $0000, $5946, $0003 ; record 4
	dw $ff08, $0000, $08bd, $0013 ; record 5
	dw $ff09, $0000, $08be, $001b ; record 6
	dw $ff0a, $0000, $5990, $0003 ; record 7
	dw $ff0b, $0000, $08c3, $0003 ; record 8
	db $ff
	script_set_text $08ba ; $5946
	ld a, $07 ; $594c
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $594e
	farcall FarPtr_RunDialogueYesNoPrompt ; $5951
	farcall FarPtr_ScriptCloseDialogueWindow ; $5954
	script_wait_frames $05 ; $5957
	and a, a ; $595e
	jp z, Label_11_5965 ; $595f
	farcall FarPtr_AdvanceDialogueTextCursor ; $5962
Label_11_5965:
	script_speak $07 ; $5965
	ret ; $596a
	script_set_text $0c18 ; $596b
	ld a, $07 ; $5971
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5973
	farcall FarPtr_RunDialogueYesNoPrompt ; $5976
	farcall FarPtr_ScriptCloseDialogueWindow ; $5979
	script_wait_frames $05 ; $597c
	and a, a ; $5983
	jp z, Label_11_598a ; $5984
	farcall FarPtr_AdvanceDialogueTextCursor ; $5987
Label_11_598a:
	script_speak $07 ; $598a
	ret ; $598f
	script_set_text $08bf ; $5990
	script_speak $0a ; $5996
	set_flag $10, 2 ; $599b
	ret ; $599e
	; $599f, 73 bytes (records:8)
; 9 records x 8 bytes
	dw $ff03, $0000, $0c14, $0001 ; record 0
	dw $ff04, $0000, $0c15, $0003 ; record 1
	dw $ff05, $0000, $0c17, $0003 ; record 2
	dw $ff06, $0000, $0c16, $0011 ; record 3
	dw $ff07, $0000, $596b, $0003 ; record 4
	dw $ff08, $0000, $0c1b, $0013 ; record 5
	dw $ff09, $0000, $0c1c, $001b ; record 6
	dw $ff0a, $0000, $59e8, $0003 ; record 7
	dw $ff0b, $0000, $0c1d, $0003 ; record 8
	db $ff
	test_flag $10, 2 ; $59e8
	jr nz, Label_11_59f9 ; $59eb
	script_set_text $0c0f ; $59ed
	script_speak $0a ; $59f3
	ret ; $59f8
Label_11_59f9:
	script_set_text $0c1e ; $59f9
	ld a, $0a ; $59ff
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5a01
	farcall FarPtr_RunDialogueYesNoPrompt ; $5a04
	farcall FarPtr_ScriptCloseDialogueWindow ; $5a07
	script_wait_frames $05 ; $5a0a
	and a, a ; $5a11
	jp z, Label_11_5a18 ; $5a12
	farcall FarPtr_AdvanceDialogueTextCursor ; $5a15
Label_11_5a18:
	script_speak $0a ; $5a18
	ret ; $5a1d
	INCBIN "data/bank_011/d_5a1e.bin" ; $5a1e, 4 bytes
	test_flag $08, 2 ; $5a22
	jr nz, Label_11_5a66 ; $5a25
	test_flag $08, 0 ; $5a27
	jr z, Label_11_5a66 ; $5a2a
	script_set_position $08, $2500, $0900 ; $5a2c
	script_face $08, $00 ; $5a37
	script_set_actor_script $08, ActorObjDef_11_7ba9 ; $5a3e
	script_set_position $09, $2500, $0b00 ; $5a49
	script_face $09, $00 ; $5a54
	script_set_actor_script $09, ActorObjDef_11_7ba9 ; $5a5b
Label_11_5a66:
	ld a, [wStoryModeEntryPoint] ; $5a66
	cp a, $0f ; $5a69
	jp z, Label_11_5d38 ; $5a6b
	cp a, $0e ; $5a6e
	jp z, Label_11_5d85 ; $5a70
	cp a, $0d ; $5a73
	jp z, Label_11_5d9b ; $5a75
	test_flag $16, 1 ; $5a78
	jr nz, Label_11_5a8d ; $5a7b
	test_flag $15, 7 ; $5a7d
	jr nz, Label_11_5aad ; $5a80
	test_flag $08, 6 ; $5a82
	jr nz, Label_11_5acd ; $5a85
	test_flag $08, 2 ; $5a87
	jr nz, Label_11_5aed ; $5a8a
	ret ; $5a8c
Label_11_5a8d:
	ld hl, $599f ; $5a8d
	ld de, $000c ; $5a90
	farcall FarPtr_WriteStoryStateWord ; $5a93
	script_set_position $06, $2000, $1900 ; $5a96
	script_set_actor_script $06, $7bb3 ; $5aa1
	ret ; $5aac
Label_11_5aad:
	ld hl, $58fd ; $5aad
	ld de, $000c ; $5ab0
	farcall FarPtr_WriteStoryStateWord ; $5ab3
	script_set_position $06, $2000, $1900 ; $5ab6
	script_set_actor_script $06, $7bb3 ; $5ac1
	ret ; $5acc
Label_11_5acd:
	ld hl, $58b4 ; $5acd
	ld de, $000c ; $5ad0
	farcall FarPtr_WriteStoryStateWord ; $5ad3
	script_set_position $06, $2000, $1900 ; $5ad6
	script_set_actor_script $06, $7bb3 ; $5ae1
	ret ; $5aec
Label_11_5aed:
	ld hl, $586b ; $5aed
	ld de, $000c ; $5af0
	farcall FarPtr_WriteStoryStateWord ; $5af3
	script_set_position $06, $2000, $1900 ; $5af6
	script_set_actor_script $06, $7bb3 ; $5b01
	script_face $0a, $40 ; $5b0c
	ret ; $5b13
	INCBIN "data/bank_011/d_5b14.bin" ; $5b14, 548 bytes
Label_11_5d38:
	wram_bank $04 ; $5d38
	ld a, [wMatchExitRequest] ; $5d3e
	cp a, $01 ; $5d41
	jr z, Label_11_5d4d ; $5d43
	ld a, [wMatchWinLoseFlag] ; $5d45
	cp a, $01 ; $5d48
	jp z, Label_11_5d85 ; $5d4a
Label_11_5d4d:
	script_player_speed $0040 ; $5d4d
	script_move_player $1300, $1500 ; $5d53
	script_set_position $00, $1300, $1500 ; $5d5d
	script_set_position $02, $1300, $1700 ; $5d68
	script_face $00, $c0 ; $5d73
	script_face $02, $c0 ; $5d7a
	farcall FarPtr_WaitPlayerMoveDone ; $5d81
	ret ; $5d84
Label_11_5d85:
	ld a, $0c ; $5d85
	ld [wStoryModeCurrentLocation], a ; $5d87
	ld a, $0d ; $5d8a
	ld [wStoryModeEntryPoint], a ; $5d8c
	ld a, $ff ; $5d8f
	ld [$c294], a ; $5d91
	ld [wStoryModeExitLocationRequest], a ; $5d94
	farcall FarPtr_StubNop_1e ; $5d97
	ret ; $5d9a
Label_11_5d9b:
	xor a, a ; $5d9b
	ld [wStoryModeShowLocationName], a ; $5d9c
	ld a, $02 ; $5d9f
	farcall FarPtr_SetActorNullScript ; $5da1
	script_player_speed $0040 ; $5da4
	ld a, [$c8f7] ; $5daa
	sub a, $02 ; $5dad
	ld a, a ; $5daf
	rst Rst00 ; $5db0
	dw Label_11_5db7 ; $5db1 jumptable
	dw Label_11_5ec0 ; $5db3 jumptable
	dw Label_11_5fbd ; $5db5 jumptable
Label_11_5db7:
	set_flag $08, 0 ; $5db7
	script_player_speed $0040 ; $5dba
	script_move_player $1900, $1100 ; $5dc0
	ld a, $08 ; $5dca
	farcall FarPtr_SetActorNullScript ; $5dcc
	ld a, $09 ; $5dcf
	farcall FarPtr_SetActorNullScript ; $5dd1
	script_set_anim $08, $01 ; $5dd4
	script_set_anim $09, $01 ; $5ddb
	script_set_position $08, $1900, $0d00 ; $5de2
	script_set_position $09, $1b00, $0d00 ; $5ded
	script_set_position $00, $1b00, $1500 ; $5df8
	script_set_position $02, $1900, $1500 ; $5e03
	script_face $00, $c0 ; $5e0e
	script_face $02, $c0 ; $5e15
	script_face $08, $40 ; $5e1c
	script_face $09, $40 ; $5e23
	script_face $03, $00 ; $5e2a
	farcall FarPtr_WaitPlayerMoveDone ; $5e31
	script_fade_in $04 ; $5e34
	call WaitFadeEnd ; $5e39
	script_set_text $0865 ; $5e3c
	script_set_anim $08, $02 ; $5e42
	script_speak $08 ; $5e49
	script_set_anim $09, $04 ; $5e4e
	script_speak $09 ; $5e55
	script_jump_velocity $03, $ff80 ; $5e5a
	ld a, $03 ; $5e62
	farcall FarPtr_ScriptWaitActorJumpDone ; $5e64
	script_speak $03 ; $5e67
	script_set_actor_script $08, $5b28 ; $5e6c
	script_set_actor_script $09, $5b56 ; $5e77
	script_move_target $00, $1300, $1700 ; $5e82
	script_move_target $02, $1300, $1500 ; $5e8d
	script_face $03, $40 ; $5e98
	script_wait_move $00 ; $5e9f
	script_face $00, $40 ; $5ea4
	script_wait_frames $28 ; $5eab
	ld a, $02 ; $5eb2
	farcall FarPtr_GetActorStateAddr ; $5eb4
	ld c, l ; $5eb7
	ld b, h ; $5eb8
	ld de, $d000 ; $5eb9
	farcall FarPtr_04_20 ; $5ebc
	ret ; $5ebf
Label_11_5ec0:
	set_flag $08, 1 ; $5ec0
	call Func_11_7af7 ; $5ec3
	script_player_speed $0040 ; $5ec6
	script_move_player $0b00, $0f00 ; $5ecc
	script_set_position $07, $0b00, $0d00 ; $5ed6
	script_set_position $05, $0900, $0d00 ; $5ee1
	script_set_position $00, $0900, $1500 ; $5eec
	script_set_position $02, $0b00, $1900 ; $5ef7
	script_face $00, $c0 ; $5f02
	script_face $02, $c0 ; $5f09
	script_face $07, $40 ; $5f10
	script_face $05, $40 ; $5f17
	script_face $03, $80 ; $5f1e
	farcall FarPtr_WaitPlayerMoveDone ; $5f25
	script_fade_in $04 ; $5f28
	call WaitFadeEnd ; $5f2d
	script_set_text $0865 ; $5f30
	script_set_anim $07, $02 ; $5f36
	script_speak $07 ; $5f3d
	script_set_anim $05, $04 ; $5f42
	script_speak $05 ; $5f49
	script_set_text $0868 ; $5f4e
	script_jump_velocity $03, $ff80 ; $5f54
	ld a, $03 ; $5f5c
	farcall FarPtr_ScriptWaitActorJumpDone ; $5f5e
	script_speak $03 ; $5f61
	script_set_actor_script $07, $5c14 ; $5f66
	script_set_actor_script $05, $5c5f ; $5f71
	script_move_target $00, $1300, $1700 ; $5f7c
	script_move_target $02, $1300, $1500 ; $5f87
	call Func_11_7b6b ; $5f92
	script_face $03, $40 ; $5f95
	script_wait_frames $3c ; $5f9c
	script_wait_move $00 ; $5fa3
	script_face $00, $40 ; $5fa8
	ld a, $02 ; $5faf
	farcall FarPtr_GetActorStateAddr ; $5fb1
	ld c, l ; $5fb4
	ld b, h ; $5fb5
	ld de, $d000 ; $5fb6
	farcall FarPtr_04_20 ; $5fb9
	ret ; $5fbc
Label_11_5fbd:
	set_flag $08, 2 ; $5fbd
	script_player_speed $0040 ; $5fc0
	script_move_player $1900, $0d00 ; $5fc6
	script_set_position $08, $2500, $0900 ; $5fd0
	script_face $08, $00 ; $5fdb
	script_set_actor_script $08, ActorObjDef_11_7ba9 ; $5fe2
	script_set_position $09, $2500, $0b00 ; $5fed
	script_face $09, $00 ; $5ff8
	script_set_position $03, $1300, $1f00 ; $5fff
	script_set_position $04, $1900, $0e00 ; $600a
	script_set_position $06, $1b00, $0e00 ; $6015
	script_set_position $00, $1b00, $1300 ; $6020
	script_set_position $02, $1900, $1300 ; $602b
	script_face $00, $c0 ; $6036
	script_face $02, $c0 ; $603d
	script_face $04, $40 ; $6044
	script_face $06, $40 ; $604b
	script_face $03, $c0 ; $6052
	farcall FarPtr_WaitPlayerMoveDone ; $6059
	script_fade_in $04 ; $605c
	call WaitFadeEnd ; $6061
	script_wait_frames $1e ; $6064
	script_set_text $0871 ; $606b
	script_set_anim $04, $02 ; $6071
	script_speak $04 ; $6078
	script_set_anim $06, $04 ; $607d
	script_speak $06 ; $6084
	script_set_anim $03, $03 ; $6089
	script_speak $03 ; $6090
	script_set_anim $04, $02 ; $6095
	script_set_anim $06, $02 ; $609c
	script_set_anim $00, $02 ; $60a3
	script_set_anim $02, $02 ; $60aa
	script_wait_frames $1e ; $60b1
	script_face $00, $40 ; $60b8
	script_face $02, $40 ; $60bf
	script_player_speed $0010 ; $60c6
	script_set_speed $03, $0010 ; $60cc
	script_move_player $1500, $1700 ; $60d4
	farcall FarPtr_WaitPlayerMoveDone ; $60de
	script_move_target $03, $1300, $1b00 ; $60e1
	script_wait_move $03 ; $60ec
	farcall FarPtr_WaitPlayerMoveDone ; $60f1
	script_move_player $1a00, $1300 ; $60f4
	script_move_target $03, $1a00, $1700 ; $60fe
	script_wait_move $03 ; $6109
	script_face $03, $c0 ; $610e
	script_set_anim $03, $02 ; $6115
	script_wait_idle $03 ; $611c
	script_speak $03 ; $6121
	script_face_pair $02, $00 ; $6126
	script_wait_frames $1e ; $612e
	script_face $00, $40 ; $6135
	script_face $02, $40 ; $613c
	script_set_anim $00, $03 ; $6143
	script_set_anim $02, $03 ; $614a
	script_wait_idle $02 ; $6151
	script_wait_frames $1e ; $6156
	script_set_text $0875 ; $615d
	script_set_anim $03, $03 ; $6163
	script_wait_idle $03 ; $616a
	script_speak $03 ; $616f
	script_move_target $03, $1b00, $1500 ; $6174
	script_wait_move $03 ; $617f
	script_speak $00 ; $6184
	script_wait_frames $1e ; $6189
	script_set_anim $03, $02 ; $6190
	script_speak $03 ; $6197
	script_set_anim $00, $03 ; $619c
	script_set_anim $02, $03 ; $61a3
	script_wait_idle $02 ; $61aa
	script_set_anim $03, $03 ; $61af
	script_wait_idle $03 ; $61b6
	script_face_pair $06, $04 ; $61bb
	script_wait_frames $1e ; $61c3
	script_face $04, $40 ; $61ca
	script_face $06, $40 ; $61d1
	script_set_anim $06, $02 ; $61d8
	script_speak $06 ; $61df
	script_face $00, $c0 ; $61e4
	script_face $02, $c0 ; $61eb
	script_set_anim $04, $03 ; $61f2
	script_wait_idle $04 ; $61f9
	script_speak $06 ; $61fe
	script_face_pair $02, $00 ; $6203
	script_wait_frames $14 ; $620b
	script_set_anim $00, $02 ; $6212
	script_set_anim $02, $02 ; $6219
	script_wait_idle $02 ; $6220
	script_wait_frames $1e ; $6225
	script_face $00, $c0 ; $622c
	script_face $02, $c0 ; $6233
	script_set_anim $00, $03 ; $623a
	script_set_anim $02, $03 ; $6241
	script_wait_idle $02 ; $6248
	script_wait_frames $1e ; $624d
	script_set_anim $04, $03 ; $6254
	script_set_anim $06, $03 ; $625b
	script_wait_idle $06 ; $6262
	script_wait_frames $3c ; $6267
	script_set_anim $03, $03 ; $626e
	ld a, $0c ; $6275
	ld [wStoryModeCurrentLocation], a ; $6277
	ld a, $01 ; $627a
	ld [wStoryModeEntryPoint], a ; $627c
	ld a, $ff ; $627f
	ld [$c294], a ; $6281
	ld [wStoryModeExitLocationRequest], a ; $6284
	script_wait_frames $3c ; $6287
	ld c, $04 ; $628e
	call BeginFadeOut ; $6290
	call WaitFadeEnd ; $6293
	script_wait_frames $1e ; $6296
	ret ; $629d
OfferDoublesRankingMatch:
	script_set_text $085a ; $629e
	ld a, $03 ; $62a4
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $62a6
	farcall FarPtr_RunDialogueYesNoPrompt ; $62a9
	farcall FarPtr_ScriptCloseDialogueWindow ; $62ac
	script_wait_frames $05 ; $62af
	and a, a ; $62b6
	jp nz, Label_11_634b ; $62b7
	script_set_speed $00, $0010 ; $62ba
	script_set_speed $02, $0010 ; $62c2
	script_move_target $00, $1300, $1500 ; $62ca
	script_move_target $02, $1300, $1700 ; $62d5
	farcall FarPtr_AdvanceDialogueTextCursor ; $62e0
	test_flag $08, 0 ; $62e3
	jr z, Label_11_62fb ; $62e6
	farcall FarPtr_AdvanceDialogueTextCursor ; $62e8
	test_flag $08, 1 ; $62eb
	jr z, Label_11_62fb ; $62ee
	farcall FarPtr_AdvanceDialogueTextCursor ; $62f0
	test_flag $08, 2 ; $62f3
	jr z, Label_11_62fb ; $62f6
	farcall FarPtr_AdvanceDialogueTextCursor ; $62f8
Label_11_62fb:
	script_wait_move $00 ; $62fb
	script_face $00, $c0 ; $6300
	script_face $03, $40 ; $6307
	script_move_target $02, $1300, $1700 ; $630e
	script_wait_move $02 ; $6319
	script_face $02, $c0 ; $631e
	script_speak $03 ; $6325
	call DrawDoublesRankingOpponentInfo ; $632a
	script_face $00, $c0 ; $632d
	script_wait_frames $0f ; $6334
	script_set_anim $03, $02 ; $633b
	script_wait_idle $03 ; $6342
	call PromptChallengeRankingOpponent ; $6347
	ret ; $634a
Label_11_634b:
	script_speak $03 ; $634b
	ret ; $6350
DrawDoublesRankingOpponentInfo:
	test_flag $08, 0 ; $6351
	jp z, Label_11_6364 ; $6354
	test_flag $08, 1 ; $6357
	jp z, Label_11_6432 ; $635a
	test_flag $08, 2 ; $635d
	jp z, Label_11_64db ; $6360
	ret ; $6363
Label_11_6364:
	script_player_speed $0020 ; $6364
	script_face $03, $00 ; $636a
	script_move_player_to_actor $08 ; $6371
	farcall FarPtr_WaitPlayerMoveDone ; $6378
	ld a, $08 ; $637b
	farcall FarPtr_SetActorNullScript ; $637d
	ld a, $09 ; $6380
	farcall FarPtr_SetActorNullScript ; $6382
	script_set_anim $09, $01 ; $6385
	script_face $08, $80 ; $638c
	script_face $09, $80 ; $6393
	script_wait_frames $32 ; $639a
	script_face $00, $00 ; $63a1
	script_face $02, $00 ; $63a8
	script_set_text $085f ; $63af
	script_set_anim $08, $02 ; $63b5
	script_wait_idle $08 ; $63bc
	script_move_target $08, $1500, $1500 ; $63c1
	script_move_target $09, $1500, $1700 ; $63cc
	script_wait_move $09 ; $63d7
	script_face $09, $80 ; $63dc
	script_move_player_to_actor $00 ; $63e3
	script_face $03, $40 ; $63ea
	script_set_anim $08, $02 ; $63f1
	script_wait_idle $08 ; $63f8
	script_speak $08 ; $63fd
	script_set_anim $09, $03 ; $6402
	script_speak $09 ; $6409
	script_wait_frames $0f ; $640e
	script_face $00, $c0 ; $6415
	script_face $02, $c0 ; $641c
	script_face $08, $c0 ; $6423
	script_face $09, $c0 ; $642a
	ret ; $6431
Label_11_6432:
	script_player_speed $0020 ; $6432
	script_face $03, $80 ; $6438
	script_move_player_to_actor $05 ; $643f
	farcall FarPtr_WaitPlayerMoveDone ; $6446
	script_face $00, $80 ; $6449
	script_face $02, $80 ; $6450
	script_wait_frames $1e ; $6457
	script_set_text $0861 ; $645e
	script_set_actor_script $05, $76e9 ; $6464
	script_set_actor_script $07, $5c2e ; $646f
	script_move_player_to_actor $00 ; $647a
	script_face $03, $40 ; $6481
	farcall FarPtr_WaitPlayerMoveDone ; $6488
	script_wait_frames $1e ; $648b
	script_set_anim $05, $04 ; $6492
	script_wait_idle $05 ; $6499
	script_speak $05 ; $649e
	script_face_pair $07, $05 ; $64a3
	script_wait_frames $1e ; $64ab
	script_set_anim $07, $03 ; $64b2
	script_speak $07 ; $64b9
	script_face $00, $c0 ; $64be
	script_face $02, $c0 ; $64c5
	script_face $05, $c0 ; $64cc
	script_face $07, $c0 ; $64d3
	ret ; $64da
Label_11_64db:
	script_player_speed $0020 ; $64db
	script_face $03, $00 ; $64e1
	script_wait_frames $14 ; $64e8
	script_face $00, $00 ; $64ef
	script_face $02, $00 ; $64f6
	script_move_player_to_actor $04 ; $64fd
	farcall FarPtr_WaitPlayerMoveDone ; $6504
	script_face $06, $80 ; $6507
	script_set_anim $06, $02 ; $650e
	script_wait_idle $06 ; $6515
	script_set_text $0863 ; $651a
	script_set_actor_script $04, $7728 ; $6520
	script_wait_frames $0f ; $652b
	script_set_actor_script $06, $5cff ; $6532
	script_move_player_to_actor $00 ; $653d
	script_face $03, $40 ; $6544
	farcall FarPtr_WaitPlayerMoveDone ; $654b
	script_wait_frames $0f ; $654e
	script_set_anim $04, $02 ; $6555
	script_wait_idle $04 ; $655c
	script_speak $04 ; $6561
	script_set_anim $06, $03 ; $6566
	script_speak $06 ; $656d
	script_wait_frames $14 ; $6572
	script_face $00, $c0 ; $6579
	script_face $02, $c0 ; $6580
	script_face $04, $c0 ; $6587
	script_face $06, $c0 ; $658e
	ret ; $6595
StartNextDoublesRankingMatch:
	script_set_speed $00, $0020 ; $6596
	script_set_speed $02, $0020 ; $659e
	test_flag $08, 0 ; $65a6
	jp z, Label_11_65b9 ; $65a9
	test_flag $08, 1 ; $65ac
	jp z, Label_11_6642 ; $65af
	test_flag $08, 2 ; $65b2
	jp z, Label_11_6702 ; $65b5
	ret ; $65b8
Label_11_65b9:
	script_face $03, $00 ; $65b9
	script_wait_frames $1e ; $65c0
	ld a, $02 ; $65c7
	farcall FarPtr_SetActorNullScript ; $65c9
	script_move_player $1900, $1100 ; $65cc
	script_set_actor_script $08, $5b70 ; $65d6
	script_set_actor_script $09, $5b84 ; $65e1
	script_move_target $00, $1b00, $1900 ; $65ec
	script_wait_frames $0a ; $65f7
	script_move_target $02, $1900, $1500 ; $65fe
	script_wait_move $00 ; $6609
	script_face $00, $c0 ; $660e
	script_face $02, $c0 ; $6615
	script_wait_frames $3c ; $661c
	ld a, $0f ; $6623
	ld [$c294], a ; $6625
	ld [wStoryModeExitLocationRequest], a ; $6628
	farcall FarPtr_InitStoryMatchSettings ; $662b
	load_match_settings $0102 ; $662e
	farcall FarPtr_RunStoryMatch ; $663b
	farcall FarPtr_RestoreOverworldAfterMatch ; $663e
	ret ; $6641
Label_11_6642:
	script_face $03, $80 ; $6642
	script_wait_frames $0f ; $6649
	script_face $00, $80 ; $6650
	script_face $02, $80 ; $6657
	script_face $05, $80 ; $665e
	script_face $07, $80 ; $6665
	script_set_actor_script $0c, $6df8 ; $666c
	script_set_actor_script $0d, $6e07 ; $6677
	ld a, $0d ; $6682
	farcall FarPtr_WaitActorScriptDone ; $6684
	ld a, $02 ; $6687
	farcall FarPtr_SetActorNullScript ; $6689
	script_move_player $0b00, $1100 ; $668c
	script_set_actor_script $05, $5b98 ; $6696
	script_set_actor_script $07, $5bb2 ; $66a1
	script_wait_frames $1e ; $66ac
	script_set_actor_script $00, $7773 ; $66b3
	script_set_actor_script $02, $5d27 ; $66be
	ld a, $00 ; $66c9
	farcall FarPtr_WaitActorScriptDone ; $66cb
	script_face $00, $c0 ; $66ce
	script_face $02, $c0 ; $66d5
	script_wait_frames $3c ; $66dc
	ld a, $0f ; $66e3
	ld [$c294], a ; $66e5
	ld [wStoryModeExitLocationRequest], a ; $66e8
	farcall FarPtr_InitStoryMatchSettings ; $66eb
	load_match_settings $0103 ; $66ee
	farcall FarPtr_RunStoryMatch ; $66fb
	farcall FarPtr_RestoreOverworldAfterMatch ; $66fe
	ret ; $6701
Label_11_6702:
	script_face $03, $00 ; $6702
	script_wait_frames $0f ; $6709
	script_face $00, $00 ; $6710
	script_face $07, $00 ; $6717
	script_wait_frames $1e ; $671e
	ld a, $02 ; $6725
	farcall FarPtr_SetActorNullScript ; $6727
	script_move_player $1900, $1100 ; $672a
	script_set_actor_script $04, $5b70 ; $6734
	script_set_actor_script $06, $5b84 ; $673f
	script_move_target $00, $1b00, $1900 ; $674a
	script_wait_frames $14 ; $6755
	script_move_target $02, $1900, $1500 ; $675c
	script_wait_move $00 ; $6767
	script_face $00, $c0 ; $676c
	script_face $02, $c0 ; $6773
	script_wait_frames $3c ; $677a
	ld a, $0f ; $6781
	ld [$c294], a ; $6783
	ld [wStoryModeExitLocationRequest], a ; $6786
	farcall FarPtr_InitStoryMatchSettings ; $6789
	load_match_settings $0104 ; $678c
	farcall FarPtr_RunStoryMatch ; $6799
	farcall FarPtr_RestoreOverworldAfterMatch ; $679c
	ret ; $679f
LoadDoublesRankingOpponentGraphics:
	test_flag $08, 0 ; $67a0
	jr z, Label_11_67b0 ; $67a3
	test_flag $08, 1 ; $67a5
	jr z, Label_11_67e7 ; $67a8
	test_flag $08, 2 ; $67aa
	jr z, Label_11_6803 ; $67ad
	ret ; $67af
Label_11_67b0:
	script_set_actor_script $08, $5b14 ; $67b0
	script_set_actor_script $09, $5b42 ; $67bb
	ld a, $09 ; $67c6
	farcall FarPtr_WaitActorScriptDone ; $67c8
	script_set_actor_script $09, $681f ; $67cb
	ld a, $08 ; $67d6
	farcall FarPtr_WaitActorScriptDone ; $67d8
	script_set_actor_script $08, $7d86 ; $67db
	ret ; $67e6
Label_11_67e7:
	script_set_actor_script $05, $5bfa ; $67e7
	script_set_actor_script $07, $5c45 ; $67f2
	ld a, $05 ; $67fd
	farcall FarPtr_WaitActorScriptDone ; $67ff
	ret ; $6802
Label_11_6803:
	script_set_actor_script $04, $5c7f ; $6803
	script_set_actor_script $06, $5cbf ; $680e
	ld a, $04 ; $6819
	farcall FarPtr_WaitActorScriptDone ; $681b
	ret ; $681e
	INCBIN "data/bank_011/d_681f.bin" ; $681f, 3 bytes
JuniorClassCourtSinglesScene_11:
	; $6822, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $691a ; record 0
	dw $692c ; record 1
	dw $6830 ; record 2
	dw $6b54 ; record 3
	dw $6cfc ; record 4
	dw $6cfd ; record 5
	dw $6cfe ; record 6
	; $6830, 234 bytes (bytes:14)
	db $00, $00, $a9, $7b, $00, $13, $00, $13, $40, $00, $37, $01, $00, $00 ; 0x00
	db $00, $00, $a9, $7b, $00, $23, $00, $17, $80, $00, $68, $01, $05, $00 ; 0x0e
	db $00, $00, $a9, $7b, $00, $05, $00, $15, $00, $00, $6b, $01, $04, $00 ; 0x1c
	db $00, $00, $a9, $7b, $00, $13, $00, $0d, $00, $00, $67, $01, $07, $00 ; 0x2a
	db $00, $00, $a9, $7b, $00, $1f, $00, $15, $80, $00, $6a, $01, $07, $00 ; 0x38
	db $00, $00, $a9, $7b, $00, $25, $00, $09, $00, $00, $66, $01, $03, $00 ; 0x46
	db $00, $00, $a9, $7b, $00, $31, $00, $15, $00, $00, $65, $01, $06, $00 ; 0x54
	db $00, $00, $a9, $7b, $00, $3d, $00, $19, $80, $00, $64, $01, $04, $00 ; 0x62
	db $00, $00, $16, $6e, $00, $31, $00, $07, $40, $00, $69, $01, $03, $00 ; 0x70
	db $00, $00, $a9, $7c, $00, $08, $00, $0b, $40, $00, $54, $01, $05, $00 ; 0x7e
	db $00, $00, $10, $7d, $00, $0c, $00, $17, $c0, $00, $54, $01, $00, $00 ; 0x8c
	db $00, $00, $df, $7b, $00, $18, $00, $0b, $40, $00, $54, $01, $00, $00 ; 0x9a
	db $00, $00, $42, $7c, $00, $1c, $00, $17, $c0, $00, $54, $01, $05, $00 ; 0xa8
	db $00, $00, $a9, $7c, $00, $34, $00, $0b, $40, $00, $54, $01, $05, $00 ; 0xb6
	db $00, $00, $10, $7d, $00, $38, $00, $17, $c0, $00, $54, $01, $00, $00 ; 0xc4
	db $00, $00, $a9, $7b, $00, $40, $00, $40, $c0, $00, $53, $01, $00, $00 ; 0xd2
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xe0
	; $691a, 18 bytes (bytes:16)
	db $01, $c0, $00, $13, $00, $1d, $fd, $42, $09, $c0, $00, $2d, $00, $19, $00, $00 ; 0x00
	db $ff, $c9 ; 0x10
	; $692c, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $ff01, $0000, $7bd1, $0508 ; record 0
	dw $ff0f, $0000, $7bd1, $0f0b ; record 1
	db $ff
	script_set_speed $00, $0008 ; $693d
	script_facing_lock $00, $01 ; $6945
	script_move_target $00, $1300, $1500 ; $694c
	script_wait_move $00 ; $6957
	script_facing_lock $00, $00 ; $695c
	script_face $00, $c0 ; $6963
	call OfferSinglesRankingMatch ; $696a
	ret ; $696d
	script_set_text $083e ; $696e
	test_flag $0a, 3 ; $6974
	jr nz, Label_11_6984 ; $6977
	farcall FarPtr_AdvanceDialogueTextCursor ; $6979
	test_flag $0a, 2 ; $697c
	jr nz, Label_11_6984 ; $697f
	farcall FarPtr_AdvanceDialogueTextCursor ; $6981
Label_11_6984:
	script_speak $04 ; $6984
	ret ; $6989
	script_set_text $0841 ; $698a
	test_flag $0a, 2 ; $6990
	jr nz, Label_11_69a3 ; $6993
	farcall FarPtr_AdvanceDialogueTextCursor ; $6995
	test_flag $0a, 1 ; $6998
	jr nz, Label_11_69a9 ; $699b
	script_set_text $0845 ; $699d
Label_11_69a3:
	script_speak $05 ; $69a3
	ret ; $69a8
Label_11_69a9:
	ld a, $05 ; $69a9
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $69ab
	farcall FarPtr_RunDialogueYesNoPrompt ; $69ae
	farcall FarPtr_ScriptCloseDialogueWindow ; $69b1
	script_wait_frames $05 ; $69b4
	and a, a ; $69bb
	jr z, Label_11_69c1 ; $69bc
	farcall FarPtr_AdvanceDialogueTextCursor ; $69be
Label_11_69c1:
	script_speak $05 ; $69c1
	ret ; $69c6
	script_set_text $0846 ; $69c7
	test_flag $0a, 1 ; $69cd
	jr nz, Label_11_69f5 ; $69d0
	farcall FarPtr_AdvanceDialogueTextCursor ; $69d2
	test_flag $0a, 0 ; $69d5
	jr nz, Label_11_69f5 ; $69d8
	farcall FarPtr_AdvanceDialogueTextCursor ; $69da
	ld a, $06 ; $69dd
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $69df
	farcall FarPtr_RunDialogueYesNoPrompt ; $69e2
	farcall FarPtr_ScriptCloseDialogueWindow ; $69e5
	script_wait_frames $05 ; $69e8
	and a, a ; $69ef
	jr z, Label_11_69f5 ; $69f0
	farcall FarPtr_AdvanceDialogueTextCursor ; $69f2
Label_11_69f5:
	script_speak $06 ; $69f5
	ret ; $69fa
	script_set_text $084b ; $69fb
	test_flag $0a, 0 ; $6a01
	jr nz, Label_11_6a09 ; $6a04
	farcall FarPtr_AdvanceDialogueTextCursor ; $6a06
Label_11_6a09:
	script_speak $07 ; $6a09
	ret ; $6a0e
	test_flag $0a, 0 ; $6a0f
	jr z, Label_11_6a20 ; $6a12
	script_set_text $0856 ; $6a14
	script_speak $08 ; $6a1a
	ret ; $6a1f
Label_11_6a20:
	script_set_text $084d ; $6a20
	ld a, $08 ; $6a26
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6a28
	farcall FarPtr_RunDialogueYesNoPrompt ; $6a2b
	farcall FarPtr_ScriptCloseDialogueWindow ; $6a2e
	script_wait_frames $05 ; $6a31
	and a, a ; $6a38
	jr z, Label_11_6a41 ; $6a39
Label_11_6a3b:
	script_speak $08 ; $6a3b
	ret ; $6a40
Label_11_6a41:
	farcall FarPtr_AdvanceDialogueTextCursor ; $6a41
	ld a, $08 ; $6a44
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6a46
	farcall FarPtr_RunDialogueYesNoPrompt ; $6a49
	farcall FarPtr_ScriptCloseDialogueWindow ; $6a4c
	script_wait_frames $05 ; $6a4f
	and a, a ; $6a56
	jr nz, Label_11_6a3b ; $6a57
	script_set_anim $00, $03 ; $6a59
	script_wait_idle $00 ; $6a60
	script_move_player $2b00, $1100 ; $6a65
	script_move_target $00, $2700, $1900 ; $6a6f
	script_wait_frames $1e ; $6a7a
	script_move_target $08, $2b00, $0900 ; $6a81
	script_wait_move $08 ; $6a8c
	script_face $08, $40 ; $6a91
	script_wait_move $00 ; $6a98
	script_move_target $00, $2d00, $1900 ; $6a9d
	script_wait_move $00 ; $6aa8
	script_face $00, $c0 ; $6aad
	script_wait_frames $3c ; $6ab4
	ld hl, wStoryModePlayersXPosition ; $6abb
	ld de, wStoryModeSpawnPosition ; $6abe
	ld bc, $0005 ; $6ac1
	call CopyMemoryBC ; $6ac4
	ld a, $ff ; $6ac7
	ld [wStoryModeEntryPoint], a ; $6ac9
	ld [$c294], a ; $6acc
	ld [wStoryModeExitLocationRequest], a ; $6acf
	farcall FarPtr_InitStoryMatchSettings ; $6ad2
	load_match_settings $0000 ; $6ad5
	farcall FarPtr_RunStoryMatch ; $6ae2
	farcall FarPtr_RestoreOverworldAfterMatch ; $6ae5
	ret ; $6ae8
	script_set_text $0851 ; $6ae9
	test_flag $0a, 0 ; $6aef
	jr z, Label_11_6afa ; $6af2
	script_set_text $0857 ; $6af4
Label_11_6afa:
	script_speak $09 ; $6afa
	ret ; $6aff
	script_set_text $0852 ; $6b00
	test_flag $0a, 0 ; $6b06
	jr z, Label_11_6b11 ; $6b09
	script_set_text $0858 ; $6b0b
Label_11_6b11:
	script_speak $0a ; $6b11
	ret ; $6b16
	script_face_toward $00, $0b ; $6b17
	test_flag $0a, 0 ; $6b1f
	jr z, Label_11_6b30 ; $6b22
	script_set_text $0859 ; $6b24
	script_speak $0b ; $6b2a
	ret ; $6b2f
Label_11_6b30:
	script_set_text $0853 ; $6b30
	ld a, $0b ; $6b36
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6b38
	farcall FarPtr_RunDialogueYesNoPrompt ; $6b3b
	farcall FarPtr_ScriptCloseDialogueWindow ; $6b3e
	script_wait_frames $05 ; $6b41
	and a, a ; $6b48
	jr z, Label_11_6b4e ; $6b49
	farcall FarPtr_AdvanceDialogueTextCursor ; $6b4b
Label_11_6b4e:
	script_speak $0b ; $6b4e
	ret ; $6b53
	; $6b54, 81 bytes (records:8)
; 10 records x 8 bytes
	dw $4003, $0000, $693d, $0003 ; record 0
	dw $ff03, $0000, $696a, $0003 ; record 1
	dw $ff04, $0000, $696e, $0003 ; record 2
	dw $ff05, $0000, $698a, $0003 ; record 3
	dw $ff06, $0000, $69c7, $0003 ; record 4
	dw $ff07, $0000, $69fb, $0003 ; record 5
	dw $ff08, $0000, $6a0f, $0001 ; record 6
	dw $ff09, $0000, $6ae9, $0003 ; record 7
	dw $ff0a, $0000, $6b00, $0003 ; record 8
	dw $ff0b, $0000, $6b17, $001b ; record 9
	db $ff
	; $6ba5, 65 bytes (records:8)
; 8 records x 8 bytes
	dw $ff03, $0000, $0889, $0001 ; record 0
	dw $ff05, $0000, $088a, $0003 ; record 1
	dw $ff06, $0000, $088b, $0001 ; record 2
	dw $ff07, $0000, $088c, $0003 ; record 3
	dw $ff08, $0000, $088d, $0003 ; record 4
	dw $ff09, $0000, $088e, $0003 ; record 5
	dw $ff0a, $0000, $088f, $0013 ; record 6
	dw $ff0b, $0000, $0890, $0013 ; record 7
	db $ff
	; $6be6, 65 bytes (records:8)
; 8 records x 8 bytes
	dw $ff03, $0000, $089a, $0003 ; record 0
	dw $ff05, $0000, $089b, $0003 ; record 1
	dw $ff06, $0000, $089c, $0001 ; record 2
	dw $ff07, $0000, $089d, $0003 ; record 3
	dw $ff08, $0000, $089e, $0003 ; record 4
	dw $ff09, $0000, $089f, $0003 ; record 5
	dw $ff0a, $0000, $08a0, $0013 ; record 6
	dw $ff0b, $0000, $08a1, $0013 ; record 7
	db $ff
	; $6c27, 65 bytes (records:8)
; 8 records x 8 bytes
	dw $ff03, $0000, $08ab, $0003 ; record 0
	dw $ff05, $0000, $08ac, $0003 ; record 1
	dw $ff06, $0000, $08ad, $0001 ; record 2
	dw $ff07, $0000, $08ae, $0003 ; record 3
	dw $ff08, $0000, $08af, $0003 ; record 4
	dw $ff09, $0000, $08b0, $0003 ; record 5
	dw $ff0a, $0000, $08b1, $0003 ; record 6
	dw $ff0b, $0000, $08b5, $0013 ; record 7
	db $ff
	; $6c68, 65 bytes (records:8)
; 8 records x 8 bytes
	dw $ff03, $0000, $0c09, $0001 ; record 0
	dw $ff05, $0000, $0c0a, $0003 ; record 1
	dw $ff06, $0000, $0c0b, $0001 ; record 2
	dw $ff07, $0000, $0c0c, $0003 ; record 3
	dw $ff08, $0000, $0c0d, $0003 ; record 4
	dw $ff09, $0000, $0c0e, $0003 ; record 5
	dw $ff0a, $0000, $6ca9, $0003 ; record 6
	dw $ff0b, $0000, $0c13, $0013 ; record 7
	db $ff
	test_flag $10, 2 ; $6ca9
	jr nz, Label_11_6cba ; $6cac
	script_set_text $0c0f ; $6cae
	script_speak $0a ; $6cb4
	ret ; $6cb9
Label_11_6cba:
	script_set_text $0c10 ; $6cba
	ld a, $0a ; $6cc0
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6cc2
	farcall FarPtr_RunDialogueYesNoPrompt ; $6cc5
	farcall FarPtr_ScriptCloseDialogueWindow ; $6cc8
	script_wait_frames $05 ; $6ccb
	and a, a ; $6cd2
	jp z, Label_11_6cd9 ; $6cd3
	farcall FarPtr_AdvanceDialogueTextCursor ; $6cd6
Label_11_6cd9:
	test_flag $06, 5 ; $6cd9
	jr nz, Label_11_6ce4 ; $6cdc
	script_speak $0a ; $6cde
	ret ; $6ce3
Label_11_6ce4:
	script_set_anim $0a, $03 ; $6ce4
	script_wait_idle $0a ; $6ceb
	script_set_text $0c1f ; $6cf0
	script_speak $0a ; $6cf6
	ret ; $6cfb
	ds 2, $ff ; $6cfc, fill
	test_flag $0a, 0 ; $6cfe
	jr z, Label_11_6d15 ; $6d01
	script_set_position $07, $2500, $0b00 ; $6d03
	script_face $07, $00 ; $6d0e
Label_11_6d15:
	ld a, [wStoryModeEntryPoint] ; $6d15
	cp a, $0f ; $6d18
	jp z, Label_11_6e4d ; $6d1a
	cp a, $0e ; $6d1d
	jp z, Label_11_6e88 ; $6d1f
	cp a, $0d ; $6d22
	jp z, Label_11_6e9e ; $6d24
	test_flag $16, 0 ; $6d27
	jr nz, Label_11_6d3c ; $6d2a
	test_flag $15, 6 ; $6d2c
	jr nz, Label_11_6d51 ; $6d2f
	test_flag $0a, 7 ; $6d31
	jr nz, Label_11_6d66 ; $6d34
	test_flag $0a, 3 ; $6d36
	jr nz, Label_11_6d91 ; $6d39
	ret ; $6d3b
Label_11_6d3c:
	ld hl, $6c68 ; $6d3c
	ld de, $000c ; $6d3f
	farcall FarPtr_WriteStoryStateWord ; $6d42
	script_set_position $04, $3f00, $2900 ; $6d45
	ret ; $6d50
Label_11_6d51:
	ld hl, $6c27 ; $6d51
	ld de, $000c ; $6d54
	farcall FarPtr_WriteStoryStateWord ; $6d57
	script_set_position $04, $3f00, $2900 ; $6d5a
	ret ; $6d65
Label_11_6d66:
	ld hl, $6be6 ; $6d66
	ld de, $000c ; $6d69
	farcall FarPtr_WriteStoryStateWord ; $6d6c
	script_set_position $0a, $3d00, $1100 ; $6d6f
	script_set_actor_script $0a, $7bbd ; $6d7a
	script_set_position $04, $3f00, $2900 ; $6d85
	ret ; $6d90
Label_11_6d91:
	ld hl, $6ba5 ; $6d91
	ld de, $000c ; $6d94
	farcall FarPtr_WriteStoryStateWord ; $6d97
	script_set_position $0a, $3d00, $1100 ; $6d9a
	script_set_actor_script $0a, $7bbd ; $6da5
	script_set_position $04, $3f00, $2900 ; $6db0
	ret ; $6dbb
	INCBIN "data/bank_011/d_6dbc.bin" ; $6dbc, 145 bytes
Label_11_6e4d:
	wram_bank $04 ; $6e4d
	ld a, [wMatchExitRequest] ; $6e53
	cp a, $01 ; $6e56
	jr z, Label_11_6e62 ; $6e58
	ld a, [wMatchWinLoseFlag] ; $6e5a
	cp a, $01 ; $6e5d
	jp z, Label_11_6e88 ; $6e5f
Label_11_6e62:
	script_player_speed $0040 ; $6e62
	script_move_player $1300, $1500 ; $6e68
	script_set_position $00, $1300, $1500 ; $6e72
	script_face $00, $c0 ; $6e7d
	farcall FarPtr_WaitPlayerMoveDone ; $6e84
	ret ; $6e87
Label_11_6e88:
	ld a, $0b ; $6e88
	ld [wStoryModeCurrentLocation], a ; $6e8a
	ld a, $0d ; $6e8d
	ld [wStoryModeEntryPoint], a ; $6e8f
	ld a, $ff ; $6e92
	ld [$c294], a ; $6e94
	ld [wStoryModeExitLocationRequest], a ; $6e97
	farcall FarPtr_StubNop_1e ; $6e9a
	ret ; $6e9d
Label_11_6e9e:
	xor a, a ; $6e9e
	ld [wStoryModeShowLocationName], a ; $6e9f
	ld a, [$c8f7] ; $6ea2
	sub a, $01 ; $6ea5
	ld a, a ; $6ea7
	rst Rst00 ; $6ea8
	dw Label_11_6eb1 ; $6ea9 jumptable
	dw Label_11_6f44 ; $6eab jumptable
	dw Label_11_6fdd ; $6ead jumptable
	dw Label_11_7076 ; $6eaf jumptable
Label_11_6eb1:
	call Func_11_7a76 ; $6eb1
	script_player_speed $0040 ; $6eb4
	script_set_position $07, $1a00, $0900 ; $6eba
	script_set_position $00, $1a00, $1400 ; $6ec5
	script_move_player $1a00, $0f00 ; $6ed0
	farcall FarPtr_WaitPlayerMoveDone ; $6eda
	script_face $00, $c0 ; $6edd
	script_face $07, $40 ; $6ee4
	script_face $03, $00 ; $6eeb
	script_fade_in $04 ; $6ef2
	call WaitFadeEnd ; $6ef7
	script_set_text $0833 ; $6efa
	script_speak $07 ; $6f00
	script_jump_velocity $03, $ff80 ; $6f05
	ld a, $03 ; $6f0d
	farcall FarPtr_ScriptWaitActorJumpDone ; $6f0f
	script_speak $03 ; $6f12
	script_set_actor_script $07, $7682 ; $6f17
	script_move_target $00, $1300, $1500 ; $6f22
	script_wait_move $00 ; $6f2d
	script_face $00, $40 ; $6f32
	call Func_11_7b2d ; $6f39
	script_face $03, $40 ; $6f3c
	ret ; $6f43
Label_11_6f44:
	call Func_11_7ab3 ; $6f44
	script_player_speed $0040 ; $6f47
	script_set_position $06, $0900, $0900 ; $6f4d
	script_set_position $00, $0b00, $1400 ; $6f58
	script_move_player $0b00, $0f00 ; $6f63
	farcall FarPtr_WaitPlayerMoveDone ; $6f6d
	script_face $00, $c0 ; $6f70
	script_face $06, $40 ; $6f77
	script_face $03, $80 ; $6f7e
	script_fade_in $04 ; $6f85
	call WaitFadeEnd ; $6f8a
	script_set_text $0846 ; $6f8d
	script_speak $06 ; $6f93
	script_jump_velocity $03, $ff80 ; $6f98
	ld a, $03 ; $6fa0
	farcall FarPtr_ScriptWaitActorJumpDone ; $6fa2
	script_set_text $0835 ; $6fa5
	script_speak $03 ; $6fab
	script_set_actor_script $06, $76de ; $6fb0
	script_move_target $00, $1300, $1500 ; $6fbb
	script_wait_move $00 ; $6fc6
	script_face $00, $40 ; $6fcb
	call Func_11_7b6b ; $6fd2
	script_face $03, $40 ; $6fd5
	ret ; $6fdc
Label_11_6fdd:
	call Func_11_7ab3 ; $6fdd
	script_player_speed $0040 ; $6fe0
	script_set_position $05, $0900, $0900 ; $6fe6
	script_set_position $00, $0b00, $1400 ; $6ff1
	script_move_player $0b00, $0f00 ; $6ffc
	farcall FarPtr_WaitPlayerMoveDone ; $7006
	script_face $00, $c0 ; $7009
	script_face $05, $40 ; $7010
	script_face $03, $80 ; $7017
	script_fade_in $04 ; $701e
	call WaitFadeEnd ; $7023
	script_set_text $0841 ; $7026
	script_speak $05 ; $702c
	script_jump_velocity $03, $ff80 ; $7031
	ld a, $03 ; $7039
	farcall FarPtr_ScriptWaitActorJumpDone ; $703b
	script_set_text $0836 ; $703e
	script_speak $03 ; $7044
	script_set_actor_script $05, $7717 ; $7049
	script_move_target $00, $1300, $1500 ; $7054
	script_wait_move $00 ; $705f
	script_face $00, $40 ; $7064
	call Func_11_7b6b ; $706b
	script_face $03, $40 ; $706e
	ret ; $7075
Label_11_7076:
	script_player_speed $0040 ; $7076
	script_set_position $03, $1300, $1f00 ; $707c
	script_set_position $04, $1a00, $0b00 ; $7087
	script_set_position $00, $1a00, $1400 ; $7092
	script_move_player $1a00, $1100 ; $709d
	farcall FarPtr_WaitPlayerMoveDone ; $70a7
	script_face $00, $c0 ; $70aa
	script_face $04, $40 ; $70b1
	script_face $03, $c0 ; $70b8
	call Func_11_7a76 ; $70bf
	script_fade_in $04 ; $70c2
	call WaitFadeEnd ; $70c7
	script_wait_frames $3c ; $70ca
	script_set_text $0837 ; $70d1
	script_move_target $04, $1a00, $0d00 ; $70d7
	script_wait_move $04 ; $70e2
	script_set_anim $04, $02 ; $70e7
	script_speak $04 ; $70ee
	script_set_anim $03, $03 ; $70f3
	script_speak $03 ; $70fa
	script_set_anim $04, $02 ; $70ff
	script_set_anim $00, $02 ; $7106
	script_face $00, $40 ; $710d
	script_player_speed $0010 ; $7114
	script_set_speed $03, $0010 ; $711a
	script_move_player $1300, $1900 ; $7122
	script_move_target $03, $1300, $1b00 ; $712c
	script_wait_move $03 ; $7137
	farcall FarPtr_WaitPlayerMoveDone ; $713c
	script_move_player $1a00, $1400 ; $713f
	script_move_target $03, $1a00, $1700 ; $7149
	script_wait_move $03 ; $7154
	script_face $03, $c0 ; $7159
	script_set_anim $03, $02 ; $7160
	script_wait_idle $03 ; $7167
	script_speak $03 ; $716c
	script_set_anim $00, $03 ; $7171
	script_wait_idle $00 ; $7178
	script_set_anim $03, $03 ; $717d
	script_wait_idle $03 ; $7184
	script_speak $03 ; $7189
	script_move_target $03, $1a00, $1600 ; $718e
	script_wait_move $03 ; $7199
	script_set_anim $03, $02 ; $719e
	script_wait_idle $03 ; $71a5
	script_wait_frames $1e ; $71aa
	script_set_anim $03, $03 ; $71b1
	script_set_anim $00, $03 ; $71b8
	script_wait_idle $00 ; $71bf
	script_speak $00 ; $71c4
	script_set_anim $03, $02 ; $71c9
	script_wait_idle $03 ; $71d0
	script_speak $03 ; $71d5
	script_set_anim $00, $03 ; $71da
	script_wait_idle $00 ; $71e1
	script_set_anim $03, $03 ; $71e6
	script_wait_idle $03 ; $71ed
	script_set_anim $00, $02 ; $71f2
	script_wait_idle $00 ; $71f9
	script_face $00, $c0 ; $71fe
	script_set_position $12, $1b80, $1280 ; $7205
	sound $96 ; $7210
	script_wait_frames $28 ; $7212
	script_set_anim $04, $02 ; $7219
	script_wait_frames $28 ; $7220
	script_move_target $04, $1a00, $0e00 ; $7227
	script_wait_move $04 ; $7232
	script_set_position $12, $3f00, $3f00 ; $7237
	script_speak $04 ; $7242
	ld a, $0b ; $7247
	ld [wStoryModeCurrentLocation], a ; $7249
	ld a, $01 ; $724c
	ld [wStoryModeEntryPoint], a ; $724e
	ld a, $ff ; $7251
	ld [$c294], a ; $7253
	ld [wStoryModeExitLocationRequest], a ; $7256
	script_set_anim $03, $03 ; $7259
	script_wait_idle $03 ; $7260
	script_wait_frames $28 ; $7265
	script_set_anim $00, $02 ; $726c
	script_wait_idle $00 ; $7273
	script_wait_frames $28 ; $7278
	ld c, $04 ; $727f
	call BeginFadeOut ; $7281
	call WaitFadeEnd ; $7284
	ret ; $7287
PromptChallengeRankingOpponent:
	script_set_text $0822 ; $7288
	test_flag $0a, 0 ; $728e
	jr z, Label_11_7296 ; $7291
	farcall FarPtr_AdvanceDialogueTextCursor ; $7293
Label_11_7296:
	ld a, $03 ; $7296
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7298
	farcall FarPtr_RunDialogueYesNoPrompt ; $729b
	farcall FarPtr_ScriptCloseDialogueWindow ; $729e
	script_wait_frames $05 ; $72a1
	and a, a ; $72a8
	jp nz, Label_11_72ec ; $72a9
	script_set_anim $03, $03 ; $72ac
	script_wait_idle $03 ; $72b3
Label_11_72b8:
	script_set_anim $03, $03 ; $72b8
	script_wait_idle $03 ; $72bf
	script_set_text $0828 ; $72c4
	script_speak $03 ; $72ca
	call StartNextRankingMatch ; $72cf
	script_set_speed $00, $0018 ; $72d2
	script_set_speed $02, $0018 ; $72da
	ret ; $72e2
Label_11_72e3:
	script_speak $03 ; $72e3
	call LoadRankingOpponentGraphics ; $72e8
	ret ; $72eb
Label_11_72ec:
	script_set_text $0825 ; $72ec
	ld a, $03 ; $72f2
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $72f4
	farcall FarPtr_RunDialogueYesNoPrompt ; $72f7
	farcall FarPtr_ScriptCloseDialogueWindow ; $72fa
	script_wait_frames $05 ; $72fd
	and a, a ; $7304
	jr z, Label_11_72e3 ; $7305
	jp Label_11_72b8 ; $7307
LoadRankingOpponentGraphics:
	test_flag $05, 7 ; $730a
	jp nz, LoadDoublesRankingOpponentGraphics ; $730d
	test_flag $0a, 0 ; $7310
	jr z, Label_11_7325 ; $7313
	test_flag $0a, 1 ; $7315
	jr z, Label_11_7336 ; $7318
	test_flag $0a, 2 ; $731a
	jr z, Label_11_7347 ; $731d
	test_flag $0a, 3 ; $731f
	jr z, Label_11_7358 ; $7322
	ret ; $7324
Label_11_7325:
	script_set_actor_script $07, $766b ; $7325
	ld a, $07 ; $7330
	farcall FarPtr_WaitActorScriptDone ; $7332
	ret ; $7335
Label_11_7336:
	script_set_actor_script $06, $76cd ; $7336
	ld a, $06 ; $7341
	farcall FarPtr_WaitActorScriptDone ; $7343
	ret ; $7346
Label_11_7347:
	script_set_actor_script $05, $7700 ; $7347
	ld a, $05 ; $7352
	farcall FarPtr_WaitActorScriptDone ; $7354
	ret ; $7357
Label_11_7358:
	script_set_actor_script $04, $7745 ; $7358
	ld a, $04 ; $7363
	farcall FarPtr_WaitActorScriptDone ; $7365
	ret ; $7368
DrawRankingOpponentInfo:
	test_flag $0a, 0 ; $7369
	jr z, Label_11_7381 ; $736c
	test_flag $0a, 1 ; $736e
	jp z, Label_11_7438 ; $7371
	test_flag $0a, 2 ; $7374
	jp z, Label_11_74e3 ; $7377
	test_flag $0a, 3 ; $737a
	jp z, Label_11_7590 ; $737d
	ret ; $7380
Label_11_7381:
	script_wait_frames $0f ; $7381
	script_face_toward $07, $03 ; $7388
	script_wait_frames $1e ; $7390
	script_face_toward $07, $00 ; $7397
	script_wait_frames $1e ; $739f
	script_player_speed $0020 ; $73a6
	script_move_player_to_actor $07 ; $73ac
	farcall FarPtr_WaitPlayerMoveDone ; $73b3
	script_face_toward $03, $07 ; $73b6
	script_set_anim $07, $03 ; $73be
	script_wait_idle $07 ; $73c5
	script_wait_frames $0a ; $73ca
	script_set_actor_script $07, $7643 ; $73d1
	script_wait_frames $0a ; $73dc
	script_move_player_to_actor $00 ; $73e3
	script_face $03, $40 ; $73ea
	farcall FarPtr_WaitPlayerMoveDone ; $73f1
	ld a, $07 ; $73f4
	farcall FarPtr_WaitActorScriptDone ; $73f6
	script_face_toward $00, $07 ; $73f9
	script_set_anim $07, $02 ; $7401
	script_wait_idle $07 ; $7408
	script_set_text $082a ; $740d
	script_speak $07 ; $7413
	script_set_anim $07, $03 ; $7418
	script_wait_idle $07 ; $741f
	script_speak $07 ; $7424
	script_wait_frames $0f ; $7429
	script_face $07, $c0 ; $7430
	ret ; $7437
Label_11_7438:
	script_wait_frames $0f ; $7438
	script_face_toward $06, $03 ; $743f
	script_wait_frames $1e ; $7447
	script_face_toward $06, $00 ; $744e
	script_wait_frames $1e ; $7456
	script_player_speed $0020 ; $745d
	script_move_player_to_actor $06 ; $7463
	farcall FarPtr_WaitPlayerMoveDone ; $746a
	script_face_toward $03, $06 ; $746d
	script_set_anim $06, $03 ; $7475
	script_wait_idle $06 ; $747c
	script_set_actor_script $06, $76ab ; $7481
	script_move_player_to_actor $00 ; $748c
	script_face $03, $40 ; $7493
	ld a, $06 ; $749a
	farcall FarPtr_WaitActorScriptDone ; $749c
	script_face_toward $06, $00 ; $749f
	ld a, $06 ; $74a7
	farcall FarPtr_WaitActorScriptDone ; $74a9
	script_set_anim $06, $02 ; $74ac
	script_wait_idle $06 ; $74b3
	script_set_text $082c ; $74b8
	script_speak $06 ; $74be
	script_set_anim $06, $03 ; $74c3
	script_wait_idle $06 ; $74ca
	script_speak $06 ; $74cf
	script_wait_frames $0f ; $74d4
	script_face $06, $c0 ; $74db
	ret ; $74e2
Label_11_74e3:
	script_wait_frames $0f ; $74e3
	script_face_toward $05, $03 ; $74ea
	script_wait_frames $1e ; $74f2
	script_face_toward $05, $00 ; $74f9
	script_wait_frames $1e ; $7501
	script_player_speed $0020 ; $7508
	script_move_player_to_actor $05 ; $750e
	farcall FarPtr_WaitPlayerMoveDone ; $7515
	script_face_toward $03, $05 ; $7518
	script_set_anim $05, $03 ; $7520
	script_wait_idle $05 ; $7527
	script_set_actor_script $05, $76e9 ; $752c
	script_wait_frames $0a ; $7537
	script_move_player_to_actor $00 ; $753e
	script_face $03, $40 ; $7545
	ld a, $05 ; $754c
	farcall FarPtr_WaitActorScriptDone ; $754e
	script_face_toward $05, $00 ; $7551
	script_set_anim $05, $02 ; $7559
	script_wait_idle $05 ; $7560
	script_set_text $082e ; $7565
	script_speak $05 ; $756b
	script_set_anim $05, $03 ; $7570
	script_wait_idle $05 ; $7577
	script_speak $05 ; $757c
	script_wait_frames $0f ; $7581
	script_face $05, $c0 ; $7588
	ret ; $758f
Label_11_7590:
	script_wait_frames $0f ; $7590
	script_face_toward $04, $03 ; $7597
	script_wait_frames $1e ; $759f
	script_face_toward $04, $00 ; $75a6
	script_wait_frames $1e ; $75ae
	script_player_speed $0020 ; $75b5
	script_move_player_to_actor $04 ; $75bb
	farcall FarPtr_WaitPlayerMoveDone ; $75c2
	ld bc, $d040 ; $75c5
	ld a, $04 ; $75c8
	farcall FarPtr_GetActorStateAddr ; $75ca
	ld e, l ; $75cd
	ld d, h ; $75ce
	farcall FarPtr_04_1e ; $75cf
	script_face_toward $03, $04 ; $75d2
	script_set_anim $04, $03 ; $75da
	script_wait_idle $04 ; $75e1
	script_set_actor_script $04, $7728 ; $75e6
	script_face $03, $40 ; $75f1
	script_move_player_to_actor $00 ; $75f8
	ld a, $04 ; $75ff
	farcall FarPtr_WaitActorScriptDone ; $7601
	script_face_toward $04, $00 ; $7604
	script_set_anim $04, $02 ; $760c
	script_wait_idle $04 ; $7613
	script_set_text $0830 ; $7618
	script_speak $04 ; $761e
	script_set_anim $04, $03 ; $7623
	script_wait_idle $04 ; $762a
	script_speak $04 ; $762f
	script_wait_frames $0f ; $7634
	script_face $04, $c0 ; $763b
	ret ; $7642
	INCBIN "data/bank_011/d_7643.bin" ; $7643, 321 bytes
OfferSinglesRankingMatch:
	script_set_text $081c ; $7784
	ld a, $03 ; $778a
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $778c
	farcall FarPtr_RunDialogueYesNoPrompt ; $778f
	farcall FarPtr_ScriptCloseDialogueWindow ; $7792
	script_wait_frames $05 ; $7795
	and a, a ; $779c
	jp nz, Label_11_7817 ; $779d
	script_facing_lock $00, $00 ; $77a0
	script_set_speed $00, $0018 ; $77a7
	script_move_target $00, $1300, $1500 ; $77af
	script_wait_move $00 ; $77ba
	script_face_toward $03, $00 ; $77bf
	script_wait_frames $1e ; $77c7
	script_face_toward $00, $03 ; $77ce
	farcall FarPtr_AdvanceDialogueTextCursor ; $77d6
	test_flag $0a, 0 ; $77d9
	jr z, Label_11_77f1 ; $77dc
	farcall FarPtr_AdvanceDialogueTextCursor ; $77de
	test_flag $0a, 1 ; $77e1
	jr z, Label_11_77f1 ; $77e4
	farcall FarPtr_AdvanceDialogueTextCursor ; $77e6
	test_flag $0a, 2 ; $77e9
	jr z, Label_11_77f1 ; $77ec
	farcall FarPtr_AdvanceDialogueTextCursor ; $77ee
Label_11_77f1:
	script_speak $03 ; $77f1
	call DrawRankingOpponentInfo ; $77f6
	script_face $00, $c0 ; $77f9
	script_wait_frames $0f ; $7800
	script_set_anim $03, $02 ; $7807
	script_wait_idle $03 ; $780e
	call PromptChallengeRankingOpponent ; $7813
	ret ; $7816
Label_11_7817:
	script_speak $03 ; $7817
	ret ; $781c
StartNextRankingMatch:
	script_set_speed $00, $0020 ; $781d
	test_flag $05, 7 ; $7825
	jp nz, StartNextDoublesRankingMatch ; $7828
	test_flag $0a, 0 ; $782b
	jr z, Label_11_7843 ; $782e
	test_flag $0a, 1 ; $7830
	jp z, Label_11_78cf ; $7833
	test_flag $0a, 2 ; $7836
	jp z, Label_11_795d ; $7839
	test_flag $0a, 3 ; $783c
	jp z, Label_11_79e8 ; $783f
	ret ; $7842
Label_11_7843:
	script_face $03, $00 ; $7843
	script_wait_frames $0f ; $784a
	script_face $00, $00 ; $7851
	script_face $07, $00 ; $7858
	script_wait_frames $1e ; $785f
	script_set_actor_script $0e, $6dbc ; $7866
	script_set_actor_script $0f, $6dcb ; $7871
	ld a, $0f ; $787c
	farcall FarPtr_WaitActorScriptDone ; $787e
	script_move_player $1b00, $1100 ; $7881
	script_set_actor_script $07, $765a ; $788b
	script_set_actor_script $00, $7762 ; $7896
	farcall FarPtr_WaitPlayerMoveDone ; $78a1
	ld a, $07 ; $78a4
	farcall FarPtr_WaitActorScriptDone ; $78a6
	script_wait_frames $14 ; $78a9
	ld a, $0f ; $78b0
	ld [$c294], a ; $78b2
	ld [wStoryModeExitLocationRequest], a ; $78b5
	farcall FarPtr_InitStoryMatchSettings ; $78b8
	load_match_settings $0001 ; $78bb
	farcall FarPtr_RunStoryMatch ; $78c8
	farcall FarPtr_RestoreOverworldAfterMatch ; $78cb
	ret ; $78ce
Label_11_78cf:
	script_face $03, $80 ; $78cf
	script_wait_frames $0f ; $78d6
	script_face $00, $80 ; $78dd
	script_face $06, $80 ; $78e4
	script_wait_frames $1e ; $78eb
	script_set_actor_script $0c, $6dda ; $78f2
	script_set_actor_script $0d, $6de9 ; $78fd
	script_wait_frames $78 ; $7908
	script_move_player $0b00, $1100 ; $790f
	script_set_actor_script $06, $76bc ; $7919
	script_set_actor_script $00, $7773 ; $7924
	farcall FarPtr_WaitPlayerMoveDone ; $792f
	ld a, $06 ; $7932
	farcall FarPtr_WaitActorScriptDone ; $7934
	script_wait_frames $28 ; $7937
	ld a, $0f ; $793e
	ld [$c294], a ; $7940
	ld [wStoryModeExitLocationRequest], a ; $7943
	farcall FarPtr_InitStoryMatchSettings ; $7946
	load_match_settings $0002 ; $7949
	farcall FarPtr_RunStoryMatch ; $7956
	farcall FarPtr_RestoreOverworldAfterMatch ; $7959
	ret ; $795c
Label_11_795d:
	script_face $03, $80 ; $795d
	script_wait_frames $0f ; $7964
	script_face $00, $80 ; $796b
	script_face $05, $80 ; $7972
	script_wait_frames $1e ; $7979
	script_set_actor_script $0c, $6dda ; $7980
	script_set_actor_script $0d, $6de9 ; $798b
	script_wait_frames $78 ; $7996
	script_move_player $0b00, $1100 ; $799d
	script_set_actor_script $05, $76bc ; $79a7
	script_set_actor_script $00, $7773 ; $79b2
	ld a, $05 ; $79bd
	farcall FarPtr_WaitActorScriptDone ; $79bf
	script_wait_frames $28 ; $79c2
	ld a, $0f ; $79c9
	ld [$c294], a ; $79cb
	ld [wStoryModeExitLocationRequest], a ; $79ce
	farcall FarPtr_InitStoryMatchSettings ; $79d1
	load_match_settings $0003 ; $79d4
	farcall FarPtr_RunStoryMatch ; $79e1
	farcall FarPtr_RestoreOverworldAfterMatch ; $79e4
	ret ; $79e7
Label_11_79e8:
	script_face $03, $00 ; $79e8
	script_wait_frames $0f ; $79ef
	script_face $00, $00 ; $79f6
	script_face $04, $00 ; $79fd
	script_wait_frames $1e ; $7a04
	script_set_actor_script $0e, $6dbc ; $7a0b
	script_set_actor_script $0f, $6dcb ; $7a16
	script_wait_frames $78 ; $7a21
	script_move_player $1700, $1300 ; $7a28
	script_set_actor_script $04, $765a ; $7a32
	script_set_actor_script $00, $7762 ; $7a3d
	farcall FarPtr_WaitPlayerMoveDone ; $7a48
	ld a, $04 ; $7a4b
	farcall FarPtr_WaitActorScriptDone ; $7a4d
	script_wait_frames $28 ; $7a50
	ld a, $0f ; $7a57
	ld [$c294], a ; $7a59
	ld [wStoryModeExitLocationRequest], a ; $7a5c
	farcall FarPtr_InitStoryMatchSettings ; $7a5f
	load_match_settings $0004 ; $7a62
	farcall FarPtr_RunStoryMatch ; $7a6f
	farcall FarPtr_RestoreOverworldAfterMatch ; $7a72
	ret ; $7a75
Func_11_7a76:
	ld a, $0e ; $7a76
	farcall FarPtr_SetActorNullScript ; $7a78
	ld a, $0f ; $7a7b
	farcall FarPtr_SetActorNullScript ; $7a7d
	script_set_anim $0e, $01 ; $7a80
	script_set_anim $0f, $01 ; $7a87
	script_set_position $0e, $1f00, $0b00 ; $7a8e
	script_set_position $0f, $1f00, $1300 ; $7a99
	script_face $0e, $80 ; $7aa4
	script_face $0f, $80 ; $7aab
	ret ; $7ab2
Func_11_7ab3:
	ld a, $0c ; $7ab3
	farcall FarPtr_SetActorNullScript ; $7ab5
	ld a, $0d ; $7ab8
	farcall FarPtr_SetActorNullScript ; $7aba
	script_set_anim $0c, $01 ; $7abd
	script_set_anim $0d, $01 ; $7ac4
	script_set_position $0c, $0f00, $0b00 ; $7acb
	script_set_position $0d, $0f00, $1300 ; $7ad6
	script_face $0c, $80 ; $7ae1
	script_face $0d, $80 ; $7ae8
	script_wait_frames $14 ; $7aef
	ret ; $7af6
Func_11_7af7:
	ld a, $0c ; $7af7
	farcall FarPtr_SetActorNullScript ; $7af9
	ld a, $0d ; $7afc
	farcall FarPtr_SetActorNullScript ; $7afe
	script_set_position $0c, $0500, $0b00 ; $7b01
	script_set_position $0d, $0500, $1300 ; $7b0c
	script_face $0c, $00 ; $7b17
	script_face $0d, $00 ; $7b1e
	script_wait_frames $14 ; $7b25
	ret ; $7b2c
Func_11_7b2d:
	script_move_target $0e, $1800, $0b00 ; $7b2d
	script_move_target $0f, $1c00, $1700 ; $7b38
	script_wait_move $0f ; $7b43
	script_face $0f, $c0 ; $7b48
	script_wait_move $0e ; $7b4f
	script_set_actor_script $0e, $7bdf ; $7b54
	script_set_actor_script $0f, $7c42 ; $7b5f
	ret ; $7b6a
Func_11_7b6b:
	script_move_target $0c, $0800, $0b00 ; $7b6b
	script_move_target $0d, $0c00, $1700 ; $7b76
	script_wait_move $0d ; $7b81
	script_face $0d, $c0 ; $7b86
	script_wait_move $0c ; $7b8d
	script_set_actor_script $0c, $7ca9 ; $7b92
	script_set_actor_script $0d, $7d10 ; $7b9d
	ret ; $7ba8
ActorObjDef_11_7ba9:
	INCBIN "data/bank_011/d_7ba9.bin" ; $7ba9, 40 bytes
Func_11_7bd1:
	ret ; $7bd1
	INCBIN "data/bank_011/d_7bd2.bin" ; $7bd2, 451 bytes
ComputeRankingProgressIndex:
	test_flag $05, 7 ; $7d95
	jr nz, Label_11_7dbc ; $7d98
	ld a, $00 ; $7d9a
	test_flag $0a, 3 ; $7d9c
	jr z, Label_11_7db8 ; $7d9f
	ld a, $02 ; $7da1
	test_flag $0a, 7 ; $7da3
	jr z, Label_11_7db8 ; $7da6
	ld a, $04 ; $7da8
	test_flag $15, 6 ; $7daa
	jr z, Label_11_7db8 ; $7dad
	ld a, $06 ; $7daf
	test_flag $16, 0 ; $7db1
	jr z, Label_11_7db8 ; $7db4
	ld a, $08 ; $7db6
Label_11_7db8:
	ld [$c2b0], a ; $7db8
	ret ; $7dbb
Label_11_7dbc:
	ld a, $01 ; $7dbc
	test_flag $08, 2 ; $7dbe
	jr z, Label_11_7db8 ; $7dc1
	ld a, $03 ; $7dc3
	test_flag $08, 6 ; $7dc5
	jr z, Label_11_7db8 ; $7dc8
	ld a, $05 ; $7dca
	test_flag $15, 7 ; $7dcc
	jr z, Label_11_7db8 ; $7dcf
	ld a, $07 ; $7dd1
	test_flag $16, 1 ; $7dd3
	jr z, Label_11_7db8 ; $7dd6
	ld a, $09 ; $7dd8
	jr Label_11_7db8 ; $7dda
	ld a, $00 ; $7ddc
	test_flag $0a, 3 ; $7dde
	jr z, Label_11_7dfb ; $7de1
	inc a ; $7de3
	test_flag $0a, 7 ; $7de4
	jr z, Label_11_7dfb ; $7de7
	inc a ; $7de9
	test_flag $05, 7 ; $7dea
	jr nz, Label_11_7dff ; $7ded
	test_flag $15, 6 ; $7def
	jr z, Label_11_7dfb ; $7df2
	inc a ; $7df4
	test_flag $16, 0 ; $7df5
	jr z, Label_11_7dfb ; $7df8
	inc a ; $7dfa
Label_11_7dfb:
	ld [$c2b0], a ; $7dfb
	ret ; $7dfe
Label_11_7dff:
	test_flag $15, 7 ; $7dff
	jr z, Label_11_7dfb ; $7e02
	inc a ; $7e04
	test_flag $16, 1 ; $7e05
	jr z, Label_11_7dfb ; $7e08
	inc a ; $7e0a
	jr Label_11_7dfb ; $7e0b
	ds 499, $ff ; $7e0d, fill

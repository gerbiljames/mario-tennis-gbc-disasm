SECTION "ROM Bank $11", ROMX[$4000], BANK[$11]

DataPtr_11_00:
	dw Data_11_4008 ; $4000
DataPtr_AcademyArrivalScene_11:
	dw AcademyArrivalScene_11 ; $4002
DataPtr_JuniorClassCourtDoublesScene_11:
	dw JuniorClassCourtDoublesScene_11 ; $4004
DataPtr_JuniorClassCourtSinglesScene_11:
	dw JuniorClassCourtSinglesScene_11 ; $4006
Data_11_4008:
	; $4008, 14 bytes (records:2)
	dw $4058 ; record 0
	dw $4071 ; record 1
	dw $4016 ; record 2
	dw $416f ; record 3
	dw $4190 ; record 4
	dw $419a ; record 5
	dw $41a4 ; record 6
	; $4016, 66 bytes (bytes:14)
	db $00, $00, $a9, $7b, $00, $0f, $00, $2e, $80, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $a9, $7b, $00, $0d, $00, $13, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $a9, $7b, $00, $1f, $00, $2e, $00, $00, $39, $01, $07, $00 ; 0x1c
	db $00, $00, $a9, $7b, $00, $21, $00, $2e, $80, $00, $32, $01, $07, $00 ; 0x2a
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x38
	; $4058, 25 bytes (bytes:16)
	db $01, $c0, $00, $0c, $00, $31, $00, $00, $02, $c0, $00, $24, $00, $31, $00, $00 ; 0x00
	db $0f, $c0, $00, $0c, $00, $31, $00, $00, $ff ; 0x10
	; $4071, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $ff01, $0000, $7bd1, $0119 ; record 0
	dw $ff02, $0000, $7bd1, $0219 ; record 1
	db $ff
	ld hl, $2450 ; $4082
	farcall FarPtr_InitDialogueTextCursor ; $4085
	test_flag $05, 7 ; $4088
	jr nz, Label_11_409c ; $408b
	ld a, [$c2b0] ; $408d
	cp a, $03 ; $4090
	jr nz, Label_11_40a9 ; $4092
	ld hl, $245b ; $4094
	farcall FarPtr_InitDialogueTextCursor ; $4097
	jr Label_11_40a9 ; $409a
Label_11_409c:
	ld a, [$c2b0] ; $409c
	cp a, $06 ; $409f
	jr nz, Label_11_40a9 ; $40a1
	ld hl, $245b ; $40a3
	farcall FarPtr_InitDialogueTextCursor ; $40a6
Label_11_40a9:
	ld a, $03 ; $40a9
	farcall FarPtr_ScriptShowSpeakerDialogue ; $40ab
	ret ; $40ae
	test_flag $05, 7 ; $40af
	jr z, Label_11_40c9 ; $40b2
	ld hl, $2460 ; $40b4
	farcall FarPtr_InitDialogueTextCursor ; $40b7
	ld a, [$c2b0] ; $40ba
	cp a, $06 ; $40bd
	jr nz, Label_11_40fa ; $40bf
	ld hl, $2465 ; $40c1
	farcall FarPtr_InitDialogueTextCursor ; $40c4
	jr Label_11_40fa ; $40c7
Label_11_40c9:
	ld hl, $2451 ; $40c9
	farcall FarPtr_InitDialogueTextCursor ; $40cc
	ld a, $04 ; $40cf
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $40d1
	farcall FarPtr_RunDialogueYesNoPrompt ; $40d4
	farcall FarPtr_ScriptCloseDialogueWindow ; $40d7
	push af ; $40da
	ld a, $05 ; $40db
	farcall FarPtr_WaitScriptFrames ; $40dd
	pop af ; $40e0
	and a, a ; $40e1
	jr z, Label_11_40ed ; $40e2
	farcall FarPtr_AdvanceDialogueTextCursor ; $40e4
	ld a, $04 ; $40e7
	farcall FarPtr_ScriptShowSpeakerDialogue ; $40e9
	ret ; $40ec
Label_11_40ed:
	ld a, [$c2b0] ; $40ed
	cp a, $03 ; $40f0
	jr nz, Label_11_40fa ; $40f2
	farcall FarPtr_AdvanceDialogueTextCursor ; $40f4
	farcall FarPtr_AdvanceDialogueTextCursor ; $40f7
Label_11_40fa:
	ld a, $04 ; $40fa
	farcall FarPtr_ScriptShowSpeakerDialogue ; $40fc
	ret ; $40ff
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
	ld a, $05 ; $4118
	farcall FarPtr_ScriptShowSpeakerDialogue ; $411a
	ret ; $411d
Label_11_411e:
	ld a, $05 ; $411e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4120
	farcall FarPtr_RunDialogueYesNoPrompt ; $4123
	farcall FarPtr_ScriptCloseDialogueWindow ; $4126
	push af ; $4129
	ld a, $05 ; $412a
	farcall FarPtr_WaitScriptFrames ; $412c
	pop af ; $412f
	and a, a ; $4130
	jr z, Label_11_4136 ; $4131
	farcall FarPtr_AdvanceDialogueTextCursor ; $4133
Label_11_4136:
	ld a, $05 ; $4136
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4138
	ret ; $413b
	; $413c, 14 bytes (records:2)
	dw $2455 ; record 0
	dw $2457 ; record 1
	dw $2459 ; record 2
	dw $245c ; record 3
	dw $2461 ; record 4
	dw $2463 ; record 5
	dw $2466 ; record 6
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
	ld a, $05 ; $415b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $415d
	ret ; $4160
	; $4161, 14 bytes (records:2)
	dw $2456 ; record 0
	dw $2458 ; record 1
	dw $245a ; record 2
	dw $245f ; record 3
	dw $2462 ; record 4
	dw $2464 ; record 5
	dw $2467 ; record 6
	; $416f, 33 bytes (records:8)
; 4 records x 8 bytes
	dw $ff03, $0000, $4082, $0003 ; record 0
	dw $ff04, $0000, $40af, $0003 ; record 1
	dw $ff05, $0000, $4100, $0003 ; record 2
	dw $ff06, $0000, $414a, $0003 ; record 3
	db $ff
	; $4190, 10 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $4199, $0000 ; record 0
	db $ff, $c9
	; $419a, 10 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $41a3, $0000 ; record 0
	db $ff, $c9
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
	ld a, $02 ; $430a
	ld bc, $00ff ; $430c
	farcall FarPtr_ScriptSetActorMoveSpeed ; $430f
	ld a, $02 ; $4312
	ld b, $40 ; $4314
	ld de, $0200 ; $4316
	farcall FarPtr_MoveActorByAngle ; $4319
	ld a, $02 ; $431c
	farcall FarPtr_ScriptWaitActorMoveDone ; $431e
	ld a, $02 ; $4321
	ld b, $c0 ; $4323
	farcall FarPtr_SetActorFacing ; $4325
	ld a, $02 ; $4328
	ld bc, $0010 ; $432a
	farcall FarPtr_ScriptSetActorMoveSpeed ; $432d
Label_11_4330:
	ld a, $00 ; $4330
	ld bc, $0010 ; $4332
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4335
	ld a, $00 ; $4338
	ld b, $c0 ; $433a
	ld de, $0200 ; $433c
	farcall FarPtr_MoveActorByAngle ; $433f
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
	farcall FarPtr_04_2c ; $4357
	ld a, $02 ; $435a
	ld d, $01 ; $435c
	farcall FarPtr_ScriptSetActorAnimation ; $435e
Label_11_4361:
	ld a, [$c90d] ; $4361
	ld d, $56 ; $4364
	add a, d ; $4366
	ld d, a ; $4367
	ld a, $00 ; $4368
	farcall FarPtr_GetActorStateAddr ; $436a
	ld c, l ; $436d
	ld b, h ; $436e
	farcall FarPtr_04_2c ; $436f
	ld a, $00 ; $4372
	ld d, $01 ; $4374
	farcall FarPtr_ScriptSetActorAnimation ; $4376
	ret ; $4379
Label_11_437a:
	ld a, $0a ; $437a
	ld bc, $2500 ; $437c
	ld de, $2400 ; $437f
	farcall FarPtr_ScriptSetActorPosition ; $4382
	test_flag $05, 7 ; $4385
	jr z, Label_11_4395 ; $4388
	ld a, $02 ; $438a
	ld bc, $0c00 ; $438c
	ld de, $3300 ; $438f
	farcall FarPtr_ScriptSetActorPosition ; $4392
Label_11_4395:
	xor a, a ; $4395
	ld [wStoryModeShowLocationName], a ; $4396
	ld c, $04 ; $4399
	call BeginFadeIn ; $439b
	ldh a, [hRomBank] ; $439e
	ld b, a ; $43a0
	ld a, $00 ; $43a1
	ld de, $43ed ; $43a3
	farcall FarPtr_ScriptSetActorScript ; $43a6
	push af ; $43a9
	ld a, $50 ; $43aa
	farcall FarPtr_WaitScriptFrames ; $43ac
	pop af ; $43af
	ld a, $00 ; $43b0
	ld d, $03 ; $43b2
	farcall FarPtr_ScriptSetActorAnimation ; $43b4
	ld a, $00 ; $43b7
	farcall FarPtr_ScriptWaitActorIdle ; $43b9
	push af ; $43bc
	ld a, $1e ; $43bd
	farcall FarPtr_WaitScriptFrames ; $43bf
	pop af ; $43c2
	ld a, $00 ; $43c3
	farcall FarPtr_WaitActorScriptDone ; $43c5
	xor a, a ; $43c8
	ld bc, $2300 ; $43c9
	ld de, $2400 ; $43cc
	farcall FarPtr_MovePlayerToPosition ; $43cf
	ldh a, [hRomBank] ; $43d2
	ld b, a ; $43d4
	ld a, $00 ; $43d5
	ld de, $43f4 ; $43d7
	farcall FarPtr_ScriptSetActorScript ; $43da
	push af ; $43dd
	ld a, $f0 ; $43de
	farcall FarPtr_WaitScriptFrames ; $43e0
	pop af ; $43e3
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
	ld a, $03 ; $45bd
	farcall FarPtr_ScriptShowSpeakerDialogue ; $45bf
	ret ; $45c2
Label_11_45c3:
	ld a, $03 ; $45c3
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $45c5
	farcall FarPtr_RunDialogueYesNoPrompt ; $45c8
	farcall FarPtr_ScriptCloseDialogueWindow ; $45cb
	push af ; $45ce
	ld a, $05 ; $45cf
	farcall FarPtr_WaitScriptFrames ; $45d1
	pop af ; $45d4
	and a, a ; $45d5
	jr z, Label_11_45db ; $45d6
	farcall FarPtr_AdvanceDialogueTextCursor ; $45d8
Label_11_45db:
	ld a, $03 ; $45db
	farcall FarPtr_ScriptShowSpeakerDialogue ; $45dd
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
	ld a, $04 ; $4606
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4608
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
	ld a, $05 ; $4633
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4635
	ret ; $4638
	; $4639, 10 bytes (records:2)
	dw $183e ; record 0
	dw $1841 ; record 1
	dw $1846 ; record 2
	dw $184b ; record 3
	dw $184e ; record 4
	ld hl, $1860 ; $4643
	farcall FarPtr_InitDialogueTextCursor ; $4646
	test_flag $05, 7 ; $4649
	jr nz, Label_11_4670 ; $464c
	test_flag $15, 6 ; $464e
	jr z, Label_11_465e ; $4651
	farcall FarPtr_AdvanceDialogueTextCursor ; $4653
	test_flag $16, 0 ; $4656
	jr z, Label_11_465e ; $4659
	farcall FarPtr_AdvanceDialogueTextCursor ; $465b
Label_11_465e:
	ld a, $14 ; $465e
	ld d, $04 ; $4660
	farcall FarPtr_ScriptSetActorAnimation ; $4662
	ld a, $14 ; $4665
	farcall FarPtr_ScriptWaitActorIdle ; $4667
	ld a, $14 ; $466a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $466c
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
	ld a, $00 ; $46cf
	ld bc, $0010 ; $46d1
	farcall FarPtr_ScriptSetActorMoveSpeed ; $46d4
	xor a, a ; $46d7
	ld [wStoryModeShowLocationName], a ; $46d8
	ld a, $11 ; $46db
	ld bc, $1800 ; $46dd
	ld de, $0d00 ; $46e0
	farcall FarPtr_ScriptSetActorPosition ; $46e3
	ld a, $00 ; $46e6
	ld bc, $1800 ; $46e8
	ld de, $3700 ; $46eb
	farcall FarPtr_ScriptSetActorPosition ; $46ee
	ld a, $14 ; $46f1
	ld bc, $3f00 ; $46f3
	ld de, $3f00 ; $46f6
	farcall FarPtr_ScriptSetActorPosition ; $46f9
	ld a, $03 ; $46fc
	ld bc, $2280 ; $46fe
	ld de, $1500 ; $4701
	farcall FarPtr_ScriptSetActorPosition ; $4704
	ld a, $03 ; $4707
	ld b, $00 ; $4709
	farcall FarPtr_SetActorFacing ; $470b
	ld a, $04 ; $470e
	ld bc, $3300 ; $4710
	ld de, $1500 ; $4713
	farcall FarPtr_ScriptSetActorPosition ; $4716
	ld a, $05 ; $4719
	ld bc, $3300 ; $471b
	ld de, $1500 ; $471e
	farcall FarPtr_ScriptSetActorPosition ; $4721
	ld c, $04 ; $4724
	call BeginFadeIn ; $4726
	call WaitFadeEnd ; $4729
	ld a, $00 ; $472c
	ld bc, $1800 ; $472e
	ld de, $2d00 ; $4731
	farcall FarPtr_ScriptSetActorMoveTarget ; $4734
	ld a, $00 ; $4737
	farcall FarPtr_ScriptWaitActorMoveDone ; $4739
	ld a, $00 ; $473c
	ld b, $00 ; $473e
	farcall FarPtr_SetActorFacing ; $4740
	push af ; $4743
	ld a, $28 ; $4744
	farcall FarPtr_WaitScriptFrames ; $4746
	pop af ; $4749
	ld a, $00 ; $474a
	ld b, $c0 ; $474c
	farcall FarPtr_SetActorFacing ; $474e
	push af ; $4751
	ld a, $28 ; $4752
	farcall FarPtr_WaitScriptFrames ; $4754
	pop af ; $4757
	ld a, $00 ; $4758
	ld b, $80 ; $475a
	farcall FarPtr_SetActorFacing ; $475c
	push af ; $475f
	ld a, $28 ; $4760
	farcall FarPtr_WaitScriptFrames ; $4762
	pop af ; $4765
	ld a, $00 ; $4766
	ld b, $c0 ; $4768
	farcall FarPtr_SetActorFacing ; $476a
	push af ; $476d
	ld a, $28 ; $476e
	farcall FarPtr_WaitScriptFrames ; $4770
	pop af ; $4773
	ld a, $00 ; $4774
	ld b, $00 ; $4776
	farcall FarPtr_SetActorFacing ; $4778
	push af ; $477b
	ld a, $0a ; $477c
	farcall FarPtr_WaitScriptFrames ; $477e
	pop af ; $4781
	ld a, $00 ; $4782
	ld b, $40 ; $4784
	farcall FarPtr_SetActorFacing ; $4786
	push af ; $4789
	ld a, $3c ; $478a
	farcall FarPtr_WaitScriptFrames ; $478c
	pop af ; $478f
	ld a, $00 ; $4790
	ld d, $03 ; $4792
	farcall FarPtr_ScriptSetActorAnimation ; $4794
	ld a, $00 ; $4797
	farcall FarPtr_ScriptWaitActorIdle ; $4799
	push af ; $479c
	ld a, $3c ; $479d
	farcall FarPtr_WaitScriptFrames ; $479f
	pop af ; $47a2
	ld a, $00 ; $47a3
	ld bc, $1800 ; $47a5
	ld de, $2100 ; $47a8
	farcall FarPtr_ScriptSetActorMoveTarget ; $47ab
	ld bc, $0040 ; $47ae
	farcall FarPtr_SetPlayerMoveSpeed ; $47b1
	xor a, a ; $47b4
	ld bc, $1800 ; $47b5
	ld de, $1200 ; $47b8
	farcall FarPtr_MovePlayerToPosition ; $47bb
	farcall FarPtr_WaitPlayerMoveDone ; $47be
	push af ; $47c1
	ld a, $3c ; $47c2
	farcall FarPtr_WaitScriptFrames ; $47c4
	pop af ; $47c7
	ld a, $00 ; $47c8
	ld bc, $1800 ; $47ca
	ld de, $2000 ; $47cd
	farcall FarPtr_ScriptSetActorPosition ; $47d0
	ld a, $00 ; $47d3
	ld b, $c0 ; $47d5
	farcall FarPtr_SetActorFacing ; $47d7
	ld a, $11 ; $47da
	ld bc, $0024 ; $47dc
	farcall FarPtr_ScriptSetActorMoveSpeed ; $47df
	ld a, $11 ; $47e2
	ld bc, $1800 ; $47e4
	ld de, $1400 ; $47e7
	farcall FarPtr_ScriptSetActorMoveTarget ; $47ea
	ld a, $11 ; $47ed
	farcall FarPtr_ScriptWaitActorMoveDone ; $47ef
	ld a, $11 ; $47f2
	ld d, $04 ; $47f4
	farcall FarPtr_ScriptSetActorAnimation ; $47f6
	ld a, $11 ; $47f9
	farcall FarPtr_ScriptWaitActorIdle ; $47fb
	ld a, $11 ; $47fe
	ld b, $c0 ; $4800
	farcall FarPtr_SetActorFacing ; $4802
	ld hl, $184f ; $4805
	farcall FarPtr_InitDialogueTextCursor ; $4808
	ld a, $11 ; $480b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $480d
	ld a, $11 ; $4810
	ld d, $03 ; $4812
	farcall FarPtr_ScriptSetActorAnimation ; $4814
	ld a, $11 ; $4817
	farcall FarPtr_ScriptWaitActorIdle ; $4819
	ld a, $11 ; $481c
	ld bc, $0020 ; $481e
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4821
	ld a, $11 ; $4824
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4826
	ld a, $11 ; $4829
	ld b, $40 ; $482b
	farcall FarPtr_SetActorFacing ; $482d
	ld a, $11 ; $4830
	ld de, $ff80 ; $4832
	farcall FarPtr_ScriptSetActorJumpVelocity ; $4835
	ld a, $11 ; $4838
	farcall FarPtr_ScriptWaitActorJumpDone ; $483a
	ld a, $11 ; $483d
	ld bc, $1800 ; $483f
	ld de, $1700 ; $4842
	farcall FarPtr_ScriptSetActorMoveTarget ; $4845
	ld a, $11 ; $4848
	farcall FarPtr_ScriptWaitActorMoveDone ; $484a
	ld a, $0e ; $484d
	ld bc, $1980 ; $484f
	ld de, $15c0 ; $4852
	farcall FarPtr_ScriptSetActorPosition ; $4855
	sound $98 ; $4858
	ld a, $11 ; $485a
	ld bc, $0010 ; $485c
	farcall FarPtr_ScriptSetActorMoveSpeed ; $485f
	ld a, $0e ; $4862
	ld bc, $0010 ; $4864
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4867
	ld a, $0e ; $486a
	ld bc, $1980 ; $486c
	ld de, $18c0 ; $486f
	farcall FarPtr_ScriptSetActorMoveTarget ; $4872
	ld a, $11 ; $4875
	ld bc, $1800 ; $4877
	ld de, $1a00 ; $487a
	farcall FarPtr_ScriptSetActorMoveTarget ; $487d
	ld a, $11 ; $4880
	farcall FarPtr_ScriptWaitActorMoveDone ; $4882
	ld a, $11 ; $4885
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4887
	ld a, $0e ; $488a
	ld bc, $3f00 ; $488c
	ld de, $3f00 ; $488f
	farcall FarPtr_ScriptSetActorPosition ; $4892
	ld a, $11 ; $4895
	ld bc, $1800 ; $4897
	ld de, $1600 ; $489a
	farcall FarPtr_ScriptSetActorMoveTarget ; $489d
	ld a, $11 ; $48a0
	farcall FarPtr_ScriptWaitActorMoveDone ; $48a2
	push af ; $48a5
	ld a, $1e ; $48a6
	farcall FarPtr_WaitScriptFrames ; $48a8
	pop af ; $48ab
	ld a, $11 ; $48ac
	ld d, $02 ; $48ae
	farcall FarPtr_ScriptSetActorAnimation ; $48b0
	ld a, $0f ; $48b3
	ld bc, $1980 ; $48b5
	ld de, $14c0 ; $48b8
	farcall FarPtr_ScriptSetActorPosition ; $48bb
	sound $97 ; $48be
	push af ; $48c0
	ld a, $14 ; $48c1
	farcall FarPtr_WaitScriptFrames ; $48c3
	pop af ; $48c6
	ld a, $11 ; $48c7
	farcall FarPtr_ScriptShowSpeakerDialogue ; $48c9
	ld a, $0f ; $48cc
	ld bc, $3f00 ; $48ce
	ld de, $3f00 ; $48d1
	farcall FarPtr_ScriptSetActorPosition ; $48d4
	ld a, $11 ; $48d7
	ld bc, $0020 ; $48d9
	farcall FarPtr_ScriptSetActorMoveSpeed ; $48dc
	ld a, $11 ; $48df
	ld de, $ff80 ; $48e1
	farcall FarPtr_ScriptSetActorJumpVelocity ; $48e4
	ld a, $11 ; $48e7
	farcall FarPtr_ScriptWaitActorJumpDone ; $48e9
	ld a, $11 ; $48ec
	ld bc, $1800 ; $48ee
	ld de, $2000 ; $48f1
	farcall FarPtr_ScriptSetActorMoveTarget ; $48f4
	push af ; $48f7
	ld a, $1e ; $48f8
	farcall FarPtr_WaitScriptFrames ; $48fa
	pop af ; $48fd
	ld bc, $d040 ; $48fe
	ld a, $11 ; $4901
	farcall FarPtr_GetActorStateAddr ; $4903
	ld e, l ; $4906
	ld d, h ; $4907
	farcall FarPtr_04_1e ; $4908
	ld a, $00 ; $490b
	ld bc, $1800 ; $490d
	ld de, $1e00 ; $4910
	farcall FarPtr_ScriptSetActorMoveTarget ; $4913
	push af ; $4916
	ld a, $14 ; $4917
	farcall FarPtr_WaitScriptFrames ; $4919
	pop af ; $491c
	call LateStudentCrashImpact ; $491d
	ld a, $11 ; $4920
	farcall FarPtr_ScriptWaitActorMoveDone ; $4922
	ld a, $11 ; $4925
	ld d, $02 ; $4927
	farcall FarPtr_ScriptSetActorAnimation ; $4929
	ld a, $10 ; $492c
	ld bc, $1900 ; $492e
	ld de, $1e00 ; $4931
	farcall FarPtr_ScriptSetActorPosition ; $4934
	sound $96 ; $4937
	push af ; $4939
	ld a, $3c ; $493a
	farcall FarPtr_WaitScriptFrames ; $493c
	pop af ; $493f
	ld a, $10 ; $4940
	ld bc, $3f00 ; $4942
	ld de, $3f00 ; $4945
	farcall FarPtr_ScriptSetActorPosition ; $4948
	ld a, $11 ; $494b
	ld bc, $1700 ; $494d
	ld de, $2200 ; $4950
	farcall FarPtr_ScriptSetActorMoveTarget ; $4953
	ld a, $11 ; $4956
	farcall FarPtr_ScriptWaitActorMoveDone ; $4958
	ld a, $00 ; $495b
	ld b, a ; $495d
	ld a, $11 ; $495e
	farcall FarPtr_FaceActorTowardActor ; $4960
	ld a, $11 ; $4963
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4965
	ld a, $11 ; $4968
	ld bc, $1900 ; $496a
	ld de, $2400 ; $496d
	farcall FarPtr_ScriptSetActorMoveTarget ; $4970
	ld a, $11 ; $4973
	farcall FarPtr_ScriptWaitActorMoveDone ; $4975
	ld a, $01 ; $4978
	farcall FarPtr_SetActorNullScript ; $497a
	ld a, $00 ; $497d
	ld b, a ; $497f
	ld a, $11 ; $4980
	farcall FarPtr_FaceActorTowardActor ; $4982
	ld a, $11 ; $4985
	ld d, $02 ; $4987
	farcall FarPtr_ScriptSetActorAnimation ; $4989
	ld a, $11 ; $498c
	farcall FarPtr_ScriptWaitActorIdle ; $498e
	ld a, $11 ; $4991
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4993
	ld a, $13 ; $4996
	ld bc, $1a80 ; $4998
	ld de, $2280 ; $499b
	farcall FarPtr_ScriptSetActorPosition ; $499e
	push af ; $49a1
	ld a, $3c ; $49a2
	farcall FarPtr_WaitScriptFrames ; $49a4
	pop af ; $49a7
	ld a, $13 ; $49a8
	ld bc, $3f00 ; $49aa
	ld de, $3f00 ; $49ad
	farcall FarPtr_ScriptSetActorPosition ; $49b0
	ld a, $11 ; $49b3
	ld bc, $1900 ; $49b5
	ld de, $2300 ; $49b8
	farcall FarPtr_ScriptSetActorMoveTarget ; $49bb
	ld a, $11 ; $49be
	farcall FarPtr_ScriptWaitActorMoveDone ; $49c0
	ld a, $11 ; $49c3
	ld bc, $1a00 ; $49c5
	ld de, $2300 ; $49c8
	farcall FarPtr_ScriptSetActorMoveTarget ; $49cb
	ld a, $11 ; $49ce
	farcall FarPtr_ScriptWaitActorMoveDone ; $49d0
	ld a, $11 ; $49d3
	ld bc, $1a00 ; $49d5
	ld de, $2400 ; $49d8
	farcall FarPtr_ScriptSetActorMoveTarget ; $49db
	ld a, $11 ; $49de
	farcall FarPtr_ScriptWaitActorMoveDone ; $49e0
	ld a, $11 ; $49e3
	ld bc, $1900 ; $49e5
	ld de, $2400 ; $49e8
	farcall FarPtr_ScriptSetActorMoveTarget ; $49eb
	ld a, $11 ; $49ee
	farcall FarPtr_ScriptWaitActorMoveDone ; $49f0
	ld a, $11 ; $49f3
	ld bc, $1900 ; $49f5
	ld de, $2500 ; $49f8
	farcall FarPtr_ScriptSetActorMoveTarget ; $49fb
	ld a, $11 ; $49fe
	farcall FarPtr_ScriptWaitActorMoveDone ; $4a00
	ld a, $11 ; $4a03
	ld bc, $1a00 ; $4a05
	ld de, $2500 ; $4a08
	farcall FarPtr_ScriptSetActorMoveTarget ; $4a0b
	ld a, $11 ; $4a0e
	farcall FarPtr_ScriptWaitActorMoveDone ; $4a10
	ld a, $11 ; $4a13
	ld bc, $1a00 ; $4a15
	ld de, $2400 ; $4a18
	farcall FarPtr_ScriptSetActorMoveTarget ; $4a1b
	ld a, $11 ; $4a1e
	farcall FarPtr_ScriptWaitActorMoveDone ; $4a20
	ld a, $11 ; $4a23
	ld bc, $1900 ; $4a25
	ld de, $2400 ; $4a28
	farcall FarPtr_ScriptSetActorMoveTarget ; $4a2b
	ld a, $11 ; $4a2e
	farcall FarPtr_ScriptWaitActorMoveDone ; $4a30
	ld a, $00 ; $4a33
	ld b, a ; $4a35
	ld a, $11 ; $4a36
	farcall FarPtr_FaceActorTowardActor ; $4a38
	push af ; $4a3b
	ld a, $3c ; $4a3c
	farcall FarPtr_WaitScriptFrames ; $4a3e
	pop af ; $4a41
	ld a, $11 ; $4a42
	ld d, $02 ; $4a44
	farcall FarPtr_ScriptSetActorAnimation ; $4a46
	ld a, $11 ; $4a49
	farcall FarPtr_ScriptWaitActorIdle ; $4a4b
	ld a, $11 ; $4a4e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4a50
	call Func_11_4d68 ; $4a53
	ld a, $11 ; $4a56
	ld b, $01 ; $4a58
	farcall FarPtr_ScriptSetActorFacingLock ; $4a5a
	ld a, $11 ; $4a5d
	ld d, $05 ; $4a5f
	farcall FarPtr_ScriptSetActorAnimation ; $4a61
	push af ; $4a64
	ld a, $14 ; $4a65
	farcall FarPtr_WaitScriptFrames ; $4a67
	pop af ; $4a6a
	ld a, $11 ; $4a6b
	ld de, $ff80 ; $4a6d
	farcall FarPtr_ScriptSetActorJumpVelocity ; $4a70
	ld a, $11 ; $4a73
	ld bc, $1b00 ; $4a75
	ld de, $2400 ; $4a78
	farcall FarPtr_ScriptSetActorMoveTarget ; $4a7b
	push af ; $4a7e
	ld a, $14 ; $4a7f
	farcall FarPtr_WaitScriptFrames ; $4a81
	pop af ; $4a84
	ld a, $11 ; $4a85
	ld b, a ; $4a87
	ld a, $00 ; $4a88
	farcall FarPtr_FaceActorTowardActor ; $4a8a
	push af ; $4a8d
	ld a, $14 ; $4a8e
	farcall FarPtr_WaitScriptFrames ; $4a90
	pop af ; $4a93
	ld a, $00 ; $4a94
	ld d, $02 ; $4a96
	farcall FarPtr_ScriptSetActorAnimation ; $4a98
	ld a, $00 ; $4a9b
	farcall FarPtr_ScriptWaitActorIdle ; $4a9d
	ld a, $11 ; $4aa0
	ld d, $02 ; $4aa2
	farcall FarPtr_ScriptSetActorAnimation ; $4aa4
	ld a, $11 ; $4aa7
	farcall FarPtr_ScriptWaitActorIdle ; $4aa9
	ld a, $00 ; $4aac
	ld b, a ; $4aae
	ld a, $11 ; $4aaf
	farcall FarPtr_FaceActorTowardActor ; $4ab1
	ld a, $11 ; $4ab4
	ld bc, $1a00 ; $4ab6
	ld de, $2400 ; $4ab9
	farcall FarPtr_ScriptSetActorMoveTarget ; $4abc
	ld a, $11 ; $4abf
	farcall FarPtr_ScriptWaitActorMoveDone ; $4ac1
	ld a, $11 ; $4ac4
	ld b, $00 ; $4ac6
	farcall FarPtr_ScriptSetActorFacingLock ; $4ac8
	ld a, $00 ; $4acb
	ld d, $02 ; $4acd
	farcall FarPtr_ScriptSetActorAnimation ; $4acf
	ld a, $00 ; $4ad2
	farcall FarPtr_ScriptWaitActorIdle ; $4ad4
	ld a, $11 ; $4ad7
	ld d, $02 ; $4ad9
	farcall FarPtr_ScriptSetActorAnimation ; $4adb
	ld a, $11 ; $4ade
	farcall FarPtr_ScriptWaitActorIdle ; $4ae0
	ld a, $11 ; $4ae3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4ae5
	ld a, $11 ; $4ae8
	ld d, $02 ; $4aea
	farcall FarPtr_ScriptSetActorAnimation ; $4aec
	ld a, $11 ; $4aef
	farcall FarPtr_ScriptWaitActorIdle ; $4af1
Label_11_4af4:
	ld hl, $1857 ; $4af4
	farcall FarPtr_InitDialogueTextCursor ; $4af7
	ld a, $11 ; $4afa
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4afc
	farcall FarPtr_RunDialogueYesNoPrompt ; $4aff
	farcall FarPtr_ScriptCloseDialogueWindow ; $4b02
	push af ; $4b05
	ld a, $05 ; $4b06
	farcall FarPtr_WaitScriptFrames ; $4b08
	pop af ; $4b0b
	and a, a ; $4b0c
	jr z, Label_11_4b1d ; $4b0d
	ld a, $11 ; $4b0f
	ld d, $02 ; $4b11
	farcall FarPtr_ScriptSetActorAnimation ; $4b13
	ld a, $11 ; $4b16
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4b18
	jr Label_11_4af4 ; $4b1b
Label_11_4b1d:
	ld hl, $1859 ; $4b1d
	farcall FarPtr_InitDialogueTextCursor ; $4b20
	ld a, $11 ; $4b23
	ld d, $03 ; $4b25
	farcall FarPtr_ScriptSetActorAnimation ; $4b27
	ld a, $11 ; $4b2a
	farcall FarPtr_ScriptWaitActorIdle ; $4b2c
	ld a, $11 ; $4b2f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4b31
	push af ; $4b34
	ld a, $3c ; $4b35
	farcall FarPtr_WaitScriptFrames ; $4b37
	pop af ; $4b3a
	ld a, $0e ; $4b3b
	ld bc, $1b80 ; $4b3d
	ld de, $21c0 ; $4b40
	farcall FarPtr_ScriptSetActorPosition ; $4b43
	sound $98 ; $4b46
	push af ; $4b48
	ld a, $28 ; $4b49
	farcall FarPtr_WaitScriptFrames ; $4b4b
	pop af ; $4b4e
	ld a, $0e ; $4b4f
	ld bc, $3f00 ; $4b51
	ld de, $3f00 ; $4b54
	farcall FarPtr_ScriptSetActorPosition ; $4b57
	ld a, $11 ; $4b5a
	ld b, $80 ; $4b5c
	ld de, $0100 ; $4b5e
	farcall FarPtr_MoveActorByAngle ; $4b61
	ld a, $11 ; $4b64
	farcall FarPtr_ScriptWaitActorMoveDone ; $4b66
	ld a, $11 ; $4b69
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4b6b
	ld a, $00 ; $4b6e
	ld d, $03 ; $4b70
	farcall FarPtr_ScriptSetActorAnimation ; $4b72
	ld a, $00 ; $4b75
	farcall FarPtr_ScriptWaitActorIdle ; $4b77
	ld a, $0e ; $4b7a
	ld bc, $1a80 ; $4b7c
	ld de, $21c0 ; $4b7f
	farcall FarPtr_ScriptSetActorPosition ; $4b82
	push af ; $4b85
	ld a, $3c ; $4b86
	farcall FarPtr_WaitScriptFrames ; $4b88
	pop af ; $4b8b
	ld a, $0e ; $4b8c
	ld bc, $3f00 ; $4b8e
	ld de, $3f00 ; $4b91
	farcall FarPtr_ScriptSetActorPosition ; $4b94
	push af ; $4b97
	ld a, $3c ; $4b98
	farcall FarPtr_WaitScriptFrames ; $4b9a
	pop af ; $4b9d
	ld a, $0f ; $4b9e
	ld bc, $1a80 ; $4ba0
	ld de, $21c0 ; $4ba3
	farcall FarPtr_ScriptSetActorPosition ; $4ba6
	sound $97 ; $4ba9
	ld a, $11 ; $4bab
	ld de, $ff80 ; $4bad
	farcall FarPtr_ScriptSetActorJumpVelocity ; $4bb0
	ld a, $11 ; $4bb3
	farcall FarPtr_ScriptWaitActorJumpDone ; $4bb5
	push af ; $4bb8
	ld a, $0a ; $4bb9
	farcall FarPtr_WaitScriptFrames ; $4bbb
	pop af ; $4bbe
	ld a, $0f ; $4bbf
	ld bc, $3f00 ; $4bc1
	ld de, $3f00 ; $4bc4
	farcall FarPtr_ScriptSetActorPosition ; $4bc7
	ld a, $11 ; $4bca
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4bcc
	ld a, $11 ; $4bcf
	ld d, $02 ; $4bd1
	farcall FarPtr_ScriptSetActorAnimation ; $4bd3
	ld a, $11 ; $4bd6
	farcall FarPtr_ScriptWaitActorIdle ; $4bd8
	ld a, $11 ; $4bdb
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4bdd
	ld a, $00 ; $4be0
	ld d, $03 ; $4be2
	farcall FarPtr_ScriptSetActorAnimation ; $4be4
	ld a, $00 ; $4be7
	farcall FarPtr_ScriptWaitActorIdle ; $4be9
	ld a, $11 ; $4bec
	ld d, $03 ; $4bee
	farcall FarPtr_ScriptSetActorAnimation ; $4bf0
	ld a, $11 ; $4bf3
	farcall FarPtr_ScriptWaitActorIdle ; $4bf5
	ld a, $11 ; $4bf8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4bfa
	push af ; $4bfd
	ld a, $0a ; $4bfe
	farcall FarPtr_WaitScriptFrames ; $4c00
	pop af ; $4c03
	ld a, $00 ; $4c04
	ld d, $03 ; $4c06
	farcall FarPtr_ScriptSetActorAnimation ; $4c08
	ld a, $00 ; $4c0b
	farcall FarPtr_ScriptWaitActorIdle ; $4c0d
	push af ; $4c10
	ld a, $3c ; $4c11
	farcall FarPtr_WaitScriptFrames ; $4c13
	pop af ; $4c16
	ld bc, $0060 ; $4c17
	farcall FarPtr_SetPlayerMoveSpeed ; $4c1a
	ld a, $11 ; $4c1d
	ld b, $c0 ; $4c1f
	farcall FarPtr_SetActorFacing ; $4c21
	ld a, $11 ; $4c24
	ld d, $02 ; $4c26
	farcall FarPtr_ScriptSetActorAnimation ; $4c28
	ld a, $11 ; $4c2b
	farcall FarPtr_ScriptWaitActorIdle ; $4c2d
	ld a, $0f ; $4c30
	ld bc, $1a80 ; $4c32
	ld de, $21c0 ; $4c35
	farcall FarPtr_ScriptSetActorPosition ; $4c38
	sound $97 ; $4c3b
	push af ; $4c3d
	ld a, $28 ; $4c3e
	farcall FarPtr_WaitScriptFrames ; $4c40
	pop af ; $4c43
	ld a, $0f ; $4c44
	ld bc, $3f00 ; $4c46
	ld de, $3f00 ; $4c49
	farcall FarPtr_ScriptSetActorPosition ; $4c4c
	ld a, $11 ; $4c4f
	ld b, $c0 ; $4c51
	farcall FarPtr_SetActorFacing ; $4c53
	ld a, $11 ; $4c56
	ld d, $02 ; $4c58
	farcall FarPtr_ScriptSetActorAnimation ; $4c5a
	xor a, a ; $4c5d
	ld bc, $1800 ; $4c5e
	ld de, $0b00 ; $4c61
	farcall FarPtr_MovePlayerToPosition ; $4c64
	farcall FarPtr_WaitPlayerMoveDone ; $4c67
	ld a, $11 ; $4c6a
	ld b, $00 ; $4c6c
	farcall FarPtr_SetActorActive ; $4c6e
	ld a, $11 ; $4c71
	ld bc, $1900 ; $4c73
	ld de, $0600 ; $4c76
	farcall FarPtr_ScriptSetActorPosition ; $4c79
	ld a, $11 ; $4c7c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4c7e
	ld a, $11 ; $4c81
	ld bc, $1900 ; $4c83
	ld de, $2400 ; $4c86
	farcall FarPtr_ScriptSetActorPosition ; $4c89
	ld a, $11 ; $4c8c
	ld b, $02 ; $4c8e
	farcall FarPtr_SetActorActive ; $4c90
	xor a, a ; $4c93
	ld bc, $1800 ; $4c94
	ld de, $2400 ; $4c97
	farcall FarPtr_MovePlayerToPosition ; $4c9a
	farcall FarPtr_WaitPlayerMoveDone ; $4c9d
	ld a, $00 ; $4ca0
	ld b, a ; $4ca2
	ld a, $11 ; $4ca3
	farcall FarPtr_FaceActorTowardActor ; $4ca5
	ld a, $11 ; $4ca8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4caa
	ld a, $11 ; $4cad
	ld d, $03 ; $4caf
	farcall FarPtr_ScriptSetActorAnimation ; $4cb1
	ld a, $11 ; $4cb4
	farcall FarPtr_ScriptWaitActorIdle ; $4cb6
	ld a, $00 ; $4cb9
	ld d, $03 ; $4cbb
	farcall FarPtr_ScriptSetActorAnimation ; $4cbd
	ld a, $00 ; $4cc0
	farcall FarPtr_ScriptWaitActorIdle ; $4cc2
	ld a, $11 ; $4cc5
	ld de, $ff80 ; $4cc7
	farcall FarPtr_ScriptSetActorJumpVelocity ; $4cca
	ld a, $11 ; $4ccd
	farcall FarPtr_ScriptWaitActorJumpDone ; $4ccf
	ld a, $11 ; $4cd2
	ld bc, $1800 ; $4cd4
	ld de, $3300 ; $4cd7
	farcall FarPtr_ScriptSetActorMoveTarget ; $4cda
	push af ; $4cdd
	ld a, $14 ; $4cde
	farcall FarPtr_WaitScriptFrames ; $4ce0
	pop af ; $4ce3
	ld a, $00 ; $4ce4
	ld b, $40 ; $4ce6
	farcall FarPtr_SetActorFacing ; $4ce8
	push af ; $4ceb
	ld a, $5a ; $4cec
	farcall FarPtr_WaitScriptFrames ; $4cee
	pop af ; $4cf1
	call AcademyArrivalGreetingScene ; $4cf2
	ret ; $4cf5
LateStudentCrashImpact:
	ld a, $01 ; $4cf6
	farcall FarPtr_SetActorNullScript ; $4cf8
	sound $70 ; $4cfb
	ld a, $03 ; $4cfd
	farcall FarPtr_SetScreenShake ; $4cff
	push af ; $4d02
	ld a, $0a ; $4d03
	farcall FarPtr_WaitScriptFrames ; $4d05
	pop af ; $4d08
	ld a, $00 ; $4d09
	farcall FarPtr_SetScreenShake ; $4d0b
	ld a, $00 ; $4d0e
	ld bc, $0040 ; $4d10
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4d13
	xor a, a ; $4d16
	ld bc, $1800 ; $4d17
	ld de, $2400 ; $4d1a
	farcall FarPtr_MovePlayerToPosition ; $4d1d
	ld a, $00 ; $4d20
	ld bc, $1700 ; $4d22
	ld de, $2400 ; $4d25
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d28
	ld a, $00 ; $4d2b
	ld de, rJOYP ; $4d2d
	farcall FarPtr_ScriptSetActorJumpVelocity ; $4d30
	ld a, $00 ; $4d33
	farcall FarPtr_GetActorStateAddr ; $4d35
	ld c, l ; $4d38
	ld b, h ; $4d39
	ld hl, $0037 ; $4d3a
	add hl, bc ; $4d3d
	ld a, [hl] ; $4d3e
	or a, $40 ; $4d3f
	ld [hl], a ; $4d41
	push af ; $4d42
	ld a, $1e ; $4d43
	farcall FarPtr_WaitScriptFrames ; $4d45
	pop af ; $4d48
	ld a, $00 ; $4d49
	ld d, $02 ; $4d4b
	farcall FarPtr_ScriptSetActorAnimation ; $4d4d
	ld a, $00 ; $4d50
	farcall FarPtr_ScriptWaitActorIdle ; $4d52
	push af ; $4d55
	ld a, $1e ; $4d56
	farcall FarPtr_WaitScriptFrames ; $4d58
	pop af ; $4d5b
	ldh a, [hRomBank] ; $4d5c
	ld b, a ; $4d5e
	ld a, $00 ; $4d5f
	ld de, $4d8d ; $4d61
	farcall FarPtr_ScriptSetActorScript ; $4d64
	ret ; $4d67
Func_11_4d68:
	ld a, $00 ; $4d68
	farcall FarPtr_SetActorNullScript ; $4d6a
	ld a, $00 ; $4d6d
	ld bc, $0010 ; $4d6f
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4d72
	ld a, $00 ; $4d75
	ld de, $ff80 ; $4d77
	farcall FarPtr_ScriptSetActorJumpVelocity ; $4d7a
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
	ld bc, $0010 ; $4d94
	farcall FarPtr_SetPlayerMoveSpeed ; $4d97
	ld a, $00 ; $4d9a
	ld bc, $0018 ; $4d9c
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4d9f
	ld a, $12 ; $4da2
	ld bc, $0018 ; $4da4
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4da7
	xor a, a ; $4daa
	ld bc, $1800 ; $4dab
	ld de, $1300 ; $4dae
	farcall FarPtr_MovePlayerToPosition ; $4db1
	ld a, $00 ; $4db4
	ld bc, $1800 ; $4db6
	ld de, $2400 ; $4db9
	farcall FarPtr_ScriptSetActorMoveTarget ; $4dbc
	ld a, $00 ; $4dbf
	farcall FarPtr_ScriptWaitActorMoveDone ; $4dc1
	ld a, $00 ; $4dc4
	ld bc, $1800 ; $4dc6
	ld de, $1300 ; $4dc9
	farcall FarPtr_ScriptSetActorMoveTarget ; $4dcc
	ld hl, $01a3 ; $4dcf
	farcall FarPtr_InitDialogueTextCursor ; $4dd2
	push af ; $4dd5
	ld a, $78 ; $4dd6
	farcall FarPtr_WaitScriptFrames ; $4dd8
	pop af ; $4ddb
	ld a, $12 ; $4ddc
	ld bc, $1800 ; $4dde
	ld de, $0f00 ; $4de1
	farcall FarPtr_ScriptSetActorPosition ; $4de4
	ld a, $00 ; $4de7
	farcall FarPtr_ScriptWaitActorMoveDone ; $4de9
	ld a, [$c90d] ; $4dec
	or a, a ; $4def
	jr z, Label_11_4df5 ; $4df0
	farcall FarPtr_AdvanceDialogueTextCursor ; $4df2
Label_11_4df5:
	ld a, $12 ; $4df5
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4df7
	ld a, $0f ; $4dfa
	ld bc, $1940 ; $4dfc
	ld de, $11c0 ; $4dff
	farcall FarPtr_ScriptSetActorPosition ; $4e02
	sound $97 ; $4e05
	push af ; $4e07
	ld a, $28 ; $4e08
	farcall FarPtr_WaitScriptFrames ; $4e0a
	pop af ; $4e0d
	ld a, $0f ; $4e0e
	ld bc, $3f00 ; $4e10
	ld de, $3f00 ; $4e13
	farcall FarPtr_ScriptSetActorPosition ; $4e16
	ld a, $12 ; $4e19
	ld b, a ; $4e1b
	ld a, $00 ; $4e1c
	farcall FarPtr_FaceActorTowardActor ; $4e1e
	ld bc, $0020 ; $4e21
	farcall FarPtr_SetPlayerMoveSpeed ; $4e24
	ld a, $12 ; $4e27
	ld bc, $1800 ; $4e29
	ld de, $1100 ; $4e2c
	farcall FarPtr_ScriptSetActorMoveTarget ; $4e2f
	push af ; $4e32
	ld a, $0f ; $4e33
	farcall FarPtr_WaitScriptFrames ; $4e35
	pop af ; $4e38
	xor a, a ; $4e39
	ld bc, $1800 ; $4e3a
	ld de, $1100 ; $4e3d
	farcall FarPtr_MovePlayerToPosition ; $4e40
	farcall FarPtr_WaitPlayerMoveDone ; $4e43
	push af ; $4e46
	ld a, $3c ; $4e47
	farcall FarPtr_WaitScriptFrames ; $4e49
	pop af ; $4e4c
	ld a, $00 ; $4e4d
	ld b, a ; $4e4f
	ld a, $12 ; $4e50
	farcall FarPtr_FaceActorsTowardEachOther ; $4e52
	push af ; $4e55
	ld a, $1e ; $4e56
	farcall FarPtr_WaitScriptFrames ; $4e58
	pop af ; $4e5b
	ld a, $00 ; $4e5c
	ld d, $03 ; $4e5e
	farcall FarPtr_ScriptSetActorAnimation ; $4e60
	ld a, $00 ; $4e63
	farcall FarPtr_ScriptWaitActorIdle ; $4e65
	push af ; $4e68
	ld a, $0f ; $4e69
	farcall FarPtr_WaitScriptFrames ; $4e6b
	pop af ; $4e6e
	ld a, $12 ; $4e6f
	ld d, $03 ; $4e71
	farcall FarPtr_ScriptSetActorAnimation ; $4e73
	ld a, $12 ; $4e76
	farcall FarPtr_ScriptWaitActorIdle ; $4e78
	ld hl, $01a5 ; $4e7b
	farcall FarPtr_InitDialogueTextCursor ; $4e7e
	ld a, $03 ; $4e81
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4e83
	ld a, $0e ; $4e86
	ld bc, $1940 ; $4e88
	ld de, $11c0 ; $4e8b
	farcall FarPtr_ScriptSetActorPosition ; $4e8e
	sound $98 ; $4e91
	push af ; $4e93
	ld a, $32 ; $4e94
	farcall FarPtr_WaitScriptFrames ; $4e96
	pop af ; $4e99
	ld a, $0e ; $4e9a
	ld bc, $3f00 ; $4e9c
	ld de, $3f00 ; $4e9f
	farcall FarPtr_ScriptSetActorPosition ; $4ea2
	ld a, $12 ; $4ea5
	ld d, $03 ; $4ea7
	farcall FarPtr_ScriptSetActorAnimation ; $4ea9
	ld a, $12 ; $4eac
	farcall FarPtr_ScriptWaitActorIdle ; $4eae
	ld a, $12 ; $4eb1
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4eb3
	push af ; $4eb6
	ld a, $0f ; $4eb7
	farcall FarPtr_WaitScriptFrames ; $4eb9
	pop af ; $4ebc
	ld a, $12 ; $4ebd
	ld d, $02 ; $4ebf
	farcall FarPtr_ScriptSetActorAnimation ; $4ec1
	ld a, $12 ; $4ec4
	farcall FarPtr_ScriptWaitActorIdle ; $4ec6
	ld a, $12 ; $4ec9
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4ecb
	farcall FarPtr_RunDialogueYesNoPrompt ; $4ece
	farcall FarPtr_ScriptCloseDialogueWindow ; $4ed1
	push af ; $4ed4
	ld a, $05 ; $4ed5
	farcall FarPtr_WaitScriptFrames ; $4ed7
	pop af ; $4eda
	and a, a ; $4edb
	jr z, Label_11_4ee1 ; $4edc
	farcall FarPtr_AdvanceDialogueTextCursor ; $4ede
Label_11_4ee1:
	ld a, $12 ; $4ee1
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4ee3
	farcall FarPtr_RunDialogueYesNoPrompt ; $4ee6
	farcall FarPtr_ScriptCloseDialogueWindow ; $4ee9
	push af ; $4eec
	ld a, $05 ; $4eed
	farcall FarPtr_WaitScriptFrames ; $4eef
	pop af ; $4ef2
	and a, a ; $4ef3
	jr z, Label_11_4f0c ; $4ef4
	xor a, a ; $4ef6
	ld [wStoryModeShowLocationName], a ; $4ef7
	ld hl, $01ab ; $4efa
	farcall FarPtr_InitDialogueTextCursor ; $4efd
	ld a, $12 ; $4f00
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4f02
	set_flag $05, 6 ; $4f05
	call Func_11_4f1b ; $4f08
	ret ; $4f0b
Label_11_4f0c:
	ld hl, $01aa ; $4f0c
	farcall FarPtr_InitDialogueTextCursor ; $4f0f
	ld a, $12 ; $4f12
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4f14
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
	ld a, $12 ; $4f40
	ld d, $02 ; $4f42
	farcall FarPtr_ScriptSetActorAnimation ; $4f44
	ld a, $12 ; $4f47
	farcall FarPtr_ScriptWaitActorIdle ; $4f49
	ld a, $00 ; $4f4c
	ld bc, $1800 ; $4f4e
	ld de, $1300 ; $4f51
	farcall FarPtr_ScriptSetActorMoveTarget ; $4f54
	ld a, $00 ; $4f57
	farcall FarPtr_ScriptWaitActorMoveDone ; $4f59
	ld a, $12 ; $4f5c
	ld b, a ; $4f5e
	ld a, $00 ; $4f5f
	farcall FarPtr_FaceActorTowardActor ; $4f61
	ld a, $12 ; $4f64
	ld d, $03 ; $4f66
	farcall FarPtr_ScriptSetActorAnimation ; $4f68
	ld a, $12 ; $4f6b
	farcall FarPtr_ScriptWaitActorIdle ; $4f6d
	ld hl, $01ac ; $4f70
	farcall FarPtr_InitDialogueTextCursor ; $4f73
	ld a, $12 ; $4f76
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4f78
	ld a, $12 ; $4f7b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4f7d
	call FollowGuideIntoAcademy ; $4f80
	ret ; $4f83
FollowGuideIntoAcademy:
	ld a, $00 ; $4f84
	ld bc, $0018 ; $4f86
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4f89
	ld a, $12 ; $4f8c
	ld bc, $0018 ; $4f8e
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4f91
	clear_flag $05, 6 ; $4f94
	ld a, $12 ; $4f97
	ld bc, $1800 ; $4f99
	ld de, $0e00 ; $4f9c
	farcall FarPtr_ScriptSetActorMoveTarget ; $4f9f
	ld a, $00 ; $4fa2
	ld bc, $1800 ; $4fa4
	ld de, $0e00 ; $4fa7
	farcall FarPtr_ScriptSetActorMoveTarget ; $4faa
	push af ; $4fad
	ld a, $1e ; $4fae
	farcall FarPtr_WaitScriptFrames ; $4fb0
	pop af ; $4fb3
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
	ld a, $02 ; $4fe5
	ld bc, $3f00 ; $4fe7
	ld de, $3f00 ; $4fea
	farcall FarPtr_ScriptSetActorPosition ; $4fed
	ld a, [$c94d] ; $4ff0
	ld d, $58 ; $4ff3
	add a, d ; $4ff5
	ld d, a ; $4ff6
	ld a, $05 ; $4ff7
	farcall FarPtr_GetActorStateAddr ; $4ff9
	ld c, l ; $4ffc
	ld b, h ; $4ffd
	farcall FarPtr_04_2c ; $4ffe
	ld a, $05 ; $5001
	ld d, $01 ; $5003
	farcall FarPtr_ScriptSetActorAnimation ; $5005
	ld a, $07 ; $5008
	ld bc, $1a00 ; $500a
	ld de, $1100 ; $500d
	farcall FarPtr_ScriptSetActorPosition ; $5010
	ld a, $07 ; $5013
	ld b, $40 ; $5015
	farcall FarPtr_SetActorFacing ; $5017
Label_11_501a:
	ld a, [$c90d] ; $501a
	ld d, $56 ; $501d
	add a, d ; $501f
	ld d, a ; $5020
	ld a, $00 ; $5021
	farcall FarPtr_GetActorStateAddr ; $5023
	ld c, l ; $5026
	ld b, h ; $5027
	farcall FarPtr_04_2c ; $5028
	ld a, $00 ; $502b
	ld d, $01 ; $502d
	farcall FarPtr_ScriptSetActorAnimation ; $502f
	ld a, $00 ; $5032
	ld bc, $1700 ; $5034
	ld de, $1700 ; $5037
	farcall FarPtr_ScriptSetActorPosition ; $503a
	ld a, $00 ; $503d
	ld b, $c0 ; $503f
	farcall FarPtr_SetActorFacing ; $5041
	ld a, $03 ; $5044
	ld b, $00 ; $5046
	farcall FarPtr_MovePlayerToActor ; $5048
	farcall FarPtr_WaitPlayerMoveDone ; $504b
	ld c, $08 ; $504e
	call BeginFadeIn ; $5050
	call WaitFadeEnd ; $5053
	push af ; $5056
	ld a, $3c ; $5057
	farcall FarPtr_WaitScriptFrames ; $5059
	pop af ; $505c
	ld hl, $01ed ; $505d
	farcall FarPtr_InitDialogueTextCursor ; $5060
	ld a, $03 ; $5063
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5065
	test_flag $05, 7 ; $5068
	jp z, Label_11_5158 ; $506b
	ld a, $04 ; $506e
	ld d, $03 ; $5070
	farcall FarPtr_ScriptSetActorAnimation ; $5072
	ld a, $06 ; $5075
	ld d, $03 ; $5077
	farcall FarPtr_ScriptSetActorAnimation ; $5079
	ld a, $06 ; $507c
	farcall FarPtr_ScriptWaitActorIdle ; $507e
	push af ; $5081
	ld a, $1e ; $5082
	farcall FarPtr_WaitScriptFrames ; $5084
	pop af ; $5087
	ld a, $05 ; $5088
	ld b, a ; $508a
	ld a, $00 ; $508b
	farcall FarPtr_FaceActorsTowardEachOther ; $508d
	push af ; $5090
	ld a, $1e ; $5091
	farcall FarPtr_WaitScriptFrames ; $5093
	pop af ; $5096
	ld a, $00 ; $5097
	ld d, $03 ; $5099
	farcall FarPtr_ScriptSetActorAnimation ; $509b
	ld a, $05 ; $509e
	ld d, $03 ; $50a0
	farcall FarPtr_ScriptSetActorAnimation ; $50a2
	ld a, $05 ; $50a5
	farcall FarPtr_ScriptWaitActorIdle ; $50a7
	push af ; $50aa
	ld a, $1e ; $50ab
	farcall FarPtr_WaitScriptFrames ; $50ad
	pop af ; $50b0
	ld a, $05 ; $50b1
	ld b, $c0 ; $50b3
	farcall FarPtr_SetActorFacing ; $50b5
	push af ; $50b8
	ld a, $1e ; $50b9
	farcall FarPtr_WaitScriptFrames ; $50bb
	pop af ; $50be
	ld a, $00 ; $50bf
	ld d, $03 ; $50c1
	farcall FarPtr_ScriptSetActorAnimation ; $50c3
	ld a, $05 ; $50c6
	ld d, $03 ; $50c8
	farcall FarPtr_ScriptSetActorAnimation ; $50ca
	ld a, $05 ; $50cd
	farcall FarPtr_ScriptWaitActorIdle ; $50cf
	push af ; $50d2
	ld a, $1e ; $50d3
	farcall FarPtr_WaitScriptFrames ; $50d5
	pop af ; $50d8
	ld a, $03 ; $50d9
	ld d, $03 ; $50db
	farcall FarPtr_ScriptSetActorAnimation ; $50dd
	ld a, $03 ; $50e0
	farcall FarPtr_ScriptWaitActorIdle ; $50e2
	push af ; $50e5
	ld a, $0a ; $50e6
	farcall FarPtr_WaitScriptFrames ; $50e8
	pop af ; $50eb
	ld a, $07 ; $50ec
	ld d, $02 ; $50ee
	farcall FarPtr_ScriptSetActorAnimation ; $50f0
	ld a, $07 ; $50f3
	farcall FarPtr_ScriptWaitActorIdle ; $50f5
	ld a, $07 ; $50f8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $50fa
	ld a, $04 ; $50fd
	ld d, $03 ; $50ff
	farcall FarPtr_ScriptSetActorAnimation ; $5101
	ld a, $05 ; $5104
	ld d, $03 ; $5106
	farcall FarPtr_ScriptSetActorAnimation ; $5108
	ld a, $00 ; $510b
	ld d, $03 ; $510d
	farcall FarPtr_ScriptSetActorAnimation ; $510f
	ld a, $06 ; $5112
	ld d, $03 ; $5114
	farcall FarPtr_ScriptSetActorAnimation ; $5116
	ld a, $06 ; $5119
	farcall FarPtr_ScriptWaitActorIdle ; $511b
	push af ; $511e
	ld a, $1e ; $511f
	farcall FarPtr_WaitScriptFrames ; $5121
	pop af ; $5124
	ld a, $07 ; $5125
	ld b, a ; $5127
	ld a, $03 ; $5128
	farcall FarPtr_FaceActorsTowardEachOther ; $512a
	ld a, $03 ; $512d
	ld d, $03 ; $512f
	farcall FarPtr_ScriptSetActorAnimation ; $5131
	ld a, $07 ; $5134
	ld d, $03 ; $5136
	farcall FarPtr_ScriptSetActorAnimation ; $5138
	ld a, $07 ; $513b
	farcall FarPtr_ScriptWaitActorIdle ; $513d
	ld a, $07 ; $5140
	ld b, $40 ; $5142
	farcall FarPtr_SetActorFacing ; $5144
	ld a, $03 ; $5147
	ld b, $40 ; $5149
	farcall FarPtr_SetActorFacing ; $514b
	push af ; $514e
	ld a, $1e ; $514f
	farcall FarPtr_WaitScriptFrames ; $5151
	pop af ; $5154
	jp Label_11_51d9 ; $5155
Label_11_5158:
	ld a, $04 ; $5158
	ld d, $03 ; $515a
	farcall FarPtr_ScriptSetActorAnimation ; $515c
	ld a, $05 ; $515f
	ld d, $03 ; $5161
	farcall FarPtr_ScriptSetActorAnimation ; $5163
	ld a, $05 ; $5166
	farcall FarPtr_ScriptWaitActorIdle ; $5168
	push af ; $516b
	ld a, $1e ; $516c
	farcall FarPtr_WaitScriptFrames ; $516e
	pop af ; $5171
	ld a, $06 ; $5172
	ld b, a ; $5174
	ld a, $00 ; $5175
	farcall FarPtr_FaceActorsTowardEachOther ; $5177
	push af ; $517a
	ld a, $1e ; $517b
	farcall FarPtr_WaitScriptFrames ; $517d
	pop af ; $5180
	ld a, $00 ; $5181
	ld d, $03 ; $5183
	farcall FarPtr_ScriptSetActorAnimation ; $5185
	ld a, $06 ; $5188
	ld d, $03 ; $518a
	farcall FarPtr_ScriptSetActorAnimation ; $518c
	ld a, $06 ; $518f
	farcall FarPtr_ScriptWaitActorIdle ; $5191
	push af ; $5194
	ld a, $1e ; $5195
	farcall FarPtr_WaitScriptFrames ; $5197
	pop af ; $519a
	ld a, $00 ; $519b
	ld b, $c0 ; $519d
	farcall FarPtr_SetActorFacing ; $519f
	ld a, $06 ; $51a2
	ld b, $c0 ; $51a4
	farcall FarPtr_SetActorFacing ; $51a6
	push af ; $51a9
	ld a, $1e ; $51aa
	farcall FarPtr_WaitScriptFrames ; $51ac
	pop af ; $51af
	ld a, $00 ; $51b0
	ld d, $03 ; $51b2
	farcall FarPtr_ScriptSetActorAnimation ; $51b4
	ld a, $06 ; $51b7
	ld d, $03 ; $51b9
	farcall FarPtr_ScriptSetActorAnimation ; $51bb
	ld a, $06 ; $51be
	farcall FarPtr_ScriptWaitActorIdle ; $51c0
	push af ; $51c3
	ld a, $1e ; $51c4
	farcall FarPtr_WaitScriptFrames ; $51c6
	pop af ; $51c9
	ld a, $03 ; $51ca
	ld d, $03 ; $51cc
	farcall FarPtr_ScriptSetActorAnimation ; $51ce
	ld a, $03 ; $51d1
	farcall FarPtr_ScriptWaitActorIdle ; $51d3
	farcall FarPtr_AdvanceDialogueTextCursor ; $51d6
Label_11_51d9:
	ld a, $03 ; $51d9
	farcall FarPtr_ScriptShowSpeakerDialogue ; $51db
	push af ; $51de
	ld a, $1e ; $51df
	farcall FarPtr_WaitScriptFrames ; $51e1
	pop af ; $51e4
	ld a, $04 ; $51e5
	ld d, $03 ; $51e7
	farcall FarPtr_ScriptSetActorAnimation ; $51e9
	ld a, $05 ; $51ec
	ld d, $03 ; $51ee
	farcall FarPtr_ScriptSetActorAnimation ; $51f0
	ld a, $00 ; $51f3
	ld d, $03 ; $51f5
	farcall FarPtr_ScriptSetActorAnimation ; $51f7
	ld a, $06 ; $51fa
	ld d, $03 ; $51fc
	farcall FarPtr_ScriptSetActorAnimation ; $51fe
	ld a, $06 ; $5201
	farcall FarPtr_ScriptWaitActorIdle ; $5203
	push af ; $5206
	ld a, $14 ; $5207
	farcall FarPtr_WaitScriptFrames ; $5209
	pop af ; $520c
	ld a, $06 ; $520d
	ld b, a ; $520f
	ld a, $00 ; $5210
	farcall FarPtr_FaceActorsTowardEachOther ; $5212
	ld a, $04 ; $5215
	ld b, a ; $5217
	ld a, $05 ; $5218
	farcall FarPtr_FaceActorsTowardEachOther ; $521a
	push af ; $521d
	ld a, $0a ; $521e
	farcall FarPtr_WaitScriptFrames ; $5220
	pop af ; $5223
	ld a, $00 ; $5224
	ld b, $01 ; $5226
	farcall FarPtr_ScriptSetActorFacingLock ; $5228
	ld a, $06 ; $522b
	ld b, $01 ; $522d
	farcall FarPtr_ScriptSetActorFacingLock ; $522f
	ld a, $05 ; $5232
	ld b, $01 ; $5234
	farcall FarPtr_ScriptSetActorFacingLock ; $5236
	ld a, $04 ; $5239
	ld b, $01 ; $523b
	farcall FarPtr_ScriptSetActorFacingLock ; $523d
	ld a, $00 ; $5240
	ld bc, $1600 ; $5242
	ld de, $1700 ; $5245
	farcall FarPtr_ScriptSetActorMoveTarget ; $5248
	ld a, $06 ; $524b
	ld bc, $1a00 ; $524d
	ld de, $1700 ; $5250
	farcall FarPtr_ScriptSetActorMoveTarget ; $5253
	ld a, $05 ; $5256
	ld bc, $1500 ; $5258
	ld de, $1500 ; $525b
	farcall FarPtr_ScriptSetActorMoveTarget ; $525e
	ld a, $04 ; $5261
	ld bc, $1b00 ; $5263
	ld de, $1500 ; $5266
	farcall FarPtr_ScriptSetActorMoveTarget ; $5269
	ld a, $04 ; $526c
	farcall FarPtr_ScriptWaitActorMoveDone ; $526e
	xor a, a ; $5271
	ld bc, $1800 ; $5272
	ld de, $2f00 ; $5275
	farcall FarPtr_MovePlayerToPosition ; $5278
	ld a, $03 ; $527b
	ld bc, $1800 ; $527d
	ld de, $1900 ; $5280
	farcall FarPtr_ScriptSetActorMoveTarget ; $5283
	ld a, $03 ; $5286
	farcall FarPtr_ScriptWaitActorMoveDone ; $5288
	ld a, $00 ; $528b
	ld b, $00 ; $528d
	farcall FarPtr_ScriptSetActorFacingLock ; $528f
	ld a, $06 ; $5292
	ld b, $00 ; $5294
	farcall FarPtr_ScriptSetActorFacingLock ; $5296
	ld a, $05 ; $5299
	ld b, $00 ; $529b
	farcall FarPtr_ScriptSetActorFacingLock ; $529d
	ld a, $04 ; $52a0
	ld b, $00 ; $52a2
	farcall FarPtr_ScriptSetActorFacingLock ; $52a4
	ld a, $00 ; $52a7
	ld bc, $1600 ; $52a9
	ld de, $2b00 ; $52ac
	farcall FarPtr_ScriptSetActorMoveTarget ; $52af
	ld a, $06 ; $52b2
	ld bc, $1a00 ; $52b4
	ld de, $2b00 ; $52b7
	farcall FarPtr_ScriptSetActorMoveTarget ; $52ba
	ld a, $05 ; $52bd
	ld bc, $1500 ; $52bf
	ld de, $2900 ; $52c2
	farcall FarPtr_ScriptSetActorMoveTarget ; $52c5
	ld a, $04 ; $52c8
	ld bc, $1b00 ; $52ca
	ld de, $2900 ; $52cd
	farcall FarPtr_ScriptSetActorMoveTarget ; $52d0
	ld a, $03 ; $52d3
	ld bc, $1800 ; $52d5
	ld de, $2d00 ; $52d8
	farcall FarPtr_ScriptSetActorMoveTarget ; $52db
	ld a, $03 ; $52de
	farcall FarPtr_ScriptWaitActorMoveDone ; $52e0
	ld a, $08 ; $52e3
	ld d, $03 ; $52e5
	farcall FarPtr_ScriptSetActorAnimation ; $52e7
	ld a, $00 ; $52ea
	ld bc, $1700 ; $52ec
	ld de, $2f00 ; $52ef
	farcall FarPtr_ScriptSetActorMoveTarget ; $52f2
	ld a, $06 ; $52f5
	ld bc, $1900 ; $52f7
	ld de, $2f00 ; $52fa
	farcall FarPtr_ScriptSetActorMoveTarget ; $52fd
	ld a, $05 ; $5300
	ld bc, $1700 ; $5302
	ld de, $2d00 ; $5305
	farcall FarPtr_ScriptSetActorMoveTarget ; $5308
	ld a, $04 ; $530b
	ld bc, $1900 ; $530d
	ld de, $2d00 ; $5310
	farcall FarPtr_ScriptSetActorMoveTarget ; $5313
	ld a, $03 ; $5316
	ld bc, $1800 ; $5318
	ld de, $3100 ; $531b
	farcall FarPtr_ScriptSetActorMoveTarget ; $531e
	ld a, $03 ; $5321
	farcall FarPtr_ScriptWaitActorMoveDone ; $5323
	ld a, $00 ; $5326
	ld bc, $1700 ; $5328
	ld de, $3b00 ; $532b
	farcall FarPtr_ScriptSetActorMoveTarget ; $532e
	ld a, $06 ; $5331
	ld bc, $1900 ; $5333
	ld de, $3b00 ; $5336
	farcall FarPtr_ScriptSetActorMoveTarget ; $5339
	ld a, $05 ; $533c
	ld bc, $1700 ; $533e
	ld de, $3900 ; $5341
	farcall FarPtr_ScriptSetActorMoveTarget ; $5344
	ld a, $04 ; $5347
	ld bc, $1900 ; $5349
	ld de, $3900 ; $534c
	farcall FarPtr_ScriptSetActorMoveTarget ; $534f
	ld a, $03 ; $5352
	ld bc, $1800 ; $5354
	ld de, $3d00 ; $5357
	farcall FarPtr_ScriptSetActorMoveTarget ; $535a
	ld a, $03 ; $535d
	farcall FarPtr_ScriptWaitActorMoveDone ; $535f
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
	ld bc, $00ff ; $53e6
	farcall FarPtr_SetPlayerMoveSpeed ; $53e9
	xor a, a ; $53ec
	ld bc, $1800 ; $53ed
	ld de, $2f00 ; $53f0
	farcall FarPtr_MovePlayerToPosition ; $53f3
	farcall FarPtr_WaitPlayerMoveDone ; $53f6
	test_flag $05, 7 ; $53f9
	jp z, Label_11_5415 ; $53fc
	ld a, $02 ; $53ff
	ld bc, $1800 ; $5401
	ld de, $1d00 ; $5404
	farcall FarPtr_ScriptSetActorPosition ; $5407
	ld a, $02 ; $540a
	ld bc, $1800 ; $540c
	ld de, $3900 ; $540f
	farcall FarPtr_ScriptSetActorMoveTarget ; $5412
Label_11_5415:
	ld a, $00 ; $5415
	ld bc, $1800 ; $5417
	ld de, $1f00 ; $541a
	farcall FarPtr_ScriptSetActorPosition ; $541d
	ld a, $00 ; $5420
	ld bc, $1800 ; $5422
	ld de, $3b00 ; $5425
	farcall FarPtr_ScriptSetActorMoveTarget ; $5428
	xor a, a ; $542b
	ld [wStoryModeShowLocationName], a ; $542c
	ld c, $04 ; $542f
	call BeginFadeIn ; $5431
	call WaitFadeEnd ; $5434
	push af ; $5437
	ld a, $3c ; $5438
	farcall FarPtr_WaitScriptFrames ; $543a
	pop af ; $543d
	ld a, $03 ; $543e
	ld d, $03 ; $5440
	farcall FarPtr_ScriptSetActorAnimation ; $5442
	ld a, $03 ; $5445
	farcall FarPtr_ScriptWaitActorIdle ; $5447
	ld a, $00 ; $544a
	farcall FarPtr_ScriptWaitActorMoveDone ; $544c
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
	ld a, $14 ; $54ad
	ld bc, $1500 ; $54af
	ld de, $3000 ; $54b2
	farcall FarPtr_ScriptSetActorPosition ; $54b5
	ld a, $14 ; $54b8
	ld b, $00 ; $54ba
	farcall FarPtr_SetActorFacing ; $54bc
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
	ld hl, $0869 ; $55b0
	farcall FarPtr_InitDialogueTextCursor ; $55b3
	test_flag $08, 2 ; $55b6
	jr nz, Label_11_55c6 ; $55b9
	farcall FarPtr_AdvanceDialogueTextCursor ; $55bb
	test_flag $08, 1 ; $55be
	jr nz, Label_11_55c6 ; $55c1
	farcall FarPtr_AdvanceDialogueTextCursor ; $55c3
Label_11_55c6:
	ld a, $04 ; $55c6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $55c8
	ret ; $55cb
	ld hl, $0878 ; $55cc
	farcall FarPtr_InitDialogueTextCursor ; $55cf
	test_flag $08, 1 ; $55d2
	jr nz, Label_11_55e2 ; $55d5
	farcall FarPtr_AdvanceDialogueTextCursor ; $55d7
	test_flag $08, 0 ; $55da
	jr nz, Label_11_55e2 ; $55dd
	farcall FarPtr_AdvanceDialogueTextCursor ; $55df
Label_11_55e2:
	ld a, $05 ; $55e2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $55e4
	ret ; $55e7
	ld hl, $086c ; $55e8
	farcall FarPtr_InitDialogueTextCursor ; $55eb
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
	push af ; $5609
	ld a, $05 ; $560a
	farcall FarPtr_WaitScriptFrames ; $560c
	pop af ; $560f
	and a, a ; $5610
	jr z, Label_11_5616 ; $5611
	farcall FarPtr_AdvanceDialogueTextCursor ; $5613
Label_11_5616:
	ld a, $06 ; $5616
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5618
	ret ; $561b
	ld hl, $087b ; $561c
	farcall FarPtr_InitDialogueTextCursor ; $561f
	test_flag $08, 1 ; $5622
	jr nz, Label_11_5632 ; $5625
	farcall FarPtr_AdvanceDialogueTextCursor ; $5627
	test_flag $08, 0 ; $562a
	jr nz, Label_11_5632 ; $562d
	farcall FarPtr_AdvanceDialogueTextCursor ; $562f
Label_11_5632:
	ld a, $07 ; $5632
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5634
	ret ; $5637
	ld hl, $087e ; $5638
	farcall FarPtr_InitDialogueTextCursor ; $563b
	test_flag $08, 0 ; $563e
	jr nz, Label_11_5646 ; $5641
	farcall FarPtr_AdvanceDialogueTextCursor ; $5643
Label_11_5646:
	ld a, $08 ; $5646
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5648
	ret ; $564b
	ld hl, $0880 ; $564c
	farcall FarPtr_InitDialogueTextCursor ; $564f
	test_flag $08, 0 ; $5652
	jr nz, Label_11_5646 ; $5655
	farcall FarPtr_AdvanceDialogueTextCursor ; $5657
	ld a, $09 ; $565a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $565c
	ret ; $565f
Label_11_5660:
	ld a, $0a ; $5660
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5662
	ld a, $0b ; $5665
	ld b, a ; $5667
	ld a, $0a ; $5668
	farcall FarPtr_FaceActorsTowardEachOther ; $566a
	ret ; $566d
Label_11_566e:
	ld hl, $0887 ; $566e
	farcall FarPtr_InitDialogueTextCursor ; $5671
	test_flag $08, 0 ; $5674
	jp nz, Label_11_5660 ; $5677
	ld hl, $0883 ; $567a
	farcall FarPtr_InitDialogueTextCursor ; $567d
	ld a, $0a ; $5680
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5682
	farcall FarPtr_RunDialogueYesNoPrompt ; $5685
	farcall FarPtr_ScriptCloseDialogueWindow ; $5688
	push af ; $568b
	ld a, $05 ; $568c
	farcall FarPtr_WaitScriptFrames ; $568e
	pop af ; $5691
	and a, a ; $5692
	jr nz, Label_11_5660 ; $5693
	farcall FarPtr_AdvanceDialogueTextCursor ; $5695
	ld a, $00 ; $5698
	ld b, a ; $569a
	ld a, $0b ; $569b
	farcall FarPtr_FaceActorTowardActor ; $569d
	ld a, $0a ; $56a0
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $56a2
	farcall FarPtr_RunDialogueYesNoPrompt ; $56a5
	farcall FarPtr_ScriptCloseDialogueWindow ; $56a8
	push af ; $56ab
	ld a, $05 ; $56ac
	farcall FarPtr_WaitScriptFrames ; $56ae
	pop af ; $56b1
	and a, a ; $56b2
	jr nz, Label_11_5660 ; $56b3
	ld a, $00 ; $56b5
	ld d, $03 ; $56b7
	farcall FarPtr_ScriptSetActorAnimation ; $56b9
	ld a, $02 ; $56bc
	farcall FarPtr_SetActorNullScript ; $56be
	ld a, $02 ; $56c1
	ld bc, $0020 ; $56c3
	farcall FarPtr_ScriptSetActorMoveSpeed ; $56c6
	ld a, $00 ; $56c9
	ld bc, $0020 ; $56cb
	farcall FarPtr_ScriptSetActorMoveSpeed ; $56ce
	ldh a, [hRomBank] ; $56d1
	ld b, a ; $56d3
	ld a, $00 ; $56d4
	ld de, $5bc6 ; $56d6
	farcall FarPtr_ScriptSetActorScript ; $56d9
	push af ; $56dc
	ld a, $14 ; $56dd
	farcall FarPtr_WaitScriptFrames ; $56df
	pop af ; $56e2
	ldh a, [hRomBank] ; $56e3
	ld b, a ; $56e5
	ld a, $02 ; $56e6
	ld de, $5be0 ; $56e8
	farcall FarPtr_ScriptSetActorScript ; $56eb
	push af ; $56ee
	ld a, $1e ; $56ef
	farcall FarPtr_WaitScriptFrames ; $56f1
	pop af ; $56f4
	xor a, a ; $56f5
	ld bc, $3500 ; $56f6
	ld de, $1100 ; $56f9
	farcall FarPtr_MovePlayerToPosition ; $56fc
	ld a, $0a ; $56ff
	ld bc, $3700 ; $5701
	ld de, $0d00 ; $5704
	farcall FarPtr_ScriptSetActorMoveTarget ; $5707
	ld a, $0b ; $570a
	ld bc, $3500 ; $570c
	ld de, $0900 ; $570f
	farcall FarPtr_ScriptSetActorMoveTarget ; $5712
	ld a, $0a ; $5715
	farcall FarPtr_ScriptWaitActorMoveDone ; $5717
	ld a, $0a ; $571a
	ld b, $40 ; $571c
	farcall FarPtr_SetActorFacing ; $571e
	ld a, $0b ; $5721
	ld b, $40 ; $5723
	farcall FarPtr_SetActorFacing ; $5725
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
	ld a, $0a ; $5747
	ld d, $03 ; $5749
	farcall FarPtr_ScriptSetActorAnimation ; $574b
	ld a, $00 ; $574e
	ld d, $03 ; $5750
	farcall FarPtr_ScriptSetActorAnimation ; $5752
	ld a, $00 ; $5755
	farcall FarPtr_ScriptWaitActorIdle ; $5757
	farcall FarPtr_InitStoryMatchSettings ; $575a
	ld a, $01 ; $575d
	ld [wCurrentMinigameStoryMatch], a ; $575f
	ld a, $00 ; $5762
	ld [$c8f7], a ; $5764
	farcall FarPtr_LoadMatchSettingsFromTable ; $5767
	farcall FarPtr_RunStoryMatch ; $576a
	farcall FarPtr_RestoreOverworldAfterMatch ; $576d
	ret ; $5770
	ld hl, $0888 ; $5771
	farcall FarPtr_InitDialogueTextCursor ; $5774
	test_flag $08, 0 ; $5777
	jr nz, Label_11_57c6 ; $577a
	ld hl, $0882 ; $577c
	farcall FarPtr_InitDialogueTextCursor ; $577f
	ld a, $0b ; $5782
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5784
	ld a, $00 ; $5787
	ld b, a ; $5789
	ld a, $0a ; $578a
	farcall FarPtr_FaceActorTowardActor ; $578c
	ld a, $0a ; $578f
	ld d, $02 ; $5791
	farcall FarPtr_ScriptSetActorAnimation ; $5793
	ld a, $0a ; $5796
	farcall FarPtr_ScriptWaitActorIdle ; $5798
	jp Label_11_566e ; $579b
	ld hl, $0852 ; $579e
	farcall FarPtr_InitDialogueTextCursor ; $57a1
	ld a, $00 ; $57a4
	ld b, a ; $57a6
	ld a, $0a ; $57a7
	farcall FarPtr_FaceActorTowardActor ; $57a9
	ld a, $0a ; $57ac
	ld d, $04 ; $57ae
	farcall FarPtr_ScriptSetActorAnimation ; $57b0
	ld a, $0a ; $57b3
	farcall FarPtr_ScriptWaitActorIdle ; $57b5
	ld a, $0a ; $57b8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $57ba
	ld a, $0b ; $57bd
	ld b, a ; $57bf
	ld a, $0a ; $57c0
	farcall FarPtr_FaceActorTowardActor ; $57c2
	ret ; $57c5
Label_11_57c6:
	ld a, $0b ; $57c6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $57c8
	ret ; $57cb
	ld hl, $0897 ; $57cc
	farcall FarPtr_InitDialogueTextCursor ; $57cf
	ld a, $0a ; $57d2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $57d4
	ld a, $0a ; $57d7
	ld d, $04 ; $57d9
	farcall FarPtr_ScriptSetActorAnimation ; $57db
	ld a, $0a ; $57de
	farcall FarPtr_ScriptWaitActorIdle ; $57e0
	ld a, $0a ; $57e3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $57e5
	ret ; $57e8
	ld a, $00 ; $57e9
	ld bc, $0008 ; $57eb
	farcall FarPtr_ScriptSetActorMoveSpeed ; $57ee
	ld a, $00 ; $57f1
	ld b, $01 ; $57f3
	farcall FarPtr_ScriptSetActorFacingLock ; $57f5
	ld a, $00 ; $57f8
	ld bc, $1300 ; $57fa
	ld de, $1500 ; $57fd
	farcall FarPtr_ScriptSetActorMoveTarget ; $5800
	ld a, $00 ; $5803
	farcall FarPtr_ScriptWaitActorMoveDone ; $5805
	ld a, $00 ; $5808
	ld b, $00 ; $580a
	farcall FarPtr_ScriptSetActorFacingLock ; $580c
	ld a, $00 ; $580f
	ld b, $c0 ; $5811
	farcall FarPtr_SetActorFacing ; $5813
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
	ld hl, $08ba ; $5946
	farcall FarPtr_InitDialogueTextCursor ; $5949
	ld a, $07 ; $594c
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $594e
	farcall FarPtr_RunDialogueYesNoPrompt ; $5951
	farcall FarPtr_ScriptCloseDialogueWindow ; $5954
	push af ; $5957
	ld a, $05 ; $5958
	farcall FarPtr_WaitScriptFrames ; $595a
	pop af ; $595d
	and a, a ; $595e
	jp z, Label_11_5965 ; $595f
	farcall FarPtr_AdvanceDialogueTextCursor ; $5962
Label_11_5965:
	ld a, $07 ; $5965
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5967
	ret ; $596a
	ld hl, $0c18 ; $596b
	farcall FarPtr_InitDialogueTextCursor ; $596e
	ld a, $07 ; $5971
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5973
	farcall FarPtr_RunDialogueYesNoPrompt ; $5976
	farcall FarPtr_ScriptCloseDialogueWindow ; $5979
	push af ; $597c
	ld a, $05 ; $597d
	farcall FarPtr_WaitScriptFrames ; $597f
	pop af ; $5982
	and a, a ; $5983
	jp z, Label_11_598a ; $5984
	farcall FarPtr_AdvanceDialogueTextCursor ; $5987
Label_11_598a:
	ld a, $07 ; $598a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $598c
	ret ; $598f
	ld hl, $08bf ; $5990
	farcall FarPtr_InitDialogueTextCursor ; $5993
	ld a, $0a ; $5996
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5998
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
	ld hl, $0c0f ; $59ed
	farcall FarPtr_InitDialogueTextCursor ; $59f0
	ld a, $0a ; $59f3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $59f5
	ret ; $59f8
Label_11_59f9:
	ld hl, $0c1e ; $59f9
	farcall FarPtr_InitDialogueTextCursor ; $59fc
	ld a, $0a ; $59ff
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5a01
	farcall FarPtr_RunDialogueYesNoPrompt ; $5a04
	farcall FarPtr_ScriptCloseDialogueWindow ; $5a07
	push af ; $5a0a
	ld a, $05 ; $5a0b
	farcall FarPtr_WaitScriptFrames ; $5a0d
	pop af ; $5a10
	and a, a ; $5a11
	jp z, Label_11_5a18 ; $5a12
	farcall FarPtr_AdvanceDialogueTextCursor ; $5a15
Label_11_5a18:
	ld a, $0a ; $5a18
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5a1a
	ret ; $5a1d
	INCBIN "data/bank_011/d_5a1e.bin" ; $5a1e, 4 bytes
	test_flag $08, 2 ; $5a22
	jr nz, Label_11_5a66 ; $5a25
	test_flag $08, 0 ; $5a27
	jr z, Label_11_5a66 ; $5a2a
	ld a, $08 ; $5a2c
	ld bc, $2500 ; $5a2e
	ld de, $0900 ; $5a31
	farcall FarPtr_ScriptSetActorPosition ; $5a34
	ld a, $08 ; $5a37
	ld b, $00 ; $5a39
	farcall FarPtr_SetActorFacing ; $5a3b
	ldh a, [hRomBank] ; $5a3e
	ld b, a ; $5a40
	ld a, $08 ; $5a41
	ld de, $7ba9 ; $5a43
	farcall FarPtr_ScriptSetActorScript ; $5a46
	ld a, $09 ; $5a49
	ld bc, $2500 ; $5a4b
	ld de, $0b00 ; $5a4e
	farcall FarPtr_ScriptSetActorPosition ; $5a51
	ld a, $09 ; $5a54
	ld b, $00 ; $5a56
	farcall FarPtr_SetActorFacing ; $5a58
	ldh a, [hRomBank] ; $5a5b
	ld b, a ; $5a5d
	ld a, $09 ; $5a5e
	ld de, $7ba9 ; $5a60
	farcall FarPtr_ScriptSetActorScript ; $5a63
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
	ld a, $06 ; $5a96
	ld bc, $2000 ; $5a98
	ld de, $1900 ; $5a9b
	farcall FarPtr_ScriptSetActorPosition ; $5a9e
	ldh a, [hRomBank] ; $5aa1
	ld b, a ; $5aa3
	ld a, $06 ; $5aa4
	ld de, $7bb3 ; $5aa6
	farcall FarPtr_ScriptSetActorScript ; $5aa9
	ret ; $5aac
Label_11_5aad:
	ld hl, $58fd ; $5aad
	ld de, $000c ; $5ab0
	farcall FarPtr_WriteStoryStateWord ; $5ab3
	ld a, $06 ; $5ab6
	ld bc, $2000 ; $5ab8
	ld de, $1900 ; $5abb
	farcall FarPtr_ScriptSetActorPosition ; $5abe
	ldh a, [hRomBank] ; $5ac1
	ld b, a ; $5ac3
	ld a, $06 ; $5ac4
	ld de, $7bb3 ; $5ac6
	farcall FarPtr_ScriptSetActorScript ; $5ac9
	ret ; $5acc
Label_11_5acd:
	ld hl, $58b4 ; $5acd
	ld de, $000c ; $5ad0
	farcall FarPtr_WriteStoryStateWord ; $5ad3
	ld a, $06 ; $5ad6
	ld bc, $2000 ; $5ad8
	ld de, $1900 ; $5adb
	farcall FarPtr_ScriptSetActorPosition ; $5ade
	ldh a, [hRomBank] ; $5ae1
	ld b, a ; $5ae3
	ld a, $06 ; $5ae4
	ld de, $7bb3 ; $5ae6
	farcall FarPtr_ScriptSetActorScript ; $5ae9
	ret ; $5aec
Label_11_5aed:
	ld hl, $586b ; $5aed
	ld de, $000c ; $5af0
	farcall FarPtr_WriteStoryStateWord ; $5af3
	ld a, $06 ; $5af6
	ld bc, $2000 ; $5af8
	ld de, $1900 ; $5afb
	farcall FarPtr_ScriptSetActorPosition ; $5afe
	ldh a, [hRomBank] ; $5b01
	ld b, a ; $5b03
	ld a, $06 ; $5b04
	ld de, $7bb3 ; $5b06
	farcall FarPtr_ScriptSetActorScript ; $5b09
	ld a, $0a ; $5b0c
	ld b, $40 ; $5b0e
	farcall FarPtr_SetActorFacing ; $5b10
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
	ld bc, $0040 ; $5d4d
	farcall FarPtr_SetPlayerMoveSpeed ; $5d50
	xor a, a ; $5d53
	ld bc, $1300 ; $5d54
	ld de, $1500 ; $5d57
	farcall FarPtr_MovePlayerToPosition ; $5d5a
	ld a, $00 ; $5d5d
	ld bc, $1300 ; $5d5f
	ld de, $1500 ; $5d62
	farcall FarPtr_ScriptSetActorPosition ; $5d65
	ld a, $02 ; $5d68
	ld bc, $1300 ; $5d6a
	ld de, $1700 ; $5d6d
	farcall FarPtr_ScriptSetActorPosition ; $5d70
	ld a, $00 ; $5d73
	ld b, $c0 ; $5d75
	farcall FarPtr_SetActorFacing ; $5d77
	ld a, $02 ; $5d7a
	ld b, $c0 ; $5d7c
	farcall FarPtr_SetActorFacing ; $5d7e
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
	ld bc, $0040 ; $5da4
	farcall FarPtr_SetPlayerMoveSpeed ; $5da7
	ld a, [$c8f7] ; $5daa
	sub a, $02 ; $5dad
	ld a, a ; $5daf
	rst Rst00 ; $5db0
	dw Label_11_5db7 ; $5db1 jumptable
	dw Label_11_5ec0 ; $5db3 jumptable
	dw Label_11_5fbd ; $5db5 jumptable
Label_11_5db7:
	set_flag $08, 0 ; $5db7
	ld bc, $0040 ; $5dba
	farcall FarPtr_SetPlayerMoveSpeed ; $5dbd
	xor a, a ; $5dc0
	ld bc, $1900 ; $5dc1
	ld de, $1100 ; $5dc4
	farcall FarPtr_MovePlayerToPosition ; $5dc7
	ld a, $08 ; $5dca
	farcall FarPtr_SetActorNullScript ; $5dcc
	ld a, $09 ; $5dcf
	farcall FarPtr_SetActorNullScript ; $5dd1
	ld a, $08 ; $5dd4
	ld d, $01 ; $5dd6
	farcall FarPtr_ScriptSetActorAnimation ; $5dd8
	ld a, $09 ; $5ddb
	ld d, $01 ; $5ddd
	farcall FarPtr_ScriptSetActorAnimation ; $5ddf
	ld a, $08 ; $5de2
	ld bc, $1900 ; $5de4
	ld de, $0d00 ; $5de7
	farcall FarPtr_ScriptSetActorPosition ; $5dea
	ld a, $09 ; $5ded
	ld bc, $1b00 ; $5def
	ld de, $0d00 ; $5df2
	farcall FarPtr_ScriptSetActorPosition ; $5df5
	ld a, $00 ; $5df8
	ld bc, $1b00 ; $5dfa
	ld de, $1500 ; $5dfd
	farcall FarPtr_ScriptSetActorPosition ; $5e00
	ld a, $02 ; $5e03
	ld bc, $1900 ; $5e05
	ld de, $1500 ; $5e08
	farcall FarPtr_ScriptSetActorPosition ; $5e0b
	ld a, $00 ; $5e0e
	ld b, $c0 ; $5e10
	farcall FarPtr_SetActorFacing ; $5e12
	ld a, $02 ; $5e15
	ld b, $c0 ; $5e17
	farcall FarPtr_SetActorFacing ; $5e19
	ld a, $08 ; $5e1c
	ld b, $40 ; $5e1e
	farcall FarPtr_SetActorFacing ; $5e20
	ld a, $09 ; $5e23
	ld b, $40 ; $5e25
	farcall FarPtr_SetActorFacing ; $5e27
	ld a, $03 ; $5e2a
	ld b, $00 ; $5e2c
	farcall FarPtr_SetActorFacing ; $5e2e
	farcall FarPtr_WaitPlayerMoveDone ; $5e31
	ld c, $04 ; $5e34
	call BeginFadeIn ; $5e36
	call WaitFadeEnd ; $5e39
	ld hl, $0865 ; $5e3c
	farcall FarPtr_InitDialogueTextCursor ; $5e3f
	ld a, $08 ; $5e42
	ld d, $02 ; $5e44
	farcall FarPtr_ScriptSetActorAnimation ; $5e46
	ld a, $08 ; $5e49
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5e4b
	ld a, $09 ; $5e4e
	ld d, $04 ; $5e50
	farcall FarPtr_ScriptSetActorAnimation ; $5e52
	ld a, $09 ; $5e55
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5e57
	ld a, $03 ; $5e5a
	ld de, $ff80 ; $5e5c
	farcall FarPtr_ScriptSetActorJumpVelocity ; $5e5f
	ld a, $03 ; $5e62
	farcall FarPtr_ScriptWaitActorJumpDone ; $5e64
	ld a, $03 ; $5e67
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5e69
	ldh a, [hRomBank] ; $5e6c
	ld b, a ; $5e6e
	ld a, $08 ; $5e6f
	ld de, $5b28 ; $5e71
	farcall FarPtr_ScriptSetActorScript ; $5e74
	ldh a, [hRomBank] ; $5e77
	ld b, a ; $5e79
	ld a, $09 ; $5e7a
	ld de, $5b56 ; $5e7c
	farcall FarPtr_ScriptSetActorScript ; $5e7f
	ld a, $00 ; $5e82
	ld bc, $1300 ; $5e84
	ld de, $1700 ; $5e87
	farcall FarPtr_ScriptSetActorMoveTarget ; $5e8a
	ld a, $02 ; $5e8d
	ld bc, $1300 ; $5e8f
	ld de, $1500 ; $5e92
	farcall FarPtr_ScriptSetActorMoveTarget ; $5e95
	ld a, $03 ; $5e98
	ld b, $40 ; $5e9a
	farcall FarPtr_SetActorFacing ; $5e9c
	ld a, $00 ; $5e9f
	farcall FarPtr_ScriptWaitActorMoveDone ; $5ea1
	ld a, $00 ; $5ea4
	ld b, $40 ; $5ea6
	farcall FarPtr_SetActorFacing ; $5ea8
	push af ; $5eab
	ld a, $28 ; $5eac
	farcall FarPtr_WaitScriptFrames ; $5eae
	pop af ; $5eb1
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
	ld bc, $0040 ; $5ec6
	farcall FarPtr_SetPlayerMoveSpeed ; $5ec9
	xor a, a ; $5ecc
	ld bc, $0b00 ; $5ecd
	ld de, $0f00 ; $5ed0
	farcall FarPtr_MovePlayerToPosition ; $5ed3
	ld a, $07 ; $5ed6
	ld bc, $0b00 ; $5ed8
	ld de, $0d00 ; $5edb
	farcall FarPtr_ScriptSetActorPosition ; $5ede
	ld a, $05 ; $5ee1
	ld bc, $0900 ; $5ee3
	ld de, $0d00 ; $5ee6
	farcall FarPtr_ScriptSetActorPosition ; $5ee9
	ld a, $00 ; $5eec
	ld bc, $0900 ; $5eee
	ld de, $1500 ; $5ef1
	farcall FarPtr_ScriptSetActorPosition ; $5ef4
	ld a, $02 ; $5ef7
	ld bc, $0b00 ; $5ef9
	ld de, $1900 ; $5efc
	farcall FarPtr_ScriptSetActorPosition ; $5eff
	ld a, $00 ; $5f02
	ld b, $c0 ; $5f04
	farcall FarPtr_SetActorFacing ; $5f06
	ld a, $02 ; $5f09
	ld b, $c0 ; $5f0b
	farcall FarPtr_SetActorFacing ; $5f0d
	ld a, $07 ; $5f10
	ld b, $40 ; $5f12
	farcall FarPtr_SetActorFacing ; $5f14
	ld a, $05 ; $5f17
	ld b, $40 ; $5f19
	farcall FarPtr_SetActorFacing ; $5f1b
	ld a, $03 ; $5f1e
	ld b, $80 ; $5f20
	farcall FarPtr_SetActorFacing ; $5f22
	farcall FarPtr_WaitPlayerMoveDone ; $5f25
	ld c, $04 ; $5f28
	call BeginFadeIn ; $5f2a
	call WaitFadeEnd ; $5f2d
	ld hl, $0865 ; $5f30
	farcall FarPtr_InitDialogueTextCursor ; $5f33
	ld a, $07 ; $5f36
	ld d, $02 ; $5f38
	farcall FarPtr_ScriptSetActorAnimation ; $5f3a
	ld a, $07 ; $5f3d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5f3f
	ld a, $05 ; $5f42
	ld d, $04 ; $5f44
	farcall FarPtr_ScriptSetActorAnimation ; $5f46
	ld a, $05 ; $5f49
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5f4b
	ld hl, $0868 ; $5f4e
	farcall FarPtr_InitDialogueTextCursor ; $5f51
	ld a, $03 ; $5f54
	ld de, $ff80 ; $5f56
	farcall FarPtr_ScriptSetActorJumpVelocity ; $5f59
	ld a, $03 ; $5f5c
	farcall FarPtr_ScriptWaitActorJumpDone ; $5f5e
	ld a, $03 ; $5f61
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5f63
	ldh a, [hRomBank] ; $5f66
	ld b, a ; $5f68
	ld a, $07 ; $5f69
	ld de, $5c14 ; $5f6b
	farcall FarPtr_ScriptSetActorScript ; $5f6e
	ldh a, [hRomBank] ; $5f71
	ld b, a ; $5f73
	ld a, $05 ; $5f74
	ld de, $5c5f ; $5f76
	farcall FarPtr_ScriptSetActorScript ; $5f79
	ld a, $00 ; $5f7c
	ld bc, $1300 ; $5f7e
	ld de, $1700 ; $5f81
	farcall FarPtr_ScriptSetActorMoveTarget ; $5f84
	ld a, $02 ; $5f87
	ld bc, $1300 ; $5f89
	ld de, $1500 ; $5f8c
	farcall FarPtr_ScriptSetActorMoveTarget ; $5f8f
	call Func_11_7b6b ; $5f92
	ld a, $03 ; $5f95
	ld b, $40 ; $5f97
	farcall FarPtr_SetActorFacing ; $5f99
	push af ; $5f9c
	ld a, $3c ; $5f9d
	farcall FarPtr_WaitScriptFrames ; $5f9f
	pop af ; $5fa2
	ld a, $00 ; $5fa3
	farcall FarPtr_ScriptWaitActorMoveDone ; $5fa5
	ld a, $00 ; $5fa8
	ld b, $40 ; $5faa
	farcall FarPtr_SetActorFacing ; $5fac
	ld a, $02 ; $5faf
	farcall FarPtr_GetActorStateAddr ; $5fb1
	ld c, l ; $5fb4
	ld b, h ; $5fb5
	ld de, $d000 ; $5fb6
	farcall FarPtr_04_20 ; $5fb9
	ret ; $5fbc
Label_11_5fbd:
	set_flag $08, 2 ; $5fbd
	ld bc, $0040 ; $5fc0
	farcall FarPtr_SetPlayerMoveSpeed ; $5fc3
	xor a, a ; $5fc6
	ld bc, $1900 ; $5fc7
	ld de, $0d00 ; $5fca
	farcall FarPtr_MovePlayerToPosition ; $5fcd
	ld a, $08 ; $5fd0
	ld bc, $2500 ; $5fd2
	ld de, $0900 ; $5fd5
	farcall FarPtr_ScriptSetActorPosition ; $5fd8
	ld a, $08 ; $5fdb
	ld b, $00 ; $5fdd
	farcall FarPtr_SetActorFacing ; $5fdf
	ldh a, [hRomBank] ; $5fe2
	ld b, a ; $5fe4
	ld a, $08 ; $5fe5
	ld de, $7ba9 ; $5fe7
	farcall FarPtr_ScriptSetActorScript ; $5fea
	ld a, $09 ; $5fed
	ld bc, $2500 ; $5fef
	ld de, $0b00 ; $5ff2
	farcall FarPtr_ScriptSetActorPosition ; $5ff5
	ld a, $09 ; $5ff8
	ld b, $00 ; $5ffa
	farcall FarPtr_SetActorFacing ; $5ffc
	ld a, $03 ; $5fff
	ld bc, $1300 ; $6001
	ld de, $1f00 ; $6004
	farcall FarPtr_ScriptSetActorPosition ; $6007
	ld a, $04 ; $600a
	ld bc, $1900 ; $600c
	ld de, $0e00 ; $600f
	farcall FarPtr_ScriptSetActorPosition ; $6012
	ld a, $06 ; $6015
	ld bc, $1b00 ; $6017
	ld de, $0e00 ; $601a
	farcall FarPtr_ScriptSetActorPosition ; $601d
	ld a, $00 ; $6020
	ld bc, $1b00 ; $6022
	ld de, $1300 ; $6025
	farcall FarPtr_ScriptSetActorPosition ; $6028
	ld a, $02 ; $602b
	ld bc, $1900 ; $602d
	ld de, $1300 ; $6030
	farcall FarPtr_ScriptSetActorPosition ; $6033
	ld a, $00 ; $6036
	ld b, $c0 ; $6038
	farcall FarPtr_SetActorFacing ; $603a
	ld a, $02 ; $603d
	ld b, $c0 ; $603f
	farcall FarPtr_SetActorFacing ; $6041
	ld a, $04 ; $6044
	ld b, $40 ; $6046
	farcall FarPtr_SetActorFacing ; $6048
	ld a, $06 ; $604b
	ld b, $40 ; $604d
	farcall FarPtr_SetActorFacing ; $604f
	ld a, $03 ; $6052
	ld b, $c0 ; $6054
	farcall FarPtr_SetActorFacing ; $6056
	farcall FarPtr_WaitPlayerMoveDone ; $6059
	ld c, $04 ; $605c
	call BeginFadeIn ; $605e
	call WaitFadeEnd ; $6061
	push af ; $6064
	ld a, $1e ; $6065
	farcall FarPtr_WaitScriptFrames ; $6067
	pop af ; $606a
	ld hl, $0871 ; $606b
	farcall FarPtr_InitDialogueTextCursor ; $606e
	ld a, $04 ; $6071
	ld d, $02 ; $6073
	farcall FarPtr_ScriptSetActorAnimation ; $6075
	ld a, $04 ; $6078
	farcall FarPtr_ScriptShowSpeakerDialogue ; $607a
	ld a, $06 ; $607d
	ld d, $04 ; $607f
	farcall FarPtr_ScriptSetActorAnimation ; $6081
	ld a, $06 ; $6084
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6086
	ld a, $03 ; $6089
	ld d, $03 ; $608b
	farcall FarPtr_ScriptSetActorAnimation ; $608d
	ld a, $03 ; $6090
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6092
	ld a, $04 ; $6095
	ld d, $02 ; $6097
	farcall FarPtr_ScriptSetActorAnimation ; $6099
	ld a, $06 ; $609c
	ld d, $02 ; $609e
	farcall FarPtr_ScriptSetActorAnimation ; $60a0
	ld a, $00 ; $60a3
	ld d, $02 ; $60a5
	farcall FarPtr_ScriptSetActorAnimation ; $60a7
	ld a, $02 ; $60aa
	ld d, $02 ; $60ac
	farcall FarPtr_ScriptSetActorAnimation ; $60ae
	push af ; $60b1
	ld a, $1e ; $60b2
	farcall FarPtr_WaitScriptFrames ; $60b4
	pop af ; $60b7
	ld a, $00 ; $60b8
	ld b, $40 ; $60ba
	farcall FarPtr_SetActorFacing ; $60bc
	ld a, $02 ; $60bf
	ld b, $40 ; $60c1
	farcall FarPtr_SetActorFacing ; $60c3
	ld bc, $0010 ; $60c6
	farcall FarPtr_SetPlayerMoveSpeed ; $60c9
	ld a, $03 ; $60cc
	ld bc, $0010 ; $60ce
	farcall FarPtr_ScriptSetActorMoveSpeed ; $60d1
	xor a, a ; $60d4
	ld bc, $1500 ; $60d5
	ld de, $1700 ; $60d8
	farcall FarPtr_MovePlayerToPosition ; $60db
	farcall FarPtr_WaitPlayerMoveDone ; $60de
	ld a, $03 ; $60e1
	ld bc, $1300 ; $60e3
	ld de, $1b00 ; $60e6
	farcall FarPtr_ScriptSetActorMoveTarget ; $60e9
	ld a, $03 ; $60ec
	farcall FarPtr_ScriptWaitActorMoveDone ; $60ee
	farcall FarPtr_WaitPlayerMoveDone ; $60f1
	xor a, a ; $60f4
	ld bc, $1a00 ; $60f5
	ld de, $1300 ; $60f8
	farcall FarPtr_MovePlayerToPosition ; $60fb
	ld a, $03 ; $60fe
	ld bc, $1a00 ; $6100
	ld de, $1700 ; $6103
	farcall FarPtr_ScriptSetActorMoveTarget ; $6106
	ld a, $03 ; $6109
	farcall FarPtr_ScriptWaitActorMoveDone ; $610b
	ld a, $03 ; $610e
	ld b, $c0 ; $6110
	farcall FarPtr_SetActorFacing ; $6112
	ld a, $03 ; $6115
	ld d, $02 ; $6117
	farcall FarPtr_ScriptSetActorAnimation ; $6119
	ld a, $03 ; $611c
	farcall FarPtr_ScriptWaitActorIdle ; $611e
	ld a, $03 ; $6121
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6123
	ld a, $02 ; $6126
	ld b, a ; $6128
	ld a, $00 ; $6129
	farcall FarPtr_FaceActorsTowardEachOther ; $612b
	push af ; $612e
	ld a, $1e ; $612f
	farcall FarPtr_WaitScriptFrames ; $6131
	pop af ; $6134
	ld a, $00 ; $6135
	ld b, $40 ; $6137
	farcall FarPtr_SetActorFacing ; $6139
	ld a, $02 ; $613c
	ld b, $40 ; $613e
	farcall FarPtr_SetActorFacing ; $6140
	ld a, $00 ; $6143
	ld d, $03 ; $6145
	farcall FarPtr_ScriptSetActorAnimation ; $6147
	ld a, $02 ; $614a
	ld d, $03 ; $614c
	farcall FarPtr_ScriptSetActorAnimation ; $614e
	ld a, $02 ; $6151
	farcall FarPtr_ScriptWaitActorIdle ; $6153
	push af ; $6156
	ld a, $1e ; $6157
	farcall FarPtr_WaitScriptFrames ; $6159
	pop af ; $615c
	ld hl, $0875 ; $615d
	farcall FarPtr_InitDialogueTextCursor ; $6160
	ld a, $03 ; $6163
	ld d, $03 ; $6165
	farcall FarPtr_ScriptSetActorAnimation ; $6167
	ld a, $03 ; $616a
	farcall FarPtr_ScriptWaitActorIdle ; $616c
	ld a, $03 ; $616f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6171
	ld a, $03 ; $6174
	ld bc, $1b00 ; $6176
	ld de, $1500 ; $6179
	farcall FarPtr_ScriptSetActorMoveTarget ; $617c
	ld a, $03 ; $617f
	farcall FarPtr_ScriptWaitActorMoveDone ; $6181
	ld a, $00 ; $6184
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6186
	push af ; $6189
	ld a, $1e ; $618a
	farcall FarPtr_WaitScriptFrames ; $618c
	pop af ; $618f
	ld a, $03 ; $6190
	ld d, $02 ; $6192
	farcall FarPtr_ScriptSetActorAnimation ; $6194
	ld a, $03 ; $6197
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6199
	ld a, $00 ; $619c
	ld d, $03 ; $619e
	farcall FarPtr_ScriptSetActorAnimation ; $61a0
	ld a, $02 ; $61a3
	ld d, $03 ; $61a5
	farcall FarPtr_ScriptSetActorAnimation ; $61a7
	ld a, $02 ; $61aa
	farcall FarPtr_ScriptWaitActorIdle ; $61ac
	ld a, $03 ; $61af
	ld d, $03 ; $61b1
	farcall FarPtr_ScriptSetActorAnimation ; $61b3
	ld a, $03 ; $61b6
	farcall FarPtr_ScriptWaitActorIdle ; $61b8
	ld a, $06 ; $61bb
	ld b, a ; $61bd
	ld a, $04 ; $61be
	farcall FarPtr_FaceActorsTowardEachOther ; $61c0
	push af ; $61c3
	ld a, $1e ; $61c4
	farcall FarPtr_WaitScriptFrames ; $61c6
	pop af ; $61c9
	ld a, $04 ; $61ca
	ld b, $40 ; $61cc
	farcall FarPtr_SetActorFacing ; $61ce
	ld a, $06 ; $61d1
	ld b, $40 ; $61d3
	farcall FarPtr_SetActorFacing ; $61d5
	ld a, $06 ; $61d8
	ld d, $02 ; $61da
	farcall FarPtr_ScriptSetActorAnimation ; $61dc
	ld a, $06 ; $61df
	farcall FarPtr_ScriptShowSpeakerDialogue ; $61e1
	ld a, $00 ; $61e4
	ld b, $c0 ; $61e6
	farcall FarPtr_SetActorFacing ; $61e8
	ld a, $02 ; $61eb
	ld b, $c0 ; $61ed
	farcall FarPtr_SetActorFacing ; $61ef
	ld a, $04 ; $61f2
	ld d, $03 ; $61f4
	farcall FarPtr_ScriptSetActorAnimation ; $61f6
	ld a, $04 ; $61f9
	farcall FarPtr_ScriptWaitActorIdle ; $61fb
	ld a, $06 ; $61fe
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6200
	ld a, $02 ; $6203
	ld b, a ; $6205
	ld a, $00 ; $6206
	farcall FarPtr_FaceActorsTowardEachOther ; $6208
	push af ; $620b
	ld a, $14 ; $620c
	farcall FarPtr_WaitScriptFrames ; $620e
	pop af ; $6211
	ld a, $00 ; $6212
	ld d, $02 ; $6214
	farcall FarPtr_ScriptSetActorAnimation ; $6216
	ld a, $02 ; $6219
	ld d, $02 ; $621b
	farcall FarPtr_ScriptSetActorAnimation ; $621d
	ld a, $02 ; $6220
	farcall FarPtr_ScriptWaitActorIdle ; $6222
	push af ; $6225
	ld a, $1e ; $6226
	farcall FarPtr_WaitScriptFrames ; $6228
	pop af ; $622b
	ld a, $00 ; $622c
	ld b, $c0 ; $622e
	farcall FarPtr_SetActorFacing ; $6230
	ld a, $02 ; $6233
	ld b, $c0 ; $6235
	farcall FarPtr_SetActorFacing ; $6237
	ld a, $00 ; $623a
	ld d, $03 ; $623c
	farcall FarPtr_ScriptSetActorAnimation ; $623e
	ld a, $02 ; $6241
	ld d, $03 ; $6243
	farcall FarPtr_ScriptSetActorAnimation ; $6245
	ld a, $02 ; $6248
	farcall FarPtr_ScriptWaitActorIdle ; $624a
	push af ; $624d
	ld a, $1e ; $624e
	farcall FarPtr_WaitScriptFrames ; $6250
	pop af ; $6253
	ld a, $04 ; $6254
	ld d, $03 ; $6256
	farcall FarPtr_ScriptSetActorAnimation ; $6258
	ld a, $06 ; $625b
	ld d, $03 ; $625d
	farcall FarPtr_ScriptSetActorAnimation ; $625f
	ld a, $06 ; $6262
	farcall FarPtr_ScriptWaitActorIdle ; $6264
	push af ; $6267
	ld a, $3c ; $6268
	farcall FarPtr_WaitScriptFrames ; $626a
	pop af ; $626d
	ld a, $03 ; $626e
	ld d, $03 ; $6270
	farcall FarPtr_ScriptSetActorAnimation ; $6272
	ld a, $0c ; $6275
	ld [wStoryModeCurrentLocation], a ; $6277
	ld a, $01 ; $627a
	ld [wStoryModeEntryPoint], a ; $627c
	ld a, $ff ; $627f
	ld [$c294], a ; $6281
	ld [wStoryModeExitLocationRequest], a ; $6284
	push af ; $6287
	ld a, $3c ; $6288
	farcall FarPtr_WaitScriptFrames ; $628a
	pop af ; $628d
	ld c, $04 ; $628e
	call BeginFadeOut ; $6290
	call WaitFadeEnd ; $6293
	push af ; $6296
	ld a, $1e ; $6297
	farcall FarPtr_WaitScriptFrames ; $6299
	pop af ; $629c
	ret ; $629d
OfferDoublesRankingMatch:
	ld hl, $085a ; $629e
	farcall FarPtr_InitDialogueTextCursor ; $62a1
	ld a, $03 ; $62a4
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $62a6
	farcall FarPtr_RunDialogueYesNoPrompt ; $62a9
	farcall FarPtr_ScriptCloseDialogueWindow ; $62ac
	push af ; $62af
	ld a, $05 ; $62b0
	farcall FarPtr_WaitScriptFrames ; $62b2
	pop af ; $62b5
	and a, a ; $62b6
	jp nz, Label_11_634b ; $62b7
	ld a, $00 ; $62ba
	ld bc, $0010 ; $62bc
	farcall FarPtr_ScriptSetActorMoveSpeed ; $62bf
	ld a, $02 ; $62c2
	ld bc, $0010 ; $62c4
	farcall FarPtr_ScriptSetActorMoveSpeed ; $62c7
	ld a, $00 ; $62ca
	ld bc, $1300 ; $62cc
	ld de, $1500 ; $62cf
	farcall FarPtr_ScriptSetActorMoveTarget ; $62d2
	ld a, $02 ; $62d5
	ld bc, $1300 ; $62d7
	ld de, $1700 ; $62da
	farcall FarPtr_ScriptSetActorMoveTarget ; $62dd
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
	ld a, $00 ; $62fb
	farcall FarPtr_ScriptWaitActorMoveDone ; $62fd
	ld a, $00 ; $6300
	ld b, $c0 ; $6302
	farcall FarPtr_SetActorFacing ; $6304
	ld a, $03 ; $6307
	ld b, $40 ; $6309
	farcall FarPtr_SetActorFacing ; $630b
	ld a, $02 ; $630e
	ld bc, $1300 ; $6310
	ld de, $1700 ; $6313
	farcall FarPtr_ScriptSetActorMoveTarget ; $6316
	ld a, $02 ; $6319
	farcall FarPtr_ScriptWaitActorMoveDone ; $631b
	ld a, $02 ; $631e
	ld b, $c0 ; $6320
	farcall FarPtr_SetActorFacing ; $6322
	ld a, $03 ; $6325
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6327
	call DrawDoublesRankingOpponentInfo ; $632a
	ld a, $00 ; $632d
	ld b, $c0 ; $632f
	farcall FarPtr_SetActorFacing ; $6331
	push af ; $6334
	ld a, $0f ; $6335
	farcall FarPtr_WaitScriptFrames ; $6337
	pop af ; $633a
	ld a, $03 ; $633b
	ld d, $02 ; $633d
	farcall FarPtr_ScriptSetActorAnimation ; $633f
	ld a, $03 ; $6342
	farcall FarPtr_ScriptWaitActorIdle ; $6344
	call PromptChallengeRankingOpponent ; $6347
	ret ; $634a
Label_11_634b:
	ld a, $03 ; $634b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $634d
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
	ld bc, $0020 ; $6364
	farcall FarPtr_SetPlayerMoveSpeed ; $6367
	ld a, $03 ; $636a
	ld b, $00 ; $636c
	farcall FarPtr_SetActorFacing ; $636e
	ld a, $08 ; $6371
	ld b, $00 ; $6373
	farcall FarPtr_MovePlayerToActor ; $6375
	farcall FarPtr_WaitPlayerMoveDone ; $6378
	ld a, $08 ; $637b
	farcall FarPtr_SetActorNullScript ; $637d
	ld a, $09 ; $6380
	farcall FarPtr_SetActorNullScript ; $6382
	ld a, $09 ; $6385
	ld d, $01 ; $6387
	farcall FarPtr_ScriptSetActorAnimation ; $6389
	ld a, $08 ; $638c
	ld b, $80 ; $638e
	farcall FarPtr_SetActorFacing ; $6390
	ld a, $09 ; $6393
	ld b, $80 ; $6395
	farcall FarPtr_SetActorFacing ; $6397
	push af ; $639a
	ld a, $32 ; $639b
	farcall FarPtr_WaitScriptFrames ; $639d
	pop af ; $63a0
	ld a, $00 ; $63a1
	ld b, $00 ; $63a3
	farcall FarPtr_SetActorFacing ; $63a5
	ld a, $02 ; $63a8
	ld b, $00 ; $63aa
	farcall FarPtr_SetActorFacing ; $63ac
	ld hl, $085f ; $63af
	farcall FarPtr_InitDialogueTextCursor ; $63b2
	ld a, $08 ; $63b5
	ld d, $02 ; $63b7
	farcall FarPtr_ScriptSetActorAnimation ; $63b9
	ld a, $08 ; $63bc
	farcall FarPtr_ScriptWaitActorIdle ; $63be
	ld a, $08 ; $63c1
	ld bc, $1500 ; $63c3
	ld de, $1500 ; $63c6
	farcall FarPtr_ScriptSetActorMoveTarget ; $63c9
	ld a, $09 ; $63cc
	ld bc, $1500 ; $63ce
	ld de, $1700 ; $63d1
	farcall FarPtr_ScriptSetActorMoveTarget ; $63d4
	ld a, $09 ; $63d7
	farcall FarPtr_ScriptWaitActorMoveDone ; $63d9
	ld a, $09 ; $63dc
	ld b, $80 ; $63de
	farcall FarPtr_SetActorFacing ; $63e0
	ld a, $00 ; $63e3
	ld b, $00 ; $63e5
	farcall FarPtr_MovePlayerToActor ; $63e7
	ld a, $03 ; $63ea
	ld b, $40 ; $63ec
	farcall FarPtr_SetActorFacing ; $63ee
	ld a, $08 ; $63f1
	ld d, $02 ; $63f3
	farcall FarPtr_ScriptSetActorAnimation ; $63f5
	ld a, $08 ; $63f8
	farcall FarPtr_ScriptWaitActorIdle ; $63fa
	ld a, $08 ; $63fd
	farcall FarPtr_ScriptShowSpeakerDialogue ; $63ff
	ld a, $09 ; $6402
	ld d, $03 ; $6404
	farcall FarPtr_ScriptSetActorAnimation ; $6406
	ld a, $09 ; $6409
	farcall FarPtr_ScriptShowSpeakerDialogue ; $640b
	push af ; $640e
	ld a, $0f ; $640f
	farcall FarPtr_WaitScriptFrames ; $6411
	pop af ; $6414
	ld a, $00 ; $6415
	ld b, $c0 ; $6417
	farcall FarPtr_SetActorFacing ; $6419
	ld a, $02 ; $641c
	ld b, $c0 ; $641e
	farcall FarPtr_SetActorFacing ; $6420
	ld a, $08 ; $6423
	ld b, $c0 ; $6425
	farcall FarPtr_SetActorFacing ; $6427
	ld a, $09 ; $642a
	ld b, $c0 ; $642c
	farcall FarPtr_SetActorFacing ; $642e
	ret ; $6431
Label_11_6432:
	ld bc, $0020 ; $6432
	farcall FarPtr_SetPlayerMoveSpeed ; $6435
	ld a, $03 ; $6438
	ld b, $80 ; $643a
	farcall FarPtr_SetActorFacing ; $643c
	ld a, $05 ; $643f
	ld b, $00 ; $6441
	farcall FarPtr_MovePlayerToActor ; $6443
	farcall FarPtr_WaitPlayerMoveDone ; $6446
	ld a, $00 ; $6449
	ld b, $80 ; $644b
	farcall FarPtr_SetActorFacing ; $644d
	ld a, $02 ; $6450
	ld b, $80 ; $6452
	farcall FarPtr_SetActorFacing ; $6454
	push af ; $6457
	ld a, $1e ; $6458
	farcall FarPtr_WaitScriptFrames ; $645a
	pop af ; $645d
	ld hl, $0861 ; $645e
	farcall FarPtr_InitDialogueTextCursor ; $6461
	ldh a, [hRomBank] ; $6464
	ld b, a ; $6466
	ld a, $05 ; $6467
	ld de, $76e9 ; $6469
	farcall FarPtr_ScriptSetActorScript ; $646c
	ldh a, [hRomBank] ; $646f
	ld b, a ; $6471
	ld a, $07 ; $6472
	ld de, $5c2e ; $6474
	farcall FarPtr_ScriptSetActorScript ; $6477
	ld a, $00 ; $647a
	ld b, $00 ; $647c
	farcall FarPtr_MovePlayerToActor ; $647e
	ld a, $03 ; $6481
	ld b, $40 ; $6483
	farcall FarPtr_SetActorFacing ; $6485
	farcall FarPtr_WaitPlayerMoveDone ; $6488
	push af ; $648b
	ld a, $1e ; $648c
	farcall FarPtr_WaitScriptFrames ; $648e
	pop af ; $6491
	ld a, $05 ; $6492
	ld d, $04 ; $6494
	farcall FarPtr_ScriptSetActorAnimation ; $6496
	ld a, $05 ; $6499
	farcall FarPtr_ScriptWaitActorIdle ; $649b
	ld a, $05 ; $649e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $64a0
	ld a, $07 ; $64a3
	ld b, a ; $64a5
	ld a, $05 ; $64a6
	farcall FarPtr_FaceActorsTowardEachOther ; $64a8
	push af ; $64ab
	ld a, $1e ; $64ac
	farcall FarPtr_WaitScriptFrames ; $64ae
	pop af ; $64b1
	ld a, $07 ; $64b2
	ld d, $03 ; $64b4
	farcall FarPtr_ScriptSetActorAnimation ; $64b6
	ld a, $07 ; $64b9
	farcall FarPtr_ScriptShowSpeakerDialogue ; $64bb
	ld a, $00 ; $64be
	ld b, $c0 ; $64c0
	farcall FarPtr_SetActorFacing ; $64c2
	ld a, $02 ; $64c5
	ld b, $c0 ; $64c7
	farcall FarPtr_SetActorFacing ; $64c9
	ld a, $05 ; $64cc
	ld b, $c0 ; $64ce
	farcall FarPtr_SetActorFacing ; $64d0
	ld a, $07 ; $64d3
	ld b, $c0 ; $64d5
	farcall FarPtr_SetActorFacing ; $64d7
	ret ; $64da
Label_11_64db:
	ld bc, $0020 ; $64db
	farcall FarPtr_SetPlayerMoveSpeed ; $64de
	ld a, $03 ; $64e1
	ld b, $00 ; $64e3
	farcall FarPtr_SetActorFacing ; $64e5
	push af ; $64e8
	ld a, $14 ; $64e9
	farcall FarPtr_WaitScriptFrames ; $64eb
	pop af ; $64ee
	ld a, $00 ; $64ef
	ld b, $00 ; $64f1
	farcall FarPtr_SetActorFacing ; $64f3
	ld a, $02 ; $64f6
	ld b, $00 ; $64f8
	farcall FarPtr_SetActorFacing ; $64fa
	ld a, $04 ; $64fd
	ld b, $00 ; $64ff
	farcall FarPtr_MovePlayerToActor ; $6501
	farcall FarPtr_WaitPlayerMoveDone ; $6504
	ld a, $06 ; $6507
	ld b, $80 ; $6509
	farcall FarPtr_SetActorFacing ; $650b
	ld a, $06 ; $650e
	ld d, $02 ; $6510
	farcall FarPtr_ScriptSetActorAnimation ; $6512
	ld a, $06 ; $6515
	farcall FarPtr_ScriptWaitActorIdle ; $6517
	ld hl, $0863 ; $651a
	farcall FarPtr_InitDialogueTextCursor ; $651d
	ldh a, [hRomBank] ; $6520
	ld b, a ; $6522
	ld a, $04 ; $6523
	ld de, $7728 ; $6525
	farcall FarPtr_ScriptSetActorScript ; $6528
	push af ; $652b
	ld a, $0f ; $652c
	farcall FarPtr_WaitScriptFrames ; $652e
	pop af ; $6531
	ldh a, [hRomBank] ; $6532
	ld b, a ; $6534
	ld a, $06 ; $6535
	ld de, $5cff ; $6537
	farcall FarPtr_ScriptSetActorScript ; $653a
	ld a, $00 ; $653d
	ld b, $00 ; $653f
	farcall FarPtr_MovePlayerToActor ; $6541
	ld a, $03 ; $6544
	ld b, $40 ; $6546
	farcall FarPtr_SetActorFacing ; $6548
	farcall FarPtr_WaitPlayerMoveDone ; $654b
	push af ; $654e
	ld a, $0f ; $654f
	farcall FarPtr_WaitScriptFrames ; $6551
	pop af ; $6554
	ld a, $04 ; $6555
	ld d, $02 ; $6557
	farcall FarPtr_ScriptSetActorAnimation ; $6559
	ld a, $04 ; $655c
	farcall FarPtr_ScriptWaitActorIdle ; $655e
	ld a, $04 ; $6561
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6563
	ld a, $06 ; $6566
	ld d, $03 ; $6568
	farcall FarPtr_ScriptSetActorAnimation ; $656a
	ld a, $06 ; $656d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $656f
	push af ; $6572
	ld a, $14 ; $6573
	farcall FarPtr_WaitScriptFrames ; $6575
	pop af ; $6578
	ld a, $00 ; $6579
	ld b, $c0 ; $657b
	farcall FarPtr_SetActorFacing ; $657d
	ld a, $02 ; $6580
	ld b, $c0 ; $6582
	farcall FarPtr_SetActorFacing ; $6584
	ld a, $04 ; $6587
	ld b, $c0 ; $6589
	farcall FarPtr_SetActorFacing ; $658b
	ld a, $06 ; $658e
	ld b, $c0 ; $6590
	farcall FarPtr_SetActorFacing ; $6592
	ret ; $6595
StartNextDoublesRankingMatch:
	ld a, $00 ; $6596
	ld bc, $0020 ; $6598
	farcall FarPtr_ScriptSetActorMoveSpeed ; $659b
	ld a, $02 ; $659e
	ld bc, $0020 ; $65a0
	farcall FarPtr_ScriptSetActorMoveSpeed ; $65a3
	test_flag $08, 0 ; $65a6
	jp z, Label_11_65b9 ; $65a9
	test_flag $08, 1 ; $65ac
	jp z, Label_11_6642 ; $65af
	test_flag $08, 2 ; $65b2
	jp z, Label_11_6702 ; $65b5
	ret ; $65b8
Label_11_65b9:
	ld a, $03 ; $65b9
	ld b, $00 ; $65bb
	farcall FarPtr_SetActorFacing ; $65bd
	push af ; $65c0
	ld a, $1e ; $65c1
	farcall FarPtr_WaitScriptFrames ; $65c3
	pop af ; $65c6
	ld a, $02 ; $65c7
	farcall FarPtr_SetActorNullScript ; $65c9
	xor a, a ; $65cc
	ld bc, $1900 ; $65cd
	ld de, $1100 ; $65d0
	farcall FarPtr_MovePlayerToPosition ; $65d3
	ldh a, [hRomBank] ; $65d6
	ld b, a ; $65d8
	ld a, $08 ; $65d9
	ld de, $5b70 ; $65db
	farcall FarPtr_ScriptSetActorScript ; $65de
	ldh a, [hRomBank] ; $65e1
	ld b, a ; $65e3
	ld a, $09 ; $65e4
	ld de, $5b84 ; $65e6
	farcall FarPtr_ScriptSetActorScript ; $65e9
	ld a, $00 ; $65ec
	ld bc, $1b00 ; $65ee
	ld de, $1900 ; $65f1
	farcall FarPtr_ScriptSetActorMoveTarget ; $65f4
	push af ; $65f7
	ld a, $0a ; $65f8
	farcall FarPtr_WaitScriptFrames ; $65fa
	pop af ; $65fd
	ld a, $02 ; $65fe
	ld bc, $1900 ; $6600
	ld de, $1500 ; $6603
	farcall FarPtr_ScriptSetActorMoveTarget ; $6606
	ld a, $00 ; $6609
	farcall FarPtr_ScriptWaitActorMoveDone ; $660b
	ld a, $00 ; $660e
	ld b, $c0 ; $6610
	farcall FarPtr_SetActorFacing ; $6612
	ld a, $02 ; $6615
	ld b, $c0 ; $6617
	farcall FarPtr_SetActorFacing ; $6619
	push af ; $661c
	ld a, $3c ; $661d
	farcall FarPtr_WaitScriptFrames ; $661f
	pop af ; $6622
	ld a, $0f ; $6623
	ld [$c294], a ; $6625
	ld [wStoryModeExitLocationRequest], a ; $6628
	farcall FarPtr_InitStoryMatchSettings ; $662b
	ld a, $01 ; $662e
	ld [wCurrentMinigameStoryMatch], a ; $6630
	ld a, $02 ; $6633
	ld [$c8f7], a ; $6635
	farcall FarPtr_LoadMatchSettingsFromTable ; $6638
	farcall FarPtr_RunStoryMatch ; $663b
	farcall FarPtr_RestoreOverworldAfterMatch ; $663e
	ret ; $6641
Label_11_6642:
	ld a, $03 ; $6642
	ld b, $80 ; $6644
	farcall FarPtr_SetActorFacing ; $6646
	push af ; $6649
	ld a, $0f ; $664a
	farcall FarPtr_WaitScriptFrames ; $664c
	pop af ; $664f
	ld a, $00 ; $6650
	ld b, $80 ; $6652
	farcall FarPtr_SetActorFacing ; $6654
	ld a, $02 ; $6657
	ld b, $80 ; $6659
	farcall FarPtr_SetActorFacing ; $665b
	ld a, $05 ; $665e
	ld b, $80 ; $6660
	farcall FarPtr_SetActorFacing ; $6662
	ld a, $07 ; $6665
	ld b, $80 ; $6667
	farcall FarPtr_SetActorFacing ; $6669
	ldh a, [hRomBank] ; $666c
	ld b, a ; $666e
	ld a, $0c ; $666f
	ld de, $6df8 ; $6671
	farcall FarPtr_ScriptSetActorScript ; $6674
	ldh a, [hRomBank] ; $6677
	ld b, a ; $6679
	ld a, $0d ; $667a
	ld de, $6e07 ; $667c
	farcall FarPtr_ScriptSetActorScript ; $667f
	ld a, $0d ; $6682
	farcall FarPtr_WaitActorScriptDone ; $6684
	ld a, $02 ; $6687
	farcall FarPtr_SetActorNullScript ; $6689
	xor a, a ; $668c
	ld bc, $0b00 ; $668d
	ld de, $1100 ; $6690
	farcall FarPtr_MovePlayerToPosition ; $6693
	ldh a, [hRomBank] ; $6696
	ld b, a ; $6698
	ld a, $05 ; $6699
	ld de, $5b98 ; $669b
	farcall FarPtr_ScriptSetActorScript ; $669e
	ldh a, [hRomBank] ; $66a1
	ld b, a ; $66a3
	ld a, $07 ; $66a4
	ld de, $5bb2 ; $66a6
	farcall FarPtr_ScriptSetActorScript ; $66a9
	push af ; $66ac
	ld a, $1e ; $66ad
	farcall FarPtr_WaitScriptFrames ; $66af
	pop af ; $66b2
	ldh a, [hRomBank] ; $66b3
	ld b, a ; $66b5
	ld a, $00 ; $66b6
	ld de, $7773 ; $66b8
	farcall FarPtr_ScriptSetActorScript ; $66bb
	ldh a, [hRomBank] ; $66be
	ld b, a ; $66c0
	ld a, $02 ; $66c1
	ld de, $5d27 ; $66c3
	farcall FarPtr_ScriptSetActorScript ; $66c6
	ld a, $00 ; $66c9
	farcall FarPtr_WaitActorScriptDone ; $66cb
	ld a, $00 ; $66ce
	ld b, $c0 ; $66d0
	farcall FarPtr_SetActorFacing ; $66d2
	ld a, $02 ; $66d5
	ld b, $c0 ; $66d7
	farcall FarPtr_SetActorFacing ; $66d9
	push af ; $66dc
	ld a, $3c ; $66dd
	farcall FarPtr_WaitScriptFrames ; $66df
	pop af ; $66e2
	ld a, $0f ; $66e3
	ld [$c294], a ; $66e5
	ld [wStoryModeExitLocationRequest], a ; $66e8
	farcall FarPtr_InitStoryMatchSettings ; $66eb
	ld a, $01 ; $66ee
	ld [wCurrentMinigameStoryMatch], a ; $66f0
	ld a, $03 ; $66f3
	ld [$c8f7], a ; $66f5
	farcall FarPtr_LoadMatchSettingsFromTable ; $66f8
	farcall FarPtr_RunStoryMatch ; $66fb
	farcall FarPtr_RestoreOverworldAfterMatch ; $66fe
	ret ; $6701
Label_11_6702:
	ld a, $03 ; $6702
	ld b, $00 ; $6704
	farcall FarPtr_SetActorFacing ; $6706
	push af ; $6709
	ld a, $0f ; $670a
	farcall FarPtr_WaitScriptFrames ; $670c
	pop af ; $670f
	ld a, $00 ; $6710
	ld b, $00 ; $6712
	farcall FarPtr_SetActorFacing ; $6714
	ld a, $07 ; $6717
	ld b, $00 ; $6719
	farcall FarPtr_SetActorFacing ; $671b
	push af ; $671e
	ld a, $1e ; $671f
	farcall FarPtr_WaitScriptFrames ; $6721
	pop af ; $6724
	ld a, $02 ; $6725
	farcall FarPtr_SetActorNullScript ; $6727
	xor a, a ; $672a
	ld bc, $1900 ; $672b
	ld de, $1100 ; $672e
	farcall FarPtr_MovePlayerToPosition ; $6731
	ldh a, [hRomBank] ; $6734
	ld b, a ; $6736
	ld a, $04 ; $6737
	ld de, $5b70 ; $6739
	farcall FarPtr_ScriptSetActorScript ; $673c
	ldh a, [hRomBank] ; $673f
	ld b, a ; $6741
	ld a, $06 ; $6742
	ld de, $5b84 ; $6744
	farcall FarPtr_ScriptSetActorScript ; $6747
	ld a, $00 ; $674a
	ld bc, $1b00 ; $674c
	ld de, $1900 ; $674f
	farcall FarPtr_ScriptSetActorMoveTarget ; $6752
	push af ; $6755
	ld a, $14 ; $6756
	farcall FarPtr_WaitScriptFrames ; $6758
	pop af ; $675b
	ld a, $02 ; $675c
	ld bc, $1900 ; $675e
	ld de, $1500 ; $6761
	farcall FarPtr_ScriptSetActorMoveTarget ; $6764
	ld a, $00 ; $6767
	farcall FarPtr_ScriptWaitActorMoveDone ; $6769
	ld a, $00 ; $676c
	ld b, $c0 ; $676e
	farcall FarPtr_SetActorFacing ; $6770
	ld a, $02 ; $6773
	ld b, $c0 ; $6775
	farcall FarPtr_SetActorFacing ; $6777
	push af ; $677a
	ld a, $3c ; $677b
	farcall FarPtr_WaitScriptFrames ; $677d
	pop af ; $6780
	ld a, $0f ; $6781
	ld [$c294], a ; $6783
	ld [wStoryModeExitLocationRequest], a ; $6786
	farcall FarPtr_InitStoryMatchSettings ; $6789
	ld a, $01 ; $678c
	ld [wCurrentMinigameStoryMatch], a ; $678e
	ld a, $04 ; $6791
	ld [$c8f7], a ; $6793
	farcall FarPtr_LoadMatchSettingsFromTable ; $6796
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
	ldh a, [hRomBank] ; $67b0
	ld b, a ; $67b2
	ld a, $08 ; $67b3
	ld de, $5b14 ; $67b5
	farcall FarPtr_ScriptSetActorScript ; $67b8
	ldh a, [hRomBank] ; $67bb
	ld b, a ; $67bd
	ld a, $09 ; $67be
	ld de, $5b42 ; $67c0
	farcall FarPtr_ScriptSetActorScript ; $67c3
	ld a, $09 ; $67c6
	farcall FarPtr_WaitActorScriptDone ; $67c8
	ldh a, [hRomBank] ; $67cb
	ld b, a ; $67cd
	ld a, $09 ; $67ce
	ld de, $681f ; $67d0
	farcall FarPtr_ScriptSetActorScript ; $67d3
	ld a, $08 ; $67d6
	farcall FarPtr_WaitActorScriptDone ; $67d8
	ldh a, [hRomBank] ; $67db
	ld b, a ; $67dd
	ld a, $08 ; $67de
	ld de, $7d86 ; $67e0
	farcall FarPtr_ScriptSetActorScript ; $67e3
	ret ; $67e6
Label_11_67e7:
	ldh a, [hRomBank] ; $67e7
	ld b, a ; $67e9
	ld a, $05 ; $67ea
	ld de, $5bfa ; $67ec
	farcall FarPtr_ScriptSetActorScript ; $67ef
	ldh a, [hRomBank] ; $67f2
	ld b, a ; $67f4
	ld a, $07 ; $67f5
	ld de, $5c45 ; $67f7
	farcall FarPtr_ScriptSetActorScript ; $67fa
	ld a, $05 ; $67fd
	farcall FarPtr_WaitActorScriptDone ; $67ff
	ret ; $6802
Label_11_6803:
	ldh a, [hRomBank] ; $6803
	ld b, a ; $6805
	ld a, $04 ; $6806
	ld de, $5c7f ; $6808
	farcall FarPtr_ScriptSetActorScript ; $680b
	ldh a, [hRomBank] ; $680e
	ld b, a ; $6810
	ld a, $06 ; $6811
	ld de, $5cbf ; $6813
	farcall FarPtr_ScriptSetActorScript ; $6816
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
	ld a, $00 ; $693d
	ld bc, $0008 ; $693f
	farcall FarPtr_ScriptSetActorMoveSpeed ; $6942
	ld a, $00 ; $6945
	ld b, $01 ; $6947
	farcall FarPtr_ScriptSetActorFacingLock ; $6949
	ld a, $00 ; $694c
	ld bc, $1300 ; $694e
	ld de, $1500 ; $6951
	farcall FarPtr_ScriptSetActorMoveTarget ; $6954
	ld a, $00 ; $6957
	farcall FarPtr_ScriptWaitActorMoveDone ; $6959
	ld a, $00 ; $695c
	ld b, $00 ; $695e
	farcall FarPtr_ScriptSetActorFacingLock ; $6960
	ld a, $00 ; $6963
	ld b, $c0 ; $6965
	farcall FarPtr_SetActorFacing ; $6967
	call OfferSinglesRankingMatch ; $696a
	ret ; $696d
	ld hl, $083e ; $696e
	farcall FarPtr_InitDialogueTextCursor ; $6971
	test_flag $0a, 3 ; $6974
	jr nz, Label_11_6984 ; $6977
	farcall FarPtr_AdvanceDialogueTextCursor ; $6979
	test_flag $0a, 2 ; $697c
	jr nz, Label_11_6984 ; $697f
	farcall FarPtr_AdvanceDialogueTextCursor ; $6981
Label_11_6984:
	ld a, $04 ; $6984
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6986
	ret ; $6989
	ld hl, $0841 ; $698a
	farcall FarPtr_InitDialogueTextCursor ; $698d
	test_flag $0a, 2 ; $6990
	jr nz, Label_11_69a3 ; $6993
	farcall FarPtr_AdvanceDialogueTextCursor ; $6995
	test_flag $0a, 1 ; $6998
	jr nz, Label_11_69a9 ; $699b
	ld hl, $0845 ; $699d
	farcall FarPtr_InitDialogueTextCursor ; $69a0
Label_11_69a3:
	ld a, $05 ; $69a3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $69a5
	ret ; $69a8
Label_11_69a9:
	ld a, $05 ; $69a9
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $69ab
	farcall FarPtr_RunDialogueYesNoPrompt ; $69ae
	farcall FarPtr_ScriptCloseDialogueWindow ; $69b1
	push af ; $69b4
	ld a, $05 ; $69b5
	farcall FarPtr_WaitScriptFrames ; $69b7
	pop af ; $69ba
	and a, a ; $69bb
	jr z, Label_11_69c1 ; $69bc
	farcall FarPtr_AdvanceDialogueTextCursor ; $69be
Label_11_69c1:
	ld a, $05 ; $69c1
	farcall FarPtr_ScriptShowSpeakerDialogue ; $69c3
	ret ; $69c6
	ld hl, $0846 ; $69c7
	farcall FarPtr_InitDialogueTextCursor ; $69ca
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
	push af ; $69e8
	ld a, $05 ; $69e9
	farcall FarPtr_WaitScriptFrames ; $69eb
	pop af ; $69ee
	and a, a ; $69ef
	jr z, Label_11_69f5 ; $69f0
	farcall FarPtr_AdvanceDialogueTextCursor ; $69f2
Label_11_69f5:
	ld a, $06 ; $69f5
	farcall FarPtr_ScriptShowSpeakerDialogue ; $69f7
	ret ; $69fa
	ld hl, $084b ; $69fb
	farcall FarPtr_InitDialogueTextCursor ; $69fe
	test_flag $0a, 0 ; $6a01
	jr nz, Label_11_6a09 ; $6a04
	farcall FarPtr_AdvanceDialogueTextCursor ; $6a06
Label_11_6a09:
	ld a, $07 ; $6a09
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6a0b
	ret ; $6a0e
	test_flag $0a, 0 ; $6a0f
	jr z, Label_11_6a20 ; $6a12
	ld hl, $0856 ; $6a14
	farcall FarPtr_InitDialogueTextCursor ; $6a17
	ld a, $08 ; $6a1a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6a1c
	ret ; $6a1f
Label_11_6a20:
	ld hl, $084d ; $6a20
	farcall FarPtr_InitDialogueTextCursor ; $6a23
	ld a, $08 ; $6a26
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6a28
	farcall FarPtr_RunDialogueYesNoPrompt ; $6a2b
	farcall FarPtr_ScriptCloseDialogueWindow ; $6a2e
	push af ; $6a31
	ld a, $05 ; $6a32
	farcall FarPtr_WaitScriptFrames ; $6a34
	pop af ; $6a37
	and a, a ; $6a38
	jr z, Label_11_6a41 ; $6a39
Label_11_6a3b:
	ld a, $08 ; $6a3b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6a3d
	ret ; $6a40
Label_11_6a41:
	farcall FarPtr_AdvanceDialogueTextCursor ; $6a41
	ld a, $08 ; $6a44
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6a46
	farcall FarPtr_RunDialogueYesNoPrompt ; $6a49
	farcall FarPtr_ScriptCloseDialogueWindow ; $6a4c
	push af ; $6a4f
	ld a, $05 ; $6a50
	farcall FarPtr_WaitScriptFrames ; $6a52
	pop af ; $6a55
	and a, a ; $6a56
	jr nz, Label_11_6a3b ; $6a57
	ld a, $00 ; $6a59
	ld d, $03 ; $6a5b
	farcall FarPtr_ScriptSetActorAnimation ; $6a5d
	ld a, $00 ; $6a60
	farcall FarPtr_ScriptWaitActorIdle ; $6a62
	xor a, a ; $6a65
	ld bc, $2b00 ; $6a66
	ld de, $1100 ; $6a69
	farcall FarPtr_MovePlayerToPosition ; $6a6c
	ld a, $00 ; $6a6f
	ld bc, $2700 ; $6a71
	ld de, $1900 ; $6a74
	farcall FarPtr_ScriptSetActorMoveTarget ; $6a77
	push af ; $6a7a
	ld a, $1e ; $6a7b
	farcall FarPtr_WaitScriptFrames ; $6a7d
	pop af ; $6a80
	ld a, $08 ; $6a81
	ld bc, $2b00 ; $6a83
	ld de, $0900 ; $6a86
	farcall FarPtr_ScriptSetActorMoveTarget ; $6a89
	ld a, $08 ; $6a8c
	farcall FarPtr_ScriptWaitActorMoveDone ; $6a8e
	ld a, $08 ; $6a91
	ld b, $40 ; $6a93
	farcall FarPtr_SetActorFacing ; $6a95
	ld a, $00 ; $6a98
	farcall FarPtr_ScriptWaitActorMoveDone ; $6a9a
	ld a, $00 ; $6a9d
	ld bc, $2d00 ; $6a9f
	ld de, $1900 ; $6aa2
	farcall FarPtr_ScriptSetActorMoveTarget ; $6aa5
	ld a, $00 ; $6aa8
	farcall FarPtr_ScriptWaitActorMoveDone ; $6aaa
	ld a, $00 ; $6aad
	ld b, $c0 ; $6aaf
	farcall FarPtr_SetActorFacing ; $6ab1
	push af ; $6ab4
	ld a, $3c ; $6ab5
	farcall FarPtr_WaitScriptFrames ; $6ab7
	pop af ; $6aba
	ld hl, wStoryModePlayersXPosition ; $6abb
	ld de, wStoryModeSpawnPosition ; $6abe
	ld bc, $0005 ; $6ac1
	call CopyMemoryBC ; $6ac4
	ld a, $ff ; $6ac7
	ld [wStoryModeEntryPoint], a ; $6ac9
	ld [$c294], a ; $6acc
	ld [wStoryModeExitLocationRequest], a ; $6acf
	farcall FarPtr_InitStoryMatchSettings ; $6ad2
	ld a, $00 ; $6ad5
	ld [wCurrentMinigameStoryMatch], a ; $6ad7
	ld a, $00 ; $6ada
	ld [$c8f7], a ; $6adc
	farcall FarPtr_LoadMatchSettingsFromTable ; $6adf
	farcall FarPtr_RunStoryMatch ; $6ae2
	farcall FarPtr_RestoreOverworldAfterMatch ; $6ae5
	ret ; $6ae8
	ld hl, $0851 ; $6ae9
	farcall FarPtr_InitDialogueTextCursor ; $6aec
	test_flag $0a, 0 ; $6aef
	jr z, Label_11_6afa ; $6af2
	ld hl, $0857 ; $6af4
	farcall FarPtr_InitDialogueTextCursor ; $6af7
Label_11_6afa:
	ld a, $09 ; $6afa
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6afc
	ret ; $6aff
	ld hl, $0852 ; $6b00
	farcall FarPtr_InitDialogueTextCursor ; $6b03
	test_flag $0a, 0 ; $6b06
	jr z, Label_11_6b11 ; $6b09
	ld hl, $0858 ; $6b0b
	farcall FarPtr_InitDialogueTextCursor ; $6b0e
Label_11_6b11:
	ld a, $0a ; $6b11
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6b13
	ret ; $6b16
	ld a, $00 ; $6b17
	ld b, a ; $6b19
	ld a, $0b ; $6b1a
	farcall FarPtr_FaceActorTowardActor ; $6b1c
	test_flag $0a, 0 ; $6b1f
	jr z, Label_11_6b30 ; $6b22
	ld hl, $0859 ; $6b24
	farcall FarPtr_InitDialogueTextCursor ; $6b27
	ld a, $0b ; $6b2a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6b2c
	ret ; $6b2f
Label_11_6b30:
	ld hl, $0853 ; $6b30
	farcall FarPtr_InitDialogueTextCursor ; $6b33
	ld a, $0b ; $6b36
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6b38
	farcall FarPtr_RunDialogueYesNoPrompt ; $6b3b
	farcall FarPtr_ScriptCloseDialogueWindow ; $6b3e
	push af ; $6b41
	ld a, $05 ; $6b42
	farcall FarPtr_WaitScriptFrames ; $6b44
	pop af ; $6b47
	and a, a ; $6b48
	jr z, Label_11_6b4e ; $6b49
	farcall FarPtr_AdvanceDialogueTextCursor ; $6b4b
Label_11_6b4e:
	ld a, $0b ; $6b4e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6b50
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
	ld hl, $0c0f ; $6cae
	farcall FarPtr_InitDialogueTextCursor ; $6cb1
	ld a, $0a ; $6cb4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6cb6
	ret ; $6cb9
Label_11_6cba:
	ld hl, $0c10 ; $6cba
	farcall FarPtr_InitDialogueTextCursor ; $6cbd
	ld a, $0a ; $6cc0
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6cc2
	farcall FarPtr_RunDialogueYesNoPrompt ; $6cc5
	farcall FarPtr_ScriptCloseDialogueWindow ; $6cc8
	push af ; $6ccb
	ld a, $05 ; $6ccc
	farcall FarPtr_WaitScriptFrames ; $6cce
	pop af ; $6cd1
	and a, a ; $6cd2
	jp z, Label_11_6cd9 ; $6cd3
	farcall FarPtr_AdvanceDialogueTextCursor ; $6cd6
Label_11_6cd9:
	test_flag $06, 5 ; $6cd9
	jr nz, Label_11_6ce4 ; $6cdc
	ld a, $0a ; $6cde
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6ce0
	ret ; $6ce3
Label_11_6ce4:
	ld a, $0a ; $6ce4
	ld d, $03 ; $6ce6
	farcall FarPtr_ScriptSetActorAnimation ; $6ce8
	ld a, $0a ; $6ceb
	farcall FarPtr_ScriptWaitActorIdle ; $6ced
	ld hl, $0c1f ; $6cf0
	farcall FarPtr_InitDialogueTextCursor ; $6cf3
	ld a, $0a ; $6cf6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6cf8
	ret ; $6cfb
	ds 2, $ff ; $6cfc, fill
	test_flag $0a, 0 ; $6cfe
	jr z, Label_11_6d15 ; $6d01
	ld a, $07 ; $6d03
	ld bc, $2500 ; $6d05
	ld de, $0b00 ; $6d08
	farcall FarPtr_ScriptSetActorPosition ; $6d0b
	ld a, $07 ; $6d0e
	ld b, $00 ; $6d10
	farcall FarPtr_SetActorFacing ; $6d12
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
	ld a, $04 ; $6d45
	ld bc, $3f00 ; $6d47
	ld de, $2900 ; $6d4a
	farcall FarPtr_ScriptSetActorPosition ; $6d4d
	ret ; $6d50
Label_11_6d51:
	ld hl, $6c27 ; $6d51
	ld de, $000c ; $6d54
	farcall FarPtr_WriteStoryStateWord ; $6d57
	ld a, $04 ; $6d5a
	ld bc, $3f00 ; $6d5c
	ld de, $2900 ; $6d5f
	farcall FarPtr_ScriptSetActorPosition ; $6d62
	ret ; $6d65
Label_11_6d66:
	ld hl, $6be6 ; $6d66
	ld de, $000c ; $6d69
	farcall FarPtr_WriteStoryStateWord ; $6d6c
	ld a, $0a ; $6d6f
	ld bc, $3d00 ; $6d71
	ld de, $1100 ; $6d74
	farcall FarPtr_ScriptSetActorPosition ; $6d77
	ldh a, [hRomBank] ; $6d7a
	ld b, a ; $6d7c
	ld a, $0a ; $6d7d
	ld de, $7bbd ; $6d7f
	farcall FarPtr_ScriptSetActorScript ; $6d82
	ld a, $04 ; $6d85
	ld bc, $3f00 ; $6d87
	ld de, $2900 ; $6d8a
	farcall FarPtr_ScriptSetActorPosition ; $6d8d
	ret ; $6d90
Label_11_6d91:
	ld hl, $6ba5 ; $6d91
	ld de, $000c ; $6d94
	farcall FarPtr_WriteStoryStateWord ; $6d97
	ld a, $0a ; $6d9a
	ld bc, $3d00 ; $6d9c
	ld de, $1100 ; $6d9f
	farcall FarPtr_ScriptSetActorPosition ; $6da2
	ldh a, [hRomBank] ; $6da5
	ld b, a ; $6da7
	ld a, $0a ; $6da8
	ld de, $7bbd ; $6daa
	farcall FarPtr_ScriptSetActorScript ; $6dad
	ld a, $04 ; $6db0
	ld bc, $3f00 ; $6db2
	ld de, $2900 ; $6db5
	farcall FarPtr_ScriptSetActorPosition ; $6db8
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
	ld bc, $0040 ; $6e62
	farcall FarPtr_SetPlayerMoveSpeed ; $6e65
	xor a, a ; $6e68
	ld bc, $1300 ; $6e69
	ld de, $1500 ; $6e6c
	farcall FarPtr_MovePlayerToPosition ; $6e6f
	ld a, $00 ; $6e72
	ld bc, $1300 ; $6e74
	ld de, $1500 ; $6e77
	farcall FarPtr_ScriptSetActorPosition ; $6e7a
	ld a, $00 ; $6e7d
	ld b, $c0 ; $6e7f
	farcall FarPtr_SetActorFacing ; $6e81
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
	ld bc, $0040 ; $6eb4
	farcall FarPtr_SetPlayerMoveSpeed ; $6eb7
	ld a, $07 ; $6eba
	ld bc, $1a00 ; $6ebc
	ld de, $0900 ; $6ebf
	farcall FarPtr_ScriptSetActorPosition ; $6ec2
	ld a, $00 ; $6ec5
	ld bc, $1a00 ; $6ec7
	ld de, $1400 ; $6eca
	farcall FarPtr_ScriptSetActorPosition ; $6ecd
	xor a, a ; $6ed0
	ld bc, $1a00 ; $6ed1
	ld de, $0f00 ; $6ed4
	farcall FarPtr_MovePlayerToPosition ; $6ed7
	farcall FarPtr_WaitPlayerMoveDone ; $6eda
	ld a, $00 ; $6edd
	ld b, $c0 ; $6edf
	farcall FarPtr_SetActorFacing ; $6ee1
	ld a, $07 ; $6ee4
	ld b, $40 ; $6ee6
	farcall FarPtr_SetActorFacing ; $6ee8
	ld a, $03 ; $6eeb
	ld b, $00 ; $6eed
	farcall FarPtr_SetActorFacing ; $6eef
	ld c, $04 ; $6ef2
	call BeginFadeIn ; $6ef4
	call WaitFadeEnd ; $6ef7
	ld hl, $0833 ; $6efa
	farcall FarPtr_InitDialogueTextCursor ; $6efd
	ld a, $07 ; $6f00
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6f02
	ld a, $03 ; $6f05
	ld de, $ff80 ; $6f07
	farcall FarPtr_ScriptSetActorJumpVelocity ; $6f0a
	ld a, $03 ; $6f0d
	farcall FarPtr_ScriptWaitActorJumpDone ; $6f0f
	ld a, $03 ; $6f12
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6f14
	ldh a, [hRomBank] ; $6f17
	ld b, a ; $6f19
	ld a, $07 ; $6f1a
	ld de, $7682 ; $6f1c
	farcall FarPtr_ScriptSetActorScript ; $6f1f
	ld a, $00 ; $6f22
	ld bc, $1300 ; $6f24
	ld de, $1500 ; $6f27
	farcall FarPtr_ScriptSetActorMoveTarget ; $6f2a
	ld a, $00 ; $6f2d
	farcall FarPtr_ScriptWaitActorMoveDone ; $6f2f
	ld a, $00 ; $6f32
	ld b, $40 ; $6f34
	farcall FarPtr_SetActorFacing ; $6f36
	call Func_11_7b2d ; $6f39
	ld a, $03 ; $6f3c
	ld b, $40 ; $6f3e
	farcall FarPtr_SetActorFacing ; $6f40
	ret ; $6f43
Label_11_6f44:
	call Func_11_7ab3 ; $6f44
	ld bc, $0040 ; $6f47
	farcall FarPtr_SetPlayerMoveSpeed ; $6f4a
	ld a, $06 ; $6f4d
	ld bc, $0900 ; $6f4f
	ld de, $0900 ; $6f52
	farcall FarPtr_ScriptSetActorPosition ; $6f55
	ld a, $00 ; $6f58
	ld bc, $0b00 ; $6f5a
	ld de, $1400 ; $6f5d
	farcall FarPtr_ScriptSetActorPosition ; $6f60
	xor a, a ; $6f63
	ld bc, $0b00 ; $6f64
	ld de, $0f00 ; $6f67
	farcall FarPtr_MovePlayerToPosition ; $6f6a
	farcall FarPtr_WaitPlayerMoveDone ; $6f6d
	ld a, $00 ; $6f70
	ld b, $c0 ; $6f72
	farcall FarPtr_SetActorFacing ; $6f74
	ld a, $06 ; $6f77
	ld b, $40 ; $6f79
	farcall FarPtr_SetActorFacing ; $6f7b
	ld a, $03 ; $6f7e
	ld b, $80 ; $6f80
	farcall FarPtr_SetActorFacing ; $6f82
	ld c, $04 ; $6f85
	call BeginFadeIn ; $6f87
	call WaitFadeEnd ; $6f8a
	ld hl, $0846 ; $6f8d
	farcall FarPtr_InitDialogueTextCursor ; $6f90
	ld a, $06 ; $6f93
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6f95
	ld a, $03 ; $6f98
	ld de, $ff80 ; $6f9a
	farcall FarPtr_ScriptSetActorJumpVelocity ; $6f9d
	ld a, $03 ; $6fa0
	farcall FarPtr_ScriptWaitActorJumpDone ; $6fa2
	ld hl, $0835 ; $6fa5
	farcall FarPtr_InitDialogueTextCursor ; $6fa8
	ld a, $03 ; $6fab
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6fad
	ldh a, [hRomBank] ; $6fb0
	ld b, a ; $6fb2
	ld a, $06 ; $6fb3
	ld de, $76de ; $6fb5
	farcall FarPtr_ScriptSetActorScript ; $6fb8
	ld a, $00 ; $6fbb
	ld bc, $1300 ; $6fbd
	ld de, $1500 ; $6fc0
	farcall FarPtr_ScriptSetActorMoveTarget ; $6fc3
	ld a, $00 ; $6fc6
	farcall FarPtr_ScriptWaitActorMoveDone ; $6fc8
	ld a, $00 ; $6fcb
	ld b, $40 ; $6fcd
	farcall FarPtr_SetActorFacing ; $6fcf
	call Func_11_7b6b ; $6fd2
	ld a, $03 ; $6fd5
	ld b, $40 ; $6fd7
	farcall FarPtr_SetActorFacing ; $6fd9
	ret ; $6fdc
Label_11_6fdd:
	call Func_11_7ab3 ; $6fdd
	ld bc, $0040 ; $6fe0
	farcall FarPtr_SetPlayerMoveSpeed ; $6fe3
	ld a, $05 ; $6fe6
	ld bc, $0900 ; $6fe8
	ld de, $0900 ; $6feb
	farcall FarPtr_ScriptSetActorPosition ; $6fee
	ld a, $00 ; $6ff1
	ld bc, $0b00 ; $6ff3
	ld de, $1400 ; $6ff6
	farcall FarPtr_ScriptSetActorPosition ; $6ff9
	xor a, a ; $6ffc
	ld bc, $0b00 ; $6ffd
	ld de, $0f00 ; $7000
	farcall FarPtr_MovePlayerToPosition ; $7003
	farcall FarPtr_WaitPlayerMoveDone ; $7006
	ld a, $00 ; $7009
	ld b, $c0 ; $700b
	farcall FarPtr_SetActorFacing ; $700d
	ld a, $05 ; $7010
	ld b, $40 ; $7012
	farcall FarPtr_SetActorFacing ; $7014
	ld a, $03 ; $7017
	ld b, $80 ; $7019
	farcall FarPtr_SetActorFacing ; $701b
	ld c, $04 ; $701e
	call BeginFadeIn ; $7020
	call WaitFadeEnd ; $7023
	ld hl, $0841 ; $7026
	farcall FarPtr_InitDialogueTextCursor ; $7029
	ld a, $05 ; $702c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $702e
	ld a, $03 ; $7031
	ld de, $ff80 ; $7033
	farcall FarPtr_ScriptSetActorJumpVelocity ; $7036
	ld a, $03 ; $7039
	farcall FarPtr_ScriptWaitActorJumpDone ; $703b
	ld hl, $0836 ; $703e
	farcall FarPtr_InitDialogueTextCursor ; $7041
	ld a, $03 ; $7044
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7046
	ldh a, [hRomBank] ; $7049
	ld b, a ; $704b
	ld a, $05 ; $704c
	ld de, $7717 ; $704e
	farcall FarPtr_ScriptSetActorScript ; $7051
	ld a, $00 ; $7054
	ld bc, $1300 ; $7056
	ld de, $1500 ; $7059
	farcall FarPtr_ScriptSetActorMoveTarget ; $705c
	ld a, $00 ; $705f
	farcall FarPtr_ScriptWaitActorMoveDone ; $7061
	ld a, $00 ; $7064
	ld b, $40 ; $7066
	farcall FarPtr_SetActorFacing ; $7068
	call Func_11_7b6b ; $706b
	ld a, $03 ; $706e
	ld b, $40 ; $7070
	farcall FarPtr_SetActorFacing ; $7072
	ret ; $7075
Label_11_7076:
	ld bc, $0040 ; $7076
	farcall FarPtr_SetPlayerMoveSpeed ; $7079
	ld a, $03 ; $707c
	ld bc, $1300 ; $707e
	ld de, $1f00 ; $7081
	farcall FarPtr_ScriptSetActorPosition ; $7084
	ld a, $04 ; $7087
	ld bc, $1a00 ; $7089
	ld de, $0b00 ; $708c
	farcall FarPtr_ScriptSetActorPosition ; $708f
	ld a, $00 ; $7092
	ld bc, $1a00 ; $7094
	ld de, $1400 ; $7097
	farcall FarPtr_ScriptSetActorPosition ; $709a
	xor a, a ; $709d
	ld bc, $1a00 ; $709e
	ld de, $1100 ; $70a1
	farcall FarPtr_MovePlayerToPosition ; $70a4
	farcall FarPtr_WaitPlayerMoveDone ; $70a7
	ld a, $00 ; $70aa
	ld b, $c0 ; $70ac
	farcall FarPtr_SetActorFacing ; $70ae
	ld a, $04 ; $70b1
	ld b, $40 ; $70b3
	farcall FarPtr_SetActorFacing ; $70b5
	ld a, $03 ; $70b8
	ld b, $c0 ; $70ba
	farcall FarPtr_SetActorFacing ; $70bc
	call Func_11_7a76 ; $70bf
	ld c, $04 ; $70c2
	call BeginFadeIn ; $70c4
	call WaitFadeEnd ; $70c7
	push af ; $70ca
	ld a, $3c ; $70cb
	farcall FarPtr_WaitScriptFrames ; $70cd
	pop af ; $70d0
	ld hl, $0837 ; $70d1
	farcall FarPtr_InitDialogueTextCursor ; $70d4
	ld a, $04 ; $70d7
	ld bc, $1a00 ; $70d9
	ld de, $0d00 ; $70dc
	farcall FarPtr_ScriptSetActorMoveTarget ; $70df
	ld a, $04 ; $70e2
	farcall FarPtr_ScriptWaitActorMoveDone ; $70e4
	ld a, $04 ; $70e7
	ld d, $02 ; $70e9
	farcall FarPtr_ScriptSetActorAnimation ; $70eb
	ld a, $04 ; $70ee
	farcall FarPtr_ScriptShowSpeakerDialogue ; $70f0
	ld a, $03 ; $70f3
	ld d, $03 ; $70f5
	farcall FarPtr_ScriptSetActorAnimation ; $70f7
	ld a, $03 ; $70fa
	farcall FarPtr_ScriptShowSpeakerDialogue ; $70fc
	ld a, $04 ; $70ff
	ld d, $02 ; $7101
	farcall FarPtr_ScriptSetActorAnimation ; $7103
	ld a, $00 ; $7106
	ld d, $02 ; $7108
	farcall FarPtr_ScriptSetActorAnimation ; $710a
	ld a, $00 ; $710d
	ld b, $40 ; $710f
	farcall FarPtr_SetActorFacing ; $7111
	ld bc, $0010 ; $7114
	farcall FarPtr_SetPlayerMoveSpeed ; $7117
	ld a, $03 ; $711a
	ld bc, $0010 ; $711c
	farcall FarPtr_ScriptSetActorMoveSpeed ; $711f
	xor a, a ; $7122
	ld bc, $1300 ; $7123
	ld de, $1900 ; $7126
	farcall FarPtr_MovePlayerToPosition ; $7129
	ld a, $03 ; $712c
	ld bc, $1300 ; $712e
	ld de, $1b00 ; $7131
	farcall FarPtr_ScriptSetActorMoveTarget ; $7134
	ld a, $03 ; $7137
	farcall FarPtr_ScriptWaitActorMoveDone ; $7139
	farcall FarPtr_WaitPlayerMoveDone ; $713c
	xor a, a ; $713f
	ld bc, $1a00 ; $7140
	ld de, $1400 ; $7143
	farcall FarPtr_MovePlayerToPosition ; $7146
	ld a, $03 ; $7149
	ld bc, $1a00 ; $714b
	ld de, $1700 ; $714e
	farcall FarPtr_ScriptSetActorMoveTarget ; $7151
	ld a, $03 ; $7154
	farcall FarPtr_ScriptWaitActorMoveDone ; $7156
	ld a, $03 ; $7159
	ld b, $c0 ; $715b
	farcall FarPtr_SetActorFacing ; $715d
	ld a, $03 ; $7160
	ld d, $02 ; $7162
	farcall FarPtr_ScriptSetActorAnimation ; $7164
	ld a, $03 ; $7167
	farcall FarPtr_ScriptWaitActorIdle ; $7169
	ld a, $03 ; $716c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $716e
	ld a, $00 ; $7171
	ld d, $03 ; $7173
	farcall FarPtr_ScriptSetActorAnimation ; $7175
	ld a, $00 ; $7178
	farcall FarPtr_ScriptWaitActorIdle ; $717a
	ld a, $03 ; $717d
	ld d, $03 ; $717f
	farcall FarPtr_ScriptSetActorAnimation ; $7181
	ld a, $03 ; $7184
	farcall FarPtr_ScriptWaitActorIdle ; $7186
	ld a, $03 ; $7189
	farcall FarPtr_ScriptShowSpeakerDialogue ; $718b
	ld a, $03 ; $718e
	ld bc, $1a00 ; $7190
	ld de, $1600 ; $7193
	farcall FarPtr_ScriptSetActorMoveTarget ; $7196
	ld a, $03 ; $7199
	farcall FarPtr_ScriptWaitActorMoveDone ; $719b
	ld a, $03 ; $719e
	ld d, $02 ; $71a0
	farcall FarPtr_ScriptSetActorAnimation ; $71a2
	ld a, $03 ; $71a5
	farcall FarPtr_ScriptWaitActorIdle ; $71a7
	push af ; $71aa
	ld a, $1e ; $71ab
	farcall FarPtr_WaitScriptFrames ; $71ad
	pop af ; $71b0
	ld a, $03 ; $71b1
	ld d, $03 ; $71b3
	farcall FarPtr_ScriptSetActorAnimation ; $71b5
	ld a, $00 ; $71b8
	ld d, $03 ; $71ba
	farcall FarPtr_ScriptSetActorAnimation ; $71bc
	ld a, $00 ; $71bf
	farcall FarPtr_ScriptWaitActorIdle ; $71c1
	ld a, $00 ; $71c4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $71c6
	ld a, $03 ; $71c9
	ld d, $02 ; $71cb
	farcall FarPtr_ScriptSetActorAnimation ; $71cd
	ld a, $03 ; $71d0
	farcall FarPtr_ScriptWaitActorIdle ; $71d2
	ld a, $03 ; $71d5
	farcall FarPtr_ScriptShowSpeakerDialogue ; $71d7
	ld a, $00 ; $71da
	ld d, $03 ; $71dc
	farcall FarPtr_ScriptSetActorAnimation ; $71de
	ld a, $00 ; $71e1
	farcall FarPtr_ScriptWaitActorIdle ; $71e3
	ld a, $03 ; $71e6
	ld d, $03 ; $71e8
	farcall FarPtr_ScriptSetActorAnimation ; $71ea
	ld a, $03 ; $71ed
	farcall FarPtr_ScriptWaitActorIdle ; $71ef
	ld a, $00 ; $71f2
	ld d, $02 ; $71f4
	farcall FarPtr_ScriptSetActorAnimation ; $71f6
	ld a, $00 ; $71f9
	farcall FarPtr_ScriptWaitActorIdle ; $71fb
	ld a, $00 ; $71fe
	ld b, $c0 ; $7200
	farcall FarPtr_SetActorFacing ; $7202
	ld a, $12 ; $7205
	ld bc, $1b80 ; $7207
	ld de, $1280 ; $720a
	farcall FarPtr_ScriptSetActorPosition ; $720d
	sound $96 ; $7210
	push af ; $7212
	ld a, $28 ; $7213
	farcall FarPtr_WaitScriptFrames ; $7215
	pop af ; $7218
	ld a, $04 ; $7219
	ld d, $02 ; $721b
	farcall FarPtr_ScriptSetActorAnimation ; $721d
	push af ; $7220
	ld a, $28 ; $7221
	farcall FarPtr_WaitScriptFrames ; $7223
	pop af ; $7226
	ld a, $04 ; $7227
	ld bc, $1a00 ; $7229
	ld de, $0e00 ; $722c
	farcall FarPtr_ScriptSetActorMoveTarget ; $722f
	ld a, $04 ; $7232
	farcall FarPtr_ScriptWaitActorMoveDone ; $7234
	ld a, $12 ; $7237
	ld bc, $3f00 ; $7239
	ld de, $3f00 ; $723c
	farcall FarPtr_ScriptSetActorPosition ; $723f
	ld a, $04 ; $7242
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7244
	ld a, $0b ; $7247
	ld [wStoryModeCurrentLocation], a ; $7249
	ld a, $01 ; $724c
	ld [wStoryModeEntryPoint], a ; $724e
	ld a, $ff ; $7251
	ld [$c294], a ; $7253
	ld [wStoryModeExitLocationRequest], a ; $7256
	ld a, $03 ; $7259
	ld d, $03 ; $725b
	farcall FarPtr_ScriptSetActorAnimation ; $725d
	ld a, $03 ; $7260
	farcall FarPtr_ScriptWaitActorIdle ; $7262
	push af ; $7265
	ld a, $28 ; $7266
	farcall FarPtr_WaitScriptFrames ; $7268
	pop af ; $726b
	ld a, $00 ; $726c
	ld d, $02 ; $726e
	farcall FarPtr_ScriptSetActorAnimation ; $7270
	ld a, $00 ; $7273
	farcall FarPtr_ScriptWaitActorIdle ; $7275
	push af ; $7278
	ld a, $28 ; $7279
	farcall FarPtr_WaitScriptFrames ; $727b
	pop af ; $727e
	ld c, $04 ; $727f
	call BeginFadeOut ; $7281
	call WaitFadeEnd ; $7284
	ret ; $7287
PromptChallengeRankingOpponent:
	ld hl, $0822 ; $7288
	farcall FarPtr_InitDialogueTextCursor ; $728b
	test_flag $0a, 0 ; $728e
	jr z, Label_11_7296 ; $7291
	farcall FarPtr_AdvanceDialogueTextCursor ; $7293
Label_11_7296:
	ld a, $03 ; $7296
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7298
	farcall FarPtr_RunDialogueYesNoPrompt ; $729b
	farcall FarPtr_ScriptCloseDialogueWindow ; $729e
	push af ; $72a1
	ld a, $05 ; $72a2
	farcall FarPtr_WaitScriptFrames ; $72a4
	pop af ; $72a7
	and a, a ; $72a8
	jp nz, Label_11_72ec ; $72a9
	ld a, $03 ; $72ac
	ld d, $03 ; $72ae
	farcall FarPtr_ScriptSetActorAnimation ; $72b0
	ld a, $03 ; $72b3
	farcall FarPtr_ScriptWaitActorIdle ; $72b5
Label_11_72b8:
	ld a, $03 ; $72b8
	ld d, $03 ; $72ba
	farcall FarPtr_ScriptSetActorAnimation ; $72bc
	ld a, $03 ; $72bf
	farcall FarPtr_ScriptWaitActorIdle ; $72c1
	ld hl, $0828 ; $72c4
	farcall FarPtr_InitDialogueTextCursor ; $72c7
	ld a, $03 ; $72ca
	farcall FarPtr_ScriptShowSpeakerDialogue ; $72cc
	call StartNextRankingMatch ; $72cf
	ld a, $00 ; $72d2
	ld bc, $0018 ; $72d4
	farcall FarPtr_ScriptSetActorMoveSpeed ; $72d7
	ld a, $02 ; $72da
	ld bc, $0018 ; $72dc
	farcall FarPtr_ScriptSetActorMoveSpeed ; $72df
	ret ; $72e2
Label_11_72e3:
	ld a, $03 ; $72e3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $72e5
	call LoadRankingOpponentGraphics ; $72e8
	ret ; $72eb
Label_11_72ec:
	ld hl, $0825 ; $72ec
	farcall FarPtr_InitDialogueTextCursor ; $72ef
	ld a, $03 ; $72f2
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $72f4
	farcall FarPtr_RunDialogueYesNoPrompt ; $72f7
	farcall FarPtr_ScriptCloseDialogueWindow ; $72fa
	push af ; $72fd
	ld a, $05 ; $72fe
	farcall FarPtr_WaitScriptFrames ; $7300
	pop af ; $7303
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
	ldh a, [hRomBank] ; $7325
	ld b, a ; $7327
	ld a, $07 ; $7328
	ld de, $766b ; $732a
	farcall FarPtr_ScriptSetActorScript ; $732d
	ld a, $07 ; $7330
	farcall FarPtr_WaitActorScriptDone ; $7332
	ret ; $7335
Label_11_7336:
	ldh a, [hRomBank] ; $7336
	ld b, a ; $7338
	ld a, $06 ; $7339
	ld de, $76cd ; $733b
	farcall FarPtr_ScriptSetActorScript ; $733e
	ld a, $06 ; $7341
	farcall FarPtr_WaitActorScriptDone ; $7343
	ret ; $7346
Label_11_7347:
	ldh a, [hRomBank] ; $7347
	ld b, a ; $7349
	ld a, $05 ; $734a
	ld de, $7700 ; $734c
	farcall FarPtr_ScriptSetActorScript ; $734f
	ld a, $05 ; $7352
	farcall FarPtr_WaitActorScriptDone ; $7354
	ret ; $7357
Label_11_7358:
	ldh a, [hRomBank] ; $7358
	ld b, a ; $735a
	ld a, $04 ; $735b
	ld de, $7745 ; $735d
	farcall FarPtr_ScriptSetActorScript ; $7360
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
	push af ; $7381
	ld a, $0f ; $7382
	farcall FarPtr_WaitScriptFrames ; $7384
	pop af ; $7387
	ld a, $07 ; $7388
	ld b, a ; $738a
	ld a, $03 ; $738b
	farcall FarPtr_FaceActorTowardActor ; $738d
	push af ; $7390
	ld a, $1e ; $7391
	farcall FarPtr_WaitScriptFrames ; $7393
	pop af ; $7396
	ld a, $07 ; $7397
	ld b, a ; $7399
	ld a, $00 ; $739a
	farcall FarPtr_FaceActorTowardActor ; $739c
	push af ; $739f
	ld a, $1e ; $73a0
	farcall FarPtr_WaitScriptFrames ; $73a2
	pop af ; $73a5
	ld bc, $0020 ; $73a6
	farcall FarPtr_SetPlayerMoveSpeed ; $73a9
	ld a, $07 ; $73ac
	ld b, $00 ; $73ae
	farcall FarPtr_MovePlayerToActor ; $73b0
	farcall FarPtr_WaitPlayerMoveDone ; $73b3
	ld a, $03 ; $73b6
	ld b, a ; $73b8
	ld a, $07 ; $73b9
	farcall FarPtr_FaceActorTowardActor ; $73bb
	ld a, $07 ; $73be
	ld d, $03 ; $73c0
	farcall FarPtr_ScriptSetActorAnimation ; $73c2
	ld a, $07 ; $73c5
	farcall FarPtr_ScriptWaitActorIdle ; $73c7
	push af ; $73ca
	ld a, $0a ; $73cb
	farcall FarPtr_WaitScriptFrames ; $73cd
	pop af ; $73d0
	ldh a, [hRomBank] ; $73d1
	ld b, a ; $73d3
	ld a, $07 ; $73d4
	ld de, $7643 ; $73d6
	farcall FarPtr_ScriptSetActorScript ; $73d9
	push af ; $73dc
	ld a, $0a ; $73dd
	farcall FarPtr_WaitScriptFrames ; $73df
	pop af ; $73e2
	ld a, $00 ; $73e3
	ld b, $00 ; $73e5
	farcall FarPtr_MovePlayerToActor ; $73e7
	ld a, $03 ; $73ea
	ld b, $40 ; $73ec
	farcall FarPtr_SetActorFacing ; $73ee
	farcall FarPtr_WaitPlayerMoveDone ; $73f1
	ld a, $07 ; $73f4
	farcall FarPtr_WaitActorScriptDone ; $73f6
	ld a, $00 ; $73f9
	ld b, a ; $73fb
	ld a, $07 ; $73fc
	farcall FarPtr_FaceActorTowardActor ; $73fe
	ld a, $07 ; $7401
	ld d, $02 ; $7403
	farcall FarPtr_ScriptSetActorAnimation ; $7405
	ld a, $07 ; $7408
	farcall FarPtr_ScriptWaitActorIdle ; $740a
	ld hl, $082a ; $740d
	farcall FarPtr_InitDialogueTextCursor ; $7410
	ld a, $07 ; $7413
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7415
	ld a, $07 ; $7418
	ld d, $03 ; $741a
	farcall FarPtr_ScriptSetActorAnimation ; $741c
	ld a, $07 ; $741f
	farcall FarPtr_ScriptWaitActorIdle ; $7421
	ld a, $07 ; $7424
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7426
	push af ; $7429
	ld a, $0f ; $742a
	farcall FarPtr_WaitScriptFrames ; $742c
	pop af ; $742f
	ld a, $07 ; $7430
	ld b, $c0 ; $7432
	farcall FarPtr_SetActorFacing ; $7434
	ret ; $7437
Label_11_7438:
	push af ; $7438
	ld a, $0f ; $7439
	farcall FarPtr_WaitScriptFrames ; $743b
	pop af ; $743e
	ld a, $06 ; $743f
	ld b, a ; $7441
	ld a, $03 ; $7442
	farcall FarPtr_FaceActorTowardActor ; $7444
	push af ; $7447
	ld a, $1e ; $7448
	farcall FarPtr_WaitScriptFrames ; $744a
	pop af ; $744d
	ld a, $06 ; $744e
	ld b, a ; $7450
	ld a, $00 ; $7451
	farcall FarPtr_FaceActorTowardActor ; $7453
	push af ; $7456
	ld a, $1e ; $7457
	farcall FarPtr_WaitScriptFrames ; $7459
	pop af ; $745c
	ld bc, $0020 ; $745d
	farcall FarPtr_SetPlayerMoveSpeed ; $7460
	ld a, $06 ; $7463
	ld b, $00 ; $7465
	farcall FarPtr_MovePlayerToActor ; $7467
	farcall FarPtr_WaitPlayerMoveDone ; $746a
	ld a, $03 ; $746d
	ld b, a ; $746f
	ld a, $06 ; $7470
	farcall FarPtr_FaceActorTowardActor ; $7472
	ld a, $06 ; $7475
	ld d, $03 ; $7477
	farcall FarPtr_ScriptSetActorAnimation ; $7479
	ld a, $06 ; $747c
	farcall FarPtr_ScriptWaitActorIdle ; $747e
	ldh a, [hRomBank] ; $7481
	ld b, a ; $7483
	ld a, $06 ; $7484
	ld de, $76ab ; $7486
	farcall FarPtr_ScriptSetActorScript ; $7489
	ld a, $00 ; $748c
	ld b, $00 ; $748e
	farcall FarPtr_MovePlayerToActor ; $7490
	ld a, $03 ; $7493
	ld b, $40 ; $7495
	farcall FarPtr_SetActorFacing ; $7497
	ld a, $06 ; $749a
	farcall FarPtr_WaitActorScriptDone ; $749c
	ld a, $06 ; $749f
	ld b, a ; $74a1
	ld a, $00 ; $74a2
	farcall FarPtr_FaceActorTowardActor ; $74a4
	ld a, $06 ; $74a7
	farcall FarPtr_WaitActorScriptDone ; $74a9
	ld a, $06 ; $74ac
	ld d, $02 ; $74ae
	farcall FarPtr_ScriptSetActorAnimation ; $74b0
	ld a, $06 ; $74b3
	farcall FarPtr_ScriptWaitActorIdle ; $74b5
	ld hl, $082c ; $74b8
	farcall FarPtr_InitDialogueTextCursor ; $74bb
	ld a, $06 ; $74be
	farcall FarPtr_ScriptShowSpeakerDialogue ; $74c0
	ld a, $06 ; $74c3
	ld d, $03 ; $74c5
	farcall FarPtr_ScriptSetActorAnimation ; $74c7
	ld a, $06 ; $74ca
	farcall FarPtr_ScriptWaitActorIdle ; $74cc
	ld a, $06 ; $74cf
	farcall FarPtr_ScriptShowSpeakerDialogue ; $74d1
	push af ; $74d4
	ld a, $0f ; $74d5
	farcall FarPtr_WaitScriptFrames ; $74d7
	pop af ; $74da
	ld a, $06 ; $74db
	ld b, $c0 ; $74dd
	farcall FarPtr_SetActorFacing ; $74df
	ret ; $74e2
Label_11_74e3:
	push af ; $74e3
	ld a, $0f ; $74e4
	farcall FarPtr_WaitScriptFrames ; $74e6
	pop af ; $74e9
	ld a, $05 ; $74ea
	ld b, a ; $74ec
	ld a, $03 ; $74ed
	farcall FarPtr_FaceActorTowardActor ; $74ef
	push af ; $74f2
	ld a, $1e ; $74f3
	farcall FarPtr_WaitScriptFrames ; $74f5
	pop af ; $74f8
	ld a, $05 ; $74f9
	ld b, a ; $74fb
	ld a, $00 ; $74fc
	farcall FarPtr_FaceActorTowardActor ; $74fe
	push af ; $7501
	ld a, $1e ; $7502
	farcall FarPtr_WaitScriptFrames ; $7504
	pop af ; $7507
	ld bc, $0020 ; $7508
	farcall FarPtr_SetPlayerMoveSpeed ; $750b
	ld a, $05 ; $750e
	ld b, $00 ; $7510
	farcall FarPtr_MovePlayerToActor ; $7512
	farcall FarPtr_WaitPlayerMoveDone ; $7515
	ld a, $03 ; $7518
	ld b, a ; $751a
	ld a, $05 ; $751b
	farcall FarPtr_FaceActorTowardActor ; $751d
	ld a, $05 ; $7520
	ld d, $03 ; $7522
	farcall FarPtr_ScriptSetActorAnimation ; $7524
	ld a, $05 ; $7527
	farcall FarPtr_ScriptWaitActorIdle ; $7529
	ldh a, [hRomBank] ; $752c
	ld b, a ; $752e
	ld a, $05 ; $752f
	ld de, $76e9 ; $7531
	farcall FarPtr_ScriptSetActorScript ; $7534
	push af ; $7537
	ld a, $0a ; $7538
	farcall FarPtr_WaitScriptFrames ; $753a
	pop af ; $753d
	ld a, $00 ; $753e
	ld b, $00 ; $7540
	farcall FarPtr_MovePlayerToActor ; $7542
	ld a, $03 ; $7545
	ld b, $40 ; $7547
	farcall FarPtr_SetActorFacing ; $7549
	ld a, $05 ; $754c
	farcall FarPtr_WaitActorScriptDone ; $754e
	ld a, $05 ; $7551
	ld b, a ; $7553
	ld a, $00 ; $7554
	farcall FarPtr_FaceActorTowardActor ; $7556
	ld a, $05 ; $7559
	ld d, $02 ; $755b
	farcall FarPtr_ScriptSetActorAnimation ; $755d
	ld a, $05 ; $7560
	farcall FarPtr_ScriptWaitActorIdle ; $7562
	ld hl, $082e ; $7565
	farcall FarPtr_InitDialogueTextCursor ; $7568
	ld a, $05 ; $756b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $756d
	ld a, $05 ; $7570
	ld d, $03 ; $7572
	farcall FarPtr_ScriptSetActorAnimation ; $7574
	ld a, $05 ; $7577
	farcall FarPtr_ScriptWaitActorIdle ; $7579
	ld a, $05 ; $757c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $757e
	push af ; $7581
	ld a, $0f ; $7582
	farcall FarPtr_WaitScriptFrames ; $7584
	pop af ; $7587
	ld a, $05 ; $7588
	ld b, $c0 ; $758a
	farcall FarPtr_SetActorFacing ; $758c
	ret ; $758f
Label_11_7590:
	push af ; $7590
	ld a, $0f ; $7591
	farcall FarPtr_WaitScriptFrames ; $7593
	pop af ; $7596
	ld a, $04 ; $7597
	ld b, a ; $7599
	ld a, $03 ; $759a
	farcall FarPtr_FaceActorTowardActor ; $759c
	push af ; $759f
	ld a, $1e ; $75a0
	farcall FarPtr_WaitScriptFrames ; $75a2
	pop af ; $75a5
	ld a, $04 ; $75a6
	ld b, a ; $75a8
	ld a, $00 ; $75a9
	farcall FarPtr_FaceActorTowardActor ; $75ab
	push af ; $75ae
	ld a, $1e ; $75af
	farcall FarPtr_WaitScriptFrames ; $75b1
	pop af ; $75b4
	ld bc, $0020 ; $75b5
	farcall FarPtr_SetPlayerMoveSpeed ; $75b8
	ld a, $04 ; $75bb
	ld b, $00 ; $75bd
	farcall FarPtr_MovePlayerToActor ; $75bf
	farcall FarPtr_WaitPlayerMoveDone ; $75c2
	ld bc, $d040 ; $75c5
	ld a, $04 ; $75c8
	farcall FarPtr_GetActorStateAddr ; $75ca
	ld e, l ; $75cd
	ld d, h ; $75ce
	farcall FarPtr_04_1e ; $75cf
	ld a, $03 ; $75d2
	ld b, a ; $75d4
	ld a, $04 ; $75d5
	farcall FarPtr_FaceActorTowardActor ; $75d7
	ld a, $04 ; $75da
	ld d, $03 ; $75dc
	farcall FarPtr_ScriptSetActorAnimation ; $75de
	ld a, $04 ; $75e1
	farcall FarPtr_ScriptWaitActorIdle ; $75e3
	ldh a, [hRomBank] ; $75e6
	ld b, a ; $75e8
	ld a, $04 ; $75e9
	ld de, $7728 ; $75eb
	farcall FarPtr_ScriptSetActorScript ; $75ee
	ld a, $03 ; $75f1
	ld b, $40 ; $75f3
	farcall FarPtr_SetActorFacing ; $75f5
	ld a, $00 ; $75f8
	ld b, $00 ; $75fa
	farcall FarPtr_MovePlayerToActor ; $75fc
	ld a, $04 ; $75ff
	farcall FarPtr_WaitActorScriptDone ; $7601
	ld a, $04 ; $7604
	ld b, a ; $7606
	ld a, $00 ; $7607
	farcall FarPtr_FaceActorTowardActor ; $7609
	ld a, $04 ; $760c
	ld d, $02 ; $760e
	farcall FarPtr_ScriptSetActorAnimation ; $7610
	ld a, $04 ; $7613
	farcall FarPtr_ScriptWaitActorIdle ; $7615
	ld hl, $0830 ; $7618
	farcall FarPtr_InitDialogueTextCursor ; $761b
	ld a, $04 ; $761e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7620
	ld a, $04 ; $7623
	ld d, $03 ; $7625
	farcall FarPtr_ScriptSetActorAnimation ; $7627
	ld a, $04 ; $762a
	farcall FarPtr_ScriptWaitActorIdle ; $762c
	ld a, $04 ; $762f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7631
	push af ; $7634
	ld a, $0f ; $7635
	farcall FarPtr_WaitScriptFrames ; $7637
	pop af ; $763a
	ld a, $04 ; $763b
	ld b, $c0 ; $763d
	farcall FarPtr_SetActorFacing ; $763f
	ret ; $7642
	INCBIN "data/bank_011/d_7643.bin" ; $7643, 321 bytes
OfferSinglesRankingMatch:
	ld hl, $081c ; $7784
	farcall FarPtr_InitDialogueTextCursor ; $7787
	ld a, $03 ; $778a
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $778c
	farcall FarPtr_RunDialogueYesNoPrompt ; $778f
	farcall FarPtr_ScriptCloseDialogueWindow ; $7792
	push af ; $7795
	ld a, $05 ; $7796
	farcall FarPtr_WaitScriptFrames ; $7798
	pop af ; $779b
	and a, a ; $779c
	jp nz, Label_11_7817 ; $779d
	ld a, $00 ; $77a0
	ld b, $00 ; $77a2
	farcall FarPtr_ScriptSetActorFacingLock ; $77a4
	ld a, $00 ; $77a7
	ld bc, $0018 ; $77a9
	farcall FarPtr_ScriptSetActorMoveSpeed ; $77ac
	ld a, $00 ; $77af
	ld bc, $1300 ; $77b1
	ld de, $1500 ; $77b4
	farcall FarPtr_ScriptSetActorMoveTarget ; $77b7
	ld a, $00 ; $77ba
	farcall FarPtr_ScriptWaitActorMoveDone ; $77bc
	ld a, $03 ; $77bf
	ld b, a ; $77c1
	ld a, $00 ; $77c2
	farcall FarPtr_FaceActorTowardActor ; $77c4
	push af ; $77c7
	ld a, $1e ; $77c8
	farcall FarPtr_WaitScriptFrames ; $77ca
	pop af ; $77cd
	ld a, $00 ; $77ce
	ld b, a ; $77d0
	ld a, $03 ; $77d1
	farcall FarPtr_FaceActorTowardActor ; $77d3
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
	ld a, $03 ; $77f1
	farcall FarPtr_ScriptShowSpeakerDialogue ; $77f3
	call DrawRankingOpponentInfo ; $77f6
	ld a, $00 ; $77f9
	ld b, $c0 ; $77fb
	farcall FarPtr_SetActorFacing ; $77fd
	push af ; $7800
	ld a, $0f ; $7801
	farcall FarPtr_WaitScriptFrames ; $7803
	pop af ; $7806
	ld a, $03 ; $7807
	ld d, $02 ; $7809
	farcall FarPtr_ScriptSetActorAnimation ; $780b
	ld a, $03 ; $780e
	farcall FarPtr_ScriptWaitActorIdle ; $7810
	call PromptChallengeRankingOpponent ; $7813
	ret ; $7816
Label_11_7817:
	ld a, $03 ; $7817
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7819
	ret ; $781c
StartNextRankingMatch:
	ld a, $00 ; $781d
	ld bc, $0020 ; $781f
	farcall FarPtr_ScriptSetActorMoveSpeed ; $7822
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
	ld a, $03 ; $7843
	ld b, $00 ; $7845
	farcall FarPtr_SetActorFacing ; $7847
	push af ; $784a
	ld a, $0f ; $784b
	farcall FarPtr_WaitScriptFrames ; $784d
	pop af ; $7850
	ld a, $00 ; $7851
	ld b, $00 ; $7853
	farcall FarPtr_SetActorFacing ; $7855
	ld a, $07 ; $7858
	ld b, $00 ; $785a
	farcall FarPtr_SetActorFacing ; $785c
	push af ; $785f
	ld a, $1e ; $7860
	farcall FarPtr_WaitScriptFrames ; $7862
	pop af ; $7865
	ldh a, [hRomBank] ; $7866
	ld b, a ; $7868
	ld a, $0e ; $7869
	ld de, $6dbc ; $786b
	farcall FarPtr_ScriptSetActorScript ; $786e
	ldh a, [hRomBank] ; $7871
	ld b, a ; $7873
	ld a, $0f ; $7874
	ld de, $6dcb ; $7876
	farcall FarPtr_ScriptSetActorScript ; $7879
	ld a, $0f ; $787c
	farcall FarPtr_WaitActorScriptDone ; $787e
	xor a, a ; $7881
	ld bc, $1b00 ; $7882
	ld de, $1100 ; $7885
	farcall FarPtr_MovePlayerToPosition ; $7888
	ldh a, [hRomBank] ; $788b
	ld b, a ; $788d
	ld a, $07 ; $788e
	ld de, $765a ; $7890
	farcall FarPtr_ScriptSetActorScript ; $7893
	ldh a, [hRomBank] ; $7896
	ld b, a ; $7898
	ld a, $00 ; $7899
	ld de, $7762 ; $789b
	farcall FarPtr_ScriptSetActorScript ; $789e
	farcall FarPtr_WaitPlayerMoveDone ; $78a1
	ld a, $07 ; $78a4
	farcall FarPtr_WaitActorScriptDone ; $78a6
	push af ; $78a9
	ld a, $14 ; $78aa
	farcall FarPtr_WaitScriptFrames ; $78ac
	pop af ; $78af
	ld a, $0f ; $78b0
	ld [$c294], a ; $78b2
	ld [wStoryModeExitLocationRequest], a ; $78b5
	farcall FarPtr_InitStoryMatchSettings ; $78b8
	ld a, $00 ; $78bb
	ld [wCurrentMinigameStoryMatch], a ; $78bd
	ld a, $01 ; $78c0
	ld [$c8f7], a ; $78c2
	farcall FarPtr_LoadMatchSettingsFromTable ; $78c5
	farcall FarPtr_RunStoryMatch ; $78c8
	farcall FarPtr_RestoreOverworldAfterMatch ; $78cb
	ret ; $78ce
Label_11_78cf:
	ld a, $03 ; $78cf
	ld b, $80 ; $78d1
	farcall FarPtr_SetActorFacing ; $78d3
	push af ; $78d6
	ld a, $0f ; $78d7
	farcall FarPtr_WaitScriptFrames ; $78d9
	pop af ; $78dc
	ld a, $00 ; $78dd
	ld b, $80 ; $78df
	farcall FarPtr_SetActorFacing ; $78e1
	ld a, $06 ; $78e4
	ld b, $80 ; $78e6
	farcall FarPtr_SetActorFacing ; $78e8
	push af ; $78eb
	ld a, $1e ; $78ec
	farcall FarPtr_WaitScriptFrames ; $78ee
	pop af ; $78f1
	ldh a, [hRomBank] ; $78f2
	ld b, a ; $78f4
	ld a, $0c ; $78f5
	ld de, $6dda ; $78f7
	farcall FarPtr_ScriptSetActorScript ; $78fa
	ldh a, [hRomBank] ; $78fd
	ld b, a ; $78ff
	ld a, $0d ; $7900
	ld de, $6de9 ; $7902
	farcall FarPtr_ScriptSetActorScript ; $7905
	push af ; $7908
	ld a, $78 ; $7909
	farcall FarPtr_WaitScriptFrames ; $790b
	pop af ; $790e
	xor a, a ; $790f
	ld bc, $0b00 ; $7910
	ld de, $1100 ; $7913
	farcall FarPtr_MovePlayerToPosition ; $7916
	ldh a, [hRomBank] ; $7919
	ld b, a ; $791b
	ld a, $06 ; $791c
	ld de, $76bc ; $791e
	farcall FarPtr_ScriptSetActorScript ; $7921
	ldh a, [hRomBank] ; $7924
	ld b, a ; $7926
	ld a, $00 ; $7927
	ld de, $7773 ; $7929
	farcall FarPtr_ScriptSetActorScript ; $792c
	farcall FarPtr_WaitPlayerMoveDone ; $792f
	ld a, $06 ; $7932
	farcall FarPtr_WaitActorScriptDone ; $7934
	push af ; $7937
	ld a, $28 ; $7938
	farcall FarPtr_WaitScriptFrames ; $793a
	pop af ; $793d
	ld a, $0f ; $793e
	ld [$c294], a ; $7940
	ld [wStoryModeExitLocationRequest], a ; $7943
	farcall FarPtr_InitStoryMatchSettings ; $7946
	ld a, $00 ; $7949
	ld [wCurrentMinigameStoryMatch], a ; $794b
	ld a, $02 ; $794e
	ld [$c8f7], a ; $7950
	farcall FarPtr_LoadMatchSettingsFromTable ; $7953
	farcall FarPtr_RunStoryMatch ; $7956
	farcall FarPtr_RestoreOverworldAfterMatch ; $7959
	ret ; $795c
Label_11_795d:
	ld a, $03 ; $795d
	ld b, $80 ; $795f
	farcall FarPtr_SetActorFacing ; $7961
	push af ; $7964
	ld a, $0f ; $7965
	farcall FarPtr_WaitScriptFrames ; $7967
	pop af ; $796a
	ld a, $00 ; $796b
	ld b, $80 ; $796d
	farcall FarPtr_SetActorFacing ; $796f
	ld a, $05 ; $7972
	ld b, $80 ; $7974
	farcall FarPtr_SetActorFacing ; $7976
	push af ; $7979
	ld a, $1e ; $797a
	farcall FarPtr_WaitScriptFrames ; $797c
	pop af ; $797f
	ldh a, [hRomBank] ; $7980
	ld b, a ; $7982
	ld a, $0c ; $7983
	ld de, $6dda ; $7985
	farcall FarPtr_ScriptSetActorScript ; $7988
	ldh a, [hRomBank] ; $798b
	ld b, a ; $798d
	ld a, $0d ; $798e
	ld de, $6de9 ; $7990
	farcall FarPtr_ScriptSetActorScript ; $7993
	push af ; $7996
	ld a, $78 ; $7997
	farcall FarPtr_WaitScriptFrames ; $7999
	pop af ; $799c
	xor a, a ; $799d
	ld bc, $0b00 ; $799e
	ld de, $1100 ; $79a1
	farcall FarPtr_MovePlayerToPosition ; $79a4
	ldh a, [hRomBank] ; $79a7
	ld b, a ; $79a9
	ld a, $05 ; $79aa
	ld de, $76bc ; $79ac
	farcall FarPtr_ScriptSetActorScript ; $79af
	ldh a, [hRomBank] ; $79b2
	ld b, a ; $79b4
	ld a, $00 ; $79b5
	ld de, $7773 ; $79b7
	farcall FarPtr_ScriptSetActorScript ; $79ba
	ld a, $05 ; $79bd
	farcall FarPtr_WaitActorScriptDone ; $79bf
	push af ; $79c2
	ld a, $28 ; $79c3
	farcall FarPtr_WaitScriptFrames ; $79c5
	pop af ; $79c8
	ld a, $0f ; $79c9
	ld [$c294], a ; $79cb
	ld [wStoryModeExitLocationRequest], a ; $79ce
	farcall FarPtr_InitStoryMatchSettings ; $79d1
	ld a, $00 ; $79d4
	ld [wCurrentMinigameStoryMatch], a ; $79d6
	ld a, $03 ; $79d9
	ld [$c8f7], a ; $79db
	farcall FarPtr_LoadMatchSettingsFromTable ; $79de
	farcall FarPtr_RunStoryMatch ; $79e1
	farcall FarPtr_RestoreOverworldAfterMatch ; $79e4
	ret ; $79e7
Label_11_79e8:
	ld a, $03 ; $79e8
	ld b, $00 ; $79ea
	farcall FarPtr_SetActorFacing ; $79ec
	push af ; $79ef
	ld a, $0f ; $79f0
	farcall FarPtr_WaitScriptFrames ; $79f2
	pop af ; $79f5
	ld a, $00 ; $79f6
	ld b, $00 ; $79f8
	farcall FarPtr_SetActorFacing ; $79fa
	ld a, $04 ; $79fd
	ld b, $00 ; $79ff
	farcall FarPtr_SetActorFacing ; $7a01
	push af ; $7a04
	ld a, $1e ; $7a05
	farcall FarPtr_WaitScriptFrames ; $7a07
	pop af ; $7a0a
	ldh a, [hRomBank] ; $7a0b
	ld b, a ; $7a0d
	ld a, $0e ; $7a0e
	ld de, $6dbc ; $7a10
	farcall FarPtr_ScriptSetActorScript ; $7a13
	ldh a, [hRomBank] ; $7a16
	ld b, a ; $7a18
	ld a, $0f ; $7a19
	ld de, $6dcb ; $7a1b
	farcall FarPtr_ScriptSetActorScript ; $7a1e
	push af ; $7a21
	ld a, $78 ; $7a22
	farcall FarPtr_WaitScriptFrames ; $7a24
	pop af ; $7a27
	xor a, a ; $7a28
	ld bc, $1700 ; $7a29
	ld de, $1300 ; $7a2c
	farcall FarPtr_MovePlayerToPosition ; $7a2f
	ldh a, [hRomBank] ; $7a32
	ld b, a ; $7a34
	ld a, $04 ; $7a35
	ld de, $765a ; $7a37
	farcall FarPtr_ScriptSetActorScript ; $7a3a
	ldh a, [hRomBank] ; $7a3d
	ld b, a ; $7a3f
	ld a, $00 ; $7a40
	ld de, $7762 ; $7a42
	farcall FarPtr_ScriptSetActorScript ; $7a45
	farcall FarPtr_WaitPlayerMoveDone ; $7a48
	ld a, $04 ; $7a4b
	farcall FarPtr_WaitActorScriptDone ; $7a4d
	push af ; $7a50
	ld a, $28 ; $7a51
	farcall FarPtr_WaitScriptFrames ; $7a53
	pop af ; $7a56
	ld a, $0f ; $7a57
	ld [$c294], a ; $7a59
	ld [wStoryModeExitLocationRequest], a ; $7a5c
	farcall FarPtr_InitStoryMatchSettings ; $7a5f
	ld a, $00 ; $7a62
	ld [wCurrentMinigameStoryMatch], a ; $7a64
	ld a, $04 ; $7a67
	ld [$c8f7], a ; $7a69
	farcall FarPtr_LoadMatchSettingsFromTable ; $7a6c
	farcall FarPtr_RunStoryMatch ; $7a6f
	farcall FarPtr_RestoreOverworldAfterMatch ; $7a72
	ret ; $7a75
Func_11_7a76:
	ld a, $0e ; $7a76
	farcall FarPtr_SetActorNullScript ; $7a78
	ld a, $0f ; $7a7b
	farcall FarPtr_SetActorNullScript ; $7a7d
	ld a, $0e ; $7a80
	ld d, $01 ; $7a82
	farcall FarPtr_ScriptSetActorAnimation ; $7a84
	ld a, $0f ; $7a87
	ld d, $01 ; $7a89
	farcall FarPtr_ScriptSetActorAnimation ; $7a8b
	ld a, $0e ; $7a8e
	ld bc, $1f00 ; $7a90
	ld de, $0b00 ; $7a93
	farcall FarPtr_ScriptSetActorPosition ; $7a96
	ld a, $0f ; $7a99
	ld bc, $1f00 ; $7a9b
	ld de, $1300 ; $7a9e
	farcall FarPtr_ScriptSetActorPosition ; $7aa1
	ld a, $0e ; $7aa4
	ld b, $80 ; $7aa6
	farcall FarPtr_SetActorFacing ; $7aa8
	ld a, $0f ; $7aab
	ld b, $80 ; $7aad
	farcall FarPtr_SetActorFacing ; $7aaf
	ret ; $7ab2
Func_11_7ab3:
	ld a, $0c ; $7ab3
	farcall FarPtr_SetActorNullScript ; $7ab5
	ld a, $0d ; $7ab8
	farcall FarPtr_SetActorNullScript ; $7aba
	ld a, $0c ; $7abd
	ld d, $01 ; $7abf
	farcall FarPtr_ScriptSetActorAnimation ; $7ac1
	ld a, $0d ; $7ac4
	ld d, $01 ; $7ac6
	farcall FarPtr_ScriptSetActorAnimation ; $7ac8
	ld a, $0c ; $7acb
	ld bc, $0f00 ; $7acd
	ld de, $0b00 ; $7ad0
	farcall FarPtr_ScriptSetActorPosition ; $7ad3
	ld a, $0d ; $7ad6
	ld bc, $0f00 ; $7ad8
	ld de, $1300 ; $7adb
	farcall FarPtr_ScriptSetActorPosition ; $7ade
	ld a, $0c ; $7ae1
	ld b, $80 ; $7ae3
	farcall FarPtr_SetActorFacing ; $7ae5
	ld a, $0d ; $7ae8
	ld b, $80 ; $7aea
	farcall FarPtr_SetActorFacing ; $7aec
	push af ; $7aef
	ld a, $14 ; $7af0
	farcall FarPtr_WaitScriptFrames ; $7af2
	pop af ; $7af5
	ret ; $7af6
Func_11_7af7:
	ld a, $0c ; $7af7
	farcall FarPtr_SetActorNullScript ; $7af9
	ld a, $0d ; $7afc
	farcall FarPtr_SetActorNullScript ; $7afe
	ld a, $0c ; $7b01
	ld bc, $0500 ; $7b03
	ld de, $0b00 ; $7b06
	farcall FarPtr_ScriptSetActorPosition ; $7b09
	ld a, $0d ; $7b0c
	ld bc, $0500 ; $7b0e
	ld de, $1300 ; $7b11
	farcall FarPtr_ScriptSetActorPosition ; $7b14
	ld a, $0c ; $7b17
	ld b, $00 ; $7b19
	farcall FarPtr_SetActorFacing ; $7b1b
	ld a, $0d ; $7b1e
	ld b, $00 ; $7b20
	farcall FarPtr_SetActorFacing ; $7b22
	push af ; $7b25
	ld a, $14 ; $7b26
	farcall FarPtr_WaitScriptFrames ; $7b28
	pop af ; $7b2b
	ret ; $7b2c
Func_11_7b2d:
	ld a, $0e ; $7b2d
	ld bc, $1800 ; $7b2f
	ld de, $0b00 ; $7b32
	farcall FarPtr_ScriptSetActorMoveTarget ; $7b35
	ld a, $0f ; $7b38
	ld bc, $1c00 ; $7b3a
	ld de, $1700 ; $7b3d
	farcall FarPtr_ScriptSetActorMoveTarget ; $7b40
	ld a, $0f ; $7b43
	farcall FarPtr_ScriptWaitActorMoveDone ; $7b45
	ld a, $0f ; $7b48
	ld b, $c0 ; $7b4a
	farcall FarPtr_SetActorFacing ; $7b4c
	ld a, $0e ; $7b4f
	farcall FarPtr_ScriptWaitActorMoveDone ; $7b51
	ldh a, [hRomBank] ; $7b54
	ld b, a ; $7b56
	ld a, $0e ; $7b57
	ld de, $7bdf ; $7b59
	farcall FarPtr_ScriptSetActorScript ; $7b5c
	ldh a, [hRomBank] ; $7b5f
	ld b, a ; $7b61
	ld a, $0f ; $7b62
	ld de, $7c42 ; $7b64
	farcall FarPtr_ScriptSetActorScript ; $7b67
	ret ; $7b6a
Func_11_7b6b:
	ld a, $0c ; $7b6b
	ld bc, $0800 ; $7b6d
	ld de, $0b00 ; $7b70
	farcall FarPtr_ScriptSetActorMoveTarget ; $7b73
	ld a, $0d ; $7b76
	ld bc, $0c00 ; $7b78
	ld de, $1700 ; $7b7b
	farcall FarPtr_ScriptSetActorMoveTarget ; $7b7e
	ld a, $0d ; $7b81
	farcall FarPtr_ScriptWaitActorMoveDone ; $7b83
	ld a, $0d ; $7b86
	ld b, $c0 ; $7b88
	farcall FarPtr_SetActorFacing ; $7b8a
	ld a, $0c ; $7b8d
	farcall FarPtr_ScriptWaitActorMoveDone ; $7b8f
	ldh a, [hRomBank] ; $7b92
	ld b, a ; $7b94
	ld a, $0c ; $7b95
	ld de, $7ca9 ; $7b97
	farcall FarPtr_ScriptSetActorScript ; $7b9a
	ldh a, [hRomBank] ; $7b9d
	ld b, a ; $7b9f
	ld a, $0d ; $7ba0
	ld de, $7d10 ; $7ba2
	farcall FarPtr_ScriptSetActorScript ; $7ba5
	ret ; $7ba8
	INCBIN "data/bank_011/d_7ba9.bin" ; $7ba9, 40 bytes
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

SECTION "ROM Bank $15", ROMX[$4000], BANK[$15]

DataPtr_15_00:
	dw Data_15_4004 ; $4000
DataPtr_15_02:
	dw Data_15_4796 ; $4002
Data_15_4004:
	; $4004, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $40b6 ; record 0
	dw $40df ; record 1
	dw $4012 ; record 2
	dw $4159 ; record 3
	dw $4192 ; record 4
	dw $419c ; record 5
	dw $41a6 ; record 6
	; $4012, 164 bytes (bytes:14)
	db $00, $00, $ba, $41, $00, $09, $80, $1d, $40, $00, $21, $01, $00, $00 ; 0x00
	db $00, $00, $6d, $7d, $00, $07, $80, $1d, $40, $00, $22, $01, $00, $00 ; 0x0e
	db $00, $00, $77, $7d, $00, $0d, $00, $1b, $80, $00, $33, $01, $03, $00 ; 0x1c
	db $00, $00, $77, $7d, $00, $1d, $00, $23, $c0, $00, $34, $01, $07, $00 ; 0x2a
	db $00, $00, $6d, $7d, $00, $1f, $00, $1d, $80, $00, $30, $01, $05, $00 ; 0x38
	db $00, $00, $6d, $7d, $00, $0b, $00, $27, $80, $00, $39, $01, $00, $00 ; 0x46
	db $00, $00, $6d, $7d, $00, $09, $00, $29, $c0, $00, $3a, $01, $00, $00 ; 0x54
	db $00, $00, $6d, $7d, $40, $1b, $40, $26, $80, $00, $36, $01, $00, $00 ; 0x62
	db $00, $00, $6d, $7d, $c0, $1c, $40, $26, $80, $00, $36, $01, $00, $00 ; 0x70
	db $00, $00, $6d, $7d, $40, $07, $40, $26, $80, $00, $36, $01, $00, $00 ; 0x7e
	db $00, $00, $6d, $7d, $c0, $08, $40, $26, $80, $00, $36, $01, $00, $00 ; 0x8c
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x9a
	; $40b6, 41 bytes (bytes:16)
	db $01, $80, $00, $21, $00, $14, $00, $00, $02, $00, $00, $03, $00, $14, $00, $00 ; 0x00
	db $03, $40, $00, $12, $00, $0d, $00, $00, $04, $c0, $00, $12, $00, $29, $00, $00 ; 0x10
	db $0f, $c0, $00, $11, $00, $39, $00, $00, $ff ; 0x20
	; $40df, 33 bytes (records:8)
; 4 records x 8 bytes
	dw $ff01, $0000, $7d95, $0216 ; record 0
	dw $ff02, $0000, $7d95, $0217 ; record 1
	dw $ff03, $0000, $7d95, $0519 ; record 2
	dw $ff04, $0000, $7d95, $021b ; record 3
	db $ff
	ld a, [$c2b0] ; $4100
	add a, a ; $4103
	add a, $4b ; $4104
	ld l, a ; $4106
	adc a, $41 ; $4107
	sub a, l ; $4109
	ld h, a ; $410a
	ld a, [hl+] ; $410b
	ld h, [hl] ; $410c
	ld l, a ; $410d
	farcall FarPtr_0a_0e ; $410e
	test_flag $05, 7 ; $4111
	jr z, Label_15_4120 ; $4114
	test_flag $0e, 7 ; $4116
	jr nz, Label_15_413f ; $4119
	set_flag $0e, 7 ; $411b
	jr Label_15_4128 ; $411e
Label_15_4120:
	test_flag $0e, 6 ; $4120
	jr nz, Label_15_413f ; $4123
	set_flag $0e, 6 ; $4125
Label_15_4128:
	ld a, $05 ; $4128
	farcall FarPtr_ScriptShowSpeakerDialogue ; $412a
	ld a, $05 ; $412d
	ld d, $02 ; $412f
	farcall FarPtr_ScriptSetActorAnimation ; $4131
	ld a, $05 ; $4134
	farcall FarPtr_ScriptWaitActorIdle ; $4136
	ld a, $05 ; $4139
	farcall FarPtr_ScriptShowSpeakerDialogue ; $413b
	ret ; $413e
Label_15_413f:
	ld hl, $2420 ; $413f
	farcall FarPtr_0a_0e ; $4142
	ld a, $05 ; $4145
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4147
	ret ; $414a
	; $414b, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $241e ; record 0
	dw $2427 ; record 1
	dw $2427 ; record 2
	dw $2427 ; record 3
	dw $243a ; record 4
	dw $2442 ; record 5
	dw $244a ; record 6
	; $4159, 57 bytes (records:8)
; 7 records x 8 bytes
	dw $ff03, $0000, $241c, $0013 ; record 0
	dw $ff04, $0000, $241d, $0003 ; record 1
	dw $ff05, $0000, $4100, $0013 ; record 2
	dw $ff06, $0000, $2421, $0013 ; record 3
	dw $ff07, $0000, $2422, $0003 ; record 4
	dw $ff08, $0000, $2423, $0003 ; record 5
	dw $ff09, $0000, $2424, $0003 ; record 6
	db $ff
	; $4192, 10 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $419b, $0000 ; record 0
	db $ff, $c9
	; $419c, 10 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $41a5, $0000 ; record 0
	db $ff, $c9
	ld a, [$c295] ; $41a6
	cp a, $0f ; $41a9
	jr nz, Label_15_41b0 ; $41ab
	jp Label_15_444d ; $41ad
Label_15_41b0:
	call Func_15_475f ; $41b0
	call Func_15_4271 ; $41b3
	call Func_15_46f0 ; $41b6
	ret ; $41b9
	INCBIN "data/bank_015/d_41ba.bin" ; $41ba, 18 bytes
	; $41cc, 112 bytes (bytes:14)
	db $ff, $00, $00, $6d, $7d, $00, $12, $00, $34, $40, $00, $63, $01, $00 ; 0x00
	db $00, $00, $00, $6d, $7d, $00, $11, $00, $37, $40, $00, $5a, $01, $00 ; 0x0e
	db $00, $00, $00, $6d, $7d, $00, $13, $00, $39, $40, $00, $5b, $01, $00 ; 0x1c
	db $00, $00, $00, $6d, $7d, $00, $13, $00, $37, $40, $00, $5c, $01, $00 ; 0x2a
	db $00, $00, $00, $ba, $41, $00, $09, $80, $1d, $40, $00, $21, $01, $00 ; 0x38
	db $00, $00, $00, $6d, $7d, $00, $07, $80, $1d, $40, $00, $22, $01, $00 ; 0x46
	db $00, $00, $00, $77, $7d, $00, $0d, $00, $1b, $80, $00, $33, $01, $03 ; 0x54
	db $00, $00, $00, $77, $7d, $00, $1d, $00, $23, $c0, $00, $34, $01, $07 ; 0x62
	; $423c, 53 bytes (bytes:14)
	db $00, $00, $00, $6d, $7d, $00, $1f, $00, $1d, $80, $00, $30, $01, $05 ; 0x00
	db $00, $00, $00, $6d, $7d, $00, $0b, $00, $27, $80, $00, $39, $01, $00 ; 0x0e
	db $00, $00, $00, $6d, $7d, $00, $09, $00, $29, $c0, $00, $3a, $01, $00 ; 0x1c
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x2a
Func_15_4271:
	ld a, $00 ; $4271
	ld [$c2b0], a ; $4273
	test_flag $05, 7 ; $4276
	jr nz, Label_15_42c0 ; $4279
	ld a, $f1 ; $427b
	ld d, $0e ; $427d
	ld e, $14 ; $427f
	farcall FarPtr_0a_8a ; $4281
	test_flag $07, 5 ; $4284
	jr z, Label_15_4298 ; $4287
	ld hl, $4369 ; $4289
	ld de, $000c ; $428c
	farcall FarPtr_0a_60 ; $428f
	ld a, $03 ; $4292
	ld [$c2b0], a ; $4294
	ret ; $4297
Label_15_4298:
	test_flag $07, 6 ; $4298
	jr z, Label_15_42ac ; $429b
	ld hl, $4330 ; $429d
	ld de, $000c ; $42a0
	farcall FarPtr_0a_60 ; $42a3
	ld a, $02 ; $42a6
	ld [$c2b0], a ; $42a8
	ret ; $42ab
Label_15_42ac:
	test_flag $07, 7 ; $42ac
	jr z, Label_15_42bf ; $42af
	ld hl, $42f7 ; $42b1
	ld de, $000c ; $42b4
	farcall FarPtr_0a_60 ; $42b7
	ld a, $01 ; $42ba
	ld [$c2b0], a ; $42bc
Label_15_42bf:
	ret ; $42bf
Label_15_42c0:
	test_flag $06, 6 ; $42c0
	jr z, Label_15_42d4 ; $42c3
	ld hl, $4414 ; $42c5
	ld de, $000c ; $42c8
	farcall FarPtr_0a_60 ; $42cb
	ld a, $06 ; $42ce
	ld [$c2b0], a ; $42d0
	ret ; $42d3
Label_15_42d4:
	test_flag $06, 7 ; $42d4
	jr z, Label_15_42e8 ; $42d7
	ld hl, $43db ; $42d9
	ld de, $000c ; $42dc
	farcall FarPtr_0a_60 ; $42df
	ld a, $05 ; $42e2
	ld [$c2b0], a ; $42e4
	ret ; $42e7
Label_15_42e8:
	ld hl, $43a2 ; $42e8
	ld de, $000c ; $42eb
	farcall FarPtr_0a_60 ; $42ee
	ld a, $04 ; $42f1
	ld [$c2b0], a ; $42f3
	ret ; $42f6
	; $42f7, 57 bytes (records:8)
; 7 records x 8 bytes
	dw $ff03, $0000, $2425, $0013 ; record 0
	dw $ff04, $0000, $2426, $0003 ; record 1
	dw $ff05, $0000, $4100, $0013 ; record 2
	dw $ff06, $0000, $2429, $0013 ; record 3
	dw $ff07, $0000, $242a, $0003 ; record 4
	dw $ff08, $0000, $242b, $0003 ; record 5
	dw $ff09, $0000, $242c, $0003 ; record 6
	db $ff
	; $4330, 57 bytes (records:8)
; 7 records x 8 bytes
	dw $ff03, $0000, $242d, $0013 ; record 0
	dw $ff04, $0000, $242e, $0003 ; record 1
	dw $ff05, $0000, $4100, $0013 ; record 2
	dw $ff06, $0000, $242f, $0013 ; record 3
	dw $ff07, $0000, $2430, $0003 ; record 4
	dw $ff08, $0000, $2431, $0003 ; record 5
	dw $ff09, $0000, $2432, $0003 ; record 6
	db $ff
	; $4369, 57 bytes (records:8)
; 7 records x 8 bytes
	dw $ff03, $0000, $2433, $0013 ; record 0
	dw $ff04, $0000, $2434, $0003 ; record 1
	dw $ff05, $0000, $4100, $0013 ; record 2
	dw $ff06, $0000, $2435, $0013 ; record 3
	dw $ff07, $0000, $2436, $0003 ; record 4
	dw $ff08, $0000, $2437, $0003 ; record 5
	dw $ff09, $0000, $2438, $0003 ; record 6
	db $ff
	; $43a2, 57 bytes (records:8)
; 7 records x 8 bytes
	dw $ff03, $0000, $241c, $0013 ; record 0
	dw $ff04, $0000, $2439, $0003 ; record 1
	dw $ff05, $0000, $4100, $0013 ; record 2
	dw $ff06, $0000, $243c, $0013 ; record 3
	dw $ff07, $0000, $243d, $0003 ; record 4
	dw $ff08, $0000, $243e, $0003 ; record 5
	dw $ff09, $0000, $243f, $0003 ; record 6
	db $ff
	; $43db, 57 bytes (records:8)
; 7 records x 8 bytes
	dw $ff03, $0000, $2440, $0013 ; record 0
	dw $ff04, $0000, $2441, $0003 ; record 1
	dw $ff05, $0000, $4100, $0013 ; record 2
	dw $ff06, $0000, $2444, $0013 ; record 3
	dw $ff07, $0000, $2445, $0003 ; record 4
	dw $ff08, $0000, $2446, $0003 ; record 5
	dw $ff09, $0000, $2447, $0003 ; record 6
	db $ff
	; $4414, 57 bytes (records:8)
; 7 records x 8 bytes
	dw $ff03, $0000, $2448, $0013 ; record 0
	dw $ff04, $0000, $2449, $0003 ; record 1
	dw $ff05, $0000, $4100, $0013 ; record 2
	dw $ff06, $0000, $244c, $0013 ; record 3
	dw $ff07, $0000, $244d, $0003 ; record 4
	dw $ff08, $0000, $244e, $0003 ; record 5
	dw $ff09, $0000, $244f, $0003 ; record 6
	db $ff
Label_15_444d:
	ldh a, [hRomBank] ; $444d
	ld hl, $41cd ; $444f
	farcall FarPtr_0a_06 ; $4452
	farcall FarPtr_0a_00 ; $4455
	call Func_15_46b7 ; $4458
	ld bc, $00ff ; $445b
	farcall FarPtr_0a_38 ; $445e
	xor a, a ; $4461
	ld bc, $1200 ; $4462
	ld de, $2900 ; $4465
	farcall FarPtr_MovePlayerToPosition ; $4468
	farcall FarPtr_WaitPlayerMoveDone ; $446b
	ld c, $04 ; $446e
	call BeginFadeIn ; $4470
	call WaitFadeEnd ; $4473
	ld a, $03 ; $4476
	ld bc, $1200 ; $4478
	ld de, $2900 ; $447b
	farcall FarPtr_ScriptSetActorMoveTarget ; $447e
	ld a, $04 ; $4481
	ld bc, $1100 ; $4483
	ld de, $2c00 ; $4486
	farcall FarPtr_ScriptSetActorMoveTarget ; $4489
	ld a, $05 ; $448c
	ld bc, $1300 ; $448e
	ld de, $2e00 ; $4491
	farcall FarPtr_ScriptSetActorMoveTarget ; $4494
	ld a, $06 ; $4497
	ld bc, $1300 ; $4499
	ld de, $2c00 ; $449c
	farcall FarPtr_ScriptSetActorMoveTarget ; $449f
	ld a, $00 ; $44a2
	ld bc, $1100 ; $44a4
	ld de, $2e00 ; $44a7
	farcall FarPtr_ScriptSetActorMoveTarget ; $44aa
	ld a, $00 ; $44ad
	farcall FarPtr_ScriptWaitActorMoveDone ; $44af
	ld bc, $0020 ; $44b2
	farcall FarPtr_0a_38 ; $44b5
	xor a, a ; $44b8
	ld bc, $1200 ; $44b9
	ld de, $1000 ; $44bc
	farcall FarPtr_MovePlayerToPosition ; $44bf
	ld a, $03 ; $44c2
	ld bc, $1200 ; $44c4
	ld de, $1000 ; $44c7
	farcall FarPtr_ScriptSetActorMoveTarget ; $44ca
	ld a, $04 ; $44cd
	ld bc, $1100 ; $44cf
	ld de, $1300 ; $44d2
	farcall FarPtr_ScriptSetActorMoveTarget ; $44d5
	ld a, $05 ; $44d8
	ld bc, $1300 ; $44da
	ld de, $1500 ; $44dd
	farcall FarPtr_ScriptSetActorMoveTarget ; $44e0
	ld a, $06 ; $44e3
	ld bc, $1300 ; $44e5
	ld de, $1300 ; $44e8
	farcall FarPtr_ScriptSetActorMoveTarget ; $44eb
	ld a, $00 ; $44ee
	ld bc, $1100 ; $44f0
	ld de, $1500 ; $44f3
	farcall FarPtr_ScriptSetActorMoveTarget ; $44f6
	ld a, $00 ; $44f9
	farcall FarPtr_ScriptWaitActorMoveDone ; $44fb
	push af ; $44fe
	ld a, $28 ; $44ff
	farcall FarPtr_WaitScriptFrames ; $4501
	pop af ; $4504
	ld a, $03 ; $4505
	ld b, $40 ; $4507
	farcall FarPtr_SetActorFacing ; $4509
	ld hl, $240d ; $450c
	farcall FarPtr_0a_0e ; $450f
	ld a, $03 ; $4512
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4514
	ld a, $04 ; $4517
	ld d, $03 ; $4519
	farcall FarPtr_ScriptSetActorAnimation ; $451b
	ld a, $05 ; $451e
	ld d, $03 ; $4520
	farcall FarPtr_ScriptSetActorAnimation ; $4522
	ld a, $06 ; $4525
	ld d, $03 ; $4527
	farcall FarPtr_ScriptSetActorAnimation ; $4529
	ld a, $00 ; $452c
	ld d, $03 ; $452e
	farcall FarPtr_ScriptSetActorAnimation ; $4530
	ld a, $00 ; $4533
	farcall FarPtr_ScriptWaitActorIdle ; $4535
	ld a, $03 ; $4538
	ld d, $04 ; $453a
	farcall FarPtr_ScriptSetActorAnimation ; $453c
	ld a, $03 ; $453f
	farcall FarPtr_ScriptWaitActorIdle ; $4541
	ld a, $03 ; $4544
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4546
	ld a, $06 ; $4549
	ld d, $03 ; $454b
	farcall FarPtr_ScriptSetActorAnimation ; $454d
	ld a, $06 ; $4550
	farcall FarPtr_ScriptWaitActorIdle ; $4552
	ld a, $06 ; $4555
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4557
	ld a, $05 ; $455a
	ld d, $03 ; $455c
	farcall FarPtr_ScriptSetActorAnimation ; $455e
	ld a, $05 ; $4561
	farcall FarPtr_ScriptWaitActorIdle ; $4563
	ld a, $05 ; $4566
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4568
	ld a, $03 ; $456b
	ld d, $02 ; $456d
	farcall FarPtr_ScriptSetActorAnimation ; $456f
	ld a, $03 ; $4572
	farcall FarPtr_ScriptWaitActorIdle ; $4574
	ld a, $03 ; $4577
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4579
	ld a, $04 ; $457c
	ld d, $03 ; $457e
	farcall FarPtr_ScriptSetActorAnimation ; $4580
	ld a, $04 ; $4583
	farcall FarPtr_ScriptWaitActorIdle ; $4585
	ld a, $04 ; $4588
	farcall FarPtr_ScriptShowSpeakerDialogue ; $458a
	ld a, $03 ; $458d
	ld d, $03 ; $458f
	farcall FarPtr_ScriptSetActorAnimation ; $4591
	ld a, $03 ; $4594
	farcall FarPtr_ScriptWaitActorIdle ; $4596
	ld a, $03 ; $4599
	farcall FarPtr_ScriptShowSpeakerDialogue ; $459b
	ld a, $04 ; $459e
	ld d, $03 ; $45a0
	farcall FarPtr_ScriptSetActorAnimation ; $45a2
	ld a, $05 ; $45a5
	ld d, $03 ; $45a7
	farcall FarPtr_ScriptSetActorAnimation ; $45a9
	ld a, $06 ; $45ac
	ld d, $03 ; $45ae
	farcall FarPtr_ScriptSetActorAnimation ; $45b0
	ld a, $06 ; $45b3
	farcall FarPtr_ScriptWaitActorIdle ; $45b5
	ld a, $03 ; $45b8
	ld d, $03 ; $45ba
	farcall FarPtr_ScriptSetActorAnimation ; $45bc
	ld a, $03 ; $45bf
	farcall FarPtr_ScriptWaitActorIdle ; $45c1
	ld a, $03 ; $45c4
	ld b, $00 ; $45c6
	farcall FarPtr_SetActorFacing ; $45c8
	push af ; $45cb
	ld a, $05 ; $45cc
	farcall FarPtr_WaitScriptFrames ; $45ce
	pop af ; $45d1
	ld a, $03 ; $45d2
	ld b, $c0 ; $45d4
	ld de, $0800 ; $45d6
	farcall FarPtr_MoveActorByAngle ; $45d9
	push af ; $45dc
	ld a, $3c ; $45dd
	farcall FarPtr_WaitScriptFrames ; $45df
	pop af ; $45e2
	ld a, $00 ; $45e3
	ld b, $80 ; $45e5
	farcall FarPtr_SetActorFacing ; $45e7
	push af ; $45ea
	ld a, $28 ; $45eb
	farcall FarPtr_WaitScriptFrames ; $45ed
	pop af ; $45f0
	ld a, $00 ; $45f1
	ld b, $40 ; $45f3
	farcall FarPtr_SetActorFacing ; $45f5
	push af ; $45f8
	ld a, $28 ; $45f9
	farcall FarPtr_WaitScriptFrames ; $45fb
	pop af ; $45fe
	ld a, $00 ; $45ff
	ld b, $80 ; $4601
	farcall FarPtr_SetActorFacing ; $4603
	push af ; $4606
	ld a, $28 ; $4607
	farcall FarPtr_WaitScriptFrames ; $4609
	pop af ; $460c
	ld a, $00 ; $460d
	ld b, $c0 ; $460f
	farcall FarPtr_SetActorFacing ; $4611
	push af ; $4614
	ld a, $28 ; $4615
	farcall FarPtr_WaitScriptFrames ; $4617
	pop af ; $461a
	ld a, $00 ; $461b
	ld b, $00 ; $461d
	farcall FarPtr_SetActorFacing ; $461f
	push af ; $4622
	ld a, $28 ; $4623
	farcall FarPtr_WaitScriptFrames ; $4625
	pop af ; $4628
	ld a, $00 ; $4629
	ld b, $c0 ; $462b
	farcall FarPtr_SetActorFacing ; $462d
	push af ; $4630
	ld a, $28 ; $4631
	farcall FarPtr_WaitScriptFrames ; $4633
	pop af ; $4636
	ld a, $06 ; $4637
	ld bc, $1200 ; $4639
	ld de, $1000 ; $463c
	farcall FarPtr_ScriptSetActorMoveTarget ; $463f
	ld a, $06 ; $4642
	farcall FarPtr_ScriptWaitActorMoveDone ; $4644
	ld a, $06 ; $4647
	ld b, $40 ; $4649
	farcall FarPtr_SetActorFacing ; $464b
	ld a, $06 ; $464e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4650
	ld a, $00 ; $4653
	ld d, $03 ; $4655
	farcall FarPtr_ScriptSetActorAnimation ; $4657
	ld a, $04 ; $465a
	ld d, $03 ; $465c
	farcall FarPtr_ScriptSetActorAnimation ; $465e
	ld a, $05 ; $4661
	ld d, $03 ; $4663
	farcall FarPtr_ScriptSetActorAnimation ; $4665
	ld a, $05 ; $4668
	farcall FarPtr_ScriptWaitActorIdle ; $466a
	ld a, $19 ; $466d
	ld [wStoryModeCurrentLocation], a ; $466f
	ld a, $0f ; $4672
	ld [$c295], a ; $4674
	ld a, $ff ; $4677
	ld [$c294], a ; $4679
	ld [$c2a1], a ; $467c
	ld a, $04 ; $467f
	ld b, $c0 ; $4681
	ld de, $0a00 ; $4683
	farcall FarPtr_MoveActorByAngle ; $4686
	ld a, $05 ; $4689
	ld b, $c0 ; $468b
	ld de, $0a00 ; $468d
	farcall FarPtr_MoveActorByAngle ; $4690
	ld a, $06 ; $4693
	ld b, $c0 ; $4695
	ld de, $0a00 ; $4697
	farcall FarPtr_MoveActorByAngle ; $469a
	ld a, $00 ; $469d
	ld b, $c0 ; $469f
	ld de, $0a00 ; $46a1
	farcall FarPtr_MoveActorByAngle ; $46a4
	push af ; $46a7
	ld a, $1e ; $46a8
	farcall FarPtr_WaitScriptFrames ; $46aa
	pop af ; $46ad
	ld c, $08 ; $46ae
	call BeginFadeOut ; $46b0
	call WaitFadeEnd ; $46b3
	ret ; $46b6
Func_15_46b7:
	call Func_15_475f ; $46b7
	test_flag $05, 7 ; $46ba
	jr z, Label_15_46c9 ; $46bd
	ld a, [$c94d] ; $46bf
	or a, a ; $46c2
	jr nz, Label_15_46ca ; $46c3
	ld d, $58 ; $46c5
	jr Label_15_46ce ; $46c7
Label_15_46c9:
	ret ; $46c9
Label_15_46ca:
	ld d, $59 ; $46ca
	jr Label_15_46ce ; $46cc
Label_15_46ce:
	ld a, $05 ; $46ce
	farcall FarPtr_GetActorStateAddr ; $46d0
	ld c, l ; $46d3
	ld b, h ; $46d4
	farcall FarPtr_04_2c ; $46d5
	ld a, $05 ; $46d8
	ld d, $01 ; $46da
	farcall FarPtr_ScriptSetActorAnimation ; $46dc
	ld a, $02 ; $46df
	farcall FarPtr_0a_1c ; $46e1
	ld a, $02 ; $46e4
	ld bc, $3f00 ; $46e6
	ld de, $3f00 ; $46e9
	farcall FarPtr_ScriptSetActorPosition ; $46ec
	ret ; $46ef
Func_15_46f0:
	ld a, [$c295] ; $46f0
	cp a, $ff ; $46f3
	jp z, Label_15_4756 ; $46f5
	test_flag $05, 7 ; $46f8
	jr z, Label_15_4739 ; $46fb
	ld a, $02 ; $46fd
	ld bc, $00ff ; $46ff
	farcall FarPtr_0a_18 ; $4702
	ld a, [$c295] ; $4705
	dec a ; $4708
	add a, $5b ; $4709
	ld l, a ; $470b
	adc a, $47 ; $470c
	sub a, l ; $470e
	ld h, a ; $470f
	ld b, [hl] ; $4710
	ld a, $02 ; $4711
	ld b, b ; $4713
	ld de, $0200 ; $4714
	farcall FarPtr_MoveActorByAngle ; $4717
	ld a, $02 ; $471a
	farcall FarPtr_ScriptWaitActorMoveDone ; $471c
	ld a, [$c295] ; $471f
	dec a ; $4722
	add a, $57 ; $4723
	ld l, a ; $4725
	adc a, $47 ; $4726
	sub a, l ; $4728
	ld h, a ; $4729
	ld b, [hl] ; $472a
	ld a, $02 ; $472b
	ld b, b ; $472d
	farcall FarPtr_SetActorFacing ; $472e
	ld a, $02 ; $4731
	ld bc, $0010 ; $4733
	farcall FarPtr_0a_18 ; $4736
Label_15_4739:
	ld a, $00 ; $4739
	ld bc, $0010 ; $473b
	farcall FarPtr_0a_18 ; $473e
	ld a, [$c295] ; $4741
	dec a ; $4744
	add a, $57 ; $4745
	ld l, a ; $4747
	adc a, $47 ; $4748
	sub a, l ; $474a
	ld h, a ; $474b
	ld b, [hl] ; $474c
	ld a, $00 ; $474d
	ld b, b ; $474f
	ld de, $0200 ; $4750
	farcall FarPtr_MoveActorByAngle ; $4753
Label_15_4756:
	ret ; $4756
	INCBIN "data/bank_015/d_4757.bin" ; $4757, 8 bytes
Func_15_475f:
	test_flag $05, 7 ; $475f
	jp z, Label_15_477d ; $4762
	ld a, [$c94d] ; $4765
	ld d, $58 ; $4768
	add a, d ; $476a
	ld d, a ; $476b
	ld a, $02 ; $476c
	farcall FarPtr_GetActorStateAddr ; $476e
	ld c, l ; $4771
	ld b, h ; $4772
	farcall FarPtr_04_2c ; $4773
	ld a, $02 ; $4776
	ld d, $01 ; $4778
	farcall FarPtr_ScriptSetActorAnimation ; $477a
Label_15_477d:
	ld a, [$c90d] ; $477d
	ld d, $56 ; $4780
	add a, d ; $4782
	ld d, a ; $4783
	ld a, $00 ; $4784
	farcall FarPtr_GetActorStateAddr ; $4786
	ld c, l ; $4789
	ld b, h ; $478a
	farcall FarPtr_04_2c ; $478b
	ld a, $00 ; $478e
	ld d, $01 ; $4790
	farcall FarPtr_ScriptSetActorAnimation ; $4792
	ret ; $4795
Data_15_4796:
	; $4796, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $48d4 ; record 0
	dw $4956 ; record 1
	dw $47a4 ; record 2
	dw $505b ; record 3
	dw $5300 ; record 4
	dw $530a ; record 5
	dw $532e ; record 6
	; $47a4, 304 bytes (bytes:14)
	db $00, $00, $e9, $55, $00, $0b, $00, $07, $40, $00, $33, $01, $03, $00 ; 0x00
	db $00, $00, $e9, $55, $00, $0b, $00, $17, $c0, $00, $32, $01, $07, $00 ; 0x0e
	db $00, $00, $e9, $55, $00, $0e, $00, $17, $c0, $00, $34, $01, $05, $00 ; 0x1c
	db $00, $00, $6d, $7d, $00, $13, $00, $0b, $80, $00, $68, $01, $00, $00 ; 0x2a
	db $00, $00, $6d, $7d, $00, $13, $00, $15, $80, $00, $67, $01, $06, $00 ; 0x38
	db $00, $00, $e6, $55, $00, $0b, $00, $21, $40, $00, $34, $01, $03, $00 ; 0x46
	db $00, $00, $e6, $55, $00, $0d, $00, $21, $40, $00, $39, $01, $05, $00 ; 0x54
	db $00, $00, $e6, $55, $00, $0c, $00, $2d, $c0, $00, $33, $01, $04, $00 ; 0x62
	db $00, $00, $3d, $7f, $00, $07, $00, $2d, $00, $00, $6a, $01, $07, $00 ; 0x70
	db $00, $00, $6d, $7d, $00, $13, $00, $27, $40, $00, $64, $01, $06, $00 ; 0x7e
	db $00, $00, $6d, $7d, $00, $13, $00, $29, $c0, $00, $68, $01, $04, $00 ; 0x8c
	db $00, $00, $e6, $55, $00, $33, $00, $2a, $c0, $00, $39, $01, $06, $00 ; 0x9a
	db $00, $00, $e6, $55, $00, $35, $00, $24, $40, $00, $32, $01, $03, $00 ; 0xa8
	db $00, $00, $e6, $55, $00, $35, $00, $2a, $c0, $00, $34, $01, $07, $00 ; 0xb6
	db $00, $00, $6d, $7d, $00, $2d, $00, $21, $00, $00, $66, $01, $07, $00 ; 0xc4
	db $00, $00, $6d, $7d, $00, $2d, $00, $29, $00, $00, $6b, $01, $07, $00 ; 0xd2
	db $00, $00, $e2, $55, $00, $3f, $00, $03, $40, $00, $33, $01, $07, $00 ; 0xe0
	db $00, $00, $6d, $7d, $00, $3f, $00, $05, $40, $00, $6c, $01, $00, $00 ; 0xee
	db $00, $00, $6d, $7d, $00, $3f, $00, $07, $40, $00, $35, $01, $05, $00 ; 0xfc
	db $00, $00, $6d, $7d, $00, $3f, $00, $09, $40, $00, $50, $01, $00, $00 ; 0x10a
	db $00, $00, $6d, $7d, $00, $3f, $00, $0b, $40, $00, $53, $01, $00, $00 ; 0x118
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x126
	; $48d4, 57 bytes (bytes:16)
	db $01, $00, $00, $09, $00, $37, $0d, $49, $02, $40, $00, $13, $00, $13, $00, $00 ; 0x00
	db $09, $40, $00, $13, $00, $13, $00, $00, $0a, $c0, $00, $13, $00, $13, $00, $00 ; 0x10
	db $0b, $40, $00, $13, $00, $13, $00, $00, $0c, $c0, $00, $2d, $00, $2b, $00, $00 ; 0x20
	db $0d, $80, $00, $15, $00, $29, $00, $00, $ff ; 0x30
	ld a, [$c295] ; $490d
	cp a, $ff ; $4910
	jp z, Label_15_4955 ; $4912
	call Func_15_4967 ; $4915
	test_flag $05, 7 ; $4918
	jr z, Label_15_4943 ; $491b
	ld a, $02 ; $491d
	ld bc, $00ff ; $491f
	farcall FarPtr_0a_18 ; $4922
	ld a, $02 ; $4925
	ld b, $80 ; $4927
	ld de, $0200 ; $4929
	farcall FarPtr_MoveActorByAngle ; $492c
	ld a, $02 ; $492f
	farcall FarPtr_ScriptWaitActorMoveDone ; $4931
	ld a, $02 ; $4934
	ld b, $00 ; $4936
	farcall FarPtr_SetActorFacing ; $4938
	ld a, $02 ; $493b
	ld bc, $0010 ; $493d
	farcall FarPtr_0a_18 ; $4940
Label_15_4943:
	ld a, $00 ; $4943
	ld bc, $0010 ; $4945
	farcall FarPtr_0a_18 ; $4948
	ld a, $00 ; $494b
	ld b, $00 ; $494d
	ld de, $0200 ; $494f
	farcall FarPtr_MoveActorByAngle ; $4952
Label_15_4955:
	ret ; $4955
	; $4956, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $ff01, $0000, $4967, $0608 ; record 0
	dw $ff0f, $0000, $7d95, $0e08 ; record 1
	db $ff
Func_15_4967:
	clear_flag $17, 2 ; $4967
	clear_flag $17, 5 ; $496a
	clear_flag $17, 3 ; $496d
	clear_flag $17, 6 ; $4970
	clear_flag $17, 4 ; $4973
	clear_flag $17, 7 ; $4976
	ret ; $4979
	ld a, [$c2b0] ; $497a
	add a, a ; $497d
	add a, $91 ; $497e
	ld l, a ; $4980
	adc a, $49 ; $4981
	sub a, l ; $4983
	ld h, a ; $4984
	ld a, [hl+] ; $4985
	ld h, [hl] ; $4986
	ld l, a ; $4987
	farcall FarPtr_0a_0e ; $4988
	ld a, $03 ; $498b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $498d
	ret ; $4990
	; $4991, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $1a79 ; record 0
	dw $1a7c ; record 1
	dw $1a7f ; record 2
	dw $1a7f ; record 3
	dw $1a7f ; record 4
	ld a, [$c2b0] ; $499b
	add a, a ; $499e
	add a, $b2 ; $499f
	ld l, a ; $49a1
	adc a, $49 ; $49a2
	sub a, l ; $49a4
	ld h, a ; $49a5
	ld a, [hl+] ; $49a6
	ld h, [hl] ; $49a7
	ld l, a ; $49a8
	farcall FarPtr_0a_0e ; $49a9
	ld a, $04 ; $49ac
	farcall FarPtr_ScriptShowSpeakerDialogue ; $49ae
	ret ; $49b1
	; $49b2, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $1a7a ; record 0
	dw $1a7d ; record 1
	dw $1a80 ; record 2
	dw $1a80 ; record 3
	dw $1a80 ; record 4
	ld a, [$c2b0] ; $49bc
	add a, a ; $49bf
	add a, $d3 ; $49c0
	ld l, a ; $49c2
	adc a, $49 ; $49c3
	sub a, l ; $49c5
	ld h, a ; $49c6
	ld a, [hl+] ; $49c7
	ld h, [hl] ; $49c8
	ld l, a ; $49c9
	farcall FarPtr_0a_0e ; $49ca
	ld a, $05 ; $49cd
	farcall FarPtr_ScriptShowSpeakerDialogue ; $49cf
	ret ; $49d2
	; $49d3, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $1a7b ; record 0
	dw $1a7e ; record 1
	dw $1a81 ; record 2
	dw $1a81 ; record 3
	dw $1a81 ; record 4
	ld a, [$c2b0] ; $49dd
	add a, a ; $49e0
	add a, $f4 ; $49e1
	ld l, a ; $49e3
	adc a, $49 ; $49e4
	sub a, l ; $49e6
	ld h, a ; $49e7
	ld a, [hl+] ; $49e8
	ld h, [hl] ; $49e9
	ld l, a ; $49ea
	farcall FarPtr_0a_0e ; $49eb
	ld a, $08 ; $49ee
	farcall FarPtr_ScriptShowSpeakerDialogue ; $49f0
	ret ; $49f3
	; $49f4, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $1a8f ; record 0
	dw $1a95 ; record 1
	dw $1a99 ; record 2
	dw $1a99 ; record 3
	dw $1a99 ; record 4
	ld a, [$c2b0] ; $49fe
	add a, a ; $4a01
	add a, $15 ; $4a02
	ld l, a ; $4a04
	adc a, $4a ; $4a05
	sub a, l ; $4a07
	ld h, a ; $4a08
	ld a, [hl+] ; $4a09
	ld h, [hl] ; $4a0a
	ld l, a ; $4a0b
	farcall FarPtr_0a_0e ; $4a0c
	ld a, $09 ; $4a0f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4a11
	ret ; $4a14
	INCBIN "data/bank_015/d_4a15.bin" ; $4a15, 10 bytes
	ld a, [$c2b0] ; $4a1f
	add a, a ; $4a22
	add a, $36 ; $4a23
	ld l, a ; $4a25
	adc a, $4a ; $4a26
	sub a, l ; $4a28
	ld h, a ; $4a29
	ld a, [hl+] ; $4a2a
	ld h, [hl] ; $4a2b
	ld l, a ; $4a2c
	farcall FarPtr_0a_0e ; $4a2d
	ld a, $0a ; $4a30
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4a32
	ret ; $4a35
	; $4a36, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $1a91 ; record 0
	dw $1a97 ; record 1
	dw $1a9b ; record 2
	dw $1a9b ; record 3
	dw $1a9b ; record 4
	ld a, [$c2b0] ; $4a40
	add a, a ; $4a43
	add a, $76 ; $4a44
	ld l, a ; $4a46
	adc a, $4a ; $4a47
	sub a, l ; $4a49
	ld h, a ; $4a4a
	ld a, [hl+] ; $4a4b
	ld h, [hl] ; $4a4c
	ld l, a ; $4a4d
	farcall FarPtr_0a_0e ; $4a4e
	ld a, [$c2b0] ; $4a51
	cp a, $01 ; $4a54
	jr z, Label_15_4a70 ; $4a56
	ld a, $0b ; $4a58
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4a5a
	farcall FarPtr_0a_12 ; $4a5d
	farcall FarPtr_ScriptCloseDialogueWindow ; $4a60
	push af ; $4a63
	ld a, $05 ; $4a64
	farcall FarPtr_WaitScriptFrames ; $4a66
	pop af ; $4a69
	and a, a ; $4a6a
	jr z, Label_15_4a70 ; $4a6b
	farcall FarPtr_0a_10 ; $4a6d
Label_15_4a70:
	ld a, $0b ; $4a70
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4a72
	ret ; $4a75
	; $4a76, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $1a92 ; record 0
	dw $1a98 ; record 1
	dw $1a9c ; record 2
	dw $1a9c ; record 3
	dw $1a9c ; record 4
	ld a, [$c2b0] ; $4a80
	add a, a ; $4a83
	add a, $97 ; $4a84
	ld l, a ; $4a86
	adc a, $4a ; $4a87
	sub a, l ; $4a89
	ld h, a ; $4a8a
	ld a, [hl+] ; $4a8b
	ld h, [hl] ; $4a8c
	ld l, a ; $4a8d
	farcall FarPtr_0a_0e ; $4a8e
	ld a, $0f ; $4a91
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4a93
	ret ; $4a96
	; $4a97, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $1a82 ; record 0
	dw $1a87 ; record 1
	dw $1a8a ; record 2
	dw $1a8a ; record 3
	dw $1a8a ; record 4
	ld a, [$c2b0] ; $4aa1
	add a, a ; $4aa4
	add a, $d7 ; $4aa5
	ld l, a ; $4aa7
	adc a, $4a ; $4aa8
	sub a, l ; $4aaa
	ld h, a ; $4aab
	ld a, [hl+] ; $4aac
	ld h, [hl] ; $4aad
	ld l, a ; $4aae
	farcall FarPtr_0a_0e ; $4aaf
	ld a, [$c2b0] ; $4ab2
	cp a, $01 ; $4ab5
	jr nc, Label_15_4ad1 ; $4ab7
	ld a, $0f ; $4ab9
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4abb
	farcall FarPtr_0a_12 ; $4abe
	farcall FarPtr_ScriptCloseDialogueWindow ; $4ac1
	push af ; $4ac4
	ld a, $05 ; $4ac5
	farcall FarPtr_WaitScriptFrames ; $4ac7
	pop af ; $4aca
	and a, a ; $4acb
	jr z, Label_15_4ad1 ; $4acc
	farcall FarPtr_0a_10 ; $4ace
Label_15_4ad1:
	ld a, $0f ; $4ad1
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4ad3
	ret ; $4ad6
	; $4ad7, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $1a83 ; record 0
	dw $1a88 ; record 1
	dw $1a8b ; record 2
	dw $1a8b ; record 3
	dw $1a8b ; record 4
	ld a, [$c2b0] ; $4ae1
	add a, a ; $4ae4
	add a, $17 ; $4ae5
	ld l, a ; $4ae7
	adc a, $4b ; $4ae8
	sub a, l ; $4aea
	ld h, a ; $4aeb
	ld a, [hl+] ; $4aec
	ld h, [hl] ; $4aed
	ld l, a ; $4aee
	farcall FarPtr_0a_0e ; $4aef
	ld a, [$c2b0] ; $4af2
	cp a, $02 ; $4af5
	jr c, Label_15_4b11 ; $4af7
	ld a, $10 ; $4af9
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4afb
	farcall FarPtr_0a_12 ; $4afe
	farcall FarPtr_ScriptCloseDialogueWindow ; $4b01
	push af ; $4b04
	ld a, $05 ; $4b05
	farcall FarPtr_WaitScriptFrames ; $4b07
	pop af ; $4b0a
	and a, a ; $4b0b
	jr z, Label_15_4b11 ; $4b0c
	farcall FarPtr_0a_10 ; $4b0e
Label_15_4b11:
	ld a, $10 ; $4b11
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4b13
	ret ; $4b16
	INCBIN "data/bank_015/d_4b17.bin" ; $4b17, 10 bytes
	ld a, $13 ; $4b21
	ld b, $00 ; $4b23
	farcall FarPtr_MovePlayerToActor ; $4b25
	farcall FarPtr_WaitPlayerMoveDone ; $4b28
	ld a, $00 ; $4b2b
	farcall FarPtr_GetActorStateAddr ; $4b2d
	ld a, $01 ; $4b30
	ld e, l ; $4b32
	ld d, h ; $4b33
	ld hl, $0018 ; $4b34
	add hl, de ; $4b37
	ld [hl], a ; $4b38
	ld hl, $1a9f ; $4b39
	farcall FarPtr_0a_0e ; $4b3c
	ld a, $13 ; $4b3f
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4b41
	farcall FarPtr_0a_12 ; $4b44
	farcall FarPtr_ScriptCloseDialogueWindow ; $4b47
	push af ; $4b4a
	ld a, $05 ; $4b4b
	farcall FarPtr_WaitScriptFrames ; $4b4d
	pop af ; $4b50
	and a, a ; $4b51
	jp nz, Label_15_4b6e ; $4b52
	ld a, $00 ; $4b55
	ld d, $03 ; $4b57
	farcall FarPtr_ScriptSetActorAnimation ; $4b59
	ld a, $00 ; $4b5c
	farcall FarPtr_ScriptWaitActorIdle ; $4b5e
	ld a, $13 ; $4b61
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4b63
	push af ; $4b66
	ld a, $0a ; $4b67
	farcall FarPtr_WaitScriptFrames ; $4b69
	pop af ; $4b6c
	ret ; $4b6d
Label_15_4b6e:
	set_flag $10, 0 ; $4b6e
	ld a, $00 ; $4b71
	ld d, $04 ; $4b73
	farcall FarPtr_ScriptSetActorAnimation ; $4b75
	ld a, $00 ; $4b78
	farcall FarPtr_ScriptWaitActorIdle ; $4b7a
	ld a, $13 ; $4b7d
	ld d, $01 ; $4b7f
	farcall FarPtr_ScriptSetActorAnimation ; $4b81
	ld a, $13 ; $4b84
	farcall FarPtr_ScriptWaitActorIdle ; $4b86
	ld a, $13 ; $4b89
	ld b, $80 ; $4b8b
	farcall FarPtr_SetActorFacing ; $4b8d
	ld a, $13 ; $4b90
	farcall FarPtr_GetActorStateAddr ; $4b92
	ld a, $02 ; $4b95
	ld e, l ; $4b97
	ld d, h ; $4b98
	ld hl, $0018 ; $4b99
	add hl, de ; $4b9c
	ld [hl], a ; $4b9d
	ld a, $13 ; $4b9e
	ld d, $02 ; $4ba0
	farcall FarPtr_ScriptSetActorAnimation ; $4ba2
	ld a, $13 ; $4ba5
	farcall FarPtr_ScriptWaitActorIdle ; $4ba7
	ld a, $13 ; $4baa
	farcall FarPtr_GetActorStateAddr ; $4bac
	ld a, $01 ; $4baf
	ld e, l ; $4bb1
	ld d, h ; $4bb2
	ld hl, $0018 ; $4bb3
	add hl, de ; $4bb6
	ld [hl], a ; $4bb7
	ld a, $16 ; $4bb8
	ld bc, $3680 ; $4bba
	ld de, $0d80 ; $4bbd
	farcall FarPtr_ScriptSetActorPosition ; $4bc0
	sound $99 ; $4bc3
	farcall FarPtr_0a_10 ; $4bc5
	ld a, $13 ; $4bc8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4bca
	ld a, $00 ; $4bcd
	ld bc, $0012 ; $4bcf
	farcall FarPtr_0a_18 ; $4bd2
	ld a, $00 ; $4bd5
	ld d, $03 ; $4bd7
	farcall FarPtr_ScriptSetActorAnimation ; $4bd9
	ld a, $00 ; $4bdc
	farcall FarPtr_ScriptWaitActorIdle ; $4bde
	ld a, $00 ; $4be1
	ld bc, $3300 ; $4be3
	ld de, $0f00 ; $4be6
	farcall FarPtr_ScriptSetActorMoveTarget ; $4be9
	ld a, $00 ; $4bec
	farcall FarPtr_ScriptWaitActorMoveDone ; $4bee
	ld a, $00 ; $4bf1
	ld b, $40 ; $4bf3
	farcall FarPtr_SetActorFacing ; $4bf5
	push af ; $4bf8
	ld a, $0a ; $4bf9
	farcall FarPtr_WaitScriptFrames ; $4bfb
	pop af ; $4bfe
	ld a, $16 ; $4bff
	ld bc, $3f00 ; $4c01
	ld de, $3f00 ; $4c04
	farcall FarPtr_ScriptSetActorPosition ; $4c07
	push af ; $4c0a
	ld a, $14 ; $4c0b
	farcall FarPtr_WaitScriptFrames ; $4c0d
	pop af ; $4c10
	ld a, $00 ; $4c11
	ld d, $06 ; $4c13
	farcall FarPtr_ScriptSetActorAnimation ; $4c15
	push af ; $4c18
	ld a, $b4 ; $4c19
	farcall FarPtr_WaitScriptFrames ; $4c1b
	pop af ; $4c1e
	ld a, $00 ; $4c1f
	ld d, $01 ; $4c21
	farcall FarPtr_ScriptSetActorAnimation ; $4c23
	ld a, $00 ; $4c26
	farcall FarPtr_ScriptWaitActorIdle ; $4c28
	ld a, $00 ; $4c2b
	ld b, $00 ; $4c2d
	farcall FarPtr_SetActorFacing ; $4c2f
	ld a, $13 ; $4c32
	ld b, $40 ; $4c34
	farcall FarPtr_SetActorFacing ; $4c36
	push af ; $4c39
	ld a, $01 ; $4c3a
	farcall FarPtr_WaitScriptFrames ; $4c3c
	pop af ; $4c3f
	ld a, $13 ; $4c40
	ld d, $04 ; $4c42
	farcall FarPtr_ScriptSetActorAnimation ; $4c44
	ld a, $13 ; $4c47
	farcall FarPtr_ScriptWaitActorIdle ; $4c49
	ld a, $13 ; $4c4c
	ld b, $80 ; $4c4e
	farcall FarPtr_SetActorFacing ; $4c50
	push af ; $4c53
	ld a, $01 ; $4c54
	farcall FarPtr_WaitScriptFrames ; $4c56
	pop af ; $4c59
	ld a, $13 ; $4c5a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4c5c
	push af ; $4c5f
	ld a, $1e ; $4c60
	farcall FarPtr_WaitScriptFrames ; $4c62
	pop af ; $4c65
	ld a, $00 ; $4c66
	ld bc, $0020 ; $4c68
	farcall FarPtr_0a_18 ; $4c6b
	ld a, $00 ; $4c6e
	ld b, $40 ; $4c70
	farcall FarPtr_SetActorFacing ; $4c72
	push af ; $4c75
	ld a, $01 ; $4c76
	farcall FarPtr_WaitScriptFrames ; $4c78
	pop af ; $4c7b
	ld a, $00 ; $4c7c
	ld b, $01 ; $4c7e
	farcall FarPtr_0a_2c ; $4c80
	ld a, $00 ; $4c83
	ld d, $02 ; $4c85
	farcall FarPtr_ScriptSetActorAnimation ; $4c87
	ld a, $00 ; $4c8a
	ld bc, $3300 ; $4c8c
	ld de, $0d00 ; $4c8f
	farcall FarPtr_ScriptSetActorMoveTarget ; $4c92
	ld a, $13 ; $4c95
	ld bc, $3300 ; $4c97
	ld de, $0f00 ; $4c9a
	farcall FarPtr_ScriptSetActorMoveTarget ; $4c9d
	ld a, $13 ; $4ca0
	farcall FarPtr_ScriptWaitActorMoveDone ; $4ca2
	ld a, $13 ; $4ca5
	ld bc, $3300 ; $4ca7
	ld de, $1500 ; $4caa
	farcall FarPtr_ScriptSetActorMoveTarget ; $4cad
	ld a, $13 ; $4cb0
	farcall FarPtr_ScriptWaitActorMoveDone ; $4cb2
	ld a, $13 ; $4cb5
	ld bc, $1f00 ; $4cb7
	ld de, $1500 ; $4cba
	farcall FarPtr_ScriptSetActorMoveTarget ; $4cbd
	ld a, $13 ; $4cc0
	farcall FarPtr_ScriptWaitActorMoveDone ; $4cc2
	ld a, $13 ; $4cc5
	ld bc, $3f00 ; $4cc7
	ld de, $3f00 ; $4cca
	farcall FarPtr_ScriptSetActorPosition ; $4ccd
	ld a, $00 ; $4cd0
	ld b, $00 ; $4cd2
	farcall FarPtr_0a_2c ; $4cd4
	ld a, $00 ; $4cd7
	ld b, $40 ; $4cd9
	farcall FarPtr_SetActorFacing ; $4cdb
	ld a, $00 ; $4cde
	farcall FarPtr_GetActorStateAddr ; $4ce0
	ld a, $02 ; $4ce3
	ld e, l ; $4ce5
	ld d, h ; $4ce6
	ld hl, $0018 ; $4ce7
	add hl, de ; $4cea
	ld [hl], a ; $4ceb
	ld a, $00 ; $4cec
	ld d, $02 ; $4cee
	farcall FarPtr_ScriptSetActorAnimation ; $4cf0
	ld a, $16 ; $4cf3
	ld bc, $3480 ; $4cf5
	ld de, $0b80 ; $4cf8
	farcall FarPtr_ScriptSetActorPosition ; $4cfb
	sound $99 ; $4cfe
	push af ; $4d00
	ld a, $50 ; $4d01
	farcall FarPtr_WaitScriptFrames ; $4d03
	pop af ; $4d06
	ld a, $00 ; $4d07
	farcall FarPtr_GetActorStateAddr ; $4d09
	ld a, $01 ; $4d0c
	ld e, l ; $4d0e
	ld d, h ; $4d0f
	ld hl, $0018 ; $4d10
	add hl, de ; $4d13
	ld [hl], a ; $4d14
	ld a, $00 ; $4d15
	ld b, $00 ; $4d17
	farcall FarPtr_MovePlayerToActor ; $4d19
	farcall FarPtr_WaitPlayerMoveDone ; $4d1c
	xor a, a ; $4d1f
	ld bc, $3300 ; $4d20
	ld de, $0c00 ; $4d23
	farcall FarPtr_MovePlayerToPosition ; $4d26
	farcall FarPtr_WaitPlayerMoveDone ; $4d29
	ld hl, $1aa3 ; $4d2c
	farcall FarPtr_0a_0e ; $4d2f
	ld a, $00 ; $4d32
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4d34
	ld a, $16 ; $4d37
	ld bc, $3f00 ; $4d39
	ld de, $3f00 ; $4d3c
	farcall FarPtr_ScriptSetActorPosition ; $4d3f
	call Func_15_564a ; $4d42
	test_flag $0c, 4 ; $4d45
	jp nz, Label_15_4d5c ; $4d48
	test_flag $0c, 5 ; $4d4b
	jp nz, Label_15_4d5c ; $4d4e
	ld a, [wWaterSpriteMinigameSwingCount] ; $4d51
	cp a, $64 ; $4d54
	jp c, Label_15_4d5c ; $4d56
	call Func_15_4d5d ; $4d59
Label_15_4d5c:
	ret ; $4d5c
Func_15_4d5d:
	push af ; $4d5d
	ld a, $3c ; $4d5e
	farcall FarPtr_WaitScriptFrames ; $4d60
	pop af ; $4d63
	ld hl, $1aa5 ; $4d64
	farcall FarPtr_0a_0e ; $4d67
	ld a, $14 ; $4d6a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4d6c
	push af ; $4d6f
	ld a, $1e ; $4d70
	farcall FarPtr_WaitScriptFrames ; $4d72
	pop af ; $4d75
	ld a, $00 ; $4d76
	ld b, $80 ; $4d78
	farcall FarPtr_SetActorFacing ; $4d7a
	push af ; $4d7d
	ld a, $1e ; $4d7e
	farcall FarPtr_WaitScriptFrames ; $4d80
	pop af ; $4d83
	ld a, $00 ; $4d84
	ld b, $00 ; $4d86
	farcall FarPtr_SetActorFacing ; $4d88
	push af ; $4d8b
	ld a, $1e ; $4d8c
	farcall FarPtr_WaitScriptFrames ; $4d8e
	pop af ; $4d91
	ld a, $00 ; $4d92
	ld b, $80 ; $4d94
	farcall FarPtr_SetActorFacing ; $4d96
	push af ; $4d99
	ld a, $1e ; $4d9a
	farcall FarPtr_WaitScriptFrames ; $4d9c
	pop af ; $4d9f
	ld a, $00 ; $4da0
	ld b, $00 ; $4da2
	farcall FarPtr_SetActorFacing ; $4da4
	push af ; $4da7
	ld a, $1e ; $4da8
	farcall FarPtr_WaitScriptFrames ; $4daa
	pop af ; $4dad
	ld a, $00 ; $4dae
	ld b, $40 ; $4db0
	farcall FarPtr_SetActorFacing ; $4db2
	push af ; $4db5
	ld a, $1e ; $4db6
	farcall FarPtr_WaitScriptFrames ; $4db8
	pop af ; $4dbb
	ld d, $4d ; $4dbc
	ld a, $16 ; $4dbe
	farcall FarPtr_GetActorStateAddr ; $4dc0
	ld c, l ; $4dc3
	ld b, h ; $4dc4
	farcall FarPtr_04_2c ; $4dc5
	ld d, $4c ; $4dc8
	ld a, $13 ; $4dca
	farcall FarPtr_GetActorStateAddr ; $4dcc
	ld c, l ; $4dcf
	ld b, h ; $4dd0
	farcall FarPtr_04_2c ; $4dd1
	ld a, $16 ; $4dd4
	ld bc, $3480 ; $4dd6
	ld de, $0b80 ; $4dd9
	farcall FarPtr_ScriptSetActorPosition ; $4ddc
	sound $98 ; $4ddf
	push af ; $4de1
	ld a, $3c ; $4de2
	farcall FarPtr_WaitScriptFrames ; $4de4
	pop af ; $4de7
	ld a, $14 ; $4de8
	ld bc, $3300 ; $4dea
	ld de, $0700 ; $4ded
	farcall FarPtr_ScriptSetActorPosition ; $4df0
	ld a, $14 ; $4df3
	ld b, $00 ; $4df5
	farcall FarPtr_SetActorActive ; $4df7
	ld bc, $0010 ; $4dfa
	farcall FarPtr_0a_38 ; $4dfd
	ld a, $14 ; $4e00
	ld b, $00 ; $4e02
	farcall FarPtr_MovePlayerToActor ; $4e04
	ld hl, $5950 ; $4e07
	ld de, $0206 ; $4e0a
	call LoadPalettesImmediate ; $4e0d
	push af ; $4e10
	ld a, $1e ; $4e11
	farcall FarPtr_WaitScriptFrames ; $4e13
	pop af ; $4e16
	ld hl, $5990 ; $4e17
	ld de, $0206 ; $4e1a
	call LoadPalettesImmediate ; $4e1d
	sound $8a ; $4e20
	ld a, $10 ; $4e22
Label_15_4e24:
	ld d, a ; $4e24
	ld a, $14 ; $4e25
	ld b, $02 ; $4e27
	farcall FarPtr_SetActorActive ; $4e29
	push af ; $4e2c
	ld a, $04 ; $4e2d
	farcall FarPtr_WaitScriptFrames ; $4e2f
	pop af ; $4e32
	ld a, $14 ; $4e33
	ld b, $00 ; $4e35
	farcall FarPtr_SetActorActive ; $4e37
	push af ; $4e3a
	ld a, d ; $4e3b
	farcall FarPtr_WaitScriptFrames ; $4e3c
	pop af ; $4e3f
	ld a, d ; $4e40
	sub a, $02 ; $4e41
	jp nz, Label_15_4e24 ; $4e43
	ld a, $14 ; $4e46
	ld b, $02 ; $4e48
	farcall FarPtr_SetActorActive ; $4e4a
	push af ; $4e4d
	ld a, $3c ; $4e4e
	farcall FarPtr_WaitScriptFrames ; $4e50
	pop af ; $4e53
	ld a, $16 ; $4e54
	ld bc, $3f00 ; $4e56
	ld de, $3f00 ; $4e59
	farcall FarPtr_ScriptSetActorPosition ; $4e5c
	ld a, $00 ; $4e5f
	ld b, $c0 ; $4e61
	farcall FarPtr_SetActorFacing ; $4e63
	push af ; $4e66
	ld a, $1e ; $4e67
	farcall FarPtr_WaitScriptFrames ; $4e69
	pop af ; $4e6c
	ld a, $13 ; $4e6d
	ld bc, $3480 ; $4e6f
	ld de, $0b80 ; $4e72
	farcall FarPtr_ScriptSetActorPosition ; $4e75
	sound $97 ; $4e78
	push af ; $4e7a
	ld a, $14 ; $4e7b
	farcall FarPtr_WaitScriptFrames ; $4e7d
	pop af ; $4e80
	ld a, $13 ; $4e81
	ld de, rLCDC ; $4e83
	farcall FarPtr_0a_42 ; $4e86
	ld a, $00 ; $4e89
	ld de, rLCDC ; $4e8b
	farcall FarPtr_0a_42 ; $4e8e
	ld a, $00 ; $4e91
	farcall FarPtr_0a_44 ; $4e93
	ld a, $13 ; $4e96
	ld bc, $3f00 ; $4e98
	ld de, $3f00 ; $4e9b
	farcall FarPtr_ScriptSetActorPosition ; $4e9e
	ld a, $14 ; $4ea1
	ld d, $03 ; $4ea3
	farcall FarPtr_ScriptSetActorAnimation ; $4ea5
	ld a, $14 ; $4ea8
	farcall FarPtr_ScriptWaitActorIdle ; $4eaa
	ld a, $14 ; $4ead
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4eaf
	ld a, $00 ; $4eb2
	ld d, $02 ; $4eb4
	farcall FarPtr_ScriptSetActorAnimation ; $4eb6
	ld a, $00 ; $4eb9
	farcall FarPtr_ScriptWaitActorIdle ; $4ebb
	ld a, $14 ; $4ebe
	ld d, $03 ; $4ec0
	farcall FarPtr_ScriptSetActorAnimation ; $4ec2
	ld a, $14 ; $4ec5
	farcall FarPtr_ScriptWaitActorIdle ; $4ec7
	ld a, [wWaterSpriteMinigameSwingCount] ; $4eca
	cp a, $96 ; $4ecd
	jp nc, Label_15_4eef ; $4ecf
	farcall FarPtr_0a_10 ; $4ed2
	ld a, $15 ; $4ed5
	farcall FarPtr_GetActorStateAddr ; $4ed7
	ld c, l ; $4eda
	ld b, h ; $4edb
	ld hl, $0037 ; $4edc
	add hl, bc ; $4edf
	ld a, [hl] ; $4ee0
	and a, $f8 ; $4ee1
	or a, $07 ; $4ee3
	ld [hl], a ; $4ee5
	set_flag $0c, 4 ; $4ee6
	ld a, $05 ; $4ee9
	ld b, a ; $4eeb
	jp Label_15_4ef5 ; $4eec
Label_15_4eef:
	set_flag $0c, 5 ; $4eef
	ld a, $04 ; $4ef2
	ld b, a ; $4ef4
Label_15_4ef5:
	ld a, [wEquippedRacket] ; $4ef5
	and a, $f0 ; $4ef8
	or a, b ; $4efa
	ld [wEquippedRacket], a ; $4efb
	ld a, $14 ; $4efe
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4f00
	push af ; $4f03
	ld a, $0a ; $4f04
	farcall FarPtr_WaitScriptFrames ; $4f06
	pop af ; $4f09
	ld c, $03 ; $4f0a
	call BeginFadeOut ; $4f0c
	call WaitFadeEnd ; $4f0f
	sound $8e ; $4f12
	ld a, $15 ; $4f14
	ld bc, $3300 ; $4f16
	ld de, $0900 ; $4f19
	farcall FarPtr_ScriptSetActorPosition ; $4f1c
	push af ; $4f1f
	ld a, $1e ; $4f20
	farcall FarPtr_WaitScriptFrames ; $4f22
	pop af ; $4f25
	ld c, $03 ; $4f26
	call BeginFadeIn ; $4f28
	call WaitFadeEnd ; $4f2b
	push af ; $4f2e
	ld a, $3c ; $4f2f
	farcall FarPtr_WaitScriptFrames ; $4f31
	pop af ; $4f34
	sound $8f ; $4f35
	ld a, $15 ; $4f37
	ld bc, $0005 ; $4f39
	farcall FarPtr_0a_18 ; $4f3c
	ld a, $15 ; $4f3f
	ld bc, $3300 ; $4f41
	ld de, $0d00 ; $4f44
	farcall FarPtr_ScriptSetActorMoveTarget ; $4f47
	ld a, $15 ; $4f4a
	farcall FarPtr_ScriptWaitActorMoveDone ; $4f4c
	push af ; $4f4f
	ld a, $3c ; $4f50
	farcall FarPtr_WaitScriptFrames ; $4f52
	pop af ; $4f55
	farcall FarPtr_0a_10 ; $4f56
	ld a, $00 ; $4f59
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4f5b
	ld a, $17 ; $4f5e
	ld bc, $3480 ; $4f60
	ld de, $0b80 ; $4f63
	farcall FarPtr_ScriptSetActorPosition ; $4f66
	sound $96 ; $4f69
	push af ; $4f6b
	ld a, $78 ; $4f6c
	farcall FarPtr_WaitScriptFrames ; $4f6e
	pop af ; $4f71
	ld a, $17 ; $4f72
	ld bc, $3f00 ; $4f74
	ld de, $3f00 ; $4f77
	farcall FarPtr_ScriptSetActorPosition ; $4f7a
	ld a, $14 ; $4f7d
	ld d, $03 ; $4f7f
	farcall FarPtr_ScriptSetActorAnimation ; $4f81
	ld a, $14 ; $4f84
	farcall FarPtr_ScriptWaitActorIdle ; $4f86
	ld hl, $1aab ; $4f89
	farcall FarPtr_0a_0e ; $4f8c
	ld a, $14 ; $4f8f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4f91
	push af ; $4f94
	ld a, $32 ; $4f95
	farcall FarPtr_WaitScriptFrames ; $4f97
	pop af ; $4f9a
	sound $90 ; $4f9b
	ld d, $10 ; $4f9d
Label_15_4f9f:
	ld a, $14 ; $4f9f
	ld b, $00 ; $4fa1
	farcall FarPtr_SetActorActive ; $4fa3
	push af ; $4fa6
	ld a, $04 ; $4fa7
	farcall FarPtr_WaitScriptFrames ; $4fa9
	pop af ; $4fac
	ld a, $14 ; $4fad
	ld b, $02 ; $4faf
	farcall FarPtr_SetActorActive ; $4fb1
	push af ; $4fb4
	ld a, d ; $4fb5
	farcall FarPtr_WaitScriptFrames ; $4fb6
	pop af ; $4fb9
	ld a, d ; $4fba
	sub a, $02 ; $4fbb
	ld d, a ; $4fbd
	jp nz, Label_15_4f9f ; $4fbe
	ld a, $14 ; $4fc1
	ld b, $00 ; $4fc3
	farcall FarPtr_SetActorActive ; $4fc5
	push af ; $4fc8
	ld a, $1e ; $4fc9
	farcall FarPtr_WaitScriptFrames ; $4fcb
	pop af ; $4fce
	ld a, $14 ; $4fcf
	ld bc, $3300 ; $4fd1
	ld de, $0b00 ; $4fd4
	farcall FarPtr_ScriptSetActorPosition ; $4fd7
	ld a, $14 ; $4fda
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4fdc
	ld a, $15 ; $4fdf
	ld bc, $3f00 ; $4fe1
	ld de, $3f00 ; $4fe4
	farcall FarPtr_ScriptSetActorPosition ; $4fe7
	ld hl, $5950 ; $4fea
	ld de, $0206 ; $4fed
	call LoadPalettesImmediate ; $4ff0
	push af ; $4ff3
	ld a, $1e ; $4ff4
	farcall FarPtr_WaitScriptFrames ; $4ff6
	pop af ; $4ff9
	ld hl, $5910 ; $4ffa
	ld de, $0206 ; $4ffd
	call LoadPalettesImmediate ; $5000
	push af ; $5003
	ld a, $1e ; $5004
	farcall FarPtr_WaitScriptFrames ; $5006
	pop af ; $5009
	ld a, $00 ; $500a
	ld b, $80 ; $500c
	farcall FarPtr_SetActorFacing ; $500e
	push af ; $5011
	ld a, $14 ; $5012
	farcall FarPtr_WaitScriptFrames ; $5014
	pop af ; $5017
	ld a, $00 ; $5018
	ld b, $00 ; $501a
	farcall FarPtr_SetActorFacing ; $501c
	push af ; $501f
	ld a, $14 ; $5020
	farcall FarPtr_WaitScriptFrames ; $5022
	pop af ; $5025
	ld a, $00 ; $5026
	ld b, $80 ; $5028
	farcall FarPtr_SetActorFacing ; $502a
	push af ; $502d
	ld a, $14 ; $502e
	farcall FarPtr_WaitScriptFrames ; $5030
	pop af ; $5033
	ld a, $00 ; $5034
	ld b, $00 ; $5036
	farcall FarPtr_SetActorFacing ; $5038
	push af ; $503b
	ld a, $14 ; $503c
	farcall FarPtr_WaitScriptFrames ; $503e
	pop af ; $5041
	ld a, $00 ; $5042
	ld b, $c0 ; $5044
	farcall FarPtr_SetActorFacing ; $5046
	ld a, $00 ; $5049
	ld b, $00 ; $504b
	farcall FarPtr_MovePlayerToActor ; $504d
	farcall FarPtr_WaitPlayerMoveDone ; $5050
	push af ; $5053
	ld a, $1e ; $5054
	farcall FarPtr_WaitScriptFrames ; $5056
	pop af ; $5059
	ret ; $505a
	; $505b, 144 bytes (records:8)
; 18 records x 8 bytes
	dw $ff03, $0000, $497a, $001b ; record 0
	dw $ff04, $0000, $499b, $001b ; record 1
	dw $ff05, $0000, $49bc, $001b ; record 2
	dw $ff06, $0000, $50fc, $0003 ; record 3
	dw $8007, $0000, $5112, $0003 ; record 4
	dw $ff07, $0000, $513f, $0003 ; record 5
	dw $ff08, $0000, $49dd, $001b ; record 6
	dw $ff09, $0000, $49fe, $001b ; record 7
	dw $ff0a, $0000, $4a1f, $001b ; record 8
	dw $ff0b, $0000, $4a40, $001b ; record 9
	dw $ff0c, $0000, $5254, $0003 ; record 10
	dw $400d, $0000, $526a, $0003 ; record 11
	dw $ff0d, $0000, $5297, $0003 ; record 12
	dw $ff0e, $0000, $4a80, $001b ; record 13
	dw $ff0f, $0000, $4aa1, $001b ; record 14
	dw $ff10, $0000, $4ae1, $001b ; record 15
	dw $ff11, $0000, $51a8, $0003 ; record 16
	dw $4012, $0000, $51be, $0003 ; record 17
	; $50eb, 211 bytes (records:8)
; 26 records x 8 bytes
	dw $ff12, $0000, $51eb, $0003 ; record 0
	dw $ff13, $0000, $4b21, $0000 ; record 1
	dw $f7ff, $1800, $0420, $e1cd ; record 2
	dw $c963, $20f7, $2018, $cd04 ; record 3
	dw $64a8, $cdc9, $6586, $3ec9 ; record 4
	dw $0100, $0008, $18df, $3e0a ; record 5
	dw $0600, $df01, $0a2c, $003e ; record 6
	dw $0001, $1113, $1300, $24df ; record 7
	dw $3e0a, $df00, $0a20, $003e ; record 8
	dw $0006, $2cdf, $3e0a, $0600 ; record 9
	dw $df40, $0a2e, $60f7, $2018 ; record 10
	dw $cd04, $66f5, $f7c9, $1880 ; record 11
	dw $2520, $a0f7, $2017, $f709 ; record 12
	dw $0a60, $0428, $7ecd, $c967 ; record 13
	dw $2121, $df1c, $0a0e, $60f7 ; record 14
	dw $280a, $2106, $1c22, $0edf ; record 15
	dw $3e0a, $df07, $0a08, $f7c9 ; record 16
	dw $18a0, $2520, $a0f7, $2017 ; record 17
	dw $f709, $0ae0, $0428, $fccd ; record 18
	dw $c967, $3221, $df1c, $0a0e ; record 19
	dw $e0f7, $280a, $2106, $1c22 ; record 20
	dw $0edf, $3e0a, $df07, $0a08 ; record 21
	dw $21c9, $1c3d, $0edf, $3e0a ; record 22
	dw $df07, $0a08, $f7c9, $18c0 ; record 23
	dw $0420, $8fcd, $c968, $e0f7 ; record 24
	dw $2018, $cd04, $6963, $cdc9 ; record 25
	db $2d, $6a, $c9
	ld a, $00 ; $51be
	ld bc, $0008 ; $51c0
	farcall FarPtr_0a_18 ; $51c3
	ld a, $00 ; $51c6
	ld b, $01 ; $51c8
	farcall FarPtr_0a_2c ; $51ca
	ld a, $00 ; $51cd
	ld bc, $2d00 ; $51cf
	ld de, $2b00 ; $51d2
	farcall FarPtr_ScriptSetActorMoveTarget ; $51d5
	ld a, $00 ; $51d8
	farcall FarPtr_ScriptWaitActorMoveDone ; $51da
	ld a, $00 ; $51dd
	ld b, $00 ; $51df
	farcall FarPtr_0a_2c ; $51e1
	ld a, $00 ; $51e4
	ld b, $c0 ; $51e6
	farcall FarPtr_SetActorFacing ; $51e8
	test_flag $19, 1 ; $51eb
	jr nz, Label_15_51f4 ; $51ee
	call Func_15_6fcf ; $51f0
	ret ; $51f3
Label_15_51f4:
	test_flag $19, 2 ; $51f4
	jr nz, Label_15_521e ; $51f7
	test_flag $17, 6 ; $51f9
	jr nz, Label_15_5207 ; $51fc
	test_flag $0a, 3 ; $51fe
	jr z, Label_15_5207 ; $5201
	call Func_15_706e ; $5203
	ret ; $5206
Label_15_5207:
	ld hl, $1c80 ; $5207
	farcall FarPtr_0a_0e ; $520a
	test_flag $0a, 7 ; $520d
	jr z, Label_15_5218 ; $5210
	ld hl, $1c83 ; $5212
	farcall FarPtr_0a_0e ; $5215
Label_15_5218:
	ld a, $12 ; $5218
	farcall FarPtr_ScriptShowSpeakerDialogue ; $521a
	ret ; $521d
Label_15_521e:
	test_flag $19, 3 ; $521e
	jr nz, Label_15_5248 ; $5221
	test_flag $17, 6 ; $5223
	jr nz, Label_15_5231 ; $5226
	test_flag $0a, 7 ; $5228
	jr z, Label_15_5231 ; $522b
	call Func_15_711d ; $522d
	ret ; $5230
Label_15_5231:
	ld hl, $1c9e ; $5231
	farcall FarPtr_0a_0e ; $5234
	test_flag $0a, 7 ; $5237
	jr z, Label_15_5242 ; $523a
	ld hl, $1c9c ; $523c
	farcall FarPtr_0a_0e ; $523f
Label_15_5242:
	ld a, $12 ; $5242
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5244
	ret ; $5247
Label_15_5248:
	ld hl, $1cbb ; $5248
	farcall FarPtr_0a_0e ; $524b
	ld a, $12 ; $524e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5250
	ret ; $5253
	test_flag $19, 4 ; $5254
	jr nz, Label_15_525d ; $5257
	call Func_15_6b94 ; $5259
	ret ; $525c
Label_15_525d:
	test_flag $19, 5 ; $525d
	jr nz, Label_15_5266 ; $5260
	call Func_15_6c3c ; $5262
	ret ; $5265
Label_15_5266:
	call Func_15_6ce4 ; $5266
	ret ; $5269
	ld a, $00 ; $526a
	ld bc, $0008 ; $526c
	farcall FarPtr_0a_18 ; $526f
	ld a, $00 ; $5272
	ld b, $01 ; $5274
	farcall FarPtr_0a_2c ; $5276
	ld a, $00 ; $5279
	ld bc, $1300 ; $527b
	ld de, $2b00 ; $527e
	farcall FarPtr_ScriptSetActorMoveTarget ; $5281
	ld a, $00 ; $5284
	farcall FarPtr_ScriptWaitActorMoveDone ; $5286
	ld a, $00 ; $5289
	ld b, $00 ; $528b
	farcall FarPtr_0a_2c ; $528d
	ld a, $00 ; $5290
	ld b, $c0 ; $5292
	farcall FarPtr_SetActorFacing ; $5294
	test_flag $19, 7 ; $5297
	jr nz, Label_15_52a0 ; $529a
	call Func_15_6db4 ; $529c
	ret ; $529f
Label_15_52a0:
	test_flag $1a, 0 ; $52a0
	jr nz, Label_15_52d5 ; $52a3
	test_flag $17, 7 ; $52a5
	jr nz, Label_15_52b3 ; $52a8
	test_flag $0a, 3 ; $52aa
	jr z, Label_15_52b3 ; $52ad
	call Func_15_6e4b ; $52af
	ret ; $52b2
Label_15_52b3:
	ld hl, $1ce1 ; $52b3
	farcall FarPtr_0a_0e ; $52b6
	test_flag $0a, 3 ; $52b9
	jr z, Label_15_52cf ; $52bc
	ld hl, $1ce2 ; $52be
	farcall FarPtr_0a_0e ; $52c1
	test_flag $0a, 7 ; $52c4
	jr z, Label_15_52cf ; $52c7
	ld hl, $1ce2 ; $52c9
	farcall FarPtr_0a_0e ; $52cc
Label_15_52cf:
	ld a, $0d ; $52cf
	farcall FarPtr_ScriptShowSpeakerDialogue ; $52d1
	ret ; $52d4
Label_15_52d5:
	test_flag $1a, 1 ; $52d5
	jr nz, Label_15_52f4 ; $52d8
	test_flag $17, 7 ; $52da
	jr nz, Label_15_52e8 ; $52dd
	test_flag $0a, 7 ; $52df
	jr z, Label_15_52e8 ; $52e2
	call Func_15_6ece ; $52e4
	ret ; $52e7
Label_15_52e8:
	ld hl, $1cf8 ; $52e8
	farcall FarPtr_0a_0e ; $52eb
	ld a, $0d ; $52ee
	farcall FarPtr_ScriptShowSpeakerDialogue ; $52f0
	ret ; $52f3
Label_15_52f4:
	ld hl, $2012 ; $52f4
	farcall FarPtr_0a_0e ; $52f7
	ld a, $0d ; $52fa
	farcall FarPtr_ScriptShowSpeakerDialogue ; $52fc
	ret ; $52ff
	; $5300, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $5309, $0000 ; record 0
	db $ff
	ret ; $5309
	; $530a, 36 bytes (records:8)
; 4 records x 8 bytes
	dw $4001, $9000, $5313, $0000 ; record 0
	dw $3eff, $0100, $3300, $0011 ; record 1
	dw $df0d, $0a24, $003e, $20df ; record 2
	dw $3e0a, $0600, $df40, $0a2e ; record 3
	db $cd, $07, $4d, $c9
	call ComputeTrainingCourtProgressIndex ; $532e
	ld a, [$c2b0] ; $5331
	cp a, $05 ; $5334
	jr c, Label_15_5340 ; $5336
	ld a, [$c2b0] ; $5338
	sub a, $06 ; $533b
	ld [$c2b0], a ; $533d
Label_15_5340:
	ld a, [$c295] ; $5340
	cp a, $0f ; $5343
	jr nz, Label_15_534b ; $5345
	call Func_15_59c0 ; $5347
	ret ; $534a
Label_15_534b:
	call Func_15_71be ; $534b
	call Func_15_724a ; $534e
	call Func_15_7204 ; $5351
	call Func_15_7a45 ; $5354
	ld a, [$c295] ; $5357
	cp a, $0a ; $535a
	jr nz, Label_15_5362 ; $535c
	call Func_15_536d ; $535e
	ret ; $5361
Label_15_5362:
	ld a, [$c295] ; $5362
	cp a, $09 ; $5365
	jr nz, Label_15_536c ; $5367
	call Func_15_7a67 ; $5369
Label_15_536c:
	ret ; $536c
Func_15_536d:
	ld a, [$c4c7] ; $536d
	cp a, $01 ; $5370
	jr nz, Label_15_5378 ; $5372
	call Func_15_53a9 ; $5374
	ret ; $5377
Label_15_5378:
	ld a, [$c8f7] ; $5378
	cp a, $12 ; $537b
	jr c, Label_15_5380 ; $537d
	ret ; $537f
Label_15_5380:
	ld a, [$c8f7] ; $5380
	ld a, a ; $5383
	rst Rst00 ; $5384
	dw Label_15_5e85 ; $5385 jumptable
	dw Label_15_5eb7 ; $5387 jumptable
	dw Label_15_5edf ; $5389 jumptable
	dw Label_15_7290 ; $538b jumptable
	dw Label_15_729f ; $538d jumptable
	dw Label_15_72b4 ; $538f jumptable
	dw Label_15_62bf ; $5391 jumptable
	dw Label_15_6300 ; $5393 jumptable
	dw Label_15_6328 ; $5395 jumptable
	dw Label_15_7539 ; $5397 jumptable
	dw Label_15_754e ; $5399 jumptable
	dw Label_15_7563 ; $539b jumptable
	dw Label_15_6350 ; $539d jumptable
	dw Label_15_6391 ; $539f jumptable
	dw Label_15_63b9 ; $53a1 jumptable
	dw Label_15_77aa ; $53a3 jumptable
	dw Label_15_77bd ; $53a5 jumptable
	dw Label_15_77d0 ; $53a7 jumptable
Func_15_53a9:
	ld a, [$c8f7] ; $53a9
	ld a, a ; $53ac
	rst Rst00 ; $53ad
	dw Label_15_53d2 ; $53ae jumptable
	dw Label_15_53d2 ; $53b0 jumptable
	dw Label_15_53d2 ; $53b2 jumptable
	dw Label_15_5437 ; $53b4 jumptable
	dw Label_15_5437 ; $53b6 jumptable
	dw Label_15_5437 ; $53b8 jumptable
	dw Label_15_5482 ; $53ba jumptable
	dw Label_15_5482 ; $53bc jumptable
	dw Label_15_5482 ; $53be jumptable
	dw Label_15_54e7 ; $53c0 jumptable
	dw Label_15_54e7 ; $53c2 jumptable
	dw Label_15_54e7 ; $53c4 jumptable
	dw Label_15_5532 ; $53c6 jumptable
	dw Label_15_5532 ; $53c8 jumptable
	dw Label_15_5532 ; $53ca jumptable
	dw Label_15_5597 ; $53cc jumptable
	dw Label_15_5597 ; $53ce jumptable
	dw Label_15_5597 ; $53d0 jumptable
Label_15_53d2:
	xor a, a ; $53d2
	ld [$c2d5], a ; $53d3
	ld a, $06 ; $53d6
	ld [$c2b1], a ; $53d8
	ld a, $00 ; $53db
	ld bc, $1800 ; $53dd
	ld de, $1100 ; $53e0
	farcall FarPtr_ScriptSetActorPosition ; $53e3
	ld a, $00 ; $53e6
	ld b, $c0 ; $53e8
	farcall FarPtr_SetActorFacing ; $53ea
	ld a, [$c2b1] ; $53ed
	ld bc, $1800 ; $53f0
	ld de, $0d00 ; $53f3
	farcall FarPtr_ScriptSetActorPosition ; $53f6
	ld a, [$c2b1] ; $53f9
	ld b, $40 ; $53fc
	farcall FarPtr_SetActorFacing ; $53fe
	ld a, $02 ; $5401
	farcall FarPtr_0a_1c ; $5403
	ld a, $02 ; $5406
	ld bc, $1300 ; $5408
	ld de, $1100 ; $540b
	farcall FarPtr_ScriptSetActorPosition ; $540e
	ld a, $02 ; $5411
	ld b, $00 ; $5413
	farcall FarPtr_SetActorFacing ; $5415
	ld bc, $00f0 ; $5418
	farcall FarPtr_0a_38 ; $541b
	xor a, a ; $541e
	ld bc, $1800 ; $541f
	ld de, $0f00 ; $5422
	farcall FarPtr_MovePlayerToPosition ; $5425
	farcall FarPtr_WaitPlayerMoveDone ; $5428
	ld c, $08 ; $542b
	call BeginFadeIn ; $542d
	call WaitFadeEnd ; $5430
	call Func_15_6179 ; $5433
	ret ; $5436
Label_15_5437:
	xor a, a ; $5437
	ld [$c2d5], a ; $5438
	ld bc, $00f0 ; $543b
	farcall FarPtr_0a_38 ; $543e
	ld a, $00 ; $5441
	ld bc, $1300 ; $5443
	ld de, $1300 ; $5446
	farcall FarPtr_ScriptSetActorPosition ; $5449
	ld a, $02 ; $544c
	ld bc, $1300 ; $544e
	ld de, $1100 ; $5451
	farcall FarPtr_ScriptSetActorPosition ; $5454
	xor a, a ; $5457
	ld bc, $1300 ; $5458
	ld de, $1300 ; $545b
	farcall FarPtr_MovePlayerToPosition ; $545e
	farcall FarPtr_WaitPlayerMoveDone ; $5461
	ld a, $00 ; $5464
	ld b, $40 ; $5466
	farcall FarPtr_SetActorFacing ; $5468
	ld a, $02 ; $546b
	ld b, $40 ; $546d
	farcall FarPtr_SetActorFacing ; $546f
	ld a, $07 ; $5472
	ld b, $80 ; $5474
	farcall FarPtr_SetActorFacing ; $5476
	ld c, $04 ; $5479
	call BeginFadeIn ; $547b
	call WaitFadeEnd ; $547e
	ret ; $5481
Label_15_5482:
	xor a, a ; $5482
	ld [$c2d5], a ; $5483
	ld a, $11 ; $5486
	ld [$c2b1], a ; $5488
	ld a, $00 ; $548b
	ld bc, $2800 ; $548d
	ld de, $2a00 ; $5490
	farcall FarPtr_ScriptSetActorPosition ; $5493
	ld a, $00 ; $5496
	ld b, $c0 ; $5498
	farcall FarPtr_SetActorFacing ; $549a
	ld a, [$c2b1] ; $549d
	ld bc, $2800 ; $54a0
	ld de, $2500 ; $54a3
	farcall FarPtr_ScriptSetActorPosition ; $54a6
	ld a, [$c2b1] ; $54a9
	ld b, $40 ; $54ac
	farcall FarPtr_SetActorFacing ; $54ae
	ld a, $02 ; $54b1
	farcall FarPtr_0a_1c ; $54b3
	ld a, $02 ; $54b6
	ld bc, $2d00 ; $54b8
	ld de, $2d00 ; $54bb
	farcall FarPtr_ScriptSetActorPosition ; $54be
	ld a, $02 ; $54c1
	ld b, $80 ; $54c3
	farcall FarPtr_SetActorFacing ; $54c5
	ld bc, $00f0 ; $54c8
	farcall FarPtr_0a_38 ; $54cb
	xor a, a ; $54ce
	ld bc, $2800 ; $54cf
	ld de, $2900 ; $54d2
	farcall FarPtr_MovePlayerToPosition ; $54d5
	farcall FarPtr_WaitPlayerMoveDone ; $54d8
	ld c, $08 ; $54db
	call BeginFadeIn ; $54dd
	call WaitFadeEnd ; $54e0
	call Func_15_6179 ; $54e3
	ret ; $54e6
Label_15_54e7:
	xor a, a ; $54e7
	ld [$c2d5], a ; $54e8
	ld bc, $00f0 ; $54eb
	farcall FarPtr_0a_38 ; $54ee
	ld a, $00 ; $54f1
	ld bc, $2d00 ; $54f3
	ld de, $2b00 ; $54f6
	farcall FarPtr_ScriptSetActorPosition ; $54f9
	ld a, $02 ; $54fc
	ld bc, $2f00 ; $54fe
	ld de, $2b00 ; $5501
	farcall FarPtr_ScriptSetActorPosition ; $5504
	xor a, a ; $5507
	ld bc, $2d00 ; $5508
	ld de, $2b00 ; $550b
	farcall FarPtr_MovePlayerToPosition ; $550e
	farcall FarPtr_WaitPlayerMoveDone ; $5511
	ld a, $00 ; $5514
	ld b, $c0 ; $5516
	farcall FarPtr_SetActorFacing ; $5518
	ld a, $02 ; $551b
	ld b, $c0 ; $551d
	farcall FarPtr_SetActorFacing ; $551f
	ld a, $12 ; $5522
	ld b, $00 ; $5524
	farcall FarPtr_SetActorFacing ; $5526
	ld c, $04 ; $5529
	call BeginFadeIn ; $552b
	call WaitFadeEnd ; $552e
	ret ; $5531
Label_15_5532:
	xor a, a ; $5532
	ld [$c2d5], a ; $5533
	ld a, $0c ; $5536
	ld [$c2b1], a ; $5538
	ld a, $00 ; $553b
	ld bc, $1800 ; $553d
	ld de, $2a00 ; $5540
	farcall FarPtr_ScriptSetActorPosition ; $5543
	ld a, $00 ; $5546
	ld b, $c0 ; $5548
	farcall FarPtr_SetActorFacing ; $554a
	ld a, [$c2b1] ; $554d
	ld bc, $1800 ; $5550
	ld de, $2500 ; $5553
	farcall FarPtr_ScriptSetActorPosition ; $5556
	ld a, [$c2b1] ; $5559
	ld b, $40 ; $555c
	farcall FarPtr_SetActorFacing ; $555e
	ld a, $02 ; $5561
	farcall FarPtr_0a_1c ; $5563
	ld a, $02 ; $5566
	ld bc, $1300 ; $5568
	ld de, $2d00 ; $556b
	farcall FarPtr_ScriptSetActorPosition ; $556e
	ld a, $02 ; $5571
	ld b, $00 ; $5573
	farcall FarPtr_SetActorFacing ; $5575
	ld bc, $00f0 ; $5578
	farcall FarPtr_0a_38 ; $557b
	xor a, a ; $557e
	ld bc, $1800 ; $557f
	ld de, $2800 ; $5582
	farcall FarPtr_MovePlayerToPosition ; $5585
	farcall FarPtr_WaitPlayerMoveDone ; $5588
	ld c, $08 ; $558b
	call BeginFadeIn ; $558d
	call WaitFadeEnd ; $5590
	call Func_15_6179 ; $5593
	ret ; $5596
Label_15_5597:
	xor a, a ; $5597
	ld [$c2d5], a ; $5598
	ld bc, $00f0 ; $559b
	farcall FarPtr_0a_38 ; $559e
	ld a, $00 ; $55a1
	ld bc, $1300 ; $55a3
	ld de, $2b00 ; $55a6
	farcall FarPtr_ScriptSetActorPosition ; $55a9
	ld a, $02 ; $55ac
	ld bc, $1100 ; $55ae
	ld de, $2b00 ; $55b1
	farcall FarPtr_ScriptSetActorPosition ; $55b4
	xor a, a ; $55b7
	ld bc, $1300 ; $55b8
	ld de, $2b00 ; $55bb
	farcall FarPtr_MovePlayerToPosition ; $55be
	farcall FarPtr_WaitPlayerMoveDone ; $55c1
	ld a, $00 ; $55c4
	ld b, $c0 ; $55c6
	farcall FarPtr_SetActorFacing ; $55c8
	ld a, $02 ; $55cb
	ld b, $c0 ; $55cd
	farcall FarPtr_SetActorFacing ; $55cf
	ld a, $0d ; $55d2
	ld b, $c0 ; $55d4
	farcall FarPtr_SetActorFacing ; $55d6
	ld c, $04 ; $55d9
	call BeginFadeIn ; $55db
	call WaitFadeEnd ; $55de
	ret ; $55e1
	INCBIN "data/bank_015/d_55e2.bin" ; $55e2, 14 bytes
	ldh a, [hInputRisingEdge] ; $55f0
	and a, $03 ; $55f2
	ld d, a ; $55f4
	ld hl, $c2b8 ; $55f5
	ld a, [hl] ; $55f8
	or a, a ; $55f9
	ld [hl], d ; $55fa
	jr nz, Label_15_562d ; $55fb
	ld a, d ; $55fd
	or a, a ; $55fe
	jr z, Label_15_562d ; $55ff
	ld hl, wWaterSpriteMinigameSwingCount ; $5601
	ld a, [hl+] ; $5604
	ld d, [hl] ; $5605
	ld e, a ; $5606
	inc de ; $5607
	ld hl, wWaterSpriteMinigameSwingCount ; $5608
	ld a, e ; $560b
	ld [hl+], a ; $560c
	ld [hl], d ; $560d
	push hl ; $560e
	push de ; $560f
	ld h, d ; $5610
	ld l, e ; $5611
	ld de, $0f04 ; $5612
	call PrintHexWord ; $5615
	pop de ; $5618
	pop hl ; $5619
	ld a, [$c2b9] ; $561a
	cp a, $02 ; $561d
	jr z, Label_15_5628 ; $561f
	ld a, $02 ; $5621
	ld [$c2b9], a ; $5623
	jr Label_15_562d ; $5626
Label_15_5628:
	ld a, $01 ; $5628
	ld [$c2b9], a ; $562a
Label_15_562d:
	ld hl, wWaterSpriteMinigameTimer ; $562d
	ld a, [hl+] ; $5630
	ld d, [hl] ; $5631
	ld e, a ; $5632
	dec de ; $5633
	ld a, d ; $5634
	or a, e ; $5635
	jr z, Label_15_563f ; $5636
	ld hl, wWaterSpriteMinigameTimer ; $5638
	ld a, e ; $563b
	ld [hl+], a ; $563c
	ld [hl], d ; $563d
	ret ; $563e
Label_15_563f:
	ld hl, $55f0 ; $563f
	call UnregisterFrameTask ; $5642
	xor a, a ; $5645
	ld [$c2b9], a ; $5646
	ret ; $5649
Func_15_564a:
	ld de, $a100 ; $564a
	ld b, $0a ; $564d
	ld c, $01 ; $564f
	farcall FarPtr_39_64 ; $5651
	ld a, $0a ; $5654
	ld [$cb6c], a ; $5656
	ld a, $10 ; $5659
	ld [$cb6b], a ; $565b
	call Func_15_58e4 ; $565e
	ld a, $00 ; $5661
	ld b, $40 ; $5663
	farcall FarPtr_SetActorFacing ; $5665
	ld b, $20 ; $5668
	ld e, $10 ; $566a
Label_15_566c:
	ld a, $20 ; $566c
	sub a, b ; $566e
	ld d, a ; $566f
	ld hl, $000a ; $5670
	farcall FarPtr_39_66 ; $5673
	ld a, $18 ; $5676
	sub a, b ; $5678
	ld [wWaterSpriteMinigameFlag], a ; $5679
	ld a, $80 ; $567c
	add a, b ; $567e
	ld d, a ; $567f
	ld hl, $0000 ; $5680
	farcall FarPtr_39_66 ; $5683
	ld a, $74 ; $5686
	add a, b ; $5688
	ld [$c2bb], a ; $5689
	push af ; $568c
	ld a, $01 ; $568d
	farcall FarPtr_WaitScriptFrames ; $568f
	pop af ; $5692
	dec b ; $5693
	jp nz, Label_15_566c ; $5694
	ld de, $0258 ; $5697
	ld hl, wWaterSpriteMinigameTimer ; $569a
	ld a, e ; $569d
	ld [hl+], a ; $569e
	ld [hl], d ; $569f
	ld hl, wWaterSpriteMinigameSwingCount ; $56a0
	xor a, a ; $56a3
	ld [hl+], a ; $56a4
	ld [hl+], a ; $56a5
	ld [hl+], a ; $56a6
	ld [hl+], a ; $56a7
	ld a, $01 ; $56a8
	ld [$c2b9], a ; $56aa
	ld a, $01 ; $56ad
	ld hl, $578d ; $56af
	call RegisterFrameTask ; $56b2
	push af ; $56b5
	ld a, $32 ; $56b6
	farcall FarPtr_WaitScriptFrames ; $56b8
	pop af ; $56bb
	ld l, $03 ; $56bc
	ld h, $00 ; $56be
	ld de, $502c ; $56c0
Label_15_56c3:
	sound $8c ; $56c3
	ld b, $3c ; $56c5
Label_15_56c7:
	farcall FarPtr_39_66 ; $56c7
	push af ; $56ca
	ld a, $01 ; $56cb
	farcall FarPtr_WaitScriptFrames ; $56cd
	pop af ; $56d0
	dec b ; $56d1
	jp nz, Label_15_56c7 ; $56d2
	dec l ; $56d5
	jp nz, Label_15_56c3 ; $56d6
	sound $75 ; $56d9
	call Func_15_5777 ; $56db
	ld a, $01 ; $56de
	ld hl, $55f0 ; $56e0
	call RegisterFrameTask ; $56e3
Label_15_56e6:
	call AdvanceFrame ; $56e6
	ld a, [$c2b9] ; $56e9
	cp a, $00 ; $56ec
	jr z, Label_15_5708 ; $56ee
	cp a, $01 ; $56f0
	jr z, Label_15_56fe ; $56f2
	ld a, $09 ; $56f4
	ld d, a ; $56f6
	ld a, $00 ; $56f7
	farcall FarPtr_ScriptSetActorAnimation ; $56f9
	jr Label_15_56e6 ; $56fc
Label_15_56fe:
	ld a, $0a ; $56fe
	ld d, a ; $5700
	ld a, $00 ; $5701
	farcall FarPtr_ScriptSetActorAnimation ; $5703
	jr Label_15_56e6 ; $5706
Label_15_5708:
	sound $8d ; $5708
	ld a, $00 ; $570a
	ld d, $02 ; $570c
	farcall FarPtr_ScriptSetActorAnimation ; $570e
	ld a, $00 ; $5711
	farcall FarPtr_ScriptWaitActorIdle ; $5713
	push af ; $5716
	ld a, $3c ; $5717
	farcall FarPtr_WaitScriptFrames ; $5719
	pop af ; $571c
	call Func_15_5777 ; $571d
	ld hl, $578d ; $5720
	call UnregisterFrameTask ; $5723
	ld b, $30 ; $5726
	ld e, $10 ; $5728
Label_15_572a:
	ld a, b ; $572a
	sub a, $10 ; $572b
	ld d, a ; $572d
	ld hl, $0000 ; $572e
	farcall FarPtr_39_66 ; $5731
	ld a, $e8 ; $5734
	add a, b ; $5736
	ld [wWaterSpriteMinigameFlag], a ; $5737
	ld a, $b0 ; $573a
	sub a, b ; $573c
	ld d, a ; $573d
	ld hl, wWaterSpriteMinigameSwingCount ; $573e
	ld a, [hl+] ; $5741
	ld h, [hl] ; $5742
	ld l, a ; $5743
	farcall FarPtr_39_66 ; $5744
	ld a, $a4 ; $5747
	sub a, b ; $5749
	ld [$c2bb], a ; $574a
	push af ; $574d
	ld a, $01 ; $574e
	farcall FarPtr_WaitScriptFrames ; $5750
	pop af ; $5753
	dec b ; $5754
	jp nz, Label_15_572a ; $5755
	ld hl, $58d1 ; $5758
	call UnregisterFrameTask ; $575b
	call WaitFramesCmd ; $575e
	db $3c ; $5761 inline arg
	ld hl, $1aa4 ; $5762
	farcall FarPtr_0a_0e ; $5765
	ld hl, wWaterSpriteMinigameSwingCount ; $5768
	ld a, [hl+] ; $576b
	ld h, [hl] ; $576c
	ld l, a ; $576d
	farcall FarPtr_PushTextArgNumber ; $576e
	ld a, $00 ; $5771
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5773
	ret ; $5776
Func_15_5777:
	ld a, [$c90e] ; $5777
	and a, a ; $577a
	jr z, Label_15_578c ; $577b
	ld a, $00 ; $577d
	farcall FarPtr_GetActorStateAddr ; $577f
	ld c, l ; $5782
	ld b, h ; $5783
	ld hl, $0037 ; $5784
	add hl, bc ; $5787
	ld a, [hl] ; $5788
	xor a, $20 ; $5789
	ld [hl], a ; $578b
Label_15_578c:
	ret ; $578c
	ld hl, wWaterSpriteMinigameTimer ; $578d
	ld a, [hl+] ; $5790
	ld h, [hl] ; $5791
	ld l, a ; $5792
	ld a, $00 ; $5793
	ld e, $3c ; $5795
	call DivAHLByE ; $5797
	ld de, $2010 ; $579a
	farcall FarPtr_39_66 ; $579d
	ld hl, wWaterSpriteMinigameSwingCount ; $57a0
	ld a, [hl+] ; $57a3
	ld h, [hl] ; $57a4
	ld l, a ; $57a5
	ld de, $8010 ; $57a6
	farcall FarPtr_39_66 ; $57a9
	ret ; $57ac
	INCBIN "data/bank_015/d_57ad.bin" ; $57ad, 235 bytes
Func_15_5898:
	ldh a, [hWramBank] ; $5898
	push af ; $589a
	wram_bank $01 ; $589b
	ld hl, $57d0 ; $58a1
	ld de, $a000 ; $58a4
	ld c, $0c ; $58a7
	call QueueVRAMCopy ; $58a9
	ld hl, $5890 ; $58ac
	ld de, $0802 ; $58af
	call LoadPaletteShadow ; $58b2
	pop af ; $58b5
	wram_bank ; $58b6
	ret ; $58ba
Func_15_58bb:
	ld hl, $57ad ; $58bb
	ld c, $00 ; $58be
	ld b, $08 ; $58c0
	call QueueSpriteTemplate ; $58c2
	ret ; $58c5
Func_15_58c6:
	ld hl, $57ba ; $58c6
	ld c, $06 ; $58c9
	ld b, $08 ; $58cb
	call QueueSpriteTemplate ; $58cd
	ret ; $58d0
	ld a, [wWaterSpriteMinigameFlag] ; $58d1
	ld d, a ; $58d4
	ld e, $18 ; $58d5
	call Func_15_58bb ; $58d7
	ld a, [$c2bb] ; $58da
	ld d, a ; $58dd
	ld e, $18 ; $58de
	call Func_15_58c6 ; $58e0
	ret ; $58e3
Func_15_58e4:
	call Func_15_5898 ; $58e4
	ld a, $e8 ; $58e7
	ld [wWaterSpriteMinigameFlag], a ; $58e9
	ld a, $a0 ; $58ec
	ld [$c2bb], a ; $58ee
	ld a, $01 ; $58f1
	ld hl, $58d1 ; $58f3
	call RegisterFrameTask ; $58f6
	ret ; $58f9
	INCBIN "data/bank_015/d_58fa.bin" ; $58fa, 198 bytes
Func_15_59c0:
	xor a, a ; $59c0
	ld [$c2d5], a ; $59c1
	ldh a, [hRomBank] ; $59c4
	ld hl, $5c4f ; $59c6
	farcall FarPtr_0a_06 ; $59c9
	farcall FarPtr_0a_00 ; $59cc
	ld a, $00 ; $59cf
	ld bc, $3f00 ; $59d1
	ld de, $3f00 ; $59d4
	farcall FarPtr_ScriptSetActorPosition ; $59d7
	ld a, $0d ; $59da
	ld bc, $3f00 ; $59dc
	ld de, $3f00 ; $59df
	farcall FarPtr_ScriptSetActorPosition ; $59e2
	ld a, $0d ; $59e5
	ld bc, $0700 ; $59e7
	ld de, $36c0 ; $59ea
	farcall FarPtr_ScriptSetActorPosition ; $59ed
	ld a, $0d ; $59f0
	ld bc, $1f00 ; $59f2
	ld de, $36c0 ; $59f5
	farcall FarPtr_ScriptSetActorMoveTarget ; $59f8
	push af ; $59fb
	ld a, $0a ; $59fc
	farcall FarPtr_WaitScriptFrames ; $59fe
	pop af ; $5a01
	ld a, $00 ; $5a02
	ld bc, $0500 ; $5a04
	ld de, $3700 ; $5a07
	farcall FarPtr_ScriptSetActorPosition ; $5a0a
	ld a, $00 ; $5a0d
	ld bc, $1f00 ; $5a0f
	ld de, $3700 ; $5a12
	farcall FarPtr_ScriptSetActorMoveTarget ; $5a15
	xor a, a ; $5a18
	ld bc, $1f00 ; $5a19
	ld de, $3700 ; $5a1c
	farcall FarPtr_MovePlayerToPosition ; $5a1f
	ld c, $04 ; $5a22
	call BeginFadeIn ; $5a24
	call WaitFadeEnd ; $5a27
	ld a, $0d ; $5a2a
	farcall FarPtr_ScriptWaitActorMoveDone ; $5a2c
	ld a, $0d ; $5a2f
	ld bc, $1f00 ; $5a31
	ld de, $2b00 ; $5a34
	farcall FarPtr_ScriptSetActorMoveTarget ; $5a37
	ld a, $00 ; $5a3a
	farcall FarPtr_ScriptWaitActorMoveDone ; $5a3c
	ld a, $00 ; $5a3f
	ld bc, $1f00 ; $5a41
	ld de, $2d00 ; $5a44
	farcall FarPtr_ScriptSetActorMoveTarget ; $5a47
	farcall FarPtr_WaitPlayerMoveDone ; $5a4a
	xor a, a ; $5a4d
	ld bc, $1f00 ; $5a4e
	ld de, $2d00 ; $5a51
	farcall FarPtr_MovePlayerToPosition ; $5a54
	farcall FarPtr_WaitPlayerMoveDone ; $5a57
	push af ; $5a5a
	ld a, $3c ; $5a5b
	farcall FarPtr_WaitScriptFrames ; $5a5d
	pop af ; $5a60
	ld a, $0d ; $5a61
	ld b, $00 ; $5a63
	farcall FarPtr_SetActorFacing ; $5a65
	push af ; $5a68
	ld a, $3c ; $5a69
	farcall FarPtr_WaitScriptFrames ; $5a6b
	pop af ; $5a6e
	ld a, $0d ; $5a6f
	ld b, $80 ; $5a71
	farcall FarPtr_SetActorFacing ; $5a73
	push af ; $5a76
	ld a, $3c ; $5a77
	farcall FarPtr_WaitScriptFrames ; $5a79
	pop af ; $5a7c
	ld a, $0d ; $5a7d
	ld b, $40 ; $5a7f
	farcall FarPtr_SetActorFacing ; $5a81
	push af ; $5a84
	ld a, $3c ; $5a85
	farcall FarPtr_WaitScriptFrames ; $5a87
	pop af ; $5a8a
	ld a, $0d ; $5a8b
	ld b, $00 ; $5a8d
	farcall FarPtr_SetActorFacing ; $5a8f
	ld bc, $0040 ; $5a92
	farcall FarPtr_0a_38 ; $5a95
	ld hl, $1a73 ; $5a98
	farcall FarPtr_0a_0e ; $5a9b
	ld a, $0d ; $5a9e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5aa0
	ld a, $00 ; $5aa3
	ld d, $03 ; $5aa5
	farcall FarPtr_ScriptSetActorAnimation ; $5aa7
	ld a, $00 ; $5aaa
	farcall FarPtr_ScriptWaitActorIdle ; $5aac
	ld a, $00 ; $5aaf
	ld b, $00 ; $5ab1
	farcall FarPtr_SetActorFacing ; $5ab3
	xor a, a ; $5ab6
	ld bc, $2d00 ; $5ab7
	ld de, $2900 ; $5aba
	farcall FarPtr_MovePlayerToPosition ; $5abd
	farcall FarPtr_WaitPlayerMoveDone ; $5ac0
	ld a, $0d ; $5ac3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5ac5
	push af ; $5ac8
	ld a, $3c ; $5ac9
	farcall FarPtr_WaitScriptFrames ; $5acb
	pop af ; $5ace
	ld a, $00 ; $5acf
	ld b, a ; $5ad1
	ld a, $0d ; $5ad2
	farcall FarPtr_FaceActorTowardActor ; $5ad4
	xor a, a ; $5ad7
	ld bc, $1f00 ; $5ad8
	ld de, $2d00 ; $5adb
	farcall FarPtr_MovePlayerToPosition ; $5ade
	farcall FarPtr_WaitPlayerMoveDone ; $5ae1
	ld a, $00 ; $5ae4
	ld d, $03 ; $5ae6
	farcall FarPtr_ScriptSetActorAnimation ; $5ae8
	ld a, $00 ; $5aeb
	farcall FarPtr_ScriptWaitActorIdle ; $5aed
	ld a, $0d ; $5af0
	ld b, $80 ; $5af2
	farcall FarPtr_SetActorFacing ; $5af4
	push af ; $5af7
	ld a, $28 ; $5af8
	farcall FarPtr_WaitScriptFrames ; $5afa
	pop af ; $5afd
	ld a, $00 ; $5afe
	ld b, $80 ; $5b00
	farcall FarPtr_SetActorFacing ; $5b02
	ld a, $0d ; $5b05
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5b07
	ld a, $0b ; $5b0a
	ld b, $00 ; $5b0c
	farcall FarPtr_MovePlayerToActor ; $5b0e
	farcall FarPtr_WaitPlayerMoveDone ; $5b11
	push af ; $5b14
	ld a, $3c ; $5b15
	farcall FarPtr_WaitScriptFrames ; $5b17
	pop af ; $5b1a
	ld a, $00 ; $5b1b
	ld b, a ; $5b1d
	ld a, $0d ; $5b1e
	farcall FarPtr_FaceActorTowardActor ; $5b20
	ld a, $0d ; $5b23
	ld b, $00 ; $5b25
	farcall FarPtr_MovePlayerToActor ; $5b27
	farcall FarPtr_WaitPlayerMoveDone ; $5b2a
	ld a, $00 ; $5b2d
	ld d, $03 ; $5b2f
	farcall FarPtr_ScriptSetActorAnimation ; $5b31
	ld a, $00 ; $5b34
	farcall FarPtr_ScriptWaitActorIdle ; $5b36
	ld a, $0d ; $5b39
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5b3b
	ld a, $0d ; $5b3e
	ld b, a ; $5b40
	ld a, $00 ; $5b41
	farcall FarPtr_FaceActorTowardActor ; $5b43
	ld a, $00 ; $5b46
	ld d, $02 ; $5b48
	farcall FarPtr_ScriptSetActorAnimation ; $5b4a
	ld a, $00 ; $5b4d
	farcall FarPtr_ScriptWaitActorIdle ; $5b4f
	ld a, $0d ; $5b52
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5b54
	ld a, $00 ; $5b57
	ld d, $03 ; $5b59
	farcall FarPtr_ScriptSetActorAnimation ; $5b5b
	ld a, $00 ; $5b5e
	farcall FarPtr_ScriptWaitActorIdle ; $5b60
	ld a, $0d ; $5b63
	ld d, $03 ; $5b65
	farcall FarPtr_ScriptSetActorAnimation ; $5b67
	ld a, $0d ; $5b6a
	farcall FarPtr_ScriptWaitActorIdle ; $5b6c
	ld a, $0d ; $5b6f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5b71
	ld a, $00 ; $5b74
	ld d, $03 ; $5b76
	farcall FarPtr_ScriptSetActorAnimation ; $5b78
	ld a, $00 ; $5b7b
	farcall FarPtr_ScriptWaitActorIdle ; $5b7d
	ld bc, $0020 ; $5b80
	farcall FarPtr_0a_38 ; $5b83
	ld a, $00 ; $5b86
	ld b, $80 ; $5b88
	farcall FarPtr_SetActorFacing ; $5b8a
	ld a, $0d ; $5b8d
	ld bc, $1e00 ; $5b8f
	ld de, $2b00 ; $5b92
	farcall FarPtr_ScriptSetActorMoveTarget ; $5b95
	ld a, $0d ; $5b98
	farcall FarPtr_ScriptWaitActorMoveDone ; $5b9a
	ld a, $00 ; $5b9d
	ld b, $01 ; $5b9f
	farcall FarPtr_0a_2c ; $5ba1
	ld a, $00 ; $5ba4
	ld bc, $2000 ; $5ba6
	ld de, $2d00 ; $5ba9
	farcall FarPtr_ScriptSetActorMoveTarget ; $5bac
	ld a, $0d ; $5baf
	ld bc, $1e00 ; $5bb1
	ld de, $2f00 ; $5bb4
	farcall FarPtr_ScriptSetActorMoveTarget ; $5bb7
	ld a, $0d ; $5bba
	farcall FarPtr_ScriptWaitActorMoveDone ; $5bbc
	ld a, $00 ; $5bbf
	ld bc, $1f00 ; $5bc1
	ld de, $2d00 ; $5bc4
	farcall FarPtr_ScriptSetActorMoveTarget ; $5bc7
	ld a, $00 ; $5bca
	farcall FarPtr_ScriptWaitActorMoveDone ; $5bcc
	ld a, $00 ; $5bcf
	ld b, $00 ; $5bd1
	farcall FarPtr_0a_2c ; $5bd3
	ld a, $0d ; $5bd6
	ld bc, $1f00 ; $5bd8
	ld de, $2f00 ; $5bdb
	farcall FarPtr_ScriptSetActorMoveTarget ; $5bde
	ld a, $0d ; $5be1
	farcall FarPtr_ScriptWaitActorMoveDone ; $5be3
	ld a, $00 ; $5be6
	ld bc, $1f00 ; $5be8
	ld de, $3700 ; $5beb
	farcall FarPtr_ScriptSetActorMoveTarget ; $5bee
	xor a, a ; $5bf1
	ld bc, $1f00 ; $5bf2
	ld de, $3700 ; $5bf5
	farcall FarPtr_MovePlayerToPosition ; $5bf8
	ld a, $0d ; $5bfb
	ld bc, $1f00 ; $5bfd
	ld de, $3700 ; $5c00
	farcall FarPtr_ScriptSetActorMoveTarget ; $5c03
	ld a, $0d ; $5c06
	farcall FarPtr_ScriptWaitActorMoveDone ; $5c08
	ld a, $0d ; $5c0b
	ld bc, $0300 ; $5c0d
	ld de, $3700 ; $5c10
	farcall FarPtr_ScriptSetActorMoveTarget ; $5c13
	xor a, a ; $5c16
	ld bc, $0900 ; $5c17
	ld de, $3700 ; $5c1a
	farcall FarPtr_MovePlayerToPosition ; $5c1d
	ld a, $00 ; $5c20
	farcall FarPtr_ScriptWaitActorMoveDone ; $5c22
	ld a, $00 ; $5c25
	ld bc, $0300 ; $5c27
	ld de, $3700 ; $5c2a
	farcall FarPtr_ScriptSetActorMoveTarget ; $5c2d
	push af ; $5c30
	ld a, $5a ; $5c31
	farcall FarPtr_WaitScriptFrames ; $5c33
	pop af ; $5c36
	ld c, $08 ; $5c37
	call BeginFadeOut ; $5c39
	push af ; $5c3c
	ld a, $14 ; $5c3d
	farcall FarPtr_WaitScriptFrames ; $5c3f
	pop af ; $5c42
	ld a, $0f ; $5c43
	ld [$c294], a ; $5c45
	ld [$c2a1], a ; $5c48
	farcall FarPtr_0a_02 ; $5c4b
	ret ; $5c4e
	; $5c4f, 164 bytes (bytes:14)
	db $00, $00, $e6, $55, $00, $33, $00, $2a, $c0, $00, $39, $01, $06, $00 ; 0x00
	db $00, $00, $e6, $55, $00, $35, $00, $23, $40, $00, $32, $01, $03, $00 ; 0x0e
	db $00, $00, $e6, $55, $00, $35, $00, $2a, $c0, $00, $34, $01, $07, $00 ; 0x1c
	db $00, $00, $6d, $7d, $00, $2d, $00, $21, $00, $00, $66, $01, $07, $00 ; 0x2a
	db $00, $00, $e6, $55, $00, $0b, $00, $23, $40, $00, $34, $01, $03, $00 ; 0x38
	db $00, $00, $e6, $55, $00, $0d, $00, $23, $40, $00, $39, $01, $05, $00 ; 0x46
	db $00, $00, $e6, $55, $00, $0c, $00, $29, $c0, $00, $33, $01, $04, $00 ; 0x54
	db $00, $00, $6d, $7d, $00, $13, $00, $27, $40, $00, $64, $01, $06, $00 ; 0x62
	db $00, $00, $6d, $7d, $00, $13, $00, $29, $c0, $00, $68, $01, $04, $00 ; 0x70
	db $00, $00, $6d, $7d, $00, $2d, $00, $29, $00, $00, $6b, $01, $07, $00 ; 0x7e
	db $00, $00, $6d, $7d, $00, $01, $00, $01, $40, $00, $49, $01, $00, $00 ; 0x8c
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x9a
Func_15_5cf3:
	xor a, a ; $5cf3
	ld [$c2d5], a ; $5cf4
	ld a, $06 ; $5cf7
	ld [$c2b1], a ; $5cf9
	ld a, $00 ; $5cfc
	ld bc, $1800 ; $5cfe
	ld de, $1100 ; $5d01
	farcall FarPtr_ScriptSetActorPosition ; $5d04
	ld a, $00 ; $5d07
	ld b, $c0 ; $5d09
	farcall FarPtr_SetActorFacing ; $5d0b
	ld a, [$c2b1] ; $5d0e
	ld bc, $1800 ; $5d11
	ld de, $0d00 ; $5d14
	farcall FarPtr_ScriptSetActorPosition ; $5d17
	ld a, [$c2b1] ; $5d1a
	ld b, $40 ; $5d1d
	farcall FarPtr_SetActorFacing ; $5d1f
	ld a, $02 ; $5d22
	farcall FarPtr_0a_1c ; $5d24
	ld a, $02 ; $5d27
	ld bc, $1300 ; $5d29
	ld de, $1100 ; $5d2c
	farcall FarPtr_ScriptSetActorPosition ; $5d2f
	ld a, $02 ; $5d32
	ld b, $00 ; $5d34
	farcall FarPtr_SetActorFacing ; $5d36
	ld bc, $00f0 ; $5d39
	farcall FarPtr_0a_38 ; $5d3c
	xor a, a ; $5d3f
	ld bc, $1800 ; $5d40
	ld de, $0f00 ; $5d43
	farcall FarPtr_MovePlayerToPosition ; $5d46
	farcall FarPtr_WaitPlayerMoveDone ; $5d49
	ld c, $08 ; $5d4c
	call BeginFadeIn ; $5d4e
	call WaitFadeEnd ; $5d51
	ld a, [wPointWinLoseFlag] ; $5d54
	inc a ; $5d57
	cp a, $01 ; $5d58
	jr nz, Label_15_5d69 ; $5d5a
	ld hl, $c2b2 ; $5d5c
	ld de, $201d ; $5d5f
	ld a, e ; $5d62
	ld [hl+], a ; $5d63
	ld [hl], d ; $5d64
	ld a, [wPointWinLoseFlag] ; $5d65
	inc a ; $5d68
Label_15_5d69:
	ld a, a ; $5d69
	rst Rst00 ; $5d6a
	dw Label_15_5f58 ; $5d6b jumptable
	dw Label_15_5f07 ; $5d6d jumptable
	dw Label_15_5fc2 ; $5d6f jumptable
	dw Label_15_5e74 ; $5d71 jumptable
	ret ; $5d73
Func_15_5d74:
	xor a, a ; $5d74
	ld [$c2d5], a ; $5d75
	ld a, $11 ; $5d78
	ld [$c2b1], a ; $5d7a
	ld a, $00 ; $5d7d
	ld bc, $2800 ; $5d7f
	ld de, $2a00 ; $5d82
	farcall FarPtr_ScriptSetActorPosition ; $5d85
	ld a, $00 ; $5d88
	ld b, $c0 ; $5d8a
	farcall FarPtr_SetActorFacing ; $5d8c
	ld a, [$c2b1] ; $5d8f
	ld bc, $2800 ; $5d92
	ld de, $2500 ; $5d95
	farcall FarPtr_ScriptSetActorPosition ; $5d98
	ld a, [$c2b1] ; $5d9b
	ld b, $40 ; $5d9e
	farcall FarPtr_SetActorFacing ; $5da0
	ld a, $02 ; $5da3
	farcall FarPtr_0a_1c ; $5da5
	ld a, $02 ; $5da8
	ld bc, $2d00 ; $5daa
	ld de, $2d00 ; $5dad
	farcall FarPtr_ScriptSetActorPosition ; $5db0
	ld a, $02 ; $5db3
	ld b, $80 ; $5db5
	farcall FarPtr_SetActorFacing ; $5db7
	ld bc, $00f0 ; $5dba
	farcall FarPtr_0a_38 ; $5dbd
	xor a, a ; $5dc0
	ld bc, $2800 ; $5dc1
	ld de, $2900 ; $5dc4
	farcall FarPtr_MovePlayerToPosition ; $5dc7
	farcall FarPtr_WaitPlayerMoveDone ; $5dca
	ld c, $08 ; $5dcd
	call BeginFadeIn ; $5dcf
	call WaitFadeEnd ; $5dd2
	ld a, [wPointWinLoseFlag] ; $5dd5
	inc a ; $5dd8
	cp a, $01 ; $5dd9
	jr nz, Label_15_5dea ; $5ddb
	ld hl, $c2b2 ; $5ddd
	ld de, $204a ; $5de0
	ld a, e ; $5de3
	ld [hl+], a ; $5de4
	ld [hl], d ; $5de5
	ld a, [wPointWinLoseFlag] ; $5de6
	inc a ; $5de9
Label_15_5dea:
	ld a, a ; $5dea
	rst Rst00 ; $5deb
	dw Label_15_5f58 ; $5dec jumptable
	dw Label_15_5f07 ; $5dee jumptable
	dw Label_15_5fc2 ; $5df0 jumptable
	ret ; $5df2
Func_15_5df3:
	xor a, a ; $5df3
	ld [$c2d5], a ; $5df4
	ld a, $0c ; $5df7
	ld [$c2b1], a ; $5df9
	ld a, $00 ; $5dfc
	ld bc, $1800 ; $5dfe
	ld de, $2a00 ; $5e01
	farcall FarPtr_ScriptSetActorPosition ; $5e04
	ld a, $00 ; $5e07
	ld b, $c0 ; $5e09
	farcall FarPtr_SetActorFacing ; $5e0b
	ld a, [$c2b1] ; $5e0e
	ld bc, $1800 ; $5e11
	ld de, $2500 ; $5e14
	farcall FarPtr_ScriptSetActorPosition ; $5e17
	ld a, [$c2b1] ; $5e1a
	ld b, $40 ; $5e1d
	farcall FarPtr_SetActorFacing ; $5e1f
	ld a, $02 ; $5e22
	farcall FarPtr_0a_1c ; $5e24
	ld a, $02 ; $5e27
	ld bc, $1300 ; $5e29
	ld de, $2d00 ; $5e2c
	farcall FarPtr_ScriptSetActorPosition ; $5e2f
	ld a, $02 ; $5e32
	ld b, $00 ; $5e34
	farcall FarPtr_SetActorFacing ; $5e36
	ld bc, $00f0 ; $5e39
	farcall FarPtr_0a_38 ; $5e3c
	xor a, a ; $5e3f
	ld bc, $1800 ; $5e40
	ld de, $2800 ; $5e43
	farcall FarPtr_MovePlayerToPosition ; $5e46
	farcall FarPtr_WaitPlayerMoveDone ; $5e49
	ld c, $08 ; $5e4c
	call BeginFadeIn ; $5e4e
	call WaitFadeEnd ; $5e51
	ld a, [wPointWinLoseFlag] ; $5e54
	inc a ; $5e57
	cp a, $01 ; $5e58
	jr nz, Label_15_5e69 ; $5e5a
	ld hl, $c2b2 ; $5e5c
	ld de, $2078 ; $5e5f
	ld a, e ; $5e62
	ld [hl+], a ; $5e63
	ld [hl], d ; $5e64
	ld a, [wPointWinLoseFlag] ; $5e65
	inc a ; $5e68
Label_15_5e69:
	ld a, a ; $5e69
	rst Rst00 ; $5e6a
	dw Label_15_5f58 ; $5e6b jumptable
	dw Label_15_5f07 ; $5e6d jumptable
	dw Label_15_5fc2 ; $5e6f jumptable
	dw Label_15_5e74 ; $5e71 jumptable
	ret ; $5e73
Label_15_5e74:
	ld a, $00 ; $5e74
	ld de, rLCDC ; $5e76
	farcall FarPtr_0a_42 ; $5e79
	ld a, $00 ; $5e7c
	farcall FarPtr_0a_44 ; $5e7e
	jp Label_15_5f58 ; $5e81
	ret ; $5e84
Label_15_5e85:
	ld hl, wWaterSpriteMinigameFlag ; $5e85
	ld de, $2020 ; $5e88
	ld a, e ; $5e8b
	ld [hl+], a ; $5e8c
	ld [hl], d ; $5e8d
	ld hl, wWaterSpriteMinigameTimer ; $5e8e
	ld de, $201d ; $5e91
	ld a, e ; $5e94
	ld [hl+], a ; $5e95
	ld [hl], d ; $5e96
	ld hl, wWaterSpriteMinigameSwingCount ; $5e97
	test_flag $0a, 3 ; $5e9a
	jr z, Label_15_5ea4 ; $5e9d
	ld de, $2023 ; $5e9f
	jr Label_15_5ea7 ; $5ea2
Label_15_5ea4:
	ld de, $2022 ; $5ea4
Label_15_5ea7:
	ld a, e ; $5ea7
	ld [hl+], a ; $5ea8
	ld [hl], d ; $5ea9
	ld hl, $c2b8 ; $5eaa
	ld de, $2024 ; $5ead
	ld a, e ; $5eb0
	ld [hl+], a ; $5eb1
	ld [hl], d ; $5eb2
	call Func_15_5cf3 ; $5eb3
	ret ; $5eb6
Label_15_5eb7:
	ld hl, wWaterSpriteMinigameFlag ; $5eb7
	ld de, $2020 ; $5eba
	ld a, e ; $5ebd
	ld [hl+], a ; $5ebe
	ld [hl], d ; $5ebf
	ld hl, wWaterSpriteMinigameTimer ; $5ec0
	ld de, $201d ; $5ec3
	ld a, e ; $5ec6
	ld [hl+], a ; $5ec7
	ld [hl], d ; $5ec8
	ld hl, wWaterSpriteMinigameSwingCount ; $5ec9
	ld de, $2031 ; $5ecc
	ld a, e ; $5ecf
	ld [hl+], a ; $5ed0
	ld [hl], d ; $5ed1
	ld hl, $c2b8 ; $5ed2
	ld de, $2032 ; $5ed5
	ld a, e ; $5ed8
	ld [hl+], a ; $5ed9
	ld [hl], d ; $5eda
	call Func_15_5cf3 ; $5edb
	ret ; $5ede
Label_15_5edf:
	ld hl, wWaterSpriteMinigameFlag ; $5edf
	ld de, $2020 ; $5ee2
	ld a, e ; $5ee5
	ld [hl+], a ; $5ee6
	ld [hl], d ; $5ee7
	ld hl, wWaterSpriteMinigameTimer ; $5ee8
	ld de, $201d ; $5eeb
	ld a, e ; $5eee
	ld [hl+], a ; $5eef
	ld [hl], d ; $5ef0
	ld hl, wWaterSpriteMinigameSwingCount ; $5ef1
	ld de, $203d ; $5ef4
	ld a, e ; $5ef7
	ld [hl+], a ; $5ef8
	ld [hl], d ; $5ef9
	ld hl, $c2b8 ; $5efa
	ld de, $203e ; $5efd
	ld a, e ; $5f00
	ld [hl+], a ; $5f01
	ld [hl], d ; $5f02
	call Func_15_5cf3 ; $5f03
	ret ; $5f06
Label_15_5f07:
	ld hl, wWaterSpriteMinigameTimer ; $5f07
	ld a, [hl+] ; $5f0a
	ld h, [hl] ; $5f0b
	ld l, a ; $5f0c
	farcall FarPtr_0a_0e ; $5f0d
	ld a, [$c2b1] ; $5f10
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5f13
	farcall FarPtr_0a_12 ; $5f16
	farcall FarPtr_ScriptCloseDialogueWindow ; $5f19
	push af ; $5f1c
	ld a, $05 ; $5f1d
	farcall FarPtr_WaitScriptFrames ; $5f1f
	pop af ; $5f22
	and a, a ; $5f23
	jr nz, Label_15_5f48 ; $5f24
	ld a, [$c2b1] ; $5f26
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5f29
	ld a, $0f ; $5f2c
	ld [wStoryModeCurrentLocation], a ; $5f2e
	ld a, $0a ; $5f31
	ld [$c295], a ; $5f33
	ld a, $ff ; $5f36
	ld [$c294], a ; $5f38
	ld [$c2a1], a ; $5f3b
	ld a, [$c8f7] ; $5f3e
	farcall FarPtr_0b_00 ; $5f41
	farcall FarPtr_0a_02 ; $5f44
	ret ; $5f47
Label_15_5f48:
	farcall FarPtr_0a_10 ; $5f48
	ld a, [$c2b1] ; $5f4b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5f4e
	call Func_15_6179 ; $5f51
	farcall FarPtr_0a_02 ; $5f54
	ret ; $5f57
Label_15_5f58:
	ld hl, wWaterSpriteMinigameSwingCount ; $5f58
	ld a, [hl+] ; $5f5b
	ld h, [hl] ; $5f5c
	ld l, a ; $5f5d
	farcall FarPtr_0a_0e ; $5f5e
	ld a, [$c2b1] ; $5f61
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5f64
	farcall FarPtr_0a_12 ; $5f67
	farcall FarPtr_ScriptCloseDialogueWindow ; $5f6a
	push af ; $5f6d
	ld a, $05 ; $5f6e
	farcall FarPtr_WaitScriptFrames ; $5f70
	pop af ; $5f73
	and a, a ; $5f74
	jr nz, Label_15_5fa2 ; $5f75
	ld hl, wWaterSpriteMinigameFlag ; $5f77
	ld a, [hl+] ; $5f7a
	ld h, [hl] ; $5f7b
	ld l, a ; $5f7c
	farcall FarPtr_0a_0e ; $5f7d
	ld a, [$c2b1] ; $5f80
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5f83
	ld a, $0f ; $5f86
	ld [wStoryModeCurrentLocation], a ; $5f88
	ld a, $0a ; $5f8b
	ld [$c295], a ; $5f8d
	ld a, $ff ; $5f90
	ld [$c294], a ; $5f92
	ld [$c2a1], a ; $5f95
	ld a, [$c8f7] ; $5f98
	farcall FarPtr_0b_00 ; $5f9b
	farcall FarPtr_0a_02 ; $5f9e
	ret ; $5fa1
Label_15_5fa2:
	ld hl, wWaterSpriteMinigameFlag ; $5fa2
	ld a, [hl+] ; $5fa5
	ld h, [hl] ; $5fa6
	ld l, a ; $5fa7
	farcall FarPtr_0a_0e ; $5fa8
	farcall FarPtr_0a_10 ; $5fab
	ld a, [$c2b1] ; $5fae
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5fb1
	call Func_15_6179 ; $5fb4
	farcall FarPtr_0a_02 ; $5fb7
	ret ; $5fba
	call Func_15_6179 ; $5fbb
	farcall FarPtr_0a_02 ; $5fbe
	ret ; $5fc1
Label_15_5fc2:
	ld a, [$c2b1] ; $5fc2
	ld d, $02 ; $5fc5
	farcall FarPtr_ScriptSetActorAnimation ; $5fc7
	ld a, [$c2b1] ; $5fca
	farcall FarPtr_ScriptWaitActorIdle ; $5fcd
	ld hl, $c2b8 ; $5fd0
	ld a, [hl+] ; $5fd3
	ld h, [hl] ; $5fd4
	ld l, a ; $5fd5
	farcall FarPtr_0a_0e ; $5fd6
	ld a, [$c2b1] ; $5fd9
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5fdc
	ld a, [$c2b1] ; $5fdf
	ld b, $01 ; $5fe2
	farcall FarPtr_0a_2c ; $5fe4
	ld a, [$c2b1] ; $5fe7
	ld b, $c0 ; $5fea
	ld de, $0100 ; $5fec
	farcall FarPtr_MoveActorByAngle ; $5fef
	ld a, [$c2b1] ; $5ff2
	farcall FarPtr_ScriptWaitActorMoveDone ; $5ff5
	push af ; $5ff8
	ld a, $28 ; $5ff9
	farcall FarPtr_WaitScriptFrames ; $5ffb
	pop af ; $5ffe
	ld a, [$c2b1] ; $5fff
	ld b, $c0 ; $6002
	ld de, $0100 ; $6004
	farcall FarPtr_MoveActorByAngle ; $6007
	ld a, [$c2b1] ; $600a
	farcall FarPtr_ScriptWaitActorMoveDone ; $600d
	ld a, [$c2b1] ; $6010
	ld d, $02 ; $6013
	farcall FarPtr_ScriptSetActorAnimation ; $6015
	ld a, [$c2b1] ; $6018
	farcall FarPtr_ScriptWaitActorIdle ; $601b
	ld a, [$c2b1] ; $601e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6021
	ld a, [$c2b1] ; $6024
	ld b, $00 ; $6027
	farcall FarPtr_0a_2c ; $6029
	call Func_15_6042 ; $602c
	ld a, [$c2b1] ; $602f
	ld bc, $3f00 ; $6032
	ld de, $3f00 ; $6035
	farcall FarPtr_ScriptSetActorPosition ; $6038
	call Func_15_6253 ; $603b
	farcall FarPtr_0a_02 ; $603e
	ret ; $6041
Func_15_6042:
	ld a, [$c8f7] ; $6042
	sub a, $0a ; $6045
	jp nc, Label_15_60f6 ; $6047
	ld a, [$c8f7] ; $604a
	sub a, $04 ; $604d
	jp c, Label_15_6056 ; $604f
	jp Label_15_60af ; $6052
	ret ; $6055
Label_15_6056:
	ld a, [$c2b1] ; $6056
	ld bc, $0030 ; $6059
	farcall FarPtr_0a_18 ; $605c
	ld a, [$c2b1] ; $605f
	farcall FarPtr_GetActorStateAddr ; $6062
	ld a, $04 ; $6065
	ld e, l ; $6067
	ld d, h ; $6068
	ld hl, $0018 ; $6069
	add hl, de ; $606c
	ld [hl], a ; $606d
	ld a, [$c2b1] ; $606e
	ld bc, $1f00 ; $6071
	ld de, $0b00 ; $6074
	farcall FarPtr_ScriptSetActorMoveTarget ; $6077
	ld a, [$c2b1] ; $607a
	farcall FarPtr_ScriptWaitActorMoveDone ; $607d
	ld a, [$c2b1] ; $6080
	ld bc, $1f00 ; $6083
	ld de, $1100 ; $6086
	farcall FarPtr_ScriptSetActorMoveTarget ; $6089
	ld a, [$c2b1] ; $608c
	farcall FarPtr_ScriptWaitActorMoveDone ; $608f
	ld a, $00 ; $6092
	ld b, $40 ; $6094
	farcall FarPtr_SetActorFacing ; $6096
	ld a, [$c2b1] ; $6099
	ld bc, $1f00 ; $609c
	ld de, $1f00 ; $609f
	farcall FarPtr_ScriptSetActorMoveTarget ; $60a2
	ld a, [$c2b1] ; $60a5
	farcall FarPtr_ScriptWaitActorMoveDone ; $60a8
	set_flag $17, 2 ; $60ab
	ret ; $60ae
Label_15_60af:
	ld a, [$c2b1] ; $60af
	ld bc, $0030 ; $60b2
	farcall FarPtr_0a_18 ; $60b5
	ld a, [$c2b1] ; $60b8
	farcall FarPtr_GetActorStateAddr ; $60bb
	ld a, $04 ; $60be
	ld e, l ; $60c0
	ld d, h ; $60c1
	ld hl, $0018 ; $60c2
	add hl, de ; $60c5
	ld [hl], a ; $60c6
	ld a, [$c2b1] ; $60c7
	ld bc, $2100 ; $60ca
	ld de, $2500 ; $60cd
	farcall FarPtr_ScriptSetActorMoveTarget ; $60d0
	ld a, [$c2b1] ; $60d3
	farcall FarPtr_ScriptWaitActorMoveDone ; $60d6
	ld a, $00 ; $60d9
	ld b, $40 ; $60db
	farcall FarPtr_SetActorFacing ; $60dd
	ld a, [$c2b1] ; $60e0
	ld bc, $1f00 ; $60e3
	ld de, $3500 ; $60e6
	farcall FarPtr_ScriptSetActorMoveTarget ; $60e9
	ld a, [$c2b1] ; $60ec
	farcall FarPtr_ScriptWaitActorMoveDone ; $60ef
	set_flag $17, 3 ; $60f2
	ret ; $60f5
Label_15_60f6:
	ld a, [$c2b1] ; $60f6
	ld b, $c0 ; $60f9
	farcall FarPtr_SetActorFacing ; $60fb
	ld a, [$c2b1] ; $60fe
	ld d, $02 ; $6101
	farcall FarPtr_ScriptSetActorAnimation ; $6103
	ld a, [$c2b1] ; $6106
	farcall FarPtr_ScriptWaitActorIdle ; $6109
	ld a, [$c2b1] ; $610c
	ld d, $02 ; $610f
	farcall FarPtr_ScriptSetActorAnimation ; $6111
	ld a, [$c2b1] ; $6114
	farcall FarPtr_ScriptWaitActorIdle ; $6117
	ld a, [$c2b1] ; $611a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $611d
	ld a, [$c2b1] ; $6120
	ld bc, $0030 ; $6123
	farcall FarPtr_0a_18 ; $6126
	ld a, [$c2b1] ; $6129
	farcall FarPtr_GetActorStateAddr ; $612c
	ld a, $04 ; $612f
	ld e, l ; $6131
	ld d, h ; $6132
	ld hl, $0018 ; $6133
	add hl, de ; $6136
	ld [hl], a ; $6137
	ld a, [$c2b1] ; $6138
	ld bc, $1f00 ; $613b
	ld de, $2500 ; $613e
	farcall FarPtr_ScriptSetActorMoveTarget ; $6141
	ld a, [$c2b1] ; $6144
	farcall FarPtr_ScriptWaitActorMoveDone ; $6147
	ld a, [$c2b1] ; $614a
	ld bc, $1f00 ; $614d
	ld de, $2900 ; $6150
	farcall FarPtr_ScriptSetActorMoveTarget ; $6153
	ld a, [$c2b1] ; $6156
	farcall FarPtr_ScriptWaitActorMoveDone ; $6159
	ld a, $00 ; $615c
	ld b, $40 ; $615e
	farcall FarPtr_SetActorFacing ; $6160
	ld a, [$c2b1] ; $6163
	ld bc, $1f00 ; $6166
	ld de, $3500 ; $6169
	farcall FarPtr_ScriptSetActorMoveTarget ; $616c
	ld a, [$c2b1] ; $616f
	farcall FarPtr_ScriptWaitActorMoveDone ; $6172
	set_flag $17, 4 ; $6175
	ret ; $6178
Func_15_6179:
	ld a, [$c8f7] ; $6179
	sub a, $0a ; $617c
	jr nc, Label_15_618b ; $617e
	ld a, [$c8f7] ; $6180
	sub a, $04 ; $6183
	jr c, Label_15_61d5 ; $6185
	jp Label_15_6214 ; $6187
	ret ; $618a
Label_15_618b:
	ld a, [$c2b1] ; $618b
	ld bc, $1300 ; $618e
	ld de, $2500 ; $6191
	farcall FarPtr_ScriptSetActorMoveTarget ; $6194
	ld a, [$c2b1] ; $6197
	farcall FarPtr_ScriptWaitActorMoveDone ; $619a
	ld a, [$c2b1] ; $619d
	ld bc, $1300 ; $61a0
	ld de, $2700 ; $61a3
	farcall FarPtr_ScriptSetActorMoveTarget ; $61a6
	ld a, $00 ; $61a9
	ld bc, $1300 ; $61ab
	ld de, $2b00 ; $61ae
	farcall FarPtr_ScriptSetActorMoveTarget ; $61b1
	ld a, $00 ; $61b4
	farcall FarPtr_ScriptWaitActorMoveDone ; $61b6
	ld a, $02 ; $61b9
	farcall FarPtr_GetActorStateAddr ; $61bb
	ld c, l ; $61be
	ld b, h ; $61bf
	ld de, $d000 ; $61c0
	farcall FarPtr_04_20 ; $61c3
	ld a, [$c2b1] ; $61c6
	farcall FarPtr_ScriptWaitActorMoveDone ; $61c9
	ld a, [$c2b1] ; $61cc
	ld b, $40 ; $61cf
	farcall FarPtr_SetActorFacing ; $61d1
	ret ; $61d4
Label_15_61d5:
	ld a, [$c2b1] ; $61d5
	ld bc, $1300 ; $61d8
	ld de, $0b00 ; $61db
	farcall FarPtr_ScriptSetActorMoveTarget ; $61de
	push af ; $61e1
	ld a, $1e ; $61e2
	farcall FarPtr_WaitScriptFrames ; $61e4
	pop af ; $61e7
	ld a, $00 ; $61e8
	ld bc, $1300 ; $61ea
	ld de, $1300 ; $61ed
	farcall FarPtr_ScriptSetActorMoveTarget ; $61f0
	ld a, $00 ; $61f3
	farcall FarPtr_ScriptWaitActorMoveDone ; $61f5
	ld a, $02 ; $61f8
	farcall FarPtr_GetActorStateAddr ; $61fa
	ld c, l ; $61fd
	ld b, h ; $61fe
	ld de, $d000 ; $61ff
	farcall FarPtr_04_20 ; $6202
	ld a, [$c2b1] ; $6205
	farcall FarPtr_ScriptWaitActorMoveDone ; $6208
	ld a, [$c2b1] ; $620b
	ld b, $00 ; $620e
	farcall FarPtr_SetActorFacing ; $6210
	ret ; $6213
Label_15_6214:
	ld a, [$c2b1] ; $6214
	ld bc, $2d00 ; $6217
	ld de, $2100 ; $621a
	farcall FarPtr_ScriptSetActorMoveTarget ; $621d
	push af ; $6220
	ld a, $1e ; $6221
	farcall FarPtr_WaitScriptFrames ; $6223
	pop af ; $6226
	ld a, $00 ; $6227
	ld bc, $2d00 ; $6229
	ld de, $2b00 ; $622c
	farcall FarPtr_ScriptSetActorMoveTarget ; $622f
	ld a, $00 ; $6232
	farcall FarPtr_ScriptWaitActorMoveDone ; $6234
	ld a, $02 ; $6237
	farcall FarPtr_GetActorStateAddr ; $6239
	ld c, l ; $623c
	ld b, h ; $623d
	ld de, $d000 ; $623e
	farcall FarPtr_04_20 ; $6241
	ld a, [$c2b1] ; $6244
	farcall FarPtr_ScriptWaitActorMoveDone ; $6247
	ld a, [$c2b1] ; $624a
	ld b, $00 ; $624d
	farcall FarPtr_SetActorFacing ; $624f
	ret ; $6252
Func_15_6253:
	ld a, [$c8f7] ; $6253
	sub a, $0a ; $6256
	jr nc, Label_15_6265 ; $6258
	ld a, [$c8f7] ; $625a
	sub a, $04 ; $625d
	jr c, Label_15_6283 ; $625f
	jp Label_15_62a1 ; $6261
	ret ; $6264
Label_15_6265:
	ld a, $00 ; $6265
	ld bc, $1300 ; $6267
	ld de, $2b00 ; $626a
	farcall FarPtr_ScriptSetActorMoveTarget ; $626d
	ld a, $00 ; $6270
	farcall FarPtr_ScriptWaitActorMoveDone ; $6272
	ld a, $02 ; $6275
	farcall FarPtr_GetActorStateAddr ; $6277
	ld c, l ; $627a
	ld b, h ; $627b
	ld de, $d000 ; $627c
	farcall FarPtr_04_20 ; $627f
	ret ; $6282
Label_15_6283:
	ld a, $00 ; $6283
	ld bc, $1300 ; $6285
	ld de, $1300 ; $6288
	farcall FarPtr_ScriptSetActorMoveTarget ; $628b
	ld a, $00 ; $628e
	farcall FarPtr_ScriptWaitActorMoveDone ; $6290
	ld a, $02 ; $6293
	farcall FarPtr_GetActorStateAddr ; $6295
	ld c, l ; $6298
	ld b, h ; $6299
	ld de, $d000 ; $629a
	farcall FarPtr_04_20 ; $629d
	ret ; $62a0
Label_15_62a1:
	ld a, $00 ; $62a1
	ld bc, $2d00 ; $62a3
	ld de, $2b00 ; $62a6
	farcall FarPtr_ScriptSetActorMoveTarget ; $62a9
	ld a, $00 ; $62ac
	farcall FarPtr_ScriptWaitActorMoveDone ; $62ae
	ld a, $02 ; $62b1
	farcall FarPtr_GetActorStateAddr ; $62b3
	ld c, l ; $62b6
	ld b, h ; $62b7
	ld de, $d000 ; $62b8
	farcall FarPtr_04_20 ; $62bb
	ret ; $62be
Label_15_62bf:
	ld hl, wWaterSpriteMinigameFlag ; $62bf
	ld de, $204d ; $62c2
	ld a, e ; $62c5
	ld [hl+], a ; $62c6
	ld [hl], d ; $62c7
	ld hl, wWaterSpriteMinigameTimer ; $62c8
	ld de, $204a ; $62cb
	ld a, e ; $62ce
	ld [hl+], a ; $62cf
	ld [hl], d ; $62d0
	test_flag $0a, 3 ; $62d1
	jr z, Label_15_62ea ; $62d4
	ld hl, wWaterSpriteMinigameSwingCount ; $62d6
	ld de, $2050 ; $62d9
	ld a, e ; $62dc
	ld [hl+], a ; $62dd
	ld [hl], d ; $62de
	ld hl, $c2b8 ; $62df
	ld de, $2053 ; $62e2
	ld a, e ; $62e5
	ld [hl+], a ; $62e6
	ld [hl], d ; $62e7
	jr Label_15_62fc ; $62e8
Label_15_62ea:
	ld hl, wWaterSpriteMinigameSwingCount ; $62ea
	ld de, $204f ; $62ed
	ld a, e ; $62f0
	ld [hl+], a ; $62f1
	ld [hl], d ; $62f2
	ld hl, $c2b8 ; $62f3
	ld de, $2051 ; $62f6
	ld a, e ; $62f9
	ld [hl+], a ; $62fa
	ld [hl], d ; $62fb
Label_15_62fc:
	call Func_15_5d74 ; $62fc
	ret ; $62ff
Label_15_6300:
	ld hl, wWaterSpriteMinigameFlag ; $6300
	ld de, $204d ; $6303
	ld a, e ; $6306
	ld [hl+], a ; $6307
	ld [hl], d ; $6308
	ld hl, wWaterSpriteMinigameTimer ; $6309
	ld de, $204a ; $630c
	ld a, e ; $630f
	ld [hl+], a ; $6310
	ld [hl], d ; $6311
	ld hl, wWaterSpriteMinigameSwingCount ; $6312
	ld de, $205f ; $6315
	ld a, e ; $6318
	ld [hl+], a ; $6319
	ld [hl], d ; $631a
	ld hl, $c2b8 ; $631b
	ld de, $2060 ; $631e
	ld a, e ; $6321
	ld [hl+], a ; $6322
	ld [hl], d ; $6323
	call Func_15_5d74 ; $6324
	ret ; $6327
Label_15_6328:
	ld hl, wWaterSpriteMinigameFlag ; $6328
	ld de, $204d ; $632b
	ld a, e ; $632e
	ld [hl+], a ; $632f
	ld [hl], d ; $6330
	ld hl, wWaterSpriteMinigameTimer ; $6331
	ld de, $204a ; $6334
	ld a, e ; $6337
	ld [hl+], a ; $6338
	ld [hl], d ; $6339
	ld hl, wWaterSpriteMinigameSwingCount ; $633a
	ld de, $206c ; $633d
	ld a, e ; $6340
	ld [hl+], a ; $6341
	ld [hl], d ; $6342
	ld hl, $c2b8 ; $6343
	ld de, $206d ; $6346
	ld a, e ; $6349
	ld [hl+], a ; $634a
	ld [hl], d ; $634b
	call Func_15_5d74 ; $634c
	ret ; $634f
Label_15_6350:
	ld hl, wWaterSpriteMinigameFlag ; $6350
	ld de, $207b ; $6353
	ld a, e ; $6356
	ld [hl+], a ; $6357
	ld [hl], d ; $6358
	ld hl, wWaterSpriteMinigameTimer ; $6359
	ld de, $2078 ; $635c
	ld a, e ; $635f
	ld [hl+], a ; $6360
	ld [hl], d ; $6361
	test_flag $0a, 3 ; $6362
	jr z, Label_15_637b ; $6365
	ld hl, wWaterSpriteMinigameSwingCount ; $6367
	ld de, $207e ; $636a
	ld a, e ; $636d
	ld [hl+], a ; $636e
	ld [hl], d ; $636f
	ld hl, $c2b8 ; $6370
	ld de, $2082 ; $6373
	ld a, e ; $6376
	ld [hl+], a ; $6377
	ld [hl], d ; $6378
	jr Label_15_638d ; $6379
Label_15_637b:
	ld hl, wWaterSpriteMinigameSwingCount ; $637b
	ld de, $207d ; $637e
	ld a, e ; $6381
	ld [hl+], a ; $6382
	ld [hl], d ; $6383
	ld hl, $c2b8 ; $6384
	ld de, $207f ; $6387
	ld a, e ; $638a
	ld [hl+], a ; $638b
	ld [hl], d ; $638c
Label_15_638d:
	call Func_15_5df3 ; $638d
	ret ; $6390
Label_15_6391:
	ld hl, wWaterSpriteMinigameFlag ; $6391
	ld de, $207b ; $6394
	ld a, e ; $6397
	ld [hl+], a ; $6398
	ld [hl], d ; $6399
	ld hl, wWaterSpriteMinigameTimer ; $639a
	ld de, $2078 ; $639d
	ld a, e ; $63a0
	ld [hl+], a ; $63a1
	ld [hl], d ; $63a2
	ld hl, wWaterSpriteMinigameSwingCount ; $63a3
	ld de, $2091 ; $63a6
	ld a, e ; $63a9
	ld [hl+], a ; $63aa
	ld [hl], d ; $63ab
	ld hl, $c2b8 ; $63ac
	ld de, $2092 ; $63af
	ld a, e ; $63b2
	ld [hl+], a ; $63b3
	ld [hl], d ; $63b4
	call Func_15_5df3 ; $63b5
	ret ; $63b8
Label_15_63b9:
	ld hl, wWaterSpriteMinigameFlag ; $63b9
	ld de, $207b ; $63bc
	ld a, e ; $63bf
	ld [hl+], a ; $63c0
	ld [hl], d ; $63c1
	ld hl, wWaterSpriteMinigameTimer ; $63c2
	ld de, $2078 ; $63c5
	ld a, e ; $63c8
	ld [hl+], a ; $63c9
	ld [hl], d ; $63ca
	ld hl, wWaterSpriteMinigameSwingCount ; $63cb
	ld de, $20a3 ; $63ce
	ld a, e ; $63d1
	ld [hl+], a ; $63d2
	ld [hl], d ; $63d3
	ld hl, $c2b8 ; $63d4
	ld de, $20a4 ; $63d7
	ld a, e ; $63da
	ld [hl+], a ; $63db
	ld [hl], d ; $63dc
	call Func_15_5df3 ; $63dd
	ret ; $63e0
	ld a, $06 ; $63e1
	ld b, a ; $63e3
	ld a, $02 ; $63e4
	farcall FarPtr_FaceActorTowardActor ; $63e6
	ld hl, $2014 ; $63e9
	farcall FarPtr_0a_0e ; $63ec
	ld a, $06 ; $63ef
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $63f1
	farcall FarPtr_0a_12 ; $63f4
	farcall FarPtr_ScriptCloseDialogueWindow ; $63f7
	push af ; $63fa
	ld a, $05 ; $63fb
	farcall FarPtr_WaitScriptFrames ; $63fd
	pop af ; $6400
	and a, a ; $6401
	jp nz, Label_15_64a2 ; $6402
	farcall FarPtr_0a_10 ; $6405
	ld a, $06 ; $6408
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $640a
	farcall FarPtr_0a_12 ; $640d
	farcall FarPtr_ScriptCloseDialogueWindow ; $6410
	push af ; $6413
	ld a, $05 ; $6414
	farcall FarPtr_WaitScriptFrames ; $6416
	pop af ; $6419
	and a, a ; $641a
	jp nz, Label_15_64a2 ; $641b
	farcall FarPtr_0a_10 ; $641e
	ld a, $06 ; $6421
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6423
	ld a, $06 ; $6426
	ld d, $03 ; $6428
	farcall FarPtr_ScriptSetActorAnimation ; $642a
	ld a, $06 ; $642d
	farcall FarPtr_ScriptWaitActorIdle ; $642f
	ld a, $06 ; $6432
	ld b, $00 ; $6434
	farcall FarPtr_SetActorFacing ; $6436
	push af ; $6439
	ld a, $28 ; $643a
	farcall FarPtr_WaitScriptFrames ; $643c
	pop af ; $643f
	ld a, $00 ; $6440
	ld b, a ; $6442
	ld a, $06 ; $6443
	farcall FarPtr_FaceActorTowardActor ; $6445
	ld a, $06 ; $6448
	farcall FarPtr_ScriptShowSpeakerDialogue ; $644a
	ld a, $06 ; $644d
	ld d, $03 ; $644f
	farcall FarPtr_ScriptSetActorAnimation ; $6451
	ld a, $06 ; $6454
	farcall FarPtr_ScriptWaitActorIdle ; $6456
	ld a, $06 ; $6459
	farcall FarPtr_ScriptShowSpeakerDialogue ; $645b
	push af ; $645e
	ld a, $28 ; $645f
	farcall FarPtr_WaitScriptFrames ; $6461
	pop af ; $6464
	ld a, $06 ; $6465
	ld d, $02 ; $6467
	farcall FarPtr_ScriptSetActorAnimation ; $6469
	ld a, $06 ; $646c
	farcall FarPtr_ScriptWaitActorIdle ; $646e
	ld a, $06 ; $6471
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6473
	ld a, $06 ; $6476
	ld d, $03 ; $6478
	farcall FarPtr_ScriptSetActorAnimation ; $647a
	ld a, $06 ; $647d
	farcall FarPtr_ScriptWaitActorIdle ; $647f
	ld a, $06 ; $6482
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6484
	call Func_15_668f ; $6487
	ld a, $0f ; $648a
	ld [wStoryModeCurrentLocation], a ; $648c
	ld a, $0a ; $648f
	ld [$c295], a ; $6491
	ld a, $ff ; $6494
	ld [$c294], a ; $6496
	ld [$c2a1], a ; $6499
	ld a, $00 ; $649c
	farcall FarPtr_0b_00 ; $649e
	ret ; $64a1
Label_15_64a2:
	ld a, $06 ; $64a2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $64a4
	ret ; $64a7
	ld a, $06 ; $64a8
	ld b, a ; $64aa
	ld a, $02 ; $64ab
	farcall FarPtr_FaceActorTowardActor ; $64ad
	ld hl, $2026 ; $64b0
	farcall FarPtr_0a_0e ; $64b3
	ld a, $06 ; $64b6
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $64b8
	farcall FarPtr_0a_12 ; $64bb
	farcall FarPtr_ScriptCloseDialogueWindow ; $64be
	push af ; $64c1
	ld a, $05 ; $64c2
	farcall FarPtr_WaitScriptFrames ; $64c4
	pop af ; $64c7
	and a, a ; $64c8
	jp nz, Label_15_64a2 ; $64c9
	farcall FarPtr_0a_10 ; $64cc
	ld a, $06 ; $64cf
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $64d1
	farcall FarPtr_0a_12 ; $64d4
	farcall FarPtr_ScriptCloseDialogueWindow ; $64d7
	push af ; $64da
	ld a, $05 ; $64db
	farcall FarPtr_WaitScriptFrames ; $64dd
	pop af ; $64e0
	and a, a ; $64e1
	jp nz, Label_15_64a2 ; $64e2
	farcall FarPtr_0a_10 ; $64e5
	ld a, $06 ; $64e8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $64ea
	ld a, $06 ; $64ed
	ld d, $03 ; $64ef
	farcall FarPtr_ScriptSetActorAnimation ; $64f1
	ld a, $06 ; $64f4
	farcall FarPtr_ScriptWaitActorIdle ; $64f6
	ld a, $06 ; $64f9
	ld b, $00 ; $64fb
	farcall FarPtr_SetActorFacing ; $64fd
	push af ; $6500
	ld a, $28 ; $6501
	farcall FarPtr_WaitScriptFrames ; $6503
	pop af ; $6506
	ld a, $00 ; $6507
	ld b, a ; $6509
	ld a, $06 ; $650a
	farcall FarPtr_FaceActorTowardActor ; $650c
	ld a, $06 ; $650f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6511
	ld a, $06 ; $6514
	ld d, $04 ; $6516
	farcall FarPtr_ScriptSetActorAnimation ; $6518
	ld a, $06 ; $651b
	farcall FarPtr_ScriptWaitActorIdle ; $651d
	ld a, $06 ; $6520
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6522
	push af ; $6525
	ld a, $14 ; $6526
	farcall FarPtr_WaitScriptFrames ; $6528
	pop af ; $652b
	ld a, $06 ; $652c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $652e
	ld a, $06 ; $6531
	ld d, $03 ; $6533
	farcall FarPtr_ScriptSetActorAnimation ; $6535
	ld a, $06 ; $6538
	farcall FarPtr_ScriptWaitActorIdle ; $653a
	ld a, $06 ; $653d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $653f
	push af ; $6542
	ld a, $14 ; $6543
	farcall FarPtr_WaitScriptFrames ; $6545
	pop af ; $6548
	ld a, $06 ; $6549
	ld d, $02 ; $654b
	farcall FarPtr_ScriptSetActorAnimation ; $654d
	ld a, $06 ; $6550
	farcall FarPtr_ScriptWaitActorIdle ; $6552
	ld a, $06 ; $6555
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6557
	ld a, $06 ; $655a
	ld d, $03 ; $655c
	farcall FarPtr_ScriptSetActorAnimation ; $655e
	ld a, $06 ; $6561
	farcall FarPtr_ScriptWaitActorIdle ; $6563
	ld a, $06 ; $6566
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6568
	call Func_15_668f ; $656b
	ld a, $0f ; $656e
	ld [wStoryModeCurrentLocation], a ; $6570
	ld a, $0a ; $6573
	ld [$c295], a ; $6575
	ld a, $ff ; $6578
	ld [$c294], a ; $657a
	ld [$c2a1], a ; $657d
	ld a, $01 ; $6580
	farcall FarPtr_0b_00 ; $6582
	ret ; $6585
	ld a, $06 ; $6586
	ld b, a ; $6588
	ld a, $02 ; $6589
	farcall FarPtr_FaceActorTowardActor ; $658b
	ld hl, $2034 ; $658e
	farcall FarPtr_0a_0e ; $6591
	ld a, $06 ; $6594
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6596
	farcall FarPtr_0a_12 ; $6599
	farcall FarPtr_ScriptCloseDialogueWindow ; $659c
	push af ; $659f
	ld a, $05 ; $65a0
	farcall FarPtr_WaitScriptFrames ; $65a2
	pop af ; $65a5
	and a, a ; $65a6
	jp nz, Label_15_64a2 ; $65a7
	farcall FarPtr_0a_10 ; $65aa
	ld a, $06 ; $65ad
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $65af
	farcall FarPtr_0a_12 ; $65b2
	farcall FarPtr_ScriptCloseDialogueWindow ; $65b5
	push af ; $65b8
	ld a, $05 ; $65b9
	farcall FarPtr_WaitScriptFrames ; $65bb
	pop af ; $65be
	and a, a ; $65bf
	jp nz, Label_15_64a2 ; $65c0
	farcall FarPtr_0a_10 ; $65c3
	ld a, $06 ; $65c6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $65c8
	ld a, $06 ; $65cb
	ld d, $03 ; $65cd
	farcall FarPtr_ScriptSetActorAnimation ; $65cf
	ld a, $06 ; $65d2
	farcall FarPtr_ScriptWaitActorIdle ; $65d4
	ld a, $06 ; $65d7
	ld b, $00 ; $65d9
	farcall FarPtr_SetActorFacing ; $65db
	push af ; $65de
	ld a, $28 ; $65df
	farcall FarPtr_WaitScriptFrames ; $65e1
	pop af ; $65e4
	ld a, $00 ; $65e5
	ld b, a ; $65e7
	ld a, $06 ; $65e8
	farcall FarPtr_FaceActorTowardActor ; $65ea
	ld a, $06 ; $65ed
	farcall FarPtr_ScriptShowSpeakerDialogue ; $65ef
	ld a, $06 ; $65f2
	ld d, $03 ; $65f4
	farcall FarPtr_ScriptSetActorAnimation ; $65f6
	ld a, $06 ; $65f9
	farcall FarPtr_ScriptWaitActorIdle ; $65fb
	ld a, $06 ; $65fe
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6600
	push af ; $6603
	ld a, $28 ; $6604
	farcall FarPtr_WaitScriptFrames ; $6606
	pop af ; $6609
	ld a, $06 ; $660a
	ld d, $02 ; $660c
	farcall FarPtr_ScriptSetActorAnimation ; $660e
	ld a, $06 ; $6611
	farcall FarPtr_ScriptWaitActorIdle ; $6613
	ld a, $06 ; $6616
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6618
	ld a, $06 ; $661b
	ld d, $03 ; $661d
	farcall FarPtr_ScriptSetActorAnimation ; $661f
	ld a, $06 ; $6622
	farcall FarPtr_ScriptWaitActorIdle ; $6624
	ld a, $06 ; $6627
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6629
	call Func_15_668f ; $662c
	ld a, $0f ; $662f
	ld [wStoryModeCurrentLocation], a ; $6631
	ld a, $0a ; $6634
	ld [$c295], a ; $6636
	ld a, $ff ; $6639
	ld [$c294], a ; $663b
	ld [$c2a1], a ; $663e
	ld a, $02 ; $6641
	farcall FarPtr_0b_00 ; $6643
	ret ; $6646
Func_15_6647:
	test_flag $05, 7 ; $6647
	jr z, Label_15_667b ; $664a
	ld a, $02 ; $664c
	ld b, a ; $664e
	ld a, $00 ; $664f
	farcall FarPtr_FaceActorTowardActor ; $6651
	ld a, $00 ; $6654
	ld d, $03 ; $6656
	farcall FarPtr_ScriptSetActorAnimation ; $6658
	ld a, $00 ; $665b
	farcall FarPtr_ScriptWaitActorIdle ; $665d
	ld a, $02 ; $6660
	ld d, $03 ; $6662
	farcall FarPtr_ScriptSetActorAnimation ; $6664
	ld a, $02 ; $6667
	farcall FarPtr_ScriptWaitActorIdle ; $6669
	ld a, $00 ; $666c
	ld b, $c0 ; $666e
	farcall FarPtr_SetActorFacing ; $6670
	push af ; $6673
	ld a, $0a ; $6674
	farcall FarPtr_WaitScriptFrames ; $6676
	pop af ; $6679
	ret ; $667a
Label_15_667b:
	ld a, $00 ; $667b
	ld d, $03 ; $667d
	farcall FarPtr_ScriptSetActorAnimation ; $667f
	ld a, $00 ; $6682
	farcall FarPtr_ScriptWaitActorIdle ; $6684
	push af ; $6687
	ld a, $0a ; $6688
	farcall FarPtr_WaitScriptFrames ; $668a
	pop af ; $668d
	ret ; $668e
Func_15_668f:
	ld a, $02 ; $668f
	farcall FarPtr_0a_1c ; $6691
	xor a, a ; $6694
	ld bc, $1800 ; $6695
	ld de, $0f00 ; $6698
	farcall FarPtr_MovePlayerToPosition ; $669b
	ldh a, [hRomBank] ; $669e
	ld b, a ; $66a0
	ld a, $00 ; $66a1
	ld de, $66d3 ; $66a3
	farcall FarPtr_0a_1a ; $66a6
	ldh a, [hRomBank] ; $66a9
	ld b, a ; $66ab
	ld a, $06 ; $66ac
	ld de, $66c8 ; $66ae
	farcall FarPtr_0a_1a ; $66b1
	ldh a, [hRomBank] ; $66b4
	ld b, a ; $66b6
	ld a, $02 ; $66b7
	ld de, $66e4 ; $66b9
	farcall FarPtr_0a_1a ; $66bc
	ld a, $00 ; $66bf
	farcall FarPtr_WaitActorScriptDone ; $66c1
	call Func_15_6647 ; $66c4
	ret ; $66c7
	INCBIN "data/bank_015/d_66c8.bin" ; $66c8, 1222 bytes
Label_15_6b8e:
	ld a, $0c ; $6b8e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6b90
	ret ; $6b93
Func_15_6b94:
	ld a, $0c ; $6b94
	ld b, a ; $6b96
	ld a, $02 ; $6b97
	farcall FarPtr_FaceActorTowardActor ; $6b99
	ld hl, $206f ; $6b9c
	farcall FarPtr_0a_0e ; $6b9f
	ld a, $0c ; $6ba2
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6ba4
	farcall FarPtr_0a_12 ; $6ba7
	farcall FarPtr_ScriptCloseDialogueWindow ; $6baa
	push af ; $6bad
	ld a, $05 ; $6bae
	farcall FarPtr_WaitScriptFrames ; $6bb0
	pop af ; $6bb3
	and a, a ; $6bb4
	jp nz, Label_15_6b8e ; $6bb5
	farcall FarPtr_0a_10 ; $6bb8
	ld a, $0c ; $6bbb
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6bbd
	farcall FarPtr_0a_12 ; $6bc0
	farcall FarPtr_ScriptCloseDialogueWindow ; $6bc3
	push af ; $6bc6
	ld a, $05 ; $6bc7
	farcall FarPtr_WaitScriptFrames ; $6bc9
	pop af ; $6bcc
	and a, a ; $6bcd
	jp nz, Label_15_6b8e ; $6bce
	farcall FarPtr_0a_10 ; $6bd1
	ld a, $0c ; $6bd4
	ld b, $00 ; $6bd6
	farcall FarPtr_SetActorFacing ; $6bd8
	push af ; $6bdb
	ld a, $28 ; $6bdc
	farcall FarPtr_WaitScriptFrames ; $6bde
	pop af ; $6be1
	ld a, $00 ; $6be2
	ld b, a ; $6be4
	ld a, $0c ; $6be5
	farcall FarPtr_FaceActorTowardActor ; $6be7
	ld a, $0c ; $6bea
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6bec
	ld a, $0c ; $6bef
	ld d, $03 ; $6bf1
	farcall FarPtr_ScriptSetActorAnimation ; $6bf3
	ld a, $0c ; $6bf6
	farcall FarPtr_ScriptWaitActorIdle ; $6bf8
	ld a, $0c ; $6bfb
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6bfd
	ld a, $0c ; $6c00
	ld d, $02 ; $6c02
	farcall FarPtr_ScriptSetActorAnimation ; $6c04
	ld a, $0c ; $6c07
	farcall FarPtr_ScriptWaitActorIdle ; $6c09
	ld a, $0c ; $6c0c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6c0e
	ld a, $0c ; $6c11
	ld d, $04 ; $6c13
	farcall FarPtr_ScriptSetActorAnimation ; $6c15
	ld a, $0c ; $6c18
	farcall FarPtr_ScriptWaitActorIdle ; $6c1a
	ld a, $0c ; $6c1d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6c1f
	ld a, $0c ; $6c22
	ld d, $03 ; $6c24
	farcall FarPtr_ScriptSetActorAnimation ; $6c26
	ld a, $0c ; $6c29
	farcall FarPtr_ScriptWaitActorIdle ; $6c2b
	ld a, $0c ; $6c2e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6c30
	call Func_15_6f51 ; $6c33
	ld a, $0c ; $6c36
	farcall FarPtr_0b_00 ; $6c38
	ret ; $6c3b
Func_15_6c3c:
	ld a, $0c ; $6c3c
	ld b, a ; $6c3e
	ld a, $02 ; $6c3f
	farcall FarPtr_FaceActorTowardActor ; $6c41
	ld hl, $2085 ; $6c44
	farcall FarPtr_0a_0e ; $6c47
	ld a, $0c ; $6c4a
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6c4c
	farcall FarPtr_0a_12 ; $6c4f
	farcall FarPtr_ScriptCloseDialogueWindow ; $6c52
	push af ; $6c55
	ld a, $05 ; $6c56
	farcall FarPtr_WaitScriptFrames ; $6c58
	pop af ; $6c5b
	and a, a ; $6c5c
	jp nz, Label_15_6b8e ; $6c5d
	farcall FarPtr_0a_10 ; $6c60
	ld a, $0c ; $6c63
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6c65
	farcall FarPtr_0a_12 ; $6c68
	farcall FarPtr_ScriptCloseDialogueWindow ; $6c6b
	push af ; $6c6e
	ld a, $05 ; $6c6f
	farcall FarPtr_WaitScriptFrames ; $6c71
	pop af ; $6c74
	and a, a ; $6c75
	jp nz, Label_15_6b8e ; $6c76
	farcall FarPtr_0a_10 ; $6c79
	ld a, $0c ; $6c7c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6c7e
	ld a, $0c ; $6c81
	ld b, $00 ; $6c83
	farcall FarPtr_SetActorFacing ; $6c85
	push af ; $6c88
	ld a, $28 ; $6c89
	farcall FarPtr_WaitScriptFrames ; $6c8b
	pop af ; $6c8e
	ld a, $00 ; $6c8f
	ld b, a ; $6c91
	ld a, $0c ; $6c92
	farcall FarPtr_FaceActorTowardActor ; $6c94
	ld a, $0c ; $6c97
	ld d, $03 ; $6c99
	farcall FarPtr_ScriptSetActorAnimation ; $6c9b
	ld a, $0c ; $6c9e
	farcall FarPtr_ScriptWaitActorIdle ; $6ca0
	ld a, $0c ; $6ca3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6ca5
	ld a, $0c ; $6ca8
	ld d, $02 ; $6caa
	farcall FarPtr_ScriptSetActorAnimation ; $6cac
	ld a, $0c ; $6caf
	farcall FarPtr_ScriptWaitActorIdle ; $6cb1
	ld a, $0c ; $6cb4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6cb6
	ld a, $0c ; $6cb9
	ld d, $04 ; $6cbb
	farcall FarPtr_ScriptSetActorAnimation ; $6cbd
	ld a, $0c ; $6cc0
	farcall FarPtr_ScriptWaitActorIdle ; $6cc2
	ld a, $0c ; $6cc5
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6cc7
	ld a, $0c ; $6cca
	ld d, $03 ; $6ccc
	farcall FarPtr_ScriptSetActorAnimation ; $6cce
	ld a, $0c ; $6cd1
	farcall FarPtr_ScriptWaitActorIdle ; $6cd3
	ld a, $0c ; $6cd6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6cd8
	call Func_15_6f51 ; $6cdb
	ld a, $0d ; $6cde
	farcall FarPtr_0b_00 ; $6ce0
	ret ; $6ce3
Func_15_6ce4:
	ld a, $0c ; $6ce4
	ld b, a ; $6ce6
	ld a, $02 ; $6ce7
	farcall FarPtr_FaceActorTowardActor ; $6ce9
	ld hl, $2095 ; $6cec
	farcall FarPtr_0a_0e ; $6cef
	ld a, $0c ; $6cf2
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6cf4
	farcall FarPtr_0a_12 ; $6cf7
	farcall FarPtr_ScriptCloseDialogueWindow ; $6cfa
	push af ; $6cfd
	ld a, $05 ; $6cfe
	farcall FarPtr_WaitScriptFrames ; $6d00
	pop af ; $6d03
	and a, a ; $6d04
	jp nz, Label_15_6b8e ; $6d05
	farcall FarPtr_0a_10 ; $6d08
	ld a, $0c ; $6d0b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6d0d
	ld a, $0c ; $6d10
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6d12
	farcall FarPtr_0a_12 ; $6d15
	farcall FarPtr_ScriptCloseDialogueWindow ; $6d18
	push af ; $6d1b
	ld a, $05 ; $6d1c
	farcall FarPtr_WaitScriptFrames ; $6d1e
	pop af ; $6d21
	and a, a ; $6d22
	jp nz, Label_15_6b8e ; $6d23
	farcall FarPtr_0a_10 ; $6d26
	ld a, $0c ; $6d29
	ld d, $03 ; $6d2b
	farcall FarPtr_ScriptSetActorAnimation ; $6d2d
	ld a, $0c ; $6d30
	farcall FarPtr_ScriptWaitActorIdle ; $6d32
	ld a, $0c ; $6d35
	ld b, $00 ; $6d37
	farcall FarPtr_SetActorFacing ; $6d39
	push af ; $6d3c
	ld a, $28 ; $6d3d
	farcall FarPtr_WaitScriptFrames ; $6d3f
	pop af ; $6d42
	ld a, $00 ; $6d43
	ld b, a ; $6d45
	ld a, $0c ; $6d46
	farcall FarPtr_FaceActorTowardActor ; $6d48
	ld a, $0c ; $6d4b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6d4d
	ld a, $0c ; $6d50
	ld d, $03 ; $6d52
	farcall FarPtr_ScriptSetActorAnimation ; $6d54
	ld a, $0c ; $6d57
	farcall FarPtr_ScriptWaitActorIdle ; $6d59
	ld a, $0c ; $6d5c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6d5e
	ld a, $0c ; $6d61
	ld d, $02 ; $6d63
	farcall FarPtr_ScriptSetActorAnimation ; $6d65
	ld a, $0c ; $6d68
	farcall FarPtr_ScriptWaitActorIdle ; $6d6a
	ld a, $0c ; $6d6d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6d6f
	ld a, $0c ; $6d72
	ld d, $04 ; $6d74
	farcall FarPtr_ScriptSetActorAnimation ; $6d76
	ld a, $0c ; $6d79
	farcall FarPtr_ScriptWaitActorIdle ; $6d7b
	ld a, $0c ; $6d7e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6d80
	ld a, $0c ; $6d83
	ld d, $02 ; $6d85
	farcall FarPtr_ScriptSetActorAnimation ; $6d87
	ld a, $0c ; $6d8a
	farcall FarPtr_ScriptWaitActorIdle ; $6d8c
	ld a, $0c ; $6d8f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6d91
	ld a, $0c ; $6d94
	ld d, $03 ; $6d96
	farcall FarPtr_ScriptSetActorAnimation ; $6d98
	ld a, $0c ; $6d9b
	farcall FarPtr_ScriptWaitActorIdle ; $6d9d
	ld a, $0c ; $6da0
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6da2
	call Func_15_6f51 ; $6da5
	ld a, $0e ; $6da8
	farcall FarPtr_0b_00 ; $6daa
	ret ; $6dad
Label_15_6dae:
	ld a, $0d ; $6dae
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6db0
	ret ; $6db3
Func_15_6db4:
	ld hl, $1cc4 ; $6db4
	farcall FarPtr_0a_0e ; $6db7
	test_flag $0a, 3 ; $6dba
	jr z, Label_15_6dc2 ; $6dbd
	farcall FarPtr_0a_10 ; $6dbf
Label_15_6dc2:
	ld a, $0d ; $6dc2
	ld b, a ; $6dc4
	ld a, $02 ; $6dc5
	farcall FarPtr_FaceActorTowardActor ; $6dc7
	ld a, $0d ; $6dca
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6dcc
	ld hl, $1cc6 ; $6dcf
	farcall FarPtr_0a_0e ; $6dd2
	farcall FarPtr_0a_12 ; $6dd5
	farcall FarPtr_ScriptCloseDialogueWindow ; $6dd8
	push af ; $6ddb
	ld a, $05 ; $6ddc
	farcall FarPtr_WaitScriptFrames ; $6dde
	pop af ; $6de1
	and a, a ; $6de2
	jp nz, Label_15_6dae ; $6de3
	farcall FarPtr_0a_10 ; $6de6
	ld a, $0d ; $6de9
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6deb
	farcall FarPtr_0a_12 ; $6dee
	farcall FarPtr_ScriptCloseDialogueWindow ; $6df1
	push af ; $6df4
	ld a, $05 ; $6df5
	farcall FarPtr_WaitScriptFrames ; $6df7
	pop af ; $6dfa
	and a, a ; $6dfb
	jp nz, Label_15_6dae ; $6dfc
	farcall FarPtr_0a_10 ; $6dff
	ld a, $0d ; $6e02
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6e04
	call Func_15_7d14 ; $6e07
	ld a, $0d ; $6e0a
	ld b, $00 ; $6e0c
	farcall FarPtr_SetActorFacing ; $6e0e
	ld hl, $1cca ; $6e11
	farcall FarPtr_0a_0e ; $6e14
	ld a, $0d ; $6e17
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6e19
	ld a, $0d ; $6e1c
	ld d, $02 ; $6e1e
	farcall FarPtr_ScriptSetActorAnimation ; $6e20
	ld a, $0d ; $6e23
	farcall FarPtr_ScriptWaitActorIdle ; $6e25
	ld a, $0f ; $6e28
	ld [$c8f7], a ; $6e2a
	ld a, $0f ; $6e2d
	ld [wStoryModeCurrentLocation], a ; $6e2f
	ld a, $09 ; $6e32
	ld [$c295], a ; $6e34
	ld a, $ff ; $6e37
	ld [$c294], a ; $6e39
	ld [$c2a1], a ; $6e3c
	ld c, $10 ; $6e3f
	call BeginFadeOut ; $6e41
	call WaitFadeEnd ; $6e44
	farcall FarPtr_17_0a ; $6e47
	ret ; $6e4a
Func_15_6e4b:
	ld a, $0d ; $6e4b
	ld b, a ; $6e4d
	ld a, $02 ; $6e4e
	farcall FarPtr_FaceActorTowardActor ; $6e50
	ld hl, $1ce3 ; $6e53
	farcall FarPtr_0a_0e ; $6e56
	ld a, $0d ; $6e59
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6e5b
	farcall FarPtr_0a_12 ; $6e5e
	farcall FarPtr_ScriptCloseDialogueWindow ; $6e61
	push af ; $6e64
	ld a, $05 ; $6e65
	farcall FarPtr_WaitScriptFrames ; $6e67
	pop af ; $6e6a
	and a, a ; $6e6b
	jp nz, Label_15_6dae ; $6e6c
	farcall FarPtr_0a_10 ; $6e6f
	ld a, $0d ; $6e72
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6e74
	farcall FarPtr_0a_12 ; $6e77
	farcall FarPtr_ScriptCloseDialogueWindow ; $6e7a
	push af ; $6e7d
	ld a, $05 ; $6e7e
	farcall FarPtr_WaitScriptFrames ; $6e80
	pop af ; $6e83
	and a, a ; $6e84
	jp nz, Label_15_6dae ; $6e85
	farcall FarPtr_0a_10 ; $6e88
	ld a, $0d ; $6e8b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6e8d
	call Func_15_7d14 ; $6e90
	ld a, $0d ; $6e93
	ld b, $00 ; $6e95
	farcall FarPtr_SetActorFacing ; $6e97
	ld a, $0d ; $6e9a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6e9c
	ld a, $0d ; $6e9f
	ld d, $02 ; $6ea1
	farcall FarPtr_ScriptSetActorAnimation ; $6ea3
	ld a, $0d ; $6ea6
	farcall FarPtr_ScriptWaitActorIdle ; $6ea8
	ld a, $10 ; $6eab
	ld [$c8f7], a ; $6ead
	ld a, $0f ; $6eb0
	ld [wStoryModeCurrentLocation], a ; $6eb2
	ld a, $09 ; $6eb5
	ld [$c295], a ; $6eb7
	ld a, $ff ; $6eba
	ld [$c294], a ; $6ebc
	ld [$c2a1], a ; $6ebf
	ld c, $10 ; $6ec2
	call BeginFadeOut ; $6ec4
	call WaitFadeEnd ; $6ec7
	farcall FarPtr_17_0a ; $6eca
	ret ; $6ecd
Func_15_6ece:
	ld a, $0d ; $6ece
	ld b, a ; $6ed0
	ld a, $02 ; $6ed1
	farcall FarPtr_FaceActorTowardActor ; $6ed3
	ld hl, $1cf9 ; $6ed6
	farcall FarPtr_0a_0e ; $6ed9
	ld a, $0d ; $6edc
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6ede
	farcall FarPtr_0a_12 ; $6ee1
	farcall FarPtr_ScriptCloseDialogueWindow ; $6ee4
	push af ; $6ee7
	ld a, $05 ; $6ee8
	farcall FarPtr_WaitScriptFrames ; $6eea
	pop af ; $6eed
	and a, a ; $6eee
	jp nz, Label_15_6dae ; $6eef
	farcall FarPtr_0a_10 ; $6ef2
	ld a, $0d ; $6ef5
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6ef7
	farcall FarPtr_0a_12 ; $6efa
	farcall FarPtr_ScriptCloseDialogueWindow ; $6efd
	push af ; $6f00
	ld a, $05 ; $6f01
	farcall FarPtr_WaitScriptFrames ; $6f03
	pop af ; $6f06
	and a, a ; $6f07
	jp nz, Label_15_6dae ; $6f08
	farcall FarPtr_0a_10 ; $6f0b
	ld a, $0d ; $6f0e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6f10
	call Func_15_7d14 ; $6f13
	ld a, $0d ; $6f16
	ld b, $00 ; $6f18
	farcall FarPtr_SetActorFacing ; $6f1a
	ld a, $0d ; $6f1d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6f1f
	ld a, $0d ; $6f22
	ld d, $02 ; $6f24
	farcall FarPtr_ScriptSetActorAnimation ; $6f26
	ld a, $0d ; $6f29
	farcall FarPtr_ScriptWaitActorIdle ; $6f2b
	ld a, $11 ; $6f2e
	ld [$c8f7], a ; $6f30
	ld a, $0f ; $6f33
	ld [wStoryModeCurrentLocation], a ; $6f35
	ld a, $09 ; $6f38
	ld [$c295], a ; $6f3a
	ld a, $ff ; $6f3d
	ld [$c294], a ; $6f3f
	ld [$c2a1], a ; $6f42
	ld c, $10 ; $6f45
	call BeginFadeOut ; $6f47
	call WaitFadeEnd ; $6f4a
	farcall FarPtr_17_0a ; $6f4d
	ret ; $6f50
Func_15_6f51:
	ld a, $02 ; $6f51
	farcall FarPtr_0a_1c ; $6f53
	xor a, a ; $6f56
	ld bc, $1800 ; $6f57
	ld de, $2700 ; $6f5a
	farcall FarPtr_MovePlayerToPosition ; $6f5d
	ldh a, [hRomBank] ; $6f60
	ld b, a ; $6f62
	ld a, $0c ; $6f63
	ld de, $6f9c ; $6f65
	farcall FarPtr_0a_1a ; $6f68
	ldh a, [hRomBank] ; $6f6b
	ld b, a ; $6f6d
	ld a, $00 ; $6f6e
	ld de, $6fa7 ; $6f70
	farcall FarPtr_0a_1a ; $6f73
	ldh a, [hRomBank] ; $6f76
	ld b, a ; $6f78
	ld a, $02 ; $6f79
	ld de, $6fbe ; $6f7b
	farcall FarPtr_0a_1a ; $6f7e
	ld a, $00 ; $6f81
	farcall FarPtr_WaitActorScriptDone ; $6f83
	call Func_15_6647 ; $6f86
	ld a, $0f ; $6f89
	ld [wStoryModeCurrentLocation], a ; $6f8b
	ld a, $0a ; $6f8e
	ld [$c295], a ; $6f90
	ld a, $ff ; $6f93
	ld [$c294], a ; $6f95
	ld [$c2a1], a ; $6f98
	ret ; $6f9b
	INCBIN "data/bank_015/d_6f9c.bin" ; $6f9c, 51 bytes
Func_15_6fcf:
	ld a, $12 ; $6fcf
	ld b, a ; $6fd1
	ld a, $02 ; $6fd2
	farcall FarPtr_FaceActorTowardActor ; $6fd4
	test_flag $0a, 3 ; $6fd7
	jr nz, Label_15_6fe4 ; $6fda
	ld hl, $1c5d ; $6fdc
	farcall FarPtr_0a_0e ; $6fdf
	jr Label_15_6fea ; $6fe2
Label_15_6fe4:
	ld hl, $1c64 ; $6fe4
	farcall FarPtr_0a_0e ; $6fe7
Label_15_6fea:
	ld a, $12 ; $6fea
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6fec
	farcall FarPtr_0a_12 ; $6fef
	farcall FarPtr_ScriptCloseDialogueWindow ; $6ff2
	push af ; $6ff5
	ld a, $05 ; $6ff6
	farcall FarPtr_WaitScriptFrames ; $6ff8
	pop af ; $6ffb
	and a, a ; $6ffc
	jr nz, Label_15_7068 ; $6ffd
	farcall FarPtr_0a_10 ; $6fff
	ld a, $12 ; $7002
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7004
	farcall FarPtr_0a_12 ; $7007
	farcall FarPtr_ScriptCloseDialogueWindow ; $700a
	push af ; $700d
	ld a, $05 ; $700e
	farcall FarPtr_WaitScriptFrames ; $7010
	pop af ; $7013
	and a, a ; $7014
	jr nz, Label_15_7068 ; $7015
	farcall FarPtr_0a_10 ; $7017
	ld a, $12 ; $701a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $701c
	call Func_15_7cbb ; $701f
	ld a, $12 ; $7022
	ld b, $80 ; $7024
	farcall FarPtr_SetActorFacing ; $7026
	ld a, $12 ; $7029
	farcall FarPtr_ScriptShowSpeakerDialogue ; $702b
	ld a, $12 ; $702e
	ld d, $02 ; $7030
	farcall FarPtr_ScriptSetActorAnimation ; $7032
	ld a, $12 ; $7035
	farcall FarPtr_ScriptWaitActorIdle ; $7037
	ld hl, $1c63 ; $703a
	farcall FarPtr_0a_0e ; $703d
	ld a, $12 ; $7040
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7042
	ld a, $09 ; $7045
	ld [$c8f7], a ; $7047
	ld a, $0f ; $704a
	ld [wStoryModeCurrentLocation], a ; $704c
	ld a, $09 ; $704f
	ld [$c295], a ; $7051
	ld a, $ff ; $7054
	ld [$c294], a ; $7056
	ld [$c2a1], a ; $7059
	ld c, $10 ; $705c
	call BeginFadeOut ; $705e
	call WaitFadeEnd ; $7061
	farcall FarPtr_17_0a ; $7064
	ret ; $7067
Label_15_7068:
	ld a, $12 ; $7068
	farcall FarPtr_ScriptShowSpeakerDialogue ; $706a
	ret ; $706d
Func_15_706e:
	ld a, $12 ; $706e
	ld b, a ; $7070
	ld a, $02 ; $7071
	farcall FarPtr_FaceActorTowardActor ; $7073
	ld hl, $1c86 ; $7076
	farcall FarPtr_0a_0e ; $7079
	ld a, $12 ; $707c
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $707e
	farcall FarPtr_0a_12 ; $7081
	farcall FarPtr_ScriptCloseDialogueWindow ; $7084
	push af ; $7087
	ld a, $05 ; $7088
	farcall FarPtr_WaitScriptFrames ; $708a
	pop af ; $708d
	and a, a ; $708e
	jr nz, Label_15_7068 ; $708f
	farcall FarPtr_0a_10 ; $7091
	ld a, $12 ; $7094
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7096
	farcall FarPtr_0a_12 ; $7099
	farcall FarPtr_ScriptCloseDialogueWindow ; $709c
	push af ; $709f
	ld a, $05 ; $70a0
	farcall FarPtr_WaitScriptFrames ; $70a2
	pop af ; $70a5
	and a, a ; $70a6
	jr nz, Label_15_7068 ; $70a7
	farcall FarPtr_0a_10 ; $70a9
	ld a, $12 ; $70ac
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $70ae
	farcall FarPtr_0a_12 ; $70b1
	farcall FarPtr_ScriptCloseDialogueWindow ; $70b4
	push af ; $70b7
	ld a, $05 ; $70b8
	farcall FarPtr_WaitScriptFrames ; $70ba
	pop af ; $70bd
	and a, a ; $70be
	jr nz, Label_15_7068 ; $70bf
	farcall FarPtr_0a_10 ; $70c1
	ld a, $12 ; $70c4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $70c6
	call Func_15_7cbb ; $70c9
	ld a, $12 ; $70cc
	ld b, $80 ; $70ce
	farcall FarPtr_SetActorFacing ; $70d0
	ld a, $12 ; $70d3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $70d5
	ld a, $12 ; $70d8
	ld d, $02 ; $70da
	farcall FarPtr_ScriptSetActorAnimation ; $70dc
	ld a, $12 ; $70df
	farcall FarPtr_ScriptWaitActorIdle ; $70e1
	ld a, $12 ; $70e4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $70e6
	ld a, $12 ; $70e9
	ld d, $03 ; $70eb
	farcall FarPtr_ScriptSetActorAnimation ; $70ed
	ld a, $12 ; $70f0
	farcall FarPtr_ScriptWaitActorIdle ; $70f2
	ld a, $12 ; $70f5
	farcall FarPtr_ScriptShowSpeakerDialogue ; $70f7
	ld a, $0a ; $70fa
	ld [$c8f7], a ; $70fc
	ld a, $0f ; $70ff
	ld [wStoryModeCurrentLocation], a ; $7101
	ld a, $09 ; $7104
	ld [$c295], a ; $7106
	ld a, $ff ; $7109
	ld [$c294], a ; $710b
	ld [$c2a1], a ; $710e
	ld c, $10 ; $7111
	call BeginFadeOut ; $7113
	call WaitFadeEnd ; $7116
	farcall FarPtr_17_0a ; $7119
	ret ; $711c
Func_15_711d:
	ld a, $12 ; $711d
	ld b, a ; $711f
	ld a, $02 ; $7120
	farcall FarPtr_FaceActorTowardActor ; $7122
	ld hl, $1c9f ; $7125
	farcall FarPtr_0a_0e ; $7128
	ld a, $12 ; $712b
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $712d
	farcall FarPtr_0a_12 ; $7130
	farcall FarPtr_ScriptCloseDialogueWindow ; $7133
	push af ; $7136
	ld a, $05 ; $7137
	farcall FarPtr_WaitScriptFrames ; $7139
	pop af ; $713c
	and a, a ; $713d
	jp nz, Label_15_7068 ; $713e
	farcall FarPtr_0a_10 ; $7141
	ld a, $12 ; $7144
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7146
	farcall FarPtr_0a_12 ; $7149
	farcall FarPtr_ScriptCloseDialogueWindow ; $714c
	push af ; $714f
	ld a, $05 ; $7150
	farcall FarPtr_WaitScriptFrames ; $7152
	pop af ; $7155
	and a, a ; $7156
	jp nz, Label_15_7068 ; $7157
	farcall FarPtr_0a_10 ; $715a
	ld a, $12 ; $715d
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $715f
	farcall FarPtr_0a_12 ; $7162
	farcall FarPtr_ScriptCloseDialogueWindow ; $7165
	push af ; $7168
	ld a, $05 ; $7169
	farcall FarPtr_WaitScriptFrames ; $716b
	pop af ; $716e
	and a, a ; $716f
	jp nz, Label_15_7068 ; $7170
	farcall FarPtr_0a_10 ; $7173
	ld a, $12 ; $7176
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7178
	call Func_15_7cbb ; $717b
	ld a, $12 ; $717e
	ld b, $80 ; $7180
	farcall FarPtr_SetActorFacing ; $7182
	ld a, $12 ; $7185
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7187
	ld a, $12 ; $718a
	ld d, $02 ; $718c
	farcall FarPtr_ScriptSetActorAnimation ; $718e
	ld a, $12 ; $7191
	farcall FarPtr_ScriptWaitActorIdle ; $7193
	ld a, $12 ; $7196
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7198
	ld a, $0b ; $719b
	ld [$c8f7], a ; $719d
	ld a, $0f ; $71a0
	ld [wStoryModeCurrentLocation], a ; $71a2
	ld a, $09 ; $71a5
	ld [$c295], a ; $71a7
	ld a, $ff ; $71aa
	ld [$c294], a ; $71ac
	ld [$c2a1], a ; $71af
	ld c, $10 ; $71b2
	call BeginFadeOut ; $71b4
	call WaitFadeEnd ; $71b7
	farcall FarPtr_17_0a ; $71ba
	ret ; $71bd
Func_15_71be:
	test_flag $17, 2 ; $71be
	jr nz, Label_15_71c8 ; $71c1
	call Func_15_71d4 ; $71c3
	jr z, Label_15_71d3 ; $71c6
Label_15_71c8:
	ld a, $06 ; $71c8
	ld bc, $3f00 ; $71ca
	ld de, $3f00 ; $71cd
	farcall FarPtr_ScriptSetActorPosition ; $71d0
Label_15_71d3:
	ret ; $71d3
Func_15_71d4:
	ld a, [$c2b0] ; $71d4
	add a, a ; $71d7
	add a, $f8 ; $71d8
	ld l, a ; $71da
	adc a, $71 ; $71db
	sub a, l ; $71dd
	ld h, a ; $71de
	ld a, [hl+] ; $71df
	ld d, [hl] ; $71e0
	ld e, a ; $71e1
	call TestGameFlagByNumber ; $71e2
	ret ; $71e5
	ld a, [$c2b0] ; $71e6
	add a, a ; $71e9
	add a, $f8 ; $71ea
	ld l, a ; $71ec
	adc a, $71 ; $71ed
	sub a, l ; $71ef
	ld h, a ; $71f0
	ld a, [hl+] ; $71f1
	ld d, [hl] ; $71f2
	ld e, a ; $71f3
	call SetGameFlagByNumber ; $71f4
	ret ; $71f7
	; $71f8, 12 bytes (records:2)
; 6 records x 2 bytes
	dw $00c0 ; record 0
	dw $00c1 ; record 1
	dw $00c2 ; record 2
	dw $00c2 ; record 3
	dw $00c2 ; record 4
	dw $00c2 ; record 5
Func_15_7204:
	test_flag $17, 3 ; $7204
	jr nz, Label_15_720e ; $7207
	call Func_15_721a ; $7209
	jr z, Label_15_7219 ; $720c
Label_15_720e:
	ld a, $11 ; $720e
	ld bc, $3f00 ; $7210
	ld de, $3f00 ; $7213
	farcall FarPtr_ScriptSetActorPosition ; $7216
Label_15_7219:
	ret ; $7219
Func_15_721a:
	ld a, [$c2b0] ; $721a
	add a, a ; $721d
	add a, $3e ; $721e
	ld l, a ; $7220
	adc a, $72 ; $7221
	sub a, l ; $7223
	ld h, a ; $7224
	ld a, [hl+] ; $7225
	ld d, [hl] ; $7226
	ld e, a ; $7227
	call TestGameFlagByNumber ; $7228
	ret ; $722b
	ld a, [$c2b0] ; $722c
	add a, a ; $722f
	add a, $3e ; $7230
	ld l, a ; $7232
	adc a, $72 ; $7233
	sub a, l ; $7235
	ld h, a ; $7236
	ld a, [hl+] ; $7237
	ld d, [hl] ; $7238
	ld e, a ; $7239
	call SetGameFlagByNumber ; $723a
	ret ; $723d
	; $723e, 12 bytes (records:2)
; 6 records x 2 bytes
	dw $00c6 ; record 0
	dw $00c7 ; record 1
	dw $00c8 ; record 2
	dw $00c8 ; record 3
	dw $00c8 ; record 4
	dw $00c8 ; record 5
Func_15_724a:
	test_flag $17, 4 ; $724a
	jr nz, Label_15_7254 ; $724d
	call Func_15_7260 ; $724f
	jr z, Label_15_725f ; $7252
Label_15_7254:
	ld a, $0c ; $7254
	ld bc, $3f00 ; $7256
	ld de, $3f00 ; $7259
	farcall FarPtr_ScriptSetActorPosition ; $725c
Label_15_725f:
	ret ; $725f
Func_15_7260:
	ld a, [$c2b0] ; $7260
	add a, a ; $7263
	add a, $84 ; $7264
	ld l, a ; $7266
	adc a, $72 ; $7267
	sub a, l ; $7269
	ld h, a ; $726a
	ld a, [hl+] ; $726b
	ld d, [hl] ; $726c
	ld e, a ; $726d
	call TestGameFlagByNumber ; $726e
	ret ; $7271
	ld a, [$c2b0] ; $7272
	add a, a ; $7275
	add a, $84 ; $7276
	ld l, a ; $7278
	adc a, $72 ; $7279
	sub a, l ; $727b
	ld h, a ; $727c
	ld a, [hl+] ; $727d
	ld d, [hl] ; $727e
	ld e, a ; $727f
	call SetGameFlagByNumber ; $7280
	ret ; $7283
	; $7284, 12 bytes (records:2)
; 6 records x 2 bytes
	dw $00cc ; record 0
	dw $00cd ; record 1
	dw $00ce ; record 2
	dw $00ce ; record 3
	dw $00ce ; record 4
	dw $00ce ; record 5
Label_15_7290:
	ld a, [$c2e3] ; $7290
	ld a, a ; $7293
	rst Rst00 ; $7294
	dw Label_15_72c7 ; $7295 jumptable
	dw Label_15_73f0 ; $7297 jumptable
	dw Label_15_73fd ; $7299 jumptable
	dw Label_15_740a ; $729b jumptable
	dw Label_15_73f0 ; $729d jumptable
Label_15_729f:
	ld a, [$c2e3] ; $729f
	ld a, a ; $72a2
	rst Rst00 ; $72a3
	dw Label_15_7336 ; $72a4 jumptable
	dw Label_15_73f0 ; $72a6 jumptable
	dw Label_15_73fd ; $72a8 jumptable
	dw Label_15_7417 ; $72aa jumptable
	dw Label_15_7424 ; $72ac jumptable
	dw Label_15_7431 ; $72ae jumptable
	dw Label_15_743e ; $72b0 jumptable
	dw Label_15_73f0 ; $72b2 jumptable
Label_15_72b4:
	ld a, [$c2e3] ; $72b4
	ld a, a ; $72b7
	rst Rst00 ; $72b8
	dw Label_15_739c ; $72b9 jumptable
	dw Label_15_73f0 ; $72bb jumptable
	dw Label_15_73fd ; $72bd jumptable
	dw Label_15_7417 ; $72bf jumptable
	dw Label_15_744b ; $72c1 jumptable
	dw Label_15_7458 ; $72c3 jumptable
	dw Label_15_73f0 ; $72c5 jumptable
Label_15_72c7:
	call Func_15_74e1 ; $72c7
	ld hl, $1c1c ; $72ca
	farcall FarPtr_0a_0e ; $72cd
	ld a, $07 ; $72d0
	farcall FarPtr_ScriptShowSpeakerDialogue ; $72d2
	test_flag $0a, 3 ; $72d5
	jr z, Label_15_72dd ; $72d8
	farcall FarPtr_0a_10 ; $72da
Label_15_72dd:
	ld a, $00 ; $72dd
	ld b, a ; $72df
	ld a, $07 ; $72e0
	farcall FarPtr_FaceActorTowardActor ; $72e2
	ld a, $07 ; $72e5
	ld d, $03 ; $72e7
	farcall FarPtr_ScriptSetActorAnimation ; $72e9
	ld a, $07 ; $72ec
	farcall FarPtr_ScriptWaitActorIdle ; $72ee
	ld a, $07 ; $72f1
	farcall FarPtr_ScriptShowSpeakerDialogue ; $72f3
	ld a, $07 ; $72f6
	ld d, $02 ; $72f8
	farcall FarPtr_ScriptSetActorAnimation ; $72fa
	ld a, $07 ; $72fd
	farcall FarPtr_ScriptWaitActorIdle ; $72ff
	ld hl, $1c1f ; $7302
	farcall FarPtr_0a_0e ; $7305
	ld a, $07 ; $7308
	farcall FarPtr_ScriptShowSpeakerDialogue ; $730a
	ld a, $07 ; $730d
	ld d, $04 ; $730f
	farcall FarPtr_ScriptSetActorAnimation ; $7311
	ld a, $07 ; $7314
	farcall FarPtr_ScriptWaitActorIdle ; $7316
	ld a, $07 ; $7319
	farcall FarPtr_ScriptShowSpeakerDialogue ; $731b
	test_flag $0a, 3 ; $731e
	jr z, Label_15_7326 ; $7321
	farcall FarPtr_0a_10 ; $7323
Label_15_7326:
	ld a, $07 ; $7326
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7328
	ld a, $07 ; $732b
	ld b, $80 ; $732d
	farcall FarPtr_SetActorFacing ; $732f
	set_flag $17, 5 ; $7332
	ret ; $7335
Label_15_7336:
	call Func_15_74e1 ; $7336
	ld hl, $1c2a ; $7339
	farcall FarPtr_0a_0e ; $733c
	test_flag $0a, 7 ; $733f
	jr z, Label_15_734a ; $7342
	ld hl, $1c2e ; $7344
	farcall FarPtr_0a_0e ; $7347
Label_15_734a:
	ld a, $07 ; $734a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $734c
	ld a, $00 ; $734f
	ld b, a ; $7351
	ld a, $07 ; $7352
	farcall FarPtr_FaceActorTowardActor ; $7354
	ld a, $07 ; $7357
	ld d, $03 ; $7359
	farcall FarPtr_ScriptSetActorAnimation ; $735b
	ld a, $07 ; $735e
	farcall FarPtr_ScriptWaitActorIdle ; $7360
	ld a, $07 ; $7363
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7365
	ld a, $07 ; $7368
	ld d, $02 ; $736a
	farcall FarPtr_ScriptSetActorAnimation ; $736c
	ld a, $07 ; $736f
	farcall FarPtr_ScriptWaitActorIdle ; $7371
	ld a, $07 ; $7374
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7376
	ld a, $07 ; $7379
	ld d, $04 ; $737b
	farcall FarPtr_ScriptSetActorAnimation ; $737d
	ld a, $07 ; $7380
	farcall FarPtr_ScriptWaitActorIdle ; $7382
	ld a, $07 ; $7385
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7387
	ld a, $07 ; $738a
	ld b, $80 ; $738c
	farcall FarPtr_SetActorFacing ; $738e
	push af ; $7391
	ld a, $05 ; $7392
	farcall FarPtr_WaitScriptFrames ; $7394
	pop af ; $7397
	set_flag $17, 5 ; $7398
	ret ; $739b
Label_15_739c:
	call Func_15_74e1 ; $739c
	ld hl, $1c39 ; $739f
	farcall FarPtr_0a_0e ; $73a2
	ld a, $07 ; $73a5
	farcall FarPtr_ScriptShowSpeakerDialogue ; $73a7
	ld a, $00 ; $73aa
	ld b, a ; $73ac
	ld a, $07 ; $73ad
	farcall FarPtr_FaceActorTowardActor ; $73af
	ld a, $07 ; $73b2
	ld d, $03 ; $73b4
	farcall FarPtr_ScriptSetActorAnimation ; $73b6
	ld a, $07 ; $73b9
	farcall FarPtr_ScriptWaitActorIdle ; $73bb
	ld a, $07 ; $73be
	farcall FarPtr_ScriptShowSpeakerDialogue ; $73c0
	ld a, $07 ; $73c3
	ld d, $02 ; $73c5
	farcall FarPtr_ScriptSetActorAnimation ; $73c7
	ld a, $07 ; $73ca
	farcall FarPtr_ScriptWaitActorIdle ; $73cc
	ld a, $07 ; $73cf
	farcall FarPtr_ScriptShowSpeakerDialogue ; $73d1
	ld a, $07 ; $73d4
	ld d, $03 ; $73d6
	farcall FarPtr_ScriptSetActorAnimation ; $73d8
	ld a, $07 ; $73db
	farcall FarPtr_ScriptWaitActorIdle ; $73dd
	ld a, $07 ; $73e0
	farcall FarPtr_ScriptShowSpeakerDialogue ; $73e2
	ld a, $07 ; $73e5
	ld b, $80 ; $73e7
	farcall FarPtr_SetActorFacing ; $73e9
	set_flag $17, 5 ; $73ec
	ret ; $73ef
Label_15_73f0:
	call Func_15_74e1 ; $73f0
	ld hl, $1c3e ; $73f3
	farcall FarPtr_0a_0e ; $73f6
	call Func_15_7465 ; $73f9
	ret ; $73fc
Label_15_73fd:
	call Func_15_74e1 ; $73fd
	ld hl, $1c43 ; $7400
	farcall FarPtr_0a_0e ; $7403
	call Func_15_749a ; $7406
	ret ; $7409
Label_15_740a:
	call Func_15_74e1 ; $740a
	ld hl, $1c48 ; $740d
	farcall FarPtr_0a_0e ; $7410
	call Func_15_747e ; $7413
	ret ; $7416
Label_15_7417:
	call Func_15_74e1 ; $7417
	ld hl, $1c4b ; $741a
	farcall FarPtr_0a_0e ; $741d
	call Func_15_747e ; $7420
	ret ; $7423
Label_15_7424:
	call Func_15_74e1 ; $7424
	ld hl, $1c4e ; $7427
	farcall FarPtr_0a_0e ; $742a
	call Func_15_747e ; $742d
	ret ; $7430
Label_15_7431:
	call Func_15_74e1 ; $7431
	ld hl, $1c51 ; $7434
	farcall FarPtr_0a_0e ; $7437
	call Func_15_747e ; $743a
	ret ; $743d
Label_15_743e:
	call Func_15_74e1 ; $743e
	ld hl, $1c54 ; $7441
	farcall FarPtr_0a_0e ; $7444
	call Func_15_747e ; $7447
	ret ; $744a
Label_15_744b:
	call Func_15_74e1 ; $744b
	ld hl, $1c57 ; $744e
	farcall FarPtr_0a_0e ; $7451
	call Func_15_747e ; $7454
	ret ; $7457
Label_15_7458:
	call Func_15_74e1 ; $7458
	ld hl, $1c5a ; $745b
	farcall FarPtr_0a_0e ; $745e
	call Func_15_747e ; $7461
	ret ; $7464
Func_15_7465:
	ld a, $07 ; $7465
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7467
	farcall FarPtr_0a_12 ; $746a
	farcall FarPtr_ScriptCloseDialogueWindow ; $746d
	push af ; $7470
	ld a, $05 ; $7471
	farcall FarPtr_WaitScriptFrames ; $7473
	pop af ; $7476
	and a, a ; $7477
	jp nz, Label_15_752c ; $7478
	farcall FarPtr_0a_10 ; $747b
Func_15_747e:
	ld a, $07 ; $747e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7480
	farcall FarPtr_0a_12 ; $7483
	farcall FarPtr_ScriptCloseDialogueWindow ; $7486
	push af ; $7489
	ld a, $05 ; $748a
	farcall FarPtr_WaitScriptFrames ; $748c
	pop af ; $748f
	and a, a ; $7490
	jp z, Label_15_74d2 ; $7491
	farcall FarPtr_0a_10 ; $7494
	jp Label_15_752c ; $7497
Func_15_749a:
	ld a, $07 ; $749a
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $749c
	farcall FarPtr_0a_12 ; $749f
	farcall FarPtr_ScriptCloseDialogueWindow ; $74a2
	push af ; $74a5
	ld a, $05 ; $74a6
	farcall FarPtr_WaitScriptFrames ; $74a8
	pop af ; $74ab
	and a, a ; $74ac
	jp nz, Label_15_74b3 ; $74ad
	farcall FarPtr_0a_10 ; $74b0
Label_15_74b3:
	ld a, $07 ; $74b3
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $74b5
	farcall FarPtr_0a_12 ; $74b8
	farcall FarPtr_ScriptCloseDialogueWindow ; $74bb
	push af ; $74be
	ld a, $05 ; $74bf
	farcall FarPtr_WaitScriptFrames ; $74c1
	pop af ; $74c4
	and a, a ; $74c5
	jp z, Label_15_74d2 ; $74c6
	ld hl, $1c47 ; $74c9
	farcall FarPtr_0a_0e ; $74cc
	jp Label_15_752c ; $74cf
Label_15_74d2:
	ld hl, $1c41 ; $74d2
	farcall FarPtr_0a_0e ; $74d5
	ld a, $07 ; $74d8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $74da
	call Func_15_7a96 ; $74dd
	ret ; $74e0
Func_15_74e1:
	xor a, a ; $74e1
	ld [$c2d5], a ; $74e2
	ld bc, $00f0 ; $74e5
	farcall FarPtr_0a_38 ; $74e8
	ld a, $00 ; $74eb
	ld bc, $1300 ; $74ed
	ld de, $1300 ; $74f0
	farcall FarPtr_ScriptSetActorPosition ; $74f3
	ld a, $02 ; $74f6
	ld bc, $1300 ; $74f8
	ld de, $1100 ; $74fb
	farcall FarPtr_ScriptSetActorPosition ; $74fe
	xor a, a ; $7501
	ld bc, $1300 ; $7502
	ld de, $1300 ; $7505
	farcall FarPtr_MovePlayerToPosition ; $7508
	farcall FarPtr_WaitPlayerMoveDone ; $750b
	ld a, $00 ; $750e
	ld b, $40 ; $7510
	farcall FarPtr_SetActorFacing ; $7512
	ld a, $02 ; $7515
	ld b, $40 ; $7517
	farcall FarPtr_SetActorFacing ; $7519
	ld a, $07 ; $751c
	ld b, $c0 ; $751e
	farcall FarPtr_SetActorFacing ; $7520
	ld c, $04 ; $7523
	call BeginFadeIn ; $7525
	call WaitFadeEnd ; $7528
	ret ; $752b
Label_15_752c:
	ld a, $07 ; $752c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $752e
	ld a, $07 ; $7531
	ld b, $80 ; $7533
	farcall FarPtr_SetActorFacing ; $7535
	ret ; $7538
Label_15_7539:
	ld a, [$c2e3] ; $7539
	ld a, a ; $753c
	rst Rst00 ; $753d
	dw Label_15_757a ; $753e jumptable
	dw Label_15_768c ; $7540 jumptable
	dw Label_15_7699 ; $7542 jumptable
	dw Label_15_76a6 ; $7544 jumptable
	dw Label_15_76b3 ; $7546 jumptable
	dw Label_15_76c0 ; $7548 jumptable
	dw Label_15_768c ; $754a jumptable
	dw Label_15_768c ; $754c jumptable
Label_15_754e:
	ld a, [$c2e3] ; $754e
	ld a, a ; $7551
	rst Rst00 ; $7552
	dw Label_15_75d9 ; $7553 jumptable
	dw Label_15_768c ; $7555 jumptable
	dw Label_15_7699 ; $7557 jumptable
	dw Label_15_76cd ; $7559 jumptable
	dw Label_15_770e ; $755b jumptable
	dw Label_15_76da ; $755d jumptable
	dw Label_15_76c0 ; $755f jumptable
	dw Label_15_768c ; $7561 jumptable
Label_15_7563:
	ld a, [$c2e3] ; $7563
	ld a, a ; $7566
	rst Rst00 ; $7567
	dw Label_15_7638 ; $7568 jumptable
	dw Label_15_768c ; $756a jumptable
	dw Label_15_7699 ; $756c jumptable
	dw Label_15_76e7 ; $756e jumptable
	dw Label_15_76f4 ; $7570 jumptable
	dw Label_15_771b ; $7572 jumptable
	dw Label_15_7701 ; $7574 jumptable
	dw Label_15_76c0 ; $7576 jumptable
	dw Label_15_768c ; $7578 jumptable
Label_15_757a:
	ld hl, $1c7e ; $757a
	farcall FarPtr_0a_0e ; $757d
	call Func_15_7752 ; $7580
	ld a, $12 ; $7583
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7585
	ld a, $00 ; $7588
	ld b, a ; $758a
	ld a, $12 ; $758b
	farcall FarPtr_FaceActorTowardActor ; $758d
	test_flag $0a, 3 ; $7590
	jr z, Label_15_759b ; $7593
	ld hl, $1c82 ; $7595
	farcall FarPtr_0a_0e ; $7598
Label_15_759b:
	ld a, $12 ; $759b
	ld d, $03 ; $759d
	farcall FarPtr_ScriptSetActorAnimation ; $759f
	ld a, $12 ; $75a2
	farcall FarPtr_ScriptWaitActorIdle ; $75a4
	ld a, $12 ; $75a7
	farcall FarPtr_ScriptShowSpeakerDialogue ; $75a9
	ld a, $12 ; $75ac
	ld d, $02 ; $75ae
	farcall FarPtr_ScriptSetActorAnimation ; $75b0
	ld a, $12 ; $75b3
	farcall FarPtr_ScriptWaitActorIdle ; $75b5
	ld a, $12 ; $75b8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $75ba
	ld a, $12 ; $75bd
	ld d, $04 ; $75bf
	farcall FarPtr_ScriptSetActorAnimation ; $75c1
	ld a, $12 ; $75c4
	farcall FarPtr_ScriptWaitActorIdle ; $75c6
	ld a, $12 ; $75c9
	farcall FarPtr_ScriptShowSpeakerDialogue ; $75cb
	ld a, $12 ; $75ce
	ld b, $00 ; $75d0
	farcall FarPtr_SetActorFacing ; $75d2
	set_flag $17, 6 ; $75d5
	ret ; $75d8
Label_15_75d9:
	call Func_15_7752 ; $75d9
	ld hl, $1c97 ; $75dc
	farcall FarPtr_0a_0e ; $75df
	ld a, $12 ; $75e2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $75e4
	ld a, $00 ; $75e7
	ld b, a ; $75e9
	ld a, $12 ; $75ea
	farcall FarPtr_FaceActorTowardActor ; $75ec
	ld a, $12 ; $75ef
	ld d, $03 ; $75f1
	farcall FarPtr_ScriptSetActorAnimation ; $75f3
	ld a, $12 ; $75f6
	farcall FarPtr_ScriptWaitActorIdle ; $75f8
	test_flag $0a, 7 ; $75fb
	jr z, Label_15_7606 ; $75fe
	ld hl, $1c9b ; $7600
	farcall FarPtr_0a_0e ; $7603
Label_15_7606:
	ld a, $12 ; $7606
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7608
	ld a, $12 ; $760b
	ld d, $02 ; $760d
	farcall FarPtr_ScriptSetActorAnimation ; $760f
	ld a, $12 ; $7612
	farcall FarPtr_ScriptWaitActorIdle ; $7614
	ld a, $12 ; $7617
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7619
	ld a, $12 ; $761c
	ld d, $04 ; $761e
	farcall FarPtr_ScriptSetActorAnimation ; $7620
	ld a, $12 ; $7623
	farcall FarPtr_ScriptWaitActorIdle ; $7625
	ld a, $12 ; $7628
	farcall FarPtr_ScriptShowSpeakerDialogue ; $762a
	ld a, $12 ; $762d
	ld b, $00 ; $762f
	farcall FarPtr_SetActorFacing ; $7631
	set_flag $17, 6 ; $7634
	ret ; $7637
Label_15_7638:
	call Func_15_7752 ; $7638
	ld hl, $1cb7 ; $763b
	farcall FarPtr_0a_0e ; $763e
	ld a, $12 ; $7641
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7643
	ld a, $00 ; $7646
	ld b, a ; $7648
	ld a, $12 ; $7649
	farcall FarPtr_FaceActorTowardActor ; $764b
	ld a, $12 ; $764e
	ld d, $03 ; $7650
	farcall FarPtr_ScriptSetActorAnimation ; $7652
	ld a, $12 ; $7655
	farcall FarPtr_ScriptWaitActorIdle ; $7657
	ld a, $12 ; $765a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $765c
	ld a, $12 ; $765f
	ld d, $02 ; $7661
	farcall FarPtr_ScriptSetActorAnimation ; $7663
	ld a, $12 ; $7666
	farcall FarPtr_ScriptWaitActorIdle ; $7668
	ld a, $12 ; $766b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $766d
	ld a, $12 ; $7670
	ld d, $03 ; $7672
	farcall FarPtr_ScriptSetActorAnimation ; $7674
	ld a, $12 ; $7677
	farcall FarPtr_ScriptWaitActorIdle ; $7679
	ld a, $12 ; $767c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $767e
	ld a, $12 ; $7681
	ld b, $00 ; $7683
	farcall FarPtr_SetActorFacing ; $7685
	set_flag $17, 6 ; $7688
	ret ; $768b
Label_15_768c:
	call Func_15_7752 ; $768c
	ld hl, $1c6b ; $768f
	farcall FarPtr_0a_0e ; $7692
	call Func_15_7728 ; $7695
	ret ; $7698
Label_15_7699:
	call Func_15_7752 ; $7699
	ld hl, $1c6f ; $769c
	farcall FarPtr_0a_0e ; $769f
	call Func_15_7728 ; $76a2
	ret ; $76a5
Label_15_76a6:
	call Func_15_7752 ; $76a6
	ld hl, $1c73 ; $76a9
	farcall FarPtr_0a_0e ; $76ac
	call Func_15_7728 ; $76af
	ret ; $76b2
Label_15_76b3:
	call Func_15_7752 ; $76b3
	ld hl, $1c77 ; $76b6
	farcall FarPtr_0a_0e ; $76b9
	call Func_15_7728 ; $76bc
	ret ; $76bf
Label_15_76c0:
	call Func_15_7752 ; $76c0
	ld hl, $1c7b ; $76c3
	farcall FarPtr_0a_0e ; $76c6
	call Func_15_772d ; $76c9
	ret ; $76cc
Label_15_76cd:
	call Func_15_7752 ; $76cd
	ld hl, $1c90 ; $76d0
	farcall FarPtr_0a_0e ; $76d3
	call Func_15_7728 ; $76d6
	ret ; $76d9
Label_15_76da:
	call Func_15_7752 ; $76da
	ld hl, $1c94 ; $76dd
	farcall FarPtr_0a_0e ; $76e0
	call Func_15_772d ; $76e3
	ret ; $76e6
Label_15_76e7:
	call Func_15_7752 ; $76e7
	ld hl, $1cac ; $76ea
	farcall FarPtr_0a_0e ; $76ed
	call Func_15_7728 ; $76f0
	ret ; $76f3
Label_15_76f4:
	call Func_15_7752 ; $76f4
	ld hl, $1cb0 ; $76f7
	farcall FarPtr_0a_0e ; $76fa
	call Func_15_7728 ; $76fd
	ret ; $7700
Label_15_7701:
	call Func_15_7752 ; $7701
	ld hl, $1cb4 ; $7704
	farcall FarPtr_0a_0e ; $7707
	call Func_15_772d ; $770a
	ret ; $770d
Label_15_770e:
	call Func_15_7752 ; $770e
	ld hl, $1cbc ; $7711
	farcall FarPtr_0a_0e ; $7714
	call Func_15_7728 ; $7717
	ret ; $771a
Label_15_771b:
	call Func_15_7752 ; $771b
	ld hl, $1cc0 ; $771e
	farcall FarPtr_0a_0e ; $7721
	call Func_15_7728 ; $7724
	ret ; $7727
Func_15_7728:
	ld a, $12 ; $7728
	farcall FarPtr_ScriptShowSpeakerDialogue ; $772a
Func_15_772d:
	ld a, $12 ; $772d
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $772f
	farcall FarPtr_0a_12 ; $7732
	farcall FarPtr_ScriptCloseDialogueWindow ; $7735
	push af ; $7738
	ld a, $05 ; $7739
	farcall FarPtr_WaitScriptFrames ; $773b
	pop af ; $773e
	and a, a ; $773f
	jp z, Label_15_7749 ; $7740
	farcall FarPtr_0a_10 ; $7743
	jp Label_15_779d ; $7746
Label_15_7749:
	ld a, $12 ; $7749
	farcall FarPtr_ScriptShowSpeakerDialogue ; $774b
	call Func_15_7b30 ; $774e
	ret ; $7751
Func_15_7752:
	xor a, a ; $7752
	ld [$c2d5], a ; $7753
	ld bc, $00f0 ; $7756
	farcall FarPtr_0a_38 ; $7759
	ld a, $00 ; $775c
	ld bc, $2d00 ; $775e
	ld de, $2b00 ; $7761
	farcall FarPtr_ScriptSetActorPosition ; $7764
	ld a, $02 ; $7767
	ld bc, $2f00 ; $7769
	ld de, $2b00 ; $776c
	farcall FarPtr_ScriptSetActorPosition ; $776f
	xor a, a ; $7772
	ld bc, $2d00 ; $7773
	ld de, $2b00 ; $7776
	farcall FarPtr_MovePlayerToPosition ; $7779
	farcall FarPtr_WaitPlayerMoveDone ; $777c
	ld a, $00 ; $777f
	ld b, $c0 ; $7781
	farcall FarPtr_SetActorFacing ; $7783
	ld a, $02 ; $7786
	ld b, $c0 ; $7788
	farcall FarPtr_SetActorFacing ; $778a
	ld a, $12 ; $778d
	ld b, $40 ; $778f
	farcall FarPtr_SetActorFacing ; $7791
	ld c, $04 ; $7794
	call BeginFadeIn ; $7796
	call WaitFadeEnd ; $7799
	ret ; $779c
Label_15_779d:
	ld a, $12 ; $779d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $779f
	ld a, $12 ; $77a2
	ld b, $00 ; $77a4
	farcall FarPtr_SetActorFacing ; $77a6
	ret ; $77a9
Label_15_77aa:
	ld a, [$c2e3] ; $77aa
	ld a, a ; $77ad
	rst Rst00 ; $77ae
	dw Label_15_77e3 ; $77af jumptable
	dw Label_15_78f5 ; $77b1 jumptable
	dw Label_15_7902 ; $77b3 jumptable
	dw Label_15_790f ; $77b5 jumptable
	dw Label_15_791c ; $77b7 jumptable
	dw Label_15_7929 ; $77b9 jumptable
	dw Label_15_7929 ; $77bb jumptable
Label_15_77bd:
	ld a, [$c2e3] ; $77bd
	ld a, a ; $77c0
	rst Rst00 ; $77c1
	dw Label_15_784d ; $77c2 jumptable
	dw Label_15_7936 ; $77c4 jumptable
	dw Label_15_7943 ; $77c6 jumptable
	dw Label_15_7950 ; $77c8 jumptable
	dw Label_15_795d ; $77ca jumptable
	dw Label_15_7929 ; $77cc jumptable
	dw Label_15_78f5 ; $77ce jumptable
Label_15_77d0:
	ld a, [$c2e3] ; $77d0
	ld a, a ; $77d3
	rst Rst00 ; $77d4
	dw Label_15_78a1 ; $77d5 jumptable
	dw Label_15_796a ; $77d7 jumptable
	dw Label_15_7977 ; $77d9 jumptable
	dw Label_15_7984 ; $77db jumptable
	dw Label_15_7991 ; $77dd jumptable
	dw Label_15_7929 ; $77df jumptable
	dw Label_15_78f5 ; $77e1 jumptable
Label_15_77e3:
	call Func_15_79cb ; $77e3
	ld hl, $1cdd ; $77e6
	farcall FarPtr_0a_0e ; $77e9
	ld a, $0d ; $77ec
	farcall FarPtr_ScriptShowSpeakerDialogue ; $77ee
	ld a, $00 ; $77f1
	ld b, a ; $77f3
	ld a, $0d ; $77f4
	farcall FarPtr_FaceActorTowardActor ; $77f6
	ld a, $0d ; $77f9
	ld d, $03 ; $77fb
	farcall FarPtr_ScriptSetActorAnimation ; $77fd
	ld a, $0d ; $7800
	farcall FarPtr_ScriptWaitActorIdle ; $7802
	ld a, $0d ; $7805
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7807
	ld a, $0d ; $780a
	ld d, $02 ; $780c
	farcall FarPtr_ScriptSetActorAnimation ; $780e
	ld a, $0d ; $7811
	farcall FarPtr_ScriptWaitActorIdle ; $7813
	test_flag $0a, 3 ; $7816
	jr z, Label_15_781e ; $7819
	farcall FarPtr_0a_10 ; $781b
Label_15_781e:
	ld a, $0d ; $781e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7820
	ld hl, $1ce1 ; $7823
	farcall FarPtr_0a_0e ; $7826
	ld a, $0d ; $7829
	ld d, $04 ; $782b
	farcall FarPtr_ScriptSetActorAnimation ; $782d
	ld a, $0d ; $7830
	farcall FarPtr_ScriptWaitActorIdle ; $7832
	test_flag $0a, 3 ; $7835
	jr z, Label_15_783d ; $7838
	farcall FarPtr_0a_10 ; $783a
Label_15_783d:
	ld a, $0d ; $783d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $783f
	ld a, $0d ; $7842
	ld b, $c0 ; $7844
	farcall FarPtr_SetActorFacing ; $7846
	set_flag $17, 7 ; $7849
	ret ; $784c
Label_15_784d:
	call Func_15_79cb ; $784d
	ld hl, $1cf5 ; $7850
	farcall FarPtr_0a_0e ; $7853
	ld a, $0d ; $7856
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7858
	ld a, $00 ; $785b
	ld b, a ; $785d
	ld a, $0d ; $785e
	farcall FarPtr_FaceActorTowardActor ; $7860
	ld a, $0d ; $7863
	ld d, $03 ; $7865
	farcall FarPtr_ScriptSetActorAnimation ; $7867
	ld a, $0d ; $786a
	farcall FarPtr_ScriptWaitActorIdle ; $786c
	ld a, $0d ; $786f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7871
	ld a, $0d ; $7874
	ld d, $02 ; $7876
	farcall FarPtr_ScriptSetActorAnimation ; $7878
	ld a, $0d ; $787b
	farcall FarPtr_ScriptWaitActorIdle ; $787d
	ld a, $0d ; $7880
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7882
	ld a, $0d ; $7885
	ld d, $04 ; $7887
	farcall FarPtr_ScriptSetActorAnimation ; $7889
	ld a, $0d ; $788c
	farcall FarPtr_ScriptWaitActorIdle ; $788e
	ld a, $0d ; $7891
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7893
	ld a, $0d ; $7896
	ld b, $c0 ; $7898
	farcall FarPtr_SetActorFacing ; $789a
	set_flag $17, 7 ; $789d
	ret ; $78a0
Label_15_78a1:
	call Func_15_79cb ; $78a1
	ld hl, $200f ; $78a4
	farcall FarPtr_0a_0e ; $78a7
	ld a, $0d ; $78aa
	farcall FarPtr_ScriptShowSpeakerDialogue ; $78ac
	ld a, $00 ; $78af
	ld b, a ; $78b1
	ld a, $0d ; $78b2
	farcall FarPtr_FaceActorTowardActor ; $78b4
	ld a, $0d ; $78b7
	ld d, $03 ; $78b9
	farcall FarPtr_ScriptSetActorAnimation ; $78bb
	ld a, $0d ; $78be
	farcall FarPtr_ScriptWaitActorIdle ; $78c0
	ld a, $0d ; $78c3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $78c5
	ld a, $0d ; $78c8
	ld d, $02 ; $78ca
	farcall FarPtr_ScriptSetActorAnimation ; $78cc
	ld a, $0d ; $78cf
	farcall FarPtr_ScriptWaitActorIdle ; $78d1
	ld a, $0d ; $78d4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $78d6
	ld a, $0d ; $78d9
	ld d, $03 ; $78db
	farcall FarPtr_ScriptSetActorAnimation ; $78dd
	ld a, $0d ; $78e0
	farcall FarPtr_ScriptWaitActorIdle ; $78e2
	ld a, $0d ; $78e5
	farcall FarPtr_ScriptShowSpeakerDialogue ; $78e7
	ld a, $0d ; $78ea
	ld b, $c0 ; $78ec
	farcall FarPtr_SetActorFacing ; $78ee
	set_flag $17, 7 ; $78f1
	ret ; $78f4
Label_15_78f5:
	call Func_15_79cb ; $78f5
	ld hl, $1ccb ; $78f8
	farcall FarPtr_0a_0e ; $78fb
	call Func_15_799e ; $78fe
	ret ; $7901
Label_15_7902:
	call Func_15_79cb ; $7902
	ld hl, $1ccf ; $7905
	farcall FarPtr_0a_0e ; $7908
	call Func_15_799e ; $790b
	ret ; $790e
Label_15_790f:
	call Func_15_79cb ; $790f
	ld hl, $1cd3 ; $7912
	farcall FarPtr_0a_0e ; $7915
	call Func_15_799e ; $7918
	ret ; $791b
Label_15_791c:
	call Func_15_79cb ; $791c
	ld hl, $1cd7 ; $791f
	farcall FarPtr_0a_0e ; $7922
	call Func_15_79a3 ; $7925
	ret ; $7928
Label_15_7929:
	call Func_15_79cb ; $7929
	ld hl, $1cda ; $792c
	farcall FarPtr_0a_0e ; $792f
	call Func_15_79a3 ; $7932
	ret ; $7935
Label_15_7936:
	call Func_15_79cb ; $7936
	ld hl, $1ce9 ; $7939
	farcall FarPtr_0a_0e ; $793c
	call Func_15_79a3 ; $793f
	ret ; $7942
Label_15_7943:
	call Func_15_79cb ; $7943
	ld hl, $1cec ; $7946
	farcall FarPtr_0a_0e ; $7949
	call Func_15_79a3 ; $794c
	ret ; $794f
Label_15_7950:
	call Func_15_79cb ; $7950
	ld hl, $1cef ; $7953
	farcall FarPtr_0a_0e ; $7956
	call Func_15_79a3 ; $7959
	ret ; $795c
Label_15_795d:
	call Func_15_79cb ; $795d
	ld hl, $1cf2 ; $7960
	farcall FarPtr_0a_0e ; $7963
	call Func_15_79a3 ; $7966
	ret ; $7969
Label_15_796a:
	call Func_15_79cb ; $796a
	ld hl, $1cff ; $796d
	farcall FarPtr_0a_0e ; $7970
	call Func_15_799e ; $7973
	ret ; $7976
Label_15_7977:
	call Func_15_79cb ; $7977
	ld hl, $2003 ; $797a
	farcall FarPtr_0a_0e ; $797d
	call Func_15_799e ; $7980
	ret ; $7983
Label_15_7984:
	call Func_15_79cb ; $7984
	ld hl, $2007 ; $7987
	farcall FarPtr_0a_0e ; $798a
	call Func_15_799e ; $798d
	ret ; $7990
Label_15_7991:
	call Func_15_79cb ; $7991
	ld hl, $200b ; $7994
	farcall FarPtr_0a_0e ; $7997
	call Func_15_799e ; $799a
	ret ; $799d
Func_15_799e:
	ld a, $0d ; $799e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $79a0
Func_15_79a3:
	ld a, $0d ; $79a3
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $79a5
	farcall FarPtr_0a_12 ; $79a8
	farcall FarPtr_ScriptCloseDialogueWindow ; $79ab
	push af ; $79ae
	ld a, $05 ; $79af
	farcall FarPtr_WaitScriptFrames ; $79b1
	pop af ; $79b4
	and a, a ; $79b5
	jp z, Label_15_79bc ; $79b6
	jp Label_15_7a16 ; $79b9
Label_15_79bc:
	farcall FarPtr_0a_10 ; $79bc
	ld a, $0d ; $79bf
	farcall FarPtr_ScriptShowSpeakerDialogue ; $79c1
	call Func_15_7bc9 ; $79c4
	farcall FarPtr_0a_02 ; $79c7
	ret ; $79ca
Func_15_79cb:
	xor a, a ; $79cb
	ld [$c2d5], a ; $79cc
	ld bc, $00f0 ; $79cf
	farcall FarPtr_0a_38 ; $79d2
	ld a, $00 ; $79d5
	ld bc, $1300 ; $79d7
	ld de, $2b00 ; $79da
	farcall FarPtr_ScriptSetActorPosition ; $79dd
	ld a, $02 ; $79e0
	ld bc, $1100 ; $79e2
	ld de, $2b00 ; $79e5
	farcall FarPtr_ScriptSetActorPosition ; $79e8
	xor a, a ; $79eb
	ld bc, $1300 ; $79ec
	ld de, $2b00 ; $79ef
	farcall FarPtr_MovePlayerToPosition ; $79f2
	farcall FarPtr_WaitPlayerMoveDone ; $79f5
	ld a, $00 ; $79f8
	ld b, $c0 ; $79fa
	farcall FarPtr_SetActorFacing ; $79fc
	ld a, $02 ; $79ff
	ld b, $c0 ; $7a01
	farcall FarPtr_SetActorFacing ; $7a03
	ld a, $0d ; $7a06
	ld b, $40 ; $7a08
	farcall FarPtr_SetActorFacing ; $7a0a
	ld c, $04 ; $7a0d
	call BeginFadeIn ; $7a0f
	call WaitFadeEnd ; $7a12
	ret ; $7a15
Label_15_7a16:
	ld a, $0d ; $7a16
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7a18
	ld a, $0d ; $7a1b
	ld b, $c0 ; $7a1d
	farcall FarPtr_SetActorFacing ; $7a1f
	ret ; $7a22
	INCBIN "data/bank_015/d_7a23.bin" ; $7a23, 34 bytes
Func_15_7a45:
	test_flag $05, 7 ; $7a45
	jp nz, Label_15_7a66 ; $7a48
	ld a, [wEquippedRacket] ; $7a4b
	and a, $0f ; $7a4e
	cp a, $03 ; $7a50
	jp nz, Label_15_7a66 ; $7a52
	test_flag $10, 0 ; $7a55
	jp nz, Label_15_7a66 ; $7a58
	ld a, $13 ; $7a5b
	ld bc, $3500 ; $7a5d
	ld de, $0f00 ; $7a60
	farcall FarPtr_ScriptSetActorPosition ; $7a63
Label_15_7a66:
	ret ; $7a66
Func_15_7a67:
	ld a, [$c8f7] ; $7a67
	cp a, $06 ; $7a6a
	jr nc, Label_15_7a75 ; $7a6c
	call Func_15_74e1 ; $7a6e
	call Func_15_7a96 ; $7a71
	ret ; $7a74
Label_15_7a75:
	cp a, $0c ; $7a75
	jr nc, Label_15_7a8b ; $7a77
	call Func_15_7752 ; $7a79
	ld hl, $1c6a ; $7a7c
	farcall FarPtr_0a_0e ; $7a7f
	ld a, $12 ; $7a82
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7a84
	call Func_15_7b30 ; $7a87
	ret ; $7a8a
Label_15_7a8b:
	cp a, $12 ; $7a8b
	jr nc, Label_15_7a95 ; $7a8d
	call Func_15_79cb ; $7a8f
	call Func_15_7bc9 ; $7a92
Label_15_7a95:
	ret ; $7a95
Func_15_7a96:
	ld a, $02 ; $7a96
	farcall FarPtr_0a_1c ; $7a98
	ld bc, $0020 ; $7a9b
	farcall FarPtr_0a_38 ; $7a9e
	push af ; $7aa1
	ld a, $14 ; $7aa2
	farcall FarPtr_WaitScriptFrames ; $7aa4
	pop af ; $7aa7
	ldh a, [hRomBank] ; $7aa8
	ld b, a ; $7aaa
	ld a, $07 ; $7aab
	ld de, $7b03 ; $7aad
	farcall FarPtr_0a_1a ; $7ab0
	ldh a, [hRomBank] ; $7ab3
	ld b, a ; $7ab5
	ld a, $00 ; $7ab6
	ld de, $7b1a ; $7ab8
	farcall FarPtr_0a_1a ; $7abb
	ldh a, [hRomBank] ; $7abe
	ld b, a ; $7ac0
	ld a, $02 ; $7ac1
	ld de, $7b25 ; $7ac3
	farcall FarPtr_0a_1a ; $7ac6
	xor a, a ; $7ac9
	ld bc, $1800 ; $7aca
	ld de, $0f00 ; $7acd
	farcall FarPtr_MovePlayerToPosition ; $7ad0
	ld a, $00 ; $7ad3
	farcall FarPtr_WaitActorScriptDone ; $7ad5
	farcall FarPtr_WaitPlayerMoveDone ; $7ad8
	ld a, $07 ; $7adb
	farcall FarPtr_WaitActorScriptDone ; $7add
	push af ; $7ae0
	ld a, $05 ; $7ae1
	farcall FarPtr_WaitScriptFrames ; $7ae3
	pop af ; $7ae6
	call Func_15_6647 ; $7ae7
	ld a, $0f ; $7aea
	ld [wStoryModeCurrentLocation], a ; $7aec
	ld a, $0a ; $7aef
	ld [$c295], a ; $7af1
	ld a, $ff ; $7af4
	ld [$c294], a ; $7af6
	ld [$c2a1], a ; $7af9
	ld a, [$c8f7] ; $7afc
	farcall FarPtr_0b_00 ; $7aff
	ret ; $7b02
	INCBIN "data/bank_015/d_7b03.bin" ; $7b03, 45 bytes
Func_15_7b30:
	ld bc, $0020 ; $7b30
	farcall FarPtr_0a_38 ; $7b33
	ld a, $02 ; $7b36
	farcall FarPtr_0a_1c ; $7b38
	ldh a, [hRomBank] ; $7b3b
	ld b, a ; $7b3d
	ld a, $12 ; $7b3e
	ld de, $7b96 ; $7b40
	farcall FarPtr_0a_1a ; $7b43
	ldh a, [hRomBank] ; $7b46
	ld b, a ; $7b48
	ld a, $00 ; $7b49
	ld de, $7bb3 ; $7b4b
	farcall FarPtr_0a_1a ; $7b4e
	ldh a, [hRomBank] ; $7b51
	ld b, a ; $7b53
	ld a, $02 ; $7b54
	ld de, $7bbe ; $7b56
	farcall FarPtr_0a_1a ; $7b59
	xor a, a ; $7b5c
	ld bc, $2800 ; $7b5d
	ld de, $2600 ; $7b60
	farcall FarPtr_MovePlayerToPosition ; $7b63
	ld a, $00 ; $7b66
	farcall FarPtr_WaitActorScriptDone ; $7b68
	farcall FarPtr_WaitPlayerMoveDone ; $7b6b
	ld a, $12 ; $7b6e
	farcall FarPtr_WaitActorScriptDone ; $7b70
	push af ; $7b73
	ld a, $05 ; $7b74
	farcall FarPtr_WaitScriptFrames ; $7b76
	pop af ; $7b79
	call Func_15_6647 ; $7b7a
	ld a, $0f ; $7b7d
	ld [wStoryModeCurrentLocation], a ; $7b7f
	ld a, $0a ; $7b82
	ld [$c295], a ; $7b84
	ld a, $ff ; $7b87
	ld [$c294], a ; $7b89
	ld [$c2a1], a ; $7b8c
	ld a, [$c8f7] ; $7b8f
	farcall FarPtr_0b_00 ; $7b92
	ret ; $7b95
	INCBIN "data/bank_015/d_7b96.bin" ; $7b96, 51 bytes
Func_15_7bc9:
	ld a, $02 ; $7bc9
	farcall FarPtr_0a_1c ; $7bcb
	ld bc, $0020 ; $7bce
	farcall FarPtr_0a_38 ; $7bd1
	ldh a, [hRomBank] ; $7bd4
	ld b, a ; $7bd6
	ld a, $0d ; $7bd7
	ld de, $7c2f ; $7bd9
	farcall FarPtr_0a_1a ; $7bdc
	ldh a, [hRomBank] ; $7bdf
	ld b, a ; $7be1
	ld a, $00 ; $7be2
	ld de, $7c4c ; $7be4
	farcall FarPtr_0a_1a ; $7be7
	ldh a, [hRomBank] ; $7bea
	ld b, a ; $7bec
	ld a, $02 ; $7bed
	ld de, $7c57 ; $7bef
	farcall FarPtr_0a_1a ; $7bf2
	xor a, a ; $7bf5
	ld bc, $1800 ; $7bf6
	ld de, $2700 ; $7bf9
	farcall FarPtr_MovePlayerToPosition ; $7bfc
	ld a, $00 ; $7bff
	farcall FarPtr_WaitActorScriptDone ; $7c01
	farcall FarPtr_WaitPlayerMoveDone ; $7c04
	ld a, $0d ; $7c07
	farcall FarPtr_WaitActorScriptDone ; $7c09
	push af ; $7c0c
	ld a, $05 ; $7c0d
	farcall FarPtr_WaitScriptFrames ; $7c0f
	pop af ; $7c12
	call Func_15_6647 ; $7c13
	ld a, $0f ; $7c16
	ld [wStoryModeCurrentLocation], a ; $7c18
	ld a, $0a ; $7c1b
	ld [$c295], a ; $7c1d
	ld a, $ff ; $7c20
	ld [$c294], a ; $7c22
	ld [$c2a1], a ; $7c25
	ld a, [$c8f7] ; $7c28
	farcall FarPtr_0b_00 ; $7c2b
	ret ; $7c2e
	INCBIN "data/bank_015/d_7c2f.bin" ; $7c2f, 140 bytes
Func_15_7cbb:
	ld a, $00 ; $7cbb
	ld bc, $0010 ; $7cbd
	farcall FarPtr_0a_18 ; $7cc0
	ld a, $02 ; $7cc3
	ld bc, $0010 ; $7cc5
	farcall FarPtr_0a_18 ; $7cc8
	ld a, $00 ; $7ccb
	ld bc, $2d00 ; $7ccd
	ld de, $2b00 ; $7cd0
	farcall FarPtr_ScriptSetActorMoveTarget ; $7cd3
	test_flag $05, 7 ; $7cd6
	jr z, Label_15_7cf0 ; $7cd9
	ld a, $02 ; $7cdb
	farcall FarPtr_0a_1c ; $7cdd
	ld a, $02 ; $7ce0
	ld bc, $2f00 ; $7ce2
	ld de, $2b00 ; $7ce5
	farcall FarPtr_ScriptSetActorMoveTarget ; $7ce8
	ld a, $02 ; $7ceb
	farcall FarPtr_ScriptWaitActorMoveDone ; $7ced
Label_15_7cf0:
	ld a, $00 ; $7cf0
	farcall FarPtr_ScriptWaitActorMoveDone ; $7cf2
	ld a, $00 ; $7cf5
	ld b, $80 ; $7cf7
	farcall FarPtr_SetActorFacing ; $7cf9
	ld a, $02 ; $7cfc
	ld b, $80 ; $7cfe
	farcall FarPtr_SetActorFacing ; $7d00
	ld a, $00 ; $7d03
	ld bc, $0020 ; $7d05
	farcall FarPtr_0a_18 ; $7d08
	ld a, $02 ; $7d0b
	ld bc, $0020 ; $7d0d
	farcall FarPtr_0a_18 ; $7d10
	ret ; $7d13
Func_15_7d14:
	ld a, $00 ; $7d14
	ld bc, $0010 ; $7d16
	farcall FarPtr_0a_18 ; $7d19
	ld a, $02 ; $7d1c
	ld bc, $0010 ; $7d1e
	farcall FarPtr_0a_18 ; $7d21
	ld a, $00 ; $7d24
	ld bc, $1300 ; $7d26
	ld de, $2b00 ; $7d29
	farcall FarPtr_ScriptSetActorMoveTarget ; $7d2c
	test_flag $05, 7 ; $7d2f
	jr z, Label_15_7d49 ; $7d32
	ld a, $02 ; $7d34
	farcall FarPtr_0a_1c ; $7d36
	ld a, $02 ; $7d39
	ld bc, $1100 ; $7d3b
	ld de, $2b00 ; $7d3e
	farcall FarPtr_ScriptSetActorMoveTarget ; $7d41
	ld a, $02 ; $7d44
	farcall FarPtr_ScriptWaitActorMoveDone ; $7d46
Label_15_7d49:
	ld a, $00 ; $7d49
	farcall FarPtr_ScriptWaitActorMoveDone ; $7d4b
	ld a, $00 ; $7d4e
	ld b, $00 ; $7d50
	farcall FarPtr_SetActorFacing ; $7d52
	ld a, $02 ; $7d55
	ld b, $00 ; $7d57
	farcall FarPtr_SetActorFacing ; $7d59
	ld a, $00 ; $7d5c
	ld bc, $0020 ; $7d5e
	farcall FarPtr_0a_18 ; $7d61
	ld a, $02 ; $7d64
	ld bc, $0020 ; $7d66
	farcall FarPtr_0a_18 ; $7d69
	ret ; $7d6c
	INCBIN "data/bank_015/d_7d6d.bin" ; $7d6d, 40 bytes
	ret ; $7d95
	INCBIN "data/bank_015/d_7d96.bin" ; $7d96, 522 bytes
ComputeTrainingCourtProgressIndex:
	ld a, $00 ; $7fa0
	test_flag $0a, 3 ; $7fa2
	jr z, Label_15_7fbf ; $7fa5
	inc a ; $7fa7
	test_flag $0a, 7 ; $7fa8
	jr z, Label_15_7fbf ; $7fab
	inc a ; $7fad
	test_flag $05, 7 ; $7fae
	jr nz, Label_15_7fc3 ; $7fb1
	test_flag $15, 6 ; $7fb3
	jr z, Label_15_7fbf ; $7fb6
	inc a ; $7fb8
	test_flag $16, 0 ; $7fb9
	jr z, Label_15_7fbf ; $7fbc
	inc a ; $7fbe
Label_15_7fbf:
	ld [$c2b0], a ; $7fbf
	ret ; $7fc2
Label_15_7fc3:
	test_flag $15, 7 ; $7fc3
	jr z, Label_15_7fbf ; $7fc6
	inc a ; $7fc8
	test_flag $16, 1 ; $7fc9
	jr z, Label_15_7fbf ; $7fcc
	inc a ; $7fce
	jr Label_15_7fbf ; $7fcf
	ds 47, $ff ; $7fd1, fill

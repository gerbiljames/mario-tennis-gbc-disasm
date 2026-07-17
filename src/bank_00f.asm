SECTION "ROM Bank $0f", ROMX[$4000], BANK[$0f]

	; $4000, 6 bytes (records:2)
; 3 records x 2 bytes
	dw $4006 ; record 0
	dw $41db ; record 1
	dw $5f94 ; record 2
	; $4006, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $40c6 ; record 0
	dw $40cf ; record 1
	dw $4014 ; record 2
	dw $4138 ; record 3
	dw $4199 ; record 4
	dw $419b ; record 5
	dw $41a4 ; record 6
	; $4014, 178 bytes (bytes:14)
	db $00, $00, $57, $7b, $00, $07, $00, $03, $40, $00, $26, $01, $00, $00 ; 0x00
	db $00, $00, $57, $7b, $00, $0d, $00, $03, $40, $00, $2b, $01, $00, $00 ; 0x0e
	db $00, $00, $57, $7b, $00, $07, $00, $07, $40, $00, $2c, $01, $00, $00 ; 0x1c
	db $00, $00, $57, $7b, $00, $0d, $00, $07, $40, $00, $2d, $01, $00, $00 ; 0x2a
	db $00, $00, $57, $7b, $00, $05, $00, $0d, $40, $00, $70, $01, $00, $00 ; 0x38
	db $00, $00, $57, $7b, $00, $09, $00, $0d, $40, $00, $71, $01, $00, $00 ; 0x46
	db $00, $00, $57, $7b, $00, $0d, $00, $0d, $40, $00, $72, $01, $00, $00 ; 0x54
	db $00, $00, $57, $7b, $00, $11, $00, $0d, $40, $00, $73, $01, $00, $00 ; 0x62
	db $00, $00, $57, $7b, $00, $05, $00, $11, $40, $00, $6d, $01, $00, $00 ; 0x70
	db $00, $00, $57, $7b, $00, $09, $00, $11, $40, $00, $6e, $01, $00, $00 ; 0x7e
	db $00, $00, $57, $7b, $00, $0d, $00, $11, $40, $00, $48, $01, $00, $00 ; 0x8c
	db $00, $00, $57, $7b, $00, $11, $00, $11, $40, $00, $2b, $01, $00, $00 ; 0x9a
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xa8
	; $40c6, 10 bytes (bytes:16)
	db $01, $40, $00, $0b, $00, $0b, $00, $00, $ff, $ff ; 0x00
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
	call Func_0f_41c5 ; $40f0
	ret ; $40f3
	ld hl, $c2b0 ; $40f4
	ld a, [hl] ; $40f7
	inc [hl] ; $40f8
	and a, $03 ; $40f9
	add a, $26 ; $40fb
	call Func_0f_41c5 ; $40fd
	ret ; $4100
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
	call Func_0f_41c5 ; $4123
	ret ; $4126
	ld a, $00 ; $4127
	ld d, $03 ; $4129
	farcall FarPtr_ScriptSetActorAnimation ; $412b
	ret ; $412e
	ld a, $00 ; $412f
	ld d, $04 ; $4131
	farcall FarPtr_ScriptSetActorAnimation ; $4133
	ret ; $4136
	ret ; $4137
	; $4138, 98 bytes (records:8)
; 12 records x 8 bytes
	dw $ff03, $0000, $40f4, $0000 ; record 0
	dw $ff04, $0000, $4101, $0000 ; record 1
	dw $ff05, $0000, $4127, $0000 ; record 2
	dw $ff06, $0000, $412f, $0000 ; record 3
	dw $ff07, $0000, $4137, $0001 ; record 4
	dw $ff08, $0000, $4137, $0001 ; record 5
	dw $ff09, $0000, $4137, $0001 ; record 6
	dw $ff0a, $0000, $4137, $0001 ; record 7
	dw $ff0b, $0000, $4137, $0001 ; record 8
	dw $ff0c, $0000, $4137, $0001 ; record 9
	dw $ff0d, $0000, $4137, $0001 ; record 10
	dw $ff0e, $0000, $4137, $0001 ; record 11
	db $ff, $ff
	ret ; $419a
	; $419b, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $419a, $0000 ; record 0
	db $ff
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
	ld a, $00 ; $41bd
	ld d, $01 ; $41bf
	farcall FarPtr_ScriptSetActorAnimation ; $41c1
Label_0f_41c4:
	ret ; $41c4
Func_0f_41c5:
	ld d, a ; $41c5
	wram_bank $04 ; $41c6
	ld hl, $dae9 ; $41cc
	ld [hl], $00 ; $41cf
	ld bc, $d000 ; $41d1
	farcall FarPtr_04_2c ; $41d4
	call RestorePalettesFromMaster ; $41d7
	ret ; $41da
	; $41db, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $442d ; record 0
	dw $4446 ; record 1
	dw $41e9 ; record 2
	dw $4447 ; record 3
	dw $4498 ; record 4
	dw $44a2 ; record 5
	dw $5581 ; record 6
	; $41e9, 580 bytes (bytes:14)
	db $00, $00, $57, $7b, $00, $0b, $00, $27, $c0, $00, $5c, $01, $00, $00 ; 0x00
	db $00, $00, $57, $7b, $00, $0d, $00, $27, $c0, $00, $61, $01, $00, $00 ; 0x0e
	db $00, $00, $57, $7b, $80, $0e, $00, $1b, $80, $00, $62, $01, $00, $00 ; 0x1c
	db $00, $00, $57, $7b, $00, $08, $00, $1f, $00, $00, $5d, $01, $00, $00 ; 0x2a
	db $00, $00, $57, $7b, $00, $07, $00, $21, $00, $00, $5e, $01, $00, $00 ; 0x38
	db $00, $00, $57, $7b, $00, $08, $00, $1d, $00, $00, $5f, $01, $00, $00 ; 0x46
	db $00, $00, $57, $7b, $00, $0f, $00, $1d, $80, $00, $24, $01, $00, $00 ; 0x54
	db $00, $00, $57, $7b, $80, $09, $00, $1b, $00, $00, $23, $01, $00, $00 ; 0x62
	db $00, $00, $57, $7b, $00, $08, $40, $19, $00, $00, $25, $01, $05, $00 ; 0x70
	db $00, $00, $57, $7b, $00, $08, $00, $17, $00, $00, $63, $01, $00, $00 ; 0x7e
	db $00, $00, $57, $7b, $c0, $0e, $80, $17, $40, $00, $74, $01, $00, $00 ; 0x8c
	db $00, $00, $57, $7b, $40, $10, $c0, $17, $40, $00, $74, $01, $00, $00 ; 0x9a
	db $00, $00, $57, $7b, $80, $11, $c0, $17, $40, $00, $74, $01, $00, $00 ; 0xa8
	db $00, $00, $57, $7b, $00, $0f, $00, $16, $80, $00, $25, $01, $00, $00 ; 0xb6
	db $00, $00, $57, $7b, $00, $11, $00, $21, $80, $00, $5b, $01, $00, $00 ; 0xc4
	db $00, $00, $57, $7b, $00, $10, $00, $1f, $80, $00, $5a, $01, $00, $00 ; 0xd2
	db $00, $00, $57, $7b, $00, $fd, $00, $01, $40, $00, $4e, $01, $00, $00 ; 0xe0
	db $00, $00, $57, $7b, $00, $fd, $00, $01, $40, $00, $53, $01, $00, $00 ; 0xee
	db $00, $00, $57, $7b, $00, $fd, $00, $01, $40, $00, $4d, $01, $00, $00 ; 0xfc
	db $00, $00, $57, $7b, $00, $fd, $00, $01, $40, $00, $26, $01, $00, $00 ; 0x10a
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff, $00, $00, $57, $7b ; 0x118
	db $00, $0f, $00, $1b, $80, $00, $5c, $01, $00, $00, $00, $00, $57, $7b ; 0x126
	db $00, $0d, $00, $27, $c0, $00, $61, $01, $00, $00, $00, $00, $57, $7b ; 0x134
	db $00, $0d, $00, $29, $c0, $00, $62, $01, $00, $00, $00, $00, $57, $7b ; 0x142
	db $00, $08, $00, $1f, $00, $00, $5d, $01, $00, $00, $00, $00, $57, $7b ; 0x150
	db $00, $07, $00, $21, $00, $00, $5e, $01, $00, $00, $00, $00, $57, $7b ; 0x15e
	db $00, $08, $00, $1d, $00, $00, $5f, $01, $00, $00, $00, $00, $57, $7b ; 0x16c
	db $00, $0f, $00, $1d, $80, $00, $24, $01, $00, $00, $00, $00, $57, $7b ; 0x17a
	db $00, $09, $00, $1b, $00, $00, $23, $01, $00, $00, $00, $00, $57, $7b ; 0x188
	db $00, $08, $40, $19, $00, $00, $25, $01, $05, $00, $00, $00, $57, $7b ; 0x196
	db $00, $08, $00, $17, $00, $00, $63, $01, $00, $00, $00, $00, $57, $7b ; 0x1a4
	db $00, $0f, $80, $17, $40, $00, $74, $01, $00, $00, $00, $00, $57, $7b ; 0x1b2
	db $00, $11, $c0, $17, $40, $00, $74, $01, $00, $00, $00, $00, $57, $7b ; 0x1c0
	db $00, $29, $00, $29, $40, $00, $74, $01, $00, $00, $00, $00, $57, $7b ; 0x1ce
	db $00, $0f, $00, $16, $80, $00, $25, $01, $00, $00, $00, $00, $57, $7b ; 0x1dc
	db $00, $2f, $00, $21, $80, $00, $5b, $01, $00, $00, $00, $00, $57, $7b ; 0x1ea
	db $00, $10, $00, $20, $80, $00, $5a, $01, $00, $00, $00, $00, $57, $7b ; 0x1f8
	db $00, $fd, $00, $01, $40, $00, $4e, $01, $00, $00, $00, $00, $57, $7b ; 0x206
	db $00, $fd, $00, $01, $40, $00, $53, $01, $00, $00, $00, $00, $57, $7b ; 0x214
	db $00, $fd, $00, $01, $40, $00, $4d, $01, $00, $00, $00, $00, $57, $7b ; 0x222
	db $00, $fd, $00, $01, $40, $00, $26, $01, $00, $00, $00, $00, $00, $00 ; 0x230
	db $00, $00, $00, $00, $00, $ff ; 0x23e
	; $442d, 26 bytes (bytes:16)
	db $01, $c0, $00, $0c, $00, $29, $00, $00, $0a, $c0, $00, $0c, $00, $29, $00, $00 ; 0x00
	db $0b, $c0, $00, $0b, $00, $29, $00, $00, $ff, $ff ; 0x10
	; $4447, 81 bytes (records:8)
; 10 records x 8 bytes
	dw $ff03, $0000, $0000, $0003 ; record 0
	dw $ff04, $0000, $2873, $0003 ; record 1
	dw $ff05, $0000, $2884, $0003 ; record 2
	dw $ff06, $0000, $287a, $0003 ; record 3
	dw $ff07, $0000, $287c, $0003 ; record 4
	dw $ff08, $0000, $5628, $0003 ; record 5
	dw $ff09, $0000, $2882, $0003 ; record 6
	dw $ff0a, $0000, $2883, $0003 ; record 7
	dw $ff11, $0000, $2879, $0003 ; record 8
	dw $ff12, $0000, $287b, $0003 ; record 9
	db $ff
	; $4498, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $44a1, $0000 ; record 0
	db $ff
	ret ; $44a1
	; $44a2, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $ff01, $0000, $44b3, $0000 ; record 0
	dw $ff02, $0000, $4725, $0000 ; record 1
	db $ff
	ld b, $0a ; $44b3
	ld c, $1c ; $44b5
	ld d, $0a ; $44b7
	ld e, $1a ; $44b9
	ld h, $04 ; $44bb
	ld l, $02 ; $44bd
	farcall FarPtr_0a_82 ; $44bf
	call Func_0f_567f ; $44c2
	call Func_0f_567f ; $44c5
	ld hl, $287e ; $44c8
	farcall FarPtr_0a_0e ; $44cb
	ld a, $08 ; $44ce
	farcall FarPtr_ScriptShowSpeakerDialogue ; $44d0
	test_flag $05, 7 ; $44d3
	jp z, Label_0f_45b6 ; $44d6
	set_flag $10, 4 ; $44d9
	ld hl, $28b4 ; $44dc
	farcall FarPtr_0a_0e ; $44df
	ld a, $02 ; $44e2
	farcall FarPtr_0a_1c ; $44e4
	ld a, $02 ; $44e7
	ld bc, $0d00 ; $44e9
	ld de, $1b00 ; $44ec
	farcall FarPtr_ScriptSetActorMoveTarget ; $44ef
	ld a, $02 ; $44f2
	farcall FarPtr_ScriptWaitActorMoveDone ; $44f4
	ld a, $00 ; $44f7
	ld bc, $0b00 ; $44f9
	ld de, $1b00 ; $44fc
	farcall FarPtr_ScriptSetActorMoveTarget ; $44ff
	ld a, $00 ; $4502
	farcall FarPtr_ScriptWaitActorMoveDone ; $4504
	call Func_0f_5641 ; $4507
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
	ld a, $15 ; $4526
	ld d, $01 ; $4528
	farcall FarPtr_ScriptSetActorAnimation ; $452a
	ld a, $02 ; $452d
	ld bc, $3f00 ; $452f
	ld de, $3f00 ; $4532
	farcall FarPtr_ScriptSetActorPosition ; $4535
	ld a, $15 ; $4538
	ld bc, $0d00 ; $453a
	ld de, $1b00 ; $453d
	farcall FarPtr_ScriptSetActorPosition ; $4540
	ld a, $16 ; $4543
	ld b, $40 ; $4545
	farcall FarPtr_SetActorFacing ; $4547
	ld a, $15 ; $454a
	ld b, $40 ; $454c
	farcall FarPtr_SetActorFacing ; $454e
	ld a, $08 ; $4551
	ld bc, $0c00 ; $4553
	ld de, $1d00 ; $4556
	farcall FarPtr_ScriptSetActorMoveTarget ; $4559
	ld a, $08 ; $455c
	farcall FarPtr_ScriptWaitActorMoveDone ; $455e
	ld a, $08 ; $4561
	ld b, $c0 ; $4563
	farcall FarPtr_SetActorFacing ; $4565
	ld a, $13 ; $4568
	ld bc, $0d80 ; $456a
	ld de, $1b00 ; $456d
	farcall FarPtr_ScriptSetActorPosition ; $4570
	sound $99 ; $4573
	ld a, $08 ; $4575
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4577
	ld a, $13 ; $457a
	ld bc, $3f00 ; $457c
	ld de, $3f00 ; $457f
	farcall FarPtr_ScriptSetActorPosition ; $4582
	ld a, $08 ; $4585
	ld d, $02 ; $4587
	farcall FarPtr_ScriptSetActorAnimation ; $4589
	ld a, $08 ; $458c
	farcall FarPtr_ScriptWaitActorIdle ; $458e
	ld a, $08 ; $4591
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4593
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
	farcall FarPtr_0a_1c ; $45bb
	ld a, $00 ; $45be
	ld bc, $0b80 ; $45c0
	ld de, $1b00 ; $45c3
	farcall FarPtr_ScriptSetActorMoveTarget ; $45c6
	ld a, $00 ; $45c9
	farcall FarPtr_ScriptWaitActorMoveDone ; $45cb
	call Func_0f_5641 ; $45ce
	ld a, $16 ; $45d1
	ld bc, $0b80 ; $45d3
	ld de, $1b00 ; $45d6
	farcall FarPtr_ScriptSetActorPosition ; $45d9
	ld a, $03 ; $45dc
	ld bc, $0d00 ; $45de
	ld de, $1d00 ; $45e1
	farcall FarPtr_ScriptSetActorMoveTarget ; $45e4
	ld a, $03 ; $45e7
	farcall FarPtr_ScriptWaitActorMoveDone ; $45e9
	ld a, $03 ; $45ec
	ld b, $80 ; $45ee
	farcall FarPtr_SetActorFacing ; $45f0
	ld a, $01 ; $45f3
	call DelayFrames ; $45f5
	ld a, $08 ; $45f8
	ld bc, $0b00 ; $45fa
	ld de, $1d00 ; $45fd
	farcall FarPtr_ScriptSetActorMoveTarget ; $4600
	ld a, $08 ; $4603
	farcall FarPtr_ScriptWaitActorMoveDone ; $4605
	ld a, $16 ; $4608
	ld b, $40 ; $460a
	farcall FarPtr_SetActorFacing ; $460c
	ld a, $08 ; $460f
	ld b, $c0 ; $4611
	farcall FarPtr_SetActorFacing ; $4613
	ld a, $13 ; $4616
	ld bc, $0c80 ; $4618
	ld de, $1b00 ; $461b
	farcall FarPtr_ScriptSetActorPosition ; $461e
	sound $99 ; $4621
	ld a, $08 ; $4623
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4625
	ld a, $13 ; $4628
	ld bc, $3f00 ; $462a
	ld de, $3f00 ; $462d
	farcall FarPtr_ScriptSetActorPosition ; $4630
	ld a, $08 ; $4633
	ld d, $02 ; $4635
	farcall FarPtr_ScriptSetActorAnimation ; $4637
	ld a, $08 ; $463a
	farcall FarPtr_ScriptWaitActorIdle ; $463c
	ld a, $08 ; $463f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4641
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
	call Func_0f_567f ; $4661
	call Func_0f_567f ; $4664
	ld a, $08 ; $4667
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4669
	call Func_0f_567f ; $466c
	call Func_0f_567f ; $466f
	ld a, $08 ; $4672
	ld bc, $0900 ; $4674
	ld de, $1d00 ; $4677
	farcall FarPtr_ScriptSetActorMoveTarget ; $467a
	ld a, $08 ; $467d
	farcall FarPtr_ScriptWaitActorMoveDone ; $467f
	ld a, $08 ; $4682
	ld b, $00 ; $4684
	farcall FarPtr_SetActorFacing ; $4686
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
	ld a, $15 ; $46b6
	ld d, $01 ; $46b8
	farcall FarPtr_ScriptSetActorAnimation ; $46ba
	ld a, $00 ; $46bd
	ld b, $40 ; $46bf
	farcall FarPtr_SetActorFacing ; $46c1
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
	ld a, $00 ; $46df
	ld b, $40 ; $46e1
	farcall FarPtr_SetActorFacing ; $46e3
	ld a, $02 ; $46e6
	ld b, $40 ; $46e8
	farcall FarPtr_SetActorFacing ; $46ea
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
	ld a, $00 ; $470b
	ld b, $40 ; $470d
	farcall FarPtr_SetActorFacing ; $470f
	ld a, $01 ; $4712
	call DelayFrames ; $4714
	ld a, $03 ; $4717
	farcall FarPtr_GetActorStateAddr ; $4719
	ld c, l ; $471c
	ld b, h ; $471d
	ld de, $d000 ; $471e
	farcall FarPtr_04_20 ; $4721
	ret ; $4724
	test_flag $05, 7 ; $4725
	jp nz, Label_0f_4ea7 ; $4728
	ld a, $03 ; $472b
	farcall FarPtr_0a_1c ; $472d
	ld a, $00 ; $4730
	ld bc, $0c00 ; $4732
	ld de, $1900 ; $4735
	farcall FarPtr_ScriptSetActorMoveTarget ; $4738
	ld a, $03 ; $473b
	ld bc, $0c00 ; $473d
	ld de, $1b00 ; $4740
	farcall FarPtr_ScriptSetActorMoveTarget ; $4743
	ld a, $03 ; $4746
	farcall FarPtr_ScriptWaitActorMoveDone ; $4748
	ld a, $0a ; $474b
	call DelayFrames ; $474d
	ld a, $0b ; $4750
	ld b, a ; $4752
	ld a, $00 ; $4753
	farcall FarPtr_FaceActorTowardActor ; $4755
	ld a, $03 ; $4758
	ld b, $c0 ; $475a
	farcall FarPtr_SetActorFacing ; $475c
	ld a, $3c ; $475f
	call DelayFrames ; $4761
	call Func_0f_5c52 ; $4764
	ld a, $00 ; $4767
	ld b, $40 ; $4769
	farcall FarPtr_SetActorFacing ; $476b
	ld a, $04 ; $476e
	ld bc, $0c00 ; $4770
	ld de, $1d00 ; $4773
	farcall FarPtr_ScriptSetActorMoveTarget ; $4776
	ld a, $04 ; $4779
	farcall FarPtr_ScriptWaitActorMoveDone ; $477b
	ld a, $0a ; $477e
	call DelayFrames ; $4780
	call Func_0f_5c96 ; $4783
	ld a, $00 ; $4786
	ld bc, $0020 ; $4788
	farcall FarPtr_0a_18 ; $478b
	ld a, $03 ; $478e
	ld bc, $0020 ; $4790
	farcall FarPtr_0a_18 ; $4793
	ld a, $04 ; $4796
	ld bc, $0020 ; $4798
	farcall FarPtr_0a_18 ; $479b
	ldh a, [hRomBank] ; $479e
	ld b, a ; $47a0
	ld a, $00 ; $47a1
	ld de, $5665 ; $47a3
	farcall FarPtr_0a_1a ; $47a6
	ldh a, [hRomBank] ; $47a9
	ld b, a ; $47ab
	ld a, $03 ; $47ac
	ld de, $5665 ; $47ae
	farcall FarPtr_0a_1a ; $47b1
	ldh a, [hRomBank] ; $47b4
	ld b, a ; $47b6
	ld a, $04 ; $47b7
	ld de, $5665 ; $47b9
	farcall FarPtr_0a_1a ; $47bc
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
	call Func_0f_5641 ; $47e5
	ld a, $16 ; $47e8
	ld bc, $0c00 ; $47ea
	ld de, $0d40 ; $47ed
	farcall FarPtr_ScriptSetActorPosition ; $47f0
	ld a, $16 ; $47f3
	ld b, $40 ; $47f5
	farcall FarPtr_SetActorFacing ; $47f7
	ld a, $03 ; $47fa
	ld b, $40 ; $47fc
	farcall FarPtr_SetActorFacing ; $47fe
	ld a, $04 ; $4801
	ld b, $40 ; $4803
	farcall FarPtr_SetActorFacing ; $4805
	ld bc, $0006 ; $4808
	farcall FarPtr_0a_38 ; $480b
	xor a, a ; $480e
	ld bc, $0c00 ; $480f
	ld de, $1300 ; $4812
	farcall FarPtr_MovePlayerToPosition ; $4815
	farcall FarPtr_WaitPlayerMoveDone ; $4818
	call Func_0f_5ccf ; $481b
	ld a, $0c ; $481e
	ld bc, $0e00 ; $4820
	ld de, $1300 ; $4823
	farcall FarPtr_ScriptSetActorMoveTarget ; $4826
	ld a, $0c ; $4829
	farcall FarPtr_ScriptWaitActorMoveDone ; $482b
	ld a, $0c ; $482e
	ld b, $c0 ; $4830
	farcall FarPtr_SetActorFacing ; $4832
	ld a, $0f ; $4835
	ld bc, $0010 ; $4837
	farcall FarPtr_0a_18 ; $483a
	ld a, $10 ; $483d
	ld bc, $0010 ; $483f
	farcall FarPtr_0a_18 ; $4842
	ld a, $10 ; $4845
	ld bc, $1100 ; $4847
	ld de, $1600 ; $484a
	farcall FarPtr_ScriptSetActorMoveTarget ; $484d
	ld a, $10 ; $4850
	farcall FarPtr_ScriptWaitActorMoveDone ; $4852
	ld a, $10 ; $4855
	ld b, $40 ; $4857
	farcall FarPtr_SetActorFacing ; $4859
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
	ld a, $11 ; $4880
	ld d, $01 ; $4882
	farcall FarPtr_ScriptSetActorAnimation ; $4884
	ld a, $03 ; $4887
	ld bc, $3f00 ; $4889
	ld de, $3f00 ; $488c
	farcall FarPtr_ScriptSetActorPosition ; $488f
	ld a, $11 ; $4892
	ld bc, $0e00 ; $4894
	ld de, $0e40 ; $4897
	farcall FarPtr_ScriptSetActorPosition ; $489a
	ld a, $11 ; $489d
	ld b, $40 ; $489f
	farcall FarPtr_SetActorFacing ; $48a1
	ld a, $0c ; $48a4
	ld bc, $0010 ; $48a6
	farcall FarPtr_0a_18 ; $48a9
	ld a, $0f ; $48ac
	ld bc, $0010 ; $48ae
	farcall FarPtr_0a_18 ; $48b1
	ld a, $0c ; $48b4
	ld bc, $0e00 ; $48b6
	ld de, $1100 ; $48b9
	farcall FarPtr_ScriptSetActorMoveTarget ; $48bc
	ld a, $0f ; $48bf
	ld bc, $0e00 ; $48c1
	ld de, $1000 ; $48c4
	farcall FarPtr_ScriptSetActorMoveTarget ; $48c7
	ld a, $0f ; $48ca
	farcall FarPtr_ScriptWaitActorMoveDone ; $48cc
	ld a, $1e ; $48cf
	call DelayFrames ; $48d1
	ld a, $0c ; $48d4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $48d6
	ld a, $1e ; $48d9
	call DelayFrames ; $48db
	ld a, $0c ; $48de
	ld bc, $0e00 ; $48e0
	ld de, $1040 ; $48e3
	farcall FarPtr_ScriptSetActorMoveTarget ; $48e6
	ld a, $0f ; $48e9
	ld bc, $0e00 ; $48eb
	ld de, $0f40 ; $48ee
	farcall FarPtr_ScriptSetActorMoveTarget ; $48f1
	ld a, $0f ; $48f4
	farcall FarPtr_ScriptWaitActorMoveDone ; $48f6
	ld a, $05 ; $48f9
	call DelayFrames ; $48fb
	ld a, $0c ; $48fe
	ld b, $01 ; $4900
	farcall FarPtr_0a_2c ; $4902
	ld a, $0c ; $4905
	ld bc, $0e00 ; $4907
	ld de, $1100 ; $490a
	farcall FarPtr_ScriptSetActorMoveTarget ; $490d
	ld a, $0c ; $4910
	farcall FarPtr_ScriptWaitActorMoveDone ; $4912
	ld a, $0c ; $4915
	ld b, $00 ; $4917
	farcall FarPtr_0a_2c ; $4919
	ld a, $0c ; $491c
	ld b, $c0 ; $491e
	farcall FarPtr_SetActorFacing ; $4920
	ld a, $14 ; $4923
	call DelayFrames ; $4925
	ld a, $0f ; $4928
	ld bc, $3f00 ; $492a
	ld de, $3f00 ; $492d
	farcall FarPtr_ScriptSetActorPosition ; $4930
	ld a, $11 ; $4933
	ld d, $02 ; $4935
	farcall FarPtr_ScriptSetActorAnimation ; $4937
	ld a, $11 ; $493a
	farcall FarPtr_ScriptWaitActorIdle ; $493c
	ld a, $11 ; $493f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4941
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
	ld a, $11 ; $4961
	ld d, $04 ; $4963
	farcall FarPtr_ScriptSetActorAnimation ; $4965
	ld a, $11 ; $4968
	farcall FarPtr_ScriptWaitActorIdle ; $496a
	ld a, $11 ; $496d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $496f
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
	ld a, $16 ; $498e
	ld d, $02 ; $4990
	farcall FarPtr_ScriptSetActorAnimation ; $4992
	ld a, $16 ; $4995
	farcall FarPtr_ScriptWaitActorIdle ; $4997
	ld a, $0c ; $499a
	ld d, $03 ; $499c
	farcall FarPtr_ScriptSetActorAnimation ; $499e
	ld a, $0c ; $49a1
	farcall FarPtr_ScriptWaitActorIdle ; $49a3
	ld a, $0c ; $49a6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $49a8
	ld a, $1e ; $49ab
	call DelayFrames ; $49ad
	ld a, $0c ; $49b0
	ld bc, $0e00 ; $49b2
	ld de, $1300 ; $49b5
	farcall FarPtr_ScriptSetActorMoveTarget ; $49b8
	ld a, $0c ; $49bb
	farcall FarPtr_ScriptWaitActorMoveDone ; $49bd
	ld a, $0c ; $49c0
	ld bc, $0a00 ; $49c2
	ld de, $1300 ; $49c5
	farcall FarPtr_ScriptSetActorMoveTarget ; $49c8
	ld a, $0c ; $49cb
	farcall FarPtr_ScriptWaitActorMoveDone ; $49cd
	ld a, $0c ; $49d0
	ld b, $c0 ; $49d2
	farcall FarPtr_SetActorFacing ; $49d4
	ld a, $14 ; $49d7
	call DelayFrames ; $49d9
	ld a, $0e ; $49dc
	ld bc, $0010 ; $49de
	farcall FarPtr_0a_18 ; $49e1
	ld a, $10 ; $49e4
	ld bc, $0010 ; $49e6
	farcall FarPtr_0a_18 ; $49e9
	ld a, $10 ; $49ec
	ld bc, $1000 ; $49ee
	ld de, $1600 ; $49f1
	farcall FarPtr_ScriptSetActorMoveTarget ; $49f4
	ld a, $10 ; $49f7
	farcall FarPtr_ScriptWaitActorMoveDone ; $49f9
	ld a, $10 ; $49fc
	ld b, $40 ; $49fe
	farcall FarPtr_SetActorFacing ; $4a00
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
	ld a, $10 ; $4a24
	ld d, $01 ; $4a26
	farcall FarPtr_ScriptSetActorAnimation ; $4a28
	ld d, $25 ; $4a2b
	ld a, $0e ; $4a2d
	farcall FarPtr_GetActorStateAddr ; $4a2f
	ld c, l ; $4a32
	ld b, h ; $4a33
	farcall FarPtr_04_2c ; $4a34
	ld a, $0e ; $4a37
	ld d, $01 ; $4a39
	farcall FarPtr_ScriptSetActorAnimation ; $4a3b
	ld a, $0e ; $4a3e
	ld bc, $1000 ; $4a40
	ld de, $1600 ; $4a43
	farcall FarPtr_ScriptSetActorPosition ; $4a46
	ld a, $10 ; $4a49
	ld bc, $1000 ; $4a4b
	ld de, $1500 ; $4a4e
	farcall FarPtr_ScriptSetActorPosition ; $4a51
	ld a, $0e ; $4a54
	ld b, $c0 ; $4a56
	farcall FarPtr_SetActorFacing ; $4a58
	ld a, $10 ; $4a5b
	ld d, $08 ; $4a5d
	farcall FarPtr_ScriptSetActorAnimation ; $4a5f
	ld a, $10 ; $4a62
	ld bc, $1000 ; $4a64
	ld de, $1200 ; $4a67
	farcall FarPtr_ScriptSetActorMoveTarget ; $4a6a
	ld a, $0e ; $4a6d
	ld bc, $1000 ; $4a6f
	ld de, $1300 ; $4a72
	farcall FarPtr_ScriptSetActorMoveTarget ; $4a75
	ld a, $0e ; $4a78
	farcall FarPtr_ScriptWaitActorMoveDone ; $4a7a
	ld d, $25 ; $4a7d
	ld a, $10 ; $4a7f
	farcall FarPtr_GetActorStateAddr ; $4a81
	ld c, l ; $4a84
	ld b, h ; $4a85
	farcall FarPtr_04_2c ; $4a86
	ld a, $10 ; $4a89
	ld d, $01 ; $4a8b
	farcall FarPtr_ScriptSetActorAnimation ; $4a8d
	ld d, $74 ; $4a90
	ld a, $0e ; $4a92
	farcall FarPtr_GetActorStateAddr ; $4a94
	ld c, l ; $4a97
	ld b, h ; $4a98
	farcall FarPtr_04_2c ; $4a99
	ld a, $0e ; $4a9c
	ld d, $01 ; $4a9e
	farcall FarPtr_ScriptSetActorAnimation ; $4aa0
	ld a, $10 ; $4aa3
	ld bc, $1000 ; $4aa5
	ld de, $1300 ; $4aa8
	farcall FarPtr_ScriptSetActorPosition ; $4aab
	ld a, $0e ; $4aae
	ld bc, $0f00 ; $4ab0
	ld de, $1300 ; $4ab3
	farcall FarPtr_ScriptSetActorPosition ; $4ab6
	ld a, $10 ; $4ab9
	ld b, $80 ; $4abb
	farcall FarPtr_SetActorFacing ; $4abd
	ld a, $0e ; $4ac0
	ld d, $08 ; $4ac2
	farcall FarPtr_ScriptSetActorAnimation ; $4ac4
	ld a, $10 ; $4ac7
	ld bc, $0c00 ; $4ac9
	ld de, $1300 ; $4acc
	farcall FarPtr_ScriptSetActorMoveTarget ; $4acf
	ld a, $0e ; $4ad2
	ld bc, $0b00 ; $4ad4
	ld de, $1300 ; $4ad7
	farcall FarPtr_ScriptSetActorMoveTarget ; $4ada
	ld a, $0e ; $4add
	farcall FarPtr_ScriptWaitActorMoveDone ; $4adf
	ld a, $10 ; $4ae2
	ld b, $01 ; $4ae4
	farcall FarPtr_0a_2c ; $4ae6
	ld a, $10 ; $4ae9
	ld bc, $0e00 ; $4aeb
	ld de, $1300 ; $4aee
	farcall FarPtr_ScriptSetActorMoveTarget ; $4af1
	ld a, $10 ; $4af4
	farcall FarPtr_ScriptWaitActorMoveDone ; $4af6
	ld a, $10 ; $4af9
	ld b, $00 ; $4afb
	farcall FarPtr_0a_2c ; $4afd
	ld a, $10 ; $4b00
	ld bc, $0020 ; $4b02
	farcall FarPtr_0a_18 ; $4b05
	ld a, $10 ; $4b08
	ld bc, $1000 ; $4b0a
	ld de, $1600 ; $4b0d
	farcall FarPtr_ScriptSetActorMoveTarget ; $4b10
	ld a, $10 ; $4b13
	farcall FarPtr_ScriptWaitActorMoveDone ; $4b15
	ld a, $10 ; $4b18
	ld b, $c0 ; $4b1a
	farcall FarPtr_SetActorFacing ; $4b1c
	ld d, $61 ; $4b1f
	ld a, $12 ; $4b21
	farcall FarPtr_GetActorStateAddr ; $4b23
	ld c, l ; $4b26
	ld b, h ; $4b27
	farcall FarPtr_04_2c ; $4b28
	ld a, $12 ; $4b2b
	ld d, $01 ; $4b2d
	farcall FarPtr_ScriptSetActorAnimation ; $4b2f
	ld a, $04 ; $4b32
	ld bc, $3f00 ; $4b34
	ld de, $3f00 ; $4b37
	farcall FarPtr_ScriptSetActorPosition ; $4b3a
	ld a, $12 ; $4b3d
	ld bc, $0a00 ; $4b3f
	ld de, $0dc0 ; $4b42
	farcall FarPtr_ScriptSetActorPosition ; $4b45
	ld a, $12 ; $4b48
	ld b, $40 ; $4b4a
	farcall FarPtr_SetActorFacing ; $4b4c
	ld a, $0c ; $4b4f
	ld bc, $0010 ; $4b51
	farcall FarPtr_0a_18 ; $4b54
	ld a, $0e ; $4b57
	ld bc, $0010 ; $4b59
	farcall FarPtr_0a_18 ; $4b5c
	ld a, $0c ; $4b5f
	ld bc, $0a00 ; $4b61
	ld de, $1100 ; $4b64
	farcall FarPtr_ScriptSetActorMoveTarget ; $4b67
	ld a, $0e ; $4b6a
	ld bc, $0a00 ; $4b6c
	ld de, $1000 ; $4b6f
	farcall FarPtr_ScriptSetActorMoveTarget ; $4b72
	ld a, $0e ; $4b75
	farcall FarPtr_ScriptWaitActorMoveDone ; $4b77
	ld a, $1e ; $4b7a
	call DelayFrames ; $4b7c
	ld a, $0c ; $4b7f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4b81
	ld a, $1e ; $4b84
	call DelayFrames ; $4b86
	ld a, $0c ; $4b89
	ld bc, $0a00 ; $4b8b
	ld de, $0fc0 ; $4b8e
	farcall FarPtr_ScriptSetActorMoveTarget ; $4b91
	ld a, $0e ; $4b94
	ld bc, $0a00 ; $4b96
	ld de, $0ec0 ; $4b99
	farcall FarPtr_ScriptSetActorMoveTarget ; $4b9c
	ld a, $0e ; $4b9f
	farcall FarPtr_ScriptWaitActorMoveDone ; $4ba1
	ld a, $05 ; $4ba4
	call DelayFrames ; $4ba6
	ld a, $12 ; $4ba9
	ld d, $02 ; $4bab
	farcall FarPtr_ScriptSetActorAnimation ; $4bad
	ld a, $12 ; $4bb0
	farcall FarPtr_ScriptWaitActorIdle ; $4bb2
	ld a, $0c ; $4bb5
	ld b, $01 ; $4bb7
	farcall FarPtr_0a_2c ; $4bb9
	ld a, $0c ; $4bbc
	ld bc, $0a00 ; $4bbe
	ld de, $1100 ; $4bc1
	farcall FarPtr_ScriptSetActorMoveTarget ; $4bc4
	ld a, $0c ; $4bc7
	farcall FarPtr_ScriptWaitActorMoveDone ; $4bc9
	ld a, $0c ; $4bcc
	ld b, $00 ; $4bce
	farcall FarPtr_0a_2c ; $4bd0
	ld a, $0c ; $4bd3
	ld b, $c0 ; $4bd5
	farcall FarPtr_SetActorFacing ; $4bd7
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
	ld a, $12 ; $4bf7
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4bf9
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
	ld a, $12 ; $4c24
	ld d, $04 ; $4c26
	farcall FarPtr_ScriptSetActorAnimation ; $4c28
	ld a, $12 ; $4c2b
	farcall FarPtr_ScriptWaitActorIdle ; $4c2d
	ld a, $12 ; $4c30
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4c32
	ld a, $0c ; $4c35
	ld d, $03 ; $4c37
	farcall FarPtr_ScriptSetActorAnimation ; $4c39
	ld a, $0c ; $4c3c
	farcall FarPtr_ScriptWaitActorIdle ; $4c3e
	ld a, $0c ; $4c41
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4c43
	ld a, $1e ; $4c46
	call DelayFrames ; $4c48
	ld a, $0c ; $4c4b
	ld bc, $0a00 ; $4c4d
	ld de, $1300 ; $4c50
	farcall FarPtr_ScriptSetActorMoveTarget ; $4c53
	ld a, $0c ; $4c56
	farcall FarPtr_ScriptWaitActorMoveDone ; $4c58
	ld a, $0c ; $4c5b
	ld bc, $0c00 ; $4c5d
	ld de, $1300 ; $4c60
	farcall FarPtr_ScriptSetActorMoveTarget ; $4c63
	ld a, $0c ; $4c66
	farcall FarPtr_ScriptWaitActorMoveDone ; $4c68
	ld a, $0c ; $4c6b
	ld b, $c0 ; $4c6d
	farcall FarPtr_SetActorFacing ; $4c6f
	ld a, $0d ; $4c72
	ld bc, $0010 ; $4c74
	farcall FarPtr_0a_18 ; $4c77
	ld a, $10 ; $4c7a
	ld bc, $0010 ; $4c7c
	farcall FarPtr_0a_18 ; $4c7f
	ld a, $10 ; $4c82
	ld bc, $0f00 ; $4c84
	ld de, $1600 ; $4c87
	farcall FarPtr_ScriptSetActorMoveTarget ; $4c8a
	ld a, $10 ; $4c8d
	farcall FarPtr_ScriptWaitActorMoveDone ; $4c8f
	ld a, $10 ; $4c92
	ld b, $40 ; $4c94
	farcall FarPtr_SetActorFacing ; $4c96
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
	ld a, $10 ; $4cba
	ld d, $01 ; $4cbc
	farcall FarPtr_ScriptSetActorAnimation ; $4cbe
	ld d, $25 ; $4cc1
	ld a, $0d ; $4cc3
	farcall FarPtr_GetActorStateAddr ; $4cc5
	ld c, l ; $4cc8
	ld b, h ; $4cc9
	farcall FarPtr_04_2c ; $4cca
	ld a, $0d ; $4ccd
	ld d, $01 ; $4ccf
	farcall FarPtr_ScriptSetActorAnimation ; $4cd1
	ld a, $0d ; $4cd4
	ld bc, $0f00 ; $4cd6
	ld de, $1600 ; $4cd9
	farcall FarPtr_ScriptSetActorPosition ; $4cdc
	ld a, $10 ; $4cdf
	ld bc, $0f00 ; $4ce1
	ld de, $1500 ; $4ce4
	farcall FarPtr_ScriptSetActorPosition ; $4ce7
	ld a, $0d ; $4cea
	ld b, $c0 ; $4cec
	farcall FarPtr_SetActorFacing ; $4cee
	ld a, $10 ; $4cf1
	ld d, $06 ; $4cf3
	farcall FarPtr_ScriptSetActorAnimation ; $4cf5
	ld a, $10 ; $4cf8
	ld bc, $0f00 ; $4cfa
	ld de, $1200 ; $4cfd
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d00
	ld a, $0d ; $4d03
	ld bc, $0f00 ; $4d05
	ld de, $1300 ; $4d08
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d0b
	ld a, $0d ; $4d0e
	farcall FarPtr_ScriptWaitActorMoveDone ; $4d10
	ld d, $25 ; $4d13
	ld a, $10 ; $4d15
	farcall FarPtr_GetActorStateAddr ; $4d17
	ld c, l ; $4d1a
	ld b, h ; $4d1b
	farcall FarPtr_04_2c ; $4d1c
	ld a, $10 ; $4d1f
	ld d, $01 ; $4d21
	farcall FarPtr_ScriptSetActorAnimation ; $4d23
	ld d, $74 ; $4d26
	ld a, $0d ; $4d28
	farcall FarPtr_GetActorStateAddr ; $4d2a
	ld c, l ; $4d2d
	ld b, h ; $4d2e
	farcall FarPtr_04_2c ; $4d2f
	ld a, $0d ; $4d32
	ld d, $01 ; $4d34
	farcall FarPtr_ScriptSetActorAnimation ; $4d36
	ld a, $10 ; $4d39
	ld bc, $0f00 ; $4d3b
	ld de, $1300 ; $4d3e
	farcall FarPtr_ScriptSetActorPosition ; $4d41
	ld a, $0d ; $4d44
	ld bc, $0e00 ; $4d46
	ld de, $1300 ; $4d49
	farcall FarPtr_ScriptSetActorPosition ; $4d4c
	ld a, $10 ; $4d4f
	ld b, $80 ; $4d51
	farcall FarPtr_SetActorFacing ; $4d53
	ld a, $0d ; $4d56
	ld d, $06 ; $4d58
	farcall FarPtr_ScriptSetActorAnimation ; $4d5a
	ld a, $10 ; $4d5d
	ld bc, $0e00 ; $4d5f
	ld de, $1300 ; $4d62
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d65
	ld a, $0d ; $4d68
	ld bc, $0d00 ; $4d6a
	ld de, $1300 ; $4d6d
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d70
	ld a, $0d ; $4d73
	farcall FarPtr_ScriptWaitActorMoveDone ; $4d75
	ld a, $10 ; $4d78
	ld b, $01 ; $4d7a
	farcall FarPtr_0a_2c ; $4d7c
	ld a, $10 ; $4d7f
	ld bc, $0f00 ; $4d81
	ld de, $1300 ; $4d84
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d87
	ld a, $10 ; $4d8a
	farcall FarPtr_ScriptWaitActorMoveDone ; $4d8c
	ld a, $10 ; $4d8f
	ld b, $00 ; $4d91
	farcall FarPtr_0a_2c ; $4d93
	ld a, $10 ; $4d96
	ld bc, $0020 ; $4d98
	farcall FarPtr_0a_18 ; $4d9b
	ld a, $10 ; $4d9e
	ld bc, $0f00 ; $4da0
	ld de, $1600 ; $4da3
	farcall FarPtr_ScriptSetActorMoveTarget ; $4da6
	ld a, $10 ; $4da9
	farcall FarPtr_ScriptWaitActorMoveDone ; $4dab
	ld a, $10 ; $4dae
	ld b, $c0 ; $4db0
	farcall FarPtr_SetActorFacing ; $4db2
	ld a, $0c ; $4db5
	ld bc, $0c00 ; $4db7
	ld de, $1100 ; $4dba
	farcall FarPtr_ScriptSetActorMoveTarget ; $4dbd
	ld a, $0d ; $4dc0
	ld bc, $0c00 ; $4dc2
	ld de, $1000 ; $4dc5
	farcall FarPtr_ScriptSetActorMoveTarget ; $4dc8
	ld a, $0d ; $4dcb
	farcall FarPtr_ScriptWaitActorMoveDone ; $4dcd
	ld a, $0c ; $4dd0
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4dd2
	ld a, $14 ; $4dd5
	call DelayFrames ; $4dd7
	ld a, $0c ; $4dda
	ld bc, $0c00 ; $4ddc
	ld de, $0f80 ; $4ddf
	farcall FarPtr_ScriptSetActorMoveTarget ; $4de2
	ld a, $0d ; $4de5
	ld bc, $0c00 ; $4de7
	ld de, $0e40 ; $4dea
	farcall FarPtr_ScriptSetActorMoveTarget ; $4ded
	ld a, $0d ; $4df0
	farcall FarPtr_ScriptWaitActorMoveDone ; $4df2
	ld a, $0c ; $4df5
	ld b, $01 ; $4df7
	farcall FarPtr_0a_2c ; $4df9
	ld a, $0c ; $4dfc
	ld bc, $0c00 ; $4dfe
	ld de, $1100 ; $4e01
	farcall FarPtr_ScriptSetActorMoveTarget ; $4e04
	ld a, $0c ; $4e07
	farcall FarPtr_ScriptWaitActorMoveDone ; $4e09
	ld a, $0c ; $4e0c
	ld b, $00 ; $4e0e
	farcall FarPtr_0a_2c ; $4e10
	ld a, $0c ; $4e13
	ld b, $c0 ; $4e15
	farcall FarPtr_SetActorFacing ; $4e17
	ld a, $0b ; $4e1a
	ld d, $02 ; $4e1c
	farcall FarPtr_ScriptSetActorAnimation ; $4e1e
	ld a, $0b ; $4e21
	farcall FarPtr_ScriptWaitActorIdle ; $4e23
	ld a, $16 ; $4e26
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4e28
	ld a, $11 ; $4e2b
	ld b, $80 ; $4e2d
	farcall FarPtr_SetActorFacing ; $4e2f
	ld a, $12 ; $4e32
	ld b, $00 ; $4e34
	farcall FarPtr_SetActorFacing ; $4e36
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
	ld a, $16 ; $4e4f
	ld d, $01 ; $4e51
	farcall FarPtr_ScriptSetActorAnimation ; $4e53
	ld a, $16 ; $4e56
	ld b, $00 ; $4e58
	farcall FarPtr_SetActorFacing ; $4e5a
	ld a, $16 ; $4e5d
	ld d, $08 ; $4e5f
	farcall FarPtr_ScriptSetActorAnimation ; $4e61
	ld a, $0d ; $4e64
	ld bc, $0b40 ; $4e66
	ld de, $0c40 ; $4e69
	farcall FarPtr_ScriptSetActorPosition ; $4e6c
	xor a, a ; $4e6f
	ld bc, $0c00 ; $4e70
	ld de, $0d00 ; $4e73
	farcall FarPtr_MovePlayerToPosition ; $4e76
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
	ld [$c295], a ; $4e9b
	ld a, $ff ; $4e9e
	ld [$c294], a ; $4ea0
	ld [$c2a1], a ; $4ea3
	ret ; $4ea6
Label_0f_4ea7:
	ld a, $02 ; $4ea7
	farcall FarPtr_0a_1c ; $4ea9
	ld a, $00 ; $4eac
	ld bc, $0c00 ; $4eae
	ld de, $1900 ; $4eb1
	farcall FarPtr_ScriptSetActorMoveTarget ; $4eb4
	ld a, $02 ; $4eb7
	ld bc, $0c00 ; $4eb9
	ld de, $1b00 ; $4ebc
	farcall FarPtr_ScriptSetActorMoveTarget ; $4ebf
	ld a, $02 ; $4ec2
	farcall FarPtr_ScriptWaitActorMoveDone ; $4ec4
	ld a, $0a ; $4ec7
	call DelayFrames ; $4ec9
	ld a, $0b ; $4ecc
	ld b, a ; $4ece
	ld a, $00 ; $4ecf
	farcall FarPtr_FaceActorTowardActor ; $4ed1
	ld a, $02 ; $4ed4
	ld b, $c0 ; $4ed6
	farcall FarPtr_SetActorFacing ; $4ed8
	ld a, $3c ; $4edb
	call DelayFrames ; $4edd
	call Func_0f_5c52 ; $4ee0
	ld a, $00 ; $4ee3
	ld b, $40 ; $4ee5
	farcall FarPtr_SetActorFacing ; $4ee7
	ld a, $05 ; $4eea
	farcall FarPtr_GetActorStateAddr ; $4eec
	ld c, l ; $4eef
	ld b, h ; $4ef0
	ld a, $04 ; $4ef1
	farcall FarPtr_GetActorStateAddr ; $4ef3
	ld e, l ; $4ef6
	ld d, h ; $4ef7
	farcall FarPtr_04_20 ; $4ef8
	ld a, $04 ; $4efb
	ld bc, $0c00 ; $4efd
	ld de, $1d00 ; $4f00
	farcall FarPtr_ScriptSetActorMoveTarget ; $4f03
	ld a, $04 ; $4f06
	farcall FarPtr_ScriptWaitActorMoveDone ; $4f08
	ld a, $0a ; $4f0b
	call DelayFrames ; $4f0d
	ld a, $05 ; $4f10
	farcall FarPtr_0a_1c ; $4f12
	call Func_0f_5c96 ; $4f15
	ld a, $03 ; $4f18
	ld b, $c0 ; $4f1a
	farcall FarPtr_SetActorFacing ; $4f1c
	ld a, $00 ; $4f1f
	ld bc, $0020 ; $4f21
	farcall FarPtr_0a_18 ; $4f24
	ld a, $02 ; $4f27
	ld bc, $0020 ; $4f29
	farcall FarPtr_0a_18 ; $4f2c
	ld a, $04 ; $4f2f
	ld bc, $0020 ; $4f31
	farcall FarPtr_0a_18 ; $4f34
	ld a, $05 ; $4f37
	ld bc, $0020 ; $4f39
	farcall FarPtr_0a_18 ; $4f3c
	ldh a, [hRomBank] ; $4f3f
	ld b, a ; $4f41
	ld a, $00 ; $4f42
	ld de, $5665 ; $4f44
	farcall FarPtr_0a_1a ; $4f47
	ldh a, [hRomBank] ; $4f4a
	ld b, a ; $4f4c
	ld a, $02 ; $4f4d
	ld de, $5665 ; $4f4f
	farcall FarPtr_0a_1a ; $4f52
	ldh a, [hRomBank] ; $4f55
	ld b, a ; $4f57
	ld a, $04 ; $4f58
	ld de, $5665 ; $4f5a
	farcall FarPtr_0a_1a ; $4f5d
	ldh a, [hRomBank] ; $4f60
	ld b, a ; $4f62
	ld a, $05 ; $4f63
	ld de, $5665 ; $4f65
	farcall FarPtr_0a_1a ; $4f68
	ld a, $b4 ; $4f6b
	call DelayFrames ; $4f6d
	call Func_0f_5641 ; $4f70
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
	ld a, $11 ; $4f8f
	ld d, $01 ; $4f91
	farcall FarPtr_ScriptSetActorAnimation ; $4f93
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
	ld a, $13 ; $4fb8
	ld d, $01 ; $4fba
	farcall FarPtr_ScriptSetActorAnimation ; $4fbc
	ld d, $62 ; $4fbf
	ld a, $15 ; $4fc1
	farcall FarPtr_GetActorStateAddr ; $4fc3
	ld c, l ; $4fc6
	ld b, h ; $4fc7
	farcall FarPtr_04_2c ; $4fc8
	ld a, $15 ; $4fcb
	ld d, $01 ; $4fcd
	farcall FarPtr_ScriptSetActorAnimation ; $4fcf
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
	ld a, $04 ; $500a
	ld d, $01 ; $500c
	farcall FarPtr_ScriptSetActorAnimation ; $500e
	ld d, $4d ; $5011
	ld a, $05 ; $5013
	farcall FarPtr_GetActorStateAddr ; $5015
	ld c, l ; $5018
	ld b, h ; $5019
	farcall FarPtr_04_2c ; $501a
	ld a, $05 ; $501d
	ld d, $01 ; $501f
	farcall FarPtr_ScriptSetActorAnimation ; $5021
	ld a, $16 ; $5024
	ld b, $40 ; $5026
	farcall FarPtr_SetActorFacing ; $5028
	ld a, $11 ; $502b
	ld b, $40 ; $502d
	farcall FarPtr_SetActorFacing ; $502f
	ld a, $13 ; $5032
	ld b, $40 ; $5034
	farcall FarPtr_SetActorFacing ; $5036
	ld a, $15 ; $5039
	ld b, $40 ; $503b
	farcall FarPtr_SetActorFacing ; $503d
	ld bc, $0006 ; $5040
	farcall FarPtr_0a_38 ; $5043
	xor a, a ; $5046
	ld bc, $0c00 ; $5047
	ld de, $1300 ; $504a
	farcall FarPtr_MovePlayerToPosition ; $504d
	farcall FarPtr_WaitPlayerMoveDone ; $5050
	call Func_0f_5ccf ; $5053
	ld a, $0c ; $5056
	ld bc, $0a00 ; $5058
	ld de, $1300 ; $505b
	farcall FarPtr_ScriptSetActorMoveTarget ; $505e
	ld a, $0c ; $5061
	farcall FarPtr_ScriptWaitActorMoveDone ; $5063
	ld a, $0c ; $5066
	ld b, $c0 ; $5068
	farcall FarPtr_SetActorFacing ; $506a
	ld a, $10 ; $506d
	ld bc, $0010 ; $506f
	farcall FarPtr_0a_18 ; $5072
	ld a, $09 ; $5075
	ld bc, $0010 ; $5077
	farcall FarPtr_0a_18 ; $507a
	ld a, $0f ; $507d
	ld bc, $0010 ; $507f
	farcall FarPtr_0a_18 ; $5082
	ld a, $10 ; $5085
	ld bc, $1100 ; $5087
	ld de, $1600 ; $508a
	farcall FarPtr_ScriptSetActorMoveTarget ; $508d
	ld a, $10 ; $5090
	farcall FarPtr_ScriptWaitActorMoveDone ; $5092
	ld a, $10 ; $5095
	ld b, $40 ; $5097
	farcall FarPtr_SetActorFacing ; $5099
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
	ld a, $09 ; $50c8
	ld d, $01 ; $50ca
	farcall FarPtr_ScriptSetActorAnimation ; $50cc
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
	ld a, $09 ; $50f0
	ld b, $c0 ; $50f2
	farcall FarPtr_SetActorFacing ; $50f4
	ld a, $0f ; $50f7
	ld d, $08 ; $50f9
	farcall FarPtr_ScriptSetActorAnimation ; $50fb
	ld a, $0f ; $50fe
	ld bc, $1100 ; $5100
	ld de, $1200 ; $5103
	farcall FarPtr_ScriptSetActorMoveTarget ; $5106
	ld a, $09 ; $5109
	ld bc, $1100 ; $510b
	ld de, $1300 ; $510e
	farcall FarPtr_ScriptSetActorMoveTarget ; $5111
	ld a, $09 ; $5114
	farcall FarPtr_ScriptWaitActorMoveDone ; $5116
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
	ld a, $10 ; $513a
	ld b, $80 ; $513c
	farcall FarPtr_SetActorFacing ; $513e
	ld a, $10 ; $5141
	ld bc, $0c00 ; $5143
	ld de, $1300 ; $5146
	farcall FarPtr_ScriptSetActorMoveTarget ; $5149
	ld a, $0f ; $514c
	ld bc, $0b00 ; $514e
	ld de, $1300 ; $5151
	farcall FarPtr_ScriptSetActorMoveTarget ; $5154
	ld a, $0f ; $5157
	farcall FarPtr_ScriptWaitActorMoveDone ; $5159
	ld a, $10 ; $515c
	ld b, $01 ; $515e
	farcall FarPtr_0a_2c ; $5160
	ld a, $10 ; $5163
	ld bc, $0f00 ; $5165
	ld de, $1300 ; $5168
	farcall FarPtr_ScriptSetActorMoveTarget ; $516b
	ld a, $10 ; $516e
	farcall FarPtr_ScriptWaitActorMoveDone ; $5170
	ld a, $10 ; $5173
	ld b, $00 ; $5175
	farcall FarPtr_0a_2c ; $5177
	ld a, $10 ; $517a
	ld bc, $1100 ; $517c
	ld de, $1600 ; $517f
	farcall FarPtr_ScriptSetActorMoveTarget ; $5182
	ld a, $10 ; $5185
	farcall FarPtr_ScriptWaitActorMoveDone ; $5187
	ld a, $10 ; $518a
	ld b, $c0 ; $518c
	farcall FarPtr_SetActorFacing ; $518e
	ld hl, $28b9 ; $5191
	farcall FarPtr_0a_0e ; $5194
	ld a, $0c ; $5197
	ld bc, $0010 ; $5199
	farcall FarPtr_0a_18 ; $519c
	ld a, $0c ; $519f
	ld bc, $0a00 ; $51a1
	ld de, $1100 ; $51a4
	farcall FarPtr_ScriptSetActorMoveTarget ; $51a7
	ld a, $0f ; $51aa
	ld bc, $0a00 ; $51ac
	ld de, $1000 ; $51af
	farcall FarPtr_ScriptSetActorMoveTarget ; $51b2
	ld a, $0f ; $51b5
	farcall FarPtr_ScriptWaitActorMoveDone ; $51b7
	ld a, $1e ; $51ba
	call DelayFrames ; $51bc
	ld a, $0c ; $51bf
	farcall FarPtr_ScriptShowSpeakerDialogue ; $51c1
	ld a, $1e ; $51c4
	call DelayFrames ; $51c6
	ld a, $0c ; $51c9
	ld bc, $0a00 ; $51cb
	ld de, $1000 ; $51ce
	farcall FarPtr_ScriptSetActorMoveTarget ; $51d1
	ld a, $0f ; $51d4
	ld bc, $0a00 ; $51d6
	ld de, $0f00 ; $51d9
	farcall FarPtr_ScriptSetActorMoveTarget ; $51dc
	ld a, $0f ; $51df
	farcall FarPtr_ScriptWaitActorMoveDone ; $51e1
	ld a, $05 ; $51e4
	call DelayFrames ; $51e6
	ld a, $13 ; $51e9
	ld d, $02 ; $51eb
	farcall FarPtr_ScriptSetActorAnimation ; $51ed
	ld a, $13 ; $51f0
	farcall FarPtr_ScriptWaitActorIdle ; $51f2
	ld a, $0c ; $51f5
	ld b, $01 ; $51f7
	farcall FarPtr_0a_2c ; $51f9
	ld a, $0c ; $51fc
	ld bc, $0a00 ; $51fe
	ld de, $1100 ; $5201
	farcall FarPtr_ScriptSetActorMoveTarget ; $5204
	ld a, $0c ; $5207
	farcall FarPtr_ScriptWaitActorMoveDone ; $5209
	ld a, $0c ; $520c
	ld b, $00 ; $520e
	farcall FarPtr_0a_2c ; $5210
	ld a, $0c ; $5213
	ld b, $c0 ; $5215
	farcall FarPtr_SetActorFacing ; $5217
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
	ld a, $13 ; $5247
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5249
	ld a, $15 ; $524c
	ld d, $02 ; $524e
	farcall FarPtr_ScriptSetActorAnimation ; $5250
	ld a, $15 ; $5253
	farcall FarPtr_ScriptWaitActorIdle ; $5255
	ld a, $15 ; $5258
	farcall FarPtr_ScriptShowSpeakerDialogue ; $525a
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
	ld a, $13 ; $527a
	ld d, $04 ; $527c
	farcall FarPtr_ScriptSetActorAnimation ; $527e
	ld a, $13 ; $5281
	farcall FarPtr_ScriptWaitActorIdle ; $5283
	ld a, $13 ; $5286
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5288
	ld a, $16 ; $528b
	ld d, $02 ; $528d
	farcall FarPtr_ScriptSetActorAnimation ; $528f
	ld a, $11 ; $5292
	ld d, $02 ; $5294
	farcall FarPtr_ScriptSetActorAnimation ; $5296
	ld a, $11 ; $5299
	farcall FarPtr_ScriptWaitActorIdle ; $529b
	ld a, $16 ; $529e
	ld b, $80 ; $52a0
	farcall FarPtr_SetActorFacing ; $52a2
	ld a, $11 ; $52a5
	ld b, $80 ; $52a7
	farcall FarPtr_SetActorFacing ; $52a9
	ld a, $3c ; $52ac
	call DelayFrames ; $52ae
	ld a, $16 ; $52b1
	ld b, $40 ; $52b3
	farcall FarPtr_SetActorFacing ; $52b5
	ld a, $11 ; $52b8
	ld b, $40 ; $52ba
	farcall FarPtr_SetActorFacing ; $52bc
	ld a, $15 ; $52bf
	ld d, $02 ; $52c1
	farcall FarPtr_ScriptSetActorAnimation ; $52c3
	ld a, $15 ; $52c6
	farcall FarPtr_ScriptWaitActorIdle ; $52c8
	ld a, $15 ; $52cb
	farcall FarPtr_ScriptShowSpeakerDialogue ; $52cd
	ld a, $0c ; $52d0
	ld d, $03 ; $52d2
	farcall FarPtr_ScriptSetActorAnimation ; $52d4
	ld a, $0c ; $52d7
	farcall FarPtr_ScriptWaitActorIdle ; $52d9
	ld a, $0c ; $52dc
	farcall FarPtr_ScriptShowSpeakerDialogue ; $52de
	ld a, $1e ; $52e1
	call DelayFrames ; $52e3
	ld a, $0c ; $52e6
	ld bc, $0a00 ; $52e8
	ld de, $1300 ; $52eb
	farcall FarPtr_ScriptSetActorMoveTarget ; $52ee
	ld a, $0c ; $52f1
	farcall FarPtr_ScriptWaitActorMoveDone ; $52f3
	ld a, $0c ; $52f6
	ld bc, $0e00 ; $52f8
	ld de, $1300 ; $52fb
	farcall FarPtr_ScriptSetActorMoveTarget ; $52fe
	ld a, $0c ; $5301
	farcall FarPtr_ScriptWaitActorMoveDone ; $5303
	ld a, $0c ; $5306
	ld b, $c0 ; $5308
	farcall FarPtr_SetActorFacing ; $530a
	ld a, $14 ; $530d
	call DelayFrames ; $530f
	ld a, $0d ; $5312
	ld bc, $0010 ; $5314
	farcall FarPtr_0a_18 ; $5317
	ld a, $10 ; $531a
	ld bc, $0f00 ; $531c
	ld de, $1600 ; $531f
	farcall FarPtr_ScriptSetActorMoveTarget ; $5322
	ld a, $10 ; $5325
	farcall FarPtr_ScriptWaitActorMoveDone ; $5327
	ld a, $10 ; $532a
	ld b, $40 ; $532c
	farcall FarPtr_SetActorFacing ; $532e
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
	ld a, $09 ; $5367
	ld b, $c0 ; $5369
	farcall FarPtr_SetActorFacing ; $536b
	ld a, $0d ; $536e
	ld d, $08 ; $5370
	farcall FarPtr_ScriptSetActorAnimation ; $5372
	ld a, $0d ; $5375
	ld bc, $0f00 ; $5377
	ld de, $1300 ; $537a
	farcall FarPtr_ScriptSetActorMoveTarget ; $537d
	ld a, $09 ; $5380
	ld bc, $0f00 ; $5382
	ld de, $1400 ; $5385
	farcall FarPtr_ScriptSetActorMoveTarget ; $5388
	ld a, $09 ; $538b
	farcall FarPtr_ScriptWaitActorMoveDone ; $538d
	ld a, $09 ; $5390
	ld bc, $3f00 ; $5392
	ld de, $3f00 ; $5395
	farcall FarPtr_ScriptSetActorPosition ; $5398
	ld a, $10 ; $539b
	ld bc, $0f00 ; $539d
	ld de, $1400 ; $53a0
	farcall FarPtr_ScriptSetActorPosition ; $53a3
	ld a, $10 ; $53a6
	ld b, $c0 ; $53a8
	farcall FarPtr_SetActorFacing ; $53aa
	ld a, $10 ; $53ad
	ld b, $01 ; $53af
	farcall FarPtr_0a_2c ; $53b1
	ld a, $10 ; $53b4
	ld bc, $0f00 ; $53b6
	ld de, $1600 ; $53b9
	farcall FarPtr_ScriptSetActorMoveTarget ; $53bc
	ld a, $10 ; $53bf
	farcall FarPtr_ScriptWaitActorMoveDone ; $53c1
	ld a, $10 ; $53c4
	ld b, $00 ; $53c6
	farcall FarPtr_0a_2c ; $53c8
	ld a, $10 ; $53cb
	ld b, $c0 ; $53cd
	farcall FarPtr_SetActorFacing ; $53cf
	ld a, $0d ; $53d2
	ld bc, $0ec0 ; $53d4
	ld de, $1300 ; $53d7
	farcall FarPtr_ScriptSetActorPosition ; $53da
	ld a, $0c ; $53dd
	ld bc, $0f00 ; $53df
	ld de, $1300 ; $53e2
	farcall FarPtr_ScriptSetActorMoveTarget ; $53e5
	ld a, $0d ; $53e8
	ld bc, $0fc0 ; $53ea
	ld de, $1300 ; $53ed
	farcall FarPtr_ScriptSetActorMoveTarget ; $53f0
	ld a, $0d ; $53f3
	farcall FarPtr_ScriptWaitActorMoveDone ; $53f5
	ld a, $0c ; $53f8
	ld bc, $0f00 ; $53fa
	ld de, $1100 ; $53fd
	farcall FarPtr_ScriptSetActorMoveTarget ; $5400
	ld a, $0d ; $5403
	ld bc, $0fc0 ; $5405
	ld de, $1100 ; $5408
	farcall FarPtr_ScriptSetActorMoveTarget ; $540b
	ld a, $0d ; $540e
	farcall FarPtr_ScriptWaitActorMoveDone ; $5410
	ld a, $1e ; $5413
	call DelayFrames ; $5415
	ld a, $0c ; $5418
	farcall FarPtr_ScriptShowSpeakerDialogue ; $541a
	ld a, $0a ; $541d
	call DelayFrames ; $541f
	ld a, $11 ; $5422
	ld d, $03 ; $5424
	farcall FarPtr_ScriptSetActorAnimation ; $5426
	ld a, $11 ; $5429
	farcall FarPtr_ScriptWaitActorIdle ; $542b
	ld a, $11 ; $542e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5430
	ld a, $14 ; $5433
	call DelayFrames ; $5435
	ld a, $0d ; $5438
	ld bc, $0e40 ; $543a
	ld de, $1100 ; $543d
	farcall FarPtr_ScriptSetActorPosition ; $5440
	ld a, $0c ; $5443
	ld bc, $0d00 ; $5445
	ld de, $1100 ; $5448
	farcall FarPtr_ScriptSetActorMoveTarget ; $544b
	ld a, $0d ; $544e
	ld bc, $0c40 ; $5450
	ld de, $1100 ; $5453
	farcall FarPtr_ScriptSetActorMoveTarget ; $5456
	ld a, $0d ; $5459
	farcall FarPtr_ScriptWaitActorMoveDone ; $545b
	ld a, $04 ; $545e
	call DelayFrames ; $5460
	ld a, $0c ; $5463
	ld b, $c0 ; $5465
	farcall FarPtr_SetActorFacing ; $5467
	ld a, $0d ; $546a
	ld bc, $0d00 ; $546c
	ld de, $1000 ; $546f
	farcall FarPtr_ScriptSetActorMoveTarget ; $5472
	ld a, $0d ; $5475
	farcall FarPtr_ScriptWaitActorMoveDone ; $5477
	ld a, $14 ; $547a
	call DelayFrames ; $547c
	ld a, $0c ; $547f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5481
	ld a, $1e ; $5484
	call DelayFrames ; $5486
	ld a, $0c ; $5489
	ld bc, $0d00 ; $548b
	ld de, $1000 ; $548e
	farcall FarPtr_ScriptSetActorMoveTarget ; $5491
	ld a, $0d ; $5494
	ld bc, $0d00 ; $5496
	ld de, $0e80 ; $5499
	farcall FarPtr_ScriptSetActorMoveTarget ; $549c
	ld a, $0d ; $549f
	farcall FarPtr_ScriptWaitActorMoveDone ; $54a1
	ld a, $05 ; $54a4
	call DelayFrames ; $54a6
	ld a, $0c ; $54a9
	ld b, $01 ; $54ab
	farcall FarPtr_0a_2c ; $54ad
	ld a, $0c ; $54b0
	ld bc, $0d00 ; $54b2
	ld de, $1100 ; $54b5
	farcall FarPtr_ScriptSetActorMoveTarget ; $54b8
	ld a, $0c ; $54bb
	farcall FarPtr_ScriptWaitActorMoveDone ; $54bd
	ld a, $0c ; $54c0
	ld b, $00 ; $54c2
	farcall FarPtr_0a_2c ; $54c4
	ld a, $0c ; $54c7
	ld b, $c0 ; $54c9
	farcall FarPtr_SetActorFacing ; $54cb
	ld a, $0b ; $54ce
	ld d, $02 ; $54d0
	farcall FarPtr_ScriptSetActorAnimation ; $54d2
	ld a, $0b ; $54d5
	farcall FarPtr_ScriptWaitActorIdle ; $54d7
	ld a, $16 ; $54da
	farcall FarPtr_ScriptShowSpeakerDialogue ; $54dc
	ld a, $16 ; $54df
	ld d, $03 ; $54e1
	farcall FarPtr_ScriptSetActorAnimation ; $54e3
	ld a, $11 ; $54e6
	ld d, $03 ; $54e8
	farcall FarPtr_ScriptSetActorAnimation ; $54ea
	ld a, $11 ; $54ed
	farcall FarPtr_ScriptWaitActorIdle ; $54ef
	ld a, $16 ; $54f2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $54f4
	ld a, $11 ; $54f7
	ld b, $80 ; $54f9
	farcall FarPtr_SetActorFacing ; $54fb
	ld a, $13 ; $54fe
	ld b, $00 ; $5500
	farcall FarPtr_SetActorFacing ; $5502
	ld a, $15 ; $5505
	ld b, $00 ; $5507
	farcall FarPtr_SetActorFacing ; $5509
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
	ld a, $16 ; $5522
	ld d, $01 ; $5524
	farcall FarPtr_ScriptSetActorAnimation ; $5526
	ld a, $16 ; $5529
	ld b, $00 ; $552b
	farcall FarPtr_SetActorFacing ; $552d
	ld a, $16 ; $5530
	ld d, $08 ; $5532
	farcall FarPtr_ScriptSetActorAnimation ; $5534
	ld a, $0d ; $5537
	ld bc, $0c40 ; $5539
	ld de, $0c60 ; $553c
	farcall FarPtr_ScriptSetActorPosition ; $553f
	xor a, a ; $5542
	ld bc, $0c00 ; $5543
	ld de, $0d00 ; $5546
	farcall FarPtr_MovePlayerToPosition ; $5549
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
	ld [$c295], a ; $5575
	ld a, $ff ; $5578
	ld [$c294], a ; $557a
	ld [$c2a1], a ; $557d
	ret ; $5580
	test_flag $05, 7 ; $5581
	jr z, Label_0f_55a9 ; $5584
	ldh a, [hRomBank] ; $5586
	ld hl, $430b ; $5588
	farcall FarPtr_0a_06 ; $558b
	ld hl, $5b04 ; $558e
	ld de, $000c ; $5591
	farcall FarPtr_0a_60 ; $5594
	ld b, $1a ; $5597
	ld c, $0d ; $5599
	ld d, $08 ; $559b
	ld e, $0d ; $559d
	ld h, $08 ; $559f
	ld l, $03 ; $55a1
	farcall FarPtr_0a_7e ; $55a3
	farcall FarPtr_0a_00 ; $55a6
Label_0f_55a9:
	ld a, $0e ; $55a9
	ld d, $08 ; $55ab
	farcall FarPtr_ScriptSetActorAnimation ; $55ad
	ld a, $0f ; $55b0
	ld d, $08 ; $55b2
	farcall FarPtr_ScriptSetActorAnimation ; $55b4
	test_flag $05, 7 ; $55b7
	jr nz, Label_0f_55c3 ; $55ba
	ld a, $0d ; $55bc
	ld d, $06 ; $55be
	farcall FarPtr_ScriptSetActorAnimation ; $55c0
Label_0f_55c3:
	call Func_0f_7b20 ; $55c3
	ld a, [$c295] ; $55c6
	cp a, $0a ; $55c9
	jp z, Label_0f_56a8 ; $55cb
	cp a, $0b ; $55ce
	jp z, Label_0f_5889 ; $55d0
	call Func_0f_5f7a ; $55d3
	and a, $01 ; $55d6
	jr z, Label_0f_5600 ; $55d8
	ld a, $08 ; $55da
	ld bc, $0900 ; $55dc
	ld de, $1d00 ; $55df
	farcall FarPtr_ScriptSetActorMoveTarget ; $55e2
	ld a, $08 ; $55e5
	farcall FarPtr_ScriptWaitActorMoveDone ; $55e7
	ld a, $08 ; $55ea
	ld b, $00 ; $55ec
	farcall FarPtr_SetActorFacing ; $55ee
	ld b, $0a ; $55f1
	ld c, $1c ; $55f3
	ld d, $0a ; $55f5
	ld e, $1a ; $55f7
	ld h, $04 ; $55f9
	ld l, $02 ; $55fb
	farcall FarPtr_0a_82 ; $55fd
Label_0f_5600:
	test_flag $05, 7 ; $5600
	jp nz, Label_0f_5627 ; $5603
	call Func_0f_5f52 ; $5606
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
	ld hl, $287d ; $5628
	farcall FarPtr_0a_0e ; $562b
	call Func_0f_5f7a ; $562e
	and a, $01 ; $5631
	jr z, Label_0f_563b ; $5633
	ld hl, $2881 ; $5635
	farcall FarPtr_0a_0e ; $5638
Label_0f_563b:
	ld a, $08 ; $563b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $563d
	ret ; $5640
Func_0f_5641:
	ld a, [$c90d] ; $5641
	ld d, $56 ; $5644
	add a, d ; $5646
	ld d, a ; $5647
	ld a, $16 ; $5648
	farcall FarPtr_GetActorStateAddr ; $564a
	ld c, l ; $564d
	ld b, h ; $564e
	farcall FarPtr_04_2c ; $564f
	ld a, $16 ; $5652
	ld d, $01 ; $5654
	farcall FarPtr_ScriptSetActorAnimation ; $5656
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
Func_0f_567f:
	ld a, $08 ; $567f
	ld de, $ff80 ; $5681
	farcall FarPtr_0a_42 ; $5684
	ld a, $08 ; $5687
	farcall FarPtr_0a_44 ; $5689
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
	ld a, $03 ; $56ab
	ld d, $02 ; $56ad
	farcall FarPtr_ScriptSetActorAnimation ; $56af
	ld a, $03 ; $56b2
	farcall FarPtr_ScriptWaitActorIdle ; $56b4
	ld a, $00 ; $56b7
	ld b, a ; $56b9
	ld a, $03 ; $56ba
	farcall FarPtr_FaceActorTowardActor ; $56bc
	ld a, $0a ; $56bf
	call DelayFrames ; $56c1
	ld hl, $286b ; $56c4
	farcall FarPtr_0a_0e ; $56c7
	ld a, $03 ; $56ca
	farcall FarPtr_ScriptShowSpeakerDialogue ; $56cc
	ld a, $03 ; $56cf
	ld d, $03 ; $56d1
	farcall FarPtr_ScriptSetActorAnimation ; $56d3
	ld a, $03 ; $56d6
	farcall FarPtr_ScriptWaitActorIdle ; $56d8
	ld a, $03 ; $56db
	farcall FarPtr_ScriptShowSpeakerDialogue ; $56dd
	ld a, $00 ; $56e0
	ld d, $03 ; $56e2
	farcall FarPtr_ScriptSetActorAnimation ; $56e4
	ld a, $00 ; $56e7
	farcall FarPtr_ScriptWaitActorIdle ; $56e9
	ld a, $03 ; $56ec
	ld b, a ; $56ee
	ld a, $04 ; $56ef
	farcall FarPtr_FaceActorTowardActor ; $56f1
	ld a, $04 ; $56f4
	ld d, $02 ; $56f6
	farcall FarPtr_ScriptSetActorAnimation ; $56f8
	ld a, $04 ; $56fb
	farcall FarPtr_ScriptWaitActorIdle ; $56fd
	ld a, $04 ; $5700
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5702
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
	ld a, $03 ; $5722
	ld d, $02 ; $5724
	farcall FarPtr_ScriptSetActorAnimation ; $5726
	ld a, $03 ; $5729
	farcall FarPtr_ScriptWaitActorIdle ; $572b
	ld a, $04 ; $572e
	ld b, a ; $5730
	ld a, $03 ; $5731
	farcall FarPtr_FaceActorTowardActor ; $5733
	ld a, $03 ; $5736
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5738
	ld a, $04 ; $573b
	ld d, $02 ; $573d
	farcall FarPtr_ScriptSetActorAnimation ; $573f
	ld a, $04 ; $5742
	farcall FarPtr_ScriptWaitActorIdle ; $5744
	ld a, $04 ; $5747
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5749
	ld a, $1e ; $574c
	call DelayFrames ; $574e
	ld a, $00 ; $5751
	ld b, a ; $5753
	ld a, $03 ; $5754
	farcall FarPtr_FaceActorsTowardEachOther ; $5756
	ld a, $50 ; $5759
	call DelayFrames ; $575b
	ld a, $04 ; $575e
	ld b, a ; $5760
	ld a, $03 ; $5761
	farcall FarPtr_FaceActorTowardActor ; $5763
	ld a, $04 ; $5766
	ld b, a ; $5768
	ld a, $00 ; $5769
	farcall FarPtr_FaceActorsTowardEachOther ; $576b
	ld a, $1e ; $576e
	call DelayFrames ; $5770
	ld a, $04 ; $5773
	ld d, $04 ; $5775
	farcall FarPtr_ScriptSetActorAnimation ; $5777
	ld a, $04 ; $577a
	farcall FarPtr_ScriptWaitActorIdle ; $577c
	ld a, $04 ; $577f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5781
	ld a, $28 ; $5784
	call DelayFrames ; $5786
	ld a, $0b ; $5789
	farcall FarPtr_ScriptShowSpeakerDialogue ; $578b
	ld a, $03 ; $578e
	ld b, $c0 ; $5790
	farcall FarPtr_SetActorFacing ; $5792
	ld a, $04 ; $5795
	ld b, $c0 ; $5797
	farcall FarPtr_SetActorFacing ; $5799
	ld a, $14 ; $579c
	call DelayFrames ; $579e
	ld bc, $0018 ; $57a1
	farcall FarPtr_0a_38 ; $57a4
	xor a, a ; $57a7
	ld bc, $0c00 ; $57a8
	ld de, $1300 ; $57ab
	farcall FarPtr_MovePlayerToPosition ; $57ae
	farcall FarPtr_WaitPlayerMoveDone ; $57b1
	ld a, $1e ; $57b4
	call DelayFrames ; $57b6
	ld a, $0b ; $57b9
	ld d, $02 ; $57bb
	farcall FarPtr_ScriptSetActorAnimation ; $57bd
	ld a, $0b ; $57c0
	farcall FarPtr_ScriptWaitActorIdle ; $57c2
	ld a, $0b ; $57c5
	farcall FarPtr_ScriptShowSpeakerDialogue ; $57c7
	ld a, $28 ; $57ca
	call DelayFrames ; $57cc
	xor a, a ; $57cf
	ld bc, $0c00 ; $57d0
	ld de, $2900 ; $57d3
	farcall FarPtr_MovePlayerToPosition ; $57d6
	farcall FarPtr_WaitPlayerMoveDone ; $57d9
	ld a, $04 ; $57dc
	ld b, $40 ; $57de
	farcall FarPtr_SetActorFacing ; $57e0
	ld a, $04 ; $57e3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $57e5
	ld a, $03 ; $57e8
	ld b, $00 ; $57ea
	farcall FarPtr_SetActorFacing ; $57ec
	ld a, $04 ; $57ef
	ld d, $02 ; $57f1
	farcall FarPtr_ScriptSetActorAnimation ; $57f3
	ld a, $04 ; $57f6
	farcall FarPtr_ScriptWaitActorIdle ; $57f8
	ld a, $04 ; $57fb
	farcall FarPtr_ScriptShowSpeakerDialogue ; $57fd
	ld a, $03 ; $5800
	ld d, $02 ; $5802
	farcall FarPtr_ScriptSetActorAnimation ; $5804
	ld a, $03 ; $5807
	farcall FarPtr_ScriptWaitActorIdle ; $5809
	ld a, $04 ; $580c
	ld b, $80 ; $580e
	farcall FarPtr_SetActorFacing ; $5810
	ld a, $03 ; $5813
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5815
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
	ld a, $04 ; $5835
	ld b, $c0 ; $5837
	farcall FarPtr_SetActorFacing ; $5839
	ld a, $28 ; $583c
	call DelayFrames ; $583e
	ld a, $03 ; $5841
	ld b, $40 ; $5843
	farcall FarPtr_SetActorFacing ; $5845
	ld a, $03 ; $5848
	farcall FarPtr_ScriptShowSpeakerDialogue ; $584a
	ld a, $03 ; $584d
	ld d, $02 ; $584f
	farcall FarPtr_ScriptSetActorAnimation ; $5851
	ld a, $03 ; $5854
	farcall FarPtr_ScriptWaitActorIdle ; $5856
	ld a, $03 ; $5859
	farcall FarPtr_ScriptShowSpeakerDialogue ; $585b
	ld a, $00 ; $585e
	ld d, $02 ; $5860
	farcall FarPtr_ScriptSetActorAnimation ; $5862
	ld a, $00 ; $5865
	farcall FarPtr_ScriptWaitActorIdle ; $5867
	ld a, $03 ; $586a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $586c
	ld a, $00 ; $586f
	ld d, $03 ; $5871
	farcall FarPtr_ScriptSetActorAnimation ; $5873
	ld a, $00 ; $5876
	farcall FarPtr_ScriptWaitActorIdle ; $5878
	ld a, $03 ; $587b
	farcall FarPtr_GetActorStateAddr ; $587d
	ld c, l ; $5880
	ld b, h ; $5881
	ld de, $d000 ; $5882
	farcall FarPtr_04_20 ; $5885
	ret ; $5888
Label_0f_5889:
	ld a, $02 ; $5889
	farcall FarPtr_0a_1c ; $588b
	ld a, $02 ; $588e
	ld bc, $0b00 ; $5890
	ld de, $2700 ; $5893
	farcall FarPtr_ScriptSetActorPosition ; $5896
	ld a, $02 ; $5899
	ld b, $c0 ; $589b
	farcall FarPtr_SetActorFacing ; $589d
	call Func_0f_5b4d ; $58a0
	ld hl, $2897 ; $58a3
	farcall FarPtr_0a_0e ; $58a6
	ld a, $02 ; $58a9
	ld d, $02 ; $58ab
	farcall FarPtr_ScriptSetActorAnimation ; $58ad
	ld a, $02 ; $58b0
	farcall FarPtr_ScriptWaitActorIdle ; $58b2
	ld a, $02 ; $58b5
	ld b, $40 ; $58b7
	farcall FarPtr_SetActorFacing ; $58b9
	call Func_0f_5aec ; $58bc
	ld a, $00 ; $58bf
	ld d, $03 ; $58c1
	farcall FarPtr_ScriptSetActorAnimation ; $58c3
	ld a, $00 ; $58c6
	farcall FarPtr_ScriptWaitActorIdle ; $58c8
	ld a, $02 ; $58cb
	ld d, $03 ; $58cd
	farcall FarPtr_ScriptSetActorAnimation ; $58cf
	ld a, $02 ; $58d2
	farcall FarPtr_ScriptWaitActorIdle ; $58d4
	call Func_0f_5aec ; $58d7
	ld a, $00 ; $58da
	ld d, $03 ; $58dc
	farcall FarPtr_ScriptSetActorAnimation ; $58de
	ld a, $00 ; $58e1
	farcall FarPtr_ScriptWaitActorIdle ; $58e3
	ld a, $02 ; $58e6
	ld b, a ; $58e8
	ld a, $04 ; $58e9
	farcall FarPtr_FaceActorTowardActor ; $58eb
	ld a, $0a ; $58ee
	call DelayFrames ; $58f0
	ld a, $04 ; $58f3
	ld d, $02 ; $58f5
	farcall FarPtr_ScriptSetActorAnimation ; $58f7
	ld a, $04 ; $58fa
	farcall FarPtr_ScriptWaitActorIdle ; $58fc
	ld a, $04 ; $58ff
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5901
	ld a, $00 ; $5904
	ld b, a ; $5906
	ld a, $05 ; $5907
	farcall FarPtr_FaceActorTowardActor ; $5909
	ld a, $05 ; $590c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $590e
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
	ld a, $02 ; $592e
	ld b, $00 ; $5930
	farcall FarPtr_SetActorFacing ; $5932
	ld a, $02 ; $5935
	ld d, $02 ; $5937
	farcall FarPtr_ScriptSetActorAnimation ; $5939
	ld a, $02 ; $593c
	farcall FarPtr_ScriptWaitActorIdle ; $593e
	call Func_0f_5aec ; $5941
	ld a, $04 ; $5944
	ld d, $02 ; $5946
	farcall FarPtr_ScriptSetActorAnimation ; $5948
	ld a, $04 ; $594b
	farcall FarPtr_ScriptWaitActorIdle ; $594d
	ld a, $04 ; $5950
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5952
	ld a, $05 ; $5955
	ld d, $02 ; $5957
	farcall FarPtr_ScriptSetActorAnimation ; $5959
	ld a, $05 ; $595c
	farcall FarPtr_ScriptWaitActorIdle ; $595e
	ld a, $05 ; $5961
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5963
	ld a, $1e ; $5966
	call DelayFrames ; $5968
	ld a, $02 ; $596b
	ld b, a ; $596d
	ld a, $00 ; $596e
	farcall FarPtr_FaceActorsTowardEachOther ; $5970
	ld a, $3c ; $5973
	call DelayFrames ; $5975
	ld a, $00 ; $5978
	ld b, $00 ; $597a
	farcall FarPtr_SetActorFacing ; $597c
	ld a, $02 ; $597f
	ld b, $00 ; $5981
	farcall FarPtr_SetActorFacing ; $5983
	ld a, $1e ; $5986
	call DelayFrames ; $5988
	ld a, $04 ; $598b
	ld b, $40 ; $598d
	farcall FarPtr_SetActorFacing ; $598f
	ld a, $04 ; $5992
	ld d, $04 ; $5994
	farcall FarPtr_ScriptSetActorAnimation ; $5996
	ld a, $04 ; $5999
	farcall FarPtr_ScriptWaitActorIdle ; $599b
	ld a, $04 ; $599e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $59a0
	ld a, $28 ; $59a3
	call DelayFrames ; $59a5
	ld a, $0b ; $59a8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $59aa
	ld a, $00 ; $59ad
	ld b, $c0 ; $59af
	farcall FarPtr_SetActorFacing ; $59b1
	ld a, $02 ; $59b4
	ld b, $c0 ; $59b6
	farcall FarPtr_SetActorFacing ; $59b8
	ld a, $04 ; $59bb
	ld b, $c0 ; $59bd
	farcall FarPtr_SetActorFacing ; $59bf
	ld a, $05 ; $59c2
	ld b, $c0 ; $59c4
	farcall FarPtr_SetActorFacing ; $59c6
	ld a, $14 ; $59c9
	call DelayFrames ; $59cb
	ld bc, $0018 ; $59ce
	farcall FarPtr_0a_38 ; $59d1
	xor a, a ; $59d4
	ld bc, $0c00 ; $59d5
	ld de, $1300 ; $59d8
	farcall FarPtr_MovePlayerToPosition ; $59db
	farcall FarPtr_WaitPlayerMoveDone ; $59de
	ld a, $1e ; $59e1
	call DelayFrames ; $59e3
	ld a, $0b ; $59e6
	ld d, $02 ; $59e8
	farcall FarPtr_ScriptSetActorAnimation ; $59ea
	ld a, $0b ; $59ed
	farcall FarPtr_ScriptWaitActorIdle ; $59ef
	ld a, $0b ; $59f2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $59f4
	ld a, $28 ; $59f7
	call DelayFrames ; $59f9
	xor a, a ; $59fc
	ld bc, $0c00 ; $59fd
	ld de, $2900 ; $5a00
	farcall FarPtr_MovePlayerToPosition ; $5a03
	farcall FarPtr_WaitPlayerMoveDone ; $5a06
	ld a, $04 ; $5a09
	ld b, $80 ; $5a0b
	farcall FarPtr_SetActorFacing ; $5a0d
	ld a, $04 ; $5a10
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5a12
	ld a, $00 ; $5a15
	ld b, $00 ; $5a17
	farcall FarPtr_SetActorFacing ; $5a19
	ld a, $02 ; $5a1c
	ld b, $00 ; $5a1e
	farcall FarPtr_SetActorFacing ; $5a20
	ld a, $04 ; $5a23
	ld d, $02 ; $5a25
	farcall FarPtr_ScriptSetActorAnimation ; $5a27
	ld a, $04 ; $5a2a
	farcall FarPtr_ScriptWaitActorIdle ; $5a2c
	ld a, $04 ; $5a2f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5a31
	ld a, $05 ; $5a34
	ld b, $80 ; $5a36
	farcall FarPtr_SetActorFacing ; $5a38
	ld a, $05 ; $5a3b
	ld d, $02 ; $5a3d
	farcall FarPtr_ScriptSetActorAnimation ; $5a3f
	ld a, $05 ; $5a42
	farcall FarPtr_ScriptWaitActorIdle ; $5a44
	ld a, $05 ; $5a47
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5a49
	ld a, $02 ; $5a4c
	ld d, $02 ; $5a4e
	farcall FarPtr_ScriptSetActorAnimation ; $5a50
	ld a, $02 ; $5a53
	farcall FarPtr_ScriptWaitActorIdle ; $5a55
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
	ld a, $04 ; $5a8a
	ld b, $c0 ; $5a8c
	farcall FarPtr_SetActorFacing ; $5a8e
	ld a, $05 ; $5a91
	ld b, $c0 ; $5a93
	farcall FarPtr_SetActorFacing ; $5a95
	ld a, $1e ; $5a98
	call DelayFrames ; $5a9a
	ld a, $00 ; $5a9d
	ld b, a ; $5a9f
	ld a, $02 ; $5aa0
	farcall FarPtr_FaceActorsTowardEachOther ; $5aa2
	call Func_0f_5aec ; $5aa5
	ld a, $02 ; $5aa8
	ld d, $02 ; $5aaa
	farcall FarPtr_ScriptSetActorAnimation ; $5aac
	ld a, $02 ; $5aaf
	farcall FarPtr_ScriptWaitActorIdle ; $5ab1
	call Func_0f_5aec ; $5ab4
	ld a, $00 ; $5ab7
	ld d, $02 ; $5ab9
	farcall FarPtr_ScriptSetActorAnimation ; $5abb
	ld a, $00 ; $5abe
	farcall FarPtr_ScriptWaitActorIdle ; $5ac0
	ld a, $02 ; $5ac3
	ld d, $03 ; $5ac5
	farcall FarPtr_ScriptSetActorAnimation ; $5ac7
	ld a, $02 ; $5aca
	farcall FarPtr_ScriptWaitActorIdle ; $5acc
	call Func_0f_5aec ; $5acf
	ld a, $00 ; $5ad2
	ld d, $03 ; $5ad4
	farcall FarPtr_ScriptSetActorAnimation ; $5ad6
	ld a, $00 ; $5ad9
	farcall FarPtr_ScriptWaitActorIdle ; $5adb
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
	ld a, $02 ; $5af2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5af4
	farcall FarPtr_0a_10 ; $5af7
	ret ; $5afa
Label_0f_5afb:
	farcall FarPtr_0a_10 ; $5afb
	ld a, $02 ; $5afe
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5b00
	ret ; $5b03
	; $5b04, 73 bytes (records:8)
; 9 records x 8 bytes
	dw $ff03, $0000, $28b7, $0003 ; record 0
	dw $ff04, $0000, $28a5, $0003 ; record 1
	dw $ff05, $0000, $28a6, $0003 ; record 2
	dw $ff06, $0000, $28af, $0003 ; record 3
	dw $ff07, $0000, $28b1, $0003 ; record 4
	dw $ff08, $0000, $5628, $0003 ; record 5
	dw $ff09, $0000, $2882, $0003 ; record 6
	dw $ff0a, $0000, $2883, $0003 ; record 7
	dw $ff12, $0000, $28b0, $0003 ; record 8
	db $ff
Func_0f_5b4d:
	ld bc, $00ff ; $5b4d
	farcall FarPtr_0a_38 ; $5b50
	xor a, a ; $5b53
	ld bc, $0c00 ; $5b54
	ld de, $0b00 ; $5b57
	farcall FarPtr_MovePlayerToPosition ; $5b5a
	farcall FarPtr_WaitPlayerMoveDone ; $5b5d
	xor a, a ; $5b60
	ld [$c2d5], a ; $5b61
	ld c, $04 ; $5b64
	call BeginFadeIn ; $5b66
	call WaitFadeEnd ; $5b69
	ld d, $30 ; $5b6c
	ld a, $13 ; $5b6e
	farcall FarPtr_GetActorStateAddr ; $5b70
	ld c, l ; $5b73
	ld b, h ; $5b74
	farcall FarPtr_04_2c ; $5b75
	ld a, $13 ; $5b78
	ld d, $01 ; $5b7a
	farcall FarPtr_ScriptSetActorAnimation ; $5b7c
	ld d, $3a ; $5b7f
	ld a, $14 ; $5b81
	farcall FarPtr_GetActorStateAddr ; $5b83
	ld c, l ; $5b86
	ld b, h ; $5b87
	farcall FarPtr_04_2c ; $5b88
	ld a, $14 ; $5b8b
	ld d, $01 ; $5b8d
	farcall FarPtr_ScriptSetActorAnimation ; $5b8f
	ld a, $13 ; $5b92
	ld bc, $0700 ; $5b94
	ld de, $0100 ; $5b97
	farcall FarPtr_ScriptSetActorPosition ; $5b9a
	ld a, $14 ; $5b9d
	ld bc, $0f00 ; $5b9f
	ld de, $0100 ; $5ba2
	farcall FarPtr_ScriptSetActorPosition ; $5ba5
	ld a, $13 ; $5ba8
	ld bc, $0020 ; $5baa
	farcall FarPtr_0a_18 ; $5bad
	ld a, $13 ; $5bb0
	ld bc, $0700 ; $5bb2
	ld de, $0500 ; $5bb5
	farcall FarPtr_ScriptSetActorMoveTarget ; $5bb8
	ld a, $13 ; $5bbb
	farcall FarPtr_ScriptWaitActorMoveDone ; $5bbd
	ld a, $13 ; $5bc0
	ld d, $04 ; $5bc2
	farcall FarPtr_ScriptSetActorAnimation ; $5bc4
	ld a, $13 ; $5bc7
	farcall FarPtr_ScriptWaitActorIdle ; $5bc9
	ld a, $13 ; $5bcc
	ld de, $ff80 ; $5bce
	farcall FarPtr_0a_42 ; $5bd1
	ld a, $13 ; $5bd4
	farcall FarPtr_0a_44 ; $5bd6
	ld a, $14 ; $5bd9
	ld bc, $0020 ; $5bdb
	farcall FarPtr_0a_18 ; $5bde
	ld a, $14 ; $5be1
	ld bc, $0f00 ; $5be3
	ld de, $0780 ; $5be6
	farcall FarPtr_ScriptSetActorMoveTarget ; $5be9
	ld a, $14 ; $5bec
	farcall FarPtr_ScriptWaitActorMoveDone ; $5bee
	ld a, $13 ; $5bf1
	ld de, $ff80 ; $5bf3
	farcall FarPtr_0a_42 ; $5bf6
	ld a, $14 ; $5bf9
	ld d, $02 ; $5bfb
	farcall FarPtr_ScriptSetActorAnimation ; $5bfd
	ld bc, $0010 ; $5c00
	farcall FarPtr_0a_38 ; $5c03
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
	ld a, $13 ; $5c21
	ld d, $01 ; $5c23
	farcall FarPtr_ScriptSetActorAnimation ; $5c25
	ld d, $53 ; $5c28
	ld a, $14 ; $5c2a
	farcall FarPtr_GetActorStateAddr ; $5c2c
	ld c, l ; $5c2f
	ld b, h ; $5c30
	farcall FarPtr_04_2c ; $5c31
	ld a, $14 ; $5c34
	ld d, $01 ; $5c36
	farcall FarPtr_ScriptSetActorAnimation ; $5c38
	ld a, $13 ; $5c3b
	ld bc, $3f00 ; $5c3d
	ld de, $3f00 ; $5c40
	farcall FarPtr_ScriptSetActorPosition ; $5c43
	ld a, $14 ; $5c46
	ld bc, $3f00 ; $5c48
	ld de, $3f00 ; $5c4b
	farcall FarPtr_ScriptSetActorPosition ; $5c4e
	ret ; $5c51
Func_0f_5c52:
	ld a, $0c ; $5c52
	ld b, a ; $5c54
	ld a, $0b ; $5c55
	farcall FarPtr_FaceActorsTowardEachOther ; $5c57
	ld a, $1e ; $5c5a
	call DelayFrames ; $5c5c
	ld a, $0b ; $5c5f
	ld d, $03 ; $5c61
	farcall FarPtr_ScriptSetActorAnimation ; $5c63
	ld a, $0b ; $5c66
	farcall FarPtr_ScriptWaitActorIdle ; $5c68
	ld a, $0c ; $5c6b
	ld d, $03 ; $5c6d
	farcall FarPtr_ScriptSetActorAnimation ; $5c6f
	ld a, $0c ; $5c72
	farcall FarPtr_ScriptWaitActorIdle ; $5c74
	ld a, $1e ; $5c77
	call DelayFrames ; $5c79
	ld a, $0b ; $5c7c
	ld b, $00 ; $5c7e
	farcall FarPtr_SetActorFacing ; $5c80
	ld a, $0c ; $5c83
	ld b, $00 ; $5c85
	farcall FarPtr_SetActorFacing ; $5c87
	ld hl, $2885 ; $5c8a
	farcall FarPtr_0a_0e ; $5c8d
	ld a, $0b ; $5c90
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5c92
	ret ; $5c95
Func_0f_5c96:
	ld a, $05 ; $5c96
	ld b, $c0 ; $5c98
	farcall FarPtr_SetActorFacing ; $5c9a
	ld a, $08 ; $5c9d
	ld b, $c0 ; $5c9f
	farcall FarPtr_SetActorFacing ; $5ca1
	ld a, $09 ; $5ca4
	ld b, $c0 ; $5ca6
	farcall FarPtr_SetActorFacing ; $5ca8
	ld a, $0a ; $5cab
	ld b, $c0 ; $5cad
	farcall FarPtr_SetActorFacing ; $5caf
	ld a, $06 ; $5cb2
	ld b, $c0 ; $5cb4
	farcall FarPtr_SetActorFacing ; $5cb6
	ld a, $12 ; $5cb9
	ld b, $c0 ; $5cbb
	farcall FarPtr_SetActorFacing ; $5cbd
	ld a, $07 ; $5cc0
	ld b, $c0 ; $5cc2
	farcall FarPtr_SetActorFacing ; $5cc4
	ld a, $11 ; $5cc7
	ld b, $c0 ; $5cc9
	farcall FarPtr_SetActorFacing ; $5ccb
	ret ; $5cce
Func_0f_5ccf:
	ld a, $1e ; $5ccf
	call DelayFrames ; $5cd1
	ld a, $0b ; $5cd4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5cd6
	ld a, $0b ; $5cd9
	ld d, $03 ; $5cdb
	farcall FarPtr_ScriptSetActorAnimation ; $5cdd
	ld a, $0b ; $5ce0
	farcall FarPtr_ScriptWaitActorIdle ; $5ce2
	ld a, $0b ; $5ce5
	ld b, $c0 ; $5ce7
	farcall FarPtr_SetActorFacing ; $5ce9
	ld a, $1e ; $5cec
	call DelayFrames ; $5cee
	ld a, $0b ; $5cf1
	ld b, $01 ; $5cf3
	farcall FarPtr_0a_2c ; $5cf5
	ld a, $0b ; $5cf8
	ld bc, $0700 ; $5cfa
	ld de, $1b00 ; $5cfd
	farcall FarPtr_ScriptSetActorMoveTarget ; $5d00
	ld a, $0b ; $5d03
	farcall FarPtr_ScriptWaitActorMoveDone ; $5d05
	ld a, $0b ; $5d08
	ld b, $00 ; $5d0a
	farcall FarPtr_0a_2c ; $5d0c
	ld a, $0b ; $5d0f
	ld b, $00 ; $5d11
	farcall FarPtr_SetActorFacing ; $5d13
	ld a, $0c ; $5d16
	ld bc, $0800 ; $5d18
	ld de, $1900 ; $5d1b
	farcall FarPtr_ScriptSetActorMoveTarget ; $5d1e
	ld a, $0c ; $5d21
	farcall FarPtr_ScriptWaitActorMoveDone ; $5d23
	ld a, $0c ; $5d26
	ld b, $00 ; $5d28
	farcall FarPtr_SetActorFacing ; $5d2a
	ld a, $1e ; $5d2d
	call DelayFrames ; $5d2f
	ld a, $0c ; $5d32
	ld d, $03 ; $5d34
	farcall FarPtr_ScriptSetActorAnimation ; $5d36
	ld a, $0c ; $5d39
	farcall FarPtr_ScriptWaitActorIdle ; $5d3b
	ld a, $0c ; $5d3e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5d40
	ld a, $0c ; $5d43
	ld d, $04 ; $5d45
	farcall FarPtr_ScriptSetActorAnimation ; $5d47
	ld a, $0c ; $5d4a
	farcall FarPtr_ScriptWaitActorIdle ; $5d4c
	ld a, $0c ; $5d4f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5d51
	ld a, $0c ; $5d54
	ld d, $02 ; $5d56
	farcall FarPtr_ScriptSetActorAnimation ; $5d58
	ld a, $0c ; $5d5b
	farcall FarPtr_ScriptWaitActorIdle ; $5d5d
	ld a, $0c ; $5d60
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5d62
	ld a, $0c ; $5d65
	ld d, $04 ; $5d67
	farcall FarPtr_ScriptSetActorAnimation ; $5d69
	ld a, $0c ; $5d6c
	farcall FarPtr_ScriptWaitActorIdle ; $5d6e
	ld a, $0c ; $5d71
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5d73
	ld a, $0c ; $5d76
	ld d, $03 ; $5d78
	farcall FarPtr_ScriptSetActorAnimation ; $5d7a
	ld a, $0c ; $5d7d
	farcall FarPtr_ScriptWaitActorIdle ; $5d7f
	ld a, $0c ; $5d82
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5d84
	ld a, $0c ; $5d87
	ld d, $03 ; $5d89
	farcall FarPtr_ScriptSetActorAnimation ; $5d8b
	ld a, $0c ; $5d8e
	farcall FarPtr_ScriptWaitActorIdle ; $5d90
	ld a, $3c ; $5d93
	call DelayFrames ; $5d95
	ld a, $0c ; $5d98
	ld bc, $0800 ; $5d9a
	ld de, $1700 ; $5d9d
	farcall FarPtr_ScriptSetActorMoveTarget ; $5da0
	ld a, $0c ; $5da3
	farcall FarPtr_ScriptWaitActorMoveDone ; $5da5
	ld a, $0c ; $5da8
	ld b, $00 ; $5daa
	farcall FarPtr_SetActorFacing ; $5dac
	ld a, $0b ; $5daf
	ld bc, $0800 ; $5db1
	ld de, $1900 ; $5db4
	farcall FarPtr_ScriptSetActorMoveTarget ; $5db7
	ld a, $0b ; $5dba
	farcall FarPtr_ScriptWaitActorMoveDone ; $5dbc
	ld a, $0b ; $5dbf
	ld b, $00 ; $5dc1
	farcall FarPtr_SetActorFacing ; $5dc3
	ld a, $1e ; $5dc6
	call DelayFrames ; $5dc8
	ld a, $0b ; $5dcb
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5dcd
	ld d, $30 ; $5dd0
	ld a, $07 ; $5dd2
	farcall FarPtr_GetActorStateAddr ; $5dd4
	ld c, l ; $5dd7
	ld b, h ; $5dd8
	farcall FarPtr_04_2c ; $5dd9
	ld a, $07 ; $5ddc
	ld d, $01 ; $5dde
	farcall FarPtr_ScriptSetActorAnimation ; $5de0
	ld d, $3a ; $5de3
	ld a, $14 ; $5de5
	farcall FarPtr_GetActorStateAddr ; $5de7
	ld c, l ; $5dea
	ld b, h ; $5deb
	farcall FarPtr_04_2c ; $5dec
	ld a, $14 ; $5def
	ld d, $01 ; $5df1
	farcall FarPtr_ScriptSetActorAnimation ; $5df3
	ld a, $07 ; $5df6
	ld bc, $0700 ; $5df8
	ld de, $0500 ; $5dfb
	farcall FarPtr_ScriptSetActorPosition ; $5dfe
	ld a, $14 ; $5e01
	ld bc, $0f00 ; $5e03
	ld de, $0780 ; $5e06
	farcall FarPtr_ScriptSetActorPosition ; $5e09
	ld a, $07 ; $5e0c
	ld b, $40 ; $5e0e
	farcall FarPtr_SetActorFacing ; $5e10
	ld a, $14 ; $5e13
	ld b, $40 ; $5e15
	farcall FarPtr_SetActorFacing ; $5e17
	ld a, $1e ; $5e1a
	call DelayFrames ; $5e1c
	xor a, a ; $5e1f
	ld bc, $0c00 ; $5e20
	ld de, $1100 ; $5e23
	farcall FarPtr_MovePlayerToPosition ; $5e26
	ld a, $0c ; $5e29
	ld bc, $0c00 ; $5e2b
	ld de, $1700 ; $5e2e
	farcall FarPtr_ScriptSetActorMoveTarget ; $5e31
	ld a, $0c ; $5e34
	farcall FarPtr_ScriptWaitActorMoveDone ; $5e36
	ld a, $0c ; $5e39
	ld bc, $0c00 ; $5e3b
	ld de, $1300 ; $5e3e
	farcall FarPtr_ScriptSetActorMoveTarget ; $5e41
	ld a, $0c ; $5e44
	farcall FarPtr_ScriptWaitActorMoveDone ; $5e46
	ret ; $5e49
Func_0f_5e4a:
	ld d, $74 ; $5e4a
	ld a, $10 ; $5e4c
	farcall FarPtr_GetActorStateAddr ; $5e4e
	ld c, l ; $5e51
	ld b, h ; $5e52
	farcall FarPtr_04_2c ; $5e53
	ld a, $10 ; $5e56
	ld d, $01 ; $5e58
	farcall FarPtr_ScriptSetActorAnimation ; $5e5a
	ld d, $25 ; $5e5d
	ld a, $0f ; $5e5f
	farcall FarPtr_GetActorStateAddr ; $5e61
	ld c, l ; $5e64
	ld b, h ; $5e65
	farcall FarPtr_04_2c ; $5e66
	ld a, $0f ; $5e69
	ld d, $01 ; $5e6b
	farcall FarPtr_ScriptSetActorAnimation ; $5e6d
	ld a, $0f ; $5e70
	ld bc, $1100 ; $5e72
	ld de, $1600 ; $5e75
	farcall FarPtr_ScriptSetActorPosition ; $5e78
	ld a, $10 ; $5e7b
	ld bc, $1100 ; $5e7d
	ld de, $1500 ; $5e80
	farcall FarPtr_ScriptSetActorPosition ; $5e83
	ld a, $0f ; $5e86
	ld b, $c0 ; $5e88
	farcall FarPtr_SetActorFacing ; $5e8a
	ld a, $10 ; $5e8d
	ld d, $08 ; $5e8f
	farcall FarPtr_ScriptSetActorAnimation ; $5e91
	ld a, $10 ; $5e94
	ld bc, $1100 ; $5e96
	ld de, $1200 ; $5e99
	farcall FarPtr_ScriptSetActorMoveTarget ; $5e9c
	ld a, $0f ; $5e9f
	ld bc, $1100 ; $5ea1
	ld de, $1300 ; $5ea4
	farcall FarPtr_ScriptSetActorMoveTarget ; $5ea7
	ld a, $0f ; $5eaa
	farcall FarPtr_ScriptWaitActorMoveDone ; $5eac
	ld d, $25 ; $5eaf
	ld a, $10 ; $5eb1
	farcall FarPtr_GetActorStateAddr ; $5eb3
	ld c, l ; $5eb6
	ld b, h ; $5eb7
	farcall FarPtr_04_2c ; $5eb8
	ld a, $10 ; $5ebb
	ld d, $01 ; $5ebd
	farcall FarPtr_ScriptSetActorAnimation ; $5ebf
	ld d, $74 ; $5ec2
	ld a, $0f ; $5ec4
	farcall FarPtr_GetActorStateAddr ; $5ec6
	ld c, l ; $5ec9
	ld b, h ; $5eca
	farcall FarPtr_04_2c ; $5ecb
	ld a, $0f ; $5ece
	ld d, $01 ; $5ed0
	farcall FarPtr_ScriptSetActorAnimation ; $5ed2
	ld a, $10 ; $5ed5
	ld bc, $1100 ; $5ed7
	ld de, $1300 ; $5eda
	farcall FarPtr_ScriptSetActorPosition ; $5edd
	ld a, $0f ; $5ee0
	ld bc, $1000 ; $5ee2
	ld de, $1300 ; $5ee5
	farcall FarPtr_ScriptSetActorPosition ; $5ee8
	ld a, $10 ; $5eeb
	ld b, $80 ; $5eed
	farcall FarPtr_SetActorFacing ; $5eef
	ld a, $0f ; $5ef2
	ld d, $08 ; $5ef4
	farcall FarPtr_ScriptSetActorAnimation ; $5ef6
	ld a, $10 ; $5ef9
	ld bc, $1000 ; $5efb
	ld de, $1300 ; $5efe
	farcall FarPtr_ScriptSetActorMoveTarget ; $5f01
	ld a, $0f ; $5f04
	ld bc, $0f00 ; $5f06
	ld de, $1300 ; $5f09
	farcall FarPtr_ScriptSetActorMoveTarget ; $5f0c
	ld a, $0f ; $5f0f
	farcall FarPtr_ScriptWaitActorMoveDone ; $5f11
	ld a, $10 ; $5f14
	ld b, $01 ; $5f16
	farcall FarPtr_0a_2c ; $5f18
	ld a, $10 ; $5f1b
	ld bc, $1100 ; $5f1d
	ld de, $1300 ; $5f20
	farcall FarPtr_ScriptSetActorMoveTarget ; $5f23
	ld a, $10 ; $5f26
	farcall FarPtr_ScriptWaitActorMoveDone ; $5f28
	ld a, $10 ; $5f2b
	ld b, $00 ; $5f2d
	farcall FarPtr_0a_2c ; $5f2f
	ld a, $10 ; $5f32
	ld bc, $0020 ; $5f34
	farcall FarPtr_0a_18 ; $5f37
	ld a, $10 ; $5f3a
	ld bc, $1100 ; $5f3c
	ld de, $1600 ; $5f3f
	farcall FarPtr_ScriptSetActorMoveTarget ; $5f42
	ld a, $10 ; $5f45
	farcall FarPtr_ScriptWaitActorMoveDone ; $5f47
	ld a, $10 ; $5f4a
	ld b, $c0 ; $5f4c
	farcall FarPtr_SetActorFacing ; $5f4e
	ret ; $5f51
Func_0f_5f52:
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
	; $5f94, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $6070 ; record 0
	dw $60b1 ; record 1
	dw $5fa2 ; record 2
	dw $6102 ; record 3
	dw $616b ; record 4
	dw $61a6 ; record 5
	dw $620f ; record 6
	; $5fa2, 206 bytes (bytes:14)
	db $00, $00, $57, $7b, $00, $27, $00, $11, $80, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $57, $7b, $00, $13, $00, $0f, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $57, $7b, $00, $01, $00, $0c, $00, $00, $25, $01, $00, $00 ; 0x1c
	db $00, $00, $57, $7b, $00, $23, $00, $11, $c0, $00, $5c, $01, $00, $00 ; 0x2a
	db $00, $00, $75, $7b, $00, $23, $00, $17, $c0, $00, $5b, $01, $00, $00 ; 0x38
	db $00, $00, $57, $7b, $00, $21, $00, $11, $00, $00, $5a, $01, $00, $00 ; 0x46
	db $00, $00, $57, $7b, $00, $29, $00, $17, $80, $00, $5f, $01, $00, $00 ; 0x54
	db $00, $00, $57, $7b, $00, $11, $00, $15, $40, $00, $5d, $01, $00, $00 ; 0x62
	db $00, $00, $57, $7b, $00, $19, $00, $13, $40, $00, $60, $01, $00, $00 ; 0x70
	db $00, $00, $57, $7b, $00, $17, $00, $13, $40, $00, $61, $01, $00, $00 ; 0x7e
	db $00, $00, $57, $7b, $00, $0f, $00, $13, $40, $00, $62, $01, $00, $00 ; 0x8c
	db $00, $00, $57, $7b, $00, $19, $00, $15, $40, $00, $5e, $01, $00, $00 ; 0x9a
	db $00, $00, $57, $7b, $00, $17, $00, $15, $40, $00, $1e, $01, $00, $00 ; 0xa8
	db $00, $00, $57, $7b, $00, $11, $00, $13, $40, $00, $1f, $01, $00, $00 ; 0xb6
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xc4
	; $6070, 65 bytes (bytes:16)
	db $01, $40, $00, $0e, $00, $09, $00, $00, $02, $40, $00, $2a, $00, $09, $00, $00 ; 0x00
	db $03, $00, $00, $05, $00, $0b, $00, $00, $04, $80, $00, $33, $00, $0b, $00, $00 ; 0x10
	db $05, $c0, $00, $1c, $00, $23, $00, $00, $0a, $40, $00, $25, $00, $11, $00, $00 ; 0x20
	db $0b, $40, $00, $23, $00, $11, $00, $00, $0f, $c0, $00, $1b, $00, $31, $00, $00 ; 0x30
	db $ff ; 0x40
	; $60b1, 41 bytes (records:8)
; 5 records x 8 bytes
	dw $ff01, $0000, $60da, $0118 ; record 0
	dw $ff02, $0000, $60da, $0218 ; record 1
	dw $ff03, $0000, $60da, $0117 ; record 2
	dw $ff04, $0000, $60da, $0116 ; record 3
	dw $ff05, $0000, $60da, $0315 ; record 4
	db $ff
	clear_flag $17, 1 ; $60da
	ret ; $60dd
	ld hl, $24a3 ; $60de
	farcall FarPtr_0a_0e ; $60e1
	ld a, $0b ; $60e4
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $60e6
	farcall FarPtr_0a_12 ; $60e9
	farcall FarPtr_ScriptCloseDialogueWindow ; $60ec
	push af ; $60ef
	ld a, $05 ; $60f0
	farcall FarPtr_WaitScriptFrames ; $60f2
	pop af ; $60f5
	and a, a ; $60f6
	jr z, Label_0f_60fc ; $60f7
	farcall FarPtr_0a_10 ; $60f9
Label_0f_60fc:
	ld a, $0b ; $60fc
	farcall FarPtr_ScriptShowSpeakerDialogue ; $60fe
	ret ; $6101
	; $6102, 105 bytes (records:8)
; 13 records x 8 bytes
	dw $ff06, $0000, $249f, $0003 ; record 0
	dw $ff07, $0000, $24a0, $0013 ; record 1
	dw $ff08, $0000, $24a1, $0003 ; record 2
	dw $ff09, $0000, $24a2, $0003 ; record 3
	dw $ff0a, $0000, $60de, $0003 ; record 4
	dw $ff0b, $0000, $24a6, $0003 ; record 5
	dw $ff0c, $0000, $24a7, $0003 ; record 6
	dw $ff0d, $0000, $24a8, $0003 ; record 7
	dw $ff0e, $0000, $24a9, $0003 ; record 8
	dw $ff0f, $0000, $24aa, $0003 ; record 9
	dw $ff10, $0000, $24ab, $0003 ; record 10
	dw $ff03, $0000, $6f3c, $0003 ; record 11
	dw $ff04, $0000, $6f71, $0003 ; record 12
	db $ff
	; $616b, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $6174, $0000 ; record 0
	db $ff
	xor a, a ; $6174
	ldh [hBGColumnBlitPending], a ; $6175
	ldh [hBGRowBlitPending], a ; $6177
	ldh [hScrollY], a ; $6179
	ldh [hScrollX], a ; $617b
	ld [$c321], a ; $617d
	ld [$c323], a ; $6180
	call ClearFrameTasks ; $6183
	call Func_0f_7416 ; $6186
	ld d, $03 ; $6189
	farcall FarPtr_1b_1a ; $618b
	ld hl, wStoryModePlayersXPosition ; $618e
	ld de, $c296 ; $6191
	ld bc, $0005 ; $6194
	call CopyMemoryBC ; $6197
	ld a, $ff ; $619a
	ld [$c295], a ; $619c
	ld [$c294], a ; $619f
	ld [$c2a1], a ; $61a2
	ret ; $61a5
	; $61a6, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $ff0e, $0000, $61b7, $0000 ; record 0
	dw $ff0f, $0000, $61f6, $0000 ; record 1
	db $ff
	ld a, $01 ; $61b7
	ld [$c2b1], a ; $61b9
	ld a, $02 ; $61bc
	farcall FarPtr_0a_1c ; $61be
	ldh a, [hRomBank] ; $61c1
	ld b, a ; $61c3
	ld a, $00 ; $61c4
	ld de, $61e0 ; $61c6
	farcall FarPtr_0a_1a ; $61c9
	ldh a, [hRomBank] ; $61cc
	ld b, a ; $61ce
	ld a, $02 ; $61cf
	ld de, $61eb ; $61d1
	farcall FarPtr_0a_1a ; $61d4
	ld a, $00 ; $61d7
	farcall FarPtr_WaitActorScriptDone ; $61d9
	call Func_0f_6fc3 ; $61dc
	ret ; $61df
	INCBIN "data/bank_00f/d_61e0.bin" ; $61e0, 22 bytes
	ld a, $00 ; $61f6
	ld [$c2b1], a ; $61f8
	ldh a, [hRomBank] ; $61fb
	ld b, a ; $61fd
	ld a, $00 ; $61fe
	ld de, $61eb ; $6200
	farcall FarPtr_0a_1a ; $6203
	ld a, $00 ; $6206
	farcall FarPtr_WaitActorScriptDone ; $6208
	call Func_0f_6fc3 ; $620b
	ret ; $620e
	ld a, $01 ; $620f
	ld hl, $6310 ; $6211
	call RegisterFrameTask ; $6214
	ld a, [$c295] ; $6217
	cp a, $ff ; $621a
	jr z, Label_0f_6221 ; $621c
	clear_flag $17, 1 ; $621e
Label_0f_6221:
	test_flag $17, 1 ; $6221
	jp z, Label_0f_62eb ; $6224
	call Func_0f_660f ; $6227
	ld a, [$c2b0] ; $622a
	and a, a ; $622d
	jr nz, Label_0f_628e ; $622e
	ldh a, [hRomBank] ; $6230
	ld hl, $65c2 ; $6232
	farcall FarPtr_0a_06 ; $6235
	ld hl, $65f6 ; $6238
	ld de, $000c ; $623b
	farcall FarPtr_0a_60 ; $623e
	farcall FarPtr_0a_00 ; $6241
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
	ld a, $03 ; $6265
	ld b, $40 ; $6267
	farcall FarPtr_SetActorFacing ; $6269
	ld a, $04 ; $626c
	ld b, $40 ; $626e
	farcall FarPtr_SetActorFacing ; $6270
	ld a, $05 ; $6273
	ld b, $80 ; $6275
	farcall FarPtr_SetActorFacing ; $6277
	test_flag $05, 7 ; $627a
	jr z, Label_0f_628a ; $627d
	ld a, $05 ; $627f
	ld bc, $3f00 ; $6281
	ld de, $3f00 ; $6284
	farcall FarPtr_ScriptSetActorPosition ; $6287
Label_0f_628a:
	call Func_0f_7b20 ; $628a
	ret ; $628d
Label_0f_628e:
	test_flag $05, 7 ; $628e
	jr nz, Label_0f_62c4 ; $6291
	ldh a, [hRomBank] ; $6293
	ld hl, $75b7 ; $6295
	farcall FarPtr_0a_06 ; $6298
	ld hl, $7615 ; $629b
	ld de, $000c ; $629e
	farcall FarPtr_0a_60 ; $62a1
	farcall FarPtr_0a_00 ; $62a4
	call Func_0f_7b20 ; $62a7
	ld a, $03 ; $62aa
	ld b, $00 ; $62ac
	farcall FarPtr_SetActorFacing ; $62ae
	ld a, $04 ; $62b1
	ld bc, $2700 ; $62b3
	ld de, $1300 ; $62b6
	farcall FarPtr_ScriptSetActorPosition ; $62b9
	ld a, $04 ; $62bc
	ld b, $80 ; $62be
	farcall FarPtr_SetActorFacing ; $62c0
	ret ; $62c3
Label_0f_62c4:
	ldh a, [hRomBank] ; $62c4
	ld hl, $7842 ; $62c6
	farcall FarPtr_0a_06 ; $62c9
	ld hl, $78a0 ; $62cc
	ld de, $000c ; $62cf
	farcall FarPtr_0a_60 ; $62d2
	farcall FarPtr_0a_00 ; $62d5
	call Func_0f_7b20 ; $62d8
	ld a, $00 ; $62db
	ld b, a ; $62dd
	ld a, $04 ; $62de
	farcall FarPtr_FaceActorTowardActor ; $62e0
	ld a, $03 ; $62e3
	ld b, $00 ; $62e5
	farcall FarPtr_SetActorFacing ; $62e7
	ret ; $62ea
Label_0f_62eb:
	ld a, [$c295] ; $62eb
	cp a, $0f ; $62ee
	jr nz, Label_0f_62f6 ; $62f0
	call Func_0f_6426 ; $62f2
	ret ; $62f5
Label_0f_62f6:
	cp a, $0a ; $62f6
	jr nz, Label_0f_62fe ; $62f8
	call Func_0f_7487 ; $62fa
	ret ; $62fd
Label_0f_62fe:
	cp a, $0b ; $62fe
	jr nz, Label_0f_6306 ; $6300
	call $76a3 ; $6302
	ret ; $6305
Label_0f_6306:
	call Func_0f_6651 ; $6306
	call Func_0f_7b20 ; $6309
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
Func_0f_6426:
	set_flag $17, 1 ; $6426
	ldh a, [hRomBank] ; $6429
	ld hl, $65c2 ; $642b
	farcall FarPtr_0a_06 ; $642e
	ld hl, $65f6 ; $6431
	ld de, $000c ; $6434
	farcall FarPtr_0a_60 ; $6437
	farcall FarPtr_0a_00 ; $643a
	call Func_0f_7a17 ; $643d
	ld bc, $00ff ; $6440
	farcall FarPtr_0a_38 ; $6443
	xor a, a ; $6446
	ld bc, $1c00 ; $6447
	ld de, $2500 ; $644a
	farcall FarPtr_MovePlayerToPosition ; $644d
	farcall FarPtr_WaitPlayerMoveDone ; $6450
	ld c, $04 ; $6453
	call BeginFadeIn ; $6455
	call WaitFadeEnd ; $6458
	ld bc, $0018 ; $645b
	farcall FarPtr_0a_38 ; $645e
	xor a, a ; $6461
	ld bc, $1c00 ; $6462
	ld de, $1b00 ; $6465
	farcall FarPtr_MovePlayerToPosition ; $6468
	ld a, $03 ; $646b
	ld bc, $1c00 ; $646d
	ld de, $1c00 ; $6470
	farcall FarPtr_ScriptSetActorMoveTarget ; $6473
	ld a, $04 ; $6476
	ld bc, $1c00 ; $6478
	ld de, $1f00 ; $647b
	farcall FarPtr_ScriptSetActorMoveTarget ; $647e
	ld a, $05 ; $6481
	ld bc, $1d00 ; $6483
	ld de, $2100 ; $6486
	farcall FarPtr_ScriptSetActorMoveTarget ; $6489
	ld a, $00 ; $648c
	ld bc, $1b00 ; $648e
	ld de, $2100 ; $6491
	farcall FarPtr_ScriptSetActorMoveTarget ; $6494
	ld a, $00 ; $6497
	farcall FarPtr_ScriptWaitActorMoveDone ; $6499
	push af ; $649c
	ld a, $28 ; $649d
	farcall FarPtr_WaitScriptFrames ; $649f
	pop af ; $64a2
	ld a, $03 ; $64a3
	ld b, $40 ; $64a5
	farcall FarPtr_SetActorFacing ; $64a7
	ld hl, $2415 ; $64aa
	farcall FarPtr_0a_0e ; $64ad
	ld a, $00 ; $64b0
	ld b, $40 ; $64b2
	farcall FarPtr_SetActorFacing ; $64b4
	push af ; $64b7
	ld a, $28 ; $64b8
	farcall FarPtr_WaitScriptFrames ; $64ba
	pop af ; $64bd
	ld a, $00 ; $64be
	ld b, $80 ; $64c0
	farcall FarPtr_SetActorFacing ; $64c2
	push af ; $64c5
	ld a, $28 ; $64c6
	farcall FarPtr_WaitScriptFrames ; $64c8
	pop af ; $64cb
	ld a, $00 ; $64cc
	ld b, $c0 ; $64ce
	farcall FarPtr_SetActorFacing ; $64d0
	push af ; $64d3
	ld a, $28 ; $64d4
	farcall FarPtr_WaitScriptFrames ; $64d6
	pop af ; $64d9
	ld a, $00 ; $64da
	ld b, $00 ; $64dc
	farcall FarPtr_SetActorFacing ; $64de
	push af ; $64e1
	ld a, $28 ; $64e2
	farcall FarPtr_WaitScriptFrames ; $64e4
	pop af ; $64e7
	ld a, $00 ; $64e8
	ld b, $40 ; $64ea
	farcall FarPtr_SetActorFacing ; $64ec
	push af ; $64ef
	ld a, $28 ; $64f0
	farcall FarPtr_WaitScriptFrames ; $64f2
	pop af ; $64f5
	ld a, $00 ; $64f6
	ld d, $02 ; $64f8
	farcall FarPtr_ScriptSetActorAnimation ; $64fa
	ld a, $00 ; $64fd
	farcall FarPtr_ScriptWaitActorIdle ; $64ff
	ld a, $04 ; $6502
	ld b, $00 ; $6504
	farcall FarPtr_SetActorFacing ; $6506
	ld a, $04 ; $6509
	ld b, $40 ; $650b
	farcall FarPtr_SetActorFacing ; $650d
	ld a, $05 ; $6510
	ld b, $80 ; $6512
	farcall FarPtr_SetActorFacing ; $6514
	push af ; $6517
	ld a, $14 ; $6518
	farcall FarPtr_WaitScriptFrames ; $651a
	pop af ; $651d
	ld a, $04 ; $651e
	ld d, $04 ; $6520
	farcall FarPtr_ScriptSetActorAnimation ; $6522
	ld a, $04 ; $6525
	farcall FarPtr_ScriptWaitActorIdle ; $6527
	ld a, $04 ; $652a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $652c
	ld a, $00 ; $652f
	ld b, $c0 ; $6531
	farcall FarPtr_SetActorFacing ; $6533
	push af ; $6536
	ld a, $28 ; $6537
	farcall FarPtr_WaitScriptFrames ; $6539
	pop af ; $653c
	ld a, $00 ; $653d
	ld d, $03 ; $653f
	farcall FarPtr_ScriptSetActorAnimation ; $6541
	ld a, $00 ; $6544
	farcall FarPtr_ScriptWaitActorIdle ; $6546
	ld a, $03 ; $6549
	ld d, $02 ; $654b
	farcall FarPtr_ScriptSetActorAnimation ; $654d
	ld a, $03 ; $6550
	farcall FarPtr_ScriptWaitActorIdle ; $6552
	ld a, $03 ; $6555
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6557
	ld a, $00 ; $655a
	ld d, $02 ; $655c
	farcall FarPtr_ScriptSetActorAnimation ; $655e
	ld a, $00 ; $6561
	farcall FarPtr_ScriptWaitActorIdle ; $6563
	test_flag $05, 7 ; $6566
	jr nz, Label_0f_6582 ; $6569
	ld a, $05 ; $656b
	ld d, $03 ; $656d
	farcall FarPtr_ScriptSetActorAnimation ; $656f
	ld a, $05 ; $6572
	farcall FarPtr_ScriptWaitActorIdle ; $6574
	ld a, $05 ; $6577
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6579
	set_flag $15, 6 ; $657c
	jr Label_0f_65a6 ; $657f
	ret ; $6581
Label_0f_6582:
	farcall FarPtr_0a_10 ; $6582
	ld a, $04 ; $6585
	ld d, $03 ; $6587
	farcall FarPtr_ScriptSetActorAnimation ; $6589
	ld a, $04 ; $658c
	farcall FarPtr_ScriptWaitActorIdle ; $658e
	ld a, $04 ; $6591
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6593
	ld a, $05 ; $6596
	farcall FarPtr_GetActorStateAddr ; $6598
	ld c, l ; $659b
	ld b, h ; $659c
	ld de, $d000 ; $659d
	farcall FarPtr_04_20 ; $65a0
	set_flag $15, 7 ; $65a3
Label_0f_65a6:
	ld bc, $0018 ; $65a6
	farcall FarPtr_0a_38 ; $65a9
	xor a, a ; $65ac
	ld bc, $1c00 ; $65ad
	ld de, $1d00 ; $65b0
	farcall FarPtr_MovePlayerToPosition ; $65b3
	farcall FarPtr_WaitPlayerMoveDone ; $65b6
	ld a, $00 ; $65b9
	ld [$c2b0], a ; $65bb
	farcall FarPtr_03_18 ; $65be
	ret ; $65c1
	; $65c2, 77 bytes (bytes:14)
	db $00, $00, $57, $7b, $00, $1c, $00, $2c, $c0, $00, $5c, $01, $00, $00 ; 0x00
	db $00, $00, $57, $7b, $00, $1c, $00, $2f, $c0, $00, $5a, $01, $00, $00 ; 0x0e
	db $00, $00, $57, $7b, $00, $1d, $00, $31, $c0, $00, $5b, $01, $00, $00 ; 0x1c
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff, $03, $ff, $00, $00 ; 0x2a
	db $19, $24, $03, $00, $04, $ff, $00, $00, $1a, $24, $03, $00, $05, $ff ; 0x38
	db $00, $00, $1b, $24, $03, $00, $ff ; 0x46
Func_0f_660f:
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
Func_0f_6651:
	ld a, $00 ; $6651
	ld [$c2b0], a ; $6653
	test_flag $05, 7 ; $6656
	jr nz, Label_0f_66b8 ; $6659
	ld a, $f1 ; $665b
	ld d, $0e ; $665d
	ld e, $14 ; $665f
	farcall FarPtr_0a_8a ; $6661
	test_flag $07, 5 ; $6664
	jr z, Label_0f_6680 ; $6667
	ldh a, [hRomBank] ; $6669
	ld hl, $6982 ; $666b
	farcall FarPtr_0a_06 ; $666e
	ld hl, $6a50 ; $6671
	ld de, $000c ; $6674
	farcall FarPtr_0a_60 ; $6677
	ld a, $03 ; $667a
	ld [$c2b0], a ; $667c
	ret ; $667f
Label_0f_6680:
	test_flag $07, 6 ; $6680
	jr z, Label_0f_669c ; $6683
	ldh a, [hRomBank] ; $6685
	ld hl, $684b ; $6687
	farcall FarPtr_0a_06 ; $668a
	ld hl, $6919 ; $668d
	ld de, $000c ; $6690
	farcall FarPtr_0a_60 ; $6693
	ld a, $02 ; $6696
	ld [$c2b0], a ; $6698
	ret ; $669b
Label_0f_669c:
	test_flag $07, 7 ; $669c
	jr z, Label_0f_66b7 ; $669f
	ldh a, [hRomBank] ; $66a1
	ld hl, $6714 ; $66a3
	farcall FarPtr_0a_06 ; $66a6
	ld hl, $67e2 ; $66a9
	ld de, $000c ; $66ac
	farcall FarPtr_0a_60 ; $66af
	ld a, $01 ; $66b2
	ld [$c2b0], a ; $66b4
Label_0f_66b7:
	ret ; $66b7
Label_0f_66b8:
	ld a, $e1 ; $66b8
	ld d, $0e ; $66ba
	ld e, $14 ; $66bc
	farcall FarPtr_0a_8a ; $66be
	ld a, $e1 ; $66c1
	ld d, $10 ; $66c3
	ld e, $14 ; $66c5
	farcall FarPtr_0a_8a ; $66c7
	test_flag $06, 6 ; $66ca
	jr z, Label_0f_66e6 ; $66cd
	ldh a, [hRomBank] ; $66cf
	ld hl, $6daf ; $66d1
	farcall FarPtr_0a_06 ; $66d4
	ld hl, $6e6f ; $66d7
	ld de, $000c ; $66da
	farcall FarPtr_0a_60 ; $66dd
	ld a, $03 ; $66e0
	ld [$c2b0], a ; $66e2
	ret ; $66e5
Label_0f_66e6:
	test_flag $06, 7 ; $66e6
	jr z, Label_0f_6702 ; $66e9
	ldh a, [hRomBank] ; $66eb
	ld hl, $6c46 ; $66ed
	farcall FarPtr_0a_06 ; $66f0
	ld hl, $6d06 ; $66f3
	ld de, $000c ; $66f6
	farcall FarPtr_0a_60 ; $66f9
	ld a, $02 ; $66fc
	ld [$c2b0], a ; $66fe
	ret ; $6701
Label_0f_6702:
	ldh a, [hRomBank] ; $6702
	ld hl, $6ab9 ; $6704
	farcall FarPtr_0a_06 ; $6707
	ld hl, $6b79 ; $670a
	ld de, $000c ; $670d
	farcall FarPtr_0a_60 ; $6710
	ret ; $6713
	; $6714, 206 bytes (bytes:14)
	db $00, $00, $57, $7b, $00, $27, $00, $11, $80, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $57, $7b, $00, $13, $00, $0f, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $57, $7b, $00, $01, $00, $0b, $00, $00, $25, $01, $00, $00 ; 0x1c
	db $00, $00, $57, $7b, $00, $19, $00, $15, $40, $00, $5c, $01, $00, $00 ; 0x2a
	db $00, $00, $57, $7b, $00, $19, $00, $13, $40, $00, $5b, $01, $00, $00 ; 0x38
	db $00, $00, $57, $7b, $00, $11, $00, $13, $40, $00, $5a, $01, $00, $00 ; 0x46
	db $00, $00, $57, $7b, $00, $1d, $00, $11, $00, $00, $5d, $01, $00, $00 ; 0x54
	db $00, $00, $57, $7b, $00, $11, $00, $15, $40, $00, $5f, $01, $00, $00 ; 0x62
	db $00, $00, $57, $7b, $00, $29, $00, $19, $80, $00, $60, $01, $00, $00 ; 0x70
	db $00, $00, $57, $7b, $00, $17, $00, $13, $40, $00, $61, $01, $00, $00 ; 0x7e
	db $00, $00, $57, $7b, $00, $0f, $00, $13, $40, $00, $62, $01, $00, $00 ; 0x8c
	db $00, $00, $57, $7b, $00, $1d, $00, $15, $40, $00, $5e, $01, $00, $00 ; 0x9a
	db $00, $00, $57, $7b, $00, $17, $00, $15, $40, $00, $1e, $01, $00, $00 ; 0xa8
	db $00, $00, $73, $7a, $00, $29, $00, $13, $40, $00, $1f, $01, $00, $00 ; 0xb6
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xc4
	; $67e2, 105 bytes (records:8)
; 13 records x 8 bytes
	dw $ff06, $0000, $24b6, $0003 ; record 0
	dw $ff07, $0000, $24b7, $0003 ; record 1
	dw $ff08, $0000, $24b8, $0003 ; record 2
	dw $ff09, $0000, $24b9, $0003 ; record 3
	dw $ff0a, $0000, $24ba, $0003 ; record 4
	dw $ff0b, $0000, $24bb, $0003 ; record 5
	dw $ff0c, $0000, $24bc, $0003 ; record 6
	dw $ff0d, $0000, $24bd, $0003 ; record 7
	dw $ff0e, $0000, $24be, $0003 ; record 8
	dw $ff0f, $0000, $24bf, $0003 ; record 9
	dw $ff10, $0000, $24c0, $0013 ; record 10
	dw $ff03, $0000, $6f3c, $0003 ; record 11
	dw $ff04, $0000, $6f71, $0003 ; record 12
	db $ff
	; $684b, 206 bytes (bytes:14)
	db $00, $00, $57, $7b, $00, $27, $00, $11, $80, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $57, $7b, $00, $13, $00, $0f, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $57, $7b, $00, $01, $00, $0b, $00, $00, $25, $01, $00, $00 ; 0x1c
	db $00, $00, $57, $7b, $00, $17, $00, $15, $40, $00, $5c, $01, $00, $00 ; 0x2a
	db $00, $00, $75, $7b, $00, $23, $00, $17, $c0, $00, $5b, $01, $00, $00 ; 0x38
	db $00, $00, $57, $7b, $00, $1d, $00, $11, $00, $00, $5d, $01, $00, $00 ; 0x46
	db $00, $00, $57, $7b, $00, $29, $00, $17, $80, $00, $5f, $01, $00, $00 ; 0x54
	db $00, $00, $57, $7b, $00, $11, $00, $15, $40, $00, $5a, $01, $00, $00 ; 0x62
	db $00, $00, $57, $7b, $00, $29, $00, $19, $80, $00, $60, $01, $00, $00 ; 0x70
	db $00, $00, $57, $7b, $00, $19, $00, $15, $40, $00, $61, $01, $00, $00 ; 0x7e
	db $00, $00, $61, $7b, $00, $07, $00, $1f, $40, $00, $62, $01, $00, $00 ; 0x8c
	db $00, $00, $57, $7b, $00, $1d, $00, $13, $00, $00, $5e, $01, $00, $00 ; 0x9a
	db $00, $00, $57, $7b, $00, $05, $00, $21, $40, $00, $1e, $01, $00, $00 ; 0xa8
	db $00, $00, $73, $7a, $00, $29, $00, $13, $40, $00, $1f, $01, $00, $00 ; 0xb6
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xc4
	; $6919, 105 bytes (records:8)
; 13 records x 8 bytes
	dw $ff06, $0000, $2804, $0003 ; record 0
	dw $ff07, $0000, $2805, $0013 ; record 1
	dw $ff08, $0000, $2806, $0003 ; record 2
	dw $ff09, $0000, $2807, $0003 ; record 3
	dw $ff0a, $0000, $2808, $0003 ; record 4
	dw $ff0b, $0000, $2809, $0003 ; record 5
	dw $ff0c, $0000, $280a, $0003 ; record 6
	dw $ff0d, $0000, $280b, $0013 ; record 7
	dw $ff0e, $0000, $280c, $0003 ; record 8
	dw $ff0f, $0000, $280d, $0003 ; record 9
	dw $ff10, $0000, $280e, $0013 ; record 10
	dw $ff03, $0000, $6f3c, $0003 ; record 11
	dw $ff04, $0000, $6f71, $0003 ; record 12
	db $ff
	; $6982, 206 bytes (bytes:14)
	db $00, $00, $57, $7b, $00, $27, $00, $11, $80, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $57, $7b, $00, $13, $00, $0f, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $57, $7b, $00, $0e, $00, $04, $00, $00, $25, $01, $00, $00 ; 0x1c
	db $00, $00, $57, $7b, $00, $23, $00, $11, $c0, $00, $5c, $01, $00, $00 ; 0x2a
	db $00, $00, $75, $7b, $00, $23, $00, $17, $c0, $00, $5b, $01, $00, $00 ; 0x38
	db $00, $00, $57, $7b, $00, $1d, $00, $11, $00, $00, $5d, $01, $00, $00 ; 0x46
	db $00, $00, $57, $7b, $00, $29, $00, $17, $80, $00, $5f, $01, $00, $00 ; 0x54
	db $00, $00, $57, $7b, $00, $11, $00, $15, $40, $00, $61, $01, $00, $00 ; 0x62
	db $00, $00, $57, $7b, $00, $21, $00, $11, $00, $00, $5a, $01, $00, $00 ; 0x70
	db $00, $00, $57, $7b, $00, $29, $00, $19, $80, $00, $60, $01, $00, $00 ; 0x7e
	db $00, $00, $61, $7b, $00, $07, $00, $1f, $40, $00, $62, $01, $00, $00 ; 0x8c
	db $00, $00, $57, $7b, $00, $1d, $00, $13, $00, $00, $5e, $01, $00, $00 ; 0x9a
	db $00, $00, $57, $7b, $00, $05, $00, $21, $40, $00, $1e, $01, $00, $00 ; 0xa8
	db $00, $00, $73, $7a, $00, $29, $00, $13, $40, $00, $1f, $01, $00, $00 ; 0xb6
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xc4
	; $6a50, 105 bytes (records:8)
; 13 records x 8 bytes
	dw $ff06, $0000, $280f, $0003 ; record 0
	dw $ff07, $0000, $2810, $0013 ; record 1
	dw $ff08, $0000, $2811, $0003 ; record 2
	dw $ff09, $0000, $2812, $0003 ; record 3
	dw $ff0a, $0000, $2813, $0003 ; record 4
	dw $ff0b, $0000, $2814, $0003 ; record 5
	dw $ff0c, $0000, $2815, $0003 ; record 6
	dw $ff0d, $0000, $2816, $0013 ; record 7
	dw $ff0e, $0000, $2817, $0003 ; record 8
	dw $ff0f, $0000, $2818, $0003 ; record 9
	dw $ff10, $0000, $2819, $0013 ; record 10
	dw $ff03, $0000, $6f3c, $0003 ; record 11
	dw $ff04, $0000, $6f71, $0003 ; record 12
	db $ff
	; $6ab9, 192 bytes (bytes:14)
	db $00, $00, $57, $7b, $00, $27, $00, $11, $80, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $57, $7b, $00, $13, $00, $0f, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $57, $7b, $00, $01, $00, $0b, $00, $00, $25, $01, $00, $00 ; 0x1c
	db $00, $00, $57, $7b, $00, $23, $00, $11, $c0, $00, $5c, $01, $00, $00 ; 0x2a
	db $00, $00, $75, $7b, $00, $23, $00, $17, $00, $00, $5a, $01, $00, $00 ; 0x38
	db $00, $00, $57, $7b, $00, $29, $00, $17, $80, $00, $5f, $01, $00, $00 ; 0x46
	db $00, $00, $57, $7b, $00, $29, $00, $19, $80, $00, $60, $01, $00, $00 ; 0x54
	db $00, $00, $57, $7b, $00, $0f, $00, $13, $40, $00, $5d, $01, $00, $00 ; 0x62
	db $00, $00, $57, $7b, $00, $11, $00, $13, $40, $00, $5e, $01, $00, $00 ; 0x70
	db $00, $00, $57, $7b, $00, $17, $00, $13, $c0, $00, $61, $01, $00, $00 ; 0x7e
	db $00, $00, $50, $7a, $00, $19, $c0, $10, $80, $00, $62, $01, $00, $00 ; 0x8c
	db $00, $00, $57, $7b, $00, $17, $00, $15, $40, $00, $1f, $01, $00, $00 ; 0x9a
	db $00, $00, $57, $7b, $00, $19, $00, $15, $40, $00, $1e, $01, $05, $00 ; 0xa8
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xb6
	; $6b79, 97 bytes (records:8)
; 12 records x 8 bytes
	dw $ff06, $0000, $281a, $0003 ; record 0
	dw $ff07, $0000, $281b, $0013 ; record 1
	dw $ff08, $0000, $281c, $0003 ; record 2
	dw $ff09, $0000, $281d, $0003 ; record 3
	dw $ff0a, $0000, $6bda, $0003 ; record 4
	dw $ff0b, $0000, $6bfe, $0003 ; record 5
	dw $ff0c, $0000, $2824, $0003 ; record 6
	dw $ff0d, $0000, $6c22, $0013 ; record 7
	dw $ff0e, $0000, $2828, $0003 ; record 8
	dw $ff0f, $0000, $2829, $0003 ; record 9
	dw $ff03, $0000, $6f3c, $0003 ; record 10
	dw $ff04, $0000, $6f71, $0003 ; record 11
	db $ff
	ld hl, $281e ; $6bda
	farcall FarPtr_0a_0e ; $6bdd
	ld a, $0a ; $6be0
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6be2
	farcall FarPtr_0a_12 ; $6be5
	farcall FarPtr_ScriptCloseDialogueWindow ; $6be8
	push af ; $6beb
	ld a, $05 ; $6bec
	farcall FarPtr_WaitScriptFrames ; $6bee
	pop af ; $6bf1
	and a, a ; $6bf2
	jr z, Label_0f_6bf8 ; $6bf3
	farcall FarPtr_0a_10 ; $6bf5
Label_0f_6bf8:
	ld a, $0a ; $6bf8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6bfa
	ret ; $6bfd
	ld hl, $2821 ; $6bfe
	farcall FarPtr_0a_0e ; $6c01
	ld a, $0b ; $6c04
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6c06
	farcall FarPtr_0a_12 ; $6c09
	farcall FarPtr_ScriptCloseDialogueWindow ; $6c0c
	push af ; $6c0f
	ld a, $05 ; $6c10
	farcall FarPtr_WaitScriptFrames ; $6c12
	pop af ; $6c15
	and a, a ; $6c16
	jr z, Label_0f_6c1c ; $6c17
	farcall FarPtr_0a_10 ; $6c19
Label_0f_6c1c:
	ld a, $0b ; $6c1c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6c1e
	ret ; $6c21
	ld hl, $2825 ; $6c22
	farcall FarPtr_0a_0e ; $6c25
	ld a, $0d ; $6c28
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6c2a
	farcall FarPtr_0a_12 ; $6c2d
	farcall FarPtr_ScriptCloseDialogueWindow ; $6c30
	push af ; $6c33
	ld a, $05 ; $6c34
	farcall FarPtr_WaitScriptFrames ; $6c36
	pop af ; $6c39
	and a, a ; $6c3a
	jr z, Label_0f_6c40 ; $6c3b
	farcall FarPtr_0a_10 ; $6c3d
Label_0f_6c40:
	ld a, $0d ; $6c40
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6c42
	ret ; $6c45
	; $6c46, 192 bytes (bytes:14)
	db $00, $00, $57, $7b, $00, $27, $00, $11, $80, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $57, $7b, $00, $13, $00, $0f, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $57, $7b, $00, $01, $00, $0b, $00, $00, $25, $01, $00, $00 ; 0x1c
	db $00, $00, $57, $7b, $00, $17, $00, $15, $40, $00, $5c, $01, $00, $00 ; 0x2a
	db $00, $00, $57, $7b, $00, $19, $00, $15, $40, $00, $5a, $01, $00, $00 ; 0x38
	db $00, $00, $57, $7b, $00, $1d, $00, $11, $00, $00, $5d, $01, $00, $00 ; 0x46
	db $00, $00, $57, $7b, $00, $1d, $00, $15, $40, $00, $5e, $01, $00, $00 ; 0x54
	db $00, $00, $57, $7b, $00, $0f, $00, $13, $40, $00, $5f, $01, $00, $00 ; 0x62
	db $00, $00, $57, $7b, $00, $11, $00, $13, $40, $00, $60, $01, $00, $00 ; 0x70
	db $00, $00, $57, $7b, $00, $17, $00, $13, $c0, $00, $61, $01, $00, $00 ; 0x7e
	db $00, $00, $50, $7a, $00, $19, $c0, $10, $80, $00, $62, $01, $00, $00 ; 0x8c
	db $00, $00, $57, $7b, $00, $29, $00, $13, $c0, $00, $1f, $01, $00, $00 ; 0x9a
	db $00, $00, $75, $7b, $00, $25, $00, $19, $40, $00, $1e, $01, $05, $00 ; 0xa8
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xb6
	; $6d06, 97 bytes (records:8)
; 12 records x 8 bytes
	dw $ff06, $0000, $282a, $0003 ; record 0
	dw $ff07, $0000, $282b, $0003 ; record 1
	dw $ff08, $0000, $6d67, $0003 ; record 2
	dw $ff09, $0000, $282f, $0003 ; record 3
	dw $ff0a, $0000, $2830, $0003 ; record 4
	dw $ff0b, $0000, $2831, $0003 ; record 5
	dw $ff0c, $0000, $2832, $0003 ; record 6
	dw $ff0d, $0000, $6d8b, $0013 ; record 7
	dw $ff0e, $0000, $2836, $0013 ; record 8
	dw $ff0f, $0000, $2837, $0013 ; record 9
	dw $ff03, $0000, $6f3c, $0003 ; record 10
	dw $ff04, $0000, $6f71, $0003 ; record 11
	db $ff
	ld hl, $282c ; $6d67
	farcall FarPtr_0a_0e ; $6d6a
	ld a, $08 ; $6d6d
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6d6f
	farcall FarPtr_0a_12 ; $6d72
	farcall FarPtr_ScriptCloseDialogueWindow ; $6d75
	push af ; $6d78
	ld a, $05 ; $6d79
	farcall FarPtr_WaitScriptFrames ; $6d7b
	pop af ; $6d7e
	and a, a ; $6d7f
	jr z, Label_0f_6d85 ; $6d80
	farcall FarPtr_0a_10 ; $6d82
Label_0f_6d85:
	ld a, $08 ; $6d85
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6d87
	ret ; $6d8a
	ld hl, $2833 ; $6d8b
	farcall FarPtr_0a_0e ; $6d8e
	ld a, $0d ; $6d91
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6d93
	farcall FarPtr_0a_12 ; $6d96
	farcall FarPtr_ScriptCloseDialogueWindow ; $6d99
	push af ; $6d9c
	ld a, $05 ; $6d9d
	farcall FarPtr_WaitScriptFrames ; $6d9f
	pop af ; $6da2
	and a, a ; $6da3
	jr z, Label_0f_6da9 ; $6da4
	farcall FarPtr_0a_10 ; $6da6
Label_0f_6da9:
	ld a, $0d ; $6da9
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6dab
	ret ; $6dae
	; $6daf, 192 bytes (bytes:14)
	db $00, $00, $57, $7b, $00, $27, $00, $11, $80, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $57, $7b, $00, $13, $00, $0f, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $57, $7b, $00, $0e, $00, $04, $00, $00, $25, $01, $00, $00 ; 0x1c
	db $00, $00, $57, $7b, $00, $23, $00, $11, $40, $00, $5c, $01, $00, $00 ; 0x2a
	db $00, $00, $57, $7b, $00, $23, $00, $13, $c0, $00, $5a, $01, $00, $00 ; 0x38
	db $00, $00, $57, $7b, $00, $29, $00, $17, $80, $00, $5f, $01, $00, $00 ; 0x46
	db $00, $00, $57, $7b, $00, $29, $00, $19, $80, $00, $60, $01, $00, $00 ; 0x54
	db $00, $00, $57, $7b, $00, $0f, $00, $13, $40, $00, $61, $01, $00, $00 ; 0x62
	db $00, $00, $57, $7b, $00, $11, $00, $13, $40, $00, $62, $01, $00, $00 ; 0x70
	db $00, $00, $57, $7b, $00, $1d, $00, $11, $00, $00, $5d, $01, $00, $00 ; 0x7e
	db $00, $00, $57, $7b, $00, $1d, $00, $15, $40, $00, $5e, $01, $00, $00 ; 0x8c
	db $00, $00, $57, $7b, $00, $29, $00, $15, $40, $00, $1f, $01, $00, $00 ; 0x9a
	db $00, $00, $75, $7b, $00, $24, $00, $18, $40, $00, $1e, $01, $05, $00 ; 0xa8
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xb6
	; $6e6f, 97 bytes (records:8)
; 12 records x 8 bytes
	dw $ff06, $0000, $2838, $0003 ; record 0
	dw $ff07, $0000, $2839, $0003 ; record 1
	dw $ff08, $0000, $283a, $0003 ; record 2
	dw $ff09, $0000, $283b, $0003 ; record 3
	dw $ff0a, $0000, $283c, $0003 ; record 4
	dw $ff0b, $0000, $6ef4, $0003 ; record 5
	dw $ff0c, $0000, $6ed0, $0003 ; record 6
	dw $ff0d, $0000, $2843, $0003 ; record 7
	dw $ff0e, $0000, $2844, $0013 ; record 8
	dw $ff0f, $0000, $2845, $0013 ; record 9
	dw $ff03, $0000, $6f3c, $0003 ; record 10
	dw $ff04, $0000, $6f71, $0003 ; record 11
	db $ff
	ld hl, $2840 ; $6ed0
	farcall FarPtr_0a_0e ; $6ed3
	ld a, $0c ; $6ed6
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6ed8
	farcall FarPtr_0a_12 ; $6edb
	farcall FarPtr_ScriptCloseDialogueWindow ; $6ede
	push af ; $6ee1
	ld a, $05 ; $6ee2
	farcall FarPtr_WaitScriptFrames ; $6ee4
	pop af ; $6ee7
	and a, a ; $6ee8
	jr z, Label_0f_6eee ; $6ee9
	farcall FarPtr_0a_10 ; $6eeb
Label_0f_6eee:
	ld a, $0c ; $6eee
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6ef0
	ret ; $6ef3
	ld hl, $283d ; $6ef4
	farcall FarPtr_0a_0e ; $6ef7
	ld a, $0b ; $6efa
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6efc
	farcall FarPtr_0a_12 ; $6eff
	farcall FarPtr_ScriptCloseDialogueWindow ; $6f02
	push af ; $6f05
	ld a, $05 ; $6f06
	farcall FarPtr_WaitScriptFrames ; $6f08
	pop af ; $6f0b
	and a, a ; $6f0c
	jr z, Label_0f_6f12 ; $6f0d
	farcall FarPtr_0a_10 ; $6f0f
Label_0f_6f12:
	ld a, $0b ; $6f12
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6f14
	ret ; $6f17
	ld hl, $24a3 ; $6f18
	farcall FarPtr_0a_0e ; $6f1b
	ld a, $0b ; $6f1e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6f20
	farcall FarPtr_0a_12 ; $6f23
	farcall FarPtr_ScriptCloseDialogueWindow ; $6f26
	push af ; $6f29
	ld a, $05 ; $6f2a
	farcall FarPtr_WaitScriptFrames ; $6f2c
	pop af ; $6f2f
	and a, a ; $6f30
	jr z, Label_0f_6f36 ; $6f31
	farcall FarPtr_0a_10 ; $6f33
Label_0f_6f36:
	ld a, $0b ; $6f36
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6f38
	ret ; $6f3b
	ld hl, $24ac ; $6f3c
	farcall FarPtr_0a_0e ; $6f3f
	ld a, $03 ; $6f42
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6f44
	farcall FarPtr_0a_12 ; $6f47
	farcall FarPtr_ScriptCloseDialogueWindow ; $6f4a
	push af ; $6f4d
	ld a, $05 ; $6f4e
	farcall FarPtr_WaitScriptFrames ; $6f50
	pop af ; $6f53
	and a, a ; $6f54
	jr nz, Label_0f_6f5d ; $6f55
	ld a, $03 ; $6f57
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6f59
	ret ; $6f5c
Label_0f_6f5d:
	ld hl, $24ae ; $6f5d
	ld a, [$c2b0] ; $6f60
	add a, l ; $6f63
	ld l, a ; $6f64
	jr nc, Label_0f_6f68 ; $6f65
	inc h ; $6f67
Label_0f_6f68:
	farcall FarPtr_0a_0e ; $6f68
	ld a, $03 ; $6f6b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6f6d
	ret ; $6f70
	ld hl, $24b2 ; $6f71
	ld a, [$c2b0] ; $6f74
	add a, l ; $6f77
	ld l, a ; $6f78
	jr nc, Label_0f_6f7c ; $6f79
	inc h ; $6f7b
Label_0f_6f7c:
	farcall FarPtr_0a_0e ; $6f7c
	ld a, $04 ; $6f7f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6f81
	ret ; $6f84
Func_0f_6f85:
	test_flag $05, 7 ; $6f85
	jr z, Label_0f_6fc2 ; $6f88
	test_flag $06, 6 ; $6f8a
	jr nz, Label_0f_6fc2 ; $6f8d
	ld a, $0d ; $6f8f
	farcall FarPtr_0a_1c ; $6f91
	ld a, $0d ; $6f94
	ld bc, $1900 ; $6f96
	ld de, $1100 ; $6f99
	farcall FarPtr_ScriptSetActorMoveTarget ; $6f9c
	ld a, $0d ; $6f9f
	farcall FarPtr_ScriptWaitActorMoveDone ; $6fa1
	ld a, $0d ; $6fa4
	ld bc, $1900 ; $6fa6
	ld de, $1300 ; $6fa9
	farcall FarPtr_ScriptSetActorMoveTarget ; $6fac
	ld a, $0d ; $6faf
	farcall FarPtr_ScriptWaitActorMoveDone ; $6fb1
	ld a, $0c ; $6fb4
	ld b, $40 ; $6fb6
	farcall FarPtr_SetActorFacing ; $6fb8
	ld a, $0d ; $6fbb
	ld b, $40 ; $6fbd
	farcall FarPtr_SetActorFacing ; $6fbf
Label_0f_6fc2:
	ret ; $6fc2
Func_0f_6fc3:
	ld hl, $285e ; $6fc3
	farcall FarPtr_0a_0e ; $6fc6
	xor a, a ; $6fc9
	ld bc, $1100 ; $6fca
	ld de, $0f00 ; $6fcd
	farcall FarPtr_MovePlayerToPosition ; $6fd0
	farcall FarPtr_WaitPlayerMoveDone ; $6fd3
	ld a, $05 ; $6fd6
	ld bc, $0e00 ; $6fd8
	ld de, $0c00 ; $6fdb
	farcall FarPtr_ScriptSetActorMoveTarget ; $6fde
	ld a, $05 ; $6fe1
	farcall FarPtr_ScriptWaitActorMoveDone ; $6fe3
	ld a, $05 ; $6fe6
	ld bc, $1300 ; $6fe8
	ld de, $0c00 ; $6feb
	farcall FarPtr_ScriptSetActorMoveTarget ; $6fee
	ld a, $05 ; $6ff1
	farcall FarPtr_ScriptWaitActorMoveDone ; $6ff3
	ld a, $05 ; $6ff6
	ld b, $40 ; $6ff8
	farcall FarPtr_SetActorFacing ; $6ffa
	ld a, $05 ; $6ffd
	ld d, $02 ; $6fff
	farcall FarPtr_ScriptSetActorAnimation ; $7001
	ld a, $05 ; $7004
	farcall FarPtr_ScriptWaitActorIdle ; $7006
	call Func_0f_744d ; $7009
	ld a, $05 ; $700c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $700e
	call Func_0f_6f85 ; $7011
	ld a, $04 ; $7014
	ld b, $c0 ; $7016
	farcall FarPtr_SetActorFacing ; $7018
	ld a, $04 ; $701b
	ld d, $03 ; $701d
	farcall FarPtr_ScriptSetActorAnimation ; $701f
	ld a, $04 ; $7022
	farcall FarPtr_ScriptWaitActorIdle ; $7024
	ld a, $04 ; $7027
	ld b, $40 ; $7029
	farcall FarPtr_SetActorFacing ; $702b
	ld a, $04 ; $702e
	ld bc, $1300 ; $7030
	ld de, $1700 ; $7033
	farcall FarPtr_ScriptSetActorMoveTarget ; $7036
	ld a, $05 ; $7039
	ld bc, $1300 ; $703b
	ld de, $1700 ; $703e
	farcall FarPtr_ScriptSetActorMoveTarget ; $7041
	xor a, a ; $7044
	ld bc, $1100 ; $7045
	ld de, $1300 ; $7048
	farcall FarPtr_MovePlayerToPosition ; $704b
	ld a, $04 ; $704e
	farcall FarPtr_ScriptWaitActorMoveDone ; $7050
	ld a, $04 ; $7053
	ld bc, $1500 ; $7055
	ld de, $1700 ; $7058
	farcall FarPtr_ScriptSetActorMoveTarget ; $705b
	ld a, $04 ; $705e
	farcall FarPtr_ScriptWaitActorMoveDone ; $7060
	ld a, $04 ; $7063
	ld b, $c0 ; $7065
	farcall FarPtr_SetActorFacing ; $7067
	ld a, $05 ; $706a
	farcall FarPtr_ScriptWaitActorMoveDone ; $706c
	ld a, $05 ; $706f
	ld b, $c0 ; $7071
	farcall FarPtr_SetActorFacing ; $7073
	call Func_0f_744d ; $7076
	ld a, $04 ; $7079
	farcall FarPtr_ScriptShowSpeakerDialogue ; $707b
	ld a, $05 ; $707e
	ld b, a ; $7080
	ld a, $04 ; $7081
	farcall FarPtr_FaceActorsTowardEachOther ; $7083
	ld a, $04 ; $7086
	ld d, $03 ; $7088
	farcall FarPtr_ScriptSetActorAnimation ; $708a
	ld a, $04 ; $708d
	farcall FarPtr_ScriptWaitActorIdle ; $708f
	ld a, $05 ; $7092
	ld bc, $1000 ; $7094
	ld de, $1700 ; $7097
	farcall FarPtr_ScriptSetActorMoveTarget ; $709a
	ld a, [$c2b0] ; $709d
	cp a, $03 ; $70a0
	jr z, Label_0f_70bb ; $70a2
	ld a, $04 ; $70a4
	ld bc, $1800 ; $70a6
	ld de, $1700 ; $70a9
	farcall FarPtr_ScriptSetActorMoveTarget ; $70ac
	ld a, $04 ; $70af
	farcall FarPtr_ScriptWaitActorMoveDone ; $70b1
	ld a, $04 ; $70b4
	ld b, $c0 ; $70b6
	farcall FarPtr_SetActorFacing ; $70b8
Label_0f_70bb:
	ld a, $05 ; $70bb
	farcall FarPtr_ScriptWaitActorMoveDone ; $70bd
	ld a, $05 ; $70c0
	ld b, $c0 ; $70c2
	farcall FarPtr_SetActorFacing ; $70c4
	ld a, $04 ; $70c7
	farcall FarPtr_ScriptShowSpeakerDialogue ; $70c9
	test_flag $05, 7 ; $70cc
	jp nz, Label_0f_722f ; $70cf
	ld a, $00 ; $70d2
	ld bc, $0020 ; $70d4
	farcall FarPtr_0a_18 ; $70d7
	ld a, $0a ; $70da
	ld b, a ; $70dc
	ld a, $00 ; $70dd
	farcall FarPtr_FaceActorsTowardEachOther ; $70df
	push af ; $70e2
	ld a, $1e ; $70e3
	farcall FarPtr_WaitScriptFrames ; $70e5
	pop af ; $70e8
	ld a, $00 ; $70e9
	ld b, $40 ; $70eb
	farcall FarPtr_SetActorFacing ; $70ed
	ld a, $0a ; $70f0
	ld b, $40 ; $70f2
	farcall FarPtr_SetActorFacing ; $70f4
	ld a, $0a ; $70f7
	ld d, $03 ; $70f9
	farcall FarPtr_ScriptSetActorAnimation ; $70fb
	ld a, $00 ; $70fe
	ld d, $03 ; $7100
	farcall FarPtr_ScriptSetActorAnimation ; $7102
	ld a, $00 ; $7105
	farcall FarPtr_ScriptWaitActorIdle ; $7107
	test_flag $07, 5 ; $710a
	jr z, Label_0f_716c ; $710d
	ld a, $05 ; $710f
	ld bc, $1300 ; $7111
	ld de, $1700 ; $7114
	farcall FarPtr_ScriptSetActorMoveTarget ; $7117
	ld a, $05 ; $711a
	farcall FarPtr_ScriptWaitActorMoveDone ; $711c
	ldh a, [hRomBank] ; $711f
	ld b, a ; $7121
	ld a, $05 ; $7122
	ld de, $73e4 ; $7124
	farcall FarPtr_0a_1a ; $7127
	push af ; $712a
	ld a, $14 ; $712b
	farcall FarPtr_WaitScriptFrames ; $712d
	pop af ; $7130
	ldh a, [hRomBank] ; $7131
	ld b, a ; $7133
	ld a, $0a ; $7134
	ld de, $73e4 ; $7136
	farcall FarPtr_0a_1a ; $7139
	push af ; $713c
	ld a, $14 ; $713d
	farcall FarPtr_WaitScriptFrames ; $713f
	pop af ; $7142
	ldh a, [hRomBank] ; $7143
	ld b, a ; $7145
	ld a, $00 ; $7146
	ld de, $73e4 ; $7148
	farcall FarPtr_0a_1a ; $714b
	push af ; $714e
	ld a, $14 ; $714f
	farcall FarPtr_WaitScriptFrames ; $7151
	pop af ; $7154
	xor a, a ; $7155
	ld bc, $1100 ; $7156
	ld de, $0d00 ; $7159
	farcall FarPtr_MovePlayerToPosition ; $715c
	farcall FarPtr_WaitPlayerMoveDone ; $715f
	push af ; $7162
	ld a, $1e ; $7163
	farcall FarPtr_WaitScriptFrames ; $7165
	pop af ; $7168
	jp Label_0f_71bf ; $7169
Label_0f_716c:
	ld a, $05 ; $716c
	ld bc, $1300 ; $716e
	ld de, $1700 ; $7171
	farcall FarPtr_ScriptSetActorMoveTarget ; $7174
	ld a, $05 ; $7177
	farcall FarPtr_ScriptWaitActorMoveDone ; $7179
	ldh a, [hRomBank] ; $717c
	ld b, a ; $717e
	ld a, $05 ; $717f
	ld de, $73be ; $7181
	farcall FarPtr_0a_1a ; $7184
	push af ; $7187
	ld a, $14 ; $7188
	farcall FarPtr_WaitScriptFrames ; $718a
	pop af ; $718d
	ldh a, [hRomBank] ; $718e
	ld b, a ; $7190
	ld a, $0a ; $7191
	ld de, $73be ; $7193
	farcall FarPtr_0a_1a ; $7196
	push af ; $7199
	ld a, $14 ; $719a
	farcall FarPtr_WaitScriptFrames ; $719c
	pop af ; $719f
	ldh a, [hRomBank] ; $71a0
	ld b, a ; $71a2
	ld a, $00 ; $71a3
	ld de, $73be ; $71a5
	farcall FarPtr_0a_1a ; $71a8
	xor a, a ; $71ab
	ld bc, $1100 ; $71ac
	ld de, $0d00 ; $71af
	farcall FarPtr_MovePlayerToPosition ; $71b2
	farcall FarPtr_WaitPlayerMoveDone ; $71b5
	push af ; $71b8
	ld a, $3c ; $71b9
	farcall FarPtr_WaitScriptFrames ; $71bb
	pop af ; $71be
Label_0f_71bf:
	ld c, $10 ; $71bf
	call BeginFadeOut ; $71c1
	call WaitFadeEnd ; $71c4
	call Func_0f_7434 ; $71c7
	ld a, $19 ; $71ca
	ld [wStoryModeCurrentLocation], a ; $71cc
	ld a, $0a ; $71cf
	ld [$c295], a ; $71d1
	ld a, $ff ; $71d4
	ld [$c294], a ; $71d6
	ld [$c2a1], a ; $71d9
	farcall FarPtr_InitStoryMatchSettings ; $71dc
	test_flag $07, 5 ; $71df
	jr z, Label_0f_71f3 ; $71e2
	ld a, $00 ; $71e4
	ld [wCurrentMinigameStoryMatch], a ; $71e6
	ld a, $13 ; $71e9
	ld [$c8f7], a ; $71eb
	farcall FarPtr_LoadMatchSettingsFromTable ; $71ee
	jr Label_0f_7228 ; $71f1
Label_0f_71f3:
	test_flag $07, 6 ; $71f3
	jr z, Label_0f_7207 ; $71f6
	ld a, $00 ; $71f8
	ld [wCurrentMinigameStoryMatch], a ; $71fa
	ld a, $12 ; $71fd
	ld [$c8f7], a ; $71ff
	farcall FarPtr_LoadMatchSettingsFromTable ; $7202
	jr Label_0f_7228 ; $7205
Label_0f_7207:
	test_flag $07, 7 ; $7207
	jr z, Label_0f_721b ; $720a
	ld a, $00 ; $720c
	ld [wCurrentMinigameStoryMatch], a ; $720e
	ld a, $11 ; $7211
	ld [$c8f7], a ; $7213
	farcall FarPtr_LoadMatchSettingsFromTable ; $7216
	jr Label_0f_7228 ; $7219
Label_0f_721b:
	ld a, $00 ; $721b
	ld [wCurrentMinigameStoryMatch], a ; $721d
	ld a, $10 ; $7220
	ld [$c8f7], a ; $7222
	farcall FarPtr_LoadMatchSettingsFromTable ; $7225
Label_0f_7228:
	farcall FarPtr_0a_4c ; $7228
	farcall FarPtr_0a_4e ; $722b
	ret ; $722e
Label_0f_722f:
	ld a, $02 ; $722f
	ld b, a ; $7231
	ld a, $00 ; $7232
	farcall FarPtr_FaceActorsTowardEachOther ; $7234
	ld a, $00 ; $7237
	ld bc, $0020 ; $7239
	farcall FarPtr_0a_18 ; $723c
	ld a, $02 ; $723f
	ld bc, $0020 ; $7241
	farcall FarPtr_0a_18 ; $7244
	push af ; $7247
	ld a, $14 ; $7248
	farcall FarPtr_WaitScriptFrames ; $724a
	pop af ; $724d
	ld a, $02 ; $724e
	ld d, $03 ; $7250
	farcall FarPtr_ScriptSetActorAnimation ; $7252
	ld a, $00 ; $7255
	ld d, $03 ; $7257
	farcall FarPtr_ScriptSetActorAnimation ; $7259
	ld a, $00 ; $725c
	farcall FarPtr_ScriptWaitActorIdle ; $725e
	ld a, $00 ; $7261
	ld b, $40 ; $7263
	farcall FarPtr_SetActorFacing ; $7265
	ld a, $02 ; $7268
	ld b, $40 ; $726a
	farcall FarPtr_SetActorFacing ; $726c
	test_flag $06, 6 ; $726f
	jp z, Label_0f_72e8 ; $7272
	ld a, $05 ; $7275
	ld bc, $1300 ; $7277
	ld de, $1700 ; $727a
	farcall FarPtr_ScriptSetActorMoveTarget ; $727d
	ld a, $05 ; $7280
	farcall FarPtr_ScriptWaitActorMoveDone ; $7282
	ldh a, [hRomBank] ; $7285
	ld b, a ; $7287
	ld a, $05 ; $7288
	ld de, $73e4 ; $728a
	farcall FarPtr_0a_1a ; $728d
	push af ; $7290
	ld a, $14 ; $7291
	farcall FarPtr_WaitScriptFrames ; $7293
	pop af ; $7296
	ldh a, [hRomBank] ; $7297
	ld b, a ; $7299
	ld a, $00 ; $729a
	ld de, $73e4 ; $729c
	farcall FarPtr_0a_1a ; $729f
	push af ; $72a2
	ld a, $14 ; $72a3
	farcall FarPtr_WaitScriptFrames ; $72a5
	pop af ; $72a8
	ldh a, [hRomBank] ; $72a9
	ld b, a ; $72ab
	ld a, $02 ; $72ac
	ld de, $73e4 ; $72ae
	farcall FarPtr_0a_1a ; $72b1
	push af ; $72b4
	ld a, $3c ; $72b5
	farcall FarPtr_WaitScriptFrames ; $72b7
	pop af ; $72ba
	ldh a, [hRomBank] ; $72bb
	ld b, a ; $72bd
	ld a, $0b ; $72be
	ld de, $73fd ; $72c0
	farcall FarPtr_0a_1a ; $72c3
	push af ; $72c6
	ld a, $14 ; $72c7
	farcall FarPtr_WaitScriptFrames ; $72c9
	pop af ; $72cc
	ldh a, [hRomBank] ; $72cd
	ld b, a ; $72cf
	ld a, $0a ; $72d0
	ld de, $73fd ; $72d2
	farcall FarPtr_0a_1a ; $72d5
	xor a, a ; $72d8
	ld bc, $1100 ; $72d9
	ld de, $0d00 ; $72dc
	farcall FarPtr_MovePlayerToPosition ; $72df
	farcall FarPtr_WaitPlayerMoveDone ; $72e2
	jp Label_0f_735f ; $72e5
Label_0f_72e8:
	ld a, $05 ; $72e8
	ld bc, $1300 ; $72ea
	ld de, $1700 ; $72ed
	farcall FarPtr_ScriptSetActorMoveTarget ; $72f0
	ld a, $05 ; $72f3
	farcall FarPtr_ScriptWaitActorMoveDone ; $72f5
	ldh a, [hRomBank] ; $72f8
	ld b, a ; $72fa
	ld a, $05 ; $72fb
	ld de, $73be ; $72fd
	farcall FarPtr_0a_1a ; $7300
	push af ; $7303
	ld a, $14 ; $7304
	farcall FarPtr_WaitScriptFrames ; $7306
	pop af ; $7309
	ldh a, [hRomBank] ; $730a
	ld b, a ; $730c
	ld a, $00 ; $730d
	ld de, $73be ; $730f
	farcall FarPtr_0a_1a ; $7312
	push af ; $7315
	ld a, $14 ; $7316
	farcall FarPtr_WaitScriptFrames ; $7318
	pop af ; $731b
	ldh a, [hRomBank] ; $731c
	ld b, a ; $731e
	ld a, $02 ; $731f
	ld de, $73be ; $7321
	farcall FarPtr_0a_1a ; $7324
	push af ; $7327
	ld a, $3c ; $7328
	farcall FarPtr_WaitScriptFrames ; $732a
	pop af ; $732d
	ldh a, [hRomBank] ; $732e
	ld b, a ; $7330
	ld a, $0b ; $7331
	ld de, $73d1 ; $7333
	farcall FarPtr_0a_1a ; $7336
	push af ; $7339
	ld a, $14 ; $733a
	farcall FarPtr_WaitScriptFrames ; $733c
	pop af ; $733f
	ldh a, [hRomBank] ; $7340
	ld b, a ; $7342
	ld a, $0a ; $7343
	ld de, $73d1 ; $7345
	farcall FarPtr_0a_1a ; $7348
	xor a, a ; $734b
	ld bc, $1100 ; $734c
	ld de, $0d00 ; $734f
	farcall FarPtr_MovePlayerToPosition ; $7352
	farcall FarPtr_WaitPlayerMoveDone ; $7355
	push af ; $7358
	ld a, $3c ; $7359
	farcall FarPtr_WaitScriptFrames ; $735b
	pop af ; $735e
Label_0f_735f:
	ld c, $10 ; $735f
	call BeginFadeOut ; $7361
	call WaitFadeEnd ; $7364
	call Func_0f_7434 ; $7367
	ld a, $19 ; $736a
	ld [wStoryModeCurrentLocation], a ; $736c
	ld a, $0b ; $736f
	ld [$c295], a ; $7371
	ld a, $ff ; $7374
	ld [$c294], a ; $7376
	ld [$c2a1], a ; $7379
	farcall FarPtr_InitStoryMatchSettings ; $737c
	test_flag $06, 6 ; $737f
	jp z, Label_0f_7394 ; $7382
	ld a, $01 ; $7385
	ld [wCurrentMinigameStoryMatch], a ; $7387
	ld a, $13 ; $738a
	ld [$c8f7], a ; $738c
	farcall FarPtr_LoadMatchSettingsFromTable ; $738f
	jr Label_0f_73b7 ; $7392
Label_0f_7394:
	test_flag $06, 7 ; $7394
	jp z, Label_0f_73aa ; $7397
	ld a, $01 ; $739a
	ld [wCurrentMinigameStoryMatch], a ; $739c
	ld a, $12 ; $739f
	ld [$c8f7], a ; $73a1
	farcall FarPtr_LoadMatchSettingsFromTable ; $73a4
	jp Label_0f_73b7 ; $73a7
Label_0f_73aa:
	ld a, $01 ; $73aa
	ld [wCurrentMinigameStoryMatch], a ; $73ac
	ld a, $11 ; $73af
	ld [$c8f7], a ; $73b1
	farcall FarPtr_LoadMatchSettingsFromTable ; $73b4
Label_0f_73b7:
	farcall FarPtr_0a_4c ; $73b7
	farcall FarPtr_0a_4e ; $73ba
	ret ; $73bd
	INCBIN "data/bank_00f/d_73be.bin" ; $73be, 88 bytes
Func_0f_7416:
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
	call Func_0f_7416 ; $7446
	farcall FarPtr_1b_1a ; $7449
	ret ; $744c
Func_0f_744d:
	ld a, [$c2b0] ; $744d
	ld hl, $2861 ; $7450
	add a, l ; $7453
	ld l, a ; $7454
	jr nc, Label_0f_7458 ; $7455
	inc h ; $7457
Label_0f_7458:
	call QueueShortText ; $7458
	ret ; $745b
Func_0f_745c:
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
	ld [$c295], a ; $7476
	ld a, $ff ; $7479
	ld [$c294], a ; $747b
	ld [$c2a1], a ; $747e
	ld a, $01 ; $7481
	ret ; $7483
Label_0f_7484:
	ld a, $00 ; $7484
	ret ; $7486
Func_0f_7487:
	wram_bank $04 ; $7487
	ld a, [$c4c7] ; $748d
	cp a, $01 ; $7490
	jr z, Label_0f_749c ; $7492
	ld a, [wMatchWinLoseFlag] ; $7494
	cp a, $01 ; $7497
	jp z, Label_0f_74a3 ; $7499
Label_0f_749c:
	call Func_0f_6651 ; $749c
	call Func_0f_7b20 ; $749f
	ret ; $74a2
Label_0f_74a3:
	clear_flag $0e, 6 ; $74a3
	clear_flag $0f, 0 ; $74a6
	call Func_0f_745c ; $74a9
	and a, a ; $74ac
	jr z, Label_0f_74b0 ; $74ad
	ret ; $74af
Label_0f_74b0:
	ldh a, [hRomBank] ; $74b0
	ld hl, $75b7 ; $74b2
	farcall FarPtr_0a_06 ; $74b5
	ld hl, $7615 ; $74b8
	ld de, $000c ; $74bb
	farcall FarPtr_0a_60 ; $74be
	call Func_0f_660f ; $74c1
	farcall FarPtr_0a_00 ; $74c4
	call Func_0f_7b20 ; $74c7
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
	farcall FarPtr_0a_0e ; $74ef
	ld a, $08 ; $74f2
	ld bc, $2200 ; $74f4
	ld de, $0f80 ; $74f7
	farcall FarPtr_ScriptSetActorPosition ; $74fa
	sound $97 ; $74fd
	push af ; $74ff
	ld a, $2d ; $7500
	farcall FarPtr_WaitScriptFrames ; $7502
	pop af ; $7505
	ld a, $03 ; $7506
	ld d, $02 ; $7508
	farcall FarPtr_ScriptSetActorAnimation ; $750a
	ld a, $03 ; $750d
	farcall FarPtr_ScriptWaitActorIdle ; $750f
	ld a, $03 ; $7512
	ld b, a ; $7514
	ld a, $00 ; $7515
	farcall FarPtr_FaceActorTowardActor ; $7517
	ld a, $08 ; $751a
	ld bc, $3f00 ; $751c
	ld de, $3f00 ; $751f
	farcall FarPtr_ScriptSetActorPosition ; $7522
	ld a, $03 ; $7525
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7527
	ld a, $05 ; $752a
	ld d, $02 ; $752c
	farcall FarPtr_ScriptSetActorAnimation ; $752e
	ld a, $05 ; $7531
	farcall FarPtr_ScriptWaitActorIdle ; $7533
	ld a, $05 ; $7536
	ld b, a ; $7538
	ld a, $00 ; $7539
	farcall FarPtr_FaceActorTowardActor ; $753b
	ld a, $05 ; $753e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7540
	ld a, $04 ; $7543
	ld d, $03 ; $7545
	farcall FarPtr_ScriptSetActorAnimation ; $7547
	ld a, $04 ; $754a
	farcall FarPtr_ScriptWaitActorIdle ; $754c
	ld a, $04 ; $754f
	ld b, a ; $7551
	ld a, $00 ; $7552
	farcall FarPtr_FaceActorTowardActor ; $7554
	ld a, $04 ; $7557
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7559
	call Func_0f_7911 ; $755c
	ld hl, $2849 ; $755f
	farcall FarPtr_0a_0e ; $7562
	ld a, [$c2b0] ; $7565
	dec a ; $7568
	ld hl, $2862 ; $7569
	add a, l ; $756c
	ld l, a ; $756d
	jr nc, Label_0f_7571 ; $756e
	inc h ; $7570
Label_0f_7571:
	call QueueShortText ; $7571
	ld a, $04 ; $7574
	ld b, $c0 ; $7576
	farcall FarPtr_SetActorFacing ; $7578
	ld a, $03 ; $757b
	ld b, $00 ; $757d
	farcall FarPtr_SetActorFacing ; $757f
	ld a, $04 ; $7582
	ld b, a ; $7584
	ld a, $00 ; $7585
	farcall FarPtr_FaceActorTowardActor ; $7587
	ld a, $04 ; $758a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $758c
	ld a, $04 ; $758f
	ld b, $00 ; $7591
	ld de, $0200 ; $7593
	farcall FarPtr_MoveActorByAngle ; $7596
	ld a, $04 ; $7599
	farcall FarPtr_ScriptWaitActorMoveDone ; $759b
	push af ; $759e
	ld a, $0a ; $759f
	farcall FarPtr_WaitScriptFrames ; $75a1
	pop af ; $75a4
	push af ; $75a5
	ld a, $0a ; $75a6
	farcall FarPtr_WaitScriptFrames ; $75a8
	pop af ; $75ab
	ld a, $04 ; $75ac
	ld b, $80 ; $75ae
	farcall FarPtr_SetActorFacing ; $75b0
	set_flag $17, 1 ; $75b3
	ret ; $75b6
	; $75b7, 94 bytes (bytes:14)
	db $00, $00, $57, $7b, $00, $23, $00, $11, $00, $00, $5c, $01, $00, $00 ; 0x00
	db $00, $00, $57, $7b, $00, $25, $00, $13, $c0, $00, $5a, $01, $00, $00 ; 0x0e
	db $00, $00, $57, $7b, $00, $27, $00, $11, $80, $00, $5b, $01, $00, $00 ; 0x1c
	db $00, $00, $57, $7b, $00, $01, $00, $31, $c0, $00, $25, $01, $00, $00 ; 0x2a
	db $00, $00, $57, $7b, $00, $01, $00, $31, $c0, $00, $25, $01, $00, $00 ; 0x38
	db $00, $00, $57, $7b, $00, $01, $00, $31, $c0, $00, $4c, $01, $00, $00 ; 0x46
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x54
	; $7615, 25 bytes (records:8)
; 3 records x 8 bytes
	dw $ff03, $0000, $7649, $0003 ; record 0
	dw $ff04, $0000, $762e, $0003 ; record 1
	dw $ff05, $0000, $766c, $0003 ; record 2
	db $ff
	ld hl, $2849 ; $762e
	farcall FarPtr_0a_0e ; $7631
	ld a, [$c2b0] ; $7634
	dec a ; $7637
	ld hl, $2862 ; $7638
	add a, l ; $763b
	ld l, a ; $763c
	jr nc, Label_0f_7640 ; $763d
	inc h ; $763f
Label_0f_7640:
	call QueueShortText ; $7640
	ld a, $04 ; $7643
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7645
	ret ; $7648
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
	farcall FarPtr_0a_0e ; $7657
	ld a, $03 ; $765a
	ld d, $03 ; $765c
	farcall FarPtr_ScriptSetActorAnimation ; $765e
	ld a, $03 ; $7661
	farcall FarPtr_ScriptWaitActorIdle ; $7663
	ld a, $03 ; $7666
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7668
	ret ; $766b
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
	farcall FarPtr_0a_0e ; $767b
	ld a, $05 ; $767e
	ld de, $ff80 ; $7680
	farcall FarPtr_0a_42 ; $7683
	ld a, $05 ; $7686
	farcall FarPtr_0a_44 ; $7688
	ld a, $05 ; $768b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $768d
	ret ; $7690
	db $47 ; $7691
	; $7692, 18 bytes (records:2)
; 9 records x 2 bytes
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
	ld a, [$c4c7] ; $76a9
	cp a, $01 ; $76ac
	jr z, Label_0f_76b8 ; $76ae
	ld a, [wMatchWinLoseFlag] ; $76b0
	cp a, $01 ; $76b3
	jp z, $76e9 ; $76b5
Label_0f_76b8:
	call Func_0f_6651 ; $76b8
	call Func_0f_7b20 ; $76bb
	ld a, $00 ; $76be
	ld bc, $2500 ; $76c0
	ld de, $1100 ; $76c3
	farcall FarPtr_ScriptSetActorPosition ; $76c6
	xor a, a ; $76c9
	ld bc, $2500 ; $76ca
	ld de, $1100 ; $76cd
	farcall FarPtr_MovePlayerToPosition ; $76d0
	ld a, $02 ; $76d3
	ld bc, $2500 ; $76d5
	ld de, $1300 ; $76d8
	farcall FarPtr_ScriptSetActorPosition ; $76db
	ld a, $02 ; $76de
	ld b, $c0 ; $76e0
	farcall FarPtr_SetActorFacing ; $76e2
	farcall FarPtr_WaitPlayerMoveDone ; $76e5
	ret ; $76e8
	db $ef ; $76e9
	ldh [$ff0e], a ; $76ea
	clear_flag $0f, 1 ; $76ec
	call Func_0f_745c ; $76ef
	and a, a ; $76f2
	jr z, Label_0f_76f6 ; $76f3
	ret ; $76f5
Label_0f_76f6:
	ldh a, [hRomBank] ; $76f6
	ld hl, $7842 ; $76f8
	farcall FarPtr_0a_06 ; $76fb
	farcall FarPtr_0a_00 ; $76fe
	ld hl, $78a0 ; $7701
	ld de, $000c ; $7704
	farcall FarPtr_0a_60 ; $7707
	call Func_0f_7b20 ; $770a
	ld a, $02 ; $770d
	farcall FarPtr_0a_1c ; $770f
	ld a, $02 ; $7712
	ld bc, $2500 ; $7714
	ld de, $1100 ; $7717
	farcall FarPtr_ScriptSetActorPosition ; $771a
	ld a, $02 ; $771d
	ld b, $c0 ; $771f
	farcall FarPtr_SetActorFacing ; $7721
	ld c, $04 ; $7724
	call BeginFadeIn ; $7726
	call WaitFadeEnd ; $7729
	call Func_0f_660f ; $772c
	farcall FarPtr_0a_00 ; $772f
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
	farcall FarPtr_0a_0e ; $7751
	ld a, [$c94d] ; $7754
	or a, a ; $7757
	jr nz, Label_0f_7763 ; $7758
	farcall FarPtr_0a_10 ; $775a
	farcall FarPtr_0a_10 ; $775d
	farcall FarPtr_0a_10 ; $7760
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
	farcall FarPtr_0a_42 ; $777f
	ld a, $02 ; $7782
	farcall FarPtr_0a_44 ; $7784
	ld a, $02 ; $7787
	ld b, a ; $7789
	ld a, $00 ; $778a
	farcall FarPtr_FaceActorTowardActor ; $778c
	ld a, $02 ; $778f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7791
	ld a, $08 ; $7794
	ld bc, $2000 ; $7796
	ld de, $0f80 ; $7799
	farcall FarPtr_ScriptSetActorPosition ; $779c
	sound $97 ; $779f
	push af ; $77a1
	ld a, $2d ; $77a2
	farcall FarPtr_WaitScriptFrames ; $77a4
	pop af ; $77a7
	ld a, $03 ; $77a8
	ld d, $02 ; $77aa
	farcall FarPtr_ScriptSetActorAnimation ; $77ac
	ld a, $03 ; $77af
	farcall FarPtr_ScriptWaitActorIdle ; $77b1
	ld a, $08 ; $77b4
	ld bc, $3f00 ; $77b6
	ld de, $3f00 ; $77b9
	farcall FarPtr_ScriptSetActorPosition ; $77bc
	ld a, $03 ; $77bf
	ld b, a ; $77c1
	ld a, $00 ; $77c2
	farcall FarPtr_FaceActorTowardActor ; $77c4
	ld a, $03 ; $77c7
	farcall FarPtr_ScriptShowSpeakerDialogue ; $77c9
	ld a, $04 ; $77cc
	ld d, $03 ; $77ce
	farcall FarPtr_ScriptSetActorAnimation ; $77d0
	ld a, $04 ; $77d3
	farcall FarPtr_ScriptWaitActorIdle ; $77d5
	ld a, $04 ; $77d8
	ld b, a ; $77da
	ld a, $00 ; $77db
	farcall FarPtr_FaceActorTowardActor ; $77dd
	ld a, $04 ; $77e0
	ld b, a ; $77e2
	ld a, $02 ; $77e3
	farcall FarPtr_FaceActorTowardActor ; $77e5
	ld a, $04 ; $77e8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $77ea
	call Func_0f_7911 ; $77ed
	ld a, $00 ; $77f0
	ld b, a ; $77f2
	ld a, $04 ; $77f3
	farcall FarPtr_FaceActorTowardActor ; $77f5
	ld a, $03 ; $77f8
	ld b, $00 ; $77fa
	farcall FarPtr_SetActorFacing ; $77fc
	ld hl, $2849 ; $77ff
	farcall FarPtr_0a_0e ; $7802
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
	ld a, $03 ; $7824
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7826
	set_flag $17, 1 ; $7829
	ld a, $02 ; $782c
	farcall FarPtr_GetActorStateAddr ; $782e
	ld c, l ; $7831
	ld b, h ; $7832
	ld de, $d000 ; $7833
	farcall FarPtr_04_20 ; $7836
	ret ; $7839
	; $783a, 8 bytes (records:2)
; 4 records x 2 bytes
	dw $2852 ; record 0
	dw $2852 ; record 1
	dw $2858 ; record 2
	dw $284e ; record 3
	; $7842, 134 bytes (bytes:14)
	db $00, $00, $57, $7b, $00, $21, $00, $11, $00, $00, $5c, $01, $00, $00 ; 0x00
	db $00, $00, $57, $7b, $00, $27, $00, $11, $80, $00, $5a, $01, $00, $00 ; 0x0e
	db $00, $00, $57, $7b, $00, $3d, $00, $3d, $c0, $00, $5b, $01, $00, $00 ; 0x1c
	db $00, $00, $57, $7b, $00, $01, $00, $31, $c0, $00, $25, $01, $00, $00 ; 0x2a
	db $00, $00, $57, $7b, $00, $01, $00, $31, $c0, $00, $25, $01, $00, $00 ; 0x38
	db $00, $00, $57, $7b, $00, $01, $00, $31, $c0, $00, $4c, $01, $00, $00 ; 0x46
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff, $03, $ff, $00, $00 ; 0x54
	db $cc, $78, $03, $00, $04, $ff, $00, $00, $b1, $78, $03, $00, $ff, $21 ; 0x62
	db $49, $28, $df, $0e, $0a, $fa, $b0, $c2, $3d, $21, $62, $28, $85, $6f ; 0x70
	db $30, $01, $24, $cd, $8e, $7a, $3e, $04 ; 0x7e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $78c8
	ret ; $78cb
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
	farcall FarPtr_0a_0e ; $78db
	ld a, $03 ; $78de
	farcall FarPtr_ScriptShowSpeakerDialogue ; $78e0
	ret ; $78e3
	; $78e4, 8 bytes (records:2)
; 4 records x 2 bytes
	dw $2853 ; record 0
	dw $2853 ; record 1
	dw $2859 ; record 2
	dw $284f ; record 3
Func_0f_78ec:
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
Func_0f_7911:
	ld a, $06 ; $7911
	ld bc, $1500 ; $7913
	ld de, $1700 ; $7916
	farcall FarPtr_ScriptSetActorPosition ; $7919
	ld a, $07 ; $791c
	ld bc, $1700 ; $791e
	ld de, $1700 ; $7921
	farcall FarPtr_ScriptSetActorPosition ; $7924
	ld a, $06 ; $7927
	ld bc, $2300 ; $7929
	ld de, $1700 ; $792c
	farcall FarPtr_ScriptSetActorMoveTarget ; $792f
	ld a, $07 ; $7932
	ld bc, $2500 ; $7934
	ld de, $1700 ; $7937
	farcall FarPtr_ScriptSetActorMoveTarget ; $793a
	ld a, $07 ; $793d
	farcall FarPtr_ScriptWaitActorMoveDone ; $793f
	ld hl, $2869 ; $7942
	farcall FarPtr_0a_0e ; $7945
	xor a, a ; $7948
	ld bc, $2300 ; $7949
	ld de, $1100 ; $794c
	farcall FarPtr_MovePlayerToPosition ; $794f
	farcall FarPtr_WaitPlayerMoveDone ; $7952
	ld a, $03 ; $7955
	ld b, $40 ; $7957
	farcall FarPtr_SetActorFacing ; $7959
	ld a, $04 ; $795c
	ld b, $40 ; $795e
	farcall FarPtr_SetActorFacing ; $7960
	ld a, $05 ; $7963
	ld b, $40 ; $7965
	farcall FarPtr_SetActorFacing ; $7967
	ld a, $00 ; $796a
	ld b, $40 ; $796c
	farcall FarPtr_SetActorFacing ; $796e
	ld a, $02 ; $7971
	ld b, $40 ; $7973
	farcall FarPtr_SetActorFacing ; $7975
	ld a, $06 ; $7978
	ld b, $c0 ; $797a
	farcall FarPtr_SetActorFacing ; $797c
	ld a, $07 ; $797f
	ld b, $c0 ; $7981
	farcall FarPtr_SetActorFacing ; $7983
	ld a, $06 ; $7986
	ld d, $03 ; $7988
	farcall FarPtr_ScriptSetActorAnimation ; $798a
	ld a, $06 ; $798d
	farcall FarPtr_ScriptWaitActorIdle ; $798f
	call Func_0f_78ec ; $7992
	ld a, $06 ; $7995
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7997
	ld a, $06 ; $799a
	ld d, $03 ; $799c
	farcall FarPtr_ScriptSetActorAnimation ; $799e
	ld a, $06 ; $79a1
	farcall FarPtr_ScriptWaitActorIdle ; $79a3
	ld a, [$c2b0] ; $79a6
	ld hl, $2861 ; $79a9
	add a, l ; $79ac
	ld l, a ; $79ad
	jr nc, Label_0f_79b1 ; $79ae
	inc h ; $79b0
Label_0f_79b1:
	call QueueShortText ; $79b1
	ld a, $06 ; $79b4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $79b6
	ld a, $07 ; $79b9
	ld b, a ; $79bb
	ld a, $06 ; $79bc
	farcall FarPtr_FaceActorsTowardEachOther ; $79be
	push af ; $79c1
	ld a, $14 ; $79c2
	farcall FarPtr_WaitScriptFrames ; $79c4
	pop af ; $79c7
	ld a, $06 ; $79c8
	ld d, $03 ; $79ca
	farcall FarPtr_ScriptSetActorAnimation ; $79cc
	ld a, $07 ; $79cf
	ld d, $03 ; $79d1
	farcall FarPtr_ScriptSetActorAnimation ; $79d3
	ld a, $07 ; $79d6
	farcall FarPtr_ScriptWaitActorIdle ; $79d8
	ld a, $06 ; $79db
	ld bc, $1500 ; $79dd
	ld de, $1700 ; $79e0
	farcall FarPtr_ScriptSetActorMoveTarget ; $79e3
	ld a, $07 ; $79e6
	ld bc, $1700 ; $79e8
	ld de, $1700 ; $79eb
	farcall FarPtr_ScriptSetActorMoveTarget ; $79ee
	ld a, $07 ; $79f1
	farcall FarPtr_ScriptWaitActorMoveDone ; $79f3
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
	call Func_0f_7b20 ; $7a17
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
	ld a, $05 ; $7a38
	ld d, $01 ; $7a3a
	farcall FarPtr_ScriptSetActorAnimation ; $7a3c
	ld a, $02 ; $7a3f
	farcall FarPtr_0a_1c ; $7a41
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
	ld a, [$c295] ; $7aaf
	cp a, $ff ; $7ab2
	jp z, Label_0f_7b15 ; $7ab4
	test_flag $05, 7 ; $7ab7
	jr z, Label_0f_7af8 ; $7aba
	ld a, $02 ; $7abc
	ld bc, $00ff ; $7abe
	farcall FarPtr_0a_18 ; $7ac1
	ld a, [$c295] ; $7ac4
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
	ld a, $02 ; $7ad9
	farcall FarPtr_ScriptWaitActorMoveDone ; $7adb
	ld a, [$c295] ; $7ade
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
	ld a, $02 ; $7af0
	ld bc, $0010 ; $7af2
	farcall FarPtr_0a_18 ; $7af5
Label_0f_7af8:
	ld a, $00 ; $7af8
	ld bc, $0010 ; $7afa
	farcall FarPtr_0a_18 ; $7afd
	ld a, [$c295] ; $7b00
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
Func_0f_7b20:
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
	ld a, $02 ; $7b37
	ld d, $01 ; $7b39
	farcall FarPtr_ScriptSetActorAnimation ; $7b3b
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
	ld a, $00 ; $7b4f
	ld d, $01 ; $7b51
	farcall FarPtr_ScriptSetActorAnimation ; $7b53
	ret ; $7b56
	INCBIN "data/bank_00f/d_7b57.bin" ; $7b57, 612 bytes
	ds 581, $ff ; $7dbb, fill

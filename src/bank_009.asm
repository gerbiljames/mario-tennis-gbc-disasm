SECTION "ROM Bank $09", ROMX[$4000], BANK[$09]

	farptr InitAllObjSlots ; $4000
	farptr UpdateAllObjSprites ; $4002
	farptr UpdatePointScoreDisplay ; $4004
	farptr LoadOnCourtCharacterGfx ; $4006
	farptr LoadServeGfx ; $4008
	farptr Func_09_412a ; $400a
	farptr Func_09_4190 ; $400c
	farptr Func_09_4242 ; $400e
	farptr Func_09_4282 ; $4010
	farptr ShowCourtBanner ; $4012
	farptr SpawnCourtBannerObj ; $4014
	farptr HideCourtBanner ; $4016
	farptr Func_09_4310 ; $4018
	farptr Func_09_431d ; $401a
	farptr Func_09_42d8 ; $401c
	farptr Func_09_42f6 ; $401e
	farptr InitAllObjSlotsAlias1, InitAllObjSlots ; $4020
	farptr InitAllObjSlotsAlias2, InitAllObjSlots ; $4022
	farptr Func_09_45c4 ; $4024
	farptr UpdateGameScoreDisplay ; $4026
	farptr LoadScoreDigitGfx ; $4028
	farptr LoadPlayer1PointsDigitGfx ; $402a
	farptr LoadPlayer2PointsDigitGfx ; $402c
	farptr LoadPlayer1ScoreDigitGfx ; $402e
	farptr LoadPlayer2ScoreDigitGfx ; $4030
	farptr Func_09_422c ; $4032
	farptr Func_09_4238 ; $4034
UpdatePointScoreDisplay:
	ld a, [wTiebreakerIndicator] ; $4036
	and a, a ; $4039
	jr nz, Label_09_405f ; $403a
	ld a, [wPlayer2PointsWon] ; $403c
	cp a, $04 ; $403f
	ld a, [wPlayer1PointsWon] ; $4041
	jr nz, Label_09_4048 ; $4044
	ld a, $05 ; $4046
Label_09_4048:
	ld b, $00 ; $4048
	call LoadPlayer1PointsDigitGfx ; $404a
	ld a, [wPlayer1PointsWon] ; $404d
	cp a, $04 ; $4050
	ld a, [wPlayer2PointsWon] ; $4052
	jr nz, Label_09_4059 ; $4055
	ld a, $05 ; $4057
Label_09_4059:
	ld b, $00 ; $4059
	call LoadPlayer2PointsDigitGfx ; $405b
	ret ; $405e
Label_09_405f:
	ld a, [wPlayer2PointsWon] ; $405f
	cp a, $07 ; $4062
	ld a, [wPlayer1PointsWon] ; $4064
	jr nz, Label_09_406b ; $4067
	ld a, $08 ; $4069
Label_09_406b:
	ld b, $01 ; $406b
	call LoadPlayer1PointsDigitGfx ; $406d
	ld a, [wPlayer1PointsWon] ; $4070
	cp a, $07 ; $4073
	ld a, [wPlayer2PointsWon] ; $4075
	jr nz, Label_09_407c ; $4078
	ld a, $08 ; $407a
Label_09_407c:
	ld b, $01 ; $407c
	call LoadPlayer2PointsDigitGfx ; $407e
	ret ; $4081
GetPointScoreForDisplay:
	ld a, [wPlayer1PointsWon] ; $4082
	ld d, a ; $4085
	ld a, [wPlayer2PointsWon] ; $4086
	ld e, a ; $4089
	ld a, [wCurrentServingPlayer] ; $408a
	and a, $01 ; $408d
	jr z, Label_09_4094 ; $408f
	ld a, d ; $4091
	ld d, e ; $4092
	ld e, a ; $4093
Label_09_4094:
	ld a, [wDeuceIndicator] ; $4094
	ret ; $4097
UpdateGameScoreDisplay:
	call GetPointScoreForDisplay ; $4098
	and a, a ; $409b
	jr nz, Label_09_40b1 ; $409c
	push de ; $409e
	ld a, [$c7bd] ; $409f
	ld b, a ; $40a2
	ld a, d ; $40a3
	call LoadPlayer1ScoreDigitGfx ; $40a4
	pop de ; $40a7
	ld a, [$c7bd] ; $40a8
	ld b, a ; $40ab
	ld a, e ; $40ac
	call LoadPlayer2ScoreDigitGfx ; $40ad
	ret ; $40b0
Label_09_40b1:
	call LoadDeuceAdvantageGfx ; $40b1
	ret ; $40b4
LoadOnCourtCharacterGfx:
	ld a, $ff ; $40b5
	ld de, $8140 ; $40b7
	farcall LoadOnCourtCharTilesB ; $40ba
	ld a, [wOnCourtCharCountMinus1] ; $40bd
	rst Rst00 ; $40c0
	dw Label_09_4111 ; $40c1 jumptable
	dw Label_09_40f9 ; $40c3 jumptable
	dw Label_09_40e1 ; $40c5 jumptable
	dw Label_09_40c9 ; $40c7 jumptable
Label_09_40c9:
	wram_bank $06 ; $40c9
	ld a, [$df7e] ; $40cf
	ld de, $8100 ; $40d2
	farcall LoadOnCourtCharTilesA ; $40d5
	ld a, [$df7e] ; $40d8
	ld de, $8140 ; $40db
	farcall LoadOnCourtCharTilesB ; $40de
Label_09_40e1:
	wram_bank $07 ; $40e1
	ld a, [$df7e] ; $40e7
	ld de, $8180 ; $40ea
	farcall LoadOnCourtCharTilesA ; $40ed
	ld a, [$df7e] ; $40f0
	ld de, $81c0 ; $40f3
	farcall LoadOnCourtCharTilesB ; $40f6
Label_09_40f9:
	wram_bank $05 ; $40f9
	ld a, [$df7e] ; $40ff
	ld de, $8080 ; $4102
	farcall LoadOnCourtCharTilesA ; $4105
	ld a, [$df7e] ; $4108
	ld de, $80c0 ; $410b
	farcall LoadOnCourtCharTilesB ; $410e
Label_09_4111:
	wram_bank $04 ; $4111
	ld a, [$df7e] ; $4117
	ld de, $8000 ; $411a
	farcall LoadOnCourtCharTilesA ; $411d
	ld a, [$df7e] ; $4120
	ld de, $8040 ; $4123
	farcall LoadOnCourtCharTilesB ; $4126
	ret ; $4129
Func_09_412a:
	wram_bank $04 ; $412a
	call ClearAllObjSlots ; $4130
	ld a, [$c494] ; $4133
	cp a, $03 ; $4136
	jr z, Label_09_4184 ; $4138
	ld a, [wCurrentServingPlayer] ; $413a
	cpl ; $413d
	and a, $01 ; $413e
	ld b, a ; $4140
	wram_bank $04 ; $4141
	ld a, [$df0a] ; $4147
	and a, $02 ; $414a
	or a, b ; $414c
	ld b, a ; $414d
	wram_bank $04 ; $414e
	push bc ; $4154
	ld a, b ; $4155
	ld hl, ObjTemplates_09_41bc ; $4156
	ld bc, $dd80 ; $4159
	call LoadObjTemplate_09 ; $415c
	call Func_09_7195 ; $415f
	call Func_09_45bc ; $4162
	pop bc ; $4165
	ld a, b ; $4166
	xor a, $03 ; $4167
	ld hl, ObjTemplates_09_41bc ; $4169
	ld bc, $dd90 ; $416c
	call LoadObjTemplate_09 ; $416f
	call Func_09_71ac ; $4172
	call Func_09_45bc ; $4175
	ld a, $00 ; $4178
	ld hl, $420c ; $417a
	ld bc, $dda0 ; $417d
	call LoadObjTemplate_09 ; $4180
	ret ; $4183
Label_09_4184:
	ld a, $00 ; $4184
	ld hl, $41fc ; $4186
	ld bc, $dd80 ; $4189
	call LoadObjTemplate_09 ; $418c
	ret ; $418f
Func_09_4190:
	ld a, [$c7bb] ; $4190
	and a, a ; $4193
	jr nz, Label_09_41b2 ; $4194
	ld hl, ObjTemplates_09_41bc ; $4196
	ld bc, $dd80 ; $4199
	call StartObjExitAnim ; $419c
	ld hl, ObjTemplates_09_41bc ; $419f
	ld bc, $dd90 ; $41a2
	call StartObjExitAnim ; $41a5
	ld hl, $420c ; $41a8
	ld bc, $dda0 ; $41ab
	call StartObjExitAnim ; $41ae
	ret ; $41b1
Label_09_41b2:
	ld hl, $41fc ; $41b2
	ld bc, $dd80 ; $41b5
	call StartObjExitAnim ; $41b8
	ret ; $41bb
ObjTemplates_09_41bc:
	; $41bc, 112 bytes (records:16)
; 7 records x 16 bytes
	dw $4c50, $0000, $4764, $0001, $4764, $0003, $0066, $0000 ; record 0
	dw $3450, $0000, $4764, $0000, $4764, $0002, $0066, $0000 ; record 1
	dw $4c30, $0000, $4764, $0001, $4764, $0003, $0066, $0000 ; record 2
	dw $3430, $0000, $4764, $0000, $4764, $0002, $0066, $0000 ; record 3
	dw $4040, $71f7, $4764, $0000, $4764, $0003, $0066, $0000 ; record 4
	dw $4040, $7090, $4758, $0000, $475e, $0000, $0066, $0000 ; record 5
	dw $4050, $7090, $4764, $0000, $4764, $0002, $0066, $0000 ; record 6
Func_09_422c:
	ld a, $01 ; $422c
	ld hl, $420c ; $422e
	ld bc, $dda0 ; $4231
	call LoadObjTemplate_09 ; $4234
	ret ; $4237
Func_09_4238:
	ld hl, $420c ; $4238
	ld bc, $dda0 ; $423b
	call StartObjExitAnim ; $423e
	ret ; $4241
Func_09_4242:
	call ClearAllObjSlots ; $4242
	call Func_09_4310 ; $4245
	ld a, [$c4d4] ; $4248
	ld hl, $4298 ; $424b
	ld bc, $dd80 ; $424e
	call LoadObjTemplate_09 ; $4251
	call Func_09_7103 ; $4254
	call Func_09_45bc ; $4257
	ld a, [$c494] ; $425a
	cp a, $03 ; $425d
	jr z, Label_09_4274 ; $425f
	ld a, [$c4d4] ; $4261
	ld hl, $4298 ; $4264
	ld bc, $dd90 ; $4267
	call LoadObjTemplate_09 ; $426a
	call Func_09_711a ; $426d
	call Func_09_45bc ; $4270
	ret ; $4273
Label_09_4274:
	ld a, [$c4d4] ; $4274
	and a, $02 ; $4277
	ret nz ; $4279
	ld hl, $dd87 ; $427a
	ld a, [hl] ; $427d
	add a, $10 ; $427e
	ld [hl], a ; $4280
	ret ; $4281
Func_09_4282:
	call Func_09_431d ; $4282
	ld hl, $4298 ; $4285
	ld bc, $dd80 ; $4288
	call StartObjExitAnim ; $428b
	ld hl, $4298 ; $428e
	ld bc, $dd90 ; $4291
	call StartObjExitAnim ; $4294
	ret ; $4297
	INCBIN "data/bank_009/d_4298.bin" ; $4298, 64 bytes
Func_09_42d8:
	push af ; $42d8
	ld a, $00 ; $42d9
	ld hl, $4300 ; $42db
	ld bc, $dd80 ; $42de
	call LoadObjTemplate_09 ; $42e1
	pop af ; $42e4
	add a, a ; $42e5
	jr c, Label_09_42ef ; $42e6
	call Func_09_7195 ; $42e8
	call Func_09_45bc ; $42eb
	ret ; $42ee
Label_09_42ef:
	call Func_09_71ac ; $42ef
	call Func_09_45bc ; $42f2
	ret ; $42f5
Func_09_42f6:
	ld hl, $4300 ; $42f6
	ld bc, $dd80 ; $42f9
	call StartObjExitAnim ; $42fc
	ret ; $42ff
	INCBIN "data/bank_009/d_4300.bin" ; $4300, 16 bytes
Func_09_4310:
	ld a, [$c4d4] ; $4310
	ld hl, $4327 ; $4313
	ld bc, $ddc0 ; $4316
	call LoadObjTemplate_09 ; $4319
	ret ; $431c
Func_09_431d:
	ld hl, $4327 ; $431d
	ld bc, $ddc0 ; $4320
	call StartObjExitAnim ; $4323
	ret ; $4326
	INCBIN "data/bank_009/d_4327.bin" ; $4327, 64 bytes
ShowCourtBanner:
	push af ; $4367
	call ClearAllObjSlots ; $4368
	pop af ; $436b
	push af ; $436c
	call LoadTilesetGfx ; $436d
	pop af ; $4370
SpawnCourtBannerObj:
	ld hl, $4385 ; $4371
	ld bc, $ddb0 ; $4374
	call LoadObjTemplate_09 ; $4377
	ret ; $437a
HideCourtBanner:
	ld hl, $4385 ; $437b
	ld bc, $ddb0 ; $437e
	call StartObjExitAnim ; $4381
	ret ; $4384
	INCBIN "data/bank_009/d_4385.bin" ; $4385, 83 bytes
SetActorPositionRaw:
	INCBIN "data/bank_009/d_43d8.bin" ; $43d8, 71 bytes
SetActorMoveTargetRaw:
	INCBIN "data/bank_009/d_441f.bin" ; $441f, 310 bytes
InitAllObjSlots:
	wram_bank $04 ; $4555
	ld bc, $dd80 ; $455b
	call InitObjSlot ; $455e
	ld bc, $dd90 ; $4561
	call InitObjSlot ; $4564
	ld bc, $dda0 ; $4567
	call InitObjSlot ; $456a
	ld d, $01 ; $456d
	call Func_09_45d2 ; $456f
	ld d, $30 ; $4572
	call Func_09_45cc ; $4574
	ld bc, $ddb0 ; $4577
	call InitObjSlot ; $457a
	ld d, $01 ; $457d
	call Func_09_45d2 ; $457f
	ld d, $20 ; $4582
	call Func_09_45cc ; $4584
	ld bc, $ddc0 ; $4587
	call InitObjSlot ; $458a
	ld d, $01 ; $458d
	call Func_09_45d2 ; $458f
	ld d, $38 ; $4592
	call Func_09_45cc ; $4594
	ret ; $4597
InitObjSlot:
	push bc ; $4598
	ld l, c ; $4599
	ld h, b ; $459a
	ld c, $01 ; $459b
	call ClearMemory16 ; $459d
	pop bc ; $45a0
	ld hl, $0008 ; $45a1
	add hl, bc ; $45a4
	ld de, $4781 ; $45a5
	ld a, e ; $45a8
	ld [hl+], a ; $45a9
	ld [hl], d ; $45aa
	ld hl, $0002 ; $45ab
	add hl, bc ; $45ae
	ld de, $7098 ; $45af
	ld a, e ; $45b2
	ld [hl+], a ; $45b3
	ld [hl], d ; $45b4
	ld hl, $0000 ; $45b5
	add hl, bc ; $45b8
	ld [hl], $ff ; $45b9
	ret ; $45bb
Func_09_45bc:
	ld hl, $0002 ; $45bc
	add hl, bc ; $45bf
	ld a, e ; $45c0
	ld [hl+], a ; $45c1
	ld [hl], d ; $45c2
	ret ; $45c3
Func_09_45c4:
	ld hl, $0006 ; $45c4
	add hl, bc ; $45c7
	ld [hl], d ; $45c8
	inc hl ; $45c9
	ld [hl], e ; $45ca
	ret ; $45cb
Func_09_45cc:
	ld hl, $0005 ; $45cc
	add hl, bc ; $45cf
	ld [hl], d ; $45d0
	ret ; $45d1
Func_09_45d2:
	ld hl, $0004 ; $45d2
	add hl, bc ; $45d5
	ld [hl], d ; $45d6
	ret ; $45d7
Func_09_45d8:
	ld hl, $0008 ; $45d8
	add hl, bc ; $45db
	ld a, e ; $45dc
	ld [hl+], a ; $45dd
	ld [hl], d ; $45de
	ld hl, $000c ; $45df
	add hl, bc ; $45e2
	ld [hl], $00 ; $45e3
	ld hl, $000d ; $45e5
	add hl, bc ; $45e8
	ld [hl], $00 ; $45e9
	ret ; $45eb
Func_09_45ec:
	ld hl, $000e ; $45ec
	add hl, bc ; $45ef
	ld [hl], d ; $45f0
	ret ; $45f1
Func_09_45f2:
	ld hl, $000f ; $45f2
	add hl, bc ; $45f5
	ld [hl], d ; $45f6
	ret ; $45f7
	INCBIN "data/bank_009/d_45f8.bin" ; $45f8, 18 bytes
LoadObjTemplate_09:
	push hl ; $460a
	ld hl, $0000 ; $460b
	add hl, bc ; $460e
	ld [hl], a ; $460f
	ld h, $00 ; $4610
	ld l, a ; $4612
	add hl, hl ; $4613
	add hl, hl ; $4614
	add hl, hl ; $4615
	add hl, hl ; $4616
	pop de ; $4617
	add hl, de ; $4618
	push hl ; $4619
	ld a, [hl+] ; $461a
	ld e, a ; $461b
	ld a, [hl+] ; $461c
	ld d, a ; $461d
	push hl ; $461e
	call Func_09_45c4 ; $461f
	pop hl ; $4622
	ld a, [hl+] ; $4623
	ld e, a ; $4624
	ld a, [hl+] ; $4625
	ld d, a ; $4626
	push hl ; $4627
	call Func_09_45bc ; $4628
	pop hl ; $462b
	ld a, [hl+] ; $462c
	ld e, a ; $462d
	ld a, [hl+] ; $462e
	ld d, a ; $462f
	push hl ; $4630
	call Func_09_45d8 ; $4631
	pop hl ; $4634
	ld d, [hl] ; $4635
	call Func_09_45ec ; $4636
	pop hl ; $4639
	ld de, $000c ; $463a
	add hl, de ; $463d
	ld a, [hl+] ; $463e
	inc hl ; $463f
	and a, a ; $4640
	jr z, Label_09_4646 ; $4641
	call PlaySoundManaged ; $4643
Label_09_4646:
	ld d, [hl] ; $4646
	call Func_09_45f2 ; $4647
	xor a, a ; $464a
	ld hl, $000a ; $464b
	add hl, bc ; $464e
	ld [hl+], a ; $464f
	ld [hl+], a ; $4650
	ld hl, $0001 ; $4651
	add hl, bc ; $4654
	set 7, [hl] ; $4655
	ret ; $4657
StartObjExitAnim:
	ld a, $01 ; $4658
	add a, c ; $465a
	ld e, a ; $465b
	ld d, b ; $465c
	ld a, [de] ; $465d
	bit 7, a ; $465e
	ret z ; $4660
	res 7, a ; $4661
	ld [de], a ; $4663
	ld a, $00 ; $4664
	add a, c ; $4666
	ld e, a ; $4667
	ld d, b ; $4668
	ld a, [de] ; $4669
	add a, a ; $466a
	add a, a ; $466b
	add a, a ; $466c
	add a, a ; $466d
	add a, $08 ; $466e
	add a, l ; $4670
	ld l, a ; $4671
	jr nc, Label_09_4675 ; $4672
	inc h ; $4674
Label_09_4675:
	ld a, [hl+] ; $4675
	ld e, a ; $4676
	ld a, [hl+] ; $4677
	ld d, a ; $4678
	push hl ; $4679
	call Func_09_45d8 ; $467a
	pop hl ; $467d
	ld d, [hl] ; $467e
	call Func_09_45ec ; $467f
	ret ; $4682
ClearAllObjSlots:
	ld a, $ff ; $4683
	ld [$dd80], a ; $4685
	ld [$dd90], a ; $4688
	ld [$dda0], a ; $468b
	ld [$ddb0], a ; $468e
	ld [$ddc0], a ; $4691
	ret ; $4694
UpdateAllObjSprites:
	ld bc, $dd80 ; $4695
	call ProcessObjSlot ; $4698
	ld bc, $dd90 ; $469b
	call ProcessObjSlot ; $469e
	ld bc, $dda0 ; $46a1
	call ProcessObjSlot ; $46a4
	ld bc, $ddb0 ; $46a7
	call ProcessObjSlot ; $46aa
	ld bc, $ddc0 ; $46ad
	call ProcessObjSlot ; $46b0
	ret ; $46b3
	ret ; $46b4
ProcessObjSlot:
	ld hl, $0000 ; $46b5
	add hl, bc ; $46b8
	ld a, [hl] ; $46b9
	cp a, $ff ; $46ba
	ret z ; $46bc
	ld l, c ; $46bd
	ld h, b ; $46be
	push hl ; $46bf
	ld de, $ddf0 ; $46c0
	ld c, $01 ; $46c3
	call CopyMemoryFast ; $46c5
	ld hl, Func_09_46d3 ; $46c8
	push hl ; $46cb
	ld hl, $ddf8 ; $46cc
	ld a, [hl+] ; $46cf
	ld h, [hl] ; $46d0
	ld l, a ; $46d1
	jp hl ; $46d2
Func_09_46d3:
	ld hl, Func_09_46e1 ; $46d3
	push hl ; $46d6
	ld a, [$ddff] ; $46d7
	and a, a ; $46da
	jr z, Label_09_46f0 ; $46db
	cp a, $01 ; $46dd
	jr z, Label_09_4718 ; $46df
Func_09_46e1:
	ld hl, $ddfd ; $46e1
	ld a, [hl] ; $46e4
	inc [hl] ; $46e5
	pop de ; $46e6
	ld hl, $ddf0 ; $46e7
	ld c, $01 ; $46ea
	call CopyMemoryFast ; $46ec
	ret ; $46ef
Label_09_46f0:
	ld hl, $ddf1 ; $46f0
	bit 0, [hl] ; $46f3
	ret z ; $46f5
	ld hl, $ddf6 ; $46f6
	ld a, [$ddfa] ; $46f9
	add a, [hl] ; $46fc
	ld d, a ; $46fd
	ld hl, $ddf7 ; $46fe
	ld a, [$ddfb] ; $4701
	add a, [hl] ; $4704
	ld e, a ; $4705
	ld a, [$ddf4] ; $4706
	ld b, a ; $4709
	ld a, [$ddf5] ; $470a
	ld c, a ; $470d
	ld hl, $ddf2 ; $470e
	ld a, [hl+] ; $4711
	ld h, [hl] ; $4712
	ld l, a ; $4713
	call QueueSpriteTemplate ; $4714
	ret ; $4717
Label_09_4718:
	ld hl, $ddf1 ; $4718
	bit 0, [hl] ; $471b
	ret z ; $471d
	farcall FindServerCharBank ; $471e
	ld a, b ; $4721
	wram_bank ; $4722
	ld a, [$df53] ; $4726
	ld d, a ; $4729
	ld a, [$df54] ; $472a
	ld e, a ; $472d
	wram_bank $04 ; $472e
	ld a, [$ddfa] ; $4734
	ld hl, $ddf6 ; $4737
	add a, [hl] ; $473a
	add a, d ; $473b
	ld d, a ; $473c
	ld a, [$ddfb] ; $473d
	ld hl, $ddf7 ; $4740
	add a, [hl] ; $4743
	add a, e ; $4744
	ld e, a ; $4745
	ld a, [$ddf4] ; $4746
	ld b, a ; $4749
	ld a, [$ddf5] ; $474a
	ld c, a ; $474d
	ld hl, $ddf2 ; $474e
	ld a, [hl+] ; $4751
	ld h, [hl] ; $4752
	ld l, a ; $4753
	call QueueSpriteTemplate ; $4754
	ret ; $4757
	ld hl, $ddf1 ; $4758
	set 0, [hl] ; $475b
	ret ; $475d
	ld hl, $ddf1 ; $475e
	res 0, [hl] ; $4761
	ret ; $4763
	ld a, [$ddfc] ; $4764
	rst Rst00 ; $4767
	dw Label_09_476c ; $4768 jumptable
	dw Label_09_4781 ; $476a jumptable
Label_09_476c:
	ld hl, $ddf1 ; $476c
	set 0, [hl] ; $476f
	call GetNextMoveCurveValue ; $4771
	jp z, Label_09_477d ; $4774
	ret ; $4777
	INCBIN "data/bank_009/d_4778.bin" ; $4778, 5 bytes
Label_09_477d:
	ld hl, $ddfc ; $477d
	inc [hl] ; $4780
Label_09_4781:
	ret ; $4781
GetNextMoveCurveValue:
	ld a, [$ddfe] ; $4782
	add a, a ; $4785
	add a, $ae ; $4786
	ld l, a ; $4788
	adc a, $47 ; $4789
	sub a, l ; $478b
	ld h, a ; $478c
	ld a, [hl+] ; $478d
	ld h, [hl] ; $478e
	ld l, a ; $478f
	ld a, [$ddfd] ; $4790
	add a, l ; $4793
	ld l, a ; $4794
	jr nc, Label_09_4798 ; $4795
	inc h ; $4797
Label_09_4798:
	ld a, [hl] ; $4798
	cp a, $80 ; $4799
	jr z, Label_09_47ac ; $479b
	cp a, $81 ; $479d
	jr z, Label_09_47a7 ; $479f
	ld [$ddfa], a ; $47a1
	xor a, a ; $47a4
	inc a ; $47a5
	ret ; $47a6
Label_09_47a7:
	ld a, $ff ; $47a7
	ld [$ddf0], a ; $47a9
Label_09_47ac:
	xor a, a ; $47ac
	ret ; $47ad
MoveCurveTable_09:
	INCBIN "data/bank_009/d_47ae.bin" ; $47ae, 197 bytes
LoadTilesetGfx:
	add a, a ; $4873
	add a, a ; $4874
	add a, $8a ; $4875
	ld l, a ; $4877
	adc a, $48 ; $4878
	sub a, l ; $487a
	ld h, a ; $487b
	ld a, [hl+] ; $487c
	ld e, a ; $487d
	ld a, [hl+] ; $487e
	ld d, a ; $487f
	ld c, [hl] ; $4880
	ld l, e ; $4881
	ld h, d ; $4882
	ld de, $8200 ; $4883
	call QueueVRAMCopy ; $4886
	ret ; $4889
VramTileset_09:
	; $488a, 118 bytes (records:4)
; 29 records x 4 bytes
	dw $4900, $0020 ; record 0
	dw $4b00, $0008 ; record 1
	dw $4b80, $0010 ; record 2
	dw $4c80, $0008 ; record 3
	dw $4ce0, $0008 ; record 4
	dw $4d40, $0008 ; record 5
	dw $4da0, $000a ; record 6
	dw $4e40, $0010 ; record 7
	dw $4f40, $0010 ; record 8
	dw $5040, $0010 ; record 9
	dw $5140, $0010 ; record 10
	dw $5240, $0010 ; record 11
	dw $52c0, $0010 ; record 12
	dw $5340, $0010 ; record 13
	dw $53c0, $0008 ; record 14
	dw $5420, $0020 ; record 15
	dw $5620, $0010 ; record 16
	dw $4900, $0001 ; record 17
	dw $5780, $000e ; record 18
	dw $5860, $000e ; record 19
	dw $5940, $000e ; record 20
	dw $5a20, $000e ; record 21
	dw $5b00, $000e ; record 22
	dw $5be0, $000e ; record 23
	dw $5cc0, $0010 ; record 24
	dw $5dc0, $0010 ; record 25
	dw $5ec0, $0010 ; record 26
	dw $5fc0, $0004 ; record 27
	dw $6000, $0010 ; record 28
	db $00, $00
TilesetTiles_09:
	INCBIN "data/bank_009/d_4900.bin" ; $4900, 6144 bytes
LoadScoreDigitGfx:
	ld hl, VramGfxPtrTable_09_616d ; $6100
	call GetGfxSourcePtr ; $6103
	ld c, $04 ; $6106
	call QueueVRAMCopy ; $6108
	ret ; $610b
LoadPlayer1PointsDigitGfx:
	ld hl, VramGfxPtrTable_09_616d ; $610c
	call GetGfxSourcePtr ; $610f
	ld de, $8780 ; $6112
	ld c, $04 ; $6115
	call QueueVRAMCopy ; $6117
	ret ; $611a
LoadPlayer2PointsDigitGfx:
	ld hl, VramGfxPtrTable_09_616d ; $611b
	call GetGfxSourcePtr ; $611e
	ld de, $87c0 ; $6121
	ld c, $04 ; $6124
	call QueueVRAMCopy ; $6126
	ret ; $6129
LoadPlayer1ScoreDigitGfx:
	ld hl, $6171 ; $612a
	call GetGfxSourcePtr ; $612d
	ld de, $8300 ; $6130
	ld c, $04 ; $6133
	call QueueVRAMCopy ; $6135
	ret ; $6138
LoadPlayer2ScoreDigitGfx:
	ld hl, $6175 ; $6139
	call GetGfxSourcePtr ; $613c
	ld de, $8340 ; $613f
	ld c, $04 ; $6142
	call QueueVRAMCopy ; $6144
	ret ; $6147
LoadDeuceAdvantageGfx:
	ld hl, $6bc0 ; $6148
	ld de, $8300 ; $614b
	ld c, $08 ; $614e
	call QueueVRAMCopy ; $6150
	ret ; $6153
GetGfxSourcePtr:
	push af ; $6154
	ld a, b ; $6155
	add a, a ; $6156
	add a, l ; $6157
	ld l, a ; $6158
	jr nc, Label_09_615c ; $6159
	inc h ; $615b
Label_09_615c:
	ld a, [hl+] ; $615c
	ld h, [hl] ; $615d
	ld l, a ; $615e
	pop af ; $615f
	ld b, a ; $6160
	ld c, $00 ; $6161
	sra b ; $6163
	rr c ; $6165
	sra b ; $6167
	rr c ; $6169
	add hl, bc ; $616b
	ret ; $616c
VramGfxPtrTable_09_616d:
	INCBIN "data/bank_009/d_616d.bin" ; $616d, 2771 bytes
LoadServeGfx:
	ld a, [wCurrentServingPlayer] ; $6c40
	add a, a ; $6c43
	add a, $6e ; $6c44
	ld l, a ; $6c46
	adc a, $6c ; $6c47
	sub a, l ; $6c49
	ld h, a ; $6c4a
	ld a, [hl+] ; $6c4b
	ld h, [hl] ; $6c4c
	ld l, a ; $6c4d
	ld a, [wServeFaultFlag] ; $6c4e
	and a, $01 ; $6c51
	ld b, a ; $6c53
	ld a, [$c4d4] ; $6c54
	and a, $02 ; $6c57
	or a, b ; $6c59
	add a, a ; $6c5a
	add a, a ; $6c5b
	add a, a ; $6c5c
	add a, a ; $6c5d
	add a, a ; $6c5e
	add a, a ; $6c5f
	add a, l ; $6c60
	ld l, a ; $6c61
	jr nc, Label_09_6c65 ; $6c62
	inc h ; $6c64
Label_09_6c65:
	ld de, $8380 ; $6c65
	ld c, $04 ; $6c68
	call QueueVRAMCopy ; $6c6a
	ret ; $6c6d
ServeGfxPtrTable_09:
	INCBIN "data/bank_009/d_6c6e.bin" ; $6c6e, 1173 bytes
Func_09_7103:
	ld a, [wOnCourtCharCountMinus1] ; $7103
	add a, a ; $7106
	add a, $12 ; $7107
	ld l, a ; $7109
	adc a, $71 ; $710a
	sub a, l ; $710c
	ld h, a ; $710d
	ld a, [hl+] ; $710e
	ld d, [hl] ; $710f
	ld e, a ; $7110
	ret ; $7111
	INCBIN "data/bank_009/d_7112.bin" ; $7112, 8 bytes
Func_09_711a:
	ld a, [wOnCourtCharCountMinus1] ; $711a
	add a, a ; $711d
	add a, $29 ; $711e
	ld l, a ; $7120
	adc a, $71 ; $7121
	sub a, l ; $7123
	ld h, a ; $7124
	ld a, [hl+] ; $7125
	ld d, [hl] ; $7126
	ld e, a ; $7127
	ret ; $7128
	INCBIN "data/bank_009/d_7129.bin" ; $7129, 108 bytes
Func_09_7195:
	ld a, [wOnCourtCharCountMinus1] ; $7195
	add a, a ; $7198
	add a, $a4 ; $7199
	ld l, a ; $719b
	adc a, $71 ; $719c
	sub a, l ; $719e
	ld h, a ; $719f
	ld a, [hl+] ; $71a0
	ld d, [hl] ; $71a1
	ld e, a ; $71a2
	ret ; $71a3
	INCBIN "data/bank_009/d_71a4.bin" ; $71a4, 8 bytes
Func_09_71ac:
	ld a, [wOnCourtCharCountMinus1] ; $71ac
	add a, a ; $71af
	add a, $bb ; $71b0
	ld l, a ; $71b2
	adc a, $71 ; $71b3
	sub a, l ; $71b5
	ld h, a ; $71b6
	ld a, [hl+] ; $71b7
	ld d, [hl] ; $71b8
	ld e, a ; $71b9
	ret ; $71ba
	INCBIN "data/bank_009/d_71bb.bin" ; $71bb, 93 bytes
	ds 3560, $ff ; $7218, fill

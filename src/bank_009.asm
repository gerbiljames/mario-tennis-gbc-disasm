SECTION "ROM Bank $09", ROMX[$4000], BANK[$09]

	farptr InitAllObjSlots ; $4000
	farptr UpdateAllObjSprites ; $4002
	farptr UpdatePointDigitsDisplay ; $4004
	farptr LoadOnCourtCharacterGfx ; $4006
	farptr LoadServeGfx ; $4008
	farptr SpawnGameScoreDisplayObjs ; $400a
	farptr DismissGameScoreDisplayObjs ; $400c
	farptr SpawnServeIndicatorObjs ; $400e
	farptr DismissServeIndicatorObjs ; $4010
	farptr ShowCourtBanner ; $4012
	farptr SpawnCourtBannerObj ; $4014
	farptr HideCourtBanner ; $4016
	farptr SpawnServeIndicatorSideObj ; $4018
	farptr DismissServeIndicatorSideObj ; $401a
	farptr SpawnWinLoseResultObj ; $401c
	farptr DismissWinLoseResultObj ; $401e
	farptr InitAllObjSlotsAlias1, InitAllObjSlots ; $4020
	farptr InitAllObjSlotsAlias2, InitAllObjSlots ; $4022
	farptr SetObjPosition ; $4024
	farptr UpdateScorePanelDisplay ; $4026
	farptr LoadScoreDigitGfx ; $4028
	farptr LoadPlayer1PointsDigitGfx ; $402a
	farptr LoadPlayer2PointsDigitGfx ; $402c
	farptr LoadPlayer1ScoreDigitGfx ; $402e
	farptr LoadPlayer2ScoreDigitGfx ; $4030
	farptr SpawnGameResultObj ; $4032
	farptr DismissGameResultObj ; $4034
UpdatePointDigitsDisplay:
	ld a, [wTiebreakerIndicator] ; $4036
	and a ; $4039
	jr nz, .drawPlayer2 ; $403a
	ld a, [wPlayer2PointsWon] ; $403c
	cp $04 ; $403f
	ld a, [wPlayer1PointsWon] ; $4041
	jr nz, .drawPlayer1 ; $4044
	ld a, $05 ; $4046
.drawPlayer1:
	ld b, $00 ; $4048
	call LoadPlayer1PointsDigitGfx ; $404a
	ld a, [wPlayer1PointsWon] ; $404d
	cp $04 ; $4050
	ld a, [wPlayer2PointsWon] ; $4052
	jr nz, .checkPlayer2 ; $4055
	ld a, $05 ; $4057
.checkPlayer2:
	ld b, $00 ; $4059
	call LoadPlayer2PointsDigitGfx ; $405b
	ret ; $405e
.drawPlayer2:
	ld a, [wPlayer2PointsWon] ; $405f
	cp $07 ; $4062
	ld a, [wPlayer1PointsWon] ; $4064
	jr nz, .checkAdvantage ; $4067
	ld a, $08 ; $4069
.checkAdvantage:
	ld b, $01 ; $406b
	call LoadPlayer1PointsDigitGfx ; $406d
	ld a, [wPlayer1PointsWon] ; $4070
	cp $07 ; $4073
	ld a, [wPlayer2PointsWon] ; $4075
	jr nz, .done ; $4078
	ld a, $08 ; $407a
.done:
	ld b, $01 ; $407c
	call LoadPlayer2PointsDigitGfx ; $407e
	ret ; $4081
GetPointScoreForDisplay:
	ld a, [wPlayer1PointsWon] ; $4082
	ld d, a ; $4085
	ld a, [wPlayer2PointsWon] ; $4086
	ld e, a ; $4089
	ld a, [wCurrentServingPlayer] ; $408a
	and $01 ; $408d
	jr z, .readDeuce ; $408f
	ld a, d ; $4091
	ld d, e ; $4092
	ld e, a ; $4093
.readDeuce:
	ld a, [wDeuceIndicator] ; $4094
	ret ; $4097
UpdateScorePanelDisplay:
	call GetPointScoreForDisplay ; $4098
	and a ; $409b
	jr nz, .deuce ; $409c
	push de ; $409e
	ld a, [wScoreDisplayIsTiebreak] ; $409f
	ld b, a ; $40a2
	ld a, d ; $40a3
	call LoadPlayer1ScoreDigitGfx ; $40a4
	pop de ; $40a7
	ld a, [wScoreDisplayIsTiebreak] ; $40a8
	ld b, a ; $40ab
	ld a, e ; $40ac
	call LoadPlayer2ScoreDigitGfx ; $40ad
	ret ; $40b0
.deuce:
	call LoadDeuceAdvantageGfx ; $40b1
	ret ; $40b4
LoadOnCourtCharacterGfx:
	ld a, $ff ; $40b5
	ld de, $8140 ; $40b7
	farcall LoadOnCourtCharTilesB ; $40ba
	ld a, [wOnCourtCharCountMinus1] ; $40bd
	rst Rst00 ; $40c0
	dw LoadOnCourtCharacterGfx.done ; $40c1 jumptable
	dw LoadOnCourtCharacterGfx.char4 ; $40c3 jumptable
	dw LoadOnCourtCharacterGfx.char3 ; $40c5 jumptable
	dw LoadOnCourtCharacterGfx.char2 ; $40c7 jumptable
.char2:
	wram_bank $06 ; $40c9
	ld a, [wCharSpriteSetId] ; $40cf
	ld de, $8100 ; $40d2
	farcall LoadOnCourtCharTilesA ; $40d5
	ld a, [wCharSpriteSetId] ; $40d8
	ld de, $8140 ; $40db
	farcall LoadOnCourtCharTilesB ; $40de
.char3:
	wram_bank $07 ; $40e1
	ld a, [wCharSpriteSetId] ; $40e7
	ld de, $8180 ; $40ea
	farcall LoadOnCourtCharTilesA ; $40ed
	ld a, [wCharSpriteSetId] ; $40f0
	ld de, $81c0 ; $40f3
	farcall LoadOnCourtCharTilesB ; $40f6
.char4:
	wram_bank $05 ; $40f9
	ld a, [wCharSpriteSetId] ; $40ff
	ld de, $8080 ; $4102
	farcall LoadOnCourtCharTilesA ; $4105
	ld a, [wCharSpriteSetId] ; $4108
	ld de, $80c0 ; $410b
	farcall LoadOnCourtCharTilesB ; $410e
.done:
	wram_bank $04 ; $4111
	ld a, [wCharSpriteSetId] ; $4117
	ld de, $8000 ; $411a
	farcall LoadOnCourtCharTilesA ; $411d
	ld a, [wCharSpriteSetId] ; $4120
	ld de, $8040 ; $4123
	farcall LoadOnCourtCharTilesB ; $4126
	ret ; $4129
SpawnGameScoreDisplayObjs:
	wram_bank $04 ; $412a
	call ClearAllObjSlots ; $4130
	ld a, [wScoreboardLayout] ; $4133
	cp $03 ; $4136
	jr z, .doubles ; $4138
	ld a, [wCurrentServingPlayer] ; $413a
	cpl ; $413d
	and $01 ; $413e
	ld b, a ; $4140
	wram_bank $04 ; $4141
	ld a, [wCharCourtPos] ; $4147
	and $02 ; $414a
	or b ; $414c
	ld b, a ; $414d
	wram_bank $04 ; $414e
	push bc ; $4154
	ld a, b ; $4155
	ld hl, ObjTemplates_09 ; $4156
	ld bc, wObjSlot0 ; $4159
	call LoadObjTemplate_09 ; $415c
	call GetPlayer1CharIconSprites ; $415f
	call SetObjSpriteTemplate ; $4162
	pop bc ; $4165
	ld a, b ; $4166
	xor $03 ; $4167
	ld hl, ObjTemplates_09 ; $4169
	ld bc, wObjSlot1 ; $416c
	call LoadObjTemplate_09 ; $416f
	call GetPlayer2CharIconSprites ; $4172
	call SetObjSpriteTemplate ; $4175
	ld a, $00 ; $4178
	ld hl, SpawnGameScoreDisplayObjsObjTemplate ; $417a
	ld bc, wObjSlot2 ; $417d
	call LoadObjTemplate_09 ; $4180
	ret ; $4183
.doubles:
	ld a, $00 ; $4184
	ld hl, GameScoreDisplayObjsObjTemplate ; $4186
	ld bc, wObjSlot0 ; $4189
	call LoadObjTemplate_09 ; $418c
	ret ; $418f
DismissGameScoreDisplayObjs:
	ld a, [wDrillIsPracticeLesson] ; $4190
	and a ; $4193
	jr nz, .doubles ; $4194
	ld hl, ObjTemplates_09 ; $4196
	ld bc, wObjSlot0 ; $4199
	call StartObjExitAnim ; $419c
	ld hl, ObjTemplates_09 ; $419f
	ld bc, wObjSlot1 ; $41a2
	call StartObjExitAnim ; $41a5
	ld hl, SpawnGameScoreDisplayObjsObjTemplate ; $41a8
	ld bc, wObjSlot2 ; $41ab
	call StartObjExitAnim ; $41ae
	ret ; $41b1
.doubles:
	ld hl, GameScoreDisplayObjsObjTemplate ; $41b2
	ld bc, wObjSlot0 ; $41b5
	call StartObjExitAnim ; $41b8
	ret ; $41bb
ObjTemplates_09:
	; $41bc, 64 bytes (records:16)
; 4 records x 16 bytes
	dw $4c50, $0000, $4764, $0001, $4764, $0003, $0066, $0000 ; record 0
	dw $3450, $0000, $4764, $0000, $4764, $0002, $0066, $0000 ; record 1
	dw $4c30, $0000, $4764, $0001, $4764, $0003, $0066, $0000 ; record 2
	dw $3430, $0000, $4764, $0000, $4764, $0002, $0066, $0000 ; record 3
GameScoreDisplayObjsObjTemplate:
	; $41fc, 16 bytes (records:16)
; 1 records x 16 bytes
	dw $4040, $71f7, $4764, $0000, $4764, $0003, $0066, $0000 ; record 0
SpawnGameScoreDisplayObjsObjTemplate:
	; $420c, 32 bytes (records:16)
; 2 records x 16 bytes
	dw $4040, $7090, $4758, $0000, $475e, $0000, $0066, $0000 ; record 0
	dw $4050, $7090, $4764, $0000, $4764, $0002, $0066, $0000 ; record 1
SpawnGameResultObj:
	ld a, $01 ; $422c
	ld hl, SpawnGameScoreDisplayObjsObjTemplate ; $422e
	ld bc, wObjSlot2 ; $4231
	call LoadObjTemplate_09 ; $4234
	ret ; $4237
DismissGameResultObj:
	ld hl, SpawnGameScoreDisplayObjsObjTemplate ; $4238
	ld bc, wObjSlot2 ; $423b
	call StartObjExitAnim ; $423e
	ret ; $4241
SpawnServeIndicatorObjs:
	call ClearAllObjSlots ; $4242
	call SpawnServeIndicatorSideObj ; $4245
	ld a, [wServingCharCourtPos] ; $4248
	ld hl, ServeIndicatorObjTemplates_09 ; $424b
	ld bc, wObjSlot0 ; $424e
	call LoadObjTemplate_09 ; $4251
	call GetPlayer1ServeIndicatorSprites ; $4254
	call SetObjSpriteTemplate ; $4257
	ld a, [wScoreboardLayout] ; $425a
	cp $03 ; $425d
	jr z, .player2Indicator ; $425f
	ld a, [wServingCharCourtPos] ; $4261
	ld hl, ServeIndicatorObjTemplates_09 ; $4264
	ld bc, wObjSlot1 ; $4267
	call LoadObjTemplate_09 ; $426a
	call GetPlayer2ServeIndicatorSprites ; $426d
	call SetObjSpriteTemplate ; $4270
	ret ; $4273
.player2Indicator:
	ld a, [wServingCharCourtPos] ; $4274
	and $02 ; $4277
	ret nz ; $4279
	ld hl, wObjSlot0 + 7 ; $427a
	ld a, [hl] ; $427d
	add $10 ; $427e
	ld [hl], a ; $4280
	ret ; $4281
DismissServeIndicatorObjs:
	call DismissServeIndicatorSideObj ; $4282
	ld hl, ServeIndicatorObjTemplates_09 ; $4285
	ld bc, wObjSlot0 ; $4288
	call StartObjExitAnim ; $428b
	ld hl, ServeIndicatorObjTemplates_09 ; $428e
	ld bc, wObjSlot1 ; $4291
	call StartObjExitAnim ; $4294
	ret ; $4297
ServeIndicatorObjTemplates_09:
	; $4298, 64 bytes (records:16)
; 4 records x 16 bytes
	dw $0070, $0000, $4764, $0004, $4764, $0006, $0000, $0000 ; record 0
	dw $7070, $0000, $4764, $0005, $4764, $0007, $0000, $0000 ; record 1
	dw $0000, $0000, $4764, $0004, $4764, $0006, $0000, $0000 ; record 2
	dw $7000, $0000, $4764, $0005, $4764, $0007, $0000, $0000 ; record 3
SpawnWinLoseResultObj:
	push af ; $42d8
	ld a, $00 ; $42d9
	ld hl, WinLoseResultObjTemplate_09 ; $42db
	ld bc, wObjSlot0 ; $42de
	call LoadObjTemplate_09 ; $42e1
	pop af ; $42e4
	add a ; $42e5
	jr c, .player2 ; $42e6
	call GetPlayer1CharIconSprites ; $42e8
	call SetObjSpriteTemplate ; $42eb
	ret ; $42ee
.player2:
	call GetPlayer2CharIconSprites ; $42ef
	call SetObjSpriteTemplate ; $42f2
	ret ; $42f5
DismissWinLoseResultObj:
	ld hl, WinLoseResultObjTemplate_09 ; $42f6
	ld bc, wObjSlot0 ; $42f9
	call StartObjExitAnim ; $42fc
	ret ; $42ff
WinLoseResultObjTemplate_09:
	; $4300, 16 bytes (records:16)
; 1 records x 16 bytes
	dw $4050, $0000, $4764, $0000, $4764, $0002, $0000, $0000 ; record 0
SpawnServeIndicatorSideObj:
	ld a, [wServingCharCourtPos] ; $4310
	ld hl, ServeIndicatorSideObjTemplates_09 ; $4313
	ld bc, wObjSlot4 ; $4316
	call LoadObjTemplate_09 ; $4319
	ret ; $431c
DismissServeIndicatorSideObj:
	ld hl, ServeIndicatorSideObjTemplates_09 ; $431d
	ld bc, wObjSlot4 ; $4320
	call StartObjExitAnim ; $4323
	ret ; $4326
ServeIndicatorSideObjTemplates_09:
	; $4327, 64 bytes (records:16)
; 4 records x 16 bytes
	dw $f4d2, $7098, $4764, $0009, $4764, $000b, $0000, $0001 ; record 0
	dw $f4d2, $7098, $4764, $0008, $4764, $000a, $0000, $0001 ; record 1
	dw $f402, $7098, $4764, $0009, $4764, $000b, $0000, $0001 ; record 2
	dw $f402, $7098, $4764, $0008, $4764, $000a, $0000, $0001 ; record 3
ShowCourtBanner:
	push af ; $4367
	call ClearAllObjSlots ; $4368
	pop af ; $436b
	push af ; $436c
	call LoadTilesetGfx ; $436d
	pop af ; $4370
SpawnCourtBannerObj:
	ld hl, CourtBannerObjTemplates_09 ; $4371
	ld bc, wObjSlot3 ; $4374
	call LoadObjTemplate_09 ; $4377
	ret ; $437a
HideCourtBanner:
	ld hl, CourtBannerObjTemplates_09 ; $437b
	ld bc, wObjSlot3 ; $437e
	call StartObjExitAnim ; $4381
	ret ; $4384
CourtBannerObjTemplates_09:
	; $4385, 464 bytes (records:16)
; 29 records x 16 bytes
	dw $3038, $70a1, $4758, $0000, $475e, $0000, $0078, $0000 ; record 0
	dw $4440, $7090, $4764, $0000, $4764, $0003, $006a, $0000 ; record 1
	dw $3440, $7080, $4764, $0000, $4764, $0003, $006a, $0000 ; record 2
	dw $4440, $7094, $4764, $0000, $4764, $0003, $006c, $0000 ; record 3
	dw $4440, $7094, $4764, $0000, $4764, $0003, $006c, $0000 ; record 4
	dw $4440, $7094, $4764, $0000, $4764, $0003, $006c, $0000 ; record 5
	dw $4440, $708c, $4764, $0000, $4764, $0003, $006c, $0000 ; record 6
	dw $3440, $7084, $4764, $0001, $4764, $0002, $0068, $0000 ; record 7
	dw $3440, $7084, $4764, $0001, $4764, $0002, $0068, $0000 ; record 8
	dw $3440, $7084, $4764, $0001, $4764, $0002, $0068, $0000 ; record 9
	dw $3440, $7084, $4764, $0001, $4764, $0002, $0068, $0000 ; record 10
	dw $4040, $7090, $4764, $0001, $4764, $0003, $006b, $0000 ; record 11
	dw $4040, $7090, $4764, $0001, $4764, $0003, $006b, $0000 ; record 12
	dw $4040, $7090, $4764, $0001, $4764, $0003, $006b, $0000 ; record 13
	dw $4040, $7094, $4764, $000e, $4764, $0003, $0000, $0001 ; record 14
	dw $3038, $70a1, $4764, $0000, $4764, $0003, $0078, $0000 ; record 15
	dw $4040, $7090, $4764, $0000, $4764, $0003, $0000, $0000 ; record 16
	dw $4840, $7098, $4764, $0000, $4764, $0003, $0000, $0000 ; record 17
	dw $3444, $7084, $4764, $0000, $4764, $0003, $0042, $0000 ; record 18
	dw $3444, $7084, $4764, $0000, $4764, $0003, $0042, $0000 ; record 19
	dw $3444, $7084, $4764, $0000, $4764, $0003, $0042, $0000 ; record 20
	dw $3444, $7084, $4764, $0000, $4764, $0003, $0042, $0000 ; record 21
	dw $3444, $7084, $4764, $0000, $4764, $0003, $0043, $0000 ; record 22
	dw $3444, $7084, $4764, $0000, $4764, $0003, $0000, $0000 ; record 23
	dw $403c, $70e2, $4764, $0000, $4764, $0003, $0067, $0000 ; record 24
	dw $403c, $70e2, $4764, $0000, $4764, $0003, $0067, $0000 ; record 25
	dw $403c, $70e2, $4764, $0000, $4764, $0003, $0067, $0000 ; record 26
	dw $4840, $7098, $4764, $0000, $4764, $0003, $0067, $0000 ; record 27
	dw $403c, $70e2, $4764, $0000, $4764, $0003, $0067, $0000 ; record 28
InitAllObjSlots:
	wram_bank $04 ; $4555
	ld bc, wObjSlot0 ; $455b
	call InitObjSlot ; $455e
	ld bc, wObjSlot1 ; $4561
	call InitObjSlot ; $4564
	ld bc, wObjSlot2 ; $4567
	call InitObjSlot ; $456a
	ld d, $01 ; $456d
	call SetObjSpriteAttr ; $456f
	ld d, $30 ; $4572
	call SetObjTileOffset ; $4574
	ld bc, wObjSlot3 ; $4577
	call InitObjSlot ; $457a
	ld d, $01 ; $457d
	call SetObjSpriteAttr ; $457f
	ld d, $20 ; $4582
	call SetObjTileOffset ; $4584
	ld bc, wObjSlot4 ; $4587
	call InitObjSlot ; $458a
	ld d, $01 ; $458d
	call SetObjSpriteAttr ; $458f
	ld d, $38 ; $4592
	call SetObjTileOffset ; $4594
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
SetObjSpriteTemplate:
	ld hl, $0002 ; $45bc
	add hl, bc ; $45bf
	ld a, e ; $45c0
	ld [hl+], a ; $45c1
	ld [hl], d ; $45c2
	ret ; $45c3
SetObjPosition:
	ld hl, $0006 ; $45c4
	add hl, bc ; $45c7
	ld [hl], d ; $45c8
	inc hl ; $45c9
	ld [hl], e ; $45ca
	ret ; $45cb
SetObjTileOffset:
	ld hl, $0005 ; $45cc
	add hl, bc ; $45cf
	ld [hl], d ; $45d0
	ret ; $45d1
SetObjSpriteAttr:
	ld hl, $0004 ; $45d2
	add hl, bc ; $45d5
	ld [hl], d ; $45d6
	ret ; $45d7
SetObjUpdateRoutine:
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
SetObjMoveCurve:
	ld hl, $000e ; $45ec
	add hl, bc ; $45ef
	ld [hl], d ; $45f0
	ret ; $45f1
SetObjDrawMode:
	ld hl, $000f ; $45f2
	add hl, bc ; $45f5
	ld [hl], d ; $45f6
	ret ; $45f7
	ld hl, $000e ; $45f8
	add hl, bc ; $45fb
	ld a, [hl] ; $45fc
	xor $02 ; $45fd
	ld [hl], a ; $45ff
	ret ; $4600
	ld hl, $000e ; $4601
	add hl, bc ; $4604
	ld a, [hl] ; $4605
	xor $03 ; $4606
	ld [hl], a ; $4608
	ret ; $4609
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
	call SetObjPosition ; $461f
	pop hl ; $4622
	ld a, [hl+] ; $4623
	ld e, a ; $4624
	ld a, [hl+] ; $4625
	ld d, a ; $4626
	push hl ; $4627
	call SetObjSpriteTemplate ; $4628
	pop hl ; $462b
	ld a, [hl+] ; $462c
	ld e, a ; $462d
	ld a, [hl+] ; $462e
	ld d, a ; $462f
	push hl ; $4630
	call SetObjUpdateRoutine ; $4631
	pop hl ; $4634
	ld d, [hl] ; $4635
	call SetObjMoveCurve ; $4636
	pop hl ; $4639
	ld de, $000c ; $463a
	add hl, de ; $463d
	ld a, [hl+] ; $463e
	inc hl ; $463f
	and a ; $4640
	jr z, .setDrawMode ; $4641
	call PlaySoundManaged ; $4643
.setDrawMode:
	ld d, [hl] ; $4646
	call SetObjDrawMode ; $4647
	xor a ; $464a
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
	add c ; $465a
	ld e, a ; $465b
	ld d, b ; $465c
	ld a, [de] ; $465d
	bit 7, a ; $465e
	ret z ; $4660
	res 7, a ; $4661
	ld [de], a ; $4663
	ld a, $00 ; $4664
	add c ; $4666
	ld e, a ; $4667
	ld d, b ; $4668
	ld a, [de] ; $4669
	add a ; $466a
	add a ; $466b
	add a ; $466c
	add a ; $466d
	add $08 ; $466e
	add l ; $4670
	ld l, a ; $4671
	jr nc, .readEntry ; $4672
	inc h ; $4674
.readEntry:
	ld a, [hl+] ; $4675
	ld e, a ; $4676
	ld a, [hl+] ; $4677
	ld d, a ; $4678
	push hl ; $4679
	call SetObjUpdateRoutine ; $467a
	pop hl ; $467d
	ld d, [hl] ; $467e
	call SetObjMoveCurve ; $467f
	ret ; $4682
ClearAllObjSlots:
	ld a, $ff ; $4683
	ld [wObjSlot0], a ; $4685
	ld [wObjSlot1], a ; $4688
	ld [wObjSlot2], a ; $468b
	ld [wObjSlot3], a ; $468e
	ld [wObjSlot4], a ; $4691
	ret ; $4694
UpdateAllObjSprites:
	ld bc, wObjSlot0 ; $4695
	call ProcessObjSlot ; $4698
	ld bc, wObjSlot1 ; $469b
	call ProcessObjSlot ; $469e
	ld bc, wObjSlot2 ; $46a1
	call ProcessObjSlot ; $46a4
	ld bc, wObjSlot3 ; $46a7
	call ProcessObjSlot ; $46aa
	ld bc, wObjSlot4 ; $46ad
	call ProcessObjSlot ; $46b0
	ret ; $46b3
	ret ; $46b4
; Runs one match object slot. It copies the slot into wObjSlotWork, pushes
; DrawObjSlot as the return address and `jp`s to the slot's handler at +$08;
; FinishObjSlotUpdate then copies the working record back.
;
; That indirection is why every handler addresses one fixed record instead of
; indexing bc, and why the subsystem reads as a pile of absolute addresses. A
; slot whose +$00 is $ff is free.
ProcessObjSlot:
	ld hl, $0000 ; $46b5
	add hl, bc ; $46b8
	ld a, [hl] ; $46b9
	cp $ff ; $46ba
	ret z ; $46bc
	ld l, c ; $46bd
	ld h, b ; $46be
	push hl ; $46bf
	ld de, wObjSlotWork ; $46c0
	ld c, $01 ; $46c3
	call CopyMemoryFast ; $46c5
	ld hl, DrawObjSlot ; $46c8
	push hl ; $46cb
	ld hl, wObjSlotWork + 8 ; $46cc
	ld a, [hl+] ; $46cf
	ld h, [hl] ; $46d0
	ld l, a ; $46d1
	jp hl ; $46d2
DrawObjSlot:
	ld hl, FinishObjSlotUpdate ; $46d3
	push hl ; $46d6
	ld a, [wObjSlotWork + 15] ; $46d7
	and a ; $46da
	jr z, FinishObjSlotUpdate.drawAtOffset ; $46db
	cp $01 ; $46dd
	jr z, FinishObjSlotUpdate.drawOnServer ; $46df
; Tail of every object-slot handler: steps the curve counter and copies
; wObjSlotWork back to the slot ProcessObjSlot pushed.
;
; Its two entry points are the draw paths, chosen by the record's anchor byte:
; .drawAtOffset uses the stored X/Y as they stand, .drawOnServer adds the
; serving character's wCharScreenX/Y first.
FinishObjSlotUpdate:
	ld hl, wObjSlotWork + 13 ; $46e1
	ld a, [hl] ; $46e4
	inc [hl] ; $46e5
	pop de ; $46e6
	ld hl, wObjSlotWork ; $46e7
	ld c, $01 ; $46ea
	call CopyMemoryFast ; $46ec
	ret ; $46ef
.drawAtOffset:
	ld hl, wObjSlotWork + 1 ; $46f0
	bit 0, [hl] ; $46f3
	ret z ; $46f5
	ld hl, wObjSlotWork + 6 ; $46f6
	ld a, [wObjSlotWork + 10] ; $46f9
	add [hl] ; $46fc
	ld d, a ; $46fd
	ld hl, wObjSlotWork + 7 ; $46fe
	ld a, [wObjSlotWork + 11] ; $4701
	add [hl] ; $4704
	ld e, a ; $4705
	ld a, [wObjSlotWork + 4] ; $4706
	ld b, a ; $4709
	ld a, [wObjSlotWork + 5] ; $470a
	ld c, a ; $470d
	ld hl, wObjSlotWork + 2 ; $470e
	ld a, [hl+] ; $4711
	ld h, [hl] ; $4712
	ld l, a ; $4713
	call QueueSpriteTemplate ; $4714
	ret ; $4717
.drawOnServer:
	ld hl, wObjSlotWork + 1 ; $4718
	bit 0, [hl] ; $471b
	ret z ; $471d
	farcall FindServerCharBank ; $471e
	ld a, b ; $4721
	wram_bank ; $4722
	ld a, [wCharScreenX] ; $4726
	ld d, a ; $4729
	ld a, [wCharScreenY] ; $472a
	ld e, a ; $472d
	wram_bank $04 ; $472e
	ld a, [wObjSlotWork + 10] ; $4734
	ld hl, wObjSlotWork + 6 ; $4737
	add [hl] ; $473a
	add d ; $473b
	ld d, a ; $473c
	ld a, [wObjSlotWork + 11] ; $473d
	ld hl, wObjSlotWork + 7 ; $4740
	add [hl] ; $4743
	add e ; $4744
	ld e, a ; $4745
	ld a, [wObjSlotWork + 4] ; $4746
	ld b, a ; $4749
	ld a, [wObjSlotWork + 5] ; $474a
	ld c, a ; $474d
	ld hl, wObjSlotWork + 2 ; $474e
	ld a, [hl+] ; $4751
	ld h, [hl] ; $4752
	ld l, a ; $4753
	call QueueSpriteTemplate ; $4754
	ret ; $4757
	ld hl, wObjSlotWork + 1 ; $4758
	set 0, [hl] ; $475b
	ret ; $475d
	ld hl, wObjSlotWork + 1 ; $475e
	res 0, [hl] ; $4761
	ret ; $4763
	ld a, [wObjSlotWork + 12] ; $4764
	rst Rst00 ; $4767
	dw FinishObjSlotUpdate.stepCurve ; $4768 jumptable
	dw FinishObjSlotUpdate.done ; $476a jumptable
.stepCurve:
	ld hl, wObjSlotWork + 1 ; $476c
	set 0, [hl] ; $476f
	call GetNextMoveCurveValue ; $4771
	jp z, .advanceState ; $4774
	ret ; $4777
	ld hl, wObjSlotWork + 1 ; $4778
	res 0, [hl] ; $477b
.advanceState:
	ld hl, wObjSlotWork + 12 ; $477d
	inc [hl] ; $4780
.done:
	ret ; $4781
; Advances an object along its move curve. wObjSlotWork + 14 selects the curve
; in MoveCurveTable_09 and + 13 is the step within it. Two terminators: $80
; holds the object where it is, $81 ends the sequence and frees the slot by
; writing $ff to the record's +$00. Returns nz while the curve is still
; producing values.
GetNextMoveCurveValue:
	ld a, [wObjSlotWork + 14] ; $4782
	add a ; $4785
	add LOW(MoveCurveTable_09) ; $4786
	ld l, a ; $4788
	adc HIGH(MoveCurveTable_09) ; $4789
	sub l ; $478b
	ld h, a ; $478c
	ld a, [hl+] ; $478d
	ld h, [hl] ; $478e
	ld l, a ; $478f
	ld a, [wObjSlotWork + 13] ; $4790
	add l ; $4793
	ld l, a ; $4794
	jr nc, .readValue ; $4795
	inc h ; $4797
.readValue:
	ld a, [hl] ; $4798
	cp $80 ; $4799
	jr z, .done ; $479b
	cp $81 ; $479d
	jr z, .markFinished ; $479f
	ld [wObjSlotWork + 10], a ; $47a1
	xor a ; $47a4
	inc a ; $47a5
	ret ; $47a6
.markFinished:
	ld a, $ff ; $47a7
	ld [wObjSlotWork], a ; $47a9
.done:
	xor a ; $47ac
	ret ; $47ad
MoveCurveTable_09:
	INCBIN "data/bank_009/d_47ae.bin" ; $47ae, 197 bytes
LoadTilesetGfx:
	add a ; $4873
	add a ; $4874
	add LOW(VramTileset_09) ; $4875
	ld l, a ; $4877
	adc HIGH(VramTileset_09) ; $4878
	sub l ; $487a
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
	ld hl, VramGfxPtrTable_09 ; $6100
	call GetGfxSourcePtr ; $6103
	ld c, $04 ; $6106
	call QueueVRAMCopy ; $6108
	ret ; $610b
LoadPlayer1PointsDigitGfx:
	ld hl, VramGfxPtrTable_09 ; $610c
	call GetGfxSourcePtr ; $610f
	ld de, $8780 ; $6112
	ld c, $04 ; $6115
	call QueueVRAMCopy ; $6117
	ret ; $611a
LoadPlayer2PointsDigitGfx:
	ld hl, VramGfxPtrTable_09 ; $611b
	call GetGfxSourcePtr ; $611e
	ld de, $87c0 ; $6121
	ld c, $04 ; $6124
	call QueueVRAMCopy ; $6126
	ret ; $6129
LoadPlayer1ScoreDigitGfx:
	ld hl, Player1ScoreDigitGfxSource ; $612a
	call GetGfxSourcePtr ; $612d
	ld de, $8300 ; $6130
	ld c, $04 ; $6133
	call QueueVRAMCopy ; $6135
	ret ; $6138
LoadPlayer2ScoreDigitGfx:
	ld hl, LoadPlayer2ScoreDigitGfxTable ; $6139
	call GetGfxSourcePtr ; $613c
	ld de, $8340 ; $613f
	ld c, $04 ; $6142
	call QueueVRAMCopy ; $6144
	ret ; $6147
LoadDeuceAdvantageGfx:
	ld hl, DeuceAdvantageTiles ; $6148
	ld de, $8300 ; $614b
	ld c, (LoadServeGfx - DeuceAdvantageTiles) / 16 ; $614e
	call QueueVRAMCopy ; $6150
	ret ; $6153
GetGfxSourcePtr:
	push af ; $6154
	ld a, b ; $6155
	add a ; $6156
	add l ; $6157
	ld l, a ; $6158
	jr nc, .read ; $6159
	inc h ; $615b
.read:
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
VramGfxPtrTable_09:
	INCBIN "data/bank_009/d_616d.bin" ; $616d, 4 bytes
Player1ScoreDigitGfxSource:
	INCBIN "data/bank_009/d_6171.bin" ; $6171, 4 bytes
LoadPlayer2ScoreDigitGfxTable:
	INCBIN "data/bank_009/d_6175.bin" ; $6175, 2635 bytes
DeuceAdvantageTiles:
	INCBIN "data/bank_009/d_6bc0.bin" ; $6bc0, 128 bytes
LoadServeGfx:
	ld a, [wCurrentServingPlayer] ; $6c40
	add a ; $6c43
	add LOW(ServeGfxPtrTable_09) ; $6c44
	ld l, a ; $6c46
	adc HIGH(ServeGfxPtrTable_09) ; $6c47
	sub l ; $6c49
	ld h, a ; $6c4a
	ld a, [hl+] ; $6c4b
	ld h, [hl] ; $6c4c
	ld l, a ; $6c4d
	ld a, [wServeFaultFlag] ; $6c4e
	and $01 ; $6c51
	ld b, a ; $6c53
	ld a, [wServingCharCourtPos] ; $6c54
	and $02 ; $6c57
	or b ; $6c59
	add a ; $6c5a
	add a ; $6c5b
	add a ; $6c5c
	add a ; $6c5d
	add a ; $6c5e
	add a ; $6c5f
	add l ; $6c60
	ld l, a ; $6c61
	jr nc, .queue ; $6c62
	inc h ; $6c64
.queue:
	ld de, $8380 ; $6c65
	ld c, $04 ; $6c68
	call QueueVRAMCopy ; $6c6a
	ret ; $6c6d
ServeGfxPtrTable_09:
	INCBIN "data/bank_009/d_6c6e.bin" ; $6c6e, 1173 bytes
GetPlayer1ServeIndicatorSprites:
	ld a, [wOnCourtCharCountMinus1] ; $7103
	add a ; $7106
	add LOW(Player1ServeIndicatorSpritePtrs_09) ; $7107
	ld l, a ; $7109
	adc HIGH(Player1ServeIndicatorSpritePtrs_09) ; $710a
	sub l ; $710c
	ld h, a ; $710d
	ld a, [hl+] ; $710e
	ld d, [hl] ; $710f
	ld e, a ; $7110
	ret ; $7111
Player1ServeIndicatorSpritePtrs_09:
	; $7112, 8 bytes (records:2)
	dw Player1ServeIndicatorSpriteTemplate0_09 ; record 0
	dw Player1ServeIndicatorSpriteTemplate0_09 ; record 1
	dw Player1ServeIndicatorSpriteTemplate0_09 ; record 2
	dw Player1ServeIndicatorSpriteTemplate1_09 ; record 3
GetPlayer2ServeIndicatorSprites:
	ld a, [wOnCourtCharCountMinus1] ; $711a
	add a ; $711d
	add LOW(Player2ServeIndicatorSpritePtrs_09) ; $711e
	ld l, a ; $7120
	adc HIGH(Player2ServeIndicatorSpritePtrs_09) ; $7121
	sub l ; $7123
	ld h, a ; $7124
	ld a, [hl+] ; $7125
	ld d, [hl] ; $7126
	ld e, a ; $7127
	ret ; $7128
Player2ServeIndicatorSpritePtrs_09:
	; $7129, 8 bytes (records:2)
	dw Player2ServeIndicatorSpriteTemplate0_09 ; record 0
	dw Player2ServeIndicatorSpriteTemplate0_09 ; record 1
	dw Player2ServeIndicatorSpriteTemplate1_09 ; record 2
	dw Player2ServeIndicatorSpriteTemplate1_09 ; record 3
Player1ServeIndicatorSpriteTemplate0_09:
	; $7131, 25 bytes (sprite_template)
	oam_sprite $10, $08, $14, $00
	oam_sprite $10, $10, $04, $04
	oam_sprite $10, $18, $06, $04
	oam_sprite $10, $20, $14, $00
	oam_sprite $10, $28, $78, $01
	oam_sprite $10, $30, $7a, $01
	oam_sprite_end
Player1ServeIndicatorSpriteTemplate1_09:
	; $714a, 25 bytes (sprite_template)
	oam_sprite $10, $08, $04, $04
	oam_sprite $10, $10, $06, $04
	oam_sprite $10, $18, $14, $06
	oam_sprite $10, $20, $16, $06
	oam_sprite $10, $28, $78, $01
	oam_sprite $10, $30, $7a, $01
	oam_sprite_end
Player2ServeIndicatorSpriteTemplate0_09:
	; $7163, 25 bytes (sprite_template)
	oam_sprite $20, $08, $14, $00
	oam_sprite $20, $10, $0c, $05
	oam_sprite $20, $18, $0e, $05
	oam_sprite $20, $20, $14, $00
	oam_sprite $20, $28, $7c, $01
	oam_sprite $20, $30, $7e, $01
	oam_sprite_end
Player2ServeIndicatorSpriteTemplate1_09:
	; $717c, 25 bytes (sprite_template)
	oam_sprite $20, $08, $0c, $05
	oam_sprite $20, $10, $0e, $05
	oam_sprite $20, $18, $1c, $07
	oam_sprite $20, $20, $1e, $07
	oam_sprite $20, $28, $7c, $01
	oam_sprite $20, $30, $7e, $01
	oam_sprite_end
GetPlayer1CharIconSprites:
	ld a, [wOnCourtCharCountMinus1] ; $7195
	add a ; $7198
	add LOW(Player1CharIconSpritePtrs_09) ; $7199
	ld l, a ; $719b
	adc HIGH(Player1CharIconSpritePtrs_09) ; $719c
	sub l ; $719e
	ld h, a ; $719f
	ld a, [hl+] ; $71a0
	ld d, [hl] ; $71a1
	ld e, a ; $71a2
	ret ; $71a3
Player1CharIconSpritePtrs_09:
	; $71a4, 8 bytes (records:2)
	dw Player1CharIconSpriteTemplate0_09 ; record 0
	dw Player1CharIconSpriteTemplate0_09 ; record 1
	dw Player1CharIconSpriteTemplate0_09 ; record 2
	dw Player1CharIconSpriteTemplate1_09 ; record 3
GetPlayer2CharIconSprites:
	ld a, [wOnCourtCharCountMinus1] ; $71ac
	add a ; $71af
	add LOW(Player2CharIconSpritePtrs_09) ; $71b0
	ld l, a ; $71b2
	adc HIGH(Player2CharIconSpritePtrs_09) ; $71b3
	sub l ; $71b5
	ld h, a ; $71b6
	ld a, [hl+] ; $71b7
	ld d, [hl] ; $71b8
	ld e, a ; $71b9
	ret ; $71ba
Player2CharIconSpritePtrs_09:
	; $71bb, 8 bytes (records:2)
	dw Player2CharIconSpriteTemplate0_09 ; record 0
	dw Player2CharIconSpriteTemplate0_09 ; record 1
	dw Player2CharIconSpriteTemplate1_09 ; record 2
	dw Player2CharIconSpriteTemplate1_09 ; record 3
Player1CharIconSpriteTemplate0_09:
	; $71c3, 9 bytes (sprite_template)
	oam_sprite $10, $10, $00, $04
	oam_sprite $10, $18, $02, $04
	oam_sprite_end
Player1CharIconSpriteTemplate1_09:
	; $71cc, 17 bytes (sprite_template)
	oam_sprite $10, $08, $00, $04
	oam_sprite $10, $10, $02, $04
	oam_sprite $10, $18, $10, $06
	oam_sprite $10, $20, $12, $06
	oam_sprite_end
Player2CharIconSpriteTemplate0_09:
	; $71dd, 9 bytes (sprite_template)
	oam_sprite $10, $10, $08, $05
	oam_sprite $10, $18, $0a, $05
	oam_sprite_end
Player2CharIconSpriteTemplate1_09:
	; $71e6, 17 bytes (sprite_template)
	oam_sprite $10, $08, $08, $05
	oam_sprite $10, $10, $0a, $05
	oam_sprite $10, $18, $18, $07
	oam_sprite $10, $20, $1a, $07
	oam_sprite_end
SpriteTemplate_09_8:
	; $71f7, 33 bytes (sprite_template)
	oam_sprite $08, $18, $00, $04
	oam_sprite $08, $20, $02, $04
	oam_sprite $18, $08, $28, $09
	oam_sprite $18, $10, $2a, $09
	oam_sprite $18, $18, $2c, $09
	oam_sprite $18, $20, $2e, $09
	oam_sprite $18, $28, $78, $01
	oam_sprite $18, $30, $7a, $01
	oam_sprite_end
	; $7218, 3560 bytes fill to bank end (linker-padded)

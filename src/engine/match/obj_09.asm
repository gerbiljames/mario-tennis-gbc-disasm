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
	ld de, vTiles0 + $14 * TILE_SIZE ; $40b7
	farcall LoadOnCourtCharTilesB ; $40ba
	ld a, [wOnCourtCharCountMinus1] ; $40bd
	rst Rst00 ; $40c0
	dw LoadOnCourtCharacterGfx.done ; $40c1 jumptable
	dw LoadOnCourtCharacterGfx.char4 ; $40c3 jumptable
	dw LoadOnCourtCharacterGfx.char3 ; $40c5 jumptable
	dw LoadOnCourtCharacterGfx.char2 ; $40c7 jumptable
.char2:
	wram_bank WRAM_CHAR2 ; $40c9
	ld a, [wCharSpriteSetId] ; $40cf
	ld de, vTiles0 + $10 * TILE_SIZE ; $40d2
	farcall LoadOnCourtCharTilesA ; $40d5
	ld a, [wCharSpriteSetId] ; $40d8
	ld de, vTiles0 + $14 * TILE_SIZE ; $40db
	farcall LoadOnCourtCharTilesB ; $40de
.char3:
	wram_bank WRAM_CHAR3 ; $40e1
	ld a, [wCharSpriteSetId] ; $40e7
	ld de, vTiles0 + $18 * TILE_SIZE ; $40ea
	farcall LoadOnCourtCharTilesA ; $40ed
	ld a, [wCharSpriteSetId] ; $40f0
	ld de, vTiles0 + $1c * TILE_SIZE ; $40f3
	farcall LoadOnCourtCharTilesB ; $40f6
.char4:
	wram_bank WRAM_CHAR1 ; $40f9
	ld a, [wCharSpriteSetId] ; $40ff
	ld de, vTiles0 + $08 * TILE_SIZE ; $4102
	farcall LoadOnCourtCharTilesA ; $4105
	ld a, [wCharSpriteSetId] ; $4108
	ld de, vTiles0 + $0c * TILE_SIZE ; $410b
	farcall LoadOnCourtCharTilesB ; $410e
.done:
	wram_bank WRAM_CHAR0 ; $4111
	ld a, [wCharSpriteSetId] ; $4117
	ld de, vTiles0 ; $411a
	farcall LoadOnCourtCharTilesA ; $411d
	ld a, [wCharSpriteSetId] ; $4120
	ld de, vTiles0 + $04 * TILE_SIZE ; $4123
	farcall LoadOnCourtCharTilesB ; $4126
	ret ; $4129
SpawnGameScoreDisplayObjs:
	wram_bank WRAM_ACTORS ; $412a
	call ClearAllObjSlots ; $4130
	ld a, [wScoreboardLayout] ; $4133
	cp $03 ; $4136
	jr z, .doubles ; $4138
	ld a, [wCurrentServingPlayer] ; $413a
	cpl ; $413d
	and $01 ; $413e
	ld b, a ; $4140
	wram_bank WRAM_CHAR0 ; $4141
	ld a, [wCharCourtPos] ; $4147
	and $02 ; $414a
	or b ; $414c
	ld b, a ; $414d
	wram_bank WRAM_ACTORS ; $414e
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
	wram_bank WRAM_ACTORS ; $4555
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
	ld de, FinishObjSlotUpdate.done ; $45a5
	ld a, e ; $45a8
	ld [hl+], a ; $45a9
	ld [hl], d ; $45aa
	ld hl, $0002 ; $45ab
	add hl, bc ; $45ae
	ld de, ObjSlotSpriteTemplate_09 ; $45af
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
UnusedToggleObjMoveCurveBits_1:
	ld hl, $000e ; $45f8
	add hl, bc ; $45fb
	ld a, [hl] ; $45fc
	xor $02 ; $45fd
	ld [hl], a ; $45ff
	ret ; $4600
UnusedToggleObjMoveCurveBits_2:
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
	wram_bank WRAM_ACTORS ; $472e
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

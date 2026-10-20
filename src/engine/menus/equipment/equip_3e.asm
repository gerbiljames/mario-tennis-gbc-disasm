OwnedShoeFlags_3e:
	; $57f2, 2 bytes (flag numbers, for TestGameFlagByNumber)
	db FLAG_HAVE_IRON_SHOES, FLAG_HAVE_LIGHT_SHOES ; 0x00
LoadEquipSelectCommon:
	farcall ResetTextWindowState ; $57f4
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $57f7
	ld c, SharedMenuGfx17_SIZE / 16 ; $57f9
	ld de, vTiles2 ; $57fb
	farcall LoadCompressedTileBlock ; $57fe
	wram_bank WRAM_TEXT ; $5801
	call CreateEquipCaptionWindow ; $5807
	call CreateEquipListWindow ; $580a
	ld de, vTiles0 + VRAM_BANK1 ; $580d
	farcall LoadCornerBracketCursorGfx ; $5810
	ret ; $5813
CreateEquipListWindow:
	rect_cell $00, $04 ; $5814
	rect_size $14, $09 ; $5818
	farcall CreateWindowFromScreenRect ; $581c
	farcall DrawTextWindowFrame ; $581f
	farcall RedrawWindowRows ; $5822
	wram_bank WRAM_SCREEN ; $5825
	ld de, wShadowAttrmap + 7 * TILEMAP_WIDTH + 1 ; $582b
	rect_size $12, $05 ; $582e
	ld h, $08 ; $5832
	farcall FillTilemapRect ; $5834
	ret ; $5837
CreateEquipCaptionWindow:
	ld a, WRAM_SCREEN ; $5838
	ld [wShadowTilemapBank], a ; $583a
	ld a, $00 ; $583d
	ld [wWindowTileAttr], a ; $583f
	rect_cell $00, $0d ; $5842
	rect_size $14, $05 ; $5846
	farcall CreateWindowFromScreenRect ; $584a
	farcall DrawTextWindowFrame ; $584d
	farcall RedrawWindowRows ; $5850
	ret ; $5853
ClearEquipSelectTextRows:
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH ; $5854
	rect_size $14, $01 ; $5857
	ld h, $03 ; $585b
	farcall FillTilemapRect ; $585d
	ld a, $02 ; $5860
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH], a ; $5862
	ld a, $04 ; $5865
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH + 19], a ; $5867
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 1 ; $586a
	rect_size $12, $03 ; $586d
	ld h, $20 ; $5871
	farcall FillTilemapRect ; $5873
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH ; $5876
	rect_size $14, $01 ; $5879
	ld h, $03 ; $587d
	farcall FillTilemapRect ; $587f
	ld a, $02 ; $5882
	ld [wShadowTilemap + 4 * TILEMAP_WIDTH], a ; $5884
	ld a, $04 ; $5887
	ld [wShadowTilemap + 4 * TILEMAP_WIDTH + 19], a ; $5889
	ld de, wShadowTilemap + 5 * TILEMAP_WIDTH + 1 ; $588c
	rect_size $12, $07 ; $588f
	ld h, $20 ; $5893
	farcall FillTilemapRect ; $5895
	ret ; $5898
FlushEquipSelectTextRows:
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH ; $5899
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH ; $589c
	ld c, 8 * TILEMAP_WIDTH / 16 ; $589f
	call QueueVRAMCopy ; $58a1
	ld hl, wShadowTilemap + 13 * TILEMAP_WIDTH ; $58a4
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH ; $58a7
	ld c, 4 * TILEMAP_WIDTH / 16 ; $58aa
	call QueueVRAMCopy ; $58ac
	ld hl, wShadowAttrmap + 5 * TILEMAP_WIDTH ; $58af
	ld de, vBGMap0 + 5 * TILEMAP_WIDTH + VRAM_BANK1 ; $58b2
	ld c, 2 * TILEMAP_WIDTH / 16 ; $58b5
	call QueueVRAMCopy ; $58b7
	ret ; $58ba
; GetItemStatModListPtr over lists of stat-change text ids in place of the stat-mod lists: the same two-level pointer lookup. Nothing calls it.
Unused_3e_GetItemStatModTextListPtr:
	push af ; $58bb
	push bc ; $58bc
	ld hl, ItemStatModTextListPtrPtrs_3e ; $58bd
	ld a, [wEquipItemKind] ; $58c0
	ASSERT EQUIPKIND_RACKETS == 0
	or a ; $58c3
	jr z, .readEntry ; $58c4
	ld hl, ItemStatModTextListPtrTable_3e ; $58c6
.readEntry:
	ld a, b ; $58c9
	add a ; $58ca
	add_hl_a ; $58cb
	ld a, [hl+] ; $58d0
	ld h, [hl] ; $58d1
	ld l, a ; $58d2
	pop bc ; $58d3
	pop af ; $58d4
	ret ; $58d5
ItemStatModTextListPtrPtrs_3e:
	; $58d6, 14 bytes (records:2)
	dw NormalItemStatModTexts_3e ; record 0
	dw LargeRacketStatModTexts_3e ; record 1
	dw SmallRacketStatModTexts_3e ; record 2
	dw IronRacketStatModTexts_3e ; record 3
	dw GoldRacketStatModTexts_3e ; record 4
	dw SilverRacketStatModTexts_3e ; record 5
	dw DriveRacketStatModTexts_3e ; record 6
ItemStatModTextListPtrTable_3e:
	; $58e4, 6 bytes (records:2)
	dw NormalItemStatModTexts_3e ; record 0
	dw IronShoesStatModTexts_3e ; record 1
	dw LightShoesStatModTexts_3e ; record 2
NormalItemStatModTexts_3e:
	; $58ea, 8 bytes (text_ids)
	dw $ffff ; blank row
	dw $ffff ; blank row
	dw Text_StatModNone
	dw 0
LargeRacketStatModTexts_3e:
	; $58f2, 12 bytes (text_ids)
	dw Text_StatModServeMinus1
	dw Text_StatModStrokeMinus1
	dw Text_StatModSpinMinus2
	dw Text_StatModAnglePlus2
	dw Text_StatModControlPlus1
	dw 0
SmallRacketStatModTexts_3e:
	; $58fe, 12 bytes (text_ids)
	dw Text_StatModServePlus2
	dw Text_StatModStrokePlus1
	dw Text_StatModSpinPlus1
	dw Text_StatModAngleMinus2
	dw Text_StatModControlMinus2
	dw 0
IronRacketStatModTexts_3e:
	; $590a, 12 bytes (text_ids)
	dw Text_StatModServeMinus2
	dw Text_StatModStrokeMinus2
	dw Text_StatModVolleyMinus2
	dw $ffff ; blank row
	dw Text_StatModExpBonus
	dw 0
SilverRacketStatModTexts_3e:
	; $5916, 12 bytes (text_ids)
	dw Text_StatModServeMinus1
	dw Text_StatModStrokeMinus1
	dw Text_StatModVolleyPlus3
	dw Text_StatModAnglePlus1
	dw Text_StatModControlPlus1
	dw 0
GoldRacketStatModTexts_3e:
	; $5922, 10 bytes (text_ids)
	dw Text_StatModServePlus2
	dw Text_StatModStrokePlus2
	dw Text_StatModVolleyMinus1
	dw Text_StatModAngleMinus1
	dw 0
DriveRacketStatModTexts_3e:
	; $592c, 8 bytes (text_ids)
	dw Text_StatModServeMinus2
	dw Text_StatModTopSpinPlus3
	dw Text_StatModStrokeMinus2
	dw 0
IronShoesStatModTexts_3e:
	; $5934, 12 bytes (text_ids)
	dw Text_StatModSpeedMinus2
	dw Text_StatModDashMinus2
	dw Text_StatModReactionMinus2
	dw Text_StatModExpBonus
	dw Text_StatModExpBonus
	dw 0
LightShoesStatModTexts_3e:
	; $5940, 10 bytes (text_ids)
	dw Text_StatModSpeedPlus2
	dw Text_StatModDashPlus2
	dw Text_StatModReactionMinus2
	dw Text_StatModExpBonus
	dw 0
GetHoveredItemId:
	push bc ; $594a
	push hl ; $594b
	ld a, [wEquipItemCount] ; $594c
	ld c, a ; $594f
	call GetMenuCursorIndex_3e ; $5950
	ld hl, wEquipItemList ; $5953
	add_hl_a ; $5956
	ld a, [hl] ; $595b
	pop hl ; $595c
	pop bc ; $595d
	ret ; $595e
GetEquippedItemId:
	push hl ; $595f
	ld a, [wEquipEquippedIndex] ; $5960
	ld hl, wEquipItemList ; $5963
	add_hl_a ; $5966
	ld a, [hl] ; $596b
	pop hl ; $596c
	ret ; $596d
DrawEquippedItemStatMods:
	push af ; $596e
	push bc ; $596f
	push de ; $5970
	push hl ; $5971
	push_wram_bank WRAM_SCREEN ; $5972
	call GetEquippedItemId ; $597b
	jp DrawHoveredItemStatMods.drawItemStatModList ; $597e
DrawHoveredItemStatMods:
	push af ; $5981
	push bc ; $5982
	push de ; $5983
	push hl ; $5984
	push_wram_bank WRAM_SCREEN ; $5985
	call GetHoveredItemId ; $598e
.drawItemStatModList:
	call DrawItemStatModList ; $5991
	pop_wram_bank ; $5994
	pop hl ; $5999
	pop de ; $599a
	pop bc ; $599b
	pop af ; $599c
	ret ; $599d
RenderShoesDescText:
	ld hl, Text_ShoesNormalDesc ; $599e
	jp RenderRacketDescText.addTextIndex ; $59a1
RenderRacketDescText:
	ld hl, Text_RacketNormalDesc ; $59a4
.addTextIndex:
	ld a, c ; $59a7
	add_hl_a ; $59a8
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 1 ; $59ad
	ld c, $12 ; $59b0
	push hl ; $59b2
	farcall RenderProportionalTextAt ; $59b3
	pop hl ; $59b6
	ret ; $59b7
RenderShoesNameText:
	ld hl, Text_ShoesNormal ; $59b8
	jp RenderRacketNameText.addTextIndex ; $59bb
RenderRacketNameText:
	ld hl, Text_RacketNormal ; $59be
.addTextIndex:
	ld a, c ; $59c1
	add_hl_a ; $59c2
	ld c, $12 ; $59c7
	farcall RenderProportionalTextAt ; $59c9
	ret ; $59cc
EquipListCursorSpriteTask:
	ld c, $07 ; $59cd
	call GetMenuCursorIndex_3e ; $59cf
	ld hl, EquipListCursorYPositions_3e ; $59d2
	add_hl_a ; $59d5
	ld d, [hl] ; $59da
	ld e, $06 ; $59db
	ld b, $10 ; $59dd
	ld c, $0e ; $59df
	call DrawSelectionBoxCorners ; $59e1
	ret ; $59e4
EquipListCursorYPositions_3e:
	; $59e5, 6 bytes (bytes:6)
	db $38, $48, $58, $68, $78, $88 ; 0x00
EquippedItemMarkerSpriteTask:
	push_wram_bank WRAM_SCREEN ; $59eb
	ld a, [wEquipEquippedIndex] ; $59f4
	ld hl, EquippedMarkerYPositions_3e ; $59f7
	add_hl_a ; $59fa
	ld d, [hl] ; $59ff
	ld e, $18 ; $5a00
	sprite_attr_tile OAM_BANK1 | 1, $20 ; $5a02
	call QueueSprite ; $5a06
	pop_wram_bank ; $5a09
	ret ; $5a0e
EquippedMarkerYPositions_3e:
	; $5a0f, 6 bytes (bytes:6)
	db $41, $51, $61, $71, $81, $91 ; 0x00
DrawItemStatModList:
	ld b, a ; $5a15
	call GetItemStatModListPtr ; $5a16
	ld b, $00 ; $5a19
.loop:
	ld d, [hl] ; $5a1b
	inc hl ; $5a1c
	ld c, [hl] ; $5a1d
	inc hl ; $5a1e
	call DrawStatModEntry ; $5a1f
	cp $ff ; $5a22
	jr z, .done ; $5a24
	inc b ; $5a26
	ld a, b ; $5a27
	cp $06 ; $5a28
	jr nz, .loop ; $5a2a
.done:
	ret ; $5a2c
DrawStatModEntry:
	push hl ; $5a2d
	push bc ; $5a2e
	ld a, d ; $5a2f
	cp $ff ; $5a30
	jr z, .restore ; $5a32
	cp $fe ; $5a34
	jr z, .restore ; $5a36
	call DrawStatModLabel ; $5a38
	ld d, c ; $5a3b
	call DrawStatModValue ; $5a3c
	ld a, $fe ; $5a3f
.restore:
	pop bc ; $5a41
	pop hl ; $5a42
	ret ; $5a43
GetItemStatModListPtr:
	push af ; $5a44
	push bc ; $5a45
	ld hl, ItemStatModListPtrPtrs ; $5a46
	ld a, [wEquipItemKind] ; $5a49
	ASSERT EQUIPKIND_RACKETS == 0
	or a ; $5a4c
	jr z, .readEntry ; $5a4d
	ld hl, ItemStatModListPtrTable ; $5a4f
.readEntry:
	ld a, b ; $5a52
	add a ; $5a53
	add_hl_a ; $5a54
	ld a, [hl+] ; $5a59
	ld h, [hl] ; $5a5a
	ld l, a ; $5a5b
	pop bc ; $5a5c
	pop af ; $5a5d
	ret ; $5a5e
ItemStatModListPtrPtrs:
	; $5a5f, 14 bytes (records:2)
	dw NormalItemStatMods ; record 0
	dw LargeRacketStatMods ; record 1
	dw SmallRacketStatMods ; record 2
	dw IronRacketStatMods ; record 3
	dw GoldRacketStatMods ; record 4
	dw SilverRacketStatMods ; record 5
	dw DriveRacketStatMods ; record 6
ItemStatModListPtrTable:
	; $5a6d, 6 bytes (records:2)
	dw NormalItemStatMods ; record 0
	dw IronShoesStatMods ; record 1
	dw LightShoesStatMods ; record 2
NormalItemStatMods:
	; $5a73, 7 bytes (bytes:8)
	db $fe, $fe, $fe, $fe, $0a, $fe, $ff ; 0x00
LargeRacketStatMods:
	; $5a7a, 11 bytes (bytes:8)
	db $00, $81, $01, $81, $03, $82, $04, $02 ; 0x00
	db $05, $01, $ff ; 0x08
SmallRacketStatMods:
	; $5a85, 11 bytes (bytes:8)
	db $00, $02, $01, $01, $03, $01, $04, $82 ; 0x00
	db $05, $82, $ff ; 0x08
IronRacketStatMods:
	; $5a90, 11 bytes (bytes:8)
	db $00, $82, $01, $82, $02, $82, $fe, $fe ; 0x00
	db $0b, $fe, $ff ; 0x08
SilverRacketStatMods:
	; $5a9b, 11 bytes (bytes:8)
	db $00, $81, $01, $81, $02, $03, $04, $01 ; 0x00
	db $05, $01, $ff ; 0x08
GoldRacketStatMods:
	; $5aa6, 9 bytes (bytes:8)
	db $00, $02, $01, $02, $02, $81, $04, $81 ; 0x00
	db $ff ; 0x08
DriveRacketStatMods:
	; $5aaf, 7 bytes (bytes:8)
	db $00, $82, $03, $03, $01, $82, $ff ; 0x00
IronShoesStatMods:
	; $5ab6, 11 bytes (bytes:8)
	db $07, $82, $0c, $82, $08, $82, $09, $82 ; 0x00
	db $0b, $fe, $ff ; 0x08
LightShoesStatMods:
	; $5ac1, 9 bytes (bytes:8)
	db $07, $02, $0c, $02, $08, $82, $09, $82 ; 0x00
	db $ff ; 0x08
DrawStatModLabel:
	push af ; $5aca
	push bc ; $5acb
	push de ; $5acc
	push hl ; $5acd
	ld e, $00 ; $5ace
	call GetStatModRowAddr ; $5ad0
	call GetStatModLabelTile ; $5ad3
	call GetStatModLabelLen ; $5ad6
	ld c, a ; $5ad9
	farcall FillIncrementingBytes ; $5ada
	pop hl ; $5add
	pop de ; $5ade
	pop bc ; $5adf
	pop af ; $5ae0
	ret ; $5ae1
GetStatModLabelTile:
	push hl ; $5ae2
	ld a, d ; $5ae3
	ld hl, StatModLabelTiles_3e ; $5ae4
	add_hl_a ; $5ae7
	ld b, [hl] ; $5aec
	pop hl ; $5aed
	ret ; $5aee
StatModLabelTiles_3e:
	; $5aef, 13 bytes (bytes:13)
	db $70, $75, $7a, $7f, $84, $d6, $89, $8e, $93, $99, $a2, $b3, $c5 ; 0x00
GetStatModLabelLen:
	push hl ; $5afc
	ld a, d ; $5afd
	ld hl, StatModLabelLengths_3e ; $5afe
	add_hl_a ; $5b01
	ld a, [hl] ; $5b06
	pop hl ; $5b07
	ret ; $5b08
StatModLabelLengths_3e:
	; $5b09, 13 bytes (bytes:13)
	db $05, $05, $05, $05, $05, $05, $05, $05, $06, $04, $11, $12, $04 ; 0x00
DrawStatModValue:
	push af ; $5b16
	push bc ; $5b17
	push de ; $5b18
	push hl ; $5b19
	ld a, d ; $5b1a
	cp $fe ; $5b1b
	jr z, .restore ; $5b1d
	ld e, $01 ; $5b1f
	call GetStatModRowAddr ; $5b21
	call WriteStatModValueTiles ; $5b24
.restore:
	pop hl ; $5b27
	pop de ; $5b28
	pop bc ; $5b29
	pop af ; $5b2a
	ret ; $5b2b
WriteStatModValueTiles:
	ld a, d ; $5b2c
	cp $80 ; $5b2d
	ld a, $d0 ; $5b2f
	jr c, .store ; $5b31
	ld a, $d1 ; $5b33
.store:
	ld [hl+], a ; $5b35
	ld a, d ; $5b36
	and $07 ; $5b37
	ld b, $d2 ; $5b39
	add b ; $5b3b
	ld [hl], a ; $5b3c
	ret ; $5b3d
GetStatModRowAddr:
	ld a, [wEquipStatRowSet] ; $5b3e
	add a ; $5b41
	ld hl, StatModRowAddrPtrs ; $5b42
	add_hl_a ; $5b45
	ld a, [hl+] ; $5b4a
	ld h, [hl] ; $5b4b
	ld l, a ; $5b4c
	ld a, b ; $5b4d
	add a ; $5b4e
	add_hl_a ; $5b4f
	ld a, [hl+] ; $5b54
	ld h, [hl] ; $5b55
	ld l, a ; $5b56
	ld a, e ; $5b57
	or a ; $5b58
	jr z, .done ; $5b59
	ld a, $06 ; $5b5b
	add l ; $5b5d
	ld l, a ; $5b5e
	jr nc, .done ; $5b5f
	inc h ; $5b61
.done:
	ret ; $5b62
StatModRowAddrPtrs:
	; $5b63, 6 bytes (records:2)
	dw StatModRowAddrSelectScreen ; record 0
	dw StatModRowAddrRacketPanel ; record 1
	dw StatModRowAddrShoesPanel ; record 2
StatModRowAddrSelectScreen:
	; $5b69, 16 bytes (ram_ptrs:3)
	dw wShadowTilemap + 7 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowTilemap + 7 * TILEMAP_WIDTH + 11 ; record 1
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 1 ; record 2
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 11 ; record 3
	dw wShadowTilemap + 11 * TILEMAP_WIDTH + 1 ; record 4
	dw wShadowTilemap + 11 * TILEMAP_WIDTH + 11 ; record 5
	dw 0 ; record 6
	dw 0 ; record 7
StatModRowAddrRacketPanel:
	; $5b79, 16 bytes (ram_ptrs:3)
	dw wShadowTilemap + 3 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowTilemap + 3 * TILEMAP_WIDTH + 11 ; record 1
	dw wShadowTilemap + 5 * TILEMAP_WIDTH + 1 ; record 2
	dw wShadowTilemap + 5 * TILEMAP_WIDTH + 11 ; record 3
	dw wShadowTilemap + 7 * TILEMAP_WIDTH + 1 ; record 4
	dw wShadowTilemap + 7 * TILEMAP_WIDTH + 11 ; record 5
	dw 0 ; record 6
	dw 0 ; record 7
StatModRowAddrShoesPanel:
	; $5b89, 16 bytes (ram_ptrs:3)
	dw wShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowTilemap + 12 * TILEMAP_WIDTH + 11 ; record 1
	dw wShadowTilemap + 14 * TILEMAP_WIDTH + 1 ; record 2
	dw wShadowTilemap + 14 * TILEMAP_WIDTH + 11 ; record 3
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 4
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 11 ; record 5
	dw 0 ; record 6
	dw 0 ; record 7

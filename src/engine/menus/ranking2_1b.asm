WaitForAOrBPress:
	call AdvanceFrame ; $5507
	ldh a, [hInputPressed] ; $550a
	and PADF_A | PADF_B ; $550c
	jr z, WaitForAOrBPress ; $550e
	ret ; $5510
DrawSinglesRankingNames:
	call InitRankingNameRender ; $5511
	wram_bank WRAM_SCREEN ; $5514
	call ClearSinglesRankingNameRects ; $551a
	ld hl, wStoryModeNameOfMainCharacter ; $551d
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 1 ; $5520
	call RenderPlayerNameFitted ; $5523
	ld b, $01 ; $5526
.loop:
	call DrawSinglesRankingEntry ; $5528
	ld a, b ; $552b
	inc a ; $552c
	ld b, a ; $552d
	cp $0c ; $552e
	jr nz, .loop ; $5530
	farcall UploadGlyphBuffer ; $5532
	ret ; $5535
DrawSinglesRankingEntry:
	push af ; $5536
	push bc ; $5537
	push de ; $5538
	push hl ; $5539
	ld a, b ; $553a
	add a ; $553b
	ld hl, SinglesRankingEntryTable1 ; $553c
	add l ; $553f
	ld l, a ; $5540
	jr nc, .read ; $5541
	inc h ; $5543
.read:
	ld a, [hl+] ; $5544
	ld d, [hl] ; $5545
	ld e, a ; $5546
	ld a, b ; $5547
	add a ; $5548
	ld hl, SinglesRankingEntryTable ; $5549
	add l ; $554c
	ld l, a ; $554d
	jr nc, .readB ; $554e
	inc h ; $5550
.readB:
	ld a, [hl+] ; $5551
	ld h, [hl] ; $5552
	ld l, a ; $5553
	ld c, $05 ; $5554
	farcall RenderProportionalTextAt ; $5556
	pop hl ; $5559
	pop de ; $555a
	pop bc ; $555b
	pop af ; $555c
	ret ; $555d
SinglesRankingEntryTable:
	; $555e, 24 bytes (records:2)
	dw $0000 ; record 0
	dw Text_30_41 ; record 1
	dw Text_30_43 ; record 2
	dw Text_30_45 ; record 3
	dw Text_30_78 ; record 4
	dw Text_30_44 ; record 5
	dw Text_30_79 ; record 6
	dw Text_30_40 ; record 7
	dw Text_30_75 ; record 8
	dw Text_30_46 ; record 9
	dw Text_30_42 ; record 10
	dw Text_30_39 ; record 11
SinglesRankingEntryTable1:
	; $5576, 24 bytes (ram_ptrs:3)
	dw wShadowTilemap + 1 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowTilemap + 4 * TILEMAP_WIDTH + 1 ; record 1
	dw wShadowTilemap + 7 * TILEMAP_WIDTH + 1 ; record 2
	dw wShadowTilemap + 10 * TILEMAP_WIDTH + 1 ; record 3
	dw wShadowTilemap + 13 * TILEMAP_WIDTH + 1 ; record 4
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 5
	dw wShadowTilemap + 1 * TILEMAP_WIDTH + 14 ; record 6
	dw wShadowTilemap + 4 * TILEMAP_WIDTH + 14 ; record 7
	dw wShadowTilemap + 7 * TILEMAP_WIDTH + 14 ; record 8
	dw wShadowTilemap + 10 * TILEMAP_WIDTH + 14 ; record 9
	dw wShadowTilemap + 13 * TILEMAP_WIDTH + 14 ; record 10
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 14 ; record 11
ClearSinglesRankingNameRects:
	push af ; $558e
	push bc ; $558f
	push de ; $5590
	push hl ; $5591
	ld b, $00 ; $5592
	ld de, wShadowAttrmap + 1 ; $5594
.loop:
	push bc ; $5597
	ld h, $00 ; $5598
	ld b, $05 ; $559a
	ld c, $02 ; $559c
	farcall FillTilemapRect ; $559e
	ld hl, $0060 ; $55a1
	add hl, de ; $55a4
	ld d, h ; $55a5
	ld e, l ; $55a6
	pop bc ; $55a7
	ld a, b ; $55a8
	inc a ; $55a9
	ld b, a ; $55aa
	cp $06 ; $55ab
	jr nz, .loop ; $55ad
	ld de, wShadowAttrmap + 14 ; $55af
	ld b, $00 ; $55b2
.loopB:
	push bc ; $55b4
	ld h, $01 ; $55b5
	ld b, $05 ; $55b7
	ld c, $02 ; $55b9
	farcall FillTilemapRect ; $55bb
	ld hl, $0060 ; $55be
	add hl, de ; $55c1
	ld d, h ; $55c2
	ld e, l ; $55c3
	pop bc ; $55c4
	ld a, b ; $55c5
	inc a ; $55c6
	ld b, a ; $55c7
	cp $06 ; $55c8
	jr nz, .loopB ; $55ca
	pop hl ; $55cc
	pop de ; $55cd
	pop bc ; $55ce
	pop af ; $55cf
	ret ; $55d0
DrawDoublesRankingNames:
	call InitRankingNameRender ; $55d1
	wram_bank WRAM_SCREEN ; $55d4
	call ClearDoublesRankingNameRects ; $55da
	ld hl, wStoryModeNameOfMainCharacter ; $55dd
	ld de, wShadowTilemap + 2 * TILEMAP_WIDTH + 1 ; $55e0
	call RenderPlayerNameFitted ; $55e3
	ld hl, wStoryModeNameOfPartnerCharacter ; $55e6
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 1 ; $55e9
	call RenderPlayerNameFitted ; $55ec
	ld b, $02 ; $55ef
.loop:
	call DrawDoublesRankingEntry ; $55f1
	ld a, b ; $55f4
	inc a ; $55f5
	ld b, a ; $55f6
	cp $0c ; $55f7
	jr nz, .loop ; $55f9
	farcall UploadGlyphBuffer ; $55fb
	ret ; $55fe
DrawDoublesRankingEntry:
	push af ; $55ff
	push bc ; $5600
	push de ; $5601
	push hl ; $5602
	ld a, b ; $5603
	add a ; $5604
	ld hl, DoublesRankingEntryTable1 ; $5605
	add l ; $5608
	ld l, a ; $5609
	jr nc, .read ; $560a
	inc h ; $560c
.read:
	ld a, [hl+] ; $560d
	ld d, [hl] ; $560e
	ld e, a ; $560f
	ld a, b ; $5610
	add a ; $5611
	ld hl, DoublesRankingEntryTable ; $5612
	add l ; $5615
	ld l, a ; $5616
	jr nc, .readB ; $5617
	inc h ; $5619
.readB:
	ld a, [hl+] ; $561a
	ld h, [hl] ; $561b
	ld l, a ; $561c
	ld c, $05 ; $561d
	farcall RenderProportionalTextAt ; $561f
	pop hl ; $5622
	pop de ; $5623
	pop bc ; $5624
	pop af ; $5625
	ret ; $5626
DoublesRankingEntryTable:
	; $5627, 26 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw Text_30_41 ; record 2
	dw Text_30_40 ; record 3
	dw Text_30_43 ; record 4
	dw Text_30_42 ; record 5
	dw Text_30_46 ; record 6
	dw Text_30_45 ; record 7
	dw Text_30_78 ; record 8
	dw Text_30_80 ; record 9
	dw Text_30_75 ; record 10
	dw Text_30_76 ; record 11
	dw Text_30_43 ; record 12
DoublesRankingEntryTable1:
	; $5641, 24 bytes (ram_ptrs:3)
	dw wShadowTilemap + 2 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowTilemap + 4 * TILEMAP_WIDTH + 1 ; record 1
	dw wShadowTilemap + 7 * TILEMAP_WIDTH + 1 ; record 2
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 1 ; record 3
	dw wShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; record 4
	dw wShadowTilemap + 14 * TILEMAP_WIDTH + 1 ; record 5
	dw wShadowTilemap + 2 * TILEMAP_WIDTH + 14 ; record 6
	dw wShadowTilemap + 4 * TILEMAP_WIDTH + 14 ; record 7
	dw wShadowTilemap + 7 * TILEMAP_WIDTH + 14 ; record 8
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 14 ; record 9
	dw wShadowTilemap + 12 * TILEMAP_WIDTH + 14 ; record 10
	dw wShadowTilemap + 14 * TILEMAP_WIDTH + 14 ; record 11
ClearDoublesRankingNameRects:
	push af ; $5659
	push bc ; $565a
	push de ; $565b
	push hl ; $565c
	ld b, $00 ; $565d
	ld de, wShadowAttrmap + 1 * TILEMAP_WIDTH + 1 ; $565f
.loop:
	push bc ; $5662
	ld h, $00 ; $5663
	ld b, $05 ; $5665
	ld c, $04 ; $5667
	farcall FillTilemapRect ; $5669
	ld hl, $00a0 ; $566c
	add hl, de ; $566f
	ld d, h ; $5670
	ld e, l ; $5671
	pop bc ; $5672
	ld a, b ; $5673
	inc a ; $5674
	ld b, a ; $5675
	cp $03 ; $5676
	jr nz, .loop ; $5678
	ld de, wShadowAttrmap + 1 * TILEMAP_WIDTH + 14 ; $567a
	ld b, $00 ; $567d
.loopB:
	push bc ; $567f
	ld h, $01 ; $5680
	ld b, $05 ; $5682
	ld c, $04 ; $5684
	farcall FillTilemapRect ; $5686
	ld hl, $00a0 ; $5689
	add hl, de ; $568c
	ld d, h ; $568d
	ld e, l ; $568e
	pop bc ; $568f
	ld a, b ; $5690
	inc a ; $5691
	ld b, a ; $5692
	cp $03 ; $5693
	jr nz, .loopB ; $5695
	pop hl ; $5697
	pop de ; $5698
	pop bc ; $5699
	pop af ; $569a
	ret ; $569b
InitRankingNameRender:
	farcall InitTextWindows ; $569c
	wram_bank WRAM_TEXT ; $569f
	ld a, $03 ; $56a5
	ld [wShadowTilemapBank], a ; $56a7
	ld a, $00 ; $56aa
	ld [wWindowTileAttr], a ; $56ac
	farcall PrepareGlyphBuffer ; $56af
	ret ; $56b2
RenderPlayerNameFitted:
	call GetStringLength ; $56b3
	cp $06 ; $56b6
	jr nc, .renderNameTwoRows ; $56b8
	call DrawNameWithDiacritics_1b ; $56ba
	ret ; $56bd
.renderNameTwoRows:
	call RenderNameTwoRows ; $56be
	ret ; $56c1
GetStringLength:
	push hl ; $56c2
	push bc ; $56c3
	ld c, $ff ; $56c4
.loop:
	inc c ; $56c6
	ld a, [hl+] ; $56c7
	or a ; $56c8
	jr nz, .loop ; $56c9
	ld a, c ; $56cb
	pop bc ; $56cc
	pop hl ; $56cd
	ret ; $56ce
RenderNameTwoRows:
	push hl ; $56cf
	push de ; $56d0
	push hl ; $56d1
	ld hl, $ffe0 ; $56d2
	add hl, de ; $56d5
	ld d, h ; $56d6
	ld e, l ; $56d7
	pop hl ; $56d8
	call RenderNameTopRow ; $56d9
	pop de ; $56dc
	pop hl ; $56dd
	call RenderNameBottomRow ; $56de
	ret ; $56e1
RenderNameTopRow:
	push de ; $56e2
	ld de, wRankingNameRowBuffer ; $56e3
	ld bc, $0004 ; $56e6
	call CopyMemoryBC ; $56e9
	ld a, $2d ; $56ec
	ld [de], a ; $56ee
	inc de ; $56ef
	xor a ; $56f0
	ld [de], a ; $56f1
	pop de ; $56f2
	ld hl, wRankingNameRowBuffer ; $56f3
	call DrawNameWithDiacritics_1b ; $56f6
	ret ; $56f9
RenderNameBottomRow:
	push de ; $56fa
	ld bc, $0004 ; $56fb
	add hl, bc ; $56fe
	ld de, wRankingNameRowBuffer ; $56ff
	ld bc, wRankingNameRowBuffer_SIZE ; $5702
	call CopyMemoryBC ; $5705
	pop de ; $5708
	ld hl, wRankingNameRowBuffer ; $5709
	call DrawNameWithDiacritics_1b ; $570c
	ret ; $570f
HighlightSinglesRankingRows:
	ld a, [wRankingBoardPlayerRow] ; $5710
	or a ; $5713
	ret z ; $5714
	cp $01 ; $5715
	ret z ; $5717
	cp $02 ; $5718
	jr nz, .compare ; $571a
	ld b, $01 ; $571c
	call HighlightRankingRow ; $571e
	ld b, $02 ; $5721
	call HighlightRankingRow ; $5723
	ld b, $03 ; $5726
	call HighlightRankingRow ; $5728
	ld b, $04 ; $572b
	call HighlightRankingRow ; $572d
	ret ; $5730
.compare:
	cp $03 ; $5731
	jr nz, .ne03 ; $5733
	ld b, $05 ; $5735
	call HighlightRankingRow ; $5737
	ld b, $06 ; $573a
	call HighlightRankingRow ; $573c
	ld b, $07 ; $573f
	call HighlightRankingRow ; $5741
	ld b, $08 ; $5744
	call HighlightRankingRow ; $5746
	ret ; $5749
.ne03:
	ld b, $0b ; $574a
	call HighlightRankingRow ; $574c
	ret ; $574f
HighlightRankingRow:
	ld a, b ; $5750
	or a ; $5751
	ret z ; $5752
	add a ; $5753
	ld hl, RankingRowDrawHandlers_1b ; $5754
	add l ; $5757
	ld l, a ; $5758
	jr nc, .jumpToHandler ; $5759
	inc h ; $575b
.jumpToHandler:
	ld a, [hl+] ; $575c
	ld h, [hl] ; $575d
	ld l, a ; $575e
	jp hl ; $575f
StubNop_1b_07:
	ret ; $5760
RankingRowDrawHandlers_1b:
	dw DrawRankingRow0 ; $5761 jumptable
	dw DrawRankingRow0 ; $5763 jumptable
	dw DrawRankingRow2 ; $5765 jumptable
	dw DrawRankingRow3 ; $5767 jumptable
	dw DrawRankingRow4 ; $5769 jumptable
	dw DrawRankingRow5 ; $576b jumptable
	dw DrawRankingRow6 ; $576d jumptable
	dw DrawRankingRow7 ; $576f jumptable
	dw DrawRankingRow8 ; $5771 jumptable
	dw DrawRankingRow9 ; $5773 jumptable
	dw DrawRankingRow10 ; $5775 jumptable
	dw DrawRankingRow11 ; $5777 jumptable
DrawRankingRow0:
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $5779
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 6 ; $577c
	ld b, $05 ; $577f
	ld c, $02 ; $5781
	farcall CopyTilemapRect ; $5783
	jp StubNop_1b_07 ; $5786
DrawRankingRow2:
	ld hl, wShadowTilemap + 20 * TILEMAP_WIDTH ; $5789
	ld de, wShadowTilemap + 10 * TILEMAP_WIDTH + 6 ; $578c
	ld b, $04 ; $578f
	ld c, $02 ; $5791
	farcall CopyTilemapRect ; $5793
	jp StubNop_1b_07 ; $5796
DrawRankingRow3:
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 4 ; $5799
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 10 ; $579c
	ld b, $04 ; $579f
	ld c, $02 ; $57a1
	farcall CopyTilemapRect ; $57a3
	jp StubNop_1b_07 ; $57a6
DrawRankingRow4:
	ld hl, wShadowTilemap + 20 * TILEMAP_WIDTH + 4 ; $57a9
	ld de, wShadowTilemap + 10 * TILEMAP_WIDTH + 10 ; $57ac
	ld b, $04 ; $57af
	ld c, $02 ; $57b1
	farcall CopyTilemapRect ; $57b3
	jp StubNop_1b_07 ; $57b6
DrawRankingRow5:
	ld hl, wShadowTilemap + 22 * TILEMAP_WIDTH ; $57b9
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 6 ; $57bc
	ld b, $04 ; $57bf
	ld c, $07 ; $57c1
	farcall CopyTilemapRect ; $57c3
	jp StubNop_1b_07 ; $57c6
DrawRankingRow6:
	ld hl, wShadowTilemap + 22 * TILEMAP_WIDTH + 8 ; $57c9
	ld de, wShadowTilemap + 10 * TILEMAP_WIDTH + 6 ; $57cc
	ld b, $04 ; $57cf
	ld c, $07 ; $57d1
	farcall CopyTilemapRect ; $57d3
	jp StubNop_1b_07 ; $57d6
DrawRankingRow7:
	ld hl, wShadowTilemap + 22 * TILEMAP_WIDTH + 4 ; $57d9
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 10 ; $57dc
	ld b, $04 ; $57df
	ld c, $07 ; $57e1
	farcall CopyTilemapRect ; $57e3
	jp StubNop_1b_07 ; $57e6
DrawRankingRow8:
	ld hl, wShadowTilemap + 22 * TILEMAP_WIDTH + 12 ; $57e9
	ld de, wShadowTilemap + 10 * TILEMAP_WIDTH + 10 ; $57ec
	ld b, $04 ; $57ef
	ld c, $07 ; $57f1
	farcall CopyTilemapRect ; $57f3
	jp StubNop_1b_07 ; $57f6
DrawRankingRow9:
	ld hl, wShadowTilemap + 20 ; $57f9
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 6 ; $57fc
	ld b, $04 ; $57ff
	ld c, $10 ; $5801
	farcall CopyTilemapRect ; $5803
	jp StubNop_1b_07 ; $5806
DrawRankingRow10:
	ld hl, wShadowTilemap + 24 ; $5809
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 10 ; $580c
	ld b, $04 ; $580f
	ld c, $10 ; $5811
	farcall CopyTilemapRect ; $5813
	jp StubNop_1b_07 ; $5816
DrawRankingRow11:
	ld hl, wShadowTilemap + 20 ; $5819
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 6 ; $581c
	ld b, $08 ; $581f
	ld c, $10 ; $5821
	farcall CopyTilemapRect ; $5823
	jp StubNop_1b_07 ; $5826

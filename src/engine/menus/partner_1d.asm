SlideToPartnerStatPage:
	call AdvanceFrame ; $543d
	ld a, [wCharDataFlushChunk] ; $5440
	or a ; $5443
	jr nz, SlideToPartnerStatPage ; $5444
	wram_bank WRAM_SCENE ; $5446
	ld hl, wCharDataValuesSlideX ; $544c
	ld de, $ffe0 ; $544f
	ld a, e ; $5452
	ld [hl+], a ; $5453
	ld [hl], d ; $5454
	call LoadBasePageIntoWorkTilemap ; $5455
	ld hl, PartnerStatPageTilemapPatch02 ; $5458
	ld bc, wCharDataPageSlot1 ; $545b
	call ApplyTilemapPatchList ; $545e
	ld hl, PartnerStatPageTilemapPatch03 ; $5461
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $5464
	call ApplyTilemapPatchList ; $5467
	ld hl, PartnerStatPageTilemapPatch04 ; $546a
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $546d
	call ApplyTilemapPatchList ; $5470
	ld hl, DrillDisplayData_1d ; $5473
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH + 16 ; $5476
	call ApplyTilemapPatchList ; $5479
	farcall FlushCharDataTilemapsFar ; $547c
	wram_bank WRAM_SCENE ; $547f
	ld hl, wCharDataStatsSlideX ; $5485
	ld de, $00a0 ; $5488
	ld a, e ; $548b
	ld [hl+], a ; $548c
	ld [hl], d ; $548d
	ld hl, wCharDataValuesSlideX ; $548e
	ld de, $ffc0 ; $5491
	ld a, e ; $5494
	ld [hl+], a ; $5495
	ld [hl], d ; $5496
	call LoadBasePageIntoWorkTilemap ; $5497
	ld hl, PartnerStatPageTilemapPatch05 ; $549a
	ld bc, wCharDataPageSlot1 ; $549d
	call ApplyTilemapPatchList ; $54a0
	ld hl, PartnerStatPageTilemapPatch06 ; $54a3
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $54a6
	call ApplyTilemapPatchList ; $54a9
	ld hl, PartnerStatPageTilemapPatch07 ; $54ac
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $54af
	call ApplyTilemapPatchList ; $54b2
	ld hl, PartnerStatPageTilemapPatch26 ; $54b5
	ld bc, wCharDataPageSlot3 ; $54b8
	call ApplyTilemapPatchList ; $54bb
	ld hl, PartnerStatPageTilemapPatch27 ; $54be
	ld bc, wCharDataPageSlot3 + 8 * TILEMAP_WIDTH ; $54c1
	call ApplyTilemapPatchList ; $54c4
	ld hl, PartnerStatPageTilemapPatch28 ; $54c7
	ld bc, wCharDataPageSlot3 + 16 * TILEMAP_WIDTH ; $54ca
	call ApplyTilemapPatchList ; $54cd
	ld hl, StatPageTilemapPatch0 ; $54d0
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH + 16 ; $54d3
	call ApplyTilemapPatchList ; $54d6
	farcall FlushCharDataTilemapsFar ; $54d9
	wram_bank WRAM_SCENE ; $54dc
	ld hl, wCharDataStatsSlideX ; $54e2
	ld de, $0080 ; $54e5
	ld a, e ; $54e8
	ld [hl+], a ; $54e9
	ld [hl], d ; $54ea
	ld hl, wCharDataValuesSlideX ; $54eb
	ld de, $ffa0 ; $54ee
	ld a, e ; $54f1
	ld [hl+], a ; $54f2
	ld [hl], d ; $54f3
	call LoadBasePageIntoWorkTilemap ; $54f4
	ld hl, PartnerStatPageTilemapPatch08 ; $54f7
	ld bc, wCharDataPageSlot1 ; $54fa
	call ApplyTilemapPatchList ; $54fd
	ld hl, PartnerStatPageTilemapPatch09 ; $5500
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $5503
	call ApplyTilemapPatchList ; $5506
	ld hl, PartnerStatPageTilemapPatch10 ; $5509
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $550c
	call ApplyTilemapPatchList ; $550f
	ld hl, PartnerStatPageTilemapPatch23 ; $5512
	ld bc, wCharDataPageSlot3 ; $5515
	call ApplyTilemapPatchList ; $5518
	ld hl, PartnerStatPageTilemapPatch24 ; $551b
	ld bc, wCharDataPageSlot3 + 8 * TILEMAP_WIDTH ; $551e
	call ApplyTilemapPatchList ; $5521
	ld hl, PartnerStatPageTilemapPatch25 ; $5524
	ld bc, wCharDataPageSlot3 + 16 * TILEMAP_WIDTH ; $5527
	call ApplyTilemapPatchList ; $552a
	farcall FlushCharDataTilemapsFar ; $552d
	wram_bank WRAM_SCENE ; $5530
	ld hl, wCharDataStatsSlideX ; $5536
	ld de, $0060 ; $5539
	ld a, e ; $553c
	ld [hl+], a ; $553d
	ld [hl], d ; $553e
	ld hl, wCharDataValuesSlideX ; $553f
	ld de, $ff80 ; $5542
	ld a, e ; $5545
	ld [hl+], a ; $5546
	ld [hl], d ; $5547
	call LoadBasePageIntoWorkTilemap ; $5548
	ld hl, PartnerStatPageTilemapPatch11 ; $554b
	ld bc, wCharDataPageSlot1 ; $554e
	call ApplyTilemapPatchList ; $5551
	ld hl, PartnerStatPageTilemapPatch12 ; $5554
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $5557
	call ApplyTilemapPatchList ; $555a
	ld hl, PartnerStatPageTilemapPatch13 ; $555d
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $5560
	call ApplyTilemapPatchList ; $5563
	ld hl, PartnerStatPageTilemapPatch20 ; $5566
	ld bc, wCharDataPageSlot3 ; $5569
	call ApplyTilemapPatchList ; $556c
	ld hl, PartnerStatPageTilemapPatch21 ; $556f
	ld bc, wCharDataPageSlot3 + 8 * TILEMAP_WIDTH ; $5572
	call ApplyTilemapPatchList ; $5575
	ld hl, PartnerStatPageTilemapPatch22 ; $5578
	ld bc, wCharDataPageSlot3 + 16 * TILEMAP_WIDTH ; $557b
	call ApplyTilemapPatchList ; $557e
	farcall FlushCharDataTilemapsFar ; $5581
	wram_bank WRAM_SCENE ; $5584
	ld hl, wCharDataStatsSlideX ; $558a
	ld de, $0040 ; $558d
	ld a, e ; $5590
	ld [hl+], a ; $5591
	ld [hl], d ; $5592
	ld hl, wCharDataValuesSlideX ; $5593
	ld de, $ff60 ; $5596
	ld a, e ; $5599
	ld [hl+], a ; $559a
	ld [hl], d ; $559b
	call LoadBasePageIntoWorkTilemap ; $559c
	ld hl, PartnerStatPageTilemapPatch17 ; $559f
	ld bc, wCharDataPageSlot3 ; $55a2
	call ApplyTilemapPatchList ; $55a5
	ld hl, PartnerStatPageTilemapPatch18 ; $55a8
	ld bc, wCharDataPageSlot3 + 8 * TILEMAP_WIDTH ; $55ab
	call ApplyTilemapPatchList ; $55ae
	ld hl, PartnerStatPageTilemapPatch19 ; $55b1
	ld bc, wCharDataPageSlot3 + 16 * TILEMAP_WIDTH ; $55b4
	call ApplyTilemapPatchList ; $55b7
	farcall FlushCharDataTilemapsFar ; $55ba
	wram_bank WRAM_SCENE ; $55bd
	ld hl, wCharDataStatsSlideX ; $55c3
	ld de, $0020 ; $55c6
	ld a, e ; $55c9
	ld [hl+], a ; $55ca
	ld [hl], d ; $55cb
	ld hl, wCharDataValuesSlideX ; $55cc
	ld de, $00a8 ; $55cf
	ld a, e ; $55d2
	ld [hl+], a ; $55d3
	ld [hl], d ; $55d4
	call LoadBasePageIntoWorkTilemap ; $55d5
	ld hl, PartnerStatPageTilemapPatch14 ; $55d8
	ld bc, wCharDataPageSlot3 ; $55db
	call ApplyTilemapPatchList ; $55de
	ld hl, PartnerStatPageTilemapPatch15 ; $55e1
	ld bc, wCharDataPageSlot3 + 8 * TILEMAP_WIDTH ; $55e4
	call ApplyTilemapPatchList ; $55e7
	ld hl, PartnerStatPageTilemapPatch16 ; $55ea
	ld bc, wCharDataPageSlot3 + 16 * TILEMAP_WIDTH ; $55ed
	call ApplyTilemapPatchList ; $55f0
	farcall FlushCharDataTilemapsFar ; $55f3
	wram_bank WRAM_SCENE ; $55f6
	ld hl, wCharDataStatsSlideX ; $55fc
	xor a ; $55ff
	ld [hl+], a ; $5600
	ld [hl], a ; $5601
	ret ; $5602
SlideFromPartnerStatPage:
	call AdvanceFrame ; $5603
	ld a, [wCharDataFlushChunk] ; $5606
	or a ; $5609
	jr nz, SlideFromPartnerStatPage ; $560a
	wram_bank WRAM_SCENE ; $560c
	ld hl, wCharDataStatsSlideX ; $5612
	ld de, $0020 ; $5615
	ld a, e ; $5618
	ld [hl+], a ; $5619
	ld [hl], d ; $561a
	call LoadBasePageIntoWorkTilemap ; $561b
	ld hl, PartnerStatPageTilemapPatch17 ; $561e
	ld bc, wCharDataPageSlot3 ; $5621
	call ApplyTilemapPatchList ; $5624
	ld hl, PartnerStatPageTilemapPatch18 ; $5627
	ld bc, wCharDataPageSlot3 + 8 * TILEMAP_WIDTH ; $562a
	call ApplyTilemapPatchList ; $562d
	ld hl, PartnerStatPageTilemapPatch19 ; $5630
	ld bc, wCharDataPageSlot3 + 16 * TILEMAP_WIDTH ; $5633
	call ApplyTilemapPatchList ; $5636
	farcall FlushCharDataTilemapsFar ; $5639
	wram_bank WRAM_SCENE ; $563c
	ld hl, wCharDataValuesSlideX ; $5642
	ld de, $ff60 ; $5645
	ld a, e ; $5648
	ld [hl+], a ; $5649
	ld [hl], d ; $564a
	ld hl, wCharDataStatsSlideX ; $564b
	ld de, $0040 ; $564e
	ld a, e ; $5651
	ld [hl+], a ; $5652
	ld [hl], d ; $5653
	call LoadBasePageIntoWorkTilemap ; $5654
	ld hl, PartnerStatPageTilemapPatch11 ; $5657
	ld bc, wCharDataPageSlot1 ; $565a
	call ApplyTilemapPatchList ; $565d
	ld hl, PartnerStatPageTilemapPatch12 ; $5660
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $5663
	call ApplyTilemapPatchList ; $5666
	ld hl, PartnerStatPageTilemapPatch13 ; $5669
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $566c
	call ApplyTilemapPatchList ; $566f
	ld hl, PartnerStatPageTilemapPatch20 ; $5672
	ld bc, wCharDataPageSlot3 ; $5675
	call ApplyTilemapPatchList ; $5678
	ld hl, PartnerStatPageTilemapPatch21 ; $567b
	ld bc, wCharDataPageSlot3 + 8 * TILEMAP_WIDTH ; $567e
	call ApplyTilemapPatchList ; $5681
	ld hl, PartnerStatPageTilemapPatch22 ; $5684
	ld bc, wCharDataPageSlot3 + 16 * TILEMAP_WIDTH ; $5687
	call ApplyTilemapPatchList ; $568a
	farcall FlushCharDataTilemapsFar ; $568d
	wram_bank WRAM_SCENE ; $5690
	ld hl, wCharDataValuesSlideX ; $5696
	ld de, $ff80 ; $5699
	ld a, e ; $569c
	ld [hl+], a ; $569d
	ld [hl], d ; $569e
	ld hl, wCharDataStatsSlideX ; $569f
	ld de, $0060 ; $56a2
	ld a, e ; $56a5
	ld [hl+], a ; $56a6
	ld [hl], d ; $56a7
	call LoadBasePageIntoWorkTilemap ; $56a8
	ld hl, PartnerStatPageTilemapPatch08 ; $56ab
	ld bc, wCharDataPageSlot1 ; $56ae
	call ApplyTilemapPatchList ; $56b1
	ld hl, PartnerStatPageTilemapPatch09 ; $56b4
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $56b7
	call ApplyTilemapPatchList ; $56ba
	ld hl, PartnerStatPageTilemapPatch10 ; $56bd
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $56c0
	call ApplyTilemapPatchList ; $56c3
	ld hl, PartnerStatPageTilemapPatch23 ; $56c6
	ld bc, wCharDataPageSlot3 ; $56c9
	call ApplyTilemapPatchList ; $56cc
	ld hl, PartnerStatPageTilemapPatch24 ; $56cf
	ld bc, wCharDataPageSlot3 + 8 * TILEMAP_WIDTH ; $56d2
	call ApplyTilemapPatchList ; $56d5
	ld hl, PartnerStatPageTilemapPatch25 ; $56d8
	ld bc, wCharDataPageSlot3 + 16 * TILEMAP_WIDTH ; $56db
	call ApplyTilemapPatchList ; $56de
	farcall FlushCharDataTilemapsFar ; $56e1
	wram_bank WRAM_SCENE ; $56e4
	ld hl, wCharDataValuesSlideX ; $56ea
	ld de, $ffa0 ; $56ed
	ld a, e ; $56f0
	ld [hl+], a ; $56f1
	ld [hl], d ; $56f2
	ld hl, wCharDataStatsSlideX ; $56f3
	ld de, $0080 ; $56f6
	ld a, e ; $56f9
	ld [hl+], a ; $56fa
	ld [hl], d ; $56fb
	call LoadBasePageIntoWorkTilemap ; $56fc
	ld hl, PartnerStatPageTilemapPatch05 ; $56ff
	ld bc, wCharDataPageSlot1 ; $5702
	call ApplyTilemapPatchList ; $5705
	ld hl, PartnerStatPageTilemapPatch06 ; $5708
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $570b
	call ApplyTilemapPatchList ; $570e
	ld hl, PartnerStatPageTilemapPatch07 ; $5711
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $5714
	call ApplyTilemapPatchList ; $5717
	ld hl, PartnerStatPageTilemapPatch26 ; $571a
	ld bc, wCharDataPageSlot3 ; $571d
	call ApplyTilemapPatchList ; $5720
	ld hl, PartnerStatPageTilemapPatch27 ; $5723
	ld bc, wCharDataPageSlot3 + 8 * TILEMAP_WIDTH ; $5726
	call ApplyTilemapPatchList ; $5729
	ld hl, PartnerStatPageTilemapPatch28 ; $572c
	ld bc, wCharDataPageSlot3 + 16 * TILEMAP_WIDTH ; $572f
	call ApplyTilemapPatchList ; $5732
	ld hl, StatPageTilemapPatch0 ; $5735
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH + 16 ; $5738
	call ApplyTilemapPatchList ; $573b
	farcall FlushCharDataTilemapsFar ; $573e
	wram_bank WRAM_SCENE ; $5741
	ld hl, wCharDataValuesSlideX ; $5747
	ld de, $ffc0 ; $574a
	ld a, e ; $574d
	ld [hl+], a ; $574e
	ld [hl], d ; $574f
	ld hl, wCharDataStatsSlideX ; $5750
	ld de, $00a0 ; $5753
	ld a, e ; $5756
	ld [hl+], a ; $5757
	ld [hl], d ; $5758
	call LoadBasePageIntoWorkTilemap ; $5759
	ld hl, PartnerStatPageTilemapPatch02 ; $575c
	ld bc, wCharDataPageSlot1 ; $575f
	call ApplyTilemapPatchList ; $5762
	ld hl, PartnerStatPageTilemapPatch03 ; $5765
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $5768
	call ApplyTilemapPatchList ; $576b
	ld hl, PartnerStatPageTilemapPatch04 ; $576e
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $5771
	call ApplyTilemapPatchList ; $5774
	ld hl, DrillDisplayData_1d ; $5777
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH + 16 ; $577a
	call ApplyTilemapPatchList ; $577d
	farcall FlushCharDataTilemapsFar ; $5780
	wram_bank WRAM_SCENE ; $5783
	ld hl, wCharDataValuesSlideX ; $5789
	ld de, $ffe0 ; $578c
	ld a, e ; $578f
	ld [hl+], a ; $5790
	ld [hl], d ; $5791
	ld hl, wCharDataStatsSlideX ; $5792
	ld de, $00a8 ; $5795
	ld a, e ; $5798
	ld [hl+], a ; $5799
	ld [hl], d ; $579a
	call LoadBasePageIntoWorkTilemap ; $579b
	ld hl, StatPageTilemapPatch6 ; $579e
	ld bc, wCharDataPageSlot1 ; $57a1
	call ApplyTilemapPatchList ; $57a4
	ld hl, StatPageTilemapPatch7 ; $57a7
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $57aa
	call ApplyTilemapPatchList ; $57ad
	ld hl, StatPageTilemapPatch8 ; $57b0
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $57b3
	call ApplyTilemapPatchList ; $57b6
	ld hl, DrillDisplayData_1d ; $57b9
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH + 16 ; $57bc
	call ApplyTilemapPatchList ; $57bf
	farcall FlushCharDataTilemapsFar ; $57c2
	wram_bank WRAM_SCENE ; $57c5
	ld hl, wCharDataValuesSlideX ; $57cb
	xor a ; $57ce
	ld [hl+], a ; $57cf
	ld [hl], a ; $57d0
	ret ; $57d1
DrawCharStatDigitsTask:
	wram_bank WRAM_SCENE ; $57d2
	ld b, $0f ; $57d8
	ld a, [wCharDataLevels] ; $57da
	ld l, a ; $57dd
	cp $0a ; $57de
	jr c, .lt0a ; $57e0
	push bc ; $57e2
	ld h, $00 ; $57e3
	ld a, $02 ; $57e5
	ld de, wCharDataNumberBuffer ; $57e7
	call FormatDecimalNumberUnsigned ; $57ea
	pop bc ; $57ed
	push bc ; $57ee
	ld a, [wCharDataNumberBuffer] ; $57ef
	sub $30 ; $57f2
	rlca ; $57f4
	ld c, a ; $57f5
	ld de, $051c ; $57f6
	xor a ; $57f9
	ld hl, wCharDataStatsSlideX ; $57fa
	call ApplySlideOffsetToSpriteX ; $57fd
	call QueueSprite ; $5800
	pop bc ; $5803
	ld a, [wCharDataNumberBuffer + 1] ; $5804
	sub $30 ; $5807
	rlca ; $5809
	ld c, a ; $580a
	ld de, $0c1c ; $580b
	xor a ; $580e
	ld hl, wCharDataStatsSlideX ; $580f
	call ApplySlideOffsetToSpriteX ; $5812
	call QueueSprite ; $5815
	jr .stat2 ; $5818
.lt0a:
	ld a, l ; $581a
	rlca ; $581b
	ld c, a ; $581c
	ld de, $091c ; $581d
	xor a ; $5820
	ld hl, wCharDataStatsSlideX ; $5821
	call ApplySlideOffsetToSpriteX ; $5824
	call QueueSprite ; $5827
.stat2:
	ld b, $0f ; $582a
	ld a, [wCharDataLevels + 1] ; $582c
	ld l, a ; $582f
	cp $0a ; $5830
	jr c, .lt0a2 ; $5832
	push bc ; $5834
	ld h, $00 ; $5835
	ld a, $02 ; $5837
	ld de, wCharDataNumberBuffer ; $5839
	call FormatDecimalNumberUnsigned ; $583c
	pop bc ; $583f
	push bc ; $5840
	ld a, [wCharDataNumberBuffer] ; $5841
	sub $30 ; $5844
	rlca ; $5846
	ld c, a ; $5847
	ld de, $0544 ; $5848
	ld a, $01 ; $584b
	ld hl, wCharDataStatsSlideX ; $584d
	call ApplySlideOffsetToSpriteX ; $5850
	call QueueSprite ; $5853
	pop bc ; $5856
	ld a, [wCharDataNumberBuffer + 1] ; $5857
	sub $30 ; $585a
	rlca ; $585c
	ld c, a ; $585d
	ld de, $0c44 ; $585e
	ld a, $01 ; $5861
	ld hl, wCharDataStatsSlideX ; $5863
	call ApplySlideOffsetToSpriteX ; $5866
	call QueueSprite ; $5869
	jr .stat3 ; $586c
.lt0a2:
	ld a, l ; $586e
	rlca ; $586f
	ld c, a ; $5870
	ld de, $0944 ; $5871
	ld a, $01 ; $5874
	ld hl, wCharDataStatsSlideX ; $5876
	call ApplySlideOffsetToSpriteX ; $5879
	call QueueSprite ; $587c
.stat3:
	ld b, $0f ; $587f
	ld a, [wCharDataLevels + 2] ; $5881
	ld l, a ; $5884
	cp $0a ; $5885
	jr c, .lt0a3 ; $5887
	push bc ; $5889
	ld h, $00 ; $588a
	ld a, $02 ; $588c
	ld de, wCharDataNumberBuffer ; $588e
	call FormatDecimalNumberUnsigned ; $5891
	pop bc ; $5894
	push bc ; $5895
	ld a, [wCharDataNumberBuffer] ; $5896
	sub $30 ; $5899
	rlca ; $589b
	ld c, a ; $589c
	ld de, $551c ; $589d
	ld a, $02 ; $58a0
	ld hl, wCharDataStatsSlideX ; $58a2
	call ApplySlideOffsetToSpriteX ; $58a5
	call QueueSprite ; $58a8
	pop bc ; $58ab
	ld a, [wCharDataNumberBuffer + 1] ; $58ac
	sub $30 ; $58af
	rlca ; $58b1
	ld c, a ; $58b2
	ld de, $5c1c ; $58b3
	ld a, $02 ; $58b6
	ld hl, wCharDataStatsSlideX ; $58b8
	call ApplySlideOffsetToSpriteX ; $58bb
	call QueueSprite ; $58be
	jr .stat4 ; $58c1
.lt0a3:
	ld a, l ; $58c3
	rlca ; $58c4
	ld c, a ; $58c5
	ld de, $591c ; $58c6
	ld a, $02 ; $58c9
	ld hl, wCharDataStatsSlideX ; $58cb
	call ApplySlideOffsetToSpriteX ; $58ce
	call QueueSprite ; $58d1
.stat4:
	ld b, $0f ; $58d4
	ld a, [wCharDataLevels + 3] ; $58d6
	ld l, a ; $58d9
	cp $0a ; $58da
	jr c, .lt0a4 ; $58dc
	push bc ; $58de
	ld h, $00 ; $58df
	ld a, $02 ; $58e1
	ld de, wCharDataNumberBuffer ; $58e3
	call FormatDecimalNumberUnsigned ; $58e6
	pop bc ; $58e9
	push bc ; $58ea
	ld a, [wCharDataNumberBuffer] ; $58eb
	sub $30 ; $58ee
	rlca ; $58f0
	ld c, a ; $58f1
	ld de, $5544 ; $58f2
	ld a, $03 ; $58f5
	ld hl, wCharDataStatsSlideX ; $58f7
	call ApplySlideOffsetToSpriteX ; $58fa
	call QueueSprite ; $58fd
	pop bc ; $5900
	ld a, [wCharDataNumberBuffer + 1] ; $5901
	sub $30 ; $5904
	rlca ; $5906
	ld c, a ; $5907
	ld de, $5c44 ; $5908
	ld a, $03 ; $590b
	ld hl, wCharDataStatsSlideX ; $590d
	call ApplySlideOffsetToSpriteX ; $5910
	call QueueSprite ; $5913
	jr .getCharDataDigitSprite ; $5916
.lt0a4:
	ld a, l ; $5918
	rlca ; $5919
	ld c, a ; $591a
	ld de, $5944 ; $591b
	ld a, $03 ; $591e
	ld hl, wCharDataStatsSlideX ; $5920
	call ApplySlideOffsetToSpriteX ; $5923
	call QueueSprite ; $5926
.getCharDataDigitSprite:
	ld a, [wCharStatPageShown + 1] ; $5929
	cp $20 ; $592c
	jr z, .eq20 ; $592e
	call GetCharDataDigitSprite ; $5930
	ld de, $2984 ; $5933
	ld hl, wCharDataStatsSlideX ; $5936
	call ApplySlideOffsetToSpriteX ; $5939
	call QueueSprite ; $593c
.eq20:
	ld a, [wCharStatPageShown + 2] ; $593f
	cp $20 ; $5942
	jr z, .eq202 ; $5944
	call GetCharDataDigitSprite ; $5946
	ld de, $3184 ; $5949
	ld hl, wCharDataStatsSlideX ; $594c
	call ApplySlideOffsetToSpriteX ; $594f
	call QueueSprite ; $5952
.eq202:
	ld a, [wCharStatPageShown + 3] ; $5955
	cp $20 ; $5958
	jr z, .eq203 ; $595a
	call GetCharDataDigitSprite ; $595c
	ld de, $3984 ; $595f
	ld hl, wCharDataStatsSlideX ; $5962
	call ApplySlideOffsetToSpriteX ; $5965
	call QueueSprite ; $5968
.eq203:
	ld a, [wCharStatPageShown + 4] ; $596b
	cp $20 ; $596e
	jr z, .eq204 ; $5970
	call GetCharDataDigitSprite ; $5972
	ld de, $4184 ; $5975
	ld hl, wCharDataStatsSlideX ; $5978
	call ApplySlideOffsetToSpriteX ; $597b
	call QueueSprite ; $597e
.eq204:
	ld a, [wCharStatPageShown + 5] ; $5981
	call GetCharDataDigitSprite ; $5984
	ld de, $4984 ; $5987
	ld hl, wCharDataStatsSlideX ; $598a
	call ApplySlideOffsetToSpriteX ; $598d
	call QueueSprite ; $5990
	farcall DrawStatChangeArrows ; $5993
	ret ; $5996

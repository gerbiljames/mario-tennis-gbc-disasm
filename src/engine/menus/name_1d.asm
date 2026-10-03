PlotTilesAtOffsets:
	push de ; $4771
	ld a, [hl+] ; $4772
	cp $ff ; $4773
	jr z, .restore ; $4775
	add e ; $4777
	ld e, a ; $4778
	jr nc, .read ; $4779
	inc d ; $477b
.read:
	ld a, [hl+] ; $477c
	ld c, a ; $477d
	wram_bank WRAM_SCREEN ; $477e
	ld a, c ; $4784
	ld [de], a ; $4785
	wram_bank WRAM_COURT_PLANES ; $4786
	ld a, b ; $478c
	ld [de], a ; $478d
	pop de ; $478e
	jr PlotTilesAtOffsets ; $478f
.restore:
	pop de ; $4791
	ret ; $4792
DrawFourTileFlagLabel:
	or a ; $4793
	jr nz, .nonZero ; $4794
	wram_bank WRAM_SCREEN ; $4796
	ld a, $01 ; $479c
	jr .store ; $479e
.nonZero:
	wram_bank WRAM_SCREEN ; $47a0
	ld a, $05 ; $47a6
.store:
	ld [hl+], a ; $47a8
	inc a ; $47a9
	ld [hl+], a ; $47aa
	inc a ; $47ab
	ld [hl+], a ; $47ac
	inc a ; $47ad
	ld [hl], a ; $47ae
	ret ; $47af
WriteNameStringTiles:
	ld a, [hl+] ; $47b0
	or a ; $47b1
	ret z ; $47b2
	cp $de ; $47b3
	jr z, .nameTilePtrUpOneRow ; $47b5
	cp $df ; $47b7
	jr z, .nameTilePtrUpOneRow ; $47b9
	ld b, a ; $47bb
	wram_bank WRAM_SCREEN ; $47bc
	ld a, b ; $47c2
	ld [de], a ; $47c3
	wram_bank WRAM_COURT_PLANES ; $47c4
	xor a ; $47ca
	ld [de], a ; $47cb
	inc de ; $47cc
	jr WriteNameStringTiles ; $47cd
.nameTilePtrUpOneRow:
	call NameTilePtrUpOneRow ; $47cf
	ld b, a ; $47d2
	wram_bank WRAM_SCREEN ; $47d3
	ld a, [de] ; $47d9
	or a ; $47da
	jr z, .zero ; $47db
	ld a, b ; $47dd
	sub $30 ; $47de
	ld [de], a ; $47e0
	wram_bank WRAM_COURT_PLANES ; $47e1
	ld a, $08 ; $47e7
	ld [de], a ; $47e9
	call NameTilePtrDownOneRow ; $47ea
	jr WriteNameStringTiles ; $47ed
.zero:
	ld a, b ; $47ef
	ld [de], a ; $47f0
	wram_bank WRAM_COURT_PLANES ; $47f1
	xor a ; $47f7
	ld [de], a ; $47f8
	call NameTilePtrDownOneRow ; $47f9
	jr WriteNameStringTiles ; $47fc
NameTilePtrUpOneRow:
	push bc ; $47fe
.loop:
	dec de ; $47ff
	dec c ; $4800
	jr nz, .loop ; $4801
	dec de ; $4803
	pop bc ; $4804
	ret ; $4805
NameTilePtrDownOneRow:
	ld a, c ; $4806
	inc a ; $4807
	add e ; $4808
	ld e, a ; $4809
	jr nc, .done ; $480a
	inc d ; $480c
.done:
	ret ; $480d
FormatExp24BitDecimal:
	wram_bank WRAM_SCENE ; $480e
	ld a, [hl+] ; $4814
	ld b, [hl] ; $4815
	ld c, a ; $4816
	inc hl ; $4817
	ld a, [hl] ; $4818
	ld [wCharDataNumberBuffer], a ; $4819
	ld h, b ; $481c
	ld l, c ; $481d
	ld de, wCharDataNumberBuffer + 1 ; $481e
	ld a, $05 ; $4821
	call FormatDecimalNumberUnsigned ; $4823
	ld hl, wCharDataNumberBuffer ; $4826
	ld a, [hl] ; $4829
	and a ; $482a
	ret z ; $482b
	ld c, a ; $482c
.loop:
	ld de, wCharDataNumberBuffer + 5 ; $482d
	ld a, [de] ; $4830
	sub $20 ; $4831
	jr z, .zero ; $4833
	sub $10 ; $4835
.zero:
	add $06 ; $4837
	cp $0a ; $4839
	jr c, .lt0a ; $483b
	sub $0a ; $483d
	ld b, a ; $483f
	ld a, $01 ; $4840
	ld [hl], a ; $4842
	ld a, b ; $4843
.lt0a:
	add $30 ; $4844
	ld [de], a ; $4846
	ld de, wCharDataNumberBuffer + 4 ; $4847
	ld a, [de] ; $484a
	add [hl] ; $484b
	ld b, a ; $484c
	xor a ; $484d
	ld [hl], a ; $484e
	ld a, b ; $484f
	sub $20 ; $4850
	jr z, .zero2 ; $4852
	sub $10 ; $4854
.zero2:
	add $03 ; $4856
	cp $0a ; $4858
	jr c, .lt0a2 ; $485a
	sub $0a ; $485c
	ld b, a ; $485e
	ld a, $01 ; $485f
	ld [hl], a ; $4861
	ld a, b ; $4862
.lt0a2:
	add $30 ; $4863
	ld [de], a ; $4865
	ld de, wCharDataNumberBuffer + 3 ; $4866
	ld a, [de] ; $4869
	add [hl] ; $486a
	ld b, a ; $486b
	xor a ; $486c
	ld [hl], a ; $486d
	ld a, b ; $486e
	sub $20 ; $486f
	jr z, .zero3 ; $4871
	sub $10 ; $4873
.zero3:
	add $05 ; $4875
	cp $0a ; $4877
	jr c, .lt0a3 ; $4879
	sub $0a ; $487b
	ld b, a ; $487d
	ld a, $01 ; $487e
	ld [hl], a ; $4880
	ld a, b ; $4881
.lt0a3:
	add $30 ; $4882
	ld [de], a ; $4884
	ld de, wCharDataNumberBuffer + 2 ; $4885
	ld a, [de] ; $4888
	add [hl] ; $4889
	ld b, a ; $488a
	xor a ; $488b
	ld [hl], a ; $488c
	ld a, b ; $488d
	sub $20 ; $488e
	jr z, .zero4 ; $4890
	sub $10 ; $4892
.zero4:
	add $05 ; $4894
	cp $0a ; $4896
	jr c, .lt0a4 ; $4898
	sub $0a ; $489a
	ld b, a ; $489c
	ld a, $01 ; $489d
	ld [hl], a ; $489f
	ld a, b ; $48a0
.lt0a4:
	add $30 ; $48a1
	ld [de], a ; $48a3
	ld de, wCharDataNumberBuffer + 1 ; $48a4
	ld a, [de] ; $48a7
	add [hl] ; $48a8
	ld b, a ; $48a9
	xor a ; $48aa
	ld [hl], a ; $48ab
	ld a, b ; $48ac
	sub $20 ; $48ad
	jr z, .zero5 ; $48af
	sub $10 ; $48b1
.zero5:
	add $05 ; $48b3
	ld hl, wCharDataNumberBuffer ; $48b5
	add [hl] ; $48b8
	cp $0a ; $48b9
	jr c, .lt0a5 ; $48bb
	ld a, $09 ; $48bd
.lt0a5:
	add $30 ; $48bf
	ld [de], a ; $48c1
	dec c ; $48c2
	jp nz, .loop ; $48c3
	ret ; $48c6
CharDataValuesSyncTask:
	wram_bank WRAM_SCENE ; $48c7
	ld a, [wCharDataSyncSource] ; $48cd
	or a ; $48d0
	jr nz, .nonZero ; $48d1
	ld hl, wCharDataSyncValues ; $48d3
	jr .step2 ; $48d6
.nonZero:
	ld hl, wGameTimer + 2 ; $48d8
.step2:
	ld de, wCharDataSyncPair ; $48db
	ld a, [hl+] ; $48de
	ld [de], a ; $48df
	inc de ; $48e0
	ld a, [hl] ; $48e1
	ld [de], a ; $48e2
	ld a, [wCharDataSyncPair + 1] ; $48e3
	ld h, $00 ; $48e6
	ld l, a ; $48e8
	ld a, $02 ; $48e9
	ld de, wCharDataNumberBuffer ; $48eb
	call FormatDecimalNumberUnsigned ; $48ee
	ld a, [wCharDataNumberBuffer] ; $48f1
	cp $20 ; $48f4
	jr z, .eq20 ; $48f6
	call GetCharDataDigitSprite ; $48f8
	ld_xy de, $5d, $88 ; $48fb
	ld hl, wCharDataValuesSlideX ; $48fe
	call ApplySlideOffsetToSpriteX ; $4901
	call QueueSprite ; $4904
.eq20:
	ld a, [wCharDataNumberBuffer + 1] ; $4907
	call GetCharDataDigitSprite ; $490a
	ld_xy de, $65, $88 ; $490d
	ld hl, wCharDataValuesSlideX ; $4910
	call ApplySlideOffsetToSpriteX ; $4913
	call QueueSprite ; $4916
	ld a, [wCharDataSyncPair] ; $4919
	ld h, $00 ; $491c
	ld l, a ; $491e
	ld a, $02 ; $491f
	ld de, wCharDataNumberBuffer ; $4921
	call FormatDecimalNumberUnsigned ; $4924
	ld a, [wCharDataNumberBuffer] ; $4927
	cp $20 ; $492a
	jr z, .eq202 ; $492c
	jr .getCharDataDigitSprite ; $492e
.eq202:
	ld a, $30 ; $4930
.getCharDataDigitSprite:
	call GetCharDataDigitSprite ; $4932
	ld_xy de, $74, $88 ; $4935
	ld hl, wCharDataValuesSlideX ; $4938
	call ApplySlideOffsetToSpriteX ; $493b
	call QueueSprite ; $493e
	ld a, [wCharDataNumberBuffer + 1] ; $4941
	call GetCharDataDigitSprite ; $4944
	ld_xy de, $7c, $88 ; $4947
	ld hl, wCharDataValuesSlideX ; $494a
	call ApplySlideOffsetToSpriteX ; $494d
	call QueueSprite ; $4950
	wram_bank WRAM_SCENE ; $4953
	ld a, [wCharStatPageMain + 10] ; $4959
	cp $20 ; $495c
	jr z, .eq203 ; $495e
	call GetSummaryExpDigitSprite ; $4960
	ld_xy de, $08, $64 ; $4963
	ld hl, wCharDataValuesSlideX ; $4966
	call ApplySlideOffsetToSpriteX ; $4969
	call QueueSprite ; $496c
.eq203:
	ld a, [wCharStatPageMain + 11] ; $496f
	cp $20 ; $4972
	jr z, .eq204 ; $4974
	call GetSummaryExpDigitSprite ; $4976
	ld_xy de, $0d, $64 ; $4979
	ld hl, wCharDataValuesSlideX ; $497c
	call ApplySlideOffsetToSpriteX ; $497f
	call QueueSprite ; $4982
.eq204:
	ld a, [wCharStatPageMain + 12] ; $4985
	cp $20 ; $4988
	jr z, .eq205 ; $498a
	call GetSummaryExpDigitSprite ; $498c
	ld_xy de, $12, $64 ; $498f
	ld hl, wCharDataValuesSlideX ; $4992
	call ApplySlideOffsetToSpriteX ; $4995
	call QueueSprite ; $4998
.eq205:
	ld a, [wCharStatPagePartner + 10] ; $499b
	cp $20 ; $499e
	jr z, .eq206 ; $49a0
	call GetSummaryExpDigitSprite ; $49a2
	ld_xy de, $58, $64 ; $49a5
	ld hl, wCharDataValuesSlideX ; $49a8
	call ApplySlideOffsetToSpriteX ; $49ab
	call QueueSprite ; $49ae
.eq206:
	ld a, [wCharStatPagePartner + 11] ; $49b1
	cp $20 ; $49b4
	jr z, .eq207 ; $49b6
	call GetSummaryExpDigitSprite ; $49b8
	ld_xy de, $5d, $64 ; $49bb
	ld hl, wCharDataValuesSlideX ; $49be
	call ApplySlideOffsetToSpriteX ; $49c1
	call QueueSprite ; $49c4
.eq207:
	ld a, [wCharStatPagePartner + 12] ; $49c7
	cp $20 ; $49ca
	jr z, .checkEquippedRacket ; $49cc
	call GetSummaryExpDigitSprite ; $49ce
	ld_xy de, $62, $64 ; $49d1
	ld hl, wCharDataValuesSlideX ; $49d4
	call ApplySlideOffsetToSpriteX ; $49d7
	call QueueSprite ; $49da
.checkEquippedRacket:
	ld a, [wEquippedRacket] ; $49dd
	push af ; $49e0
	and $0f ; $49e1
	jr z, .restore ; $49e3
	ld b, $0e ; $49e5
	ld c, $d6 ; $49e7
	ld_xy de, $30, $3c ; $49e9
	ld hl, wCharDataValuesSlideX ; $49ec
	call ApplySlideOffsetToSpriteX ; $49ef
	call QueueSprite ; $49f2
.restore:
	pop af ; $49f5
	and $f0 ; $49f6
	jr z, .done ; $49f8
	ld b, $0e ; $49fa
	ld c, $d8 ; $49fc
	ld_xy de, $38, $3c ; $49fe
	ld hl, wCharDataValuesSlideX ; $4a01
	call ApplySlideOffsetToSpriteX ; $4a04
	call QueueSprite ; $4a07
.done:
	ret ; $4a0a
GetSummaryExpDigitSprite:
	sub $30 ; $4a0b
	rlca ; $4a0d
	add $4c ; $4a0e
	ld c, a ; $4a10
	ld b, $08 ; $4a11
	ret ; $4a13
SaveWorkTilemapToPage:
	or a ; $4a14
	jr z, .toPlane ; $4a15
	dec a ; $4a17
	jr z, .toSlot1 ; $4a18
	dec a ; $4a1a
	jr z, .toSlot2 ; $4a1b
	wram_bank WRAM_SCREEN ; $4a1d
	ld hl, wShadowTilemap ; $4a23
	ld de, wCharDataPageSlot3 ; $4a26
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $4a29
	call CopyMemoryFast ; $4a2b
	wram_bank WRAM_COURT_PLANES ; $4a2e
	ld hl, wScreenAttrmap ; $4a34
	ld de, wCharDataPageSlot3 ; $4a37
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $4a3a
	call CopyMemoryFast ; $4a3c
	ret ; $4a3f
.toSlot2:
	wram_bank WRAM_SCREEN ; $4a40
	ld hl, wShadowTilemap ; $4a46
	ld de, wCharDataPageSlot2 ; $4a49
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $4a4c
	call CopyMemoryFast ; $4a4e
	wram_bank WRAM_COURT_PLANES ; $4a51
	ld hl, wScreenAttrmap ; $4a57
	ld de, wCharDataPageSlot2 ; $4a5a
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $4a5d
	call CopyMemoryFast ; $4a5f
	ret ; $4a62
.toSlot1:
	wram_bank WRAM_SCREEN ; $4a63
	ld hl, wShadowTilemap ; $4a69
	ld de, wCharDataPageSlot1 ; $4a6c
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $4a6f
	call CopyMemoryFast ; $4a71
	wram_bank WRAM_COURT_PLANES ; $4a74
	ld hl, wScreenAttrmap ; $4a7a
	ld de, wCharDataPageSlot1 ; $4a7d
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $4a80
	call CopyMemoryFast ; $4a82
	ret ; $4a85
.toPlane:
	wram_bank WRAM_SCREEN ; $4a86
	ld hl, wShadowTilemap ; $4a8c
	ld de, wCharDataPagePlane + 13 * TILEMAP_WIDTH ; $4a8f
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $4a92
	call CopyMemoryFast ; $4a94
	wram_bank WRAM_COURT_PLANES ; $4a97
	ld hl, wScreenAttrmap ; $4a9d
	ld de, wCharDataPagePlane + 13 * TILEMAP_WIDTH ; $4aa0
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $4aa3
	call CopyMemoryFast ; $4aa5
	ret ; $4aa8
LoadBasePageIntoWorkTilemap:
	wram_bank WRAM_SCREEN ; $4aa9
	ld hl, wCharDataPagePlane + 13 * TILEMAP_WIDTH ; $4aaf
	ld de, wShadowTilemap ; $4ab2
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $4ab5
	call CopyMemoryFast ; $4ab7
	wram_bank WRAM_COURT_PLANES ; $4aba
	ld hl, wCharDataPagePlane + 13 * TILEMAP_WIDTH ; $4ac0
	ld de, wScreenAttrmap ; $4ac3
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $4ac6
	call CopyMemoryFast ; $4ac8
	ret ; $4acb
BuildCharDataSummaryPage:
	call BuildCharDataSummaryFields ; $4acc
	ld hl, CharDataSummaryPageTilemapPatch0 ; $4acf
	ld bc, wCharDataScreenCell + 30 * TILEMAP_WIDTH ; $4ad2
	call ApplyTilemapPatchList ; $4ad5
	ld hl, CharDataSummaryPageTilemapPatch1 ; $4ad8
	ld bc, wCharDataPagePlane + 2 * TILEMAP_WIDTH + 16 ; $4adb
	call ApplyTilemapPatchList ; $4ade
	ld hl, CharDataSummaryPageTilemapPatch2 ; $4ae1
	ld bc, wCharDataPagePlane + 7 * TILEMAP_WIDTH ; $4ae4
	call ApplyTilemapPatchList ; $4ae7
	ret ; $4aea
BuildMainCharStatPage:
	xor a ; $4aeb
	ld [wStoryCharacterSlot], a ; $4aec
	call BuildCharStatDisplay ; $4aef
	wram_bank WRAM_SCENE ; $4af2
	ld a, [wCharDataLevels] ; $4af8
	ld [wCharStatPageMain], a ; $4afb
	ld a, [wCharDataLevels + 1] ; $4afe
	ld [wCharStatPageMain + 1], a ; $4b01
	ld a, [wCharDataLevels + 2] ; $4b04
	ld [wCharStatPageMain + 2], a ; $4b07
	ld a, [wCharDataLevels + 3] ; $4b0a
	ld [wCharStatPageMain + 3], a ; $4b0d
	ld hl, MainCharStatPageTilemapPatch00 ; $4b10
	ld bc, wCharDataScreenCell + 27 * TILEMAP_WIDTH + 16 ; $4b13
	call ApplyTilemapPatchList ; $4b16
	ld hl, MainCharStatPageTilemapPatch01 ; $4b19
	ld bc, wCharDataPagePlane + 8 * TILEMAP_WIDTH ; $4b1c
	call ApplyTilemapPatchList ; $4b1f
	ld hl, StatPageTilemapPatch1 ; $4b22
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $4b25
	call ApplyTilemapPatchList ; $4b28
	ld hl, StatPageTilemapPatch2 ; $4b2b
	ld bc, wCharDataScreenCell + 20 * TILEMAP_WIDTH ; $4b2e
	call ApplyTilemapPatchList ; $4b31
	ld hl, StatPageTilemapPatch3 ; $4b34
	ld bc, wCharDataScreenCell + 22 * TILEMAP_WIDTH + 16 ; $4b37
	call ApplyTilemapPatchList ; $4b3a
	ld hl, StatPageTilemapPatch4 ; $4b3d
	ld bc, wCharDataScreenCell + 24 * TILEMAP_WIDTH + 16 ; $4b40
	call ApplyTilemapPatchList ; $4b43
	ld hl, StatPageTilemapPatch5 ; $4b46
	ld bc, wCharDataPagePlane + 9 * TILEMAP_WIDTH + 16 ; $4b49
	call ApplyTilemapPatchList ; $4b4c
	ret ; $4b4f

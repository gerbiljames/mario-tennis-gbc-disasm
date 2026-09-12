BuildN64ExhibColumnList:
	wram_bank WRAM_SCREEN ; $4743
	ld hl, N64ExhibColumn ; $4749
	ld de, wChartColumnList ; $474c
	ld bc, $0001 ; $474f
	call CopyMemoryFast ; $4752
	ld hl, wN64RecordsBlock + 344 ; $4755
	ld a, [hl] ; $4758
	ld b, a ; $4759
	and $01 ; $475a
	jr nz, .maskSet ; $475c
	ld a, $10 ; $475e
	ld [wChartColumnList + 14], a ; $4760
.maskSet:
	ld a, b ; $4763
	and $02 ; $4764
	jr nz, .buildN64ExhibResultsGrid ; $4766
	ld a, $10 ; $4768
	ld [wChartColumnList + 15], a ; $476a
.buildN64ExhibResultsGrid:
	call BuildN64ExhibResultsGrid ; $476d
	ret ; $4770
StubNop_3b_1:
	ret ; $4771
N64ExhibColumn:
	; $4772, 17 bytes (bytes:8)
	db $00, $01, $02, $03, $04, $05, $06, $07 ; 0x00
	db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x08
	db $10 ; 0x10
InitChartRowFlags:
	ld hl, wChartRows ; $4783
	ld c, $00 ; $4786
.loop:
	ld a, $01 ; $4788
	ld [hl], a ; $478a
	ld a, $11 ; $478b
	add l ; $478d
	ld l, a ; $478e
	jr nc, .gotPtr ; $478f
	inc h ; $4791
.gotPtr:
	ld a, c ; $4792
	inc a ; $4793
	ld c, a ; $4794
	cp $10 ; $4795
	jr nz, .loop ; $4797
	ret ; $4799
BuildN64ExhibResultsGrid:
	ld de, wChartRows ; $479a
	ld b, $00 ; $479d
.loop:
	push bc ; $479f
	ld hl, N64ExhibResultsGridTable ; $47a0
	ld a, b ; $47a3
	add l ; $47a4
	ld l, a ; $47a5
	jr nc, .read ; $47a6
	inc h ; $47a8
.read:
	ld b, [hl] ; $47a9
	call DecodeN64ExhibResultsRow ; $47aa
	pop bc ; $47ad
	ld hl, $0010 ; $47ae
	add hl, de ; $47b1
	ld d, h ; $47b2
	ld e, l ; $47b3
	ld a, b ; $47b4
	inc a ; $47b5
	ld b, a ; $47b6
	cp $10 ; $47b7
	jr nz, .loop ; $47b9
	ret ; $47bb
N64ExhibResultsGridTable:
	; $47bc, 16 bytes (bytes:16)
	db $02, $0a, $01, $06, $00, $05, $0f, $09, $08, $0b, $07, $0c, $03, $04, $0e, $0d ; 0x00
DecodeN64ExhibResultsRow:
	push af ; $47cc
	push bc ; $47cd
	push de ; $47ce
	push hl ; $47cf
	push de ; $47d0
	ld hl, wN64RecordsBlock + 216 ; $47d1
	ld a, b ; $47d4
	add a ; $47d5
	add a ; $47d6
	add a ; $47d7
	add l ; $47d8
	ld l, a ; $47d9
	jr nc, .expandRowBytesToBits ; $47da
	inc h ; $47dc
.expandRowBytesToBits:
	ld d, h ; $47dd
	ld e, l ; $47de
	call ExpandRowBytesToBits ; $47df
	pop de ; $47e2
	ld h, d ; $47e3
	ld l, e ; $47e4
	ld b, $00 ; $47e5
.loop:
	push bc ; $47e7
	push hl ; $47e8
	ld hl, DecodeN64ExhibResultsRowTable ; $47e9
	ld a, b ; $47ec
	add l ; $47ed
	ld l, a ; $47ee
	jr nc, .read ; $47ef
	inc h ; $47f1
.read:
	ld b, [hl] ; $47f2
	call CombineExhibCellBits ; $47f3
	pop hl ; $47f6
	pop bc ; $47f7
	call MapExhibCellValueToGlyph ; $47f8
	ld [hl+], a ; $47fb
	ld a, b ; $47fc
	inc a ; $47fd
	ld b, a ; $47fe
	cp $10 ; $47ff
	jr nz, .loop ; $4801
	pop hl ; $4803
	pop de ; $4804
	pop bc ; $4805
	pop af ; $4806
	ret ; $4807
DecodeN64ExhibResultsRowTable:
	; $4808, 16 bytes (bytes:16)
	db $0d, $05, $0e, $09, $0f, $0a, $00, $06, $07, $04, $08, $03, $0c, $0b, $01, $02 ; 0x00
MapExhibCellValueToGlyph:
	push hl ; $4818
	ld hl, MapExhibCellValueToGlyphTable ; $4819
	add l ; $481c
	ld l, a ; $481d
	jr nc, .read ; $481e
	inc h ; $4820
.read:
	ld a, [hl] ; $4821
	pop hl ; $4822
	ret ; $4823
MapExhibCellValueToGlyphTable:
	; $4824, 16 bytes (bytes:8)
	db $00, $03, $05, $07, $09, $0a, $09, $09 ; 0x00
	db $00, $02, $04, $06, $08, $08, $08, $08 ; 0x08
CombineExhibCellBits:
	push hl ; $4834
	push de ; $4835
	push bc ; $4836
	ld a, b ; $4837
	and $0f ; $4838
	ld hl, wExhibCellBits ; $483a
	add l ; $483d
	ld l, a ; $483e
	jr nc, .read ; $483f
	inc h ; $4841
.read:
	ld c, [hl] ; $4842
	ld a, $10 ; $4843
	add l ; $4845
	ld l, a ; $4846
	jr nc, .readB ; $4847
	inc h ; $4849
.readB:
	ld a, [hl] ; $484a
	sla a ; $484b
	ld d, a ; $484d
	ld a, $10 ; $484e
	add l ; $4850
	ld l, a ; $4851
	jr nc, .read2 ; $4852
	inc h ; $4854
.read2:
	ld a, [hl] ; $4855
	sla a ; $4856
	sla a ; $4858
	ld e, a ; $485a
	ld a, $10 ; $485b
	add l ; $485d
	ld l, a ; $485e
	jr nc, .read3 ; $485f
	inc h ; $4861
.read3:
	ld a, [hl] ; $4862
	sla a ; $4863
	sla a ; $4865
	sla a ; $4867
	add e ; $4869
	add d ; $486a
	add c ; $486b
	pop bc ; $486c
	pop de ; $486d
	pop hl ; $486e
	ret ; $486f
ExpandRowBytesToBits:
	push af ; $4870
	push bc ; $4871
	push de ; $4872
	push hl ; $4873
	push de ; $4874
	ld hl, wExhibCellBits ; $4875
	ld bc, $0004 ; $4878
	call ClearMemory16 ; $487b
	pop de ; $487e
	ld hl, wExhibCellBits ; $487f
	ld c, $00 ; $4882
.loop:
	ld a, [de] ; $4884
	inc de ; $4885
	ld b, a ; $4886
	call ExpandByteToBitArray ; $4887
	ld a, $08 ; $488a
	add l ; $488c
	ld l, a ; $488d
	jr nc, .gotPtr ; $488e
	inc h ; $4890
.gotPtr:
	ld a, c ; $4891
	inc a ; $4892
	ld c, a ; $4893
	cp $08 ; $4894
	jr nz, .loop ; $4896
	pop hl ; $4898
	pop de ; $4899
	pop bc ; $489a
	pop af ; $489b
	ret ; $489c
ExpandByteToBitArray:
	push hl ; $489d
	push bc ; $489e
	ld a, $07 ; $489f
	add l ; $48a1
	ld l, a ; $48a2
	jr nc, .gotPtr ; $48a3
	inc h ; $48a5
.gotPtr:
	ld c, $00 ; $48a6
.loop:
	ld a, b ; $48a8
	and $01 ; $48a9
	ld [hl-], a ; $48ab
	srl b ; $48ac
	ld a, c ; $48ae
	inc a ; $48af
	ld c, a ; $48b0
	cp $08 ; $48b1
	jr nz, .loop ; $48b3
	pop bc ; $48b5
	pop hl ; $48b6
	ret ; $48b7
Unused_3b_FillN64RecordsPalettes:
	wram_bank WRAM_SCREEN ; $48b8
	ld hl, wN64RecordsBlock + 216 ; $48be
	ld c, $00 ; $48c1
.loopB:
	ld a, $2c ; $48c3
	ld a, $ff ; $48c5
	ld [hl+], a ; $48c7
	ld a, $61 ; $48c8
	ld a, $ff ; $48ca
	ld [hl+], a ; $48cc
	ld a, $28 ; $48cd
	ld a, $77 ; $48cf
	ld [hl+], a ; $48d1
	ld a, $01 ; $48d2
	ld a, $77 ; $48d4
	ld [hl+], a ; $48d6
	ld a, $04 ; $48d7
	ld a, $33 ; $48d9
	ld [hl+], a ; $48db
	ld a, $01 ; $48dc
	ld a, $33 ; $48de
	ld [hl+], a ; $48e0
	ld a, $08 ; $48e1
	ld a, $11 ; $48e3
	ld [hl+], a ; $48e5
	ld a, $01 ; $48e6
	ld a, $11 ; $48e8
	ld [hl+], a ; $48ea
	inc c ; $48eb
	ld a, c ; $48ec
	cp $08 ; $48ed
	jr nz, .loopB ; $48ef
	ret ; $48f1
LoadChartWindowTiles:
	ld b, TILEBLOCK_MugshotTiles ; $48f2
	ld c, $44 ; $48f4 -- 68 of MugshotTiles's 96 tiles
	farcall LoadCompressedTileBlock ; $48f6
	ret ; $48f9
DrawChartCharIcon:
	push af ; $48fa
	push bc ; $48fb
	push de ; $48fc
	push hl ; $48fd
	ld c, $ac ; $48fe
	ld a, b ; $4900
	add a ; $4901
	add a ; $4902
	add c ; $4903
	push hl ; $4904
	ld [hl+], a ; $4905
	inc a ; $4906
	ld [hl], a ; $4907
	inc a ; $4908
	ld de, $001f ; $4909
	add hl, de ; $490c
	ld [hl+], a ; $490d
	inc a ; $490e
	ld [hl], a ; $490f
	pop hl ; $4910
	ld de, $0400 ; $4911
	add hl, de ; $4914
	ld a, b ; $4915
	push hl ; $4916
	ld hl, ChartCharIconTable ; $4917
	add l ; $491a
	ld l, a ; $491b
	jr nc, .readTile ; $491c
	inc h ; $491e
.readTile:
	ld a, [hl] ; $491f
	pop hl ; $4920
	ld [hl+], a ; $4921
	ld [hl], a ; $4922
	ld de, $001f ; $4923
	add hl, de ; $4926
	ld [hl+], a ; $4927
	ld [hl], a ; $4928
	pop hl ; $4929
	pop de ; $492a
	pop bc ; $492b
	pop af ; $492c
	ret ; $492d
ChartCharIconTable:
	; $492e, 17 bytes (bytes:8)
	db $0e, $0b, $0d, $0e, $0b, $0c, $0d, $0d ; 0x00
	db $0f, $0c, $0e, $0c, $0d, $0e, $0c, $0e ; 0x08
	db $0e ; 0x10
ReadN64RecordsSaveBlock:
	push bc ; $493f
	push_wram_bank WRAM_SCREEN ; $4940
	ld hl, wN64RecordsBlock ; $4949
	ld bc, $0020 ; $494c
	call ClearMemory16 ; $494f
	ld hl, wN64RecordsBlock ; $4952
	ld b, $0b ; $4955
	farcall ReadSaveBlock ; $4957
	ld b, a ; $495a
	pop_wram_bank ; $495b
	ld a, b ; $4960
	pop bc ; $4961
	ret ; $4962
RunTrophiesScreen:
	sound BGM_STATUS_SCREEN ; $4963
	call DisableLCDSafely ; $4965
	call BuildTrophiesScreen ; $4968
	ld a, $00 ; $496b
	ld [wAnimatedTileSet], a ; $496d
	ld a, $01 ; $4970
	ld hl, UpdateAnimatedTilesTask_3b ; $4972
	call RegisterFrameTask ; $4975
	xor a ; $4978
	ld [wN64RecordsBlock + 1], a ; $4979
	ld [wN64RecordsBlock], a ; $497c
	call EnableLCD ; $497f
	script_fade_in $10 ; $4982
	call WaitFadeEnd ; $4987
	wram_bank WRAM_SCREEN ; $498a
.loop:
	ldh a, [hInputPressed] ; $4990
	ld [wMenuInputPressed], a ; $4992
	call AdvanceFrame ; $4995
	ld a, [wMenuInputPressed] ; $4998
	bit PADB_A, a ; $499b
	jr nz, .checkTrophiesCheatCode ; $499d
	bit 1, a ; $499f
	jr nz, .playSfx2 ; $49a1
	bit 5, a ; $49a3
	jr nz, .bit5Set ; $49a5
	bit 4, a ; $49a7
	jr nz, .bit4Set ; $49a9
	jr .loop ; $49ab
.bit5Set:
	ld a, [wN64RecordsBlock + 1] ; $49ad
	inc a ; $49b0
	ld [wN64RecordsBlock + 1], a ; $49b1
	jr .loop ; $49b4
.bit4Set:
	ld a, [wN64RecordsBlock] ; $49b6
	inc a ; $49b9
	ld [wN64RecordsBlock], a ; $49ba
	jr .loop ; $49bd
.checkTrophiesCheatCode:
	bit 2, a ; $49bf
	jr z, .playSfx ; $49c1
	call CheckTrophiesCheatCode ; $49c3
.playSfx:
	sound SFX_MENU_SELECT ; $49c6
	ld c, $10 ; $49c8
	call BeginFadeOut ; $49ca
	call WaitFadeEnd ; $49cd
	call ClearFrameTasks ; $49d0
	ret ; $49d3
.playSfx2:
	sound SFX_MENU_CANCEL ; $49d4
	ld c, $10 ; $49d6
	call BeginFadeOut ; $49d8
	call WaitFadeEnd ; $49db
	call ClearFrameTasks ; $49de
	ld a, $ff ; $49e1
	ret ; $49e3
StubNop_3b_2:
	ret ; $49e4
BuildTrophiesScreen:
	wram_bank WRAM_SCREEN ; $49e5
	call DecodeTrophyCounts ; $49eb
	ld a, [wTrophySecondSetPresent] ; $49ee
	or a ; $49f1
	jr nz, .nonZero ; $49f2
	ld c, SCREENASSET_N64Tournament2 ; $49f4
	farcall LoadScreenAssetRecord ; $49f6
	jr .drawTrophiesWonRows ; $49f9
.nonZero:
	ld c, SCREENASSET_N64Tournament ; $49fb
	farcall LoadScreenAssetRecord ; $49fd
.drawTrophiesWonRows:
	wram_bank WRAM_SCREEN ; $4a00
	call DrawTrophiesWonRows ; $4a06
	ld a, [wTrophySecondSetPresent] ; $4a09
	or a ; $4a0c
	jr nz, .nonZero2 ; $4a0d
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4a0f
	ld c, a ; $4a12
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 2 ; $4a13
	call DrawTrophiesCharSprite ; $4a16
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $4a19
	ld c, a ; $4a1c
	ld de, wShadowTilemap + 10 * TILEMAP_WIDTH + 2 ; $4a1d
	call DrawTrophiesCharSprite ; $4a20
	jr .queueWram3MapToVRAM ; $4a23
.nonZero2:
	ld c, $00 ; $4a25
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 2 ; $4a27
	call DrawTrophiesCharSprite ; $4a2a
	ld c, $00 ; $4a2d
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 2 ; $4a2f
	call DrawTrophiesCharSprite ; $4a32
	ld c, $03 ; $4a35
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 2 ; $4a37
	call DrawTrophiesCharSprite ; $4a3a
	ld c, $03 ; $4a3d
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 2 ; $4a3f
	call DrawTrophiesCharSprite ; $4a42
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4a45
	ld c, a ; $4a48
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 2 ; $4a49
	call DrawTrophiesCharSprite ; $4a4c
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $4a4f
	ld c, a ; $4a52
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 2 ; $4a53
	call DrawTrophiesCharSprite ; $4a56
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4a59
	ld c, a ; $4a5c
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 2 ; $4a5d
	call DrawTrophiesCharSprite ; $4a60
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $4a63
	ld c, a ; $4a66
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 2 ; $4a67
	call DrawTrophiesCharSprite ; $4a6a
.queueWram3MapToVRAM:
	farcall QueueWram3MapToVRAM ; $4a6d
	ret ; $4a70
DrawTrophiesWonRows:
	ld a, [wTrophySecondSetPresent] ; $4a71
	or a ; $4a74
	jr nz, .nonZero ; $4a75
	ld hl, wTrophyCellsMainSet1 ; $4a77
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 5 ; $4a7a
	call DrawTrophyRowPair ; $4a7d
	ld de, wShadowTilemap + 10 * TILEMAP_WIDTH + 5 ; $4a80
	call DrawTrophyRowPair ; $4a83
	ret ; $4a86
.nonZero:
	ld hl, wTrophyCellsMainSet1 ; $4a87
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 5 ; $4a8a
	call DrawTrophyRowPair ; $4a8d
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 5 ; $4a90
	call DrawTrophyRowPair ; $4a93
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 5 ; $4a96
	call DrawTrophyRowPair ; $4a99
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 5 ; $4a9c
	call DrawTrophyRowPair ; $4a9f
	ret ; $4aa2

ShowTournamentBracket:
	wram_bank WRAM_SCREEN ; $775d
	ld a, b ; $7763
	ld [wScreenScratch], a ; $7764
	ld a, c ; $7767
	ld [wDataScreenPage], a ; $7768
	call DisableLCDSafely ; $776b
	call BuildTournamentBracketScreen ; $776e
	call EnableLCD ; $7771
	script_fade_in $10 ; $7774
	call WaitFadeEnd ; $7779
	ld a, $01 ; $777c
	ld hl, BracketHighlightBlinkTask ; $777e
	call RegisterFrameTask ; $7781
	sound SFX_MARKER ; $7784
	wait_frames $78 ; $7786
.loop:
	ldh a, [hInputPressed] ; $778a
	bit PADB_A, a ; $778c
	jr nz, .playSfx ; $778e
	bit 1, a ; $7790
	jr nz, .playSfx ; $7792
	call AdvanceFrame ; $7794
	jr .loop ; $7797
.playSfx:
	sound SFX_MENU_SELECT ; $7799
	call ClearFrameTasks ; $779b
	ld c, $10 ; $779e
	call BeginFadeOut ; $77a0
	call WaitFadeEnd ; $77a3
	ret ; $77a6
BuildTournamentBracketScreen:
	ld a, [wScreenScratch] ; $77a7
	or a ; $77aa
	jr nz, .nonZero ; $77ab
	ld c, SCREENASSET_VarsityTeamChart ; $77ad
	farcall LoadScreenAssetRecord ; $77af
	ld b, TILEBLOCK_TournamentBracketGfx ; $77b2
	ld c, TournamentBracketGfx_SIZE / 16 ; $77b4
	ld de, vTiles2 ; $77b6
	farcall LoadCompressedTileBlock ; $77b9
	wram_bank WRAM_SCREEN ; $77bc
	call ClearTournamentBracketAttrs ; $77c2
	call DrawTournamentBracketNameBoxes ; $77c5
	call WriteBracketSinglesNames ; $77c8
	call HighlightBracketPlayerRow ; $77cb
	farcall QueueWram3MapToVRAM ; $77ce
	ret ; $77d1
.nonZero:
	ld c, SCREENASSET_VarsityTeamChart2 ; $77d2
	farcall LoadScreenAssetRecord ; $77d4
	ld b, TILEBLOCK_TournamentBracketGfx ; $77d7
	ld c, TournamentBracketGfx_SIZE / 16 ; $77d9
	ld de, vTiles2 ; $77db
	farcall LoadCompressedTileBlock ; $77de
	wram_bank WRAM_SCREEN ; $77e1
	call ClearTournamentBracketAttrs ; $77e7
	call DrawTournamentBracketNameBoxes ; $77ea
	call WriteBracketDoublesNames ; $77ed
	call HighlightBracketPlayerRow ; $77f0
	farcall QueueWram3MapToVRAM ; $77f3
	ret ; $77f6
ClearTournamentBracketAttrs:
	ld de, wShadowAttrmap + 8 * TILEMAP_WIDTH + 9 ; $77f7
	ld b, $07 ; $77fa
	ld c, $08 ; $77fc
	ld h, $00 ; $77fe
	farcall FillTilemapRect ; $7800
	ret ; $7803
DrawTournamentBracketNameBoxes:
	ld a, [wScreenScratch] ; $7804
	or a ; $7807
	jr nz, .nonZero ; $7808
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 9 ; $780a
	ld b, $07 ; $780d
	ld c, $08 ; $780f
	ld h, $20 ; $7811
	farcall FillTilemapRect ; $7813
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 9 ; $7816
	ld b, $07 ; $7819
	ld c, $01 ; $781b
	ld h, $03 ; $781d
	farcall FillTilemapRect ; $781f
	ld de, wShadowTilemap + 10 * TILEMAP_WIDTH + 9 ; $7822
	ld b, $07 ; $7825
	ld c, $01 ; $7827
	ld h, $03 ; $7829
	farcall FillTilemapRect ; $782b
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 9 ; $782e
	ld b, $07 ; $7831
	ld c, $01 ; $7833
	ld h, $03 ; $7835
	farcall FillTilemapRect ; $7837
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 9 ; $783a
	ld b, $07 ; $783d
	ld c, $01 ; $783f
	ld h, $03 ; $7841
	farcall FillTilemapRect ; $7843
	ret ; $7846
.nonZero:
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 9 ; $7847
	ld b, $07 ; $784a
	ld c, $08 ; $784c
	ld h, $20 ; $784e
	farcall FillTilemapRect ; $7850
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 9 ; $7853
	ld b, $07 ; $7856
	ld c, $01 ; $7858
	ld h, $03 ; $785a
	farcall FillTilemapRect ; $785c
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 9 ; $785f
	ld b, $07 ; $7862
	ld c, $01 ; $7864
	ld h, $03 ; $7866
	farcall FillTilemapRect ; $7868
	ret ; $786b
WriteBracketSinglesNames:
	ld a, [wDataScreenPage] ; $786c
	ld hl, WriteBracketSinglesNamesPtrs ; $786f
	add a ; $7872
	add l ; $7873
	ld l, a ; $7874
	jr nc, .read ; $7875
	inc h ; $7877
.read:
	ld a, [hl+] ; $7878
	ld h, [hl] ; $7879
	ld l, a ; $787a
	ld b, $00 ; $787b
.loop:
	ld a, [hl+] ; $787d
	call WriteBracketEntrantName ; $787e
	ld a, b ; $7881
	inc a ; $7882
	ld b, a ; $7883
	cp $04 ; $7884
	jr nz, .loop ; $7886
	ret ; $7888
WriteBracketSinglesNamesPtrs:
	; $7889, 10 bytes (records:2)
	dw BracketSinglesNames0 ; record 0
	dw BracketSinglesNames0 ; record 1
	dw BracketSinglesNames1 ; record 2
	dw BracketSinglesNames2 ; record 3
	dw BracketSinglesNames3 ; record 4
BracketSinglesNames0:
	; $7893, 4 bytes (bytes:4)
	db $00, $01, $02, $03 ; 0x00
BracketSinglesNames1:
	; $7897, 4 bytes (bytes:4)
	db $01, $00, $02, $03 ; 0x00
BracketSinglesNames2:
	; $789b, 4 bytes (bytes:4)
	db $01, $02, $00, $03 ; 0x00
BracketSinglesNames3:
	; $789f, 4 bytes (bytes:4)
	db $01, $02, $03, $00 ; 0x00
WriteBracketEntrantName:
	push af ; $78a3
	push bc ; $78a4
	push de ; $78a5
	push hl ; $78a6
	or a ; $78a7
	jr z, .zero ; $78a8
	ld hl, $004b ; $78aa
	dec a ; $78ad
	add l ; $78ae
	ld l, a ; $78af
	jr nc, .gotPtr ; $78b0
	inc h ; $78b2
.gotPtr:
	push hl ; $78b3
	ld hl, WriteBracketEntrantNameTable ; $78b4
	ld a, b ; $78b7
	add a ; $78b8
	add l ; $78b9
	ld l, a ; $78ba
	jr nc, .read ; $78bb
	inc h ; $78bd
.read:
	ld a, [hl+] ; $78be
	ld d, [hl] ; $78bf
	ld e, a ; $78c0
	pop hl ; $78c1
	ld c, $20 ; $78c2
	farcall RenderTextToBuffer64 ; $78c4
	pop hl ; $78c7
	pop de ; $78c8
	pop bc ; $78c9
	pop af ; $78ca
	ret ; $78cb
.zero:
	ld hl, WriteBracketEntrantNameTable ; $78cc
	ld a, b ; $78cf
	add a ; $78d0
	add l ; $78d1
	ld l, a ; $78d2
	jr nc, .readB ; $78d3
	inc h ; $78d5
.readB:
	ld a, [hl+] ; $78d6
	ld d, [hl] ; $78d7
	ld e, a ; $78d8
	ld hl, wStoryModeNameOfMainCharacter ; $78d9
	call DrawNameWithDiacritics_3b ; $78dc
	pop hl ; $78df
	pop de ; $78e0
	pop bc ; $78e1
	pop af ; $78e2
	ret ; $78e3
WriteBracketEntrantNameTable:
	; $78e4, 8 bytes (ram_ptrs:3)
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 9 ; record 0
	dw wShadowTilemap + 11 * TILEMAP_WIDTH + 9 ; record 1
	dw wShadowTilemap + 13 * TILEMAP_WIDTH + 9 ; record 2
	dw wShadowTilemap + 15 * TILEMAP_WIDTH + 9 ; record 3
WriteBracketDoublesNames:
	ld a, [wDataScreenPage] ; $78ec
	cp $01 ; $78ef
	jr nz, .ne01 ; $78f1
	ld hl, wStoryModeNameOfMainCharacter ; $78f3
	ld de, wShadowTilemap + 9 * TILEMAP_WIDTH + 9 ; $78f6
	call DrawNameWithDiacritics_3b ; $78f9
	ld hl, wStoryModeNameOfPartnerCharacter ; $78fc
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 9 ; $78ff
	call DrawNameWithDiacritics_3b ; $7902
	ld hl, Text_30_75 ; $7905
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 9 ; $7908
	ld c, $20 ; $790b
	farcall RenderTextToBuffer64 ; $790d
	ld hl, Text_30_76 ; $7910
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 9 ; $7913
	ld c, $20 ; $7916
	farcall RenderTextToBuffer64 ; $7918
	ret ; $791b
.ne01:
	ld hl, wStoryModeNameOfMainCharacter ; $791c
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 9 ; $791f
	call DrawNameWithDiacritics_3b ; $7922
	ld hl, wStoryModeNameOfPartnerCharacter ; $7925
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 9 ; $7928
	call DrawNameWithDiacritics_3b ; $792b
	ld hl, Text_30_75 ; $792e
	ld de, wShadowTilemap + 9 * TILEMAP_WIDTH + 9 ; $7931
	ld c, $20 ; $7934
	farcall RenderTextToBuffer64 ; $7936
	ld hl, Text_30_76 ; $7939
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 9 ; $793c
	ld c, $20 ; $793f
	farcall RenderTextToBuffer64 ; $7941
	ret ; $7944
HighlightBracketPlayerRow:
	ld a, [wScreenScratch] ; $7945
	or a ; $7948
	jr nz, .nonZero ; $7949
	ld a, [wDataScreenPage] ; $794b
	ld hl, HighlightBracketPlayerRowTable ; $794e
	add a ; $7951
	add l ; $7952
	ld l, a ; $7953
	jr nc, .read ; $7954
	inc h ; $7956
.read:
	ld a, [hl+] ; $7957
	ld d, [hl] ; $7958
	ld e, a ; $7959
	ld b, $07 ; $795a
	ld c, $02 ; $795c
	ld h, $05 ; $795e
	farcall FillTilemapRect ; $7960
	ld a, [wDataScreenPage] ; $7963
	ld hl, BracketPlayerRowTable0 ; $7966
	add a ; $7969
	add l ; $796a
	ld l, a ; $796b
	jr nc, .readB ; $796c
	inc h ; $796e
.readB:
	ld a, [hl+] ; $796f
	ld d, [hl] ; $7970
	ld e, a ; $7971
	ld b, $02 ; $7972
	ld c, $02 ; $7974
	ld a, [wDataScreenPage] ; $7976
	cp $04 ; $7979
	jr nz, .ne04 ; $797b
	ld c, $01 ; $797d
.ne04:
	ld h, $0d ; $797f
	farcall FillTilemapRect ; $7981
	ret ; $7984
.nonZero:
	ld a, [wDataScreenPage] ; $7985
	ld hl, BracketPlayerRowTable1 ; $7988
	add a ; $798b
	add l ; $798c
	ld l, a ; $798d
	jr nc, .read2 ; $798e
	inc h ; $7990
.read2:
	ld a, [hl+] ; $7991
	ld d, [hl] ; $7992
	ld e, a ; $7993
	ld b, $07 ; $7994
	ld c, $04 ; $7996
	ld h, $05 ; $7998
	farcall FillTilemapRect ; $799a
	ld a, [wDataScreenPage] ; $799d
	ld hl, BracketPlayerRowTable2 ; $79a0
	add a ; $79a3
	add l ; $79a4
	ld l, a ; $79a5
	jr nc, .read3 ; $79a6
	inc h ; $79a8
.read3:
	ld a, [hl+] ; $79a9
	ld d, [hl] ; $79aa
	ld e, a ; $79ab
	ld b, $02 ; $79ac
	ld c, $03 ; $79ae
	ld h, $0d ; $79b0
	farcall FillTilemapRect ; $79b2
	ret ; $79b5
HighlightBracketPlayerRowTable:
	; $79b6, 10 bytes (ram_ptrs:3:NO_BOX)
	dw NO_BOX ; record 0
	dw wShadowAttrmap + 8 * TILEMAP_WIDTH + 9 ; record 1
	dw wShadowAttrmap + 10 * TILEMAP_WIDTH + 9 ; record 2
	dw wShadowAttrmap + 12 * TILEMAP_WIDTH + 9 ; record 3
	dw wShadowAttrmap + 14 * TILEMAP_WIDTH + 9 ; record 4
BracketPlayerRowTable0:
	; $79c0, 10 bytes (ram_ptrs:3:NO_BOX)
	dw NO_BOX ; record 0
	dw wShadowAttrmap + 9 * TILEMAP_WIDTH + 5 ; record 1
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 5 ; record 2
	dw wShadowAttrmap + 13 * TILEMAP_WIDTH + 5 ; record 3
	dw wShadowAttrmap + 15 * TILEMAP_WIDTH + 5 ; record 4
BracketPlayerRowTable1:
	; $79ca, 6 bytes (ram_ptrs:3:NO_BOX)
	dw NO_BOX ; record 0
	dw wShadowAttrmap + 8 * TILEMAP_WIDTH + 9 ; record 1
	dw wShadowAttrmap + 12 * TILEMAP_WIDTH + 9 ; record 2
BracketPlayerRowTable2:
	; $79d0, 6 bytes (ram_ptrs:3:NO_BOX)
	dw NO_BOX ; record 0
	dw wShadowAttrmap + 9 * TILEMAP_WIDTH + 5 ; record 1
	dw wShadowAttrmap + 13 * TILEMAP_WIDTH + 5 ; record 2
BracketHighlightBlinkTask:
	ld hl, BracketHighlightBlinkTaskPalettes0 ; $79d6
	ldh a, [hVBlankCounter] ; $79d9
	and $10 ; $79db
	jr z, .maskClear ; $79dd
	ld hl, BracketHighlightBlinkTaskPalettes1 ; $79df
.maskClear:
	lb de, $05, $01 ; $79e2 palette index, count
	call LoadPalettesImmediate ; $79e5
	ret ; $79e8
BracketHighlightBlinkTaskPalettes0:
	; $79e9, 8 bytes (bytes:8)
	db $f9, $67, $00, $00, $1f, $3e, $ff, $33 ; 0x00
BracketHighlightBlinkTaskPalettes1:
	; $79f1, 8 bytes (bytes:8)
	db $f9, $67, $00, $00, $98, $00, $1f, $03 ; 0x00
RunMarioCastExhibResults:
	sound BGM_STATUS_SCREEN ; $79f9
	call DisableLCDSafely ; $79fb
	call BuildMarioCastExhibScreen ; $79fe
	ld a, $01 ; $7a01
	ld [wAnimatedTileSet], a ; $7a03
	ld a, $03 ; $7a06
	ld [wAnimatedTilePeriod], a ; $7a08
	ld a, $01 ; $7a0b
	ld hl, UpdateAnimatedTilesTask_3b ; $7a0d
	call RegisterFrameTask ; $7a10
	ld a, $01 ; $7a13
	ld hl, MarioCastChartScrollArrowsTask ; $7a15
	call RegisterFrameTask ; $7a18
	call EnableLCD ; $7a1b
	script_fade_in $10 ; $7a1e
	call WaitFadeEnd ; $7a23
	wram_bank WRAM_SCREEN ; $7a26
.loop:
	call AdvanceFrame ; $7a2c
	ldh a, [hInputPressed] ; $7a2f
	ld [wMenuInputPressed], a ; $7a31
	call CheckMarioCastChartExpanded ; $7a34
	or a ; $7a37
	jr z, .scrollMarioCastChartCursorSmall ; $7a38
	call ScrollMarioCastChartCursorFull ; $7a3a
	jr .checkMenuInputPressed ; $7a3d
.scrollMarioCastChartCursorSmall:
	call ScrollMarioCastChartCursorSmall ; $7a3f
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $7a42
	bit PADB_A, a ; $7a45
	jr nz, .playSfx ; $7a47
	bit 1, a ; $7a49
	jr nz, .playSfx2 ; $7a4b
	jr .loop ; $7a4d
.playSfx:
	sound SFX_MENU_SELECT ; $7a4f
	ld c, $10 ; $7a51
	call BeginFadeOut ; $7a53
	call WaitFadeEnd ; $7a56
	call ClearFrameTasks ; $7a59
	ret ; $7a5c
.playSfx2:
	sound SFX_MENU_CANCEL ; $7a5d
	ld c, $10 ; $7a5f
	call BeginFadeOut ; $7a61
	call WaitFadeEnd ; $7a64
	call ClearFrameTasks ; $7a67
	ld a, $ff ; $7a6a
	ret ; $7a6c
MarioCastChartScrollArrowsTask:
	push_wram_bank WRAM_SCREEN ; $7a6d
	call CheckMarioCastChartExpanded ; $7a76
	or a ; $7a79
	jr z, .checkMenuCursorY3 ; $7a7a
	ld a, [wMenuCursorX] ; $7a7c
	cp $02 ; $7a7f
	jr z, .checkMenuCursorX ; $7a81
	ld de, $932f ; $7a83
	ld c, $01 ; $7a86
	call ApplyCursorBounceX ; $7a88
	ld b, $08 ; $7a8b
	ld c, $00 ; $7a8d
	ld h, $00 ; $7a8f
	farcall QueueStackedSpritePair ; $7a91
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $7a94
	or a ; $7a97
	jr z, .checkMenuCursorY ; $7a98
	ld de, $082f ; $7a9a
	ld c, $00 ; $7a9d
	call ApplyCursorBounceX ; $7a9f
	ld b, $08 ; $7aa2
	ld c, $00 ; $7aa4
	ld h, $01 ; $7aa6
	farcall QueueStackedSpritePair ; $7aa8
.checkMenuCursorY:
	ld a, [wMenuCursorY] ; $7aab
	or a ; $7aae
	jr z, .checkMenuCursorY2 ; $7aaf
	ld de, $0a20 ; $7ab1
	ld c, $01 ; $7ab4
	call ApplyCursorBounceY ; $7ab6
	ld b, $08 ; $7ab9
	ld c, $00 ; $7abb
	ld h, $02 ; $7abd
	farcall QueueStackedSpritePair ; $7abf
.checkMenuCursorY2:
	ld a, [wMenuCursorY] ; $7ac2
	cp $05 ; $7ac5
	jr z, .eq05 ; $7ac7
	ld de, $0a78 ; $7ac9
	ld c, $00 ; $7acc
	call ApplyCursorBounceY ; $7ace
	ld b, $08 ; $7ad1
	ld c, $00 ; $7ad3
	ld h, $03 ; $7ad5
	farcall QueueStackedSpritePair ; $7ad7
.eq05:
	jr .restore ; $7ada
.checkMenuCursorY3:
	ld a, [wMenuCursorY] ; $7adc
	or a ; $7adf
	jr z, .checkMenuCursorY4 ; $7ae0
	ld de, $1a20 ; $7ae2
	ld c, $01 ; $7ae5
	call ApplyCursorBounceY ; $7ae7
	ld b, $08 ; $7aea
	ld c, $00 ; $7aec
	ld h, $02 ; $7aee
	farcall QueueStackedSpritePair ; $7af0
.checkMenuCursorY4:
	ld a, [wMenuCursorY] ; $7af3
	cp $01 ; $7af6
	jr z, .restore ; $7af8
	ld de, $1a78 ; $7afa
	ld c, $00 ; $7afd
	call ApplyCursorBounceY ; $7aff
	ld b, $08 ; $7b02
	ld c, $00 ; $7b04
	ld h, $03 ; $7b06
	farcall QueueStackedSpritePair ; $7b08
.restore:
	pop_wram_bank ; $7b0b
	ret ; $7b10
BuildMarioCastExhibScreen:
	wram_bank WRAM_SCREEN ; $7b11
	xor a ; $7b17
	ld [wN64ExhibCursorRow], a ; $7b18
	ld [wN64ExhibPage], a ; $7b1b
	ld c, SCREENASSET_ExhibitionMenu ; $7b1e
	farcall LoadScreenAssetRecord ; $7b20
	ld de, vTiles1 + $2c * TILE_SIZE + VRAM_BANK1 ; $7b23
	call LoadChartWindowTiles ; $7b26
	ld de, vTiles0 + VRAM_BANK1 ; $7b29
	farcall LoadMenuArrowSpriteTiles ; $7b2c
	ld b, $08 ; $7b2f
	ld c, $0f ; $7b31
	farcall LoadIndexedPalette ; $7b33
	wram_bank WRAM_SCREEN ; $7b36
	call BuildMarioCastChartColumnList ; $7b3c
	call LoadMarioCastExhibGrid ; $7b3f
	call ApplyMarioCastChartReducedLayout ; $7b42
	call InitChartRowFlags ; $7b45
	call RedrawMarioCastChartWindow ; $7b48
	farcall QueueWram3MapToVRAM ; $7b4b
	ret ; $7b4e
ScrollMarioCastChartCursorFull:
	ld a, [wMenuInputPressed] ; $7b4f
	bit PADB_LEFT, a ; $7b52
	jr z, .checkMenuCursorX ; $7b54
	ld a, [wMenuCursorX] ; $7b56
	or a ; $7b59
	jr z, .done ; $7b5a
	dec a ; $7b5c
	ld [wMenuCursorX], a ; $7b5d
	sound SFX_MENU_MOVE ; $7b60
	call RedrawMarioCastChartWindow ; $7b62
	call FlushMarioCastChartWindowToVram ; $7b65
	jr .done ; $7b68
.checkMenuCursorX:
	bit 4, a ; $7b6a
	jr z, .bit4Clear ; $7b6c
	ld a, [wMenuCursorX] ; $7b6e
	cp $02 ; $7b71
	jr z, .done ; $7b73
	inc a ; $7b75
	ld [wMenuCursorX], a ; $7b76
	sound SFX_MENU_MOVE ; $7b79
	call RedrawMarioCastChartWindow ; $7b7b
	call FlushMarioCastChartWindowToVram ; $7b7e
	jr .done ; $7b81
.bit4Clear:
	bit 6, a ; $7b83
	jr z, .bit6Clear ; $7b85
	ld a, [wMenuCursorY] ; $7b87
	or a ; $7b8a
	jr z, .done ; $7b8b
	dec a ; $7b8d
	ld [wMenuCursorY], a ; $7b8e
	sound SFX_MENU_MOVE ; $7b91
	call RedrawMarioCastChartWindow ; $7b93
	call FlushMarioCastChartWindowToVram ; $7b96
	jr .done ; $7b99
.bit6Clear:
	bit 7, a ; $7b9b
	jr z, .done ; $7b9d
	ld a, [wMenuCursorY] ; $7b9f
	cp $05 ; $7ba2
	jr z, .done ; $7ba4
	inc a ; $7ba6
	ld [wMenuCursorY], a ; $7ba7
	sound SFX_MENU_MOVE ; $7baa
	call RedrawMarioCastChartWindow ; $7bac
	call FlushMarioCastChartWindowToVram ; $7baf
	jr .done ; $7bb2
.done:
	ret ; $7bb4
ScrollMarioCastChartCursorSmall:
	ld a, [wMenuInputPressed] ; $7bb5
	bit PADB_UP, a ; $7bb8
	jr z, .checkMenuCursorY ; $7bba
	ld a, [wMenuCursorY] ; $7bbc
	or a ; $7bbf
	jr z, .done ; $7bc0
	dec a ; $7bc2
	ld [wMenuCursorY], a ; $7bc3
	sound SFX_MENU_MOVE ; $7bc6
	call RedrawMarioCastChartWindow ; $7bc8
	call FlushMarioCastChartWindowToVram ; $7bcb
	jr .done ; $7bce
.checkMenuCursorY:
	bit 7, a ; $7bd0
	jr z, .done ; $7bd2
	ld a, [wMenuCursorY] ; $7bd4
	cp $01 ; $7bd7
	jr z, .done ; $7bd9
	inc a ; $7bdb
	ld [wMenuCursorY], a ; $7bdc
	sound SFX_MENU_MOVE ; $7bdf
	call RedrawMarioCastChartWindow ; $7be1
	call FlushMarioCastChartWindowToVram ; $7be4
	jr .done ; $7be7
.done:
	ret ; $7be9
RedrawMarioCastChartWindow:
	wram_bank WRAM_SCREEN ; $7bea
	call CheckMarioCastChartExpanded ; $7bf0
	or a ; $7bf3
	jr z, .compact ; $7bf4
	ld bc, wShadowTilemap + 5 * TILEMAP_WIDTH + 4 ; $7bf6
	ld a, [wMenuCursorX] ; $7bf9
	ld hl, wChartColumnList ; $7bfc
	add l ; $7bff
	ld l, a ; $7c00
	jr nc, .wideRow ; $7c01
	inc h ; $7c03
.wideRow:
	ld a, $07 ; $7c04
	call DrawChartIconRow ; $7c06
	ld a, [wMenuCursorY] ; $7c09
	ld hl, wChartColumnList ; $7c0c
	add l ; $7c0f
	ld l, a ; $7c10
	jr nc, .wideColumn ; $7c11
	inc h ; $7c13
.wideColumn:
	ld bc, wShadowTilemap + 7 * TILEMAP_WIDTH + 2 ; $7c14
	call DrawChartIconColumn ; $7c17
	ld a, [wMenuCursorY] ; $7c1a
	ld hl, wChartRows ; $7c1d
	ld de, $0010 ; $7c20
.wideRowLoop:
	or a ; $7c23
	jr z, .wideRowFound ; $7c24
	add hl, de ; $7c26
	dec a ; $7c27
	jr .wideRowLoop ; $7c28
.wideRowFound:
	ld a, [wMenuCursorX] ; $7c2a
	add l ; $7c2d
	ld l, a ; $7c2e
	jr nc, .wideCells ; $7c2f
	inc h ; $7c31
.wideCells:
	ld de, wShadowTilemap + 7 * TILEMAP_WIDTH + 4 ; $7c32
	ld a, $07 ; $7c35
	call DrawChartCellRows ; $7c37
	jr .done ; $7c3a
.compact:
	ld bc, wShadowTilemap + 5 * TILEMAP_WIDTH + 6 ; $7c3c
	ld a, [wMenuCursorX] ; $7c3f
	ld hl, wChartColumnList ; $7c42
	add l ; $7c45
	ld l, a ; $7c46
	jr nc, .compactRow ; $7c47
	inc h ; $7c49
.compactRow:
	ld a, $05 ; $7c4a
	call DrawChartIconRow ; $7c4c
	ld a, [wMenuCursorY] ; $7c4f
	ld hl, wChartColumnList ; $7c52
	add l ; $7c55
	ld l, a ; $7c56
	jr nc, .compactColumn ; $7c57
	inc h ; $7c59
.compactColumn:
	ld bc, wShadowTilemap + 7 * TILEMAP_WIDTH + 4 ; $7c5a
	call DrawChartIconColumn ; $7c5d
	ld a, [wMenuCursorY] ; $7c60
	ld hl, wChartRows ; $7c63
	ld de, $0010 ; $7c66
.compactRowLoop:
	or a ; $7c69
	jr z, .compactRowFound ; $7c6a
	add hl, de ; $7c6c
	dec a ; $7c6d
	jr .compactRowLoop ; $7c6e
.compactRowFound:
	ld a, [wMenuCursorX] ; $7c70
	add l ; $7c73
	ld l, a ; $7c74
	jr nc, .compactCells ; $7c75
	inc h ; $7c77
.compactCells:
	ld de, wShadowTilemap + 7 * TILEMAP_WIDTH + 6 ; $7c78
	ld a, $05 ; $7c7b
	call DrawChartCellRows ; $7c7d
.done:
	ret ; $7c80
FlushMarioCastChartWindowToVram:
	ld hl, wShadowTilemap + 5 * TILEMAP_WIDTH ; $7c81
	ld de, vBGMap0 + 5 * TILEMAP_WIDTH ; $7c84
	ld c, $08 ; $7c87
	call QueueVRAMCopy ; $7c89
	ld hl, wShadowAttrmap + 5 * TILEMAP_WIDTH ; $7c8c
	ld de, vBGMap0 + 5 * TILEMAP_WIDTH + VRAM_BANK1 ; $7c8f
	ld c, $08 ; $7c92
	call QueueVRAMCopy ; $7c94
	call AdvanceFrame ; $7c97
	ld hl, wShadowTilemap + 9 * TILEMAP_WIDTH ; $7c9a
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $7c9d
	ld c, $08 ; $7ca0
	call QueueVRAMCopy ; $7ca2
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $7ca5
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $7ca8
	ld c, $08 ; $7cab
	call QueueVRAMCopy ; $7cad
	call AdvanceFrame ; $7cb0
	ld hl, wShadowTilemap + 13 * TILEMAP_WIDTH ; $7cb3
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH ; $7cb6
	ld c, $04 ; $7cb9
	call QueueVRAMCopy ; $7cbb
	ld hl, wShadowAttrmap + 13 * TILEMAP_WIDTH ; $7cbe
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH + VRAM_BANK1 ; $7cc1
	ld c, $04 ; $7cc4
	call QueueVRAMCopy ; $7cc6
	ret ; $7cc9
BuildMarioCastChartColumnList:
	ld c, $00 ; $7cca
.loop:
	ld hl, MarioCastChartColumnListTable ; $7ccc
	ld a, c ; $7ccf
	add a ; $7cd0
	add l ; $7cd1
	ld l, a ; $7cd2
	jr nc, .read ; $7cd3
	inc h ; $7cd5
.read:
	ld a, [hl+] ; $7cd6
	ld d, [hl] ; $7cd7
	ld e, a ; $7cd8
	ld a, d ; $7cd9
	or e ; $7cda
	cp $ff ; $7cdb
	jr z, .step ; $7cdd
	farcall TestSaveFlag ; $7cdf
	jr nz, .step ; $7ce2
	ld b, $10 ; $7ce4
	jr .step2 ; $7ce6
.step:
	ld hl, MarioCastChartColumnTable ; $7ce8
	ld a, c ; $7ceb
	add l ; $7cec
	ld l, a ; $7ced
	jr nc, .readB ; $7cee
	inc h ; $7cf0
.readB:
	ld b, [hl] ; $7cf1
.step2:
	ld hl, wChartColumnList ; $7cf2
	ld a, c ; $7cf5
	add l ; $7cf6
	ld l, a ; $7cf7
	jr nc, .store ; $7cf8
	inc h ; $7cfa
.store:
	ld [hl], b ; $7cfb
	inc c ; $7cfc
	ld a, c ; $7cfd
	cp $09 ; $7cfe
	jr nz, .loop ; $7d00
	ret ; $7d02
MarioCastChartColumnListTable:
	; $7d03, 18 bytes (records:2)
	dw $01c0 ; record 0
	dw $ffff ; record 1
	dw $01e0 ; record 2
	dw $ffff ; record 3
	dw $0160 ; record 4
	dw $ffff ; record 5
	dw $01a0 ; record 6
	dw $0140 ; record 7
	dw $0180 ; record 8
MarioCastChartColumnTable:
	; $7d15, 9 bytes (bytes:3)
	db $00, $01, $02 ; 0x00
	db $03, $04, $05 ; 0x03
	db $07, $08, $0c ; 0x06
LoadMarioCastExhibGrid:
	push_wram_bank WRAM_SCREEN ; $7d1e
	ld hl, wN64RecordsBlock ; $7d27
	farcall ReadMarioCastVictoryGrid ; $7d2a
	ld hl, wN64RecordsBlock ; $7d2d
	ld de, wChartRows ; $7d30
	ld c, $00 ; $7d33
.loop:
	push bc ; $7d35
	push hl ; $7d36
	push de ; $7d37
	ld bc, $0009 ; $7d38
	call CopyMemoryBC ; $7d3b
	pop de ; $7d3e
	ld hl, $0010 ; $7d3f
	add hl, de ; $7d42
	ld d, h ; $7d43
	ld e, l ; $7d44
	pop hl ; $7d45
	ld bc, $0009 ; $7d46
	add hl, bc ; $7d49
	pop bc ; $7d4a
	inc c ; $7d4b
	ld a, c ; $7d4c
	cp $09 ; $7d4d
	jr nz, .loop ; $7d4f
	pop_wram_bank ; $7d51
	ret ; $7d56

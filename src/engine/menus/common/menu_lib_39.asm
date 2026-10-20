LoadIndexedPalette:
	ld e, c ; $457f
	ld d, $00 ; $4580
	sla e ; $4582
	rl d ; $4584
	sla e ; $4586
	rl d ; $4588
	sla e ; $458a
	rl d ; $458c
	ld hl, IndexedPalettes ; $458e
	add hl, de ; $4591
	ld d, b ; $4592
	ld e, $01 ; $4593
	call LoadPaletteShadow ; $4595
	ret ; $4598
IndexedPalettes:
	INCLUDE "data/engine/menus/common/IndexedPalettes.asm" ; $4599, 200 bytes (palettes)
Unused_39_LoadFixedPaletteSet:
	ld hl, FixedPaletteSetPalettes ; $4661
	ld_obj_pals de, 1, 4 ; $4664
	call LoadPaletteShadow ; $4667
	ret ; $466a
FixedPaletteSetPalettes:
	INCLUDE "data/engine/menus/common/FixedPaletteSetPalettes.asm" ; $466b, 32 bytes (palettes)
LoadCompressedTileBlock:
	ldh a, [hWramBank] ; $468b
	push af ; $468d
	ld a, b ; $468e
	add a ; $468f
	ld hl, TileBlockPtrs_39 ; $4690
	add_hl_a ; $4693
	ld a, [hl+] ; $4698
	ld h, [hl] ; $4699
	ld l, a ; $469a
	push de ; $469b
	push bc ; $469c
	wram_bank WRAM_STAGING ; $469d
	ld de, wDecompBuffer ; $46a3
	call DecompressDataFromBank ; $46a6
	pop bc ; $46a9
	pop de ; $46aa
	ld hl, wDecompBuffer ; $46ab
	call QueueVRAMCopy ; $46ae
	pop_wram_bank ; $46b1
	ret ; $46b6
TileBlockPtrs_39:
	; $46b7, 244 bytes (122 records x 1 slot words)
	tileblock AwardsCeremonyConfettiGfx0 ; record 0
	tileblock AwardsCeremonyConfettiGfx1 ; record 1
	tileblock AwardsCeremonyConfettiGfx2 ; record 2
	tileblock DreamMatchEpilogueConfettiGfx0 ; record 3
	tileblock DreamMatchEpilogueConfettiGfx1 ; record 4
	tileblock DreamMatchEpilogueConfettiGfx2 ; record 5
	tileblock ToBeContinuedGfx ; record 6
	tileblock ToBeContinuedOutlineGfx ; record 7
	tileblock TheEndGfx ; record 8
	tileblock WinLoseArrowGfx ; record 9
	tileblock Unused_18_JpCourtStatLabelTiles ; record 10
	tileblock SharedMenuGfx17Alias11 ; record 11
	tileblock SharedMenuGfx17Alias12 ; record 12
	tileblock SharedMenuGfx17Alias13 ; record 13
	tileblock SharedMenuGfx17Alias14 ; record 14
	tileblock SharedMenuGfx17Alias15 ; record 15
	tileblock SharedMenuGfx17Alias16 ; record 16
	tileblock SharedMenuGfx17Alias17 ; record 17
	tileblock NameEntryUnderlineCursorGfx ; record 18
	tileblock HandednessLRSpriteGfx ; record 19
	tileblock LargeDigitArrowSpriteGfx ; record 20
	tileblock StatLabelTiles ; record 21
	tileblock MugshotTiles ; record 22
	tileblock MenuArrowRightGfx ; record 23
	tileblock MenuArrowLeftGfx ; record 24
	tileblock MenuArrowUpGfx ; record 25
	tileblock MenuArrowDownGfx ; record 26
	tileblock SharedMenuGfx27 ; record 27
	tileblock MarioTourLabelGfx ; record 28
	tileblock ExhibitionLabelGfx ; record 29
	tileblock MarioMiniGamesLabelGfx ; record 30
	tileblock LinkedPlayLabelGfx ; record 31
	tileblock StatusLabelGfx ; record 32
	tileblock DictionaryLabelGfx ; record 33
	tileblock SavedDataLabelGfx ; record 34
	tileblock SinglesLabelGfx ; record 35
	tileblock DoublesLabelGfx ; record 36
	tileblock TwoGamesLabelGfx ; record 37
	tileblock SixGamesLabelGfx ; record 38
	tileblock OneSetLabelGfx ; record 39
	tileblock ThreeSetsLabelGfx ; record 40
	tileblock FiveSetsLabelGfx ; record 41
	tileblock File1LabelGfx ; record 42
	tileblock File2LabelGfx ; record 43
	tileblock File3LabelGfx ; record 44
	tileblock N64DataLabelGfx ; record 45
	tileblock EraseFile1LabelGfx ; record 46
	tileblock EraseFile2LabelGfx ; record 47
	tileblock EraseFile3LabelGfx ; record 48
	tileblock EraseN64DataLabelGfx ; record 49
	tileblock EraseAllDataLabelGfx ; record 50
	tileblock MarioNameGfx ; record 51
	tileblock WaluigiNameGfx ; record 52
	tileblock YoshiNameGfx ; record 53
	tileblock BowserNameGfx ; record 54
	tileblock WarioNameGfx ; record 55
	tileblock PeachNameGfx ; record 56
	tileblock TournamentLabelGfx ; record 57
	tileblock RingShotLabelGfx ; record 58
	tileblock CharacterDataLabelGfx ; record 59
	tileblock N64TournamentsLabelGfx ; record 60
	tileblock SetItemsLabelGfx ; record 61
	tileblock MainMenuTitleGfxAlias4 ; record 62
	tileblock PlayMenuTitleGfx ; record 63
	tileblock SelectACourtHeadingGfx ; record 64
	tileblock SavedDataTitleGfx ; record 65
	tileblock StatusTitleGfx ; record 66
	tileblock N64DataTitleGfx ; record 67
	tileblock GbDataTitleGfx ; record 68
	tileblock EraseN64DataTitleGfx ; record 69
	tileblock EraseAllTitleGfx ; record 70
	tileblock MarioMiniGamesTitleGfx ; record 71
	tileblock CreateACharacterTitleGfx ; record 72
	tileblock NumberSpriteGfx ; record 73
	tileblock SelectRacketLabelGfx ; record 74
	tileblock SelectShoesLabelGfx ; record 75
	tileblock SetItemsTitleGfx ; record 76
	tileblock CutsceneGfx0 ; record 77
	tileblock CutsceneGfx1 ; record 78
	tileblock CutsceneGfx2 ; record 79
	tileblock CutsceneGfx3 ; record 80
	tileblock CutsceneGfx4 ; record 81
	tileblock CutsceneGfx5 ; record 82
	tileblock CutsceneGfx6 ; record 83
	tileblock IntroGfx0 ; record 84
	tileblock IntroGfx1 ; record 85
	tileblock IntroGfx2 ; record 86
	tileblock IntroGfx3 ; record 87
	tileblock IntroGfx4 ; record 88
	tileblock IntroGfx5 ; record 89
	tileblock IntroGfx6 ; record 90
	tileblock TitleGfx0 ; record 91
	tileblock TitleGfx1 ; record 92
	tileblock TitleGfx2 ; record 93
	tileblock TitleGfx3 ; record 94
	tileblock TitleGfx4 ; record 95
	tileblock TitleGfx5 ; record 96
	tileblock TitleGfx6 ; record 97
	tileblock TitleGfx7 ; record 98
	tileblock SharedMenuGfx99 ; record 99
	tileblock SelectACharacterTitleGfx ; record 100
	tileblock HardCourtNameGfx ; record 101
	tileblock ClayCourtNameGfx ; record 102
	tileblock GrassCourtNameGfx ; record 103
	tileblock CompositionCourtNameGfx ; record 104
	tileblock VarsityTeamChartNameBoxTiles ; record 105
	tileblock StarCourtNameGfxAlias16 ; record 106
	tileblock CastleCourtNameGfx ; record 107
	tileblock TropicsCourtNameGfx ; record 108
	tileblock JungleCourtNameGfx ; record 109
	tileblock WarehouseCourtNameGfx ; record 110
	tileblock QuestionMarksLabelGfx ; record 111
	tileblock Level1LabelGfx ; record 112
	tileblock Level2LabelGfx ; record 113
	tileblock ChallengeLabelGfx ; record 114
	tileblock ClearStatusLabelGfx ; record 115
	tileblock MarioStarGetsLabelGfx ; record 116
	tileblock CharGridStatLabelSpriteGfx ; record 117
	tileblock MarioCharactersLabelGfx ; record 118
	tileblock SelectALevelTitleGfxAlias16 ; record 119
	tileblock MarioCharactersTitleGfx ; record 120
	tileblock DigitFontTiles ; record 121
SharedMenuGfx17:
	INCBIN "data/engine/menus/common/lz_SharedMenuGfx17.bin" ; $47ab, 79 bytes
NameEntryUnderlineCursorGfx:
	INCBIN "data/engine/menus/common/lz_NameEntryUnderlineCursorGfx.bin" ; $47fa, 15 bytes
HandednessLRSpriteGfx:
	INCBIN "data/engine/menus/common/lz_HandednessLRSpriteGfx.bin" ; $4809, 42 bytes
LargeDigitArrowSpriteGfx:
	INCBIN "data/engine/menus/common/lz_LargeDigitArrowSpriteGfx.bin" ; $4833, 240 bytes
StatLabelTiles:
	INCBIN "data/engine/menus/common/lz_StatLabelTiles.bin" ; $4923, 243 bytes
LoadMenuArrowSpriteTiles:
	ld c, $04 ; $4a16
	ld b, TILEBLOCK_MenuArrowRightGfx ; $4a18
	push de ; $4a1a
	call LoadCompressedTileBlock ; $4a1b
	pop hl ; $4a1e
	ld de, $0040 ; $4a1f
	add hl, de ; $4a22
	ld d, h ; $4a23
	ld e, l ; $4a24
	ld c, $04 ; $4a25
	ld b, TILEBLOCK_MenuArrowLeftGfx ; $4a27
	push de ; $4a29
	call LoadCompressedTileBlock ; $4a2a
	pop hl ; $4a2d
	ld de, $0040 ; $4a2e
	add hl, de ; $4a31
	ld d, h ; $4a32
	ld e, l ; $4a33
	ld c, $04 ; $4a34
	ld b, TILEBLOCK_MenuArrowUpGfx ; $4a36
	push de ; $4a38
	call LoadCompressedTileBlock ; $4a39
	pop hl ; $4a3c
	ld de, $0040 ; $4a3d
	add hl, de ; $4a40
	ld d, h ; $4a41
	ld e, l ; $4a42
	ld c, $04 ; $4a43
	ld b, TILEBLOCK_MenuArrowDownGfx ; $4a45
	push de ; $4a47
	call LoadCompressedTileBlock ; $4a48
	pop hl ; $4a4b
	ld de, $0040 ; $4a4c
	add hl, de ; $4a4f
	ld d, h ; $4a50
	ld e, l ; $4a51
	ret ; $4a52
QueueStackedSpritePair:
	push af ; $4a53
	push bc ; $4a54
	push de ; $4a55
	push hl ; $4a56
	ld a, h ; $4a57
	add a ; $4a58
	add a ; $4a59
	add c ; $4a5a
	ld c, a ; $4a5b
	push af ; $4a5c
	push bc ; $4a5d
	push de ; $4a5e
	push hl ; $4a5f
	call QueueSprite ; $4a60
	pop hl ; $4a63
	pop de ; $4a64
	pop bc ; $4a65
	pop af ; $4a66
	ld a, $08 ; $4a67
	add d ; $4a69
	ld d, a ; $4a6a
	inc c ; $4a6b
	inc c ; $4a6c
	call QueueSprite ; $4a6d
	pop hl ; $4a70
	pop de ; $4a71
	pop bc ; $4a72
	pop af ; $4a73
	ret ; $4a74
ApplySpriteWaveOffset:
	ldh a, [hVBlankCounter] ; $4a75
	and $3f ; $4a77
	ld_hl_indexed ApplySpriteWaveOffsetTable ; $4a79
	ld a, [hl] ; $4a80
	add e ; $4a81
	ld e, a ; $4a82
	ret ; $4a83
ApplySpriteWaveOffsetTable:
	; $4a84, 64 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03 ; 0x00
	db $03, $03, $03, $03, $03, $03, $03, $03, $02, $02, $02, $01, $01, $01, $00, $00 ; 0x10
	db $00, $00, $00, $ff, $ff, $ff, $fe, $fe, $fe, $fd, $fd, $fd, $fd, $fd, $fd, $fd ; 0x20
	db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fe, $fe, $fe, $ff, $ff, $ff, $00, $00 ; 0x30
ApplySpriteBobOffset:
	ldh a, [hVBlankCounter] ; $4ac4
	and $3f ; $4ac6
	ld_hl_indexed ApplySpriteBobOffsetTable ; $4ac8
	ld a, [hl] ; $4acf
	add e ; $4ad0
	ld e, a ; $4ad1
	ret ; $4ad2
ApplySpriteBobOffsetTable:
	; $4ad3, 64 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02 ; 0x00
	db $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x10
	db $00, $00, $00, $00, $00, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $fe, $fe, $fe, $fe ; 0x20
	db $fe, $fe, $fe, $fe, $fe, $fe, $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; 0x30
InitMenuBgScroll:
	ld a, $01 ; $4b13
	ld [wMenuBgScrollAttr], a ; $4b15
	ld a, $01 ; $4b18
	ld [wMenuBgScrollAttr + 1], a ; $4b1a
	xor a ; $4b1d
	ld [wMenuBgScrollX], a ; $4b1e
	ld a, $40 ; $4b21
	ld [wMenuBgScrollY], a ; $4b23
	add $86 ; $4b26
	ld [wMenuBgScrollY + 1], a ; $4b28
	ld a, $00 ; $4b2b
	ld [wMenuBgScrollTile], a ; $4b2d
	ld a, $00 ; $4b30
	ld [wMenuBgScrollTile + 1], a ; $4b32
	xor a ; $4b35
	ld [wMenuBgScrollLane], a ; $4b36
	ret ; $4b39
LoadMenuSpritePalettePair:
	push bc ; $4b3a
	ld a, c ; $4b3b
	add $08 ; $4b3c
	ld d, a ; $4b3e
	ld e, $01 ; $4b3f
	ld hl, MenuSpritePalettePairPalettes ; $4b41
	call LoadPaletteShadow ; $4b44
	pop bc ; $4b47
	ld a, b ; $4b48
	add $08 ; $4b49
	ld d, a ; $4b4b
	ld e, $01 ; $4b4c
	ld hl, MenuSpritePalettePairPalettes ; $4b4e
	call LoadPaletteShadow ; $4b51
	ret ; $4b54
Unused_39_MenuSpritePalettes:
	; $4b55, 16 bytes (records:2)
	dw $0004 ; record 0
	dw $00af ; record 1
	dw $015f ; record 2
	dw $031f ; record 3
	dw $1088 ; record 4
	dw $1133 ; record 5
	dw $11df ; record 6
	dw $139f ; record 7
MenuSpritePalettePairPalettes:
	; $4b65, 8 bytes (records:2)
	dw $0000 ; record 0
	dw $018f ; record 1
	dw $031f ; record 2
	dw $031f ; record 3
TickMenuBgScroll:
	ld a, [wMenuBgScrollY] ; $4b6d
	dec a ; $4b70
	cp $b0 ; $4b71
	jr nz, .storeLane0Y ; $4b73
	ld a, $a0 ; $4b75
.storeLane0Y:
	ld [wMenuBgScrollY], a ; $4b77
	ld a, [wMenuBgScrollY + 1] ; $4b7a
	dec a ; $4b7d
	cp $b0 ; $4b7e
	jr nz, .storeLane1Y ; $4b80
	ld a, $a0 ; $4b82
.storeLane1Y:
	ld [wMenuBgScrollY + 1], a ; $4b84
	ld a, [wMenuBgScrollLane] ; $4b87
	or a ; $4b8a
	jr nz, .secondSprite ; $4b8b
	ld a, [wMenuBgScrollY] ; $4b8d
	ld d, a ; $4b90
	ld a, [wMenuBgScrollTile] ; $4b91
	ld c, a ; $4b94
	ld a, [wMenuBgScrollAttr] ; $4b95
	ld b, a ; $4b98
	ld a, [wMenuBgScrollX] ; $4b99
	ld e, a ; $4b9c
	ld a, $01 ; $4b9d
	ld [wMenuBgScrollLane], a ; $4b9f
	jr .queueSprite ; $4ba2
.secondSprite:
	ld a, [wMenuBgScrollY + 1] ; $4ba4
	ld d, a ; $4ba7
	ld a, [wMenuBgScrollTile + 1] ; $4ba8
	ld c, a ; $4bab
	ld a, [wMenuBgScrollAttr + 1] ; $4bac
	ld b, a ; $4baf
	ld a, [wMenuBgScrollX] ; $4bb0
	ld e, a ; $4bb3
	xor a ; $4bb4
	ld [wMenuBgScrollLane], a ; $4bb5
.queueSprite:
	ld hl, TickMenuBgScroll_SpriteTemplate ; $4bb8
	call QueueSpriteTemplate ; $4bbb
	ret ; $4bbe
TickMenuBgScroll_SpriteTemplate:
	; $4bbf, 41 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite $10, $48, $10, $00
	oam_sprite $10, $50, $12, $00
	oam_sprite_end
LoadMenuFontTiles:
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $4be8
	ld c, SharedMenuGfx17_SIZE / 16 ; $4bea
	ld de, vTiles2 ; $4bec
	farcall LoadCompressedTileBlock ; $4bef
	ret ; $4bf2
ResetScreenAndTextWindows:
	ldh [hScrollX], a ; $4bf3
	ldh [hScrollY], a ; $4bf5
	ld [wCameraX], a ; $4bf7
	ld [wCameraX + 1], a ; $4bfa
	ld [wCameraY], a ; $4bfd
	ld [wCameraY + 1], a ; $4c00
	farcall LoadStadiumBgGraphics ; $4c03
	farcall ResetTextWindowState ; $4c06
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $4c09
	ld c, SharedMenuGfx17_SIZE / 16 ; $4c0b
	ld de, vTiles2 ; $4c0d
	farcall LoadCompressedTileBlock ; $4c10
	wram_bank WRAM_TEXT ; $4c13
	ld a, WRAM_SCREEN ; $4c19
	ld [wShadowTilemapBank], a ; $4c1b
	ld a, $00 ; $4c1e
	ld [wWindowTileAttr], a ; $4c20
	rect_cell $00, $0f ; $4c23
	rect_size $14, $03 ; $4c27
	farcall CreateWindowFromScreenRect ; $4c2b
	farcall DrawTextWindowFrame ; $4c2e
	farcall RedrawWindowRows ; $4c31
	farcall QueueWram3MapToVRAM ; $4c34
	ret ; $4c37
LoadStadiumBgGraphics:
	push_wram_bank WRAM_STAGING ; $4c38
	ld_slot hl, DataPtr_StadiumTiles ; $4c41
	ld de, wDecompBuffer ; $4c44
	call DecompressDataFromBank ; $4c47
	ld hl, wDecompBuffer ; $4c4a
	ld de, vTiles2 + VRAM_BANK1 ; $4c4d
	ld c, 128 ; $4c50
	call QueueVRAMCopy ; $4c52
	ld hl, wDecompBufferHigh ; $4c55
	ld de, vTiles1 + VRAM_BANK1 ; $4c58
	ld c, wDecompBufferHigh_SIZE / 16 ; $4c5b
	call QueueVRAMCopy ; $4c5d
	wram_bank WRAM_SCREEN ; $4c60
	ld_slot hl, DataPtr_StadiumTilemap ; $4c66
	ld de, wShadowTilemap ; $4c69
	call DecompressDataFromBank ; $4c6c
	ld_slot hl, DataPtr_StadiumTilemap ; $4c6f
	ld de, wStadiumTilemapCopy ; $4c72
	call DecompressDataFromBank ; $4c75
	ld_slot hl, DataPtr_StadiumAttrmap ; $4c78
	ld de, wShadowAttrmap ; $4c7b
	call DecompressDataFromBank ; $4c7e
	ld_slot hl, DataPtr_StadiumAttrmap ; $4c81
	ld de, wStadiumAttrmapCopy ; $4c84
	call DecompressDataFromBank ; $4c87
	wram_bank WRAM_STAGING ; $4c8a
	ld_slot hl, DataPtr_StadiumPalettes ; $4c90
	ld de, wDecompBuffer ; $4c93
	ld bc, $0040 ; $4c96
	call CopyDataFromBank ; $4c99
	ld hl, wDecompBuffer ; $4c9c
	ld_bg_pals de, 0, 8 ; $4c9f
	call LoadPaletteShadow ; $4ca2
	pop_wram_bank ; $4ca5
	ret ; $4caa

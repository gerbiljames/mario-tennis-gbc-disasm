Unused_18_CopyBytes11:
	ld a, [hl+] ; $55b9
	ld [de], a ; $55ba
	inc de ; $55bb
	ld a, [hl+] ; $55bc
	ld [de], a ; $55bd
	inc de ; $55be
	ld a, [hl+] ; $55bf
	ld [de], a ; $55c0
	inc de ; $55c1
	ld a, [hl+] ; $55c2
	ld [de], a ; $55c3
	inc de ; $55c4
	ld a, [hl+] ; $55c5
	ld [de], a ; $55c6
	inc de ; $55c7
	ld a, [hl+] ; $55c8
	ld [de], a ; $55c9
	inc de ; $55ca
	ld a, [hl+] ; $55cb
	ld [de], a ; $55cc
	inc de ; $55cd
	ld a, [hl+] ; $55ce
	ld [de], a ; $55cf
	inc de ; $55d0
	ld a, [hl+] ; $55d1
	ld [de], a ; $55d2
	inc de ; $55d3
	ld a, [hl+] ; $55d4
	ld [de], a ; $55d5
	inc de ; $55d6
	ld a, [hl+] ; $55d7
	ld [de], a ; $55d8
	inc de ; $55d9
	ret ; $55da
Unused_18_ClearTileVramBothBanks:
	ld hl, vTiles0 ; $55db
	ld c, $80 ; $55de
	call ClearMemory16 ; $55e0
	ldh a, [rVBK] ; $55e3
	xor VBK_BANK ; $55e5
	ldh [rVBK], a ; $55e7
	ld hl, vTiles0 ; $55e9
	ld c, $80 ; $55ec
	call ClearMemory16 ; $55ee
	ldh a, [rVBK] ; $55f1
	xor VBK_BANK ; $55f3
	ldh [rVBK], a ; $55f5
	ret ; $55f7
Unused_18_LoadJpLevelUpSpriteGfx:
	ld hl, Unused_18_JpLevelUpBannerGfx ; $55f8
	ld de, wDecompBuffer ; $55fb
	call DecompressData ; $55fe
	ld hl, wDecompBuffer ; $5601
	ld de, vTiles0 + VRAM_BANK1 ; $5604
	ld c, Unused_18_JpLevelUpBannerGfx_SIZE / 16 ; $5607
	call QueueVRAMCopy ; $5609
	ld hl, Unused_18_JpLevelUpBannerPalette ; $560c
	ld_obj_pals de, 4, 3 ; $560f
	call LoadPalettesImmediate ; $5612
	ld hl, Unused_18_JpLevelUpSparkleGfx ; $5615
	ld de, wDecompBuffer ; $5618
	call DecompressData ; $561b
	ld hl, wDecompBuffer ; $561e
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $5621
	ld c, Unused_18_JpLevelUpSparkleGfx_SIZE / 16 ; $5624
	call QueueVRAMCopy ; $5626
	ld hl, Unused_18_JpLevelUpSparklePalette ; $5629
	ld_obj_pals de, 0, 1 ; $562c
	call LoadPalettesImmediate ; $562f
	ret ; $5632
Unused_18_JpLevelUpBannerGfx:
	INCBIN "data/engine/menus/scenes/lz_Unused_18_JpLevelUpBannerGfx.bin" ; $5633, 449 bytes
	INCLUDE "data/engine/menus/scenes/lz_Unused_18_JpLevelUpBannerGfx.inc" ; DEF Unused_18_JpLevelUpBannerGfx_SIZE EQU its decoded length, generated from the .bin by make
; A QueueSpriteTemplate list: 14 records of (dy $10, dx $08+8n, tile 2n, attr 0) then the $80 terminator -- one horizontal strip of 14 sprites. Nothing references it.
Unused_18_JpLevelUpBannerTemplate:
	; $57f4, 57 bytes (sprite_template)
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
	oam_sprite $10, $58, $14, $00
	oam_sprite $10, $60, $16, $00
	oam_sprite $10, $68, $18, $00
	oam_sprite $10, $70, $1a, $00
	oam_sprite_end
Unused_18_JpLevelUpBannerPalette:
	INCLUDE "data/engine/menus/scenes/Unused_18_JpLevelUpBannerPalette.asm" ; $582d, 24 bytes (palettes)
Unused_18_JpLevelUpSparkleGfx:
	INCBIN "data/engine/menus/scenes/lz_Unused_18_JpLevelUpSparkleGfx.bin" ; $5845, 104 bytes
	INCLUDE "data/engine/menus/scenes/lz_Unused_18_JpLevelUpSparkleGfx.inc" ; DEF Unused_18_JpLevelUpSparkleGfx_SIZE EQU its decoded length, generated from the .bin by make
Unused_18_JpLevelUpSparklePalette:
	INCLUDE "data/engine/menus/scenes/Unused_18_JpLevelUpSparklePalette.asm" ; $58ad, 48 bytes (palettes)
Padding_18_1:
	; $58dd, 3 bytes (fill)
	ds 3, $00
	ds ALIGN[4]
CharSelectCursorGfx:
	INCBIN "data/engine/menus/scenes/CharSelectCursorGfx.bin" ; $58e0, 192 bytes
Unused_18_CharSelectCursorTemplate:
	; $59a0, 25 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite_end
CharSelectCursorPalette:
	INCLUDE "data/engine/menus/scenes/CharSelectCursorPalette.asm" ; $59b9, 8 bytes (palettes)
Unused_18_LoadCharSelectCursorGfx:
	ld hl, CharSelectCursorGfx ; $59c1
	ld de, vTiles0 tile $40 ; $59c4
	ld c, (Unused_18_CharSelectCursorTemplate - CharSelectCursorGfx) / 16 ; $59c7
	call QueueVRAMCopy ; $59c9
	ld hl, CharSelectCursorPalette ; $59cc
	ld_obj_pals de, 2, 1 ; $59cf
	call LoadPaletteShadow ; $59d2
	ret ; $59d5
Unused_18_DrawCharSelectCursor:
	ld c, $00 ; $59d6
	cp $84 ; $59d8
	jr nz, .animate ; $59da
	ld c, $01 ; $59dc
.animate:
	ldh a, [hVBlankCounter] ; $59de
	and $1f ; $59e0
	ld_hl_indexed CharSelectCursorAnimTable ; $59e2
	ld a, c ; $59e9
	add a ; $59ea
	add [hl] ; $59eb
	add a ; $59ec
	ld_hl_indexed CharSelectCursorTemplatePtrs ; $59ed
	ld a, [hl+] ; $59f4
	ld h, [hl] ; $59f5
	ld l, a ; $59f6
	ld_oam bc, 2, $40 ; $59f7
	call QueueSpriteTemplate ; $59fa
	ret ; $59fd
CharSelectCursorAnimTable:
	INCLUDE "data/engine/menus/scenes/CharSelectCursorAnimTable.asm" ; $59fe, 32 bytes (bytes:16)
CharSelectCursorTemplatePtrs:
	; $5a1e, 8 bytes (records:2)
	dw CharSelectCursorTemplate0 ; record 0
	dw CharSelectCursorTemplate1 ; record 1
	dw CharSelectCursorTemplate2 ; record 2
	dw CharSelectCursorTemplate3 ; record 3
CharSelectCursorTemplate0:
	; $5a26, 17 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $18, $08, $00, $40
	oam_sprite $10, $18, $00, $20
	oam_sprite $18, $18, $00, $60
	oam_sprite_end
CharSelectCursorTemplate1:
	; $5a37, 17 bytes (sprite_template)
	oam_sprite $0f, $07, $00, $00
	oam_sprite $19, $07, $00, $40
	oam_sprite $0f, $19, $00, $20
	oam_sprite $19, $19, $00, $60
	oam_sprite_end
CharSelectCursorTemplate2:
	; $5a48, 17 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $18, $08, $00, $40
	oam_sprite $10, $48, $00, $20
	oam_sprite $18, $48, $00, $60
	oam_sprite_end
CharSelectCursorTemplate3:
	; $5a59, 17 bytes (sprite_template)
	oam_sprite $0f, $07, $00, $00
	oam_sprite $19, $07, $00, $40
	oam_sprite $0f, $49, $00, $20
	oam_sprite $19, $49, $00, $60
	oam_sprite_end
Unused_18_ApplySpriteBobOffset:
	ldh a, [hVBlankCounter] ; $5a6a
	and $3f ; $5a6c
	ld_hl_indexed SpriteBobRamp_18 ; $5a6e
	ld a, [hl] ; $5a75
	add e ; $5a76
	ld e, a ; $5a77
	ret ; $5a78
SpriteBobRamp_18:
	; $5a79, 64 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03 ; 0x00
	db $03, $03, $03, $03, $03, $03, $03, $03, $02, $02, $02, $01, $01, $01, $00, $00 ; 0x10
	db $00, $00, $00, $ff, $ff, $ff, $fe, $fe, $fe, $fd, $fd, $fd, $fd, $fd, $fd, $fd ; 0x20
	db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fe, $fe, $fe, $ff, $ff, $ff, $00, $00 ; 0x30
LoadOnCourtCharTilesA:
	ld h, a ; $5ab9
	ld l, $00 ; $5aba
	srl h ; $5abc
	rr l ; $5abe
	srl h ; $5ac0
	rr l ; $5ac2
	ld bc, OnCourtCharTilesAGfx ; $5ac4
	add hl, bc ; $5ac7
	ld c, 4 ; $5ac8
	call QueueVRAMCopy ; $5aca
	ret ; $5acd
LoadOnCourtCharTilesB:
	cp $ff ; $5ace
	jr z, LoadOnCourtCharTilesFallback ; $5ad0
	ld h, a ; $5ad2
	ld l, $00 ; $5ad3
	srl h ; $5ad5
	rr l ; $5ad7
	srl h ; $5ad9
	rr l ; $5adb
	ld bc, OnCourtCharTilesBGfx ; $5add
	add hl, bc ; $5ae0
	ld c, 4 ; $5ae1
	call QueueVRAMCopy ; $5ae3
	ret ; $5ae6
LoadOnCourtCharTilesFallback:
	ld hl, OnCourtCharTilesFallbackGfx ; $5ae7
	ld c, (MushroomAnimFrame00 - OnCourtCharTilesFallbackGfx) / 16 ; $5aea
	call QueueVRAMCopy ; $5aec
	ret ; $5aef
	ds ALIGN[4]
OnCourtCharTilesAGfx:
	INCBIN "data/engine/menus/scenes/OnCourtCharTilesAGfx.bin" ; $5af0, 2048 bytes
	ds ALIGN[4]
OnCourtCharTilesBGfx:
	INCBIN "data/engine/menus/scenes/OnCourtCharTilesBGfx.bin" ; $62f0, 2048 bytes
	ds ALIGN[4]
OnCourtCharTilesFallbackGfx:
	INCBIN "data/engine/menus/scenes/OnCourtCharTilesFallbackGfx.bin" ; $6af0, 64 bytes
MushroomAnimFrame00:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame00.bin" ; $6b30, 67 bytes
MushroomAnimFrame01:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame01.bin" ; $6b73, 66 bytes
MushroomAnimFrame02:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame02.bin" ; $6bb5, 62 bytes
MushroomAnimFrame03:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame03.bin" ; $6bf3, 48 bytes
MushroomAnimFrame04:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame04.bin" ; $6c23, 44 bytes
MushroomAnimFrame05:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame05.bin" ; $6c4f, 46 bytes
MushroomAnimFrame06:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame06.bin" ; $6c7d, 59 bytes
MushroomAnimFrame07:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame07.bin" ; $6cb8, 65 bytes
MushroomAnimFrame08:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame08.bin" ; $6cf9, 67 bytes
MushroomAnimFrame09:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame09.bin" ; $6d3c, 65 bytes
MushroomAnimFrame10:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame10.bin" ; $6d7d, 60 bytes
MushroomAnimFrame11:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame11.bin" ; $6db9, 50 bytes
MushroomAnimFrame12:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame12.bin" ; $6deb, 45 bytes
MushroomAnimFrame13:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame13.bin" ; $6e18, 51 bytes
MushroomAnimFrame14:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame14.bin" ; $6e4b, 61 bytes
MushroomAnimFrame15:
	INCBIN "data/engine/menus/scenes/lz_MushroomAnimFrame15.bin" ; $6e88, 66 bytes
InvertedStarAnimFrame00:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame00.bin" ; $6eca, 73 bytes
InvertedStarAnimFrame01:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame01.bin" ; $6f13, 68 bytes
InvertedStarAnimFrame02:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame02.bin" ; $6f57, 64 bytes
InvertedStarAnimFrame03:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame03.bin" ; $6f97, 59 bytes
InvertedStarAnimFrame04:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame04.bin" ; $6fd2, 53 bytes
InvertedStarAnimFrame05:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame05.bin" ; $7007, 57 bytes
InvertedStarAnimFrame06:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame06.bin" ; $7040, 66 bytes
InvertedStarAnimFrame07:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame07.bin" ; $7082, 73 bytes
InvertedStarAnimFrame08:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame08.bin" ; $70cb, 71 bytes
InvertedStarAnimFrame09:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame09.bin" ; $7112, 68 bytes
InvertedStarAnimFrame10:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame10.bin" ; $7156, 66 bytes
InvertedStarAnimFrame11:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame11.bin" ; $7198, 64 bytes
InvertedStarAnimFrame12:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame12.bin" ; $71d8, 58 bytes
InvertedStarAnimFrame13:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame13.bin" ; $7212, 60 bytes
InvertedStarAnimFrame14:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame14.bin" ; $724e, 68 bytes
InvertedStarAnimFrame15:
	INCBIN "data/engine/menus/scenes/lz_InvertedStarAnimFrame15.bin" ; $7292, 73 bytes
MarioMiniGamesTilemap:
	INCBIN "data/engine/menus/scenes/lz_MarioMiniGamesTilemap.bin" ; $72db, 304 bytes
MarioMiniGamesAttrmap:
	INCBIN "data/engine/menus/scenes/lz_MarioMiniGamesAttrmap.bin" ; $740b, 214 bytes
MarioMiniGamesPalettes:
	INCLUDE "data/engine/menus/scenes/MarioMiniGamesPalettes.asm" ; $74e1, 64 bytes (palettes)
WinLoseArrowGfx:
	INCBIN "data/engine/menus/scenes/lz_WinLoseArrowGfx.bin" ; $7521, 71 bytes
Unused_18_JpCourtStatLabelTiles:
	INCBIN "data/engine/menus/scenes/lz_Unused_18_JpCourtStatLabelTiles.bin" ; $7568, 175 bytes
RunStorySceneByMode:
	ld a, c ; $7617
	ld [wStorySceneAssetIndex], a ; $7618
	call FadeOutAndResetScreen ; $761b
	ld a, b ; $761e
	or a ; $761f
	jr nz, .checkMode1 ; $7620
	call PlayTravelingTeamVictoryScene ; $7622
	ret ; $7625
.checkMode1:
	cp $01 ; $7626
	jr nz, .mode2 ; $7628
	call PlayAwardsCeremonyScene ; $762a
	ret ; $762d
.mode2:
	call PlayDreamMatchEpilogueScene ; $762e
	ret ; $7631
FadeOutAndResetScreen:
	call EnableLCD ; $7632
	script_fade_out 16 ; $7635
	call WaitFadeEnd ; $763a
	call DisableLCDSafely ; $763d
	call ClearFrameTasks ; $7640
	call ResetScrollAndCamera ; $7643
	ret ; $7646
ResetScrollAndCamera:
	xor a ; $7647
	ldh [hScrollX], a ; $7648
	ldh [hScrollY], a ; $764a
	ld [wCameraX], a ; $764c
	ld [wCameraX + 1], a ; $764f
	ld [wCameraY], a ; $7652
	ld [wCameraY + 1], a ; $7655
	ret ; $7658
Unused_18_DebugScreenAssetViewer:
	call FadeOutAndResetScreen ; $7659
	ld c, $00 ; $765c
.screenLoop:
	push bc ; $765e
	ld a, c ; $765f
	ld hl, DebugScreenAssetViewerRecords ; $7660
	add_hl_a ; $7663
	ld c, [hl] ; $7668
	push bc ; $7669
	script_fade_out 16 ; $766a
	call WaitFadeEnd ; $766f
	call DisableLCDSafely ; $7672
	pop bc ; $7675
	farcall LoadScreenAssetRecord ; $7676
	farcall QueueWram3MapToVRAM ; $7679
	call EnableLCD ; $767c
	script_fade_in 16 ; $767f
	call WaitFadeEnd ; $7684
.inputLoop:
	call AdvanceFrame ; $7687
	ldh a, [hInputPressed] ; $768a
	or a ; $768c
	jr z, .inputLoop ; $768d
	pop bc ; $768f
	ld a, c ; $7690
	inc a ; $7691
	ld c, a ; $7692
	cp $18 ; $7693
	jr nz, .screenLoop ; $7695
	ld c, $00 ; $7697
	jr .screenLoop ; $7699
	ret ; $769b
DebugScreenAssetViewerRecords:
	; $769c, 24 bytes (bytes:12)
	db SCREENASSET_VictoryCutscene, SCREENASSET_VictoryCutscene2, SCREENASSET_VictoryCutscene3, SCREENASSET_VictoryCutscene4, SCREENASSET_VictoryCutscene5, SCREENASSET_VictoryCutscene6, SCREENASSET_AwardsCeremonyCutscene, SCREENASSET_AwardsCeremonyCutscene2, SCREENASSET_AwardsCeremonyCutscene3, SCREENASSET_AwardsCeremonyCutscene4, SCREENASSET_AwardsCeremonyCutscene5, SCREENASSET_AwardsCeremonyCutscene6 ; 0x00
	db SCREENASSET_DreamMatchEpilogue, SCREENASSET_DreamMatchEpilogue2, SCREENASSET_DreamMatchEpilogue3, SCREENASSET_DreamMatchEpilogue4, SCREENASSET_DreamMatchEpilogue5, SCREENASSET_DreamMatchEpilogue6, SCREENASSET_ChampionMedal, SCREENASSET_ChampionMedal2, SCREENASSET_ChampionMedal3, SCREENASSET_ChampionMedal4, SCREENASSET_ChampionMedal5, SCREENASSET_ChampionMedal6 ; 0x0c
PlayTravelingTeamVictoryScene:
	call SetupTravelingTeamVictoryScreen ; $76b4
	call LoadToBeContinuedGfx ; $76b7
	call EnableLCD ; $76ba
	script_fade_in 2 ; $76bd
	call WaitFadeEnd ; $76c2
	wram_bank WRAM_SCREEN ; $76c5
	xor a ; $76cb
	ld [wScreenSequenceTimer], a ; $76cc
.scrollLoop:
	call AdvanceFrame ; $76cf
	ld a, [wScreenSequenceTimer] ; $76d2
	inc a ; $76d5
	ld [wScreenSequenceTimer], a ; $76d6
	cp $fa ; $76d9
	jr nz, .scrollLoop ; $76db
	farcall InitSepiaPaletteFade ; $76dd
	ld b, $3f ; $76e0
	ld c, $3f ; $76e2
	ld d, $1e ; $76e4
	farcall SetupPaletteFadeMask ; $76e6
	farcall AnimatePaletteFadeToTarget ; $76e9
.waitInput:
	call AdvanceFrame ; $76ec
	ldh a, [hInputPressed] ; $76ef
	and PADF_A | PADF_B ; $76f1
	jr z, .waitInput ; $76f3
	script_fade_out 16 ; $76f5
	call WaitFadeEnd ; $76fa
	call DisableLCDSafely ; $76fd
	call FillAllBgPalettes ; $7700
	call EnableLCD ; $7703
	script_fade_in 16 ; $7706
	call WaitFadeEnd ; $770b
	frame_task QueueToBeContinuedSprites ; $770e
.waitDismiss:
	call AdvanceFrame ; $7716
	ldh a, [hInputPressed] ; $7719
	and PADF_A | PADF_B ; $771b
	jr z, .waitDismiss ; $771d
	ret ; $771f
SetupTravelingTeamVictoryScreen:
	call ResetScrollAndCamera ; $7720
	call LookupTravelingTeamVictoryAssetId ; $7723
	farcall LoadScreenAssetRecord ; $7726
	farcall QueueWram3MapToVRAM ; $7729
	ret ; $772c
LookupTravelingTeamVictoryAssetId:
	ld a, [wStorySceneAssetIndex] ; $772d
	ld hl, TravelingTeamVictoryAssetIds ; $7730
	add_hl_a ; $7733
	ld c, [hl] ; $7738
	ret ; $7739
TravelingTeamVictoryAssetIds:
	; $773a, 6 bytes (bytes:6)
	db SCREENASSET_VictoryCutscene, SCREENASSET_VictoryCutscene2, SCREENASSET_VictoryCutscene4, SCREENASSET_VictoryCutscene3, SCREENASSET_VictoryCutscene5, SCREENASSET_VictoryCutscene6 ; 0x00
LoadToBeContinuedGfx:
	ld b, TILEBLOCK_ToBeContinuedGfx ; $7740
	ld c, ToBeContinuedGfx_SIZE / 16 ; $7742
	ld de, vTiles0 ; $7744
	farcall LoadCompressedTileBlock ; $7747
	ld hl, ToBeContinuedPalette ; $774a
	ld_obj_pals de, 0, 1 ; $774d
	call LoadPaletteShadow ; $7750
	ret ; $7753
ToBeContinuedPalette:
	INCLUDE "data/engine/menus/scenes/ToBeContinuedPalette.asm" ; $7754, 8 bytes (palettes)
QueueToBeContinuedSprites:
	ld hl, QueueToBeContinuedSprites_SpriteTemplate ; $775c
	ld_xy de, $28, $3a ; $775f
	sprite_tile_attr $00, 0 ; $7762
	call QueueSpriteTemplate ; $7766
	ret ; $7769
QueueToBeContinuedSprites_SpriteTemplate:
	; $776a, 81 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite $10, $38, $18, $00
	oam_sprite $20, $38, $1a, $00
	oam_sprite $10, $40, $1c, $00
	oam_sprite $20, $40, $1e, $00
	oam_sprite $10, $48, $20, $00
	oam_sprite $20, $48, $22, $00
	oam_sprite $10, $50, $24, $00
	oam_sprite $20, $50, $26, $00
	oam_sprite_end

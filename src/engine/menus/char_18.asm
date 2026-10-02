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
	xor $01 ; $55e5
	ldh [rVBK], a ; $55e7
	ld hl, vTiles0 ; $55e9
	ld c, $80 ; $55ec
	call ClearMemory16 ; $55ee
	ldh a, [rVBK] ; $55f1
	xor $01 ; $55f3
	ldh [rVBK], a ; $55f5
	ret ; $55f7
Unused_18_LoadConfirmScreenSpriteGfx:
	ld hl, ConfirmScreenSpriteGfx0 ; $55f8
	ld de, wDecompBuffer ; $55fb
	call DecompressData ; $55fe
	ld hl, wDecompBuffer ; $5601
	ld de, vTiles0 + VRAM_BANK1 ; $5604
	ld c, ConfirmScreenSpriteGfx0_SIZE / 16 ; $5607
	call QueueVRAMCopy ; $5609
	ld hl, ConfirmScreenSpritePalette0 ; $560c
	ld_obj_pals de, 4, 3 ; $560f
	call LoadPalettesImmediate ; $5612
	ld hl, ConfirmScreenSpriteGfx1 ; $5615
	ld de, wDecompBuffer ; $5618
	call DecompressData ; $561b
	ld hl, wDecompBuffer ; $561e
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $5621
	ld c, $0c ; $5624
	call QueueVRAMCopy ; $5626
	ld hl, ConfirmScreenSpritePalette1 ; $5629
	ld_obj_pals de, 0, 1 ; $562c
	call LoadPalettesImmediate ; $562f
	ret ; $5632
ConfirmScreenSpriteGfx0:
	INCBIN "data/bank_018/lz_ConfirmScreenSpriteGfx0.bin" ; $5633, 449 bytes
	INCLUDE "data/bank_018/lz_ConfirmScreenSpriteGfx0.inc" ; DEF ConfirmScreenSpriteGfx0_SIZE EQU its decoded length, generated from the .bin by make
; A QueueSpriteTemplate list: 14 records of (dy $10, dx $08+8n, tile 2n, attr 0) then the $80 terminator -- one horizontal strip of 14 sprites. It sat inside ConfirmScreenSpriteGfx0's blob until that stream was sized by decoding it; nothing references it, which is why the sprite-template carve never saw it
ConfirmScreenSpriteTemplate:
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
ConfirmScreenSpritePalette0:
	INCLUDE "data/bank_018/ConfirmScreenSpritePalette0.asm" ; $582d, 24 bytes (palettes)
ConfirmScreenSpriteGfx1:
	INCBIN "data/bank_018/ConfirmScreenSpriteGfx1.bin" ; $5845, 77 bytes
TwoOptionSelectBTable:
	; $5892, 27 bytes (bytes:16)
	db $92, $ec, $e1, $10, $6c, $7c, $d5, $e2, $92, $e8, $e7, $00, $de, $e5, $b4, $e3 ; 0x00
	db $88, $e3, $c8, $e9, $da, $ef, $ff, $eb, $00, $00, $00 ; 0x10
ConfirmScreenSpritePalette1:
	INCLUDE "data/bank_018/ConfirmScreenSpritePalette1.asm" ; $58ad, 48 bytes (palettes)
ConfirmScreenSpritePalette1Pad:
	; $58dd, 3 bytes (fill)
	ds 3, $00
	ds ALIGN[4]
CharSelectCursorGfx:
	INCBIN "data/bank_018/CharSelectCursorGfx.bin" ; $58e0, 217 bytes
CharSelectCursorPalette:
	INCLUDE "data/bank_018/CharSelectCursorPalette.asm" ; $59b9, 8 bytes (palettes)
Unused_18_LoadCharSelectCursorGfx:
	ld hl, CharSelectCursorGfx ; $59c1
	ld de, vTiles0 + $40 * TILE_SIZE ; $59c4
	ld c, $0c ; $59c7 -- 12 of CharSelectCursorGfx's 13 tiles
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
	INCBIN "data/bank_018/CharSelectCursorAnimTable.bin" ; $59fe, 32 bytes
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
	ld c, $04 ; $5ac8
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
	ld c, $04 ; $5ae1
	call QueueVRAMCopy ; $5ae3
	ret ; $5ae6
LoadOnCourtCharTilesFallback:
	ld hl, OnCourtCharTilesFallbackGfx ; $5ae7
	ld c, (CharRosterIcon00 - OnCourtCharTilesFallbackGfx) / 16 ; $5aea
	call QueueVRAMCopy ; $5aec
	ret ; $5aef
	ds ALIGN[4]
OnCourtCharTilesAGfx:
	INCBIN "data/bank_018/OnCourtCharTilesAGfx.bin" ; $5af0, 2048 bytes
	ds ALIGN[4]
OnCourtCharTilesBGfx:
	INCBIN "data/bank_018/OnCourtCharTilesBGfx.bin" ; $62f0, 2048 bytes
	ds ALIGN[4]
OnCourtCharTilesFallbackGfx:
	INCBIN "data/bank_018/OnCourtCharTilesFallbackGfx.bin" ; $6af0, 64 bytes
CharRosterIcon00:
	INCBIN "data/bank_018/lz_CharRosterIcon00.bin" ; $6b30, 67 bytes
CharRosterIcon01:
	INCBIN "data/bank_018/lz_CharRosterIcon01.bin" ; $6b73, 66 bytes
CharRosterIcon02:
	INCBIN "data/bank_018/lz_CharRosterIcon02.bin" ; $6bb5, 62 bytes
CharRosterIcon03:
	INCBIN "data/bank_018/lz_CharRosterIcon03.bin" ; $6bf3, 48 bytes
CharRosterIcon04:
	INCBIN "data/bank_018/lz_CharRosterIcon04.bin" ; $6c23, 44 bytes
CharRosterIcon05:
	INCBIN "data/bank_018/lz_CharRosterIcon05.bin" ; $6c4f, 46 bytes
CharRosterIcon06:
	INCBIN "data/bank_018/lz_CharRosterIcon06.bin" ; $6c7d, 59 bytes
CharRosterIcon07:
	INCBIN "data/bank_018/lz_CharRosterIcon07.bin" ; $6cb8, 65 bytes
CharRosterIcon08:
	INCBIN "data/bank_018/lz_CharRosterIcon08.bin" ; $6cf9, 67 bytes
CharRosterIcon09:
	INCBIN "data/bank_018/lz_CharRosterIcon09.bin" ; $6d3c, 65 bytes
CharRosterIcon10:
	INCBIN "data/bank_018/lz_CharRosterIcon10.bin" ; $6d7d, 60 bytes
CharRosterIcon11:
	INCBIN "data/bank_018/lz_CharRosterIcon11.bin" ; $6db9, 50 bytes
CharRosterIcon12:
	INCBIN "data/bank_018/lz_CharRosterIcon12.bin" ; $6deb, 45 bytes
CharRosterIcon13:
	INCBIN "data/bank_018/lz_CharRosterIcon13.bin" ; $6e18, 51 bytes
CharRosterIcon14:
	INCBIN "data/bank_018/lz_CharRosterIcon14.bin" ; $6e4b, 61 bytes
CharRosterIcon15:
	INCBIN "data/bank_018/lz_CharRosterIcon15.bin" ; $6e88, 66 bytes
CharRosterIcon16:
	INCBIN "data/bank_018/lz_CharRosterIcon16.bin" ; $6eca, 73 bytes
CharRosterIcon17:
	INCBIN "data/bank_018/lz_CharRosterIcon17.bin" ; $6f13, 68 bytes
CharRosterIcon18:
	INCBIN "data/bank_018/lz_CharRosterIcon18.bin" ; $6f57, 64 bytes
CharRosterIcon19:
	INCBIN "data/bank_018/lz_CharRosterIcon19.bin" ; $6f97, 59 bytes
CharRosterIcon20:
	INCBIN "data/bank_018/lz_CharRosterIcon20.bin" ; $6fd2, 53 bytes
CharRosterIcon21:
	INCBIN "data/bank_018/lz_CharRosterIcon21.bin" ; $7007, 57 bytes
CharRosterIcon22:
	INCBIN "data/bank_018/lz_CharRosterIcon22.bin" ; $7040, 66 bytes
CharRosterIcon23:
	INCBIN "data/bank_018/lz_CharRosterIcon23.bin" ; $7082, 73 bytes
CharRosterIcon24:
	INCBIN "data/bank_018/lz_CharRosterIcon24.bin" ; $70cb, 71 bytes
CharRosterIcon25:
	INCBIN "data/bank_018/lz_CharRosterIcon25.bin" ; $7112, 68 bytes
CharRosterIcon26:
	INCBIN "data/bank_018/lz_CharRosterIcon26.bin" ; $7156, 66 bytes
CharRosterIcon27:
	INCBIN "data/bank_018/lz_CharRosterIcon27.bin" ; $7198, 64 bytes
CharRosterIcon28:
	INCBIN "data/bank_018/lz_CharRosterIcon28.bin" ; $71d8, 58 bytes
CharRosterIcon29:
	INCBIN "data/bank_018/lz_CharRosterIcon29.bin" ; $7212, 60 bytes
CharRosterIcon30:
	INCBIN "data/bank_018/lz_CharRosterIcon30.bin" ; $724e, 68 bytes
CharRosterIcon31:
	INCBIN "data/bank_018/lz_CharRosterIcon31.bin" ; $7292, 73 bytes
MarioMiniGamesTilemap:
	INCBIN "data/bank_018/lz_MarioMiniGamesTilemap.bin" ; $72db, 304 bytes
MarioMiniGamesAttrmap:
	INCBIN "data/bank_018/lz_MarioMiniGamesAttrmap.bin" ; $740b, 214 bytes
MarioMiniGamesPalettes:
	INCLUDE "data/bank_018/MarioMiniGamesPalettes.asm" ; $74e1, 64 bytes (palettes)
MatchWinLoseGfx:
	INCBIN "data/bank_018/lz_MatchWinLoseGfx.bin" ; $7521, 71 bytes
UnusedJpCourtStatLabelTiles_18:
	INCBIN "data/bank_018/lz_UnusedJpCourtStatLabelTiles_18.bin" ; $7568, 175 bytes
RunStorySceneByMode:
	ld a, c ; $7617
	ld [wStorySceneAssetIndex], a ; $7618
	call FadeOutAndResetScreen ; $761b
	ld a, b ; $761e
	or a ; $761f
	jr nz, .checkMode1 ; $7620
	call PlayScreenSequence0 ; $7622
	ret ; $7625
.checkMode1:
	cp $01 ; $7626
	jr nz, .mode2 ; $7628
	call PlayScreenSequence1 ; $762a
	ret ; $762d
.mode2:
	call PlayScreenSequence2 ; $762e
	ret ; $7631
FadeOutAndResetScreen:
	call EnableLCD ; $7632
	ld c, $10 ; $7635
	call BeginFadeOut ; $7637
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
	add l ; $7663
	ld l, a ; $7664
	jr nc, .loadScreen ; $7665
	inc h ; $7667
.loadScreen:
	ld c, [hl] ; $7668
	push bc ; $7669
	ld c, $10 ; $766a
	call BeginFadeOut ; $766c
	call WaitFadeEnd ; $766f
	call DisableLCDSafely ; $7672
	pop bc ; $7675
	farcall LoadScreenAssetRecord ; $7676
	farcall QueueWram3MapToVRAM ; $7679
	call EnableLCD ; $767c
	script_fade_in $10 ; $767f
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
	db SCREENASSET_VictoryCutscene, SCREENASSET_VictoryCutscene2, SCREENASSET_VictoryCutscene3, SCREENASSET_VictoryCutscene4, SCREENASSET_VictoryCutscene5, SCREENASSET_VictoryCutscene6, SCREENASSET_ShopCutscene, SCREENASSET_ShopCutscene2, SCREENASSET_ShopCutscene3, SCREENASSET_ShopCutscene4, SCREENASSET_ShopCutscene5, SCREENASSET_ShopCutscene6 ; 0x00
	db SCREENASSET_AwardCeremony, SCREENASSET_AwardCeremony2, SCREENASSET_AwardCeremony3, SCREENASSET_AwardCeremony4, SCREENASSET_AwardCeremony5, SCREENASSET_AwardCeremony6, SCREENASSET_ChampionMedal, SCREENASSET_ChampionMedal2, SCREENASSET_ChampionMedal3, SCREENASSET_ChampionMedal4, SCREENASSET_ChampionMedal5, SCREENASSET_ChampionMedal6 ; 0x0c
PlayScreenSequence0:
	call SetupScreen0Assets ; $76b4
	call LoadScreen0TilesAndPalette ; $76b7
	call EnableLCD ; $76ba
	script_fade_in $02 ; $76bd
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
	farcall InitGrayscalePaletteFade ; $76dd
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
	ld c, $10 ; $76f5
	call BeginFadeOut ; $76f7
	call WaitFadeEnd ; $76fa
	call DisableLCDSafely ; $76fd
	call FillAllBgPalettes ; $7700
	call EnableLCD ; $7703
	script_fade_in $10 ; $7706
	call WaitFadeEnd ; $770b
	ld a, $01 ; $770e
	ld hl, QueueScreen0Sprites ; $7710
	call RegisterFrameTask ; $7713
.done:
	call AdvanceFrame ; $7716
	ldh a, [hInputPressed] ; $7719
	and PADF_A | PADF_B ; $771b
	jr z, .done ; $771d
	ret ; $771f
SetupScreen0Assets:
	call ResetScrollAndCamera ; $7720
	call LookupScreen0AssetId ; $7723
	farcall LoadScreenAssetRecord ; $7726
	farcall QueueWram3MapToVRAM ; $7729
	ret ; $772c
LookupScreen0AssetId:
	ld a, [wStorySceneAssetIndex] ; $772d
	ld hl, Screen0AssetIdTable ; $7730
	add l ; $7733
	ld l, a ; $7734
	jr nc, .read ; $7735
	inc h ; $7737
.read:
	ld c, [hl] ; $7738
	ret ; $7739
Screen0AssetIdTable:
	; $773a, 6 bytes (bytes:6)
	db SCREENASSET_VictoryCutscene, SCREENASSET_VictoryCutscene2, SCREENASSET_VictoryCutscene4, SCREENASSET_VictoryCutscene3, SCREENASSET_VictoryCutscene5, SCREENASSET_VictoryCutscene6 ; 0x00
LoadScreen0TilesAndPalette:
	ld b, TILEBLOCK_Screen0Gfx ; $7740
	ld c, Screen0Gfx_SIZE / 16 ; $7742
	ld de, vTiles0 ; $7744
	farcall LoadCompressedTileBlock ; $7747
	ld hl, Screen0Palette ; $774a
	ld_obj_pals de, 0, 1 ; $774d
	call LoadPaletteShadow ; $7750
	ret ; $7753
Screen0Palette:
	INCLUDE "data/bank_018/Screen0Palette.asm" ; $7754, 8 bytes (palettes)
QueueScreen0Sprites:
	ld hl, QueueScreen0Sprites_SpriteTemplate ; $775c
	ld_xy de, $28, $3a ; $775f
	ld c, $00 ; $7762
	ld b, $00 ; $7764
	call QueueSpriteTemplate ; $7766
	ret ; $7769
QueueScreen0Sprites_SpriteTemplate:
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

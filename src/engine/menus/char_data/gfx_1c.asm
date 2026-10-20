	ds ALIGN[4]
CharDataBallAnimFrame00:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame00.bin" ; $6880, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame01:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame01.bin" ; $68c0, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame02:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame02.bin" ; $6900, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame03:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame03.bin" ; $6940, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame04:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame04.bin" ; $6980, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame05:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame05.bin" ; $69c0, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame06:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame06.bin" ; $6a00, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame07:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame07.bin" ; $6a40, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame08:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame08.bin" ; $6a80, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame09:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame09.bin" ; $6ac0, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame10:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame10.bin" ; $6b00, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame11:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame11.bin" ; $6b40, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame12:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame12.bin" ; $6b80, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame13:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame13.bin" ; $6bc0, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame14:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame14.bin" ; $6c00, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame15:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame15.bin" ; $6c40, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame16:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame16.bin" ; $6c80, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame17:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame17.bin" ; $6cc0, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame18:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame18.bin" ; $6d00, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame19:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame19.bin" ; $6d40, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame20:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame20.bin" ; $6d80, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame21:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame21.bin" ; $6dc0, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame22:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame22.bin" ; $6e00, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame23:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame23.bin" ; $6e40, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame24:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame24.bin" ; $6e80, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame25:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame25.bin" ; $6ec0, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame26:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame26.bin" ; $6f00, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame27:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame27.bin" ; $6f40, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame28:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame28.bin" ; $6f80, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame29:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame29.bin" ; $6fc0, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame30:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame30.bin" ; $7000, 64 bytes
	ds ALIGN[4]
CharDataBallAnimFrame31:
	INCBIN "data/engine/menus/char_data/CharDataBallAnimFrame31.bin" ; $7040, 64 bytes
CharDataLargeDigitGfx:
	INCBIN "data/engine/menus/char_data/lz_CharDataLargeDigitGfx.bin" ; $7080, 150 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataLargeDigitGfx.inc" ; DEF CharDataLargeDigitGfx_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreen_LoadScreen:
	ld hl, CharDataScreenBasePalettes ; $7116
	ld_bg_pals de, 0, 8 ; $7119
	call LoadPaletteShadow ; $711c
	ld hl, CharDataScreenBasePalettes ; $711f
	ld_obj_pals de, 0, 8 ; $7122
	call LoadPaletteShadow ; $7125
	wram_bank WRAM_STAGING ; $7128
	ld hl, CharDataLargeDigitGfx ; $712e
	ld de, wDecompBuffer ; $7131
	call DecompressData ; $7134
	ld hl, wDecompBuffer ; $7137
	ld de, vTiles0 + VRAM_BANK1 ; $713a
	ld c, CharDataLargeDigitGfx_SIZE / 16 ; $713d
	call QueueVRAMCopy ; $713f
	farcall CharDataScreen_LoadGfx ; $7142
	wram_bank WRAM_STAGING ; $7145
	ld hl, CharDataScreenGfx0_1c ; $714b
	ld de, wDecompBuffer ; $714e
	call DecompressData ; $7151
	ld hl, wDecompBuffer ; $7154
	ld de, vTiles2 + VRAM_BANK1 ; $7157
	ld c, 128 ; $715a -- 128 of CharDataScreenGfx0_1c's 256 tiles
	call QueueVRAMCopy ; $715c
	ld hl, wDecompBufferHigh ; $715f
	ld de, vTiles1 + VRAM_BANK1 ; $7162
	ld c, wDecompBufferHigh_SIZE / 16 ; $7165
	call QueueVRAMCopy ; $7167
	wram_bank WRAM_STAGING ; $716a
	ld hl, CharDataScreenTilemap_1c ; $7170
	ld de, wDecompBuffer ; $7173
	call DecompressData ; $7176
	ld hl, wDecompBuffer ; $7179
	ld bc, CharDataScreenTilemap_1c_SIZE ; $717c
	call CopyWram1ToWram3 ; $717f
	wram_bank WRAM_STAGING ; $7182
	ld hl, CharDataScreenAttrmap_1c ; $7188
	ld de, wDecompBuffer ; $718b
	call DecompressData ; $718e
	ld hl, wDecompBuffer ; $7191
	ld bc, CharDataScreenAttrmap_1c_SIZE ; $7194
	call CopyWram1ToWram2 ; $7197
	wram_bank WRAM_STAGING ; $719a
	ld hl, CharDataScreenBand1Tilemap ; $71a0
	ld de, wDecompBuffer + 18 * TILEMAP_WIDTH ; $71a3
	call DecompressData ; $71a6
	ld hl, wDecompBuffer + 18 * TILEMAP_WIDTH ; $71a9
	ld bc, CharDataScreenBand1Tilemap_SIZE ; $71ac
	call CopyWram1ToWram3 ; $71af
	wram_bank WRAM_STAGING ; $71b2
	ld hl, CharDataScreenBand1Attrmap ; $71b8
	ld de, wDecompBuffer + 18 * TILEMAP_WIDTH ; $71bb
	call DecompressData ; $71be
	ld hl, wDecompBuffer + 18 * TILEMAP_WIDTH ; $71c1
	ld bc, CharDataScreenBand1Attrmap_SIZE ; $71c4
	call CopyWram1ToWram2 ; $71c7
	wram_bank WRAM_STAGING ; $71ca
	ld hl, CharDataScreenBand2Tilemap ; $71d0
	ld de, wDecompBuffer + 20 * TILEMAP_WIDTH ; $71d3
	call DecompressData ; $71d6
	ld hl, wDecompBuffer + 20 * TILEMAP_WIDTH ; $71d9
	ld bc, CharDataScreenBand2Tilemap_SIZE ; $71dc
	call CopyWram1ToWram3 ; $71df
	wram_bank WRAM_STAGING ; $71e2
	ld hl, CharDataScreenBand2Attrmap ; $71e8
	ld de, wDecompBuffer + 20 * TILEMAP_WIDTH ; $71eb
	call DecompressData ; $71ee
	ld hl, wDecompBuffer + 20 * TILEMAP_WIDTH ; $71f1
	ld bc, CharDataScreenBand2Attrmap_SIZE ; $71f4
	call CopyWram1ToWram2 ; $71f7
	wram_bank WRAM_STAGING ; $71fa
	ld hl, CharDataScreenBand3Tilemap ; $7200
	ld de, wDecompBuffer + 22 * TILEMAP_WIDTH + 16 ; $7203
	call DecompressData ; $7206
	ld hl, wDecompBuffer + 22 * TILEMAP_WIDTH + 16 ; $7209
	ld bc, CharDataScreenBand3Tilemap_SIZE ; $720c
	call CopyWram1ToWram3 ; $720f
	wram_bank WRAM_STAGING ; $7212
	ld hl, CharDataScreenBand3Attrmap ; $7218
	ld de, wDecompBuffer + 22 * TILEMAP_WIDTH + 16 ; $721b
	call DecompressData ; $721e
	ld hl, wDecompBuffer + 22 * TILEMAP_WIDTH + 16 ; $7221
	ld bc, CharDataScreenBand3Attrmap_SIZE ; $7224
	call CopyWram1ToWram2 ; $7227
	wram_bank WRAM_STAGING ; $722a
	ld hl, CharDataScreenBand4Tilemap ; $7230
	ld de, wDecompBuffer + 24 * TILEMAP_WIDTH + 16 ; $7233
	call DecompressData ; $7236
	ld hl, wDecompBuffer + 24 * TILEMAP_WIDTH + 16 ; $7239
	ld bc, CharDataScreenBand4Tilemap_SIZE ; $723c
	call CopyWram1ToWram3 ; $723f
	wram_bank WRAM_STAGING ; $7242
	ld hl, CharDataScreenBand4Attrmap ; $7248
	ld de, wDecompBuffer + 24 * TILEMAP_WIDTH + 16 ; $724b
	call DecompressData ; $724e
	ld hl, wDecompBuffer + 24 * TILEMAP_WIDTH + 16 ; $7251
	ld bc, CharDataScreenBand4Attrmap_SIZE ; $7254
	call CopyWram1ToWram2 ; $7257
	wram_bank WRAM_STAGING ; $725a
	ld hl, CharDataScreenBand5Tilemap ; $7260
	ld de, wDecompBuffer + 27 * TILEMAP_WIDTH + 16 ; $7263
	call DecompressData ; $7266
	ld hl, wDecompBuffer + 27 * TILEMAP_WIDTH + 16 ; $7269
	ld bc, CharDataScreenBand5Tilemap_SIZE ; $726c
	call CopyWram1ToWram3 ; $726f
	wram_bank WRAM_STAGING ; $7272
	ld hl, CharDataScreenBand5Attrmap ; $7278
	ld de, wDecompBuffer + 27 * TILEMAP_WIDTH + 16 ; $727b
	call DecompressData ; $727e
	ld hl, wDecompBuffer + 27 * TILEMAP_WIDTH + 16 ; $7281
	ld bc, CharDataScreenBand5Attrmap_SIZE ; $7284
	call CopyWram1ToWram2 ; $7287
	ret ; $728a
LoadCharDataScreenTilemaps:
	wram_bank WRAM_STAGING ; $728b
	ld hl, CharDataScreenUIPatch2Tilemap ; $7291
	ld de, wDecompBuffer + 42 * TILEMAP_WIDTH + 16 ; $7294
	call DecompressData ; $7297
	ld hl, wDecompBuffer + 42 * TILEMAP_WIDTH + 16 ; $729a
	ld bc, CharDataScreenUIPatch2Tilemap_SIZE ; $729d
	call CopyWram1ToWram3 ; $72a0
	wram_bank WRAM_STAGING ; $72a3
	ld hl, CharDataScreenUIPatch2Attrmap ; $72a9
	ld de, wDecompBuffer + 42 * TILEMAP_WIDTH + 16 ; $72ac
	call DecompressData ; $72af
	ld hl, wDecompBuffer + 42 * TILEMAP_WIDTH + 16 ; $72b2
	ld bc, CharDataScreenUIPatch2Attrmap_SIZE ; $72b5
	call CopyWram1ToWram2 ; $72b8
	wram_bank WRAM_STAGING ; $72bb
	ld hl, CharDataScreenUIPatch3Tilemap ; $72c1
	ld de, wDecompBuffer + 44 * TILEMAP_WIDTH ; $72c4
	call DecompressData ; $72c7
	ld hl, wDecompBuffer + 44 * TILEMAP_WIDTH ; $72ca
	ld bc, CharDataScreenUIPatch3Tilemap_SIZE ; $72cd
	call CopyWram1ToWram3 ; $72d0
	wram_bank WRAM_STAGING ; $72d3
	ld hl, CharDataScreenUIPatch3Attrmap ; $72d9
	ld de, wDecompBuffer + 44 * TILEMAP_WIDTH ; $72dc
	call DecompressData ; $72df
	ld hl, wDecompBuffer + 44 * TILEMAP_WIDTH ; $72e2
	ld bc, CharDataScreenUIPatch3Attrmap_SIZE ; $72e5
	call CopyWram1ToWram2 ; $72e8
	ret ; $72eb
StartCharDataScreenAnimTask:
	frame_task CharDataScreenAnimTask ; $72ec
	ret ; $72f4
StopCharDataScreenAnimTask:
	ld hl, CharDataScreenAnimTask ; $72f5
	call UnregisterFrameTask ; $72f8
	ret ; $72fb
FlushCharDataTilemapsFar:
	call FlushCharDataTilemaps ; $72fc
	ret ; $72ff
BackupCharData:
	wram_bank WRAM_SCENE ; $7300
	ld hl, wCharDataPointsWorking ; $7306
	ld de, wCharDataEditBackup ; $7309
	ld bc, wCharDataEditBackup_SIZE ; $730c
	call CopyMemoryBC ; $730f
	ld hl, wCharDataChoiceCount ; $7312
	ld de, wCharDataChoiceBackup ; $7315
	ld bc, wCharDataChoiceBackup_SIZE ; $7318
	call CopyMemoryBC ; $731b
	ret ; $731e
RestoreCharData:
	wram_bank WRAM_SCENE ; $731f
	ld hl, wCharDataEditBackup ; $7325
	ld de, wCharDataPointsWorking ; $7328
	ld bc, wCharDataEditBackup_SIZE ; $732b
	call CopyMemoryBC ; $732e
	ld hl, wCharDataChoiceBackup ; $7331
	ld de, wCharDataChoiceCount ; $7334
	ld bc, wCharDataChoiceBackup_SIZE ; $7337
	call CopyMemoryBC ; $733a
	ld a, $01 ; $733d
	ld [wCharDataViewOnly], a ; $733f
	xor a ; $7342
	ld [wStoryCharacterSlot], a ; $7343
	ld a, [wCharDataPointsWorking] ; $7346
	ld [wCharDataPointsLeft], a ; $7349
	push af ; $734c
	ld_story_char_field CHARREC_LEVEL ; $734d
	pop af ; $7360
	ld a, [wCharDataLevel] ; $7361
	ld [hl], a ; $7364
	push af ; $7365
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_SPIN ; $7366
	pop af ; $7379
	ld a, [wCharDataNewLevels + TRAINSTAT_SPIN] ; $737a
	ld [hl], a ; $737d
	ld [wCharDataLevels + TRAINSTAT_SPIN], a ; $737e
	push af ; $7381
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_POWER ; $7382
	pop af ; $7395
	ld a, [wCharDataNewLevels + TRAINSTAT_POWER] ; $7396
	ld [hl], a ; $7399
	ld [wCharDataLevels + TRAINSTAT_POWER], a ; $739a
	push af ; $739d
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_CONTROL ; $739e
	pop af ; $73b1
	ld a, [wCharDataNewLevels + TRAINSTAT_CONTROL] ; $73b2
	ld [hl], a ; $73b5
	ld [wCharDataLevels + TRAINSTAT_CONTROL], a ; $73b6
	push af ; $73b9
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_SPEED ; $73ba
	pop af ; $73cd
	ld a, [wCharDataNewLevels + TRAINSTAT_SPEED] ; $73ce
	ld [hl], a ; $73d1
	ld [wCharDataLevels + TRAINSTAT_SPEED], a ; $73d2
	xor a ; $73d5
	farcall RefreshPlayerStatsAndGetPtr ; $73d6
	wram_bank WRAM_SCENE ; $73d9
	ld hl, wCharDataChoiceLog ; $73df
	ld a, [wCharDataChoiceCount] ; $73e2
	ld b, a ; $73e5
.loop:
	ld a, [hl+] ; $73e6
	push bc ; $73e7
	push hl ; $73e8
	ld d, a ; $73e9
	xor a ; $73ea
	farcall LevelUpPlayer ; $73eb
	pop hl ; $73ee
	pop bc ; $73ef
	dec b ; $73f0
	jr nz, .loop ; $73f1
	ret ; $73f3
LoadCharDataScreenGraphics:
	call LoadCharDataScreenBgAndPalettes ; $73f4
	call LoadCharDataScreenMugshots ; $73f7
	ret ; $73fa
LoadCharDataScreenBgAndPalettes:
	ld hl, CharDataScreenBgAndPalettes ; $73fb
	ld_bg_pals de, 0, 8 ; $73fe
	call LoadPaletteShadow ; $7401
	ld hl, CharDataScreenBgAndPalettes ; $7404
	ld_obj_pals de, 0, 8 ; $7407
	call LoadPaletteShadow ; $740a
	wram_bank WRAM_SCENE ; $740d
	ld a, [wMasterPalettes + 7 * PAL_SIZE + 1 * COLOR_SIZE] ; $7413
	ld [wExpScreenCharStats + EXPSTAT_SAVED_COLOR], a ; $7416
	ld a, [wMasterPalettes + 7 * PAL_SIZE + 1 * COLOR_SIZE + 1] ; $7419
	ld [wExpScreenCharStats + EXPSTAT_SAVED_COLOR + 1], a ; $741c
	ld a, [wMasterPalettes + 4 * PAL_SIZE + 1 * COLOR_SIZE] ; $741f
	ld [wExpScreenCharStats + EXPSTAT_SIZE + EXPSTAT_SAVED_COLOR], a ; $7422
	ld a, [wMasterPalettes + 4 * PAL_SIZE + 1 * COLOR_SIZE + 1] ; $7425
	ld [wExpScreenCharStats + EXPSTAT_SIZE + EXPSTAT_SAVED_COLOR + 1], a ; $7428
	ld hl, wMasterPalettes + 4 * PAL_SIZE + 1 * COLOR_SIZE ; $742b
	farcall GrayscalePaletteColorInPlace ; $742e
	ld hl, wMasterPalettes + 4 * PAL_SIZE + 1 * COLOR_SIZE ; $7431
	farcall GrayscalePaletteColorInPlace ; $7434
	wram_bank WRAM_STAGING ; $7437
	ld hl, CharDataScreenBgGfx ; $743d
	ld de, wDecompBuffer ; $7440
	call DecompressData ; $7443
	ld hl, wDecompBuffer ; $7446
	ld de, vTiles2 + VRAM_BANK1 ; $7449
	ld c, 128 ; $744c -- 128 of CharDataScreenBgGfx's 256 tiles
	call QueueVRAMCopy ; $744e
	ld hl, wDecompBufferHigh ; $7451
	ld de, vTiles1 + VRAM_BANK1 ; $7454
	ld c, wDecompBufferHigh_SIZE / 16 ; $7457
	call QueueVRAMCopy ; $7459
	wram_bank WRAM_STAGING ; $745c
	ld hl, CharDataScreenBgTilemap ; $7462
	ld de, wDecompBuffer ; $7465
	call DecompressData ; $7468
	ld hl, wDecompBuffer ; $746b
	ld bc, CharDataScreenBgTilemap_SIZE ; $746e
	call CopyWram1ToWram3 ; $7471
	wram_bank WRAM_STAGING ; $7474
	ld hl, CharDataScreenBgAttrmap ; $747a
	ld de, wDecompBuffer ; $747d
	call DecompressData ; $7480
	ld hl, wDecompBuffer ; $7483
	ld bc, CharDataScreenBgAttrmap_SIZE ; $7486
	call CopyWram1ToWram2 ; $7489
	ret ; $748c
LoadCharDataScreenMugshots:
	xor a ; $748d
	ld [wStoryCharacterSlot], a ; $748e
	push af ; $7491
	ld_story_char_field CHARREC_PALETTE ; $7492
	pop af ; $74a5
	ld a, [hl] ; $74a6
	ld_bg_pals de, 1, 1 ; $74a7
	farcall LoadIndexedPaletteThunk ; $74aa
	wram_bank WRAM_STAGING ; $74ad
	push af ; $74b3
	ld_story_char_field CHARREC_CHAR ; $74b4
	pop af ; $74c7
	ld a, [hl] ; $74c8
	ld de, wDecompBuffer ; $74c9
	farcall DecompressCharMugshot ; $74cc
	ld hl, wDecompBuffer ; $74cf
	ld de, vTiles1 tile $30 + VRAM_BANK1 ; $74d2
	ld c, 9 ; $74d5
	call QueueVRAMCopy ; $74d7
	ld a, STORYREC_PARTNER ; $74da
	ld [wStoryCharacterSlot], a ; $74dc
	push af ; $74df
	ld_story_char_field CHARREC_PALETTE ; $74e0
	pop af ; $74f3
	ld a, [hl] ; $74f4
	ld_bg_pals de, 2, 1 ; $74f5
	farcall LoadIndexedPaletteThunk ; $74f8
	wram_bank WRAM_STAGING ; $74fb
	push af ; $7501
	ld_story_char_field CHARREC_CHAR ; $7502
	pop af ; $7515
	ld a, [hl] ; $7516
	ld de, wDecompBuffer ; $7517
	farcall DecompressCharMugshot ; $751a
	ld hl, wDecompBuffer ; $751d
	ld de, vTiles1 tile $40 + VRAM_BANK1 ; $7520
	ld c, 9 ; $7523
	call QueueVRAMCopy ; $7525
	ld hl, wMasterPalettes + 2 * PAL_SIZE + 0 * COLOR_SIZE ; $7528
	farcall GrayscalePaletteColorInPlace ; $752b
	ld hl, wMasterPalettes + 2 * PAL_SIZE + 1 * COLOR_SIZE ; $752e
	farcall GrayscalePaletteColorInPlace ; $7531
	ld hl, wMasterPalettes + 2 * PAL_SIZE + 2 * COLOR_SIZE ; $7534
	farcall GrayscalePaletteColorInPlace ; $7537
	ld hl, wMasterPalettes + 2 * PAL_SIZE + 3 * COLOR_SIZE ; $753a
	farcall GrayscalePaletteColorInPlace ; $753d
	ret ; $7540
CharDataScreenBgAndPalettes:
	INCLUDE "data/engine/menus/char_data/CharDataScreenBgAndPalettes.asm" ; $7541, 64 bytes (palettes)
CharDataScreenBgGfx:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBgGfx.bin" ; $7581, 1886 bytes
CharDataScreenBgTilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBgTilemap.bin" ; $7cdf, 320 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBgTilemap.inc" ; DEF CharDataScreenBgTilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenBgAttrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBgAttrmap.bin" ; $7e1f, 216 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBgAttrmap.inc" ; DEF CharDataScreenBgAttrmap_SIZE EQU its decoded length, generated from the .bin by make
	; $7ef7, 265 bytes fill to bank end (linker-padded)

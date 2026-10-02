LoadCutsceneAnimFrameGfx_2D_35:
	wram_bank WRAM_SCENE ; $6408
	ld a, [wSceneAnimFrame] ; $640e
	ld b, a ; $6411
	sub $2d ; $6412
	ret c ; $6414
	ld a, b ; $6415
	cp $2d ; $6416
	jp z, .eq2d ; $6418
	cp $2e ; $641b
	jp z, .eq2e ; $641d
	cp $2f ; $6420
	jp z, .eq2f ; $6422
	cp $30 ; $6425
	jp z, .eq30 ; $6427
	cp $31 ; $642a
	jp z, .eq31 ; $642c
	cp $32 ; $642f
	jp z, .eq32 ; $6431
	cp $33 ; $6434
	jp z, .eq33 ; $6436
	cp $34 ; $6439
	jp z, .eq34 ; $643b
	cp $35 ; $643e
	jp z, .eq35 ; $6440
	jp .queueSpriteTemplate ; $6443
.eq2d:
	wram_bank WRAM_STAGING ; $6446
	ld hl, CutsceneAnimFrameLZ_2d ; $644c
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $644f
	call DecompressData ; $6452
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $6455
	ld de, vTiles0 + $10 * TILE_SIZE ; $6458
	ld c, CutsceneAnimFrameLZ_2d_SIZE / 16 ; $645b
	call QueueVRAMCopy ; $645d
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate0 ; $6460
	ld d, $3e ; $6463
	ld e, $80 ; $6465
	ld_oam bc, 3, $10 ; $6467
	call QueueSpriteTemplate ; $646a
	ret ; $646d
.eq2e:
	wram_bank WRAM_STAGING ; $646e
	ld hl, CutsceneAnimFrameLZ_2e ; $6474
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $6477
	call DecompressData ; $647a
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $647d
	ld de, vTiles0 + $10 * TILE_SIZE ; $6480
	ld c, CutsceneAnimFrameLZ_2e_SIZE / 16 ; $6483
	call QueueVRAMCopy ; $6485
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate1 ; $6488
	ld d, $3e ; $648b
	ld e, $80 ; $648d
	ld_oam bc, 3, $10 ; $648f
	call QueueSpriteTemplate ; $6492
	ret ; $6495
.eq2f:
	wram_bank WRAM_STAGING ; $6496
	ld hl, CutsceneAnimFrameLZ_2f ; $649c
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $649f
	call DecompressData ; $64a2
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $64a5
	ld de, vTiles0 + $10 * TILE_SIZE ; $64a8
	ld c, CutsceneAnimFrameLZ_2f_SIZE / 16 ; $64ab
	call QueueVRAMCopy ; $64ad
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate2 ; $64b0
	ld d, $3e ; $64b3
	ld e, $80 ; $64b5
	ld_oam bc, 3, $10 ; $64b7
	call QueueSpriteTemplate ; $64ba
	ret ; $64bd
.eq30:
	wram_bank WRAM_STAGING ; $64be
	ld hl, CutsceneAnimFrameLZ_30 ; $64c4
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $64c7
	call DecompressData ; $64ca
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $64cd
	ld de, vTiles0 + $10 * TILE_SIZE ; $64d0
	ld c, CutsceneAnimFrameLZ_30_SIZE / 16 ; $64d3
	call QueueVRAMCopy ; $64d5
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate3 ; $64d8
	ld d, $3e ; $64db
	ld e, $80 ; $64dd
	ld_oam bc, 3, $10 ; $64df
	call QueueSpriteTemplate ; $64e2
	ret ; $64e5
.eq31:
	wram_bank WRAM_STAGING ; $64e6
	ld hl, CutsceneAnimFrameLZ_31 ; $64ec
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $64ef
	call DecompressData ; $64f2
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $64f5
	ld de, vTiles0 + $10 * TILE_SIZE ; $64f8
	ld c, CutsceneAnimFrameLZ_31_SIZE / 16 ; $64fb
	call QueueVRAMCopy ; $64fd
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate4 ; $6500
	ld d, $3e ; $6503
	ld e, $80 ; $6505
	ld_oam bc, 3, $10 ; $6507
	call QueueSpriteTemplate ; $650a
	ret ; $650d
.eq32:
	wram_bank WRAM_STAGING ; $650e
	ld hl, CutsceneAnimFrameLZ_32 ; $6514
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $6517
	call DecompressData ; $651a
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $651d
	ld de, vTiles0 + $10 * TILE_SIZE ; $6520
	ld c, CutsceneAnimFrameLZ_32_SIZE / 16 ; $6523
	call QueueVRAMCopy ; $6525
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate5 ; $6528
	ld d, $3e ; $652b
	ld e, $80 ; $652d
	ld_oam bc, 3, $10 ; $652f
	call QueueSpriteTemplate ; $6532
	ret ; $6535
.eq33:
	wram_bank WRAM_STAGING ; $6536
	ld hl, CutsceneAnimFrameLZ_33 ; $653c
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $653f
	call DecompressData ; $6542
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $6545
	ld de, vTiles0 + $10 * TILE_SIZE ; $6548
	ld c, CutsceneAnimFrameLZ_33_SIZE / 16 ; $654b
	call QueueVRAMCopy ; $654d
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate6 ; $6550
	ld d, $3e ; $6553
	ld e, $80 ; $6555
	ld_oam bc, 3, $10 ; $6557
	call QueueSpriteTemplate ; $655a
	ret ; $655d
.eq34:
	wram_bank WRAM_STAGING ; $655e
	ld hl, CutsceneAnimFrameLZ_34 ; $6564
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $6567
	call DecompressData ; $656a
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $656d
	ld de, vTiles0 + $10 * TILE_SIZE ; $6570
	ld c, CutsceneAnimFrameLZ_34_SIZE / 16 ; $6573
	call QueueVRAMCopy ; $6575
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate7 ; $6578
	ld d, $3e ; $657b
	ld e, $80 ; $657d
	ld_oam bc, 3, $10 ; $657f
	call QueueSpriteTemplate ; $6582
	ret ; $6585
.eq35:
	wram_bank WRAM_STAGING ; $6586
	ld hl, CutsceneAnimFrameLZ_35 ; $658c
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $658f
	call DecompressData ; $6592
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $6595
	ld de, vTiles0 + $10 * TILE_SIZE ; $6598
	ld c, CutsceneAnimFrameLZ_35_SIZE / 16 ; $659b
	call QueueVRAMCopy ; $659d
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate8 ; $65a0
	ld d, $3e ; $65a3
	ld e, $80 ; $65a5
	ld_oam bc, 3, $10 ; $65a7
	call QueueSpriteTemplate ; $65aa
	ret ; $65ad
.queueSpriteTemplate:
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate8 ; $65ae
	ld d, $3e ; $65b1
	ld e, $80 ; $65b3
	ld_oam bc, 3, $10 ; $65b5
	call QueueSpriteTemplate ; $65b8
	ret ; $65bb
SceneAnimObjPalette0_03:
	INCLUDE "data/bank_003/SceneAnimObjPalette0_03.asm" ; $65bc, 8 bytes (palettes)
SceneAnimObjPalette1_03:
	INCLUDE "data/bank_003/SceneAnimObjPalette1_03.asm" ; $65c4, 8 bytes (palettes)
	; $65cc, 4 bytes (fill)
	ds 4, $00
CutsceneAnimFrameLZ_00:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_00.bin" ; $65d0, 42 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_00.inc" ; DEF CutsceneAnimFrameLZ_00_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_01:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_01.bin" ; $65fa, 46 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_01.inc" ; DEF CutsceneAnimFrameLZ_01_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_02:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_02.bin" ; $6628, 48 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_02.inc" ; DEF CutsceneAnimFrameLZ_02_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_03:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_03.bin" ; $6658, 65 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_03.inc" ; DEF CutsceneAnimFrameLZ_03_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_04:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_04.bin" ; $6699, 66 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_04.inc" ; DEF CutsceneAnimFrameLZ_04_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_05:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_05.bin" ; $66db, 72 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_05.inc" ; DEF CutsceneAnimFrameLZ_05_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_06:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_06.bin" ; $6723, 73 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_06.inc" ; DEF CutsceneAnimFrameLZ_06_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_07:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_07.bin" ; $676c, 73 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_07.inc" ; DEF CutsceneAnimFrameLZ_07_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_08:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_08.bin" ; $67b5, 71 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_08.inc" ; DEF CutsceneAnimFrameLZ_08_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_09:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_09.bin" ; $67fc, 38 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_09.inc" ; DEF CutsceneAnimFrameLZ_09_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_0a:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_0a.bin" ; $6822, 46 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_0a.inc" ; DEF CutsceneAnimFrameLZ_0a_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_0b:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_0b.bin" ; $6850, 46 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_0b.inc" ; DEF CutsceneAnimFrameLZ_0b_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_0c:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_0c.bin" ; $687e, 67 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_0c.inc" ; DEF CutsceneAnimFrameLZ_0c_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_0d:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_0d.bin" ; $68c1, 75 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_0d.inc" ; DEF CutsceneAnimFrameLZ_0d_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_0e:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_0e.bin" ; $690c, 75 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_0e.inc" ; DEF CutsceneAnimFrameLZ_0e_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_0f:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_0f.bin" ; $6957, 75 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_0f.inc" ; DEF CutsceneAnimFrameLZ_0f_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_10:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_10.bin" ; $69a2, 74 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_10.inc" ; DEF CutsceneAnimFrameLZ_10_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_11:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_11.bin" ; $69ec, 73 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_11.inc" ; DEF CutsceneAnimFrameLZ_11_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_12:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_12.bin" ; $6a35, 39 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_12.inc" ; DEF CutsceneAnimFrameLZ_12_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_13:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_13.bin" ; $6a5c, 49 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_13.inc" ; DEF CutsceneAnimFrameLZ_13_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_14:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_14.bin" ; $6a8d, 53 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_14.inc" ; DEF CutsceneAnimFrameLZ_14_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_15:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_15.bin" ; $6ac2, 66 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_15.inc" ; DEF CutsceneAnimFrameLZ_15_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_16:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_16.bin" ; $6b04, 69 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_16.inc" ; DEF CutsceneAnimFrameLZ_16_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_17:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_17.bin" ; $6b49, 73 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_17.inc" ; DEF CutsceneAnimFrameLZ_17_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_18:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_18.bin" ; $6b92, 74 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_18.inc" ; DEF CutsceneAnimFrameLZ_18_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_19:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_19.bin" ; $6bdc, 74 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_19.inc" ; DEF CutsceneAnimFrameLZ_19_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_1a:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_1a.bin" ; $6c26, 69 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_1a.inc" ; DEF CutsceneAnimFrameLZ_1a_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_1b:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_1b.bin" ; $6c6b, 15 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_1b.inc" ; DEF CutsceneAnimFrameLZ_1b_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_1c:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_1c.bin" ; $6c7a, 15 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_1c.inc" ; DEF CutsceneAnimFrameLZ_1c_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_1d:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_1d.bin" ; $6c89, 15 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_1d.inc" ; DEF CutsceneAnimFrameLZ_1d_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_1e:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_1e.bin" ; $6c98, 19 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_1e.inc" ; DEF CutsceneAnimFrameLZ_1e_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_1f:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_1f.bin" ; $6cab, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_1f.inc" ; DEF CutsceneAnimFrameLZ_1f_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_20:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_20.bin" ; $6cc1, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_20.inc" ; DEF CutsceneAnimFrameLZ_20_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_21:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_21.bin" ; $6cd7, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_21.inc" ; DEF CutsceneAnimFrameLZ_21_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_22:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_22.bin" ; $6ced, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_22.inc" ; DEF CutsceneAnimFrameLZ_22_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_23:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_23.bin" ; $6d03, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_23.inc" ; DEF CutsceneAnimFrameLZ_23_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_24:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_24.bin" ; $6d19, 15 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_24.inc" ; DEF CutsceneAnimFrameLZ_24_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_25:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_25.bin" ; $6d28, 15 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_25.inc" ; DEF CutsceneAnimFrameLZ_25_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_26:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_26.bin" ; $6d37, 15 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_26.inc" ; DEF CutsceneAnimFrameLZ_26_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_27:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_27.bin" ; $6d46, 20 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_27.inc" ; DEF CutsceneAnimFrameLZ_27_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_28:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_28.bin" ; $6d5a, 21 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_28.inc" ; DEF CutsceneAnimFrameLZ_28_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_29:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_29.bin" ; $6d6f, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_29.inc" ; DEF CutsceneAnimFrameLZ_29_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_2a:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_2a.bin" ; $6d85, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_2a.inc" ; DEF CutsceneAnimFrameLZ_2a_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_2b:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_2b.bin" ; $6d9b, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_2b.inc" ; DEF CutsceneAnimFrameLZ_2b_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_2c:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_2c.bin" ; $6db1, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_2c.inc" ; DEF CutsceneAnimFrameLZ_2c_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_2d:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_2d.bin" ; $6dc7, 15 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_2d.inc" ; DEF CutsceneAnimFrameLZ_2d_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_2e:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_2e.bin" ; $6dd6, 15 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_2e.inc" ; DEF CutsceneAnimFrameLZ_2e_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_2f:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_2f.bin" ; $6de5, 15 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_2f.inc" ; DEF CutsceneAnimFrameLZ_2f_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_30:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_30.bin" ; $6df4, 19 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_30.inc" ; DEF CutsceneAnimFrameLZ_30_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_31:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_31.bin" ; $6e07, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_31.inc" ; DEF CutsceneAnimFrameLZ_31_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_32:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_32.bin" ; $6e1d, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_32.inc" ; DEF CutsceneAnimFrameLZ_32_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_33:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_33.bin" ; $6e33, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_33.inc" ; DEF CutsceneAnimFrameLZ_33_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_34:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_34.bin" ; $6e49, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_34.inc" ; DEF CutsceneAnimFrameLZ_34_SIZE EQU its decoded length, generated from the .bin by make
CutsceneAnimFrameLZ_35:
	INCBIN "data/bank_003/lz_CutsceneAnimFrameLZ_35.bin" ; $6e5f, 22 bytes
	INCLUDE "data/bank_003/lz_CutsceneAnimFrameLZ_35.inc" ; DEF CutsceneAnimFrameLZ_35_SIZE EQU its decoded length, generated from the .bin by make
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate0:
	; $6e75, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate1:
	; $6e7e, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate2:
	; $6e87, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate3:
	; $6e90, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate4:
	; $6e99, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate5:
	; $6ea2, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate6:
	; $6eab, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate7:
	; $6eb4, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate8:
	; $6ebd, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate0:
	; $6ec6, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate1:
	; $6ecf, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate2:
	; $6ed8, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate3:
	; $6ee1, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate4:
	; $6eea, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate5:
	; $6ef3, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate6:
	; $6efc, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate7:
	; $6f05, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate8:
	; $6f0e, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate0:
	; $6f17, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate1:
	; $6f20, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate2:
	; $6f29, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate3:
	; $6f32, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate4:
	; $6f3b, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate5:
	; $6f44, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate6:
	; $6f4d, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate7:
	; $6f56, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate8:
	; $6f5f, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate0:
	; $6f68, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate1:
	; $6f6d, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate2:
	; $6f72, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate3:
	; $6f77, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate4:
	; $6f7c, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate5:
	; $6f81, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate6:
	; $6f86, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate7:
	; $6f8b, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate8:
	; $6f90, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate0:
	; $6f95, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate1:
	; $6f9a, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate2:
	; $6f9f, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate3:
	; $6fa4, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate4:
	; $6fa9, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate5:
	; $6fae, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate6:
	; $6fb3, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate7:
	; $6fb8, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate8:
	; $6fbd, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate0:
	; $6fc2, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate1:
	; $6fc7, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate2:
	; $6fcc, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate3:
	; $6fd1, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate4:
	; $6fd6, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate5:
	; $6fdb, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate6:
	; $6fe0, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate7:
	; $6fe5, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate8:
	; $6fea, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end

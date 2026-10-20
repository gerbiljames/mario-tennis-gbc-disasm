AnimateEpilogueEndDot3:
	wram_bank WRAM_SCENE ; $6408
	ld a, [wSceneAnimFrame] ; $640e
	ld b, a ; $6411
	sub $2d ; $6412
	ret c ; $6414
	ld a, b ; $6415
	cp $2d ; $6416
	jp z, .frame2d ; $6418
	cp $2e ; $641b
	jp z, .frame2e ; $641d
	cp $2f ; $6420
	jp z, .frame2f ; $6422
	cp $30 ; $6425
	jp z, .frame30 ; $6427
	cp $31 ; $642a
	jp z, .frame31 ; $642c
	cp $32 ; $642f
	jp z, .frame32 ; $6431
	cp $33 ; $6434
	jp z, .frame33 ; $6436
	cp $34 ; $6439
	jp z, .frame34 ; $643b
	cp $35 ; $643e
	jp z, .frame35 ; $6440
	jp .queueSpriteTemplate ; $6443
.frame2d:
	wram_bank WRAM_STAGING ; $6446
	ld hl, EpilogueEndDot3_0 ; $644c
	ld de, wDecompBuffer tile 16 ; $644f
	call DecompressData ; $6452
	ld hl, wDecompBuffer tile 16 ; $6455
	ld de, vTiles0 tile $10 ; $6458
	ld c, EpilogueEndDot3_0_SIZE / 16 ; $645b
	call QueueVRAMCopy ; $645d
	ld hl, AnimateEpilogueEndDot3_SpriteTemplate0 ; $6460
	sprite_xy $3e, $80 ; $6463
	ld_oam bc, 3, $10 ; $6467
	call QueueSpriteTemplate ; $646a
	ret ; $646d
.frame2e:
	wram_bank WRAM_STAGING ; $646e
	ld hl, EpilogueEndDot3_1 ; $6474
	ld de, wDecompBuffer tile 16 ; $6477
	call DecompressData ; $647a
	ld hl, wDecompBuffer tile 16 ; $647d
	ld de, vTiles0 tile $10 ; $6480
	ld c, EpilogueEndDot3_1_SIZE / 16 ; $6483
	call QueueVRAMCopy ; $6485
	ld hl, AnimateEpilogueEndDot3_SpriteTemplate1 ; $6488
	sprite_xy $3e, $80 ; $648b
	ld_oam bc, 3, $10 ; $648f
	call QueueSpriteTemplate ; $6492
	ret ; $6495
.frame2f:
	wram_bank WRAM_STAGING ; $6496
	ld hl, EpilogueEndDot3_2 ; $649c
	ld de, wDecompBuffer tile 16 ; $649f
	call DecompressData ; $64a2
	ld hl, wDecompBuffer tile 16 ; $64a5
	ld de, vTiles0 tile $10 ; $64a8
	ld c, EpilogueEndDot3_2_SIZE / 16 ; $64ab
	call QueueVRAMCopy ; $64ad
	ld hl, AnimateEpilogueEndDot3_SpriteTemplate2 ; $64b0
	sprite_xy $3e, $80 ; $64b3
	ld_oam bc, 3, $10 ; $64b7
	call QueueSpriteTemplate ; $64ba
	ret ; $64bd
.frame30:
	wram_bank WRAM_STAGING ; $64be
	ld hl, EpilogueEndDot3_3 ; $64c4
	ld de, wDecompBuffer tile 16 ; $64c7
	call DecompressData ; $64ca
	ld hl, wDecompBuffer tile 16 ; $64cd
	ld de, vTiles0 tile $10 ; $64d0
	ld c, EpilogueEndDot3_3_SIZE / 16 ; $64d3
	call QueueVRAMCopy ; $64d5
	ld hl, AnimateEpilogueEndDot3_SpriteTemplate3 ; $64d8
	sprite_xy $3e, $80 ; $64db
	ld_oam bc, 3, $10 ; $64df
	call QueueSpriteTemplate ; $64e2
	ret ; $64e5
.frame31:
	wram_bank WRAM_STAGING ; $64e6
	ld hl, EpilogueEndDot3_4 ; $64ec
	ld de, wDecompBuffer tile 16 ; $64ef
	call DecompressData ; $64f2
	ld hl, wDecompBuffer tile 16 ; $64f5
	ld de, vTiles0 tile $10 ; $64f8
	ld c, EpilogueEndDot3_4_SIZE / 16 ; $64fb
	call QueueVRAMCopy ; $64fd
	ld hl, AnimateEpilogueEndDot3_SpriteTemplate4 ; $6500
	sprite_xy $3e, $80 ; $6503
	ld_oam bc, 3, $10 ; $6507
	call QueueSpriteTemplate ; $650a
	ret ; $650d
.frame32:
	wram_bank WRAM_STAGING ; $650e
	ld hl, EpilogueEndDot3_5 ; $6514
	ld de, wDecompBuffer tile 16 ; $6517
	call DecompressData ; $651a
	ld hl, wDecompBuffer tile 16 ; $651d
	ld de, vTiles0 tile $10 ; $6520
	ld c, EpilogueEndDot3_5_SIZE / 16 ; $6523
	call QueueVRAMCopy ; $6525
	ld hl, AnimateEpilogueEndDot3_SpriteTemplate5 ; $6528
	sprite_xy $3e, $80 ; $652b
	ld_oam bc, 3, $10 ; $652f
	call QueueSpriteTemplate ; $6532
	ret ; $6535
.frame33:
	wram_bank WRAM_STAGING ; $6536
	ld hl, EpilogueEndDot3_6 ; $653c
	ld de, wDecompBuffer tile 16 ; $653f
	call DecompressData ; $6542
	ld hl, wDecompBuffer tile 16 ; $6545
	ld de, vTiles0 tile $10 ; $6548
	ld c, EpilogueEndDot3_6_SIZE / 16 ; $654b
	call QueueVRAMCopy ; $654d
	ld hl, AnimateEpilogueEndDot3_SpriteTemplate6 ; $6550
	sprite_xy $3e, $80 ; $6553
	ld_oam bc, 3, $10 ; $6557
	call QueueSpriteTemplate ; $655a
	ret ; $655d
.frame34:
	wram_bank WRAM_STAGING ; $655e
	ld hl, EpilogueEndDot3_7 ; $6564
	ld de, wDecompBuffer tile 16 ; $6567
	call DecompressData ; $656a
	ld hl, wDecompBuffer tile 16 ; $656d
	ld de, vTiles0 tile $10 ; $6570
	ld c, EpilogueEndDot3_7_SIZE / 16 ; $6573
	call QueueVRAMCopy ; $6575
	ld hl, AnimateEpilogueEndDot3_SpriteTemplate7 ; $6578
	sprite_xy $3e, $80 ; $657b
	ld_oam bc, 3, $10 ; $657f
	call QueueSpriteTemplate ; $6582
	ret ; $6585
.frame35:
	wram_bank WRAM_STAGING ; $6586
	ld hl, EpilogueEndDot3_8 ; $658c
	ld de, wDecompBuffer tile 16 ; $658f
	call DecompressData ; $6592
	ld hl, wDecompBuffer tile 16 ; $6595
	ld de, vTiles0 tile $10 ; $6598
	ld c, EpilogueEndDot3_8_SIZE / 16 ; $659b
	call QueueVRAMCopy ; $659d
	ld hl, AnimateEpilogueEndDot3_SpriteTemplate8 ; $65a0
	sprite_xy $3e, $80 ; $65a3
	ld_oam bc, 3, $10 ; $65a7
	call QueueSpriteTemplate ; $65aa
	ret ; $65ad
.queueSpriteTemplate:
	ld hl, AnimateEpilogueEndDot3_SpriteTemplate8 ; $65ae
	sprite_xy $3e, $80 ; $65b1
	ld_oam bc, 3, $10 ; $65b5
	call QueueSpriteTemplate ; $65b8
	ret ; $65bb
EpilogueEndOrangePalette:
	INCLUDE "data/engine/cutscenes/EpilogueEndOrangePalette.asm" ; $65bc, 8 bytes (palettes)
EpilogueEndGreenPalette:
	INCLUDE "data/engine/cutscenes/EpilogueEndGreenPalette.asm" ; $65c4, 8 bytes (palettes)
	; $65cc, 4 bytes (fill)
	ds 4, $00
EpilogueEndLetterE_0:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterE_0.bin" ; $65d0, 42 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterE_0.inc" ; DEF EpilogueEndLetterE_0_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterE_1:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterE_1.bin" ; $65fa, 46 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterE_1.inc" ; DEF EpilogueEndLetterE_1_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterE_2:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterE_2.bin" ; $6628, 48 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterE_2.inc" ; DEF EpilogueEndLetterE_2_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterE_3:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterE_3.bin" ; $6658, 65 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterE_3.inc" ; DEF EpilogueEndLetterE_3_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterE_4:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterE_4.bin" ; $6699, 66 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterE_4.inc" ; DEF EpilogueEndLetterE_4_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterE_5:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterE_5.bin" ; $66db, 72 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterE_5.inc" ; DEF EpilogueEndLetterE_5_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterE_6:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterE_6.bin" ; $6723, 73 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterE_6.inc" ; DEF EpilogueEndLetterE_6_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterE_7:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterE_7.bin" ; $676c, 73 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterE_7.inc" ; DEF EpilogueEndLetterE_7_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterE_8:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterE_8.bin" ; $67b5, 71 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterE_8.inc" ; DEF EpilogueEndLetterE_8_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterN_0:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterN_0.bin" ; $67fc, 38 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterN_0.inc" ; DEF EpilogueEndLetterN_0_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterN_1:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterN_1.bin" ; $6822, 46 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterN_1.inc" ; DEF EpilogueEndLetterN_1_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterN_2:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterN_2.bin" ; $6850, 46 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterN_2.inc" ; DEF EpilogueEndLetterN_2_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterN_3:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterN_3.bin" ; $687e, 67 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterN_3.inc" ; DEF EpilogueEndLetterN_3_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterN_4:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterN_4.bin" ; $68c1, 75 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterN_4.inc" ; DEF EpilogueEndLetterN_4_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterN_5:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterN_5.bin" ; $690c, 75 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterN_5.inc" ; DEF EpilogueEndLetterN_5_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterN_6:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterN_6.bin" ; $6957, 75 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterN_6.inc" ; DEF EpilogueEndLetterN_6_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterN_7:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterN_7.bin" ; $69a2, 74 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterN_7.inc" ; DEF EpilogueEndLetterN_7_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterN_8:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterN_8.bin" ; $69ec, 73 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterN_8.inc" ; DEF EpilogueEndLetterN_8_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterD_0:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterD_0.bin" ; $6a35, 39 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterD_0.inc" ; DEF EpilogueEndLetterD_0_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterD_1:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterD_1.bin" ; $6a5c, 49 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterD_1.inc" ; DEF EpilogueEndLetterD_1_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterD_2:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterD_2.bin" ; $6a8d, 53 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterD_2.inc" ; DEF EpilogueEndLetterD_2_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterD_3:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterD_3.bin" ; $6ac2, 66 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterD_3.inc" ; DEF EpilogueEndLetterD_3_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterD_4:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterD_4.bin" ; $6b04, 69 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterD_4.inc" ; DEF EpilogueEndLetterD_4_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterD_5:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterD_5.bin" ; $6b49, 73 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterD_5.inc" ; DEF EpilogueEndLetterD_5_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterD_6:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterD_6.bin" ; $6b92, 74 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterD_6.inc" ; DEF EpilogueEndLetterD_6_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterD_7:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterD_7.bin" ; $6bdc, 74 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterD_7.inc" ; DEF EpilogueEndLetterD_7_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndLetterD_8:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndLetterD_8.bin" ; $6c26, 69 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndLetterD_8.inc" ; DEF EpilogueEndLetterD_8_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot1_0:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot1_0.bin" ; $6c6b, 15 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot1_0.inc" ; DEF EpilogueEndDot1_0_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot1_1:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot1_1.bin" ; $6c7a, 15 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot1_1.inc" ; DEF EpilogueEndDot1_1_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot1_2:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot1_2.bin" ; $6c89, 15 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot1_2.inc" ; DEF EpilogueEndDot1_2_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot1_3:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot1_3.bin" ; $6c98, 19 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot1_3.inc" ; DEF EpilogueEndDot1_3_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot1_4:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot1_4.bin" ; $6cab, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot1_4.inc" ; DEF EpilogueEndDot1_4_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot1_5:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot1_5.bin" ; $6cc1, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot1_5.inc" ; DEF EpilogueEndDot1_5_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot1_6:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot1_6.bin" ; $6cd7, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot1_6.inc" ; DEF EpilogueEndDot1_6_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot1_7:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot1_7.bin" ; $6ced, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot1_7.inc" ; DEF EpilogueEndDot1_7_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot1_8:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot1_8.bin" ; $6d03, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot1_8.inc" ; DEF EpilogueEndDot1_8_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot2_0:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot2_0.bin" ; $6d19, 15 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot2_0.inc" ; DEF EpilogueEndDot2_0_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot2_1:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot2_1.bin" ; $6d28, 15 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot2_1.inc" ; DEF EpilogueEndDot2_1_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot2_2:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot2_2.bin" ; $6d37, 15 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot2_2.inc" ; DEF EpilogueEndDot2_2_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot2_3:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot2_3.bin" ; $6d46, 20 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot2_3.inc" ; DEF EpilogueEndDot2_3_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot2_4:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot2_4.bin" ; $6d5a, 21 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot2_4.inc" ; DEF EpilogueEndDot2_4_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot2_5:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot2_5.bin" ; $6d6f, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot2_5.inc" ; DEF EpilogueEndDot2_5_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot2_6:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot2_6.bin" ; $6d85, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot2_6.inc" ; DEF EpilogueEndDot2_6_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot2_7:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot2_7.bin" ; $6d9b, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot2_7.inc" ; DEF EpilogueEndDot2_7_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot2_8:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot2_8.bin" ; $6db1, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot2_8.inc" ; DEF EpilogueEndDot2_8_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot3_0:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot3_0.bin" ; $6dc7, 15 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot3_0.inc" ; DEF EpilogueEndDot3_0_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot3_1:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot3_1.bin" ; $6dd6, 15 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot3_1.inc" ; DEF EpilogueEndDot3_1_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot3_2:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot3_2.bin" ; $6de5, 15 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot3_2.inc" ; DEF EpilogueEndDot3_2_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot3_3:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot3_3.bin" ; $6df4, 19 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot3_3.inc" ; DEF EpilogueEndDot3_3_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot3_4:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot3_4.bin" ; $6e07, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot3_4.inc" ; DEF EpilogueEndDot3_4_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot3_5:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot3_5.bin" ; $6e1d, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot3_5.inc" ; DEF EpilogueEndDot3_5_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot3_6:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot3_6.bin" ; $6e33, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot3_6.inc" ; DEF EpilogueEndDot3_6_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot3_7:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot3_7.bin" ; $6e49, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot3_7.inc" ; DEF EpilogueEndDot3_7_SIZE EQU its decoded length, generated from the .bin by make
EpilogueEndDot3_8:
	INCBIN "data/engine/cutscenes/lz_EpilogueEndDot3_8.bin" ; $6e5f, 22 bytes
	INCLUDE "data/engine/cutscenes/lz_EpilogueEndDot3_8.inc" ; DEF EpilogueEndDot3_8_SIZE EQU its decoded length, generated from the .bin by make
AnimateEpilogueEndE_SpriteTemplate0:
	; $6e75, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndE_SpriteTemplate1:
	; $6e7e, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndE_SpriteTemplate2:
	; $6e87, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndE_SpriteTemplate3:
	; $6e90, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndE_SpriteTemplate4:
	; $6e99, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndE_SpriteTemplate5:
	; $6ea2, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndE_SpriteTemplate6:
	; $6eab, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndE_SpriteTemplate7:
	; $6eb4, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndE_SpriteTemplate8:
	; $6ebd, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndN_SpriteTemplate0:
	; $6ec6, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndN_SpriteTemplate1:
	; $6ecf, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndN_SpriteTemplate2:
	; $6ed8, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndN_SpriteTemplate3:
	; $6ee1, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndN_SpriteTemplate4:
	; $6eea, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndN_SpriteTemplate5:
	; $6ef3, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndN_SpriteTemplate6:
	; $6efc, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndN_SpriteTemplate7:
	; $6f05, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndN_SpriteTemplate8:
	; $6f0e, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndD_SpriteTemplate0:
	; $6f17, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndD_SpriteTemplate1:
	; $6f20, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndD_SpriteTemplate2:
	; $6f29, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndD_SpriteTemplate3:
	; $6f32, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndD_SpriteTemplate4:
	; $6f3b, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndD_SpriteTemplate5:
	; $6f44, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndD_SpriteTemplate6:
	; $6f4d, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndD_SpriteTemplate7:
	; $6f56, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndD_SpriteTemplate8:
	; $6f5f, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
AnimateEpilogueEndDot1_SpriteTemplate0:
	; $6f68, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot1_SpriteTemplate1:
	; $6f6d, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot1_SpriteTemplate2:
	; $6f72, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot1_SpriteTemplate3:
	; $6f77, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot1_SpriteTemplate4:
	; $6f7c, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot1_SpriteTemplate5:
	; $6f81, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot1_SpriteTemplate6:
	; $6f86, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot1_SpriteTemplate7:
	; $6f8b, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot1_SpriteTemplate8:
	; $6f90, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot2_SpriteTemplate0:
	; $6f95, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot2_SpriteTemplate1:
	; $6f9a, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot2_SpriteTemplate2:
	; $6f9f, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot2_SpriteTemplate3:
	; $6fa4, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot2_SpriteTemplate4:
	; $6fa9, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot2_SpriteTemplate5:
	; $6fae, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot2_SpriteTemplate6:
	; $6fb3, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot2_SpriteTemplate7:
	; $6fb8, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot2_SpriteTemplate8:
	; $6fbd, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot3_SpriteTemplate0:
	; $6fc2, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot3_SpriteTemplate1:
	; $6fc7, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot3_SpriteTemplate2:
	; $6fcc, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot3_SpriteTemplate3:
	; $6fd1, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot3_SpriteTemplate4:
	; $6fd6, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot3_SpriteTemplate5:
	; $6fdb, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot3_SpriteTemplate6:
	; $6fe0, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot3_SpriteTemplate7:
	; $6fe5, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
AnimateEpilogueEndDot3_SpriteTemplate8:
	; $6fea, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end

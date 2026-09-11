SECTION "ROM Bank $28", ROMX[$4000], BANK[$28]

	farptr LoadMatchGraphics ; $4000
	farptr LoadMatchVariantGraphics ; $4002
	farptr LoadSpecialHitEffectTiles ; $4004
	farptr LoadBallTouchCharEffectTilesA ; $4006
	farptr LoadBallTouchCharEffectTilesB ; $4008
	farptr LoadMatchStoryGfx ; $400a
	farptr QueueMatchSpriteFrameA ; $400c
	farptr LoadEffectFrameTiles_28 ; $400e
	farptr QueueMatchSpriteFrameB ; $4010
Padding_28_0:
	; $4012, 14 bytes (fill)
	ds 14, $00
MatchGraphicsGfx:
	INCBIN "data/bank_028/MatchGraphicsGfx.bin" ; $4020, 832 bytes
SpecialHitEffectTiles_28:
	INCBIN "data/bank_028/SpecialHitEffectTiles_28.bin" ; $4360, 256 bytes
BallTouchCharEffectTilesA_28:
	INCBIN "data/bank_028/BallTouchCharEffectTilesA_28.bin" ; $4460, 256 bytes
BallTouchCharEffectTilesB_28:
	INCBIN "data/bank_028/BallTouchCharEffectTilesB_28.bin" ; $4560, 128 bytes
MatchGfxTilesA_28:
	INCBIN "data/bank_028/lz_MatchGfxTilesA_28.bin" ; $45e0, 1472 bytes
MatchGfxPalettesA_28:
	INCLUDE "data/bank_028/MatchGfxPalettesA_28.asm" ; $4ba0, 64 bytes (palettes)
MatchGraphicsPalettes:
	INCLUDE "data/bank_028/MatchGraphicsPalettes.asm" ; $4be0, 16 bytes (palettes)
MatchGfxMapsA_28:
	INCBIN "data/bank_028/MatchGfxMapsA_28.bin" ; $4bf0, 320 bytes
MatchVariantTiles0:
	INCBIN "data/bank_028/MatchVariantTiles0.bin" ; $4d30, 256 bytes
MatchVariantTiles1:
	INCBIN "data/bank_028/MatchVariantTiles1.bin" ; $4e30, 768 bytes
MatchVariantTiles2:
	INCBIN "data/bank_028/MatchVariantTiles2.bin" ; $5130, 832 bytes
MatchVariantTiles3:
	INCBIN "data/bank_028/MatchVariantTiles3.bin" ; $5470, 32 bytes
MatchVariantTiles4:
	INCBIN "data/bank_028/MatchVariantTiles4.bin" ; $5490, 256 bytes
MatchSharedTiles_28:
	INCBIN "data/bank_028/MatchSharedTiles_28.bin" ; $5590, 2208 bytes
MatchGfxPalettesB_28:
	INCLUDE "data/bank_028/MatchGfxPalettesB_28.asm" ; $5e30, 8 bytes (palettes)
MatchVariantGraphicsPalettes0:
	INCLUDE "data/bank_028/MatchVariantGraphicsPalettes0.asm" ; $5e38, 24 bytes (palettes)
MatchVariantGraphicsPalettes1:
	INCLUDE "data/bank_028/MatchVariantGraphicsPalettes1.asm" ; $5e50, 24 bytes (palettes)
MatchVariantGraphicsPalettes2:
	INCLUDE "data/bank_028/MatchVariantGraphicsPalettes2.asm" ; $5e68, 16 bytes (palettes)
MatchVariantGraphicsPalettes3:
	INCLUDE "data/bank_028/MatchVariantGraphicsPalettes3.asm" ; $5e78, 8 bytes (palettes)
MatchVariantGraphicsPalettes4:
	INCLUDE "data/bank_028/MatchVariantGraphicsPalettes4.asm" ; $5e80, 24 bytes (palettes)
MatchVariantGraphicsPalettes5:
	INCLUDE "data/bank_028/MatchVariantGraphicsPalettes5.asm" ; $5e98, 8 bytes (palettes)
MatchVariantGraphicsPalettes6:
	INCLUDE "data/bank_028/MatchVariantGraphicsPalettes6.asm" ; $5ea0, 16 bytes (palettes)
LoadMatchGraphics:
	wram_bank $01 ; $5eb0
	ld hl, MatchGfxPalettesA_28 ; $5eb6
	lb de, $08, $03 ; $5eb9 palette index, count
	call LoadPaletteShadow ; $5ebc
	ld hl, MatchGraphicsPalettes ; $5ebf
	lb de, $00, $02 ; $5ec2 palette index, count
	call LoadPaletteShadow ; $5ec5
	ld hl, MatchGraphicsGfx ; $5ec8
	ld de, $8400 + VRAM_BANK1 ; $5ecb
	ld c, $40 ; $5ece
	call QueueVRAMCopy ; $5ed0
	ld hl, MatchGfxTilesA_28 ; $5ed3
	ld de, wDecompBuffer ; $5ed6
	call DecompressData ; $5ed9
	ld hl, wDecompBuffer ; $5edc
	ld de, $9000 ; $5edf
	ld c, $80 ; $5ee2 -- 128 of MatchGfxTilesA_28's 256 tiles
	call QueueVRAMCopy ; $5ee4
	ld hl, wTextTileBuffer ; $5ee7
	ld de, $8800 ; $5eea
	ld c, $80 ; $5eed
	call QueueVRAMCopy ; $5eef
	ld a, [wMatchContext] ; $5ef2
	cp $02 ; $5ef5
	call z, LoadMatchVariantGraphics ; $5ef7
	ret ; $5efa
LoadMatchVariantGraphics:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5efb
	sub MINIGAME_TENNIS_MACHINE_1 ; $5efe
	jr c, .carry ; $5f00
	ld a, a ; $5f02
	rst Rst00 ; $5f03
	dw LoadMatchVariantGraphics.loadMatchSharedTiles ; $5f04 jumptable
	dw LoadMatchVariantGraphics.loadMatchSharedTiles ; $5f06 jumptable
	dw LoadMatchVariantGraphics.loadMatchSharedTiles ; $5f08 jumptable
	dw LoadMatchVariantGraphics.loadMatchSharedTiles ; $5f0a jumptable
	dw LoadMatchVariantGraphics.loadPaletteShadow ; $5f0c jumptable
	dw LoadMatchVariantGraphics.loadPaletteShadow ; $5f0e jumptable
	dw LoadMatchVariantGraphics.loadPaletteShadow ; $5f10 jumptable
	dw LoadMatchVariantGraphics.loadPaletteShadow ; $5f12 jumptable
	dw LoadMatchVariantGraphics.loadMatchSharedTiles ; $5f14 jumptable
	dw LoadMatchVariantGraphics.loadPaletteShadow ; $5f16 jumptable
	dw LoadMatchVariantGraphics.loadPaletteShadow2 ; $5f18 jumptable
	dw LoadMatchVariantGraphics.loadPaletteShadow3 ; $5f1a jumptable
	dw LoadMatchVariantGraphics.loadPaletteShadow ; $5f1c jumptable
	dw LoadMatchVariantGraphics.queueVRAMCopy ; $5f1e jumptable
	dw LoadMatchVariantGraphics.loadPaletteShadow6 ; $5f20 jumptable
	dw LoadMatchVariantGraphics.loadPaletteShadow5 ; $5f22 jumptable
	dw LoadMatchVariantGraphics.queueVRAMCopy2 ; $5f24 jumptable
	dw LoadMatchVariantGraphics.loadPaletteShadow4 ; $5f26 jumptable
	dw LoadMatchVariantGraphics.carry ; $5f28 jumptable
.carry:
	ld hl, MatchGfxMapsA_28 ; $5f2a
	ld de, $8200 + VRAM_BANK1 ; $5f2d
	ld c, $20 ; $5f30
	call QueueVRAMCopy ; $5f32
	ret ; $5f35
.loadMatchSharedTiles:
	call LoadMatchSharedTiles_28 ; $5f36
	ret ; $5f39
.loadPaletteShadow:
	ld hl, MatchGfxPalettesB_28 ; $5f3a
	lb de, $0b, $01 ; $5f3d palette index, count
	call LoadPaletteShadow ; $5f40
	ld hl, MatchVariantGraphicsPalettes0 ; $5f43
	lb de, $0d, $03 ; $5f46 palette index, count
	call LoadPaletteShadow ; $5f49
	ld hl, MatchVariantTiles0 ; $5f4c
	ld de, $8100 + VRAM_BANK1 ; $5f4f
	ld c, (MatchVariantTiles1 - MatchVariantTiles0) / 16 ; $5f52
	call QueueVRAMCopy ; $5f54
	call LoadMatchSharedTiles_28 ; $5f57
	ret ; $5f5a
.queueVRAMCopy:
	ld hl, MatchGfxMapsA_28 ; $5f5b
	ld de, $8200 + VRAM_BANK1 ; $5f5e
	ld c, $08 ; $5f61 -- 8 of MatchGfxMapsA_28's 20 tiles
	call QueueVRAMCopy ; $5f63
	call LoadMatchSharedTiles_28 ; $5f66
	ret ; $5f69
.loadPaletteShadow2:
	ld hl, MatchVariantGraphicsPalettes6 ; $5f6a
	lb de, $0e, $02 ; $5f6d palette index, count
	call LoadPaletteShadow ; $5f70
	ld hl, MatchVariantTiles3 ; $5f73
	ld de, $83c0 + VRAM_BANK1 ; $5f76
	ld c, (MatchVariantTiles4 - MatchVariantTiles3) / 16 ; $5f79
	call QueueVRAMCopy ; $5f7b
	call LoadMatchSharedTiles_28 ; $5f7e
	ret ; $5f81
.loadPaletteShadow3:
	ld hl, MatchVariantGraphicsPalettes2 ; $5f82
	lb de, $0e, $02 ; $5f85 palette index, count
	call LoadPaletteShadow ; $5f88
	ld hl, MatchVariantTiles3 ; $5f8b
	ld de, $83c0 + VRAM_BANK1 ; $5f8e
	ld c, (MatchVariantTiles4 - MatchVariantTiles3) / 16 ; $5f91
	call QueueVRAMCopy ; $5f93
	call LoadMatchSharedTiles_28 ; $5f96
	ret ; $5f99
.loadPaletteShadow4:
	ld hl, MatchVariantGraphicsPalettes3 ; $5f9a
	lb de, $0f, $01 ; $5f9d palette index, count
	call LoadPaletteShadow ; $5fa0
	ld hl, MatchVariantTiles4 ; $5fa3
	ld de, $8200 + VRAM_BANK1 ; $5fa6
	ld c, (MatchSharedTiles_28 - MatchVariantTiles4) / 16 ; $5fa9
	call QueueVRAMCopy ; $5fab
	ld hl, MatchVariantTiles3 ; $5fae
	ld de, $83c0 + VRAM_BANK1 ; $5fb1
	ld c, (MatchVariantTiles4 - MatchVariantTiles3) / 16 ; $5fb4
	call QueueVRAMCopy ; $5fb6
	call LoadMatchSharedTiles_28 ; $5fb9
	ret ; $5fbc
.queueVRAMCopy2:
	ld hl, MatchGfxMapsA_28 ; $5fbd
	ld de, $8200 + VRAM_BANK1 ; $5fc0
	ld c, $08 ; $5fc3 -- 8 of MatchGfxMapsA_28's 20 tiles
	call QueueVRAMCopy ; $5fc5
	ld hl, MatchVariantGraphicsPalettes4 ; $5fc8
	lb de, $0e, $01 ; $5fcb palette index, count
	call LoadPaletteShadow ; $5fce
	ld hl, MatchVariantGraphicsPalettes5 ; $5fd1
	lb de, $0f, $01 ; $5fd4 palette index, count
	call LoadPaletteShadow ; $5fd7
	ld hl, MatchVariantTiles3 ; $5fda
	ld de, $83c0 + VRAM_BANK1 ; $5fdd
	ld c, (MatchVariantTiles4 - MatchVariantTiles3) / 16 ; $5fe0
	call QueueVRAMCopy ; $5fe2
	call LoadMatchSharedTiles_28 ; $5fe5
	ret ; $5fe8
.loadPaletteShadow5:
	ld hl, MatchVariantGraphicsPalettes1 ; $5fe9
	lb de, $0d, $03 ; $5fec palette index, count
	call LoadPaletteShadow ; $5fef
	ld hl, MatchVariantTiles1 ; $5ff2
	ld de, $8100 + VRAM_BANK1 ; $5ff5
	ld c, $10 ; $5ff8 -- 16 of MatchVariantTiles1's 48 tiles
	call QueueVRAMCopy ; $5ffa
	ld hl, MatchVariantTiles2 ; $5ffd
	ld de, $8200 + VRAM_BANK1 ; $6000
	ld c, $10 ; $6003 -- 16 of MatchVariantTiles2's 52 tiles
	call QueueVRAMCopy ; $6005
	call LoadMatchSharedTiles_28 ; $6008
	ret ; $600b
.loadPaletteShadow6:
	ld hl, MatchVariantGraphicsPalettes1 ; $600c
	lb de, $0d, $03 ; $600f palette index, count
	call LoadPaletteShadow ; $6012
	ld hl, MatchVariantTiles1 ; $6015
	ld de, $8100 + VRAM_BANK1 ; $6018
	ld c, (MatchVariantTiles2 - MatchVariantTiles1) / 16 ; $601b
	call QueueVRAMCopy ; $601d
	call LoadMatchSharedTiles_28 ; $6020
	ret ; $6023
LoadMatchSharedTiles_28:
	ld hl, MatchSharedTiles_28 ; $6024
	ld de, $8080 ; $6027
	ld c, $14 ; $602a -- 20 of MatchSharedTiles_28's 138 tiles
	call QueueVRAMCopy ; $602c
	ret ; $602f
LoadSpecialHitEffectTiles:
	rrca ; $6030
	rrca ; $6031
	and $c0 ; $6032
	ld_hl_indexed SpecialHitEffectTiles_28 ; $6034
	ld de, $8740 + VRAM_BANK1 ; $603b
	ld c, $04 ; $603e
	call QueueVRAMCopy ; $6040
	ret ; $6043
LoadBallTouchCharEffectTilesA:
	rrca ; $6044
	rrca ; $6045
	and $40 ; $6046
	ld_hl_indexed BallTouchCharEffectTilesA_28 ; $6048
	ld de, $8780 + VRAM_BANK1 ; $604f
	ld c, $04 ; $6052
	call QueueVRAMCopy ; $6054
	ret ; $6057
LoadBallTouchCharEffectTilesB:
	rrca ; $6058
	rrca ; $6059
	and $40 ; $605a
	ld_hl_indexed BallTouchCharEffectTilesB_28 ; $605c
	ld de, $87c0 + VRAM_BANK1 ; $6063
	ld c, $04 ; $6066
	call QueueVRAMCopy ; $6068
	ret ; $606b
QueueMatchSpriteFrameA:
	add a ; $606c
	ld_hl_indexed QueueMatchSpriteFrameATable ; $606d
	ld a, [hl+] ; $6074
	ld h, [hl] ; $6075
	ld l, a ; $6076
	ld de, $8300 + VRAM_BANK1 ; $6077
	ld c, $0c ; $607a
	call QueueVRAMCopy ; $607c
	ret ; $607f
QueueMatchSpriteFrameATable:
	; $6080, 6 bytes (bytes:6)
	db $30, $52, $f0, $52, $b0, $53 ; 0x00
QueueMatchSpriteFrameB:
	add a ; $6086
	ld_hl_indexed QueueMatchSpriteFrameBTable ; $6087
	ld a, [hl+] ; $608e
	ld h, [hl] ; $608f
	ld l, a ; $6090
	ld de, $8300 + VRAM_BANK1 ; $6091
	ld c, $0c ; $6094
	call QueueVRAMCopy ; $6096
	ret ; $6099
QueueMatchSpriteFrameBTable:
	; $609a, 6 bytes (bytes:6)
	db $f0, $5b, $b0, $5c, $70, $5d ; 0x00
LoadEffectFrameTiles_28:
	ld h, $00 ; $60a0
	ld l, a ; $60a2
	add hl, hl ; $60a3
	add hl, hl ; $60a4
	add hl, hl ; $60a5
	add hl, hl ; $60a6
	add hl, hl ; $60a7
	add hl, hl ; $60a8
	ld e, l ; $60a9
	ld d, h ; $60aa
	ld a, b ; $60ab
	add a ; $60ac
	ld_hl_indexed LoadEffectFrameTiles_28Table ; $60ad
	ld a, [hl+] ; $60b4
	ld h, [hl] ; $60b5
	ld l, a ; $60b6
	add hl, de ; $60b7
	ld de, $8300 + VRAM_BANK1 ; $60b8
	ld c, $04 ; $60bb
	call QueueVRAMCopy ; $60bd
	ret ; $60c0
LoadEffectFrameTiles_28Table:
	; $60c1, 8 bytes (bytes:8)
	db $d0, $56, $10, $58, $50, $59, $90, $5a ; 0x00
LoadMatchStoryGfx:
	wram_bank $01 ; $60c9
	ld hl, MatchGfxPalettesC_28 ; $60cf
	lb de, $09, $02 ; $60d2 palette index, count
	call LoadPaletteShadow ; $60d5
	ld hl, MatchStoryGfxPalettes ; $60d8
	lb de, $00, $02 ; $60db palette index, count
	call LoadPaletteShadow ; $60de
	ld hl, MatchGfxTilesB_28 ; $60e1
	ld de, wDecompBuffer ; $60e4
	call DecompressData ; $60e7
	ld hl, wDecompBuffer ; $60ea
	ld de, $9000 ; $60ed
	ld c, $20 ; $60f0 -- 32 of MatchGfxTilesB_28's 256 tiles
	call QueueVRAMCopy ; $60f2
	push af ; $60f5
	ldh a, [rLCDC] ; $60f6
	bit 7, a ; $60f8
	jr z, .restore ; $60fa
	call AdvanceFrame ; $60fc
.restore:
	pop af ; $60ff
	ld hl, wDecompBuffer + 32 * TILE_SIZE ; $6100
	ld de, $9200 ; $6103
	ld c, $20 ; $6106 -- 32 of MatchGfxTilesB_28's 256 tiles from tile 32
	call QueueVRAMCopy ; $6108
	push af ; $610b
	ldh a, [rLCDC] ; $610c
	bit 7, a ; $610e
	jr z, .restore2 ; $6110
	call AdvanceFrame ; $6112
.restore2:
	pop af ; $6115
	ld hl, wDecompBuffer + 64 * TILE_SIZE ; $6116
	ld de, $9400 ; $6119
	ld c, $20 ; $611c
	call QueueVRAMCopy ; $611e
	push af ; $6121
	ldh a, [rLCDC] ; $6122
	bit 7, a ; $6124
	jr z, .restore3 ; $6126
	call AdvanceFrame ; $6128
.restore3:
	pop af ; $612b
	ld hl, wDecompBuffer + 96 * TILE_SIZE ; $612c
	ld de, $9600 ; $612f
	ld c, $20 ; $6132
	call QueueVRAMCopy ; $6134
	push af ; $6137
	ldh a, [rLCDC] ; $6138
	bit 7, a ; $613a
	jr z, .restore4 ; $613c
	call AdvanceFrame ; $613e
.restore4:
	pop af ; $6141
	ld hl, wTextTileBuffer ; $6142
	ld de, $8800 ; $6145
	ld c, $20 ; $6148
	ld hl, wTextTileBuffer + 32 * TILE_SIZE ; $614a
	ld de, $8a00 ; $614d
	ld c, $20 ; $6150
	ld hl, wTextTileBuffer + 64 * TILE_SIZE ; $6152
	ld de, $8c00 ; $6155
	ld c, $20 ; $6158
	ld hl, wTextTileBuffer + 96 * TILE_SIZE ; $615a
	ld de, $8e00 ; $615d
	ld c, $20 ; $6160
	call QueueVRAMCopy ; $6162
	push af ; $6165
	ldh a, [rLCDC] ; $6166
	bit 7, a ; $6168
	jr z, .restore5 ; $616a
	call AdvanceFrame ; $616c
.restore5:
	pop af ; $616f
	ret ; $6170
Padding_28_1:
	; $6171, 15 bytes (fill)
	ds 15, $00
MatchGfxTilesB_28:
	INCBIN "data/bank_028/lz_MatchGfxTilesB_28.bin" ; $6180, 2964 bytes
UnusedMatchGfxPalette_28:
	INCBIN "data/bank_028/UnusedMatchGfxPalette_28.bin" ; $6d14, 8 bytes
MatchGfxPalettesC_28:
	INCLUDE "data/bank_028/MatchGfxPalettesC_28.asm" ; $6d1c, 56 bytes (palettes)
MatchStoryGfxPalettes:
	INCLUDE "data/bank_028/MatchStoryGfxPalettes.asm" ; $6d54, 16 bytes (palettes)
	; $6d64, 4764 bytes fill to bank end (linker-padded)

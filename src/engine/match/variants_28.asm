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
	ds ALIGN[4]
MatchGraphicsGfx:
	INCBIN "data/engine/match/MatchGraphicsGfx.bin" ; $4020, 832 bytes
	ds ALIGN[4]
SpecialHitEffectTiles_28:
	INCBIN "data/engine/match/SpecialHitEffectTiles_28.bin" ; $4360, 256 bytes
	ds ALIGN[4]
BallTouchCharEffectTilesA_28:
	INCBIN "data/engine/match/BallTouchCharEffectTilesA_28.bin" ; $4460, 256 bytes
	ds ALIGN[4]
BallTouchCharEffectTilesB_28:
	INCBIN "data/engine/match/BallTouchCharEffectTilesB_28.bin" ; $4560, 128 bytes
MatchGfxTilesA_28:
	INCBIN "data/engine/match/lz_MatchGfxTilesA_28.bin" ; $45e0, 1472 bytes
MatchGfxPalettesA_28:
	INCLUDE "data/engine/match/MatchGfxPalettesA_28.asm" ; $4ba0, 64 bytes (palettes)
MatchGraphicsPalettes:
	INCLUDE "data/engine/match/MatchGraphicsPalettes.asm" ; $4be0, 16 bytes (palettes)
	ds ALIGN[4]
MinigameObjTiles_28:
	INCBIN "data/engine/match/MinigameObjTiles_28.bin" ; $4bf0, 320 bytes
	ds ALIGN[4]
MatchVariantTiles0:
	INCBIN "data/engine/match/MatchVariantTiles0.bin" ; $4d30, 256 bytes
	ds ALIGN[4]
MatchVariantTiles1:
	INCBIN "data/engine/match/MatchVariantTiles1.bin" ; $4e30, 768 bytes
	ds ALIGN[4]
MatchVariantTiles2:
	INCBIN "data/engine/match/MatchVariantTiles2.bin" ; $5130, 832 bytes
	ds ALIGN[4]
MatchVariantTiles3:
	INCBIN "data/engine/match/MatchVariantTiles3.bin" ; $5470, 32 bytes
	ds ALIGN[4]
MatchVariantTiles4:
	INCBIN "data/engine/match/MatchVariantTiles4.bin" ; $5490, 256 bytes
	ds ALIGN[4]
MatchSharedTiles_28:
	INCBIN "data/engine/match/MatchSharedTiles_28.bin" ; $5590, 2208 bytes
MatchGfxPalettesB_28:
	INCLUDE "data/engine/match/MatchGfxPalettesB_28.asm" ; $5e30, 8 bytes (palettes)
MatchVariantGraphicsPalettes0:
	INCLUDE "data/engine/match/MatchVariantGraphicsPalettes0.asm" ; $5e38, 24 bytes (palettes)
MatchVariantGraphicsPalettes1:
	INCLUDE "data/engine/match/MatchVariantGraphicsPalettes1.asm" ; $5e50, 24 bytes (palettes)
MatchVariantGraphicsPalettes2:
	INCLUDE "data/engine/match/MatchVariantGraphicsPalettes2.asm" ; $5e68, 16 bytes (palettes)
MatchVariantGraphicsPalettes3:
	INCLUDE "data/engine/match/MatchVariantGraphicsPalettes3.asm" ; $5e78, 8 bytes (palettes)
MatchVariantGraphicsPalettes4:
	INCLUDE "data/engine/match/MatchVariantGraphicsPalettes4.asm" ; $5e80, 24 bytes (palettes)
MatchVariantGraphicsPalettes5:
	INCLUDE "data/engine/match/MatchVariantGraphicsPalettes5.asm" ; $5e98, 8 bytes (palettes)
MatchVariantGraphicsPalettes6:
	INCLUDE "data/engine/match/MatchVariantGraphicsPalettes6.asm" ; $5ea0, 16 bytes (palettes)
LoadMatchGraphics:
	wram_bank WRAM_STAGING ; $5eb0
	ld hl, MatchGfxPalettesA_28 ; $5eb6
	ld_obj_pals de, 0, 3 ; $5eb9
	call LoadPaletteShadow ; $5ebc
	ld hl, MatchGraphicsPalettes ; $5ebf
	ld_bg_pals de, 0, 2 ; $5ec2
	call LoadPaletteShadow ; $5ec5
	ld hl, MatchGraphicsGfx ; $5ec8
	ld de, vTiles0 tile $40 + VRAM_BANK1 ; $5ecb
	ld c, (SpecialHitEffectTiles_28 - MatchGraphicsGfx) / 16 + 12 ; $5ece
	call QueueVRAMCopy ; $5ed0
	ld hl, MatchGfxTilesA_28 ; $5ed3
	ld de, wDecompBuffer ; $5ed6
	call DecompressData ; $5ed9
	ld hl, wDecompBuffer ; $5edc
	ld de, vTiles2 ; $5edf
	ld c, 128 ; $5ee2 -- 128 of MatchGfxTilesA_28's 256 tiles
	call QueueVRAMCopy ; $5ee4
	ld hl, wTextTileBuffer ; $5ee7
	ld de, vTiles1 ; $5eea
	ld c, wTextTileBuffer_SIZE / 16 ; $5eed
	call QueueVRAMCopy ; $5eef
	ld a, [wMatchContext] ; $5ef2
	cp MATCHCONTEXT_MINIGAME ; $5ef5
	call z, LoadMatchVariantGraphics ; $5ef7
	ret ; $5efa
LoadMatchVariantGraphics:
	ld a, [wCurrentMatchIndex] ; $5efb
	sub MINIGAME_TENNIS_MACHINE_1 ; $5efe
	jr c, .loadObjTiles ; $5f00
	jumptable a ; $5f02
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
	dw LoadMatchVariantGraphics.booBlast ; $5f18 jumptable
	dw LoadMatchVariantGraphics.shootingStar ; $5f1a jumptable
	dw LoadMatchVariantGraphics.loadPaletteShadow ; $5f1c jumptable
	dw LoadMatchVariantGraphics.targetShot ; $5f1e jumptable
	dw LoadMatchVariantGraphics.fruitFantasy ; $5f20 jumptable
	dw LoadMatchVariantGraphics.bananaBunch ; $5f22 jumptable
	dw LoadMatchVariantGraphics.treasureBox ; $5f24 jumptable
	dw LoadMatchVariantGraphics.medallionMatch ; $5f26 jumptable
	dw LoadMatchVariantGraphics.loadObjTiles ; $5f28 jumptable
.loadObjTiles:
	ld hl, MinigameObjTiles_28 ; $5f2a
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $5f2d
	ld c, (MatchVariantTiles0 - MinigameObjTiles_28) / 16 + 12 ; $5f30
	call QueueVRAMCopy ; $5f32
	ret ; $5f35
.loadMatchSharedTiles:
	call LoadMatchSharedTiles_28 ; $5f36
	ret ; $5f39
.loadPaletteShadow:
	ld hl, MatchGfxPalettesB_28 ; $5f3a
	ld_obj_pals de, 3, 1 ; $5f3d
	call LoadPaletteShadow ; $5f40
	ld hl, MatchVariantGraphicsPalettes0 ; $5f43
	ld_obj_pals de, 5, 3 ; $5f46
	call LoadPaletteShadow ; $5f49
	ld hl, MatchVariantTiles0 ; $5f4c
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $5f4f
	ld c, (MatchVariantTiles1 - MatchVariantTiles0) / 16 ; $5f52
	call QueueVRAMCopy ; $5f54
	call LoadMatchSharedTiles_28 ; $5f57
	ret ; $5f5a
.targetShot:
	ld hl, MinigameObjTiles_28 ; $5f5b
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $5f5e
	ld c, 8 ; $5f61 -- 8 of MinigameObjTiles_28's 20 tiles
	call QueueVRAMCopy ; $5f63
	call LoadMatchSharedTiles_28 ; $5f66
	ret ; $5f69
.booBlast:
	ld hl, MatchVariantGraphicsPalettes6 ; $5f6a
	ld_obj_pals de, 6, 2 ; $5f6d
	call LoadPaletteShadow ; $5f70
	ld hl, MatchVariantTiles3 ; $5f73
	ld de, vTiles0 tile $3c + VRAM_BANK1 ; $5f76
	ld c, (MatchVariantTiles4 - MatchVariantTiles3) / 16 ; $5f79
	call QueueVRAMCopy ; $5f7b
	call LoadMatchSharedTiles_28 ; $5f7e
	ret ; $5f81
.shootingStar:
	ld hl, MatchVariantGraphicsPalettes2 ; $5f82
	ld_obj_pals de, 6, 2 ; $5f85
	call LoadPaletteShadow ; $5f88
	ld hl, MatchVariantTiles3 ; $5f8b
	ld de, vTiles0 tile $3c + VRAM_BANK1 ; $5f8e
	ld c, (MatchVariantTiles4 - MatchVariantTiles3) / 16 ; $5f91
	call QueueVRAMCopy ; $5f93
	call LoadMatchSharedTiles_28 ; $5f96
	ret ; $5f99
.medallionMatch:
	ld hl, MatchVariantGraphicsPalettes3 ; $5f9a
	ld_obj_pals de, 7, 1 ; $5f9d
	call LoadPaletteShadow ; $5fa0
	ld hl, MatchVariantTiles4 ; $5fa3
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $5fa6
	ld c, (MatchSharedTiles_28 - MatchVariantTiles4) / 16 ; $5fa9
	call QueueVRAMCopy ; $5fab
	ld hl, MatchVariantTiles3 ; $5fae
	ld de, vTiles0 tile $3c + VRAM_BANK1 ; $5fb1
	ld c, (MatchVariantTiles4 - MatchVariantTiles3) / 16 ; $5fb4
	call QueueVRAMCopy ; $5fb6
	call LoadMatchSharedTiles_28 ; $5fb9
	ret ; $5fbc
.treasureBox:
	ld hl, MinigameObjTiles_28 ; $5fbd
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $5fc0
	ld c, 8 ; $5fc3 -- 8 of MinigameObjTiles_28's 20 tiles
	call QueueVRAMCopy ; $5fc5
	ld hl, MatchVariantGraphicsPalettes4 ; $5fc8
	ld_obj_pals de, 6, 1 ; $5fcb
	call LoadPaletteShadow ; $5fce
	ld hl, MatchVariantGraphicsPalettes5 ; $5fd1
	ld_obj_pals de, 7, 1 ; $5fd4
	call LoadPaletteShadow ; $5fd7
	ld hl, MatchVariantTiles3 ; $5fda
	ld de, vTiles0 tile $3c + VRAM_BANK1 ; $5fdd
	ld c, (MatchVariantTiles4 - MatchVariantTiles3) / 16 ; $5fe0
	call QueueVRAMCopy ; $5fe2
	call LoadMatchSharedTiles_28 ; $5fe5
	ret ; $5fe8
.bananaBunch:
	ld hl, MatchVariantGraphicsPalettes1 ; $5fe9
	ld_obj_pals de, 5, 3 ; $5fec
	call LoadPaletteShadow ; $5fef
	ld hl, MatchVariantTiles1 ; $5ff2
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $5ff5
	ld c, 16 ; $5ff8 -- 16 of MatchVariantTiles1's 48 tiles
	call QueueVRAMCopy ; $5ffa
	ld hl, MatchVariantTiles2 ; $5ffd
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $6000
	ld c, 16 ; $6003 -- 16 of MatchVariantTiles2's 52 tiles
	call QueueVRAMCopy ; $6005
	call LoadMatchSharedTiles_28 ; $6008
	ret ; $600b
.fruitFantasy:
	ld hl, MatchVariantGraphicsPalettes1 ; $600c
	ld_obj_pals de, 5, 3 ; $600f
	call LoadPaletteShadow ; $6012
	ld hl, MatchVariantTiles1 ; $6015
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $6018
	ld c, (MatchVariantTiles2 - MatchVariantTiles1) / 16 ; $601b
	call QueueVRAMCopy ; $601d
	call LoadMatchSharedTiles_28 ; $6020
	ret ; $6023
LoadMatchSharedTiles_28:
	ld hl, MatchSharedTiles_28 ; $6024
	ld de, vTiles0 tile $08 ; $6027
	ld c, 20 ; $602a -- 20 of MatchSharedTiles_28's 138 tiles
	call QueueVRAMCopy ; $602c
	ret ; $602f
LoadSpecialHitEffectTiles:
	rrca ; $6030
	rrca ; $6031
	and $c0 ; $6032
	ld_hl_indexed SpecialHitEffectTiles_28 ; $6034
	ld de, vTiles0 tile $74 + VRAM_BANK1 ; $603b
	ld c, 4 ; $603e
	call QueueVRAMCopy ; $6040
	ret ; $6043
LoadBallTouchCharEffectTilesA:
	rrca ; $6044
	rrca ; $6045
	and $40 ; $6046
	ld_hl_indexed BallTouchCharEffectTilesA_28 ; $6048
	ld de, vTiles0 tile $78 + VRAM_BANK1 ; $604f
	ld c, 4 ; $6052
	call QueueVRAMCopy ; $6054
	ret ; $6057
LoadBallTouchCharEffectTilesB:
	rrca ; $6058
	rrca ; $6059
	and $40 ; $605a
	ld_hl_indexed BallTouchCharEffectTilesB_28 ; $605c
	ld de, vTiles0 tile $7c + VRAM_BANK1 ; $6063
	ld c, 4 ; $6066
	call QueueVRAMCopy ; $6068
	ret ; $606b
QueueMatchSpriteFrameA:
	add a ; $606c
	ld_hl_indexed QueueMatchSpriteFrameATable ; $606d
	ld a, [hl+] ; $6074
	ld h, [hl] ; $6075
	ld l, a ; $6076
	ld de, vTiles0 tile $30 + VRAM_BANK1 ; $6077
	ld c, 12 ; $607a
	call QueueVRAMCopy ; $607c
	ret ; $607f
QueueMatchSpriteFrameATable:
	; $6080, 6 bytes (records:2)
	dw MatchVariantTiles2 tile 16 ; record 0
	dw MatchVariantTiles2 tile 28 ; record 1
	dw MatchVariantTiles2 tile 40 ; record 2
QueueMatchSpriteFrameB:
	add a ; $6086
	ld_hl_indexed QueueMatchSpriteFrameBTable ; $6087
	ld a, [hl+] ; $608e
	ld h, [hl] ; $608f
	ld l, a ; $6090
	ld de, vTiles0 tile $30 + VRAM_BANK1 ; $6091
	ld c, 12 ; $6094
	call QueueVRAMCopy ; $6096
	ret ; $6099
QueueMatchSpriteFrameBTable:
	; $609a, 6 bytes (records:2)
	dw MatchSharedTiles_28 tile 102 ; record 0
	dw MatchSharedTiles_28 tile 114 ; record 1
	dw MatchSharedTiles_28 tile 126 ; record 2
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
	ld de, vTiles0 tile $30 + VRAM_BANK1 ; $60b8
	ld c, 4 ; $60bb
	call QueueVRAMCopy ; $60bd
	ret ; $60c0
LoadEffectFrameTiles_28Table:
	; $60c1, 8 bytes (records:2)
	dw MatchSharedTiles_28 tile 20 ; record 0
	dw MatchSharedTiles_28 tile 40 ; record 1
	dw MatchSharedTiles_28 tile 60 ; record 2
	dw MatchSharedTiles_28 tile 80 ; record 3
LoadMatchStoryGfx:
	wram_bank WRAM_STAGING ; $60c9
	ld hl, MatchGfxPalettesC_28 ; $60cf
	ld_obj_pals de, 1, 2 ; $60d2
	call LoadPaletteShadow ; $60d5
	ld hl, MatchStoryGfxPalettes ; $60d8
	ld_bg_pals de, 0, 2 ; $60db
	call LoadPaletteShadow ; $60de
	ld hl, MatchGfxTilesB_28 ; $60e1
	ld de, wDecompBuffer ; $60e4
	call DecompressData ; $60e7
	ld hl, wDecompBuffer ; $60ea
	ld de, vTiles2 ; $60ed
	ld c, 32 ; $60f0 -- 32 of MatchGfxTilesB_28's 256 tiles
	call QueueVRAMCopy ; $60f2
	push af ; $60f5
	ldh a, [rLCDC] ; $60f6
	bit B_LCDC_ENABLE, a ; $60f8
	jr z, .queuedBlock0 ; $60fa
	call AdvanceFrame ; $60fc
.queuedBlock0:
	pop af ; $60ff
	ld hl, wDecompBuffer tile 32 ; $6100
	ld de, vTiles2 tile $20 ; $6103
	ld c, 32 ; $6106 -- 32 of MatchGfxTilesB_28's 256 tiles from tile 32
	call QueueVRAMCopy ; $6108
	push af ; $610b
	ldh a, [rLCDC] ; $610c
	bit B_LCDC_ENABLE, a ; $610e
	jr z, .queuedBlock1 ; $6110
	call AdvanceFrame ; $6112
.queuedBlock1:
	pop af ; $6115
	ld hl, wDecompBuffer tile 64 ; $6116
	ld de, vTiles2 tile $40 ; $6119
	ld c, 32 ; $611c
	call QueueVRAMCopy ; $611e
	push af ; $6121
	ldh a, [rLCDC] ; $6122
	bit B_LCDC_ENABLE, a ; $6124
	jr z, .queuedBlock2 ; $6126
	call AdvanceFrame ; $6128
.queuedBlock2:
	pop af ; $612b
	ld hl, wDecompBuffer tile 96 ; $612c
	ld de, vTiles2 tile $60 ; $612f
	ld c, 32 ; $6132
	call QueueVRAMCopy ; $6134
	push af ; $6137
	ldh a, [rLCDC] ; $6138
	bit B_LCDC_ENABLE, a ; $613a
	jr z, .queuedBlock3 ; $613c
	call AdvanceFrame ; $613e
.queuedBlock3:
	pop af ; $6141
	ld hl, wTextTileBuffer ; $6142
	ld de, vTiles1 ; $6145
	ld c, $20 ; $6148
	ld hl, wTextTileBuffer tile 32 ; $614a
	ld de, vTiles1 tile $20 ; $614d
	ld c, $20 ; $6150
	ld hl, wTextTileBuffer tile 64 ; $6152
	ld de, vTiles1 tile $40 ; $6155
	ld c, $20 ; $6158
	ld hl, wTextTileBuffer tile 96 ; $615a
	ld de, vTiles1 tile $60 ; $615d
	ld c, 32 ; $6160
	call QueueVRAMCopy ; $6162
	push af ; $6165
	ldh a, [rLCDC] ; $6166
	bit B_LCDC_ENABLE, a ; $6168
	jr z, .queuedTextTiles ; $616a
	call AdvanceFrame ; $616c
.queuedTextTiles:
	pop af ; $616f
	ret ; $6170
Padding_28_1:
	; $6171, 15 bytes (fill)
	ds 15, $00
MatchGfxTilesB_28:
	INCBIN "data/engine/match/lz_MatchGfxTilesB_28.bin" ; $6180, 2964 bytes
Unused_28_MatchGfxPalette:
	INCLUDE "data/engine/match/Unused_28_MatchGfxPalette.asm" ; $6d14, 8 bytes (palettes)
MatchGfxPalettesC_28:
	INCLUDE "data/engine/match/MatchGfxPalettesC_28.asm" ; $6d1c, 56 bytes (palettes)
MatchStoryGfxPalettes:
	INCLUDE "data/engine/match/MatchStoryGfxPalettes.asm" ; $6d54, 16 bytes (palettes)
	; $6d64, 4764 bytes fill to bank end (linker-padded)

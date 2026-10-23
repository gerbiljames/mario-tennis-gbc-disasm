	farptr LoadMatchGraphics ; $4000
	farptr LoadMatchVariantGraphics ; $4002
	farptr LoadSpecialHitEffectTiles ; $4004
	farptr LoadBallTouchCharEffectTiles ; $4006
	farptr LoadLandingMarkerTiles ; $4008
	farptr LoadStoryPauseMenuGfx ; $400a
	farptr LoadShootingStarFrameTiles ; $400c
	farptr LoadTreasureBoxFrameTiles ; $400e
	farptr LoadBooFrameTiles ; $4010
Padding_28_0:
	; $4012, 14 bytes (fill)
	ds 14, $00
	ds ALIGN[4]
BallObjTiles:
	INCBIN "data/engine/match/BallObjTiles.bin" ; $4020, 832 bytes
	ds ALIGN[4]
SpecialHitEffectTiles_28:
	INCBIN "data/engine/match/SpecialHitEffectTiles_28.bin" ; $4360, 256 bytes
	ds ALIGN[4]
BallTouchCharEffectTiles_28:
	INCBIN "data/engine/match/BallTouchCharEffectTiles_28.bin" ; $4460, 256 bytes
	ds ALIGN[4]
LandingMarkerTiles_28:
	INCBIN "data/engine/match/LandingMarkerTiles_28.bin" ; $4560, 128 bytes
MatchMenuIconGfx:
	INCBIN "data/engine/match/lz_MatchMenuIconGfx.bin" ; $45e0, 1472 bytes
MatchObjPalettes_28:
	INCLUDE "data/engine/match/MatchObjPalettes_28.asm" ; $4ba0, 64 bytes (palettes)
MatchBGPalettes:
	INCLUDE "data/engine/match/MatchBGPalettes.asm" ; $4be0, 16 bytes (palettes)
	ds ALIGN[4]
MinigameObjTiles_28:
	INCBIN "data/engine/match/MinigameObjTiles_28.bin" ; $4bf0, 320 bytes
	ds ALIGN[4]
ShotDirectionArrowObjTiles:
	INCBIN "data/engine/match/ShotDirectionArrowObjTiles.bin" ; $4d30, 256 bytes
	ds ALIGN[4]
FruitObjTiles:
	INCBIN "data/engine/match/FruitObjTiles.bin" ; $4e30, 768 bytes
	ds ALIGN[4]
BananaBunchObjTiles:
	INCBIN "data/engine/match/BananaBunchObjTiles.bin" ; $5130, 256 bytes
	ds ALIGN[4]
ShootingStarObjTiles:
	INCBIN "data/engine/match/ShootingStarObjTiles.bin" ; $5230, 576 bytes
	ds ALIGN[4]
BonusStarObjTiles:
	INCBIN "data/engine/match/BonusStarObjTiles.bin" ; $5470, 32 bytes
	ds ALIGN[4]
MedallionObjTiles:
	INCBIN "data/engine/match/MedallionObjTiles.bin" ; $5490, 256 bytes
	ds ALIGN[4]
MinigameScoreAndTargetTiles_28:
	INCBIN "data/engine/match/MinigameScoreAndTargetTiles_28.bin" ; $5590, 2208 bytes
ShotDirectionArrowBluePalette:
	INCLUDE "data/engine/match/ShotDirectionArrowBluePalette.asm" ; $5e30, 8 bytes (palettes)
ShotDirectionArrowPalettes:
	INCLUDE "data/engine/match/ShotDirectionArrowPalettes.asm" ; $5e38, 24 bytes (palettes)
FruitPalettes:
	INCLUDE "data/engine/match/FruitPalettes.asm" ; $5e50, 24 bytes (palettes)
ShootingStarPalettes:
	INCLUDE "data/engine/match/ShootingStarPalettes.asm" ; $5e68, 16 bytes (palettes)
MedallionMatchPalettes:
	INCLUDE "data/engine/match/MedallionMatchPalettes.asm" ; $5e78, 8 bytes (palettes)
TreasureBoxPalettes0:
	INCLUDE "data/engine/match/TreasureBoxPalettes0.asm" ; $5e80, 24 bytes (palettes)
TreasureBoxChestPalette:
	INCLUDE "data/engine/match/TreasureBoxChestPalette.asm" ; $5e98, 8 bytes (palettes)
BooBlastPalettes:
	INCLUDE "data/engine/match/BooBlastPalettes.asm" ; $5ea0, 16 bytes (palettes)
LoadMatchGraphics:
	wram_bank WRAM_STAGING ; $5eb0
	ld hl, MatchObjPalettes_28 ; $5eb6
	ld_obj_pals de, 0, 3 ; $5eb9
	call LoadPaletteShadow ; $5ebc
	ld hl, MatchBGPalettes ; $5ebf
	ld_bg_pals de, 0, 2 ; $5ec2
	call LoadPaletteShadow ; $5ec5
	ld hl, BallObjTiles ; $5ec8
	ld de, vTiles0 tile $40 + VRAM_BANK1 ; $5ecb
	ld c, (SpecialHitEffectTiles_28 - BallObjTiles) / 16 + 12 ; $5ece
	call QueueVRAMCopy ; $5ed0
	ld hl, MatchMenuIconGfx ; $5ed3
	ld de, wDecompBuffer ; $5ed6
	call DecompressData ; $5ed9
	ld hl, wDecompBuffer ; $5edc
	ld de, vTiles2 ; $5edf
	ld c, 128 ; $5ee2 -- 128 of MatchMenuIconGfx's 256 tiles
	call QueueVRAMCopy ; $5ee4
	ld hl, wDecompBufferHigh ; $5ee7
	ld de, vTiles1 ; $5eea
	ld c, wDecompBufferHigh_SIZE / 16 ; $5eed
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
	dw LoadMatchVariantGraphics.tennisMachine ; $5f04 jumptable
	dw LoadMatchVariantGraphics.tennisMachine ; $5f06 jumptable
	dw LoadMatchVariantGraphics.tennisMachine ; $5f08 jumptable
	dw LoadMatchVariantGraphics.tennisMachine ; $5f0a jumptable
	dw LoadMatchVariantGraphics.shotDirectionArrows ; $5f0c jumptable
	dw LoadMatchVariantGraphics.shotDirectionArrows ; $5f0e jumptable
	dw LoadMatchVariantGraphics.shotDirectionArrows ; $5f10 jumptable
	dw LoadMatchVariantGraphics.shotDirectionArrows ; $5f12 jumptable
	dw LoadMatchVariantGraphics.tennisMachine ; $5f14 jumptable
	dw LoadMatchVariantGraphics.shotDirectionArrows ; $5f16 jumptable
	dw LoadMatchVariantGraphics.booBlast ; $5f18 jumptable
	dw LoadMatchVariantGraphics.shootingStar ; $5f1a jumptable
	dw LoadMatchVariantGraphics.shotDirectionArrows ; $5f1c jumptable
	dw LoadMatchVariantGraphics.targetShot ; $5f1e jumptable
	dw LoadMatchVariantGraphics.fruitFantasy ; $5f20 jumptable
	dw LoadMatchVariantGraphics.bananaBunch ; $5f22 jumptable
	dw LoadMatchVariantGraphics.treasureBox ; $5f24 jumptable
	dw LoadMatchVariantGraphics.medallionMatch ; $5f26 jumptable
	dw LoadMatchVariantGraphics.loadObjTiles ; $5f28 jumptable
.loadObjTiles:
	ld hl, MinigameObjTiles_28 ; $5f2a
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $5f2d
	ld c, (ShotDirectionArrowObjTiles - MinigameObjTiles_28) / 16 + 12 ; $5f30
	call QueueVRAMCopy ; $5f32
	ret ; $5f35
.tennisMachine:
	call LoadMinigameScoreDigitTiles ; $5f36
	ret ; $5f39
.shotDirectionArrows:
	ld hl, ShotDirectionArrowBluePalette ; $5f3a
	ld_obj_pals de, 3, 1 ; $5f3d
	call LoadPaletteShadow ; $5f40
	ld hl, ShotDirectionArrowPalettes ; $5f43
	ld_obj_pals de, 5, 3 ; $5f46
	call LoadPaletteShadow ; $5f49
	ld hl, ShotDirectionArrowObjTiles ; $5f4c
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $5f4f
	ld c, (FruitObjTiles - ShotDirectionArrowObjTiles) / 16 ; $5f52
	call QueueVRAMCopy ; $5f54
	call LoadMinigameScoreDigitTiles ; $5f57
	ret ; $5f5a
.targetShot:
	ld hl, MinigameObjTiles_28 ; $5f5b
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $5f5e
	ld c, 8 ; $5f61 -- 8 of MinigameObjTiles_28's 20 tiles
	call QueueVRAMCopy ; $5f63
	call LoadMinigameScoreDigitTiles ; $5f66
	ret ; $5f69
.booBlast:
	ld hl, BooBlastPalettes ; $5f6a
	ld_obj_pals de, 6, 2 ; $5f6d
	call LoadPaletteShadow ; $5f70
	ld hl, BonusStarObjTiles ; $5f73
	ld de, vTiles0 tile $3c + VRAM_BANK1 ; $5f76
	ld c, (MedallionObjTiles - BonusStarObjTiles) / 16 ; $5f79
	call QueueVRAMCopy ; $5f7b
	call LoadMinigameScoreDigitTiles ; $5f7e
	ret ; $5f81
.shootingStar:
	ld hl, ShootingStarPalettes ; $5f82
	ld_obj_pals de, 6, 2 ; $5f85
	call LoadPaletteShadow ; $5f88
	ld hl, BonusStarObjTiles ; $5f8b
	ld de, vTiles0 tile $3c + VRAM_BANK1 ; $5f8e
	ld c, (MedallionObjTiles - BonusStarObjTiles) / 16 ; $5f91
	call QueueVRAMCopy ; $5f93
	call LoadMinigameScoreDigitTiles ; $5f96
	ret ; $5f99
.medallionMatch:
	ld hl, MedallionMatchPalettes ; $5f9a
	ld_obj_pals de, 7, 1 ; $5f9d
	call LoadPaletteShadow ; $5fa0
	ld hl, MedallionObjTiles ; $5fa3
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $5fa6
	ld c, (MinigameScoreAndTargetTiles_28 - MedallionObjTiles) / 16 ; $5fa9
	call QueueVRAMCopy ; $5fab
	ld hl, BonusStarObjTiles ; $5fae
	ld de, vTiles0 tile $3c + VRAM_BANK1 ; $5fb1
	ld c, (MedallionObjTiles - BonusStarObjTiles) / 16 ; $5fb4
	call QueueVRAMCopy ; $5fb6
	call LoadMinigameScoreDigitTiles ; $5fb9
	ret ; $5fbc
.treasureBox:
	ld hl, MinigameObjTiles_28 ; $5fbd
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $5fc0
	ld c, 8 ; $5fc3 -- 8 of MinigameObjTiles_28's 20 tiles
	call QueueVRAMCopy ; $5fc5
	ld hl, TreasureBoxPalettes0 ; $5fc8
	ld_obj_pals de, 6, 1 ; $5fcb
	call LoadPaletteShadow ; $5fce
	ld hl, TreasureBoxChestPalette ; $5fd1
	ld_obj_pals de, 7, 1 ; $5fd4
	call LoadPaletteShadow ; $5fd7
	ld hl, BonusStarObjTiles ; $5fda
	ld de, vTiles0 tile $3c + VRAM_BANK1 ; $5fdd
	ld c, (MedallionObjTiles - BonusStarObjTiles) / 16 ; $5fe0
	call QueueVRAMCopy ; $5fe2
	call LoadMinigameScoreDigitTiles ; $5fe5
	ret ; $5fe8
.bananaBunch:
	ld hl, FruitPalettes ; $5fe9
	ld_obj_pals de, 5, 3 ; $5fec
	call LoadPaletteShadow ; $5fef
	ld hl, FruitObjTiles ; $5ff2
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $5ff5
	ld c, 16 ; $5ff8 -- 16 of FruitObjTiles's 48 tiles
	call QueueVRAMCopy ; $5ffa
	ld hl, BananaBunchObjTiles ; $5ffd
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $6000
	ld c, (ShootingStarObjTiles - BananaBunchObjTiles) / 16 ; $6003
	call QueueVRAMCopy ; $6005
	call LoadMinigameScoreDigitTiles ; $6008
	ret ; $600b
.fruitFantasy:
	ld hl, FruitPalettes ; $600c
	ld_obj_pals de, 5, 3 ; $600f
	call LoadPaletteShadow ; $6012
	ld hl, FruitObjTiles ; $6015
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $6018
	ld c, (BananaBunchObjTiles - FruitObjTiles) / 16 ; $601b
	call QueueVRAMCopy ; $601d
	call LoadMinigameScoreDigitTiles ; $6020
	ret ; $6023
LoadMinigameScoreDigitTiles:
	ld hl, MinigameScoreAndTargetTiles_28 ; $6024
	ld de, vTiles0 tile $08 ; $6027
	ld c, 20 ; $602a -- 20 of MinigameScoreAndTargetTiles_28's 138 tiles
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
LoadBallTouchCharEffectTiles:
	rrca ; $6044
	rrca ; $6045
	and $40 ; $6046
	ld_hl_indexed BallTouchCharEffectTiles_28 ; $6048
	ld de, vTiles0 tile $78 + VRAM_BANK1 ; $604f
	ld c, 4 ; $6052
	call QueueVRAMCopy ; $6054
	ret ; $6057
LoadLandingMarkerTiles:
	rrca ; $6058
	rrca ; $6059
	and $40 ; $605a
	ld_hl_indexed LandingMarkerTiles_28 ; $605c
	ld de, vTiles0 tile $7c + VRAM_BANK1 ; $6063
	ld c, 4 ; $6066
	call QueueVRAMCopy ; $6068
	ret ; $606b
LoadShootingStarFrameTiles:
	add a ; $606c
	ld_hl_indexed ShootingStarFrameTilePtrs ; $606d
	ld a, [hl+] ; $6074
	ld h, [hl] ; $6075
	ld l, a ; $6076
	ld de, vTiles0 tile $30 + VRAM_BANK1 ; $6077
	ld c, 12 ; $607a
	call QueueVRAMCopy ; $607c
	ret ; $607f
ShootingStarFrameTilePtrs:
	; $6080, 6 bytes (records:2)
	dw ShootingStarObjTiles tile 0 ; record 0
	dw ShootingStarObjTiles tile 12 ; record 1
	dw ShootingStarObjTiles tile 24 ; record 2
LoadBooFrameTiles:
	add a ; $6086
	ld_hl_indexed BooFrameTilePtrs ; $6087
	ld a, [hl+] ; $608e
	ld h, [hl] ; $608f
	ld l, a ; $6090
	ld de, vTiles0 tile $30 + VRAM_BANK1 ; $6091
	ld c, 12 ; $6094
	call QueueVRAMCopy ; $6096
	ret ; $6099
BooFrameTilePtrs:
	; $609a, 6 bytes (records:2)
	dw MinigameScoreAndTargetTiles_28 tile 102 ; record 0
	dw MinigameScoreAndTargetTiles_28 tile 114 ; record 1
	dw MinigameScoreAndTargetTiles_28 tile 126 ; record 2
LoadTreasureBoxFrameTiles:
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
	ld_hl_indexed TreasureBoxFrameTilePtrs ; $60ad
	ld a, [hl+] ; $60b4
	ld h, [hl] ; $60b5
	ld l, a ; $60b6
	add hl, de ; $60b7
	ld de, vTiles0 tile $30 + VRAM_BANK1 ; $60b8
	ld c, 4 ; $60bb
	call QueueVRAMCopy ; $60bd
	ret ; $60c0
TreasureBoxFrameTilePtrs:
	; $60c1, 8 bytes (records:2)
	dw MinigameScoreAndTargetTiles_28 tile 20 ; record 0
	dw MinigameScoreAndTargetTiles_28 tile 40 ; record 1
	dw MinigameScoreAndTargetTiles_28 tile 60 ; record 2
	dw MinigameScoreAndTargetTiles_28 tile 80 ; record 3
LoadStoryPauseMenuGfx:
	wram_bank WRAM_STAGING ; $60c9
	ld hl, StoryPauseMenuObjPalettes ; $60cf
	ld_obj_pals de, 1, 2 ; $60d2
	call LoadPaletteShadow ; $60d5
	ld hl, StoryPauseMenuBGPalettes ; $60d8
	ld_bg_pals de, 0, 2 ; $60db
	call LoadPaletteShadow ; $60de
	ld hl, StoryPauseMenuGfx ; $60e1
	ld de, wDecompBuffer ; $60e4
	call DecompressData ; $60e7
	ld hl, wDecompBuffer ; $60ea
	ld de, vTiles2 ; $60ed
	ld c, 32 ; $60f0 -- 32 of StoryPauseMenuGfx's 256 tiles
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
	ld c, 32 ; $6106 -- 32 of StoryPauseMenuGfx's 256 tiles from tile 32
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
	ld hl, wDecompBufferHigh ; $6142
	ld de, vTiles1 ; $6145
	ld c, $20 ; $6148
	ld hl, wDecompBufferHigh tile 32 ; $614a
	ld de, vTiles1 tile $20 ; $614d
	ld c, $20 ; $6150
	ld hl, wDecompBufferHigh tile 64 ; $6152
	ld de, vTiles1 tile $40 ; $6155
	ld c, $20 ; $6158
	ld hl, wDecompBufferHigh tile 96 ; $615a
	ld de, vTiles1 tile $60 ; $615d
	ld c, 32 ; $6160
	call QueueVRAMCopy ; $6162
	push af ; $6165
	ldh a, [rLCDC] ; $6166
	bit B_LCDC_ENABLE, a ; $6168
	jr z, .lcdOff ; $616a
	call AdvanceFrame ; $616c
.lcdOff:
	pop af ; $616f
	ret ; $6170
Padding_28_1:
	; $6171, 15 bytes (fill)
	ds 15, $00
StoryPauseMenuGfx:
	INCBIN "data/engine/match/lz_StoryPauseMenuGfx.bin" ; $6180, 2964 bytes
Unused_28_MatchGfxPalette:
	INCLUDE "data/engine/match/Unused_28_MatchGfxPalette.asm" ; $6d14, 8 bytes (palettes)
StoryPauseMenuObjPalettes:
	INCLUDE "data/engine/match/StoryPauseMenuObjPalettes.asm" ; $6d1c, 56 bytes (palettes)
StoryPauseMenuBGPalettes:
	INCLUDE "data/engine/match/StoryPauseMenuBGPalettes.asm" ; $6d54, 16 bytes (palettes)
	; $6d64, 4764 bytes fill to bank end (linker-padded)

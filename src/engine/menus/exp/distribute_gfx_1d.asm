TickLevelUpJingle:
	wram_bank WRAM_SCENE ; $77a7
	ld a, [wExpLevelUpFanfare] ; $77ad
	or a ; $77b0
	ret z ; $77b1
	cp $ff ; $77b2
	jr z, .eqff ; $77b4
	dec a ; $77b6
	ld [wExpLevelUpFanfare], a ; $77b7
	ret nz ; $77ba
	sound BGM_EXP_DISTRIBUTION ; $77bb
	ret ; $77bd
.eqff:
	ld a, $a0 ; $77be
	ld [wExpLevelUpFanfare], a ; $77c0
	sound BGM_NONE ; $77c3
	sound BGM_LEVEL_UP ; $77c5
	ret ; $77c7
ExpPromptWindowFrame_1d:
	INCBIN "data/bank_01d/ExpPromptWindowFrame_1d.bin" ; $77c8, 25 bytes
ExpLevelDownTilemapPatch0:
	INCBIN "data/bank_01d/ExpLevelDownTilemapPatch0.bin" ; $77e1, 21 bytes
ExpLevelDownTilemapPatch1:
	INCBIN "data/bank_01d/ExpLevelDownTilemapPatch1.bin" ; $77f6, 17 bytes
ExpLevelDownTilemapPatch2:
	INCBIN "data/bank_01d/ExpLevelDownTilemapPatch2.bin" ; $7807, 13 bytes
ExpLevelDownTilemapPatch3:
	INCBIN "data/bank_01d/ExpLevelDownTilemapPatch3.bin" ; $7814, 9 bytes
ExpLevelDownTilemapPatch4:
	INCBIN "data/bank_01d/ExpLevelDownTilemapPatch4.bin" ; $781d, 5 bytes
ExpDistributionScreenPatchTilemap:
	INCBIN "data/bank_01d/lz_ExpDistributionScreenPatchTilemap.bin" ; $7822, 47 bytes
	INCLUDE "data/bank_01d/lz_ExpDistributionScreenPatchTilemap.inc" ; DEF ExpDistributionScreenPatchTilemap_SIZE EQU its decoded length, generated from the .bin by make
ExpDistributionScreenPatchAttrmap:
	INCBIN "data/bank_01d/lz_ExpDistributionScreenPatchAttrmap.bin" ; $7851, 37 bytes
	INCLUDE "data/bank_01d/lz_ExpDistributionScreenPatchAttrmap.inc" ; DEF ExpDistributionScreenPatchAttrmap_SIZE EQU its decoded length, generated from the .bin by make
ExpDistributionScreenGfx7:
	INCBIN "data/bank_01d/lz_ExpDistributionScreenGfx7.bin" ; $7876, 25 bytes
	INCLUDE "data/bank_01d/lz_ExpDistributionScreenGfx7.inc" ; DEF ExpDistributionScreenGfx7_SIZE EQU its decoded length, generated from the .bin by make
ExpDistributionScreenPalettes:
	INCBIN "data/bank_01d/ExpDistributionScreenPalettes.bin" ; $788f, 24 bytes
ExpDistributionScreenGfx8:
	INCBIN "data/bank_01d/lz_ExpDistributionScreenGfx8.bin" ; $78a7, 137 bytes
	INCLUDE "data/bank_01d/lz_ExpDistributionScreenGfx8.inc" ; DEF ExpDistributionScreenGfx8_SIZE EQU its decoded length, generated from the .bin by make
DrawExpCharCursorTask_SpriteTemplate:
	; $7930, 25 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite_end
ExpDistributionScreenGfx0:
	INCBIN "data/bank_01d/lz_ExpDistributionScreenGfx0.bin" ; $7949, 49 bytes
	INCLUDE "data/bank_01d/lz_ExpDistributionScreenGfx0.inc" ; DEF ExpDistributionScreenGfx0_SIZE EQU its decoded length, generated from the .bin by make
DrawExpBarFillMarkersTask_SpriteTemplate:
	; $797a, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
ExpDistributionScreenGfx1:
	INCBIN "data/bank_01d/lz_ExpDistributionScreenGfx1.bin" ; $7983, 49 bytes
	INCLUDE "data/bank_01d/lz_ExpDistributionScreenGfx1.inc" ; DEF ExpDistributionScreenGfx1_SIZE EQU its decoded length, generated from the .bin by make
DrawExpBarSweepSpriteTask_SpriteTemplate:
	; $79b4, 13 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite_end
ExpDistributionScreenGfx2:
	INCBIN "data/bank_01d/lz_ExpDistributionScreenGfx2.bin" ; $79c1, 162 bytes
	INCLUDE "data/bank_01d/lz_ExpDistributionScreenGfx2.inc" ; DEF ExpDistributionScreenGfx2_SIZE EQU its decoded length, generated from the .bin by make
ExpDistributionScreenGfx3:
	INCBIN "data/bank_01d/lz_ExpDistributionScreenGfx3.bin" ; $7a63, 246 bytes
	INCLUDE "data/bank_01d/lz_ExpDistributionScreenGfx3.inc" ; DEF ExpDistributionScreenGfx3_SIZE EQU its decoded length, generated from the .bin by make
DrawExpToNextLevelTask_SpriteTemplate0:
	; $7b59, 49 bytes (sprite_template)
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
	oam_sprite_end
ExpDistributionScreenGfx4:
	INCBIN "data/bank_01d/lz_ExpDistributionScreenGfx4.bin" ; $7b8a, 243 bytes
	INCLUDE "data/bank_01d/lz_ExpDistributionScreenGfx4.inc" ; DEF ExpDistributionScreenGfx4_SIZE EQU its decoded length, generated from the .bin by make
DrawExpToNextLevelTask_SpriteTemplate1:
	; $7c7d, 49 bytes (sprite_template)
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
	oam_sprite_end
ClearPendingExpAwards:
	push af ; $7cae
	push bc ; $7caf
	push de ; $7cb0
	push hl ; $7cb1
	wram_bank WRAM_SCENE ; $7cb2
	ld hl, wPendingExpAwardAmounts ; $7cb8
	ld bc, $000f ; $7cbb
	call ClearBytes ; $7cbe
	pop hl ; $7cc1
	pop de ; $7cc2
	pop bc ; $7cc3
	pop af ; $7cc4
	ret ; $7cc5
SetPendingExpAward:
	wram_bank WRAM_SCENE ; $7cc6
	ld a, b ; $7ccc
	rlca ; $7ccd
	ld_hl_indexed PendingExpAwardSetters_1d ; $7cce
	ld a, [hl+] ; $7cd5
	ld h, [hl] ; $7cd6
	ld l, a ; $7cd7
	jp hl ; $7cd8
PendingExpAwardSetters_1d:
	; $7cd9, 10 bytes (records:2)
	dw SetPendingExpAward_N64 ; record 0
	dw SetPendingExpAward_Exhibition ; record 1
	dw SetPendingExpAward_Linked ; record 2
	dw SetPendingExpAward_Match ; record 3
	dw SetPendingExpAward_Trophy ; record 4
SetPendingExpAward_N64:
	ld a, c ; $7ce3
	ld [wPendingExpAwardVariants], a ; $7ce4
	ld hl, wPendingExpAwardAmounts ; $7ce7
	ld a, e ; $7cea
	ld [hl+], a ; $7ceb
	ld [hl], d ; $7cec
	ret ; $7ced
SetPendingExpAward_Exhibition:
	ld a, c ; $7cee
	ld [wPendingExpAwardVariants + 1], a ; $7cef
	ld hl, wPendingExpAwardAmounts + 2 ; $7cf2
	ld a, e ; $7cf5
	ld [hl+], a ; $7cf6
	ld [hl], d ; $7cf7
	ret ; $7cf8
SetPendingExpAward_Linked:
	ld a, c ; $7cf9
	ld [wPendingExpAwardVariants + 2], a ; $7cfa
	ld hl, wPendingExpAwardAmounts + 4 ; $7cfd
	ld a, e ; $7d00
	ld [hl+], a ; $7d01
	ld [hl], d ; $7d02
	ret ; $7d03
SetPendingExpAward_Match:
	ld a, c ; $7d04
	ld [wPendingExpAwardVariants + 3], a ; $7d05
	ld hl, wPendingExpAwardAmounts + 6 ; $7d08
	ld a, e ; $7d0b
	ld [hl+], a ; $7d0c
	ld [hl], d ; $7d0d
	ret ; $7d0e
SetPendingExpAward_Trophy:
	ld a, c ; $7d0f
	ld [wPendingExpAwardVariants + 4], a ; $7d10
	ld hl, wPendingExpAwardAmounts + 8 ; $7d13
	ld a, e ; $7d16
	ld [hl+], a ; $7d17
	ld [hl], d ; $7d18
	ret ; $7d19
	; $7d1a, 742 bytes fill to bank end (linker-padded)

Unused_1a_StubNop_1a_0:
	ret ; $4779
Unused_1a_ExpScreenDrawTask:
	push af ; $477a
	push bc ; $477b
	push de ; $477c
	push hl ; $477d
	push_wram_bank WRAM_SCENE ; $477e
	ld a, [wExpScreenFlags] ; $4787
	or a ; $478a
	jr nz, .checkStoryModeMainCharacterOverworldSprite ; $478b
	ld de, vTiles0 + VRAM_BANK1 ; $478d
.checkStoryModeMainCharacterOverworldSprite:
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4790
	rlca ; $4793
	ld_hl_indexed ExpScreenDrawTaskTable ; $4794
	ld a, [hl+] ; $479b
	ld d, [hl] ; $479c
	ld e, a ; $479d
	ld bc, $0e00 ; $479e
	ld hl, ExpScreenDrawTask_SpriteTemplate ; $47a1
	lb bc, $09, $c0 ; $47a4 attr, tile
	ld_xy de, $70, $58 ; $47a7
	call QueueSpriteTemplate ; $47aa
	ld a, [wExpScreenFlags] ; $47ad
	and $80 ; $47b0
	jr z, .restore ; $47b2
	wram_bank WRAM_COURT_PLANES ; $47b4
	ld a, $01 ; $47ba
	ld hl, wCharDataPageSlot1 + 1 * TILEMAP_WIDTH ; $47bc
	ld b, $40 ; $47bf
.loop:
	ld [hl+], a ; $47c1
	dec b ; $47c2
	jr nz, .loop ; $47c3
	ld hl, wCharDataPageSlot1 + 1 * TILEMAP_WIDTH ; $47c5
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH + VRAM_BANK1 ; $47c8
	ld c, $04 ; $47cb
	call QueueVRAMCopy ; $47cd
	wram_bank WRAM_SCREEN ; $47d0
	ld a, $20 ; $47d6
	ld hl, wScreenScratch ; $47d8
	ld b, $40 ; $47db
.loopB:
	ld [hl+], a ; $47dd
	dec b ; $47de
	jr nz, .loopB ; $47df
	ld a, $03 ; $47e1
	call Unused_1a_DrawExpScreenCaption ; $47e3
	ld hl, wScreenScratch ; $47e6
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $47e9
	ld c, $04 ; $47ec
	call QueueVRAMCopy ; $47ee
	wram_bank WRAM_SCENE ; $47f1
	ld a, [wExpScreenFlags] ; $47f7
	and $7f ; $47fa
	ld [wExpScreenFlags], a ; $47fc
.restore:
	pop_wram_bank ; $47ff
	pop hl ; $4804
	pop de ; $4805
	pop bc ; $4806
	pop af ; $4807
	ret ; $4808
ExpScreenDrawTaskTable:
	; $4809, 55 bytes (bytes:16)
	db $2c, $7b, $2e, $7b, $2d, $7b, $2e, $79, $2a, $7b, $2f, $7a, $30, $7b, $2e, $7a ; 0x00
	db $2c, $7b, $30, $7b, $2f, $7b, $2a, $7b, $30, $7a, $2c, $7c, $2a, $7c, $2a, $7b ; 0x10
	db $2c, $7b, $2c, $7b, $2c, $7b, $2c, $7b, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x20
	db $00, $00, $00, $00, $00, $00, $00 ; 0x30
ExpScreenDrawTask_SpriteTemplate:
	; $4840, 17 bytes (sprite_template)
	oam_sprite $00, $00, $00, $00
	oam_sprite $00, $08, $02, $00
	oam_sprite $10, $00, $04, $00
	oam_sprite $10, $08, $06, $00
	oam_sprite_end
	db $00 ; $4851
Unused_1a_LoadExpScreenGfx:
	wram_bank WRAM_STAGING ; $4852
	push hl ; $4858
	ld hl, ExpScreenGfx0 ; $4859
	ld de, wDecompBuffer ; $485c
	call DecompressData ; $485f
	ld hl, wDecompBuffer ; $4862
	ld de, vTiles2 + VRAM_BANK1 ; $4865
	ld c, $80 ; $4868 -- 128 of ExpScreenGfx0's 192 tiles
	call QueueVRAMCopy ; $486a
	ld hl, wTextTileBuffer ; $486d
	ld de, vTiles1 + VRAM_BANK1 ; $4870
	ld c, $50 ; $4873
	call QueueVRAMCopy ; $4875
	ld hl, ExpScreenGfxPalettes0 ; $4878
	lb de, $00, $08 ; $487b palette index, count
	call LoadPalettesMasterOnly ; $487e
	wram_bank WRAM_STAGING ; $4881
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $4887
	ld d, $0e ; $488a
	farcall LoadIndexedPalette_18 ; $488c
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $488f
	ld b, $00 ; $4892
	wram_bank WRAM_STAGING ; $4894
	ld hl, ExpScreenGfx6 ; $489a
	ld de, wDecompBuffer ; $489d
	call DecompressData ; $48a0
	ld hl, wDecompBuffer ; $48a3
	ld de, vTiles1 + $40 * TILE_SIZE + VRAM_BANK1 ; $48a6
	ld c, ExpScreenGfx6_SIZE / 16 ; $48a9
	call QueueVRAMCopy ; $48ab
	ld hl, ExpScreenGfx7 ; $48ae
	ld de, wDecompBuffer ; $48b1
	call DecompressData ; $48b4
	ld hl, wDecompBuffer ; $48b7
	ld de, vTiles1 + $44 * TILE_SIZE + VRAM_BANK1 ; $48ba
	ld c, ExpScreenGfx7_SIZE / 16 ; $48bd
	call QueueVRAMCopy ; $48bf
	ld hl, ExpScreenGfxPalettes2 ; $48c2
	lb de, $09, $01 ; $48c5 palette index, count
	call LoadPalettesMasterOnly ; $48c8
	pop hl ; $48cb
	ld a, h ; $48cc
	cp $01 ; $48cd
	jr z, .processVRAMCopyQueues ; $48cf
	ld hl, ExpScreenGfx5 ; $48d1
	ld de, wDecompBuffer ; $48d4
	call DecompressData ; $48d7
	ld hl, wDecompBuffer ; $48da
	ld de, vTiles1 + $48 * TILE_SIZE + VRAM_BANK1 ; $48dd
	ld c, ExpScreenGfx5_SIZE / 16 ; $48e0
	call QueueVRAMCopy ; $48e2
	ld hl, ExpScreenGfxPalettes1 ; $48e5
	lb de, $0a, $01 ; $48e8 palette index, count
	call LoadPalettesMasterOnly ; $48eb
	jr .copyMemoryFast ; $48ee
.processVRAMCopyQueues:
	call ProcessVRAMCopyQueues ; $48f0
	ld hl, ExpScreenGfxPalettes3 ; $48f3
	lb de, $0f, $01 ; $48f6 palette index, count
	call LoadPalettesMasterOnly ; $48f9
	wram_bank WRAM_STAGING ; $48fc
	ld hl, ExpScreenGfx8 ; $4902
	ld de, wTextTileBuffer + 96 * TILE_SIZE ; $4905
	call DecompressData ; $4908
	ld hl, wTextTileBuffer + 96 * TILE_SIZE ; $490b
	ld de, vTiles1 + $4a * TILE_SIZE + VRAM_BANK1 ; $490e
	ld c, $14 ; $4911
	call QueueVRAMCopy ; $4913
	wram_bank WRAM_STAGING ; $4916
	ld hl, ExpScreenGfx2 ; $491c
	ld de, wDecompBuffer ; $491f
	ld c, (ExpScreenGfx3 - ExpScreenGfx2) / 16 ; $4922
	call CopyMemoryFast ; $4924
	ld hl, ExpScreenGfx1 ; $4927
	ld de, wDecompBuffer + 64 * TILE_SIZE ; $492a
	ld c, (ExpScreenGfx2 - ExpScreenGfx1) / 16 ; $492d
	call CopyMemoryFast ; $492f
	ret ; $4932
.copyMemoryFast:
	wram_bank WRAM_STAGING ; $4933
	ld hl, ExpScreenGfx4 ; $4939
	ld de, wDecompBuffer ; $493c
	ld c, (ExpScreenGfxPalettes0 - ExpScreenGfx4) / 16 ; $493f
	call CopyMemoryFast ; $4941
	ld hl, ExpScreenGfx3 ; $4944
	ld de, wDecompBuffer + 64 * TILE_SIZE ; $4947
	ld c, (ExpScreenGfx4 - ExpScreenGfx3) / 16 ; $494a
	call CopyMemoryFast ; $494c
	ret ; $494f
ExpScreenMessageBoxTilemap:
	; $4950, 200 bytes (records:2)
	dw $0b00 ; record 0
	dw $0b01 ; record 1
	dw $0b01 ; record 2
	dw $0b01 ; record 3
	dw $0b01 ; record 4
	dw $0b01 ; record 5
	dw $0b01 ; record 6
	dw $0b01 ; record 7
	dw $0b01 ; record 8
	dw $0b01 ; record 9
	dw $0b01 ; record 10
	dw $0b01 ; record 11
	dw $0b01 ; record 12
	dw $0b01 ; record 13
	dw $0b01 ; record 14
	dw $0b01 ; record 15
	dw $0b01 ; record 16
	dw $0b01 ; record 17
	dw $0b01 ; record 18
	dw $0b02 ; record 19
	dw $0b10 ; record 20
	dw $0120 ; record 21
	dw $0120 ; record 22
	dw $0120 ; record 23
	dw $0120 ; record 24
	dw $0120 ; record 25
	dw $0120 ; record 26
	dw $0120 ; record 27
	dw $0120 ; record 28
	dw $0120 ; record 29
	dw $0120 ; record 30
	dw $0120 ; record 31
	dw $0120 ; record 32
	dw $0120 ; record 33
	dw $0120 ; record 34
	dw $0120 ; record 35
	dw $0120 ; record 36
	dw $0120 ; record 37
	dw $0120 ; record 38
	dw $0b12 ; record 39
	dw $0b10 ; record 40
	dw $0120 ; record 41
	dw $0120 ; record 42
	dw $0120 ; record 43
	dw $0120 ; record 44
	dw $0120 ; record 45
	dw $0120 ; record 46
	dw $0120 ; record 47
	dw $0120 ; record 48
	dw $0120 ; record 49
	dw $0120 ; record 50
	dw $0120 ; record 51
	dw $0120 ; record 52
	dw $0120 ; record 53
	dw $0120 ; record 54
	dw $0120 ; record 55
	dw $0120 ; record 56
	dw $0120 ; record 57
	dw $0120 ; record 58
	dw $0b12 ; record 59
	dw $0b10 ; record 60
	dw $0120 ; record 61
	dw $0120 ; record 62
	dw $0120 ; record 63
	dw $0120 ; record 64
	dw $0120 ; record 65
	dw $0120 ; record 66
	dw $0120 ; record 67
	dw $0120 ; record 68
	dw $0120 ; record 69
	dw $0120 ; record 70
	dw $0120 ; record 71
	dw $0120 ; record 72
	dw $0120 ; record 73
	dw $0120 ; record 74
	dw $0120 ; record 75
	dw $0120 ; record 76
	dw $0120 ; record 77
	dw $0120 ; record 78
	dw $0b12 ; record 79
	dw $0b20 ; record 80
	dw $0b21 ; record 81
	dw $0b21 ; record 82
	dw $0b21 ; record 83
	dw $0b21 ; record 84
	dw $0b21 ; record 85
	dw $0b21 ; record 86
	dw $0b21 ; record 87
	dw $0b21 ; record 88
	dw $0b21 ; record 89
	dw $0b21 ; record 90
	dw $0b21 ; record 91
	dw $0b21 ; record 92
	dw $0b21 ; record 93
	dw $0b21 ; record 94
	dw $0b21 ; record 95
	dw $0b21 ; record 96
	dw $0b21 ; record 97
	dw $0b21 ; record 98
	dw $0b22 ; record 99
Unused_1a_DrawExpScreenMessageBox:
	push af ; $4a18
	push bc ; $4a19
	push de ; $4a1a
	push hl ; $4a1b
	ld c, $00 ; $4a1c
	ld hl, ExpScreenMessageBoxTilemap ; $4a1e
.loop:
	ld a, c ; $4a21
	cp $05 ; $4a22
	jr z, .restore ; $4a24
	ld b, $00 ; $4a26
.loopB:
	ld a, b ; $4a28
	cp $14 ; $4a29
	jr z, .eq14 ; $4a2b
	ld a, [hl] ; $4a2d
	ld d, a ; $4a2e
	inc hl ; $4a2f
	ld a, [hl] ; $4a30
	ld e, a ; $4a31
	call Unused_1a_WriteTileBufferCell ; $4a32
	inc hl ; $4a35
	inc b ; $4a36
	jr .loopB ; $4a37
.eq14:
	inc c ; $4a39
	jr .loop ; $4a3a
.restore:
	pop hl ; $4a3c
	pop de ; $4a3d
	pop bc ; $4a3e
	pop af ; $4a3f
	ret ; $4a40
ExpScreenYesNoBoxTilemap:
	; $4a41, 60 bytes (records:2)
	dw $0b00 ; record 0
	dw $0b01 ; record 1
	dw $0b01 ; record 2
	dw $0b01 ; record 3
	dw $0b01 ; record 4
	dw $0b02 ; record 5
	dw $0b10 ; record 6
	dw $0120 ; record 7
	dw $0120 ; record 8
	dw $0120 ; record 9
	dw $0120 ; record 10
	dw $0b12 ; record 11
	dw $0b10 ; record 12
	dw $0120 ; record 13
	dw $0120 ; record 14
	dw $0120 ; record 15
	dw $0120 ; record 16
	dw $0b12 ; record 17
	dw $0b10 ; record 18
	dw $0120 ; record 19
	dw $0120 ; record 20
	dw $0120 ; record 21
	dw $0120 ; record 22
	dw $0b12 ; record 23
	dw $0b20 ; record 24
	dw $0b21 ; record 25
	dw $0b21 ; record 26
	dw $0b21 ; record 27
	dw $0b21 ; record 28
	dw $0b22 ; record 29
Unused_1a_DrawExpScreenYesNoBox:
	push af ; $4a7d
	push bc ; $4a7e
	push de ; $4a7f
	push hl ; $4a80
	ld bc, $0005 ; $4a81
	ld a, $00 ; $4a84
	ld hl, ExpScreenYesNoBoxTilemap ; $4a86
.loop:
	ld a, c ; $4a89
	cp $0a ; $4a8a
	jr z, .eq0a ; $4a8c
	ld b, $00 ; $4a8e
.loopB:
	ld a, b ; $4a90
	cp $06 ; $4a91
	jr z, .eq06 ; $4a93
	ld a, [hl] ; $4a95
	ld d, a ; $4a96
	inc hl ; $4a97
	ld a, [hl] ; $4a98
	ld e, a ; $4a99
	call Unused_1a_WriteTileBufferCell ; $4a9a
	inc hl ; $4a9d
	inc b ; $4a9e
	jr .loopB ; $4a9f
.eq06:
	inc c ; $4aa1
	jr .loop ; $4aa2
.eq0a:
	ld de, wCharDataPagePlane + 6 * TILEMAP_WIDTH + 2 ; $4aa4
	ld hl, Text_31_235 ; $4aa7
	ld c, $20 ; $4aaa
	farcall RenderProportionalTextAt ; $4aac
	pop hl ; $4aaf
	pop de ; $4ab0
	pop bc ; $4ab1
	pop af ; $4ab2
	ret ; $4ab3
; 32 words walked by Unused_1a_FillTileBufferBlockFromTable, one per cell
; of the 4x8 block it fills. The values run $0b38-$0b6f
; consecutively, so the high byte is constant and only the low byte
; varies across the block.
TileBufferBlockCells_1a:
	; $4ab4, 64 bytes (records:2)
	dw $0b38 ; record 0
	dw $0b39 ; record 1
	dw $0b3a ; record 2
	dw $0b3b ; record 3
	dw $0b3c ; record 4
	dw $0b3d ; record 5
	dw $0b3e ; record 6
	dw $0b3f ; record 7
	dw $0b48 ; record 8
	dw $0b49 ; record 9
	dw $0b4a ; record 10
	dw $0b4b ; record 11
	dw $0b4c ; record 12
	dw $0b4d ; record 13
	dw $0b4e ; record 14
	dw $0b4f ; record 15
	dw $0b58 ; record 16
	dw $0b59 ; record 17
	dw $0b5a ; record 18
	dw $0b5b ; record 19
	dw $0b5c ; record 20
	dw $0b5d ; record 21
	dw $0b5e ; record 22
	dw $0b5f ; record 23
	dw $0b68 ; record 24
	dw $0b69 ; record 25
	dw $0b6a ; record 26
	dw $0b6b ; record 27
	dw $0b6c ; record 28
	dw $0b6d ; record 29
	dw $0b6e ; record 30
	dw $0b6f ; record 31
; Fills a 4-row by 8-column block of the tile buffer from
; TileBufferBlockCells_1a, the 32-word table immediately above it:
; c counts rows $0b-$0e, b counts columns $01-$08, and each iteration
; reads one word into de and calls Unused_1a_WriteTileBufferCell. 4 x 8 is
; exactly the table's 32 entries.
;
; Was 43 bytes of INCBIN with no proven caller; seeded as code because
; it decodes as one complete push/pop-balanced routine and its
; `ld hl, $4ab4` lands exactly on that table.
Unused_1a_FillTileBufferBlockFromTable:
	push af ; $4af4
	push bc ; $4af5
	push de ; $4af6
	push hl ; $4af7
	ld c, $0b ; $4af8
	ld a, $00 ; $4afa
	ld hl, TileBufferBlockCells_1a ; $4afc
.rowLoop:
	ld a, c ; $4aff
	cp $0f ; $4b00
	jr z, .done ; $4b02
	ld b, $01 ; $4b04
.colLoop:
	ld a, b ; $4b06
	cp $09 ; $4b07
	jr z, .nextRow ; $4b09
	ld a, [hl] ; $4b0b
	ld d, a ; $4b0c
	inc hl ; $4b0d
	ld a, [hl] ; $4b0e
	ld e, a ; $4b0f
	call Unused_1a_WriteTileBufferCell ; $4b10
	inc hl ; $4b13
	inc b ; $4b14
	jr .colLoop ; $4b15
.nextRow:
	inc c ; $4b17
	jr .rowLoop ; $4b18
.done:
	pop hl ; $4b1a
	pop de ; $4b1b
	pop bc ; $4b1c
	pop af ; $4b1d
	ret ; $4b1e

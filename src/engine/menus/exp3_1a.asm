Padding_1a:
	; $5523, 13 bytes (fill)
	ds 13, $00
ExpScreenGfx0:
	INCBIN "data/bank_01a/lz_ExpScreenGfx0.bin" ; $5530, 1711 bytes
	db $00 ; $5bdf
	ds ALIGN[4]
ExpScreenGfx1:
	INCBIN "data/bank_01a/ExpScreenGfx1.bin" ; $5be0, 576 bytes
	ds ALIGN[4]
ExpScreenGfx2:
	INCBIN "data/bank_01a/ExpScreenGfx2.bin" ; $5e20, 576 bytes
	ds ALIGN[4]
ExpScreenGfx3:
	INCBIN "data/bank_01a/ExpScreenGfx3.bin" ; $6060, 576 bytes
	ds ALIGN[4]
ExpScreenGfx4:
	INCBIN "data/bank_01a/ExpScreenGfx4.bin" ; $62a0, 576 bytes
ExpScreenGfxPalettes0:
	INCBIN "data/bank_01a/ExpScreenGfxPalettes0.bin" ; $64e0, 368 bytes
ExpScreenGfx5:
	INCBIN "data/bank_01a/lz_ExpScreenGfx5.bin" ; $6650, 24 bytes
	INCLUDE "data/bank_01a/lz_ExpScreenGfx5.inc" ; DEF ExpScreenGfx5_SIZE EQU its decoded length, generated from the .bin by make
ExpScreenGfxPalettes1:
	INCBIN "data/bank_01a/ExpScreenGfxPalettes1.bin" ; $6668, 24 bytes
ExpScreenGfx6:
	INCBIN "data/bank_01a/lz_ExpScreenGfx6.bin" ; $6680, 72 bytes
	INCLUDE "data/bank_01a/lz_ExpScreenGfx6.inc" ; DEF ExpScreenGfx6_SIZE EQU its decoded length, generated from the .bin by make
ExpScreenGfx7:
	INCBIN "data/bank_01a/lz_ExpScreenGfx7.bin" ; $66c8, 73 bytes
	INCLUDE "data/bank_01a/lz_ExpScreenGfx7.inc" ; DEF ExpScreenGfx7_SIZE EQU its decoded length, generated from the .bin by make
ExpScreenGfxPalettes2:
	INCBIN "data/bank_01a/ExpScreenGfxPalettes2.bin" ; $6711, 16 bytes
ExpScreenGfxPalettes3:
	INCBIN "data/bank_01a/ExpScreenGfxPalettes3.bin" ; $6721, 8 bytes
ExpScreenGfx8:
	INCBIN "data/bank_01a/lz_ExpScreenGfx8.bin" ; $6729, 171 bytes
Unused_1a_RunDebugCharViewer:
	xor a ; $67d4
	ld [wDebugCharViewerPage], a ; $67d5
	ld [wDebugCharViewerIndex], a ; $67d8
.loop:
	call ClearFrameTasks ; $67db
	call DisableLCDSafely ; $67de
	farcall LoadMenuFontGfx ; $67e1
	xor a ; $67e4
	ldh [hScrollX], a ; $67e5
	ldh [hScrollY], a ; $67e7
	ld [wCameraX], a ; $67e9
	ld [wCameraX + 1], a ; $67ec
	ld [wCameraY], a ; $67ef
	ld [wCameraY + 1], a ; $67f2
	ld a, $90 ; $67f5
	ldh [rWY], a ; $67f7
	call ClearSpriteQueue ; $67f9
	farcall InitActorEngine ; $67fc
	farcall ResetTextWindowState ; $67ff
	call Unused_1a_RunCharViewerSelectGrid ; $6802
	cp $ff ; $6805
	jr z, .eqff ; $6807
	ld c, $40 ; $6809
	call BeginFadeOut ; $680b
	call WaitFadeEnd ; $680e
	call DisableLCDSafely ; $6811
	call Unused_1a_InitCharViewerState ; $6814
	call Unused_1a_LoadCharViewerScreen ; $6817
	call Unused_1a_SetupCharViewerScene ; $681a
	call EnableLCD ; $681d
	ld a, $01 ; $6820
	ld hl, Unused_1a_DrawCharViewerCursorSprite ; $6822
	call RegisterFrameTask ; $6825
	call Unused_1a_ApplyCharViewerPalette ; $6828
	call Unused_1a_RefreshCharViewerSelection ; $682b
	call AdvanceFrame ; $682e
	wram_bank WRAM_SCENE ; $6831
	ld a, [wCharViewerCharId] ; $6837
	ld de, vTiles0 + $70 * TILE_SIZE ; $683a
	farcall LoadOnCourtCharTilesA ; $683d
	call AdvanceFrame ; $6840
	script_fade_in $10 ; $6843
	call WaitFadeEnd ; $6848
	call Unused_1a_RunCharViewerInputLoop ; $684b
	ld hl, Unused_1a_DrawCharViewerCursorSprite ; $684e
	call UnregisterFrameTask ; $6851
.eqff:
	ld c, $10 ; $6854
	call BeginFadeOut ; $6856
	call WaitFadeEnd ; $6859
	call DisableLCDSafely ; $685c
	farcall LoadMenuFontGfx ; $685f
	call EnableLCD ; $6862
	call AdvanceFrame ; $6865
	jp .loop ; $6868
	ret ; $686b
Unused_1a_RunCharViewerSelectGrid:
	wram_bank WRAM_SCENE ; $686c
	xor a ; $6872
	ld hl, Palette_1a_0 ; $6873
	ld_bg_pals de, 0, 8 ; $6876
	call LoadPaletteShadow ; $6879
	ld hl, Palette_1a_0 ; $687c
	ld_obj_pals de, 0, 8 ; $687f
	call LoadPaletteShadow ; $6882
	wram_bank WRAM_STAGING ; $6885
	ld hl, CharViewerScreenGfx0 ; $688b
	ld de, wDecompBuffer ; $688e
	call DecompressData ; $6891
	ld hl, wDecompBuffer ; $6894
	ld de, vTiles2 + VRAM_BANK1 ; $6897
	ld c, $80 ; $689a -- 128 of CharViewerScreenGfx0's 256 tiles
	call QueueVRAMCopy ; $689c
	ld hl, wTextTileBuffer ; $689f
	ld de, vTiles1 + VRAM_BANK1 ; $68a2
	ld c, wTextTileBuffer_SIZE / 16 ; $68a5
	call QueueVRAMCopy ; $68a7
	call Unused_1a_LoadCharViewerGridTilemap ; $68aa
	ld a, [wDebugCharViewerPage] ; $68ad
	call Unused_1a_DrawCharViewerPageNames ; $68b0
	wram_bank WRAM_SCREEN ; $68b3
	ld hl, wShadowTilemap ; $68b9
	ld de, vBGMap0 ; $68bc
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $68bf
	call QueueVRAMCopy ; $68c1
	wram_bank WRAM_COURT_PLANES ; $68c4
	ld hl, wScreenAttrmap ; $68ca
	ld de, vBGMap0 + VRAM_BANK1 ; $68cd
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $68d0
	call QueueVRAMCopy ; $68d2
	call EnableLCD ; $68d5
	ld a, $01 ; $68d8
	ld hl, Unused_1a_DrawCharViewerGridCursor ; $68da
	call RegisterFrameTask ; $68dd
	script_fade_in $10 ; $68e0
	call WaitFadeEnd ; $68e5
.loop:
	wram_bank WRAM_SCENE ; $68e8
	call AdvanceFrame ; $68ee
	ldh a, [hInputPressed] ; $68f1
	bit PADB_UP, a ; $68f3
	jr nz, .checkDebugCharViewerIndex ; $68f5
	bit 7, a ; $68f7
	jr nz, .checkDebugCharViewerIndex2 ; $68f9
	bit 5, a ; $68fb
	jr nz, .checkDebugCharViewerIndex3 ; $68fd
	bit 4, a ; $68ff
	jr nz, .checkDebugCharViewerIndex5 ; $6901
	bit 0, a ; $6903
	jp nz, .bit0Set ; $6905
	bit 1, a ; $6908
	jp nz, .bit1Set ; $690a
	jr .loop ; $690d
	ld c, $10 ; $690f
	call BeginFadeOut ; $6911
	call WaitFadeEnd ; $6914
	call DisableLCDSafely ; $6917
	ret ; $691a
.checkDebugCharViewerIndex:
	ld a, [wDebugCharViewerIndex] ; $691b
	dec a ; $691e
	cp $ff ; $691f
	jr z, .eqff ; $6921
	cp $07 ; $6923
	jr nz, .store ; $6925
	ld a, $0f ; $6927
	jr .store ; $6929
.eqff:
	ld a, $07 ; $692b
.store:
	ld [wDebugCharViewerIndex], a ; $692d
	sound SFX_MENU_MOVE ; $6930
	jr .loop ; $6932
.checkDebugCharViewerIndex2:
	ld a, [wDebugCharViewerIndex] ; $6934
	inc a ; $6937
	cp $08 ; $6938
	jr z, .eq08 ; $693a
	cp $10 ; $693c
	jr nz, .store2 ; $693e
	ld a, $08 ; $6940
	jr .store2 ; $6942
.eq08:
	xor a ; $6944
.store2:
	ld [wDebugCharViewerIndex], a ; $6945
	sound SFX_MENU_MOVE ; $6948
	jr .loop ; $694a
.checkDebugCharViewerIndex3:
	ld a, [wDebugCharViewerIndex] ; $694c
	sub $08 ; $694f
	jr nc, .store3 ; $6951
	add $10 ; $6953
	ld [wDebugCharViewerIndex], a ; $6955
	ld a, [wDebugCharViewerPage] ; $6958
	or a ; $695b
	jr z, .checkDebugCharViewerIndex4 ; $695c
	dec a ; $695e
	ld [wDebugCharViewerPage], a ; $695f
	sound SFX_MENU_MOVE ; $6962
	jr .loadCharViewerGridTilemap ; $6964
.store3:
	ld [wDebugCharViewerIndex], a ; $6966
	sound SFX_MENU_MOVE ; $6969
	jp .loop ; $696b
.checkDebugCharViewerIndex4:
	ld a, [wDebugCharViewerIndex] ; $696e
	sub $08 ; $6971
	ld [wDebugCharViewerIndex], a ; $6973
	jp .loop ; $6976
.checkDebugCharViewerIndex5:
	ld a, [wDebugCharViewerIndex] ; $6979
	add $08 ; $697c
	cp $10 ; $697e
	jr c, .store4 ; $6980
	sub $10 ; $6982
	ld [wDebugCharViewerIndex], a ; $6984
	ld a, [wDebugCharViewerPage] ; $6987
	cp $01 ; $698a
	jr z, .checkDebugCharViewerIndex6 ; $698c
	inc a ; $698e
	ld [wDebugCharViewerPage], a ; $698f
	sound SFX_MENU_MOVE ; $6992
	jr .loadCharViewerGridTilemap ; $6994
.store4:
	ld [wDebugCharViewerIndex], a ; $6996
	sound SFX_MENU_MOVE ; $6999
	jp .loop ; $699b
.checkDebugCharViewerIndex6:
	ld a, [wDebugCharViewerIndex] ; $699e
	add $08 ; $69a1
	ld [wDebugCharViewerIndex], a ; $69a3
	jp .loop ; $69a6
.loadCharViewerGridTilemap:
	push af ; $69a9
	call Unused_1a_LoadCharViewerGridTilemap ; $69aa
	pop af ; $69ad
	call Unused_1a_DrawCharViewerPageNames ; $69ae
	wram_bank WRAM_SCREEN ; $69b1
	ld hl, wShadowTilemap + 1 * TILEMAP_WIDTH ; $69b7
	ld de, vBGMap0 + 1 * TILEMAP_WIDTH ; $69ba
	ld c, 16 * TILEMAP_WIDTH / 16 ; $69bd
	call QueueVRAMCopy ; $69bf
	call AdvanceFrame ; $69c2
	jp .loop ; $69c5
.bit0Set:
	ld hl, Unused_1a_DrawCharViewerGridCursor ; $69c8
	call UnregisterFrameTask ; $69cb
	sound SFX_MENU_SELECT ; $69ce
	ld a, [wDebugCharViewerPage] ; $69d0
	rlca ; $69d3
	rlca ; $69d4
	rlca ; $69d5
	rlca ; $69d6
	ld b, a ; $69d7
	ld a, [wDebugCharViewerIndex] ; $69d8
	add b ; $69db
	ld [wCharViewerCharId], a ; $69dc
	ret ; $69df
.bit1Set:
	ld hl, Unused_1a_DrawCharViewerGridCursor ; $69e0
	call UnregisterFrameTask ; $69e3
	sound SFX_MENU_CANCEL ; $69e6
	ld a, $ff ; $69e8
	ret ; $69ea
Unused_1a_LoadCharViewerGridTilemap:
	wram_bank WRAM_STAGING ; $69eb
	ld hl, CharViewerGridTilemap0 ; $69f1
	ld de, wDecompBuffer ; $69f4
	call DecompressData ; $69f7
	ld hl, wDecompBuffer ; $69fa
	ld bc, $0240 ; $69fd
	call Unused_1a_CopyBank1ToBank3Buffer ; $6a00
	wram_bank WRAM_STAGING ; $6a03
	ld hl, CharViewerGridTilemap1 ; $6a09
	ld de, wDecompBuffer ; $6a0c
	call DecompressData ; $6a0f
	ld hl, wDecompBuffer ; $6a12
	ld bc, $0240 ; $6a15
	call Unused_1a_CopyBank1ToBank2Buffer ; $6a18
	wram_bank WRAM_COURT_PLANES ; $6a1b
	ld hl, wScreenAttrmap + 1 * TILEMAP_WIDTH + 1 ; $6a21
	ld c, $10 ; $6a24
.loop:
	push hl ; $6a26
	ld b, $12 ; $6a27
.loopB:
	xor a ; $6a29
	ld [hl+], a ; $6a2a
	dec b ; $6a2b
	jr nz, .loopB ; $6a2c
	pop hl ; $6a2e
	ld a, $20 ; $6a2f
	add l ; $6a31
	ld l, a ; $6a32
	jr nc, .gotPtr ; $6a33
	inc h ; $6a35
.gotPtr:
	dec c ; $6a36
	jr nz, .loop ; $6a37
	ret ; $6a39
Unused_1a_DrawCharViewerPageNames:
	or a ; $6a3a
	jr z, .zero ; $6a3b
	dec a ; $6a3d
	jr z, .countDone ; $6a3e
	dec a ; $6a40
	jr z, .countDone2 ; $6a41
	ret ; $6a43
.zero:
	wram_bank WRAM_SCREEN ; $6a44
	ld hl, Text_30_27 ; $6a4a
	ld de, wShadowTilemap + 2 * TILEMAP_WIDTH + 3 ; $6a4d
	ld c, $08 ; $6a50
	call Unused_1a_RenderTextColumnToBuffer64 ; $6a52
	ld hl, Text_30_35 ; $6a55
	ld de, wShadowTilemap + 2 * TILEMAP_WIDTH + 11 ; $6a58
	ld c, $08 ; $6a5b
	call Unused_1a_RenderTextColumnToBuffer64 ; $6a5d
	ret ; $6a60
.countDone:
	wram_bank WRAM_SCREEN ; $6a61
	ld hl, Text_30_43 ; $6a67
	ld de, wShadowTilemap + 2 * TILEMAP_WIDTH + 3 ; $6a6a
	ld c, $08 ; $6a6d
	call Unused_1a_RenderTextColumnToBuffer64 ; $6a6f
	ld hl, Text_30_51 ; $6a72
	ld de, wShadowTilemap + 2 * TILEMAP_WIDTH + 11 ; $6a75
	ld c, $08 ; $6a78
	call Unused_1a_RenderTextColumnToBuffer64 ; $6a7a
	ret ; $6a7d
.countDone2:
	wram_bank WRAM_SCREEN ; $6a7e
	ld hl, Text_30_59 ; $6a84
	ld de, wShadowTilemap + 2 * TILEMAP_WIDTH + 3 ; $6a87
	ld c, $08 ; $6a8a
	call Unused_1a_RenderTextColumnToBuffer64 ; $6a8c
	ld hl, Text_30_67 ; $6a8f
	ld de, wShadowTilemap + 2 * TILEMAP_WIDTH + 11 ; $6a92
	ld c, $08 ; $6a95
	call Unused_1a_RenderTextColumnToBuffer64 ; $6a97
	ret ; $6a9a
Unused_1a_RenderTextColumnToBuffer64:
	push bc ; $6a9b
	push de ; $6a9c
	push hl ; $6a9d
	ld c, $20 ; $6a9e
	farcall RenderTextToBuffer64 ; $6aa0
	pop hl ; $6aa3
	pop de ; $6aa4
	pop bc ; $6aa5
	dec c ; $6aa6
	ret z ; $6aa7
	inc hl ; $6aa8
	push hl ; $6aa9
	ld hl, $0040 ; $6aaa
	add hl, de ; $6aad
	ld d, h ; $6aae
	ld e, l ; $6aaf
	pop hl ; $6ab0
	jr Unused_1a_RenderTextColumnToBuffer64 ; $6ab1
Unused_1a_DrawCharViewerGridCursor:
	wram_bank WRAM_SCENE ; $6ab3
	ldh a, [hVBlankCounter] ; $6ab9
	and $1c ; $6abb
	jr z, .checkVBlankCounter ; $6abd
	ld a, [wDebugCharViewerPage] ; $6abf
	dec a ; $6ac2
	jr z, .queueSprite ; $6ac3
	dec a ; $6ac5
	jr z, .queueSprite ; $6ac6
	ld b, OAM_BANK1 | 2 ; $6ac8
	ld c, $86 ; $6aca
	ld_xy de, $96, $4a ; $6acc
	call QueueSprite ; $6acf
	jr .checkVBlankCounter ; $6ad2
	ld b, OAM_BANK1 | 2 ; $6ad4
	ld c, $84 ; $6ad6
	ld_xy de, $0a, $4a ; $6ad8
	call QueueSprite ; $6adb
	ld b, OAM_BANK1 | 2 ; $6ade
	ld c, $86 ; $6ae0
	ld_xy de, $96, $4a ; $6ae2
	call QueueSprite ; $6ae5
	jr .checkVBlankCounter ; $6ae8
.queueSprite:
	ld b, OAM_BANK1 | 2 ; $6aea
	ld c, $84 ; $6aec
	ld_xy de, $0a, $4a ; $6aee
	call QueueSprite ; $6af1
.checkVBlankCounter:
	ldh a, [hVBlankCounter] ; $6af4
	and $2a ; $6af6
	ret z ; $6af8
	ld a, [wDebugCharViewerIndex] ; $6af9
	rlca ; $6afc
	ld_hl_indexed DrawCharViewerGridCursorTable ; $6afd
	ld a, [hl+] ; $6b04
	ld d, [hl] ; $6b05
	ld e, a ; $6b06
	sprite_attr_tile OAM_BANK1, $88 ; $6b07
	call QueueSprite ; $6b0b
	ret ; $6b0e
DrawCharViewerGridCursorTable:
	; $6b0f, 32 bytes (bytes:16)
	db $14, $13, $24, $13, $34, $13, $44, $13, $54, $13, $64, $13, $74, $13, $84, $13 ; 0x00
	db $14, $53, $24, $53, $34, $53, $44, $53, $54, $53, $64, $53, $74, $53, $84, $53 ; 0x10
Unused_1a_LoadCharViewerScreen:
	call Unused_1a_LoadCharViewerScreenGfx ; $6b2f
	wram_bank WRAM_SCREEN ; $6b32
	ld hl, wShadowTilemap ; $6b38
	ld de, vBGMap0 ; $6b3b
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $6b3e
	call QueueVRAMCopy ; $6b40
	wram_bank WRAM_COURT_PLANES ; $6b43
	ld hl, wScreenAttrmap ; $6b49
	ld de, vBGMap0 + VRAM_BANK1 ; $6b4c
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $6b4f
	call QueueVRAMCopy ; $6b51
	ret ; $6b54
Unused_1a_LoadCharViewerScreenGfx:
	ld hl, Palette_1a_0 ; $6b55
	ld_bg_pals de, 0, 8 ; $6b58
	call LoadPaletteShadow ; $6b5b
	wram_bank WRAM_STAGING ; $6b5e
	ld hl, CharViewerScreenGfx0 ; $6b64
	ld de, wDecompBuffer ; $6b67
	call DecompressData ; $6b6a
	ld hl, wDecompBuffer ; $6b6d
	ld de, vTiles2 + VRAM_BANK1 ; $6b70
	ld c, $80 ; $6b73 -- 128 of CharViewerScreenGfx0's 256 tiles
	call QueueVRAMCopy ; $6b75
	ld hl, wTextTileBuffer ; $6b78
	ld de, vTiles1 + VRAM_BANK1 ; $6b7b
	ld c, wTextTileBuffer_SIZE / 16 ; $6b7e
	call QueueVRAMCopy ; $6b80
	wram_bank WRAM_STAGING ; $6b83
	ld hl, CharViewerScreenGfx1 ; $6b89
	ld de, wDecompBuffer ; $6b8c
	call DecompressData ; $6b8f
	ld hl, wDecompBuffer ; $6b92
	ld bc, $0240 ; $6b95
	call Unused_1a_CopyBank1ToBank3Buffer ; $6b98
	wram_bank WRAM_STAGING ; $6b9b
	ld hl, CharViewerScreenGfx2 ; $6ba1
	ld de, wDecompBuffer ; $6ba4
	call DecompressData ; $6ba7
	ld hl, wDecompBuffer ; $6baa
	ld bc, $0240 ; $6bad
	call Unused_1a_CopyBank1ToBank2Buffer ; $6bb0
	wram_bank WRAM_COURT_PLANES ; $6bb3
	ld hl, wScreenAttrmap + 15 * TILEMAP_WIDTH + 1 ; $6bb9
	xor a ; $6bbc
	ld [hl+], a ; $6bbd
	ld [hl+], a ; $6bbe
	ld [hl+], a ; $6bbf
	ld [hl+], a ; $6bc0
	ld [hl+], a ; $6bc1
	ld [hl+], a ; $6bc2
	ld [hl+], a ; $6bc3
	ld [hl+], a ; $6bc4
	ld [hl+], a ; $6bc5
	ld [hl+], a ; $6bc6
	ld [hl+], a ; $6bc7
	ld [hl+], a ; $6bc8
	ld [hl+], a ; $6bc9
	ld [hl+], a ; $6bca
	ld [hl+], a ; $6bcb
	ld [hl+], a ; $6bcc
	ld hl, wScreenAttrmap + 16 * TILEMAP_WIDTH + 1 ; $6bcd
	ld [hl+], a ; $6bd0
	ld [hl+], a ; $6bd1
	ld [hl+], a ; $6bd2
	ld [hl+], a ; $6bd3
	ld [hl+], a ; $6bd4
	ld [hl+], a ; $6bd5
	ld [hl+], a ; $6bd6
	ld [hl+], a ; $6bd7
	ld [hl+], a ; $6bd8
	ld [hl+], a ; $6bd9
	ld [hl+], a ; $6bda
	ld [hl+], a ; $6bdb
	ld [hl+], a ; $6bdc
	ld [hl+], a ; $6bdd
	ld [hl+], a ; $6bde
	ld [hl+], a ; $6bdf
	ret ; $6be0

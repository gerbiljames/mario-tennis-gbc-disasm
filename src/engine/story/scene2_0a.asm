CopyScrolledSceneTilemapToVram:
	push af ; $5c29
	push bc ; $5c2a
	push de ; $5c2b
	push hl ; $5c2c
	or a ; $5c2d
	jr z, .fromPlayer ; $5c2e
	ld a, [wCameraX + 1] ; $5c30
	ld h, a ; $5c33
	ld a, [wCameraY + 1] ; $5c34
	ld l, a ; $5c37
	jp .gotCamera ; $5c38
.fromPlayer:
	call UpdateCameraFromPlayer ; $5c3b
	ld h, b ; $5c3e
	ld l, d ; $5c3f
.gotCamera:
	push hl ; $5c40
	ld a, l ; $5c41
	and $1f ; $5c42
	ld l, a ; $5c44
	ld a, h ; $5c45
	and $1f ; $5c46
	ld h, $00 ; $5c48
	add hl, hl ; $5c4a
	add hl, hl ; $5c4b
	add hl, hl ; $5c4c
	add hl, hl ; $5c4d
	add hl, hl ; $5c4e
	add l ; $5c4f
	ld l, a ; $5c50
	ld de, $9800 ; $5c51
	add hl, de ; $5c54
	ld e, l ; $5c55
	ld d, h ; $5c56
	pop hl ; $5c57
	push de ; $5c58
	ld a, h ; $5c59
	ld h, $00 ; $5c5a
	add hl, hl ; $5c5c
	add hl, hl ; $5c5d
	add hl, hl ; $5c5e
	add hl, hl ; $5c5f
	add hl, hl ; $5c60
	add hl, hl ; $5c61
	add l ; $5c62
	ld l, a ; $5c63
	ld de, wMapBuffer64 ; $5c64
	add hl, de ; $5c67
	pop de ; $5c68
	push hl ; $5c69
	push de ; $5c6a
	wram_bank WRAM_COURT_PLANES ; $5c6b
	ld a, $01 ; $5c71
	ldh [rVBK], a ; $5c73
	ld b, $15 ; $5c75
.attrRowLoop:
	ld c, $17 ; $5c77
	push de ; $5c79
	push hl ; $5c7a
.attrCellLoop:
	ld a, [hl+] ; $5c7b
	ld [de], a ; $5c7c
	inc de ; $5c7d
	ld a, l ; $5c7e
	and $3f ; $5c7f
	jr nz, .attrCheckDestWrap ; $5c81
	push de ; $5c83
	ld de, $ffc0 ; $5c84
	add hl, de ; $5c87
	pop de ; $5c88
	jr .attrWrapDest ; $5c89
.attrCheckDestWrap:
	ld a, e ; $5c8b
	and $1f ; $5c8c
	jr nz, .attrNextCell ; $5c8e
.attrWrapDest:
	push hl ; $5c90
	ld hl, $ffe0 ; $5c91
	add hl, de ; $5c94
	ld e, l ; $5c95
	ld d, h ; $5c96
	pop hl ; $5c97
.attrNextCell:
	dec c ; $5c98
	jr nz, .attrCellLoop ; $5c99
	pop hl ; $5c9b
	ld a, $40 ; $5c9c
	add l ; $5c9e
	ld l, a ; $5c9f
	jr nc, .attrRowSrcOk ; $5ca0
	ld a, h ; $5ca2
	inc a ; $5ca3
	and $0f ; $5ca4
	or $d0 ; $5ca6
	ld h, a ; $5ca8
.attrRowSrcOk:
	pop de ; $5ca9
	ld a, $20 ; $5caa
	add e ; $5cac
	ld e, a ; $5cad
	jr nc, .attrNextRow ; $5cae
	ld a, d ; $5cb0
	inc a ; $5cb1
	res 2, a ; $5cb2
	ld d, a ; $5cb4
.attrNextRow:
	dec b ; $5cb5
	jr nz, .attrRowLoop ; $5cb6
	pop de ; $5cb8
	pop hl ; $5cb9
	wram_bank WRAM_SCREEN ; $5cba
	xor a ; $5cc0
	ldh [rVBK], a ; $5cc1
	ld b, $15 ; $5cc3
.tileRowLoop:
	ld c, $17 ; $5cc5
	push de ; $5cc7
	push hl ; $5cc8
.tileCellLoop:
	ld a, [hl+] ; $5cc9
	ld [de], a ; $5cca
	inc de ; $5ccb
	ld a, l ; $5ccc
	and $3f ; $5ccd
	jr nz, .tileCheckDestWrap ; $5ccf
	push de ; $5cd1
	ld de, $ffc0 ; $5cd2
	add hl, de ; $5cd5
	pop de ; $5cd6
	jr .tileWrapDest ; $5cd7
.tileCheckDestWrap:
	ld a, e ; $5cd9
	and $1f ; $5cda
	jr nz, .tileNextCell ; $5cdc
.tileWrapDest:
	push hl ; $5cde
	ld hl, $ffe0 ; $5cdf
	add hl, de ; $5ce2
	ld e, l ; $5ce3
	ld d, h ; $5ce4
	pop hl ; $5ce5
.tileNextCell:
	dec c ; $5ce6
	jr nz, .tileCellLoop ; $5ce7
	pop hl ; $5ce9
	ld a, $40 ; $5cea
	add l ; $5cec
	ld l, a ; $5ced
	jr nc, .tileRowSrcOk ; $5cee
	ld a, h ; $5cf0
	inc a ; $5cf1
	and $0f ; $5cf2
	or $d0 ; $5cf4
	ld h, a ; $5cf6
.tileRowSrcOk:
	pop de ; $5cf7
	ld a, $20 ; $5cf8
	add e ; $5cfa
	ld e, a ; $5cfb
	jr nc, .tileNextRow ; $5cfc
	ld a, d ; $5cfe
	inc a ; $5cff
	res 2, a ; $5d00
	ld d, a ; $5d02
.tileNextRow:
	dec b ; $5d03
	jr nz, .tileRowLoop ; $5d04
	pop hl ; $5d06
	pop de ; $5d07
	pop bc ; $5d08
	pop af ; $5d09
	ret ; $5d0a
GetSceneSlotPtr:
	push af ; $5d0b
	push bc ; $5d0c
	push de ; $5d0d
	ld b, a ; $5d0e
	ld a, [wCurrentScene] ; $5d0f
	ld h, $00 ; $5d12
	ld l, a ; $5d14
	add hl, hl ; $5d15
	add hl, hl ; $5d16
	add hl, hl ; $5d17
	add hl, hl ; $5d18
	ld de, SceneGfxSlotTable ; $5d19
	add hl, de ; $5d1c
	ld e, b ; $5d1d
	sla e ; $5d1e
	ld d, $00 ; $5d20
	add hl, de ; $5d22
	ld a, [hl+] ; $5d23
	ld h, [hl] ; $5d24
	ld l, a ; $5d25
	pop de ; $5d26
	pop bc ; $5d27
	pop af ; $5d28
	ret ; $5d29
Unused_0a_LoadSceneGraphicsDirect:
	push af ; $5d2a
	push bc ; $5d2b
	push de ; $5d2c
	push hl ; $5d2d
	ld h, $00 ; $5d2e
	ld l, a ; $5d30
	add hl, hl ; $5d31
	ld d, h ; $5d32
	ld e, l ; $5d33
	add hl, hl ; $5d34
	add hl, hl ; $5d35
	add hl, hl ; $5d36
	add hl, de ; $5d37
	ld d, h ; $5d38
	ld e, l ; $5d39
	ld hl, SceneGfxSlotTable ; $5d3a
	add hl, de ; $5d3d
	inc hl ; $5d3e
	inc hl ; $5d3f
	ld a, [hl+] ; $5d40
	ld c, a ; $5d41
	ld a, [hl+] ; $5d42
	ld b, a ; $5d43
	push bc ; $5d44
	ld a, [hl+] ; $5d45
	ld c, a ; $5d46
	ld a, [hl+] ; $5d47
	ld b, a ; $5d48
	push bc ; $5d49
	ld a, [hl+] ; $5d4a
	ld c, a ; $5d4b
	ld a, [hl+] ; $5d4c
	ld b, a ; $5d4d
	push bc ; $5d4e
	ld a, [hl+] ; $5d4f
	ld c, a ; $5d50
	ld a, [hl+] ; $5d51
	ld b, a ; $5d52
	push bc ; $5d53
	ld a, [hl+] ; $5d54
	ld c, a ; $5d55
	ld a, [hl+] ; $5d56
	ld b, a ; $5d57
	push bc ; $5d58
	ld a, [hl+] ; $5d59
	ld c, a ; $5d5a
	ld a, [hl+] ; $5d5b
	ld b, a ; $5d5c
	push bc ; $5d5d
	ld a, [hl+] ; $5d5e
	ld c, a ; $5d5f
	ld a, [hl+] ; $5d60
	ld b, a ; $5d61
	push bc ; $5d62
	wram_bank WRAM_STAGING ; $5d63
	ld a, $01 ; $5d69
	ldh [rVBK], a ; $5d6b
	ld a, [hl+] ; $5d6d
	ld h, [hl] ; $5d6e
	ld l, a ; $5d6f
	ld de, wDecompBuffer ; $5d70
	call DecompressDataFromBank ; $5d73
	ld hl, wDecompBuffer ; $5d76
	ld de, vTiles2 ; $5d79
	ld bc, $0080 ; $5d7c
	call StartVRAMDMAFromHL ; $5d7f
	ld hl, wTextTileBuffer ; $5d82
	ld de, vTiles1 ; $5d85
	ld bc, $0080 ; $5d88
	call StartVRAMDMAFromHL ; $5d8b
	wram_bank WRAM_SCENE ; $5d8e
	pop hl ; $5d94
	ld de, wStorySceneUnusedBuffer ; $5d95
	call DecompressDataFromBank ; $5d98
	pop hl ; $5d9b
	pop hl ; $5d9c
	ld de, wBehaviorMap ; $5d9d
	call DecompressDataFromBank ; $5da0
	pop hl ; $5da3
	ld de, wCollisionMap ; $5da4
	call DecompressDataFromBank ; $5da7
	wram_bank WRAM_COURT_PLANES ; $5daa
	pop hl ; $5db0
	ld de, wScreenAttrmap ; $5db1
	call DecompressDataFromBank ; $5db4
	wram_bank WRAM_SCREEN ; $5db7
	pop hl ; $5dbd
	ld de, wShadowTilemap ; $5dbe
	call DecompressDataFromBank ; $5dc1
	pop hl ; $5dc4
	wram_bank WRAM_STAGING ; $5dc5
	ld de, wDecompBuffer ; $5dcb
	ld bc, $0040 ; $5dce
	call CopyDataFromBank ; $5dd1
	ld hl, wDecompBuffer + 8 ; $5dd4
	lb de, $01, $07 ; $5dd7 palette index, count
	call LoadPalettesMasterOnly ; $5dda
	pop hl ; $5ddd
	pop de ; $5dde
	pop bc ; $5ddf
	pop af ; $5de0
	ret ; $5de1
Unused_0a_LoadAndDisplayScene:
	push bc ; $5de2
	push af ; $5de3
	call DisableLCDSafely ; $5de4
	pop af ; $5de7
	call Unused_0a_LoadSceneGraphicsDirect ; $5de8
	ld a, $00 ; $5deb
	call GetSceneSlotPtr ; $5ded
	ld de, wTextBuffer ; $5df0
	ld bc, $0010 ; $5df3
	call CopyDataFromBank ; $5df6
	ld hl, wTextBuffer ; $5df9
	ld bc, $0002 ; $5dfc
	add hl, bc ; $5dff
	ld a, [hl+] ; $5e00
	ld [wMapScrollMinX], a ; $5e01
	ld a, [hl+] ; $5e04
	ld [wMapScrollMinY], a ; $5e05
	ld a, [hl+] ; $5e08
	ld [wMapWidthTiles], a ; $5e09
	ld a, [hl+] ; $5e0c
	ld [wMapHeightTiles], a ; $5e0d
	pop bc ; $5e10
	ld a, b ; $5e11
	call CopyScrolledSceneTilemapToVram ; $5e12
	call EnableLCD ; $5e15
	call AdvanceFrame ; $5e18
	call AdvanceFrame ; $5e1b
	ret ; $5e1e
Unused_0a_SceneViewerSelectScene:
	ldh a, [hInputRisingEdge] ; $5e1f
	bit PADB_B, a ; $5e21
	ret z ; $5e23
	ld a, [wScrollListLength] ; $5e24
	dec a ; $5e27
	srl a ; $5e28
	srl a ; $5e2a
	inc a ; $5e2c
	push af ; $5e2d
	ld a, [wCurrentScene] ; $5e2e
	ld [wUnusedPrevSceneIndex], a ; $5e31
	call StopSceneTileAnimations ; $5e34
	pop af ; $5e37
	ld hl, Text_30_374 ; $5e38
	farcall RunPagedTextMenu ; $5e3b
	ld [wCurrentScene], a ; $5e3e
	cp $ff ; $5e41
	jp z, .done ; $5e43
	ld b, $01 ; $5e46
	call Unused_0a_LoadAndDisplayScene ; $5e48
	ld a, [wCurrentScene] ; $5e4b
	call InitSceneTileAnimations ; $5e4e
.done:
	ret ; $5e51
UnusedSceneViewerSelectSceneMenu:
	ld hl, Text_30_374 ; $5e52
	ld d, $01 ; $5e55
	ld e, $01 ; $5e57
	farcall CreateMenuWindowFromText ; $5e59
	ld a, [$d820] ; $5e5c
	ld [$d82f], a ; $5e5f
	farcall RestoreShadowTilemap ; $5e62
	farcall Unused_05_StubNop_05_0 ; $5e65
.inputLoop:
	call AdvanceFrame ; $5e68
	ldh a, [hPlayerInputFlags] ; $5e6b
	and PADF_B ; $5e6d
	jr nz, .inputLoop ; $5e6f
	farcall RunMenuSelection ; $5e71
	ld [wCurrentScene], a ; $5e74
	ld a, [$d82f] ; $5e77
	farcall CloseWindow ; $5e7a
	ld a, [wCurrentScene] ; $5e7d
	cp $ff ; $5e80
	jp z, .redraw ; $5e82
	ld a, [wCurrentScene] ; $5e85
	ld b, $01 ; $5e88
	call Unused_0a_LoadAndDisplayScene ; $5e8a
	farcall RestoreShadowTilemap ; $5e8d
.redraw:
	ret ; $5e90
Unused_0a_RunSceneSelectDebugMenu:
	push af ; $5e91
	push bc ; $5e92
	push de ; $5e93
	push hl ; $5e94
	ld a, $08 ; $5e95
	ld [wScrollListLength], a ; $5e97
	dec a ; $5e9a
	srl a ; $5e9b
	srl a ; $5e9d
	inc a ; $5e9f
	push af ; $5ea0
	ld a, [wCurrentScene] ; $5ea1
	ld [wUnusedPrevSceneIndex], a ; $5ea4
	call StopSceneTileAnimations ; $5ea7
	pop af ; $5eaa
	ld hl, Text_30_374 ; $5eab
	farcall RunPagedTextMenu ; $5eae
	ld [wCurrentScene], a ; $5eb1
	cp $ff ; $5eb4
	jp z, .done ; $5eb6
	ld b, $01 ; $5eb9
	farcall ResetTextWindowState ; $5ebb
	call DisableLCDSafely ; $5ebe
	call InitSceneScroll ; $5ec1
	ld a, [wCurrentScene] ; $5ec4
	call LoadStorySceneGraphics ; $5ec7
	ld a, $00 ; $5eca
	farcall CopyScrolledSceneTilemapToVram ; $5ecc
	call EnableLCD ; $5ecf
	ld a, [wCurrentScene] ; $5ed2
	call InitSceneTileAnimations ; $5ed5
.done:
	pop hl ; $5ed8
	pop de ; $5ed9
	pop bc ; $5eda
	pop af ; $5edb
	ret ; $5edc
GetCollisionMapCellAddr:
	push bc ; $5edd
	push de ; $5ede
	sra d ; $5edf
	sla d ; $5ee1
	sra e ; $5ee3
	sla e ; $5ee5
	ld h, $00 ; $5ee7
	ld l, e ; $5ee9
	add hl, hl ; $5eea
	add hl, hl ; $5eeb
	add hl, hl ; $5eec
	add hl, hl ; $5eed
	ld b, $00 ; $5eee
	ld c, d ; $5ef0
	sra c ; $5ef1
	add hl, bc ; $5ef3
	ld bc, wCollisionMap ; $5ef4
	add hl, bc ; $5ef7
	pop de ; $5ef8
	pop bc ; $5ef9
	ret ; $5efa
ReadCollisionMapCell:
	push bc ; $5efb
	push de ; $5efc
	push hl ; $5efd
	call GetCollisionMapCellAddr ; $5efe
	push_wram_bank WRAM_SCENE ; $5f01
	ld b, [hl] ; $5f0a
	pop_wram_bank ; $5f0b
	ld a, b ; $5f10
	pop hl ; $5f11
	pop de ; $5f12
	pop bc ; $5f13
	ret ; $5f14
Unused_0a_WriteCollisionMapCell:
	push af ; $5f15
	push bc ; $5f16
	push de ; $5f17
	push hl ; $5f18
	call GetCollisionMapCellAddr ; $5f19
	ld b, a ; $5f1c
	push_wram_bank WRAM_SCENE ; $5f1d
	ld [hl], b ; $5f26
	pop_wram_bank ; $5f27
	pop hl ; $5f2c
	pop de ; $5f2d
	pop bc ; $5f2e
	pop af ; $5f2f
	ret ; $5f30

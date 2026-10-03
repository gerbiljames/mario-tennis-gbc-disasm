TestCartIdString_03:
	; $5957, 30 bytes (ascii)
	db "TESTCARTIDTESTCARTIDTESTCARTID"
Unused_03_DebugTestMinigameRecords:
	push af ; $5975
	push bc ; $5976
	push de ; $5977
	push hl ; $5978
	wram_bank WRAM_SOUND ; $5979
	ld hl, wMinigameRecordValue ; $597f
	ld de, $270f ; $5982
	ld a, e ; $5985
	ld [hl+], a ; $5986
	ld [hl], d ; $5987
	xor a ; $5988
	call UpdateMinigameRecord ; $5989
	ld hl, wMinigameRecordValue ; $598c
	ld de, $03e7 ; $598f
	ld a, e ; $5992
	ld [hl+], a ; $5993
	ld [hl], d ; $5994
	ld a, $01 ; $5995
	call UpdateMinigameRecord ; $5997
	ld hl, wMinigameRecordValue ; $599a
	ld de, $0000 ; $599d
	ld a, e ; $59a0
	ld [hl+], a ; $59a1
	ld [hl], d ; $59a2
	xor a ; $59a3
	call ReadMinigameRecord ; $59a4
	ld a, $01 ; $59a7
	call ReadMinigameRecord ; $59a9
	pop hl ; $59ac
	pop de ; $59ad
	pop bc ; $59ae
	pop af ; $59af
	ret ; $59b0
FillMemory16:
	ld [hl+], a ; $59b1
	ld [hl+], a ; $59b2
	ld [hl+], a ; $59b3
	ld [hl+], a ; $59b4
	ld [hl+], a ; $59b5
	ld [hl+], a ; $59b6
	ld [hl+], a ; $59b7
	ld [hl+], a ; $59b8
	ld [hl+], a ; $59b9
	ld [hl+], a ; $59ba
	ld [hl+], a ; $59bb
	ld [hl+], a ; $59bc
	ld [hl+], a ; $59bd
	ld [hl+], a ; $59be
	ld [hl+], a ; $59bf
	ld [hl+], a ; $59c0
	dec c ; $59c1
	jr nz, FillMemory16 ; $59c2
	ret ; $59c4
RunScrollingTextScreen:
	call ClearFrameTasks ; $59c5
	farcall LoadMenuFontGfx ; $59c8
	call DisableLCDSafely ; $59cb
	xor a ; $59ce
	ldh [hScrollX], a ; $59cf
	ldh [hScrollY], a ; $59d1
	ld [wCameraX], a ; $59d3
	ld [wCameraX + 1], a ; $59d6
	ld [wCameraY], a ; $59d9
	ld [wCameraY + 1], a ; $59dc
	ld a, $90 ; $59df
	ldh [rWY], a ; $59e1
	call ClearSpriteQueue ; $59e3
	ld hl, ScrollTextPalette_03 ; $59e6
	ld_bg_pals de, 0, 1 ; $59e9
	call LoadPaletteShadow ; $59ec
	call InitScrollingTextScreen ; $59ef
	call EnableLCD ; $59f2
	sound BGM_CREDITS ; $59f5
	ld c, $08 ; $59f7
	call ForceFadeIn ; $59f9
	call WaitFadeEnd ; $59fc
.loop:
	wram_bank WRAM_SCENE ; $59ff
	ld a, [wScrollTextDelay] ; $5a05
	dec a ; $5a08
	ld [wScrollTextDelay], a ; $5a09
	jr nz, .checkDebugStepMode ; $5a0c
	ld a, $02 ; $5a0e
	ld [wScrollTextDelay], a ; $5a10
	ld a, [wScrollTextDone] ; $5a13
	and a ; $5a16
	jr nz, .checkDebugStepMode ; $5a17
	ldh a, [hScrollY] ; $5a19
	inc a ; $5a1b
	ldh [hScrollY], a ; $5a1c
	and $07 ; $5a1e
	jr nz, .checkDebugStepMode ; $5a20
	ld hl, wScrollTextId ; $5a22
	ld a, [hl+] ; $5a25
	ld h, [hl] ; $5a26
	ld l, a ; $5a27
	wram_bank WRAM_SCREEN ; $5a28
	ld de, wShadowTilemap ; $5a2e
	ld c, $10 ; $5a31
	farcall FetchAndDrawDialogueText ; $5a33
	call TestTextEndMarker ; $5a36
	and a ; $5a39
	jr nz, .nonZero ; $5a3a
	wram_bank WRAM_SCENE ; $5a3c
	ld a, $01 ; $5a42
	ld [wScrollTextDone], a ; $5a44
	jr .checkDebugStepMode ; $5a47
.nonZero:
	ld de, $0090 ; $5a49
	call GetScrollTextRowVramAddr ; $5a4c
	push de ; $5a4f
	wram_bank WRAM_SCREEN ; $5a50
	ld hl, wShadowTilemap ; $5a56
	ld c, TILEMAP_WIDTH / 16 ; $5a59
	call QueueVRAMCopy ; $5a5b
	pop de ; $5a5e
	wram_bank WRAM_SCENE ; $5a5f
	ld hl, wScrollTextId ; $5a65
	ld b, h ; $5a68
	ld c, l ; $5a69
	ld a, [hl+] ; $5a6a
	ld d, [hl] ; $5a6b
	ld e, a ; $5a6c
	inc de ; $5a6d
	ld h, b ; $5a6e
	ld l, c ; $5a6f
	ld a, e ; $5a70
	ld [hl+], a ; $5a71
	ld [hl], d ; $5a72
.checkDebugStepMode:
	ldh a, [hDebugStepMode] ; $5a73
	or a ; $5a75
	jr nz, .nonZero2 ; $5a76
	ld a, [wScrollTextDone] ; $5a78
	and a ; $5a7b
	jr z, .advanceFrame ; $5a7c
.nonZero2:
	ldh a, [hPlayerInputFlags] ; $5a7e
	and $0b ; $5a80
	jr nz, .maskSet ; $5a82
.advanceFrame:
	call AdvanceFrame ; $5a84
	wram_bank WRAM_SCREEN ; $5a87
	xor a ; $5a8d
	ld b, $40 ; $5a8e
	ld hl, wShadowTilemap ; $5a90
.loopB:
	ld [hl+], a ; $5a93
	inc b ; $5a94
	jr nz, .loopB ; $5a95
	jp .loop ; $5a97
.maskSet:
	ld c, $01 ; $5a9a
	call BeginFadeOut ; $5a9c
	call WaitFadeEnd ; $5a9f
	call ClearFrameTasks ; $5aa2
	farcall LoadMenuFontGfx ; $5aa5
	ret ; $5aa8
InitScrollingTextScreen:
	wram_bank WRAM_SCENE ; $5aa9
	ld hl, wScrollTextDelay ; $5aaf
	ld a, $02 ; $5ab2
	ld [hl+], a ; $5ab4
	ld [hl+], a ; $5ab5
	ld de, $1863 ; $5ab6
	ld a, e ; $5ab9
	ld [hl+], a ; $5aba
	ld [hl], d ; $5abb
	xor a ; $5abc
	ld [wScrollTextDone], a ; $5abd
	wram_bank WRAM_COURT_PLANES ; $5ac0
	ld bc, $0400 ; $5ac6
	ld d, $00 ; $5ac9
	ld hl, wScreenAttrmap ; $5acb
	call FillMemoryBC ; $5ace
	ld hl, wScreenAttrmap ; $5ad1
	ld de, $b800 ; $5ad4
	ld c, TILEMAP_AREA / 16 ; $5ad7
	call QueueVRAMCopy ; $5ad9
	wram_bank WRAM_SCREEN ; $5adc
	ld bc, wScreenAttrmap_SIZE ; $5ae2
	ld d, $20 ; $5ae5
	ld hl, wShadowTilemap ; $5ae7
	call FillMemoryBC ; $5aea
	ld hl, wShadowTilemap ; $5aed
	ld de, vBGMap0 ; $5af0
	ld c, TILEMAP_AREA / 16 ; $5af3
	call QueueVRAMCopy ; $5af5
	ret ; $5af8
FillMemoryBC:
	ld [hl], d ; $5af9
	inc hl ; $5afa
	dec bc ; $5afb
	ld a, b ; $5afc
	or c ; $5afd
	jr nz, FillMemoryBC ; $5afe
	ret ; $5b00
GetScrollTextRowVramAddr:
	ldh a, [hScrollY] ; $5b01
	ld h, $00 ; $5b03
	ld l, a ; $5b05
	add hl, de ; $5b06
	sla l ; $5b07
	rl h ; $5b09
	sla l ; $5b0b
	rl h ; $5b0d
	ld a, h ; $5b0f
	and $03 ; $5b10
	ld h, a ; $5b12
	ld de, vBGMap0 ; $5b13
	add hl, de ; $5b16
	ld d, h ; $5b17
	ld e, l ; $5b18
	ret ; $5b19
TestTextEndMarker:
	ld a, [wShadowTilemap] ; $5b1a
	sub $23 ; $5b1d
	ret ; $5b1f
ScrollTextPalette_03:
	INCLUDE "data/bank_003/ScrollTextPalette_03.asm" ; $5b20, 8 bytes (palettes)
SetupSceneAnimationPalettes:
	push_wram_bank WRAM_SCENE ; $5b28
	xor a ; $5b31
	ld [wSceneAnimFrame], a ; $5b32
	ld hl, SceneAnimObjPalette0_03 ; $5b35
	ld_obj_pals de, 2, 1 ; $5b38
	call LoadPaletteShadow ; $5b3b
	ld hl, SceneAnimObjPalette1_03 ; $5b3e
	ld_obj_pals de, 3, 1 ; $5b41
	call LoadPaletteShadow ; $5b44
	pop_wram_bank ; $5b47
	ret ; $5b4c
UpdateSceneAnimation:
	push_wram_bank WRAM_SCENE ; $5b4d
	call LoadCutsceneAnimFrameGfx_00_08 ; $5b56
	call LoadCutsceneAnimFrameGfx_09_11 ; $5b59
	call LoadCutsceneAnimFrameGfx_12_1A ; $5b5c
	call LoadCutsceneAnimFrameGfx_1B_23 ; $5b5f
	call LoadCutsceneAnimFrameGfx_24_2C ; $5b62
	call LoadCutsceneAnimFrameGfx_2D_35 ; $5b65
	wram_bank WRAM_SCENE ; $5b68
	ld a, [wCutsceneSlideTimer] ; $5b6e
	and $03 ; $5b71
	jr nz, .restore ; $5b73
	ld a, [wSceneAnimFrame] ; $5b75
	ld b, a ; $5b78
	sub $36 ; $5b79
	jp nc, .restore ; $5b7b
	ld a, b ; $5b7e
	inc a ; $5b7f
	ld [wSceneAnimFrame], a ; $5b80
.restore:
	pop_wram_bank ; $5b83
	ret ; $5b88
LoadCutsceneAnimFrameGfx_00_08:
	wram_bank WRAM_SCENE ; $5b89
	ld a, [wSceneAnimFrame] ; $5b8f
	cp $00 ; $5b92
	jp z, .eq00 ; $5b94
	cp $01 ; $5b97
	jp z, .eq01 ; $5b99
	cp $02 ; $5b9c
	jp z, .eq02 ; $5b9e
	cp $03 ; $5ba1
	jp z, .eq03 ; $5ba3
	cp $04 ; $5ba6
	jp z, .eq04 ; $5ba8
	cp $05 ; $5bab
	jp z, .eq05 ; $5bad
	cp $06 ; $5bb0
	jp z, .eq06 ; $5bb2
	cp $07 ; $5bb5
	jp z, .eq07 ; $5bb7
	cp $08 ; $5bba
	jp z, .eq08 ; $5bbc
	jp .queueSpriteTemplate ; $5bbf
.eq00:
	wram_bank WRAM_STAGING ; $5bc2
	ld hl, CutsceneAnimFrameLZ_00 ; $5bc8
	ld de, wDecompBuffer ; $5bcb
	call DecompressData ; $5bce
	ld hl, wDecompBuffer ; $5bd1
	ld de, vTiles0 ; $5bd4
	ld c, CutsceneAnimFrameLZ_00_SIZE / 16 ; $5bd7
	call QueueVRAMCopy ; $5bd9
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate0 ; $5bdc
	sprite_xy $fe, $80 ; $5bdf
	ld_oam bc, 3, $00 ; $5be3
	call QueueSpriteTemplate ; $5be6
	ret ; $5be9
.eq01:
	wram_bank WRAM_STAGING ; $5bea
	ld hl, CutsceneAnimFrameLZ_01 ; $5bf0
	ld de, wDecompBuffer ; $5bf3
	call DecompressData ; $5bf6
	ld hl, wDecompBuffer ; $5bf9
	ld de, vTiles0 ; $5bfc
	ld c, CutsceneAnimFrameLZ_01_SIZE / 16 ; $5bff
	call QueueVRAMCopy ; $5c01
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate1 ; $5c04
	sprite_xy $fe, $80 ; $5c07
	ld_oam bc, 3, $00 ; $5c0b
	call QueueSpriteTemplate ; $5c0e
	ret ; $5c11
.eq02:
	wram_bank WRAM_STAGING ; $5c12
	ld hl, CutsceneAnimFrameLZ_02 ; $5c18
	ld de, wDecompBuffer ; $5c1b
	call DecompressData ; $5c1e
	ld hl, wDecompBuffer ; $5c21
	ld de, vTiles0 ; $5c24
	ld c, CutsceneAnimFrameLZ_02_SIZE / 16 ; $5c27
	call QueueVRAMCopy ; $5c29
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate2 ; $5c2c
	sprite_xy $fe, $80 ; $5c2f
	ld_oam bc, 3, $00 ; $5c33
	call QueueSpriteTemplate ; $5c36
	ret ; $5c39
.eq03:
	wram_bank WRAM_STAGING ; $5c3a
	ld hl, CutsceneAnimFrameLZ_03 ; $5c40
	ld de, wDecompBuffer ; $5c43
	call DecompressData ; $5c46
	ld hl, wDecompBuffer ; $5c49
	ld de, vTiles0 ; $5c4c
	ld c, CutsceneAnimFrameLZ_03_SIZE / 16 ; $5c4f
	call QueueVRAMCopy ; $5c51
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate3 ; $5c54
	sprite_xy $fe, $80 ; $5c57
	ld_oam bc, 3, $00 ; $5c5b
	call QueueSpriteTemplate ; $5c5e
	ret ; $5c61
.eq04:
	wram_bank WRAM_STAGING ; $5c62
	ld hl, CutsceneAnimFrameLZ_04 ; $5c68
	ld de, wDecompBuffer ; $5c6b
	call DecompressData ; $5c6e
	ld hl, wDecompBuffer ; $5c71
	ld de, vTiles0 ; $5c74
	ld c, CutsceneAnimFrameLZ_04_SIZE / 16 ; $5c77
	call QueueVRAMCopy ; $5c79
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate4 ; $5c7c
	sprite_xy $fe, $80 ; $5c7f
	ld_oam bc, 3, $00 ; $5c83
	call QueueSpriteTemplate ; $5c86
	ret ; $5c89
.eq05:
	wram_bank WRAM_STAGING ; $5c8a
	ld hl, CutsceneAnimFrameLZ_05 ; $5c90
	ld de, wDecompBuffer ; $5c93
	call DecompressData ; $5c96
	ld hl, wDecompBuffer ; $5c99
	ld de, vTiles0 ; $5c9c
	ld c, CutsceneAnimFrameLZ_05_SIZE / 16 ; $5c9f
	call QueueVRAMCopy ; $5ca1
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate5 ; $5ca4
	sprite_xy $fe, $80 ; $5ca7
	ld_oam bc, 3, $00 ; $5cab
	call QueueSpriteTemplate ; $5cae
	ret ; $5cb1
.eq06:
	wram_bank WRAM_STAGING ; $5cb2
	ld hl, CutsceneAnimFrameLZ_06 ; $5cb8
	ld de, wDecompBuffer ; $5cbb
	call DecompressData ; $5cbe
	ld hl, wDecompBuffer ; $5cc1
	ld de, vTiles0 ; $5cc4
	ld c, CutsceneAnimFrameLZ_06_SIZE / 16 ; $5cc7
	call QueueVRAMCopy ; $5cc9
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate6 ; $5ccc
	sprite_xy $fe, $80 ; $5ccf
	ld_oam bc, 3, $00 ; $5cd3
	call QueueSpriteTemplate ; $5cd6
	ret ; $5cd9
.eq07:
	wram_bank WRAM_STAGING ; $5cda
	ld hl, CutsceneAnimFrameLZ_07 ; $5ce0
	ld de, wDecompBuffer ; $5ce3
	call DecompressData ; $5ce6
	ld hl, wDecompBuffer ; $5ce9
	ld de, vTiles0 ; $5cec
	ld c, CutsceneAnimFrameLZ_07_SIZE / 16 ; $5cef
	call QueueVRAMCopy ; $5cf1
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate7 ; $5cf4
	sprite_xy $fe, $80 ; $5cf7
	ld_oam bc, 3, $00 ; $5cfb
	call QueueSpriteTemplate ; $5cfe
	ret ; $5d01
.eq08:
	wram_bank WRAM_STAGING ; $5d02
	ld hl, CutsceneAnimFrameLZ_08 ; $5d08
	ld de, wDecompBuffer ; $5d0b
	call DecompressData ; $5d0e
	ld hl, wDecompBuffer ; $5d11
	ld de, vTiles0 ; $5d14
	ld c, CutsceneAnimFrameLZ_08_SIZE / 16 ; $5d17
	call QueueVRAMCopy ; $5d19
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate8 ; $5d1c
	sprite_xy $fe, $80 ; $5d1f
	ld_oam bc, 3, $00 ; $5d23
	call QueueSpriteTemplate ; $5d26
	ret ; $5d29
.queueSpriteTemplate:
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate8 ; $5d2a
	sprite_xy $fe, $80 ; $5d2d
	ld_oam bc, 3, $00 ; $5d31
	call QueueSpriteTemplate ; $5d34
	ret ; $5d37
LoadCutsceneAnimFrameGfx_09_11:
	wram_bank WRAM_SCENE ; $5d38
	ld a, [wSceneAnimFrame] ; $5d3e
	ld b, a ; $5d41
	sub $09 ; $5d42
	ret c ; $5d44
	ld a, b ; $5d45
	cp $09 ; $5d46
	jp z, .eq09 ; $5d48
	cp $0a ; $5d4b
	jp z, .eq0a ; $5d4d
	cp $0b ; $5d50
	jp z, .eq0b ; $5d52
	cp $0c ; $5d55
	jp z, .eq0c ; $5d57
	cp $0d ; $5d5a
	jp z, .eq0d ; $5d5c
	cp $0e ; $5d5f
	jp z, .eq0e ; $5d61
	cp $0f ; $5d64
	jp z, .eq0f ; $5d66
	cp $10 ; $5d69
	jp z, .eq10 ; $5d6b
	cp $11 ; $5d6e
	jp z, .eq11 ; $5d70
	jp .queueSpriteTemplate ; $5d73
.eq09:
	wram_bank WRAM_STAGING ; $5d76
	ld hl, CutsceneAnimFrameLZ_09 ; $5d7c
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5d7f
	call DecompressData ; $5d82
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5d85
	ld de, vTiles0 + $04 * TILE_SIZE ; $5d88
	ld c, CutsceneAnimFrameLZ_09_SIZE / 16 ; $5d8b
	call QueueVRAMCopy ; $5d8d
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate0 ; $5d90
	sprite_xy $0e, $80 ; $5d93
	ld_oam bc, 2, $04 ; $5d97
	call QueueSpriteTemplate ; $5d9a
	ret ; $5d9d
.eq0a:
	wram_bank WRAM_STAGING ; $5d9e
	ld hl, CutsceneAnimFrameLZ_0a ; $5da4
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5da7
	call DecompressData ; $5daa
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5dad
	ld de, vTiles0 + $04 * TILE_SIZE ; $5db0
	ld c, CutsceneAnimFrameLZ_0a_SIZE / 16 ; $5db3
	call QueueVRAMCopy ; $5db5
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate1 ; $5db8
	sprite_xy $0e, $80 ; $5dbb
	ld_oam bc, 2, $04 ; $5dbf
	call QueueSpriteTemplate ; $5dc2
	ret ; $5dc5
.eq0b:
	wram_bank WRAM_STAGING ; $5dc6
	ld hl, CutsceneAnimFrameLZ_0b ; $5dcc
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5dcf
	call DecompressData ; $5dd2
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5dd5
	ld de, vTiles0 + $04 * TILE_SIZE ; $5dd8
	ld c, CutsceneAnimFrameLZ_0b_SIZE / 16 ; $5ddb
	call QueueVRAMCopy ; $5ddd
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate2 ; $5de0
	sprite_xy $0e, $80 ; $5de3
	ld_oam bc, 2, $04 ; $5de7
	call QueueSpriteTemplate ; $5dea
	ret ; $5ded
.eq0c:
	wram_bank WRAM_STAGING ; $5dee
	ld hl, CutsceneAnimFrameLZ_0c ; $5df4
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5df7
	call DecompressData ; $5dfa
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5dfd
	ld de, vTiles0 + $04 * TILE_SIZE ; $5e00
	ld c, CutsceneAnimFrameLZ_0c_SIZE / 16 ; $5e03
	call QueueVRAMCopy ; $5e05
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate3 ; $5e08
	sprite_xy $0e, $80 ; $5e0b
	ld_oam bc, 2, $04 ; $5e0f
	call QueueSpriteTemplate ; $5e12
	ret ; $5e15
.eq0d:
	wram_bank WRAM_STAGING ; $5e16
	ld hl, CutsceneAnimFrameLZ_0d ; $5e1c
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5e1f
	call DecompressData ; $5e22
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5e25
	ld de, vTiles0 + $04 * TILE_SIZE ; $5e28
	ld c, CutsceneAnimFrameLZ_0d_SIZE / 16 ; $5e2b
	call QueueVRAMCopy ; $5e2d
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate4 ; $5e30
	sprite_xy $0e, $80 ; $5e33
	ld_oam bc, 2, $04 ; $5e37
	call QueueSpriteTemplate ; $5e3a
	ret ; $5e3d
.eq0e:
	wram_bank WRAM_STAGING ; $5e3e
	ld hl, CutsceneAnimFrameLZ_0e ; $5e44
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5e47
	call DecompressData ; $5e4a
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5e4d
	ld de, vTiles0 + $04 * TILE_SIZE ; $5e50
	ld c, CutsceneAnimFrameLZ_0e_SIZE / 16 ; $5e53
	call QueueVRAMCopy ; $5e55
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate5 ; $5e58
	sprite_xy $0e, $80 ; $5e5b
	ld_oam bc, 2, $04 ; $5e5f
	call QueueSpriteTemplate ; $5e62
	ret ; $5e65
.eq0f:
	wram_bank WRAM_STAGING ; $5e66
	ld hl, CutsceneAnimFrameLZ_0f ; $5e6c
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5e6f
	call DecompressData ; $5e72
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5e75
	ld de, vTiles0 + $04 * TILE_SIZE ; $5e78
	ld c, CutsceneAnimFrameLZ_0f_SIZE / 16 ; $5e7b
	call QueueVRAMCopy ; $5e7d
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate6 ; $5e80
	sprite_xy $0e, $80 ; $5e83
	ld_oam bc, 2, $04 ; $5e87
	call QueueSpriteTemplate ; $5e8a
	ret ; $5e8d
.eq10:
	wram_bank WRAM_STAGING ; $5e8e
	ld hl, CutsceneAnimFrameLZ_10 ; $5e94
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5e97
	call DecompressData ; $5e9a
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5e9d
	ld de, vTiles0 + $04 * TILE_SIZE ; $5ea0
	ld c, CutsceneAnimFrameLZ_10_SIZE / 16 ; $5ea3
	call QueueVRAMCopy ; $5ea5
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate7 ; $5ea8
	sprite_xy $0e, $80 ; $5eab
	ld_oam bc, 2, $04 ; $5eaf
	call QueueSpriteTemplate ; $5eb2
	ret ; $5eb5
.eq11:
	wram_bank WRAM_STAGING ; $5eb6
	ld hl, CutsceneAnimFrameLZ_11 ; $5ebc
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5ebf
	call DecompressData ; $5ec2
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5ec5
	ld de, vTiles0 + $04 * TILE_SIZE ; $5ec8
	ld c, CutsceneAnimFrameLZ_11_SIZE / 16 ; $5ecb
	call QueueVRAMCopy ; $5ecd
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate8 ; $5ed0
	sprite_xy $0e, $80 ; $5ed3
	ld_oam bc, 2, $04 ; $5ed7
	call QueueSpriteTemplate ; $5eda
	ret ; $5edd
.queueSpriteTemplate:
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate8 ; $5ede
	sprite_xy $0e, $80 ; $5ee1
	ld_oam bc, 2, $04 ; $5ee5
	call QueueSpriteTemplate ; $5ee8
	ret ; $5eeb
LoadCutsceneAnimFrameGfx_12_1A:
	wram_bank WRAM_SCENE ; $5eec
	ld a, [wSceneAnimFrame] ; $5ef2
	ld b, a ; $5ef5
	sub $12 ; $5ef6
	ret c ; $5ef8
	ld a, b ; $5ef9
	cp $12 ; $5efa
	jp z, .eq12 ; $5efc
	cp $13 ; $5eff
	jp z, .eq13 ; $5f01
	cp $14 ; $5f04
	jp z, .eq14 ; $5f06
	cp $15 ; $5f09
	jp z, .eq15 ; $5f0b
	cp $16 ; $5f0e
	jp z, .eq16 ; $5f10
	cp $17 ; $5f13
	jp z, .eq17 ; $5f15
	cp $18 ; $5f18
	jp z, .eq18 ; $5f1a
	cp $19 ; $5f1d
	jp z, .eq19 ; $5f1f
	cp $1a ; $5f22
	jp z, .eq1a ; $5f24
	jp .queueSpriteTemplate ; $5f27
.eq12:
	wram_bank WRAM_STAGING ; $5f2a
	ld hl, CutsceneAnimFrameLZ_12 ; $5f30
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $5f33
	call DecompressData ; $5f36
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $5f39
	ld de, vTiles0 + $08 * TILE_SIZE ; $5f3c
	ld c, CutsceneAnimFrameLZ_12_SIZE / 16 ; $5f3f
	call QueueVRAMCopy ; $5f41
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate0 ; $5f44
	sprite_xy $1e, $80 ; $5f47
	ld_oam bc, 3, $08 ; $5f4b
	call QueueSpriteTemplate ; $5f4e
	ret ; $5f51
.eq13:
	wram_bank WRAM_STAGING ; $5f52
	ld hl, CutsceneAnimFrameLZ_13 ; $5f58
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $5f5b
	call DecompressData ; $5f5e
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $5f61
	ld de, vTiles0 + $08 * TILE_SIZE ; $5f64
	ld c, CutsceneAnimFrameLZ_13_SIZE / 16 ; $5f67
	call QueueVRAMCopy ; $5f69
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate1 ; $5f6c
	sprite_xy $1e, $80 ; $5f6f
	ld_oam bc, 3, $08 ; $5f73
	call QueueSpriteTemplate ; $5f76
	ret ; $5f79
.eq14:
	wram_bank WRAM_STAGING ; $5f7a
	ld hl, CutsceneAnimFrameLZ_14 ; $5f80
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $5f83
	call DecompressData ; $5f86
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $5f89
	ld de, vTiles0 + $08 * TILE_SIZE ; $5f8c
	ld c, CutsceneAnimFrameLZ_14_SIZE / 16 ; $5f8f
	call QueueVRAMCopy ; $5f91
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate2 ; $5f94
	sprite_xy $1e, $80 ; $5f97
	ld_oam bc, 3, $08 ; $5f9b
	call QueueSpriteTemplate ; $5f9e
	ret ; $5fa1
.eq15:
	wram_bank WRAM_STAGING ; $5fa2
	ld hl, CutsceneAnimFrameLZ_15 ; $5fa8
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $5fab
	call DecompressData ; $5fae
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $5fb1
	ld de, vTiles0 + $08 * TILE_SIZE ; $5fb4
	ld c, CutsceneAnimFrameLZ_15_SIZE / 16 ; $5fb7
	call QueueVRAMCopy ; $5fb9
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate3 ; $5fbc
	sprite_xy $1e, $80 ; $5fbf
	ld_oam bc, 3, $08 ; $5fc3
	call QueueSpriteTemplate ; $5fc6
	ret ; $5fc9
.eq16:
	wram_bank WRAM_STAGING ; $5fca
	ld hl, CutsceneAnimFrameLZ_16 ; $5fd0
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $5fd3
	call DecompressData ; $5fd6
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $5fd9
	ld de, vTiles0 + $08 * TILE_SIZE ; $5fdc
	ld c, CutsceneAnimFrameLZ_16_SIZE / 16 ; $5fdf
	call QueueVRAMCopy ; $5fe1
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate4 ; $5fe4
	sprite_xy $1e, $80 ; $5fe7
	ld_oam bc, 3, $08 ; $5feb
	call QueueSpriteTemplate ; $5fee
	ret ; $5ff1
.eq17:
	wram_bank WRAM_STAGING ; $5ff2
	ld hl, CutsceneAnimFrameLZ_17 ; $5ff8
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $5ffb
	call DecompressData ; $5ffe
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $6001
	ld de, vTiles0 + $08 * TILE_SIZE ; $6004
	ld c, CutsceneAnimFrameLZ_17_SIZE / 16 ; $6007
	call QueueVRAMCopy ; $6009
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate5 ; $600c
	sprite_xy $1e, $80 ; $600f
	ld_oam bc, 3, $08 ; $6013
	call QueueSpriteTemplate ; $6016
	ret ; $6019
.eq18:
	wram_bank WRAM_STAGING ; $601a
	ld hl, CutsceneAnimFrameLZ_18 ; $6020
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $6023
	call DecompressData ; $6026
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $6029
	ld de, vTiles0 + $08 * TILE_SIZE ; $602c
	ld c, CutsceneAnimFrameLZ_18_SIZE / 16 ; $602f
	call QueueVRAMCopy ; $6031
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate6 ; $6034
	sprite_xy $1e, $80 ; $6037
	ld_oam bc, 3, $08 ; $603b
	call QueueSpriteTemplate ; $603e
	ret ; $6041
.eq19:
	wram_bank WRAM_STAGING ; $6042
	ld hl, CutsceneAnimFrameLZ_19 ; $6048
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $604b
	call DecompressData ; $604e
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $6051
	ld de, vTiles0 + $08 * TILE_SIZE ; $6054
	ld c, CutsceneAnimFrameLZ_19_SIZE / 16 ; $6057
	call QueueVRAMCopy ; $6059
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate7 ; $605c
	sprite_xy $1e, $80 ; $605f
	ld_oam bc, 3, $08 ; $6063
	call QueueSpriteTemplate ; $6066
	ret ; $6069
.eq1a:
	wram_bank WRAM_STAGING ; $606a
	ld hl, CutsceneAnimFrameLZ_1a ; $6070
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $6073
	call DecompressData ; $6076
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $6079
	ld de, vTiles0 + $08 * TILE_SIZE ; $607c
	ld c, CutsceneAnimFrameLZ_1a_SIZE / 16 ; $607f
	call QueueVRAMCopy ; $6081
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate8 ; $6084
	sprite_xy $1e, $80 ; $6087
	ld_oam bc, 3, $08 ; $608b
	call QueueSpriteTemplate ; $608e
	ret ; $6091
.queueSpriteTemplate:
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate8 ; $6092
	sprite_xy $1e, $80 ; $6095
	ld_oam bc, 3, $08 ; $6099
	call QueueSpriteTemplate ; $609c
	ret ; $609f
LoadCutsceneAnimFrameGfx_1B_23:
	wram_bank WRAM_SCENE ; $60a0
	ld a, [wSceneAnimFrame] ; $60a6
	ld b, a ; $60a9
	sub $1b ; $60aa
	ret c ; $60ac
	ld a, b ; $60ad
	cp $1b ; $60ae
	jp z, .eq1b ; $60b0
	cp $1c ; $60b3
	jp z, .eq1c ; $60b5
	cp $1d ; $60b8
	jp z, .eq1d ; $60ba
	cp $1e ; $60bd
	jp z, .eq1e ; $60bf
	cp $1f ; $60c2
	jp z, .eq1f ; $60c4
	cp $20 ; $60c7
	jp z, .eq20 ; $60c9
	cp $21 ; $60cc
	jp z, .eq21 ; $60ce
	cp $22 ; $60d1
	jp z, .eq22 ; $60d3
	cp $23 ; $60d6
	jp z, .eq23 ; $60d8
	jp .queueSpriteTemplate ; $60db
.eq1b:
	wram_bank WRAM_STAGING ; $60de
	ld hl, CutsceneAnimFrameLZ_1b ; $60e4
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $60e7
	call DecompressData ; $60ea
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $60ed
	ld de, vTiles0 + $0c * TILE_SIZE ; $60f0
	ld c, CutsceneAnimFrameLZ_1b_SIZE / 16 ; $60f3
	call QueueVRAMCopy ; $60f5
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate0 ; $60f8
	sprite_xy $2e, $80 ; $60fb
	ld_oam bc, 3, $0c ; $60ff
	call QueueSpriteTemplate ; $6102
	ret ; $6105
.eq1c:
	wram_bank WRAM_STAGING ; $6106
	ld hl, CutsceneAnimFrameLZ_1c ; $610c
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $610f
	call DecompressData ; $6112
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $6115
	ld de, vTiles0 + $0c * TILE_SIZE ; $6118
	ld c, CutsceneAnimFrameLZ_1c_SIZE / 16 ; $611b
	call QueueVRAMCopy ; $611d
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate1 ; $6120
	sprite_xy $2e, $80 ; $6123
	ld_oam bc, 3, $0c ; $6127
	call QueueSpriteTemplate ; $612a
	ret ; $612d
.eq1d:
	wram_bank WRAM_STAGING ; $612e
	ld hl, CutsceneAnimFrameLZ_1d ; $6134
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $6137
	call DecompressData ; $613a
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $613d
	ld de, vTiles0 + $0c * TILE_SIZE ; $6140
	ld c, CutsceneAnimFrameLZ_1d_SIZE / 16 ; $6143
	call QueueVRAMCopy ; $6145
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate2 ; $6148
	sprite_xy $2e, $80 ; $614b
	ld_oam bc, 3, $0c ; $614f
	call QueueSpriteTemplate ; $6152
	ret ; $6155
.eq1e:
	wram_bank WRAM_STAGING ; $6156
	ld hl, CutsceneAnimFrameLZ_1e ; $615c
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $615f
	call DecompressData ; $6162
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $6165
	ld de, vTiles0 + $0c * TILE_SIZE ; $6168
	ld c, CutsceneAnimFrameLZ_1e_SIZE / 16 ; $616b
	call QueueVRAMCopy ; $616d
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate3 ; $6170
	sprite_xy $2e, $80 ; $6173
	ld_oam bc, 3, $0c ; $6177
	call QueueSpriteTemplate ; $617a
	ret ; $617d
.eq1f:
	wram_bank WRAM_STAGING ; $617e
	ld hl, CutsceneAnimFrameLZ_1f ; $6184
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $6187
	call DecompressData ; $618a
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $618d
	ld de, vTiles0 + $0c * TILE_SIZE ; $6190
	ld c, CutsceneAnimFrameLZ_1f_SIZE / 16 ; $6193
	call QueueVRAMCopy ; $6195
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate4 ; $6198
	sprite_xy $2e, $80 ; $619b
	ld_oam bc, 3, $0c ; $619f
	call QueueSpriteTemplate ; $61a2
	ret ; $61a5
.eq20:
	wram_bank WRAM_STAGING ; $61a6
	ld hl, CutsceneAnimFrameLZ_20 ; $61ac
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $61af
	call DecompressData ; $61b2
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $61b5
	ld de, vTiles0 + $0c * TILE_SIZE ; $61b8
	ld c, CutsceneAnimFrameLZ_20_SIZE / 16 ; $61bb
	call QueueVRAMCopy ; $61bd
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate5 ; $61c0
	sprite_xy $2e, $80 ; $61c3
	ld_oam bc, 3, $0c ; $61c7
	call QueueSpriteTemplate ; $61ca
	ret ; $61cd
.eq21:
	wram_bank WRAM_STAGING ; $61ce
	ld hl, CutsceneAnimFrameLZ_21 ; $61d4
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $61d7
	call DecompressData ; $61da
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $61dd
	ld de, vTiles0 + $0c * TILE_SIZE ; $61e0
	ld c, CutsceneAnimFrameLZ_21_SIZE / 16 ; $61e3
	call QueueVRAMCopy ; $61e5
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate6 ; $61e8
	sprite_xy $2e, $80 ; $61eb
	ld_oam bc, 3, $0c ; $61ef
	call QueueSpriteTemplate ; $61f2
	ret ; $61f5
.eq22:
	wram_bank WRAM_STAGING ; $61f6
	ld hl, CutsceneAnimFrameLZ_22 ; $61fc
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $61ff
	call DecompressData ; $6202
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $6205
	ld de, vTiles0 + $0c * TILE_SIZE ; $6208
	ld c, CutsceneAnimFrameLZ_22_SIZE / 16 ; $620b
	call QueueVRAMCopy ; $620d
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate7 ; $6210
	sprite_xy $2e, $80 ; $6213
	ld_oam bc, 3, $0c ; $6217
	call QueueSpriteTemplate ; $621a
	ret ; $621d
.eq23:
	wram_bank WRAM_STAGING ; $621e
	ld hl, CutsceneAnimFrameLZ_23 ; $6224
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $6227
	call DecompressData ; $622a
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $622d
	ld de, vTiles0 + $0c * TILE_SIZE ; $6230
	ld c, CutsceneAnimFrameLZ_23_SIZE / 16 ; $6233
	call QueueVRAMCopy ; $6235
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate8 ; $6238
	sprite_xy $2e, $80 ; $623b
	ld_oam bc, 3, $0c ; $623f
	call QueueSpriteTemplate ; $6242
	ret ; $6245
.queueSpriteTemplate:
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate8 ; $6246
	sprite_xy $2e, $80 ; $6249
	ld_oam bc, 3, $0c ; $624d
	call QueueSpriteTemplate ; $6250
	ret ; $6253
LoadCutsceneAnimFrameGfx_24_2C:
	wram_bank WRAM_SCENE ; $6254
	ld a, [wSceneAnimFrame] ; $625a
	ld b, a ; $625d
	sub $24 ; $625e
	ret c ; $6260
	ld a, b ; $6261
	cp $24 ; $6262
	jp z, .eq24 ; $6264
	cp $25 ; $6267
	jp z, .eq25 ; $6269
	cp $26 ; $626c
	jp z, .eq26 ; $626e
	cp $27 ; $6271
	jp z, .eq27 ; $6273
	cp $28 ; $6276
	jp z, .eq28 ; $6278
	cp $29 ; $627b
	jp z, .eq29 ; $627d
	cp $2a ; $6280
	jp z, .eq2a ; $6282
	cp $2b ; $6285
	jp z, .eq2b ; $6287
	cp $2c ; $628a
	jp z, .eq2c ; $628c
	jp .queueSpriteTemplate ; $628f
.eq24:
	wram_bank WRAM_STAGING ; $6292
	ld hl, CutsceneAnimFrameLZ_24 ; $6298
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $629b
	call DecompressData ; $629e
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $62a1
	ld de, vTiles0 + $0e * TILE_SIZE ; $62a4
	ld c, CutsceneAnimFrameLZ_24_SIZE / 16 ; $62a7
	call QueueVRAMCopy ; $62a9
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate0 ; $62ac
	sprite_xy $36, $80 ; $62af
	ld_oam bc, 2, $0e ; $62b3
	call QueueSpriteTemplate ; $62b6
	ret ; $62b9
.eq25:
	wram_bank WRAM_STAGING ; $62ba
	ld hl, CutsceneAnimFrameLZ_25 ; $62c0
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $62c3
	call DecompressData ; $62c6
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $62c9
	ld de, vTiles0 + $0e * TILE_SIZE ; $62cc
	ld c, CutsceneAnimFrameLZ_25_SIZE / 16 ; $62cf
	call QueueVRAMCopy ; $62d1
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate1 ; $62d4
	sprite_xy $36, $80 ; $62d7
	ld_oam bc, 2, $0e ; $62db
	call QueueSpriteTemplate ; $62de
	ret ; $62e1
.eq26:
	wram_bank WRAM_STAGING ; $62e2
	ld hl, CutsceneAnimFrameLZ_26 ; $62e8
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $62eb
	call DecompressData ; $62ee
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $62f1
	ld de, vTiles0 + $0e * TILE_SIZE ; $62f4
	ld c, CutsceneAnimFrameLZ_26_SIZE / 16 ; $62f7
	call QueueVRAMCopy ; $62f9
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate2 ; $62fc
	sprite_xy $36, $80 ; $62ff
	ld_oam bc, 2, $0e ; $6303
	call QueueSpriteTemplate ; $6306
	ret ; $6309
.eq27:
	wram_bank WRAM_STAGING ; $630a
	ld hl, CutsceneAnimFrameLZ_27 ; $6310
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $6313
	call DecompressData ; $6316
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $6319
	ld de, vTiles0 + $0e * TILE_SIZE ; $631c
	ld c, CutsceneAnimFrameLZ_27_SIZE / 16 ; $631f
	call QueueVRAMCopy ; $6321
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate3 ; $6324
	sprite_xy $36, $80 ; $6327
	ld_oam bc, 2, $0e ; $632b
	call QueueSpriteTemplate ; $632e
	ret ; $6331
.eq28:
	wram_bank WRAM_STAGING ; $6332
	ld hl, CutsceneAnimFrameLZ_28 ; $6338
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $633b
	call DecompressData ; $633e
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $6341
	ld de, vTiles0 + $0e * TILE_SIZE ; $6344
	ld c, CutsceneAnimFrameLZ_28_SIZE / 16 ; $6347
	call QueueVRAMCopy ; $6349
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate4 ; $634c
	sprite_xy $36, $80 ; $634f
	ld_oam bc, 2, $0e ; $6353
	call QueueSpriteTemplate ; $6356
	ret ; $6359
.eq29:
	wram_bank WRAM_STAGING ; $635a
	ld hl, CutsceneAnimFrameLZ_29 ; $6360
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $6363
	call DecompressData ; $6366
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $6369
	ld de, vTiles0 + $0e * TILE_SIZE ; $636c
	ld c, CutsceneAnimFrameLZ_29_SIZE / 16 ; $636f
	call QueueVRAMCopy ; $6371
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate5 ; $6374
	sprite_xy $36, $80 ; $6377
	ld_oam bc, 2, $0e ; $637b
	call QueueSpriteTemplate ; $637e
	ret ; $6381
.eq2a:
	wram_bank WRAM_STAGING ; $6382
	ld hl, CutsceneAnimFrameLZ_2a ; $6388
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $638b
	call DecompressData ; $638e
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $6391
	ld de, vTiles0 + $0e * TILE_SIZE ; $6394
	ld c, CutsceneAnimFrameLZ_2a_SIZE / 16 ; $6397
	call QueueVRAMCopy ; $6399
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate6 ; $639c
	sprite_xy $36, $80 ; $639f
	ld_oam bc, 2, $0e ; $63a3
	call QueueSpriteTemplate ; $63a6
	ret ; $63a9
.eq2b:
	wram_bank WRAM_STAGING ; $63aa
	ld hl, CutsceneAnimFrameLZ_2b ; $63b0
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $63b3
	call DecompressData ; $63b6
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $63b9
	ld de, vTiles0 + $0e * TILE_SIZE ; $63bc
	ld c, CutsceneAnimFrameLZ_2b_SIZE / 16 ; $63bf
	call QueueVRAMCopy ; $63c1
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate7 ; $63c4
	sprite_xy $36, $80 ; $63c7
	ld_oam bc, 2, $0e ; $63cb
	call QueueSpriteTemplate ; $63ce
	ret ; $63d1
.eq2c:
	wram_bank WRAM_STAGING ; $63d2
	ld hl, CutsceneAnimFrameLZ_2c ; $63d8
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $63db
	call DecompressData ; $63de
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $63e1
	ld de, vTiles0 + $0e * TILE_SIZE ; $63e4
	ld c, CutsceneAnimFrameLZ_2c_SIZE / 16 ; $63e7
	call QueueVRAMCopy ; $63e9
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate8 ; $63ec
	sprite_xy $36, $80 ; $63ef
	ld_oam bc, 2, $0e ; $63f3
	call QueueSpriteTemplate ; $63f6
	ret ; $63f9
.queueSpriteTemplate:
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate8 ; $63fa
	sprite_xy $36, $80 ; $63fd
	ld_oam bc, 2, $0e ; $6401
	call QueueSpriteTemplate ; $6404
	ret ; $6407

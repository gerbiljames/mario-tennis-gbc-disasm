QueueSprite32x32:
	bit 5, b ; $2ced
	jr nz, .bit5Set ; $2cef
	ld a, h ; $2cf1
	add d ; $2cf2
	ldh [hSpriteBlitX], a ; $2cf3
	ld a, l ; $2cf5
	add e ; $2cf6
	ldh [hSpriteBlitY], a ; $2cf7
	ld a, [wSpriteBufferPage] ; $2cf9
	ld h, a ; $2cfc
	ldh a, [hSpriteQueueIndex] ; $2cfd
	ld l, a ; $2cff
	ld_xy de, $00, $00 ; $2d00
	call QueueSpriteBlockPart ; $2d03
	ld_xy de, $00, $10 ; $2d06
	call QueueSpriteBlockPart ; $2d09
	ld_xy de, $08, $00 ; $2d0c
	call QueueSpriteBlockPart ; $2d0f
	ld_xy de, $08, $10 ; $2d12
	call QueueSpriteBlockPart ; $2d15
	ld_xy de, $10, $00 ; $2d18
	call QueueSpriteBlockPart ; $2d1b
	ld_xy de, $10, $10 ; $2d1e
	call QueueSpriteBlockPart ; $2d21
	ld_xy de, $18, $00 ; $2d24
	call QueueSpriteBlockPart ; $2d27
	ld_xy de, $18, $10 ; $2d2a
	call QueueSpriteBlockPart ; $2d2d
	ld a, l ; $2d30
	ldh [hSpriteQueueIndex], a ; $2d31
	ret ; $2d33
.bit5Set:
	ld a, d ; $2d34
	sub h ; $2d35
	add $08 ; $2d36
	ldh [hSpriteBlitX], a ; $2d38
	ld a, l ; $2d3a
	add e ; $2d3b
	ldh [hSpriteBlitY], a ; $2d3c
	ld a, [wSpriteBufferPage] ; $2d3e
	ld h, a ; $2d41
	ldh a, [hSpriteQueueIndex] ; $2d42
	ld l, a ; $2d44
	ld_xy de, $00, $00 ; $2d45
	call QueueSpriteBlockPart ; $2d48
	ld_xy de, $00, $10 ; $2d4b
	call QueueSpriteBlockPart ; $2d4e
	ld_xy de, $f8, $00 ; $2d51
	call QueueSpriteBlockPart ; $2d54
	ld_xy de, $f8, $10 ; $2d57
	call QueueSpriteBlockPart ; $2d5a
	ld_xy de, $f0, $00 ; $2d5d
	call QueueSpriteBlockPart ; $2d60
	ld_xy de, $f0, $10 ; $2d63
	call QueueSpriteBlockPart ; $2d66
	ld_xy de, $e8, $00 ; $2d69
	call QueueSpriteBlockPart ; $2d6c
	ld_xy de, $e8, $10 ; $2d6f
	call QueueSpriteBlockPart ; $2d72
	ld a, l ; $2d75
	ldh [hSpriteQueueIndex], a ; $2d76
	ret ; $2d78
QueueSpriteBlockPart:
	ld a, l ; $2d79
	cp $a0 ; $2d7a
	ret z ; $2d7c
	ldh a, [hSpriteBlitY] ; $2d7d
	add e ; $2d7f
	ld [hl+], a ; $2d80
	ldh a, [hSpriteBlitX] ; $2d81
	add d ; $2d83
	ld [hl+], a ; $2d84
	ld a, c ; $2d85
	ld [hl+], a ; $2d86
	ld a, b ; $2d87
	ld [hl+], a ; $2d88
	inc c ; $2d89
	inc c ; $2d8a
	ret ; $2d8b
ProjectWorldToScreen:
	ldh a, [hRomBank] ; $2d8c
	push af ; $2d8e
	ld a, BANK(ViewScaleTableA) ; $2d8f
	ldh [hRomBank], a ; $2d91
	ld [rROMB0], a ; $2d93
	push hl ; $2d96
	push de ; $2d97
	ld l, e ; $2d98
	ld h, d ; $2d99
	call MulViewScaleA ; $2d9a
	ld e, l ; $2d9d
	ld d, h ; $2d9e
	ld l, c ; $2d9f
	ld h, b ; $2da0
	call MulViewScaleB ; $2da1
	add hl, de ; $2da4
	pop de ; $2da5
	push hl ; $2da6
	ld l, e ; $2da7
	ld h, d ; $2da8
	call MulViewScaleB ; $2da9
	ld e, l ; $2dac
	ld d, h ; $2dad
	ld l, c ; $2dae
	ld h, b ; $2daf
	call MulViewScaleANeg ; $2db0
	add hl, de ; $2db3
	ld e, l ; $2db4
	ld d, h ; $2db5
	pop bc ; $2db6
	pop hl ; $2db7
	ld a, BANK(PerspectiveScaleTable) ; $2db8
	ldh [hRomBank], a ; $2dba
	ld [rROMB0], a ; $2dbc
	push de ; $2dbf
	push hl ; $2dc0
	ld l, e ; $2dc1
	ld h, d ; $2dc2
	call GetPerspectiveScale ; $2dc3
	ld l, c ; $2dc6
	ld h, b ; $2dc7
	ld a, d ; $2dc8
	call MulHLByASigned ; $2dc9
	add hl, hl ; $2dcc
	ld bc, $0004 ; $2dcd
	add hl, bc ; $2dd0
	add hl, hl ; $2dd1
	add hl, hl ; $2dd2
	ld c, l ; $2dd3
	ld b, h ; $2dd4
	pop hl ; $2dd5
	ld a, d ; $2dd6
	call MulHLByASigned ; $2dd7
	add hl, hl ; $2dda
	ld de, $0004 ; $2ddb
	add hl, de ; $2dde
	add hl, hl ; $2ddf
	add hl, hl ; $2de0
	pop de ; $2de1
	pop af ; $2de2
	ldh [hRomBank], a ; $2de3
	ld [rROMB0], a ; $2de5
	ret ; $2de8
MulViewScaleA:
	bit 7, h ; $2de9
	jr nz, .negative ; $2deb
	res 0, l ; $2ded
	ld a, h ; $2def
	and $1f ; $2df0
	add HIGH(ViewScaleTableA) ; $2df2
	ld h, a ; $2df4
	ld a, [hl+] ; $2df5
	ld h, [hl] ; $2df6
	ld l, a ; $2df7
	ret ; $2df8
.negative:
	xor a ; $2df9
	sub l ; $2dfa
	ld l, a ; $2dfb
	sbc a ; $2dfc
	sub h ; $2dfd
	ld h, a ; $2dfe
	res 0, l ; $2dff
	ld a, h ; $2e01
	and $1f ; $2e02
	add HIGH(ViewScaleTableA) ; $2e04
	ld h, a ; $2e06
	ld a, [hl+] ; $2e07
	ld h, [hl] ; $2e08
	ld l, a ; $2e09
	xor a ; $2e0a
	sub l ; $2e0b
	ld l, a ; $2e0c
	sbc a ; $2e0d
	sub h ; $2e0e
	ld h, a ; $2e0f
	ret ; $2e10
MulViewScaleANeg:
	bit 7, h ; $2e11
	jr nz, .negative ; $2e13
	res 0, l ; $2e15
	ld a, h ; $2e17
	and $1f ; $2e18
	add HIGH(ViewScaleTableA) ; $2e1a
	ld h, a ; $2e1c
	ld a, [hl+] ; $2e1d
	ld h, [hl] ; $2e1e
	ld l, a ; $2e1f
	xor a ; $2e20
	sub l ; $2e21
	ld l, a ; $2e22
	sbc a ; $2e23
	sub h ; $2e24
	ld h, a ; $2e25
	ret ; $2e26
.negative:
	xor a ; $2e27
	sub l ; $2e28
	ld l, a ; $2e29
	sbc a ; $2e2a
	sub h ; $2e2b
	ld h, a ; $2e2c
	res 0, l ; $2e2d
	ld a, h ; $2e2f
	and $1f ; $2e30
	add HIGH(ViewScaleTableA) ; $2e32
	ld h, a ; $2e34
	ld a, [hl+] ; $2e35
	ld h, [hl] ; $2e36
	ld l, a ; $2e37
	ret ; $2e38
MulViewScaleB:
	bit 7, h ; $2e39
	jr nz, .negative ; $2e3b
	res 0, l ; $2e3d
	ld a, h ; $2e3f
	and $1f ; $2e40
	add HIGH(ViewScaleTableB) ; $2e42
	ld h, a ; $2e44
	ld a, [hl+] ; $2e45
	ld h, [hl] ; $2e46
	ld l, a ; $2e47
	ret ; $2e48
.negative:
	xor a ; $2e49
	sub l ; $2e4a
	ld l, a ; $2e4b
	sbc a ; $2e4c
	sub h ; $2e4d
	ld h, a ; $2e4e
	res 0, l ; $2e4f
	ld a, h ; $2e51
	and $1f ; $2e52
	add HIGH(ViewScaleTableB) ; $2e54
	ld h, a ; $2e56
	ld a, [hl+] ; $2e57
	ld h, [hl] ; $2e58
	ld l, a ; $2e59
	xor a ; $2e5a
	sub l ; $2e5b
	ld l, a ; $2e5c
	sbc a ; $2e5d
	sub h ; $2e5e
	ld h, a ; $2e5f
	ret ; $2e60
GetPerspectiveScale:
	ld a, h ; $2e61
	add $20 ; $2e62
	and $3f ; $2e64
	ld h, a ; $2e66
	set 6, h ; $2e67
	ld d, [hl] ; $2e69
	ret ; $2e6a
QueueCharFrameTiles:
	ldh a, [hRomBank] ; $2e6b
	push af ; $2e6d
	ld a, [wCharObjectBank] ; $2e6e
	ldh [hRomBank], a ; $2e71
	ld [rROMB0], a ; $2e73
	ld hl, wCharShadowTablePtr ; $2e76
	ld a, [hl+] ; $2e79
	ld h, [hl] ; $2e7a
	ld l, a ; $2e7b
	add hl, de ; $2e7c
	add hl, de ; $2e7d
	ld a, [hl+] ; $2e7e
	ld [wCharSpriteFrame], a ; $2e7f
	ld a, [hl+] ; $2e82
	ld [wCharSpriteFrame + 1], a ; $2e83
	ld a, [hl+] ; $2e86
	ld [wCharSpriteFrame + 2], a ; $2e87
	ld c, [hl] ; $2e8a
	ld hl, wCharFrameTablePtr ; $2e8b
	ld a, [hl+] ; $2e8e
	ld h, [hl] ; $2e8f
	ld l, a ; $2e90
	add hl, de ; $2e91
	ld a, [hl+] ; $2e92
	ld h, [hl] ; $2e93
	ld l, a ; $2e94
	ld a, [wCharFrameVramDest] ; $2e95
	ld e, a ; $2e98
	ld a, [wCharFrameVramDest + 1] ; $2e99
	ld d, a ; $2e9c
	ld a, [wStandingShadowsEnabled] ; $2e9d
	and a ; $2ea0
	jr nz, .nonZero ; $2ea1
	call QueueVRAMCopy ; $2ea3
.loop:
	pop af ; $2ea6
	ldh [hRomBank], a ; $2ea7
	ld [rROMB0], a ; $2ea9
	ret ; $2eac
.nonZero:
	push de ; $2ead
	push hl ; $2eae
	call QueueVRAMCopy ; $2eaf
	pop hl ; $2eb2
	pop de ; $2eb3
	ld a, [wCharSpriteFrame + 2] ; $2eb4
	and a ; $2eb7
	jr z, .zero ; $2eb8
	ld bc, $0100 ; $2eba
	add hl, bc ; $2ebd
	ld a, $30 ; $2ebe
	add e ; $2ec0
	ld e, a ; $2ec1
	jr nc, .queueTileCopyAdvance ; $2ec2
	inc d ; $2ec4
.queueTileCopyAdvance:
	call QueueTileCopyAdvance ; $2ec5
	ld a, $40 ; $2ec8
	add e ; $2eca
	ld e, a ; $2ecb
	jr nc, .queueTileCopyAdvance2 ; $2ecc
	inc d ; $2ece
.queueTileCopyAdvance2:
	call QueueTileCopyAdvance ; $2ecf
	ld a, $40 ; $2ed2
	add e ; $2ed4
	ld e, a ; $2ed5
	jr nc, .queueTileCopyAdvance3 ; $2ed6
	inc d ; $2ed8
.queueTileCopyAdvance3:
	call QueueTileCopyAdvance ; $2ed9
	ld a, $40 ; $2edc
	add e ; $2ede
	ld e, a ; $2edf
	jr nc, .queueTileCopyAdvance4 ; $2ee0
	inc d ; $2ee2
.queueTileCopyAdvance4:
	call QueueTileCopyAdvance ; $2ee3
	jr .loop ; $2ee6
.zero:
	ld bc, $00c0 ; $2ee8
	add hl, bc ; $2eeb
	ld a, $30 ; $2eec
	add e ; $2eee
	ld e, a ; $2eef
	jr nc, .queueTileCopyAdvance5 ; $2ef0
	inc d ; $2ef2
.queueTileCopyAdvance5:
	call QueueTileCopyAdvance ; $2ef3
	ld a, $40 ; $2ef6
	add e ; $2ef8
	ld e, a ; $2ef9
	jr nc, .queueTileCopyAdvance6 ; $2efa
	inc d ; $2efc
.queueTileCopyAdvance6:
	call QueueTileCopyAdvance ; $2efd
	ld a, $40 ; $2f00
	add e ; $2f02
	ld e, a ; $2f03
	jr nc, .queueTileCopyAdvance7 ; $2f04
	inc d ; $2f06
.queueTileCopyAdvance7:
	call QueueTileCopyAdvance ; $2f07
	jr .loop ; $2f0a
QueueTileCopyAdvance:
	ld c, $01 ; $2f0c
	push de ; $2f0e
	push hl ; $2f0f
	call QueueVRAMCopy ; $2f10
	pop hl ; $2f13
	pop de ; $2f14
	ld bc, $0010 ; $2f15
	add hl, bc ; $2f18
	ret ; $2f19
UpdateSoundEngine:
	ld hl, hSoundEngineBusy ; $2f1a
	ld a, [hl] ; $2f1d
	or a ; $2f1e
	jr nz, .done ; $2f1f
	ld [hl], $01 ; $2f21
	ldh a, [hWramBank] ; $2f23
	push af ; $2f25
	call RunSoundEngine ; $2f26
	pop_wram_bank ; $2f29
	xor a ; $2f2e
	ldh [hSoundEngineBusy], a ; $2f2f
.done:
	ret ; $2f31
ResumeBGM:
	push af ; $2f32
	push bc ; $2f33
	push de ; $2f34
	push hl ; $2f35
	ld hl, hMusic ; $2f36
	bit 0, [hl] ; $2f39
	jr z, .done ; $2f3b
	res 0, [hl] ; $2f3d
	ldh a, [hWramBank] ; $2f3f
	push af ; $2f41
	ld a, [wCurrentBGM] ; $2f42
	call PlaySound ; $2f45
	pop_wram_bank ; $2f48
.done:
	pop hl ; $2f4d
	pop de ; $2f4e
	pop bc ; $2f4f
	pop af ; $2f50
	ret ; $2f51
Unused_00_StopBGMIfPlaying:
	push hl ; $2f52
	ld hl, hMusic ; $2f53
	bit 0, [hl] ; $2f56
	jr z, .done ; $2f58
	res 0, [hl] ; $2f5a
	sound BGM_NONE ; $2f5c
.done:
	pop hl ; $2f5e
	ret ; $2f5f
Unused_00_SyncBGMEnableFlag:
	push af ; $2f60
	push bc ; $2f61
	push de ; $2f62
	push hl ; $2f63
	ld a, [wSoundOptionBits] ; $2f64
	and $01 ; $2f67
	ld c, a ; $2f69
	ldh a, [hMusic] ; $2f6a
	and $fe ; $2f6c
	or c ; $2f6e
	ldh [hMusic], a ; $2f6f
	bit 0, a ; $2f71
	jr z, .done ; $2f73
	ldh a, [hWramBank] ; $2f75
	push af ; $2f77
	xor a ; $2f78
	call PlaySound ; $2f79
	pop_wram_bank ; $2f7c
.done:
	pop hl ; $2f81
	pop de ; $2f82
	pop bc ; $2f83
	pop af ; $2f84
	ret ; $2f85
SetMusicMuted:
	push af ; $2f86
	push bc ; $2f87
	push de ; $2f88
	push hl ; $2f89
	ld b, a ; $2f8a
	xor a ; $2f8b
	ldh [hActiveJingle], a ; $2f8c
	ldh a, [hWramBank] ; $2f8e
	push af ; $2f90
	ld a, b ; $2f91
	and $01 ; $2f92
	ld c, a ; $2f94
	ldh a, [hMusic] ; $2f95
	and $fe ; $2f97
	or c ; $2f99
	ldh [hMusic], a ; $2f9a
	bit 0, a ; $2f9c
	jr nz, .mute ; $2f9e
	ld a, [wCurrentBGM] ; $2fa0
	jr .apply ; $2fa3
.mute:
	xor a ; $2fa5
.apply:
	call PlaySound ; $2fa6
	pop_wram_bank ; $2fa9
	pop hl ; $2fae
	pop de ; $2faf
	pop bc ; $2fb0
	pop af ; $2fb1
	ret ; $2fb2

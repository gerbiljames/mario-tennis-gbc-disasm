Unused_00_WaitFadeEndLinked:
	push af ; $1dbd
.loop:
	ldh a, [hFadeState] ; $1dbe
	and a ; $1dc0
	jr z, .done ; $1dc1
	push af ; $1dc3
	farcall SyncLinkFrame ; $1dc4
	pop af ; $1dc7
	jr .loop ; $1dc8
.done:
	pop af ; $1dca
	ret ; $1dcb
Unused_00_ApplyWhiteFade:
	push af ; $1dcc
	ld a, c ; $1dcd
	and $78 ; $1dce
	ld d, a ; $1dd0
	rrca ; $1dd1
	rrca ; $1dd2
	ld e, a ; $1dd3
	swap a ; $1dd4
	rrca ; $1dd6
	ld l, a ; $1dd7
	ld h, $00 ; $1dd8
	add hl, hl ; $1dda
	add hl, hl ; $1ddb
	add hl, de ; $1ddc
	ld d, h ; $1ddd
	ld e, l ; $1dde
	ld hl, wMasterPalettes ; $1ddf
	ld bc, wBGPalettes ; $1de2
	ld a, $40 ; $1de5
.loop:
	push af ; $1de7
	push de ; $1de8
	push bc ; $1de9
	ld a, [hl+] ; $1dea
	and $df ; $1deb
	add e ; $1ded
	ld c, a ; $1dee
	ld a, [hl+] ; $1def
	res 2, a ; $1df0
	adc d ; $1df2
	ld b, a ; $1df3
	bit 7, a ; $1df4
	jr z, .positive ; $1df6
	or $78 ; $1df8
.positive:
	bit 2, a ; $1dfa
	jr z, .bit2Clear ; $1dfc
	and $fc ; $1dfe
	dec a ; $1e00
	set 7, c ; $1e01
	set 6, c ; $1e03
.bit2Clear:
	ld b, a ; $1e05
	ld a, c ; $1e06
	bit 5, a ; $1e07
	jr z, .restore ; $1e09
	and $e0 ; $1e0b
	dec a ; $1e0d
.restore:
	pop de ; $1e0e
	ld [de], a ; $1e0f
	inc de ; $1e10
	ld a, b ; $1e11
	ld [de], a ; $1e12
	inc de ; $1e13
	ld b, d ; $1e14
	ld c, e ; $1e15
	pop de ; $1e16
	pop af ; $1e17
	dec a ; $1e18
	jr nz, .loop ; $1e19
	pop af ; $1e1b
	ret ; $1e1c
ClearSpriteQueue:
	xor a ; $1e1d
	ldh [hSpriteQueueIndex], a ; $1e1e
	ldh [hSpriteQueueBase], a ; $1e20
ClearUnusedSprites:
	ldh a, [hSpriteQueueBase] ; $1e22
	ldh [hSpriteQueueIndex], a ; $1e24
	ld l, a ; $1e26
	ld a, [wSpriteBufferPage] ; $1e27
	ld h, a ; $1e2a
	ld a, $a0 ; $1e2b
	sub l ; $1e2d
	ret z ; $1e2e
	srl a ; $1e2f
	srl a ; $1e31
	ld c, a ; $1e33
	xor a ; $1e34
.loop:
	ld [hl+], a ; $1e35
	ld [hl+], a ; $1e36
	ld [hl+], a ; $1e37
	ld [hl+], a ; $1e38
	dec c ; $1e39
	jr nz, .loop ; $1e3a
	ret ; $1e3c
ClearBothSpriteBuffers:
	call ClearSpriteQueue ; $1e3d
	ld a, [wSpriteBufferPage] ; $1e40
	push af ; $1e43
	and $cf ; $1e44
	xor $05 ; $1e46
	ld [wSpriteBufferPage], a ; $1e48
	call ClearSpriteQueue ; $1e4b
	pop af ; $1e4e
	ret ; $1e4f
Unused_00_SetSpriteQueueBase:
	ldh a, [hSpriteQueueIndex] ; $1e50
	ldh [hSpriteQueueBase], a ; $1e52
	ret ; $1e54
QueueSprite16:
	ldh a, [hSpriteQueueIndex] ; $1e55
	cp $a0 ; $1e57
	ret z ; $1e59
	ld l, a ; $1e5a
	ld a, [wSpriteBufferPage] ; $1e5b
	ld h, a ; $1e5e
	bit 5, b ; $1e5f
	jr nz, .mirrored ; $1e61
	ld [hl], e ; $1e63
	inc l ; $1e64
	ld [hl], d ; $1e65
	inc l ; $1e66
	ld [hl], c ; $1e67
	inc l ; $1e68
	ld [hl], b ; $1e69
	inc l ; $1e6a
	inc c ; $1e6b
	inc c ; $1e6c
	ld a, l ; $1e6d
	cp $a0 ; $1e6e
	jr z, .store ; $1e70
	ld [hl], e ; $1e72
	inc l ; $1e73
	ld a, d ; $1e74
	add $08 ; $1e75
	ld [hl+], a ; $1e77
	ld [hl], c ; $1e78
	inc l ; $1e79
	ld [hl], b ; $1e7a
	inc l ; $1e7b
	ld a, l ; $1e7c
.store:
	ldh [hSpriteQueueIndex], a ; $1e7d
	ret ; $1e7f
.mirrored:
	ld [hl], e ; $1e80
	inc l ; $1e81
	ld a, d ; $1e82
	add $08 ; $1e83
	ld [hl+], a ; $1e85
	ld [hl], c ; $1e86
	inc l ; $1e87
	ld [hl], b ; $1e88
	inc l ; $1e89
	inc c ; $1e8a
	inc c ; $1e8b
	ld a, l ; $1e8c
	cp $a0 ; $1e8d
	jr z, .store ; $1e8f
	ld [hl], e ; $1e91
	inc l ; $1e92
	ld [hl], d ; $1e93
	inc l ; $1e94
	ld [hl], c ; $1e95
	inc l ; $1e96
	ld [hl], b ; $1e97
	inc l ; $1e98
	ld a, l ; $1e99
	ldh [hSpriteQueueIndex], a ; $1e9a
	ret ; $1e9c
QueueSpriteTemplate:
	add sp, -4 ; $1e9d
	push hl ; $1e9f
	ld hl, sp + 2 ; $1ea0
	ld a, e ; $1ea2
	ld [hl+], a ; $1ea3
	ld a, d ; $1ea4
	ld [hl+], a ; $1ea5
	ld a, c ; $1ea6
	ld [hl+], a ; $1ea7
	ld [hl], b ; $1ea8
	pop de ; $1ea9
	bit 5, b ; $1eaa
	jr nz, .mirrored ; $1eac
	ld a, [wSpriteBufferPage] ; $1eae
	ld b, a ; $1eb1
	ldh a, [hSpriteQueueIndex] ; $1eb2
	ld c, a ; $1eb4
.copyLoop:
	ld a, c ; $1eb5
	cp $a0 ; $1eb6
	jr z, .done ; $1eb8
	ld a, [de] ; $1eba
	cp $80 ; $1ebb
	jr z, .done ; $1ebd
	ld hl, sp + 0 ; $1ebf
	add [hl] ; $1ec1
	ld [bc], a ; $1ec2
	inc c ; $1ec3
	inc de ; $1ec4
	inc hl ; $1ec5
	ld a, [de] ; $1ec6
	add [hl] ; $1ec7
	ld [bc], a ; $1ec8
	inc c ; $1ec9
	inc de ; $1eca
	inc hl ; $1ecb
	ld a, [de] ; $1ecc
	add [hl] ; $1ecd
	ld [bc], a ; $1ece
	inc c ; $1ecf
	inc de ; $1ed0
	inc hl ; $1ed1
	ld a, [de] ; $1ed2
	add [hl] ; $1ed3
	ld [bc], a ; $1ed4
	inc c ; $1ed5
	inc de ; $1ed6
	jr .copyLoop ; $1ed7
.mirrored:
	ld a, [wSpriteBufferPage] ; $1ed9
	ld b, a ; $1edc
	ldh a, [hSpriteQueueIndex] ; $1edd
	ld c, a ; $1edf
.mirrorLoop:
	ld a, c ; $1ee0
	cp $a0 ; $1ee1
	jr z, .done ; $1ee3
	ld a, [de] ; $1ee5
	cp $80 ; $1ee6
	jr z, .done ; $1ee8
	ld hl, sp + 0 ; $1eea
	add [hl] ; $1eec
	ld [bc], a ; $1eed
	inc c ; $1eee
	inc de ; $1eef
	inc hl ; $1ef0
	ld a, [de] ; $1ef1
	cpl ; $1ef2
	add $09 ; $1ef3
	add [hl] ; $1ef5
	ld [bc], a ; $1ef6
	inc c ; $1ef7
	inc de ; $1ef8
	inc hl ; $1ef9
	ld a, [de] ; $1efa
	add [hl] ; $1efb
	ld [bc], a ; $1efc
	inc c ; $1efd
	inc de ; $1efe
	inc hl ; $1eff
	ld a, [de] ; $1f00
	or [hl] ; $1f01
	ld [bc], a ; $1f02
	inc c ; $1f03
	inc de ; $1f04
	jr .mirrorLoop ; $1f05
.done:
	ld a, c ; $1f07
	ldh [hSpriteQueueIndex], a ; $1f08
	add sp, 4 ; $1f0a
	ret ; $1f0c
Unused_00_QueueSpriteGrid:
	push af ; $1f0d
	push bc ; $1f0e
	push de ; $1f0f
	push hl ; $1f10
	push hl ; $1f11
	ld hl, $0810 ; $1f12
	add hl, de ; $1f15
	ld d, h ; $1f16
	ld e, l ; $1f17
	pop hl ; $1f18
.rowLoop:
	push de ; $1f19
	push hl ; $1f1a
.colLoop:
	ldh a, [hSpriteQueueIndex] ; $1f1b
	cp $a0 ; $1f1d
	jr nz, .store ; $1f1f
	add sp, 4 ; $1f21
	pop hl ; $1f23
	pop de ; $1f24
	pop bc ; $1f25
	pop af ; $1f26
	ret ; $1f27
.store:
	push hl ; $1f28
	ld l, a ; $1f29
	ld a, [wSpriteBufferPage] ; $1f2a
	ld h, a ; $1f2d
	ld [hl], e ; $1f2e
	inc l ; $1f2f
	ld [hl], d ; $1f30
	inc l ; $1f31
	ld [hl], c ; $1f32
	inc l ; $1f33
	ld [hl], b ; $1f34
	inc l ; $1f35
	ld a, l ; $1f36
	ldh [hSpriteQueueIndex], a ; $1f37
	pop hl ; $1f39
	inc c ; $1f3a
	inc c ; $1f3b
	ld a, d ; $1f3c
	add $08 ; $1f3d
	ld d, a ; $1f3f
	dec h ; $1f40
	jr nz, .colLoop ; $1f41
	pop hl ; $1f43
	pop de ; $1f44
	ld a, e ; $1f45
	add $10 ; $1f46
	ld e, a ; $1f48
	dec l ; $1f49
	jr nz, .rowLoop ; $1f4a
	pop hl ; $1f4c
	pop de ; $1f4d
	pop bc ; $1f4e
	pop af ; $1f4f
	ret ; $1f50
QueueSprite:
	ldh a, [hSpriteQueueIndex] ; $1f51
	cp $a0 ; $1f53
	ret z ; $1f55
	ld l, a ; $1f56
	ld a, [wSpriteBufferPage] ; $1f57
	ld h, a ; $1f5a
	ld a, e ; $1f5b
	add $0c ; $1f5c
	ld [hl+], a ; $1f5e
	ld a, d ; $1f5f
	add $04 ; $1f60
	ld [hl+], a ; $1f62
	ld a, c ; $1f63
	ld [hl+], a ; $1f64
	ld a, b ; $1f65
	ld [hl+], a ; $1f66
	ld a, l ; $1f67
	ldh [hSpriteQueueIndex], a ; $1f68
	ret ; $1f6a
Unused_00_PositionSpriteWorld:
	push af ; $1f6b
	push bc ; $1f6c
	push de ; $1f6d
	push hl ; $1f6e
	push bc ; $1f6f
	ld a, [wCameraX] ; $1f70
	ld c, a ; $1f73
	ld a, [wCameraX + 1] ; $1f74
	ld b, a ; $1f77
	ld a, l ; $1f78
	sub c ; $1f79
	ld l, a ; $1f7a
	ld a, h ; $1f7b
	sbc b ; $1f7c
	ld h, a ; $1f7d
	ld a, h ; $1f7e
	inc a ; $1f7f
	cp $16 ; $1f80
	jp nc, .restore ; $1f82
	add hl, hl ; $1f85
	add hl, hl ; $1f86
	add hl, hl ; $1f87
	push hl ; $1f88
	ld hl, wCameraY ; $1f89
	ld a, [hl+] ; $1f8c
	ld b, [hl] ; $1f8d
	ld c, a ; $1f8e
	ld l, e ; $1f8f
	ld h, d ; $1f90
	ld a, l ; $1f91
	sub c ; $1f92
	ld l, a ; $1f93
	ld a, h ; $1f94
	sbc b ; $1f95
	ld h, a ; $1f96
	pop de ; $1f97
	ld a, h ; $1f98
	cp $14 ; $1f99
	jp nc, .restore ; $1f9b
	add hl, hl ; $1f9e
	add hl, hl ; $1f9f
	add hl, hl ; $1fa0
	ld e, h ; $1fa1
	pop bc ; $1fa2
	call QueueSprite16 ; $1fa3
	pop hl ; $1fa6
	pop de ; $1fa7
	pop bc ; $1fa8
	pop af ; $1fa9
	ret ; $1faa
.restore:
	pop bc ; $1fab
	pop hl ; $1fac
	pop de ; $1fad
	pop bc ; $1fae
	pop af ; $1faf
	ret ; $1fb0
Unused_00_PositionSpriteWorld2:
	push af ; $1fb1
	push bc ; $1fb2
	push de ; $1fb3
	push hl ; $1fb4
	push bc ; $1fb5
	ld a, [wCameraX] ; $1fb6
	ld c, a ; $1fb9
	ld a, [wCameraX + 1] ; $1fba
	ld b, a ; $1fbd
	ld a, l ; $1fbe
	sub c ; $1fbf
	ld l, a ; $1fc0
	ld a, h ; $1fc1
	sbc b ; $1fc2
	ld h, a ; $1fc3
	ld a, h ; $1fc4
	inc a ; $1fc5
	cp $16 ; $1fc6
	jp nc, .restore ; $1fc8
	add hl, hl ; $1fcb
	add hl, hl ; $1fcc
	add hl, hl ; $1fcd
	push hl ; $1fce
	ld hl, wCameraY ; $1fcf
	ld a, [hl+] ; $1fd2
	ld b, [hl] ; $1fd3
	ld c, a ; $1fd4
	ld l, e ; $1fd5
	ld h, d ; $1fd6
	ld a, l ; $1fd7
	sub c ; $1fd8
	ld l, a ; $1fd9
	ld a, h ; $1fda
	sbc b ; $1fdb
	ld h, a ; $1fdc
	pop de ; $1fdd
	ld a, h ; $1fde
	cp $13 ; $1fdf
	jp nc, .restore ; $1fe1
	add hl, hl ; $1fe4
	add hl, hl ; $1fe5
	add hl, hl ; $1fe6
	ld e, h ; $1fe7
	pop bc ; $1fe8
	call QueueSprite ; $1fe9
	pop hl ; $1fec
	pop de ; $1fed
	pop bc ; $1fee
	pop af ; $1fef
	ret ; $1ff0
.restore:
	pop bc ; $1ff1
	pop hl ; $1ff2
	pop de ; $1ff3
	pop bc ; $1ff4
	pop af ; $1ff5
	ret ; $1ff6

CopyBank1ToBank3Buffer:
	wram_bank WRAM_STAGING ; $6be1
	ld d, [hl] ; $6be7
	wram_bank WRAM_SCREEN ; $6be8
	ld [hl], d ; $6bee
	inc hl ; $6bef
	dec bc ; $6bf0
	ld a, b ; $6bf1
	or c ; $6bf2
	jr nz, CopyBank1ToBank3Buffer ; $6bf3
	ret ; $6bf5
CopyBank1ToBank2Buffer:
	wram_bank WRAM_STAGING ; $6bf6
	ld d, [hl] ; $6bfc
	wram_bank WRAM_COURT_PLANES ; $6bfd
	ld [hl], d ; $6c03
	inc hl ; $6c04
	dec bc ; $6c05
	ld a, b ; $6c06
	or c ; $6c07
	jr nz, CopyBank1ToBank2Buffer ; $6c08
	ret ; $6c0a
InitCharViewerState:
	wram_bank WRAM_SCENE ; $6c0b
	xor a ; $6c11
	ld [wCharViewerCursor], a ; $6c12
	ld [wCharViewerRow], a ; $6c15
	ld [wCharViewerSavedCursor], a ; $6c18
	ld [wCharViewerPose], a ; $6c1b
	ld a, [wCharViewerCharId] ; $6c1e
	farcall GetCharPaletteIndex ; $6c21
	ld [wCharViewerPalette], a ; $6c24
	ret ; $6c27
DrawCharViewerCursorSprite:
	wram_bank WRAM_SCENE ; $6c28
	ld a, [wCharViewerRow] ; $6c2e
	or a ; $6c31
	jr nz, .nonZero ; $6c32
	ld a, [wCharViewerCursor] ; $6c34
	rlca ; $6c37
	ld_hl_indexed DrawCharViewerCursorSpriteTable0 ; $6c38
	ld a, [hl+] ; $6c3f
	ld d, [hl] ; $6c40
	ld e, a ; $6c41
	jr .queueSprite ; $6c42
.nonZero:
	ld a, [wCharViewerCursor] ; $6c44
	rlca ; $6c47
	ld_hl_indexed DrawCharViewerCursorSpriteTable1 ; $6c48
	ld a, [hl+] ; $6c4f
	ld d, [hl] ; $6c50
	ld e, a ; $6c51
.queueSprite:
	push de ; $6c52
	ldh a, [hVBlankCounter] ; $6c53
	ld b, $0d ; $6c55
	ld c, $80 ; $6c57
	call QueueSprite ; $6c59
	pop de ; $6c5c
	ld a, $08 ; $6c5d
	add d ; $6c5f
	ld d, a ; $6c60
	ld b, $0d ; $6c61
	ld c, $82 ; $6c63
	call QueueSprite ; $6c65
	ret ; $6c68
DrawCharViewerCursorSpriteTable0:
	; $6c69, 44 bytes (bytes:16)
	db $50, $38, $50, $40, $50, $48, $50, $50, $50, $58, $50, $60, $50, $68, $50, $70 ; 0x00
	db $50, $78, $50, $80, $50, $88, $58, $38, $58, $40, $58, $48, $58, $50, $58, $58 ; 0x10
	db $58, $60, $58, $68, $58, $70, $58, $78, $58, $80, $58, $88 ; 0x20
DrawCharViewerCursorSpriteTable1:
	INCBIN "data/bank_01a/DrawCharViewerCursorSpriteTable1.bin" ; $6c95, 10 bytes
RunCharViewerInputLoop:
	call DrawCharViewerCharSprite ; $6c9f
	wram_bank WRAM_SCENE ; $6ca2
	call AdvanceFrame ; $6ca8
	ldh a, [hInputPressed] ; $6cab
	bit PADB_UP, a ; $6cad
	jr nz, .up ; $6caf
	bit 7, a ; $6cb1
	jr nz, .down ; $6cb3
	bit 5, a ; $6cb5
	jp nz, .left ; $6cb7
	bit 4, a ; $6cba
	jp nz, .right ; $6cbc
	bit 0, a ; $6cbf
	jp nz, .confirm ; $6cc1
	bit 1, a ; $6cc4
	jp nz, .exit ; $6cc6
	bit 3, a ; $6cc9
	jp nz, .prevPose ; $6ccb
	bit 2, a ; $6cce
	jp nz, .nextPose ; $6cd0
	jr RunCharViewerInputLoop ; $6cd3
.up:
	sound SFX_MENU_MOVE ; $6cd5
	wram_bank WRAM_SCENE ; $6cd7
	ld a, [wCharViewerRow] ; $6cdd
	or a ; $6ce0
	jr nz, .upWrapToChar ; $6ce1
	ld a, [wCharViewerCursor] ; $6ce3
	cp $0b ; $6ce6
	jr c, .upWrapToPalette ; $6ce8
	ld a, [wCharViewerCursor] ; $6cea
	sub $0b ; $6ced
	ld [wCharViewerCursor], a ; $6cef
	jp .refresh ; $6cf2
.upWrapToPalette:
	wram_bank WRAM_SCENE ; $6cf5
	ld a, [wCharViewerRow] ; $6cfb
	xor $01 ; $6cfe
	ld [wCharViewerRow], a ; $6d00
	ld a, [wCharViewerPalette] ; $6d03
	ld [wCharViewerCursor], a ; $6d06
	jp .refresh ; $6d09
.upWrapToChar:
	wram_bank WRAM_SCENE ; $6d0c
	ld a, [wCharViewerRow] ; $6d12
	xor $01 ; $6d15
	ld [wCharViewerRow], a ; $6d17
	ld a, [wCharViewerSavedCursor] ; $6d1a
	ld [wCharViewerCursor], a ; $6d1d
	jp .refresh ; $6d20
.down:
	sound SFX_MENU_MOVE ; $6d23
	wram_bank WRAM_SCENE ; $6d25
	ld a, [wCharViewerRow] ; $6d2b
	or a ; $6d2e
	jr nz, .downWrapToChar ; $6d2f
	ld a, [wCharViewerCursor] ; $6d31
	cp $0b ; $6d34
	jr nc, .downWrapToPalette ; $6d36
	ld a, [wCharViewerCursor] ; $6d38
	add $0b ; $6d3b
	ld [wCharViewerCursor], a ; $6d3d
	jp .refresh ; $6d40
.downWrapToPalette:
	wram_bank WRAM_SCENE ; $6d43
	ld a, [wCharViewerRow] ; $6d49
	xor $01 ; $6d4c
	ld [wCharViewerRow], a ; $6d4e
	ld a, [wCharViewerPalette] ; $6d51
	ld [wCharViewerCursor], a ; $6d54
	jp .refresh ; $6d57
.downWrapToChar:
	wram_bank WRAM_SCENE ; $6d5a
	ld a, [wCharViewerRow] ; $6d60
	xor $01 ; $6d63
	ld [wCharViewerRow], a ; $6d65
	ld a, [wCharViewerSavedCursor] ; $6d68
	ld [wCharViewerCursor], a ; $6d6b
	jp .refresh ; $6d6e
.left:
	sound SFX_MENU_MOVE ; $6d71
	wram_bank WRAM_SCENE ; $6d73
	ld a, [wCharViewerRow] ; $6d79
	or a ; $6d7c
	jr nz, .leftPalette ; $6d7d
	ld a, [wCharViewerCursor] ; $6d7f
	dec a ; $6d82
	ld [wCharViewerCursor], a ; $6d83
	cp $ff ; $6d86
	jr nz, .leftWrapRow ; $6d88
	ld a, $0a ; $6d8a
	ld [wCharViewerCursor], a ; $6d8c
	jp .refresh ; $6d8f
.leftWrapRow:
	cp $0a ; $6d92
	jp nz, .refresh ; $6d94
	ld a, $15 ; $6d97
	ld [wCharViewerCursor], a ; $6d99
	jp .refresh ; $6d9c
.leftPalette:
	ld a, [wCharViewerCursor] ; $6d9f
	dec a ; $6da2
	cp $ff ; $6da3
	jr nz, .storeLeftPalette ; $6da5
	ld a, $04 ; $6da7
.storeLeftPalette:
	ld [wCharViewerCursor], a ; $6da9
	jr .refresh ; $6dac
.right:
	sound SFX_MENU_MOVE ; $6dae
	wram_bank WRAM_SCENE ; $6db0
	ld a, [wCharViewerRow] ; $6db6
	or a ; $6db9
	jr nz, .rightPalette ; $6dba
	ld a, [wCharViewerCursor] ; $6dbc
	inc a ; $6dbf
	ld [wCharViewerCursor], a ; $6dc0
	cp $0b ; $6dc3
	jr nz, .rightWrapRow ; $6dc5
	xor a ; $6dc7
	ld [wCharViewerCursor], a ; $6dc8
.rightWrapRow:
	cp $16 ; $6dcb
	jr nz, .refresh ; $6dcd
	ld a, $0b ; $6dcf
	ld [wCharViewerCursor], a ; $6dd1
	jr .refresh ; $6dd4
.rightPalette:
	ld a, [wCharViewerCursor] ; $6dd6
	inc a ; $6dd9
	cp $05 ; $6dda
	jr nz, .storeRightPalette ; $6ddc
	xor a ; $6dde
.storeRightPalette:
	ld [wCharViewerCursor], a ; $6ddf
	jr .refresh ; $6de2
.confirm:
	sound SFX_MENU_MOVE ; $6de4
	wram_bank WRAM_SCENE ; $6de6
	ld a, [wCharViewerRow] ; $6dec
	or a ; $6def
	jr nz, .selectPalette ; $6df0
	ld a, [wCharViewerCursor] ; $6df2
	ld [wCharViewerSavedCursor], a ; $6df5
	ld hl, CharViewerInputLoopTable ; $6df8
	add l ; $6dfb
	ld l, a ; $6dfc
	jr nc, .readAnimId ; $6dfd
	inc h ; $6dff
.readAnimId:
	ld d, [hl] ; $6e00
	wram_bank WRAM_ACTORS ; $6e01
	farcall SetCharAnimation ; $6e07
	wram_bank WRAM_SCENE ; $6e0a
	jr .refresh ; $6e10
.selectPalette:
	ld a, [wCharViewerCursor] ; $6e12
	ld [wCharViewerPalette], a ; $6e15
	call ApplyCharViewerPalette ; $6e18
	jr .refresh ; $6e1b
.exit:
	sound SFX_MENU_CANCEL ; $6e1d
	ret ; $6e1f
.refresh:
	call RefreshCharViewerSelection ; $6e20
	call AdvanceFrame ; $6e23
	jp RunCharViewerInputLoop ; $6e26
.prevPose:
	ld a, [wCharViewerPose] ; $6e29
	dec a ; $6e2c
	and $07 ; $6e2d
	ld [wCharViewerPose], a ; $6e2f
	jp RunCharViewerInputLoop ; $6e32
.nextPose:
	ld a, [wCharViewerPose] ; $6e35
	inc a ; $6e38
	and $07 ; $6e39
	ld [wCharViewerPose], a ; $6e3b
	jp RunCharViewerInputLoop ; $6e3e
RefreshCharViewerSelection:
	wram_bank WRAM_COURT_PLANES ; $6e41
	ld a, $09 ; $6e47
	ld hl, wScreenAttrmap + 9 * TILEMAP_WIDTH + 8 ; $6e49
	ld [hl+], a ; $6e4c
	ld [hl+], a ; $6e4d
	ld [hl+], a ; $6e4e
	ld [hl+], a ; $6e4f
	ld [hl+], a ; $6e50
	ld [hl+], a ; $6e51
	ld [hl+], a ; $6e52
	ld [hl+], a ; $6e53
	ld [hl+], a ; $6e54
	ld [hl+], a ; $6e55
	ld [hl+], a ; $6e56
	ld hl, wScreenAttrmap + 10 * TILEMAP_WIDTH + 8 ; $6e57
	ld [hl+], a ; $6e5a
	ld [hl+], a ; $6e5b
	ld [hl+], a ; $6e5c
	ld [hl+], a ; $6e5d
	ld [hl+], a ; $6e5e
	ld [hl+], a ; $6e5f
	ld [hl+], a ; $6e60
	ld [hl+], a ; $6e61
	ld [hl+], a ; $6e62
	ld [hl+], a ; $6e63
	ld [hl+], a ; $6e64
	ld hl, wScreenAttrmap + 14 * TILEMAP_WIDTH + 8 ; $6e65
	ld [hl+], a ; $6e68
	ld [hl+], a ; $6e69
	ld [hl+], a ; $6e6a
	ld [hl+], a ; $6e6b
	ld [hl+], a ; $6e6c
	wram_bank WRAM_SCENE ; $6e6d
	ld a, [wCharViewerSavedCursor] ; $6e73
	cp $0b ; $6e76
	jr nc, .ge0b ; $6e78
	add $28 ; $6e7a
	ld l, a ; $6e7c
	adc $d1 ; $6e7d
	sub l ; $6e7f
	ld h, a ; $6e80
	jr .queueVRAMCopy ; $6e81
.ge0b:
	sub $0b ; $6e83
	add $48 ; $6e85
	ld l, a ; $6e87
	adc $d1 ; $6e88
	sub l ; $6e8a
	ld h, a ; $6e8b
.queueVRAMCopy:
	wram_bank WRAM_COURT_PLANES ; $6e8c
	ld a, $08 ; $6e92
	ld [hl], a ; $6e94
	ld hl, wScreenAttrmap + 9 * TILEMAP_WIDTH ; $6e95
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $6e98
	ld c, $04 ; $6e9b
	call QueueVRAMCopy ; $6e9d
	wram_bank WRAM_SCENE ; $6ea0
	ld a, [wCharViewerPalette] ; $6ea6
	add $c8 ; $6ea9
	ld l, a ; $6eab
	adc $d1 ; $6eac
	sub l ; $6eae
	ld h, a ; $6eaf
	wram_bank WRAM_COURT_PLANES ; $6eb0
	ld a, $08 ; $6eb6
	ld [hl], a ; $6eb8
	ld hl, wScreenAttrmap + 14 * TILEMAP_WIDTH ; $6eb9
	ld de, vBGMap0 + 14 * TILEMAP_WIDTH + VRAM_BANK1 ; $6ebc
	ld c, $02 ; $6ebf
	call QueueVRAMCopy ; $6ec1
	wram_bank WRAM_SCREEN ; $6ec4
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH + 1 ; $6eca
	ld a, $20 ; $6ecd
	ld [hl+], a ; $6ecf
	ld [hl+], a ; $6ed0
	ld [hl+], a ; $6ed1
	ld [hl+], a ; $6ed2
	ld [hl+], a ; $6ed3
	ld [hl+], a ; $6ed4
	ld [hl+], a ; $6ed5
	ld [hl+], a ; $6ed6
	ld [hl+], a ; $6ed7
	ld [hl+], a ; $6ed8
	ld [hl+], a ; $6ed9
	ld [hl+], a ; $6eda
	ld [hl+], a ; $6edb
	ld [hl+], a ; $6edc
	ld [hl+], a ; $6edd
	ld [hl+], a ; $6ede
	ld hl, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6edf
	ld [hl+], a ; $6ee2
	ld [hl+], a ; $6ee3
	ld [hl+], a ; $6ee4
	ld [hl+], a ; $6ee5
	ld [hl+], a ; $6ee6
	ld [hl+], a ; $6ee7
	ld [hl+], a ; $6ee8
	ld [hl+], a ; $6ee9
	ld [hl+], a ; $6eea
	ld [hl+], a ; $6eeb
	ld [hl+], a ; $6eec
	ld [hl+], a ; $6eed
	ld [hl+], a ; $6eee
	ld [hl+], a ; $6eef
	ld [hl+], a ; $6ef0
	ld [hl+], a ; $6ef1
	wram_bank WRAM_SCENE ; $6ef2
	ld a, [wCharViewerRow] ; $6ef8
	or a ; $6efb
	jr nz, .nonZero ; $6efc
	ld a, [wCharViewerCursor] ; $6efe
	add $01 ; $6f01
	add $c0 ; $6f03
	ld l, a ; $6f05
	adc $10 ; $6f06
	sub l ; $6f08
	ld h, a ; $6f09
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6f0a
	ld c, $20 ; $6f0d
	wram_bank WRAM_SCREEN ; $6f0f
	farcall RenderTextToBuffer64 ; $6f15
	jr .queueVRAMCopy2 ; $6f18
.nonZero:
	wram_bank WRAM_SCREEN ; $6f1a
	ld hl, Text_34_192 ; $6f20
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6f23
	ld c, $20 ; $6f26
	farcall RenderTextToBuffer64 ; $6f28
.queueVRAMCopy2:
	wram_bank WRAM_SCREEN ; $6f2b
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $6f31
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $6f34
	ld c, $04 ; $6f37
	call QueueVRAMCopy ; $6f39
	ret ; $6f3c
SetupCharViewerScene:
	call LoadCharViewerMugshot ; $6f3d
	wram_bank WRAM_SCENE ; $6f40
	ld a, [wCharViewerCharId] ; $6f46
	farcall GetCharObjectId ; $6f49
	ld d, a ; $6f4c
	wram_bank WRAM_ACTORS ; $6f4d
	ldh a, [hRomBank] ; $6f53
	ld hl, CharViewerSceneActors_1a ; $6f55
	farcall SpawnActorsFromList ; $6f58
	ld bc, wActors ; $6f5b
	farcall LoadActorObjectDefIfValid ; $6f5e
	ld bc, wActors + 1 * ACTOR_SIZE ; $6f61
	farcall LoadActorObjectDefIfValid ; $6f64
	ld bc, wActors + 2 * ACTOR_SIZE ; $6f67
	farcall LoadActorObjectDefIfValid ; $6f6a
	ld bc, wActors + 3 * ACTOR_SIZE ; $6f6d
	farcall LoadActorObjectDefIfValid ; $6f70
	ld d, $01 ; $6f73
	ld bc, wActors ; $6f75
	farcall SetActorAnimationChecked ; $6f78
	ld bc, wActors + 1 * ACTOR_SIZE ; $6f7b
	farcall SetActorAnimationChecked ; $6f7e
	ld bc, wActors + 2 * ACTOR_SIZE ; $6f81
	farcall SetActorAnimationChecked ; $6f84
	ld bc, wActors + 3 * ACTOR_SIZE ; $6f87
	farcall SetActorAnimationChecked ; $6f8a
	ld a, $07 ; $6f8d
	ld [wActors + 55], a ; $6f8f
	ld [wActors + 1 * ACTOR_SIZE + 55], a ; $6f92
	ld [wActors + 2 * ACTOR_SIZE + 55], a ; $6f95
	ld [wActors + 3 * ACTOR_SIZE + 55], a ; $6f98
	wram_bank WRAM_CHAR2 ; $6f9b
	ld a, [wCharViewerCharId] ; $6fa1
	ld [wMatchPlayerChar], a ; $6fa4
	ld d, a ; $6fa7
	wram_bank WRAM_CHAR0 ; $6fa8
	ld hl, wCharPosX ; $6fae
	ld c, $10 ; $6fb1
	call ClearMemory16 ; $6fb3
	ld a, $00 ; $6fb6
	farcall InitChar ; $6fb8
	ld a, $07 ; $6fbb
	ld [wCharSpriteAttr], a ; $6fbd
	ld de, $8600 ; $6fc0
	ld hl, wCharFrameVramDest ; $6fc3
	ld a, e ; $6fc6
	ld [hl+], a ; $6fc7
	ld [hl], d ; $6fc8
	ld hl, wCharTileBase ; $6fc9
	ld [hl], $60 ; $6fcc
	ret ; $6fce
CharViewerSceneActors_1a:
	; $6fcf, 66 bytes (map_actors)
	map_actor $0000, ActorScript_1a_CharViewer, $0f00, $0400, FACE_DOWN, OBJ_ALEX, $01, $00, CHAR_VIEWER_SCENE_ALEX_1
	map_actor $0000, ActorScript_1a_CharViewer, $1180, $0400, FACE_LEFT, OBJ_ALEX, $01, $00, CHAR_VIEWER_SCENE_ALEX_2
	map_actor $0000, ActorScript_1a_CharViewer, $0f00, $0680, FACE_UP, OBJ_ALEX, $01, $00, CHAR_VIEWER_SCENE_ALEX_3
	map_actor $0000, ActorScript_1a_CharViewer, $1180, $0680, FACE_RIGHT, OBJ_ALEX, $01, $00, CHAR_VIEWER_SCENE_ALEX_4
	map_actor_end
; A one-opcode actor script, as_halt: the four character-viewer actors stand still.
ActorScript_1a_CharViewer:
	; $7011, 1 bytes (actor_script)
	as_halt

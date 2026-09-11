BuildPartnerStatPage:
	ld a, $01 ; $4b50
	ld [wStoryCharacterSlot], a ; $4b52
	call BuildCharStatDisplay ; $4b55
	wram_bank $06 ; $4b58
	ld a, [wCharDataLevels] ; $4b5e
	ld [wCharStatPagePartner], a ; $4b61
	ld a, [wCharDataLevels + 1] ; $4b64
	ld [wCharStatPagePartner + 1], a ; $4b67
	ld a, [wCharDataLevels + 2] ; $4b6a
	ld [wCharStatPagePartner + 2], a ; $4b6d
	ld a, [wCharDataLevels + 3] ; $4b70
	ld [wCharStatPagePartner + 3], a ; $4b73
	ld hl, PartnerStatPageTilemapPatch01 ; $4b76
	ld bc, wCharDataPagePlane + 8 * TILEMAP_WIDTH ; $4b79
	call ApplyTilemapPatchList ; $4b7c
	ld hl, PartnerStatPageTilemapPatch00 ; $4b7f
	ld bc, wCharDataScreenCell + 28 * TILEMAP_WIDTH ; $4b82
	call ApplyTilemapPatchList ; $4b85
	ld hl, StatPageTilemapPatch1 ; $4b88
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $4b8b
	call ApplyTilemapPatchList ; $4b8e
	ld hl, StatPageTilemapPatch2 ; $4b91
	ld bc, wCharDataScreenCell + 20 * TILEMAP_WIDTH ; $4b94
	call ApplyTilemapPatchList ; $4b97
	ld hl, StatPageTilemapPatch3 ; $4b9a
	ld bc, wCharDataScreenCell + 22 * TILEMAP_WIDTH + 16 ; $4b9d
	call ApplyTilemapPatchList ; $4ba0
	ld hl, StatPageTilemapPatch4 ; $4ba3
	ld bc, wCharDataScreenCell + 24 * TILEMAP_WIDTH + 16 ; $4ba6
	call ApplyTilemapPatchList ; $4ba9
	ld hl, StatPageTilemapPatch5 ; $4bac
	ld bc, wCharDataPagePlane + 9 * TILEMAP_WIDTH + 16 ; $4baf
	call ApplyTilemapPatchList ; $4bb2
	ret ; $4bb5
ApplyTilemapPatchList:
	ld a, [hl] ; $4bb6
	cp $ff ; $4bb7
	ret z ; $4bb9
	push hl ; $4bba
	ld d, [hl] ; $4bbb
	inc hl ; $4bbc
	ld e, [hl] ; $4bbd
	push hl ; $4bbe
	ld hl, wCharDataScreenCell ; $4bbf
	add hl, de ; $4bc2
	ld d, h ; $4bc3
	ld e, l ; $4bc4
	pop hl ; $4bc5
	inc hl ; $4bc6
	push hl ; $4bc7
	ld a, [hl] ; $4bc8
	ld h, b ; $4bc9
	ld l, c ; $4bca
	add l ; $4bcb
	ld l, a ; $4bcc
	jr nc, .gotSrc ; $4bcd
	inc h ; $4bcf
.gotSrc:
	wram_bank $06 ; $4bd0
	ld a, l ; $4bd6
	ld [wCharDataNumberBuffer], a ; $4bd7
	ld a, h ; $4bda
	ld [wCharDataNumberBuffer + 1], a ; $4bdb
	pop hl ; $4bde
	push bc ; $4bdf
	inc hl ; $4be0
	ld c, [hl] ; $4be1
	ld hl, wCharDataNumberBuffer ; $4be2
	ld a, [hl+] ; $4be5
	ld h, [hl] ; $4be6
	ld l, a ; $4be7
.copyLoop:
	wram_bank $03 ; $4be8
	ld a, [hl] ; $4bee
	ld [de], a ; $4bef
	wram_bank $02 ; $4bf0
	ld a, [hl+] ; $4bf6
	ld [de], a ; $4bf7
	inc de ; $4bf8
	dec c ; $4bf9
	jr nz, .copyLoop ; $4bfa
	pop bc ; $4bfc
	pop hl ; $4bfd
	inc hl ; $4bfe
	inc hl ; $4bff
	inc hl ; $4c00
	inc hl ; $4c01
	jr ApplyTilemapPatchList ; $4c02
DrawCharDataPageArrowsTask:
	wram_bank $06 ; $4c04
	ld a, [wCharDataArrowHold] ; $4c0a
	or a ; $4c0d
	jr nz, .nonZero ; $4c0e
	ld hl, wCharDataArrowPhase ; $4c10
	inc [hl] ; $4c13
.nonZero:
	ld a, [wCharDataPageArrowMode] ; $4c14
	or a ; $4c17
	jr z, .zero ; $4c18
	dec a ; $4c1a
	jr z, .countDone ; $4c1b
	ld de, $0103 ; $4c1d
	call BobArrowSpriteLeft ; $4c20
	ld hl, DrawCharDataPageArrowsTask_SpriteTemplate2 ; $4c23
	ld b, $0e ; $4c26
	ld c, $28 ; $4c28
	call QueueSpriteTemplate ; $4c2a
	ret ; $4c2d
.countDone:
	ld de, $7f03 ; $4c2e
	call BobArrowSpriteRight ; $4c31
	ld hl, DrawCharDataPageArrowsTask_SpriteTemplate3 ; $4c34
	ld b, $0e ; $4c37
	ld c, $30 ; $4c39
	call QueueSpriteTemplate ; $4c3b
	ret ; $4c3e
.zero:
	ld de, $1010 ; $4c3f
	call BobArrowSpriteLeft ; $4c42
	ld hl, DrawCharDataPageArrowsTask_SpriteTemplate0 ; $4c45
	ld b, $0e ; $4c48
	ld c, $14 ; $4c4a
	call QueueSpriteTemplate ; $4c4c
	ld de, $6810 ; $4c4f
	call BobArrowSpriteRight ; $4c52
	ld hl, DrawCharDataPageArrowsTask_SpriteTemplate1 ; $4c55
	ld b, $0e ; $4c58
	ld c, $1e ; $4c5a
	call QueueSpriteTemplate ; $4c5c
	ret ; $4c5f
BobArrowSpriteLeft:
	wram_bank $06 ; $4c60
	ld a, [wCharDataArrowPhase] ; $4c66
	rrca ; $4c69
	and $0f ; $4c6a
	ld_hl_indexed CharDataArrowBobOffsetTable_1d ; $4c6c
	ld a, [hl] ; $4c73
	cpl ; $4c74
	inc a ; $4c75
	add d ; $4c76
	ld d, a ; $4c77
	ld a, [wCharDataArrowHold] ; $4c78
	cpl ; $4c7b
	inc a ; $4c7c
	add d ; $4c7d
	ld d, a ; $4c7e
	ret ; $4c7f
BobArrowSpriteRight:
	wram_bank $06 ; $4c80
	ld a, [wCharDataArrowPhase] ; $4c86
	rrca ; $4c89
	and $0f ; $4c8a
	ld_hl_indexed CharDataArrowBobOffsetTable_1d ; $4c8c
	ld a, [hl] ; $4c93
	add d ; $4c94
	ld d, a ; $4c95
	ld a, [wCharDataArrowHold] ; $4c96
	add d ; $4c99
	ld d, a ; $4c9a
	ret ; $4c9b
CharDataArrowBobOffsetTable_1d:
	; $4c9c, 16 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $06, $06, $05, $04, $03, $02, $01, $00, $00 ; 0x00
RunDrillResultInputLoop:
	wram_bank $06 ; $4cac
	ld a, [wCharDataPageArrowMode] ; $4cb2
	or a ; $4cb5
	jr z, .loop ; $4cb6
	dec a ; $4cb8
	jp z, .loopB ; $4cb9
	jp .loop2 ; $4cbc
.loop:
	call AdvanceFrame ; $4cbf
	ldh a, [hInputRisingEdge] ; $4cc2
	bit PADB_RIGHT, a ; $4cc4
	jr nz, .playSfx ; $4cc6
	bit 5, a ; $4cc8
	jp nz, .playSfx2 ; $4cca
	bit 1, a ; $4ccd
	jp nz, .playSfx3 ; $4ccf
	bit 0, a ; $4cd2
	jp nz, .playSfx4 ; $4cd4
	jr .loop ; $4cd7
.playSfx:
	sound SFX_MENU_MOVE ; $4cd9
	ld hl, CharDataScreenBgScrollTask ; $4cdb
	call UnregisterFrameTask ; $4cde
	ld hl, SlideCharDataArrowsInTask ; $4ce1
	call UnregisterFrameTask ; $4ce4
	ld a, $01 ; $4ce7
	ld hl, SlideCharDataArrowsOutTask ; $4ce9
	call RegisterFrameTask ; $4cec
	ld a, $01 ; $4cef
	ld hl, DrawCharStatDigitsTask ; $4cf1
	call RegisterFrameTask ; $4cf4
	wram_bank $06 ; $4cf7
	ld a, [wCharStatPagePartner] ; $4cfd
	ld [wCharDataLevels], a ; $4d00
	ld a, [wCharStatPagePartner + 1] ; $4d03
	ld [wCharDataLevels + 1], a ; $4d06
	ld a, [wCharStatPagePartner + 2] ; $4d09
	ld [wCharDataLevels + 2], a ; $4d0c
	ld a, [wCharStatPagePartner + 3] ; $4d0f
	ld [wCharDataLevels + 3], a ; $4d12
	ld hl, wCharStatPagePartner + 4 ; $4d15
	ld de, wCharStatPageShown ; $4d18
	ld bc, $0006 ; $4d1b
	call CopyMemoryBC ; $4d1e
	call SlideToPartnerStatPage ; $4d21
	wram_bank $06 ; $4d24
	ld a, $02 ; $4d2a
	ld [wCharDataPageArrowMode], a ; $4d2c
	ld a, $01 ; $4d2f
	ld hl, SlideCharDataArrowsInTask ; $4d31
	call RegisterFrameTask ; $4d34
	jp .loop2 ; $4d37
.playSfx2:
	sound SFX_MENU_MOVE ; $4d3a
	ld hl, CharDataScreenBgScrollTask ; $4d3c
	call UnregisterFrameTask ; $4d3f
	ld hl, SlideCharDataArrowsInTask ; $4d42
	call UnregisterFrameTask ; $4d45
	ld a, $01 ; $4d48
	ld hl, SlideCharDataArrowsOutTask ; $4d4a
	call RegisterFrameTask ; $4d4d
	ld a, $01 ; $4d50
	ld hl, DrawCharStatDigitsTask ; $4d52
	call RegisterFrameTask ; $4d55
	wram_bank $06 ; $4d58
	ld a, [wCharStatPageMain] ; $4d5e
	ld [wCharDataLevels], a ; $4d61
	ld a, [wCharStatPageMain + 1] ; $4d64
	ld [wCharDataLevels + 1], a ; $4d67
	ld a, [wCharStatPageMain + 2] ; $4d6a
	ld [wCharDataLevels + 2], a ; $4d6d
	ld a, [wCharStatPageMain + 3] ; $4d70
	ld [wCharDataLevels + 3], a ; $4d73
	ld hl, wCharStatPageMain + 4 ; $4d76
	ld de, wCharStatPageShown ; $4d79
	ld bc, $0006 ; $4d7c
	call CopyMemoryBC ; $4d7f
	call SlideToMainCharStatPage ; $4d82
	wram_bank $06 ; $4d85
	ld a, $01 ; $4d8b
	ld [wCharDataPageArrowMode], a ; $4d8d
	ld a, $01 ; $4d90
	ld hl, SlideCharDataArrowsInTask ; $4d92
	call RegisterFrameTask ; $4d95
	jr .loopB ; $4d98
.playSfx3:
	sound SFX_MENU_CANCEL ; $4d9a
	ret ; $4d9c
.playSfx4:
	sound SFX_MENU_SELECT ; $4d9d
	ret ; $4d9f
.loopB:
	call AdvanceFrame ; $4da0
	ldh a, [hInputRisingEdge] ; $4da3
	bit PADB_RIGHT, a ; $4da5
	jr nz, .playSfx5 ; $4da7
	bit 1, a ; $4da9
	jr nz, .playSfx6 ; $4dab
	bit 0, a ; $4dad
	jr nz, .playSfx7 ; $4daf
	jr .loopB ; $4db1
.playSfx5:
	sound SFX_MENU_MOVE ; $4db3
	ld hl, SlideCharDataArrowsInTask ; $4db5
	call UnregisterFrameTask ; $4db8
	ld a, $01 ; $4dbb
	ld hl, SlideCharDataArrowsOutTask ; $4dbd
	call RegisterFrameTask ; $4dc0
	call SlideFromMainCharStatPage ; $4dc3
	wram_bank $06 ; $4dc6
	xor a ; $4dcc
	ld [wCharDataPageArrowMode], a ; $4dcd
	call ClearFrameTasks ; $4dd0
	ld a, $01 ; $4dd3
	ld hl, CharDataScreenBgScrollTask ; $4dd5
	call RegisterFrameTask ; $4dd8
	ld a, $01 ; $4ddb
	ld hl, SlideCharDataArrowsInTask ; $4ddd
	call RegisterFrameTask ; $4de0
	ld a, $01 ; $4de3
	ld hl, DrawCharDataPageArrowsTask ; $4de5
	call RegisterFrameTask ; $4de8
	ld a, $01 ; $4deb
	ld hl, CharDataValuesSyncTask ; $4ded
	call RegisterFrameTask ; $4df0
	farcall StartCharDataScreenAnimTask ; $4df3
	jp .loop ; $4df6
.playSfx6:
	sound SFX_MENU_CANCEL ; $4df9
	ret ; $4dfb
.playSfx7:
	sound SFX_MENU_SELECT ; $4dfc
	ret ; $4dfe
.loop2:
	call AdvanceFrame ; $4dff
	ldh a, [hInputRisingEdge] ; $4e02
	bit PADB_LEFT, a ; $4e04
	jr nz, .playSfx8 ; $4e06
	bit 1, a ; $4e08
	jr nz, .playSfx9 ; $4e0a
	bit 0, a ; $4e0c
	jr nz, .playSfx10 ; $4e0e
	jr .loop2 ; $4e10
.playSfx8:
	sound SFX_MENU_MOVE ; $4e12
	ld hl, SlideCharDataArrowsInTask ; $4e14
	call UnregisterFrameTask ; $4e17
	ld a, $01 ; $4e1a
	ld hl, SlideCharDataArrowsOutTask ; $4e1c
	call RegisterFrameTask ; $4e1f
	call SlideFromPartnerStatPage ; $4e22
	wram_bank $06 ; $4e25
	xor a ; $4e2b
	ld [wCharDataPageArrowMode], a ; $4e2c
	call ClearFrameTasks ; $4e2f
	ld a, $01 ; $4e32
	ld hl, CharDataScreenBgScrollTask ; $4e34
	call RegisterFrameTask ; $4e37
	ld a, $01 ; $4e3a
	ld hl, SlideCharDataArrowsInTask ; $4e3c
	call RegisterFrameTask ; $4e3f
	ld a, $01 ; $4e42
	ld hl, DrawCharDataPageArrowsTask ; $4e44
	call RegisterFrameTask ; $4e47
	ld a, $01 ; $4e4a
	ld hl, CharDataValuesSyncTask ; $4e4c
	call RegisterFrameTask ; $4e4f
	farcall StartCharDataScreenAnimTask ; $4e52
	jp .loop ; $4e55
.playSfx9:
	sound SFX_MENU_CANCEL ; $4e58
	ret ; $4e5a
.playSfx10:
	sound SFX_MENU_SELECT ; $4e5b
	ret ; $4e5d
SlideCharDataArrowsOutTask:
	wram_bank $06 ; $4e5e
	ld a, [wCharDataArrowHold] ; $4e64
	add $04 ; $4e67
	ld [wCharDataArrowHold], a ; $4e69
	cp $40 ; $4e6c
	ret c ; $4e6e
	ld hl, SlideCharDataArrowsOutTask ; $4e6f
	call UnregisterFrameTask ; $4e72
	ret ; $4e75
SlideCharDataArrowsInTask:
	wram_bank $06 ; $4e76
	ld a, [wCharDataArrowHold] ; $4e7c
	sub $08 ; $4e7f
	ld [wCharDataArrowHold], a ; $4e81
	or a ; $4e84
	ret nz ; $4e85
	ld hl, SlideCharDataArrowsInTask ; $4e86
	call UnregisterFrameTask ; $4e89
	ret ; $4e8c
BuildCharStatDisplay:
	wram_bank $06 ; $4e8d
	push af ; $4e93
	ld hl, wStoryModeNameOfMainCharacter ; $4e94
	ld a, [wStoryCharacterSlot] ; $4e97
	or a ; $4e9a
	jr z, .zero ; $4e9b
	ld l, $40 ; $4e9d
.zero:
	ld a, l ; $4e9f
	add $38 ; $4ea0
	ld l, a ; $4ea2
	ld a, h ; $4ea3
	adc $00 ; $4ea4
	ld h, a ; $4ea6
	pop af ; $4ea7
	ld a, [hl] ; $4ea8
	ld [wCharDataLevels], a ; $4ea9
	push af ; $4eac
	ld hl, wStoryModeNameOfMainCharacter ; $4ead
	ld a, [wStoryCharacterSlot] ; $4eb0
	or a ; $4eb3
	jr z, .zero2 ; $4eb4
	ld l, $40 ; $4eb6
.zero2:
	ld a, l ; $4eb8
	add $20 ; $4eb9
	ld l, a ; $4ebb
	ld a, h ; $4ebc
	adc $00 ; $4ebd
	ld h, a ; $4ebf
	pop af ; $4ec0
	ld a, [hl] ; $4ec1
	inc a ; $4ec2
	ld [wCharDataStats], a ; $4ec3
	push af ; $4ec6
	ld hl, wStoryModeNameOfMainCharacter ; $4ec7
	ld a, [wStoryCharacterSlot] ; $4eca
	or a ; $4ecd
	jr z, .zero3 ; $4ece
	ld l, $40 ; $4ed0
.zero3:
	ld a, l ; $4ed2
	add $21 ; $4ed3
	ld l, a ; $4ed5
	ld a, h ; $4ed6
	adc $00 ; $4ed7
	ld h, a ; $4ed9
	pop af ; $4eda
	ld a, [hl] ; $4edb
	inc a ; $4edc
	ld [wCharDataStats + 1], a ; $4edd
	push af ; $4ee0
	ld hl, wStoryModeNameOfMainCharacter ; $4ee1
	ld a, [wStoryCharacterSlot] ; $4ee4
	or a ; $4ee7
	jr z, .zero4 ; $4ee8
	ld l, $40 ; $4eea
.zero4:
	ld a, l ; $4eec
	add $39 ; $4eed
	ld l, a ; $4eef
	ld a, h ; $4ef0
	adc $00 ; $4ef1
	ld h, a ; $4ef3
	pop af ; $4ef4
	ld a, [hl] ; $4ef5
	ld [wCharDataLevels + 1], a ; $4ef6
	push af ; $4ef9
	ld hl, wStoryModeNameOfMainCharacter ; $4efa
	ld a, [wStoryCharacterSlot] ; $4efd
	or a ; $4f00
	jr z, .zero5 ; $4f01
	ld l, $40 ; $4f03
.zero5:
	ld a, l ; $4f05
	add $22 ; $4f06
	ld l, a ; $4f08
	ld a, h ; $4f09
	adc $00 ; $4f0a
	ld h, a ; $4f0c
	pop af ; $4f0d
	ld a, [hl] ; $4f0e
	inc a ; $4f0f
	ld [wCharDataStats + 2], a ; $4f10
	push af ; $4f13
	ld hl, wStoryModeNameOfMainCharacter ; $4f14
	ld a, [wStoryCharacterSlot] ; $4f17
	or a ; $4f1a
	jr z, .zero6 ; $4f1b
	ld l, $40 ; $4f1d
.zero6:
	ld a, l ; $4f1f
	add $23 ; $4f20
	ld l, a ; $4f22
	ld a, h ; $4f23
	adc $00 ; $4f24
	ld h, a ; $4f26
	pop af ; $4f27
	ld a, [hl] ; $4f28
	inc a ; $4f29
	ld [wCharDataStats + 3], a ; $4f2a
	push af ; $4f2d
	ld hl, wStoryModeNameOfMainCharacter ; $4f2e
	ld a, [wStoryCharacterSlot] ; $4f31
	or a ; $4f34
	jr z, .zero7 ; $4f35
	ld l, $40 ; $4f37
.zero7:
	ld a, l ; $4f39
	add $24 ; $4f3a
	ld l, a ; $4f3c
	ld a, h ; $4f3d
	adc $00 ; $4f3e
	ld h, a ; $4f40
	pop af ; $4f41
	ld a, [hl] ; $4f42
	inc a ; $4f43
	ld [wCharDataStats + 4], a ; $4f44
	push af ; $4f47
	ld hl, wStoryModeNameOfMainCharacter ; $4f48
	ld a, [wStoryCharacterSlot] ; $4f4b
	or a ; $4f4e
	jr z, .zero8 ; $4f4f
	ld l, $40 ; $4f51
.zero8:
	ld a, l ; $4f53
	add $3a ; $4f54
	ld l, a ; $4f56
	ld a, h ; $4f57
	adc $00 ; $4f58
	ld h, a ; $4f5a
	pop af ; $4f5b
	ld a, [hl] ; $4f5c
	ld [wCharDataLevels + 2], a ; $4f5d
	push af ; $4f60
	ld hl, wStoryModeNameOfMainCharacter ; $4f61
	ld a, [wStoryCharacterSlot] ; $4f64
	or a ; $4f67
	jr z, .zero9 ; $4f68
	ld l, $40 ; $4f6a
.zero9:
	ld a, l ; $4f6c
	add $25 ; $4f6d
	ld l, a ; $4f6f
	ld a, h ; $4f70
	adc $00 ; $4f71
	ld h, a ; $4f73
	pop af ; $4f74
	ld a, [hl] ; $4f75
	inc a ; $4f76
	ld [wCharDataStats + 5], a ; $4f77
	push af ; $4f7a
	ld hl, wStoryModeNameOfMainCharacter ; $4f7b
	ld a, [wStoryCharacterSlot] ; $4f7e
	or a ; $4f81
	jr z, .zero10 ; $4f82
	ld l, $40 ; $4f84
.zero10:
	ld a, l ; $4f86
	add $26 ; $4f87
	ld l, a ; $4f89
	ld a, h ; $4f8a
	adc $00 ; $4f8b
	ld h, a ; $4f8d
	pop af ; $4f8e
	ld a, [hl] ; $4f8f
	inc a ; $4f90
	ld [wCharDataStats + 6], a ; $4f91
	push af ; $4f94
	ld hl, wStoryModeNameOfMainCharacter ; $4f95
	ld a, [wStoryCharacterSlot] ; $4f98
	or a ; $4f9b
	jr z, .zero11 ; $4f9c
	ld l, $40 ; $4f9e
.zero11:
	ld a, l ; $4fa0
	add $3b ; $4fa1
	ld l, a ; $4fa3
	ld a, h ; $4fa4
	adc $00 ; $4fa5
	ld h, a ; $4fa7
	pop af ; $4fa8
	ld a, [hl] ; $4fa9
	ld [wCharDataLevels + 3], a ; $4faa
	push af ; $4fad
	ld hl, wStoryModeNameOfMainCharacter ; $4fae
	ld a, [wStoryCharacterSlot] ; $4fb1
	or a ; $4fb4
	jr z, .zero12 ; $4fb5
	ld l, $40 ; $4fb7
.zero12:
	ld a, l ; $4fb9
	add $27 ; $4fba
	ld l, a ; $4fbc
	ld a, h ; $4fbd
	adc $00 ; $4fbe
	ld h, a ; $4fc0
	pop af ; $4fc1
	ld a, [hl] ; $4fc2
	inc a ; $4fc3
	ld [wCharDataStats + 7], a ; $4fc4
	push af ; $4fc7
	ld hl, wStoryModeNameOfMainCharacter ; $4fc8
	ld a, [wStoryCharacterSlot] ; $4fcb
	or a ; $4fce
	jr z, .zero13 ; $4fcf
	ld l, $40 ; $4fd1
.zero13:
	ld a, l ; $4fd3
	add $28 ; $4fd4
	ld l, a ; $4fd6
	ld a, h ; $4fd7
	adc $00 ; $4fd8
	ld h, a ; $4fda
	pop af ; $4fdb
	ld a, [hl] ; $4fdc
	inc a ; $4fdd
	ld [wCharDataStats + 8], a ; $4fde
	push af ; $4fe1
	ld hl, wStoryModeNameOfMainCharacter ; $4fe2
	ld a, [wStoryCharacterSlot] ; $4fe5
	or a ; $4fe8
	jr z, .zero14 ; $4fe9
	ld l, $40 ; $4feb
.zero14:
	ld a, l ; $4fed
	add $29 ; $4fee
	ld l, a ; $4ff0
	ld a, h ; $4ff1
	adc $00 ; $4ff2
	ld h, a ; $4ff4
	pop af ; $4ff5
	ld a, [hl] ; $4ff6
	inc a ; $4ff7
	ld [wCharDataStats + 9], a ; $4ff8
	push af ; $4ffb
	ld hl, wStoryModeNameOfMainCharacter ; $4ffc
	ld a, [wStoryCharacterSlot] ; $4fff
	or a ; $5002
	jr z, .zero15 ; $5003
	ld l, $40 ; $5005
.zero15:
	ld a, l ; $5007
	add $2a ; $5008
	ld l, a ; $500a
	ld a, h ; $500b
	adc $00 ; $500c
	ld h, a ; $500e
	pop af ; $500f
	ld a, [hl] ; $5010
	inc a ; $5011
	ld [wCharDataStats + 10], a ; $5012
	farcall CharDataScreen_DrawStats ; $5015
	wram_bank $03 ; $5018
	ld hl, wCharDataPagePlane + 8 * TILEMAP_WIDTH + 1 ; $501e
	ld a, $a3 ; $5021
	ld [hl+], a ; $5023
	ld [hl+], a ; $5024
	ld [hl+], a ; $5025
	ld [hl+], a ; $5026
	ld [hl+], a ; $5027
	ld [hl+], a ; $5028
	ld [hl], a ; $5029
	ld hl, wCharDataPagePlane + 8 * TILEMAP_WIDTH + 15 ; $502a
	xor a ; $502d
	ld [hl+], a ; $502e
	ld [hl+], a ; $502f
	ld [hl+], a ; $5030
	ld [hl+], a ; $5031
	ld [hl+], a ; $5032
	ld [hl+], a ; $5033
	ld [hl], a ; $5034
	wram_bank $02 ; $5035
	ld hl, wCharDataPagePlane + 8 * TILEMAP_WIDTH + 1 ; $503b
	ld a, $08 ; $503e
	ld [hl+], a ; $5040
	ld [hl+], a ; $5041
	ld [hl+], a ; $5042
	ld [hl+], a ; $5043
	ld [hl+], a ; $5044
	ld [hl+], a ; $5045
	ld [hl], a ; $5046
	ld hl, wCharDataPagePlane + 8 * TILEMAP_WIDTH + 15 ; $5047
	ld [hl+], a ; $504a
	ld [hl+], a ; $504b
	ld [hl+], a ; $504c
	ld [hl+], a ; $504d
	ld [hl+], a ; $504e
	ld [hl+], a ; $504f
	ld [hl], a ; $5050
	push af ; $5051
	ld hl, wStoryModeNameOfMainCharacter ; $5052
	ld a, [wStoryCharacterSlot] ; $5055
	or a ; $5058
	jr z, .zero16 ; $5059
	ld l, $40 ; $505b
.zero16:
	ld a, l ; $505d
	add $00 ; $505e
	ld l, a ; $5060
	ld a, h ; $5061
	adc $00 ; $5062
	ld h, a ; $5064
	pop af ; $5065
	ld de, wCharDataPagePlane + 8 * TILEMAP_WIDTH + 15 ; $5066
	ld c, $0e ; $5069
	call WriteNameStringTiles ; $506b
	wram_bank $06 ; $506e
	push af ; $5074
	ld hl, wStoryModeNameOfMainCharacter ; $5075
	ld a, [wStoryCharacterSlot] ; $5078
	or a ; $507b
	jr z, .zero17 ; $507c
	ld l, $40 ; $507e
.zero17:
	ld a, l ; $5080
	add $18 ; $5081
	ld l, a ; $5083
	ld a, h ; $5084
	adc $00 ; $5085
	ld h, a ; $5087
	pop af ; $5088
	ld a, [hl] ; $5089
	ld h, $00 ; $508a
	ld l, a ; $508c
	ld a, $02 ; $508d
	ld de, wCharDataNumberBuffer ; $508f
	call FormatDecimalNumberUnsigned ; $5092
	ld de, wCharDataPagePlane + 8 * TILEMAP_WIDTH + 25 ; $5095
	farcall CharDataScreen_WriteStatNumber ; $5098
	ret ; $509b
SlideToMainCharStatPage:
	call AdvanceFrame ; $509c
	ld a, [wCharDataFlushChunk] ; $509f
	or a ; $50a2
	jr nz, SlideToMainCharStatPage ; $50a3
	call LoadBasePageIntoWorkTilemap ; $50a5
	ld hl, MainCharStatPageTilemapPatch02 ; $50a8
	ld bc, wCharDataPageSlot1 ; $50ab
	call ApplyTilemapPatchList ; $50ae
	ld hl, MainCharStatPageTilemapPatch03 ; $50b1
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $50b4
	call ApplyTilemapPatchList ; $50b7
	ld hl, MainCharStatPageTilemapPatch04 ; $50ba
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $50bd
	call ApplyTilemapPatchList ; $50c0
	ld hl, DrillDisplayData_1d ; $50c3
	ld bc, wCharDataScreenCell + 28 * TILEMAP_WIDTH + 16 ; $50c6
	call ApplyTilemapPatchList ; $50c9
	farcall FlushCharDataTilemapsFar ; $50cc
	wram_bank $06 ; $50cf
	ld hl, wCharDataValuesSlideX ; $50d5
	ld de, $0020 ; $50d8
	ld a, e ; $50db
	ld [hl+], a ; $50dc
	ld [hl], d ; $50dd
	call LoadBasePageIntoWorkTilemap ; $50de
	ld hl, MainCharStatPageTilemapPatch05 ; $50e1
	ld bc, wCharDataPageSlot1 ; $50e4
	call ApplyTilemapPatchList ; $50e7
	ld hl, MainCharStatPageTilemapPatch06 ; $50ea
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $50ed
	call ApplyTilemapPatchList ; $50f0
	ld hl, MainCharStatPageTilemapPatch07 ; $50f3
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $50f6
	call ApplyTilemapPatchList ; $50f9
	ld hl, StatPageTilemapPatch0 ; $50fc
	ld bc, wCharDataScreenCell + 28 * TILEMAP_WIDTH + 16 ; $50ff
	call ApplyTilemapPatchList ; $5102
	farcall FlushCharDataTilemapsFar ; $5105
	wram_bank $06 ; $5108
	ld hl, wCharDataStatsSlideX ; $510e
	ld de, $ff60 ; $5111
	ld a, e ; $5114
	ld [hl+], a ; $5115
	ld [hl], d ; $5116
	ld hl, wCharDataValuesSlideX ; $5117
	ld de, $0040 ; $511a
	ld a, e ; $511d
	ld [hl+], a ; $511e
	ld [hl], d ; $511f
	call LoadBasePageIntoWorkTilemap ; $5120
	ld hl, MainCharStatPageTilemapPatch08 ; $5123
	ld bc, wCharDataPageSlot1 ; $5126
	call ApplyTilemapPatchList ; $5129
	ld hl, MainCharStatPageTilemapPatch09 ; $512c
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $512f
	call ApplyTilemapPatchList ; $5132
	ld hl, MainCharStatPageTilemapPatch10 ; $5135
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $5138
	call ApplyTilemapPatchList ; $513b
	ld hl, MainCharStatPageTilemapPatch26 ; $513e
	ld bc, wCharDataPageSlot2 ; $5141
	call ApplyTilemapPatchList ; $5144
	ld hl, MainCharStatPageTilemapPatch27 ; $5147
	ld bc, wCharDataPageSlot2 + 8 * TILEMAP_WIDTH ; $514a
	call ApplyTilemapPatchList ; $514d
	ld hl, MainCharStatPageTilemapPatch28 ; $5150
	ld bc, wCharDataPageSlot2 + 16 * TILEMAP_WIDTH ; $5153
	call ApplyTilemapPatchList ; $5156
	farcall FlushCharDataTilemapsFar ; $5159
	wram_bank $06 ; $515c
	ld hl, wCharDataStatsSlideX ; $5162
	ld de, $ff80 ; $5165
	ld a, e ; $5168
	ld [hl+], a ; $5169
	ld [hl], d ; $516a
	ld hl, wCharDataValuesSlideX ; $516b
	ld de, $0060 ; $516e
	ld a, e ; $5171
	ld [hl+], a ; $5172
	ld [hl], d ; $5173
	call LoadBasePageIntoWorkTilemap ; $5174
	ld hl, MainCharStatPageTilemapPatch11 ; $5177
	ld bc, wCharDataPageSlot1 ; $517a
	call ApplyTilemapPatchList ; $517d
	ld hl, MainCharStatPageTilemapPatch12 ; $5180
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $5183
	call ApplyTilemapPatchList ; $5186
	ld hl, MainCharStatPageTilemapPatch13 ; $5189
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $518c
	call ApplyTilemapPatchList ; $518f
	ld hl, MainCharStatPageTilemapPatch23 ; $5192
	ld bc, wCharDataPageSlot2 ; $5195
	call ApplyTilemapPatchList ; $5198
	ld hl, MainCharStatPageTilemapPatch24 ; $519b
	ld bc, wCharDataPageSlot2 + 8 * TILEMAP_WIDTH ; $519e
	call ApplyTilemapPatchList ; $51a1
	ld hl, MainCharStatPageTilemapPatch25 ; $51a4
	ld bc, wCharDataPageSlot2 + 16 * TILEMAP_WIDTH ; $51a7
	call ApplyTilemapPatchList ; $51aa
	farcall FlushCharDataTilemapsFar ; $51ad
	wram_bank $06 ; $51b0
	ld hl, wCharDataStatsSlideX ; $51b6
	ld de, $ffa0 ; $51b9
	ld a, e ; $51bc
	ld [hl+], a ; $51bd
	ld [hl], d ; $51be
	ld hl, wCharDataValuesSlideX ; $51bf
	ld de, $0080 ; $51c2
	ld a, e ; $51c5
	ld [hl+], a ; $51c6
	ld [hl], d ; $51c7
	call LoadBasePageIntoWorkTilemap ; $51c8
	ld hl, MainCharStatPageTilemapPatch20 ; $51cb
	ld bc, wCharDataPageSlot2 ; $51ce
	call ApplyTilemapPatchList ; $51d1
	ld hl, MainCharStatPageTilemapPatch21 ; $51d4
	ld bc, wCharDataPageSlot2 + 8 * TILEMAP_WIDTH ; $51d7
	call ApplyTilemapPatchList ; $51da
	ld hl, MainCharStatPageTilemapPatch22 ; $51dd
	ld bc, wCharDataPageSlot2 + 16 * TILEMAP_WIDTH ; $51e0
	call ApplyTilemapPatchList ; $51e3
	farcall FlushCharDataTilemapsFar ; $51e6
	wram_bank $06 ; $51e9
	ld hl, wCharDataStatsSlideX ; $51ef
	ld de, $ffc0 ; $51f2
	ld a, e ; $51f5
	ld [hl+], a ; $51f6
	ld [hl], d ; $51f7
	ld hl, wCharDataValuesSlideX ; $51f8
	ld de, $00a0 ; $51fb
	ld a, e ; $51fe
	ld [hl+], a ; $51ff
	ld [hl], d ; $5200
	call LoadBasePageIntoWorkTilemap ; $5201
	ld hl, MainCharStatPageTilemapPatch17 ; $5204
	ld bc, wCharDataPageSlot2 ; $5207
	call ApplyTilemapPatchList ; $520a
	ld hl, MainCharStatPageTilemapPatch18 ; $520d
	ld bc, wCharDataPageSlot2 + 8 * TILEMAP_WIDTH ; $5210
	call ApplyTilemapPatchList ; $5213
	ld hl, MainCharStatPageTilemapPatch19 ; $5216
	ld bc, wCharDataPageSlot2 + 16 * TILEMAP_WIDTH ; $5219
	call ApplyTilemapPatchList ; $521c
	farcall FlushCharDataTilemapsFar ; $521f
	wram_bank $06 ; $5222
	ld hl, wCharDataStatsSlideX ; $5228
	ld de, $ffe0 ; $522b
	ld a, e ; $522e
	ld [hl+], a ; $522f
	ld [hl], d ; $5230
	ld hl, wCharDataValuesSlideX ; $5231
	ld de, $00a8 ; $5234
	ld a, e ; $5237
	ld [hl+], a ; $5238
	ld [hl], d ; $5239
	call LoadBasePageIntoWorkTilemap ; $523a
	ld hl, MainCharStatPageTilemapPatch14 ; $523d
	ld bc, wCharDataPageSlot2 ; $5240
	call ApplyTilemapPatchList ; $5243
	ld hl, MainCharStatPageTilemapPatch15 ; $5246
	ld bc, wCharDataPageSlot2 + 8 * TILEMAP_WIDTH ; $5249
	call ApplyTilemapPatchList ; $524c
	ld hl, MainCharStatPageTilemapPatch16 ; $524f
	ld bc, wCharDataPageSlot2 + 16 * TILEMAP_WIDTH ; $5252
	call ApplyTilemapPatchList ; $5255
	farcall FlushCharDataTilemapsFar ; $5258
	wram_bank $06 ; $525b
	ld hl, wCharDataStatsSlideX ; $5261
	xor a ; $5264
	ld [hl+], a ; $5265
	ld [hl], a ; $5266
	ret ; $5267
SlideFromMainCharStatPage:
	call AdvanceFrame ; $5268
	ld a, [wCharDataFlushChunk] ; $526b
	or a ; $526e
	jr nz, SlideFromMainCharStatPage ; $526f
	wram_bank $06 ; $5271
	ld hl, wCharDataStatsSlideX ; $5277
	ld de, $ffe0 ; $527a
	ld a, e ; $527d
	ld [hl+], a ; $527e
	ld [hl], d ; $527f
	call LoadBasePageIntoWorkTilemap ; $5280
	ld hl, MainCharStatPageTilemapPatch17 ; $5283
	ld bc, wCharDataPageSlot2 ; $5286
	call ApplyTilemapPatchList ; $5289
	ld hl, MainCharStatPageTilemapPatch18 ; $528c
	ld bc, wCharDataPageSlot2 + 8 * TILEMAP_WIDTH ; $528f
	call ApplyTilemapPatchList ; $5292
	ld hl, MainCharStatPageTilemapPatch19 ; $5295
	ld bc, wCharDataPageSlot2 + 16 * TILEMAP_WIDTH ; $5298
	call ApplyTilemapPatchList ; $529b
	farcall FlushCharDataTilemapsFar ; $529e
	wram_bank $06 ; $52a1
	ld hl, wCharDataStatsSlideX ; $52a7
	ld de, $ffc0 ; $52aa
	ld a, e ; $52ad
	ld [hl+], a ; $52ae
	ld [hl], d ; $52af
	ld hl, wCharDataValuesSlideX ; $52b0
	ld de, $00a0 ; $52b3
	ld a, e ; $52b6
	ld [hl+], a ; $52b7
	ld [hl], d ; $52b8
	call LoadBasePageIntoWorkTilemap ; $52b9
	ld hl, MainCharStatPageTilemapPatch20 ; $52bc
	ld bc, wCharDataPageSlot2 ; $52bf
	call ApplyTilemapPatchList ; $52c2
	ld hl, MainCharStatPageTilemapPatch21 ; $52c5
	ld bc, wCharDataPageSlot2 + 8 * TILEMAP_WIDTH ; $52c8
	call ApplyTilemapPatchList ; $52cb
	ld hl, MainCharStatPageTilemapPatch22 ; $52ce
	ld bc, wCharDataPageSlot2 + 16 * TILEMAP_WIDTH ; $52d1
	call ApplyTilemapPatchList ; $52d4
	farcall FlushCharDataTilemapsFar ; $52d7
	wram_bank $06 ; $52da
	ld hl, wCharDataStatsSlideX ; $52e0
	ld de, $ffa0 ; $52e3
	ld a, e ; $52e6
	ld [hl+], a ; $52e7
	ld [hl], d ; $52e8
	ld hl, wCharDataValuesSlideX ; $52e9
	ld de, $0080 ; $52ec
	ld a, e ; $52ef
	ld [hl+], a ; $52f0
	ld [hl], d ; $52f1
	call LoadBasePageIntoWorkTilemap ; $52f2
	ld hl, MainCharStatPageTilemapPatch11 ; $52f5
	ld bc, wCharDataPageSlot1 ; $52f8
	call ApplyTilemapPatchList ; $52fb
	ld hl, MainCharStatPageTilemapPatch12 ; $52fe
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $5301
	call ApplyTilemapPatchList ; $5304
	ld hl, MainCharStatPageTilemapPatch13 ; $5307
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $530a
	call ApplyTilemapPatchList ; $530d
	ld hl, MainCharStatPageTilemapPatch23 ; $5310
	ld bc, wCharDataPageSlot2 ; $5313
	call ApplyTilemapPatchList ; $5316
	ld hl, MainCharStatPageTilemapPatch24 ; $5319
	ld bc, wCharDataPageSlot2 + 8 * TILEMAP_WIDTH ; $531c
	call ApplyTilemapPatchList ; $531f
	ld hl, MainCharStatPageTilemapPatch25 ; $5322
	ld bc, wCharDataPageSlot2 + 16 * TILEMAP_WIDTH ; $5325
	call ApplyTilemapPatchList ; $5328
	farcall FlushCharDataTilemapsFar ; $532b
	wram_bank $06 ; $532e
	ld hl, wCharDataStatsSlideX ; $5334
	ld de, $ff80 ; $5337
	ld a, e ; $533a
	ld [hl+], a ; $533b
	ld [hl], d ; $533c
	ld hl, wCharDataValuesSlideX ; $533d
	ld de, $0060 ; $5340
	ld a, e ; $5343
	ld [hl+], a ; $5344
	ld [hl], d ; $5345
	call LoadBasePageIntoWorkTilemap ; $5346
	ld hl, MainCharStatPageTilemapPatch08 ; $5349
	ld bc, wCharDataPageSlot1 ; $534c
	call ApplyTilemapPatchList ; $534f
	ld hl, MainCharStatPageTilemapPatch09 ; $5352
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $5355
	call ApplyTilemapPatchList ; $5358
	ld hl, MainCharStatPageTilemapPatch10 ; $535b
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $535e
	call ApplyTilemapPatchList ; $5361
	ld hl, MainCharStatPageTilemapPatch26 ; $5364
	ld bc, wCharDataPageSlot2 ; $5367
	call ApplyTilemapPatchList ; $536a
	ld hl, MainCharStatPageTilemapPatch27 ; $536d
	ld bc, wCharDataPageSlot2 + 8 * TILEMAP_WIDTH ; $5370
	call ApplyTilemapPatchList ; $5373
	ld hl, MainCharStatPageTilemapPatch28 ; $5376
	ld bc, wCharDataPageSlot2 + 16 * TILEMAP_WIDTH ; $5379
	call ApplyTilemapPatchList ; $537c
	farcall FlushCharDataTilemapsFar ; $537f
	wram_bank $06 ; $5382
	ld hl, wCharDataStatsSlideX ; $5388
	ld de, $ff60 ; $538b
	ld a, e ; $538e
	ld [hl+], a ; $538f
	ld [hl], d ; $5390
	ld hl, wCharDataValuesSlideX ; $5391
	ld de, $0040 ; $5394
	ld a, e ; $5397
	ld [hl+], a ; $5398
	ld [hl], d ; $5399
	call LoadBasePageIntoWorkTilemap ; $539a
	ld hl, MainCharStatPageTilemapPatch05 ; $539d
	ld bc, wCharDataPageSlot1 ; $53a0
	call ApplyTilemapPatchList ; $53a3
	ld hl, MainCharStatPageTilemapPatch06 ; $53a6
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $53a9
	call ApplyTilemapPatchList ; $53ac
	ld hl, MainCharStatPageTilemapPatch07 ; $53af
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $53b2
	call ApplyTilemapPatchList ; $53b5
	ld hl, StatPageTilemapPatch0 ; $53b8
	ld bc, wCharDataScreenCell + 28 * TILEMAP_WIDTH + 16 ; $53bb
	call ApplyTilemapPatchList ; $53be
	farcall FlushCharDataTilemapsFar ; $53c1
	wram_bank $06 ; $53c4
	ld hl, wCharDataStatsSlideX ; $53ca
	ld de, $00a8 ; $53cd
	ld a, e ; $53d0
	ld [hl+], a ; $53d1
	ld [hl], d ; $53d2
	ld hl, wCharDataValuesSlideX ; $53d3
	ld de, $0010 ; $53d6
	ld a, e ; $53d9
	ld [hl+], a ; $53da
	ld [hl], d ; $53db
	call LoadBasePageIntoWorkTilemap ; $53dc
	ld hl, MainCharStatPageTilemapPatch02 ; $53df
	ld bc, wCharDataPageSlot1 ; $53e2
	call ApplyTilemapPatchList ; $53e5
	ld hl, MainCharStatPageTilemapPatch03 ; $53e8
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $53eb
	call ApplyTilemapPatchList ; $53ee
	ld hl, MainCharStatPageTilemapPatch04 ; $53f1
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $53f4
	call ApplyTilemapPatchList ; $53f7
	ld hl, DrillDisplayData_1d ; $53fa
	ld bc, wCharDataScreenCell + 28 * TILEMAP_WIDTH + 16 ; $53fd
	call ApplyTilemapPatchList ; $5400
	farcall FlushCharDataTilemapsFar ; $5403
	wram_bank $06 ; $5406
	ld hl, wCharDataValuesSlideX ; $540c
	xor a ; $540f
	ld [hl+], a ; $5410
	ld [hl], a ; $5411
	call LoadBasePageIntoWorkTilemap ; $5412
	ld hl, StatPageTilemapPatch6 ; $5415
	ld bc, wCharDataPageSlot1 ; $5418
	call ApplyTilemapPatchList ; $541b
	ld hl, StatPageTilemapPatch7 ; $541e
	ld bc, wCharDataPageSlot1 + 8 * TILEMAP_WIDTH ; $5421
	call ApplyTilemapPatchList ; $5424
	ld hl, StatPageTilemapPatch8 ; $5427
	ld bc, wCharDataPageSlot1 + 16 * TILEMAP_WIDTH ; $542a
	call ApplyTilemapPatchList ; $542d
	ld hl, DrillDisplayData_1d ; $5430
	ld bc, wCharDataScreenCell + 28 * TILEMAP_WIDTH + 16 ; $5433
	call ApplyTilemapPatchList ; $5436
	farcall FlushCharDataTilemapsFar ; $5439
	ret ; $543c

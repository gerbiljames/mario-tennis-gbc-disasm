DrawExpScreenNameAndLevel:
	push af ; $4b1f
	push bc ; $4b20
	push de ; $4b21
	push hl ; $4b22
	call ClearExpScreenNameBox ; $4b23
	wram_bank $01 ; $4b26
	push af ; $4b2c
	ld hl, wStoryModeNameOfMainCharacter ; $4b2d
	ld a, [wStoryCharacterSlot] ; $4b30
	or a ; $4b33
	jr z, .zero ; $4b34
	ld l, $40 ; $4b36
.zero:
	ld a, l ; $4b38
	add $00 ; $4b39
	ld l, a ; $4b3b
	ld a, h ; $4b3c
	adc $00 ; $4b3d
	ld h, a ; $4b3f
	pop af ; $4b40
	ld de, wDecompBuffer + 76 * TILE_SIZE + 7 ; $4b41
	call CopyNameToTileBuffer ; $4b44
	push af ; $4b47
	ld hl, wStoryModeNameOfMainCharacter ; $4b48
	ld a, [wStoryCharacterSlot] ; $4b4b
	or a ; $4b4e
	jr z, .zero2 ; $4b4f
	ld l, $40 ; $4b51
.zero2:
	ld a, l ; $4b53
	add $18 ; $4b54
	ld l, a ; $4b56
	ld a, h ; $4b57
	adc $00 ; $4b58
	ld h, a ; $4b5a
	pop af ; $4b5b
	ld a, [hl] ; $4b5c
	ld l, a ; $4b5d
	ld h, $00 ; $4b5e
	farcall PushTextArgNumber ; $4b60
	ld de, wDecompBuffer + 80 * TILE_SIZE + 7 ; $4b63
	ld hl, Text_31_237 ; $4b66
	ld c, $20 ; $4b69
	farcall RenderProportionalTextAt ; $4b6b
	pop hl ; $4b6e
	pop de ; $4b6f
	pop bc ; $4b70
	pop af ; $4b71
	ret ; $4b72
CopyNameToTileBuffer:
	ld a, [hl+] ; $4b73
	or a ; $4b74
	ret z ; $4b75
	cp $de ; $4b76
	jr z, .moveTileBufferDestUpRow ; $4b78
	cp $df ; $4b7a
	jr z, .moveTileBufferDestUpRow ; $4b7c
	ld [de], a ; $4b7e
	inc de ; $4b7f
	jr CopyNameToTileBuffer ; $4b80
.moveTileBufferDestUpRow:
	call MoveTileBufferDestUpRow ; $4b82
	ld [de], a ; $4b85
	ld a, $21 ; $4b86
	add e ; $4b88
	ld e, a ; $4b89
	jr nc, .copyNameToTileBuffer ; $4b8a
	inc d ; $4b8c
.copyNameToTileBuffer:
	jr CopyNameToTileBuffer ; $4b8d
MoveTileBufferDestUpRow:
	ld b, $21 ; $4b8f
.loop:
	dec de ; $4b91
	dec b ; $4b92
	jr nz, .loop ; $4b93
	ret ; $4b95
ClearExpScreenNameBox:
	push af ; $4b96
	push bc ; $4b97
	push de ; $4b98
	push hl ; $4b99
	ld c, $05 ; $4b9a
.loop:
	ld a, c ; $4b9c
	cp $09 ; $4b9d
	jr z, .restore ; $4b9f
	ld b, $07 ; $4ba1
.loopB:
	ld a, b ; $4ba3
	cp $0d ; $4ba4
	jr z, .eq0d ; $4ba6
	ld de, $2000 ; $4ba8
	call WriteTileBufferCell ; $4bab
	inc b ; $4bae
	jr .loopB ; $4baf
.eq0d:
	inc c ; $4bb1
	jr .loop ; $4bb2
.restore:
	pop hl ; $4bb4
	pop de ; $4bb5
	pop bc ; $4bb6
	pop af ; $4bb7
	ret ; $4bb8
StubNop_1a_1:
	ret ; $4bb9
StubNop_1a_2:
	ret ; $4bba
DrawPositionedStringToTileBuffer:
	push af ; $4bbb
	push bc ; $4bbc
	push de ; $4bbd
	push hl ; $4bbe
	ld a, [hl] ; $4bbf
	ld b, a ; $4bc0
	inc hl ; $4bc1
	ld a, [hl] ; $4bc2
	ld c, a ; $4bc3
	inc hl ; $4bc4
	ld a, [hl] ; $4bc5
	ld e, a ; $4bc6
	inc hl ; $4bc7
	call DrawStringToTileBuffer ; $4bc8
	pop hl ; $4bcb
	pop de ; $4bcc
	pop bc ; $4bcd
	pop af ; $4bce
	ret ; $4bcf
DrawStringToTileBuffer:
	push af ; $4bd0
	push bc ; $4bd1
	push de ; $4bd2
	push hl ; $4bd3
.charLoop:
	ld a, [hl] ; $4bd4
	cp $00 ; $4bd5
	jr z, .done ; $4bd7
	cp $9e ; $4bd9
	jr z, .specialChar ; $4bdb
	cp $9f ; $4bdd
	jr z, .specialChar ; $4bdf
	cp $de ; $4be1
	jr z, .specialChar ; $4be3
	cp $df ; $4be5
	jr z, .specialChar ; $4be7
	ld d, a ; $4be9
	call WriteTileBufferCell ; $4bea
	inc b ; $4bed
	inc hl ; $4bee
	jr .charLoop ; $4bef
.specialChar:
	push bc ; $4bf1
	dec b ; $4bf2
	dec c ; $4bf3
	push af ; $4bf4
	ld a, c ; $4bf5
	cp $00 ; $4bf6
	jr z, .noRoom ; $4bf8
	pop af ; $4bfa
	ld d, a ; $4bfb
	call WriteTileBufferCell ; $4bfc
	pop bc ; $4bff
	inc hl ; $4c00
	jr .charLoop ; $4c01
.noRoom:
	pop af ; $4c03
	push de ; $4c04
	cp $9e ; $4c05
	jr z, .altTile ; $4c07
	cp $de ; $4c09
	jr z, .altTile ; $4c0b
	ld de, $040b ; $4c0d
	jr .writeTile ; $4c10
.altTile:
	ld de, $030b ; $4c12
.writeTile:
	call WriteTileBufferCell ; $4c15
	pop de ; $4c18
	pop bc ; $4c19
	inc hl ; $4c1a
	jr .charLoop ; $4c1b
.done:
	pop hl ; $4c1d
	pop de ; $4c1e
	pop bc ; $4c1f
	pop af ; $4c20
	ret ; $4c21
GetTileBufferCellAddr:
	push af ; $4c22
	push de ; $4c23
	ld hl, $0020 ; $4c24
	ld a, c ; $4c27
	call MulHLByA ; $4c28
	ld d, $00 ; $4c2b
	ld e, b ; $4c2d
	add hl, de ; $4c2e
	push hl ; $4c2f
	pop de ; $4c30
	ld hl, wDecompBuffer ; $4c31
	add hl, de ; $4c34
	pop de ; $4c35
	pop af ; $4c36
	ret ; $4c37
WriteTileBufferCell:
	push af ; $4c38
	push bc ; $4c39
	push de ; $4c3a
	push hl ; $4c3b
	push_wram_bank $01 ; $4c3c
	call GetTileBufferCellAddr ; $4c45
	ld a, e ; $4c48
	ld [hl], a ; $4c49
	push de ; $4c4a
	ld de, $0400 ; $4c4b
	add hl, de ; $4c4e
	pop de ; $4c4f
	ld a, d ; $4c50
	ld [hl], a ; $4c51
	pop_wram_bank ; $4c52
	pop hl ; $4c57
	pop de ; $4c58
	pop bc ; $4c59
	pop af ; $4c5a
	ret ; $4c5b
WriteStatModifierToTileBuffer:
	push af ; $4c5c
	push bc ; $4c5d
	push de ; $4c5e
	push hl ; $4c5f
	ld d, a ; $4c60
	push bc ; $4c61
	push de ; $4c62
	call SignExtendModifierByte ; $4c63
	push hl ; $4c66
	pop bc ; $4c67
	ld de, $0000 ; $4c68
	call CompareBCToDE ; $4c6b
	cp $00 ; $4c6e
	jr z, .zero ; $4c70
	bit 7, h ; $4c72
	jr nz, .negative ; $4c74
	ld a, $2b ; $4c76
	jr .writeSign ; $4c78
.negative:
	ld a, $2d ; $4c7a
	jr .writeSign ; $4c7c
.zero:
	ld a, $60 ; $4c7e
.writeSign:
	pop de ; $4c80
	pop bc ; $4c81
	push de ; $4c82
	ld d, a ; $4c83
	ld e, $01 ; $4c84
	call WriteTileBufferCell ; $4c86
	pop de ; $4c89
	inc b ; $4c8a
	ld a, d ; $4c8b
	cp $00 ; $4c8c
	jr z, .tens ; $4c8e
	push bc ; $4c90
	push de ; $4c91
	call SignExtendModifierByte ; $4c92
	bit 7, h ; $4c95
	jr z, .divide ; $4c97
	push hl ; $4c99
	pop de ; $4c9a
	ld hl, $0000 ; $4c9b
	ld a, l ; $4c9e
	sub e ; $4c9f
	ld l, a ; $4ca0
	ld a, h ; $4ca1
	sbc d ; $4ca2
	ld h, a ; $4ca3
.divide:
	ld de, $0064 ; $4ca4
	call DivHLByDE ; $4ca7
	pop de ; $4caa
	pop bc ; $4cab
	ld a, l ; $4cac
	cp $00 ; $4cad
	jr z, .tens ; $4caf
	push de ; $4cb1
	ld d, $31 ; $4cb2
	ld e, $01 ; $4cb4
	call WriteTileBufferCell ; $4cb6
	pop de ; $4cb9
	inc b ; $4cba
.tens:
	ld a, d ; $4cbb
	call GetModifierTensDigit ; $4cbc
	cp $00 ; $4cbf
	jr nz, .writeTens ; $4cc1
	ld a, d ; $4cc3
	sub $64 ; $4cc4
	bit 7, a ; $4cc6
	jr nz, .ones ; $4cc8
	ld a, $00 ; $4cca
.writeTens:
	add $30 ; $4ccc
	push de ; $4cce
	ld d, a ; $4ccf
	ld e, $01 ; $4cd0
	call WriteTileBufferCell ; $4cd2
	pop de ; $4cd5
	inc b ; $4cd6
.ones:
	ld a, d ; $4cd7
	call GetModifierOnesDigit ; $4cd8
	add $30 ; $4cdb
	push de ; $4cdd
	ld d, a ; $4cde
	ld e, $01 ; $4cdf
	call WriteTileBufferCell ; $4ce1
	pop de ; $4ce4
	pop hl ; $4ce5
	pop de ; $4ce6
	pop bc ; $4ce7
	pop af ; $4ce8
	ret ; $4ce9
CompareBCToDE:
	push bc ; $4cea
	push de ; $4ceb
	push hl ; $4cec
	push bc ; $4ced
	pop hl ; $4cee
	ld a, l ; $4cef
	sub e ; $4cf0
	ld l, a ; $4cf1
	ld a, h ; $4cf2
	sbc d ; $4cf3
	ld h, a ; $4cf4
	bit 7, h ; $4cf5
	jr nz, .negative ; $4cf7
	ld a, h ; $4cf9
	cp $00 ; $4cfa
	jr nz, .step ; $4cfc
	ld a, l ; $4cfe
	cp $00 ; $4cff
	jr nz, .step ; $4d01
	ld a, $00 ; $4d03
	jr .restore ; $4d05
.step:
	ld a, $01 ; $4d07
	jr .restore ; $4d09
.negative:
	ld a, $02 ; $4d0b
.restore:
	pop hl ; $4d0d
	pop de ; $4d0e
	pop bc ; $4d0f
	ret ; $4d10
GetModifierTensDigit:
	push bc ; $4d11
	push de ; $4d12
	push hl ; $4d13
	call SignExtendModifierByte ; $4d14
	bit 7, h ; $4d17
	jr z, .positive ; $4d19
	push hl ; $4d1b
	pop de ; $4d1c
	ld hl, $0000 ; $4d1d
	ld a, l ; $4d20
	sub e ; $4d21
	ld l, a ; $4d22
	ld a, h ; $4d23
	sbc d ; $4d24
	ld h, a ; $4d25
.positive:
	push hl ; $4d26
	pop bc ; $4d27
	ld de, $0064 ; $4d28
	ld a, l ; $4d2b
	sub e ; $4d2c
	ld l, a ; $4d2d
	ld a, h ; $4d2e
	sbc d ; $4d2f
	ld h, a ; $4d30
	bit 7, h ; $4d31
	jr nz, .negative ; $4d33
	push hl ; $4d35
	pop bc ; $4d36
.negative:
	push bc ; $4d37
	pop hl ; $4d38
	ld de, $000a ; $4d39
	call DivHLByDE ; $4d3c
	ld a, l ; $4d3f
	pop hl ; $4d40
	pop de ; $4d41
	pop bc ; $4d42
	ret ; $4d43
GetModifierOnesDigit:
	push bc ; $4d44
	push de ; $4d45
	push hl ; $4d46
	call SignExtendModifierByte ; $4d47
	bit 7, h ; $4d4a
	jr z, .positive ; $4d4c
	push hl ; $4d4e
	pop de ; $4d4f
	ld hl, $0000 ; $4d50
	ld a, l ; $4d53
	sub e ; $4d54
	ld l, a ; $4d55
	ld a, h ; $4d56
	sbc d ; $4d57
	ld h, a ; $4d58
.positive:
	push hl ; $4d59
	pop bc ; $4d5a
	ld de, $0064 ; $4d5b
	ld a, l ; $4d5e
	sub e ; $4d5f
	ld l, a ; $4d60
	ld a, h ; $4d61
	sbc d ; $4d62
	ld h, a ; $4d63
	bit 7, h ; $4d64
	jr nz, .negative ; $4d66
	push hl ; $4d68
	pop bc ; $4d69
.negative:
	push bc ; $4d6a
	pop hl ; $4d6b
	ld de, $000a ; $4d6c
	call DivHLByDE ; $4d6f
	ld a, $0a ; $4d72
	call MulHLByA ; $4d74
	push hl ; $4d77
	pop de ; $4d78
	push bc ; $4d79
	pop hl ; $4d7a
	ld a, l ; $4d7b
	sub e ; $4d7c
	ld l, a ; $4d7d
	ld a, h ; $4d7e
	sbc d ; $4d7f
	ld h, a ; $4d80
	ld a, l ; $4d81
	pop hl ; $4d82
	pop de ; $4d83
	pop bc ; $4d84
	ret ; $4d85
SignExtendModifierByte:
	push af ; $4d86
	push bc ; $4d87
	push de ; $4d88
	ld l, a ; $4d89
	ld h, $00 ; $4d8a
	push hl ; $4d8c
	pop bc ; $4d8d
	ld d, $00 ; $4d8e
	ld e, $91 ; $4d90
	ld a, l ; $4d92
	sub e ; $4d93
	ld l, a ; $4d94
	ld a, h ; $4d95
	sbc d ; $4d96
	ld h, a ; $4d97
	bit 7, h ; $4d98
	jr nz, .positive ; $4d9a
	push bc ; $4d9c
	pop hl ; $4d9d
	ld h, $ff ; $4d9e
	jr .done ; $4da0
.positive:
	push bc ; $4da2
	pop hl ; $4da3
.done:
	pop de ; $4da4
	pop bc ; $4da5
	pop af ; $4da6
	ret ; $4da7

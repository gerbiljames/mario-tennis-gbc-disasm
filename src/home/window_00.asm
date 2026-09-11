EnableTimerInterrupt:
	di ; $2a0e
	xor a ; $2a0f
	ldh [rIF], a ; $2a10
	ldh a, [rIE] ; $2a12
	or $04 ; $2a14
	ldh [rIE], a ; $2a16
	ei ; $2a18
	ret ; $2a19
; EnableSerialAndVBlankInterrupts with IE = $0d (timer as well). Nothing calls it.
Unused_00_SetInterruptsVBlankTimerSerial:
	di ; $2a1a
	xor a ; $2a1b
	ldh [rIF], a ; $2a1c
	ld a, $0d ; $2a1e
	ldh [rIE], a ; $2a20
	ei ; $2a22
	ret ; $2a23
; Instruction-for-instruction the same as EnableSerialAndVBlankInterrupts, a second copy of it. Nothing calls it.
Unused_00_SetInterruptsVBlankSerial:
	di ; $2a24
	xor a ; $2a25
	ldh [rIF], a ; $2a26
	ld a, $09 ; $2a28
	ldh [rIE], a ; $2a2a
	ei ; $2a2c
	ret ; $2a2d
QueueDeferredTilemapCopy:
	push af ; $2a2e
	ld [wDeferredTilemapWramBank], a ; $2a2f
	ld a, c ; $2a32
	ld [wDeferredTilemapLength], a ; $2a33
	ld a, l ; $2a36
	ld [wDeferredTilemapSrc], a ; $2a37
	ld a, h ; $2a3a
	ld [wDeferredTilemapSrc + 1], a ; $2a3b
	ld a, e ; $2a3e
	ld [wDeferredTilemapAttrSrc], a ; $2a3f
	ld a, d ; $2a42
	ld [wDeferredTilemapAttrSrc + 1], a ; $2a43
	xor a ; $2a46
	ld [wDeferredTilemapPending], a ; $2a47
	ld a, $05 ; $2a4a
	ld hl, VBlankDeferredTilemapCopyTask ; $2a4c
	call RegisterFrameTask ; $2a4f
	pop af ; $2a52
	ret ; $2a53
VBlankDeferredTilemapCopyTask:
	push af ; $2a54
	push bc ; $2a55
	push de ; $2a56
	push hl ; $2a57
	ldh a, [hWramBank] ; $2a58
	push af ; $2a5a
	ld a, [wDeferredTilemapWramBank] ; $2a5b
	wram_bank ; $2a5e
	ld a, [wDeferredTilemapPending] ; $2a62
	and $0f ; $2a65
	jr z, .maskClear ; $2a67
	ld hl, wDeferredTilemapSrc ; $2a69
	ld a, [hl+] ; $2a6c
	ld h, [hl] ; $2a6d
	ld l, a ; $2a6e
	ld de, vBGMap0 ; $2a6f
	ld a, [wDeferredTilemapLength] ; $2a72
	ld c, a ; $2a75
	call QueueVRAMCopy ; $2a76
.maskClear:
	ld a, [wDeferredTilemapPending] ; $2a79
	and $f0 ; $2a7c
	jr z, .maskClear2 ; $2a7e
	ld hl, wDeferredTilemapAttrSrc ; $2a80
	ld a, [hl+] ; $2a83
	ld h, [hl] ; $2a84
	ld l, a ; $2a85
	ld de, vBGMap0 + VRAM_BANK1 ; $2a86
	ld a, [wDeferredTilemapLength] ; $2a89
	ld c, a ; $2a8c
	call QueueVRAMCopy ; $2a8d
.maskClear2:
	xor a ; $2a90
	ld [wDeferredTilemapPending], a ; $2a91
	pop_wram_bank ; $2a94
	pop hl ; $2a99
	pop de ; $2a9a
	pop bc ; $2a9b
	pop af ; $2a9c
	ret ; $2a9d
RenderProportionalMenuText:
	push bc ; $2a9e
	ld c, $11 ; $2a9f
	farcall RenderProportionalTextAt ; $2aa1
	pop bc ; $2aa4
	ret ; $2aa5
CopyTextString:
	push af ; $2aa6
	push bc ; $2aa7
	push hl ; $2aa8
.loop:
	ld a, [hl+] ; $2aa9
	cp $00 ; $2aaa
	jr z, .restore ; $2aac
	cp $de ; $2aae
	jr z, .step ; $2ab0
	cp $df ; $2ab2
	jr z, .step ; $2ab4
	ld [de], a ; $2ab6
	inc de ; $2ab7
	jr .loop ; $2ab8
.step:
	push hl ; $2aba
	ld b, a ; $2abb
	ld hl, $ffdf ; $2abc
	add hl, de ; $2abf
	ld a, [hl] ; $2ac0
	cp $03 ; $2ac1
	ld a, b ; $2ac3
	jr nz, .store ; $2ac4
	sub $d0 ; $2ac6
.store:
	ld [hl], a ; $2ac8
	pop hl ; $2ac9
	jr .loop ; $2aca
.restore:
	pop hl ; $2acc
	pop bc ; $2acd
	pop af ; $2ace
	ret ; $2acf
Unused_00_WriteByteAdvanceDE:
	ld [de], a ; $2ad0
	inc de ; $2ad1
	ret ; $2ad2
DrawHexWord:
	push af ; $2ad3
	push bc ; $2ad4
	push hl ; $2ad5
	add sp, -10 ; $2ad6
	push de ; $2ad8
	ld c, l ; $2ad9
	ld b, h ; $2ada
	ld hl, sp + 2 ; $2adb
	ld e, l ; $2add
	ld d, h ; $2ade
	ld l, c ; $2adf
	ld h, b ; $2ae0
	ld c, e ; $2ae1
	ld b, d ; $2ae2
	call FormatHexWord ; $2ae3
	ld l, c ; $2ae6
	ld h, b ; $2ae7
	pop de ; $2ae8
	call CopyTextString ; $2ae9
	add sp, 10 ; $2aec
	pop hl ; $2aee
	pop bc ; $2aef
	pop af ; $2af0
	ret ; $2af1
DrawDecimalWord:
	push af ; $2af2
	push bc ; $2af3
	push hl ; $2af4
	add sp, -10 ; $2af5
	push de ; $2af7
	ld c, l ; $2af8
	ld b, h ; $2af9
	ld hl, sp + 2 ; $2afa
	ld e, l ; $2afc
	ld d, h ; $2afd
	ld l, c ; $2afe
	ld h, b ; $2aff
	ld c, e ; $2b00
	ld b, d ; $2b01
	call FormatDecimalNumber ; $2b02
	ld l, c ; $2b05
	ld h, b ; $2b06
	pop de ; $2b07
	call CopyTextString ; $2b08
	add sp, 10 ; $2b0b
	pop hl ; $2b0d
	pop bc ; $2b0e
	pop af ; $2b0f
	ret ; $2b10
Unused_00_DrawDecimalByte1Digit:
	ld l, a ; $2b11
	ld h, $00 ; $2b12
	ld a, $01 ; $2b14
	jr DrawDecimalWord ; $2b16
Unused_00_DrawDecimalByte2Digits:
	ld l, a ; $2b18
	ld h, $00 ; $2b19
	ld a, $02 ; $2b1b
	jr DrawDecimalWord ; $2b1d
Unused_00_DrawDecimalByte3Digits:
	ld l, a ; $2b1f
	ld h, $00 ; $2b20
	ld a, $03 ; $2b22
	jr DrawDecimalWord ; $2b24
Unused_00_DrawThreeHalvedWordsDecimal:
	push af ; $2b26
	push hl ; $2b27
	call DrawHalvedWordDecimal ; $2b28
	call DrawHalvedWordDecimal ; $2b2b
	call DrawHalvedWordDecimal ; $2b2e
	pop hl ; $2b31
	pop af ; $2b32
	ret ; $2b33
DrawHalvedWordDecimal:
	push hl ; $2b34
	ld a, [hl+] ; $2b35
	ld h, [hl] ; $2b36
	ld l, a ; $2b37
	sra h ; $2b38
	rr l ; $2b3a
	ld a, $04 ; $2b3c
	call DrawDecimalWord ; $2b3e
	inc de ; $2b41
	pop hl ; $2b42
	inc hl ; $2b43
	inc hl ; $2b44
	ret ; $2b45
CopyTextRect:
	push bc ; $2b46
	push de ; $2b47
.cellLoop:
	ld a, [hl+] ; $2b48
	and a ; $2b49
	ld [de], a ; $2b4a
	inc de ; $2b4b
	dec b ; $2b4c
	jr nz, .cellLoop ; $2b4d
	pop de ; $2b4f
	pop bc ; $2b50
	ld a, $20 ; $2b51
	add e ; $2b53
	ld e, a ; $2b54
	jr nc, .nextRow ; $2b55
	inc d ; $2b57
.nextRow:
	dec c ; $2b58
	jr nz, CopyTextRect ; $2b59
	ret ; $2b5b
DrawWindowFramePriority:
	ld a, $80 ; $2b5c
	ld [wWindowFrameAttr], a ; $2b5e
	jr DrawWindowFrame ; $2b61
DrawWindowFrameNoPriority:
	ld a, $00 ; $2b63
	ld [wWindowFrameAttr], a ; $2b65
DrawWindowFrame:
	push af ; $2b68
	push bc ; $2b69
	push de ; $2b6a
	push hl ; $2b6b
	push hl ; $2b6c
	ld l, e ; $2b6d
	ld h, d ; $2b6e
	ld e, c ; $2b6f
	ld d, b ; $2b70
	pop bc ; $2b71
	push bc ; $2b72
	push de ; $2b73
	push hl ; $2b74
.loop:
	push bc ; $2b75
	push de ; $2b76
	push hl ; $2b77
.loopB:
	ld a, $20 ; $2b78
	ld [hl+], a ; $2b7a
	ld a, [wWindowFrameAttr] ; $2b7b
	ld [de], a ; $2b7e
	inc de ; $2b7f
	dec b ; $2b80
	jr nz, .loopB ; $2b81
	pop hl ; $2b83
	pop de ; $2b84
	pop bc ; $2b85
	ld a, $20 ; $2b86
	add l ; $2b88
	ld l, a ; $2b89
	jr nc, .gotPtr ; $2b8a
	inc h ; $2b8c
.gotPtr:
	ld a, $20 ; $2b8d
	add e ; $2b8f
	ld e, a ; $2b90
	jr nc, .gotPtr2 ; $2b91
	inc d ; $2b93
.gotPtr2:
	dec c ; $2b94
	jr nz, .loop ; $2b95
	pop hl ; $2b97
	pop de ; $2b98
	pop bc ; $2b99
	call DrawWindowFrameTop ; $2b9a
	ld a, $20 ; $2b9d
	add l ; $2b9f
	ld l, a ; $2ba0
	jr nc, .gotPtr3 ; $2ba1
	inc h ; $2ba3
.gotPtr3:
	dec c ; $2ba4
	dec c ; $2ba5
.loop2:
	call DrawWindowFrameSides ; $2ba6
	ld a, $20 ; $2ba9
	add l ; $2bab
	ld l, a ; $2bac
	jr nc, .drawWindowFrameBottom ; $2bad
	inc h ; $2baf
.drawWindowFrameBottom:
	dec c ; $2bb0
	jr nz, .loop2 ; $2bb1
	call DrawWindowFrameBottom ; $2bb3
	pop hl ; $2bb6
	pop de ; $2bb7
	pop bc ; $2bb8
	pop af ; $2bb9
	ret ; $2bba
DrawWindowFrameTop:
	push bc ; $2bbb
	push hl ; $2bbc
	ld a, $02 ; $2bbd
	ld [hl+], a ; $2bbf
	dec b ; $2bc0
	dec b ; $2bc1
.loop:
	ld a, $03 ; $2bc2
	ld [hl+], a ; $2bc4
	dec b ; $2bc5
	jr nz, .loop ; $2bc6
	ld a, $04 ; $2bc8
	ld [hl+], a ; $2bca
	pop hl ; $2bcb
	pop bc ; $2bcc
	ret ; $2bcd
DrawWindowFrameSides:
	push hl ; $2bce
	ld [hl], $05 ; $2bcf
	ld a, b ; $2bd1
	dec a ; $2bd2
	add l ; $2bd3
	ld l, a ; $2bd4
	jr nc, .store ; $2bd5
	inc h ; $2bd7
.store:
	ld [hl], $06 ; $2bd8
	pop hl ; $2bda
	ret ; $2bdb
DrawWindowFrameBottom:
	ld a, $07 ; $2bdc
	ld [hl+], a ; $2bde
	dec b ; $2bdf
	dec b ; $2be0
.loop:
	ld a, $08 ; $2be1
	ld [hl+], a ; $2be3
	dec b ; $2be4
	jr nz, .loop ; $2be5
	ld a, $09 ; $2be7
	ld [hl+], a ; $2be9
	ret ; $2bea
Unused_00_MoveCoordsByDpad:
	bit 5, a ; $2beb
	jr z, .bit5Clear ; $2bed
	dec d ; $2bef
	ret ; $2bf0
.bit5Clear:
	bit 4, a ; $2bf1
	jr z, .bit4Clear ; $2bf3
	inc d ; $2bf5
	ret ; $2bf6
.bit4Clear:
	bit 6, a ; $2bf7
	jr z, .bit6Clear ; $2bf9
	dec e ; $2bfb
	ret ; $2bfc
.bit6Clear:
	bit 7, a ; $2bfd
	jr z, .done ; $2bff
	inc e ; $2c01
	ret ; $2c02
.done:
	ret ; $2c03
MoveCursorVertical:
	bit 6, b ; $2c04
	jr nz, MoveCursorHorizontal.wrap ; $2c06
	bit 7, b ; $2c08
	jr nz, MoveCursorHorizontal.right ; $2c0a
	ret ; $2c0c
MoveCursorHorizontal:
	bit 5, b ; $2c0d
	jr nz, .wrap ; $2c0f
	bit 4, b ; $2c11
	jr nz, .right ; $2c13
	ret ; $2c15
.right:
	inc a ; $2c16
	inc a ; $2c17
.wrap:
	dec a ; $2c18
	add a ; $2c19
	jr nc, .checkMax ; $2c1a
	ld a, c ; $2c1c
	dec a ; $2c1d
	jr .done ; $2c1e
.checkMax:
	rra ; $2c20
	cp c ; $2c21
	jr c, .done ; $2c22
	xor a ; $2c24
.done:
	ret ; $2c25
TickTimer:
	ld a, [hl] ; $2c26
	and a ; $2c27
	ret z ; $2c28
	dec [hl] ; $2c29
	ret ; $2c2a
QueueSprite24x32:
	bit 5, b ; $2c2b
	jr nz, .bit5Set ; $2c2d
	ld a, h ; $2c2f
	add d ; $2c30
	ld d, a ; $2c31
	ld a, l ; $2c32
	add e ; $2c33
	ld e, a ; $2c34
	ld a, [wSpriteBufferPage] ; $2c35
	ld h, a ; $2c38
	ldh a, [hSpriteQueueIndex] ; $2c39
	cp $89 ; $2c3b
	ret nc ; $2c3d
	ld l, a ; $2c3e
	ld a, e ; $2c3f
	ld [hl+], a ; $2c40
	ld a, d ; $2c41
	ld [hl+], a ; $2c42
	ld a, c ; $2c43
	ld [hl+], a ; $2c44
	ld a, b ; $2c45
	ld [hl+], a ; $2c46
	inc c ; $2c47
	inc c ; $2c48
	ld a, e ; $2c49
	add $10 ; $2c4a
	ld [hl+], a ; $2c4c
	ld a, d ; $2c4d
	ld [hl+], a ; $2c4e
	ld a, c ; $2c4f
	ld [hl+], a ; $2c50
	ld a, b ; $2c51
	ld [hl+], a ; $2c52
	inc c ; $2c53
	inc c ; $2c54
	ld a, e ; $2c55
	ld [hl+], a ; $2c56
	ld a, d ; $2c57
	add $08 ; $2c58
	ld [hl+], a ; $2c5a
	ld a, c ; $2c5b
	ld [hl+], a ; $2c5c
	ld a, b ; $2c5d
	ld [hl+], a ; $2c5e
	inc c ; $2c5f
	inc c ; $2c60
	ld a, e ; $2c61
	add $10 ; $2c62
	ld [hl+], a ; $2c64
	ld a, d ; $2c65
	add $08 ; $2c66
	ld [hl+], a ; $2c68
	ld a, c ; $2c69
	ld [hl+], a ; $2c6a
	ld a, b ; $2c6b
	ld [hl+], a ; $2c6c
	inc c ; $2c6d
	inc c ; $2c6e
	ld a, e ; $2c6f
	ld [hl+], a ; $2c70
	ld a, d ; $2c71
	add $10 ; $2c72
	ld [hl+], a ; $2c74
	ld a, c ; $2c75
	ld [hl+], a ; $2c76
	ld a, b ; $2c77
	ld [hl+], a ; $2c78
	inc c ; $2c79
	inc c ; $2c7a
	ld a, e ; $2c7b
	add $10 ; $2c7c
	ld [hl+], a ; $2c7e
	ld a, d ; $2c7f
	add $10 ; $2c80
	ld [hl+], a ; $2c82
	ld a, c ; $2c83
	ld [hl+], a ; $2c84
	ld a, b ; $2c85
	ld [hl+], a ; $2c86
	inc c ; $2c87
	inc c ; $2c88
	ld a, l ; $2c89
	ldh [hSpriteQueueIndex], a ; $2c8a
	ret ; $2c8c
.bit5Set:
	ld a, d ; $2c8d
	sub h ; $2c8e
	add $08 ; $2c8f
	ld d, a ; $2c91
	ld a, l ; $2c92
	add e ; $2c93
	ld e, a ; $2c94
	ld a, [wSpriteBufferPage] ; $2c95
	ld h, a ; $2c98
	ldh a, [hSpriteQueueIndex] ; $2c99
	cp $89 ; $2c9b
	ret nc ; $2c9d
	ld l, a ; $2c9e
	ld a, e ; $2c9f
	ld [hl+], a ; $2ca0
	ld a, d ; $2ca1
	ld [hl+], a ; $2ca2
	ld a, c ; $2ca3
	ld [hl+], a ; $2ca4
	ld a, b ; $2ca5
	ld [hl+], a ; $2ca6
	inc c ; $2ca7
	inc c ; $2ca8
	ld a, e ; $2ca9
	add $10 ; $2caa
	ld [hl+], a ; $2cac
	ld a, d ; $2cad
	ld [hl+], a ; $2cae
	ld a, c ; $2caf
	ld [hl+], a ; $2cb0
	ld a, b ; $2cb1
	ld [hl+], a ; $2cb2
	inc c ; $2cb3
	inc c ; $2cb4
	ld a, e ; $2cb5
	ld [hl+], a ; $2cb6
	ld a, d ; $2cb7
	add $f8 ; $2cb8
	ld [hl+], a ; $2cba
	ld a, c ; $2cbb
	ld [hl+], a ; $2cbc
	ld a, b ; $2cbd
	ld [hl+], a ; $2cbe
	inc c ; $2cbf
	inc c ; $2cc0
	ld a, e ; $2cc1
	add $10 ; $2cc2
	ld [hl+], a ; $2cc4
	ld a, d ; $2cc5
	add $f8 ; $2cc6
	ld [hl+], a ; $2cc8
	ld a, c ; $2cc9
	ld [hl+], a ; $2cca
	ld a, b ; $2ccb
	ld [hl+], a ; $2ccc
	inc c ; $2ccd
	inc c ; $2cce
	ld a, e ; $2ccf
	ld [hl+], a ; $2cd0
	ld a, d ; $2cd1
	add $f0 ; $2cd2
	ld [hl+], a ; $2cd4
	ld a, c ; $2cd5
	ld [hl+], a ; $2cd6
	ld a, b ; $2cd7
	ld [hl+], a ; $2cd8
	inc c ; $2cd9
	inc c ; $2cda
	ld a, e ; $2cdb
	add $10 ; $2cdc
	ld [hl+], a ; $2cde
	ld a, d ; $2cdf
	add $f0 ; $2ce0
	ld [hl+], a ; $2ce2
	ld a, c ; $2ce3
	ld [hl+], a ; $2ce4
	ld a, b ; $2ce5
	ld [hl+], a ; $2ce6
	inc c ; $2ce7
	inc c ; $2ce8
	ld a, l ; $2ce9
	ldh [hSpriteQueueIndex], a ; $2cea
	ret ; $2cec

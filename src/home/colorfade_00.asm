Compare3Bytes:
	push hl ; $1b48
	push de ; $1b49
	ld a, [de] ; $1b4a
	cp [hl] ; $1b4b
	jr nz, .step ; $1b4c
	inc hl ; $1b4e
	inc de ; $1b4f
	ld a, [de] ; $1b50
	cp [hl] ; $1b51
	jr nz, .step ; $1b52
	inc hl ; $1b54
	inc de ; $1b55
	ld a, [de] ; $1b56
	cp [hl] ; $1b57
	jr nz, .step ; $1b58
	xor a ; $1b5a
	jr .restore ; $1b5b
.step:
	ld a, $01 ; $1b5d
	or a ; $1b5f
.restore:
	pop de ; $1b60
	pop hl ; $1b61
	ret ; $1b62
Check3BytesZero:
	push hl ; $1b63
	ld a, [hl+] ; $1b64
	or [hl] ; $1b65
	inc hl ; $1b66
	or [hl] ; $1b67
	pop hl ; $1b68
	ret ; $1b69
RegisterFrameTask:
	add sp, -4 ; $1b6a
	push af ; $1b6c
	xor a ; $1b6d
	ldh [hFrameTasksReady], a ; $1b6e
	pop af ; $1b70
	ld d, h ; $1b71
	ld e, l ; $1b72
	ld hl, sp + 0 ; $1b73
	push hl ; $1b75
	ld [hl+], a ; $1b76
	ld [hl], e ; $1b77
	inc hl ; $1b78
	ld [hl], d ; $1b79
	inc hl ; $1b7a
	ldh a, [hRomBank] ; $1b7b
	ld [hl], a ; $1b7d
	pop de ; $1b7e
	inc de ; $1b7f
	ld bc, $0010 ; $1b80
	ld hl, wFrameTasks ; $1b83
.searchLoop:
	inc hl ; $1b86
	call Compare3Bytes ; $1b87
	jr nz, .searchNext ; $1b8a
	ld b, $01 ; $1b8c
	jr .searchDone ; $1b8e
.searchNext:
	inc hl ; $1b90
	inc hl ; $1b91
	inc hl ; $1b92
	dec c ; $1b93
	jr nz, .searchLoop ; $1b94
.searchDone:
	ld a, b ; $1b96
	or a ; $1b97
	jr nz, .done ; $1b98
	ld c, $16 ; $1b9a
	ld hl, wFrameTasks ; $1b9c
.insertLoop:
	inc hl ; $1b9f
	call Check3BytesZero ; $1ba0
	jr nz, .insertNext ; $1ba3
	dec hl ; $1ba5
	dec de ; $1ba6
	ld a, [de] ; $1ba7
	ld [hl], a ; $1ba8
	inc hl ; $1ba9
	inc de ; $1baa
	ld a, [de] ; $1bab
	ld [hl], a ; $1bac
	inc de ; $1bad
	inc hl ; $1bae
	ld a, [de] ; $1baf
	ld [hl], a ; $1bb0
	inc de ; $1bb1
	inc hl ; $1bb2
	ld a, [de] ; $1bb3
	ld [hl], a ; $1bb4
	jr .done ; $1bb5
.insertNext:
	inc hl ; $1bb7
	inc hl ; $1bb8
	inc hl ; $1bb9
	dec c ; $1bba
	jr nz, .insertLoop ; $1bbb
	ld a, b ; $1bbd
	or a ; $1bbe
	jr nz, .done ; $1bbf
.done:
	call SortFrameTasks ; $1bc1
	ld a, $01 ; $1bc4
	ldh [hFrameTasksReady], a ; $1bc6
	add sp, 4 ; $1bc8
	ret ; $1bca
UnregisterFrameTask:
	add sp, -3 ; $1bcb
	push af ; $1bcd
	xor a ; $1bce
	ldh [hFrameTasksReady], a ; $1bcf
	pop af ; $1bd1
	ld d, h ; $1bd2
	ld e, l ; $1bd3
	ld hl, sp + 0 ; $1bd4
	push hl ; $1bd6
	ld [hl], e ; $1bd7
	inc hl ; $1bd8
	ld [hl], d ; $1bd9
	inc hl ; $1bda
	ldh a, [hRomBank] ; $1bdb
	ld [hl], a ; $1bdd
	pop de ; $1bde
	ld c, $10 ; $1bdf
	ld hl, wFrameTasks ; $1be1
.searchLoop:
	inc hl ; $1be4
	call Compare3Bytes ; $1be5
	jr nz, .next ; $1be8
	dec hl ; $1bea
	xor a ; $1beb
	ld [hl+], a ; $1bec
	ld [hl+], a ; $1bed
	ld [hl+], a ; $1bee
	ld [hl+], a ; $1bef
	jr .done ; $1bf0
.next:
	inc hl ; $1bf2
	inc hl ; $1bf3
	inc hl ; $1bf4
	dec c ; $1bf5
	jr nz, .searchLoop ; $1bf6
.done:
	ld a, $01 ; $1bf8
	ldh [hFrameTasksReady], a ; $1bfa
	add sp, 3 ; $1bfc
	ret ; $1bfe
RunFrameTasks:
	and $80 ; $1bff
	ld b, a ; $1c01
	ldh a, [hFrameTasksReady] ; $1c02
	or a ; $1c04
	ret z ; $1c05
	ldh a, [hRomBank] ; $1c06
	ld d, a ; $1c08
	ldh a, [hWramBank] ; $1c09
	ld e, a ; $1c0b
	push de ; $1c0c
	ld c, $10 ; $1c0d
	ld hl, wFrameTasks ; $1c0f
.loop:
	ld a, [hl+] ; $1c12
	xor b ; $1c13
	add a ; $1c14
	jr z, .next ; $1c15
	jr c, .next ; $1c17
	push bc ; $1c19
	push hl ; $1c1a
	ld a, [hl+] ; $1c1b
	ld e, a ; $1c1c
	ld a, [hl+] ; $1c1d
	ld d, a ; $1c1e
	ld a, [hl] ; $1c1f
	ldh [hRomBank], a ; $1c20
	ld [rROMB0], a ; $1c22
	ld l, e ; $1c25
	ld h, d ; $1c26
	call JumpToHL ; $1c27
	pop hl ; $1c2a
	pop bc ; $1c2b
.next:
	inc hl ; $1c2c
	inc hl ; $1c2d
	inc hl ; $1c2e
	dec c ; $1c2f
	jr nz, .loop ; $1c30
	pop de ; $1c32
	ld a, d ; $1c33
	ldh [hRomBank], a ; $1c34
	ld [rROMB0], a ; $1c36
	ld a, e ; $1c39
	wram_bank ; $1c3a
	ret ; $1c3e
SortFrameTasks:
	ld c, $0f ; $1c3f
.loop:
	ld hl, wFrameTasks ; $1c41
	ld de, wFrameTasks + 4 ; $1c44
	ld b, c ; $1c47
.loopB:
	ld a, [de] ; $1c48
	cp [hl] ; $1c49
	jr c, .next ; $1c4a
	push bc ; $1c4c
	ld c, $04 ; $1c4d
.loop2:
	ld b, [hl] ; $1c4f
	ld a, [de] ; $1c50
	ld [hl+], a ; $1c51
	ld a, b ; $1c52
	ld [de], a ; $1c53
	inc de ; $1c54
	dec c ; $1c55
	jr nz, .loop2 ; $1c56
	pop bc ; $1c58
	jr .next2 ; $1c59
.next:
	inc hl ; $1c5b
	inc de ; $1c5c
	inc hl ; $1c5d
	inc de ; $1c5e
	inc hl ; $1c5f
	inc de ; $1c60
	inc hl ; $1c61
	inc de ; $1c62
.next2:
	dec b ; $1c63
	jr nz, .loopB ; $1c64
	dec c ; $1c66
	jr nz, .loop ; $1c67
	ret ; $1c69
SplitColorComponents:
	push de ; $1c6a
	ld a, b ; $1c6b
	and $7c ; $1c6c
	rrca ; $1c6e
	rrca ; $1c6f
	ld e, a ; $1c70
	ld a, b ; $1c71
	and $03 ; $1c72
	ld b, a ; $1c74
	ld a, c ; $1c75
	and $e0 ; $1c76
	or b ; $1c78
	rlca ; $1c79
	rlca ; $1c7a
	rlca ; $1c7b
	ld b, a ; $1c7c
	ld a, c ; $1c7d
	and $1f ; $1c7e
	ld c, e ; $1c80
	pop de ; $1c81
	ret ; $1c82
CombineColorComponents:
	push af ; $1c83
	push de ; $1c84
	and $1f ; $1c85
	ld e, a ; $1c87
	ld a, b ; $1c88
	rrca ; $1c89
	rrca ; $1c8a
	rrca ; $1c8b
	ld b, a ; $1c8c
	and $e0 ; $1c8d
	or e ; $1c8f
	ld e, a ; $1c90
	ld a, b ; $1c91
	and $03 ; $1c92
	ld b, a ; $1c94
	ld a, c ; $1c95
	rlca ; $1c96
	rlca ; $1c97
	and $7c ; $1c98
	or b ; $1c9a
	ld b, a ; $1c9b
	ld c, e ; $1c9c
	pop de ; $1c9d
	pop af ; $1c9e
	ret ; $1c9f
AddClampColorComponent:
	add d ; $1ca0
	bit 7, a ; $1ca1
	jr z, .clampHigh ; $1ca3
	xor a ; $1ca5
	ret ; $1ca6
.clampHigh:
	cp $1f ; $1ca7
	ret c ; $1ca9
	ld a, $1f ; $1caa
	ret ; $1cac
AdjustColorRed:
	push af ; $1cad
	call SplitColorComponents ; $1cae
	call AddClampColorComponent ; $1cb1
	call CombineColorComponents ; $1cb4
	pop af ; $1cb7
	ret ; $1cb8
AdjustColorGreen:
	push af ; $1cb9
	call SplitColorComponents ; $1cba
	push af ; $1cbd
	ld a, b ; $1cbe
	call AddClampColorComponent ; $1cbf
	ld b, a ; $1cc2
	pop af ; $1cc3
	call CombineColorComponents ; $1cc4
	pop af ; $1cc7
	ret ; $1cc8
AdjustColorBlue:
	push af ; $1cc9
	call SplitColorComponents ; $1cca
	push af ; $1ccd
	ld a, c ; $1cce
	call AddClampColorComponent ; $1ccf
	ld c, a ; $1cd2
	pop af ; $1cd3
	call CombineColorComponents ; $1cd4
	pop af ; $1cd7
	ret ; $1cd8
AdjustColorsBrightness:
	push af ; $1cd9
	push bc ; $1cda
	push de ; $1cdb
	push hl ; $1cdc
.loop:
	push bc ; $1cdd
	push de ; $1cde
	ld d, c ; $1cdf
	ld a, [hl+] ; $1ce0
	ld c, a ; $1ce1
	ld a, [hl+] ; $1ce2
	ld b, a ; $1ce3
	call SplitColorComponents ; $1ce4
	call AddClampColorComponent ; $1ce7
	ld e, a ; $1cea
	ld a, b ; $1ceb
	call AddClampColorComponent ; $1cec
	ld b, a ; $1cef
	ld a, c ; $1cf0
	call AddClampColorComponent ; $1cf1
	ld c, a ; $1cf4
	ld a, e ; $1cf5
	call CombineColorComponents ; $1cf6
	pop de ; $1cf9
	ld a, c ; $1cfa
	ld [de], a ; $1cfb
	inc de ; $1cfc
	ld a, b ; $1cfd
	ld [de], a ; $1cfe
	inc de ; $1cff
	pop bc ; $1d00
	dec b ; $1d01
	jr nz, .loop ; $1d02
	pop hl ; $1d04
	pop de ; $1d05
	pop bc ; $1d06
	pop af ; $1d07
	ret ; $1d08
Unused_00_ForceFadeOut:
	push af ; $1d09
	jr BeginFadeOut.start ; $1d0a
ForceFadeIn:
	push af ; $1d0c
	jr BeginFadeIn.start ; $1d0d
Unused_00_BeginWhiteFadeOut:
	di ; $1d0f
	call BeginFadeOut ; $1d10
	push af ; $1d13
	ldh a, [hFadeState] ; $1d14
	or a ; $1d16
	jr z, .restore ; $1d17
	or $80 ; $1d19
	ldh [hFadeState], a ; $1d1b
.restore:
	pop af ; $1d1d
	ei ; $1d1e
	ret ; $1d1f
BeginFadeOut:
	push af ; $1d20
	ldh a, [hFadedOut] ; $1d21
	or a ; $1d23
	jr nz, BeginFadeIn.done ; $1d24
.start:
	ld a, $01 ; $1d26
	ldh [hFadeState], a ; $1d28
	ldh [hFadedOut], a ; $1d2a
	jr BeginFadeIn.setSpeed ; $1d2c
BeginFadeIn:
	push af ; $1d2e
	ldh a, [hFadedOut] ; $1d2f
	or a ; $1d31
	jr z, .done ; $1d32
.start:
	ld a, $02 ; $1d34
	ldh [hFadeState], a ; $1d36
	xor a ; $1d38
	ldh [hFadedOut], a ; $1d39
.setSpeed:
	ld a, c ; $1d3b
	and a ; $1d3c
	jr nz, .storeSpeed ; $1d3d
	inc a ; $1d3f
.storeSpeed:
	ldh [hFadeSpeed], a ; $1d40
	ld a, $7c ; $1d42
	ldh [hFadeCounter], a ; $1d44
.done:
	pop af ; $1d46
	ret ; $1d47
UpdateFadeIn:
	push af ; $1d48
	ldh a, [hFadeState] ; $1d49
	and $02 ; $1d4b
	jr z, UpdateFadeOut.restore2 ; $1d4d
	push bc ; $1d4f
	push de ; $1d50
	push hl ; $1d51
	ldh a, [hFadeSpeed] ; $1d52
	ld c, a ; $1d54
	ldh a, [hFadeCounter] ; $1d55
	sub c ; $1d57
	jr nc, .noCarry ; $1d58
	xor a ; $1d5a
.noCarry:
	ld c, a ; $1d5b
	jr UpdateFadeOut.step2 ; $1d5c
UpdateFadeOut:
	push af ; $1d5e
	ldh a, [hFadeState] ; $1d5f
	rrca ; $1d61
	jr nc, .restore2 ; $1d62
	push bc ; $1d64
	push de ; $1d65
	push hl ; $1d66
	ldh a, [hFadeSpeed] ; $1d67
	ld c, a ; $1d69
	ldh a, [hFadeCounter] ; $1d6a
	sub c ; $1d6c
	jr nc, .noCarry ; $1d6d
	xor a ; $1d6f
.noCarry:
	ld b, a ; $1d70
	ld a, $7c ; $1d71
	sub b ; $1d73
	ld c, a ; $1d74
	ld a, b ; $1d75
.step2:
	push af ; $1d76
	ldh a, [hFadeState] ; $1d77
	add a ; $1d79
	jr nc, .noCarry2 ; $1d7a
	ld a, c ; $1d7c
	and $04 ; $1d7d
	call z, Unused_00_ApplyWhiteFade ; $1d7f
	jr .restore ; $1d82
.noCarry2:
	ld hl, wMasterPalettes ; $1d84
	ld de, wBGPalettes ; $1d87
	ld b, $40 ; $1d8a
	srl c ; $1d8c
	srl c ; $1d8e
	call AdjustColorsBrightness ; $1d90
.restore:
	pop af ; $1d93
	and a ; $1d94
	jr nz, .store ; $1d95
	ldh [hFadeState], a ; $1d97
.store:
	ldh [hFadeCounter], a ; $1d99
	ld a, $03 ; $1d9b
	ldh [hPaletteDirtyFlags], a ; $1d9d
	pop hl ; $1d9f
	pop de ; $1da0
	pop bc ; $1da1
.restore2:
	pop af ; $1da2
	ret ; $1da3
WaitFadeEnd:
	push af ; $1da4
.loop:
	ldh a, [hFadeState] ; $1da5
	and a ; $1da7
	jr z, .done ; $1da8
	ldh a, [hLinkExchangeActive] ; $1daa
	or a ; $1dac
	jr z, .waitLocalFrame ; $1dad
	push af ; $1daf
	farcall SyncLinkFrame ; $1db0
	pop af ; $1db3
	jr .next ; $1db4
.waitLocalFrame:
	call AdvanceFrame ; $1db6
.next:
	jr .loop ; $1db9
.done:
	pop af ; $1dbb
	ret ; $1dbc

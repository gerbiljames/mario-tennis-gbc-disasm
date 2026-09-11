QuarterSineTable:
	; $0b5c, 65 bytes (bytes:16)
	db $00, $03, $06, $09, $0d, $10, $13, $16, $19, $1c, $1f, $22, $25, $28, $2b, $2e ; 0x00
	db $31, $34, $37, $3a, $3c, $3f, $42, $45, $47, $4a, $4c, $4f, $51, $54, $56, $58 ; 0x10
	db $5b, $5d, $5f, $61, $63, $65, $67, $69, $6b, $6c, $6e, $6f, $71, $72, $74, $75 ; 0x20
	db $76, $77, $79, $7a, $7b, $7b, $7c, $7d, $7e, $7e, $7f, $7f, $7f, $80, $80, $80 ; 0x30
	db $80 ; 0x40
MulHLByASignedFull:
	bit 7, h ; $0b9d
	jp z, MulHLByA ; $0b9f
	push af ; $0ba2
	xor a ; $0ba3
	sub l ; $0ba4
	ld l, a ; $0ba5
	sbc a ; $0ba6
	sub h ; $0ba7
	ld h, a ; $0ba8
	pop af ; $0ba9
	call MulHLByA ; $0baa
	push af ; $0bad
	xor a ; $0bae
	sub l ; $0baf
	ld l, a ; $0bb0
	sbc a ; $0bb1
	sub h ; $0bb2
	ld h, a ; $0bb3
	pop af ; $0bb4
	ret ; $0bb5
MulHLByAFracSigned:
	bit 7, h ; $0bb6
	jr z, MulHLByAFrac ; $0bb8
	push de ; $0bba
	ld d, a ; $0bbb
	xor a ; $0bbc
	sub l ; $0bbd
	ld l, a ; $0bbe
	sbc a ; $0bbf
	sub h ; $0bc0
	ld h, a ; $0bc1
	ld a, d ; $0bc2
	call MulHLByAFrac ; $0bc3
	ld d, a ; $0bc6
	xor a ; $0bc7
	sub l ; $0bc8
	ld l, a ; $0bc9
	sbc a ; $0bca
	sub h ; $0bcb
	ld h, a ; $0bcc
	ld a, d ; $0bcd
	pop de ; $0bce
	ret ; $0bcf
.loop:
	ld hl, $0000 ; $0bd0
	ret ; $0bd3
MulHLByAFrac:
	or a ; $0bd4
	jr z, MulHLByAFracSigned.loop ; $0bd5
	push de ; $0bd7
	ld e, l ; $0bd8
	ld d, h ; $0bd9
	rra ; $0bda
	jr c, .low0 ; $0bdb
	rra ; $0bdd
	jr c, .low1 ; $0bde
	rra ; $0be0
	jr c, .low2 ; $0be1
	rra ; $0be3
	jr c, .low3 ; $0be4
	rra ; $0be6
	jr c, .low4 ; $0be7
	rra ; $0be9
	jr c, .low5 ; $0bea
	rra ; $0bec
	jr c, .low6 ; $0bed
	jr .finish ; $0bef
.low1:
	srl h ; $0bf1
	jr .bit1 ; $0bf3
.low2:
	srl h ; $0bf5
	jr .bit2 ; $0bf7
.low3:
	srl h ; $0bf9
	jr .bit3 ; $0bfb
.low4:
	srl h ; $0bfd
	jr .bit4 ; $0bff
.low5:
	srl h ; $0c01
	jr .bit5 ; $0c03
.low6:
	srl h ; $0c05
	jr .bit6 ; $0c07
.low0:
	srl h ; $0c09
	rr l ; $0c0b
	rra ; $0c0d
	jr nc, .rot1 ; $0c0e
	add hl, de ; $0c10
.rot1:
	rr h ; $0c11
.bit1:
	rr l ; $0c13
	rra ; $0c15
	jr nc, .rot2 ; $0c16
	add hl, de ; $0c18
.rot2:
	rr h ; $0c19
.bit2:
	rr l ; $0c1b
	rra ; $0c1d
	jr nc, .rot3 ; $0c1e
	add hl, de ; $0c20
.rot3:
	rr h ; $0c21
.bit3:
	rr l ; $0c23
	rra ; $0c25
	jr nc, .rot4 ; $0c26
	add hl, de ; $0c28
.rot4:
	rr h ; $0c29
.bit4:
	rr l ; $0c2b
	rra ; $0c2d
	jr nc, .rot5 ; $0c2e
	add hl, de ; $0c30
.rot5:
	rr h ; $0c31
.bit5:
	rr l ; $0c33
	rra ; $0c35
	jr nc, .rot6 ; $0c36
	add hl, de ; $0c38
.rot6:
	rr h ; $0c39
.bit6:
	rr l ; $0c3b
	rra ; $0c3d
	jr nc, .finish ; $0c3e
	add hl, de ; $0c40
.finish:
	rr h ; $0c41
	rr l ; $0c43
	rra ; $0c45
	pop de ; $0c46
	ret ; $0c47
MulHLByDESigned:
	bit 7, h ; $0c48
	jr z, MulHLByDE ; $0c4a
	push af ; $0c4c
	ld a, l ; $0c4d
	cpl ; $0c4e
	add $01 ; $0c4f
	ld l, a ; $0c51
	ld a, h ; $0c52
	sbc $00 ; $0c53
	cpl ; $0c55
	ld h, a ; $0c56
	pop af ; $0c57
	call MulHLByDE ; $0c58
	push af ; $0c5b
	ld a, l ; $0c5c
	cpl ; $0c5d
	add $01 ; $0c5e
	ld l, a ; $0c60
	ld a, h ; $0c61
	sbc $00 ; $0c62
	cpl ; $0c64
	ld h, a ; $0c65
	pop af ; $0c66
	ret ; $0c67
Unused_00_MulHLByDEBothSigned:
	ld a, h ; $0c68
	xor d ; $0c69
	ldh [hMathSign], a ; $0c6a
	bit 7, h ; $0c6c
	jr z, .positive ; $0c6e
	xor a ; $0c70
	sub l ; $0c71
	ld l, a ; $0c72
	sbc a ; $0c73
	sub h ; $0c74
	ld h, a ; $0c75
.positive:
	bit 7, d ; $0c76
	jr z, .mulHLByDE ; $0c78
	xor a ; $0c7a
	sub e ; $0c7b
	ld e, a ; $0c7c
	sbc a ; $0c7d
	sub d ; $0c7e
	ld d, a ; $0c7f
.mulHLByDE:
	call MulHLByDE ; $0c80
	ldh a, [hMathSign] ; $0c83
	bit 7, a ; $0c85
	ret z ; $0c87
	xor a ; $0c88
	sub l ; $0c89
	ld l, a ; $0c8a
	sbc a ; $0c8b
	sub h ; $0c8c
	ld h, a ; $0c8d
	ret ; $0c8e
MulHLByDE:
	push de ; $0c8f
	push bc ; $0c90
	ld c, d ; $0c91
	ld a, e ; $0c92
	ld b, $00 ; $0c93
	push hl ; $0c95
	add a ; $0c96
	jr c, .loTop7 ; $0c97
	jr z, .loZero ; $0c99
	ld e, l ; $0c9b
	ld d, h ; $0c9c
	add a ; $0c9d
	jr c, .loBit6 ; $0c9e
	add a ; $0ca0
	jr c, .loBit5 ; $0ca1
	add a ; $0ca3
	jr c, .loBit4 ; $0ca4
	add a ; $0ca6
	jr c, .loBit3 ; $0ca7
	add a ; $0ca9
	jr c, .loBit2 ; $0caa
	add a ; $0cac
	jr c, .loBit1 ; $0cad
	xor a ; $0caf
	jr .loDone ; $0cb0
.loZero:
	ld hl, $0000 ; $0cb2
	jr .loDone ; $0cb5
.loTop7:
	ld e, l ; $0cb7
	ld d, h ; $0cb8
	add hl, hl ; $0cb9
	adc a ; $0cba
	jr nc, .loBit6 ; $0cbb
	add hl, de ; $0cbd
	adc b ; $0cbe
.loBit6:
	add hl, hl ; $0cbf
	adc a ; $0cc0
	jr nc, .loBit5 ; $0cc1
	add hl, de ; $0cc3
	adc b ; $0cc4
.loBit5:
	add hl, hl ; $0cc5
	adc a ; $0cc6
	jr nc, .loBit4 ; $0cc7
	add hl, de ; $0cc9
	adc b ; $0cca
.loBit4:
	add hl, hl ; $0ccb
	adc a ; $0ccc
	jr nc, .loBit3 ; $0ccd
	add hl, de ; $0ccf
	adc b ; $0cd0
.loBit3:
	add hl, hl ; $0cd1
	adc a ; $0cd2
	jr nc, .loBit2 ; $0cd3
	add hl, de ; $0cd5
	adc b ; $0cd6
.loBit2:
	add hl, hl ; $0cd7
	adc a ; $0cd8
	jr nc, .loBit1 ; $0cd9
	add hl, de ; $0cdb
	adc b ; $0cdc
.loBit1:
	add hl, hl ; $0cdd
	adc a ; $0cde
	jr nc, .loDone ; $0cdf
	add hl, de ; $0ce1
	adc b ; $0ce2
.loDone:
	ld e, h ; $0ce3
	ld d, a ; $0ce4
	ld a, c ; $0ce5
	ld c, l ; $0ce6
	pop hl ; $0ce7
	push de ; $0ce8
	add a ; $0ce9
	jr c, .hiTop7 ; $0cea
	jr z, .hiZero ; $0cec
	ld e, l ; $0cee
	ld d, h ; $0cef
	add a ; $0cf0
	jr c, .hiBit6 ; $0cf1
	add a ; $0cf3
	jr c, .hiBit5 ; $0cf4
	add a ; $0cf6
	jr c, .hiBit4 ; $0cf7
	add a ; $0cf9
	jr c, .hiBit3 ; $0cfa
	add a ; $0cfc
	jr c, .hiBit2 ; $0cfd
	add a ; $0cff
	jr c, .hiBit1 ; $0d00
	xor a ; $0d02
	jr .hiDone ; $0d03
.hiZero:
	ld hl, $0000 ; $0d05
	jr .hiDone ; $0d08
.hiTop7:
	ld e, l ; $0d0a
	ld d, h ; $0d0b
	add hl, hl ; $0d0c
	adc a ; $0d0d
	jr nc, .hiBit6 ; $0d0e
	add hl, de ; $0d10
	adc b ; $0d11
.hiBit6:
	add hl, hl ; $0d12
	adc a ; $0d13
	jr nc, .hiBit5 ; $0d14
	add hl, de ; $0d16
	adc b ; $0d17
.hiBit5:
	add hl, hl ; $0d18
	adc a ; $0d19
	jr nc, .hiBit4 ; $0d1a
	add hl, de ; $0d1c
	adc b ; $0d1d
.hiBit4:
	add hl, hl ; $0d1e
	adc a ; $0d1f
	jr nc, .hiBit3 ; $0d20
	add hl, de ; $0d22
	adc b ; $0d23
.hiBit3:
	add hl, hl ; $0d24
	adc a ; $0d25
	jr nc, .hiBit2 ; $0d26
	add hl, de ; $0d28
	adc b ; $0d29
.hiBit2:
	add hl, hl ; $0d2a
	adc a ; $0d2b
	jr nc, .hiBit1 ; $0d2c
	add hl, de ; $0d2e
	adc b ; $0d2f
.hiBit1:
	add hl, hl ; $0d30
	adc a ; $0d31
	jr nc, .hiDone ; $0d32
	add hl, de ; $0d34
	adc b ; $0d35
.hiDone:
	pop de ; $0d36
	add hl, de ; $0d37
	adc b ; $0d38
	ld b, a ; $0d39
	ld a, c ; $0d3a
	ldh [hMulResult], a ; $0d3b
	ld a, l ; $0d3d
	ldh [hMulResult + 1], a ; $0d3e
	ld a, h ; $0d40
	ld l, h ; $0d41
	ldh [hMulResult + 2], a ; $0d42
	ld a, b ; $0d44
	ld h, b ; $0d45
	ldh [hMulResult + 3], a ; $0d46
	pop bc ; $0d48
	pop de ; $0d49
	ret ; $0d4a
MulHLByDE32:
	push bc ; $0d4b
	ld c, d ; $0d4c
	ld a, e ; $0d4d
	ld b, $00 ; $0d4e
	push hl ; $0d50
	add a ; $0d51
	jr c, .carry ; $0d52
	jr z, .zero ; $0d54
	ld e, l ; $0d56
	ld d, h ; $0d57
	add a ; $0d58
	jr c, .offset ; $0d59
	add a ; $0d5b
	jr c, .offset2 ; $0d5c
	add a ; $0d5e
	jr c, .offset3 ; $0d5f
	add a ; $0d61
	jr c, .offset4 ; $0d62
	add a ; $0d64
	jr c, .offset5 ; $0d65
	add a ; $0d67
	jr c, .offset6 ; $0d68
	xor a ; $0d6a
	jr .step3 ; $0d6b
.zero:
	ld hl, $0000 ; $0d6d
	jr .step3 ; $0d70
.carry:
	ld e, l ; $0d72
	ld d, h ; $0d73
	add hl, hl ; $0d74
	adc a ; $0d75
	jr nc, .offset ; $0d76
	add hl, de ; $0d78
	adc b ; $0d79
.offset:
	add hl, hl ; $0d7a
	adc a ; $0d7b
	jr nc, .offset2 ; $0d7c
	add hl, de ; $0d7e
	adc b ; $0d7f
.offset2:
	add hl, hl ; $0d80
	adc a ; $0d81
	jr nc, .offset3 ; $0d82
	add hl, de ; $0d84
	adc b ; $0d85
.offset3:
	add hl, hl ; $0d86
	adc a ; $0d87
	jr nc, .offset4 ; $0d88
	add hl, de ; $0d8a
	adc b ; $0d8b
.offset4:
	add hl, hl ; $0d8c
	adc a ; $0d8d
	jr nc, .offset5 ; $0d8e
	add hl, de ; $0d90
	adc b ; $0d91
.offset5:
	add hl, hl ; $0d92
	adc a ; $0d93
	jr nc, .offset6 ; $0d94
	add hl, de ; $0d96
	adc b ; $0d97
.offset6:
	add hl, hl ; $0d98
	adc a ; $0d99
	jr nc, .step3 ; $0d9a
	add hl, de ; $0d9c
	adc b ; $0d9d
.step3:
	ld e, h ; $0d9e
	ld d, a ; $0d9f
	ld a, c ; $0da0
	ld c, l ; $0da1
	pop hl ; $0da2
	push de ; $0da3
	add a ; $0da4
	jr c, .carry2 ; $0da5
	jr z, .zero2 ; $0da7
	ld e, l ; $0da9
	ld d, h ; $0daa
	add a ; $0dab
	jr c, .offset7 ; $0dac
	add a ; $0dae
	jr c, .offset8 ; $0daf
	add a ; $0db1
	jr c, .offset9 ; $0db2
	add a ; $0db4
	jr c, .offset10 ; $0db5
	add a ; $0db7
	jr c, .offset11 ; $0db8
	add a ; $0dba
	jr c, .offset12 ; $0dbb
	xor a ; $0dbd
	jr .restore ; $0dbe
.zero2:
	ld hl, $0000 ; $0dc0
	jr .restore ; $0dc3
.carry2:
	ld e, l ; $0dc5
	ld d, h ; $0dc6
	add hl, hl ; $0dc7
	adc a ; $0dc8
	jr nc, .offset7 ; $0dc9
	add hl, de ; $0dcb
	adc b ; $0dcc
.offset7:
	add hl, hl ; $0dcd
	adc a ; $0dce
	jr nc, .offset8 ; $0dcf
	add hl, de ; $0dd1
	adc b ; $0dd2
.offset8:
	add hl, hl ; $0dd3
	adc a ; $0dd4
	jr nc, .offset9 ; $0dd5
	add hl, de ; $0dd7
	adc b ; $0dd8
.offset9:
	add hl, hl ; $0dd9
	adc a ; $0dda
	jr nc, .offset10 ; $0ddb
	add hl, de ; $0ddd
	adc b ; $0dde
.offset10:
	add hl, hl ; $0ddf
	adc a ; $0de0
	jr nc, .offset11 ; $0de1
	add hl, de ; $0de3
	adc b ; $0de4
.offset11:
	add hl, hl ; $0de5
	adc a ; $0de6
	jr nc, .offset12 ; $0de7
	add hl, de ; $0de9
	adc b ; $0dea
.offset12:
	add hl, hl ; $0deb
	adc a ; $0dec
	jr nc, .restore ; $0ded
	add hl, de ; $0def
	adc b ; $0df0
.restore:
	pop de ; $0df1
	add hl, de ; $0df2
	adc b ; $0df3
	ld e, c ; $0df4
	ld d, l ; $0df5
	ld l, h ; $0df6
	ld h, a ; $0df7
	pop bc ; $0df8
	ret ; $0df9
MulHLByASigned:
	bit 7, h ; $0dfa
	jr z, MulPosHLByA ; $0dfc
	call MulNegHLByA ; $0dfe
	xor a ; $0e01
	sub l ; $0e02
	ld l, a ; $0e03
	sbc a ; $0e04
	sub h ; $0e05
	ld h, a ; $0e06
	ret ; $0e07
MulNegHLByA:
	push de ; $0e08
	ld e, a ; $0e09
	xor a ; $0e0a
	sub l ; $0e0b
	ld l, a ; $0e0c
	sbc a ; $0e0d
	sub h ; $0e0e
	ld h, a ; $0e0f
	ld a, e ; $0e10
	jr MulPosHLByA.step ; $0e11
MulPosHLByA:
	push de ; $0e13
.step:
	add a ; $0e14
	jr c, .carry ; $0e15
	jr z, .zero ; $0e17
	ld e, l ; $0e19
	ld d, h ; $0e1a
	add a ; $0e1b
	jr c, .offset ; $0e1c
	add a ; $0e1e
	jr c, .offset2 ; $0e1f
	add a ; $0e21
	jr c, .offset3 ; $0e22
	add a ; $0e24
	jr c, .offset4 ; $0e25
	add a ; $0e27
	jr c, .offset5 ; $0e28
	add a ; $0e2a
	jr c, .offset6 ; $0e2b
	xor a ; $0e2d
	jr .step4 ; $0e2e
.zero:
	ld hl, $0000 ; $0e30
	jr .step4 ; $0e33
.carry:
	ld e, l ; $0e35
	ld d, h ; $0e36
	add hl, hl ; $0e37
	adc a ; $0e38
	jr nc, .offset ; $0e39
	add hl, de ; $0e3b
	adc $00 ; $0e3c
.offset:
	add hl, hl ; $0e3e
	adc a ; $0e3f
	jr nc, .offset2 ; $0e40
	add hl, de ; $0e42
	adc $00 ; $0e43
.offset2:
	add hl, hl ; $0e45
	adc a ; $0e46
	jr nc, .offset3 ; $0e47
	add hl, de ; $0e49
	adc $00 ; $0e4a
.offset3:
	add hl, hl ; $0e4c
	adc a ; $0e4d
	jr nc, .offset4 ; $0e4e
	add hl, de ; $0e50
	adc $00 ; $0e51
.offset4:
	add hl, hl ; $0e53
	adc a ; $0e54
	jr nc, .offset5 ; $0e55
	add hl, de ; $0e57
	adc $00 ; $0e58
.offset5:
	add hl, hl ; $0e5a
	adc a ; $0e5b
	jr nc, .offset6 ; $0e5c
	add hl, de ; $0e5e
	adc $00 ; $0e5f
.offset6:
	add hl, hl ; $0e61
	adc a ; $0e62
	jr nc, .step4 ; $0e63
	add hl, de ; $0e65
	adc $00 ; $0e66
.step4:
	ld l, h ; $0e68
	ld h, a ; $0e69
	pop de ; $0e6a
	ret ; $0e6b

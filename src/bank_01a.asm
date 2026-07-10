INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1a", ROMX[$4000], BANK[$1a]

	INCBIN "data/bank_01a/d_4000.bin" ; $4000, 3127 bytes
	ret ; $4c37
	INCBIN "data/bank_01a/d_4c38.bin" ; $4c38, 11901 bytes
	ld a, [$cb00] ; $7ab5
	or a, a ; $7ab8
	ret nz ; $7ab9
	ld a, $06 ; $7aba
	ldh [$ff96], a ; $7abc
	ldh [rWBK], a ; $7abe
	xor a, a ; $7ac0
	ld hl, $d0ab ; $7ac1
	ld [hl+], a ; $7ac4
	ld [hl+], a ; $7ac5
	ld [hl+], a ; $7ac6
	ld [hl+], a ; $7ac7
	ld [hl+], a ; $7ac8
	ld [hl+], a ; $7ac9
	ld [hl+], a ; $7aca
	ld [hl+], a ; $7acb
	ld [hl+], a ; $7acc
	ld [hl+], a ; $7acd
	ld [hl+], a ; $7ace
	ld a, [wEquippedRacket] ; $7acf
	or a, a ; $7ad2
	ret z ; $7ad3
	rst Rst18 ; $7ad4
	ld [de], a ; $7ad5
	ld [bc], a ; $7ad6
	ld hl, $c920 ; $7ad7
	ld de, $d0a0 ; $7ada
	ld a, [hl+] ; $7add
	ld [de], a ; $7ade
	inc de ; $7adf
	ld a, [hl+] ; $7ae0
	ld [de], a ; $7ae1
	inc de ; $7ae2
	ld a, [hl+] ; $7ae3
	ld [de], a ; $7ae4
	inc de ; $7ae5
	ld a, [hl+] ; $7ae6
	ld [de], a ; $7ae7
	inc de ; $7ae8
	ld a, [hl+] ; $7ae9
	ld [de], a ; $7aea
	inc de ; $7aeb
	ld a, [hl+] ; $7aec
	ld [de], a ; $7aed
	inc de ; $7aee
	ld a, [hl+] ; $7aef
	ld [de], a ; $7af0
	inc de ; $7af1
	ld a, [hl+] ; $7af2
	ld [de], a ; $7af3
	inc de ; $7af4
	ld a, [hl+] ; $7af5
	ld [de], a ; $7af6
	inc de ; $7af7
	ld a, [hl+] ; $7af8
	ld [de], a ; $7af9
	inc de ; $7afa
	ld a, [hl] ; $7afb
	ld [de], a ; $7afc
	ld hl, $d0a0 ; $7afd
	ld c, [hl] ; $7b00
	ld a, [$d00e] ; $7b01
	dec a ; $7b04
	sub a, c ; $7b05
	ld [$d0ab], a ; $7b06
	ld hl, $d0a1 ; $7b09
	ld c, [hl] ; $7b0c
	ld a, [$d00f] ; $7b0d
	dec a ; $7b10
	sub a, c ; $7b11
	ld [$d0ac], a ; $7b12
	ld hl, $d0a2 ; $7b15
	ld c, [hl] ; $7b18
	ld a, [$d010] ; $7b19
	dec a ; $7b1c
	sub a, c ; $7b1d
	ld [$d0ad], a ; $7b1e
	ld hl, $d0a3 ; $7b21
	ld c, [hl] ; $7b24
	ld a, [$d011] ; $7b25
	dec a ; $7b28
	sub a, c ; $7b29
	ld [$d0ae], a ; $7b2a
	ld hl, $d0a4 ; $7b2d
	ld c, [hl] ; $7b30
	ld a, [$d012] ; $7b31
	dec a ; $7b34
	sub a, c ; $7b35
	ld [$d0af], a ; $7b36
	ld hl, $d0a5 ; $7b39
	ld c, [hl] ; $7b3c
	ld a, [$d013] ; $7b3d
	dec a ; $7b40
	sub a, c ; $7b41
	ld [$d0b0], a ; $7b42
	ld hl, $d0a6 ; $7b45
	ld c, [hl] ; $7b48
	ld a, [$d014] ; $7b49
	dec a ; $7b4c
	sub a, c ; $7b4d
	ld [$d0b1], a ; $7b4e
	ld hl, $d0a7 ; $7b51
	ld c, [hl] ; $7b54
	ld a, [$d015] ; $7b55
	dec a ; $7b58
	sub a, c ; $7b59
	ld [$d0b2], a ; $7b5a
	ld hl, $d0a8 ; $7b5d
	ld c, [hl] ; $7b60
	ld a, [$d016] ; $7b61
	dec a ; $7b64
	sub a, c ; $7b65
	ld [$d0b3], a ; $7b66
	ld hl, $d0a9 ; $7b69
	ld c, [hl] ; $7b6c
	ld a, [$d017] ; $7b6d
	dec a ; $7b70
	sub a, c ; $7b71
	ld [$d0b4], a ; $7b72
	ld hl, $d0aa ; $7b75
	ld c, [hl] ; $7b78
	ld a, [$d018] ; $7b79
	dec a ; $7b7c
	sub a, c ; $7b7d
	ld [$d0b5], a ; $7b7e
	rst Rst18 ; $7b81
	INCBIN "data/bank_01a/d_7b82.bin" ; $7b82, 3 bytes
	ld hl, $7e7e ; $7b85
	ld de, $0c02 ; $7b88
	call Func_00_05b0 ; $7b8b
	ld a, $01 ; $7b8e
	ldh [$ff96], a ; $7b90
	ldh [rWBK], a ; $7b92
	ld hl, $7e8e ; $7b94
	ld de, $d000 ; $7b97
	call DecompressData ; $7b9a
	ld hl, $d000 ; $7b9d
	ld de, $a780 ; $7ba0
	ld c, $02 ; $7ba3
	call Func_00_0480 ; $7ba5
	ld hl, $7e99 ; $7ba8
	ld de, $d000 ; $7bab
	call DecompressData ; $7bae
	ld hl, $d000 ; $7bb1
	ld de, $a7a0 ; $7bb4
	ld c, $02 ; $7bb7
	call Func_00_0480 ; $7bb9
	ld hl, $7ea4 ; $7bbc
	ld de, $d000 ; $7bbf
	call DecompressData ; $7bc2
	ld hl, $d000 ; $7bc5
	ld de, $a7c0 ; $7bc8
	ld c, $02 ; $7bcb
	call Func_00_0480 ; $7bcd
	ld hl, $7eaf ; $7bd0
	ld de, $d000 ; $7bd3
	call DecompressData ; $7bd6
	ld hl, $d000 ; $7bd9
	ld de, $a7e0 ; $7bdc
	ld c, $02 ; $7bdf
	call Func_00_0480 ; $7be1
	ret ; $7be4
	ld a, $06 ; $7be5
	ldh [$ff96], a ; $7be7
	ldh [rWBK], a ; $7be9
	ld a, [$d142] ; $7beb
	dec a ; $7bee
	ret nz ; $7bef
	ld hl, $d145 ; $7bf0
	ld a, [hl+] ; $7bf3
	ld h, [hl] ; $7bf4
	ld l, a ; $7bf5
	ld a, h ; $7bf6
	or a, l ; $7bf7
	ret nz ; $7bf8
	ldh a, [$ff8c] ; $7bf9
	and a, $18 ; $7bfb
	ret z ; $7bfd
	ld a, [$d0ab] ; $7bfe
	or a, a ; $7c01
	jr z, Label_1a_7c2b ; $7c02
	call Func_1a_7dee ; $7c04
	call Func_1a_7df5 ; $7c07
	push af ; $7c0a
	ld a, [$d0a0] ; $7c0b
	ld l, a ; $7c0e
	ld a, [$d019] ; $7c0f
	add a, l ; $7c12
	ld de, $142c ; $7c13
	call Func_1a_7e23 ; $7c16
	push de ; $7c19
	call Func_00_1f51 ; $7c1a
	pop de ; $7c1d
	pop af ; $7c1e
	or a, a ; $7c1f
	jr z, Label_1a_7c2b ; $7c20
	call Func_1a_7e15 ; $7c22
	call Func_1a_7e38 ; $7c25
	call Func_00_1f51 ; $7c28
Label_1a_7c2b:
	ld a, [$d0ac] ; $7c2b
	or a, a ; $7c2e
	jr z, Label_1a_7c58 ; $7c2f
	call Func_1a_7dee ; $7c31
	call Func_1a_7df5 ; $7c34
	push af ; $7c37
	ld a, [$d0a1] ; $7c38
	ld l, a ; $7c3b
	ld a, [$d01a] ; $7c3c
	add a, l ; $7c3f
	ld de, $143c ; $7c40
	call Func_1a_7e23 ; $7c43
	push de ; $7c46
	call Func_00_1f51 ; $7c47
	pop de ; $7c4a
	pop af ; $7c4b
	or a, a ; $7c4c
	jr z, Label_1a_7c58 ; $7c4d
	call Func_1a_7e15 ; $7c4f
	call Func_1a_7e38 ; $7c52
	call Func_00_1f51 ; $7c55
Label_1a_7c58:
	ld a, [$d0ad] ; $7c58
	or a, a ; $7c5b
	jr z, Label_1a_7c85 ; $7c5c
	call Func_1a_7dee ; $7c5e
	call Func_1a_7df5 ; $7c61
	push af ; $7c64
	ld a, [$d0a2] ; $7c65
	ld l, a ; $7c68
	ld a, [$d01b] ; $7c69
	add a, l ; $7c6c
	ld de, $1454 ; $7c6d
	call Func_1a_7e23 ; $7c70
	push de ; $7c73
	call Func_00_1f51 ; $7c74
	pop de ; $7c77
	pop af ; $7c78
	or a, a ; $7c79
	jr z, Label_1a_7c85 ; $7c7a
	call Func_1a_7e15 ; $7c7c
	call Func_1a_7e38 ; $7c7f
	call Func_00_1f51 ; $7c82
Label_1a_7c85:
	ld a, [$d0ae] ; $7c85
	or a, a ; $7c88
	jr z, Label_1a_7cb2 ; $7c89
	call Func_1a_7dee ; $7c8b
	call Func_1a_7df5 ; $7c8e
	push af ; $7c91
	ld a, [$d0a3] ; $7c92
	ld l, a ; $7c95
	ld a, [$d01c] ; $7c96
	add a, l ; $7c99
	ld de, $1464 ; $7c9a
	call Func_1a_7e23 ; $7c9d
	push de ; $7ca0
	call Func_00_1f51 ; $7ca1
	pop de ; $7ca4
	pop af ; $7ca5
	or a, a ; $7ca6
	jr z, Label_1a_7cb2 ; $7ca7
	call Func_1a_7e15 ; $7ca9
	call Func_1a_7e38 ; $7cac
	call Func_00_1f51 ; $7caf
Label_1a_7cb2:
	ld a, [$d0af] ; $7cb2
	or a, a ; $7cb5
	jr z, Label_1a_7cdf ; $7cb6
	call Func_1a_7dee ; $7cb8
	call Func_1a_7df5 ; $7cbb
	push af ; $7cbe
	ld a, [$d0a4] ; $7cbf
	ld l, a ; $7cc2
	ld a, [$d01d] ; $7cc3
	add a, l ; $7cc6
	ld de, $1474 ; $7cc7
	call Func_1a_7e23 ; $7cca
	push de ; $7ccd
	call Func_00_1f51 ; $7cce
	pop de ; $7cd1
	pop af ; $7cd2
	or a, a ; $7cd3
	jr z, Label_1a_7cdf ; $7cd4
	call Func_1a_7e15 ; $7cd6
	call Func_1a_7e38 ; $7cd9
	call Func_00_1f51 ; $7cdc
Label_1a_7cdf:
	ld a, [$d0b0] ; $7cdf
	or a, a ; $7ce2
	jr z, Label_1a_7d0c ; $7ce3
	call Func_1a_7dee ; $7ce5
	call Func_1a_7df5 ; $7ce8
	push af ; $7ceb
	ld a, [$d0a5] ; $7cec
	ld l, a ; $7cef
	ld a, [$d01e] ; $7cf0
	add a, l ; $7cf3
	ld de, $642c ; $7cf4
	call Func_1a_7e23 ; $7cf7
	push de ; $7cfa
	call Func_00_1f51 ; $7cfb
	pop de ; $7cfe
	pop af ; $7cff
	or a, a ; $7d00
	jr z, Label_1a_7d0c ; $7d01
	call Func_1a_7e15 ; $7d03
	call Func_1a_7e38 ; $7d06
	call Func_00_1f51 ; $7d09
Label_1a_7d0c:
	ld a, [$d0b1] ; $7d0c
	or a, a ; $7d0f
	jr z, Label_1a_7d39 ; $7d10
	call Func_1a_7dee ; $7d12
	call Func_1a_7df5 ; $7d15
	push af ; $7d18
	ld a, [$d0a6] ; $7d19
	ld l, a ; $7d1c
	ld a, [$d01f] ; $7d1d
	add a, l ; $7d20
	ld de, $643c ; $7d21
	call Func_1a_7e23 ; $7d24
	push de ; $7d27
	call Func_00_1f51 ; $7d28
	pop de ; $7d2b
	pop af ; $7d2c
	or a, a ; $7d2d
	jr z, Label_1a_7d39 ; $7d2e
	call Func_1a_7e15 ; $7d30
	call Func_1a_7e38 ; $7d33
	call Func_00_1f51 ; $7d36
Label_1a_7d39:
	ld a, [$d0b2] ; $7d39
	or a, a ; $7d3c
	jr z, Label_1a_7d66 ; $7d3d
	call Func_1a_7dee ; $7d3f
	call Func_1a_7df5 ; $7d42
	push af ; $7d45
	ld a, [$d0a7] ; $7d46
	ld l, a ; $7d49
	ld a, [$d020] ; $7d4a
	add a, l ; $7d4d
	ld de, $6454 ; $7d4e
	call Func_1a_7e23 ; $7d51
	push de ; $7d54
	call Func_00_1f51 ; $7d55
	pop de ; $7d58
	pop af ; $7d59
	or a, a ; $7d5a
	jr z, Label_1a_7d66 ; $7d5b
	call Func_1a_7e15 ; $7d5d
	call Func_1a_7e38 ; $7d60
	call Func_00_1f51 ; $7d63
Label_1a_7d66:
	ld a, [$d0b3] ; $7d66
	or a, a ; $7d69
	jr z, Label_1a_7d93 ; $7d6a
	call Func_1a_7dee ; $7d6c
	call Func_1a_7df5 ; $7d6f
	push af ; $7d72
	ld a, [$d0a8] ; $7d73
	ld l, a ; $7d76
	ld a, [$d021] ; $7d77
	add a, l ; $7d7a
	ld de, $6464 ; $7d7b
	call Func_1a_7e23 ; $7d7e
	push de ; $7d81
	call Func_00_1f51 ; $7d82
	pop de ; $7d85
	pop af ; $7d86
	or a, a ; $7d87
	jr z, Label_1a_7d93 ; $7d88
	call Func_1a_7e15 ; $7d8a
	call Func_1a_7e38 ; $7d8d
	call Func_00_1f51 ; $7d90
Label_1a_7d93:
	ld a, [$d0b4] ; $7d93
	or a, a ; $7d96
	jr z, Label_1a_7dc0 ; $7d97
	call Func_1a_7dee ; $7d99
	call Func_1a_7df5 ; $7d9c
	push af ; $7d9f
	ld a, [$d0a9] ; $7da0
	ld l, a ; $7da3
	ld a, [$d022] ; $7da4
	add a, l ; $7da7
	ld de, $6474 ; $7da8
	call Func_1a_7e23 ; $7dab
	push de ; $7dae
	call Func_00_1f51 ; $7daf
	pop de ; $7db2
	pop af ; $7db3
	or a, a ; $7db4
	jr z, Label_1a_7dc0 ; $7db5
	call Func_1a_7e15 ; $7db7
	call Func_1a_7e38 ; $7dba
	call Func_00_1f51 ; $7dbd
Label_1a_7dc0:
	ld a, [$d0b5] ; $7dc0
	or a, a ; $7dc3
	jr z, Label_1a_7ded ; $7dc4
	call Func_1a_7dee ; $7dc6
	call Func_1a_7df5 ; $7dc9
	push af ; $7dcc
	ld a, [$d0aa] ; $7dcd
	ld l, a ; $7dd0
	ld a, [$d023] ; $7dd1
	add a, l ; $7dd4
	ld de, $6484 ; $7dd5
	call Func_1a_7e23 ; $7dd8
	push de ; $7ddb
	call Func_00_1f51 ; $7ddc
	pop de ; $7ddf
	pop af ; $7de0
	or a, a ; $7de1
	jr z, Label_1a_7ded ; $7de2
	call Func_1a_7e15 ; $7de4
	call Func_1a_7e38 ; $7de7
	call Func_00_1f51 ; $7dea
Label_1a_7ded:
	ret ; $7ded
Func_1a_7dee:
	ld b, $0c ; $7dee
	bit 7, a ; $7df0
	ret z ; $7df2
	inc b ; $7df3
	ret ; $7df4
Func_1a_7df5:
	bit 7, a ; $7df5
	jr nz, Label_1a_7e07 ; $7df7
	dec a ; $7df9
	jr z, Label_1a_7e02 ; $7dfa
	dec a ; $7dfc
	ld c, $7e ; $7dfd
	ld h, $02 ; $7dff
	ret ; $7e01
Label_1a_7e02:
	ld c, $7c ; $7e02
	ld h, $02 ; $7e04
	ret ; $7e06
Label_1a_7e07:
	inc a ; $7e07
	jr z, Label_1a_7e10 ; $7e08
	inc a ; $7e0a
	ld c, $7a ; $7e0b
	ld h, $01 ; $7e0d
	ret ; $7e0f
Label_1a_7e10:
	ld c, $78 ; $7e10
	ld h, $01 ; $7e12
	ret ; $7e14
Func_1a_7e15:
	bit 7, a ; $7e15
	jr nz, Label_1a_7e1e ; $7e17
	ld c, $7c ; $7e19
	ld h, $03 ; $7e1b
	ret ; $7e1d
Label_1a_7e1e:
	ld c, $78 ; $7e1e
	ld h, $00 ; $7e20
	ret ; $7e22
Func_1a_7e23:
	inc a ; $7e23
	rlca ; $7e24
	rlca ; $7e25
	add a, d ; $7e26
	ld d, a ; $7e27
	ld a, h ; $7e28
	add a, $34 ; $7e29
	ld l, a ; $7e2b
	adc a, $7e ; $7e2c
	sub a, l ; $7e2e
	ld h, a ; $7e2f
	ld a, [hl] ; $7e30
	add a, d ; $7e31
	ld d, a ; $7e32
	ret ; $7e33
	INCBIN "data/bank_01a/d_7e34.bin" ; $7e34, 4 bytes
Func_1a_7e38:
	bit 7, a ; $7e38
	jr nz, Label_1a_7e41 ; $7e3a
	ld a, $08 ; $7e3c
	add a, d ; $7e3e
	ld d, a ; $7e3f
	ret ; $7e40
Label_1a_7e41:
	ld a, $f8 ; $7e41
	add a, d ; $7e43
	ld d, a ; $7e44
	ret ; $7e45
	INCBIN "data/bank_01a/d_7e46.bin" ; $7e46, 442 bytes

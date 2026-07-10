INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $27", ROMX[$4000], BANK[$27]

	INCBIN "data/bank_027/d_4000.bin" ; $4000, 3348 bytes
	farcall FarPtr_0a_2e ; $4d14
	ld a, $09 ; $4d17
	ld b, $c0 ; $4d19
	farcall FarPtr_0a_2e ; $4d1b
	ld a, $0a ; $4d1e
	ld b, $c0 ; $4d20
	farcall FarPtr_0a_2e ; $4d22
	sound $96 ; $4d25
	ld a, $04 ; $4d27
	ld bc, $1f80 ; $4d29
	ld de, $3180 ; $4d2c
	farcall FarPtr_0a_22 ; $4d2f
	ld a, $28 ; $4d32
	call Func_27_7856 ; $4d34
	sound $96 ; $4d37
	ld a, $06 ; $4d39
	ld bc, $2180 ; $4d3b
	ld de, $3180 ; $4d3e
	farcall FarPtr_0a_22 ; $4d41
	ld a, $28 ; $4d44
	call Func_27_7856 ; $4d46
	sound $96 ; $4d49
	ld a, $04 ; $4d4b
	ld bc, $2380 ; $4d4d
	ld de, $3180 ; $4d50
	farcall FarPtr_0a_22 ; $4d53
	ld a, $28 ; $4d56
	call Func_27_7856 ; $4d58
	ld a, $06 ; $4d5b
	ld bc, $3f00 ; $4d5d
	ld de, $3f00 ; $4d60
	farcall FarPtr_0a_22 ; $4d63
	ld a, $28 ; $4d66
	call Func_27_7856 ; $4d68
	ld a, $04 ; $4d6b
	ld bc, $3f00 ; $4d6d
	ld de, $3f00 ; $4d70
	farcall FarPtr_0a_22 ; $4d73
	rst30 $05e0 ; $4d76
	jp z, Label_27_4e13 ; $4d79
	ld a, $02 ; $4d7c
	farcall FarPtr_0a_1c ; $4d7e
	ld a, $02 ; $4d81
	ld bc, $2d00 ; $4d83
	ld de, $3b00 ; $4d86
	farcall FarPtr_0a_22 ; $4d89
	ld a, $00 ; $4d8c
	ld bc, $2100 ; $4d8e
	ld de, $3b00 ; $4d91
	farcall FarPtr_0a_24 ; $4d94
	ld a, $02 ; $4d97
	ld bc, $2300 ; $4d99
	ld de, $3b00 ; $4d9c
	farcall FarPtr_0a_24 ; $4d9f
	ld a, $02 ; $4da2
	farcall FarPtr_0a_20 ; $4da4
	push af ; $4da7
	ld a, $05 ; $4da8
	farcall FarPtr_0a_04 ; $4daa
	pop af ; $4dad
	ld a, $00 ; $4dae
	ld b, $c0 ; $4db0
	farcall FarPtr_0a_2e ; $4db2
	call Func_27_516b ; $4db5
	ld a, $00 ; $4db8
	ld bc, $2100 ; $4dba
	ld de, $3500 ; $4dbd
	farcall FarPtr_0a_24 ; $4dc0
	ld a, $02 ; $4dc3
	ld bc, $2100 ; $4dc5
	ld de, $3b00 ; $4dc8
	farcall FarPtr_0a_24 ; $4dcb
	ld a, $02 ; $4dce
	farcall FarPtr_0a_20 ; $4dd0
	ld a, $00 ; $4dd3
	ld bc, $1f00 ; $4dd5
	ld de, $3500 ; $4dd8
	farcall FarPtr_0a_24 ; $4ddb
	ld a, $02 ; $4dde
	ld bc, $2100 ; $4de0
	ld de, $3500 ; $4de3
	farcall FarPtr_0a_24 ; $4de6
	ld a, $02 ; $4de9
	farcall FarPtr_0a_20 ; $4deb
	ld a, $02 ; $4dee
	ld bc, $2100 ; $4df0
	ld de, $3500 ; $4df3
	farcall FarPtr_0a_24 ; $4df6
	ld a, $02 ; $4df9
	farcall FarPtr_0a_20 ; $4dfb
	ld a, $00 ; $4dfe
	ld b, $c0 ; $4e00
	farcall FarPtr_0a_2e ; $4e02
	ld a, $02 ; $4e05
	ld b, $c0 ; $4e07
	farcall FarPtr_0a_2e ; $4e09
	ld a, $01 ; $4e0c
	call Func_27_7856 ; $4e0e
	jr Label_27_4e59 ; $4e11
Label_27_4e13:
	ld a, $00 ; $4e13
	ld bc, $2100 ; $4e15
	ld de, $3b00 ; $4e18
	farcall FarPtr_0a_24 ; $4e1b
	ld a, $00 ; $4e1e
	farcall FarPtr_0a_20 ; $4e20
	ld a, $00 ; $4e23
	ld b, $c0 ; $4e25
	farcall FarPtr_0a_2e ; $4e27
	call Func_27_516b ; $4e2a
	ld a, $00 ; $4e2d
	ld bc, $2100 ; $4e2f
	ld de, $3500 ; $4e32
	farcall FarPtr_0a_24 ; $4e35
	ld a, $00 ; $4e38
	farcall FarPtr_0a_20 ; $4e3a
	ld a, $00 ; $4e3d
	ld bc, $2000 ; $4e3f
	ld de, $3500 ; $4e42
	farcall FarPtr_0a_24 ; $4e45
	ld a, $00 ; $4e48
	farcall FarPtr_0a_20 ; $4e4a
	ld a, $00 ; $4e4d
	ld b, $c0 ; $4e4f
	farcall FarPtr_0a_2e ; $4e51
	ld a, $01 ; $4e54
	call Func_27_7856 ; $4e56
Label_27_4e59:
	call Func_27_51a1 ; $4e59
	ld a, $07 ; $4e5c
	ld d, $02 ; $4e5e
	farcall FarPtr_0a_34 ; $4e60
	ld a, $08 ; $4e63
	ld d, $02 ; $4e65
	farcall FarPtr_0a_34 ; $4e67
	ld a, $09 ; $4e6a
	ld d, $02 ; $4e6c
	farcall FarPtr_0a_34 ; $4e6e
	ld a, $0a ; $4e71
	ld d, $02 ; $4e73
	farcall FarPtr_0a_34 ; $4e75
	ld a, $0a ; $4e78
	farcall FarPtr_0a_36 ; $4e7a
	ld a, $1e ; $4e7d
	call Func_27_7856 ; $4e7f
	ld a, $0a ; $4e82
	ld bc, $1d00 ; $4e84
	ld de, $3500 ; $4e87
	farcall FarPtr_0a_24 ; $4e8a
	ld a, $09 ; $4e8d
	ld bc, $2300 ; $4e8f
	ld de, $3500 ; $4e92
	farcall FarPtr_0a_24 ; $4e95
	ld a, $08 ; $4e98
	ld bc, $2500 ; $4e9a
	ld de, $3500 ; $4e9d
	farcall FarPtr_0a_24 ; $4ea0
	ld a, $08 ; $4ea3
	farcall FarPtr_0a_20 ; $4ea5
	ld a, $0a ; $4ea8
	ld b, $00 ; $4eaa
	farcall FarPtr_0a_2e ; $4eac
	ld a, $09 ; $4eaf
	ld b, $80 ; $4eb1
	farcall FarPtr_0a_2e ; $4eb3
	ld a, $08 ; $4eb6
	ld b, $80 ; $4eb8
	farcall FarPtr_0a_2e ; $4eba
	ld a, $0a ; $4ebd
	call Func_27_7856 ; $4ebf
	rst30 $05e0 ; $4ec2
	jp z, Label_27_4f62 ; $4ec5
	ld a, $3c ; $4ec8
	call Func_27_7856 ; $4eca
	ld a, $02 ; $4ecd
	ld b, a ; $4ecf
	ld a, $00 ; $4ed0
	farcall FarPtr_0a_30 ; $4ed2
	ld a, $00 ; $4ed5
	ld d, $02 ; $4ed7
	farcall FarPtr_0a_34 ; $4ed9
	ld a, $00 ; $4edc
	farcall FarPtr_0a_36 ; $4ede
	ld a, $14 ; $4ee1
	call Func_27_7856 ; $4ee3
	ld a, $00 ; $4ee6
	ld b, a ; $4ee8
	ld a, $02 ; $4ee9
	farcall FarPtr_0a_30 ; $4eeb
	ld a, $01 ; $4eee
	call Func_27_7856 ; $4ef0
	ld a, $02 ; $4ef3
	ld d, $03 ; $4ef5
	farcall FarPtr_0a_34 ; $4ef7
	ld a, $02 ; $4efa
	farcall FarPtr_0a_36 ; $4efc
	ld a, $14 ; $4eff
	call Func_27_7856 ; $4f01
	ld a, $00 ; $4f04
	ld b, $c0 ; $4f06
	farcall FarPtr_0a_2e ; $4f08
	ld a, $02 ; $4f0b
	ld b, $c0 ; $4f0d
	farcall FarPtr_0a_2e ; $4f0f
	ld a, $08 ; $4f12
	ld d, $03 ; $4f14
	farcall FarPtr_0a_34 ; $4f16
	ld a, $09 ; $4f19
	ld d, $03 ; $4f1b
	farcall FarPtr_0a_34 ; $4f1d
	ld a, $0a ; $4f20
	ld d, $03 ; $4f22
	farcall FarPtr_0a_34 ; $4f24
	ld a, $0a ; $4f27
	farcall FarPtr_0a_36 ; $4f29
	ld a, $28 ; $4f2c
	call Func_27_7856 ; $4f2e
	ld a, $00 ; $4f31
	ld d, $03 ; $4f33
	farcall FarPtr_0a_34 ; $4f35
	ld a, $02 ; $4f38
	ld d, $03 ; $4f3a
	farcall FarPtr_0a_34 ; $4f3c
	ld a, $02 ; $4f3f
	farcall FarPtr_0a_36 ; $4f41
	ld a, $00 ; $4f44
	ld bc, $1f00 ; $4f46
	ld de, $3200 ; $4f49
	farcall FarPtr_0a_24 ; $4f4c
	ld a, $02 ; $4f4f
	ld bc, $2100 ; $4f51
	ld de, $3200 ; $4f54
	farcall FarPtr_0a_24 ; $4f57
	ld a, $02 ; $4f5a
	farcall FarPtr_0a_20 ; $4f5c
	jp Label_27_4fe7 ; $4f5f
Label_27_4f62:
	sound $96 ; $4f62
	ld a, $04 ; $4f64
	ld bc, $2180 ; $4f66
	ld de, $3380 ; $4f69
	farcall FarPtr_0a_22 ; $4f6c
	ld a, $50 ; $4f6f
	call Func_27_7856 ; $4f71
	ld a, $04 ; $4f74
	ld bc, $3f00 ; $4f76
	ld de, $3f00 ; $4f79
	farcall FarPtr_0a_22 ; $4f7c
	ld a, $0a ; $4f7f
	ld b, a ; $4f81
	ld a, $00 ; $4f82
	farcall FarPtr_0a_30 ; $4f84
	ld a, $28 ; $4f87
	call Func_27_7856 ; $4f89
	ld a, $00 ; $4f8c
	ld b, a ; $4f8e
	ld a, $0a ; $4f8f
	farcall FarPtr_0a_30 ; $4f91
	ld a, $01 ; $4f94
	call Func_27_7856 ; $4f96
	ld a, $0a ; $4f99
	ld d, $03 ; $4f9b
	farcall FarPtr_0a_34 ; $4f9d
	ld a, $0a ; $4fa0
	farcall FarPtr_0a_36 ; $4fa2
	ld a, $14 ; $4fa5
	call Func_27_7856 ; $4fa7
	ld a, $00 ; $4faa
	ld b, $c0 ; $4fac
	farcall FarPtr_0a_2e ; $4fae
	ld a, $08 ; $4fb1
	ld d, $03 ; $4fb3
	farcall FarPtr_0a_34 ; $4fb5
	ld a, $09 ; $4fb8
	ld d, $03 ; $4fba
	farcall FarPtr_0a_34 ; $4fbc
	ld a, $0a ; $4fbf
	ld d, $03 ; $4fc1
	farcall FarPtr_0a_34 ; $4fc3
	ld a, $0a ; $4fc6
	farcall FarPtr_0a_36 ; $4fc8
	ld a, $28 ; $4fcb
	call Func_27_7856 ; $4fcd
	ld a, $00 ; $4fd0
	ld d, $03 ; $4fd2
	farcall FarPtr_0a_34 ; $4fd4
	ld a, $00 ; $4fd7
	ld bc, $2000 ; $4fd9
	ld de, $3200 ; $4fdc
	farcall FarPtr_0a_24 ; $4fdf
	ld a, $00 ; $4fe2
	farcall FarPtr_0a_20 ; $4fe4
Label_27_4fe7:
	ld a, $01 ; $4fe7
	ld [$c294], a ; $4fe9
	ld [$c2a1], a ; $4fec
	ret ; $4fef
	INCBIN "data/bank_027/d_4ff0.bin" ; $4ff0, 379 bytes
Func_27_516b:
	push af ; $516b
	ld a, $0a ; $516c
	farcall FarPtr_0a_04 ; $516e
	pop af ; $5171
	sound $79 ; $5172
	ld b, $07 ; $5174
	ld c, $38 ; $5176
	ld d, $20 ; $5178
	ld e, $38 ; $517a
	ld h, $02 ; $517c
	ld l, $02 ; $517e
	farcall FarPtr_0a_7e ; $5180
	push af ; $5183
	ld a, $02 ; $5184
	farcall FarPtr_0a_04 ; $5186
	pop af ; $5189
	ld b, $0b ; $518a
	ld c, $38 ; $518c
	ld d, $20 ; $518e
	ld e, $38 ; $5190
	ld h, $02 ; $5192
	ld l, $02 ; $5194
	farcall FarPtr_0a_7e ; $5196
	push af ; $5199
	ld a, $04 ; $519a
	farcall FarPtr_0a_04 ; $519c
	pop af ; $519f
	ret ; $51a0
Func_27_51a1:
	sound $79 ; $51a1
	ld b, $07 ; $51a3
	ld c, $38 ; $51a5
	ld d, $20 ; $51a7
	ld e, $38 ; $51a9
	ld h, $02 ; $51ab
	ld l, $02 ; $51ad
	farcall FarPtr_0a_7e ; $51af
	push af ; $51b2
	ld a, $02 ; $51b3
	farcall FarPtr_0a_04 ; $51b5
	pop af ; $51b8
	ld b, $03 ; $51b9
	ld c, $38 ; $51bb
	ld d, $20 ; $51bd
	ld e, $38 ; $51bf
	ld h, $02 ; $51c1
	ld l, $02 ; $51c3
	farcall FarPtr_0a_7e ; $51c5
	push af ; $51c8
	ld a, $04 ; $51c9
	farcall FarPtr_0a_04 ; $51cb
	pop af ; $51ce
	ret ; $51cf
	INCBIN "data/bank_027/d_51d0.bin" ; $51d0, 9862 bytes
Func_27_7856:
	push af ; $7856
	ld a, a ; $7857
	farcall FarPtr_0a_04 ; $7858
	pop af ; $785b
	ret ; $785c
	INCBIN "data/bank_027/d_785d.bin" ; $785d, 1955 bytes

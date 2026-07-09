INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $27", ROMX[$4000], BANK[$27]

	INCBIN "data/bank_027/d_4000.bin" ; $4000, 3348 bytes
	rst Rst18 ; $4d14
	ld l, $0a ; $4d15
	ld a, $09 ; $4d17
	ld b, $c0 ; $4d19
	rst Rst18 ; $4d1b
	ld l, $0a ; $4d1c
	ld a, $0a ; $4d1e
	ld b, $c0 ; $4d20
	rst Rst18 ; $4d22
	ld l, $0a ; $4d23
	rst Rst08 ; $4d25
	sub a, [hl] ; $4d26
	ld a, $04 ; $4d27
	ld bc, $1f80 ; $4d29
	ld de, $3180 ; $4d2c
	rst Rst18 ; $4d2f
	ld [hl+], a ; $4d30
	ld a, [bc] ; $4d31
	ld a, $28 ; $4d32
	call Func_27_7856 ; $4d34
	rst Rst08 ; $4d37
	sub a, [hl] ; $4d38
	ld a, $06 ; $4d39
	ld bc, $2180 ; $4d3b
	ld de, $3180 ; $4d3e
	rst Rst18 ; $4d41
	ld [hl+], a ; $4d42
	ld a, [bc] ; $4d43
	ld a, $28 ; $4d44
	call Func_27_7856 ; $4d46
	rst Rst08 ; $4d49
	sub a, [hl] ; $4d4a
	ld a, $04 ; $4d4b
	ld bc, $2380 ; $4d4d
	ld de, $3180 ; $4d50
	rst Rst18 ; $4d53
	ld [hl+], a ; $4d54
	ld a, [bc] ; $4d55
	ld a, $28 ; $4d56
	call Func_27_7856 ; $4d58
	ld a, $06 ; $4d5b
	ld bc, $3f00 ; $4d5d
	ld de, $3f00 ; $4d60
	rst Rst18 ; $4d63
	ld [hl+], a ; $4d64
	ld a, [bc] ; $4d65
	ld a, $28 ; $4d66
	call Func_27_7856 ; $4d68
	ld a, $04 ; $4d6b
	ld bc, $3f00 ; $4d6d
	ld de, $3f00 ; $4d70
	rst Rst18 ; $4d73
	ld [hl+], a ; $4d74
	ld a, [bc] ; $4d75
	rst Rst30 ; $4d76
	ldh [rTIMA], a ; $4d77
	jp z, Label_27_4e13 ; $4d79
	ld a, $02 ; $4d7c
	rst Rst18 ; $4d7e
	inc e ; $4d7f
	ld a, [bc] ; $4d80
	ld a, $02 ; $4d81
	ld bc, $2d00 ; $4d83
	ld de, $3b00 ; $4d86
	rst Rst18 ; $4d89
	ld [hl+], a ; $4d8a
	ld a, [bc] ; $4d8b
	ld a, $00 ; $4d8c
	ld bc, $2100 ; $4d8e
	ld de, $3b00 ; $4d91
	rst Rst18 ; $4d94
	inc h ; $4d95
	ld a, [bc] ; $4d96
	ld a, $02 ; $4d97
	ld bc, $2300 ; $4d99
	ld de, $3b00 ; $4d9c
	rst Rst18 ; $4d9f
	inc h ; $4da0
	ld a, [bc] ; $4da1
	ld a, $02 ; $4da2
	rst Rst18 ; $4da4
	jr nz, Label_27_4db1 ; $4da5
	push af ; $4da7
	ld a, $05 ; $4da8
	rst Rst18 ; $4daa
	inc b ; $4dab
	ld a, [bc] ; $4dac
	pop af ; $4dad
	ld a, $00 ; $4dae
	INCBIN "data/bank_027/d_4db0.bin" ; $4db0, 1 bytes
Label_27_4db1:
	ret nz ; $4db1
	rst Rst18 ; $4db2
	ld l, $0a ; $4db3
	call Func_27_516b ; $4db5
	ld a, $00 ; $4db8
	ld bc, $2100 ; $4dba
	ld de, $3500 ; $4dbd
	rst Rst18 ; $4dc0
	inc h ; $4dc1
	ld a, [bc] ; $4dc2
	ld a, $02 ; $4dc3
	ld bc, $2100 ; $4dc5
	ld de, $3b00 ; $4dc8
	rst Rst18 ; $4dcb
	inc h ; $4dcc
	ld a, [bc] ; $4dcd
	ld a, $02 ; $4dce
	rst Rst18 ; $4dd0
	jr nz, Label_27_4ddd ; $4dd1
	ld a, $00 ; $4dd3
	ld bc, $1f00 ; $4dd5
	ld de, $3500 ; $4dd8
	rst Rst18 ; $4ddb
	inc h ; $4ddc
Label_27_4ddd:
	ld a, [bc] ; $4ddd
	ld a, $02 ; $4dde
	ld bc, $2100 ; $4de0
	ld de, $3500 ; $4de3
	rst Rst18 ; $4de6
	inc h ; $4de7
	ld a, [bc] ; $4de8
	ld a, $02 ; $4de9
	rst Rst18 ; $4deb
	jr nz, Label_27_4df8 ; $4dec
	ld a, $02 ; $4dee
	ld bc, $2100 ; $4df0
	ld de, $3500 ; $4df3
	rst Rst18 ; $4df6
	inc h ; $4df7
Label_27_4df8:
	ld a, [bc] ; $4df8
	ld a, $02 ; $4df9
	rst Rst18 ; $4dfb
	jr nz, Label_27_4e08 ; $4dfc
	ld a, $00 ; $4dfe
	ld b, $c0 ; $4e00
	rst Rst18 ; $4e02
	ld l, $0a ; $4e03
	ld a, $02 ; $4e05
	INCBIN "data/bank_027/d_4e07.bin" ; $4e07, 1 bytes
Label_27_4e08:
	ret nz ; $4e08
	rst Rst18 ; $4e09
	ld l, $0a ; $4e0a
	ld a, $01 ; $4e0c
	call Func_27_7856 ; $4e0e
	jr Label_27_4e59 ; $4e11
Label_27_4e13:
	ld a, $00 ; $4e13
	ld bc, $2100 ; $4e15
	ld de, $3b00 ; $4e18
	rst Rst18 ; $4e1b
	inc h ; $4e1c
	ld a, [bc] ; $4e1d
	ld a, $00 ; $4e1e
	rst Rst18 ; $4e20
	jr nz, Label_27_4e2d ; $4e21
	ld a, $00 ; $4e23
	ld b, $c0 ; $4e25
	rst Rst18 ; $4e27
	ld l, $0a ; $4e28
	call Func_27_516b ; $4e2a
Label_27_4e2d:
	ld a, $00 ; $4e2d
	ld bc, $2100 ; $4e2f
	ld de, $3500 ; $4e32
	rst Rst18 ; $4e35
	inc h ; $4e36
	ld a, [bc] ; $4e37
	ld a, $00 ; $4e38
	rst Rst18 ; $4e3a
	jr nz, Label_27_4e47 ; $4e3b
	ld a, $00 ; $4e3d
	ld bc, $2000 ; $4e3f
	ld de, $3500 ; $4e42
	rst Rst18 ; $4e45
	inc h ; $4e46
Label_27_4e47:
	ld a, [bc] ; $4e47
	ld a, $00 ; $4e48
	rst Rst18 ; $4e4a
	jr nz, Label_27_4e57 ; $4e4b
	ld a, $00 ; $4e4d
	ld b, $c0 ; $4e4f
	rst Rst18 ; $4e51
	ld l, $0a ; $4e52
	ld a, $01 ; $4e54
	INCBIN "data/bank_027/d_4e56.bin" ; $4e56, 1 bytes
Label_27_4e57:
	ld d, [hl] ; $4e57
	ld a, b ; $4e58
Label_27_4e59:
	call Func_27_51a1 ; $4e59
	ld a, $07 ; $4e5c
	ld d, $02 ; $4e5e
	rst Rst18 ; $4e60
	inc [hl] ; $4e61
	ld a, [bc] ; $4e62
	ld a, $08 ; $4e63
	ld d, $02 ; $4e65
	rst Rst18 ; $4e67
	inc [hl] ; $4e68
	ld a, [bc] ; $4e69
	ld a, $09 ; $4e6a
	ld d, $02 ; $4e6c
	rst Rst18 ; $4e6e
	inc [hl] ; $4e6f
	ld a, [bc] ; $4e70
	ld a, $0a ; $4e71
	ld d, $02 ; $4e73
	rst Rst18 ; $4e75
	inc [hl] ; $4e76
	ld a, [bc] ; $4e77
	ld a, $0a ; $4e78
	rst Rst18 ; $4e7a
	ld [hl], $0a ; $4e7b
	ld a, $1e ; $4e7d
	call Func_27_7856 ; $4e7f
	ld a, $0a ; $4e82
	ld bc, $1d00 ; $4e84
	ld de, $3500 ; $4e87
	rst Rst18 ; $4e8a
	inc h ; $4e8b
	ld a, [bc] ; $4e8c
	ld a, $09 ; $4e8d
	ld bc, $2300 ; $4e8f
	ld de, $3500 ; $4e92
	rst Rst18 ; $4e95
	inc h ; $4e96
	ld a, [bc] ; $4e97
	ld a, $08 ; $4e98
	ld bc, $2500 ; $4e9a
	ld de, $3500 ; $4e9d
	rst Rst18 ; $4ea0
	inc h ; $4ea1
	ld a, [bc] ; $4ea2
	ld a, $08 ; $4ea3
	rst Rst18 ; $4ea5
	jr nz, Label_27_4eb2 ; $4ea6
	ld a, $0a ; $4ea8
	ld b, $00 ; $4eaa
	rst Rst18 ; $4eac
	ld l, $0a ; $4ead
	ld a, $09 ; $4eaf
	INCBIN "data/bank_027/d_4eb1.bin" ; $4eb1, 1 bytes
Label_27_4eb2:
	add a, b ; $4eb2
	rst Rst18 ; $4eb3
	ld l, $0a ; $4eb4
	ld a, $08 ; $4eb6
	ld b, $80 ; $4eb8
	rst Rst18 ; $4eba
	ld l, $0a ; $4ebb
	ld a, $0a ; $4ebd
	call Func_27_7856 ; $4ebf
	rst Rst30 ; $4ec2
	ldh [rTIMA], a ; $4ec3
	jp z, Label_27_4f62 ; $4ec5
	ld a, $3c ; $4ec8
	call Func_27_7856 ; $4eca
	ld a, $02 ; $4ecd
	ld b, a ; $4ecf
	ld a, $00 ; $4ed0
	rst Rst18 ; $4ed2
	jr nc, Label_27_4edf ; $4ed3
	ld a, $00 ; $4ed5
	ld d, $02 ; $4ed7
	rst Rst18 ; $4ed9
	inc [hl] ; $4eda
	ld a, [bc] ; $4edb
	ld a, $00 ; $4edc
	rst Rst18 ; $4ede
Label_27_4edf:
	ld [hl], $0a ; $4edf
	ld a, $14 ; $4ee1
	call Func_27_7856 ; $4ee3
	ld a, $00 ; $4ee6
	ld b, a ; $4ee8
	ld a, $02 ; $4ee9
	rst Rst18 ; $4eeb
	jr nc, Label_27_4ef8 ; $4eec
	ld a, $01 ; $4eee
	call Func_27_7856 ; $4ef0
	ld a, $02 ; $4ef3
	ld d, $03 ; $4ef5
	rst Rst18 ; $4ef7
Label_27_4ef8:
	inc [hl] ; $4ef8
	ld a, [bc] ; $4ef9
	ld a, $02 ; $4efa
	rst Rst18 ; $4efc
	ld [hl], $0a ; $4efd
	ld a, $14 ; $4eff
	call Func_27_7856 ; $4f01
	ld a, $00 ; $4f04
	ld b, $c0 ; $4f06
	rst Rst18 ; $4f08
	ld l, $0a ; $4f09
	ld a, $02 ; $4f0b
	ld b, $c0 ; $4f0d
	rst Rst18 ; $4f0f
	ld l, $0a ; $4f10
	ld a, $08 ; $4f12
	ld d, $03 ; $4f14
	rst Rst18 ; $4f16
	inc [hl] ; $4f17
	ld a, [bc] ; $4f18
	ld a, $09 ; $4f19
	ld d, $03 ; $4f1b
	rst Rst18 ; $4f1d
	inc [hl] ; $4f1e
	ld a, [bc] ; $4f1f
	ld a, $0a ; $4f20
	ld d, $03 ; $4f22
	rst Rst18 ; $4f24
	inc [hl] ; $4f25
	ld a, [bc] ; $4f26
	ld a, $0a ; $4f27
	rst Rst18 ; $4f29
	ld [hl], $0a ; $4f2a
	ld a, $28 ; $4f2c
	call Func_27_7856 ; $4f2e
	ld a, $00 ; $4f31
	ld d, $03 ; $4f33
	rst Rst18 ; $4f35
	inc [hl] ; $4f36
	ld a, [bc] ; $4f37
	ld a, $02 ; $4f38
	ld d, $03 ; $4f3a
	rst Rst18 ; $4f3c
	inc [hl] ; $4f3d
	ld a, [bc] ; $4f3e
	ld a, $02 ; $4f3f
	rst Rst18 ; $4f41
	ld [hl], $0a ; $4f42
	ld a, $00 ; $4f44
	ld bc, $1f00 ; $4f46
	ld de, $3200 ; $4f49
	rst Rst18 ; $4f4c
	inc h ; $4f4d
	ld a, [bc] ; $4f4e
	ld a, $02 ; $4f4f
	ld bc, $2100 ; $4f51
	ld de, $3200 ; $4f54
	rst Rst18 ; $4f57
	inc h ; $4f58
	ld a, [bc] ; $4f59
	ld a, $02 ; $4f5a
	rst Rst18 ; $4f5c
	jr nz, Label_27_4f69 ; $4f5d
	jp Label_27_4fe7 ; $4f5f
Label_27_4f62:
	rst Rst08 ; $4f62
	sub a, [hl] ; $4f63
	ld a, $04 ; $4f64
	ld bc, $2180 ; $4f66
Label_27_4f69:
	ld de, $3380 ; $4f69
	rst Rst18 ; $4f6c
	ld [hl+], a ; $4f6d
	ld a, [bc] ; $4f6e
	ld a, $50 ; $4f6f
	call Func_27_7856 ; $4f71
	ld a, $04 ; $4f74
	ld bc, $3f00 ; $4f76
	ld de, $3f00 ; $4f79
	rst Rst18 ; $4f7c
	ld [hl+], a ; $4f7d
	ld a, [bc] ; $4f7e
	ld a, $0a ; $4f7f
	ld b, a ; $4f81
	ld a, $00 ; $4f82
	rst Rst18 ; $4f84
	jr nc, Label_27_4f91 ; $4f85
	ld a, $28 ; $4f87
	call Func_27_7856 ; $4f89
	ld a, $00 ; $4f8c
	ld b, a ; $4f8e
	ld a, $0a ; $4f8f
Label_27_4f91:
	rst Rst18 ; $4f91
	jr nc, Label_27_4f9e ; $4f92
	ld a, $01 ; $4f94
	call Func_27_7856 ; $4f96
	ld a, $0a ; $4f99
	ld d, $03 ; $4f9b
	rst Rst18 ; $4f9d
Label_27_4f9e:
	inc [hl] ; $4f9e
	ld a, [bc] ; $4f9f
	ld a, $0a ; $4fa0
	rst Rst18 ; $4fa2
	ld [hl], $0a ; $4fa3
	ld a, $14 ; $4fa5
	call Func_27_7856 ; $4fa7
	ld a, $00 ; $4faa
	ld b, $c0 ; $4fac
	rst Rst18 ; $4fae
	ld l, $0a ; $4faf
	ld a, $08 ; $4fb1
	ld d, $03 ; $4fb3
	rst Rst18 ; $4fb5
	inc [hl] ; $4fb6
	ld a, [bc] ; $4fb7
	ld a, $09 ; $4fb8
	ld d, $03 ; $4fba
	rst Rst18 ; $4fbc
	inc [hl] ; $4fbd
	ld a, [bc] ; $4fbe
	ld a, $0a ; $4fbf
	ld d, $03 ; $4fc1
	rst Rst18 ; $4fc3
	inc [hl] ; $4fc4
	ld a, [bc] ; $4fc5
	ld a, $0a ; $4fc6
	rst Rst18 ; $4fc8
	ld [hl], $0a ; $4fc9
	ld a, $28 ; $4fcb
	call Func_27_7856 ; $4fcd
	ld a, $00 ; $4fd0
	ld d, $03 ; $4fd2
	rst Rst18 ; $4fd4
	inc [hl] ; $4fd5
	ld a, [bc] ; $4fd6
	ld a, $00 ; $4fd7
	ld bc, $2000 ; $4fd9
	ld de, $3200 ; $4fdc
	rst Rst18 ; $4fdf
	inc h ; $4fe0
	ld a, [bc] ; $4fe1
	ld a, $00 ; $4fe2
	rst Rst18 ; $4fe4
	jr nz, Label_27_4ff1 ; $4fe5
Label_27_4fe7:
	ld a, $01 ; $4fe7
	ld [$c294], a ; $4fe9
	ld [$c2a1], a ; $4fec
	ret ; $4fef
	INCBIN "data/bank_027/d_4ff0.bin" ; $4ff0, 1 bytes
Label_27_4ff1:
	sub a, l ; $4ff1
	ld hl, $51dd ; $4ff2
	rst Rst18 ; $4ff5
	ld b, $0a ; $4ff6
	rst Rst18 ; $4ff8
	nop ; $4ff9
	ld a, [bc] ; $4ffa
	ld a, $04 ; $4ffb
	ld d, $06 ; $4ffd
	rst Rst18 ; $4fff
	inc [hl] ; $5000
	ld a, [bc] ; $5001
	rst Rst30 ; $5002
	ldh [rTIMA], a ; $5003
	jp z, Label_27_503c ; $5005
	ld a, $02 ; $5008
	rst Rst18 ; $500a
	inc e ; $500b
	ld a, [bc] ; $500c
	ld a, $00 ; $500d
	ld bc, $1f00 ; $500f
	ld de, $3400 ; $5012
	rst Rst18 ; $5015
	ld [hl+], a ; $5016
	ld a, [bc] ; $5017
	ld a, $02 ; $5018
	ld bc, $2100 ; $501a
	ld de, $3400 ; $501d
	rst Rst18 ; $5020
	ld [hl+], a ; $5021
	ld a, [bc] ; $5022
	ld a, $02 ; $5023
	ld b, $c0 ; $5025
	rst Rst18 ; $5027
	ld l, $0a ; $5028
	rst Rst30 ; $502a
	add a, b ; $502b
	rlca ; $502c
	jr nz, Label_27_5057 ; $502d
	ld a, $04 ; $502f
	ld bc, $3f00 ; $5031
	ld de, $3f00 ; $5034
	rst Rst18 ; $5037
	ld [hl+], a ; $5038
	ld a, [bc] ; $5039
	jr Label_27_5057 ; $503a
Label_27_503c:
	ld a, $00 ; $503c
	ld bc, $2000 ; $503e
	ld de, $3400 ; $5041
	rst Rst18 ; $5044
	ld [hl+], a ; $5045
	ld a, [bc] ; $5046
	rst Rst30 ; $5047
	and a, b ; $5048
	ld b, $20 ; $5049
	dec bc ; $504b
	ld a, $05 ; $504c
	ld bc, $3f00 ; $504e
	ld de, $3f00 ; $5051
	rst Rst18 ; $5054
	ld [hl+], a ; $5055
	ld a, [bc] ; $5056
Label_27_5057:
	ld a, $00 ; $5057
	ld b, $c0 ; $5059
	rst Rst18 ; $505b
	ld l, $0a ; $505c
	xor a, a ; $505e
	ld [$c2d5], a ; $505f
	ld c, $04 ; $5062
	call Func_00_1d2e ; $5064
	call Func_00_1da4 ; $5067
	rst Rst30 ; $506a
	ldh [rTIMA], a ; $506b
	jp z, Label_27_50ff ; $506d
	ld a, $00 ; $5070
	ld d, $03 ; $5072
	rst Rst18 ; $5074
	inc [hl] ; $5075
	ld a, [bc] ; $5076
	ld a, $00 ; $5077
	rst Rst18 ; $5079
	ld [hl], $0a ; $507a
	ld a, $03 ; $507c
	ld d, $03 ; $507e
	rst Rst18 ; $5080
	inc [hl] ; $5081
	ld a, [bc] ; $5082
	ld a, $03 ; $5083
	rst Rst18 ; $5085
	ld [hl], $0a ; $5086
	ld a, $3c ; $5088
	call Func_27_7856 ; $508a
	ld a, $02 ; $508d
	ld b, a ; $508f
	ld a, $00 ; $5090
	rst Rst18 ; $5092
	ld [hl-], a ; $5093
	ld a, [bc] ; $5094
	ld a, $1e ; $5095
	call Func_27_7856 ; $5097
	ld a, $00 ; $509a
	ld d, $03 ; $509c
	rst Rst18 ; $509e
	inc [hl] ; $509f
	ld a, [bc] ; $50a0
	ld a, $02 ; $50a1
	ld d, $03 ; $50a3
	rst Rst18 ; $50a5
	inc [hl] ; $50a6
	ld a, [bc] ; $50a7
	ld a, $02 ; $50a8
	rst Rst18 ; $50aa
	ld [hl], $0a ; $50ab
	ld a, $02 ; $50ad
	ld b, $40 ; $50af
	rst Rst18 ; $50b1
	ld l, $0a ; $50b2
	ld a, $00 ; $50b4
	ld bc, $2100 ; $50b6
	ld de, $3600 ; $50b9
	rst Rst18 ; $50bc
	inc h ; $50bd
	ld a, [bc] ; $50be
	ld a, $00 ; $50bf
	rst Rst18 ; $50c1
	jr nz, Label_27_50ce ; $50c2
	ld a, $00 ; $50c4
	ld bc, $2100 ; $50c6
	ld de, $3700 ; $50c9
	rst Rst18 ; $50cc
	inc h ; $50cd
Label_27_50ce:
	ld a, [bc] ; $50ce
	ld a, $02 ; $50cf
	ld bc, $2100 ; $50d1
	ld de, $3500 ; $50d4
	rst Rst18 ; $50d7
	inc h ; $50d8
	ld a, [bc] ; $50d9
	ld a, $02 ; $50da
	rst Rst18 ; $50dc
	jr nz, Label_27_50e9 ; $50dd
	call Func_27_516b ; $50df
	ldh a, [$ff95] ; $50e2
	ld b, a ; $50e4
	ld a, $00 ; $50e5
	INCBIN "data/bank_027/d_50e7.bin" ; $50e7, 2 bytes
Label_27_50e9:
	ld d, c ; $50e9
	rst Rst18 ; $50ea
	ld a, [de] ; $50eb
	ld a, [bc] ; $50ec
	ldh a, [$ff95] ; $50ed
	ld b, a ; $50ef
	ld a, $02 ; $50f0
	ld de, $51d0 ; $50f2
	rst Rst18 ; $50f5
	ld a, [de] ; $50f6
	ld a, [bc] ; $50f7
	ld a, $14 ; $50f8
	call Func_27_7856 ; $50fa
	jr Label_27_514f ; $50fd
Label_27_50ff:
	ld a, $00 ; $50ff
	ld d, $03 ; $5101
	rst Rst18 ; $5103
	inc [hl] ; $5104
	ld a, [bc] ; $5105
	ld a, $00 ; $5106
	rst Rst18 ; $5108
	ld [hl], $0a ; $5109
	ld a, $03 ; $510b
	ld d, $03 ; $510d
	rst Rst18 ; $510f
	inc [hl] ; $5110
	ld a, [bc] ; $5111
	ld a, $03 ; $5112
	rst Rst18 ; $5114
	ld [hl], $0a ; $5115
	ld a, $3c ; $5117
	call Func_27_7856 ; $5119
	ld a, $00 ; $511c
	ld bc, $2100 ; $511e
	ld de, $3400 ; $5121
	rst Rst18 ; $5124
	inc h ; $5125
	ld a, [bc] ; $5126
	ld a, $00 ; $5127
	rst Rst18 ; $5129
	jr nz, Label_27_5136 ; $512a
	ld a, $00 ; $512c
	ld bc, $2100 ; $512e
	ld de, $3700 ; $5131
	rst Rst18 ; $5134
	inc h ; $5135
Label_27_5136:
	ld a, [bc] ; $5136
	ld a, $00 ; $5137
	rst Rst18 ; $5139
	jr nz, Label_27_5146 ; $513a
	call Func_27_516b ; $513c
	ldh a, [$ff95] ; $513f
	ld b, a ; $5141
	ld a, $00 ; $5142
	INCBIN "data/bank_027/d_5144.bin" ; $5144, 2 bytes
Label_27_5146:
	ld d, c ; $5146
	rst Rst18 ; $5147
	ld a, [de] ; $5148
	ld a, [bc] ; $5149
	ld a, $14 ; $514a
	call Func_27_7856 ; $514c
Label_27_514f:
	call Func_27_51a1 ; $514f
	ld a, $3c ; $5152
	call Func_27_7856 ; $5154
	rst Rst20 ; $5157
	and a, b ; $5158
	dec c ; $5159
	ld c, $04 ; $515a
	call Func_00_1d20 ; $515c
	call Func_00_1da4 ; $515f
	ld a, $01 ; $5162
	ld [$c294], a ; $5164
	ld [$c2a1], a ; $5167
	ret ; $516a
Func_27_516b:
	push af ; $516b
	ld a, $0a ; $516c
	rst Rst18 ; $516e
	inc b ; $516f
	ld a, [bc] ; $5170
	pop af ; $5171
	rst Rst08 ; $5172
	ld a, c ; $5173
	ld b, $07 ; $5174
	ld c, $38 ; $5176
	ld d, $20 ; $5178
	ld e, $38 ; $517a
	ld h, $02 ; $517c
	ld l, $02 ; $517e
	rst Rst18 ; $5180
	ld a, [hl] ; $5181
	ld a, [bc] ; $5182
	push af ; $5183
	ld a, $02 ; $5184
	rst Rst18 ; $5186
	inc b ; $5187
	ld a, [bc] ; $5188
	pop af ; $5189
	ld b, $0b ; $518a
	ld c, $38 ; $518c
	ld d, $20 ; $518e
	ld e, $38 ; $5190
	ld h, $02 ; $5192
	ld l, $02 ; $5194
	rst Rst18 ; $5196
	ld a, [hl] ; $5197
	ld a, [bc] ; $5198
	push af ; $5199
	ld a, $04 ; $519a
	rst Rst18 ; $519c
	inc b ; $519d
	ld a, [bc] ; $519e
	pop af ; $519f
	ret ; $51a0
Func_27_51a1:
	rst Rst08 ; $51a1
	ld a, c ; $51a2
	ld b, $07 ; $51a3
	ld c, $38 ; $51a5
	ld d, $20 ; $51a7
	ld e, $38 ; $51a9
	ld h, $02 ; $51ab
	ld l, $02 ; $51ad
	rst Rst18 ; $51af
	ld a, [hl] ; $51b0
	ld a, [bc] ; $51b1
	push af ; $51b2
	ld a, $02 ; $51b3
	rst Rst18 ; $51b5
	inc b ; $51b6
	ld a, [bc] ; $51b7
	pop af ; $51b8
	ld b, $03 ; $51b9
	ld c, $38 ; $51bb
	ld d, $20 ; $51bd
	ld e, $38 ; $51bf
	ld h, $02 ; $51c1
	ld l, $02 ; $51c3
	rst Rst18 ; $51c5
	ld a, [hl] ; $51c6
	ld a, [bc] ; $51c7
	push af ; $51c8
	ld a, $04 ; $51c9
	rst Rst18 ; $51cb
	inc b ; $51cc
	ld a, [bc] ; $51cd
	pop af ; $51ce
	ret ; $51cf
	INCBIN "data/bank_027/d_51d0.bin" ; $51d0, 9862 bytes
Func_27_7856:
	push af ; $7856
	ld a, a ; $7857
	rst Rst18 ; $7858
	inc b ; $7859
	ld a, [bc] ; $785a
	pop af ; $785b
	ret ; $785c
	INCBIN "data/bank_027/d_785d.bin" ; $785d, 1955 bytes

DivAHLByDESigned:
	ld b, a ; $0e6c
	xor d ; $0e6d
	ldh [hMathSign], a ; $0e6e
	bit 7, d ; $0e70
	jr z, .positive ; $0e72
	xor a ; $0e74
	sub e ; $0e75
	ld e, a ; $0e76
	sbc a ; $0e77
	sub d ; $0e78
	ld d, a ; $0e79
.positive:
	ld a, b ; $0e7a
	bit 7, b ; $0e7b
	jr z, .divAHLByDE ; $0e7d
	ld a, l ; $0e7f
	cpl ; $0e80
	add $01 ; $0e81
	ld l, a ; $0e83
	ld a, h ; $0e84
	cpl ; $0e85
	adc $00 ; $0e86
	ld h, a ; $0e88
	ld a, b ; $0e89
	cpl ; $0e8a
	adc $00 ; $0e8b
.divAHLByDE:
	call DivAHLByDE ; $0e8d
	ld b, a ; $0e90
	ldh a, [hMathSign] ; $0e91
	bit 7, a ; $0e93
	ld a, b ; $0e95
	ret z ; $0e96
	ld a, l ; $0e97
	cpl ; $0e98
	add $01 ; $0e99
	ld l, a ; $0e9b
	ld a, h ; $0e9c
	cpl ; $0e9d
	adc $00 ; $0e9e
	ld h, a ; $0ea0
	ld a, b ; $0ea1
	cpl ; $0ea2
	adc $00 ; $0ea3
	ret ; $0ea5
DivAHLByDE:
	inc d ; $0ea6
	dec d ; $0ea7
	jr nz, .wideDivisor ; $0ea8
	bit 7, e ; $0eaa
	jp z, DivAHLByE ; $0eac
.wideDivisor:
	push bc ; $0eaf
	ldh [hDivDividendHi], a ; $0eb0
	xor a ; $0eb2
	sub e ; $0eb3
	ld c, a ; $0eb4
	sbc a ; $0eb5
	sub d ; $0eb6
	ld b, a ; $0eb7
	or c ; $0eb8
	jr nz, .divide ; $0eb9
	ld a, $ff ; $0ebb
	ld h, a ; $0ebd
	ld l, a ; $0ebe
	pop bc ; $0ebf
	ret ; $0ec0
.divide:
	ld a, l ; $0ec1
	push af ; $0ec2
	ldh a, [hDivDividendHi] ; $0ec3
	push hl ; $0ec5
	scf ; $0ec6
	ld hl, $0000 ; $0ec7
	adc a ; $0eca
	rl l ; $0ecb
	add hl, bc ; $0ecd
	jr c, .bit22 ; $0ece
	dec a ; $0ed0
	add hl, de ; $0ed1
.bit22:
	adc a ; $0ed2
	rl l ; $0ed3
	add hl, bc ; $0ed5
	jr c, .bit21 ; $0ed6
	dec a ; $0ed8
	add hl, de ; $0ed9
.bit21:
	adc a ; $0eda
	rl l ; $0edb
	add hl, bc ; $0edd
	jr c, .bit20 ; $0ede
	dec a ; $0ee0
	add hl, de ; $0ee1
.bit20:
	adc a ; $0ee2
	rl l ; $0ee3
	add hl, bc ; $0ee5
	jr c, .bit19 ; $0ee6
	dec a ; $0ee8
	add hl, de ; $0ee9
.bit19:
	adc a ; $0eea
	rl l ; $0eeb
	add hl, bc ; $0eed
	jr c, .bit18 ; $0eee
	dec a ; $0ef0
	add hl, de ; $0ef1
.bit18:
	adc a ; $0ef2
	rl l ; $0ef3
	add hl, bc ; $0ef5
	jr c, .bit17 ; $0ef6
	dec a ; $0ef8
	add hl, de ; $0ef9
.bit17:
	adc a ; $0efa
	rl l ; $0efb
	add hl, bc ; $0efd
	jr c, .bit16 ; $0efe
	dec a ; $0f00
	add hl, de ; $0f01
.bit16:
	adc a ; $0f02
	rl l ; $0f03
	add hl, bc ; $0f05
	jr c, .bit15 ; $0f06
	dec a ; $0f08
	add hl, de ; $0f09
.bit15:
	ldh [hDivQuotientHi], a ; $0f0a
	pop af ; $0f0c
	ld h, $00 ; $0f0d
	scf ; $0f0f
	adc a ; $0f10
	rl l ; $0f11
	rl h ; $0f13
	add hl, bc ; $0f15
	jr c, .bit14 ; $0f16
	dec a ; $0f18
	add hl, de ; $0f19
.bit14:
	adc a ; $0f1a
	rl l ; $0f1b
	rl h ; $0f1d
	add hl, bc ; $0f1f
	jr c, .bit13 ; $0f20
	dec a ; $0f22
	add hl, de ; $0f23
.bit13:
	adc a ; $0f24
	rl l ; $0f25
	rl h ; $0f27
	add hl, bc ; $0f29
	jr c, .bit12 ; $0f2a
	dec a ; $0f2c
	add hl, de ; $0f2d
.bit12:
	adc a ; $0f2e
	rl l ; $0f2f
	rl h ; $0f31
	add hl, bc ; $0f33
	jr c, .bit11 ; $0f34
	dec a ; $0f36
	add hl, de ; $0f37
.bit11:
	adc a ; $0f38
	rl l ; $0f39
	rl h ; $0f3b
	add hl, bc ; $0f3d
	jr c, .bit10 ; $0f3e
	dec a ; $0f40
	add hl, de ; $0f41
.bit10:
	adc a ; $0f42
	rl l ; $0f43
	rl h ; $0f45
	add hl, bc ; $0f47
	jr c, .bit9 ; $0f48
	dec a ; $0f4a
	add hl, de ; $0f4b
.bit9:
	adc a ; $0f4c
	rl l ; $0f4d
	rl h ; $0f4f
	add hl, bc ; $0f51
	jr c, .bit8 ; $0f52
	dec a ; $0f54
	add hl, de ; $0f55
.bit8:
	adc a ; $0f56
	rl l ; $0f57
	rl h ; $0f59
	add hl, bc ; $0f5b
	jr c, .bit7 ; $0f5c
	dec a ; $0f5e
	add hl, de ; $0f5f
.bit7:
	ldh [hDivQuotientMid], a ; $0f60
	pop af ; $0f62
	scf ; $0f63
	adc a ; $0f64
	rl l ; $0f65
	rl h ; $0f67
	add hl, bc ; $0f69
	jr c, .bit6 ; $0f6a
	dec a ; $0f6c
	add hl, de ; $0f6d
.bit6:
	adc a ; $0f6e
	rl l ; $0f6f
	rl h ; $0f71
	add hl, bc ; $0f73
	jr c, .bit5 ; $0f74
	dec a ; $0f76
	add hl, de ; $0f77
.bit5:
	adc a ; $0f78
	rl l ; $0f79
	rl h ; $0f7b
	add hl, bc ; $0f7d
	jr c, .bit4 ; $0f7e
	dec a ; $0f80
	add hl, de ; $0f81
.bit4:
	adc a ; $0f82
	rl l ; $0f83
	rl h ; $0f85
	add hl, bc ; $0f87
	jr c, .bit3 ; $0f88
	dec a ; $0f8a
	add hl, de ; $0f8b
.bit3:
	adc a ; $0f8c
	rl l ; $0f8d
	rl h ; $0f8f
	add hl, bc ; $0f91
	jr c, .bit2 ; $0f92
	dec a ; $0f94
	add hl, de ; $0f95
.bit2:
	adc a ; $0f96
	rl l ; $0f97
	rl h ; $0f99
	add hl, bc ; $0f9b
	jr c, .bit1 ; $0f9c
	dec a ; $0f9e
	add hl, de ; $0f9f
.bit1:
	adc a ; $0fa0
	rl l ; $0fa1
	rl h ; $0fa3
	add hl, bc ; $0fa5
	jr c, .bit0 ; $0fa6
	dec a ; $0fa8
	add hl, de ; $0fa9
.bit0:
	adc a ; $0faa
	rl l ; $0fab
	rl h ; $0fad
	add hl, bc ; $0faf
	jr c, .done ; $0fb0
	dec a ; $0fb2
	add hl, de ; $0fb3
.done:
	ld l, a ; $0fb4
	ldh a, [hDivQuotientMid] ; $0fb5
	ld h, a ; $0fb7
	ldh a, [hDivQuotientHi] ; $0fb8
	pop bc ; $0fba
	ret ; $0fbb
DivAHLByE:
	push bc ; $0fbc
	ld c, l ; $0fbd
	ld l, h ; $0fbe
	ld h, a ; $0fbf
	xor a ; $0fc0
	add hl, hl ; $0fc1
	adc a ; $0fc2
	cp e ; $0fc3
	jr c, .bit22 ; $0fc4
	inc l ; $0fc6
	sub e ; $0fc7
.bit22:
	add hl, hl ; $0fc8
	adc a ; $0fc9
	cp e ; $0fca
	jr c, .bit21 ; $0fcb
	inc l ; $0fcd
	sub e ; $0fce
.bit21:
	add hl, hl ; $0fcf
	adc a ; $0fd0
	cp e ; $0fd1
	jr c, .bit20 ; $0fd2
	inc l ; $0fd4
	sub e ; $0fd5
.bit20:
	add hl, hl ; $0fd6
	adc a ; $0fd7
	cp e ; $0fd8
	jr c, .bit19 ; $0fd9
	inc l ; $0fdb
	sub e ; $0fdc
.bit19:
	add hl, hl ; $0fdd
	adc a ; $0fde
	cp e ; $0fdf
	jr c, .bit18 ; $0fe0
	inc l ; $0fe2
	sub e ; $0fe3
.bit18:
	add hl, hl ; $0fe4
	adc a ; $0fe5
	cp e ; $0fe6
	jr c, .bit17 ; $0fe7
	inc l ; $0fe9
	sub e ; $0fea
.bit17:
	add hl, hl ; $0feb
	adc a ; $0fec
	cp e ; $0fed
	jr c, .bit16 ; $0fee
	inc l ; $0ff0
	sub e ; $0ff1
.bit16:
	add hl, hl ; $0ff2
	adc a ; $0ff3
	cp e ; $0ff4
	jr c, .bit15 ; $0ff5
	inc l ; $0ff7
	sub e ; $0ff8
.bit15:
	ld b, l ; $0ff9
	add hl, hl ; $0ffa
	adc a ; $0ffb
	cp e ; $0ffc
	jr c, .bit14 ; $0ffd
	inc l ; $0fff
	sub e ; $1000
.bit14:
	add hl, hl ; $1001
	adc a ; $1002
	cp e ; $1003
	jr c, .bit13 ; $1004
	inc l ; $1006
	sub e ; $1007
.bit13:
	add hl, hl ; $1008
	adc a ; $1009
	cp e ; $100a
	jr c, .bit12 ; $100b
	inc l ; $100d
	sub e ; $100e
.bit12:
	add hl, hl ; $100f
	adc a ; $1010
	cp e ; $1011
	jr c, .bit11 ; $1012
	inc l ; $1014
	sub e ; $1015
.bit11:
	add hl, hl ; $1016
	adc a ; $1017
	cp e ; $1018
	jr c, .bit10 ; $1019
	inc l ; $101b
	sub e ; $101c
.bit10:
	add hl, hl ; $101d
	adc a ; $101e
	cp e ; $101f
	jr c, .bit9 ; $1020
	inc l ; $1022
	sub e ; $1023
.bit9:
	add hl, hl ; $1024
	adc a ; $1025
	cp e ; $1026
	jr c, .bit8 ; $1027
	inc l ; $1029
	sub e ; $102a
.bit8:
	add hl, hl ; $102b
	adc a ; $102c
	cp e ; $102d
	jr c, .bit7 ; $102e
	inc l ; $1030
	sub e ; $1031
.bit7:
	ld h, c ; $1032
	add hl, hl ; $1033
	adc a ; $1034
	cp e ; $1035
	jr c, .bit6 ; $1036
	inc l ; $1038
	sub e ; $1039
.bit6:
	add hl, hl ; $103a
	adc a ; $103b
	cp e ; $103c
	jr c, .bit5 ; $103d
	inc l ; $103f
	sub e ; $1040
.bit5:
	add hl, hl ; $1041
	adc a ; $1042
	cp e ; $1043
	jr c, .bit4 ; $1044
	inc l ; $1046
	sub e ; $1047
.bit4:
	add hl, hl ; $1048
	adc a ; $1049
	cp e ; $104a
	jr c, .bit3 ; $104b
	inc l ; $104d
	sub e ; $104e
.bit3:
	add hl, hl ; $104f
	adc a ; $1050
	cp e ; $1051
	jr c, .bit2 ; $1052
	inc l ; $1054
	sub e ; $1055
.bit2:
	add hl, hl ; $1056
	adc a ; $1057
	cp e ; $1058
	jr c, .bit1 ; $1059
	inc l ; $105b
	sub e ; $105c
.bit1:
	add hl, hl ; $105d
	adc a ; $105e
	cp e ; $105f
	jr c, .bit0 ; $1060
	inc l ; $1062
	sub e ; $1063
.bit0:
	add hl, hl ; $1064
	adc a ; $1065
	cp e ; $1066
	jr c, .done ; $1067
	inc l ; $1069
	sub e ; $106a
.done:
	ld a, b ; $106b
	pop bc ; $106c
	ret ; $106d

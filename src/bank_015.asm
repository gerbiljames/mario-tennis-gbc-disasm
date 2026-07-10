INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $15", ROMX[$4000], BANK[$15]

	INCBIN "data/bank_015/d_4000.bin" ; $4000, 6 bytes
Label_15_4006:
	rst Rst18 ; $4006
	ld b, b ; $4007
	ld [de], a ; $4008
	ld b, b ; $4009
	ld e, c ; $400a
	ld b, c ; $400b
	sub a, d ; $400c
	ld b, c ; $400d
	sbc a, h ; $400e
	ld b, c ; $400f
	and a, [hl] ; $4010
	ld b, c ; $4011
	nop ; $4012
	nop ; $4013
	cp a, d ; $4014
	ld b, c ; $4015
	nop ; $4016
	add hl, bc ; $4017
	add a, b ; $4018
	dec e ; $4019
	ld b, b ; $401a
	nop ; $401b
	ld hl, $0001 ; $401c
	nop ; $401f
	nop ; $4020
	nop ; $4021
	ld l, l ; $4022
	ld a, l ; $4023
	nop ; $4024
	rlca ; $4025
	add a, b ; $4026
	dec e ; $4027
	ld b, b ; $4028
	nop ; $4029
	ld [hl+], a ; $402a
	ld bc, $0000 ; $402b
	nop ; $402e
	nop ; $402f
	ld [hl], a ; $4030
	ld a, l ; $4031
	nop ; $4032
	dec c ; $4033
	nop ; $4034
	dec de ; $4035
	add a, b ; $4036
	nop ; $4037
	inc sp ; $4038
	ld bc, $0003 ; $4039
	nop ; $403c
	nop ; $403d
	ld [hl], a ; $403e
	ld a, l ; $403f
	nop ; $4040
	dec e ; $4041
	nop ; $4042
	inc hl ; $4043
	ret nz ; $4044
	nop ; $4045
	inc [hl] ; $4046
	ld bc, $0007 ; $4047
	nop ; $404a
	nop ; $404b
	ld l, l ; $404c
	ld a, l ; $404d
	nop ; $404e
	rra ; $404f
	nop ; $4050
	dec e ; $4051
	add a, b ; $4052
	nop ; $4053
	jr nc, Label_15_4057 ; $4054
	dec b ; $4056
Label_15_4057:
	nop ; $4057
	nop ; $4058
	nop ; $4059
	ld l, l ; $405a
	ld a, l ; $405b
	nop ; $405c
	dec bc ; $405d
	nop ; $405e
	daa ; $405f
	add a, b ; $4060
	nop ; $4061
	add hl, sp ; $4062
	ld bc, $0000 ; $4063
	nop ; $4066
	nop ; $4067
	ld l, l ; $4068
	ld a, l ; $4069
	nop ; $406a
	add hl, bc ; $406b
	nop ; $406c
	add hl, hl ; $406d
	ret nz ; $406e
	nop ; $406f
	ld a, [hl-] ; $4070
	ld bc, $0000 ; $4071
	nop ; $4074
	nop ; $4075
	ld l, l ; $4076
	ld a, l ; $4077
	ld b, b ; $4078
	dec de ; $4079
	ld b, b ; $407a
	ld h, $80 ; $407b
	nop ; $407d
	ld [hl], $01 ; $407e
	nop ; $4080
	nop ; $4081
	nop ; $4082
	nop ; $4083
	ld l, l ; $4084
	ld a, l ; $4085
	ret nz ; $4086
	inc e ; $4087
	ld b, b ; $4088
	ld h, $80 ; $4089
	nop ; $408b
	ld [hl], $01 ; $408c
	nop ; $408e
	nop ; $408f
	nop ; $4090
	nop ; $4091
	ld l, l ; $4092
	ld a, l ; $4093
	ld b, b ; $4094
	rlca ; $4095
	ld b, b ; $4096
	ld h, $80 ; $4097
	nop ; $4099
	ld [hl], $01 ; $409a
	nop ; $409c
	nop ; $409d
	nop ; $409e
	nop ; $409f
	ld l, l ; $40a0
	ld a, l ; $40a1
	ret nz ; $40a2
	ld [$2640], sp ; $40a3
	add a, b ; $40a6
	nop ; $40a7
	ld [hl], $01 ; $40a8
	nop ; $40aa
	nop ; $40ab
	nop ; $40ac
	nop ; $40ad
	nop ; $40ae
	nop ; $40af
	nop ; $40b0
	nop ; $40b1
	nop ; $40b2
	nop ; $40b3
	nop ; $40b4
	rst Rst38 ; $40b5
	ld bc, $0080 ; $40b6
	ld hl, $1400 ; $40b9
	nop ; $40bc
	nop ; $40bd
	ld [bc], a ; $40be
	nop ; $40bf
	nop ; $40c0
	inc bc ; $40c1
	nop ; $40c2
	inc d ; $40c3
	nop ; $40c4
	nop ; $40c5
	inc bc ; $40c6
	ld b, b ; $40c7
	nop ; $40c8
	ld [de], a ; $40c9
	nop ; $40ca
	dec c ; $40cb
	nop ; $40cc
	nop ; $40cd
	inc b ; $40ce
	ret nz ; $40cf
	nop ; $40d0
	ld [de], a ; $40d1
	nop ; $40d2
	add hl, hl ; $40d3
	nop ; $40d4
	nop ; $40d5
	rrca ; $40d6
	ret nz ; $40d7
	nop ; $40d8
	ld de, $3900 ; $40d9
	nop ; $40dc
	nop ; $40dd
	rst Rst38 ; $40de
	ld bc, $00ff ; $40df
	nop ; $40e2
	sub a, l ; $40e3
	ld a, l ; $40e4
	ld d, $02 ; $40e5
	ld [bc], a ; $40e7
	rst Rst38 ; $40e8
	nop ; $40e9
	nop ; $40ea
	sub a, l ; $40eb
	ld a, l ; $40ec
	rla ; $40ed
	ld [bc], a ; $40ee
	inc bc ; $40ef
	rst Rst38 ; $40f0
	nop ; $40f1
	nop ; $40f2
	sub a, l ; $40f3
	ld a, l ; $40f4
	add hl, de ; $40f5
	dec b ; $40f6
	inc b ; $40f7
	rst Rst38 ; $40f8
	nop ; $40f9
	nop ; $40fa
	sub a, l ; $40fb
	ld a, l ; $40fc
	dec de ; $40fd
	ld [bc], a ; $40fe
	rst Rst38 ; $40ff
	ld a, [$c2b0] ; $4100
	add a, a ; $4103
	add a, $4b ; $4104
	ld l, a ; $4106
	adc a, $41 ; $4107
	sub a, l ; $4109
	ld h, a ; $410a
	ld a, [hl+] ; $410b
	ld h, [hl] ; $410c
	ld l, a ; $410d
	rst Rst18 ; $410e
	ld c, $0a ; $410f
	rst Rst30 ; $4111
	ldh [rTIMA], a ; $4112
	jr z, Label_15_4120 ; $4114
	rst Rst30 ; $4116
	ldh [$ff0e], a ; $4117
	jr nz, Label_15_413f ; $4119
	rst Rst20 ; $411b
	ldh [$ff0e], a ; $411c
	jr $4128 ; $411e
Label_15_4120:
	rst Rst30 ; $4120
	ret nz ; $4121
	ld c, $20 ; $4122
	ld a, [de] ; $4124
	rst Rst20 ; $4125
	ret nz ; $4126
	ld c, $3e ; $4127
	dec b ; $4129
	rst Rst18 ; $412a
	ld [$3e0a], sp ; $412b
	dec b ; $412e
	ld d, $02 ; $412f
	rst Rst18 ; $4131
	inc [hl] ; $4132
	ld a, [bc] ; $4133
	ld a, $05 ; $4134
	rst Rst18 ; $4136
	ld [hl], $0a ; $4137
	ld a, $05 ; $4139
	rst Rst18 ; $413b
	ld [$c90a], sp ; $413c
Label_15_413f:
	ld hl, $2420 ; $413f
	rst Rst18 ; $4142
	ld c, $0a ; $4143
	ld a, $05 ; $4145
	rst Rst18 ; $4147
	ld [$c90a], sp ; $4148
	ld e, $24 ; $414b
	daa ; $414d
	inc h ; $414e
	daa ; $414f
	inc h ; $4150
	daa ; $4151
	inc h ; $4152
	ld a, [hl-] ; $4153
	inc h ; $4154
	ld b, d ; $4155
	inc h ; $4156
	ld c, d ; $4157
	inc h ; $4158
	inc bc ; $4159
	rst Rst38 ; $415a
	nop ; $415b
	nop ; $415c
	inc e ; $415d
	inc h ; $415e
	inc de ; $415f
	nop ; $4160
	inc b ; $4161
	rst Rst38 ; $4162
	nop ; $4163
	nop ; $4164
	dec e ; $4165
	inc h ; $4166
	inc bc ; $4167
	nop ; $4168
	dec b ; $4169
	rst Rst38 ; $416a
	nop ; $416b
	nop ; $416c
	nop ; $416d
	ld b, c ; $416e
	inc de ; $416f
	nop ; $4170
	ld b, $ff ; $4171
	nop ; $4173
	nop ; $4174
	ld hl, $1324 ; $4175
	nop ; $4178
	rlca ; $4179
	rst Rst38 ; $417a
	nop ; $417b
	nop ; $417c
	ld [hl+], a ; $417d
	inc h ; $417e
	inc bc ; $417f
	nop ; $4180
	ld [$00ff], sp ; $4181
	nop ; $4184
	inc hl ; $4185
	inc h ; $4186
	inc bc ; $4187
	nop ; $4188
	add hl, bc ; $4189
	rst Rst38 ; $418a
	nop ; $418b
	nop ; $418c
	inc h ; $418d
	inc h ; $418e
	inc bc ; $418f
	nop ; $4190
	rst Rst38 ; $4191
	ld bc, $00ff ; $4192
	nop ; $4195
	sbc a, e ; $4196
	ld b, c ; $4197
	nop ; $4198
	nop ; $4199
	rst Rst38 ; $419a
	ret ; $419b
	INCBIN "data/bank_015/d_419c.bin" ; $419c, 1905 bytes
	ld a, [$c295] ; $490d
	cp a, $ff ; $4910
	jp z, Label_15_4955 ; $4912
	call Func_15_4967 ; $4915
	rst Rst30 ; $4918
	ldh [rTIMA], a ; $4919
	jr z, Label_15_4943 ; $491b
	ld a, $02 ; $491d
	ld bc, $00ff ; $491f
	rst Rst18 ; $4922
	jr Label_15_492f ; $4923
	INCBIN "data/bank_015/d_4925.bin" ; $4925, 10 bytes
Label_15_492f:
	ld a, $02 ; $492f
	rst Rst18 ; $4931
	jr nz, Label_15_493e ; $4932
	ld a, $02 ; $4934
	ld b, $00 ; $4936
	rst Rst18 ; $4938
	ld l, $0a ; $4939
	ld a, $02 ; $493b
	INCBIN "data/bank_015/d_493d.bin" ; $493d, 1 bytes
Label_15_493e:
	stop ; $493e
	rst Rst18 ; $4940
	jr Label_15_494d ; $4941
Label_15_4943:
	ld a, $00 ; $4943
	ld bc, $0010 ; $4945
	rst Rst18 ; $4948
	jr Label_15_4955 ; $4949
	ld a, $00 ; $494b
Label_15_494d:
	ld b, $00 ; $494d
	ld de, $0200 ; $494f
	rst Rst18 ; $4952
	ld a, [hl+] ; $4953
	ld a, [bc] ; $4954
Label_15_4955:
	ret ; $4955
	INCBIN "data/bank_015/d_4956.bin" ; $4956, 17 bytes
Func_15_4967:
	rst Rst28 ; $4967
	ld b, b ; $4968
	rla ; $4969
	rst Rst28 ; $496a
	and a, b ; $496b
	rla ; $496c
	rst Rst28 ; $496d
	ld h, b ; $496e
	rla ; $496f
	rst Rst28 ; $4970
	ret nz ; $4971
	rla ; $4972
	rst Rst28 ; $4973
	add a, b ; $4974
	rla ; $4975
	rst Rst28 ; $4976
	ldh [rAUD2ENV], a ; $4977
	ret ; $4979
	INCBIN "data/bank_015/d_497a.bin" ; $497a, 248 bytes
	rst Rst18 ; $4a72
	ld [$c90a], sp ; $4a73
	sub a, d ; $4a76
	ld a, [de] ; $4a77
	sbc a, b ; $4a78
	ld a, [de] ; $4a79
	sbc a, h ; $4a7a
	ld a, [de] ; $4a7b
	sbc a, h ; $4a7c
	ld a, [de] ; $4a7d
	sbc a, h ; $4a7e
	ld a, [de] ; $4a7f
	ld a, [$c2b0] ; $4a80
	add a, a ; $4a83
	add a, $97 ; $4a84
	ld l, a ; $4a86
	adc a, $4a ; $4a87
	sub a, l ; $4a89
	ld h, a ; $4a8a
	ld a, [hl+] ; $4a8b
	ld h, [hl] ; $4a8c
	ld l, a ; $4a8d
	rst Rst18 ; $4a8e
	ld c, $0a ; $4a8f
	ld a, $0f ; $4a91
	rst Rst18 ; $4a93
	ld [$c90a], sp ; $4a94
	add a, d ; $4a97
	ld a, [de] ; $4a98
	add a, a ; $4a99
	ld a, [de] ; $4a9a
	adc a, d ; $4a9b
	ld a, [de] ; $4a9c
	adc a, d ; $4a9d
	ld a, [de] ; $4a9e
	adc a, d ; $4a9f
	ld a, [de] ; $4aa0
	ld a, [$c2b0] ; $4aa1
	add a, a ; $4aa4
	add a, $d7 ; $4aa5
	ld l, a ; $4aa7
	adc a, $4a ; $4aa8
	sub a, l ; $4aaa
	ld h, a ; $4aab
	ld a, [hl+] ; $4aac
	ld h, [hl] ; $4aad
	ld l, a ; $4aae
	rst Rst18 ; $4aaf
	ld c, $0a ; $4ab0
	ld a, [$c2b0] ; $4ab2
	cp a, $01 ; $4ab5
	jr nc, Label_15_4ad1 ; $4ab7
	ld a, $0f ; $4ab9
	rst Rst18 ; $4abb
	ld a, [bc] ; $4abc
	ld a, [bc] ; $4abd
	rst Rst18 ; $4abe
	ld [de], a ; $4abf
	ld a, [bc] ; $4ac0
	rst Rst18 ; $4ac1
	inc c ; $4ac2
	ld a, [bc] ; $4ac3
	push af ; $4ac4
	ld a, $05 ; $4ac5
	rst Rst18 ; $4ac7
	inc b ; $4ac8
	ld a, [bc] ; $4ac9
	pop af ; $4aca
	and a, a ; $4acb
	jr z, Label_15_4ad1 ; $4acc
	rst Rst18 ; $4ace
	INCBIN "data/bank_015/d_4acf.bin" ; $4acf, 2 bytes
Label_15_4ad1:
	ld a, $0f ; $4ad1
	rst Rst18 ; $4ad3
	ld [$c90a], sp ; $4ad4
	add a, e ; $4ad7
	ld a, [de] ; $4ad8
	adc a, b ; $4ad9
	ld a, [de] ; $4ada
	adc a, e ; $4adb
	ld a, [de] ; $4adc
	adc a, e ; $4add
	ld a, [de] ; $4ade
	adc a, e ; $4adf
	ld a, [de] ; $4ae0
	ld a, [$c2b0] ; $4ae1
	add a, a ; $4ae4
	add a, $17 ; $4ae5
	ld l, a ; $4ae7
	adc a, $4b ; $4ae8
	sub a, l ; $4aea
	ld h, a ; $4aeb
	ld a, [hl+] ; $4aec
	ld h, [hl] ; $4aed
	ld l, a ; $4aee
	rst Rst18 ; $4aef
	ld c, $0a ; $4af0
	ld a, [$c2b0] ; $4af2
	cp a, $02 ; $4af5
	jr c, Label_15_4b11 ; $4af7
	ld a, $10 ; $4af9
	rst Rst18 ; $4afb
	ld a, [bc] ; $4afc
	ld a, [bc] ; $4afd
	rst Rst18 ; $4afe
	ld [de], a ; $4aff
	ld a, [bc] ; $4b00
	rst Rst18 ; $4b01
	inc c ; $4b02
	ld a, [bc] ; $4b03
	push af ; $4b04
	ld a, $05 ; $4b05
	rst Rst18 ; $4b07
	inc b ; $4b08
	ld a, [bc] ; $4b09
	pop af ; $4b0a
	and a, a ; $4b0b
	jr z, Label_15_4b11 ; $4b0c
	rst Rst18 ; $4b0e
	INCBIN "data/bank_015/d_4b0f.bin" ; $4b0f, 2 bytes
Label_15_4b11:
	ld a, $10 ; $4b11
	rst Rst18 ; $4b13
	ld [$c90a], sp ; $4b14
	add a, [hl] ; $4b17
	ld a, [de] ; $4b18
	adc a, c ; $4b19
	ld a, [de] ; $4b1a
	adc a, h ; $4b1b
	ld a, [de] ; $4b1c
	adc a, h ; $4b1d
	ld a, [de] ; $4b1e
	adc a, h ; $4b1f
	ld a, [de] ; $4b20
	ld a, $13 ; $4b21
	ld b, $00 ; $4b23
	rst Rst18 ; $4b25
	inc a ; $4b26
	ld a, [bc] ; $4b27
	rst Rst18 ; $4b28
	ld a, $0a ; $4b29
	ld a, $00 ; $4b2b
	rst Rst18 ; $4b2d
	ld d, $0a ; $4b2e
	ld a, $01 ; $4b30
	ld e, l ; $4b32
	ld d, h ; $4b33
	ld hl, $0018 ; $4b34
	add hl, de ; $4b37
	ld [hl], a ; $4b38
	ld hl, $1a9f ; $4b39
	rst Rst18 ; $4b3c
	ld c, $0a ; $4b3d
	ld a, $13 ; $4b3f
	rst Rst18 ; $4b41
	ld a, [bc] ; $4b42
	ld a, [bc] ; $4b43
	rst Rst18 ; $4b44
	ld [de], a ; $4b45
	ld a, [bc] ; $4b46
	rst Rst18 ; $4b47
	inc c ; $4b48
	ld a, [bc] ; $4b49
	push af ; $4b4a
	ld a, $05 ; $4b4b
	rst Rst18 ; $4b4d
	inc b ; $4b4e
	ld a, [bc] ; $4b4f
	pop af ; $4b50
	and a, a ; $4b51
	jp nz, Label_15_4b6e ; $4b52
	ld a, $00 ; $4b55
	ld d, $03 ; $4b57
	rst Rst18 ; $4b59
	inc [hl] ; $4b5a
	ld a, [bc] ; $4b5b
	ld a, $00 ; $4b5c
	rst Rst18 ; $4b5e
	ld [hl], $0a ; $4b5f
	ld a, $13 ; $4b61
	rst Rst18 ; $4b63
	ld [$f50a], sp ; $4b64
	ld a, $0a ; $4b67
	rst Rst18 ; $4b69
	inc b ; $4b6a
	ld a, [bc] ; $4b6b
	pop af ; $4b6c
	ret ; $4b6d
Label_15_4b6e:
	rst Rst20 ; $4b6e
	nop ; $4b6f
	INCBIN "data/bank_015/d_4b70.bin" ; $4b70, 1982 bytes
	call Func_15_7fa0 ; $532e
	ld a, [$c2b0] ; $5331
	cp a, $05 ; $5334
	jr c, Label_15_5340 ; $5336
	ld a, [$c2b0] ; $5338
	sub a, $06 ; $533b
	ld [$c2b0], a ; $533d
Label_15_5340:
	ld a, [$c295] ; $5340
	cp a, $0f ; $5343
	jr nz, Label_15_534b ; $5345
	call Func_15_59c0 ; $5347
	ret ; $534a
Label_15_534b:
	call Func_15_71be ; $534b
	call Func_15_724a ; $534e
	call Func_15_7204 ; $5351
	call Func_15_7a45 ; $5354
	ld a, [$c295] ; $5357
	cp a, $0a ; $535a
	jr nz, Label_15_5362 ; $535c
	call Func_15_536d ; $535e
	ret ; $5361
Label_15_5362:
	ld a, [$c295] ; $5362
	cp a, $09 ; $5365
	jr nz, Label_15_536c ; $5367
	call Func_15_7a67 ; $5369
Label_15_536c:
	ret ; $536c
Func_15_536d:
	ld a, [$c4c7] ; $536d
	cp a, $01 ; $5370
	jr nz, Label_15_5378 ; $5372
	call Func_15_53a9 ; $5374
	ret ; $5377
Label_15_5378:
	ld a, [$c8f7] ; $5378
	cp a, $12 ; $537b
	jr c, Label_15_5380 ; $537d
	ret ; $537f
Label_15_5380:
	ld a, [$c8f7] ; $5380
	ld a, a ; $5383
	rst Rst00 ; $5384
	add a, l ; $5385
	ld e, [hl] ; $5386
	or a, a ; $5387
	ld e, [hl] ; $5388
	rst Rst18 ; $5389
	ld e, [hl] ; $538a
	sub a, b ; $538b
	ld [hl], d ; $538c
	sbc a, a ; $538d
	ld [hl], d ; $538e
	or a, h ; $538f
	ld [hl], d ; $5390
	cp a, a ; $5391
	ld h, d ; $5392
	nop ; $5393
	ld h, e ; $5394
	jr z, Label_15_53fa ; $5395
	add hl, sp ; $5397
	ld [hl], l ; $5398
	ld c, [hl] ; $5399
	ld [hl], l ; $539a
	ld h, e ; $539b
	ld [hl], l ; $539c
	ld d, b ; $539d
	ld h, e ; $539e
	sub a, c ; $539f
	ld h, e ; $53a0
	cp a, c ; $53a1
	ld h, e ; $53a2
	xor a, d ; $53a3
	ld [hl], a ; $53a4
	cp a, l ; $53a5
	ld [hl], a ; $53a6
	ret nc ; $53a7
	ld [hl], a ; $53a8
Func_15_53a9:
	ld a, [$c8f7] ; $53a9
	ld a, a ; $53ac
	rst Rst00 ; $53ad
	jp nc, $d253 ; $53ae
	ld d, e ; $53b1
	jp nc, Label_00_3753 ; $53b2
	ld d, h ; $53b5
	scf ; $53b6
	ld d, h ; $53b7
	scf ; $53b8
	ld d, h ; $53b9
	add a, d ; $53ba
	ld d, h ; $53bb
	add a, d ; $53bc
	ld d, h ; $53bd
	add a, d ; $53be
	ld d, h ; $53bf
	rst Rst20 ; $53c0
	ld d, h ; $53c1
	rst Rst20 ; $53c2
	ld d, h ; $53c3
	rst Rst20 ; $53c4
	ld d, h ; $53c5
	ld [hl-], a ; $53c6
	ld d, l ; $53c7
	ld [hl-], a ; $53c8
	ld d, l ; $53c9
	ld [hl-], a ; $53ca
	ld d, l ; $53cb
	sub a, a ; $53cc
	ld d, l ; $53cd
	sub a, a ; $53ce
	ld d, l ; $53cf
	sub a, a ; $53d0
	ld d, l ; $53d1
	xor a, a ; $53d2
	ld [$c2d5], a ; $53d3
	ld a, $06 ; $53d6
	ld [$c2b1], a ; $53d8
	ld a, $00 ; $53db
	ld bc, $1800 ; $53dd
	ld de, $1100 ; $53e0
	rst Rst18 ; $53e3
	ld [hl+], a ; $53e4
	ld a, [bc] ; $53e5
	ld a, $00 ; $53e6
	ld b, $c0 ; $53e8
	rst Rst18 ; $53ea
	ld l, $0a ; $53eb
	ld a, [$c2b1] ; $53ed
	ld bc, $1800 ; $53f0
	ld de, $0d00 ; $53f3
	rst Rst18 ; $53f6
	ld [hl+], a ; $53f7
	ld a, [bc] ; $53f8
	INCBIN "data/bank_015/d_53f9.bin" ; $53f9, 1 bytes
Label_15_53fa:
	or a, c ; $53fa
	jp nz, Label_15_4006 ; $53fb
	rst Rst18 ; $53fe
	ld l, $0a ; $53ff
	ld a, $02 ; $5401
	rst Rst18 ; $5403
	inc e ; $5404
	ld a, [bc] ; $5405
	ld a, $02 ; $5406
	ld bc, $1300 ; $5408
	ld de, $1100 ; $540b
	rst Rst18 ; $540e
	ld [hl+], a ; $540f
	ld a, [bc] ; $5410
	ld a, $02 ; $5411
	ld b, $00 ; $5413
	rst Rst18 ; $5415
	ld l, $0a ; $5416
	ld bc, $00f0 ; $5418
	rst Rst18 ; $541b
	jr c, Label_15_5428 ; $541c
	xor a, a ; $541e
	ld bc, $1800 ; $541f
	ld de, $0f00 ; $5422
	rst Rst18 ; $5425
	ld a, [hl-] ; $5426
	ld a, [bc] ; $5427
Label_15_5428:
	rst Rst18 ; $5428
	ld a, $0a ; $5429
	ld c, $08 ; $542b
	call Func_00_1d2e ; $542d
	call Func_00_1da4 ; $5430
	call Func_15_6179 ; $5433
	ret ; $5436
	INCBIN "data/bank_015/d_5437.bin" ; $5437, 1417 bytes
Func_15_59c0:
	xor a, a ; $59c0
	ld [$c2d5], a ; $59c1
	ldh a, [$ff95] ; $59c4
	ld hl, $5c4f ; $59c6
	rst Rst18 ; $59c9
	ld b, $0a ; $59ca
	rst Rst18 ; $59cc
	nop ; $59cd
	ld a, [bc] ; $59ce
	ld a, $00 ; $59cf
	ld bc, $3f00 ; $59d1
	ld de, $3f00 ; $59d4
	rst Rst18 ; $59d7
	ld [hl+], a ; $59d8
	ld a, [bc] ; $59d9
	ld a, $0d ; $59da
	ld bc, $3f00 ; $59dc
	ld de, $3f00 ; $59df
	rst Rst18 ; $59e2
	ld [hl+], a ; $59e3
	ld a, [bc] ; $59e4
	ld a, $0d ; $59e5
	ld bc, $0700 ; $59e7
	ld de, $36c0 ; $59ea
	rst Rst18 ; $59ed
	ld [hl+], a ; $59ee
	ld a, [bc] ; $59ef
	ld a, $0d ; $59f0
	ld bc, $1f00 ; $59f2
	ld de, $36c0 ; $59f5
	rst Rst18 ; $59f8
	inc h ; $59f9
	ld a, [bc] ; $59fa
	push af ; $59fb
	ld a, $0a ; $59fc
	rst Rst18 ; $59fe
	inc b ; $59ff
	ld a, [bc] ; $5a00
	pop af ; $5a01
	ld a, $00 ; $5a02
	ld bc, $0500 ; $5a04
	ld de, $3700 ; $5a07
	rst Rst18 ; $5a0a
	ld [hl+], a ; $5a0b
	ld a, [bc] ; $5a0c
	ld a, $00 ; $5a0d
	ld bc, $1f00 ; $5a0f
	ld de, $3700 ; $5a12
	rst Rst18 ; $5a15
	inc h ; $5a16
	ld a, [bc] ; $5a17
	xor a, a ; $5a18
	ld bc, $1f00 ; $5a19
	ld de, $3700 ; $5a1c
	rst Rst18 ; $5a1f
	ld a, [hl-] ; $5a20
	ld a, [bc] ; $5a21
	ld c, $04 ; $5a22
	call Func_00_1d2e ; $5a24
	call Func_00_1da4 ; $5a27
	ld a, $0d ; $5a2a
	rst Rst18 ; $5a2c
	jr nz, Label_15_5a39 ; $5a2d
	ld a, $0d ; $5a2f
	ld bc, $1f00 ; $5a31
	ld de, $2b00 ; $5a34
	rst Rst18 ; $5a37
	inc h ; $5a38
Label_15_5a39:
	ld a, [bc] ; $5a39
	ld a, $00 ; $5a3a
	rst Rst18 ; $5a3c
	jr nz, Label_15_5a49 ; $5a3d
	ld a, $00 ; $5a3f
	ld bc, $1f00 ; $5a41
	ld de, $2d00 ; $5a44
	rst Rst18 ; $5a47
	inc h ; $5a48
Label_15_5a49:
	ld a, [bc] ; $5a49
	rst Rst18 ; $5a4a
	ld a, $0a ; $5a4b
	xor a, a ; $5a4d
	ld bc, $1f00 ; $5a4e
	ld de, $2d00 ; $5a51
	rst Rst18 ; $5a54
	ld a, [hl-] ; $5a55
	ld a, [bc] ; $5a56
	rst Rst18 ; $5a57
	ld a, $0a ; $5a58
	push af ; $5a5a
	ld a, $3c ; $5a5b
	rst Rst18 ; $5a5d
	inc b ; $5a5e
	ld a, [bc] ; $5a5f
	pop af ; $5a60
	ld a, $0d ; $5a61
	ld b, $00 ; $5a63
	rst Rst18 ; $5a65
	ld l, $0a ; $5a66
	push af ; $5a68
	ld a, $3c ; $5a69
	rst Rst18 ; $5a6b
	inc b ; $5a6c
	ld a, [bc] ; $5a6d
	pop af ; $5a6e
	ld a, $0d ; $5a6f
	ld b, $80 ; $5a71
	rst Rst18 ; $5a73
	ld l, $0a ; $5a74
	push af ; $5a76
	ld a, $3c ; $5a77
	rst Rst18 ; $5a79
	inc b ; $5a7a
	ld a, [bc] ; $5a7b
	pop af ; $5a7c
	ld a, $0d ; $5a7d
	ld b, $40 ; $5a7f
	rst Rst18 ; $5a81
	ld l, $0a ; $5a82
	push af ; $5a84
	ld a, $3c ; $5a85
	rst Rst18 ; $5a87
	inc b ; $5a88
	ld a, [bc] ; $5a89
	pop af ; $5a8a
	ld a, $0d ; $5a8b
	ld b, $00 ; $5a8d
	rst Rst18 ; $5a8f
	ld l, $0a ; $5a90
	ld bc, $0040 ; $5a92
	rst Rst18 ; $5a95
	jr c, Label_15_5aa2 ; $5a96
	ld hl, $1a73 ; $5a98
	rst Rst18 ; $5a9b
	ld c, $0a ; $5a9c
	ld a, $0d ; $5a9e
	rst Rst18 ; $5aa0
	INCBIN "data/bank_015/d_5aa1.bin" ; $5aa1, 1 bytes
Label_15_5aa2:
	ld a, [bc] ; $5aa2
	ld a, $00 ; $5aa3
	ld d, $03 ; $5aa5
	rst Rst18 ; $5aa7
	inc [hl] ; $5aa8
	ld a, [bc] ; $5aa9
	ld a, $00 ; $5aaa
	rst Rst18 ; $5aac
	ld [hl], $0a ; $5aad
	ld a, $00 ; $5aaf
	ld b, $00 ; $5ab1
	rst Rst18 ; $5ab3
	ld l, $0a ; $5ab4
	xor a, a ; $5ab6
	ld bc, $2d00 ; $5ab7
	ld de, $2900 ; $5aba
	rst Rst18 ; $5abd
	ld a, [hl-] ; $5abe
	ld a, [bc] ; $5abf
	rst Rst18 ; $5ac0
	ld a, $0a ; $5ac1
	ld a, $0d ; $5ac3
	rst Rst18 ; $5ac5
	INCBIN "data/bank_015/d_5ac6.bin" ; $5ac6, 2 bytes
	push af ; $5ac8
	ld a, $3c ; $5ac9
	rst Rst18 ; $5acb
	inc b ; $5acc
	ld a, [bc] ; $5acd
	pop af ; $5ace
	ld a, $00 ; $5acf
	ld b, a ; $5ad1
	ld a, $0d ; $5ad2
	rst Rst18 ; $5ad4
	jr nc, Label_15_5ae1 ; $5ad5
	xor a, a ; $5ad7
	ld bc, $1f00 ; $5ad8
	ld de, $2d00 ; $5adb
	rst Rst18 ; $5ade
	ld a, [hl-] ; $5adf
	ld a, [bc] ; $5ae0
Label_15_5ae1:
	rst Rst18 ; $5ae1
	ld a, $0a ; $5ae2
	ld a, $00 ; $5ae4
	ld d, $03 ; $5ae6
	rst Rst18 ; $5ae8
	inc [hl] ; $5ae9
	ld a, [bc] ; $5aea
	ld a, $00 ; $5aeb
	rst Rst18 ; $5aed
	ld [hl], $0a ; $5aee
	ld a, $0d ; $5af0
	ld b, $80 ; $5af2
	rst Rst18 ; $5af4
	ld l, $0a ; $5af5
	push af ; $5af7
	ld a, $28 ; $5af8
	rst Rst18 ; $5afa
	inc b ; $5afb
	ld a, [bc] ; $5afc
	pop af ; $5afd
	ld a, $00 ; $5afe
	ld b, $80 ; $5b00
	rst Rst18 ; $5b02
	ld l, $0a ; $5b03
	ld a, $0d ; $5b05
	rst Rst18 ; $5b07
	INCBIN "data/bank_015/d_5b08.bin" ; $5b08, 2 bytes
	ld a, $0b ; $5b0a
	ld b, $00 ; $5b0c
	rst Rst18 ; $5b0e
	inc a ; $5b0f
	ld a, [bc] ; $5b10
	rst Rst18 ; $5b11
	ld a, $0a ; $5b12
	push af ; $5b14
	ld a, $3c ; $5b15
	rst Rst18 ; $5b17
	inc b ; $5b18
	ld a, [bc] ; $5b19
	pop af ; $5b1a
	ld a, $00 ; $5b1b
	ld b, a ; $5b1d
	ld a, $0d ; $5b1e
	rst Rst18 ; $5b20
	jr nc, Label_15_5b2d ; $5b21
	ld a, $0d ; $5b23
	ld b, $00 ; $5b25
	rst Rst18 ; $5b27
	inc a ; $5b28
	ld a, [bc] ; $5b29
	rst Rst18 ; $5b2a
	ld a, $0a ; $5b2b
Label_15_5b2d:
	ld a, $00 ; $5b2d
	ld d, $03 ; $5b2f
	rst Rst18 ; $5b31
	inc [hl] ; $5b32
	ld a, [bc] ; $5b33
	ld a, $00 ; $5b34
	rst Rst18 ; $5b36
	ld [hl], $0a ; $5b37
	ld a, $0d ; $5b39
	rst Rst18 ; $5b3b
	INCBIN "data/bank_015/d_5b3c.bin" ; $5b3c, 2 bytes
	ld a, $0d ; $5b3e
	ld b, a ; $5b40
	ld a, $00 ; $5b41
	rst Rst18 ; $5b43
	jr nc, Label_15_5b50 ; $5b44
	ld a, $00 ; $5b46
	ld d, $02 ; $5b48
	rst Rst18 ; $5b4a
	inc [hl] ; $5b4b
	ld a, [bc] ; $5b4c
	ld a, $00 ; $5b4d
	rst Rst18 ; $5b4f
Label_15_5b50:
	ld [hl], $0a ; $5b50
	ld a, $0d ; $5b52
	rst Rst18 ; $5b54
	INCBIN "data/bank_015/d_5b55.bin" ; $5b55, 2 bytes
	ld a, $00 ; $5b57
	ld d, $03 ; $5b59
	rst Rst18 ; $5b5b
	inc [hl] ; $5b5c
	ld a, [bc] ; $5b5d
	ld a, $00 ; $5b5e
	rst Rst18 ; $5b60
	ld [hl], $0a ; $5b61
	ld a, $0d ; $5b63
	ld d, $03 ; $5b65
	rst Rst18 ; $5b67
	inc [hl] ; $5b68
	ld a, [bc] ; $5b69
	ld a, $0d ; $5b6a
	rst Rst18 ; $5b6c
	ld [hl], $0a ; $5b6d
	ld a, $0d ; $5b6f
	rst Rst18 ; $5b71
	INCBIN "data/bank_015/d_5b72.bin" ; $5b72, 2 bytes
	ld a, $00 ; $5b74
	ld d, $03 ; $5b76
	rst Rst18 ; $5b78
	inc [hl] ; $5b79
	ld a, [bc] ; $5b7a
	ld a, $00 ; $5b7b
	rst Rst18 ; $5b7d
	ld [hl], $0a ; $5b7e
	ld bc, $0020 ; $5b80
	rst Rst18 ; $5b83
	jr c, $5b90 ; $5b84
	ld a, $00 ; $5b86
	ld b, $80 ; $5b88
	rst Rst18 ; $5b8a
	ld l, $0a ; $5b8b
	ld a, $0d ; $5b8d
	ld bc, $1e00 ; $5b8f
	ld de, $2b00 ; $5b92
	rst Rst18 ; $5b95
	inc h ; $5b96
	ld a, [bc] ; $5b97
	ld a, $0d ; $5b98
	rst Rst18 ; $5b9a
	jr nz, $5ba7 ; $5b9b
	ld a, $00 ; $5b9d
	ld b, $01 ; $5b9f
	rst Rst18 ; $5ba1
	inc l ; $5ba2
	ld a, [bc] ; $5ba3
	ld a, $00 ; $5ba4
	ld bc, $2000 ; $5ba6
	ld de, $2d00 ; $5ba9
	rst Rst18 ; $5bac
	inc h ; $5bad
	ld a, [bc] ; $5bae
	ld a, $0d ; $5baf
	ld bc, $1e00 ; $5bb1
	ld de, $2f00 ; $5bb4
	rst Rst18 ; $5bb7
	inc h ; $5bb8
	ld a, [bc] ; $5bb9
	ld a, $0d ; $5bba
	rst Rst18 ; $5bbc
	jr nz, Label_15_5bc9 ; $5bbd
	ld a, $00 ; $5bbf
	ld bc, $1f00 ; $5bc1
	ld de, $2d00 ; $5bc4
	rst Rst18 ; $5bc7
	inc h ; $5bc8
Label_15_5bc9:
	ld a, [bc] ; $5bc9
	ld a, $00 ; $5bca
	rst Rst18 ; $5bcc
	jr nz, $5bd9 ; $5bcd
	ld a, $00 ; $5bcf
	ld b, $00 ; $5bd1
	rst Rst18 ; $5bd3
	inc l ; $5bd4
	ld a, [bc] ; $5bd5
	ld a, $0d ; $5bd6
	ld bc, $1f00 ; $5bd8
	ld de, $2f00 ; $5bdb
	rst Rst18 ; $5bde
	inc h ; $5bdf
	ld a, [bc] ; $5be0
	ld a, $0d ; $5be1
	rst Rst18 ; $5be3
	jr nz, Label_15_5bf0 ; $5be4
	ld a, $00 ; $5be6
	ld bc, $1f00 ; $5be8
	ld de, $3700 ; $5beb
	rst Rst18 ; $5bee
	inc h ; $5bef
Label_15_5bf0:
	ld a, [bc] ; $5bf0
	xor a, a ; $5bf1
	ld bc, $1f00 ; $5bf2
	ld de, $3700 ; $5bf5
	rst Rst18 ; $5bf8
	ld a, [hl-] ; $5bf9
	ld a, [bc] ; $5bfa
	ld a, $0d ; $5bfb
	ld bc, $1f00 ; $5bfd
	ld de, $3700 ; $5c00
	rst Rst18 ; $5c03
	inc h ; $5c04
	ld a, [bc] ; $5c05
	ld a, $0d ; $5c06
	rst Rst18 ; $5c08
	jr nz, Label_15_5c15 ; $5c09
	ld a, $0d ; $5c0b
	ld bc, $0300 ; $5c0d
	ld de, $3700 ; $5c10
	rst Rst18 ; $5c13
	inc h ; $5c14
Label_15_5c15:
	ld a, [bc] ; $5c15
	xor a, a ; $5c16
	ld bc, $0900 ; $5c17
	ld de, $3700 ; $5c1a
	rst Rst18 ; $5c1d
	ld a, [hl-] ; $5c1e
	ld a, [bc] ; $5c1f
	ld a, $00 ; $5c20
	rst Rst18 ; $5c22
	jr nz, Label_15_5c2f ; $5c23
	ld a, $00 ; $5c25
	ld bc, $0300 ; $5c27
	ld de, $3700 ; $5c2a
	rst Rst18 ; $5c2d
	inc h ; $5c2e
Label_15_5c2f:
	ld a, [bc] ; $5c2f
	push af ; $5c30
	ld a, $5a ; $5c31
	rst Rst18 ; $5c33
	inc b ; $5c34
	ld a, [bc] ; $5c35
	pop af ; $5c36
	ld c, $08 ; $5c37
	call Func_00_1d20 ; $5c39
	push af ; $5c3c
	ld a, $14 ; $5c3d
	rst Rst18 ; $5c3f
	inc b ; $5c40
	ld a, [bc] ; $5c41
	pop af ; $5c42
	ld a, $0f ; $5c43
	ld [$c294], a ; $5c45
	ld [$c2a1], a ; $5c48
	rst Rst18 ; $5c4b
	ld [bc], a ; $5c4c
	ld a, [bc] ; $5c4d
	ret ; $5c4e
	INCBIN "data/bank_015/d_5c4f.bin" ; $5c4f, 293 bytes
Func_15_5d74:
	xor a, a ; $5d74
	ld [$c2d5], a ; $5d75
	ld a, $11 ; $5d78
	ld [$c2b1], a ; $5d7a
	ld a, $00 ; $5d7d
	ld bc, $2800 ; $5d7f
	ld de, $2a00 ; $5d82
	rst Rst18 ; $5d85
	ld [hl+], a ; $5d86
	ld a, [bc] ; $5d87
	ld a, $00 ; $5d88
	ld b, $c0 ; $5d8a
	rst Rst18 ; $5d8c
	ld l, $0a ; $5d8d
	ld a, [$c2b1] ; $5d8f
	ld bc, $2800 ; $5d92
	ld de, $2500 ; $5d95
	rst Rst18 ; $5d98
	ld [hl+], a ; $5d99
	ld a, [bc] ; $5d9a
	ld a, [$c2b1] ; $5d9b
	ld b, $40 ; $5d9e
	rst Rst18 ; $5da0
	ld l, $0a ; $5da1
	ld a, $02 ; $5da3
	rst Rst18 ; $5da5
	inc e ; $5da6
	ld a, [bc] ; $5da7
	ld a, $02 ; $5da8
	ld bc, $2d00 ; $5daa
	ld de, $2d00 ; $5dad
	rst Rst18 ; $5db0
	ld [hl+], a ; $5db1
	ld a, [bc] ; $5db2
	ld a, $02 ; $5db3
	ld b, $80 ; $5db5
	rst Rst18 ; $5db7
	ld l, $0a ; $5db8
	ld bc, $00f0 ; $5dba
	rst Rst18 ; $5dbd
	jr c, Label_15_5dca ; $5dbe
	xor a, a ; $5dc0
	ld bc, $2800 ; $5dc1
	ld de, $2900 ; $5dc4
	rst Rst18 ; $5dc7
	ld a, [hl-] ; $5dc8
	ld a, [bc] ; $5dc9
Label_15_5dca:
	rst Rst18 ; $5dca
	ld a, $0a ; $5dcb
	ld c, $08 ; $5dcd
	call Func_00_1d2e ; $5dcf
	call Func_00_1da4 ; $5dd2
	ld a, [wPointWinLoseFlag] ; $5dd5
	inc a ; $5dd8
	cp a, $01 ; $5dd9
	jr nz, Label_15_5dea ; $5ddb
	ld hl, $c2b2 ; $5ddd
	ld de, $204a ; $5de0
	ld a, e ; $5de3
	ld [hl+], a ; $5de4
	ld [hl], d ; $5de5
	ld a, [wPointWinLoseFlag] ; $5de6
	inc a ; $5de9
Label_15_5dea:
	ld a, a ; $5dea
	rst Rst00 ; $5deb
	ld e, b ; $5dec
	ld e, a ; $5ded
	rlca ; $5dee
	ld e, a ; $5def
	jp nz, $c95f ; $5df0
	xor a, a ; $5df3
	ld [$c2d5], a ; $5df4
	ld a, $0c ; $5df7
	ld [$c2b1], a ; $5df9
	ld a, $00 ; $5dfc
	ld bc, $1800 ; $5dfe
	ld de, $2a00 ; $5e01
	rst Rst18 ; $5e04
	ld [hl+], a ; $5e05
	ld a, [bc] ; $5e06
	ld a, $00 ; $5e07
	ld b, $c0 ; $5e09
	rst Rst18 ; $5e0b
	ld l, $0a ; $5e0c
	ld a, [$c2b1] ; $5e0e
	ld bc, $1800 ; $5e11
	ld de, $2500 ; $5e14
	rst Rst18 ; $5e17
	ld [hl+], a ; $5e18
	ld a, [bc] ; $5e19
	ld a, [$c2b1] ; $5e1a
	ld b, $40 ; $5e1d
	rst Rst18 ; $5e1f
	ld l, $0a ; $5e20
	ld a, $02 ; $5e22
	rst Rst18 ; $5e24
	inc e ; $5e25
	ld a, [bc] ; $5e26
	ld a, $02 ; $5e27
	ld bc, $1300 ; $5e29
	ld de, $2d00 ; $5e2c
	rst Rst18 ; $5e2f
	ld [hl+], a ; $5e30
	ld a, [bc] ; $5e31
	ld a, $02 ; $5e32
	ld b, $00 ; $5e34
	rst Rst18 ; $5e36
	ld l, $0a ; $5e37
	ld bc, $00f0 ; $5e39
	rst Rst18 ; $5e3c
	jr c, Label_15_5e49 ; $5e3d
	xor a, a ; $5e3f
	ld bc, $1800 ; $5e40
	ld de, $2800 ; $5e43
	rst Rst18 ; $5e46
	ld a, [hl-] ; $5e47
	ld a, [bc] ; $5e48
Label_15_5e49:
	rst Rst18 ; $5e49
	ld a, $0a ; $5e4a
	ld c, $08 ; $5e4c
	call Func_00_1d2e ; $5e4e
	call Func_00_1da4 ; $5e51
	ld a, [wPointWinLoseFlag] ; $5e54
	inc a ; $5e57
	cp a, $01 ; $5e58
	jr nz, Label_15_5e69 ; $5e5a
	ld hl, $c2b2 ; $5e5c
	ld de, $2078 ; $5e5f
	ld a, e ; $5e62
	ld [hl+], a ; $5e63
	ld [hl], d ; $5e64
	ld a, [wPointWinLoseFlag] ; $5e65
	inc a ; $5e68
Label_15_5e69:
	ld a, a ; $5e69
	rst Rst00 ; $5e6a
	ld e, b ; $5e6b
	ld e, a ; $5e6c
	rlca ; $5e6d
	ld e, a ; $5e6e
	jp nz, Label_15_745f ; $5e6f
	ld e, [hl] ; $5e72
	ret ; $5e73
	INCBIN "data/bank_015/d_5e74.bin" ; $5e74, 773 bytes
Func_15_6179:
	ld a, [$c8f7] ; $6179
	sub a, $0a ; $617c
	jr nc, Label_15_618b ; $617e
	ld a, [$c8f7] ; $6180
	sub a, $04 ; $6183
	jr c, $61d5 ; $6185
	jp $6214 ; $6187
	INCBIN "data/bank_015/d_618a.bin" ; $618a, 1 bytes
Label_15_618b:
	ld a, [$c2b1] ; $618b
	ld bc, $1300 ; $618e
	ld de, $2500 ; $6191
	rst Rst18 ; $6194
	inc h ; $6195
	ld a, [bc] ; $6196
	ld a, [$c2b1] ; $6197
	rst Rst18 ; $619a
	jr nz, Label_15_61a7 ; $619b
	ld a, [$c2b1] ; $619d
	ld bc, $1300 ; $61a0
	ld de, $2700 ; $61a3
	rst Rst18 ; $61a6
Label_15_61a7:
	inc h ; $61a7
	ld a, [bc] ; $61a8
	ld a, $00 ; $61a9
	ld bc, $1300 ; $61ab
	ld de, $2b00 ; $61ae
	rst Rst18 ; $61b1
	inc h ; $61b2
	ld a, [bc] ; $61b3
	ld a, $00 ; $61b4
	rst Rst18 ; $61b6
	jr nz, Label_15_61c3 ; $61b7
	ld a, $02 ; $61b9
	rst Rst18 ; $61bb
	ld d, $0a ; $61bc
	ld c, l ; $61be
	ld b, h ; $61bf
	ld de, $d000 ; $61c0
Label_15_61c3:
	rst Rst18 ; $61c3
	jr nz, Label_15_61ca ; $61c4
	ld a, [$c2b1] ; $61c6
	rst Rst18 ; $61c9
Label_15_61ca:
	jr nz, Label_15_61d6 ; $61ca
	ld a, [$c2b1] ; $61cc
	ld b, $40 ; $61cf
	rst Rst18 ; $61d1
	ld l, $0a ; $61d2
	ret ; $61d4
	INCBIN "data/bank_015/d_61d5.bin" ; $61d5, 1 bytes
Label_15_61d6:
	or a, c ; $61d6
	jp nz, $0001 ; $61d7
	inc de ; $61da
	ld de, $0b00 ; $61db
	rst Rst18 ; $61de
	inc h ; $61df
	ld a, [bc] ; $61e0
	push af ; $61e1
	ld a, $1e ; $61e2
	rst Rst18 ; $61e4
	inc b ; $61e5
	ld a, [bc] ; $61e6
	pop af ; $61e7
	ld a, $00 ; $61e8
	ld bc, $1300 ; $61ea
	ld de, $1300 ; $61ed
	rst Rst18 ; $61f0
	inc h ; $61f1
	ld a, [bc] ; $61f2
	ld a, $00 ; $61f3
	rst Rst18 ; $61f5
	jr nz, Label_15_6202 ; $61f6
	ld a, $02 ; $61f8
	rst Rst18 ; $61fa
	ld d, $0a ; $61fb
	ld c, l ; $61fd
	ld b, h ; $61fe
	ld de, $d000 ; $61ff
Label_15_6202:
	rst Rst18 ; $6202
	jr nz, Label_15_6209 ; $6203
	ld a, [$c2b1] ; $6205
	rst Rst18 ; $6208
Label_15_6209:
	jr nz, Label_15_6215 ; $6209
	ld a, [$c2b1] ; $620b
	ld b, $00 ; $620e
	rst Rst18 ; $6210
	ld l, $0a ; $6211
	ret ; $6213
	INCBIN "data/bank_015/d_6214.bin" ; $6214, 1 bytes
Label_15_6215:
	or a, c ; $6215
	jp nz, $0001 ; $6216
	dec l ; $6219
	ld de, $2100 ; $621a
	rst Rst18 ; $621d
	inc h ; $621e
	ld a, [bc] ; $621f
	push af ; $6220
	ld a, $1e ; $6221
	rst Rst18 ; $6223
	inc b ; $6224
	ld a, [bc] ; $6225
	pop af ; $6226
	ld a, $00 ; $6227
	ld bc, $2d00 ; $6229
	ld de, $2b00 ; $622c
	rst Rst18 ; $622f
	inc h ; $6230
	ld a, [bc] ; $6231
	ld a, $00 ; $6232
	rst Rst18 ; $6234
	jr nz, Label_15_6241 ; $6235
	ld a, $02 ; $6237
	rst Rst18 ; $6239
	ld d, $0a ; $623a
	ld c, l ; $623c
	ld b, h ; $623d
	ld de, $d000 ; $623e
Label_15_6241:
	rst Rst18 ; $6241
	jr nz, Label_15_6248 ; $6242
	ld a, [$c2b1] ; $6244
	rst Rst18 ; $6247
Label_15_6248:
	jr nz, Label_15_6254 ; $6248
	ld a, [$c2b1] ; $624a
	ld b, $00 ; $624d
	rst Rst18 ; $624f
	ld l, $0a ; $6250
	ret ; $6252
	INCBIN "data/bank_015/d_6253.bin" ; $6253, 1 bytes
Label_15_6254:
	rst Rst30 ; $6254
	ret z ; $6255
	sub a, $0a ; $6256
	jr nc, Label_15_6265 ; $6258
	ld a, [$c8f7] ; $625a
	sub a, $04 ; $625d
	jr c, Label_15_6283 ; $625f
	jp Label_15_62a1 ; $6261
	INCBIN "data/bank_015/d_6264.bin" ; $6264, 1 bytes
Label_15_6265:
	ld a, $00 ; $6265
	ld bc, $1300 ; $6267
	ld de, $2b00 ; $626a
	rst Rst18 ; $626d
	inc h ; $626e
	ld a, [bc] ; $626f
	ld a, $00 ; $6270
	rst Rst18 ; $6272
	jr nz, Label_15_627f ; $6273
	ld a, $02 ; $6275
	rst Rst18 ; $6277
	ld d, $0a ; $6278
	ld c, l ; $627a
	ld b, h ; $627b
	ld de, $d000 ; $627c
Label_15_627f:
	rst Rst18 ; $627f
	jr nz, Label_15_6286 ; $6280
	ret ; $6282
Label_15_6283:
	ld a, $00 ; $6283
	INCBIN "data/bank_015/d_6285.bin" ; $6285, 1 bytes
Label_15_6286:
	nop ; $6286
	inc de ; $6287
	ld de, $1300 ; $6288
	rst Rst18 ; $628b
	inc h ; $628c
	ld a, [bc] ; $628d
	ld a, $00 ; $628e
	rst Rst18 ; $6290
	jr nz, Label_15_629d ; $6291
	ld a, $02 ; $6293
	rst Rst18 ; $6295
	ld d, $0a ; $6296
	ld c, l ; $6298
	ld b, h ; $6299
	ld de, $d000 ; $629a
Label_15_629d:
	rst Rst18 ; $629d
	jr nz, Label_15_62a4 ; $629e
	ret ; $62a0
Label_15_62a1:
	ld a, $00 ; $62a1
	INCBIN "data/bank_015/d_62a3.bin" ; $62a3, 1 bytes
Label_15_62a4:
	nop ; $62a4
	dec l ; $62a5
	ld de, $2b00 ; $62a6
	rst Rst18 ; $62a9
	inc h ; $62aa
	ld a, [bc] ; $62ab
	ld a, $00 ; $62ac
	rst Rst18 ; $62ae
	jr nz, Label_15_62bb ; $62af
	ld a, $02 ; $62b1
	rst Rst18 ; $62b3
	ld d, $0a ; $62b4
	ld c, l ; $62b6
	ld b, h ; $62b7
	ld de, $d000 ; $62b8
Label_15_62bb:
	rst Rst18 ; $62bb
	jr nz, Label_15_62c2 ; $62bc
	ret ; $62be
	INCBIN "data/bank_015/d_62bf.bin" ; $62bf, 3 bytes
Label_15_62c2:
	ld de, $204d ; $62c2
	ld a, e ; $62c5
	ld [hl+], a ; $62c6
	ld [hl], d ; $62c7
	ld hl, $c2b4 ; $62c8
	ld de, $204a ; $62cb
	ld a, e ; $62ce
	ld [hl+], a ; $62cf
	ld [hl], d ; $62d0
	rst Rst30 ; $62d1
	ld h, b ; $62d2
	ld a, [bc] ; $62d3
	jr z, Label_15_62ea ; $62d4
	ld hl, $c2b6 ; $62d6
	ld de, $2050 ; $62d9
	ld a, e ; $62dc
	ld [hl+], a ; $62dd
	ld [hl], d ; $62de
	ld hl, $c2b8 ; $62df
	ld de, $2053 ; $62e2
	ld a, e ; $62e5
	ld [hl+], a ; $62e6
	ld [hl], d ; $62e7
	jr Label_15_62fc ; $62e8
Label_15_62ea:
	ld hl, $c2b6 ; $62ea
	ld de, $204f ; $62ed
	ld a, e ; $62f0
	ld [hl+], a ; $62f1
	ld [hl], d ; $62f2
	ld hl, $c2b8 ; $62f3
	ld de, $2051 ; $62f6
	ld a, e ; $62f9
	ld [hl+], a ; $62fa
	ld [hl], d ; $62fb
Label_15_62fc:
	call Func_15_5d74 ; $62fc
	ret ; $62ff
	INCBIN "data/bank_015/d_6300.bin" ; $6300, 839 bytes
Func_15_6647:
	rst Rst30 ; $6647
	ldh [rTIMA], a ; $6648
	jr z, Label_15_667b ; $664a
	ld a, $02 ; $664c
	ld b, a ; $664e
	ld a, $00 ; $664f
	rst Rst18 ; $6651
	jr nc, Label_15_665e ; $6652
	ld a, $00 ; $6654
	ld d, $03 ; $6656
	rst Rst18 ; $6658
	inc [hl] ; $6659
	ld a, [bc] ; $665a
	ld a, $00 ; $665b
	rst Rst18 ; $665d
Label_15_665e:
	ld [hl], $0a ; $665e
	ld a, $02 ; $6660
	ld d, $03 ; $6662
	rst Rst18 ; $6664
	inc [hl] ; $6665
	ld a, [bc] ; $6666
	ld a, $02 ; $6667
	rst Rst18 ; $6669
	ld [hl], $0a ; $666a
	ld a, $00 ; $666c
	ld b, $c0 ; $666e
	rst Rst18 ; $6670
	ld l, $0a ; $6671
	push af ; $6673
	ld a, $0a ; $6674
	rst Rst18 ; $6676
	inc b ; $6677
	ld a, [bc] ; $6678
	pop af ; $6679
	ret ; $667a
Label_15_667b:
	ld a, $00 ; $667b
	ld d, $03 ; $667d
	rst Rst18 ; $667f
	inc [hl] ; $6680
	ld a, [bc] ; $6681
	ld a, $00 ; $6682
	rst Rst18 ; $6684
	ld [hl], $0a ; $6685
	push af ; $6687
	ld a, $0a ; $6688
	rst Rst18 ; $668a
	inc b ; $668b
	ld a, [bc] ; $668c
	pop af ; $668d
	ret ; $668e
	INCBIN "data/bank_015/d_668f.bin" ; $668f, 2863 bytes
Func_15_71be:
	rst Rst30 ; $71be
	ld b, b ; $71bf
	rla ; $71c0
	jr nz, Label_15_71c8 ; $71c1
	call Func_15_71d4 ; $71c3
	jr z, Label_15_71d3 ; $71c6
Label_15_71c8:
	ld a, $06 ; $71c8
	ld bc, $3f00 ; $71ca
	ld de, $3f00 ; $71cd
	rst Rst18 ; $71d0
	ld [hl+], a ; $71d1
	ld a, [bc] ; $71d2
Label_15_71d3:
	ret ; $71d3
Func_15_71d4:
	ld a, [$c2b0] ; $71d4
	add a, a ; $71d7
	add a, $f8 ; $71d8
	ld l, a ; $71da
	adc a, $71 ; $71db
	sub a, l ; $71dd
	ld h, a ; $71de
	ld a, [hl+] ; $71df
	ld d, [hl] ; $71e0
	ld e, a ; $71e1
	call Func_00_24ef ; $71e2
	ret ; $71e5
	INCBIN "data/bank_015/d_71e6.bin" ; $71e6, 30 bytes
Func_15_7204:
	rst Rst30 ; $7204
	ld h, b ; $7205
	rla ; $7206
	jr nz, Label_15_720e ; $7207
	call Func_15_721a ; $7209
	jr z, Label_15_7219 ; $720c
Label_15_720e:
	ld a, $11 ; $720e
	ld bc, $3f00 ; $7210
	ld de, $3f00 ; $7213
	rst Rst18 ; $7216
	ld [hl+], a ; $7217
	ld a, [bc] ; $7218
Label_15_7219:
	ret ; $7219
Func_15_721a:
	ld a, [$c2b0] ; $721a
	add a, a ; $721d
	add a, $3e ; $721e
	ld l, a ; $7220
	adc a, $72 ; $7221
	sub a, l ; $7223
	ld h, a ; $7224
	ld a, [hl+] ; $7225
	ld d, [hl] ; $7226
	ld e, a ; $7227
	call Func_00_24ef ; $7228
	ret ; $722b
	INCBIN "data/bank_015/d_722c.bin" ; $722c, 30 bytes
Func_15_724a:
	rst Rst30 ; $724a
	add a, b ; $724b
	rla ; $724c
	jr nz, Label_15_7254 ; $724d
	call Func_15_7260 ; $724f
	jr z, Label_15_725f ; $7252
Label_15_7254:
	ld a, $0c ; $7254
	ld bc, $3f00 ; $7256
	ld de, $3f00 ; $7259
	rst Rst18 ; $725c
	ld [hl+], a ; $725d
	ld a, [bc] ; $725e
Label_15_725f:
	ret ; $725f
Func_15_7260:
	ld a, [$c2b0] ; $7260
	add a, a ; $7263
	add a, $84 ; $7264
	ld l, a ; $7266
	adc a, $72 ; $7267
	sub a, l ; $7269
	ld h, a ; $726a
	ld a, [hl+] ; $726b
	ld d, [hl] ; $726c
	ld e, a ; $726d
	call Func_00_24ef ; $726e
	ret ; $7271
	INCBIN "data/bank_015/d_7272.bin" ; $7272, 493 bytes
Label_15_745f:
	ld c, $0a ; $745f
	call Func_15_747e ; $7461
	ret ; $7464
	INCBIN "data/bank_015/d_7465.bin" ; $7465, 25 bytes
Func_15_747e:
	ld a, $07 ; $747e
	rst Rst18 ; $7480
	ld a, [bc] ; $7481
	ld a, [bc] ; $7482
	rst Rst18 ; $7483
	ld [de], a ; $7484
	ld a, [bc] ; $7485
	rst Rst18 ; $7486
	inc c ; $7487
	ld a, [bc] ; $7488
	push af ; $7489
	ld a, $05 ; $748a
	rst Rst18 ; $748c
	inc b ; $748d
	ld a, [bc] ; $748e
	pop af ; $748f
	and a, a ; $7490
	jp z, Label_15_74d2 ; $7491
	rst Rst18 ; $7494
	INCBIN "data/bank_015/d_7495.bin" ; $7495, 61 bytes
Label_15_74d2:
	ld hl, $1c41 ; $74d2
	rst Rst18 ; $74d5
	ld c, $0a ; $74d6
	ld a, $07 ; $74d8
	rst Rst18 ; $74da
	ld [$cd0a], sp ; $74db
	sub a, [hl] ; $74de
	ld a, d ; $74df
	ret ; $74e0
Func_15_74e1:
	xor a, a ; $74e1
	ld [$c2d5], a ; $74e2
	ld bc, $00f0 ; $74e5
	rst Rst18 ; $74e8
	jr c, Label_15_74f5 ; $74e9
	ld a, $00 ; $74eb
	ld bc, $1300 ; $74ed
	ld de, $1300 ; $74f0
	rst Rst18 ; $74f3
	ld [hl+], a ; $74f4
Label_15_74f5:
	ld a, [bc] ; $74f5
	ld a, $02 ; $74f6
	ld bc, $1300 ; $74f8
	ld de, $1100 ; $74fb
	rst Rst18 ; $74fe
	ld [hl+], a ; $74ff
	ld a, [bc] ; $7500
	xor a, a ; $7501
	ld bc, $1300 ; $7502
	ld de, $1300 ; $7505
	rst Rst18 ; $7508
	ld a, [hl-] ; $7509
	ld a, [bc] ; $750a
	rst Rst18 ; $750b
	ld a, $0a ; $750c
	ld a, $00 ; $750e
	ld b, $40 ; $7510
	rst Rst18 ; $7512
	ld l, $0a ; $7513
	ld a, $02 ; $7515
	ld b, $40 ; $7517
	rst Rst18 ; $7519
	ld l, $0a ; $751a
	ld a, $07 ; $751c
	ld b, $c0 ; $751e
	rst Rst18 ; $7520
	ld l, $0a ; $7521
	ld c, $04 ; $7523
	call Func_00_1d2e ; $7525
	call Func_00_1da4 ; $7528
	ret ; $752b
	INCBIN "data/bank_015/d_752c.bin" ; $752c, 550 bytes
Func_15_7752:
	xor a, a ; $7752
	ld [$c2d5], a ; $7753
	ld bc, $00f0 ; $7756
	rst Rst18 ; $7759
	jr c, Label_15_7766 ; $775a
	ld a, $00 ; $775c
	ld bc, $2d00 ; $775e
	ld de, $2b00 ; $7761
	rst Rst18 ; $7764
	ld [hl+], a ; $7765
Label_15_7766:
	ld a, [bc] ; $7766
	ld a, $02 ; $7767
	ld bc, $2f00 ; $7769
	ld de, $2b00 ; $776c
	rst Rst18 ; $776f
	ld [hl+], a ; $7770
	ld a, [bc] ; $7771
	xor a, a ; $7772
	ld bc, $2d00 ; $7773
	ld de, $2b00 ; $7776
	rst Rst18 ; $7779
	ld a, [hl-] ; $777a
	ld a, [bc] ; $777b
	rst Rst18 ; $777c
	ld a, $0a ; $777d
	ld a, $00 ; $777f
	ld b, $c0 ; $7781
	rst Rst18 ; $7783
	ld l, $0a ; $7784
	ld a, $02 ; $7786
	ld b, $c0 ; $7788
	rst Rst18 ; $778a
	ld l, $0a ; $778b
	ld a, $12 ; $778d
	ld b, $40 ; $778f
	rst Rst18 ; $7791
	ld l, $0a ; $7792
	ld c, $04 ; $7794
	call Func_00_1d2e ; $7796
	call Func_00_1da4 ; $7799
	ret ; $779c
	INCBIN "data/bank_015/d_779d.bin" ; $779d, 558 bytes
Func_15_79cb:
	xor a, a ; $79cb
	ld [$c2d5], a ; $79cc
	ld bc, $00f0 ; $79cf
	rst Rst18 ; $79d2
	jr c, Label_15_79df ; $79d3
	ld a, $00 ; $79d5
	ld bc, $1300 ; $79d7
	ld de, $2b00 ; $79da
	rst Rst18 ; $79dd
	ld [hl+], a ; $79de
Label_15_79df:
	ld a, [bc] ; $79df
	ld a, $02 ; $79e0
	ld bc, $1100 ; $79e2
	ld de, $2b00 ; $79e5
	rst Rst18 ; $79e8
	ld [hl+], a ; $79e9
	ld a, [bc] ; $79ea
	xor a, a ; $79eb
	ld bc, $1300 ; $79ec
	ld de, $2b00 ; $79ef
	rst Rst18 ; $79f2
	ld a, [hl-] ; $79f3
	ld a, [bc] ; $79f4
	rst Rst18 ; $79f5
	ld a, $0a ; $79f6
	ld a, $00 ; $79f8
	ld b, $c0 ; $79fa
	rst Rst18 ; $79fc
	ld l, $0a ; $79fd
	ld a, $02 ; $79ff
	ld b, $c0 ; $7a01
	rst Rst18 ; $7a03
	ld l, $0a ; $7a04
	ld a, $0d ; $7a06
	ld b, $40 ; $7a08
	rst Rst18 ; $7a0a
	ld l, $0a ; $7a0b
	ld c, $04 ; $7a0d
	call Func_00_1d2e ; $7a0f
	call Func_00_1da4 ; $7a12
	ret ; $7a15
	INCBIN "data/bank_015/d_7a16.bin" ; $7a16, 47 bytes
Func_15_7a45:
	rst Rst30 ; $7a45
	ldh [rTIMA], a ; $7a46
	jp nz, Label_15_7a66 ; $7a48
	ld a, [wEquippedRacket] ; $7a4b
	and a, $0f ; $7a4e
	cp a, $03 ; $7a50
	jp nz, Label_15_7a66 ; $7a52
	rst Rst30 ; $7a55
	nop ; $7a56
	INCBIN "data/bank_015/d_7a57.bin" ; $7a57, 15 bytes
Label_15_7a66:
	ret ; $7a66
Func_15_7a67:
	ld a, [$c8f7] ; $7a67
	cp a, $06 ; $7a6a
	jr nc, Label_15_7a75 ; $7a6c
	call Func_15_74e1 ; $7a6e
	call Func_15_7a96 ; $7a71
	ret ; $7a74
Label_15_7a75:
	cp a, $0c ; $7a75
	jr nc, Label_15_7a8b ; $7a77
	call Func_15_7752 ; $7a79
	ld hl, $1c6a ; $7a7c
	rst Rst18 ; $7a7f
	ld c, $0a ; $7a80
	ld a, $12 ; $7a82
	rst Rst18 ; $7a84
	ld [$cd0a], sp ; $7a85
	jr nc, Label_15_7b05 ; $7a88
	ret ; $7a8a
Label_15_7a8b:
	cp a, $12 ; $7a8b
	jr nc, Label_15_7a95 ; $7a8d
	call Func_15_79cb ; $7a8f
	call Func_15_7bc9 ; $7a92
Label_15_7a95:
	ret ; $7a95
Func_15_7a96:
	ld a, $02 ; $7a96
	rst Rst18 ; $7a98
	inc e ; $7a99
	ld a, [bc] ; $7a9a
	ld bc, $0020 ; $7a9b
	rst Rst18 ; $7a9e
	jr c, Label_15_7aab ; $7a9f
	push af ; $7aa1
	ld a, $14 ; $7aa2
	rst Rst18 ; $7aa4
	inc b ; $7aa5
	ld a, [bc] ; $7aa6
	pop af ; $7aa7
	ldh a, [$ff95] ; $7aa8
	ld b, a ; $7aaa
Label_15_7aab:
	ld a, $07 ; $7aab
	ld de, $7b03 ; $7aad
	rst Rst18 ; $7ab0
	ld a, [de] ; $7ab1
	ld a, [bc] ; $7ab2
	ldh a, [$ff95] ; $7ab3
	ld b, a ; $7ab5
	ld a, $00 ; $7ab6
	ld de, $7b1a ; $7ab8
	rst Rst18 ; $7abb
	ld a, [de] ; $7abc
	ld a, [bc] ; $7abd
	ldh a, [$ff95] ; $7abe
	ld b, a ; $7ac0
	ld a, $02 ; $7ac1
	ld de, $7b25 ; $7ac3
	rst Rst18 ; $7ac6
	ld a, [de] ; $7ac7
	ld a, [bc] ; $7ac8
	xor a, a ; $7ac9
	ld bc, $1800 ; $7aca
	ld de, $0f00 ; $7acd
	rst Rst18 ; $7ad0
	ld a, [hl-] ; $7ad1
	ld a, [bc] ; $7ad2
	ld a, $00 ; $7ad3
	rst Rst18 ; $7ad5
	ld e, $0a ; $7ad6
	rst Rst18 ; $7ad8
	ld a, $0a ; $7ad9
	ld a, $07 ; $7adb
	rst Rst18 ; $7add
	ld e, $0a ; $7ade
	push af ; $7ae0
	ld a, $05 ; $7ae1
	rst Rst18 ; $7ae3
	inc b ; $7ae4
	ld a, [bc] ; $7ae5
	pop af ; $7ae6
	call Func_15_6647 ; $7ae7
	ld a, $0f ; $7aea
	ld [wStoryModeCurrentLocation], a ; $7aec
	ld a, $0a ; $7aef
	ld [$c295], a ; $7af1
	ld a, $ff ; $7af4
	ld [$c294], a ; $7af6
	ld [$c2a1], a ; $7af9
	ld a, [$c8f7] ; $7afc
	rst Rst18 ; $7aff
	nop ; $7b00
	dec bc ; $7b01
	ret ; $7b02
	INCBIN "data/bank_015/d_7b03.bin" ; $7b03, 2 bytes
Label_15_7b05:
	ld de, $1500 ; $7b05
	ld [bc], a ; $7b08
	inc b ; $7b09
	nop ; $7b0a
	inc de ; $7b0b
	nop ; $7b0c
	rrca ; $7b0d
	ld [bc], a ; $7b0e
	inc b ; $7b0f
	nop ; $7b10
	rla ; $7b11
	nop ; $7b12
	rlca ; $7b13
	ld [bc], a ; $7b14
	dec c ; $7b15
	inc d ; $7b16
	ld b, b ; $7b17
	nop ; $7b18
	nop ; $7b19
	inc b ; $7b1a
	nop ; $7b1b
	add hl, de ; $7b1c
	nop ; $7b1d
	rla ; $7b1e
	ld [bc], a ; $7b1f
	dec c ; $7b20
	inc d ; $7b21
	ret nz ; $7b22
	nop ; $7b23
	nop ; $7b24
	inc b ; $7b25
	nop ; $7b26
	inc de ; $7b27
	nop ; $7b28
	dec d ; $7b29
	ld [bc], a ; $7b2a
	dec c ; $7b2b
	inc d ; $7b2c
	nop ; $7b2d
	nop ; $7b2e
	nop ; $7b2f
	ld bc, $0020 ; $7b30
	rst Rst18 ; $7b33
	jr c, Label_15_7b40 ; $7b34
	ld a, $02 ; $7b36
	rst Rst18 ; $7b38
	inc e ; $7b39
	ld a, [bc] ; $7b3a
	ldh a, [$ff95] ; $7b3b
	ld b, a ; $7b3d
	ld a, $12 ; $7b3e
Label_15_7b40:
	ld de, $7b96 ; $7b40
	rst Rst18 ; $7b43
	ld a, [de] ; $7b44
	ld a, [bc] ; $7b45
	ldh a, [$ff95] ; $7b46
	ld b, a ; $7b48
	ld a, $00 ; $7b49
	ld de, $7bb3 ; $7b4b
	rst Rst18 ; $7b4e
	ld a, [de] ; $7b4f
	ld a, [bc] ; $7b50
	ldh a, [$ff95] ; $7b51
	ld b, a ; $7b53
	ld a, $02 ; $7b54
	ld de, $7bbe ; $7b56
	rst Rst18 ; $7b59
	ld a, [de] ; $7b5a
	ld a, [bc] ; $7b5b
	xor a, a ; $7b5c
	ld bc, $2800 ; $7b5d
	ld de, $2600 ; $7b60
	rst Rst18 ; $7b63
	ld a, [hl-] ; $7b64
	ld a, [bc] ; $7b65
	ld a, $00 ; $7b66
	rst Rst18 ; $7b68
	ld e, $0a ; $7b69
	rst Rst18 ; $7b6b
	ld a, $0a ; $7b6c
	ld a, $12 ; $7b6e
	rst Rst18 ; $7b70
	ld e, $0a ; $7b71
	push af ; $7b73
	ld a, $05 ; $7b74
	rst Rst18 ; $7b76
	inc b ; $7b77
	ld a, [bc] ; $7b78
	pop af ; $7b79
	call Func_15_6647 ; $7b7a
	ld a, $0f ; $7b7d
	ld [wStoryModeCurrentLocation], a ; $7b7f
	ld a, $0a ; $7b82
	ld [$c295], a ; $7b84
	ld a, $ff ; $7b87
	ld [$c294], a ; $7b89
	ld [$c2a1], a ; $7b8c
	ld a, [$c8f7] ; $7b8f
	rst Rst18 ; $7b92
	nop ; $7b93
	dec bc ; $7b94
	ret ; $7b95
	INCBIN "data/bank_015/d_7b96.bin" ; $7b96, 51 bytes
Func_15_7bc9:
	ld a, $02 ; $7bc9
	rst Rst18 ; $7bcb
	inc e ; $7bcc
	ld a, [bc] ; $7bcd
	ld bc, $0020 ; $7bce
	rst Rst18 ; $7bd1
	jr c, Label_15_7bde ; $7bd2
	ldh a, [$ff95] ; $7bd4
	ld b, a ; $7bd6
	ld a, $0d ; $7bd7
	ld de, $7c2f ; $7bd9
	rst Rst18 ; $7bdc
	ld a, [de] ; $7bdd
Label_15_7bde:
	ld a, [bc] ; $7bde
	ldh a, [$ff95] ; $7bdf
	ld b, a ; $7be1
	ld a, $00 ; $7be2
	ld de, $7c4c ; $7be4
	rst Rst18 ; $7be7
	ld a, [de] ; $7be8
	ld a, [bc] ; $7be9
	ldh a, [$ff95] ; $7bea
	ld b, a ; $7bec
	ld a, $02 ; $7bed
	ld de, $7c57 ; $7bef
	rst Rst18 ; $7bf2
	ld a, [de] ; $7bf3
	ld a, [bc] ; $7bf4
	xor a, a ; $7bf5
	ld bc, $1800 ; $7bf6
	ld de, $2700 ; $7bf9
	rst Rst18 ; $7bfc
	ld a, [hl-] ; $7bfd
	ld a, [bc] ; $7bfe
	ld a, $00 ; $7bff
	rst Rst18 ; $7c01
	ld e, $0a ; $7c02
	rst Rst18 ; $7c04
	ld a, $0a ; $7c05
	ld a, $0d ; $7c07
	rst Rst18 ; $7c09
	ld e, $0a ; $7c0a
	push af ; $7c0c
	ld a, $05 ; $7c0d
	rst Rst18 ; $7c0f
	inc b ; $7c10
	ld a, [bc] ; $7c11
	pop af ; $7c12
	call Func_15_6647 ; $7c13
	ld a, $0f ; $7c16
	ld [wStoryModeCurrentLocation], a ; $7c18
	ld a, $0a ; $7c1b
	ld [$c295], a ; $7c1d
	ld a, $ff ; $7c20
	ld [$c294], a ; $7c22
	ld [$c2a1], a ; $7c25
	ld a, [$c8f7] ; $7c28
	rst Rst18 ; $7c2b
	nop ; $7c2c
	dec bc ; $7c2d
	ret ; $7c2e
	INCBIN "data/bank_015/d_7c2f.bin" ; $7c2f, 358 bytes
	ret ; $7d95
	INCBIN "data/bank_015/d_7d96.bin" ; $7d96, 522 bytes
Func_15_7fa0:
	ld a, $00 ; $7fa0
	rst Rst30 ; $7fa2
	ld h, b ; $7fa3
	ld a, [bc] ; $7fa4
	jr z, Label_15_7fbf ; $7fa5
	inc a ; $7fa7
	rst Rst30 ; $7fa8
	ldh [$ff0a], a ; $7fa9
	jr z, Label_15_7fbf ; $7fab
	inc a ; $7fad
	rst Rst30 ; $7fae
	ldh [rTIMA], a ; $7faf
	jr nz, Label_15_7fc3 ; $7fb1
	rst Rst30 ; $7fb3
	ret nz ; $7fb4
	dec d ; $7fb5
	jr z, Label_15_7fbf ; $7fb6
	inc a ; $7fb8
	rst Rst30 ; $7fb9
	nop ; $7fba
	ld d, $28 ; $7fbb
	INCBIN "data/bank_015/d_7fbd.bin" ; $7fbd, 2 bytes
Label_15_7fbf:
	ld [$c2b0], a ; $7fbf
	ret ; $7fc2
Label_15_7fc3:
	rst Rst30 ; $7fc3
	ldh [$ff15], a ; $7fc4
	jr z, Label_15_7fbf ; $7fc6
	inc a ; $7fc8
	rst Rst30 ; $7fc9
	jr nz, Label_15_7fe2 ; $7fca
	jr z, Label_15_7fbf ; $7fcc
	inc a ; $7fce
	jr Label_15_7fbf ; $7fcf
	INCBIN "data/bank_015/d_7fd1.bin" ; $7fd1, 17 bytes
Label_15_7fe2:
	rst Rst38 ; $7fe2
	rst Rst38 ; $7fe3
	rst Rst38 ; $7fe4
	rst Rst38 ; $7fe5
	rst Rst38 ; $7fe6
	rst Rst38 ; $7fe7
	rst Rst38 ; $7fe8
	rst Rst38 ; $7fe9
	rst Rst38 ; $7fea
	rst Rst38 ; $7feb
	rst Rst38 ; $7fec
	rst Rst38 ; $7fed
	rst Rst38 ; $7fee
	rst Rst38 ; $7fef
	rst Rst38 ; $7ff0
	rst Rst38 ; $7ff1
	rst Rst38 ; $7ff2
	rst Rst38 ; $7ff3
	rst Rst38 ; $7ff4
	rst Rst38 ; $7ff5
	rst Rst38 ; $7ff6
	rst Rst38 ; $7ff7
	rst Rst38 ; $7ff8
	rst Rst38 ; $7ff9
	rst Rst38 ; $7ffa
	rst Rst38 ; $7ffb
	rst Rst38 ; $7ffc
	rst Rst38 ; $7ffd
	rst Rst38 ; $7ffe
	rst Rst38 ; $7fff

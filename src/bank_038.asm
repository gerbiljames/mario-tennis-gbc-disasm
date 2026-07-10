INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $38", ROMX[$4000], BANK[$38]

	INCBIN "data/bank_038/d_4000.bin" ; $4000, 24 bytes
Func_38_4018:
	push de ; $4018
	push bc ; $4019
	ld c, $00 ; $401a
	call Func_38_407b ; $401c
	ld c, $00 ; $401f
	call Func_38_40a5 ; $4021
	ld c, $00 ; $4024
	ld b, $08 ; $4026
	call Func_00_1f51 ; $4028
	pop bc ; $402b
	pop de ; $402c
	push de ; $402d
	push bc ; $402e
	ld a, b ; $402f
	add a, d ; $4030
	ld d, a ; $4031
	push de ; $4032
	ld c, $01 ; $4033
	call Func_38_407b ; $4035
	ld c, $00 ; $4038
	call Func_38_40a5 ; $403a
	ld c, $00 ; $403d
	ld b, $28 ; $403f
	call Func_00_1f51 ; $4041
	pop de ; $4044
	pop bc ; $4045
	pop de ; $4046
	push de ; $4047
	push bc ; $4048
	ld a, c ; $4049
	add a, e ; $404a
	ld e, a ; $404b
	ld a, b ; $404c
	add a, d ; $404d
	ld d, a ; $404e
	push de ; $404f
	ld c, $01 ; $4050
	call Func_38_407b ; $4052
	ld c, $01 ; $4055
	call Func_38_40a5 ; $4057
	ld c, $00 ; $405a
	ld b, $68 ; $405c
	call Func_00_1f51 ; $405e
	pop de ; $4061
	pop bc ; $4062
	pop de ; $4063
	ld a, e ; $4064
	add a, c ; $4065
	ld e, a ; $4066
	push de ; $4067
	ld c, $00 ; $4068
	call Func_38_407b ; $406a
	ld c, $01 ; $406d
	call Func_38_40a5 ; $406f
	ld c, $00 ; $4072
	ld b, $48 ; $4074
	call Func_00_1f51 ; $4076
	pop de ; $4079
	ret ; $407a
Func_38_407b:
	ldh a, [$ff8c] ; $407b
	and a, $0f ; $407d
	ld hl, $4095 ; $407f
	add a, l ; $4082
	ld l, a ; $4083
	jr nc, Label_38_4087 ; $4084
	inc h ; $4086
Label_38_4087:
	ld a, [hl] ; $4087
	ld b, a ; $4088
	ld a, c ; $4089
	or a, a ; $408a
	jr z, Label_38_4091 ; $408b
	ld a, b ; $408d
	add a, d ; $408e
	ld d, a ; $408f
	ret ; $4090
Label_38_4091:
	ld a, d ; $4091
	sub a, b ; $4092
	ld d, a ; $4093
	ret ; $4094
	INCBIN "data/bank_038/d_4095.bin" ; $4095, 16 bytes
Func_38_40a5:
	ldh a, [$ff8c] ; $40a5
	and a, $0f ; $40a7
	ld hl, $40bf ; $40a9
	add a, l ; $40ac
	ld l, a ; $40ad
	jr nc, Label_38_40b1 ; $40ae
	inc h ; $40b0
Label_38_40b1:
	ld a, [hl] ; $40b1
	ld b, a ; $40b2
	ld a, c ; $40b3
	or a, a ; $40b4
	jr z, Label_38_40bb ; $40b5
	ld a, b ; $40b7
	add a, e ; $40b8
	ld e, a ; $40b9
	ret ; $40ba
Label_38_40bb:
	ld a, e ; $40bb
	sub a, b ; $40bc
	ld e, a ; $40bd
	ret ; $40be
	INCBIN "data/bank_038/d_40bf.bin" ; $40bf, 75 bytes
Func_38_410a:
	ld a, [$cb04] ; $410a
	ld d, a ; $410d
	ld a, [$cb05] ; $410e
	ld e, a ; $4111
	ld a, [$cb0d] ; $4112
	bit 4, a ; $4115
	jr z, Label_38_412e ; $4117
	ld a, [$cb04] ; $4119
	inc a ; $411c
	add a, a ; $411d
	jr nc, Label_38_4124 ; $411e
	ld a, b ; $4120
	dec a ; $4121
	jr Label_38_4129 ; $4122
Label_38_4124:
	rra ; $4124
	cp a, b ; $4125
	jr c, Label_38_4129 ; $4126
	xor a, a ; $4128
Label_38_4129:
	ld [$cb04], a ; $4129
	jr Label_38_4177 ; $412c
Label_38_412e:
	bit 5, a ; $412e
	jr z, Label_38_4147 ; $4130
	ld a, [$cb04] ; $4132
	dec a ; $4135
	add a, a ; $4136
	jr nc, Label_38_413d ; $4137
	ld a, b ; $4139
	dec a ; $413a
	jr Label_38_4142 ; $413b
Label_38_413d:
	rra ; $413d
	cp a, b ; $413e
	jr c, Label_38_4142 ; $413f
	xor a, a ; $4141
Label_38_4142:
	ld [$cb04], a ; $4142
	jr Label_38_4177 ; $4145
Label_38_4147:
	bit 6, a ; $4147
	jr z, Label_38_4160 ; $4149
	ld a, [$cb05] ; $414b
	dec a ; $414e
	add a, a ; $414f
	jr nc, Label_38_4156 ; $4150
	ld a, c ; $4152
	dec a ; $4153
	jr Label_38_415b ; $4154
Label_38_4156:
	rra ; $4156
	cp a, c ; $4157
	jr c, Label_38_415b ; $4158
	xor a, a ; $415a
Label_38_415b:
	ld [$cb05], a ; $415b
	jr Label_38_4177 ; $415e
Label_38_4160:
	bit 7, a ; $4160
	jr z, Label_38_4177 ; $4162
	ld a, [$cb05] ; $4164
	inc a ; $4167
	add a, a ; $4168
	jr nc, Label_38_416f ; $4169
	ld a, c ; $416b
	dec a ; $416c
	jr Label_38_4174 ; $416d
Label_38_416f:
	rra ; $416f
	cp a, c ; $4170
	jr c, Label_38_4174 ; $4171
	xor a, a ; $4173
Label_38_4174:
	ld [$cb05], a ; $4174
Label_38_4177:
	ld a, [$cb04] ; $4177
	cp a, d ; $417a
	jr nz, Label_38_4185 ; $417b
	ld a, [$cb05] ; $417d
	cp a, e ; $4180
	jr nz, Label_38_4185 ; $4181
	xor a, a ; $4183
	ret ; $4184
Label_38_4185:
	ld a, $01 ; $4185
	ret ; $4187
	INCBIN "data/bank_038/d_4188.bin" ; $4188, 529 bytes
Func_38_4399:
	ld a, [$cb05] ; $4399
	ld b, a ; $439c
	xor a, a ; $439d
	inc b ; $439e
Label_38_439f:
	dec b ; $439f
	jr z, Label_38_43a5 ; $43a0
	add a, c ; $43a2
	jr Label_38_439f ; $43a3
Label_38_43a5:
	ld b, a ; $43a5
	ld a, [$cb04] ; $43a6
	add a, b ; $43a9
	ret ; $43aa
	INCBIN "data/bank_038/d_43ab.bin" ; $43ab, 16 bytes
Func_38_43bb:
	ld d, $00 ; $43bb
	ld a, c ; $43bd
Label_38_43be:
	cp a, b ; $43be
	jr c, Label_38_43c5 ; $43bf
	inc d ; $43c1
	sub a, b ; $43c2
	jr Label_38_43be ; $43c3
Label_38_43c5:
	ld [$cb04], a ; $43c5
	ld a, d ; $43c8
	ld [$cb05], a ; $43c9
	ret ; $43cc
	INCBIN "data/bank_038/d_43cd.bin" ; $43cd, 63 bytes
Func_38_440c:
	push af ; $440c
	push bc ; $440d
Label_38_440e:
	ld a, [hl] ; $440e
	cp a, $00 ; $440f
	jr z, Label_38_4442 ; $4411
	ld [de], a ; $4413
	inc hl ; $4414
	ld a, [hl] ; $4415
	cp a, $de ; $4416
	jr z, Label_38_441e ; $4418
	cp a, $df ; $441a
	jr nz, Label_38_4433 ; $441c
Label_38_441e:
	push hl ; $441e
	push bc ; $441f
	ld h, d ; $4420
	ld l, e ; $4421
	ld bc, $ffe0 ; $4422
	add hl, bc ; $4425
	ld b, a ; $4426
	ld a, [hl] ; $4427
	cp a, $03 ; $4428
	ld a, b ; $442a
	jr nz, Label_38_442f ; $442b
	sub a, $d0 ; $442d
Label_38_442f:
	ld [hl], a ; $442f
	pop bc ; $4430
	pop hl ; $4431
	inc hl ; $4432
Label_38_4433:
	inc de ; $4433
	ld a, e ; $4434
	and a, $1f ; $4435
	jr nz, Label_38_440e ; $4437
	push hl ; $4439
	ld h, d ; $443a
	ld l, e ; $443b
	add hl, de ; $443c
	ld d, h ; $443d
	ld e, l ; $443e
	pop hl ; $443f
	jr Label_38_440e ; $4440
Label_38_4442:
	pop bc ; $4442
	pop af ; $4443
	ret ; $4444
Func_38_4445:
	push af ; $4445
	push bc ; $4446
	push hl ; $4447
	add sp, -10 ; $4448
	push bc ; $444a
	push de ; $444b
	ld c, l ; $444c
	ld b, h ; $444d
	ld hl, sp + 4 ; $444e
	ld e, l ; $4450
	ld d, h ; $4451
	ld l, c ; $4452
	ld h, b ; $4453
	ld c, e ; $4454
	ld b, d ; $4455
	call Func_00_1972 ; $4456
	ld l, c ; $4459
	ld h, b ; $445a
	pop de ; $445b
	pop bc ; $445c
	call Func_38_4466 ; $445d
	add sp, 10 ; $4460
	pop hl ; $4462
	pop bc ; $4463
	pop af ; $4464
	ret ; $4465
Func_38_4466:
	ld a, [hl+] ; $4466
	and a, a ; $4467
	jr z, Label_38_446f ; $4468
	call Func_38_4470 ; $446a
	jr Func_38_4466 ; $446d
Label_38_446f:
	ret ; $446f
Func_38_4470:
	push hl ; $4470
	ld hl, $d240 ; $4471
	sub a, $30 ; $4474
	jr c, Label_38_4486 ; $4476
	add a, $30 ; $4478
	ld b, a ; $447a
	ld a, $03 ; $447b
	ldh [$ff96], a ; $447d
	ldh [rWBK], a ; $447f
	ld a, b ; $4481
	ld [de], a ; $4482
	inc de ; $4483
	pop hl ; $4484
	ret ; $4485
Label_38_4486:
	inc de ; $4486
	pop hl ; $4487
	ret ; $4488
	INCBIN "data/bank_038/d_4489.bin" ; $4489, 830 bytes
	rst Rst08 ; $47c7
	inc bc ; $47c8
	ld a, $02 ; $47c9
	ldh [$ff96], a ; $47cb
	ldh [rWBK], a ; $47cd
	ld a, b ; $47cf
	ld [$cb52], a ; $47d0
	ld a, $07 ; $47d3
	ldh [$ff96], a ; $47d5
	ldh [rWBK], a ; $47d7
	ld hl, $df00 ; $47d9
	ld c, $10 ; $47dc
	call ClearMemory16 ; $47de
	ld a, $06 ; $47e1
	ldh [$ff96], a ; $47e3
	ldh [rWBK], a ; $47e5
	ld hl, $df00 ; $47e7
	ld c, $10 ; $47ea
	call ClearMemory16 ; $47ec
	ld a, $05 ; $47ef
	ldh [$ff96], a ; $47f1
	ldh [rWBK], a ; $47f3
	ld hl, $df00 ; $47f5
	ld c, $10 ; $47f8
	call ClearMemory16 ; $47fa
	ld a, $04 ; $47fd
	ldh [$ff96], a ; $47ff
	ldh [rWBK], a ; $4801
	ld hl, $df00 ; $4803
	ld c, $10 ; $4806
	call ClearMemory16 ; $4808
	rst Rst18 ; $480b
	ld [bc], a ; $480c
	INCBIN "data/bank_038/d_480d.bin" ; $480d, 1 bytes
	call Func_00_1b38 ; $480e
	xor a, a ; $4811
	ld [$cb4f], a ; $4812
	ld [$cb50], a ; $4815
	ld [$cb51], a ; $4818
	call DisableLCDSafely ; $481b
	call Func_00_1b38 ; $481e
	call Func_38_4975 ; $4821
	call Func_38_4bac ; $4824
	ld a, $01 ; $4827
	ld hl, $4408 ; $4829
	call Func_00_1b6a ; $482c
	ld a, $01 ; $482f
	ld hl, $4bac ; $4831
	call Func_00_1b6a ; $4834
	ld a, $01 ; $4837
	ld hl, $4e23 ; $4839
	call Func_00_1b6a ; $483c
	call EnableLCD ; $483f
	ld c, $08 ; $4842
	call Func_00_1d2e ; $4844
	call Func_00_1da4 ; $4847
	ld hl, rIE ; $484a
	res 2, [hl] ; $484d
	ld a, $01 ; $484f
	ld hl, $4e52 ; $4851
	call Func_00_1b6a ; $4854
Label_38_4857:
	ldh a, [$ff91] ; $4857
	ld [$cb0d], a ; $4859
	ld b, $02 ; $485c
	ld c, $01 ; $485e
	call Func_38_410a ; $4860
	or a, a ; $4863
	jr z, Label_38_4869 ; $4864
	call Func_38_4aae ; $4866
Label_38_4869:
	call Func_00_2631 ; $4869
	ldh a, [$ff91] ; $486c
	bit 0, a ; $486e
	jr nz, Label_38_487c ; $4870
	bit 1, a ; $4872
	jr nz, Label_38_48d3 ; $4874
	bit 3, a ; $4876
	jr nz, Label_38_48f1 ; $4878
	jr Label_38_4857 ; $487a
Label_38_487c:
	rst Rst08 ; $487c
	ld e, a ; $487d
	ld c, $10 ; $487e
	call Func_00_1d20 ; $4880
	call Func_00_1da4 ; $4883
	ld c, $02 ; $4886
	call Func_38_4399 ; $4888
	push af ; $488b
	ld a, $02 ; $488c
	ldh [$ff96], a ; $488e
	ldh [rWBK], a ; $4890
	ld a, [$cb50] ; $4892
	ld b, a ; $4895
	ld a, [$cb52] ; $4896
	add a, a ; $4899
	ld c, a ; $489a
	pop af ; $489b
	add a, c ; $489c
	push af ; $489d
	ld d, a ; $489e
	ld a, [$cb00] ; $489f
	rst Rst18 ; $48a2
	ld b, $02 ; $48a3
	push af ; $48a5
	ld hl, $c900 ; $48a6
	ld a, [$cb00] ; $48a9
	or a, a ; $48ac
	jr z, Label_38_48b1 ; $48ad
	ld l, $40 ; $48af
Label_38_48b1:
	ld a, l ; $48b1
	add a, $0e ; $48b2
	ld l, a ; $48b4
	ld a, h ; $48b5
	adc a, $00 ; $48b6
	ld h, a ; $48b8
	pop af ; $48b9
	ld a, [$cb50] ; $48ba
	ld [hl], a ; $48bd
	pop af ; $48be
	push af ; $48bf
	call Func_00_1b38 ; $48c0
	ld hl, rIE ; $48c3
	set 2, [hl] ; $48c6
	call DisableLCDSafely ; $48c8
	rst Rst18 ; $48cb
	ld a, [bc] ; $48cc
	INCBIN "data/bank_038/d_48cd.bin" ; $48cd, 1 bytes
	call EnableLCD ; $48ce
	pop af ; $48d1
	ret ; $48d2
Label_38_48d3:
	rst Rst08 ; $48d3
	ld h, d ; $48d4
	ld c, $10 ; $48d5
	call Func_00_1d20 ; $48d7
	call Func_00_1da4 ; $48da
	call Func_00_1b38 ; $48dd
	ld hl, rIE ; $48e0
	set 2, [hl] ; $48e3
	call DisableLCDSafely ; $48e5
	rst Rst18 ; $48e8
	ld a, [bc] ; $48e9
	INCBIN "data/bank_038/d_48ea.bin" ; $48ea, 1 bytes
	call EnableLCD ; $48eb
	ld a, $ff ; $48ee
	ret ; $48f0
Label_38_48f1:
	rst Rst08 ; $48f1
	ld e, [hl] ; $48f2
	ldh a, [$ff96] ; $48f3
	push af ; $48f5
	ld a, $02 ; $48f6
	ldh [$ff96], a ; $48f8
	ldh [rWBK], a ; $48fa
	ld a, [$cb50] ; $48fc
	xor a, $01 ; $48ff
	ld [$cb50], a ; $4901
	pop af ; $4904
	ldh [$ff96], a ; $4905
	ldh [rWBK], a ; $4907
	jp Label_38_4857 ; $4909
	INCBIN "data/bank_038/d_490c.bin" ; $490c, 32 bytes
Func_38_492c:
	ld b, $04 ; $492c
	ld c, $0b ; $492e
	rst Rst18 ; $4930
	ld c, $39 ; $4931
	ld b, $05 ; $4933
	ld c, $0b ; $4935
	rst Rst18 ; $4937
	ld c, $39 ; $4938
	ld b, $06 ; $493a
	ld c, $0b ; $493c
	rst Rst18 ; $493e
	ld c, $39 ; $493f
	ld b, $07 ; $4941
	ld c, $0b ; $4943
	rst Rst18 ; $4945
	ld c, $39 ; $4946
	ret ; $4948
Func_38_4949:
	ld c, $02 ; $4949
	call Func_38_4399 ; $494b
	ld b, a ; $494e
	ldh a, [$ff96] ; $494f
	push af ; $4951
	ld a, $02 ; $4952
	ldh [$ff96], a ; $4954
	ldh [rWBK], a ; $4956
	ld a, [$cb52] ; $4958
	ld c, a ; $495b
	pop af ; $495c
	ldh [$ff96], a ; $495d
	ldh [rWBK], a ; $495f
	ld a, c ; $4961
	add a, a ; $4962
	add a, b ; $4963
	ld b, a ; $4964
	ld d, $04 ; $4965
	add a, d ; $4967
	ld d, a ; $4968
	ld a, b ; $4969
	rst Rst18 ; $496a
	inc [hl] ; $496b
	ld [bc], a ; $496c
	rst Rst18 ; $496d
	ld [bc], a ; $496e
	INCBIN "data/bank_038/d_496f.bin" ; $496f, 1 bytes
	ret ; $4970
	INCBIN "data/bank_038/d_4971.bin" ; $4971, 4 bytes
Func_38_4975:
	xor a, a ; $4975
	ldh [$ff8b], a ; $4976
	ldh [$ff8a], a ; $4978
	ld a, $02 ; $497a
	ldh [$ff96], a ; $497c
	ldh [rWBK], a ; $497e
	xor a, a ; $4980
	ld [$cb4f], a ; $4981
	ld [$cb50], a ; $4984
	ld [$cb51], a ; $4987
	ld [$c320], a ; $498a
	ld [$c321], a ; $498d
	ld [$c322], a ; $4990
	ld [$c323], a ; $4993
	ld a, $90 ; $4996
	ldh [rWY], a ; $4998
	call Func_00_1e1d ; $499a
	ld a, $02 ; $499d
	ld [$c8f3], a ; $499f
	rst Rst18 ; $49a2
	nop ; $49a3
	inc b ; $49a4
	ld b, $02 ; $49a5
	ld c, $00 ; $49a7
	call Func_38_43bb ; $49a9
	rst Rst18 ; $49ac
	ld a, [bc] ; $49ad
	INCBIN "data/bank_038/d_49ae.bin" ; $49ae, 1 bytes
	ld c, $05 ; $49af
	rst Rst18 ; $49b1
	nop ; $49b2
	add hl, sp ; $49b3
	call Func_38_492c ; $49b4
	rst Rst18 ; $49b7
	halt ; $49b8
	dec b ; $49b9
	ld b, $11 ; $49ba
	ld c, $10 ; $49bc
	ld de, $9000 ; $49be
	rst Rst18 ; $49c1
	INCBIN "data/bank_038/d_49c2.bin" ; $49c2, 2 bytes
	ld a, $05 ; $49c4
	ldh [$ff96], a ; $49c6
	ldh [rWBK], a ; $49c8
	ld a, $03 ; $49ca
	ld [$c3b3], a ; $49cc
	ld a, $00 ; $49cf
	ld [$c3b6], a ; $49d1
	ld d, $00 ; $49d4
	ld e, $0f ; $49d6
	ld b, $14 ; $49d8
	ld c, $03 ; $49da
	rst Rst18 ; $49dc
	ld a, b ; $49dd
	dec b ; $49de
	rst Rst18 ; $49df
	ld a, h ; $49e0
	dec b ; $49e1
	rst Rst18 ; $49e2
	ld a, [hl] ; $49e3
	dec b ; $49e4
	ld d, $00 ; $49e5
	ld e, $02 ; $49e7
	ld b, $14 ; $49e9
	ld c, $03 ; $49eb
	rst Rst18 ; $49ed
	ld a, b ; $49ee
	dec b ; $49ef
	rst Rst18 ; $49f0
	ld a, h ; $49f1
	dec b ; $49f2
	rst Rst18 ; $49f3
	ld a, [hl] ; $49f4
	dec b ; $49f5
	rst Rst18 ; $49f6
	adc a, h ; $49f7
	dec b ; $49f8
	call Func_38_4b21 ; $49f9
	call Func_38_4d66 ; $49fc
	call Func_38_4949 ; $49ff
	call Func_38_4d14 ; $4a02
	call Func_38_4acf ; $4a05
	rst Rst18 ; $4a08
	sub a, b ; $4a09
	dec b ; $4a0a
	ld a, $00 ; $4a0b
	rst Rst18 ; $4a0d
	INCBIN "data/bank_038/d_4a0e.bin" ; $4a0e, 2 bytes
	ld de, $b200 ; $4a10
	rst Rst18 ; $4a13
	jr Label_38_4a31 ; $4a14
	ld a, $01 ; $4a16
	rst Rst18 ; $4a18
	INCBIN "data/bank_038/d_4a19.bin" ; $4a19, 2 bytes
	ld de, $b300 ; $4a1b
	rst Rst18 ; $4a1e
	jr Label_38_4a3c ; $4a1f
	ld a, $02 ; $4a21
	ldh [$ff96], a ; $4a23
	ldh [rWBK], a ; $4a25
	ld a, [$cb52] ; $4a27
	or a, a ; $4a2a
	jr z, Label_38_4a61 ; $4a2b
	ld a, $02 ; $4a2d
	rst Rst18 ; $4a2f
	INCBIN "data/bank_038/d_4a30.bin" ; $4a30, 1 bytes
Label_38_4a31:
	dec de ; $4a31
	ld de, $b200 ; $4a32
	rst Rst18 ; $4a35
	jr Label_38_4a53 ; $4a36
	INCBIN "data/bank_038/d_4a38.bin" ; $4a38, 4 bytes
Label_38_4a3c:
	dec de ; $4a3c
	ld de, $b300 ; $4a3d
	rst Rst18 ; $4a40
	jr Label_38_4a5e ; $4a41
	INCBIN "data/bank_038/d_4a43.bin" ; $4a43, 16 bytes
Label_38_4a53:
	inc c ; $4a53
	add hl, sp ; $4a54
	ld b, $03 ; $4a55
	ld c, $03 ; $4a57
	ld de, $d50e ; $4a59
	ld h, $0f ; $4a5c
Label_38_4a5e:
	rst Rst18 ; $4a5e
	inc c ; $4a5f
	add hl, sp ; $4a60
Label_38_4a61:
	ld b, $13 ; $4a61
	ld c, $04 ; $4a63
	ld de, $8000 ; $4a65
	rst Rst18 ; $4a68
	INCBIN "data/bank_038/d_4a69.bin" ; $4a69, 2 bytes
	ld b, $08 ; $4a6b
	ld c, $0c ; $4a6d
	rst Rst18 ; $4a6f
	ld c, $39 ; $4a70
	rst Rst18 ; $4a72
	ld [bc], a ; $4a73
	add hl, sp ; $4a74
	ld a, $02 ; $4a75
	ldh [$ff96], a ; $4a77
	ldh [rWBK], a ; $4a79
	xor a, a ; $4a7b
	ld [$cb4f], a ; $4a7c
	ld [$cb51], a ; $4a7f
	ld [$cb50], a ; $4a82
	rst Rst18 ; $4a85
	inc h ; $4a86
	add hl, sp ; $4a87
	ld b, $01 ; $4a88
	ld c, $01 ; $4a8a
	rst Rst18 ; $4a8c
	ld h, $39 ; $4a8d
	ld a, $10 ; $4a8f
	ld [$cb15], a ; $4a91
	ld [$cb16], a ; $4a94
	ld b, $48 ; $4a97
	ld c, $14 ; $4a99
	ld de, $8100 ; $4a9b
	rst Rst18 ; $4a9e
	INCBIN "data/bank_038/d_4a9f.bin" ; $4a9f, 2 bytes
	call Func_38_492c ; $4aa1
	call Func_38_4949 ; $4aa4
	call Func_38_4d14 ; $4aa7
	call Func_38_4d66 ; $4aaa
	ret ; $4aad
Func_38_4aae:
	rst Rst08 ; $4aae
	ld e, [hl] ; $4aaf
	call Func_38_492c ; $4ab0
	call Func_38_4949 ; $4ab3
	call Func_38_4d14 ; $4ab6
	call Func_38_4d66 ; $4ab9
	ldh a, [$ff96] ; $4abc
	push af ; $4abe
	ld a, $02 ; $4abf
	ldh [$ff96], a ; $4ac1
	ldh [rWBK], a ; $4ac3
	xor a, a ; $4ac5
	ld [$cb51], a ; $4ac6
	pop af ; $4ac9
	ldh [$ff96], a ; $4aca
	ldh [rWBK], a ; $4acc
	ret ; $4ace
Func_38_4acf:
	push af ; $4acf
	push bc ; $4ad0
	push de ; $4ad1
	push hl ; $4ad2
	ldh a, [$ff96] ; $4ad3
	push af ; $4ad5
	ld a, $02 ; $4ad6
	ldh [$ff96], a ; $4ad8
	ldh [rWBK], a ; $4ada
	ld a, [$cb52] ; $4adc
	or a, a ; $4adf
	jr nz, Label_38_4af5 ; $4ae0
	ld a, $03 ; $4ae2
	ldh [$ff96], a ; $4ae4
	ldh [rWBK], a ; $4ae6
	ld hl, $0075 ; $4ae8
	ld de, $d061 ; $4aeb
	ld c, $12 ; $4aee
	rst Rst18 ; $4af0
	inc e ; $4af1
	dec b ; $4af2
	jr Label_38_4b06 ; $4af3
Label_38_4af5:
	ld a, $03 ; $4af5
	ldh [$ff96], a ; $4af7
	ldh [rWBK], a ; $4af9
	ld hl, $0077 ; $4afb
	ld de, $d062 ; $4afe
	ld c, $12 ; $4b01
	rst Rst18 ; $4b03
	inc e ; $4b04
	dec b ; $4b05
Label_38_4b06:
	ld a, $03 ; $4b06
	ldh [$ff96], a ; $4b08
	ldh [rWBK], a ; $4b0a
	ld hl, $0076 ; $4b0c
	ld de, $d201 ; $4b0f
	ld c, $12 ; $4b12
	rst Rst18 ; $4b14
	inc e ; $4b15
	dec b ; $4b16
	pop af ; $4b17
	ldh [$ff96], a ; $4b18
	ldh [rWBK], a ; $4b1a
	pop hl ; $4b1c
	pop de ; $4b1d
	pop bc ; $4b1e
	pop af ; $4b1f
	ret ; $4b20
Func_38_4b21:
	ld a, $07 ; $4b21
	ldh [$ff96], a ; $4b23
	ldh [rWBK], a ; $4b25
	ld hl, $df00 ; $4b27
	ld c, $10 ; $4b2a
	call ClearMemory16 ; $4b2c
	ld a, $06 ; $4b2f
	ldh [$ff96], a ; $4b31
	ldh [rWBK], a ; $4b33
	ld hl, $df00 ; $4b35
	ld c, $10 ; $4b38
	call ClearMemory16 ; $4b3a
	ld a, $05 ; $4b3d
	ldh [$ff96], a ; $4b3f
	ldh [rWBK], a ; $4b41
	ld hl, $df00 ; $4b43
	ld c, $10 ; $4b46
	call ClearMemory16 ; $4b48
	ld a, $04 ; $4b4b
	ldh [$ff96], a ; $4b4d
	ldh [rWBK], a ; $4b4f
	ld hl, $df00 ; $4b51
	ld c, $10 ; $4b54
	call ClearMemory16 ; $4b56
	ld a, $00 ; $4b59
	rst Rst18 ; $4b5b
	inc [hl] ; $4b5c
	ld [bc], a ; $4b5d
	ld e, a ; $4b5e
	ld d, $00 ; $4b5f
	ld a, $04 ; $4b61
	ldh [$ff96], a ; $4b63
	ldh [rWBK], a ; $4b65
	ld a, $00 ; $4b67
	rst Rst18 ; $4b69
	inc c ; $4b6a
	INCBIN "data/bank_038/d_4b6b.bin" ; $4b6b, 1 bytes
	ld a, $01 ; $4b6c
	rst Rst18 ; $4b6e
	inc [hl] ; $4b6f
	ld [bc], a ; $4b70
	ld e, a ; $4b71
	ld d, $01 ; $4b72
	ld a, $05 ; $4b74
	ldh [$ff96], a ; $4b76
	ldh [rWBK], a ; $4b78
	ld a, $01 ; $4b7a
	rst Rst18 ; $4b7c
	inc c ; $4b7d
	INCBIN "data/bank_038/d_4b7e.bin" ; $4b7e, 1 bytes
	ld a, $02 ; $4b7f
	rst Rst18 ; $4b81
	inc [hl] ; $4b82
	ld [bc], a ; $4b83
	ld e, a ; $4b84
	ld d, $02 ; $4b85
	ld a, $06 ; $4b87
	ldh [$ff96], a ; $4b89
	ldh [rWBK], a ; $4b8b
	ld a, $02 ; $4b8d
	rst Rst18 ; $4b8f
	inc c ; $4b90
	INCBIN "data/bank_038/d_4b91.bin" ; $4b91, 1 bytes
	ld a, $03 ; $4b92
	rst Rst18 ; $4b94
	inc [hl] ; $4b95
	ld [bc], a ; $4b96
	ld e, a ; $4b97
	ld d, $03 ; $4b98
	ld a, $07 ; $4b9a
	ldh [$ff96], a ; $4b9c
	ldh [rWBK], a ; $4b9e
	ld a, $03 ; $4ba0
	rst Rst18 ; $4ba2
	inc c ; $4ba3
	INCBIN "data/bank_038/d_4ba4.bin" ; $4ba4, 1 bytes
	ld a, $04 ; $4ba5
	ldh [$ff96], a ; $4ba7
	ldh [rWBK], a ; $4ba9
	ret ; $4bab
Func_38_4bac:
	ld a, $04 ; $4bac
	ldh [$ff96], a ; $4bae
	ldh [rWBK], a ; $4bb0
	ld hl, $df00 ; $4bb2
	call Func_38_4ce2 ; $4bb5
	ld a, $58 ; $4bb8
	ld [$df82], a ; $4bba
	ld a, $20 ; $4bbd
	ld [$df83], a ; $4bbf
	ld a, $05 ; $4bc2
	ldh [$ff96], a ; $4bc4
	ldh [rWBK], a ; $4bc6
	ld hl, $df00 ; $4bc8
	call Func_38_4ce2 ; $4bcb
	ld a, $58 ; $4bce
	ld [$df82], a ; $4bd0
	ld a, $61 ; $4bd3
	ld [$df83], a ; $4bd5
	ld a, $06 ; $4bd8
	ldh [$ff96], a ; $4bda
	ldh [rWBK], a ; $4bdc
	ld hl, $df00 ; $4bde
	call Func_38_4ce2 ; $4be1
	ld a, $c8 ; $4be4
	ld [$df82], a ; $4be6
	ld a, $c8 ; $4be9
	ld [$df83], a ; $4beb
	ld a, $07 ; $4bee
	ldh [$ff96], a ; $4bf0
	ldh [rWBK], a ; $4bf2
	ld hl, $df00 ; $4bf4
	call Func_38_4ce2 ; $4bf7
	ld a, $c8 ; $4bfa
	ld [$df82], a ; $4bfc
	ld a, $c8 ; $4bff
	ld [$df83], a ; $4c01
	ld a, $04 ; $4c04
	ldh [$ff96], a ; $4c06
	ldh [rWBK], a ; $4c08
	ldh a, [$ff96] ; $4c0a
	push af ; $4c0c
	ld a, $02 ; $4c0d
	ldh [$ff96], a ; $4c0f
	ldh [rWBK], a ; $4c11
	ld a, [$cb52] ; $4c13
	ld b, a ; $4c16
	pop af ; $4c17
	ldh [$ff96], a ; $4c18
	ldh [rWBK], a ; $4c1a
	ld a, b ; $4c1c
	or a, a ; $4c1d
	jr z, Label_38_4c66 ; $4c1e
	ld a, $04 ; $4c20
	ldh [$ff96], a ; $4c22
	ldh [rWBK], a ; $4c24
	ld a, $c8 ; $4c26
	ld [$df82], a ; $4c28
	ld a, $c8 ; $4c2b
	ld [$df83], a ; $4c2d
	ld a, $05 ; $4c30
	ldh [$ff96], a ; $4c32
	ldh [rWBK], a ; $4c34
	ld a, $c8 ; $4c36
	ld [$df82], a ; $4c38
	ld a, $c8 ; $4c3b
	ld [$df83], a ; $4c3d
	ld a, $06 ; $4c40
	ldh [$ff96], a ; $4c42
	ldh [rWBK], a ; $4c44
	ld a, $58 ; $4c46
	ld [$df82], a ; $4c48
	ld a, $20 ; $4c4b
	ld [$df83], a ; $4c4d
	ld a, $07 ; $4c50
	ldh [$ff96], a ; $4c52
	ldh [rWBK], a ; $4c54
	ld a, $58 ; $4c56
	ld [$df82], a ; $4c58
	ld a, $61 ; $4c5b
	ld [$df83], a ; $4c5d
	ld a, $04 ; $4c60
	ldh [$ff96], a ; $4c62
	ldh [rWBK], a ; $4c64
Label_38_4c66:
	ldh a, [$ff96] ; $4c66
	push af ; $4c68
	ld a, $02 ; $4c69
	ldh [$ff96], a ; $4c6b
	ldh [rWBK], a ; $4c6d
	ld a, [$cb50] ; $4c6f
	ld c, a ; $4c72
	pop af ; $4c73
	ldh [$ff96], a ; $4c74
	ldh [rWBK], a ; $4c76
	ld a, c ; $4c78
	or a, a ; $4c79
	jr z, Label_38_4ca8 ; $4c7a
	ld a, $04 ; $4c7c
	ldh [$ff96], a ; $4c7e
	ldh [rWBK], a ; $4c80
	ld hl, $df81 ; $4c82
	set 5, [hl] ; $4c85
	ld a, $05 ; $4c87
	ldh [$ff96], a ; $4c89
	ldh [rWBK], a ; $4c8b
	ld hl, $df81 ; $4c8d
	set 5, [hl] ; $4c90
	ld a, $06 ; $4c92
	ldh [$ff96], a ; $4c94
	ldh [rWBK], a ; $4c96
	ld hl, $df81 ; $4c98
	set 5, [hl] ; $4c9b
	ld a, $07 ; $4c9d
	ldh [$ff96], a ; $4c9f
	ldh [rWBK], a ; $4ca1
	ld hl, $df81 ; $4ca3
	set 5, [hl] ; $4ca6
Label_38_4ca8:
	ld a, $04 ; $4ca8
	ldh [$ff96], a ; $4caa
	ldh [rWBK], a ; $4cac
	ld hl, $df80 ; $4cae
	rst Rst18 ; $4cb1
	INCBIN "data/bank_038/d_4cb2.bin" ; $4cb2, 2 bytes
	ld a, $05 ; $4cb4
	ldh [$ff96], a ; $4cb6
	ldh [rWBK], a ; $4cb8
	ld hl, $df80 ; $4cba
	rst Rst18 ; $4cbd
	INCBIN "data/bank_038/d_4cbe.bin" ; $4cbe, 2 bytes
	ld a, $06 ; $4cc0
	ldh [$ff96], a ; $4cc2
	ldh [rWBK], a ; $4cc4
	ld hl, $df80 ; $4cc6
	rst Rst18 ; $4cc9
	INCBIN "data/bank_038/d_4cca.bin" ; $4cca, 2 bytes
	ld a, $07 ; $4ccc
	ldh [$ff96], a ; $4cce
	ldh [rWBK], a ; $4cd0
	ld hl, $df80 ; $4cd2
	rst Rst18 ; $4cd5
	INCBIN "data/bank_038/d_4cd6.bin" ; $4cd6, 2 bytes
	ld a, $04 ; $4cd8
	ldh [$ff96], a ; $4cda
	ldh [rWBK], a ; $4cdc
	call Func_38_4d9b ; $4cde
	ret ; $4ce1
Func_38_4ce2:
	ld c, l ; $4ce2
	ld b, h ; $4ce3
	ld hl, $0022 ; $4ce4
	add hl, bc ; $4ce7
	ld a, [hl] ; $4ce8
	and a, a ; $4ce9
	ret z ; $4cea
	ld l, c ; $4ceb
	ld h, b ; $4cec
	push hl ; $4ced
	ld de, $df00 ; $4cee
	ld c, $08 ; $4cf1
	call CopyMemoryFast ; $4cf3
	rst Rst18 ; $4cf6
	ld a, [de] ; $4cf7
	INCBIN "data/bank_038/d_4cf8.bin" ; $4cf8, 1 bytes
	rst Rst18 ; $4cf9
	ld [de], a ; $4cfa
	INCBIN "data/bank_038/d_4cfb.bin" ; $4cfb, 1 bytes
	ld d, $02 ; $4cfc
	ld a, d ; $4cfe
	ld [$df32], a ; $4cff
	push de ; $4d02
	rst Rst18 ; $4d03
	inc d ; $4d04
	INCBIN "data/bank_038/d_4d05.bin" ; $4d05, 1 bytes
	pop de ; $4d06
	rst Rst18 ; $4d07
	ld d, $08 ; $4d08
	pop de ; $4d0a
	ld hl, $df00 ; $4d0b
	ld c, $06 ; $4d0e
	call CopyMemoryFast ; $4d10
	ret ; $4d13
Func_38_4d14:
	ld a, $04 ; $4d14
	ldh [$ff96], a ; $4d16
	ldh [rWBK], a ; $4d18
	ld d, $00 ; $4d1a
	rst Rst18 ; $4d1c
	jr nz, Label_38_4d27 ; $4d1d
	ld a, $05 ; $4d1f
	ldh [$ff96], a ; $4d21
	ldh [rWBK], a ; $4d23
	ld d, $00 ; $4d25
Label_38_4d27:
	rst Rst18 ; $4d27
	jr nz, Label_38_4d32 ; $4d28
	ld a, $06 ; $4d2a
	ldh [$ff96], a ; $4d2c
	ldh [rWBK], a ; $4d2e
	ld d, $00 ; $4d30
Label_38_4d32:
	rst Rst18 ; $4d32
	jr nz, Label_38_4d3d ; $4d33
	ld a, $07 ; $4d35
	ldh [$ff96], a ; $4d37
	ldh [rWBK], a ; $4d39
	ld d, $00 ; $4d3b
Label_38_4d3d:
	rst Rst18 ; $4d3d
	jr nz, Label_38_4d48 ; $4d3e
	call Func_38_4dfa ; $4d40
	ld a, b ; $4d43
	ldh [$ff96], a ; $4d44
	ldh [rWBK], a ; $4d46
Label_38_4d48:
	ld d, $05 ; $4d48
	rst Rst18 ; $4d4a
	jr nz, Label_38_4d55 ; $4d4b
	ld a, $04 ; $4d4d
	ldh [$ff96], a ; $4d4f
	ldh [rWBK], a ; $4d51
	ldh a, [$ff96] ; $4d53
Label_38_4d55:
	push af ; $4d55
	ld a, $02 ; $4d56
	ldh [$ff96], a ; $4d58
	ldh [rWBK], a ; $4d5a
	xor a, a ; $4d5c
	ld [$cb4f], a ; $4d5d
	pop af ; $4d60
	ldh [$ff96], a ; $4d61
	ldh [rWBK], a ; $4d63
	ret ; $4d65
Func_38_4d66:
	ld b, $0b ; $4d66
	ld c, $0b ; $4d68
	rst Rst18 ; $4d6a
	ld c, $39 ; $4d6b
	ld b, $0c ; $4d6d
	ld c, $0b ; $4d6f
	rst Rst18 ; $4d71
	ld c, $39 ; $4d72
	ld b, $0d ; $4d74
	ld c, $0b ; $4d76
	rst Rst18 ; $4d78
	ld c, $39 ; $4d79
	ld b, $0e ; $4d7b
	ld c, $0b ; $4d7d
	rst Rst18 ; $4d7f
	ld c, $39 ; $4d80
	ld b, $0f ; $4d82
	ld c, $0b ; $4d84
	rst Rst18 ; $4d86
	ld c, $39 ; $4d87
	call Func_38_4dfa ; $4d89
	ld a, b ; $4d8c
	ldh [$ff96], a ; $4d8d
	ldh [rWBK], a ; $4d8f
	rst Rst18 ; $4d91
	ld e, $08 ; $4d92
	ld a, $04 ; $4d94
	ldh [$ff96], a ; $4d96
	ldh [rWBK], a ; $4d98
	ret ; $4d9a
Func_38_4d9b:
	call Func_38_4dfa ; $4d9b
	ld a, b ; $4d9e
	ldh [$ff96], a ; $4d9f
	ldh [rWBK], a ; $4da1
	ld bc, $df00 ; $4da3
	ld hl, $002e ; $4da6
	add hl, bc ; $4da9
	ld a, [hl] ; $4daa
	cp a, $01 ; $4dab
	jr nz, Label_38_4df9 ; $4dad
	ldh a, [$ff96] ; $4daf
	push af ; $4db1
	ld a, $02 ; $4db2
	ldh [$ff96], a ; $4db4
	ldh [rWBK], a ; $4db6
	ld a, [$cb4f] ; $4db8
	inc a ; $4dbb
	ld [$cb4f], a ; $4dbc
	ld d, a ; $4dbf
	pop af ; $4dc0
	ldh [$ff96], a ; $4dc1
	ldh [rWBK], a ; $4dc3
	ld a, d ; $4dc5
	and a, $1f ; $4dc6
	jr nz, Label_38_4df9 ; $4dc8
	ld d, $05 ; $4dca
	rst Rst18 ; $4dcc
	jr nz, $4dd7 ; $4dcd
	ldh a, [$ff96] ; $4dcf
	push af ; $4dd1
	ld a, $02 ; $4dd2
	ldh [$ff96], a ; $4dd4
	ldh [rWBK], a ; $4dd6
	ld a, [$cb51] ; $4dd8
	inc a ; $4ddb
	ld [$cb51], a ; $4ddc
	cp a, $0f ; $4ddf
	jr nz, Label_38_4df4 ; $4de1
	xor a, a ; $4de3
	ld [$cb51], a ; $4de4
	call Func_38_4dfa ; $4de7
	ld a, b ; $4dea
	ldh [$ff96], a ; $4deb
	ldh [rWBK], a ; $4ded
	ld d, $07 ; $4def
	rst Rst18 ; $4df1
	jr nz, Label_38_4dfc ; $4df2
Label_38_4df4:
	pop af ; $4df4
	ldh [$ff96], a ; $4df5
	ldh [rWBK], a ; $4df7
Label_38_4df9:
	ret ; $4df9
Func_38_4dfa:
	ld c, $02 ; $4dfa
Label_38_4dfc:
	call Func_38_4399 ; $4dfc
	ld b, a ; $4dff
	ldh a, [$ff96] ; $4e00
	push af ; $4e02
	ld a, $02 ; $4e03
	ldh [$ff96], a ; $4e05
	ldh [rWBK], a ; $4e07
	ld a, [$cb52] ; $4e09
	ld c, a ; $4e0c
	pop af ; $4e0d
	ldh [$ff96], a ; $4e0e
	ldh [rWBK], a ; $4e10
	ld a, c ; $4e12
	add a, a ; $4e13
	add a, b ; $4e14
	ld hl, $4e1f ; $4e15
	add a, l ; $4e18
	ld l, a ; $4e19
	jr nc, Label_38_4e1d ; $4e1a
	inc h ; $4e1c
Label_38_4e1d:
	ld b, [hl] ; $4e1d
	ret ; $4e1e
	INCBIN "data/bank_038/d_4e1f.bin" ; $4e1f, 4 bytes
	ld c, $02 ; $4e23
	call Func_38_4399 ; $4e25
	add a, a ; $4e28
	ld hl, $4e4a ; $4e29
	add a, l ; $4e2c
	ld l, a ; $4e2d
	jr nc, Label_38_4e31 ; $4e2e
	inc h ; $4e30
Label_38_4e31:
	ld a, [hl+] ; $4e31
	ld d, [hl] ; $4e32
	ld e, a ; $4e33
	ld a, $02 ; $4e34
	ldh [$ff96], a ; $4e36
	ldh [rWBK], a ; $4e38
	ld c, $00 ; $4e3a
	ld a, [$cb50] ; $4e3c
	or a, a ; $4e3f
	jr nz, Label_38_4e44 ; $4e40
	ld c, $02 ; $4e42
Label_38_4e44:
	ld b, $00 ; $4e44
	call Func_00_1f51 ; $4e46
	ret ; $4e49
	INCBIN "data/bank_038/d_4e4a.bin" ; $4e4a, 8 bytes
	rst Rst18 ; $4e52
	jr z, $4e8e ; $4e53
	ret ; $4e55
	INCBIN "data/bank_038/d_4e56.bin" ; $4e56, 15 bytes
	rst Rst08 ; $4e65
	inc bc ; $4e66
	ld a, $03 ; $4e67
	ldh [$ff96], a ; $4e69
	ldh [rWBK], a ; $4e6b
	ld a, b ; $4e6d
	ld [$d813], a ; $4e6e
	ld a, $02 ; $4e71
	ld [$df00], a ; $4e73
	call DisableLCDSafely ; $4e76
	rst Rst18 ; $4e79
	ld a, [bc] ; $4e7a
	INCBIN "data/bank_038/d_4e7b.bin" ; $4e7b, 1 bytes
	xor a, a ; $4e7c
	ld [$d81d], a ; $4e7d
	ld hl, $da00 ; $4e80
	ld bc, $0080 ; $4e83
	call ClearBytes ; $4e86
	call Func_38_5a82 ; $4e89
	call Func_38_4f6f ; $4e8c
	call EnableLCD ; $4e8f
	ld c, $10 ; $4e92
	call Func_00_1d2e ; $4e94
	call Func_00_1da4 ; $4e97
	ld hl, rIE ; $4e9a
	res 2, [hl] ; $4e9d
	ld a, $01 ; $4e9f
	ld hl, $4e52 ; $4ea1
	call Func_00_1b6a ; $4ea4
	call Func_38_575e ; $4ea7
Label_38_4eaa:
	call Func_00_2631 ; $4eaa
	ldh a, [$ff91] ; $4ead
	ld [$cb0d], a ; $4eaf
	ld a, $03 ; $4eb2
	ldh [$ff96], a ; $4eb4
	ldh [rWBK], a ; $4eb6
	ld a, [$de00] ; $4eb8
	push de ; $4ebb
	push af ; $4ebc
	ld a, a ; $4ebd
	ld de, $0301 ; $4ebe
	call Func_00_1ae4 ; $4ec1
	pop af ; $4ec4
	pop de ; $4ec5
	ld a, [$d824] ; $4ec6
	or a, a ; $4ec9
	jr z, Label_38_4ed7 ; $4eca
	call Func_38_5545 ; $4ecc
	call Func_38_6216 ; $4ecf
	ldh a, [$ff96] ; $4ed2
	push af ; $4ed4
	jr Label_38_4f01 ; $4ed5
Label_38_4ed7:
	call Func_38_5195 ; $4ed7
	call Func_38_52b9 ; $4eda
	xor a, a ; $4edd
	ld [$cb0d], a ; $4ede
	ldh [$ff91], a ; $4ee1
	ldh a, [$ff96] ; $4ee3
	push af ; $4ee5
	ld a, $03 ; $4ee6
	ldh [$ff96], a ; $4ee8
	ldh [rWBK], a ; $4eea
	ld a, [$d814] ; $4eec
	cp a, $04 ; $4eef
	jr z, Label_38_4efe ; $4ef1
	call Func_38_4f4b ; $4ef3
	call Func_38_5545 ; $4ef6
	call Func_38_54cc ; $4ef9
	jr Label_38_4f01 ; $4efc
Label_38_4efe:
	call Func_38_549a ; $4efe
Label_38_4f01:
	ld a, [$d815] ; $4f01
	ld b, a ; $4f04
	pop af ; $4f05
	ldh [$ff96], a ; $4f06
	ldh [rWBK], a ; $4f08
	ld a, b ; $4f0a
	cp a, $01 ; $4f0b
	jr z, Label_38_4f15 ; $4f0d
	cp a, $02 ; $4f0f
	jr z, Label_38_4f36 ; $4f11
	jr Label_38_4eaa ; $4f13
Label_38_4f15:
	ld c, $08 ; $4f15
	call Func_00_1d20 ; $4f17
	call Func_00_1da4 ; $4f1a
	call Func_38_5e6e ; $4f1d
	call Func_38_5ea6 ; $4f20
	call Func_38_601c ; $4f23
	call Func_38_5f4c ; $4f26
	rst Rst18 ; $4f29
	nop ; $4f2a
	INCBIN "data/bank_038/d_4f2b.bin" ; $4f2b, 1 bytes
	call Func_00_1b38 ; $4f2c
	ld hl, rIE ; $4f2f
	set 2, [hl] ; $4f32
	xor a, a ; $4f34
	ret ; $4f35
Label_38_4f36:
	rst Rst08 ; $4f36
	ld h, d ; $4f37
	ld c, $10 ; $4f38
	call Func_00_1d20 ; $4f3a
	call Func_00_1da4 ; $4f3d
	call Func_00_1b38 ; $4f40
	ld hl, rIE ; $4f43
	set 2, [hl] ; $4f46
	ld a, $ff ; $4f48
	ret ; $4f4a
Func_38_4f4b:
	ld c, $03 ; $4f4b
	call Func_38_4399 ; $4f4d
	add a, a ; $4f50
	ld hl, $4f63 ; $4f51
	add a, l ; $4f54
	ld l, a ; $4f55
	jr nc, Label_38_4f59 ; $4f56
	inc h ; $4f58
Label_38_4f59:
	ld a, [hl+] ; $4f59
	ld d, [hl] ; $4f5a
	ld e, a ; $4f5b
	ld bc, $1008 ; $4f5c
	call Func_38_4018 ; $4f5f
	ret ; $4f62
	INCBIN "data/bank_038/d_4f63.bin" ; $4f63, 12 bytes
Func_38_4f6f:
	xor a, a ; $4f6f
	ldh [$ff8b], a ; $4f70
	ldh [$ff8a], a ; $4f72
	ld [$c320], a ; $4f74
	ld [$c321], a ; $4f77
	ld [$c322], a ; $4f7a
	ld [$c323], a ; $4f7d
	call Func_38_5d83 ; $4f80
	ld b, $03 ; $4f83
	ld c, $00 ; $4f85
	call Func_38_43bb ; $4f87
	ld a, $01 ; $4f8a
	ldh [$ff96], a ; $4f8c
	ldh [rWBK], a ; $4f8e
	ld hl, $50a7 ; $4f90
	ld de, $d000 ; $4f93
	call DecompressData ; $4f96
	ld hl, $d000 ; $4f99
	ld de, $a100 ; $4f9c
	ld c, $08 ; $4f9f
	call Func_00_0480 ; $4fa1
	ld hl, $50f1 ; $4fa4
	ld de, $0901 ; $4fa7
	call Func_00_05e1 ; $4faa
	ld a, $01 ; $4fad
	ldh [$ff96], a ; $4faf
	ldh [rWBK], a ; $4fb1
	ld hl, $50f9 ; $4fb3
	ld de, $d000 ; $4fb6
	call DecompressData ; $4fb9
	ld hl, $d000 ; $4fbc
	ld de, $a200 ; $4fbf
	ld c, $10 ; $4fc2
	call Func_00_0480 ; $4fc4
	ld c, $01 ; $4fc7
	rst Rst18 ; $4fc9
	nop ; $4fca
	add hl, sp ; $4fcb
	rst Rst18 ; $4fcc
	halt ; $4fcd
	dec b ; $4fce
	ld a, $05 ; $4fcf
	ldh [$ff96], a ; $4fd1
	ldh [rWBK], a ; $4fd3
	ld a, $03 ; $4fd5
	ld [$c3b3], a ; $4fd7
	ld a, $00 ; $4fda
	ld [$c3b6], a ; $4fdc
	ld d, $00 ; $4fdf
	ld e, $02 ; $4fe1
	ld b, $14 ; $4fe3
	ld c, $03 ; $4fe5
	rst Rst18 ; $4fe7
	ld a, b ; $4fe8
	dec b ; $4fe9
	rst Rst18 ; $4fea
	ld a, h ; $4feb
	dec b ; $4fec
	rst Rst18 ; $4fed
	ld a, [hl] ; $4fee
	dec b ; $4fef
	ld d, $00 ; $4ff0
	ld e, $0c ; $4ff2
	ld b, $14 ; $4ff4
	ld c, $06 ; $4ff6
	rst Rst18 ; $4ff8
	ld a, b ; $4ff9
	dec b ; $4ffa
	rst Rst18 ; $4ffb
	ld a, h ; $4ffc
	dec b ; $4ffd
	rst Rst18 ; $4ffe
	ld a, [hl] ; $4fff
	dec b ; $5000
	ld b, $11 ; $5001
	ld c, $10 ; $5003
	ld de, $9000 ; $5005
	rst Rst18 ; $5008
	INCBIN "data/bank_038/d_5009.bin" ; $5009, 2 bytes
	ld b, $15 ; $500b
	ld c, $10 ; $500d
	ld de, $9100 ; $500f
	rst Rst18 ; $5012
	INCBIN "data/bank_038/d_5013.bin" ; $5013, 2 bytes
	ld b, $75 ; $5015
	ld c, $14 ; $5017
	ld de, $a500 ; $5019
	rst Rst18 ; $501c
	INCBIN "data/bank_038/d_501d.bin" ; $501d, 2 bytes
	ld b, $79 ; $501f
	ld c, $14 ; $5021
	ld de, $a640 ; $5023
	rst Rst18 ; $5026
	INCBIN "data/bank_038/d_5027.bin" ; $5027, 2 bytes
	ld de, $8000 ; $5029
	call Func_38_5746 ; $502c
	ld de, $a800 ; $502f
	call Func_38_5746 ; $5032
	call Func_38_5a1b ; $5035
	call Func_38_5424 ; $5038
	call Func_38_598b ; $503b
	rst Rst18 ; $503e
	ld [bc], a ; $503f
	add hl, sp ; $5040
	ld de, $a000 ; $5041
	rst Rst18 ; $5044
	ld b, $39 ; $5045
	ld hl, $507f ; $5047
	ld de, $0b05 ; $504a
	call Func_00_05e1 ; $504d
	ld c, $0b ; $5050
	ld b, $0a ; $5052
	rst Rst18 ; $5054
	ld c, $39 ; $5055
	rst Rst18 ; $5057
	inc h ; $5058
	add hl, sp ; $5059
	ld b, $01 ; $505a
	ld c, $01 ; $505c
	rst Rst18 ; $505e
	ld h, $39 ; $505f
	ld a, $30 ; $5061
	ld [$cb15], a ; $5063
	ld [$cb16], a ; $5066
	ld a, $09 ; $5069
	ld [$cb17], a ; $506b
	ld [$cb18], a ; $506e
	ld b, $64 ; $5071
	ld c, $14 ; $5073
	ld de, $a300 ; $5075
	rst Rst18 ; $5078
	INCBIN "data/bank_038/d_5079.bin" ; $5079, 2 bytes
	rst Rst18 ; $507b
	nop ; $507c
	INCBIN "data/bank_038/d_507d.bin" ; $507d, 1 bytes
	ret ; $507e
	INCBIN "data/bank_038/d_507f.bin" ; $507f, 278 bytes
Func_38_5195:
	ldh a, [$ff96] ; $5195
	push af ; $5197
	ld a, $03 ; $5198
	ldh [$ff96], a ; $519a
	ldh [rWBK], a ; $519c
	ld a, [$d814] ; $519e
	cp a, $04 ; $51a1
	jr z, Label_38_51ee ; $51a3
	ld a, [$cb0d] ; $51a5
	ldh a, [$ff91] ; $51a8
	bit 4, a ; $51aa
	jr nz, Label_38_51bc ; $51ac
	bit 5, a ; $51ae
	jr nz, Label_38_51d2 ; $51b0
	bit 6, a ; $51b2
	jr nz, Label_38_51dc ; $51b4
	bit 7, a ; $51b6
	jr nz, Label_38_51e6 ; $51b8
	jr Label_38_51ee ; $51ba
Label_38_51bc:
	ld a, [$de00] ; $51bc
	inc a ; $51bf
	ld [$de00], a ; $51c0
	ld a, $02 ; $51c3
	ld [$df00], a ; $51c5
	call Func_38_525e ; $51c8
	xor a, a ; $51cb
	ld [$cb0d], a ; $51cc
	jp Label_38_51ee ; $51cf
Label_38_51d2:
	ld a, $02 ; $51d2
	ld [$df00], a ; $51d4
	call Func_38_528b ; $51d7
	jr Label_38_51ee ; $51da
Label_38_51dc:
	ld a, $02 ; $51dc
	ld [$df00], a ; $51de
	call Func_38_51f4 ; $51e1
	jr Label_38_51ee ; $51e4
Label_38_51e6:
	ld a, $02 ; $51e6
	ld [$df00], a ; $51e8
	call Func_38_521c ; $51eb
Label_38_51ee:
	pop af ; $51ee
	ldh [$ff96], a ; $51ef
	ldh [rWBK], a ; $51f1
	ret ; $51f3
Func_38_51f4:
	ld a, [$cb05] ; $51f4
	or a, a ; $51f7
	jr z, Label_38_5202 ; $51f8
	dec a ; $51fa
	ld [$cb05], a ; $51fb
	rst Rst08 ; $51fe
	ld e, [hl] ; $51ff
	jr Label_38_5218 ; $5200
Label_38_5202:
	ld a, [$d811] ; $5202
	or a, a ; $5205
	ret z ; $5206
	dec a ; $5207
	cp a, $02 ; $5208
	jr nz, Label_38_5210 ; $520a
	ld a, $03 ; $520c
	jr Label_38_5212 ; $520e
Label_38_5210:
	rst Rst08 ; $5210
	ld e, [hl] ; $5211
Label_38_5212:
	ld [$d811], a ; $5212
	call Func_38_5ce5 ; $5215
Label_38_5218:
	call Func_38_575e ; $5218
	ret ; $521b
Func_38_521c:
	ld a, [$cb05] ; $521c
	inc a ; $521f
	cp a, $02 ; $5220
	jr z, Label_38_522b ; $5222
	ld [$cb05], a ; $5224
	rst Rst08 ; $5227
	ld e, [hl] ; $5228
	jr Label_38_525a ; $5229
Label_38_522b:
	ld a, [$d811] ; $522b
	cp a, $02 ; $522e
	jr nc, Label_38_5243 ; $5230
	cp a, $01 ; $5232
	ret z ; $5234
	ld a, [$d823] ; $5235
	cp a, $07 ; $5238
	jr c, Label_38_525a ; $523a
	ld a, $01 ; $523c
	ld [$d811], a ; $523e
	jr Label_38_5252 ; $5241
Label_38_5243:
	inc a ; $5243
	ld e, a ; $5244
	ld a, [$d812] ; $5245
	dec a ; $5248
	ld b, a ; $5249
	ld a, e ; $524a
	cp a, b ; $524b
	jr nz, Label_38_5252 ; $524c
	ld a, b ; $524e
	dec a ; $524f
	jr Label_38_5254 ; $5250
Label_38_5252:
	rst Rst08 ; $5252
	ld e, [hl] ; $5253
Label_38_5254:
	ld [$d811], a ; $5254
	call Func_38_5ce5 ; $5257
Label_38_525a:
	call Func_38_575e ; $525a
	ret ; $525d
Func_38_525e:
	ld a, [$cb04] ; $525e
	inc a ; $5261
	cp a, $03 ; $5262
	jr nz, Label_38_527f ; $5264
	ld a, [$d811] ; $5266
	cp a, $02 ; $5269
	jr c, Label_38_5279 ; $526b
	ld a, [$d811] ; $526d
	ld [$d81b], a ; $5270
	xor a, a ; $5273
	ld [$d811], a ; $5274
	jr Label_38_527e ; $5277
Label_38_5279:
	ld a, $03 ; $5279
	ld [$d811], a ; $527b
Label_38_527e:
	xor a, a ; $527e
Label_38_527f:
	ld [$cb04], a ; $527f
	call Func_38_5ce5 ; $5282
	call Func_38_575e ; $5285
	rst Rst08 ; $5288
	ld e, [hl] ; $5289
	ret ; $528a
Func_38_528b:
	ld a, [$cb04] ; $528b
	dec a ; $528e
	cp a, $ff ; $528f
	jr nz, Label_38_52b0 ; $5291
	ld a, [$d811] ; $5293
	cp a, $02 ; $5296
	jr c, Label_38_52a6 ; $5298
	ld a, [$d811] ; $529a
	ld [$d81b], a ; $529d
	xor a, a ; $52a0
	ld [$d811], a ; $52a1
	jr Label_38_52ab ; $52a4
Label_38_52a6:
	ld a, $03 ; $52a6
	ld [$d811], a ; $52a8
Label_38_52ab:
	call Func_38_5ce5 ; $52ab
	ld a, $02 ; $52ae
Label_38_52b0:
	ld [$cb04], a ; $52b0
	call Func_38_575e ; $52b3
	rst Rst08 ; $52b6
	ld e, [hl] ; $52b7
	ret ; $52b8
Func_38_52b9:
	ld a, [$cb0d] ; $52b9
	bit 0, a ; $52bc
	jr nz, Label_38_52c9 ; $52be
	bit 1, a ; $52c0
	jr nz, Label_38_52cd ; $52c2
	bit 3, a ; $52c4
	jr nz, Label_38_52d1 ; $52c6
	ret ; $52c8
Label_38_52c9:
	call Func_38_5302 ; $52c9
	ret ; $52cc
Label_38_52cd:
	call Func_38_53b0 ; $52cd
	ret ; $52d0
Label_38_52d1:
	call Func_38_5cb7 ; $52d1
	ld b, a ; $52d4
	ld hl, $da00 ; $52d5
	add a, a ; $52d8
	add a, a ; $52d9
	add a, l ; $52da
	ld l, a ; $52db
	jr nc, Label_38_52df ; $52dc
	inc h ; $52de
Label_38_52df:
	ld a, [hl] ; $52df
	ld c, a ; $52e0
	call Func_38_6208 ; $52e1
	or a, a ; $52e4
	jr z, Label_38_5301 ; $52e5
	rst Rst08 ; $52e7
	ld e, [hl] ; $52e8
	ld a, [$df00] ; $52e9
	cp a, $02 ; $52ec
	jr z, Label_38_52f9 ; $52ee
	xor a, $01 ; $52f0
	ld [$df00], a ; $52f2
	call Func_38_575e ; $52f5
	ret ; $52f8
Label_38_52f9:
	ld a, $01 ; $52f9
	ld [$df00], a ; $52fb
	call Func_38_575e ; $52fe
Label_38_5301:
	ret ; $5301
Func_38_5302:
	ldh a, [$ff96] ; $5302
	push af ; $5304
	ld a, $03 ; $5305
	ldh [$ff96], a ; $5307
	ldh [rWBK], a ; $5309
	ld a, [$d814] ; $530b
	ld a, [$d811] ; $530e
	ld c, a ; $5311
	ld a, [$cb04] ; $5312
	ld d, a ; $5315
	ld a, [$cb05] ; $5316
	ld e, a ; $5319
	call Func_38_5d42 ; $531a
	or a, a ; $531d
	jr nz, Label_38_5368 ; $531e
	call Func_38_5cb7 ; $5320
	ld b, a ; $5323
	ld hl, $da00 ; $5324
	add a, a ; $5327
	add a, a ; $5328
	add a, l ; $5329
	ld l, a ; $532a
	jr nc, Label_38_532e ; $532b
	inc h ; $532d
Label_38_532e:
	ld a, [hl] ; $532e
	cp a, $ff ; $532f
	jr z, Label_38_5368 ; $5331
	ld c, a ; $5333
	ld a, [$d814] ; $5334
	ld hl, $d816 ; $5337
	add a, l ; $533a
	ld l, a ; $533b
	jr nc, Label_38_533f ; $533c
	inc h ; $533e
Label_38_533f:
	ld [hl], b ; $533f
	ld a, c ; $5340
	ld c, a ; $5341
	call Func_38_6208 ; $5342
	or a, a ; $5345
	jr z, Label_38_535d ; $5346
	ld a, [$df00] ; $5348
	cp a, $01 ; $534b
	jr nz, Label_38_535d ; $534d
	ld a, [$d814] ; $534f
	ld hl, $d834 ; $5352
	add a, l ; $5355
	ld l, a ; $5356
	jr nc, Label_38_535a ; $5357
	inc h ; $5359
Label_38_535a:
	ld a, $01 ; $535a
	ld [hl], a ; $535c
Label_38_535d:
	call Func_38_5cb7 ; $535d
	ld b, a ; $5360
	call Func_38_5612 ; $5361
	rst Rst08 ; $5364
	ld e, a ; $5365
	jr Label_38_5370 ; $5366
Label_38_5368:
	rst Rst08 ; $5368
	ld h, d ; $5369
	pop af ; $536a
	ldh [$ff96], a ; $536b
	ldh [rWBK], a ; $536d
	ret ; $536f
Label_38_5370:
	call Func_38_5ce5 ; $5370
	call Func_38_5cb7 ; $5373
	ld b, a ; $5376
	ld hl, $da00 ; $5377
	add a, a ; $537a
	add a, a ; $537b
	add a, l ; $537c
	ld l, a ; $537d
	jr nc, Label_38_5381 ; $537e
	inc h ; $5380
Label_38_5381:
	ld a, [hl] ; $5381
	ld c, a ; $5382
	call Func_38_61f7 ; $5383
	or a, a ; $5386
	jr z, Label_38_5390 ; $5387
	ld a, $01 ; $5389
	ld [$d824], a ; $538b
	jr Label_38_539c ; $538e
Label_38_5390:
	call Func_38_5c47 ; $5390
	cp a, $ff ; $5393
	jr nz, Label_38_539c ; $5395
	ld a, $01 ; $5397
	ld [$d815], a ; $5399
Label_38_539c:
	call Func_38_5424 ; $539c
	ld hl, $d040 ; $539f
	ld de, $9840 ; $53a2
	ld c, $04 ; $53a5
	call Func_00_0480 ; $53a7
	pop af ; $53aa
	ldh [$ff96], a ; $53ab
	ldh [rWBK], a ; $53ad
	ret ; $53af
Func_38_53b0:
	ldh a, [$ff96] ; $53b0
	push af ; $53b2
	ld a, $03 ; $53b3
	ldh [$ff96], a ; $53b5
	ldh [rWBK], a ; $53b7
	call Func_38_5c63 ; $53b9
	cp a, $ff ; $53bc
	jr nz, Label_38_53cb ; $53be
	ld a, $02 ; $53c0
	ld [$d815], a ; $53c2
	pop af ; $53c5
	ldh [$ff96], a ; $53c6
	ldh [rWBK], a ; $53c8
	ret ; $53ca
Label_38_53cb:
	rst Rst08 ; $53cb
	ld h, d ; $53cc
	ld hl, $d816 ; $53cd
	ld a, [$d814] ; $53d0
	add a, l ; $53d3
	ld l, a ; $53d4
	jr nc, Label_38_53d8 ; $53d5
	inc h ; $53d7
Label_38_53d8:
	ld a, [hl] ; $53d8
	ld b, $00 ; $53d9
	ld [hl], b ; $53db
	ld hl, $da00 ; $53dc
	add a, a ; $53df
	add a, a ; $53e0
	add a, l ; $53e1
	ld l, a ; $53e2
	jr nc, Label_38_53e6 ; $53e3
	inc h ; $53e5
Label_38_53e6:
	inc hl ; $53e6
	inc hl ; $53e7
	xor a, a ; $53e8
	ld [hl], a ; $53e9
	ld a, $03 ; $53ea
	ldh [$ff96], a ; $53ec
	ldh [rWBK], a ; $53ee
	ld hl, $d830 ; $53f0
	ld a, [$d814] ; $53f3
	add a, l ; $53f6
	ld l, a ; $53f7
	jr nc, Label_38_53fb ; $53f8
	inc h ; $53fa
Label_38_53fb:
	xor a, a ; $53fb
	ld [hl], a ; $53fc
	ld hl, $d834 ; $53fd
	ld a, [$d814] ; $5400
	add a, l ; $5403
	ld l, a ; $5404
	jr nc, Label_38_5408 ; $5405
	inc h ; $5407
Label_38_5408:
	xor a, a ; $5408
	ld [hl], a ; $5409
	call Func_38_55ab ; $540a
	call Func_38_5ce5 ; $540d
	call Func_38_5424 ; $5410
	ld hl, $d040 ; $5413
	ld de, $9840 ; $5416
	ld c, $04 ; $5419
	call Func_00_0480 ; $541b
	pop af ; $541e
	ldh [$ff96], a ; $541f
	ldh [rWBK], a ; $5421
	ret ; $5423
Func_38_5424:
	ld a, $03 ; $5424
	ldh [$ff96], a ; $5426
	ldh [rWBK], a ; $5428
	ld a, [$d814] ; $542a
	cp a, $ff ; $542d
	ret z ; $542f
	ld a, $03 ; $5430
	ldh [$ff96], a ; $5432
	ldh [rWBK], a ; $5434
	ld de, $d041 ; $5436
	ld b, $12 ; $5439
	ld c, $01 ; $543b
	ld h, $03 ; $543d
	rst Rst18 ; $543f
	inc c ; $5440
	add hl, sp ; $5441
	ld de, $d061 ; $5442
	ld b, $12 ; $5445
	ld c, $01 ; $5447
	ld h, $20 ; $5449
	rst Rst18 ; $544b
	inc c ; $544c
	add hl, sp ; $544d
	ld a, [$d824] ; $544e
	or a, a ; $5451
	jr z, Label_38_5460 ; $5452
	ld hl, $0095 ; $5454
	ld de, $d061 ; $5457
	ld c, $20 ; $545a
	rst Rst18 ; $545c
	ld [hl], d ; $545d
	dec b ; $545e
	ret ; $545f
Label_38_5460:
	ld hl, $5490 ; $5460
	ld a, [$d813] ; $5463
	cp a, $03 ; $5466
	jr z, Label_38_5471 ; $5468
	cp a, $05 ; $546a
	jr z, Label_38_5471 ; $546c
	ld hl, $5486 ; $546e
Label_38_5471:
	ld a, [$d814] ; $5471
	add a, a ; $5474
	add a, l ; $5475
	ld l, a ; $5476
	jr nc, Label_38_547a ; $5477
	inc h ; $5479
Label_38_547a:
	ld a, [hl+] ; $547a
	ld h, [hl] ; $547b
	ld l, a ; $547c
	ld de, $d061 ; $547d
	ld c, $20 ; $5480
	rst Rst18 ; $5482
	ld [hl], d ; $5483
	dec b ; $5484
	ret ; $5485
	INCBIN "data/bank_038/d_5486.bin" ; $5486, 20 bytes
Func_38_549a:
	ld c, $20 ; $549a
	ld b, $0f ; $549c
	ld de, $0840 ; $549e
	rst Rst18 ; $54a1
	inc d ; $54a2
	add hl, sp ; $54a3
	ld hl, $54ab ; $54a4
	call Func_00_1e9d ; $54a7
	ret ; $54aa
	INCBIN "data/bank_038/d_54ab.bin" ; $54ab, 33 bytes
Func_38_54cc:
	ldh a, [$ff96] ; $54cc
	push af ; $54ce
	ld a, $03 ; $54cf
	ldh [$ff96], a ; $54d1
	ldh [rWBK], a ; $54d3
	ld a, [$d814] ; $54d5
	cp a, $04 ; $54d8
	jr z, Label_38_553f ; $54da
	ld de, $0245 ; $54dc
	ld c, $01 ; $54df
	call Func_38_407b ; $54e1
	ld c, $10 ; $54e4
	ld b, $0f ; $54e6
	call Func_00_1f51 ; $54e8
	ld de, $5045 ; $54eb
	ld c, $00 ; $54ee
	call Func_38_407b ; $54f0
	ld c, $12 ; $54f3
	ld b, $0f ; $54f5
	call Func_00_1f51 ; $54f7
	ld a, [$d811] ; $54fa
	or a, a ; $54fd
	jr z, Label_38_5513 ; $54fe
	cp a, $03 ; $5500
	jr z, Label_38_5513 ; $5502
	ld de, $2a25 ; $5504
	ld c, $01 ; $5507
	call Func_38_40a5 ; $5509
	ld c, $14 ; $550c
	ld b, $0f ; $550e
	call Func_00_1f51 ; $5510
Label_38_5513:
	ld a, [$d811] ; $5513
	cp a, $01 ; $5516
	jr z, Label_38_553f ; $5518
	or a, a ; $551a
	jr nz, Label_38_5524 ; $551b
	ld a, [$d823] ; $551d
	cp a, $07 ; $5520
	jr c, Label_38_553f ; $5522
Label_38_5524:
	ld a, [$d811] ; $5524
	ld b, a ; $5527
	ld a, [$d812] ; $5528
	dec a ; $552b
	dec a ; $552c
	cp a, b ; $552d
	jr z, Label_38_553f ; $552e
	ld de, $2a63 ; $5530
	ld c, $00 ; $5533
	call Func_38_40a5 ; $5535
	ld c, $16 ; $5538
	ld b, $0f ; $553a
	call Func_00_1f51 ; $553c
Label_38_553f:
	pop af ; $553f
	ldh [$ff96], a ; $5540
	ldh [rWBK], a ; $5542
	ret ; $5544
Func_38_5545:
	ldh a, [$ff96] ; $5545
	push af ; $5547
	ld a, $03 ; $5548
	ldh [$ff96], a ; $554a
	ldh [rWBK], a ; $554c
	ld hl, $d800 ; $554e
	ld c, $00 ; $5551
Label_38_5553:
	push hl ; $5553
	ld a, c ; $5554
	add a, a ; $5555
	ld hl, $557d ; $5556
	add a, l ; $5559
	ld l, a ; $555a
	jr nc, Label_38_555e ; $555b
	inc h ; $555d
Label_38_555e:
	ld a, [hl+] ; $555e
	ld d, [hl] ; $555f
	ld e, a ; $5560
	pop hl ; $5561
	push bc ; $5562
	ld b, [hl] ; $5563
	inc hl ; $5564
	ld c, [hl] ; $5565
	inc hl ; $5566
	ld a, b ; $5567
	cp a, $ff ; $5568
	jr z, Label_38_556f ; $556a
	call Func_38_5589 ; $556c
Label_38_556f:
	pop bc ; $556f
	ld a, c ; $5570
	inc a ; $5571
	ld c, a ; $5572
	cp a, $06 ; $5573
	jr nz, Label_38_5553 ; $5575
	pop af ; $5577
	ldh [$ff96], a ; $5578
	ldh [rWBK], a ; $557a
	ret ; $557c
	INCBIN "data/bank_038/d_557d.bin" ; $557d, 12 bytes
Func_38_5589:
	push af ; $5589
	push bc ; $558a
	push de ; $558b
	push hl ; $558c
	ld h, b ; $558d
	ld a, $02 ; $558e
	add a, c ; $5590
	ld b, a ; $5591
	ld a, h ; $5592
	add a, a ; $5593
	add a, a ; $5594
	ld c, a ; $5595
	push de ; $5596
	call Func_00_1f51 ; $5597
	pop de ; $559a
	ld a, $08 ; $559b
	add a, d ; $559d
	ld d, a ; $559e
	ld a, $02 ; $559f
	add a, c ; $55a1
	ld c, a ; $55a2
	call Func_00_1f51 ; $55a3
	pop hl ; $55a6
	pop de ; $55a7
	pop bc ; $55a8
	pop af ; $55a9
	ret ; $55aa
Func_38_55ab:
	call Func_38_56ad ; $55ab
	ld d, b ; $55ae
	ld e, c ; $55af
	ld b, $02 ; $55b0
	ld c, $02 ; $55b2
	ld h, $00 ; $55b4
	push de ; $55b6
	rst Rst18 ; $55b7
	inc c ; $55b8
	add hl, sp ; $55b9
	pop de ; $55ba
	ld b, $02 ; $55bb
	ld c, $02 ; $55bd
	ld hl, $0400 ; $55bf
	add hl, de ; $55c2
	ld d, h ; $55c3
	ld e, l ; $55c4
	ld h, $08 ; $55c5
	rst Rst18 ; $55c7
	inc c ; $55c8
	add hl, sp ; $55c9
	call Func_38_56ad ; $55ca
	ld hl, $001e ; $55cd
	add hl, bc ; $55d0
	xor a, a ; $55d1
	ld [hl+], a ; $55d2
	ld [hl], a ; $55d3
	ld a, [$d814] ; $55d4
	cp a, $02 ; $55d7
	jr nc, Label_38_55f3 ; $55d9
	ld hl, $d0c0 ; $55db
	ld de, $98c0 ; $55de
	ld c, $04 ; $55e1
	call Func_00_0480 ; $55e3
	ld hl, $d4c0 ; $55e6
	ld de, $b8c0 ; $55e9
	ld c, $04 ; $55ec
	call Func_00_0480 ; $55ee
	jr Label_38_5609 ; $55f1
Label_38_55f3:
	ld hl, $d120 ; $55f3
	ld de, $9920 ; $55f6
	ld c, $04 ; $55f9
	call Func_00_0480 ; $55fb
	ld hl, $d520 ; $55fe
	ld de, $b920 ; $5601
	ld c, $04 ; $5604
	call Func_00_0480 ; $5606
Label_38_5609:
	ret ; $5609
	INCBIN "data/bank_038/d_560a.bin" ; $560a, 8 bytes
Func_38_5612:
	ld hl, $da00 ; $5612
	ld a, b ; $5615
	add a, a ; $5616
	add a, a ; $5617
	add a, l ; $5618
	ld l, a ; $5619
	jr nc, Label_38_561d ; $561a
	inc h ; $561c
Label_38_561d:
	ld b, h ; $561d
	ld c, l ; $561e
	ld hl, $0000 ; $561f
	add hl, bc ; $5622
	ld d, [hl] ; $5623
	ld hl, $0001 ; $5624
	add hl, bc ; $5627
	ld e, [hl] ; $5628
	call Func_38_56ad ; $5629
	ld h, b ; $562c
	ld l, c ; $562d
	ld b, d ; $562e
	ld c, e ; $562f
	ld d, h ; $5630
	ld e, l ; $5631
	dec c ; $5632
	call Func_38_5712 ; $5633
	call Func_38_567a ; $5636
	call Func_38_5693 ; $5639
	ld a, [$d814] ; $563c
	cp a, $02 ; $563f
	jr nc, Label_38_565b ; $5641
	ld hl, $d0c0 ; $5643
	ld de, $98c0 ; $5646
	ld c, $04 ; $5649
	call Func_00_0480 ; $564b
	ld hl, $d4c0 ; $564e
	ld de, $b8c0 ; $5651
	ld c, $04 ; $5654
	call Func_00_0480 ; $5656
	jr Label_38_5671 ; $5659
Label_38_565b:
	ld hl, $d120 ; $565b
	ld de, $9920 ; $565e
	ld c, $04 ; $5661
	call Func_00_0480 ; $5663
	ld hl, $d520 ; $5666
	ld de, $b920 ; $5669
	ld c, $04 ; $566c
	call Func_00_0480 ; $566e
Label_38_5671:
	ret ; $5671
	INCBIN "data/bank_038/d_5672.bin" ; $5672, 8 bytes
Func_38_567a:
	ld a, [$d814] ; $567a
	ld hl, $d834 ; $567d
	add a, l ; $5680
	ld l, a ; $5681
	jr nc, Label_38_5685 ; $5682
	inc h ; $5684
Label_38_5685:
	ld a, [hl] ; $5685
	or a, a ; $5686
	ret z ; $5687
	call Func_38_56ad ; $5688
	ld hl, $001f ; $568b
	add hl, bc ; $568e
	ld a, $32 ; $568f
	ld [hl], a ; $5691
	ret ; $5692
Func_38_5693:
	ld hl, $d830 ; $5693
	ld a, [$d814] ; $5696
	add a, l ; $5699
	ld l, a ; $569a
	jr nc, Label_38_569e ; $569b
	inc h ; $569d
Label_38_569e:
	ld a, [hl] ; $569e
	ld c, $33 ; $569f
	add a, c ; $56a1
	push af ; $56a2
	call Func_38_56ad ; $56a3
	ld hl, $001e ; $56a6
	add hl, bc ; $56a9
	pop af ; $56aa
	ld [hl], a ; $56ab
	ret ; $56ac
Func_38_56ad:
	ld a, [$d813] ; $56ad
	add a, a ; $56b0
	ld hl, $56c9 ; $56b1
	add a, l ; $56b4
	ld l, a ; $56b5
	jr nc, Label_38_56b9 ; $56b6
	inc h ; $56b8
Label_38_56b9:
	ld a, [hl+] ; $56b9
	ld h, [hl] ; $56ba
	ld l, a ; $56bb
	ld a, [$d814] ; $56bc
	add a, a ; $56bf
	add a, l ; $56c0
	ld l, a ; $56c1
	jr nc, Label_38_56c5 ; $56c2
	inc h ; $56c4
Label_38_56c5:
	ld a, [hl+] ; $56c5
	ld b, [hl] ; $56c6
	ld c, a ; $56c7
	ret ; $56c8
	INCBIN "data/bank_038/d_56c9.bin" ; $56c9, 73 bytes
Func_38_5712:
	ld a, b ; $5712
	add a, a ; $5713
	add a, a ; $5714
	ld b, a ; $5715
	ld a, $80 ; $5716
	add a, b ; $5718
	ld b, a ; $5719
	ld a, c ; $571a
	add a, $03 ; $571b
	or a, $08 ; $571d
	ld c, a ; $571f
	push de ; $5720
	ld a, b ; $5721
	ld [de], a ; $5722
	inc b ; $5723
	inc b ; $5724
	inc de ; $5725
	ld a, b ; $5726
	ld [de], a ; $5727
	ld hl, $001f ; $5728
	add hl, de ; $572b
	ld d, h ; $572c
	ld e, l ; $572d
	dec b ; $572e
	ld a, b ; $572f
	ld [de], a ; $5730
	inc b ; $5731
	inc b ; $5732
	inc de ; $5733
	ld a, b ; $5734
	ld [de], a ; $5735
	pop de ; $5736
	ld hl, $0400 ; $5737
	add hl, de ; $573a
	ld d, h ; $573b
	ld e, l ; $573c
	ld h, c ; $573d
	ld b, $02 ; $573e
	ld c, $02 ; $5740
	rst Rst18 ; $5742
	inc c ; $5743
	add hl, sp ; $5744
	ret ; $5745
Func_38_5746:
	xor a, a ; $5746
Label_38_5747:
	push af ; $5747
	push bc ; $5748
	push de ; $5749
	push hl ; $574a
	rst Rst18 ; $574b
	ld b, h ; $574c
	INCBIN "data/bank_038/d_574d.bin" ; $574d, 1 bytes
	pop hl ; $574e
	pop de ; $574f
	pop bc ; $5750
	pop af ; $5751
	ld hl, $0040 ; $5752
	add hl, de ; $5755
	ld d, h ; $5756
	ld e, l ; $5757
	inc a ; $5758
	cp a, $20 ; $5759
	jr nz, Label_38_5747 ; $575b
	ret ; $575d
Func_38_575e:
	push af ; $575e
	push bc ; $575f
	push de ; $5760
	push hl ; $5761
	ldh a, [$ff96] ; $5762
	push af ; $5764
	ld a, $03 ; $5765
	ldh [$ff96], a ; $5767
	ldh [rWBK], a ; $5769
	ld de, $d181 ; $576b
	ld b, $12 ; $576e
	ld c, $01 ; $5770
	ld h, $03 ; $5772
	rst Rst18 ; $5774
	inc c ; $5775
	add hl, sp ; $5776
	ld de, $d1a1 ; $5777
	ld b, $12 ; $577a
	ld c, $04 ; $577c
	ld h, $20 ; $577e
	rst Rst18 ; $5780
	inc c ; $5781
	add hl, sp ; $5782
	ld a, [$d814] ; $5783
	cp a, $04 ; $5786
	jr nz, Label_38_578c ; $5788
	jr Label_38_57b7 ; $578a
Label_38_578c:
	call Func_38_5cb7 ; $578c
	ld d, a ; $578f
	ld c, a ; $5790
	add a, a ; $5791
	add a, a ; $5792
	ld hl, $da00 ; $5793
	add a, l ; $5796
	ld l, a ; $5797
	jr nc, Label_38_579b ; $5798
	inc h ; $579a
Label_38_579b:
	ld a, [hl] ; $579b
	cp a, $04 ; $579c
	jr nc, Label_38_57aa ; $579e
	inc hl ; $57a0
	inc hl ; $57a1
	inc hl ; $57a2
	ld a, [hl] ; $57a3
	ld c, a ; $57a4
	call Func_38_57dd ; $57a5
	jr Label_38_57b7 ; $57a8
Label_38_57aa:
	cp a, $ff ; $57aa
	jr z, Label_38_57b7 ; $57ac
	ld c, a ; $57ae
	push bc ; $57af
	call Func_38_58cd ; $57b0
	pop bc ; $57b3
	call Func_38_591b ; $57b4
Label_38_57b7:
	ld hl, $d180 ; $57b7
	ld de, $9980 ; $57ba
	ld c, $0a ; $57bd
	call Func_00_0480 ; $57bf
	ld hl, $d600 ; $57c2
	ld de, $ba00 ; $57c5
	ld c, $02 ; $57c8
	call Func_00_0480 ; $57ca
	pop af ; $57cd
	ldh [$ff96], a ; $57ce
	ldh [rWBK], a ; $57d0
	pop hl ; $57d2
	pop de ; $57d3
	pop bc ; $57d4
	pop af ; $57d5
	ret ; $57d6
	INCBIN "data/bank_038/d_57d7.bin" ; $57d7, 6 bytes
Func_38_57dd:
	push af ; $57dd
	push bc ; $57de
	push de ; $57df
	push hl ; $57e0
	ldh a, [$ff96] ; $57e1
	push af ; $57e3
	ld a, $03 ; $57e4
	ldh [$ff96], a ; $57e6
	ldh [rWBK], a ; $57e8
	ld a, c ; $57ea
	ld de, $0020 ; $57eb
	ld hl, $d900 ; $57ee
Label_38_57f1:
	or a, a ; $57f1
	jr z, Label_38_57f8 ; $57f2
	add hl, de ; $57f4
	dec a ; $57f5
	jr Label_38_57f1 ; $57f6
Label_38_57f8:
	ld b, h ; $57f8
	ld c, l ; $57f9
	ld a, [hl] ; $57fa
	cp a, $ff ; $57fb
	jp z, Label_38_58b7 ; $57fd
	push af ; $5800
	push bc ; $5801
	push de ; $5802
	push hl ; $5803
	ld hl, $0007 ; $5804
	add hl, bc ; $5807
	ld de, $d1a3 ; $5808
	call Func_38_440c ; $580b
	pop hl ; $580e
	pop de ; $580f
	pop bc ; $5810
	pop af ; $5811
	ld a, $4c ; $5812
	ld [$d1ab], a ; $5814
	ld a, $56 ; $5817
	ld [$d1ac], a ; $5819
	ld hl, $0002 ; $581c
	add hl, bc ; $581f
	ld l, [hl] ; $5820
	ld h, $00 ; $5821
	ld de, $d1ae ; $5823
	ld a, $02 ; $5826
	call Func_38_4445 ; $5828
	ld a, $1d ; $582b
	ld [$d1e2], a ; $582d
	ld a, $1e ; $5830
	ld [$d1e3], a ; $5832
	ld a, $1f ; $5835
	ld [$d1e4], a ; $5837
	ld hl, $0003 ; $583a
	add hl, bc ; $583d
	ld l, [hl] ; $583e
	ld h, $00 ; $583f
	ld de, $d1e7 ; $5841
	ld a, $02 ; $5844
	call Func_38_4445 ; $5846
	ld hl, $0004 ; $5849
	add hl, bc ; $584c
	ld l, [hl] ; $584d
	ld h, $00 ; $584e
	ld de, $d1ef ; $5850
	ld a, $02 ; $5853
	call Func_38_4445 ; $5855
	ld a, $14 ; $5858
	ld [$d1ea], a ; $585a
	ld a, $15 ; $585d
	ld [$d1eb], a ; $585f
	ld a, $16 ; $5862
	ld [$d1ec], a ; $5864
	ld a, $17 ; $5867
	ld [$d1ed], a ; $5869
	ld a, $18 ; $586c
	ld [$d202], a ; $586e
	ld a, $19 ; $5871
	ld [$d203], a ; $5873
	ld a, $1a ; $5876
	ld [$d204], a ; $5878
	ld a, $1b ; $587b
	ld [$d205], a ; $587d
	ld a, $1c ; $5880
	ld [$d206], a ; $5882
	ld hl, $0005 ; $5885
	add hl, bc ; $5888
	ld l, [hl] ; $5889
	ld h, $00 ; $588a
	ld de, $d207 ; $588c
	ld a, $02 ; $588f
	call Func_38_4445 ; $5891
	ld a, $10 ; $5894
	ld [$d20a], a ; $5896
	ld a, $11 ; $5899
	ld [$d20b], a ; $589b
	ld a, $12 ; $589e
	ld [$d20c], a ; $58a0
	ld a, $13 ; $58a3
	ld [$d20d], a ; $58a5
	ld hl, $0006 ; $58a8
	add hl, bc ; $58ab
	ld l, [hl] ; $58ac
	ld h, $00 ; $58ad
	ld de, $d20f ; $58af
	ld a, $02 ; $58b2
	call Func_38_4445 ; $58b4
Label_38_58b7:
	ld de, $d601 ; $58b7
	ld h, $00 ; $58ba
	ld b, $12 ; $58bc
	ld c, $01 ; $58be
	rst Rst18 ; $58c0
	inc c ; $58c1
	add hl, sp ; $58c2
	pop af ; $58c3
	ldh [$ff96], a ; $58c4
	ldh [rWBK], a ; $58c6
	pop hl ; $58c8
	pop de ; $58c9
	pop bc ; $58ca
	pop af ; $58cb
	ret ; $58cc
Func_38_58cd:
	push bc ; $58cd
	ld a, c ; $58ce
	ld hl, $001b ; $58cf
	add a, l ; $58d2
	ld l, a ; $58d3
	jr nc, Label_38_58d7 ; $58d4
	inc h ; $58d6
Label_38_58d7:
	ld de, $d1a6 ; $58d7
	ld c, $20 ; $58da
	rst Rst18 ; $58dc
	ld [hl], d ; $58dd
	dec b ; $58de
	pop bc ; $58df
	ld a, c ; $58e0
	ld hl, $58fb ; $58e1
	add a, l ; $58e4
	ld l, a ; $58e5
	jr nc, Label_38_58e9 ; $58e6
	inc h ; $58e8
Label_38_58e9:
	ld a, [hl] ; $58e9
	ld hl, $0099 ; $58ea
	add a, l ; $58ed
	ld l, a ; $58ee
	jr nc, Label_38_58f2 ; $58ef
	inc h ; $58f1
Label_38_58f2:
	ld de, $d1e3 ; $58f2
	ld c, $20 ; $58f5
	rst Rst18 ; $58f7
	ld [hl], d ; $58f8
	dec b ; $58f9
	ret ; $58fa
	INCBIN "data/bank_038/d_58fb.bin" ; $58fb, 32 bytes
Func_38_591b:
	ld a, [$d811] ; $591b
	cp a, $02 ; $591e
	jr nc, Label_38_597e ; $5920
	ld a, [$df00] ; $5922
	or a, a ; $5925
	jr nz, Label_38_5944 ; $5926
	ld hl, $d340 ; $5928
	ld de, $d204 ; $592b
	ld b, $05 ; $592e
	ld c, $01 ; $5930
	rst Rst18 ; $5932
	ld a, [bc] ; $5933
	add hl, sp ; $5934
	ld hl, $d34a ; $5935
	ld de, $d209 ; $5938
	ld b, $05 ; $593b
	ld c, $01 ; $593d
	rst Rst18 ; $593f
	ld a, [bc] ; $5940
	add hl, sp ; $5941
	jr Label_38_597e ; $5942
Label_38_5944:
	cp a, $01 ; $5944
	jr nz, Label_38_5964 ; $5946
	ld hl, $d340 ; $5948
	ld de, $d204 ; $594b
	ld b, $05 ; $594e
	ld c, $01 ; $5950
	rst Rst18 ; $5952
	ld a, [bc] ; $5953
	add hl, sp ; $5954
	ld hl, $d345 ; $5955
	ld de, $d209 ; $5958
	ld b, $05 ; $595b
	ld c, $01 ; $595d
	rst Rst18 ; $595f
	ld a, [bc] ; $5960
	add hl, sp ; $5961
	jr Label_38_597e ; $5962
Label_38_5964:
	ld hl, $d340 ; $5964
	ld de, $d204 ; $5967
	ld b, $05 ; $596a
	ld c, $01 ; $596c
	rst Rst18 ; $596e
	ld a, [bc] ; $596f
	add hl, sp ; $5970
	ld hl, $d34f ; $5971
	ld de, $d209 ; $5974
	ld b, $08 ; $5977
	ld c, $01 ; $5979
	rst Rst18 ; $597b
	ld a, [bc] ; $597c
	add hl, sp ; $597d
Label_38_597e:
	ld de, $d601 ; $597e
	ld h, $08 ; $5981
	ld b, $12 ; $5983
	ld c, $01 ; $5985
	rst Rst18 ; $5987
	inc c ; $5988
	add hl, sp ; $5989
	ret ; $598a
Func_38_598b:
	ldh a, [$ff96] ; $598b
	push af ; $598d
	ld a, $03 ; $598e
	ldh [$ff96], a ; $5990
	ldh [rWBK], a ; $5992
	ld a, [$d813] ; $5994
	add a, a ; $5997
	ld hl, $59ba ; $5998
	add a, l ; $599b
	ld l, a ; $599c
	jr nc, Label_38_59a0 ; $599d
	inc h ; $599f
Label_38_59a0:
	ld a, [hl+] ; $59a0
	ld h, [hl] ; $59a1
	ld l, a ; $59a2
Label_38_59a3:
	ld a, [hl] ; $59a3
	or a, a ; $59a4
	jr z, Label_38_59b4 ; $59a5
	ld c, a ; $59a7
	inc hl ; $59a8
	ld b, [hl] ; $59a9
	inc hl ; $59aa
	ld a, [hl+] ; $59ab
	ld d, [hl] ; $59ac
	ld e, a ; $59ad
	inc hl ; $59ae
	call Func_38_59fa ; $59af
	jr Label_38_59a3 ; $59b2
Label_38_59b4:
	pop af ; $59b4
	ldh [$ff96], a ; $59b5
	ldh [rWBK], a ; $59b7
	ret ; $59b9
	INCBIN "data/bank_038/d_59ba.bin" ; $59ba, 64 bytes
Func_38_59fa:
	push af ; $59fa
	push bc ; $59fb
	push de ; $59fc
	push hl ; $59fd
	ldh a, [$ff96] ; $59fe
	push af ; $5a00
	ld a, $03 ; $5a01
	ldh [$ff96], a ; $5a03
	ldh [rWBK], a ; $5a05
	dec c ; $5a07
	ld a, $50 ; $5a08
	add a, c ; $5a0a
	ld [de], a ; $5a0b
	inc de ; $5a0c
	ld a, $54 ; $5a0d
	add a, b ; $5a0f
	ld [de], a ; $5a10
	pop af ; $5a11
	ldh [$ff96], a ; $5a12
	ldh [rWBK], a ; $5a14
	pop hl ; $5a16
	pop de ; $5a17
	pop bc ; $5a18
	pop af ; $5a19
	ret ; $5a1a
Func_38_5a1b:
	ldh a, [$ff96] ; $5a1b
	push af ; $5a1d
	ld a, $03 ; $5a1e
	ldh [$ff96], a ; $5a20
	ldh [rWBK], a ; $5a22
	ld a, $00 ; $5a24
	ld [$d811], a ; $5a26
	xor a, a ; $5a29
	ld [$d815], a ; $5a2a
	ld [$d81d], a ; $5a2d
	ld [$d824], a ; $5a30
	ld [$d825], a ; $5a33
	ld [$d826], a ; $5a36
	ld a, $ff ; $5a39
	ld [$d816], a ; $5a3b
	ld [$d817], a ; $5a3e
	ld [$d818], a ; $5a41
	ld [$d819], a ; $5a44
	ld [$d81f], a ; $5a47
	ld [$d820], a ; $5a4a
	ld a, [$d813] ; $5a4d
	cp a, $03 ; $5a50
	jr z, Label_38_5a5c ; $5a52
	cp a, $05 ; $5a54
	jr z, Label_38_5a5c ; $5a56
	ld a, $00 ; $5a58
	jr Label_38_5a5e ; $5a5a
Label_38_5a5c:
	ld a, $02 ; $5a5c
Label_38_5a5e:
	ld [$d814], a ; $5a5e
	ld hl, $d840 ; $5a61
	call Func_38_5b43 ; $5a64
	call Func_38_5bb7 ; $5a67
	call Func_38_5bd9 ; $5a6a
	call Func_38_60ec ; $5a6d
	call Func_38_6146 ; $5a70
	call Func_38_6192 ; $5a73
	call Func_38_61cb ; $5a76
	call Func_38_5ce5 ; $5a79
	pop af ; $5a7c
	ldh [$ff96], a ; $5a7d
	ldh [rWBK], a ; $5a7f
	ret ; $5a81
Func_38_5a82:
	ldh a, [$ff96] ; $5a82
	push af ; $5a84
	ld a, $03 ; $5a85
	ldh [$ff96], a ; $5a87
	ldh [rWBK], a ; $5a89
	ld hl, $d840 ; $5a8b
	ld bc, $0028 ; $5a8e
	call ClearBytes ; $5a91
	ld b, $00 ; $5a94
Label_38_5a96:
	ld a, b ; $5a96
	add a, a ; $5a97
	ld hl, $5b17 ; $5a98
	add a, l ; $5a9b
	ld l, a ; $5a9c
	jr nc, Label_38_5aa0 ; $5a9d
	inc h ; $5a9f
Label_38_5aa0:
	ld a, [hl+] ; $5aa0
	ld d, [hl] ; $5aa1
	ld e, a ; $5aa2
	ld a, d ; $5aa3
	and a, e ; $5aa4
	cp a, $ff ; $5aa5
	jr z, Label_38_5ab0 ; $5aa7
	rst Rst18 ; $5aa9
	inc e ; $5aaa
	inc bc ; $5aab
	jr nz, Label_38_5ab0 ; $5aac
	jr Label_38_5abc ; $5aae
Label_38_5ab0:
	ld hl, $d840 ; $5ab0
	ld a, b ; $5ab3
	add a, l ; $5ab4
	ld l, a ; $5ab5
	jr nc, Label_38_5ab9 ; $5ab6
	inc h ; $5ab8
Label_38_5ab9:
	ld a, $01 ; $5ab9
	ld [hl], a ; $5abb
Label_38_5abc:
	ld a, b ; $5abc
	inc a ; $5abd
	ld b, a ; $5abe
	cp a, $09 ; $5abf
	jr nz, Label_38_5a96 ; $5ac1
	ld hl, $d84f ; $5ac3
	ld a, $01 ; $5ac6
	ld [hl+], a ; $5ac8
	ld [hl+], a ; $5ac9
	ld [hl+], a ; $5aca
	ld a, [$c36c] ; $5acb
	push af ; $5ace
	ld c, $00 ; $5acf
Label_38_5ad1:
	ld a, c ; $5ad1
	ld [$c36c], a ; $5ad2
	rst Rst18 ; $5ad5
	ld a, [de] ; $5ad6
	inc bc ; $5ad7
	push bc ; $5ad8
	ld hl, $d852 ; $5ad9
	ld b, $00 ; $5adc
Label_38_5ade:
	ld a, b ; $5ade
	add a, a ; $5adf
	ld hl, $5b29 ; $5ae0
	add a, l ; $5ae3
	ld l, a ; $5ae4
	jr nc, Label_38_5ae8 ; $5ae5
	inc h ; $5ae7
Label_38_5ae8:
	ld a, [hl+] ; $5ae8
	ld d, [hl] ; $5ae9
	ld e, a ; $5aea
	call Func_00_249f ; $5aeb
	jr nz, Label_38_5af2 ; $5aee
	jr Label_38_5afe ; $5af0
Label_38_5af2:
	ld hl, $d852 ; $5af2
	ld a, b ; $5af5
	add a, l ; $5af6
	ld l, a ; $5af7
	jr nc, Label_38_5afb ; $5af8
	inc h ; $5afa
Label_38_5afb:
	ld a, $01 ; $5afb
	ld [hl], a ; $5afd
Label_38_5afe:
	ld a, b ; $5afe
	inc a ; $5aff
	ld b, a ; $5b00
	cp a, $0d ; $5b01
	jr nz, Label_38_5ade ; $5b03
	pop bc ; $5b05
	ld a, c ; $5b06
	inc a ; $5b07
	ld c, a ; $5b08
	cp a, $03 ; $5b09
	jr nz, Label_38_5ad1 ; $5b0b
	pop af ; $5b0d
	ld [$c36c], a ; $5b0e
	pop af ; $5b11
	ldh [$ff96], a ; $5b12
	ldh [rWBK], a ; $5b14
	ret ; $5b16
	INCBIN "data/bank_038/d_5b17.bin" ; $5b17, 44 bytes
Func_38_5b43:
	ld a, $01 ; $5b43
	ld [$d81c], a ; $5b45
	ld de, $da00 ; $5b48
	ld c, $00 ; $5b4b
Label_38_5b4d:
	ld a, [hl+] ; $5b4d
	or a, a ; $5b4e
	jr z, Label_38_5b60 ; $5b4f
	push hl ; $5b51
	ld hl, $5b93 ; $5b52
	ld a, c ; $5b55
	add a, l ; $5b56
	ld l, a ; $5b57
	jr nc, Label_38_5b5b ; $5b58
	inc h ; $5b5a
Label_38_5b5b:
	ld a, [hl] ; $5b5b
	ld [de], a ; $5b5c
	pop hl ; $5b5d
	jr Label_38_5b63 ; $5b5e
Label_38_5b60:
	ld a, $ff ; $5b60
	ld [de], a ; $5b62
Label_38_5b63:
	inc de ; $5b63
	inc de ; $5b64
	inc de ; $5b65
	inc de ; $5b66
	ld a, c ; $5b67
	inc a ; $5b68
	ld c, a ; $5b69
	cp a, $20 ; $5b6a
	jr nz, Label_38_5b4d ; $5b6c
	ret ; $5b6e
	INCBIN "data/bank_038/d_5b6f.bin" ; $5b6f, 72 bytes
Func_38_5bb7:
	ld hl, $da00 ; $5bb7
	ld c, $00 ; $5bba
	ld b, $00 ; $5bbc
Label_38_5bbe:
	ld a, [hl] ; $5bbe
	push bc ; $5bbf
	push hl ; $5bc0
	rst Rst18 ; $5bc1
	inc [hl] ; $5bc2
	ld [bc], a ; $5bc3
	pop hl ; $5bc4
	pop bc ; $5bc5
	inc hl ; $5bc6
	inc a ; $5bc7
	ld [hl], a ; $5bc8
	dec hl ; $5bc9
	ld a, $04 ; $5bca
	add a, l ; $5bcc
	ld l, a ; $5bcd
	jr nc, Label_38_5bd1 ; $5bce
	inc h ; $5bd0
Label_38_5bd1:
	ld a, c ; $5bd1
	inc a ; $5bd2
	ld c, a ; $5bd3
	cp a, $20 ; $5bd4
	jr nz, Label_38_5bbe ; $5bd6
	ret ; $5bd8
Func_38_5bd9:
	ldh a, [$ff96] ; $5bd9
	push af ; $5bdb
	ld a, $03 ; $5bdc
	ldh [$ff96], a ; $5bde
	ldh [rWBK], a ; $5be0
	ld c, $00 ; $5be2
	ld b, $00 ; $5be4
	ld hl, $d900 ; $5be6
Label_38_5be9:
	ld a, [hl] ; $5be9
	cp a, $ff ; $5bea
	jr z, Label_38_5c36 ; $5bec
	push hl ; $5bee
	ld hl, $da24 ; $5bef
	ld a, b ; $5bf2
	add a, a ; $5bf3
	add a, a ; $5bf4
	add a, l ; $5bf5
	ld l, a ; $5bf6
	jr nc, Label_38_5bfa ; $5bf7
	inc h ; $5bf9
Label_38_5bfa:
	ld d, h ; $5bfa
	ld e, l ; $5bfb
	pop hl ; $5bfc
	ld a, [hl+] ; $5bfd
	ld [de], a ; $5bfe
	inc de ; $5bff
	ld a, [hl] ; $5c00
	inc a ; $5c01
	ld [de], a ; $5c02
	inc de ; $5c03
	xor a, a ; $5c04
	ld [de], a ; $5c05
	inc de ; $5c06
	ld a, c ; $5c07
	add a, a ; $5c08
	ld [de], a ; $5c09
	dec hl ; $5c0a
	ld de, $0020 ; $5c0b
	add hl, de ; $5c0e
	push hl ; $5c0f
	ld hl, $da24 ; $5c10
	ld a, b ; $5c13
	add a, $03 ; $5c14
	add a, a ; $5c16
	add a, a ; $5c17
	add a, l ; $5c18
	ld l, a ; $5c19
	jr nc, Label_38_5c1d ; $5c1a
	inc h ; $5c1c
Label_38_5c1d:
	ld d, h ; $5c1d
	ld e, l ; $5c1e
	pop hl ; $5c1f
	ld a, [hl+] ; $5c20
	ld [de], a ; $5c21
	inc de ; $5c22
	ld a, [hl] ; $5c23
	inc a ; $5c24
	ld [de], a ; $5c25
	inc de ; $5c26
	xor a, a ; $5c27
	ld [de], a ; $5c28
	ld a, c ; $5c29
	add a, a ; $5c2a
	inc a ; $5c2b
	inc de ; $5c2c
	ld [de], a ; $5c2d
	dec hl ; $5c2e
	ld de, $0020 ; $5c2f
	add hl, de ; $5c32
	inc b ; $5c33
	jr Label_38_5c3a ; $5c34
Label_38_5c36:
	ld de, $0040 ; $5c36
	add hl, de ; $5c39
Label_38_5c3a:
	ld a, c ; $5c3a
	inc a ; $5c3b
	ld c, a ; $5c3c
	cp a, $03 ; $5c3d
	jr nz, Label_38_5be9 ; $5c3f
	pop af ; $5c41
	ldh [$ff96], a ; $5c42
	ldh [rWBK], a ; $5c44
	ret ; $5c46
Func_38_5c47:
	ld a, [$d813] ; $5c47
	ld hl, $5c8f ; $5c4a
	add a, a ; $5c4d
	add a, l ; $5c4e
	ld l, a ; $5c4f
	jr nc, Label_38_5c53 ; $5c50
	inc h ; $5c52
Label_38_5c53:
	ld a, [hl+] ; $5c53
	ld h, [hl] ; $5c54
	ld l, a ; $5c55
	ld a, [$d814] ; $5c56
	ld b, a ; $5c59
Label_38_5c5a:
	ld a, [hl+] ; $5c5a
	cp a, b ; $5c5b
	jr nz, Label_38_5c5a ; $5c5c
	ld a, [hl] ; $5c5e
	ld [$d814], a ; $5c5f
	ret ; $5c62
Func_38_5c63:
	ld a, [$d813] ; $5c63
	ld hl, $5c8f ; $5c66
	add a, a ; $5c69
	add a, l ; $5c6a
	ld l, a ; $5c6b
	jr nc, Label_38_5c6f ; $5c6c
	inc h ; $5c6e
Label_38_5c6f:
	ld a, [hl+] ; $5c6f
	ld h, [hl] ; $5c70
	ld l, a ; $5c71
	ld a, [$d814] ; $5c72
	ld b, a ; $5c75
Label_38_5c76:
	ld a, [hl+] ; $5c76
	cp a, b ; $5c77
	jr nz, Label_38_5c76 ; $5c78
	dec hl ; $5c7a
	dec hl ; $5c7b
	ld a, [hl] ; $5c7c
	ld [$d814], a ; $5c7d
	cp a, $ff ; $5c80
	jr z, Label_38_5c8e ; $5c82
	ld c, a ; $5c84
	ld a, b ; $5c85
	cp a, $04 ; $5c86
	jr z, Label_38_5c8c ; $5c88
	ld a, c ; $5c8a
	ret ; $5c8b
Label_38_5c8c:
	ld a, $fe ; $5c8c
Label_38_5c8e:
	ret ; $5c8e
	INCBIN "data/bank_038/d_5c8f.bin" ; $5c8f, 40 bytes
Func_38_5cb7:
	ldh a, [$ff96] ; $5cb7
	push af ; $5cb9
	ld a, $03 ; $5cba
	ldh [$ff96], a ; $5cbc
	ldh [rWBK], a ; $5cbe
	ld a, [$cb04] ; $5cc0
	ld d, a ; $5cc3
	ld a, [$cb05] ; $5cc4
	ld e, a ; $5cc7
	ld a, e ; $5cc8
	add a, a ; $5cc9
	add a, e ; $5cca
	ld e, a ; $5ccb
	ld a, d ; $5ccc
	add a, e ; $5ccd
	ld b, a ; $5cce
	ld a, [$d811] ; $5ccf
	ld c, a ; $5cd2
Label_38_5cd3:
	ld a, c ; $5cd3
	or a, a ; $5cd4
	jr z, Label_38_5cde ; $5cd5
	ld a, $03 ; $5cd7
	add a, b ; $5cd9
	ld b, a ; $5cda
	dec c ; $5cdb
	jr Label_38_5cd3 ; $5cdc
Label_38_5cde:
	pop af ; $5cde
	ldh [$ff96], a ; $5cdf
	ldh [rWBK], a ; $5ce1
	ld a, b ; $5ce3
	ret ; $5ce4
Func_38_5ce5:
	push af ; $5ce5
	push bc ; $5ce6
	push de ; $5ce7
	push hl ; $5ce8
	ldh a, [$ff96] ; $5ce9
	push af ; $5ceb
	ld a, $03 ; $5cec
	ldh [$ff96], a ; $5cee
	ldh [rWBK], a ; $5cf0
	ld hl, $da00 ; $5cf2
	ld a, [$d811] ; $5cf5
	ld bc, $000c ; $5cf8
Label_38_5cfb:
	or a, a ; $5cfb
	jr z, Label_38_5d02 ; $5cfc
	add hl, bc ; $5cfe
	dec a ; $5cff
	jr Label_38_5cfb ; $5d00
Label_38_5d02:
	ld c, $00 ; $5d02
	ld de, $d800 ; $5d04
Label_38_5d07:
	ld a, [hl+] ; $5d07
	ld [de], a ; $5d08
	inc de ; $5d09
	ld a, [hl+] ; $5d0a
	ld [de], a ; $5d0b
	ld a, [hl+] ; $5d0c
	or a, a ; $5d0d
	jr z, Label_38_5d12 ; $5d0e
	xor a, a ; $5d10
	ld [de], a ; $5d11
Label_38_5d12:
	inc de ; $5d12
	inc hl ; $5d13
	ld a, c ; $5d14
	inc a ; $5d15
	ld c, a ; $5d16
	cp a, $06 ; $5d17
	jr nz, Label_38_5d07 ; $5d19
	pop af ; $5d1b
	ldh [$ff96], a ; $5d1c
	ldh [rWBK], a ; $5d1e
	pop hl ; $5d20
	pop de ; $5d21
	pop bc ; $5d22
	pop af ; $5d23
	ret ; $5d24
	INCBIN "data/bank_038/d_5d25.bin" ; $5d25, 29 bytes
Func_38_5d42:
	push bc ; $5d42
	push de ; $5d43
	push hl ; $5d44
	ldh a, [$ff96] ; $5d45
	push af ; $5d47
	ld a, $03 ; $5d48
	ldh [$ff96], a ; $5d4a
	ldh [rWBK], a ; $5d4c
	call Func_38_5d60 ; $5d4e
	ld a, [hl] ; $5d51
	ld b, a ; $5d52
	ld a, $01 ; $5d53
	ld [hl], a ; $5d55
	pop af ; $5d56
	ldh [$ff96], a ; $5d57
	ldh [rWBK], a ; $5d59
	ld a, b ; $5d5b
	pop hl ; $5d5c
	pop de ; $5d5d
	pop bc ; $5d5e
	ret ; $5d5f
Func_38_5d60:
	ld hl, $da00 ; $5d60
	ld a, c ; $5d63
	ld bc, $000c ; $5d64
Label_38_5d67:
	or a, a ; $5d67
	jr z, Label_38_5d6e ; $5d68
	add hl, bc ; $5d6a
	dec a ; $5d6b
	jr Label_38_5d67 ; $5d6c
Label_38_5d6e:
	ld a, e ; $5d6e
	add a, a ; $5d6f
	add a, e ; $5d70
	ld e, a ; $5d71
	ld a, d ; $5d72
	add a, e ; $5d73
	add a, a ; $5d74
	add a, a ; $5d75
	add a, l ; $5d76
	ld l, a ; $5d77
	jr nc, Label_38_5d7b ; $5d78
	inc h ; $5d7a
Label_38_5d7b:
	ld a, $02 ; $5d7b
	add a, l ; $5d7d
	ld l, a ; $5d7e
	jr nc, Label_38_5d82 ; $5d7f
	inc h ; $5d81
Label_38_5d82:
	ret ; $5d82
Func_38_5d83:
	push af ; $5d83
	push bc ; $5d84
	push de ; $5d85
	push hl ; $5d86
	ldh a, [$ff96] ; $5d87
	push af ; $5d89
	ld a, $03 ; $5d8a
	ldh [$ff96], a ; $5d8c
	ldh [rWBK], a ; $5d8e
	ld hl, $d900 ; $5d90
	ld bc, $00c0 ; $5d93
	call ClearBytes ; $5d96
	ld bc, $d900 ; $5d99
	ld a, $80 ; $5d9c
Label_38_5d9e:
	push af ; $5d9e
	rst Rst18 ; $5d9f
	inc h ; $5da0
	INCBIN "data/bank_038/d_5da1.bin" ; $5da1, 1 bytes
	rst Rst18 ; $5da2
	ld h, $18 ; $5da3
	ld hl, $0000 ; $5da5
	add hl, bc ; $5da8
	ld a, [$d58b] ; $5da9
	cp a, $04 ; $5dac
	jr c, Label_38_5dc9 ; $5dae
	ld a, $ff ; $5db0
	ld [hl], a ; $5db2
	ld hl, $0020 ; $5db3
	add hl, bc ; $5db6
	ld b, h ; $5db7
	ld c, l ; $5db8
	ld hl, $0000 ; $5db9
	add hl, bc ; $5dbc
	ld a, $ff ; $5dbd
	ld [hl], a ; $5dbf
	ld hl, $0020 ; $5dc0
	add hl, bc ; $5dc3
	ld b, h ; $5dc4
	ld c, l ; $5dc5
	jp Label_38_5e5d ; $5dc6
Label_38_5dc9:
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $5dc9
	ld [hl], a ; $5dcc
	ld hl, $0001 ; $5dcd
	add hl, bc ; $5dd0
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $5dd1
	ld [hl], a ; $5dd4
	ld hl, $0002 ; $5dd5
	add hl, bc ; $5dd8
	ld a, [$c918] ; $5dd9
	ld [hl], a ; $5ddc
	ld hl, $0003 ; $5ddd
	add hl, bc ; $5de0
	ld a, [$c938] ; $5de1
	ld [hl], a ; $5de4
	ld hl, $0004 ; $5de5
	add hl, bc ; $5de8
	ld a, [$c939] ; $5de9
	ld [hl], a ; $5dec
	ld hl, $0005 ; $5ded
	add hl, bc ; $5df0
	ld a, [$c93a] ; $5df1
	ld [hl], a ; $5df4
	ld hl, $0006 ; $5df5
	add hl, bc ; $5df8
	ld a, [$c93b] ; $5df9
	ld [hl], a ; $5dfc
	push bc ; $5dfd
	ld a, $07 ; $5dfe
	add a, c ; $5e00
	ld e, a ; $5e01
	ld d, b ; $5e02
	ld hl, $c900 ; $5e03
	ld bc, $000b ; $5e06
	call CopyMemoryBC ; $5e09
	pop bc ; $5e0c
	ld hl, $0020 ; $5e0d
	add hl, bc ; $5e10
	ld b, h ; $5e11
	ld c, l ; $5e12
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $5e13
	ld [hl], a ; $5e16
	ld hl, $0001 ; $5e17
	add hl, bc ; $5e1a
	ld a, [wStoryModePartnerCharacterOverworldSpriteColor] ; $5e1b
	ld [hl], a ; $5e1e
	ld hl, $0002 ; $5e1f
	add hl, bc ; $5e22
	ld a, [$c958] ; $5e23
	ld [hl], a ; $5e26
	ld hl, $0003 ; $5e27
	add hl, bc ; $5e2a
	ld a, [$c978] ; $5e2b
	ld [hl], a ; $5e2e
	ld hl, $0004 ; $5e2f
	add hl, bc ; $5e32
	ld a, [$c979] ; $5e33
	ld [hl], a ; $5e36
	ld hl, $0005 ; $5e37
	add hl, bc ; $5e3a
	ld a, [$c97a] ; $5e3b
	ld [hl], a ; $5e3e
	ld hl, $0006 ; $5e3f
	add hl, bc ; $5e42
	ld a, [$c97b] ; $5e43
	ld [hl], a ; $5e46
	push bc ; $5e47
	ld a, $07 ; $5e48
	add a, c ; $5e4a
	ld e, a ; $5e4b
	ld d, b ; $5e4c
	ld hl, $c940 ; $5e4d
	ld bc, $000b ; $5e50
	call CopyMemoryBC ; $5e53
	pop bc ; $5e56
	ld hl, $0020 ; $5e57
	add hl, bc ; $5e5a
	ld b, h ; $5e5b
	ld c, l ; $5e5c
Label_38_5e5d:
	pop af ; $5e5d
	inc a ; $5e5e
	cp a, $83 ; $5e5f
	jp nz, Label_38_5d9e ; $5e61
	pop af ; $5e64
	ldh [$ff96], a ; $5e65
	ldh [rWBK], a ; $5e67
	pop hl ; $5e69
	pop de ; $5e6a
	pop bc ; $5e6b
	pop af ; $5e6c
	ret ; $5e6d
Func_38_5e6e:
	ldh a, [$ff96] ; $5e6e
	push af ; $5e70
	ld a, $03 ; $5e71
	ldh [$ff96], a ; $5e73
	ldh [rWBK], a ; $5e75
	ld c, $00 ; $5e77
	ld hl, $d816 ; $5e79
Label_38_5e7c:
	ld a, [hl] ; $5e7c
	cp a, $ff ; $5e7d
	jr z, Label_38_5e98 ; $5e7f
	push hl ; $5e81
	ld hl, $da00 ; $5e82
	add a, a ; $5e85
	add a, a ; $5e86
	add a, l ; $5e87
	ld l, a ; $5e88
	jr nc, Label_38_5e8c ; $5e89
	inc h ; $5e8b
Label_38_5e8c:
	ld a, [hl] ; $5e8c
	cp a, $04 ; $5e8d
	jr nc, Label_38_5e97 ; $5e8f
	inc hl ; $5e91
	inc hl ; $5e92
	inc hl ; $5e93
	ld a, [hl] ; $5e94
	or a, $80 ; $5e95
Label_38_5e97:
	pop hl ; $5e97
Label_38_5e98:
	ld [hl+], a ; $5e98
	ld a, c ; $5e99
	inc a ; $5e9a
	ld c, a ; $5e9b
	cp a, $04 ; $5e9c
	jr nz, Label_38_5e7c ; $5e9e
	pop af ; $5ea0
	ldh [$ff96], a ; $5ea1
	ldh [rWBK], a ; $5ea3
	ret ; $5ea5
Func_38_5ea6:
	ldh a, [$ff96] ; $5ea6
	push af ; $5ea8
	ld a, $03 ; $5ea9
	ldh [$ff96], a ; $5eab
	ldh [rWBK], a ; $5ead
	call Func_38_605b ; $5eaf
	ld a, [$d816] ; $5eb2
	cp a, $ff ; $5eb5
	jr z, Label_38_5ed7 ; $5eb7
	cp a, $80 ; $5eb9
	jr c, Label_38_5ed1 ; $5ebb
	ld c, a ; $5ebd
	and a, $07 ; $5ebe
	srl a ; $5ec0
	ld b, a ; $5ec2
	ld a, c ; $5ec3
	call Func_38_60b9 ; $5ec4
	and a, $81 ; $5ec7
	ld b, a ; $5ec9
	ld c, $00 ; $5eca
	rst Rst18 ; $5ecc
	jr Label_38_5ed1 ; $5ecd
	INCBIN "data/bank_038/d_5ecf.bin" ; $5ecf, 2 bytes
Label_38_5ed1:
	ld b, a ; $5ed1
	ld c, $00 ; $5ed2
	rst Rst18 ; $5ed4
	jr $5ed9 ; $5ed5
Label_38_5ed7:
	ld a, [$d817] ; $5ed7
	cp a, $ff ; $5eda
	jr z, Label_38_5efc ; $5edc
	cp a, $80 ; $5ede
	jr c, Label_38_5ef6 ; $5ee0
	ld c, a ; $5ee2
	and a, $07 ; $5ee3
	srl a ; $5ee5
	ld b, a ; $5ee7
	ld a, c ; $5ee8
	call Func_38_60b9 ; $5ee9
	and a, $81 ; $5eec
	ld b, a ; $5eee
	ld c, $01 ; $5eef
	rst Rst18 ; $5ef1
	jr Label_38_5ef6 ; $5ef2
	INCBIN "data/bank_038/d_5ef4.bin" ; $5ef4, 2 bytes
Label_38_5ef6:
	ld b, a ; $5ef6
	ld c, $01 ; $5ef7
	rst Rst18 ; $5ef9
	jr $5efe ; $5efa
Label_38_5efc:
	ld a, [$d818] ; $5efc
	cp a, $ff ; $5eff
	jr z, Label_38_5f21 ; $5f01
	cp a, $80 ; $5f03
	jr c, Label_38_5f1b ; $5f05
	ld c, a ; $5f07
	and a, $07 ; $5f08
	srl a ; $5f0a
	ld b, a ; $5f0c
	ld a, c ; $5f0d
	call Func_38_60b9 ; $5f0e
	and a, $81 ; $5f11
	ld b, a ; $5f13
	ld c, $02 ; $5f14
	rst Rst18 ; $5f16
	jr Label_38_5f1b ; $5f17
	INCBIN "data/bank_038/d_5f19.bin" ; $5f19, 2 bytes
Label_38_5f1b:
	ld b, a ; $5f1b
	ld c, $02 ; $5f1c
	rst Rst18 ; $5f1e
	jr $5f23 ; $5f1f
Label_38_5f21:
	ld a, [$d819] ; $5f21
	cp a, $ff ; $5f24
	jr z, Label_38_5f46 ; $5f26
	cp a, $80 ; $5f28
	jr c, Label_38_5f40 ; $5f2a
	ld c, a ; $5f2c
	and a, $07 ; $5f2d
	srl a ; $5f2f
	ld b, a ; $5f31
	ld a, c ; $5f32
	call Func_38_60b9 ; $5f33
	and a, $81 ; $5f36
	ld b, a ; $5f38
	ld c, $03 ; $5f39
	rst Rst18 ; $5f3b
	jr Label_38_5f40 ; $5f3c
	INCBIN "data/bank_038/d_5f3e.bin" ; $5f3e, 2 bytes
Label_38_5f40:
	ld b, a ; $5f40
	ld c, $03 ; $5f41
	rst Rst18 ; $5f43
	jr $5f48 ; $5f44
Label_38_5f46:
	pop af ; $5f46
	ldh [$ff96], a ; $5f47
	ldh [rWBK], a ; $5f49
	ret ; $5f4b
Func_38_5f4c:
	ldh a, [$ff96] ; $5f4c
	push af ; $5f4e
	ld a, $03 ; $5f4f
	ldh [$ff96], a ; $5f51
	ldh [rWBK], a ; $5f53
	ld a, [$d831] ; $5f55
	ld hl, $5feb ; $5f58
	add a, a ; $5f5b
	add a, l ; $5f5c
	ld l, a ; $5f5d
	jr nc, Label_38_5f61 ; $5f5e
	inc h ; $5f60
Label_38_5f61:
	ld a, [hl+] ; $5f61
	ld h, [hl] ; $5f62
	ld l, a ; $5f63
	ld a, [hl+] ; $5f64
	ld [$ca5b], a ; $5f65
	ld a, [hl+] ; $5f68
	ld [$ca5c], a ; $5f69
	ld a, [hl+] ; $5f6c
	ld [$ca5d], a ; $5f6d
	ld a, [hl+] ; $5f70
	ld [$ca5e], a ; $5f71
	ld a, [hl+] ; $5f74
	ld [wExhibitionModePlayerPartnerCharacterDifficulty], a ; $5f75
	ld a, [wPlayer1CurrentPartnerCharacter] ; $5f78
	call Func_38_6013 ; $5f7b
	or a, a ; $5f7e
	jr nz, Label_38_5f85 ; $5f7f
	ld a, [hl+] ; $5f81
	ld [$ca58], a ; $5f82
Label_38_5f85:
	ld a, [$d832] ; $5f85
	ld hl, $5feb ; $5f88
	add a, a ; $5f8b
	add a, l ; $5f8c
	ld l, a ; $5f8d
	jr nc, Label_38_5f91 ; $5f8e
	inc h ; $5f90
Label_38_5f91:
	ld a, [hl+] ; $5f91
	ld h, [hl] ; $5f92
	ld l, a ; $5f93
	ld a, [hl+] ; $5f94
	ld [$ca9b], a ; $5f95
	ld a, [hl+] ; $5f98
	ld [$ca9c], a ; $5f99
	ld a, [hl+] ; $5f9c
	ld [$ca9d], a ; $5f9d
	ld a, [hl+] ; $5fa0
	ld [$ca9e], a ; $5fa1
	ld a, [hl+] ; $5fa4
	ld [wExhibitionModeCPUMainCharacterDifficulty], a ; $5fa5
	ld a, [wPlayer2CurrentMainCharacter] ; $5fa8
	call Func_38_6013 ; $5fab
	or a, a ; $5fae
	jr nz, Label_38_5fb5 ; $5faf
	ld a, [hl+] ; $5fb1
	ld [$ca98], a ; $5fb2
Label_38_5fb5:
	ld a, [$d833] ; $5fb5
	ld hl, $5feb ; $5fb8
	add a, a ; $5fbb
	add a, l ; $5fbc
	ld l, a ; $5fbd
	jr nc, Label_38_5fc1 ; $5fbe
	inc h ; $5fc0
Label_38_5fc1:
	ld a, [hl+] ; $5fc1
	ld h, [hl] ; $5fc2
	ld l, a ; $5fc3
	ld a, [hl+] ; $5fc4
	ld [$cadb], a ; $5fc5
	ld a, [hl+] ; $5fc8
	ld [$cadc], a ; $5fc9
	ld a, [hl+] ; $5fcc
	ld [$cadd], a ; $5fcd
	ld a, [hl+] ; $5fd0
	ld [$cade], a ; $5fd1
	ld a, [hl+] ; $5fd4
	ld [wExhibitionModeCPUPartnerCharacterDifficulty], a ; $5fd5
	ld a, [wPlayer2CurrentPartnerCharacter] ; $5fd8
	call Func_38_6013 ; $5fdb
	or a, a ; $5fde
	jr nz, Label_38_5fe5 ; $5fdf
	ld a, [hl+] ; $5fe1
	ld [$cad8], a ; $5fe2
Label_38_5fe5:
	pop af ; $5fe5
	ldh [$ff96], a ; $5fe6
	ldh [rWBK], a ; $5fe8
	ret ; $5fea
	INCBIN "data/bank_038/d_5feb.bin" ; $5feb, 40 bytes
Func_38_6013:
	cp a, $04 ; $6013
	jr nc, Label_38_601a ; $6015
	ld a, $01 ; $6017
	ret ; $6019
Label_38_601a:
	xor a, a ; $601a
	ret ; $601b
Func_38_601c:
	ldh a, [$ff96] ; $601c
	push af ; $601e
	ld a, $03 ; $601f
	ldh [$ff96], a ; $6021
	ldh [rWBK], a ; $6023
	ld a, [$ca0e] ; $6025
	or a, a ; $6028
	jr nz, Label_38_6031 ; $6029
	ld a, [$d834] ; $602b
	ld [$ca0e], a ; $602e
Label_38_6031:
	ld a, [$ca4e] ; $6031
	or a, a ; $6034
	jr nz, Label_38_603d ; $6035
	ld a, [$d835] ; $6037
	ld [$ca4e], a ; $603a
Label_38_603d:
	ld a, [$ca8e] ; $603d
	or a, a ; $6040
	jr nz, Label_38_6049 ; $6041
	ld a, [$d836] ; $6043
	ld [$ca8e], a ; $6046
Label_38_6049:
	ld a, [$cace] ; $6049
	or a, a ; $604c
	jr nz, Label_38_6055 ; $604d
	ld a, [$d837] ; $604f
	ld [$cace], a ; $6052
Label_38_6055:
	pop af ; $6055
	ldh [$ff96], a ; $6056
	ldh [rWBK], a ; $6058
	ret ; $605a
Func_38_605b:
	push af ; $605b
	push bc ; $605c
	push de ; $605d
	push hl ; $605e
	ldh a, [$ff96] ; $605f
	push af ; $6061
	ld a, $01 ; $6062
	ldh [$ff96], a ; $6064
	ldh [rWBK], a ; $6066
	ld a, $00 ; $6068
	ld [$c36c], a ; $606a
	rst Rst18 ; $606d
	ld a, [de] ; $606e
	inc bc ; $606f
	ld hl, $c900 ; $6070
	ld de, $d000 ; $6073
	ld bc, $0008 ; $6076
	call CopyMemoryFast ; $6079
	ld a, $01 ; $607c
	ld [$c36c], a ; $607e
	rst Rst18 ; $6081
	ld a, [de] ; $6082
	inc bc ; $6083
	ld hl, $c900 ; $6084
	ld de, $d100 ; $6087
	ld bc, $0008 ; $608a
	call CopyMemoryFast ; $608d
	ld a, $02 ; $6090
	ld [$c36c], a ; $6092
	rst Rst18 ; $6095
	ld a, [de] ; $6096
	inc bc ; $6097
	ld hl, $c900 ; $6098
	ld de, $d200 ; $609b
	ld bc, $0008 ; $609e
	call CopyMemoryFast ; $60a1
	pop af ; $60a4
	ldh [$ff96], a ; $60a5
	ldh [rWBK], a ; $60a7
	pop hl ; $60a9
	pop de ; $60aa
	pop bc ; $60ab
	pop af ; $60ac
	ld a, $03 ; $60ad
	ld [$c36c], a ; $60af
	rst Rst18 ; $60b2
	ld [bc], a ; $60b3
	ld [bc], a ; $60b4
	rst Rst18 ; $60b5
	nop ; $60b6
	INCBIN "data/bank_038/d_60b7.bin" ; $60b7, 1 bytes
	ret ; $60b8
Func_38_60b9:
	push af ; $60b9
	push bc ; $60ba
	push de ; $60bb
	push hl ; $60bc
	ldh a, [$ff96] ; $60bd
	push af ; $60bf
	ld a, $01 ; $60c0
	ldh [$ff96], a ; $60c2
	ldh [rWBK], a ; $60c4
	ld a, b ; $60c6
	add a, a ; $60c7
	ld hl, $60e6 ; $60c8
	add a, l ; $60cb
	ld l, a ; $60cc
	jr nc, Label_38_60d0 ; $60cd
	inc h ; $60cf
Label_38_60d0:
	ld a, [hl+] ; $60d0
	ld h, [hl] ; $60d1
	ld l, a ; $60d2
	ld de, $c900 ; $60d3
	ld bc, $0008 ; $60d6
	call CopyMemoryFast ; $60d9
	pop af ; $60dc
	ldh [$ff96], a ; $60dd
	ldh [rWBK], a ; $60df
	pop hl ; $60e1
	pop de ; $60e2
	pop bc ; $60e3
	pop af ; $60e4
	ret ; $60e5
	INCBIN "data/bank_038/d_60e6.bin" ; $60e6, 6 bytes
Func_38_60ec:
	ld hl, $da24 ; $60ec
	ld c, $00 ; $60ef
Label_38_60f1:
	ld a, [hl] ; $60f1
	cp a, $ff ; $60f2
	jr nz, Label_38_612c ; $60f4
	push hl ; $60f6
	ld a, $16 ; $60f7
	sub a, c ; $60f9
	ld b, a ; $60fa
Label_38_60fb:
	inc hl ; $60fb
	inc hl ; $60fc
	inc hl ; $60fd
	inc hl ; $60fe
	ld a, [hl] ; $60ff
	cp a, $04 ; $6100
	jr c, Label_38_6109 ; $6102
	ld a, [hl] ; $6104
	cp a, $ff ; $6105
	jr nz, Label_38_610e ; $6107
Label_38_6109:
	ld a, b ; $6109
	dec a ; $610a
	ld b, a ; $610b
	jr nz, Label_38_60fb ; $610c
Label_38_610e:
	pop de ; $610e
	ld a, [hl] ; $610f
	ld [de], a ; $6110
	ld a, $ff ; $6111
	ld [hl], a ; $6113
	inc de ; $6114
	inc hl ; $6115
	ld a, [hl] ; $6116
	ld [de], a ; $6117
	xor a, a ; $6118
	ld [hl], a ; $6119
	inc de ; $611a
	inc hl ; $611b
	ld a, [hl] ; $611c
	ld [de], a ; $611d
	xor a, a ; $611e
	ld [hl], a ; $611f
	inc de ; $6120
	inc hl ; $6121
	ld a, [hl] ; $6122
	ld [de], a ; $6123
	xor a, a ; $6124
	ld [hl], a ; $6125
	inc de ; $6126
	inc hl ; $6127
	ld h, d ; $6128
	ld l, e ; $6129
	jr Label_38_6130 ; $612a
Label_38_612c:
	inc hl ; $612c
	inc hl ; $612d
	inc hl ; $612e
	inc hl ; $612f
Label_38_6130:
	ld a, c ; $6130
	inc a ; $6131
	ld c, a ; $6132
	cp a, $16 ; $6133
	jr nz, Label_38_60f1 ; $6135
	ld a, $ff ; $6137
	ld [hl+], a ; $6139
	ld [hl+], a ; $613a
	ld [hl+], a ; $613b
	ld [hl+], a ; $613c
	ld [hl+], a ; $613d
	ld [hl+], a ; $613e
	ld [hl+], a ; $613f
	ld [hl+], a ; $6140
	ld [hl+], a ; $6141
	ld [hl+], a ; $6142
	ld [hl+], a ; $6143
	ld [hl+], a ; $6144
	ret ; $6145
Func_38_6146:
	ld hl, $da00 ; $6146
	ld c, $00 ; $6149
Label_38_614b:
	ld a, [hl] ; $614b
	cp a, $ff ; $614c
	jr nz, Label_38_6186 ; $614e
	push hl ; $6150
	ld a, $08 ; $6151
	sub a, c ; $6153
	ld b, a ; $6154
Label_38_6155:
	inc hl ; $6155
	inc hl ; $6156
	inc hl ; $6157
	inc hl ; $6158
	ld a, [hl] ; $6159
	cp a, $04 ; $615a
	jr c, Label_38_6163 ; $615c
	ld a, [hl] ; $615e
	cp a, $ff ; $615f
	jr nz, Label_38_6168 ; $6161
Label_38_6163:
	ld a, b ; $6163
	dec a ; $6164
	ld b, a ; $6165
	jr nz, Label_38_6155 ; $6166
Label_38_6168:
	pop de ; $6168
	ld a, [hl] ; $6169
	ld [de], a ; $616a
	ld a, $ff ; $616b
	ld [hl], a ; $616d
	inc de ; $616e
	inc hl ; $616f
	ld a, [hl] ; $6170
	ld [de], a ; $6171
	xor a, a ; $6172
	ld [hl], a ; $6173
	inc de ; $6174
	inc hl ; $6175
	ld a, [hl] ; $6176
	ld [de], a ; $6177
	xor a, a ; $6178
	ld [hl], a ; $6179
	inc de ; $617a
	inc hl ; $617b
	ld a, [hl] ; $617c
	ld [de], a ; $617d
	xor a, a ; $617e
	ld [hl], a ; $617f
	inc de ; $6180
	inc hl ; $6181
	ld h, d ; $6182
	ld l, e ; $6183
	jr Label_38_618a ; $6184
Label_38_6186:
	inc hl ; $6186
	inc hl ; $6187
	inc hl ; $6188
	inc hl ; $6189
Label_38_618a:
	ld a, c ; $618a
	inc a ; $618b
	ld c, a ; $618c
	cp a, $08 ; $618d
	jr nz, Label_38_614b ; $618f
	ret ; $6191
Func_38_6192:
	ld hl, $da24 ; $6192
	ld c, $00 ; $6195
	ld b, $00 ; $6197
Label_38_6199:
	ld a, [hl] ; $6199
	cp a, $ff ; $619a
	jr z, Label_38_619f ; $619c
	inc b ; $619e
Label_38_619f:
	inc hl ; $619f
	inc hl ; $61a0
	inc hl ; $61a1
	inc hl ; $61a2
	ld a, c ; $61a3
	inc a ; $61a4
	ld c, a ; $61a5
	cp a, $16 ; $61a6
	jr nz, Label_38_6199 ; $61a8
	ld a, b ; $61aa
	ld [$d81a], a ; $61ab
	ld hl, $da00 ; $61ae
	ld c, $00 ; $61b1
	ld b, $00 ; $61b3
Label_38_61b5:
	ld a, [hl] ; $61b5
	cp a, $ff ; $61b6
	jr z, Label_38_61bb ; $61b8
	inc b ; $61ba
Label_38_61bb:
	inc hl ; $61bb
	inc hl ; $61bc
	inc hl ; $61bd
	inc hl ; $61be
	ld a, c ; $61bf
	inc a ; $61c0
	ld c, a ; $61c1
	cp a, $09 ; $61c2
	jr nz, Label_38_61b5 ; $61c4
	ld a, b ; $61c6
	ld [$d823], a ; $61c7
	ret ; $61ca
Func_38_61cb:
	ld a, [$d81a] ; $61cb
	ld hl, $61db ; $61ce
	add a, l ; $61d1
	ld l, a ; $61d2
	jr nc, Label_38_61d6 ; $61d3
	inc h ; $61d5
Label_38_61d6:
	ld a, [hl] ; $61d6
	ld [$d812], a ; $61d7
	ret ; $61da
	INCBIN "data/bank_038/d_61db.bin" ; $61db, 28 bytes
Func_38_61f7:
	call Func_38_6208 ; $61f7
	or a, a ; $61fa
	jr z, Label_38_6206 ; $61fb
	ld a, [$d814] ; $61fd
	or a, a ; $6200
	jr z, Label_38_6206 ; $6201
	ld a, $01 ; $6203
	ret ; $6205
Label_38_6206:
	xor a, a ; $6206
	ret ; $6207
Func_38_6208:
	ld a, c ; $6208
	cp a, $17 ; $6209
	jr c, Label_38_6214 ; $620b
	cp a, $20 ; $620d
	jr nc, Label_38_6214 ; $620f
	ld a, $01 ; $6211
	ret ; $6213
Label_38_6214:
	xor a, a ; $6214
	ret ; $6215
Func_38_6216:
	ldh a, [$ff96] ; $6216
	push af ; $6218
	ld a, $03 ; $6219
	ldh [$ff96], a ; $621b
	ldh [rWBK], a ; $621d
	ld a, [$d825] ; $621f
	or a, a ; $6222
	jr nz, Label_38_6230 ; $6223
	call Func_38_636d ; $6225
	call Func_38_6396 ; $6228
	ld a, $01 ; $622b
	ld [$d825], a ; $622d
Label_38_6230:
	call Func_38_630f ; $6230
	call Func_38_633b ; $6233
	ld a, [$cb0d] ; $6236
	bit 0, a ; $6239
	jr nz, Label_38_628d ; $623b
	bit 1, a ; $623d
	jr nz, Label_38_6243 ; $623f
	jr Label_38_62c2 ; $6241
Label_38_6243:
	call Func_38_62c8 ; $6243
	rst Rst08 ; $6246
	ld h, d ; $6247
	ld a, $03 ; $6248
	ldh [$ff96], a ; $624a
	ldh [rWBK], a ; $624c
	ld hl, $d830 ; $624e
	ld a, [$d814] ; $6251
	add a, l ; $6254
	ld l, a ; $6255
	jr nc, Label_38_6259 ; $6256
	inc h ; $6258
Label_38_6259:
	xor a, a ; $6259
	ld [hl], a ; $625a
	ld hl, $d834 ; $625b
	ld a, [$d814] ; $625e
	add a, l ; $6261
	ld l, a ; $6262
	jr nc, Label_38_6266 ; $6263
	inc h ; $6265
Label_38_6266:
	xor a, a ; $6266
	ld [hl], a ; $6267
	ld hl, $d816 ; $6268
	ld a, [$d814] ; $626b
	add a, l ; $626e
	ld l, a ; $626f
	jr nc, Label_38_6273 ; $6270
	inc h ; $6272
Label_38_6273:
	ld a, [hl] ; $6273
	ld b, $00 ; $6274
	ld [hl], b ; $6276
	ld hl, $da00 ; $6277
	add a, a ; $627a
	add a, a ; $627b
	add a, l ; $627c
	ld l, a ; $627d
	jr nc, Label_38_6281 ; $627e
	inc h ; $6280
Label_38_6281:
	inc hl ; $6281
	inc hl ; $6282
	xor a, a ; $6283
	ld [hl], a ; $6284
	call Func_38_55ab ; $6285
	call Func_38_5ce5 ; $6288
	jr Label_38_62b4 ; $628b
Label_38_628d:
	rst Rst08 ; $628d
	ld e, a ; $628e
	call Func_38_62c8 ; $628f
	ld hl, $d830 ; $6292
	ld a, [$d814] ; $6295
	add a, l ; $6298
	ld l, a ; $6299
	jr nc, Label_38_629d ; $629a
	inc h ; $629c
Label_38_629d:
	ld a, [$d826] ; $629d
	inc a ; $62a0
	ld [hl], a ; $62a1
	call Func_38_5cb7 ; $62a2
	call Func_38_5612 ; $62a5
	call Func_38_5c47 ; $62a8
	cp a, $ff ; $62ab
	jr nz, Label_38_62b4 ; $62ad
	ld a, $01 ; $62af
	ld [$d815], a ; $62b1
Label_38_62b4:
	call Func_38_5424 ; $62b4
	ld hl, $d040 ; $62b7
	ld de, $9840 ; $62ba
	ld c, $04 ; $62bd
	call Func_00_0480 ; $62bf
Label_38_62c2:
	pop af ; $62c2
	ldh [$ff96], a ; $62c3
	ldh [rWBK], a ; $62c5
	ret ; $62c7
Func_38_62c8:
	xor a, a ; $62c8
	ld [$d825], a ; $62c9
	ld [$d824], a ; $62cc
	ld hl, $d2c0 ; $62cf
	ld de, $d1c0 ; $62d2
	ld b, $14 ; $62d5
	ld c, $04 ; $62d7
	rst Rst18 ; $62d9
	ld a, [bc] ; $62da
	add hl, sp ; $62db
	ld hl, $d6c0 ; $62dc
	ld de, $d5c0 ; $62df
	ld b, $14 ; $62e2
	ld c, $04 ; $62e4
	rst Rst18 ; $62e6
	ld a, [bc] ; $62e7
	add hl, sp ; $62e8
	ld de, $d5c1 ; $62e9
	ld b, $12 ; $62ec
	ld c, $03 ; $62ee
	ld h, $00 ; $62f0
	rst Rst18 ; $62f2
	inc c ; $62f3
	add hl, sp ; $62f4
	call Func_38_575e ; $62f5
	ld hl, $d220 ; $62f8
	ld de, $9a20 ; $62fb
	ld c, $02 ; $62fe
	call Func_00_0480 ; $6300
	ld hl, $d5c0 ; $6303
	ld de, $b9c0 ; $6306
	ld c, $08 ; $6309
	call Func_00_0480 ; $630b
	ret ; $630e
Func_38_630f:
	ld a, [$cb0d] ; $630f
	bit 5, a ; $6312
	jr nz, Label_38_631b ; $6314
	bit 4, a ; $6316
	jr nz, Label_38_6323 ; $6318
	ret ; $631a
Label_38_631b:
	rst Rst08 ; $631b
	ld e, [hl] ; $631c
	ld a, [$d826] ; $631d
	dec a ; $6320
	jr Label_38_6329 ; $6321
Label_38_6323:
	rst Rst08 ; $6323
	ld e, [hl] ; $6324
	ld a, [$d826] ; $6325
	inc a ; $6328
Label_38_6329:
	add a, a ; $6329
	jr nc, Label_38_6331 ; $632a
	ld a, $04 ; $632c
	dec a ; $632e
	jr Label_38_6337 ; $632f
Label_38_6331:
	rra ; $6331
	cp a, $04 ; $6332
	jr c, Label_38_6337 ; $6334
	xor a, a ; $6336
Label_38_6337:
	ld [$d826], a ; $6337
	ret ; $633a
Func_38_633b:
	ld a, [$d826] ; $633b
	add a, a ; $633e
	ld hl, $635d ; $633f
	add a, l ; $6342
	ld l, a ; $6343
	jr nc, Label_38_6347 ; $6344
	inc h ; $6346
Label_38_6347:
	ld a, [hl+] ; $6347
	ld d, [hl] ; $6348
	ld e, a ; $6349
	ld a, [$d826] ; $634a
	add a, a ; $634d
	ld hl, $6365 ; $634e
	add a, l ; $6351
	ld l, a ; $6352
	jr nc, Label_38_6356 ; $6353
	inc h ; $6355
Label_38_6356:
	ld a, [hl+] ; $6356
	ld b, [hl] ; $6357
	ld c, a ; $6358
	call Func_38_4018 ; $6359
	ret ; $635c
	INCBIN "data/bank_038/d_635d.bin" ; $635d, 16 bytes
Func_38_636d:
	ldh a, [$ff96] ; $636d
	push af ; $636f
	ld a, $03 ; $6370
	ldh [$ff96], a ; $6372
	ldh [rWBK], a ; $6374
	ld hl, $d240 ; $6376
	ld de, $d1c0 ; $6379
	ld b, $14 ; $637c
	ld c, $04 ; $637e
	rst Rst18 ; $6380
	ld a, [bc] ; $6381
	add hl, sp ; $6382
	ld hl, $d640 ; $6383
	ld de, $d5c0 ; $6386
	ld b, $14 ; $6389
	ld c, $04 ; $638b
	rst Rst18 ; $638d
	ld a, [bc] ; $638e
	add hl, sp ; $638f
	pop af ; $6390
	ldh [$ff96], a ; $6391
	ldh [rWBK], a ; $6393
	ret ; $6395
Func_38_6396:
	ldh a, [$ff96] ; $6396
	push af ; $6398
	ld a, $03 ; $6399
	ldh [$ff96], a ; $639b
	ldh [rWBK], a ; $639d
	ld hl, $d1c0 ; $639f
	ld de, $99c0 ; $63a2
	ld c, $08 ; $63a5
	call Func_00_0480 ; $63a7
	ld hl, $d5c0 ; $63aa
	ld de, $b9c0 ; $63ad
	ld c, $08 ; $63b0
	call Func_00_0480 ; $63b2
	pop af ; $63b5
	ldh [$ff96], a ; $63b6
	ldh [rWBK], a ; $63b8
	ret ; $63ba
	INCBIN "data/bank_038/d_63bb.bin" ; $63bb, 2649 bytes
	ld a, b ; $6e14
	ld [$cb00], a ; $6e15
	ld a, $02 ; $6e18
	ldh [$ff96], a ; $6e1a
	ldh [rWBK], a ; $6e1c
	ld a, c ; $6e1e
	ld [$d001], a ; $6e1f
	call DisableLCDSafely ; $6e22
	call Func_00_1b38 ; $6e25
	call Func_38_6f6e ; $6e28
	ld a, $01 ; $6e2b
	ld hl, $4408 ; $6e2d
	call Func_00_1b6a ; $6e30
	ld a, $01 ; $6e33
	ld hl, $7090 ; $6e35
	call Func_00_1b6a ; $6e38
	ld a, $01 ; $6e3b
	ld hl, $7385 ; $6e3d
	call Func_00_1b6a ; $6e40
	call EnableLCD ; $6e43
	ld c, $10 ; $6e46
	call Func_00_1d2e ; $6e48
	call Func_00_1da4 ; $6e4b
	ld hl, rIE ; $6e4e
	res 2, [hl] ; $6e51
	ld a, $01 ; $6e53
	ld hl, $4e52 ; $6e55
	call Func_00_1b6a ; $6e58
Label_38_6e5b:
	ld a, [$cb04] ; $6e5b
	push de ; $6e5e
	push af ; $6e5f
	ld a, a ; $6e60
	ld de, $0303 ; $6e61
	call Func_00_1ae4 ; $6e64
	pop af ; $6e67
	pop de ; $6e68
	ldh a, [$ff91] ; $6e69
	ld [$cb0d], a ; $6e6b
	ld b, $0f ; $6e6e
	ld c, $06 ; $6e70
	call Func_38_410a ; $6e72
	or a, a ; $6e75
	jr z, Label_38_6e7b ; $6e76
	call Func_38_7072 ; $6e78
Label_38_6e7b:
	call Func_00_2631 ; $6e7b
	ld a, [$cb0d] ; $6e7e
	bit 0, a ; $6e81
	jr nz, Label_38_6e8f ; $6e83
	bit 1, a ; $6e85
	jr nz, Label_38_6eb0 ; $6e87
	bit 2, a ; $6e89
	jr nz, Label_38_6ea7 ; $6e8b
	jr Label_38_6e5b ; $6e8d
Label_38_6e8f:
	ld a, [$cb05] ; $6e8f
	cp a, $05 ; $6e92
	jr z, Label_38_6e9b ; $6e94
	call Func_38_72b3 ; $6e96
	jr Label_38_6e5b ; $6e99
Label_38_6e9b:
	call Func_38_7220 ; $6e9b
	or a, a ; $6e9e
	jr z, Label_38_6ea7 ; $6e9f
	cp a, $01 ; $6ea1
	jr z, Label_38_6ea9 ; $6ea3
	jr Label_38_6ee3 ; $6ea5
Label_38_6ea7:
	rst Rst08 ; $6ea7
	ld e, [hl] ; $6ea8
Label_38_6ea9:
	rst Rst08 ; $6ea9
	ld h, d ; $6eaa
	call Func_38_7341 ; $6eab
	jr Label_38_6e5b ; $6eae
Label_38_6eb0:
	rst Rst08 ; $6eb0
	ld h, d ; $6eb1
	ldh a, [$ff96] ; $6eb2
	push af ; $6eb4
	ld a, $03 ; $6eb5
	ldh [$ff96], a ; $6eb7
	ldh [rWBK], a ; $6eb9
	ld a, [$d800] ; $6ebb
	ld b, a ; $6ebe
	pop af ; $6ebf
	ldh [$ff96], a ; $6ec0
	ldh [rWBK], a ; $6ec2
	ld a, b ; $6ec4
	cp a, $00 ; $6ec5
	jr z, Label_38_6ece ; $6ec7
	call Func_38_7341 ; $6ec9
	jr Label_38_6e5b ; $6ecc
Label_38_6ece:
	rst Rst08 ; $6ece
	ld h, d ; $6ecf
	ld c, $10 ; $6ed0
	call Func_00_1d20 ; $6ed2
	call Func_00_1da4 ; $6ed5
	call Func_00_1b38 ; $6ed8
	ld hl, rIE ; $6edb
	set 2, [hl] ; $6ede
	ld a, $ff ; $6ee0
	ret ; $6ee2
Label_38_6ee3:
	ldh a, [$ff96] ; $6ee3
	push af ; $6ee5
	ld a, $03 ; $6ee6
	ldh [$ff96], a ; $6ee8
	ldh [rWBK], a ; $6eea
	ld a, [$d800] ; $6eec
	ld b, a ; $6eef
	pop af ; $6ef0
	ldh [$ff96], a ; $6ef1
	ldh [rWBK], a ; $6ef3
	ld a, b ; $6ef5
	cp a, $00 ; $6ef6
	jr z, Label_38_6f26 ; $6ef8
	ld a, $03 ; $6efa
	ldh [$ff96], a ; $6efc
	ldh [rWBK], a ; $6efe
	call Func_38_73ae ; $6f00
	call Func_38_73fa ; $6f03
	ld d, b ; $6f06
	ld e, c ; $6f07
	ld hl, $d800 ; $6f08
	ld bc, $000b ; $6f0b
	call CopyMemoryBC ; $6f0e
	rst Rst08 ; $6f11
	ld e, a ; $6f12
	ld c, $10 ; $6f13
	call Func_00_1d20 ; $6f15
	call Func_00_1da4 ; $6f18
	call Func_00_1b38 ; $6f1b
	ld hl, rIE ; $6f1e
	set 2, [hl] ; $6f21
	ld a, $00 ; $6f23
	ret ; $6f25
Label_38_6f26:
	ld a, $03 ; $6f26
	ldh [$ff96], a ; $6f28
	ldh [rWBK], a ; $6f2a
	call Func_38_73fa ; $6f2c
	ld h, b ; $6f2f
	ld l, c ; $6f30
	ld de, $d800 ; $6f31
	ld bc, $000b ; $6f34
	call CopyMemoryBC ; $6f37
	call Func_38_73fa ; $6f3a
	ld d, b ; $6f3d
	ld e, c ; $6f3e
	ld hl, $d800 ; $6f3f
	ld bc, $000b ; $6f42
	call CopyMemoryBC ; $6f45
	call Func_38_728f ; $6f48
	ld hl, $d0a0 ; $6f4b
	ld de, $98a0 ; $6f4e
	ld c, $04 ; $6f51
	call Func_00_0480 ; $6f53
	call Func_00_2631 ; $6f56
	rst Rst08 ; $6f59
	ld e, a ; $6f5a
	ld c, $10 ; $6f5b
	call Func_00_1d20 ; $6f5d
	call Func_00_1da4 ; $6f60
	call Func_00_1b38 ; $6f63
	ld hl, rIE ; $6f66
	set 2, [hl] ; $6f69
	ld a, $00 ; $6f6b
	ret ; $6f6d
Func_38_6f6e:
	ld b, $12 ; $6f6e
	ld c, $02 ; $6f70
	ld de, $a100 ; $6f72
	rst Rst18 ; $6f75
	INCBIN "data/bank_038/d_6f76.bin" ; $6f76, 2 bytes
	ld hl, $a000 ; $6f78
	ld de, $0801 ; $6f7b
	rst Rst18 ; $6f7e
	ld b, $18 ; $6f7f
	ld b, $0f ; $6f81
	ld c, $00 ; $6f83
	call Func_38_43bb ; $6f85
	ld c, $06 ; $6f88
	rst Rst18 ; $6f8a
	nop ; $6f8b
	add hl, sp ; $6f8c
	rst Rst18 ; $6f8d
	halt ; $6f8e
	dec b ; $6f8f
	ld b, $11 ; $6f90
	ld c, $10 ; $6f92
	ld de, $9000 ; $6f94
	rst Rst18 ; $6f97
	INCBIN "data/bank_038/d_6f98.bin" ; $6f98, 2 bytes
	ld a, $05 ; $6f9a
	ldh [$ff96], a ; $6f9c
	ldh [rWBK], a ; $6f9e
	ld a, $03 ; $6fa0
	ld [$c3b3], a ; $6fa2
	ld a, $00 ; $6fa5
	ld [$c3b6], a ; $6fa7
	ld d, $00 ; $6faa
	ld e, $02 ; $6fac
	ld b, $14 ; $6fae
	ld c, $03 ; $6fb0
	rst Rst18 ; $6fb2
	ld a, b ; $6fb3
	dec b ; $6fb4
	rst Rst18 ; $6fb5
	ld a, h ; $6fb6
	dec b ; $6fb7
	rst Rst18 ; $6fb8
	ld a, [hl] ; $6fb9
	dec b ; $6fba
	ld d, $00 ; $6fbb
	ld e, $08 ; $6fbd
	ld b, $14 ; $6fbf
	ld c, $09 ; $6fc1
	rst Rst18 ; $6fc3
	ld a, b ; $6fc4
	dec b ; $6fc5
	rst Rst18 ; $6fc6
	ld a, h ; $6fc7
	dec b ; $6fc8
	rst Rst18 ; $6fc9
	ld a, [hl] ; $6fca
	dec b ; $6fcb
	ld d, $06 ; $6fcc
	ld e, $05 ; $6fce
	ld b, $09 ; $6fd0
	ld c, $03 ; $6fd2
	rst Rst18 ; $6fd4
	ld a, b ; $6fd5
	dec b ; $6fd6
	rst Rst18 ; $6fd7
	ld a, h ; $6fd8
	dec b ; $6fd9
	rst Rst18 ; $6fda
	ld a, [hl] ; $6fdb
	dec b ; $6fdc
	ld hl, $71b6 ; $6fdd
	call Func_38_717c ; $6fe0
	call Func_38_7159 ; $6fe3
	ld b, $0a ; $6fe6
	ld c, $0c ; $6fe8
	rst Rst18 ; $6fea
	ld c, $39 ; $6feb
	ldh a, [$ff96] ; $6fed
	push af ; $6fef
	ld a, $02 ; $6ff0
	ldh [$ff96], a ; $6ff2
	ldh [rWBK], a ; $6ff4
	ld a, [$d001] ; $6ff6
	rst Rst18 ; $6ff9
	INCBIN "data/bank_038/d_6ffa.bin" ; $6ffa, 2 bytes
	ld de, $b200 ; $6ffc
	rst Rst18 ; $6fff
	jr Label_38_701d ; $7000
	ld a, $02 ; $7002
	ldh [$ff96], a ; $7004
	ldh [rWBK], a ; $7006
	call Func_38_73fa ; $7008
	ld hl, $000c ; $700b
	add hl, bc ; $700e
	ld a, [hl] ; $700f
	ld d, $04 ; $7010
	rst Rst18 ; $7012
	ld [bc], a ; $7013
	INCBIN "data/bank_038/d_7014.bin" ; $7014, 1 bytes
	pop af ; $7015
	ldh [$ff96], a ; $7016
	ldh [rWBK], a ; $7018
	rst Rst18 ; $701a
	inc h ; $701b
	add hl, sp ; $701c
Label_38_701d:
	ld b, $01 ; $701d
	ld c, $01 ; $701f
	rst Rst18 ; $7021
	ld h, $39 ; $7022
	ld a, $10 ; $7024
	ld [$cb15], a ; $7026
	ld [$cb16], a ; $7029
	ld b, $48 ; $702c
	ld c, $14 ; $702e
	ld de, $8100 ; $7030
	rst Rst18 ; $7033
	INCBIN "data/bank_038/d_7034.bin" ; $7034, 2 bytes
	ldh a, [$ff96] ; $7036
	push af ; $7038
	ld a, $02 ; $7039
	ldh [$ff96], a ; $703b
	ldh [rWBK], a ; $703d
	xor a, a ; $703f
	ld [$d000], a ; $7040
	ld a, $03 ; $7043
	ldh [$ff96], a ; $7045
	ldh [rWBK], a ; $7047
	call Func_38_73fa ; $7049
	ld h, b ; $704c
	ld l, c ; $704d
	ld de, $d800 ; $704e
	ld bc, $000b ; $7051
	call CopyMemoryBC ; $7054
	pop af ; $7057
	ldh [$ff96], a ; $7058
	ldh [rWBK], a ; $705a
	call Func_38_728f ; $705c
	rst Rst18 ; $705f
	ld [bc], a ; $7060
	add hl, sp ; $7061
	ret ; $7062
	INCBIN "data/bank_038/d_7063.bin" ; $7063, 15 bytes
Func_38_7072:
	rst Rst08 ; $7072
	ld e, [hl] ; $7073
	ld a, [$cb05] ; $7074
	cp a, $05 ; $7077
	jr nz, Label_38_708f ; $7079
	ldh a, [$ff91] ; $707b
	bit 4, a ; $707d
	jr nz, Label_38_7087 ; $707f
	bit 5, a ; $7081
	jr nz, Label_38_708c ; $7083
	jr Label_38_708f ; $7085
Label_38_7087:
	call Func_38_723c ; $7087
	jr Label_38_708f ; $708a
Label_38_708c:
	call Func_38_725b ; $708c
Label_38_708f:
	ret ; $708f
	ld c, $0f ; $7090
	call Func_38_4399 ; $7092
	add a, a ; $7095
	ld hl, $70a5 ; $7096
	add a, l ; $7099
	ld l, a ; $709a
	jr nc, Label_38_709e ; $709b
	inc h ; $709d
Label_38_709e:
	ld a, [hl+] ; $709e
	ld d, [hl] ; $709f
	ld e, a ; $70a0
	call Func_38_727a ; $70a1
	ret ; $70a4
	INCBIN "data/bank_038/d_70a5.bin" ; $70a5, 180 bytes
Func_38_7159:
	ldh a, [$ff96] ; $7159
	push af ; $715b
	ld a, $03 ; $715c
	ldh [$ff96], a ; $715e
	ldh [rWBK], a ; $7160
	ld hl, $7171 ; $7162
	ld de, $d061 ; $7165
	call Func_38_440c ; $7168
	pop af ; $716b
	ldh [$ff96], a ; $716c
	ldh [rWBK], a ; $716e
	ret ; $7170
	INCBIN "data/bank_038/d_7171.bin" ; $7171, 11 bytes
Func_38_717c:
	ldh a, [$ff96] ; $717c
	push af ; $717e
	ld a, $03 ; $717f
	ldh [$ff96], a ; $7181
	ldh [rWBK], a ; $7183
	ld c, $05 ; $7185
	ld b, $03 ; $7187
	ld de, $d121 ; $7189
Label_38_718c:
	ld a, $20 ; $718c
	ld [de], a ; $718e
	inc de ; $718f
Label_38_7190:
	ld a, [hl+] ; $7190
	push hl ; $7191
	ld h, d ; $7192
	ld l, e ; $7193
	ld [hl+], a ; $7194
	ld d, h ; $7195
	ld e, l ; $7196
	pop hl ; $7197
	dec c ; $7198
	jr nz, Label_38_7190 ; $7199
	ld c, $05 ; $719b
	dec b ; $719d
	jr nz, Label_38_718c ; $719e
	ld a, [hl] ; $71a0
	or a, a ; $71a1
	jr z, Label_38_71b0 ; $71a2
	ld b, $03 ; $71a4
	push hl ; $71a6
	ld hl, $000e ; $71a7
	add hl, de ; $71aa
	ld d, h ; $71ab
	ld e, l ; $71ac
	pop hl ; $71ad
	jr Label_38_718c ; $71ae
Label_38_71b0:
	pop af ; $71b0
	ldh [$ff96], a ; $71b1
	ldh [rWBK], a ; $71b3
	ret ; $71b5
	INCBIN "data/bank_038/d_71b6.bin" ; $71b6, 106 bytes
Func_38_7220:
	ld hl, $722d ; $7220
	ld a, [$cb04] ; $7223
	add a, l ; $7226
	ld l, a ; $7227
	jr nc, Label_38_722b ; $7228
	inc h ; $722a
Label_38_722b:
	ld a, [hl] ; $722b
	ret ; $722c
	INCBIN "data/bank_038/d_722d.bin" ; $722d, 15 bytes
Func_38_723c:
	ld hl, $724c ; $723c
	ld a, [$cb04] ; $723f
	add a, l ; $7242
	ld l, a ; $7243
	jr nc, Label_38_7247 ; $7244
	inc h ; $7246
Label_38_7247:
	ld a, [hl] ; $7247
	ld [$cb04], a ; $7248
	ret ; $724b
	INCBIN "data/bank_038/d_724c.bin" ; $724c, 15 bytes
Func_38_725b:
	ld hl, $726b ; $725b
	ld a, [$cb04] ; $725e
	add a, l ; $7261
	ld l, a ; $7262
	jr nc, Label_38_7266 ; $7263
	inc h ; $7265
Label_38_7266:
	ld a, [hl] ; $7266
	ld [$cb04], a ; $7267
	ret ; $726a
	INCBIN "data/bank_038/d_726b.bin" ; $726b, 15 bytes
Func_38_727a:
	ld c, $00 ; $727a
	ld b, $08 ; $727c
	push de ; $727e
	call Func_00_1f51 ; $727f
	pop de ; $7282
	ld a, $08 ; $7283
	add a, d ; $7285
	ld d, a ; $7286
	ld c, $02 ; $7287
	ld b, $08 ; $7289
	call Func_00_1f51 ; $728b
	ret ; $728e
Func_38_728f:
	ldh a, [$ff96] ; $728f
	push af ; $7291
	ld a, $03 ; $7292
	ldh [$ff96], a ; $7294
	ldh [rWBK], a ; $7296
	ld a, $20 ; $7298
	ld hl, $d0c7 ; $729a
	ld [hl+], a ; $729d
	ld [hl+], a ; $729e
	ld [hl+], a ; $729f
	ld [hl+], a ; $72a0
	ld [hl+], a ; $72a1
	ld [hl+], a ; $72a2
	ld [hl+], a ; $72a3
	ld hl, $d800 ; $72a4
	ld de, $d0c7 ; $72a7
	call Func_38_440c ; $72aa
	pop af ; $72ad
	ldh [$ff96], a ; $72ae
	ldh [rWBK], a ; $72b0
	ret ; $72b2
Func_38_72b3:
	ldh a, [$ff96] ; $72b3
	push af ; $72b5
	ld a, $03 ; $72b6
	ldh [$ff96], a ; $72b8
	ldh [rWBK], a ; $72ba
	ld hl, $d800 ; $72bc
Label_38_72bf:
	ld a, [hl] ; $72bf
	cp a, $00 ; $72c0
	jr z, Label_38_72c7 ; $72c2
	inc hl ; $72c4
	jr Label_38_72bf ; $72c5
Label_38_72c7:
	push hl ; $72c7
	ld c, $0f ; $72c8
	call Func_38_4399 ; $72ca
	ld d, a ; $72cd
	ld hl, $71b6 ; $72ce
	ld a, $02 ; $72d1
	ldh [$ff96], a ; $72d3
	ldh [rWBK], a ; $72d5
	ld a, [$d000] ; $72d7
	or a, a ; $72da
	jr z, Label_38_72e0 ; $72db
	ld hl, $71b6 ; $72dd
Label_38_72e0:
	ld a, d ; $72e0
	add a, l ; $72e1
	ld l, a ; $72e2
	jr nc, Label_38_72e6 ; $72e3
	inc h ; $72e5
Label_38_72e6:
	ld d, [hl] ; $72e6
	ld a, d ; $72e7
	cp a, $9e ; $72e8
	jr z, Label_38_72f2 ; $72ea
	cp a, $9f ; $72ec
	jr z, Label_38_72f2 ; $72ee
	jr Label_38_72f5 ; $72f0
Label_38_72f2:
	add a, $40 ; $72f2
	ld d, a ; $72f4
Label_38_72f5:
	pop hl ; $72f5
	ld a, $03 ; $72f6
	ldh [$ff96], a ; $72f8
	ldh [rWBK], a ; $72fa
	call Func_38_7379 ; $72fc
	or a, a ; $72ff
	jr z, Label_38_7311 ; $7300
	dec hl ; $7302
	ld a, [hl] ; $7303
	cp a, $de ; $7304
	jr z, Label_38_730e ; $7306
	cp a, $df ; $7308
	jr z, Label_38_730e ; $730a
	jr Label_38_7311 ; $730c
Label_38_730e:
	ld [hl], $00 ; $730e
	dec hl ; $7310
Label_38_7311:
	ld [hl], d ; $7311
	call Func_38_728f ; $7312
	ld hl, $d0a0 ; $7315
	ld de, $98a0 ; $7318
	ld c, $04 ; $731b
	call Func_00_0480 ; $731d
	rst Rst08 ; $7320
	ld e, a ; $7321
	call Func_38_73cf ; $7322
	cp a, $07 ; $7325
	jr nz, Label_38_7333 ; $7327
	ld a, $05 ; $7329
	ld [$cb05], a ; $732b
	ld a, $0a ; $732e
	ld [$cb04], a ; $7330
Label_38_7333:
	pop af ; $7333
	ldh [$ff96], a ; $7334
	ldh [rWBK], a ; $7336
	ret ; $7338
	INCBIN "data/bank_038/d_7339.bin" ; $7339, 8 bytes
Func_38_7341:
	ldh a, [$ff96] ; $7341
	push af ; $7343
	call Func_38_73cf ; $7344
	and a, a ; $7347
	jr z, Label_38_7373 ; $7348
	ld a, $03 ; $734a
	ldh [$ff96], a ; $734c
	ldh [rWBK], a ; $734e
	ld hl, $d800 ; $7350
Label_38_7353:
	ld a, [hl+] ; $7353
	cp a, $00 ; $7354
	jr nz, Label_38_7353 ; $7356
	dec hl ; $7358
Label_38_7359:
	dec hl ; $7359
	ld a, [hl] ; $735a
	ld [hl], $00 ; $735b
	cp a, $de ; $735d
	jr z, Label_38_7359 ; $735f
	cp a, $df ; $7361
	jr z, Label_38_7359 ; $7363
	call Func_38_728f ; $7365
	ld hl, $d0a0 ; $7368
	ld de, $98a0 ; $736b
	ld c, $04 ; $736e
	call Func_00_0480 ; $7370
Label_38_7373:
	pop af ; $7373
	ldh [$ff96], a ; $7374
	ldh [rWBK], a ; $7376
	ret ; $7378
Func_38_7379:
	call Func_38_73cf ; $7379
	cp a, $07 ; $737c
	jr c, Label_38_7383 ; $737e
	ld a, $ff ; $7380
	ret ; $7382
Label_38_7383:
	xor a, a ; $7383
	ret ; $7384
	ld c, $00 ; $7385
	ld de, $3c38 ; $7387
	call Func_38_73cf ; $738a
	ld b, a ; $738d
Label_38_738e:
	push bc ; $738e
	ld a, b ; $738f
	cp a, c ; $7390
	jr nz, Label_38_7399 ; $7391
	ldh a, [$ff8c] ; $7393
	and a, $10 ; $7395
	jr z, Label_38_73a2 ; $7397
Label_38_7399:
	ld c, $10 ; $7399
	ld b, $0a ; $739b
	push de ; $739d
	call Func_00_1f51 ; $739e
	pop de ; $73a1
Label_38_73a2:
	pop bc ; $73a2
	ld a, $08 ; $73a3
	add a, d ; $73a5
	ld d, a ; $73a6
	inc c ; $73a7
	ld a, c ; $73a8
	cp a, $07 ; $73a9
	jr nz, Label_38_738e ; $73ab
	ret ; $73ad
Func_38_73ae:
	ldh a, [$ff96] ; $73ae
	push af ; $73b0
	ld a, $03 ; $73b1
	ldh [$ff96], a ; $73b3
	ldh [rWBK], a ; $73b5
	ld hl, $d80a ; $73b7
Label_38_73ba:
	ld a, [hl] ; $73ba
	cp a, $20 ; $73bb
	jr nz, Label_38_73c3 ; $73bd
	xor a, a ; $73bf
	ld [hl-], a ; $73c0
	jr Label_38_73ba ; $73c1
Label_38_73c3:
	or a, a ; $73c3
	jr nz, Label_38_73c9 ; $73c4
	dec hl ; $73c6
	jr Label_38_73ba ; $73c7
Label_38_73c9:
	pop af ; $73c9
	ldh [$ff96], a ; $73ca
	ldh [rWBK], a ; $73cc
	ret ; $73ce
Func_38_73cf:
	push bc ; $73cf
	push hl ; $73d0
	ldh a, [$ff96] ; $73d1
	push af ; $73d3
	ld a, $03 ; $73d4
	ldh [$ff96], a ; $73d6
	ldh [rWBK], a ; $73d8
	ld hl, $d800 ; $73da
	ld c, $00 ; $73dd
Label_38_73df:
	ld a, [hl+] ; $73df
	cp a, $00 ; $73e0
	jr z, Label_38_73ef ; $73e2
	cp a, $de ; $73e4
	jr z, Label_38_73df ; $73e6
	cp a, $df ; $73e8
	jr z, Label_38_73df ; $73ea
	inc c ; $73ec
	jr Label_38_73df ; $73ed
Label_38_73ef:
	ld a, c ; $73ef
	ld b, a ; $73f0
	pop af ; $73f1
	ldh [$ff96], a ; $73f2
	ldh [rWBK], a ; $73f4
	ld a, b ; $73f6
	pop hl ; $73f7
	pop bc ; $73f8
	ret ; $73f9
Func_38_73fa:
	ld a, [$cb00] ; $73fa
	or a, a ; $73fd
	jr nz, Label_38_7404 ; $73fe
	ld bc, $c900 ; $7400
	ret ; $7403
Label_38_7404:
	ld bc, $c940 ; $7404
	ret ; $7407
	INCBIN "data/bank_038/d_7408.bin" ; $7408, 3064 bytes

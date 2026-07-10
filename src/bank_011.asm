INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $11", ROMX[$4000], BANK[$11]

	ld [$0140], sp ; $4000
	ld b, h ; $4003
	ret nz ; $4004
	ld d, h ; $4005
	ld [hl+], a ; $4006
	ld l, b ; $4007
	ld e, b ; $4008
	ld b, b ; $4009
	ld [hl], c ; $400a
	ld b, b ; $400b
	ld d, $40 ; $400c
	ld l, a ; $400e
	ld b, c ; $400f
	sub a, b ; $4010
	ld b, c ; $4011
	sbc a, d ; $4012
	ld b, c ; $4013
	and a, h ; $4014
	ld b, c ; $4015
	nop ; $4016
	nop ; $4017
	xor a, c ; $4018
	ld a, e ; $4019
	nop ; $401a
	rrca ; $401b
	nop ; $401c
	ld l, $80 ; $401d
	nop ; $401f
	dec h ; $4020
	ld bc, $0000 ; $4021
	nop ; $4024
	nop ; $4025
	xor a, c ; $4026
	ld a, e ; $4027
	nop ; $4028
	dec c ; $4029
	nop ; $402a
	inc de ; $402b
	ld b, b ; $402c
	nop ; $402d
	dec h ; $402e
	ld bc, $0000 ; $402f
	nop ; $4032
	nop ; $4033
	xor a, c ; $4034
	ld a, e ; $4035
	nop ; $4036
	rra ; $4037
	nop ; $4038
	ld l, $00 ; $4039
	nop ; $403b
	add hl, sp ; $403c
	ld bc, $0007 ; $403d
	nop ; $4040
	nop ; $4041
	xor a, c ; $4042
	ld a, e ; $4043
	nop ; $4044
	ld hl, $2e00 ; $4045
	add a, b ; $4048
	nop ; $4049
	ld [hl-], a ; $404a
	ld bc, $0007 ; $404b
	nop ; $404e
	nop ; $404f
	nop ; $4050
	nop ; $4051
	nop ; $4052
	nop ; $4053
	nop ; $4054
	nop ; $4055
	nop ; $4056
	rst Rst38 ; $4057
	ld bc, $00c0 ; $4058
	inc c ; $405b
	nop ; $405c
	ld sp, $0000 ; $405d
	ld [bc], a ; $4060
	ret nz ; $4061
	nop ; $4062
	inc h ; $4063
	nop ; $4064
	ld sp, $0000 ; $4065
	rrca ; $4068
	ret nz ; $4069
	nop ; $406a
	inc c ; $406b
	nop ; $406c
	ld sp, $0000 ; $406d
	rst Rst38 ; $4070
	ld bc, $00ff ; $4071
	nop ; $4074
	pop de ; $4075
	ld a, e ; $4076
	add hl, de ; $4077
	ld bc, rSC ; $4078
	nop ; $407b
	nop ; $407c
	pop de ; $407d
	ld a, e ; $407e
	add hl, de ; $407f
	ld [bc], a ; $4080
	rst Rst38 ; $4081
	ld hl, $2450 ; $4082
	rst Rst18 ; $4085
	ld c, $0a ; $4086
	rst Rst30 ; $4088
	ldh [rTIMA], a ; $4089
	jr nz, Label_11_409c ; $408b
	ld a, [$c2b0] ; $408d
	cp a, $03 ; $4090
	jr nz, Label_11_40a9 ; $4092
	ld hl, $245b ; $4094
	rst Rst18 ; $4097
	ld c, $0a ; $4098
	jr Label_11_40a9 ; $409a
Label_11_409c:
	ld a, [$c2b0] ; $409c
	cp a, $06 ; $409f
	jr nz, Label_11_40a9 ; $40a1
	ld hl, $245b ; $40a3
	rst Rst18 ; $40a6
	ld c, $0a ; $40a7
Label_11_40a9:
	ld a, $03 ; $40a9
	rst Rst18 ; $40ab
	ld [$c90a], sp ; $40ac
	rst Rst30 ; $40af
	ldh [rTIMA], a ; $40b0
	jr z, Label_11_40c9 ; $40b2
	ld hl, $2460 ; $40b4
	rst Rst18 ; $40b7
	ld c, $0a ; $40b8
	ld a, [$c2b0] ; $40ba
	cp a, $06 ; $40bd
	jr nz, Label_11_40fa ; $40bf
	ld hl, $2465 ; $40c1
	rst Rst18 ; $40c4
	ld c, $0a ; $40c5
	jr Label_11_40fa ; $40c7
Label_11_40c9:
	ld hl, $2451 ; $40c9
	rst Rst18 ; $40cc
	ld c, $0a ; $40cd
	ld a, $04 ; $40cf
	rst Rst18 ; $40d1
	ld a, [bc] ; $40d2
	ld a, [bc] ; $40d3
	rst Rst18 ; $40d4
	ld [de], a ; $40d5
	ld a, [bc] ; $40d6
	rst Rst18 ; $40d7
	inc c ; $40d8
	ld a, [bc] ; $40d9
	push af ; $40da
	ld a, $05 ; $40db
	rst Rst18 ; $40dd
	inc b ; $40de
	ld a, [bc] ; $40df
	pop af ; $40e0
	and a, a ; $40e1
	jr z, Label_11_40ed ; $40e2
	rst Rst18 ; $40e4
	INCBIN "data/bank_011/d_40e5.bin" ; $40e5, 8 bytes
Label_11_40ed:
	ld a, [$c2b0] ; $40ed
	cp a, $03 ; $40f0
	jr nz, Label_11_40fa ; $40f2
	rst Rst18 ; $40f4
	INCBIN "data/bank_011/d_40f5.bin" ; $40f5, 5 bytes
Label_11_40fa:
	ld a, $04 ; $40fa
	rst Rst18 ; $40fc
	ld [$c90a], sp ; $40fd
	ld a, [$c2b0] ; $4100
	add a, a ; $4103
	add a, $3c ; $4104
	ld l, a ; $4106
	adc a, $41 ; $4107
	sub a, l ; $4109
	ld h, a ; $410a
	ld a, [hl+] ; $410b
	ld h, [hl] ; $410c
	ld l, a ; $410d
	rst Rst18 ; $410e
	ld c, $0a ; $410f
	ld a, [$c2b0] ; $4111
	cp a, $03 ; $4114
	jr z, Label_11_411e ; $4116
	ld a, $05 ; $4118
	rst Rst18 ; $411a
	ld [$c90a], sp ; $411b
Label_11_411e:
	ld a, $05 ; $411e
	rst Rst18 ; $4120
	ld a, [bc] ; $4121
	ld a, [bc] ; $4122
	rst Rst18 ; $4123
	ld [de], a ; $4124
	ld a, [bc] ; $4125
	rst Rst18 ; $4126
	inc c ; $4127
	ld a, [bc] ; $4128
	push af ; $4129
	ld a, $05 ; $412a
	rst Rst18 ; $412c
	inc b ; $412d
	ld a, [bc] ; $412e
	pop af ; $412f
	and a, a ; $4130
	jr z, Label_11_4136 ; $4131
	rst Rst18 ; $4133
	INCBIN "data/bank_011/d_4134.bin" ; $4134, 2 bytes
Label_11_4136:
	ld a, $05 ; $4136
	rst Rst18 ; $4138
	ld [$c90a], sp ; $4139
	ld d, l ; $413c
	inc h ; $413d
	ld d, a ; $413e
	inc h ; $413f
	ld e, c ; $4140
	inc h ; $4141
	ld e, h ; $4142
	inc h ; $4143
	ld h, c ; $4144
	inc h ; $4145
	ld h, e ; $4146
	inc h ; $4147
	ld h, [hl] ; $4148
	inc h ; $4149
	ld a, [$c2b0] ; $414a
	add a, a ; $414d
	add a, $61 ; $414e
	ld l, a ; $4150
	adc a, $41 ; $4151
	sub a, l ; $4153
	ld h, a ; $4154
	ld a, [hl+] ; $4155
	ld h, [hl] ; $4156
	ld l, a ; $4157
	rst Rst18 ; $4158
	ld c, $0a ; $4159
	ld a, $05 ; $415b
	rst Rst18 ; $415d
	ld [$c90a], sp ; $415e
	ld d, [hl] ; $4161
	inc h ; $4162
	ld e, b ; $4163
	inc h ; $4164
	ld e, d ; $4165
	inc h ; $4166
	ld e, a ; $4167
	inc h ; $4168
	ld h, d ; $4169
	inc h ; $416a
	ld h, h ; $416b
	inc h ; $416c
	ld h, a ; $416d
	inc h ; $416e
	inc bc ; $416f
	rst Rst38 ; $4170
	nop ; $4171
	nop ; $4172
	add a, d ; $4173
	ld b, b ; $4174
	inc bc ; $4175
	nop ; $4176
	inc b ; $4177
	rst Rst38 ; $4178
	nop ; $4179
	nop ; $417a
	xor a, a ; $417b
	ld b, b ; $417c
	inc bc ; $417d
	nop ; $417e
	dec b ; $417f
	rst Rst38 ; $4180
	nop ; $4181
	nop ; $4182
	nop ; $4183
	ld b, c ; $4184
	inc bc ; $4185
	nop ; $4186
	ld b, $ff ; $4187
	nop ; $4189
	nop ; $418a
	ld c, d ; $418b
	ld b, c ; $418c
	inc bc ; $418d
	nop ; $418e
	rst Rst38 ; $418f
	ld bc, $00ff ; $4190
	nop ; $4193
	sbc a, c ; $4194
	ld b, c ; $4195
	nop ; $4196
	nop ; $4197
	rst Rst38 ; $4198
	ret ; $4199
	INCBIN "data/bank_011/d_419a.bin" ; $419a, 1303 bytes
	call Func_11_7d95 ; $46b1
	call Func_11_5482 ; $46b4
	call Func_11_54a6 ; $46b7
	ld a, [$c295] ; $46ba
	cp a, $0a ; $46bd
	jp z, Label_11_4fcf ; $46bf
	cp a, $0c ; $46c2
	jp z, Label_11_53db ; $46c4
	cp a, $0f ; $46c7
	jr nz, Label_11_46ce ; $46c9
	call Func_11_46cf ; $46cb
Label_11_46ce:
	ret ; $46ce
Func_11_46cf:
	ld a, $00 ; $46cf
	ld bc, $0010 ; $46d1
	rst Rst18 ; $46d4
	jr $46e1 ; $46d5
	xor a, a ; $46d7
	ld [$c2d5], a ; $46d8
	ld a, $11 ; $46db
	ld bc, $1800 ; $46dd
	ld de, $0d00 ; $46e0
	rst Rst18 ; $46e3
	ld [hl+], a ; $46e4
	ld a, [bc] ; $46e5
	ld a, $00 ; $46e6
	ld bc, $1800 ; $46e8
	ld de, $3700 ; $46eb
	rst Rst18 ; $46ee
	ld [hl+], a ; $46ef
	ld a, [bc] ; $46f0
	ld a, $14 ; $46f1
	ld bc, $3f00 ; $46f3
	ld de, $3f00 ; $46f6
	rst Rst18 ; $46f9
	ld [hl+], a ; $46fa
	ld a, [bc] ; $46fb
	ld a, $03 ; $46fc
	ld bc, $2280 ; $46fe
	ld de, $1500 ; $4701
	rst Rst18 ; $4704
	ld [hl+], a ; $4705
	ld a, [bc] ; $4706
	ld a, $03 ; $4707
	ld b, $00 ; $4709
	rst Rst18 ; $470b
	ld l, $0a ; $470c
	ld a, $04 ; $470e
	ld bc, $3300 ; $4710
	ld de, $1500 ; $4713
	rst Rst18 ; $4716
	ld [hl+], a ; $4717
	ld a, [bc] ; $4718
	ld a, $05 ; $4719
	ld bc, $3300 ; $471b
	ld de, $1500 ; $471e
	rst Rst18 ; $4721
	ld [hl+], a ; $4722
	ld a, [bc] ; $4723
	ld c, $04 ; $4724
	call Func_00_1d2e ; $4726
	call Func_00_1da4 ; $4729
	ld a, $00 ; $472c
	ld bc, $1800 ; $472e
	ld de, $2d00 ; $4731
	rst Rst18 ; $4734
	inc h ; $4735
	ld a, [bc] ; $4736
	ld a, $00 ; $4737
	rst Rst18 ; $4739
	jr nz, Label_11_4746 ; $473a
	ld a, $00 ; $473c
	ld b, $00 ; $473e
	rst Rst18 ; $4740
	ld l, $0a ; $4741
	push af ; $4743
	ld a, $28 ; $4744
Label_11_4746:
	rst Rst18 ; $4746
	inc b ; $4747
	ld a, [bc] ; $4748
	pop af ; $4749
	ld a, $00 ; $474a
	ld b, $c0 ; $474c
	rst Rst18 ; $474e
	ld l, $0a ; $474f
	push af ; $4751
	ld a, $28 ; $4752
	rst Rst18 ; $4754
	inc b ; $4755
	ld a, [bc] ; $4756
	pop af ; $4757
	ld a, $00 ; $4758
	ld b, $80 ; $475a
	rst Rst18 ; $475c
	ld l, $0a ; $475d
	push af ; $475f
	ld a, $28 ; $4760
	rst Rst18 ; $4762
	inc b ; $4763
	ld a, [bc] ; $4764
	pop af ; $4765
	ld a, $00 ; $4766
	ld b, $c0 ; $4768
	rst Rst18 ; $476a
	ld l, $0a ; $476b
	push af ; $476d
	ld a, $28 ; $476e
	rst Rst18 ; $4770
	inc b ; $4771
	ld a, [bc] ; $4772
	pop af ; $4773
	ld a, $00 ; $4774
	ld b, $00 ; $4776
	rst Rst18 ; $4778
	ld l, $0a ; $4779
	push af ; $477b
	ld a, $0a ; $477c
	rst Rst18 ; $477e
	inc b ; $477f
	ld a, [bc] ; $4780
	pop af ; $4781
	ld a, $00 ; $4782
	ld b, $40 ; $4784
	rst Rst18 ; $4786
	ld l, $0a ; $4787
	push af ; $4789
	ld a, $3c ; $478a
	rst Rst18 ; $478c
	inc b ; $478d
	ld a, [bc] ; $478e
	pop af ; $478f
	ld a, $00 ; $4790
	ld d, $03 ; $4792
	rst Rst18 ; $4794
	inc [hl] ; $4795
	ld a, [bc] ; $4796
	ld a, $00 ; $4797
	rst Rst18 ; $4799
	ld [hl], $0a ; $479a
	push af ; $479c
	ld a, $3c ; $479d
	rst Rst18 ; $479f
	inc b ; $47a0
	ld a, [bc] ; $47a1
	pop af ; $47a2
	ld a, $00 ; $47a3
	ld bc, $1800 ; $47a5
	ld de, $2100 ; $47a8
	rst Rst18 ; $47ab
	inc h ; $47ac
	ld a, [bc] ; $47ad
	ld bc, $0040 ; $47ae
	rst Rst18 ; $47b1
	jr c, Label_11_47be ; $47b2
	xor a, a ; $47b4
	ld bc, $1800 ; $47b5
	ld de, $1200 ; $47b8
	rst Rst18 ; $47bb
	ld a, [hl-] ; $47bc
	ld a, [bc] ; $47bd
Label_11_47be:
	rst Rst18 ; $47be
	ld a, $0a ; $47bf
	push af ; $47c1
	ld a, $3c ; $47c2
	rst Rst18 ; $47c4
	inc b ; $47c5
	ld a, [bc] ; $47c6
	pop af ; $47c7
	ld a, $00 ; $47c8
	ld bc, $1800 ; $47ca
	ld de, $2000 ; $47cd
	rst Rst18 ; $47d0
	ld [hl+], a ; $47d1
	ld a, [bc] ; $47d2
	ld a, $00 ; $47d3
	ld b, $c0 ; $47d5
	rst Rst18 ; $47d7
	ld l, $0a ; $47d8
	ld a, $11 ; $47da
	ld bc, $0024 ; $47dc
	rst Rst18 ; $47df
	jr Label_11_47ec ; $47e0
	ld a, $11 ; $47e2
	ld bc, $1800 ; $47e4
	ld de, $1400 ; $47e7
	rst Rst18 ; $47ea
	inc h ; $47eb
Label_11_47ec:
	ld a, [bc] ; $47ec
	ld a, $11 ; $47ed
	rst Rst18 ; $47ef
	jr nz, Label_11_47fc ; $47f0
	ld a, $11 ; $47f2
	ld d, $04 ; $47f4
	rst Rst18 ; $47f6
	inc [hl] ; $47f7
	ld a, [bc] ; $47f8
	ld a, $11 ; $47f9
	rst Rst18 ; $47fb
Label_11_47fc:
	ld [hl], $0a ; $47fc
	ld a, $11 ; $47fe
	ld b, $c0 ; $4800
	rst Rst18 ; $4802
	ld l, $0a ; $4803
	ld hl, $184f ; $4805
	rst Rst18 ; $4808
	ld c, $0a ; $4809
	ld a, $11 ; $480b
	rst Rst18 ; $480d
	INCBIN "data/bank_011/d_480e.bin" ; $480e, 2 bytes
	ld a, $11 ; $4810
	ld d, $03 ; $4812
	rst Rst18 ; $4814
	inc [hl] ; $4815
	ld a, [bc] ; $4816
	ld a, $11 ; $4817
	rst Rst18 ; $4819
	ld [hl], $0a ; $481a
	ld a, $11 ; $481c
	ld bc, $0020 ; $481e
	rst Rst18 ; $4821
	jr Label_11_482e ; $4822
	ld a, $11 ; $4824
	rst Rst18 ; $4826
	INCBIN "data/bank_011/d_4827.bin" ; $4827, 2 bytes
	ld a, $11 ; $4829
	ld b, $40 ; $482b
	rst Rst18 ; $482d
Label_11_482e:
	ld l, $0a ; $482e
	ld a, $11 ; $4830
	ld de, $ff80 ; $4832
	rst Rst18 ; $4835
	ld b, d ; $4836
	ld a, [bc] ; $4837
	ld a, $11 ; $4838
	rst Rst18 ; $483a
	ld b, h ; $483b
	ld a, [bc] ; $483c
	ld a, $11 ; $483d
	ld bc, $1800 ; $483f
	ld de, $1700 ; $4842
	rst Rst18 ; $4845
	inc h ; $4846
	ld a, [bc] ; $4847
	ld a, $11 ; $4848
	rst Rst18 ; $484a
	jr nz, Label_11_4857 ; $484b
	ld a, $0e ; $484d
	ld bc, $1980 ; $484f
	ld de, $15c0 ; $4852
	rst Rst18 ; $4855
	ld [hl+], a ; $4856
Label_11_4857:
	ld a, [bc] ; $4857
	rst Rst08 ; $4858
	sbc a, b ; $4859
	ld a, $11 ; $485a
	ld bc, $0010 ; $485c
	rst Rst18 ; $485f
	jr Label_11_486c ; $4860
	ld a, $0e ; $4862
	ld bc, $0010 ; $4864
	rst Rst18 ; $4867
	jr Label_11_4874 ; $4868
	ld a, $0e ; $486a
Label_11_486c:
	ld bc, $1980 ; $486c
	ld de, $18c0 ; $486f
	rst Rst18 ; $4872
	inc h ; $4873
Label_11_4874:
	ld a, [bc] ; $4874
	ld a, $11 ; $4875
	ld bc, $1800 ; $4877
	ld de, $1a00 ; $487a
	rst Rst18 ; $487d
	inc h ; $487e
	ld a, [bc] ; $487f
	ld a, $11 ; $4880
	rst Rst18 ; $4882
	jr nz, Label_11_488f ; $4883
	ld a, $11 ; $4885
	rst Rst18 ; $4887
	INCBIN "data/bank_011/d_4888.bin" ; $4888, 2 bytes
	ld a, $0e ; $488a
	ld bc, $3f00 ; $488c
Label_11_488f:
	ld de, $3f00 ; $488f
	rst Rst18 ; $4892
	ld [hl+], a ; $4893
	ld a, [bc] ; $4894
	ld a, $11 ; $4895
	ld bc, $1800 ; $4897
	ld de, $1600 ; $489a
	rst Rst18 ; $489d
	inc h ; $489e
	ld a, [bc] ; $489f
	ld a, $11 ; $48a0
	rst Rst18 ; $48a2
	jr nz, $48af ; $48a3
	push af ; $48a5
	ld a, $1e ; $48a6
	rst Rst18 ; $48a8
	inc b ; $48a9
	ld a, [bc] ; $48aa
	pop af ; $48ab
	ld a, $11 ; $48ac
	ld d, $02 ; $48ae
	rst Rst18 ; $48b0
	inc [hl] ; $48b1
	ld a, [bc] ; $48b2
	ld a, $0f ; $48b3
	ld bc, $1980 ; $48b5
	ld de, $14c0 ; $48b8
	rst Rst18 ; $48bb
	ld [hl+], a ; $48bc
	ld a, [bc] ; $48bd
	rst Rst08 ; $48be
	sub a, a ; $48bf
	push af ; $48c0
	ld a, $14 ; $48c1
	rst Rst18 ; $48c3
	inc b ; $48c4
	ld a, [bc] ; $48c5
	pop af ; $48c6
	ld a, $11 ; $48c7
	rst Rst18 ; $48c9
	INCBIN "data/bank_011/d_48ca.bin" ; $48ca, 2 bytes
	ld a, $0f ; $48cc
	ld bc, $3f00 ; $48ce
	ld de, $3f00 ; $48d1
	rst Rst18 ; $48d4
	ld [hl+], a ; $48d5
	ld a, [bc] ; $48d6
	ld a, $11 ; $48d7
	ld bc, $0020 ; $48d9
	rst Rst18 ; $48dc
	jr Label_11_48e9 ; $48dd
	ld a, $11 ; $48df
	ld de, $ff80 ; $48e1
	rst Rst18 ; $48e4
	ld b, d ; $48e5
	ld a, [bc] ; $48e6
	ld a, $11 ; $48e7
Label_11_48e9:
	rst Rst18 ; $48e9
	ld b, h ; $48ea
	ld a, [bc] ; $48eb
	ld a, $11 ; $48ec
	ld bc, $1800 ; $48ee
	ld de, $2000 ; $48f1
	rst Rst18 ; $48f4
	inc h ; $48f5
	ld a, [bc] ; $48f6
	push af ; $48f7
	ld a, $1e ; $48f8
	rst Rst18 ; $48fa
	inc b ; $48fb
	ld a, [bc] ; $48fc
	pop af ; $48fd
	ld bc, $d040 ; $48fe
	ld a, $11 ; $4901
	rst Rst18 ; $4903
	ld d, $0a ; $4904
	ld e, l ; $4906
	ld d, h ; $4907
	rst Rst18 ; $4908
	ld e, $04 ; $4909
	ld a, $00 ; $490b
	ld bc, $1800 ; $490d
	ld de, $1e00 ; $4910
	rst Rst18 ; $4913
	inc h ; $4914
	ld a, [bc] ; $4915
	push af ; $4916
	ld a, $14 ; $4917
	rst Rst18 ; $4919
	inc b ; $491a
	ld a, [bc] ; $491b
	pop af ; $491c
	call Func_11_4cf6 ; $491d
	ld a, $11 ; $4920
	rst Rst18 ; $4922
	jr nz, $492f ; $4923
	ld a, $11 ; $4925
	ld d, $02 ; $4927
	rst Rst18 ; $4929
	inc [hl] ; $492a
	ld a, [bc] ; $492b
	ld a, $10 ; $492c
	ld bc, $1900 ; $492e
	ld de, $1e00 ; $4931
	rst Rst18 ; $4934
	ld [hl+], a ; $4935
	ld a, [bc] ; $4936
	rst Rst08 ; $4937
	sub a, [hl] ; $4938
	push af ; $4939
	ld a, $3c ; $493a
	rst Rst18 ; $493c
	inc b ; $493d
	ld a, [bc] ; $493e
	pop af ; $493f
	ld a, $10 ; $4940
	ld bc, $3f00 ; $4942
	ld de, $3f00 ; $4945
	rst Rst18 ; $4948
	ld [hl+], a ; $4949
	ld a, [bc] ; $494a
	ld a, $11 ; $494b
	ld bc, $1700 ; $494d
	ld de, $2200 ; $4950
	rst Rst18 ; $4953
	inc h ; $4954
	ld a, [bc] ; $4955
	ld a, $11 ; $4956
	rst Rst18 ; $4958
	jr nz, Label_11_4965 ; $4959
	ld a, $00 ; $495b
	ld b, a ; $495d
	ld a, $11 ; $495e
	rst Rst18 ; $4960
	jr nc, Label_11_496d ; $4961
	ld a, $11 ; $4963
Label_11_4965:
	rst Rst18 ; $4965
	INCBIN "data/bank_011/d_4966.bin" ; $4966, 2 bytes
	ld a, $11 ; $4968
	ld bc, $1900 ; $496a
Label_11_496d:
	ld de, $2400 ; $496d
	rst Rst18 ; $4970
	inc h ; $4971
	ld a, [bc] ; $4972
	ld a, $11 ; $4973
	rst Rst18 ; $4975
	jr nz, Label_11_4982 ; $4976
	ld a, $01 ; $4978
	rst Rst18 ; $497a
	inc e ; $497b
	ld a, [bc] ; $497c
	ld a, $00 ; $497d
	ld b, a ; $497f
	ld a, $11 ; $4980
Label_11_4982:
	rst Rst18 ; $4982
	jr nc, Label_11_498f ; $4983
	ld a, $11 ; $4985
	ld d, $02 ; $4987
	rst Rst18 ; $4989
	inc [hl] ; $498a
	ld a, [bc] ; $498b
	ld a, $11 ; $498c
	rst Rst18 ; $498e
Label_11_498f:
	ld [hl], $0a ; $498f
	ld a, $11 ; $4991
	rst Rst18 ; $4993
	INCBIN "data/bank_011/d_4994.bin" ; $4994, 2 bytes
	ld a, $13 ; $4996
	ld bc, $1a80 ; $4998
	ld de, $2280 ; $499b
	rst Rst18 ; $499e
	ld [hl+], a ; $499f
	ld a, [bc] ; $49a0
	push af ; $49a1
	ld a, $3c ; $49a2
	rst Rst18 ; $49a4
	inc b ; $49a5
	ld a, [bc] ; $49a6
	pop af ; $49a7
	ld a, $13 ; $49a8
	ld bc, $3f00 ; $49aa
	ld de, $3f00 ; $49ad
	rst Rst18 ; $49b0
	ld [hl+], a ; $49b1
	ld a, [bc] ; $49b2
	ld a, $11 ; $49b3
	ld bc, $1900 ; $49b5
	ld de, $2300 ; $49b8
	rst Rst18 ; $49bb
	inc h ; $49bc
	ld a, [bc] ; $49bd
	ld a, $11 ; $49be
	rst Rst18 ; $49c0
	jr nz, Label_11_49cd ; $49c1
	ld a, $11 ; $49c3
	ld bc, $1a00 ; $49c5
	ld de, $2300 ; $49c8
	rst Rst18 ; $49cb
	inc h ; $49cc
Label_11_49cd:
	ld a, [bc] ; $49cd
	ld a, $11 ; $49ce
	rst Rst18 ; $49d0
	jr nz, Label_11_49dd ; $49d1
	ld a, $11 ; $49d3
	ld bc, $1a00 ; $49d5
	ld de, $2400 ; $49d8
	rst Rst18 ; $49db
	inc h ; $49dc
Label_11_49dd:
	ld a, [bc] ; $49dd
	ld a, $11 ; $49de
	rst Rst18 ; $49e0
	jr nz, Label_11_49ed ; $49e1
	ld a, $11 ; $49e3
	ld bc, $1900 ; $49e5
	ld de, $2400 ; $49e8
	rst Rst18 ; $49eb
	inc h ; $49ec
Label_11_49ed:
	ld a, [bc] ; $49ed
	ld a, $11 ; $49ee
	rst Rst18 ; $49f0
	jr nz, Label_11_49fd ; $49f1
	ld a, $11 ; $49f3
	ld bc, $1900 ; $49f5
	ld de, $2500 ; $49f8
	rst Rst18 ; $49fb
	inc h ; $49fc
Label_11_49fd:
	ld a, [bc] ; $49fd
	ld a, $11 ; $49fe
	rst Rst18 ; $4a00
	jr nz, Label_11_4a0d ; $4a01
	ld a, $11 ; $4a03
	ld bc, $1a00 ; $4a05
	ld de, $2500 ; $4a08
	rst Rst18 ; $4a0b
	inc h ; $4a0c
Label_11_4a0d:
	ld a, [bc] ; $4a0d
	ld a, $11 ; $4a0e
	rst Rst18 ; $4a10
	jr nz, Label_11_4a1d ; $4a11
	ld a, $11 ; $4a13
	ld bc, $1a00 ; $4a15
	ld de, $2400 ; $4a18
	rst Rst18 ; $4a1b
	inc h ; $4a1c
Label_11_4a1d:
	ld a, [bc] ; $4a1d
	ld a, $11 ; $4a1e
	rst Rst18 ; $4a20
	jr nz, Label_11_4a2d ; $4a21
	ld a, $11 ; $4a23
	ld bc, $1900 ; $4a25
	ld de, $2400 ; $4a28
	rst Rst18 ; $4a2b
	inc h ; $4a2c
Label_11_4a2d:
	ld a, [bc] ; $4a2d
	ld a, $11 ; $4a2e
	rst Rst18 ; $4a30
	jr nz, $4a3d ; $4a31
	ld a, $00 ; $4a33
	ld b, a ; $4a35
	ld a, $11 ; $4a36
	rst Rst18 ; $4a38
	jr nc, $4a45 ; $4a39
	push af ; $4a3b
	ld a, $3c ; $4a3c
	rst Rst18 ; $4a3e
	inc b ; $4a3f
	ld a, [bc] ; $4a40
	pop af ; $4a41
	ld a, $11 ; $4a42
	ld d, $02 ; $4a44
	rst Rst18 ; $4a46
	inc [hl] ; $4a47
	ld a, [bc] ; $4a48
	ld a, $11 ; $4a49
	rst Rst18 ; $4a4b
	ld [hl], $0a ; $4a4c
	ld a, $11 ; $4a4e
	rst Rst18 ; $4a50
	INCBIN "data/bank_011/d_4a51.bin" ; $4a51, 2 bytes
	call Func_11_4d68 ; $4a53
	ld a, $11 ; $4a56
	ld b, $01 ; $4a58
	rst Rst18 ; $4a5a
	inc l ; $4a5b
	ld a, [bc] ; $4a5c
	ld a, $11 ; $4a5d
	ld d, $05 ; $4a5f
	rst Rst18 ; $4a61
	inc [hl] ; $4a62
	ld a, [bc] ; $4a63
	push af ; $4a64
	ld a, $14 ; $4a65
	rst Rst18 ; $4a67
	inc b ; $4a68
	ld a, [bc] ; $4a69
	pop af ; $4a6a
	ld a, $11 ; $4a6b
	ld de, $ff80 ; $4a6d
	rst Rst18 ; $4a70
	ld b, d ; $4a71
	ld a, [bc] ; $4a72
	ld a, $11 ; $4a73
	ld bc, $1b00 ; $4a75
	ld de, $2400 ; $4a78
	rst Rst18 ; $4a7b
	inc h ; $4a7c
	ld a, [bc] ; $4a7d
	push af ; $4a7e
	ld a, $14 ; $4a7f
	rst Rst18 ; $4a81
	inc b ; $4a82
	ld a, [bc] ; $4a83
	pop af ; $4a84
	ld a, $11 ; $4a85
	ld b, a ; $4a87
	ld a, $00 ; $4a88
	rst Rst18 ; $4a8a
	jr nc, $4a97 ; $4a8b
	push af ; $4a8d
	ld a, $14 ; $4a8e
	rst Rst18 ; $4a90
	inc b ; $4a91
	ld a, [bc] ; $4a92
	pop af ; $4a93
	ld a, $00 ; $4a94
	ld d, $02 ; $4a96
	rst Rst18 ; $4a98
	inc [hl] ; $4a99
	ld a, [bc] ; $4a9a
	ld a, $00 ; $4a9b
	rst Rst18 ; $4a9d
	ld [hl], $0a ; $4a9e
	ld a, $11 ; $4aa0
	ld d, $02 ; $4aa2
	rst Rst18 ; $4aa4
	inc [hl] ; $4aa5
	ld a, [bc] ; $4aa6
	ld a, $11 ; $4aa7
	rst Rst18 ; $4aa9
	ld [hl], $0a ; $4aaa
	ld a, $00 ; $4aac
	ld b, a ; $4aae
	ld a, $11 ; $4aaf
	rst Rst18 ; $4ab1
	jr nc, Label_11_4abe ; $4ab2
	ld a, $11 ; $4ab4
	ld bc, $1a00 ; $4ab6
	ld de, $2400 ; $4ab9
	rst Rst18 ; $4abc
	inc h ; $4abd
Label_11_4abe:
	ld a, [bc] ; $4abe
	ld a, $11 ; $4abf
	rst Rst18 ; $4ac1
	jr nz, $4ace ; $4ac2
	ld a, $11 ; $4ac4
	ld b, $00 ; $4ac6
	rst Rst18 ; $4ac8
	inc l ; $4ac9
	ld a, [bc] ; $4aca
	ld a, $00 ; $4acb
	ld d, $02 ; $4acd
	rst Rst18 ; $4acf
	inc [hl] ; $4ad0
	ld a, [bc] ; $4ad1
	ld a, $00 ; $4ad2
	rst Rst18 ; $4ad4
	ld [hl], $0a ; $4ad5
	ld a, $11 ; $4ad7
	ld d, $02 ; $4ad9
	rst Rst18 ; $4adb
	inc [hl] ; $4adc
	ld a, [bc] ; $4add
	ld a, $11 ; $4ade
	rst Rst18 ; $4ae0
	ld [hl], $0a ; $4ae1
	ld a, $11 ; $4ae3
	rst Rst18 ; $4ae5
	INCBIN "data/bank_011/d_4ae6.bin" ; $4ae6, 2 bytes
	ld a, $11 ; $4ae8
	ld d, $02 ; $4aea
	rst Rst18 ; $4aec
	inc [hl] ; $4aed
	ld a, [bc] ; $4aee
	ld a, $11 ; $4aef
	rst Rst18 ; $4af1
	ld [hl], $0a ; $4af2
	ld hl, $1857 ; $4af4
	rst Rst18 ; $4af7
	ld c, $0a ; $4af8
	ld a, $11 ; $4afa
	rst Rst18 ; $4afc
	ld a, [bc] ; $4afd
	ld a, [bc] ; $4afe
	rst Rst18 ; $4aff
	ld [de], a ; $4b00
	ld a, [bc] ; $4b01
	rst Rst18 ; $4b02
	inc c ; $4b03
	ld a, [bc] ; $4b04
	push af ; $4b05
	ld a, $05 ; $4b06
	rst Rst18 ; $4b08
	inc b ; $4b09
	ld a, [bc] ; $4b0a
	pop af ; $4b0b
	and a, a ; $4b0c
	jr z, Label_11_4b1d ; $4b0d
	ld a, $11 ; $4b0f
	ld d, $02 ; $4b11
	rst Rst18 ; $4b13
	inc [hl] ; $4b14
	ld a, [bc] ; $4b15
	ld a, $11 ; $4b16
	rst Rst18 ; $4b18
	ld [$180a], sp ; $4b19
	rst Rst10 ; $4b1c
Label_11_4b1d:
	ld hl, $1859 ; $4b1d
	rst Rst18 ; $4b20
	ld c, $0a ; $4b21
	ld a, $11 ; $4b23
	ld d, $03 ; $4b25
	rst Rst18 ; $4b27
	inc [hl] ; $4b28
	ld a, [bc] ; $4b29
	ld a, $11 ; $4b2a
	rst Rst18 ; $4b2c
	ld [hl], $0a ; $4b2d
	ld a, $11 ; $4b2f
	rst Rst18 ; $4b31
	INCBIN "data/bank_011/d_4b32.bin" ; $4b32, 2 bytes
	push af ; $4b34
	ld a, $3c ; $4b35
	rst Rst18 ; $4b37
	inc b ; $4b38
	ld a, [bc] ; $4b39
	pop af ; $4b3a
	ld a, $0e ; $4b3b
	ld bc, $1b80 ; $4b3d
	ld de, $21c0 ; $4b40
	rst Rst18 ; $4b43
	ld [hl+], a ; $4b44
	ld a, [bc] ; $4b45
	rst Rst08 ; $4b46
	sbc a, b ; $4b47
	push af ; $4b48
	ld a, $28 ; $4b49
	rst Rst18 ; $4b4b
	inc b ; $4b4c
	ld a, [bc] ; $4b4d
	pop af ; $4b4e
	ld a, $0e ; $4b4f
	ld bc, $3f00 ; $4b51
	ld de, $3f00 ; $4b54
	rst Rst18 ; $4b57
	ld [hl+], a ; $4b58
	ld a, [bc] ; $4b59
	ld a, $11 ; $4b5a
	ld b, $80 ; $4b5c
	ld de, $0100 ; $4b5e
	rst Rst18 ; $4b61
	ld a, [hl+] ; $4b62
	ld a, [bc] ; $4b63
	ld a, $11 ; $4b64
	rst Rst18 ; $4b66
	jr nz, Label_11_4b73 ; $4b67
	ld a, $11 ; $4b69
	rst Rst18 ; $4b6b
	INCBIN "data/bank_011/d_4b6c.bin" ; $4b6c, 2 bytes
	ld a, $00 ; $4b6e
	ld d, $03 ; $4b70
	rst Rst18 ; $4b72
Label_11_4b73:
	inc [hl] ; $4b73
	ld a, [bc] ; $4b74
	ld a, $00 ; $4b75
	rst Rst18 ; $4b77
	ld [hl], $0a ; $4b78
	ld a, $0e ; $4b7a
	ld bc, $1a80 ; $4b7c
	ld de, $21c0 ; $4b7f
	rst Rst18 ; $4b82
	ld [hl+], a ; $4b83
	ld a, [bc] ; $4b84
	push af ; $4b85
	ld a, $3c ; $4b86
	rst Rst18 ; $4b88
	inc b ; $4b89
	ld a, [bc] ; $4b8a
	pop af ; $4b8b
	ld a, $0e ; $4b8c
	ld bc, $3f00 ; $4b8e
	ld de, $3f00 ; $4b91
	rst Rst18 ; $4b94
	ld [hl+], a ; $4b95
	ld a, [bc] ; $4b96
	push af ; $4b97
	ld a, $3c ; $4b98
	rst Rst18 ; $4b9a
	inc b ; $4b9b
	ld a, [bc] ; $4b9c
	pop af ; $4b9d
	ld a, $0f ; $4b9e
	ld bc, $1a80 ; $4ba0
	ld de, $21c0 ; $4ba3
	rst Rst18 ; $4ba6
	ld [hl+], a ; $4ba7
	ld a, [bc] ; $4ba8
	rst Rst08 ; $4ba9
	sub a, a ; $4baa
	ld a, $11 ; $4bab
	ld de, $ff80 ; $4bad
	rst Rst18 ; $4bb0
	ld b, d ; $4bb1
	ld a, [bc] ; $4bb2
	ld a, $11 ; $4bb3
	rst Rst18 ; $4bb5
	ld b, h ; $4bb6
	ld a, [bc] ; $4bb7
	push af ; $4bb8
	ld a, $0a ; $4bb9
	rst Rst18 ; $4bbb
	inc b ; $4bbc
	ld a, [bc] ; $4bbd
	pop af ; $4bbe
	ld a, $0f ; $4bbf
	ld bc, $3f00 ; $4bc1
	ld de, $3f00 ; $4bc4
	rst Rst18 ; $4bc7
	ld [hl+], a ; $4bc8
	ld a, [bc] ; $4bc9
	ld a, $11 ; $4bca
	rst Rst18 ; $4bcc
	INCBIN "data/bank_011/d_4bcd.bin" ; $4bcd, 2 bytes
	ld a, $11 ; $4bcf
	ld d, $02 ; $4bd1
	rst Rst18 ; $4bd3
	inc [hl] ; $4bd4
	ld a, [bc] ; $4bd5
	ld a, $11 ; $4bd6
	rst Rst18 ; $4bd8
	ld [hl], $0a ; $4bd9
	ld a, $11 ; $4bdb
	rst Rst18 ; $4bdd
	INCBIN "data/bank_011/d_4bde.bin" ; $4bde, 2 bytes
	ld a, $00 ; $4be0
	ld d, $03 ; $4be2
	rst Rst18 ; $4be4
	inc [hl] ; $4be5
	ld a, [bc] ; $4be6
	ld a, $00 ; $4be7
	rst Rst18 ; $4be9
	ld [hl], $0a ; $4bea
	ld a, $11 ; $4bec
	ld d, $03 ; $4bee
	rst Rst18 ; $4bf0
	inc [hl] ; $4bf1
	ld a, [bc] ; $4bf2
	ld a, $11 ; $4bf3
	rst Rst18 ; $4bf5
	ld [hl], $0a ; $4bf6
	ld a, $11 ; $4bf8
	rst Rst18 ; $4bfa
	INCBIN "data/bank_011/d_4bfb.bin" ; $4bfb, 2 bytes
	push af ; $4bfd
	ld a, $0a ; $4bfe
	rst Rst18 ; $4c00
	inc b ; $4c01
	ld a, [bc] ; $4c02
	pop af ; $4c03
	ld a, $00 ; $4c04
	ld d, $03 ; $4c06
	rst Rst18 ; $4c08
	inc [hl] ; $4c09
	ld a, [bc] ; $4c0a
	ld a, $00 ; $4c0b
	rst Rst18 ; $4c0d
	ld [hl], $0a ; $4c0e
	push af ; $4c10
	ld a, $3c ; $4c11
	rst Rst18 ; $4c13
	inc b ; $4c14
	ld a, [bc] ; $4c15
	pop af ; $4c16
	ld bc, $0060 ; $4c17
	rst Rst18 ; $4c1a
	jr c, $4c27 ; $4c1b
	ld a, $11 ; $4c1d
	ld b, $c0 ; $4c1f
	rst Rst18 ; $4c21
	ld l, $0a ; $4c22
	ld a, $11 ; $4c24
	ld d, $02 ; $4c26
	rst Rst18 ; $4c28
	inc [hl] ; $4c29
	ld a, [bc] ; $4c2a
	ld a, $11 ; $4c2b
	rst Rst18 ; $4c2d
	ld [hl], $0a ; $4c2e
	ld a, $0f ; $4c30
	ld bc, $1a80 ; $4c32
	ld de, $21c0 ; $4c35
	rst Rst18 ; $4c38
	ld [hl+], a ; $4c39
	ld a, [bc] ; $4c3a
	rst Rst08 ; $4c3b
	sub a, a ; $4c3c
	push af ; $4c3d
	ld a, $28 ; $4c3e
	rst Rst18 ; $4c40
	inc b ; $4c41
	ld a, [bc] ; $4c42
	pop af ; $4c43
	ld a, $0f ; $4c44
	ld bc, $3f00 ; $4c46
	ld de, $3f00 ; $4c49
	rst Rst18 ; $4c4c
	ld [hl+], a ; $4c4d
	ld a, [bc] ; $4c4e
	ld a, $11 ; $4c4f
	ld b, $c0 ; $4c51
	rst Rst18 ; $4c53
	ld l, $0a ; $4c54
	ld a, $11 ; $4c56
	ld d, $02 ; $4c58
	rst Rst18 ; $4c5a
	inc [hl] ; $4c5b
	ld a, [bc] ; $4c5c
	xor a, a ; $4c5d
	ld bc, $1800 ; $4c5e
	ld de, $0b00 ; $4c61
	rst Rst18 ; $4c64
	ld a, [hl-] ; $4c65
	ld a, [bc] ; $4c66
	rst Rst18 ; $4c67
	ld a, $0a ; $4c68
	ld a, $11 ; $4c6a
	ld b, $00 ; $4c6c
	rst Rst18 ; $4c6e
	ld c, b ; $4c6f
	ld a, [bc] ; $4c70
	ld a, $11 ; $4c71
	ld bc, $1900 ; $4c73
	ld de, $0600 ; $4c76
	rst Rst18 ; $4c79
	ld [hl+], a ; $4c7a
	ld a, [bc] ; $4c7b
	ld a, $11 ; $4c7c
	rst Rst18 ; $4c7e
	INCBIN "data/bank_011/d_4c7f.bin" ; $4c7f, 2 bytes
	ld a, $11 ; $4c81
	ld bc, $1900 ; $4c83
	ld de, $2400 ; $4c86
	rst Rst18 ; $4c89
	ld [hl+], a ; $4c8a
	ld a, [bc] ; $4c8b
	ld a, $11 ; $4c8c
	ld b, $02 ; $4c8e
	rst Rst18 ; $4c90
	ld c, b ; $4c91
	ld a, [bc] ; $4c92
	xor a, a ; $4c93
	ld bc, $1800 ; $4c94
	ld de, $2400 ; $4c97
	rst Rst18 ; $4c9a
	ld a, [hl-] ; $4c9b
	ld a, [bc] ; $4c9c
	rst Rst18 ; $4c9d
	ld a, $0a ; $4c9e
	ld a, $00 ; $4ca0
	ld b, a ; $4ca2
	ld a, $11 ; $4ca3
	rst Rst18 ; $4ca5
	jr nc, Label_11_4cb2 ; $4ca6
	ld a, $11 ; $4ca8
	rst Rst18 ; $4caa
	INCBIN "data/bank_011/d_4cab.bin" ; $4cab, 2 bytes
	ld a, $11 ; $4cad
	ld d, $03 ; $4caf
	rst Rst18 ; $4cb1
Label_11_4cb2:
	inc [hl] ; $4cb2
	ld a, [bc] ; $4cb3
	ld a, $11 ; $4cb4
	rst Rst18 ; $4cb6
	ld [hl], $0a ; $4cb7
	ld a, $00 ; $4cb9
	ld d, $03 ; $4cbb
	rst Rst18 ; $4cbd
	inc [hl] ; $4cbe
	ld a, [bc] ; $4cbf
	ld a, $00 ; $4cc0
	rst Rst18 ; $4cc2
	ld [hl], $0a ; $4cc3
	ld a, $11 ; $4cc5
	ld de, $ff80 ; $4cc7
	rst Rst18 ; $4cca
	ld b, d ; $4ccb
	ld a, [bc] ; $4ccc
	ld a, $11 ; $4ccd
	rst Rst18 ; $4ccf
	ld b, h ; $4cd0
	ld a, [bc] ; $4cd1
	ld a, $11 ; $4cd2
	ld bc, $1800 ; $4cd4
	ld de, $3300 ; $4cd7
	rst Rst18 ; $4cda
	inc h ; $4cdb
	ld a, [bc] ; $4cdc
	push af ; $4cdd
	ld a, $14 ; $4cde
	rst Rst18 ; $4ce0
	inc b ; $4ce1
	ld a, [bc] ; $4ce2
	pop af ; $4ce3
	ld a, $00 ; $4ce4
	ld b, $40 ; $4ce6
	rst Rst18 ; $4ce8
	ld l, $0a ; $4ce9
	push af ; $4ceb
	ld a, $5a ; $4cec
	rst Rst18 ; $4cee
	inc b ; $4cef
	ld a, [bc] ; $4cf0
	pop af ; $4cf1
	call Func_11_4d94 ; $4cf2
	ret ; $4cf5
Func_11_4cf6:
	ld a, $01 ; $4cf6
	rst Rst18 ; $4cf8
	inc e ; $4cf9
	ld a, [bc] ; $4cfa
	rst Rst08 ; $4cfb
	ld [hl], b ; $4cfc
	ld a, $03 ; $4cfd
	rst Rst18 ; $4cff
	ld b, b ; $4d00
	ld a, [bc] ; $4d01
	push af ; $4d02
	ld a, $0a ; $4d03
	rst Rst18 ; $4d05
	inc b ; $4d06
	ld a, [bc] ; $4d07
	pop af ; $4d08
	ld a, $00 ; $4d09
	rst Rst18 ; $4d0b
	ld b, b ; $4d0c
	ld a, [bc] ; $4d0d
	ld a, $00 ; $4d0e
	ld bc, $0040 ; $4d10
	rst Rst18 ; $4d13
	jr Label_11_4d20 ; $4d14
	xor a, a ; $4d16
	ld bc, $1800 ; $4d17
	ld de, $2400 ; $4d1a
	rst Rst18 ; $4d1d
	ld a, [hl-] ; $4d1e
	ld a, [bc] ; $4d1f
Label_11_4d20:
	ld a, $00 ; $4d20
	ld bc, $1700 ; $4d22
	ld de, $2400 ; $4d25
	rst Rst18 ; $4d28
	inc h ; $4d29
	ld a, [bc] ; $4d2a
	ld a, $00 ; $4d2b
	ld de, rJOYP ; $4d2d
	rst Rst18 ; $4d30
	ld b, d ; $4d31
	ld a, [bc] ; $4d32
	ld a, $00 ; $4d33
	rst Rst18 ; $4d35
	ld d, $0a ; $4d36
	ld c, l ; $4d38
	ld b, h ; $4d39
	ld hl, $0037 ; $4d3a
	add hl, bc ; $4d3d
	ld a, [hl] ; $4d3e
	or a, $40 ; $4d3f
	ld [hl], a ; $4d41
	push af ; $4d42
	ld a, $1e ; $4d43
	rst Rst18 ; $4d45
	inc b ; $4d46
	ld a, [bc] ; $4d47
	pop af ; $4d48
	ld a, $00 ; $4d49
	ld d, $02 ; $4d4b
	rst Rst18 ; $4d4d
	inc [hl] ; $4d4e
	ld a, [bc] ; $4d4f
	ld a, $00 ; $4d50
	rst Rst18 ; $4d52
	ld [hl], $0a ; $4d53
	push af ; $4d55
	ld a, $1e ; $4d56
	rst Rst18 ; $4d58
	inc b ; $4d59
	ld a, [bc] ; $4d5a
	pop af ; $4d5b
	ldh a, [$ff95] ; $4d5c
	ld b, a ; $4d5e
	ld a, $00 ; $4d5f
	ld de, $4d8d ; $4d61
	rst Rst18 ; $4d64
	ld a, [de] ; $4d65
	ld a, [bc] ; $4d66
	ret ; $4d67
Func_11_4d68:
	ld a, $00 ; $4d68
	rst Rst18 ; $4d6a
	inc e ; $4d6b
	ld a, [bc] ; $4d6c
	ld a, $00 ; $4d6d
	ld bc, $0010 ; $4d6f
	rst Rst18 ; $4d72
	jr Label_11_4d7f ; $4d73
	ld a, $00 ; $4d75
	ld de, $ff80 ; $4d77
	rst Rst18 ; $4d7a
	ld b, d ; $4d7b
	ld a, [bc] ; $4d7c
	ld a, $00 ; $4d7d
Label_11_4d7f:
	rst Rst18 ; $4d7f
	ld d, $0a ; $4d80
	ld c, l ; $4d82
	ld b, h ; $4d83
	ld hl, $0037 ; $4d84
	add hl, bc ; $4d87
	ld a, [hl] ; $4d88
	xor a, $40 ; $4d89
	ld [hl], a ; $4d8b
	ret ; $4d8c
	INCBIN "data/bank_011/d_4d8d.bin" ; $4d8d, 7 bytes
Func_11_4d94:
	ld bc, $0010 ; $4d94
	rst Rst18 ; $4d97
	jr c, Label_11_4da4 ; $4d98
	ld a, $00 ; $4d9a
	ld bc, $0018 ; $4d9c
	rst Rst18 ; $4d9f
	jr $4dac ; $4da0
	ld a, $12 ; $4da2
Label_11_4da4:
	ld bc, $0018 ; $4da4
	rst Rst18 ; $4da7
	jr Label_11_4db4 ; $4da8
	xor a, a ; $4daa
	ld bc, $1800 ; $4dab
	ld de, $1300 ; $4dae
	rst Rst18 ; $4db1
	ld a, [hl-] ; $4db2
	ld a, [bc] ; $4db3
Label_11_4db4:
	ld a, $00 ; $4db4
	ld bc, $1800 ; $4db6
	ld de, $2400 ; $4db9
	rst Rst18 ; $4dbc
	inc h ; $4dbd
	ld a, [bc] ; $4dbe
	ld a, $00 ; $4dbf
	rst Rst18 ; $4dc1
	jr nz, Label_11_4dce ; $4dc2
	ld a, $00 ; $4dc4
	ld bc, $1800 ; $4dc6
	ld de, $1300 ; $4dc9
	rst Rst18 ; $4dcc
	inc h ; $4dcd
Label_11_4dce:
	ld a, [bc] ; $4dce
	ld hl, $01a3 ; $4dcf
	rst Rst18 ; $4dd2
	ld c, $0a ; $4dd3
	push af ; $4dd5
	ld a, $78 ; $4dd6
	rst Rst18 ; $4dd8
	inc b ; $4dd9
	ld a, [bc] ; $4dda
	pop af ; $4ddb
	ld a, $12 ; $4ddc
	ld bc, $1800 ; $4dde
	ld de, $0f00 ; $4de1
	rst Rst18 ; $4de4
	ld [hl+], a ; $4de5
	ld a, [bc] ; $4de6
	ld a, $00 ; $4de7
	rst Rst18 ; $4de9
	jr nz, $4df6 ; $4dea
	ld a, [$c90d] ; $4dec
	or a, a ; $4def
	jr z, Label_11_4df5 ; $4df0
	rst Rst18 ; $4df2
	INCBIN "data/bank_011/d_4df3.bin" ; $4df3, 2 bytes
Label_11_4df5:
	ld a, $12 ; $4df5
	rst Rst18 ; $4df7
	INCBIN "data/bank_011/d_4df8.bin" ; $4df8, 2 bytes
	ld a, $0f ; $4dfa
	ld bc, $1940 ; $4dfc
	ld de, $11c0 ; $4dff
	rst Rst18 ; $4e02
	ld [hl+], a ; $4e03
	ld a, [bc] ; $4e04
	rst Rst08 ; $4e05
	sub a, a ; $4e06
	push af ; $4e07
	ld a, $28 ; $4e08
	rst Rst18 ; $4e0a
	inc b ; $4e0b
	ld a, [bc] ; $4e0c
	pop af ; $4e0d
	ld a, $0f ; $4e0e
	ld bc, $3f00 ; $4e10
	ld de, $3f00 ; $4e13
	rst Rst18 ; $4e16
	ld [hl+], a ; $4e17
	ld a, [bc] ; $4e18
	ld a, $12 ; $4e19
	ld b, a ; $4e1b
	ld a, $00 ; $4e1c
	rst Rst18 ; $4e1e
	jr nc, $4e2b ; $4e1f
	ld bc, $0020 ; $4e21
	rst Rst18 ; $4e24
	jr c, Label_11_4e31 ; $4e25
	ld a, $12 ; $4e27
	ld bc, $1800 ; $4e29
	ld de, $1100 ; $4e2c
	rst Rst18 ; $4e2f
	inc h ; $4e30
Label_11_4e31:
	ld a, [bc] ; $4e31
	push af ; $4e32
	ld a, $0f ; $4e33
	rst Rst18 ; $4e35
	inc b ; $4e36
	ld a, [bc] ; $4e37
	pop af ; $4e38
	xor a, a ; $4e39
	ld bc, $1800 ; $4e3a
	ld de, $1100 ; $4e3d
	rst Rst18 ; $4e40
	ld a, [hl-] ; $4e41
	ld a, [bc] ; $4e42
	rst Rst18 ; $4e43
	ld a, $0a ; $4e44
	push af ; $4e46
	ld a, $3c ; $4e47
	rst Rst18 ; $4e49
	inc b ; $4e4a
	ld a, [bc] ; $4e4b
	pop af ; $4e4c
	ld a, $00 ; $4e4d
	ld b, a ; $4e4f
	ld a, $12 ; $4e50
	rst Rst18 ; $4e52
	ld [hl-], a ; $4e53
	ld a, [bc] ; $4e54
	push af ; $4e55
	ld a, $1e ; $4e56
	rst Rst18 ; $4e58
	inc b ; $4e59
	ld a, [bc] ; $4e5a
	pop af ; $4e5b
	ld a, $00 ; $4e5c
	ld d, $03 ; $4e5e
	rst Rst18 ; $4e60
	inc [hl] ; $4e61
	ld a, [bc] ; $4e62
	ld a, $00 ; $4e63
	rst Rst18 ; $4e65
	ld [hl], $0a ; $4e66
	push af ; $4e68
	ld a, $0f ; $4e69
	rst Rst18 ; $4e6b
	inc b ; $4e6c
	ld a, [bc] ; $4e6d
	pop af ; $4e6e
	ld a, $12 ; $4e6f
	ld d, $03 ; $4e71
	rst Rst18 ; $4e73
	inc [hl] ; $4e74
	ld a, [bc] ; $4e75
	ld a, $12 ; $4e76
	rst Rst18 ; $4e78
	ld [hl], $0a ; $4e79
	ld hl, $01a5 ; $4e7b
	rst Rst18 ; $4e7e
	ld c, $0a ; $4e7f
	ld a, $03 ; $4e81
	rst Rst18 ; $4e83
	INCBIN "data/bank_011/d_4e84.bin" ; $4e84, 2 bytes
	ld a, $0e ; $4e86
	ld bc, $1940 ; $4e88
	ld de, $11c0 ; $4e8b
	rst Rst18 ; $4e8e
	ld [hl+], a ; $4e8f
	ld a, [bc] ; $4e90
	rst Rst08 ; $4e91
	sbc a, b ; $4e92
	push af ; $4e93
	ld a, $32 ; $4e94
	rst Rst18 ; $4e96
	inc b ; $4e97
	ld a, [bc] ; $4e98
	pop af ; $4e99
	ld a, $0e ; $4e9a
	ld bc, $3f00 ; $4e9c
	ld de, $3f00 ; $4e9f
	rst Rst18 ; $4ea2
	ld [hl+], a ; $4ea3
	ld a, [bc] ; $4ea4
	ld a, $12 ; $4ea5
	ld d, $03 ; $4ea7
	rst Rst18 ; $4ea9
	inc [hl] ; $4eaa
	ld a, [bc] ; $4eab
	ld a, $12 ; $4eac
	rst Rst18 ; $4eae
	ld [hl], $0a ; $4eaf
	ld a, $12 ; $4eb1
	rst Rst18 ; $4eb3
	INCBIN "data/bank_011/d_4eb4.bin" ; $4eb4, 2 bytes
	push af ; $4eb6
	ld a, $0f ; $4eb7
	rst Rst18 ; $4eb9
	inc b ; $4eba
	ld a, [bc] ; $4ebb
	pop af ; $4ebc
	ld a, $12 ; $4ebd
	ld d, $02 ; $4ebf
	rst Rst18 ; $4ec1
	inc [hl] ; $4ec2
	ld a, [bc] ; $4ec3
	ld a, $12 ; $4ec4
	rst Rst18 ; $4ec6
	ld [hl], $0a ; $4ec7
	ld a, $12 ; $4ec9
	rst Rst18 ; $4ecb
	ld a, [bc] ; $4ecc
	ld a, [bc] ; $4ecd
	rst Rst18 ; $4ece
	ld [de], a ; $4ecf
	ld a, [bc] ; $4ed0
	rst Rst18 ; $4ed1
	inc c ; $4ed2
	ld a, [bc] ; $4ed3
	push af ; $4ed4
	ld a, $05 ; $4ed5
	rst Rst18 ; $4ed7
	inc b ; $4ed8
	ld a, [bc] ; $4ed9
	pop af ; $4eda
	and a, a ; $4edb
	jr z, Label_11_4ee1 ; $4edc
	rst Rst18 ; $4ede
	INCBIN "data/bank_011/d_4edf.bin" ; $4edf, 2 bytes
Label_11_4ee1:
	ld a, $12 ; $4ee1
	rst Rst18 ; $4ee3
	ld a, [bc] ; $4ee4
	ld a, [bc] ; $4ee5
	rst Rst18 ; $4ee6
	ld [de], a ; $4ee7
	ld a, [bc] ; $4ee8
	rst Rst18 ; $4ee9
	inc c ; $4eea
	ld a, [bc] ; $4eeb
	push af ; $4eec
	ld a, $05 ; $4eed
	rst Rst18 ; $4eef
	inc b ; $4ef0
	ld a, [bc] ; $4ef1
	pop af ; $4ef2
	and a, a ; $4ef3
	jr z, Label_11_4f0c ; $4ef4
	xor a, a ; $4ef6
	ld [$c2d5], a ; $4ef7
	ld hl, $01ab ; $4efa
	rst Rst18 ; $4efd
	ld c, $0a ; $4efe
	ld a, $12 ; $4f00
	rst Rst18 ; $4f02
	ld [$e70a], sp ; $4f03
	ret nz ; $4f06
	dec b ; $4f07
	call Func_11_4f1b ; $4f08
	ret ; $4f0b
Label_11_4f0c:
	ld hl, $01aa ; $4f0c
	rst Rst18 ; $4f0f
	ld c, $0a ; $4f10
	ld a, $12 ; $4f12
	rst Rst18 ; $4f14
	INCBIN "data/bank_011/d_4f15.bin" ; $4f15, 2 bytes
	call Func_11_4f84 ; $4f17
	ret ; $4f1a
Func_11_4f1b:
	ld a, $f1 ; $4f1b
	ld d, $16 ; $4f1d
	ld e, $10 ; $4f1f
	rst Rst18 ; $4f21
	adc a, d ; $4f22
	ld a, [bc] ; $4f23
	ld a, $f1 ; $4f24
	ld d, $18 ; $4f26
	ld e, $10 ; $4f28
	rst Rst18 ; $4f2a
	adc a, d ; $4f2b
	ld a, [bc] ; $4f2c
	ld a, $f1 ; $4f2d
	ld d, $16 ; $4f2f
	ld e, $12 ; $4f31
	rst Rst18 ; $4f33
	adc a, d ; $4f34
	ld a, [bc] ; $4f35
	ld a, $f1 ; $4f36
	ld d, $18 ; $4f38
	ld e, $12 ; $4f3a
	rst Rst18 ; $4f3c
	adc a, d ; $4f3d
	ld a, [bc] ; $4f3e
	ret ; $4f3f
	INCBIN "data/bank_011/d_4f40.bin" ; $4f40, 68 bytes
Func_11_4f84:
	ld a, $00 ; $4f84
	ld bc, $0018 ; $4f86
	rst Rst18 ; $4f89
	jr Label_11_4f96 ; $4f8a
	ld a, $12 ; $4f8c
	ld bc, $0018 ; $4f8e
	rst Rst18 ; $4f91
	jr $4f9e ; $4f92
	rst Rst28 ; $4f94
	ret nz ; $4f95
Label_11_4f96:
	dec b ; $4f96
	ld a, $12 ; $4f97
	ld bc, $1800 ; $4f99
	ld de, $0e00 ; $4f9c
	rst Rst18 ; $4f9f
	inc h ; $4fa0
	ld a, [bc] ; $4fa1
	ld a, $00 ; $4fa2
	ld bc, $1800 ; $4fa4
	ld de, $0e00 ; $4fa7
	rst Rst18 ; $4faa
	inc h ; $4fab
	ld a, [bc] ; $4fac
	push af ; $4fad
	ld a, $1e ; $4fae
	rst Rst18 ; $4fb0
	inc b ; $4fb1
	ld a, [bc] ; $4fb2
	pop af ; $4fb3
	ld a, $0f ; $4fb4
	ld [$c294], a ; $4fb6
	ld [$c2a1], a ; $4fb9
	ld c, $04 ; $4fbc
	call Func_00_1d20 ; $4fbe
	call Func_00_1da4 ; $4fc1
	ret ; $4fc4
	INCBIN "data/bank_011/d_4fc5.bin" ; $4fc5, 10 bytes
Label_11_4fcf:
	ldh a, [$ff95] ; $4fcf
	ld hl, $537d ; $4fd1
	rst Rst18 ; $4fd4
	ld b, $0a ; $4fd5
	rst Rst18 ; $4fd7
	nop ; $4fd8
	ld a, [bc] ; $4fd9
	rst Rst30 ; $4fda
	ldh [rTIMA], a ; $4fdb
	jp z, Label_11_501a ; $4fdd
	ld a, $02 ; $4fe0
	rst Rst18 ; $4fe2
	inc e ; $4fe3
	ld a, [bc] ; $4fe4
	ld a, $02 ; $4fe5
	ld bc, $3f00 ; $4fe7
	ld de, $3f00 ; $4fea
	rst Rst18 ; $4fed
	ld [hl+], a ; $4fee
	ld a, [bc] ; $4fef
	ld a, [$c94d] ; $4ff0
	ld d, $58 ; $4ff3
	add a, d ; $4ff5
	ld d, a ; $4ff6
	ld a, $05 ; $4ff7
	rst Rst18 ; $4ff9
	ld d, $0a ; $4ffa
	ld c, l ; $4ffc
	ld b, h ; $4ffd
	rst Rst18 ; $4ffe
	inc l ; $4fff
	inc b ; $5000
	ld a, $05 ; $5001
	ld d, $01 ; $5003
	rst Rst18 ; $5005
	inc [hl] ; $5006
	ld a, [bc] ; $5007
	ld a, $07 ; $5008
	ld bc, $1a00 ; $500a
	ld de, $1100 ; $500d
	rst Rst18 ; $5010
	ld [hl+], a ; $5011
	ld a, [bc] ; $5012
	ld a, $07 ; $5013
	ld b, $40 ; $5015
	rst Rst18 ; $5017
	ld l, $0a ; $5018
Label_11_501a:
	ld a, [$c90d] ; $501a
	ld d, $56 ; $501d
	add a, d ; $501f
	ld d, a ; $5020
	ld a, $00 ; $5021
	rst Rst18 ; $5023
	ld d, $0a ; $5024
	ld c, l ; $5026
	ld b, h ; $5027
	rst Rst18 ; $5028
	inc l ; $5029
	inc b ; $502a
	ld a, $00 ; $502b
	ld d, $01 ; $502d
	rst Rst18 ; $502f
	inc [hl] ; $5030
	ld a, [bc] ; $5031
	ld a, $00 ; $5032
	ld bc, $1700 ; $5034
	ld de, $1700 ; $5037
	rst Rst18 ; $503a
	ld [hl+], a ; $503b
	ld a, [bc] ; $503c
	ld a, $00 ; $503d
	ld b, $c0 ; $503f
	rst Rst18 ; $5041
	ld l, $0a ; $5042
	ld a, $03 ; $5044
	ld b, $00 ; $5046
	rst Rst18 ; $5048
	inc a ; $5049
	ld a, [bc] ; $504a
	rst Rst18 ; $504b
	ld a, $0a ; $504c
	ld c, $08 ; $504e
	call Func_00_1d2e ; $5050
	call Func_00_1da4 ; $5053
	push af ; $5056
	ld a, $3c ; $5057
	rst Rst18 ; $5059
	inc b ; $505a
	ld a, [bc] ; $505b
	pop af ; $505c
	ld hl, $01ed ; $505d
	rst Rst18 ; $5060
	ld c, $0a ; $5061
	ld a, $03 ; $5063
	rst Rst18 ; $5065
	ld [$f70a], sp ; $5066
	ldh [rTIMA], a ; $5069
	jp z, Label_11_5158 ; $506b
	ld a, $04 ; $506e
	ld d, $03 ; $5070
	rst Rst18 ; $5072
	inc [hl] ; $5073
	ld a, [bc] ; $5074
	ld a, $06 ; $5075
	ld d, $03 ; $5077
	rst Rst18 ; $5079
	inc [hl] ; $507a
	ld a, [bc] ; $507b
	ld a, $06 ; $507c
	rst Rst18 ; $507e
	ld [hl], $0a ; $507f
	push af ; $5081
	ld a, $1e ; $5082
	rst Rst18 ; $5084
	inc b ; $5085
	ld a, [bc] ; $5086
	pop af ; $5087
	ld a, $05 ; $5088
	ld b, a ; $508a
	ld a, $00 ; $508b
	rst Rst18 ; $508d
	ld [hl-], a ; $508e
	ld a, [bc] ; $508f
	push af ; $5090
	ld a, $1e ; $5091
	rst Rst18 ; $5093
	inc b ; $5094
	ld a, [bc] ; $5095
	pop af ; $5096
	ld a, $00 ; $5097
	ld d, $03 ; $5099
	rst Rst18 ; $509b
	inc [hl] ; $509c
	ld a, [bc] ; $509d
	ld a, $05 ; $509e
	ld d, $03 ; $50a0
	rst Rst18 ; $50a2
	inc [hl] ; $50a3
	ld a, [bc] ; $50a4
	ld a, $05 ; $50a5
	rst Rst18 ; $50a7
	ld [hl], $0a ; $50a8
	push af ; $50aa
	ld a, $1e ; $50ab
	rst Rst18 ; $50ad
	inc b ; $50ae
	ld a, [bc] ; $50af
	pop af ; $50b0
	ld a, $05 ; $50b1
	ld b, $c0 ; $50b3
	rst Rst18 ; $50b5
	ld l, $0a ; $50b6
	push af ; $50b8
	ld a, $1e ; $50b9
	rst Rst18 ; $50bb
	inc b ; $50bc
	ld a, [bc] ; $50bd
	pop af ; $50be
	ld a, $00 ; $50bf
	ld d, $03 ; $50c1
	rst Rst18 ; $50c3
	inc [hl] ; $50c4
	ld a, [bc] ; $50c5
	ld a, $05 ; $50c6
	ld d, $03 ; $50c8
	rst Rst18 ; $50ca
	inc [hl] ; $50cb
	ld a, [bc] ; $50cc
	ld a, $05 ; $50cd
	rst Rst18 ; $50cf
	ld [hl], $0a ; $50d0
	push af ; $50d2
	ld a, $1e ; $50d3
	rst Rst18 ; $50d5
	inc b ; $50d6
	ld a, [bc] ; $50d7
	pop af ; $50d8
	ld a, $03 ; $50d9
	ld d, $03 ; $50db
	rst Rst18 ; $50dd
	inc [hl] ; $50de
	ld a, [bc] ; $50df
	ld a, $03 ; $50e0
	rst Rst18 ; $50e2
	ld [hl], $0a ; $50e3
	push af ; $50e5
	ld a, $0a ; $50e6
	rst Rst18 ; $50e8
	inc b ; $50e9
	ld a, [bc] ; $50ea
	pop af ; $50eb
	ld a, $07 ; $50ec
	ld d, $02 ; $50ee
	rst Rst18 ; $50f0
	inc [hl] ; $50f1
	ld a, [bc] ; $50f2
	ld a, $07 ; $50f3
	rst Rst18 ; $50f5
	ld [hl], $0a ; $50f6
	ld a, $07 ; $50f8
	rst Rst18 ; $50fa
	ld [$3e0a], sp ; $50fb
	inc b ; $50fe
	ld d, $03 ; $50ff
	rst Rst18 ; $5101
	inc [hl] ; $5102
	ld a, [bc] ; $5103
	ld a, $05 ; $5104
	ld d, $03 ; $5106
	rst Rst18 ; $5108
	inc [hl] ; $5109
	ld a, [bc] ; $510a
	ld a, $00 ; $510b
	ld d, $03 ; $510d
	rst Rst18 ; $510f
	inc [hl] ; $5110
	ld a, [bc] ; $5111
	ld a, $06 ; $5112
	ld d, $03 ; $5114
	rst Rst18 ; $5116
	inc [hl] ; $5117
	ld a, [bc] ; $5118
	ld a, $06 ; $5119
	rst Rst18 ; $511b
	ld [hl], $0a ; $511c
	push af ; $511e
	ld a, $1e ; $511f
	rst Rst18 ; $5121
	inc b ; $5122
	ld a, [bc] ; $5123
	pop af ; $5124
	ld a, $07 ; $5125
	ld b, a ; $5127
	ld a, $03 ; $5128
	rst Rst18 ; $512a
	ld [hl-], a ; $512b
	ld a, [bc] ; $512c
	ld a, $03 ; $512d
	ld d, $03 ; $512f
	rst Rst18 ; $5131
	inc [hl] ; $5132
	ld a, [bc] ; $5133
	ld a, $07 ; $5134
	ld d, $03 ; $5136
	rst Rst18 ; $5138
	inc [hl] ; $5139
	ld a, [bc] ; $513a
	ld a, $07 ; $513b
	rst Rst18 ; $513d
	ld [hl], $0a ; $513e
	ld a, $07 ; $5140
	ld b, $40 ; $5142
	rst Rst18 ; $5144
	ld l, $0a ; $5145
	ld a, $03 ; $5147
	ld b, $40 ; $5149
	rst Rst18 ; $514b
	ld l, $0a ; $514c
	push af ; $514e
	ld a, $1e ; $514f
	rst Rst18 ; $5151
	inc b ; $5152
	ld a, [bc] ; $5153
	pop af ; $5154
	jp Label_11_51d9 ; $5155
Label_11_5158:
	ld a, $04 ; $5158
	ld d, $03 ; $515a
	rst Rst18 ; $515c
	inc [hl] ; $515d
	ld a, [bc] ; $515e
	ld a, $05 ; $515f
	ld d, $03 ; $5161
	rst Rst18 ; $5163
	inc [hl] ; $5164
	ld a, [bc] ; $5165
	ld a, $05 ; $5166
	rst Rst18 ; $5168
	ld [hl], $0a ; $5169
	push af ; $516b
	ld a, $1e ; $516c
	rst Rst18 ; $516e
	inc b ; $516f
	ld a, [bc] ; $5170
	pop af ; $5171
	ld a, $06 ; $5172
	ld b, a ; $5174
	ld a, $00 ; $5175
	rst Rst18 ; $5177
	ld [hl-], a ; $5178
	ld a, [bc] ; $5179
	push af ; $517a
	ld a, $1e ; $517b
	rst Rst18 ; $517d
	inc b ; $517e
	ld a, [bc] ; $517f
	pop af ; $5180
	ld a, $00 ; $5181
	ld d, $03 ; $5183
	rst Rst18 ; $5185
	inc [hl] ; $5186
	ld a, [bc] ; $5187
	ld a, $06 ; $5188
	ld d, $03 ; $518a
	rst Rst18 ; $518c
	inc [hl] ; $518d
	ld a, [bc] ; $518e
	ld a, $06 ; $518f
	rst Rst18 ; $5191
	ld [hl], $0a ; $5192
	push af ; $5194
	ld a, $1e ; $5195
	rst Rst18 ; $5197
	inc b ; $5198
	ld a, [bc] ; $5199
	pop af ; $519a
	ld a, $00 ; $519b
	ld b, $c0 ; $519d
	rst Rst18 ; $519f
	ld l, $0a ; $51a0
	ld a, $06 ; $51a2
	ld b, $c0 ; $51a4
	rst Rst18 ; $51a6
	ld l, $0a ; $51a7
	push af ; $51a9
	ld a, $1e ; $51aa
	rst Rst18 ; $51ac
	inc b ; $51ad
	ld a, [bc] ; $51ae
	pop af ; $51af
	ld a, $00 ; $51b0
	ld d, $03 ; $51b2
	rst Rst18 ; $51b4
	inc [hl] ; $51b5
	ld a, [bc] ; $51b6
	ld a, $06 ; $51b7
	ld d, $03 ; $51b9
	rst Rst18 ; $51bb
	inc [hl] ; $51bc
	ld a, [bc] ; $51bd
	ld a, $06 ; $51be
	rst Rst18 ; $51c0
	ld [hl], $0a ; $51c1
	push af ; $51c3
	ld a, $1e ; $51c4
	rst Rst18 ; $51c6
	inc b ; $51c7
	ld a, [bc] ; $51c8
	pop af ; $51c9
	ld a, $03 ; $51ca
	ld d, $03 ; $51cc
	rst Rst18 ; $51ce
	inc [hl] ; $51cf
	ld a, [bc] ; $51d0
	ld a, $03 ; $51d1
	rst Rst18 ; $51d3
	ld [hl], $0a ; $51d4
	rst Rst18 ; $51d6
	INCBIN "data/bank_011/d_51d7.bin" ; $51d7, 2 bytes
Label_11_51d9:
	ld a, $03 ; $51d9
	rst Rst18 ; $51db
	ld [$f50a], sp ; $51dc
	ld a, $1e ; $51df
	rst Rst18 ; $51e1
	inc b ; $51e2
	ld a, [bc] ; $51e3
	pop af ; $51e4
	ld a, $04 ; $51e5
	ld d, $03 ; $51e7
	rst Rst18 ; $51e9
	inc [hl] ; $51ea
	ld a, [bc] ; $51eb
	ld a, $05 ; $51ec
	ld d, $03 ; $51ee
	rst Rst18 ; $51f0
	inc [hl] ; $51f1
	ld a, [bc] ; $51f2
	ld a, $00 ; $51f3
	ld d, $03 ; $51f5
	rst Rst18 ; $51f7
	inc [hl] ; $51f8
	ld a, [bc] ; $51f9
	ld a, $06 ; $51fa
	ld d, $03 ; $51fc
	rst Rst18 ; $51fe
	inc [hl] ; $51ff
	ld a, [bc] ; $5200
	ld a, $06 ; $5201
	rst Rst18 ; $5203
	ld [hl], $0a ; $5204
	push af ; $5206
	ld a, $14 ; $5207
	rst Rst18 ; $5209
	inc b ; $520a
	ld a, [bc] ; $520b
	pop af ; $520c
	ld a, $06 ; $520d
	ld b, a ; $520f
	ld a, $00 ; $5210
	rst Rst18 ; $5212
	ld [hl-], a ; $5213
	ld a, [bc] ; $5214
	ld a, $04 ; $5215
	ld b, a ; $5217
	ld a, $05 ; $5218
	rst Rst18 ; $521a
	ld [hl-], a ; $521b
	ld a, [bc] ; $521c
	push af ; $521d
	ld a, $0a ; $521e
	rst Rst18 ; $5220
	inc b ; $5221
	ld a, [bc] ; $5222
	pop af ; $5223
	ld a, $00 ; $5224
	ld b, $01 ; $5226
	rst Rst18 ; $5228
	inc l ; $5229
	ld a, [bc] ; $522a
	ld a, $06 ; $522b
	ld b, $01 ; $522d
	rst Rst18 ; $522f
	inc l ; $5230
	ld a, [bc] ; $5231
	ld a, $05 ; $5232
	ld b, $01 ; $5234
	rst Rst18 ; $5236
	inc l ; $5237
	ld a, [bc] ; $5238
	ld a, $04 ; $5239
	ld b, $01 ; $523b
	rst Rst18 ; $523d
	inc l ; $523e
	ld a, [bc] ; $523f
	ld a, $00 ; $5240
	ld bc, $1600 ; $5242
	ld de, $1700 ; $5245
	rst Rst18 ; $5248
	inc h ; $5249
	ld a, [bc] ; $524a
	ld a, $06 ; $524b
	ld bc, $1a00 ; $524d
	ld de, $1700 ; $5250
	rst Rst18 ; $5253
	inc h ; $5254
	ld a, [bc] ; $5255
	ld a, $05 ; $5256
	ld bc, $1500 ; $5258
	ld de, $1500 ; $525b
	rst Rst18 ; $525e
	inc h ; $525f
	ld a, [bc] ; $5260
	ld a, $04 ; $5261
	ld bc, $1b00 ; $5263
	ld de, $1500 ; $5266
	rst Rst18 ; $5269
	inc h ; $526a
	ld a, [bc] ; $526b
	ld a, $04 ; $526c
	rst Rst18 ; $526e
	jr nz, Label_11_527b ; $526f
	xor a, a ; $5271
	ld bc, $1800 ; $5272
	ld de, $2f00 ; $5275
	rst Rst18 ; $5278
	ld a, [hl-] ; $5279
	ld a, [bc] ; $527a
Label_11_527b:
	ld a, $03 ; $527b
	ld bc, $1800 ; $527d
	ld de, $1900 ; $5280
	rst Rst18 ; $5283
	inc h ; $5284
	ld a, [bc] ; $5285
	ld a, $03 ; $5286
	rst Rst18 ; $5288
	jr nz, Label_11_5295 ; $5289
	ld a, $00 ; $528b
	ld b, $00 ; $528d
	rst Rst18 ; $528f
	inc l ; $5290
	ld a, [bc] ; $5291
	ld a, $06 ; $5292
	INCBIN "data/bank_011/d_5294.bin" ; $5294, 1 bytes
Label_11_5295:
	nop ; $5295
	rst Rst18 ; $5296
	inc l ; $5297
	ld a, [bc] ; $5298
	ld a, $05 ; $5299
	ld b, $00 ; $529b
	rst Rst18 ; $529d
	inc l ; $529e
	ld a, [bc] ; $529f
	ld a, $04 ; $52a0
	ld b, $00 ; $52a2
	rst Rst18 ; $52a4
	inc l ; $52a5
	ld a, [bc] ; $52a6
	ld a, $00 ; $52a7
	ld bc, $1600 ; $52a9
	ld de, $2b00 ; $52ac
	rst Rst18 ; $52af
	inc h ; $52b0
	ld a, [bc] ; $52b1
	ld a, $06 ; $52b2
	ld bc, $1a00 ; $52b4
	ld de, $2b00 ; $52b7
	rst Rst18 ; $52ba
	inc h ; $52bb
	ld a, [bc] ; $52bc
	ld a, $05 ; $52bd
	ld bc, $1500 ; $52bf
	ld de, $2900 ; $52c2
	rst Rst18 ; $52c5
	inc h ; $52c6
	ld a, [bc] ; $52c7
	ld a, $04 ; $52c8
	ld bc, $1b00 ; $52ca
	ld de, $2900 ; $52cd
	rst Rst18 ; $52d0
	inc h ; $52d1
	ld a, [bc] ; $52d2
	ld a, $03 ; $52d3
	ld bc, $1800 ; $52d5
	ld de, $2d00 ; $52d8
	rst Rst18 ; $52db
	inc h ; $52dc
	ld a, [bc] ; $52dd
	ld a, $03 ; $52de
	rst Rst18 ; $52e0
	jr nz, Label_11_52ed ; $52e1
	ld a, $08 ; $52e3
	ld d, $03 ; $52e5
	rst Rst18 ; $52e7
	inc [hl] ; $52e8
	ld a, [bc] ; $52e9
	ld a, $00 ; $52ea
	INCBIN "data/bank_011/d_52ec.bin" ; $52ec, 1 bytes
Label_11_52ed:
	nop ; $52ed
	rla ; $52ee
	ld de, $2f00 ; $52ef
	rst Rst18 ; $52f2
	inc h ; $52f3
	ld a, [bc] ; $52f4
	ld a, $06 ; $52f5
	ld bc, $1900 ; $52f7
	ld de, $2f00 ; $52fa
	rst Rst18 ; $52fd
	inc h ; $52fe
	ld a, [bc] ; $52ff
	ld a, $05 ; $5300
	ld bc, $1700 ; $5302
	ld de, $2d00 ; $5305
	rst Rst18 ; $5308
	inc h ; $5309
	ld a, [bc] ; $530a
	ld a, $04 ; $530b
	ld bc, $1900 ; $530d
	ld de, $2d00 ; $5310
	rst Rst18 ; $5313
	inc h ; $5314
	ld a, [bc] ; $5315
	ld a, $03 ; $5316
	ld bc, $1800 ; $5318
	ld de, $3100 ; $531b
	rst Rst18 ; $531e
	inc h ; $531f
	ld a, [bc] ; $5320
	ld a, $03 ; $5321
	rst Rst18 ; $5323
	jr nz, Label_11_5330 ; $5324
	ld a, $00 ; $5326
	ld bc, $1700 ; $5328
	ld de, $3b00 ; $532b
	rst Rst18 ; $532e
	inc h ; $532f
Label_11_5330:
	ld a, [bc] ; $5330
	ld a, $06 ; $5331
	ld bc, $1900 ; $5333
	ld de, $3b00 ; $5336
	rst Rst18 ; $5339
	inc h ; $533a
	ld a, [bc] ; $533b
	ld a, $05 ; $533c
	ld bc, $1700 ; $533e
	ld de, $3900 ; $5341
	rst Rst18 ; $5344
	inc h ; $5345
	ld a, [bc] ; $5346
	ld a, $04 ; $5347
	ld bc, $1900 ; $5349
	ld de, $3900 ; $534c
	rst Rst18 ; $534f
	inc h ; $5350
	ld a, [bc] ; $5351
	ld a, $03 ; $5352
	ld bc, $1800 ; $5354
	ld de, $3d00 ; $5357
	rst Rst18 ; $535a
	inc h ; $535b
	ld a, [bc] ; $535c
	ld a, $03 ; $535d
	rst Rst18 ; $535f
	jr nz, Label_11_536c ; $5360
	ld c, $04 ; $5362
	call Func_00_1d20 ; $5364
	call Func_00_1da4 ; $5367
	ld a, $1b ; $536a
Label_11_536c:
	ld [wStoryModeCurrentLocation], a ; $536c
	ld a, $01 ; $536f
	ld [$c295], a ; $5371
	ld a, $ff ; $5374
	ld [$c294], a ; $5376
	ld [$c2a1], a ; $5379
	ret ; $537c
	INCBIN "data/bank_011/d_537d.bin" ; $537d, 94 bytes
Label_11_53db:
	ldh a, [$ff95] ; $53db
	ld hl, $546a ; $53dd
	rst Rst18 ; $53e0
	ld b, $0a ; $53e1
	rst Rst18 ; $53e3
	nop ; $53e4
	ld a, [bc] ; $53e5
	ld bc, $00ff ; $53e6
	rst Rst18 ; $53e9
	jr c, Label_11_53f6 ; $53ea
	xor a, a ; $53ec
	ld bc, $1800 ; $53ed
	ld de, $2f00 ; $53f0
	rst Rst18 ; $53f3
	ld a, [hl-] ; $53f4
	ld a, [bc] ; $53f5
Label_11_53f6:
	rst Rst18 ; $53f6
	ld a, $0a ; $53f7
	rst Rst30 ; $53f9
	ldh [rTIMA], a ; $53fa
	jp z, Label_11_5415 ; $53fc
	ld a, $02 ; $53ff
	ld bc, $1800 ; $5401
	ld de, $1d00 ; $5404
	rst Rst18 ; $5407
	ld [hl+], a ; $5408
	ld a, [bc] ; $5409
	ld a, $02 ; $540a
	ld bc, $1800 ; $540c
	ld de, $3900 ; $540f
	rst Rst18 ; $5412
	inc h ; $5413
	ld a, [bc] ; $5414
Label_11_5415:
	ld a, $00 ; $5415
	ld bc, $1800 ; $5417
	ld de, $1f00 ; $541a
	rst Rst18 ; $541d
	ld [hl+], a ; $541e
	ld a, [bc] ; $541f
	ld a, $00 ; $5420
	ld bc, $1800 ; $5422
	ld de, $3b00 ; $5425
	rst Rst18 ; $5428
	inc h ; $5429
	ld a, [bc] ; $542a
	xor a, a ; $542b
	ld [$c2d5], a ; $542c
	ld c, $04 ; $542f
	call Func_00_1d2e ; $5431
	call Func_00_1da4 ; $5434
	push af ; $5437
	ld a, $3c ; $5438
	rst Rst18 ; $543a
	inc b ; $543b
	ld a, [bc] ; $543c
	pop af ; $543d
	ld a, $03 ; $543e
	ld d, $03 ; $5440
	rst Rst18 ; $5442
	inc [hl] ; $5443
	ld a, [bc] ; $5444
	ld a, $03 ; $5445
	rst Rst18 ; $5447
	ld [hl], $0a ; $5448
	ld a, $00 ; $544a
	rst Rst18 ; $544c
	jr nz, Label_11_5459 ; $544d
	ld c, $04 ; $544f
	call Func_00_1d20 ; $5451
	call Func_00_1da4 ; $5454
	ld a, $1b ; $5457
Label_11_5459:
	ld [wStoryModeCurrentLocation], a ; $5459
	ld a, $0f ; $545c
	ld [$c295], a ; $545e
	ld a, $ff ; $5461
	ld [$c294], a ; $5463
	ld [$c2a1], a ; $5466
	ret ; $5469
	INCBIN "data/bank_011/d_546a.bin" ; $546a, 24 bytes
Func_11_5482:
	rst Rst30 ; $5482
	ldh [rTIMA], a ; $5483
	jr nz, Label_11_548d ; $5485
	rst Rst30 ; $5487
	nop ; $5488
	INCBIN "data/bank_011/d_5489.bin" ; $5489, 1 bytes
	jr nz, Label_11_5493 ; $548a
	ret ; $548c
Label_11_548d:
	rst Rst30 ; $548d
	jr nz, Func_11_54a6 ; $548e
	jr nz, Label_11_5493 ; $5490
	ret ; $5492
Label_11_5493:
	ld a, $33 ; $5493
	ld d, $16 ; $5495
	ld e, $34 ; $5497
	rst Rst18 ; $5499
	adc a, d ; $549a
	ld a, [bc] ; $549b
	ld a, $33 ; $549c
	ld d, $18 ; $549e
	ld e, $34 ; $54a0
	rst Rst18 ; $54a2
	adc a, d ; $54a3
	ld a, [bc] ; $54a4
	ret ; $54a5
Func_11_54a6:
	ld a, [$c2b0] ; $54a6
	cp a, $06 ; $54a9
	jr c, Label_11_54bf ; $54ab
	ld a, $14 ; $54ad
	ld bc, $1500 ; $54af
	ld de, $3000 ; $54b2
	rst Rst18 ; $54b5
	ld [hl+], a ; $54b6
	ld a, [bc] ; $54b7
	ld a, $14 ; $54b8
	ld b, $00 ; $54ba
	rst Rst18 ; $54bc
	ld l, $0a ; $54bd
Label_11_54bf:
	ret ; $54bf
	INCBIN "data/bank_011/d_54c0.bin" ; $54c0, 7652 bytes
	rst Rst18 ; $72a4
	inc b ; $72a5
	ld a, [bc] ; $72a6
	pop af ; $72a7
	and a, a ; $72a8
	jp nz, Label_11_72ec ; $72a9
	ld a, $03 ; $72ac
	ld d, $03 ; $72ae
	rst Rst18 ; $72b0
	inc [hl] ; $72b1
	ld a, [bc] ; $72b2
	ld a, $03 ; $72b3
	rst Rst18 ; $72b5
	ld [hl], $0a ; $72b6
Label_11_72b8:
	ld a, $03 ; $72b8
	ld d, $03 ; $72ba
	rst Rst18 ; $72bc
	inc [hl] ; $72bd
	ld a, [bc] ; $72be
	ld a, $03 ; $72bf
	rst Rst18 ; $72c1
	ld [hl], $0a ; $72c2
	ld hl, $0828 ; $72c4
	rst Rst18 ; $72c7
	ld c, $0a ; $72c8
	ld a, $03 ; $72ca
	rst Rst18 ; $72cc
	ld [$cd0a], sp ; $72cd
	dec e ; $72d0
	ld a, b ; $72d1
	ld a, $00 ; $72d2
	ld bc, $0018 ; $72d4
	rst Rst18 ; $72d7
	jr $72e4 ; $72d8
	INCBIN "data/bank_011/d_72da.bin" ; $72da, 9 bytes
Label_11_72e3:
	ld a, $03 ; $72e3
	rst Rst18 ; $72e5
	ld [$cd0a], sp ; $72e6
	ld a, [bc] ; $72e9
	ld [hl], e ; $72ea
	ret ; $72eb
Label_11_72ec:
	ld hl, $0825 ; $72ec
	rst Rst18 ; $72ef
	ld c, $0a ; $72f0
	ld a, $03 ; $72f2
	rst Rst18 ; $72f4
	ld a, [bc] ; $72f5
	ld a, [bc] ; $72f6
	rst Rst18 ; $72f7
	ld [de], a ; $72f8
	ld a, [bc] ; $72f9
	rst Rst18 ; $72fa
	inc c ; $72fb
	ld a, [bc] ; $72fc
	push af ; $72fd
	ld a, $05 ; $72fe
	rst Rst18 ; $7300
	inc b ; $7301
	ld a, [bc] ; $7302
	pop af ; $7303
	and a, a ; $7304
	jr z, Label_11_72e3 ; $7305
	jp Label_11_72b8 ; $7307
	INCBIN "data/bank_011/d_730a.bin" ; $730a, 729 bytes
	rst Rst18 ; $75e3
	ld [hl], $0a ; $75e4
	ldh a, [$ff95] ; $75e6
	ld b, a ; $75e8
	ld a, $04 ; $75e9
	ld de, $7728 ; $75eb
	rst Rst18 ; $75ee
	ld a, [de] ; $75ef
	ld a, [bc] ; $75f0
	ld a, $03 ; $75f1
	ld b, $40 ; $75f3
	rst Rst18 ; $75f5
	ld l, $0a ; $75f6
	ld a, $00 ; $75f8
	ld b, $00 ; $75fa
	rst Rst18 ; $75fc
	inc a ; $75fd
	ld a, [bc] ; $75fe
	ld a, $04 ; $75ff
	rst Rst18 ; $7601
	ld e, $0a ; $7602
	ld a, $04 ; $7604
	ld b, a ; $7606
	ld a, $00 ; $7607
	rst Rst18 ; $7609
	jr nc, Label_11_7616 ; $760a
	ld a, $04 ; $760c
	ld d, $02 ; $760e
	rst Rst18 ; $7610
	inc [hl] ; $7611
	ld a, [bc] ; $7612
	ld a, $04 ; $7613
	rst Rst18 ; $7615
Label_11_7616:
	ld [hl], $0a ; $7616
	ld hl, $0830 ; $7618
	rst Rst18 ; $761b
	ld c, $0a ; $761c
	ld a, $04 ; $761e
	rst Rst18 ; $7620
	ld [$3e0a], sp ; $7621
	inc b ; $7624
	ld d, $03 ; $7625
	rst Rst18 ; $7627
	inc [hl] ; $7628
	ld a, [bc] ; $7629
	ld a, $04 ; $762a
	rst Rst18 ; $762c
	ld [hl], $0a ; $762d
	ld a, $04 ; $762f
	rst Rst18 ; $7631
	ld [$f50a], sp ; $7632
	ld a, $0f ; $7635
	rst Rst18 ; $7637
	inc b ; $7638
	ld a, [bc] ; $7639
	pop af ; $763a
	ld a, $04 ; $763b
	ld b, $c0 ; $763d
	rst Rst18 ; $763f
	ld l, $0a ; $7640
	ret ; $7642
	INCBIN "data/bank_011/d_7643.bin" ; $7643, 1422 bytes
	ret ; $7bd1
	INCBIN "data/bank_011/d_7bd2.bin" ; $7bd2, 451 bytes
Func_11_7d95:
	rst Rst30 ; $7d95
	ldh [rTIMA], a ; $7d96
	jr nz, Label_11_7dbc ; $7d98
	ld a, $00 ; $7d9a
	rst Rst30 ; $7d9c
	ld h, b ; $7d9d
	ld a, [bc] ; $7d9e
	jr z, Label_11_7db8 ; $7d9f
	ld a, $02 ; $7da1
	rst Rst30 ; $7da3
	ldh [$ff0a], a ; $7da4
	jr z, Label_11_7db8 ; $7da6
	ld a, $04 ; $7da8
	rst Rst30 ; $7daa
	ret nz ; $7dab
	dec d ; $7dac
	jr z, Label_11_7db8 ; $7dad
	ld a, $06 ; $7daf
	rst Rst30 ; $7db1
	nop ; $7db2
	ld d, $28 ; $7db3
	ld [bc], a ; $7db5
	ld a, $08 ; $7db6
Label_11_7db8:
	ld [$c2b0], a ; $7db8
	ret ; $7dbb
Label_11_7dbc:
	ld a, $01 ; $7dbc
	rst Rst30 ; $7dbe
	ld b, b ; $7dbf
	ld [$f528], sp ; $7dc0
	ld a, $03 ; $7dc3
	rst Rst30 ; $7dc5
	ret nz ; $7dc6
	ld [$ee28], sp ; $7dc7
	ld a, $05 ; $7dca
	rst Rst30 ; $7dcc
	ldh [$ff15], a ; $7dcd
	jr z, Label_11_7db8 ; $7dcf
	ld a, $07 ; $7dd1
	rst Rst30 ; $7dd3
	jr nz, Label_11_7dec ; $7dd4
	jr z, Label_11_7db8 ; $7dd6
	ld a, $09 ; $7dd8
	jr Label_11_7db8 ; $7dda
	INCBIN "data/bank_011/d_7ddc.bin" ; $7ddc, 16 bytes
Label_11_7dec:
	dec b ; $7dec
	jr nz, Label_11_7dff ; $7ded
	rst Rst30 ; $7def
	ret nz ; $7df0
	dec d ; $7df1
	jr z, Label_11_7dfb ; $7df2
	inc a ; $7df4
	rst Rst30 ; $7df5
	nop ; $7df6
	ld d, $28 ; $7df7
	INCBIN "data/bank_011/d_7df9.bin" ; $7df9, 2 bytes
Label_11_7dfb:
	ld [$c2b0], a ; $7dfb
	ret ; $7dfe
Label_11_7dff:
	rst Rst30 ; $7dff
	ldh [$ff15], a ; $7e00
	jr z, Label_11_7dfb ; $7e02
	inc a ; $7e04
	rst Rst30 ; $7e05
	jr nz, Label_11_7e1e ; $7e06
	jr z, Label_11_7dfb ; $7e08
	inc a ; $7e0a
	jr Label_11_7dfb ; $7e0b
	INCBIN "data/bank_011/d_7e0d.bin" ; $7e0d, 17 bytes
Label_11_7e1e:
	rst Rst38 ; $7e1e
	rst Rst38 ; $7e1f
	rst Rst38 ; $7e20
	rst Rst38 ; $7e21
	rst Rst38 ; $7e22
	rst Rst38 ; $7e23
	rst Rst38 ; $7e24
	rst Rst38 ; $7e25
	rst Rst38 ; $7e26
	rst Rst38 ; $7e27
	rst Rst38 ; $7e28
	rst Rst38 ; $7e29
	rst Rst38 ; $7e2a
	rst Rst38 ; $7e2b
	rst Rst38 ; $7e2c
	rst Rst38 ; $7e2d
	rst Rst38 ; $7e2e
	rst Rst38 ; $7e2f
	rst Rst38 ; $7e30
	rst Rst38 ; $7e31
	rst Rst38 ; $7e32
	rst Rst38 ; $7e33
	rst Rst38 ; $7e34
	rst Rst38 ; $7e35
	rst Rst38 ; $7e36
	rst Rst38 ; $7e37
	rst Rst38 ; $7e38
	rst Rst38 ; $7e39
	rst Rst38 ; $7e3a
	rst Rst38 ; $7e3b
	rst Rst38 ; $7e3c
	rst Rst38 ; $7e3d
	rst Rst38 ; $7e3e
	rst Rst38 ; $7e3f
	rst Rst38 ; $7e40
	rst Rst38 ; $7e41
	rst Rst38 ; $7e42
	rst Rst38 ; $7e43
	rst Rst38 ; $7e44
	rst Rst38 ; $7e45
	rst Rst38 ; $7e46
	rst Rst38 ; $7e47
	rst Rst38 ; $7e48
	rst Rst38 ; $7e49
	rst Rst38 ; $7e4a
	rst Rst38 ; $7e4b
	rst Rst38 ; $7e4c
	rst Rst38 ; $7e4d
	rst Rst38 ; $7e4e
	rst Rst38 ; $7e4f
	rst Rst38 ; $7e50
	rst Rst38 ; $7e51
	rst Rst38 ; $7e52
	rst Rst38 ; $7e53
	rst Rst38 ; $7e54
	rst Rst38 ; $7e55
	rst Rst38 ; $7e56
	rst Rst38 ; $7e57
	rst Rst38 ; $7e58
	rst Rst38 ; $7e59
	rst Rst38 ; $7e5a
	rst Rst38 ; $7e5b
	rst Rst38 ; $7e5c
	rst Rst38 ; $7e5d
	rst Rst38 ; $7e5e
	rst Rst38 ; $7e5f
	rst Rst38 ; $7e60
	rst Rst38 ; $7e61
	rst Rst38 ; $7e62
	rst Rst38 ; $7e63
	rst Rst38 ; $7e64
	rst Rst38 ; $7e65
	rst Rst38 ; $7e66
	rst Rst38 ; $7e67
	rst Rst38 ; $7e68
	rst Rst38 ; $7e69
	rst Rst38 ; $7e6a
	rst Rst38 ; $7e6b
	rst Rst38 ; $7e6c
	rst Rst38 ; $7e6d
	rst Rst38 ; $7e6e
	rst Rst38 ; $7e6f
	rst Rst38 ; $7e70
	rst Rst38 ; $7e71
	rst Rst38 ; $7e72
	rst Rst38 ; $7e73
	rst Rst38 ; $7e74
	rst Rst38 ; $7e75
	rst Rst38 ; $7e76
	rst Rst38 ; $7e77
	rst Rst38 ; $7e78
	rst Rst38 ; $7e79
	rst Rst38 ; $7e7a
	rst Rst38 ; $7e7b
	rst Rst38 ; $7e7c
	rst Rst38 ; $7e7d
	rst Rst38 ; $7e7e
	rst Rst38 ; $7e7f
	rst Rst38 ; $7e80
	rst Rst38 ; $7e81
	rst Rst38 ; $7e82
	rst Rst38 ; $7e83
	rst Rst38 ; $7e84
	rst Rst38 ; $7e85
	rst Rst38 ; $7e86
	rst Rst38 ; $7e87
	rst Rst38 ; $7e88
	rst Rst38 ; $7e89
	rst Rst38 ; $7e8a
	rst Rst38 ; $7e8b
	rst Rst38 ; $7e8c
	rst Rst38 ; $7e8d
	rst Rst38 ; $7e8e
	rst Rst38 ; $7e8f
	rst Rst38 ; $7e90
	rst Rst38 ; $7e91
	rst Rst38 ; $7e92
	rst Rst38 ; $7e93
	rst Rst38 ; $7e94
	rst Rst38 ; $7e95
	rst Rst38 ; $7e96
	rst Rst38 ; $7e97
	rst Rst38 ; $7e98
	rst Rst38 ; $7e99
	rst Rst38 ; $7e9a
	rst Rst38 ; $7e9b
	rst Rst38 ; $7e9c
	rst Rst38 ; $7e9d
	rst Rst38 ; $7e9e
	rst Rst38 ; $7e9f
	rst Rst38 ; $7ea0
	rst Rst38 ; $7ea1
	rst Rst38 ; $7ea2
	rst Rst38 ; $7ea3
	rst Rst38 ; $7ea4
	rst Rst38 ; $7ea5
	rst Rst38 ; $7ea6
	rst Rst38 ; $7ea7
	rst Rst38 ; $7ea8
	rst Rst38 ; $7ea9
	rst Rst38 ; $7eaa
	rst Rst38 ; $7eab
	rst Rst38 ; $7eac
	rst Rst38 ; $7ead
	rst Rst38 ; $7eae
	rst Rst38 ; $7eaf
	rst Rst38 ; $7eb0
	rst Rst38 ; $7eb1
	rst Rst38 ; $7eb2
	rst Rst38 ; $7eb3
	rst Rst38 ; $7eb4
	rst Rst38 ; $7eb5
	rst Rst38 ; $7eb6
	rst Rst38 ; $7eb7
	rst Rst38 ; $7eb8
	rst Rst38 ; $7eb9
	rst Rst38 ; $7eba
	rst Rst38 ; $7ebb
	rst Rst38 ; $7ebc
	rst Rst38 ; $7ebd
	rst Rst38 ; $7ebe
	rst Rst38 ; $7ebf
	rst Rst38 ; $7ec0
	rst Rst38 ; $7ec1
	rst Rst38 ; $7ec2
	rst Rst38 ; $7ec3
	rst Rst38 ; $7ec4
	rst Rst38 ; $7ec5
	rst Rst38 ; $7ec6
	rst Rst38 ; $7ec7
	rst Rst38 ; $7ec8
	rst Rst38 ; $7ec9
	rst Rst38 ; $7eca
	rst Rst38 ; $7ecb
	rst Rst38 ; $7ecc
	rst Rst38 ; $7ecd
	rst Rst38 ; $7ece
	rst Rst38 ; $7ecf
	rst Rst38 ; $7ed0
	rst Rst38 ; $7ed1
	rst Rst38 ; $7ed2
	rst Rst38 ; $7ed3
	rst Rst38 ; $7ed4
	rst Rst38 ; $7ed5
	rst Rst38 ; $7ed6
	rst Rst38 ; $7ed7
	rst Rst38 ; $7ed8
	rst Rst38 ; $7ed9
	rst Rst38 ; $7eda
	rst Rst38 ; $7edb
	rst Rst38 ; $7edc
	rst Rst38 ; $7edd
	rst Rst38 ; $7ede
	rst Rst38 ; $7edf
	rst Rst38 ; $7ee0
	rst Rst38 ; $7ee1
	rst Rst38 ; $7ee2
	rst Rst38 ; $7ee3
	rst Rst38 ; $7ee4
	rst Rst38 ; $7ee5
	rst Rst38 ; $7ee6
	rst Rst38 ; $7ee7
	rst Rst38 ; $7ee8
	rst Rst38 ; $7ee9
	rst Rst38 ; $7eea
	rst Rst38 ; $7eeb
	rst Rst38 ; $7eec
	rst Rst38 ; $7eed
	rst Rst38 ; $7eee
	rst Rst38 ; $7eef
	rst Rst38 ; $7ef0
	rst Rst38 ; $7ef1
	rst Rst38 ; $7ef2
	rst Rst38 ; $7ef3
	rst Rst38 ; $7ef4
	rst Rst38 ; $7ef5
	rst Rst38 ; $7ef6
	rst Rst38 ; $7ef7
	rst Rst38 ; $7ef8
	rst Rst38 ; $7ef9
	rst Rst38 ; $7efa
	rst Rst38 ; $7efb
	rst Rst38 ; $7efc
	rst Rst38 ; $7efd
	rst Rst38 ; $7efe
	rst Rst38 ; $7eff
	rst Rst38 ; $7f00
	rst Rst38 ; $7f01
	rst Rst38 ; $7f02
	rst Rst38 ; $7f03
	rst Rst38 ; $7f04
	rst Rst38 ; $7f05
	rst Rst38 ; $7f06
	rst Rst38 ; $7f07
	rst Rst38 ; $7f08
	rst Rst38 ; $7f09
	rst Rst38 ; $7f0a
	rst Rst38 ; $7f0b
	rst Rst38 ; $7f0c
	rst Rst38 ; $7f0d
	rst Rst38 ; $7f0e
	rst Rst38 ; $7f0f
	rst Rst38 ; $7f10
	rst Rst38 ; $7f11
	rst Rst38 ; $7f12
	rst Rst38 ; $7f13
	rst Rst38 ; $7f14
	rst Rst38 ; $7f15
	rst Rst38 ; $7f16
	rst Rst38 ; $7f17
	rst Rst38 ; $7f18
	rst Rst38 ; $7f19
	rst Rst38 ; $7f1a
	rst Rst38 ; $7f1b
	rst Rst38 ; $7f1c
	rst Rst38 ; $7f1d
	rst Rst38 ; $7f1e
	rst Rst38 ; $7f1f
	rst Rst38 ; $7f20
	rst Rst38 ; $7f21
	rst Rst38 ; $7f22
	rst Rst38 ; $7f23
	rst Rst38 ; $7f24
	rst Rst38 ; $7f25
	rst Rst38 ; $7f26
	rst Rst38 ; $7f27
	rst Rst38 ; $7f28
	rst Rst38 ; $7f29
	rst Rst38 ; $7f2a
	rst Rst38 ; $7f2b
	rst Rst38 ; $7f2c
	rst Rst38 ; $7f2d
	rst Rst38 ; $7f2e
	rst Rst38 ; $7f2f
	rst Rst38 ; $7f30
	rst Rst38 ; $7f31
	rst Rst38 ; $7f32
	rst Rst38 ; $7f33
	rst Rst38 ; $7f34
	rst Rst38 ; $7f35
	rst Rst38 ; $7f36
	rst Rst38 ; $7f37
	rst Rst38 ; $7f38
	rst Rst38 ; $7f39
	rst Rst38 ; $7f3a
	rst Rst38 ; $7f3b
	rst Rst38 ; $7f3c
	rst Rst38 ; $7f3d
	rst Rst38 ; $7f3e
	rst Rst38 ; $7f3f
	rst Rst38 ; $7f40
	rst Rst38 ; $7f41
	rst Rst38 ; $7f42
	rst Rst38 ; $7f43
	rst Rst38 ; $7f44
	rst Rst38 ; $7f45
	rst Rst38 ; $7f46
	rst Rst38 ; $7f47
	rst Rst38 ; $7f48
	rst Rst38 ; $7f49
	rst Rst38 ; $7f4a
	rst Rst38 ; $7f4b
	rst Rst38 ; $7f4c
	rst Rst38 ; $7f4d
	rst Rst38 ; $7f4e
	rst Rst38 ; $7f4f
	rst Rst38 ; $7f50
	rst Rst38 ; $7f51
	rst Rst38 ; $7f52
	rst Rst38 ; $7f53
	rst Rst38 ; $7f54
	rst Rst38 ; $7f55
	rst Rst38 ; $7f56
	rst Rst38 ; $7f57
	rst Rst38 ; $7f58
	rst Rst38 ; $7f59
	rst Rst38 ; $7f5a
	rst Rst38 ; $7f5b
	rst Rst38 ; $7f5c
	rst Rst38 ; $7f5d
	rst Rst38 ; $7f5e
	rst Rst38 ; $7f5f
	rst Rst38 ; $7f60
	rst Rst38 ; $7f61
	rst Rst38 ; $7f62
	rst Rst38 ; $7f63
	rst Rst38 ; $7f64
	rst Rst38 ; $7f65
	rst Rst38 ; $7f66
	rst Rst38 ; $7f67
	rst Rst38 ; $7f68
	rst Rst38 ; $7f69
	rst Rst38 ; $7f6a
	rst Rst38 ; $7f6b
	rst Rst38 ; $7f6c
	rst Rst38 ; $7f6d
	rst Rst38 ; $7f6e
	rst Rst38 ; $7f6f
	rst Rst38 ; $7f70
	rst Rst38 ; $7f71
	rst Rst38 ; $7f72
	rst Rst38 ; $7f73
	rst Rst38 ; $7f74
	rst Rst38 ; $7f75
	rst Rst38 ; $7f76
	rst Rst38 ; $7f77
	rst Rst38 ; $7f78
	rst Rst38 ; $7f79
	rst Rst38 ; $7f7a
	rst Rst38 ; $7f7b
	rst Rst38 ; $7f7c
	rst Rst38 ; $7f7d
	rst Rst38 ; $7f7e
	rst Rst38 ; $7f7f
	rst Rst38 ; $7f80
	rst Rst38 ; $7f81
	rst Rst38 ; $7f82
	rst Rst38 ; $7f83
	rst Rst38 ; $7f84
	rst Rst38 ; $7f85
	rst Rst38 ; $7f86
	rst Rst38 ; $7f87
	rst Rst38 ; $7f88
	rst Rst38 ; $7f89
	rst Rst38 ; $7f8a
	rst Rst38 ; $7f8b
	rst Rst38 ; $7f8c
	rst Rst38 ; $7f8d
	rst Rst38 ; $7f8e
	rst Rst38 ; $7f8f
	rst Rst38 ; $7f90
	rst Rst38 ; $7f91
	rst Rst38 ; $7f92
	rst Rst38 ; $7f93
	rst Rst38 ; $7f94
	rst Rst38 ; $7f95
	rst Rst38 ; $7f96
	rst Rst38 ; $7f97
	rst Rst38 ; $7f98
	rst Rst38 ; $7f99
	rst Rst38 ; $7f9a
	rst Rst38 ; $7f9b
	rst Rst38 ; $7f9c
	rst Rst38 ; $7f9d
	rst Rst38 ; $7f9e
	rst Rst38 ; $7f9f
	rst Rst38 ; $7fa0
	rst Rst38 ; $7fa1
	rst Rst38 ; $7fa2
	rst Rst38 ; $7fa3
	rst Rst38 ; $7fa4
	rst Rst38 ; $7fa5
	rst Rst38 ; $7fa6
	rst Rst38 ; $7fa7
	rst Rst38 ; $7fa8
	rst Rst38 ; $7fa9
	rst Rst38 ; $7faa
	rst Rst38 ; $7fab
	rst Rst38 ; $7fac
	rst Rst38 ; $7fad
	rst Rst38 ; $7fae
	rst Rst38 ; $7faf
	rst Rst38 ; $7fb0
	rst Rst38 ; $7fb1
	rst Rst38 ; $7fb2
	rst Rst38 ; $7fb3
	rst Rst38 ; $7fb4
	rst Rst38 ; $7fb5
	rst Rst38 ; $7fb6
	rst Rst38 ; $7fb7
	rst Rst38 ; $7fb8
	rst Rst38 ; $7fb9
	rst Rst38 ; $7fba
	rst Rst38 ; $7fbb
	rst Rst38 ; $7fbc
	rst Rst38 ; $7fbd
	rst Rst38 ; $7fbe
	rst Rst38 ; $7fbf
	rst Rst38 ; $7fc0
	rst Rst38 ; $7fc1
	rst Rst38 ; $7fc2
	rst Rst38 ; $7fc3
	rst Rst38 ; $7fc4
	rst Rst38 ; $7fc5
	rst Rst38 ; $7fc6
	rst Rst38 ; $7fc7
	rst Rst38 ; $7fc8
	rst Rst38 ; $7fc9
	rst Rst38 ; $7fca
	rst Rst38 ; $7fcb
	rst Rst38 ; $7fcc
	rst Rst38 ; $7fcd
	rst Rst38 ; $7fce
	rst Rst38 ; $7fcf
	rst Rst38 ; $7fd0
	rst Rst38 ; $7fd1
	rst Rst38 ; $7fd2
	rst Rst38 ; $7fd3
	rst Rst38 ; $7fd4
	rst Rst38 ; $7fd5
	rst Rst38 ; $7fd6
	rst Rst38 ; $7fd7
	rst Rst38 ; $7fd8
	rst Rst38 ; $7fd9
	rst Rst38 ; $7fda
	rst Rst38 ; $7fdb
	rst Rst38 ; $7fdc
	rst Rst38 ; $7fdd
	rst Rst38 ; $7fde
	rst Rst38 ; $7fdf
	rst Rst38 ; $7fe0
	rst Rst38 ; $7fe1
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

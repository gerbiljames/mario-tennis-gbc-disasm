INCLUDE "hardware.inc"
INCLUDE "macros.inc"
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
	farcall FarPtr_0a_0e ; $4085
	rst Rst30 ; $4088
	ldh [rTIMA], a ; $4089
	jr nz, Label_11_409c ; $408b
	ld a, [$c2b0] ; $408d
	cp a, $03 ; $4090
	jr nz, Label_11_40a9 ; $4092
	ld hl, $245b ; $4094
	farcall FarPtr_0a_0e ; $4097
	jr Label_11_40a9 ; $409a
Label_11_409c:
	ld a, [$c2b0] ; $409c
	cp a, $06 ; $409f
	jr nz, Label_11_40a9 ; $40a1
	ld hl, $245b ; $40a3
	farcall FarPtr_0a_0e ; $40a6
Label_11_40a9:
	ld a, $03 ; $40a9
	farcall FarPtr_0a_08 ; $40ab
	ret ; $40ae
	INCBIN "data/bank_011/d_40af.bin" ; $40af, 1302 bytes
	farcall FarPtr_0a_0a ; $45c5
	farcall FarPtr_0a_12 ; $45c8
	farcall FarPtr_0a_0c ; $45cb
	push af ; $45ce
	ld a, $05 ; $45cf
	farcall FarPtr_0a_04 ; $45d1
	pop af ; $45d4
	and a, a ; $45d5
	jr z, Label_11_45db ; $45d6
	farcall FarPtr_0a_10 ; $45d8
Label_11_45db:
	ld a, $03 ; $45db
	farcall FarPtr_0a_08 ; $45dd
	ret ; $45e0
	INCBIN "data/bank_011/d_45e1.bin" ; $45e1, 129 bytes
	farcall FarPtr_0a_34 ; $4662
	ld a, $14 ; $4665
	farcall FarPtr_0a_36 ; $4667
	ld a, $14 ; $466a
	farcall FarPtr_0a_08 ; $466c
	ret ; $466f
	INCBIN "data/bank_011/d_4670.bin" ; $4670, 65 bytes
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
	farcall FarPtr_0a_18 ; $46d4
	xor a, a ; $46d7
	ld [$c2d5], a ; $46d8
	ld a, $11 ; $46db
	ld bc, $1800 ; $46dd
	ld de, $0d00 ; $46e0
	farcall FarPtr_0a_22 ; $46e3
	ld a, $00 ; $46e6
	ld bc, $1800 ; $46e8
	ld de, $3700 ; $46eb
	farcall FarPtr_0a_22 ; $46ee
	ld a, $14 ; $46f1
	ld bc, $3f00 ; $46f3
	ld de, $3f00 ; $46f6
	farcall FarPtr_0a_22 ; $46f9
	ld a, $03 ; $46fc
	ld bc, $2280 ; $46fe
	ld de, $1500 ; $4701
	farcall FarPtr_0a_22 ; $4704
	ld a, $03 ; $4707
	ld b, $00 ; $4709
	farcall FarPtr_0a_2e ; $470b
	ld a, $04 ; $470e
	ld bc, $3300 ; $4710
	ld de, $1500 ; $4713
	farcall FarPtr_0a_22 ; $4716
	ld a, $05 ; $4719
	ld bc, $3300 ; $471b
	ld de, $1500 ; $471e
	farcall FarPtr_0a_22 ; $4721
	ld c, $04 ; $4724
	call Func_00_1d2e ; $4726
	call Func_00_1da4 ; $4729
	ld a, $00 ; $472c
	ld bc, $1800 ; $472e
	ld de, $2d00 ; $4731
	farcall FarPtr_0a_24 ; $4734
	ld a, $00 ; $4737
	farcall FarPtr_0a_20 ; $4739
	ld a, $00 ; $473c
	ld b, $00 ; $473e
	farcall FarPtr_0a_2e ; $4740
	push af ; $4743
	ld a, $28 ; $4744
	farcall FarPtr_0a_04 ; $4746
	pop af ; $4749
	ld a, $00 ; $474a
	ld b, $c0 ; $474c
	farcall FarPtr_0a_2e ; $474e
	push af ; $4751
	ld a, $28 ; $4752
	farcall FarPtr_0a_04 ; $4754
	pop af ; $4757
	ld a, $00 ; $4758
	ld b, $80 ; $475a
	farcall FarPtr_0a_2e ; $475c
	push af ; $475f
	ld a, $28 ; $4760
	farcall FarPtr_0a_04 ; $4762
	pop af ; $4765
	ld a, $00 ; $4766
	ld b, $c0 ; $4768
	farcall FarPtr_0a_2e ; $476a
	push af ; $476d
	ld a, $28 ; $476e
	farcall FarPtr_0a_04 ; $4770
	pop af ; $4773
	ld a, $00 ; $4774
	ld b, $00 ; $4776
	farcall FarPtr_0a_2e ; $4778
	push af ; $477b
	ld a, $0a ; $477c
	farcall FarPtr_0a_04 ; $477e
	pop af ; $4781
	ld a, $00 ; $4782
	ld b, $40 ; $4784
	farcall FarPtr_0a_2e ; $4786
	push af ; $4789
	ld a, $3c ; $478a
	farcall FarPtr_0a_04 ; $478c
	pop af ; $478f
	ld a, $00 ; $4790
	ld d, $03 ; $4792
	farcall FarPtr_0a_34 ; $4794
	ld a, $00 ; $4797
	farcall FarPtr_0a_36 ; $4799
	push af ; $479c
	ld a, $3c ; $479d
	farcall FarPtr_0a_04 ; $479f
	pop af ; $47a2
	ld a, $00 ; $47a3
	ld bc, $1800 ; $47a5
	ld de, $2100 ; $47a8
	farcall FarPtr_0a_24 ; $47ab
	ld bc, $0040 ; $47ae
	farcall FarPtr_0a_38 ; $47b1
	xor a, a ; $47b4
	ld bc, $1800 ; $47b5
	ld de, $1200 ; $47b8
	farcall FarPtr_0a_3a ; $47bb
	farcall FarPtr_0a_3e ; $47be
	push af ; $47c1
	ld a, $3c ; $47c2
	farcall FarPtr_0a_04 ; $47c4
	pop af ; $47c7
	ld a, $00 ; $47c8
	ld bc, $1800 ; $47ca
	ld de, $2000 ; $47cd
	farcall FarPtr_0a_22 ; $47d0
	ld a, $00 ; $47d3
	ld b, $c0 ; $47d5
	farcall FarPtr_0a_2e ; $47d7
	ld a, $11 ; $47da
	ld bc, $0024 ; $47dc
	farcall FarPtr_0a_18 ; $47df
	ld a, $11 ; $47e2
	ld bc, $1800 ; $47e4
	ld de, $1400 ; $47e7
	farcall FarPtr_0a_24 ; $47ea
	ld a, $11 ; $47ed
	farcall FarPtr_0a_20 ; $47ef
	ld a, $11 ; $47f2
	ld d, $04 ; $47f4
	farcall FarPtr_0a_34 ; $47f6
	ld a, $11 ; $47f9
	farcall FarPtr_0a_36 ; $47fb
	ld a, $11 ; $47fe
	ld b, $c0 ; $4800
	farcall FarPtr_0a_2e ; $4802
	ld hl, $184f ; $4805
	farcall FarPtr_0a_0e ; $4808
	ld a, $11 ; $480b
	farcall FarPtr_0a_08 ; $480d
	ld a, $11 ; $4810
	ld d, $03 ; $4812
	farcall FarPtr_0a_34 ; $4814
	ld a, $11 ; $4817
	farcall FarPtr_0a_36 ; $4819
	ld a, $11 ; $481c
	ld bc, $0020 ; $481e
	farcall FarPtr_0a_18 ; $4821
	ld a, $11 ; $4824
	farcall FarPtr_0a_08 ; $4826
	ld a, $11 ; $4829
	ld b, $40 ; $482b
	farcall FarPtr_0a_2e ; $482d
	ld a, $11 ; $4830
	ld de, $ff80 ; $4832
	farcall FarPtr_0a_42 ; $4835
	ld a, $11 ; $4838
	farcall FarPtr_0a_44 ; $483a
	ld a, $11 ; $483d
	ld bc, $1800 ; $483f
	ld de, $1700 ; $4842
	farcall FarPtr_0a_24 ; $4845
	ld a, $11 ; $4848
	farcall FarPtr_0a_20 ; $484a
	ld a, $0e ; $484d
	ld bc, $1980 ; $484f
	ld de, $15c0 ; $4852
	farcall FarPtr_0a_22 ; $4855
	rst Rst08 ; $4858
	sbc a, b ; $4859
	ld a, $11 ; $485a
	ld bc, $0010 ; $485c
	farcall FarPtr_0a_18 ; $485f
	ld a, $0e ; $4862
	ld bc, $0010 ; $4864
	farcall FarPtr_0a_18 ; $4867
	ld a, $0e ; $486a
	ld bc, $1980 ; $486c
	ld de, $18c0 ; $486f
	farcall FarPtr_0a_24 ; $4872
	ld a, $11 ; $4875
	ld bc, $1800 ; $4877
	ld de, $1a00 ; $487a
	farcall FarPtr_0a_24 ; $487d
	ld a, $11 ; $4880
	farcall FarPtr_0a_20 ; $4882
	ld a, $11 ; $4885
	farcall FarPtr_0a_08 ; $4887
	ld a, $0e ; $488a
	ld bc, $3f00 ; $488c
	ld de, $3f00 ; $488f
	farcall FarPtr_0a_22 ; $4892
	ld a, $11 ; $4895
	ld bc, $1800 ; $4897
	ld de, $1600 ; $489a
	farcall FarPtr_0a_24 ; $489d
	ld a, $11 ; $48a0
	farcall FarPtr_0a_20 ; $48a2
	push af ; $48a5
	ld a, $1e ; $48a6
	farcall FarPtr_0a_04 ; $48a8
	pop af ; $48ab
	ld a, $11 ; $48ac
	ld d, $02 ; $48ae
	farcall FarPtr_0a_34 ; $48b0
	ld a, $0f ; $48b3
	ld bc, $1980 ; $48b5
	ld de, $14c0 ; $48b8
	farcall FarPtr_0a_22 ; $48bb
	rst Rst08 ; $48be
	sub a, a ; $48bf
	push af ; $48c0
	ld a, $14 ; $48c1
	farcall FarPtr_0a_04 ; $48c3
	pop af ; $48c6
	ld a, $11 ; $48c7
	farcall FarPtr_0a_08 ; $48c9
	ld a, $0f ; $48cc
	ld bc, $3f00 ; $48ce
	ld de, $3f00 ; $48d1
	farcall FarPtr_0a_22 ; $48d4
	ld a, $11 ; $48d7
	ld bc, $0020 ; $48d9
	farcall FarPtr_0a_18 ; $48dc
	ld a, $11 ; $48df
	ld de, $ff80 ; $48e1
	farcall FarPtr_0a_42 ; $48e4
	ld a, $11 ; $48e7
	farcall FarPtr_0a_44 ; $48e9
	ld a, $11 ; $48ec
	ld bc, $1800 ; $48ee
	ld de, $2000 ; $48f1
	farcall FarPtr_0a_24 ; $48f4
	push af ; $48f7
	ld a, $1e ; $48f8
	farcall FarPtr_0a_04 ; $48fa
	pop af ; $48fd
	ld bc, $d040 ; $48fe
	ld a, $11 ; $4901
	farcall FarPtr_0a_16 ; $4903
	ld e, l ; $4906
	ld d, h ; $4907
	farcall FarPtr_04_1e ; $4908
	ld a, $00 ; $490b
	ld bc, $1800 ; $490d
	ld de, $1e00 ; $4910
	farcall FarPtr_0a_24 ; $4913
	push af ; $4916
	ld a, $14 ; $4917
	farcall FarPtr_0a_04 ; $4919
	pop af ; $491c
	call Func_11_4cf6 ; $491d
	ld a, $11 ; $4920
	farcall FarPtr_0a_20 ; $4922
	ld a, $11 ; $4925
	ld d, $02 ; $4927
	farcall FarPtr_0a_34 ; $4929
	ld a, $10 ; $492c
	ld bc, $1900 ; $492e
	ld de, $1e00 ; $4931
	farcall FarPtr_0a_22 ; $4934
	rst Rst08 ; $4937
	sub a, [hl] ; $4938
	push af ; $4939
	ld a, $3c ; $493a
	farcall FarPtr_0a_04 ; $493c
	pop af ; $493f
	ld a, $10 ; $4940
	ld bc, $3f00 ; $4942
	ld de, $3f00 ; $4945
	farcall FarPtr_0a_22 ; $4948
	ld a, $11 ; $494b
	ld bc, $1700 ; $494d
	ld de, $2200 ; $4950
	farcall FarPtr_0a_24 ; $4953
	ld a, $11 ; $4956
	farcall FarPtr_0a_20 ; $4958
	ld a, $00 ; $495b
	ld b, a ; $495d
	ld a, $11 ; $495e
	farcall FarPtr_0a_30 ; $4960
	ld a, $11 ; $4963
	farcall FarPtr_0a_08 ; $4965
	ld a, $11 ; $4968
	ld bc, $1900 ; $496a
	ld de, $2400 ; $496d
	farcall FarPtr_0a_24 ; $4970
	ld a, $11 ; $4973
	farcall FarPtr_0a_20 ; $4975
	ld a, $01 ; $4978
	farcall FarPtr_0a_1c ; $497a
	ld a, $00 ; $497d
	ld b, a ; $497f
	ld a, $11 ; $4980
	farcall FarPtr_0a_30 ; $4982
	ld a, $11 ; $4985
	ld d, $02 ; $4987
	farcall FarPtr_0a_34 ; $4989
	ld a, $11 ; $498c
	farcall FarPtr_0a_36 ; $498e
	ld a, $11 ; $4991
	farcall FarPtr_0a_08 ; $4993
	ld a, $13 ; $4996
	ld bc, $1a80 ; $4998
	ld de, $2280 ; $499b
	farcall FarPtr_0a_22 ; $499e
	push af ; $49a1
	ld a, $3c ; $49a2
	farcall FarPtr_0a_04 ; $49a4
	pop af ; $49a7
	ld a, $13 ; $49a8
	ld bc, $3f00 ; $49aa
	ld de, $3f00 ; $49ad
	farcall FarPtr_0a_22 ; $49b0
	ld a, $11 ; $49b3
	ld bc, $1900 ; $49b5
	ld de, $2300 ; $49b8
	farcall FarPtr_0a_24 ; $49bb
	ld a, $11 ; $49be
	farcall FarPtr_0a_20 ; $49c0
	ld a, $11 ; $49c3
	ld bc, $1a00 ; $49c5
	ld de, $2300 ; $49c8
	farcall FarPtr_0a_24 ; $49cb
	ld a, $11 ; $49ce
	farcall FarPtr_0a_20 ; $49d0
	ld a, $11 ; $49d3
	ld bc, $1a00 ; $49d5
	ld de, $2400 ; $49d8
	farcall FarPtr_0a_24 ; $49db
	ld a, $11 ; $49de
	farcall FarPtr_0a_20 ; $49e0
	ld a, $11 ; $49e3
	ld bc, $1900 ; $49e5
	ld de, $2400 ; $49e8
	farcall FarPtr_0a_24 ; $49eb
	ld a, $11 ; $49ee
	farcall FarPtr_0a_20 ; $49f0
	ld a, $11 ; $49f3
	ld bc, $1900 ; $49f5
	ld de, $2500 ; $49f8
	farcall FarPtr_0a_24 ; $49fb
	ld a, $11 ; $49fe
	farcall FarPtr_0a_20 ; $4a00
	ld a, $11 ; $4a03
	ld bc, $1a00 ; $4a05
	ld de, $2500 ; $4a08
	farcall FarPtr_0a_24 ; $4a0b
	ld a, $11 ; $4a0e
	farcall FarPtr_0a_20 ; $4a10
	ld a, $11 ; $4a13
	ld bc, $1a00 ; $4a15
	ld de, $2400 ; $4a18
	farcall FarPtr_0a_24 ; $4a1b
	ld a, $11 ; $4a1e
	farcall FarPtr_0a_20 ; $4a20
	ld a, $11 ; $4a23
	ld bc, $1900 ; $4a25
	ld de, $2400 ; $4a28
	farcall FarPtr_0a_24 ; $4a2b
	ld a, $11 ; $4a2e
	farcall FarPtr_0a_20 ; $4a30
	ld a, $00 ; $4a33
	ld b, a ; $4a35
	ld a, $11 ; $4a36
	farcall FarPtr_0a_30 ; $4a38
	push af ; $4a3b
	ld a, $3c ; $4a3c
	farcall FarPtr_0a_04 ; $4a3e
	pop af ; $4a41
	ld a, $11 ; $4a42
	ld d, $02 ; $4a44
	farcall FarPtr_0a_34 ; $4a46
	ld a, $11 ; $4a49
	farcall FarPtr_0a_36 ; $4a4b
	ld a, $11 ; $4a4e
	farcall FarPtr_0a_08 ; $4a50
	call Func_11_4d68 ; $4a53
	ld a, $11 ; $4a56
	ld b, $01 ; $4a58
	farcall FarPtr_0a_2c ; $4a5a
	ld a, $11 ; $4a5d
	ld d, $05 ; $4a5f
	farcall FarPtr_0a_34 ; $4a61
	push af ; $4a64
	ld a, $14 ; $4a65
	farcall FarPtr_0a_04 ; $4a67
	pop af ; $4a6a
	ld a, $11 ; $4a6b
	ld de, $ff80 ; $4a6d
	farcall FarPtr_0a_42 ; $4a70
	ld a, $11 ; $4a73
	ld bc, $1b00 ; $4a75
	ld de, $2400 ; $4a78
	farcall FarPtr_0a_24 ; $4a7b
	push af ; $4a7e
	ld a, $14 ; $4a7f
	farcall FarPtr_0a_04 ; $4a81
	pop af ; $4a84
	ld a, $11 ; $4a85
	ld b, a ; $4a87
	ld a, $00 ; $4a88
	farcall FarPtr_0a_30 ; $4a8a
	push af ; $4a8d
	ld a, $14 ; $4a8e
	farcall FarPtr_0a_04 ; $4a90
	pop af ; $4a93
	ld a, $00 ; $4a94
	ld d, $02 ; $4a96
	farcall FarPtr_0a_34 ; $4a98
	ld a, $00 ; $4a9b
	farcall FarPtr_0a_36 ; $4a9d
	ld a, $11 ; $4aa0
	ld d, $02 ; $4aa2
	farcall FarPtr_0a_34 ; $4aa4
	ld a, $11 ; $4aa7
	farcall FarPtr_0a_36 ; $4aa9
	ld a, $00 ; $4aac
	ld b, a ; $4aae
	ld a, $11 ; $4aaf
	farcall FarPtr_0a_30 ; $4ab1
	ld a, $11 ; $4ab4
	ld bc, $1a00 ; $4ab6
	ld de, $2400 ; $4ab9
	farcall FarPtr_0a_24 ; $4abc
	ld a, $11 ; $4abf
	farcall FarPtr_0a_20 ; $4ac1
	ld a, $11 ; $4ac4
	ld b, $00 ; $4ac6
	farcall FarPtr_0a_2c ; $4ac8
	ld a, $00 ; $4acb
	ld d, $02 ; $4acd
	farcall FarPtr_0a_34 ; $4acf
	ld a, $00 ; $4ad2
	farcall FarPtr_0a_36 ; $4ad4
	ld a, $11 ; $4ad7
	ld d, $02 ; $4ad9
	farcall FarPtr_0a_34 ; $4adb
	ld a, $11 ; $4ade
	farcall FarPtr_0a_36 ; $4ae0
	ld a, $11 ; $4ae3
	farcall FarPtr_0a_08 ; $4ae5
	ld a, $11 ; $4ae8
	ld d, $02 ; $4aea
	farcall FarPtr_0a_34 ; $4aec
	ld a, $11 ; $4aef
	farcall FarPtr_0a_36 ; $4af1
Label_11_4af4:
	ld hl, $1857 ; $4af4
	farcall FarPtr_0a_0e ; $4af7
	ld a, $11 ; $4afa
	farcall FarPtr_0a_0a ; $4afc
	farcall FarPtr_0a_12 ; $4aff
	farcall FarPtr_0a_0c ; $4b02
	push af ; $4b05
	ld a, $05 ; $4b06
	farcall FarPtr_0a_04 ; $4b08
	pop af ; $4b0b
	and a, a ; $4b0c
	jr z, Label_11_4b1d ; $4b0d
	ld a, $11 ; $4b0f
	ld d, $02 ; $4b11
	farcall FarPtr_0a_34 ; $4b13
	ld a, $11 ; $4b16
	farcall FarPtr_0a_08 ; $4b18
	jr Label_11_4af4 ; $4b1b
Label_11_4b1d:
	ld hl, $1859 ; $4b1d
	farcall FarPtr_0a_0e ; $4b20
	ld a, $11 ; $4b23
	ld d, $03 ; $4b25
	farcall FarPtr_0a_34 ; $4b27
	ld a, $11 ; $4b2a
	farcall FarPtr_0a_36 ; $4b2c
	ld a, $11 ; $4b2f
	farcall FarPtr_0a_08 ; $4b31
	push af ; $4b34
	ld a, $3c ; $4b35
	farcall FarPtr_0a_04 ; $4b37
	pop af ; $4b3a
	ld a, $0e ; $4b3b
	ld bc, $1b80 ; $4b3d
	ld de, $21c0 ; $4b40
	farcall FarPtr_0a_22 ; $4b43
	rst Rst08 ; $4b46
	sbc a, b ; $4b47
	push af ; $4b48
	ld a, $28 ; $4b49
	farcall FarPtr_0a_04 ; $4b4b
	pop af ; $4b4e
	ld a, $0e ; $4b4f
	ld bc, $3f00 ; $4b51
	ld de, $3f00 ; $4b54
	farcall FarPtr_0a_22 ; $4b57
	ld a, $11 ; $4b5a
	ld b, $80 ; $4b5c
	ld de, $0100 ; $4b5e
	farcall FarPtr_0a_2a ; $4b61
	ld a, $11 ; $4b64
	farcall FarPtr_0a_20 ; $4b66
	ld a, $11 ; $4b69
	farcall FarPtr_0a_08 ; $4b6b
	ld a, $00 ; $4b6e
	ld d, $03 ; $4b70
	farcall FarPtr_0a_34 ; $4b72
	ld a, $00 ; $4b75
	farcall FarPtr_0a_36 ; $4b77
	ld a, $0e ; $4b7a
	ld bc, $1a80 ; $4b7c
	ld de, $21c0 ; $4b7f
	farcall FarPtr_0a_22 ; $4b82
	push af ; $4b85
	ld a, $3c ; $4b86
	farcall FarPtr_0a_04 ; $4b88
	pop af ; $4b8b
	ld a, $0e ; $4b8c
	ld bc, $3f00 ; $4b8e
	ld de, $3f00 ; $4b91
	farcall FarPtr_0a_22 ; $4b94
	push af ; $4b97
	ld a, $3c ; $4b98
	farcall FarPtr_0a_04 ; $4b9a
	pop af ; $4b9d
	ld a, $0f ; $4b9e
	ld bc, $1a80 ; $4ba0
	ld de, $21c0 ; $4ba3
	farcall FarPtr_0a_22 ; $4ba6
	rst Rst08 ; $4ba9
	sub a, a ; $4baa
	ld a, $11 ; $4bab
	ld de, $ff80 ; $4bad
	farcall FarPtr_0a_42 ; $4bb0
	ld a, $11 ; $4bb3
	farcall FarPtr_0a_44 ; $4bb5
	push af ; $4bb8
	ld a, $0a ; $4bb9
	farcall FarPtr_0a_04 ; $4bbb
	pop af ; $4bbe
	ld a, $0f ; $4bbf
	ld bc, $3f00 ; $4bc1
	ld de, $3f00 ; $4bc4
	farcall FarPtr_0a_22 ; $4bc7
	ld a, $11 ; $4bca
	farcall FarPtr_0a_08 ; $4bcc
	ld a, $11 ; $4bcf
	ld d, $02 ; $4bd1
	farcall FarPtr_0a_34 ; $4bd3
	ld a, $11 ; $4bd6
	farcall FarPtr_0a_36 ; $4bd8
	ld a, $11 ; $4bdb
	farcall FarPtr_0a_08 ; $4bdd
	ld a, $00 ; $4be0
	ld d, $03 ; $4be2
	farcall FarPtr_0a_34 ; $4be4
	ld a, $00 ; $4be7
	farcall FarPtr_0a_36 ; $4be9
	ld a, $11 ; $4bec
	ld d, $03 ; $4bee
	farcall FarPtr_0a_34 ; $4bf0
	ld a, $11 ; $4bf3
	farcall FarPtr_0a_36 ; $4bf5
	ld a, $11 ; $4bf8
	farcall FarPtr_0a_08 ; $4bfa
	push af ; $4bfd
	ld a, $0a ; $4bfe
	farcall FarPtr_0a_04 ; $4c00
	pop af ; $4c03
	ld a, $00 ; $4c04
	ld d, $03 ; $4c06
	farcall FarPtr_0a_34 ; $4c08
	ld a, $00 ; $4c0b
	farcall FarPtr_0a_36 ; $4c0d
	push af ; $4c10
	ld a, $3c ; $4c11
	farcall FarPtr_0a_04 ; $4c13
	pop af ; $4c16
	ld bc, $0060 ; $4c17
	farcall FarPtr_0a_38 ; $4c1a
	ld a, $11 ; $4c1d
	ld b, $c0 ; $4c1f
	farcall FarPtr_0a_2e ; $4c21
	ld a, $11 ; $4c24
	ld d, $02 ; $4c26
	farcall FarPtr_0a_34 ; $4c28
	ld a, $11 ; $4c2b
	farcall FarPtr_0a_36 ; $4c2d
	ld a, $0f ; $4c30
	ld bc, $1a80 ; $4c32
	ld de, $21c0 ; $4c35
	farcall FarPtr_0a_22 ; $4c38
	rst Rst08 ; $4c3b
	sub a, a ; $4c3c
	push af ; $4c3d
	ld a, $28 ; $4c3e
	farcall FarPtr_0a_04 ; $4c40
	pop af ; $4c43
	ld a, $0f ; $4c44
	ld bc, $3f00 ; $4c46
	ld de, $3f00 ; $4c49
	farcall FarPtr_0a_22 ; $4c4c
	ld a, $11 ; $4c4f
	ld b, $c0 ; $4c51
	farcall FarPtr_0a_2e ; $4c53
	ld a, $11 ; $4c56
	ld d, $02 ; $4c58
	farcall FarPtr_0a_34 ; $4c5a
	xor a, a ; $4c5d
	ld bc, $1800 ; $4c5e
	ld de, $0b00 ; $4c61
	farcall FarPtr_0a_3a ; $4c64
	farcall FarPtr_0a_3e ; $4c67
	ld a, $11 ; $4c6a
	ld b, $00 ; $4c6c
	farcall FarPtr_0a_48 ; $4c6e
	ld a, $11 ; $4c71
	ld bc, $1900 ; $4c73
	ld de, $0600 ; $4c76
	farcall FarPtr_0a_22 ; $4c79
	ld a, $11 ; $4c7c
	farcall FarPtr_0a_08 ; $4c7e
	ld a, $11 ; $4c81
	ld bc, $1900 ; $4c83
	ld de, $2400 ; $4c86
	farcall FarPtr_0a_22 ; $4c89
	ld a, $11 ; $4c8c
	ld b, $02 ; $4c8e
	farcall FarPtr_0a_48 ; $4c90
	xor a, a ; $4c93
	ld bc, $1800 ; $4c94
	ld de, $2400 ; $4c97
	farcall FarPtr_0a_3a ; $4c9a
	farcall FarPtr_0a_3e ; $4c9d
	ld a, $00 ; $4ca0
	ld b, a ; $4ca2
	ld a, $11 ; $4ca3
	farcall FarPtr_0a_30 ; $4ca5
	ld a, $11 ; $4ca8
	farcall FarPtr_0a_08 ; $4caa
	ld a, $11 ; $4cad
	ld d, $03 ; $4caf
	farcall FarPtr_0a_34 ; $4cb1
	ld a, $11 ; $4cb4
	farcall FarPtr_0a_36 ; $4cb6
	ld a, $00 ; $4cb9
	ld d, $03 ; $4cbb
	farcall FarPtr_0a_34 ; $4cbd
	ld a, $00 ; $4cc0
	farcall FarPtr_0a_36 ; $4cc2
	ld a, $11 ; $4cc5
	ld de, $ff80 ; $4cc7
	farcall FarPtr_0a_42 ; $4cca
	ld a, $11 ; $4ccd
	farcall FarPtr_0a_44 ; $4ccf
	ld a, $11 ; $4cd2
	ld bc, $1800 ; $4cd4
	ld de, $3300 ; $4cd7
	farcall FarPtr_0a_24 ; $4cda
	push af ; $4cdd
	ld a, $14 ; $4cde
	farcall FarPtr_0a_04 ; $4ce0
	pop af ; $4ce3
	ld a, $00 ; $4ce4
	ld b, $40 ; $4ce6
	farcall FarPtr_0a_2e ; $4ce8
	push af ; $4ceb
	ld a, $5a ; $4cec
	farcall FarPtr_0a_04 ; $4cee
	pop af ; $4cf1
	call Func_11_4d94 ; $4cf2
	ret ; $4cf5
Func_11_4cf6:
	ld a, $01 ; $4cf6
	farcall FarPtr_0a_1c ; $4cf8
	rst Rst08 ; $4cfb
	ld [hl], b ; $4cfc
	ld a, $03 ; $4cfd
	farcall FarPtr_0a_40 ; $4cff
	push af ; $4d02
	ld a, $0a ; $4d03
	farcall FarPtr_0a_04 ; $4d05
	pop af ; $4d08
	ld a, $00 ; $4d09
	farcall FarPtr_0a_40 ; $4d0b
	ld a, $00 ; $4d0e
	ld bc, $0040 ; $4d10
	farcall FarPtr_0a_18 ; $4d13
	xor a, a ; $4d16
	ld bc, $1800 ; $4d17
	ld de, $2400 ; $4d1a
	farcall FarPtr_0a_3a ; $4d1d
	ld a, $00 ; $4d20
	ld bc, $1700 ; $4d22
	ld de, $2400 ; $4d25
	farcall FarPtr_0a_24 ; $4d28
	ld a, $00 ; $4d2b
	ld de, rJOYP ; $4d2d
	farcall FarPtr_0a_42 ; $4d30
	ld a, $00 ; $4d33
	farcall FarPtr_0a_16 ; $4d35
	ld c, l ; $4d38
	ld b, h ; $4d39
	ld hl, $0037 ; $4d3a
	add hl, bc ; $4d3d
	ld a, [hl] ; $4d3e
	or a, $40 ; $4d3f
	ld [hl], a ; $4d41
	push af ; $4d42
	ld a, $1e ; $4d43
	farcall FarPtr_0a_04 ; $4d45
	pop af ; $4d48
	ld a, $00 ; $4d49
	ld d, $02 ; $4d4b
	farcall FarPtr_0a_34 ; $4d4d
	ld a, $00 ; $4d50
	farcall FarPtr_0a_36 ; $4d52
	push af ; $4d55
	ld a, $1e ; $4d56
	farcall FarPtr_0a_04 ; $4d58
	pop af ; $4d5b
	ldh a, [$ff95] ; $4d5c
	ld b, a ; $4d5e
	ld a, $00 ; $4d5f
	ld de, $4d8d ; $4d61
	farcall FarPtr_0a_1a ; $4d64
	ret ; $4d67
Func_11_4d68:
	ld a, $00 ; $4d68
	farcall FarPtr_0a_1c ; $4d6a
	ld a, $00 ; $4d6d
	ld bc, $0010 ; $4d6f
	farcall FarPtr_0a_18 ; $4d72
	ld a, $00 ; $4d75
	ld de, $ff80 ; $4d77
	farcall FarPtr_0a_42 ; $4d7a
	ld a, $00 ; $4d7d
	farcall FarPtr_0a_16 ; $4d7f
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
	farcall FarPtr_0a_38 ; $4d97
	ld a, $00 ; $4d9a
	ld bc, $0018 ; $4d9c
	farcall FarPtr_0a_18 ; $4d9f
	ld a, $12 ; $4da2
	ld bc, $0018 ; $4da4
	farcall FarPtr_0a_18 ; $4da7
	xor a, a ; $4daa
	ld bc, $1800 ; $4dab
	ld de, $1300 ; $4dae
	farcall FarPtr_0a_3a ; $4db1
	ld a, $00 ; $4db4
	ld bc, $1800 ; $4db6
	ld de, $2400 ; $4db9
	farcall FarPtr_0a_24 ; $4dbc
	ld a, $00 ; $4dbf
	farcall FarPtr_0a_20 ; $4dc1
	ld a, $00 ; $4dc4
	ld bc, $1800 ; $4dc6
	ld de, $1300 ; $4dc9
	farcall FarPtr_0a_24 ; $4dcc
	ld hl, $01a3 ; $4dcf
	farcall FarPtr_0a_0e ; $4dd2
	push af ; $4dd5
	ld a, $78 ; $4dd6
	farcall FarPtr_0a_04 ; $4dd8
	pop af ; $4ddb
	ld a, $12 ; $4ddc
	ld bc, $1800 ; $4dde
	ld de, $0f00 ; $4de1
	farcall FarPtr_0a_22 ; $4de4
	ld a, $00 ; $4de7
	farcall FarPtr_0a_20 ; $4de9
	ld a, [$c90d] ; $4dec
	or a, a ; $4def
	jr z, Label_11_4df5 ; $4df0
	farcall FarPtr_0a_10 ; $4df2
Label_11_4df5:
	ld a, $12 ; $4df5
	farcall FarPtr_0a_08 ; $4df7
	ld a, $0f ; $4dfa
	ld bc, $1940 ; $4dfc
	ld de, $11c0 ; $4dff
	farcall FarPtr_0a_22 ; $4e02
	rst Rst08 ; $4e05
	sub a, a ; $4e06
	push af ; $4e07
	ld a, $28 ; $4e08
	farcall FarPtr_0a_04 ; $4e0a
	pop af ; $4e0d
	ld a, $0f ; $4e0e
	ld bc, $3f00 ; $4e10
	ld de, $3f00 ; $4e13
	farcall FarPtr_0a_22 ; $4e16
	ld a, $12 ; $4e19
	ld b, a ; $4e1b
	ld a, $00 ; $4e1c
	farcall FarPtr_0a_30 ; $4e1e
	ld bc, $0020 ; $4e21
	farcall FarPtr_0a_38 ; $4e24
	ld a, $12 ; $4e27
	ld bc, $1800 ; $4e29
	ld de, $1100 ; $4e2c
	farcall FarPtr_0a_24 ; $4e2f
	push af ; $4e32
	ld a, $0f ; $4e33
	farcall FarPtr_0a_04 ; $4e35
	pop af ; $4e38
	xor a, a ; $4e39
	ld bc, $1800 ; $4e3a
	ld de, $1100 ; $4e3d
	farcall FarPtr_0a_3a ; $4e40
	farcall FarPtr_0a_3e ; $4e43
	push af ; $4e46
	ld a, $3c ; $4e47
	farcall FarPtr_0a_04 ; $4e49
	pop af ; $4e4c
	ld a, $00 ; $4e4d
	ld b, a ; $4e4f
	ld a, $12 ; $4e50
	farcall FarPtr_0a_32 ; $4e52
	push af ; $4e55
	ld a, $1e ; $4e56
	farcall FarPtr_0a_04 ; $4e58
	pop af ; $4e5b
	ld a, $00 ; $4e5c
	ld d, $03 ; $4e5e
	farcall FarPtr_0a_34 ; $4e60
	ld a, $00 ; $4e63
	farcall FarPtr_0a_36 ; $4e65
	push af ; $4e68
	ld a, $0f ; $4e69
	farcall FarPtr_0a_04 ; $4e6b
	pop af ; $4e6e
	ld a, $12 ; $4e6f
	ld d, $03 ; $4e71
	farcall FarPtr_0a_34 ; $4e73
	ld a, $12 ; $4e76
	farcall FarPtr_0a_36 ; $4e78
	ld hl, $01a5 ; $4e7b
	farcall FarPtr_0a_0e ; $4e7e
	ld a, $03 ; $4e81
	farcall FarPtr_0a_08 ; $4e83
	ld a, $0e ; $4e86
	ld bc, $1940 ; $4e88
	ld de, $11c0 ; $4e8b
	farcall FarPtr_0a_22 ; $4e8e
	rst Rst08 ; $4e91
	sbc a, b ; $4e92
	push af ; $4e93
	ld a, $32 ; $4e94
	farcall FarPtr_0a_04 ; $4e96
	pop af ; $4e99
	ld a, $0e ; $4e9a
	ld bc, $3f00 ; $4e9c
	ld de, $3f00 ; $4e9f
	farcall FarPtr_0a_22 ; $4ea2
	ld a, $12 ; $4ea5
	ld d, $03 ; $4ea7
	farcall FarPtr_0a_34 ; $4ea9
	ld a, $12 ; $4eac
	farcall FarPtr_0a_36 ; $4eae
	ld a, $12 ; $4eb1
	farcall FarPtr_0a_08 ; $4eb3
	push af ; $4eb6
	ld a, $0f ; $4eb7
	farcall FarPtr_0a_04 ; $4eb9
	pop af ; $4ebc
	ld a, $12 ; $4ebd
	ld d, $02 ; $4ebf
	farcall FarPtr_0a_34 ; $4ec1
	ld a, $12 ; $4ec4
	farcall FarPtr_0a_36 ; $4ec6
	ld a, $12 ; $4ec9
	farcall FarPtr_0a_0a ; $4ecb
	farcall FarPtr_0a_12 ; $4ece
	farcall FarPtr_0a_0c ; $4ed1
	push af ; $4ed4
	ld a, $05 ; $4ed5
	farcall FarPtr_0a_04 ; $4ed7
	pop af ; $4eda
	and a, a ; $4edb
	jr z, Label_11_4ee1 ; $4edc
	farcall FarPtr_0a_10 ; $4ede
Label_11_4ee1:
	ld a, $12 ; $4ee1
	farcall FarPtr_0a_0a ; $4ee3
	farcall FarPtr_0a_12 ; $4ee6
	farcall FarPtr_0a_0c ; $4ee9
	push af ; $4eec
	ld a, $05 ; $4eed
	farcall FarPtr_0a_04 ; $4eef
	pop af ; $4ef2
	and a, a ; $4ef3
	jr z, Label_11_4f0c ; $4ef4
	xor a, a ; $4ef6
	ld [$c2d5], a ; $4ef7
	ld hl, $01ab ; $4efa
	farcall FarPtr_0a_0e ; $4efd
	ld a, $12 ; $4f00
	farcall FarPtr_0a_08 ; $4f02
	rst Rst20 ; $4f05
	ret nz ; $4f06
	dec b ; $4f07
	call Func_11_4f1b ; $4f08
	ret ; $4f0b
Label_11_4f0c:
	ld hl, $01aa ; $4f0c
	farcall FarPtr_0a_0e ; $4f0f
	ld a, $12 ; $4f12
	farcall FarPtr_0a_08 ; $4f14
	call Func_11_4f84 ; $4f17
	ret ; $4f1a
Func_11_4f1b:
	ld a, $f1 ; $4f1b
	ld d, $16 ; $4f1d
	ld e, $10 ; $4f1f
	farcall FarPtr_0a_8a ; $4f21
	ld a, $f1 ; $4f24
	ld d, $18 ; $4f26
	ld e, $10 ; $4f28
	farcall FarPtr_0a_8a ; $4f2a
	ld a, $f1 ; $4f2d
	ld d, $16 ; $4f2f
	ld e, $12 ; $4f31
	farcall FarPtr_0a_8a ; $4f33
	ld a, $f1 ; $4f36
	ld d, $18 ; $4f38
	ld e, $12 ; $4f3a
	farcall FarPtr_0a_8a ; $4f3c
	ret ; $4f3f
	INCBIN "data/bank_011/d_4f40.bin" ; $4f40, 68 bytes
Func_11_4f84:
	ld a, $00 ; $4f84
	ld bc, $0018 ; $4f86
	farcall FarPtr_0a_18 ; $4f89
	ld a, $12 ; $4f8c
	ld bc, $0018 ; $4f8e
	farcall FarPtr_0a_18 ; $4f91
	rst Rst28 ; $4f94
	ret nz ; $4f95
	dec b ; $4f96
	ld a, $12 ; $4f97
	ld bc, $1800 ; $4f99
	ld de, $0e00 ; $4f9c
	farcall FarPtr_0a_24 ; $4f9f
	ld a, $00 ; $4fa2
	ld bc, $1800 ; $4fa4
	ld de, $0e00 ; $4fa7
	farcall FarPtr_0a_24 ; $4faa
	push af ; $4fad
	ld a, $1e ; $4fae
	farcall FarPtr_0a_04 ; $4fb0
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
	farcall FarPtr_0a_06 ; $4fd4
	farcall FarPtr_0a_00 ; $4fd7
	rst Rst30 ; $4fda
	ldh [rTIMA], a ; $4fdb
	jp z, Label_11_501a ; $4fdd
	ld a, $02 ; $4fe0
	farcall FarPtr_0a_1c ; $4fe2
	ld a, $02 ; $4fe5
	ld bc, $3f00 ; $4fe7
	ld de, $3f00 ; $4fea
	farcall FarPtr_0a_22 ; $4fed
	ld a, [$c94d] ; $4ff0
	ld d, $58 ; $4ff3
	add a, d ; $4ff5
	ld d, a ; $4ff6
	ld a, $05 ; $4ff7
	farcall FarPtr_0a_16 ; $4ff9
	ld c, l ; $4ffc
	ld b, h ; $4ffd
	farcall FarPtr_04_2c ; $4ffe
	ld a, $05 ; $5001
	ld d, $01 ; $5003
	farcall FarPtr_0a_34 ; $5005
	ld a, $07 ; $5008
	ld bc, $1a00 ; $500a
	ld de, $1100 ; $500d
	farcall FarPtr_0a_22 ; $5010
	ld a, $07 ; $5013
	ld b, $40 ; $5015
	farcall FarPtr_0a_2e ; $5017
Label_11_501a:
	ld a, [$c90d] ; $501a
	ld d, $56 ; $501d
	add a, d ; $501f
	ld d, a ; $5020
	ld a, $00 ; $5021
	farcall FarPtr_0a_16 ; $5023
	ld c, l ; $5026
	ld b, h ; $5027
	farcall FarPtr_04_2c ; $5028
	ld a, $00 ; $502b
	ld d, $01 ; $502d
	farcall FarPtr_0a_34 ; $502f
	ld a, $00 ; $5032
	ld bc, $1700 ; $5034
	ld de, $1700 ; $5037
	farcall FarPtr_0a_22 ; $503a
	ld a, $00 ; $503d
	ld b, $c0 ; $503f
	farcall FarPtr_0a_2e ; $5041
	ld a, $03 ; $5044
	ld b, $00 ; $5046
	farcall FarPtr_0a_3c ; $5048
	farcall FarPtr_0a_3e ; $504b
	ld c, $08 ; $504e
	call Func_00_1d2e ; $5050
	call Func_00_1da4 ; $5053
	push af ; $5056
	ld a, $3c ; $5057
	farcall FarPtr_0a_04 ; $5059
	pop af ; $505c
	ld hl, $01ed ; $505d
	farcall FarPtr_0a_0e ; $5060
	ld a, $03 ; $5063
	farcall FarPtr_0a_08 ; $5065
	rst Rst30 ; $5068
	ldh [rTIMA], a ; $5069
	jp z, Label_11_5158 ; $506b
	ld a, $04 ; $506e
	ld d, $03 ; $5070
	farcall FarPtr_0a_34 ; $5072
	ld a, $06 ; $5075
	ld d, $03 ; $5077
	farcall FarPtr_0a_34 ; $5079
	ld a, $06 ; $507c
	farcall FarPtr_0a_36 ; $507e
	push af ; $5081
	ld a, $1e ; $5082
	farcall FarPtr_0a_04 ; $5084
	pop af ; $5087
	ld a, $05 ; $5088
	ld b, a ; $508a
	ld a, $00 ; $508b
	farcall FarPtr_0a_32 ; $508d
	push af ; $5090
	ld a, $1e ; $5091
	farcall FarPtr_0a_04 ; $5093
	pop af ; $5096
	ld a, $00 ; $5097
	ld d, $03 ; $5099
	farcall FarPtr_0a_34 ; $509b
	ld a, $05 ; $509e
	ld d, $03 ; $50a0
	farcall FarPtr_0a_34 ; $50a2
	ld a, $05 ; $50a5
	farcall FarPtr_0a_36 ; $50a7
	push af ; $50aa
	ld a, $1e ; $50ab
	farcall FarPtr_0a_04 ; $50ad
	pop af ; $50b0
	ld a, $05 ; $50b1
	ld b, $c0 ; $50b3
	farcall FarPtr_0a_2e ; $50b5
	push af ; $50b8
	ld a, $1e ; $50b9
	farcall FarPtr_0a_04 ; $50bb
	pop af ; $50be
	ld a, $00 ; $50bf
	ld d, $03 ; $50c1
	farcall FarPtr_0a_34 ; $50c3
	ld a, $05 ; $50c6
	ld d, $03 ; $50c8
	farcall FarPtr_0a_34 ; $50ca
	ld a, $05 ; $50cd
	farcall FarPtr_0a_36 ; $50cf
	push af ; $50d2
	ld a, $1e ; $50d3
	farcall FarPtr_0a_04 ; $50d5
	pop af ; $50d8
	ld a, $03 ; $50d9
	ld d, $03 ; $50db
	farcall FarPtr_0a_34 ; $50dd
	ld a, $03 ; $50e0
	farcall FarPtr_0a_36 ; $50e2
	push af ; $50e5
	ld a, $0a ; $50e6
	farcall FarPtr_0a_04 ; $50e8
	pop af ; $50eb
	ld a, $07 ; $50ec
	ld d, $02 ; $50ee
	farcall FarPtr_0a_34 ; $50f0
	ld a, $07 ; $50f3
	farcall FarPtr_0a_36 ; $50f5
	ld a, $07 ; $50f8
	farcall FarPtr_0a_08 ; $50fa
	ld a, $04 ; $50fd
	ld d, $03 ; $50ff
	farcall FarPtr_0a_34 ; $5101
	ld a, $05 ; $5104
	ld d, $03 ; $5106
	farcall FarPtr_0a_34 ; $5108
	ld a, $00 ; $510b
	ld d, $03 ; $510d
	farcall FarPtr_0a_34 ; $510f
	ld a, $06 ; $5112
	ld d, $03 ; $5114
	farcall FarPtr_0a_34 ; $5116
	ld a, $06 ; $5119
	farcall FarPtr_0a_36 ; $511b
	push af ; $511e
	ld a, $1e ; $511f
	farcall FarPtr_0a_04 ; $5121
	pop af ; $5124
	ld a, $07 ; $5125
	ld b, a ; $5127
	ld a, $03 ; $5128
	farcall FarPtr_0a_32 ; $512a
	ld a, $03 ; $512d
	ld d, $03 ; $512f
	farcall FarPtr_0a_34 ; $5131
	ld a, $07 ; $5134
	ld d, $03 ; $5136
	farcall FarPtr_0a_34 ; $5138
	ld a, $07 ; $513b
	farcall FarPtr_0a_36 ; $513d
	ld a, $07 ; $5140
	ld b, $40 ; $5142
	farcall FarPtr_0a_2e ; $5144
	ld a, $03 ; $5147
	ld b, $40 ; $5149
	farcall FarPtr_0a_2e ; $514b
	push af ; $514e
	ld a, $1e ; $514f
	farcall FarPtr_0a_04 ; $5151
	pop af ; $5154
	jp Label_11_51d9 ; $5155
Label_11_5158:
	ld a, $04 ; $5158
	ld d, $03 ; $515a
	farcall FarPtr_0a_34 ; $515c
	ld a, $05 ; $515f
	ld d, $03 ; $5161
	farcall FarPtr_0a_34 ; $5163
	ld a, $05 ; $5166
	farcall FarPtr_0a_36 ; $5168
	push af ; $516b
	ld a, $1e ; $516c
	farcall FarPtr_0a_04 ; $516e
	pop af ; $5171
	ld a, $06 ; $5172
	ld b, a ; $5174
	ld a, $00 ; $5175
	farcall FarPtr_0a_32 ; $5177
	push af ; $517a
	ld a, $1e ; $517b
	farcall FarPtr_0a_04 ; $517d
	pop af ; $5180
	ld a, $00 ; $5181
	ld d, $03 ; $5183
	farcall FarPtr_0a_34 ; $5185
	ld a, $06 ; $5188
	ld d, $03 ; $518a
	farcall FarPtr_0a_34 ; $518c
	ld a, $06 ; $518f
	farcall FarPtr_0a_36 ; $5191
	push af ; $5194
	ld a, $1e ; $5195
	farcall FarPtr_0a_04 ; $5197
	pop af ; $519a
	ld a, $00 ; $519b
	ld b, $c0 ; $519d
	farcall FarPtr_0a_2e ; $519f
	ld a, $06 ; $51a2
	ld b, $c0 ; $51a4
	farcall FarPtr_0a_2e ; $51a6
	push af ; $51a9
	ld a, $1e ; $51aa
	farcall FarPtr_0a_04 ; $51ac
	pop af ; $51af
	ld a, $00 ; $51b0
	ld d, $03 ; $51b2
	farcall FarPtr_0a_34 ; $51b4
	ld a, $06 ; $51b7
	ld d, $03 ; $51b9
	farcall FarPtr_0a_34 ; $51bb
	ld a, $06 ; $51be
	farcall FarPtr_0a_36 ; $51c0
	push af ; $51c3
	ld a, $1e ; $51c4
	farcall FarPtr_0a_04 ; $51c6
	pop af ; $51c9
	ld a, $03 ; $51ca
	ld d, $03 ; $51cc
	farcall FarPtr_0a_34 ; $51ce
	ld a, $03 ; $51d1
	farcall FarPtr_0a_36 ; $51d3
	farcall FarPtr_0a_10 ; $51d6
Label_11_51d9:
	ld a, $03 ; $51d9
	farcall FarPtr_0a_08 ; $51db
	push af ; $51de
	ld a, $1e ; $51df
	farcall FarPtr_0a_04 ; $51e1
	pop af ; $51e4
	ld a, $04 ; $51e5
	ld d, $03 ; $51e7
	farcall FarPtr_0a_34 ; $51e9
	ld a, $05 ; $51ec
	ld d, $03 ; $51ee
	farcall FarPtr_0a_34 ; $51f0
	ld a, $00 ; $51f3
	ld d, $03 ; $51f5
	farcall FarPtr_0a_34 ; $51f7
	ld a, $06 ; $51fa
	ld d, $03 ; $51fc
	farcall FarPtr_0a_34 ; $51fe
	ld a, $06 ; $5201
	farcall FarPtr_0a_36 ; $5203
	push af ; $5206
	ld a, $14 ; $5207
	farcall FarPtr_0a_04 ; $5209
	pop af ; $520c
	ld a, $06 ; $520d
	ld b, a ; $520f
	ld a, $00 ; $5210
	farcall FarPtr_0a_32 ; $5212
	ld a, $04 ; $5215
	ld b, a ; $5217
	ld a, $05 ; $5218
	farcall FarPtr_0a_32 ; $521a
	push af ; $521d
	ld a, $0a ; $521e
	farcall FarPtr_0a_04 ; $5220
	pop af ; $5223
	ld a, $00 ; $5224
	ld b, $01 ; $5226
	farcall FarPtr_0a_2c ; $5228
	ld a, $06 ; $522b
	ld b, $01 ; $522d
	farcall FarPtr_0a_2c ; $522f
	ld a, $05 ; $5232
	ld b, $01 ; $5234
	farcall FarPtr_0a_2c ; $5236
	ld a, $04 ; $5239
	ld b, $01 ; $523b
	farcall FarPtr_0a_2c ; $523d
	ld a, $00 ; $5240
	ld bc, $1600 ; $5242
	ld de, $1700 ; $5245
	farcall FarPtr_0a_24 ; $5248
	ld a, $06 ; $524b
	ld bc, $1a00 ; $524d
	ld de, $1700 ; $5250
	farcall FarPtr_0a_24 ; $5253
	ld a, $05 ; $5256
	ld bc, $1500 ; $5258
	ld de, $1500 ; $525b
	farcall FarPtr_0a_24 ; $525e
	ld a, $04 ; $5261
	ld bc, $1b00 ; $5263
	ld de, $1500 ; $5266
	farcall FarPtr_0a_24 ; $5269
	ld a, $04 ; $526c
	farcall FarPtr_0a_20 ; $526e
	xor a, a ; $5271
	ld bc, $1800 ; $5272
	ld de, $2f00 ; $5275
	farcall FarPtr_0a_3a ; $5278
	ld a, $03 ; $527b
	ld bc, $1800 ; $527d
	ld de, $1900 ; $5280
	farcall FarPtr_0a_24 ; $5283
	ld a, $03 ; $5286
	farcall FarPtr_0a_20 ; $5288
	ld a, $00 ; $528b
	ld b, $00 ; $528d
	farcall FarPtr_0a_2c ; $528f
	ld a, $06 ; $5292
	ld b, $00 ; $5294
	farcall FarPtr_0a_2c ; $5296
	ld a, $05 ; $5299
	ld b, $00 ; $529b
	farcall FarPtr_0a_2c ; $529d
	ld a, $04 ; $52a0
	ld b, $00 ; $52a2
	farcall FarPtr_0a_2c ; $52a4
	ld a, $00 ; $52a7
	ld bc, $1600 ; $52a9
	ld de, $2b00 ; $52ac
	farcall FarPtr_0a_24 ; $52af
	ld a, $06 ; $52b2
	ld bc, $1a00 ; $52b4
	ld de, $2b00 ; $52b7
	farcall FarPtr_0a_24 ; $52ba
	ld a, $05 ; $52bd
	ld bc, $1500 ; $52bf
	ld de, $2900 ; $52c2
	farcall FarPtr_0a_24 ; $52c5
	ld a, $04 ; $52c8
	ld bc, $1b00 ; $52ca
	ld de, $2900 ; $52cd
	farcall FarPtr_0a_24 ; $52d0
	ld a, $03 ; $52d3
	ld bc, $1800 ; $52d5
	ld de, $2d00 ; $52d8
	farcall FarPtr_0a_24 ; $52db
	ld a, $03 ; $52de
	farcall FarPtr_0a_20 ; $52e0
	ld a, $08 ; $52e3
	ld d, $03 ; $52e5
	farcall FarPtr_0a_34 ; $52e7
	ld a, $00 ; $52ea
	ld bc, $1700 ; $52ec
	ld de, $2f00 ; $52ef
	farcall FarPtr_0a_24 ; $52f2
	ld a, $06 ; $52f5
	ld bc, $1900 ; $52f7
	ld de, $2f00 ; $52fa
	farcall FarPtr_0a_24 ; $52fd
	ld a, $05 ; $5300
	ld bc, $1700 ; $5302
	ld de, $2d00 ; $5305
	farcall FarPtr_0a_24 ; $5308
	ld a, $04 ; $530b
	ld bc, $1900 ; $530d
	ld de, $2d00 ; $5310
	farcall FarPtr_0a_24 ; $5313
	ld a, $03 ; $5316
	ld bc, $1800 ; $5318
	ld de, $3100 ; $531b
	farcall FarPtr_0a_24 ; $531e
	ld a, $03 ; $5321
	farcall FarPtr_0a_20 ; $5323
	ld a, $00 ; $5326
	ld bc, $1700 ; $5328
	ld de, $3b00 ; $532b
	farcall FarPtr_0a_24 ; $532e
	ld a, $06 ; $5331
	ld bc, $1900 ; $5333
	ld de, $3b00 ; $5336
	farcall FarPtr_0a_24 ; $5339
	ld a, $05 ; $533c
	ld bc, $1700 ; $533e
	ld de, $3900 ; $5341
	farcall FarPtr_0a_24 ; $5344
	ld a, $04 ; $5347
	ld bc, $1900 ; $5349
	ld de, $3900 ; $534c
	farcall FarPtr_0a_24 ; $534f
	ld a, $03 ; $5352
	ld bc, $1800 ; $5354
	ld de, $3d00 ; $5357
	farcall FarPtr_0a_24 ; $535a
	ld a, $03 ; $535d
	farcall FarPtr_0a_20 ; $535f
	ld c, $04 ; $5362
	call Func_00_1d20 ; $5364
	call Func_00_1da4 ; $5367
	ld a, $1b ; $536a
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
	farcall FarPtr_0a_06 ; $53e0
	farcall FarPtr_0a_00 ; $53e3
	ld bc, $00ff ; $53e6
	farcall FarPtr_0a_38 ; $53e9
	xor a, a ; $53ec
	ld bc, $1800 ; $53ed
	ld de, $2f00 ; $53f0
	farcall FarPtr_0a_3a ; $53f3
	farcall FarPtr_0a_3e ; $53f6
	rst Rst30 ; $53f9
	ldh [rTIMA], a ; $53fa
	jp z, Label_11_5415 ; $53fc
	ld a, $02 ; $53ff
	ld bc, $1800 ; $5401
	ld de, $1d00 ; $5404
	farcall FarPtr_0a_22 ; $5407
	ld a, $02 ; $540a
	ld bc, $1800 ; $540c
	ld de, $3900 ; $540f
	farcall FarPtr_0a_24 ; $5412
Label_11_5415:
	ld a, $00 ; $5415
	ld bc, $1800 ; $5417
	ld de, $1f00 ; $541a
	farcall FarPtr_0a_22 ; $541d
	ld a, $00 ; $5420
	ld bc, $1800 ; $5422
	ld de, $3b00 ; $5425
	farcall FarPtr_0a_24 ; $5428
	xor a, a ; $542b
	ld [$c2d5], a ; $542c
	ld c, $04 ; $542f
	call Func_00_1d2e ; $5431
	call Func_00_1da4 ; $5434
	push af ; $5437
	ld a, $3c ; $5438
	farcall FarPtr_0a_04 ; $543a
	pop af ; $543d
	ld a, $03 ; $543e
	ld d, $03 ; $5440
	farcall FarPtr_0a_34 ; $5442
	ld a, $03 ; $5445
	farcall FarPtr_0a_36 ; $5447
	ld a, $00 ; $544a
	farcall FarPtr_0a_20 ; $544c
	ld c, $04 ; $544f
	call Func_00_1d20 ; $5451
	call Func_00_1da4 ; $5454
	ld a, $1b ; $5457
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
	farcall FarPtr_0a_8a ; $5499
	ld a, $33 ; $549c
	ld d, $18 ; $549e
	ld e, $34 ; $54a0
	farcall FarPtr_0a_8a ; $54a2
	ret ; $54a5
Func_11_54a6:
	ld a, [$c2b0] ; $54a6
	cp a, $06 ; $54a9
	jr c, Label_11_54bf ; $54ab
	ld a, $14 ; $54ad
	ld bc, $1500 ; $54af
	ld de, $3000 ; $54b2
	farcall FarPtr_0a_22 ; $54b5
	ld a, $14 ; $54b8
	ld b, $00 ; $54ba
	farcall FarPtr_0a_2e ; $54bc
Label_11_54bf:
	ret ; $54bf
	INCBIN "data/bank_011/d_54c0.bin" ; $54c0, 4310 bytes
Label_11_6596:
	ld a, $00 ; $6596
	ld bc, $0020 ; $6598
	farcall FarPtr_0a_18 ; $659b
	ld a, $02 ; $659e
	ld bc, $0020 ; $65a0
	farcall FarPtr_0a_18 ; $65a3
	rst Rst30 ; $65a6
	nop ; $65a7
	ld [$b9ca], sp ; $65a8
	ld h, l ; $65ab
	rst Rst30 ; $65ac
	jr nz, Label_11_65b7 ; $65ad
	jp z, Label_11_6642 ; $65af
	rst Rst30 ; $65b2
	ld b, b ; $65b3
	ld [$02ca], sp ; $65b4
Label_11_65b7:
	ld h, a ; $65b7
	ret ; $65b8
	INCBIN "data/bank_011/d_65b9.bin" ; $65b9, 137 bytes
Label_11_6642:
	ld a, $03 ; $6642
	ld b, $80 ; $6644
	farcall FarPtr_0a_2e ; $6646
	push af ; $6649
	ld a, $0f ; $664a
	farcall FarPtr_0a_04 ; $664c
	pop af ; $664f
	ld a, $00 ; $6650
	ld b, $80 ; $6652
	farcall FarPtr_0a_2e ; $6654
	ld a, $02 ; $6657
	ld b, $80 ; $6659
	farcall FarPtr_0a_2e ; $665b
	ld a, $05 ; $665e
	ld b, $80 ; $6660
	farcall FarPtr_0a_2e ; $6662
	ld a, $07 ; $6665
	ld b, $80 ; $6667
	farcall FarPtr_0a_2e ; $6669
	ldh a, [$ff95] ; $666c
	ld b, a ; $666e
	ld a, $0c ; $666f
	ld de, $6df8 ; $6671
	farcall FarPtr_0a_1a ; $6674
	ldh a, [$ff95] ; $6677
	ld b, a ; $6679
	ld a, $0d ; $667a
	ld de, $6e07 ; $667c
	farcall FarPtr_0a_1a ; $667f
	ld a, $0d ; $6682
	farcall FarPtr_0a_1e ; $6684
	ld a, $02 ; $6687
	farcall FarPtr_0a_1c ; $6689
	xor a, a ; $668c
	ld bc, $0b00 ; $668d
	ld de, $1100 ; $6690
	farcall FarPtr_0a_3a ; $6693
	ldh a, [$ff95] ; $6696
	ld b, a ; $6698
	ld a, $05 ; $6699
	ld de, $5b98 ; $669b
	farcall FarPtr_0a_1a ; $669e
	ldh a, [$ff95] ; $66a1
	ld b, a ; $66a3
	ld a, $07 ; $66a4
	ld de, $5bb2 ; $66a6
	farcall FarPtr_0a_1a ; $66a9
	push af ; $66ac
	ld a, $1e ; $66ad
	farcall FarPtr_0a_04 ; $66af
	pop af ; $66b2
	ldh a, [$ff95] ; $66b3
	ld b, a ; $66b5
	ld a, $00 ; $66b6
	ld de, $7773 ; $66b8
	farcall FarPtr_0a_1a ; $66bb
	ldh a, [$ff95] ; $66be
	ld b, a ; $66c0
	ld a, $02 ; $66c1
	ld de, $5d27 ; $66c3
	farcall FarPtr_0a_1a ; $66c6
	ld a, $00 ; $66c9
	farcall FarPtr_0a_1e ; $66cb
	ld a, $00 ; $66ce
	ld b, $c0 ; $66d0
	farcall FarPtr_0a_2e ; $66d2
	ld a, $02 ; $66d5
	ld b, $c0 ; $66d7
	farcall FarPtr_0a_2e ; $66d9
	push af ; $66dc
	ld a, $3c ; $66dd
	farcall FarPtr_0a_04 ; $66df
	pop af ; $66e2
	ld a, $0f ; $66e3
	ld [$c294], a ; $66e5
	ld [$c2a1], a ; $66e8
	farcall FarPtr_0a_4a ; $66eb
	ld a, $01 ; $66ee
	ld [wCurrentMinigameStoryMatch], a ; $66f0
	ld a, $03 ; $66f3
	ld [$c8f7], a ; $66f5
	farcall FarPtr_0a_5a ; $66f8
	farcall FarPtr_0a_4c ; $66fb
	farcall FarPtr_0a_4e ; $66fe
	ret ; $6701
	INCBIN "data/bank_011/d_6702.bin" ; $6702, 158 bytes
Label_11_67a0:
	rst Rst30 ; $67a0
	nop ; $67a1
	ld [$0b28], sp ; $67a2
	rst Rst30 ; $67a5
	jr nz, Label_11_67b0 ; $67a6
	jr z, Label_11_67e7 ; $67a8
	rst Rst30 ; $67aa
	ld b, b ; $67ab
	ld [$5428], sp ; $67ac
	ret ; $67af
Label_11_67b0:
	ldh a, [$ff95] ; $67b0
	ld b, a ; $67b2
	ld a, $08 ; $67b3
	ld de, $5b14 ; $67b5
	farcall FarPtr_0a_1a ; $67b8
	ldh a, [$ff95] ; $67bb
	ld b, a ; $67bd
	ld a, $09 ; $67be
	ld de, $5b42 ; $67c0
	farcall FarPtr_0a_1a ; $67c3
	ld a, $09 ; $67c6
	farcall FarPtr_0a_1e ; $67c8
	ldh a, [$ff95] ; $67cb
	ld b, a ; $67cd
	ld a, $09 ; $67ce
	ld de, $681f ; $67d0
	farcall FarPtr_0a_1a ; $67d3
	ld a, $08 ; $67d6
	farcall FarPtr_0a_1e ; $67d8
	ldh a, [$ff95] ; $67db
	ld b, a ; $67dd
	ld a, $08 ; $67de
	ld de, $7d86 ; $67e0
	farcall FarPtr_0a_1a ; $67e3
	ret ; $67e6
Label_11_67e7:
	ldh a, [$ff95] ; $67e7
	ld b, a ; $67e9
	ld a, $05 ; $67ea
	ld de, $5bfa ; $67ec
	farcall FarPtr_0a_1a ; $67ef
	ldh a, [$ff95] ; $67f2
	ld b, a ; $67f4
	ld a, $07 ; $67f5
	ld de, $5c45 ; $67f7
	farcall FarPtr_0a_1a ; $67fa
	ld a, $05 ; $67fd
	farcall FarPtr_0a_1e ; $67ff
	ret ; $6802
	INCBIN "data/bank_011/d_6803.bin" ; $6803, 2721 bytes
	farcall FarPtr_0a_04 ; $72a4
	pop af ; $72a7
	and a, a ; $72a8
	jp nz, Label_11_72ec ; $72a9
	ld a, $03 ; $72ac
	ld d, $03 ; $72ae
	farcall FarPtr_0a_34 ; $72b0
	ld a, $03 ; $72b3
	farcall FarPtr_0a_36 ; $72b5
Label_11_72b8:
	ld a, $03 ; $72b8
	ld d, $03 ; $72ba
	farcall FarPtr_0a_34 ; $72bc
	ld a, $03 ; $72bf
	farcall FarPtr_0a_36 ; $72c1
	ld hl, $0828 ; $72c4
	farcall FarPtr_0a_0e ; $72c7
	ld a, $03 ; $72ca
	farcall FarPtr_0a_08 ; $72cc
	call Func_11_781d ; $72cf
	ld a, $00 ; $72d2
	ld bc, $0018 ; $72d4
	farcall FarPtr_0a_18 ; $72d7
	ld a, $02 ; $72da
	ld bc, $0018 ; $72dc
	farcall FarPtr_0a_18 ; $72df
	ret ; $72e2
Label_11_72e3:
	ld a, $03 ; $72e3
	farcall FarPtr_0a_08 ; $72e5
	call Func_11_730a ; $72e8
	ret ; $72eb
Label_11_72ec:
	ld hl, $0825 ; $72ec
	farcall FarPtr_0a_0e ; $72ef
	ld a, $03 ; $72f2
	farcall FarPtr_0a_0a ; $72f4
	farcall FarPtr_0a_12 ; $72f7
	farcall FarPtr_0a_0c ; $72fa
	push af ; $72fd
	ld a, $05 ; $72fe
	farcall FarPtr_0a_04 ; $7300
	pop af ; $7303
	and a, a ; $7304
	jr z, Label_11_72e3 ; $7305
	jp Label_11_72b8 ; $7307
Func_11_730a:
	rst Rst30 ; $730a
	ldh [rTIMA], a ; $730b
	jp nz, Label_11_67a0 ; $730d
	rst Rst30 ; $7310
	nop ; $7311
	ld a, [bc] ; $7312
	jr z, Label_11_7325 ; $7313
	rst Rst30 ; $7315
	jr nz, Label_11_7322 ; $7316
	jr z, Label_11_7336 ; $7318
	rst Rst30 ; $731a
	ld b, b ; $731b
	ld a, [bc] ; $731c
	jr z, Label_11_7347 ; $731d
	rst Rst30 ; $731f
	ld h, b ; $7320
	ld a, [bc] ; $7321
Label_11_7322:
	jr z, Label_11_7358 ; $7322
	ret ; $7324
Label_11_7325:
	ldh a, [$ff95] ; $7325
	ld b, a ; $7327
	ld a, $07 ; $7328
	ld de, $766b ; $732a
	farcall FarPtr_0a_1a ; $732d
	ld a, $07 ; $7330
	farcall FarPtr_0a_1e ; $7332
	ret ; $7335
Label_11_7336:
	ldh a, [$ff95] ; $7336
	ld b, a ; $7338
	ld a, $06 ; $7339
	ld de, $76cd ; $733b
	farcall FarPtr_0a_1a ; $733e
	ld a, $06 ; $7341
	farcall FarPtr_0a_1e ; $7343
	ret ; $7346
Label_11_7347:
	ldh a, [$ff95] ; $7347
	ld b, a ; $7349
	ld a, $05 ; $734a
	ld de, $7700 ; $734c
	farcall FarPtr_0a_1a ; $734f
	ld a, $05 ; $7352
	farcall FarPtr_0a_1e ; $7354
	ret ; $7357
Label_11_7358:
	ldh a, [$ff95] ; $7358
	ld b, a ; $735a
	ld a, $04 ; $735b
	ld de, $7745 ; $735d
	farcall FarPtr_0a_1a ; $7360
	ld a, $04 ; $7363
	farcall FarPtr_0a_1e ; $7365
	ret ; $7368
	INCBIN "data/bank_011/d_7369.bin" ; $7369, 634 bytes
	farcall FarPtr_0a_36 ; $75e3
	ldh a, [$ff95] ; $75e6
	ld b, a ; $75e8
	ld a, $04 ; $75e9
	ld de, $7728 ; $75eb
	farcall FarPtr_0a_1a ; $75ee
	ld a, $03 ; $75f1
	ld b, $40 ; $75f3
	farcall FarPtr_0a_2e ; $75f5
	ld a, $00 ; $75f8
	ld b, $00 ; $75fa
	farcall FarPtr_0a_3c ; $75fc
	ld a, $04 ; $75ff
	farcall FarPtr_0a_1e ; $7601
	ld a, $04 ; $7604
	ld b, a ; $7606
	ld a, $00 ; $7607
	farcall FarPtr_0a_30 ; $7609
	ld a, $04 ; $760c
	ld d, $02 ; $760e
	farcall FarPtr_0a_34 ; $7610
	ld a, $04 ; $7613
	farcall FarPtr_0a_36 ; $7615
	ld hl, $0830 ; $7618
	farcall FarPtr_0a_0e ; $761b
	ld a, $04 ; $761e
	farcall FarPtr_0a_08 ; $7620
	ld a, $04 ; $7623
	ld d, $03 ; $7625
	farcall FarPtr_0a_34 ; $7627
	ld a, $04 ; $762a
	farcall FarPtr_0a_36 ; $762c
	ld a, $04 ; $762f
	farcall FarPtr_0a_08 ; $7631
	push af ; $7634
	ld a, $0f ; $7635
	farcall FarPtr_0a_04 ; $7637
	pop af ; $763a
	ld a, $04 ; $763b
	ld b, $c0 ; $763d
	farcall FarPtr_0a_2e ; $763f
	ret ; $7642
	INCBIN "data/bank_011/d_7643.bin" ; $7643, 474 bytes
Func_11_781d:
	ld a, $00 ; $781d
	ld bc, $0020 ; $781f
	farcall FarPtr_0a_18 ; $7822
	rst Rst30 ; $7825
	ldh [rTIMA], a ; $7826
	jp nz, Label_11_6596 ; $7828
	rst Rst30 ; $782b
	nop ; $782c
	ld a, [bc] ; $782d
	jr z, Label_11_7843 ; $782e
	rst Rst30 ; $7830
	jr nz, Label_11_783d ; $7831
	jp z, Label_11_78cf ; $7833
	rst Rst30 ; $7836
	ld b, b ; $7837
	ld a, [bc] ; $7838
	jp z, Label_11_795d ; $7839
	rst Rst30 ; $783c
Label_11_783d:
	ld h, b ; $783d
	ld a, [bc] ; $783e
	jp z, Label_11_79e8 ; $783f
	ret ; $7842
Label_11_7843:
	ld a, $03 ; $7843
	ld b, $00 ; $7845
	farcall FarPtr_0a_2e ; $7847
	push af ; $784a
	ld a, $0f ; $784b
	farcall FarPtr_0a_04 ; $784d
	pop af ; $7850
	ld a, $00 ; $7851
	ld b, $00 ; $7853
	farcall FarPtr_0a_2e ; $7855
	ld a, $07 ; $7858
	ld b, $00 ; $785a
	farcall FarPtr_0a_2e ; $785c
	push af ; $785f
	ld a, $1e ; $7860
	farcall FarPtr_0a_04 ; $7862
	pop af ; $7865
	ldh a, [$ff95] ; $7866
	ld b, a ; $7868
	ld a, $0e ; $7869
	ld de, $6dbc ; $786b
	farcall FarPtr_0a_1a ; $786e
	ldh a, [$ff95] ; $7871
	ld b, a ; $7873
	ld a, $0f ; $7874
	ld de, $6dcb ; $7876
	farcall FarPtr_0a_1a ; $7879
	ld a, $0f ; $787c
	farcall FarPtr_0a_1e ; $787e
	xor a, a ; $7881
	ld bc, $1b00 ; $7882
	ld de, $1100 ; $7885
	farcall FarPtr_0a_3a ; $7888
	ldh a, [$ff95] ; $788b
	ld b, a ; $788d
	ld a, $07 ; $788e
	ld de, $765a ; $7890
	farcall FarPtr_0a_1a ; $7893
	ldh a, [$ff95] ; $7896
	ld b, a ; $7898
	ld a, $00 ; $7899
	ld de, $7762 ; $789b
	farcall FarPtr_0a_1a ; $789e
	farcall FarPtr_0a_3e ; $78a1
	ld a, $07 ; $78a4
	farcall FarPtr_0a_1e ; $78a6
	push af ; $78a9
	ld a, $14 ; $78aa
	farcall FarPtr_0a_04 ; $78ac
	pop af ; $78af
	ld a, $0f ; $78b0
	ld [$c294], a ; $78b2
	ld [$c2a1], a ; $78b5
	farcall FarPtr_0a_4a ; $78b8
	ld a, $00 ; $78bb
	ld [wCurrentMinigameStoryMatch], a ; $78bd
	ld a, $01 ; $78c0
	ld [$c8f7], a ; $78c2
	farcall FarPtr_0a_5a ; $78c5
	farcall FarPtr_0a_4c ; $78c8
	farcall FarPtr_0a_4e ; $78cb
	ret ; $78ce
Label_11_78cf:
	ld a, $03 ; $78cf
	ld b, $80 ; $78d1
	farcall FarPtr_0a_2e ; $78d3
	push af ; $78d6
	ld a, $0f ; $78d7
	farcall FarPtr_0a_04 ; $78d9
	pop af ; $78dc
	ld a, $00 ; $78dd
	ld b, $80 ; $78df
	farcall FarPtr_0a_2e ; $78e1
	ld a, $06 ; $78e4
	ld b, $80 ; $78e6
	farcall FarPtr_0a_2e ; $78e8
	push af ; $78eb
	ld a, $1e ; $78ec
	farcall FarPtr_0a_04 ; $78ee
	pop af ; $78f1
	ldh a, [$ff95] ; $78f2
	ld b, a ; $78f4
	ld a, $0c ; $78f5
	ld de, $6dda ; $78f7
	farcall FarPtr_0a_1a ; $78fa
	ldh a, [$ff95] ; $78fd
	ld b, a ; $78ff
	ld a, $0d ; $7900
	ld de, $6de9 ; $7902
	farcall FarPtr_0a_1a ; $7905
	push af ; $7908
	ld a, $78 ; $7909
	farcall FarPtr_0a_04 ; $790b
	pop af ; $790e
	xor a, a ; $790f
	ld bc, $0b00 ; $7910
	ld de, $1100 ; $7913
	farcall FarPtr_0a_3a ; $7916
	ldh a, [$ff95] ; $7919
	ld b, a ; $791b
	ld a, $06 ; $791c
	ld de, $76bc ; $791e
	farcall FarPtr_0a_1a ; $7921
	ldh a, [$ff95] ; $7924
	ld b, a ; $7926
	ld a, $00 ; $7927
	ld de, $7773 ; $7929
	farcall FarPtr_0a_1a ; $792c
	farcall FarPtr_0a_3e ; $792f
	ld a, $06 ; $7932
	farcall FarPtr_0a_1e ; $7934
	push af ; $7937
	ld a, $28 ; $7938
	farcall FarPtr_0a_04 ; $793a
	pop af ; $793d
	ld a, $0f ; $793e
	ld [$c294], a ; $7940
	ld [$c2a1], a ; $7943
	farcall FarPtr_0a_4a ; $7946
	ld a, $00 ; $7949
	ld [wCurrentMinigameStoryMatch], a ; $794b
	ld a, $02 ; $794e
	ld [$c8f7], a ; $7950
	farcall FarPtr_0a_5a ; $7953
	farcall FarPtr_0a_4c ; $7956
	farcall FarPtr_0a_4e ; $7959
	ret ; $795c
Label_11_795d:
	ld a, $03 ; $795d
	ld b, $80 ; $795f
	farcall FarPtr_0a_2e ; $7961
	push af ; $7964
	ld a, $0f ; $7965
	farcall FarPtr_0a_04 ; $7967
	pop af ; $796a
	ld a, $00 ; $796b
	ld b, $80 ; $796d
	farcall FarPtr_0a_2e ; $796f
	ld a, $05 ; $7972
	ld b, $80 ; $7974
	farcall FarPtr_0a_2e ; $7976
	push af ; $7979
	ld a, $1e ; $797a
	farcall FarPtr_0a_04 ; $797c
	pop af ; $797f
	ldh a, [$ff95] ; $7980
	ld b, a ; $7982
	ld a, $0c ; $7983
	ld de, $6dda ; $7985
	farcall FarPtr_0a_1a ; $7988
	ldh a, [$ff95] ; $798b
	ld b, a ; $798d
	ld a, $0d ; $798e
	ld de, $6de9 ; $7990
	farcall FarPtr_0a_1a ; $7993
	push af ; $7996
	ld a, $78 ; $7997
	farcall FarPtr_0a_04 ; $7999
	pop af ; $799c
	xor a, a ; $799d
	ld bc, $0b00 ; $799e
	ld de, $1100 ; $79a1
	farcall FarPtr_0a_3a ; $79a4
	ldh a, [$ff95] ; $79a7
	ld b, a ; $79a9
	ld a, $05 ; $79aa
	ld de, $76bc ; $79ac
	farcall FarPtr_0a_1a ; $79af
	ldh a, [$ff95] ; $79b2
	ld b, a ; $79b4
	ld a, $00 ; $79b5
	ld de, $7773 ; $79b7
	farcall FarPtr_0a_1a ; $79ba
	ld a, $05 ; $79bd
	farcall FarPtr_0a_1e ; $79bf
	push af ; $79c2
	ld a, $28 ; $79c3
	farcall FarPtr_0a_04 ; $79c5
	pop af ; $79c8
	ld a, $0f ; $79c9
	ld [$c294], a ; $79cb
	ld [$c2a1], a ; $79ce
	farcall FarPtr_0a_4a ; $79d1
	ld a, $00 ; $79d4
	ld [wCurrentMinigameStoryMatch], a ; $79d6
	ld a, $03 ; $79d9
	ld [$c8f7], a ; $79db
	farcall FarPtr_0a_5a ; $79de
	farcall FarPtr_0a_4c ; $79e1
	farcall FarPtr_0a_4e ; $79e4
	ret ; $79e7
Label_11_79e8:
	ld a, $03 ; $79e8
	ld b, $00 ; $79ea
	farcall FarPtr_0a_2e ; $79ec
	push af ; $79ef
	ld a, $0f ; $79f0
	farcall FarPtr_0a_04 ; $79f2
	pop af ; $79f5
	ld a, $00 ; $79f6
	ld b, $00 ; $79f8
	farcall FarPtr_0a_2e ; $79fa
	ld a, $04 ; $79fd
	ld b, $00 ; $79ff
	farcall FarPtr_0a_2e ; $7a01
	push af ; $7a04
	ld a, $1e ; $7a05
	farcall FarPtr_0a_04 ; $7a07
	pop af ; $7a0a
	ldh a, [$ff95] ; $7a0b
	ld b, a ; $7a0d
	ld a, $0e ; $7a0e
	ld de, $6dbc ; $7a10
	farcall FarPtr_0a_1a ; $7a13
	ldh a, [$ff95] ; $7a16
	ld b, a ; $7a18
	ld a, $0f ; $7a19
	ld de, $6dcb ; $7a1b
	farcall FarPtr_0a_1a ; $7a1e
	push af ; $7a21
	ld a, $78 ; $7a22
	farcall FarPtr_0a_04 ; $7a24
	pop af ; $7a27
	xor a, a ; $7a28
	ld bc, $1700 ; $7a29
	ld de, $1300 ; $7a2c
	farcall FarPtr_0a_3a ; $7a2f
	ldh a, [$ff95] ; $7a32
	ld b, a ; $7a34
	ld a, $04 ; $7a35
	ld de, $765a ; $7a37
	farcall FarPtr_0a_1a ; $7a3a
	ldh a, [$ff95] ; $7a3d
	ld b, a ; $7a3f
	ld a, $00 ; $7a40
	ld de, $7762 ; $7a42
	farcall FarPtr_0a_1a ; $7a45
	farcall FarPtr_0a_3e ; $7a48
	ld a, $04 ; $7a4b
	farcall FarPtr_0a_1e ; $7a4d
	push af ; $7a50
	ld a, $28 ; $7a51
	farcall FarPtr_0a_04 ; $7a53
	pop af ; $7a56
	ld a, $0f ; $7a57
	ld [$c294], a ; $7a59
	ld [$c2a1], a ; $7a5c
	farcall FarPtr_0a_4a ; $7a5f
	ld a, $00 ; $7a62
	ld [wCurrentMinigameStoryMatch], a ; $7a64
	ld a, $04 ; $7a67
	ld [$c8f7], a ; $7a69
	farcall FarPtr_0a_5a ; $7a6c
	farcall FarPtr_0a_4c ; $7a6f
	farcall FarPtr_0a_4e ; $7a72
	ret ; $7a75
	INCBIN "data/bank_011/d_7a76.bin" ; $7a76, 347 bytes
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

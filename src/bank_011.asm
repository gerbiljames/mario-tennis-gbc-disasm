SECTION "ROM Bank $11", ROMX[$4000], BANK[$11]

DataPtr_11_00:
	dw Data_11_4008 ; $4000
DataPtr_11_02:
	dw Data_11_4401 ; $4002
DataPtr_11_04:
	dw Data_11_54c0 ; $4004
DataPtr_11_06:
	dw Data_11_6822 ; $4006
Data_11_4008:
	INCBIN "data/bank_011/d_4008.bin" ; $4008, 757 bytes
	ld a, [$c295] ; $42fd
	cp a, $ff ; $4300
	jp z, Label_11_4342 ; $4302
	test_flag $05, 7 ; $4305
	jr z, Label_11_4330 ; $4308
	ld a, $02 ; $430a
	ld bc, $00ff ; $430c
	farcall FarPtr_0a_18 ; $430f
	ld a, $02 ; $4312
	ld b, $40 ; $4314
	ld de, $0200 ; $4316
	farcall FarPtr_0a_2a ; $4319
	ld a, $02 ; $431c
	farcall FarPtr_0a_20 ; $431e
	ld a, $02 ; $4321
	ld b, $c0 ; $4323
	farcall FarPtr_0a_2e ; $4325
	ld a, $02 ; $4328
	ld bc, $0010 ; $432a
	farcall FarPtr_0a_18 ; $432d
Label_11_4330:
	ld a, $00 ; $4330
	ld bc, $0010 ; $4332
	farcall FarPtr_0a_18 ; $4335
	ld a, $00 ; $4338
	ld b, $c0 ; $433a
	ld de, $0200 ; $433c
	farcall FarPtr_0a_2a ; $433f
Label_11_4342:
	ret ; $4342
	INCBIN "data/bank_011/d_4343.bin" ; $4343, 190 bytes
Data_11_4401:
	INCBIN "data/bank_011/d_4401.bin" ; $4401, 452 bytes
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
	call ComputeRankingProgressIndex ; $46b1
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
	sound $98 ; $4858
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
	sound $97 ; $48be
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
	sound $96 ; $4937
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
	sound $98 ; $4b46
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
	sound $97 ; $4ba9
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
	sound $97 ; $4c3b
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
	sound $70 ; $4cfb
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
	ldh a, [hRomBank] ; $4d5c
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
	sound $97 ; $4e05
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
	sound $98 ; $4e91
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
	set_flag $05, 6 ; $4f05
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
	clear_flag $05, 6 ; $4f94
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
	ldh a, [hRomBank] ; $4fcf
	ld hl, $537d ; $4fd1
	farcall FarPtr_0a_06 ; $4fd4
	farcall FarPtr_0a_00 ; $4fd7
	test_flag $05, 7 ; $4fda
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
	test_flag $05, 7 ; $5068
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
	ldh a, [hRomBank] ; $53db
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
	test_flag $05, 7 ; $53f9
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
	test_flag $05, 7 ; $5482
	jr nz, Label_11_548d ; $5485
	test_flag $16, 0 ; $5487
	jr nz, Label_11_5493 ; $548a
	ret ; $548c
Label_11_548d:
	test_flag $16, 1 ; $548d
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
Data_11_54c0:
	INCBIN "data/bank_011/d_54c0.bin" ; $54c0, 4310 bytes
Label_11_6596:
	ld a, $00 ; $6596
	ld bc, $0020 ; $6598
	farcall FarPtr_0a_18 ; $659b
	ld a, $02 ; $659e
	ld bc, $0020 ; $65a0
	farcall FarPtr_0a_18 ; $65a3
	test_flag $08, 0 ; $65a6
	jp z, Label_11_65b9 ; $65a9
	test_flag $08, 1 ; $65ac
	jp z, Label_11_6642 ; $65af
	test_flag $08, 2 ; $65b2
	jp z, Label_11_6702 ; $65b5
	ret ; $65b8
Label_11_65b9:
	ld a, $03 ; $65b9
	ld b, $00 ; $65bb
	farcall FarPtr_0a_2e ; $65bd
	push af ; $65c0
	ld a, $1e ; $65c1
	farcall FarPtr_0a_04 ; $65c3
	pop af ; $65c6
	ld a, $02 ; $65c7
	farcall FarPtr_0a_1c ; $65c9
	xor a, a ; $65cc
	ld bc, $1900 ; $65cd
	ld de, $1100 ; $65d0
	farcall FarPtr_0a_3a ; $65d3
	ldh a, [hRomBank] ; $65d6
	ld b, a ; $65d8
	ld a, $08 ; $65d9
	ld de, $5b70 ; $65db
	farcall FarPtr_0a_1a ; $65de
	ldh a, [hRomBank] ; $65e1
	ld b, a ; $65e3
	ld a, $09 ; $65e4
	ld de, $5b84 ; $65e6
	farcall FarPtr_0a_1a ; $65e9
	ld a, $00 ; $65ec
	ld bc, $1b00 ; $65ee
	ld de, $1900 ; $65f1
	farcall FarPtr_0a_24 ; $65f4
	push af ; $65f7
	ld a, $0a ; $65f8
	farcall FarPtr_0a_04 ; $65fa
	pop af ; $65fd
	ld a, $02 ; $65fe
	ld bc, $1900 ; $6600
	ld de, $1500 ; $6603
	farcall FarPtr_0a_24 ; $6606
	ld a, $00 ; $6609
	farcall FarPtr_0a_20 ; $660b
	ld a, $00 ; $660e
	ld b, $c0 ; $6610
	farcall FarPtr_0a_2e ; $6612
	ld a, $02 ; $6615
	ld b, $c0 ; $6617
	farcall FarPtr_0a_2e ; $6619
	push af ; $661c
	ld a, $3c ; $661d
	farcall FarPtr_0a_04 ; $661f
	pop af ; $6622
	ld a, $0f ; $6623
	ld [$c294], a ; $6625
	ld [$c2a1], a ; $6628
	farcall FarPtr_InitStoryMatchSettings ; $662b
	ld a, $01 ; $662e
	ld [wCurrentMinigameStoryMatch], a ; $6630
	ld a, $02 ; $6633
	ld [$c8f7], a ; $6635
	farcall FarPtr_LoadMatchSettingsFromTable ; $6638
	farcall FarPtr_0a_4c ; $663b
	farcall FarPtr_0a_4e ; $663e
	ret ; $6641
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
	ldh a, [hRomBank] ; $666c
	ld b, a ; $666e
	ld a, $0c ; $666f
	ld de, $6df8 ; $6671
	farcall FarPtr_0a_1a ; $6674
	ldh a, [hRomBank] ; $6677
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
	ldh a, [hRomBank] ; $6696
	ld b, a ; $6698
	ld a, $05 ; $6699
	ld de, $5b98 ; $669b
	farcall FarPtr_0a_1a ; $669e
	ldh a, [hRomBank] ; $66a1
	ld b, a ; $66a3
	ld a, $07 ; $66a4
	ld de, $5bb2 ; $66a6
	farcall FarPtr_0a_1a ; $66a9
	push af ; $66ac
	ld a, $1e ; $66ad
	farcall FarPtr_0a_04 ; $66af
	pop af ; $66b2
	ldh a, [hRomBank] ; $66b3
	ld b, a ; $66b5
	ld a, $00 ; $66b6
	ld de, $7773 ; $66b8
	farcall FarPtr_0a_1a ; $66bb
	ldh a, [hRomBank] ; $66be
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
	farcall FarPtr_InitStoryMatchSettings ; $66eb
	ld a, $01 ; $66ee
	ld [wCurrentMinigameStoryMatch], a ; $66f0
	ld a, $03 ; $66f3
	ld [$c8f7], a ; $66f5
	farcall FarPtr_LoadMatchSettingsFromTable ; $66f8
	farcall FarPtr_0a_4c ; $66fb
	farcall FarPtr_0a_4e ; $66fe
	ret ; $6701
Label_11_6702:
	ld a, $03 ; $6702
	ld b, $00 ; $6704
	farcall FarPtr_0a_2e ; $6706
	push af ; $6709
	ld a, $0f ; $670a
	farcall FarPtr_0a_04 ; $670c
	pop af ; $670f
	ld a, $00 ; $6710
	ld b, $00 ; $6712
	farcall FarPtr_0a_2e ; $6714
	ld a, $07 ; $6717
	ld b, $00 ; $6719
	farcall FarPtr_0a_2e ; $671b
	push af ; $671e
	ld a, $1e ; $671f
	farcall FarPtr_0a_04 ; $6721
	pop af ; $6724
	ld a, $02 ; $6725
	farcall FarPtr_0a_1c ; $6727
	xor a, a ; $672a
	ld bc, $1900 ; $672b
	ld de, $1100 ; $672e
	farcall FarPtr_0a_3a ; $6731
	ldh a, [hRomBank] ; $6734
	ld b, a ; $6736
	ld a, $04 ; $6737
	ld de, $5b70 ; $6739
	farcall FarPtr_0a_1a ; $673c
	ldh a, [hRomBank] ; $673f
	ld b, a ; $6741
	ld a, $06 ; $6742
	ld de, $5b84 ; $6744
	farcall FarPtr_0a_1a ; $6747
	ld a, $00 ; $674a
	ld bc, $1b00 ; $674c
	ld de, $1900 ; $674f
	farcall FarPtr_0a_24 ; $6752
	push af ; $6755
	ld a, $14 ; $6756
	farcall FarPtr_0a_04 ; $6758
	pop af ; $675b
	ld a, $02 ; $675c
	ld bc, $1900 ; $675e
	ld de, $1500 ; $6761
	farcall FarPtr_0a_24 ; $6764
	ld a, $00 ; $6767
	farcall FarPtr_0a_20 ; $6769
	ld a, $00 ; $676c
	ld b, $c0 ; $676e
	farcall FarPtr_0a_2e ; $6770
	ld a, $02 ; $6773
	ld b, $c0 ; $6775
	farcall FarPtr_0a_2e ; $6777
	push af ; $677a
	ld a, $3c ; $677b
	farcall FarPtr_0a_04 ; $677d
	pop af ; $6780
	ld a, $0f ; $6781
	ld [$c294], a ; $6783
	ld [$c2a1], a ; $6786
	farcall FarPtr_InitStoryMatchSettings ; $6789
	ld a, $01 ; $678c
	ld [wCurrentMinigameStoryMatch], a ; $678e
	ld a, $04 ; $6791
	ld [$c8f7], a ; $6793
	farcall FarPtr_LoadMatchSettingsFromTable ; $6796
	farcall FarPtr_0a_4c ; $6799
	farcall FarPtr_0a_4e ; $679c
	ret ; $679f
Label_11_67a0:
	test_flag $08, 0 ; $67a0
	jr z, Label_11_67b0 ; $67a3
	test_flag $08, 1 ; $67a5
	jr z, Label_11_67e7 ; $67a8
	test_flag $08, 2 ; $67aa
	jr z, Label_11_6803 ; $67ad
	ret ; $67af
Label_11_67b0:
	ldh a, [hRomBank] ; $67b0
	ld b, a ; $67b2
	ld a, $08 ; $67b3
	ld de, $5b14 ; $67b5
	farcall FarPtr_0a_1a ; $67b8
	ldh a, [hRomBank] ; $67bb
	ld b, a ; $67bd
	ld a, $09 ; $67be
	ld de, $5b42 ; $67c0
	farcall FarPtr_0a_1a ; $67c3
	ld a, $09 ; $67c6
	farcall FarPtr_0a_1e ; $67c8
	ldh a, [hRomBank] ; $67cb
	ld b, a ; $67cd
	ld a, $09 ; $67ce
	ld de, $681f ; $67d0
	farcall FarPtr_0a_1a ; $67d3
	ld a, $08 ; $67d6
	farcall FarPtr_0a_1e ; $67d8
	ldh a, [hRomBank] ; $67db
	ld b, a ; $67dd
	ld a, $08 ; $67de
	ld de, $7d86 ; $67e0
	farcall FarPtr_0a_1a ; $67e3
	ret ; $67e6
Label_11_67e7:
	ldh a, [hRomBank] ; $67e7
	ld b, a ; $67e9
	ld a, $05 ; $67ea
	ld de, $5bfa ; $67ec
	farcall FarPtr_0a_1a ; $67ef
	ldh a, [hRomBank] ; $67f2
	ld b, a ; $67f4
	ld a, $07 ; $67f5
	ld de, $5c45 ; $67f7
	farcall FarPtr_0a_1a ; $67fa
	ld a, $05 ; $67fd
	farcall FarPtr_0a_1e ; $67ff
	ret ; $6802
Label_11_6803:
	ldh a, [hRomBank] ; $6803
	ld b, a ; $6805
	ld a, $04 ; $6806
	ld de, $5c7f ; $6808
	farcall FarPtr_0a_1a ; $680b
	ldh a, [hRomBank] ; $680e
	ld b, a ; $6810
	ld a, $06 ; $6811
	ld de, $5cbf ; $6813
	farcall FarPtr_0a_1a ; $6816
	ld a, $04 ; $6819
	farcall FarPtr_0a_1e ; $681b
	ret ; $681e
	INCBIN "data/bank_011/d_681f.bin" ; $681f, 3 bytes
Data_11_6822:
	INCBIN "data/bank_011/d_6822.bin" ; $6822, 14 bytes
	INCBIN "data/bank_011/d_6830.bin" ; $6830, 317 bytes
	ret ; $696d
	INCBIN "data/bank_011/d_696e.bin" ; $696e, 912 bytes
	test_flag $0a, 0 ; $6cfe
	jr z, Label_11_6d15 ; $6d01
	ld a, $07 ; $6d03
	ld bc, $2500 ; $6d05
	ld de, $0b00 ; $6d08
	farcall FarPtr_0a_22 ; $6d0b
	ld a, $07 ; $6d0e
	ld b, $00 ; $6d10
	farcall FarPtr_0a_2e ; $6d12
Label_11_6d15:
	ld a, [$c295] ; $6d15
	cp a, $0f ; $6d18
	jp z, Label_11_6e4d ; $6d1a
	cp a, $0e ; $6d1d
	jp z, Label_11_6e88 ; $6d1f
	cp a, $0d ; $6d22
	jp z, Label_11_6e9e ; $6d24
	test_flag $16, 0 ; $6d27
	jr nz, Label_11_6d3c ; $6d2a
	test_flag $15, 6 ; $6d2c
	jr nz, Label_11_6d51 ; $6d2f
	test_flag $0a, 7 ; $6d31
	jr nz, Label_11_6d66 ; $6d34
	test_flag $0a, 3 ; $6d36
	jr nz, Label_11_6d91 ; $6d39
	ret ; $6d3b
Label_11_6d3c:
	ld hl, $6c68 ; $6d3c
	ld de, $000c ; $6d3f
	farcall FarPtr_0a_60 ; $6d42
	ld a, $04 ; $6d45
	ld bc, $3f00 ; $6d47
	ld de, $2900 ; $6d4a
	farcall FarPtr_0a_22 ; $6d4d
	ret ; $6d50
Label_11_6d51:
	ld hl, $6c27 ; $6d51
	ld de, $000c ; $6d54
	farcall FarPtr_0a_60 ; $6d57
	ld a, $04 ; $6d5a
	ld bc, $3f00 ; $6d5c
	ld de, $2900 ; $6d5f
	farcall FarPtr_0a_22 ; $6d62
	ret ; $6d65
Label_11_6d66:
	ld hl, $6be6 ; $6d66
	ld de, $000c ; $6d69
	farcall FarPtr_0a_60 ; $6d6c
	ld a, $0a ; $6d6f
	ld bc, $3d00 ; $6d71
	ld de, $1100 ; $6d74
	farcall FarPtr_0a_22 ; $6d77
	ldh a, [hRomBank] ; $6d7a
	ld b, a ; $6d7c
	ld a, $0a ; $6d7d
	ld de, $7bbd ; $6d7f
	farcall FarPtr_0a_1a ; $6d82
	ld a, $04 ; $6d85
	ld bc, $3f00 ; $6d87
	ld de, $2900 ; $6d8a
	farcall FarPtr_0a_22 ; $6d8d
	ret ; $6d90
Label_11_6d91:
	ld hl, $6ba5 ; $6d91
	ld de, $000c ; $6d94
	farcall FarPtr_0a_60 ; $6d97
	ld a, $0a ; $6d9a
	ld bc, $3d00 ; $6d9c
	ld de, $1100 ; $6d9f
	farcall FarPtr_0a_22 ; $6da2
	ldh a, [hRomBank] ; $6da5
	ld b, a ; $6da7
	ld a, $0a ; $6da8
	ld de, $7bbd ; $6daa
	farcall FarPtr_0a_1a ; $6dad
	ld a, $04 ; $6db0
	ld bc, $3f00 ; $6db2
	ld de, $2900 ; $6db5
	farcall FarPtr_0a_22 ; $6db8
	ret ; $6dbb
	INCBIN "data/bank_011/d_6dbc.bin" ; $6dbc, 145 bytes
Label_11_6e4d:
	wram_bank $04 ; $6e4d
	ld a, [$c4c7] ; $6e53
	cp a, $01 ; $6e56
	jr z, Label_11_6e62 ; $6e58
	ld a, [wMatchWinLoseFlag] ; $6e5a
	cp a, $01 ; $6e5d
	jp z, Label_11_6e88 ; $6e5f
Label_11_6e62:
	ld bc, $0040 ; $6e62
	farcall FarPtr_0a_38 ; $6e65
	xor a, a ; $6e68
	ld bc, $1300 ; $6e69
	ld de, $1500 ; $6e6c
	farcall FarPtr_0a_3a ; $6e6f
	ld a, $00 ; $6e72
	ld bc, $1300 ; $6e74
	ld de, $1500 ; $6e77
	farcall FarPtr_0a_22 ; $6e7a
	ld a, $00 ; $6e7d
	ld b, $c0 ; $6e7f
	farcall FarPtr_0a_2e ; $6e81
	farcall FarPtr_0a_3e ; $6e84
	ret ; $6e87
Label_11_6e88:
	ld a, $0b ; $6e88
	ld [wStoryModeCurrentLocation], a ; $6e8a
	ld a, $0d ; $6e8d
	ld [$c295], a ; $6e8f
	ld a, $ff ; $6e92
	ld [$c294], a ; $6e94
	ld [$c2a1], a ; $6e97
	farcall FarPtr_1e_02 ; $6e9a
	ret ; $6e9d
Label_11_6e9e:
	xor a, a ; $6e9e
	ld [$c2d5], a ; $6e9f
	ld a, [$c8f7] ; $6ea2
	sub a, $01 ; $6ea5
	ld a, a ; $6ea7
	rst Rst00 ; $6ea8
	dw Label_11_6eb1 ; $6ea9 jumptable
	dw Label_11_6f44 ; $6eab jumptable
	dw Label_11_6fdd ; $6ead jumptable
	dw Label_11_7076 ; $6eaf jumptable
Label_11_6eb1:
	call Func_11_7a76 ; $6eb1
	ld bc, $0040 ; $6eb4
	farcall FarPtr_0a_38 ; $6eb7
	ld a, $07 ; $6eba
	ld bc, $1a00 ; $6ebc
	ld de, $0900 ; $6ebf
	farcall FarPtr_0a_22 ; $6ec2
	ld a, $00 ; $6ec5
	ld bc, $1a00 ; $6ec7
	ld de, $1400 ; $6eca
	farcall FarPtr_0a_22 ; $6ecd
	xor a, a ; $6ed0
	ld bc, $1a00 ; $6ed1
	ld de, $0f00 ; $6ed4
	farcall FarPtr_0a_3a ; $6ed7
	farcall FarPtr_0a_3e ; $6eda
	ld a, $00 ; $6edd
	ld b, $c0 ; $6edf
	farcall FarPtr_0a_2e ; $6ee1
	ld a, $07 ; $6ee4
	ld b, $40 ; $6ee6
	farcall FarPtr_0a_2e ; $6ee8
	ld a, $03 ; $6eeb
	ld b, $00 ; $6eed
	farcall FarPtr_0a_2e ; $6eef
	ld c, $04 ; $6ef2
	call Func_00_1d2e ; $6ef4
	call Func_00_1da4 ; $6ef7
	ld hl, $0833 ; $6efa
	farcall FarPtr_0a_0e ; $6efd
	ld a, $07 ; $6f00
	farcall FarPtr_0a_08 ; $6f02
	ld a, $03 ; $6f05
	ld de, $ff80 ; $6f07
	farcall FarPtr_0a_42 ; $6f0a
	ld a, $03 ; $6f0d
	farcall FarPtr_0a_44 ; $6f0f
	ld a, $03 ; $6f12
	farcall FarPtr_0a_08 ; $6f14
	ldh a, [hRomBank] ; $6f17
	ld b, a ; $6f19
	ld a, $07 ; $6f1a
	ld de, $7682 ; $6f1c
	farcall FarPtr_0a_1a ; $6f1f
	ld a, $00 ; $6f22
	ld bc, $1300 ; $6f24
	ld de, $1500 ; $6f27
	farcall FarPtr_0a_24 ; $6f2a
	ld a, $00 ; $6f2d
	farcall FarPtr_0a_20 ; $6f2f
	ld a, $00 ; $6f32
	ld b, $40 ; $6f34
	farcall FarPtr_0a_2e ; $6f36
	call Func_11_7b2d ; $6f39
	ld a, $03 ; $6f3c
	ld b, $40 ; $6f3e
	farcall FarPtr_0a_2e ; $6f40
	ret ; $6f43
Label_11_6f44:
	call Func_11_7ab3 ; $6f44
	ld bc, $0040 ; $6f47
	farcall FarPtr_0a_38 ; $6f4a
	ld a, $06 ; $6f4d
	ld bc, $0900 ; $6f4f
	ld de, $0900 ; $6f52
	farcall FarPtr_0a_22 ; $6f55
	ld a, $00 ; $6f58
	ld bc, $0b00 ; $6f5a
	ld de, $1400 ; $6f5d
	farcall FarPtr_0a_22 ; $6f60
	xor a, a ; $6f63
	ld bc, $0b00 ; $6f64
	ld de, $0f00 ; $6f67
	farcall FarPtr_0a_3a ; $6f6a
	farcall FarPtr_0a_3e ; $6f6d
	ld a, $00 ; $6f70
	ld b, $c0 ; $6f72
	farcall FarPtr_0a_2e ; $6f74
	ld a, $06 ; $6f77
	ld b, $40 ; $6f79
	farcall FarPtr_0a_2e ; $6f7b
	ld a, $03 ; $6f7e
	ld b, $80 ; $6f80
	farcall FarPtr_0a_2e ; $6f82
	ld c, $04 ; $6f85
	call Func_00_1d2e ; $6f87
	call Func_00_1da4 ; $6f8a
	ld hl, $0846 ; $6f8d
	farcall FarPtr_0a_0e ; $6f90
	ld a, $06 ; $6f93
	farcall FarPtr_0a_08 ; $6f95
	ld a, $03 ; $6f98
	ld de, $ff80 ; $6f9a
	farcall FarPtr_0a_42 ; $6f9d
	ld a, $03 ; $6fa0
	farcall FarPtr_0a_44 ; $6fa2
	ld hl, $0835 ; $6fa5
	farcall FarPtr_0a_0e ; $6fa8
	ld a, $03 ; $6fab
	farcall FarPtr_0a_08 ; $6fad
	ldh a, [hRomBank] ; $6fb0
	ld b, a ; $6fb2
	ld a, $06 ; $6fb3
	ld de, $76de ; $6fb5
	farcall FarPtr_0a_1a ; $6fb8
	ld a, $00 ; $6fbb
	ld bc, $1300 ; $6fbd
	ld de, $1500 ; $6fc0
	farcall FarPtr_0a_24 ; $6fc3
	ld a, $00 ; $6fc6
	farcall FarPtr_0a_20 ; $6fc8
	ld a, $00 ; $6fcb
	ld b, $40 ; $6fcd
	farcall FarPtr_0a_2e ; $6fcf
	call Func_11_7b6b ; $6fd2
	ld a, $03 ; $6fd5
	ld b, $40 ; $6fd7
	farcall FarPtr_0a_2e ; $6fd9
	ret ; $6fdc
Label_11_6fdd:
	call Func_11_7ab3 ; $6fdd
	ld bc, $0040 ; $6fe0
	farcall FarPtr_0a_38 ; $6fe3
	ld a, $05 ; $6fe6
	ld bc, $0900 ; $6fe8
	ld de, $0900 ; $6feb
	farcall FarPtr_0a_22 ; $6fee
	ld a, $00 ; $6ff1
	ld bc, $0b00 ; $6ff3
	ld de, $1400 ; $6ff6
	farcall FarPtr_0a_22 ; $6ff9
	xor a, a ; $6ffc
	ld bc, $0b00 ; $6ffd
	ld de, $0f00 ; $7000
	farcall FarPtr_0a_3a ; $7003
	farcall FarPtr_0a_3e ; $7006
	ld a, $00 ; $7009
	ld b, $c0 ; $700b
	farcall FarPtr_0a_2e ; $700d
	ld a, $05 ; $7010
	ld b, $40 ; $7012
	farcall FarPtr_0a_2e ; $7014
	ld a, $03 ; $7017
	ld b, $80 ; $7019
	farcall FarPtr_0a_2e ; $701b
	ld c, $04 ; $701e
	call Func_00_1d2e ; $7020
	call Func_00_1da4 ; $7023
	ld hl, $0841 ; $7026
	farcall FarPtr_0a_0e ; $7029
	ld a, $05 ; $702c
	farcall FarPtr_0a_08 ; $702e
	ld a, $03 ; $7031
	ld de, $ff80 ; $7033
	farcall FarPtr_0a_42 ; $7036
	ld a, $03 ; $7039
	farcall FarPtr_0a_44 ; $703b
	ld hl, $0836 ; $703e
	farcall FarPtr_0a_0e ; $7041
	ld a, $03 ; $7044
	farcall FarPtr_0a_08 ; $7046
	ldh a, [hRomBank] ; $7049
	ld b, a ; $704b
	ld a, $05 ; $704c
	ld de, $7717 ; $704e
	farcall FarPtr_0a_1a ; $7051
	ld a, $00 ; $7054
	ld bc, $1300 ; $7056
	ld de, $1500 ; $7059
	farcall FarPtr_0a_24 ; $705c
	ld a, $00 ; $705f
	farcall FarPtr_0a_20 ; $7061
	ld a, $00 ; $7064
	ld b, $40 ; $7066
	farcall FarPtr_0a_2e ; $7068
	call Func_11_7b6b ; $706b
	ld a, $03 ; $706e
	ld b, $40 ; $7070
	farcall FarPtr_0a_2e ; $7072
	ret ; $7075
Label_11_7076:
	ld bc, $0040 ; $7076
	farcall FarPtr_0a_38 ; $7079
	ld a, $03 ; $707c
	ld bc, $1300 ; $707e
	ld de, $1f00 ; $7081
	farcall FarPtr_0a_22 ; $7084
	ld a, $04 ; $7087
	ld bc, $1a00 ; $7089
	ld de, $0b00 ; $708c
	farcall FarPtr_0a_22 ; $708f
	ld a, $00 ; $7092
	ld bc, $1a00 ; $7094
	ld de, $1400 ; $7097
	farcall FarPtr_0a_22 ; $709a
	xor a, a ; $709d
	ld bc, $1a00 ; $709e
	ld de, $1100 ; $70a1
	farcall FarPtr_0a_3a ; $70a4
	farcall FarPtr_0a_3e ; $70a7
	ld a, $00 ; $70aa
	ld b, $c0 ; $70ac
	farcall FarPtr_0a_2e ; $70ae
	ld a, $04 ; $70b1
	ld b, $40 ; $70b3
	farcall FarPtr_0a_2e ; $70b5
	ld a, $03 ; $70b8
	ld b, $c0 ; $70ba
	farcall FarPtr_0a_2e ; $70bc
	call Func_11_7a76 ; $70bf
	ld c, $04 ; $70c2
	call Func_00_1d2e ; $70c4
	call Func_00_1da4 ; $70c7
	push af ; $70ca
	ld a, $3c ; $70cb
	farcall FarPtr_0a_04 ; $70cd
	pop af ; $70d0
	ld hl, $0837 ; $70d1
	farcall FarPtr_0a_0e ; $70d4
	ld a, $04 ; $70d7
	ld bc, $1a00 ; $70d9
	ld de, $0d00 ; $70dc
	farcall FarPtr_0a_24 ; $70df
	ld a, $04 ; $70e2
	farcall FarPtr_0a_20 ; $70e4
	ld a, $04 ; $70e7
	ld d, $02 ; $70e9
	farcall FarPtr_0a_34 ; $70eb
	ld a, $04 ; $70ee
	farcall FarPtr_0a_08 ; $70f0
	ld a, $03 ; $70f3
	ld d, $03 ; $70f5
	farcall FarPtr_0a_34 ; $70f7
	ld a, $03 ; $70fa
	farcall FarPtr_0a_08 ; $70fc
	ld a, $04 ; $70ff
	ld d, $02 ; $7101
	farcall FarPtr_0a_34 ; $7103
	ld a, $00 ; $7106
	ld d, $02 ; $7108
	farcall FarPtr_0a_34 ; $710a
	ld a, $00 ; $710d
	ld b, $40 ; $710f
	farcall FarPtr_0a_2e ; $7111
	ld bc, $0010 ; $7114
	farcall FarPtr_0a_38 ; $7117
	ld a, $03 ; $711a
	ld bc, $0010 ; $711c
	farcall FarPtr_0a_18 ; $711f
	xor a, a ; $7122
	ld bc, $1300 ; $7123
	ld de, $1900 ; $7126
	farcall FarPtr_0a_3a ; $7129
	ld a, $03 ; $712c
	ld bc, $1300 ; $712e
	ld de, $1b00 ; $7131
	farcall FarPtr_0a_24 ; $7134
	ld a, $03 ; $7137
	farcall FarPtr_0a_20 ; $7139
	farcall FarPtr_0a_3e ; $713c
	xor a, a ; $713f
	ld bc, $1a00 ; $7140
	ld de, $1400 ; $7143
	farcall FarPtr_0a_3a ; $7146
	ld a, $03 ; $7149
	ld bc, $1a00 ; $714b
	ld de, $1700 ; $714e
	farcall FarPtr_0a_24 ; $7151
	ld a, $03 ; $7154
	farcall FarPtr_0a_20 ; $7156
	ld a, $03 ; $7159
	ld b, $c0 ; $715b
	farcall FarPtr_0a_2e ; $715d
	ld a, $03 ; $7160
	ld d, $02 ; $7162
	farcall FarPtr_0a_34 ; $7164
	ld a, $03 ; $7167
	farcall FarPtr_0a_36 ; $7169
	ld a, $03 ; $716c
	farcall FarPtr_0a_08 ; $716e
	ld a, $00 ; $7171
	ld d, $03 ; $7173
	farcall FarPtr_0a_34 ; $7175
	ld a, $00 ; $7178
	farcall FarPtr_0a_36 ; $717a
	ld a, $03 ; $717d
	ld d, $03 ; $717f
	farcall FarPtr_0a_34 ; $7181
	ld a, $03 ; $7184
	farcall FarPtr_0a_36 ; $7186
	ld a, $03 ; $7189
	farcall FarPtr_0a_08 ; $718b
	ld a, $03 ; $718e
	ld bc, $1a00 ; $7190
	ld de, $1600 ; $7193
	farcall FarPtr_0a_24 ; $7196
	ld a, $03 ; $7199
	farcall FarPtr_0a_20 ; $719b
	ld a, $03 ; $719e
	ld d, $02 ; $71a0
	farcall FarPtr_0a_34 ; $71a2
	ld a, $03 ; $71a5
	farcall FarPtr_0a_36 ; $71a7
	push af ; $71aa
	ld a, $1e ; $71ab
	farcall FarPtr_0a_04 ; $71ad
	pop af ; $71b0
	ld a, $03 ; $71b1
	ld d, $03 ; $71b3
	farcall FarPtr_0a_34 ; $71b5
	ld a, $00 ; $71b8
	ld d, $03 ; $71ba
	farcall FarPtr_0a_34 ; $71bc
	ld a, $00 ; $71bf
	farcall FarPtr_0a_36 ; $71c1
	ld a, $00 ; $71c4
	farcall FarPtr_0a_08 ; $71c6
	ld a, $03 ; $71c9
	ld d, $02 ; $71cb
	farcall FarPtr_0a_34 ; $71cd
	ld a, $03 ; $71d0
	farcall FarPtr_0a_36 ; $71d2
	ld a, $03 ; $71d5
	farcall FarPtr_0a_08 ; $71d7
	ld a, $00 ; $71da
	ld d, $03 ; $71dc
	farcall FarPtr_0a_34 ; $71de
	ld a, $00 ; $71e1
	farcall FarPtr_0a_36 ; $71e3
	ld a, $03 ; $71e6
	ld d, $03 ; $71e8
	farcall FarPtr_0a_34 ; $71ea
	ld a, $03 ; $71ed
	farcall FarPtr_0a_36 ; $71ef
	ld a, $00 ; $71f2
	ld d, $02 ; $71f4
	farcall FarPtr_0a_34 ; $71f6
	ld a, $00 ; $71f9
	farcall FarPtr_0a_36 ; $71fb
	ld a, $00 ; $71fe
	ld b, $c0 ; $7200
	farcall FarPtr_0a_2e ; $7202
	ld a, $12 ; $7205
	ld bc, $1b80 ; $7207
	ld de, $1280 ; $720a
	farcall FarPtr_0a_22 ; $720d
	sound $96 ; $7210
	push af ; $7212
	ld a, $28 ; $7213
	farcall FarPtr_0a_04 ; $7215
	pop af ; $7218
	ld a, $04 ; $7219
	ld d, $02 ; $721b
	farcall FarPtr_0a_34 ; $721d
	push af ; $7220
	ld a, $28 ; $7221
	farcall FarPtr_0a_04 ; $7223
	pop af ; $7226
	ld a, $04 ; $7227
	ld bc, $1a00 ; $7229
	ld de, $0e00 ; $722c
	farcall FarPtr_0a_24 ; $722f
	ld a, $04 ; $7232
	farcall FarPtr_0a_20 ; $7234
	ld a, $12 ; $7237
	ld bc, $3f00 ; $7239
	ld de, $3f00 ; $723c
	farcall FarPtr_0a_22 ; $723f
	ld a, $04 ; $7242
	farcall FarPtr_0a_08 ; $7244
	ld a, $0b ; $7247
	ld [wStoryModeCurrentLocation], a ; $7249
	ld a, $01 ; $724c
	ld [$c295], a ; $724e
	ld a, $ff ; $7251
	ld [$c294], a ; $7253
	ld [$c2a1], a ; $7256
	ld a, $03 ; $7259
	ld d, $03 ; $725b
	farcall FarPtr_0a_34 ; $725d
	ld a, $03 ; $7260
	farcall FarPtr_0a_36 ; $7262
	push af ; $7265
	ld a, $28 ; $7266
	farcall FarPtr_0a_04 ; $7268
	pop af ; $726b
	ld a, $00 ; $726c
	ld d, $02 ; $726e
	farcall FarPtr_0a_34 ; $7270
	ld a, $00 ; $7273
	farcall FarPtr_0a_36 ; $7275
	push af ; $7278
	ld a, $28 ; $7279
	farcall FarPtr_0a_04 ; $727b
	pop af ; $727e
	ld c, $04 ; $727f
	call Func_00_1d20 ; $7281
	call Func_00_1da4 ; $7284
	ret ; $7287
PromptChallengeRankingOpponent:
	ld hl, $0822 ; $7288
	farcall FarPtr_0a_0e ; $728b
	test_flag $0a, 0 ; $728e
	jr z, Label_11_7296 ; $7291
	farcall FarPtr_0a_10 ; $7293
Label_11_7296:
	ld a, $03 ; $7296
	farcall FarPtr_0a_0a ; $7298
	farcall FarPtr_0a_12 ; $729b
	farcall FarPtr_0a_0c ; $729e
	push af ; $72a1
	ld a, $05 ; $72a2
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
	call StartNextRankingMatch ; $72cf
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
	call LoadRankingOpponentGraphics ; $72e8
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
LoadRankingOpponentGraphics:
	test_flag $05, 7 ; $730a
	jp nz, Label_11_67a0 ; $730d
	test_flag $0a, 0 ; $7310
	jr z, Label_11_7325 ; $7313
	test_flag $0a, 1 ; $7315
	jr z, Label_11_7336 ; $7318
	test_flag $0a, 2 ; $731a
	jr z, Label_11_7347 ; $731d
	test_flag $0a, 3 ; $731f
	jr z, Label_11_7358 ; $7322
	ret ; $7324
Label_11_7325:
	ldh a, [hRomBank] ; $7325
	ld b, a ; $7327
	ld a, $07 ; $7328
	ld de, $766b ; $732a
	farcall FarPtr_0a_1a ; $732d
	ld a, $07 ; $7330
	farcall FarPtr_0a_1e ; $7332
	ret ; $7335
Label_11_7336:
	ldh a, [hRomBank] ; $7336
	ld b, a ; $7338
	ld a, $06 ; $7339
	ld de, $76cd ; $733b
	farcall FarPtr_0a_1a ; $733e
	ld a, $06 ; $7341
	farcall FarPtr_0a_1e ; $7343
	ret ; $7346
Label_11_7347:
	ldh a, [hRomBank] ; $7347
	ld b, a ; $7349
	ld a, $05 ; $734a
	ld de, $7700 ; $734c
	farcall FarPtr_0a_1a ; $734f
	ld a, $05 ; $7352
	farcall FarPtr_0a_1e ; $7354
	ret ; $7357
Label_11_7358:
	ldh a, [hRomBank] ; $7358
	ld b, a ; $735a
	ld a, $04 ; $735b
	ld de, $7745 ; $735d
	farcall FarPtr_0a_1a ; $7360
	ld a, $04 ; $7363
	farcall FarPtr_0a_1e ; $7365
	ret ; $7368
DrawRankingOpponentInfo:
	test_flag $0a, 0 ; $7369
	jr z, Label_11_7381 ; $736c
	test_flag $0a, 1 ; $736e
	jp z, Label_11_7438 ; $7371
	test_flag $0a, 2 ; $7374
	jp z, Label_11_74e3 ; $7377
	test_flag $0a, 3 ; $737a
	jp z, Label_11_7590 ; $737d
	ret ; $7380
Label_11_7381:
	push af ; $7381
	ld a, $0f ; $7382
	farcall FarPtr_0a_04 ; $7384
	pop af ; $7387
	ld a, $07 ; $7388
	ld b, a ; $738a
	ld a, $03 ; $738b
	farcall FarPtr_0a_30 ; $738d
	push af ; $7390
	ld a, $1e ; $7391
	farcall FarPtr_0a_04 ; $7393
	pop af ; $7396
	ld a, $07 ; $7397
	ld b, a ; $7399
	ld a, $00 ; $739a
	farcall FarPtr_0a_30 ; $739c
	push af ; $739f
	ld a, $1e ; $73a0
	farcall FarPtr_0a_04 ; $73a2
	pop af ; $73a5
	ld bc, $0020 ; $73a6
	farcall FarPtr_0a_38 ; $73a9
	ld a, $07 ; $73ac
	ld b, $00 ; $73ae
	farcall FarPtr_0a_3c ; $73b0
	farcall FarPtr_0a_3e ; $73b3
	ld a, $03 ; $73b6
	ld b, a ; $73b8
	ld a, $07 ; $73b9
	farcall FarPtr_0a_30 ; $73bb
	ld a, $07 ; $73be
	ld d, $03 ; $73c0
	farcall FarPtr_0a_34 ; $73c2
	ld a, $07 ; $73c5
	farcall FarPtr_0a_36 ; $73c7
	push af ; $73ca
	ld a, $0a ; $73cb
	farcall FarPtr_0a_04 ; $73cd
	pop af ; $73d0
	ldh a, [hRomBank] ; $73d1
	ld b, a ; $73d3
	ld a, $07 ; $73d4
	ld de, $7643 ; $73d6
	farcall FarPtr_0a_1a ; $73d9
	push af ; $73dc
	ld a, $0a ; $73dd
	farcall FarPtr_0a_04 ; $73df
	pop af ; $73e2
	ld a, $00 ; $73e3
	ld b, $00 ; $73e5
	farcall FarPtr_0a_3c ; $73e7
	ld a, $03 ; $73ea
	ld b, $40 ; $73ec
	farcall FarPtr_0a_2e ; $73ee
	farcall FarPtr_0a_3e ; $73f1
	ld a, $07 ; $73f4
	farcall FarPtr_0a_1e ; $73f6
	ld a, $00 ; $73f9
	ld b, a ; $73fb
	ld a, $07 ; $73fc
	farcall FarPtr_0a_30 ; $73fe
	ld a, $07 ; $7401
	ld d, $02 ; $7403
	farcall FarPtr_0a_34 ; $7405
	ld a, $07 ; $7408
	farcall FarPtr_0a_36 ; $740a
	ld hl, $082a ; $740d
	farcall FarPtr_0a_0e ; $7410
	ld a, $07 ; $7413
	farcall FarPtr_0a_08 ; $7415
	ld a, $07 ; $7418
	ld d, $03 ; $741a
	farcall FarPtr_0a_34 ; $741c
	ld a, $07 ; $741f
	farcall FarPtr_0a_36 ; $7421
	ld a, $07 ; $7424
	farcall FarPtr_0a_08 ; $7426
	push af ; $7429
	ld a, $0f ; $742a
	farcall FarPtr_0a_04 ; $742c
	pop af ; $742f
	ld a, $07 ; $7430
	ld b, $c0 ; $7432
	farcall FarPtr_0a_2e ; $7434
	ret ; $7437
Label_11_7438:
	push af ; $7438
	ld a, $0f ; $7439
	farcall FarPtr_0a_04 ; $743b
	pop af ; $743e
	ld a, $06 ; $743f
	ld b, a ; $7441
	ld a, $03 ; $7442
	farcall FarPtr_0a_30 ; $7444
	push af ; $7447
	ld a, $1e ; $7448
	farcall FarPtr_0a_04 ; $744a
	pop af ; $744d
	ld a, $06 ; $744e
	ld b, a ; $7450
	ld a, $00 ; $7451
	farcall FarPtr_0a_30 ; $7453
	push af ; $7456
	ld a, $1e ; $7457
	farcall FarPtr_0a_04 ; $7459
	pop af ; $745c
	ld bc, $0020 ; $745d
	farcall FarPtr_0a_38 ; $7460
	ld a, $06 ; $7463
	ld b, $00 ; $7465
	farcall FarPtr_0a_3c ; $7467
	farcall FarPtr_0a_3e ; $746a
	ld a, $03 ; $746d
	ld b, a ; $746f
	ld a, $06 ; $7470
	farcall FarPtr_0a_30 ; $7472
	ld a, $06 ; $7475
	ld d, $03 ; $7477
	farcall FarPtr_0a_34 ; $7479
	ld a, $06 ; $747c
	farcall FarPtr_0a_36 ; $747e
	ldh a, [hRomBank] ; $7481
	ld b, a ; $7483
	ld a, $06 ; $7484
	ld de, $76ab ; $7486
	farcall FarPtr_0a_1a ; $7489
	ld a, $00 ; $748c
	ld b, $00 ; $748e
	farcall FarPtr_0a_3c ; $7490
	ld a, $03 ; $7493
	ld b, $40 ; $7495
	farcall FarPtr_0a_2e ; $7497
	ld a, $06 ; $749a
	farcall FarPtr_0a_1e ; $749c
	ld a, $06 ; $749f
	ld b, a ; $74a1
	ld a, $00 ; $74a2
	farcall FarPtr_0a_30 ; $74a4
	ld a, $06 ; $74a7
	farcall FarPtr_0a_1e ; $74a9
	ld a, $06 ; $74ac
	ld d, $02 ; $74ae
	farcall FarPtr_0a_34 ; $74b0
	ld a, $06 ; $74b3
	farcall FarPtr_0a_36 ; $74b5
	ld hl, $082c ; $74b8
	farcall FarPtr_0a_0e ; $74bb
	ld a, $06 ; $74be
	farcall FarPtr_0a_08 ; $74c0
	ld a, $06 ; $74c3
	ld d, $03 ; $74c5
	farcall FarPtr_0a_34 ; $74c7
	ld a, $06 ; $74ca
	farcall FarPtr_0a_36 ; $74cc
	ld a, $06 ; $74cf
	farcall FarPtr_0a_08 ; $74d1
	push af ; $74d4
	ld a, $0f ; $74d5
	farcall FarPtr_0a_04 ; $74d7
	pop af ; $74da
	ld a, $06 ; $74db
	ld b, $c0 ; $74dd
	farcall FarPtr_0a_2e ; $74df
	ret ; $74e2
Label_11_74e3:
	push af ; $74e3
	ld a, $0f ; $74e4
	farcall FarPtr_0a_04 ; $74e6
	pop af ; $74e9
	ld a, $05 ; $74ea
	ld b, a ; $74ec
	ld a, $03 ; $74ed
	farcall FarPtr_0a_30 ; $74ef
	push af ; $74f2
	ld a, $1e ; $74f3
	farcall FarPtr_0a_04 ; $74f5
	pop af ; $74f8
	ld a, $05 ; $74f9
	ld b, a ; $74fb
	ld a, $00 ; $74fc
	farcall FarPtr_0a_30 ; $74fe
	push af ; $7501
	ld a, $1e ; $7502
	farcall FarPtr_0a_04 ; $7504
	pop af ; $7507
	ld bc, $0020 ; $7508
	farcall FarPtr_0a_38 ; $750b
	ld a, $05 ; $750e
	ld b, $00 ; $7510
	farcall FarPtr_0a_3c ; $7512
	farcall FarPtr_0a_3e ; $7515
	ld a, $03 ; $7518
	ld b, a ; $751a
	ld a, $05 ; $751b
	farcall FarPtr_0a_30 ; $751d
	ld a, $05 ; $7520
	ld d, $03 ; $7522
	farcall FarPtr_0a_34 ; $7524
	ld a, $05 ; $7527
	farcall FarPtr_0a_36 ; $7529
	ldh a, [hRomBank] ; $752c
	ld b, a ; $752e
	ld a, $05 ; $752f
	ld de, $76e9 ; $7531
	farcall FarPtr_0a_1a ; $7534
	push af ; $7537
	ld a, $0a ; $7538
	farcall FarPtr_0a_04 ; $753a
	pop af ; $753d
	ld a, $00 ; $753e
	ld b, $00 ; $7540
	farcall FarPtr_0a_3c ; $7542
	ld a, $03 ; $7545
	ld b, $40 ; $7547
	farcall FarPtr_0a_2e ; $7549
	ld a, $05 ; $754c
	farcall FarPtr_0a_1e ; $754e
	ld a, $05 ; $7551
	ld b, a ; $7553
	ld a, $00 ; $7554
	farcall FarPtr_0a_30 ; $7556
	ld a, $05 ; $7559
	ld d, $02 ; $755b
	farcall FarPtr_0a_34 ; $755d
	ld a, $05 ; $7560
	farcall FarPtr_0a_36 ; $7562
	ld hl, $082e ; $7565
	farcall FarPtr_0a_0e ; $7568
	ld a, $05 ; $756b
	farcall FarPtr_0a_08 ; $756d
	ld a, $05 ; $7570
	ld d, $03 ; $7572
	farcall FarPtr_0a_34 ; $7574
	ld a, $05 ; $7577
	farcall FarPtr_0a_36 ; $7579
	ld a, $05 ; $757c
	farcall FarPtr_0a_08 ; $757e
	push af ; $7581
	ld a, $0f ; $7582
	farcall FarPtr_0a_04 ; $7584
	pop af ; $7587
	ld a, $05 ; $7588
	ld b, $c0 ; $758a
	farcall FarPtr_0a_2e ; $758c
	ret ; $758f
Label_11_7590:
	push af ; $7590
	ld a, $0f ; $7591
	farcall FarPtr_0a_04 ; $7593
	pop af ; $7596
	ld a, $04 ; $7597
	ld b, a ; $7599
	ld a, $03 ; $759a
	farcall FarPtr_0a_30 ; $759c
	push af ; $759f
	ld a, $1e ; $75a0
	farcall FarPtr_0a_04 ; $75a2
	pop af ; $75a5
	ld a, $04 ; $75a6
	ld b, a ; $75a8
	ld a, $00 ; $75a9
	farcall FarPtr_0a_30 ; $75ab
	push af ; $75ae
	ld a, $1e ; $75af
	farcall FarPtr_0a_04 ; $75b1
	pop af ; $75b4
	ld bc, $0020 ; $75b5
	farcall FarPtr_0a_38 ; $75b8
	ld a, $04 ; $75bb
	ld b, $00 ; $75bd
	farcall FarPtr_0a_3c ; $75bf
	farcall FarPtr_0a_3e ; $75c2
	ld bc, $d040 ; $75c5
	ld a, $04 ; $75c8
	farcall FarPtr_0a_16 ; $75ca
	ld e, l ; $75cd
	ld d, h ; $75ce
	farcall FarPtr_04_1e ; $75cf
	ld a, $03 ; $75d2
	ld b, a ; $75d4
	ld a, $04 ; $75d5
	farcall FarPtr_0a_30 ; $75d7
	ld a, $04 ; $75da
	ld d, $03 ; $75dc
	farcall FarPtr_0a_34 ; $75de
	ld a, $04 ; $75e1
	farcall FarPtr_0a_36 ; $75e3
	ldh a, [hRomBank] ; $75e6
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
	INCBIN "data/bank_011/d_7643.bin" ; $7643, 338 bytes
	push af ; $7795
	ld a, $05 ; $7796
	farcall FarPtr_0a_04 ; $7798
	pop af ; $779b
	and a, a ; $779c
	jp nz, Label_11_7817 ; $779d
	ld a, $00 ; $77a0
	ld b, $00 ; $77a2
	farcall FarPtr_0a_2c ; $77a4
	ld a, $00 ; $77a7
	ld bc, $0018 ; $77a9
	farcall FarPtr_0a_18 ; $77ac
	ld a, $00 ; $77af
	ld bc, $1300 ; $77b1
	ld de, $1500 ; $77b4
	farcall FarPtr_0a_24 ; $77b7
	ld a, $00 ; $77ba
	farcall FarPtr_0a_20 ; $77bc
	ld a, $03 ; $77bf
	ld b, a ; $77c1
	ld a, $00 ; $77c2
	farcall FarPtr_0a_30 ; $77c4
	push af ; $77c7
	ld a, $1e ; $77c8
	farcall FarPtr_0a_04 ; $77ca
	pop af ; $77cd
	ld a, $00 ; $77ce
	ld b, a ; $77d0
	ld a, $03 ; $77d1
	farcall FarPtr_0a_30 ; $77d3
	farcall FarPtr_0a_10 ; $77d6
	test_flag $0a, 0 ; $77d9
	jr z, Label_11_77f1 ; $77dc
	farcall FarPtr_0a_10 ; $77de
	test_flag $0a, 1 ; $77e1
	jr z, Label_11_77f1 ; $77e4
	farcall FarPtr_0a_10 ; $77e6
	test_flag $0a, 2 ; $77e9
	jr z, Label_11_77f1 ; $77ec
	farcall FarPtr_0a_10 ; $77ee
Label_11_77f1:
	ld a, $03 ; $77f1
	farcall FarPtr_0a_08 ; $77f3
	call DrawRankingOpponentInfo ; $77f6
	ld a, $00 ; $77f9
	ld b, $c0 ; $77fb
	farcall FarPtr_0a_2e ; $77fd
	push af ; $7800
	ld a, $0f ; $7801
	farcall FarPtr_0a_04 ; $7803
	pop af ; $7806
	ld a, $03 ; $7807
	ld d, $02 ; $7809
	farcall FarPtr_0a_34 ; $780b
	ld a, $03 ; $780e
	farcall FarPtr_0a_36 ; $7810
	call PromptChallengeRankingOpponent ; $7813
	ret ; $7816
Label_11_7817:
	ld a, $03 ; $7817
	farcall FarPtr_0a_08 ; $7819
	ret ; $781c
StartNextRankingMatch:
	ld a, $00 ; $781d
	ld bc, $0020 ; $781f
	farcall FarPtr_0a_18 ; $7822
	test_flag $05, 7 ; $7825
	jp nz, Label_11_6596 ; $7828
	test_flag $0a, 0 ; $782b
	jr z, Label_11_7843 ; $782e
	test_flag $0a, 1 ; $7830
	jp z, Label_11_78cf ; $7833
	test_flag $0a, 2 ; $7836
	jp z, Label_11_795d ; $7839
	test_flag $0a, 3 ; $783c
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
	ldh a, [hRomBank] ; $7866
	ld b, a ; $7868
	ld a, $0e ; $7869
	ld de, $6dbc ; $786b
	farcall FarPtr_0a_1a ; $786e
	ldh a, [hRomBank] ; $7871
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
	ldh a, [hRomBank] ; $788b
	ld b, a ; $788d
	ld a, $07 ; $788e
	ld de, $765a ; $7890
	farcall FarPtr_0a_1a ; $7893
	ldh a, [hRomBank] ; $7896
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
	farcall FarPtr_InitStoryMatchSettings ; $78b8
	ld a, $00 ; $78bb
	ld [wCurrentMinigameStoryMatch], a ; $78bd
	ld a, $01 ; $78c0
	ld [$c8f7], a ; $78c2
	farcall FarPtr_LoadMatchSettingsFromTable ; $78c5
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
	ldh a, [hRomBank] ; $78f2
	ld b, a ; $78f4
	ld a, $0c ; $78f5
	ld de, $6dda ; $78f7
	farcall FarPtr_0a_1a ; $78fa
	ldh a, [hRomBank] ; $78fd
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
	ldh a, [hRomBank] ; $7919
	ld b, a ; $791b
	ld a, $06 ; $791c
	ld de, $76bc ; $791e
	farcall FarPtr_0a_1a ; $7921
	ldh a, [hRomBank] ; $7924
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
	farcall FarPtr_InitStoryMatchSettings ; $7946
	ld a, $00 ; $7949
	ld [wCurrentMinigameStoryMatch], a ; $794b
	ld a, $02 ; $794e
	ld [$c8f7], a ; $7950
	farcall FarPtr_LoadMatchSettingsFromTable ; $7953
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
	ldh a, [hRomBank] ; $7980
	ld b, a ; $7982
	ld a, $0c ; $7983
	ld de, $6dda ; $7985
	farcall FarPtr_0a_1a ; $7988
	ldh a, [hRomBank] ; $798b
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
	ldh a, [hRomBank] ; $79a7
	ld b, a ; $79a9
	ld a, $05 ; $79aa
	ld de, $76bc ; $79ac
	farcall FarPtr_0a_1a ; $79af
	ldh a, [hRomBank] ; $79b2
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
	farcall FarPtr_InitStoryMatchSettings ; $79d1
	ld a, $00 ; $79d4
	ld [wCurrentMinigameStoryMatch], a ; $79d6
	ld a, $03 ; $79d9
	ld [$c8f7], a ; $79db
	farcall FarPtr_LoadMatchSettingsFromTable ; $79de
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
	ldh a, [hRomBank] ; $7a0b
	ld b, a ; $7a0d
	ld a, $0e ; $7a0e
	ld de, $6dbc ; $7a10
	farcall FarPtr_0a_1a ; $7a13
	ldh a, [hRomBank] ; $7a16
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
	ldh a, [hRomBank] ; $7a32
	ld b, a ; $7a34
	ld a, $04 ; $7a35
	ld de, $765a ; $7a37
	farcall FarPtr_0a_1a ; $7a3a
	ldh a, [hRomBank] ; $7a3d
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
	farcall FarPtr_InitStoryMatchSettings ; $7a5f
	ld a, $00 ; $7a62
	ld [wCurrentMinigameStoryMatch], a ; $7a64
	ld a, $04 ; $7a67
	ld [$c8f7], a ; $7a69
	farcall FarPtr_LoadMatchSettingsFromTable ; $7a6c
	farcall FarPtr_0a_4c ; $7a6f
	farcall FarPtr_0a_4e ; $7a72
	ret ; $7a75
Func_11_7a76:
	ld a, $0e ; $7a76
	farcall FarPtr_0a_1c ; $7a78
	ld a, $0f ; $7a7b
	farcall FarPtr_0a_1c ; $7a7d
	ld a, $0e ; $7a80
	ld d, $01 ; $7a82
	farcall FarPtr_0a_34 ; $7a84
	ld a, $0f ; $7a87
	ld d, $01 ; $7a89
	farcall FarPtr_0a_34 ; $7a8b
	ld a, $0e ; $7a8e
	ld bc, $1f00 ; $7a90
	ld de, $0b00 ; $7a93
	farcall FarPtr_0a_22 ; $7a96
	ld a, $0f ; $7a99
	ld bc, $1f00 ; $7a9b
	ld de, $1300 ; $7a9e
	farcall FarPtr_0a_22 ; $7aa1
	ld a, $0e ; $7aa4
	ld b, $80 ; $7aa6
	farcall FarPtr_0a_2e ; $7aa8
	ld a, $0f ; $7aab
	ld b, $80 ; $7aad
	farcall FarPtr_0a_2e ; $7aaf
	ret ; $7ab2
Func_11_7ab3:
	ld a, $0c ; $7ab3
	farcall FarPtr_0a_1c ; $7ab5
	ld a, $0d ; $7ab8
	farcall FarPtr_0a_1c ; $7aba
	ld a, $0c ; $7abd
	ld d, $01 ; $7abf
	farcall FarPtr_0a_34 ; $7ac1
	ld a, $0d ; $7ac4
	ld d, $01 ; $7ac6
	farcall FarPtr_0a_34 ; $7ac8
	ld a, $0c ; $7acb
	ld bc, $0f00 ; $7acd
	ld de, $0b00 ; $7ad0
	farcall FarPtr_0a_22 ; $7ad3
	ld a, $0d ; $7ad6
	ld bc, $0f00 ; $7ad8
	ld de, $1300 ; $7adb
	farcall FarPtr_0a_22 ; $7ade
	ld a, $0c ; $7ae1
	ld b, $80 ; $7ae3
	farcall FarPtr_0a_2e ; $7ae5
	ld a, $0d ; $7ae8
	ld b, $80 ; $7aea
	farcall FarPtr_0a_2e ; $7aec
	push af ; $7aef
	ld a, $14 ; $7af0
	farcall FarPtr_0a_04 ; $7af2
	pop af ; $7af5
	ret ; $7af6
	INCBIN "data/bank_011/d_7af7.bin" ; $7af7, 54 bytes
Func_11_7b2d:
	ld a, $0e ; $7b2d
	ld bc, $1800 ; $7b2f
	ld de, $0b00 ; $7b32
	farcall FarPtr_0a_24 ; $7b35
	ld a, $0f ; $7b38
	ld bc, $1c00 ; $7b3a
	ld de, $1700 ; $7b3d
	farcall FarPtr_0a_24 ; $7b40
	ld a, $0f ; $7b43
	farcall FarPtr_0a_20 ; $7b45
	ld a, $0f ; $7b48
	ld b, $c0 ; $7b4a
	farcall FarPtr_0a_2e ; $7b4c
	ld a, $0e ; $7b4f
	farcall FarPtr_0a_20 ; $7b51
	ldh a, [hRomBank] ; $7b54
	ld b, a ; $7b56
	ld a, $0e ; $7b57
	ld de, $7bdf ; $7b59
	farcall FarPtr_0a_1a ; $7b5c
	ldh a, [hRomBank] ; $7b5f
	ld b, a ; $7b61
	ld a, $0f ; $7b62
	ld de, $7c42 ; $7b64
	farcall FarPtr_0a_1a ; $7b67
	ret ; $7b6a
Func_11_7b6b:
	ld a, $0c ; $7b6b
	ld bc, $0800 ; $7b6d
	ld de, $0b00 ; $7b70
	farcall FarPtr_0a_24 ; $7b73
	ld a, $0d ; $7b76
	ld bc, $0c00 ; $7b78
	ld de, $1700 ; $7b7b
	farcall FarPtr_0a_24 ; $7b7e
	ld a, $0d ; $7b81
	farcall FarPtr_0a_20 ; $7b83
	ld a, $0d ; $7b86
	ld b, $c0 ; $7b88
	farcall FarPtr_0a_2e ; $7b8a
	ld a, $0c ; $7b8d
	farcall FarPtr_0a_20 ; $7b8f
	ldh a, [hRomBank] ; $7b92
	ld b, a ; $7b94
	ld a, $0c ; $7b95
	ld de, $7ca9 ; $7b97
	farcall FarPtr_0a_1a ; $7b9a
	ldh a, [hRomBank] ; $7b9d
	ld b, a ; $7b9f
	ld a, $0d ; $7ba0
	ld de, $7d10 ; $7ba2
	farcall FarPtr_0a_1a ; $7ba5
	ret ; $7ba8
	INCBIN "data/bank_011/d_7ba9.bin" ; $7ba9, 40 bytes
	ret ; $7bd1
	INCBIN "data/bank_011/d_7bd2.bin" ; $7bd2, 451 bytes
ComputeRankingProgressIndex:
	test_flag $05, 7 ; $7d95
	jr nz, Label_11_7dbc ; $7d98
	ld a, $00 ; $7d9a
	test_flag $0a, 3 ; $7d9c
	jr z, Label_11_7db8 ; $7d9f
	ld a, $02 ; $7da1
	test_flag $0a, 7 ; $7da3
	jr z, Label_11_7db8 ; $7da6
	ld a, $04 ; $7da8
	test_flag $15, 6 ; $7daa
	jr z, Label_11_7db8 ; $7dad
	ld a, $06 ; $7daf
	test_flag $16, 0 ; $7db1
	jr z, Label_11_7db8 ; $7db4
	ld a, $08 ; $7db6
Label_11_7db8:
	ld [$c2b0], a ; $7db8
	ret ; $7dbb
Label_11_7dbc:
	ld a, $01 ; $7dbc
	test_flag $08, 2 ; $7dbe
	jr z, Label_11_7db8 ; $7dc1
	ld a, $03 ; $7dc3
	test_flag $08, 6 ; $7dc5
	jr z, Label_11_7db8 ; $7dc8
	ld a, $05 ; $7dca
	test_flag $15, 7 ; $7dcc
	jr z, Label_11_7db8 ; $7dcf
	ld a, $07 ; $7dd1
	test_flag $16, 1 ; $7dd3
	jr z, Label_11_7db8 ; $7dd6
	ld a, $09 ; $7dd8
	jr Label_11_7db8 ; $7dda
	INCBIN "data/bank_011/d_7ddc.bin" ; $7ddc, 49 bytes
	ds 499, $ff ; $7e0d, fill

SECTION "ROM Bank $0f", ROMX[$4000], BANK[$0f]

	INCBIN "data/bank_00f/d_4000.bin" ; $4000, 1417 bytes
	farcall FarPtr_0a_34 ; $4589
	ld a, $08 ; $458c
	farcall FarPtr_0a_36 ; $458e
	ld a, $08 ; $4591
	farcall FarPtr_0a_08 ; $4593
	ld a, $14 ; $4596
	ld bc, $0c80 ; $4598
	ld de, $1900 ; $459b
	farcall FarPtr_0a_22 ; $459e
	sound $96 ; $45a1
	ld a, $78 ; $45a3
	call DelayFrames ; $45a5
	ld a, $14 ; $45a8
	ld bc, $3f00 ; $45aa
	ld de, $3f00 ; $45ad
	farcall FarPtr_0a_22 ; $45b0
	jp Label_0f_4661 ; $45b3
	INCBIN "data/bank_00f/d_45b6.bin" ; $45b6, 168 bytes
	farcall FarPtr_0a_22 ; $465e
Label_0f_4661:
	call Func_0f_567f ; $4661
	call Func_0f_567f ; $4664
	ld a, $08 ; $4667
	farcall FarPtr_0a_08 ; $4669
	call Func_0f_567f ; $466c
	call Func_0f_567f ; $466f
	ld a, $08 ; $4672
	ld bc, $0900 ; $4674
	ld de, $1d00 ; $4677
	farcall FarPtr_0a_24 ; $467a
	ld a, $08 ; $467d
	farcall FarPtr_0a_20 ; $467f
	ld a, $08 ; $4682
	ld b, $00 ; $4684
	farcall FarPtr_0a_2e ; $4686
	ld a, $01 ; $4689
	call DelayFrames ; $468b
	ld a, $16 ; $468e
	ld bc, $3f00 ; $4690
	ld de, $3f00 ; $4693
	farcall FarPtr_0a_22 ; $4696
	test_flag $05, 7 ; $4699
	jp z, Label_0f_4700 ; $469c
	ld a, $15 ; $469f
	ld bc, $3f00 ; $46a1
	ld de, $3f00 ; $46a4
	farcall FarPtr_0a_22 ; $46a7
	ld d, $4d ; $46aa
	ld a, $15 ; $46ac
	farcall FarPtr_0a_16 ; $46ae
	ld c, l ; $46b1
	ld b, h ; $46b2
	farcall FarPtr_04_2c ; $46b3
	ld a, $15 ; $46b6
	ld d, $01 ; $46b8
	farcall FarPtr_0a_34 ; $46ba
	ld a, $00 ; $46bd
	ld b, $40 ; $46bf
	farcall FarPtr_0a_2e ; $46c1
	ld a, $00 ; $46c4
	ld bc, $0b00 ; $46c6
	ld de, $1b00 ; $46c9
	farcall FarPtr_0a_22 ; $46cc
	ld a, $02 ; $46cf
	ld bc, $0d00 ; $46d1
	ld de, $1b00 ; $46d4
	farcall FarPtr_0a_22 ; $46d7
	ld a, $01 ; $46da
	call DelayFrames ; $46dc
	ld a, $00 ; $46df
	ld b, $40 ; $46e1
	farcall FarPtr_0a_2e ; $46e3
	ld a, $02 ; $46e6
	ld b, $40 ; $46e8
	farcall FarPtr_0a_2e ; $46ea
	ld a, $01 ; $46ed
	call DelayFrames ; $46ef
	ld a, $02 ; $46f2
	farcall FarPtr_0a_16 ; $46f4
	ld c, l ; $46f7
	ld b, h ; $46f8
	ld de, $d000 ; $46f9
	farcall FarPtr_04_20 ; $46fc
	ret ; $46ff
Label_0f_4700:
	ld a, $00 ; $4700
	ld bc, $0b80 ; $4702
	ld de, $1b00 ; $4705
	farcall FarPtr_0a_22 ; $4708
	ld a, $00 ; $470b
	ld b, $40 ; $470d
	farcall FarPtr_0a_2e ; $470f
	ld a, $01 ; $4712
	call DelayFrames ; $4714
	ld a, $03 ; $4717
	farcall FarPtr_0a_16 ; $4719
	ld c, l ; $471c
	ld b, h ; $471d
	ld de, $d000 ; $471e
	farcall FarPtr_04_20 ; $4721
	ret ; $4724
	INCBIN "data/bank_00f/d_4725.bin" ; $4725, 230 bytes
	farcall FarPtr_0a_38 ; $480b
	xor a, a ; $480e
	ld bc, $0c00 ; $480f
	ld de, $1300 ; $4812
	farcall FarPtr_0a_3a ; $4815
	farcall FarPtr_0a_3e ; $4818
	call Func_0f_5ccf ; $481b
	ld a, $0c ; $481e
	ld bc, $0e00 ; $4820
	ld de, $1300 ; $4823
	farcall FarPtr_0a_24 ; $4826
	ld a, $0c ; $4829
	farcall FarPtr_0a_20 ; $482b
	ld a, $0c ; $482e
	ld b, $c0 ; $4830
	farcall FarPtr_0a_2e ; $4832
	ld a, $0f ; $4835
	ld bc, $0010 ; $4837
	farcall FarPtr_0a_18 ; $483a
	ld a, $10 ; $483d
	ld bc, $0010 ; $483f
	farcall FarPtr_0a_18 ; $4842
	ld a, $10 ; $4845
	ld bc, $1100 ; $4847
	ld de, $1600 ; $484a
	farcall FarPtr_0a_24 ; $484d
	ld a, $10 ; $4850
	farcall FarPtr_0a_20 ; $4852
	ld a, $10 ; $4855
	ld b, $40 ; $4857
	farcall FarPtr_0a_2e ; $4859
	ld a, $14 ; $485c
	call DelayFrames ; $485e
	ld a, $0f ; $4861
	ld bc, $1180 ; $4863
	ld de, $1600 ; $4866
	farcall FarPtr_0a_22 ; $4869
	ld a, $14 ; $486c
	call DelayFrames ; $486e
	call Func_0f_5e4a ; $4871
	ld d, $5c ; $4874
	ld a, $11 ; $4876
	farcall FarPtr_0a_16 ; $4878
	ld c, l ; $487b
	ld b, h ; $487c
	farcall FarPtr_04_2c ; $487d
	ld a, $11 ; $4880
	ld d, $01 ; $4882
	farcall FarPtr_0a_34 ; $4884
	ld a, $03 ; $4887
	ld bc, $3f00 ; $4889
	ld de, $3f00 ; $488c
	farcall FarPtr_0a_22 ; $488f
	ld a, $11 ; $4892
	ld bc, $0e00 ; $4894
	ld de, $0e40 ; $4897
	farcall FarPtr_0a_22 ; $489a
	ld a, $11 ; $489d
	ld b, $40 ; $489f
	farcall FarPtr_0a_2e ; $48a1
	ld a, $0c ; $48a4
	ld bc, $0010 ; $48a6
	farcall FarPtr_0a_18 ; $48a9
	ld a, $0f ; $48ac
	ld bc, $0010 ; $48ae
	farcall FarPtr_0a_18 ; $48b1
	ld a, $0c ; $48b4
	ld bc, $0e00 ; $48b6
	ld de, $1100 ; $48b9
	farcall FarPtr_0a_24 ; $48bc
	ld a, $0f ; $48bf
	ld bc, $0e00 ; $48c1
	ld de, $1000 ; $48c4
	farcall FarPtr_0a_24 ; $48c7
	ld a, $0f ; $48ca
	farcall FarPtr_0a_20 ; $48cc
	ld a, $1e ; $48cf
	call DelayFrames ; $48d1
	ld a, $0c ; $48d4
	farcall FarPtr_0a_08 ; $48d6
	ld a, $1e ; $48d9
	call DelayFrames ; $48db
	ld a, $0c ; $48de
	ld bc, $0e00 ; $48e0
	ld de, $1040 ; $48e3
	farcall FarPtr_0a_24 ; $48e6
	ld a, $0f ; $48e9
	ld bc, $0e00 ; $48eb
	ld de, $0f40 ; $48ee
	farcall FarPtr_0a_24 ; $48f1
	ld a, $0f ; $48f4
	farcall FarPtr_0a_20 ; $48f6
	ld a, $05 ; $48f9
	call DelayFrames ; $48fb
	ld a, $0c ; $48fe
	ld b, $01 ; $4900
	farcall FarPtr_0a_2c ; $4902
	ld a, $0c ; $4905
	ld bc, $0e00 ; $4907
	ld de, $1100 ; $490a
	farcall FarPtr_0a_24 ; $490d
	ld a, $0c ; $4910
	farcall FarPtr_0a_20 ; $4912
	ld a, $0c ; $4915
	ld b, $00 ; $4917
	farcall FarPtr_0a_2c ; $4919
	ld a, $0c ; $491c
	ld b, $c0 ; $491e
	farcall FarPtr_0a_2e ; $4920
	ld a, $14 ; $4923
	call DelayFrames ; $4925
	ld a, $0f ; $4928
	ld bc, $3f00 ; $492a
	ld de, $3f00 ; $492d
	farcall FarPtr_0a_22 ; $4930
	ld a, $11 ; $4933
	ld d, $02 ; $4935
	farcall FarPtr_0a_34 ; $4937
	ld a, $11 ; $493a
	farcall FarPtr_0a_36 ; $493c
	ld a, $11 ; $493f
	farcall FarPtr_0a_08 ; $4941
	ld a, $15 ; $4944
	ld bc, $0f80 ; $4946
	ld de, $0f80 ; $4949
	farcall FarPtr_0a_22 ; $494c
	sound $98 ; $494f
	ld a, $78 ; $4951
	call DelayFrames ; $4953
	ld a, $15 ; $4956
	ld bc, $3f00 ; $4958
	ld de, $3f00 ; $495b
	farcall FarPtr_0a_22 ; $495e
	ld a, $11 ; $4961
	ld d, $04 ; $4963
	farcall FarPtr_0a_34 ; $4965
	ld a, $11 ; $4968
	farcall FarPtr_0a_36 ; $496a
	ld a, $11 ; $496d
	farcall FarPtr_0a_08 ; $496f
	ld a, $16 ; $4972
	farcall FarPtr_0a_16 ; $4974
	ld a, $01 ; $4977
	ld e, l ; $4979
	ld d, h ; $497a
	ld hl, $0018 ; $497b
	add hl, de ; $497e
	ld [hl], a ; $497f
	ld a, $0c ; $4980
	farcall FarPtr_0a_16 ; $4982
	ld a, $01 ; $4985
	ld e, l ; $4987
	ld d, h ; $4988
	ld hl, $0018 ; $4989
	add hl, de ; $498c
	ld [hl], a ; $498d
	ld a, $16 ; $498e
	ld d, $02 ; $4990
	farcall FarPtr_0a_34 ; $4992
	ld a, $16 ; $4995
	farcall FarPtr_0a_36 ; $4997
	ld a, $0c ; $499a
	ld d, $03 ; $499c
	farcall FarPtr_0a_34 ; $499e
	ld a, $0c ; $49a1
	farcall FarPtr_0a_36 ; $49a3
	ld a, $0c ; $49a6
	farcall FarPtr_0a_08 ; $49a8
	ld a, $1e ; $49ab
	call DelayFrames ; $49ad
	ld a, $0c ; $49b0
	ld bc, $0e00 ; $49b2
	ld de, $1300 ; $49b5
	farcall FarPtr_0a_24 ; $49b8
	ld a, $0c ; $49bb
	farcall FarPtr_0a_20 ; $49bd
	ld a, $0c ; $49c0
	ld bc, $0a00 ; $49c2
	ld de, $1300 ; $49c5
	farcall FarPtr_0a_24 ; $49c8
	ld a, $0c ; $49cb
	farcall FarPtr_0a_20 ; $49cd
	ld a, $0c ; $49d0
	ld b, $c0 ; $49d2
	farcall FarPtr_0a_2e ; $49d4
	ld a, $14 ; $49d7
	call DelayFrames ; $49d9
	ld a, $0e ; $49dc
	ld bc, $0010 ; $49de
	farcall FarPtr_0a_18 ; $49e1
	ld a, $10 ; $49e4
	ld bc, $0010 ; $49e6
	farcall FarPtr_0a_18 ; $49e9
	ld a, $10 ; $49ec
	ld bc, $1000 ; $49ee
	ld de, $1600 ; $49f1
	farcall FarPtr_0a_24 ; $49f4
	ld a, $10 ; $49f7
	farcall FarPtr_0a_20 ; $49f9
	ld a, $10 ; $49fc
	ld b, $40 ; $49fe
	farcall FarPtr_0a_2e ; $4a00
	ld a, $14 ; $4a03
	call DelayFrames ; $4a05
	ld a, $0e ; $4a08
	ld bc, $1080 ; $4a0a
	ld de, $1600 ; $4a0d
	farcall FarPtr_0a_22 ; $4a10
	ld a, $14 ; $4a13
	call DelayFrames ; $4a15
	ld d, $74 ; $4a18
	ld a, $10 ; $4a1a
	farcall FarPtr_0a_16 ; $4a1c
	ld c, l ; $4a1f
	ld b, h ; $4a20
	farcall FarPtr_04_2c ; $4a21
	ld a, $10 ; $4a24
	ld d, $01 ; $4a26
	farcall FarPtr_0a_34 ; $4a28
	ld d, $25 ; $4a2b
	ld a, $0e ; $4a2d
	farcall FarPtr_0a_16 ; $4a2f
	ld c, l ; $4a32
	ld b, h ; $4a33
	farcall FarPtr_04_2c ; $4a34
	ld a, $0e ; $4a37
	ld d, $01 ; $4a39
	farcall FarPtr_0a_34 ; $4a3b
	ld a, $0e ; $4a3e
	ld bc, $1000 ; $4a40
	ld de, $1600 ; $4a43
	farcall FarPtr_0a_22 ; $4a46
	ld a, $10 ; $4a49
	ld bc, $1000 ; $4a4b
	ld de, $1500 ; $4a4e
	farcall FarPtr_0a_22 ; $4a51
	ld a, $0e ; $4a54
	ld b, $c0 ; $4a56
	farcall FarPtr_0a_2e ; $4a58
	ld a, $10 ; $4a5b
	ld d, $08 ; $4a5d
	farcall FarPtr_0a_34 ; $4a5f
	ld a, $10 ; $4a62
	ld bc, $1000 ; $4a64
	ld de, $1200 ; $4a67
	farcall FarPtr_0a_24 ; $4a6a
	ld a, $0e ; $4a6d
	ld bc, $1000 ; $4a6f
	ld de, $1300 ; $4a72
	farcall FarPtr_0a_24 ; $4a75
	ld a, $0e ; $4a78
	farcall FarPtr_0a_20 ; $4a7a
	ld d, $25 ; $4a7d
	ld a, $10 ; $4a7f
	farcall FarPtr_0a_16 ; $4a81
	ld c, l ; $4a84
	ld b, h ; $4a85
	farcall FarPtr_04_2c ; $4a86
	ld a, $10 ; $4a89
	ld d, $01 ; $4a8b
	farcall FarPtr_0a_34 ; $4a8d
	ld d, $74 ; $4a90
	ld a, $0e ; $4a92
	farcall FarPtr_0a_16 ; $4a94
	ld c, l ; $4a97
	ld b, h ; $4a98
	farcall FarPtr_04_2c ; $4a99
	ld a, $0e ; $4a9c
	ld d, $01 ; $4a9e
	farcall FarPtr_0a_34 ; $4aa0
	ld a, $10 ; $4aa3
	ld bc, $1000 ; $4aa5
	ld de, $1300 ; $4aa8
	farcall FarPtr_0a_22 ; $4aab
	ld a, $0e ; $4aae
	ld bc, $0f00 ; $4ab0
	ld de, $1300 ; $4ab3
	farcall FarPtr_0a_22 ; $4ab6
	ld a, $10 ; $4ab9
	ld b, $80 ; $4abb
	farcall FarPtr_0a_2e ; $4abd
	ld a, $0e ; $4ac0
	ld d, $08 ; $4ac2
	farcall FarPtr_0a_34 ; $4ac4
	ld a, $10 ; $4ac7
	ld bc, $0c00 ; $4ac9
	ld de, $1300 ; $4acc
	farcall FarPtr_0a_24 ; $4acf
	ld a, $0e ; $4ad2
	ld bc, $0b00 ; $4ad4
	ld de, $1300 ; $4ad7
	farcall FarPtr_0a_24 ; $4ada
	ld a, $0e ; $4add
	farcall FarPtr_0a_20 ; $4adf
	ld a, $10 ; $4ae2
	ld b, $01 ; $4ae4
	farcall FarPtr_0a_2c ; $4ae6
	ld a, $10 ; $4ae9
	ld bc, $0e00 ; $4aeb
	ld de, $1300 ; $4aee
	farcall FarPtr_0a_24 ; $4af1
	ld a, $10 ; $4af4
	farcall FarPtr_0a_20 ; $4af6
	ld a, $10 ; $4af9
	ld b, $00 ; $4afb
	farcall FarPtr_0a_2c ; $4afd
	ld a, $10 ; $4b00
	ld bc, $0020 ; $4b02
	farcall FarPtr_0a_18 ; $4b05
	ld a, $10 ; $4b08
	ld bc, $1000 ; $4b0a
	ld de, $1600 ; $4b0d
	farcall FarPtr_0a_24 ; $4b10
	ld a, $10 ; $4b13
	farcall FarPtr_0a_20 ; $4b15
	ld a, $10 ; $4b18
	ld b, $c0 ; $4b1a
	farcall FarPtr_0a_2e ; $4b1c
	ld d, $61 ; $4b1f
	ld a, $12 ; $4b21
	farcall FarPtr_0a_16 ; $4b23
	ld c, l ; $4b26
	ld b, h ; $4b27
	farcall FarPtr_04_2c ; $4b28
	ld a, $12 ; $4b2b
	ld d, $01 ; $4b2d
	farcall FarPtr_0a_34 ; $4b2f
	ld a, $04 ; $4b32
	ld bc, $3f00 ; $4b34
	ld de, $3f00 ; $4b37
	farcall FarPtr_0a_22 ; $4b3a
	ld a, $12 ; $4b3d
	ld bc, $0a00 ; $4b3f
	ld de, $0dc0 ; $4b42
	farcall FarPtr_0a_22 ; $4b45
	ld a, $12 ; $4b48
	ld b, $40 ; $4b4a
	farcall FarPtr_0a_2e ; $4b4c
	ld a, $0c ; $4b4f
	ld bc, $0010 ; $4b51
	farcall FarPtr_0a_18 ; $4b54
	ld a, $0e ; $4b57
	ld bc, $0010 ; $4b59
	farcall FarPtr_0a_18 ; $4b5c
	ld a, $0c ; $4b5f
	ld bc, $0a00 ; $4b61
	ld de, $1100 ; $4b64
	farcall FarPtr_0a_24 ; $4b67
	ld a, $0e ; $4b6a
	ld bc, $0a00 ; $4b6c
	ld de, $1000 ; $4b6f
	farcall FarPtr_0a_24 ; $4b72
	ld a, $0e ; $4b75
	farcall FarPtr_0a_20 ; $4b77
	ld a, $1e ; $4b7a
	call DelayFrames ; $4b7c
	ld a, $0c ; $4b7f
	farcall FarPtr_0a_08 ; $4b81
	ld a, $1e ; $4b84
	call DelayFrames ; $4b86
	ld a, $0c ; $4b89
	ld bc, $0a00 ; $4b8b
	ld de, $0fc0 ; $4b8e
	farcall FarPtr_0a_24 ; $4b91
	ld a, $0e ; $4b94
	ld bc, $0a00 ; $4b96
	ld de, $0ec0 ; $4b99
	farcall FarPtr_0a_24 ; $4b9c
	ld a, $0e ; $4b9f
	farcall FarPtr_0a_20 ; $4ba1
	ld a, $05 ; $4ba4
	call DelayFrames ; $4ba6
	ld a, $12 ; $4ba9
	ld d, $02 ; $4bab
	farcall FarPtr_0a_34 ; $4bad
	ld a, $12 ; $4bb0
	farcall FarPtr_0a_36 ; $4bb2
	ld a, $0c ; $4bb5
	ld b, $01 ; $4bb7
	farcall FarPtr_0a_2c ; $4bb9
	ld a, $0c ; $4bbc
	ld bc, $0a00 ; $4bbe
	ld de, $1100 ; $4bc1
	farcall FarPtr_0a_24 ; $4bc4
	ld a, $0c ; $4bc7
	farcall FarPtr_0a_20 ; $4bc9
	ld a, $0c ; $4bcc
	ld b, $00 ; $4bce
	farcall FarPtr_0a_2c ; $4bd0
	ld a, $0c ; $4bd3
	ld b, $c0 ; $4bd5
	farcall FarPtr_0a_2e ; $4bd7
	ld a, $14 ; $4bda
	call DelayFrames ; $4bdc
	ld a, $0e ; $4bdf
	ld bc, $3f00 ; $4be1
	ld de, $3f00 ; $4be4
	farcall FarPtr_0a_22 ; $4be7
	ld a, $13 ; $4bea
	ld bc, $0b80 ; $4bec
	ld de, $0c40 ; $4bef
	farcall FarPtr_0a_22 ; $4bf2
	sound $99 ; $4bf5
	ld a, $12 ; $4bf7
	farcall FarPtr_0a_08 ; $4bf9
	ld a, $13 ; $4bfc
	ld bc, $3f00 ; $4bfe
	ld de, $3f00 ; $4c01
	farcall FarPtr_0a_22 ; $4c04
	ld a, $15 ; $4c07
	ld bc, $0b80 ; $4c09
	ld de, $0f80 ; $4c0c
	farcall FarPtr_0a_22 ; $4c0f
	sound $98 ; $4c12
	ld a, $78 ; $4c14
	call DelayFrames ; $4c16
	ld a, $15 ; $4c19
	ld bc, $3f00 ; $4c1b
	ld de, $3f00 ; $4c1e
	farcall FarPtr_0a_22 ; $4c21
	ld a, $12 ; $4c24
	ld d, $04 ; $4c26
	farcall FarPtr_0a_34 ; $4c28
	ld a, $12 ; $4c2b
	farcall FarPtr_0a_36 ; $4c2d
	ld a, $12 ; $4c30
	farcall FarPtr_0a_08 ; $4c32
	ld a, $0c ; $4c35
	ld d, $03 ; $4c37
	farcall FarPtr_0a_34 ; $4c39
	ld a, $0c ; $4c3c
	farcall FarPtr_0a_36 ; $4c3e
	ld a, $0c ; $4c41
	farcall FarPtr_0a_08 ; $4c43
	ld a, $1e ; $4c46
	call DelayFrames ; $4c48
	ld a, $0c ; $4c4b
	ld bc, $0a00 ; $4c4d
	ld de, $1300 ; $4c50
	farcall FarPtr_0a_24 ; $4c53
	ld a, $0c ; $4c56
	farcall FarPtr_0a_20 ; $4c58
	ld a, $0c ; $4c5b
	ld bc, $0c00 ; $4c5d
	ld de, $1300 ; $4c60
	farcall FarPtr_0a_24 ; $4c63
	ld a, $0c ; $4c66
	farcall FarPtr_0a_20 ; $4c68
	ld a, $0c ; $4c6b
	ld b, $c0 ; $4c6d
	farcall FarPtr_0a_2e ; $4c6f
	ld a, $0d ; $4c72
	ld bc, $0010 ; $4c74
	farcall FarPtr_0a_18 ; $4c77
	ld a, $10 ; $4c7a
	ld bc, $0010 ; $4c7c
	farcall FarPtr_0a_18 ; $4c7f
	ld a, $10 ; $4c82
	ld bc, $0f00 ; $4c84
	ld de, $1600 ; $4c87
	farcall FarPtr_0a_24 ; $4c8a
	ld a, $10 ; $4c8d
	farcall FarPtr_0a_20 ; $4c8f
	ld a, $10 ; $4c92
	ld b, $40 ; $4c94
	farcall FarPtr_0a_2e ; $4c96
	ld a, $14 ; $4c99
	call DelayFrames ; $4c9b
	ld a, $0d ; $4c9e
	ld bc, $0f80 ; $4ca0
	ld de, $1600 ; $4ca3
	farcall FarPtr_0a_22 ; $4ca6
	ld a, $14 ; $4ca9
	call DelayFrames ; $4cab
	ld d, $74 ; $4cae
	ld a, $10 ; $4cb0
	farcall FarPtr_0a_16 ; $4cb2
	ld c, l ; $4cb5
	ld b, h ; $4cb6
	farcall FarPtr_04_2c ; $4cb7
	ld a, $10 ; $4cba
	ld d, $01 ; $4cbc
	farcall FarPtr_0a_34 ; $4cbe
	ld d, $25 ; $4cc1
	ld a, $0d ; $4cc3
	farcall FarPtr_0a_16 ; $4cc5
	ld c, l ; $4cc8
	ld b, h ; $4cc9
	farcall FarPtr_04_2c ; $4cca
	ld a, $0d ; $4ccd
	ld d, $01 ; $4ccf
	farcall FarPtr_0a_34 ; $4cd1
	ld a, $0d ; $4cd4
	ld bc, $0f00 ; $4cd6
	ld de, $1600 ; $4cd9
	farcall FarPtr_0a_22 ; $4cdc
	ld a, $10 ; $4cdf
	ld bc, $0f00 ; $4ce1
	ld de, $1500 ; $4ce4
	farcall FarPtr_0a_22 ; $4ce7
	ld a, $0d ; $4cea
	ld b, $c0 ; $4cec
	farcall FarPtr_0a_2e ; $4cee
	ld a, $10 ; $4cf1
	ld d, $06 ; $4cf3
	farcall FarPtr_0a_34 ; $4cf5
	ld a, $10 ; $4cf8
	ld bc, $0f00 ; $4cfa
	ld de, $1200 ; $4cfd
	farcall FarPtr_0a_24 ; $4d00
	ld a, $0d ; $4d03
	ld bc, $0f00 ; $4d05
	ld de, $1300 ; $4d08
	farcall FarPtr_0a_24 ; $4d0b
	ld a, $0d ; $4d0e
	farcall FarPtr_0a_20 ; $4d10
	ld d, $25 ; $4d13
	ld a, $10 ; $4d15
	farcall FarPtr_0a_16 ; $4d17
	ld c, l ; $4d1a
	ld b, h ; $4d1b
	farcall FarPtr_04_2c ; $4d1c
	ld a, $10 ; $4d1f
	ld d, $01 ; $4d21
	farcall FarPtr_0a_34 ; $4d23
	ld d, $74 ; $4d26
	ld a, $0d ; $4d28
	farcall FarPtr_0a_16 ; $4d2a
	ld c, l ; $4d2d
	ld b, h ; $4d2e
	farcall FarPtr_04_2c ; $4d2f
	ld a, $0d ; $4d32
	ld d, $01 ; $4d34
	farcall FarPtr_0a_34 ; $4d36
	ld a, $10 ; $4d39
	ld bc, $0f00 ; $4d3b
	ld de, $1300 ; $4d3e
	farcall FarPtr_0a_22 ; $4d41
	ld a, $0d ; $4d44
	ld bc, $0e00 ; $4d46
	ld de, $1300 ; $4d49
	farcall FarPtr_0a_22 ; $4d4c
	ld a, $10 ; $4d4f
	ld b, $80 ; $4d51
	farcall FarPtr_0a_2e ; $4d53
	ld a, $0d ; $4d56
	ld d, $06 ; $4d58
	farcall FarPtr_0a_34 ; $4d5a
	ld a, $10 ; $4d5d
	ld bc, $0e00 ; $4d5f
	ld de, $1300 ; $4d62
	farcall FarPtr_0a_24 ; $4d65
	ld a, $0d ; $4d68
	ld bc, $0d00 ; $4d6a
	ld de, $1300 ; $4d6d
	farcall FarPtr_0a_24 ; $4d70
	ld a, $0d ; $4d73
	farcall FarPtr_0a_20 ; $4d75
	ld a, $10 ; $4d78
	ld b, $01 ; $4d7a
	farcall FarPtr_0a_2c ; $4d7c
	ld a, $10 ; $4d7f
	ld bc, $0f00 ; $4d81
	ld de, $1300 ; $4d84
	farcall FarPtr_0a_24 ; $4d87
	ld a, $10 ; $4d8a
	farcall FarPtr_0a_20 ; $4d8c
	ld a, $10 ; $4d8f
	ld b, $00 ; $4d91
	farcall FarPtr_0a_2c ; $4d93
	ld a, $10 ; $4d96
	ld bc, $0020 ; $4d98
	farcall FarPtr_0a_18 ; $4d9b
	ld a, $10 ; $4d9e
	ld bc, $0f00 ; $4da0
	ld de, $1600 ; $4da3
	farcall FarPtr_0a_24 ; $4da6
	ld a, $10 ; $4da9
	farcall FarPtr_0a_20 ; $4dab
	ld a, $10 ; $4dae
	ld b, $c0 ; $4db0
	farcall FarPtr_0a_2e ; $4db2
	ld a, $0c ; $4db5
	ld bc, $0c00 ; $4db7
	ld de, $1100 ; $4dba
	farcall FarPtr_0a_24 ; $4dbd
	ld a, $0d ; $4dc0
	ld bc, $0c00 ; $4dc2
	ld de, $1000 ; $4dc5
	farcall FarPtr_0a_24 ; $4dc8
	ld a, $0d ; $4dcb
	farcall FarPtr_0a_20 ; $4dcd
	ld a, $0c ; $4dd0
	farcall FarPtr_0a_08 ; $4dd2
	ld a, $14 ; $4dd5
	call DelayFrames ; $4dd7
	ld a, $0c ; $4dda
	ld bc, $0c00 ; $4ddc
	ld de, $0f80 ; $4ddf
	farcall FarPtr_0a_24 ; $4de2
	ld a, $0d ; $4de5
	ld bc, $0c00 ; $4de7
	ld de, $0e40 ; $4dea
	farcall FarPtr_0a_24 ; $4ded
	ld a, $0d ; $4df0
	farcall FarPtr_0a_20 ; $4df2
	ld a, $0c ; $4df5
	ld b, $01 ; $4df7
	farcall FarPtr_0a_2c ; $4df9
	ld a, $0c ; $4dfc
	ld bc, $0c00 ; $4dfe
	ld de, $1100 ; $4e01
	farcall FarPtr_0a_24 ; $4e04
	ld a, $0c ; $4e07
	farcall FarPtr_0a_20 ; $4e09
	ld a, $0c ; $4e0c
	ld b, $00 ; $4e0e
	farcall FarPtr_0a_2c ; $4e10
	ld a, $0c ; $4e13
	ld b, $c0 ; $4e15
	farcall FarPtr_0a_2e ; $4e17
	ld a, $0b ; $4e1a
	ld d, $02 ; $4e1c
	farcall FarPtr_0a_34 ; $4e1e
	ld a, $0b ; $4e21
	farcall FarPtr_0a_36 ; $4e23
	ld a, $16 ; $4e26
	farcall FarPtr_0a_08 ; $4e28
	ld a, $11 ; $4e2b
	ld b, $80 ; $4e2d
	farcall FarPtr_0a_2e ; $4e2f
	ld a, $12 ; $4e32
	ld b, $00 ; $4e34
	farcall FarPtr_0a_2e ; $4e36
	ld a, $3c ; $4e39
	call DelayFrames ; $4e3b
	ld a, [$c90d] ; $4e3e
	ld d, $26 ; $4e41
	add a, d ; $4e43
	ld d, a ; $4e44
	ld a, $16 ; $4e45
	farcall FarPtr_0a_16 ; $4e47
	ld c, l ; $4e4a
	ld b, h ; $4e4b
	farcall FarPtr_04_2c ; $4e4c
	ld a, $16 ; $4e4f
	ld d, $01 ; $4e51
	farcall FarPtr_0a_34 ; $4e53
	ld a, $16 ; $4e56
	ld b, $00 ; $4e58
	farcall FarPtr_0a_2e ; $4e5a
	ld a, $16 ; $4e5d
	ld d, $08 ; $4e5f
	farcall FarPtr_0a_34 ; $4e61
	ld a, $0d ; $4e64
	ld bc, $0b40 ; $4e66
	ld de, $0c40 ; $4e69
	farcall FarPtr_0a_22 ; $4e6c
	xor a, a ; $4e6f
	ld bc, $0c00 ; $4e70
	ld de, $0d00 ; $4e73
	farcall FarPtr_0a_3a ; $4e76
	farcall FarPtr_0a_3e ; $4e79
	ld a, $b4 ; $4e7c
	call DelayFrames ; $4e7e
	ld c, $01 ; $4e81
	call Func_00_1d20 ; $4e83
	call Func_00_1da4 ; $4e86
	ld b, $01 ; $4e89
	ld a, [$c90d] ; $4e8b
	add a, $04 ; $4e8e
	ld c, a ; $4e90
	farcall FarPtr_18_8e ; $4e91
	ld a, $06 ; $4e94
	ld [wStoryModeCurrentLocation], a ; $4e96
	ld a, $0f ; $4e99
	ld [$c295], a ; $4e9b
	ld a, $ff ; $4e9e
	ld [$c294], a ; $4ea0
	ld [$c2a1], a ; $4ea3
	ret ; $4ea6
	INCBIN "data/bank_00f/d_4ea7.bin" ; $4ea7, 42 bytes
	farcall FarPtr_0a_30 ; $4ed1
	ld a, $02 ; $4ed4
	ld b, $c0 ; $4ed6
	farcall FarPtr_0a_2e ; $4ed8
	ld a, $3c ; $4edb
	call DelayFrames ; $4edd
	call Func_0f_5c52 ; $4ee0
	ld a, $00 ; $4ee3
	ld b, $40 ; $4ee5
	farcall FarPtr_0a_2e ; $4ee7
	ld a, $05 ; $4eea
	farcall FarPtr_0a_16 ; $4eec
	ld c, l ; $4eef
	ld b, h ; $4ef0
	ld a, $04 ; $4ef1
	farcall FarPtr_0a_16 ; $4ef3
	ld e, l ; $4ef6
	ld d, h ; $4ef7
	farcall FarPtr_04_20 ; $4ef8
	ld a, $04 ; $4efb
	ld bc, $0c00 ; $4efd
	ld de, $1d00 ; $4f00
	farcall FarPtr_0a_24 ; $4f03
	ld a, $04 ; $4f06
	farcall FarPtr_0a_20 ; $4f08
	ld a, $0a ; $4f0b
	call DelayFrames ; $4f0d
	ld a, $05 ; $4f10
	farcall FarPtr_0a_1c ; $4f12
	call Func_0f_5c96 ; $4f15
	ld a, $03 ; $4f18
	ld b, $c0 ; $4f1a
	farcall FarPtr_0a_2e ; $4f1c
	ld a, $00 ; $4f1f
	ld bc, $0020 ; $4f21
	farcall FarPtr_0a_18 ; $4f24
	ld a, $02 ; $4f27
	ld bc, $0020 ; $4f29
	farcall FarPtr_0a_18 ; $4f2c
	ld a, $04 ; $4f2f
	ld bc, $0020 ; $4f31
	farcall FarPtr_0a_18 ; $4f34
	ld a, $05 ; $4f37
	ld bc, $0020 ; $4f39
	farcall FarPtr_0a_18 ; $4f3c
	ldh a, [hRomBank] ; $4f3f
	ld b, a ; $4f41
	ld a, $00 ; $4f42
	ld de, $5665 ; $4f44
	farcall FarPtr_0a_1a ; $4f47
	ldh a, [hRomBank] ; $4f4a
	ld b, a ; $4f4c
	ld a, $02 ; $4f4d
	ld de, $5665 ; $4f4f
	farcall FarPtr_0a_1a ; $4f52
	ldh a, [hRomBank] ; $4f55
	ld b, a ; $4f57
	ld a, $04 ; $4f58
	ld de, $5665 ; $4f5a
	farcall FarPtr_0a_1a ; $4f5d
	ldh a, [hRomBank] ; $4f60
	ld b, a ; $4f62
	ld a, $05 ; $4f63
	ld de, $5665 ; $4f65
	farcall FarPtr_0a_1a ; $4f68
	ld a, $b4 ; $4f6b
	call DelayFrames ; $4f6d
	call Func_0f_5641 ; $4f70
	ld a, $16 ; $4f73
	ld bc, $0d00 ; $4f75
	ld de, $0d60 ; $4f78
	farcall FarPtr_0a_22 ; $4f7b
	ld a, [$c94d] ; $4f7e
	ld d, $58 ; $4f81
	add a, d ; $4f83
	ld d, a ; $4f84
	ld a, $11 ; $4f85
	farcall FarPtr_0a_16 ; $4f87
	ld c, l ; $4f8a
	ld b, h ; $4f8b
	farcall FarPtr_04_2c ; $4f8c
	ld a, $11 ; $4f8f
	ld d, $01 ; $4f91
	farcall FarPtr_0a_34 ; $4f93
	ld a, $02 ; $4f96
	ld bc, $3f00 ; $4f98
	ld de, $3f00 ; $4f9b
	farcall FarPtr_0a_22 ; $4f9e
	ld a, $11 ; $4fa1
	ld bc, $0f00 ; $4fa3
	ld de, $0d60 ; $4fa6
	farcall FarPtr_0a_22 ; $4fa9
	ld d, $61 ; $4fac
	ld a, $13 ; $4fae
	farcall FarPtr_0a_16 ; $4fb0
	ld c, l ; $4fb3
	ld b, h ; $4fb4
	farcall FarPtr_04_2c ; $4fb5
	ld a, $13 ; $4fb8
	ld d, $01 ; $4fba
	farcall FarPtr_0a_34 ; $4fbc
	ld d, $62 ; $4fbf
	ld a, $15 ; $4fc1
	farcall FarPtr_0a_16 ; $4fc3
	ld c, l ; $4fc6
	ld b, h ; $4fc7
	farcall FarPtr_04_2c ; $4fc8
	ld a, $15 ; $4fcb
	ld d, $01 ; $4fcd
	farcall FarPtr_0a_34 ; $4fcf
	ld a, $04 ; $4fd2
	ld bc, $3f00 ; $4fd4
	ld de, $3f00 ; $4fd7
	farcall FarPtr_0a_22 ; $4fda
	ld a, $05 ; $4fdd
	ld bc, $3f00 ; $4fdf
	ld de, $3f00 ; $4fe2
	farcall FarPtr_0a_22 ; $4fe5
	ld a, $13 ; $4fe8
	ld bc, $0b00 ; $4fea
	ld de, $0e00 ; $4fed
	farcall FarPtr_0a_22 ; $4ff0
	ld a, $15 ; $4ff3
	ld bc, $0900 ; $4ff5
	ld de, $0e00 ; $4ff8
	farcall FarPtr_0a_22 ; $4ffb
	ld d, $4e ; $4ffe
	ld a, $04 ; $5000
	farcall FarPtr_0a_16 ; $5002
	ld c, l ; $5005
	ld b, h ; $5006
	farcall FarPtr_04_2c ; $5007
	ld a, $04 ; $500a
	ld d, $01 ; $500c
	farcall FarPtr_0a_34 ; $500e
	ld d, $4d ; $5011
	ld a, $05 ; $5013
	farcall FarPtr_0a_16 ; $5015
	ld c, l ; $5018
	ld b, h ; $5019
	farcall FarPtr_04_2c ; $501a
	ld a, $05 ; $501d
	ld d, $01 ; $501f
	farcall FarPtr_0a_34 ; $5021
	ld a, $16 ; $5024
	ld b, $40 ; $5026
	farcall FarPtr_0a_2e ; $5028
	ld a, $11 ; $502b
	ld b, $40 ; $502d
	farcall FarPtr_0a_2e ; $502f
	ld a, $13 ; $5032
	ld b, $40 ; $5034
	farcall FarPtr_0a_2e ; $5036
	ld a, $15 ; $5039
	ld b, $40 ; $503b
	farcall FarPtr_0a_2e ; $503d
	ld bc, $0006 ; $5040
	farcall FarPtr_0a_38 ; $5043
	xor a, a ; $5046
	ld bc, $0c00 ; $5047
	ld de, $1300 ; $504a
	farcall FarPtr_0a_3a ; $504d
	farcall FarPtr_0a_3e ; $5050
	call Func_0f_5ccf ; $5053
	ld a, $0c ; $5056
	ld bc, $0a00 ; $5058
	ld de, $1300 ; $505b
	farcall FarPtr_0a_24 ; $505e
	ld a, $0c ; $5061
	farcall FarPtr_0a_20 ; $5063
	ld a, $0c ; $5066
	ld b, $c0 ; $5068
	farcall FarPtr_0a_2e ; $506a
	ld a, $10 ; $506d
	ld bc, $0010 ; $506f
	farcall FarPtr_0a_18 ; $5072
	ld a, $09 ; $5075
	ld bc, $0010 ; $5077
	farcall FarPtr_0a_18 ; $507a
	ld a, $0f ; $507d
	ld bc, $0010 ; $507f
	farcall FarPtr_0a_18 ; $5082
	ld a, $10 ; $5085
	ld bc, $1100 ; $5087
	ld de, $1600 ; $508a
	farcall FarPtr_0a_24 ; $508d
	ld a, $10 ; $5090
	farcall FarPtr_0a_20 ; $5092
	ld a, $10 ; $5095
	ld b, $40 ; $5097
	farcall FarPtr_0a_2e ; $5099
	ld a, $14 ; $509c
	call DelayFrames ; $509e
	ld a, $0e ; $50a1
	ld bc, $3f00 ; $50a3
	ld de, $3f00 ; $50a6
	farcall FarPtr_0a_22 ; $50a9
	ld a, $0f ; $50ac
	ld bc, $1100 ; $50ae
	ld de, $1600 ; $50b1
	farcall FarPtr_0a_22 ; $50b4
	ld a, $14 ; $50b7
	call DelayFrames ; $50b9
	ld d, $25 ; $50bc
	ld a, $09 ; $50be
	farcall FarPtr_0a_16 ; $50c0
	ld c, l ; $50c3
	ld b, h ; $50c4
	farcall FarPtr_04_2c ; $50c5
	ld a, $09 ; $50c8
	ld d, $01 ; $50ca
	farcall FarPtr_0a_34 ; $50cc
	ld a, $10 ; $50cf
	ld bc, $3f00 ; $50d1
	ld de, $3f00 ; $50d4
	farcall FarPtr_0a_22 ; $50d7
	ld a, $09 ; $50da
	ld bc, $1100 ; $50dc
	ld de, $1600 ; $50df
	farcall FarPtr_0a_22 ; $50e2
	ld a, $0f ; $50e5
	ld bc, $1100 ; $50e7
	ld de, $1500 ; $50ea
	farcall FarPtr_0a_22 ; $50ed
	ld a, $09 ; $50f0
	ld b, $c0 ; $50f2
	farcall FarPtr_0a_2e ; $50f4
	ld a, $0f ; $50f7
	ld d, $08 ; $50f9
	farcall FarPtr_0a_34 ; $50fb
	ld a, $0f ; $50fe
	ld bc, $1100 ; $5100
	ld de, $1200 ; $5103
	farcall FarPtr_0a_24 ; $5106
	ld a, $09 ; $5109
	ld bc, $1100 ; $510b
	ld de, $1300 ; $510e
	farcall FarPtr_0a_24 ; $5111
	ld a, $09 ; $5114
	farcall FarPtr_0a_20 ; $5116
	ld a, $09 ; $5119
	ld bc, $3f00 ; $511b
	ld de, $3f00 ; $511e
	farcall FarPtr_0a_22 ; $5121
	ld a, $10 ; $5124
	ld bc, $1100 ; $5126
	ld de, $1300 ; $5129
	farcall FarPtr_0a_22 ; $512c
	ld a, $0f ; $512f
	ld bc, $1000 ; $5131
	ld de, $1300 ; $5134
	farcall FarPtr_0a_22 ; $5137
	ld a, $10 ; $513a
	ld b, $80 ; $513c
	farcall FarPtr_0a_2e ; $513e
	ld a, $10 ; $5141
	ld bc, $0c00 ; $5143
	ld de, $1300 ; $5146
	farcall FarPtr_0a_24 ; $5149
	ld a, $0f ; $514c
	ld bc, $0b00 ; $514e
	ld de, $1300 ; $5151
	farcall FarPtr_0a_24 ; $5154
	ld a, $0f ; $5157
	farcall FarPtr_0a_20 ; $5159
	ld a, $10 ; $515c
	ld b, $01 ; $515e
	farcall FarPtr_0a_2c ; $5160
	ld a, $10 ; $5163
	ld bc, $0f00 ; $5165
	ld de, $1300 ; $5168
	farcall FarPtr_0a_24 ; $516b
	ld a, $10 ; $516e
	farcall FarPtr_0a_20 ; $5170
	ld a, $10 ; $5173
	ld b, $00 ; $5175
	farcall FarPtr_0a_2c ; $5177
	ld a, $10 ; $517a
	ld bc, $1100 ; $517c
	ld de, $1600 ; $517f
	farcall FarPtr_0a_24 ; $5182
	ld a, $10 ; $5185
	farcall FarPtr_0a_20 ; $5187
	ld a, $10 ; $518a
	ld b, $c0 ; $518c
	farcall FarPtr_0a_2e ; $518e
	ld hl, $28b9 ; $5191
	farcall FarPtr_0a_0e ; $5194
	ld a, $0c ; $5197
	ld bc, $0010 ; $5199
	farcall FarPtr_0a_18 ; $519c
	ld a, $0c ; $519f
	ld bc, $0a00 ; $51a1
	ld de, $1100 ; $51a4
	farcall FarPtr_0a_24 ; $51a7
	ld a, $0f ; $51aa
	ld bc, $0a00 ; $51ac
	ld de, $1000 ; $51af
	farcall FarPtr_0a_24 ; $51b2
	ld a, $0f ; $51b5
	farcall FarPtr_0a_20 ; $51b7
	ld a, $1e ; $51ba
	call DelayFrames ; $51bc
	ld a, $0c ; $51bf
	farcall FarPtr_0a_08 ; $51c1
	ld a, $1e ; $51c4
	call DelayFrames ; $51c6
	ld a, $0c ; $51c9
	ld bc, $0a00 ; $51cb
	ld de, $1000 ; $51ce
	farcall FarPtr_0a_24 ; $51d1
	ld a, $0f ; $51d4
	ld bc, $0a00 ; $51d6
	ld de, $0f00 ; $51d9
	farcall FarPtr_0a_24 ; $51dc
	ld a, $0f ; $51df
	farcall FarPtr_0a_20 ; $51e1
	ld a, $05 ; $51e4
	call DelayFrames ; $51e6
	ld a, $13 ; $51e9
	ld d, $02 ; $51eb
	farcall FarPtr_0a_34 ; $51ed
	ld a, $13 ; $51f0
	farcall FarPtr_0a_36 ; $51f2
	ld a, $0c ; $51f5
	ld b, $01 ; $51f7
	farcall FarPtr_0a_2c ; $51f9
	ld a, $0c ; $51fc
	ld bc, $0a00 ; $51fe
	ld de, $1100 ; $5201
	farcall FarPtr_0a_24 ; $5204
	ld a, $0c ; $5207
	farcall FarPtr_0a_20 ; $5209
	ld a, $0c ; $520c
	ld b, $00 ; $520e
	farcall FarPtr_0a_2c ; $5210
	ld a, $0c ; $5213
	ld b, $c0 ; $5215
	farcall FarPtr_0a_2e ; $5217
	ld a, $32 ; $521a
	call DelayFrames ; $521c
	ld a, $0f ; $521f
	ld bc, $3f00 ; $5221
	ld de, $3f00 ; $5224
	farcall FarPtr_0a_22 ; $5227
	ld a, $04 ; $522a
	ld bc, $0c80 ; $522c
	ld de, $0c80 ; $522f
	farcall FarPtr_0a_22 ; $5232
	sound $99 ; $5235
	ld a, $50 ; $5237
	call DelayFrames ; $5239
	ld a, $04 ; $523c
	ld bc, $3f00 ; $523e
	ld de, $3f00 ; $5241
	farcall FarPtr_0a_22 ; $5244
	ld a, $13 ; $5247
	farcall FarPtr_0a_08 ; $5249
	ld a, $15 ; $524c
	ld d, $02 ; $524e
	farcall FarPtr_0a_34 ; $5250
	ld a, $15 ; $5253
	farcall FarPtr_0a_36 ; $5255
	ld a, $15 ; $5258
	farcall FarPtr_0a_08 ; $525a
	ld a, $05 ; $525d
	ld bc, $0b80 ; $525f
	ld de, $0f80 ; $5262
	farcall FarPtr_0a_22 ; $5265
	sound $98 ; $5268
	ld a, $78 ; $526a
	call DelayFrames ; $526c
	ld a, $05 ; $526f
	ld bc, $3f00 ; $5271
	ld de, $3f00 ; $5274
	farcall FarPtr_0a_22 ; $5277
	ld a, $13 ; $527a
	ld d, $04 ; $527c
	farcall FarPtr_0a_34 ; $527e
	ld a, $13 ; $5281
	farcall FarPtr_0a_36 ; $5283
	ld a, $13 ; $5286
	farcall FarPtr_0a_08 ; $5288
	ld a, $16 ; $528b
	ld d, $02 ; $528d
	farcall FarPtr_0a_34 ; $528f
	ld a, $11 ; $5292
	ld d, $02 ; $5294
	farcall FarPtr_0a_34 ; $5296
	ld a, $11 ; $5299
	farcall FarPtr_0a_36 ; $529b
	ld a, $16 ; $529e
	ld b, $80 ; $52a0
	farcall FarPtr_0a_2e ; $52a2
	ld a, $11 ; $52a5
	ld b, $80 ; $52a7
	farcall FarPtr_0a_2e ; $52a9
	ld a, $3c ; $52ac
	call DelayFrames ; $52ae
	ld a, $16 ; $52b1
	ld b, $40 ; $52b3
	farcall FarPtr_0a_2e ; $52b5
	ld a, $11 ; $52b8
	ld b, $40 ; $52ba
	farcall FarPtr_0a_2e ; $52bc
	ld a, $15 ; $52bf
	ld d, $02 ; $52c1
	farcall FarPtr_0a_34 ; $52c3
	ld a, $15 ; $52c6
	farcall FarPtr_0a_36 ; $52c8
	ld a, $15 ; $52cb
	farcall FarPtr_0a_08 ; $52cd
	ld a, $0c ; $52d0
	ld d, $03 ; $52d2
	farcall FarPtr_0a_34 ; $52d4
	ld a, $0c ; $52d7
	farcall FarPtr_0a_36 ; $52d9
	ld a, $0c ; $52dc
	farcall FarPtr_0a_08 ; $52de
	ld a, $1e ; $52e1
	call DelayFrames ; $52e3
	ld a, $0c ; $52e6
	ld bc, $0a00 ; $52e8
	ld de, $1300 ; $52eb
	farcall FarPtr_0a_24 ; $52ee
	ld a, $0c ; $52f1
	farcall FarPtr_0a_20 ; $52f3
	ld a, $0c ; $52f6
	ld bc, $0e00 ; $52f8
	ld de, $1300 ; $52fb
	farcall FarPtr_0a_24 ; $52fe
	ld a, $0c ; $5301
	farcall FarPtr_0a_20 ; $5303
	ld a, $0c ; $5306
	ld b, $c0 ; $5308
	farcall FarPtr_0a_2e ; $530a
	ld a, $14 ; $530d
	call DelayFrames ; $530f
	ld a, $0d ; $5312
	ld bc, $0010 ; $5314
	farcall FarPtr_0a_18 ; $5317
	ld a, $10 ; $531a
	ld bc, $0f00 ; $531c
	ld de, $1600 ; $531f
	farcall FarPtr_0a_24 ; $5322
	ld a, $10 ; $5325
	farcall FarPtr_0a_20 ; $5327
	ld a, $10 ; $532a
	ld b, $40 ; $532c
	farcall FarPtr_0a_2e ; $532e
	ld a, $14 ; $5331
	call DelayFrames ; $5333
	ld a, $0d ; $5336
	ld bc, $0f80 ; $5338
	ld de, $1600 ; $533b
	farcall FarPtr_0a_22 ; $533e
	ld a, $14 ; $5341
	call DelayFrames ; $5343
	ld a, $10 ; $5346
	ld bc, $3f00 ; $5348
	ld de, $3f00 ; $534b
	farcall FarPtr_0a_22 ; $534e
	ld a, $09 ; $5351
	ld bc, $0f00 ; $5353
	ld de, $1600 ; $5356
	farcall FarPtr_0a_22 ; $5359
	ld a, $0d ; $535c
	ld bc, $0f00 ; $535e
	ld de, $1500 ; $5361
	farcall FarPtr_0a_22 ; $5364
	ld a, $09 ; $5367
	ld b, $c0 ; $5369
	farcall FarPtr_0a_2e ; $536b
	ld a, $0d ; $536e
	ld d, $08 ; $5370
	farcall FarPtr_0a_34 ; $5372
	ld a, $0d ; $5375
	ld bc, $0f00 ; $5377
	ld de, $1300 ; $537a
	farcall FarPtr_0a_24 ; $537d
	ld a, $09 ; $5380
	ld bc, $0f00 ; $5382
	ld de, $1400 ; $5385
	farcall FarPtr_0a_24 ; $5388
	ld a, $09 ; $538b
	farcall FarPtr_0a_20 ; $538d
	ld a, $09 ; $5390
	ld bc, $3f00 ; $5392
	ld de, $3f00 ; $5395
	farcall FarPtr_0a_22 ; $5398
	ld a, $10 ; $539b
	ld bc, $0f00 ; $539d
	ld de, $1400 ; $53a0
	farcall FarPtr_0a_22 ; $53a3
	ld a, $10 ; $53a6
	ld b, $c0 ; $53a8
	farcall FarPtr_0a_2e ; $53aa
	ld a, $10 ; $53ad
	ld b, $01 ; $53af
	farcall FarPtr_0a_2c ; $53b1
	ld a, $10 ; $53b4
	ld bc, $0f00 ; $53b6
	ld de, $1600 ; $53b9
	farcall FarPtr_0a_24 ; $53bc
	ld a, $10 ; $53bf
	farcall FarPtr_0a_20 ; $53c1
	ld a, $10 ; $53c4
	ld b, $00 ; $53c6
	farcall FarPtr_0a_2c ; $53c8
	ld a, $10 ; $53cb
	ld b, $c0 ; $53cd
	farcall FarPtr_0a_2e ; $53cf
	ld a, $0d ; $53d2
	ld bc, $0ec0 ; $53d4
	ld de, $1300 ; $53d7
	farcall FarPtr_0a_22 ; $53da
	ld a, $0c ; $53dd
	ld bc, $0f00 ; $53df
	ld de, $1300 ; $53e2
	farcall FarPtr_0a_24 ; $53e5
	ld a, $0d ; $53e8
	ld bc, $0fc0 ; $53ea
	ld de, $1300 ; $53ed
	farcall FarPtr_0a_24 ; $53f0
	ld a, $0d ; $53f3
	farcall FarPtr_0a_20 ; $53f5
	ld a, $0c ; $53f8
	ld bc, $0f00 ; $53fa
	ld de, $1100 ; $53fd
	farcall FarPtr_0a_24 ; $5400
	ld a, $0d ; $5403
	ld bc, $0fc0 ; $5405
	ld de, $1100 ; $5408
	farcall FarPtr_0a_24 ; $540b
	ld a, $0d ; $540e
	farcall FarPtr_0a_20 ; $5410
	ld a, $1e ; $5413
	call DelayFrames ; $5415
	ld a, $0c ; $5418
	farcall FarPtr_0a_08 ; $541a
	ld a, $0a ; $541d
	call DelayFrames ; $541f
	ld a, $11 ; $5422
	ld d, $03 ; $5424
	farcall FarPtr_0a_34 ; $5426
	ld a, $11 ; $5429
	farcall FarPtr_0a_36 ; $542b
	ld a, $11 ; $542e
	farcall FarPtr_0a_08 ; $5430
	ld a, $14 ; $5433
	call DelayFrames ; $5435
	ld a, $0d ; $5438
	ld bc, $0e40 ; $543a
	ld de, $1100 ; $543d
	farcall FarPtr_0a_22 ; $5440
	ld a, $0c ; $5443
	ld bc, $0d00 ; $5445
	ld de, $1100 ; $5448
	farcall FarPtr_0a_24 ; $544b
	ld a, $0d ; $544e
	ld bc, $0c40 ; $5450
	ld de, $1100 ; $5453
	farcall FarPtr_0a_24 ; $5456
	ld a, $0d ; $5459
	farcall FarPtr_0a_20 ; $545b
	ld a, $04 ; $545e
	call DelayFrames ; $5460
	ld a, $0c ; $5463
	ld b, $c0 ; $5465
	farcall FarPtr_0a_2e ; $5467
	ld a, $0d ; $546a
	ld bc, $0d00 ; $546c
	ld de, $1000 ; $546f
	farcall FarPtr_0a_24 ; $5472
	ld a, $0d ; $5475
	farcall FarPtr_0a_20 ; $5477
	ld a, $14 ; $547a
	call DelayFrames ; $547c
	ld a, $0c ; $547f
	farcall FarPtr_0a_08 ; $5481
	ld a, $1e ; $5484
	call DelayFrames ; $5486
	ld a, $0c ; $5489
	ld bc, $0d00 ; $548b
	ld de, $1000 ; $548e
	farcall FarPtr_0a_24 ; $5491
	ld a, $0d ; $5494
	ld bc, $0d00 ; $5496
	ld de, $0e80 ; $5499
	farcall FarPtr_0a_24 ; $549c
	ld a, $0d ; $549f
	farcall FarPtr_0a_20 ; $54a1
	ld a, $05 ; $54a4
	call DelayFrames ; $54a6
	ld a, $0c ; $54a9
	ld b, $01 ; $54ab
	farcall FarPtr_0a_2c ; $54ad
	ld a, $0c ; $54b0
	ld bc, $0d00 ; $54b2
	ld de, $1100 ; $54b5
	farcall FarPtr_0a_24 ; $54b8
	ld a, $0c ; $54bb
	farcall FarPtr_0a_20 ; $54bd
	ld a, $0c ; $54c0
	ld b, $00 ; $54c2
	farcall FarPtr_0a_2c ; $54c4
	ld a, $0c ; $54c7
	ld b, $c0 ; $54c9
	farcall FarPtr_0a_2e ; $54cb
	ld a, $0b ; $54ce
	ld d, $02 ; $54d0
	farcall FarPtr_0a_34 ; $54d2
	ld a, $0b ; $54d5
	farcall FarPtr_0a_36 ; $54d7
	ld a, $16 ; $54da
	farcall FarPtr_0a_08 ; $54dc
	ld a, $16 ; $54df
	ld d, $03 ; $54e1
	farcall FarPtr_0a_34 ; $54e3
	ld a, $11 ; $54e6
	ld d, $03 ; $54e8
	farcall FarPtr_0a_34 ; $54ea
	ld a, $11 ; $54ed
	farcall FarPtr_0a_36 ; $54ef
	ld a, $16 ; $54f2
	farcall FarPtr_0a_08 ; $54f4
	ld a, $11 ; $54f7
	ld b, $80 ; $54f9
	farcall FarPtr_0a_2e ; $54fb
	ld a, $13 ; $54fe
	ld b, $00 ; $5500
	farcall FarPtr_0a_2e ; $5502
	ld a, $15 ; $5505
	ld b, $00 ; $5507
	farcall FarPtr_0a_2e ; $5509
	ld a, $3c ; $550c
	call DelayFrames ; $550e
	ld a, [$c90d] ; $5511
	ld d, $26 ; $5514
	add a, d ; $5516
	ld d, a ; $5517
	ld a, $16 ; $5518
	farcall FarPtr_0a_16 ; $551a
	ld c, l ; $551d
	ld b, h ; $551e
	farcall FarPtr_04_2c ; $551f
	ld a, $16 ; $5522
	ld d, $01 ; $5524
	farcall FarPtr_0a_34 ; $5526
	ld a, $16 ; $5529
	ld b, $00 ; $552b
	farcall FarPtr_0a_2e ; $552d
	ld a, $16 ; $5530
	ld d, $08 ; $5532
	farcall FarPtr_0a_34 ; $5534
	ld a, $0d ; $5537
	ld bc, $0c40 ; $5539
	ld de, $0c60 ; $553c
	farcall FarPtr_0a_22 ; $553f
	xor a, a ; $5542
	ld bc, $0c00 ; $5543
	ld de, $0d00 ; $5546
	farcall FarPtr_0a_3a ; $5549
	farcall FarPtr_0a_3e ; $554c
	ld a, $b4 ; $554f
	call DelayFrames ; $5551
	ld c, $01 ; $5554
	call Func_00_1d20 ; $5556
	call Func_00_1da4 ; $5559
	ld b, $01 ; $555c
	ld a, [$c90d] ; $555e
	ld d, a ; $5561
	sla a ; $5562
	ld c, a ; $5564
	ld a, [$c94d] ; $5565
	xor a, d ; $5568
	or a, c ; $5569
	ld c, a ; $556a
	farcall FarPtr_18_8e ; $556b
	ld a, $06 ; $556e
	ld [wStoryModeCurrentLocation], a ; $5570
	ld a, $0f ; $5573
	ld [$c295], a ; $5575
	ld a, $ff ; $5578
	ld [$c294], a ; $557a
	ld [$c2a1], a ; $557d
	ret ; $5580
	INCBIN "data/bank_00f/d_5581.bin" ; $5581, 192 bytes
Func_0f_5641:
	ld a, [$c90d] ; $5641
	ld d, $56 ; $5644
	add a, d ; $5646
	ld d, a ; $5647
	ld a, $16 ; $5648
	farcall FarPtr_0a_16 ; $564a
	ld c, l ; $564d
	ld b, h ; $564e
	farcall FarPtr_04_2c ; $564f
	ld a, $16 ; $5652
	ld d, $01 ; $5654
	farcall FarPtr_0a_34 ; $5656
	ld a, $00 ; $5659
	ld bc, $3f00 ; $565b
	ld de, $3f00 ; $565e
	farcall FarPtr_0a_22 ; $5661
	ret ; $5664
	INCBIN "data/bank_00f/d_5665.bin" ; $5665, 19 bytes
DelayFrames:
	push af ; $5678
	ld a, a ; $5679
	farcall FarPtr_0a_04 ; $567a
	pop af ; $567d
	ret ; $567e
Func_0f_567f:
	ld a, $08 ; $567f
	ld de, $ff80 ; $5681
	farcall FarPtr_0a_42 ; $5684
	ld a, $08 ; $5687
	farcall FarPtr_0a_44 ; $5689
	sound $83 ; $568c
	ld a, $02 ; $568e
	farcall FarPtr_0a_40 ; $5690
	ld a, $08 ; $5693
	call DelayFrames ; $5695
	ld a, $01 ; $5698
	farcall FarPtr_0a_40 ; $569a
	ld a, $08 ; $569d
	call DelayFrames ; $569f
	ld a, $00 ; $56a2
	farcall FarPtr_0a_40 ; $56a4
	ret ; $56a7
	INCBIN "data/bank_00f/d_56a8.bin" ; $56a8, 1048 bytes
	farcall FarPtr_0a_36 ; $5ac0
	ld a, $02 ; $5ac3
	ld d, $03 ; $5ac5
	farcall FarPtr_0a_34 ; $5ac7
	ld a, $02 ; $5aca
	farcall FarPtr_0a_36 ; $5acc
	call Func_0f_5aec ; $5acf
	ld a, $00 ; $5ad2
	ld d, $03 ; $5ad4
	farcall FarPtr_0a_34 ; $5ad6
	ld a, $00 ; $5ad9
	farcall FarPtr_0a_36 ; $5adb
	ld a, $02 ; $5ade
	farcall FarPtr_0a_16 ; $5ae0
	ld c, l ; $5ae3
	ld b, h ; $5ae4
	ld de, $d000 ; $5ae5
	farcall FarPtr_04_20 ; $5ae8
	ret ; $5aeb
Func_0f_5aec:
	ld a, [$c94d] ; $5aec
	and a, a ; $5aef
	jr nz, Label_0f_5afb ; $5af0
	ld a, $02 ; $5af2
	farcall FarPtr_0a_08 ; $5af4
	farcall FarPtr_0a_10 ; $5af7
	ret ; $5afa
Label_0f_5afb:
	farcall FarPtr_0a_10 ; $5afb
	ld a, $02 ; $5afe
	farcall FarPtr_0a_08 ; $5b00
	ret ; $5b03
	INCBIN "data/bank_00f/d_5b04.bin" ; $5b04, 308 bytes
	farcall FarPtr_0a_34 ; $5c38
	ld a, $13 ; $5c3b
	ld bc, $3f00 ; $5c3d
	ld de, $3f00 ; $5c40
	farcall FarPtr_0a_22 ; $5c43
	ld a, $14 ; $5c46
	ld bc, $3f00 ; $5c48
	ld de, $3f00 ; $5c4b
	farcall FarPtr_0a_22 ; $5c4e
	ret ; $5c51
Func_0f_5c52:
	ld a, $0c ; $5c52
	ld b, a ; $5c54
	ld a, $0b ; $5c55
	farcall FarPtr_0a_32 ; $5c57
	ld a, $1e ; $5c5a
	call DelayFrames ; $5c5c
	ld a, $0b ; $5c5f
	ld d, $03 ; $5c61
	farcall FarPtr_0a_34 ; $5c63
	ld a, $0b ; $5c66
	farcall FarPtr_0a_36 ; $5c68
	ld a, $0c ; $5c6b
	ld d, $03 ; $5c6d
	farcall FarPtr_0a_34 ; $5c6f
	ld a, $0c ; $5c72
	farcall FarPtr_0a_36 ; $5c74
	ld a, $1e ; $5c77
	call DelayFrames ; $5c79
	ld a, $0b ; $5c7c
	ld b, $00 ; $5c7e
	farcall FarPtr_0a_2e ; $5c80
	ld a, $0c ; $5c83
	ld b, $00 ; $5c85
	farcall FarPtr_0a_2e ; $5c87
	ld hl, $2885 ; $5c8a
	farcall FarPtr_0a_0e ; $5c8d
	ld a, $0b ; $5c90
	farcall FarPtr_0a_08 ; $5c92
	ret ; $5c95
Func_0f_5c96:
	ld a, $05 ; $5c96
	ld b, $c0 ; $5c98
	farcall FarPtr_0a_2e ; $5c9a
	ld a, $08 ; $5c9d
	ld b, $c0 ; $5c9f
	farcall FarPtr_0a_2e ; $5ca1
	ld a, $09 ; $5ca4
	ld b, $c0 ; $5ca6
	farcall FarPtr_0a_2e ; $5ca8
	ld a, $0a ; $5cab
	ld b, $c0 ; $5cad
	farcall FarPtr_0a_2e ; $5caf
	ld a, $06 ; $5cb2
	ld b, $c0 ; $5cb4
	farcall FarPtr_0a_2e ; $5cb6
	ld a, $12 ; $5cb9
	ld b, $c0 ; $5cbb
	farcall FarPtr_0a_2e ; $5cbd
	ld a, $07 ; $5cc0
	ld b, $c0 ; $5cc2
	farcall FarPtr_0a_2e ; $5cc4
	ld a, $11 ; $5cc7
	ld b, $c0 ; $5cc9
	farcall FarPtr_0a_2e ; $5ccb
	ret ; $5cce
Func_0f_5ccf:
	ld a, $1e ; $5ccf
	call DelayFrames ; $5cd1
	ld a, $0b ; $5cd4
	farcall FarPtr_0a_08 ; $5cd6
	ld a, $0b ; $5cd9
	ld d, $03 ; $5cdb
	farcall FarPtr_0a_34 ; $5cdd
	ld a, $0b ; $5ce0
	farcall FarPtr_0a_36 ; $5ce2
	ld a, $0b ; $5ce5
	ld b, $c0 ; $5ce7
	farcall FarPtr_0a_2e ; $5ce9
	ld a, $1e ; $5cec
	call DelayFrames ; $5cee
	ld a, $0b ; $5cf1
	ld b, $01 ; $5cf3
	farcall FarPtr_0a_2c ; $5cf5
	ld a, $0b ; $5cf8
	ld bc, $0700 ; $5cfa
	ld de, $1b00 ; $5cfd
	farcall FarPtr_0a_24 ; $5d00
	ld a, $0b ; $5d03
	farcall FarPtr_0a_20 ; $5d05
	ld a, $0b ; $5d08
	ld b, $00 ; $5d0a
	farcall FarPtr_0a_2c ; $5d0c
	ld a, $0b ; $5d0f
	ld b, $00 ; $5d11
	farcall FarPtr_0a_2e ; $5d13
	ld a, $0c ; $5d16
	ld bc, $0800 ; $5d18
	ld de, $1900 ; $5d1b
	farcall FarPtr_0a_24 ; $5d1e
	ld a, $0c ; $5d21
	farcall FarPtr_0a_20 ; $5d23
	ld a, $0c ; $5d26
	ld b, $00 ; $5d28
	farcall FarPtr_0a_2e ; $5d2a
	ld a, $1e ; $5d2d
	call DelayFrames ; $5d2f
	ld a, $0c ; $5d32
	ld d, $03 ; $5d34
	farcall FarPtr_0a_34 ; $5d36
	ld a, $0c ; $5d39
	farcall FarPtr_0a_36 ; $5d3b
	ld a, $0c ; $5d3e
	farcall FarPtr_0a_08 ; $5d40
	ld a, $0c ; $5d43
	ld d, $04 ; $5d45
	farcall FarPtr_0a_34 ; $5d47
	ld a, $0c ; $5d4a
	farcall FarPtr_0a_36 ; $5d4c
	ld a, $0c ; $5d4f
	farcall FarPtr_0a_08 ; $5d51
	ld a, $0c ; $5d54
	ld d, $02 ; $5d56
	farcall FarPtr_0a_34 ; $5d58
	ld a, $0c ; $5d5b
	farcall FarPtr_0a_36 ; $5d5d
	ld a, $0c ; $5d60
	farcall FarPtr_0a_08 ; $5d62
	ld a, $0c ; $5d65
	ld d, $04 ; $5d67
	farcall FarPtr_0a_34 ; $5d69
	ld a, $0c ; $5d6c
	farcall FarPtr_0a_36 ; $5d6e
	ld a, $0c ; $5d71
	farcall FarPtr_0a_08 ; $5d73
	ld a, $0c ; $5d76
	ld d, $03 ; $5d78
	farcall FarPtr_0a_34 ; $5d7a
	ld a, $0c ; $5d7d
	farcall FarPtr_0a_36 ; $5d7f
	ld a, $0c ; $5d82
	farcall FarPtr_0a_08 ; $5d84
	ld a, $0c ; $5d87
	ld d, $03 ; $5d89
	farcall FarPtr_0a_34 ; $5d8b
	ld a, $0c ; $5d8e
	farcall FarPtr_0a_36 ; $5d90
	ld a, $3c ; $5d93
	call DelayFrames ; $5d95
	ld a, $0c ; $5d98
	ld bc, $0800 ; $5d9a
	ld de, $1700 ; $5d9d
	farcall FarPtr_0a_24 ; $5da0
	ld a, $0c ; $5da3
	farcall FarPtr_0a_20 ; $5da5
	ld a, $0c ; $5da8
	ld b, $00 ; $5daa
	farcall FarPtr_0a_2e ; $5dac
	ld a, $0b ; $5daf
	ld bc, $0800 ; $5db1
	ld de, $1900 ; $5db4
	farcall FarPtr_0a_24 ; $5db7
	ld a, $0b ; $5dba
	farcall FarPtr_0a_20 ; $5dbc
	ld a, $0b ; $5dbf
	ld b, $00 ; $5dc1
	farcall FarPtr_0a_2e ; $5dc3
	ld a, $1e ; $5dc6
	call DelayFrames ; $5dc8
	ld a, $0b ; $5dcb
	farcall FarPtr_0a_08 ; $5dcd
	ld d, $30 ; $5dd0
	ld a, $07 ; $5dd2
	farcall FarPtr_0a_16 ; $5dd4
	ld c, l ; $5dd7
	ld b, h ; $5dd8
	farcall FarPtr_04_2c ; $5dd9
	ld a, $07 ; $5ddc
	ld d, $01 ; $5dde
	farcall FarPtr_0a_34 ; $5de0
	ld d, $3a ; $5de3
	ld a, $14 ; $5de5
	farcall FarPtr_0a_16 ; $5de7
	ld c, l ; $5dea
	ld b, h ; $5deb
	farcall FarPtr_04_2c ; $5dec
	ld a, $14 ; $5def
	ld d, $01 ; $5df1
	farcall FarPtr_0a_34 ; $5df3
	ld a, $07 ; $5df6
	ld bc, $0700 ; $5df8
	ld de, $0500 ; $5dfb
	farcall FarPtr_0a_22 ; $5dfe
	ld a, $14 ; $5e01
	ld bc, $0f00 ; $5e03
	ld de, $0780 ; $5e06
	farcall FarPtr_0a_22 ; $5e09
	ld a, $07 ; $5e0c
	ld b, $40 ; $5e0e
	farcall FarPtr_0a_2e ; $5e10
	ld a, $14 ; $5e13
	ld b, $40 ; $5e15
	farcall FarPtr_0a_2e ; $5e17
	ld a, $1e ; $5e1a
	call DelayFrames ; $5e1c
	xor a, a ; $5e1f
	ld bc, $0c00 ; $5e20
	ld de, $1100 ; $5e23
	farcall FarPtr_0a_3a ; $5e26
	ld a, $0c ; $5e29
	ld bc, $0c00 ; $5e2b
	ld de, $1700 ; $5e2e
	farcall FarPtr_0a_24 ; $5e31
	ld a, $0c ; $5e34
	farcall FarPtr_0a_20 ; $5e36
	ld a, $0c ; $5e39
	ld bc, $0c00 ; $5e3b
	ld de, $1300 ; $5e3e
	farcall FarPtr_0a_24 ; $5e41
	ld a, $0c ; $5e44
	farcall FarPtr_0a_20 ; $5e46
	ret ; $5e49
Func_0f_5e4a:
	ld d, $74 ; $5e4a
	ld a, $10 ; $5e4c
	farcall FarPtr_0a_16 ; $5e4e
	ld c, l ; $5e51
	ld b, h ; $5e52
	farcall FarPtr_04_2c ; $5e53
	ld a, $10 ; $5e56
	ld d, $01 ; $5e58
	farcall FarPtr_0a_34 ; $5e5a
	ld d, $25 ; $5e5d
	ld a, $0f ; $5e5f
	farcall FarPtr_0a_16 ; $5e61
	ld c, l ; $5e64
	ld b, h ; $5e65
	farcall FarPtr_04_2c ; $5e66
	ld a, $0f ; $5e69
	ld d, $01 ; $5e6b
	farcall FarPtr_0a_34 ; $5e6d
	ld a, $0f ; $5e70
	ld bc, $1100 ; $5e72
	ld de, $1600 ; $5e75
	farcall FarPtr_0a_22 ; $5e78
	ld a, $10 ; $5e7b
	ld bc, $1100 ; $5e7d
	ld de, $1500 ; $5e80
	farcall FarPtr_0a_22 ; $5e83
	ld a, $0f ; $5e86
	ld b, $c0 ; $5e88
	farcall FarPtr_0a_2e ; $5e8a
	ld a, $10 ; $5e8d
	ld d, $08 ; $5e8f
	farcall FarPtr_0a_34 ; $5e91
	ld a, $10 ; $5e94
	ld bc, $1100 ; $5e96
	ld de, $1200 ; $5e99
	farcall FarPtr_0a_24 ; $5e9c
	ld a, $0f ; $5e9f
	ld bc, $1100 ; $5ea1
	ld de, $1300 ; $5ea4
	farcall FarPtr_0a_24 ; $5ea7
	ld a, $0f ; $5eaa
	farcall FarPtr_0a_20 ; $5eac
	ld d, $25 ; $5eaf
	ld a, $10 ; $5eb1
	farcall FarPtr_0a_16 ; $5eb3
	ld c, l ; $5eb6
	ld b, h ; $5eb7
	farcall FarPtr_04_2c ; $5eb8
	ld a, $10 ; $5ebb
	ld d, $01 ; $5ebd
	farcall FarPtr_0a_34 ; $5ebf
	ld d, $74 ; $5ec2
	ld a, $0f ; $5ec4
	farcall FarPtr_0a_16 ; $5ec6
	ld c, l ; $5ec9
	ld b, h ; $5eca
	farcall FarPtr_04_2c ; $5ecb
	ld a, $0f ; $5ece
	ld d, $01 ; $5ed0
	farcall FarPtr_0a_34 ; $5ed2
	ld a, $10 ; $5ed5
	ld bc, $1100 ; $5ed7
	ld de, $1300 ; $5eda
	farcall FarPtr_0a_22 ; $5edd
	ld a, $0f ; $5ee0
	ld bc, $1000 ; $5ee2
	ld de, $1300 ; $5ee5
	farcall FarPtr_0a_22 ; $5ee8
	ld a, $10 ; $5eeb
	ld b, $80 ; $5eed
	farcall FarPtr_0a_2e ; $5eef
	ld a, $0f ; $5ef2
	ld d, $08 ; $5ef4
	farcall FarPtr_0a_34 ; $5ef6
	ld a, $10 ; $5ef9
	ld bc, $1000 ; $5efb
	ld de, $1300 ; $5efe
	farcall FarPtr_0a_24 ; $5f01
	ld a, $0f ; $5f04
	ld bc, $0f00 ; $5f06
	ld de, $1300 ; $5f09
	farcall FarPtr_0a_24 ; $5f0c
	ld a, $0f ; $5f0f
	farcall FarPtr_0a_20 ; $5f11
	ld a, $10 ; $5f14
	ld b, $01 ; $5f16
	farcall FarPtr_0a_2c ; $5f18
	ld a, $10 ; $5f1b
	ld bc, $1100 ; $5f1d
	ld de, $1300 ; $5f20
	farcall FarPtr_0a_24 ; $5f23
	ld a, $10 ; $5f26
	farcall FarPtr_0a_20 ; $5f28
	ld a, $10 ; $5f2b
	ld b, $00 ; $5f2d
	farcall FarPtr_0a_2c ; $5f2f
	ld a, $10 ; $5f32
	ld bc, $0020 ; $5f34
	farcall FarPtr_0a_18 ; $5f37
	ld a, $10 ; $5f3a
	ld bc, $1100 ; $5f3c
	ld de, $1600 ; $5f3f
	farcall FarPtr_0a_24 ; $5f42
	ld a, $10 ; $5f45
	farcall FarPtr_0a_20 ; $5f47
	ld a, $10 ; $5f4a
	ld b, $c0 ; $5f4c
	farcall FarPtr_0a_2e ; $5f4e
	ret ; $5f51
	INCBIN "data/bank_00f/d_5f52.bin" ; $5f52, 1519 bytes
	farcall FarPtr_0a_34 ; $6541
	ld a, $00 ; $6544
	farcall FarPtr_0a_36 ; $6546
	ld a, $03 ; $6549
	ld d, $02 ; $654b
	farcall FarPtr_0a_34 ; $654d
	ld a, $03 ; $6550
	farcall FarPtr_0a_36 ; $6552
	ld a, $03 ; $6555
	farcall FarPtr_0a_08 ; $6557
	ld a, $00 ; $655a
	ld d, $02 ; $655c
	farcall FarPtr_0a_34 ; $655e
	ld a, $00 ; $6561
	farcall FarPtr_0a_36 ; $6563
	test_flag $05, 7 ; $6566
	jr nz, Label_0f_6582 ; $6569
	ld a, $05 ; $656b
	ld d, $03 ; $656d
	farcall FarPtr_0a_34 ; $656f
	ld a, $05 ; $6572
	farcall FarPtr_0a_36 ; $6574
	ld a, $05 ; $6577
	farcall FarPtr_0a_08 ; $6579
	set_flag $15, 6 ; $657c
	jr Label_0f_65a6 ; $657f
	ret ; $6581
Label_0f_6582:
	farcall FarPtr_0a_10 ; $6582
	ld a, $04 ; $6585
	ld d, $03 ; $6587
	farcall FarPtr_0a_34 ; $6589
	ld a, $04 ; $658c
	farcall FarPtr_0a_36 ; $658e
	ld a, $04 ; $6591
	farcall FarPtr_0a_08 ; $6593
	ld a, $05 ; $6596
	farcall FarPtr_0a_16 ; $6598
	ld c, l ; $659b
	ld b, h ; $659c
	ld de, $d000 ; $659d
	farcall FarPtr_04_20 ; $65a0
	set_flag $15, 7 ; $65a3
Label_0f_65a6:
	ld bc, $0018 ; $65a6
	farcall FarPtr_0a_38 ; $65a9
	xor a, a ; $65ac
	ld bc, $1c00 ; $65ad
	ld de, $1d00 ; $65b0
	farcall FarPtr_0a_3a ; $65b3
	farcall FarPtr_0a_3e ; $65b6
	ld a, $00 ; $65b9
	ld [$c2b0], a ; $65bb
	farcall FarPtr_03_18 ; $65be
	ret ; $65c1
	INCBIN "data/bank_00f/d_65c2.bin" ; $65c2, 77 bytes
Func_0f_660f:
	test_flag $05, 7 ; $660f
	jr nz, Label_0f_663b ; $6612
	test_flag $07, 5 ; $6614
	jr z, Label_0f_661f ; $6617
	ld a, $03 ; $6619
	ld [$c2b0], a ; $661b
	ret ; $661e
Label_0f_661f:
	test_flag $07, 6 ; $661f
	jr z, Label_0f_662a ; $6622
	ld a, $02 ; $6624
	ld [$c2b0], a ; $6626
	ret ; $6629
Label_0f_662a:
	test_flag $07, 7 ; $662a
	jr z, Label_0f_6635 ; $662d
	ld a, $01 ; $662f
	ld [$c2b0], a ; $6631
	ret ; $6634
Label_0f_6635:
	ld a, $00 ; $6635
	ld [$c2b0], a ; $6637
	ret ; $663a
Label_0f_663b:
	test_flag $06, 6 ; $663b
	jr z, Label_0f_6646 ; $663e
	ld a, $03 ; $6640
	ld [$c2b0], a ; $6642
	ret ; $6645
Label_0f_6646:
	test_flag $06, 7 ; $6646
	jr z, Label_0f_6635 ; $6649
	ld a, $02 ; $664b
	ld [$c2b0], a ; $664d
	ret ; $6650
	INCBIN "data/bank_00f/d_6651.bin" ; $6651, 2407 bytes
	farcall FarPtr_0a_2e ; $6fb8
	ld a, $0d ; $6fbb
	ld b, $40 ; $6fbd
	farcall FarPtr_0a_2e ; $6fbf
	ret ; $6fc2
	INCBIN "data/bank_00f/d_6fc3.bin" ; $6fc3, 433 bytes
	farcall FarPtr_0a_24 ; $7174
	ld a, $05 ; $7177
	farcall FarPtr_0a_20 ; $7179
	ldh a, [hRomBank] ; $717c
	ld b, a ; $717e
	ld a, $05 ; $717f
	ld de, $73be ; $7181
	farcall FarPtr_0a_1a ; $7184
	push af ; $7187
	ld a, $14 ; $7188
	farcall FarPtr_0a_04 ; $718a
	pop af ; $718d
	ldh a, [hRomBank] ; $718e
	ld b, a ; $7190
	ld a, $0a ; $7191
	ld de, $73be ; $7193
	farcall FarPtr_0a_1a ; $7196
	push af ; $7199
	ld a, $14 ; $719a
	farcall FarPtr_0a_04 ; $719c
	pop af ; $719f
	ldh a, [hRomBank] ; $71a0
	ld b, a ; $71a2
	ld a, $00 ; $71a3
	ld de, $73be ; $71a5
	farcall FarPtr_0a_1a ; $71a8
	xor a, a ; $71ab
	ld bc, $1100 ; $71ac
	ld de, $0d00 ; $71af
	farcall FarPtr_0a_3a ; $71b2
	farcall FarPtr_0a_3e ; $71b5
	push af ; $71b8
	ld a, $3c ; $71b9
	farcall FarPtr_0a_04 ; $71bb
	pop af ; $71be
	ld c, $10 ; $71bf
	call Func_00_1d20 ; $71c1
	call Func_00_1da4 ; $71c4
	call Func_0f_7434 ; $71c7
	ld a, $19 ; $71ca
	ld [wStoryModeCurrentLocation], a ; $71cc
	ld a, $0a ; $71cf
	ld [$c295], a ; $71d1
	ld a, $ff ; $71d4
	ld [$c294], a ; $71d6
	ld [$c2a1], a ; $71d9
	farcall FarPtr_InitStoryMatchSettings ; $71dc
	test_flag $07, 5 ; $71df
	jr z, Label_0f_71f3 ; $71e2
	ld a, $00 ; $71e4
	ld [wCurrentMinigameStoryMatch], a ; $71e6
	ld a, $13 ; $71e9
	ld [$c8f7], a ; $71eb
	farcall FarPtr_LoadMatchSettingsFromTable ; $71ee
	jr Label_0f_7228 ; $71f1
Label_0f_71f3:
	test_flag $07, 6 ; $71f3
	jr z, Label_0f_7207 ; $71f6
	ld a, $00 ; $71f8
	ld [wCurrentMinigameStoryMatch], a ; $71fa
	ld a, $12 ; $71fd
	ld [$c8f7], a ; $71ff
	farcall FarPtr_LoadMatchSettingsFromTable ; $7202
	jr Label_0f_7228 ; $7205
Label_0f_7207:
	test_flag $07, 7 ; $7207
	jr z, Label_0f_721b ; $720a
	ld a, $00 ; $720c
	ld [wCurrentMinigameStoryMatch], a ; $720e
	ld a, $11 ; $7211
	ld [$c8f7], a ; $7213
	farcall FarPtr_LoadMatchSettingsFromTable ; $7216
	jr Label_0f_7228 ; $7219
Label_0f_721b:
	ld a, $00 ; $721b
	ld [wCurrentMinigameStoryMatch], a ; $721d
	ld a, $10 ; $7220
	ld [$c8f7], a ; $7222
	farcall FarPtr_LoadMatchSettingsFromTable ; $7225
Label_0f_7228:
	farcall FarPtr_0a_4c ; $7228
	farcall FarPtr_0a_4e ; $722b
	ret ; $722e
	INCBIN "data/bank_00f/d_722f.bin" ; $722f, 487 bytes
Func_0f_7416:
	test_flag $05, 7 ; $7416
	jr nz, Label_0f_7425 ; $7419
	ld b, $00 ; $741b
	ld a, [$c2b0] ; $741d
	inc a ; $7420
	ld c, a ; $7421
	ld d, $00 ; $7422
	ret ; $7424
Label_0f_7425:
	ld b, $01 ; $7425
	ld a, [$c2b0] ; $7427
	inc a ; $742a
	cp a, $03 ; $742b
	jr c, Label_0f_7430 ; $742d
	dec a ; $742f
Label_0f_7430:
	ld c, a ; $7430
	ld d, $00 ; $7431
	ret ; $7433
Func_0f_7434:
	xor a, a ; $7434
	ldh [$ffb9], a ; $7435
	ldh [$ffb8], a ; $7437
	ldh [$ff8a], a ; $7439
	ldh [$ff8b], a ; $743b
	ld [$c321], a ; $743d
	ld [$c323], a ; $7440
	call ClearFrameTasks ; $7443
	call Func_0f_7416 ; $7446
	farcall FarPtr_1b_1a ; $7449
	ret ; $744c
	INCBIN "data/bank_00f/d_744d.bin" ; $744d, 329 bytes
	farcall FarPtr_0a_2a ; $7596
	ld a, $04 ; $7599
	farcall FarPtr_0a_20 ; $759b
	push af ; $759e
	ld a, $0a ; $759f
	farcall FarPtr_0a_04 ; $75a1
	pop af ; $75a4
	push af ; $75a5
	ld a, $0a ; $75a6
	farcall FarPtr_0a_04 ; $75a8
	pop af ; $75ab
	ld a, $04 ; $75ac
	ld b, $80 ; $75ae
	farcall FarPtr_0a_2e ; $75b0
	set_flag $17, 1 ; $75b3
	ret ; $75b6
	INCBIN "data/bank_00f/d_75b7.bin" ; $75b7, 336 bytes
	farcall FarPtr_0a_60 ; $7707
	call Func_0f_7b20 ; $770a
	ld a, $02 ; $770d
	farcall FarPtr_0a_1c ; $770f
	ld a, $02 ; $7712
	ld bc, $2500 ; $7714
	ld de, $1100 ; $7717
	farcall FarPtr_0a_22 ; $771a
	ld a, $02 ; $771d
	ld b, $c0 ; $771f
	farcall FarPtr_0a_2e ; $7721
	ld c, $04 ; $7724
	call Func_00_1d2e ; $7726
	call Func_00_1da4 ; $7729
	call Func_0f_660f ; $772c
	farcall FarPtr_0a_00 ; $772f
	ld a, $00 ; $7732
	ld b, a ; $7734
	ld a, $02 ; $7735
	farcall FarPtr_0a_30 ; $7737
	ld c, $04 ; $773a
	call Func_00_1d2e ; $773c
	call Func_00_1da4 ; $773f
	ld a, [$c2b0] ; $7742
	dec a ; $7745
	add a, a ; $7746
	add a, $3a ; $7747
	ld l, a ; $7749
	adc a, $78 ; $774a
	sub a, l ; $774c
	ld h, a ; $774d
	ld a, [hl+] ; $774e
	ld h, [hl] ; $774f
	ld l, a ; $7750
	farcall FarPtr_0a_0e ; $7751
	ld a, [$c94d] ; $7754
	or a, a ; $7757
	jr nz, Label_0f_7763 ; $7758
	farcall FarPtr_0a_10 ; $775a
	farcall FarPtr_0a_10 ; $775d
	farcall FarPtr_0a_10 ; $7760
Label_0f_7763:
	ld a, $08 ; $7763
	farcall FarPtr_0a_16 ; $7765
	ld c, l ; $7768
	ld b, h ; $7769
	ld hl, $0037 ; $776a
	add hl, bc ; $776d
	ld a, [hl] ; $776e
	xor a, $20 ; $776f
	ld [hl], a ; $7771
	ld a, $00 ; $7772
	ld b, a ; $7774
	ld a, $02 ; $7775
	farcall FarPtr_0a_30 ; $7777
	ld a, $02 ; $777a
	ld de, $ff80 ; $777c
	farcall FarPtr_0a_42 ; $777f
	ld a, $02 ; $7782
	farcall FarPtr_0a_44 ; $7784
	ld a, $02 ; $7787
	ld b, a ; $7789
	ld a, $00 ; $778a
	farcall FarPtr_0a_30 ; $778c
	ld a, $02 ; $778f
	farcall FarPtr_0a_08 ; $7791
	ld a, $08 ; $7794
	ld bc, $2000 ; $7796
	ld de, $0f80 ; $7799
	farcall FarPtr_0a_22 ; $779c
	sound $97 ; $779f
	push af ; $77a1
	ld a, $2d ; $77a2
	farcall FarPtr_0a_04 ; $77a4
	pop af ; $77a7
	ld a, $03 ; $77a8
	ld d, $02 ; $77aa
	farcall FarPtr_0a_34 ; $77ac
	ld a, $03 ; $77af
	farcall FarPtr_0a_36 ; $77b1
	ld a, $08 ; $77b4
	ld bc, $3f00 ; $77b6
	ld de, $3f00 ; $77b9
	farcall FarPtr_0a_22 ; $77bc
	ld a, $03 ; $77bf
	ld b, a ; $77c1
	ld a, $00 ; $77c2
	farcall FarPtr_0a_30 ; $77c4
	ld a, $03 ; $77c7
	farcall FarPtr_0a_08 ; $77c9
	ld a, $04 ; $77cc
	ld d, $03 ; $77ce
	farcall FarPtr_0a_34 ; $77d0
	ld a, $04 ; $77d3
	farcall FarPtr_0a_36 ; $77d5
	ld a, $04 ; $77d8
	ld b, a ; $77da
	ld a, $00 ; $77db
	farcall FarPtr_0a_30 ; $77dd
	ld a, $04 ; $77e0
	ld b, a ; $77e2
	ld a, $02 ; $77e3
	farcall FarPtr_0a_30 ; $77e5
	ld a, $04 ; $77e8
	farcall FarPtr_0a_08 ; $77ea
	call Func_0f_7911 ; $77ed
	ld a, $00 ; $77f0
	ld b, a ; $77f2
	ld a, $04 ; $77f3
	farcall FarPtr_0a_30 ; $77f5
	ld a, $03 ; $77f8
	ld b, $00 ; $77fa
	farcall FarPtr_0a_2e ; $77fc
	ld hl, $2849 ; $77ff
	farcall FarPtr_0a_0e ; $7802
	ld a, [$c2b0] ; $7805
	dec a ; $7808
	ld hl, $2862 ; $7809
	add a, l ; $780c
	ld l, a ; $780d
	jr nc, Label_0f_7811 ; $780e
	inc h ; $7810
Label_0f_7811:
	call QueueShortText ; $7811
	ld a, $04 ; $7814
	ld b, a ; $7816
	ld a, $00 ; $7817
	farcall FarPtr_0a_30 ; $7819
	ld a, $04 ; $781c
	ld b, a ; $781e
	ld a, $02 ; $781f
	farcall FarPtr_0a_30 ; $7821
	ld a, $03 ; $7824
	farcall FarPtr_0a_08 ; $7826
	set_flag $17, 1 ; $7829
	ld a, $02 ; $782c
	farcall FarPtr_0a_16 ; $782e
	ld c, l ; $7831
	ld b, h ; $7832
	ld de, $d000 ; $7833
	farcall FarPtr_04_20 ; $7836
	ret ; $7839
	INCBIN "data/bank_00f/d_783a.bin" ; $783a, 142 bytes
	farcall FarPtr_0a_08 ; $78c8
	ret ; $78cb
	INCBIN "data/bank_00f/d_78cc.bin" ; $78cc, 32 bytes
Func_0f_78ec:
	test_flag $05, 7 ; $78ec
	jr nz, Label_0f_7901 ; $78ef
	ld a, [$c2b0] ; $78f1
	dec a ; $78f4
	ld hl, $2861 ; $78f5
	add a, l ; $78f8
	ld l, a ; $78f9
	jr nc, Label_0f_78fd ; $78fa
	inc h ; $78fc
Label_0f_78fd:
	call QueueShortText ; $78fd
	ret ; $7900
Label_0f_7901:
	ld a, [$c2b0] ; $7901
	dec a ; $7904
	ld hl, $2865 ; $7905
	add a, l ; $7908
	ld l, a ; $7909
	jr nc, Label_0f_790d ; $790a
	inc h ; $790c
Label_0f_790d:
	call QueueShortText ; $790d
	ret ; $7910
Func_0f_7911:
	ld a, $06 ; $7911
	ld bc, $1500 ; $7913
	ld de, $1700 ; $7916
	farcall FarPtr_0a_22 ; $7919
	ld a, $07 ; $791c
	ld bc, $1700 ; $791e
	ld de, $1700 ; $7921
	farcall FarPtr_0a_22 ; $7924
	ld a, $06 ; $7927
	ld bc, $2300 ; $7929
	ld de, $1700 ; $792c
	farcall FarPtr_0a_24 ; $792f
	ld a, $07 ; $7932
	ld bc, $2500 ; $7934
	ld de, $1700 ; $7937
	farcall FarPtr_0a_24 ; $793a
	ld a, $07 ; $793d
	farcall FarPtr_0a_20 ; $793f
	ld hl, $2869 ; $7942
	farcall FarPtr_0a_0e ; $7945
	xor a, a ; $7948
	ld bc, $2300 ; $7949
	ld de, $1100 ; $794c
	farcall FarPtr_0a_3a ; $794f
	farcall FarPtr_0a_3e ; $7952
	ld a, $03 ; $7955
	ld b, $40 ; $7957
	farcall FarPtr_0a_2e ; $7959
	ld a, $04 ; $795c
	ld b, $40 ; $795e
	farcall FarPtr_0a_2e ; $7960
	ld a, $05 ; $7963
	ld b, $40 ; $7965
	farcall FarPtr_0a_2e ; $7967
	ld a, $00 ; $796a
	ld b, $40 ; $796c
	farcall FarPtr_0a_2e ; $796e
	ld a, $02 ; $7971
	ld b, $40 ; $7973
	farcall FarPtr_0a_2e ; $7975
	ld a, $06 ; $7978
	ld b, $c0 ; $797a
	farcall FarPtr_0a_2e ; $797c
	ld a, $07 ; $797f
	ld b, $c0 ; $7981
	farcall FarPtr_0a_2e ; $7983
	ld a, $06 ; $7986
	ld d, $03 ; $7988
	farcall FarPtr_0a_34 ; $798a
	ld a, $06 ; $798d
	farcall FarPtr_0a_36 ; $798f
	call Func_0f_78ec ; $7992
	ld a, $06 ; $7995
	farcall FarPtr_0a_08 ; $7997
	ld a, $06 ; $799a
	ld d, $03 ; $799c
	farcall FarPtr_0a_34 ; $799e
	ld a, $06 ; $79a1
	farcall FarPtr_0a_36 ; $79a3
	ld a, [$c2b0] ; $79a6
	ld hl, $2861 ; $79a9
	add a, l ; $79ac
	ld l, a ; $79ad
	jr nc, Label_0f_79b1 ; $79ae
	inc h ; $79b0
Label_0f_79b1:
	call QueueShortText ; $79b1
	ld a, $06 ; $79b4
	farcall FarPtr_0a_08 ; $79b6
	ld a, $07 ; $79b9
	ld b, a ; $79bb
	ld a, $06 ; $79bc
	farcall FarPtr_0a_32 ; $79be
	push af ; $79c1
	ld a, $14 ; $79c2
	farcall FarPtr_0a_04 ; $79c4
	pop af ; $79c7
	ld a, $06 ; $79c8
	ld d, $03 ; $79ca
	farcall FarPtr_0a_34 ; $79cc
	ld a, $07 ; $79cf
	ld d, $03 ; $79d1
	farcall FarPtr_0a_34 ; $79d3
	ld a, $07 ; $79d6
	farcall FarPtr_0a_36 ; $79d8
	ld a, $06 ; $79db
	ld bc, $1500 ; $79dd
	ld de, $1700 ; $79e0
	farcall FarPtr_0a_24 ; $79e3
	ld a, $07 ; $79e6
	ld bc, $1700 ; $79e8
	ld de, $1700 ; $79eb
	farcall FarPtr_0a_24 ; $79ee
	ld a, $07 ; $79f1
	farcall FarPtr_0a_20 ; $79f3
	ld a, $00 ; $79f6
	ld b, $00 ; $79f8
	farcall FarPtr_0a_3c ; $79fa
	ld a, $06 ; $79fd
	ld bc, $3f00 ; $79ff
	ld de, $3f00 ; $7a02
	farcall FarPtr_0a_22 ; $7a05
	ld a, $07 ; $7a08
	ld bc, $3f00 ; $7a0a
	ld de, $3f00 ; $7a0d
	farcall FarPtr_0a_22 ; $7a10
	farcall FarPtr_0a_3e ; $7a13
	ret ; $7a16
	INCBIN "data/bank_00f/d_7a17.bin" ; $7a17, 119 bytes
QueueShortText:
	ldh a, [hWramBank] ; $7a8e
	push af ; $7a90
	wram_bank $07 ; $7a91
	ld de, $df00 ; $7a97
	wram_bank $05 ; $7a9a
	farcall FarPtr_FetchShortTextToBuffer ; $7aa0
	ld hl, $df00 ; $7aa3
	farcall FarPtr_05_46 ; $7aa6
	pop af ; $7aa9
	wram_bank ; $7aaa
	ret ; $7aae
	INCBIN "data/bank_00f/d_7aaf.bin" ; $7aaf, 113 bytes
Func_0f_7b20:
	test_flag $05, 7 ; $7b20
	jp z, Label_0f_7b3e ; $7b23
	ld a, [$c94d] ; $7b26
	ld d, $58 ; $7b29
	add a, d ; $7b2b
	ld d, a ; $7b2c
	ld a, $02 ; $7b2d
	farcall FarPtr_0a_16 ; $7b2f
	ld c, l ; $7b32
	ld b, h ; $7b33
	farcall FarPtr_04_2c ; $7b34
	ld a, $02 ; $7b37
	ld d, $01 ; $7b39
	farcall FarPtr_0a_34 ; $7b3b
Label_0f_7b3e:
	ld a, [$c90d] ; $7b3e
	ld d, $56 ; $7b41
	add a, d ; $7b43
	ld d, a ; $7b44
	ld a, $00 ; $7b45
	farcall FarPtr_0a_16 ; $7b47
	ld c, l ; $7b4a
	ld b, h ; $7b4b
	farcall FarPtr_04_2c ; $7b4c
	ld a, $00 ; $7b4f
	ld d, $01 ; $7b51
	farcall FarPtr_0a_34 ; $7b53
	ret ; $7b56
	INCBIN "data/bank_00f/d_7b57.bin" ; $7b57, 612 bytes
	ds 581, $ff ; $7dbb, fill

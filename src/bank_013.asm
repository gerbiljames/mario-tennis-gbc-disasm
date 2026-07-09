INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $13", ROMX[$4000], BANK[$13]

	INCBIN "data/bank_013/d_4000.bin" ; $4000, 1080 bytes
	rst Rst18 ; $4438
	ld a, [hl+] ; $4439
	ld a, [bc] ; $443a
	ld a, $00 ; $443b
	ld bc, $0010 ; $443d
	rst Rst18 ; $4440
	jr Label_13_444d ; $4441
	INCBIN "data/bank_013/d_4443.bin" ; $4443, 10 bytes
Label_13_444d:
	ld [$34df], sp ; $444d
	ld a, [bc] ; $4450
	ld c, $08 ; $4451
	call Func_00_1d20 ; $4453
	ld a, $00 ; $4456
	rst Rst18 ; $4458
	jr nz, Label_13_4465 ; $4459
	ld a, $00 ; $445b
	ld b, $00 ; $445d
	rst Rst18 ; $445f
	ld c, b ; $4460
	ld a, [bc] ; $4461
	push af ; $4462
	ld a, $0a ; $4463
Label_13_4465:
	rst Rst18 ; $4465
	inc b ; $4466
	ld a, [bc] ; $4467
	pop af ; $4468
	ret ; $4469
	INCBIN "data/bank_013/d_446a.bin" ; $446a, 824 bytes
	rst Rst18 ; $47a2
	ld [hl+], a ; $47a3
	ld a, [bc] ; $47a4
	ld c, $04 ; $47a5
	call Func_00_1d2e ; $47a7
	call Func_00_1da4 ; $47aa
	ld a, $06 ; $47ad
	ld bc, $4100 ; $47af
	ld de, $0d00 ; $47b2
	rst Rst18 ; $47b5
	ld [hl+], a ; $47b6
	ld a, [bc] ; $47b7
	ld a, $06 ; $47b8
	ld bc, $1b00 ; $47ba
	ld de, $0d00 ; $47bd
	rst Rst18 ; $47c0
	inc h ; $47c1
	ld a, [bc] ; $47c2
	ld a, $00 ; $47c3
	ld bc, $4300 ; $47c5
	ld de, $0d00 ; $47c8
	rst Rst18 ; $47cb
	ld [hl+], a ; $47cc
	ld a, [bc] ; $47cd
	ld a, $00 ; $47ce
	ld bc, $1d00 ; $47d0
	ld de, $0d00 ; $47d3
	rst Rst18 ; $47d6
	inc h ; $47d7
	ld a, [bc] ; $47d8
	push af ; $47d9
	ld a, $0f ; $47da
	rst Rst18 ; $47dc
	inc b ; $47dd
	ld a, [bc] ; $47de
	pop af ; $47df
	xor a, a ; $47e0
	ld bc, $1b00 ; $47e1
	ld de, $0d00 ; $47e4
	rst Rst18 ; $47e7
	ld a, [hl-] ; $47e8
	ld a, [bc] ; $47e9
	ld a, $00 ; $47ea
	rst Rst18 ; $47ec
	jr nz, Label_13_47f9 ; $47ed
	push af ; $47ef
	ld a, $1e ; $47f0
	rst Rst18 ; $47f2
	inc b ; $47f3
	ld a, [bc] ; $47f4
	pop af ; $47f5
	ld a, $00 ; $47f6
	ld b, a ; $47f8
Label_13_47f9:
	ld a, $06 ; $47f9
	rst Rst18 ; $47fb
	jr nc, Label_13_4808 ; $47fc
	ld hl, $0435 ; $47fe
	rst Rst18 ; $4801
	ld c, $0a ; $4802
	ld a, $06 ; $4804
	rst Rst18 ; $4806
	INCBIN "data/bank_013/d_4807.bin" ; $4807, 1 bytes
Label_13_4808:
	ld a, [bc] ; $4808
	ld a, $00 ; $4809
	ld d, $03 ; $480b
	rst Rst18 ; $480d
	inc [hl] ; $480e
	ld a, [bc] ; $480f
	ld a, $00 ; $4810
	rst Rst18 ; $4812
	ld [hl], $0a ; $4813
	ld a, $06 ; $4815
	ld b, $c0 ; $4817
	rst Rst18 ; $4819
	ld l, $0a ; $481a
	push af ; $481c
	ld a, $0f ; $481d
	rst Rst18 ; $481f
	inc b ; $4820
	ld a, [bc] ; $4821
	pop af ; $4822
	ld a, $00 ; $4823
	ld b, $c0 ; $4825
	rst Rst18 ; $4827
	ld l, $0a ; $4828
	ld a, $06 ; $482a
	rst Rst18 ; $482c
	ld [$3e0a], sp ; $482d
	nop ; $4830
	ld d, $03 ; $4831
	rst Rst18 ; $4833
	inc [hl] ; $4834
	ld a, [bc] ; $4835
	ld a, $00 ; $4836
	rst Rst18 ; $4838
	ld [hl], $0a ; $4839
	push af ; $483b
	ld a, $1e ; $483c
	rst Rst18 ; $483e
	inc b ; $483f
	ld a, [bc] ; $4840
	pop af ; $4841
	call Func_13_4d78 ; $4842
	ld a, $07 ; $4845
	rst Rst18 ; $4847
	ld [$f50a], sp ; $4848
	ld a, $0f ; $484b
	rst Rst18 ; $484d
	inc b ; $484e
	ld a, [bc] ; $484f
	pop af ; $4850
	ld a, $03 ; $4851
	ld bc, $1c00 ; $4853
	ld de, $0b00 ; $4856
	rst Rst18 ; $4859
	ld [hl+], a ; $485a
	ld a, [bc] ; $485b
	rst Rst08 ; $485c
	sub a, a ; $485d
	push af ; $485e
	ld a, $1e ; $485f
	rst Rst18 ; $4861
	inc b ; $4862
	ld a, [bc] ; $4863
	pop af ; $4864
	ld a, $03 ; $4865
	ld bc, $3f00 ; $4867
	ld de, $3f00 ; $486a
	rst Rst18 ; $486d
	ld [hl+], a ; $486e
	ld a, [bc] ; $486f
	ld a, $06 ; $4870
	ld b, $80 ; $4872
	rst Rst18 ; $4874
	ld l, $0a ; $4875
	push af ; $4877
	ld a, $0f ; $4878
	rst Rst18 ; $487a
	inc b ; $487b
	ld a, [bc] ; $487c
	pop af ; $487d
	ld a, $00 ; $487e
	ld b, $80 ; $4880
	rst Rst18 ; $4882
	ld l, $0a ; $4883
	xor a, a ; $4885
	ld bc, $1800 ; $4886
	ld de, $0d00 ; $4889
	rst Rst18 ; $488c
	ld a, [hl-] ; $488d
	ld a, [bc] ; $488e
	push af ; $488f
	ld a, $0f ; $4890
	rst Rst18 ; $4892
	inc b ; $4893
	ld a, [bc] ; $4894
	pop af ; $4895
	ld a, $07 ; $4896
	ld bc, $1500 ; $4898
	ld de, $0980 ; $489b
	rst Rst18 ; $489e
	ld [hl+], a ; $489f
	ld a, [bc] ; $48a0
	push af ; $48a1
	ld a, $0f ; $48a2
	rst Rst18 ; $48a4
	inc b ; $48a5
	ld a, [bc] ; $48a6
	pop af ; $48a7
	ld a, $07 ; $48a8
	ld bc, $0010 ; $48aa
	rst Rst18 ; $48ad
	jr Label_13_48ba ; $48ae
	INCBIN "data/bank_013/d_48b0.bin" ; $48b0, 10 bytes
Label_13_48ba:
	ld a, [bc] ; $48ba
	ld a, $07 ; $48bb
	rst Rst18 ; $48bd
	jr nz, Label_13_48ca ; $48be
	ld a, $07 ; $48c0
	ld b, $00 ; $48c2
	rst Rst18 ; $48c4
	ld l, $0a ; $48c5
	ld a, $08 ; $48c7
	INCBIN "data/bank_013/d_48c9.bin" ; $48c9, 1 bytes
Label_13_48ca:
	nop ; $48ca
	dec d ; $48cb
	ld de, $0900 ; $48cc
	rst Rst18 ; $48cf
	ld [hl+], a ; $48d0
	ld a, [bc] ; $48d1
	push af ; $48d2
	ld a, $0f ; $48d3
	rst Rst18 ; $48d5
	inc b ; $48d6
	ld a, [bc] ; $48d7
	pop af ; $48d8
	ld a, $08 ; $48d9
	ld bc, $0010 ; $48db
	rst Rst18 ; $48de
	jr Label_13_48eb ; $48df
	INCBIN "data/bank_013/d_48e1.bin" ; $48e1, 10 bytes
Label_13_48eb:
	ld a, [bc] ; $48eb
	ld a, $08 ; $48ec
	rst Rst18 ; $48ee
	jr nz, Label_13_48fb ; $48ef
	call Func_13_4dcc ; $48f1
	ld a, $08 ; $48f4
	ld b, $00 ; $48f6
	rst Rst18 ; $48f8
	ld l, $0a ; $48f9
Label_13_48fb:
	push af ; $48fb
	ld a, $0f ; $48fc
	rst Rst18 ; $48fe
	inc b ; $48ff
	ld a, [bc] ; $4900
	pop af ; $4901
	ld a, $06 ; $4902
	ld d, $02 ; $4904
	rst Rst18 ; $4906
	inc [hl] ; $4907
	ld a, [bc] ; $4908
	ld a, $06 ; $4909
	rst Rst18 ; $490b
	ld [hl], $0a ; $490c
	ld a, $06 ; $490e
	rst Rst18 ; $4910
	ld [$3e0a], sp ; $4911
	rlca ; $4914
	ld b, $40 ; $4915
	rst Rst18 ; $4917
	ld l, $0a ; $4918
	ld a, $07 ; $491a
	ld d, $04 ; $491c
	rst Rst18 ; $491e
	inc [hl] ; $491f
	ld a, [bc] ; $4920
	ld a, $07 ; $4921
	rst Rst18 ; $4923
	ld [hl], $0a ; $4924
	push af ; $4926
	ld a, $1e ; $4927
	rst Rst18 ; $4929
	inc b ; $492a
	ld a, [bc] ; $492b
	pop af ; $492c
	ld a, $06 ; $492d
	ld b, a ; $492f
	ld a, $07 ; $4930
	rst Rst18 ; $4932
	jr nc, Label_13_493f ; $4933
	ld a, $07 ; $4935
	rst Rst18 ; $4937
	ld [$3e0a], sp ; $4938
	ld b, $16 ; $493b
	ld [bc], a ; $493d
	rst Rst18 ; $493e
Label_13_493f:
	inc [hl] ; $493f
	ld a, [bc] ; $4940
	ld a, $06 ; $4941
	rst Rst18 ; $4943
	ld [hl], $0a ; $4944
	ld a, $06 ; $4946
	rst Rst18 ; $4948
	ld [$3e0a], sp ; $4949
	ld [$0316], sp ; $494c
	rst Rst18 ; $494f
	inc [hl] ; $4950
	ld a, [bc] ; $4951
	ld a, $08 ; $4952
	rst Rst18 ; $4954
	ld [hl], $0a ; $4955
	ld a, $08 ; $4957
	rst Rst18 ; $4959
	ld [$f50a], sp ; $495a
	ld a, $0f ; $495d
	rst Rst18 ; $495f
	inc b ; $4960
	ld a, [bc] ; $4961
	pop af ; $4962
	ld a, $08 ; $4963
	ld d, $02 ; $4965
	rst Rst18 ; $4967
	inc [hl] ; $4968
	ld a, [bc] ; $4969
	ld a, $08 ; $496a
	rst Rst18 ; $496c
	ld [hl], $0a ; $496d
	ld a, $04 ; $496f
	ld bc, $1640 ; $4971
	ld de, $0940 ; $4974
	rst Rst18 ; $4977
	ld [hl+], a ; $4978
	ld a, [bc] ; $4979
	rst Rst08 ; $497a
	sbc a, b ; $497b
	push af ; $497c
	ld a, $1e ; $497d
	rst Rst18 ; $497f
	inc b ; $4980
	ld a, [bc] ; $4981
	pop af ; $4982
	ld a, $04 ; $4983
	ld bc, $3f00 ; $4985
	ld de, $3f00 ; $4988
	rst Rst18 ; $498b
	ld [hl+], a ; $498c
	ld a, [bc] ; $498d
	push af ; $498e
	ld a, $1e ; $498f
	rst Rst18 ; $4991
	inc b ; $4992
	ld a, [bc] ; $4993
	pop af ; $4994
	ld a, $06 ; $4995
	ld d, $02 ; $4997
	rst Rst18 ; $4999
	inc [hl] ; $499a
	ld a, [bc] ; $499b
	ld a, $06 ; $499c
	rst Rst18 ; $499e
	ld [hl], $0a ; $499f
	ld a, $00 ; $49a1
	ld b, a ; $49a3
	ld a, $06 ; $49a4
	rst Rst18 ; $49a6
	jr nc, Label_13_49b3 ; $49a7
	push af ; $49a9
	ld a, $32 ; $49aa
	rst Rst18 ; $49ac
	inc b ; $49ad
	ld a, [bc] ; $49ae
	pop af ; $49af
	ld a, $07 ; $49b0
	ld b, a ; $49b2
Label_13_49b3:
	ld a, $06 ; $49b3
	rst Rst18 ; $49b5
	jr nc, Label_13_49c2 ; $49b6
	ld a, [$c90d] ; $49b8
	or a, a ; $49bb
	jr z, $49c1 ; $49bc
	rst Rst18 ; $49be
	INCBIN "data/bank_013/d_49bf.bin" ; $49bf, 3 bytes
Label_13_49c2:
	ld b, $df ; $49c2
	ld [$210a], sp ; $49c4
	ld a, $04 ; $49c7
	rst Rst18 ; $49c9
	ld c, $0a ; $49ca
	push af ; $49cc
	ld a, $0f ; $49cd
	rst Rst18 ; $49cf
	inc b ; $49d0
	ld a, [bc] ; $49d1
	pop af ; $49d2
	ld a, $00 ; $49d3
	ld bc, $0018 ; $49d5
	rst Rst18 ; $49d8
	jr Label_13_49e5 ; $49d9
	INCBIN "data/bank_013/d_49db.bin" ; $49db, 10 bytes
Label_13_49e5:
	ld a, [bc] ; $49e5
	ld a, $00 ; $49e6
	rst Rst18 ; $49e8
	jr nz, Label_13_49f5 ; $49e9
	ld a, $00 ; $49eb
	ld bc, $1b00 ; $49ed
	ld de, $0b00 ; $49f0
	rst Rst18 ; $49f3
	inc h ; $49f4
Label_13_49f5:
	ld a, [bc] ; $49f5
	ld a, $00 ; $49f6
	rst Rst18 ; $49f8
	jr nz, Label_13_4a05 ; $49f9
	ld a, $00 ; $49fb
	ld b, $80 ; $49fd
	rst Rst18 ; $49ff
	ld l, $0a ; $4a00
	ld a, $00 ; $4a02
	INCBIN "data/bank_013/d_4a04.bin" ; $4a04, 1 bytes
Label_13_4a05:
	jr nz, Label_13_4a07 ; $4a05
Label_13_4a07:
	rst Rst18 ; $4a07
	jr Label_13_4a14 ; $4a08
	INCBIN "data/bank_013/d_4a0a.bin" ; $4a0a, 10 bytes
Label_13_4a14:
	inc bc ; $4a14
	rst Rst18 ; $4a15
	inc [hl] ; $4a16
	ld a, [bc] ; $4a17
	ld a, $00 ; $4a18
	rst Rst18 ; $4a1a
	ld [hl], $0a ; $4a1b
	push af ; $4a1d
	ld a, $0f ; $4a1e
	rst Rst18 ; $4a20
	inc b ; $4a21
	ld a, [bc] ; $4a22
	pop af ; $4a23
	ld a, $08 ; $4a24
	ld b, a ; $4a26
	ld a, $07 ; $4a27
	rst Rst18 ; $4a29
	ld [hl-], a ; $4a2a
	ld a, [bc] ; $4a2b
	push af ; $4a2c
	ld a, $46 ; $4a2d
	rst Rst18 ; $4a2f
	inc b ; $4a30
	ld a, [bc] ; $4a31
	pop af ; $4a32
	ld a, $00 ; $4a33
	ld b, a ; $4a35
	ld a, $07 ; $4a36
	rst Rst18 ; $4a38
	jr nc, Label_13_4a45 ; $4a39
	ld a, $00 ; $4a3b
	ld b, a ; $4a3d
	ld a, $08 ; $4a3e
	rst Rst18 ; $4a40
	jr nc, Label_13_4a4d ; $4a41
	push af ; $4a43
	INCBIN "data/bank_013/d_4a44.bin" ; $4a44, 1 bytes
Label_13_4a45:
	rrca ; $4a45
	rst Rst18 ; $4a46
	inc b ; $4a47
	ld a, [bc] ; $4a48
	pop af ; $4a49
	ld a, $07 ; $4a4a
	rst Rst18 ; $4a4c
Label_13_4a4d:
	ld [$3e0a], sp ; $4a4d
	rlca ; $4a50
	ld d, $03 ; $4a51
	rst Rst18 ; $4a53
	inc [hl] ; $4a54
	ld a, [bc] ; $4a55
	ld a, $07 ; $4a56
	rst Rst18 ; $4a58
	ld [hl], $0a ; $4a59
	ld a, $07 ; $4a5b
	rst Rst18 ; $4a5d
	ld [$3e0a], sp ; $4a5e
	nop ; $4a61
	ld d, $03 ; $4a62
	rst Rst18 ; $4a64
	inc [hl] ; $4a65
	ld a, [bc] ; $4a66
	ld a, $00 ; $4a67
	rst Rst18 ; $4a69
	ld [hl], $0a ; $4a6a
	push af ; $4a6c
	ld a, $1e ; $4a6d
	rst Rst18 ; $4a6f
	inc b ; $4a70
	ld a, [bc] ; $4a71
	pop af ; $4a72
	ld a, $08 ; $4a73
	ld d, $02 ; $4a75
	rst Rst18 ; $4a77
	inc [hl] ; $4a78
	ld a, [bc] ; $4a79
	ld a, $08 ; $4a7a
	rst Rst18 ; $4a7c
	ld [hl], $0a ; $4a7d
	ld a, $08 ; $4a7f
	rst Rst18 ; $4a81
	ld [$3e0a], sp ; $4a82
	ld [$0316], sp ; $4a85
	rst Rst18 ; $4a88
	inc [hl] ; $4a89
	ld a, [bc] ; $4a8a
	ld a, $08 ; $4a8b
	rst Rst18 ; $4a8d
	ld [hl], $0a ; $4a8e
	ld a, $08 ; $4a90
	rst Rst18 ; $4a92
	ld [$f50a], sp ; $4a93
	ld a, $5a ; $4a96
	rst Rst18 ; $4a98
	inc b ; $4a99
	ld a, [bc] ; $4a9a
	pop af ; $4a9b
	ld a, $08 ; $4a9c
	ld bc, $1500 ; $4a9e
	ld de, $0980 ; $4aa1
	rst Rst18 ; $4aa4
	inc h ; $4aa5
	ld a, [bc] ; $4aa6
	call Func_13_4d78 ; $4aa7
	ld a, $08 ; $4aaa
	ld bc, $14c0 ; $4aac
	ld de, $0900 ; $4aaf
	rst Rst18 ; $4ab2
	inc h ; $4ab3
	ld a, [bc] ; $4ab4
	ld a, $07 ; $4ab5
	ld bc, $1500 ; $4ab7
	ld de, $0b00 ; $4aba
	rst Rst18 ; $4abd
	inc h ; $4abe
	ld a, [bc] ; $4abf
	ld a, $08 ; $4ac0
	ld bc, $3f00 ; $4ac2
	ld de, $3f00 ; $4ac5
	rst Rst18 ; $4ac8
	ld [hl+], a ; $4ac9
	ld a, [bc] ; $4aca
	ld a, $07 ; $4acb
	rst Rst18 ; $4acd
	jr nz, Label_13_4ada ; $4ace
	push af ; $4ad0
	ld a, $0f ; $4ad1
	rst Rst18 ; $4ad3
	inc b ; $4ad4
	ld a, [bc] ; $4ad5
	pop af ; $4ad6
	ld a, $06 ; $4ad7
	ld b, a ; $4ad9
Label_13_4ada:
	ld a, $07 ; $4ada
	rst Rst18 ; $4adc
	jr nc, Label_13_4ae9 ; $4add
	ld a, $07 ; $4adf
	rst Rst18 ; $4ae1
	ld [$3e0a], sp ; $4ae2
	rlca ; $4ae5
	ld bc, $1500 ; $4ae6
Label_13_4ae9:
	ld de, $0980 ; $4ae9
	rst Rst18 ; $4aec
	inc h ; $4aed
	ld a, [bc] ; $4aee
	ld a, $07 ; $4aef
	rst Rst18 ; $4af1
	jr nz, Label_13_4afe ; $4af2
	ld a, $07 ; $4af4
	ld bc, $14c0 ; $4af6
	ld de, $0900 ; $4af9
	rst Rst18 ; $4afc
	inc h ; $4afd
Label_13_4afe:
	ld a, [bc] ; $4afe
	push af ; $4aff
	ld a, $0f ; $4b00
	rst Rst18 ; $4b02
	inc b ; $4b03
	ld a, [bc] ; $4b04
	pop af ; $4b05
	ld a, $07 ; $4b06
	ld bc, $3f00 ; $4b08
	ld de, $3f00 ; $4b0b
	rst Rst18 ; $4b0e
	ld [hl+], a ; $4b0f
	ld a, [bc] ; $4b10
	call Func_13_4dcc ; $4b11
	xor a, a ; $4b14
	ld bc, $1b00 ; $4b15
	ld de, $0d00 ; $4b18
	rst Rst18 ; $4b1b
	ld a, [hl-] ; $4b1c
	ld a, [bc] ; $4b1d
	push af ; $4b1e
	ld a, $3c ; $4b1f
	rst Rst18 ; $4b21
	inc b ; $4b22
	ld a, [bc] ; $4b23
	pop af ; $4b24
	ld a, $06 ; $4b25
	ld b, a ; $4b27
	ld a, $00 ; $4b28
	rst Rst18 ; $4b2a
	jr nc, Label_13_4b37 ; $4b2b
	push af ; $4b2d
	ld a, $0f ; $4b2e
	rst Rst18 ; $4b30
	inc b ; $4b31
	ld a, [bc] ; $4b32
	pop af ; $4b33
	ld a, $05 ; $4b34
	INCBIN "data/bank_013/d_4b36.bin" ; $4b36, 1 bytes
Label_13_4b37:
	nop ; $4b37
	inc e ; $4b38
	ld de, $0900 ; $4b39
	rst Rst18 ; $4b3c
	ld [hl+], a ; $4b3d
	ld a, [bc] ; $4b3e
	push af ; $4b3f
	ld a, $5a ; $4b40
	rst Rst18 ; $4b42
	inc b ; $4b43
	ld a, [bc] ; $4b44
	pop af ; $4b45
	ld a, $05 ; $4b46
	ld bc, $3f00 ; $4b48
	ld de, $3f00 ; $4b4b
	rst Rst18 ; $4b4e
	ld [hl+], a ; $4b4f
	ld a, [bc] ; $4b50
	push af ; $4b51
	ld a, $0f ; $4b52
	rst Rst18 ; $4b54
	inc b ; $4b55
	ld a, [bc] ; $4b56
	pop af ; $4b57
	ld a, $06 ; $4b58
	rst Rst18 ; $4b5a
	ld [$3e0a], sp ; $4b5b
	nop ; $4b5e
	ld b, a ; $4b5f
	ld a, $06 ; $4b60
	rst Rst18 ; $4b62
	jr nc, Label_13_4b6f ; $4b63
	push af ; $4b65
	ld a, $1e ; $4b66
	rst Rst18 ; $4b68
	inc b ; $4b69
	ld a, [bc] ; $4b6a
	pop af ; $4b6b
	ld a, $06 ; $4b6c
	rst Rst18 ; $4b6e
Label_13_4b6f:
	ld [$3e0a], sp ; $4b6f
	nop ; $4b72
	ld d, $02 ; $4b73
	rst Rst18 ; $4b75
	inc [hl] ; $4b76
	ld a, [bc] ; $4b77
	ld a, $00 ; $4b78
	rst Rst18 ; $4b7a
	ld [hl], $0a ; $4b7b
	push af ; $4b7d
	ld a, $3c ; $4b7e
	rst Rst18 ; $4b80
	inc b ; $4b81
	ld a, [bc] ; $4b82
	pop af ; $4b83
	ld a, $06 ; $4b84
	ld bc, $1500 ; $4b86
	ld de, $0d00 ; $4b89
	rst Rst18 ; $4b8c
	inc h ; $4b8d
	ld a, [bc] ; $4b8e
	ld a, $06 ; $4b8f
	rst Rst18 ; $4b91
	jr nz, Label_13_4b9e ; $4b92
	ld a, $00 ; $4b94
	ld b, a ; $4b96
	ld a, $06 ; $4b97
	rst Rst18 ; $4b99
	jr nc, Label_13_4ba6 ; $4b9a
	push af ; $4b9c
	INCBIN "data/bank_013/d_4b9d.bin" ; $4b9d, 1 bytes
Label_13_4b9e:
	ld e, $df ; $4b9e
	inc b ; $4ba0
	ld a, [bc] ; $4ba1
	pop af ; $4ba2
	ld a, $06 ; $4ba3
	rst Rst18 ; $4ba5
Label_13_4ba6:
	ld [$f50a], sp ; $4ba6
	ld a, $0f ; $4ba9
	rst Rst18 ; $4bab
	inc b ; $4bac
	ld a, [bc] ; $4bad
	pop af ; $4bae
	ld a, $00 ; $4baf
	ld bc, $1700 ; $4bb1
	ld de, $0d00 ; $4bb4
	rst Rst18 ; $4bb7
	inc h ; $4bb8
	ld a, [bc] ; $4bb9
	ld a, $00 ; $4bba
	rst Rst18 ; $4bbc
	jr nz, Label_13_4bc9 ; $4bbd
	push af ; $4bbf
	ld a, $0a ; $4bc0
	rst Rst18 ; $4bc2
	inc b ; $4bc3
	ld a, [bc] ; $4bc4
	pop af ; $4bc5
	ld a, $06 ; $4bc6
	INCBIN "data/bank_013/d_4bc8.bin" ; $4bc8, 1 bytes
Label_13_4bc9:
	nop ; $4bc9
	rlca ; $4bca
	ld de, $0d00 ; $4bcb
	rst Rst18 ; $4bce
	inc h ; $4bcf
	ld a, [bc] ; $4bd0
	push af ; $4bd1
	ld a, $0a ; $4bd2
	rst Rst18 ; $4bd4
	inc b ; $4bd5
	ld a, [bc] ; $4bd6
	pop af ; $4bd7
	xor a, a ; $4bd8
	ld bc, $0900 ; $4bd9
	ld de, $0d00 ; $4bdc
	rst Rst18 ; $4bdf
	ld a, [hl-] ; $4be0
	ld a, [bc] ; $4be1
	ld a, $00 ; $4be2
	ld bc, $0700 ; $4be4
	ld de, $0d00 ; $4be7
	rst Rst18 ; $4bea
	inc h ; $4beb
	ld a, [bc] ; $4bec
	ld a, $06 ; $4bed
	rst Rst18 ; $4bef
	jr nz, Label_13_4bfc ; $4bf0
	ld a, $06 ; $4bf2
	ld b, $c0 ; $4bf4
	rst Rst18 ; $4bf6
	ld l, $0a ; $4bf7
	ld a, $06 ; $4bf9
	INCBIN "data/bank_013/d_4bfb.bin" ; $4bfb, 1 bytes
Label_13_4bfc:
	ret nz ; $4bfc
	ld de, $0500 ; $4bfd
	rst Rst18 ; $4c00
	ld a, [hl+] ; $4c01
	ld a, [bc] ; $4c02
	ld a, $06 ; $4c03
	ld bc, $000b ; $4c05
	rst Rst18 ; $4c08
	jr Label_13_4c15 ; $4c09
	INCBIN "data/bank_013/d_4c0b.bin" ; $4c0b, 10 bytes
Label_13_4c15:
	jr nz, Label_13_4c21 ; $4c15
	ld a, $00 ; $4c17
	ld b, $c0 ; $4c19
	rst Rst18 ; $4c1b
	ld l, $0a ; $4c1c
	ld a, $00 ; $4c1e
	INCBIN "data/bank_013/d_4c20.bin" ; $4c20, 1 bytes
Label_13_4c21:
	ret nz ; $4c21
	ld de, $0500 ; $4c22
	rst Rst18 ; $4c25
	ld a, [hl+] ; $4c26
	ld a, [bc] ; $4c27
	ld a, $00 ; $4c28
	ld bc, $000b ; $4c2a
	rst Rst18 ; $4c2d
	jr Label_13_4c3a ; $4c2e
	INCBIN "data/bank_013/d_4c30.bin" ; $4c30, 10 bytes
Label_13_4c3a:
	inc [hl] ; $4c3a
	ld a, [bc] ; $4c3b
	ld a, $06 ; $4c3c
	ld b, $c0 ; $4c3e
	ld de, $0100 ; $4c40
	rst Rst18 ; $4c43
	ld a, [hl+] ; $4c44
	ld a, [bc] ; $4c45
	ld a, $00 ; $4c46
	rst Rst18 ; $4c48
	jr nz, Label_13_4c55 ; $4c49
	ld a, $00 ; $4c4b
	ld d, $08 ; $4c4d
	rst Rst18 ; $4c4f
	inc [hl] ; $4c50
	ld a, [bc] ; $4c51
	ld a, $00 ; $4c52
	INCBIN "data/bank_013/d_4c54.bin" ; $4c54, 1 bytes
Label_13_4c55:
	ret nz ; $4c55
	ld de, $0100 ; $4c56
	rst Rst18 ; $4c59
	ld a, [hl+] ; $4c5a
	ld a, [bc] ; $4c5b
	ld a, $06 ; $4c5c
	ld bc, $3f00 ; $4c5e
	ld de, $3f00 ; $4c61
	rst Rst18 ; $4c64
	ld [hl+], a ; $4c65
	ld a, [bc] ; $4c66
	ld a, $00 ; $4c67
	ld bc, $3f00 ; $4c69
	ld de, $3f00 ; $4c6c
	rst Rst18 ; $4c6f
	ld [hl+], a ; $4c70
	ld a, [bc] ; $4c71
	ld a, $0e ; $4c72
	ld [$c294], a ; $4c74
	ld [$c2a1], a ; $4c77
	rst Rst18 ; $4c7a
	ld [bc], a ; $4c7b
	ld a, [bc] ; $4c7c
	ret ; $4c7d
	INCBIN "data/bank_013/d_4c7e.bin" ; $4c7e, 250 bytes
Func_13_4d78:
	rst Rst08 ; $4d78
	ld [hl], c ; $4d79
	ld b, $14 ; $4d7a
	ld c, $08 ; $4d7c
	ld d, $06 ; $4d7e
	ld e, $15 ; $4d80
	ld h, $02 ; $4d82
	ld l, $02 ; $4d84
	rst Rst18 ; $4d86
	ld a, [hl] ; $4d87
	ld a, [bc] ; $4d88
	ld b, $00 ; $4d89
	ld c, $15 ; $4d8b
	ld d, $14 ; $4d8d
	ld e, $08 ; $4d8f
	ld h, $02 ; $4d91
	ld l, $02 ; $4d93
	rst Rst18 ; $4d95
	ld a, [hl] ; $4d96
	ld a, [bc] ; $4d97
	push af ; $4d98
	ld a, $02 ; $4d99
	rst Rst18 ; $4d9b
	inc b ; $4d9c
	ld a, [bc] ; $4d9d
	pop af ; $4d9e
	ld b, $02 ; $4d9f
	ld c, $15 ; $4da1
	ld d, $14 ; $4da3
	ld e, $08 ; $4da5
	ld h, $02 ; $4da7
	ld l, $02 ; $4da9
	rst Rst18 ; $4dab
	ld a, [hl] ; $4dac
	ld a, [bc] ; $4dad
	push af ; $4dae
	ld a, $02 ; $4daf
	rst Rst18 ; $4db1
	inc b ; $4db2
	ld a, [bc] ; $4db3
	pop af ; $4db4
	ld b, $04 ; $4db5
	ld c, $15 ; $4db7
	ld d, $14 ; $4db9
	ld e, $08 ; $4dbb
	ld h, $02 ; $4dbd
	ld l, $02 ; $4dbf
	rst Rst18 ; $4dc1
	ld a, [hl] ; $4dc2
	ld a, [bc] ; $4dc3
	push af ; $4dc4
	ld a, $02 ; $4dc5
	rst Rst18 ; $4dc7
	inc b ; $4dc8
	ld a, [bc] ; $4dc9
	pop af ; $4dca
	ret ; $4dcb
Func_13_4dcc:
	rst Rst08 ; $4dcc
	ld [hl], c ; $4dcd
	ld b, $04 ; $4dce
	ld c, $15 ; $4dd0
	ld d, $14 ; $4dd2
	ld e, $08 ; $4dd4
	ld h, $02 ; $4dd6
	ld l, $02 ; $4dd8
	rst Rst18 ; $4dda
	ld a, [hl] ; $4ddb
	ld a, [bc] ; $4ddc
	push af ; $4ddd
	ld a, $01 ; $4dde
	rst Rst18 ; $4de0
	inc b ; $4de1
	ld a, [bc] ; $4de2
	pop af ; $4de3
	ld b, $02 ; $4de4
	ld c, $15 ; $4de6
	ld d, $14 ; $4de8
	ld e, $08 ; $4dea
	ld h, $02 ; $4dec
	ld l, $02 ; $4dee
	rst Rst18 ; $4df0
	ld a, [hl] ; $4df1
	ld a, [bc] ; $4df2
	push af ; $4df3
	ld a, $01 ; $4df4
	rst Rst18 ; $4df6
	inc b ; $4df7
	ld a, [bc] ; $4df8
	pop af ; $4df9
	ld b, $00 ; $4dfa
	ld c, $15 ; $4dfc
	ld d, $14 ; $4dfe
	ld e, $08 ; $4e00
	ld h, $02 ; $4e02
	ld l, $02 ; $4e04
	rst Rst18 ; $4e06
	ld a, [hl] ; $4e07
	ld a, [bc] ; $4e08
	push af ; $4e09
	ld a, $01 ; $4e0a
	rst Rst18 ; $4e0c
	inc b ; $4e0d
	ld a, [bc] ; $4e0e
	pop af ; $4e0f
	ld b, $06 ; $4e10
	ld c, $15 ; $4e12
	ld d, $14 ; $4e14
	ld e, $08 ; $4e16
	ld h, $02 ; $4e18
	ld l, $02 ; $4e1a
	rst Rst18 ; $4e1c
	ld a, [hl] ; $4e1d
	ld a, [bc] ; $4e1e
	ret ; $4e1f
	INCBIN "data/bank_013/d_4e20.bin" ; $4e20, 583 bytes
Func_13_5067:
	rst Rst30 ; $5067
	ldh [rTIMA], a ; $5068
	jr nz, Label_13_507c ; $506a
	rst Rst30 ; $506c
	nop ; $506d
	dec bc ; $506e
	jr nz, Label_13_5074 ; $506f
	jr Label_13_50de ; $5071
	INCBIN "data/bank_013/d_5073.bin" ; $5073, 1 bytes
Label_13_5074:
	rst Rst30 ; $5074
	ret nz ; $5075
	dec d ; $5076
	jr z, Label_13_508c ; $5077
	jr Label_13_50de ; $5079
	INCBIN "data/bank_013/d_507b.bin" ; $507b, 1 bytes
Label_13_507c:
	rst Rst30 ; $507c
	nop ; $507d
	add hl, bc ; $507e
	jr nz, Label_13_5084 ; $507f
	jr Label_13_50de ; $5081
	INCBIN "data/bank_013/d_5083.bin" ; $5083, 1 bytes
Label_13_5084:
	rst Rst30 ; $5084
	ldh [$ff15], a ; $5085
	jr z, Label_13_508c ; $5087
	jr Label_13_50de ; $5089
	INCBIN "data/bank_013/d_508b.bin" ; $508b, 1 bytes
Label_13_508c:
	ld a, $f1 ; $508c
	ld d, $08 ; $508e
	ld e, $0e ; $5090
	rst Rst18 ; $5092
	adc a, d ; $5093
	ld a, [bc] ; $5094
	ld a, $f1 ; $5095
	ld d, $0a ; $5097
	ld e, $0e ; $5099
	rst Rst18 ; $509b
	adc a, d ; $509c
	ld a, [bc] ; $509d
	ld a, $f1 ; $509e
	ld d, $0c ; $50a0
	ld e, $0e ; $50a2
	rst Rst18 ; $50a4
	adc a, d ; $50a5
	ld a, [bc] ; $50a6
	ld a, $f1 ; $50a7
	ld d, $08 ; $50a9
	ld e, $10 ; $50ab
	rst Rst18 ; $50ad
	adc a, d ; $50ae
	ld a, [bc] ; $50af
	ld a, $f1 ; $50b0
	ld d, $0a ; $50b2
	ld e, $10 ; $50b4
	rst Rst18 ; $50b6
	adc a, d ; $50b7
	ld a, [bc] ; $50b8
	ld a, $f1 ; $50b9
	ld d, $0c ; $50bb
	ld e, $10 ; $50bd
	rst Rst18 ; $50bf
	adc a, d ; $50c0
	ld a, [bc] ; $50c1
	ld a, $f1 ; $50c2
	ld d, $08 ; $50c4
	ld e, $12 ; $50c6
	rst Rst18 ; $50c8
	adc a, d ; $50c9
	ld a, [bc] ; $50ca
	ld a, $f1 ; $50cb
	ld d, $0a ; $50cd
	ld e, $12 ; $50cf
	rst Rst18 ; $50d1
	adc a, d ; $50d2
	ld a, [bc] ; $50d3
	ld a, $f1 ; $50d4
	ld d, $0c ; $50d6
	ld e, $12 ; $50d8
	rst Rst18 ; $50da
	adc a, d ; $50db
	ld a, [bc] ; $50dc
	ret ; $50dd
Label_13_50de:
	ld a, $00 ; $50de
	ld d, $08 ; $50e0
	ld e, $0e ; $50e2
	rst Rst18 ; $50e4
	adc a, d ; $50e5
	ld a, [bc] ; $50e6
	ld a, $00 ; $50e7
	ld d, $0a ; $50e9
	ld e, $0e ; $50eb
	rst Rst18 ; $50ed
	adc a, d ; $50ee
	ld a, [bc] ; $50ef
	ld a, $00 ; $50f0
	ld d, $0c ; $50f2
	ld e, $0e ; $50f4
	rst Rst18 ; $50f6
	adc a, d ; $50f7
	ld a, [bc] ; $50f8
	ld a, $00 ; $50f9
	ld d, $08 ; $50fb
	ld e, $10 ; $50fd
	rst Rst18 ; $50ff
	adc a, d ; $5100
	ld a, [bc] ; $5101
	ld a, $00 ; $5102
	ld d, $0a ; $5104
	ld e, $10 ; $5106
	rst Rst18 ; $5108
	adc a, d ; $5109
	ld a, [bc] ; $510a
	ld a, $00 ; $510b
	ld d, $0c ; $510d
	ld e, $10 ; $510f
	rst Rst18 ; $5111
	adc a, d ; $5112
	ld a, [bc] ; $5113
	ld a, $00 ; $5114
	ld d, $08 ; $5116
	ld e, $12 ; $5118
	rst Rst18 ; $511a
	adc a, d ; $511b
	ld a, [bc] ; $511c
	ld a, $00 ; $511d
	ld d, $0a ; $511f
	ld e, $12 ; $5121
	rst Rst18 ; $5123
	adc a, d ; $5124
	ld a, [bc] ; $5125
	ld a, $00 ; $5126
	ld d, $0c ; $5128
	ld e, $12 ; $512a
	rst Rst18 ; $512c
	adc a, d ; $512d
	ld a, [bc] ; $512e
	ret ; $512f
	INCBIN "data/bank_013/d_5130.bin" ; $5130, 722 bytes
	rst Rst18 ; $5402
	inc b ; $5403
	ld a, [bc] ; $5404
	pop af ; $5405
	ld a, $03 ; $5406
	rst Rst18 ; $5408
	ld a, [bc] ; $5409
	ld a, [bc] ; $540a
	rst Rst18 ; $540b
	ld [de], a ; $540c
	ld a, [bc] ; $540d
	rst Rst18 ; $540e
	inc c ; $540f
	ld a, [bc] ; $5410
	push af ; $5411
	ld a, $05 ; $5412
	rst Rst18 ; $5414
	inc b ; $5415
	ld a, [bc] ; $5416
	pop af ; $5417
	and a, a ; $5418
	jr nz, Label_13_5425 ; $5419
	ld a, $03 ; $541b
	rst Rst18 ; $541d
	ld [$df0a], sp ; $541e
	INCBIN "data/bank_013/d_5421.bin" ; $5421, 4 bytes
Label_13_5425:
	rst Rst18 ; $5425
	INCBIN "data/bank_013/d_5426.bin" ; $5426, 153 bytes
	rst Rst18 ; $54bf
	jr nz, Label_13_54cc ; $54c0
	ld a, $03 ; $54c2
	ld d, $02 ; $54c4
	rst Rst18 ; $54c6
	inc [hl] ; $54c7
	ld a, [bc] ; $54c8
	ld a, $03 ; $54c9
	rst Rst18 ; $54cb
Label_13_54cc:
	ld [hl], $0a ; $54cc
	ld a, $03 ; $54ce
	rst Rst18 ; $54d0
	ld [$3e0a], sp ; $54d1
	inc bc ; $54d4
	ld d, $03 ; $54d5
	rst Rst18 ; $54d7
	inc [hl] ; $54d8
	ld a, [bc] ; $54d9
	ld a, $03 ; $54da
	rst Rst18 ; $54dc
	ld [hl], $0a ; $54dd
	ld a, $03 ; $54df
	rst Rst18 ; $54e1
	ld [$3e0a], sp ; $54e2
	inc bc ; $54e5
	ld d, $03 ; $54e6
	rst Rst18 ; $54e8
	inc [hl] ; $54e9
	ld a, [bc] ; $54ea
	ld a, $03 ; $54eb
	rst Rst18 ; $54ed
	ld [hl], $0a ; $54ee
	ld a, $03 ; $54f0
	rst Rst18 ; $54f2
	ld a, [bc] ; $54f3
	ld a, [bc] ; $54f4
	rst Rst18 ; $54f5
	ld [de], a ; $54f6
	ld a, [bc] ; $54f7
	rst Rst18 ; $54f8
	inc c ; $54f9
	ld a, [bc] ; $54fa
	push af ; $54fb
	ld a, $05 ; $54fc
	rst Rst18 ; $54fe
	inc b ; $54ff
	ld a, [bc] ; $5500
	pop af ; $5501
	and a, a ; $5502
	jr nz, Label_13_5508 ; $5503
	call Func_13_58be ; $5505
Label_13_5508:
	rst Rst30 ; $5508
	nop ; $5509
	inc e ; $550a
	jr nz, Label_13_5550 ; $550b
	rst Rst30 ; $550d
	jr nz, Label_13_552c ; $550e
	jr nz, Label_13_5531 ; $5510
	push af ; $5512
	ld a, $14 ; $5513
	rst Rst18 ; $5515
	inc b ; $5516
	ld a, [bc] ; $5517
	pop af ; $5518
	ld a, $03 ; $5519
	ld d, $03 ; $551b
	rst Rst18 ; $551d
	inc [hl] ; $551e
	ld a, [bc] ; $551f
	ld a, $03 ; $5520
	rst Rst18 ; $5522
	ld [hl], $0a ; $5523
	ld hl, $0500 ; $5525
	rst Rst18 ; $5528
	ld c, $0a ; $5529
	INCBIN "data/bank_013/d_552b.bin" ; $552b, 1 bytes
Label_13_552c:
	inc bc ; $552c
	rst Rst18 ; $552d
	ld [$c90a], sp ; $552e
Label_13_5531:
	push af ; $5531
	ld a, $14 ; $5532
	rst Rst18 ; $5534
	inc b ; $5535
	ld a, [bc] ; $5536
	pop af ; $5537
	ld a, $03 ; $5538
	ld d, $03 ; $553a
	rst Rst18 ; $553c
	inc [hl] ; $553d
	ld a, [bc] ; $553e
	ld a, $03 ; $553f
	rst Rst18 ; $5541
	ld [hl], $0a ; $5542
	ld hl, $0501 ; $5544
	rst Rst18 ; $5547
	ld c, $0a ; $5548
	ld a, $03 ; $554a
	rst Rst18 ; $554c
	ld [$c90a], sp ; $554d
Label_13_5550:
	rst Rst30 ; $5550
	jr nz, Label_13_556f ; $5551
	jr nz, Label_13_5574 ; $5553
	push af ; $5555
	ld a, $14 ; $5556
	rst Rst18 ; $5558
	inc b ; $5559
	ld a, [bc] ; $555a
	pop af ; $555b
	ld a, $03 ; $555c
	ld d, $03 ; $555e
	rst Rst18 ; $5560
	inc [hl] ; $5561
	ld a, [bc] ; $5562
	ld a, $03 ; $5563
	rst Rst18 ; $5565
	ld [hl], $0a ; $5566
	ld hl, $0523 ; $5568
	rst Rst18 ; $556b
	ld c, $0a ; $556c
	INCBIN "data/bank_013/d_556e.bin" ; $556e, 1 bytes
Label_13_556f:
	inc bc ; $556f
	rst Rst18 ; $5570
	ld [$c90a], sp ; $5571
Label_13_5574:
	push af ; $5574
	ld a, $14 ; $5575
	rst Rst18 ; $5577
	inc b ; $5578
	ld a, [bc] ; $5579
	pop af ; $557a
	ld a, $03 ; $557b
	ld d, $03 ; $557d
	rst Rst18 ; $557f
	inc [hl] ; $5580
	ld a, [bc] ; $5581
	ld a, $03 ; $5582
	rst Rst18 ; $5584
	ld [hl], $0a ; $5585
	ld hl, $0522 ; $5587
	rst Rst18 ; $558a
	ld c, $0a ; $558b
	ld a, $03 ; $558d
	rst Rst18 ; $558f
	ld [$c90a], sp ; $5590
	rst Rst30 ; $5593
	nop ; $5594
	inc e ; $5595
	jr z, Label_13_55a3 ; $5596
	ld hl, $c2b2 ; $5598
	ld de, $052a ; $559b
	ld a, e ; $559e
	ld [hl+], a ; $559f
	ld [hl], d ; $55a0
	jr Label_13_55ac ; $55a1
Label_13_55a3:
	ld hl, $c2b2 ; $55a3
	ld de, $0524 ; $55a6
	ld a, e ; $55a9
	ld [hl+], a ; $55aa
	ld [hl], d ; $55ab
Label_13_55ac:
	ld hl, $c2b2 ; $55ac
	ld a, [hl+] ; $55af
	ld h, [hl] ; $55b0
	ld l, a ; $55b1
	rst Rst18 ; $55b2
	ld c, $0a ; $55b3
	rst Rst30 ; $55b5
	ldh [rTIMA], a ; $55b6
	jr z, Label_13_55bd ; $55b8
	rst Rst18 ; $55ba
	INCBIN "data/bank_013/d_55bb.bin" ; $55bb, 2 bytes
Label_13_55bd:
	push af ; $55bd
	ld a, $1e ; $55be
	rst Rst18 ; $55c0
	inc b ; $55c1
	ld a, [bc] ; $55c2
	pop af ; $55c3
	ld a, $00 ; $55c4
	ld bc, $0b00 ; $55c6
	ld de, $0e00 ; $55c9
	rst Rst18 ; $55cc
	inc h ; $55cd
	ld a, [bc] ; $55ce
	ld c, $04 ; $55cf
	call Func_00_1d2e ; $55d1
	call Func_00_1da4 ; $55d4
	xor a, a ; $55d7
	ld bc, $0b00 ; $55d8
	ld de, $0c40 ; $55db
	rst Rst18 ; $55de
	ld a, [hl-] ; $55df
	ld a, [bc] ; $55e0
	rst Rst18 ; $55e1
	ld a, $0a ; $55e2
	ld a, $03 ; $55e4
	ld b, $40 ; $55e6
	rst Rst18 ; $55e8
	ld l, $0a ; $55e9
	ld a, $03 ; $55eb
	ld d, $03 ; $55ed
	rst Rst18 ; $55ef
	inc [hl] ; $55f0
	ld a, [bc] ; $55f1
	ld a, $03 ; $55f2
	rst Rst18 ; $55f4
	ld [hl], $0a ; $55f5
	ld a, $03 ; $55f7
	rst Rst18 ; $55f9
	ld [$cd0a], sp ; $55fa
	jp z, $a75a ; $55fd
	jp z, Label_13_560d ; $5600
	ld hl, $c2b2 ; $5603
	ld a, [hl+] ; $5606
	ld h, [hl] ; $5607
	ld l, a ; $5608
	ld a, $05 ; $5609
	jr Label_13_5615 ; $560b
Label_13_560d:
	ld hl, $c2b2 ; $560d
	ld a, [hl+] ; $5610
	ld h, [hl] ; $5611
	ld l, a ; $5612
	ld a, $02 ; $5613
Label_13_5615:
	add a, l ; $5615
	ld l, a ; $5616
	jr nc, Label_13_561a ; $5617
	inc h ; $5619
Label_13_561a:
	rst Rst18 ; $561a
	ld c, $0a ; $561b
	ld a, $03 ; $561d
	ld d, $04 ; $561f
	rst Rst18 ; $5621
	inc [hl] ; $5622
	ld a, [bc] ; $5623
	ld a, $03 ; $5624
	rst Rst18 ; $5626
	ld [hl], $0a ; $5627
	ld a, $03 ; $5629
	rst Rst18 ; $562b
	ld a, [bc] ; $562c
	ld a, [bc] ; $562d
	rst Rst18 ; $562e
	ld [de], a ; $562f
	ld a, [bc] ; $5630
	rst Rst18 ; $5631
	inc c ; $5632
	ld a, [bc] ; $5633
	push af ; $5634
	ld a, $05 ; $5635
	rst Rst18 ; $5637
	inc b ; $5638
	ld a, [bc] ; $5639
	pop af ; $563a
	and a, a ; $563b
	jr nz, Label_13_568f ; $563c
	ld hl, $c2b2 ; $563e
	ld a, [hl+] ; $5641
	ld h, [hl] ; $5642
	ld l, a ; $5643
	ld a, $03 ; $5644
	add a, l ; $5646
	ld l, a ; $5647
	jr nc, Label_13_564b ; $5648
	inc h ; $564a
Label_13_564b:
	rst Rst18 ; $564b
	ld c, $0a ; $564c
	ld a, $03 ; $564e
	rst Rst18 ; $5650
	ld [$cf0a], sp ; $5651
	nop ; $5654
	push af ; $5655
	ld a, $02 ; $5656
	rst Rst18 ; $5658
	inc b ; $5659
	ld a, [bc] ; $565a
	pop af ; $565b
	rst Rst08 ; $565c
	ld b, c ; $565d
	ld a, $00 ; $565e
	ld d, $03 ; $5660
	rst Rst18 ; $5662
	inc [hl] ; $5663
	ld a, [bc] ; $5664
	ld a, $03 ; $5665
	ld d, $03 ; $5667
	rst Rst18 ; $5669
	inc [hl] ; $566a
	ld a, [bc] ; $566b
	ld a, $03 ; $566c
	rst Rst18 ; $566e
	ld [hl], $0a ; $566f
	call Func_00_302a ; $5671
	ld c, $04 ; $5674
	call Func_00_1d20 ; $5676
	call Func_00_1da4 ; $5679
	ld a, $02 ; $567c
	ld [$c294], a ; $567e
	ld [$c2a1], a ; $5681
	ld b, $0a ; $5684
	ld c, $01 ; $5686
	rst Rst18 ; $5688
	ld h, d ; $5689
	ld a, [bc] ; $568a
	rst Rst18 ; $568b
	jr $5691 ; $568c
	INCBIN "data/bank_013/d_568e.bin" ; $568e, 1 bytes
Label_13_568f:
	ld hl, $c2b2 ; $568f
	ld a, [hl+] ; $5692
	ld h, [hl] ; $5693
	ld l, a ; $5694
	ld a, $04 ; $5695
	add a, l ; $5697
	ld l, a ; $5698
	jr nc, Label_13_569c ; $5699
	inc h ; $569b
Label_13_569c:
	rst Rst18 ; $569c
	ld c, $0a ; $569d
	ld a, $03 ; $569f
	rst Rst18 ; $56a1
	ld a, [bc] ; $56a2
	ld a, [bc] ; $56a3
	rst Rst18 ; $56a4
	ld [de], a ; $56a5
	ld a, [bc] ; $56a6
	rst Rst18 ; $56a7
	inc c ; $56a8
	ld a, [bc] ; $56a9
	push af ; $56aa
	ld a, $05 ; $56ab
	rst Rst18 ; $56ad
	inc b ; $56ae
	ld a, [bc] ; $56af
	pop af ; $56b0
	and a, a ; $56b1
	jr nz, Label_13_56b7 ; $56b2
	call Func_13_58be ; $56b4
Label_13_56b7:
	call Func_13_56bb ; $56b7
	ret ; $56ba
Func_13_56bb:
	rst Rst30 ; $56bb
	ldh [rTIMA], a ; $56bc
	jp nz, Label_13_5782 ; $56be
	rst Rst30 ; $56c1
	nop ; $56c2
	inc e ; $56c3
	jr nz, Label_13_56ce ; $56c4
	ld hl, $0536 ; $56c6
	rst Rst18 ; $56c9
	ld c, $0a ; $56ca
	jr Label_13_56d4 ; $56cc
Label_13_56ce:
	ld hl, $0530 ; $56ce
	rst Rst18 ; $56d1
	ld c, $0a ; $56d2
Label_13_56d4:
	ld a, $03 ; $56d4
	rst Rst18 ; $56d6
	ld a, [bc] ; $56d7
	ld a, [bc] ; $56d8
	rst Rst18 ; $56d9
	ld [de], a ; $56da
	ld a, [bc] ; $56db
	rst Rst18 ; $56dc
	inc c ; $56dd
	ld a, [bc] ; $56de
	push af ; $56df
	ld a, $05 ; $56e0
	rst Rst18 ; $56e2
	inc b ; $56e3
	ld a, [bc] ; $56e4
	pop af ; $56e5
	and a, a ; $56e6
	jr nz, Label_13_574c ; $56e7
	rst Rst20 ; $56e9
	ldh [rTIMA], a ; $56ea
	call Func_13_5bdf ; $56ec
	ld a, $03 ; $56ef
	rst Rst18 ; $56f1
	ld [$3e0a], sp ; $56f2
	nop ; $56f5
	ld d, $03 ; $56f6
	rst Rst18 ; $56f8
	inc [hl] ; $56f9
	ld a, [bc] ; $56fa
	ld a, $00 ; $56fb
	rst Rst18 ; $56fd
	ld [hl], $0a ; $56fe
	push af ; $5700
	ld a, $05 ; $5701
	rst Rst18 ; $5703
	inc b ; $5704
	ld a, [bc] ; $5705
	pop af ; $5706
	ld a, $00 ; $5707
	ld b, $40 ; $5709
	rst Rst18 ; $570b
	ld l, $0a ; $570c
	ld a, $04 ; $570e
	ldh [$ff96], a ; $5710
	ldh [rWBK], a ; $5712
	ld a, $01 ; $5714
	ld [$c8f2], a ; $5716
	call Func_13_5067 ; $5719
	push af ; $571c
	ld a, $05 ; $571d
	rst Rst18 ; $571f
	inc b ; $5720
	ld a, [bc] ; $5721
	pop af ; $5722
	ld a, $03 ; $5723
	rst Rst18 ; $5725
	ld d, $0a ; $5726
	ld c, l ; $5728
	ld b, h ; $5729
	ld de, $d000 ; $572a
	rst Rst18 ; $572d
	jr nz, Label_13_5734 ; $572e
	ld a, $03 ; $5730
	rst Rst18 ; $5732
	INCBIN "data/bank_013/d_5733.bin" ; $5733, 1 bytes
Label_13_5734:
	ld a, [bc] ; $5734
	ld c, l ; $5735
	ld b, h ; $5736
	ld hl, $0005 ; $5737
	add hl, bc ; $573a
	set 4, [hl] ; $573b
	push af ; $573d
	ld a, $05 ; $573e
	rst Rst18 ; $5740
	inc b ; $5741
	ld a, [bc] ; $5742
	pop af ; $5743
	ld a, $00 ; $5744
	ld b, $40 ; $5746
	rst Rst18 ; $5748
	ld l, $0a ; $5749
	ret ; $574b
Label_13_574c:
	call Func_13_5b8b ; $574c
	rst Rst18 ; $574f
	INCBIN "data/bank_013/d_5750.bin" ; $5750, 50 bytes
Label_13_5782:
	rst Rst30 ; $5782
	nop ; $5783
	inc e ; $5784
	jr nz, Label_13_578f ; $5785
	ld hl, $0539 ; $5787
	rst Rst18 ; $578a
	ld c, $0a ; $578b
	jr Label_13_5795 ; $578d
Label_13_578f:
	ld hl, $0533 ; $578f
	rst Rst18 ; $5792
	ld c, $0a ; $5793
Label_13_5795:
	ld a, $03 ; $5795
	rst Rst18 ; $5797
	ld a, [bc] ; $5798
	ld a, [bc] ; $5799
	rst Rst18 ; $579a
	ld [de], a ; $579b
	ld a, [bc] ; $579c
	rst Rst18 ; $579d
	inc c ; $579e
	ld a, [bc] ; $579f
	push af ; $57a0
	ld a, $05 ; $57a1
	rst Rst18 ; $57a3
	inc b ; $57a4
	ld a, [bc] ; $57a5
	pop af ; $57a6
	and a, a ; $57a7
	jr nz, Label_13_5807 ; $57a8
	call Func_13_5bc3 ; $57aa
	ld a, $03 ; $57ad
	rst Rst18 ; $57af
	ld [$3e0a], sp ; $57b0
	inc bc ; $57b3
	rst Rst18 ; $57b4
	inc e ; $57b5
	ld a, [bc] ; $57b6
	rst Rst28 ; $57b7
	ldh [rTIMA], a ; $57b8
	ld a, $04 ; $57ba
	ldh [$ff96], a ; $57bc
	ldh [rWBK], a ; $57be
	ld a, $00 ; $57c0
	ld [$c8f2], a ; $57c2
	ld a, $03 ; $57c5
	ld bc, $0b00 ; $57c7
	ld de, $0900 ; $57ca
	rst Rst18 ; $57cd
	inc h ; $57ce
	ld a, [bc] ; $57cf
	ld a, $03 ; $57d0
	rst Rst18 ; $57d2
	jr nz, Label_13_57df ; $57d3
	push af ; $57d5
	ld a, $05 ; $57d6
	rst Rst18 ; $57d8
	inc b ; $57d9
	ld a, [bc] ; $57da
	pop af ; $57db
	ld a, $03 ; $57dc
	INCBIN "data/bank_013/d_57de.bin" ; $57de, 1 bytes
Label_13_57df:
	ld b, b ; $57df
	rst Rst18 ; $57e0
	ld l, $0a ; $57e1
	push af ; $57e3
	ld a, $05 ; $57e4
	rst Rst18 ; $57e6
	inc b ; $57e7
	ld a, [bc] ; $57e8
	pop af ; $57e9
	ld a, $03 ; $57ea
	rst Rst18 ; $57ec
	ld d, $0a ; $57ed
	ld c, l ; $57ef
	ld b, h ; $57f0
	ld hl, $0005 ; $57f1
	add hl, bc ; $57f4
	set 3, [hl] ; $57f5
	call Func_13_5067 ; $57f7
	ld a, $03 ; $57fa
	rst Rst18 ; $57fc
	inc e ; $57fd
	ld a, [bc] ; $57fe
	ld a, $03 ; $57ff
	ld b, $40 ; $5801
	rst Rst18 ; $5803
	ld l, $0a ; $5804
	ret ; $5806
Label_13_5807:
	call Func_13_5ba7 ; $5807
	rst Rst18 ; $580a
	INCBIN "data/bank_013/d_580b.bin" ; $580b, 179 bytes
Func_13_58be:
	rst Rst30 ; $58be
	nop ; $58bf
	inc e ; $58c0
	jr z, Label_13_58cb ; $58c1
	ld hl, $c2b2 ; $58c3
	ld de, $054f ; $58c6
	jr Label_13_58d1 ; $58c9
Label_13_58cb:
	ld hl, $c2b2 ; $58cb
	ld de, $0808 ; $58ce
Label_13_58d1:
	ld a, e ; $58d1
	ld [hl+], a ; $58d2
	ld [hl], d ; $58d3
	ld hl, $054c ; $58d4
	rst Rst30 ; $58d7
	ldh [$ff0a], a ; $58d8
	jr z, Label_13_58e7 ; $58da
	ld hl, $054d ; $58dc
	rst Rst30 ; $58df
	nop ; $58e0
	dec bc ; $58e1
	jr z, Label_13_58e7 ; $58e2
	ld hl, $054e ; $58e4
Label_13_58e7:
	ld de, $0101 ; $58e7
	ld a, $01 ; $58ea
	rst Rst18 ; $58ec
	ld a, $05 ; $58ed
	cp a, $ff ; $58ef
	jp z, Label_13_5927 ; $58f1
	add a, a ; $58f4
	add a, $28 ; $58f5
	ld l, a ; $58f7
	adc a, $59 ; $58f8
	sub a, l ; $58fa
	ld h, a ; $58fb
	ld a, [hl+] ; $58fc
	ld h, [hl] ; $58fd
	ld l, a ; $58fe
	call JumpToHL ; $58ff
	ld a, $03 ; $5902
	rst Rst18 ; $5904
	ld [$210a], sp ; $5905
	or a, d ; $5908
	jp nz, Label_13_662a ; $5909
	ld l, a ; $590c
	rst Rst18 ; $590d
	ld c, $0a ; $590e
	ld a, $03 ; $5910
	rst Rst18 ; $5912
	ld a, [bc] ; $5913
	ld a, [bc] ; $5914
	rst Rst18 ; $5915
	ld [de], a ; $5916
	ld a, [bc] ; $5917
	rst Rst18 ; $5918
	inc c ; $5919
	ld a, [bc] ; $591a
	push af ; $591b
	ld a, $05 ; $591c
	rst Rst18 ; $591e
	inc b ; $591f
	ld a, [bc] ; $5920
	pop af ; $5921
	and a, a ; $5922
	jr nz, Label_13_5927 ; $5923
	jr Label_13_58d1 ; $5925
Label_13_5927:
	ret ; $5927
	INCBIN "data/bank_013/d_5928.bin" ; $5928, 418 bytes
Func_13_5aca:
	rst Rst30 ; $5aca
	ldh [rTIMA], a ; $5acb
	jr nz, Label_13_5ae2 ; $5acd
	rst Rst30 ; $5acf
	nop ; $5ad0
	ld d, $20 ; $5ad1
	dec bc ; $5ad3
	rst Rst30 ; $5ad4
	ret nz ; $5ad5
	dec d ; $5ad6
	jr nz, Label_13_5adc ; $5ad7
Label_13_5ad9:
	ld a, $00 ; $5ad9
	ret ; $5adb
Label_13_5adc:
	ld a, $01 ; $5adc
	ret ; $5ade
Label_13_5adf:
	ld a, $02 ; $5adf
	ret ; $5ae1
Label_13_5ae2:
	rst Rst30 ; $5ae2
	jr nz, Label_13_5afb ; $5ae3
	jr nz, Label_13_5adf ; $5ae5
	rst Rst30 ; $5ae7
	ldh [$ff15], a ; $5ae8
	jr nz, Label_13_5adc ; $5aea
	jr Label_13_5ad9 ; $5aec
	INCBIN "data/bank_013/d_5aee.bin" ; $5aee, 13 bytes
Label_13_5afb:
	ld hl, $050c ; $5afb
	rst Rst18 ; $5afe
	ld c, $0a ; $5aff
	ld a, $02 ; $5b01
	rst Rst18 ; $5b03
	inc e ; $5b04
	ld a, [bc] ; $5b05
	ld a, $02 ; $5b06
	ld bc, $0b00 ; $5b08
	ld de, $1e00 ; $5b0b
	rst Rst18 ; $5b0e
	ld [hl+], a ; $5b0f
	ld a, [bc] ; $5b10
	ld a, $02 ; $5b11
	ld b, $40 ; $5b13
	rst Rst18 ; $5b15
	ld l, $0a ; $5b16
	ld a, $03 ; $5b18
	ld bc, $0b00 ; $5b1a
	ld de, $0a00 ; $5b1d
	rst Rst18 ; $5b20
	ld [hl+], a ; $5b21
	ld a, [bc] ; $5b22
	ld a, $03 ; $5b23
	ld b, $40 ; $5b25
	rst Rst18 ; $5b27
	ld l, $0a ; $5b28
	ld c, $04 ; $5b2a
	call Func_00_1d2e ; $5b2c
	call Func_00_1da4 ; $5b2f
	rst Rst30 ; $5b32
	ldh [rTIMA], a ; $5b33
	jr z, Label_13_5b79 ; $5b35
	rst Rst18 ; $5b37
	INCBIN "data/bank_013/d_5b38.bin" ; $5b38, 65 bytes
Label_13_5b79:
	ld a, $03 ; $5b79
	rst Rst18 ; $5b7b
	ld [$3e0a], sp ; $5b7c
	nop ; $5b7f
	ld d, $03 ; $5b80
	rst Rst18 ; $5b82
	inc [hl] ; $5b83
	ld a, [bc] ; $5b84
	ld a, $00 ; $5b85
	rst Rst18 ; $5b87
	ld [hl], $0a ; $5b88
	ret ; $5b8a
Func_13_5b8b:
	call Func_13_5aca ; $5b8b
	cp a, $01 ; $5b8e
	jp nz, Label_13_5ba6 ; $5b90
	rst Rst30 ; $5b93
	nop ; $5b94
	inc e ; $5b95
	jr z, Label_13_5ba0 ; $5b96
	ld hl, $0513 ; $5b98
	rst Rst18 ; $5b9b
	ld c, $0a ; $5b9c
	jr Label_13_5ba6 ; $5b9e
Label_13_5ba0:
	ld hl, $050e ; $5ba0
	rst Rst18 ; $5ba3
	ld c, $0a ; $5ba4
Label_13_5ba6:
	ret ; $5ba6
Func_13_5ba7:
	call Func_13_5aca ; $5ba7
	cp a, $01 ; $5baa
	jp nz, Label_13_5bc2 ; $5bac
	rst Rst30 ; $5baf
	nop ; $5bb0
	inc e ; $5bb1
	jr z, Label_13_5bbc ; $5bb2
	ld hl, $0514 ; $5bb4
	rst Rst18 ; $5bb7
	ld c, $0a ; $5bb8
	jr Label_13_5bc2 ; $5bba
Label_13_5bbc:
	ld hl, $050f ; $5bbc
	rst Rst18 ; $5bbf
	ld c, $0a ; $5bc0
Label_13_5bc2:
	ret ; $5bc2
Func_13_5bc3:
	call Func_13_5aca ; $5bc3
	cp a, $01 ; $5bc6
	jp nz, Label_13_5bde ; $5bc8
	rst Rst30 ; $5bcb
	nop ; $5bcc
	inc e ; $5bcd
	jr z, Label_13_5bd8 ; $5bce
	ld hl, $0514 ; $5bd0
	rst Rst18 ; $5bd3
	ld c, $0a ; $5bd4
	jr Label_13_5bde ; $5bd6
Label_13_5bd8:
	ld hl, $050f ; $5bd8
	rst Rst18 ; $5bdb
	ld c, $0a ; $5bdc
Label_13_5bde:
	ret ; $5bde
Func_13_5bdf:
	call Func_13_5aca ; $5bdf
	cp a, $01 ; $5be2
	jp nz, Label_13_5bfa ; $5be4
	rst Rst30 ; $5be7
	nop ; $5be8
	inc e ; $5be9
	jr z, Label_13_5bf4 ; $5bea
	ld hl, $0515 ; $5bec
	rst Rst18 ; $5bef
	ld c, $0a ; $5bf0
	jr Label_13_5bfa ; $5bf2
Label_13_5bf4:
	ld hl, $0510 ; $5bf4
	rst Rst18 ; $5bf7
	ld c, $0a ; $5bf8
Label_13_5bfa:
	ret ; $5bfa
	INCBIN "data/bank_013/d_5bfb.bin" ; $5bfb, 1731 bytes
Func_13_62be:
	ld a, [$c94d] ; $62be
	or a, a ; $62c1
	jr nz, Label_13_62da ; $62c2
	ld d, $28 ; $62c4
	ld a, $0d ; $62c6
	rst Rst18 ; $62c8
	ld d, $0a ; $62c9
	ld c, l ; $62cb
	ld b, h ; $62cc
	rst Rst18 ; $62cd
	inc l ; $62ce
	inc b ; $62cf
	ld a, $0d ; $62d0
	ld d, $01 ; $62d2
	rst Rst18 ; $62d4
	inc [hl] ; $62d5
	ld a, [bc] ; $62d6
	rst Rst20 ; $62d7
	nop ; $62d8
	inc e ; $62d9
Label_13_62da:
	ret ; $62da
	INCBIN "data/bank_013/d_62db.bin" ; $62db, 847 bytes
Label_13_662a:
	ld a, $00 ; $662a
	rst Rst18 ; $662c
	jr nz, Label_13_6639 ; $662d
	ld a, $0f ; $662f
	ld [$c294], a ; $6631
	ld [$c2a1], a ; $6634
	ret ; $6637
	INCBIN "data/bank_013/d_6638.bin" ; $6638, 1 bytes
Label_13_6639:
	nop ; $6639
	dec h ; $663a
	ld a, e ; $663b
	nop ; $663c
	INCBIN "data/bank_013/d_663d.bin" ; $663d, 2341 bytes
	rst Rst18 ; $6f62
	jr nz, Label_13_6f6f ; $6f63
	ld a, $04 ; $6f65
	ld b, $c0 ; $6f67
	rst Rst18 ; $6f69
	ld l, $0a ; $6f6a
	ld a, $09 ; $6f6c
	INCBIN "data/bank_013/d_6f6e.bin" ; $6f6e, 1 bytes
Label_13_6f6f:
	ret nz ; $6f6f
	rst Rst18 ; $6f70
	ld l, $0a ; $6f71
	ld a, $00 ; $6f73
	ld b, $c0 ; $6f75
	rst Rst18 ; $6f77
	ld l, $0a ; $6f78
	ld a, $02 ; $6f7a
	ld b, $c0 ; $6f7c
	rst Rst18 ; $6f7e
	ld l, $0a ; $6f7f
	push af ; $6f81
	ld a, $0f ; $6f82
	rst Rst18 ; $6f84
	inc b ; $6f85
	ld a, [bc] ; $6f86
	pop af ; $6f87
	ld a, $03 ; $6f88
	ld d, $02 ; $6f8a
	rst Rst18 ; $6f8c
	inc [hl] ; $6f8d
	ld a, [bc] ; $6f8e
	ld a, $03 ; $6f8f
	rst Rst18 ; $6f91
	ld [hl], $0a ; $6f92
	ld a, $03 ; $6f94
	rst Rst18 ; $6f96
	ld a, [bc] ; $6f97
	ld a, [bc] ; $6f98
	rst Rst18 ; $6f99
	ld [de], a ; $6f9a
	ld a, [bc] ; $6f9b
	rst Rst18 ; $6f9c
	inc c ; $6f9d
	ld a, [bc] ; $6f9e
	push af ; $6f9f
	ld a, $05 ; $6fa0
	rst Rst18 ; $6fa2
	inc b ; $6fa3
	ld a, [bc] ; $6fa4
	pop af ; $6fa5
	and a, a ; $6fa6
	jp nz, Label_13_7090 ; $6fa7
	ld a, $03 ; $6faa
	ld d, $03 ; $6fac
	rst Rst18 ; $6fae
	inc [hl] ; $6faf
	ld a, [bc] ; $6fb0
	ld a, $03 ; $6fb1
	rst Rst18 ; $6fb3
	ld [hl], $0a ; $6fb4
	ld hl, $0410 ; $6fb6
	rst Rst18 ; $6fb9
	ld c, $0a ; $6fba
	ld a, $03 ; $6fbc
	ld d, $03 ; $6fbe
	rst Rst18 ; $6fc0
	inc [hl] ; $6fc1
	ld a, [bc] ; $6fc2
	ld a, $03 ; $6fc3
	rst Rst18 ; $6fc5
	ld [hl], $0a ; $6fc6
	ld a, $03 ; $6fc8
	rst Rst18 ; $6fca
	ld [$3e0a], sp ; $6fcb
	rlca ; $6fce
	ld [wStoryModeCurrentLocation], a ; $6fcf
	ld a, $0d ; $6fd2
	ld [$c295], a ; $6fd4
	ld a, $ff ; $6fd7
	ld [$c294], a ; $6fd9
	ld [$c2a1], a ; $6fdc
	ld a, $00 ; $6fdf
	ld bc, $0020 ; $6fe1
	rst Rst18 ; $6fe4
	jr Label_13_6ff1 ; $6fe5
	INCBIN "data/bank_013/d_6fe7.bin" ; $6fe7, 10 bytes
Label_13_6ff1:
	ld b, a ; $6ff1
	ld a, $04 ; $6ff2
	ld de, $6bae ; $6ff4
	rst Rst18 ; $6ff7
	ld a, [de] ; $6ff8
	ld a, [bc] ; $6ff9
	ldh a, [$ff95] ; $6ffa
	ld b, a ; $6ffc
	ld a, $09 ; $6ffd
	ld de, $6bc5 ; $6fff
	rst Rst18 ; $7002
	ld a, [de] ; $7003
	ld a, [bc] ; $7004
	ldh a, [$ff95] ; $7005
	ld b, a ; $7007
	ld a, $00 ; $7008
	ld de, $6be7 ; $700a
	rst Rst18 ; $700d
	ld a, [de] ; $700e
	ld a, [bc] ; $700f
	ldh a, [$ff95] ; $7010
	ld b, a ; $7012
	ld a, $02 ; $7013
	ld de, $6bdc ; $7015
	rst Rst18 ; $7018
	ld a, [de] ; $7019
	ld a, [bc] ; $701a
	ld a, $07 ; $701b
	rst Rst18 ; $701d
	inc e ; $701e
	ld a, [bc] ; $701f
	ld a, $07 ; $7020
	ld bc, $0018 ; $7022
	rst Rst18 ; $7025
	jr Label_13_7032 ; $7026
	INCBIN "data/bank_013/d_7028.bin" ; $7028, 10 bytes
Label_13_7032:
	ld a, [bc] ; $7032
	ldh a, [$ff95] ; $7033
	ld b, a ; $7035
	ld a, $05 ; $7036
	ld de, $6b24 ; $7038
	rst Rst18 ; $703b
	ld a, [de] ; $703c
	ld a, [bc] ; $703d
	ldh a, [$ff95] ; $703e
	ld b, a ; $7040
	ld a, $06 ; $7041
	ld de, $6b3c ; $7043
	rst Rst18 ; $7046
	ld a, [de] ; $7047
	ld a, [bc] ; $7048
	ldh a, [$ff95] ; $7049
	ld b, a ; $704b
	ld a, $07 ; $704c
	ld de, $6b58 ; $704e
	rst Rst18 ; $7051
	ld a, [de] ; $7052
	ld a, [bc] ; $7053
	xor a, a ; $7054
	ld bc, $0c00 ; $7055
	ld de, $1b00 ; $7058
	rst Rst18 ; $705b
	ld a, [hl-] ; $705c
	ld a, [bc] ; $705d
	rst Rst18 ; $705e
	ld a, $0a ; $705f
	ld a, $04 ; $7061
	rst Rst18 ; $7063
	ld e, $0a ; $7064
	rst Rst18 ; $7066
	ld c, d ; $7067
	ld a, [bc] ; $7068
	ld a, $01 ; $7069
	ld [wCurrentMinigameStoryMatch], a ; $706b
	ld a, $0d ; $706e
	ld [$c8f7], a ; $7070
	rst Rst18 ; $7073
	ld e, d ; $7074
	ld a, [bc] ; $7075
	rst Rst18 ; $7076
	ld c, h ; $7077
	ld a, [bc] ; $7078
	rst Rst18 ; $7079
	ld c, [hl] ; $707a
	ld a, [bc] ; $707b
	ret ; $707c
	INCBIN "data/bank_013/d_707d.bin" ; $707d, 19 bytes
Label_13_7090:
	rst Rst18 ; $7090
	INCBIN "data/bank_013/d_7091.bin" ; $7091, 296 bytes
	rst Rst18 ; $71b9
	ld l, $0a ; $71ba
	ld a, $0d ; $71bc
	ld b, $00 ; $71be
	rst Rst18 ; $71c0
	inc a ; $71c1
	ld a, [bc] ; $71c2
	rst Rst18 ; $71c3
	ld a, $0a ; $71c4
	push af ; $71c6
	ld a, $28 ; $71c7
	rst Rst18 ; $71c9
	inc b ; $71ca
	ld a, [bc] ; $71cb
	pop af ; $71cc
	ld a, $00 ; $71cd
	ld b, $00 ; $71cf
	rst Rst18 ; $71d1
	inc a ; $71d2
	ld a, [bc] ; $71d3
	ldh a, [$ff95] ; $71d4
	ld b, a ; $71d6
	ld a, $08 ; $71d7
	ld de, $7a43 ; $71d9
	rst Rst18 ; $71dc
	ld a, [de] ; $71dd
	ld a, [bc] ; $71de
	ldh a, [$ff95] ; $71df
	ld b, a ; $71e1
	ld a, $09 ; $71e2
	ld de, $7aa7 ; $71e4
	rst Rst18 ; $71e7
	ld a, [de] ; $71e8
	ld a, [bc] ; $71e9
	ldh a, [$ff95] ; $71ea
	ld b, a ; $71ec
	ld a, $0d ; $71ed
	ld de, $7aa0 ; $71ef
	rst Rst18 ; $71f2
	ld a, [de] ; $71f3
	ld a, [bc] ; $71f4
	push af ; $71f5
	ld a, $0a ; $71f6
	rst Rst18 ; $71f8
	inc b ; $71f9
	ld a, [bc] ; $71fa
	pop af ; $71fb
	ldh a, [$ff95] ; $71fc
	ld b, a ; $71fe
	ld a, $03 ; $71ff
	ld de, $7a7d ; $7201
	rst Rst18 ; $7204
	ld a, [de] ; $7205
	ld a, [bc] ; $7206
	rst Rst18 ; $7207
	ld a, $0a ; $7208
	ld a, $03 ; $720a
	rst Rst18 ; $720c
	ld e, $0a ; $720d
	ld a, $00 ; $720f
	ld b, a ; $7211
	ld a, $0d ; $7212
	rst Rst18 ; $7214
	jr nc, Label_13_7221 ; $7215
	rst Rst30 ; $7217
	nop ; $7218
	inc e ; $7219
	jr z, Label_13_724d ; $721a
	rst Rst18 ; $721c
	INCBIN "data/bank_013/d_721d.bin" ; $721d, 4 bytes
Label_13_7221:
	ld d, $02 ; $7221
	rst Rst18 ; $7223
	inc [hl] ; $7224
	ld a, [bc] ; $7225
	ld a, $0d ; $7226
	rst Rst18 ; $7228
	ld [hl], $0a ; $7229
	ld a, $0d ; $722b
	rst Rst18 ; $722d
	ld [$3e0a], sp ; $722e
	dec c ; $7231
	ld b, a ; $7232
	ld a, $00 ; $7233
	rst Rst18 ; $7235
	jr nc, Label_13_7242 ; $7236
	ld a, $0d ; $7238
	ld d, $03 ; $723a
	rst Rst18 ; $723c
	inc [hl] ; $723d
	ld a, [bc] ; $723e
	ld a, $00 ; $723f
	INCBIN "data/bank_013/d_7241.bin" ; $7241, 1 bytes
Label_13_7242:
	inc bc ; $7242
	rst Rst18 ; $7243
	inc [hl] ; $7244
	ld a, [bc] ; $7245
	ld a, $00 ; $7246
	rst Rst18 ; $7248
	ld [hl], $0a ; $7249
	jr Label_13_727c ; $724b
Label_13_724d:
	ld a, $0d ; $724d
	ld d, $02 ; $724f
	rst Rst18 ; $7251
	inc [hl] ; $7252
	ld a, [bc] ; $7253
	ld a, $0d ; $7254
	rst Rst18 ; $7256
	ld [hl], $0a ; $7257
	ld a, $0d ; $7259
	rst Rst18 ; $725b
	ld [$3e0a], sp ; $725c
	dec c ; $725f
	ld b, a ; $7260
	ld a, $00 ; $7261
	rst Rst18 ; $7263
	jr nc, Label_13_7270 ; $7264
	ld a, $0d ; $7266
	ld d, $03 ; $7268
	rst Rst18 ; $726a
	inc [hl] ; $726b
	ld a, [bc] ; $726c
	ld a, $00 ; $726d
	INCBIN "data/bank_013/d_726f.bin" ; $726f, 1 bytes
Label_13_7270:
	inc bc ; $7270
	rst Rst18 ; $7271
	inc [hl] ; $7272
	ld a, [bc] ; $7273
	ld a, $00 ; $7274
	rst Rst18 ; $7276
	ld [hl], $0a ; $7277
	rst Rst18 ; $7279
	INCBIN "data/bank_013/d_727a.bin" ; $727a, 2 bytes
Label_13_727c:
	ld a, $09 ; $727c
	ld b, $40 ; $727e
	rst Rst18 ; $7280
	ld l, $0a ; $7281
	ld a, $09 ; $7283
	ld d, $04 ; $7285
	rst Rst18 ; $7287
	inc [hl] ; $7288
	ld a, [bc] ; $7289
	ld a, $09 ; $728a
	rst Rst18 ; $728c
	ld [hl], $0a ; $728d
	ld a, $09 ; $728f
	ld b, $00 ; $7291
	rst Rst18 ; $7293
	ld l, $0a ; $7294
	ld a, $09 ; $7296
	ld b, a ; $7298
	ld a, $00 ; $7299
	rst Rst18 ; $729b
	jr nc, Label_13_72a8 ; $729c
	ld a, $09 ; $729e
	rst Rst18 ; $72a0
	ld [$3e0a], sp ; $72a1
	nop ; $72a4
	ld d, $02 ; $72a5
	rst Rst18 ; $72a7
Label_13_72a8:
	inc [hl] ; $72a8
	ld a, [bc] ; $72a9
	ld a, $00 ; $72aa
	rst Rst18 ; $72ac
	ld [hl], $0a ; $72ad
	push af ; $72af
	ld a, $14 ; $72b0
	rst Rst18 ; $72b2
	inc b ; $72b3
	ld a, [bc] ; $72b4
	pop af ; $72b5
	ld a, $08 ; $72b6
	ld bc, $0a00 ; $72b8
	ld de, $1f00 ; $72bb
	rst Rst18 ; $72be
	inc h ; $72bf
	ld a, [bc] ; $72c0
	ld a, $08 ; $72c1
	rst Rst18 ; $72c3
	jr nz, Label_13_72d0 ; $72c4
	push af ; $72c6
	ld a, $14 ; $72c7
	rst Rst18 ; $72c9
	inc b ; $72ca
	ld a, [bc] ; $72cb
	pop af ; $72cc
	ld a, $08 ; $72cd
	ld b, a ; $72cf
Label_13_72d0:
	ld a, $00 ; $72d0
	rst Rst18 ; $72d2
	jr nc, Label_13_72df ; $72d3
	ld a, $08 ; $72d5
	ld b, a ; $72d7
	ld a, $0d ; $72d8
	rst Rst18 ; $72da
	jr nc, $72e7 ; $72db
	push af ; $72dd
	INCBIN "data/bank_013/d_72de.bin" ; $72de, 1 bytes
Label_13_72df:
	inc d ; $72df
	rst Rst18 ; $72e0
	inc b ; $72e1
	ld a, [bc] ; $72e2
	pop af ; $72e3
	ld a, $08 ; $72e4
	ld d, $03 ; $72e6
	rst Rst18 ; $72e8
	inc [hl] ; $72e9
	ld a, [bc] ; $72ea
	ld a, $08 ; $72eb
	rst Rst18 ; $72ed
	ld [hl], $0a ; $72ee
	ld a, $08 ; $72f0
	rst Rst18 ; $72f2
	ld [$f50a], sp ; $72f3
	ld a, $14 ; $72f6
	rst Rst18 ; $72f8
	inc b ; $72f9
	ld a, [bc] ; $72fa
	pop af ; $72fb
	ld a, $03 ; $72fc
	ld bc, $0c00 ; $72fe
	ld de, $1f00 ; $7301
	rst Rst18 ; $7304
	inc h ; $7305
	ld a, [bc] ; $7306
	ld a, $03 ; $7307
	rst Rst18 ; $7309
	jr nz, Label_13_7316 ; $730a
	push af ; $730c
	ld a, $14 ; $730d
	rst Rst18 ; $730f
	inc b ; $7310
	ld a, [bc] ; $7311
	pop af ; $7312
	ld a, $03 ; $7313
	INCBIN "data/bank_013/d_7315.bin" ; $7315, 1 bytes
Label_13_7316:
	ld [bc], a ; $7316
	rst Rst18 ; $7317
	inc [hl] ; $7318
	ld a, [bc] ; $7319
	ld a, $03 ; $731a
	rst Rst18 ; $731c
	ld [hl], $0a ; $731d
	ld a, $03 ; $731f
	rst Rst18 ; $7321
	ld [$3e0a], sp ; $7322
	dec c ; $7325
	ld d, $02 ; $7326
	rst Rst18 ; $7328
	inc [hl] ; $7329
	ld a, [bc] ; $732a
	ld a, $0d ; $732b
	rst Rst18 ; $732d
	ld [hl], $0a ; $732e
	ld a, $00 ; $7330
	ld b, a ; $7332
	ld a, $0d ; $7333
	rst Rst18 ; $7335
	jr nc, Label_13_7342 ; $7336
	rst Rst30 ; $7338
	nop ; $7339
	inc e ; $733a
	jr z, Label_13_7340 ; $733b
	rst Rst18 ; $733d
	INCBIN "data/bank_013/d_733e.bin" ; $733e, 2 bytes
Label_13_7340:
	ld a, $0d ; $7340
Label_13_7342:
	rst Rst18 ; $7342
	ld [$3e0a], sp ; $7343
	dec c ; $7346
	ld b, a ; $7347
	ld a, $00 ; $7348
	rst Rst18 ; $734a
	jr nc, Label_13_7357 ; $734b
	ld a, $00 ; $734d
	ld d, $03 ; $734f
	rst Rst18 ; $7351
	inc [hl] ; $7352
	ld a, [bc] ; $7353
	ld a, $00 ; $7354
	rst Rst18 ; $7356
Label_13_7357:
	ld [hl], $0a ; $7357
	push af ; $7359
	ld a, $0a ; $735a
	rst Rst18 ; $735c
	inc b ; $735d
	ld a, [bc] ; $735e
	pop af ; $735f
	ld a, $08 ; $7360
	ld b, a ; $7362
	ld a, $00 ; $7363
	rst Rst18 ; $7365
	jr nc, Label_13_7372 ; $7366
	push af ; $7368
	ld a, $0a ; $7369
	rst Rst18 ; $736b
	inc b ; $736c
	ld a, [bc] ; $736d
	pop af ; $736e
	ld a, $00 ; $736f
	INCBIN "data/bank_013/d_7371.bin" ; $7371, 1 bytes
Label_13_7372:
	inc bc ; $7372
	rst Rst18 ; $7373
	inc [hl] ; $7374
	ld a, [bc] ; $7375
	ld c, $02 ; $7376
	call Func_00_1d20 ; $7378
	call Func_00_1da4 ; $737b
	ld b, $00 ; $737e
	ld a, [$c90d] ; $7380
	add a, $04 ; $7383
	ld c, a ; $7385
	rst Rst18 ; $7386
	adc a, [hl] ; $7387
	jr Label_13_73c8 ; $7388
	INCBIN "data/bank_013/d_738a.bin" ; $738a, 62 bytes
Label_13_73c8:
	dec h ; $73c8
	ld a, e ; $73c9
	nop ; $73ca
	inc de ; $73cb
	nop ; $73cc
	inc hl ; $73cd
	add a, b ; $73ce
	nop ; $73cf
	ld h, a ; $73d0
	ld bc, $0006 ; $73d1
	nop ; $73d4
	nop ; $73d5
	dec h ; $73d6
	ld a, e ; $73d7
	nop ; $73d8
	inc de ; $73d9
	nop ; $73da
	rla ; $73db
	add a, b ; $73dc
	nop ; $73dd
	ld l, e ; $73de
	ld bc, $0006 ; $73df
	nop ; $73e2
	nop ; $73e3
	dec h ; $73e4
	ld a, e ; $73e5
	nop ; $73e6
	dec de ; $73e7
	nop ; $73e8
	dec e ; $73e9
	add a, b ; $73ea
	nop ; $73eb
	ld c, c ; $73ec
	ld bc, $0000 ; $73ed
	nop ; $73f0
	nop ; $73f1
	dec h ; $73f2
	ld a, e ; $73f3
	nop ; $73f4
	add hl, de ; $73f5
	nop ; $73f6
	dec e ; $73f7
	add a, b ; $73f8
	nop ; $73f9
	ld c, d ; $73fa
	ld bc, $0000 ; $73fb
	nop ; $73fe
	nop ; $73ff
	dec h ; $7400
	ld a, e ; $7401
	nop ; $7402
	dec a ; $7403
	nop ; $7404
	dec a ; $7405
	add a, b ; $7406
	nop ; $7407
	ld d, e ; $7408
	ld bc, $0000 ; $7409
	nop ; $740c
	nop ; $740d
	dec h ; $740e
	ld a, e ; $740f
	nop ; $7410
	dec a ; $7411
	nop ; $7412
	dec a ; $7413
	add a, b ; $7414
	nop ; $7415
	ld c, h ; $7416
	ld bc, $0000 ; $7417
	nop ; $741a
	nop ; $741b
	dec h ; $741c
	ld a, e ; $741d
	nop ; $741e
	dec a ; $741f
	nop ; $7420
	dec a ; $7421
	add a, b ; $7422
	nop ; $7423
	ld c, l ; $7424
	ld bc, $0000 ; $7425
	nop ; $7428
	nop ; $7429
	dec h ; $742a
	ld a, e ; $742b
	nop ; $742c
	rla ; $742d
	nop ; $742e
	dec e ; $742f
	add a, b ; $7430
	nop ; $7431
	add hl, hl ; $7432
	ld bc, $0000 ; $7433
	nop ; $7436
	nop ; $7437
	nop ; $7438
	nop ; $7439
	nop ; $743a
	nop ; $743b
	nop ; $743c
	nop ; $743d
	nop ; $743e
	rst Rst38 ; $743f
	ld a, $04 ; $7440
	ldh [$ff96], a ; $7442
	ldh [rWBK], a ; $7444
	ld a, [wMatchWinLoseFlag] ; $7446
	cp a, $01 ; $7449
	jp z, Label_13_744f ; $744b
	ret ; $744e
Label_13_744f:
	ld hl, $0416 ; $744f
	rst Rst18 ; $7452
	ld c, $0a ; $7453
	ldh a, [$ff95] ; $7455
	ld hl, $78d7 ; $7457
	rst Rst18 ; $745a
	ld b, $0a ; $745b
	rst Rst18 ; $745d
	nop ; $745e
	ld a, [bc] ; $745f
	call Func_13_62be ; $7460
	ld a, $02 ; $7463
	rst Rst18 ; $7465
	inc e ; $7466
	ld a, [bc] ; $7467
	ld a, $01 ; $7468
	rst Rst18 ; $746a
	inc e ; $746b
	ld a, [bc] ; $746c
	ld bc, $0040 ; $746d
	rst Rst18 ; $7470
	jr c, Label_13_747d ; $7471
	ld a, $00 ; $7473
	ld bc, $0b00 ; $7475
	ld de, $1d00 ; $7478
	rst Rst18 ; $747b
	ld [hl+], a ; $747c
Label_13_747d:
	ld a, [bc] ; $747d
	ld a, $02 ; $747e
	ld bc, $0d00 ; $7480
	ld de, $2300 ; $7483
	rst Rst18 ; $7486
	ld [hl+], a ; $7487
	ld a, [bc] ; $7488
	ld a, $00 ; $7489
	ld b, $c0 ; $748b
	rst Rst18 ; $748d
	ld l, $0a ; $748e
	ld a, $02 ; $7490
	ld b, $c0 ; $7492
	rst Rst18 ; $7494
	ld l, $0a ; $7495
	xor a, a ; $7497
	ld bc, $0b00 ; $7498
	ld de, $1100 ; $749b
	rst Rst18 ; $749e
	ld a, [hl-] ; $749f
	ld a, [bc] ; $74a0
	rst Rst18 ; $74a1
	ld a, $0a ; $74a2
	ld c, $04 ; $74a4
	call Func_00_1d2e ; $74a6
	call Func_00_1da4 ; $74a9
	push af ; $74ac
	ld a, $3c ; $74ad
	rst Rst18 ; $74af
	inc b ; $74b0
	ld a, [bc] ; $74b1
	pop af ; $74b2
	ld bc, $0020 ; $74b3
	rst Rst18 ; $74b6
	jr c, Label_13_74c3 ; $74b7
	xor a, a ; $74b9
	ld bc, $0b00 ; $74ba
	ld de, $1700 ; $74bd
	rst Rst18 ; $74c0
	ld a, [hl-] ; $74c1
	ld a, [bc] ; $74c2
Label_13_74c3:
	rst Rst18 ; $74c3
	ld a, $0a ; $74c4
	ld a, $02 ; $74c6
	ld bc, $0d00 ; $74c8
	ld de, $1d00 ; $74cb
	rst Rst18 ; $74ce
	inc h ; $74cf
	ld a, [bc] ; $74d0
	ld a, $09 ; $74d1
	ld bc, $0b00 ; $74d3
	ld de, $1700 ; $74d6
	rst Rst18 ; $74d9
	inc h ; $74da
	ld a, [bc] ; $74db
	ld a, $09 ; $74dc
	rst Rst18 ; $74de
	jr nz, Label_13_74eb ; $74df
	ld a, $09 ; $74e1
	ld d, $04 ; $74e3
	rst Rst18 ; $74e5
	inc [hl] ; $74e6
	ld a, [bc] ; $74e7
	ld a, $09 ; $74e8
	rst Rst18 ; $74ea
Label_13_74eb:
	ld [hl], $0a ; $74eb
	ld a, $09 ; $74ed
	rst Rst18 ; $74ef
	ld [$3e0a], sp ; $74f0
	inc b ; $74f3
	ld d, $02 ; $74f4
	rst Rst18 ; $74f6
	inc [hl] ; $74f7
	ld a, [bc] ; $74f8
	ld a, $04 ; $74f9
	rst Rst18 ; $74fb
	ld [hl], $0a ; $74fc
	ld a, $04 ; $74fe
	rst Rst18 ; $7500
	ld [$3e0a], sp ; $7501
	ld [bc], a ; $7504
	ld d, $03 ; $7505
	rst Rst18 ; $7507
	inc [hl] ; $7508
	ld a, [bc] ; $7509
	ld a, $00 ; $750a
	ld d, $03 ; $750c
	rst Rst18 ; $750e
	inc [hl] ; $750f
	ld a, [bc] ; $7510
	ld a, $00 ; $7511
	rst Rst18 ; $7513
	ld [hl], $0a ; $7514
	ld a, $00 ; $7516
	ld b, a ; $7518
	ld a, $02 ; $7519
	rst Rst18 ; $751b
	jr nc, Label_13_7528 ; $751c
	push af ; $751e
	ld a, $1e ; $751f
	rst Rst18 ; $7521
	inc b ; $7522
	ld a, [bc] ; $7523
	pop af ; $7524
	ld a, $02 ; $7525
	INCBIN "data/bank_013/d_7527.bin" ; $7527, 1 bytes
Label_13_7528:
	inc bc ; $7528
	rst Rst18 ; $7529
	inc [hl] ; $752a
	ld a, [bc] ; $752b
	ld a, $02 ; $752c
	rst Rst18 ; $752e
	ld [hl], $0a ; $752f
	rst Rst30 ; $7531
	nop ; $7532
	inc e ; $7533
	jp z, Label_13_7672 ; $7534
	ld hl, $041a ; $7537
	rst Rst18 ; $753a
	ld c, $0a ; $753b
	ld a, $02 ; $753d
	rst Rst18 ; $753f
	ld [$3e0a], sp ; $7540
	ld [bc], a ; $7543
	ld b, a ; $7544
	ld a, $00 ; $7545
	rst Rst18 ; $7547
	jr nc, Label_13_7554 ; $7548
	ld a, $02 ; $754a
	ld d, $02 ; $754c
	rst Rst18 ; $754e
	inc [hl] ; $754f
	ld a, [bc] ; $7550
	ld a, $02 ; $7551
	rst Rst18 ; $7553
Label_13_7554:
	ld [hl], $0a ; $7554
	ld a, $02 ; $7556
	rst Rst18 ; $7558
	ld [$3e0a], sp ; $7559
	nop ; $755c
	ld b, $80 ; $755d
	rst Rst18 ; $755f
	ld l, $0a ; $7560
	ld a, $00 ; $7562
	ld d, $02 ; $7564
	rst Rst18 ; $7566
	inc [hl] ; $7567
	ld a, [bc] ; $7568
	ld a, $0a ; $7569
	ld bc, $0c00 ; $756b
	ld de, $1b80 ; $756e
	rst Rst18 ; $7571
	ld [hl+], a ; $7572
	ld a, [bc] ; $7573
	rst Rst08 ; $7574
	sub a, [hl] ; $7575
	push af ; $7576
	ld a, $28 ; $7577
	rst Rst18 ; $7579
	inc b ; $757a
	ld a, [bc] ; $757b
	pop af ; $757c
	ld a, $0a ; $757d
	ld bc, $3f00 ; $757f
	ld de, $3f00 ; $7582
	rst Rst18 ; $7585
	ld [hl+], a ; $7586
	ld a, [bc] ; $7587
	ld a, $02 ; $7588
	ld b, a ; $758a
	ld a, $00 ; $758b
	rst Rst18 ; $758d
	jr nc, Label_13_759a ; $758e
	push af ; $7590
	ld a, $0a ; $7591
	rst Rst18 ; $7593
	inc b ; $7594
	ld a, [bc] ; $7595
	pop af ; $7596
	ld a, $00 ; $7597
	INCBIN "data/bank_013/d_7599.bin" ; $7599, 1 bytes
Label_13_759a:
	ld bc, $2cdf ; $759a
	ld a, [bc] ; $759d
	push af ; $759e
	ld a, $0a ; $759f
	rst Rst18 ; $75a1
	inc b ; $75a2
	ld a, [bc] ; $75a3
	pop af ; $75a4
	ld a, $00 ; $75a5
	ld b, $00 ; $75a7
	ld de, $0100 ; $75a9
	rst Rst18 ; $75ac
	ld a, [hl+] ; $75ad
	ld a, [bc] ; $75ae
	ld a, $00 ; $75af
	rst Rst18 ; $75b1
	jr nz, Label_13_75be ; $75b2
	ld a, $00 ; $75b4
	ld d, $02 ; $75b6
	rst Rst18 ; $75b8
	inc [hl] ; $75b9
	ld a, [bc] ; $75ba
	ld a, $00 ; $75bb
	rst Rst18 ; $75bd
Label_13_75be:
	ld [hl], $0a ; $75be
	ld a, $00 ; $75c0
	ld b, $80 ; $75c2
	ld de, $0100 ; $75c4
	rst Rst18 ; $75c7
	ld a, [hl+] ; $75c8
	ld a, [bc] ; $75c9
	ld a, $00 ; $75ca
	rst Rst18 ; $75cc
	jr nz, Label_13_75d9 ; $75cd
	ld a, $02 ; $75cf
	rst Rst18 ; $75d1
	ld d, $0a ; $75d2
	ld de, $0018 ; $75d4
	add hl, de ; $75d7
	INCBIN "data/bank_013/d_75d8.bin" ; $75d8, 1 bytes
Label_13_75d9:
	inc b ; $75d9
	ld a, $02 ; $75da
	ld d, $02 ; $75dc
	rst Rst18 ; $75de
	inc [hl] ; $75df
	ld a, [bc] ; $75e0
	ld a, $02 ; $75e1
	rst Rst18 ; $75e3
	ld [hl], $0a ; $75e4
	ld a, $02 ; $75e6
	ld b, $c0 ; $75e8
	rst Rst18 ; $75ea
	ld l, $0a ; $75eb
	ld a, $02 ; $75ed
	ld d, $02 ; $75ef
	rst Rst18 ; $75f1
	inc [hl] ; $75f2
	ld a, [bc] ; $75f3
	ld a, $02 ; $75f4
	rst Rst18 ; $75f6
	ld [hl], $0a ; $75f7
	ld a, $02 ; $75f9
	ld d, $02 ; $75fb
	rst Rst18 ; $75fd
	inc [hl] ; $75fe
	ld a, [bc] ; $75ff
	ld a, $02 ; $7600
	rst Rst18 ; $7602
	ld [hl], $0a ; $7603
	ld a, $02 ; $7605
	ld b, $40 ; $7607
	rst Rst18 ; $7609
	ld l, $0a ; $760a
	ld a, $02 ; $760c
	ld d, $02 ; $760e
	rst Rst18 ; $7610
	inc [hl] ; $7611
	ld a, [bc] ; $7612
	ld a, $02 ; $7613
	rst Rst18 ; $7615
	ld [hl], $0a ; $7616
	ld a, $02 ; $7618
	ld b, $c0 ; $761a
	rst Rst18 ; $761c
	ld l, $0a ; $761d
	ld a, $02 ; $761f
	ld d, $02 ; $7621
	rst Rst18 ; $7623
	inc [hl] ; $7624
	ld a, [bc] ; $7625
	ld a, $02 ; $7626
	rst Rst18 ; $7628
	ld [hl], $0a ; $7629
	ld a, $02 ; $762b
	ld d, $02 ; $762d
	rst Rst18 ; $762f
	inc [hl] ; $7630
	ld a, [bc] ; $7631
	ld a, $02 ; $7632
	rst Rst18 ; $7634
	ld [hl], $0a ; $7635
	ld a, $02 ; $7637
	rst Rst18 ; $7639
	ld d, $0a ; $763a
	ld de, $0018 ; $763c
	add hl, de ; $763f
	ld [hl], $01 ; $7640
	ld a, $02 ; $7642
	ld b, $80 ; $7644
	rst Rst18 ; $7646
	ld l, $0a ; $7647
	push af ; $7649
	ld a, $14 ; $764a
	rst Rst18 ; $764c
	inc b ; $764d
	ld a, [bc] ; $764e
	pop af ; $764f
	ld a, $02 ; $7650
	ld d, $03 ; $7652
	rst Rst18 ; $7654
	inc [hl] ; $7655
	ld a, [bc] ; $7656
	ld a, $02 ; $7657
	rst Rst18 ; $7659
	ld [hl], $0a ; $765a
	push af ; $765c
	ld a, $14 ; $765d
	rst Rst18 ; $765f
	inc b ; $7660
	ld a, [bc] ; $7661
	pop af ; $7662
	ld a, $00 ; $7663
	ld d, $03 ; $7665
	rst Rst18 ; $7667
	inc [hl] ; $7668
	ld a, [bc] ; $7669
	ld a, $00 ; $766a
	rst Rst18 ; $766c
	ld [hl], $0a ; $766d
	jp Label_13_7769 ; $766f
Label_13_7672:
	ld hl, $0418 ; $7672
	rst Rst18 ; $7675
	ld c, $0a ; $7676
	ld a, $02 ; $7678
	rst Rst18 ; $767a
	ld [$3e0a], sp ; $767b
	ld [bc], a ; $767e
	ld d, $02 ; $767f
	rst Rst18 ; $7681
	inc [hl] ; $7682
	ld a, [bc] ; $7683
	ld a, $02 ; $7684
	rst Rst18 ; $7686
	ld [hl], $0a ; $7687
	ld a, $02 ; $7689
	rst Rst18 ; $768b
	ld [$3e0a], sp ; $768c
	ld [bc], a ; $768f
	ld b, a ; $7690
	ld a, $00 ; $7691
	rst Rst18 ; $7693
	jr nc, Label_13_76a0 ; $7694
	ld a, $0a ; $7696
	ld bc, $0c00 ; $7698
	ld de, $1b80 ; $769b
	rst Rst18 ; $769e
	ld [hl+], a ; $769f
Label_13_76a0:
	ld a, [bc] ; $76a0
	rst Rst08 ; $76a1
	sub a, [hl] ; $76a2
	push af ; $76a3
	ld a, $28 ; $76a4
	rst Rst18 ; $76a6
	inc b ; $76a7
	ld a, [bc] ; $76a8
	pop af ; $76a9
	ld a, $0a ; $76aa
	ld bc, $3f00 ; $76ac
	ld de, $3f00 ; $76af
	rst Rst18 ; $76b2
	ld [hl+], a ; $76b3
	ld a, [bc] ; $76b4
	push af ; $76b5
	ld a, $0a ; $76b6
	rst Rst18 ; $76b8
	inc b ; $76b9
	ld a, [bc] ; $76ba
	pop af ; $76bb
	ld a, $00 ; $76bc
	ld b, $01 ; $76be
	rst Rst18 ; $76c0
	inc l ; $76c1
	ld a, [bc] ; $76c2
	push af ; $76c3
	ld a, $0a ; $76c4
	rst Rst18 ; $76c6
	inc b ; $76c7
	ld a, [bc] ; $76c8
	pop af ; $76c9
	ld a, $00 ; $76ca
	ld b, $00 ; $76cc
	ld de, $0100 ; $76ce
	rst Rst18 ; $76d1
	ld a, [hl+] ; $76d2
	ld a, [bc] ; $76d3
	ld a, $00 ; $76d4
	rst Rst18 ; $76d6
	jr nz, Label_13_76e3 ; $76d7
	ld a, $00 ; $76d9
	ld d, $02 ; $76db
	rst Rst18 ; $76dd
	inc [hl] ; $76de
	ld a, [bc] ; $76df
	ld a, $00 ; $76e0
	rst Rst18 ; $76e2
Label_13_76e3:
	ld [hl], $0a ; $76e3
	ld a, $00 ; $76e5
	ld b, $80 ; $76e7
	ld de, $0100 ; $76e9
	rst Rst18 ; $76ec
	ld a, [hl+] ; $76ed
	ld a, [bc] ; $76ee
	ld a, $00 ; $76ef
	rst Rst18 ; $76f1
	jr nz, Label_13_76fe ; $76f2
	ld a, $02 ; $76f4
	rst Rst18 ; $76f6
	ld d, $0a ; $76f7
	ld de, $0018 ; $76f9
	add hl, de ; $76fc
	INCBIN "data/bank_013/d_76fd.bin" ; $76fd, 1 bytes
Label_13_76fe:
	inc bc ; $76fe
	ld a, $02 ; $76ff
	ld d, $02 ; $7701
	rst Rst18 ; $7703
	inc [hl] ; $7704
	ld a, [bc] ; $7705
	ld a, $02 ; $7706
	rst Rst18 ; $7708
	ld [hl], $0a ; $7709
	ld a, $02 ; $770b
	ld b, $40 ; $770d
	rst Rst18 ; $770f
	ld l, $0a ; $7710
	ld a, $02 ; $7712
	ld d, $02 ; $7714
	rst Rst18 ; $7716
	inc [hl] ; $7717
	ld a, [bc] ; $7718
	ld a, $02 ; $7719
	rst Rst18 ; $771b
	ld [hl], $0a ; $771c
	push af ; $771e
	ld a, $28 ; $771f
	rst Rst18 ; $7721
	inc b ; $7722
	ld a, [bc] ; $7723
	pop af ; $7724
	ld a, $02 ; $7725
	ld d, $02 ; $7727
	rst Rst18 ; $7729
	inc [hl] ; $772a
	ld a, [bc] ; $772b
	ld a, $02 ; $772c
	rst Rst18 ; $772e
	ld [hl], $0a ; $772f
	ld a, $02 ; $7731
	rst Rst18 ; $7733
	ld d, $0a ; $7734
	ld de, $0018 ; $7736
	add hl, de ; $7739
	ld [hl], $01 ; $773a
	ld a, $02 ; $773c
	ld b, $80 ; $773e
	rst Rst18 ; $7740
	ld l, $0a ; $7741
	push af ; $7743
	ld a, $14 ; $7744
	rst Rst18 ; $7746
	inc b ; $7747
	ld a, [bc] ; $7748
	pop af ; $7749
	ld a, $02 ; $774a
	ld d, $03 ; $774c
	rst Rst18 ; $774e
	inc [hl] ; $774f
	ld a, [bc] ; $7750
	ld a, $02 ; $7751
	rst Rst18 ; $7753
	ld [hl], $0a ; $7754
	push af ; $7756
	ld a, $14 ; $7757
	rst Rst18 ; $7759
	inc b ; $775a
	ld a, [bc] ; $775b
	pop af ; $775c
	ld a, $00 ; $775d
	ld d, $03 ; $775f
	rst Rst18 ; $7761
	inc [hl] ; $7762
	ld a, [bc] ; $7763
	ld a, $00 ; $7764
	rst Rst18 ; $7766
	ld [hl], $0a ; $7767
Label_13_7769:
	ld hl, $041c ; $7769
	rst Rst18 ; $776c
	ld c, $0a ; $776d
	push af ; $776f
	ld a, $14 ; $7770
	rst Rst18 ; $7772
	inc b ; $7773
	ld a, [bc] ; $7774
	pop af ; $7775
	ld a, $08 ; $7776
	rst Rst18 ; $7778
	ld [$3e0a], sp ; $7779
	nop ; $777c
	ld b, $00 ; $777d
	rst Rst18 ; $777f
	inc l ; $7780
	ld a, [bc] ; $7781
	ld a, $00 ; $7782
	ld b, $00 ; $7784
	rst Rst18 ; $7786
	ld l, $0a ; $7787
	ld a, $02 ; $7789
	ld b, $00 ; $778b
	rst Rst18 ; $778d
	ld l, $0a ; $778e
	ldh a, [$ff95] ; $7790
	ld b, a ; $7792
	ld a, $08 ; $7793
	ld de, $7a43 ; $7795
	rst Rst18 ; $7798
	ld a, [de] ; $7799
	ld a, [bc] ; $779a
	ldh a, [$ff95] ; $779b
	ld b, a ; $779d
	ld a, $03 ; $779e
	ld de, $7a60 ; $77a0
	rst Rst18 ; $77a3
	ld a, [de] ; $77a4
	ld a, [bc] ; $77a5
	push af ; $77a6
	ld a, $14 ; $77a7
	rst Rst18 ; $77a9
	inc b ; $77aa
	ld a, [bc] ; $77ab
	pop af ; $77ac
	ldh a, [$ff95] ; $77ad
	ld b, a ; $77af
	ld a, $09 ; $77b0
	ld de, $7ac9 ; $77b2
	rst Rst18 ; $77b5
	ld a, [de] ; $77b6
	ld a, [bc] ; $77b7
	xor a, a ; $77b8
	ld bc, $0b00 ; $77b9
	ld de, $1d00 ; $77bc
	rst Rst18 ; $77bf
	ld a, [hl-] ; $77c0
	ld a, [bc] ; $77c1
	rst Rst18 ; $77c2
	ld a, $0a ; $77c3
	ld a, $09 ; $77c5
	rst Rst18 ; $77c7
	ld e, $0a ; $77c8
	ld a, $00 ; $77ca
	ld b, a ; $77cc
	ld a, $09 ; $77cd
	rst Rst18 ; $77cf
	jr nc, Label_13_77dc ; $77d0
	ld a, $03 ; $77d2
	ld b, a ; $77d4
	ld a, $02 ; $77d5
	rst Rst18 ; $77d7
	jr nc, Label_13_77e4 ; $77d8
	ld a, $09 ; $77da
Label_13_77dc:
	ld d, $04 ; $77dc
	rst Rst18 ; $77de
	inc [hl] ; $77df
	ld a, [bc] ; $77e0
	ld a, $09 ; $77e1
	rst Rst18 ; $77e3
Label_13_77e4:
	ld [hl], $0a ; $77e4
	ld a, $09 ; $77e6
	ld b, a ; $77e8
	ld a, $00 ; $77e9
	rst Rst18 ; $77eb
	jr nc, Label_13_77f8 ; $77ec
	ld a, $09 ; $77ee
	rst Rst18 ; $77f0
	ld [$3e0a], sp ; $77f1
	ld [$0001], sp ; $77f4
	ld a, [bc] ; $77f7
Label_13_77f8:
	ld de, $1f00 ; $77f8
	rst Rst18 ; $77fb
	inc h ; $77fc
	ld a, [bc] ; $77fd
	ld a, $08 ; $77fe
	rst Rst18 ; $7800
	jr nz, Label_13_780d ; $7801
	ld a, $08 ; $7803
	ld b, a ; $7805
	ld a, $00 ; $7806
	rst Rst18 ; $7808
	jr nc, Label_13_7815 ; $7809
	ld a, $03 ; $780b
Label_13_780d:
	ld b, a ; $780d
	ld a, $02 ; $780e
	rst Rst18 ; $7810
	jr nc, Label_13_781d ; $7811
	ld a, $08 ; $7813
Label_13_7815:
	ld d, $03 ; $7815
	rst Rst18 ; $7817
	inc [hl] ; $7818
	ld a, [bc] ; $7819
	ld a, $08 ; $781a
	rst Rst18 ; $781c
Label_13_781d:
	ld [hl], $0a ; $781d
	ld a, $08 ; $781f
	rst Rst18 ; $7821
	ld [$3e0a], sp ; $7822
	inc bc ; $7825
	ld bc, $0c00 ; $7826
	ld de, $1f00 ; $7829
	rst Rst18 ; $782c
	inc h ; $782d
	ld a, [bc] ; $782e
	ld a, $03 ; $782f
	rst Rst18 ; $7831
	jr nz, Label_13_783e ; $7832
	ld a, $03 ; $7834
	ld d, $02 ; $7836
	rst Rst18 ; $7838
	inc [hl] ; $7839
	ld a, [bc] ; $783a
	ld a, $03 ; $783b
	rst Rst18 ; $783d
Label_13_783e:
	ld [hl], $0a ; $783e
	ld a, $03 ; $7840
	rst Rst18 ; $7842
	ld [$3e0a], sp ; $7843
	nop ; $7846
	ld b, a ; $7847
	ld a, $02 ; $7848
	rst Rst18 ; $784a
	jr nc, Label_13_7857 ; $784b
	ld a, $02 ; $784d
	ld d, $03 ; $784f
	rst Rst18 ; $7851
	inc [hl] ; $7852
	ld a, [bc] ; $7853
	ld a, $02 ; $7854
	rst Rst18 ; $7856
Label_13_7857:
	ld [hl], $0a ; $7857
	rst Rst30 ; $7859
	nop ; $785a
	inc e ; $785b
	jr z, Label_13_7861 ; $785c
	rst Rst18 ; $785e
	INCBIN "data/bank_013/d_785f.bin" ; $785f, 2 bytes
Label_13_7861:
	ld a, $02 ; $7861
	rst Rst18 ; $7863
	ld [$3e0a], sp ; $7864
	ld [bc], a ; $7867
	ld b, a ; $7868
	ld a, $00 ; $7869
	rst Rst18 ; $786b
	jr nc, Label_13_7878 ; $786c
	ld a, $00 ; $786e
	ld d, $03 ; $7870
	rst Rst18 ; $7872
	inc [hl] ; $7873
	ld a, [bc] ; $7874
	ld a, $00 ; $7875
	rst Rst18 ; $7877
Label_13_7878:
	ld [hl], $0a ; $7878
	push af ; $787a
	ld a, $0a ; $787b
	rst Rst18 ; $787d
	inc b ; $787e
	ld a, [bc] ; $787f
	pop af ; $7880
	ld a, $08 ; $7881
	ld b, a ; $7883
	ld a, $00 ; $7884
	rst Rst18 ; $7886
	jr nc, Label_13_7893 ; $7887
	ld a, $03 ; $7889
	ld b, a ; $788b
	ld a, $02 ; $788c
	rst Rst18 ; $788e
	jr nc, $789b ; $788f
	push af ; $7891
	INCBIN "data/bank_013/d_7892.bin" ; $7892, 1 bytes
Label_13_7893:
	ld a, [bc] ; $7893
	rst Rst18 ; $7894
	inc b ; $7895
	ld a, [bc] ; $7896
	pop af ; $7897
	ld a, $00 ; $7898
	ld d, $03 ; $789a
	rst Rst18 ; $789c
	inc [hl] ; $789d
	ld a, [bc] ; $789e
	ld a, $02 ; $789f
	ld d, $03 ; $78a1
	rst Rst18 ; $78a3
	inc [hl] ; $78a4
	ld a, [bc] ; $78a5
	ld c, $02 ; $78a6
	call Func_00_1d20 ; $78a8
	call Func_00_1da4 ; $78ab
	call Func_13_78c4 ; $78ae
	ld a, $00 ; $78b1
	ld [wStoryModeCurrentLocation], a ; $78b3
	ld a, $0a ; $78b6
	ld [$c295], a ; $78b8
	ld a, $ff ; $78bb
	ld [$c294], a ; $78bd
	ld [$c2a1], a ; $78c0
	ret ; $78c3
Func_13_78c4:
	ld b, $00 ; $78c4
	ld a, [$c90d] ; $78c6
	ld d, a ; $78c9
	sla a ; $78ca
	ld c, a ; $78cc
	ld a, [$c94d] ; $78cd
	xor a, d ; $78d0
	or a, c ; $78d1
	ld c, a ; $78d2
	rst Rst18 ; $78d3
	adc a, [hl] ; $78d4
	jr $78a0 ; $78d5
	INCBIN "data/bank_013/d_78d7.bin" ; $78d7, 1833 bytes

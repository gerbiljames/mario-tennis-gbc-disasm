INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $11", ROMX[$4000], BANK[$11]

	INCBIN "data/bank_011/d_4000.bin" ; $4000, 2031 bytes
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
	ld [$3e0a], sp ; $480e
	ld de, $0316 ; $4811
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
	INCBIN "data/bank_011/d_4824.bin" ; $4824, 10 bytes
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
	INCBIN "data/bank_011/d_4862.bin" ; $4862, 10 bytes
Label_11_486c:
	ld bc, $1980 ; $486c
	ld de, $18c0 ; $486f
	rst Rst18 ; $4872
	inc h ; $4873
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
	ld [$3e0a], sp ; $4888
	ld c, $01 ; $488b
	nop ; $488d
	ccf ; $488e
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
	jr nz, Label_11_48af ; $48a3
	push af ; $48a5
	ld a, $1e ; $48a6
	rst Rst18 ; $48a8
	inc b ; $48a9
	ld a, [bc] ; $48aa
	pop af ; $48ab
	ld a, $11 ; $48ac
	INCBIN "data/bank_011/d_48ae.bin" ; $48ae, 1 bytes
Label_11_48af:
	ld [bc], a ; $48af
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
	ld [$3e0a], sp ; $48ca
	rrca ; $48cd
	ld bc, $3f00 ; $48ce
	ld de, $3f00 ; $48d1
	rst Rst18 ; $48d4
	ld [hl+], a ; $48d5
	ld a, [bc] ; $48d6
	ld a, $11 ; $48d7
	ld bc, $0020 ; $48d9
	rst Rst18 ; $48dc
	jr Label_11_48e9 ; $48dd
	INCBIN "data/bank_011/d_48df.bin" ; $48df, 10 bytes
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
	jr nz, Label_11_492f ; $4923
	ld a, $11 ; $4925
	ld d, $02 ; $4927
	rst Rst18 ; $4929
	inc [hl] ; $492a
	ld a, [bc] ; $492b
	ld a, $10 ; $492c
	INCBIN "data/bank_011/d_492e.bin" ; $492e, 1 bytes
Label_11_492f:
	nop ; $492f
	add hl, de ; $4930
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
	ld [$3e0a], sp ; $4966
	ld de, $0001 ; $4969
	add hl, de ; $496c
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
	ld [$3e0a], sp ; $4994
	inc de ; $4997
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
	jr nz, Label_11_4a3d ; $4a31
	ld a, $00 ; $4a33
	ld b, a ; $4a35
	ld a, $11 ; $4a36
	rst Rst18 ; $4a38
	jr nc, $4a45 ; $4a39
	push af ; $4a3b
	INCBIN "data/bank_011/d_4a3c.bin" ; $4a3c, 1 bytes
Label_11_4a3d:
	inc a ; $4a3d
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
	ld [$cd0a], sp ; $4a51
	ld l, b ; $4a54
	ld c, l ; $4a55
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
	jr nc, Label_11_4a97 ; $4a8b
	push af ; $4a8d
	ld a, $14 ; $4a8e
	rst Rst18 ; $4a90
	inc b ; $4a91
	ld a, [bc] ; $4a92
	pop af ; $4a93
	ld a, $00 ; $4a94
	INCBIN "data/bank_011/d_4a96.bin" ; $4a96, 1 bytes
Label_11_4a97:
	ld [bc], a ; $4a97
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
	jr nz, Label_11_4ace ; $4ac2
	ld a, $11 ; $4ac4
	ld b, $00 ; $4ac6
	rst Rst18 ; $4ac8
	inc l ; $4ac9
	ld a, [bc] ; $4aca
	ld a, $00 ; $4acb
	INCBIN "data/bank_011/d_4acd.bin" ; $4acd, 1 bytes
Label_11_4ace:
	ld [bc], a ; $4ace
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
	ld [$3e0a], sp ; $4ae6
	ld de, $0216 ; $4ae9
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
	ld [$f50a], sp ; $4b32
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
	ld [$3e0a], sp ; $4b6c
	nop ; $4b6f
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
	ld [$3e0a], sp ; $4bcd
	ld de, $0216 ; $4bd0
	rst Rst18 ; $4bd3
	inc [hl] ; $4bd4
	ld a, [bc] ; $4bd5
	ld a, $11 ; $4bd6
	rst Rst18 ; $4bd8
	ld [hl], $0a ; $4bd9
	ld a, $11 ; $4bdb
	rst Rst18 ; $4bdd
	ld [$3e0a], sp ; $4bde
	nop ; $4be1
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
	ld [$f50a], sp ; $4bfb
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
	jr c, Label_11_4c27 ; $4c1b
	ld a, $11 ; $4c1d
	ld b, $c0 ; $4c1f
	rst Rst18 ; $4c21
	ld l, $0a ; $4c22
	ld a, $11 ; $4c24
	INCBIN "data/bank_011/d_4c26.bin" ; $4c26, 1 bytes
Label_11_4c27:
	ld [bc], a ; $4c27
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
	ld [$3e0a], sp ; $4c7f
	ld de, $0001 ; $4c82
	add hl, de ; $4c85
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
	ld [$3e0a], sp ; $4cab
	ld de, $0316 ; $4cae
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
	INCBIN "data/bank_011/d_4d16.bin" ; $4d16, 10 bytes
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
	INCBIN "data/bank_011/d_4d68.bin" ; $4d68, 44 bytes
Func_11_4d94:
	ld bc, $0010 ; $4d94
	rst Rst18 ; $4d97
	jr c, Label_11_4da4 ; $4d98
	ld a, $00 ; $4d9a
	ld bc, $0018 ; $4d9c
	rst Rst18 ; $4d9f
	jr Label_11_4dac ; $4da0
	INCBIN "data/bank_011/d_4da2.bin" ; $4da2, 2 bytes
Label_11_4da4:
	ld bc, $0018 ; $4da4
	rst Rst18 ; $4da7
	jr Label_11_4db4 ; $4da8
	INCBIN "data/bank_011/d_4daa.bin" ; $4daa, 2 bytes
Label_11_4dac:
	nop ; $4dac
	jr $4dc0 ; $4dad
	INCBIN "data/bank_011/d_4daf.bin" ; $4daf, 5 bytes
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
	jr nz, Label_11_4df6 ; $4dea
	ld a, [$c90d] ; $4dec
	or a, a ; $4def
	jr z, $4df5 ; $4df0
	rst Rst18 ; $4df2
	INCBIN "data/bank_011/d_4df3.bin" ; $4df3, 3 bytes
Label_11_4df6:
	ld [de], a ; $4df6
	rst Rst18 ; $4df7
	ld [$3e0a], sp ; $4df8
	rrca ; $4dfb
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
	jr nc, Label_11_4e2b ; $4e1f
	ld bc, $0020 ; $4e21
	rst Rst18 ; $4e24
	jr c, Label_11_4e31 ; $4e25
	ld a, $12 ; $4e27
	INCBIN "data/bank_011/d_4e29.bin" ; $4e29, 2 bytes
Label_11_4e2b:
	jr Label_11_4e3e ; $4e2b
	INCBIN "data/bank_011/d_4e2d.bin" ; $4e2d, 4 bytes
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
	INCBIN "data/bank_011/d_4e3d.bin" ; $4e3d, 1 bytes
Label_11_4e3e:
	nop ; $4e3e
	ld de, $3adf ; $4e3f
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
	ld [$3e0a], sp ; $4e84
	ld c, $01 ; $4e87
	ld b, b ; $4e89
	add hl, de ; $4e8a
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
	ld [$f50a], sp ; $4eb4
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
	ld [$cd0a], sp ; $4f15
	add a, h ; $4f18
	ld c, a ; $4f19
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
	INCBIN "data/bank_011/d_4f40.bin" ; $4f40, 1404 bytes
	rst Rst18 ; $54bc
	ld l, $0a ; $54bd
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
	INCBIN "data/bank_011/d_7643.bin" ; $7643, 2493 bytes

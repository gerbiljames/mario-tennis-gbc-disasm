INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $15", ROMX[$4000], BANK[$15]

	INCBIN "data/bank_015/d_4000.bin" ; $4000, 2317 bytes
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
	ld a, [$c2b0] ; $497a
	add a, a ; $497d
	add a, $91 ; $497e
	ld l, a ; $4980
	adc a, $49 ; $4981
	sub a, l ; $4983
	ld h, a ; $4984
	ld a, [hl+] ; $4985
	ld h, [hl] ; $4986
	ld l, a ; $4987
	rst Rst18 ; $4988
	ld c, $0a ; $4989
	ld a, $03 ; $498b
	rst Rst18 ; $498d
	INCBIN "data/bank_015/d_498e.bin" ; $498e, 2 bytes
	ret ; $4990
	INCBIN "data/bank_015/d_4991.bin" ; $4991, 57 bytes
	rst Rst18 ; $49ca
	ld c, $0a ; $49cb
	ld a, $05 ; $49cd
	rst Rst18 ; $49cf
	ld [$c90a], sp ; $49d0
	ld a, e ; $49d3
	ld a, [de] ; $49d4
	ld a, [hl] ; $49d5
	ld a, [de] ; $49d6
	add a, c ; $49d7
	ld a, [de] ; $49d8
	add a, c ; $49d9
	ld a, [de] ; $49da
	add a, c ; $49db
	ld a, [de] ; $49dc
	ld a, [$c2b0] ; $49dd
	add a, a ; $49e0
	add a, $f4 ; $49e1
	ld l, a ; $49e3
	adc a, $49 ; $49e4
	sub a, l ; $49e6
	ld h, a ; $49e7
	ld a, [hl+] ; $49e8
	ld h, [hl] ; $49e9
	ld l, a ; $49ea
	rst Rst18 ; $49eb
	ld c, $0a ; $49ec
	ld a, $08 ; $49ee
	rst Rst18 ; $49f0
	ld [$c90a], sp ; $49f1
	adc a, a ; $49f4
	ld a, [de] ; $49f5
	sub a, l ; $49f6
	ld a, [de] ; $49f7
	sbc a, c ; $49f8
	ld a, [de] ; $49f9
	sbc a, c ; $49fa
	ld a, [de] ; $49fb
	sbc a, c ; $49fc
	ld a, [de] ; $49fd
	ld a, [$c2b0] ; $49fe
	add a, a ; $4a01
	add a, $15 ; $4a02
	ld l, a ; $4a04
	adc a, $4a ; $4a05
	sub a, l ; $4a07
	ld h, a ; $4a08
	ld a, [hl+] ; $4a09
	ld h, [hl] ; $4a0a
	ld l, a ; $4a0b
	rst Rst18 ; $4a0c
	ld c, $0a ; $4a0d
	ld a, $09 ; $4a0f
	rst Rst18 ; $4a11
	ld [$c90a], sp ; $4a12
	sub a, b ; $4a15
	ld a, [de] ; $4a16
	sub a, [hl] ; $4a17
	ld a, [de] ; $4a18
	sbc a, d ; $4a19
	ld a, [de] ; $4a1a
	sbc a, d ; $4a1b
	ld a, [de] ; $4a1c
	sbc a, d ; $4a1d
	ld a, [de] ; $4a1e
	ld a, [$c2b0] ; $4a1f
	add a, a ; $4a22
	add a, $36 ; $4a23
	ld l, a ; $4a25
	adc a, $4a ; $4a26
	sub a, l ; $4a28
	ld h, a ; $4a29
	ld a, [hl+] ; $4a2a
	ld h, [hl] ; $4a2b
	ld l, a ; $4a2c
	rst Rst18 ; $4a2d
	ld c, $0a ; $4a2e
	ld a, $0a ; $4a30
	rst Rst18 ; $4a32
	ld [$c90a], sp ; $4a33
	sub a, c ; $4a36
	ld a, [de] ; $4a37
	sub a, a ; $4a38
	ld a, [de] ; $4a39
	sbc a, e ; $4a3a
	ld a, [de] ; $4a3b
	sbc a, e ; $4a3c
	ld a, [de] ; $4a3d
	sbc a, e ; $4a3e
	ld a, [de] ; $4a3f
	ld a, [$c2b0] ; $4a40
	add a, a ; $4a43
	add a, $76 ; $4a44
	ld l, a ; $4a46
	adc a, $4a ; $4a47
	sub a, l ; $4a49
	ld h, a ; $4a4a
	ld a, [hl+] ; $4a4b
	ld h, [hl] ; $4a4c
	ld l, a ; $4a4d
	rst Rst18 ; $4a4e
	ld c, $0a ; $4a4f
	ld a, [$c2b0] ; $4a51
	cp a, $01 ; $4a54
	jr z, Label_15_4a70 ; $4a56
	ld a, $0b ; $4a58
	rst Rst18 ; $4a5a
	ld a, [bc] ; $4a5b
	ld a, [bc] ; $4a5c
	rst Rst18 ; $4a5d
	ld [de], a ; $4a5e
	ld a, [bc] ; $4a5f
	rst Rst18 ; $4a60
	inc c ; $4a61
	ld a, [bc] ; $4a62
	push af ; $4a63
	ld a, $05 ; $4a64
	rst Rst18 ; $4a66
	inc b ; $4a67
	ld a, [bc] ; $4a68
	pop af ; $4a69
	and a, a ; $4a6a
	jr z, Label_15_4a70 ; $4a6b
	rst Rst18 ; $4a6d
	INCBIN "data/bank_015/d_4a6e.bin" ; $4a6e, 2 bytes
Label_15_4a70:
	ld a, $0b ; $4a70
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
	INCBIN "data/bank_015/d_4b70.bin" ; $4b70, 1614 bytes
	ld a, $00 ; $51be
	ld bc, $0008 ; $51c0
	rst Rst18 ; $51c3
	jr $51d0 ; $51c4
	ld a, $00 ; $51c6
	ld b, $01 ; $51c8
	rst Rst18 ; $51ca
	inc l ; $51cb
	ld a, [bc] ; $51cc
	ld a, $00 ; $51cd
	ld bc, $2d00 ; $51cf
	ld de, $2b00 ; $51d2
	rst Rst18 ; $51d5
	inc h ; $51d6
	ld a, [bc] ; $51d7
	ld a, $00 ; $51d8
	rst Rst18 ; $51da
	jr nz, $51e7 ; $51db
	ld a, $00 ; $51dd
	ld b, $00 ; $51df
	rst Rst18 ; $51e1
	inc l ; $51e2
	ld a, [bc] ; $51e3
	ld a, $00 ; $51e4
	ld b, $c0 ; $51e6
	rst Rst18 ; $51e8
	ld l, $0a ; $51e9
	rst Rst30 ; $51eb
	jr nz, Label_15_5207 ; $51ec
	jr nz, Label_15_51f4 ; $51ee
	call Func_15_6fcf ; $51f0
	ret ; $51f3
Label_15_51f4:
	rst Rst30 ; $51f4
	ld b, b ; $51f5
	add hl, de ; $51f6
	jr nz, Label_15_521e ; $51f7
	rst Rst30 ; $51f9
	ret nz ; $51fa
	rla ; $51fb
	jr nz, Label_15_5207 ; $51fc
	rst Rst30 ; $51fe
	ld h, b ; $51ff
	ld a, [bc] ; $5200
	jr z, Label_15_5207 ; $5201
	call Func_15_706e ; $5203
	ret ; $5206
Label_15_5207:
	ld hl, $1c80 ; $5207
	rst Rst18 ; $520a
	ld c, $0a ; $520b
	rst Rst30 ; $520d
	ldh [$ff0a], a ; $520e
	jr z, Label_15_5218 ; $5210
	ld hl, $1c83 ; $5212
	rst Rst18 ; $5215
	ld c, $0a ; $5216
Label_15_5218:
	ld a, $12 ; $5218
	rst Rst18 ; $521a
	ld [$c90a], sp ; $521b
Label_15_521e:
	rst Rst30 ; $521e
	ld h, b ; $521f
	add hl, de ; $5220
	jr nz, Label_15_5248 ; $5221
	rst Rst30 ; $5223
	ret nz ; $5224
	rla ; $5225
	jr nz, Label_15_5231 ; $5226
	rst Rst30 ; $5228
	ldh [$ff0a], a ; $5229
	jr z, Label_15_5231 ; $522b
	call Func_15_711d ; $522d
	ret ; $5230
Label_15_5231:
	ld hl, $1c9e ; $5231
	rst Rst18 ; $5234
	ld c, $0a ; $5235
	rst Rst30 ; $5237
	ldh [$ff0a], a ; $5238
	jr z, Label_15_5242 ; $523a
	ld hl, $1c9c ; $523c
	rst Rst18 ; $523f
	ld c, $0a ; $5240
Label_15_5242:
	ld a, $12 ; $5242
	rst Rst18 ; $5244
	ld [$c90a], sp ; $5245
Label_15_5248:
	ld hl, $1cbb ; $5248
	rst Rst18 ; $524b
	ld c, $0a ; $524c
	ld a, $12 ; $524e
	rst Rst18 ; $5250
	ld [$c90a], sp ; $5251
	rst Rst30 ; $5254
	add a, b ; $5255
	add hl, de ; $5256
	jr nz, Label_15_525d ; $5257
	call Func_15_6b94 ; $5259
	ret ; $525c
Label_15_525d:
	rst Rst30 ; $525d
	and a, b ; $525e
	add hl, de ; $525f
	jr nz, Label_15_5266 ; $5260
	call Func_15_6c3c ; $5262
	ret ; $5265
Label_15_5266:
	call Func_15_6ce4 ; $5266
	ret ; $5269
	INCBIN "data/bank_015/d_526a.bin" ; $526a, 45 bytes
	rst Rst30 ; $5297
	ldh [rAUD2HIGH], a ; $5298
	jr nz, Label_15_52a0 ; $529a
	call Func_15_6db4 ; $529c
	ret ; $529f
Label_15_52a0:
	rst Rst30 ; $52a0
	nop ; $52a1
	ld a, [de] ; $52a2
	jr nz, Label_15_52d5 ; $52a3
	rst Rst30 ; $52a5
	ldh [rAUD2ENV], a ; $52a6
	jr nz, Label_15_52b3 ; $52a8
	rst Rst30 ; $52aa
	ld h, b ; $52ab
	ld a, [bc] ; $52ac
	jr z, Label_15_52b3 ; $52ad
	call Func_15_6e4b ; $52af
	ret ; $52b2
Label_15_52b3:
	ld hl, $1ce1 ; $52b3
	rst Rst18 ; $52b6
	ld c, $0a ; $52b7
	rst Rst30 ; $52b9
	ld h, b ; $52ba
	ld a, [bc] ; $52bb
	jr z, Label_15_52cf ; $52bc
	ld hl, $1ce2 ; $52be
	rst Rst18 ; $52c1
	ld c, $0a ; $52c2
	rst Rst30 ; $52c4
	ldh [$ff0a], a ; $52c5
	jr z, Label_15_52cf ; $52c7
	ld hl, $1ce2 ; $52c9
	rst Rst18 ; $52cc
	ld c, $0a ; $52cd
Label_15_52cf:
	ld a, $0d ; $52cf
	rst Rst18 ; $52d1
	ld [$c90a], sp ; $52d2
Label_15_52d5:
	rst Rst30 ; $52d5
	jr nz, Label_15_52f2 ; $52d6
	jr nz, Label_15_52f4 ; $52d8
	rst Rst30 ; $52da
	ldh [rAUD2ENV], a ; $52db
	jr nz, Label_15_52e8 ; $52dd
	rst Rst30 ; $52df
	ldh [$ff0a], a ; $52e0
	jr z, Label_15_52e8 ; $52e2
	call Func_15_6ece ; $52e4
	ret ; $52e7
Label_15_52e8:
	ld hl, $1cf8 ; $52e8
	rst Rst18 ; $52eb
	ld c, $0a ; $52ec
	ld a, $0d ; $52ee
	rst Rst18 ; $52f0
	INCBIN "data/bank_015/d_52f1.bin" ; $52f1, 1 bytes
Label_15_52f2:
	ld a, [bc] ; $52f2
	ret ; $52f3
Label_15_52f4:
	ld hl, $2012 ; $52f4
	rst Rst18 ; $52f7
	ld c, $0a ; $52f8
	ld a, $0d ; $52fa
	rst Rst18 ; $52fc
	ld [$c90a], sp ; $52fd
	ld bc, $00ff ; $5300
	nop ; $5303
	add hl, bc ; $5304
	ld d, e ; $5305
	nop ; $5306
	nop ; $5307
	rst Rst38 ; $5308
	ret ; $5309
	INCBIN "data/bank_015/d_530a.bin" ; $530a, 36 bytes
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
	jr z, $53fa ; $5395
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
	ld a, [$c2b1] ; $53f9
	ld b, $40 ; $53fc
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
	INCBIN "data/bank_015/d_5437.bin" ; $5437, 176 bytes
	xor a, a ; $54e7
	ld [$c2d5], a ; $54e8
	ld bc, $00f0 ; $54eb
	rst Rst18 ; $54ee
	jr c, Label_15_54fb ; $54ef
	ld a, $00 ; $54f1
	ld bc, $2d00 ; $54f3
	ld de, $2b00 ; $54f6
	rst Rst18 ; $54f9
	ld [hl+], a ; $54fa
Label_15_54fb:
	ld a, [bc] ; $54fb
	ld a, $02 ; $54fc
	ld bc, $2f00 ; $54fe
	ld de, $2b00 ; $5501
	rst Rst18 ; $5504
	ld [hl+], a ; $5505
	ld a, [bc] ; $5506
	xor a, a ; $5507
	ld bc, $2d00 ; $5508
	ld de, $2b00 ; $550b
	rst Rst18 ; $550e
	ld a, [hl-] ; $550f
	ld a, [bc] ; $5510
	rst Rst18 ; $5511
	ld a, $0a ; $5512
	ld a, $00 ; $5514
	ld b, $c0 ; $5516
	rst Rst18 ; $5518
	ld l, $0a ; $5519
	ld a, $02 ; $551b
	ld b, $c0 ; $551d
	rst Rst18 ; $551f
	ld l, $0a ; $5520
	ld a, $12 ; $5522
	ld b, $00 ; $5524
	rst Rst18 ; $5526
	ld l, $0a ; $5527
	ld c, $04 ; $5529
	call Func_00_1d2e ; $552b
	call Func_00_1da4 ; $552e
	ret ; $5531
	INCBIN "data/bank_015/d_5532.bin" ; $5532, 1166 bytes
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
	INCBIN "data/bank_015/d_668f.bin" ; $668f, 1279 bytes
Label_15_6b8e:
	ld a, $0c ; $6b8e
	rst Rst18 ; $6b90
	ld [$c90a], sp ; $6b91
Func_15_6b94:
	ld a, $0c ; $6b94
	ld b, a ; $6b96
	ld a, $02 ; $6b97
	rst Rst18 ; $6b99
	jr nc, Label_15_6ba6 ; $6b9a
	ld hl, $206f ; $6b9c
	rst Rst18 ; $6b9f
	ld c, $0a ; $6ba0
	ld a, $0c ; $6ba2
	rst Rst18 ; $6ba4
	ld a, [bc] ; $6ba5
Label_15_6ba6:
	ld a, [bc] ; $6ba6
	rst Rst18 ; $6ba7
	ld [de], a ; $6ba8
	ld a, [bc] ; $6ba9
	rst Rst18 ; $6baa
	inc c ; $6bab
	ld a, [bc] ; $6bac
	push af ; $6bad
	ld a, $05 ; $6bae
	rst Rst18 ; $6bb0
	inc b ; $6bb1
	ld a, [bc] ; $6bb2
	pop af ; $6bb3
	and a, a ; $6bb4
	jp nz, Label_15_6b8e ; $6bb5
	rst Rst18 ; $6bb8
	INCBIN "data/bank_015/d_6bb9.bin" ; $6bb9, 131 bytes
Func_15_6c3c:
	ld a, $0c ; $6c3c
	ld b, a ; $6c3e
	ld a, $02 ; $6c3f
	rst Rst18 ; $6c41
	jr nc, Label_15_6c4e ; $6c42
	ld hl, $2085 ; $6c44
	rst Rst18 ; $6c47
	ld c, $0a ; $6c48
	ld a, $0c ; $6c4a
	rst Rst18 ; $6c4c
	ld a, [bc] ; $6c4d
Label_15_6c4e:
	ld a, [bc] ; $6c4e
	rst Rst18 ; $6c4f
	ld [de], a ; $6c50
	ld a, [bc] ; $6c51
	rst Rst18 ; $6c52
	inc c ; $6c53
	ld a, [bc] ; $6c54
	push af ; $6c55
	ld a, $05 ; $6c56
	rst Rst18 ; $6c58
	inc b ; $6c59
	ld a, [bc] ; $6c5a
	pop af ; $6c5b
	and a, a ; $6c5c
	jp nz, Label_15_6b8e ; $6c5d
	rst Rst18 ; $6c60
	INCBIN "data/bank_015/d_6c61.bin" ; $6c61, 131 bytes
Func_15_6ce4:
	ld a, $0c ; $6ce4
	ld b, a ; $6ce6
	ld a, $02 ; $6ce7
	rst Rst18 ; $6ce9
	jr nc, Label_15_6cf6 ; $6cea
	ld hl, $2095 ; $6cec
	rst Rst18 ; $6cef
	ld c, $0a ; $6cf0
	ld a, $0c ; $6cf2
	rst Rst18 ; $6cf4
	ld a, [bc] ; $6cf5
Label_15_6cf6:
	ld a, [bc] ; $6cf6
	rst Rst18 ; $6cf7
	ld [de], a ; $6cf8
	ld a, [bc] ; $6cf9
	rst Rst18 ; $6cfa
	inc c ; $6cfb
	ld a, [bc] ; $6cfc
	push af ; $6cfd
	ld a, $05 ; $6cfe
	rst Rst18 ; $6d00
	inc b ; $6d01
	ld a, [bc] ; $6d02
	pop af ; $6d03
	and a, a ; $6d04
	jp nz, Label_15_6b8e ; $6d05
	rst Rst18 ; $6d08
	INCBIN "data/bank_015/d_6d09.bin" ; $6d09, 165 bytes
Label_15_6dae:
	ld a, $0d ; $6dae
	rst Rst18 ; $6db0
	ld [$c90a], sp ; $6db1
Func_15_6db4:
	ld hl, $1cc4 ; $6db4
	rst Rst18 ; $6db7
	ld c, $0a ; $6db8
	rst Rst30 ; $6dba
	ld h, b ; $6dbb
	ld a, [bc] ; $6dbc
	jr z, Label_15_6dc2 ; $6dbd
	rst Rst18 ; $6dbf
	INCBIN "data/bank_015/d_6dc0.bin" ; $6dc0, 2 bytes
Label_15_6dc2:
	ld a, $0d ; $6dc2
	ld b, a ; $6dc4
	ld a, $02 ; $6dc5
	rst Rst18 ; $6dc7
	jr nc, $6dd4 ; $6dc8
	ld a, $0d ; $6dca
	rst Rst18 ; $6dcc
	ld a, [bc] ; $6dcd
	ld a, [bc] ; $6dce
	ld hl, $1cc6 ; $6dcf
	rst Rst18 ; $6dd2
	ld c, $0a ; $6dd3
	rst Rst18 ; $6dd5
	ld [de], a ; $6dd6
	ld a, [bc] ; $6dd7
	rst Rst18 ; $6dd8
	inc c ; $6dd9
	ld a, [bc] ; $6dda
	push af ; $6ddb
	ld a, $05 ; $6ddc
	rst Rst18 ; $6dde
	inc b ; $6ddf
	ld a, [bc] ; $6de0
	pop af ; $6de1
	and a, a ; $6de2
	jp nz, Label_15_6dae ; $6de3
	rst Rst18 ; $6de6
	INCBIN "data/bank_015/d_6de7.bin" ; $6de7, 2 bytes
	ld a, $0d ; $6de9
	rst Rst18 ; $6deb
	ld a, [bc] ; $6dec
	ld a, [bc] ; $6ded
	rst Rst18 ; $6dee
	ld [de], a ; $6def
	ld a, [bc] ; $6df0
	rst Rst18 ; $6df1
	inc c ; $6df2
	ld a, [bc] ; $6df3
	push af ; $6df4
	ld a, $05 ; $6df5
	rst Rst18 ; $6df7
	inc b ; $6df8
	ld a, [bc] ; $6df9
	pop af ; $6dfa
	and a, a ; $6dfb
	jp nz, Label_15_6dae ; $6dfc
	rst Rst18 ; $6dff
	INCBIN "data/bank_015/d_6e00.bin" ; $6e00, 2 bytes
	ld a, $0d ; $6e02
	rst Rst18 ; $6e04
	INCBIN "data/bank_015/d_6e05.bin" ; $6e05, 2 bytes
	call Func_15_7d14 ; $6e07
	ld a, $0d ; $6e0a
	ld b, $00 ; $6e0c
	rst Rst18 ; $6e0e
	ld l, $0a ; $6e0f
	ld hl, $1cca ; $6e11
	rst Rst18 ; $6e14
	ld c, $0a ; $6e15
	ld a, $0d ; $6e17
	rst Rst18 ; $6e19
	INCBIN "data/bank_015/d_6e1a.bin" ; $6e1a, 2 bytes
	ld a, $0d ; $6e1c
	ld d, $02 ; $6e1e
	rst Rst18 ; $6e20
	inc [hl] ; $6e21
	ld a, [bc] ; $6e22
	ld a, $0d ; $6e23
	rst Rst18 ; $6e25
	ld [hl], $0a ; $6e26
	ld a, $0f ; $6e28
	ld [$c8f7], a ; $6e2a
	ld a, $0f ; $6e2d
	ld [wStoryModeCurrentLocation], a ; $6e2f
	ld a, $09 ; $6e32
	ld [$c295], a ; $6e34
	ld a, $ff ; $6e37
	ld [$c294], a ; $6e39
	ld [$c2a1], a ; $6e3c
	ld c, $10 ; $6e3f
	call Func_00_1d20 ; $6e41
	call Func_00_1da4 ; $6e44
	rst Rst18 ; $6e47
	ld a, [bc] ; $6e48
	rla ; $6e49
	ret ; $6e4a
Func_15_6e4b:
	ld a, $0d ; $6e4b
	ld b, a ; $6e4d
	ld a, $02 ; $6e4e
	rst Rst18 ; $6e50
	jr nc, Label_15_6e5d ; $6e51
	ld hl, $1ce3 ; $6e53
	rst Rst18 ; $6e56
	ld c, $0a ; $6e57
	ld a, $0d ; $6e59
	rst Rst18 ; $6e5b
	ld a, [bc] ; $6e5c
Label_15_6e5d:
	ld a, [bc] ; $6e5d
	rst Rst18 ; $6e5e
	ld [de], a ; $6e5f
	ld a, [bc] ; $6e60
	rst Rst18 ; $6e61
	inc c ; $6e62
	ld a, [bc] ; $6e63
	push af ; $6e64
	ld a, $05 ; $6e65
	rst Rst18 ; $6e67
	inc b ; $6e68
	ld a, [bc] ; $6e69
	pop af ; $6e6a
	and a, a ; $6e6b
	jp nz, Label_15_6dae ; $6e6c
	rst Rst18 ; $6e6f
	INCBIN "data/bank_015/d_6e70.bin" ; $6e70, 94 bytes
Func_15_6ece:
	ld a, $0d ; $6ece
	ld b, a ; $6ed0
	ld a, $02 ; $6ed1
	rst Rst18 ; $6ed3
	jr nc, Label_15_6ee0 ; $6ed4
	ld hl, $1cf9 ; $6ed6
	rst Rst18 ; $6ed9
	ld c, $0a ; $6eda
	ld a, $0d ; $6edc
	rst Rst18 ; $6ede
	ld a, [bc] ; $6edf
Label_15_6ee0:
	ld a, [bc] ; $6ee0
	rst Rst18 ; $6ee1
	ld [de], a ; $6ee2
	ld a, [bc] ; $6ee3
	rst Rst18 ; $6ee4
	inc c ; $6ee5
	ld a, [bc] ; $6ee6
	push af ; $6ee7
	ld a, $05 ; $6ee8
	rst Rst18 ; $6eea
	inc b ; $6eeb
	ld a, [bc] ; $6eec
	pop af ; $6eed
	and a, a ; $6eee
	jp nz, Label_15_6dae ; $6eef
	rst Rst18 ; $6ef2
	INCBIN "data/bank_015/d_6ef3.bin" ; $6ef3, 220 bytes
Func_15_6fcf:
	ld a, $12 ; $6fcf
	ld b, a ; $6fd1
	ld a, $02 ; $6fd2
	rst Rst18 ; $6fd4
	jr nc, $6fe1 ; $6fd5
	rst Rst30 ; $6fd7
	ld h, b ; $6fd8
	ld a, [bc] ; $6fd9
	jr nz, Label_15_6fe4 ; $6fda
	ld hl, $1c5d ; $6fdc
	rst Rst18 ; $6fdf
	ld c, $0a ; $6fe0
	jr Label_15_6fea ; $6fe2
Label_15_6fe4:
	ld hl, $1c64 ; $6fe4
	rst Rst18 ; $6fe7
	ld c, $0a ; $6fe8
Label_15_6fea:
	ld a, $12 ; $6fea
	rst Rst18 ; $6fec
	ld a, [bc] ; $6fed
	ld a, [bc] ; $6fee
	rst Rst18 ; $6fef
	ld [de], a ; $6ff0
	ld a, [bc] ; $6ff1
	rst Rst18 ; $6ff2
	inc c ; $6ff3
	ld a, [bc] ; $6ff4
	push af ; $6ff5
	ld a, $05 ; $6ff6
	rst Rst18 ; $6ff8
	inc b ; $6ff9
	ld a, [bc] ; $6ffa
	pop af ; $6ffb
	and a, a ; $6ffc
	jr nz, Label_15_7068 ; $6ffd
	rst Rst18 ; $6fff
	INCBIN "data/bank_015/d_7000.bin" ; $7000, 2 bytes
	ld a, $12 ; $7002
	rst Rst18 ; $7004
	ld a, [bc] ; $7005
	ld a, [bc] ; $7006
	rst Rst18 ; $7007
	ld [de], a ; $7008
	ld a, [bc] ; $7009
	rst Rst18 ; $700a
	inc c ; $700b
	ld a, [bc] ; $700c
	push af ; $700d
	ld a, $05 ; $700e
	rst Rst18 ; $7010
	inc b ; $7011
	ld a, [bc] ; $7012
	pop af ; $7013
	and a, a ; $7014
	jr nz, Label_15_7068 ; $7015
	rst Rst18 ; $7017
	INCBIN "data/bank_015/d_7018.bin" ; $7018, 2 bytes
	ld a, $12 ; $701a
	rst Rst18 ; $701c
	INCBIN "data/bank_015/d_701d.bin" ; $701d, 2 bytes
	call Func_15_7cbb ; $701f
	ld a, $12 ; $7022
	ld b, $80 ; $7024
	rst Rst18 ; $7026
	ld l, $0a ; $7027
	ld a, $12 ; $7029
	rst Rst18 ; $702b
	INCBIN "data/bank_015/d_702c.bin" ; $702c, 2 bytes
	ld a, $12 ; $702e
	ld d, $02 ; $7030
	rst Rst18 ; $7032
	inc [hl] ; $7033
	ld a, [bc] ; $7034
	ld a, $12 ; $7035
	rst Rst18 ; $7037
	ld [hl], $0a ; $7038
	ld hl, $1c63 ; $703a
	rst Rst18 ; $703d
	ld c, $0a ; $703e
	ld a, $12 ; $7040
	rst Rst18 ; $7042
	INCBIN "data/bank_015/d_7043.bin" ; $7043, 2 bytes
	ld a, $09 ; $7045
	ld [$c8f7], a ; $7047
	ld a, $0f ; $704a
	ld [wStoryModeCurrentLocation], a ; $704c
	ld a, $09 ; $704f
	ld [$c295], a ; $7051
	ld a, $ff ; $7054
	ld [$c294], a ; $7056
	ld [$c2a1], a ; $7059
	ld c, $10 ; $705c
	call Func_00_1d20 ; $705e
	call Func_00_1da4 ; $7061
	rst Rst18 ; $7064
	ld a, [bc] ; $7065
	rla ; $7066
	ret ; $7067
Label_15_7068:
	ld a, $12 ; $7068
	rst Rst18 ; $706a
	ld [$c90a], sp ; $706b
Func_15_706e:
	ld a, $12 ; $706e
	ld b, a ; $7070
	ld a, $02 ; $7071
	rst Rst18 ; $7073
	jr nc, Label_15_7080 ; $7074
	ld hl, $1c86 ; $7076
	rst Rst18 ; $7079
	ld c, $0a ; $707a
	ld a, $12 ; $707c
	rst Rst18 ; $707e
	ld a, [bc] ; $707f
Label_15_7080:
	ld a, [bc] ; $7080
	rst Rst18 ; $7081
	ld [de], a ; $7082
	ld a, [bc] ; $7083
	rst Rst18 ; $7084
	inc c ; $7085
	ld a, [bc] ; $7086
	push af ; $7087
	ld a, $05 ; $7088
	rst Rst18 ; $708a
	inc b ; $708b
	ld a, [bc] ; $708c
	pop af ; $708d
	and a, a ; $708e
	jr nz, Label_15_7068 ; $708f
	rst Rst18 ; $7091
	INCBIN "data/bank_015/d_7092.bin" ; $7092, 139 bytes
Func_15_711d:
	ld a, $12 ; $711d
	ld b, a ; $711f
	ld a, $02 ; $7120
	rst Rst18 ; $7122
	jr nc, Label_15_712f ; $7123
	ld hl, $1c9f ; $7125
	rst Rst18 ; $7128
	ld c, $0a ; $7129
	ld a, $12 ; $712b
	rst Rst18 ; $712d
	ld a, [bc] ; $712e
Label_15_712f:
	ld a, [bc] ; $712f
	rst Rst18 ; $7130
	ld [de], a ; $7131
	ld a, [bc] ; $7132
	rst Rst18 ; $7133
	inc c ; $7134
	ld a, [bc] ; $7135
	push af ; $7136
	ld a, $05 ; $7137
	rst Rst18 ; $7139
	inc b ; $713a
	ld a, [bc] ; $713b
	pop af ; $713c
	and a, a ; $713d
	jp nz, Label_15_7068 ; $713e
	rst Rst18 ; $7141
	INCBIN "data/bank_015/d_7142.bin" ; $7142, 124 bytes
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
	INCBIN "data/bank_015/d_752c.bin" ; $752c, 13 bytes
	ld a, [$c2e3] ; $7539
	ld a, a ; $753c
	rst Rst00 ; $753d
	ld a, d ; $753e
	ld [hl], l ; $753f
	adc a, h ; $7540
	halt ; $7541
	sbc a, c ; $7542
	halt ; $7543
	and a, [hl] ; $7544
	halt ; $7545
	or a, e ; $7546
	halt ; $7547
	ret nz ; $7548
	halt ; $7549
	adc a, h ; $754a
	halt ; $754b
	adc a, h ; $754c
	halt ; $754d
	ld a, [$c2e3] ; $754e
	ld a, a ; $7551
	rst Rst00 ; $7552
	reti ; $7553
	INCBIN "data/bank_015/d_7554.bin" ; $7554, 85 bytes
	rst Rst18 ; $75a9
	ld [$3e0a], sp ; $75aa
	ld [de], a ; $75ad
	ld d, $02 ; $75ae
	rst Rst18 ; $75b0
	inc [hl] ; $75b1
	ld a, [bc] ; $75b2
	ld a, $12 ; $75b3
	rst Rst18 ; $75b5
	ld [hl], $0a ; $75b6
	ld a, $12 ; $75b8
	rst Rst18 ; $75ba
	ld [$3e0a], sp ; $75bb
	ld [de], a ; $75be
	ld d, $04 ; $75bf
	rst Rst18 ; $75c1
	inc [hl] ; $75c2
	ld a, [bc] ; $75c3
	ld a, $12 ; $75c4
	rst Rst18 ; $75c6
	ld [hl], $0a ; $75c7
	ld a, $12 ; $75c9
	rst Rst18 ; $75cb
	ld [$3e0a], sp ; $75cc
	ld [de], a ; $75cf
	ld b, $00 ; $75d0
	rst Rst18 ; $75d2
	ld l, $0a ; $75d3
	rst Rst20 ; $75d5
	ret nz ; $75d6
	rla ; $75d7
	ret ; $75d8
	INCBIN "data/bank_015/d_75d9.bin" ; $75d9, 205 bytes
	call Func_15_7752 ; $76a6
	ld hl, $1c73 ; $76a9
	rst Rst18 ; $76ac
	ld c, $0a ; $76ad
	call Func_15_7728 ; $76af
	ret ; $76b2
	INCBIN "data/bank_015/d_76b3.bin" ; $76b3, 117 bytes
Func_15_7728:
	ld a, $12 ; $7728
	rst Rst18 ; $772a
	INCBIN "data/bank_015/d_772b.bin" ; $772b, 2 bytes
	ld a, $12 ; $772d
	rst Rst18 ; $772f
	ld a, [bc] ; $7730
	ld a, [bc] ; $7731
	rst Rst18 ; $7732
	ld [de], a ; $7733
	ld a, [bc] ; $7734
	rst Rst18 ; $7735
	inc c ; $7736
	ld a, [bc] ; $7737
	push af ; $7738
	ld a, $05 ; $7739
	rst Rst18 ; $773b
	inc b ; $773c
	ld a, [bc] ; $773d
	pop af ; $773e
	and a, a ; $773f
	jp z, Label_15_7749 ; $7740
	rst Rst18 ; $7743
	INCBIN "data/bank_015/d_7744.bin" ; $7744, 2 bytes
	jp Label_15_779d ; $7746
Label_15_7749:
	ld a, $12 ; $7749
	rst Rst18 ; $774b
	INCBIN "data/bank_015/d_774c.bin" ; $774c, 2 bytes
	call Func_15_7b30 ; $774e
	ret ; $7751
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
Label_15_779d:
	ld a, $12 ; $779d
	rst Rst18 ; $779f
	INCBIN "data/bank_015/d_77a0.bin" ; $77a0, 2 bytes
	ld a, $12 ; $77a2
	ld b, $00 ; $77a4
	rst Rst18 ; $77a6
	ld l, $0a ; $77a7
	ret ; $77a9
	ld a, [$c2e3] ; $77aa
	ld a, a ; $77ad
	rst Rst00 ; $77ae
	INCBIN "data/bank_015/d_77af.bin" ; $77af, 52 bytes
	call Func_15_79cb ; $77e3
	ld hl, $1cdd ; $77e6
	rst Rst18 ; $77e9
	ld c, $0a ; $77ea
	ld a, $0d ; $77ec
	rst Rst18 ; $77ee
	INCBIN "data/bank_015/d_77ef.bin" ; $77ef, 2 bytes
	ld a, $00 ; $77f1
	ld b, a ; $77f3
	ld a, $0d ; $77f4
	rst Rst18 ; $77f6
	jr nc, Label_15_7803 ; $77f7
	ld a, $0d ; $77f9
	ld d, $03 ; $77fb
	rst Rst18 ; $77fd
	inc [hl] ; $77fe
	ld a, [bc] ; $77ff
	ld a, $0d ; $7800
	rst Rst18 ; $7802
Label_15_7803:
	ld [hl], $0a ; $7803
	ld a, $0d ; $7805
	rst Rst18 ; $7807
	INCBIN "data/bank_015/d_7808.bin" ; $7808, 2 bytes
	ld a, $0d ; $780a
	ld d, $02 ; $780c
	rst Rst18 ; $780e
	inc [hl] ; $780f
	ld a, [bc] ; $7810
	ld a, $0d ; $7811
	rst Rst18 ; $7813
	ld [hl], $0a ; $7814
	rst Rst30 ; $7816
	ld h, b ; $7817
	ld a, [bc] ; $7818
	jr z, Label_15_781e ; $7819
	rst Rst18 ; $781b
	INCBIN "data/bank_015/d_781c.bin" ; $781c, 2 bytes
Label_15_781e:
	ld a, $0d ; $781e
	rst Rst18 ; $7820
	INCBIN "data/bank_015/d_7821.bin" ; $7821, 2 bytes
	ld hl, $1ce1 ; $7823
	rst Rst18 ; $7826
	ld c, $0a ; $7827
	ld a, $0d ; $7829
	ld d, $04 ; $782b
	rst Rst18 ; $782d
	inc [hl] ; $782e
	ld a, [bc] ; $782f
	ld a, $0d ; $7830
	rst Rst18 ; $7832
	ld [hl], $0a ; $7833
	rst Rst30 ; $7835
	ld h, b ; $7836
	ld a, [bc] ; $7837
	jr z, Label_15_783d ; $7838
	rst Rst18 ; $783a
	INCBIN "data/bank_015/d_783b.bin" ; $783b, 2 bytes
Label_15_783d:
	ld a, $0d ; $783d
	rst Rst18 ; $783f
	INCBIN "data/bank_015/d_7840.bin" ; $7840, 2 bytes
	ld a, $0d ; $7842
	ld b, $c0 ; $7844
	rst Rst18 ; $7846
	ld l, $0a ; $7847
	rst Rst20 ; $7849
	ldh [rAUD2ENV], a ; $784a
	ret ; $784c
	INCBIN "data/bank_015/d_784d.bin" ; $784d, 194 bytes
	call Func_15_79cb ; $790f
	ld hl, $1cd3 ; $7912
	rst Rst18 ; $7915
	ld c, $0a ; $7916
	call Func_15_799e ; $7918
	ret ; $791b
	INCBIN "data/bank_015/d_791c.bin" ; $791c, 130 bytes
Func_15_799e:
	ld a, $0d ; $799e
	rst Rst18 ; $79a0
	INCBIN "data/bank_015/d_79a1.bin" ; $79a1, 2 bytes
	ld a, $0d ; $79a3
	rst Rst18 ; $79a5
	ld a, [bc] ; $79a6
	ld a, [bc] ; $79a7
	rst Rst18 ; $79a8
	ld [de], a ; $79a9
	ld a, [bc] ; $79aa
	rst Rst18 ; $79ab
	inc c ; $79ac
	ld a, [bc] ; $79ad
	push af ; $79ae
	ld a, $05 ; $79af
	rst Rst18 ; $79b1
	inc b ; $79b2
	ld a, [bc] ; $79b3
	pop af ; $79b4
	and a, a ; $79b5
	jp z, Label_15_79bc ; $79b6
	jp Label_15_7a16 ; $79b9
Label_15_79bc:
	rst Rst18 ; $79bc
	INCBIN "data/bank_015/d_79bd.bin" ; $79bd, 2 bytes
	ld a, $0d ; $79bf
	rst Rst18 ; $79c1
	INCBIN "data/bank_015/d_79c2.bin" ; $79c2, 2 bytes
	call Func_15_7bc9 ; $79c4
	rst Rst18 ; $79c7
	ld [bc], a ; $79c8
	ld a, [bc] ; $79c9
	ret ; $79ca
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
Label_15_7a16:
	ld a, $0d ; $7a16
	rst Rst18 ; $7a18
	ld [$3e0a], sp ; $7a19
	dec c ; $7a1c
	ld b, $c0 ; $7a1d
	rst Rst18 ; $7a1f
	ld l, $0a ; $7a20
	ret ; $7a22
	INCBIN "data/bank_015/d_7a23.bin" ; $7a23, 34 bytes
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
	INCBIN "data/bank_015/d_7a85.bin" ; $7a85, 2 bytes
	call Func_15_7b30 ; $7a87
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
	INCBIN "data/bank_015/d_7b03.bin" ; $7b03, 45 bytes
Func_15_7b30:
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
	INCBIN "data/bank_015/d_7c2f.bin" ; $7c2f, 140 bytes
Func_15_7cbb:
	ld a, $00 ; $7cbb
	ld bc, $0010 ; $7cbd
	rst Rst18 ; $7cc0
	jr Label_15_7ccd ; $7cc1
	ld a, $02 ; $7cc3
	ld bc, $0010 ; $7cc5
	rst Rst18 ; $7cc8
	jr Label_15_7cd5 ; $7cc9
	ld a, $00 ; $7ccb
Label_15_7ccd:
	ld bc, $2d00 ; $7ccd
	ld de, $2b00 ; $7cd0
	rst Rst18 ; $7cd3
	inc h ; $7cd4
Label_15_7cd5:
	ld a, [bc] ; $7cd5
	rst Rst30 ; $7cd6
	ldh [rTIMA], a ; $7cd7
	jr z, Label_15_7cf0 ; $7cd9
	ld a, $02 ; $7cdb
	rst Rst18 ; $7cdd
	inc e ; $7cde
	ld a, [bc] ; $7cdf
	ld a, $02 ; $7ce0
	ld bc, $2f00 ; $7ce2
	ld de, $2b00 ; $7ce5
	rst Rst18 ; $7ce8
	inc h ; $7ce9
	ld a, [bc] ; $7cea
	ld a, $02 ; $7ceb
	rst Rst18 ; $7ced
	jr nz, Label_15_7cfa ; $7cee
Label_15_7cf0:
	ld a, $00 ; $7cf0
	rst Rst18 ; $7cf2
	jr nz, $7cff ; $7cf3
	ld a, $00 ; $7cf5
	ld b, $80 ; $7cf7
	rst Rst18 ; $7cf9
Label_15_7cfa:
	ld l, $0a ; $7cfa
	ld a, $02 ; $7cfc
	ld b, $80 ; $7cfe
	rst Rst18 ; $7d00
	ld l, $0a ; $7d01
	ld a, $00 ; $7d03
	ld bc, $0020 ; $7d05
	rst Rst18 ; $7d08
	jr $7d15 ; $7d09
	ld a, $02 ; $7d0b
	ld bc, $0020 ; $7d0d
	rst Rst18 ; $7d10
	jr $7d1d ; $7d11
	ret ; $7d13
Func_15_7d14:
	ld a, $00 ; $7d14
	ld bc, $0010 ; $7d16
	rst Rst18 ; $7d19
	jr Label_15_7d26 ; $7d1a
	ld a, $02 ; $7d1c
	ld bc, $0010 ; $7d1e
	rst Rst18 ; $7d21
	jr Label_15_7d2e ; $7d22
	ld a, $00 ; $7d24
Label_15_7d26:
	ld bc, $1300 ; $7d26
	ld de, $2b00 ; $7d29
	rst Rst18 ; $7d2c
	inc h ; $7d2d
Label_15_7d2e:
	ld a, [bc] ; $7d2e
	rst Rst30 ; $7d2f
	ldh [rTIMA], a ; $7d30
	jr z, Label_15_7d49 ; $7d32
	ld a, $02 ; $7d34
	rst Rst18 ; $7d36
	inc e ; $7d37
	ld a, [bc] ; $7d38
	ld a, $02 ; $7d39
	ld bc, $1100 ; $7d3b
	ld de, $2b00 ; $7d3e
	rst Rst18 ; $7d41
	inc h ; $7d42
	ld a, [bc] ; $7d43
	ld a, $02 ; $7d44
	rst Rst18 ; $7d46
	jr nz, Label_15_7d53 ; $7d47
Label_15_7d49:
	ld a, $00 ; $7d49
	rst Rst18 ; $7d4b
	jr nz, $7d58 ; $7d4c
	ld a, $00 ; $7d4e
	ld b, $00 ; $7d50
	rst Rst18 ; $7d52
Label_15_7d53:
	ld l, $0a ; $7d53
	ld a, $02 ; $7d55
	ld b, $00 ; $7d57
	rst Rst18 ; $7d59
	ld l, $0a ; $7d5a
	ld a, $00 ; $7d5c
	ld bc, $0020 ; $7d5e
	rst Rst18 ; $7d61
	jr Label_15_7d6e ; $7d62
	ld a, $02 ; $7d64
	ld bc, $0020 ; $7d66
	rst Rst18 ; $7d69
	jr Label_15_7d76 ; $7d6a
	ret ; $7d6c
	INCBIN "data/bank_015/d_7d6d.bin" ; $7d6d, 1 bytes
Label_15_7d6e:
	stop ; $7d6e
	nop ; $7d70
	ld a, [bc] ; $7d71
	ld bc, $0c01 ; $7d72
	INCBIN "data/bank_015/d_7d75.bin" ; $7d75, 1 bytes
Label_15_7d76:
	rst Rst38 ; $7d76
	inc de ; $7d77
	add hl, bc ; $7d78
	ld [bc], a ; $7d79
	ld [bc], a ; $7d7a
	inc d ; $7d7b
	ld bc, $0c28 ; $7d7c
	ld sp, hl ; $7d7f
	rst Rst38 ; $7d80
	inc de ; $7d81
	add hl, bc ; $7d82
	ld bc, $1402 ; $7d83
	ld bc, $0c28 ; $7d86
	ld sp, hl ; $7d89
	rst Rst38 ; $7d8a
	inc de ; $7d8b
	add hl, bc ; $7d8c
	ld bc, $1401 ; $7d8d
	ld bc, $0c28 ; $7d90
	ld sp, hl ; $7d93
	rst Rst38 ; $7d94
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

INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $07", ROMX[$4000], BANK[$07]

	INCBIN "data/bank_007/d_4000.bin" ; $4000, 72 bytes
	di ; $4048
	ldh a, [$ffc0] ; $4049
	ei ; $404b
	cp a, $c1 ; $404c
	jr z, Label_07_4061 ; $404e
	ld a, $01 ; $4050
	ldh [$ffc2], a ; $4052
	call Func_07_4b38 ; $4054
	jr nc, Label_07_4076 ; $4057
	push af ; $4059
	call Func_00_28f8 ; $405a
	pop af ; $405d
	scf ; $405e
	jr Label_07_4076 ; $405f
Label_07_4061:
	di ; $4061
	xor a, a ; $4062
	ldh [$ffc0], a ; $4063
	xor a, a ; $4065
	ldh [$ffd7], a ; $4066
	ei ; $4068
	ld a, $02 ; $4069
	ldh [$ffc2], a ; $406b
	call Func_07_4afe ; $406d
	jr nc, Label_07_4076 ; $4070
	call Func_00_28f8 ; $4072
	scf ; $4075
Label_07_4076:
	ret ; $4076
Func_07_4077:
	di ; $4077
	xor a, a ; $4078
	ldh [rIF], a ; $4079
	ld a, $09 ; $407b
	ldh [rIE], a ; $407d
	ei ; $407f
	ret ; $4080
	INCBIN "data/bank_007/d_4081.bin" ; $4081, 1534 bytes
Func_07_467f:
	di ; $467f
	ldh a, [rLY] ; $4680
	ei ; $4682
	cp a, $8c ; $4683
	jr nz, Func_07_467f ; $4685
	di ; $4687
	ldh a, [$ffc1] ; $4688
	ldh [rSB], a ; $468a
	push af ; $468c
	ld a, $03 ; $468d
	ldh [rSC], a ; $468f
	ld a, $83 ; $4691
	ldh [rSC], a ; $4693
	pop af ; $4695
	ei ; $4696
	call Func_00_2631 ; $4697
	ldh a, [$ffc0] ; $469a
	ld b, a ; $469c
	cp a, $00 ; $469d
	jr z, Label_07_46af ; $469f
	cp a, $ff ; $46a1
	jr z, Label_07_46c4 ; $46a3
	and a, $c0 ; $46a5
	cp a, $80 ; $46a7
	jr z, Label_07_46c7 ; $46a9
	cp a, $40 ; $46ab
	jr z, Label_07_46c7 ; $46ad
Label_07_46af:
	call Func_00_284b ; $46af
	ld hl, $ffc8 ; $46b2
	inc [hl] ; $46b5
	ld a, [hl] ; $46b6
	cp a, $0a ; $46b7
	jr nc, Label_07_46c1 ; $46b9
	call Func_00_2814 ; $46bb
	jp Func_07_467f ; $46be
Label_07_46c1:
	call Func_00_284b ; $46c1
Label_07_46c4:
	call Func_00_284b ; $46c4
Label_07_46c7:
	ldh a, [$ffdb] ; $46c7
	cp a, b ; $46c9
	jr nz, Label_07_46e6 ; $46ca
	and a, $3f ; $46cc
	ld hl, $ffc8 ; $46ce
	inc [hl] ; $46d1
	ld a, [hl] ; $46d2
	cp a, $02 ; $46d3
	jr nc, Label_07_46e0 ; $46d5
	call Func_00_2814 ; $46d7
	call Func_00_2814 ; $46da
	jp Func_07_467f ; $46dd
Label_07_46e0:
	call Func_00_28b9 ; $46e0
	call Func_00_284b ; $46e3
Label_07_46e6:
	ld a, b ; $46e6
	ldh [$ffdb], a ; $46e7
	ldh [$ffda], a ; $46e9
	xor a, a ; $46eb
	ldh [$ffc8], a ; $46ec
	ret ; $46ee
Func_07_46ef:
	call Func_07_4a29 ; $46ef
	jr c, Label_07_470c ; $46f2
	push bc ; $46f4
	call Func_00_2631 ; $46f5
	pop bc ; $46f8
	di ; $46f9
	cp a, $00 ; $46fa
	jr z, Label_07_470c ; $46fc
	cp a, $ff ; $46fe
	jr z, Label_07_470f ; $4700
	and a, $c0 ; $4702
	cp a, $40 ; $4704
	jr z, Label_07_4712 ; $4706
	cp a, $80 ; $4708
	jr z, Label_07_4712 ; $470a
Label_07_470c:
	call Func_00_284b ; $470c
Label_07_470f:
	call Func_00_284b ; $470f
Label_07_4712:
	ldh a, [$ffdb] ; $4712
	cp a, b ; $4714
	jr nz, Label_07_471b ; $4715
	and a, $3f ; $4717
	jr Label_07_470c ; $4719
Label_07_471b:
	ld a, b ; $471b
	ldh [$ffdb], a ; $471c
	ldh [$ffda], a ; $471e
	xor a, a ; $4720
	ldh [$ffc8], a ; $4721
	ei ; $4723
	ret ; $4724
	INCBIN "data/bank_007/d_4725.bin" ; $4725, 289 bytes
	push af ; $4846
	push bc ; $4847
	push de ; $4848
	push hl ; $4849
	ld a, [$c33f] ; $484a
	or a, a ; $484d
	jp z, Label_07_48f1 ; $484e
	ldh a, [$ffd8] ; $4851
	or a, a ; $4853
	jp nz, Label_07_48df ; $4854
	rst Rst08 ; $4857
	nop ; $4858
	call DisableLCDSafely ; $4859
	ld a, $01 ; $485c
	ldh [$ffd8], a ; $485e
	rst Rst18 ; $4860
	ld e, $07 ; $4861
	ldh a, [$ffc2] ; $4863
	cp a, $02 ; $4865
	jp z, Label_07_48a7 ; $4867
	cp a, $01 ; $486a
	jr z, Label_07_4871 ; $486c
	call Func_00_284b ; $486e
Label_07_4871:
	ld a, $40 ; $4871
	ldh [$ffdc], a ; $4873
	call Func_00_2821 ; $4875
	call Func_00_2821 ; $4878
	call Func_00_2821 ; $487b
	call Func_00_2821 ; $487e
	call Func_00_2821 ; $4881
	call Func_00_2821 ; $4884
	call Func_00_2821 ; $4887
	call Func_00_2821 ; $488a
	call Func_00_2821 ; $488d
	call Func_00_2821 ; $4890
	call Func_00_2821 ; $4893
	call Func_00_2821 ; $4896
	call Func_00_2821 ; $4899
	call Func_00_2821 ; $489c
	call Func_00_2821 ; $489f
	call Func_00_2821 ; $48a2
	jr Label_07_48ae ; $48a5
Label_07_48a7:
	xor a, a ; $48a7
	ldh [$ffd7], a ; $48a8
	ld a, $80 ; $48aa
	ldh [$ffdc], a ; $48ac
Label_07_48ae:
	xor a, a ; $48ae
	ldh [$ffe2], a ; $48af
	call Func_00_2924 ; $48b1
	rst Rst18 ; $48b4
	inc l ; $48b5
	rlca ; $48b6
	xor a, a ; $48b7
	ldh [$ffde], a ; $48b8
	ld hl, $df1e ; $48ba
	ld a, $04 ; $48bd
	ldh [$ff96], a ; $48bf
	ldh [rWBK], a ; $48c1
	ld [hl], $05 ; $48c3
	ld a, $05 ; $48c5
	ldh [$ff96], a ; $48c7
	ldh [rWBK], a ; $48c9
	ld [hl], $06 ; $48cb
	ld a, $04 ; $48cd
	ldh [$ff96], a ; $48cf
	ldh [rWBK], a ; $48d1
	xor a, a ; $48d3
	ldh [$ffc0], a ; $48d4
	ldh [$ffd7], a ; $48d6
	ld a, $01 ; $48d8
	ldh [$ffdf], a ; $48da
	call EnableLCD ; $48dc
Label_07_48df:
	xor a, a ; $48df
	ldh [$ffe9], a ; $48e0
	push af ; $48e2
	rst Rst18 ; $48e3
	ld a, [de] ; $48e4
	rlca ; $48e5
	pop af ; $48e6
	push af ; $48e7
	rst Rst18 ; $48e8
	ld a, [de] ; $48e9
	rlca ; $48ea
	pop af ; $48eb
	push af ; $48ec
	rst Rst18 ; $48ed
	ld a, [de] ; $48ee
	rlca ; $48ef
	pop af ; $48f0
Label_07_48f1:
	pop hl ; $48f1
	pop de ; $48f2
	pop bc ; $48f3
	pop af ; $48f4
	ret ; $48f5
	xor a, a ; $48f6
	ld [$c33f], a ; $48f7
	call Func_00_28b9 ; $48fa
	ret ; $48fd
	INCBIN "data/bank_007/d_48fe.bin" ; $48fe, 277 bytes
Func_07_4a13:
	push af ; $4a13
	ldh a, [$ffc1] ; $4a14
	and a, $c0 ; $4a16
	xor a, $c0 ; $4a18
	ldh [$ffdc], a ; $4a1a
	ldh a, [$ffd6] ; $4a1c
	ldh [$ffd5], a ; $4a1e
	call Func_00_2851 ; $4a20
	ldh a, [$ff91] ; $4a23
	ldh [$ffd6], a ; $4a25
	pop af ; $4a27
	ret ; $4a28
Func_07_4a29:
	push de ; $4a29
	ld de, $4e20 ; $4a2a
Label_07_4a2d:
	ei ; $4a2d
	nop ; $4a2e
	nop ; $4a2f
	di ; $4a30
	ldh a, [$ff8d] ; $4a31
	or a, a ; $4a33
	jr z, Label_07_4a2d ; $4a34
	ldh a, [$ffd7] ; $4a36
	or a, a ; $4a38
	jr nz, Label_07_4a43 ; $4a39
	dec de ; $4a3b
	ld a, d ; $4a3c
	or a, e ; $4a3d
	jr nz, Label_07_4a2d ; $4a3e
	scf ; $4a40
	jr Label_07_4a4b ; $4a41
Label_07_4a43:
	dec a ; $4a43
	ldh [$ffd7], a ; $4a44
	xor a, a ; $4a46
	ldh [$ff8d], a ; $4a47
	scf ; $4a49
	ccf ; $4a4a
Label_07_4a4b:
	ldh a, [$ffc0] ; $4a4b
	ld b, a ; $4a4d
	ei ; $4a4e
	pop de ; $4a4f
	ret ; $4a50
	INCBIN "data/bank_007/d_4a51.bin" ; $4a51, 173 bytes
Func_07_4afe:
	push hl ; $4afe
	push de ; $4aff
	push bc ; $4b00
	call Func_07_4077 ; $4b01
	di ; $4b04
	ldh a, [rIF] ; $4b05
	and a, $f7 ; $4b07
	ldh [rIF], a ; $4b09
	xor a, a ; $4b0b
	ldh [$ffd7], a ; $4b0c
	ld a, $c2 ; $4b0e
	ldh [$ffc1], a ; $4b10
	ldh [$ffe0], a ; $4b12
	ei ; $4b14
	call Func_07_4a29 ; $4b15
	jr c, Label_07_4b2e ; $4b18
	di ; $4b1a
	ldh a, [$ffc0] ; $4b1b
	cp a, $c2 ; $4b1d
	jr z, Label_07_4b2e ; $4b1f
	cp a, $00 ; $4b21
	jr z, Label_07_4b2e ; $4b23
	cp a, $ff ; $4b25
	jr z, Label_07_4b2e ; $4b27
	cp a, $c1 ; $4b29
	jr z, Label_07_4b31 ; $4b2b
	ei ; $4b2d
Label_07_4b2e:
	scf ; $4b2e
	jr Label_07_4b33 ; $4b2f
Label_07_4b31:
	scf ; $4b31
	ccf ; $4b32
Label_07_4b33:
	ei ; $4b33
	pop bc ; $4b34
	pop de ; $4b35
	pop hl ; $4b36
	ret ; $4b37
Func_07_4b38:
	push hl ; $4b38
	push de ; $4b39
	push bc ; $4b3a
	call Func_07_4077 ; $4b3b
	di ; $4b3e
	ldh a, [rSC] ; $4b3f
	and a, $7f ; $4b41
	ldh [rSC], a ; $4b43
	ei ; $4b45
	ld a, $c1 ; $4b46
	ldh [$ffc1], a ; $4b48
	ld hl, $03e8 ; $4b4a
	ld de, $03e8 ; $4b4d
Label_07_4b50:
	ldh a, [rLY] ; $4b50
	cp a, $8c ; $4b52
	jr nz, Label_07_4b50 ; $4b54
	ldh a, [rSC] ; $4b56
	bit 7, a ; $4b58
	jr nz, Label_07_4b50 ; $4b5a
	di ; $4b5c
	ldh a, [$ffc1] ; $4b5d
	ldh [rSB], a ; $4b5f
	push af ; $4b61
	ld a, $03 ; $4b62
	ldh [rSC], a ; $4b64
	ld a, $83 ; $4b66
	ldh [rSC], a ; $4b68
	pop af ; $4b6a
	xor a, a ; $4b6b
	ldh [$ffd7], a ; $4b6c
	ei ; $4b6e
	call Func_07_4a29 ; $4b6f
	rst Rst18 ; $4b72
	ld d, $3e ; $4b73
	rst Rst18 ; $4b75
	inc b ; $4b76
	add hl, sp ; $4b77
	jr c, Label_07_4ba2 ; $4b78
	cp a, $c1 ; $4b7a
	jr z, Label_07_4ba2 ; $4b7c
	cp a, $ff ; $4b7e
	jr z, Label_07_4ba2 ; $4b80
	cp a, $c2 ; $4b82
	jr z, Label_07_4bbc ; $4b84
	ld a, d ; $4b86
	cp a, $03 ; $4b87
	jr nz, Label_07_4b9b ; $4b89
	ld a, e ; $4b8b
	cp a, $e8 ; $4b8c
	jr nz, Label_07_4b9b ; $4b8e
	push bc ; $4b90
	push de ; $4b91
	push hl ; $4b92
	ld c, $02 ; $4b93
	rst Rst18 ; $4b95
	jr nc, Label_07_4bd6 ; $4b96
	pop hl ; $4b98
	pop de ; $4b99
	pop bc ; $4b9a
Label_07_4b9b:
	dec de ; $4b9b
	ld a, d ; $4b9c
	or a, e ; $4b9d
	jr nz, Label_07_4b50 ; $4b9e
	jr Label_07_4ba2 ; $4ba0
Label_07_4ba2:
	di ; $4ba2
	ld a, $c0 ; $4ba3
Label_07_4ba5:
	ldh [rSB], a ; $4ba5
	push af ; $4ba7
	ld a, $03 ; $4ba8
	ldh [rSC], a ; $4baa
	ld a, $83 ; $4bac
	ldh [rSC], a ; $4bae
	pop af ; $4bb0
	xor a, a ; $4bb1
	ldh [$ffd7], a ; $4bb2
	ei ; $4bb4
	call Func_07_4a29 ; $4bb5
	ld a, e ; $4bb8
	scf ; $4bb9
	jr Label_07_4bbe ; $4bba
Label_07_4bbc:
	scf ; $4bbc
	ccf ; $4bbd
Label_07_4bbe:
	pop bc ; $4bbe
	pop de ; $4bbf
	pop hl ; $4bc0
	ret ; $4bc1
	INCBIN "data/bank_007/d_4bc2.bin" ; $4bc2, 20 bytes
Label_07_4bd6:
	jr z, Label_07_4ba5 ; $4bd6
	ld hl, $cd28 ; $4bd8
	ld hl, $cd28 ; $4bdb
	ld hl, $cd28 ; $4bde
	ld hl, $cd28 ; $4be1
	ld hl, $cd28 ; $4be4
	ld hl, $cd28 ; $4be7
	ld hl, $cd28 ; $4bea
	ld hl, $cd28 ; $4bed
	ld hl, $c928 ; $4bf0
	ldh a, [$ffc2] ; $4bf3
	cp a, $02 ; $4bf5
	jr z, Label_07_4bfe ; $4bf7
	call Func_07_4c02 ; $4bf9
	jr Label_07_4c01 ; $4bfc
Label_07_4bfe:
	call Func_07_4c13 ; $4bfe
Label_07_4c01:
	ret ; $4c01
Func_07_4c02:
	push bc ; $4c02
	push hl ; $4c03
	call Func_07_4a13 ; $4c04
	call Func_07_467f ; $4c07
	call Func_07_4c69 ; $4c0a
	call Func_07_4c24 ; $4c0d
	pop bc ; $4c10
	pop hl ; $4c11
	ret ; $4c12
Func_07_4c13:
	push bc ; $4c13
	push hl ; $4c14
	call Func_07_4a13 ; $4c15
	call Func_07_46ef ; $4c18
	call Func_07_4c69 ; $4c1b
	call Func_07_4c24 ; $4c1e
	pop hl ; $4c21
	pop bc ; $4c22
	ret ; $4c23
Func_07_4c24:
	push bc ; $4c24
	push hl ; $4c25
	ldh a, [$ffd6] ; $4c26
	ld b, a ; $4c28
	push hl ; $4c29
	push de ; $4c2a
	rst Rst18 ; $4c2b
	ld a, [bc] ; $4c2c
	jr c, $4c00 ; $4c2d
	pop hl ; $4c2f
	ld c, b ; $4c30
	ldh a, [$ffc2] ; $4c31
	cp a, $01 ; $4c33
	jr z, Label_07_4c49 ; $4c35
	cp a, $02 ; $4c37
	jr z, Label_07_4c49 ; $4c39
	rst Rst08 ; $4c3b
	ld [hl], d ; $4c3c
	xor a, a ; $4c3d
	ldh [$ffd5], a ; $4c3e
	ldh [$ffd6], a ; $4c40
	ld a, $c0 ; $4c42
	ldh [$ffc1], a ; $4c44
	call Func_00_284b ; $4c46
Label_07_4c49:
	ldh a, [$ffdf] ; $4c49
	or a, a ; $4c4b
	jr z, Label_07_4c5d ; $4c4c
	ldh a, [$ffc2] ; $4c4e
	cp a, $02 ; $4c50
	jr nz, Label_07_4c5d ; $4c52
Label_07_4c54:
	ei ; $4c54
	nop ; $4c55
	nop ; $4c56
	di ; $4c57
	ldh a, [$ffe0] ; $4c58
	or a, a ; $4c5a
	jr nz, Label_07_4c54 ; $4c5b
Label_07_4c5d:
	ldh a, [$ffdc] ; $4c5d
	or a, c ; $4c5f
	di ; $4c60
	ldh [$ffc1], a ; $4c61
	ldh [$ffe0], a ; $4c63
	ei ; $4c65
	pop hl ; $4c66
	pop bc ; $4c67
	ret ; $4c68
Func_07_4c69:
	push af ; $4c69
	push bc ; $4c6a
	ldh a, [$ffc0] ; $4c6b
	ld b, a ; $4c6d
	and a, $c0 ; $4c6e
	cp a, $80 ; $4c70
	jr z, Label_07_4c7f ; $4c72
	cp a, $40 ; $4c74
	jr z, Label_07_4c7f ; $4c76
	rst Rst08 ; $4c78
	ld [hl], d ; $4c79
	xor a, a ; $4c7a
	ldh [$ffd3], a ; $4c7b
	jr Label_07_4cae ; $4c7d
Label_07_4c7f:
	ld a, b ; $4c7f
	and a, $3f ; $4c80
	ldh [$ffd4], a ; $4c82
	ldh a, [$ffc2] ; $4c84
	cp a, $01 ; $4c86
	jr nz, Label_07_4c96 ; $4c88
	ldh a, [$ffd5] ; $4c8a
	or a, a ; $4c8c
	jr nz, Label_07_4cac ; $4c8d
	ldh a, [$ffd4] ; $4c8f
	call Func_07_4ce4 ; $4c91
	jr Label_07_4cac ; $4c94
Label_07_4c96:
	ldh a, [$ffd5] ; $4c96
	ld b, a ; $4c98
	ldh a, [$ffde] ; $4c99
	ldh [$ffd5], a ; $4c9b
	ld a, b ; $4c9d
	ldh [$ffde], a ; $4c9e
	ldh a, [$ffd4] ; $4ca0
	or a, a ; $4ca2
	jr z, Label_07_4caa ; $4ca3
	call Func_07_4ce4 ; $4ca5
	jr Label_07_4cac ; $4ca8
Label_07_4caa:
	ldh a, [$ffd5] ; $4caa
Label_07_4cac:
	ldh [$ffd3], a ; $4cac
Label_07_4cae:
	pop bc ; $4cae
	pop af ; $4caf
	ret ; $4cb0
	INCBIN "data/bank_007/d_4cb1.bin" ; $4cb1, 51 bytes
Func_07_4ce4:
	cp a, $14 ; $4ce4
	jr nz, Label_07_4cec ; $4ce6
	ld a, $0f ; $4ce8
	jr Label_07_4cfd ; $4cea
Label_07_4cec:
	cp a, $15 ; $4cec
	jr nz, Label_07_4cf4 ; $4cee
	ld a, $01 ; $4cf0
	jr Label_07_4cfd ; $4cf2
Label_07_4cf4:
	cp a, $19 ; $4cf4
	jr nz, Label_07_4cfc ; $4cf6
	ld a, $02 ; $4cf8
	jr Label_07_4cfd ; $4cfa
Label_07_4cfc:
	xor a, a ; $4cfc
Label_07_4cfd:
	ret ; $4cfd
	INCBIN "data/bank_007/d_4cfe.bin" ; $4cfe, 1123 bytes
	ld a, [$c4a0] ; $5161
	rst Rst00 ; $5164
	add a, e ; $5165
	ld d, c ; $5166
	sbc a, e ; $5167
	ld d, c ; $5168
	or a, e ; $5169
	ld d, c ; $516a
	bit 2, c ; $516b
	INCBIN "data/bank_007/d_516d.bin" ; $516d, 22 bytes
	ld hl, $4d31 ; $5183
	ld a, [$df6e] ; $5186
	ld d, a ; $5189
	ld a, [$df6b] ; $518a
	ld e, a ; $518d
	call Func_07_52a0 ; $518e
	call Func_07_52f1 ; $5191
	call Func_07_5345 ; $5194
	call Func_07_52d7 ; $5197
	ret ; $519a
	ld hl, $4d81 ; $519b
	ld a, [$df6e] ; $519e
	ld d, a ; $51a1
	ld a, [$df6b] ; $51a2
	ld e, a ; $51a5
	call Func_07_52a0 ; $51a6
	call Func_07_52f1 ; $51a9
	call Func_07_5345 ; $51ac
	call Func_07_52d7 ; $51af
	ret ; $51b2
	ld hl, $4dd1 ; $51b3
	ld a, [$df6f] ; $51b6
	ld d, a ; $51b9
	ld a, [$df6b] ; $51ba
	ld e, a ; $51bd
	call Func_07_52a0 ; $51be
	call Func_07_531d ; $51c1
	call Func_07_535c ; $51c4
	call Func_07_52d7 ; $51c7
	ret ; $51ca
	ld hl, $4e21 ; $51cb
	ld a, [$df6f] ; $51ce
	ld d, a ; $51d1
	ld a, [$df6b] ; $51d2
	ld e, a ; $51d5
	call Func_07_52a0 ; $51d6
	call Func_07_531d ; $51d9
	call Func_07_535c ; $51dc
	call Func_07_52d7 ; $51df
	ret ; $51e2
	ld hl, $4e71 ; $51e3
	ld d, $00 ; $51e6
	ld a, [$df6b] ; $51e8
	ld e, a ; $51eb
	call Func_07_52a0 ; $51ec
	call Func_07_52f1 ; $51ef
	call Func_07_5345 ; $51f2
	call Func_07_52d7 ; $51f5
	ret ; $51f8
	INCBIN "data/bank_007/d_51f9.bin" ; $51f9, 41 bytes
	ld hl, $4f61 ; $5222
	ld d, $00 ; $5225
	ld a, [$df6d] ; $5227
	ld e, a ; $522a
	call Func_07_52a0 ; $522b
	call Func_07_52f1 ; $522e
	call Func_07_52d7 ; $5231
	ret ; $5234
	ld hl, $4fb1 ; $5235
	ld d, $00 ; $5238
	ld a, [$df6d] ; $523a
	ld e, a ; $523d
	call Func_07_52a0 ; $523e
	call Func_07_531d ; $5241
	call Func_07_52d7 ; $5244
	ret ; $5247
	ld hl, $5001 ; $5248
	ld d, $00 ; $524b
	ld a, [$df6d] ; $524d
	ld e, a ; $5250
	call Func_07_52a0 ; $5251
	call Func_07_5301 ; $5254
	call Func_07_52d7 ; $5257
	ret ; $525a
	ld hl, $5051 ; $525b
	ld a, [$df92] ; $525e
	ld d, a ; $5261
	ld e, $00 ; $5262
	call Func_07_52a0 ; $5264
	ret ; $5267
	ld hl, $5061 ; $5268
	ld a, [$df93] ; $526b
	ld d, a ; $526e
	ld e, $00 ; $526f
	call Func_07_52a0 ; $5271
	ret ; $5274
	ld hl, $5071 ; $5275
	ld a, [$df6e] ; $5278
	ld d, a ; $527b
	ld a, [$df6c] ; $527c
	ld e, a ; $527f
	call Func_07_52a0 ; $5280
	ret ; $5283
	ld hl, $50c1 ; $5284
	ld a, [$df6f] ; $5287
	ld d, a ; $528a
	ld a, [$df6c] ; $528b
	ld e, a ; $528e
	call Func_07_52a0 ; $528f
	ret ; $5292
	ld hl, $5111 ; $5293
	ld d, $00 ; $5296
	ld a, [$df6c] ; $5298
	ld e, a ; $529b
	call Func_07_52a0 ; $529c
	ret ; $529f
Func_07_52a0:
	push hl ; $52a0
	ld a, d ; $52a1
	add a, a ; $52a2
	add a, a ; $52a3
	add a, a ; $52a4
	add a, l ; $52a5
	ld l, a ; $52a6
	jr nc, Label_07_52aa ; $52a7
	inc h ; $52a9
Label_07_52aa:
	ld a, [hl+] ; $52aa
	ld [$c41c], a ; $52ab
	ld a, [hl+] ; $52ae
	ld [$c41d], a ; $52af
	ld a, [hl+] ; $52b2
	ld b, [hl] ; $52b3
	ld c, a ; $52b4
	ld a, [$c4a7] ; $52b5
	and a, a ; $52b8
	jr z, Label_07_52c1 ; $52b9
	xor a, a ; $52bb
	sub a, c ; $52bc
	ld c, a ; $52bd
	sbc a, a ; $52be
	sub a, b ; $52bf
	ld b, a ; $52c0
Label_07_52c1:
	ld hl, $c41e ; $52c1
	ld a, c ; $52c4
	ld [hl+], a ; $52c5
	ld [hl], b ; $52c6
	pop hl ; $52c7
	ld a, e ; $52c8
	add a, a ; $52c9
	add a, a ; $52ca
	add a, a ; $52cb
	add a, $04 ; $52cc
	add a, l ; $52ce
	ld l, a ; $52cf
	jr nc, Label_07_52d3 ; $52d0
	inc h ; $52d2
Label_07_52d3:
	ld a, [hl+] ; $52d3
	ld b, [hl] ; $52d4
	ld c, a ; $52d5
	ret ; $52d6
Func_07_52d7:
	call Func_07_537f ; $52d7
	call Func_07_53a2 ; $52da
	ld hl, rJOYP ; $52dd
	add hl, bc ; $52e0
	bit 7, h ; $52e1
	jr z, Label_07_52e8 ; $52e3
	ld bc, $0100 ; $52e5
Label_07_52e8:
	ld a, c ; $52e8
	ld [$c458], a ; $52e9
	ld a, b ; $52ec
	ld [$c459], a ; $52ed
	ret ; $52f0
Func_07_52f1:
	ld hl, $c424 ; $52f1
	ld a, [hl+] ; $52f4
	ld h, [hl] ; $52f5
	ld l, a ; $52f6
	sra h ; $52f7
	rr l ; $52f9
	sra h ; $52fb
	rr l ; $52fd
	jr Label_07_532f ; $52ff
Func_07_5301:
	ld hl, $c424 ; $5301
	ld a, [hl+] ; $5304
	ld h, [hl] ; $5305
	ld l, a ; $5306
	sra h ; $5307
	rr l ; $5309
	sra h ; $530b
	rr l ; $530d
	sra h ; $530f
	rr l ; $5311
	sra h ; $5313
	rr l ; $5315
	ld e, l ; $5317
	ld d, h ; $5318
	add hl, de ; $5319
	add hl, de ; $531a
	jr Label_07_532f ; $531b
Func_07_531d:
	ld hl, $c424 ; $531d
	ld a, [hl+] ; $5320
	ld h, [hl] ; $5321
	ld l, a ; $5322
	sra h ; $5323
	rr l ; $5325
	sra h ; $5327
	rr l ; $5329
	sra h ; $532b
	rr l ; $532d
Label_07_532f:
	bit 7, h ; $532f
	jr nz, Label_07_5339 ; $5331
	xor a, a ; $5333
	sub a, l ; $5334
	ld l, a ; $5335
	sbc a, a ; $5336
	sub a, h ; $5337
	ld h, a ; $5338
Label_07_5339:
	ld a, l ; $5339
	ld [$c45a], a ; $533a
	ld a, h ; $533d
	ld [$c45b], a ; $533e
	add hl, bc ; $5341
	ld c, l ; $5342
	ld b, h ; $5343
	ret ; $5344
Func_07_5345:
	ld a, [$c4a2] ; $5345
	ld l, a ; $5348
	ld h, $00 ; $5349
	ld de, $ffe0 ; $534b
	add hl, de ; $534e
	ld a, $80 ; $534f
	bit 7, h ; $5351
	jr z, Label_07_5357 ; $5353
	srl a ; $5355
Label_07_5357:
	call Func_00_0b9d ; $5357
	jr Label_07_5373 ; $535a
Func_07_535c:
	ld a, [$c4a2] ; $535c
	ld l, a ; $535f
	ld h, $00 ; $5360
	ld de, $ffe0 ; $5362
	add hl, de ; $5365
	ld a, $40 ; $5366
	bit 7, h ; $5368
	jr z, Label_07_536e ; $536a
	srl a ; $536c
Label_07_536e:
	call Func_00_0b9d ; $536e
	jr Label_07_5373 ; $5371
Label_07_5373:
	ld a, l ; $5373
	ld [$c45e], a ; $5374
	ld a, h ; $5377
	ld [$c45f], a ; $5378
	add hl, bc ; $537b
	ld c, l ; $537c
	ld b, h ; $537d
	ret ; $537e
Func_07_537f:
	ld hl, $df42 ; $537f
	ld a, [hl+] ; $5382
	ld h, [hl] ; $5383
	ld l, a ; $5384
	sra h ; $5385
	rr l ; $5387
	ld a, [$df0a] ; $5389
	and a, $02 ; $538c
	jr nz, Label_07_5396 ; $538e
	xor a, a ; $5390
	sub a, l ; $5391
	ld l, a ; $5392
	sbc a, a ; $5393
	sub a, h ; $5394
	ld h, a ; $5395
Label_07_5396:
	ld a, l ; $5396
	ld [$c45c], a ; $5397
	ld a, h ; $539a
	ld [$c45d], a ; $539b
	add hl, bc ; $539e
	ld c, l ; $539f
	ld b, h ; $53a0
	ret ; $53a1
Func_07_53a2:
	ld hl, $df0f ; $53a2
	bit 1, [hl] ; $53a5
	jr z, Label_07_53af ; $53a7
	ld hl, $f400 ; $53a9
	add hl, bc ; $53ac
	ld c, l ; $53ad
	ld b, h ; $53ae
Label_07_53af:
	ret ; $53af
	ld hl, $c4b7 ; $53b0
	ld a, [hl] ; $53b3
	and a, a ; $53b4
	ret nz ; $53b5
	ld a, $01 ; $53b6
	ld [$c4b7], a ; $53b8
	ld a, [$df0b] ; $53bb
	ld [$c4b8], a ; $53be
	ld a, [$df09] ; $53c1
	ld [$c4b9], a ; $53c4
	ld a, [$df4a] ; $53c7
	ld [$c4a4], a ; $53ca
	ld a, [$df14] ; $53cd
	ld [$c4a0], a ; $53d0
	ld a, [$df16] ; $53d3
	swap a ; $53d6
	ld hl, $df17 ; $53d8
	or a, [hl] ; $53db
	ld [$c490], a ; $53dc
	ld a, [$c4b0] ; $53df
	ld [$c4be], a ; $53e2
	xor a, a ; $53e5
	ld [$c4a5], a ; $53e6
	ld [$c4a6], a ; $53e9
	ld [$c4c6], a ; $53ec
	ld b, $00 ; $53ef
	ld a, [$df15] ; $53f1
	cp a, $06 ; $53f4
	jr nz, Label_07_53f9 ; $53f6
	inc b ; $53f8
Label_07_53f9:
	cp a, $0a ; $53f9
	jr nz, Label_07_53fe ; $53fb
	inc b ; $53fd
Label_07_53fe:
	ld a, [$df94] ; $53fe
	and a, a ; $5401
	jr z, Label_07_5405 ; $5402
	inc b ; $5404
Label_07_5405:
	ld a, [wRallyLength] ; $5405
	cp a, $00 ; $5408
	jr nz, Label_07_540d ; $540a
	inc b ; $540c
Label_07_540d:
	ld a, b ; $540d
	and a, $01 ; $540e
	ld [$c4a7], a ; $5410
	ld a, [$df4b] ; $5413
	cp a, $3f ; $5416
	jr c, Label_07_541c ; $5418
	ld a, $3f ; $541a
Label_07_541c:
	ld [$c4a2], a ; $541c
	ld a, [$df4c] ; $541f
	ld [$c4a3], a ; $5422
	ld hl, $c421 ; $5425
	ld a, [hl+] ; $5428
	ld d, [hl] ; $5429
	ld e, a ; $542a
	ld hl, $c454 ; $542b
	ld a, e ; $542e
	ld [hl+], a ; $542f
	ld [hl], d ; $5430
	ld hl, $c424 ; $5431
	ld a, [hl+] ; $5434
	ld d, [hl] ; $5435
	ld e, a ; $5436
	ld hl, $c456 ; $5437
	ld a, e ; $543a
	ld [hl+], a ; $543b
	ld [hl], d ; $543c
	ld hl, $5463 ; $543d
	push hl ; $5440
	ld a, [$c4a0] ; $5441
	rst Rst00 ; $5444
	cp a, [hl] ; $5445
	ld e, b ; $5446
	INCBIN "data/bank_007/d_5447.bin" ; $5447, 28 bytes
	call Func_07_546b ; $5463
	xor a, a ; $5466
	ld [$df4b], a ; $5467
	ret ; $546a
Func_07_546b:
	ld hl, $df0f ; $546b
	set 0, [hl] ; $546e
	res 5, [hl] ; $5470
	ld a, [$c4a1] ; $5472
	add a, a ; $5475
	add a, $ca ; $5476
	ld l, a ; $5478
	adc a, $54 ; $5479
	sub a, l ; $547b
	ld h, a ; $547c
	ld a, [hl+] ; $547d
	ld h, [hl] ; $547e
	ld l, a ; $547f
	ld a, [hl] ; $5480
	add a, $d4 ; $5481
	ld l, a ; $5483
	adc a, $54 ; $5484
	sub a, l ; $5486
	ld h, a ; $5487
	ld b, [hl] ; $5488
	ld hl, $c456 ; $5489
	ld a, [hl+] ; $548c
	ld h, [hl] ; $548d
	ld l, a ; $548e
	ld a, b ; $548f
	call Func_00_0bb6 ; $5490
	ld e, l ; $5493
	ld d, h ; $5494
	ld hl, $df42 ; $5495
	ld a, [hl+] ; $5498
	ld h, [hl] ; $5499
	ld l, a ; $549a
	sra h ; $549b
	rr l ; $549d
	sra h ; $549f
	rr l ; $54a1
	add hl, de ; $54a3
	ld e, l ; $54a4
	ld d, h ; $54a5
	ld hl, $df42 ; $54a6
	ld a, e ; $54a9
	ld [hl+], a ; $54aa
	ld [hl], d ; $54ab
	ld hl, $df0f ; $54ac
	bit 1, [hl] ; $54af
	jr nz, Label_07_54c9 ; $54b1
	ld hl, $df40 ; $54b3
	ld a, [hl+] ; $54b6
	ld h, [hl] ; $54b7
	ld l, a ; $54b8
	sra h ; $54b9
	rr l ; $54bb
	sra h ; $54bd
	rr l ; $54bf
	ld e, l ; $54c1
	ld d, h ; $54c2
	ld hl, $df40 ; $54c3
	ld a, e ; $54c6
	ld [hl+], a ; $54c7
	ld [hl], d ; $54c8
Label_07_54c9:
	ret ; $54c9
	INCBIN "data/bank_007/d_54ca.bin" ; $54ca, 20 bytes
Func_07_54de:
	ld a, [$c4a2] ; $54de
	ld l, a ; $54e1
	ld h, $00 ; $54e2
	add hl, hl ; $54e4
	add hl, hl ; $54e5
	ld a, c ; $54e6
	sub a, l ; $54e7
	ld c, a ; $54e8
	ld a, b ; $54e9
	sbc a, h ; $54ea
	ld b, a ; $54eb
	ret ; $54ec
Func_07_54ed:
	ld a, [$c4a2] ; $54ed
	ld l, a ; $54f0
	ld h, $00 ; $54f1
	add hl, hl ; $54f3
	ld e, l ; $54f4
	ld d, h ; $54f5
	add hl, hl ; $54f6
	add hl, hl ; $54f7
	add hl, de ; $54f8
	add hl, de ; $54f9
	add hl, bc ; $54fa
	ld c, l ; $54fb
	ld b, h ; $54fc
	ret ; $54fd
Func_07_54fe:
	ld hl, $df42 ; $54fe
	ld a, [hl+] ; $5501
	ld h, [hl] ; $5502
	ld l, a ; $5503
	sra h ; $5504
	rr l ; $5506
	sra h ; $5508
	rr l ; $550a
	sra h ; $550c
	rr l ; $550e
	sra h ; $5510
	rr l ; $5512
	ld a, [$df0a] ; $5514
	and a, $02 ; $5517
	jr nz, Label_07_5521 ; $5519
	xor a, a ; $551b
	sub a, l ; $551c
	ld l, a ; $551d
	sbc a, a ; $551e
	sub a, h ; $551f
	ld h, a ; $5520
Label_07_5521:
	add hl, bc ; $5521
	ld c, l ; $5522
	ld b, h ; $5523
	ret ; $5524
Func_07_5525:
	ld hl, $c406 ; $5525
	ld a, [hl+] ; $5528
	ld h, [hl] ; $5529
	ld l, a ; $552a
	bit 7, h ; $552b
	jr z, Label_07_5535 ; $552d
	xor a, a ; $552f
	sub a, l ; $5530
	ld l, a ; $5531
	sbc a, a ; $5532
	sub a, h ; $5533
	ld h, a ; $5534
Label_07_5535:
	ld e, l ; $5535
	ld d, h ; $5536
	sra d ; $5537
	rr e ; $5539
	add hl, de ; $553b
	sra h ; $553c
	rr l ; $553e
	ld e, l ; $5540
	ld d, h ; $5541
	ld hl, $c40a ; $5542
	ld a, [hl+] ; $5545
	ld h, [hl] ; $5546
	ld l, a ; $5547
	ld bc, $0070 ; $5548
	add hl, bc ; $554b
	bit 7, h ; $554c
	jr z, Label_07_557d ; $554e
	call Func_00_1416 ; $5550
	push bc ; $5553
	ld hl, $c406 ; $5554
	ld a, [hl+] ; $5557
	ld h, [hl] ; $5558
	ld l, a ; $5559
	bit 7, h ; $555a
	jr z, Label_07_5564 ; $555c
	xor a, a ; $555e
	sub a, l ; $555f
	ld l, a ; $5560
	sbc a, a ; $5561
	sub a, h ; $5562
	ld h, a ; $5563
Label_07_5564:
	ld de, $04e0 ; $5564
	add hl, de ; $5567
	ld e, l ; $5568
	ld d, h ; $5569
	ld hl, $c40a ; $556a
	ld a, [hl+] ; $556d
	ld h, [hl] ; $556e
	ld l, a ; $556f
	xor a, a ; $5570
	sub a, l ; $5571
	ld l, a ; $5572
	sbc a, a ; $5573
	sub a, h ; $5574
	ld h, a ; $5575
	call Func_00_1416 ; $5576
	pop hl ; $5579
	add hl, bc ; $557a
	bit 7, h ; $557b
Label_07_557d:
	ret ; $557d
Func_07_557e:
	ld a, [$c4a0] ; $557e
	ld b, a ; $5581
	add a, a ; $5582
	add a, a ; $5583
	add a, b ; $5584
	add a, $9e ; $5585
	ld l, a ; $5587
	adc a, $55 ; $5588
	sub a, l ; $558a
	ld h, a ; $558b
	ld a, [hl+] ; $558c
	call Func_00_3024 ; $558d
	ld a, [hl+] ; $5590
	ld [$c4a1], a ; $5591
	ld a, [hl+] ; $5594
	push hl ; $5595
	rst Rst18 ; $5596
	inc h ; $5597
	INCBIN "data/bank_007/d_5598.bin" ; $5598, 1 bytes
	pop hl ; $5599
	ld a, [hl+] ; $559a
	ld b, [hl] ; $559b
	ld c, a ; $559c
	ret ; $559d
	INCBIN "data/bank_007/d_559e.bin" ; $559e, 75 bytes
Label_07_55e9:
	ld hl, $563e ; $55e9
	ld a, [$c7b9] ; $55ec
	and a, a ; $55ef
	jr nz, Label_07_5601 ; $55f0
	ld a, [$df0a] ; $55f2
	and a, $01 ; $55f5
	add a, a ; $55f7
	add a, a ; $55f8
	add a, a ; $55f9
	add a, $2e ; $55fa
	ld l, a ; $55fc
	adc a, $56 ; $55fd
	sub a, l ; $55ff
	ld h, a ; $5600
Label_07_5601:
	ld a, [$df4a] ; $5601
	inc a ; $5604
	add a, a ; $5605
	add a, l ; $5606
	ld l, a ; $5607
	jr nc, Label_07_560b ; $5608
	inc h ; $560a
Label_07_560b:
	ld a, [hl+] ; $560b
	ld d, [hl] ; $560c
	ld e, a ; $560d
	ld hl, $df01 ; $560e
	ld a, [hl+] ; $5611
	ld h, [hl] ; $5612
	ld l, a ; $5613
	xor a, a ; $5614
	sub a, l ; $5615
	ld l, a ; $5616
	sbc a, a ; $5617
	sub a, h ; $5618
	ld h, a ; $5619
	sra h ; $561a
	rr l ; $561c
	sra h ; $561e
	rr l ; $5620
	sra h ; $5622
	rr l ; $5624
	sra h ; $5626
	rr l ; $5628
	add hl, de ; $562a
	ld e, l ; $562b
	ld d, h ; $562c
	ret ; $562d
	INCBIN "data/bank_007/d_562e.bin" ; $562e, 24 bytes
Func_07_5646:
	ld a, [wRallyLength] ; $5646
	and a, a ; $5649
	jr z, Label_07_55e9 ; $564a
	call Func_07_56b7 ; $564c
	ld a, [$df4a] ; $564f
	add a, $02 ; $5652
	and a, $07 ; $5654
	ld a, a ; $5656
	rst Rst00 ; $5657
	ld l, h ; $5658
	ld d, [hl] ; $5659
	ld l, b ; $565a
	ld d, [hl] ; $565b
	sub a, [hl] ; $565c
	ld d, [hl] ; $565d
	add a, l ; $565e
	ld d, [hl] ; $565f
	adc a, c ; $5660
	ld d, [hl] ; $5661
	sub a, [hl] ; $5662
	ld d, [hl] ; $5663
	sub a, [hl] ; $5664
	ld d, [hl] ; $5665
	sub a, [hl] ; $5666
	ld d, [hl] ; $5667
	sra d ; $5668
	rr e ; $566a
	ld hl, $c402 ; $566c
	ld a, [hl+] ; $566f
	ld h, [hl] ; $5670
	ld l, a ; $5671
	xor a, a ; $5672
	sub a, l ; $5673
	ld l, a ; $5674
	sbc a, a ; $5675
	sub a, h ; $5676
	ld h, a ; $5677
	add hl, de ; $5678
	ld e, l ; $5679
	ld d, h ; $567a
	call Func_07_56e3 ; $567b
	xor a, a ; $567e
	sub a, e ; $567f
	ld e, a ; $5680
	sbc a, a ; $5681
	sub a, d ; $5682
	ld d, a ; $5683
	ret ; $5684
	sra d ; $5685
	rr e ; $5687
	ld hl, $c402 ; $5689
	ld a, [hl+] ; $568c
	ld h, [hl] ; $568d
	ld l, a ; $568e
	add hl, de ; $568f
	ld e, l ; $5690
	ld d, h ; $5691
	call Func_07_56e3 ; $5692
	ret ; $5695
	ld hl, $c402 ; $5696
	ld a, [hl+] ; $5699
	ld d, [hl] ; $569a
	ld e, a ; $569b
	sra d ; $569c
	rr e ; $569e
	sra d ; $56a0
	rr e ; $56a2
	call Func_07_570d ; $56a4
	ld a, e ; $56a7
	sub a, h ; $56a8
	ld e, a ; $56a9
	jr nc, Label_07_56ad ; $56aa
	dec d ; $56ac
Label_07_56ad:
	call Func_07_570d ; $56ad
	ld a, h ; $56b0
	add a, e ; $56b1
	ld e, a ; $56b2
	jr nc, Label_07_56b6 ; $56b3
	inc d ; $56b5
Label_07_56b6:
	ret ; $56b6
Func_07_56b7:
	ld hl, $c43e ; $56b7
	ld a, [hl+] ; $56ba
	ld d, [hl] ; $56bb
	ld e, a ; $56bc
	ld hl, $df04 ; $56bd
	ld a, [hl+] ; $56c0
	ld h, [hl] ; $56c1
	ld l, a ; $56c2
	bit 7, h ; $56c3
	jr z, Label_07_56cd ; $56c5
	xor a, a ; $56c7
	sub a, l ; $56c8
	ld l, a ; $56c9
	sbc a, a ; $56ca
	sub a, h ; $56cb
	ld h, a ; $56cc
Label_07_56cd:
	sra h ; $56cd
	rr l ; $56cf
	sra h ; $56d1
	rr l ; $56d3
	sra h ; $56d5
	rr l ; $56d7
	add hl, de ; $56d9
	ld a, [$df69] ; $56da
	call Func_00_0bd4 ; $56dd
	ld e, l ; $56e0
	ld d, h ; $56e1
	ret ; $56e2
Func_07_56e3:
	ld hl, $c484 ; $56e3
	ld a, [hl+] ; $56e6
	ld h, [hl] ; $56e7
	ld l, a ; $56e8
	ld bc, $0020 ; $56e9
	add hl, bc ; $56ec
	xor a, a ; $56ed
	sub a, l ; $56ee
	ld l, a ; $56ef
	sbc a, a ; $56f0
	sub a, h ; $56f1
	ld h, a ; $56f2
	ld c, l ; $56f3
	ld b, h ; $56f4
	ld l, e ; $56f5
	ld h, d ; $56f6
	ld a, l ; $56f7
	sub a, c ; $56f8
	ld l, a ; $56f9
	ld a, h ; $56fa
	sbc a, b ; $56fb
	ld h, a ; $56fc
	bit 7, h ; $56fd
	jr nz, Label_07_5703 ; $56ff
	ld e, c ; $5701
	ld d, b ; $5702
Label_07_5703:
	call Func_07_570d ; $5703
	ld a, e ; $5706
	sub a, h ; $5707
	ld e, a ; $5708
	jr nc, Label_07_570c ; $5709
	dec d ; $570b
Label_07_570c:
	ret ; $570c
Func_07_570d:
	rst Rst18 ; $570d
	ld [hl], $08 ; $570e
	ld l, a ; $5710
	ld h, $00 ; $5711
	ld a, [$df6a] ; $5713
	call Func_00_0926 ; $5716
	add hl, hl ; $5719
	add hl, hl ; $571a
	add hl, hl ; $571b
	add hl, hl ; $571c
	ret ; $571d
Func_07_571e:
	ld a, [$df0a] ; $571e
	and a, $02 ; $5721
	jr nz, Label_07_572b ; $5723
	xor a, a ; $5725
	sub a, c ; $5726
	ld c, a ; $5727
	sbc a, a ; $5728
	sub a, b ; $5729
	ld b, a ; $572a
Label_07_572b:
	ld hl, $c432 ; $572b
	ld a, c ; $572e
	ld [hl+], a ; $572f
	ld [hl], b ; $5730
	ld hl, $c406 ; $5731
	ld a, [hl+] ; $5734
	ld h, [hl] ; $5735
	ld l, a ; $5736
	ld a, c ; $5737
	sub a, l ; $5738
	ld c, a ; $5739
	ld a, b ; $573a
	sbc a, h ; $573b
	ld b, a ; $573c
	ld hl, $c436 ; $573d
	ld a, c ; $5740
	ld [hl+], a ; $5741
	ld [hl], b ; $5742
	call Func_07_5646 ; $5743
	ld hl, $c430 ; $5746
	ld a, e ; $5749
	ld [hl+], a ; $574a
	ld [hl], d ; $574b
	ld hl, $c402 ; $574c
	ld a, [hl+] ; $574f
	ld h, [hl] ; $5750
	ld l, a ; $5751
	ld a, e ; $5752
	sub a, l ; $5753
	ld e, a ; $5754
	ld a, d ; $5755
	sbc a, h ; $5756
	ld d, a ; $5757
	ld hl, $c434 ; $5758
	ld a, e ; $575b
	ld [hl+], a ; $575c
	ld [hl], d ; $575d
	ld hl, $c436 ; $575e
	ld a, [hl+] ; $5761
	ld h, [hl] ; $5762
	ld l, a ; $5763
	call Func_00_1416 ; $5764
	ld hl, $c43a ; $5767
	ld a, c ; $576a
	ld [hl+], a ; $576b
	ld [hl], b ; $576c
	ld hl, $c43a ; $576d
	ld a, [hl+] ; $5770
	ld b, [hl] ; $5771
	ld c, a ; $5772
	ld hl, $c406 ; $5773
	ld a, [hl+] ; $5776
	ld h, [hl] ; $5777
	ld l, a ; $5778
	bit 7, h ; $5779
	jr z, Label_07_5783 ; $577b
	xor a, a ; $577d
	sub a, l ; $577e
	ld l, a ; $577f
	sbc a, a ; $5780
	sub a, h ; $5781
	ld h, a ; $5782
Label_07_5783:
	ld de, $0140 ; $5783
	add hl, de ; $5786
	call Func_00_13ce ; $5787
	bit 7, h ; $578a
	jr z, Label_07_5794 ; $578c
	xor a, a ; $578e
	sub a, l ; $578f
	ld l, a ; $5790
	sbc a, a ; $5791
	sub a, h ; $5792
	ld h, a ; $5793
Label_07_5794:
	ld e, l ; $5794
	ld d, h ; $5795
	add hl, hl ; $5796
	add hl, hl ; $5797
	ld a, h ; $5798
	ld [$c48e], a ; $5799
	ld hl, $c48a ; $579c
	ld a, e ; $579f
	ld [hl+], a ; $57a0
	ld [hl], d ; $57a1
	ld hl, $c43a ; $57a2
	ld a, [hl+] ; $57a5
	ld b, [hl] ; $57a6
	ld c, a ; $57a7
	ld hl, $c406 ; $57a8
	ld a, [hl+] ; $57ab
	ld h, [hl] ; $57ac
	ld l, a ; $57ad
	bit 7, h ; $57ae
	jr z, Label_07_57b8 ; $57b0
	xor a, a ; $57b2
	sub a, l ; $57b3
	ld l, a ; $57b4
	sbc a, a ; $57b5
	sub a, h ; $57b6
	ld h, a ; $57b7
Label_07_57b8:
	ld de, $0480 ; $57b8
	add hl, de ; $57bb
	call Func_00_13ce ; $57bc
	bit 7, h ; $57bf
	jr z, Label_07_57c9 ; $57c1
	xor a, a ; $57c3
	sub a, l ; $57c4
	ld l, a ; $57c5
	sbc a, a ; $57c6
	sub a, h ; $57c7
	ld h, a ; $57c8
Label_07_57c9:
	ld e, l ; $57c9
	ld d, h ; $57ca
	add hl, hl ; $57cb
	add hl, hl ; $57cc
	ld a, h ; $57cd
	ld [$c48f], a ; $57ce
	ld hl, $c48c ; $57d1
	ld a, e ; $57d4
	ld [hl+], a ; $57d5
	ld [hl], d ; $57d6
	ld hl, $c43a ; $57d7
	ld a, [hl+] ; $57da
	ld b, [hl] ; $57db
	ld c, a ; $57dc
	ld l, e ; $57dd
	ld h, d ; $57de
	call Func_00_1340 ; $57df
	bit 7, h ; $57e2
	jr z, Label_07_57ec ; $57e4
	xor a, a ; $57e6
	sub a, l ; $57e7
	ld l, a ; $57e8
	sbc a, a ; $57e9
	sub a, h ; $57ea
	ld h, a ; $57eb
Label_07_57ec:
	ld c, l ; $57ec
	ld b, h ; $57ed
	ld hl, $ffe0 ; $57ee
	add hl, bc ; $57f1
	jr nc, Label_07_5851 ; $57f2
	ld hl, $c484 ; $57f4
	ld a, [hl+] ; $57f7
	ld h, [hl] ; $57f8
	ld l, a ; $57f9
	ld de, $0020 ; $57fa
	add hl, de ; $57fd
	ld e, l ; $57fe
	ld d, h ; $57ff
	ld a, [$c43b] ; $5800
	add a, $40 ; $5803
	bit 7, a ; $5805
	jr z, Label_07_580f ; $5807
	xor a, a ; $5809
	sub a, e ; $580a
	ld e, a ; $580b
	sbc a, a ; $580c
	sub a, d ; $580d
	ld d, a ; $580e
Label_07_580f:
	ld hl, $c402 ; $580f
	ld a, [hl+] ; $5812
	ld h, [hl] ; $5813
	ld l, a ; $5814
	add hl, de ; $5815
	bit 7, h ; $5816
	jr z, Label_07_5820 ; $5818
	xor a, a ; $581a
	sub a, l ; $581b
	ld l, a ; $581c
	sbc a, a ; $581d
	sub a, h ; $581e
	ld h, a ; $581f
Label_07_5820:
	ld e, l ; $5820
	ld d, h ; $5821
	ld a, l ; $5822
	sub a, c ; $5823
	ld l, a ; $5824
	ld a, h ; $5825
	sbc a, b ; $5826
	ld h, a ; $5827
	bit 7, h ; $5828
	jr z, Label_07_5851 ; $582a
	push de ; $582c
	ld l, $00 ; $582d
	ld a, [$c48c] ; $582f
	ld h, a ; $5832
	ld a, [$c48d] ; $5833
	ld e, c ; $5836
	ld d, b ; $5837
	call Func_00_0e6c ; $5838
	pop de ; $583b
	call Func_00_0c8f ; $583c
	ld h, l ; $583f
	ldh a, [$ffa9] ; $5840
	ld l, a ; $5842
	ld e, l ; $5843
	ld d, h ; $5844
	add hl, hl ; $5845
	add hl, hl ; $5846
	ld a, h ; $5847
	ld [$c48f], a ; $5848
	ld hl, $c48c ; $584b
	ld a, e ; $584e
	ld [hl+], a ; $584f
	ld [hl], d ; $5850
Label_07_5851:
	ld hl, $c40a ; $5851
	ld a, [hl+] ; $5854
	ld d, [hl] ; $5855
	ld e, a ; $5856
	xor a, a ; $5857
	sub a, e ; $5858
	ld e, a ; $5859
	sbc a, a ; $585a
	sub a, d ; $585b
	ld d, a ; $585c
	ld hl, $c470 ; $585d
	ld a, e ; $5860
	ld [hl+], a ; $5861
	ld [hl], d ; $5862
	ld hl, $c430 ; $5863
	ld de, $c450 ; $5866
	ld a, [hl+] ; $5869
	ld [de], a ; $586a
	inc de ; $586b
	ld a, [hl+] ; $586c
	ld [de], a ; $586d
	inc de ; $586e
	ld a, [hl+] ; $586f
	ld [de], a ; $5870
	inc de ; $5871
	ld a, [hl+] ; $5872
	ld [de], a ; $5873
	inc de ; $5874
	ret ; $5875
Func_07_5876:
	ld hl, $c40a ; $5876
	ld a, [hl+] ; $5879
	ld d, [hl] ; $587a
	ld e, a ; $587b
	ld hl, $0060 ; $587c
	add hl, de ; $587f
	bit 7, h ; $5880
	jr nz, Label_07_5898 ; $5882
	ld hl, $0060 ; $5884
	add hl, de ; $5887
	sra h ; $5888
	rr l ; $588a
	ld a, e ; $588c
	sub a, l ; $588d
	ld e, a ; $588e
	ld a, d ; $588f
	sbc a, h ; $5890
	ld d, a ; $5891
	ld hl, $c40a ; $5892
	ld a, e ; $5895
	ld [hl+], a ; $5896
	ld [hl], d ; $5897
Label_07_5898:
	ret ; $5898
Func_07_5899:
	ld hl, $c40a ; $5899
	ld a, [hl+] ; $589c
	ld d, [hl] ; $589d
	ld e, a ; $589e
	ld hl, $0080 ; $589f
	add hl, de ; $58a2
	bit 7, h ; $58a3
	jr nz, Label_07_58b1 ; $58a5
	ld de, $ffa0 ; $58a7
	ld hl, $c40a ; $58aa
	ld a, e ; $58ad
	ld [hl+], a ; $58ae
	ld [hl], d ; $58af
	ret ; $58b0
Label_07_58b1:
	ld hl, $0020 ; $58b1
	add hl, de ; $58b4
	ld e, l ; $58b5
	ld d, h ; $58b6
	ld hl, $c40a ; $58b7
	ld a, e ; $58ba
	ld [hl+], a ; $58bb
	ld [hl], d ; $58bc
	ret ; $58bd
Label_07_58be:
	ld a, $00 ; $58be
	ld [$c4a0], a ; $58c0
	call Func_07_5876 ; $58c3
	call Func_07_557e ; $58c6
	call Func_07_54de ; $58c9
	call Func_07_571e ; $58cc
	rst Rst18 ; $58cf
	nop ; $58d0
	ld [hl+], a ; $58d1
	ret ; $58d2
	ld hl, $df0f ; $58d3
	bit 1, [hl] ; $58d6
	jr nz, Label_07_58be ; $58d8
	ld a, $01 ; $58da
	ld [$c4a6], a ; $58dc
	call Func_07_5876 ; $58df
	call Func_07_557e ; $58e2
	call Func_07_571e ; $58e5
	rst Rst18 ; $58e8
	nop ; $58e9
	inc hl ; $58ea
	ret ; $58eb
Label_07_58ec:
	ld a, $02 ; $58ec
	ld [$c4a0], a ; $58ee
	call Func_07_5876 ; $58f1
	call Func_07_557e ; $58f4
	call Func_07_54de ; $58f7
	call Func_07_571e ; $58fa
	rst Rst18 ; $58fd
	nop ; $58fe
	INCBIN "data/bank_007/d_58ff.bin" ; $58ff, 1 bytes
	ret ; $5900
	ld hl, $df0f ; $5901
	bit 1, [hl] ; $5904
	jr nz, Label_07_58ec ; $5906
	ld a, $01 ; $5908
	ld [$c4a6], a ; $590a
	call Func_07_5876 ; $590d
	call Func_07_557e ; $5910
	call Func_07_571e ; $5913
	rst Rst18 ; $5916
	nop ; $5917
	INCBIN "data/bank_007/d_5918.bin" ; $5918, 1 bytes
	ret ; $5919
	call Func_07_5899 ; $591a
	call Func_07_557e ; $591d
	call Func_07_54ed ; $5920
	call Func_07_54fe ; $5923
	rst Rst18 ; $5926
	ld a, $07 ; $5927
	rst Rst18 ; $5929
	nop ; $592a
	inc h ; $592b
	ret ; $592c
	call Func_07_5899 ; $592d
	call Func_07_557e ; $5930
	call Func_07_54de ; $5933
	call Func_07_571e ; $5936
	rst Rst18 ; $5939
	ld [bc], a ; $593a
	inc h ; $593b
	ret ; $593c
	call Func_07_5525 ; $593d
	jr z, Label_07_597c ; $5940
	call Func_07_5876 ; $5942
	call Func_07_557e ; $5945
	call Func_07_54de ; $5948
	call Func_07_571e ; $594b
	rst Rst18 ; $594e
	nop ; $594f
	inc l ; $5950
	ret ; $5951
	call Func_07_5525 ; $5952
	jr z, Label_07_597c ; $5955
	call Func_07_5876 ; $5957
	call Func_07_557e ; $595a
	call Func_07_54de ; $595d
	call Func_07_571e ; $5960
	rst Rst18 ; $5963
	ld [bc], a ; $5964
	inc l ; $5965
	ret ; $5966
	call Func_07_5525 ; $5967
	jr z, Label_07_597c ; $596a
	call Func_07_5876 ; $596c
	call Func_07_557e ; $596f
	call Func_07_54de ; $5972
	call Func_07_571e ; $5975
	rst Rst18 ; $5978
	inc b ; $5979
	inc l ; $597a
	ret ; $597b
Label_07_597c:
	ld a, $05 ; $597c
	ld [$c4a0], a ; $597e
	call Func_07_5876 ; $5981
	call Func_07_557e ; $5984
	call Func_07_54de ; $5987
	call Func_07_571e ; $598a
	rst Rst18 ; $598d
	inc c ; $598e
	inc h ; $598f
	ret ; $5990
Label_07_5991:
	ld a, $09 ; $5991
	ld [$c4a0], a ; $5993
	ld a, $01 ; $5996
	ld [$c4a6], a ; $5998
	call Func_07_5876 ; $599b
	call Func_07_557e ; $599e
	call Func_07_571e ; $59a1
	rst Rst18 ; $59a4
	ld [$c924], sp ; $59a5
	call Func_07_5525 ; $59a8
	jr z, Label_07_59b8 ; $59ab
	ld a, [$df15] ; $59ad
	cp a, $07 ; $59b0
	jr z, Label_07_5991 ; $59b2
	cp a, $08 ; $59b4
	jr z, Label_07_5991 ; $59b6
Label_07_59b8:
	call Func_07_5876 ; $59b8
	call Func_07_557e ; $59bb
	call Func_07_571e ; $59be
	rst Rst18 ; $59c1
	ld b, $24 ; $59c2
	ret ; $59c4
	call Func_07_557e ; $59c5
	call Func_07_571e ; $59c8
	rst Rst18 ; $59cb
	nop ; $59cc
	add hl, hl ; $59cd
	call Func_07_5a01 ; $59ce
	ret ; $59d1
	call Func_07_557e ; $59d2
	call Func_07_571e ; $59d5
	rst Rst18 ; $59d8
	nop ; $59d9
	ld a, [hl+] ; $59da
	call Func_07_5a01 ; $59db
	ret ; $59de
	call Func_07_557e ; $59df
	call Func_07_571e ; $59e2
	rst Rst18 ; $59e5
	nop ; $59e6
	dec hl ; $59e7
	call Func_07_5a01 ; $59e8
	ret ; $59eb
	INCBIN "data/bank_007/d_59ec.bin" ; $59ec, 21 bytes
Func_07_5a01:
	ld hl, $c40a ; $5a01
	ld a, [hl+] ; $5a04
	ld h, [hl] ; $5a05
	ld l, a ; $5a06
	xor a, a ; $5a07
	sub a, l ; $5a08
	ld l, a ; $5a09
	sbc a, a ; $5a0a
	sub a, h ; $5a0b
	ld h, a ; $5a0c
	add hl, hl ; $5a0d
	add hl, hl ; $5a0e
	add hl, hl ; $5a0f
	add hl, hl ; $5a10
	ld a, h ; $5a11
	and a, $1f ; $5a12
	add a, $23 ; $5a14
	ld l, a ; $5a16
	adc a, $5a ; $5a17
	sub a, l ; $5a19
	ld h, a ; $5a1a
	ld a, [hl] ; $5a1b
	ld [$c4a5], a ; $5a1c
	ld [$c4a6], a ; $5a1f
	ret ; $5a22
	INCBIN "data/bank_007/d_5a23.bin" ; $5a23, 32 bytes
	push hl ; $5a43
	and a, $3f ; $5a44
	add a, $50 ; $5a46
	ld l, a ; $5a48
	adc a, $5a ; $5a49
	sub a, l ; $5a4b
	ld h, a ; $5a4c
	ld a, [hl] ; $5a4d
	pop hl ; $5a4e
	ret ; $5a4f
	INCBIN "data/bank_007/d_5a50.bin" ; $5a50, 32 bytes
	push de ; $5a70
	rst Rst18 ; $5a71
	ld [de], a ; $5a72
	inc b ; $5a73
	pop de ; $5a74
	ld a, e ; $5a75
	ld [$df3a], a ; $5a76
	ld a, [$df0b] ; $5a79
	add a, $04 ; $5a7c
	ld [$df37], a ; $5a7e
	ld a, [$df0b] ; $5a81
	add a, $af ; $5a84
	ld l, a ; $5a86
	adc a, $5a ; $5a87
	sub a, l ; $5a89
	ld h, a ; $5a8a
	ld a, [hl] ; $5a8b
	ld [$df36], a ; $5a8c
	ld a, [$df0b] ; $5a8f
	add a, a ; $5a92
	add a, $a7 ; $5a93
	ld l, a ; $5a95
	adc a, $5a ; $5a96
	sub a, l ; $5a98
	ld h, a ; $5a99
	ld a, [hl+] ; $5a9a
	ld d, [hl] ; $5a9b
	ld e, a ; $5a9c
	ld hl, $df26 ; $5a9d
	ld a, e ; $5aa0
	ld [hl+], a ; $5aa1
	ld [hl], d ; $5aa2
	rst Rst18 ; $5aa3
	ld e, $08 ; $5aa4
	ret ; $5aa6
	INCBIN "data/bank_007/d_5aa7.bin" ; $5aa7, 12 bytes
	ld a, [$df0b] ; $5ab3
	add a, a ; $5ab6
	add a, $42 ; $5ab7
	ld l, a ; $5ab9
	adc a, $5c ; $5aba
	sub a, l ; $5abc
	ld h, a ; $5abd
	ld a, [hl+] ; $5abe
	ld d, [hl] ; $5abf
	ld e, a ; $5ac0
	ld hl, $0010 ; $5ac1
	add hl, de ; $5ac4
	ld a, [hl+] ; $5ac5
	ld b, [hl] ; $5ac6
	ld c, a ; $5ac7
	ld hl, $fff0 ; $5ac8
	add hl, bc ; $5acb
	ld c, l ; $5acc
	ld b, h ; $5acd
	ld hl, $df70 ; $5ace
	ld a, c ; $5ad1
	ld [hl+], a ; $5ad2
	ld [hl], b ; $5ad3
	ld hl, $0012 ; $5ad4
	add hl, de ; $5ad7
	ld a, [hl+] ; $5ad8
	ld b, [hl] ; $5ad9
	ld c, a ; $5ada
	ld hl, $df72 ; $5adb
	ld a, c ; $5ade
	ld [hl+], a ; $5adf
	ld [hl], b ; $5ae0
	ld hl, $0014 ; $5ae1
	add hl, de ; $5ae4
	ld a, [hl+] ; $5ae5
	ld b, [hl] ; $5ae6
	ld c, a ; $5ae7
	ld hl, $0200 ; $5ae8
	add hl, bc ; $5aeb
	ld c, l ; $5aec
	ld b, h ; $5aed
	ld hl, $df74 ; $5aee
	ld a, c ; $5af1
	ld [hl+], a ; $5af2
	ld [hl], b ; $5af3
	ld hl, $0016 ; $5af4
	add hl, de ; $5af7
	ld a, [hl+] ; $5af8
	ld b, [hl] ; $5af9
	ld c, a ; $5afa
	ld hl, $df76 ; $5afb
	ld a, c ; $5afe
	ld [hl+], a ; $5aff
	ld [hl], b ; $5b00
	ld hl, $0019 ; $5b01
	add hl, de ; $5b04
	ld a, [hl+] ; $5b05
	ld b, [hl] ; $5b06
	ld c, a ; $5b07
	ld hl, $df90 ; $5b08
	ld a, c ; $5b0b
	ld [hl+], a ; $5b0c
	ld [hl], b ; $5b0d
	ld hl, $0018 ; $5b0e
	add hl, de ; $5b11
	ld a, [hl] ; $5b12
	ld [$df95], a ; $5b13
	ld b, $00 ; $5b16
	ld hl, $000e ; $5b18
	add hl, de ; $5b1b
	ld a, [hl] ; $5b1c
	and a, a ; $5b1d
	jr z, Label_07_5b22 ; $5b1e
	ld b, $20 ; $5b20
Label_07_5b22:
	ld a, b ; $5b22
	ld [$df94], a ; $5b23
	ld hl, $0027 ; $5b26
	add hl, de ; $5b29
	ld a, [hl] ; $5b2a
	add a, a ; $5b2b
	add a, $4a ; $5b2c
	ld l, a ; $5b2e
	adc a, $5c ; $5b2f
	sub a, l ; $5b31
	ld h, a ; $5b32
	ld a, [hl+] ; $5b33
	ld b, [hl] ; $5b34
	ld c, a ; $5b35
	ld hl, $df60 ; $5b36
	ld a, c ; $5b39
	ld [hl+], a ; $5b3a
	ld [hl], b ; $5b3b
	ld hl, $0027 ; $5b3c
	add hl, de ; $5b3f
	ld a, [hl] ; $5b40
	ld hl, $002b ; $5b41
	add hl, de ; $5b44
	add a, [hl] ; $5b45
	add a, a ; $5b46
	jr nc, Label_07_5b4c ; $5b47
	xor a, a ; $5b49
	jr Label_07_5b54 ; $5b4a
Label_07_5b4c:
	rra ; $5b4c
	cp a, $0a ; $5b4d
	jr c, Label_07_5b54 ; $5b4f
	ld a, $0a ; $5b51
	dec a ; $5b53
Label_07_5b54:
	add a, a ; $5b54
	add a, $4a ; $5b55
	ld l, a ; $5b57
	adc a, $5c ; $5b58
	sub a, l ; $5b5a
	ld h, a ; $5b5b
	ld a, [hl+] ; $5b5c
	ld b, [hl] ; $5b5d
	ld c, a ; $5b5e
	ld hl, $df62 ; $5b5f
	ld a, c ; $5b62
	ld [hl+], a ; $5b63
	ld [hl], b ; $5b64
	ld hl, $0028 ; $5b65
	add hl, de ; $5b68
	ld a, [hl] ; $5b69
	add a, a ; $5b6a
	add a, $5e ; $5b6b
	ld l, a ; $5b6d
	adc a, $5c ; $5b6e
	sub a, l ; $5b70
	ld h, a ; $5b71
	ld a, [hl+] ; $5b72
	ld b, [hl] ; $5b73
	ld c, a ; $5b74
	ld hl, $df64 ; $5b75
	ld a, c ; $5b78
	ld [hl+], a ; $5b79
	ld [hl], b ; $5b7a
	ld hl, $002a ; $5b7b
	add hl, de ; $5b7e
	ld a, [hl] ; $5b7f
	add a, a ; $5b80
	add a, $72 ; $5b81
	ld l, a ; $5b83
	adc a, $5c ; $5b84
	sub a, l ; $5b86
	ld h, a ; $5b87
	ld a, [hl+] ; $5b88
	ld b, [hl] ; $5b89
	ld c, a ; $5b8a
	ld hl, $df66 ; $5b8b
	ld a, c ; $5b8e
	ld [hl+], a ; $5b8f
	ld [hl], b ; $5b90
	ld hl, $0029 ; $5b91
	add hl, de ; $5b94
	ld a, [hl] ; $5b95
	add a, $86 ; $5b96
	ld l, a ; $5b98
	adc a, $5c ; $5b99
	sub a, l ; $5b9b
	ld h, a ; $5b9c
	ld a, [hl] ; $5b9d
	ld [$df68], a ; $5b9e
	ld hl, $0025 ; $5ba1
	add hl, de ; $5ba4
	ld a, [hl] ; $5ba5
	add a, $90 ; $5ba6
	ld l, a ; $5ba8
	adc a, $5c ; $5ba9
	sub a, l ; $5bab
	ld h, a ; $5bac
	ld a, [hl] ; $5bad
	ld [$df69], a ; $5bae
	ld hl, $0026 ; $5bb1
	add hl, de ; $5bb4
	ld a, [hl] ; $5bb5
	add a, $9a ; $5bb6
	ld l, a ; $5bb8
	adc a, $5c ; $5bb9
	sub a, l ; $5bbb
	ld h, a ; $5bbc
	ld a, [hl] ; $5bbd
	ld [$df6a], a ; $5bbe
	ld hl, $0023 ; $5bc1
	add hl, de ; $5bc4
	ld a, [hl] ; $5bc5
	ld [$df6b], a ; $5bc6
	ld hl, $0022 ; $5bc9
	add hl, de ; $5bcc
	ld a, [hl] ; $5bcd
	ld [$df6c], a ; $5bce
	ld hl, $0024 ; $5bd1
	add hl, de ; $5bd4
	ld a, [hl] ; $5bd5
	ld [$df6d], a ; $5bd6
	ld hl, $0021 ; $5bd9
	add hl, de ; $5bdc
	ld a, [hl] ; $5bdd
	ld [$df6f], a ; $5bde
	ld hl, $0020 ; $5be1
	add hl, de ; $5be4
	ld a, [hl] ; $5be5
	ld [$df6e], a ; $5be6
	ld hl, $000f ; $5be9
	add hl, de ; $5bec
	ld a, [hl] ; $5bed
	ld [$df7f], a ; $5bee
	ld hl, $001b ; $5bf1
	add hl, de ; $5bf4
	ld a, [hl] ; $5bf5
	ld [$df79], a ; $5bf6
	ld hl, $001c ; $5bf9
	add hl, de ; $5bfc
	ld a, [hl] ; $5bfd
	ld [$df7a], a ; $5bfe
	ld hl, $001d ; $5c01
	add hl, de ; $5c04
	ld a, [hl] ; $5c05
	ld [$df7b], a ; $5c06
	ld hl, $001e ; $5c09
	add hl, de ; $5c0c
	ld a, [hl] ; $5c0d
	ld [$df7c], a ; $5c0e
	ld hl, $001f ; $5c11
	add hl, de ; $5c14
	ld a, [hl] ; $5c15
	ld [$df7d], a ; $5c16
	ld a, $00 ; $5c19
	ld hl, $df91 ; $5c1b
	bit 0, [hl] ; $5c1e
	jr z, Label_07_5c24 ; $5c20
	ld a, $01 ; $5c22
Label_07_5c24:
	ld [$df92], a ; $5c24
	ld a, $00 ; $5c27
	ld hl, $df91 ; $5c29
	bit 1, [hl] ; $5c2c
	jr z, Label_07_5c32 ; $5c2e
	ld a, $01 ; $5c30
Label_07_5c32:
	ld [$df93], a ; $5c32
	ld a, [$c4ee] ; $5c35
	bit 1, a ; $5c38
	ret z ; $5c3a
	ld a, [$df0b] ; $5c3b
	call Func_07_5cf4 ; $5c3e
	ret ; $5c41
	INCBIN "data/bank_007/d_5c42.bin" ; $5c42, 178 bytes
Func_07_5cf4:
	push af ; $5cf4
	ld a, $04 ; $5cf5
	ld [$df79], a ; $5cf7
	ld a, $04 ; $5cfa
	ld [$df7a], a ; $5cfc
	ld a, $00 ; $5cff
	ld [$df7b], a ; $5d01
	ld a, $ff ; $5d04
	ld [$df7c], a ; $5d06
	ld a, $02 ; $5d09
	ld [$df7d], a ; $5d0b
	ld a, $00 ; $5d0e
	ld [$df6a], a ; $5d10
	ld a, $01 ; $5d13
	ld [$df7f], a ; $5d15
	ld a, $01 ; $5d18
	ld a, $01 ; $5d1a
	pop af ; $5d1c
	ret ; $5d1d
	INCBIN "data/bank_007/d_5d1e.bin" ; $5d1e, 383 bytes
	rst Rst18 ; $5e9d
	inc b ; $5e9e
	ld [$dfc9], sp ; $5e9f
	ld b, $08 ; $5ea2
	ld a, $02 ; $5ea4
	ld [wCurrentlyUsedCourt], a ; $5ea6
	ld a, $02 ; $5ea9
	ld [$c8f3], a ; $5eab
	ldh a, [$ff95] ; $5eae
	ld de, $5efc ; $5eb0
	rst Rst18 ; $5eb3
	ld c, b ; $5eb4
	ld [$f611], sp ; $5eb5
	ld e, a ; $5eb8
	rst Rst18 ; $5eb9
	ld c, d ; $5eba
	ld [$013e], sp ; $5ebb
	ld [$c78c], a ; $5ebe
	ld a, $1a ; $5ec1
	ld [$c3b0], a ; $5ec3
	ld a, $1c ; $5ec6
	ld [$c3b1], a ; $5ec8
	rst Rst18 ; $5ecb
	ld [bc], a ; $5ecc
	dec sp ; $5ecd
	rst Rst18 ; $5ece
	ld [$c908], sp ; $5ecf
	ret ; $5ed2
	INCBIN "data/bank_007/d_5ed3.bin" ; $5ed3, 8493 bytes

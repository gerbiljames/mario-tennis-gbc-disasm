INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1a", ROMX[$4000], BANK[$1a]

	INCBIN "data/bank_01a/d_4000.bin" ; $4000, 2 bytes
FarPtr_1a_02:
	dw Func_1a_413c ; $4002
	INCBIN "data/bank_01a/d_4004.bin" ; $4004, 4 bytes
FarPtr_1a_08:
	dw Func_1a_67d4 ; $4008
	INCBIN "data/bank_01a/d_400a.bin" ; $400a, 4 bytes
FarPtr_1a_0e:
	dw Func_1a_7ab5 ; $400e
FarPtr_1a_10:
	dw Func_1a_7b85 ; $4010
FarPtr_1a_12:
	dw Func_1a_7be5 ; $4012
	INCBIN "data/bank_01a/d_4014.bin" ; $4014, 296 bytes
Func_1a_413c:
	ld h, $80 ; $413c
	call Func_1a_4145 ; $413e
	call Func_00_0507 ; $4141
	ret ; $4144
Func_1a_4145:
	push af ; $4145
	push bc ; $4146
	push hl ; $4147
	push de ; $4148
	ld a, [$cb26] ; $4149
	farcall FarPtr_05_86 ; $414c
	ld d, [hl] ; $414f
	inc hl ; $4150
	ld e, [hl] ; $4151
	pop hl ; $4152
	ld a, h ; $4153
	add a, d ; $4154
	ld d, a ; $4155
	ld a, l ; $4156
	add a, e ; $4157
	ld e, a ; $4158
	farcall FarPtr_05_58 ; $4159
	ld h, d ; $415c
	ld l, e ; $415d
	ld de, $3000 ; $415e
	add hl, de ; $4161
	ld de, $9800 ; $4162
	add hl, de ; $4165
	ld d, h ; $4166
	ld e, l ; $4167
	pop hl ; $4168
	pop bc ; $4169
	pop af ; $416a
	ret ; $416b
	INCBIN "data/bank_01a/d_416c.bin" ; $416c, 2763 bytes
	ret ; $4c37
	INCBIN "data/bank_01a/d_4c38.bin" ; $4c38, 7068 bytes
Func_1a_67d4:
	xor a, a ; $67d4
	ld [$cb62], a ; $67d5
	ld [$cb63], a ; $67d8
Label_1a_67db:
	call Func_00_1b38 ; $67db
	call DisableLCDSafely ; $67de
	farcall FarPtr_01_0a ; $67e1
	xor a, a ; $67e4
	ldh [$ff8b], a ; $67e5
	ldh [$ff8a], a ; $67e7
	ld [$c320], a ; $67e9
	ld [$c321], a ; $67ec
	ld [$c322], a ; $67ef
	ld [$c323], a ; $67f2
	ld a, $90 ; $67f5
	ldh [rWY], a ; $67f7
	call Func_00_1e1d ; $67f9
	farcall FarPtr_04_00 ; $67fc
	farcall FarPtr_05_76 ; $67ff
	call Func_1a_686c ; $6802
	cp a, $ff ; $6805
	jr z, Label_1a_6854 ; $6807
	ld c, $40 ; $6809
	call Func_00_1d20 ; $680b
	call Func_00_1da4 ; $680e
	call DisableLCDSafely ; $6811
	call Func_1a_6c0b ; $6814
	call Func_1a_6b2f ; $6817
	call Func_1a_6f3d ; $681a
	call EnableLCD ; $681d
	ld a, $01 ; $6820
	ld hl, $6c28 ; $6822
	call Func_00_1b6a ; $6825
	call Func_1a_70c0 ; $6828
	call Func_1a_6e41 ; $682b
	call Func_00_2631 ; $682e
	ld a, $06 ; $6831
	ldh [$ff96], a ; $6833
	ldh [rWBK], a ; $6835
	ld a, [$d002] ; $6837
	ld de, $8700 ; $683a
	farcall FarPtr_18_44 ; $683d
	call Func_00_2631 ; $6840
	ld c, $10 ; $6843
	call Func_00_1d2e ; $6845
	call Func_00_1da4 ; $6848
	call Func_1a_6c9f ; $684b
	ld hl, $6c28 ; $684e
	call Func_00_1bcb ; $6851
Label_1a_6854:
	ld c, $10 ; $6854
	call Func_00_1d20 ; $6856
	call Func_00_1da4 ; $6859
	call DisableLCDSafely ; $685c
	farcall FarPtr_01_0a ; $685f
	call EnableLCD ; $6862
	call Func_00_2631 ; $6865
	jp Label_1a_67db ; $6868
	INCBIN "data/bank_01a/d_686b.bin" ; $686b, 1 bytes
Func_1a_686c:
	ld a, $06 ; $686c
	ldh [$ff96], a ; $686e
	ldh [rWBK], a ; $6870
	xor a, a ; $6872
	ld hl, $70d9 ; $6873
	ld de, $0008 ; $6876
	call Func_00_05b0 ; $6879
	ld hl, $70d9 ; $687c
	ld de, $0808 ; $687f
	call Func_00_05b0 ; $6882
	ld a, $01 ; $6885
	ldh [$ff96], a ; $6887
	ldh [rWBK], a ; $6889
	ld hl, $7119 ; $688b
	ld de, $d000 ; $688e
	call DecompressData ; $6891
	ld hl, $d000 ; $6894
	ld de, $b000 ; $6897
	ld c, $80 ; $689a
	call Func_00_0480 ; $689c
	ld hl, $d800 ; $689f
	ld de, $a800 ; $68a2
	ld c, $80 ; $68a5
	call Func_00_0480 ; $68a7
	call Func_1a_69eb ; $68aa
	ld a, [$cb62] ; $68ad
	call Func_1a_6a3a ; $68b0
	ld a, $03 ; $68b3
	ldh [$ff96], a ; $68b5
	ldh [rWBK], a ; $68b7
	ld hl, $d000 ; $68b9
	ld de, $9800 ; $68bc
	ld c, $24 ; $68bf
	call Func_00_0480 ; $68c1
	ld a, $02 ; $68c4
	ldh [$ff96], a ; $68c6
	ldh [rWBK], a ; $68c8
	ld hl, $d000 ; $68ca
	ld de, $b800 ; $68cd
	ld c, $24 ; $68d0
	call Func_00_0480 ; $68d2
	call EnableLCD ; $68d5
	ld a, $01 ; $68d8
	ld hl, $6ab3 ; $68da
	call Func_00_1b6a ; $68dd
	ld c, $10 ; $68e0
	call Func_00_1d2e ; $68e2
	call Func_00_1da4 ; $68e5
Label_1a_68e8:
	ld a, $06 ; $68e8
	ldh [$ff96], a ; $68ea
	ldh [rWBK], a ; $68ec
	call Func_00_2631 ; $68ee
	ldh a, [$ff91] ; $68f1
	bit 6, a ; $68f3
	jr nz, Label_1a_691b ; $68f5
	bit 7, a ; $68f7
	jr nz, Label_1a_6934 ; $68f9
	bit 5, a ; $68fb
	jr nz, Label_1a_694c ; $68fd
	bit 4, a ; $68ff
	jr nz, Label_1a_6979 ; $6901
	bit 0, a ; $6903
	jp nz, Label_1a_69c8 ; $6905
	bit 1, a ; $6908
	jp nz, Label_1a_69e0 ; $690a
	jr Label_1a_68e8 ; $690d
	INCBIN "data/bank_01a/d_690f.bin" ; $690f, 12 bytes
Label_1a_691b:
	ld a, [$cb63] ; $691b
	dec a ; $691e
	cp a, $ff ; $691f
	jr z, Label_1a_692b ; $6921
	cp a, $07 ; $6923
	jr nz, Label_1a_692d ; $6925
	ld a, $0f ; $6927
	jr Label_1a_692d ; $6929
Label_1a_692b:
	ld a, $07 ; $692b
Label_1a_692d:
	ld [$cb63], a ; $692d
	rst Rst08 ; $6930
	ld e, [hl] ; $6931
	jr Label_1a_68e8 ; $6932
Label_1a_6934:
	ld a, [$cb63] ; $6934
	inc a ; $6937
	cp a, $08 ; $6938
	jr z, Label_1a_6944 ; $693a
	cp a, $10 ; $693c
	jr nz, Label_1a_6945 ; $693e
	ld a, $08 ; $6940
	jr Label_1a_6945 ; $6942
Label_1a_6944:
	xor a, a ; $6944
Label_1a_6945:
	ld [$cb63], a ; $6945
	rst Rst08 ; $6948
	ld e, [hl] ; $6949
	jr Label_1a_68e8 ; $694a
Label_1a_694c:
	ld a, [$cb63] ; $694c
	sub a, $08 ; $694f
	jr nc, Label_1a_6966 ; $6951
	add a, $10 ; $6953
	ld [$cb63], a ; $6955
	ld a, [$cb62] ; $6958
	or a, a ; $695b
	jr z, Label_1a_696e ; $695c
	dec a ; $695e
	ld [$cb62], a ; $695f
	rst Rst08 ; $6962
	ld e, [hl] ; $6963
	jr Label_1a_69a9 ; $6964
Label_1a_6966:
	ld [$cb63], a ; $6966
	rst Rst08 ; $6969
	ld e, [hl] ; $696a
	jp Label_1a_68e8 ; $696b
Label_1a_696e:
	ld a, [$cb63] ; $696e
	sub a, $08 ; $6971
	ld [$cb63], a ; $6973
	jp Label_1a_68e8 ; $6976
Label_1a_6979:
	ld a, [$cb63] ; $6979
	add a, $08 ; $697c
	cp a, $10 ; $697e
	jr c, Label_1a_6996 ; $6980
	sub a, $10 ; $6982
	ld [$cb63], a ; $6984
	ld a, [$cb62] ; $6987
	cp a, $01 ; $698a
	jr z, Label_1a_699e ; $698c
	inc a ; $698e
	ld [$cb62], a ; $698f
	rst Rst08 ; $6992
	ld e, [hl] ; $6993
	jr Label_1a_69a9 ; $6994
Label_1a_6996:
	ld [$cb63], a ; $6996
	rst Rst08 ; $6999
	ld e, [hl] ; $699a
	jp Label_1a_68e8 ; $699b
Label_1a_699e:
	ld a, [$cb63] ; $699e
	add a, $08 ; $69a1
	ld [$cb63], a ; $69a3
	jp Label_1a_68e8 ; $69a6
Label_1a_69a9:
	push af ; $69a9
	call Func_1a_69eb ; $69aa
	pop af ; $69ad
	call Func_1a_6a3a ; $69ae
	ld a, $03 ; $69b1
	ldh [$ff96], a ; $69b3
	ldh [rWBK], a ; $69b5
	ld hl, $d020 ; $69b7
	ld de, $9820 ; $69ba
	ld c, $20 ; $69bd
	call Func_00_0480 ; $69bf
	call Func_00_2631 ; $69c2
	jp Label_1a_68e8 ; $69c5
Label_1a_69c8:
	ld hl, $6ab3 ; $69c8
	call Func_00_1bcb ; $69cb
	rst Rst08 ; $69ce
	ld e, a ; $69cf
	ld a, [$cb62] ; $69d0
	rlca ; $69d3
	rlca ; $69d4
	rlca ; $69d5
	rlca ; $69d6
	ld b, a ; $69d7
	ld a, [$cb63] ; $69d8
	add a, b ; $69db
	ld [$d002], a ; $69dc
	ret ; $69df
Label_1a_69e0:
	ld hl, $6ab3 ; $69e0
	call Func_00_1bcb ; $69e3
	rst Rst08 ; $69e6
	ld h, d ; $69e7
	ld a, $ff ; $69e8
	ret ; $69ea
Func_1a_69eb:
	ld a, $01 ; $69eb
	ldh [$ff96], a ; $69ed
	ldh [rWBK], a ; $69ef
	ld hl, $78b2 ; $69f1
	ld de, $d000 ; $69f4
	call DecompressData ; $69f7
	ld hl, $d000 ; $69fa
	ld bc, $0240 ; $69fd
	call Func_1a_6be1 ; $6a00
	ld a, $01 ; $6a03
	ldh [$ff96], a ; $6a05
	ldh [rWBK], a ; $6a07
	ld hl, $78ec ; $6a09
	ld de, $d000 ; $6a0c
	call DecompressData ; $6a0f
	ld hl, $d000 ; $6a12
	ld bc, $0240 ; $6a15
	call Func_1a_6bf6 ; $6a18
	ld a, $02 ; $6a1b
	ldh [$ff96], a ; $6a1d
	ldh [rWBK], a ; $6a1f
	ld hl, $d021 ; $6a21
	ld c, $10 ; $6a24
Label_1a_6a26:
	push hl ; $6a26
	ld b, $12 ; $6a27
Label_1a_6a29:
	xor a, a ; $6a29
	ld [hl+], a ; $6a2a
	dec b ; $6a2b
	jr nz, Label_1a_6a29 ; $6a2c
	pop hl ; $6a2e
	ld a, $20 ; $6a2f
	add a, l ; $6a31
	ld l, a ; $6a32
	jr nc, Label_1a_6a36 ; $6a33
	inc h ; $6a35
Label_1a_6a36:
	dec c ; $6a36
	jr nz, Label_1a_6a26 ; $6a37
	ret ; $6a39
Func_1a_6a3a:
	or a, a ; $6a3a
	jr z, Label_1a_6a44 ; $6a3b
	dec a ; $6a3d
	jr z, Label_1a_6a61 ; $6a3e
	dec a ; $6a40
	jr z, Label_1a_6a7e ; $6a41
	ret ; $6a43
Label_1a_6a44:
	ld a, $03 ; $6a44
	ldh [$ff96], a ; $6a46
	ldh [rWBK], a ; $6a48
	ld hl, $001b ; $6a4a
	ld de, $d043 ; $6a4d
	ld c, $08 ; $6a50
	call Func_1a_6a9b ; $6a52
	ld hl, $0023 ; $6a55
	ld de, $d04b ; $6a58
	ld c, $08 ; $6a5b
	call Func_1a_6a9b ; $6a5d
	ret ; $6a60
Label_1a_6a61:
	ld a, $03 ; $6a61
	ldh [$ff96], a ; $6a63
	ldh [rWBK], a ; $6a65
	ld hl, $002b ; $6a67
	ld de, $d043 ; $6a6a
	ld c, $08 ; $6a6d
	call Func_1a_6a9b ; $6a6f
	ld hl, $0033 ; $6a72
	ld de, $d04b ; $6a75
	ld c, $08 ; $6a78
	call Func_1a_6a9b ; $6a7a
	ret ; $6a7d
Label_1a_6a7e:
	ld a, $03 ; $6a7e
	ldh [$ff96], a ; $6a80
	ldh [rWBK], a ; $6a82
	ld hl, $003b ; $6a84
	ld de, $d043 ; $6a87
	ld c, $08 ; $6a8a
	call Func_1a_6a9b ; $6a8c
	ld hl, $0043 ; $6a8f
	ld de, $d04b ; $6a92
	ld c, $08 ; $6a95
	call Func_1a_6a9b ; $6a97
	ret ; $6a9a
Func_1a_6a9b:
	push bc ; $6a9b
	push de ; $6a9c
	push hl ; $6a9d
	ld c, $20 ; $6a9e
	farcall FarPtr_05_72 ; $6aa0
	pop hl ; $6aa3
	pop de ; $6aa4
	pop bc ; $6aa5
	dec c ; $6aa6
	ret z ; $6aa7
	inc hl ; $6aa8
	push hl ; $6aa9
	ld hl, $0040 ; $6aaa
	add hl, de ; $6aad
	ld d, h ; $6aae
	ld e, l ; $6aaf
	pop hl ; $6ab0
	jr Func_1a_6a9b ; $6ab1
	INCBIN "data/bank_01a/d_6ab3.bin" ; $6ab3, 124 bytes
Func_1a_6b2f:
	call Func_1a_6b55 ; $6b2f
	ld a, $03 ; $6b32
	ldh [$ff96], a ; $6b34
	ldh [rWBK], a ; $6b36
	ld hl, $d000 ; $6b38
	ld de, $9800 ; $6b3b
	ld c, $24 ; $6b3e
	call Func_00_0480 ; $6b40
	ld a, $02 ; $6b43
	ldh [$ff96], a ; $6b45
	ldh [rWBK], a ; $6b47
	ld hl, $d000 ; $6b49
	ld de, $b800 ; $6b4c
	ld c, $24 ; $6b4f
	call Func_00_0480 ; $6b51
	ret ; $6b54
Func_1a_6b55:
	ld hl, $70d9 ; $6b55
	ld de, $0008 ; $6b58
	call Func_00_05b0 ; $6b5b
	ld a, $01 ; $6b5e
	ldh [$ff96], a ; $6b60
	ldh [rWBK], a ; $6b62
	ld hl, $7119 ; $6b64
	ld de, $d000 ; $6b67
	call DecompressData ; $6b6a
	ld hl, $d000 ; $6b6d
	ld de, $b000 ; $6b70
	ld c, $80 ; $6b73
	call Func_00_0480 ; $6b75
	ld hl, $d800 ; $6b78
	ld de, $a800 ; $6b7b
	ld c, $80 ; $6b7e
	call Func_00_0480 ; $6b80
	ld a, $01 ; $6b83
	ldh [$ff96], a ; $6b85
	ldh [rWBK], a ; $6b87
	ld hl, $777d ; $6b89
	ld de, $d000 ; $6b8c
	call DecompressData ; $6b8f
	ld hl, $d000 ; $6b92
	ld bc, $0240 ; $6b95
	call Func_1a_6be1 ; $6b98
	ld a, $01 ; $6b9b
	ldh [$ff96], a ; $6b9d
	ldh [rWBK], a ; $6b9f
	ld hl, $7831 ; $6ba1
	ld de, $d000 ; $6ba4
	call DecompressData ; $6ba7
	ld hl, $d000 ; $6baa
	ld bc, $0240 ; $6bad
	call Func_1a_6bf6 ; $6bb0
	ld a, $02 ; $6bb3
	ldh [$ff96], a ; $6bb5
	ldh [rWBK], a ; $6bb7
	ld hl, $d1e1 ; $6bb9
	xor a, a ; $6bbc
	ld [hl+], a ; $6bbd
	ld [hl+], a ; $6bbe
	ld [hl+], a ; $6bbf
	ld [hl+], a ; $6bc0
	ld [hl+], a ; $6bc1
	ld [hl+], a ; $6bc2
	ld [hl+], a ; $6bc3
	ld [hl+], a ; $6bc4
	ld [hl+], a ; $6bc5
	ld [hl+], a ; $6bc6
	ld [hl+], a ; $6bc7
	ld [hl+], a ; $6bc8
	ld [hl+], a ; $6bc9
	ld [hl+], a ; $6bca
	ld [hl+], a ; $6bcb
	ld [hl+], a ; $6bcc
	ld hl, $d201 ; $6bcd
	ld [hl+], a ; $6bd0
	ld [hl+], a ; $6bd1
	ld [hl+], a ; $6bd2
	ld [hl+], a ; $6bd3
	ld [hl+], a ; $6bd4
	ld [hl+], a ; $6bd5
	ld [hl+], a ; $6bd6
	ld [hl+], a ; $6bd7
	ld [hl+], a ; $6bd8
	ld [hl+], a ; $6bd9
	ld [hl+], a ; $6bda
	ld [hl+], a ; $6bdb
	ld [hl+], a ; $6bdc
	ld [hl+], a ; $6bdd
	ld [hl+], a ; $6bde
	ld [hl+], a ; $6bdf
	ret ; $6be0
Func_1a_6be1:
	ld a, $01 ; $6be1
	ldh [$ff96], a ; $6be3
	ldh [rWBK], a ; $6be5
	ld d, [hl] ; $6be7
	ld a, $03 ; $6be8
	ldh [$ff96], a ; $6bea
	ldh [rWBK], a ; $6bec
	ld [hl], d ; $6bee
	inc hl ; $6bef
	dec bc ; $6bf0
	ld a, b ; $6bf1
	or a, c ; $6bf2
	jr nz, Func_1a_6be1 ; $6bf3
	ret ; $6bf5
Func_1a_6bf6:
	ld a, $01 ; $6bf6
	ldh [$ff96], a ; $6bf8
	ldh [rWBK], a ; $6bfa
	ld d, [hl] ; $6bfc
	ld a, $02 ; $6bfd
	ldh [$ff96], a ; $6bff
	ldh [rWBK], a ; $6c01
	ld [hl], d ; $6c03
	inc hl ; $6c04
	dec bc ; $6c05
	ld a, b ; $6c06
	or a, c ; $6c07
	jr nz, Func_1a_6bf6 ; $6c08
	ret ; $6c0a
Func_1a_6c0b:
	ld a, $06 ; $6c0b
	ldh [$ff96], a ; $6c0d
	ldh [rWBK], a ; $6c0f
	xor a, a ; $6c11
	ld [$d001], a ; $6c12
	ld [$d000], a ; $6c15
	ld [$d003], a ; $6c18
	ld [$d005], a ; $6c1b
	ld a, [$d002] ; $6c1e
	farcall FarPtr_02_34 ; $6c21
	ld [$d004], a ; $6c24
	ret ; $6c27
	INCBIN "data/bank_01a/d_6c28.bin" ; $6c28, 119 bytes
Func_1a_6c9f:
	call Func_1a_7012 ; $6c9f
	ld a, $06 ; $6ca2
	ldh [$ff96], a ; $6ca4
	ldh [rWBK], a ; $6ca6
	call Func_00_2631 ; $6ca8
	ldh a, [$ff91] ; $6cab
	bit 6, a ; $6cad
	jr nz, Label_1a_6cd5 ; $6caf
	bit 7, a ; $6cb1
	jr nz, Label_1a_6d23 ; $6cb3
	bit 5, a ; $6cb5
	jp nz, Label_1a_6d71 ; $6cb7
	bit 4, a ; $6cba
	jp nz, Label_1a_6dae ; $6cbc
	bit 0, a ; $6cbf
	jp nz, Label_1a_6de4 ; $6cc1
	bit 1, a ; $6cc4
	jp nz, Label_1a_6e1d ; $6cc6
	bit 3, a ; $6cc9
	jp nz, Label_1a_6e29 ; $6ccb
	bit 2, a ; $6cce
	jp nz, Label_1a_6e35 ; $6cd0
	jr Func_1a_6c9f ; $6cd3
Label_1a_6cd5:
	rst Rst08 ; $6cd5
	ld e, [hl] ; $6cd6
	ld a, $06 ; $6cd7
	ldh [$ff96], a ; $6cd9
	ldh [rWBK], a ; $6cdb
	ld a, [$d000] ; $6cdd
	or a, a ; $6ce0
	jr nz, Label_1a_6d0c ; $6ce1
	ld a, [$d001] ; $6ce3
	cp a, $0b ; $6ce6
	jr c, Label_1a_6cf5 ; $6ce8
	ld a, [$d001] ; $6cea
	sub a, $0b ; $6ced
	ld [$d001], a ; $6cef
	jp Label_1a_6e20 ; $6cf2
Label_1a_6cf5:
	ld a, $06 ; $6cf5
	ldh [$ff96], a ; $6cf7
	ldh [rWBK], a ; $6cf9
	ld a, [$d000] ; $6cfb
	xor a, $01 ; $6cfe
	ld [$d000], a ; $6d00
	ld a, [$d004] ; $6d03
	ld [$d001], a ; $6d06
	jp Label_1a_6e20 ; $6d09
Label_1a_6d0c:
	ld a, $06 ; $6d0c
	ldh [$ff96], a ; $6d0e
	ldh [rWBK], a ; $6d10
	ld a, [$d000] ; $6d12
	xor a, $01 ; $6d15
	ld [$d000], a ; $6d17
	ld a, [$d003] ; $6d1a
	ld [$d001], a ; $6d1d
	jp Label_1a_6e20 ; $6d20
Label_1a_6d23:
	rst Rst08 ; $6d23
	ld e, [hl] ; $6d24
	ld a, $06 ; $6d25
	ldh [$ff96], a ; $6d27
	ldh [rWBK], a ; $6d29
	ld a, [$d000] ; $6d2b
	or a, a ; $6d2e
	jr nz, Label_1a_6d5a ; $6d2f
	ld a, [$d001] ; $6d31
	cp a, $0b ; $6d34
	jr nc, Label_1a_6d43 ; $6d36
	ld a, [$d001] ; $6d38
	add a, $0b ; $6d3b
	ld [$d001], a ; $6d3d
	jp Label_1a_6e20 ; $6d40
Label_1a_6d43:
	ld a, $06 ; $6d43
	ldh [$ff96], a ; $6d45
	ldh [rWBK], a ; $6d47
	ld a, [$d000] ; $6d49
	xor a, $01 ; $6d4c
	ld [$d000], a ; $6d4e
	ld a, [$d004] ; $6d51
	ld [$d001], a ; $6d54
	jp Label_1a_6e20 ; $6d57
Label_1a_6d5a:
	ld a, $06 ; $6d5a
	ldh [$ff96], a ; $6d5c
	ldh [rWBK], a ; $6d5e
	ld a, [$d000] ; $6d60
	xor a, $01 ; $6d63
	ld [$d000], a ; $6d65
	ld a, [$d003] ; $6d68
	ld [$d001], a ; $6d6b
	jp Label_1a_6e20 ; $6d6e
Label_1a_6d71:
	rst Rst08 ; $6d71
	ld e, [hl] ; $6d72
	ld a, $06 ; $6d73
	ldh [$ff96], a ; $6d75
	ldh [rWBK], a ; $6d77
	ld a, [$d000] ; $6d79
	or a, a ; $6d7c
	jr nz, Label_1a_6d9f ; $6d7d
	ld a, [$d001] ; $6d7f
	dec a ; $6d82
	ld [$d001], a ; $6d83
	cp a, $ff ; $6d86
	jr nz, Label_1a_6d92 ; $6d88
	ld a, $0a ; $6d8a
	ld [$d001], a ; $6d8c
	jp Label_1a_6e20 ; $6d8f
Label_1a_6d92:
	cp a, $0a ; $6d92
	jp nz, Label_1a_6e20 ; $6d94
	ld a, $15 ; $6d97
	ld [$d001], a ; $6d99
	jp Label_1a_6e20 ; $6d9c
Label_1a_6d9f:
	ld a, [$d001] ; $6d9f
	dec a ; $6da2
	cp a, $ff ; $6da3
	jr nz, Label_1a_6da9 ; $6da5
	ld a, $04 ; $6da7
Label_1a_6da9:
	ld [$d001], a ; $6da9
	jr Label_1a_6e20 ; $6dac
Label_1a_6dae:
	rst Rst08 ; $6dae
	ld e, [hl] ; $6daf
	ld a, $06 ; $6db0
	ldh [$ff96], a ; $6db2
	ldh [rWBK], a ; $6db4
	ld a, [$d000] ; $6db6
	or a, a ; $6db9
	jr nz, Label_1a_6dd6 ; $6dba
	ld a, [$d001] ; $6dbc
	inc a ; $6dbf
	ld [$d001], a ; $6dc0
	cp a, $0b ; $6dc3
	jr nz, Label_1a_6dcb ; $6dc5
	xor a, a ; $6dc7
	ld [$d001], a ; $6dc8
Label_1a_6dcb:
	cp a, $16 ; $6dcb
	jr nz, Label_1a_6e20 ; $6dcd
	ld a, $0b ; $6dcf
	ld [$d001], a ; $6dd1
	jr Label_1a_6e20 ; $6dd4
Label_1a_6dd6:
	ld a, [$d001] ; $6dd6
	inc a ; $6dd9
	cp a, $05 ; $6dda
	jr nz, Label_1a_6ddf ; $6ddc
	xor a, a ; $6dde
Label_1a_6ddf:
	ld [$d001], a ; $6ddf
	jr Label_1a_6e20 ; $6de2
Label_1a_6de4:
	rst Rst08 ; $6de4
	ld e, [hl] ; $6de5
	ld a, $06 ; $6de6
	ldh [$ff96], a ; $6de8
	ldh [rWBK], a ; $6dea
	ld a, [$d000] ; $6dec
	or a, a ; $6def
	jr nz, Label_1a_6e12 ; $6df0
	ld a, [$d001] ; $6df2
	ld [$d003], a ; $6df5
	ld hl, $792f ; $6df8
	add a, l ; $6dfb
	ld l, a ; $6dfc
	jr nc, Label_1a_6e00 ; $6dfd
	inc h ; $6dff
Label_1a_6e00:
	ld d, [hl] ; $6e00
	ld a, $04 ; $6e01
	ldh [$ff96], a ; $6e03
	ldh [rWBK], a ; $6e05
	farcall FarPtr_08_20 ; $6e07
	ld a, $06 ; $6e0a
	ldh [$ff96], a ; $6e0c
	ldh [rWBK], a ; $6e0e
	jr Label_1a_6e20 ; $6e10
Label_1a_6e12:
	ld a, [$d001] ; $6e12
	ld [$d004], a ; $6e15
	call Func_1a_70c0 ; $6e18
	jr Label_1a_6e20 ; $6e1b
Label_1a_6e1d:
	rst Rst08 ; $6e1d
	ld h, d ; $6e1e
	ret ; $6e1f
Label_1a_6e20:
	call Func_1a_6e41 ; $6e20
	call Func_00_2631 ; $6e23
	jp Func_1a_6c9f ; $6e26
Label_1a_6e29:
	ld a, [$d005] ; $6e29
	dec a ; $6e2c
	and a, $07 ; $6e2d
	ld [$d005], a ; $6e2f
	jp Func_1a_6c9f ; $6e32
Label_1a_6e35:
	ld a, [$d005] ; $6e35
	inc a ; $6e38
	and a, $07 ; $6e39
	ld [$d005], a ; $6e3b
	jp Func_1a_6c9f ; $6e3e
Func_1a_6e41:
	ld a, $02 ; $6e41
	ldh [$ff96], a ; $6e43
	ldh [rWBK], a ; $6e45
	ld a, $09 ; $6e47
	ld hl, $d128 ; $6e49
	ld [hl+], a ; $6e4c
	ld [hl+], a ; $6e4d
	ld [hl+], a ; $6e4e
	ld [hl+], a ; $6e4f
	ld [hl+], a ; $6e50
	ld [hl+], a ; $6e51
	ld [hl+], a ; $6e52
	ld [hl+], a ; $6e53
	ld [hl+], a ; $6e54
	ld [hl+], a ; $6e55
	ld [hl+], a ; $6e56
	ld hl, $d148 ; $6e57
	ld [hl+], a ; $6e5a
	ld [hl+], a ; $6e5b
	ld [hl+], a ; $6e5c
	ld [hl+], a ; $6e5d
	ld [hl+], a ; $6e5e
	ld [hl+], a ; $6e5f
	ld [hl+], a ; $6e60
	ld [hl+], a ; $6e61
	ld [hl+], a ; $6e62
	ld [hl+], a ; $6e63
	ld [hl+], a ; $6e64
	ld hl, $d1c8 ; $6e65
	ld [hl+], a ; $6e68
	ld [hl+], a ; $6e69
	ld [hl+], a ; $6e6a
	ld [hl+], a ; $6e6b
	ld [hl+], a ; $6e6c
	ld a, $06 ; $6e6d
	ldh [$ff96], a ; $6e6f
	ldh [rWBK], a ; $6e71
	ld a, [$d003] ; $6e73
	cp a, $0b ; $6e76
	jr nc, Label_1a_6e83 ; $6e78
	add a, $28 ; $6e7a
	ld l, a ; $6e7c
	adc a, $d1 ; $6e7d
	sub a, l ; $6e7f
	ld h, a ; $6e80
	jr Label_1a_6e8c ; $6e81
Label_1a_6e83:
	sub a, $0b ; $6e83
	add a, $48 ; $6e85
	ld l, a ; $6e87
	adc a, $d1 ; $6e88
	sub a, l ; $6e8a
	ld h, a ; $6e8b
Label_1a_6e8c:
	ld a, $02 ; $6e8c
	ldh [$ff96], a ; $6e8e
	ldh [rWBK], a ; $6e90
	ld a, $08 ; $6e92
	ld [hl], a ; $6e94
	ld hl, $d120 ; $6e95
	ld de, $b920 ; $6e98
	ld c, $04 ; $6e9b
	call Func_00_0480 ; $6e9d
	ld a, $06 ; $6ea0
	ldh [$ff96], a ; $6ea2
	ldh [rWBK], a ; $6ea4
	ld a, [$d004] ; $6ea6
	add a, $c8 ; $6ea9
	ld l, a ; $6eab
	adc a, $d1 ; $6eac
	sub a, l ; $6eae
	ld h, a ; $6eaf
	ld a, $02 ; $6eb0
	ldh [$ff96], a ; $6eb2
	ldh [rWBK], a ; $6eb4
	ld a, $08 ; $6eb6
	ld [hl], a ; $6eb8
	ld hl, $d1c0 ; $6eb9
	ld de, $b9c0 ; $6ebc
	ld c, $02 ; $6ebf
	call Func_00_0480 ; $6ec1
	ld a, $03 ; $6ec4
	ldh [$ff96], a ; $6ec6
	ldh [rWBK], a ; $6ec8
	ld hl, $d1e1 ; $6eca
	ld a, $20 ; $6ecd
	ld [hl+], a ; $6ecf
	ld [hl+], a ; $6ed0
	ld [hl+], a ; $6ed1
	ld [hl+], a ; $6ed2
	ld [hl+], a ; $6ed3
	ld [hl+], a ; $6ed4
	ld [hl+], a ; $6ed5
	ld [hl+], a ; $6ed6
	ld [hl+], a ; $6ed7
	ld [hl+], a ; $6ed8
	ld [hl+], a ; $6ed9
	ld [hl+], a ; $6eda
	ld [hl+], a ; $6edb
	ld [hl+], a ; $6edc
	ld [hl+], a ; $6edd
	ld [hl+], a ; $6ede
	ld hl, $d201 ; $6edf
	ld [hl+], a ; $6ee2
	ld [hl+], a ; $6ee3
	ld [hl+], a ; $6ee4
	ld [hl+], a ; $6ee5
	ld [hl+], a ; $6ee6
	ld [hl+], a ; $6ee7
	ld [hl+], a ; $6ee8
	ld [hl+], a ; $6ee9
	ld [hl+], a ; $6eea
	ld [hl+], a ; $6eeb
	ld [hl+], a ; $6eec
	ld [hl+], a ; $6eed
	ld [hl+], a ; $6eee
	ld [hl+], a ; $6eef
	ld [hl+], a ; $6ef0
	ld [hl+], a ; $6ef1
	ld a, $06 ; $6ef2
	ldh [$ff96], a ; $6ef4
	ldh [rWBK], a ; $6ef6
	ld a, [$d000] ; $6ef8
	or a, a ; $6efb
	jr nz, Label_1a_6f1a ; $6efc
	ld a, [$d001] ; $6efe
	add a, $01 ; $6f01
	add a, $c0 ; $6f03
	ld l, a ; $6f05
	adc a, $10 ; $6f06
	sub a, l ; $6f08
	ld h, a ; $6f09
	ld de, $d201 ; $6f0a
	ld c, $20 ; $6f0d
	ld a, $03 ; $6f0f
	ldh [$ff96], a ; $6f11
	ldh [rWBK], a ; $6f13
	farcall FarPtr_05_72 ; $6f15
	jr Label_1a_6f2b ; $6f18
Label_1a_6f1a:
	ld a, $03 ; $6f1a
	ldh [$ff96], a ; $6f1c
	ldh [rWBK], a ; $6f1e
	ld hl, $10c0 ; $6f20
	ld de, $d201 ; $6f23
	ld c, $20 ; $6f26
	farcall FarPtr_05_72 ; $6f28
Label_1a_6f2b:
	ld a, $03 ; $6f2b
	ldh [$ff96], a ; $6f2d
	ldh [rWBK], a ; $6f2f
	ld hl, $d1e0 ; $6f31
	ld de, $99e0 ; $6f34
	ld c, $04 ; $6f37
	call Func_00_0480 ; $6f39
	ret ; $6f3c
Func_1a_6f3d:
	call Func_1a_7096 ; $6f3d
	ld a, $06 ; $6f40
	ldh [$ff96], a ; $6f42
	ldh [rWBK], a ; $6f44
	ld a, [$d002] ; $6f46
	farcall FarPtr_04_30 ; $6f49
	ld d, a ; $6f4c
	ld a, $04 ; $6f4d
	ldh [$ff96], a ; $6f4f
	ldh [rWBK], a ; $6f51
	ldh a, [$ff95] ; $6f53
	ld hl, $6fcf ; $6f55
	farcall FarPtr_04_0a ; $6f58
	ld bc, $d000 ; $6f5b
	farcall FarPtr_04_2c ; $6f5e
	ld bc, $d040 ; $6f61
	farcall FarPtr_04_2c ; $6f64
	ld bc, $d080 ; $6f67
	farcall FarPtr_04_2c ; $6f6a
	ld bc, $d0c0 ; $6f6d
	farcall FarPtr_04_2c ; $6f70
	ld d, $01 ; $6f73
	ld bc, $d000 ; $6f75
	farcall FarPtr_04_16 ; $6f78
	ld bc, $d040 ; $6f7b
	farcall FarPtr_04_16 ; $6f7e
	ld bc, $d080 ; $6f81
	farcall FarPtr_04_16 ; $6f84
	ld bc, $d0c0 ; $6f87
	farcall FarPtr_04_16 ; $6f8a
	ld a, $07 ; $6f8d
	ld [$d037], a ; $6f8f
	ld [$d077], a ; $6f92
	ld [$d0b7], a ; $6f95
	ld [$d0f7], a ; $6f98
	ld a, $06 ; $6f9b
	ldh [$ff96], a ; $6f9d
	ldh [rWBK], a ; $6f9f
	ld a, [$d002] ; $6fa1
	ld [$c3b0], a ; $6fa4
	ld d, a ; $6fa7
	ld a, $04 ; $6fa8
	ldh [$ff96], a ; $6faa
	ldh [rWBK], a ; $6fac
	ld hl, $df00 ; $6fae
	ld c, $10 ; $6fb1
	call ClearMemory16 ; $6fb3
	ld a, $00 ; $6fb6
	farcall FarPtr_08_0c ; $6fb8
	ld a, $07 ; $6fbb
	ld [$df37], a ; $6fbd
	ld de, $8600 ; $6fc0
	ld hl, $df26 ; $6fc3
	ld a, e ; $6fc6
	ld [hl+], a ; $6fc7
	ld [hl], d ; $6fc8
	ld hl, $df36 ; $6fc9
	ld [hl], $60 ; $6fcc
	ret ; $6fce
	INCBIN "data/bank_01a/d_6fcf.bin" ; $6fcf, 67 bytes
Func_1a_7012:
	ld bc, $0770 ; $7012
	ld de, $4615 ; $7015
	call Func_00_1f51 ; $7018
	ld bc, $0772 ; $701b
	ld de, $4e15 ; $701e
	call Func_00_1f51 ; $7021
	ld a, $04 ; $7024
	ldh [$ff96], a ; $7026
	ldh [rWBK], a ; $7028
	ld hl, $df00 ; $702a
	ld b, h ; $702d
	ld c, l ; $702e
	farcall FarPtr_08_12 ; $702f
	ld a, $06 ; $7032
	ldh [$ff96], a ; $7034
	ldh [rWBK], a ; $7036
	ld a, [$d005] ; $7038
	ld d, a ; $703b
	ld a, $04 ; $703c
	ldh [$ff96], a ; $703e
	ldh [rWBK], a ; $7040
	push de ; $7042
	farcall FarPtr_08_14 ; $7043
	pop de ; $7046
	ld a, d ; $7047
	add a, $8e ; $7048
	ld l, a ; $704a
	adc a, $70 ; $704b
	sub a, l ; $704d
	ld h, a ; $704e
	ld b, [hl] ; $704f
	ld hl, $df36 ; $7050
	ld a, [hl+] ; $7053
	ld c, a ; $7054
	ld a, [hl] ; $7055
	or a, b ; $7056
	ld b, a ; $7057
	push bc ; $7058
	push de ; $7059
	ld d, $20 ; $705a
	ld e, $68 ; $705c
	ld a, d ; $705e
	ld [$df53], a ; $705f
	ld a, e ; $7062
	ld [$df54], a ; $7063
	pop hl ; $7066
	add hl, hl ; $7067
	add hl, hl ; $7068
	add hl, hl ; $7069
	pop bc ; $706a
	push hl ; $706b
	ld hl, $df80 ; $706c
	ld a, c ; $706f
	ld [hl+], a ; $7070
	ld a, b ; $7071
	ld [hl+], a ; $7072
	ld a, e ; $7073
	ld [hl+], a ; $7074
	ld a, d ; $7075
	ld [hl+], a ; $7076
	ld a, [$df1d] ; $7077
	ld [hl+], a ; $707a
	ld a, [$df1c] ; $707b
	ld [hl+], a ; $707e
	ld a, [$df1b] ; $707f
	ld [hl+], a ; $7082
	pop af ; $7083
	add a, $80 ; $7084
	ld [hl+], a ; $7086
	ld hl, $df80 ; $7087
	farcall FarPtr_08_10 ; $708a
	ret ; $708d
	INCBIN "data/bank_01a/d_708e.bin" ; $708e, 8 bytes
Func_1a_7096:
	xor a, a ; $7096
	ld de, $0701 ; $7097
	farcall FarPtr_1b_02 ; $709a
	ld a, $06 ; $709d
	ldh [$ff96], a ; $709f
	ldh [rWBK], a ; $70a1
	ld a, [$d002] ; $70a3
	ld b, a ; $70a6
	ld a, $01 ; $70a7
	ldh [$ff96], a ; $70a9
	ldh [rWBK], a ; $70ab
	ld a, b ; $70ad
	ld de, $d000 ; $70ae
	farcall FarPtr_1b_00 ; $70b1
	ld hl, $d000 ; $70b4
	ld de, $b100 ; $70b7
	ld c, $09 ; $70ba
	call Func_00_0480 ; $70bc
	ret ; $70bf
Func_1a_70c0:
	ld a, $06 ; $70c0
	ldh [$ff96], a ; $70c2
	ldh [rWBK], a ; $70c4
	ld a, [$d004] ; $70c6
	ld de, $0701 ; $70c9
	farcall FarPtr_1b_02 ; $70cc
	ld a, [$d004] ; $70cf
	ld de, $0f01 ; $70d2
	farcall FarPtr_1b_02 ; $70d5
	ret ; $70d8
	INCBIN "data/bank_01a/d_70d9.bin" ; $70d9, 2524 bytes
Func_1a_7ab5:
	ld a, [$cb00] ; $7ab5
	or a, a ; $7ab8
	ret nz ; $7ab9
	ld a, $06 ; $7aba
	ldh [$ff96], a ; $7abc
	ldh [rWBK], a ; $7abe
	xor a, a ; $7ac0
	ld hl, $d0ab ; $7ac1
	ld [hl+], a ; $7ac4
	ld [hl+], a ; $7ac5
	ld [hl+], a ; $7ac6
	ld [hl+], a ; $7ac7
	ld [hl+], a ; $7ac8
	ld [hl+], a ; $7ac9
	ld [hl+], a ; $7aca
	ld [hl+], a ; $7acb
	ld [hl+], a ; $7acc
	ld [hl+], a ; $7acd
	ld [hl+], a ; $7ace
	ld a, [wEquippedRacket] ; $7acf
	or a, a ; $7ad2
	ret z ; $7ad3
	farcall FarPtr_02_12 ; $7ad4
	ld hl, $c920 ; $7ad7
	ld de, $d0a0 ; $7ada
	ld a, [hl+] ; $7add
	ld [de], a ; $7ade
	inc de ; $7adf
	ld a, [hl+] ; $7ae0
	ld [de], a ; $7ae1
	inc de ; $7ae2
	ld a, [hl+] ; $7ae3
	ld [de], a ; $7ae4
	inc de ; $7ae5
	ld a, [hl+] ; $7ae6
	ld [de], a ; $7ae7
	inc de ; $7ae8
	ld a, [hl+] ; $7ae9
	ld [de], a ; $7aea
	inc de ; $7aeb
	ld a, [hl+] ; $7aec
	ld [de], a ; $7aed
	inc de ; $7aee
	ld a, [hl+] ; $7aef
	ld [de], a ; $7af0
	inc de ; $7af1
	ld a, [hl+] ; $7af2
	ld [de], a ; $7af3
	inc de ; $7af4
	ld a, [hl+] ; $7af5
	ld [de], a ; $7af6
	inc de ; $7af7
	ld a, [hl+] ; $7af8
	ld [de], a ; $7af9
	inc de ; $7afa
	ld a, [hl] ; $7afb
	ld [de], a ; $7afc
	ld hl, $d0a0 ; $7afd
	ld c, [hl] ; $7b00
	ld a, [$d00e] ; $7b01
	dec a ; $7b04
	sub a, c ; $7b05
	ld [$d0ab], a ; $7b06
	ld hl, $d0a1 ; $7b09
	ld c, [hl] ; $7b0c
	ld a, [$d00f] ; $7b0d
	dec a ; $7b10
	sub a, c ; $7b11
	ld [$d0ac], a ; $7b12
	ld hl, $d0a2 ; $7b15
	ld c, [hl] ; $7b18
	ld a, [$d010] ; $7b19
	dec a ; $7b1c
	sub a, c ; $7b1d
	ld [$d0ad], a ; $7b1e
	ld hl, $d0a3 ; $7b21
	ld c, [hl] ; $7b24
	ld a, [$d011] ; $7b25
	dec a ; $7b28
	sub a, c ; $7b29
	ld [$d0ae], a ; $7b2a
	ld hl, $d0a4 ; $7b2d
	ld c, [hl] ; $7b30
	ld a, [$d012] ; $7b31
	dec a ; $7b34
	sub a, c ; $7b35
	ld [$d0af], a ; $7b36
	ld hl, $d0a5 ; $7b39
	ld c, [hl] ; $7b3c
	ld a, [$d013] ; $7b3d
	dec a ; $7b40
	sub a, c ; $7b41
	ld [$d0b0], a ; $7b42
	ld hl, $d0a6 ; $7b45
	ld c, [hl] ; $7b48
	ld a, [$d014] ; $7b49
	dec a ; $7b4c
	sub a, c ; $7b4d
	ld [$d0b1], a ; $7b4e
	ld hl, $d0a7 ; $7b51
	ld c, [hl] ; $7b54
	ld a, [$d015] ; $7b55
	dec a ; $7b58
	sub a, c ; $7b59
	ld [$d0b2], a ; $7b5a
	ld hl, $d0a8 ; $7b5d
	ld c, [hl] ; $7b60
	ld a, [$d016] ; $7b61
	dec a ; $7b64
	sub a, c ; $7b65
	ld [$d0b3], a ; $7b66
	ld hl, $d0a9 ; $7b69
	ld c, [hl] ; $7b6c
	ld a, [$d017] ; $7b6d
	dec a ; $7b70
	sub a, c ; $7b71
	ld [$d0b4], a ; $7b72
	ld hl, $d0aa ; $7b75
	ld c, [hl] ; $7b78
	ld a, [$d018] ; $7b79
	dec a ; $7b7c
	sub a, c ; $7b7d
	ld [$d0b5], a ; $7b7e
	farcall FarPtr_02_10 ; $7b81
	ret ; $7b84
Func_1a_7b85:
	ld hl, $7e7e ; $7b85
	ld de, $0c02 ; $7b88
	call Func_00_05b0 ; $7b8b
	ld a, $01 ; $7b8e
	ldh [$ff96], a ; $7b90
	ldh [rWBK], a ; $7b92
	ld hl, $7e8e ; $7b94
	ld de, $d000 ; $7b97
	call DecompressData ; $7b9a
	ld hl, $d000 ; $7b9d
	ld de, $a780 ; $7ba0
	ld c, $02 ; $7ba3
	call Func_00_0480 ; $7ba5
	ld hl, $7e99 ; $7ba8
	ld de, $d000 ; $7bab
	call DecompressData ; $7bae
	ld hl, $d000 ; $7bb1
	ld de, $a7a0 ; $7bb4
	ld c, $02 ; $7bb7
	call Func_00_0480 ; $7bb9
	ld hl, $7ea4 ; $7bbc
	ld de, $d000 ; $7bbf
	call DecompressData ; $7bc2
	ld hl, $d000 ; $7bc5
	ld de, $a7c0 ; $7bc8
	ld c, $02 ; $7bcb
	call Func_00_0480 ; $7bcd
	ld hl, $7eaf ; $7bd0
	ld de, $d000 ; $7bd3
	call DecompressData ; $7bd6
	ld hl, $d000 ; $7bd9
	ld de, $a7e0 ; $7bdc
	ld c, $02 ; $7bdf
	call Func_00_0480 ; $7be1
	ret ; $7be4
Func_1a_7be5:
	ld a, $06 ; $7be5
	ldh [$ff96], a ; $7be7
	ldh [rWBK], a ; $7be9
	ld a, [$d142] ; $7beb
	dec a ; $7bee
	ret nz ; $7bef
	ld hl, $d145 ; $7bf0
	ld a, [hl+] ; $7bf3
	ld h, [hl] ; $7bf4
	ld l, a ; $7bf5
	ld a, h ; $7bf6
	or a, l ; $7bf7
	ret nz ; $7bf8
	ldh a, [$ff8c] ; $7bf9
	and a, $18 ; $7bfb
	ret z ; $7bfd
	ld a, [$d0ab] ; $7bfe
	or a, a ; $7c01
	jr z, Label_1a_7c2b ; $7c02
	call Func_1a_7dee ; $7c04
	call Func_1a_7df5 ; $7c07
	push af ; $7c0a
	ld a, [$d0a0] ; $7c0b
	ld l, a ; $7c0e
	ld a, [$d019] ; $7c0f
	add a, l ; $7c12
	ld de, $142c ; $7c13
	call Func_1a_7e23 ; $7c16
	push de ; $7c19
	call Func_00_1f51 ; $7c1a
	pop de ; $7c1d
	pop af ; $7c1e
	or a, a ; $7c1f
	jr z, Label_1a_7c2b ; $7c20
	call Func_1a_7e15 ; $7c22
	call Func_1a_7e38 ; $7c25
	call Func_00_1f51 ; $7c28
Label_1a_7c2b:
	ld a, [$d0ac] ; $7c2b
	or a, a ; $7c2e
	jr z, Label_1a_7c58 ; $7c2f
	call Func_1a_7dee ; $7c31
	call Func_1a_7df5 ; $7c34
	push af ; $7c37
	ld a, [$d0a1] ; $7c38
	ld l, a ; $7c3b
	ld a, [$d01a] ; $7c3c
	add a, l ; $7c3f
	ld de, $143c ; $7c40
	call Func_1a_7e23 ; $7c43
	push de ; $7c46
	call Func_00_1f51 ; $7c47
	pop de ; $7c4a
	pop af ; $7c4b
	or a, a ; $7c4c
	jr z, Label_1a_7c58 ; $7c4d
	call Func_1a_7e15 ; $7c4f
	call Func_1a_7e38 ; $7c52
	call Func_00_1f51 ; $7c55
Label_1a_7c58:
	ld a, [$d0ad] ; $7c58
	or a, a ; $7c5b
	jr z, Label_1a_7c85 ; $7c5c
	call Func_1a_7dee ; $7c5e
	call Func_1a_7df5 ; $7c61
	push af ; $7c64
	ld a, [$d0a2] ; $7c65
	ld l, a ; $7c68
	ld a, [$d01b] ; $7c69
	add a, l ; $7c6c
	ld de, $1454 ; $7c6d
	call Func_1a_7e23 ; $7c70
	push de ; $7c73
	call Func_00_1f51 ; $7c74
	pop de ; $7c77
	pop af ; $7c78
	or a, a ; $7c79
	jr z, Label_1a_7c85 ; $7c7a
	call Func_1a_7e15 ; $7c7c
	call Func_1a_7e38 ; $7c7f
	call Func_00_1f51 ; $7c82
Label_1a_7c85:
	ld a, [$d0ae] ; $7c85
	or a, a ; $7c88
	jr z, Label_1a_7cb2 ; $7c89
	call Func_1a_7dee ; $7c8b
	call Func_1a_7df5 ; $7c8e
	push af ; $7c91
	ld a, [$d0a3] ; $7c92
	ld l, a ; $7c95
	ld a, [$d01c] ; $7c96
	add a, l ; $7c99
	ld de, $1464 ; $7c9a
	call Func_1a_7e23 ; $7c9d
	push de ; $7ca0
	call Func_00_1f51 ; $7ca1
	pop de ; $7ca4
	pop af ; $7ca5
	or a, a ; $7ca6
	jr z, Label_1a_7cb2 ; $7ca7
	call Func_1a_7e15 ; $7ca9
	call Func_1a_7e38 ; $7cac
	call Func_00_1f51 ; $7caf
Label_1a_7cb2:
	ld a, [$d0af] ; $7cb2
	or a, a ; $7cb5
	jr z, Label_1a_7cdf ; $7cb6
	call Func_1a_7dee ; $7cb8
	call Func_1a_7df5 ; $7cbb
	push af ; $7cbe
	ld a, [$d0a4] ; $7cbf
	ld l, a ; $7cc2
	ld a, [$d01d] ; $7cc3
	add a, l ; $7cc6
	ld de, $1474 ; $7cc7
	call Func_1a_7e23 ; $7cca
	push de ; $7ccd
	call Func_00_1f51 ; $7cce
	pop de ; $7cd1
	pop af ; $7cd2
	or a, a ; $7cd3
	jr z, Label_1a_7cdf ; $7cd4
	call Func_1a_7e15 ; $7cd6
	call Func_1a_7e38 ; $7cd9
	call Func_00_1f51 ; $7cdc
Label_1a_7cdf:
	ld a, [$d0b0] ; $7cdf
	or a, a ; $7ce2
	jr z, Label_1a_7d0c ; $7ce3
	call Func_1a_7dee ; $7ce5
	call Func_1a_7df5 ; $7ce8
	push af ; $7ceb
	ld a, [$d0a5] ; $7cec
	ld l, a ; $7cef
	ld a, [$d01e] ; $7cf0
	add a, l ; $7cf3
	ld de, $642c ; $7cf4
	call Func_1a_7e23 ; $7cf7
	push de ; $7cfa
	call Func_00_1f51 ; $7cfb
	pop de ; $7cfe
	pop af ; $7cff
	or a, a ; $7d00
	jr z, Label_1a_7d0c ; $7d01
	call Func_1a_7e15 ; $7d03
	call Func_1a_7e38 ; $7d06
	call Func_00_1f51 ; $7d09
Label_1a_7d0c:
	ld a, [$d0b1] ; $7d0c
	or a, a ; $7d0f
	jr z, Label_1a_7d39 ; $7d10
	call Func_1a_7dee ; $7d12
	call Func_1a_7df5 ; $7d15
	push af ; $7d18
	ld a, [$d0a6] ; $7d19
	ld l, a ; $7d1c
	ld a, [$d01f] ; $7d1d
	add a, l ; $7d20
	ld de, $643c ; $7d21
	call Func_1a_7e23 ; $7d24
	push de ; $7d27
	call Func_00_1f51 ; $7d28
	pop de ; $7d2b
	pop af ; $7d2c
	or a, a ; $7d2d
	jr z, Label_1a_7d39 ; $7d2e
	call Func_1a_7e15 ; $7d30
	call Func_1a_7e38 ; $7d33
	call Func_00_1f51 ; $7d36
Label_1a_7d39:
	ld a, [$d0b2] ; $7d39
	or a, a ; $7d3c
	jr z, Label_1a_7d66 ; $7d3d
	call Func_1a_7dee ; $7d3f
	call Func_1a_7df5 ; $7d42
	push af ; $7d45
	ld a, [$d0a7] ; $7d46
	ld l, a ; $7d49
	ld a, [$d020] ; $7d4a
	add a, l ; $7d4d
	ld de, $6454 ; $7d4e
	call Func_1a_7e23 ; $7d51
	push de ; $7d54
	call Func_00_1f51 ; $7d55
	pop de ; $7d58
	pop af ; $7d59
	or a, a ; $7d5a
	jr z, Label_1a_7d66 ; $7d5b
	call Func_1a_7e15 ; $7d5d
	call Func_1a_7e38 ; $7d60
	call Func_00_1f51 ; $7d63
Label_1a_7d66:
	ld a, [$d0b3] ; $7d66
	or a, a ; $7d69
	jr z, Label_1a_7d93 ; $7d6a
	call Func_1a_7dee ; $7d6c
	call Func_1a_7df5 ; $7d6f
	push af ; $7d72
	ld a, [$d0a8] ; $7d73
	ld l, a ; $7d76
	ld a, [$d021] ; $7d77
	add a, l ; $7d7a
	ld de, $6464 ; $7d7b
	call Func_1a_7e23 ; $7d7e
	push de ; $7d81
	call Func_00_1f51 ; $7d82
	pop de ; $7d85
	pop af ; $7d86
	or a, a ; $7d87
	jr z, Label_1a_7d93 ; $7d88
	call Func_1a_7e15 ; $7d8a
	call Func_1a_7e38 ; $7d8d
	call Func_00_1f51 ; $7d90
Label_1a_7d93:
	ld a, [$d0b4] ; $7d93
	or a, a ; $7d96
	jr z, Label_1a_7dc0 ; $7d97
	call Func_1a_7dee ; $7d99
	call Func_1a_7df5 ; $7d9c
	push af ; $7d9f
	ld a, [$d0a9] ; $7da0
	ld l, a ; $7da3
	ld a, [$d022] ; $7da4
	add a, l ; $7da7
	ld de, $6474 ; $7da8
	call Func_1a_7e23 ; $7dab
	push de ; $7dae
	call Func_00_1f51 ; $7daf
	pop de ; $7db2
	pop af ; $7db3
	or a, a ; $7db4
	jr z, Label_1a_7dc0 ; $7db5
	call Func_1a_7e15 ; $7db7
	call Func_1a_7e38 ; $7dba
	call Func_00_1f51 ; $7dbd
Label_1a_7dc0:
	ld a, [$d0b5] ; $7dc0
	or a, a ; $7dc3
	jr z, Label_1a_7ded ; $7dc4
	call Func_1a_7dee ; $7dc6
	call Func_1a_7df5 ; $7dc9
	push af ; $7dcc
	ld a, [$d0aa] ; $7dcd
	ld l, a ; $7dd0
	ld a, [$d023] ; $7dd1
	add a, l ; $7dd4
	ld de, $6484 ; $7dd5
	call Func_1a_7e23 ; $7dd8
	push de ; $7ddb
	call Func_00_1f51 ; $7ddc
	pop de ; $7ddf
	pop af ; $7de0
	or a, a ; $7de1
	jr z, Label_1a_7ded ; $7de2
	call Func_1a_7e15 ; $7de4
	call Func_1a_7e38 ; $7de7
	call Func_00_1f51 ; $7dea
Label_1a_7ded:
	ret ; $7ded
Func_1a_7dee:
	ld b, $0c ; $7dee
	bit 7, a ; $7df0
	ret z ; $7df2
	inc b ; $7df3
	ret ; $7df4
Func_1a_7df5:
	bit 7, a ; $7df5
	jr nz, Label_1a_7e07 ; $7df7
	dec a ; $7df9
	jr z, Label_1a_7e02 ; $7dfa
	dec a ; $7dfc
	ld c, $7e ; $7dfd
	ld h, $02 ; $7dff
	ret ; $7e01
Label_1a_7e02:
	ld c, $7c ; $7e02
	ld h, $02 ; $7e04
	ret ; $7e06
Label_1a_7e07:
	inc a ; $7e07
	jr z, Label_1a_7e10 ; $7e08
	inc a ; $7e0a
	ld c, $7a ; $7e0b
	ld h, $01 ; $7e0d
	ret ; $7e0f
Label_1a_7e10:
	ld c, $78 ; $7e10
	ld h, $01 ; $7e12
	ret ; $7e14
Func_1a_7e15:
	bit 7, a ; $7e15
	jr nz, Label_1a_7e1e ; $7e17
	ld c, $7c ; $7e19
	ld h, $03 ; $7e1b
	ret ; $7e1d
Label_1a_7e1e:
	ld c, $78 ; $7e1e
	ld h, $00 ; $7e20
	ret ; $7e22
Func_1a_7e23:
	inc a ; $7e23
	rlca ; $7e24
	rlca ; $7e25
	add a, d ; $7e26
	ld d, a ; $7e27
	ld a, h ; $7e28
	add a, $34 ; $7e29
	ld l, a ; $7e2b
	adc a, $7e ; $7e2c
	sub a, l ; $7e2e
	ld h, a ; $7e2f
	ld a, [hl] ; $7e30
	add a, d ; $7e31
	ld d, a ; $7e32
	ret ; $7e33
	INCBIN "data/bank_01a/d_7e34.bin" ; $7e34, 4 bytes
Func_1a_7e38:
	bit 7, a ; $7e38
	jr nz, Label_1a_7e41 ; $7e3a
	ld a, $08 ; $7e3c
	add a, d ; $7e3e
	ld d, a ; $7e3f
	ret ; $7e40
Label_1a_7e41:
	ld a, $f8 ; $7e41
	add a, d ; $7e43
	ld d, a ; $7e44
	ret ; $7e45
	INCBIN "data/bank_01a/d_7e46.bin" ; $7e46, 442 bytes

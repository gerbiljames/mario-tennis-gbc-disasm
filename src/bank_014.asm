INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $14", ROMX[$4000], BANK[$14]

	ld [$3940], sp ; $4000
	ld c, d ; $4003
	xor a, h ; $4004
	ld c, a ; $4005
	ld hl, $4a52 ; $4006
	ld b, b ; $4009
	add a, [hl] ; $400a
	ld b, b ; $400b
	ld d, $40 ; $400c
	ld a, [$e640] ; $400e
	ld b, c ; $4011
	rst Rst20 ; $4012
	ld b, c ; $4013
	ld a, b ; $4014
	ld b, d ; $4015
	nop ; $4016
	nop ; $4017
	or a, c ; $4018
	ld a, b ; $4019
	nop ; $401a
	dec hl ; $401b
	nop ; $401c
	inc sp ; $401d
	nop ; $401e
	nop ; $401f
	dec a ; $4020
	ld bc, $0000 ; $4021
	nop ; $4024
	nop ; $4025
	or a, c ; $4026
	ld a, b ; $4027
	nop ; $4028
	dec hl ; $4029
	nop ; $402a
	ld sp, $0000 ; $402b
	dec a ; $402e
	ld bc, $0000 ; $402f
	nop ; $4032
	nop ; $4033
	or a, c ; $4034
	ld a, b ; $4035
	nop ; $4036
	dec l ; $4037
	nop ; $4038
	dec hl ; $4039
	add a, b ; $403a
	nop ; $403b
	ld a, $01 ; $403c
	nop ; $403e
	nop ; $403f
	nop ; $4040
	nop ; $4041
	nop ; $4042
	nop ; $4043
	nop ; $4044
	nop ; $4045
	nop ; $4046
	nop ; $4047
	nop ; $4048
	rst Rst38 ; $4049
	ld bc, $00c0 ; $404a
	dec hl ; $404d
	nop ; $404e
	add hl, sp ; $404f
	ld h, e ; $4050
	ld b, b ; $4051
	dec b ; $4052
	ret nz ; $4053
	nop ; $4054
	jr c, Label_14_4057 ; $4055
Label_14_4057:
	ld [hl], $00 ; $4057
	nop ; $4059
	rlca ; $405a
	ret nz ; $405b
	nop ; $405c
	jr c, Label_14_405f ; $405d
Label_14_405f:
	ld [hl], $00 ; $405f
	nop ; $4061
	rst Rst38 ; $4062
	ld a, [$c295] ; $4063
	cp a, $ff ; $4066
	jp z, Label_14_4085 ; $4068
	rst Rst28 ; $406b
	and a, b ; $406c
	rrca ; $406d
	rst Rst30 ; $406e
	ldh [rTIMA], a ; $406f
	jr z, Label_14_4085 ; $4071
	ld a, $02 ; $4073
	ld bc, $2b00 ; $4075
	ld de, $3b00 ; $4078
	rst Rst18 ; $407b
	ld [hl+], a ; $407c
	ld a, [bc] ; $407d
	ld a, $02 ; $407e
	ld b, $c0 ; $4080
	rst Rst18 ; $4082
	ld l, $0a ; $4083
Label_14_4085:
	ret ; $4085
	INCBIN "data/bank_014/d_4086.bin" ; $4086, 3535 bytes
	ret ; $4e55
	INCBIN "data/bank_014/d_4e56.bin" ; $4e56, 5090 bytes
Func_14_6238:
	ldh a, [$ff96] ; $6238
	push af ; $623a
	ld a, $01 ; $623b
	ldh [$ff96], a ; $623d
	ldh [rWBK], a ; $623f
	ld hl, $5a50 ; $6241
	ld de, $a000 ; $6244
	ld c, $60 ; $6247
	call Func_00_0480 ; $6249
	ld hl, $5e71 ; $624c
	ld de, $0801 ; $624f
	call Func_00_05b0 ; $6252
	pop af ; $6255
	ldh [$ff96], a ; $6256
	ldh [rWBK], a ; $6258
	ret ; $625a
	INCBIN "data/bank_014/d_625b.bin" ; $625b, 5406 bytes
Label_14_7779:
	push af ; $7779
	ld a, $02 ; $777a
	rst Rst18 ; $777c
	inc b ; $777d
	ld a, [bc] ; $777e
	pop af ; $777f
	call Func_14_78a7 ; $7780
	dec h ; $7783
	jr nz, Label_14_7779 ; $7784
	call Func_14_6238 ; $7786
	ld a, $a4 ; $7789
	ld [$c2b0], a ; $778b
	ld a, $c6 ; $778e
	ld [$c2b1], a ; $7790
	ld a, $3c ; $7793
	ld [$c2b2], a ; $7795
	ld a, $01 ; $7798
	ld hl, $625b ; $779a
	call Func_00_1b6a ; $779d
	ld h, $20 ; $77a0
Label_14_77a2:
	push af ; $77a2
	ld a, $02 ; $77a3
	rst Rst18 ; $77a5
	inc b ; $77a6
	ld a, [bc] ; $77a7
	pop af ; $77a8
	call Func_14_78a7 ; $77a9
	ld a, [$c2b0] ; $77ac
	dec a ; $77af
	ld [$c2b0], a ; $77b0
	and a, $03 ; $77b3
	cp a, $03 ; $77b5
	jr nz, Label_14_77c0 ; $77b7
	ld a, [$c2b1] ; $77b9
	dec a ; $77bc
	ld [$c2b1], a ; $77bd
Label_14_77c0:
	call Func_14_7873 ; $77c0
	dec h ; $77c3
	jr nz, Label_14_77a2 ; $77c4
	ld h, $18 ; $77c6
Label_14_77c8:
	push af ; $77c8
	ld a, $02 ; $77c9
	rst Rst18 ; $77cb
	inc b ; $77cc
	ld a, [bc] ; $77cd
	pop af ; $77ce
	call Func_14_78a7 ; $77cf
	ld a, [$c2b0] ; $77d2
	dec a ; $77d5
	ld [$c2b0], a ; $77d6
	and a, $01 ; $77d9
	ld b, a ; $77db
	ld a, [$c2b1] ; $77dc
	sub a, b ; $77df
	ld [$c2b1], a ; $77e0
	call Func_14_7873 ; $77e3
	dec h ; $77e6
	jr nz, Label_14_77c8 ; $77e7
	xor a, a ; $77e9
	ld bc, $0b00 ; $77ea
	ld de, $1200 ; $77ed
	rst Rst18 ; $77f0
	ld a, [hl-] ; $77f1
	ld a, [bc] ; $77f2
	ld h, $18 ; $77f3
Label_14_77f5:
	push af ; $77f5
	ld a, $03 ; $77f6
	rst Rst18 ; $77f8
	inc b ; $77f9
	ld a, [bc] ; $77fa
	pop af ; $77fb
	call Func_14_78a7 ; $77fc
	ld a, [$c2b1] ; $77ff
	dec a ; $7802
	ld [$c2b1], a ; $7803
	ld a, [$c2b0] ; $7806
	dec a ; $7809
	ld [$c2b0], a ; $780a
	call Func_14_7873 ; $780d
	dec h ; $7810
	jr nz, Label_14_77f5 ; $7811
	ld h, $08 ; $7813
Label_14_7815:
	push af ; $7815
	ld a, $04 ; $7816
	rst Rst18 ; $7818
	inc b ; $7819
	ld a, [bc] ; $781a
	pop af ; $781b
	call Func_14_78a7 ; $781c
	ld a, [$c2b1] ; $781f
	dec a ; $7822
	ld [$c2b1], a ; $7823
	and a, $01 ; $7826
	ld b, a ; $7828
	ld a, [$c2b0] ; $7829
	sub a, b ; $782c
	ld [$c2b0], a ; $782d
	call Func_14_7873 ; $7830
	dec h ; $7833
	jr nz, Label_14_7815 ; $7834
	ld h, $0c ; $7836
Label_14_7838:
	push af ; $7838
	ld a, $06 ; $7839
	rst Rst18 ; $783b
	inc b ; $783c
	ld a, [bc] ; $783d
	pop af ; $783e
	call Func_14_78a7 ; $783f
	ld a, [$c2b1] ; $7842
	dec a ; $7845
	ld [$c2b1], a ; $7846
	call Func_14_7873 ; $7849
	dec h ; $784c
	jr nz, Label_14_7838 ; $784d
	rst Rst08 ; $784f
	ld a, l ; $7850
	push af ; $7851
	ld a, $46 ; $7852
	rst Rst18 ; $7854
	inc b ; $7855
	ld a, [bc] ; $7856
	pop af ; $7857
	ld c, $04 ; $7858
	call Func_00_1d20 ; $785a
	call Func_00_1da4 ; $785d
	ld a, $14 ; $7860
	ld [wStoryModeCurrentLocation], a ; $7862
	ld a, $02 ; $7865
	ld [$c295], a ; $7867
	ld a, $ff ; $786a
	ld [$c294], a ; $786c
	ld [$c2a1], a ; $786f
	ret ; $7872
Func_14_7873:
	ld a, [$c2b2] ; $7873
	inc a ; $7876
	ld [$c2b2], a ; $7877
	ret ; $787a
	INCBIN "data/bank_014/d_787b.bin" ; $787b, 44 bytes
Func_14_78a7:
	ld a, h ; $78a7
	srl a ; $78a8
	and a, $01 ; $78aa
	jr z, Label_14_78b0 ; $78ac
	rst Rst08 ; $78ae
	ld a, e ; $78af
Label_14_78b0:
	ret ; $78b0
	INCBIN "data/bank_014/d_78b1.bin" ; $78b1, 1871 bytes

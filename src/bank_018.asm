INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $18", ROMX[$4000], BANK[$18]

	INCBIN "data/bank_018/d_4000.bin" ; $4000, 825 bytes
	push af ; $4339
	push bc ; $433a
	push de ; $433b
	push hl ; $433c
	and a, $0f ; $433d
	add a, a ; $433f
	add a, a ; $4340
	add a, a ; $4341
	add a, $00 ; $4342
	ld l, a ; $4344
	adc a, $43 ; $4345
	sub a, l ; $4347
	ld h, a ; $4348
	ld e, $01 ; $4349
	call Func_00_05b0 ; $434b
	pop hl ; $434e
	pop de ; $434f
	pop bc ; $4350
	pop af ; $4351
	ret ; $4352
	INCBIN "data/bank_018/d_4353.bin" ; $4353, 41 bytes
	push hl ; $437c
	ld hl, $42e0 ; $437d
	call Func_00_05b0 ; $4380
	pop de ; $4383
	ld hl, $42a0 ; $4384
	ld c, $04 ; $4387
	call Func_00_0480 ; $4389
	ret ; $438c
	INCBIN "data/bank_018/d_438d.bin" ; $438d, 270 bytes
	push af ; $449b
	push hl ; $449c
	ldh a, [$ff8c] ; $449d
	and a, $3f ; $449f
	add a, $ae ; $44a1
	ld l, a ; $44a3
	adc a, $44 ; $44a4
	sub a, l ; $44a6
	ld h, a ; $44a7
	ld a, [hl] ; $44a8
	add a, e ; $44a9
	ld e, a ; $44aa
	pop af ; $44ab
	pop hl ; $44ac
	ret ; $44ad
	INCBIN "data/bank_018/d_44ae.bin" ; $44ae, 89 bytes
	cp a, $84 ; $4507
	jr z, Label_18_4522 ; $4509
	push af ; $450b
	push bc ; $450c
	push de ; $450d
	push hl ; $450e
	rst Rst18 ; $450f
	ld a, [de] ; $4510
	ld [bc], a ; $4511
	ld hl, $ca80 ; $4512
	ld de, $d580 ; $4515
	ld c, $08 ; $4518
	call CopyMemoryFast ; $451a
	pop hl ; $451d
	pop de ; $451e
	pop bc ; $451f
	pop af ; $4520
	ret ; $4521
Label_18_4522:
	push af ; $4522
	ld a, $3e ; $4523
	ld [$d58b], a ; $4525
	pop af ; $4528
	ret ; $4529
	bit 7, a ; $452a
	jr z, Label_18_4534 ; $452c
	ld a, [$d58b] ; $452e
	cp a, $ff ; $4531
	ret ; $4533
Label_18_4534:
	cp a, $04 ; $4534
	jr nc, Label_18_453b ; $4536
	cp a, $ff ; $4538
	ret ; $453a
Label_18_453b:
	push hl ; $453b
	push de ; $453c
	ld h, $00 ; $453d
	ld l, a ; $453f
	add hl, hl ; $4540
	add hl, hl ; $4541
	add hl, hl ; $4542
	add hl, hl ; $4543
	add hl, hl ; $4544
	ld d, h ; $4545
	ld e, l ; $4546
	rst Rst18 ; $4547
	inc e ; $4548
	inc bc ; $4549
	pop de ; $454a
	pop hl ; $454b
	ret ; $454c
	INCBIN "data/bank_018/d_454d.bin" ; $454d, 5484 bytes
	ld h, a ; $5ab9
	ld l, $00 ; $5aba
	srl h ; $5abc
	rr l ; $5abe
	srl h ; $5ac0
	rr l ; $5ac2
	ld bc, $5af0 ; $5ac4
	add hl, bc ; $5ac7
	ld c, $04 ; $5ac8
	call Func_00_0480 ; $5aca
	ret ; $5acd
	cp a, $ff ; $5ace
	jr z, Label_18_5ae7 ; $5ad0
	ld h, a ; $5ad2
	ld l, $00 ; $5ad3
	srl h ; $5ad5
	rr l ; $5ad7
	srl h ; $5ad9
	rr l ; $5adb
	ld bc, $62f0 ; $5add
	add hl, bc ; $5ae0
	ld c, $04 ; $5ae1
	call Func_00_0480 ; $5ae3
	ret ; $5ae6
Label_18_5ae7:
	ld hl, $6af0 ; $5ae7
	ld c, $04 ; $5aea
	call Func_00_0480 ; $5aec
	ret ; $5aef
	INCBIN "data/bank_018/d_5af0.bin" ; $5af0, 9488 bytes

INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $42", ROMX[$4000], BANK[$42]

	INCBIN "data/bank_042/d_4000.bin" ; $4000, 32 bytes
FarPtr_42_20:
	dw Func_42_49a0 ; $4020
	INCBIN "data/bank_042/d_4022.bin" ; $4022, 2430 bytes
Func_42_49a0:
	nop ; $49a0
	nop ; $49a1
	nop ; $49a2
	nop ; $49a3
	nop ; $49a4
	nop ; $49a5
	nop ; $49a6
	nop ; $49a7
	nop ; $49a8
	nop ; $49a9
	nop ; $49aa
	nop ; $49ab
	nop ; $49ac
	nop ; $49ad
	nop ; $49ae
	nop ; $49af
	nop ; $49b0
	nop ; $49b1
	nop ; $49b2
	nop ; $49b3
	nop ; $49b4
	nop ; $49b5
	ld bc, $0201 ; $49b6
	inc bc ; $49b9
	inc bc ; $49ba
	inc bc ; $49bb
	ld b, $07 ; $49bc
	ld b, $07 ; $49be
	dec b ; $49c0
	rlca ; $49c1
	ld [bc], a ; $49c2
	inc bc ; $49c3
	ld [bc], a ; $49c4
	inc bc ; $49c5
	ld bc, $0101 ; $49c6
	ld bc, $0203 ; $49c9
	inc bc ; $49cc
	ld [bc], a ; $49cd
	ld bc, $0101 ; $49ce
	ld bc, $0000 ; $49d1
	ld bc, $0301 ; $49d4
	ld [bc], a ; $49d7
	inc bc ; $49d8
	inc bc ; $49d9
	rlca ; $49da
	ld b, $0f ; $49db
	rrca ; $49dd
	rlca ; $49de
	rlca ; $49df
	nop ; $49e0
	nop ; $49e1
	nop ; $49e2
	nop ; $49e3
	nop ; $49e4
	nop ; $49e5
	nop ; $49e6
	nop ; $49e7
	nop ; $49e8
	nop ; $49e9
	nop ; $49ea
	nop ; $49eb
	nop ; $49ec
	nop ; $49ed
	nop ; $49ee
	nop ; $49ef
	ld c, $0e ; $49f0
	ld [hl], h ; $49f2
	ld a, h ; $49f3
	xor a, d ; $49f4
	cp a, $29 ; $49f5
	rst Rst38 ; $49f7
	add a, d ; $49f8
	rst Rst38 ; $49f9
	add hl, de ; $49fa
	rst Rst38 ; $49fb
	cp a, l ; $49fc
	rst20 $ffbd ; $49fd
	cp a, $eb ; $4a00
	cp a, $ab ; $4a02
	ld a, h ; $4a04
	rst Rst00 ; $4a05
	INCBIN "data/bank_042/d_4a06.bin" ; $4a06, 13743 bytes
	ds 75, $ff ; $7fb5, fill

INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $19", ROMX[$4000], BANK[$19]

	INCBIN "data/bank_019/d_4000.bin" ; $4000, 13954 bytes
	rst Rst08 ; $7682
	ld l, h ; $7683
	ld d, a ; $7684
	ld hl, sp - 17 ; $7685
	cp a, a ; $7687
	pop bc ; $7688
	add sp, 100 ; $7689
	INCBIN "data/bank_019/d_768b.bin" ; $768b, 2421 bytes

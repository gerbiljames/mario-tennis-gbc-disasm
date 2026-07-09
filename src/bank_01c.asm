INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1c", ROMX[$4000], BANK[$1c]

	INCBIN "data/bank_01c/d_4000.bin" ; $4000, 8578 bytes
	rst Rst18 ; $6182
	and a, a ; $6183
	rst Rst38 ; $6184
	ld sp, hl ; $6185
	rst Rst10 ; $6186
	ld sp, hl ; $6187
	adc a, e ; $6188
	INCBIN "data/bank_01c/d_6189.bin" ; $6189, 7799 bytes

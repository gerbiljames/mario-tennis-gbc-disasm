INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $65", ROMX[$4000], BANK[$65]

	INCBIN "data/bank_065/d_4000.bin" ; $4000, 8575 bytes
	farcall FarPtr_43_40 ; $617f
	ld e, e ; $6182
	inc b ; $6183
	ld c, d ; $6184
	ld h, c ; $6185
	add a, b ; $6186
	INCBIN "data/bank_065/d_6187.bin" ; $6187, 7801 bytes

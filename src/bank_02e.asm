SECTION "ROM Bank $2e", ROMX[$4000], BANK[$2e]

PerspectiveScaleTable:
	INCBIN "data/bank_02e/d_4000.bin" ; $4000, 16352 bytes
	ds 32, $ff ; $7fe0, fill

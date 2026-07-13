SECTION "ROM Bank $2d", ROMX[$4000], BANK[$2d]

SineTable:
	INCBIN "data/bank_02d/d_4000.bin" ; $4000, 4096 bytes
CosecantTable:
	INCBIN "data/bank_02d/d_5000.bin" ; $5000, 4096 bytes
	ds 8192, $ff ; $6000, fill

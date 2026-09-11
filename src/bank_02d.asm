SECTION "ROM Bank $2d", ROMX[$4000], BANK[$2d]

SineTable:
	INCBIN "data/bank_02d/SineTable.bin" ; $4000, 4096 bytes
CosecantTable:
	INCBIN "data/bank_02d/CosecantTable.bin" ; $5000, 4096 bytes
	; $6000, 8192 bytes fill to bank end (linker-padded)

SineTable:
	ASSERT LOW(SineTable) == 0
	INCBIN "data/bank_02d/SineTable.bin" ; $4000, 4096 bytes
CosecantTable:
	ASSERT LOW(CosecantTable) == 0
	INCBIN "data/bank_02d/CosecantTable.bin" ; $5000, 4096 bytes
	; $6000, 8192 bytes fill to bank end (linker-padded)

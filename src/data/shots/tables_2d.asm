SineTable:
	ASSERT LOW(SineTable) == 0
	INCLUDE "data/shots/SineTable.asm" ; $4000, 4096 bytes (words:8)
CosecantTable:
	ASSERT LOW(CosecantTable) == 0
	INCLUDE "data/shots/CosecantTable.asm" ; $5000, 4096 bytes (words:8)
	; $6000, 8192 bytes fill to bank end (linker-padded)

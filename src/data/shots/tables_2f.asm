ViewRotateSinTable:
	ASSERT LOW(ViewRotateSinTable) == 0
	INCLUDE "data/shots/ViewRotateSinTable.asm" ; $4000, 8192 bytes (words:8)
ViewRotateCosTable:
	ASSERT LOW(ViewRotateCosTable) == 0
	INCLUDE "data/shots/ViewRotateCosTable.asm" ; $6000, 8192 bytes (words:8)

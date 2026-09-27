PerspectiveScaleTable:
	ASSERT PerspectiveScaleTable == $4000
	INCBIN "data/bank_02e/PerspectiveScaleTable.bin" ; $4000, 16352 bytes
	; $7fe0, 32 bytes fill to bank end (linker-padded)

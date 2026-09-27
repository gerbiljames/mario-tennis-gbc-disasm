ViewScaleTableA:
	ASSERT LOW(ViewScaleTableA) == 0
	INCBIN "data/bank_02f/ViewScaleTableA.bin" ; $4000, 8192 bytes
ViewScaleTableB:
	ASSERT LOW(ViewScaleTableB) == 0
	INCBIN "data/bank_02f/ViewScaleTableB.bin" ; $6000, 8192 bytes

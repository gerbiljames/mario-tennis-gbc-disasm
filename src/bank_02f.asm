SECTION "ROM Bank $2f", ROMX[$4000], BANK[$2f]

ViewScaleTableA:
	INCBIN "data/bank_02f/ViewScaleTableA.bin" ; $4000, 8192 bytes
ViewScaleTableB:
	INCBIN "data/bank_02f/ViewScaleTableB.bin" ; $6000, 8192 bytes

INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6f", ROMX[$4000], BANK[$6f]

WalkSprites_6f:
	dw Data_6f_4010 ; $4000
	dw Data_6f_46a1 ; $4002
	dw Data_6f_4d31 ; $4004
	dw Data_6f_53c1 ; $4006
	dw Data_6f_5a51 ; $4008
	dw Data_6f_60e1 ; $400a
	dw Data_6f_6771 ; $400c
	dw Data_6f_6e01 ; $400e
Data_6f_4010:
	INCBIN "data/bank_06f/d_4010.bin" ; $4010, 16 bytes
	INCBIN "data/bank_06f/d_4020.bin" ; $4020, 1665 bytes
Data_6f_46a1:
	INCBIN "data/bank_06f/d_46a1.bin" ; $46a1, 16 bytes
	INCBIN "data/bank_06f/d_46b1.bin" ; $46b1, 1664 bytes
Data_6f_4d31:
	INCBIN "data/bank_06f/d_4d31.bin" ; $4d31, 16 bytes
	INCBIN "data/bank_06f/d_4d41.bin" ; $4d41, 1664 bytes
Data_6f_53c1:
	INCBIN "data/bank_06f/d_53c1.bin" ; $53c1, 16 bytes
	INCBIN "data/bank_06f/d_53d1.bin" ; $53d1, 1664 bytes
Data_6f_5a51:
	INCBIN "data/bank_06f/d_5a51.bin" ; $5a51, 16 bytes
	INCBIN "data/bank_06f/d_5a61.bin" ; $5a61, 1664 bytes
Data_6f_60e1:
	INCBIN "data/bank_06f/d_60e1.bin" ; $60e1, 16 bytes
	INCBIN "data/bank_06f/d_60f1.bin" ; $60f1, 1664 bytes
Data_6f_6771:
	INCBIN "data/bank_06f/d_6771.bin" ; $6771, 16 bytes
	INCBIN "data/bank_06f/d_6781.bin" ; $6781, 1664 bytes
Data_6f_6e01:
	INCBIN "data/bank_06f/d_6e01.bin" ; $6e01, 16 bytes
	INCBIN "data/bank_06f/d_6e11.bin" ; $6e11, 1664 bytes
	ds 2927, $ff ; $7491, fill

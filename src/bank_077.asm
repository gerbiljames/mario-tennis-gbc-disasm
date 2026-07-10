INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $77", ROMX[$4000], BANK[$77]

WalkSprites_77:
	dw Data_77_4010 ; $4000
	dw Data_77_4895 ; $4002
	dw Data_77_5115 ; $4004
	dw Data_77_5995 ; $4006
	dw Data_77_6031 ; $4008
	dw Data_77_66c1 ; $400a
	dw Data_77_6d51 ; $400c
	dw Data_77_73e1 ; $400e
Data_77_4010:
	INCBIN "data/bank_077/d_4010.bin" ; $4010, 2181 bytes
Data_77_4895:
	INCBIN "data/bank_077/d_4895.bin" ; $4895, 2176 bytes
Data_77_5115:
	INCBIN "data/bank_077/d_5115.bin" ; $5115, 2176 bytes
Data_77_5995:
	INCBIN "data/bank_077/d_5995.bin" ; $5995, 1692 bytes
Data_77_6031:
	INCBIN "data/bank_077/d_6031.bin" ; $6031, 1680 bytes
Data_77_66c1:
	INCBIN "data/bank_077/d_66c1.bin" ; $66c1, 1680 bytes
Data_77_6d51:
	INCBIN "data/bank_077/d_6d51.bin" ; $6d51, 1680 bytes
Data_77_73e1:
	INCBIN "data/bank_077/d_73e1.bin" ; $73e1, 473 bytes
	ds 2630, $ff ; $75ba, fill

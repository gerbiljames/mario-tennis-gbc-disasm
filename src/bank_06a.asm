INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6a", ROMX[$4000], BANK[$6a]

WalkSprites_6a:
	dw Data_6a_400a ; $4000
	dw Data_6a_46a1 ; $4002
	dw Data_6a_4d31 ; $4004
	dw Data_6a_53c1 ; $4006
	dw Data_6a_5a51 ; $4008
Data_6a_400a:
	INCBIN "data/bank_06a/d_400a.bin" ; $400a, 16 bytes
	INCBIN "data/bank_06a/d_401a.bin" ; $401a, 1671 bytes
Data_6a_46a1:
	INCBIN "data/bank_06a/d_46a1.bin" ; $46a1, 16 bytes
	INCBIN "data/bank_06a/d_46b1.bin" ; $46b1, 1664 bytes
Data_6a_4d31:
	INCBIN "data/bank_06a/d_4d31.bin" ; $4d31, 16 bytes
	INCBIN "data/bank_06a/d_4d41.bin" ; $4d41, 1664 bytes
Data_6a_53c1:
	INCBIN "data/bank_06a/d_53c1.bin" ; $53c1, 16 bytes
	INCBIN "data/bank_06a/d_53d1.bin" ; $53d1, 1664 bytes
Data_6a_5a51:
	INCBIN "data/bank_06a/d_5a51.bin" ; $5a51, 16 bytes
	INCBIN "data/bank_06a/d_5a61.bin" ; $5a61, 1664 bytes
	ds 7967, $ff ; $60e1, fill

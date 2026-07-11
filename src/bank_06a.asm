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
	db $05, $04, $02, $00 ; count, flags
	dw $4014, $4630, $4014, $4030, $4130, $4230 ; body pointers
	INCBIN "data/bank_06a/d_401a.bin" ; $401a, 1671 bytes
Data_6a_46a1:
	db $05, $04, $02, $00 ; count, flags
	dw $46ab, $4cc0, $46ab, $46c0, $47c0, $48c0 ; body pointers
	INCBIN "data/bank_06a/d_46b1.bin" ; $46b1, 1664 bytes
Data_6a_4d31:
	db $07, $04, $02, $00 ; count, flags
	dw $4d3b, $5350, $4d3b, $4d50, $4e50, $4f50 ; body pointers
	INCBIN "data/bank_06a/d_4d41.bin" ; $4d41, 1664 bytes
Data_6a_53c1:
	db $06, $04, $02, $00 ; count, flags
	dw $53cb, $59e0, $53cb, $53e0, $54e0, $55e0 ; body pointers
	INCBIN "data/bank_06a/d_53d1.bin" ; $53d1, 1664 bytes
Data_6a_5a51:
	db $03, $04, $02, $00 ; count, flags
	dw $5a5b, $6070, $5a5b, $5a70, $5b70, $5c70 ; body pointers
	INCBIN "data/bank_06a/d_5a61.bin" ; $5a61, 1664 bytes
	ds 7967, $ff ; $60e1, fill

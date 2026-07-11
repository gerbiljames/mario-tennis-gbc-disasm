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
	db $07, $04, $02, $00 ; count, flags
	dw $401a, $4630, $401a, $4030, $4130, $4230 ; body pointers
	INCBIN "data/bank_06f/d_4020.bin" ; $4020, 1665 bytes
Data_6f_46a1:
	db $05, $04, $02, $00 ; count, flags
	dw $46ab, $4cc0, $46ab, $46c0, $47c0, $48c0 ; body pointers
	INCBIN "data/bank_06f/d_46b1.bin" ; $46b1, 1664 bytes
Data_6f_4d31:
	db $05, $04, $02, $00 ; count, flags
	dw $4d3b, $5350, $4d3b, $4d50, $4e50, $4f50 ; body pointers
	INCBIN "data/bank_06f/d_4d41.bin" ; $4d41, 1664 bytes
Data_6f_53c1:
	db $05, $04, $02, $00 ; count, flags
	dw $53cb, $59e0, $53cb, $53e0, $54e0, $55e0 ; body pointers
	INCBIN "data/bank_06f/d_53d1.bin" ; $53d1, 1664 bytes
Data_6f_5a51:
	db $05, $04, $02, $00 ; count, flags
	dw $5a5b, $6070, $5a5b, $5a70, $5b70, $5c70 ; body pointers
	INCBIN "data/bank_06f/d_5a61.bin" ; $5a61, 1664 bytes
Data_6f_60e1:
	db $07, $04, $02, $00 ; count, flags
	dw $60eb, $6700, $60eb, $6100, $6200, $6300 ; body pointers
	INCBIN "data/bank_06f/d_60f1.bin" ; $60f1, 1664 bytes
Data_6f_6771:
	db $06, $04, $02, $00 ; count, flags
	dw $677b, $6d90, $677b, $6790, $6890, $6990 ; body pointers
	INCBIN "data/bank_06f/d_6781.bin" ; $6781, 1664 bytes
Data_6f_6e01:
	db $03, $04, $02, $00 ; count, flags
	dw $6e0b, $7420, $6e0b, $6e20, $6f20, $7020 ; body pointers
	INCBIN "data/bank_06f/d_6e11.bin" ; $6e11, 1664 bytes
	ds 2927, $ff ; $7491, fill

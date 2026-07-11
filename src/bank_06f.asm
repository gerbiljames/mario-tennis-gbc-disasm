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
	dw $401a, Data_6f_4630, $401a, Data_6f_4030, Data_6f_4130, Data_6f_4230 ; body pointers
	INCBIN "data/bank_06f/d_4020.bin" ; $4020, 16 bytes
Data_6f_4030:
	INCBIN "data/bank_06f/d_4030.bin" ; $4030, 256 bytes
Data_6f_4130:
	INCBIN "data/bank_06f/d_4130.bin" ; $4130, 256 bytes
Data_6f_4230:
	INCBIN "data/bank_06f/d_4230.bin" ; $4230, 1024 bytes
Data_6f_4630:
	INCBIN "data/bank_06f/d_4630.bin" ; $4630, 113 bytes
Data_6f_46a1:
	db $05, $04, $02, $00 ; count, flags
	dw $46ab, Data_6f_4cc0, $46ab, Data_6f_46c0, Data_6f_47c0, Data_6f_48c0 ; body pointers
	INCBIN "data/bank_06f/d_46b1.bin" ; $46b1, 15 bytes
Data_6f_46c0:
	INCBIN "data/bank_06f/d_46c0.bin" ; $46c0, 256 bytes
Data_6f_47c0:
	INCBIN "data/bank_06f/d_47c0.bin" ; $47c0, 256 bytes
Data_6f_48c0:
	INCBIN "data/bank_06f/d_48c0.bin" ; $48c0, 1024 bytes
Data_6f_4cc0:
	INCBIN "data/bank_06f/d_4cc0.bin" ; $4cc0, 113 bytes
Data_6f_4d31:
	db $05, $04, $02, $00 ; count, flags
	dw $4d3b, Data_6f_5350, $4d3b, Data_6f_4d50, Data_6f_4e50, Data_6f_4f50 ; body pointers
	INCBIN "data/bank_06f/d_4d41.bin" ; $4d41, 15 bytes
Data_6f_4d50:
	INCBIN "data/bank_06f/d_4d50.bin" ; $4d50, 256 bytes
Data_6f_4e50:
	INCBIN "data/bank_06f/d_4e50.bin" ; $4e50, 256 bytes
Data_6f_4f50:
	INCBIN "data/bank_06f/d_4f50.bin" ; $4f50, 1024 bytes
Data_6f_5350:
	INCBIN "data/bank_06f/d_5350.bin" ; $5350, 113 bytes
Data_6f_53c1:
	db $05, $04, $02, $00 ; count, flags
	dw $53cb, Data_6f_59e0, $53cb, Data_6f_53e0, Data_6f_54e0, Data_6f_55e0 ; body pointers
	INCBIN "data/bank_06f/d_53d1.bin" ; $53d1, 15 bytes
Data_6f_53e0:
	INCBIN "data/bank_06f/d_53e0.bin" ; $53e0, 256 bytes
Data_6f_54e0:
	INCBIN "data/bank_06f/d_54e0.bin" ; $54e0, 256 bytes
Data_6f_55e0:
	INCBIN "data/bank_06f/d_55e0.bin" ; $55e0, 1024 bytes
Data_6f_59e0:
	INCBIN "data/bank_06f/d_59e0.bin" ; $59e0, 113 bytes
Data_6f_5a51:
	db $05, $04, $02, $00 ; count, flags
	dw $5a5b, Data_6f_6070, $5a5b, Data_6f_5a70, Data_6f_5b70, Data_6f_5c70 ; body pointers
	INCBIN "data/bank_06f/d_5a61.bin" ; $5a61, 15 bytes
Data_6f_5a70:
	INCBIN "data/bank_06f/d_5a70.bin" ; $5a70, 256 bytes
Data_6f_5b70:
	INCBIN "data/bank_06f/d_5b70.bin" ; $5b70, 256 bytes
Data_6f_5c70:
	INCBIN "data/bank_06f/d_5c70.bin" ; $5c70, 1024 bytes
Data_6f_6070:
	INCBIN "data/bank_06f/d_6070.bin" ; $6070, 113 bytes
Data_6f_60e1:
	db $07, $04, $02, $00 ; count, flags
	dw $60eb, Data_6f_6700, $60eb, Data_6f_6100, Data_6f_6200, Data_6f_6300 ; body pointers
	INCBIN "data/bank_06f/d_60f1.bin" ; $60f1, 15 bytes
Data_6f_6100:
	INCBIN "data/bank_06f/d_6100.bin" ; $6100, 256 bytes
Data_6f_6200:
	INCBIN "data/bank_06f/d_6200.bin" ; $6200, 256 bytes
Data_6f_6300:
	INCBIN "data/bank_06f/d_6300.bin" ; $6300, 1024 bytes
Data_6f_6700:
	INCBIN "data/bank_06f/d_6700.bin" ; $6700, 113 bytes
Data_6f_6771:
	db $06, $04, $02, $00 ; count, flags
	dw $677b, Data_6f_6d90, $677b, Data_6f_6790, Data_6f_6890, Data_6f_6990 ; body pointers
	INCBIN "data/bank_06f/d_6781.bin" ; $6781, 15 bytes
Data_6f_6790:
	INCBIN "data/bank_06f/d_6790.bin" ; $6790, 256 bytes
Data_6f_6890:
	INCBIN "data/bank_06f/d_6890.bin" ; $6890, 256 bytes
Data_6f_6990:
	INCBIN "data/bank_06f/d_6990.bin" ; $6990, 1024 bytes
Data_6f_6d90:
	INCBIN "data/bank_06f/d_6d90.bin" ; $6d90, 113 bytes
Data_6f_6e01:
	db $03, $04, $02, $00 ; count, flags
	dw $6e0b, Data_6f_7420, $6e0b, Data_6f_6e20, Data_6f_6f20, Data_6f_7020 ; body pointers
	INCBIN "data/bank_06f/d_6e11.bin" ; $6e11, 15 bytes
Data_6f_6e20:
	INCBIN "data/bank_06f/d_6e20.bin" ; $6e20, 256 bytes
Data_6f_6f20:
	INCBIN "data/bank_06f/d_6f20.bin" ; $6f20, 256 bytes
Data_6f_7020:
	INCBIN "data/bank_06f/d_7020.bin" ; $7020, 1024 bytes
Data_6f_7420:
	INCBIN "data/bank_06f/d_7420.bin" ; $7420, 113 bytes
	ds 2927, $ff ; $7491, fill

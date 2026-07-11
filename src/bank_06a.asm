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
	dw $4014, Data_6a_4630, $4014, Data_6a_4030, Data_6a_4130, Data_6a_4230 ; body pointers
	INCBIN "data/bank_06a/d_401a.bin" ; $401a, 22 bytes
Data_6a_4030:
	INCBIN "data/bank_06a/d_4030.bin" ; $4030, 256 bytes
Data_6a_4130:
	INCBIN "data/bank_06a/d_4130.bin" ; $4130, 256 bytes
Data_6a_4230:
	INCBIN "data/bank_06a/d_4230.bin" ; $4230, 1024 bytes
Data_6a_4630:
	INCBIN "data/bank_06a/d_4630.bin" ; $4630, 113 bytes
Data_6a_46a1:
	db $05, $04, $02, $00 ; count, flags
	dw $46ab, Data_6a_4cc0, $46ab, Data_6a_46c0, Data_6a_47c0, Data_6a_48c0 ; body pointers
	INCBIN "data/bank_06a/d_46b1.bin" ; $46b1, 15 bytes
Data_6a_46c0:
	INCBIN "data/bank_06a/d_46c0.bin" ; $46c0, 256 bytes
Data_6a_47c0:
	INCBIN "data/bank_06a/d_47c0.bin" ; $47c0, 256 bytes
Data_6a_48c0:
	INCBIN "data/bank_06a/d_48c0.bin" ; $48c0, 1024 bytes
Data_6a_4cc0:
	INCBIN "data/bank_06a/d_4cc0.bin" ; $4cc0, 113 bytes
Data_6a_4d31:
	db $07, $04, $02, $00 ; count, flags
	dw $4d3b, Data_6a_5350, $4d3b, Data_6a_4d50, Data_6a_4e50, Data_6a_4f50 ; body pointers
	INCBIN "data/bank_06a/d_4d41.bin" ; $4d41, 15 bytes
Data_6a_4d50:
	INCBIN "data/bank_06a/d_4d50.bin" ; $4d50, 256 bytes
Data_6a_4e50:
	INCBIN "data/bank_06a/d_4e50.bin" ; $4e50, 256 bytes
Data_6a_4f50:
	INCBIN "data/bank_06a/d_4f50.bin" ; $4f50, 1024 bytes
Data_6a_5350:
	INCBIN "data/bank_06a/d_5350.bin" ; $5350, 113 bytes
Data_6a_53c1:
	db $06, $04, $02, $00 ; count, flags
	dw $53cb, Data_6a_59e0, $53cb, Data_6a_53e0, Data_6a_54e0, Data_6a_55e0 ; body pointers
	INCBIN "data/bank_06a/d_53d1.bin" ; $53d1, 15 bytes
Data_6a_53e0:
	INCBIN "data/bank_06a/d_53e0.bin" ; $53e0, 256 bytes
Data_6a_54e0:
	INCBIN "data/bank_06a/d_54e0.bin" ; $54e0, 256 bytes
Data_6a_55e0:
	INCBIN "data/bank_06a/d_55e0.bin" ; $55e0, 1024 bytes
Data_6a_59e0:
	INCBIN "data/bank_06a/d_59e0.bin" ; $59e0, 113 bytes
Data_6a_5a51:
	db $03, $04, $02, $00 ; count, flags
	dw $5a5b, Data_6a_6070, $5a5b, Data_6a_5a70, Data_6a_5b70, Data_6a_5c70 ; body pointers
	INCBIN "data/bank_06a/d_5a61.bin" ; $5a61, 15 bytes
Data_6a_5a70:
	INCBIN "data/bank_06a/d_5a70.bin" ; $5a70, 256 bytes
Data_6a_5b70:
	INCBIN "data/bank_06a/d_5b70.bin" ; $5b70, 256 bytes
Data_6a_5c70:
	INCBIN "data/bank_06a/d_5c70.bin" ; $5c70, 1024 bytes
Data_6a_6070:
	INCBIN "data/bank_06a/d_6070.bin" ; $6070, 113 bytes
	ds 7967, $ff ; $60e1, fill

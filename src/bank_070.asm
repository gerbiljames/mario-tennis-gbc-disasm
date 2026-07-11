INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $70", ROMX[$4000], BANK[$70]

DataPtr_70_00:
	dw Data_70_400e ; $4000
DataPtr_70_02:
	dw Data_70_4cb1 ; $4002
DataPtr_70_04:
	dw Data_70_5951 ; $4004
DataPtr_70_06:
	dw Data_70_61d5 ; $4006
DataPtr_70_08:
	dw Data_70_6a55 ; $4008
DataPtr_70_0a:
	dw Data_70_70cd ; $400a
DataPtr_70_0c:
	dw Data_70_773d ; $400c
Data_70_400e:
	db $06, $04, $02, $00 ; count, flags
	dw $4018, Data_70_4c40, $4018, Data_70_4040, Data_70_4140, Data_70_4240 ; body pointers
	INCBIN "data/bank_070/d_401e.bin" ; $401e, 34 bytes
Data_70_4040:
	INCBIN "data/bank_070/d_4040.bin" ; $4040, 256 bytes
Data_70_4140:
	INCBIN "data/bank_070/d_4140.bin" ; $4140, 256 bytes
Data_70_4240:
	INCBIN "data/bank_070/d_4240.bin" ; $4240, 2560 bytes
Data_70_4c40:
	INCBIN "data/bank_070/d_4c40.bin" ; $4c40, 113 bytes
Data_70_4cb1:
	db $05, $04, $02, $00 ; count, flags
	dw $4cbb, Data_70_58e0, $4cbb, Data_70_4ce0, Data_70_4de0, Data_70_4ee0 ; body pointers
	INCBIN "data/bank_070/d_4cc1.bin" ; $4cc1, 31 bytes
Data_70_4ce0:
	INCBIN "data/bank_070/d_4ce0.bin" ; $4ce0, 256 bytes
Data_70_4de0:
	INCBIN "data/bank_070/d_4de0.bin" ; $4de0, 256 bytes
Data_70_4ee0:
	INCBIN "data/bank_070/d_4ee0.bin" ; $4ee0, 2560 bytes
Data_70_58e0:
	INCBIN "data/bank_070/d_58e0.bin" ; $58e0, 113 bytes
Data_70_5951:
	db $05, $04, $02, $00 ; count, flags
	dw $595b, Data_70_6180, $595b, Data_70_5980, Data_70_5a80, Data_70_5b80 ; body pointers
	INCBIN "data/bank_070/d_5961.bin" ; $5961, 31 bytes
Data_70_5980:
	INCBIN "data/bank_070/d_5980.bin" ; $5980, 256 bytes
Data_70_5a80:
	INCBIN "data/bank_070/d_5a80.bin" ; $5a80, 256 bytes
Data_70_5b80:
	INCBIN "data/bank_070/d_5b80.bin" ; $5b80, 1536 bytes
Data_70_6180:
	INCBIN "data/bank_070/d_6180.bin" ; $6180, 85 bytes
Data_70_61d5:
	db $04, $04, $02, $00 ; count, flags
	dw $61df, Data_70_6a00, $61df, Data_70_6200, Data_70_6300, Data_70_6400 ; body pointers
	INCBIN "data/bank_070/d_61e5.bin" ; $61e5, 27 bytes
Data_70_6200:
	INCBIN "data/bank_070/d_6200.bin" ; $6200, 256 bytes
Data_70_6300:
	INCBIN "data/bank_070/d_6300.bin" ; $6300, 256 bytes
Data_70_6400:
	INCBIN "data/bank_070/d_6400.bin" ; $6400, 1536 bytes
Data_70_6a00:
	INCBIN "data/bank_070/d_6a00.bin" ; $6a00, 85 bytes
Data_70_6a55:
	db $06, $04, $02, $00 ; count, flags
	dw $6a5f, Data_70_7080, $6a5f, Data_70_6a80, Data_70_6b80, Data_70_6c80 ; body pointers
	INCBIN "data/bank_070/d_6a65.bin" ; $6a65, 27 bytes
Data_70_6a80:
	INCBIN "data/bank_070/d_6a80.bin" ; $6a80, 256 bytes
Data_70_6b80:
	INCBIN "data/bank_070/d_6b80.bin" ; $6b80, 256 bytes
Data_70_6c80:
	INCBIN "data/bank_070/d_6c80.bin" ; $6c80, 1024 bytes
Data_70_7080:
	INCBIN "data/bank_070/d_7080.bin" ; $7080, 77 bytes
Data_70_70cd:
	db $07, $04, $02, $00 ; count, flags
	dw $70d7, Data_70_76f0, $70d7, Data_70_70f0, Data_70_71f0, Data_70_72f0 ; body pointers
	INCBIN "data/bank_070/d_70dd.bin" ; $70dd, 19 bytes
Data_70_70f0:
	INCBIN "data/bank_070/d_70f0.bin" ; $70f0, 256 bytes
Data_70_71f0:
	INCBIN "data/bank_070/d_71f0.bin" ; $71f0, 256 bytes
Data_70_72f0:
	INCBIN "data/bank_070/d_72f0.bin" ; $72f0, 1024 bytes
Data_70_76f0:
	INCBIN "data/bank_070/d_76f0.bin" ; $76f0, 77 bytes
Data_70_773d:
	db $03, $04, $02, $00 ; count, flags
	dw $7747, Data_70_7d60, $7747, Data_70_7760, Data_70_7860, Data_70_7960 ; body pointers
	INCBIN "data/bank_070/d_774d.bin" ; $774d, 19 bytes
Data_70_7760:
	INCBIN "data/bank_070/d_7760.bin" ; $7760, 256 bytes
Data_70_7860:
	INCBIN "data/bank_070/d_7860.bin" ; $7860, 256 bytes
Data_70_7960:
	INCBIN "data/bank_070/d_7960.bin" ; $7960, 1024 bytes
Data_70_7d60:
	INCBIN "data/bank_070/d_7d60.bin" ; $7d60, 77 bytes
	ds 595, $ff ; $7dad, fill

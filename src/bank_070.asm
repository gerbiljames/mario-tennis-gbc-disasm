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
	dw $4018, $4c40, $4018, $4040, $4140, $4240 ; body pointers
	INCBIN "data/bank_070/d_401e.bin" ; $401e, 3219 bytes
Data_70_4cb1:
	db $05, $04, $02, $00 ; count, flags
	dw $4cbb, $58e0, $4cbb, $4ce0, $4de0, $4ee0 ; body pointers
	INCBIN "data/bank_070/d_4cc1.bin" ; $4cc1, 3216 bytes
Data_70_5951:
	db $05, $04, $02, $00 ; count, flags
	dw $595b, $6180, $595b, $5980, $5a80, $5b80 ; body pointers
	INCBIN "data/bank_070/d_5961.bin" ; $5961, 2164 bytes
Data_70_61d5:
	db $04, $04, $02, $00 ; count, flags
	dw $61df, $6a00, $61df, $6200, $6300, $6400 ; body pointers
	INCBIN "data/bank_070/d_61e5.bin" ; $61e5, 2160 bytes
Data_70_6a55:
	db $06, $04, $02, $00 ; count, flags
	dw $6a5f, $7080, $6a5f, $6a80, $6b80, $6c80 ; body pointers
	INCBIN "data/bank_070/d_6a65.bin" ; $6a65, 1640 bytes
Data_70_70cd:
	db $07, $04, $02, $00 ; count, flags
	dw $70d7, $76f0, $70d7, $70f0, $71f0, $72f0 ; body pointers
	INCBIN "data/bank_070/d_70dd.bin" ; $70dd, 1632 bytes
Data_70_773d:
	db $03, $04, $02, $00 ; count, flags
	dw $7747, $7d60, $7747, $7760, $7860, $7960 ; body pointers
	INCBIN "data/bank_070/d_774d.bin" ; $774d, 1632 bytes
	ds 595, $ff ; $7dad, fill

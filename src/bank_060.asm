INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $60", ROMX[$4000], BANK[$60]

	adc a, c ; $4000
	ld d, b ; $4001
	ld b, b ; $4002
	ld b, b ; $4003
	ld hl, $7d4d ; $4004
	ld c, a ; $4007
	adc a, c ; $4008
	ld d, b ; $4009
	or a, c ; $400a
	ld d, b ; $400b
	reti ; $400c
	INCBIN "data/bank_060/d_400d.bin" ; $400d, 1 bytes
DataPtr_60_0e:
	dw Lz_60_4080 ; $400e
DataPtr_60_10:
	dw Data_60_5d61 ; $4010
DataPtr_60_12:
	dw Data_60_50d9 ; $4012
DataPtr_60_14:
	dw Lz_60_5a49 ; $4014
DataPtr_60_16:
	dw Lz_60_5cc6 ; $4016
DataPtr_60_18:
	dw Data_60_5d61 ; $4018
	INCBIN "data/bank_060/d_401a.bin" ; $401a, 4 bytes
DataPtr_60_1e:
	dw Lz_60_5119 ; $401e
DataPtr_60_20:
	dw Data_60_6c8e ; $4020
	INCBIN "data/bank_060/d_4022.bin" ; $4022, 2 bytes
DataPtr_60_24:
	dw Lz_60_69a2 ; $4024
DataPtr_60_26:
	dw Lz_60_6be8 ; $4026
DataPtr_60_28:
	dw Data_60_6c8e ; $4028
	INCBIN "data/bank_060/d_402a.bin" ; $402a, 4 bytes
DataPtr_60_2e:
	dw Lz_60_5df1 ; $402e
DataPtr_60_30:
	dw Data_60_7bad ; $4030
	INCBIN "data/bank_060/d_4032.bin" ; $4032, 2 bytes
DataPtr_60_34:
	dw Lz_60_78d0 ; $4034
DataPtr_60_36:
	dw Lz_60_7b0d ; $4036
DataPtr_60_38:
	dw Data_60_7bad ; $4038
	INCBIN "data/bank_060/d_403a.bin" ; $403a, 4 bytes
DataPtr_60_3e:
	dw Lz_60_6d1e ; $403e
	INCBIN "data/bank_060/d_4040.bin" ; $4040, 64 bytes
Lz_60_4080:
	INCBIN "data/bank_060/lz_4080.bin" ; $4080, 3233 bytes
	INCBIN "data/bank_060/d_4d21.bin" ; $4d21, 952 bytes
Data_60_50d9:
	INCBIN "data/bank_060/d_50d9.bin" ; $50d9, 64 bytes
Lz_60_5119:
	INCBIN "data/bank_060/lz_5119.bin" ; $5119, 2352 bytes
Lz_60_5a49:
	INCBIN "data/bank_060/lz_5a49.bin" ; $5a49, 637 bytes
Lz_60_5cc6:
	INCBIN "data/bank_060/lz_5cc6.bin" ; $5cc6, 155 bytes
Data_60_5d61:
	INCBIN "data/bank_060/d_5d61.bin" ; $5d61, 144 bytes
Lz_60_5df1:
	INCBIN "data/bank_060/lz_5df1.bin" ; $5df1, 2993 bytes
Lz_60_69a2:
	INCBIN "data/bank_060/lz_69a2.bin" ; $69a2, 582 bytes
Lz_60_6be8:
	INCBIN "data/bank_060/lz_6be8.bin" ; $6be8, 166 bytes
Data_60_6c8e:
	INCBIN "data/bank_060/d_6c8e.bin" ; $6c8e, 144 bytes
Lz_60_6d1e:
	INCBIN "data/bank_060/lz_6d1e.bin" ; $6d1e, 2994 bytes
Lz_60_78d0:
	INCBIN "data/bank_060/lz_78d0.bin" ; $78d0, 573 bytes
Lz_60_7b0d:
	INCBIN "data/bank_060/lz_7b0d.bin" ; $7b0d, 160 bytes
Data_60_7bad:
	INCBIN "data/bank_060/d_7bad.bin" ; $7bad, 1107 bytes

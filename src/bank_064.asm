INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $64", ROMX[$4000], BANK[$64]

DataPtr_64_00:
	dw Data_64_4030 ; $4000
DataPtr_64_02:
	dw Data_64_405a ; $4002
DataPtr_64_04:
	dw Lz_64_499d ; $4004
DataPtr_64_06:
	dw Lz_64_4c5f ; $4006
DataPtr_64_08:
	dw Lz_64_4e5e ; $4008
DataPtr_64_0a:
	dw Lz_64_4ed4 ; $400a
DataPtr_64_0c:
	dw Data_64_4f1c ; $400c
DataPtr_64_0e:
	dw Lz_64_409a ; $400e
DataPtr_64_10:
	dw Data_64_4f1c ; $4010
DataPtr_64_12:
	dw Data_64_4f46 ; $4012
DataPtr_64_14:
	dw Lz_64_5c2c ; $4014
DataPtr_64_16:
	dw Lz_64_5f4e ; $4016
DataPtr_64_18:
	dw Lz_64_60e9 ; $4018
DataPtr_64_1a:
	dw Lz_64_6139 ; $401a
DataPtr_64_1c:
	dw Data_64_6193 ; $401c
DataPtr_64_1e:
	dw Lz_64_4f86 ; $401e
DataPtr_64_20:
	dw Data_64_6193 ; $4020
DataPtr_64_22:
	dw Data_64_61ae ; $4022
DataPtr_64_24:
	dw Lz_64_6e0a ; $4024
DataPtr_64_26:
	dw Lz_64_739f ; $4026
DataPtr_64_28:
	dw Lz_64_7646 ; $4028
DataPtr_64_2a:
	dw Lz_64_76d9 ; $402a
DataPtr_64_2c:
	dw Data_64_7730 ; $402c
DataPtr_64_2e:
	dw Lz_64_61ee ; $402e
Data_64_4030:
	INCBIN "data/bank_064/d_4030.bin" ; $4030, 42 bytes
Data_64_405a:
	INCBIN "data/bank_064/d_405a.bin" ; $405a, 64 bytes
Lz_64_409a:
	INCBIN "data/bank_064/lz_409a.bin" ; $409a, 2307 bytes
Lz_64_499d:
	INCBIN "data/bank_064/lz_499d.bin" ; $499d, 706 bytes
Lz_64_4c5f:
	INCBIN "data/bank_064/lz_4c5f.bin" ; $4c5f, 511 bytes
Lz_64_4e5e:
	INCBIN "data/bank_064/lz_4e5e.bin" ; $4e5e, 118 bytes
Lz_64_4ed4:
	INCBIN "data/bank_064/lz_4ed4.bin" ; $4ed4, 72 bytes
Data_64_4f1c:
	INCBIN "data/bank_064/d_4f1c.bin" ; $4f1c, 42 bytes
Data_64_4f46:
	INCBIN "data/bank_064/d_4f46.bin" ; $4f46, 64 bytes
Lz_64_4f86:
	INCBIN "data/bank_064/lz_4f86.bin" ; $4f86, 3238 bytes
Lz_64_5c2c:
	INCBIN "data/bank_064/lz_5c2c.bin" ; $5c2c, 802 bytes
Lz_64_5f4e:
	INCBIN "data/bank_064/lz_5f4e.bin" ; $5f4e, 411 bytes
Lz_64_60e9:
	INCBIN "data/bank_064/lz_60e9.bin" ; $60e9, 80 bytes
Lz_64_6139:
	INCBIN "data/bank_064/lz_6139.bin" ; $6139, 90 bytes
Data_64_6193:
	INCBIN "data/bank_064/d_6193.bin" ; $6193, 27 bytes
Data_64_61ae:
	INCBIN "data/bank_064/d_61ae.bin" ; $61ae, 64 bytes
Lz_64_61ee:
	INCBIN "data/bank_064/lz_61ee.bin" ; $61ee, 3100 bytes
Lz_64_6e0a:
	INCBIN "data/bank_064/lz_6e0a.bin" ; $6e0a, 1429 bytes
Lz_64_739f:
	INCBIN "data/bank_064/lz_739f.bin" ; $739f, 679 bytes
Lz_64_7646:
	INCBIN "data/bank_064/lz_7646.bin" ; $7646, 147 bytes
Lz_64_76d9:
	INCBIN "data/bank_064/lz_76d9.bin" ; $76d9, 79 bytes
	; $7728, 8 bytes (fill)
	ds 8, $00
Data_64_7730:
	INCBIN "data/bank_064/d_7730.bin" ; $7730, 2256 bytes

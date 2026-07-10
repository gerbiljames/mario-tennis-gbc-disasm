INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $65", ROMX[$4000], BANK[$65]

DataPtr_65_00:
	dw Data_65_4030 ; $4000
	INCBIN "data/bank_065/d_4002.bin" ; $4002, 2 bytes
DataPtr_65_04:
	dw Lz_65_4c36 ; $4004
DataPtr_65_06:
	dw Lz_65_4ee2 ; $4006
DataPtr_65_08:
	dw Lz_65_5082 ; $4008
DataPtr_65_0a:
	dw Lz_65_50c8 ; $400a
DataPtr_65_0c:
	dw Data_65_5120 ; $400c
DataPtr_65_0e:
	dw Lz_65_408b ; $400e
	INCBIN "data/bank_065/d_4010.bin" ; $4010, 4 bytes
DataPtr_65_14:
	dw Data_65_5ee0 ; $4014
DataPtr_65_16:
	dw Lz_65_6269 ; $4016
DataPtr_65_18:
	dw Lz_65_646e ; $4018
DataPtr_65_1a:
	dw Lz_65_64b4 ; $401a
DataPtr_65_1c:
	dw Data_65_6500 ; $401c
DataPtr_65_1e:
	dw Lz_65_5777 ; $401e
	INCBIN "data/bank_065/d_4020.bin" ; $4020, 4 bytes
DataPtr_65_24:
	dw Lz_65_7458 ; $4024
DataPtr_65_26:
	dw Lz_65_78f2 ; $4026
DataPtr_65_28:
	dw Lz_65_7c97 ; $4028
DataPtr_65_2a:
	dw Lz_65_7d05 ; $402a
DataPtr_65_2c:
	dw Data_65_7d56 ; $402c
DataPtr_65_2e:
	dw Lz_65_6b6a ; $402e
Data_65_4030:
	INCBIN "data/bank_065/d_4030.bin" ; $4030, 91 bytes
Lz_65_408b:
	INCBIN "data/bank_065/lz_408b.bin" ; $408b, 2987 bytes
Lz_65_4c36:
	INCBIN "data/bank_065/lz_4c36.bin" ; $4c36, 684 bytes
Lz_65_4ee2:
	INCBIN "data/bank_065/lz_4ee2.bin" ; $4ee2, 416 bytes
Lz_65_5082:
	INCBIN "data/bank_065/lz_5082.bin" ; $5082, 70 bytes
Lz_65_50c8:
	INCBIN "data/bank_065/lz_50c8.bin" ; $50c8, 73 bytes
	INCBIN "data/bank_065/d_5111.bin" ; $5111, 15 bytes
Data_65_5120:
	INCBIN "data/bank_065/d_5120.bin" ; $5120, 1623 bytes
Lz_65_5777:
	INCBIN "data/bank_065/lz_5777.bin" ; $5777, 1897 bytes
Data_65_5ee0:
	INCBIN "data/bank_065/d_5ee0.bin" ; $5ee0, 671 bytes
	rst Rst18 ; $617f
	ld b, b ; $6180
	ld b, e ; $6181
	ld e, e ; $6182
	inc b ; $6183
	ld c, d ; $6184
	ld h, c ; $6185
	add a, b ; $6186
	INCBIN "data/bank_065/d_6187.bin" ; $6187, 226 bytes
Lz_65_6269:
	INCBIN "data/bank_065/lz_6269.bin" ; $6269, 517 bytes
Lz_65_646e:
	INCBIN "data/bank_065/lz_646e.bin" ; $646e, 70 bytes
Lz_65_64b4:
	INCBIN "data/bank_065/lz_64b4.bin" ; $64b4, 70 bytes
	INCBIN "data/bank_065/d_64fa.bin" ; $64fa, 6 bytes
Data_65_6500:
	INCBIN "data/bank_065/d_6500.bin" ; $6500, 1642 bytes
Lz_65_6b6a:
	INCBIN "data/bank_065/lz_6b6a.bin" ; $6b6a, 2286 bytes
Lz_65_7458:
	INCBIN "data/bank_065/lz_7458.bin" ; $7458, 1178 bytes
Lz_65_78f2:
	INCBIN "data/bank_065/lz_78f2.bin" ; $78f2, 933 bytes
Lz_65_7c97:
	INCBIN "data/bank_065/lz_7c97.bin" ; $7c97, 110 bytes
Lz_65_7d05:
	INCBIN "data/bank_065/lz_7d05.bin" ; $7d05, 81 bytes
Data_65_7d56:
	INCBIN "data/bank_065/d_7d56.bin" ; $7d56, 682 bytes

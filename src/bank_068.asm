INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $68", ROMX[$4000], BANK[$68]

DataPtr_68_00:
	dw Data_68_4030 ; $4000
DataPtr_68_02:
	dw Data_68_405a ; $4002
DataPtr_68_04:
	dw Lz_68_4c72 ; $4004
DataPtr_68_06:
	dw Lz_68_5107 ; $4006
DataPtr_68_08:
	dw Lz_68_53c5 ; $4008
DataPtr_68_0a:
	dw Lz_68_5431 ; $400a
DataPtr_68_0c:
	dw Data_68_547b ; $400c
DataPtr_68_0e:
	dw Lz_68_409a ; $400e
DataPtr_68_10:
	dw Data_68_547b ; $4010
DataPtr_68_12:
	dw Data_68_54a5 ; $4012
DataPtr_68_14:
	dw Lz_68_5d21 ; $4014
DataPtr_68_16:
	dw Lz_68_6164 ; $4016
DataPtr_68_18:
	dw Lz_68_63d0 ; $4018
DataPtr_68_1a:
	dw Lz_68_6435 ; $401a
DataPtr_68_1c:
	dw Data_68_6480 ; $401c
DataPtr_68_1e:
	dw Lz_68_54e5 ; $401e
DataPtr_68_20:
	dw Data_68_6480 ; $4020
DataPtr_68_22:
	dw Data_68_6497 ; $4022
DataPtr_68_24:
	dw Lz_68_6dec ; $4024
DataPtr_68_26:
	dw Lz_68_713d ; $4026
DataPtr_68_28:
	dw Lz_68_7390 ; $4028
DataPtr_68_2a:
	dw Lz_68_73f7 ; $402a
DataPtr_68_2c:
	dw Data_68_7450 ; $402c
DataPtr_68_2e:
	dw Lz_68_64d7 ; $402e
Data_68_4030:
	INCBIN "data/bank_068/d_4030.bin" ; $4030, 42 bytes
Data_68_405a:
	INCBIN "data/bank_068/d_405a.bin" ; $405a, 64 bytes
Lz_68_409a:
	INCBIN "data/bank_068/lz_409a.bin" ; $409a, 3032 bytes
Lz_68_4c72:
	INCBIN "data/bank_068/lz_4c72.bin" ; $4c72, 1173 bytes
Lz_68_5107:
	INCBIN "data/bank_068/lz_5107.bin" ; $5107, 702 bytes
Lz_68_53c5:
	INCBIN "data/bank_068/lz_53c5.bin" ; $53c5, 108 bytes
Lz_68_5431:
	INCBIN "data/bank_068/lz_5431.bin" ; $5431, 74 bytes
Data_68_547b:
	INCBIN "data/bank_068/d_547b.bin" ; $547b, 42 bytes
Data_68_54a5:
	INCBIN "data/bank_068/d_54a5.bin" ; $54a5, 64 bytes
Lz_68_54e5:
	INCBIN "data/bank_068/lz_54e5.bin" ; $54e5, 2108 bytes
Lz_68_5d21:
	INCBIN "data/bank_068/lz_5d21.bin" ; $5d21, 1091 bytes
Lz_68_6164:
	INCBIN "data/bank_068/lz_6164.bin" ; $6164, 620 bytes
Lz_68_63d0:
	INCBIN "data/bank_068/lz_63d0.bin" ; $63d0, 101 bytes
Lz_68_6435:
	INCBIN "data/bank_068/lz_6435.bin" ; $6435, 75 bytes
Data_68_6480:
	INCBIN "data/bank_068/d_6480.bin" ; $6480, 23 bytes
Data_68_6497:
	INCBIN "data/bank_068/d_6497.bin" ; $6497, 64 bytes
Lz_68_64d7:
	INCBIN "data/bank_068/lz_64d7.bin" ; $64d7, 2325 bytes
Lz_68_6dec:
	INCBIN "data/bank_068/lz_6dec.bin" ; $6dec, 849 bytes
Lz_68_713d:
	INCBIN "data/bank_068/lz_713d.bin" ; $713d, 595 bytes
Lz_68_7390:
	INCBIN "data/bank_068/lz_7390.bin" ; $7390, 103 bytes
Lz_68_73f7:
	INCBIN "data/bank_068/lz_73f7.bin" ; $73f7, 74 bytes
	INCBIN "data/bank_068/d_7441.bin" ; $7441, 15 bytes
Data_68_7450:
	INCBIN "data/bank_068/d_7450.bin" ; $7450, 2992 bytes

INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $67", ROMX[$4000], BANK[$67]

DataPtr_67_00:
	dw Data_67_4030 ; $4000
DataPtr_67_02:
	dw Data_67_404b ; $4002
DataPtr_67_04:
	dw Lz_67_4c77 ; $4004
DataPtr_67_06:
	dw Lz_67_50c4 ; $4006
DataPtr_67_08:
	dw Lz_67_5375 ; $4008
DataPtr_67_0a:
	dw Lz_67_53df ; $400a
DataPtr_67_0c:
	dw Data_67_5440 ; $400c
DataPtr_67_0e:
	dw Lz_67_408b ; $400e
DataPtr_67_10:
	dw Data_67_5a40 ; $4010
DataPtr_67_12:
	dw Data_67_5a6a ; $4012
DataPtr_67_14:
	dw Lz_67_63df ; $4014
DataPtr_67_16:
	dw Lz_67_6779 ; $4016
DataPtr_67_18:
	dw Lz_67_69b2 ; $4018
DataPtr_67_1a:
	dw Lz_67_6a19 ; $401a
DataPtr_67_1c:
	dw Data_67_6a64 ; $401c
DataPtr_67_1e:
	dw Lz_67_5aaa ; $401e
DataPtr_67_20:
	dw Data_67_6a64 ; $4020
DataPtr_67_22:
	dw Data_67_6a8e ; $4022
DataPtr_67_24:
	dw Lz_67_73da ; $4024
DataPtr_67_26:
	dw Lz_67_790c ; $4026
DataPtr_67_28:
	dw Lz_67_7bd2 ; $4028
DataPtr_67_2a:
	dw Lz_67_7c52 ; $402a
DataPtr_67_2c:
	dw Data_67_7c9e ; $402c
DataPtr_67_2e:
	dw Lz_67_6ace ; $402e
Data_67_4030:
	INCBIN "data/bank_067/d_4030.bin" ; $4030, 27 bytes
Data_67_404b:
	INCBIN "data/bank_067/d_404b.bin" ; $404b, 64 bytes
Lz_67_408b:
	INCBIN "data/bank_067/lz_408b.bin" ; $408b, 3052 bytes
Lz_67_4c77:
	INCBIN "data/bank_067/lz_4c77.bin" ; $4c77, 1101 bytes
Lz_67_50c4:
	INCBIN "data/bank_067/lz_50c4.bin" ; $50c4, 689 bytes
Lz_67_5375:
	INCBIN "data/bank_067/lz_5375.bin" ; $5375, 106 bytes
Lz_67_53df:
	INCBIN "data/bank_067/lz_53df.bin" ; $53df, 83 bytes
	INCBIN "data/bank_067/d_5432.bin" ; $5432, 14 bytes
Data_67_5440:
	INCBIN "data/bank_067/d_5440.bin" ; $5440, 1536 bytes
Data_67_5a40:
	INCBIN "data/bank_067/d_5a40.bin" ; $5a40, 42 bytes
Data_67_5a6a:
	INCBIN "data/bank_067/d_5a6a.bin" ; $5a6a, 64 bytes
Lz_67_5aaa:
	INCBIN "data/bank_067/lz_5aaa.bin" ; $5aaa, 2357 bytes
Lz_67_63df:
	INCBIN "data/bank_067/lz_63df.bin" ; $63df, 922 bytes
Lz_67_6779:
	INCBIN "data/bank_067/lz_6779.bin" ; $6779, 569 bytes
Lz_67_69b2:
	INCBIN "data/bank_067/lz_69b2.bin" ; $69b2, 103 bytes
Lz_67_6a19:
	INCBIN "data/bank_067/lz_6a19.bin" ; $6a19, 75 bytes
Data_67_6a64:
	INCBIN "data/bank_067/d_6a64.bin" ; $6a64, 42 bytes
Data_67_6a8e:
	INCBIN "data/bank_067/d_6a8e.bin" ; $6a8e, 64 bytes
Lz_67_6ace:
	INCBIN "data/bank_067/lz_6ace.bin" ; $6ace, 2316 bytes
Lz_67_73da:
	INCBIN "data/bank_067/lz_73da.bin" ; $73da, 1330 bytes
Lz_67_790c:
	INCBIN "data/bank_067/lz_790c.bin" ; $790c, 710 bytes
Lz_67_7bd2:
	INCBIN "data/bank_067/lz_7bd2.bin" ; $7bd2, 128 bytes
Lz_67_7c52:
	INCBIN "data/bank_067/lz_7c52.bin" ; $7c52, 76 bytes
Data_67_7c9e:
	INCBIN "data/bank_067/d_7c9e.bin" ; $7c9e, 866 bytes

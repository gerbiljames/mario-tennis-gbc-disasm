INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $66", ROMX[$4000], BANK[$66]

DataPtr_66_00:
	dw Data_66_4040 ; $4000
DataPtr_66_02:
	dw $406a ; $4002
DataPtr_66_04:
	dw Lz_66_45b6 ; $4004
DataPtr_66_06:
	dw Lz_66_49aa ; $4006
DataPtr_66_08:
	dw Lz_66_4ca2 ; $4008
DataPtr_66_0a:
	dw Lz_66_4d07 ; $400a
DataPtr_66_0c:
	dw Data_66_4d4f ; $400c
DataPtr_66_0e:
	dw $40aa ; $400e
DataPtr_66_10:
	dw Data_66_4d4f ; $4010
	INCBIN "data/bank_066/d_4012.bin" ; $4012, 2 bytes
DataPtr_66_14:
	dw Lz_66_55ab ; $4014
DataPtr_66_16:
	dw Lz_66_59e9 ; $4016
DataPtr_66_18:
	dw Lz_66_5c8c ; $4018
DataPtr_66_1a:
	dw Lz_66_5d02 ; $401a
DataPtr_66_1c:
	dw Data_66_5d82 ; $401c
DataPtr_66_1e:
	dw Lz_66_4db9 ; $401e
DataPtr_66_20:
	dw Data_66_5d82 ; $4020
	INCBIN "data/bank_066/d_4022.bin" ; $4022, 2 bytes
DataPtr_66_24:
	dw Lz_66_66c8 ; $4024
DataPtr_66_26:
	dw Lz_66_6b10 ; $4026
DataPtr_66_28:
	dw Lz_66_6d4c ; $4028
DataPtr_66_2a:
	dw Lz_66_6dad ; $402a
DataPtr_66_2c:
	dw Data_66_6df8 ; $402c
DataPtr_66_2e:
	dw Lz_66_5dcb ; $402e
DataPtr_66_30:
	dw Data_66_6df8 ; $4030
DataPtr_66_32:
	dw $6e22 ; $4032
DataPtr_66_34:
	dw Lz_66_75de ; $4034
DataPtr_66_36:
	dw Lz_66_79a9 ; $4036
DataPtr_66_38:
	dw Lz_66_7b83 ; $4038
DataPtr_66_3a:
	dw Lz_66_7be2 ; $403a
DataPtr_66_3c:
	dw Data_66_7c2d ; $403c
DataPtr_66_3e:
	dw $6e62 ; $403e
Data_66_4040:
	INCBIN "data/bank_066/d_4040.bin" ; $4040, 136 bytes
	INCBIN "data/bank_066/d_40c8.bin" ; $40c8, 1262 bytes
Lz_66_45b6:
	INCBIN "data/bank_066/lz_45b6.bin" ; $45b6, 1012 bytes
Lz_66_49aa:
	INCBIN "data/bank_066/lz_49aa.bin" ; $49aa, 760 bytes
Lz_66_4ca2:
	INCBIN "data/bank_066/lz_4ca2.bin" ; $4ca2, 101 bytes
Lz_66_4d07:
	INCBIN "data/bank_066/lz_4d07.bin" ; $4d07, 72 bytes
Data_66_4d4f:
	INCBIN "data/bank_066/d_4d4f.bin" ; $4d4f, 106 bytes
Lz_66_4db9:
	INCBIN "data/bank_066/lz_4db9.bin" ; $4db9, 2034 bytes
Lz_66_55ab:
	INCBIN "data/bank_066/lz_55ab.bin" ; $55ab, 1086 bytes
Lz_66_59e9:
	INCBIN "data/bank_066/lz_59e9.bin" ; $59e9, 675 bytes
Lz_66_5c8c:
	INCBIN "data/bank_066/lz_5c8c.bin" ; $5c8c, 118 bytes
Lz_66_5d02:
	INCBIN "data/bank_066/lz_5d02.bin" ; $5d02, 128 bytes
Data_66_5d82:
	INCBIN "data/bank_066/d_5d82.bin" ; $5d82, 73 bytes
Lz_66_5dcb:
	INCBIN "data/bank_066/lz_5dcb.bin" ; $5dcb, 2301 bytes
Lz_66_66c8:
	INCBIN "data/bank_066/lz_66c8.bin" ; $66c8, 1096 bytes
Lz_66_6b10:
	INCBIN "data/bank_066/lz_6b10.bin" ; $6b10, 572 bytes
Lz_66_6d4c:
	INCBIN "data/bank_066/lz_6d4c.bin" ; $6d4c, 97 bytes
Lz_66_6dad:
	INCBIN "data/bank_066/lz_6dad.bin" ; $6dad, 75 bytes
Data_66_6df8:
	INCBIN "data/bank_066/d_6df8.bin" ; $6df8, 136 bytes
	INCBIN "data/bank_066/d_6e80.bin" ; $6e80, 1886 bytes
Lz_66_75de:
	INCBIN "data/bank_066/lz_75de.bin" ; $75de, 971 bytes
Lz_66_79a9:
	INCBIN "data/bank_066/lz_79a9.bin" ; $79a9, 474 bytes
Lz_66_7b83:
	INCBIN "data/bank_066/lz_7b83.bin" ; $7b83, 95 bytes
Lz_66_7be2:
	INCBIN "data/bank_066/lz_7be2.bin" ; $7be2, 75 bytes
Data_66_7c2d:
	INCBIN "data/bank_066/d_7c2d.bin" ; $7c2d, 979 bytes

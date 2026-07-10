INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $61", ROMX[$4000], BANK[$61]

DataPtr_61_00:
	dw Data_61_4c19 ; $4000
DataPtr_61_02:
	dw Data_61_4040 ; $4002
DataPtr_61_04:
	dw Lz_61_49ae ; $4004
DataPtr_61_06:
	dw Lz_61_4b7b ; $4006
DataPtr_61_08:
	dw Data_61_4c19 ; $4008
	INCBIN "data/bank_061/d_400a.bin" ; $400a, 4 bytes
DataPtr_61_0e:
	dw Lz_61_4080 ; $400e
DataPtr_61_10:
	dw Data_61_5bfb ; $4010
	INCBIN "data/bank_061/d_4012.bin" ; $4012, 2 bytes
DataPtr_61_14:
	dw Lz_61_589a ; $4014
DataPtr_61_16:
	dw Lz_61_5aee ; $4016
DataPtr_61_18:
	dw Data_61_5bfb ; $4018
	INCBIN "data/bank_061/d_401a.bin" ; $401a, 4 bytes
DataPtr_61_1e:
	dw Lz_61_4ca9 ; $401e
DataPtr_61_20:
	dw Data_61_69fb ; $4020
	INCBIN "data/bank_061/d_4022.bin" ; $4022, 2 bytes
DataPtr_61_24:
	dw Lz_61_6754 ; $4024
DataPtr_61_26:
	dw Lz_61_6977 ; $4026
DataPtr_61_28:
	dw Data_61_69fb ; $4028
	INCBIN "data/bank_061/d_402a.bin" ; $402a, 4 bytes
DataPtr_61_2e:
	dw Lz_61_5c8b ; $402e
DataPtr_61_30:
	dw Data_61_7a47 ; $4030
	INCBIN "data/bank_061/d_4032.bin" ; $4032, 2 bytes
DataPtr_61_34:
	dw Lz_61_7646 ; $4034
DataPtr_61_36:
	dw Lz_61_790a ; $4036
DataPtr_61_38:
	dw Data_61_7a47 ; $4038
	INCBIN "data/bank_061/d_403a.bin" ; $403a, 4 bytes
DataPtr_61_3e:
	dw Lz_61_6a8b ; $403e
Data_61_4040:
	INCBIN "data/bank_061/d_4040.bin" ; $4040, 64 bytes
Lz_61_4080:
	INCBIN "data/bank_061/lz_4080.bin" ; $4080, 2350 bytes
Lz_61_49ae:
	INCBIN "data/bank_061/lz_49ae.bin" ; $49ae, 461 bytes
Lz_61_4b7b:
	INCBIN "data/bank_061/lz_4b7b.bin" ; $4b7b, 158 bytes
Data_61_4c19:
	INCBIN "data/bank_061/d_4c19.bin" ; $4c19, 144 bytes
Lz_61_4ca9:
	INCBIN "data/bank_061/lz_4ca9.bin" ; $4ca9, 3057 bytes
Lz_61_589a:
	INCBIN "data/bank_061/lz_589a.bin" ; $589a, 596 bytes
Lz_61_5aee:
	INCBIN "data/bank_061/lz_5aee.bin" ; $5aee, 269 bytes
Data_61_5bfb:
	INCBIN "data/bank_061/d_5bfb.bin" ; $5bfb, 144 bytes
Lz_61_5c8b:
	INCBIN "data/bank_061/lz_5c8b.bin" ; $5c8b, 2761 bytes
Lz_61_6754:
	INCBIN "data/bank_061/lz_6754.bin" ; $6754, 547 bytes
Lz_61_6977:
	INCBIN "data/bank_061/lz_6977.bin" ; $6977, 132 bytes
Data_61_69fb:
	INCBIN "data/bank_061/d_69fb.bin" ; $69fb, 144 bytes
Lz_61_6a8b:
	INCBIN "data/bank_061/lz_6a8b.bin" ; $6a8b, 3003 bytes
Lz_61_7646:
	INCBIN "data/bank_061/lz_7646.bin" ; $7646, 708 bytes
Lz_61_790a:
	INCBIN "data/bank_061/lz_790a.bin" ; $790a, 317 bytes
Data_61_7a47:
	INCBIN "data/bank_061/d_7a47.bin" ; $7a47, 1465 bytes

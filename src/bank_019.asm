INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $19", ROMX[$4000], BANK[$19]

DataPtr_19_00:
	dw Lz_19_404c ; $4000
DataPtr_19_02:
	dw Data_19_4c7a ; $4002
DataPtr_19_04:
	dw Lz_19_4cba ; $4004
DataPtr_19_06:
	dw Lz_19_4dc3 ; $4006
DataPtr_19_08:
	dw Lz_19_4e26 ; $4008
DataPtr_19_0a:
	dw Lz_19_4f28 ; $400a
DataPtr_19_0c:
	dw Lz_19_4fa3 ; $400c
DataPtr_19_0e:
	dw Lz_19_50b2 ; $400e
DataPtr_19_10:
	dw Lz_19_5106 ; $4010
DataPtr_19_12:
	dw Lz_19_5209 ; $4012
DataPtr_19_14:
	dw Lz_19_5273 ; $4014
DataPtr_19_16:
	dw Lz_19_5344 ; $4016
DataPtr_19_18:
	dw Lz_19_53d0 ; $4018
DataPtr_19_1a:
	dw Lz_19_54ad ; $401a
DataPtr_19_1c:
	dw Lz_19_551f ; $401c
DataPtr_19_1e:
	dw Data_19_6124 ; $401e
DataPtr_19_20:
	dw Lz_19_6164 ; $4020
DataPtr_19_22:
	dw Lz_19_6265 ; $4022
DataPtr_19_24:
	dw Lz_19_62e6 ; $4024
DataPtr_19_26:
	dw Lz_19_63e0 ; $4026
DataPtr_19_28:
	dw Lz_19_644e ; $4028
DataPtr_19_2a:
	dw Lz_19_655d ; $402a
DataPtr_19_2c:
	dw Lz_19_65e1 ; $402c
DataPtr_19_2e:
	dw Lz_19_66e9 ; $402e
DataPtr_19_30:
	dw Lz_19_676d ; $4030
DataPtr_19_32:
	dw Lz_19_6844 ; $4032
DataPtr_19_34:
	dw Lz_19_68b1 ; $4034
DataPtr_19_36:
	dw Lz_19_6993 ; $4036
DataPtr_19_38:
	dw Data_19_6a10 ; $4038
DataPtr_19_3a:
	dw Data_19_772b ; $403a
DataPtr_19_3c:
	dw Lz_19_776b ; $403c
DataPtr_19_3e:
	dw Lz_19_787e ; $403e
DataPtr_19_40:
	dw Lz_19_78fe ; $4040
DataPtr_19_42:
	dw Lz_19_7a11 ; $4042
DataPtr_19_44:
	dw Lz_19_7a8e ; $4044
DataPtr_19_46:
	dw Lz_19_7ba1 ; $4046
DataPtr_19_48:
	dw Lz_19_7c34 ; $4048
DataPtr_19_4a:
	dw Lz_19_7d47 ; $404a
Lz_19_404c:
	INCBIN "data/bank_019/lz_404c.bin" ; $404c, 3118 bytes
Data_19_4c7a:
	INCBIN "data/bank_019/d_4c7a.bin" ; $4c7a, 64 bytes
Lz_19_4cba:
	INCBIN "data/bank_019/lz_4cba.bin" ; $4cba, 265 bytes
Lz_19_4dc3:
	INCBIN "data/bank_019/lz_4dc3.bin" ; $4dc3, 99 bytes
Lz_19_4e26:
	INCBIN "data/bank_019/lz_4e26.bin" ; $4e26, 258 bytes
Lz_19_4f28:
	INCBIN "data/bank_019/lz_4f28.bin" ; $4f28, 123 bytes
Lz_19_4fa3:
	INCBIN "data/bank_019/lz_4fa3.bin" ; $4fa3, 271 bytes
Lz_19_50b2:
	INCBIN "data/bank_019/lz_50b2.bin" ; $50b2, 84 bytes
Lz_19_5106:
	INCBIN "data/bank_019/lz_5106.bin" ; $5106, 259 bytes
Lz_19_5209:
	INCBIN "data/bank_019/lz_5209.bin" ; $5209, 106 bytes
Lz_19_5273:
	INCBIN "data/bank_019/lz_5273.bin" ; $5273, 209 bytes
Lz_19_5344:
	INCBIN "data/bank_019/lz_5344.bin" ; $5344, 140 bytes
Lz_19_53d0:
	INCBIN "data/bank_019/lz_53d0.bin" ; $53d0, 221 bytes
Lz_19_54ad:
	INCBIN "data/bank_019/lz_54ad.bin" ; $54ad, 114 bytes
Lz_19_551f:
	INCBIN "data/bank_019/lz_551f.bin" ; $551f, 3077 bytes
Data_19_6124:
	INCBIN "data/bank_019/d_6124.bin" ; $6124, 64 bytes
Lz_19_6164:
	INCBIN "data/bank_019/lz_6164.bin" ; $6164, 257 bytes
Lz_19_6265:
	INCBIN "data/bank_019/lz_6265.bin" ; $6265, 129 bytes
Lz_19_62e6:
	INCBIN "data/bank_019/lz_62e6.bin" ; $62e6, 250 bytes
Lz_19_63e0:
	INCBIN "data/bank_019/lz_63e0.bin" ; $63e0, 110 bytes
Lz_19_644e:
	INCBIN "data/bank_019/lz_644e.bin" ; $644e, 271 bytes
Lz_19_655d:
	INCBIN "data/bank_019/lz_655d.bin" ; $655d, 132 bytes
Lz_19_65e1:
	INCBIN "data/bank_019/lz_65e1.bin" ; $65e1, 264 bytes
Lz_19_66e9:
	INCBIN "data/bank_019/lz_66e9.bin" ; $66e9, 132 bytes
Lz_19_676d:
	INCBIN "data/bank_019/lz_676d.bin" ; $676d, 215 bytes
Lz_19_6844:
	INCBIN "data/bank_019/lz_6844.bin" ; $6844, 109 bytes
Lz_19_68b1:
	INCBIN "data/bank_019/lz_68b1.bin" ; $68b1, 226 bytes
Lz_19_6993:
	INCBIN "data/bank_019/lz_6993.bin" ; $6993, 125 bytes
Data_19_6a10:
	INCBIN "data/bank_019/d_6a10.bin" ; $6a10, 3186 bytes
	sound $6c ; $7682
	ld d, a ; $7684
	ld hl, sp - 17 ; $7685
	cp a, a ; $7687
	pop bc ; $7688
	add sp, 100 ; $7689
	INCBIN "data/bank_019/d_768b.bin" ; $768b, 160 bytes
Data_19_772b:
	INCBIN "data/bank_019/d_772b.bin" ; $772b, 64 bytes
Lz_19_776b:
	INCBIN "data/bank_019/lz_776b.bin" ; $776b, 275 bytes
Lz_19_787e:
	INCBIN "data/bank_019/lz_787e.bin" ; $787e, 128 bytes
Lz_19_78fe:
	INCBIN "data/bank_019/lz_78fe.bin" ; $78fe, 275 bytes
Lz_19_7a11:
	INCBIN "data/bank_019/lz_7a11.bin" ; $7a11, 125 bytes
Lz_19_7a8e:
	INCBIN "data/bank_019/lz_7a8e.bin" ; $7a8e, 275 bytes
Lz_19_7ba1:
	INCBIN "data/bank_019/lz_7ba1.bin" ; $7ba1, 147 bytes
Lz_19_7c34:
	INCBIN "data/bank_019/lz_7c34.bin" ; $7c34, 275 bytes
Lz_19_7d47:
	INCBIN "data/bank_019/lz_7d47.bin" ; $7d47, 144 bytes
	ds 553, $ff ; $7dd7, fill

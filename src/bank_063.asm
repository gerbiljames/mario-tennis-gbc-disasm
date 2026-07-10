INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $63", ROMX[$4000], BANK[$63]

DataPtr_63_00:
	dw Data_63_4bae ; $4000
DataPtr_63_02:
	dw Data_63_4040 ; $4002
DataPtr_63_04:
	dw Lz_63_487a ; $4004
DataPtr_63_06:
	dw Lz_63_4af5 ; $4006
DataPtr_63_08:
	dw Data_63_4bae ; $4008
	INCBIN "data/bank_063/d_400a.bin" ; $400a, 4 bytes
DataPtr_63_0e:
	dw Lz_63_4080 ; $400e
DataPtr_63_10:
	dw Data_63_5d25 ; $4010
	INCBIN "data/bank_063/d_4012.bin" ; $4012, 2 bytes
DataPtr_63_14:
	dw DKCourtTilemap ; $4014
DataPtr_63_16:
	dw Lz_63_5be2 ; $4016
DataPtr_63_18:
	dw Data_63_5d25 ; $4018
	INCBIN "data/bank_063/d_401a.bin" ; $401a, 2 bytes
DataPtr_63_1c:
	dw Data_63_5d75 ; $401c
DataPtr_63_1e:
	dw DKCourtTiles ; $401e
DataPtr_63_20:
	dw Data_63_5d75 ; $4020
DataPtr_63_22:
	dw $5d9f ; $4022
DataPtr_63_24:
	dw Lz_63_608c ; $4024
DataPtr_63_26:
	dw Lz_63_619e ; $4026
DataPtr_63_28:
	dw Lz_63_62a5 ; $4028
DataPtr_63_2a:
	dw Lz_63_62eb ; $402a
DataPtr_63_2c:
	dw Data_63_6331 ; $402c
DataPtr_63_2e:
	dw $5ddf ; $402e
	INCBIN "data/bank_063/d_4030.bin" ; $4030, 16 bytes
Data_63_4040:
	INCBIN "data/bank_063/d_4040.bin" ; $4040, 64 bytes
Lz_63_4080:
	INCBIN "data/bank_063/lz_4080.bin" ; $4080, 2042 bytes
Lz_63_487a:
	INCBIN "data/bank_063/lz_487a.bin" ; $487a, 635 bytes
Lz_63_4af5:
	INCBIN "data/bank_063/lz_4af5.bin" ; $4af5, 185 bytes
Data_63_4bae:
	INCBIN "data/bank_063/d_4bae.bin" ; $4bae, 144 bytes
DKCourtTiles:
	INCBIN "data/bank_063/lz_4c3e.bin" ; $4c3e, 3291 bytes
DKCourtTilemap:
	INCBIN "data/bank_063/lz_5919.bin" ; $5919, 713 bytes
Lz_63_5be2:
	INCBIN "data/bank_063/lz_5be2.bin" ; $5be2, 323 bytes
Data_63_5d25:
	INCBIN "data/bank_063/d_5d25.bin" ; $5d25, 80 bytes
Data_63_5d75:
	INCBIN "data/bank_063/d_5d75.bin" ; $5d75, 136 bytes
	INCBIN "data/bank_063/d_5dfd.bin" ; $5dfd, 655 bytes
Lz_63_608c:
	INCBIN "data/bank_063/lz_608c.bin" ; $608c, 274 bytes
Lz_63_619e:
	INCBIN "data/bank_063/lz_619e.bin" ; $619e, 263 bytes
Lz_63_62a5:
	INCBIN "data/bank_063/lz_62a5.bin" ; $62a5, 70 bytes
Lz_63_62eb:
	INCBIN "data/bank_063/lz_62eb.bin" ; $62eb, 70 bytes
Data_63_6331:
	INCBIN "data/bank_063/d_6331.bin" ; $6331, 7375 bytes

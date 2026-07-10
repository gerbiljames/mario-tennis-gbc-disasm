INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5f", ROMX[$4000], BANK[$5f]

	INCBIN "data/bank_05f/d_4000.bin" ; $4000, 4 bytes
DataPtr_5f_04:
	dw Lz_5f_4855 ; $4004
DataPtr_5f_06:
	dw Lz_5f_4ac6 ; $4006
	INCBIN "data/bank_05f/d_4008.bin" ; $4008, 12 bytes
DataPtr_5f_14:
	dw Lz_5f_55f3 ; $4014
DataPtr_5f_16:
	dw Lz_5f_57de ; $4016
	INCBIN "data/bank_05f/d_4018.bin" ; $4018, 6 bytes
DataPtr_5f_1e:
	dw Lz_5f_4ca3 ; $401e
	INCBIN "data/bank_05f/d_4020.bin" ; $4020, 176 bytes
FarPtr_5f_d0:
	dw Func_5f_7fed ; $40d0
	INCBIN "data/bank_05f/d_40d2.bin" ; $40d2, 1923 bytes
Lz_5f_4855:
	INCBIN "data/bank_05f/lz_4855.bin" ; $4855, 624 bytes
	INCBIN "data/bank_05f/d_4ac5.bin" ; $4ac5, 1 bytes
Lz_5f_4ac6:
	INCBIN "data/bank_05f/lz_4ac6.bin" ; $4ac6, 332 bytes
	INCBIN "data/bank_05f/d_4c12.bin" ; $4c12, 145 bytes
Lz_5f_4ca3:
	INCBIN "data/bank_05f/lz_4ca3.bin" ; $4ca3, 2383 bytes
	INCBIN "data/bank_05f/d_55f2.bin" ; $55f2, 1 bytes
Lz_5f_55f3:
	INCBIN "data/bank_05f/lz_55f3.bin" ; $55f3, 490 bytes
	INCBIN "data/bank_05f/d_57dd.bin" ; $57dd, 1 bytes
Lz_5f_57de:
	INCBIN "data/bank_05f/lz_57de.bin" ; $57de, 293 bytes
	INCBIN "data/bank_05f/d_5903.bin" ; $5903, 9962 bytes
Func_5f_7fed:
	rst Rst38 ; $7fed
	rst Rst38 ; $7fee
	rst Rst38 ; $7fef
	rst Rst38 ; $7ff0
	rst Rst38 ; $7ff1
	rst Rst38 ; $7ff2
	rst Rst38 ; $7ff3
	rst Rst38 ; $7ff4
	rst Rst38 ; $7ff5
	rst Rst38 ; $7ff6
	rst Rst38 ; $7ff7
	rst Rst38 ; $7ff8
	rst Rst38 ; $7ff9
	rst Rst38 ; $7ffa
	rst Rst38 ; $7ffb
	rst Rst38 ; $7ffc
	rst Rst38 ; $7ffd
	rst Rst38 ; $7ffe
	rst Rst38 ; $7fff

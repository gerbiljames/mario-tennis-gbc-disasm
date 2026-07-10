INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $62", ROMX[$4000], BANK[$62]

	INCBIN "data/bank_062/d_4000.bin" ; $4000, 2 bytes
DataPtr_62_02:
	dw Data_62_4040 ; $4002
DataPtr_62_04:
	dw Lz_62_4846 ; $4004
DataPtr_62_06:
	dw Lz_62_4a42 ; $4006
DataPtr_62_08:
	dw Data_62_4b13 ; $4008
DataPtr_62_0a:
	dw Data_62_4b3b ; $400a
	INCBIN "data/bank_062/d_400c.bin" ; $400c, 2 bytes
DataPtr_62_0e:
	dw Lz_62_4080 ; $400e
	INCBIN "data/bank_062/d_4010.bin" ; $4010, 48 bytes
Data_62_4040:
	INCBIN "data/bank_062/d_4040.bin" ; $4040, 64 bytes
Lz_62_4080:
	INCBIN "data/bank_062/lz_4080.bin" ; $4080, 1990 bytes
Lz_62_4846:
	INCBIN "data/bank_062/lz_4846.bin" ; $4846, 508 bytes
Lz_62_4a42:
	INCBIN "data/bank_062/lz_4a42.bin" ; $4a42, 209 bytes
Data_62_4b13:
	INCBIN "data/bank_062/d_4b13.bin" ; $4b13, 40 bytes
Data_62_4b3b:
	INCBIN "data/bank_062/d_4b3b.bin" ; $4b3b, 40 bytes
	INCBIN "data/bank_062/d_4b63.bin" ; $4b63, 13469 bytes

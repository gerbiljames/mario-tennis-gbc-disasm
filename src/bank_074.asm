INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $74", ROMX[$4000], BANK[$74]

DataPtr_74_00:
	dw Data_74_4012 ; $4000
DataPtr_74_02:
	dw Data_74_4785 ; $4002
DataPtr_74_04:
	dw Data_74_4dfd ; $4004
DataPtr_74_06:
	dw Data_74_546d ; $4006
DataPtr_74_08:
	dw Data_74_5add ; $4008
DataPtr_74_0a:
	dw Data_74_614d ; $400a
	INCBIN "data/bank_074/d_400c.bin" ; $400c, 6 bytes
Data_74_4012:
	INCBIN "data/bank_074/d_4012.bin" ; $4012, 16 bytes
	INCBIN "data/bank_074/d_4022.bin" ; $4022, 1891 bytes
Data_74_4785:
	INCBIN "data/bank_074/d_4785.bin" ; $4785, 16 bytes
	INCBIN "data/bank_074/d_4795.bin" ; $4795, 1640 bytes
Data_74_4dfd:
	INCBIN "data/bank_074/d_4dfd.bin" ; $4dfd, 1648 bytes
Data_74_546d:
	INCBIN "data/bank_074/d_546d.bin" ; $546d, 1648 bytes
Data_74_5add:
	INCBIN "data/bank_074/d_5add.bin" ; $5add, 1648 bytes
Data_74_614d:
	INCBIN "data/bank_074/d_614d.bin" ; $614d, 7859 bytes

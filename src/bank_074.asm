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
DataPtr_74_0c:
	dw Data_74_67bd ; $400c
DataPtr_74_0e:
	dw Data_74_6e2d ; $400e
DataPtr_74_10:
	dw Data_74_749d ; $4010
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
	INCBIN "data/bank_074/d_614d.bin" ; $614d, 1648 bytes
Data_74_67bd:
	INCBIN "data/bank_074/d_67bd.bin" ; $67bd, 1648 bytes
Data_74_6e2d:
	INCBIN "data/bank_074/d_6e2d.bin" ; $6e2d, 1648 bytes
Data_74_749d:
	INCBIN "data/bank_074/d_749d.bin" ; $749d, 2915 bytes

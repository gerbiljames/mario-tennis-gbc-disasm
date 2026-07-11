INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $72", ROMX[$4000], BANK[$72]

DataPtr_72_00:
	dw Data_72_4012 ; $4000
DataPtr_72_02:
	dw Data_72_467d ; $4002
DataPtr_72_04:
	dw Data_72_4ced ; $4004
DataPtr_72_06:
	dw Data_72_566a ; $4006
DataPtr_72_08:
	dw Data_72_5cdd ; $4008
DataPtr_72_0a:
	dw Data_72_634d ; $400a
DataPtr_72_0c:
	dw Data_72_69bd ; $400c
DataPtr_72_0e:
	dw Data_72_702d ; $400e
DataPtr_72_10:
	dw Data_72_769d ; $4010
Data_72_4012:
	INCBIN "data/bank_072/d_4012.bin" ; $4012, 16 bytes
	INCBIN "data/bank_072/d_4022.bin" ; $4022, 1627 bytes
Data_72_467d:
	INCBIN "data/bank_072/d_467d.bin" ; $467d, 16 bytes
	INCBIN "data/bank_072/d_468d.bin" ; $468d, 1632 bytes
Data_72_4ced:
	INCBIN "data/bank_072/d_4ced.bin" ; $4ced, 16 bytes
	INCBIN "data/bank_072/d_4cfd.bin" ; $4cfd, 2413 bytes
Data_72_566a:
	INCBIN "data/bank_072/d_566a.bin" ; $566a, 16 bytes
	INCBIN "data/bank_072/d_567a.bin" ; $567a, 1635 bytes
Data_72_5cdd:
	INCBIN "data/bank_072/d_5cdd.bin" ; $5cdd, 16 bytes
	INCBIN "data/bank_072/d_5ced.bin" ; $5ced, 1632 bytes
Data_72_634d:
	INCBIN "data/bank_072/d_634d.bin" ; $634d, 16 bytes
	INCBIN "data/bank_072/d_635d.bin" ; $635d, 1632 bytes
Data_72_69bd:
	INCBIN "data/bank_072/d_69bd.bin" ; $69bd, 16 bytes
	INCBIN "data/bank_072/d_69cd.bin" ; $69cd, 1632 bytes
Data_72_702d:
	INCBIN "data/bank_072/d_702d.bin" ; $702d, 16 bytes
	INCBIN "data/bank_072/d_703d.bin" ; $703d, 1632 bytes
Data_72_769d:
	INCBIN "data/bank_072/d_769d.bin" ; $769d, 16 bytes
	INCBIN "data/bank_072/d_76ad.bin" ; $76ad, 1632 bytes
	ds 755, $ff ; $7d0d, fill

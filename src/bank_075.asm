INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $75", ROMX[$4000], BANK[$75]

DataPtr_75_00:
	dw Data_75_4012 ; $4000
DataPtr_75_02:
	dw Data_75_467d ; $4002
DataPtr_75_04:
	dw Data_75_4ced ; $4004
DataPtr_75_06:
	dw Data_75_535d ; $4006
DataPtr_75_08:
	dw Data_75_59cd ; $4008
DataPtr_75_0a:
	dw Data_75_603d ; $400a
DataPtr_75_0c:
	dw Data_75_66ad ; $400c
DataPtr_75_0e:
	dw Data_75_6d2b ; $400e
DataPtr_75_10:
	dw Data_75_739d ; $4010
Data_75_4012:
	INCBIN "data/bank_075/d_4012.bin" ; $4012, 1643 bytes
Data_75_467d:
	INCBIN "data/bank_075/d_467d.bin" ; $467d, 1648 bytes
Data_75_4ced:
	INCBIN "data/bank_075/d_4ced.bin" ; $4ced, 1648 bytes
Data_75_535d:
	INCBIN "data/bank_075/d_535d.bin" ; $535d, 1648 bytes
Data_75_59cd:
	INCBIN "data/bank_075/d_59cd.bin" ; $59cd, 1648 bytes
Data_75_603d:
	INCBIN "data/bank_075/d_603d.bin" ; $603d, 1648 bytes
Data_75_66ad:
	INCBIN "data/bank_075/d_66ad.bin" ; $66ad, 1662 bytes
Data_75_6d2b:
	INCBIN "data/bank_075/d_6d2b.bin" ; $6d2b, 16 bytes
	INCBIN "data/bank_075/d_6d3b.bin" ; $6d3b, 1634 bytes
Data_75_739d:
	INCBIN "data/bank_075/d_739d.bin" ; $739d, 16 bytes
	INCBIN "data/bank_075/d_73ad.bin" ; $73ad, 2669 bytes
	ds 486, $ff ; $7e1a, fill

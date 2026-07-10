INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $76", ROMX[$4000], BANK[$76]

DataPtr_76_00:
	dw Data_76_400e ; $4000
DataPtr_76_02:
	dw Data_76_467d ; $4002
DataPtr_76_04:
	dw Data_76_4ced ; $4004
DataPtr_76_06:
	dw Data_76_5774 ; $4006
DataPtr_76_08:
	dw Data_76_5ded ; $4008
DataPtr_76_0a:
	dw Data_76_686a ; $400a
DataPtr_76_0c:
	dw Data_76_72ea ; $400c
Data_76_400e:
	INCBIN "data/bank_076/d_400e.bin" ; $400e, 16 bytes
	INCBIN "data/bank_076/d_401e.bin" ; $401e, 1631 bytes
Data_76_467d:
	INCBIN "data/bank_076/d_467d.bin" ; $467d, 16 bytes
	INCBIN "data/bank_076/d_468d.bin" ; $468d, 1632 bytes
Data_76_4ced:
	INCBIN "data/bank_076/d_4ced.bin" ; $4ced, 16 bytes
	INCBIN "data/bank_076/d_4cfd.bin" ; $4cfd, 2679 bytes
Data_76_5774:
	INCBIN "data/bank_076/d_5774.bin" ; $5774, 16 bytes
	INCBIN "data/bank_076/d_5784.bin" ; $5784, 1641 bytes
Data_76_5ded:
	INCBIN "data/bank_076/d_5ded.bin" ; $5ded, 16 bytes
	INCBIN "data/bank_076/d_5dfd.bin" ; $5dfd, 2669 bytes
Data_76_686a:
	INCBIN "data/bank_076/d_686a.bin" ; $686a, 16 bytes
	INCBIN "data/bank_076/d_687a.bin" ; $687a, 2672 bytes
Data_76_72ea:
	INCBIN "data/bank_076/d_72ea.bin" ; $72ea, 16 bytes
	INCBIN "data/bank_076/d_72fa.bin" ; $72fa, 3334 bytes

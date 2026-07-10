INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $69", ROMX[$4000], BANK[$69]

DataPtr_69_00:
	dw Data_69_4030 ; $4000
DataPtr_69_02:
	dw $405a ; $4002
DataPtr_69_04:
	dw Lz_69_4c5d ; $4004
DataPtr_69_06:
	dw Lz_69_511b ; $4006
DataPtr_69_08:
	dw Lz_69_5412 ; $4008
DataPtr_69_0a:
	dw Lz_69_5493 ; $400a
DataPtr_69_0c:
	dw Data_69_5514 ; $400c
DataPtr_69_0e:
	dw $409a ; $400e
DataPtr_69_10:
	dw Data_69_5514 ; $4010
	INCBIN "data/bank_069/d_4012.bin" ; $4012, 2 bytes
DataPtr_69_14:
	dw Lz_69_5da0 ; $4014
DataPtr_69_16:
	dw Lz_69_617f ; $4016
DataPtr_69_18:
	dw Lz_69_646e ; $4018
DataPtr_69_1a:
	dw Lz_69_64eb ; $401a
DataPtr_69_1c:
	dw Data_69_6542 ; $401c
DataPtr_69_1e:
	dw Lz_69_557e ; $401e
DataPtr_69_20:
	dw Data_69_6542 ; $4020
	INCBIN "data/bank_069/d_4022.bin" ; $4022, 2 bytes
DataPtr_69_24:
	dw Lz_69_6f53 ; $4024
DataPtr_69_26:
	dw Lz_69_733a ; $4026
DataPtr_69_28:
	dw Lz_69_75c1 ; $4028
DataPtr_69_2a:
	dw Lz_69_7615 ; $402a
DataPtr_69_2c:
	dw Data_69_7660 ; $402c
DataPtr_69_2e:
	dw Lz_69_659d ; $402e
Data_69_4030:
	INCBIN "data/bank_069/d_4030.bin" ; $4030, 136 bytes
	INCBIN "data/bank_069/d_40b8.bin" ; $40b8, 2981 bytes
Lz_69_4c5d:
	INCBIN "data/bank_069/lz_4c5d.bin" ; $4c5d, 1214 bytes
Lz_69_511b:
	INCBIN "data/bank_069/lz_511b.bin" ; $511b, 759 bytes
Lz_69_5412:
	INCBIN "data/bank_069/lz_5412.bin" ; $5412, 129 bytes
Lz_69_5493:
	INCBIN "data/bank_069/lz_5493.bin" ; $5493, 129 bytes
Data_69_5514:
	INCBIN "data/bank_069/d_5514.bin" ; $5514, 106 bytes
Lz_69_557e:
	INCBIN "data/bank_069/lz_557e.bin" ; $557e, 2082 bytes
Lz_69_5da0:
	INCBIN "data/bank_069/lz_5da0.bin" ; $5da0, 991 bytes
Lz_69_617f:
	INCBIN "data/bank_069/lz_617f.bin" ; $617f, 751 bytes
Lz_69_646e:
	INCBIN "data/bank_069/lz_646e.bin" ; $646e, 125 bytes
Lz_69_64eb:
	INCBIN "data/bank_069/lz_64eb.bin" ; $64eb, 87 bytes
Data_69_6542:
	INCBIN "data/bank_069/d_6542.bin" ; $6542, 91 bytes
Lz_69_659d:
	INCBIN "data/bank_069/lz_659d.bin" ; $659d, 2486 bytes
Lz_69_6f53:
	INCBIN "data/bank_069/lz_6f53.bin" ; $6f53, 999 bytes
Lz_69_733a:
	INCBIN "data/bank_069/lz_733a.bin" ; $733a, 647 bytes
Lz_69_75c1:
	INCBIN "data/bank_069/lz_75c1.bin" ; $75c1, 84 bytes
Lz_69_7615:
	INCBIN "data/bank_069/lz_7615.bin" ; $7615, 75 bytes
Data_69_7660:
	INCBIN "data/bank_069/d_7660.bin" ; $7660, 2464 bytes

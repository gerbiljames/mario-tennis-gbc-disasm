INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $73", ROMX[$4000], BANK[$73]

DataPtr_73_00:
	dw Data_73_4028 ; $4000
DataPtr_73_02:
	dw Data_73_469d ; $4002
DataPtr_73_04:
	dw Data_73_4d0d ; $4004
DataPtr_73_06:
	dw Data_73_4efd ; $4006
DataPtr_73_08:
	dw Data_73_50ed ; $4008
DataPtr_73_0a:
	dw Data_73_52dd ; $400a
DataPtr_73_0c:
	dw Data_73_54cd ; $400c
DataPtr_73_0e:
	dw Data_73_5701 ; $400e
DataPtr_73_10:
	dw Data_73_593f ; $4010
DataPtr_73_12:
	dw Data_73_5fad ; $4012
DataPtr_73_14:
	dw Data_73_6835 ; $4014
DataPtr_73_16:
	dw Data_73_6ead ; $4016
DataPtr_73_18:
	dw Data_73_751d ; $4018
DataPtr_73_1a:
	dw Data_73_75bd ; $401a
DataPtr_73_1c:
	dw Data_73_765d ; $401c
DataPtr_73_1e:
	dw Data_73_784d ; $401e
DataPtr_73_20:
	dw Data_73_78ed ; $4020
DataPtr_73_22:
	dw Data_73_798d ; $4022
DataPtr_73_24:
	dw Data_73_7a2d ; $4024
DataPtr_73_26:
	dw Data_73_7acd ; $4026
Data_73_4028:
	INCBIN "data/bank_073/d_4028.bin" ; $4028, 16 bytes
	INCBIN "data/bank_073/d_4038.bin" ; $4038, 1637 bytes
Data_73_469d:
	INCBIN "data/bank_073/d_469d.bin" ; $469d, 16 bytes
	INCBIN "data/bank_073/d_46ad.bin" ; $46ad, 1632 bytes
Data_73_4d0d:
	INCBIN "data/bank_073/d_4d0d.bin" ; $4d0d, 16 bytes
	INCBIN "data/bank_073/d_4d1d.bin" ; $4d1d, 480 bytes
Data_73_4efd:
	INCBIN "data/bank_073/d_4efd.bin" ; $4efd, 16 bytes
	INCBIN "data/bank_073/d_4f0d.bin" ; $4f0d, 480 bytes
Data_73_50ed:
	INCBIN "data/bank_073/d_50ed.bin" ; $50ed, 16 bytes
	INCBIN "data/bank_073/d_50fd.bin" ; $50fd, 480 bytes
Data_73_52dd:
	INCBIN "data/bank_073/d_52dd.bin" ; $52dd, 16 bytes
	INCBIN "data/bank_073/d_52ed.bin" ; $52ed, 480 bytes
Data_73_54cd:
	INCBIN "data/bank_073/d_54cd.bin" ; $54cd, 16 bytes
	INCBIN "data/bank_073/d_54dd.bin" ; $54dd, 548 bytes
Data_73_5701:
	INCBIN "data/bank_073/d_5701.bin" ; $5701, 16 bytes
	INCBIN "data/bank_073/d_5711.bin" ; $5711, 558 bytes
Data_73_593f:
	INCBIN "data/bank_073/d_593f.bin" ; $593f, 16 bytes
	INCBIN "data/bank_073/d_594f.bin" ; $594f, 1630 bytes
Data_73_5fad:
	INCBIN "data/bank_073/d_5fad.bin" ; $5fad, 16 bytes
	INCBIN "data/bank_073/d_5fbd.bin" ; $5fbd, 2168 bytes
Data_73_6835:
	INCBIN "data/bank_073/d_6835.bin" ; $6835, 16 bytes
	INCBIN "data/bank_073/d_6845.bin" ; $6845, 1640 bytes
Data_73_6ead:
	INCBIN "data/bank_073/d_6ead.bin" ; $6ead, 16 bytes
	INCBIN "data/bank_073/d_6ebd.bin" ; $6ebd, 1632 bytes
Data_73_751d:
	INCBIN "data/bank_073/d_751d.bin" ; $751d, 16 bytes
	INCBIN "data/bank_073/d_752d.bin" ; $752d, 144 bytes
Data_73_75bd:
	INCBIN "data/bank_073/d_75bd.bin" ; $75bd, 16 bytes
	INCBIN "data/bank_073/d_75cd.bin" ; $75cd, 144 bytes
Data_73_765d:
	INCBIN "data/bank_073/d_765d.bin" ; $765d, 16 bytes
	INCBIN "data/bank_073/d_766d.bin" ; $766d, 480 bytes
Data_73_784d:
	INCBIN "data/bank_073/d_784d.bin" ; $784d, 16 bytes
	INCBIN "data/bank_073/d_785d.bin" ; $785d, 144 bytes
Data_73_78ed:
	INCBIN "data/bank_073/d_78ed.bin" ; $78ed, 16 bytes
	INCBIN "data/bank_073/d_78fd.bin" ; $78fd, 144 bytes
Data_73_798d:
	INCBIN "data/bank_073/d_798d.bin" ; $798d, 16 bytes
	INCBIN "data/bank_073/d_799d.bin" ; $799d, 144 bytes
Data_73_7a2d:
	INCBIN "data/bank_073/d_7a2d.bin" ; $7a2d, 16 bytes
	INCBIN "data/bank_073/d_7a3d.bin" ; $7a3d, 144 bytes
Data_73_7acd:
	INCBIN "data/bank_073/d_7acd.bin" ; $7acd, 16 bytes
	INCBIN "data/bank_073/d_7add.bin" ; $7add, 144 bytes
	ds 1171, $ff ; $7b6d, fill

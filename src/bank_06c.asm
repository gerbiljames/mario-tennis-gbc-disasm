INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6c", ROMX[$4000], BANK[$6c]

DataPtr_6c_00:
	dw Lz_6c_406c ; $4000
DataPtr_6c_02:
	dw Lz_6c_4778 ; $4002
DataPtr_6c_04:
	dw Lz_6c_48af ; $4004
	INCBIN "data/bank_06c/d_4006.bin" ; $4006, 2 bytes
DataPtr_6c_08:
	dw Lz_6c_4946 ; $4008
DataPtr_6c_0a:
	dw Lz_6c_505b ; $400a
DataPtr_6c_0c:
	dw Lz_6c_50b7 ; $400c
DataPtr_6c_0e:
	dw Lz_6c_50ff ; $400e
DataPtr_6c_10:
	dw Lz_6c_515b ; $4010
DataPtr_6c_12:
	dw Lz_6c_51a6 ; $4012
DataPtr_6c_14:
	dw Lz_6c_5214 ; $4014
DataPtr_6c_16:
	dw Lz_6c_525d ; $4016
DataPtr_6c_18:
	dw Lz_6c_539e ; $4018
	INCBIN "data/bank_06c/d_401a.bin" ; $401a, 2 bytes
DataPtr_6c_1c:
	dw Lz_6c_5424 ; $401c
DataPtr_6c_1e:
	dw Lz_6c_5451 ; $401e
DataPtr_6c_20:
	dw Lz_6c_54e8 ; $4020
DataPtr_6c_22:
	dw Lz_6c_55c6 ; $4022
DataPtr_6c_24:
	dw Lz_6c_55f6 ; $4024
DataPtr_6c_26:
	dw Lz_6c_56f9 ; $4026
DataPtr_6c_28:
	dw Lz_6c_57e1 ; $4028
DataPtr_6c_2a:
	dw Lz_6c_57f1 ; $402a
DataPtr_6c_2c:
	dw Lz_6c_5c2e ; $402c
DataPtr_6c_2e:
	dw Lz_6c_5d0f ; $402e
	INCBIN "data/bank_06c/d_4030.bin" ; $4030, 2 bytes
DataPtr_6c_32:
	dw Lz_6c_5d95 ; $4032
DataPtr_6c_34:
	dw Lz_6c_61ba ; $4034
DataPtr_6c_36:
	dw Lz_6c_6264 ; $4036
	INCBIN "data/bank_06c/d_4038.bin" ; $4038, 52 bytes
Lz_6c_406c:
	INCBIN "data/bank_06c/lz_406c.bin" ; $406c, 1803 bytes
	INCBIN "data/bank_06c/d_4777.bin" ; $4777, 1 bytes
Lz_6c_4778:
	INCBIN "data/bank_06c/lz_4778.bin" ; $4778, 311 bytes
Lz_6c_48af:
	INCBIN "data/bank_06c/lz_48af.bin" ; $48af, 86 bytes
	INCBIN "data/bank_06c/d_4905.bin" ; $4905, 65 bytes
Lz_6c_4946:
	INCBIN "data/bank_06c/lz_4946.bin" ; $4946, 1812 bytes
	INCBIN "data/bank_06c/d_505a.bin" ; $505a, 1 bytes
Lz_6c_505b:
	INCBIN "data/bank_06c/lz_505b.bin" ; $505b, 91 bytes
	INCBIN "data/bank_06c/d_50b6.bin" ; $50b6, 1 bytes
Lz_6c_50b7:
	INCBIN "data/bank_06c/lz_50b7.bin" ; $50b7, 71 bytes
	INCBIN "data/bank_06c/d_50fe.bin" ; $50fe, 1 bytes
Lz_6c_50ff:
	INCBIN "data/bank_06c/lz_50ff.bin" ; $50ff, 91 bytes
	INCBIN "data/bank_06c/d_515a.bin" ; $515a, 1 bytes
Lz_6c_515b:
	INCBIN "data/bank_06c/lz_515b.bin" ; $515b, 74 bytes
	INCBIN "data/bank_06c/d_51a5.bin" ; $51a5, 1 bytes
Lz_6c_51a6:
	INCBIN "data/bank_06c/lz_51a6.bin" ; $51a6, 109 bytes
	INCBIN "data/bank_06c/d_5213.bin" ; $5213, 1 bytes
Lz_6c_5214:
	INCBIN "data/bank_06c/lz_5214.bin" ; $5214, 72 bytes
	INCBIN "data/bank_06c/d_525c.bin" ; $525c, 1 bytes
Lz_6c_525d:
	INCBIN "data/bank_06c/lz_525d.bin" ; $525d, 320 bytes
	INCBIN "data/bank_06c/d_539d.bin" ; $539d, 1 bytes
Lz_6c_539e:
	INCBIN "data/bank_06c/lz_539e.bin" ; $539e, 70 bytes
	INCBIN "data/bank_06c/d_53e4.bin" ; $53e4, 64 bytes
Lz_6c_5424:
	INCBIN "data/bank_06c/lz_5424.bin" ; $5424, 44 bytes
	INCBIN "data/bank_06c/d_5450.bin" ; $5450, 1 bytes
Lz_6c_5451:
	INCBIN "data/bank_06c/lz_5451.bin" ; $5451, 150 bytes
	INCBIN "data/bank_06c/d_54e7.bin" ; $54e7, 1 bytes
Lz_6c_54e8:
	INCBIN "data/bank_06c/lz_54e8.bin" ; $54e8, 221 bytes
	INCBIN "data/bank_06c/d_55c5.bin" ; $55c5, 1 bytes
Lz_6c_55c6:
	INCBIN "data/bank_06c/lz_55c6.bin" ; $55c6, 47 bytes
	INCBIN "data/bank_06c/d_55f5.bin" ; $55f5, 1 bytes
Lz_6c_55f6:
	INCBIN "data/bank_06c/lz_55f6.bin" ; $55f6, 258 bytes
	INCBIN "data/bank_06c/d_56f8.bin" ; $56f8, 1 bytes
Lz_6c_56f9:
	INCBIN "data/bank_06c/lz_56f9.bin" ; $56f9, 231 bytes
	INCBIN "data/bank_06c/d_57e0.bin" ; $57e0, 1 bytes
Lz_6c_57e1:
	INCBIN "data/bank_06c/lz_57e1.bin" ; $57e1, 15 bytes
	INCBIN "data/bank_06c/d_57f0.bin" ; $57f0, 1 bytes
Lz_6c_57f1:
	INCBIN "data/bank_06c/lz_57f1.bin" ; $57f1, 1085 bytes
Lz_6c_5c2e:
	INCBIN "data/bank_06c/lz_5c2e.bin" ; $5c2e, 224 bytes
	INCBIN "data/bank_06c/d_5d0e.bin" ; $5d0e, 1 bytes
Lz_6c_5d0f:
	INCBIN "data/bank_06c/lz_5d0f.bin" ; $5d0f, 70 bytes
	INCBIN "data/bank_06c/d_5d55.bin" ; $5d55, 64 bytes
Lz_6c_5d95:
	INCBIN "data/bank_06c/lz_5d95.bin" ; $5d95, 1061 bytes
Lz_6c_61ba:
	INCBIN "data/bank_06c/lz_61ba.bin" ; $61ba, 169 bytes
	INCBIN "data/bank_06c/d_6263.bin" ; $6263, 1 bytes
Lz_6c_6264:
	INCBIN "data/bank_06c/lz_6264.bin" ; $6264, 73 bytes
	INCBIN "data/bank_06c/d_62ad.bin" ; $62ad, 7507 bytes

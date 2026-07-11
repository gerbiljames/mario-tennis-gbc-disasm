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
	db $03, $04, $02, $00 ; count, flags
	dw $4032, $4650, $4032, $4050, $4150, $4250 ; body pointers
	INCBIN "data/bank_073/d_4038.bin" ; $4038, 1637 bytes
Data_73_469d:
	db $07, $04, $02, $00 ; count, flags
	dw $46a7, $4cc0, $46a7, $46c0, $47c0, $48c0 ; body pointers
	INCBIN "data/bank_073/d_46ad.bin" ; $46ad, 1632 bytes
Data_73_4d0d:
	db $03, $01, $02, $00 ; count, flags
	dw $4d17, $4eb0, $4d17, $4d30, $4d70, $4db0 ; body pointers
	INCBIN "data/bank_073/d_4d1d.bin" ; $4d1d, 480 bytes
Data_73_4efd:
	db $03, $01, $02, $00 ; count, flags
	dw $4f07, $50a0, $4f07, $4f20, $4f60, $4fa0 ; body pointers
	INCBIN "data/bank_073/d_4f0d.bin" ; $4f0d, 480 bytes
Data_73_50ed:
	db $03, $01, $02, $00 ; count, flags
	dw $50f7, $5290, $50f7, $5110, $5150, $5190 ; body pointers
	INCBIN "data/bank_073/d_50fd.bin" ; $50fd, 480 bytes
Data_73_52dd:
	db $03, $01, $02, $00 ; count, flags
	dw $52e7, $5480, $52e7, $5300, $5340, $5380 ; body pointers
	INCBIN "data/bank_073/d_52ed.bin" ; $52ed, 480 bytes
Data_73_54cd:
	db $04, $01, $02, $00 ; count, flags
	dw $54d7, $56b0, $54d7, $54f0, $5530, $5570 ; body pointers
	INCBIN "data/bank_073/d_54dd.bin" ; $54dd, 548 bytes
Data_73_5701:
	db $03, $01, $02, $00 ; count, flags
	dw $570b, $58f0, $570b, $5730, $5770, $57b0 ; body pointers
	INCBIN "data/bank_073/d_5711.bin" ; $5711, 558 bytes
Data_73_593f:
	db $05, $04, $02, $00 ; count, flags
	dw $5949, $5f60, $5949, $5960, $5a60, $5b60 ; body pointers
	INCBIN "data/bank_073/d_594f.bin" ; $594f, 1630 bytes
Data_73_5fad:
	db $05, $04, $02, $00 ; count, flags
	dw $5fb7, $67e0, $5fb7, $5fe0, $60e0, $61e0 ; body pointers
	INCBIN "data/bank_073/d_5fbd.bin" ; $5fbd, 2168 bytes
Data_73_6835:
	db $04, $04, $02, $00 ; count, flags
	dw $683f, $6e60, $683f, $6860, $6960, $6a60 ; body pointers
	INCBIN "data/bank_073/d_6845.bin" ; $6845, 1640 bytes
Data_73_6ead:
	db $03, $04, $02, $00 ; count, flags
	dw $6eb7, $74d0, $6eb7, $6ed0, $6fd0, $70d0 ; body pointers
	INCBIN "data/bank_073/d_6ebd.bin" ; $6ebd, 1632 bytes
Data_73_751d:
	db $03, $01, $02, $00 ; count, flags
	dw $7527, $75b0, $7527, $7530, $7570, $0000 ; body pointers
	INCBIN "data/bank_073/d_752d.bin" ; $752d, 144 bytes
Data_73_75bd:
	db $03, $01, $02, $00 ; count, flags
	dw $75c7, $7650, $75c7, $75d0, $7610, $0000 ; body pointers
	INCBIN "data/bank_073/d_75cd.bin" ; $75cd, 144 bytes
Data_73_765d:
	db $03, $01, $02, $00 ; count, flags
	dw $7667, $7800, $7667, $7680, $76c0, $7700 ; body pointers
	INCBIN "data/bank_073/d_766d.bin" ; $766d, 480 bytes
Data_73_784d:
	db $03, $01, $02, $00 ; count, flags
	dw $7857, $78e0, $7857, $7860, $78a0, $0000 ; body pointers
	INCBIN "data/bank_073/d_785d.bin" ; $785d, 144 bytes
Data_73_78ed:
	db $03, $01, $02, $00 ; count, flags
	dw $78f7, $7980, $78f7, $7900, $7940, $0000 ; body pointers
	INCBIN "data/bank_073/d_78fd.bin" ; $78fd, 144 bytes
Data_73_798d:
	db $03, $01, $02, $00 ; count, flags
	dw $7997, $7a20, $7997, $79a0, $79e0, $0000 ; body pointers
	INCBIN "data/bank_073/d_799d.bin" ; $799d, 144 bytes
Data_73_7a2d:
	db $03, $01, $02, $00 ; count, flags
	dw $7a37, $7ac0, $7a37, $7a40, $7a80, $0000 ; body pointers
	INCBIN "data/bank_073/d_7a3d.bin" ; $7a3d, 144 bytes
Data_73_7acd:
	db $03, $01, $02, $00 ; count, flags
	dw $7ad7, $7b60, $7ad7, $7ae0, $7b20, $0000 ; body pointers
	INCBIN "data/bank_073/d_7add.bin" ; $7add, 144 bytes
	ds 1171, $ff ; $7b6d, fill

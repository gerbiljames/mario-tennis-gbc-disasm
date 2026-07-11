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
	dw $4032, Data_73_4650, $4032, Data_73_4050, Data_73_4150, Data_73_4250 ; body pointers
	INCBIN "data/bank_073/d_4038.bin" ; $4038, 24 bytes
Data_73_4050:
	INCBIN "data/bank_073/d_4050.bin" ; $4050, 256 bytes
Data_73_4150:
	INCBIN "data/bank_073/d_4150.bin" ; $4150, 256 bytes
Data_73_4250:
	INCBIN "data/bank_073/d_4250.bin" ; $4250, 1024 bytes
Data_73_4650:
	INCBIN "data/bank_073/d_4650.bin" ; $4650, 77 bytes
Data_73_469d:
	db $07, $04, $02, $00 ; count, flags
	dw $46a7, Data_73_4cc0, $46a7, Data_73_46c0, Data_73_47c0, Data_73_48c0 ; body pointers
	INCBIN "data/bank_073/d_46ad.bin" ; $46ad, 19 bytes
Data_73_46c0:
	INCBIN "data/bank_073/d_46c0.bin" ; $46c0, 256 bytes
Data_73_47c0:
	INCBIN "data/bank_073/d_47c0.bin" ; $47c0, 256 bytes
Data_73_48c0:
	INCBIN "data/bank_073/d_48c0.bin" ; $48c0, 1024 bytes
Data_73_4cc0:
	INCBIN "data/bank_073/d_4cc0.bin" ; $4cc0, 77 bytes
Data_73_4d0d:
	db $03, $01, $02, $00 ; count, flags
	dw $4d17, Data_73_4eb0, $4d17, Data_73_4d30, Data_73_4d70, Data_73_4db0 ; body pointers
	INCBIN "data/bank_073/d_4d1d.bin" ; $4d1d, 19 bytes
Data_73_4d30:
	INCBIN "data/bank_073/d_4d30.bin" ; $4d30, 64 bytes
Data_73_4d70:
	INCBIN "data/bank_073/d_4d70.bin" ; $4d70, 64 bytes
Data_73_4db0:
	INCBIN "data/bank_073/d_4db0.bin" ; $4db0, 256 bytes
Data_73_4eb0:
	INCBIN "data/bank_073/d_4eb0.bin" ; $4eb0, 77 bytes
Data_73_4efd:
	db $03, $01, $02, $00 ; count, flags
	dw $4f07, Data_73_50a0, $4f07, Data_73_4f20, Data_73_4f60, Data_73_4fa0 ; body pointers
	INCBIN "data/bank_073/d_4f0d.bin" ; $4f0d, 19 bytes
Data_73_4f20:
	INCBIN "data/bank_073/d_4f20.bin" ; $4f20, 64 bytes
Data_73_4f60:
	INCBIN "data/bank_073/d_4f60.bin" ; $4f60, 64 bytes
Data_73_4fa0:
	INCBIN "data/bank_073/d_4fa0.bin" ; $4fa0, 256 bytes
Data_73_50a0:
	INCBIN "data/bank_073/d_50a0.bin" ; $50a0, 77 bytes
Data_73_50ed:
	db $03, $01, $02, $00 ; count, flags
	dw $50f7, Data_73_5290, $50f7, Data_73_5110, Data_73_5150, Data_73_5190 ; body pointers
	INCBIN "data/bank_073/d_50fd.bin" ; $50fd, 19 bytes
Data_73_5110:
	INCBIN "data/bank_073/d_5110.bin" ; $5110, 64 bytes
Data_73_5150:
	INCBIN "data/bank_073/d_5150.bin" ; $5150, 64 bytes
Data_73_5190:
	INCBIN "data/bank_073/d_5190.bin" ; $5190, 256 bytes
Data_73_5290:
	INCBIN "data/bank_073/d_5290.bin" ; $5290, 77 bytes
Data_73_52dd:
	db $03, $01, $02, $00 ; count, flags
	dw $52e7, Data_73_5480, $52e7, Data_73_5300, Data_73_5340, Data_73_5380 ; body pointers
	INCBIN "data/bank_073/d_52ed.bin" ; $52ed, 19 bytes
Data_73_5300:
	INCBIN "data/bank_073/d_5300.bin" ; $5300, 64 bytes
Data_73_5340:
	INCBIN "data/bank_073/d_5340.bin" ; $5340, 64 bytes
Data_73_5380:
	INCBIN "data/bank_073/d_5380.bin" ; $5380, 256 bytes
Data_73_5480:
	INCBIN "data/bank_073/d_5480.bin" ; $5480, 77 bytes
Data_73_54cd:
	db $04, $01, $02, $00 ; count, flags
	dw $54d7, Data_73_56b0, $54d7, Data_73_54f0, Data_73_5530, Data_73_5570 ; body pointers
	INCBIN "data/bank_073/d_54dd.bin" ; $54dd, 19 bytes
Data_73_54f0:
	INCBIN "data/bank_073/d_54f0.bin" ; $54f0, 64 bytes
Data_73_5530:
	INCBIN "data/bank_073/d_5530.bin" ; $5530, 64 bytes
Data_73_5570:
	INCBIN "data/bank_073/d_5570.bin" ; $5570, 320 bytes
Data_73_56b0:
	INCBIN "data/bank_073/d_56b0.bin" ; $56b0, 81 bytes
Data_73_5701:
	db $03, $01, $02, $00 ; count, flags
	dw $570b, Data_73_58f0, $570b, Data_73_5730, Data_73_5770, Data_73_57b0 ; body pointers
	INCBIN "data/bank_073/d_5711.bin" ; $5711, 31 bytes
Data_73_5730:
	INCBIN "data/bank_073/d_5730.bin" ; $5730, 64 bytes
Data_73_5770:
	INCBIN "data/bank_073/d_5770.bin" ; $5770, 64 bytes
Data_73_57b0:
	INCBIN "data/bank_073/d_57b0.bin" ; $57b0, 320 bytes
Data_73_58f0:
	INCBIN "data/bank_073/d_58f0.bin" ; $58f0, 79 bytes
Data_73_593f:
	db $05, $04, $02, $00 ; count, flags
	dw $5949, Data_73_5f60, $5949, Data_73_5960, Data_73_5a60, Data_73_5b60 ; body pointers
	INCBIN "data/bank_073/d_594f.bin" ; $594f, 17 bytes
Data_73_5960:
	INCBIN "data/bank_073/d_5960.bin" ; $5960, 256 bytes
Data_73_5a60:
	INCBIN "data/bank_073/d_5a60.bin" ; $5a60, 256 bytes
Data_73_5b60:
	INCBIN "data/bank_073/d_5b60.bin" ; $5b60, 1024 bytes
Data_73_5f60:
	INCBIN "data/bank_073/d_5f60.bin" ; $5f60, 77 bytes
Data_73_5fad:
	db $05, $04, $02, $00 ; count, flags
	dw $5fb7, Data_73_67e0, $5fb7, Data_73_5fe0, Data_73_60e0, Data_73_61e0 ; body pointers
	INCBIN "data/bank_073/d_5fbd.bin" ; $5fbd, 35 bytes
Data_73_5fe0:
	INCBIN "data/bank_073/d_5fe0.bin" ; $5fe0, 256 bytes
Data_73_60e0:
	INCBIN "data/bank_073/d_60e0.bin" ; $60e0, 256 bytes
Data_73_61e0:
	INCBIN "data/bank_073/d_61e0.bin" ; $61e0, 1536 bytes
Data_73_67e0:
	INCBIN "data/bank_073/d_67e0.bin" ; $67e0, 85 bytes
Data_73_6835:
	db $04, $04, $02, $00 ; count, flags
	dw $683f, Data_73_6e60, $683f, Data_73_6860, Data_73_6960, Data_73_6a60 ; body pointers
	INCBIN "data/bank_073/d_6845.bin" ; $6845, 27 bytes
Data_73_6860:
	INCBIN "data/bank_073/d_6860.bin" ; $6860, 256 bytes
Data_73_6960:
	INCBIN "data/bank_073/d_6960.bin" ; $6960, 256 bytes
Data_73_6a60:
	INCBIN "data/bank_073/d_6a60.bin" ; $6a60, 1024 bytes
Data_73_6e60:
	INCBIN "data/bank_073/d_6e60.bin" ; $6e60, 77 bytes
Data_73_6ead:
	db $03, $04, $02, $00 ; count, flags
	dw $6eb7, Data_73_74d0, $6eb7, Data_73_6ed0, Data_73_6fd0, Data_73_70d0 ; body pointers
	INCBIN "data/bank_073/d_6ebd.bin" ; $6ebd, 19 bytes
Data_73_6ed0:
	INCBIN "data/bank_073/d_6ed0.bin" ; $6ed0, 256 bytes
Data_73_6fd0:
	INCBIN "data/bank_073/d_6fd0.bin" ; $6fd0, 256 bytes
Data_73_70d0:
	INCBIN "data/bank_073/d_70d0.bin" ; $70d0, 1024 bytes
Data_73_74d0:
	INCBIN "data/bank_073/d_74d0.bin" ; $74d0, 77 bytes
Data_73_751d:
	db $03, $01, $02, $00 ; count, flags
	dw $7527, Data_73_75b0, $7527, Data_73_7530, Data_73_7570, $0000 ; body pointers
	INCBIN "data/bank_073/d_752d.bin" ; $752d, 3 bytes
Data_73_7530:
	INCBIN "data/bank_073/d_7530.bin" ; $7530, 64 bytes
Data_73_7570:
	INCBIN "data/bank_073/d_7570.bin" ; $7570, 64 bytes
Data_73_75b0:
	INCBIN "data/bank_073/d_75b0.bin" ; $75b0, 13 bytes
Data_73_75bd:
	db $03, $01, $02, $00 ; count, flags
	dw $75c7, Data_73_7650, $75c7, Data_73_75d0, Data_73_7610, $0000 ; body pointers
	INCBIN "data/bank_073/d_75cd.bin" ; $75cd, 3 bytes
Data_73_75d0:
	INCBIN "data/bank_073/d_75d0.bin" ; $75d0, 64 bytes
Data_73_7610:
	INCBIN "data/bank_073/d_7610.bin" ; $7610, 64 bytes
Data_73_7650:
	INCBIN "data/bank_073/d_7650.bin" ; $7650, 13 bytes
Data_73_765d:
	db $03, $01, $02, $00 ; count, flags
	dw $7667, Data_73_7800, $7667, Data_73_7680, Data_73_76c0, Data_73_7700 ; body pointers
	INCBIN "data/bank_073/d_766d.bin" ; $766d, 19 bytes
Data_73_7680:
	INCBIN "data/bank_073/d_7680.bin" ; $7680, 64 bytes
Data_73_76c0:
	INCBIN "data/bank_073/d_76c0.bin" ; $76c0, 64 bytes
Data_73_7700:
	INCBIN "data/bank_073/d_7700.bin" ; $7700, 256 bytes
Data_73_7800:
	INCBIN "data/bank_073/d_7800.bin" ; $7800, 77 bytes
Data_73_784d:
	db $03, $01, $02, $00 ; count, flags
	dw $7857, Data_73_78e0, $7857, Data_73_7860, Data_73_78a0, $0000 ; body pointers
	INCBIN "data/bank_073/d_785d.bin" ; $785d, 3 bytes
Data_73_7860:
	INCBIN "data/bank_073/d_7860.bin" ; $7860, 64 bytes
Data_73_78a0:
	INCBIN "data/bank_073/d_78a0.bin" ; $78a0, 64 bytes
Data_73_78e0:
	INCBIN "data/bank_073/d_78e0.bin" ; $78e0, 13 bytes
Data_73_78ed:
	db $03, $01, $02, $00 ; count, flags
	dw $78f7, Data_73_7980, $78f7, Data_73_7900, Data_73_7940, $0000 ; body pointers
	INCBIN "data/bank_073/d_78fd.bin" ; $78fd, 3 bytes
Data_73_7900:
	INCBIN "data/bank_073/d_7900.bin" ; $7900, 64 bytes
Data_73_7940:
	INCBIN "data/bank_073/d_7940.bin" ; $7940, 64 bytes
Data_73_7980:
	INCBIN "data/bank_073/d_7980.bin" ; $7980, 13 bytes
Data_73_798d:
	db $03, $01, $02, $00 ; count, flags
	dw $7997, Data_73_7a20, $7997, Data_73_79a0, Data_73_79e0, $0000 ; body pointers
	INCBIN "data/bank_073/d_799d.bin" ; $799d, 3 bytes
Data_73_79a0:
	INCBIN "data/bank_073/d_79a0.bin" ; $79a0, 64 bytes
Data_73_79e0:
	INCBIN "data/bank_073/d_79e0.bin" ; $79e0, 64 bytes
Data_73_7a20:
	INCBIN "data/bank_073/d_7a20.bin" ; $7a20, 13 bytes
Data_73_7a2d:
	db $03, $01, $02, $00 ; count, flags
	dw $7a37, Data_73_7ac0, $7a37, Data_73_7a40, Data_73_7a80, $0000 ; body pointers
	INCBIN "data/bank_073/d_7a3d.bin" ; $7a3d, 3 bytes
Data_73_7a40:
	INCBIN "data/bank_073/d_7a40.bin" ; $7a40, 64 bytes
Data_73_7a80:
	INCBIN "data/bank_073/d_7a80.bin" ; $7a80, 64 bytes
Data_73_7ac0:
	INCBIN "data/bank_073/d_7ac0.bin" ; $7ac0, 13 bytes
Data_73_7acd:
	db $03, $01, $02, $00 ; count, flags
	dw $7ad7, Data_73_7b60, $7ad7, Data_73_7ae0, Data_73_7b20, $0000 ; body pointers
	INCBIN "data/bank_073/d_7add.bin" ; $7add, 3 bytes
Data_73_7ae0:
	INCBIN "data/bank_073/d_7ae0.bin" ; $7ae0, 64 bytes
Data_73_7b20:
	INCBIN "data/bank_073/d_7b20.bin" ; $7b20, 64 bytes
Data_73_7b60:
	INCBIN "data/bank_073/d_7b60.bin" ; $7b60, 13 bytes
	ds 1171, $ff ; $7b6d, fill

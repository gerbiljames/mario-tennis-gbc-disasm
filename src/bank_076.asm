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
	db $07, $04, $02, $00 ; count, flags
	dw $4018, Data_76_4630, $4018, Data_76_4030, Data_76_4130, Data_76_4230 ; body pointers
	INCBIN "data/bank_076/d_401e.bin" ; $401e, 18 bytes
Data_76_4030:
	INCBIN "data/bank_076/d_4030.bin" ; $4030, 256 bytes
Data_76_4130:
	INCBIN "data/bank_076/d_4130.bin" ; $4130, 256 bytes
Data_76_4230:
	INCBIN "data/bank_076/d_4230.bin" ; $4230, 1024 bytes
Data_76_4630:
	INCBIN "data/bank_076/d_4630.bin" ; $4630, 77 bytes
Data_76_467d:
	db $07, $04, $02, $00 ; count, flags
	dw $4687, Data_76_4ca0, $4687, Data_76_46a0, Data_76_47a0, Data_76_48a0 ; body pointers
	INCBIN "data/bank_076/d_468d.bin" ; $468d, 19 bytes
Data_76_46a0:
	INCBIN "data/bank_076/d_46a0.bin" ; $46a0, 256 bytes
Data_76_47a0:
	INCBIN "data/bank_076/d_47a0.bin" ; $47a0, 256 bytes
Data_76_48a0:
	INCBIN "data/bank_076/d_48a0.bin" ; $48a0, 1024 bytes
Data_76_4ca0:
	INCBIN "data/bank_076/d_4ca0.bin" ; $4ca0, 77 bytes
Data_76_4ced:
	db $07, $04, $02, $00 ; count, flags
	dw $4cf7, Data_76_5710, $4cf7, Data_76_4d10, Data_76_4e10, Data_76_4f10 ; body pointers
	INCBIN "data/bank_076/d_4cfd.bin" ; $4cfd, 19 bytes
Data_76_4d10:
	INCBIN "data/bank_076/d_4d10.bin" ; $4d10, 256 bytes
Data_76_4e10:
	INCBIN "data/bank_076/d_4e10.bin" ; $4e10, 256 bytes
Data_76_4f10:
	INCBIN "data/bank_076/d_4f10.bin" ; $4f10, 2048 bytes
Data_76_5710:
	INCBIN "data/bank_076/d_5710.bin" ; $5710, 100 bytes
Data_76_5774:
	db $07, $04, $02, $00 ; count, flags
	dw $577e, Data_76_5da0, $577e, Data_76_57a0, Data_76_58a0, Data_76_59a0 ; body pointers
	INCBIN "data/bank_076/d_5784.bin" ; $5784, 28 bytes
Data_76_57a0:
	INCBIN "data/bank_076/d_57a0.bin" ; $57a0, 256 bytes
Data_76_58a0:
	INCBIN "data/bank_076/d_58a0.bin" ; $58a0, 256 bytes
Data_76_59a0:
	INCBIN "data/bank_076/d_59a0.bin" ; $59a0, 1024 bytes
Data_76_5da0:
	INCBIN "data/bank_076/d_5da0.bin" ; $5da0, 77 bytes
Data_76_5ded:
	db $07, $04, $02, $00 ; count, flags
	dw $5df7, Data_76_6810, $5df7, Data_76_5e10, Data_76_5f10, Data_76_6010 ; body pointers
	INCBIN "data/bank_076/d_5dfd.bin" ; $5dfd, 19 bytes
Data_76_5e10:
	INCBIN "data/bank_076/d_5e10.bin" ; $5e10, 256 bytes
Data_76_5f10:
	INCBIN "data/bank_076/d_5f10.bin" ; $5f10, 256 bytes
Data_76_6010:
	INCBIN "data/bank_076/d_6010.bin" ; $6010, 2048 bytes
Data_76_6810:
	INCBIN "data/bank_076/d_6810.bin" ; $6810, 90 bytes
Data_76_686a:
	db $07, $04, $02, $00 ; count, flags
	dw $6874, Data_76_7290, $6874, Data_76_6890, Data_76_6990, Data_76_6a90 ; body pointers
	INCBIN "data/bank_076/d_687a.bin" ; $687a, 22 bytes
Data_76_6890:
	INCBIN "data/bank_076/d_6890.bin" ; $6890, 256 bytes
Data_76_6990:
	INCBIN "data/bank_076/d_6990.bin" ; $6990, 256 bytes
Data_76_6a90:
	INCBIN "data/bank_076/d_6a90.bin" ; $6a90, 2048 bytes
Data_76_7290:
	INCBIN "data/bank_076/d_7290.bin" ; $7290, 90 bytes
Data_76_72ea:
	db $04, $01, $02, $00 ; count, flags
	dw $72f4, Data_76_7490, $72f4, Data_76_7310, Data_76_7350, Data_76_7390 ; body pointers
	INCBIN "data/bank_076/d_72fa.bin" ; $72fa, 22 bytes
Data_76_7310:
	INCBIN "data/bank_076/d_7310.bin" ; $7310, 64 bytes
Data_76_7350:
	INCBIN "data/bank_076/d_7350.bin" ; $7350, 64 bytes
Data_76_7390:
	INCBIN "data/bank_076/d_7390.bin" ; $7390, 256 bytes
Data_76_7490:
	INCBIN "data/bank_076/d_7490.bin" ; $7490, 77 bytes
	ds 2851, $ff ; $74dd, fill

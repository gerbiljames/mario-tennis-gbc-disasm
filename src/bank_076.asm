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
	dw $4018, $4630, $4018, $4030, $4130, $4230 ; body pointers
	INCBIN "data/bank_076/d_401e.bin" ; $401e, 1631 bytes
Data_76_467d:
	db $07, $04, $02, $00 ; count, flags
	dw $4687, $4ca0, $4687, $46a0, $47a0, $48a0 ; body pointers
	INCBIN "data/bank_076/d_468d.bin" ; $468d, 1632 bytes
Data_76_4ced:
	db $07, $04, $02, $00 ; count, flags
	dw $4cf7, $5710, $4cf7, $4d10, $4e10, $4f10 ; body pointers
	INCBIN "data/bank_076/d_4cfd.bin" ; $4cfd, 2679 bytes
Data_76_5774:
	db $07, $04, $02, $00 ; count, flags
	dw $577e, $5da0, $577e, $57a0, $58a0, $59a0 ; body pointers
	INCBIN "data/bank_076/d_5784.bin" ; $5784, 1641 bytes
Data_76_5ded:
	db $07, $04, $02, $00 ; count, flags
	dw $5df7, $6810, $5df7, $5e10, $5f10, $6010 ; body pointers
	INCBIN "data/bank_076/d_5dfd.bin" ; $5dfd, 2669 bytes
Data_76_686a:
	db $07, $04, $02, $00 ; count, flags
	dw $6874, $7290, $6874, $6890, $6990, $6a90 ; body pointers
	INCBIN "data/bank_076/d_687a.bin" ; $687a, 2672 bytes
Data_76_72ea:
	db $04, $01, $02, $00 ; count, flags
	dw $72f4, $7490, $72f4, $7310, $7350, $7390 ; body pointers
	INCBIN "data/bank_076/d_72fa.bin" ; $72fa, 483 bytes
	ds 2851, $ff ; $74dd, fill

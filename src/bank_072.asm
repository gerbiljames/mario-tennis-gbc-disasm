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
	db $07, $04, $02, $00 ; count, flags
	dw $401c, Data_72_4630, $401c, Data_72_4030, Data_72_4130, Data_72_4230 ; body pointers
	INCBIN "data/bank_072/d_4022.bin" ; $4022, 14 bytes
Data_72_4030:
	INCBIN "data/bank_072/d_4030.bin" ; $4030, 256 bytes
Data_72_4130:
	INCBIN "data/bank_072/d_4130.bin" ; $4130, 256 bytes
Data_72_4230:
	INCBIN "data/bank_072/d_4230.bin" ; $4230, 1024 bytes
Data_72_4630:
	INCBIN "data/bank_072/d_4630.bin" ; $4630, 77 bytes
Data_72_467d:
	db $07, $04, $02, $00 ; count, flags
	dw $4687, Data_72_4ca0, $4687, Data_72_46a0, Data_72_47a0, Data_72_48a0 ; body pointers
	INCBIN "data/bank_072/d_468d.bin" ; $468d, 19 bytes
Data_72_46a0:
	INCBIN "data/bank_072/d_46a0.bin" ; $46a0, 256 bytes
Data_72_47a0:
	INCBIN "data/bank_072/d_47a0.bin" ; $47a0, 256 bytes
Data_72_48a0:
	INCBIN "data/bank_072/d_48a0.bin" ; $48a0, 1024 bytes
Data_72_4ca0:
	INCBIN "data/bank_072/d_4ca0.bin" ; $4ca0, 77 bytes
Data_72_4ced:
	db $03, $04, $02, $00 ; count, flags
	dw $4cf7, Data_72_5610, $4cf7, Data_72_4d10, Data_72_4e10, Data_72_4f10 ; body pointers
	INCBIN "data/bank_072/d_4cfd.bin" ; $4cfd, 19 bytes
Data_72_4d10:
	INCBIN "data/bank_072/d_4d10.bin" ; $4d10, 256 bytes
Data_72_4e10:
	INCBIN "data/bank_072/d_4e10.bin" ; $4e10, 256 bytes
Data_72_4f10:
	INCBIN "data/bank_072/d_4f10.bin" ; $4f10, 1792 bytes
Data_72_5610:
	INCBIN "data/bank_072/d_5610.bin" ; $5610, 90 bytes
Data_72_566a:
	db $06, $04, $02, $00 ; count, flags
	dw $5674, Data_72_5c90, $5674, Data_72_5690, Data_72_5790, Data_72_5890 ; body pointers
	INCBIN "data/bank_072/d_567a.bin" ; $567a, 22 bytes
Data_72_5690:
	INCBIN "data/bank_072/d_5690.bin" ; $5690, 256 bytes
Data_72_5790:
	INCBIN "data/bank_072/d_5790.bin" ; $5790, 256 bytes
Data_72_5890:
	INCBIN "data/bank_072/d_5890.bin" ; $5890, 1024 bytes
Data_72_5c90:
	INCBIN "data/bank_072/d_5c90.bin" ; $5c90, 77 bytes
Data_72_5cdd:
	db $07, $04, $02, $00 ; count, flags
	dw $5ce7, Data_72_6300, $5ce7, Data_72_5d00, Data_72_5e00, Data_72_5f00 ; body pointers
	INCBIN "data/bank_072/d_5ced.bin" ; $5ced, 19 bytes
Data_72_5d00:
	INCBIN "data/bank_072/d_5d00.bin" ; $5d00, 256 bytes
Data_72_5e00:
	INCBIN "data/bank_072/d_5e00.bin" ; $5e00, 256 bytes
Data_72_5f00:
	INCBIN "data/bank_072/d_5f00.bin" ; $5f00, 1024 bytes
Data_72_6300:
	INCBIN "data/bank_072/d_6300.bin" ; $6300, 77 bytes
Data_72_634d:
	db $07, $04, $02, $00 ; count, flags
	dw $6357, Data_72_6970, $6357, Data_72_6370, Data_72_6470, Data_72_6570 ; body pointers
	INCBIN "data/bank_072/d_635d.bin" ; $635d, 19 bytes
Data_72_6370:
	INCBIN "data/bank_072/d_6370.bin" ; $6370, 256 bytes
Data_72_6470:
	INCBIN "data/bank_072/d_6470.bin" ; $6470, 256 bytes
Data_72_6570:
	INCBIN "data/bank_072/d_6570.bin" ; $6570, 1024 bytes
Data_72_6970:
	INCBIN "data/bank_072/d_6970.bin" ; $6970, 77 bytes
Data_72_69bd:
	db $03, $04, $02, $00 ; count, flags
	dw $69c7, Data_72_6fe0, $69c7, Data_72_69e0, Data_72_6ae0, Data_72_6be0 ; body pointers
	INCBIN "data/bank_072/d_69cd.bin" ; $69cd, 19 bytes
Data_72_69e0:
	INCBIN "data/bank_072/d_69e0.bin" ; $69e0, 256 bytes
Data_72_6ae0:
	INCBIN "data/bank_072/d_6ae0.bin" ; $6ae0, 256 bytes
Data_72_6be0:
	INCBIN "data/bank_072/d_6be0.bin" ; $6be0, 1024 bytes
Data_72_6fe0:
	INCBIN "data/bank_072/d_6fe0.bin" ; $6fe0, 77 bytes
Data_72_702d:
	db $04, $04, $02, $00 ; count, flags
	dw $7037, Data_72_7650, $7037, Data_72_7050, Data_72_7150, Data_72_7250 ; body pointers
	INCBIN "data/bank_072/d_703d.bin" ; $703d, 19 bytes
Data_72_7050:
	INCBIN "data/bank_072/d_7050.bin" ; $7050, 256 bytes
Data_72_7150:
	INCBIN "data/bank_072/d_7150.bin" ; $7150, 256 bytes
Data_72_7250:
	INCBIN "data/bank_072/d_7250.bin" ; $7250, 1024 bytes
Data_72_7650:
	INCBIN "data/bank_072/d_7650.bin" ; $7650, 77 bytes
Data_72_769d:
	db $05, $04, $02, $00 ; count, flags
	dw $76a7, Data_72_7cc0, $76a7, Data_72_76c0, Data_72_77c0, Data_72_78c0 ; body pointers
	INCBIN "data/bank_072/d_76ad.bin" ; $76ad, 19 bytes
Data_72_76c0:
	INCBIN "data/bank_072/d_76c0.bin" ; $76c0, 256 bytes
Data_72_77c0:
	INCBIN "data/bank_072/d_77c0.bin" ; $77c0, 256 bytes
Data_72_78c0:
	INCBIN "data/bank_072/d_78c0.bin" ; $78c0, 1024 bytes
Data_72_7cc0:
	INCBIN "data/bank_072/d_7cc0.bin" ; $7cc0, 77 bytes
	ds 755, $ff ; $7d0d, fill

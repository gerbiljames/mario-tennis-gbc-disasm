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
	dw $401c, $4630, $401c, $4030, $4130, $4230 ; body pointers
	INCBIN "data/bank_072/d_4022.bin" ; $4022, 1627 bytes
Data_72_467d:
	db $07, $04, $02, $00 ; count, flags
	dw $4687, $4ca0, $4687, $46a0, $47a0, $48a0 ; body pointers
	INCBIN "data/bank_072/d_468d.bin" ; $468d, 1632 bytes
Data_72_4ced:
	db $03, $04, $02, $00 ; count, flags
	dw $4cf7, $5610, $4cf7, $4d10, $4e10, $4f10 ; body pointers
	INCBIN "data/bank_072/d_4cfd.bin" ; $4cfd, 2413 bytes
Data_72_566a:
	db $06, $04, $02, $00 ; count, flags
	dw $5674, $5c90, $5674, $5690, $5790, $5890 ; body pointers
	INCBIN "data/bank_072/d_567a.bin" ; $567a, 1635 bytes
Data_72_5cdd:
	db $07, $04, $02, $00 ; count, flags
	dw $5ce7, $6300, $5ce7, $5d00, $5e00, $5f00 ; body pointers
	INCBIN "data/bank_072/d_5ced.bin" ; $5ced, 1632 bytes
Data_72_634d:
	db $07, $04, $02, $00 ; count, flags
	dw $6357, $6970, $6357, $6370, $6470, $6570 ; body pointers
	INCBIN "data/bank_072/d_635d.bin" ; $635d, 1632 bytes
Data_72_69bd:
	db $03, $04, $02, $00 ; count, flags
	dw $69c7, $6fe0, $69c7, $69e0, $6ae0, $6be0 ; body pointers
	INCBIN "data/bank_072/d_69cd.bin" ; $69cd, 1632 bytes
Data_72_702d:
	db $04, $04, $02, $00 ; count, flags
	dw $7037, $7650, $7037, $7050, $7150, $7250 ; body pointers
	INCBIN "data/bank_072/d_703d.bin" ; $703d, 1632 bytes
Data_72_769d:
	db $05, $04, $02, $00 ; count, flags
	dw $76a7, $7cc0, $76a7, $76c0, $77c0, $78c0 ; body pointers
	INCBIN "data/bank_072/d_76ad.bin" ; $76ad, 1632 bytes
	ds 755, $ff ; $7d0d, fill

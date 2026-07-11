INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $75", ROMX[$4000], BANK[$75]

DataPtr_75_00:
	dw Data_75_4012 ; $4000
DataPtr_75_02:
	dw Data_75_467d ; $4002
DataPtr_75_04:
	dw Data_75_4ced ; $4004
DataPtr_75_06:
	dw Data_75_535d ; $4006
DataPtr_75_08:
	dw Data_75_59cd ; $4008
DataPtr_75_0a:
	dw Data_75_603d ; $400a
DataPtr_75_0c:
	dw Data_75_66ad ; $400c
DataPtr_75_0e:
	dw Data_75_6d2b ; $400e
DataPtr_75_10:
	dw Data_75_739d ; $4010
Data_75_4012:
	db $03, $04, $02, $00 ; count, flags
	dw $401c, $4630, $401c, $4030, $4130, $4230 ; body pointers
	INCBIN "data/bank_075/d_4022.bin" ; $4022, 1627 bytes
Data_75_467d:
	db $03, $04, $02, $00 ; count, flags
	dw $4687, $4ca0, $4687, $46a0, $47a0, $48a0 ; body pointers
	INCBIN "data/bank_075/d_468d.bin" ; $468d, 1632 bytes
Data_75_4ced:
	db $05, $04, $02, $00 ; count, flags
	dw $4cf7, $5310, $4cf7, $4d10, $4e10, $4f10 ; body pointers
	INCBIN "data/bank_075/d_4cfd.bin" ; $4cfd, 1632 bytes
Data_75_535d:
	db $05, $04, $02, $00 ; count, flags
	dw $5367, $5980, $5367, $5380, $5480, $5580 ; body pointers
	INCBIN "data/bank_075/d_536d.bin" ; $536d, 1632 bytes
Data_75_59cd:
	db $07, $04, $02, $00 ; count, flags
	dw $59d7, $5ff0, $59d7, $59f0, $5af0, $5bf0 ; body pointers
	INCBIN "data/bank_075/d_59dd.bin" ; $59dd, 1632 bytes
Data_75_603d:
	db $07, $04, $02, $00 ; count, flags
	dw $6047, $6660, $6047, $6060, $6160, $6260 ; body pointers
	INCBIN "data/bank_075/d_604d.bin" ; $604d, 1632 bytes
Data_75_66ad:
	db $07, $04, $02, $00 ; count, flags
	dw $66b7, $6cd0, $66b7, $66d0, $67d0, $68d0 ; body pointers
	INCBIN "data/bank_075/d_66bd.bin" ; $66bd, 1646 bytes
Data_75_6d2b:
	db $07, $04, $02, $00 ; count, flags
	dw $6d35, $7350, $6d35, $6d50, $6e50, $6f50 ; body pointers
	INCBIN "data/bank_075/d_6d3b.bin" ; $6d3b, 1634 bytes
Data_75_739d:
	db $07, $04, $02, $00 ; count, flags
	dw $73a7, $7dc0, $73a7, $73c0, $74c0, $75c0 ; body pointers
	INCBIN "data/bank_075/d_73ad.bin" ; $73ad, 2669 bytes
	ds 486, $ff ; $7e1a, fill

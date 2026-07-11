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
	dw $401c, Data_75_4630, $401c, Data_75_4030, Data_75_4130, Data_75_4230 ; body pointers
	INCBIN "data/bank_075/d_4022.bin" ; $4022, 14 bytes
Data_75_4030:
	INCBIN "data/bank_075/d_4030.bin" ; $4030, 256 bytes
Data_75_4130:
	INCBIN "data/bank_075/d_4130.bin" ; $4130, 256 bytes
Data_75_4230:
	INCBIN "data/bank_075/d_4230.bin" ; $4230, 1024 bytes
Data_75_4630:
	INCBIN "data/bank_075/d_4630.bin" ; $4630, 77 bytes
Data_75_467d:
	db $03, $04, $02, $00 ; count, flags
	dw $4687, Data_75_4ca0, $4687, Data_75_46a0, Data_75_47a0, Data_75_48a0 ; body pointers
	INCBIN "data/bank_075/d_468d.bin" ; $468d, 19 bytes
Data_75_46a0:
	INCBIN "data/bank_075/d_46a0.bin" ; $46a0, 256 bytes
Data_75_47a0:
	INCBIN "data/bank_075/d_47a0.bin" ; $47a0, 256 bytes
Data_75_48a0:
	INCBIN "data/bank_075/d_48a0.bin" ; $48a0, 1024 bytes
Data_75_4ca0:
	INCBIN "data/bank_075/d_4ca0.bin" ; $4ca0, 77 bytes
Data_75_4ced:
	db $05, $04, $02, $00 ; count, flags
	dw $4cf7, Data_75_5310, $4cf7, Data_75_4d10, Data_75_4e10, Data_75_4f10 ; body pointers
	INCBIN "data/bank_075/d_4cfd.bin" ; $4cfd, 19 bytes
Data_75_4d10:
	INCBIN "data/bank_075/d_4d10.bin" ; $4d10, 256 bytes
Data_75_4e10:
	INCBIN "data/bank_075/d_4e10.bin" ; $4e10, 256 bytes
Data_75_4f10:
	INCBIN "data/bank_075/d_4f10.bin" ; $4f10, 1024 bytes
Data_75_5310:
	INCBIN "data/bank_075/d_5310.bin" ; $5310, 77 bytes
Data_75_535d:
	db $05, $04, $02, $00 ; count, flags
	dw $5367, Data_75_5980, $5367, Data_75_5380, Data_75_5480, Data_75_5580 ; body pointers
	INCBIN "data/bank_075/d_536d.bin" ; $536d, 19 bytes
Data_75_5380:
	INCBIN "data/bank_075/d_5380.bin" ; $5380, 256 bytes
Data_75_5480:
	INCBIN "data/bank_075/d_5480.bin" ; $5480, 256 bytes
Data_75_5580:
	INCBIN "data/bank_075/d_5580.bin" ; $5580, 1024 bytes
Data_75_5980:
	INCBIN "data/bank_075/d_5980.bin" ; $5980, 77 bytes
Data_75_59cd:
	db $07, $04, $02, $00 ; count, flags
	dw $59d7, Data_75_5ff0, $59d7, Data_75_59f0, Data_75_5af0, Data_75_5bf0 ; body pointers
	INCBIN "data/bank_075/d_59dd.bin" ; $59dd, 19 bytes
Data_75_59f0:
	INCBIN "data/bank_075/d_59f0.bin" ; $59f0, 256 bytes
Data_75_5af0:
	INCBIN "data/bank_075/d_5af0.bin" ; $5af0, 256 bytes
Data_75_5bf0:
	INCBIN "data/bank_075/d_5bf0.bin" ; $5bf0, 1024 bytes
Data_75_5ff0:
	INCBIN "data/bank_075/d_5ff0.bin" ; $5ff0, 77 bytes
Data_75_603d:
	db $07, $04, $02, $00 ; count, flags
	dw $6047, Data_75_6660, $6047, Data_75_6060, Data_75_6160, Data_75_6260 ; body pointers
	INCBIN "data/bank_075/d_604d.bin" ; $604d, 19 bytes
Data_75_6060:
	INCBIN "data/bank_075/d_6060.bin" ; $6060, 256 bytes
Data_75_6160:
	INCBIN "data/bank_075/d_6160.bin" ; $6160, 256 bytes
Data_75_6260:
	INCBIN "data/bank_075/d_6260.bin" ; $6260, 1024 bytes
Data_75_6660:
	INCBIN "data/bank_075/d_6660.bin" ; $6660, 77 bytes
Data_75_66ad:
	db $07, $04, $02, $00 ; count, flags
	dw $66b7, Data_75_6cd0, $66b7, Data_75_66d0, Data_75_67d0, Data_75_68d0 ; body pointers
	INCBIN "data/bank_075/d_66bd.bin" ; $66bd, 19 bytes
Data_75_66d0:
	INCBIN "data/bank_075/d_66d0.bin" ; $66d0, 256 bytes
Data_75_67d0:
	INCBIN "data/bank_075/d_67d0.bin" ; $67d0, 256 bytes
Data_75_68d0:
	INCBIN "data/bank_075/d_68d0.bin" ; $68d0, 1024 bytes
Data_75_6cd0:
	INCBIN "data/bank_075/d_6cd0.bin" ; $6cd0, 91 bytes
Data_75_6d2b:
	db $07, $04, $02, $00 ; count, flags
	dw $6d35, Data_75_7350, $6d35, Data_75_6d50, Data_75_6e50, Data_75_6f50 ; body pointers
	INCBIN "data/bank_075/d_6d3b.bin" ; $6d3b, 21 bytes
Data_75_6d50:
	INCBIN "data/bank_075/d_6d50.bin" ; $6d50, 256 bytes
Data_75_6e50:
	INCBIN "data/bank_075/d_6e50.bin" ; $6e50, 256 bytes
Data_75_6f50:
	INCBIN "data/bank_075/d_6f50.bin" ; $6f50, 1024 bytes
Data_75_7350:
	INCBIN "data/bank_075/d_7350.bin" ; $7350, 77 bytes
Data_75_739d:
	db $07, $04, $02, $00 ; count, flags
	dw $73a7, Data_75_7dc0, $73a7, Data_75_73c0, Data_75_74c0, Data_75_75c0 ; body pointers
	INCBIN "data/bank_075/d_73ad.bin" ; $73ad, 19 bytes
Data_75_73c0:
	INCBIN "data/bank_075/d_73c0.bin" ; $73c0, 256 bytes
Data_75_74c0:
	INCBIN "data/bank_075/d_74c0.bin" ; $74c0, 256 bytes
Data_75_75c0:
	INCBIN "data/bank_075/d_75c0.bin" ; $75c0, 2048 bytes
Data_75_7dc0:
	INCBIN "data/bank_075/d_7dc0.bin" ; $7dc0, 90 bytes
	ds 486, $ff ; $7e1a, fill

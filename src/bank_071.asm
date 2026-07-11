INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $71", ROMX[$4000], BANK[$71]

DataPtr_71_00:
	dw Data_71_4014 ; $4000
DataPtr_71_02:
	dw Data_71_468d ; $4002
DataPtr_71_04:
	dw Data_71_4cfd ; $4004
DataPtr_71_06:
	dw Data_71_536d ; $4006
DataPtr_71_08:
	dw Data_71_59dd ; $4008
DataPtr_71_0a:
	dw Data_71_604d ; $400a
DataPtr_71_0c:
	dw Data_71_69cc ; $400c
DataPtr_71_0e:
	dw Data_71_734c ; $400e
DataPtr_71_10:
	dw Data_71_7ccc ; $4010
DataPtr_71_12:
	dw Data_71_7d43 ; $4012
Data_71_4014:
	db $05, $04, $02, $00 ; count, flags
	dw $401e, $4640, $401e, $4040, $4140, $4240 ; body pointers
	INCBIN "data/bank_071/d_4024.bin" ; $4024, 1641 bytes
Data_71_468d:
	db $05, $04, $02, $00 ; count, flags
	dw $4697, $4cb0, $4697, $46b0, $47b0, $48b0 ; body pointers
	INCBIN "data/bank_071/d_469d.bin" ; $469d, 1632 bytes
Data_71_4cfd:
	db $05, $04, $02, $00 ; count, flags
	dw $4d07, $5320, $4d07, $4d20, $4e20, $4f20 ; body pointers
	INCBIN "data/bank_071/d_4d0d.bin" ; $4d0d, 1632 bytes
Data_71_536d:
	db $03, $04, $02, $00 ; count, flags
	dw $5377, $5990, $5377, $5390, $5490, $5590 ; body pointers
	INCBIN "data/bank_071/d_537d.bin" ; $537d, 1632 bytes
Data_71_59dd:
	db $06, $04, $02, $00 ; count, flags
	dw $59e7, $6000, $59e7, $5a00, $5b00, $5c00 ; body pointers
	INCBIN "data/bank_071/d_59ed.bin" ; $59ed, 1632 bytes
Data_71_604d:
	db $05, $04, $02, $00 ; count, flags
	dw $6057, $6970, $6057, $6070, $6170, $6270 ; body pointers
	INCBIN "data/bank_071/d_605d.bin" ; $605d, 2415 bytes
Data_71_69cc:
	db $03, $04, $02, $00 ; count, flags
	dw $69d6, $72f0, $69d6, $69f0, $6af0, $6bf0 ; body pointers
	INCBIN "data/bank_071/d_69dc.bin" ; $69dc, 2416 bytes
Data_71_734c:
	db $05, $04, $02, $00 ; count, flags
	dw $7356, $7c70, $7356, $7370, $7470, $7570 ; body pointers
	INCBIN "data/bank_071/d_735c.bin" ; $735c, 2416 bytes
Data_71_7ccc:
	db $05, $01, $02, $00 ; count, flags
	dw $7cd6, $7d30, $7cd6, $7cf0, $7d30, $7d30 ; body pointers
	INCBIN "data/bank_071/d_7cdc.bin" ; $7cdc, 103 bytes
Data_71_7d43:
	db $03, $01, $02, $00 ; count, flags
	dw $7d4d, $7de0, $7d4d, $7d60, $7da0, $0000 ; body pointers
	INCBIN "data/bank_071/d_7d53.bin" ; $7d53, 166 bytes
	ds 519, $ff ; $7df9, fill

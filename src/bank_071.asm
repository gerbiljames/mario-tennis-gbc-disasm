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
	dw $401e, Data_71_4640, $401e, Data_71_4040, Data_71_4140, Data_71_4240 ; body pointers
	INCBIN "data/bank_071/d_4024.bin" ; $4024, 28 bytes
Data_71_4040:
	INCBIN "data/bank_071/d_4040.bin" ; $4040, 256 bytes
Data_71_4140:
	INCBIN "data/bank_071/d_4140.bin" ; $4140, 256 bytes
Data_71_4240:
	INCBIN "data/bank_071/d_4240.bin" ; $4240, 1024 bytes
Data_71_4640:
	INCBIN "data/bank_071/d_4640.bin" ; $4640, 77 bytes
Data_71_468d:
	db $05, $04, $02, $00 ; count, flags
	dw $4697, Data_71_4cb0, $4697, Data_71_46b0, Data_71_47b0, Data_71_48b0 ; body pointers
	INCBIN "data/bank_071/d_469d.bin" ; $469d, 19 bytes
Data_71_46b0:
	INCBIN "data/bank_071/d_46b0.bin" ; $46b0, 256 bytes
Data_71_47b0:
	INCBIN "data/bank_071/d_47b0.bin" ; $47b0, 256 bytes
Data_71_48b0:
	INCBIN "data/bank_071/d_48b0.bin" ; $48b0, 1024 bytes
Data_71_4cb0:
	INCBIN "data/bank_071/d_4cb0.bin" ; $4cb0, 77 bytes
Data_71_4cfd:
	db $05, $04, $02, $00 ; count, flags
	dw $4d07, Data_71_5320, $4d07, Data_71_4d20, Data_71_4e20, Data_71_4f20 ; body pointers
	INCBIN "data/bank_071/d_4d0d.bin" ; $4d0d, 19 bytes
Data_71_4d20:
	INCBIN "data/bank_071/d_4d20.bin" ; $4d20, 256 bytes
Data_71_4e20:
	INCBIN "data/bank_071/d_4e20.bin" ; $4e20, 256 bytes
Data_71_4f20:
	INCBIN "data/bank_071/d_4f20.bin" ; $4f20, 1024 bytes
Data_71_5320:
	INCBIN "data/bank_071/d_5320.bin" ; $5320, 77 bytes
Data_71_536d:
	db $03, $04, $02, $00 ; count, flags
	dw $5377, Data_71_5990, $5377, Data_71_5390, Data_71_5490, Data_71_5590 ; body pointers
	INCBIN "data/bank_071/d_537d.bin" ; $537d, 19 bytes
Data_71_5390:
	INCBIN "data/bank_071/d_5390.bin" ; $5390, 256 bytes
Data_71_5490:
	INCBIN "data/bank_071/d_5490.bin" ; $5490, 256 bytes
Data_71_5590:
	INCBIN "data/bank_071/d_5590.bin" ; $5590, 1024 bytes
Data_71_5990:
	INCBIN "data/bank_071/d_5990.bin" ; $5990, 77 bytes
Data_71_59dd:
	db $06, $04, $02, $00 ; count, flags
	dw $59e7, Data_71_6000, $59e7, Data_71_5a00, Data_71_5b00, Data_71_5c00 ; body pointers
	INCBIN "data/bank_071/d_59ed.bin" ; $59ed, 19 bytes
Data_71_5a00:
	INCBIN "data/bank_071/d_5a00.bin" ; $5a00, 256 bytes
Data_71_5b00:
	INCBIN "data/bank_071/d_5b00.bin" ; $5b00, 256 bytes
Data_71_5c00:
	INCBIN "data/bank_071/d_5c00.bin" ; $5c00, 1024 bytes
Data_71_6000:
	INCBIN "data/bank_071/d_6000.bin" ; $6000, 77 bytes
Data_71_604d:
	db $05, $04, $02, $00 ; count, flags
	dw $6057, Data_71_6970, $6057, Data_71_6070, Data_71_6170, Data_71_6270 ; body pointers
	INCBIN "data/bank_071/d_605d.bin" ; $605d, 19 bytes
Data_71_6070:
	INCBIN "data/bank_071/d_6070.bin" ; $6070, 256 bytes
Data_71_6170:
	INCBIN "data/bank_071/d_6170.bin" ; $6170, 256 bytes
Data_71_6270:
	INCBIN "data/bank_071/d_6270.bin" ; $6270, 1792 bytes
Data_71_6970:
	INCBIN "data/bank_071/d_6970.bin" ; $6970, 92 bytes
Data_71_69cc:
	db $03, $04, $02, $00 ; count, flags
	dw $69d6, Data_71_72f0, $69d6, Data_71_69f0, Data_71_6af0, Data_71_6bf0 ; body pointers
	INCBIN "data/bank_071/d_69dc.bin" ; $69dc, 20 bytes
Data_71_69f0:
	INCBIN "data/bank_071/d_69f0.bin" ; $69f0, 256 bytes
Data_71_6af0:
	INCBIN "data/bank_071/d_6af0.bin" ; $6af0, 256 bytes
Data_71_6bf0:
	INCBIN "data/bank_071/d_6bf0.bin" ; $6bf0, 1792 bytes
Data_71_72f0:
	INCBIN "data/bank_071/d_72f0.bin" ; $72f0, 92 bytes
Data_71_734c:
	db $05, $04, $02, $00 ; count, flags
	dw $7356, Data_71_7c70, $7356, Data_71_7370, Data_71_7470, Data_71_7570 ; body pointers
	INCBIN "data/bank_071/d_735c.bin" ; $735c, 20 bytes
Data_71_7370:
	INCBIN "data/bank_071/d_7370.bin" ; $7370, 256 bytes
Data_71_7470:
	INCBIN "data/bank_071/d_7470.bin" ; $7470, 256 bytes
Data_71_7570:
	INCBIN "data/bank_071/d_7570.bin" ; $7570, 1792 bytes
Data_71_7c70:
	INCBIN "data/bank_071/d_7c70.bin" ; $7c70, 92 bytes
Data_71_7ccc:
	db $05, $01, $02, $00 ; count, flags
	dw $7cd6, Data_71_7d30, $7cd6, Data_71_7cf0, Data_71_7d30, Data_71_7d30 ; body pointers
	INCBIN "data/bank_071/d_7cdc.bin" ; $7cdc, 20 bytes
Data_71_7cf0:
	INCBIN "data/bank_071/d_7cf0.bin" ; $7cf0, 64 bytes
Data_71_7d30:
	INCBIN "data/bank_071/d_7d30.bin" ; $7d30, 19 bytes
Data_71_7d43:
	db $03, $01, $02, $00 ; count, flags
	dw $7d4d, Data_71_7de0, $7d4d, Data_71_7d60, Data_71_7da0, $0000 ; body pointers
	INCBIN "data/bank_071/d_7d53.bin" ; $7d53, 13 bytes
Data_71_7d60:
	INCBIN "data/bank_071/d_7d60.bin" ; $7d60, 64 bytes
Data_71_7da0:
	INCBIN "data/bank_071/d_7da0.bin" ; $7da0, 64 bytes
Data_71_7de0:
	INCBIN "data/bank_071/d_7de0.bin" ; $7de0, 25 bytes
	ds 519, $ff ; $7df9, fill

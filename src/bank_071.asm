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
	INCBIN "data/bank_071/d_4014.bin" ; $4014, 1657 bytes
Data_71_468d:
	INCBIN "data/bank_071/d_468d.bin" ; $468d, 1648 bytes
Data_71_4cfd:
	INCBIN "data/bank_071/d_4cfd.bin" ; $4cfd, 1648 bytes
Data_71_536d:
	INCBIN "data/bank_071/d_536d.bin" ; $536d, 1648 bytes
Data_71_59dd:
	INCBIN "data/bank_071/d_59dd.bin" ; $59dd, 1648 bytes
Data_71_604d:
	INCBIN "data/bank_071/d_604d.bin" ; $604d, 16 bytes
	INCBIN "data/bank_071/d_605d.bin" ; $605d, 2415 bytes
Data_71_69cc:
	INCBIN "data/bank_071/d_69cc.bin" ; $69cc, 16 bytes
	INCBIN "data/bank_071/d_69dc.bin" ; $69dc, 2416 bytes
Data_71_734c:
	INCBIN "data/bank_071/d_734c.bin" ; $734c, 16 bytes
	INCBIN "data/bank_071/d_735c.bin" ; $735c, 2416 bytes
Data_71_7ccc:
	INCBIN "data/bank_071/d_7ccc.bin" ; $7ccc, 16 bytes
	INCBIN "data/bank_071/d_7cdc.bin" ; $7cdc, 103 bytes
Data_71_7d43:
	INCBIN "data/bank_071/d_7d43.bin" ; $7d43, 16 bytes
	INCBIN "data/bank_071/d_7d53.bin" ; $7d53, 166 bytes
	ds 519, $ff ; $7df9, fill

INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5f", ROMX[$4000], BANK[$5f]

	INCBIN "data/bank_05f/d_4000.bin" ; $4000, 208 bytes
FarPtr_5f_d0:
	dw Func_5f_7fed ; $40d0
	INCBIN "data/bank_05f/d_40d2.bin" ; $40d2, 16155 bytes
Func_5f_7fed:
	rst Rst38 ; $7fed
	rst Rst38 ; $7fee
	rst Rst38 ; $7fef
	rst Rst38 ; $7ff0
	rst Rst38 ; $7ff1
	rst Rst38 ; $7ff2
	rst Rst38 ; $7ff3
	rst Rst38 ; $7ff4
	rst Rst38 ; $7ff5
	rst Rst38 ; $7ff6
	rst Rst38 ; $7ff7
	rst Rst38 ; $7ff8
	rst Rst38 ; $7ff9
	rst Rst38 ; $7ffa
	rst Rst38 ; $7ffb
	rst Rst38 ; $7ffc
	rst Rst38 ; $7ffd
	rst Rst38 ; $7ffe
	rst Rst38 ; $7fff

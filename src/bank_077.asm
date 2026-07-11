INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $77", ROMX[$4000], BANK[$77]

WalkSprites_77:
	dw Data_77_4010 ; $4000
	dw Data_77_4895 ; $4002
	dw Data_77_5115 ; $4004
	dw Data_77_5995 ; $4006
	dw Data_77_6031 ; $4008
	dw Data_77_66c1 ; $400a
	dw Data_77_6d51 ; $400c
	dw Data_77_73e1 ; $400e
Data_77_4010:
	db $03, $04, $02, $00 ; count, flags
	dw $401a, $4840, $401a, $4040, $4140, $4240 ; body pointers
	INCBIN "data/bank_077/d_4020.bin" ; $4020, 2165 bytes
Data_77_4895:
	db $04, $04, $02, $00 ; count, flags
	dw $489f, $50c0, $489f, $48c0, $49c0, $4ac0 ; body pointers
	INCBIN "data/bank_077/d_48a5.bin" ; $48a5, 2160 bytes
Data_77_5115:
	db $06, $04, $02, $00 ; count, flags
	dw $511f, $5940, $511f, $5140, $5240, $5340 ; body pointers
	INCBIN "data/bank_077/d_5125.bin" ; $5125, 2160 bytes
Data_77_5995:
	db $06, $04, $02, $00 ; count, flags
	dw $599f, $5fc0, $599f, $59c0, $5ac0, $5bc0 ; body pointers
	INCBIN "data/bank_077/d_59a5.bin" ; $59a5, 1676 bytes
Data_77_6031:
	db $06, $04, $02, $00 ; count, flags
	dw $603b, $6650, $603b, $6050, $6150, $6250 ; body pointers
	INCBIN "data/bank_077/d_6041.bin" ; $6041, 1664 bytes
Data_77_66c1:
	db $05, $04, $02, $00 ; count, flags
	dw $66cb, $6ce0, $66cb, $66e0, $67e0, $68e0 ; body pointers
	INCBIN "data/bank_077/d_66d1.bin" ; $66d1, 1664 bytes
Data_77_6d51:
	db $06, $04, $02, $00 ; count, flags
	dw $6d5b, $7370, $6d5b, $6d70, $6e70, $6f70 ; body pointers
	INCBIN "data/bank_077/d_6d61.bin" ; $6d61, 1664 bytes
Data_77_73e1:
	db $05, $01, $02, $00 ; count, flags
	dw $73eb, $7590, $73eb, $7410, $7450, $7490 ; body pointers
	INCBIN "data/bank_077/d_73f1.bin" ; $73f1, 457 bytes
	ds 2630, $ff ; $75ba, fill

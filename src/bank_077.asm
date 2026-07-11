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
	dw $401a, Data_77_4840, $401a, Data_77_4040, Data_77_4140, Data_77_4240 ; body pointers
	INCBIN "data/bank_077/d_4020.bin" ; $4020, 32 bytes
Data_77_4040:
	INCBIN "data/bank_077/d_4040.bin" ; $4040, 256 bytes
Data_77_4140:
	INCBIN "data/bank_077/d_4140.bin" ; $4140, 256 bytes
Data_77_4240:
	INCBIN "data/bank_077/d_4240.bin" ; $4240, 1536 bytes
Data_77_4840:
	INCBIN "data/bank_077/d_4840.bin" ; $4840, 85 bytes
Data_77_4895:
	db $04, $04, $02, $00 ; count, flags
	dw $489f, Data_77_50c0, $489f, Data_77_48c0, Data_77_49c0, Data_77_4ac0 ; body pointers
	INCBIN "data/bank_077/d_48a5.bin" ; $48a5, 27 bytes
Data_77_48c0:
	INCBIN "data/bank_077/d_48c0.bin" ; $48c0, 256 bytes
Data_77_49c0:
	INCBIN "data/bank_077/d_49c0.bin" ; $49c0, 256 bytes
Data_77_4ac0:
	INCBIN "data/bank_077/d_4ac0.bin" ; $4ac0, 1536 bytes
Data_77_50c0:
	INCBIN "data/bank_077/d_50c0.bin" ; $50c0, 85 bytes
Data_77_5115:
	db $06, $04, $02, $00 ; count, flags
	dw $511f, Data_77_5940, $511f, Data_77_5140, Data_77_5240, Data_77_5340 ; body pointers
	INCBIN "data/bank_077/d_5125.bin" ; $5125, 27 bytes
Data_77_5140:
	INCBIN "data/bank_077/d_5140.bin" ; $5140, 256 bytes
Data_77_5240:
	INCBIN "data/bank_077/d_5240.bin" ; $5240, 256 bytes
Data_77_5340:
	INCBIN "data/bank_077/d_5340.bin" ; $5340, 1536 bytes
Data_77_5940:
	INCBIN "data/bank_077/d_5940.bin" ; $5940, 85 bytes
Data_77_5995:
	db $06, $04, $02, $00 ; count, flags
	dw $599f, Data_77_5fc0, $599f, Data_77_59c0, Data_77_5ac0, Data_77_5bc0 ; body pointers
	INCBIN "data/bank_077/d_59a5.bin" ; $59a5, 27 bytes
Data_77_59c0:
	INCBIN "data/bank_077/d_59c0.bin" ; $59c0, 256 bytes
Data_77_5ac0:
	INCBIN "data/bank_077/d_5ac0.bin" ; $5ac0, 256 bytes
Data_77_5bc0:
	INCBIN "data/bank_077/d_5bc0.bin" ; $5bc0, 1024 bytes
Data_77_5fc0:
	INCBIN "data/bank_077/d_5fc0.bin" ; $5fc0, 113 bytes
Data_77_6031:
	db $06, $04, $02, $00 ; count, flags
	dw $603b, Data_77_6650, $603b, Data_77_6050, Data_77_6150, Data_77_6250 ; body pointers
	INCBIN "data/bank_077/d_6041.bin" ; $6041, 15 bytes
Data_77_6050:
	INCBIN "data/bank_077/d_6050.bin" ; $6050, 256 bytes
Data_77_6150:
	INCBIN "data/bank_077/d_6150.bin" ; $6150, 256 bytes
Data_77_6250:
	INCBIN "data/bank_077/d_6250.bin" ; $6250, 1024 bytes
Data_77_6650:
	INCBIN "data/bank_077/d_6650.bin" ; $6650, 113 bytes
Data_77_66c1:
	db $05, $04, $02, $00 ; count, flags
	dw $66cb, Data_77_6ce0, $66cb, Data_77_66e0, Data_77_67e0, Data_77_68e0 ; body pointers
	INCBIN "data/bank_077/d_66d1.bin" ; $66d1, 15 bytes
Data_77_66e0:
	INCBIN "data/bank_077/d_66e0.bin" ; $66e0, 256 bytes
Data_77_67e0:
	INCBIN "data/bank_077/d_67e0.bin" ; $67e0, 256 bytes
Data_77_68e0:
	INCBIN "data/bank_077/d_68e0.bin" ; $68e0, 1024 bytes
Data_77_6ce0:
	INCBIN "data/bank_077/d_6ce0.bin" ; $6ce0, 113 bytes
Data_77_6d51:
	db $06, $04, $02, $00 ; count, flags
	dw $6d5b, Data_77_7370, $6d5b, Data_77_6d70, Data_77_6e70, Data_77_6f70 ; body pointers
	INCBIN "data/bank_077/d_6d61.bin" ; $6d61, 15 bytes
Data_77_6d70:
	INCBIN "data/bank_077/d_6d70.bin" ; $6d70, 256 bytes
Data_77_6e70:
	INCBIN "data/bank_077/d_6e70.bin" ; $6e70, 256 bytes
Data_77_6f70:
	INCBIN "data/bank_077/d_6f70.bin" ; $6f70, 1024 bytes
Data_77_7370:
	INCBIN "data/bank_077/d_7370.bin" ; $7370, 113 bytes
Data_77_73e1:
	db $05, $01, $02, $00 ; count, flags
	dw $73eb, Data_77_7590, $73eb, Data_77_7410, Data_77_7450, Data_77_7490 ; body pointers
	INCBIN "data/bank_077/d_73f1.bin" ; $73f1, 31 bytes
Data_77_7410:
	INCBIN "data/bank_077/d_7410.bin" ; $7410, 64 bytes
Data_77_7450:
	INCBIN "data/bank_077/d_7450.bin" ; $7450, 64 bytes
Data_77_7490:
	INCBIN "data/bank_077/d_7490.bin" ; $7490, 256 bytes
Data_77_7590:
	INCBIN "data/bank_077/d_7590.bin" ; $7590, 42 bytes
	ds 2630, $ff ; $75ba, fill

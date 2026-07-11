INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $74", ROMX[$4000], BANK[$74]

DataPtr_74_00:
	dw Data_74_4012 ; $4000
DataPtr_74_02:
	dw Data_74_4785 ; $4002
DataPtr_74_04:
	dw Data_74_4dfd ; $4004
DataPtr_74_06:
	dw Data_74_546d ; $4006
DataPtr_74_08:
	dw Data_74_5add ; $4008
DataPtr_74_0a:
	dw Data_74_614d ; $400a
DataPtr_74_0c:
	dw Data_74_67bd ; $400c
DataPtr_74_0e:
	dw Data_74_6e2d ; $400e
DataPtr_74_10:
	dw Data_74_749d ; $4010
Data_74_4012:
	db $03, $04, $02, $00 ; count, flags
	dw $401c, Data_74_4730, $401c, Data_74_4030, Data_74_4130, Data_74_4230 ; body pointers
	INCBIN "data/bank_074/d_4022.bin" ; $4022, 14 bytes
Data_74_4030:
	INCBIN "data/bank_074/d_4030.bin" ; $4030, 256 bytes
Data_74_4130:
	INCBIN "data/bank_074/d_4130.bin" ; $4130, 256 bytes
Data_74_4230:
	INCBIN "data/bank_074/d_4230.bin" ; $4230, 1280 bytes
Data_74_4730:
	INCBIN "data/bank_074/d_4730.bin" ; $4730, 85 bytes
Data_74_4785:
	db $03, $04, $02, $00 ; count, flags
	dw $478f, Data_74_4db0, $478f, Data_74_47b0, Data_74_48b0, Data_74_49b0 ; body pointers
	INCBIN "data/bank_074/d_4795.bin" ; $4795, 27 bytes
Data_74_47b0:
	INCBIN "data/bank_074/d_47b0.bin" ; $47b0, 256 bytes
Data_74_48b0:
	INCBIN "data/bank_074/d_48b0.bin" ; $48b0, 256 bytes
Data_74_49b0:
	INCBIN "data/bank_074/d_49b0.bin" ; $49b0, 1024 bytes
Data_74_4db0:
	INCBIN "data/bank_074/d_4db0.bin" ; $4db0, 77 bytes
Data_74_4dfd:
	db $06, $04, $02, $00 ; count, flags
	dw $4e07, Data_74_5420, $4e07, Data_74_4e20, Data_74_4f20, Data_74_5020 ; body pointers
	INCBIN "data/bank_074/d_4e0d.bin" ; $4e0d, 19 bytes
Data_74_4e20:
	INCBIN "data/bank_074/d_4e20.bin" ; $4e20, 256 bytes
Data_74_4f20:
	INCBIN "data/bank_074/d_4f20.bin" ; $4f20, 256 bytes
Data_74_5020:
	INCBIN "data/bank_074/d_5020.bin" ; $5020, 1024 bytes
Data_74_5420:
	INCBIN "data/bank_074/d_5420.bin" ; $5420, 77 bytes
Data_74_546d:
	db $05, $04, $02, $00 ; count, flags
	dw $5477, Data_74_5a90, $5477, Data_74_5490, Data_74_5590, Data_74_5690 ; body pointers
	INCBIN "data/bank_074/d_547d.bin" ; $547d, 19 bytes
Data_74_5490:
	INCBIN "data/bank_074/d_5490.bin" ; $5490, 256 bytes
Data_74_5590:
	INCBIN "data/bank_074/d_5590.bin" ; $5590, 256 bytes
Data_74_5690:
	INCBIN "data/bank_074/d_5690.bin" ; $5690, 1024 bytes
Data_74_5a90:
	INCBIN "data/bank_074/d_5a90.bin" ; $5a90, 77 bytes
Data_74_5add:
	db $05, $04, $02, $00 ; count, flags
	dw $5ae7, Data_74_6100, $5ae7, Data_74_5b00, Data_74_5c00, Data_74_5d00 ; body pointers
	INCBIN "data/bank_074/d_5aed.bin" ; $5aed, 19 bytes
Data_74_5b00:
	INCBIN "data/bank_074/d_5b00.bin" ; $5b00, 256 bytes
Data_74_5c00:
	INCBIN "data/bank_074/d_5c00.bin" ; $5c00, 256 bytes
Data_74_5d00:
	INCBIN "data/bank_074/d_5d00.bin" ; $5d00, 1024 bytes
Data_74_6100:
	INCBIN "data/bank_074/d_6100.bin" ; $6100, 77 bytes
Data_74_614d:
	db $04, $04, $02, $00 ; count, flags
	dw $6157, Data_74_6770, $6157, Data_74_6170, Data_74_6270, Data_74_6370 ; body pointers
	INCBIN "data/bank_074/d_615d.bin" ; $615d, 19 bytes
Data_74_6170:
	INCBIN "data/bank_074/d_6170.bin" ; $6170, 256 bytes
Data_74_6270:
	INCBIN "data/bank_074/d_6270.bin" ; $6270, 256 bytes
Data_74_6370:
	INCBIN "data/bank_074/d_6370.bin" ; $6370, 1024 bytes
Data_74_6770:
	INCBIN "data/bank_074/d_6770.bin" ; $6770, 77 bytes
Data_74_67bd:
	db $05, $04, $02, $00 ; count, flags
	dw $67c7, Data_74_6de0, $67c7, Data_74_67e0, Data_74_68e0, Data_74_69e0 ; body pointers
	INCBIN "data/bank_074/d_67cd.bin" ; $67cd, 19 bytes
Data_74_67e0:
	INCBIN "data/bank_074/d_67e0.bin" ; $67e0, 256 bytes
Data_74_68e0:
	INCBIN "data/bank_074/d_68e0.bin" ; $68e0, 256 bytes
Data_74_69e0:
	INCBIN "data/bank_074/d_69e0.bin" ; $69e0, 1024 bytes
Data_74_6de0:
	INCBIN "data/bank_074/d_6de0.bin" ; $6de0, 77 bytes
Data_74_6e2d:
	db $04, $04, $02, $00 ; count, flags
	dw $6e37, Data_74_7450, $6e37, Data_74_6e50, Data_74_6f50, Data_74_7050 ; body pointers
	INCBIN "data/bank_074/d_6e3d.bin" ; $6e3d, 19 bytes
Data_74_6e50:
	INCBIN "data/bank_074/d_6e50.bin" ; $6e50, 256 bytes
Data_74_6f50:
	INCBIN "data/bank_074/d_6f50.bin" ; $6f50, 256 bytes
Data_74_7050:
	INCBIN "data/bank_074/d_7050.bin" ; $7050, 1024 bytes
Data_74_7450:
	INCBIN "data/bank_074/d_7450.bin" ; $7450, 77 bytes
Data_74_749d:
	db $03, $04, $02, $00 ; count, flags
	dw $74a7, Data_74_7ac0, $74a7, Data_74_74c0, Data_74_75c0, Data_74_76c0 ; body pointers
	INCBIN "data/bank_074/d_74ad.bin" ; $74ad, 19 bytes
Data_74_74c0:
	INCBIN "data/bank_074/d_74c0.bin" ; $74c0, 256 bytes
Data_74_75c0:
	INCBIN "data/bank_074/d_75c0.bin" ; $75c0, 256 bytes
Data_74_76c0:
	INCBIN "data/bank_074/d_76c0.bin" ; $76c0, 1024 bytes
Data_74_7ac0:
	INCBIN "data/bank_074/d_7ac0.bin" ; $7ac0, 77 bytes
	ds 1267, $ff ; $7b0d, fill

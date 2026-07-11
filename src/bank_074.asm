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
	dw $401c, $4730, $401c, $4030, $4130, $4230 ; body pointers
	INCBIN "data/bank_074/d_4022.bin" ; $4022, 1891 bytes
Data_74_4785:
	db $03, $04, $02, $00 ; count, flags
	dw $478f, $4db0, $478f, $47b0, $48b0, $49b0 ; body pointers
	INCBIN "data/bank_074/d_4795.bin" ; $4795, 1640 bytes
Data_74_4dfd:
	db $06, $04, $02, $00 ; count, flags
	dw $4e07, $5420, $4e07, $4e20, $4f20, $5020 ; body pointers
	INCBIN "data/bank_074/d_4e0d.bin" ; $4e0d, 1632 bytes
Data_74_546d:
	db $05, $04, $02, $00 ; count, flags
	dw $5477, $5a90, $5477, $5490, $5590, $5690 ; body pointers
	INCBIN "data/bank_074/d_547d.bin" ; $547d, 1632 bytes
Data_74_5add:
	db $05, $04, $02, $00 ; count, flags
	dw $5ae7, $6100, $5ae7, $5b00, $5c00, $5d00 ; body pointers
	INCBIN "data/bank_074/d_5aed.bin" ; $5aed, 1632 bytes
Data_74_614d:
	db $04, $04, $02, $00 ; count, flags
	dw $6157, $6770, $6157, $6170, $6270, $6370 ; body pointers
	INCBIN "data/bank_074/d_615d.bin" ; $615d, 1632 bytes
Data_74_67bd:
	db $05, $04, $02, $00 ; count, flags
	dw $67c7, $6de0, $67c7, $67e0, $68e0, $69e0 ; body pointers
	INCBIN "data/bank_074/d_67cd.bin" ; $67cd, 1632 bytes
Data_74_6e2d:
	db $04, $04, $02, $00 ; count, flags
	dw $6e37, $7450, $6e37, $6e50, $6f50, $7050 ; body pointers
	INCBIN "data/bank_074/d_6e3d.bin" ; $6e3d, 1632 bytes
Data_74_749d:
	db $03, $04, $02, $00 ; count, flags
	dw $74a7, $7ac0, $74a7, $74c0, $75c0, $76c0 ; body pointers
	INCBIN "data/bank_074/d_74ad.bin" ; $74ad, 1632 bytes
	ds 1267, $ff ; $7b0d, fill

INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $62", ROMX[$4000], BANK[$62]

DataPtr_62_00:
	dw Data_62_4b13 ; $4000
DataPtr_62_02:
	dw Data_62_4040 ; $4002
DataPtr_StarCourtTilemap:
	dw StarCourtTilemap ; $4004
DataPtr_62_06:
	dw Lz_62_4a42 ; $4006
DataPtr_62_08:
	dw Data_62_4b13 ; $4008
DataPtr_62_0a:
	dw Data_62_4b3b ; $400a
DataPtr_62_0c:
	dw Data_62_4b63 ; $400c
DataPtr_StarCourtTiles:
	dw StarCourtTiles ; $400e
DataPtr_62_10:
	dw Data_62_5600 ; $4010
DataPtr_62_12:
	dw Data_62_4b63 ; $4012
DataPtr_62_14:
	dw Lz_62_528d ; $4014
DataPtr_62_16:
	dw Lz_62_54e3 ; $4016
DataPtr_62_18:
	dw Data_62_5600 ; $4018
DataPtr_62_1a:
	dw Data_62_5628 ; $401a
DataPtr_62_1c:
	dw Data_62_5650 ; $401c
DataPtr_62_1e:
	dw Lz_62_4ba3 ; $401e
DataPtr_62_20:
	dw Data_62_63e1 ; $4020
DataPtr_62_22:
	dw Data_62_5650 ; $4022
DataPtr_WarioCourtTilemap:
	dw WarioCourtTilemap ; $4024
DataPtr_62_26:
	dw Lz_62_62cf ; $4026
DataPtr_62_28:
	dw Data_62_63e1 ; $4028
DataPtr_62_2a:
	dw Data_62_6409 ; $402a
DataPtr_62_2c:
	dw Data_62_6431 ; $402c
DataPtr_WarioCourtTiles:
	dw WarioCourtTiles ; $402e
DataPtr_62_30:
	dw Data_62_6f2e ; $4030
DataPtr_62_32:
	dw Data_62_6431 ; $4032
DataPtr_62_34:
	dw Lz_62_6bc3 ; $4034
DataPtr_62_36:
	dw Lz_62_6df5 ; $4036
DataPtr_62_38:
	dw Data_62_6f2e ; $4038
DataPtr_62_3a:
	dw Data_62_6f56 ; $403a
DataPtr_62_3c:
	dw Data_62_6f7e ; $403c
DataPtr_62_3e:
	dw Lz_62_6471 ; $403e
Data_62_4040:
	INCBIN "data/bank_062/d_4040.bin" ; $4040, 64 bytes
StarCourtTiles:
	INCBIN "data/bank_062/lz_4080.bin" ; $4080, 1990 bytes
StarCourtTilemap:
	INCBIN "data/bank_062/lz_4846.bin" ; $4846, 508 bytes
Lz_62_4a42:
	INCBIN "data/bank_062/lz_4a42.bin" ; $4a42, 209 bytes
Data_62_4b13:
	INCBIN "data/bank_062/d_4b13.bin" ; $4b13, 40 bytes
Data_62_4b3b:
	INCBIN "data/bank_062/d_4b3b.bin" ; $4b3b, 40 bytes
Data_62_4b63:
	INCBIN "data/bank_062/d_4b63.bin" ; $4b63, 64 bytes
Lz_62_4ba3:
	INCBIN "data/bank_062/lz_4ba3.bin" ; $4ba3, 1770 bytes
Lz_62_528d:
	INCBIN "data/bank_062/lz_528d.bin" ; $528d, 598 bytes
Lz_62_54e3:
	INCBIN "data/bank_062/lz_54e3.bin" ; $54e3, 285 bytes
Data_62_5600:
	INCBIN "data/bank_062/d_5600.bin" ; $5600, 40 bytes
Data_62_5628:
	INCBIN "data/bank_062/d_5628.bin" ; $5628, 40 bytes
Data_62_5650:
	INCBIN "data/bank_062/d_5650.bin" ; $5650, 64 bytes
WarioCourtTiles:
	INCBIN "data/bank_062/lz_5690.bin" ; $5690, 2412 bytes
WarioCourtTilemap:
	INCBIN "data/bank_062/lz_5ffc.bin" ; $5ffc, 723 bytes
Lz_62_62cf:
	INCBIN "data/bank_062/lz_62cf.bin" ; $62cf, 274 bytes
Data_62_63e1:
	INCBIN "data/bank_062/d_63e1.bin" ; $63e1, 40 bytes
Data_62_6409:
	INCBIN "data/bank_062/d_6409.bin" ; $6409, 40 bytes
Data_62_6431:
	INCBIN "data/bank_062/d_6431.bin" ; $6431, 64 bytes
Lz_62_6471:
	INCBIN "data/bank_062/lz_6471.bin" ; $6471, 1874 bytes
Lz_62_6bc3:
	INCBIN "data/bank_062/lz_6bc3.bin" ; $6bc3, 562 bytes
Lz_62_6df5:
	INCBIN "data/bank_062/lz_6df5.bin" ; $6df5, 313 bytes
Data_62_6f2e:
	INCBIN "data/bank_062/d_6f2e.bin" ; $6f2e, 40 bytes
Data_62_6f56:
	INCBIN "data/bank_062/d_6f56.bin" ; $6f56, 40 bytes
Data_62_6f7e:
	INCBIN "data/bank_062/d_6f7e.bin" ; $6f7e, 4226 bytes

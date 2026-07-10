INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6c", ROMX[$4000], BANK[$6c]

DataPtr_6c_00:
	dw CompanyLogosTiles ; $4000
DataPtr_6c_02:
	dw CompanyLogosTilemap ; $4002
DataPtr_6c_04:
	dw Lz_6c_48af ; $4004
DataPtr_6c_06:
	dw Data_6c_4906 ; $4006
DataPtr_6c_08:
	dw IntroRalliesTiles ; $4008
DataPtr_6c_0a:
	dw Lz_6c_505b ; $400a
DataPtr_6c_0c:
	dw Lz_6c_50b7 ; $400c
DataPtr_6c_0e:
	dw Lz_6c_50ff ; $400e
DataPtr_6c_10:
	dw Lz_6c_515b ; $4010
DataPtr_6c_12:
	dw Lz_6c_51a6 ; $4012
DataPtr_6c_14:
	dw Lz_6c_5214 ; $4014
DataPtr_6c_16:
	dw Lz_6c_525d ; $4016
DataPtr_6c_18:
	dw Lz_6c_539e ; $4018
DataPtr_6c_1a:
	dw Data_6c_53e4 ; $401a
DataPtr_6c_1c:
	dw Lz_6c_5424 ; $401c
DataPtr_6c_1e:
	dw Lz_6c_5451 ; $401e
DataPtr_6c_20:
	dw Lz_6c_54e8 ; $4020
DataPtr_6c_22:
	dw Lz_6c_55c6 ; $4022
DataPtr_6c_24:
	dw Lz_6c_55f6 ; $4024
DataPtr_6c_26:
	dw Lz_6c_56f9 ; $4026
DataPtr_6c_28:
	dw Lz_6c_57e1 ; $4028
DataPtr_6c_2a:
	dw IntroSwingTiles ; $402a
DataPtr_6c_2c:
	dw Lz_6c_5c2e ; $402c
DataPtr_6c_2e:
	dw Lz_6c_5d0f ; $402e
DataPtr_6c_30:
	dw Data_6c_5d55 ; $4030
DataPtr_6c_32:
	dw IntroCloseupTiles ; $4032
DataPtr_6c_34:
	dw Lz_6c_61ba ; $4034
DataPtr_6c_36:
	dw Lz_6c_6264 ; $4036
DataPtr_6c_38:
	dw Data_6c_62ae ; $4038
DataPtr_6c_3a:
	dw Lz_6c_62ee ; $403a
DataPtr_6c_3c:
	dw Lz_6c_67e0 ; $403c
DataPtr_6c_3e:
	dw Lz_6c_68c2 ; $403e
DataPtr_6c_40:
	dw Data_6c_690a ; $4040
DataPtr_6c_42:
	dw Lz_6c_694a ; $4042
DataPtr_6c_44:
	dw Lz_6c_6dee ; $4044
DataPtr_6c_46:
	dw Lz_6c_6eab ; $4046
DataPtr_6c_48:
	dw Data_6c_6ef3 ; $4048
DataPtr_6c_4a:
	dw Lz_6c_6f33 ; $404a
DataPtr_6c_4c:
	dw Lz_6c_739e ; $404c
DataPtr_6c_4e:
	dw Lz_6c_7453 ; $404e
DataPtr_6c_50:
	dw Data_6c_749b ; $4050
DataPtr_6c_52:
	dw Lz_6c_74db ; $4052
DataPtr_6c_54:
	dw Lz_6c_75a7 ; $4054
DataPtr_6c_56:
	dw Lz_6c_7678 ; $4056
DataPtr_6c_58:
	dw Lz_6c_7744 ; $4058
DataPtr_6c_5a:
	dw Lz_6c_7808 ; $405a
DataPtr_6c_5c:
	dw Lz_6c_7836 ; $405c
DataPtr_6c_5e:
	dw Lz_6c_786d ; $405e
DataPtr_6c_60:
	dw Lz_6c_7894 ; $4060
DataPtr_6c_62:
	dw Lz_6c_799d ; $4062
DataPtr_6c_64:
	dw Lz_6c_7a16 ; $4064
DataPtr_6c_66:
	dw Lz_6c_7b1f ; $4066
DataPtr_6c_68:
	dw Lz_6c_7b92 ; $4068
DataPtr_6c_6a:
	dw Lz_6c_7ca8 ; $406a
CompanyLogosTiles:
	INCBIN "data/bank_06c/lz_406c.bin" ; $406c, 1804 bytes
CompanyLogosTilemap:
	INCBIN "data/bank_06c/lz_4778.bin" ; $4778, 311 bytes
Lz_6c_48af:
	INCBIN "data/bank_06c/lz_48af.bin" ; $48af, 87 bytes
Data_6c_4906:
	INCBIN "data/bank_06c/d_4906.bin" ; $4906, 64 bytes
IntroRalliesTiles:
	INCBIN "data/bank_06c/lz_4946.bin" ; $4946, 1813 bytes
Lz_6c_505b:
	INCBIN "data/bank_06c/lz_505b.bin" ; $505b, 92 bytes
Lz_6c_50b7:
	INCBIN "data/bank_06c/lz_50b7.bin" ; $50b7, 72 bytes
Lz_6c_50ff:
	INCBIN "data/bank_06c/lz_50ff.bin" ; $50ff, 92 bytes
Lz_6c_515b:
	INCBIN "data/bank_06c/lz_515b.bin" ; $515b, 75 bytes
Lz_6c_51a6:
	INCBIN "data/bank_06c/lz_51a6.bin" ; $51a6, 110 bytes
Lz_6c_5214:
	INCBIN "data/bank_06c/lz_5214.bin" ; $5214, 73 bytes
Lz_6c_525d:
	INCBIN "data/bank_06c/lz_525d.bin" ; $525d, 321 bytes
Lz_6c_539e:
	INCBIN "data/bank_06c/lz_539e.bin" ; $539e, 70 bytes
Data_6c_53e4:
	INCBIN "data/bank_06c/d_53e4.bin" ; $53e4, 64 bytes
Lz_6c_5424:
	INCBIN "data/bank_06c/lz_5424.bin" ; $5424, 45 bytes
Lz_6c_5451:
	INCBIN "data/bank_06c/lz_5451.bin" ; $5451, 151 bytes
Lz_6c_54e8:
	INCBIN "data/bank_06c/lz_54e8.bin" ; $54e8, 222 bytes
Lz_6c_55c6:
	INCBIN "data/bank_06c/lz_55c6.bin" ; $55c6, 48 bytes
Lz_6c_55f6:
	INCBIN "data/bank_06c/lz_55f6.bin" ; $55f6, 259 bytes
Lz_6c_56f9:
	INCBIN "data/bank_06c/lz_56f9.bin" ; $56f9, 232 bytes
Lz_6c_57e1:
	INCBIN "data/bank_06c/lz_57e1.bin" ; $57e1, 16 bytes
IntroSwingTiles:
	INCBIN "data/bank_06c/lz_57f1.bin" ; $57f1, 1085 bytes
Lz_6c_5c2e:
	INCBIN "data/bank_06c/lz_5c2e.bin" ; $5c2e, 225 bytes
Lz_6c_5d0f:
	INCBIN "data/bank_06c/lz_5d0f.bin" ; $5d0f, 70 bytes
Data_6c_5d55:
	INCBIN "data/bank_06c/d_5d55.bin" ; $5d55, 64 bytes
IntroCloseupTiles:
	INCBIN "data/bank_06c/lz_5d95.bin" ; $5d95, 1061 bytes
Lz_6c_61ba:
	INCBIN "data/bank_06c/lz_61ba.bin" ; $61ba, 170 bytes
Lz_6c_6264:
	INCBIN "data/bank_06c/lz_6264.bin" ; $6264, 74 bytes
Data_6c_62ae:
	INCBIN "data/bank_06c/d_62ae.bin" ; $62ae, 64 bytes
Lz_6c_62ee:
	INCBIN "data/bank_06c/lz_62ee.bin" ; $62ee, 1266 bytes
Lz_6c_67e0:
	INCBIN "data/bank_06c/lz_67e0.bin" ; $67e0, 226 bytes
Lz_6c_68c2:
	INCBIN "data/bank_06c/lz_68c2.bin" ; $68c2, 72 bytes
Data_6c_690a:
	INCBIN "data/bank_06c/d_690a.bin" ; $690a, 64 bytes
Lz_6c_694a:
	INCBIN "data/bank_06c/lz_694a.bin" ; $694a, 1188 bytes
Lz_6c_6dee:
	INCBIN "data/bank_06c/lz_6dee.bin" ; $6dee, 189 bytes
Lz_6c_6eab:
	INCBIN "data/bank_06c/lz_6eab.bin" ; $6eab, 72 bytes
Data_6c_6ef3:
	INCBIN "data/bank_06c/d_6ef3.bin" ; $6ef3, 64 bytes
Lz_6c_6f33:
	INCBIN "data/bank_06c/lz_6f33.bin" ; $6f33, 1131 bytes
Lz_6c_739e:
	INCBIN "data/bank_06c/lz_739e.bin" ; $739e, 181 bytes
Lz_6c_7453:
	INCBIN "data/bank_06c/lz_7453.bin" ; $7453, 72 bytes
Data_6c_749b:
	INCBIN "data/bank_06c/d_749b.bin" ; $749b, 64 bytes
Lz_6c_74db:
	INCBIN "data/bank_06c/lz_74db.bin" ; $74db, 204 bytes
Lz_6c_75a7:
	INCBIN "data/bank_06c/lz_75a7.bin" ; $75a7, 209 bytes
Lz_6c_7678:
	INCBIN "data/bank_06c/lz_7678.bin" ; $7678, 204 bytes
Lz_6c_7744:
	INCBIN "data/bank_06c/lz_7744.bin" ; $7744, 196 bytes
Lz_6c_7808:
	INCBIN "data/bank_06c/lz_7808.bin" ; $7808, 46 bytes
Lz_6c_7836:
	INCBIN "data/bank_06c/lz_7836.bin" ; $7836, 55 bytes
Lz_6c_786d:
	INCBIN "data/bank_06c/lz_786d.bin" ; $786d, 39 bytes
Lz_6c_7894:
	INCBIN "data/bank_06c/lz_7894.bin" ; $7894, 265 bytes
Lz_6c_799d:
	INCBIN "data/bank_06c/lz_799d.bin" ; $799d, 121 bytes
Lz_6c_7a16:
	INCBIN "data/bank_06c/lz_7a16.bin" ; $7a16, 265 bytes
Lz_6c_7b1f:
	INCBIN "data/bank_06c/lz_7b1f.bin" ; $7b1f, 115 bytes
Lz_6c_7b92:
	INCBIN "data/bank_06c/lz_7b92.bin" ; $7b92, 278 bytes
Lz_6c_7ca8:
	INCBIN "data/bank_06c/lz_7ca8.bin" ; $7ca8, 118 bytes
	ds 738, $ff ; $7d1e, fill

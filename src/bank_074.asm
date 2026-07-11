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
	dw $401c, OamPtrs_74_4730, $401c, Data_74_4030, Data_74_4130, Data_74_4230 ; body pointers
	INCBIN "data/bank_074/d_4022.bin" ; $4022, 14 bytes
Data_74_4030:
	INCBIN "data/bank_074/d_4030.bin" ; $4030, 256 bytes
Data_74_4130:
	INCBIN "data/bank_074/d_4130.bin" ; $4130, 256 bytes
Data_74_4230:
	INCBIN "data/bank_074/d_4230.bin" ; $4230, 1280 bytes
OamPtrs_74_4730:
	dw Data_74_4740 ; $4730
	dw Data_74_4743 ; $4732
	dw Data_74_4749 ; $4734
	dw Data_74_4755 ; $4736
	dw Data_74_475d ; $4738
	dw Data_74_4771 ; $473a
	dw Data_74_4779 ; $473c
	dw Data_74_4779 ; $473e
Data_74_4740:
	INCBIN "data/bank_074/d_4740.bin" ; $4740, 3 bytes
Data_74_4743:
	INCBIN "data/bank_074/d_4743.bin" ; $4743, 6 bytes
Data_74_4749:
	INCBIN "data/bank_074/d_4749.bin" ; $4749, 12 bytes
Data_74_4755:
	INCBIN "data/bank_074/d_4755.bin" ; $4755, 8 bytes
Data_74_475d:
	INCBIN "data/bank_074/d_475d.bin" ; $475d, 20 bytes
Data_74_4771:
	INCBIN "data/bank_074/d_4771.bin" ; $4771, 8 bytes
Data_74_4779:
	INCBIN "data/bank_074/d_4779.bin" ; $4779, 12 bytes
Data_74_4785:
	db $03, $04, $02, $00 ; count, flags
	dw $478f, OamPtrs_74_4db0, $478f, Data_74_47b0, Data_74_48b0, Data_74_49b0 ; body pointers
	INCBIN "data/bank_074/d_4795.bin" ; $4795, 27 bytes
Data_74_47b0:
	INCBIN "data/bank_074/d_47b0.bin" ; $47b0, 256 bytes
Data_74_48b0:
	INCBIN "data/bank_074/d_48b0.bin" ; $48b0, 256 bytes
Data_74_49b0:
	INCBIN "data/bank_074/d_49b0.bin" ; $49b0, 1024 bytes
OamPtrs_74_4db0:
	dw Data_74_4dc0 ; $4db0
	dw Data_74_4dc3 ; $4db2
	dw Data_74_4dc9 ; $4db4
	dw Data_74_4dd5 ; $4db6
	dw Data_74_4ddd ; $4db8
	dw Data_74_4df1 ; $4dba
	dw Data_74_4df1 ; $4dbc
	dw Data_74_4df1 ; $4dbe
Data_74_4dc0:
	INCBIN "data/bank_074/d_4dc0.bin" ; $4dc0, 3 bytes
Data_74_4dc3:
	INCBIN "data/bank_074/d_4dc3.bin" ; $4dc3, 6 bytes
Data_74_4dc9:
	INCBIN "data/bank_074/d_4dc9.bin" ; $4dc9, 12 bytes
Data_74_4dd5:
	INCBIN "data/bank_074/d_4dd5.bin" ; $4dd5, 8 bytes
Data_74_4ddd:
	INCBIN "data/bank_074/d_4ddd.bin" ; $4ddd, 20 bytes
Data_74_4df1:
	INCBIN "data/bank_074/d_4df1.bin" ; $4df1, 12 bytes
Data_74_4dfd:
	db $06, $04, $02, $00 ; count, flags
	dw $4e07, OamPtrs_74_5420, $4e07, Data_74_4e20, Data_74_4f20, Data_74_5020 ; body pointers
	INCBIN "data/bank_074/d_4e0d.bin" ; $4e0d, 19 bytes
Data_74_4e20:
	INCBIN "data/bank_074/d_4e20.bin" ; $4e20, 256 bytes
Data_74_4f20:
	INCBIN "data/bank_074/d_4f20.bin" ; $4f20, 256 bytes
Data_74_5020:
	INCBIN "data/bank_074/d_5020.bin" ; $5020, 1024 bytes
OamPtrs_74_5420:
	dw Data_74_5430 ; $5420
	dw Data_74_5433 ; $5422
	dw Data_74_5439 ; $5424
	dw Data_74_5445 ; $5426
	dw Data_74_544d ; $5428
	dw Data_74_5461 ; $542a
	dw Data_74_5461 ; $542c
	dw Data_74_5461 ; $542e
Data_74_5430:
	INCBIN "data/bank_074/d_5430.bin" ; $5430, 3 bytes
Data_74_5433:
	INCBIN "data/bank_074/d_5433.bin" ; $5433, 6 bytes
Data_74_5439:
	INCBIN "data/bank_074/d_5439.bin" ; $5439, 12 bytes
Data_74_5445:
	INCBIN "data/bank_074/d_5445.bin" ; $5445, 8 bytes
Data_74_544d:
	INCBIN "data/bank_074/d_544d.bin" ; $544d, 20 bytes
Data_74_5461:
	INCBIN "data/bank_074/d_5461.bin" ; $5461, 12 bytes
Data_74_546d:
	db $05, $04, $02, $00 ; count, flags
	dw $5477, OamPtrs_74_5a90, $5477, Data_74_5490, Data_74_5590, Data_74_5690 ; body pointers
	INCBIN "data/bank_074/d_547d.bin" ; $547d, 19 bytes
Data_74_5490:
	INCBIN "data/bank_074/d_5490.bin" ; $5490, 256 bytes
Data_74_5590:
	INCBIN "data/bank_074/d_5590.bin" ; $5590, 256 bytes
Data_74_5690:
	INCBIN "data/bank_074/d_5690.bin" ; $5690, 1024 bytes
OamPtrs_74_5a90:
	dw Data_74_5aa0 ; $5a90
	dw Data_74_5aa3 ; $5a92
	dw Data_74_5aa9 ; $5a94
	dw Data_74_5ab5 ; $5a96
	dw Data_74_5abd ; $5a98
	dw Data_74_5ad1 ; $5a9a
	dw Data_74_5ad1 ; $5a9c
	dw Data_74_5ad1 ; $5a9e
Data_74_5aa0:
	INCBIN "data/bank_074/d_5aa0.bin" ; $5aa0, 3 bytes
Data_74_5aa3:
	INCBIN "data/bank_074/d_5aa3.bin" ; $5aa3, 6 bytes
Data_74_5aa9:
	INCBIN "data/bank_074/d_5aa9.bin" ; $5aa9, 12 bytes
Data_74_5ab5:
	INCBIN "data/bank_074/d_5ab5.bin" ; $5ab5, 8 bytes
Data_74_5abd:
	INCBIN "data/bank_074/d_5abd.bin" ; $5abd, 20 bytes
Data_74_5ad1:
	INCBIN "data/bank_074/d_5ad1.bin" ; $5ad1, 12 bytes
Data_74_5add:
	db $05, $04, $02, $00 ; count, flags
	dw $5ae7, OamPtrs_74_6100, $5ae7, Data_74_5b00, Data_74_5c00, Data_74_5d00 ; body pointers
	INCBIN "data/bank_074/d_5aed.bin" ; $5aed, 19 bytes
Data_74_5b00:
	INCBIN "data/bank_074/d_5b00.bin" ; $5b00, 256 bytes
Data_74_5c00:
	INCBIN "data/bank_074/d_5c00.bin" ; $5c00, 256 bytes
Data_74_5d00:
	INCBIN "data/bank_074/d_5d00.bin" ; $5d00, 1024 bytes
OamPtrs_74_6100:
	dw Data_74_6110 ; $6100
	dw Data_74_6113 ; $6102
	dw Data_74_6119 ; $6104
	dw Data_74_6125 ; $6106
	dw Data_74_612d ; $6108
	dw Data_74_6141 ; $610a
	dw Data_74_6141 ; $610c
	dw Data_74_6141 ; $610e
Data_74_6110:
	INCBIN "data/bank_074/d_6110.bin" ; $6110, 3 bytes
Data_74_6113:
	INCBIN "data/bank_074/d_6113.bin" ; $6113, 6 bytes
Data_74_6119:
	INCBIN "data/bank_074/d_6119.bin" ; $6119, 12 bytes
Data_74_6125:
	INCBIN "data/bank_074/d_6125.bin" ; $6125, 8 bytes
Data_74_612d:
	INCBIN "data/bank_074/d_612d.bin" ; $612d, 20 bytes
Data_74_6141:
	INCBIN "data/bank_074/d_6141.bin" ; $6141, 12 bytes
Data_74_614d:
	db $04, $04, $02, $00 ; count, flags
	dw $6157, OamPtrs_74_6770, $6157, Data_74_6170, Data_74_6270, Data_74_6370 ; body pointers
	INCBIN "data/bank_074/d_615d.bin" ; $615d, 19 bytes
Data_74_6170:
	INCBIN "data/bank_074/d_6170.bin" ; $6170, 256 bytes
Data_74_6270:
	INCBIN "data/bank_074/d_6270.bin" ; $6270, 256 bytes
Data_74_6370:
	INCBIN "data/bank_074/d_6370.bin" ; $6370, 1024 bytes
OamPtrs_74_6770:
	dw Data_74_6780 ; $6770
	dw Data_74_6783 ; $6772
	dw Data_74_6789 ; $6774
	dw Data_74_6795 ; $6776
	dw Data_74_679d ; $6778
	dw Data_74_67b1 ; $677a
	dw Data_74_67b1 ; $677c
	dw Data_74_67b1 ; $677e
Data_74_6780:
	INCBIN "data/bank_074/d_6780.bin" ; $6780, 3 bytes
Data_74_6783:
	INCBIN "data/bank_074/d_6783.bin" ; $6783, 6 bytes
Data_74_6789:
	INCBIN "data/bank_074/d_6789.bin" ; $6789, 12 bytes
Data_74_6795:
	INCBIN "data/bank_074/d_6795.bin" ; $6795, 8 bytes
Data_74_679d:
	INCBIN "data/bank_074/d_679d.bin" ; $679d, 20 bytes
Data_74_67b1:
	INCBIN "data/bank_074/d_67b1.bin" ; $67b1, 12 bytes
Data_74_67bd:
	db $05, $04, $02, $00 ; count, flags
	dw $67c7, OamPtrs_74_6de0, $67c7, Data_74_67e0, Data_74_68e0, Data_74_69e0 ; body pointers
	INCBIN "data/bank_074/d_67cd.bin" ; $67cd, 19 bytes
Data_74_67e0:
	INCBIN "data/bank_074/d_67e0.bin" ; $67e0, 256 bytes
Data_74_68e0:
	INCBIN "data/bank_074/d_68e0.bin" ; $68e0, 256 bytes
Data_74_69e0:
	INCBIN "data/bank_074/d_69e0.bin" ; $69e0, 1024 bytes
OamPtrs_74_6de0:
	dw Data_74_6df0 ; $6de0
	dw Data_74_6df3 ; $6de2
	dw Data_74_6df9 ; $6de4
	dw Data_74_6e05 ; $6de6
	dw Data_74_6e0d ; $6de8
	dw Data_74_6e21 ; $6dea
	dw Data_74_6e21 ; $6dec
	dw Data_74_6e21 ; $6dee
Data_74_6df0:
	INCBIN "data/bank_074/d_6df0.bin" ; $6df0, 3 bytes
Data_74_6df3:
	INCBIN "data/bank_074/d_6df3.bin" ; $6df3, 6 bytes
Data_74_6df9:
	INCBIN "data/bank_074/d_6df9.bin" ; $6df9, 12 bytes
Data_74_6e05:
	INCBIN "data/bank_074/d_6e05.bin" ; $6e05, 8 bytes
Data_74_6e0d:
	INCBIN "data/bank_074/d_6e0d.bin" ; $6e0d, 20 bytes
Data_74_6e21:
	INCBIN "data/bank_074/d_6e21.bin" ; $6e21, 12 bytes
Data_74_6e2d:
	db $04, $04, $02, $00 ; count, flags
	dw $6e37, OamPtrs_74_7450, $6e37, Data_74_6e50, Data_74_6f50, Data_74_7050 ; body pointers
	INCBIN "data/bank_074/d_6e3d.bin" ; $6e3d, 19 bytes
Data_74_6e50:
	INCBIN "data/bank_074/d_6e50.bin" ; $6e50, 256 bytes
Data_74_6f50:
	INCBIN "data/bank_074/d_6f50.bin" ; $6f50, 256 bytes
Data_74_7050:
	INCBIN "data/bank_074/d_7050.bin" ; $7050, 1024 bytes
OamPtrs_74_7450:
	dw Data_74_7460 ; $7450
	dw Data_74_7463 ; $7452
	dw Data_74_7469 ; $7454
	dw Data_74_7475 ; $7456
	dw Data_74_747d ; $7458
	dw Data_74_7491 ; $745a
	dw Data_74_7491 ; $745c
	dw Data_74_7491 ; $745e
Data_74_7460:
	INCBIN "data/bank_074/d_7460.bin" ; $7460, 3 bytes
Data_74_7463:
	INCBIN "data/bank_074/d_7463.bin" ; $7463, 6 bytes
Data_74_7469:
	INCBIN "data/bank_074/d_7469.bin" ; $7469, 12 bytes
Data_74_7475:
	INCBIN "data/bank_074/d_7475.bin" ; $7475, 8 bytes
Data_74_747d:
	INCBIN "data/bank_074/d_747d.bin" ; $747d, 20 bytes
Data_74_7491:
	INCBIN "data/bank_074/d_7491.bin" ; $7491, 12 bytes
Data_74_749d:
	db $03, $04, $02, $00 ; count, flags
	dw $74a7, OamPtrs_74_7ac0, $74a7, Data_74_74c0, Data_74_75c0, Data_74_76c0 ; body pointers
	INCBIN "data/bank_074/d_74ad.bin" ; $74ad, 19 bytes
Data_74_74c0:
	INCBIN "data/bank_074/d_74c0.bin" ; $74c0, 256 bytes
Data_74_75c0:
	INCBIN "data/bank_074/d_75c0.bin" ; $75c0, 256 bytes
Data_74_76c0:
	INCBIN "data/bank_074/d_76c0.bin" ; $76c0, 1024 bytes
OamPtrs_74_7ac0:
	dw Data_74_7ad0 ; $7ac0
	dw Data_74_7ad3 ; $7ac2
	dw Data_74_7ad9 ; $7ac4
	dw Data_74_7ae5 ; $7ac6
	dw Data_74_7aed ; $7ac8
	dw Data_74_7b01 ; $7aca
	dw Data_74_7b01 ; $7acc
	dw Data_74_7b01 ; $7ace
Data_74_7ad0:
	INCBIN "data/bank_074/d_7ad0.bin" ; $7ad0, 3 bytes
Data_74_7ad3:
	INCBIN "data/bank_074/d_7ad3.bin" ; $7ad3, 6 bytes
Data_74_7ad9:
	INCBIN "data/bank_074/d_7ad9.bin" ; $7ad9, 12 bytes
Data_74_7ae5:
	INCBIN "data/bank_074/d_7ae5.bin" ; $7ae5, 8 bytes
Data_74_7aed:
	INCBIN "data/bank_074/d_7aed.bin" ; $7aed, 20 bytes
Data_74_7b01:
	INCBIN "data/bank_074/d_7b01.bin" ; $7b01, 12 bytes
	ds 1267, $ff ; $7b0d, fill

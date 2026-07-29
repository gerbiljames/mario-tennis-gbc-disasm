SECTION "ROM Bank $74", ROMX[$4000], BANK[$74]

DataPtr_WalkSprite_74_00:
	dw WalkSprite_74_00 ; $4000
DataPtr_WalkSprite_74_01:
	dw WalkSprite_74_01 ; $4002
DataPtr_WalkSprite_74_02:
	dw WalkSprite_74_02 ; $4004
DataPtr_WalkSprite_74_03:
	dw WalkSprite_74_03 ; $4006
DataPtr_WalkSprite_74_04:
	dw WalkSprite_74_04 ; $4008
DataPtr_WalkSprite_74_05:
	dw WalkSprite_74_05 ; $400a
DataPtr_WalkSprite_74_06:
	dw WalkSprite_74_06 ; $400c
DataPtr_WalkSprite_74_07:
	dw WalkSprite_74_07 ; $400e
DataPtr_WalkSprite_74_08:
	dw WalkSprite_74_08 ; $4010
WalkSprite_74_00:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_74_00_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_74_00_Gfx00, WalkSprite_74_00_Gfx01, WalkSprite_74_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_00_Gfx03 ; $4022
	dw WalkSprite_74_00_Gfx03 ; $4024
	dw WalkSprite_74_00_Gfx03 ; $4026
	dw WalkSprite_74_00_Gfx03 ; $4028
	dw WalkSprite_74_00_Gfx04 ; $402a
	dw WalkSprite_74_00_Gfx05 ; $402c
	dw WalkSprite_74_00_Gfx06 ; $402e
WalkSprite_74_00_Gfx00:
	INCBIN "data/bank_074/d_4030.bin" ; $4030, 256 bytes
WalkSprite_74_00_Gfx01:
	INCBIN "data/bank_074/d_4130.bin" ; $4130, 256 bytes
WalkSprite_74_00_Gfx02:
	INCBIN "data/bank_074/d_4230.bin" ; $4230, 256 bytes
WalkSprite_74_00_Gfx03:
	INCBIN "data/bank_074/d_4330.bin" ; $4330, 256 bytes
WalkSprite_74_00_Gfx04:
	INCBIN "data/bank_074/d_4430.bin" ; $4430, 256 bytes
WalkSprite_74_00_Gfx05:
	INCBIN "data/bank_074/d_4530.bin" ; $4530, 256 bytes
WalkSprite_74_00_Gfx06:
	INCBIN "data/bank_074/d_4630.bin" ; $4630, 256 bytes
WalkSprite_74_00_OamPtrs:
	dw WalkSprite_74_00_Oam00 ; $4730
	dw WalkSprite_74_00_Oam01 ; $4732
	dw WalkSprite_74_00_Oam02 ; $4734
	dw WalkSprite_74_00_Oam03 ; $4736
	dw WalkSprite_74_00_Oam04 ; $4738
	dw WalkSprite_74_00_Oam05 ; $473a
	dw WalkSprite_74_00_Oam06 ; $473c
	dw WalkSprite_74_00_Oam06 ; $473e
WalkSprite_74_00_Oam00:
	INCBIN "data/bank_074/d_4740.bin" ; $4740, 3 bytes
WalkSprite_74_00_Oam01:
	INCBIN "data/bank_074/d_4743.bin" ; $4743, 6 bytes
WalkSprite_74_00_Oam02:
	INCBIN "data/bank_074/d_4749.bin" ; $4749, 12 bytes
WalkSprite_74_00_Oam03:
	INCBIN "data/bank_074/d_4755.bin" ; $4755, 8 bytes
WalkSprite_74_00_Oam04:
	INCBIN "data/bank_074/d_475d.bin" ; $475d, 20 bytes
WalkSprite_74_00_Oam05:
	INCBIN "data/bank_074/d_4771.bin" ; $4771, 8 bytes
WalkSprite_74_00_Oam06:
	INCBIN "data/bank_074/d_4779.bin" ; $4779, 12 bytes
WalkSprite_74_01:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_74_01_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_74_01_Gfx00, WalkSprite_74_01_Gfx01, WalkSprite_74_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_01_Gfx02 ; $4795
	dw WalkSprite_74_01_Gfx02 ; $4797
	dw WalkSprite_74_01_Gfx02 ; $4799
	dw WalkSprite_74_01_Gfx02 ; $479b
	dw WalkSprite_74_01_Gfx03 ; $479d
	dw WalkSprite_74_01_Gfx04 ; $479f
	dw WalkSprite_74_01_Gfx05 ; $47a1
Padding_74_0:
	; $47a3, 13 bytes (fill)
	ds 13, $00
WalkSprite_74_01_Gfx00:
	INCBIN "data/bank_074/d_47b0.bin" ; $47b0, 256 bytes
WalkSprite_74_01_Gfx01:
	INCBIN "data/bank_074/d_48b0.bin" ; $48b0, 256 bytes
WalkSprite_74_01_Gfx02:
	INCBIN "data/bank_074/d_49b0.bin" ; $49b0, 256 bytes
WalkSprite_74_01_Gfx03:
	INCBIN "data/bank_074/d_4ab0.bin" ; $4ab0, 256 bytes
WalkSprite_74_01_Gfx04:
	INCBIN "data/bank_074/d_4bb0.bin" ; $4bb0, 256 bytes
WalkSprite_74_01_Gfx05:
	INCBIN "data/bank_074/d_4cb0.bin" ; $4cb0, 256 bytes
WalkSprite_74_01_OamPtrs:
	dw WalkSprite_74_01_Oam00 ; $4db0
	dw WalkSprite_74_01_Oam01 ; $4db2
	dw WalkSprite_74_01_Oam02 ; $4db4
	dw WalkSprite_74_01_Oam03 ; $4db6
	dw WalkSprite_74_01_Oam04 ; $4db8
	dw WalkSprite_74_01_Oam05 ; $4dba
	dw WalkSprite_74_01_Oam05 ; $4dbc
	dw WalkSprite_74_01_Oam05 ; $4dbe
WalkSprite_74_01_Oam00:
	INCBIN "data/bank_074/d_4dc0.bin" ; $4dc0, 3 bytes
WalkSprite_74_01_Oam01:
	INCBIN "data/bank_074/d_4dc3.bin" ; $4dc3, 6 bytes
WalkSprite_74_01_Oam02:
	INCBIN "data/bank_074/d_4dc9.bin" ; $4dc9, 12 bytes
WalkSprite_74_01_Oam03:
	INCBIN "data/bank_074/d_4dd5.bin" ; $4dd5, 8 bytes
WalkSprite_74_01_Oam04:
	INCBIN "data/bank_074/d_4ddd.bin" ; $4ddd, 20 bytes
WalkSprite_74_01_Oam05:
	INCBIN "data/bank_074/d_4df1.bin" ; $4df1, 12 bytes
WalkSprite_74_02:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_74_02_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_74_02_Gfx00, WalkSprite_74_02_Gfx01, WalkSprite_74_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_02_Gfx02 ; $4e0d
	dw WalkSprite_74_02_Gfx02 ; $4e0f
	dw WalkSprite_74_02_Gfx02 ; $4e11
	dw WalkSprite_74_02_Gfx02 ; $4e13
	dw WalkSprite_74_02_Gfx03 ; $4e15
	dw WalkSprite_74_02_Gfx04 ; $4e17
	dw WalkSprite_74_02_Gfx05 ; $4e19
Padding_74_1:
	; $4e1b, 5 bytes (fill)
	ds 5, $00
WalkSprite_74_02_Gfx00:
	INCBIN "data/bank_074/d_4e20.bin" ; $4e20, 256 bytes
WalkSprite_74_02_Gfx01:
	INCBIN "data/bank_074/d_4f20.bin" ; $4f20, 256 bytes
WalkSprite_74_02_Gfx02:
	INCBIN "data/bank_074/d_5020.bin" ; $5020, 256 bytes
WalkSprite_74_02_Gfx03:
	INCBIN "data/bank_074/d_5120.bin" ; $5120, 256 bytes
WalkSprite_74_02_Gfx04:
	INCBIN "data/bank_074/d_5220.bin" ; $5220, 256 bytes
WalkSprite_74_02_Gfx05:
	INCBIN "data/bank_074/d_5320.bin" ; $5320, 256 bytes
WalkSprite_74_02_OamPtrs:
	dw WalkSprite_74_02_Oam00 ; $5420
	dw WalkSprite_74_02_Oam01 ; $5422
	dw WalkSprite_74_02_Oam02 ; $5424
	dw WalkSprite_74_02_Oam03 ; $5426
	dw WalkSprite_74_02_Oam04 ; $5428
	dw WalkSprite_74_02_Oam05 ; $542a
	dw WalkSprite_74_02_Oam05 ; $542c
	dw WalkSprite_74_02_Oam05 ; $542e
WalkSprite_74_02_Oam00:
	INCBIN "data/bank_074/d_5430.bin" ; $5430, 3 bytes
WalkSprite_74_02_Oam01:
	INCBIN "data/bank_074/d_5433.bin" ; $5433, 6 bytes
WalkSprite_74_02_Oam02:
	INCBIN "data/bank_074/d_5439.bin" ; $5439, 12 bytes
WalkSprite_74_02_Oam03:
	INCBIN "data/bank_074/d_5445.bin" ; $5445, 8 bytes
WalkSprite_74_02_Oam04:
	INCBIN "data/bank_074/d_544d.bin" ; $544d, 20 bytes
WalkSprite_74_02_Oam05:
	INCBIN "data/bank_074/d_5461.bin" ; $5461, 12 bytes
WalkSprite_74_03:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_74_03_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_74_03_Gfx00, WalkSprite_74_03_Gfx01, WalkSprite_74_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_03_Gfx02 ; $547d
	dw WalkSprite_74_03_Gfx02 ; $547f
	dw WalkSprite_74_03_Gfx02 ; $5481
	dw WalkSprite_74_03_Gfx02 ; $5483
	dw WalkSprite_74_03_Gfx03 ; $5485
	dw WalkSprite_74_03_Gfx04 ; $5487
	dw WalkSprite_74_03_Gfx05 ; $5489
Padding_74_2:
	; $548b, 5 bytes (fill)
	ds 5, $00
WalkSprite_74_03_Gfx00:
	INCBIN "data/bank_074/d_5490.bin" ; $5490, 256 bytes
WalkSprite_74_03_Gfx01:
	INCBIN "data/bank_074/d_5590.bin" ; $5590, 256 bytes
WalkSprite_74_03_Gfx02:
	INCBIN "data/bank_074/d_5690.bin" ; $5690, 256 bytes
WalkSprite_74_03_Gfx03:
	INCBIN "data/bank_074/d_5790.bin" ; $5790, 256 bytes
WalkSprite_74_03_Gfx04:
	INCBIN "data/bank_074/d_5890.bin" ; $5890, 256 bytes
WalkSprite_74_03_Gfx05:
	INCBIN "data/bank_074/d_5990.bin" ; $5990, 256 bytes
WalkSprite_74_03_OamPtrs:
	dw WalkSprite_74_03_Oam00 ; $5a90
	dw WalkSprite_74_03_Oam01 ; $5a92
	dw WalkSprite_74_03_Oam02 ; $5a94
	dw WalkSprite_74_03_Oam03 ; $5a96
	dw WalkSprite_74_03_Oam04 ; $5a98
	dw WalkSprite_74_03_Oam05 ; $5a9a
	dw WalkSprite_74_03_Oam05 ; $5a9c
	dw WalkSprite_74_03_Oam05 ; $5a9e
WalkSprite_74_03_Oam00:
	INCBIN "data/bank_074/d_5aa0.bin" ; $5aa0, 3 bytes
WalkSprite_74_03_Oam01:
	INCBIN "data/bank_074/d_5aa3.bin" ; $5aa3, 6 bytes
WalkSprite_74_03_Oam02:
	INCBIN "data/bank_074/d_5aa9.bin" ; $5aa9, 12 bytes
WalkSprite_74_03_Oam03:
	INCBIN "data/bank_074/d_5ab5.bin" ; $5ab5, 8 bytes
WalkSprite_74_03_Oam04:
	INCBIN "data/bank_074/d_5abd.bin" ; $5abd, 20 bytes
WalkSprite_74_03_Oam05:
	INCBIN "data/bank_074/d_5ad1.bin" ; $5ad1, 12 bytes
WalkSprite_74_04:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_74_04_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_74_04_Gfx00, WalkSprite_74_04_Gfx01, WalkSprite_74_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_04_Gfx02 ; $5aed
	dw WalkSprite_74_04_Gfx02 ; $5aef
	dw WalkSprite_74_04_Gfx02 ; $5af1
	dw WalkSprite_74_04_Gfx02 ; $5af3
	dw WalkSprite_74_04_Gfx03 ; $5af5
	dw WalkSprite_74_04_Gfx04 ; $5af7
	dw WalkSprite_74_04_Gfx05 ; $5af9
Padding_74_3:
	; $5afb, 5 bytes (fill)
	ds 5, $00
WalkSprite_74_04_Gfx00:
	INCBIN "data/bank_074/d_5b00.bin" ; $5b00, 256 bytes
WalkSprite_74_04_Gfx01:
	INCBIN "data/bank_074/d_5c00.bin" ; $5c00, 256 bytes
WalkSprite_74_04_Gfx02:
	INCBIN "data/bank_074/d_5d00.bin" ; $5d00, 256 bytes
WalkSprite_74_04_Gfx03:
	INCBIN "data/bank_074/d_5e00.bin" ; $5e00, 256 bytes
WalkSprite_74_04_Gfx04:
	INCBIN "data/bank_074/d_5f00.bin" ; $5f00, 256 bytes
WalkSprite_74_04_Gfx05:
	INCBIN "data/bank_074/d_6000.bin" ; $6000, 256 bytes
WalkSprite_74_04_OamPtrs:
	dw WalkSprite_74_04_Oam00 ; $6100
	dw WalkSprite_74_04_Oam01 ; $6102
	dw WalkSprite_74_04_Oam02 ; $6104
	dw WalkSprite_74_04_Oam03 ; $6106
	dw WalkSprite_74_04_Oam04 ; $6108
	dw WalkSprite_74_04_Oam05 ; $610a
	dw WalkSprite_74_04_Oam05 ; $610c
	dw WalkSprite_74_04_Oam05 ; $610e
WalkSprite_74_04_Oam00:
	INCBIN "data/bank_074/d_6110.bin" ; $6110, 3 bytes
WalkSprite_74_04_Oam01:
	INCBIN "data/bank_074/d_6113.bin" ; $6113, 6 bytes
WalkSprite_74_04_Oam02:
	INCBIN "data/bank_074/d_6119.bin" ; $6119, 12 bytes
WalkSprite_74_04_Oam03:
	INCBIN "data/bank_074/d_6125.bin" ; $6125, 8 bytes
WalkSprite_74_04_Oam04:
	INCBIN "data/bank_074/d_612d.bin" ; $612d, 20 bytes
WalkSprite_74_04_Oam05:
	INCBIN "data/bank_074/d_6141.bin" ; $6141, 12 bytes
WalkSprite_74_05:
	db $04, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_74_05_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_74_05_Gfx00, WalkSprite_74_05_Gfx01, WalkSprite_74_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_05_Gfx02 ; $615d
	dw WalkSprite_74_05_Gfx02 ; $615f
	dw WalkSprite_74_05_Gfx02 ; $6161
	dw WalkSprite_74_05_Gfx02 ; $6163
	dw WalkSprite_74_05_Gfx03 ; $6165
	dw WalkSprite_74_05_Gfx04 ; $6167
	dw WalkSprite_74_05_Gfx05 ; $6169
Padding_74_4:
	; $616b, 5 bytes (fill)
	ds 5, $00
WalkSprite_74_05_Gfx00:
	INCBIN "data/bank_074/d_6170.bin" ; $6170, 256 bytes
WalkSprite_74_05_Gfx01:
	INCBIN "data/bank_074/d_6270.bin" ; $6270, 256 bytes
WalkSprite_74_05_Gfx02:
	INCBIN "data/bank_074/d_6370.bin" ; $6370, 256 bytes
WalkSprite_74_05_Gfx03:
	INCBIN "data/bank_074/d_6470.bin" ; $6470, 256 bytes
WalkSprite_74_05_Gfx04:
	INCBIN "data/bank_074/d_6570.bin" ; $6570, 256 bytes
WalkSprite_74_05_Gfx05:
	INCBIN "data/bank_074/d_6670.bin" ; $6670, 256 bytes
WalkSprite_74_05_OamPtrs:
	dw WalkSprite_74_05_Oam00 ; $6770
	dw WalkSprite_74_05_Oam01 ; $6772
	dw WalkSprite_74_05_Oam02 ; $6774
	dw WalkSprite_74_05_Oam03 ; $6776
	dw WalkSprite_74_05_Oam04 ; $6778
	dw WalkSprite_74_05_Oam05 ; $677a
	dw WalkSprite_74_05_Oam05 ; $677c
	dw WalkSprite_74_05_Oam05 ; $677e
WalkSprite_74_05_Oam00:
	INCBIN "data/bank_074/d_6780.bin" ; $6780, 3 bytes
WalkSprite_74_05_Oam01:
	INCBIN "data/bank_074/d_6783.bin" ; $6783, 6 bytes
WalkSprite_74_05_Oam02:
	INCBIN "data/bank_074/d_6789.bin" ; $6789, 12 bytes
WalkSprite_74_05_Oam03:
	INCBIN "data/bank_074/d_6795.bin" ; $6795, 8 bytes
WalkSprite_74_05_Oam04:
	INCBIN "data/bank_074/d_679d.bin" ; $679d, 20 bytes
WalkSprite_74_05_Oam05:
	INCBIN "data/bank_074/d_67b1.bin" ; $67b1, 12 bytes
WalkSprite_74_06:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_74_06_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_74_06_Gfx00, WalkSprite_74_06_Gfx01, WalkSprite_74_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_06_Gfx02 ; $67cd
	dw WalkSprite_74_06_Gfx02 ; $67cf
	dw WalkSprite_74_06_Gfx02 ; $67d1
	dw WalkSprite_74_06_Gfx02 ; $67d3
	dw WalkSprite_74_06_Gfx03 ; $67d5
	dw WalkSprite_74_06_Gfx04 ; $67d7
	dw WalkSprite_74_06_Gfx05 ; $67d9
Padding_74_5:
	; $67db, 5 bytes (fill)
	ds 5, $00
WalkSprite_74_06_Gfx00:
	INCBIN "data/bank_074/d_67e0.bin" ; $67e0, 256 bytes
WalkSprite_74_06_Gfx01:
	INCBIN "data/bank_074/d_68e0.bin" ; $68e0, 256 bytes
WalkSprite_74_06_Gfx02:
	INCBIN "data/bank_074/d_69e0.bin" ; $69e0, 256 bytes
WalkSprite_74_06_Gfx03:
	INCBIN "data/bank_074/d_6ae0.bin" ; $6ae0, 256 bytes
WalkSprite_74_06_Gfx04:
	INCBIN "data/bank_074/d_6be0.bin" ; $6be0, 256 bytes
WalkSprite_74_06_Gfx05:
	INCBIN "data/bank_074/d_6ce0.bin" ; $6ce0, 256 bytes
WalkSprite_74_06_OamPtrs:
	dw WalkSprite_74_06_Oam00 ; $6de0
	dw WalkSprite_74_06_Oam01 ; $6de2
	dw WalkSprite_74_06_Oam02 ; $6de4
	dw WalkSprite_74_06_Oam03 ; $6de6
	dw WalkSprite_74_06_Oam04 ; $6de8
	dw WalkSprite_74_06_Oam05 ; $6dea
	dw WalkSprite_74_06_Oam05 ; $6dec
	dw WalkSprite_74_06_Oam05 ; $6dee
WalkSprite_74_06_Oam00:
	INCBIN "data/bank_074/d_6df0.bin" ; $6df0, 3 bytes
WalkSprite_74_06_Oam01:
	INCBIN "data/bank_074/d_6df3.bin" ; $6df3, 6 bytes
WalkSprite_74_06_Oam02:
	INCBIN "data/bank_074/d_6df9.bin" ; $6df9, 12 bytes
WalkSprite_74_06_Oam03:
	INCBIN "data/bank_074/d_6e05.bin" ; $6e05, 8 bytes
WalkSprite_74_06_Oam04:
	INCBIN "data/bank_074/d_6e0d.bin" ; $6e0d, 20 bytes
WalkSprite_74_06_Oam05:
	INCBIN "data/bank_074/d_6e21.bin" ; $6e21, 12 bytes
WalkSprite_74_07:
	db $04, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_74_07_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_74_07_Gfx00, WalkSprite_74_07_Gfx01, WalkSprite_74_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_07_Gfx02 ; $6e3d
	dw WalkSprite_74_07_Gfx02 ; $6e3f
	dw WalkSprite_74_07_Gfx02 ; $6e41
	dw WalkSprite_74_07_Gfx02 ; $6e43
	dw WalkSprite_74_07_Gfx03 ; $6e45
	dw WalkSprite_74_07_Gfx04 ; $6e47
	dw WalkSprite_74_07_Gfx05 ; $6e49
Padding_74_6:
	; $6e4b, 5 bytes (fill)
	ds 5, $00
WalkSprite_74_07_Gfx00:
	INCBIN "data/bank_074/d_6e50.bin" ; $6e50, 256 bytes
WalkSprite_74_07_Gfx01:
	INCBIN "data/bank_074/d_6f50.bin" ; $6f50, 256 bytes
WalkSprite_74_07_Gfx02:
	INCBIN "data/bank_074/d_7050.bin" ; $7050, 256 bytes
WalkSprite_74_07_Gfx03:
	INCBIN "data/bank_074/d_7150.bin" ; $7150, 256 bytes
WalkSprite_74_07_Gfx04:
	INCBIN "data/bank_074/d_7250.bin" ; $7250, 256 bytes
WalkSprite_74_07_Gfx05:
	INCBIN "data/bank_074/d_7350.bin" ; $7350, 256 bytes
WalkSprite_74_07_OamPtrs:
	dw WalkSprite_74_07_Oam00 ; $7450
	dw WalkSprite_74_07_Oam01 ; $7452
	dw WalkSprite_74_07_Oam02 ; $7454
	dw WalkSprite_74_07_Oam03 ; $7456
	dw WalkSprite_74_07_Oam04 ; $7458
	dw WalkSprite_74_07_Oam05 ; $745a
	dw WalkSprite_74_07_Oam05 ; $745c
	dw WalkSprite_74_07_Oam05 ; $745e
WalkSprite_74_07_Oam00:
	INCBIN "data/bank_074/d_7460.bin" ; $7460, 3 bytes
WalkSprite_74_07_Oam01:
	INCBIN "data/bank_074/d_7463.bin" ; $7463, 6 bytes
WalkSprite_74_07_Oam02:
	INCBIN "data/bank_074/d_7469.bin" ; $7469, 12 bytes
WalkSprite_74_07_Oam03:
	INCBIN "data/bank_074/d_7475.bin" ; $7475, 8 bytes
WalkSprite_74_07_Oam04:
	INCBIN "data/bank_074/d_747d.bin" ; $747d, 20 bytes
WalkSprite_74_07_Oam05:
	INCBIN "data/bank_074/d_7491.bin" ; $7491, 12 bytes
WalkSprite_74_08:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_74_08_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_74_08_Gfx00, WalkSprite_74_08_Gfx01, WalkSprite_74_08_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_08_Gfx02 ; $74ad
	dw WalkSprite_74_08_Gfx02 ; $74af
	dw WalkSprite_74_08_Gfx02 ; $74b1
	dw WalkSprite_74_08_Gfx02 ; $74b3
	dw WalkSprite_74_08_Gfx03 ; $74b5
	dw WalkSprite_74_08_Gfx04 ; $74b7
	dw WalkSprite_74_08_Gfx05 ; $74b9
Padding_74_7:
	; $74bb, 5 bytes (fill)
	ds 5, $00
WalkSprite_74_08_Gfx00:
	INCBIN "data/bank_074/d_74c0.bin" ; $74c0, 256 bytes
WalkSprite_74_08_Gfx01:
	INCBIN "data/bank_074/d_75c0.bin" ; $75c0, 256 bytes
WalkSprite_74_08_Gfx02:
	INCBIN "data/bank_074/d_76c0.bin" ; $76c0, 256 bytes
WalkSprite_74_08_Gfx03:
	INCBIN "data/bank_074/d_77c0.bin" ; $77c0, 256 bytes
WalkSprite_74_08_Gfx04:
	INCBIN "data/bank_074/d_78c0.bin" ; $78c0, 256 bytes
WalkSprite_74_08_Gfx05:
	INCBIN "data/bank_074/d_79c0.bin" ; $79c0, 256 bytes
WalkSprite_74_08_OamPtrs:
	dw WalkSprite_74_08_Oam00 ; $7ac0
	dw WalkSprite_74_08_Oam01 ; $7ac2
	dw WalkSprite_74_08_Oam02 ; $7ac4
	dw WalkSprite_74_08_Oam03 ; $7ac6
	dw WalkSprite_74_08_Oam04 ; $7ac8
	dw WalkSprite_74_08_Oam05 ; $7aca
	dw WalkSprite_74_08_Oam05 ; $7acc
	dw WalkSprite_74_08_Oam05 ; $7ace
WalkSprite_74_08_Oam00:
	INCBIN "data/bank_074/d_7ad0.bin" ; $7ad0, 3 bytes
WalkSprite_74_08_Oam01:
	INCBIN "data/bank_074/d_7ad3.bin" ; $7ad3, 6 bytes
WalkSprite_74_08_Oam02:
	INCBIN "data/bank_074/d_7ad9.bin" ; $7ad9, 12 bytes
WalkSprite_74_08_Oam03:
	INCBIN "data/bank_074/d_7ae5.bin" ; $7ae5, 8 bytes
WalkSprite_74_08_Oam04:
	INCBIN "data/bank_074/d_7aed.bin" ; $7aed, 20 bytes
WalkSprite_74_08_Oam05:
	INCBIN "data/bank_074/d_7b01.bin" ; $7b01, 12 bytes
	; $7b0d, 1267 bytes fill to bank end (linker-padded)

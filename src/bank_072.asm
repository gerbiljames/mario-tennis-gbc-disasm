SECTION "ROM Bank $72", ROMX[$4000], BANK[$72]

DataPtr_WalkSprite_72_00:
	dw WalkSprite_72_00 ; $4000
DataPtr_WalkSprite_72_01:
	dw WalkSprite_72_01 ; $4002
DataPtr_WalkSprite_72_02:
	dw WalkSprite_72_02 ; $4004
DataPtr_WalkSprite_72_03:
	dw WalkSprite_72_03 ; $4006
DataPtr_WalkSprite_72_04:
	dw WalkSprite_72_04 ; $4008
DataPtr_WalkSprite_72_05:
	dw WalkSprite_72_05 ; $400a
DataPtr_WalkSprite_72_06:
	dw WalkSprite_72_06 ; $400c
DataPtr_WalkSprite_72_07:
	dw WalkSprite_72_07 ; $400e
DataPtr_WalkSprite_72_08:
	dw WalkSprite_72_08 ; $4010
WalkSprite_72_00:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_72_00_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_72_00_Gfx00, WalkSprite_72_00_Gfx01, WalkSprite_72_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_00_Gfx02 ; $4022
	dw WalkSprite_72_00_Gfx02 ; $4024
	dw WalkSprite_72_00_Gfx02 ; $4026
	dw WalkSprite_72_00_Gfx02 ; $4028
	dw WalkSprite_72_00_Gfx03 ; $402a
	dw WalkSprite_72_00_Gfx04 ; $402c
	dw WalkSprite_72_00_Gfx05 ; $402e
WalkSprite_72_00_Gfx00:
	INCBIN "data/bank_072/d_4030.bin" ; $4030, 256 bytes
WalkSprite_72_00_Gfx01:
	INCBIN "data/bank_072/d_4130.bin" ; $4130, 256 bytes
WalkSprite_72_00_Gfx02:
	INCBIN "data/bank_072/d_4230.bin" ; $4230, 256 bytes
WalkSprite_72_00_Gfx03:
	INCBIN "data/bank_072/d_4330.bin" ; $4330, 256 bytes
WalkSprite_72_00_Gfx04:
	INCBIN "data/bank_072/d_4430.bin" ; $4430, 256 bytes
WalkSprite_72_00_Gfx05:
	INCBIN "data/bank_072/d_4530.bin" ; $4530, 256 bytes
WalkSprite_72_00_OamPtrs:
	dw WalkSprite_72_00_Oam00 ; $4630
	dw WalkSprite_72_00_Oam01 ; $4632
	dw WalkSprite_72_00_Oam02 ; $4634
	dw WalkSprite_72_00_Oam03 ; $4636
	dw WalkSprite_72_00_Oam04 ; $4638
	dw WalkSprite_72_00_Oam05 ; $463a
	dw WalkSprite_72_00_Oam05 ; $463c
	dw WalkSprite_72_00_Oam05 ; $463e
WalkSprite_72_00_Oam00:
	INCBIN "data/bank_072/d_4640.bin" ; $4640, 3 bytes
WalkSprite_72_00_Oam01:
	INCBIN "data/bank_072/d_4643.bin" ; $4643, 6 bytes
WalkSprite_72_00_Oam02:
	INCBIN "data/bank_072/d_4649.bin" ; $4649, 12 bytes
WalkSprite_72_00_Oam03:
	INCBIN "data/bank_072/d_4655.bin" ; $4655, 8 bytes
WalkSprite_72_00_Oam04:
	INCBIN "data/bank_072/d_465d.bin" ; $465d, 20 bytes
WalkSprite_72_00_Oam05:
	INCBIN "data/bank_072/d_4671.bin" ; $4671, 12 bytes
WalkSprite_72_01:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_72_01_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_72_01_Gfx00, WalkSprite_72_01_Gfx01, WalkSprite_72_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_01_Gfx02 ; $468d
	dw WalkSprite_72_01_Gfx02 ; $468f
	dw WalkSprite_72_01_Gfx02 ; $4691
	dw WalkSprite_72_01_Gfx02 ; $4693
	dw WalkSprite_72_01_Gfx03 ; $4695
	dw WalkSprite_72_01_Gfx04 ; $4697
	dw WalkSprite_72_01_Gfx05 ; $4699
Padding_72_0:
	; $469b, 5 bytes (fill)
	ds 5, $00
WalkSprite_72_01_Gfx00:
	INCBIN "data/bank_072/d_46a0.bin" ; $46a0, 256 bytes
WalkSprite_72_01_Gfx01:
	INCBIN "data/bank_072/d_47a0.bin" ; $47a0, 256 bytes
WalkSprite_72_01_Gfx02:
	INCBIN "data/bank_072/d_48a0.bin" ; $48a0, 256 bytes
WalkSprite_72_01_Gfx03:
	INCBIN "data/bank_072/d_49a0.bin" ; $49a0, 256 bytes
WalkSprite_72_01_Gfx04:
	INCBIN "data/bank_072/d_4aa0.bin" ; $4aa0, 256 bytes
WalkSprite_72_01_Gfx05:
	INCBIN "data/bank_072/d_4ba0.bin" ; $4ba0, 256 bytes
WalkSprite_72_01_OamPtrs:
	dw WalkSprite_72_01_Oam00 ; $4ca0
	dw WalkSprite_72_01_Oam01 ; $4ca2
	dw WalkSprite_72_01_Oam02 ; $4ca4
	dw WalkSprite_72_01_Oam03 ; $4ca6
	dw WalkSprite_72_01_Oam04 ; $4ca8
	dw WalkSprite_72_01_Oam05 ; $4caa
	dw WalkSprite_72_01_Oam05 ; $4cac
	dw WalkSprite_72_01_Oam05 ; $4cae
WalkSprite_72_01_Oam00:
	INCBIN "data/bank_072/d_4cb0.bin" ; $4cb0, 3 bytes
WalkSprite_72_01_Oam01:
	INCBIN "data/bank_072/d_4cb3.bin" ; $4cb3, 6 bytes
WalkSprite_72_01_Oam02:
	INCBIN "data/bank_072/d_4cb9.bin" ; $4cb9, 12 bytes
WalkSprite_72_01_Oam03:
	INCBIN "data/bank_072/d_4cc5.bin" ; $4cc5, 8 bytes
WalkSprite_72_01_Oam04:
	INCBIN "data/bank_072/d_4ccd.bin" ; $4ccd, 20 bytes
WalkSprite_72_01_Oam05:
	INCBIN "data/bank_072/d_4ce1.bin" ; $4ce1, 12 bytes
WalkSprite_72_02:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_72_02_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_72_02_Gfx00, WalkSprite_72_02_Gfx01, WalkSprite_72_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_02_Gfx03 ; $4cfd
	dw WalkSprite_72_02_Gfx04 ; $4cff
	dw WalkSprite_72_02_Gfx05 ; $4d01
	dw WalkSprite_72_02_Gfx05 ; $4d03
	dw WalkSprite_72_02_Gfx06 ; $4d05
	dw WalkSprite_72_02_Gfx07 ; $4d07
	dw WalkSprite_72_02_Gfx08 ; $4d09
Padding_72_1:
	; $4d0b, 5 bytes (fill)
	ds 5, $00
WalkSprite_72_02_Gfx00:
	INCBIN "data/bank_072/d_4d10.bin" ; $4d10, 256 bytes
WalkSprite_72_02_Gfx01:
	INCBIN "data/bank_072/d_4e10.bin" ; $4e10, 256 bytes
WalkSprite_72_02_Gfx02:
	INCBIN "data/bank_072/d_4f10.bin" ; $4f10, 256 bytes
WalkSprite_72_02_Gfx03:
	INCBIN "data/bank_072/d_5010.bin" ; $5010, 256 bytes
WalkSprite_72_02_Gfx04:
	INCBIN "data/bank_072/d_5110.bin" ; $5110, 256 bytes
WalkSprite_72_02_Gfx05:
	INCBIN "data/bank_072/d_5210.bin" ; $5210, 256 bytes
WalkSprite_72_02_Gfx06:
	INCBIN "data/bank_072/d_5310.bin" ; $5310, 256 bytes
WalkSprite_72_02_Gfx07:
	INCBIN "data/bank_072/d_5410.bin" ; $5410, 256 bytes
WalkSprite_72_02_Gfx08:
	INCBIN "data/bank_072/d_5510.bin" ; $5510, 256 bytes
WalkSprite_72_02_OamPtrs:
	dw WalkSprite_72_02_Oam00 ; $5610
	dw WalkSprite_72_02_Oam01 ; $5612
	dw WalkSprite_72_02_Oam02 ; $5614
	dw WalkSprite_72_02_Oam03 ; $5616
	dw WalkSprite_72_02_Oam04 ; $5618
	dw WalkSprite_72_02_Oam05 ; $561a
	dw WalkSprite_72_02_Oam06 ; $561c
	dw WalkSprite_72_02_Oam07 ; $561e
WalkSprite_72_02_Oam00:
	INCBIN "data/bank_072/d_5620.bin" ; $5620, 3 bytes
WalkSprite_72_02_Oam01:
	INCBIN "data/bank_072/d_5623.bin" ; $5623, 6 bytes
WalkSprite_72_02_Oam02:
	INCBIN "data/bank_072/d_5629.bin" ; $5629, 12 bytes
WalkSprite_72_02_Oam03:
	INCBIN "data/bank_072/d_5635.bin" ; $5635, 8 bytes
WalkSprite_72_02_Oam04:
	INCBIN "data/bank_072/d_563d.bin" ; $563d, 20 bytes
WalkSprite_72_02_Oam05:
	INCBIN "data/bank_072/d_5651.bin" ; $5651, 8 bytes
WalkSprite_72_02_Oam06:
	INCBIN "data/bank_072/d_5659.bin" ; $5659, 5 bytes
WalkSprite_72_02_Oam07:
	INCBIN "data/bank_072/d_565e.bin" ; $565e, 12 bytes
WalkSprite_72_03:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_72_03_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_72_03_Gfx00, WalkSprite_72_03_Gfx01, WalkSprite_72_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_03_Gfx02 ; $567a
	dw WalkSprite_72_03_Gfx02 ; $567c
	dw WalkSprite_72_03_Gfx02 ; $567e
	dw WalkSprite_72_03_Gfx02 ; $5680
	dw WalkSprite_72_03_Gfx03 ; $5682
	dw WalkSprite_72_03_Gfx04 ; $5684
	dw WalkSprite_72_03_Gfx05 ; $5686
Padding_72_2:
	; $5688, 8 bytes (fill)
	ds 8, $00
WalkSprite_72_03_Gfx00:
	INCBIN "data/bank_072/d_5690.bin" ; $5690, 256 bytes
WalkSprite_72_03_Gfx01:
	INCBIN "data/bank_072/d_5790.bin" ; $5790, 256 bytes
WalkSprite_72_03_Gfx02:
	INCBIN "data/bank_072/d_5890.bin" ; $5890, 256 bytes
WalkSprite_72_03_Gfx03:
	INCBIN "data/bank_072/d_5990.bin" ; $5990, 256 bytes
WalkSprite_72_03_Gfx04:
	INCBIN "data/bank_072/d_5a90.bin" ; $5a90, 256 bytes
WalkSprite_72_03_Gfx05:
	INCBIN "data/bank_072/d_5b90.bin" ; $5b90, 256 bytes
WalkSprite_72_03_OamPtrs:
	dw WalkSprite_72_03_Oam00 ; $5c90
	dw WalkSprite_72_03_Oam01 ; $5c92
	dw WalkSprite_72_03_Oam02 ; $5c94
	dw WalkSprite_72_03_Oam03 ; $5c96
	dw WalkSprite_72_03_Oam04 ; $5c98
	dw WalkSprite_72_03_Oam05 ; $5c9a
	dw WalkSprite_72_03_Oam05 ; $5c9c
	dw WalkSprite_72_03_Oam05 ; $5c9e
WalkSprite_72_03_Oam00:
	INCBIN "data/bank_072/d_5ca0.bin" ; $5ca0, 3 bytes
WalkSprite_72_03_Oam01:
	INCBIN "data/bank_072/d_5ca3.bin" ; $5ca3, 6 bytes
WalkSprite_72_03_Oam02:
	INCBIN "data/bank_072/d_5ca9.bin" ; $5ca9, 12 bytes
WalkSprite_72_03_Oam03:
	INCBIN "data/bank_072/d_5cb5.bin" ; $5cb5, 8 bytes
WalkSprite_72_03_Oam04:
	INCBIN "data/bank_072/d_5cbd.bin" ; $5cbd, 20 bytes
WalkSprite_72_03_Oam05:
	INCBIN "data/bank_072/d_5cd1.bin" ; $5cd1, 12 bytes
WalkSprite_72_04:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_72_04_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_72_04_Gfx00, WalkSprite_72_04_Gfx01, WalkSprite_72_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_04_Gfx02 ; $5ced
	dw WalkSprite_72_04_Gfx02 ; $5cef
	dw WalkSprite_72_04_Gfx02 ; $5cf1
	dw WalkSprite_72_04_Gfx02 ; $5cf3
	dw WalkSprite_72_04_Gfx03 ; $5cf5
	dw WalkSprite_72_04_Gfx04 ; $5cf7
	dw WalkSprite_72_04_Gfx05 ; $5cf9
Padding_72_3:
	; $5cfb, 5 bytes (fill)
	ds 5, $00
WalkSprite_72_04_Gfx00:
	INCBIN "data/bank_072/d_5d00.bin" ; $5d00, 256 bytes
WalkSprite_72_04_Gfx01:
	INCBIN "data/bank_072/d_5e00.bin" ; $5e00, 256 bytes
WalkSprite_72_04_Gfx02:
	INCBIN "data/bank_072/d_5f00.bin" ; $5f00, 256 bytes
WalkSprite_72_04_Gfx03:
	INCBIN "data/bank_072/d_6000.bin" ; $6000, 256 bytes
WalkSprite_72_04_Gfx04:
	INCBIN "data/bank_072/d_6100.bin" ; $6100, 256 bytes
WalkSprite_72_04_Gfx05:
	INCBIN "data/bank_072/d_6200.bin" ; $6200, 256 bytes
WalkSprite_72_04_OamPtrs:
	dw WalkSprite_72_04_Oam00 ; $6300
	dw WalkSprite_72_04_Oam01 ; $6302
	dw WalkSprite_72_04_Oam02 ; $6304
	dw WalkSprite_72_04_Oam03 ; $6306
	dw WalkSprite_72_04_Oam04 ; $6308
	dw WalkSprite_72_04_Oam05 ; $630a
	dw WalkSprite_72_04_Oam05 ; $630c
	dw WalkSprite_72_04_Oam05 ; $630e
WalkSprite_72_04_Oam00:
	INCBIN "data/bank_072/d_6310.bin" ; $6310, 3 bytes
WalkSprite_72_04_Oam01:
	INCBIN "data/bank_072/d_6313.bin" ; $6313, 6 bytes
WalkSprite_72_04_Oam02:
	INCBIN "data/bank_072/d_6319.bin" ; $6319, 12 bytes
WalkSprite_72_04_Oam03:
	INCBIN "data/bank_072/d_6325.bin" ; $6325, 8 bytes
WalkSprite_72_04_Oam04:
	INCBIN "data/bank_072/d_632d.bin" ; $632d, 20 bytes
WalkSprite_72_04_Oam05:
	INCBIN "data/bank_072/d_6341.bin" ; $6341, 12 bytes
WalkSprite_72_05:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_72_05_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_72_05_Gfx00, WalkSprite_72_05_Gfx01, WalkSprite_72_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_05_Gfx02 ; $635d
	dw WalkSprite_72_05_Gfx02 ; $635f
	dw WalkSprite_72_05_Gfx02 ; $6361
	dw WalkSprite_72_05_Gfx02 ; $6363
	dw WalkSprite_72_05_Gfx03 ; $6365
	dw WalkSprite_72_05_Gfx04 ; $6367
	dw WalkSprite_72_05_Gfx05 ; $6369
Padding_72_4:
	; $636b, 5 bytes (fill)
	ds 5, $00
WalkSprite_72_05_Gfx00:
	INCBIN "data/bank_072/d_6370.bin" ; $6370, 256 bytes
WalkSprite_72_05_Gfx01:
	INCBIN "data/bank_072/d_6470.bin" ; $6470, 256 bytes
WalkSprite_72_05_Gfx02:
	INCBIN "data/bank_072/d_6570.bin" ; $6570, 256 bytes
WalkSprite_72_05_Gfx03:
	INCBIN "data/bank_072/d_6670.bin" ; $6670, 256 bytes
WalkSprite_72_05_Gfx04:
	INCBIN "data/bank_072/d_6770.bin" ; $6770, 256 bytes
WalkSprite_72_05_Gfx05:
	INCBIN "data/bank_072/d_6870.bin" ; $6870, 256 bytes
WalkSprite_72_05_OamPtrs:
	dw WalkSprite_72_05_Oam00 ; $6970
	dw WalkSprite_72_05_Oam01 ; $6972
	dw WalkSprite_72_05_Oam02 ; $6974
	dw WalkSprite_72_05_Oam03 ; $6976
	dw WalkSprite_72_05_Oam04 ; $6978
	dw WalkSprite_72_05_Oam05 ; $697a
	dw WalkSprite_72_05_Oam05 ; $697c
	dw WalkSprite_72_05_Oam05 ; $697e
WalkSprite_72_05_Oam00:
	INCBIN "data/bank_072/d_6980.bin" ; $6980, 3 bytes
WalkSprite_72_05_Oam01:
	INCBIN "data/bank_072/d_6983.bin" ; $6983, 6 bytes
WalkSprite_72_05_Oam02:
	INCBIN "data/bank_072/d_6989.bin" ; $6989, 12 bytes
WalkSprite_72_05_Oam03:
	INCBIN "data/bank_072/d_6995.bin" ; $6995, 8 bytes
WalkSprite_72_05_Oam04:
	INCBIN "data/bank_072/d_699d.bin" ; $699d, 20 bytes
WalkSprite_72_05_Oam05:
	INCBIN "data/bank_072/d_69b1.bin" ; $69b1, 12 bytes
WalkSprite_72_06:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_72_06_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_72_06_Gfx00, WalkSprite_72_06_Gfx01, WalkSprite_72_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_06_Gfx02 ; $69cd
	dw WalkSprite_72_06_Gfx02 ; $69cf
	dw WalkSprite_72_06_Gfx02 ; $69d1
	dw WalkSprite_72_06_Gfx02 ; $69d3
	dw WalkSprite_72_06_Gfx03 ; $69d5
	dw WalkSprite_72_06_Gfx04 ; $69d7
	dw WalkSprite_72_06_Gfx05 ; $69d9
Padding_72_5:
	; $69db, 5 bytes (fill)
	ds 5, $00
WalkSprite_72_06_Gfx00:
	INCBIN "data/bank_072/d_69e0.bin" ; $69e0, 256 bytes
WalkSprite_72_06_Gfx01:
	INCBIN "data/bank_072/d_6ae0.bin" ; $6ae0, 256 bytes
WalkSprite_72_06_Gfx02:
	INCBIN "data/bank_072/d_6be0.bin" ; $6be0, 256 bytes
WalkSprite_72_06_Gfx03:
	INCBIN "data/bank_072/d_6ce0.bin" ; $6ce0, 256 bytes
WalkSprite_72_06_Gfx04:
	INCBIN "data/bank_072/d_6de0.bin" ; $6de0, 256 bytes
WalkSprite_72_06_Gfx05:
	INCBIN "data/bank_072/d_6ee0.bin" ; $6ee0, 256 bytes
WalkSprite_72_06_OamPtrs:
	dw WalkSprite_72_06_Oam00 ; $6fe0
	dw WalkSprite_72_06_Oam01 ; $6fe2
	dw WalkSprite_72_06_Oam02 ; $6fe4
	dw WalkSprite_72_06_Oam03 ; $6fe6
	dw WalkSprite_72_06_Oam04 ; $6fe8
	dw WalkSprite_72_06_Oam05 ; $6fea
	dw WalkSprite_72_06_Oam05 ; $6fec
	dw WalkSprite_72_06_Oam05 ; $6fee
WalkSprite_72_06_Oam00:
	INCBIN "data/bank_072/d_6ff0.bin" ; $6ff0, 3 bytes
WalkSprite_72_06_Oam01:
	INCBIN "data/bank_072/d_6ff3.bin" ; $6ff3, 6 bytes
WalkSprite_72_06_Oam02:
	INCBIN "data/bank_072/d_6ff9.bin" ; $6ff9, 12 bytes
WalkSprite_72_06_Oam03:
	INCBIN "data/bank_072/d_7005.bin" ; $7005, 8 bytes
WalkSprite_72_06_Oam04:
	INCBIN "data/bank_072/d_700d.bin" ; $700d, 20 bytes
WalkSprite_72_06_Oam05:
	INCBIN "data/bank_072/d_7021.bin" ; $7021, 12 bytes
WalkSprite_72_07:
	db $04, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_72_07_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_72_07_Gfx00, WalkSprite_72_07_Gfx01, WalkSprite_72_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_07_Gfx02 ; $703d
	dw WalkSprite_72_07_Gfx02 ; $703f
	dw WalkSprite_72_07_Gfx02 ; $7041
	dw WalkSprite_72_07_Gfx02 ; $7043
	dw WalkSprite_72_07_Gfx03 ; $7045
	dw WalkSprite_72_07_Gfx04 ; $7047
	dw WalkSprite_72_07_Gfx05 ; $7049
Padding_72_6:
	; $704b, 5 bytes (fill)
	ds 5, $00
WalkSprite_72_07_Gfx00:
	INCBIN "data/bank_072/d_7050.bin" ; $7050, 256 bytes
WalkSprite_72_07_Gfx01:
	INCBIN "data/bank_072/d_7150.bin" ; $7150, 256 bytes
WalkSprite_72_07_Gfx02:
	INCBIN "data/bank_072/d_7250.bin" ; $7250, 256 bytes
WalkSprite_72_07_Gfx03:
	INCBIN "data/bank_072/d_7350.bin" ; $7350, 256 bytes
WalkSprite_72_07_Gfx04:
	INCBIN "data/bank_072/d_7450.bin" ; $7450, 256 bytes
WalkSprite_72_07_Gfx05:
	INCBIN "data/bank_072/d_7550.bin" ; $7550, 256 bytes
WalkSprite_72_07_OamPtrs:
	dw WalkSprite_72_07_Oam00 ; $7650
	dw WalkSprite_72_07_Oam01 ; $7652
	dw WalkSprite_72_07_Oam02 ; $7654
	dw WalkSprite_72_07_Oam03 ; $7656
	dw WalkSprite_72_07_Oam04 ; $7658
	dw WalkSprite_72_07_Oam05 ; $765a
	dw WalkSprite_72_07_Oam05 ; $765c
	dw WalkSprite_72_07_Oam05 ; $765e
WalkSprite_72_07_Oam00:
	INCBIN "data/bank_072/d_7660.bin" ; $7660, 3 bytes
WalkSprite_72_07_Oam01:
	INCBIN "data/bank_072/d_7663.bin" ; $7663, 6 bytes
WalkSprite_72_07_Oam02:
	INCBIN "data/bank_072/d_7669.bin" ; $7669, 12 bytes
WalkSprite_72_07_Oam03:
	INCBIN "data/bank_072/d_7675.bin" ; $7675, 8 bytes
WalkSprite_72_07_Oam04:
	INCBIN "data/bank_072/d_767d.bin" ; $767d, 20 bytes
WalkSprite_72_07_Oam05:
	INCBIN "data/bank_072/d_7691.bin" ; $7691, 12 bytes
WalkSprite_72_08:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_72_08_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_72_08_Gfx00, WalkSprite_72_08_Gfx01, WalkSprite_72_08_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_08_Gfx02 ; $76ad
	dw WalkSprite_72_08_Gfx02 ; $76af
	dw WalkSprite_72_08_Gfx02 ; $76b1
	dw WalkSprite_72_08_Gfx02 ; $76b3
	dw WalkSprite_72_08_Gfx03 ; $76b5
	dw WalkSprite_72_08_Gfx04 ; $76b7
	dw WalkSprite_72_08_Gfx05 ; $76b9
Padding_72_7:
	; $76bb, 5 bytes (fill)
	ds 5, $00
WalkSprite_72_08_Gfx00:
	INCBIN "data/bank_072/d_76c0.bin" ; $76c0, 256 bytes
WalkSprite_72_08_Gfx01:
	INCBIN "data/bank_072/d_77c0.bin" ; $77c0, 256 bytes
WalkSprite_72_08_Gfx02:
	INCBIN "data/bank_072/d_78c0.bin" ; $78c0, 256 bytes
WalkSprite_72_08_Gfx03:
	INCBIN "data/bank_072/d_79c0.bin" ; $79c0, 256 bytes
WalkSprite_72_08_Gfx04:
	INCBIN "data/bank_072/d_7ac0.bin" ; $7ac0, 256 bytes
WalkSprite_72_08_Gfx05:
	INCBIN "data/bank_072/d_7bc0.bin" ; $7bc0, 256 bytes
WalkSprite_72_08_OamPtrs:
	dw WalkSprite_72_08_Oam00 ; $7cc0
	dw WalkSprite_72_08_Oam01 ; $7cc2
	dw WalkSprite_72_08_Oam02 ; $7cc4
	dw WalkSprite_72_08_Oam03 ; $7cc6
	dw WalkSprite_72_08_Oam04 ; $7cc8
	dw WalkSprite_72_08_Oam05 ; $7cca
	dw WalkSprite_72_08_Oam05 ; $7ccc
	dw WalkSprite_72_08_Oam05 ; $7cce
WalkSprite_72_08_Oam00:
	INCBIN "data/bank_072/d_7cd0.bin" ; $7cd0, 3 bytes
WalkSprite_72_08_Oam01:
	INCBIN "data/bank_072/d_7cd3.bin" ; $7cd3, 6 bytes
WalkSprite_72_08_Oam02:
	INCBIN "data/bank_072/d_7cd9.bin" ; $7cd9, 12 bytes
WalkSprite_72_08_Oam03:
	INCBIN "data/bank_072/d_7ce5.bin" ; $7ce5, 8 bytes
WalkSprite_72_08_Oam04:
	INCBIN "data/bank_072/d_7ced.bin" ; $7ced, 20 bytes
WalkSprite_72_08_Oam05:
	INCBIN "data/bank_072/d_7d01.bin" ; $7d01, 12 bytes
	; $7d0d, 755 bytes fill to bank end (linker-padded)

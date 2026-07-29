SECTION "ROM Bank $70", ROMX[$4000], BANK[$70]

DataPtr_WalkSprite_70_00:
	dw WalkSprite_70_00 ; $4000
DataPtr_WalkSprite_70_01:
	dw WalkSprite_70_01 ; $4002
DataPtr_WalkSprite_70_02:
	dw WalkSprite_70_02 ; $4004
DataPtr_WalkSprite_70_03:
	dw WalkSprite_70_03 ; $4006
DataPtr_WalkSprite_70_04:
	dw WalkSprite_70_04 ; $4008
DataPtr_WalkSprite_70_05:
	dw WalkSprite_70_05 ; $400a
DataPtr_WalkSprite_70_06:
	dw WalkSprite_70_06 ; $400c
WalkSprite_70_00:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_70_00_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_70_00_Gfx00, WalkSprite_70_00_Gfx01, WalkSprite_70_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_00_Gfx02 ; $401e
	dw WalkSprite_70_00_Gfx03 ; $4020
	dw WalkSprite_70_00_Gfx04 ; $4022
	dw WalkSprite_70_00_Gfx04 ; $4024
	dw WalkSprite_70_00_Gfx05 ; $4026
	dw WalkSprite_70_00_Gfx06 ; $4028
	dw WalkSprite_70_00_Gfx07 ; $402a
	dw WalkSprite_70_00_Gfx08 ; $402c
	dw WalkSprite_70_00_Gfx08 ; $402e
	dw WalkSprite_70_00_Gfx09 ; $4030
	dw WalkSprite_70_00_Gfx10 ; $4032
	dw WalkSprite_70_00_Gfx11 ; $4034
Padding_70_0:
	; $4036, 10 bytes (fill)
	ds 10, $00
WalkSprite_70_00_Gfx00:
	INCBIN "data/bank_070/d_4040.bin" ; $4040, 256 bytes
WalkSprite_70_00_Gfx01:
	INCBIN "data/bank_070/d_4140.bin" ; $4140, 256 bytes
WalkSprite_70_00_Gfx02:
	INCBIN "data/bank_070/d_4240.bin" ; $4240, 256 bytes
WalkSprite_70_00_Gfx03:
	INCBIN "data/bank_070/d_4340.bin" ; $4340, 256 bytes
WalkSprite_70_00_Gfx04:
	INCBIN "data/bank_070/d_4440.bin" ; $4440, 256 bytes
WalkSprite_70_00_Gfx05:
	INCBIN "data/bank_070/d_4540.bin" ; $4540, 256 bytes
WalkSprite_70_00_Gfx06:
	INCBIN "data/bank_070/d_4640.bin" ; $4640, 256 bytes
WalkSprite_70_00_Gfx07:
	INCBIN "data/bank_070/d_4740.bin" ; $4740, 256 bytes
WalkSprite_70_00_Gfx08:
	INCBIN "data/bank_070/d_4840.bin" ; $4840, 256 bytes
WalkSprite_70_00_Gfx09:
	INCBIN "data/bank_070/d_4940.bin" ; $4940, 256 bytes
WalkSprite_70_00_Gfx10:
	INCBIN "data/bank_070/d_4a40.bin" ; $4a40, 256 bytes
WalkSprite_70_00_Gfx11:
	INCBIN "data/bank_070/d_4b40.bin" ; $4b40, 256 bytes
WalkSprite_70_00_OamPtrs:
	dw WalkSprite_70_00_Oam00 ; $4c40
	dw WalkSprite_70_00_Oam01 ; $4c42
	dw WalkSprite_70_00_Oam02 ; $4c44
	dw WalkSprite_70_00_Oam03 ; $4c46
	dw WalkSprite_70_00_Oam04 ; $4c48
	dw WalkSprite_70_00_Oam05 ; $4c4a
	dw WalkSprite_70_00_Oam05 ; $4c4c
	dw WalkSprite_70_00_Oam06 ; $4c4e
	dw WalkSprite_70_00_Oam07 ; $4c50
	dw WalkSprite_70_00_Oam08 ; $4c52
	dw WalkSprite_70_00_Oam09 ; $4c54
	dw WalkSprite_70_00_Oam10 ; $4c56
WalkSprite_70_00_Oam00:
	INCBIN "data/bank_070/d_4c58.bin" ; $4c58, 3 bytes
WalkSprite_70_00_Oam01:
	INCBIN "data/bank_070/d_4c5b.bin" ; $4c5b, 6 bytes
WalkSprite_70_00_Oam02:
	INCBIN "data/bank_070/d_4c61.bin" ; $4c61, 12 bytes
WalkSprite_70_00_Oam03:
	INCBIN "data/bank_070/d_4c6d.bin" ; $4c6d, 8 bytes
WalkSprite_70_00_Oam04:
	INCBIN "data/bank_070/d_4c75.bin" ; $4c75, 20 bytes
WalkSprite_70_00_Oam05:
	INCBIN "data/bank_070/d_4c89.bin" ; $4c89, 5 bytes
WalkSprite_70_00_Oam06:
	INCBIN "data/bank_070/d_4c8e.bin" ; $4c8e, 12 bytes
WalkSprite_70_00_Oam07:
	INCBIN "data/bank_070/d_4c9a.bin" ; $4c9a, 6 bytes
WalkSprite_70_00_Oam08:
	INCBIN "data/bank_070/d_4ca0.bin" ; $4ca0, 3 bytes
WalkSprite_70_00_Oam09:
	INCBIN "data/bank_070/d_4ca3.bin" ; $4ca3, 3 bytes
WalkSprite_70_00_Oam10:
	INCBIN "data/bank_070/d_4ca6.bin" ; $4ca6, 11 bytes
WalkSprite_70_01:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_70_01_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_70_01_Gfx00, WalkSprite_70_01_Gfx01, WalkSprite_70_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_01_Gfx02 ; $4cc1
	dw WalkSprite_70_01_Gfx03 ; $4cc3
	dw WalkSprite_70_01_Gfx04 ; $4cc5
	dw WalkSprite_70_01_Gfx04 ; $4cc7
	dw WalkSprite_70_01_Gfx05 ; $4cc9
	dw WalkSprite_70_01_Gfx06 ; $4ccb
	dw WalkSprite_70_01_Gfx07 ; $4ccd
	dw WalkSprite_70_01_Gfx08 ; $4ccf
	dw WalkSprite_70_01_Gfx08 ; $4cd1
	dw WalkSprite_70_01_Gfx09 ; $4cd3
	dw WalkSprite_70_01_Gfx10 ; $4cd5
	dw WalkSprite_70_01_Gfx11 ; $4cd7
Padding_70_1:
	; $4cd9, 7 bytes (fill)
	ds 7, $00
WalkSprite_70_01_Gfx00:
	INCBIN "data/bank_070/d_4ce0.bin" ; $4ce0, 256 bytes
WalkSprite_70_01_Gfx01:
	INCBIN "data/bank_070/d_4de0.bin" ; $4de0, 256 bytes
WalkSprite_70_01_Gfx02:
	INCBIN "data/bank_070/d_4ee0.bin" ; $4ee0, 256 bytes
WalkSprite_70_01_Gfx03:
	INCBIN "data/bank_070/d_4fe0.bin" ; $4fe0, 256 bytes
WalkSprite_70_01_Gfx04:
	INCBIN "data/bank_070/d_50e0.bin" ; $50e0, 256 bytes
WalkSprite_70_01_Gfx05:
	INCBIN "data/bank_070/d_51e0.bin" ; $51e0, 256 bytes
WalkSprite_70_01_Gfx06:
	INCBIN "data/bank_070/d_52e0.bin" ; $52e0, 256 bytes
WalkSprite_70_01_Gfx07:
	INCBIN "data/bank_070/d_53e0.bin" ; $53e0, 256 bytes
WalkSprite_70_01_Gfx08:
	INCBIN "data/bank_070/d_54e0.bin" ; $54e0, 256 bytes
WalkSprite_70_01_Gfx09:
	INCBIN "data/bank_070/d_55e0.bin" ; $55e0, 256 bytes
WalkSprite_70_01_Gfx10:
	INCBIN "data/bank_070/d_56e0.bin" ; $56e0, 256 bytes
WalkSprite_70_01_Gfx11:
	INCBIN "data/bank_070/d_57e0.bin" ; $57e0, 256 bytes
WalkSprite_70_01_OamPtrs:
	dw WalkSprite_70_01_Oam00 ; $58e0
	dw WalkSprite_70_01_Oam01 ; $58e2
	dw WalkSprite_70_01_Oam02 ; $58e4
	dw WalkSprite_70_01_Oam03 ; $58e6
	dw WalkSprite_70_01_Oam04 ; $58e8
	dw WalkSprite_70_01_Oam05 ; $58ea
	dw WalkSprite_70_01_Oam05 ; $58ec
	dw WalkSprite_70_01_Oam06 ; $58ee
	dw WalkSprite_70_01_Oam07 ; $58f0
	dw WalkSprite_70_01_Oam08 ; $58f2
	dw WalkSprite_70_01_Oam09 ; $58f4
	dw WalkSprite_70_01_Oam10 ; $58f6
WalkSprite_70_01_Oam00:
	INCBIN "data/bank_070/d_58f8.bin" ; $58f8, 3 bytes
WalkSprite_70_01_Oam01:
	INCBIN "data/bank_070/d_58fb.bin" ; $58fb, 6 bytes
WalkSprite_70_01_Oam02:
	INCBIN "data/bank_070/d_5901.bin" ; $5901, 12 bytes
WalkSprite_70_01_Oam03:
	INCBIN "data/bank_070/d_590d.bin" ; $590d, 8 bytes
WalkSprite_70_01_Oam04:
	INCBIN "data/bank_070/d_5915.bin" ; $5915, 20 bytes
WalkSprite_70_01_Oam05:
	INCBIN "data/bank_070/d_5929.bin" ; $5929, 5 bytes
WalkSprite_70_01_Oam06:
	INCBIN "data/bank_070/d_592e.bin" ; $592e, 12 bytes
WalkSprite_70_01_Oam07:
	INCBIN "data/bank_070/d_593a.bin" ; $593a, 6 bytes
WalkSprite_70_01_Oam08:
	INCBIN "data/bank_070/d_5940.bin" ; $5940, 3 bytes
WalkSprite_70_01_Oam09:
	INCBIN "data/bank_070/d_5943.bin" ; $5943, 3 bytes
WalkSprite_70_01_Oam10:
	INCBIN "data/bank_070/d_5946.bin" ; $5946, 11 bytes
WalkSprite_70_02:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_70_02_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_70_02_Gfx00, WalkSprite_70_02_Gfx01, WalkSprite_70_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_02_Gfx02 ; $5961
	dw WalkSprite_70_02_Gfx02 ; $5963
	dw WalkSprite_70_02_Gfx02 ; $5965
	dw WalkSprite_70_02_Gfx02 ; $5967
	dw WalkSprite_70_02_Gfx03 ; $5969
	dw WalkSprite_70_02_Gfx04 ; $596b
	dw WalkSprite_70_02_Gfx05 ; $596d
	dw WalkSprite_70_02_Gfx06 ; $596f
	dw WalkSprite_70_02_Gfx06 ; $5971
	dw WalkSprite_70_02_Gfx07 ; $5973
Padding_70_2:
	; $5975, 11 bytes (fill)
	ds 11, $00
WalkSprite_70_02_Gfx00:
	INCBIN "data/bank_070/d_5980.bin" ; $5980, 256 bytes
WalkSprite_70_02_Gfx01:
	INCBIN "data/bank_070/d_5a80.bin" ; $5a80, 256 bytes
WalkSprite_70_02_Gfx02:
	INCBIN "data/bank_070/d_5b80.bin" ; $5b80, 256 bytes
WalkSprite_70_02_Gfx03:
	INCBIN "data/bank_070/d_5c80.bin" ; $5c80, 256 bytes
WalkSprite_70_02_Gfx04:
	INCBIN "data/bank_070/d_5d80.bin" ; $5d80, 256 bytes
WalkSprite_70_02_Gfx05:
	INCBIN "data/bank_070/d_5e80.bin" ; $5e80, 256 bytes
WalkSprite_70_02_Gfx06:
	INCBIN "data/bank_070/d_5f80.bin" ; $5f80, 256 bytes
WalkSprite_70_02_Gfx07:
	INCBIN "data/bank_070/d_6080.bin" ; $6080, 256 bytes
WalkSprite_70_02_OamPtrs:
	dw WalkSprite_70_02_Oam00 ; $6180
	dw WalkSprite_70_02_Oam01 ; $6182
	dw WalkSprite_70_02_Oam02 ; $6184
	dw WalkSprite_70_02_Oam03 ; $6186
	dw WalkSprite_70_02_Oam04 ; $6188
	dw WalkSprite_70_02_Oam05 ; $618a
	dw WalkSprite_70_02_Oam05 ; $618c
	dw WalkSprite_70_02_Oam05 ; $618e
	dw WalkSprite_70_02_Oam06 ; $6190
WalkSprite_70_02_Oam00:
	INCBIN "data/bank_070/d_6192.bin" ; $6192, 3 bytes
WalkSprite_70_02_Oam01:
	INCBIN "data/bank_070/d_6195.bin" ; $6195, 6 bytes
WalkSprite_70_02_Oam02:
	INCBIN "data/bank_070/d_619b.bin" ; $619b, 12 bytes
WalkSprite_70_02_Oam03:
	INCBIN "data/bank_070/d_61a7.bin" ; $61a7, 8 bytes
WalkSprite_70_02_Oam04:
	INCBIN "data/bank_070/d_61af.bin" ; $61af, 20 bytes
WalkSprite_70_02_Oam05:
	INCBIN "data/bank_070/d_61c3.bin" ; $61c3, 12 bytes
WalkSprite_70_02_Oam06:
	INCBIN "data/bank_070/d_61cf.bin" ; $61cf, 6 bytes
WalkSprite_70_03:
	db $04, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_70_03_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_70_03_Gfx00, WalkSprite_70_03_Gfx01, WalkSprite_70_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_03_Gfx02 ; $61e5
	dw WalkSprite_70_03_Gfx02 ; $61e7
	dw WalkSprite_70_03_Gfx02 ; $61e9
	dw WalkSprite_70_03_Gfx02 ; $61eb
	dw WalkSprite_70_03_Gfx03 ; $61ed
	dw WalkSprite_70_03_Gfx04 ; $61ef
	dw WalkSprite_70_03_Gfx05 ; $61f1
	dw WalkSprite_70_03_Gfx06 ; $61f3
	dw WalkSprite_70_03_Gfx06 ; $61f5
	dw WalkSprite_70_03_Gfx07 ; $61f7
Padding_70_3:
	; $61f9, 7 bytes (fill)
	ds 7, $00
WalkSprite_70_03_Gfx00:
	INCBIN "data/bank_070/d_6200.bin" ; $6200, 256 bytes
WalkSprite_70_03_Gfx01:
	INCBIN "data/bank_070/d_6300.bin" ; $6300, 256 bytes
WalkSprite_70_03_Gfx02:
	INCBIN "data/bank_070/d_6400.bin" ; $6400, 256 bytes
WalkSprite_70_03_Gfx03:
	INCBIN "data/bank_070/d_6500.bin" ; $6500, 256 bytes
WalkSprite_70_03_Gfx04:
	INCBIN "data/bank_070/d_6600.bin" ; $6600, 256 bytes
WalkSprite_70_03_Gfx05:
	INCBIN "data/bank_070/d_6700.bin" ; $6700, 256 bytes
WalkSprite_70_03_Gfx06:
	INCBIN "data/bank_070/d_6800.bin" ; $6800, 256 bytes
WalkSprite_70_03_Gfx07:
	INCBIN "data/bank_070/d_6900.bin" ; $6900, 256 bytes
WalkSprite_70_03_OamPtrs:
	dw WalkSprite_70_03_Oam00 ; $6a00
	dw WalkSprite_70_03_Oam01 ; $6a02
	dw WalkSprite_70_03_Oam02 ; $6a04
	dw WalkSprite_70_03_Oam03 ; $6a06
	dw WalkSprite_70_03_Oam04 ; $6a08
	dw WalkSprite_70_03_Oam05 ; $6a0a
	dw WalkSprite_70_03_Oam05 ; $6a0c
	dw WalkSprite_70_03_Oam05 ; $6a0e
	dw WalkSprite_70_03_Oam06 ; $6a10
WalkSprite_70_03_Oam00:
	INCBIN "data/bank_070/d_6a12.bin" ; $6a12, 3 bytes
WalkSprite_70_03_Oam01:
	INCBIN "data/bank_070/d_6a15.bin" ; $6a15, 6 bytes
WalkSprite_70_03_Oam02:
	INCBIN "data/bank_070/d_6a1b.bin" ; $6a1b, 12 bytes
WalkSprite_70_03_Oam03:
	INCBIN "data/bank_070/d_6a27.bin" ; $6a27, 8 bytes
WalkSprite_70_03_Oam04:
	INCBIN "data/bank_070/d_6a2f.bin" ; $6a2f, 20 bytes
WalkSprite_70_03_Oam05:
	INCBIN "data/bank_070/d_6a43.bin" ; $6a43, 12 bytes
WalkSprite_70_03_Oam06:
	INCBIN "data/bank_070/d_6a4f.bin" ; $6a4f, 6 bytes
WalkSprite_70_04:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_70_04_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_70_04_Gfx00, WalkSprite_70_04_Gfx01, WalkSprite_70_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_04_Gfx02 ; $6a65
	dw WalkSprite_70_04_Gfx02 ; $6a67
	dw WalkSprite_70_04_Gfx02 ; $6a69
	dw WalkSprite_70_04_Gfx02 ; $6a6b
	dw WalkSprite_70_04_Gfx03 ; $6a6d
	dw WalkSprite_70_04_Gfx04 ; $6a6f
	dw WalkSprite_70_04_Gfx05 ; $6a71
Padding_70_4:
	; $6a73, 13 bytes (fill)
	ds 13, $00
WalkSprite_70_04_Gfx00:
	INCBIN "data/bank_070/d_6a80.bin" ; $6a80, 256 bytes
WalkSprite_70_04_Gfx01:
	INCBIN "data/bank_070/d_6b80.bin" ; $6b80, 256 bytes
WalkSprite_70_04_Gfx02:
	INCBIN "data/bank_070/d_6c80.bin" ; $6c80, 256 bytes
WalkSprite_70_04_Gfx03:
	INCBIN "data/bank_070/d_6d80.bin" ; $6d80, 256 bytes
WalkSprite_70_04_Gfx04:
	INCBIN "data/bank_070/d_6e80.bin" ; $6e80, 256 bytes
WalkSprite_70_04_Gfx05:
	INCBIN "data/bank_070/d_6f80.bin" ; $6f80, 256 bytes
WalkSprite_70_04_OamPtrs:
	dw WalkSprite_70_04_Oam00 ; $7080
	dw WalkSprite_70_04_Oam01 ; $7082
	dw WalkSprite_70_04_Oam02 ; $7084
	dw WalkSprite_70_04_Oam03 ; $7086
	dw WalkSprite_70_04_Oam04 ; $7088
	dw WalkSprite_70_04_Oam05 ; $708a
	dw WalkSprite_70_04_Oam05 ; $708c
	dw WalkSprite_70_04_Oam05 ; $708e
WalkSprite_70_04_Oam00:
	INCBIN "data/bank_070/d_7090.bin" ; $7090, 3 bytes
WalkSprite_70_04_Oam01:
	INCBIN "data/bank_070/d_7093.bin" ; $7093, 6 bytes
WalkSprite_70_04_Oam02:
	INCBIN "data/bank_070/d_7099.bin" ; $7099, 12 bytes
WalkSprite_70_04_Oam03:
	INCBIN "data/bank_070/d_70a5.bin" ; $70a5, 8 bytes
WalkSprite_70_04_Oam04:
	INCBIN "data/bank_070/d_70ad.bin" ; $70ad, 20 bytes
WalkSprite_70_04_Oam05:
	INCBIN "data/bank_070/d_70c1.bin" ; $70c1, 12 bytes
WalkSprite_70_05:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_70_05_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_70_05_Gfx00, WalkSprite_70_05_Gfx01, WalkSprite_70_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_05_Gfx02 ; $70dd
	dw WalkSprite_70_05_Gfx02 ; $70df
	dw WalkSprite_70_05_Gfx02 ; $70e1
	dw WalkSprite_70_05_Gfx02 ; $70e3
	dw WalkSprite_70_05_Gfx03 ; $70e5
	dw WalkSprite_70_05_Gfx04 ; $70e7
	dw WalkSprite_70_05_Gfx05 ; $70e9
Padding_70_5:
	; $70eb, 5 bytes (fill)
	ds 5, $00
WalkSprite_70_05_Gfx00:
	INCBIN "data/bank_070/d_70f0.bin" ; $70f0, 256 bytes
WalkSprite_70_05_Gfx01:
	INCBIN "data/bank_070/d_71f0.bin" ; $71f0, 256 bytes
WalkSprite_70_05_Gfx02:
	INCBIN "data/bank_070/d_72f0.bin" ; $72f0, 256 bytes
WalkSprite_70_05_Gfx03:
	INCBIN "data/bank_070/d_73f0.bin" ; $73f0, 256 bytes
WalkSprite_70_05_Gfx04:
	INCBIN "data/bank_070/d_74f0.bin" ; $74f0, 256 bytes
WalkSprite_70_05_Gfx05:
	INCBIN "data/bank_070/d_75f0.bin" ; $75f0, 256 bytes
WalkSprite_70_05_OamPtrs:
	dw WalkSprite_70_05_Oam00 ; $76f0
	dw WalkSprite_70_05_Oam01 ; $76f2
	dw WalkSprite_70_05_Oam02 ; $76f4
	dw WalkSprite_70_05_Oam03 ; $76f6
	dw WalkSprite_70_05_Oam04 ; $76f8
	dw WalkSprite_70_05_Oam05 ; $76fa
	dw WalkSprite_70_05_Oam05 ; $76fc
	dw WalkSprite_70_05_Oam05 ; $76fe
WalkSprite_70_05_Oam00:
	INCBIN "data/bank_070/d_7700.bin" ; $7700, 3 bytes
WalkSprite_70_05_Oam01:
	INCBIN "data/bank_070/d_7703.bin" ; $7703, 6 bytes
WalkSprite_70_05_Oam02:
	INCBIN "data/bank_070/d_7709.bin" ; $7709, 12 bytes
WalkSprite_70_05_Oam03:
	INCBIN "data/bank_070/d_7715.bin" ; $7715, 8 bytes
WalkSprite_70_05_Oam04:
	INCBIN "data/bank_070/d_771d.bin" ; $771d, 20 bytes
WalkSprite_70_05_Oam05:
	INCBIN "data/bank_070/d_7731.bin" ; $7731, 12 bytes
WalkSprite_70_06:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_70_06_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_70_06_Gfx00, WalkSprite_70_06_Gfx01, WalkSprite_70_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_06_Gfx02 ; $774d
	dw WalkSprite_70_06_Gfx02 ; $774f
	dw WalkSprite_70_06_Gfx02 ; $7751
	dw WalkSprite_70_06_Gfx02 ; $7753
	dw WalkSprite_70_06_Gfx03 ; $7755
	dw WalkSprite_70_06_Gfx04 ; $7757
	dw WalkSprite_70_06_Gfx05 ; $7759
Padding_70_6:
	; $775b, 5 bytes (fill)
	ds 5, $00
WalkSprite_70_06_Gfx00:
	INCBIN "data/bank_070/d_7760.bin" ; $7760, 256 bytes
WalkSprite_70_06_Gfx01:
	INCBIN "data/bank_070/d_7860.bin" ; $7860, 256 bytes
WalkSprite_70_06_Gfx02:
	INCBIN "data/bank_070/d_7960.bin" ; $7960, 256 bytes
WalkSprite_70_06_Gfx03:
	INCBIN "data/bank_070/d_7a60.bin" ; $7a60, 256 bytes
WalkSprite_70_06_Gfx04:
	INCBIN "data/bank_070/d_7b60.bin" ; $7b60, 256 bytes
WalkSprite_70_06_Gfx05:
	INCBIN "data/bank_070/d_7c60.bin" ; $7c60, 256 bytes
WalkSprite_70_06_OamPtrs:
	dw WalkSprite_70_06_Oam00 ; $7d60
	dw WalkSprite_70_06_Oam01 ; $7d62
	dw WalkSprite_70_06_Oam02 ; $7d64
	dw WalkSprite_70_06_Oam03 ; $7d66
	dw WalkSprite_70_06_Oam04 ; $7d68
	dw WalkSprite_70_06_Oam05 ; $7d6a
	dw WalkSprite_70_06_Oam05 ; $7d6c
	dw WalkSprite_70_06_Oam05 ; $7d6e
WalkSprite_70_06_Oam00:
	INCBIN "data/bank_070/d_7d70.bin" ; $7d70, 3 bytes
WalkSprite_70_06_Oam01:
	INCBIN "data/bank_070/d_7d73.bin" ; $7d73, 6 bytes
WalkSprite_70_06_Oam02:
	INCBIN "data/bank_070/d_7d79.bin" ; $7d79, 12 bytes
WalkSprite_70_06_Oam03:
	INCBIN "data/bank_070/d_7d85.bin" ; $7d85, 8 bytes
WalkSprite_70_06_Oam04:
	INCBIN "data/bank_070/d_7d8d.bin" ; $7d8d, 20 bytes
WalkSprite_70_06_Oam05:
	INCBIN "data/bank_070/d_7da1.bin" ; $7da1, 12 bytes
	; $7dad, 595 bytes fill to bank end (linker-padded)

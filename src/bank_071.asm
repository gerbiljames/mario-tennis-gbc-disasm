SECTION "ROM Bank $71", ROMX[$4000], BANK[$71]

DataPtr_WalkSprite_71_00:
	dw WalkSprite_71_00 ; $4000
DataPtr_WalkSprite_71_01:
	dw WalkSprite_71_01 ; $4002
DataPtr_WalkSprite_71_02:
	dw WalkSprite_71_02 ; $4004
DataPtr_WalkSprite_71_03:
	dw WalkSprite_71_03 ; $4006
DataPtr_WalkSprite_71_04:
	dw WalkSprite_71_04 ; $4008
DataPtr_WalkSprite_71_05:
	dw WalkSprite_71_05 ; $400a
DataPtr_WalkSprite_71_06:
	dw WalkSprite_71_06 ; $400c
DataPtr_WalkSprite_71_07:
	dw WalkSprite_71_07 ; $400e
DataPtr_WalkSprite_71_08:
	dw WalkSprite_71_08 ; $4010
DataPtr_WalkSprite_71_09:
	dw WalkSprite_71_09 ; $4012
WalkSprite_71_00:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_4640, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_71_00_Gfx00, WalkSprite_71_00_Gfx01, WalkSprite_71_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_00_Gfx02 ; $4024
	dw WalkSprite_71_00_Gfx02 ; $4026
	dw WalkSprite_71_00_Gfx02 ; $4028
	dw WalkSprite_71_00_Gfx02 ; $402a
	dw WalkSprite_71_00_Gfx03 ; $402c
	dw WalkSprite_71_00_Gfx04 ; $402e
	dw WalkSprite_71_00_Gfx05 ; $4030
Padding_71_4032:
	; $4032, 14 bytes (fill)
	ds 14, $00
WalkSprite_71_00_Gfx00:
	INCBIN "data/bank_071/d_4040.bin" ; $4040, 256 bytes
WalkSprite_71_00_Gfx01:
	INCBIN "data/bank_071/d_4140.bin" ; $4140, 256 bytes
WalkSprite_71_00_Gfx02:
	INCBIN "data/bank_071/d_4240.bin" ; $4240, 256 bytes
WalkSprite_71_00_Gfx03:
	INCBIN "data/bank_071/d_4340.bin" ; $4340, 256 bytes
WalkSprite_71_00_Gfx04:
	INCBIN "data/bank_071/d_4440.bin" ; $4440, 256 bytes
WalkSprite_71_00_Gfx05:
	INCBIN "data/bank_071/d_4540.bin" ; $4540, 256 bytes
OamPtrs_71_4640:
	dw WalkSprite_71_00_Oam00 ; $4640
	dw WalkSprite_71_00_Oam01 ; $4642
	dw WalkSprite_71_00_Oam02 ; $4644
	dw WalkSprite_71_00_Oam03 ; $4646
	dw WalkSprite_71_00_Oam04 ; $4648
	dw WalkSprite_71_00_Oam05 ; $464a
	dw WalkSprite_71_00_Oam05 ; $464c
	dw WalkSprite_71_00_Oam05 ; $464e
WalkSprite_71_00_Oam00:
	INCBIN "data/bank_071/d_4650.bin" ; $4650, 3 bytes
WalkSprite_71_00_Oam01:
	INCBIN "data/bank_071/d_4653.bin" ; $4653, 6 bytes
WalkSprite_71_00_Oam02:
	INCBIN "data/bank_071/d_4659.bin" ; $4659, 12 bytes
WalkSprite_71_00_Oam03:
	INCBIN "data/bank_071/d_4665.bin" ; $4665, 8 bytes
WalkSprite_71_00_Oam04:
	INCBIN "data/bank_071/d_466d.bin" ; $466d, 20 bytes
WalkSprite_71_00_Oam05:
	INCBIN "data/bank_071/d_4681.bin" ; $4681, 12 bytes
WalkSprite_71_01:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_4cb0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_71_01_Gfx00, WalkSprite_71_01_Gfx01, WalkSprite_71_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_01_Gfx02 ; $469d
	dw WalkSprite_71_01_Gfx02 ; $469f
	dw WalkSprite_71_01_Gfx02 ; $46a1
	dw WalkSprite_71_01_Gfx02 ; $46a3
	dw WalkSprite_71_01_Gfx03 ; $46a5
	dw WalkSprite_71_01_Gfx04 ; $46a7
	dw WalkSprite_71_01_Gfx05 ; $46a9
Padding_71_46ab:
	; $46ab, 5 bytes (fill)
	ds 5, $00
WalkSprite_71_01_Gfx00:
	INCBIN "data/bank_071/d_46b0.bin" ; $46b0, 256 bytes
WalkSprite_71_01_Gfx01:
	INCBIN "data/bank_071/d_47b0.bin" ; $47b0, 256 bytes
WalkSprite_71_01_Gfx02:
	INCBIN "data/bank_071/d_48b0.bin" ; $48b0, 256 bytes
WalkSprite_71_01_Gfx03:
	INCBIN "data/bank_071/d_49b0.bin" ; $49b0, 256 bytes
WalkSprite_71_01_Gfx04:
	INCBIN "data/bank_071/d_4ab0.bin" ; $4ab0, 256 bytes
WalkSprite_71_01_Gfx05:
	INCBIN "data/bank_071/d_4bb0.bin" ; $4bb0, 256 bytes
OamPtrs_71_4cb0:
	dw WalkSprite_71_01_Oam00 ; $4cb0
	dw WalkSprite_71_01_Oam01 ; $4cb2
	dw WalkSprite_71_01_Oam02 ; $4cb4
	dw WalkSprite_71_01_Oam03 ; $4cb6
	dw WalkSprite_71_01_Oam04 ; $4cb8
	dw WalkSprite_71_01_Oam05 ; $4cba
	dw WalkSprite_71_01_Oam05 ; $4cbc
	dw WalkSprite_71_01_Oam05 ; $4cbe
WalkSprite_71_01_Oam00:
	INCBIN "data/bank_071/d_4cc0.bin" ; $4cc0, 3 bytes
WalkSprite_71_01_Oam01:
	INCBIN "data/bank_071/d_4cc3.bin" ; $4cc3, 6 bytes
WalkSprite_71_01_Oam02:
	INCBIN "data/bank_071/d_4cc9.bin" ; $4cc9, 12 bytes
WalkSprite_71_01_Oam03:
	INCBIN "data/bank_071/d_4cd5.bin" ; $4cd5, 8 bytes
WalkSprite_71_01_Oam04:
	INCBIN "data/bank_071/d_4cdd.bin" ; $4cdd, 20 bytes
WalkSprite_71_01_Oam05:
	INCBIN "data/bank_071/d_4cf1.bin" ; $4cf1, 12 bytes
WalkSprite_71_02:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_5320, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_71_02_Gfx00, WalkSprite_71_02_Gfx01, WalkSprite_71_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_02_Gfx02 ; $4d0d
	dw WalkSprite_71_02_Gfx02 ; $4d0f
	dw WalkSprite_71_02_Gfx02 ; $4d11
	dw WalkSprite_71_02_Gfx02 ; $4d13
	dw WalkSprite_71_02_Gfx03 ; $4d15
	dw WalkSprite_71_02_Gfx04 ; $4d17
	dw WalkSprite_71_02_Gfx05 ; $4d19
Padding_71_4d1b:
	; $4d1b, 5 bytes (fill)
	ds 5, $00
WalkSprite_71_02_Gfx00:
	INCBIN "data/bank_071/d_4d20.bin" ; $4d20, 256 bytes
WalkSprite_71_02_Gfx01:
	INCBIN "data/bank_071/d_4e20.bin" ; $4e20, 256 bytes
WalkSprite_71_02_Gfx02:
	INCBIN "data/bank_071/d_4f20.bin" ; $4f20, 256 bytes
WalkSprite_71_02_Gfx03:
	INCBIN "data/bank_071/d_5020.bin" ; $5020, 256 bytes
WalkSprite_71_02_Gfx04:
	INCBIN "data/bank_071/d_5120.bin" ; $5120, 256 bytes
WalkSprite_71_02_Gfx05:
	INCBIN "data/bank_071/d_5220.bin" ; $5220, 256 bytes
OamPtrs_71_5320:
	dw WalkSprite_71_02_Oam00 ; $5320
	dw WalkSprite_71_02_Oam01 ; $5322
	dw WalkSprite_71_02_Oam02 ; $5324
	dw WalkSprite_71_02_Oam03 ; $5326
	dw WalkSprite_71_02_Oam04 ; $5328
	dw WalkSprite_71_02_Oam05 ; $532a
	dw WalkSprite_71_02_Oam05 ; $532c
	dw WalkSprite_71_02_Oam05 ; $532e
WalkSprite_71_02_Oam00:
	INCBIN "data/bank_071/d_5330.bin" ; $5330, 3 bytes
WalkSprite_71_02_Oam01:
	INCBIN "data/bank_071/d_5333.bin" ; $5333, 6 bytes
WalkSprite_71_02_Oam02:
	INCBIN "data/bank_071/d_5339.bin" ; $5339, 12 bytes
WalkSprite_71_02_Oam03:
	INCBIN "data/bank_071/d_5345.bin" ; $5345, 8 bytes
WalkSprite_71_02_Oam04:
	INCBIN "data/bank_071/d_534d.bin" ; $534d, 20 bytes
WalkSprite_71_02_Oam05:
	INCBIN "data/bank_071/d_5361.bin" ; $5361, 12 bytes
WalkSprite_71_03:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_5990, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_71_03_Gfx00, WalkSprite_71_03_Gfx01, WalkSprite_71_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_03_Gfx02 ; $537d
	dw WalkSprite_71_03_Gfx02 ; $537f
	dw WalkSprite_71_03_Gfx02 ; $5381
	dw WalkSprite_71_03_Gfx02 ; $5383
	dw WalkSprite_71_03_Gfx03 ; $5385
	dw WalkSprite_71_03_Gfx04 ; $5387
	dw WalkSprite_71_03_Gfx05 ; $5389
Padding_71_538b:
	; $538b, 5 bytes (fill)
	ds 5, $00
WalkSprite_71_03_Gfx00:
	INCBIN "data/bank_071/d_5390.bin" ; $5390, 256 bytes
WalkSprite_71_03_Gfx01:
	INCBIN "data/bank_071/d_5490.bin" ; $5490, 256 bytes
WalkSprite_71_03_Gfx02:
	INCBIN "data/bank_071/d_5590.bin" ; $5590, 256 bytes
WalkSprite_71_03_Gfx03:
	INCBIN "data/bank_071/d_5690.bin" ; $5690, 256 bytes
WalkSprite_71_03_Gfx04:
	INCBIN "data/bank_071/d_5790.bin" ; $5790, 256 bytes
WalkSprite_71_03_Gfx05:
	INCBIN "data/bank_071/d_5890.bin" ; $5890, 256 bytes
OamPtrs_71_5990:
	dw WalkSprite_71_03_Oam00 ; $5990
	dw WalkSprite_71_03_Oam01 ; $5992
	dw WalkSprite_71_03_Oam02 ; $5994
	dw WalkSprite_71_03_Oam03 ; $5996
	dw WalkSprite_71_03_Oam04 ; $5998
	dw WalkSprite_71_03_Oam05 ; $599a
	dw WalkSprite_71_03_Oam05 ; $599c
	dw WalkSprite_71_03_Oam05 ; $599e
WalkSprite_71_03_Oam00:
	INCBIN "data/bank_071/d_59a0.bin" ; $59a0, 3 bytes
WalkSprite_71_03_Oam01:
	INCBIN "data/bank_071/d_59a3.bin" ; $59a3, 6 bytes
WalkSprite_71_03_Oam02:
	INCBIN "data/bank_071/d_59a9.bin" ; $59a9, 12 bytes
WalkSprite_71_03_Oam03:
	INCBIN "data/bank_071/d_59b5.bin" ; $59b5, 8 bytes
WalkSprite_71_03_Oam04:
	INCBIN "data/bank_071/d_59bd.bin" ; $59bd, 20 bytes
WalkSprite_71_03_Oam05:
	INCBIN "data/bank_071/d_59d1.bin" ; $59d1, 12 bytes
WalkSprite_71_04:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_6000, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_71_04_Gfx00, WalkSprite_71_04_Gfx01, WalkSprite_71_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_04_Gfx02 ; $59ed
	dw WalkSprite_71_04_Gfx02 ; $59ef
	dw WalkSprite_71_04_Gfx02 ; $59f1
	dw WalkSprite_71_04_Gfx02 ; $59f3
	dw WalkSprite_71_04_Gfx03 ; $59f5
	dw WalkSprite_71_04_Gfx04 ; $59f7
	dw WalkSprite_71_04_Gfx05 ; $59f9
Padding_71_59fb:
	; $59fb, 5 bytes (fill)
	ds 5, $00
WalkSprite_71_04_Gfx00:
	INCBIN "data/bank_071/d_5a00.bin" ; $5a00, 256 bytes
WalkSprite_71_04_Gfx01:
	INCBIN "data/bank_071/d_5b00.bin" ; $5b00, 256 bytes
WalkSprite_71_04_Gfx02:
	INCBIN "data/bank_071/d_5c00.bin" ; $5c00, 256 bytes
WalkSprite_71_04_Gfx03:
	INCBIN "data/bank_071/d_5d00.bin" ; $5d00, 256 bytes
WalkSprite_71_04_Gfx04:
	INCBIN "data/bank_071/d_5e00.bin" ; $5e00, 256 bytes
WalkSprite_71_04_Gfx05:
	INCBIN "data/bank_071/d_5f00.bin" ; $5f00, 256 bytes
OamPtrs_71_6000:
	dw WalkSprite_71_04_Oam00 ; $6000
	dw WalkSprite_71_04_Oam01 ; $6002
	dw WalkSprite_71_04_Oam02 ; $6004
	dw WalkSprite_71_04_Oam03 ; $6006
	dw WalkSprite_71_04_Oam04 ; $6008
	dw WalkSprite_71_04_Oam05 ; $600a
	dw WalkSprite_71_04_Oam05 ; $600c
	dw WalkSprite_71_04_Oam05 ; $600e
WalkSprite_71_04_Oam00:
	INCBIN "data/bank_071/d_6010.bin" ; $6010, 3 bytes
WalkSprite_71_04_Oam01:
	INCBIN "data/bank_071/d_6013.bin" ; $6013, 6 bytes
WalkSprite_71_04_Oam02:
	INCBIN "data/bank_071/d_6019.bin" ; $6019, 12 bytes
WalkSprite_71_04_Oam03:
	INCBIN "data/bank_071/d_6025.bin" ; $6025, 8 bytes
WalkSprite_71_04_Oam04:
	INCBIN "data/bank_071/d_602d.bin" ; $602d, 20 bytes
WalkSprite_71_04_Oam05:
	INCBIN "data/bank_071/d_6041.bin" ; $6041, 12 bytes
WalkSprite_71_05:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_6970, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_71_05_Gfx00, WalkSprite_71_05_Gfx01, WalkSprite_71_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_05_Gfx02 ; $605d
	dw WalkSprite_71_05_Gfx03 ; $605f
	dw WalkSprite_71_05_Gfx04 ; $6061
	dw WalkSprite_71_05_Gfx05 ; $6063
	dw WalkSprite_71_05_Gfx06 ; $6065
	dw WalkSprite_71_05_Gfx07 ; $6067
	dw WalkSprite_71_05_Gfx08 ; $6069
Padding_71_606b:
	; $606b, 5 bytes (fill)
	ds 5, $00
WalkSprite_71_05_Gfx00:
	INCBIN "data/bank_071/d_6070.bin" ; $6070, 256 bytes
WalkSprite_71_05_Gfx01:
	INCBIN "data/bank_071/d_6170.bin" ; $6170, 256 bytes
WalkSprite_71_05_Gfx02:
	INCBIN "data/bank_071/d_6270.bin" ; $6270, 256 bytes
WalkSprite_71_05_Gfx03:
	INCBIN "data/bank_071/d_6370.bin" ; $6370, 256 bytes
WalkSprite_71_05_Gfx04:
	INCBIN "data/bank_071/d_6470.bin" ; $6470, 256 bytes
WalkSprite_71_05_Gfx05:
	INCBIN "data/bank_071/d_6570.bin" ; $6570, 256 bytes
WalkSprite_71_05_Gfx06:
	INCBIN "data/bank_071/d_6670.bin" ; $6670, 256 bytes
WalkSprite_71_05_Gfx07:
	INCBIN "data/bank_071/d_6770.bin" ; $6770, 256 bytes
WalkSprite_71_05_Gfx08:
	INCBIN "data/bank_071/d_6870.bin" ; $6870, 256 bytes
OamPtrs_71_6970:
	dw WalkSprite_71_05_Oam00 ; $6970
	dw WalkSprite_71_05_Oam01 ; $6972
	dw WalkSprite_71_05_Oam02 ; $6974
	dw WalkSprite_71_05_Oam03 ; $6976
	dw WalkSprite_71_05_Oam04 ; $6978
	dw WalkSprite_71_05_Oam05 ; $697a
	dw WalkSprite_71_05_Oam05 ; $697c
	dw WalkSprite_71_05_Oam06 ; $697e
	dw WalkSprite_71_05_Oam07 ; $6980
WalkSprite_71_05_Oam00:
	INCBIN "data/bank_071/d_6982.bin" ; $6982, 3 bytes
WalkSprite_71_05_Oam01:
	INCBIN "data/bank_071/d_6985.bin" ; $6985, 6 bytes
WalkSprite_71_05_Oam02:
	INCBIN "data/bank_071/d_698b.bin" ; $698b, 12 bytes
WalkSprite_71_05_Oam03:
	INCBIN "data/bank_071/d_6997.bin" ; $6997, 8 bytes
WalkSprite_71_05_Oam04:
	INCBIN "data/bank_071/d_699f.bin" ; $699f, 20 bytes
WalkSprite_71_05_Oam05:
	INCBIN "data/bank_071/d_69b3.bin" ; $69b3, 5 bytes
WalkSprite_71_05_Oam06:
	INCBIN "data/bank_071/d_69b8.bin" ; $69b8, 12 bytes
WalkSprite_71_05_Oam07:
	INCBIN "data/bank_071/d_69c4.bin" ; $69c4, 8 bytes
WalkSprite_71_06:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_72f0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_71_06_Gfx00, WalkSprite_71_06_Gfx01, WalkSprite_71_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_06_Gfx02 ; $69dc
	dw WalkSprite_71_06_Gfx03 ; $69de
	dw WalkSprite_71_06_Gfx04 ; $69e0
	dw WalkSprite_71_06_Gfx05 ; $69e2
	dw WalkSprite_71_06_Gfx06 ; $69e4
	dw WalkSprite_71_06_Gfx07 ; $69e6
	dw WalkSprite_71_06_Gfx08 ; $69e8
Padding_71_69ea:
	; $69ea, 6 bytes (fill)
	ds 6, $00
WalkSprite_71_06_Gfx00:
	INCBIN "data/bank_071/d_69f0.bin" ; $69f0, 256 bytes
WalkSprite_71_06_Gfx01:
	INCBIN "data/bank_071/d_6af0.bin" ; $6af0, 256 bytes
WalkSprite_71_06_Gfx02:
	INCBIN "data/bank_071/d_6bf0.bin" ; $6bf0, 256 bytes
WalkSprite_71_06_Gfx03:
	INCBIN "data/bank_071/d_6cf0.bin" ; $6cf0, 256 bytes
WalkSprite_71_06_Gfx04:
	INCBIN "data/bank_071/d_6df0.bin" ; $6df0, 256 bytes
WalkSprite_71_06_Gfx05:
	INCBIN "data/bank_071/d_6ef0.bin" ; $6ef0, 256 bytes
WalkSprite_71_06_Gfx06:
	INCBIN "data/bank_071/d_6ff0.bin" ; $6ff0, 256 bytes
WalkSprite_71_06_Gfx07:
	INCBIN "data/bank_071/d_70f0.bin" ; $70f0, 256 bytes
WalkSprite_71_06_Gfx08:
	INCBIN "data/bank_071/d_71f0.bin" ; $71f0, 256 bytes
OamPtrs_71_72f0:
	dw WalkSprite_71_06_Oam00 ; $72f0
	dw WalkSprite_71_06_Oam01 ; $72f2
	dw WalkSprite_71_06_Oam02 ; $72f4
	dw WalkSprite_71_06_Oam03 ; $72f6
	dw WalkSprite_71_06_Oam04 ; $72f8
	dw WalkSprite_71_06_Oam05 ; $72fa
	dw WalkSprite_71_06_Oam05 ; $72fc
	dw WalkSprite_71_06_Oam06 ; $72fe
	dw WalkSprite_71_06_Oam07 ; $7300
WalkSprite_71_06_Oam00:
	INCBIN "data/bank_071/d_7302.bin" ; $7302, 3 bytes
WalkSprite_71_06_Oam01:
	INCBIN "data/bank_071/d_7305.bin" ; $7305, 6 bytes
WalkSprite_71_06_Oam02:
	INCBIN "data/bank_071/d_730b.bin" ; $730b, 12 bytes
WalkSprite_71_06_Oam03:
	INCBIN "data/bank_071/d_7317.bin" ; $7317, 8 bytes
WalkSprite_71_06_Oam04:
	INCBIN "data/bank_071/d_731f.bin" ; $731f, 20 bytes
WalkSprite_71_06_Oam05:
	INCBIN "data/bank_071/d_7333.bin" ; $7333, 5 bytes
WalkSprite_71_06_Oam06:
	INCBIN "data/bank_071/d_7338.bin" ; $7338, 12 bytes
WalkSprite_71_06_Oam07:
	INCBIN "data/bank_071/d_7344.bin" ; $7344, 8 bytes
WalkSprite_71_07:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_7c70, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_71_07_Gfx00, WalkSprite_71_07_Gfx01, WalkSprite_71_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_07_Gfx02 ; $735c
	dw WalkSprite_71_07_Gfx03 ; $735e
	dw WalkSprite_71_07_Gfx04 ; $7360
	dw WalkSprite_71_07_Gfx05 ; $7362
	dw WalkSprite_71_07_Gfx06 ; $7364
	dw WalkSprite_71_07_Gfx07 ; $7366
	dw WalkSprite_71_07_Gfx08 ; $7368
Padding_71_736a:
	; $736a, 6 bytes (fill)
	ds 6, $00
WalkSprite_71_07_Gfx00:
	INCBIN "data/bank_071/d_7370.bin" ; $7370, 256 bytes
WalkSprite_71_07_Gfx01:
	INCBIN "data/bank_071/d_7470.bin" ; $7470, 256 bytes
WalkSprite_71_07_Gfx02:
	INCBIN "data/bank_071/d_7570.bin" ; $7570, 256 bytes
WalkSprite_71_07_Gfx03:
	INCBIN "data/bank_071/d_7670.bin" ; $7670, 256 bytes
WalkSprite_71_07_Gfx04:
	INCBIN "data/bank_071/d_7770.bin" ; $7770, 256 bytes
WalkSprite_71_07_Gfx05:
	INCBIN "data/bank_071/d_7870.bin" ; $7870, 256 bytes
WalkSprite_71_07_Gfx06:
	INCBIN "data/bank_071/d_7970.bin" ; $7970, 256 bytes
WalkSprite_71_07_Gfx07:
	INCBIN "data/bank_071/d_7a70.bin" ; $7a70, 256 bytes
WalkSprite_71_07_Gfx08:
	INCBIN "data/bank_071/d_7b70.bin" ; $7b70, 256 bytes
OamPtrs_71_7c70:
	dw WalkSprite_71_07_Oam00 ; $7c70
	dw WalkSprite_71_07_Oam01 ; $7c72
	dw WalkSprite_71_07_Oam02 ; $7c74
	dw WalkSprite_71_07_Oam03 ; $7c76
	dw WalkSprite_71_07_Oam04 ; $7c78
	dw WalkSprite_71_07_Oam05 ; $7c7a
	dw WalkSprite_71_07_Oam05 ; $7c7c
	dw WalkSprite_71_07_Oam06 ; $7c7e
	dw WalkSprite_71_07_Oam07 ; $7c80
WalkSprite_71_07_Oam00:
	INCBIN "data/bank_071/d_7c82.bin" ; $7c82, 3 bytes
WalkSprite_71_07_Oam01:
	INCBIN "data/bank_071/d_7c85.bin" ; $7c85, 6 bytes
WalkSprite_71_07_Oam02:
	INCBIN "data/bank_071/d_7c8b.bin" ; $7c8b, 12 bytes
WalkSprite_71_07_Oam03:
	INCBIN "data/bank_071/d_7c97.bin" ; $7c97, 8 bytes
WalkSprite_71_07_Oam04:
	INCBIN "data/bank_071/d_7c9f.bin" ; $7c9f, 20 bytes
WalkSprite_71_07_Oam05:
	INCBIN "data/bank_071/d_7cb3.bin" ; $7cb3, 5 bytes
WalkSprite_71_07_Oam06:
	INCBIN "data/bank_071/d_7cb8.bin" ; $7cb8, 12 bytes
WalkSprite_71_07_Oam07:
	INCBIN "data/bank_071/d_7cc4.bin" ; $7cc4, 8 bytes
WalkSprite_71_08:
	db $05, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_7d30, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_71_08_Gfx00, OamPtrs_71_7d30, OamPtrs_71_7d30 ; frame pointers (continue in body)
	dw OamPtrs_71_7d30 ; $7cdc
	dw OamPtrs_71_7d30 ; $7cde
	dw OamPtrs_71_7d30 ; $7ce0
	dw OamPtrs_71_7d30 ; $7ce2
	dw OamPtrs_71_7d30 ; $7ce4
	dw OamPtrs_71_7d30 ; $7ce6
	dw OamPtrs_71_7d30 ; $7ce8
Padding_71_7cea:
	; $7cea, 6 bytes (fill)
	ds 6, $00
WalkSprite_71_08_Gfx00:
	INCBIN "data/bank_071/d_7cf0.bin" ; $7cf0, 64 bytes
OamPtrs_71_7d30:
	dw WalkSprite_71_08_Oam00 ; $7d30
	dw WalkSprite_71_08_Oam00 ; $7d32
	dw WalkSprite_71_08_Oam00 ; $7d34
	dw WalkSprite_71_08_Oam00 ; $7d36
	dw WalkSprite_71_08_Oam00 ; $7d38
	dw WalkSprite_71_08_Oam00 ; $7d3a
	dw WalkSprite_71_08_Oam00 ; $7d3c
	dw WalkSprite_71_08_Oam00 ; $7d3e
WalkSprite_71_08_Oam00:
	INCBIN "data/bank_071/d_7d40.bin" ; $7d40, 3 bytes
WalkSprite_71_09:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_7de0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_71_09_Gfx00, WalkSprite_71_09_Gfx01, $0000 ; frame pointers (continue in body)
Padding_71_7d53:
	; $7d53, 13 bytes (fill)
	ds 13, $00
WalkSprite_71_09_Gfx00:
	INCBIN "data/bank_071/d_7d60.bin" ; $7d60, 64 bytes
WalkSprite_71_09_Gfx01:
	INCBIN "data/bank_071/d_7da0.bin" ; $7da0, 64 bytes
OamPtrs_71_7de0:
	dw WalkSprite_71_09_Oam00 ; $7de0
	dw WalkSprite_71_09_Oam01 ; $7de2
	dw WalkSprite_71_09_Oam02 ; $7de4
	dw WalkSprite_71_09_Oam02 ; $7de6
	dw WalkSprite_71_09_Oam02 ; $7de8
	dw WalkSprite_71_09_Oam02 ; $7dea
	dw WalkSprite_71_09_Oam02 ; $7dec
	dw WalkSprite_71_09_Oam02 ; $7dee
WalkSprite_71_09_Oam00:
	INCBIN "data/bank_071/d_7df0.bin" ; $7df0, 3 bytes
WalkSprite_71_09_Oam01:
	INCBIN "data/bank_071/d_7df3.bin" ; $7df3, 6 bytes
WalkSprite_71_09_Oam02:
	ds 519, $ff ; $7df9, fill

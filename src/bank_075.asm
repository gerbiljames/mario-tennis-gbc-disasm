SECTION "ROM Bank $75", ROMX[$4000], BANK[$75]

DataPtr_WalkSprite_75_00:
	dw WalkSprite_75_00 ; $4000
DataPtr_WalkSprite_75_01:
	dw WalkSprite_75_01 ; $4002
DataPtr_WalkSprite_75_02:
	dw WalkSprite_75_02 ; $4004
DataPtr_WalkSprite_75_03:
	dw WalkSprite_75_03 ; $4006
DataPtr_WalkSprite_75_04:
	dw WalkSprite_75_04 ; $4008
DataPtr_WalkSprite_75_05:
	dw WalkSprite_75_05 ; $400a
DataPtr_WalkSprite_75_06:
	dw WalkSprite_75_06 ; $400c
DataPtr_WalkSprite_75_07:
	dw WalkSprite_75_07 ; $400e
DataPtr_WalkSprite_75_08:
	dw WalkSprite_75_08 ; $4010
WalkSprite_75_00:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_75_4630, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_75_00_Gfx00, WalkSprite_75_00_Gfx01, WalkSprite_75_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_00_Gfx02 ; $4022
	dw WalkSprite_75_00_Gfx02 ; $4024
	dw WalkSprite_75_00_Gfx02 ; $4026
	dw WalkSprite_75_00_Gfx02 ; $4028
	dw WalkSprite_75_00_Gfx03 ; $402a
	dw WalkSprite_75_00_Gfx04 ; $402c
	dw WalkSprite_75_00_Gfx05 ; $402e
WalkSprite_75_00_Gfx00:
	INCBIN "data/bank_075/d_4030.bin" ; $4030, 256 bytes
WalkSprite_75_00_Gfx01:
	INCBIN "data/bank_075/d_4130.bin" ; $4130, 256 bytes
WalkSprite_75_00_Gfx02:
	INCBIN "data/bank_075/d_4230.bin" ; $4230, 256 bytes
WalkSprite_75_00_Gfx03:
	INCBIN "data/bank_075/d_4330.bin" ; $4330, 256 bytes
WalkSprite_75_00_Gfx04:
	INCBIN "data/bank_075/d_4430.bin" ; $4430, 256 bytes
WalkSprite_75_00_Gfx05:
	INCBIN "data/bank_075/d_4530.bin" ; $4530, 256 bytes
OamPtrs_75_4630:
	dw WalkSprite_75_00_Oam00 ; $4630
	dw WalkSprite_75_00_Oam01 ; $4632
	dw WalkSprite_75_00_Oam02 ; $4634
	dw WalkSprite_75_00_Oam03 ; $4636
	dw WalkSprite_75_00_Oam04 ; $4638
	dw WalkSprite_75_00_Oam05 ; $463a
	dw WalkSprite_75_00_Oam05 ; $463c
	dw WalkSprite_75_00_Oam05 ; $463e
WalkSprite_75_00_Oam00:
	INCBIN "data/bank_075/d_4640.bin" ; $4640, 3 bytes
WalkSprite_75_00_Oam01:
	INCBIN "data/bank_075/d_4643.bin" ; $4643, 6 bytes
WalkSprite_75_00_Oam02:
	INCBIN "data/bank_075/d_4649.bin" ; $4649, 12 bytes
WalkSprite_75_00_Oam03:
	INCBIN "data/bank_075/d_4655.bin" ; $4655, 8 bytes
WalkSprite_75_00_Oam04:
	INCBIN "data/bank_075/d_465d.bin" ; $465d, 20 bytes
WalkSprite_75_00_Oam05:
	INCBIN "data/bank_075/d_4671.bin" ; $4671, 12 bytes
WalkSprite_75_01:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_75_4ca0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_75_01_Gfx00, WalkSprite_75_01_Gfx01, WalkSprite_75_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_01_Gfx02 ; $468d
	dw WalkSprite_75_01_Gfx02 ; $468f
	dw WalkSprite_75_01_Gfx02 ; $4691
	dw WalkSprite_75_01_Gfx02 ; $4693
	dw WalkSprite_75_01_Gfx03 ; $4695
	dw WalkSprite_75_01_Gfx04 ; $4697
	dw WalkSprite_75_01_Gfx05 ; $4699
Padding_75_469b:
	; $469b, 5 bytes (fill)
	ds 5, $00
WalkSprite_75_01_Gfx00:
	INCBIN "data/bank_075/d_46a0.bin" ; $46a0, 256 bytes
WalkSprite_75_01_Gfx01:
	INCBIN "data/bank_075/d_47a0.bin" ; $47a0, 256 bytes
WalkSprite_75_01_Gfx02:
	INCBIN "data/bank_075/d_48a0.bin" ; $48a0, 256 bytes
WalkSprite_75_01_Gfx03:
	INCBIN "data/bank_075/d_49a0.bin" ; $49a0, 256 bytes
WalkSprite_75_01_Gfx04:
	INCBIN "data/bank_075/d_4aa0.bin" ; $4aa0, 256 bytes
WalkSprite_75_01_Gfx05:
	INCBIN "data/bank_075/d_4ba0.bin" ; $4ba0, 256 bytes
OamPtrs_75_4ca0:
	dw WalkSprite_75_01_Oam00 ; $4ca0
	dw WalkSprite_75_01_Oam01 ; $4ca2
	dw WalkSprite_75_01_Oam02 ; $4ca4
	dw WalkSprite_75_01_Oam03 ; $4ca6
	dw WalkSprite_75_01_Oam04 ; $4ca8
	dw WalkSprite_75_01_Oam05 ; $4caa
	dw WalkSprite_75_01_Oam05 ; $4cac
	dw WalkSprite_75_01_Oam05 ; $4cae
WalkSprite_75_01_Oam00:
	INCBIN "data/bank_075/d_4cb0.bin" ; $4cb0, 3 bytes
WalkSprite_75_01_Oam01:
	INCBIN "data/bank_075/d_4cb3.bin" ; $4cb3, 6 bytes
WalkSprite_75_01_Oam02:
	INCBIN "data/bank_075/d_4cb9.bin" ; $4cb9, 12 bytes
WalkSprite_75_01_Oam03:
	INCBIN "data/bank_075/d_4cc5.bin" ; $4cc5, 8 bytes
WalkSprite_75_01_Oam04:
	INCBIN "data/bank_075/d_4ccd.bin" ; $4ccd, 20 bytes
WalkSprite_75_01_Oam05:
	INCBIN "data/bank_075/d_4ce1.bin" ; $4ce1, 12 bytes
WalkSprite_75_02:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_75_5310, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_75_02_Gfx00, WalkSprite_75_02_Gfx01, WalkSprite_75_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_02_Gfx02 ; $4cfd
	dw WalkSprite_75_02_Gfx02 ; $4cff
	dw WalkSprite_75_02_Gfx02 ; $4d01
	dw WalkSprite_75_02_Gfx02 ; $4d03
	dw WalkSprite_75_02_Gfx03 ; $4d05
	dw WalkSprite_75_02_Gfx04 ; $4d07
	dw WalkSprite_75_02_Gfx05 ; $4d09
Padding_75_4d0b:
	; $4d0b, 5 bytes (fill)
	ds 5, $00
WalkSprite_75_02_Gfx00:
	INCBIN "data/bank_075/d_4d10.bin" ; $4d10, 256 bytes
WalkSprite_75_02_Gfx01:
	INCBIN "data/bank_075/d_4e10.bin" ; $4e10, 256 bytes
WalkSprite_75_02_Gfx02:
	INCBIN "data/bank_075/d_4f10.bin" ; $4f10, 256 bytes
WalkSprite_75_02_Gfx03:
	INCBIN "data/bank_075/d_5010.bin" ; $5010, 256 bytes
WalkSprite_75_02_Gfx04:
	INCBIN "data/bank_075/d_5110.bin" ; $5110, 256 bytes
WalkSprite_75_02_Gfx05:
	INCBIN "data/bank_075/d_5210.bin" ; $5210, 256 bytes
OamPtrs_75_5310:
	dw WalkSprite_75_02_Oam00 ; $5310
	dw WalkSprite_75_02_Oam01 ; $5312
	dw WalkSprite_75_02_Oam02 ; $5314
	dw WalkSprite_75_02_Oam03 ; $5316
	dw WalkSprite_75_02_Oam04 ; $5318
	dw WalkSprite_75_02_Oam05 ; $531a
	dw WalkSprite_75_02_Oam05 ; $531c
	dw WalkSprite_75_02_Oam05 ; $531e
WalkSprite_75_02_Oam00:
	INCBIN "data/bank_075/d_5320.bin" ; $5320, 3 bytes
WalkSprite_75_02_Oam01:
	INCBIN "data/bank_075/d_5323.bin" ; $5323, 6 bytes
WalkSprite_75_02_Oam02:
	INCBIN "data/bank_075/d_5329.bin" ; $5329, 12 bytes
WalkSprite_75_02_Oam03:
	INCBIN "data/bank_075/d_5335.bin" ; $5335, 8 bytes
WalkSprite_75_02_Oam04:
	INCBIN "data/bank_075/d_533d.bin" ; $533d, 20 bytes
WalkSprite_75_02_Oam05:
	INCBIN "data/bank_075/d_5351.bin" ; $5351, 12 bytes
WalkSprite_75_03:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_75_5980, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_75_03_Gfx00, WalkSprite_75_03_Gfx01, WalkSprite_75_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_03_Gfx02 ; $536d
	dw WalkSprite_75_03_Gfx02 ; $536f
	dw WalkSprite_75_03_Gfx02 ; $5371
	dw WalkSprite_75_03_Gfx02 ; $5373
	dw WalkSprite_75_03_Gfx03 ; $5375
	dw WalkSprite_75_03_Gfx04 ; $5377
	dw WalkSprite_75_03_Gfx05 ; $5379
Padding_75_537b:
	; $537b, 5 bytes (fill)
	ds 5, $00
WalkSprite_75_03_Gfx00:
	INCBIN "data/bank_075/d_5380.bin" ; $5380, 256 bytes
WalkSprite_75_03_Gfx01:
	INCBIN "data/bank_075/d_5480.bin" ; $5480, 256 bytes
WalkSprite_75_03_Gfx02:
	INCBIN "data/bank_075/d_5580.bin" ; $5580, 256 bytes
WalkSprite_75_03_Gfx03:
	INCBIN "data/bank_075/d_5680.bin" ; $5680, 256 bytes
WalkSprite_75_03_Gfx04:
	INCBIN "data/bank_075/d_5780.bin" ; $5780, 256 bytes
WalkSprite_75_03_Gfx05:
	INCBIN "data/bank_075/d_5880.bin" ; $5880, 256 bytes
OamPtrs_75_5980:
	dw WalkSprite_75_03_Oam00 ; $5980
	dw WalkSprite_75_03_Oam01 ; $5982
	dw WalkSprite_75_03_Oam02 ; $5984
	dw WalkSprite_75_03_Oam03 ; $5986
	dw WalkSprite_75_03_Oam04 ; $5988
	dw WalkSprite_75_03_Oam05 ; $598a
	dw WalkSprite_75_03_Oam05 ; $598c
	dw WalkSprite_75_03_Oam05 ; $598e
WalkSprite_75_03_Oam00:
	INCBIN "data/bank_075/d_5990.bin" ; $5990, 3 bytes
WalkSprite_75_03_Oam01:
	INCBIN "data/bank_075/d_5993.bin" ; $5993, 6 bytes
WalkSprite_75_03_Oam02:
	INCBIN "data/bank_075/d_5999.bin" ; $5999, 12 bytes
WalkSprite_75_03_Oam03:
	INCBIN "data/bank_075/d_59a5.bin" ; $59a5, 8 bytes
WalkSprite_75_03_Oam04:
	INCBIN "data/bank_075/d_59ad.bin" ; $59ad, 20 bytes
WalkSprite_75_03_Oam05:
	INCBIN "data/bank_075/d_59c1.bin" ; $59c1, 12 bytes
WalkSprite_75_04:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_75_5ff0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_75_04_Gfx00, WalkSprite_75_04_Gfx01, WalkSprite_75_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_04_Gfx02 ; $59dd
	dw WalkSprite_75_04_Gfx02 ; $59df
	dw WalkSprite_75_04_Gfx02 ; $59e1
	dw WalkSprite_75_04_Gfx02 ; $59e3
	dw WalkSprite_75_04_Gfx03 ; $59e5
	dw WalkSprite_75_04_Gfx04 ; $59e7
	dw WalkSprite_75_04_Gfx05 ; $59e9
Padding_75_59eb:
	; $59eb, 5 bytes (fill)
	ds 5, $00
WalkSprite_75_04_Gfx00:
	INCBIN "data/bank_075/d_59f0.bin" ; $59f0, 256 bytes
WalkSprite_75_04_Gfx01:
	INCBIN "data/bank_075/d_5af0.bin" ; $5af0, 256 bytes
WalkSprite_75_04_Gfx02:
	INCBIN "data/bank_075/d_5bf0.bin" ; $5bf0, 256 bytes
WalkSprite_75_04_Gfx03:
	INCBIN "data/bank_075/d_5cf0.bin" ; $5cf0, 256 bytes
WalkSprite_75_04_Gfx04:
	INCBIN "data/bank_075/d_5df0.bin" ; $5df0, 256 bytes
WalkSprite_75_04_Gfx05:
	INCBIN "data/bank_075/d_5ef0.bin" ; $5ef0, 256 bytes
OamPtrs_75_5ff0:
	dw WalkSprite_75_04_Oam00 ; $5ff0
	dw WalkSprite_75_04_Oam01 ; $5ff2
	dw WalkSprite_75_04_Oam02 ; $5ff4
	dw WalkSprite_75_04_Oam03 ; $5ff6
	dw WalkSprite_75_04_Oam04 ; $5ff8
	dw WalkSprite_75_04_Oam05 ; $5ffa
	dw WalkSprite_75_04_Oam05 ; $5ffc
	dw WalkSprite_75_04_Oam05 ; $5ffe
WalkSprite_75_04_Oam00:
	INCBIN "data/bank_075/d_6000.bin" ; $6000, 3 bytes
WalkSprite_75_04_Oam01:
	INCBIN "data/bank_075/d_6003.bin" ; $6003, 6 bytes
WalkSprite_75_04_Oam02:
	INCBIN "data/bank_075/d_6009.bin" ; $6009, 12 bytes
WalkSprite_75_04_Oam03:
	INCBIN "data/bank_075/d_6015.bin" ; $6015, 8 bytes
WalkSprite_75_04_Oam04:
	INCBIN "data/bank_075/d_601d.bin" ; $601d, 20 bytes
WalkSprite_75_04_Oam05:
	INCBIN "data/bank_075/d_6031.bin" ; $6031, 12 bytes
WalkSprite_75_05:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_75_6660, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_75_05_Gfx00, WalkSprite_75_05_Gfx01, WalkSprite_75_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_05_Gfx02 ; $604d
	dw WalkSprite_75_05_Gfx02 ; $604f
	dw WalkSprite_75_05_Gfx02 ; $6051
	dw WalkSprite_75_05_Gfx02 ; $6053
	dw WalkSprite_75_05_Gfx03 ; $6055
	dw WalkSprite_75_05_Gfx04 ; $6057
	dw WalkSprite_75_05_Gfx05 ; $6059
Padding_75_605b:
	; $605b, 5 bytes (fill)
	ds 5, $00
WalkSprite_75_05_Gfx00:
	INCBIN "data/bank_075/d_6060.bin" ; $6060, 256 bytes
WalkSprite_75_05_Gfx01:
	INCBIN "data/bank_075/d_6160.bin" ; $6160, 256 bytes
WalkSprite_75_05_Gfx02:
	INCBIN "data/bank_075/d_6260.bin" ; $6260, 256 bytes
WalkSprite_75_05_Gfx03:
	INCBIN "data/bank_075/d_6360.bin" ; $6360, 256 bytes
WalkSprite_75_05_Gfx04:
	INCBIN "data/bank_075/d_6460.bin" ; $6460, 256 bytes
WalkSprite_75_05_Gfx05:
	INCBIN "data/bank_075/d_6560.bin" ; $6560, 256 bytes
OamPtrs_75_6660:
	dw WalkSprite_75_05_Oam00 ; $6660
	dw WalkSprite_75_05_Oam01 ; $6662
	dw WalkSprite_75_05_Oam02 ; $6664
	dw WalkSprite_75_05_Oam03 ; $6666
	dw WalkSprite_75_05_Oam04 ; $6668
	dw WalkSprite_75_05_Oam05 ; $666a
	dw WalkSprite_75_05_Oam05 ; $666c
	dw WalkSprite_75_05_Oam05 ; $666e
WalkSprite_75_05_Oam00:
	INCBIN "data/bank_075/d_6670.bin" ; $6670, 3 bytes
WalkSprite_75_05_Oam01:
	INCBIN "data/bank_075/d_6673.bin" ; $6673, 6 bytes
WalkSprite_75_05_Oam02:
	INCBIN "data/bank_075/d_6679.bin" ; $6679, 12 bytes
WalkSprite_75_05_Oam03:
	INCBIN "data/bank_075/d_6685.bin" ; $6685, 8 bytes
WalkSprite_75_05_Oam04:
	INCBIN "data/bank_075/d_668d.bin" ; $668d, 20 bytes
WalkSprite_75_05_Oam05:
	INCBIN "data/bank_075/d_66a1.bin" ; $66a1, 12 bytes
WalkSprite_75_06:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_75_6cd0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_75_06_Gfx00, WalkSprite_75_06_Gfx01, WalkSprite_75_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_06_Gfx02 ; $66bd
	dw WalkSprite_75_06_Gfx02 ; $66bf
	dw WalkSprite_75_06_Gfx02 ; $66c1
	dw WalkSprite_75_06_Gfx02 ; $66c3
	dw WalkSprite_75_06_Gfx03 ; $66c5
	dw WalkSprite_75_06_Gfx04 ; $66c7
	dw WalkSprite_75_06_Gfx05 ; $66c9
	dw OamPtrs_75_6cd0 ; $66cb
Padding_75_66cd:
	; $66cd, 3 bytes (fill)
	ds 3, $00
WalkSprite_75_06_Gfx00:
	INCBIN "data/bank_075/d_66d0.bin" ; $66d0, 256 bytes
WalkSprite_75_06_Gfx01:
	INCBIN "data/bank_075/d_67d0.bin" ; $67d0, 256 bytes
WalkSprite_75_06_Gfx02:
	INCBIN "data/bank_075/d_68d0.bin" ; $68d0, 256 bytes
WalkSprite_75_06_Gfx03:
	INCBIN "data/bank_075/d_69d0.bin" ; $69d0, 256 bytes
WalkSprite_75_06_Gfx04:
	INCBIN "data/bank_075/d_6ad0.bin" ; $6ad0, 256 bytes
WalkSprite_75_06_Gfx05:
	INCBIN "data/bank_075/d_6bd0.bin" ; $6bd0, 256 bytes
OamPtrs_75_6cd0:
	dw WalkSprite_75_06_Oam00 ; $6cd0
	dw WalkSprite_75_06_Oam01 ; $6cd2
	dw WalkSprite_75_06_Oam02 ; $6cd4
	dw WalkSprite_75_06_Oam03 ; $6cd6
	dw WalkSprite_75_06_Oam04 ; $6cd8
	dw WalkSprite_75_06_Oam05 ; $6cda
	dw WalkSprite_75_06_Oam06 ; $6cdc
	dw WalkSprite_75_06_Oam06 ; $6cde
	dw WalkSprite_75_06_Oam07 ; $6ce0
WalkSprite_75_06_Oam00:
	INCBIN "data/bank_075/d_6ce2.bin" ; $6ce2, 3 bytes
WalkSprite_75_06_Oam01:
	INCBIN "data/bank_075/d_6ce5.bin" ; $6ce5, 6 bytes
WalkSprite_75_06_Oam02:
	INCBIN "data/bank_075/d_6ceb.bin" ; $6ceb, 12 bytes
WalkSprite_75_06_Oam03:
	INCBIN "data/bank_075/d_6cf7.bin" ; $6cf7, 8 bytes
WalkSprite_75_06_Oam04:
	INCBIN "data/bank_075/d_6cff.bin" ; $6cff, 20 bytes
WalkSprite_75_06_Oam05:
	INCBIN "data/bank_075/d_6d13.bin" ; $6d13, 6 bytes
WalkSprite_75_06_Oam06:
	INCBIN "data/bank_075/d_6d19.bin" ; $6d19, 12 bytes
WalkSprite_75_06_Oam07:
	INCBIN "data/bank_075/d_6d25.bin" ; $6d25, 6 bytes
WalkSprite_75_07:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_75_7350, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_75_07_Gfx00, WalkSprite_75_07_Gfx01, WalkSprite_75_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_07_Gfx02 ; $6d3b
	dw WalkSprite_75_07_Gfx02 ; $6d3d
	dw WalkSprite_75_07_Gfx02 ; $6d3f
	dw WalkSprite_75_07_Gfx02 ; $6d41
	dw WalkSprite_75_07_Gfx03 ; $6d43
	dw WalkSprite_75_07_Gfx04 ; $6d45
	dw WalkSprite_75_07_Gfx05 ; $6d47
Padding_75_6d49:
	; $6d49, 7 bytes (fill)
	ds 7, $00
WalkSprite_75_07_Gfx00:
	INCBIN "data/bank_075/d_6d50.bin" ; $6d50, 256 bytes
WalkSprite_75_07_Gfx01:
	INCBIN "data/bank_075/d_6e50.bin" ; $6e50, 256 bytes
WalkSprite_75_07_Gfx02:
	INCBIN "data/bank_075/d_6f50.bin" ; $6f50, 256 bytes
WalkSprite_75_07_Gfx03:
	INCBIN "data/bank_075/d_7050.bin" ; $7050, 256 bytes
WalkSprite_75_07_Gfx04:
	INCBIN "data/bank_075/d_7150.bin" ; $7150, 256 bytes
WalkSprite_75_07_Gfx05:
	INCBIN "data/bank_075/d_7250.bin" ; $7250, 256 bytes
OamPtrs_75_7350:
	dw WalkSprite_75_07_Oam00 ; $7350
	dw WalkSprite_75_07_Oam01 ; $7352
	dw WalkSprite_75_07_Oam02 ; $7354
	dw WalkSprite_75_07_Oam03 ; $7356
	dw WalkSprite_75_07_Oam04 ; $7358
	dw WalkSprite_75_07_Oam05 ; $735a
	dw WalkSprite_75_07_Oam05 ; $735c
	dw WalkSprite_75_07_Oam05 ; $735e
WalkSprite_75_07_Oam00:
	INCBIN "data/bank_075/d_7360.bin" ; $7360, 3 bytes
WalkSprite_75_07_Oam01:
	INCBIN "data/bank_075/d_7363.bin" ; $7363, 6 bytes
WalkSprite_75_07_Oam02:
	INCBIN "data/bank_075/d_7369.bin" ; $7369, 12 bytes
WalkSprite_75_07_Oam03:
	INCBIN "data/bank_075/d_7375.bin" ; $7375, 8 bytes
WalkSprite_75_07_Oam04:
	INCBIN "data/bank_075/d_737d.bin" ; $737d, 20 bytes
WalkSprite_75_07_Oam05:
	INCBIN "data/bank_075/d_7391.bin" ; $7391, 12 bytes
WalkSprite_75_08:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_75_7dc0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_75_08_Gfx00, WalkSprite_75_08_Gfx01, WalkSprite_75_08_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_08_Gfx03 ; $73ad
	dw WalkSprite_75_08_Gfx04 ; $73af
	dw WalkSprite_75_08_Gfx05 ; $73b1
	dw WalkSprite_75_08_Gfx06 ; $73b3
	dw WalkSprite_75_08_Gfx07 ; $73b5
	dw WalkSprite_75_08_Gfx08 ; $73b7
	dw WalkSprite_75_08_Gfx09 ; $73b9
Padding_75_73bb:
	; $73bb, 5 bytes (fill)
	ds 5, $00
WalkSprite_75_08_Gfx00:
	INCBIN "data/bank_075/d_73c0.bin" ; $73c0, 256 bytes
WalkSprite_75_08_Gfx01:
	INCBIN "data/bank_075/d_74c0.bin" ; $74c0, 256 bytes
WalkSprite_75_08_Gfx02:
	INCBIN "data/bank_075/d_75c0.bin" ; $75c0, 256 bytes
WalkSprite_75_08_Gfx03:
	INCBIN "data/bank_075/d_76c0.bin" ; $76c0, 256 bytes
WalkSprite_75_08_Gfx04:
	INCBIN "data/bank_075/d_77c0.bin" ; $77c0, 256 bytes
WalkSprite_75_08_Gfx05:
	INCBIN "data/bank_075/d_78c0.bin" ; $78c0, 256 bytes
WalkSprite_75_08_Gfx06:
	INCBIN "data/bank_075/d_79c0.bin" ; $79c0, 256 bytes
WalkSprite_75_08_Gfx07:
	INCBIN "data/bank_075/d_7ac0.bin" ; $7ac0, 256 bytes
WalkSprite_75_08_Gfx08:
	INCBIN "data/bank_075/d_7bc0.bin" ; $7bc0, 256 bytes
WalkSprite_75_08_Gfx09:
	INCBIN "data/bank_075/d_7cc0.bin" ; $7cc0, 256 bytes
OamPtrs_75_7dc0:
	dw WalkSprite_75_08_Oam00 ; $7dc0
	dw WalkSprite_75_08_Oam01 ; $7dc2
	dw WalkSprite_75_08_Oam02 ; $7dc4
	dw WalkSprite_75_08_Oam03 ; $7dc6
	dw WalkSprite_75_08_Oam04 ; $7dc8
	dw WalkSprite_75_08_Oam05 ; $7dca
	dw WalkSprite_75_08_Oam06 ; $7dcc
	dw WalkSprite_75_08_Oam07 ; $7dce
WalkSprite_75_08_Oam00:
	INCBIN "data/bank_075/d_7dd0.bin" ; $7dd0, 3 bytes
WalkSprite_75_08_Oam01:
	INCBIN "data/bank_075/d_7dd3.bin" ; $7dd3, 6 bytes
WalkSprite_75_08_Oam02:
	INCBIN "data/bank_075/d_7dd9.bin" ; $7dd9, 12 bytes
WalkSprite_75_08_Oam03:
	INCBIN "data/bank_075/d_7de5.bin" ; $7de5, 8 bytes
WalkSprite_75_08_Oam04:
	INCBIN "data/bank_075/d_7ded.bin" ; $7ded, 20 bytes
WalkSprite_75_08_Oam05:
	INCBIN "data/bank_075/d_7e01.bin" ; $7e01, 8 bytes
WalkSprite_75_08_Oam06:
	INCBIN "data/bank_075/d_7e09.bin" ; $7e09, 5 bytes
WalkSprite_75_08_Oam07:
	INCBIN "data/bank_075/d_7e0e.bin" ; $7e0e, 12 bytes
	; $7e1a, 486 bytes fill to bank end (linker-padded)

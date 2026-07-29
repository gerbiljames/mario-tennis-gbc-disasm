SECTION "ROM Bank $6f", ROMX[$4000], BANK[$6f]

WalkSprites_6f:
	dw WalkSprite_6f_00 ; $4000
	dw WalkSprite_6f_01 ; $4002
	dw WalkSprite_6f_02 ; $4004
	dw WalkSprite_6f_03 ; $4006
	dw WalkSprite_6f_04 ; $4008
	dw WalkSprite_6f_05 ; $400a
	dw WalkSprite_6f_06 ; $400c
	dw WalkSprite_6f_07 ; $400e
WalkSprite_6f_00:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_6f_00_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6f_00_Gfx00, WalkSprite_6f_00_Gfx01, WalkSprite_6f_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_00_Gfx02 ; $4020
	dw WalkSprite_6f_00_Gfx02 ; $4022
	dw WalkSprite_6f_00_Gfx02 ; $4024
	dw WalkSprite_6f_00_Gfx02 ; $4026
	dw WalkSprite_6f_00_Gfx03 ; $4028
	dw WalkSprite_6f_00_Gfx04 ; $402a
	dw WalkSprite_6f_00_Gfx05 ; $402c
	db $00 ; $402e
	db $00 ; $402f
WalkSprite_6f_00_Gfx00:
	INCBIN "data/bank_06f/d_4030.bin" ; $4030, 256 bytes
WalkSprite_6f_00_Gfx01:
	INCBIN "data/bank_06f/d_4130.bin" ; $4130, 256 bytes
WalkSprite_6f_00_Gfx02:
	INCBIN "data/bank_06f/d_4230.bin" ; $4230, 256 bytes
WalkSprite_6f_00_Gfx03:
	INCBIN "data/bank_06f/d_4330.bin" ; $4330, 256 bytes
WalkSprite_6f_00_Gfx04:
	INCBIN "data/bank_06f/d_4430.bin" ; $4430, 256 bytes
WalkSprite_6f_00_Gfx05:
	INCBIN "data/bank_06f/d_4530.bin" ; $4530, 256 bytes
WalkSprite_6f_00_OamPtrs:
	dw WalkSprite_6f_00_Oam00 ; $4630
	dw WalkSprite_6f_00_Oam01 ; $4632
	dw WalkSprite_6f_00_Oam02 ; $4634
	dw WalkSprite_6f_00_Oam03 ; $4636
	dw WalkSprite_6f_00_Oam04 ; $4638
	dw WalkSprite_6f_00_Oam05 ; $463a
	dw WalkSprite_6f_00_Oam05 ; $463c
	dw WalkSprite_6f_00_Oam06 ; $463e
	dw WalkSprite_6f_00_Oam07 ; $4640
	dw WalkSprite_6f_00_Oam08 ; $4642
	dw WalkSprite_6f_00_Oam09 ; $4644
	dw WalkSprite_6f_00_Oam10 ; $4646
WalkSprite_6f_00_Oam00:
	INCBIN "data/bank_06f/d_4648.bin" ; $4648, 3 bytes
WalkSprite_6f_00_Oam01:
	INCBIN "data/bank_06f/d_464b.bin" ; $464b, 6 bytes
WalkSprite_6f_00_Oam02:
	INCBIN "data/bank_06f/d_4651.bin" ; $4651, 12 bytes
WalkSprite_6f_00_Oam03:
	INCBIN "data/bank_06f/d_465d.bin" ; $465d, 8 bytes
WalkSprite_6f_00_Oam04:
	INCBIN "data/bank_06f/d_4665.bin" ; $4665, 20 bytes
WalkSprite_6f_00_Oam05:
	INCBIN "data/bank_06f/d_4679.bin" ; $4679, 5 bytes
WalkSprite_6f_00_Oam06:
	INCBIN "data/bank_06f/d_467e.bin" ; $467e, 12 bytes
WalkSprite_6f_00_Oam07:
	INCBIN "data/bank_06f/d_468a.bin" ; $468a, 6 bytes
WalkSprite_6f_00_Oam08:
	INCBIN "data/bank_06f/d_4690.bin" ; $4690, 3 bytes
WalkSprite_6f_00_Oam09:
	INCBIN "data/bank_06f/d_4693.bin" ; $4693, 3 bytes
WalkSprite_6f_00_Oam10:
	INCBIN "data/bank_06f/d_4696.bin" ; $4696, 11 bytes
WalkSprite_6f_01:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_6f_01_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6f_01_Gfx00, WalkSprite_6f_01_Gfx01, WalkSprite_6f_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_01_Gfx02 ; $46b1
	dw WalkSprite_6f_01_Gfx02 ; $46b3
	dw WalkSprite_6f_01_Gfx02 ; $46b5
	dw WalkSprite_6f_01_Gfx02 ; $46b7
	dw WalkSprite_6f_01_Gfx03 ; $46b9
	dw WalkSprite_6f_01_Gfx04 ; $46bb
	dw WalkSprite_6f_01_Gfx05 ; $46bd
	db $00 ; $46bf
WalkSprite_6f_01_Gfx00:
	INCBIN "data/bank_06f/d_46c0.bin" ; $46c0, 256 bytes
WalkSprite_6f_01_Gfx01:
	INCBIN "data/bank_06f/d_47c0.bin" ; $47c0, 256 bytes
WalkSprite_6f_01_Gfx02:
	INCBIN "data/bank_06f/d_48c0.bin" ; $48c0, 256 bytes
WalkSprite_6f_01_Gfx03:
	INCBIN "data/bank_06f/d_49c0.bin" ; $49c0, 256 bytes
WalkSprite_6f_01_Gfx04:
	INCBIN "data/bank_06f/d_4ac0.bin" ; $4ac0, 256 bytes
WalkSprite_6f_01_Gfx05:
	INCBIN "data/bank_06f/d_4bc0.bin" ; $4bc0, 256 bytes
WalkSprite_6f_01_OamPtrs:
	dw WalkSprite_6f_01_Oam00 ; $4cc0
	dw WalkSprite_6f_01_Oam01 ; $4cc2
	dw WalkSprite_6f_01_Oam02 ; $4cc4
	dw WalkSprite_6f_01_Oam03 ; $4cc6
	dw WalkSprite_6f_01_Oam04 ; $4cc8
	dw WalkSprite_6f_01_Oam05 ; $4cca
	dw WalkSprite_6f_01_Oam05 ; $4ccc
	dw WalkSprite_6f_01_Oam06 ; $4cce
	dw WalkSprite_6f_01_Oam07 ; $4cd0
	dw WalkSprite_6f_01_Oam08 ; $4cd2
	dw WalkSprite_6f_01_Oam09 ; $4cd4
	dw WalkSprite_6f_01_Oam10 ; $4cd6
WalkSprite_6f_01_Oam00:
	INCBIN "data/bank_06f/d_4cd8.bin" ; $4cd8, 3 bytes
WalkSprite_6f_01_Oam01:
	INCBIN "data/bank_06f/d_4cdb.bin" ; $4cdb, 6 bytes
WalkSprite_6f_01_Oam02:
	INCBIN "data/bank_06f/d_4ce1.bin" ; $4ce1, 12 bytes
WalkSprite_6f_01_Oam03:
	INCBIN "data/bank_06f/d_4ced.bin" ; $4ced, 8 bytes
WalkSprite_6f_01_Oam04:
	INCBIN "data/bank_06f/d_4cf5.bin" ; $4cf5, 20 bytes
WalkSprite_6f_01_Oam05:
	INCBIN "data/bank_06f/d_4d09.bin" ; $4d09, 5 bytes
WalkSprite_6f_01_Oam06:
	INCBIN "data/bank_06f/d_4d0e.bin" ; $4d0e, 12 bytes
WalkSprite_6f_01_Oam07:
	INCBIN "data/bank_06f/d_4d1a.bin" ; $4d1a, 6 bytes
WalkSprite_6f_01_Oam08:
	INCBIN "data/bank_06f/d_4d20.bin" ; $4d20, 3 bytes
WalkSprite_6f_01_Oam09:
	INCBIN "data/bank_06f/d_4d23.bin" ; $4d23, 3 bytes
WalkSprite_6f_01_Oam10:
	INCBIN "data/bank_06f/d_4d26.bin" ; $4d26, 11 bytes
WalkSprite_6f_02:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_6f_02_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6f_02_Gfx00, WalkSprite_6f_02_Gfx01, WalkSprite_6f_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_02_Gfx02 ; $4d41
	dw WalkSprite_6f_02_Gfx02 ; $4d43
	dw WalkSprite_6f_02_Gfx02 ; $4d45
	dw WalkSprite_6f_02_Gfx02 ; $4d47
	dw WalkSprite_6f_02_Gfx03 ; $4d49
	dw WalkSprite_6f_02_Gfx04 ; $4d4b
	dw WalkSprite_6f_02_Gfx05 ; $4d4d
	db $00 ; $4d4f
WalkSprite_6f_02_Gfx00:
	INCBIN "data/bank_06f/d_4d50.bin" ; $4d50, 256 bytes
WalkSprite_6f_02_Gfx01:
	INCBIN "data/bank_06f/d_4e50.bin" ; $4e50, 256 bytes
WalkSprite_6f_02_Gfx02:
	INCBIN "data/bank_06f/d_4f50.bin" ; $4f50, 256 bytes
WalkSprite_6f_02_Gfx03:
	INCBIN "data/bank_06f/d_5050.bin" ; $5050, 256 bytes
WalkSprite_6f_02_Gfx04:
	INCBIN "data/bank_06f/d_5150.bin" ; $5150, 256 bytes
WalkSprite_6f_02_Gfx05:
	INCBIN "data/bank_06f/d_5250.bin" ; $5250, 256 bytes
WalkSprite_6f_02_OamPtrs:
	dw WalkSprite_6f_02_Oam00 ; $5350
	dw WalkSprite_6f_02_Oam01 ; $5352
	dw WalkSprite_6f_02_Oam02 ; $5354
	dw WalkSprite_6f_02_Oam03 ; $5356
	dw WalkSprite_6f_02_Oam04 ; $5358
	dw WalkSprite_6f_02_Oam05 ; $535a
	dw WalkSprite_6f_02_Oam05 ; $535c
	dw WalkSprite_6f_02_Oam06 ; $535e
	dw WalkSprite_6f_02_Oam07 ; $5360
	dw WalkSprite_6f_02_Oam08 ; $5362
	dw WalkSprite_6f_02_Oam09 ; $5364
	dw WalkSprite_6f_02_Oam10 ; $5366
WalkSprite_6f_02_Oam00:
	INCBIN "data/bank_06f/d_5368.bin" ; $5368, 3 bytes
WalkSprite_6f_02_Oam01:
	INCBIN "data/bank_06f/d_536b.bin" ; $536b, 6 bytes
WalkSprite_6f_02_Oam02:
	INCBIN "data/bank_06f/d_5371.bin" ; $5371, 12 bytes
WalkSprite_6f_02_Oam03:
	INCBIN "data/bank_06f/d_537d.bin" ; $537d, 8 bytes
WalkSprite_6f_02_Oam04:
	INCBIN "data/bank_06f/d_5385.bin" ; $5385, 20 bytes
WalkSprite_6f_02_Oam05:
	INCBIN "data/bank_06f/d_5399.bin" ; $5399, 5 bytes
WalkSprite_6f_02_Oam06:
	INCBIN "data/bank_06f/d_539e.bin" ; $539e, 12 bytes
WalkSprite_6f_02_Oam07:
	INCBIN "data/bank_06f/d_53aa.bin" ; $53aa, 6 bytes
WalkSprite_6f_02_Oam08:
	INCBIN "data/bank_06f/d_53b0.bin" ; $53b0, 3 bytes
WalkSprite_6f_02_Oam09:
	INCBIN "data/bank_06f/d_53b3.bin" ; $53b3, 3 bytes
WalkSprite_6f_02_Oam10:
	INCBIN "data/bank_06f/d_53b6.bin" ; $53b6, 11 bytes
WalkSprite_6f_03:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_6f_03_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6f_03_Gfx00, WalkSprite_6f_03_Gfx01, WalkSprite_6f_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_03_Gfx02 ; $53d1
	dw WalkSprite_6f_03_Gfx02 ; $53d3
	dw WalkSprite_6f_03_Gfx02 ; $53d5
	dw WalkSprite_6f_03_Gfx02 ; $53d7
	dw WalkSprite_6f_03_Gfx03 ; $53d9
	dw WalkSprite_6f_03_Gfx04 ; $53db
	dw WalkSprite_6f_03_Gfx05 ; $53dd
	db $00 ; $53df
WalkSprite_6f_03_Gfx00:
	INCBIN "data/bank_06f/d_53e0.bin" ; $53e0, 256 bytes
WalkSprite_6f_03_Gfx01:
	INCBIN "data/bank_06f/d_54e0.bin" ; $54e0, 256 bytes
WalkSprite_6f_03_Gfx02:
	INCBIN "data/bank_06f/d_55e0.bin" ; $55e0, 256 bytes
WalkSprite_6f_03_Gfx03:
	INCBIN "data/bank_06f/d_56e0.bin" ; $56e0, 256 bytes
WalkSprite_6f_03_Gfx04:
	INCBIN "data/bank_06f/d_57e0.bin" ; $57e0, 256 bytes
WalkSprite_6f_03_Gfx05:
	INCBIN "data/bank_06f/d_58e0.bin" ; $58e0, 256 bytes
WalkSprite_6f_03_OamPtrs:
	dw WalkSprite_6f_03_Oam00 ; $59e0
	dw WalkSprite_6f_03_Oam01 ; $59e2
	dw WalkSprite_6f_03_Oam02 ; $59e4
	dw WalkSprite_6f_03_Oam03 ; $59e6
	dw WalkSprite_6f_03_Oam04 ; $59e8
	dw WalkSprite_6f_03_Oam05 ; $59ea
	dw WalkSprite_6f_03_Oam05 ; $59ec
	dw WalkSprite_6f_03_Oam06 ; $59ee
	dw WalkSprite_6f_03_Oam07 ; $59f0
	dw WalkSprite_6f_03_Oam08 ; $59f2
	dw WalkSprite_6f_03_Oam09 ; $59f4
	dw WalkSprite_6f_03_Oam10 ; $59f6
WalkSprite_6f_03_Oam00:
	INCBIN "data/bank_06f/d_59f8.bin" ; $59f8, 3 bytes
WalkSprite_6f_03_Oam01:
	INCBIN "data/bank_06f/d_59fb.bin" ; $59fb, 6 bytes
WalkSprite_6f_03_Oam02:
	INCBIN "data/bank_06f/d_5a01.bin" ; $5a01, 12 bytes
WalkSprite_6f_03_Oam03:
	INCBIN "data/bank_06f/d_5a0d.bin" ; $5a0d, 8 bytes
WalkSprite_6f_03_Oam04:
	INCBIN "data/bank_06f/d_5a15.bin" ; $5a15, 20 bytes
WalkSprite_6f_03_Oam05:
	INCBIN "data/bank_06f/d_5a29.bin" ; $5a29, 5 bytes
WalkSprite_6f_03_Oam06:
	INCBIN "data/bank_06f/d_5a2e.bin" ; $5a2e, 12 bytes
WalkSprite_6f_03_Oam07:
	INCBIN "data/bank_06f/d_5a3a.bin" ; $5a3a, 6 bytes
WalkSprite_6f_03_Oam08:
	INCBIN "data/bank_06f/d_5a40.bin" ; $5a40, 3 bytes
WalkSprite_6f_03_Oam09:
	INCBIN "data/bank_06f/d_5a43.bin" ; $5a43, 3 bytes
WalkSprite_6f_03_Oam10:
	INCBIN "data/bank_06f/d_5a46.bin" ; $5a46, 11 bytes
WalkSprite_6f_04:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_6f_04_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6f_04_Gfx00, WalkSprite_6f_04_Gfx01, WalkSprite_6f_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_04_Gfx02 ; $5a61
	dw WalkSprite_6f_04_Gfx02 ; $5a63
	dw WalkSprite_6f_04_Gfx02 ; $5a65
	dw WalkSprite_6f_04_Gfx02 ; $5a67
	dw WalkSprite_6f_04_Gfx03 ; $5a69
	dw WalkSprite_6f_04_Gfx04 ; $5a6b
	dw WalkSprite_6f_04_Gfx05 ; $5a6d
	db $00 ; $5a6f
WalkSprite_6f_04_Gfx00:
	INCBIN "data/bank_06f/d_5a70.bin" ; $5a70, 256 bytes
WalkSprite_6f_04_Gfx01:
	INCBIN "data/bank_06f/d_5b70.bin" ; $5b70, 256 bytes
WalkSprite_6f_04_Gfx02:
	INCBIN "data/bank_06f/d_5c70.bin" ; $5c70, 256 bytes
WalkSprite_6f_04_Gfx03:
	INCBIN "data/bank_06f/d_5d70.bin" ; $5d70, 256 bytes
WalkSprite_6f_04_Gfx04:
	INCBIN "data/bank_06f/d_5e70.bin" ; $5e70, 256 bytes
WalkSprite_6f_04_Gfx05:
	INCBIN "data/bank_06f/d_5f70.bin" ; $5f70, 256 bytes
WalkSprite_6f_04_OamPtrs:
	dw WalkSprite_6f_04_Oam00 ; $6070
	dw WalkSprite_6f_04_Oam01 ; $6072
	dw WalkSprite_6f_04_Oam02 ; $6074
	dw WalkSprite_6f_04_Oam03 ; $6076
	dw WalkSprite_6f_04_Oam04 ; $6078
	dw WalkSprite_6f_04_Oam05 ; $607a
	dw WalkSprite_6f_04_Oam05 ; $607c
	dw WalkSprite_6f_04_Oam06 ; $607e
	dw WalkSprite_6f_04_Oam07 ; $6080
	dw WalkSprite_6f_04_Oam08 ; $6082
	dw WalkSprite_6f_04_Oam09 ; $6084
	dw WalkSprite_6f_04_Oam10 ; $6086
WalkSprite_6f_04_Oam00:
	INCBIN "data/bank_06f/d_6088.bin" ; $6088, 3 bytes
WalkSprite_6f_04_Oam01:
	INCBIN "data/bank_06f/d_608b.bin" ; $608b, 6 bytes
WalkSprite_6f_04_Oam02:
	INCBIN "data/bank_06f/d_6091.bin" ; $6091, 12 bytes
WalkSprite_6f_04_Oam03:
	INCBIN "data/bank_06f/d_609d.bin" ; $609d, 8 bytes
WalkSprite_6f_04_Oam04:
	INCBIN "data/bank_06f/d_60a5.bin" ; $60a5, 20 bytes
WalkSprite_6f_04_Oam05:
	INCBIN "data/bank_06f/d_60b9.bin" ; $60b9, 5 bytes
WalkSprite_6f_04_Oam06:
	INCBIN "data/bank_06f/d_60be.bin" ; $60be, 12 bytes
WalkSprite_6f_04_Oam07:
	INCBIN "data/bank_06f/d_60ca.bin" ; $60ca, 6 bytes
WalkSprite_6f_04_Oam08:
	INCBIN "data/bank_06f/d_60d0.bin" ; $60d0, 3 bytes
WalkSprite_6f_04_Oam09:
	INCBIN "data/bank_06f/d_60d3.bin" ; $60d3, 3 bytes
WalkSprite_6f_04_Oam10:
	INCBIN "data/bank_06f/d_60d6.bin" ; $60d6, 11 bytes
WalkSprite_6f_05:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_6f_05_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6f_05_Gfx00, WalkSprite_6f_05_Gfx01, WalkSprite_6f_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_05_Gfx02 ; $60f1
	dw WalkSprite_6f_05_Gfx02 ; $60f3
	dw WalkSprite_6f_05_Gfx02 ; $60f5
	dw WalkSprite_6f_05_Gfx02 ; $60f7
	dw WalkSprite_6f_05_Gfx03 ; $60f9
	dw WalkSprite_6f_05_Gfx04 ; $60fb
	dw WalkSprite_6f_05_Gfx05 ; $60fd
	db $00 ; $60ff
WalkSprite_6f_05_Gfx00:
	INCBIN "data/bank_06f/d_6100.bin" ; $6100, 256 bytes
WalkSprite_6f_05_Gfx01:
	INCBIN "data/bank_06f/d_6200.bin" ; $6200, 256 bytes
WalkSprite_6f_05_Gfx02:
	INCBIN "data/bank_06f/d_6300.bin" ; $6300, 256 bytes
WalkSprite_6f_05_Gfx03:
	INCBIN "data/bank_06f/d_6400.bin" ; $6400, 256 bytes
WalkSprite_6f_05_Gfx04:
	INCBIN "data/bank_06f/d_6500.bin" ; $6500, 256 bytes
WalkSprite_6f_05_Gfx05:
	INCBIN "data/bank_06f/d_6600.bin" ; $6600, 256 bytes
WalkSprite_6f_05_OamPtrs:
	dw WalkSprite_6f_05_Oam00 ; $6700
	dw WalkSprite_6f_05_Oam01 ; $6702
	dw WalkSprite_6f_05_Oam02 ; $6704
	dw WalkSprite_6f_05_Oam03 ; $6706
	dw WalkSprite_6f_05_Oam04 ; $6708
	dw WalkSprite_6f_05_Oam05 ; $670a
	dw WalkSprite_6f_05_Oam05 ; $670c
	dw WalkSprite_6f_05_Oam06 ; $670e
	dw WalkSprite_6f_05_Oam07 ; $6710
	dw WalkSprite_6f_05_Oam08 ; $6712
	dw WalkSprite_6f_05_Oam09 ; $6714
	dw WalkSprite_6f_05_Oam10 ; $6716
WalkSprite_6f_05_Oam00:
	INCBIN "data/bank_06f/d_6718.bin" ; $6718, 3 bytes
WalkSprite_6f_05_Oam01:
	INCBIN "data/bank_06f/d_671b.bin" ; $671b, 6 bytes
WalkSprite_6f_05_Oam02:
	INCBIN "data/bank_06f/d_6721.bin" ; $6721, 12 bytes
WalkSprite_6f_05_Oam03:
	INCBIN "data/bank_06f/d_672d.bin" ; $672d, 8 bytes
WalkSprite_6f_05_Oam04:
	INCBIN "data/bank_06f/d_6735.bin" ; $6735, 20 bytes
WalkSprite_6f_05_Oam05:
	INCBIN "data/bank_06f/d_6749.bin" ; $6749, 5 bytes
WalkSprite_6f_05_Oam06:
	INCBIN "data/bank_06f/d_674e.bin" ; $674e, 12 bytes
WalkSprite_6f_05_Oam07:
	INCBIN "data/bank_06f/d_675a.bin" ; $675a, 6 bytes
WalkSprite_6f_05_Oam08:
	INCBIN "data/bank_06f/d_6760.bin" ; $6760, 3 bytes
WalkSprite_6f_05_Oam09:
	INCBIN "data/bank_06f/d_6763.bin" ; $6763, 3 bytes
WalkSprite_6f_05_Oam10:
	INCBIN "data/bank_06f/d_6766.bin" ; $6766, 11 bytes
WalkSprite_6f_06:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_6f_06_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6f_06_Gfx00, WalkSprite_6f_06_Gfx01, WalkSprite_6f_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_06_Gfx02 ; $6781
	dw WalkSprite_6f_06_Gfx02 ; $6783
	dw WalkSprite_6f_06_Gfx02 ; $6785
	dw WalkSprite_6f_06_Gfx02 ; $6787
	dw WalkSprite_6f_06_Gfx03 ; $6789
	dw WalkSprite_6f_06_Gfx04 ; $678b
	dw WalkSprite_6f_06_Gfx05 ; $678d
	db $00 ; $678f
WalkSprite_6f_06_Gfx00:
	INCBIN "data/bank_06f/d_6790.bin" ; $6790, 256 bytes
WalkSprite_6f_06_Gfx01:
	INCBIN "data/bank_06f/d_6890.bin" ; $6890, 256 bytes
WalkSprite_6f_06_Gfx02:
	INCBIN "data/bank_06f/d_6990.bin" ; $6990, 256 bytes
WalkSprite_6f_06_Gfx03:
	INCBIN "data/bank_06f/d_6a90.bin" ; $6a90, 256 bytes
WalkSprite_6f_06_Gfx04:
	INCBIN "data/bank_06f/d_6b90.bin" ; $6b90, 256 bytes
WalkSprite_6f_06_Gfx05:
	INCBIN "data/bank_06f/d_6c90.bin" ; $6c90, 256 bytes
WalkSprite_6f_06_OamPtrs:
	dw WalkSprite_6f_06_Oam00 ; $6d90
	dw WalkSprite_6f_06_Oam01 ; $6d92
	dw WalkSprite_6f_06_Oam02 ; $6d94
	dw WalkSprite_6f_06_Oam03 ; $6d96
	dw WalkSprite_6f_06_Oam04 ; $6d98
	dw WalkSprite_6f_06_Oam05 ; $6d9a
	dw WalkSprite_6f_06_Oam05 ; $6d9c
	dw WalkSprite_6f_06_Oam06 ; $6d9e
	dw WalkSprite_6f_06_Oam07 ; $6da0
	dw WalkSprite_6f_06_Oam08 ; $6da2
	dw WalkSprite_6f_06_Oam09 ; $6da4
	dw WalkSprite_6f_06_Oam10 ; $6da6
WalkSprite_6f_06_Oam00:
	INCBIN "data/bank_06f/d_6da8.bin" ; $6da8, 3 bytes
WalkSprite_6f_06_Oam01:
	INCBIN "data/bank_06f/d_6dab.bin" ; $6dab, 6 bytes
WalkSprite_6f_06_Oam02:
	INCBIN "data/bank_06f/d_6db1.bin" ; $6db1, 12 bytes
WalkSprite_6f_06_Oam03:
	INCBIN "data/bank_06f/d_6dbd.bin" ; $6dbd, 8 bytes
WalkSprite_6f_06_Oam04:
	INCBIN "data/bank_06f/d_6dc5.bin" ; $6dc5, 20 bytes
WalkSprite_6f_06_Oam05:
	INCBIN "data/bank_06f/d_6dd9.bin" ; $6dd9, 5 bytes
WalkSprite_6f_06_Oam06:
	INCBIN "data/bank_06f/d_6dde.bin" ; $6dde, 12 bytes
WalkSprite_6f_06_Oam07:
	INCBIN "data/bank_06f/d_6dea.bin" ; $6dea, 6 bytes
WalkSprite_6f_06_Oam08:
	INCBIN "data/bank_06f/d_6df0.bin" ; $6df0, 3 bytes
WalkSprite_6f_06_Oam09:
	INCBIN "data/bank_06f/d_6df3.bin" ; $6df3, 3 bytes
WalkSprite_6f_06_Oam10:
	INCBIN "data/bank_06f/d_6df6.bin" ; $6df6, 11 bytes
WalkSprite_6f_07:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_6f_07_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6f_07_Gfx00, WalkSprite_6f_07_Gfx01, WalkSprite_6f_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_07_Gfx02 ; $6e11
	dw WalkSprite_6f_07_Gfx02 ; $6e13
	dw WalkSprite_6f_07_Gfx02 ; $6e15
	dw WalkSprite_6f_07_Gfx02 ; $6e17
	dw WalkSprite_6f_07_Gfx03 ; $6e19
	dw WalkSprite_6f_07_Gfx04 ; $6e1b
	dw WalkSprite_6f_07_Gfx05 ; $6e1d
	db $00 ; $6e1f
WalkSprite_6f_07_Gfx00:
	INCBIN "data/bank_06f/d_6e20.bin" ; $6e20, 256 bytes
WalkSprite_6f_07_Gfx01:
	INCBIN "data/bank_06f/d_6f20.bin" ; $6f20, 256 bytes
WalkSprite_6f_07_Gfx02:
	INCBIN "data/bank_06f/d_7020.bin" ; $7020, 256 bytes
WalkSprite_6f_07_Gfx03:
	INCBIN "data/bank_06f/d_7120.bin" ; $7120, 256 bytes
WalkSprite_6f_07_Gfx04:
	INCBIN "data/bank_06f/d_7220.bin" ; $7220, 256 bytes
WalkSprite_6f_07_Gfx05:
	INCBIN "data/bank_06f/d_7320.bin" ; $7320, 256 bytes
WalkSprite_6f_07_OamPtrs:
	dw WalkSprite_6f_07_Oam00 ; $7420
	dw WalkSprite_6f_07_Oam01 ; $7422
	dw WalkSprite_6f_07_Oam02 ; $7424
	dw WalkSprite_6f_07_Oam03 ; $7426
	dw WalkSprite_6f_07_Oam04 ; $7428
	dw WalkSprite_6f_07_Oam05 ; $742a
	dw WalkSprite_6f_07_Oam05 ; $742c
	dw WalkSprite_6f_07_Oam06 ; $742e
	dw WalkSprite_6f_07_Oam07 ; $7430
	dw WalkSprite_6f_07_Oam08 ; $7432
	dw WalkSprite_6f_07_Oam09 ; $7434
	dw WalkSprite_6f_07_Oam10 ; $7436
WalkSprite_6f_07_Oam00:
	INCBIN "data/bank_06f/d_7438.bin" ; $7438, 3 bytes
WalkSprite_6f_07_Oam01:
	INCBIN "data/bank_06f/d_743b.bin" ; $743b, 6 bytes
WalkSprite_6f_07_Oam02:
	INCBIN "data/bank_06f/d_7441.bin" ; $7441, 12 bytes
WalkSprite_6f_07_Oam03:
	INCBIN "data/bank_06f/d_744d.bin" ; $744d, 8 bytes
WalkSprite_6f_07_Oam04:
	INCBIN "data/bank_06f/d_7455.bin" ; $7455, 20 bytes
WalkSprite_6f_07_Oam05:
	INCBIN "data/bank_06f/d_7469.bin" ; $7469, 5 bytes
WalkSprite_6f_07_Oam06:
	INCBIN "data/bank_06f/d_746e.bin" ; $746e, 12 bytes
WalkSprite_6f_07_Oam07:
	INCBIN "data/bank_06f/d_747a.bin" ; $747a, 6 bytes
WalkSprite_6f_07_Oam08:
	INCBIN "data/bank_06f/d_7480.bin" ; $7480, 3 bytes
WalkSprite_6f_07_Oam09:
	INCBIN "data/bank_06f/d_7483.bin" ; $7483, 3 bytes
WalkSprite_6f_07_Oam10:
	INCBIN "data/bank_06f/d_7486.bin" ; $7486, 11 bytes
	; $7491, 2927 bytes fill to bank end (linker-padded)

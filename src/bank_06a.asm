SECTION "ROM Bank $6a", ROMX[$4000], BANK[$6a]

WalkSprites_6a:
	dw WalkSprite_6a_00 ; $4000
	dw WalkSprite_6a_01 ; $4002
	dw WalkSprite_6a_02 ; $4004
	dw WalkSprite_6a_03 ; $4006
	dw WalkSprite_6a_04 ; $4008
WalkSprite_6a_00:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6a_4630, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6a_00_Gfx00, WalkSprite_6a_00_Gfx01, WalkSprite_6a_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6a_00_Gfx02 ; $401a
	dw WalkSprite_6a_00_Gfx02 ; $401c
	dw WalkSprite_6a_00_Gfx02 ; $401e
	dw WalkSprite_6a_00_Gfx02 ; $4020
	dw WalkSprite_6a_00_Gfx03 ; $4022
	dw WalkSprite_6a_00_Gfx04 ; $4024
	dw WalkSprite_6a_00_Gfx05 ; $4026
Padding_6a_4028:
	; $4028, 8 bytes (fill)
	ds 8, $00
WalkSprite_6a_00_Gfx00:
	INCBIN "data/bank_06a/d_4030.bin" ; $4030, 256 bytes
WalkSprite_6a_00_Gfx01:
	INCBIN "data/bank_06a/d_4130.bin" ; $4130, 256 bytes
WalkSprite_6a_00_Gfx02:
	INCBIN "data/bank_06a/d_4230.bin" ; $4230, 256 bytes
WalkSprite_6a_00_Gfx03:
	INCBIN "data/bank_06a/d_4330.bin" ; $4330, 256 bytes
WalkSprite_6a_00_Gfx04:
	INCBIN "data/bank_06a/d_4430.bin" ; $4430, 256 bytes
WalkSprite_6a_00_Gfx05:
	INCBIN "data/bank_06a/d_4530.bin" ; $4530, 256 bytes
OamPtrs_6a_4630:
	dw WalkSprite_6a_00_Oam00 ; $4630
	dw WalkSprite_6a_00_Oam01 ; $4632
	dw WalkSprite_6a_00_Oam02 ; $4634
	dw WalkSprite_6a_00_Oam03 ; $4636
	dw WalkSprite_6a_00_Oam04 ; $4638
	dw WalkSprite_6a_00_Oam05 ; $463a
	dw WalkSprite_6a_00_Oam05 ; $463c
	dw WalkSprite_6a_00_Oam06 ; $463e
	dw WalkSprite_6a_00_Oam07 ; $4640
	dw WalkSprite_6a_00_Oam08 ; $4642
	dw WalkSprite_6a_00_Oam09 ; $4644
	dw WalkSprite_6a_00_Oam10 ; $4646
WalkSprite_6a_00_Oam00:
	INCBIN "data/bank_06a/d_4648.bin" ; $4648, 3 bytes
WalkSprite_6a_00_Oam01:
	INCBIN "data/bank_06a/d_464b.bin" ; $464b, 6 bytes
WalkSprite_6a_00_Oam02:
	INCBIN "data/bank_06a/d_4651.bin" ; $4651, 12 bytes
WalkSprite_6a_00_Oam03:
	INCBIN "data/bank_06a/d_465d.bin" ; $465d, 8 bytes
WalkSprite_6a_00_Oam04:
	INCBIN "data/bank_06a/d_4665.bin" ; $4665, 20 bytes
WalkSprite_6a_00_Oam05:
	INCBIN "data/bank_06a/d_4679.bin" ; $4679, 5 bytes
WalkSprite_6a_00_Oam06:
	INCBIN "data/bank_06a/d_467e.bin" ; $467e, 12 bytes
WalkSprite_6a_00_Oam07:
	INCBIN "data/bank_06a/d_468a.bin" ; $468a, 6 bytes
WalkSprite_6a_00_Oam08:
	INCBIN "data/bank_06a/d_4690.bin" ; $4690, 3 bytes
WalkSprite_6a_00_Oam09:
	INCBIN "data/bank_06a/d_4693.bin" ; $4693, 3 bytes
WalkSprite_6a_00_Oam10:
	INCBIN "data/bank_06a/d_4696.bin" ; $4696, 11 bytes
WalkSprite_6a_01:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6a_4cc0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6a_01_Gfx00, WalkSprite_6a_01_Gfx01, WalkSprite_6a_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6a_01_Gfx02 ; $46b1
	dw WalkSprite_6a_01_Gfx02 ; $46b3
	dw WalkSprite_6a_01_Gfx02 ; $46b5
	dw WalkSprite_6a_01_Gfx02 ; $46b7
	dw WalkSprite_6a_01_Gfx03 ; $46b9
	dw WalkSprite_6a_01_Gfx04 ; $46bb
	dw WalkSprite_6a_01_Gfx05 ; $46bd
	db $00 ; $46bf
WalkSprite_6a_01_Gfx00:
	INCBIN "data/bank_06a/d_46c0.bin" ; $46c0, 256 bytes
WalkSprite_6a_01_Gfx01:
	INCBIN "data/bank_06a/d_47c0.bin" ; $47c0, 256 bytes
WalkSprite_6a_01_Gfx02:
	INCBIN "data/bank_06a/d_48c0.bin" ; $48c0, 256 bytes
WalkSprite_6a_01_Gfx03:
	INCBIN "data/bank_06a/d_49c0.bin" ; $49c0, 256 bytes
WalkSprite_6a_01_Gfx04:
	INCBIN "data/bank_06a/d_4ac0.bin" ; $4ac0, 256 bytes
WalkSprite_6a_01_Gfx05:
	INCBIN "data/bank_06a/d_4bc0.bin" ; $4bc0, 256 bytes
OamPtrs_6a_4cc0:
	dw WalkSprite_6a_01_Oam00 ; $4cc0
	dw WalkSprite_6a_01_Oam01 ; $4cc2
	dw WalkSprite_6a_01_Oam02 ; $4cc4
	dw WalkSprite_6a_01_Oam03 ; $4cc6
	dw WalkSprite_6a_01_Oam04 ; $4cc8
	dw WalkSprite_6a_01_Oam05 ; $4cca
	dw WalkSprite_6a_01_Oam05 ; $4ccc
	dw WalkSprite_6a_01_Oam06 ; $4cce
	dw WalkSprite_6a_01_Oam07 ; $4cd0
	dw WalkSprite_6a_01_Oam08 ; $4cd2
	dw WalkSprite_6a_01_Oam09 ; $4cd4
	dw WalkSprite_6a_01_Oam10 ; $4cd6
WalkSprite_6a_01_Oam00:
	INCBIN "data/bank_06a/d_4cd8.bin" ; $4cd8, 3 bytes
WalkSprite_6a_01_Oam01:
	INCBIN "data/bank_06a/d_4cdb.bin" ; $4cdb, 6 bytes
WalkSprite_6a_01_Oam02:
	INCBIN "data/bank_06a/d_4ce1.bin" ; $4ce1, 12 bytes
WalkSprite_6a_01_Oam03:
	INCBIN "data/bank_06a/d_4ced.bin" ; $4ced, 8 bytes
WalkSprite_6a_01_Oam04:
	INCBIN "data/bank_06a/d_4cf5.bin" ; $4cf5, 20 bytes
WalkSprite_6a_01_Oam05:
	INCBIN "data/bank_06a/d_4d09.bin" ; $4d09, 5 bytes
WalkSprite_6a_01_Oam06:
	INCBIN "data/bank_06a/d_4d0e.bin" ; $4d0e, 12 bytes
WalkSprite_6a_01_Oam07:
	INCBIN "data/bank_06a/d_4d1a.bin" ; $4d1a, 6 bytes
WalkSprite_6a_01_Oam08:
	INCBIN "data/bank_06a/d_4d20.bin" ; $4d20, 3 bytes
WalkSprite_6a_01_Oam09:
	INCBIN "data/bank_06a/d_4d23.bin" ; $4d23, 3 bytes
WalkSprite_6a_01_Oam10:
	INCBIN "data/bank_06a/d_4d26.bin" ; $4d26, 11 bytes
WalkSprite_6a_02:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6a_5350, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6a_02_Gfx00, WalkSprite_6a_02_Gfx01, WalkSprite_6a_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6a_02_Gfx02 ; $4d41
	dw WalkSprite_6a_02_Gfx02 ; $4d43
	dw WalkSprite_6a_02_Gfx02 ; $4d45
	dw WalkSprite_6a_02_Gfx02 ; $4d47
	dw WalkSprite_6a_02_Gfx03 ; $4d49
	dw WalkSprite_6a_02_Gfx04 ; $4d4b
	dw WalkSprite_6a_02_Gfx05 ; $4d4d
	db $00 ; $4d4f
WalkSprite_6a_02_Gfx00:
	INCBIN "data/bank_06a/d_4d50.bin" ; $4d50, 256 bytes
WalkSprite_6a_02_Gfx01:
	INCBIN "data/bank_06a/d_4e50.bin" ; $4e50, 256 bytes
WalkSprite_6a_02_Gfx02:
	INCBIN "data/bank_06a/d_4f50.bin" ; $4f50, 256 bytes
WalkSprite_6a_02_Gfx03:
	INCBIN "data/bank_06a/d_5050.bin" ; $5050, 256 bytes
WalkSprite_6a_02_Gfx04:
	INCBIN "data/bank_06a/d_5150.bin" ; $5150, 256 bytes
WalkSprite_6a_02_Gfx05:
	INCBIN "data/bank_06a/d_5250.bin" ; $5250, 256 bytes
OamPtrs_6a_5350:
	dw WalkSprite_6a_02_Oam00 ; $5350
	dw WalkSprite_6a_02_Oam01 ; $5352
	dw WalkSprite_6a_02_Oam02 ; $5354
	dw WalkSprite_6a_02_Oam03 ; $5356
	dw WalkSprite_6a_02_Oam04 ; $5358
	dw WalkSprite_6a_02_Oam05 ; $535a
	dw WalkSprite_6a_02_Oam05 ; $535c
	dw WalkSprite_6a_02_Oam06 ; $535e
	dw WalkSprite_6a_02_Oam07 ; $5360
	dw WalkSprite_6a_02_Oam08 ; $5362
	dw WalkSprite_6a_02_Oam09 ; $5364
	dw WalkSprite_6a_02_Oam10 ; $5366
WalkSprite_6a_02_Oam00:
	INCBIN "data/bank_06a/d_5368.bin" ; $5368, 3 bytes
WalkSprite_6a_02_Oam01:
	INCBIN "data/bank_06a/d_536b.bin" ; $536b, 6 bytes
WalkSprite_6a_02_Oam02:
	INCBIN "data/bank_06a/d_5371.bin" ; $5371, 12 bytes
WalkSprite_6a_02_Oam03:
	INCBIN "data/bank_06a/d_537d.bin" ; $537d, 8 bytes
WalkSprite_6a_02_Oam04:
	INCBIN "data/bank_06a/d_5385.bin" ; $5385, 20 bytes
WalkSprite_6a_02_Oam05:
	INCBIN "data/bank_06a/d_5399.bin" ; $5399, 5 bytes
WalkSprite_6a_02_Oam06:
	INCBIN "data/bank_06a/d_539e.bin" ; $539e, 12 bytes
WalkSprite_6a_02_Oam07:
	INCBIN "data/bank_06a/d_53aa.bin" ; $53aa, 6 bytes
WalkSprite_6a_02_Oam08:
	INCBIN "data/bank_06a/d_53b0.bin" ; $53b0, 3 bytes
WalkSprite_6a_02_Oam09:
	INCBIN "data/bank_06a/d_53b3.bin" ; $53b3, 3 bytes
WalkSprite_6a_02_Oam10:
	INCBIN "data/bank_06a/d_53b6.bin" ; $53b6, 11 bytes
WalkSprite_6a_03:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6a_59e0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6a_03_Gfx00, WalkSprite_6a_03_Gfx01, WalkSprite_6a_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6a_03_Gfx02 ; $53d1
	dw WalkSprite_6a_03_Gfx02 ; $53d3
	dw WalkSprite_6a_03_Gfx02 ; $53d5
	dw WalkSprite_6a_03_Gfx02 ; $53d7
	dw WalkSprite_6a_03_Gfx03 ; $53d9
	dw WalkSprite_6a_03_Gfx04 ; $53db
	dw WalkSprite_6a_03_Gfx05 ; $53dd
	db $00 ; $53df
WalkSprite_6a_03_Gfx00:
	INCBIN "data/bank_06a/d_53e0.bin" ; $53e0, 256 bytes
WalkSprite_6a_03_Gfx01:
	INCBIN "data/bank_06a/d_54e0.bin" ; $54e0, 256 bytes
WalkSprite_6a_03_Gfx02:
	INCBIN "data/bank_06a/d_55e0.bin" ; $55e0, 256 bytes
WalkSprite_6a_03_Gfx03:
	INCBIN "data/bank_06a/d_56e0.bin" ; $56e0, 256 bytes
WalkSprite_6a_03_Gfx04:
	INCBIN "data/bank_06a/d_57e0.bin" ; $57e0, 256 bytes
WalkSprite_6a_03_Gfx05:
	INCBIN "data/bank_06a/d_58e0.bin" ; $58e0, 256 bytes
OamPtrs_6a_59e0:
	dw WalkSprite_6a_03_Oam00 ; $59e0
	dw WalkSprite_6a_03_Oam01 ; $59e2
	dw WalkSprite_6a_03_Oam02 ; $59e4
	dw WalkSprite_6a_03_Oam03 ; $59e6
	dw WalkSprite_6a_03_Oam04 ; $59e8
	dw WalkSprite_6a_03_Oam05 ; $59ea
	dw WalkSprite_6a_03_Oam05 ; $59ec
	dw WalkSprite_6a_03_Oam06 ; $59ee
	dw WalkSprite_6a_03_Oam07 ; $59f0
	dw WalkSprite_6a_03_Oam08 ; $59f2
	dw WalkSprite_6a_03_Oam09 ; $59f4
	dw WalkSprite_6a_03_Oam10 ; $59f6
WalkSprite_6a_03_Oam00:
	INCBIN "data/bank_06a/d_59f8.bin" ; $59f8, 3 bytes
WalkSprite_6a_03_Oam01:
	INCBIN "data/bank_06a/d_59fb.bin" ; $59fb, 6 bytes
WalkSprite_6a_03_Oam02:
	INCBIN "data/bank_06a/d_5a01.bin" ; $5a01, 12 bytes
WalkSprite_6a_03_Oam03:
	INCBIN "data/bank_06a/d_5a0d.bin" ; $5a0d, 8 bytes
WalkSprite_6a_03_Oam04:
	INCBIN "data/bank_06a/d_5a15.bin" ; $5a15, 20 bytes
WalkSprite_6a_03_Oam05:
	INCBIN "data/bank_06a/d_5a29.bin" ; $5a29, 5 bytes
WalkSprite_6a_03_Oam06:
	INCBIN "data/bank_06a/d_5a2e.bin" ; $5a2e, 12 bytes
WalkSprite_6a_03_Oam07:
	INCBIN "data/bank_06a/d_5a3a.bin" ; $5a3a, 6 bytes
WalkSprite_6a_03_Oam08:
	INCBIN "data/bank_06a/d_5a40.bin" ; $5a40, 3 bytes
WalkSprite_6a_03_Oam09:
	INCBIN "data/bank_06a/d_5a43.bin" ; $5a43, 3 bytes
WalkSprite_6a_03_Oam10:
	INCBIN "data/bank_06a/d_5a46.bin" ; $5a46, 11 bytes
WalkSprite_6a_04:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6a_6070, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_6a_04_Gfx00, WalkSprite_6a_04_Gfx01, WalkSprite_6a_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6a_04_Gfx02 ; $5a61
	dw WalkSprite_6a_04_Gfx02 ; $5a63
	dw WalkSprite_6a_04_Gfx02 ; $5a65
	dw WalkSprite_6a_04_Gfx02 ; $5a67
	dw WalkSprite_6a_04_Gfx03 ; $5a69
	dw WalkSprite_6a_04_Gfx04 ; $5a6b
	dw WalkSprite_6a_04_Gfx05 ; $5a6d
	db $00 ; $5a6f
WalkSprite_6a_04_Gfx00:
	INCBIN "data/bank_06a/d_5a70.bin" ; $5a70, 256 bytes
WalkSprite_6a_04_Gfx01:
	INCBIN "data/bank_06a/d_5b70.bin" ; $5b70, 256 bytes
WalkSprite_6a_04_Gfx02:
	INCBIN "data/bank_06a/d_5c70.bin" ; $5c70, 256 bytes
WalkSprite_6a_04_Gfx03:
	INCBIN "data/bank_06a/d_5d70.bin" ; $5d70, 256 bytes
WalkSprite_6a_04_Gfx04:
	INCBIN "data/bank_06a/d_5e70.bin" ; $5e70, 256 bytes
WalkSprite_6a_04_Gfx05:
	INCBIN "data/bank_06a/d_5f70.bin" ; $5f70, 256 bytes
OamPtrs_6a_6070:
	dw WalkSprite_6a_04_Oam00 ; $6070
	dw WalkSprite_6a_04_Oam01 ; $6072
	dw WalkSprite_6a_04_Oam02 ; $6074
	dw WalkSprite_6a_04_Oam03 ; $6076
	dw WalkSprite_6a_04_Oam04 ; $6078
	dw WalkSprite_6a_04_Oam05 ; $607a
	dw WalkSprite_6a_04_Oam05 ; $607c
	dw WalkSprite_6a_04_Oam06 ; $607e
	dw WalkSprite_6a_04_Oam07 ; $6080
	dw WalkSprite_6a_04_Oam08 ; $6082
	dw WalkSprite_6a_04_Oam09 ; $6084
	dw WalkSprite_6a_04_Oam10 ; $6086
WalkSprite_6a_04_Oam00:
	INCBIN "data/bank_06a/d_6088.bin" ; $6088, 3 bytes
WalkSprite_6a_04_Oam01:
	INCBIN "data/bank_06a/d_608b.bin" ; $608b, 6 bytes
WalkSprite_6a_04_Oam02:
	INCBIN "data/bank_06a/d_6091.bin" ; $6091, 12 bytes
WalkSprite_6a_04_Oam03:
	INCBIN "data/bank_06a/d_609d.bin" ; $609d, 8 bytes
WalkSprite_6a_04_Oam04:
	INCBIN "data/bank_06a/d_60a5.bin" ; $60a5, 20 bytes
WalkSprite_6a_04_Oam05:
	INCBIN "data/bank_06a/d_60b9.bin" ; $60b9, 5 bytes
WalkSprite_6a_04_Oam06:
	INCBIN "data/bank_06a/d_60be.bin" ; $60be, 12 bytes
WalkSprite_6a_04_Oam07:
	INCBIN "data/bank_06a/d_60ca.bin" ; $60ca, 6 bytes
WalkSprite_6a_04_Oam08:
	INCBIN "data/bank_06a/d_60d0.bin" ; $60d0, 3 bytes
WalkSprite_6a_04_Oam09:
	INCBIN "data/bank_06a/d_60d3.bin" ; $60d3, 3 bytes
WalkSprite_6a_04_Oam10:
	INCBIN "data/bank_06a/d_60d6.bin" ; $60d6, 11 bytes
	; $60e1, 7967 bytes fill to bank end (linker-padded)

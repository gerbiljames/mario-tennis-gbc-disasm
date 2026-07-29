SECTION "ROM Bank $77", ROMX[$4000], BANK[$77]

WalkSprites_77:
	dw WalkSprite_77_00 ; $4000
	dw WalkSprite_77_01 ; $4002
	dw WalkSprite_77_02 ; $4004
	dw WalkSprite_77_03 ; $4006
	dw WalkSprite_77_04 ; $4008
	dw WalkSprite_77_05 ; $400a
	dw WalkSprite_77_06 ; $400c
	dw WalkSprite_77_07 ; $400e
WalkSprite_77_00:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_77_00_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_77_00_Gfx00, WalkSprite_77_00_Gfx01, WalkSprite_77_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_00_Gfx02 ; $4020
	dw WalkSprite_77_00_Gfx02 ; $4022
	dw WalkSprite_77_00_Gfx02 ; $4024
	dw WalkSprite_77_00_Gfx02 ; $4026
	dw WalkSprite_77_00_Gfx03 ; $4028
	dw WalkSprite_77_00_Gfx04 ; $402a
	dw WalkSprite_77_00_Gfx05 ; $402c
	dw WalkSprite_77_00_Gfx06 ; $402e
	dw WalkSprite_77_00_Gfx06 ; $4030
	dw WalkSprite_77_00_Gfx07 ; $4032
Padding_77_0:
	; $4034, 12 bytes (fill)
	ds 12, $00
WalkSprite_77_00_Gfx00:
	INCBIN "data/bank_077/d_4040.bin" ; $4040, 256 bytes
WalkSprite_77_00_Gfx01:
	INCBIN "data/bank_077/d_4140.bin" ; $4140, 256 bytes
WalkSprite_77_00_Gfx02:
	INCBIN "data/bank_077/d_4240.bin" ; $4240, 256 bytes
WalkSprite_77_00_Gfx03:
	INCBIN "data/bank_077/d_4340.bin" ; $4340, 256 bytes
WalkSprite_77_00_Gfx04:
	INCBIN "data/bank_077/d_4440.bin" ; $4440, 256 bytes
WalkSprite_77_00_Gfx05:
	INCBIN "data/bank_077/d_4540.bin" ; $4540, 256 bytes
WalkSprite_77_00_Gfx06:
	INCBIN "data/bank_077/d_4640.bin" ; $4640, 256 bytes
WalkSprite_77_00_Gfx07:
	INCBIN "data/bank_077/d_4740.bin" ; $4740, 256 bytes
WalkSprite_77_00_OamPtrs:
	dw WalkSprite_77_00_Oam00 ; $4840
	dw WalkSprite_77_00_Oam01 ; $4842
	dw WalkSprite_77_00_Oam02 ; $4844
	dw WalkSprite_77_00_Oam03 ; $4846
	dw WalkSprite_77_00_Oam04 ; $4848
	dw WalkSprite_77_00_Oam05 ; $484a
	dw WalkSprite_77_00_Oam05 ; $484c
	dw WalkSprite_77_00_Oam05 ; $484e
	dw WalkSprite_77_00_Oam06 ; $4850
WalkSprite_77_00_Oam00:
	INCBIN "data/bank_077/d_4852.bin" ; $4852, 3 bytes
WalkSprite_77_00_Oam01:
	INCBIN "data/bank_077/d_4855.bin" ; $4855, 6 bytes
WalkSprite_77_00_Oam02:
	INCBIN "data/bank_077/d_485b.bin" ; $485b, 12 bytes
WalkSprite_77_00_Oam03:
	INCBIN "data/bank_077/d_4867.bin" ; $4867, 8 bytes
WalkSprite_77_00_Oam04:
	INCBIN "data/bank_077/d_486f.bin" ; $486f, 20 bytes
WalkSprite_77_00_Oam05:
	INCBIN "data/bank_077/d_4883.bin" ; $4883, 12 bytes
WalkSprite_77_00_Oam06:
	INCBIN "data/bank_077/d_488f.bin" ; $488f, 6 bytes
WalkSprite_77_01:
	db $04, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_77_01_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_77_01_Gfx00, WalkSprite_77_01_Gfx01, WalkSprite_77_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_01_Gfx02 ; $48a5
	dw WalkSprite_77_01_Gfx02 ; $48a7
	dw WalkSprite_77_01_Gfx02 ; $48a9
	dw WalkSprite_77_01_Gfx02 ; $48ab
	dw WalkSprite_77_01_Gfx03 ; $48ad
	dw WalkSprite_77_01_Gfx04 ; $48af
	dw WalkSprite_77_01_Gfx05 ; $48b1
	dw WalkSprite_77_01_Gfx06 ; $48b3
	dw WalkSprite_77_01_Gfx06 ; $48b5
	dw WalkSprite_77_01_Gfx07 ; $48b7
Padding_77_1:
	; $48b9, 7 bytes (fill)
	ds 7, $00
WalkSprite_77_01_Gfx00:
	INCBIN "data/bank_077/d_48c0.bin" ; $48c0, 256 bytes
WalkSprite_77_01_Gfx01:
	INCBIN "data/bank_077/d_49c0.bin" ; $49c0, 256 bytes
WalkSprite_77_01_Gfx02:
	INCBIN "data/bank_077/d_4ac0.bin" ; $4ac0, 256 bytes
WalkSprite_77_01_Gfx03:
	INCBIN "data/bank_077/d_4bc0.bin" ; $4bc0, 256 bytes
WalkSprite_77_01_Gfx04:
	INCBIN "data/bank_077/d_4cc0.bin" ; $4cc0, 256 bytes
WalkSprite_77_01_Gfx05:
	INCBIN "data/bank_077/d_4dc0.bin" ; $4dc0, 256 bytes
WalkSprite_77_01_Gfx06:
	INCBIN "data/bank_077/d_4ec0.bin" ; $4ec0, 256 bytes
WalkSprite_77_01_Gfx07:
	INCBIN "data/bank_077/d_4fc0.bin" ; $4fc0, 256 bytes
WalkSprite_77_01_OamPtrs:
	dw WalkSprite_77_01_Oam00 ; $50c0
	dw WalkSprite_77_01_Oam01 ; $50c2
	dw WalkSprite_77_01_Oam02 ; $50c4
	dw WalkSprite_77_01_Oam03 ; $50c6
	dw WalkSprite_77_01_Oam04 ; $50c8
	dw WalkSprite_77_01_Oam05 ; $50ca
	dw WalkSprite_77_01_Oam05 ; $50cc
	dw WalkSprite_77_01_Oam05 ; $50ce
	dw WalkSprite_77_01_Oam06 ; $50d0
WalkSprite_77_01_Oam00:
	INCBIN "data/bank_077/d_50d2.bin" ; $50d2, 3 bytes
WalkSprite_77_01_Oam01:
	INCBIN "data/bank_077/d_50d5.bin" ; $50d5, 6 bytes
WalkSprite_77_01_Oam02:
	INCBIN "data/bank_077/d_50db.bin" ; $50db, 12 bytes
WalkSprite_77_01_Oam03:
	INCBIN "data/bank_077/d_50e7.bin" ; $50e7, 8 bytes
WalkSprite_77_01_Oam04:
	INCBIN "data/bank_077/d_50ef.bin" ; $50ef, 20 bytes
WalkSprite_77_01_Oam05:
	INCBIN "data/bank_077/d_5103.bin" ; $5103, 12 bytes
WalkSprite_77_01_Oam06:
	INCBIN "data/bank_077/d_510f.bin" ; $510f, 6 bytes
WalkSprite_77_02:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_77_02_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_77_02_Gfx00, WalkSprite_77_02_Gfx01, WalkSprite_77_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_02_Gfx02 ; $5125
	dw WalkSprite_77_02_Gfx02 ; $5127
	dw WalkSprite_77_02_Gfx02 ; $5129
	dw WalkSprite_77_02_Gfx02 ; $512b
	dw WalkSprite_77_02_Gfx03 ; $512d
	dw WalkSprite_77_02_Gfx04 ; $512f
	dw WalkSprite_77_02_Gfx05 ; $5131
	dw WalkSprite_77_02_Gfx06 ; $5133
	dw WalkSprite_77_02_Gfx06 ; $5135
	dw WalkSprite_77_02_Gfx07 ; $5137
Padding_77_2:
	; $5139, 7 bytes (fill)
	ds 7, $00
WalkSprite_77_02_Gfx00:
	INCBIN "data/bank_077/d_5140.bin" ; $5140, 256 bytes
WalkSprite_77_02_Gfx01:
	INCBIN "data/bank_077/d_5240.bin" ; $5240, 256 bytes
WalkSprite_77_02_Gfx02:
	INCBIN "data/bank_077/d_5340.bin" ; $5340, 256 bytes
WalkSprite_77_02_Gfx03:
	INCBIN "data/bank_077/d_5440.bin" ; $5440, 256 bytes
WalkSprite_77_02_Gfx04:
	INCBIN "data/bank_077/d_5540.bin" ; $5540, 256 bytes
WalkSprite_77_02_Gfx05:
	INCBIN "data/bank_077/d_5640.bin" ; $5640, 256 bytes
WalkSprite_77_02_Gfx06:
	INCBIN "data/bank_077/d_5740.bin" ; $5740, 256 bytes
WalkSprite_77_02_Gfx07:
	INCBIN "data/bank_077/d_5840.bin" ; $5840, 256 bytes
WalkSprite_77_02_OamPtrs:
	dw WalkSprite_77_02_Oam00 ; $5940
	dw WalkSprite_77_02_Oam01 ; $5942
	dw WalkSprite_77_02_Oam02 ; $5944
	dw WalkSprite_77_02_Oam03 ; $5946
	dw WalkSprite_77_02_Oam04 ; $5948
	dw WalkSprite_77_02_Oam05 ; $594a
	dw WalkSprite_77_02_Oam05 ; $594c
	dw WalkSprite_77_02_Oam05 ; $594e
	dw WalkSprite_77_02_Oam06 ; $5950
WalkSprite_77_02_Oam00:
	INCBIN "data/bank_077/d_5952.bin" ; $5952, 3 bytes
WalkSprite_77_02_Oam01:
	INCBIN "data/bank_077/d_5955.bin" ; $5955, 6 bytes
WalkSprite_77_02_Oam02:
	INCBIN "data/bank_077/d_595b.bin" ; $595b, 12 bytes
WalkSprite_77_02_Oam03:
	INCBIN "data/bank_077/d_5967.bin" ; $5967, 8 bytes
WalkSprite_77_02_Oam04:
	INCBIN "data/bank_077/d_596f.bin" ; $596f, 20 bytes
WalkSprite_77_02_Oam05:
	INCBIN "data/bank_077/d_5983.bin" ; $5983, 12 bytes
WalkSprite_77_02_Oam06:
	INCBIN "data/bank_077/d_598f.bin" ; $598f, 6 bytes
WalkSprite_77_03:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_77_03_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_77_03_Gfx00, WalkSprite_77_03_Gfx01, WalkSprite_77_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_03_Gfx02 ; $59a5
	dw WalkSprite_77_03_Gfx02 ; $59a7
	dw WalkSprite_77_03_Gfx02 ; $59a9
	dw WalkSprite_77_03_Gfx02 ; $59ab
	dw WalkSprite_77_03_Gfx03 ; $59ad
	dw WalkSprite_77_03_Gfx04 ; $59af
	dw WalkSprite_77_03_Gfx05 ; $59b1
Padding_77_3:
	; $59b3, 13 bytes (fill)
	ds 13, $00
WalkSprite_77_03_Gfx00:
	INCBIN "data/bank_077/d_59c0.bin" ; $59c0, 256 bytes
WalkSprite_77_03_Gfx01:
	INCBIN "data/bank_077/d_5ac0.bin" ; $5ac0, 256 bytes
WalkSprite_77_03_Gfx02:
	INCBIN "data/bank_077/d_5bc0.bin" ; $5bc0, 256 bytes
WalkSprite_77_03_Gfx03:
	INCBIN "data/bank_077/d_5cc0.bin" ; $5cc0, 256 bytes
WalkSprite_77_03_Gfx04:
	INCBIN "data/bank_077/d_5dc0.bin" ; $5dc0, 256 bytes
WalkSprite_77_03_Gfx05:
	INCBIN "data/bank_077/d_5ec0.bin" ; $5ec0, 256 bytes
WalkSprite_77_03_OamPtrs:
	dw WalkSprite_77_03_Oam00 ; $5fc0
	dw WalkSprite_77_03_Oam01 ; $5fc2
	dw WalkSprite_77_03_Oam02 ; $5fc4
	dw WalkSprite_77_03_Oam03 ; $5fc6
	dw WalkSprite_77_03_Oam04 ; $5fc8
	dw WalkSprite_77_03_Oam05 ; $5fca
	dw WalkSprite_77_03_Oam05 ; $5fcc
	dw WalkSprite_77_03_Oam06 ; $5fce
	dw WalkSprite_77_03_Oam07 ; $5fd0
	dw WalkSprite_77_03_Oam08 ; $5fd2
	dw WalkSprite_77_03_Oam09 ; $5fd4
	dw WalkSprite_77_03_Oam10 ; $5fd6
WalkSprite_77_03_Oam00:
	INCBIN "data/bank_077/d_5fd8.bin" ; $5fd8, 3 bytes
WalkSprite_77_03_Oam01:
	INCBIN "data/bank_077/d_5fdb.bin" ; $5fdb, 6 bytes
WalkSprite_77_03_Oam02:
	INCBIN "data/bank_077/d_5fe1.bin" ; $5fe1, 12 bytes
WalkSprite_77_03_Oam03:
	INCBIN "data/bank_077/d_5fed.bin" ; $5fed, 8 bytes
WalkSprite_77_03_Oam04:
	INCBIN "data/bank_077/d_5ff5.bin" ; $5ff5, 20 bytes
WalkSprite_77_03_Oam05:
	INCBIN "data/bank_077/d_6009.bin" ; $6009, 5 bytes
WalkSprite_77_03_Oam06:
	INCBIN "data/bank_077/d_600e.bin" ; $600e, 12 bytes
WalkSprite_77_03_Oam07:
	INCBIN "data/bank_077/d_601a.bin" ; $601a, 6 bytes
WalkSprite_77_03_Oam08:
	INCBIN "data/bank_077/d_6020.bin" ; $6020, 3 bytes
WalkSprite_77_03_Oam09:
	INCBIN "data/bank_077/d_6023.bin" ; $6023, 3 bytes
WalkSprite_77_03_Oam10:
	INCBIN "data/bank_077/d_6026.bin" ; $6026, 11 bytes
WalkSprite_77_04:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_77_04_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_77_04_Gfx00, WalkSprite_77_04_Gfx01, WalkSprite_77_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_04_Gfx02 ; $6041
	dw WalkSprite_77_04_Gfx02 ; $6043
	dw WalkSprite_77_04_Gfx02 ; $6045
	dw WalkSprite_77_04_Gfx02 ; $6047
	dw WalkSprite_77_04_Gfx03 ; $6049
	dw WalkSprite_77_04_Gfx04 ; $604b
	dw WalkSprite_77_04_Gfx05 ; $604d
	db $00 ; $604f
WalkSprite_77_04_Gfx00:
	INCBIN "data/bank_077/d_6050.bin" ; $6050, 256 bytes
WalkSprite_77_04_Gfx01:
	INCBIN "data/bank_077/d_6150.bin" ; $6150, 256 bytes
WalkSprite_77_04_Gfx02:
	INCBIN "data/bank_077/d_6250.bin" ; $6250, 256 bytes
WalkSprite_77_04_Gfx03:
	INCBIN "data/bank_077/d_6350.bin" ; $6350, 256 bytes
WalkSprite_77_04_Gfx04:
	INCBIN "data/bank_077/d_6450.bin" ; $6450, 256 bytes
WalkSprite_77_04_Gfx05:
	INCBIN "data/bank_077/d_6550.bin" ; $6550, 256 bytes
WalkSprite_77_04_OamPtrs:
	dw WalkSprite_77_04_Oam00 ; $6650
	dw WalkSprite_77_04_Oam01 ; $6652
	dw WalkSprite_77_04_Oam02 ; $6654
	dw WalkSprite_77_04_Oam03 ; $6656
	dw WalkSprite_77_04_Oam04 ; $6658
	dw WalkSprite_77_04_Oam05 ; $665a
	dw WalkSprite_77_04_Oam05 ; $665c
	dw WalkSprite_77_04_Oam06 ; $665e
	dw WalkSprite_77_04_Oam07 ; $6660
	dw WalkSprite_77_04_Oam08 ; $6662
	dw WalkSprite_77_04_Oam09 ; $6664
	dw WalkSprite_77_04_Oam10 ; $6666
WalkSprite_77_04_Oam00:
	INCBIN "data/bank_077/d_6668.bin" ; $6668, 3 bytes
WalkSprite_77_04_Oam01:
	INCBIN "data/bank_077/d_666b.bin" ; $666b, 6 bytes
WalkSprite_77_04_Oam02:
	INCBIN "data/bank_077/d_6671.bin" ; $6671, 12 bytes
WalkSprite_77_04_Oam03:
	INCBIN "data/bank_077/d_667d.bin" ; $667d, 8 bytes
WalkSprite_77_04_Oam04:
	INCBIN "data/bank_077/d_6685.bin" ; $6685, 20 bytes
WalkSprite_77_04_Oam05:
	INCBIN "data/bank_077/d_6699.bin" ; $6699, 5 bytes
WalkSprite_77_04_Oam06:
	INCBIN "data/bank_077/d_669e.bin" ; $669e, 12 bytes
WalkSprite_77_04_Oam07:
	INCBIN "data/bank_077/d_66aa.bin" ; $66aa, 6 bytes
WalkSprite_77_04_Oam08:
	INCBIN "data/bank_077/d_66b0.bin" ; $66b0, 3 bytes
WalkSprite_77_04_Oam09:
	INCBIN "data/bank_077/d_66b3.bin" ; $66b3, 3 bytes
WalkSprite_77_04_Oam10:
	INCBIN "data/bank_077/d_66b6.bin" ; $66b6, 11 bytes
WalkSprite_77_05:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_77_05_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_77_05_Gfx00, WalkSprite_77_05_Gfx01, WalkSprite_77_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_05_Gfx02 ; $66d1
	dw WalkSprite_77_05_Gfx02 ; $66d3
	dw WalkSprite_77_05_Gfx02 ; $66d5
	dw WalkSprite_77_05_Gfx02 ; $66d7
	dw WalkSprite_77_05_Gfx03 ; $66d9
	dw WalkSprite_77_05_Gfx04 ; $66db
	dw WalkSprite_77_05_Gfx05 ; $66dd
	db $00 ; $66df
WalkSprite_77_05_Gfx00:
	INCBIN "data/bank_077/d_66e0.bin" ; $66e0, 256 bytes
WalkSprite_77_05_Gfx01:
	INCBIN "data/bank_077/d_67e0.bin" ; $67e0, 256 bytes
WalkSprite_77_05_Gfx02:
	INCBIN "data/bank_077/d_68e0.bin" ; $68e0, 256 bytes
WalkSprite_77_05_Gfx03:
	INCBIN "data/bank_077/d_69e0.bin" ; $69e0, 256 bytes
WalkSprite_77_05_Gfx04:
	INCBIN "data/bank_077/d_6ae0.bin" ; $6ae0, 256 bytes
WalkSprite_77_05_Gfx05:
	INCBIN "data/bank_077/d_6be0.bin" ; $6be0, 256 bytes
WalkSprite_77_05_OamPtrs:
	dw WalkSprite_77_05_Oam00 ; $6ce0
	dw WalkSprite_77_05_Oam01 ; $6ce2
	dw WalkSprite_77_05_Oam02 ; $6ce4
	dw WalkSprite_77_05_Oam03 ; $6ce6
	dw WalkSprite_77_05_Oam04 ; $6ce8
	dw WalkSprite_77_05_Oam05 ; $6cea
	dw WalkSprite_77_05_Oam05 ; $6cec
	dw WalkSprite_77_05_Oam06 ; $6cee
	dw WalkSprite_77_05_Oam07 ; $6cf0
	dw WalkSprite_77_05_Oam08 ; $6cf2
	dw WalkSprite_77_05_Oam09 ; $6cf4
	dw WalkSprite_77_05_Oam10 ; $6cf6
WalkSprite_77_05_Oam00:
	INCBIN "data/bank_077/d_6cf8.bin" ; $6cf8, 3 bytes
WalkSprite_77_05_Oam01:
	INCBIN "data/bank_077/d_6cfb.bin" ; $6cfb, 6 bytes
WalkSprite_77_05_Oam02:
	INCBIN "data/bank_077/d_6d01.bin" ; $6d01, 12 bytes
WalkSprite_77_05_Oam03:
	INCBIN "data/bank_077/d_6d0d.bin" ; $6d0d, 8 bytes
WalkSprite_77_05_Oam04:
	INCBIN "data/bank_077/d_6d15.bin" ; $6d15, 20 bytes
WalkSprite_77_05_Oam05:
	INCBIN "data/bank_077/d_6d29.bin" ; $6d29, 5 bytes
WalkSprite_77_05_Oam06:
	INCBIN "data/bank_077/d_6d2e.bin" ; $6d2e, 12 bytes
WalkSprite_77_05_Oam07:
	INCBIN "data/bank_077/d_6d3a.bin" ; $6d3a, 6 bytes
WalkSprite_77_05_Oam08:
	INCBIN "data/bank_077/d_6d40.bin" ; $6d40, 3 bytes
WalkSprite_77_05_Oam09:
	INCBIN "data/bank_077/d_6d43.bin" ; $6d43, 3 bytes
WalkSprite_77_05_Oam10:
	INCBIN "data/bank_077/d_6d46.bin" ; $6d46, 11 bytes
WalkSprite_77_06:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, WalkSprite_77_06_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_77_06_Gfx00, WalkSprite_77_06_Gfx01, WalkSprite_77_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_06_Gfx02 ; $6d61
	dw WalkSprite_77_06_Gfx02 ; $6d63
	dw WalkSprite_77_06_Gfx02 ; $6d65
	dw WalkSprite_77_06_Gfx02 ; $6d67
	dw WalkSprite_77_06_Gfx03 ; $6d69
	dw WalkSprite_77_06_Gfx04 ; $6d6b
	dw WalkSprite_77_06_Gfx05 ; $6d6d
	db $00 ; $6d6f
WalkSprite_77_06_Gfx00:
	INCBIN "data/bank_077/d_6d70.bin" ; $6d70, 256 bytes
WalkSprite_77_06_Gfx01:
	INCBIN "data/bank_077/d_6e70.bin" ; $6e70, 256 bytes
WalkSprite_77_06_Gfx02:
	INCBIN "data/bank_077/d_6f70.bin" ; $6f70, 256 bytes
WalkSprite_77_06_Gfx03:
	INCBIN "data/bank_077/d_7070.bin" ; $7070, 256 bytes
WalkSprite_77_06_Gfx04:
	INCBIN "data/bank_077/d_7170.bin" ; $7170, 256 bytes
WalkSprite_77_06_Gfx05:
	INCBIN "data/bank_077/d_7270.bin" ; $7270, 256 bytes
WalkSprite_77_06_OamPtrs:
	dw WalkSprite_77_06_Oam00 ; $7370
	dw WalkSprite_77_06_Oam01 ; $7372
	dw WalkSprite_77_06_Oam02 ; $7374
	dw WalkSprite_77_06_Oam03 ; $7376
	dw WalkSprite_77_06_Oam04 ; $7378
	dw WalkSprite_77_06_Oam05 ; $737a
	dw WalkSprite_77_06_Oam05 ; $737c
	dw WalkSprite_77_06_Oam06 ; $737e
	dw WalkSprite_77_06_Oam07 ; $7380
	dw WalkSprite_77_06_Oam08 ; $7382
	dw WalkSprite_77_06_Oam09 ; $7384
	dw WalkSprite_77_06_Oam10 ; $7386
WalkSprite_77_06_Oam00:
	INCBIN "data/bank_077/d_7388.bin" ; $7388, 3 bytes
WalkSprite_77_06_Oam01:
	INCBIN "data/bank_077/d_738b.bin" ; $738b, 6 bytes
WalkSprite_77_06_Oam02:
	INCBIN "data/bank_077/d_7391.bin" ; $7391, 12 bytes
WalkSprite_77_06_Oam03:
	INCBIN "data/bank_077/d_739d.bin" ; $739d, 8 bytes
WalkSprite_77_06_Oam04:
	INCBIN "data/bank_077/d_73a5.bin" ; $73a5, 20 bytes
WalkSprite_77_06_Oam05:
	INCBIN "data/bank_077/d_73b9.bin" ; $73b9, 5 bytes
WalkSprite_77_06_Oam06:
	INCBIN "data/bank_077/d_73be.bin" ; $73be, 12 bytes
WalkSprite_77_06_Oam07:
	INCBIN "data/bank_077/d_73ca.bin" ; $73ca, 6 bytes
WalkSprite_77_06_Oam08:
	INCBIN "data/bank_077/d_73d0.bin" ; $73d0, 3 bytes
WalkSprite_77_06_Oam09:
	INCBIN "data/bank_077/d_73d3.bin" ; $73d3, 3 bytes
WalkSprite_77_06_Oam10:
	INCBIN "data/bank_077/d_73d6.bin" ; $73d6, 11 bytes
WalkSprite_77_07:
	db $05, $01, $02, $00 ; count, flags
	dw .frames, WalkSprite_77_07_OamPtrs, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_77_07_Gfx00, WalkSprite_77_07_Gfx01, WalkSprite_77_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_07_Gfx03 ; $73f1
	dw WalkSprite_77_07_Gfx04 ; $73f3
	dw WalkSprite_77_07_Gfx04 ; $73f5
	dw WalkSprite_77_07_Gfx04 ; $73f7
	dw WalkSprite_77_07_Gfx04 ; $73f9
	dw WalkSprite_77_07_Gfx04 ; $73fb
	dw WalkSprite_77_07_Gfx04 ; $73fd
	dw WalkSprite_77_07_Gfx04 ; $73ff
	dw WalkSprite_77_07_Gfx04 ; $7401
	dw WalkSprite_77_07_Gfx05 ; $7403
Padding_77_4:
	; $7405, 11 bytes (fill)
	ds 11, $00
WalkSprite_77_07_Gfx00:
	INCBIN "data/bank_077/d_7410.bin" ; $7410, 64 bytes
WalkSprite_77_07_Gfx01:
	INCBIN "data/bank_077/d_7450.bin" ; $7450, 64 bytes
WalkSprite_77_07_Gfx02:
	INCBIN "data/bank_077/d_7490.bin" ; $7490, 64 bytes
WalkSprite_77_07_Gfx03:
	INCBIN "data/bank_077/d_74d0.bin" ; $74d0, 64 bytes
WalkSprite_77_07_Gfx04:
	INCBIN "data/bank_077/d_7510.bin" ; $7510, 64 bytes
WalkSprite_77_07_Gfx05:
	INCBIN "data/bank_077/d_7550.bin" ; $7550, 64 bytes
WalkSprite_77_07_OamPtrs:
	dw WalkSprite_77_07_Oam00 ; $7590
	dw WalkSprite_77_07_Oam01 ; $7592
	dw WalkSprite_77_07_Oam02 ; $7594
	dw WalkSprite_77_07_Oam02 ; $7596
	dw WalkSprite_77_07_Oam02 ; $7598
	dw WalkSprite_77_07_Oam02 ; $759a
	dw WalkSprite_77_07_Oam02 ; $759c
	dw WalkSprite_77_07_Oam03 ; $759e
	dw WalkSprite_77_07_Oam04 ; $75a0
WalkSprite_77_07_Oam00:
	INCBIN "data/bank_077/d_75a2.bin" ; $75a2, 3 bytes
WalkSprite_77_07_Oam01:
	INCBIN "data/bank_077/d_75a5.bin" ; $75a5, 6 bytes
WalkSprite_77_07_Oam02:
	INCBIN "data/bank_077/d_75ab.bin" ; $75ab, 6 bytes
WalkSprite_77_07_Oam03:
	INCBIN "data/bank_077/d_75b1.bin" ; $75b1, 3 bytes
WalkSprite_77_07_Oam04:
	INCBIN "data/bank_077/d_75b4.bin" ; $75b4, 6 bytes
	; $75ba, 2630 bytes fill to bank end (linker-padded)

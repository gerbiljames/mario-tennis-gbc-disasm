SECTION "ROM Bank $73", ROMX[$4000], BANK[$73]

DataPtr_WalkSprite_73_00:
	dw WalkSprite_73_00 ; $4000
DataPtr_WalkSprite_73_01:
	dw WalkSprite_73_01 ; $4002
DataPtr_WalkSprite_73_02:
	dw WalkSprite_73_02 ; $4004
DataPtr_WalkSprite_73_03:
	dw WalkSprite_73_03 ; $4006
DataPtr_WalkSprite_73_04:
	dw WalkSprite_73_04 ; $4008
DataPtr_WalkSprite_73_05:
	dw WalkSprite_73_05 ; $400a
DataPtr_WalkSprite_73_06:
	dw WalkSprite_73_06 ; $400c
DataPtr_WalkSprite_73_07:
	dw WalkSprite_73_07 ; $400e
DataPtr_WalkSprite_73_08:
	dw WalkSprite_73_08 ; $4010
DataPtr_WalkSprite_73_09:
	dw WalkSprite_73_09 ; $4012
DataPtr_WalkSprite_73_10:
	dw WalkSprite_73_10 ; $4014
DataPtr_WalkSprite_73_11:
	dw WalkSprite_73_11 ; $4016
DataPtr_WalkSprite_73_12:
	dw WalkSprite_73_12 ; $4018
DataPtr_WalkSprite_73_13:
	dw WalkSprite_73_13 ; $401a
DataPtr_WalkSprite_73_14:
	dw WalkSprite_73_14 ; $401c
DataPtr_WalkSprite_73_15:
	dw WalkSprite_73_15 ; $401e
DataPtr_WalkSprite_73_16:
	dw WalkSprite_73_16 ; $4020
DataPtr_WalkSprite_73_17:
	dw WalkSprite_73_17 ; $4022
DataPtr_WalkSprite_73_18:
	dw WalkSprite_73_18 ; $4024
DataPtr_WalkSprite_73_19:
	dw WalkSprite_73_19 ; $4026
WalkSprite_73_00:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_4650, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_00_Gfx00, WalkSprite_73_00_Gfx01, WalkSprite_73_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_00_Gfx02 ; $4038
	dw WalkSprite_73_00_Gfx02 ; $403a
	dw WalkSprite_73_00_Gfx02 ; $403c
	dw WalkSprite_73_00_Gfx02 ; $403e
	dw WalkSprite_73_00_Gfx03 ; $4040
	dw WalkSprite_73_00_Gfx04 ; $4042
	dw WalkSprite_73_00_Gfx05 ; $4044
Padding_73_4046:
	; $4046, 10 bytes (fill)
	ds 10, $00
WalkSprite_73_00_Gfx00:
	INCBIN "data/bank_073/d_4050.bin" ; $4050, 256 bytes
WalkSprite_73_00_Gfx01:
	INCBIN "data/bank_073/d_4150.bin" ; $4150, 256 bytes
WalkSprite_73_00_Gfx02:
	INCBIN "data/bank_073/d_4250.bin" ; $4250, 256 bytes
WalkSprite_73_00_Gfx03:
	INCBIN "data/bank_073/d_4350.bin" ; $4350, 256 bytes
WalkSprite_73_00_Gfx04:
	INCBIN "data/bank_073/d_4450.bin" ; $4450, 256 bytes
WalkSprite_73_00_Gfx05:
	INCBIN "data/bank_073/d_4550.bin" ; $4550, 256 bytes
OamPtrs_73_4650:
	dw WalkSprite_73_00_Oam00 ; $4650
	dw WalkSprite_73_00_Oam01 ; $4652
	dw WalkSprite_73_00_Oam02 ; $4654
	dw WalkSprite_73_00_Oam03 ; $4656
	dw WalkSprite_73_00_Oam04 ; $4658
	dw WalkSprite_73_00_Oam05 ; $465a
	dw WalkSprite_73_00_Oam05 ; $465c
	dw WalkSprite_73_00_Oam05 ; $465e
WalkSprite_73_00_Oam00:
	INCBIN "data/bank_073/d_4660.bin" ; $4660, 3 bytes
WalkSprite_73_00_Oam01:
	INCBIN "data/bank_073/d_4663.bin" ; $4663, 6 bytes
WalkSprite_73_00_Oam02:
	INCBIN "data/bank_073/d_4669.bin" ; $4669, 12 bytes
WalkSprite_73_00_Oam03:
	INCBIN "data/bank_073/d_4675.bin" ; $4675, 8 bytes
WalkSprite_73_00_Oam04:
	INCBIN "data/bank_073/d_467d.bin" ; $467d, 20 bytes
WalkSprite_73_00_Oam05:
	INCBIN "data/bank_073/d_4691.bin" ; $4691, 12 bytes
WalkSprite_73_01:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_4cc0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_01_Gfx00, WalkSprite_73_01_Gfx01, WalkSprite_73_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_01_Gfx02 ; $46ad
	dw WalkSprite_73_01_Gfx02 ; $46af
	dw WalkSprite_73_01_Gfx02 ; $46b1
	dw WalkSprite_73_01_Gfx02 ; $46b3
	dw WalkSprite_73_01_Gfx03 ; $46b5
	dw WalkSprite_73_01_Gfx04 ; $46b7
	dw WalkSprite_73_01_Gfx05 ; $46b9
Padding_73_46bb:
	; $46bb, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_01_Gfx00:
	INCBIN "data/bank_073/d_46c0.bin" ; $46c0, 256 bytes
WalkSprite_73_01_Gfx01:
	INCBIN "data/bank_073/d_47c0.bin" ; $47c0, 256 bytes
WalkSprite_73_01_Gfx02:
	INCBIN "data/bank_073/d_48c0.bin" ; $48c0, 256 bytes
WalkSprite_73_01_Gfx03:
	INCBIN "data/bank_073/d_49c0.bin" ; $49c0, 256 bytes
WalkSprite_73_01_Gfx04:
	INCBIN "data/bank_073/d_4ac0.bin" ; $4ac0, 256 bytes
WalkSprite_73_01_Gfx05:
	INCBIN "data/bank_073/d_4bc0.bin" ; $4bc0, 256 bytes
OamPtrs_73_4cc0:
	dw WalkSprite_73_01_Oam00 ; $4cc0
	dw WalkSprite_73_01_Oam01 ; $4cc2
	dw WalkSprite_73_01_Oam02 ; $4cc4
	dw WalkSprite_73_01_Oam03 ; $4cc6
	dw WalkSprite_73_01_Oam04 ; $4cc8
	dw WalkSprite_73_01_Oam05 ; $4cca
	dw WalkSprite_73_01_Oam05 ; $4ccc
	dw WalkSprite_73_01_Oam05 ; $4cce
WalkSprite_73_01_Oam00:
	INCBIN "data/bank_073/d_4cd0.bin" ; $4cd0, 3 bytes
WalkSprite_73_01_Oam01:
	INCBIN "data/bank_073/d_4cd3.bin" ; $4cd3, 6 bytes
WalkSprite_73_01_Oam02:
	INCBIN "data/bank_073/d_4cd9.bin" ; $4cd9, 12 bytes
WalkSprite_73_01_Oam03:
	INCBIN "data/bank_073/d_4ce5.bin" ; $4ce5, 8 bytes
WalkSprite_73_01_Oam04:
	INCBIN "data/bank_073/d_4ced.bin" ; $4ced, 20 bytes
WalkSprite_73_01_Oam05:
	INCBIN "data/bank_073/d_4d01.bin" ; $4d01, 12 bytes
WalkSprite_73_02:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_4eb0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_02_Gfx00, WalkSprite_73_02_Gfx01, WalkSprite_73_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_02_Gfx02 ; $4d1d
	dw WalkSprite_73_02_Gfx02 ; $4d1f
	dw WalkSprite_73_02_Gfx02 ; $4d21
	dw WalkSprite_73_02_Gfx02 ; $4d23
	dw WalkSprite_73_02_Gfx03 ; $4d25
	dw WalkSprite_73_02_Gfx04 ; $4d27
	dw WalkSprite_73_02_Gfx05 ; $4d29
Padding_73_4d2b:
	; $4d2b, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_02_Gfx00:
	INCBIN "data/bank_073/d_4d30.bin" ; $4d30, 64 bytes
WalkSprite_73_02_Gfx01:
	INCBIN "data/bank_073/d_4d70.bin" ; $4d70, 64 bytes
WalkSprite_73_02_Gfx02:
	INCBIN "data/bank_073/d_4db0.bin" ; $4db0, 64 bytes
WalkSprite_73_02_Gfx03:
	INCBIN "data/bank_073/d_4df0.bin" ; $4df0, 64 bytes
WalkSprite_73_02_Gfx04:
	INCBIN "data/bank_073/d_4e30.bin" ; $4e30, 64 bytes
WalkSprite_73_02_Gfx05:
	INCBIN "data/bank_073/d_4e70.bin" ; $4e70, 64 bytes
OamPtrs_73_4eb0:
	dw WalkSprite_73_02_Oam00 ; $4eb0
	dw WalkSprite_73_02_Oam01 ; $4eb2
	dw WalkSprite_73_02_Oam02 ; $4eb4
	dw WalkSprite_73_02_Oam03 ; $4eb6
	dw WalkSprite_73_02_Oam04 ; $4eb8
	dw WalkSprite_73_02_Oam05 ; $4eba
	dw WalkSprite_73_02_Oam05 ; $4ebc
	dw WalkSprite_73_02_Oam05 ; $4ebe
WalkSprite_73_02_Oam00:
	INCBIN "data/bank_073/d_4ec0.bin" ; $4ec0, 3 bytes
WalkSprite_73_02_Oam01:
	INCBIN "data/bank_073/d_4ec3.bin" ; $4ec3, 6 bytes
WalkSprite_73_02_Oam02:
	INCBIN "data/bank_073/d_4ec9.bin" ; $4ec9, 12 bytes
WalkSprite_73_02_Oam03:
	INCBIN "data/bank_073/d_4ed5.bin" ; $4ed5, 8 bytes
WalkSprite_73_02_Oam04:
	INCBIN "data/bank_073/d_4edd.bin" ; $4edd, 20 bytes
WalkSprite_73_02_Oam05:
	INCBIN "data/bank_073/d_4ef1.bin" ; $4ef1, 12 bytes
WalkSprite_73_03:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_50a0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_03_Gfx00, WalkSprite_73_03_Gfx01, WalkSprite_73_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_03_Gfx02 ; $4f0d
	dw WalkSprite_73_03_Gfx02 ; $4f0f
	dw WalkSprite_73_03_Gfx02 ; $4f11
	dw WalkSprite_73_03_Gfx02 ; $4f13
	dw WalkSprite_73_03_Gfx03 ; $4f15
	dw WalkSprite_73_03_Gfx04 ; $4f17
	dw WalkSprite_73_03_Gfx05 ; $4f19
Padding_73_4f1b:
	; $4f1b, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_03_Gfx00:
	INCBIN "data/bank_073/d_4f20.bin" ; $4f20, 64 bytes
WalkSprite_73_03_Gfx01:
	INCBIN "data/bank_073/d_4f60.bin" ; $4f60, 64 bytes
WalkSprite_73_03_Gfx02:
	INCBIN "data/bank_073/d_4fa0.bin" ; $4fa0, 64 bytes
WalkSprite_73_03_Gfx03:
	INCBIN "data/bank_073/d_4fe0.bin" ; $4fe0, 64 bytes
WalkSprite_73_03_Gfx04:
	INCBIN "data/bank_073/d_5020.bin" ; $5020, 64 bytes
WalkSprite_73_03_Gfx05:
	INCBIN "data/bank_073/d_5060.bin" ; $5060, 64 bytes
OamPtrs_73_50a0:
	dw WalkSprite_73_03_Oam00 ; $50a0
	dw WalkSprite_73_03_Oam01 ; $50a2
	dw WalkSprite_73_03_Oam02 ; $50a4
	dw WalkSprite_73_03_Oam03 ; $50a6
	dw WalkSprite_73_03_Oam04 ; $50a8
	dw WalkSprite_73_03_Oam05 ; $50aa
	dw WalkSprite_73_03_Oam05 ; $50ac
	dw WalkSprite_73_03_Oam05 ; $50ae
WalkSprite_73_03_Oam00:
	INCBIN "data/bank_073/d_50b0.bin" ; $50b0, 3 bytes
WalkSprite_73_03_Oam01:
	INCBIN "data/bank_073/d_50b3.bin" ; $50b3, 6 bytes
WalkSprite_73_03_Oam02:
	INCBIN "data/bank_073/d_50b9.bin" ; $50b9, 12 bytes
WalkSprite_73_03_Oam03:
	INCBIN "data/bank_073/d_50c5.bin" ; $50c5, 8 bytes
WalkSprite_73_03_Oam04:
	INCBIN "data/bank_073/d_50cd.bin" ; $50cd, 20 bytes
WalkSprite_73_03_Oam05:
	INCBIN "data/bank_073/d_50e1.bin" ; $50e1, 12 bytes
WalkSprite_73_04:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_5290, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_04_Gfx00, WalkSprite_73_04_Gfx01, WalkSprite_73_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_04_Gfx02 ; $50fd
	dw WalkSprite_73_04_Gfx02 ; $50ff
	dw WalkSprite_73_04_Gfx02 ; $5101
	dw WalkSprite_73_04_Gfx02 ; $5103
	dw WalkSprite_73_04_Gfx03 ; $5105
	dw WalkSprite_73_04_Gfx04 ; $5107
	dw WalkSprite_73_04_Gfx05 ; $5109
Padding_73_510b:
	; $510b, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_04_Gfx00:
	INCBIN "data/bank_073/d_5110.bin" ; $5110, 64 bytes
WalkSprite_73_04_Gfx01:
	INCBIN "data/bank_073/d_5150.bin" ; $5150, 64 bytes
WalkSprite_73_04_Gfx02:
	INCBIN "data/bank_073/d_5190.bin" ; $5190, 64 bytes
WalkSprite_73_04_Gfx03:
	INCBIN "data/bank_073/d_51d0.bin" ; $51d0, 64 bytes
WalkSprite_73_04_Gfx04:
	INCBIN "data/bank_073/d_5210.bin" ; $5210, 64 bytes
WalkSprite_73_04_Gfx05:
	INCBIN "data/bank_073/d_5250.bin" ; $5250, 64 bytes
OamPtrs_73_5290:
	dw WalkSprite_73_04_Oam00 ; $5290
	dw WalkSprite_73_04_Oam01 ; $5292
	dw WalkSprite_73_04_Oam02 ; $5294
	dw WalkSprite_73_04_Oam03 ; $5296
	dw WalkSprite_73_04_Oam04 ; $5298
	dw WalkSprite_73_04_Oam05 ; $529a
	dw WalkSprite_73_04_Oam05 ; $529c
	dw WalkSprite_73_04_Oam05 ; $529e
WalkSprite_73_04_Oam00:
	INCBIN "data/bank_073/d_52a0.bin" ; $52a0, 3 bytes
WalkSprite_73_04_Oam01:
	INCBIN "data/bank_073/d_52a3.bin" ; $52a3, 6 bytes
WalkSprite_73_04_Oam02:
	INCBIN "data/bank_073/d_52a9.bin" ; $52a9, 12 bytes
WalkSprite_73_04_Oam03:
	INCBIN "data/bank_073/d_52b5.bin" ; $52b5, 8 bytes
WalkSprite_73_04_Oam04:
	INCBIN "data/bank_073/d_52bd.bin" ; $52bd, 20 bytes
WalkSprite_73_04_Oam05:
	INCBIN "data/bank_073/d_52d1.bin" ; $52d1, 12 bytes
WalkSprite_73_05:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_5480, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_05_Gfx00, WalkSprite_73_05_Gfx01, WalkSprite_73_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_05_Gfx02 ; $52ed
	dw WalkSprite_73_05_Gfx02 ; $52ef
	dw WalkSprite_73_05_Gfx02 ; $52f1
	dw WalkSprite_73_05_Gfx02 ; $52f3
	dw WalkSprite_73_05_Gfx03 ; $52f5
	dw WalkSprite_73_05_Gfx04 ; $52f7
	dw WalkSprite_73_05_Gfx05 ; $52f9
Padding_73_52fb:
	; $52fb, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_05_Gfx00:
	INCBIN "data/bank_073/d_5300.bin" ; $5300, 64 bytes
WalkSprite_73_05_Gfx01:
	INCBIN "data/bank_073/d_5340.bin" ; $5340, 64 bytes
WalkSprite_73_05_Gfx02:
	INCBIN "data/bank_073/d_5380.bin" ; $5380, 64 bytes
WalkSprite_73_05_Gfx03:
	INCBIN "data/bank_073/d_53c0.bin" ; $53c0, 64 bytes
WalkSprite_73_05_Gfx04:
	INCBIN "data/bank_073/d_5400.bin" ; $5400, 64 bytes
WalkSprite_73_05_Gfx05:
	INCBIN "data/bank_073/d_5440.bin" ; $5440, 64 bytes
OamPtrs_73_5480:
	dw WalkSprite_73_05_Oam00 ; $5480
	dw WalkSprite_73_05_Oam01 ; $5482
	dw WalkSprite_73_05_Oam02 ; $5484
	dw WalkSprite_73_05_Oam03 ; $5486
	dw WalkSprite_73_05_Oam04 ; $5488
	dw WalkSprite_73_05_Oam05 ; $548a
	dw WalkSprite_73_05_Oam05 ; $548c
	dw WalkSprite_73_05_Oam05 ; $548e
WalkSprite_73_05_Oam00:
	INCBIN "data/bank_073/d_5490.bin" ; $5490, 3 bytes
WalkSprite_73_05_Oam01:
	INCBIN "data/bank_073/d_5493.bin" ; $5493, 6 bytes
WalkSprite_73_05_Oam02:
	INCBIN "data/bank_073/d_5499.bin" ; $5499, 12 bytes
WalkSprite_73_05_Oam03:
	INCBIN "data/bank_073/d_54a5.bin" ; $54a5, 8 bytes
WalkSprite_73_05_Oam04:
	INCBIN "data/bank_073/d_54ad.bin" ; $54ad, 20 bytes
WalkSprite_73_05_Oam05:
	INCBIN "data/bank_073/d_54c1.bin" ; $54c1, 12 bytes
WalkSprite_73_06:
	db $04, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_56b0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_06_Gfx00, WalkSprite_73_06_Gfx01, WalkSprite_73_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_06_Gfx02 ; $54dd
	dw WalkSprite_73_06_Gfx02 ; $54df
	dw WalkSprite_73_06_Gfx02 ; $54e1
	dw WalkSprite_73_06_Gfx02 ; $54e3
	dw WalkSprite_73_06_Gfx03 ; $54e5
	dw WalkSprite_73_06_Gfx04 ; $54e7
	dw WalkSprite_73_06_Gfx05 ; $54e9
	dw WalkSprite_73_06_Gfx06 ; $54eb
Padding_73_54ed:
	; $54ed, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_06_Gfx00:
	INCBIN "data/bank_073/d_54f0.bin" ; $54f0, 64 bytes
WalkSprite_73_06_Gfx01:
	INCBIN "data/bank_073/d_5530.bin" ; $5530, 64 bytes
WalkSprite_73_06_Gfx02:
	INCBIN "data/bank_073/d_5570.bin" ; $5570, 64 bytes
WalkSprite_73_06_Gfx03:
	INCBIN "data/bank_073/d_55b0.bin" ; $55b0, 64 bytes
WalkSprite_73_06_Gfx04:
	INCBIN "data/bank_073/d_55f0.bin" ; $55f0, 64 bytes
WalkSprite_73_06_Gfx05:
	INCBIN "data/bank_073/d_5630.bin" ; $5630, 64 bytes
WalkSprite_73_06_Gfx06:
	INCBIN "data/bank_073/d_5670.bin" ; $5670, 64 bytes
OamPtrs_73_56b0:
	dw WalkSprite_73_06_Oam00 ; $56b0
	dw WalkSprite_73_06_Oam00 ; $56b2
	dw WalkSprite_73_06_Oam01 ; $56b4
	dw WalkSprite_73_06_Oam02 ; $56b6
	dw WalkSprite_73_06_Oam03 ; $56b8
	dw WalkSprite_73_06_Oam04 ; $56ba
	dw WalkSprite_73_06_Oam05 ; $56bc
	dw WalkSprite_73_06_Oam05 ; $56be
WalkSprite_73_06_Oam00:
	INCBIN "data/bank_073/d_56c0.bin" ; $56c0, 3 bytes
WalkSprite_73_06_Oam01:
	INCBIN "data/bank_073/d_56c3.bin" ; $56c3, 12 bytes
WalkSprite_73_06_Oam02:
	INCBIN "data/bank_073/d_56cf.bin" ; $56cf, 8 bytes
WalkSprite_73_06_Oam03:
	INCBIN "data/bank_073/d_56d7.bin" ; $56d7, 20 bytes
WalkSprite_73_06_Oam04:
	INCBIN "data/bank_073/d_56eb.bin" ; $56eb, 10 bytes
WalkSprite_73_06_Oam05:
	INCBIN "data/bank_073/d_56f5.bin" ; $56f5, 12 bytes
WalkSprite_73_07:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_58f0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_07_Gfx00, WalkSprite_73_07_Gfx01, WalkSprite_73_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_07_Gfx02 ; $5711
	dw WalkSprite_73_07_Gfx02 ; $5713
	dw WalkSprite_73_07_Gfx02 ; $5715
	dw WalkSprite_73_07_Gfx02 ; $5717
	dw WalkSprite_73_07_Gfx03 ; $5719
	dw WalkSprite_73_07_Gfx04 ; $571b
	dw WalkSprite_73_07_Gfx05 ; $571d
	dw WalkSprite_73_07_Gfx06 ; $571f
Padding_73_5721:
	; $5721, 15 bytes (fill)
	ds 15, $00
WalkSprite_73_07_Gfx00:
	INCBIN "data/bank_073/d_5730.bin" ; $5730, 64 bytes
WalkSprite_73_07_Gfx01:
	INCBIN "data/bank_073/d_5770.bin" ; $5770, 64 bytes
WalkSprite_73_07_Gfx02:
	INCBIN "data/bank_073/d_57b0.bin" ; $57b0, 64 bytes
WalkSprite_73_07_Gfx03:
	INCBIN "data/bank_073/d_57f0.bin" ; $57f0, 64 bytes
WalkSprite_73_07_Gfx04:
	INCBIN "data/bank_073/d_5830.bin" ; $5830, 64 bytes
WalkSprite_73_07_Gfx05:
	INCBIN "data/bank_073/d_5870.bin" ; $5870, 64 bytes
WalkSprite_73_07_Gfx06:
	INCBIN "data/bank_073/d_58b0.bin" ; $58b0, 64 bytes
OamPtrs_73_58f0:
	dw WalkSprite_73_07_Oam00 ; $58f0
	dw WalkSprite_73_07_Oam00 ; $58f2
	dw WalkSprite_73_07_Oam01 ; $58f4
	dw WalkSprite_73_07_Oam02 ; $58f6
	dw WalkSprite_73_07_Oam02 ; $58f8
	dw WalkSprite_73_07_Oam03 ; $58fa
	dw WalkSprite_73_07_Oam04 ; $58fc
	dw WalkSprite_73_07_Oam04 ; $58fe
WalkSprite_73_07_Oam00:
	INCBIN "data/bank_073/d_5900.bin" ; $5900, 3 bytes
WalkSprite_73_07_Oam01:
	INCBIN "data/bank_073/d_5903.bin" ; $5903, 18 bytes
WalkSprite_73_07_Oam02:
	INCBIN "data/bank_073/d_5915.bin" ; $5915, 20 bytes
WalkSprite_73_07_Oam03:
	INCBIN "data/bank_073/d_5929.bin" ; $5929, 10 bytes
WalkSprite_73_07_Oam04:
	INCBIN "data/bank_073/d_5933.bin" ; $5933, 12 bytes
WalkSprite_73_08:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_5f60, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_08_Gfx00, WalkSprite_73_08_Gfx01, WalkSprite_73_08_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_08_Gfx02 ; $594f
	dw WalkSprite_73_08_Gfx02 ; $5951
	dw WalkSprite_73_08_Gfx02 ; $5953
	dw WalkSprite_73_08_Gfx02 ; $5955
	dw WalkSprite_73_08_Gfx03 ; $5957
	dw WalkSprite_73_08_Gfx04 ; $5959
	dw WalkSprite_73_08_Gfx05 ; $595b
Padding_73_595d:
	; $595d, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_08_Gfx00:
	INCBIN "data/bank_073/d_5960.bin" ; $5960, 256 bytes
WalkSprite_73_08_Gfx01:
	INCBIN "data/bank_073/d_5a60.bin" ; $5a60, 256 bytes
WalkSprite_73_08_Gfx02:
	INCBIN "data/bank_073/d_5b60.bin" ; $5b60, 256 bytes
WalkSprite_73_08_Gfx03:
	INCBIN "data/bank_073/d_5c60.bin" ; $5c60, 256 bytes
WalkSprite_73_08_Gfx04:
	INCBIN "data/bank_073/d_5d60.bin" ; $5d60, 256 bytes
WalkSprite_73_08_Gfx05:
	INCBIN "data/bank_073/d_5e60.bin" ; $5e60, 256 bytes
OamPtrs_73_5f60:
	dw WalkSprite_73_08_Oam00 ; $5f60
	dw WalkSprite_73_08_Oam01 ; $5f62
	dw WalkSprite_73_08_Oam02 ; $5f64
	dw WalkSprite_73_08_Oam03 ; $5f66
	dw WalkSprite_73_08_Oam04 ; $5f68
	dw WalkSprite_73_08_Oam05 ; $5f6a
	dw WalkSprite_73_08_Oam05 ; $5f6c
	dw WalkSprite_73_08_Oam05 ; $5f6e
WalkSprite_73_08_Oam00:
	INCBIN "data/bank_073/d_5f70.bin" ; $5f70, 3 bytes
WalkSprite_73_08_Oam01:
	INCBIN "data/bank_073/d_5f73.bin" ; $5f73, 6 bytes
WalkSprite_73_08_Oam02:
	INCBIN "data/bank_073/d_5f79.bin" ; $5f79, 12 bytes
WalkSprite_73_08_Oam03:
	INCBIN "data/bank_073/d_5f85.bin" ; $5f85, 8 bytes
WalkSprite_73_08_Oam04:
	INCBIN "data/bank_073/d_5f8d.bin" ; $5f8d, 20 bytes
WalkSprite_73_08_Oam05:
	INCBIN "data/bank_073/d_5fa1.bin" ; $5fa1, 12 bytes
WalkSprite_73_09:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_67e0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_09_Gfx00, WalkSprite_73_09_Gfx01, WalkSprite_73_09_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_09_Gfx02 ; $5fbd
	dw WalkSprite_73_09_Gfx02 ; $5fbf
	dw WalkSprite_73_09_Gfx02 ; $5fc1
	dw WalkSprite_73_09_Gfx02 ; $5fc3
	dw WalkSprite_73_09_Gfx03 ; $5fc5
	dw WalkSprite_73_09_Gfx04 ; $5fc7
	dw WalkSprite_73_09_Gfx05 ; $5fc9
	dw WalkSprite_73_09_Gfx06 ; $5fcb
	dw WalkSprite_73_09_Gfx06 ; $5fcd
	dw WalkSprite_73_09_Gfx07 ; $5fcf
Padding_73_5fd1:
	; $5fd1, 15 bytes (fill)
	ds 15, $00
WalkSprite_73_09_Gfx00:
	INCBIN "data/bank_073/d_5fe0.bin" ; $5fe0, 256 bytes
WalkSprite_73_09_Gfx01:
	INCBIN "data/bank_073/d_60e0.bin" ; $60e0, 256 bytes
WalkSprite_73_09_Gfx02:
	INCBIN "data/bank_073/d_61e0.bin" ; $61e0, 256 bytes
WalkSprite_73_09_Gfx03:
	INCBIN "data/bank_073/d_62e0.bin" ; $62e0, 256 bytes
WalkSprite_73_09_Gfx04:
	INCBIN "data/bank_073/d_63e0.bin" ; $63e0, 256 bytes
WalkSprite_73_09_Gfx05:
	INCBIN "data/bank_073/d_64e0.bin" ; $64e0, 256 bytes
WalkSprite_73_09_Gfx06:
	INCBIN "data/bank_073/d_65e0.bin" ; $65e0, 256 bytes
WalkSprite_73_09_Gfx07:
	INCBIN "data/bank_073/d_66e0.bin" ; $66e0, 256 bytes
OamPtrs_73_67e0:
	dw WalkSprite_73_09_Oam00 ; $67e0
	dw WalkSprite_73_09_Oam01 ; $67e2
	dw WalkSprite_73_09_Oam02 ; $67e4
	dw WalkSprite_73_09_Oam03 ; $67e6
	dw WalkSprite_73_09_Oam04 ; $67e8
	dw WalkSprite_73_09_Oam05 ; $67ea
	dw WalkSprite_73_09_Oam05 ; $67ec
	dw WalkSprite_73_09_Oam05 ; $67ee
	dw WalkSprite_73_09_Oam06 ; $67f0
WalkSprite_73_09_Oam00:
	INCBIN "data/bank_073/d_67f2.bin" ; $67f2, 3 bytes
WalkSprite_73_09_Oam01:
	INCBIN "data/bank_073/d_67f5.bin" ; $67f5, 6 bytes
WalkSprite_73_09_Oam02:
	INCBIN "data/bank_073/d_67fb.bin" ; $67fb, 12 bytes
WalkSprite_73_09_Oam03:
	INCBIN "data/bank_073/d_6807.bin" ; $6807, 8 bytes
WalkSprite_73_09_Oam04:
	INCBIN "data/bank_073/d_680f.bin" ; $680f, 20 bytes
WalkSprite_73_09_Oam05:
	INCBIN "data/bank_073/d_6823.bin" ; $6823, 12 bytes
WalkSprite_73_09_Oam06:
	INCBIN "data/bank_073/d_682f.bin" ; $682f, 6 bytes
WalkSprite_73_10:
	db $04, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_6e60, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_10_Gfx00, WalkSprite_73_10_Gfx01, WalkSprite_73_10_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_10_Gfx02 ; $6845
	dw WalkSprite_73_10_Gfx02 ; $6847
	dw WalkSprite_73_10_Gfx02 ; $6849
	dw WalkSprite_73_10_Gfx02 ; $684b
	dw WalkSprite_73_10_Gfx03 ; $684d
	dw WalkSprite_73_10_Gfx04 ; $684f
	dw WalkSprite_73_10_Gfx05 ; $6851
Padding_73_6853:
	; $6853, 13 bytes (fill)
	ds 13, $00
WalkSprite_73_10_Gfx00:
	INCBIN "data/bank_073/d_6860.bin" ; $6860, 256 bytes
WalkSprite_73_10_Gfx01:
	INCBIN "data/bank_073/d_6960.bin" ; $6960, 256 bytes
WalkSprite_73_10_Gfx02:
	INCBIN "data/bank_073/d_6a60.bin" ; $6a60, 256 bytes
WalkSprite_73_10_Gfx03:
	INCBIN "data/bank_073/d_6b60.bin" ; $6b60, 256 bytes
WalkSprite_73_10_Gfx04:
	INCBIN "data/bank_073/d_6c60.bin" ; $6c60, 256 bytes
WalkSprite_73_10_Gfx05:
	INCBIN "data/bank_073/d_6d60.bin" ; $6d60, 256 bytes
OamPtrs_73_6e60:
	dw WalkSprite_73_10_Oam00 ; $6e60
	dw WalkSprite_73_10_Oam01 ; $6e62
	dw WalkSprite_73_10_Oam02 ; $6e64
	dw WalkSprite_73_10_Oam03 ; $6e66
	dw WalkSprite_73_10_Oam04 ; $6e68
	dw WalkSprite_73_10_Oam05 ; $6e6a
	dw WalkSprite_73_10_Oam05 ; $6e6c
	dw WalkSprite_73_10_Oam05 ; $6e6e
WalkSprite_73_10_Oam00:
	INCBIN "data/bank_073/d_6e70.bin" ; $6e70, 3 bytes
WalkSprite_73_10_Oam01:
	INCBIN "data/bank_073/d_6e73.bin" ; $6e73, 6 bytes
WalkSprite_73_10_Oam02:
	INCBIN "data/bank_073/d_6e79.bin" ; $6e79, 12 bytes
WalkSprite_73_10_Oam03:
	INCBIN "data/bank_073/d_6e85.bin" ; $6e85, 8 bytes
WalkSprite_73_10_Oam04:
	INCBIN "data/bank_073/d_6e8d.bin" ; $6e8d, 20 bytes
WalkSprite_73_10_Oam05:
	INCBIN "data/bank_073/d_6ea1.bin" ; $6ea1, 12 bytes
WalkSprite_73_11:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_74d0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_11_Gfx00, WalkSprite_73_11_Gfx01, WalkSprite_73_11_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_11_Gfx02 ; $6ebd
	dw WalkSprite_73_11_Gfx02 ; $6ebf
	dw WalkSprite_73_11_Gfx02 ; $6ec1
	dw WalkSprite_73_11_Gfx02 ; $6ec3
	dw WalkSprite_73_11_Gfx03 ; $6ec5
	dw WalkSprite_73_11_Gfx04 ; $6ec7
	dw WalkSprite_73_11_Gfx05 ; $6ec9
Padding_73_6ecb:
	; $6ecb, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_11_Gfx00:
	INCBIN "data/bank_073/d_6ed0.bin" ; $6ed0, 256 bytes
WalkSprite_73_11_Gfx01:
	INCBIN "data/bank_073/d_6fd0.bin" ; $6fd0, 256 bytes
WalkSprite_73_11_Gfx02:
	INCBIN "data/bank_073/d_70d0.bin" ; $70d0, 256 bytes
WalkSprite_73_11_Gfx03:
	INCBIN "data/bank_073/d_71d0.bin" ; $71d0, 256 bytes
WalkSprite_73_11_Gfx04:
	INCBIN "data/bank_073/d_72d0.bin" ; $72d0, 256 bytes
WalkSprite_73_11_Gfx05:
	INCBIN "data/bank_073/d_73d0.bin" ; $73d0, 256 bytes
OamPtrs_73_74d0:
	dw WalkSprite_73_11_Oam00 ; $74d0
	dw WalkSprite_73_11_Oam01 ; $74d2
	dw WalkSprite_73_11_Oam02 ; $74d4
	dw WalkSprite_73_11_Oam03 ; $74d6
	dw WalkSprite_73_11_Oam04 ; $74d8
	dw WalkSprite_73_11_Oam05 ; $74da
	dw WalkSprite_73_11_Oam05 ; $74dc
	dw WalkSprite_73_11_Oam05 ; $74de
WalkSprite_73_11_Oam00:
	INCBIN "data/bank_073/d_74e0.bin" ; $74e0, 3 bytes
WalkSprite_73_11_Oam01:
	INCBIN "data/bank_073/d_74e3.bin" ; $74e3, 6 bytes
WalkSprite_73_11_Oam02:
	INCBIN "data/bank_073/d_74e9.bin" ; $74e9, 12 bytes
WalkSprite_73_11_Oam03:
	INCBIN "data/bank_073/d_74f5.bin" ; $74f5, 8 bytes
WalkSprite_73_11_Oam04:
	INCBIN "data/bank_073/d_74fd.bin" ; $74fd, 20 bytes
WalkSprite_73_11_Oam05:
	INCBIN "data/bank_073/d_7511.bin" ; $7511, 12 bytes
WalkSprite_73_12:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_75b0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_12_Gfx00, WalkSprite_73_12_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_752d:
	; $752d, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_12_Gfx00:
	INCBIN "data/bank_073/d_7530.bin" ; $7530, 64 bytes
WalkSprite_73_12_Gfx01:
	INCBIN "data/bank_073/d_7570.bin" ; $7570, 64 bytes
OamPtrs_73_75b0:
	dw WalkSprite_73_12_Oam00 ; $75b0
	dw WalkSprite_73_12_Oam01 ; $75b2
WalkSprite_73_12_Oam00:
	INCBIN "data/bank_073/d_75b4.bin" ; $75b4, 3 bytes
WalkSprite_73_12_Oam01:
	INCBIN "data/bank_073/d_75b7.bin" ; $75b7, 6 bytes
WalkSprite_73_13:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_7650, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_13_Gfx00, WalkSprite_73_13_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_75cd:
	; $75cd, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_13_Gfx00:
	INCBIN "data/bank_073/d_75d0.bin" ; $75d0, 64 bytes
WalkSprite_73_13_Gfx01:
	INCBIN "data/bank_073/d_7610.bin" ; $7610, 64 bytes
OamPtrs_73_7650:
	dw WalkSprite_73_13_Oam00 ; $7650
	dw WalkSprite_73_13_Oam01 ; $7652
WalkSprite_73_13_Oam00:
	INCBIN "data/bank_073/d_7654.bin" ; $7654, 3 bytes
WalkSprite_73_13_Oam01:
	INCBIN "data/bank_073/d_7657.bin" ; $7657, 6 bytes
WalkSprite_73_14:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_7800, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_14_Gfx00, WalkSprite_73_14_Gfx01, WalkSprite_73_14_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_14_Gfx02 ; $766d
	dw WalkSprite_73_14_Gfx02 ; $766f
	dw WalkSprite_73_14_Gfx02 ; $7671
	dw WalkSprite_73_14_Gfx02 ; $7673
	dw WalkSprite_73_14_Gfx03 ; $7675
	dw WalkSprite_73_14_Gfx04 ; $7677
	dw WalkSprite_73_14_Gfx05 ; $7679
Padding_73_767b:
	; $767b, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_14_Gfx00:
	INCBIN "data/bank_073/d_7680.bin" ; $7680, 64 bytes
WalkSprite_73_14_Gfx01:
	INCBIN "data/bank_073/d_76c0.bin" ; $76c0, 64 bytes
WalkSprite_73_14_Gfx02:
	INCBIN "data/bank_073/d_7700.bin" ; $7700, 64 bytes
WalkSprite_73_14_Gfx03:
	INCBIN "data/bank_073/d_7740.bin" ; $7740, 64 bytes
WalkSprite_73_14_Gfx04:
	INCBIN "data/bank_073/d_7780.bin" ; $7780, 64 bytes
WalkSprite_73_14_Gfx05:
	INCBIN "data/bank_073/d_77c0.bin" ; $77c0, 64 bytes
OamPtrs_73_7800:
	dw WalkSprite_73_14_Oam00 ; $7800
	dw WalkSprite_73_14_Oam01 ; $7802
	dw WalkSprite_73_14_Oam02 ; $7804
	dw WalkSprite_73_14_Oam03 ; $7806
	dw WalkSprite_73_14_Oam04 ; $7808
	dw WalkSprite_73_14_Oam05 ; $780a
	dw WalkSprite_73_14_Oam05 ; $780c
	dw WalkSprite_73_14_Oam05 ; $780e
WalkSprite_73_14_Oam00:
	INCBIN "data/bank_073/d_7810.bin" ; $7810, 3 bytes
WalkSprite_73_14_Oam01:
	INCBIN "data/bank_073/d_7813.bin" ; $7813, 6 bytes
WalkSprite_73_14_Oam02:
	INCBIN "data/bank_073/d_7819.bin" ; $7819, 12 bytes
WalkSprite_73_14_Oam03:
	INCBIN "data/bank_073/d_7825.bin" ; $7825, 8 bytes
WalkSprite_73_14_Oam04:
	INCBIN "data/bank_073/d_782d.bin" ; $782d, 20 bytes
WalkSprite_73_14_Oam05:
	INCBIN "data/bank_073/d_7841.bin" ; $7841, 12 bytes
WalkSprite_73_15:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_78e0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_15_Gfx00, WalkSprite_73_15_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_785d:
	; $785d, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_15_Gfx00:
	INCBIN "data/bank_073/d_7860.bin" ; $7860, 64 bytes
WalkSprite_73_15_Gfx01:
	INCBIN "data/bank_073/d_78a0.bin" ; $78a0, 64 bytes
OamPtrs_73_78e0:
	dw WalkSprite_73_15_Oam00 ; $78e0
	dw WalkSprite_73_15_Oam01 ; $78e2
WalkSprite_73_15_Oam00:
	INCBIN "data/bank_073/d_78e4.bin" ; $78e4, 3 bytes
WalkSprite_73_15_Oam01:
	INCBIN "data/bank_073/d_78e7.bin" ; $78e7, 6 bytes
WalkSprite_73_16:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_7980, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_16_Gfx00, WalkSprite_73_16_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_78fd:
	; $78fd, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_16_Gfx00:
	INCBIN "data/bank_073/d_7900.bin" ; $7900, 64 bytes
WalkSprite_73_16_Gfx01:
	INCBIN "data/bank_073/d_7940.bin" ; $7940, 64 bytes
OamPtrs_73_7980:
	dw WalkSprite_73_16_Oam00 ; $7980
	dw WalkSprite_73_16_Oam01 ; $7982
WalkSprite_73_16_Oam00:
	INCBIN "data/bank_073/d_7984.bin" ; $7984, 3 bytes
WalkSprite_73_16_Oam01:
	INCBIN "data/bank_073/d_7987.bin" ; $7987, 6 bytes
WalkSprite_73_17:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_7a20, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_17_Gfx00, WalkSprite_73_17_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_799d:
	; $799d, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_17_Gfx00:
	INCBIN "data/bank_073/d_79a0.bin" ; $79a0, 64 bytes
WalkSprite_73_17_Gfx01:
	INCBIN "data/bank_073/d_79e0.bin" ; $79e0, 64 bytes
OamPtrs_73_7a20:
	dw WalkSprite_73_17_Oam00 ; $7a20
	dw WalkSprite_73_17_Oam01 ; $7a22
WalkSprite_73_17_Oam00:
	INCBIN "data/bank_073/d_7a24.bin" ; $7a24, 3 bytes
WalkSprite_73_17_Oam01:
	INCBIN "data/bank_073/d_7a27.bin" ; $7a27, 6 bytes
WalkSprite_73_18:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_7ac0, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_18_Gfx00, WalkSprite_73_18_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_7a3d:
	; $7a3d, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_18_Gfx00:
	INCBIN "data/bank_073/d_7a40.bin" ; $7a40, 64 bytes
WalkSprite_73_18_Gfx01:
	INCBIN "data/bank_073/d_7a80.bin" ; $7a80, 64 bytes
OamPtrs_73_7ac0:
	dw WalkSprite_73_18_Oam00 ; $7ac0
	dw WalkSprite_73_18_Oam01 ; $7ac2
WalkSprite_73_18_Oam00:
	INCBIN "data/bank_073/d_7ac4.bin" ; $7ac4, 3 bytes
WalkSprite_73_18_Oam01:
	INCBIN "data/bank_073/d_7ac7.bin" ; $7ac7, 6 bytes
WalkSprite_73_19:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_73_7b60, .frames ; frame array, OAM array, frame array
.frames:
	dw WalkSprite_73_19_Gfx00, WalkSprite_73_19_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_7add:
	; $7add, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_19_Gfx00:
	INCBIN "data/bank_073/d_7ae0.bin" ; $7ae0, 64 bytes
WalkSprite_73_19_Gfx01:
	INCBIN "data/bank_073/d_7b20.bin" ; $7b20, 64 bytes
OamPtrs_73_7b60:
	dw WalkSprite_73_19_Oam00 ; $7b60
	dw WalkSprite_73_19_Oam01 ; $7b62
WalkSprite_73_19_Oam00:
	INCBIN "data/bank_073/d_7b64.bin" ; $7b64, 3 bytes
WalkSprite_73_19_Oam01:
	INCBIN "data/bank_073/d_7b67.bin" ; $7b67, 6 bytes
	; $7b6d, 1171 bytes fill to bank end (linker-padded)

SECTION "ROM Bank $6a", ROMX[$4000], BANK[$6a]

WalkSprites_6a:
	dw Data_6a_400a ; $4000
	dw Data_6a_46a1 ; $4002
	dw Data_6a_4d31 ; $4004
	dw Data_6a_53c1 ; $4006
	dw Data_6a_5a51 ; $4008
Data_6a_400a:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6a_4630, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6a_4030, Data_6a_4130, Data_6a_4230 ; frame pointers (continue in body)
	dw Data_6a_4230 ; $401a
	dw Data_6a_4230 ; $401c
	dw Data_6a_4230 ; $401e
	dw Data_6a_4230 ; $4020
	dw Data_6a_4330 ; $4022
	dw Data_6a_4430 ; $4024
	dw Data_6a_4530 ; $4026
	INCBIN "data/bank_06a/d_4028.bin" ; $4028, 8 bytes
Data_6a_4030:
	INCBIN "data/bank_06a/d_4030.bin" ; $4030, 256 bytes
Data_6a_4130:
	INCBIN "data/bank_06a/d_4130.bin" ; $4130, 256 bytes
Data_6a_4230:
	INCBIN "data/bank_06a/d_4230.bin" ; $4230, 256 bytes
Data_6a_4330:
	INCBIN "data/bank_06a/d_4330.bin" ; $4330, 256 bytes
Data_6a_4430:
	INCBIN "data/bank_06a/d_4430.bin" ; $4430, 256 bytes
Data_6a_4530:
	INCBIN "data/bank_06a/d_4530.bin" ; $4530, 256 bytes
OamPtrs_6a_4630:
	dw Data_6a_4648 ; $4630
	dw Data_6a_464b ; $4632
	dw Data_6a_4651 ; $4634
	dw Data_6a_465d ; $4636
	dw Data_6a_4665 ; $4638
	dw Data_6a_4679 ; $463a
	dw Data_6a_4679 ; $463c
	dw Data_6a_467e ; $463e
	dw Data_6a_468a ; $4640
	dw Data_6a_4690 ; $4642
	dw Data_6a_4693 ; $4644
	dw Data_6a_4696 ; $4646
Data_6a_4648:
	INCBIN "data/bank_06a/d_4648.bin" ; $4648, 3 bytes
Data_6a_464b:
	INCBIN "data/bank_06a/d_464b.bin" ; $464b, 6 bytes
Data_6a_4651:
	INCBIN "data/bank_06a/d_4651.bin" ; $4651, 12 bytes
Data_6a_465d:
	INCBIN "data/bank_06a/d_465d.bin" ; $465d, 8 bytes
Data_6a_4665:
	INCBIN "data/bank_06a/d_4665.bin" ; $4665, 20 bytes
Data_6a_4679:
	INCBIN "data/bank_06a/d_4679.bin" ; $4679, 5 bytes
Data_6a_467e:
	INCBIN "data/bank_06a/d_467e.bin" ; $467e, 12 bytes
Data_6a_468a:
	INCBIN "data/bank_06a/d_468a.bin" ; $468a, 6 bytes
Data_6a_4690:
	INCBIN "data/bank_06a/d_4690.bin" ; $4690, 3 bytes
Data_6a_4693:
	INCBIN "data/bank_06a/d_4693.bin" ; $4693, 3 bytes
Data_6a_4696:
	INCBIN "data/bank_06a/d_4696.bin" ; $4696, 11 bytes
Data_6a_46a1:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6a_4cc0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6a_46c0, Data_6a_47c0, Data_6a_48c0 ; frame pointers (continue in body)
	dw Data_6a_48c0 ; $46b1
	dw Data_6a_48c0 ; $46b3
	dw Data_6a_48c0 ; $46b5
	dw Data_6a_48c0 ; $46b7
	dw Data_6a_49c0 ; $46b9
	dw Data_6a_4ac0 ; $46bb
	dw Data_6a_4bc0 ; $46bd
	db $00 ; $46bf
Data_6a_46c0:
	INCBIN "data/bank_06a/d_46c0.bin" ; $46c0, 256 bytes
Data_6a_47c0:
	INCBIN "data/bank_06a/d_47c0.bin" ; $47c0, 256 bytes
Data_6a_48c0:
	INCBIN "data/bank_06a/d_48c0.bin" ; $48c0, 256 bytes
Data_6a_49c0:
	INCBIN "data/bank_06a/d_49c0.bin" ; $49c0, 256 bytes
Data_6a_4ac0:
	INCBIN "data/bank_06a/d_4ac0.bin" ; $4ac0, 256 bytes
Data_6a_4bc0:
	INCBIN "data/bank_06a/d_4bc0.bin" ; $4bc0, 256 bytes
OamPtrs_6a_4cc0:
	dw Data_6a_4cd8 ; $4cc0
	dw Data_6a_4cdb ; $4cc2
	dw Data_6a_4ce1 ; $4cc4
	dw Data_6a_4ced ; $4cc6
	dw Data_6a_4cf5 ; $4cc8
	dw Data_6a_4d09 ; $4cca
	dw Data_6a_4d09 ; $4ccc
	dw Data_6a_4d0e ; $4cce
	dw Data_6a_4d1a ; $4cd0
	dw Data_6a_4d20 ; $4cd2
	dw Data_6a_4d23 ; $4cd4
	dw Data_6a_4d26 ; $4cd6
Data_6a_4cd8:
	INCBIN "data/bank_06a/d_4cd8.bin" ; $4cd8, 3 bytes
Data_6a_4cdb:
	INCBIN "data/bank_06a/d_4cdb.bin" ; $4cdb, 6 bytes
Data_6a_4ce1:
	INCBIN "data/bank_06a/d_4ce1.bin" ; $4ce1, 12 bytes
Data_6a_4ced:
	INCBIN "data/bank_06a/d_4ced.bin" ; $4ced, 8 bytes
Data_6a_4cf5:
	INCBIN "data/bank_06a/d_4cf5.bin" ; $4cf5, 20 bytes
Data_6a_4d09:
	INCBIN "data/bank_06a/d_4d09.bin" ; $4d09, 5 bytes
Data_6a_4d0e:
	INCBIN "data/bank_06a/d_4d0e.bin" ; $4d0e, 12 bytes
Data_6a_4d1a:
	INCBIN "data/bank_06a/d_4d1a.bin" ; $4d1a, 6 bytes
Data_6a_4d20:
	INCBIN "data/bank_06a/d_4d20.bin" ; $4d20, 3 bytes
Data_6a_4d23:
	INCBIN "data/bank_06a/d_4d23.bin" ; $4d23, 3 bytes
Data_6a_4d26:
	INCBIN "data/bank_06a/d_4d26.bin" ; $4d26, 11 bytes
Data_6a_4d31:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6a_5350, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6a_4d50, Data_6a_4e50, Data_6a_4f50 ; frame pointers (continue in body)
	dw Data_6a_4f50 ; $4d41
	dw Data_6a_4f50 ; $4d43
	dw Data_6a_4f50 ; $4d45
	dw Data_6a_4f50 ; $4d47
	dw Data_6a_5050 ; $4d49
	dw Data_6a_5150 ; $4d4b
	dw Data_6a_5250 ; $4d4d
	db $00 ; $4d4f
Data_6a_4d50:
	INCBIN "data/bank_06a/d_4d50.bin" ; $4d50, 256 bytes
Data_6a_4e50:
	INCBIN "data/bank_06a/d_4e50.bin" ; $4e50, 256 bytes
Data_6a_4f50:
	INCBIN "data/bank_06a/d_4f50.bin" ; $4f50, 256 bytes
Data_6a_5050:
	INCBIN "data/bank_06a/d_5050.bin" ; $5050, 256 bytes
Data_6a_5150:
	INCBIN "data/bank_06a/d_5150.bin" ; $5150, 256 bytes
Data_6a_5250:
	INCBIN "data/bank_06a/d_5250.bin" ; $5250, 256 bytes
OamPtrs_6a_5350:
	dw Data_6a_5368 ; $5350
	dw Data_6a_536b ; $5352
	dw Data_6a_5371 ; $5354
	dw Data_6a_537d ; $5356
	dw Data_6a_5385 ; $5358
	dw Data_6a_5399 ; $535a
	dw Data_6a_5399 ; $535c
	dw Data_6a_539e ; $535e
	dw Data_6a_53aa ; $5360
	dw Data_6a_53b0 ; $5362
	dw Data_6a_53b3 ; $5364
	dw Data_6a_53b6 ; $5366
Data_6a_5368:
	INCBIN "data/bank_06a/d_5368.bin" ; $5368, 3 bytes
Data_6a_536b:
	INCBIN "data/bank_06a/d_536b.bin" ; $536b, 6 bytes
Data_6a_5371:
	INCBIN "data/bank_06a/d_5371.bin" ; $5371, 12 bytes
Data_6a_537d:
	INCBIN "data/bank_06a/d_537d.bin" ; $537d, 8 bytes
Data_6a_5385:
	INCBIN "data/bank_06a/d_5385.bin" ; $5385, 20 bytes
Data_6a_5399:
	INCBIN "data/bank_06a/d_5399.bin" ; $5399, 5 bytes
Data_6a_539e:
	INCBIN "data/bank_06a/d_539e.bin" ; $539e, 12 bytes
Data_6a_53aa:
	INCBIN "data/bank_06a/d_53aa.bin" ; $53aa, 6 bytes
Data_6a_53b0:
	INCBIN "data/bank_06a/d_53b0.bin" ; $53b0, 3 bytes
Data_6a_53b3:
	INCBIN "data/bank_06a/d_53b3.bin" ; $53b3, 3 bytes
Data_6a_53b6:
	INCBIN "data/bank_06a/d_53b6.bin" ; $53b6, 11 bytes
Data_6a_53c1:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6a_59e0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6a_53e0, Data_6a_54e0, Data_6a_55e0 ; frame pointers (continue in body)
	dw Data_6a_55e0 ; $53d1
	dw Data_6a_55e0 ; $53d3
	dw Data_6a_55e0 ; $53d5
	dw Data_6a_55e0 ; $53d7
	dw Data_6a_56e0 ; $53d9
	dw Data_6a_57e0 ; $53db
	dw Data_6a_58e0 ; $53dd
	db $00 ; $53df
Data_6a_53e0:
	INCBIN "data/bank_06a/d_53e0.bin" ; $53e0, 256 bytes
Data_6a_54e0:
	INCBIN "data/bank_06a/d_54e0.bin" ; $54e0, 256 bytes
Data_6a_55e0:
	INCBIN "data/bank_06a/d_55e0.bin" ; $55e0, 256 bytes
Data_6a_56e0:
	INCBIN "data/bank_06a/d_56e0.bin" ; $56e0, 256 bytes
Data_6a_57e0:
	INCBIN "data/bank_06a/d_57e0.bin" ; $57e0, 256 bytes
Data_6a_58e0:
	INCBIN "data/bank_06a/d_58e0.bin" ; $58e0, 256 bytes
OamPtrs_6a_59e0:
	dw Data_6a_59f8 ; $59e0
	dw Data_6a_59fb ; $59e2
	dw Data_6a_5a01 ; $59e4
	dw Data_6a_5a0d ; $59e6
	dw Data_6a_5a15 ; $59e8
	dw Data_6a_5a29 ; $59ea
	dw Data_6a_5a29 ; $59ec
	dw Data_6a_5a2e ; $59ee
	dw Data_6a_5a3a ; $59f0
	dw Data_6a_5a40 ; $59f2
	dw Data_6a_5a43 ; $59f4
	dw Data_6a_5a46 ; $59f6
Data_6a_59f8:
	INCBIN "data/bank_06a/d_59f8.bin" ; $59f8, 3 bytes
Data_6a_59fb:
	INCBIN "data/bank_06a/d_59fb.bin" ; $59fb, 6 bytes
Data_6a_5a01:
	INCBIN "data/bank_06a/d_5a01.bin" ; $5a01, 12 bytes
Data_6a_5a0d:
	INCBIN "data/bank_06a/d_5a0d.bin" ; $5a0d, 8 bytes
Data_6a_5a15:
	INCBIN "data/bank_06a/d_5a15.bin" ; $5a15, 20 bytes
Data_6a_5a29:
	INCBIN "data/bank_06a/d_5a29.bin" ; $5a29, 5 bytes
Data_6a_5a2e:
	INCBIN "data/bank_06a/d_5a2e.bin" ; $5a2e, 12 bytes
Data_6a_5a3a:
	INCBIN "data/bank_06a/d_5a3a.bin" ; $5a3a, 6 bytes
Data_6a_5a40:
	INCBIN "data/bank_06a/d_5a40.bin" ; $5a40, 3 bytes
Data_6a_5a43:
	INCBIN "data/bank_06a/d_5a43.bin" ; $5a43, 3 bytes
Data_6a_5a46:
	INCBIN "data/bank_06a/d_5a46.bin" ; $5a46, 11 bytes
Data_6a_5a51:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6a_6070, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6a_5a70, Data_6a_5b70, Data_6a_5c70 ; frame pointers (continue in body)
	dw Data_6a_5c70 ; $5a61
	dw Data_6a_5c70 ; $5a63
	dw Data_6a_5c70 ; $5a65
	dw Data_6a_5c70 ; $5a67
	dw Data_6a_5d70 ; $5a69
	dw Data_6a_5e70 ; $5a6b
	dw Data_6a_5f70 ; $5a6d
	db $00 ; $5a6f
Data_6a_5a70:
	INCBIN "data/bank_06a/d_5a70.bin" ; $5a70, 256 bytes
Data_6a_5b70:
	INCBIN "data/bank_06a/d_5b70.bin" ; $5b70, 256 bytes
Data_6a_5c70:
	INCBIN "data/bank_06a/d_5c70.bin" ; $5c70, 256 bytes
Data_6a_5d70:
	INCBIN "data/bank_06a/d_5d70.bin" ; $5d70, 256 bytes
Data_6a_5e70:
	INCBIN "data/bank_06a/d_5e70.bin" ; $5e70, 256 bytes
Data_6a_5f70:
	INCBIN "data/bank_06a/d_5f70.bin" ; $5f70, 256 bytes
OamPtrs_6a_6070:
	dw Data_6a_6088 ; $6070
	dw Data_6a_608b ; $6072
	dw Data_6a_6091 ; $6074
	dw Data_6a_609d ; $6076
	dw Data_6a_60a5 ; $6078
	dw Data_6a_60b9 ; $607a
	dw Data_6a_60b9 ; $607c
	dw Data_6a_60be ; $607e
	dw Data_6a_60ca ; $6080
	dw Data_6a_60d0 ; $6082
	dw Data_6a_60d3 ; $6084
	dw Data_6a_60d6 ; $6086
Data_6a_6088:
	INCBIN "data/bank_06a/d_6088.bin" ; $6088, 3 bytes
Data_6a_608b:
	INCBIN "data/bank_06a/d_608b.bin" ; $608b, 6 bytes
Data_6a_6091:
	INCBIN "data/bank_06a/d_6091.bin" ; $6091, 12 bytes
Data_6a_609d:
	INCBIN "data/bank_06a/d_609d.bin" ; $609d, 8 bytes
Data_6a_60a5:
	INCBIN "data/bank_06a/d_60a5.bin" ; $60a5, 20 bytes
Data_6a_60b9:
	INCBIN "data/bank_06a/d_60b9.bin" ; $60b9, 5 bytes
Data_6a_60be:
	INCBIN "data/bank_06a/d_60be.bin" ; $60be, 12 bytes
Data_6a_60ca:
	INCBIN "data/bank_06a/d_60ca.bin" ; $60ca, 6 bytes
Data_6a_60d0:
	INCBIN "data/bank_06a/d_60d0.bin" ; $60d0, 3 bytes
Data_6a_60d3:
	INCBIN "data/bank_06a/d_60d3.bin" ; $60d3, 3 bytes
Data_6a_60d6:
	INCBIN "data/bank_06a/d_60d6.bin" ; $60d6, 11 bytes
	ds 7967, $ff ; $60e1, fill

INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6f", ROMX[$4000], BANK[$6f]

WalkSprites_6f:
	dw Data_6f_4010 ; $4000
	dw Data_6f_46a1 ; $4002
	dw Data_6f_4d31 ; $4004
	dw Data_6f_53c1 ; $4006
	dw Data_6f_5a51 ; $4008
	dw Data_6f_60e1 ; $400a
	dw Data_6f_6771 ; $400c
	dw Data_6f_6e01 ; $400e
Data_6f_4010:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6f_4630, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6f_4030, Data_6f_4130, Data_6f_4230 ; frame pointers (continue in body)
	dw Data_6f_4230 ; $4020
	dw Data_6f_4230 ; $4022
	dw Data_6f_4230 ; $4024
	dw Data_6f_4230 ; $4026
	dw Data_6f_4330 ; $4028
	dw Data_6f_4430 ; $402a
	dw Data_6f_4530 ; $402c
	INCBIN "data/bank_06f/d_402e.bin" ; $402e, 2 bytes
Data_6f_4030:
	INCBIN "data/bank_06f/d_4030.bin" ; $4030, 256 bytes
Data_6f_4130:
	INCBIN "data/bank_06f/d_4130.bin" ; $4130, 256 bytes
Data_6f_4230:
	INCBIN "data/bank_06f/d_4230.bin" ; $4230, 256 bytes
Data_6f_4330:
	INCBIN "data/bank_06f/d_4330.bin" ; $4330, 256 bytes
Data_6f_4430:
	INCBIN "data/bank_06f/d_4430.bin" ; $4430, 256 bytes
Data_6f_4530:
	INCBIN "data/bank_06f/d_4530.bin" ; $4530, 256 bytes
OamPtrs_6f_4630:
	dw Data_6f_4648 ; $4630
	dw Data_6f_464b ; $4632
	dw Data_6f_4651 ; $4634
	dw Data_6f_465d ; $4636
	dw Data_6f_4665 ; $4638
	dw Data_6f_4679 ; $463a
	dw Data_6f_4679 ; $463c
	dw Data_6f_467e ; $463e
	dw Data_6f_468a ; $4640
	dw Data_6f_4690 ; $4642
	dw Data_6f_4693 ; $4644
	dw Data_6f_4696 ; $4646
Data_6f_4648:
	INCBIN "data/bank_06f/d_4648.bin" ; $4648, 3 bytes
Data_6f_464b:
	INCBIN "data/bank_06f/d_464b.bin" ; $464b, 6 bytes
Data_6f_4651:
	INCBIN "data/bank_06f/d_4651.bin" ; $4651, 12 bytes
Data_6f_465d:
	INCBIN "data/bank_06f/d_465d.bin" ; $465d, 8 bytes
Data_6f_4665:
	INCBIN "data/bank_06f/d_4665.bin" ; $4665, 20 bytes
Data_6f_4679:
	INCBIN "data/bank_06f/d_4679.bin" ; $4679, 5 bytes
Data_6f_467e:
	INCBIN "data/bank_06f/d_467e.bin" ; $467e, 12 bytes
Data_6f_468a:
	INCBIN "data/bank_06f/d_468a.bin" ; $468a, 6 bytes
Data_6f_4690:
	INCBIN "data/bank_06f/d_4690.bin" ; $4690, 3 bytes
Data_6f_4693:
	INCBIN "data/bank_06f/d_4693.bin" ; $4693, 3 bytes
Data_6f_4696:
	INCBIN "data/bank_06f/d_4696.bin" ; $4696, 11 bytes
Data_6f_46a1:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6f_4cc0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6f_46c0, Data_6f_47c0, Data_6f_48c0 ; frame pointers (continue in body)
	dw Data_6f_48c0 ; $46b1
	dw Data_6f_48c0 ; $46b3
	dw Data_6f_48c0 ; $46b5
	dw Data_6f_48c0 ; $46b7
	dw Data_6f_49c0 ; $46b9
	dw Data_6f_4ac0 ; $46bb
	dw Data_6f_4bc0 ; $46bd
	INCBIN "data/bank_06f/d_46bf.bin" ; $46bf, 1 bytes
Data_6f_46c0:
	INCBIN "data/bank_06f/d_46c0.bin" ; $46c0, 256 bytes
Data_6f_47c0:
	INCBIN "data/bank_06f/d_47c0.bin" ; $47c0, 256 bytes
Data_6f_48c0:
	INCBIN "data/bank_06f/d_48c0.bin" ; $48c0, 256 bytes
Data_6f_49c0:
	INCBIN "data/bank_06f/d_49c0.bin" ; $49c0, 256 bytes
Data_6f_4ac0:
	INCBIN "data/bank_06f/d_4ac0.bin" ; $4ac0, 256 bytes
Data_6f_4bc0:
	INCBIN "data/bank_06f/d_4bc0.bin" ; $4bc0, 256 bytes
OamPtrs_6f_4cc0:
	dw Data_6f_4cd8 ; $4cc0
	dw Data_6f_4cdb ; $4cc2
	dw Data_6f_4ce1 ; $4cc4
	dw Data_6f_4ced ; $4cc6
	dw Data_6f_4cf5 ; $4cc8
	dw Data_6f_4d09 ; $4cca
	dw Data_6f_4d09 ; $4ccc
	dw Data_6f_4d0e ; $4cce
	dw Data_6f_4d1a ; $4cd0
	dw Data_6f_4d20 ; $4cd2
	dw Data_6f_4d23 ; $4cd4
	dw Data_6f_4d26 ; $4cd6
Data_6f_4cd8:
	INCBIN "data/bank_06f/d_4cd8.bin" ; $4cd8, 3 bytes
Data_6f_4cdb:
	INCBIN "data/bank_06f/d_4cdb.bin" ; $4cdb, 6 bytes
Data_6f_4ce1:
	INCBIN "data/bank_06f/d_4ce1.bin" ; $4ce1, 12 bytes
Data_6f_4ced:
	INCBIN "data/bank_06f/d_4ced.bin" ; $4ced, 8 bytes
Data_6f_4cf5:
	INCBIN "data/bank_06f/d_4cf5.bin" ; $4cf5, 20 bytes
Data_6f_4d09:
	INCBIN "data/bank_06f/d_4d09.bin" ; $4d09, 5 bytes
Data_6f_4d0e:
	INCBIN "data/bank_06f/d_4d0e.bin" ; $4d0e, 12 bytes
Data_6f_4d1a:
	INCBIN "data/bank_06f/d_4d1a.bin" ; $4d1a, 6 bytes
Data_6f_4d20:
	INCBIN "data/bank_06f/d_4d20.bin" ; $4d20, 3 bytes
Data_6f_4d23:
	INCBIN "data/bank_06f/d_4d23.bin" ; $4d23, 3 bytes
Data_6f_4d26:
	INCBIN "data/bank_06f/d_4d26.bin" ; $4d26, 11 bytes
Data_6f_4d31:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6f_5350, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6f_4d50, Data_6f_4e50, Data_6f_4f50 ; frame pointers (continue in body)
	dw Data_6f_4f50 ; $4d41
	dw Data_6f_4f50 ; $4d43
	dw Data_6f_4f50 ; $4d45
	dw Data_6f_4f50 ; $4d47
	dw Data_6f_5050 ; $4d49
	dw Data_6f_5150 ; $4d4b
	dw Data_6f_5250 ; $4d4d
	INCBIN "data/bank_06f/d_4d4f.bin" ; $4d4f, 1 bytes
Data_6f_4d50:
	INCBIN "data/bank_06f/d_4d50.bin" ; $4d50, 256 bytes
Data_6f_4e50:
	INCBIN "data/bank_06f/d_4e50.bin" ; $4e50, 256 bytes
Data_6f_4f50:
	INCBIN "data/bank_06f/d_4f50.bin" ; $4f50, 256 bytes
Data_6f_5050:
	INCBIN "data/bank_06f/d_5050.bin" ; $5050, 256 bytes
Data_6f_5150:
	INCBIN "data/bank_06f/d_5150.bin" ; $5150, 256 bytes
Data_6f_5250:
	INCBIN "data/bank_06f/d_5250.bin" ; $5250, 256 bytes
OamPtrs_6f_5350:
	dw Data_6f_5368 ; $5350
	dw Data_6f_536b ; $5352
	dw Data_6f_5371 ; $5354
	dw Data_6f_537d ; $5356
	dw Data_6f_5385 ; $5358
	dw Data_6f_5399 ; $535a
	dw Data_6f_5399 ; $535c
	dw Data_6f_539e ; $535e
	dw Data_6f_53aa ; $5360
	dw Data_6f_53b0 ; $5362
	dw Data_6f_53b3 ; $5364
	dw Data_6f_53b6 ; $5366
Data_6f_5368:
	INCBIN "data/bank_06f/d_5368.bin" ; $5368, 3 bytes
Data_6f_536b:
	INCBIN "data/bank_06f/d_536b.bin" ; $536b, 6 bytes
Data_6f_5371:
	INCBIN "data/bank_06f/d_5371.bin" ; $5371, 12 bytes
Data_6f_537d:
	INCBIN "data/bank_06f/d_537d.bin" ; $537d, 8 bytes
Data_6f_5385:
	INCBIN "data/bank_06f/d_5385.bin" ; $5385, 20 bytes
Data_6f_5399:
	INCBIN "data/bank_06f/d_5399.bin" ; $5399, 5 bytes
Data_6f_539e:
	INCBIN "data/bank_06f/d_539e.bin" ; $539e, 12 bytes
Data_6f_53aa:
	INCBIN "data/bank_06f/d_53aa.bin" ; $53aa, 6 bytes
Data_6f_53b0:
	INCBIN "data/bank_06f/d_53b0.bin" ; $53b0, 3 bytes
Data_6f_53b3:
	INCBIN "data/bank_06f/d_53b3.bin" ; $53b3, 3 bytes
Data_6f_53b6:
	INCBIN "data/bank_06f/d_53b6.bin" ; $53b6, 11 bytes
Data_6f_53c1:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6f_59e0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6f_53e0, Data_6f_54e0, Data_6f_55e0 ; frame pointers (continue in body)
	dw Data_6f_55e0 ; $53d1
	dw Data_6f_55e0 ; $53d3
	dw Data_6f_55e0 ; $53d5
	dw Data_6f_55e0 ; $53d7
	dw Data_6f_56e0 ; $53d9
	dw Data_6f_57e0 ; $53db
	dw Data_6f_58e0 ; $53dd
	INCBIN "data/bank_06f/d_53df.bin" ; $53df, 1 bytes
Data_6f_53e0:
	INCBIN "data/bank_06f/d_53e0.bin" ; $53e0, 256 bytes
Data_6f_54e0:
	INCBIN "data/bank_06f/d_54e0.bin" ; $54e0, 256 bytes
Data_6f_55e0:
	INCBIN "data/bank_06f/d_55e0.bin" ; $55e0, 256 bytes
Data_6f_56e0:
	INCBIN "data/bank_06f/d_56e0.bin" ; $56e0, 256 bytes
Data_6f_57e0:
	INCBIN "data/bank_06f/d_57e0.bin" ; $57e0, 256 bytes
Data_6f_58e0:
	INCBIN "data/bank_06f/d_58e0.bin" ; $58e0, 256 bytes
OamPtrs_6f_59e0:
	dw Data_6f_59f8 ; $59e0
	dw Data_6f_59fb ; $59e2
	dw Data_6f_5a01 ; $59e4
	dw Data_6f_5a0d ; $59e6
	dw Data_6f_5a15 ; $59e8
	dw Data_6f_5a29 ; $59ea
	dw Data_6f_5a29 ; $59ec
	dw Data_6f_5a2e ; $59ee
	dw Data_6f_5a3a ; $59f0
	dw Data_6f_5a40 ; $59f2
	dw Data_6f_5a43 ; $59f4
	dw Data_6f_5a46 ; $59f6
Data_6f_59f8:
	INCBIN "data/bank_06f/d_59f8.bin" ; $59f8, 3 bytes
Data_6f_59fb:
	INCBIN "data/bank_06f/d_59fb.bin" ; $59fb, 6 bytes
Data_6f_5a01:
	INCBIN "data/bank_06f/d_5a01.bin" ; $5a01, 12 bytes
Data_6f_5a0d:
	INCBIN "data/bank_06f/d_5a0d.bin" ; $5a0d, 8 bytes
Data_6f_5a15:
	INCBIN "data/bank_06f/d_5a15.bin" ; $5a15, 20 bytes
Data_6f_5a29:
	INCBIN "data/bank_06f/d_5a29.bin" ; $5a29, 5 bytes
Data_6f_5a2e:
	INCBIN "data/bank_06f/d_5a2e.bin" ; $5a2e, 12 bytes
Data_6f_5a3a:
	INCBIN "data/bank_06f/d_5a3a.bin" ; $5a3a, 6 bytes
Data_6f_5a40:
	INCBIN "data/bank_06f/d_5a40.bin" ; $5a40, 3 bytes
Data_6f_5a43:
	INCBIN "data/bank_06f/d_5a43.bin" ; $5a43, 3 bytes
Data_6f_5a46:
	INCBIN "data/bank_06f/d_5a46.bin" ; $5a46, 11 bytes
Data_6f_5a51:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6f_6070, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6f_5a70, Data_6f_5b70, Data_6f_5c70 ; frame pointers (continue in body)
	dw Data_6f_5c70 ; $5a61
	dw Data_6f_5c70 ; $5a63
	dw Data_6f_5c70 ; $5a65
	dw Data_6f_5c70 ; $5a67
	dw Data_6f_5d70 ; $5a69
	dw Data_6f_5e70 ; $5a6b
	dw Data_6f_5f70 ; $5a6d
	INCBIN "data/bank_06f/d_5a6f.bin" ; $5a6f, 1 bytes
Data_6f_5a70:
	INCBIN "data/bank_06f/d_5a70.bin" ; $5a70, 256 bytes
Data_6f_5b70:
	INCBIN "data/bank_06f/d_5b70.bin" ; $5b70, 256 bytes
Data_6f_5c70:
	INCBIN "data/bank_06f/d_5c70.bin" ; $5c70, 256 bytes
Data_6f_5d70:
	INCBIN "data/bank_06f/d_5d70.bin" ; $5d70, 256 bytes
Data_6f_5e70:
	INCBIN "data/bank_06f/d_5e70.bin" ; $5e70, 256 bytes
Data_6f_5f70:
	INCBIN "data/bank_06f/d_5f70.bin" ; $5f70, 256 bytes
OamPtrs_6f_6070:
	dw Data_6f_6088 ; $6070
	dw Data_6f_608b ; $6072
	dw Data_6f_6091 ; $6074
	dw Data_6f_609d ; $6076
	dw Data_6f_60a5 ; $6078
	dw Data_6f_60b9 ; $607a
	dw Data_6f_60b9 ; $607c
	dw Data_6f_60be ; $607e
	dw Data_6f_60ca ; $6080
	dw Data_6f_60d0 ; $6082
	dw Data_6f_60d3 ; $6084
	dw Data_6f_60d6 ; $6086
Data_6f_6088:
	INCBIN "data/bank_06f/d_6088.bin" ; $6088, 3 bytes
Data_6f_608b:
	INCBIN "data/bank_06f/d_608b.bin" ; $608b, 6 bytes
Data_6f_6091:
	INCBIN "data/bank_06f/d_6091.bin" ; $6091, 12 bytes
Data_6f_609d:
	INCBIN "data/bank_06f/d_609d.bin" ; $609d, 8 bytes
Data_6f_60a5:
	INCBIN "data/bank_06f/d_60a5.bin" ; $60a5, 20 bytes
Data_6f_60b9:
	INCBIN "data/bank_06f/d_60b9.bin" ; $60b9, 5 bytes
Data_6f_60be:
	INCBIN "data/bank_06f/d_60be.bin" ; $60be, 12 bytes
Data_6f_60ca:
	INCBIN "data/bank_06f/d_60ca.bin" ; $60ca, 6 bytes
Data_6f_60d0:
	INCBIN "data/bank_06f/d_60d0.bin" ; $60d0, 3 bytes
Data_6f_60d3:
	INCBIN "data/bank_06f/d_60d3.bin" ; $60d3, 3 bytes
Data_6f_60d6:
	INCBIN "data/bank_06f/d_60d6.bin" ; $60d6, 11 bytes
Data_6f_60e1:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6f_6700, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6f_6100, Data_6f_6200, Data_6f_6300 ; frame pointers (continue in body)
	dw Data_6f_6300 ; $60f1
	dw Data_6f_6300 ; $60f3
	dw Data_6f_6300 ; $60f5
	dw Data_6f_6300 ; $60f7
	dw Data_6f_6400 ; $60f9
	dw Data_6f_6500 ; $60fb
	dw Data_6f_6600 ; $60fd
	INCBIN "data/bank_06f/d_60ff.bin" ; $60ff, 1 bytes
Data_6f_6100:
	INCBIN "data/bank_06f/d_6100.bin" ; $6100, 256 bytes
Data_6f_6200:
	INCBIN "data/bank_06f/d_6200.bin" ; $6200, 256 bytes
Data_6f_6300:
	INCBIN "data/bank_06f/d_6300.bin" ; $6300, 256 bytes
Data_6f_6400:
	INCBIN "data/bank_06f/d_6400.bin" ; $6400, 256 bytes
Data_6f_6500:
	INCBIN "data/bank_06f/d_6500.bin" ; $6500, 256 bytes
Data_6f_6600:
	INCBIN "data/bank_06f/d_6600.bin" ; $6600, 256 bytes
OamPtrs_6f_6700:
	dw Data_6f_6718 ; $6700
	dw Data_6f_671b ; $6702
	dw Data_6f_6721 ; $6704
	dw Data_6f_672d ; $6706
	dw Data_6f_6735 ; $6708
	dw Data_6f_6749 ; $670a
	dw Data_6f_6749 ; $670c
	dw Data_6f_674e ; $670e
	dw Data_6f_675a ; $6710
	dw Data_6f_6760 ; $6712
	dw Data_6f_6763 ; $6714
	dw Data_6f_6766 ; $6716
Data_6f_6718:
	INCBIN "data/bank_06f/d_6718.bin" ; $6718, 3 bytes
Data_6f_671b:
	INCBIN "data/bank_06f/d_671b.bin" ; $671b, 6 bytes
Data_6f_6721:
	INCBIN "data/bank_06f/d_6721.bin" ; $6721, 12 bytes
Data_6f_672d:
	INCBIN "data/bank_06f/d_672d.bin" ; $672d, 8 bytes
Data_6f_6735:
	INCBIN "data/bank_06f/d_6735.bin" ; $6735, 20 bytes
Data_6f_6749:
	INCBIN "data/bank_06f/d_6749.bin" ; $6749, 5 bytes
Data_6f_674e:
	INCBIN "data/bank_06f/d_674e.bin" ; $674e, 12 bytes
Data_6f_675a:
	INCBIN "data/bank_06f/d_675a.bin" ; $675a, 6 bytes
Data_6f_6760:
	INCBIN "data/bank_06f/d_6760.bin" ; $6760, 3 bytes
Data_6f_6763:
	INCBIN "data/bank_06f/d_6763.bin" ; $6763, 3 bytes
Data_6f_6766:
	INCBIN "data/bank_06f/d_6766.bin" ; $6766, 11 bytes
Data_6f_6771:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6f_6d90, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6f_6790, Data_6f_6890, Data_6f_6990 ; frame pointers (continue in body)
	dw Data_6f_6990 ; $6781
	dw Data_6f_6990 ; $6783
	dw Data_6f_6990 ; $6785
	dw Data_6f_6990 ; $6787
	dw Data_6f_6a90 ; $6789
	dw Data_6f_6b90 ; $678b
	dw Data_6f_6c90 ; $678d
	INCBIN "data/bank_06f/d_678f.bin" ; $678f, 1 bytes
Data_6f_6790:
	INCBIN "data/bank_06f/d_6790.bin" ; $6790, 256 bytes
Data_6f_6890:
	INCBIN "data/bank_06f/d_6890.bin" ; $6890, 256 bytes
Data_6f_6990:
	INCBIN "data/bank_06f/d_6990.bin" ; $6990, 256 bytes
Data_6f_6a90:
	INCBIN "data/bank_06f/d_6a90.bin" ; $6a90, 256 bytes
Data_6f_6b90:
	INCBIN "data/bank_06f/d_6b90.bin" ; $6b90, 256 bytes
Data_6f_6c90:
	INCBIN "data/bank_06f/d_6c90.bin" ; $6c90, 256 bytes
OamPtrs_6f_6d90:
	dw Data_6f_6da8 ; $6d90
	dw Data_6f_6dab ; $6d92
	dw Data_6f_6db1 ; $6d94
	dw Data_6f_6dbd ; $6d96
	dw Data_6f_6dc5 ; $6d98
	dw Data_6f_6dd9 ; $6d9a
	dw Data_6f_6dd9 ; $6d9c
	dw Data_6f_6dde ; $6d9e
	dw Data_6f_6dea ; $6da0
	dw Data_6f_6df0 ; $6da2
	dw Data_6f_6df3 ; $6da4
	dw Data_6f_6df6 ; $6da6
Data_6f_6da8:
	INCBIN "data/bank_06f/d_6da8.bin" ; $6da8, 3 bytes
Data_6f_6dab:
	INCBIN "data/bank_06f/d_6dab.bin" ; $6dab, 6 bytes
Data_6f_6db1:
	INCBIN "data/bank_06f/d_6db1.bin" ; $6db1, 12 bytes
Data_6f_6dbd:
	INCBIN "data/bank_06f/d_6dbd.bin" ; $6dbd, 8 bytes
Data_6f_6dc5:
	INCBIN "data/bank_06f/d_6dc5.bin" ; $6dc5, 20 bytes
Data_6f_6dd9:
	INCBIN "data/bank_06f/d_6dd9.bin" ; $6dd9, 5 bytes
Data_6f_6dde:
	INCBIN "data/bank_06f/d_6dde.bin" ; $6dde, 12 bytes
Data_6f_6dea:
	INCBIN "data/bank_06f/d_6dea.bin" ; $6dea, 6 bytes
Data_6f_6df0:
	INCBIN "data/bank_06f/d_6df0.bin" ; $6df0, 3 bytes
Data_6f_6df3:
	INCBIN "data/bank_06f/d_6df3.bin" ; $6df3, 3 bytes
Data_6f_6df6:
	INCBIN "data/bank_06f/d_6df6.bin" ; $6df6, 11 bytes
Data_6f_6e01:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_6f_7420, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_6f_6e20, Data_6f_6f20, Data_6f_7020 ; frame pointers (continue in body)
	dw Data_6f_7020 ; $6e11
	dw Data_6f_7020 ; $6e13
	dw Data_6f_7020 ; $6e15
	dw Data_6f_7020 ; $6e17
	dw Data_6f_7120 ; $6e19
	dw Data_6f_7220 ; $6e1b
	dw Data_6f_7320 ; $6e1d
	INCBIN "data/bank_06f/d_6e1f.bin" ; $6e1f, 1 bytes
Data_6f_6e20:
	INCBIN "data/bank_06f/d_6e20.bin" ; $6e20, 256 bytes
Data_6f_6f20:
	INCBIN "data/bank_06f/d_6f20.bin" ; $6f20, 256 bytes
Data_6f_7020:
	INCBIN "data/bank_06f/d_7020.bin" ; $7020, 256 bytes
Data_6f_7120:
	INCBIN "data/bank_06f/d_7120.bin" ; $7120, 256 bytes
Data_6f_7220:
	INCBIN "data/bank_06f/d_7220.bin" ; $7220, 256 bytes
Data_6f_7320:
	INCBIN "data/bank_06f/d_7320.bin" ; $7320, 256 bytes
OamPtrs_6f_7420:
	dw Data_6f_7438 ; $7420
	dw Data_6f_743b ; $7422
	dw Data_6f_7441 ; $7424
	dw Data_6f_744d ; $7426
	dw Data_6f_7455 ; $7428
	dw Data_6f_7469 ; $742a
	dw Data_6f_7469 ; $742c
	dw Data_6f_746e ; $742e
	dw Data_6f_747a ; $7430
	dw Data_6f_7480 ; $7432
	dw Data_6f_7483 ; $7434
	dw Data_6f_7486 ; $7436
Data_6f_7438:
	INCBIN "data/bank_06f/d_7438.bin" ; $7438, 3 bytes
Data_6f_743b:
	INCBIN "data/bank_06f/d_743b.bin" ; $743b, 6 bytes
Data_6f_7441:
	INCBIN "data/bank_06f/d_7441.bin" ; $7441, 12 bytes
Data_6f_744d:
	INCBIN "data/bank_06f/d_744d.bin" ; $744d, 8 bytes
Data_6f_7455:
	INCBIN "data/bank_06f/d_7455.bin" ; $7455, 20 bytes
Data_6f_7469:
	INCBIN "data/bank_06f/d_7469.bin" ; $7469, 5 bytes
Data_6f_746e:
	INCBIN "data/bank_06f/d_746e.bin" ; $746e, 12 bytes
Data_6f_747a:
	INCBIN "data/bank_06f/d_747a.bin" ; $747a, 6 bytes
Data_6f_7480:
	INCBIN "data/bank_06f/d_7480.bin" ; $7480, 3 bytes
Data_6f_7483:
	INCBIN "data/bank_06f/d_7483.bin" ; $7483, 3 bytes
Data_6f_7486:
	INCBIN "data/bank_06f/d_7486.bin" ; $7486, 11 bytes
	ds 2927, $ff ; $7491, fill

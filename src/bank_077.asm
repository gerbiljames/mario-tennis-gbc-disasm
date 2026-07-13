SECTION "ROM Bank $77", ROMX[$4000], BANK[$77]

WalkSprites_77:
	dw Data_77_4010 ; $4000
	dw Data_77_4895 ; $4002
	dw Data_77_5115 ; $4004
	dw Data_77_5995 ; $4006
	dw Data_77_6031 ; $4008
	dw Data_77_66c1 ; $400a
	dw Data_77_6d51 ; $400c
	dw Data_77_73e1 ; $400e
Data_77_4010:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_77_4840, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_77_4040, Data_77_4140, Data_77_4240 ; frame pointers (continue in body)
	dw Data_77_4240 ; $4020
	dw Data_77_4240 ; $4022
	dw Data_77_4240 ; $4024
	dw Data_77_4240 ; $4026
	dw Data_77_4340 ; $4028
	dw Data_77_4440 ; $402a
	dw Data_77_4540 ; $402c
	dw Data_77_4640 ; $402e
	dw Data_77_4640 ; $4030
	dw Data_77_4740 ; $4032
	INCBIN "data/bank_077/d_4034.bin" ; $4034, 12 bytes
Data_77_4040:
	INCBIN "data/bank_077/d_4040.bin" ; $4040, 256 bytes
Data_77_4140:
	INCBIN "data/bank_077/d_4140.bin" ; $4140, 256 bytes
Data_77_4240:
	INCBIN "data/bank_077/d_4240.bin" ; $4240, 256 bytes
Data_77_4340:
	INCBIN "data/bank_077/d_4340.bin" ; $4340, 256 bytes
Data_77_4440:
	INCBIN "data/bank_077/d_4440.bin" ; $4440, 256 bytes
Data_77_4540:
	INCBIN "data/bank_077/d_4540.bin" ; $4540, 256 bytes
Data_77_4640:
	INCBIN "data/bank_077/d_4640.bin" ; $4640, 256 bytes
Data_77_4740:
	INCBIN "data/bank_077/d_4740.bin" ; $4740, 256 bytes
OamPtrs_77_4840:
	dw Data_77_4852 ; $4840
	dw Data_77_4855 ; $4842
	dw Data_77_485b ; $4844
	dw Data_77_4867 ; $4846
	dw Data_77_486f ; $4848
	dw Data_77_4883 ; $484a
	dw Data_77_4883 ; $484c
	dw Data_77_4883 ; $484e
	dw Data_77_488f ; $4850
Data_77_4852:
	INCBIN "data/bank_077/d_4852.bin" ; $4852, 3 bytes
Data_77_4855:
	INCBIN "data/bank_077/d_4855.bin" ; $4855, 6 bytes
Data_77_485b:
	INCBIN "data/bank_077/d_485b.bin" ; $485b, 12 bytes
Data_77_4867:
	INCBIN "data/bank_077/d_4867.bin" ; $4867, 8 bytes
Data_77_486f:
	INCBIN "data/bank_077/d_486f.bin" ; $486f, 20 bytes
Data_77_4883:
	INCBIN "data/bank_077/d_4883.bin" ; $4883, 12 bytes
Data_77_488f:
	INCBIN "data/bank_077/d_488f.bin" ; $488f, 6 bytes
Data_77_4895:
	db $04, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_77_50c0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_77_48c0, Data_77_49c0, Data_77_4ac0 ; frame pointers (continue in body)
	dw Data_77_4ac0 ; $48a5
	dw Data_77_4ac0 ; $48a7
	dw Data_77_4ac0 ; $48a9
	dw Data_77_4ac0 ; $48ab
	dw Data_77_4bc0 ; $48ad
	dw Data_77_4cc0 ; $48af
	dw Data_77_4dc0 ; $48b1
	dw Data_77_4ec0 ; $48b3
	dw Data_77_4ec0 ; $48b5
	dw Data_77_4fc0 ; $48b7
	INCBIN "data/bank_077/d_48b9.bin" ; $48b9, 7 bytes
Data_77_48c0:
	INCBIN "data/bank_077/d_48c0.bin" ; $48c0, 256 bytes
Data_77_49c0:
	INCBIN "data/bank_077/d_49c0.bin" ; $49c0, 256 bytes
Data_77_4ac0:
	INCBIN "data/bank_077/d_4ac0.bin" ; $4ac0, 256 bytes
Data_77_4bc0:
	INCBIN "data/bank_077/d_4bc0.bin" ; $4bc0, 256 bytes
Data_77_4cc0:
	INCBIN "data/bank_077/d_4cc0.bin" ; $4cc0, 256 bytes
Data_77_4dc0:
	INCBIN "data/bank_077/d_4dc0.bin" ; $4dc0, 256 bytes
Data_77_4ec0:
	INCBIN "data/bank_077/d_4ec0.bin" ; $4ec0, 256 bytes
Data_77_4fc0:
	INCBIN "data/bank_077/d_4fc0.bin" ; $4fc0, 256 bytes
OamPtrs_77_50c0:
	dw Data_77_50d2 ; $50c0
	dw Data_77_50d5 ; $50c2
	dw Data_77_50db ; $50c4
	dw Data_77_50e7 ; $50c6
	dw Data_77_50ef ; $50c8
	dw Data_77_5103 ; $50ca
	dw Data_77_5103 ; $50cc
	dw Data_77_5103 ; $50ce
	dw Data_77_510f ; $50d0
Data_77_50d2:
	INCBIN "data/bank_077/d_50d2.bin" ; $50d2, 3 bytes
Data_77_50d5:
	INCBIN "data/bank_077/d_50d5.bin" ; $50d5, 6 bytes
Data_77_50db:
	INCBIN "data/bank_077/d_50db.bin" ; $50db, 12 bytes
Data_77_50e7:
	INCBIN "data/bank_077/d_50e7.bin" ; $50e7, 8 bytes
Data_77_50ef:
	INCBIN "data/bank_077/d_50ef.bin" ; $50ef, 20 bytes
Data_77_5103:
	INCBIN "data/bank_077/d_5103.bin" ; $5103, 12 bytes
Data_77_510f:
	INCBIN "data/bank_077/d_510f.bin" ; $510f, 6 bytes
Data_77_5115:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_77_5940, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_77_5140, Data_77_5240, Data_77_5340 ; frame pointers (continue in body)
	dw Data_77_5340 ; $5125
	dw Data_77_5340 ; $5127
	dw Data_77_5340 ; $5129
	dw Data_77_5340 ; $512b
	dw Data_77_5440 ; $512d
	dw Data_77_5540 ; $512f
	dw Data_77_5640 ; $5131
	dw Data_77_5740 ; $5133
	dw Data_77_5740 ; $5135
	dw Data_77_5840 ; $5137
	INCBIN "data/bank_077/d_5139.bin" ; $5139, 7 bytes
Data_77_5140:
	INCBIN "data/bank_077/d_5140.bin" ; $5140, 256 bytes
Data_77_5240:
	INCBIN "data/bank_077/d_5240.bin" ; $5240, 256 bytes
Data_77_5340:
	INCBIN "data/bank_077/d_5340.bin" ; $5340, 256 bytes
Data_77_5440:
	INCBIN "data/bank_077/d_5440.bin" ; $5440, 256 bytes
Data_77_5540:
	INCBIN "data/bank_077/d_5540.bin" ; $5540, 256 bytes
Data_77_5640:
	INCBIN "data/bank_077/d_5640.bin" ; $5640, 256 bytes
Data_77_5740:
	INCBIN "data/bank_077/d_5740.bin" ; $5740, 256 bytes
Data_77_5840:
	INCBIN "data/bank_077/d_5840.bin" ; $5840, 256 bytes
OamPtrs_77_5940:
	dw Data_77_5952 ; $5940
	dw Data_77_5955 ; $5942
	dw Data_77_595b ; $5944
	dw Data_77_5967 ; $5946
	dw Data_77_596f ; $5948
	dw Data_77_5983 ; $594a
	dw Data_77_5983 ; $594c
	dw Data_77_5983 ; $594e
	dw Data_77_598f ; $5950
Data_77_5952:
	INCBIN "data/bank_077/d_5952.bin" ; $5952, 3 bytes
Data_77_5955:
	INCBIN "data/bank_077/d_5955.bin" ; $5955, 6 bytes
Data_77_595b:
	INCBIN "data/bank_077/d_595b.bin" ; $595b, 12 bytes
Data_77_5967:
	INCBIN "data/bank_077/d_5967.bin" ; $5967, 8 bytes
Data_77_596f:
	INCBIN "data/bank_077/d_596f.bin" ; $596f, 20 bytes
Data_77_5983:
	INCBIN "data/bank_077/d_5983.bin" ; $5983, 12 bytes
Data_77_598f:
	INCBIN "data/bank_077/d_598f.bin" ; $598f, 6 bytes
Data_77_5995:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_77_5fc0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_77_59c0, Data_77_5ac0, Data_77_5bc0 ; frame pointers (continue in body)
	dw Data_77_5bc0 ; $59a5
	dw Data_77_5bc0 ; $59a7
	dw Data_77_5bc0 ; $59a9
	dw Data_77_5bc0 ; $59ab
	dw Data_77_5cc0 ; $59ad
	dw Data_77_5dc0 ; $59af
	dw Data_77_5ec0 ; $59b1
	INCBIN "data/bank_077/d_59b3.bin" ; $59b3, 13 bytes
Data_77_59c0:
	INCBIN "data/bank_077/d_59c0.bin" ; $59c0, 256 bytes
Data_77_5ac0:
	INCBIN "data/bank_077/d_5ac0.bin" ; $5ac0, 256 bytes
Data_77_5bc0:
	INCBIN "data/bank_077/d_5bc0.bin" ; $5bc0, 256 bytes
Data_77_5cc0:
	INCBIN "data/bank_077/d_5cc0.bin" ; $5cc0, 256 bytes
Data_77_5dc0:
	INCBIN "data/bank_077/d_5dc0.bin" ; $5dc0, 256 bytes
Data_77_5ec0:
	INCBIN "data/bank_077/d_5ec0.bin" ; $5ec0, 256 bytes
OamPtrs_77_5fc0:
	dw Data_77_5fd8 ; $5fc0
	dw Data_77_5fdb ; $5fc2
	dw Data_77_5fe1 ; $5fc4
	dw Data_77_5fed ; $5fc6
	dw Data_77_5ff5 ; $5fc8
	dw Data_77_6009 ; $5fca
	dw Data_77_6009 ; $5fcc
	dw Data_77_600e ; $5fce
	dw Data_77_601a ; $5fd0
	dw Data_77_6020 ; $5fd2
	dw Data_77_6023 ; $5fd4
	dw Data_77_6026 ; $5fd6
Data_77_5fd8:
	INCBIN "data/bank_077/d_5fd8.bin" ; $5fd8, 3 bytes
Data_77_5fdb:
	INCBIN "data/bank_077/d_5fdb.bin" ; $5fdb, 6 bytes
Data_77_5fe1:
	INCBIN "data/bank_077/d_5fe1.bin" ; $5fe1, 12 bytes
Data_77_5fed:
	INCBIN "data/bank_077/d_5fed.bin" ; $5fed, 8 bytes
Data_77_5ff5:
	INCBIN "data/bank_077/d_5ff5.bin" ; $5ff5, 20 bytes
Data_77_6009:
	INCBIN "data/bank_077/d_6009.bin" ; $6009, 5 bytes
Data_77_600e:
	INCBIN "data/bank_077/d_600e.bin" ; $600e, 12 bytes
Data_77_601a:
	INCBIN "data/bank_077/d_601a.bin" ; $601a, 6 bytes
Data_77_6020:
	INCBIN "data/bank_077/d_6020.bin" ; $6020, 3 bytes
Data_77_6023:
	INCBIN "data/bank_077/d_6023.bin" ; $6023, 3 bytes
Data_77_6026:
	INCBIN "data/bank_077/d_6026.bin" ; $6026, 11 bytes
Data_77_6031:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_77_6650, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_77_6050, Data_77_6150, Data_77_6250 ; frame pointers (continue in body)
	dw Data_77_6250 ; $6041
	dw Data_77_6250 ; $6043
	dw Data_77_6250 ; $6045
	dw Data_77_6250 ; $6047
	dw Data_77_6350 ; $6049
	dw Data_77_6450 ; $604b
	dw Data_77_6550 ; $604d
	db $00 ; $604f
Data_77_6050:
	INCBIN "data/bank_077/d_6050.bin" ; $6050, 256 bytes
Data_77_6150:
	INCBIN "data/bank_077/d_6150.bin" ; $6150, 256 bytes
Data_77_6250:
	INCBIN "data/bank_077/d_6250.bin" ; $6250, 256 bytes
Data_77_6350:
	INCBIN "data/bank_077/d_6350.bin" ; $6350, 256 bytes
Data_77_6450:
	INCBIN "data/bank_077/d_6450.bin" ; $6450, 256 bytes
Data_77_6550:
	INCBIN "data/bank_077/d_6550.bin" ; $6550, 256 bytes
OamPtrs_77_6650:
	dw Data_77_6668 ; $6650
	dw Data_77_666b ; $6652
	dw Data_77_6671 ; $6654
	dw Data_77_667d ; $6656
	dw Data_77_6685 ; $6658
	dw Data_77_6699 ; $665a
	dw Data_77_6699 ; $665c
	dw Data_77_669e ; $665e
	dw Data_77_66aa ; $6660
	dw Data_77_66b0 ; $6662
	dw Data_77_66b3 ; $6664
	dw Data_77_66b6 ; $6666
Data_77_6668:
	INCBIN "data/bank_077/d_6668.bin" ; $6668, 3 bytes
Data_77_666b:
	INCBIN "data/bank_077/d_666b.bin" ; $666b, 6 bytes
Data_77_6671:
	INCBIN "data/bank_077/d_6671.bin" ; $6671, 12 bytes
Data_77_667d:
	INCBIN "data/bank_077/d_667d.bin" ; $667d, 8 bytes
Data_77_6685:
	INCBIN "data/bank_077/d_6685.bin" ; $6685, 20 bytes
Data_77_6699:
	INCBIN "data/bank_077/d_6699.bin" ; $6699, 5 bytes
Data_77_669e:
	INCBIN "data/bank_077/d_669e.bin" ; $669e, 12 bytes
Data_77_66aa:
	INCBIN "data/bank_077/d_66aa.bin" ; $66aa, 6 bytes
Data_77_66b0:
	INCBIN "data/bank_077/d_66b0.bin" ; $66b0, 3 bytes
Data_77_66b3:
	INCBIN "data/bank_077/d_66b3.bin" ; $66b3, 3 bytes
Data_77_66b6:
	INCBIN "data/bank_077/d_66b6.bin" ; $66b6, 11 bytes
Data_77_66c1:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_77_6ce0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_77_66e0, Data_77_67e0, Data_77_68e0 ; frame pointers (continue in body)
	dw Data_77_68e0 ; $66d1
	dw Data_77_68e0 ; $66d3
	dw Data_77_68e0 ; $66d5
	dw Data_77_68e0 ; $66d7
	dw Data_77_69e0 ; $66d9
	dw Data_77_6ae0 ; $66db
	dw Data_77_6be0 ; $66dd
	db $00 ; $66df
Data_77_66e0:
	INCBIN "data/bank_077/d_66e0.bin" ; $66e0, 256 bytes
Data_77_67e0:
	INCBIN "data/bank_077/d_67e0.bin" ; $67e0, 256 bytes
Data_77_68e0:
	INCBIN "data/bank_077/d_68e0.bin" ; $68e0, 256 bytes
Data_77_69e0:
	INCBIN "data/bank_077/d_69e0.bin" ; $69e0, 256 bytes
Data_77_6ae0:
	INCBIN "data/bank_077/d_6ae0.bin" ; $6ae0, 256 bytes
Data_77_6be0:
	INCBIN "data/bank_077/d_6be0.bin" ; $6be0, 256 bytes
OamPtrs_77_6ce0:
	dw Data_77_6cf8 ; $6ce0
	dw Data_77_6cfb ; $6ce2
	dw Data_77_6d01 ; $6ce4
	dw Data_77_6d0d ; $6ce6
	dw Data_77_6d15 ; $6ce8
	dw Data_77_6d29 ; $6cea
	dw Data_77_6d29 ; $6cec
	dw Data_77_6d2e ; $6cee
	dw Data_77_6d3a ; $6cf0
	dw Data_77_6d40 ; $6cf2
	dw Data_77_6d43 ; $6cf4
	dw Data_77_6d46 ; $6cf6
Data_77_6cf8:
	INCBIN "data/bank_077/d_6cf8.bin" ; $6cf8, 3 bytes
Data_77_6cfb:
	INCBIN "data/bank_077/d_6cfb.bin" ; $6cfb, 6 bytes
Data_77_6d01:
	INCBIN "data/bank_077/d_6d01.bin" ; $6d01, 12 bytes
Data_77_6d0d:
	INCBIN "data/bank_077/d_6d0d.bin" ; $6d0d, 8 bytes
Data_77_6d15:
	INCBIN "data/bank_077/d_6d15.bin" ; $6d15, 20 bytes
Data_77_6d29:
	INCBIN "data/bank_077/d_6d29.bin" ; $6d29, 5 bytes
Data_77_6d2e:
	INCBIN "data/bank_077/d_6d2e.bin" ; $6d2e, 12 bytes
Data_77_6d3a:
	INCBIN "data/bank_077/d_6d3a.bin" ; $6d3a, 6 bytes
Data_77_6d40:
	INCBIN "data/bank_077/d_6d40.bin" ; $6d40, 3 bytes
Data_77_6d43:
	INCBIN "data/bank_077/d_6d43.bin" ; $6d43, 3 bytes
Data_77_6d46:
	INCBIN "data/bank_077/d_6d46.bin" ; $6d46, 11 bytes
Data_77_6d51:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_77_7370, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_77_6d70, Data_77_6e70, Data_77_6f70 ; frame pointers (continue in body)
	dw Data_77_6f70 ; $6d61
	dw Data_77_6f70 ; $6d63
	dw Data_77_6f70 ; $6d65
	dw Data_77_6f70 ; $6d67
	dw Data_77_7070 ; $6d69
	dw Data_77_7170 ; $6d6b
	dw Data_77_7270 ; $6d6d
	db $00 ; $6d6f
Data_77_6d70:
	INCBIN "data/bank_077/d_6d70.bin" ; $6d70, 256 bytes
Data_77_6e70:
	INCBIN "data/bank_077/d_6e70.bin" ; $6e70, 256 bytes
Data_77_6f70:
	INCBIN "data/bank_077/d_6f70.bin" ; $6f70, 256 bytes
Data_77_7070:
	INCBIN "data/bank_077/d_7070.bin" ; $7070, 256 bytes
Data_77_7170:
	INCBIN "data/bank_077/d_7170.bin" ; $7170, 256 bytes
Data_77_7270:
	INCBIN "data/bank_077/d_7270.bin" ; $7270, 256 bytes
OamPtrs_77_7370:
	dw Data_77_7388 ; $7370
	dw Data_77_738b ; $7372
	dw Data_77_7391 ; $7374
	dw Data_77_739d ; $7376
	dw Data_77_73a5 ; $7378
	dw Data_77_73b9 ; $737a
	dw Data_77_73b9 ; $737c
	dw Data_77_73be ; $737e
	dw Data_77_73ca ; $7380
	dw Data_77_73d0 ; $7382
	dw Data_77_73d3 ; $7384
	dw Data_77_73d6 ; $7386
Data_77_7388:
	INCBIN "data/bank_077/d_7388.bin" ; $7388, 3 bytes
Data_77_738b:
	INCBIN "data/bank_077/d_738b.bin" ; $738b, 6 bytes
Data_77_7391:
	INCBIN "data/bank_077/d_7391.bin" ; $7391, 12 bytes
Data_77_739d:
	INCBIN "data/bank_077/d_739d.bin" ; $739d, 8 bytes
Data_77_73a5:
	INCBIN "data/bank_077/d_73a5.bin" ; $73a5, 20 bytes
Data_77_73b9:
	INCBIN "data/bank_077/d_73b9.bin" ; $73b9, 5 bytes
Data_77_73be:
	INCBIN "data/bank_077/d_73be.bin" ; $73be, 12 bytes
Data_77_73ca:
	INCBIN "data/bank_077/d_73ca.bin" ; $73ca, 6 bytes
Data_77_73d0:
	INCBIN "data/bank_077/d_73d0.bin" ; $73d0, 3 bytes
Data_77_73d3:
	INCBIN "data/bank_077/d_73d3.bin" ; $73d3, 3 bytes
Data_77_73d6:
	INCBIN "data/bank_077/d_73d6.bin" ; $73d6, 11 bytes
Data_77_73e1:
	db $05, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_77_7590, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_77_7410, Data_77_7450, Data_77_7490 ; frame pointers (continue in body)
	dw Data_77_74d0 ; $73f1
	dw Data_77_7510 ; $73f3
	dw Data_77_7510 ; $73f5
	dw Data_77_7510 ; $73f7
	dw Data_77_7510 ; $73f9
	dw Data_77_7510 ; $73fb
	dw Data_77_7510 ; $73fd
	dw Data_77_7510 ; $73ff
	dw Data_77_7510 ; $7401
	dw Data_77_7550 ; $7403
	INCBIN "data/bank_077/d_7405.bin" ; $7405, 11 bytes
Data_77_7410:
	INCBIN "data/bank_077/d_7410.bin" ; $7410, 64 bytes
Data_77_7450:
	INCBIN "data/bank_077/d_7450.bin" ; $7450, 64 bytes
Data_77_7490:
	INCBIN "data/bank_077/d_7490.bin" ; $7490, 64 bytes
Data_77_74d0:
	INCBIN "data/bank_077/d_74d0.bin" ; $74d0, 64 bytes
Data_77_7510:
	INCBIN "data/bank_077/d_7510.bin" ; $7510, 64 bytes
Data_77_7550:
	INCBIN "data/bank_077/d_7550.bin" ; $7550, 64 bytes
OamPtrs_77_7590:
	dw Data_77_75a2 ; $7590
	dw Data_77_75a5 ; $7592
	dw Data_77_75ab ; $7594
	dw Data_77_75ab ; $7596
	dw Data_77_75ab ; $7598
	dw Data_77_75ab ; $759a
	dw Data_77_75ab ; $759c
	dw Data_77_75b1 ; $759e
	dw Data_77_75b4 ; $75a0
Data_77_75a2:
	INCBIN "data/bank_077/d_75a2.bin" ; $75a2, 3 bytes
Data_77_75a5:
	INCBIN "data/bank_077/d_75a5.bin" ; $75a5, 6 bytes
Data_77_75ab:
	INCBIN "data/bank_077/d_75ab.bin" ; $75ab, 6 bytes
Data_77_75b1:
	INCBIN "data/bank_077/d_75b1.bin" ; $75b1, 3 bytes
Data_77_75b4:
	INCBIN "data/bank_077/d_75b4.bin" ; $75b4, 6 bytes
	ds 2630, $ff ; $75ba, fill

INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $73", ROMX[$4000], BANK[$73]

DataPtr_73_00:
	dw Data_73_4028 ; $4000
DataPtr_73_02:
	dw Data_73_469d ; $4002
DataPtr_73_04:
	dw Data_73_4d0d ; $4004
DataPtr_73_06:
	dw Data_73_4efd ; $4006
DataPtr_73_08:
	dw Data_73_50ed ; $4008
DataPtr_73_0a:
	dw Data_73_52dd ; $400a
DataPtr_73_0c:
	dw Data_73_54cd ; $400c
DataPtr_73_0e:
	dw Data_73_5701 ; $400e
DataPtr_73_10:
	dw Data_73_593f ; $4010
DataPtr_73_12:
	dw Data_73_5fad ; $4012
DataPtr_73_14:
	dw Data_73_6835 ; $4014
DataPtr_73_16:
	dw Data_73_6ead ; $4016
DataPtr_73_18:
	dw Data_73_751d ; $4018
DataPtr_73_1a:
	dw Data_73_75bd ; $401a
DataPtr_73_1c:
	dw Data_73_765d ; $401c
DataPtr_73_1e:
	dw Data_73_784d ; $401e
DataPtr_73_20:
	dw Data_73_78ed ; $4020
DataPtr_73_22:
	dw Data_73_798d ; $4022
DataPtr_73_24:
	dw Data_73_7a2d ; $4024
DataPtr_73_26:
	dw Data_73_7acd ; $4026
Data_73_4028:
	db $03, $04, $02, $00 ; count, flags
	dw $4032, OamPtrs_73_4650, $4032, Data_73_4050, Data_73_4150, Data_73_4250 ; body pointers
	INCBIN "data/bank_073/d_4038.bin" ; $4038, 24 bytes
Data_73_4050:
	INCBIN "data/bank_073/d_4050.bin" ; $4050, 256 bytes
Data_73_4150:
	INCBIN "data/bank_073/d_4150.bin" ; $4150, 256 bytes
Data_73_4250:
	INCBIN "data/bank_073/d_4250.bin" ; $4250, 1024 bytes
OamPtrs_73_4650:
	dw Data_73_4660 ; $4650
	dw Data_73_4663 ; $4652
	dw Data_73_4669 ; $4654
	dw Data_73_4675 ; $4656
	dw Data_73_467d ; $4658
	dw Data_73_4691 ; $465a
	dw Data_73_4691 ; $465c
	dw Data_73_4691 ; $465e
Data_73_4660:
	INCBIN "data/bank_073/d_4660.bin" ; $4660, 3 bytes
Data_73_4663:
	INCBIN "data/bank_073/d_4663.bin" ; $4663, 6 bytes
Data_73_4669:
	INCBIN "data/bank_073/d_4669.bin" ; $4669, 12 bytes
Data_73_4675:
	INCBIN "data/bank_073/d_4675.bin" ; $4675, 8 bytes
Data_73_467d:
	INCBIN "data/bank_073/d_467d.bin" ; $467d, 20 bytes
Data_73_4691:
	INCBIN "data/bank_073/d_4691.bin" ; $4691, 12 bytes
Data_73_469d:
	db $07, $04, $02, $00 ; count, flags
	dw $46a7, OamPtrs_73_4cc0, $46a7, Data_73_46c0, Data_73_47c0, Data_73_48c0 ; body pointers
	INCBIN "data/bank_073/d_46ad.bin" ; $46ad, 19 bytes
Data_73_46c0:
	INCBIN "data/bank_073/d_46c0.bin" ; $46c0, 256 bytes
Data_73_47c0:
	INCBIN "data/bank_073/d_47c0.bin" ; $47c0, 256 bytes
Data_73_48c0:
	INCBIN "data/bank_073/d_48c0.bin" ; $48c0, 1024 bytes
OamPtrs_73_4cc0:
	dw Data_73_4cd0 ; $4cc0
	dw Data_73_4cd3 ; $4cc2
	dw Data_73_4cd9 ; $4cc4
	dw Data_73_4ce5 ; $4cc6
	dw Data_73_4ced ; $4cc8
	dw Data_73_4d01 ; $4cca
	dw Data_73_4d01 ; $4ccc
	dw Data_73_4d01 ; $4cce
Data_73_4cd0:
	INCBIN "data/bank_073/d_4cd0.bin" ; $4cd0, 3 bytes
Data_73_4cd3:
	INCBIN "data/bank_073/d_4cd3.bin" ; $4cd3, 6 bytes
Data_73_4cd9:
	INCBIN "data/bank_073/d_4cd9.bin" ; $4cd9, 12 bytes
Data_73_4ce5:
	INCBIN "data/bank_073/d_4ce5.bin" ; $4ce5, 8 bytes
Data_73_4ced:
	INCBIN "data/bank_073/d_4ced.bin" ; $4ced, 20 bytes
Data_73_4d01:
	INCBIN "data/bank_073/d_4d01.bin" ; $4d01, 12 bytes
Data_73_4d0d:
	db $03, $01, $02, $00 ; count, flags
	dw $4d17, OamPtrs_73_4eb0, $4d17, Data_73_4d30, Data_73_4d70, Data_73_4db0 ; body pointers
	INCBIN "data/bank_073/d_4d1d.bin" ; $4d1d, 19 bytes
Data_73_4d30:
	INCBIN "data/bank_073/d_4d30.bin" ; $4d30, 64 bytes
Data_73_4d70:
	INCBIN "data/bank_073/d_4d70.bin" ; $4d70, 64 bytes
Data_73_4db0:
	INCBIN "data/bank_073/d_4db0.bin" ; $4db0, 256 bytes
OamPtrs_73_4eb0:
	dw Data_73_4ec0 ; $4eb0
	dw Data_73_4ec3 ; $4eb2
	dw Data_73_4ec9 ; $4eb4
	dw Data_73_4ed5 ; $4eb6
	dw Data_73_4edd ; $4eb8
	dw Data_73_4ef1 ; $4eba
	dw Data_73_4ef1 ; $4ebc
	dw Data_73_4ef1 ; $4ebe
Data_73_4ec0:
	INCBIN "data/bank_073/d_4ec0.bin" ; $4ec0, 3 bytes
Data_73_4ec3:
	INCBIN "data/bank_073/d_4ec3.bin" ; $4ec3, 6 bytes
Data_73_4ec9:
	INCBIN "data/bank_073/d_4ec9.bin" ; $4ec9, 12 bytes
Data_73_4ed5:
	INCBIN "data/bank_073/d_4ed5.bin" ; $4ed5, 8 bytes
Data_73_4edd:
	INCBIN "data/bank_073/d_4edd.bin" ; $4edd, 20 bytes
Data_73_4ef1:
	INCBIN "data/bank_073/d_4ef1.bin" ; $4ef1, 12 bytes
Data_73_4efd:
	db $03, $01, $02, $00 ; count, flags
	dw $4f07, OamPtrs_73_50a0, $4f07, Data_73_4f20, Data_73_4f60, Data_73_4fa0 ; body pointers
	INCBIN "data/bank_073/d_4f0d.bin" ; $4f0d, 19 bytes
Data_73_4f20:
	INCBIN "data/bank_073/d_4f20.bin" ; $4f20, 64 bytes
Data_73_4f60:
	INCBIN "data/bank_073/d_4f60.bin" ; $4f60, 64 bytes
Data_73_4fa0:
	INCBIN "data/bank_073/d_4fa0.bin" ; $4fa0, 256 bytes
OamPtrs_73_50a0:
	dw Data_73_50b0 ; $50a0
	dw Data_73_50b3 ; $50a2
	dw Data_73_50b9 ; $50a4
	dw Data_73_50c5 ; $50a6
	dw Data_73_50cd ; $50a8
	dw Data_73_50e1 ; $50aa
	dw Data_73_50e1 ; $50ac
	dw Data_73_50e1 ; $50ae
Data_73_50b0:
	INCBIN "data/bank_073/d_50b0.bin" ; $50b0, 3 bytes
Data_73_50b3:
	INCBIN "data/bank_073/d_50b3.bin" ; $50b3, 6 bytes
Data_73_50b9:
	INCBIN "data/bank_073/d_50b9.bin" ; $50b9, 12 bytes
Data_73_50c5:
	INCBIN "data/bank_073/d_50c5.bin" ; $50c5, 8 bytes
Data_73_50cd:
	INCBIN "data/bank_073/d_50cd.bin" ; $50cd, 20 bytes
Data_73_50e1:
	INCBIN "data/bank_073/d_50e1.bin" ; $50e1, 12 bytes
Data_73_50ed:
	db $03, $01, $02, $00 ; count, flags
	dw $50f7, OamPtrs_73_5290, $50f7, Data_73_5110, Data_73_5150, Data_73_5190 ; body pointers
	INCBIN "data/bank_073/d_50fd.bin" ; $50fd, 19 bytes
Data_73_5110:
	INCBIN "data/bank_073/d_5110.bin" ; $5110, 64 bytes
Data_73_5150:
	INCBIN "data/bank_073/d_5150.bin" ; $5150, 64 bytes
Data_73_5190:
	INCBIN "data/bank_073/d_5190.bin" ; $5190, 256 bytes
OamPtrs_73_5290:
	dw Data_73_52a0 ; $5290
	dw Data_73_52a3 ; $5292
	dw Data_73_52a9 ; $5294
	dw Data_73_52b5 ; $5296
	dw Data_73_52bd ; $5298
	dw Data_73_52d1 ; $529a
	dw Data_73_52d1 ; $529c
	dw Data_73_52d1 ; $529e
Data_73_52a0:
	INCBIN "data/bank_073/d_52a0.bin" ; $52a0, 3 bytes
Data_73_52a3:
	INCBIN "data/bank_073/d_52a3.bin" ; $52a3, 6 bytes
Data_73_52a9:
	INCBIN "data/bank_073/d_52a9.bin" ; $52a9, 12 bytes
Data_73_52b5:
	INCBIN "data/bank_073/d_52b5.bin" ; $52b5, 8 bytes
Data_73_52bd:
	INCBIN "data/bank_073/d_52bd.bin" ; $52bd, 20 bytes
Data_73_52d1:
	INCBIN "data/bank_073/d_52d1.bin" ; $52d1, 12 bytes
Data_73_52dd:
	db $03, $01, $02, $00 ; count, flags
	dw $52e7, OamPtrs_73_5480, $52e7, Data_73_5300, Data_73_5340, Data_73_5380 ; body pointers
	INCBIN "data/bank_073/d_52ed.bin" ; $52ed, 19 bytes
Data_73_5300:
	INCBIN "data/bank_073/d_5300.bin" ; $5300, 64 bytes
Data_73_5340:
	INCBIN "data/bank_073/d_5340.bin" ; $5340, 64 bytes
Data_73_5380:
	INCBIN "data/bank_073/d_5380.bin" ; $5380, 256 bytes
OamPtrs_73_5480:
	dw Data_73_5490 ; $5480
	dw Data_73_5493 ; $5482
	dw Data_73_5499 ; $5484
	dw Data_73_54a5 ; $5486
	dw Data_73_54ad ; $5488
	dw Data_73_54c1 ; $548a
	dw Data_73_54c1 ; $548c
	dw Data_73_54c1 ; $548e
Data_73_5490:
	INCBIN "data/bank_073/d_5490.bin" ; $5490, 3 bytes
Data_73_5493:
	INCBIN "data/bank_073/d_5493.bin" ; $5493, 6 bytes
Data_73_5499:
	INCBIN "data/bank_073/d_5499.bin" ; $5499, 12 bytes
Data_73_54a5:
	INCBIN "data/bank_073/d_54a5.bin" ; $54a5, 8 bytes
Data_73_54ad:
	INCBIN "data/bank_073/d_54ad.bin" ; $54ad, 20 bytes
Data_73_54c1:
	INCBIN "data/bank_073/d_54c1.bin" ; $54c1, 12 bytes
Data_73_54cd:
	db $04, $01, $02, $00 ; count, flags
	dw $54d7, OamPtrs_73_56b0, $54d7, Data_73_54f0, Data_73_5530, Data_73_5570 ; body pointers
	INCBIN "data/bank_073/d_54dd.bin" ; $54dd, 19 bytes
Data_73_54f0:
	INCBIN "data/bank_073/d_54f0.bin" ; $54f0, 64 bytes
Data_73_5530:
	INCBIN "data/bank_073/d_5530.bin" ; $5530, 64 bytes
Data_73_5570:
	INCBIN "data/bank_073/d_5570.bin" ; $5570, 320 bytes
OamPtrs_73_56b0:
	dw Data_73_56c0 ; $56b0
	dw Data_73_56c0 ; $56b2
	dw Data_73_56c3 ; $56b4
	dw Data_73_56cf ; $56b6
	dw Data_73_56d7 ; $56b8
	dw Data_73_56eb ; $56ba
	dw Data_73_56f5 ; $56bc
	dw Data_73_56f5 ; $56be
Data_73_56c0:
	INCBIN "data/bank_073/d_56c0.bin" ; $56c0, 3 bytes
Data_73_56c3:
	INCBIN "data/bank_073/d_56c3.bin" ; $56c3, 12 bytes
Data_73_56cf:
	INCBIN "data/bank_073/d_56cf.bin" ; $56cf, 8 bytes
Data_73_56d7:
	INCBIN "data/bank_073/d_56d7.bin" ; $56d7, 20 bytes
Data_73_56eb:
	INCBIN "data/bank_073/d_56eb.bin" ; $56eb, 10 bytes
Data_73_56f5:
	INCBIN "data/bank_073/d_56f5.bin" ; $56f5, 12 bytes
Data_73_5701:
	db $03, $01, $02, $00 ; count, flags
	dw $570b, OamPtrs_73_58f0, $570b, Data_73_5730, Data_73_5770, Data_73_57b0 ; body pointers
	INCBIN "data/bank_073/d_5711.bin" ; $5711, 31 bytes
Data_73_5730:
	INCBIN "data/bank_073/d_5730.bin" ; $5730, 64 bytes
Data_73_5770:
	INCBIN "data/bank_073/d_5770.bin" ; $5770, 64 bytes
Data_73_57b0:
	INCBIN "data/bank_073/d_57b0.bin" ; $57b0, 320 bytes
OamPtrs_73_58f0:
	dw Data_73_5900 ; $58f0
	dw Data_73_5900 ; $58f2
	dw Data_73_5903 ; $58f4
	dw Data_73_5915 ; $58f6
	dw Data_73_5915 ; $58f8
	dw Data_73_5929 ; $58fa
	dw Data_73_5933 ; $58fc
	dw Data_73_5933 ; $58fe
Data_73_5900:
	INCBIN "data/bank_073/d_5900.bin" ; $5900, 3 bytes
Data_73_5903:
	INCBIN "data/bank_073/d_5903.bin" ; $5903, 18 bytes
Data_73_5915:
	INCBIN "data/bank_073/d_5915.bin" ; $5915, 20 bytes
Data_73_5929:
	INCBIN "data/bank_073/d_5929.bin" ; $5929, 10 bytes
Data_73_5933:
	INCBIN "data/bank_073/d_5933.bin" ; $5933, 12 bytes
Data_73_593f:
	db $05, $04, $02, $00 ; count, flags
	dw $5949, OamPtrs_73_5f60, $5949, Data_73_5960, Data_73_5a60, Data_73_5b60 ; body pointers
	INCBIN "data/bank_073/d_594f.bin" ; $594f, 17 bytes
Data_73_5960:
	INCBIN "data/bank_073/d_5960.bin" ; $5960, 256 bytes
Data_73_5a60:
	INCBIN "data/bank_073/d_5a60.bin" ; $5a60, 256 bytes
Data_73_5b60:
	INCBIN "data/bank_073/d_5b60.bin" ; $5b60, 1024 bytes
OamPtrs_73_5f60:
	dw Data_73_5f70 ; $5f60
	dw Data_73_5f73 ; $5f62
	dw Data_73_5f79 ; $5f64
	dw Data_73_5f85 ; $5f66
	dw Data_73_5f8d ; $5f68
	dw Data_73_5fa1 ; $5f6a
	dw Data_73_5fa1 ; $5f6c
	dw Data_73_5fa1 ; $5f6e
Data_73_5f70:
	INCBIN "data/bank_073/d_5f70.bin" ; $5f70, 3 bytes
Data_73_5f73:
	INCBIN "data/bank_073/d_5f73.bin" ; $5f73, 6 bytes
Data_73_5f79:
	INCBIN "data/bank_073/d_5f79.bin" ; $5f79, 12 bytes
Data_73_5f85:
	INCBIN "data/bank_073/d_5f85.bin" ; $5f85, 8 bytes
Data_73_5f8d:
	INCBIN "data/bank_073/d_5f8d.bin" ; $5f8d, 20 bytes
Data_73_5fa1:
	INCBIN "data/bank_073/d_5fa1.bin" ; $5fa1, 12 bytes
Data_73_5fad:
	db $05, $04, $02, $00 ; count, flags
	dw $5fb7, OamPtrs_73_67e0, $5fb7, Data_73_5fe0, Data_73_60e0, Data_73_61e0 ; body pointers
	INCBIN "data/bank_073/d_5fbd.bin" ; $5fbd, 35 bytes
Data_73_5fe0:
	INCBIN "data/bank_073/d_5fe0.bin" ; $5fe0, 256 bytes
Data_73_60e0:
	INCBIN "data/bank_073/d_60e0.bin" ; $60e0, 256 bytes
Data_73_61e0:
	INCBIN "data/bank_073/d_61e0.bin" ; $61e0, 1536 bytes
OamPtrs_73_67e0:
	dw Data_73_67f2 ; $67e0
	dw Data_73_67f5 ; $67e2
	dw Data_73_67fb ; $67e4
	dw Data_73_6807 ; $67e6
	dw Data_73_680f ; $67e8
	dw Data_73_6823 ; $67ea
	dw Data_73_6823 ; $67ec
	dw Data_73_6823 ; $67ee
	dw Data_73_682f ; $67f0
Data_73_67f2:
	INCBIN "data/bank_073/d_67f2.bin" ; $67f2, 3 bytes
Data_73_67f5:
	INCBIN "data/bank_073/d_67f5.bin" ; $67f5, 6 bytes
Data_73_67fb:
	INCBIN "data/bank_073/d_67fb.bin" ; $67fb, 12 bytes
Data_73_6807:
	INCBIN "data/bank_073/d_6807.bin" ; $6807, 8 bytes
Data_73_680f:
	INCBIN "data/bank_073/d_680f.bin" ; $680f, 20 bytes
Data_73_6823:
	INCBIN "data/bank_073/d_6823.bin" ; $6823, 12 bytes
Data_73_682f:
	INCBIN "data/bank_073/d_682f.bin" ; $682f, 6 bytes
Data_73_6835:
	db $04, $04, $02, $00 ; count, flags
	dw $683f, OamPtrs_73_6e60, $683f, Data_73_6860, Data_73_6960, Data_73_6a60 ; body pointers
	INCBIN "data/bank_073/d_6845.bin" ; $6845, 27 bytes
Data_73_6860:
	INCBIN "data/bank_073/d_6860.bin" ; $6860, 256 bytes
Data_73_6960:
	INCBIN "data/bank_073/d_6960.bin" ; $6960, 256 bytes
Data_73_6a60:
	INCBIN "data/bank_073/d_6a60.bin" ; $6a60, 1024 bytes
OamPtrs_73_6e60:
	dw Data_73_6e70 ; $6e60
	dw Data_73_6e73 ; $6e62
	dw Data_73_6e79 ; $6e64
	dw Data_73_6e85 ; $6e66
	dw Data_73_6e8d ; $6e68
	dw Data_73_6ea1 ; $6e6a
	dw Data_73_6ea1 ; $6e6c
	dw Data_73_6ea1 ; $6e6e
Data_73_6e70:
	INCBIN "data/bank_073/d_6e70.bin" ; $6e70, 3 bytes
Data_73_6e73:
	INCBIN "data/bank_073/d_6e73.bin" ; $6e73, 6 bytes
Data_73_6e79:
	INCBIN "data/bank_073/d_6e79.bin" ; $6e79, 12 bytes
Data_73_6e85:
	INCBIN "data/bank_073/d_6e85.bin" ; $6e85, 8 bytes
Data_73_6e8d:
	INCBIN "data/bank_073/d_6e8d.bin" ; $6e8d, 20 bytes
Data_73_6ea1:
	INCBIN "data/bank_073/d_6ea1.bin" ; $6ea1, 12 bytes
Data_73_6ead:
	db $03, $04, $02, $00 ; count, flags
	dw $6eb7, OamPtrs_73_74d0, $6eb7, Data_73_6ed0, Data_73_6fd0, Data_73_70d0 ; body pointers
	INCBIN "data/bank_073/d_6ebd.bin" ; $6ebd, 19 bytes
Data_73_6ed0:
	INCBIN "data/bank_073/d_6ed0.bin" ; $6ed0, 256 bytes
Data_73_6fd0:
	INCBIN "data/bank_073/d_6fd0.bin" ; $6fd0, 256 bytes
Data_73_70d0:
	INCBIN "data/bank_073/d_70d0.bin" ; $70d0, 1024 bytes
OamPtrs_73_74d0:
	dw Data_73_74e0 ; $74d0
	dw Data_73_74e3 ; $74d2
	dw Data_73_74e9 ; $74d4
	dw Data_73_74f5 ; $74d6
	dw Data_73_74fd ; $74d8
	dw Data_73_7511 ; $74da
	dw Data_73_7511 ; $74dc
	dw Data_73_7511 ; $74de
Data_73_74e0:
	INCBIN "data/bank_073/d_74e0.bin" ; $74e0, 3 bytes
Data_73_74e3:
	INCBIN "data/bank_073/d_74e3.bin" ; $74e3, 6 bytes
Data_73_74e9:
	INCBIN "data/bank_073/d_74e9.bin" ; $74e9, 12 bytes
Data_73_74f5:
	INCBIN "data/bank_073/d_74f5.bin" ; $74f5, 8 bytes
Data_73_74fd:
	INCBIN "data/bank_073/d_74fd.bin" ; $74fd, 20 bytes
Data_73_7511:
	INCBIN "data/bank_073/d_7511.bin" ; $7511, 12 bytes
Data_73_751d:
	db $03, $01, $02, $00 ; count, flags
	dw $7527, OamPtrs_73_75b0, $7527, Data_73_7530, Data_73_7570, $0000 ; body pointers
	INCBIN "data/bank_073/d_752d.bin" ; $752d, 3 bytes
Data_73_7530:
	INCBIN "data/bank_073/d_7530.bin" ; $7530, 64 bytes
Data_73_7570:
	INCBIN "data/bank_073/d_7570.bin" ; $7570, 64 bytes
OamPtrs_73_75b0:
	dw Data_73_75b4 ; $75b0
	dw Data_73_75b7 ; $75b2
Data_73_75b4:
	INCBIN "data/bank_073/d_75b4.bin" ; $75b4, 3 bytes
Data_73_75b7:
	INCBIN "data/bank_073/d_75b7.bin" ; $75b7, 6 bytes
Data_73_75bd:
	db $03, $01, $02, $00 ; count, flags
	dw $75c7, OamPtrs_73_7650, $75c7, Data_73_75d0, Data_73_7610, $0000 ; body pointers
	INCBIN "data/bank_073/d_75cd.bin" ; $75cd, 3 bytes
Data_73_75d0:
	INCBIN "data/bank_073/d_75d0.bin" ; $75d0, 64 bytes
Data_73_7610:
	INCBIN "data/bank_073/d_7610.bin" ; $7610, 64 bytes
OamPtrs_73_7650:
	dw Data_73_7654 ; $7650
	dw Data_73_7657 ; $7652
Data_73_7654:
	INCBIN "data/bank_073/d_7654.bin" ; $7654, 3 bytes
Data_73_7657:
	INCBIN "data/bank_073/d_7657.bin" ; $7657, 6 bytes
Data_73_765d:
	db $03, $01, $02, $00 ; count, flags
	dw $7667, OamPtrs_73_7800, $7667, Data_73_7680, Data_73_76c0, Data_73_7700 ; body pointers
	INCBIN "data/bank_073/d_766d.bin" ; $766d, 19 bytes
Data_73_7680:
	INCBIN "data/bank_073/d_7680.bin" ; $7680, 64 bytes
Data_73_76c0:
	INCBIN "data/bank_073/d_76c0.bin" ; $76c0, 64 bytes
Data_73_7700:
	INCBIN "data/bank_073/d_7700.bin" ; $7700, 256 bytes
OamPtrs_73_7800:
	dw Data_73_7810 ; $7800
	dw Data_73_7813 ; $7802
	dw Data_73_7819 ; $7804
	dw Data_73_7825 ; $7806
	dw Data_73_782d ; $7808
	dw Data_73_7841 ; $780a
	dw Data_73_7841 ; $780c
	dw Data_73_7841 ; $780e
Data_73_7810:
	INCBIN "data/bank_073/d_7810.bin" ; $7810, 3 bytes
Data_73_7813:
	INCBIN "data/bank_073/d_7813.bin" ; $7813, 6 bytes
Data_73_7819:
	INCBIN "data/bank_073/d_7819.bin" ; $7819, 12 bytes
Data_73_7825:
	INCBIN "data/bank_073/d_7825.bin" ; $7825, 8 bytes
Data_73_782d:
	INCBIN "data/bank_073/d_782d.bin" ; $782d, 20 bytes
Data_73_7841:
	INCBIN "data/bank_073/d_7841.bin" ; $7841, 12 bytes
Data_73_784d:
	db $03, $01, $02, $00 ; count, flags
	dw $7857, OamPtrs_73_78e0, $7857, Data_73_7860, Data_73_78a0, $0000 ; body pointers
	INCBIN "data/bank_073/d_785d.bin" ; $785d, 3 bytes
Data_73_7860:
	INCBIN "data/bank_073/d_7860.bin" ; $7860, 64 bytes
Data_73_78a0:
	INCBIN "data/bank_073/d_78a0.bin" ; $78a0, 64 bytes
OamPtrs_73_78e0:
	dw Data_73_78e4 ; $78e0
	dw Data_73_78e7 ; $78e2
Data_73_78e4:
	INCBIN "data/bank_073/d_78e4.bin" ; $78e4, 3 bytes
Data_73_78e7:
	INCBIN "data/bank_073/d_78e7.bin" ; $78e7, 6 bytes
Data_73_78ed:
	db $03, $01, $02, $00 ; count, flags
	dw $78f7, OamPtrs_73_7980, $78f7, Data_73_7900, Data_73_7940, $0000 ; body pointers
	INCBIN "data/bank_073/d_78fd.bin" ; $78fd, 3 bytes
Data_73_7900:
	INCBIN "data/bank_073/d_7900.bin" ; $7900, 64 bytes
Data_73_7940:
	INCBIN "data/bank_073/d_7940.bin" ; $7940, 64 bytes
OamPtrs_73_7980:
	dw Data_73_7984 ; $7980
	dw Data_73_7987 ; $7982
Data_73_7984:
	INCBIN "data/bank_073/d_7984.bin" ; $7984, 3 bytes
Data_73_7987:
	INCBIN "data/bank_073/d_7987.bin" ; $7987, 6 bytes
Data_73_798d:
	db $03, $01, $02, $00 ; count, flags
	dw $7997, OamPtrs_73_7a20, $7997, Data_73_79a0, Data_73_79e0, $0000 ; body pointers
	INCBIN "data/bank_073/d_799d.bin" ; $799d, 3 bytes
Data_73_79a0:
	INCBIN "data/bank_073/d_79a0.bin" ; $79a0, 64 bytes
Data_73_79e0:
	INCBIN "data/bank_073/d_79e0.bin" ; $79e0, 64 bytes
OamPtrs_73_7a20:
	dw Data_73_7a24 ; $7a20
	dw Data_73_7a27 ; $7a22
Data_73_7a24:
	INCBIN "data/bank_073/d_7a24.bin" ; $7a24, 3 bytes
Data_73_7a27:
	INCBIN "data/bank_073/d_7a27.bin" ; $7a27, 6 bytes
Data_73_7a2d:
	db $03, $01, $02, $00 ; count, flags
	dw $7a37, OamPtrs_73_7ac0, $7a37, Data_73_7a40, Data_73_7a80, $0000 ; body pointers
	INCBIN "data/bank_073/d_7a3d.bin" ; $7a3d, 3 bytes
Data_73_7a40:
	INCBIN "data/bank_073/d_7a40.bin" ; $7a40, 64 bytes
Data_73_7a80:
	INCBIN "data/bank_073/d_7a80.bin" ; $7a80, 64 bytes
OamPtrs_73_7ac0:
	dw Data_73_7ac4 ; $7ac0
	dw Data_73_7ac7 ; $7ac2
Data_73_7ac4:
	INCBIN "data/bank_073/d_7ac4.bin" ; $7ac4, 3 bytes
Data_73_7ac7:
	INCBIN "data/bank_073/d_7ac7.bin" ; $7ac7, 6 bytes
Data_73_7acd:
	db $03, $01, $02, $00 ; count, flags
	dw $7ad7, OamPtrs_73_7b60, $7ad7, Data_73_7ae0, Data_73_7b20, $0000 ; body pointers
	INCBIN "data/bank_073/d_7add.bin" ; $7add, 3 bytes
Data_73_7ae0:
	INCBIN "data/bank_073/d_7ae0.bin" ; $7ae0, 64 bytes
Data_73_7b20:
	INCBIN "data/bank_073/d_7b20.bin" ; $7b20, 64 bytes
OamPtrs_73_7b60:
	dw Data_73_7b64 ; $7b60
	dw Data_73_7b67 ; $7b62
Data_73_7b64:
	INCBIN "data/bank_073/d_7b64.bin" ; $7b64, 3 bytes
Data_73_7b67:
	INCBIN "data/bank_073/d_7b67.bin" ; $7b67, 6 bytes
	ds 1171, $ff ; $7b6d, fill

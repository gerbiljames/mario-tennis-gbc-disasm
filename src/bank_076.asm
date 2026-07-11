INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $76", ROMX[$4000], BANK[$76]

DataPtr_76_00:
	dw Data_76_400e ; $4000
DataPtr_76_02:
	dw Data_76_467d ; $4002
DataPtr_76_04:
	dw Data_76_4ced ; $4004
DataPtr_76_06:
	dw Data_76_5774 ; $4006
DataPtr_76_08:
	dw Data_76_5ded ; $4008
DataPtr_76_0a:
	dw Data_76_686a ; $400a
DataPtr_76_0c:
	dw Data_76_72ea ; $400c
Data_76_400e:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_76_4630, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_76_4030, Data_76_4130, Data_76_4230 ; frame pointers (continue in body)
	dw Data_76_4230 ; $401e
	dw Data_76_4230 ; $4020
	dw Data_76_4230 ; $4022
	dw Data_76_4230 ; $4024
	dw Data_76_4330 ; $4026
	dw Data_76_4430 ; $4028
	dw Data_76_4530 ; $402a
	INCBIN "data/bank_076/d_402c.bin" ; $402c, 4 bytes
Data_76_4030:
	INCBIN "data/bank_076/d_4030.bin" ; $4030, 256 bytes
Data_76_4130:
	INCBIN "data/bank_076/d_4130.bin" ; $4130, 256 bytes
Data_76_4230:
	INCBIN "data/bank_076/d_4230.bin" ; $4230, 256 bytes
Data_76_4330:
	INCBIN "data/bank_076/d_4330.bin" ; $4330, 256 bytes
Data_76_4430:
	INCBIN "data/bank_076/d_4430.bin" ; $4430, 256 bytes
Data_76_4530:
	INCBIN "data/bank_076/d_4530.bin" ; $4530, 256 bytes
OamPtrs_76_4630:
	dw Data_76_4640 ; $4630
	dw Data_76_4643 ; $4632
	dw Data_76_4649 ; $4634
	dw Data_76_4655 ; $4636
	dw Data_76_465d ; $4638
	dw Data_76_4671 ; $463a
	dw Data_76_4671 ; $463c
	dw Data_76_4671 ; $463e
Data_76_4640:
	INCBIN "data/bank_076/d_4640.bin" ; $4640, 3 bytes
Data_76_4643:
	INCBIN "data/bank_076/d_4643.bin" ; $4643, 6 bytes
Data_76_4649:
	INCBIN "data/bank_076/d_4649.bin" ; $4649, 12 bytes
Data_76_4655:
	INCBIN "data/bank_076/d_4655.bin" ; $4655, 8 bytes
Data_76_465d:
	INCBIN "data/bank_076/d_465d.bin" ; $465d, 20 bytes
Data_76_4671:
	INCBIN "data/bank_076/d_4671.bin" ; $4671, 12 bytes
Data_76_467d:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_76_4ca0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_76_46a0, Data_76_47a0, Data_76_48a0 ; frame pointers (continue in body)
	dw Data_76_48a0 ; $468d
	dw Data_76_48a0 ; $468f
	dw Data_76_48a0 ; $4691
	dw Data_76_48a0 ; $4693
	dw Data_76_49a0 ; $4695
	dw Data_76_4aa0 ; $4697
	dw Data_76_4ba0 ; $4699
	INCBIN "data/bank_076/d_469b.bin" ; $469b, 5 bytes
Data_76_46a0:
	INCBIN "data/bank_076/d_46a0.bin" ; $46a0, 256 bytes
Data_76_47a0:
	INCBIN "data/bank_076/d_47a0.bin" ; $47a0, 256 bytes
Data_76_48a0:
	INCBIN "data/bank_076/d_48a0.bin" ; $48a0, 256 bytes
Data_76_49a0:
	INCBIN "data/bank_076/d_49a0.bin" ; $49a0, 256 bytes
Data_76_4aa0:
	INCBIN "data/bank_076/d_4aa0.bin" ; $4aa0, 256 bytes
Data_76_4ba0:
	INCBIN "data/bank_076/d_4ba0.bin" ; $4ba0, 256 bytes
OamPtrs_76_4ca0:
	dw Data_76_4cb0 ; $4ca0
	dw Data_76_4cb3 ; $4ca2
	dw Data_76_4cb9 ; $4ca4
	dw Data_76_4cc5 ; $4ca6
	dw Data_76_4ccd ; $4ca8
	dw Data_76_4ce1 ; $4caa
	dw Data_76_4ce1 ; $4cac
	dw Data_76_4ce1 ; $4cae
Data_76_4cb0:
	INCBIN "data/bank_076/d_4cb0.bin" ; $4cb0, 3 bytes
Data_76_4cb3:
	INCBIN "data/bank_076/d_4cb3.bin" ; $4cb3, 6 bytes
Data_76_4cb9:
	INCBIN "data/bank_076/d_4cb9.bin" ; $4cb9, 12 bytes
Data_76_4cc5:
	INCBIN "data/bank_076/d_4cc5.bin" ; $4cc5, 8 bytes
Data_76_4ccd:
	INCBIN "data/bank_076/d_4ccd.bin" ; $4ccd, 20 bytes
Data_76_4ce1:
	INCBIN "data/bank_076/d_4ce1.bin" ; $4ce1, 12 bytes
Data_76_4ced:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_76_5710, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_76_4d10, Data_76_4e10, Data_76_4f10 ; frame pointers (continue in body)
	dw Data_76_5010 ; $4cfd
	dw Data_76_5110 ; $4cff
	dw Data_76_5210 ; $4d01
	dw Data_76_5310 ; $4d03
	dw Data_76_5410 ; $4d05
	dw Data_76_5510 ; $4d07
	dw Data_76_5610 ; $4d09
	INCBIN "data/bank_076/d_4d0b.bin" ; $4d0b, 5 bytes
Data_76_4d10:
	INCBIN "data/bank_076/d_4d10.bin" ; $4d10, 256 bytes
Data_76_4e10:
	INCBIN "data/bank_076/d_4e10.bin" ; $4e10, 256 bytes
Data_76_4f10:
	INCBIN "data/bank_076/d_4f10.bin" ; $4f10, 256 bytes
Data_76_5010:
	INCBIN "data/bank_076/d_5010.bin" ; $5010, 256 bytes
Data_76_5110:
	INCBIN "data/bank_076/d_5110.bin" ; $5110, 256 bytes
Data_76_5210:
	INCBIN "data/bank_076/d_5210.bin" ; $5210, 256 bytes
Data_76_5310:
	INCBIN "data/bank_076/d_5310.bin" ; $5310, 256 bytes
Data_76_5410:
	INCBIN "data/bank_076/d_5410.bin" ; $5410, 256 bytes
Data_76_5510:
	INCBIN "data/bank_076/d_5510.bin" ; $5510, 256 bytes
Data_76_5610:
	INCBIN "data/bank_076/d_5610.bin" ; $5610, 256 bytes
OamPtrs_76_5710:
	dw Data_76_5722 ; $5710
	dw Data_76_5725 ; $5712
	dw Data_76_572b ; $5714
	dw Data_76_5737 ; $5716
	dw Data_76_573f ; $5718
	dw Data_76_5753 ; $571a
	dw Data_76_575b ; $571c
	dw Data_76_5760 ; $571e
	dw Data_76_576c ; $5720
Data_76_5722:
	INCBIN "data/bank_076/d_5722.bin" ; $5722, 3 bytes
Data_76_5725:
	INCBIN "data/bank_076/d_5725.bin" ; $5725, 6 bytes
Data_76_572b:
	INCBIN "data/bank_076/d_572b.bin" ; $572b, 12 bytes
Data_76_5737:
	INCBIN "data/bank_076/d_5737.bin" ; $5737, 8 bytes
Data_76_573f:
	INCBIN "data/bank_076/d_573f.bin" ; $573f, 20 bytes
Data_76_5753:
	INCBIN "data/bank_076/d_5753.bin" ; $5753, 8 bytes
Data_76_575b:
	INCBIN "data/bank_076/d_575b.bin" ; $575b, 5 bytes
Data_76_5760:
	INCBIN "data/bank_076/d_5760.bin" ; $5760, 12 bytes
Data_76_576c:
	INCBIN "data/bank_076/d_576c.bin" ; $576c, 8 bytes
Data_76_5774:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_76_5da0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_76_57a0, Data_76_58a0, Data_76_59a0 ; frame pointers (continue in body)
	dw Data_76_59a0 ; $5784
	dw Data_76_59a0 ; $5786
	dw Data_76_59a0 ; $5788
	dw Data_76_59a0 ; $578a
	dw Data_76_5aa0 ; $578c
	dw Data_76_5ba0 ; $578e
	dw Data_76_5ca0 ; $5790
	INCBIN "data/bank_076/d_5792.bin" ; $5792, 14 bytes
Data_76_57a0:
	INCBIN "data/bank_076/d_57a0.bin" ; $57a0, 256 bytes
Data_76_58a0:
	INCBIN "data/bank_076/d_58a0.bin" ; $58a0, 256 bytes
Data_76_59a0:
	INCBIN "data/bank_076/d_59a0.bin" ; $59a0, 256 bytes
Data_76_5aa0:
	INCBIN "data/bank_076/d_5aa0.bin" ; $5aa0, 256 bytes
Data_76_5ba0:
	INCBIN "data/bank_076/d_5ba0.bin" ; $5ba0, 256 bytes
Data_76_5ca0:
	INCBIN "data/bank_076/d_5ca0.bin" ; $5ca0, 256 bytes
OamPtrs_76_5da0:
	dw Data_76_5db0 ; $5da0
	dw Data_76_5db3 ; $5da2
	dw Data_76_5db9 ; $5da4
	dw Data_76_5dc5 ; $5da6
	dw Data_76_5dcd ; $5da8
	dw Data_76_5de1 ; $5daa
	dw Data_76_5de1 ; $5dac
	dw Data_76_5de1 ; $5dae
Data_76_5db0:
	INCBIN "data/bank_076/d_5db0.bin" ; $5db0, 3 bytes
Data_76_5db3:
	INCBIN "data/bank_076/d_5db3.bin" ; $5db3, 6 bytes
Data_76_5db9:
	INCBIN "data/bank_076/d_5db9.bin" ; $5db9, 12 bytes
Data_76_5dc5:
	INCBIN "data/bank_076/d_5dc5.bin" ; $5dc5, 8 bytes
Data_76_5dcd:
	INCBIN "data/bank_076/d_5dcd.bin" ; $5dcd, 20 bytes
Data_76_5de1:
	INCBIN "data/bank_076/d_5de1.bin" ; $5de1, 12 bytes
Data_76_5ded:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_76_6810, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_76_5e10, Data_76_5f10, Data_76_6010 ; frame pointers (continue in body)
	dw Data_76_6110 ; $5dfd
	dw Data_76_6210 ; $5dff
	dw Data_76_6310 ; $5e01
	dw Data_76_6410 ; $5e03
	dw Data_76_6510 ; $5e05
	dw Data_76_6610 ; $5e07
	dw Data_76_6710 ; $5e09
	INCBIN "data/bank_076/d_5e0b.bin" ; $5e0b, 5 bytes
Data_76_5e10:
	INCBIN "data/bank_076/d_5e10.bin" ; $5e10, 256 bytes
Data_76_5f10:
	INCBIN "data/bank_076/d_5f10.bin" ; $5f10, 256 bytes
Data_76_6010:
	INCBIN "data/bank_076/d_6010.bin" ; $6010, 256 bytes
Data_76_6110:
	INCBIN "data/bank_076/d_6110.bin" ; $6110, 256 bytes
Data_76_6210:
	INCBIN "data/bank_076/d_6210.bin" ; $6210, 256 bytes
Data_76_6310:
	INCBIN "data/bank_076/d_6310.bin" ; $6310, 256 bytes
Data_76_6410:
	INCBIN "data/bank_076/d_6410.bin" ; $6410, 256 bytes
Data_76_6510:
	INCBIN "data/bank_076/d_6510.bin" ; $6510, 256 bytes
Data_76_6610:
	INCBIN "data/bank_076/d_6610.bin" ; $6610, 256 bytes
Data_76_6710:
	INCBIN "data/bank_076/d_6710.bin" ; $6710, 256 bytes
OamPtrs_76_6810:
	dw Data_76_6820 ; $6810
	dw Data_76_6823 ; $6812
	dw Data_76_6829 ; $6814
	dw Data_76_6835 ; $6816
	dw Data_76_683d ; $6818
	dw Data_76_6851 ; $681a
	dw Data_76_6859 ; $681c
	dw Data_76_685e ; $681e
Data_76_6820:
	INCBIN "data/bank_076/d_6820.bin" ; $6820, 3 bytes
Data_76_6823:
	INCBIN "data/bank_076/d_6823.bin" ; $6823, 6 bytes
Data_76_6829:
	INCBIN "data/bank_076/d_6829.bin" ; $6829, 12 bytes
Data_76_6835:
	INCBIN "data/bank_076/d_6835.bin" ; $6835, 8 bytes
Data_76_683d:
	INCBIN "data/bank_076/d_683d.bin" ; $683d, 20 bytes
Data_76_6851:
	INCBIN "data/bank_076/d_6851.bin" ; $6851, 8 bytes
Data_76_6859:
	INCBIN "data/bank_076/d_6859.bin" ; $6859, 5 bytes
Data_76_685e:
	INCBIN "data/bank_076/d_685e.bin" ; $685e, 12 bytes
Data_76_686a:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_76_7290, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_76_6890, Data_76_6990, Data_76_6a90 ; frame pointers (continue in body)
	dw Data_76_6b90 ; $687a
	dw Data_76_6c90 ; $687c
	dw Data_76_6d90 ; $687e
	dw Data_76_6e90 ; $6880
	dw Data_76_6f90 ; $6882
	dw Data_76_7090 ; $6884
	dw Data_76_7190 ; $6886
	INCBIN "data/bank_076/d_6888.bin" ; $6888, 8 bytes
Data_76_6890:
	INCBIN "data/bank_076/d_6890.bin" ; $6890, 256 bytes
Data_76_6990:
	INCBIN "data/bank_076/d_6990.bin" ; $6990, 256 bytes
Data_76_6a90:
	INCBIN "data/bank_076/d_6a90.bin" ; $6a90, 256 bytes
Data_76_6b90:
	INCBIN "data/bank_076/d_6b90.bin" ; $6b90, 256 bytes
Data_76_6c90:
	INCBIN "data/bank_076/d_6c90.bin" ; $6c90, 256 bytes
Data_76_6d90:
	INCBIN "data/bank_076/d_6d90.bin" ; $6d90, 256 bytes
Data_76_6e90:
	INCBIN "data/bank_076/d_6e90.bin" ; $6e90, 256 bytes
Data_76_6f90:
	INCBIN "data/bank_076/d_6f90.bin" ; $6f90, 256 bytes
Data_76_7090:
	INCBIN "data/bank_076/d_7090.bin" ; $7090, 256 bytes
Data_76_7190:
	INCBIN "data/bank_076/d_7190.bin" ; $7190, 256 bytes
OamPtrs_76_7290:
	dw Data_76_72a0 ; $7290
	dw Data_76_72a3 ; $7292
	dw Data_76_72a9 ; $7294
	dw Data_76_72b5 ; $7296
	dw Data_76_72bd ; $7298
	dw Data_76_72d1 ; $729a
	dw Data_76_72d9 ; $729c
	dw Data_76_72de ; $729e
Data_76_72a0:
	INCBIN "data/bank_076/d_72a0.bin" ; $72a0, 3 bytes
Data_76_72a3:
	INCBIN "data/bank_076/d_72a3.bin" ; $72a3, 6 bytes
Data_76_72a9:
	INCBIN "data/bank_076/d_72a9.bin" ; $72a9, 12 bytes
Data_76_72b5:
	INCBIN "data/bank_076/d_72b5.bin" ; $72b5, 8 bytes
Data_76_72bd:
	INCBIN "data/bank_076/d_72bd.bin" ; $72bd, 20 bytes
Data_76_72d1:
	INCBIN "data/bank_076/d_72d1.bin" ; $72d1, 8 bytes
Data_76_72d9:
	INCBIN "data/bank_076/d_72d9.bin" ; $72d9, 5 bytes
Data_76_72de:
	INCBIN "data/bank_076/d_72de.bin" ; $72de, 12 bytes
Data_76_72ea:
	db $04, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_76_7490, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_76_7310, Data_76_7350, Data_76_7390 ; frame pointers (continue in body)
	dw Data_76_7390 ; $72fa
	dw Data_76_7390 ; $72fc
	dw Data_76_7390 ; $72fe
	dw Data_76_7390 ; $7300
	dw Data_76_73d0 ; $7302
	dw Data_76_7410 ; $7304
	dw Data_76_7450 ; $7306
	INCBIN "data/bank_076/d_7308.bin" ; $7308, 8 bytes
Data_76_7310:
	INCBIN "data/bank_076/d_7310.bin" ; $7310, 64 bytes
Data_76_7350:
	INCBIN "data/bank_076/d_7350.bin" ; $7350, 64 bytes
Data_76_7390:
	INCBIN "data/bank_076/d_7390.bin" ; $7390, 64 bytes
Data_76_73d0:
	INCBIN "data/bank_076/d_73d0.bin" ; $73d0, 64 bytes
Data_76_7410:
	INCBIN "data/bank_076/d_7410.bin" ; $7410, 64 bytes
Data_76_7450:
	INCBIN "data/bank_076/d_7450.bin" ; $7450, 64 bytes
OamPtrs_76_7490:
	dw Data_76_74a0 ; $7490
	dw Data_76_74a3 ; $7492
	dw Data_76_74a9 ; $7494
	dw Data_76_74b5 ; $7496
	dw Data_76_74bd ; $7498
	dw Data_76_74d1 ; $749a
	dw Data_76_74d1 ; $749c
	dw Data_76_74d1 ; $749e
Data_76_74a0:
	INCBIN "data/bank_076/d_74a0.bin" ; $74a0, 3 bytes
Data_76_74a3:
	INCBIN "data/bank_076/d_74a3.bin" ; $74a3, 6 bytes
Data_76_74a9:
	INCBIN "data/bank_076/d_74a9.bin" ; $74a9, 12 bytes
Data_76_74b5:
	INCBIN "data/bank_076/d_74b5.bin" ; $74b5, 8 bytes
Data_76_74bd:
	INCBIN "data/bank_076/d_74bd.bin" ; $74bd, 20 bytes
Data_76_74d1:
	INCBIN "data/bank_076/d_74d1.bin" ; $74d1, 12 bytes
	ds 2851, $ff ; $74dd, fill

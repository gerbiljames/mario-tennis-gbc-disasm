INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $75", ROMX[$4000], BANK[$75]

DataPtr_75_00:
	dw Data_75_4012 ; $4000
DataPtr_75_02:
	dw Data_75_467d ; $4002
DataPtr_75_04:
	dw Data_75_4ced ; $4004
DataPtr_75_06:
	dw Data_75_535d ; $4006
DataPtr_75_08:
	dw Data_75_59cd ; $4008
DataPtr_75_0a:
	dw Data_75_603d ; $400a
DataPtr_75_0c:
	dw Data_75_66ad ; $400c
DataPtr_75_0e:
	dw Data_75_6d2b ; $400e
DataPtr_75_10:
	dw Data_75_739d ; $4010
Data_75_4012:
	db $03, $04, $02, $00 ; count, flags
	dw $401c, OamPtrs_75_4630, $401c, Data_75_4030, Data_75_4130, Data_75_4230 ; body pointers
	INCBIN "data/bank_075/d_4022.bin" ; $4022, 14 bytes
Data_75_4030:
	INCBIN "data/bank_075/d_4030.bin" ; $4030, 256 bytes
Data_75_4130:
	INCBIN "data/bank_075/d_4130.bin" ; $4130, 256 bytes
Data_75_4230:
	INCBIN "data/bank_075/d_4230.bin" ; $4230, 1024 bytes
OamPtrs_75_4630:
	dw Data_75_4640 ; $4630
	dw Data_75_4643 ; $4632
	dw Data_75_4649 ; $4634
	dw Data_75_4655 ; $4636
	dw Data_75_465d ; $4638
	dw Data_75_4671 ; $463a
	dw Data_75_4671 ; $463c
	dw Data_75_4671 ; $463e
Data_75_4640:
	INCBIN "data/bank_075/d_4640.bin" ; $4640, 3 bytes
Data_75_4643:
	INCBIN "data/bank_075/d_4643.bin" ; $4643, 6 bytes
Data_75_4649:
	INCBIN "data/bank_075/d_4649.bin" ; $4649, 12 bytes
Data_75_4655:
	INCBIN "data/bank_075/d_4655.bin" ; $4655, 8 bytes
Data_75_465d:
	INCBIN "data/bank_075/d_465d.bin" ; $465d, 20 bytes
Data_75_4671:
	INCBIN "data/bank_075/d_4671.bin" ; $4671, 12 bytes
Data_75_467d:
	db $03, $04, $02, $00 ; count, flags
	dw $4687, OamPtrs_75_4ca0, $4687, Data_75_46a0, Data_75_47a0, Data_75_48a0 ; body pointers
	INCBIN "data/bank_075/d_468d.bin" ; $468d, 19 bytes
Data_75_46a0:
	INCBIN "data/bank_075/d_46a0.bin" ; $46a0, 256 bytes
Data_75_47a0:
	INCBIN "data/bank_075/d_47a0.bin" ; $47a0, 256 bytes
Data_75_48a0:
	INCBIN "data/bank_075/d_48a0.bin" ; $48a0, 1024 bytes
OamPtrs_75_4ca0:
	dw Data_75_4cb0 ; $4ca0
	dw Data_75_4cb3 ; $4ca2
	dw Data_75_4cb9 ; $4ca4
	dw Data_75_4cc5 ; $4ca6
	dw Data_75_4ccd ; $4ca8
	dw Data_75_4ce1 ; $4caa
	dw Data_75_4ce1 ; $4cac
	dw Data_75_4ce1 ; $4cae
Data_75_4cb0:
	INCBIN "data/bank_075/d_4cb0.bin" ; $4cb0, 3 bytes
Data_75_4cb3:
	INCBIN "data/bank_075/d_4cb3.bin" ; $4cb3, 6 bytes
Data_75_4cb9:
	INCBIN "data/bank_075/d_4cb9.bin" ; $4cb9, 12 bytes
Data_75_4cc5:
	INCBIN "data/bank_075/d_4cc5.bin" ; $4cc5, 8 bytes
Data_75_4ccd:
	INCBIN "data/bank_075/d_4ccd.bin" ; $4ccd, 20 bytes
Data_75_4ce1:
	INCBIN "data/bank_075/d_4ce1.bin" ; $4ce1, 12 bytes
Data_75_4ced:
	db $05, $04, $02, $00 ; count, flags
	dw $4cf7, OamPtrs_75_5310, $4cf7, Data_75_4d10, Data_75_4e10, Data_75_4f10 ; body pointers
	INCBIN "data/bank_075/d_4cfd.bin" ; $4cfd, 19 bytes
Data_75_4d10:
	INCBIN "data/bank_075/d_4d10.bin" ; $4d10, 256 bytes
Data_75_4e10:
	INCBIN "data/bank_075/d_4e10.bin" ; $4e10, 256 bytes
Data_75_4f10:
	INCBIN "data/bank_075/d_4f10.bin" ; $4f10, 1024 bytes
OamPtrs_75_5310:
	dw Data_75_5320 ; $5310
	dw Data_75_5323 ; $5312
	dw Data_75_5329 ; $5314
	dw Data_75_5335 ; $5316
	dw Data_75_533d ; $5318
	dw Data_75_5351 ; $531a
	dw Data_75_5351 ; $531c
	dw Data_75_5351 ; $531e
Data_75_5320:
	INCBIN "data/bank_075/d_5320.bin" ; $5320, 3 bytes
Data_75_5323:
	INCBIN "data/bank_075/d_5323.bin" ; $5323, 6 bytes
Data_75_5329:
	INCBIN "data/bank_075/d_5329.bin" ; $5329, 12 bytes
Data_75_5335:
	INCBIN "data/bank_075/d_5335.bin" ; $5335, 8 bytes
Data_75_533d:
	INCBIN "data/bank_075/d_533d.bin" ; $533d, 20 bytes
Data_75_5351:
	INCBIN "data/bank_075/d_5351.bin" ; $5351, 12 bytes
Data_75_535d:
	db $05, $04, $02, $00 ; count, flags
	dw $5367, OamPtrs_75_5980, $5367, Data_75_5380, Data_75_5480, Data_75_5580 ; body pointers
	INCBIN "data/bank_075/d_536d.bin" ; $536d, 19 bytes
Data_75_5380:
	INCBIN "data/bank_075/d_5380.bin" ; $5380, 256 bytes
Data_75_5480:
	INCBIN "data/bank_075/d_5480.bin" ; $5480, 256 bytes
Data_75_5580:
	INCBIN "data/bank_075/d_5580.bin" ; $5580, 1024 bytes
OamPtrs_75_5980:
	dw Data_75_5990 ; $5980
	dw Data_75_5993 ; $5982
	dw Data_75_5999 ; $5984
	dw Data_75_59a5 ; $5986
	dw Data_75_59ad ; $5988
	dw Data_75_59c1 ; $598a
	dw Data_75_59c1 ; $598c
	dw Data_75_59c1 ; $598e
Data_75_5990:
	INCBIN "data/bank_075/d_5990.bin" ; $5990, 3 bytes
Data_75_5993:
	INCBIN "data/bank_075/d_5993.bin" ; $5993, 6 bytes
Data_75_5999:
	INCBIN "data/bank_075/d_5999.bin" ; $5999, 12 bytes
Data_75_59a5:
	INCBIN "data/bank_075/d_59a5.bin" ; $59a5, 8 bytes
Data_75_59ad:
	INCBIN "data/bank_075/d_59ad.bin" ; $59ad, 20 bytes
Data_75_59c1:
	INCBIN "data/bank_075/d_59c1.bin" ; $59c1, 12 bytes
Data_75_59cd:
	db $07, $04, $02, $00 ; count, flags
	dw $59d7, OamPtrs_75_5ff0, $59d7, Data_75_59f0, Data_75_5af0, Data_75_5bf0 ; body pointers
	INCBIN "data/bank_075/d_59dd.bin" ; $59dd, 19 bytes
Data_75_59f0:
	INCBIN "data/bank_075/d_59f0.bin" ; $59f0, 256 bytes
Data_75_5af0:
	INCBIN "data/bank_075/d_5af0.bin" ; $5af0, 256 bytes
Data_75_5bf0:
	INCBIN "data/bank_075/d_5bf0.bin" ; $5bf0, 1024 bytes
OamPtrs_75_5ff0:
	dw Data_75_6000 ; $5ff0
	dw Data_75_6003 ; $5ff2
	dw Data_75_6009 ; $5ff4
	dw Data_75_6015 ; $5ff6
	dw Data_75_601d ; $5ff8
	dw Data_75_6031 ; $5ffa
	dw Data_75_6031 ; $5ffc
	dw Data_75_6031 ; $5ffe
Data_75_6000:
	INCBIN "data/bank_075/d_6000.bin" ; $6000, 3 bytes
Data_75_6003:
	INCBIN "data/bank_075/d_6003.bin" ; $6003, 6 bytes
Data_75_6009:
	INCBIN "data/bank_075/d_6009.bin" ; $6009, 12 bytes
Data_75_6015:
	INCBIN "data/bank_075/d_6015.bin" ; $6015, 8 bytes
Data_75_601d:
	INCBIN "data/bank_075/d_601d.bin" ; $601d, 20 bytes
Data_75_6031:
	INCBIN "data/bank_075/d_6031.bin" ; $6031, 12 bytes
Data_75_603d:
	db $07, $04, $02, $00 ; count, flags
	dw $6047, OamPtrs_75_6660, $6047, Data_75_6060, Data_75_6160, Data_75_6260 ; body pointers
	INCBIN "data/bank_075/d_604d.bin" ; $604d, 19 bytes
Data_75_6060:
	INCBIN "data/bank_075/d_6060.bin" ; $6060, 256 bytes
Data_75_6160:
	INCBIN "data/bank_075/d_6160.bin" ; $6160, 256 bytes
Data_75_6260:
	INCBIN "data/bank_075/d_6260.bin" ; $6260, 1024 bytes
OamPtrs_75_6660:
	dw Data_75_6670 ; $6660
	dw Data_75_6673 ; $6662
	dw Data_75_6679 ; $6664
	dw Data_75_6685 ; $6666
	dw Data_75_668d ; $6668
	dw Data_75_66a1 ; $666a
	dw Data_75_66a1 ; $666c
	dw Data_75_66a1 ; $666e
Data_75_6670:
	INCBIN "data/bank_075/d_6670.bin" ; $6670, 3 bytes
Data_75_6673:
	INCBIN "data/bank_075/d_6673.bin" ; $6673, 6 bytes
Data_75_6679:
	INCBIN "data/bank_075/d_6679.bin" ; $6679, 12 bytes
Data_75_6685:
	INCBIN "data/bank_075/d_6685.bin" ; $6685, 8 bytes
Data_75_668d:
	INCBIN "data/bank_075/d_668d.bin" ; $668d, 20 bytes
Data_75_66a1:
	INCBIN "data/bank_075/d_66a1.bin" ; $66a1, 12 bytes
Data_75_66ad:
	db $07, $04, $02, $00 ; count, flags
	dw $66b7, OamPtrs_75_6cd0, $66b7, Data_75_66d0, Data_75_67d0, Data_75_68d0 ; body pointers
	INCBIN "data/bank_075/d_66bd.bin" ; $66bd, 19 bytes
Data_75_66d0:
	INCBIN "data/bank_075/d_66d0.bin" ; $66d0, 256 bytes
Data_75_67d0:
	INCBIN "data/bank_075/d_67d0.bin" ; $67d0, 256 bytes
Data_75_68d0:
	INCBIN "data/bank_075/d_68d0.bin" ; $68d0, 1024 bytes
OamPtrs_75_6cd0:
	dw Data_75_6ce2 ; $6cd0
	dw Data_75_6ce5 ; $6cd2
	dw Data_75_6ceb ; $6cd4
	dw Data_75_6cf7 ; $6cd6
	dw Data_75_6cff ; $6cd8
	dw Data_75_6d13 ; $6cda
	dw Data_75_6d19 ; $6cdc
	dw Data_75_6d19 ; $6cde
	dw Data_75_6d25 ; $6ce0
Data_75_6ce2:
	INCBIN "data/bank_075/d_6ce2.bin" ; $6ce2, 3 bytes
Data_75_6ce5:
	INCBIN "data/bank_075/d_6ce5.bin" ; $6ce5, 6 bytes
Data_75_6ceb:
	INCBIN "data/bank_075/d_6ceb.bin" ; $6ceb, 12 bytes
Data_75_6cf7:
	INCBIN "data/bank_075/d_6cf7.bin" ; $6cf7, 8 bytes
Data_75_6cff:
	INCBIN "data/bank_075/d_6cff.bin" ; $6cff, 20 bytes
Data_75_6d13:
	INCBIN "data/bank_075/d_6d13.bin" ; $6d13, 6 bytes
Data_75_6d19:
	INCBIN "data/bank_075/d_6d19.bin" ; $6d19, 12 bytes
Data_75_6d25:
	INCBIN "data/bank_075/d_6d25.bin" ; $6d25, 6 bytes
Data_75_6d2b:
	db $07, $04, $02, $00 ; count, flags
	dw $6d35, OamPtrs_75_7350, $6d35, Data_75_6d50, Data_75_6e50, Data_75_6f50 ; body pointers
	INCBIN "data/bank_075/d_6d3b.bin" ; $6d3b, 21 bytes
Data_75_6d50:
	INCBIN "data/bank_075/d_6d50.bin" ; $6d50, 256 bytes
Data_75_6e50:
	INCBIN "data/bank_075/d_6e50.bin" ; $6e50, 256 bytes
Data_75_6f50:
	INCBIN "data/bank_075/d_6f50.bin" ; $6f50, 1024 bytes
OamPtrs_75_7350:
	dw Data_75_7360 ; $7350
	dw Data_75_7363 ; $7352
	dw Data_75_7369 ; $7354
	dw Data_75_7375 ; $7356
	dw Data_75_737d ; $7358
	dw Data_75_7391 ; $735a
	dw Data_75_7391 ; $735c
	dw Data_75_7391 ; $735e
Data_75_7360:
	INCBIN "data/bank_075/d_7360.bin" ; $7360, 3 bytes
Data_75_7363:
	INCBIN "data/bank_075/d_7363.bin" ; $7363, 6 bytes
Data_75_7369:
	INCBIN "data/bank_075/d_7369.bin" ; $7369, 12 bytes
Data_75_7375:
	INCBIN "data/bank_075/d_7375.bin" ; $7375, 8 bytes
Data_75_737d:
	INCBIN "data/bank_075/d_737d.bin" ; $737d, 20 bytes
Data_75_7391:
	INCBIN "data/bank_075/d_7391.bin" ; $7391, 12 bytes
Data_75_739d:
	db $07, $04, $02, $00 ; count, flags
	dw $73a7, OamPtrs_75_7dc0, $73a7, Data_75_73c0, Data_75_74c0, Data_75_75c0 ; body pointers
	INCBIN "data/bank_075/d_73ad.bin" ; $73ad, 19 bytes
Data_75_73c0:
	INCBIN "data/bank_075/d_73c0.bin" ; $73c0, 256 bytes
Data_75_74c0:
	INCBIN "data/bank_075/d_74c0.bin" ; $74c0, 256 bytes
Data_75_75c0:
	INCBIN "data/bank_075/d_75c0.bin" ; $75c0, 2048 bytes
OamPtrs_75_7dc0:
	dw Data_75_7dd0 ; $7dc0
	dw Data_75_7dd3 ; $7dc2
	dw Data_75_7dd9 ; $7dc4
	dw Data_75_7de5 ; $7dc6
	dw Data_75_7ded ; $7dc8
	dw Data_75_7e01 ; $7dca
	dw Data_75_7e09 ; $7dcc
	dw Data_75_7e0e ; $7dce
Data_75_7dd0:
	INCBIN "data/bank_075/d_7dd0.bin" ; $7dd0, 3 bytes
Data_75_7dd3:
	INCBIN "data/bank_075/d_7dd3.bin" ; $7dd3, 6 bytes
Data_75_7dd9:
	INCBIN "data/bank_075/d_7dd9.bin" ; $7dd9, 12 bytes
Data_75_7de5:
	INCBIN "data/bank_075/d_7de5.bin" ; $7de5, 8 bytes
Data_75_7ded:
	INCBIN "data/bank_075/d_7ded.bin" ; $7ded, 20 bytes
Data_75_7e01:
	INCBIN "data/bank_075/d_7e01.bin" ; $7e01, 8 bytes
Data_75_7e09:
	INCBIN "data/bank_075/d_7e09.bin" ; $7e09, 5 bytes
Data_75_7e0e:
	INCBIN "data/bank_075/d_7e0e.bin" ; $7e0e, 12 bytes
	ds 486, $ff ; $7e1a, fill

SECTION "ROM Bank $72", ROMX[$4000], BANK[$72]

DataPtr_72_00:
	dw Data_72_4012 ; $4000
DataPtr_72_02:
	dw Data_72_467d ; $4002
DataPtr_72_04:
	dw Data_72_4ced ; $4004
DataPtr_72_06:
	dw Data_72_566a ; $4006
DataPtr_72_08:
	dw Data_72_5cdd ; $4008
DataPtr_72_0a:
	dw Data_72_634d ; $400a
DataPtr_72_0c:
	dw Data_72_69bd ; $400c
DataPtr_72_0e:
	dw Data_72_702d ; $400e
DataPtr_72_10:
	dw Data_72_769d ; $4010
Data_72_4012:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_72_4630, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_72_4030, Data_72_4130, Data_72_4230 ; frame pointers (continue in body)
	dw Data_72_4230 ; $4022
	dw Data_72_4230 ; $4024
	dw Data_72_4230 ; $4026
	dw Data_72_4230 ; $4028
	dw Data_72_4330 ; $402a
	dw Data_72_4430 ; $402c
	dw Data_72_4530 ; $402e
Data_72_4030:
	INCBIN "data/bank_072/d_4030.bin" ; $4030, 256 bytes
Data_72_4130:
	INCBIN "data/bank_072/d_4130.bin" ; $4130, 256 bytes
Data_72_4230:
	INCBIN "data/bank_072/d_4230.bin" ; $4230, 256 bytes
Data_72_4330:
	INCBIN "data/bank_072/d_4330.bin" ; $4330, 256 bytes
Data_72_4430:
	INCBIN "data/bank_072/d_4430.bin" ; $4430, 256 bytes
Data_72_4530:
	INCBIN "data/bank_072/d_4530.bin" ; $4530, 256 bytes
OamPtrs_72_4630:
	dw Data_72_4640 ; $4630
	dw Data_72_4643 ; $4632
	dw Data_72_4649 ; $4634
	dw Data_72_4655 ; $4636
	dw Data_72_465d ; $4638
	dw Data_72_4671 ; $463a
	dw Data_72_4671 ; $463c
	dw Data_72_4671 ; $463e
Data_72_4640:
	INCBIN "data/bank_072/d_4640.bin" ; $4640, 3 bytes
Data_72_4643:
	INCBIN "data/bank_072/d_4643.bin" ; $4643, 6 bytes
Data_72_4649:
	INCBIN "data/bank_072/d_4649.bin" ; $4649, 12 bytes
Data_72_4655:
	INCBIN "data/bank_072/d_4655.bin" ; $4655, 8 bytes
Data_72_465d:
	INCBIN "data/bank_072/d_465d.bin" ; $465d, 20 bytes
Data_72_4671:
	INCBIN "data/bank_072/d_4671.bin" ; $4671, 12 bytes
Data_72_467d:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_72_4ca0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_72_46a0, Data_72_47a0, Data_72_48a0 ; frame pointers (continue in body)
	dw Data_72_48a0 ; $468d
	dw Data_72_48a0 ; $468f
	dw Data_72_48a0 ; $4691
	dw Data_72_48a0 ; $4693
	dw Data_72_49a0 ; $4695
	dw Data_72_4aa0 ; $4697
	dw Data_72_4ba0 ; $4699
Padding_72_469b:
	; $469b, 5 bytes (fill)
	ds 5, $00
Data_72_46a0:
	INCBIN "data/bank_072/d_46a0.bin" ; $46a0, 256 bytes
Data_72_47a0:
	INCBIN "data/bank_072/d_47a0.bin" ; $47a0, 256 bytes
Data_72_48a0:
	INCBIN "data/bank_072/d_48a0.bin" ; $48a0, 256 bytes
Data_72_49a0:
	INCBIN "data/bank_072/d_49a0.bin" ; $49a0, 256 bytes
Data_72_4aa0:
	INCBIN "data/bank_072/d_4aa0.bin" ; $4aa0, 256 bytes
Data_72_4ba0:
	INCBIN "data/bank_072/d_4ba0.bin" ; $4ba0, 256 bytes
OamPtrs_72_4ca0:
	dw Data_72_4cb0 ; $4ca0
	dw Data_72_4cb3 ; $4ca2
	dw Data_72_4cb9 ; $4ca4
	dw Data_72_4cc5 ; $4ca6
	dw Data_72_4ccd ; $4ca8
	dw Data_72_4ce1 ; $4caa
	dw Data_72_4ce1 ; $4cac
	dw Data_72_4ce1 ; $4cae
Data_72_4cb0:
	INCBIN "data/bank_072/d_4cb0.bin" ; $4cb0, 3 bytes
Data_72_4cb3:
	INCBIN "data/bank_072/d_4cb3.bin" ; $4cb3, 6 bytes
Data_72_4cb9:
	INCBIN "data/bank_072/d_4cb9.bin" ; $4cb9, 12 bytes
Data_72_4cc5:
	INCBIN "data/bank_072/d_4cc5.bin" ; $4cc5, 8 bytes
Data_72_4ccd:
	INCBIN "data/bank_072/d_4ccd.bin" ; $4ccd, 20 bytes
Data_72_4ce1:
	INCBIN "data/bank_072/d_4ce1.bin" ; $4ce1, 12 bytes
Data_72_4ced:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_72_5610, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_72_4d10, Data_72_4e10, Data_72_4f10 ; frame pointers (continue in body)
	dw Data_72_5010 ; $4cfd
	dw Data_72_5110 ; $4cff
	dw Data_72_5210 ; $4d01
	dw Data_72_5210 ; $4d03
	dw Data_72_5310 ; $4d05
	dw Data_72_5410 ; $4d07
	dw Data_72_5510 ; $4d09
Padding_72_4d0b:
	; $4d0b, 5 bytes (fill)
	ds 5, $00
Data_72_4d10:
	INCBIN "data/bank_072/d_4d10.bin" ; $4d10, 256 bytes
Data_72_4e10:
	INCBIN "data/bank_072/d_4e10.bin" ; $4e10, 256 bytes
Data_72_4f10:
	INCBIN "data/bank_072/d_4f10.bin" ; $4f10, 256 bytes
Data_72_5010:
	INCBIN "data/bank_072/d_5010.bin" ; $5010, 256 bytes
Data_72_5110:
	INCBIN "data/bank_072/d_5110.bin" ; $5110, 256 bytes
Data_72_5210:
	INCBIN "data/bank_072/d_5210.bin" ; $5210, 256 bytes
Data_72_5310:
	INCBIN "data/bank_072/d_5310.bin" ; $5310, 256 bytes
Data_72_5410:
	INCBIN "data/bank_072/d_5410.bin" ; $5410, 256 bytes
Data_72_5510:
	INCBIN "data/bank_072/d_5510.bin" ; $5510, 256 bytes
OamPtrs_72_5610:
	dw Data_72_5620 ; $5610
	dw Data_72_5623 ; $5612
	dw Data_72_5629 ; $5614
	dw Data_72_5635 ; $5616
	dw Data_72_563d ; $5618
	dw Data_72_5651 ; $561a
	dw Data_72_5659 ; $561c
	dw Data_72_565e ; $561e
Data_72_5620:
	INCBIN "data/bank_072/d_5620.bin" ; $5620, 3 bytes
Data_72_5623:
	INCBIN "data/bank_072/d_5623.bin" ; $5623, 6 bytes
Data_72_5629:
	INCBIN "data/bank_072/d_5629.bin" ; $5629, 12 bytes
Data_72_5635:
	INCBIN "data/bank_072/d_5635.bin" ; $5635, 8 bytes
Data_72_563d:
	INCBIN "data/bank_072/d_563d.bin" ; $563d, 20 bytes
Data_72_5651:
	INCBIN "data/bank_072/d_5651.bin" ; $5651, 8 bytes
Data_72_5659:
	INCBIN "data/bank_072/d_5659.bin" ; $5659, 5 bytes
Data_72_565e:
	INCBIN "data/bank_072/d_565e.bin" ; $565e, 12 bytes
Data_72_566a:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_72_5c90, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_72_5690, Data_72_5790, Data_72_5890 ; frame pointers (continue in body)
	dw Data_72_5890 ; $567a
	dw Data_72_5890 ; $567c
	dw Data_72_5890 ; $567e
	dw Data_72_5890 ; $5680
	dw Data_72_5990 ; $5682
	dw Data_72_5a90 ; $5684
	dw Data_72_5b90 ; $5686
Padding_72_5688:
	; $5688, 8 bytes (fill)
	ds 8, $00
Data_72_5690:
	INCBIN "data/bank_072/d_5690.bin" ; $5690, 256 bytes
Data_72_5790:
	INCBIN "data/bank_072/d_5790.bin" ; $5790, 256 bytes
Data_72_5890:
	INCBIN "data/bank_072/d_5890.bin" ; $5890, 256 bytes
Data_72_5990:
	INCBIN "data/bank_072/d_5990.bin" ; $5990, 256 bytes
Data_72_5a90:
	INCBIN "data/bank_072/d_5a90.bin" ; $5a90, 256 bytes
Data_72_5b90:
	INCBIN "data/bank_072/d_5b90.bin" ; $5b90, 256 bytes
OamPtrs_72_5c90:
	dw Data_72_5ca0 ; $5c90
	dw Data_72_5ca3 ; $5c92
	dw Data_72_5ca9 ; $5c94
	dw Data_72_5cb5 ; $5c96
	dw Data_72_5cbd ; $5c98
	dw Data_72_5cd1 ; $5c9a
	dw Data_72_5cd1 ; $5c9c
	dw Data_72_5cd1 ; $5c9e
Data_72_5ca0:
	INCBIN "data/bank_072/d_5ca0.bin" ; $5ca0, 3 bytes
Data_72_5ca3:
	INCBIN "data/bank_072/d_5ca3.bin" ; $5ca3, 6 bytes
Data_72_5ca9:
	INCBIN "data/bank_072/d_5ca9.bin" ; $5ca9, 12 bytes
Data_72_5cb5:
	INCBIN "data/bank_072/d_5cb5.bin" ; $5cb5, 8 bytes
Data_72_5cbd:
	INCBIN "data/bank_072/d_5cbd.bin" ; $5cbd, 20 bytes
Data_72_5cd1:
	INCBIN "data/bank_072/d_5cd1.bin" ; $5cd1, 12 bytes
Data_72_5cdd:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_72_6300, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_72_5d00, Data_72_5e00, Data_72_5f00 ; frame pointers (continue in body)
	dw Data_72_5f00 ; $5ced
	dw Data_72_5f00 ; $5cef
	dw Data_72_5f00 ; $5cf1
	dw Data_72_5f00 ; $5cf3
	dw Data_72_6000 ; $5cf5
	dw Data_72_6100 ; $5cf7
	dw Data_72_6200 ; $5cf9
Padding_72_5cfb:
	; $5cfb, 5 bytes (fill)
	ds 5, $00
Data_72_5d00:
	INCBIN "data/bank_072/d_5d00.bin" ; $5d00, 256 bytes
Data_72_5e00:
	INCBIN "data/bank_072/d_5e00.bin" ; $5e00, 256 bytes
Data_72_5f00:
	INCBIN "data/bank_072/d_5f00.bin" ; $5f00, 256 bytes
Data_72_6000:
	INCBIN "data/bank_072/d_6000.bin" ; $6000, 256 bytes
Data_72_6100:
	INCBIN "data/bank_072/d_6100.bin" ; $6100, 256 bytes
Data_72_6200:
	INCBIN "data/bank_072/d_6200.bin" ; $6200, 256 bytes
OamPtrs_72_6300:
	dw Data_72_6310 ; $6300
	dw Data_72_6313 ; $6302
	dw Data_72_6319 ; $6304
	dw Data_72_6325 ; $6306
	dw Data_72_632d ; $6308
	dw Data_72_6341 ; $630a
	dw Data_72_6341 ; $630c
	dw Data_72_6341 ; $630e
Data_72_6310:
	INCBIN "data/bank_072/d_6310.bin" ; $6310, 3 bytes
Data_72_6313:
	INCBIN "data/bank_072/d_6313.bin" ; $6313, 6 bytes
Data_72_6319:
	INCBIN "data/bank_072/d_6319.bin" ; $6319, 12 bytes
Data_72_6325:
	INCBIN "data/bank_072/d_6325.bin" ; $6325, 8 bytes
Data_72_632d:
	INCBIN "data/bank_072/d_632d.bin" ; $632d, 20 bytes
Data_72_6341:
	INCBIN "data/bank_072/d_6341.bin" ; $6341, 12 bytes
Data_72_634d:
	db $07, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_72_6970, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_72_6370, Data_72_6470, Data_72_6570 ; frame pointers (continue in body)
	dw Data_72_6570 ; $635d
	dw Data_72_6570 ; $635f
	dw Data_72_6570 ; $6361
	dw Data_72_6570 ; $6363
	dw Data_72_6670 ; $6365
	dw Data_72_6770 ; $6367
	dw Data_72_6870 ; $6369
Padding_72_636b:
	; $636b, 5 bytes (fill)
	ds 5, $00
Data_72_6370:
	INCBIN "data/bank_072/d_6370.bin" ; $6370, 256 bytes
Data_72_6470:
	INCBIN "data/bank_072/d_6470.bin" ; $6470, 256 bytes
Data_72_6570:
	INCBIN "data/bank_072/d_6570.bin" ; $6570, 256 bytes
Data_72_6670:
	INCBIN "data/bank_072/d_6670.bin" ; $6670, 256 bytes
Data_72_6770:
	INCBIN "data/bank_072/d_6770.bin" ; $6770, 256 bytes
Data_72_6870:
	INCBIN "data/bank_072/d_6870.bin" ; $6870, 256 bytes
OamPtrs_72_6970:
	dw Data_72_6980 ; $6970
	dw Data_72_6983 ; $6972
	dw Data_72_6989 ; $6974
	dw Data_72_6995 ; $6976
	dw Data_72_699d ; $6978
	dw Data_72_69b1 ; $697a
	dw Data_72_69b1 ; $697c
	dw Data_72_69b1 ; $697e
Data_72_6980:
	INCBIN "data/bank_072/d_6980.bin" ; $6980, 3 bytes
Data_72_6983:
	INCBIN "data/bank_072/d_6983.bin" ; $6983, 6 bytes
Data_72_6989:
	INCBIN "data/bank_072/d_6989.bin" ; $6989, 12 bytes
Data_72_6995:
	INCBIN "data/bank_072/d_6995.bin" ; $6995, 8 bytes
Data_72_699d:
	INCBIN "data/bank_072/d_699d.bin" ; $699d, 20 bytes
Data_72_69b1:
	INCBIN "data/bank_072/d_69b1.bin" ; $69b1, 12 bytes
Data_72_69bd:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_72_6fe0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_72_69e0, Data_72_6ae0, Data_72_6be0 ; frame pointers (continue in body)
	dw Data_72_6be0 ; $69cd
	dw Data_72_6be0 ; $69cf
	dw Data_72_6be0 ; $69d1
	dw Data_72_6be0 ; $69d3
	dw Data_72_6ce0 ; $69d5
	dw Data_72_6de0 ; $69d7
	dw Data_72_6ee0 ; $69d9
Padding_72_69db:
	; $69db, 5 bytes (fill)
	ds 5, $00
Data_72_69e0:
	INCBIN "data/bank_072/d_69e0.bin" ; $69e0, 256 bytes
Data_72_6ae0:
	INCBIN "data/bank_072/d_6ae0.bin" ; $6ae0, 256 bytes
Data_72_6be0:
	INCBIN "data/bank_072/d_6be0.bin" ; $6be0, 256 bytes
Data_72_6ce0:
	INCBIN "data/bank_072/d_6ce0.bin" ; $6ce0, 256 bytes
Data_72_6de0:
	INCBIN "data/bank_072/d_6de0.bin" ; $6de0, 256 bytes
Data_72_6ee0:
	INCBIN "data/bank_072/d_6ee0.bin" ; $6ee0, 256 bytes
OamPtrs_72_6fe0:
	dw Data_72_6ff0 ; $6fe0
	dw Data_72_6ff3 ; $6fe2
	dw Data_72_6ff9 ; $6fe4
	dw Data_72_7005 ; $6fe6
	dw Data_72_700d ; $6fe8
	dw Data_72_7021 ; $6fea
	dw Data_72_7021 ; $6fec
	dw Data_72_7021 ; $6fee
Data_72_6ff0:
	INCBIN "data/bank_072/d_6ff0.bin" ; $6ff0, 3 bytes
Data_72_6ff3:
	INCBIN "data/bank_072/d_6ff3.bin" ; $6ff3, 6 bytes
Data_72_6ff9:
	INCBIN "data/bank_072/d_6ff9.bin" ; $6ff9, 12 bytes
Data_72_7005:
	INCBIN "data/bank_072/d_7005.bin" ; $7005, 8 bytes
Data_72_700d:
	INCBIN "data/bank_072/d_700d.bin" ; $700d, 20 bytes
Data_72_7021:
	INCBIN "data/bank_072/d_7021.bin" ; $7021, 12 bytes
Data_72_702d:
	db $04, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_72_7650, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_72_7050, Data_72_7150, Data_72_7250 ; frame pointers (continue in body)
	dw Data_72_7250 ; $703d
	dw Data_72_7250 ; $703f
	dw Data_72_7250 ; $7041
	dw Data_72_7250 ; $7043
	dw Data_72_7350 ; $7045
	dw Data_72_7450 ; $7047
	dw Data_72_7550 ; $7049
Padding_72_704b:
	; $704b, 5 bytes (fill)
	ds 5, $00
Data_72_7050:
	INCBIN "data/bank_072/d_7050.bin" ; $7050, 256 bytes
Data_72_7150:
	INCBIN "data/bank_072/d_7150.bin" ; $7150, 256 bytes
Data_72_7250:
	INCBIN "data/bank_072/d_7250.bin" ; $7250, 256 bytes
Data_72_7350:
	INCBIN "data/bank_072/d_7350.bin" ; $7350, 256 bytes
Data_72_7450:
	INCBIN "data/bank_072/d_7450.bin" ; $7450, 256 bytes
Data_72_7550:
	INCBIN "data/bank_072/d_7550.bin" ; $7550, 256 bytes
OamPtrs_72_7650:
	dw Data_72_7660 ; $7650
	dw Data_72_7663 ; $7652
	dw Data_72_7669 ; $7654
	dw Data_72_7675 ; $7656
	dw Data_72_767d ; $7658
	dw Data_72_7691 ; $765a
	dw Data_72_7691 ; $765c
	dw Data_72_7691 ; $765e
Data_72_7660:
	INCBIN "data/bank_072/d_7660.bin" ; $7660, 3 bytes
Data_72_7663:
	INCBIN "data/bank_072/d_7663.bin" ; $7663, 6 bytes
Data_72_7669:
	INCBIN "data/bank_072/d_7669.bin" ; $7669, 12 bytes
Data_72_7675:
	INCBIN "data/bank_072/d_7675.bin" ; $7675, 8 bytes
Data_72_767d:
	INCBIN "data/bank_072/d_767d.bin" ; $767d, 20 bytes
Data_72_7691:
	INCBIN "data/bank_072/d_7691.bin" ; $7691, 12 bytes
Data_72_769d:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_72_7cc0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_72_76c0, Data_72_77c0, Data_72_78c0 ; frame pointers (continue in body)
	dw Data_72_78c0 ; $76ad
	dw Data_72_78c0 ; $76af
	dw Data_72_78c0 ; $76b1
	dw Data_72_78c0 ; $76b3
	dw Data_72_79c0 ; $76b5
	dw Data_72_7ac0 ; $76b7
	dw Data_72_7bc0 ; $76b9
Padding_72_76bb:
	; $76bb, 5 bytes (fill)
	ds 5, $00
Data_72_76c0:
	INCBIN "data/bank_072/d_76c0.bin" ; $76c0, 256 bytes
Data_72_77c0:
	INCBIN "data/bank_072/d_77c0.bin" ; $77c0, 256 bytes
Data_72_78c0:
	INCBIN "data/bank_072/d_78c0.bin" ; $78c0, 256 bytes
Data_72_79c0:
	INCBIN "data/bank_072/d_79c0.bin" ; $79c0, 256 bytes
Data_72_7ac0:
	INCBIN "data/bank_072/d_7ac0.bin" ; $7ac0, 256 bytes
Data_72_7bc0:
	INCBIN "data/bank_072/d_7bc0.bin" ; $7bc0, 256 bytes
OamPtrs_72_7cc0:
	dw Data_72_7cd0 ; $7cc0
	dw Data_72_7cd3 ; $7cc2
	dw Data_72_7cd9 ; $7cc4
	dw Data_72_7ce5 ; $7cc6
	dw Data_72_7ced ; $7cc8
	dw Data_72_7d01 ; $7cca
	dw Data_72_7d01 ; $7ccc
	dw Data_72_7d01 ; $7cce
Data_72_7cd0:
	INCBIN "data/bank_072/d_7cd0.bin" ; $7cd0, 3 bytes
Data_72_7cd3:
	INCBIN "data/bank_072/d_7cd3.bin" ; $7cd3, 6 bytes
Data_72_7cd9:
	INCBIN "data/bank_072/d_7cd9.bin" ; $7cd9, 12 bytes
Data_72_7ce5:
	INCBIN "data/bank_072/d_7ce5.bin" ; $7ce5, 8 bytes
Data_72_7ced:
	INCBIN "data/bank_072/d_7ced.bin" ; $7ced, 20 bytes
Data_72_7d01:
	INCBIN "data/bank_072/d_7d01.bin" ; $7d01, 12 bytes
	; $7d0d, 755 bytes fill to bank end (linker-padded)

INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $71", ROMX[$4000], BANK[$71]

DataPtr_71_00:
	dw Data_71_4014 ; $4000
DataPtr_71_02:
	dw Data_71_468d ; $4002
DataPtr_71_04:
	dw Data_71_4cfd ; $4004
DataPtr_71_06:
	dw Data_71_536d ; $4006
DataPtr_71_08:
	dw Data_71_59dd ; $4008
DataPtr_71_0a:
	dw Data_71_604d ; $400a
DataPtr_71_0c:
	dw Data_71_69cc ; $400c
DataPtr_71_0e:
	dw Data_71_734c ; $400e
DataPtr_71_10:
	dw Data_71_7ccc ; $4010
DataPtr_71_12:
	dw Data_71_7d43 ; $4012
Data_71_4014:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_4640, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_71_4040, Data_71_4140, Data_71_4240 ; frame pointers (continue in body)
	dw Data_71_4240 ; $4024
	dw Data_71_4240 ; $4026
	dw Data_71_4240 ; $4028
	dw Data_71_4240 ; $402a
	dw Data_71_4340 ; $402c
	dw Data_71_4440 ; $402e
	dw Data_71_4540 ; $4030
	INCBIN "data/bank_071/d_4032.bin" ; $4032, 14 bytes
Data_71_4040:
	INCBIN "data/bank_071/d_4040.bin" ; $4040, 256 bytes
Data_71_4140:
	INCBIN "data/bank_071/d_4140.bin" ; $4140, 256 bytes
Data_71_4240:
	INCBIN "data/bank_071/d_4240.bin" ; $4240, 256 bytes
Data_71_4340:
	INCBIN "data/bank_071/d_4340.bin" ; $4340, 256 bytes
Data_71_4440:
	INCBIN "data/bank_071/d_4440.bin" ; $4440, 256 bytes
Data_71_4540:
	INCBIN "data/bank_071/d_4540.bin" ; $4540, 256 bytes
OamPtrs_71_4640:
	dw Data_71_4650 ; $4640
	dw Data_71_4653 ; $4642
	dw Data_71_4659 ; $4644
	dw Data_71_4665 ; $4646
	dw Data_71_466d ; $4648
	dw Data_71_4681 ; $464a
	dw Data_71_4681 ; $464c
	dw Data_71_4681 ; $464e
Data_71_4650:
	INCBIN "data/bank_071/d_4650.bin" ; $4650, 3 bytes
Data_71_4653:
	INCBIN "data/bank_071/d_4653.bin" ; $4653, 6 bytes
Data_71_4659:
	INCBIN "data/bank_071/d_4659.bin" ; $4659, 12 bytes
Data_71_4665:
	INCBIN "data/bank_071/d_4665.bin" ; $4665, 8 bytes
Data_71_466d:
	INCBIN "data/bank_071/d_466d.bin" ; $466d, 20 bytes
Data_71_4681:
	INCBIN "data/bank_071/d_4681.bin" ; $4681, 12 bytes
Data_71_468d:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_4cb0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_71_46b0, Data_71_47b0, Data_71_48b0 ; frame pointers (continue in body)
	dw Data_71_48b0 ; $469d
	dw Data_71_48b0 ; $469f
	dw Data_71_48b0 ; $46a1
	dw Data_71_48b0 ; $46a3
	dw Data_71_49b0 ; $46a5
	dw Data_71_4ab0 ; $46a7
	dw Data_71_4bb0 ; $46a9
	INCBIN "data/bank_071/d_46ab.bin" ; $46ab, 5 bytes
Data_71_46b0:
	INCBIN "data/bank_071/d_46b0.bin" ; $46b0, 256 bytes
Data_71_47b0:
	INCBIN "data/bank_071/d_47b0.bin" ; $47b0, 256 bytes
Data_71_48b0:
	INCBIN "data/bank_071/d_48b0.bin" ; $48b0, 256 bytes
Data_71_49b0:
	INCBIN "data/bank_071/d_49b0.bin" ; $49b0, 256 bytes
Data_71_4ab0:
	INCBIN "data/bank_071/d_4ab0.bin" ; $4ab0, 256 bytes
Data_71_4bb0:
	INCBIN "data/bank_071/d_4bb0.bin" ; $4bb0, 256 bytes
OamPtrs_71_4cb0:
	dw Data_71_4cc0 ; $4cb0
	dw Data_71_4cc3 ; $4cb2
	dw Data_71_4cc9 ; $4cb4
	dw Data_71_4cd5 ; $4cb6
	dw Data_71_4cdd ; $4cb8
	dw Data_71_4cf1 ; $4cba
	dw Data_71_4cf1 ; $4cbc
	dw Data_71_4cf1 ; $4cbe
Data_71_4cc0:
	INCBIN "data/bank_071/d_4cc0.bin" ; $4cc0, 3 bytes
Data_71_4cc3:
	INCBIN "data/bank_071/d_4cc3.bin" ; $4cc3, 6 bytes
Data_71_4cc9:
	INCBIN "data/bank_071/d_4cc9.bin" ; $4cc9, 12 bytes
Data_71_4cd5:
	INCBIN "data/bank_071/d_4cd5.bin" ; $4cd5, 8 bytes
Data_71_4cdd:
	INCBIN "data/bank_071/d_4cdd.bin" ; $4cdd, 20 bytes
Data_71_4cf1:
	INCBIN "data/bank_071/d_4cf1.bin" ; $4cf1, 12 bytes
Data_71_4cfd:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_5320, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_71_4d20, Data_71_4e20, Data_71_4f20 ; frame pointers (continue in body)
	dw Data_71_4f20 ; $4d0d
	dw Data_71_4f20 ; $4d0f
	dw Data_71_4f20 ; $4d11
	dw Data_71_4f20 ; $4d13
	dw Data_71_5020 ; $4d15
	dw Data_71_5120 ; $4d17
	dw Data_71_5220 ; $4d19
	INCBIN "data/bank_071/d_4d1b.bin" ; $4d1b, 5 bytes
Data_71_4d20:
	INCBIN "data/bank_071/d_4d20.bin" ; $4d20, 256 bytes
Data_71_4e20:
	INCBIN "data/bank_071/d_4e20.bin" ; $4e20, 256 bytes
Data_71_4f20:
	INCBIN "data/bank_071/d_4f20.bin" ; $4f20, 256 bytes
Data_71_5020:
	INCBIN "data/bank_071/d_5020.bin" ; $5020, 256 bytes
Data_71_5120:
	INCBIN "data/bank_071/d_5120.bin" ; $5120, 256 bytes
Data_71_5220:
	INCBIN "data/bank_071/d_5220.bin" ; $5220, 256 bytes
OamPtrs_71_5320:
	dw Data_71_5330 ; $5320
	dw Data_71_5333 ; $5322
	dw Data_71_5339 ; $5324
	dw Data_71_5345 ; $5326
	dw Data_71_534d ; $5328
	dw Data_71_5361 ; $532a
	dw Data_71_5361 ; $532c
	dw Data_71_5361 ; $532e
Data_71_5330:
	INCBIN "data/bank_071/d_5330.bin" ; $5330, 3 bytes
Data_71_5333:
	INCBIN "data/bank_071/d_5333.bin" ; $5333, 6 bytes
Data_71_5339:
	INCBIN "data/bank_071/d_5339.bin" ; $5339, 12 bytes
Data_71_5345:
	INCBIN "data/bank_071/d_5345.bin" ; $5345, 8 bytes
Data_71_534d:
	INCBIN "data/bank_071/d_534d.bin" ; $534d, 20 bytes
Data_71_5361:
	INCBIN "data/bank_071/d_5361.bin" ; $5361, 12 bytes
Data_71_536d:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_5990, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_71_5390, Data_71_5490, Data_71_5590 ; frame pointers (continue in body)
	dw Data_71_5590 ; $537d
	dw Data_71_5590 ; $537f
	dw Data_71_5590 ; $5381
	dw Data_71_5590 ; $5383
	dw Data_71_5690 ; $5385
	dw Data_71_5790 ; $5387
	dw Data_71_5890 ; $5389
	INCBIN "data/bank_071/d_538b.bin" ; $538b, 5 bytes
Data_71_5390:
	INCBIN "data/bank_071/d_5390.bin" ; $5390, 256 bytes
Data_71_5490:
	INCBIN "data/bank_071/d_5490.bin" ; $5490, 256 bytes
Data_71_5590:
	INCBIN "data/bank_071/d_5590.bin" ; $5590, 256 bytes
Data_71_5690:
	INCBIN "data/bank_071/d_5690.bin" ; $5690, 256 bytes
Data_71_5790:
	INCBIN "data/bank_071/d_5790.bin" ; $5790, 256 bytes
Data_71_5890:
	INCBIN "data/bank_071/d_5890.bin" ; $5890, 256 bytes
OamPtrs_71_5990:
	dw Data_71_59a0 ; $5990
	dw Data_71_59a3 ; $5992
	dw Data_71_59a9 ; $5994
	dw Data_71_59b5 ; $5996
	dw Data_71_59bd ; $5998
	dw Data_71_59d1 ; $599a
	dw Data_71_59d1 ; $599c
	dw Data_71_59d1 ; $599e
Data_71_59a0:
	INCBIN "data/bank_071/d_59a0.bin" ; $59a0, 3 bytes
Data_71_59a3:
	INCBIN "data/bank_071/d_59a3.bin" ; $59a3, 6 bytes
Data_71_59a9:
	INCBIN "data/bank_071/d_59a9.bin" ; $59a9, 12 bytes
Data_71_59b5:
	INCBIN "data/bank_071/d_59b5.bin" ; $59b5, 8 bytes
Data_71_59bd:
	INCBIN "data/bank_071/d_59bd.bin" ; $59bd, 20 bytes
Data_71_59d1:
	INCBIN "data/bank_071/d_59d1.bin" ; $59d1, 12 bytes
Data_71_59dd:
	db $06, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_6000, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_71_5a00, Data_71_5b00, Data_71_5c00 ; frame pointers (continue in body)
	dw Data_71_5c00 ; $59ed
	dw Data_71_5c00 ; $59ef
	dw Data_71_5c00 ; $59f1
	dw Data_71_5c00 ; $59f3
	dw Data_71_5d00 ; $59f5
	dw Data_71_5e00 ; $59f7
	dw Data_71_5f00 ; $59f9
	INCBIN "data/bank_071/d_59fb.bin" ; $59fb, 5 bytes
Data_71_5a00:
	INCBIN "data/bank_071/d_5a00.bin" ; $5a00, 256 bytes
Data_71_5b00:
	INCBIN "data/bank_071/d_5b00.bin" ; $5b00, 256 bytes
Data_71_5c00:
	INCBIN "data/bank_071/d_5c00.bin" ; $5c00, 256 bytes
Data_71_5d00:
	INCBIN "data/bank_071/d_5d00.bin" ; $5d00, 256 bytes
Data_71_5e00:
	INCBIN "data/bank_071/d_5e00.bin" ; $5e00, 256 bytes
Data_71_5f00:
	INCBIN "data/bank_071/d_5f00.bin" ; $5f00, 256 bytes
OamPtrs_71_6000:
	dw Data_71_6010 ; $6000
	dw Data_71_6013 ; $6002
	dw Data_71_6019 ; $6004
	dw Data_71_6025 ; $6006
	dw Data_71_602d ; $6008
	dw Data_71_6041 ; $600a
	dw Data_71_6041 ; $600c
	dw Data_71_6041 ; $600e
Data_71_6010:
	INCBIN "data/bank_071/d_6010.bin" ; $6010, 3 bytes
Data_71_6013:
	INCBIN "data/bank_071/d_6013.bin" ; $6013, 6 bytes
Data_71_6019:
	INCBIN "data/bank_071/d_6019.bin" ; $6019, 12 bytes
Data_71_6025:
	INCBIN "data/bank_071/d_6025.bin" ; $6025, 8 bytes
Data_71_602d:
	INCBIN "data/bank_071/d_602d.bin" ; $602d, 20 bytes
Data_71_6041:
	INCBIN "data/bank_071/d_6041.bin" ; $6041, 12 bytes
Data_71_604d:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_6970, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_71_6070, Data_71_6170, Data_71_6270 ; frame pointers (continue in body)
	dw Data_71_6270 ; $605d
	dw Data_71_6370 ; $605f
	dw Data_71_6470 ; $6061
	dw Data_71_6570 ; $6063
	dw Data_71_6670 ; $6065
	dw Data_71_6770 ; $6067
	dw Data_71_6870 ; $6069
	INCBIN "data/bank_071/d_606b.bin" ; $606b, 5 bytes
Data_71_6070:
	INCBIN "data/bank_071/d_6070.bin" ; $6070, 256 bytes
Data_71_6170:
	INCBIN "data/bank_071/d_6170.bin" ; $6170, 256 bytes
Data_71_6270:
	INCBIN "data/bank_071/d_6270.bin" ; $6270, 256 bytes
Data_71_6370:
	INCBIN "data/bank_071/d_6370.bin" ; $6370, 256 bytes
Data_71_6470:
	INCBIN "data/bank_071/d_6470.bin" ; $6470, 256 bytes
Data_71_6570:
	INCBIN "data/bank_071/d_6570.bin" ; $6570, 256 bytes
Data_71_6670:
	INCBIN "data/bank_071/d_6670.bin" ; $6670, 256 bytes
Data_71_6770:
	INCBIN "data/bank_071/d_6770.bin" ; $6770, 256 bytes
Data_71_6870:
	INCBIN "data/bank_071/d_6870.bin" ; $6870, 256 bytes
OamPtrs_71_6970:
	dw Data_71_6982 ; $6970
	dw Data_71_6985 ; $6972
	dw Data_71_698b ; $6974
	dw Data_71_6997 ; $6976
	dw Data_71_699f ; $6978
	dw Data_71_69b3 ; $697a
	dw Data_71_69b3 ; $697c
	dw Data_71_69b8 ; $697e
	dw Data_71_69c4 ; $6980
Data_71_6982:
	INCBIN "data/bank_071/d_6982.bin" ; $6982, 3 bytes
Data_71_6985:
	INCBIN "data/bank_071/d_6985.bin" ; $6985, 6 bytes
Data_71_698b:
	INCBIN "data/bank_071/d_698b.bin" ; $698b, 12 bytes
Data_71_6997:
	INCBIN "data/bank_071/d_6997.bin" ; $6997, 8 bytes
Data_71_699f:
	INCBIN "data/bank_071/d_699f.bin" ; $699f, 20 bytes
Data_71_69b3:
	INCBIN "data/bank_071/d_69b3.bin" ; $69b3, 5 bytes
Data_71_69b8:
	INCBIN "data/bank_071/d_69b8.bin" ; $69b8, 12 bytes
Data_71_69c4:
	INCBIN "data/bank_071/d_69c4.bin" ; $69c4, 8 bytes
Data_71_69cc:
	db $03, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_72f0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_71_69f0, Data_71_6af0, Data_71_6bf0 ; frame pointers (continue in body)
	dw Data_71_6bf0 ; $69dc
	dw Data_71_6cf0 ; $69de
	dw Data_71_6df0 ; $69e0
	dw Data_71_6ef0 ; $69e2
	dw Data_71_6ff0 ; $69e4
	dw Data_71_70f0 ; $69e6
	dw Data_71_71f0 ; $69e8
	INCBIN "data/bank_071/d_69ea.bin" ; $69ea, 6 bytes
Data_71_69f0:
	INCBIN "data/bank_071/d_69f0.bin" ; $69f0, 256 bytes
Data_71_6af0:
	INCBIN "data/bank_071/d_6af0.bin" ; $6af0, 256 bytes
Data_71_6bf0:
	INCBIN "data/bank_071/d_6bf0.bin" ; $6bf0, 256 bytes
Data_71_6cf0:
	INCBIN "data/bank_071/d_6cf0.bin" ; $6cf0, 256 bytes
Data_71_6df0:
	INCBIN "data/bank_071/d_6df0.bin" ; $6df0, 256 bytes
Data_71_6ef0:
	INCBIN "data/bank_071/d_6ef0.bin" ; $6ef0, 256 bytes
Data_71_6ff0:
	INCBIN "data/bank_071/d_6ff0.bin" ; $6ff0, 256 bytes
Data_71_70f0:
	INCBIN "data/bank_071/d_70f0.bin" ; $70f0, 256 bytes
Data_71_71f0:
	INCBIN "data/bank_071/d_71f0.bin" ; $71f0, 256 bytes
OamPtrs_71_72f0:
	dw Data_71_7302 ; $72f0
	dw Data_71_7305 ; $72f2
	dw Data_71_730b ; $72f4
	dw Data_71_7317 ; $72f6
	dw Data_71_731f ; $72f8
	dw Data_71_7333 ; $72fa
	dw Data_71_7333 ; $72fc
	dw Data_71_7338 ; $72fe
	dw Data_71_7344 ; $7300
Data_71_7302:
	INCBIN "data/bank_071/d_7302.bin" ; $7302, 3 bytes
Data_71_7305:
	INCBIN "data/bank_071/d_7305.bin" ; $7305, 6 bytes
Data_71_730b:
	INCBIN "data/bank_071/d_730b.bin" ; $730b, 12 bytes
Data_71_7317:
	INCBIN "data/bank_071/d_7317.bin" ; $7317, 8 bytes
Data_71_731f:
	INCBIN "data/bank_071/d_731f.bin" ; $731f, 20 bytes
Data_71_7333:
	INCBIN "data/bank_071/d_7333.bin" ; $7333, 5 bytes
Data_71_7338:
	INCBIN "data/bank_071/d_7338.bin" ; $7338, 12 bytes
Data_71_7344:
	INCBIN "data/bank_071/d_7344.bin" ; $7344, 8 bytes
Data_71_734c:
	db $05, $04, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_7c70, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_71_7370, Data_71_7470, Data_71_7570 ; frame pointers (continue in body)
	dw Data_71_7570 ; $735c
	dw Data_71_7670 ; $735e
	dw Data_71_7770 ; $7360
	dw Data_71_7870 ; $7362
	dw Data_71_7970 ; $7364
	dw Data_71_7a70 ; $7366
	dw Data_71_7b70 ; $7368
	INCBIN "data/bank_071/d_736a.bin" ; $736a, 6 bytes
Data_71_7370:
	INCBIN "data/bank_071/d_7370.bin" ; $7370, 256 bytes
Data_71_7470:
	INCBIN "data/bank_071/d_7470.bin" ; $7470, 256 bytes
Data_71_7570:
	INCBIN "data/bank_071/d_7570.bin" ; $7570, 256 bytes
Data_71_7670:
	INCBIN "data/bank_071/d_7670.bin" ; $7670, 256 bytes
Data_71_7770:
	INCBIN "data/bank_071/d_7770.bin" ; $7770, 256 bytes
Data_71_7870:
	INCBIN "data/bank_071/d_7870.bin" ; $7870, 256 bytes
Data_71_7970:
	INCBIN "data/bank_071/d_7970.bin" ; $7970, 256 bytes
Data_71_7a70:
	INCBIN "data/bank_071/d_7a70.bin" ; $7a70, 256 bytes
Data_71_7b70:
	INCBIN "data/bank_071/d_7b70.bin" ; $7b70, 256 bytes
OamPtrs_71_7c70:
	dw Data_71_7c82 ; $7c70
	dw Data_71_7c85 ; $7c72
	dw Data_71_7c8b ; $7c74
	dw Data_71_7c97 ; $7c76
	dw Data_71_7c9f ; $7c78
	dw Data_71_7cb3 ; $7c7a
	dw Data_71_7cb3 ; $7c7c
	dw Data_71_7cb8 ; $7c7e
	dw Data_71_7cc4 ; $7c80
Data_71_7c82:
	INCBIN "data/bank_071/d_7c82.bin" ; $7c82, 3 bytes
Data_71_7c85:
	INCBIN "data/bank_071/d_7c85.bin" ; $7c85, 6 bytes
Data_71_7c8b:
	INCBIN "data/bank_071/d_7c8b.bin" ; $7c8b, 12 bytes
Data_71_7c97:
	INCBIN "data/bank_071/d_7c97.bin" ; $7c97, 8 bytes
Data_71_7c9f:
	INCBIN "data/bank_071/d_7c9f.bin" ; $7c9f, 20 bytes
Data_71_7cb3:
	INCBIN "data/bank_071/d_7cb3.bin" ; $7cb3, 5 bytes
Data_71_7cb8:
	INCBIN "data/bank_071/d_7cb8.bin" ; $7cb8, 12 bytes
Data_71_7cc4:
	INCBIN "data/bank_071/d_7cc4.bin" ; $7cc4, 8 bytes
Data_71_7ccc:
	db $05, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_7d30, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_71_7cf0, OamPtrs_71_7d30, OamPtrs_71_7d30 ; frame pointers (continue in body)
	dw OamPtrs_71_7d30 ; $7cdc
	dw OamPtrs_71_7d30 ; $7cde
	dw OamPtrs_71_7d30 ; $7ce0
	dw OamPtrs_71_7d30 ; $7ce2
	dw OamPtrs_71_7d30 ; $7ce4
	dw OamPtrs_71_7d30 ; $7ce6
	dw OamPtrs_71_7d30 ; $7ce8
	INCBIN "data/bank_071/d_7cea.bin" ; $7cea, 6 bytes
Data_71_7cf0:
	INCBIN "data/bank_071/d_7cf0.bin" ; $7cf0, 64 bytes
OamPtrs_71_7d30:
	dw Data_71_7d40 ; $7d30
	dw Data_71_7d40 ; $7d32
	dw Data_71_7d40 ; $7d34
	dw Data_71_7d40 ; $7d36
	dw Data_71_7d40 ; $7d38
	dw Data_71_7d40 ; $7d3a
	dw Data_71_7d40 ; $7d3c
	dw Data_71_7d40 ; $7d3e
Data_71_7d40:
	INCBIN "data/bank_071/d_7d40.bin" ; $7d40, 3 bytes
Data_71_7d43:
	db $03, $01, $02, $00 ; count, flags
	dw .frames, OamPtrs_71_7de0, .frames ; frame array, OAM array, frame array
.frames:
	dw Data_71_7d60, Data_71_7da0, $0000 ; frame pointers (continue in body)
	INCBIN "data/bank_071/d_7d53.bin" ; $7d53, 13 bytes
Data_71_7d60:
	INCBIN "data/bank_071/d_7d60.bin" ; $7d60, 64 bytes
Data_71_7da0:
	INCBIN "data/bank_071/d_7da0.bin" ; $7da0, 64 bytes
OamPtrs_71_7de0:
	dw Data_71_7df0 ; $7de0
	dw Data_71_7df3 ; $7de2
	dw Data_71_7df9 ; $7de4
	dw Data_71_7df9 ; $7de6
	dw Data_71_7df9 ; $7de8
	dw Data_71_7df9 ; $7dea
	dw Data_71_7df9 ; $7dec
	dw Data_71_7df9 ; $7dee
Data_71_7df0:
	INCBIN "data/bank_071/d_7df0.bin" ; $7df0, 3 bytes
Data_71_7df3:
	INCBIN "data/bank_071/d_7df3.bin" ; $7df3, 6 bytes
Data_71_7df9:
	ds 519, $ff ; $7df9, fill

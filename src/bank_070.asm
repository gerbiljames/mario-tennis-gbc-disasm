INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $70", ROMX[$4000], BANK[$70]

DataPtr_70_00:
	dw Data_70_400e ; $4000
DataPtr_70_02:
	dw Data_70_4cb1 ; $4002
DataPtr_70_04:
	dw Data_70_5951 ; $4004
DataPtr_70_06:
	dw Data_70_61d5 ; $4006
DataPtr_70_08:
	dw Data_70_6a55 ; $4008
DataPtr_70_0a:
	dw Data_70_70cd ; $400a
DataPtr_70_0c:
	dw Data_70_773d ; $400c
Data_70_400e:
	db $06, $04, $02, $00 ; count, flags
	dw $4018, OamPtrs_70_4c40, $4018, Data_70_4040, Data_70_4140, Data_70_4240 ; body pointers
	INCBIN "data/bank_070/d_401e.bin" ; $401e, 34 bytes
Data_70_4040:
	INCBIN "data/bank_070/d_4040.bin" ; $4040, 256 bytes
Data_70_4140:
	INCBIN "data/bank_070/d_4140.bin" ; $4140, 256 bytes
Data_70_4240:
	INCBIN "data/bank_070/d_4240.bin" ; $4240, 2560 bytes
OamPtrs_70_4c40:
	dw Data_70_4c58 ; $4c40
	dw Data_70_4c5b ; $4c42
	dw Data_70_4c61 ; $4c44
	dw Data_70_4c6d ; $4c46
	dw Data_70_4c75 ; $4c48
	dw Data_70_4c89 ; $4c4a
	dw Data_70_4c89 ; $4c4c
	dw Data_70_4c8e ; $4c4e
	dw Data_70_4c9a ; $4c50
	dw Data_70_4ca0 ; $4c52
	dw Data_70_4ca3 ; $4c54
	dw Data_70_4ca6 ; $4c56
Data_70_4c58:
	INCBIN "data/bank_070/d_4c58.bin" ; $4c58, 3 bytes
Data_70_4c5b:
	INCBIN "data/bank_070/d_4c5b.bin" ; $4c5b, 6 bytes
Data_70_4c61:
	INCBIN "data/bank_070/d_4c61.bin" ; $4c61, 12 bytes
Data_70_4c6d:
	INCBIN "data/bank_070/d_4c6d.bin" ; $4c6d, 8 bytes
Data_70_4c75:
	INCBIN "data/bank_070/d_4c75.bin" ; $4c75, 20 bytes
Data_70_4c89:
	INCBIN "data/bank_070/d_4c89.bin" ; $4c89, 5 bytes
Data_70_4c8e:
	INCBIN "data/bank_070/d_4c8e.bin" ; $4c8e, 12 bytes
Data_70_4c9a:
	INCBIN "data/bank_070/d_4c9a.bin" ; $4c9a, 6 bytes
Data_70_4ca0:
	INCBIN "data/bank_070/d_4ca0.bin" ; $4ca0, 3 bytes
Data_70_4ca3:
	INCBIN "data/bank_070/d_4ca3.bin" ; $4ca3, 3 bytes
Data_70_4ca6:
	INCBIN "data/bank_070/d_4ca6.bin" ; $4ca6, 11 bytes
Data_70_4cb1:
	db $05, $04, $02, $00 ; count, flags
	dw $4cbb, OamPtrs_70_58e0, $4cbb, Data_70_4ce0, Data_70_4de0, Data_70_4ee0 ; body pointers
	INCBIN "data/bank_070/d_4cc1.bin" ; $4cc1, 31 bytes
Data_70_4ce0:
	INCBIN "data/bank_070/d_4ce0.bin" ; $4ce0, 256 bytes
Data_70_4de0:
	INCBIN "data/bank_070/d_4de0.bin" ; $4de0, 256 bytes
Data_70_4ee0:
	INCBIN "data/bank_070/d_4ee0.bin" ; $4ee0, 2560 bytes
OamPtrs_70_58e0:
	dw Data_70_58f8 ; $58e0
	dw Data_70_58fb ; $58e2
	dw Data_70_5901 ; $58e4
	dw Data_70_590d ; $58e6
	dw Data_70_5915 ; $58e8
	dw Data_70_5929 ; $58ea
	dw Data_70_5929 ; $58ec
	dw Data_70_592e ; $58ee
	dw Data_70_593a ; $58f0
	dw Data_70_5940 ; $58f2
	dw Data_70_5943 ; $58f4
	dw Data_70_5946 ; $58f6
Data_70_58f8:
	INCBIN "data/bank_070/d_58f8.bin" ; $58f8, 3 bytes
Data_70_58fb:
	INCBIN "data/bank_070/d_58fb.bin" ; $58fb, 6 bytes
Data_70_5901:
	INCBIN "data/bank_070/d_5901.bin" ; $5901, 12 bytes
Data_70_590d:
	INCBIN "data/bank_070/d_590d.bin" ; $590d, 8 bytes
Data_70_5915:
	INCBIN "data/bank_070/d_5915.bin" ; $5915, 20 bytes
Data_70_5929:
	INCBIN "data/bank_070/d_5929.bin" ; $5929, 5 bytes
Data_70_592e:
	INCBIN "data/bank_070/d_592e.bin" ; $592e, 12 bytes
Data_70_593a:
	INCBIN "data/bank_070/d_593a.bin" ; $593a, 6 bytes
Data_70_5940:
	INCBIN "data/bank_070/d_5940.bin" ; $5940, 3 bytes
Data_70_5943:
	INCBIN "data/bank_070/d_5943.bin" ; $5943, 3 bytes
Data_70_5946:
	INCBIN "data/bank_070/d_5946.bin" ; $5946, 11 bytes
Data_70_5951:
	db $05, $04, $02, $00 ; count, flags
	dw $595b, OamPtrs_70_6180, $595b, Data_70_5980, Data_70_5a80, Data_70_5b80 ; body pointers
	INCBIN "data/bank_070/d_5961.bin" ; $5961, 31 bytes
Data_70_5980:
	INCBIN "data/bank_070/d_5980.bin" ; $5980, 256 bytes
Data_70_5a80:
	INCBIN "data/bank_070/d_5a80.bin" ; $5a80, 256 bytes
Data_70_5b80:
	INCBIN "data/bank_070/d_5b80.bin" ; $5b80, 1536 bytes
OamPtrs_70_6180:
	dw Data_70_6192 ; $6180
	dw Data_70_6195 ; $6182
	dw Data_70_619b ; $6184
	dw Data_70_61a7 ; $6186
	dw Data_70_61af ; $6188
	dw Data_70_61c3 ; $618a
	dw Data_70_61c3 ; $618c
	dw Data_70_61c3 ; $618e
	dw Data_70_61cf ; $6190
Data_70_6192:
	INCBIN "data/bank_070/d_6192.bin" ; $6192, 3 bytes
Data_70_6195:
	INCBIN "data/bank_070/d_6195.bin" ; $6195, 6 bytes
Data_70_619b:
	INCBIN "data/bank_070/d_619b.bin" ; $619b, 12 bytes
Data_70_61a7:
	INCBIN "data/bank_070/d_61a7.bin" ; $61a7, 8 bytes
Data_70_61af:
	INCBIN "data/bank_070/d_61af.bin" ; $61af, 20 bytes
Data_70_61c3:
	INCBIN "data/bank_070/d_61c3.bin" ; $61c3, 12 bytes
Data_70_61cf:
	INCBIN "data/bank_070/d_61cf.bin" ; $61cf, 6 bytes
Data_70_61d5:
	db $04, $04, $02, $00 ; count, flags
	dw $61df, OamPtrs_70_6a00, $61df, Data_70_6200, Data_70_6300, Data_70_6400 ; body pointers
	INCBIN "data/bank_070/d_61e5.bin" ; $61e5, 27 bytes
Data_70_6200:
	INCBIN "data/bank_070/d_6200.bin" ; $6200, 256 bytes
Data_70_6300:
	INCBIN "data/bank_070/d_6300.bin" ; $6300, 256 bytes
Data_70_6400:
	INCBIN "data/bank_070/d_6400.bin" ; $6400, 1536 bytes
OamPtrs_70_6a00:
	dw Data_70_6a12 ; $6a00
	dw Data_70_6a15 ; $6a02
	dw Data_70_6a1b ; $6a04
	dw Data_70_6a27 ; $6a06
	dw Data_70_6a2f ; $6a08
	dw Data_70_6a43 ; $6a0a
	dw Data_70_6a43 ; $6a0c
	dw Data_70_6a43 ; $6a0e
	dw Data_70_6a4f ; $6a10
Data_70_6a12:
	INCBIN "data/bank_070/d_6a12.bin" ; $6a12, 3 bytes
Data_70_6a15:
	INCBIN "data/bank_070/d_6a15.bin" ; $6a15, 6 bytes
Data_70_6a1b:
	INCBIN "data/bank_070/d_6a1b.bin" ; $6a1b, 12 bytes
Data_70_6a27:
	INCBIN "data/bank_070/d_6a27.bin" ; $6a27, 8 bytes
Data_70_6a2f:
	INCBIN "data/bank_070/d_6a2f.bin" ; $6a2f, 20 bytes
Data_70_6a43:
	INCBIN "data/bank_070/d_6a43.bin" ; $6a43, 12 bytes
Data_70_6a4f:
	INCBIN "data/bank_070/d_6a4f.bin" ; $6a4f, 6 bytes
Data_70_6a55:
	db $06, $04, $02, $00 ; count, flags
	dw $6a5f, OamPtrs_70_7080, $6a5f, Data_70_6a80, Data_70_6b80, Data_70_6c80 ; body pointers
	INCBIN "data/bank_070/d_6a65.bin" ; $6a65, 27 bytes
Data_70_6a80:
	INCBIN "data/bank_070/d_6a80.bin" ; $6a80, 256 bytes
Data_70_6b80:
	INCBIN "data/bank_070/d_6b80.bin" ; $6b80, 256 bytes
Data_70_6c80:
	INCBIN "data/bank_070/d_6c80.bin" ; $6c80, 1024 bytes
OamPtrs_70_7080:
	dw Data_70_7090 ; $7080
	dw Data_70_7093 ; $7082
	dw Data_70_7099 ; $7084
	dw Data_70_70a5 ; $7086
	dw Data_70_70ad ; $7088
	dw Data_70_70c1 ; $708a
	dw Data_70_70c1 ; $708c
	dw Data_70_70c1 ; $708e
Data_70_7090:
	INCBIN "data/bank_070/d_7090.bin" ; $7090, 3 bytes
Data_70_7093:
	INCBIN "data/bank_070/d_7093.bin" ; $7093, 6 bytes
Data_70_7099:
	INCBIN "data/bank_070/d_7099.bin" ; $7099, 12 bytes
Data_70_70a5:
	INCBIN "data/bank_070/d_70a5.bin" ; $70a5, 8 bytes
Data_70_70ad:
	INCBIN "data/bank_070/d_70ad.bin" ; $70ad, 20 bytes
Data_70_70c1:
	INCBIN "data/bank_070/d_70c1.bin" ; $70c1, 12 bytes
Data_70_70cd:
	db $07, $04, $02, $00 ; count, flags
	dw $70d7, OamPtrs_70_76f0, $70d7, Data_70_70f0, Data_70_71f0, Data_70_72f0 ; body pointers
	INCBIN "data/bank_070/d_70dd.bin" ; $70dd, 19 bytes
Data_70_70f0:
	INCBIN "data/bank_070/d_70f0.bin" ; $70f0, 256 bytes
Data_70_71f0:
	INCBIN "data/bank_070/d_71f0.bin" ; $71f0, 256 bytes
Data_70_72f0:
	INCBIN "data/bank_070/d_72f0.bin" ; $72f0, 1024 bytes
OamPtrs_70_76f0:
	dw Data_70_7700 ; $76f0
	dw Data_70_7703 ; $76f2
	dw Data_70_7709 ; $76f4
	dw Data_70_7715 ; $76f6
	dw Data_70_771d ; $76f8
	dw Data_70_7731 ; $76fa
	dw Data_70_7731 ; $76fc
	dw Data_70_7731 ; $76fe
Data_70_7700:
	INCBIN "data/bank_070/d_7700.bin" ; $7700, 3 bytes
Data_70_7703:
	INCBIN "data/bank_070/d_7703.bin" ; $7703, 6 bytes
Data_70_7709:
	INCBIN "data/bank_070/d_7709.bin" ; $7709, 12 bytes
Data_70_7715:
	INCBIN "data/bank_070/d_7715.bin" ; $7715, 8 bytes
Data_70_771d:
	INCBIN "data/bank_070/d_771d.bin" ; $771d, 20 bytes
Data_70_7731:
	INCBIN "data/bank_070/d_7731.bin" ; $7731, 12 bytes
Data_70_773d:
	db $03, $04, $02, $00 ; count, flags
	dw $7747, OamPtrs_70_7d60, $7747, Data_70_7760, Data_70_7860, Data_70_7960 ; body pointers
	INCBIN "data/bank_070/d_774d.bin" ; $774d, 19 bytes
Data_70_7760:
	INCBIN "data/bank_070/d_7760.bin" ; $7760, 256 bytes
Data_70_7860:
	INCBIN "data/bank_070/d_7860.bin" ; $7860, 256 bytes
Data_70_7960:
	INCBIN "data/bank_070/d_7960.bin" ; $7960, 1024 bytes
OamPtrs_70_7d60:
	dw Data_70_7d70 ; $7d60
	dw Data_70_7d73 ; $7d62
	dw Data_70_7d79 ; $7d64
	dw Data_70_7d85 ; $7d66
	dw Data_70_7d8d ; $7d68
	dw Data_70_7da1 ; $7d6a
	dw Data_70_7da1 ; $7d6c
	dw Data_70_7da1 ; $7d6e
Data_70_7d70:
	INCBIN "data/bank_070/d_7d70.bin" ; $7d70, 3 bytes
Data_70_7d73:
	INCBIN "data/bank_070/d_7d73.bin" ; $7d73, 6 bytes
Data_70_7d79:
	INCBIN "data/bank_070/d_7d79.bin" ; $7d79, 12 bytes
Data_70_7d85:
	INCBIN "data/bank_070/d_7d85.bin" ; $7d85, 8 bytes
Data_70_7d8d:
	INCBIN "data/bank_070/d_7d8d.bin" ; $7d8d, 20 bytes
Data_70_7da1:
	INCBIN "data/bank_070/d_7da1.bin" ; $7da1, 12 bytes
	ds 595, $ff ; $7dad, fill

SECTION "ROM Bank $7a", ROMX[$4000], BANK[$7a]

SoundTable_7a:
	dw $0140 ; $4000
	dw Sfx10_Trk0 ; $4002
	dw $0060 ; $4004
	dw Sfx10_Trk1 ; $4006
	dw $0280 ; $4008
	dw Sfx10_Trk2 ; $400a
	dw $03a0 ; $400c
	dw Sfx10_Trk3 ; $400e
	dw $0140 ; $4010
	dw Sfx11_Trk0 ; $4012
	dw $0060 ; $4014
	dw Sfx11_Trk1 ; $4016
	dw $0280 ; $4018
	dw Sfx11_Trk2 ; $401a
	dw $03a0 ; $401c
	dw Sfx11_Trk3 ; $401e
	dw $0140 ; $4020
	dw Sfx12_Trk0 ; $4022
	dw $0060 ; $4024
	dw Sfx12_Trk1 ; $4026
	dw $0280 ; $4028
	dw Sfx12_Trk2 ; $402a
	dw $03a0 ; $402c
	dw Sfx12_Trk3 ; $402e
	dw $0140 ; $4030
	dw Sfx13_Trk0 ; $4032
	dw $0060 ; $4034
	dw Sfx13_Trk1 ; $4036
	dw $0280 ; $4038
	dw Sfx13_Trk2 ; $403a
	dw $03a0 ; $403c
	dw Sfx13_Trk3 ; $403e
	dw $0140 ; $4040
	dw Sfx14_Trk0 ; $4042
	dw $0060 ; $4044
	dw Sfx14_Trk1 ; $4046
	dw $0280 ; $4048
	dw Sfx14_Trk2 ; $404a
	dw $03a0 ; $404c
	dw Sfx14_Trk3 ; $404e
	dw $0140 ; $4050
	dw Sfx15_Trk0 ; $4052
	dw $0060 ; $4054
	dw Sfx15_Trk1 ; $4056
	dw $0280 ; $4058
	dw Sfx15_Trk2 ; $405a
	dw $03a0 ; $405c
	dw Sfx15_Trk3 ; $405e
	dw $0140 ; $4060
	dw Sfx2e_Trk0 ; $4062
	dw $0060 ; $4064
	dw Sfx2e_Trk1 ; $4066
	dw $0280 ; $4068
	dw Sfx2e_Trk2 ; $406a
Sfx10_Trk0:
	INCBIN "data/bank_07a/d_406c.bin" ; $406c, 850 bytes
Sfx10_Trk1:
	INCBIN "data/bank_07a/d_43be.bin" ; $43be, 628 bytes
Sfx10_Trk2:
	INCBIN "data/bank_07a/d_4632.bin" ; $4632, 1622 bytes
Sfx10_Trk3:
	INCBIN "data/bank_07a/d_4c88.bin" ; $4c88, 780 bytes
Sfx11_Trk0:
	INCBIN "data/bank_07a/d_4f94.bin" ; $4f94, 720 bytes
Sfx11_Trk1:
	INCBIN "data/bank_07a/d_5264.bin" ; $5264, 756 bytes
Sfx11_Trk2:
	INCBIN "data/bank_07a/d_5558.bin" ; $5558, 610 bytes
Sfx11_Trk3:
	INCBIN "data/bank_07a/d_57ba.bin" ; $57ba, 752 bytes
Sfx12_Trk0:
	INCBIN "data/bank_07a/d_5aaa.bin" ; $5aaa, 1454 bytes
Sfx12_Trk1:
	INCBIN "data/bank_07a/d_6058.bin" ; $6058, 1246 bytes
Sfx12_Trk2:
	INCBIN "data/bank_07a/d_6536.bin" ; $6536, 320 bytes
Sfx12_Trk3:
	INCBIN "data/bank_07a/d_6676.bin" ; $6676, 672 bytes
Sfx13_Trk0:
	INCBIN "data/bank_07a/d_6916.bin" ; $6916, 520 bytes
Sfx13_Trk1:
	INCBIN "data/bank_07a/d_6b1e.bin" ; $6b1e, 610 bytes
Sfx13_Trk2:
	INCBIN "data/bank_07a/d_6d80.bin" ; $6d80, 680 bytes
Sfx13_Trk3:
	INCBIN "data/bank_07a/d_7028.bin" ; $7028, 624 bytes
Sfx14_Trk0:
	INCBIN "data/bank_07a/d_7298.bin" ; $7298, 364 bytes
Sfx14_Trk1:
	INCBIN "data/bank_07a/d_7404.bin" ; $7404, 318 bytes
Sfx14_Trk2:
	INCBIN "data/bank_07a/d_7542.bin" ; $7542, 370 bytes
Sfx14_Trk3:
	INCBIN "data/bank_07a/d_76b4.bin" ; $76b4, 678 bytes
Sfx15_Trk0:
	INCBIN "data/bank_07a/d_795a.bin" ; $795a, 406 bytes
Sfx15_Trk1:
	INCBIN "data/bank_07a/d_7af0.bin" ; $7af0, 382 bytes
Sfx15_Trk2:
	INCBIN "data/bank_07a/d_7c6e.bin" ; $7c6e, 294 bytes
Sfx15_Trk3:
	INCBIN "data/bank_07a/d_7d94.bin" ; $7d94, 364 bytes
Sfx2e_Trk0:
	INCBIN "data/bank_07a/d_7f00.bin" ; $7f00, 94 bytes
Sfx2e_Trk1:
	INCBIN "data/bank_07a/d_7f5e.bin" ; $7f5e, 76 bytes
Sfx2e_Trk2:
	INCBIN "data/bank_07a/d_7faa.bin" ; $7faa, 70 bytes
	; $7ff0, 16 bytes fill to bank end (linker-padded)

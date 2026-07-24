SECTION "ROM Bank $7a", ROMX[$4000], BANK[$7a]

SoundTable_7a:
	dw $0140 ; $4000
	dw Data_7a_406c ; $4002
	dw $0060 ; $4004
	dw Data_7a_43be ; $4006
	dw $0280 ; $4008
	dw Data_7a_4632 ; $400a
	dw $03a0 ; $400c
	dw Data_7a_4c88 ; $400e
	dw $0140 ; $4010
	dw Data_7a_4f94 ; $4012
	dw $0060 ; $4014
	dw Data_7a_5264 ; $4016
	dw $0280 ; $4018
	dw Data_7a_5558 ; $401a
	dw $03a0 ; $401c
	dw Data_7a_57ba ; $401e
	dw $0140 ; $4020
	dw Data_7a_5aaa ; $4022
	dw $0060 ; $4024
	dw Data_7a_6058 ; $4026
	dw $0280 ; $4028
	dw Data_7a_6536 ; $402a
	dw $03a0 ; $402c
	dw Data_7a_6676 ; $402e
	dw $0140 ; $4030
	dw Data_7a_6916 ; $4032
	dw $0060 ; $4034
	dw Data_7a_6b1e ; $4036
	dw $0280 ; $4038
	dw Data_7a_6d80 ; $403a
	dw $03a0 ; $403c
	dw Data_7a_7028 ; $403e
	dw $0140 ; $4040
	dw Data_7a_7298 ; $4042
	dw $0060 ; $4044
	dw Data_7a_7404 ; $4046
	dw $0280 ; $4048
	dw Data_7a_7542 ; $404a
	dw $03a0 ; $404c
	dw Data_7a_76b4 ; $404e
	dw $0140 ; $4050
	dw Data_7a_795a ; $4052
	dw $0060 ; $4054
	dw Data_7a_7af0 ; $4056
	dw $0280 ; $4058
	dw Data_7a_7c6e ; $405a
	dw $03a0 ; $405c
	dw Data_7a_7d94 ; $405e
	dw $0140 ; $4060
	dw Data_7a_7f00 ; $4062
	dw $0060 ; $4064
	dw Data_7a_7f5e ; $4066
	dw $0280 ; $4068
	dw Data_7a_7faa ; $406a
Data_7a_406c:
	INCBIN "data/bank_07a/d_406c.bin" ; $406c, 850 bytes
Data_7a_43be:
	INCBIN "data/bank_07a/d_43be.bin" ; $43be, 628 bytes
Data_7a_4632:
	INCBIN "data/bank_07a/d_4632.bin" ; $4632, 1622 bytes
Data_7a_4c88:
	INCBIN "data/bank_07a/d_4c88.bin" ; $4c88, 780 bytes
Data_7a_4f94:
	INCBIN "data/bank_07a/d_4f94.bin" ; $4f94, 720 bytes
Data_7a_5264:
	INCBIN "data/bank_07a/d_5264.bin" ; $5264, 756 bytes
Data_7a_5558:
	INCBIN "data/bank_07a/d_5558.bin" ; $5558, 610 bytes
Data_7a_57ba:
	INCBIN "data/bank_07a/d_57ba.bin" ; $57ba, 752 bytes
Data_7a_5aaa:
	INCBIN "data/bank_07a/d_5aaa.bin" ; $5aaa, 1454 bytes
Data_7a_6058:
	INCBIN "data/bank_07a/d_6058.bin" ; $6058, 1246 bytes
Data_7a_6536:
	INCBIN "data/bank_07a/d_6536.bin" ; $6536, 320 bytes
Data_7a_6676:
	INCBIN "data/bank_07a/d_6676.bin" ; $6676, 672 bytes
Data_7a_6916:
	INCBIN "data/bank_07a/d_6916.bin" ; $6916, 520 bytes
Data_7a_6b1e:
	INCBIN "data/bank_07a/d_6b1e.bin" ; $6b1e, 610 bytes
Data_7a_6d80:
	INCBIN "data/bank_07a/d_6d80.bin" ; $6d80, 680 bytes
Data_7a_7028:
	INCBIN "data/bank_07a/d_7028.bin" ; $7028, 624 bytes
Data_7a_7298:
	INCBIN "data/bank_07a/d_7298.bin" ; $7298, 364 bytes
Data_7a_7404:
	INCBIN "data/bank_07a/d_7404.bin" ; $7404, 318 bytes
Data_7a_7542:
	INCBIN "data/bank_07a/d_7542.bin" ; $7542, 370 bytes
Data_7a_76b4:
	INCBIN "data/bank_07a/d_76b4.bin" ; $76b4, 678 bytes
Data_7a_795a:
	INCBIN "data/bank_07a/d_795a.bin" ; $795a, 406 bytes
Data_7a_7af0:
	INCBIN "data/bank_07a/d_7af0.bin" ; $7af0, 382 bytes
Data_7a_7c6e:
	INCBIN "data/bank_07a/d_7c6e.bin" ; $7c6e, 294 bytes
Data_7a_7d94:
	INCBIN "data/bank_07a/d_7d94.bin" ; $7d94, 364 bytes
Data_7a_7f00:
	INCBIN "data/bank_07a/d_7f00.bin" ; $7f00, 94 bytes
Data_7a_7f5e:
	INCBIN "data/bank_07a/d_7f5e.bin" ; $7f5e, 76 bytes
Data_7a_7faa:
	INCBIN "data/bank_07a/d_7faa.bin" ; $7faa, 70 bytes
	; $7ff0, 16 bytes fill to bank end (linker-padded)

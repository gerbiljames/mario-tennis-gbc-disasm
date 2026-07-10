INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $7b", ROMX[$4000], BANK[$7b]

SoundTable_7b:
	dw $0140 ; $4000
	dw Data_7b_40c0 ; $4002
	dw $0060 ; $4004
	dw Data_7b_4276 ; $4006
	dw $0280 ; $4008
	dw Data_7b_443e ; $400a
	dw $03a0 ; $400c
	dw Data_7b_4596 ; $400e
	dw $0040 ; $4010
	dw Data_7b_47ec ; $4012
	dw $0160 ; $4014
	dw Data_7b_48f4 ; $4016
	dw $0280 ; $4018
	dw Data_7b_49b8 ; $401a
	dw $03a0 ; $401c
	dw Data_7b_4a56 ; $401e
	dw $0140 ; $4020
	dw Data_7b_4aa8 ; $4022
	dw $0060 ; $4024
	dw Data_7b_4bd6 ; $4026
	dw $0280 ; $4028
	dw Data_7b_4d04 ; $402a
	dw $03a0 ; $402c
	dw Data_7b_4d98 ; $402e
	dw $0140 ; $4030
	dw Data_7b_5172 ; $4032
	dw $0060 ; $4034
	dw Data_7b_5366 ; $4036
	dw $0280 ; $4038
	dw Data_7b_5524 ; $403a
	dw $03a0 ; $403c
	dw Data_7b_57f0 ; $403e
	dw $0140 ; $4040
	dw Data_7b_588a ; $4042
	dw $0060 ; $4044
	dw Data_7b_5964 ; $4046
	dw $0280 ; $4048
	dw Data_7b_5a42 ; $404a
	dw $0140 ; $404c
	dw Data_7b_5abe ; $404e
	dw $0060 ; $4050
	dw Data_7b_5b76 ; $4052
	dw $0280 ; $4054
	dw Data_7b_5c30 ; $4056
	dw $03a0 ; $4058
	dw Data_7b_5d00 ; $405a
	dw $0140 ; $405c
	dw Data_7b_5e52 ; $405e
	dw $0060 ; $4060
	dw Data_7b_5ed6 ; $4062
	dw $0280 ; $4064
	dw Data_7b_5fc0 ; $4066
	dw $03a0 ; $4068
	dw Data_7b_614c ; $406a
	dw $0140 ; $406c
	dw Data_7b_62e8 ; $406e
	dw $0060 ; $4070
	dw Data_7b_6416 ; $4072
	dw $0280 ; $4074
	dw Data_7b_65d6 ; $4076
	dw $03a0 ; $4078
	dw Data_7b_66c6 ; $407a
	dw $0140 ; $407c
	dw Data_7b_6726 ; $407e
	dw $0060 ; $4080
	dw Data_7b_69fa ; $4082
	dw $0280 ; $4084
	dw Data_7b_6e30 ; $4086
	dw $03a0 ; $4088
	dw Data_7b_72dc ; $408a
	dw $0140 ; $408c
	dw Data_7b_799a ; $408e
	dw $0060 ; $4090
	dw Data_7b_7a6e ; $4092
	dw $0280 ; $4094
	dw Data_7b_7b46 ; $4096
	dw $03a0 ; $4098
	dw Data_7b_7d08 ; $409a
	dw $0140 ; $409c
	dw Data_7b_7e5c ; $409e
	dw $0060 ; $40a0
	dw Data_7b_7e78 ; $40a2
	dw $0280 ; $40a4
	dw Data_7b_7e94 ; $40a6
	dw $03a0 ; $40a8
	dw Data_7b_7eaa ; $40aa
	dw $0140 ; $40ac
	dw Data_7b_7ef6 ; $40ae
	dw $0060 ; $40b0
	dw Data_7b_7f1c ; $40b2
	dw $0280 ; $40b4
	dw Data_7b_7f42 ; $40b6
	dw $03a0 ; $40b8
	dw Data_7b_7f64 ; $40ba
	dw $0000 ; $40bc
	dw Data_7b_7fe6 ; $40be
Data_7b_40c0:
	INCBIN "data/bank_07b/d_40c0.bin" ; $40c0, 438 bytes
Data_7b_4276:
	INCBIN "data/bank_07b/d_4276.bin" ; $4276, 456 bytes
Data_7b_443e:
	INCBIN "data/bank_07b/d_443e.bin" ; $443e, 344 bytes
Data_7b_4596:
	INCBIN "data/bank_07b/d_4596.bin" ; $4596, 598 bytes
Data_7b_47ec:
	INCBIN "data/bank_07b/d_47ec.bin" ; $47ec, 264 bytes
Data_7b_48f4:
	INCBIN "data/bank_07b/d_48f4.bin" ; $48f4, 196 bytes
Data_7b_49b8:
	INCBIN "data/bank_07b/d_49b8.bin" ; $49b8, 158 bytes
Data_7b_4a56:
	INCBIN "data/bank_07b/d_4a56.bin" ; $4a56, 82 bytes
Data_7b_4aa8:
	INCBIN "data/bank_07b/d_4aa8.bin" ; $4aa8, 302 bytes
Data_7b_4bd6:
	INCBIN "data/bank_07b/d_4bd6.bin" ; $4bd6, 302 bytes
Data_7b_4d04:
	INCBIN "data/bank_07b/d_4d04.bin" ; $4d04, 148 bytes
Data_7b_4d98:
	INCBIN "data/bank_07b/d_4d98.bin" ; $4d98, 986 bytes
Data_7b_5172:
	INCBIN "data/bank_07b/d_5172.bin" ; $5172, 500 bytes
Data_7b_5366:
	INCBIN "data/bank_07b/d_5366.bin" ; $5366, 446 bytes
Data_7b_5524:
	INCBIN "data/bank_07b/d_5524.bin" ; $5524, 716 bytes
Data_7b_57f0:
	INCBIN "data/bank_07b/d_57f0.bin" ; $57f0, 154 bytes
Data_7b_588a:
	INCBIN "data/bank_07b/d_588a.bin" ; $588a, 218 bytes
Data_7b_5964:
	INCBIN "data/bank_07b/d_5964.bin" ; $5964, 222 bytes
Data_7b_5a42:
	INCBIN "data/bank_07b/d_5a42.bin" ; $5a42, 124 bytes
Data_7b_5abe:
	INCBIN "data/bank_07b/d_5abe.bin" ; $5abe, 184 bytes
Data_7b_5b76:
	INCBIN "data/bank_07b/d_5b76.bin" ; $5b76, 186 bytes
Data_7b_5c30:
	INCBIN "data/bank_07b/d_5c30.bin" ; $5c30, 208 bytes
Data_7b_5d00:
	INCBIN "data/bank_07b/d_5d00.bin" ; $5d00, 338 bytes
Data_7b_5e52:
	INCBIN "data/bank_07b/d_5e52.bin" ; $5e52, 132 bytes
Data_7b_5ed6:
	INCBIN "data/bank_07b/d_5ed6.bin" ; $5ed6, 234 bytes
Data_7b_5fc0:
	INCBIN "data/bank_07b/d_5fc0.bin" ; $5fc0, 396 bytes
Data_7b_614c:
	INCBIN "data/bank_07b/d_614c.bin" ; $614c, 412 bytes
Data_7b_62e8:
	INCBIN "data/bank_07b/d_62e8.bin" ; $62e8, 302 bytes
Data_7b_6416:
	INCBIN "data/bank_07b/d_6416.bin" ; $6416, 448 bytes
Data_7b_65d6:
	INCBIN "data/bank_07b/d_65d6.bin" ; $65d6, 240 bytes
Data_7b_66c6:
	INCBIN "data/bank_07b/d_66c6.bin" ; $66c6, 96 bytes
Data_7b_6726:
	INCBIN "data/bank_07b/d_6726.bin" ; $6726, 724 bytes
Data_7b_69fa:
	INCBIN "data/bank_07b/d_69fa.bin" ; $69fa, 1078 bytes
Data_7b_6e30:
	INCBIN "data/bank_07b/d_6e30.bin" ; $6e30, 1196 bytes
Data_7b_72dc:
	INCBIN "data/bank_07b/d_72dc.bin" ; $72dc, 1726 bytes
Data_7b_799a:
	INCBIN "data/bank_07b/d_799a.bin" ; $799a, 212 bytes
Data_7b_7a6e:
	INCBIN "data/bank_07b/d_7a6e.bin" ; $7a6e, 216 bytes
Data_7b_7b46:
	INCBIN "data/bank_07b/d_7b46.bin" ; $7b46, 450 bytes
Data_7b_7d08:
	INCBIN "data/bank_07b/d_7d08.bin" ; $7d08, 340 bytes
Data_7b_7e5c:
	INCBIN "data/bank_07b/d_7e5c.bin" ; $7e5c, 28 bytes
Data_7b_7e78:
	INCBIN "data/bank_07b/d_7e78.bin" ; $7e78, 28 bytes
Data_7b_7e94:
	INCBIN "data/bank_07b/d_7e94.bin" ; $7e94, 22 bytes
Data_7b_7eaa:
	INCBIN "data/bank_07b/d_7eaa.bin" ; $7eaa, 76 bytes
Data_7b_7ef6:
	INCBIN "data/bank_07b/d_7ef6.bin" ; $7ef6, 38 bytes
Data_7b_7f1c:
	INCBIN "data/bank_07b/d_7f1c.bin" ; $7f1c, 38 bytes
Data_7b_7f42:
	INCBIN "data/bank_07b/d_7f42.bin" ; $7f42, 34 bytes
Data_7b_7f64:
	INCBIN "data/bank_07b/d_7f64.bin" ; $7f64, 130 bytes
Data_7b_7fe6:
	INCBIN "data/bank_07b/d_7fe6.bin" ; $7fe6, 10 bytes
	INCBIN "data/bank_07b/d_7ff0.bin" ; $7ff0, 16 bytes

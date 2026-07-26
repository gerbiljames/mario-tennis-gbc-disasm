SECTION "ROM Bank $7b", ROMX[$4000], BANK[$7b]

SoundTable_7b:
	dw $0140 ; $4000
	dw Sfx16_Trk0 ; $4002
	dw $0060 ; $4004
	dw Sfx16_Trk1 ; $4006
	dw $0280 ; $4008
	dw Sfx16_Trk2 ; $400a
	dw $03a0 ; $400c
	dw Sfx16_Trk3 ; $400e
	dw $0040 ; $4010
	dw Sfx17_Trk0 ; $4012
	dw $0160 ; $4014
	dw Sfx17_Trk1 ; $4016
	dw $0280 ; $4018
	dw Sfx17_Trk2 ; $401a
	dw $03a0 ; $401c
	dw Sfx17_Trk3 ; $401e
	dw $0140 ; $4020
	dw Sfx18_Trk0 ; $4022
	dw $0060 ; $4024
	dw Sfx18_Trk1 ; $4026
	dw $0280 ; $4028
	dw Sfx18_Trk2 ; $402a
	dw $03a0 ; $402c
	dw Sfx18_Trk3 ; $402e
	dw $0140 ; $4030
	dw Sfx19_Trk0 ; $4032
	dw $0060 ; $4034
	dw Sfx19_Trk1 ; $4036
	dw $0280 ; $4038
	dw Sfx19_Trk2 ; $403a
	dw $03a0 ; $403c
	dw Sfx19_Trk3 ; $403e
	dw $0140 ; $4040
	dw Sfx1a_Trk0 ; $4042
	dw $0060 ; $4044
	dw Sfx1a_Trk1 ; $4046
	dw $0280 ; $4048
	dw Sfx1a_Trk2 ; $404a
	dw $0140 ; $404c
	dw Sfx1b_Trk0 ; $404e
	dw $0060 ; $4050
	dw Sfx1b_Trk1 ; $4052
	dw $0280 ; $4054
	dw Sfx1b_Trk2 ; $4056
	dw $03a0 ; $4058
	dw Sfx1b_Trk3 ; $405a
	dw $0140 ; $405c
	dw Sfx1c_Trk0 ; $405e
	dw $0060 ; $4060
	dw Sfx1c_Trk1 ; $4062
	dw $0280 ; $4064
	dw Sfx1c_Trk2 ; $4066
	dw $03a0 ; $4068
	dw Sfx1c_Trk3 ; $406a
	dw $0140 ; $406c
	dw Sfx1d_Trk0 ; $406e
	dw $0060 ; $4070
	dw Sfx1d_Trk1 ; $4072
	dw $0280 ; $4074
	dw Sfx1d_Trk2 ; $4076
	dw $03a0 ; $4078
	dw Sfx1d_Trk3 ; $407a
	dw $0140 ; $407c
	dw Sfx1e_Trk0 ; $407e
	dw $0060 ; $4080
	dw Sfx1e_Trk1 ; $4082
	dw $0280 ; $4084
	dw Sfx1e_Trk2 ; $4086
	dw $03a0 ; $4088
	dw Sfx1e_Trk3 ; $408a
	dw $0140 ; $408c
	dw Sfx1f_Trk0 ; $408e
	dw $0060 ; $4090
	dw Sfx1f_Trk1 ; $4092
	dw $0280 ; $4094
	dw Sfx1f_Trk2 ; $4096
	dw $03a0 ; $4098
	dw Sfx1f_Trk3 ; $409a
	dw $0140 ; $409c
	dw Sfx2f_Trk0 ; $409e
	dw $0060 ; $40a0
	dw Sfx2f_Trk1 ; $40a2
	dw $0280 ; $40a4
	dw Sfx2f_Trk2 ; $40a6
	dw $03a0 ; $40a8
	dw Sfx2f_Trk3 ; $40aa
	dw $0140 ; $40ac
	dw Sfx31_Trk0 ; $40ae
	dw $0060 ; $40b0
	dw Sfx31_Trk1 ; $40b2
	dw $0280 ; $40b4
	dw Sfx31_Trk2 ; $40b6
	dw $03a0 ; $40b8
	dw Sfx31_Trk3 ; $40ba
	dw $0000 ; $40bc
	dw Music9b_Trk0 ; $40be
Sfx16_Trk0:
	INCBIN "data/bank_07b/d_40c0.bin" ; $40c0, 438 bytes
Sfx16_Trk1:
	INCBIN "data/bank_07b/d_4276.bin" ; $4276, 456 bytes
Sfx16_Trk2:
	INCBIN "data/bank_07b/d_443e.bin" ; $443e, 344 bytes
Sfx16_Trk3:
	INCBIN "data/bank_07b/d_4596.bin" ; $4596, 598 bytes
Sfx17_Trk0:
	INCBIN "data/bank_07b/d_47ec.bin" ; $47ec, 264 bytes
Sfx17_Trk1:
	INCBIN "data/bank_07b/d_48f4.bin" ; $48f4, 196 bytes
Sfx17_Trk2:
	INCBIN "data/bank_07b/d_49b8.bin" ; $49b8, 158 bytes
Sfx17_Trk3:
	INCBIN "data/bank_07b/d_4a56.bin" ; $4a56, 82 bytes
Sfx18_Trk0:
	INCBIN "data/bank_07b/d_4aa8.bin" ; $4aa8, 302 bytes
Sfx18_Trk1:
	INCBIN "data/bank_07b/d_4bd6.bin" ; $4bd6, 302 bytes
Sfx18_Trk2:
	INCBIN "data/bank_07b/d_4d04.bin" ; $4d04, 148 bytes
Sfx18_Trk3:
	INCBIN "data/bank_07b/d_4d98.bin" ; $4d98, 986 bytes
Sfx19_Trk0:
	INCBIN "data/bank_07b/d_5172.bin" ; $5172, 500 bytes
Sfx19_Trk1:
	INCBIN "data/bank_07b/d_5366.bin" ; $5366, 446 bytes
Sfx19_Trk2:
	INCBIN "data/bank_07b/d_5524.bin" ; $5524, 716 bytes
Sfx19_Trk3:
	INCBIN "data/bank_07b/d_57f0.bin" ; $57f0, 154 bytes
Sfx1a_Trk0:
	INCBIN "data/bank_07b/d_588a.bin" ; $588a, 218 bytes
Sfx1a_Trk1:
	INCBIN "data/bank_07b/d_5964.bin" ; $5964, 222 bytes
Sfx1a_Trk2:
	INCBIN "data/bank_07b/d_5a42.bin" ; $5a42, 124 bytes
Sfx1b_Trk0:
	INCBIN "data/bank_07b/d_5abe.bin" ; $5abe, 184 bytes
Sfx1b_Trk1:
	INCBIN "data/bank_07b/d_5b76.bin" ; $5b76, 186 bytes
Sfx1b_Trk2:
	INCBIN "data/bank_07b/d_5c30.bin" ; $5c30, 208 bytes
Sfx1b_Trk3:
	INCBIN "data/bank_07b/d_5d00.bin" ; $5d00, 338 bytes
Sfx1c_Trk0:
	INCBIN "data/bank_07b/d_5e52.bin" ; $5e52, 132 bytes
Sfx1c_Trk1:
	INCBIN "data/bank_07b/d_5ed6.bin" ; $5ed6, 234 bytes
Sfx1c_Trk2:
	INCBIN "data/bank_07b/d_5fc0.bin" ; $5fc0, 396 bytes
Sfx1c_Trk3:
	INCBIN "data/bank_07b/d_614c.bin" ; $614c, 412 bytes
Sfx1d_Trk0:
	INCBIN "data/bank_07b/d_62e8.bin" ; $62e8, 302 bytes
Sfx1d_Trk1:
	INCBIN "data/bank_07b/d_6416.bin" ; $6416, 448 bytes
Sfx1d_Trk2:
	INCBIN "data/bank_07b/d_65d6.bin" ; $65d6, 240 bytes
Sfx1d_Trk3:
	INCBIN "data/bank_07b/d_66c6.bin" ; $66c6, 96 bytes
Sfx1e_Trk0:
	INCBIN "data/bank_07b/d_6726.bin" ; $6726, 724 bytes
Sfx1e_Trk1:
	INCBIN "data/bank_07b/d_69fa.bin" ; $69fa, 1078 bytes
Sfx1e_Trk2:
	INCBIN "data/bank_07b/d_6e30.bin" ; $6e30, 1196 bytes
Sfx1e_Trk3:
	INCBIN "data/bank_07b/d_72dc.bin" ; $72dc, 1726 bytes
Sfx1f_Trk0:
	INCBIN "data/bank_07b/d_799a.bin" ; $799a, 212 bytes
Sfx1f_Trk1:
	INCBIN "data/bank_07b/d_7a6e.bin" ; $7a6e, 216 bytes
Sfx1f_Trk2:
	INCBIN "data/bank_07b/d_7b46.bin" ; $7b46, 450 bytes
Sfx1f_Trk3:
	INCBIN "data/bank_07b/d_7d08.bin" ; $7d08, 340 bytes
Sfx2f_Trk0:
	INCBIN "data/bank_07b/d_7e5c.bin" ; $7e5c, 28 bytes
Sfx2f_Trk1:
	INCBIN "data/bank_07b/d_7e78.bin" ; $7e78, 28 bytes
Sfx2f_Trk2:
	INCBIN "data/bank_07b/d_7e94.bin" ; $7e94, 22 bytes
Sfx2f_Trk3:
	INCBIN "data/bank_07b/d_7eaa.bin" ; $7eaa, 76 bytes
Sfx31_Trk0:
	INCBIN "data/bank_07b/d_7ef6.bin" ; $7ef6, 38 bytes
Sfx31_Trk1:
	INCBIN "data/bank_07b/d_7f1c.bin" ; $7f1c, 38 bytes
Sfx31_Trk2:
	INCBIN "data/bank_07b/d_7f42.bin" ; $7f42, 34 bytes
Sfx31_Trk3:
	INCBIN "data/bank_07b/d_7f64.bin" ; $7f64, 130 bytes
Music9b_Trk0:
	INCBIN "data/bank_07b/d_7fe6.bin" ; $7fe6, 10 bytes
	; $7ff0, 16 bytes fill to bank end (linker-padded)

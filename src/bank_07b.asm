SECTION "ROM Bank $7b", ROMX[$4000], BANK[$7b]

SoundTable_7b:
	snd_channel 2, $01 ; $4000
	dw Sfx16_Trk0 ; $4002
	snd_channel 3, $00 ; $4004
	dw Sfx16_Trk1 ; $4006
	snd_channel 4, $02 ; $4008
	dw Sfx16_Trk2 ; $400a
	snd_channel 5, $03 ; $400c
	dw Sfx16_Trk3 ; $400e
	snd_channel 2, $00 ; $4010
	dw Sfx17_Trk0 ; $4012
	snd_channel 3, $01 ; $4014
	dw Sfx17_Trk1 ; $4016
	snd_channel 4, $02 ; $4018
	dw Sfx17_Trk2 ; $401a
	snd_channel 5, $03 ; $401c
	dw Sfx17_Trk3 ; $401e
	snd_channel 2, $01 ; $4020
	dw Sfx18_Trk0 ; $4022
	snd_channel 3, $00 ; $4024
	dw Sfx18_Trk1 ; $4026
	snd_channel 4, $02 ; $4028
	dw Sfx18_Trk2 ; $402a
	snd_channel 5, $03 ; $402c
	dw Sfx18_Trk3 ; $402e
	snd_channel 2, $01 ; $4030
	dw Sfx19_Trk0 ; $4032
	snd_channel 3, $00 ; $4034
	dw Sfx19_Trk1 ; $4036
	snd_channel 4, $02 ; $4038
	dw Sfx19_Trk2 ; $403a
	snd_channel 5, $03 ; $403c
	dw Sfx19_Trk3 ; $403e
	snd_channel 2, $01 ; $4040
	dw Sfx1a_Trk0 ; $4042
	snd_channel 3, $00 ; $4044
	dw Sfx1a_Trk1 ; $4046
	snd_channel 4, $02 ; $4048
	dw Sfx1a_Trk2 ; $404a
	snd_channel 2, $01 ; $404c
	dw Sfx1b_Trk0 ; $404e
	snd_channel 3, $00 ; $4050
	dw Sfx1b_Trk1 ; $4052
	snd_channel 4, $02 ; $4054
	dw Sfx1b_Trk2 ; $4056
	snd_channel 5, $03 ; $4058
	dw Sfx1b_Trk3 ; $405a
	snd_channel 2, $01 ; $405c
	dw Sfx1c_Trk0 ; $405e
	snd_channel 3, $00 ; $4060
	dw Sfx1c_Trk1 ; $4062
	snd_channel 4, $02 ; $4064
	dw Sfx1c_Trk2 ; $4066
	snd_channel 5, $03 ; $4068
	dw Sfx1c_Trk3 ; $406a
	snd_channel 2, $01 ; $406c
	dw Sfx1d_Trk0 ; $406e
	snd_channel 3, $00 ; $4070
	dw Sfx1d_Trk1 ; $4072
	snd_channel 4, $02 ; $4074
	dw Sfx1d_Trk2 ; $4076
	snd_channel 5, $03 ; $4078
	dw Sfx1d_Trk3 ; $407a
	snd_channel 2, $01 ; $407c
	dw Sfx1e_Trk0 ; $407e
	snd_channel 3, $00 ; $4080
	dw Sfx1e_Trk1 ; $4082
	snd_channel 4, $02 ; $4084
	dw Sfx1e_Trk2 ; $4086
	snd_channel 5, $03 ; $4088
	dw Sfx1e_Trk3 ; $408a
	snd_channel 2, $01 ; $408c
	dw Sfx1f_Trk0 ; $408e
	snd_channel 3, $00 ; $4090
	dw Sfx1f_Trk1 ; $4092
	snd_channel 4, $02 ; $4094
	dw Sfx1f_Trk2 ; $4096
	snd_channel 5, $03 ; $4098
	dw Sfx1f_Trk3 ; $409a
	snd_channel 2, $01 ; $409c
	dw Sfx2f_Trk0 ; $409e
	snd_channel 3, $00 ; $40a0
	dw Sfx2f_Trk1 ; $40a2
	snd_channel 4, $02 ; $40a4
	dw Sfx2f_Trk2 ; $40a6
	snd_channel 5, $03 ; $40a8
	dw Sfx2f_Trk3 ; $40aa
	snd_channel 2, $01 ; $40ac
	dw Sfx31_Trk0 ; $40ae
	snd_channel 3, $00 ; $40b0
	dw Sfx31_Trk1 ; $40b2
	snd_channel 4, $02 ; $40b4
	dw Sfx31_Trk2 ; $40b6
	snd_channel 5, $03 ; $40b8
	dw Sfx31_Trk3 ; $40ba
	snd_channel 0, $00 ; $40bc
	dw Music9b_Trk0 ; $40be
Sfx16_Trk0:
	INCBIN "data/bank_07b/Sfx16_Trk0.bin" ; $40c0, 438 bytes
Sfx16_Trk1:
	INCBIN "data/bank_07b/Sfx16_Trk1.bin" ; $4276, 456 bytes
Sfx16_Trk2:
	INCBIN "data/bank_07b/Sfx16_Trk2.bin" ; $443e, 344 bytes
Sfx16_Trk3:
	INCBIN "data/bank_07b/Sfx16_Trk3.bin" ; $4596, 598 bytes
Sfx17_Trk0:
	INCBIN "data/bank_07b/Sfx17_Trk0.bin" ; $47ec, 264 bytes
Sfx17_Trk1:
	INCBIN "data/bank_07b/Sfx17_Trk1.bin" ; $48f4, 196 bytes
Sfx17_Trk2:
	INCBIN "data/bank_07b/Sfx17_Trk2.bin" ; $49b8, 158 bytes
Sfx17_Trk3:
	INCBIN "data/bank_07b/Sfx17_Trk3.bin" ; $4a56, 82 bytes
Sfx18_Trk0:
	INCBIN "data/bank_07b/Sfx18_Trk0.bin" ; $4aa8, 302 bytes
Sfx18_Trk1:
	INCBIN "data/bank_07b/Sfx18_Trk1.bin" ; $4bd6, 302 bytes
Sfx18_Trk2:
	INCBIN "data/bank_07b/Sfx18_Trk2.bin" ; $4d04, 148 bytes
Sfx18_Trk3:
	INCBIN "data/bank_07b/Sfx18_Trk3.bin" ; $4d98, 986 bytes
Sfx19_Trk0:
	INCBIN "data/bank_07b/Sfx19_Trk0.bin" ; $5172, 500 bytes
Sfx19_Trk1:
	INCBIN "data/bank_07b/Sfx19_Trk1.bin" ; $5366, 446 bytes
Sfx19_Trk2:
	INCBIN "data/bank_07b/Sfx19_Trk2.bin" ; $5524, 716 bytes
Sfx19_Trk3:
	INCBIN "data/bank_07b/Sfx19_Trk3.bin" ; $57f0, 154 bytes
Sfx1a_Trk0:
	INCBIN "data/bank_07b/Sfx1a_Trk0.bin" ; $588a, 218 bytes
Sfx1a_Trk1:
	INCBIN "data/bank_07b/Sfx1a_Trk1.bin" ; $5964, 222 bytes
Sfx1a_Trk2:
	INCBIN "data/bank_07b/Sfx1a_Trk2.bin" ; $5a42, 124 bytes
Sfx1b_Trk0:
	INCBIN "data/bank_07b/Sfx1b_Trk0.bin" ; $5abe, 184 bytes
Sfx1b_Trk1:
	INCBIN "data/bank_07b/Sfx1b_Trk1.bin" ; $5b76, 186 bytes
Sfx1b_Trk2:
	INCBIN "data/bank_07b/Sfx1b_Trk2.bin" ; $5c30, 208 bytes
Sfx1b_Trk3:
	INCBIN "data/bank_07b/Sfx1b_Trk3.bin" ; $5d00, 338 bytes
Sfx1c_Trk0:
	INCBIN "data/bank_07b/Sfx1c_Trk0.bin" ; $5e52, 132 bytes
Sfx1c_Trk1:
	INCBIN "data/bank_07b/Sfx1c_Trk1.bin" ; $5ed6, 234 bytes
Sfx1c_Trk2:
	INCBIN "data/bank_07b/Sfx1c_Trk2.bin" ; $5fc0, 396 bytes
Sfx1c_Trk3:
	INCBIN "data/bank_07b/Sfx1c_Trk3.bin" ; $614c, 412 bytes
Sfx1d_Trk0:
	INCBIN "data/bank_07b/Sfx1d_Trk0.bin" ; $62e8, 302 bytes
Sfx1d_Trk1:
	INCBIN "data/bank_07b/Sfx1d_Trk1.bin" ; $6416, 448 bytes
Sfx1d_Trk2:
	INCBIN "data/bank_07b/Sfx1d_Trk2.bin" ; $65d6, 240 bytes
Sfx1d_Trk3:
	INCBIN "data/bank_07b/Sfx1d_Trk3.bin" ; $66c6, 96 bytes
Sfx1e_Trk0:
	INCBIN "data/bank_07b/Sfx1e_Trk0.bin" ; $6726, 724 bytes
Sfx1e_Trk1:
	INCBIN "data/bank_07b/Sfx1e_Trk1.bin" ; $69fa, 1078 bytes
Sfx1e_Trk2:
	INCBIN "data/bank_07b/Sfx1e_Trk2.bin" ; $6e30, 1196 bytes
Sfx1e_Trk3:
	INCBIN "data/bank_07b/Sfx1e_Trk3.bin" ; $72dc, 1726 bytes
Sfx1f_Trk0:
	INCBIN "data/bank_07b/Sfx1f_Trk0.bin" ; $799a, 212 bytes
Sfx1f_Trk1:
	INCBIN "data/bank_07b/Sfx1f_Trk1.bin" ; $7a6e, 216 bytes
Sfx1f_Trk2:
	INCBIN "data/bank_07b/Sfx1f_Trk2.bin" ; $7b46, 450 bytes
Sfx1f_Trk3:
	INCBIN "data/bank_07b/Sfx1f_Trk3.bin" ; $7d08, 340 bytes
Sfx2f_Trk0:
	INCBIN "data/bank_07b/Sfx2f_Trk0.bin" ; $7e5c, 28 bytes
Sfx2f_Trk1:
	INCBIN "data/bank_07b/Sfx2f_Trk1.bin" ; $7e78, 28 bytes
Sfx2f_Trk2:
	INCBIN "data/bank_07b/Sfx2f_Trk2.bin" ; $7e94, 22 bytes
Sfx2f_Trk3:
	INCBIN "data/bank_07b/Sfx2f_Trk3.bin" ; $7eaa, 76 bytes
Sfx31_Trk0:
	INCBIN "data/bank_07b/Sfx31_Trk0.bin" ; $7ef6, 38 bytes
Sfx31_Trk1:
	INCBIN "data/bank_07b/Sfx31_Trk1.bin" ; $7f1c, 38 bytes
Sfx31_Trk2:
	INCBIN "data/bank_07b/Sfx31_Trk2.bin" ; $7f42, 34 bytes
Sfx31_Trk3:
	INCBIN "data/bank_07b/Sfx31_Trk3.bin" ; $7f64, 130 bytes
Music9b_Trk0:
	INCBIN "data/bank_07b/Music9b_Trk0.bin" ; $7fe6, 10 bytes
	; $7ff0, 16 bytes fill to bank end (linker-padded)

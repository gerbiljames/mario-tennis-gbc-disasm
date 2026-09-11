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
	INCLUDE "data/bank_07b/Sfx16_Trk0.asm" ; $40c0, 438 bytes (snd_script:pulse)
Sfx16_Trk1:
	INCLUDE "data/bank_07b/Sfx16_Trk1.asm" ; $4276, 456 bytes (snd_script:pulse)
Sfx16_Trk2:
	INCLUDE "data/bank_07b/Sfx16_Trk2.asm" ; $443e, 344 bytes (snd_script:wave)
Sfx16_Trk3:
	INCLUDE "data/bank_07b/Sfx16_Trk3.asm" ; $4596, 598 bytes (snd_script:noise)
Sfx17_Trk0:
	INCLUDE "data/bank_07b/Sfx17_Trk0.asm" ; $47ec, 264 bytes (snd_script:pulse)
Sfx17_Trk1:
	INCLUDE "data/bank_07b/Sfx17_Trk1.asm" ; $48f4, 196 bytes (snd_script:pulse)
Sfx17_Trk2:
	INCLUDE "data/bank_07b/Sfx17_Trk2.asm" ; $49b8, 158 bytes (snd_script:wave)
Sfx17_Trk3:
	INCLUDE "data/bank_07b/Sfx17_Trk3.asm" ; $4a56, 82 bytes (snd_script:noise)
Sfx18_Trk0:
	INCLUDE "data/bank_07b/Sfx18_Trk0.asm" ; $4aa8, 302 bytes (snd_script:pulse)
Sfx18_Trk1:
	INCLUDE "data/bank_07b/Sfx18_Trk1.asm" ; $4bd6, 302 bytes (snd_script:pulse)
Sfx18_Trk2:
	INCLUDE "data/bank_07b/Sfx18_Trk2.asm" ; $4d04, 148 bytes (snd_script:wave)
Sfx18_Trk3:
	INCLUDE "data/bank_07b/Sfx18_Trk3.asm" ; $4d98, 986 bytes (snd_script:noise)
Sfx19_Trk0:
	INCLUDE "data/bank_07b/Sfx19_Trk0.asm" ; $5172, 500 bytes (snd_script:pulse)
Sfx19_Trk1:
	INCLUDE "data/bank_07b/Sfx19_Trk1.asm" ; $5366, 446 bytes (snd_script:pulse)
Sfx19_Trk2:
	INCLUDE "data/bank_07b/Sfx19_Trk2.asm" ; $5524, 716 bytes (snd_script:wave)
Sfx19_Trk3:
	INCLUDE "data/bank_07b/Sfx19_Trk3.asm" ; $57f0, 154 bytes (snd_script:noise)
Sfx1a_Trk0:
	INCLUDE "data/bank_07b/Sfx1a_Trk0.asm" ; $588a, 218 bytes (snd_script:pulse)
Sfx1a_Trk1:
	INCLUDE "data/bank_07b/Sfx1a_Trk1.asm" ; $5964, 222 bytes (snd_script:pulse)
Sfx1a_Trk2:
	INCLUDE "data/bank_07b/Sfx1a_Trk2.asm" ; $5a42, 124 bytes (snd_script:wave)
Sfx1b_Trk0:
	INCLUDE "data/bank_07b/Sfx1b_Trk0.asm" ; $5abe, 184 bytes (snd_script:pulse)
Sfx1b_Trk1:
	INCLUDE "data/bank_07b/Sfx1b_Trk1.asm" ; $5b76, 186 bytes (snd_script:pulse)
Sfx1b_Trk2:
	INCLUDE "data/bank_07b/Sfx1b_Trk2.asm" ; $5c30, 208 bytes (snd_script:wave)
Sfx1b_Trk3:
	INCLUDE "data/bank_07b/Sfx1b_Trk3.asm" ; $5d00, 338 bytes (snd_script:noise)
Sfx1c_Trk0:
	INCLUDE "data/bank_07b/Sfx1c_Trk0.asm" ; $5e52, 132 bytes (snd_script:pulse)
Sfx1c_Trk1:
	INCLUDE "data/bank_07b/Sfx1c_Trk1.asm" ; $5ed6, 234 bytes (snd_script:pulse)
Sfx1c_Trk2:
	INCLUDE "data/bank_07b/Sfx1c_Trk2.asm" ; $5fc0, 396 bytes (snd_script:wave)
Sfx1c_Trk3:
	INCLUDE "data/bank_07b/Sfx1c_Trk3.asm" ; $614c, 412 bytes (snd_script:noise)
Sfx1d_Trk0:
	INCLUDE "data/bank_07b/Sfx1d_Trk0.asm" ; $62e8, 302 bytes (snd_script:pulse)
Sfx1d_Trk1:
	INCLUDE "data/bank_07b/Sfx1d_Trk1.asm" ; $6416, 448 bytes (snd_script:pulse)
Sfx1d_Trk2:
	INCLUDE "data/bank_07b/Sfx1d_Trk2.asm" ; $65d6, 240 bytes (snd_script:wave)
Sfx1d_Trk3:
	INCLUDE "data/bank_07b/Sfx1d_Trk3.asm" ; $66c6, 96 bytes (snd_script:noise)
Sfx1e_Trk0:
	INCLUDE "data/bank_07b/Sfx1e_Trk0.asm" ; $6726, 724 bytes (snd_script:pulse)
Sfx1e_Trk1:
	INCLUDE "data/bank_07b/Sfx1e_Trk1.asm" ; $69fa, 1078 bytes (snd_script:pulse)
Sfx1e_Trk2:
	INCLUDE "data/bank_07b/Sfx1e_Trk2.asm" ; $6e30, 1196 bytes (snd_script:wave)
Sfx1e_Trk3:
	INCLUDE "data/bank_07b/Sfx1e_Trk3.asm" ; $72dc, 1726 bytes (snd_script:noise)
Sfx1f_Trk0:
	INCLUDE "data/bank_07b/Sfx1f_Trk0.asm" ; $799a, 212 bytes (snd_script:pulse)
Sfx1f_Trk1:
	INCLUDE "data/bank_07b/Sfx1f_Trk1.asm" ; $7a6e, 216 bytes (snd_script:pulse)
Sfx1f_Trk2:
	INCLUDE "data/bank_07b/Sfx1f_Trk2.asm" ; $7b46, 450 bytes (snd_script:wave)
Sfx1f_Trk3:
	INCLUDE "data/bank_07b/Sfx1f_Trk3.asm" ; $7d08, 340 bytes (snd_script:noise)
Sfx2f_Trk0:
	INCLUDE "data/bank_07b/Sfx2f_Trk0.asm" ; $7e5c, 28 bytes (snd_script:pulse)
Sfx2f_Trk1:
	INCLUDE "data/bank_07b/Sfx2f_Trk1.asm" ; $7e78, 28 bytes (snd_script:pulse)
Sfx2f_Trk2:
	INCLUDE "data/bank_07b/Sfx2f_Trk2.asm" ; $7e94, 22 bytes (snd_script:wave)
Sfx2f_Trk3:
	INCLUDE "data/bank_07b/Sfx2f_Trk3.asm" ; $7eaa, 76 bytes (snd_script:noise)
Sfx31_Trk0:
	INCLUDE "data/bank_07b/Sfx31_Trk0.asm" ; $7ef6, 38 bytes (snd_script:pulse)
Sfx31_Trk1:
	INCLUDE "data/bank_07b/Sfx31_Trk1.asm" ; $7f1c, 38 bytes (snd_script:pulse)
Sfx31_Trk2:
	INCLUDE "data/bank_07b/Sfx31_Trk2.asm" ; $7f42, 34 bytes (snd_script:wave)
Sfx31_Trk3:
	INCLUDE "data/bank_07b/Sfx31_Trk3.asm" ; $7f64, 130 bytes (snd_script:noise)
Music9b_Trk0:
	INCLUDE "data/bank_07b/Music9b_Trk0.asm" ; $7fe6, 10 bytes (snd_script:pulse)
	; $7ff0, 16 bytes fill to bank end (linker-padded)

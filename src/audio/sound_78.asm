SoundTable_78:
	snd_channel 2, $01 ; $4000
	dw Sfx01_Trk0 ; $4002
	snd_channel 3, $00 ; $4004
	dw Sfx01_Trk1 ; $4006
	snd_channel 4, $02 ; $4008
	dw Sfx01_Trk2 ; $400a
	snd_channel 5, $03 ; $400c
	dw Sfx01_Trk3 ; $400e
	snd_channel 2, $01 ; $4010
	dw Sfx02_Trk0 ; $4012
	snd_channel 3, $00 ; $4014
	dw Sfx02_Trk1 ; $4016
	snd_channel 4, $02 ; $4018
	dw Sfx02_Trk2 ; $401a
	snd_channel 5, $03 ; $401c
	dw Sfx02_Trk3 ; $401e
	snd_channel 2, $01 ; $4020
	dw Sfx03_Trk0 ; $4022
	snd_channel 3, $00 ; $4024
	dw Sfx03_Trk1 ; $4026
	snd_channel 4, $02 ; $4028
	dw Sfx03_Trk2 ; $402a
	snd_channel 5, $03 ; $402c
	dw Sfx03_Trk3 ; $402e
	snd_channel 2, $01 ; $4030
	dw Sfx04_Trk0 ; $4032
	snd_channel 3, $00 ; $4034
	dw Sfx04_Trk1 ; $4036
	snd_channel 4, $02 ; $4038
	dw Sfx04_Trk2 ; $403a
	snd_channel 5, $03 ; $403c
	dw Sfx04_Trk3 ; $403e
	snd_channel 2, $01 ; $4040
	dw Sfx05_Trk0 ; $4042
	snd_channel 3, $00 ; $4044
	dw Sfx05_Trk1 ; $4046
	snd_channel 4, $02 ; $4048
	dw Sfx05_Trk2 ; $404a
	snd_channel 5, $03 ; $404c
	dw Sfx05_Trk3 ; $404e
	snd_channel 2, $01 ; $4050
	dw Sfx06_Trk0 ; $4052
	snd_channel 3, $00 ; $4054
	dw Sfx06_Trk1 ; $4056
	snd_channel 4, $02 ; $4058
	dw Sfx06_Trk2 ; $405a
	snd_channel 5, $03 ; $405c
	dw Sfx06_Trk3 ; $405e
	snd_channel 2, $01 ; $4060
	dw Sfx07_Trk0 ; $4062
	snd_channel 3, $00 ; $4064
	dw Sfx07_Trk1 ; $4066
	snd_channel 4, $02 ; $4068
	dw Sfx07_Trk2 ; $406a
	snd_channel 5, $03 ; $406c
	dw Sfx07_Trk3 ; $406e
	snd_channel 2, $01 ; $4070
	dw Sfx0a_Trk0 ; $4072
	snd_channel 3, $00 ; $4074
	dw Sfx0a_Trk1 ; $4076
	snd_channel 4, $02 ; $4078
	dw Sfx0a_Trk2 ; $407a
	snd_channel 0, $03 ; $407c
	dw Music51_Trk0 ; $407e
	snd_channel 0, $03 ; $4080
	dw Music52_Trk0 ; $4082
	snd_channel 0, $00 ; $4084
	dw Music9a_Trk0 ; $4086
Sfx01_Trk0:
	INCBIN "data/bank_078/Sfx01_Trk0.bin" ; $4088, 240 bytes
Sfx01_Trk1:
	INCBIN "data/bank_078/Sfx01_Trk1.bin" ; $4178, 242 bytes
Sfx01_Trk2:
	INCBIN "data/bank_078/Sfx01_Trk2.bin" ; $426a, 356 bytes
Sfx01_Trk3:
	INCBIN "data/bank_078/Sfx01_Trk3.bin" ; $43ce, 1336 bytes
Sfx02_Trk0:
	INCBIN "data/bank_078/Sfx02_Trk0.bin" ; $4906, 62 bytes
Sfx02_Trk1:
	INCBIN "data/bank_078/Sfx02_Trk1.bin" ; $4944, 78 bytes
Sfx02_Trk2:
	INCBIN "data/bank_078/Sfx02_Trk2.bin" ; $4992, 174 bytes
Sfx02_Trk3:
	INCBIN "data/bank_078/Sfx02_Trk3.bin" ; $4a40, 582 bytes
Sfx03_Trk0:
	INCBIN "data/bank_078/Sfx03_Trk0.bin" ; $4c86, 486 bytes
Sfx03_Trk1:
	INCBIN "data/bank_078/Sfx03_Trk1.bin" ; $4e6c, 448 bytes
Sfx03_Trk2:
	INCBIN "data/bank_078/Sfx03_Trk2.bin" ; $502c, 1134 bytes
Sfx03_Trk3:
	INCBIN "data/bank_078/Sfx03_Trk3.bin" ; $549a, 832 bytes
Sfx04_Trk0:
	INCBIN "data/bank_078/Sfx04_Trk0.bin" ; $57da, 530 bytes
Sfx04_Trk1:
	INCBIN "data/bank_078/Sfx04_Trk1.bin" ; $59ec, 530 bytes
Sfx04_Trk2:
	INCBIN "data/bank_078/Sfx04_Trk2.bin" ; $5bfe, 266 bytes
Sfx04_Trk3:
	INCBIN "data/bank_078/Sfx04_Trk3.bin" ; $5d08, 824 bytes
Sfx05_Trk0:
	INCBIN "data/bank_078/Sfx05_Trk0.bin" ; $6040, 436 bytes
Sfx05_Trk1:
	INCBIN "data/bank_078/Sfx05_Trk1.bin" ; $61f4, 300 bytes
Sfx05_Trk2:
	INCBIN "data/bank_078/Sfx05_Trk2.bin" ; $6320, 354 bytes
Sfx05_Trk3:
	INCBIN "data/bank_078/Sfx05_Trk3.bin" ; $6482, 866 bytes
Sfx06_Trk0:
	INCBIN "data/bank_078/Sfx06_Trk0.bin" ; $67e4, 624 bytes
Sfx06_Trk1:
	INCBIN "data/bank_078/Sfx06_Trk1.bin" ; $6a54, 578 bytes
Sfx06_Trk2:
	INCBIN "data/bank_078/Sfx06_Trk2.bin" ; $6c96, 1276 bytes
Sfx06_Trk3:
	INCBIN "data/bank_078/Sfx06_Trk3.bin" ; $7192, 1284 bytes
Sfx07_Trk0:
	INCBIN "data/bank_078/Sfx07_Trk0.bin" ; $7696, 386 bytes
Sfx07_Trk1:
	INCBIN "data/bank_078/Sfx07_Trk1.bin" ; $7818, 712 bytes
Sfx07_Trk2:
	INCBIN "data/bank_078/Sfx07_Trk2.bin" ; $7ae0, 708 bytes
Sfx07_Trk3:
	INCBIN "data/bank_078/Sfx07_Trk3.bin" ; $7da4, 392 bytes
Sfx0a_Trk0:
	INCBIN "data/bank_078/Sfx0a_Trk0.bin" ; $7f2c, 58 bytes
Sfx0a_Trk1:
	INCBIN "data/bank_078/Sfx0a_Trk1.bin" ; $7f66, 56 bytes
Sfx0a_Trk2:
	INCBIN "data/bank_078/Sfx0a_Trk2.bin" ; $7f9e, 24 bytes
Music51_Trk0:
	INCBIN "data/bank_078/Music51_Trk0.bin" ; $7fb6, 22 bytes
Music52_Trk0:
	INCBIN "data/bank_078/Music52_Trk0.bin" ; $7fcc, 26 bytes
Music9a_Trk0:
	INCBIN "data/bank_078/Music9a_Trk0.bin" ; $7fe6, 10 bytes
	; $7ff0, 16 bytes fill to bank end (linker-padded)

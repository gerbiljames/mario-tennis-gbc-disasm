SoundTable_78:
	ASSERT SoundTable_78 == $4000
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
	INCLUDE "data/bank_078/Sfx01_Trk0.asm" ; $4088, 240 bytes (snd_script:pulse)
Sfx01_Trk1:
	INCLUDE "data/bank_078/Sfx01_Trk1.asm" ; $4178, 242 bytes (snd_script:pulse)
Sfx01_Trk2:
	INCLUDE "data/bank_078/Sfx01_Trk2.asm" ; $426a, 356 bytes (snd_script:wave)
Sfx01_Trk3:
	INCLUDE "data/bank_078/Sfx01_Trk3.asm" ; $43ce, 1336 bytes (snd_script:noise)
Sfx02_Trk0:
	INCLUDE "data/bank_078/Sfx02_Trk0.asm" ; $4906, 62 bytes (snd_script:pulse)
Sfx02_Trk1:
	INCLUDE "data/bank_078/Sfx02_Trk1.asm" ; $4944, 78 bytes (snd_script:pulse)
Sfx02_Trk2:
	INCLUDE "data/bank_078/Sfx02_Trk2.asm" ; $4992, 174 bytes (snd_script:wave)
Sfx02_Trk3:
	INCLUDE "data/bank_078/Sfx02_Trk3.asm" ; $4a40, 582 bytes (snd_script:noise)
Sfx03_Trk0:
	INCLUDE "data/bank_078/Sfx03_Trk0.asm" ; $4c86, 486 bytes (snd_script:pulse)
Sfx03_Trk1:
	INCLUDE "data/bank_078/Sfx03_Trk1.asm" ; $4e6c, 448 bytes (snd_script:pulse)
Sfx03_Trk2:
	INCLUDE "data/bank_078/Sfx03_Trk2.asm" ; $502c, 1134 bytes (snd_script:wave)
Sfx03_Trk3:
	INCLUDE "data/bank_078/Sfx03_Trk3.asm" ; $549a, 832 bytes (snd_script:noise)
Sfx04_Trk0:
	INCLUDE "data/bank_078/Sfx04_Trk0.asm" ; $57da, 530 bytes (snd_script:pulse)
Sfx04_Trk1:
	INCLUDE "data/bank_078/Sfx04_Trk1.asm" ; $59ec, 530 bytes (snd_script:pulse)
Sfx04_Trk2:
	INCLUDE "data/bank_078/Sfx04_Trk2.asm" ; $5bfe, 266 bytes (snd_script:wave)
Sfx04_Trk3:
	INCLUDE "data/bank_078/Sfx04_Trk3.asm" ; $5d08, 824 bytes (snd_script:noise)
Sfx05_Trk0:
	INCLUDE "data/bank_078/Sfx05_Trk0.asm" ; $6040, 436 bytes (snd_script:pulse)
Sfx05_Trk1:
	INCLUDE "data/bank_078/Sfx05_Trk1.asm" ; $61f4, 300 bytes (snd_script:pulse)
Sfx05_Trk2:
	INCLUDE "data/bank_078/Sfx05_Trk2.asm" ; $6320, 354 bytes (snd_script:wave)
Sfx05_Trk3:
	INCLUDE "data/bank_078/Sfx05_Trk3.asm" ; $6482, 866 bytes (snd_script:noise)
Sfx06_Trk0:
	INCLUDE "data/bank_078/Sfx06_Trk0.asm" ; $67e4, 624 bytes (snd_script:pulse)
Sfx06_Trk1:
	INCLUDE "data/bank_078/Sfx06_Trk1.asm" ; $6a54, 578 bytes (snd_script:pulse)
Sfx06_Trk2:
	INCLUDE "data/bank_078/Sfx06_Trk2.asm" ; $6c96, 1276 bytes (snd_script:wave)
Sfx06_Trk3:
	INCLUDE "data/bank_078/Sfx06_Trk3.asm" ; $7192, 1284 bytes (snd_script:noise)
Sfx07_Trk0:
	INCLUDE "data/bank_078/Sfx07_Trk0.asm" ; $7696, 386 bytes (snd_script:pulse)
Sfx07_Trk1:
	INCLUDE "data/bank_078/Sfx07_Trk1.asm" ; $7818, 712 bytes (snd_script:pulse)
Sfx07_Trk2:
	INCLUDE "data/bank_078/Sfx07_Trk2.asm" ; $7ae0, 708 bytes (snd_script:wave)
Sfx07_Trk3:
	INCLUDE "data/bank_078/Sfx07_Trk3.asm" ; $7da4, 392 bytes (snd_script:noise)
Sfx0a_Trk0:
	INCLUDE "data/bank_078/Sfx0a_Trk0.asm" ; $7f2c, 58 bytes (snd_script:pulse)
Sfx0a_Trk1:
	INCLUDE "data/bank_078/Sfx0a_Trk1.asm" ; $7f66, 56 bytes (snd_script:pulse)
Sfx0a_Trk2:
	INCLUDE "data/bank_078/Sfx0a_Trk2.asm" ; $7f9e, 24 bytes (snd_script:wave)
Music51_Trk0:
	INCLUDE "data/bank_078/Music51_Trk0.asm" ; $7fb6, 22 bytes (snd_script:noise)
Music52_Trk0:
	INCLUDE "data/bank_078/Music52_Trk0.asm" ; $7fcc, 26 bytes (snd_script:noise)
Music9a_Trk0:
	INCLUDE "data/bank_078/Music9a_Trk0.asm" ; $7fe6, 10 bytes (snd_script:pulse)
	; $7ff0, 16 bytes fill to bank end (linker-padded)

SoundTable_7d:
	ASSERT SoundTable_7d == $4000
	snd_channel 2, $01 ; $4000
	dw Sfx25_Trk0 ; $4002
	snd_channel 3, $00 ; $4004
	dw Sfx25_Trk1 ; $4006
	snd_channel 4, $02 ; $4008
	dw Sfx25_Trk2 ; $400a
	snd_channel 5, $03 ; $400c
	dw Sfx25_Trk3 ; $400e
	snd_channel 2, $01 ; $4010
	dw Sfx26_Trk0 ; $4012
	snd_channel 3, $00 ; $4014
	dw Sfx26_Trk1 ; $4016
	snd_channel 4, $02 ; $4018
	dw Sfx26_Trk2 ; $401a
	snd_channel 5, $03 ; $401c
	dw Sfx26_Trk3 ; $401e
	snd_channel 2, $01 ; $4020
	dw Sfx27_Trk0 ; $4022
	snd_channel 3, $00 ; $4024
	dw Sfx27_Trk1 ; $4026
	snd_channel 4, $02 ; $4028
	dw Sfx27_Trk2 ; $402a
	snd_channel 5, $03 ; $402c
	dw Sfx27_Trk3 ; $402e
	snd_channel 2, $01 ; $4030
	dw Sfx2a_Trk0 ; $4032
	snd_channel 3, $00 ; $4034
	dw Sfx2a_Trk1 ; $4036
	snd_channel 4, $02 ; $4038
	dw Sfx2a_Trk2 ; $403a
	snd_channel 5, $03 ; $403c
	dw Sfx2a_Trk3 ; $403e
	snd_channel 2, $01 ; $4040
	dw Sfx2b_Trk0 ; $4042
	snd_channel 3, $00 ; $4044
	dw Sfx2b_Trk1 ; $4046
	snd_channel 4, $02 ; $4048
	dw Sfx2b_Trk2 ; $404a
	snd_channel 5, $03 ; $404c
	dw Sfx2b_Trk3 ; $404e
	snd_channel 2, $01 ; $4050
	dw Sfx30_Trk0 ; $4052
	snd_channel 3, $00 ; $4054
	dw Sfx30_Trk1 ; $4056
	snd_channel 4, $02 ; $4058
	dw Sfx30_Trk2 ; $405a
	snd_channel 5, $03 ; $405c
	dw Sfx30_Trk3 ; $405e
	snd_channel 2, $01 ; $4060
	dw Sfx32_Trk0 ; $4062
	snd_channel 3, $00 ; $4064
	dw Sfx32_Trk1 ; $4066
	snd_channel 4, $02 ; $4068
	dw Sfx32_Trk2 ; $406a
	snd_channel 5, $03 ; $406c
	dw Sfx32_Trk3 ; $406e
	snd_channel 0, $00 ; $4070
	dw Music5a_Trk0 ; $4072
	snd_channel 0, $00 ; $4074
	dw Music5c_Trk0 ; $4076
	snd_channel 0, $00 ; $4078
	dw Music9c_Trk0 ; $407a
Sfx25_Trk0:
	INCLUDE "data/bank_07d/Sfx25_Trk0.asm" ; $407c, 650 bytes (snd_script:pulse)
Sfx25_Trk1:
	INCLUDE "data/bank_07d/Sfx25_Trk1.asm" ; $4306, 1102 bytes (snd_script:pulse)
Sfx25_Trk2:
	INCLUDE "data/bank_07d/Sfx25_Trk2.asm" ; $4754, 302 bytes (snd_script:wave)
Sfx25_Trk3:
	INCLUDE "data/bank_07d/Sfx25_Trk3.asm" ; $4882, 1664 bytes (snd_script:noise)
Sfx26_Trk0:
	INCLUDE "data/bank_07d/Sfx26_Trk0.asm" ; $4f02, 1434 bytes (snd_script:pulse)
Sfx26_Trk1:
	INCLUDE "data/bank_07d/Sfx26_Trk1.asm" ; $549c, 1380 bytes (snd_script:pulse)
Sfx26_Trk2:
	INCLUDE "data/bank_07d/Sfx26_Trk2.asm" ; $5a00, 1714 bytes (snd_script:wave)
Sfx26_Trk3:
	INCLUDE "data/bank_07d/Sfx26_Trk3.asm" ; $60b2, 1542 bytes (snd_script:noise)
Sfx27_Trk0:
	INCLUDE "data/bank_07d/Sfx27_Trk0.asm" ; $66b8, 570 bytes (snd_script:pulse)
Sfx27_Trk1:
	INCLUDE "data/bank_07d/Sfx27_Trk1.asm" ; $68f2, 1610 bytes (snd_script:pulse)
Sfx27_Trk2:
	INCLUDE "data/bank_07d/Sfx27_Trk2.asm" ; $6f3c, 1650 bytes (snd_script:wave)
Sfx27_Trk3:
	INCLUDE "data/bank_07d/Sfx27_Trk3.asm" ; $75ae, 162 bytes (snd_script:noise)
Sfx2a_Trk0:
	INCLUDE "data/bank_07d/Sfx2a_Trk0.asm" ; $7650, 272 bytes (snd_script:pulse)
Sfx2a_Trk1:
	INCLUDE "data/bank_07d/Sfx2a_Trk1.asm" ; $7760, 266 bytes (snd_script:pulse)
Sfx2a_Trk2:
	INCLUDE "data/bank_07d/Sfx2a_Trk2.asm" ; $786a, 20 bytes (snd_script:wave)
Sfx2a_Trk3:
	INCLUDE "data/bank_07d/Sfx2a_Trk3.asm" ; $787e, 102 bytes (snd_script:noise)
Sfx2b_Trk0:
	INCLUDE "data/bank_07d/Sfx2b_Trk0.asm" ; $78e4, 164 bytes (snd_script:pulse)
Sfx2b_Trk1:
	INCLUDE "data/bank_07d/Sfx2b_Trk1.asm" ; $7988, 164 bytes (snd_script:pulse)
Sfx2b_Trk2:
	INCLUDE "data/bank_07d/Sfx2b_Trk2.asm" ; $7a2c, 224 bytes (snd_script:wave)
Sfx2b_Trk3:
	INCLUDE "data/bank_07d/Sfx2b_Trk3.asm" ; $7b0c, 398 bytes (snd_script:noise)
Sfx30_Trk0:
	INCLUDE "data/bank_07d/Sfx30_Trk0.asm" ; $7c9a, 64 bytes (snd_script:pulse)
Sfx30_Trk1:
	INCLUDE "data/bank_07d/Sfx30_Trk1.asm" ; $7cda, 64 bytes (snd_script:pulse)
Sfx30_Trk2:
	INCLUDE "data/bank_07d/Sfx30_Trk2.asm" ; $7d1a, 26 bytes (snd_script:wave)
Sfx30_Trk3:
	INCLUDE "data/bank_07d/Sfx30_Trk3.asm" ; $7d34, 188 bytes (snd_script:noise)
Sfx32_Trk0:
	INCLUDE "data/bank_07d/Sfx32_Trk0.asm" ; $7df0, 42 bytes (snd_script:pulse)
Sfx32_Trk1:
	INCLUDE "data/bank_07d/Sfx32_Trk1.asm" ; $7e1a, 42 bytes (snd_script:pulse)
Sfx32_Trk2:
	INCLUDE "data/bank_07d/Sfx32_Trk2.asm" ; $7e44, 42 bytes (snd_script:wave)
Sfx32_Trk3:
	INCLUDE "data/bank_07d/Sfx32_Trk3.asm" ; $7e6e, 226 bytes (snd_script:noise)
Music5a_Trk0:
	INCLUDE "data/bank_07d/Music5a_Trk0.asm" ; $7f50, 76 bytes (snd_script:pulse)
Music5c_Trk0:
	INCLUDE "data/bank_07d/Music5c_Trk0.asm" ; $7f9c, 76 bytes (snd_script:pulse)
Music9c_Trk0:
	INCLUDE "data/bank_07d/Music9c_Trk0.asm" ; $7fe8, 10 bytes (snd_script:pulse)
	; $7ff2, 14 bytes fill to bank end (linker-padded)

SoundTable_7d:
	ASSERT SoundTable_7d == $4000
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4000
	dw MusicDrillPractice_Trk0 ; $4002
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4004
	dw MusicDrillPractice_Trk1 ; $4006
	snd_channel 4, SNDCHANTYPE_WAVE ; $4008
	dw MusicDrillPractice_Trk2 ; $400a
	snd_channel 5, SNDCHANTYPE_NOISE ; $400c
	dw MusicDrillPractice_Trk3 ; $400e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4010
	dw MusicIslandOpen_Trk0 ; $4012
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4014
	dw MusicIslandOpen_Trk1 ; $4016
	snd_channel 4, SNDCHANTYPE_WAVE ; $4018
	dw MusicIslandOpen_Trk2 ; $401a
	snd_channel 5, SNDCHANTYPE_NOISE ; $401c
	dw MusicIslandOpen_Trk3 ; $401e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4020
	dw MusicIslandOpenSemifinal_Trk0 ; $4022
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4024
	dw MusicIslandOpenSemifinal_Trk1 ; $4026
	snd_channel 4, SNDCHANTYPE_WAVE ; $4028
	dw MusicIslandOpenSemifinal_Trk2 ; $402a
	snd_channel 5, SNDCHANTYPE_NOISE ; $402c
	dw MusicIslandOpenSemifinal_Trk3 ; $402e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4030
	dw MusicIslandOpenLose_Trk0 ; $4032
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4034
	dw MusicIslandOpenLose_Trk1 ; $4036
	snd_channel 4, SNDCHANTYPE_WAVE ; $4038
	dw MusicIslandOpenLose_Trk2 ; $403a
	snd_channel 5, SNDCHANTYPE_NOISE ; $403c
	dw MusicIslandOpenLose_Trk3 ; $403e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4040
	dw MusicIslandOpenWin_Trk0 ; $4042
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4044
	dw MusicIslandOpenWin_Trk1 ; $4046
	snd_channel 4, SNDCHANTYPE_WAVE ; $4048
	dw MusicIslandOpenWin_Trk2 ; $404a
	snd_channel 5, SNDCHANTYPE_NOISE ; $404c
	dw MusicIslandOpenWin_Trk3 ; $404e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4050
	dw MusicHighScore_Trk0 ; $4052
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4054
	dw MusicHighScore_Trk1 ; $4056
	snd_channel 4, SNDCHANTYPE_WAVE ; $4058
	dw MusicHighScore_Trk2 ; $405a
	snd_channel 5, SNDCHANTYPE_NOISE ; $405c
	dw MusicHighScore_Trk3 ; $405e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4060
	dw MusicCourtIntro_Trk0 ; $4062
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4064
	dw MusicCourtIntro_Trk1 ; $4066
	snd_channel 4, SNDCHANTYPE_WAVE ; $4068
	dw MusicCourtIntro_Trk2 ; $406a
	snd_channel 5, SNDCHANTYPE_NOISE ; $406c
	dw MusicCourtIntro_Trk3 ; $406e
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4070
	dw SfxNetCord_Trk0 ; $4072
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4074
	dw SfxLeap_Trk0 ; $4076
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4078
	dw Sfx9c_Trk0 ; $407a
MusicDrillPractice_Trk0:
	INCLUDE "data/audio/MusicDrillPractice_Trk0.asm" ; $407c, 650 bytes (snd_script:pulse)
MusicDrillPractice_Trk1:
	INCLUDE "data/audio/MusicDrillPractice_Trk1.asm" ; $4306, 1102 bytes (snd_script:pulse)
MusicDrillPractice_Trk2:
	INCLUDE "data/audio/MusicDrillPractice_Trk2.asm" ; $4754, 302 bytes (snd_script:wave)
MusicDrillPractice_Trk3:
	INCLUDE "data/audio/MusicDrillPractice_Trk3.asm" ; $4882, 1664 bytes (snd_script:noise)
MusicIslandOpen_Trk0:
	INCLUDE "data/audio/MusicIslandOpen_Trk0.asm" ; $4f02, 1434 bytes (snd_script:pulse)
MusicIslandOpen_Trk1:
	INCLUDE "data/audio/MusicIslandOpen_Trk1.asm" ; $549c, 1380 bytes (snd_script:pulse)
MusicIslandOpen_Trk2:
	INCLUDE "data/audio/MusicIslandOpen_Trk2.asm" ; $5a00, 1714 bytes (snd_script:wave)
MusicIslandOpen_Trk3:
	INCLUDE "data/audio/MusicIslandOpen_Trk3.asm" ; $60b2, 1542 bytes (snd_script:noise)
MusicIslandOpenSemifinal_Trk0:
	INCLUDE "data/audio/MusicIslandOpenSemifinal_Trk0.asm" ; $66b8, 570 bytes (snd_script:pulse)
MusicIslandOpenSemifinal_Trk1:
	INCLUDE "data/audio/MusicIslandOpenSemifinal_Trk1.asm" ; $68f2, 1610 bytes (snd_script:pulse)
MusicIslandOpenSemifinal_Trk2:
	INCLUDE "data/audio/MusicIslandOpenSemifinal_Trk2.asm" ; $6f3c, 1650 bytes (snd_script:wave)
MusicIslandOpenSemifinal_Trk3:
	INCLUDE "data/audio/MusicIslandOpenSemifinal_Trk3.asm" ; $75ae, 162 bytes (snd_script:noise)
MusicIslandOpenLose_Trk0:
	INCLUDE "data/audio/MusicIslandOpenLose_Trk0.asm" ; $7650, 272 bytes (snd_script:pulse)
MusicIslandOpenLose_Trk1:
	INCLUDE "data/audio/MusicIslandOpenLose_Trk1.asm" ; $7760, 266 bytes (snd_script:pulse)
MusicIslandOpenLose_Trk2:
	INCLUDE "data/audio/MusicIslandOpenLose_Trk2.asm" ; $786a, 20 bytes (snd_script:wave)
MusicIslandOpenLose_Trk3:
	INCLUDE "data/audio/MusicIslandOpenLose_Trk3.asm" ; $787e, 102 bytes (snd_script:noise)
MusicIslandOpenWin_Trk0:
	INCLUDE "data/audio/MusicIslandOpenWin_Trk0.asm" ; $78e4, 164 bytes (snd_script:pulse)
MusicIslandOpenWin_Trk1:
	INCLUDE "data/audio/MusicIslandOpenWin_Trk1.asm" ; $7988, 164 bytes (snd_script:pulse)
MusicIslandOpenWin_Trk2:
	INCLUDE "data/audio/MusicIslandOpenWin_Trk2.asm" ; $7a2c, 224 bytes (snd_script:wave)
MusicIslandOpenWin_Trk3:
	INCLUDE "data/audio/MusicIslandOpenWin_Trk3.asm" ; $7b0c, 398 bytes (snd_script:noise)
MusicHighScore_Trk0:
	INCLUDE "data/audio/MusicHighScore_Trk0.asm" ; $7c9a, 64 bytes (snd_script:pulse)
MusicHighScore_Trk1:
	INCLUDE "data/audio/MusicHighScore_Trk1.asm" ; $7cda, 64 bytes (snd_script:pulse)
MusicHighScore_Trk2:
	INCLUDE "data/audio/MusicHighScore_Trk2.asm" ; $7d1a, 26 bytes (snd_script:wave)
MusicHighScore_Trk3:
	INCLUDE "data/audio/MusicHighScore_Trk3.asm" ; $7d34, 188 bytes (snd_script:noise)
MusicCourtIntro_Trk0:
	INCLUDE "data/audio/MusicCourtIntro_Trk0.asm" ; $7df0, 42 bytes (snd_script:pulse)
MusicCourtIntro_Trk1:
	INCLUDE "data/audio/MusicCourtIntro_Trk1.asm" ; $7e1a, 42 bytes (snd_script:pulse)
MusicCourtIntro_Trk2:
	INCLUDE "data/audio/MusicCourtIntro_Trk2.asm" ; $7e44, 42 bytes (snd_script:wave)
MusicCourtIntro_Trk3:
	INCLUDE "data/audio/MusicCourtIntro_Trk3.asm" ; $7e6e, 226 bytes (snd_script:noise)
SfxNetCord_Trk0:
	INCLUDE "data/audio/SfxNetCord_Trk0.asm" ; $7f50, 76 bytes (snd_script:pulse)
SfxLeap_Trk0:
	INCLUDE "data/audio/SfxLeap_Trk0.asm" ; $7f9c, 76 bytes (snd_script:pulse)
Sfx9c_Trk0:
	INCLUDE "data/audio/Sfx9c_Trk0.asm" ; $7fe8, 10 bytes (snd_script:pulse)
	; $7ff2, 14 bytes fill to bank end (linker-padded)

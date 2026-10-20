SoundTable_7a:
	ASSERT SoundTable_7a == $4000
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4000
	dw MusicGamePoint_Trk0 ; $4002
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4004
	dw MusicGamePoint_Trk1 ; $4006
	snd_channel 4, SNDCHANTYPE_WAVE ; $4008
	dw MusicGamePoint_Trk2 ; $400a
	snd_channel 5, SNDCHANTYPE_NOISE ; $400c
	dw MusicGamePoint_Trk3 ; $400e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4010
	dw MusicCourtStar_Trk0 ; $4012
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4014
	dw MusicCourtStar_Trk1 ; $4016
	snd_channel 4, SNDCHANTYPE_WAVE ; $4018
	dw MusicCourtStar_Trk2 ; $401a
	snd_channel 5, SNDCHANTYPE_NOISE ; $401c
	dw MusicCourtStar_Trk3 ; $401e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4020
	dw MusicCourtCastle_Trk0 ; $4022
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4024
	dw MusicCourtCastle_Trk1 ; $4026
	snd_channel 4, SNDCHANTYPE_WAVE ; $4028
	dw MusicCourtCastle_Trk2 ; $402a
	snd_channel 5, SNDCHANTYPE_NOISE ; $402c
	dw MusicCourtCastle_Trk3 ; $402e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4030
	dw MusicCourtTropic_Trk0 ; $4032
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4034
	dw MusicCourtTropic_Trk1 ; $4036
	snd_channel 4, SNDCHANTYPE_WAVE ; $4038
	dw MusicCourtTropic_Trk2 ; $403a
	snd_channel 5, SNDCHANTYPE_NOISE ; $403c
	dw MusicCourtTropic_Trk3 ; $403e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4040
	dw MusicCourtWarehouse_Trk0 ; $4042
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4044
	dw MusicCourtWarehouse_Trk1 ; $4046
	snd_channel 4, SNDCHANTYPE_WAVE ; $4048
	dw MusicCourtWarehouse_Trk2 ; $404a
	snd_channel 5, SNDCHANTYPE_NOISE ; $404c
	dw MusicCourtWarehouse_Trk3 ; $404e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4050
	dw MusicTwoOnOne_Trk0 ; $4052
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4054
	dw MusicTwoOnOne_Trk1 ; $4056
	snd_channel 4, SNDCHANTYPE_WAVE ; $4058
	dw MusicTwoOnOne_Trk2 ; $405a
	snd_channel 5, SNDCHANTYPE_NOISE ; $405c
	dw MusicTwoOnOne_Trk3 ; $405e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4060
	dw MusicDoneForTheDay_Trk0 ; $4062
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4064
	dw MusicDoneForTheDay_Trk1 ; $4066
	snd_channel 4, SNDCHANTYPE_WAVE ; $4068
	dw MusicDoneForTheDay_Trk2 ; $406a
MusicGamePoint_Trk0:
	INCLUDE "data/audio/MusicGamePoint_Trk0.asm" ; $406c, 850 bytes (snd_script:pulse)
MusicGamePoint_Trk1:
	INCLUDE "data/audio/MusicGamePoint_Trk1.asm" ; $43be, 628 bytes (snd_script:pulse)
MusicGamePoint_Trk2:
	INCLUDE "data/audio/MusicGamePoint_Trk2.asm" ; $4632, 1622 bytes (snd_script:wave)
MusicGamePoint_Trk3:
	INCLUDE "data/audio/MusicGamePoint_Trk3.asm" ; $4c88, 780 bytes (snd_script:noise)
MusicCourtStar_Trk0:
	INCLUDE "data/audio/MusicCourtStar_Trk0.asm" ; $4f94, 720 bytes (snd_script:pulse)
MusicCourtStar_Trk1:
	INCLUDE "data/audio/MusicCourtStar_Trk1.asm" ; $5264, 756 bytes (snd_script:pulse)
MusicCourtStar_Trk2:
	INCLUDE "data/audio/MusicCourtStar_Trk2.asm" ; $5558, 610 bytes (snd_script:wave)
MusicCourtStar_Trk3:
	INCLUDE "data/audio/MusicCourtStar_Trk3.asm" ; $57ba, 752 bytes (snd_script:noise)
MusicCourtCastle_Trk0:
	INCLUDE "data/audio/MusicCourtCastle_Trk0.asm" ; $5aaa, 1454 bytes (snd_script:pulse)
MusicCourtCastle_Trk1:
	INCLUDE "data/audio/MusicCourtCastle_Trk1.asm" ; $6058, 1246 bytes (snd_script:pulse)
MusicCourtCastle_Trk2:
	INCLUDE "data/audio/MusicCourtCastle_Trk2.asm" ; $6536, 320 bytes (snd_script:wave)
MusicCourtCastle_Trk3:
	INCLUDE "data/audio/MusicCourtCastle_Trk3.asm" ; $6676, 672 bytes (snd_script:noise)
MusicCourtTropic_Trk0:
	INCLUDE "data/audio/MusicCourtTropic_Trk0.asm" ; $6916, 520 bytes (snd_script:pulse)
MusicCourtTropic_Trk1:
	INCLUDE "data/audio/MusicCourtTropic_Trk1.asm" ; $6b1e, 610 bytes (snd_script:pulse)
MusicCourtTropic_Trk2:
	INCLUDE "data/audio/MusicCourtTropic_Trk2.asm" ; $6d80, 680 bytes (snd_script:wave)
MusicCourtTropic_Trk3:
	INCLUDE "data/audio/MusicCourtTropic_Trk3.asm" ; $7028, 624 bytes (snd_script:noise)
MusicCourtWarehouse_Trk0:
	INCLUDE "data/audio/MusicCourtWarehouse_Trk0.asm" ; $7298, 364 bytes (snd_script:pulse)
MusicCourtWarehouse_Trk1:
	INCLUDE "data/audio/MusicCourtWarehouse_Trk1.asm" ; $7404, 318 bytes (snd_script:pulse)
MusicCourtWarehouse_Trk2:
	INCLUDE "data/audio/MusicCourtWarehouse_Trk2.asm" ; $7542, 370 bytes (snd_script:wave)
MusicCourtWarehouse_Trk3:
	INCLUDE "data/audio/MusicCourtWarehouse_Trk3.asm" ; $76b4, 678 bytes (snd_script:noise)
MusicTwoOnOne_Trk0:
	INCLUDE "data/audio/MusicTwoOnOne_Trk0.asm" ; $795a, 406 bytes (snd_script:pulse)
MusicTwoOnOne_Trk1:
	INCLUDE "data/audio/MusicTwoOnOne_Trk1.asm" ; $7af0, 382 bytes (snd_script:pulse)
MusicTwoOnOne_Trk2:
	INCLUDE "data/audio/MusicTwoOnOne_Trk2.asm" ; $7c6e, 294 bytes (snd_script:wave)
MusicTwoOnOne_Trk3:
	INCLUDE "data/audio/MusicTwoOnOne_Trk3.asm" ; $7d94, 364 bytes (snd_script:noise)
MusicDoneForTheDay_Trk0:
	INCLUDE "data/audio/MusicDoneForTheDay_Trk0.asm" ; $7f00, 94 bytes (snd_script:pulse)
MusicDoneForTheDay_Trk1:
	INCLUDE "data/audio/MusicDoneForTheDay_Trk1.asm" ; $7f5e, 76 bytes (snd_script:pulse)
MusicDoneForTheDay_Trk2:
	INCLUDE "data/audio/MusicDoneForTheDay_Trk2.asm" ; $7faa, 70 bytes (snd_script:wave)
	; $7ff0, 16 bytes fill to bank end (linker-padded)

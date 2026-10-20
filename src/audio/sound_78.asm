SoundTable_78:
	ASSERT SoundTable_78 == $4000
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4000
	dw MusicIntro_Trk0 ; $4002
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4004
	dw MusicIntro_Trk1 ; $4006
	snd_channel 4, SNDCHANTYPE_WAVE ; $4008
	dw MusicIntro_Trk2 ; $400a
	snd_channel 5, SNDCHANTYPE_NOISE ; $400c
	dw MusicIntro_Trk3 ; $400e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4010
	dw MusicTitleScreen_Trk0 ; $4012
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4014
	dw MusicTitleScreen_Trk1 ; $4016
	snd_channel 4, SNDCHANTYPE_WAVE ; $4018
	dw MusicTitleScreen_Trk2 ; $401a
	snd_channel 5, SNDCHANTYPE_NOISE ; $401c
	dw MusicTitleScreen_Trk3 ; $401e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4020
	dw MusicMenu_Trk0 ; $4022
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4024
	dw MusicMenu_Trk1 ; $4026
	snd_channel 4, SNDCHANTYPE_WAVE ; $4028
	dw MusicMenu_Trk2 ; $402a
	snd_channel 5, SNDCHANTYPE_NOISE ; $402c
	dw MusicMenu_Trk3 ; $402e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4030
	dw MusicStatusScreen_Trk0 ; $4032
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4034
	dw MusicStatusScreen_Trk1 ; $4036
	snd_channel 4, SNDCHANTYPE_WAVE ; $4038
	dw MusicStatusScreen_Trk2 ; $403a
	snd_channel 5, SNDCHANTYPE_NOISE ; $403c
	dw MusicStatusScreen_Trk3 ; $403e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4040
	dw MusicDictionary_Trk0 ; $4042
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4044
	dw MusicDictionary_Trk1 ; $4046
	snd_channel 4, SNDCHANTYPE_WAVE ; $4048
	dw MusicDictionary_Trk2 ; $404a
	snd_channel 5, SNDCHANTYPE_NOISE ; $404c
	dw MusicDictionary_Trk3 ; $404e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4050
	dw MusicExhibitionMatch_Trk0 ; $4052
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4054
	dw MusicExhibitionMatch_Trk1 ; $4056
	snd_channel 4, SNDCHANTYPE_WAVE ; $4058
	dw MusicExhibitionMatch_Trk2 ; $405a
	snd_channel 5, SNDCHANTYPE_NOISE ; $405c
	dw MusicExhibitionMatch_Trk3 ; $405e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4060
	dw MusicExhibitionMatchLink_Trk0 ; $4062
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4064
	dw MusicExhibitionMatchLink_Trk1 ; $4066
	snd_channel 4, SNDCHANTYPE_WAVE ; $4068
	dw MusicExhibitionMatchLink_Trk2 ; $406a
	snd_channel 5, SNDCHANTYPE_NOISE ; $406c
	dw MusicExhibitionMatchLink_Trk3 ; $406e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4070
	dw MusicLose_Trk0 ; $4072
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4074
	dw MusicLose_Trk1 ; $4076
	snd_channel 4, SNDCHANTYPE_WAVE ; $4078
	dw MusicLose_Trk2 ; $407a
	snd_channel 0, SNDCHANTYPE_NOISE ; $407c
	dw SfxHitTopspin_Trk0 ; $407e
	snd_channel 0, SNDCHANTYPE_NOISE ; $4080
	dw SfxHitDrop_Trk0 ; $4082
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4084
	dw Sfx9a_Trk0 ; $4086
MusicIntro_Trk0:
	INCLUDE "data/audio/MusicIntro_Trk0.asm" ; $4088, 240 bytes (snd_script:pulse)
MusicIntro_Trk1:
	INCLUDE "data/audio/MusicIntro_Trk1.asm" ; $4178, 242 bytes (snd_script:pulse)
MusicIntro_Trk2:
	INCLUDE "data/audio/MusicIntro_Trk2.asm" ; $426a, 356 bytes (snd_script:wave)
MusicIntro_Trk3:
	INCLUDE "data/audio/MusicIntro_Trk3.asm" ; $43ce, 1336 bytes (snd_script:noise)
MusicTitleScreen_Trk0:
	INCLUDE "data/audio/MusicTitleScreen_Trk0.asm" ; $4906, 62 bytes (snd_script:pulse)
MusicTitleScreen_Trk1:
	INCLUDE "data/audio/MusicTitleScreen_Trk1.asm" ; $4944, 78 bytes (snd_script:pulse)
MusicTitleScreen_Trk2:
	INCLUDE "data/audio/MusicTitleScreen_Trk2.asm" ; $4992, 174 bytes (snd_script:wave)
MusicTitleScreen_Trk3:
	INCLUDE "data/audio/MusicTitleScreen_Trk3.asm" ; $4a40, 582 bytes (snd_script:noise)
MusicMenu_Trk0:
	INCLUDE "data/audio/MusicMenu_Trk0.asm" ; $4c86, 486 bytes (snd_script:pulse)
MusicMenu_Trk1:
	INCLUDE "data/audio/MusicMenu_Trk1.asm" ; $4e6c, 448 bytes (snd_script:pulse)
MusicMenu_Trk2:
	INCLUDE "data/audio/MusicMenu_Trk2.asm" ; $502c, 1134 bytes (snd_script:wave)
MusicMenu_Trk3:
	INCLUDE "data/audio/MusicMenu_Trk3.asm" ; $549a, 832 bytes (snd_script:noise)
MusicStatusScreen_Trk0:
	INCLUDE "data/audio/MusicStatusScreen_Trk0.asm" ; $57da, 530 bytes (snd_script:pulse)
MusicStatusScreen_Trk1:
	INCLUDE "data/audio/MusicStatusScreen_Trk1.asm" ; $59ec, 530 bytes (snd_script:pulse)
MusicStatusScreen_Trk2:
	INCLUDE "data/audio/MusicStatusScreen_Trk2.asm" ; $5bfe, 266 bytes (snd_script:wave)
MusicStatusScreen_Trk3:
	INCLUDE "data/audio/MusicStatusScreen_Trk3.asm" ; $5d08, 824 bytes (snd_script:noise)
MusicDictionary_Trk0:
	INCLUDE "data/audio/MusicDictionary_Trk0.asm" ; $6040, 436 bytes (snd_script:pulse)
MusicDictionary_Trk1:
	INCLUDE "data/audio/MusicDictionary_Trk1.asm" ; $61f4, 300 bytes (snd_script:pulse)
MusicDictionary_Trk2:
	INCLUDE "data/audio/MusicDictionary_Trk2.asm" ; $6320, 354 bytes (snd_script:wave)
MusicDictionary_Trk3:
	INCLUDE "data/audio/MusicDictionary_Trk3.asm" ; $6482, 866 bytes (snd_script:noise)
MusicExhibitionMatch_Trk0:
	INCLUDE "data/audio/MusicExhibitionMatch_Trk0.asm" ; $67e4, 624 bytes (snd_script:pulse)
MusicExhibitionMatch_Trk1:
	INCLUDE "data/audio/MusicExhibitionMatch_Trk1.asm" ; $6a54, 578 bytes (snd_script:pulse)
MusicExhibitionMatch_Trk2:
	INCLUDE "data/audio/MusicExhibitionMatch_Trk2.asm" ; $6c96, 1276 bytes (snd_script:wave)
MusicExhibitionMatch_Trk3:
	INCLUDE "data/audio/MusicExhibitionMatch_Trk3.asm" ; $7192, 1284 bytes (snd_script:noise)
MusicExhibitionMatchLink_Trk0:
	INCLUDE "data/audio/MusicExhibitionMatchLink_Trk0.asm" ; $7696, 386 bytes (snd_script:pulse)
MusicExhibitionMatchLink_Trk1:
	INCLUDE "data/audio/MusicExhibitionMatchLink_Trk1.asm" ; $7818, 712 bytes (snd_script:pulse)
MusicExhibitionMatchLink_Trk2:
	INCLUDE "data/audio/MusicExhibitionMatchLink_Trk2.asm" ; $7ae0, 708 bytes (snd_script:wave)
MusicExhibitionMatchLink_Trk3:
	INCLUDE "data/audio/MusicExhibitionMatchLink_Trk3.asm" ; $7da4, 392 bytes (snd_script:noise)
MusicLose_Trk0:
	INCLUDE "data/audio/MusicLose_Trk0.asm" ; $7f2c, 58 bytes (snd_script:pulse)
MusicLose_Trk1:
	INCLUDE "data/audio/MusicLose_Trk1.asm" ; $7f66, 56 bytes (snd_script:pulse)
MusicLose_Trk2:
	INCLUDE "data/audio/MusicLose_Trk2.asm" ; $7f9e, 24 bytes (snd_script:wave)
SfxHitTopspin_Trk0:
	INCLUDE "data/audio/SfxHitTopspin_Trk0.asm" ; $7fb6, 22 bytes (snd_script:noise)
SfxHitDrop_Trk0:
	INCLUDE "data/audio/SfxHitDrop_Trk0.asm" ; $7fcc, 26 bytes (snd_script:noise)
Sfx9a_Trk0:
	INCLUDE "data/audio/Sfx9a_Trk0.asm" ; $7fe6, 10 bytes (snd_script:pulse)
	; $7ff0, 16 bytes fill to bank end (linker-padded)

SoundTable_7c:
	ASSERT SoundTable_7c == $4000
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4000
	dw MusicPracticeMatch_Trk0 ; $4002
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4004
	dw MusicPracticeMatch_Trk1 ; $4006
	snd_channel 4, SNDCHANTYPE_WAVE ; $4008
	dw MusicPracticeMatch_Trk2 ; $400a
	snd_channel 5, SNDCHANTYPE_NOISE ; $400c
	dw MusicPracticeMatch_Trk3 ; $400e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4010
	dw MusicJuniorRanking_Trk0 ; $4012
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4014
	dw MusicJuniorRanking_Trk1 ; $4016
	snd_channel 4, SNDCHANTYPE_WAVE ; $4018
	dw MusicJuniorRanking_Trk2 ; $401a
	snd_channel 5, SNDCHANTYPE_NOISE ; $401c
	dw MusicJuniorRanking_Trk3 ; $401e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4020
	dw MusicSeniorRanking_Trk0 ; $4022
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4024
	dw MusicSeniorRanking_Trk1 ; $4026
	snd_channel 4, SNDCHANTYPE_WAVE ; $4028
	dw MusicSeniorRanking_Trk2 ; $402a
	snd_channel 5, SNDCHANTYPE_NOISE ; $402c
	dw MusicSeniorRanking_Trk3 ; $402e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4030
	dw MusicVarsityRanking_Trk0 ; $4032
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4034
	dw MusicVarsityRanking_Trk1 ; $4036
	snd_channel 4, SNDCHANTYPE_WAVE ; $4038
	dw MusicVarsityRanking_Trk2 ; $403a
	snd_channel 5, SNDCHANTYPE_NOISE ; $403c
	dw MusicVarsityRanking_Trk3 ; $403e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4040
	dw MusicDrillMatch_Trk0 ; $4042
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4044
	dw MusicDrillMatch_Trk1 ; $4046
	snd_channel 4, SNDCHANTYPE_WAVE ; $4048
	dw MusicDrillMatch_Trk2 ; $404a
	snd_channel 5, SNDCHANTYPE_NOISE ; $404c
	dw MusicDrillMatch_Trk3 ; $404e
	snd_channel 0, SNDCHANTYPE_NOISE ; $4050
	dw SfxHitServe_Trk0 ; $4052
	snd_channel 0, SNDCHANTYPE_NOISE ; $4054
	dw SfxSpecialHit_Trk0 ; $4056
	snd_channel 0, SNDCHANTYPE_NOISE ; $4058
	dw Sfx56_Trk0 ; $405a
	snd_channel 0, SNDCHANTYPE_NOISE ; $405c
	dw SfxHitSlice_Trk0 ; $405e
	snd_channel 0, SNDCHANTYPE_NOISE ; $4060
	dw Sfx58_Trk0 ; $4062
	snd_channel 0, SNDCHANTYPE_NOISE ; $4064
	dw SfxSwing_Trk0 ; $4066
	snd_channel 0, SNDCHANTYPE_NOISE ; $4068
	dw SfxBallBounce_Trk0 ; $406a
MusicPracticeMatch_Trk0:
	INCLUDE "data/audio/MusicPracticeMatch_Trk0.asm" ; $406c, 454 bytes (snd_script:pulse)
MusicPracticeMatch_Trk1:
	INCLUDE "data/audio/MusicPracticeMatch_Trk1.asm" ; $4232, 1212 bytes (snd_script:pulse)
MusicPracticeMatch_Trk2:
	INCLUDE "data/audio/MusicPracticeMatch_Trk2.asm" ; $46ee, 1048 bytes (snd_script:wave)
MusicPracticeMatch_Trk3:
	INCLUDE "data/audio/MusicPracticeMatch_Trk3.asm" ; $4b06, 738 bytes (snd_script:noise)
MusicJuniorRanking_Trk0:
	INCLUDE "data/audio/MusicJuniorRanking_Trk0.asm" ; $4de8, 424 bytes (snd_script:pulse)
MusicJuniorRanking_Trk1:
	INCLUDE "data/audio/MusicJuniorRanking_Trk1.asm" ; $4f90, 692 bytes (snd_script:pulse)
MusicJuniorRanking_Trk2:
	INCLUDE "data/audio/MusicJuniorRanking_Trk2.asm" ; $5244, 490 bytes (snd_script:wave)
MusicJuniorRanking_Trk3:
	INCLUDE "data/audio/MusicJuniorRanking_Trk3.asm" ; $542e, 1272 bytes (snd_script:noise)
MusicSeniorRanking_Trk0:
	INCLUDE "data/audio/MusicSeniorRanking_Trk0.asm" ; $5926, 654 bytes (snd_script:pulse)
MusicSeniorRanking_Trk1:
	INCLUDE "data/audio/MusicSeniorRanking_Trk1.asm" ; $5bb4, 652 bytes (snd_script:pulse)
MusicSeniorRanking_Trk2:
	INCLUDE "data/audio/MusicSeniorRanking_Trk2.asm" ; $5e40, 616 bytes (snd_script:wave)
MusicSeniorRanking_Trk3:
	INCLUDE "data/audio/MusicSeniorRanking_Trk3.asm" ; $60a8, 422 bytes (snd_script:noise)
MusicVarsityRanking_Trk0:
	INCLUDE "data/audio/MusicVarsityRanking_Trk0.asm" ; $624e, 498 bytes (snd_script:pulse)
MusicVarsityRanking_Trk1:
	INCLUDE "data/audio/MusicVarsityRanking_Trk1.asm" ; $6440, 502 bytes (snd_script:pulse)
MusicVarsityRanking_Trk2:
	INCLUDE "data/audio/MusicVarsityRanking_Trk2.asm" ; $6636, 534 bytes (snd_script:wave)
MusicVarsityRanking_Trk3:
	INCLUDE "data/audio/MusicVarsityRanking_Trk3.asm" ; $684c, 1274 bytes (snd_script:noise)
MusicDrillMatch_Trk0:
	INCLUDE "data/audio/MusicDrillMatch_Trk0.asm" ; $6d46, 566 bytes (snd_script:pulse)
MusicDrillMatch_Trk1:
	INCLUDE "data/audio/MusicDrillMatch_Trk1.asm" ; $6f7c, 570 bytes (snd_script:pulse)
MusicDrillMatch_Trk2:
	INCLUDE "data/audio/MusicDrillMatch_Trk2.asm" ; $71b6, 1682 bytes (snd_script:wave)
MusicDrillMatch_Trk3:
	INCLUDE "data/audio/MusicDrillMatch_Trk3.asm" ; $7848, 1648 bytes (snd_script:noise)
SfxHitServe_Trk0:
	INCLUDE "data/audio/SfxHitServe_Trk0.asm" ; $7eb8, 42 bytes (snd_script:noise)
SfxSpecialHit_Trk0:
	INCLUDE "data/audio/SfxSpecialHit_Trk0.asm" ; $7ee2, 54 bytes (snd_script:noise)
Sfx56_Trk0:
	INCLUDE "data/audio/Sfx56_Trk0.asm" ; $7f18, 40 bytes (snd_script:noise)
SfxHitSlice_Trk0:
	INCLUDE "data/audio/SfxHitSlice_Trk0.asm" ; $7f40, 56 bytes (snd_script:noise)
Sfx58_Trk0:
	INCLUDE "data/audio/Sfx58_Trk0.asm" ; $7f78, 40 bytes (snd_script:noise)
SfxSwing_Trk0:
	INCLUDE "data/audio/SfxSwing_Trk0.asm" ; $7fa0, 48 bytes (snd_script:noise)
SfxBallBounce_Trk0:
	INCLUDE "data/audio/SfxBallBounce_Trk0.asm" ; $7fd0, 22 bytes (snd_script:noise)
	; $7fe6, 26 bytes fill to bank end (linker-padded)

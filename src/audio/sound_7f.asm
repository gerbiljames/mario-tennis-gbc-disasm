SoundTable_7f:
	ASSERT SoundTable_7f == $4000
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4000
	dw SfxAppear2_Trk0 ; $4002
	snd_channel 1, SNDCHANTYPE_WAVE ; $4004
	dw SfxAppear2_Trk1 ; $4006
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4008
	dw SfxChime_Trk0 ; $400a
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $400c
	dw SfxEmote_Trk0 ; $400e
	snd_channel 0, SNDCHANTYPE_NOISE ; $4010
	dw SfxAppear1_Trk0 ; $4012
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4014
	dw Sfx9d_Trk0 ; $4016
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4018
	dw Sfx9e_Trk0 ; $401a
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $401c
	dw Sfx9f_Trk0 ; $401e
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4020
	dw Sfxa0_Trk0 ; $4022
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4024
	dw Sfxa1_Trk0 ; $4026
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4028
	dw SfxStoryCue_Trk0 ; $402a
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $402c
	dw Sfxa3_Trk0 ; $402e
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4030
	dw Sfxa4_Trk0 ; $4032
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4034
	dw Sfxa5_Trk0 ; $4036
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4038
	dw Sfxa6_Trk0 ; $403a
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $403c
	dw Sfxa7_Trk0 ; $403e
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4040
	dw Sfxa8_Trk0 ; $4042
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4044
	dw Sfxa9_Trk0 ; $4046
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4048
	dw Sfxaa_Trk0 ; $404a
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $404c
	dw Sfxab_Trk0 ; $404e
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4050
	dw Sfxac_Trk0 ; $4052
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4054
	dw Sfxad_Trk0 ; $4056
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4058
	dw Sfxae_Trk0 ; $405a
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $405c
	dw SfxTimerTick_Trk0 ; $405e
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4060
	dw SfxTimerUp_Trk0 ; $4062
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4064
	dw Sfxb1_Trk0 ; $4066
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4068
	dw Sfxb2_Trk0 ; $406a
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $406c
	dw Sfxb3_Trk0 ; $406e
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4070
	dw Sfxb4_Trk0 ; $4072
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4074
	dw Sfxb5_Trk0 ; $4076
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4078
	dw Sfxb6_Trk0 ; $407a
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $407c
	dw Sfxb7_Trk0 ; $407e
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4080
	dw Sfxb8_Trk0 ; $4082
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $4084
	dw Sfxb9_Trk0 ; $4086
	snd_channel 1, SNDCHANTYPE_SQUARE1 ; $4088
	dw SfxScoreStep7_Trk0 ; $408a
	snd_channel 1, SNDCHANTYPE_SQUARE1 ; $408c
	dw SfxScoreStep6_Trk0 ; $408e
	snd_channel 1, SNDCHANTYPE_SQUARE1 ; $4090
	dw SfxScoreStep5_Trk0 ; $4092
	snd_channel 1, SNDCHANTYPE_SQUARE1 ; $4094
	dw SfxScoreStep4_Trk0 ; $4096
	snd_channel 1, SNDCHANTYPE_SQUARE1 ; $4098
	dw SfxScoreStep3_Trk0 ; $409a
	snd_channel 1, SNDCHANTYPE_SQUARE1 ; $409c
	dw SfxScoreStep2_Trk0 ; $409e
	snd_channel 1, SNDCHANTYPE_SQUARE1 ; $40a0
	dw SfxScoreStep1_Trk0 ; $40a2
	snd_channel 0, SNDCHANTYPE_SQUARE1 ; $40a4
	dw Sfxc1_Trk0 ; $40a6
SfxAppear2_Trk0:
	INCLUDE "data/audio/SfxAppear2_Trk0.asm" ; $40a8, 36 bytes (snd_script:pulse)
SfxAppear2_Trk1:
	INCLUDE "data/audio/SfxAppear2_Trk1.asm" ; $40cc, 44 bytes (snd_script:wave)
SfxChime_Trk0:
	INCLUDE "data/audio/SfxChime_Trk0.asm" ; $40f8, 72 bytes (snd_script:pulse)
SfxEmote_Trk0:
	INCLUDE "data/audio/SfxEmote_Trk0.asm" ; $4140, 72 bytes (snd_script:pulse)
SfxAppear1_Trk0:
	INCLUDE "data/audio/SfxAppear1_Trk0.asm" ; $4188, 26 bytes (snd_script:noise)
Sfx9d_Trk0:
	INCLUDE "data/audio/Sfx9d_Trk0.asm" ; $41a2, 12 bytes (snd_script:pulse)
Sfx9e_Trk0:
	INCLUDE "data/audio/Sfx9e_Trk0.asm" ; $41ae, 12 bytes (snd_script:pulse)
Sfx9f_Trk0:
	INCLUDE "data/audio/Sfx9f_Trk0.asm" ; $41ba, 12 bytes (snd_script:pulse)
Sfxa0_Trk0:
	INCLUDE "data/audio/Sfxa0_Trk0.asm" ; $41c6, 12 bytes (snd_script:pulse)
Sfxa1_Trk0:
	INCLUDE "data/audio/Sfxa1_Trk0.asm" ; $41d2, 12 bytes (snd_script:pulse)
SfxStoryCue_Trk0:
	INCLUDE "data/audio/SfxStoryCue_Trk0.asm" ; $41de, 12 bytes (snd_script:pulse)
Sfxa3_Trk0:
	INCLUDE "data/audio/Sfxa3_Trk0.asm" ; $41ea, 12 bytes (snd_script:pulse)
Sfxa4_Trk0:
	INCLUDE "data/audio/Sfxa4_Trk0.asm" ; $41f6, 12 bytes (snd_script:pulse)
Sfxa5_Trk0:
	INCLUDE "data/audio/Sfxa5_Trk0.asm" ; $4202, 12 bytes (snd_script:pulse)
Sfxa6_Trk0:
	INCLUDE "data/audio/Sfxa6_Trk0.asm" ; $420e, 12 bytes (snd_script:pulse)
Sfxa7_Trk0:
	INCLUDE "data/audio/Sfxa7_Trk0.asm" ; $421a, 12 bytes (snd_script:pulse)
Sfxa8_Trk0:
	INCLUDE "data/audio/Sfxa8_Trk0.asm" ; $4226, 12 bytes (snd_script:pulse)
Sfxa9_Trk0:
	INCLUDE "data/audio/Sfxa9_Trk0.asm" ; $4232, 12 bytes (snd_script:pulse)
Sfxaa_Trk0:
	INCLUDE "data/audio/Sfxaa_Trk0.asm" ; $423e, 12 bytes (snd_script:pulse)
Sfxab_Trk0:
	INCLUDE "data/audio/Sfxab_Trk0.asm" ; $424a, 12 bytes (snd_script:pulse)
Sfxac_Trk0:
	INCLUDE "data/audio/Sfxac_Trk0.asm" ; $4256, 12 bytes (snd_script:pulse)
Sfxad_Trk0:
	INCLUDE "data/audio/Sfxad_Trk0.asm" ; $4262, 12 bytes (snd_script:pulse)
Sfxae_Trk0:
	INCLUDE "data/audio/Sfxae_Trk0.asm" ; $426e, 12 bytes (snd_script:pulse)
SfxTimerTick_Trk0:
	INCLUDE "data/audio/SfxTimerTick_Trk0.asm" ; $427a, 12 bytes (snd_script:pulse)
SfxTimerUp_Trk0:
	INCLUDE "data/audio/SfxTimerUp_Trk0.asm" ; $4286, 12 bytes (snd_script:pulse)
Sfxb1_Trk0:
	INCLUDE "data/audio/Sfxb1_Trk0.asm" ; $4292, 12 bytes (snd_script:pulse)
Sfxb2_Trk0:
	INCLUDE "data/audio/Sfxb2_Trk0.asm" ; $429e, 12 bytes (snd_script:pulse)
Sfxb3_Trk0:
	INCLUDE "data/audio/Sfxb3_Trk0.asm" ; $42aa, 12 bytes (snd_script:pulse)
Sfxb4_Trk0:
	INCLUDE "data/audio/Sfxb4_Trk0.asm" ; $42b6, 12 bytes (snd_script:pulse)
Sfxb5_Trk0:
	INCLUDE "data/audio/Sfxb5_Trk0.asm" ; $42c2, 12 bytes (snd_script:pulse)
Sfxb6_Trk0:
	INCLUDE "data/audio/Sfxb6_Trk0.asm" ; $42ce, 12 bytes (snd_script:pulse)
Sfxb7_Trk0:
	INCLUDE "data/audio/Sfxb7_Trk0.asm" ; $42da, 12 bytes (snd_script:pulse)
Sfxb8_Trk0:
	INCLUDE "data/audio/Sfxb8_Trk0.asm" ; $42e6, 12 bytes (snd_script:pulse)
Sfxb9_Trk0:
	INCLUDE "data/audio/Sfxb9_Trk0.asm" ; $42f2, 12 bytes (snd_script:pulse)
SfxScoreStep7_Trk0:
	INCLUDE "data/audio/SfxScoreStep7_Trk0.asm" ; $42fe, 72 bytes (snd_script:pulse)
SfxScoreStep6_Trk0:
	INCLUDE "data/audio/SfxScoreStep6_Trk0.asm" ; $4346, 72 bytes (snd_script:pulse)
SfxScoreStep5_Trk0:
	INCLUDE "data/audio/SfxScoreStep5_Trk0.asm" ; $438e, 72 bytes (snd_script:pulse)
SfxScoreStep4_Trk0:
	INCLUDE "data/audio/SfxScoreStep4_Trk0.asm" ; $43d6, 72 bytes (snd_script:pulse)
SfxScoreStep3_Trk0:
	INCLUDE "data/audio/SfxScoreStep3_Trk0.asm" ; $441e, 72 bytes (snd_script:pulse)
SfxScoreStep2_Trk0:
	INCLUDE "data/audio/SfxScoreStep2_Trk0.asm" ; $4466, 72 bytes (snd_script:pulse)
SfxScoreStep1_Trk0:
	INCLUDE "data/audio/SfxScoreStep1_Trk0.asm" ; $44ae, 72 bytes (snd_script:pulse)
Sfxc1_Trk0:
	INCLUDE "data/audio/Sfxc1_Trk0.asm" ; $44f6, 12 bytes (snd_script:pulse)
	; $4502, 15102 bytes fill to bank end (linker-padded)

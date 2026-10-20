SoundTable_79:
	ASSERT SoundTable_79 == $4000
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4000
	dw MusicMarioMinigame_Trk0 ; $4002
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4004
	dw MusicMarioMinigame_Trk1 ; $4006
	snd_channel 4, SNDCHANTYPE_WAVE ; $4008
	dw MusicMarioMinigame_Trk2 ; $400a
	snd_channel 5, SNDCHANTYPE_NOISE ; $400c
	dw MusicMarioMinigame_Trk3 ; $400e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4010
	dw MusicWin_Trk0 ; $4012
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4014
	dw MusicWin_Trk1 ; $4016
	snd_channel 4, SNDCHANTYPE_WAVE ; $4018
	dw MusicWin_Trk2 ; $401a
	snd_channel 5, SNDCHANTYPE_NOISE ; $401c
	dw MusicWin_Trk3 ; $401e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4020
	dw MusicExpAward_Trk0 ; $4022
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4024
	dw MusicExpAward_Trk1 ; $4026
	snd_channel 4, SNDCHANTYPE_WAVE ; $4028
	dw MusicExpAward_Trk2 ; $402a
	snd_channel 5, SNDCHANTYPE_NOISE ; $402c
	dw MusicExpAward_Trk3 ; $402e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4030
	dw MusicExpDistribution_Trk0 ; $4032
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4034
	dw MusicExpDistribution_Trk1 ; $4036
	snd_channel 4, SNDCHANTYPE_WAVE ; $4038
	dw MusicExpDistribution_Trk2 ; $403a
	snd_channel 5, SNDCHANTYPE_NOISE ; $403c
	dw MusicExpDistribution_Trk3 ; $403e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4040
	dw MusicStatDistribution_Trk0 ; $4042
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4044
	dw MusicStatDistribution_Trk1 ; $4046
	snd_channel 4, SNDCHANTYPE_WAVE ; $4048
	dw MusicStatDistribution_Trk2 ; $404a
	snd_channel 5, SNDCHANTYPE_NOISE ; $404c
	dw MusicStatDistribution_Trk3 ; $404e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4050
	dw MusicTiebreak_Trk0 ; $4052
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4054
	dw MusicTiebreak_Trk1 ; $4056
	snd_channel 4, SNDCHANTYPE_WAVE ; $4058
	dw MusicTiebreak_Trk2 ; $405a
	snd_channel 5, SNDCHANTYPE_NOISE ; $405c
	dw MusicTiebreak_Trk3 ; $405e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4060
	dw MusicSetPoint_Trk0 ; $4062
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4064
	dw MusicSetPoint_Trk1 ; $4066
	snd_channel 4, SNDCHANTYPE_WAVE ; $4068
	dw MusicSetPoint_Trk2 ; $406a
	snd_channel 5, SNDCHANTYPE_NOISE ; $406c
	dw MusicSetPoint_Trk3 ; $406e
	snd_channel 2, SNDCHANTYPE_SQUARE2 ; $4070
	dw MusicTheEnd_Trk0 ; $4072
	snd_channel 3, SNDCHANTYPE_SQUARE1 ; $4074
	dw MusicTheEnd_Trk1 ; $4076
	snd_channel 4, SNDCHANTYPE_WAVE ; $4078
	dw MusicTheEnd_Trk2 ; $407a
	snd_channel 5, SNDCHANTYPE_NOISE ; $407c
	dw MusicTheEnd_Trk3 ; $407e
	snd_channel 0, SNDCHANTYPE_NOISE ; $4080
	dw SfxHitLob_Trk0 ; $4082
MusicMarioMinigame_Trk0:
	INCLUDE "data/audio/MusicMarioMinigame_Trk0.asm" ; $4084, 794 bytes (snd_script:pulse)
MusicMarioMinigame_Trk1:
	INCLUDE "data/audio/MusicMarioMinigame_Trk1.asm" ; $439e, 802 bytes (snd_script:pulse)
MusicMarioMinigame_Trk2:
	INCLUDE "data/audio/MusicMarioMinigame_Trk2.asm" ; $46c0, 414 bytes (snd_script:wave)
MusicMarioMinigame_Trk3:
	INCLUDE "data/audio/MusicMarioMinigame_Trk3.asm" ; $485e, 1590 bytes (snd_script:noise)
MusicWin_Trk0:
	INCLUDE "data/audio/MusicWin_Trk0.asm" ; $4e94, 154 bytes (snd_script:pulse)
MusicWin_Trk1:
	INCLUDE "data/audio/MusicWin_Trk1.asm" ; $4f2e, 154 bytes (snd_script:pulse)
MusicWin_Trk2:
	INCLUDE "data/audio/MusicWin_Trk2.asm" ; $4fc8, 142 bytes (snd_script:wave)
MusicWin_Trk3:
	INCLUDE "data/audio/MusicWin_Trk3.asm" ; $5056, 804 bytes (snd_script:noise)
MusicExpAward_Trk0:
	INCLUDE "data/audio/MusicExpAward_Trk0.asm" ; $537a, 210 bytes (snd_script:pulse)
MusicExpAward_Trk1:
	INCLUDE "data/audio/MusicExpAward_Trk1.asm" ; $544c, 210 bytes (snd_script:pulse)
MusicExpAward_Trk2:
	INCLUDE "data/audio/MusicExpAward_Trk2.asm" ; $551e, 224 bytes (snd_script:wave)
MusicExpAward_Trk3:
	INCLUDE "data/audio/MusicExpAward_Trk3.asm" ; $55fe, 834 bytes (snd_script:noise)
MusicExpDistribution_Trk0:
	INCLUDE "data/audio/MusicExpDistribution_Trk0.asm" ; $5940, 120 bytes (snd_script:pulse)
MusicExpDistribution_Trk1:
	INCLUDE "data/audio/MusicExpDistribution_Trk1.asm" ; $59b8, 122 bytes (snd_script:pulse)
MusicExpDistribution_Trk2:
	INCLUDE "data/audio/MusicExpDistribution_Trk2.asm" ; $5a32, 300 bytes (snd_script:wave)
MusicExpDistribution_Trk3:
	INCLUDE "data/audio/MusicExpDistribution_Trk3.asm" ; $5b5e, 878 bytes (snd_script:noise)
MusicStatDistribution_Trk0:
	INCLUDE "data/audio/MusicStatDistribution_Trk0.asm" ; $5ecc, 168 bytes (snd_script:pulse)
MusicStatDistribution_Trk1:
	INCLUDE "data/audio/MusicStatDistribution_Trk1.asm" ; $5f74, 406 bytes (snd_script:pulse)
MusicStatDistribution_Trk2:
	INCLUDE "data/audio/MusicStatDistribution_Trk2.asm" ; $610a, 204 bytes (snd_script:wave)
MusicStatDistribution_Trk3:
	INCLUDE "data/audio/MusicStatDistribution_Trk3.asm" ; $61d6, 950 bytes (snd_script:noise)
MusicTiebreak_Trk0:
	INCLUDE "data/audio/MusicTiebreak_Trk0.asm" ; $658c, 522 bytes (snd_script:pulse)
MusicTiebreak_Trk1:
	INCLUDE "data/audio/MusicTiebreak_Trk1.asm" ; $6796, 526 bytes (snd_script:pulse)
MusicTiebreak_Trk2:
	INCLUDE "data/audio/MusicTiebreak_Trk2.asm" ; $69a4, 1684 bytes (snd_script:wave)
MusicTiebreak_Trk3:
	INCLUDE "data/audio/MusicTiebreak_Trk3.asm" ; $7038, 408 bytes (snd_script:noise)
MusicSetPoint_Trk0:
	INCLUDE "data/audio/MusicSetPoint_Trk0.asm" ; $71d0, 524 bytes (snd_script:pulse)
MusicSetPoint_Trk1:
	INCLUDE "data/audio/MusicSetPoint_Trk1.asm" ; $73dc, 214 bytes (snd_script:pulse)
MusicSetPoint_Trk2:
	INCLUDE "data/audio/MusicSetPoint_Trk2.asm" ; $74b2, 868 bytes (snd_script:wave)
MusicSetPoint_Trk3:
	INCLUDE "data/audio/MusicSetPoint_Trk3.asm" ; $7816, 1654 bytes (snd_script:noise)
MusicTheEnd_Trk0:
	INCLUDE "data/audio/MusicTheEnd_Trk0.asm" ; $7e8c, 108 bytes (snd_script:pulse)
MusicTheEnd_Trk1:
	INCLUDE "data/audio/MusicTheEnd_Trk1.asm" ; $7ef8, 98 bytes (snd_script:pulse)
MusicTheEnd_Trk2:
	INCLUDE "data/audio/MusicTheEnd_Trk2.asm" ; $7f5a, 34 bytes (snd_script:wave)
MusicTheEnd_Trk3:
	INCLUDE "data/audio/MusicTheEnd_Trk3.asm" ; $7f7c, 74 bytes (snd_script:noise)
SfxHitLob_Trk0:
	INCLUDE "data/audio/SfxHitLob_Trk0.asm" ; $7fc6, 44 bytes (snd_script:noise)
	; $7ff2, 14 bytes fill to bank end (linker-padded)

SECTION "ROM Bank $79", ROMX[$4000], BANK[$79]

SoundTable_79:
	snd_channel 2, $01 ; $4000
	dw Sfx08_Trk0 ; $4002
	snd_channel 3, $00 ; $4004
	dw Sfx08_Trk1 ; $4006
	snd_channel 4, $02 ; $4008
	dw Sfx08_Trk2 ; $400a
	snd_channel 5, $03 ; $400c
	dw Sfx08_Trk3 ; $400e
	snd_channel 2, $01 ; $4010
	dw Sfx09_Trk0 ; $4012
	snd_channel 3, $00 ; $4014
	dw Sfx09_Trk1 ; $4016
	snd_channel 4, $02 ; $4018
	dw Sfx09_Trk2 ; $401a
	snd_channel 5, $03 ; $401c
	dw Sfx09_Trk3 ; $401e
	snd_channel 2, $01 ; $4020
	dw Sfx0b_Trk0 ; $4022
	snd_channel 3, $00 ; $4024
	dw Sfx0b_Trk1 ; $4026
	snd_channel 4, $02 ; $4028
	dw Sfx0b_Trk2 ; $402a
	snd_channel 5, $03 ; $402c
	dw Sfx0b_Trk3 ; $402e
	snd_channel 2, $01 ; $4030
	dw Sfx0c_Trk0 ; $4032
	snd_channel 3, $00 ; $4034
	dw Sfx0c_Trk1 ; $4036
	snd_channel 4, $02 ; $4038
	dw Sfx0c_Trk2 ; $403a
	snd_channel 5, $03 ; $403c
	dw Sfx0c_Trk3 ; $403e
	snd_channel 2, $01 ; $4040
	dw Sfx0d_Trk0 ; $4042
	snd_channel 3, $00 ; $4044
	dw Sfx0d_Trk1 ; $4046
	snd_channel 4, $02 ; $4048
	dw Sfx0d_Trk2 ; $404a
	snd_channel 5, $03 ; $404c
	dw Sfx0d_Trk3 ; $404e
	snd_channel 2, $01 ; $4050
	dw Sfx0e_Trk0 ; $4052
	snd_channel 3, $00 ; $4054
	dw Sfx0e_Trk1 ; $4056
	snd_channel 4, $02 ; $4058
	dw Sfx0e_Trk2 ; $405a
	snd_channel 5, $03 ; $405c
	dw Sfx0e_Trk3 ; $405e
	snd_channel 2, $01 ; $4060
	dw Sfx0f_Trk0 ; $4062
	snd_channel 3, $00 ; $4064
	dw Sfx0f_Trk1 ; $4066
	snd_channel 4, $02 ; $4068
	dw Sfx0f_Trk2 ; $406a
	snd_channel 5, $03 ; $406c
	dw Sfx0f_Trk3 ; $406e
	snd_channel 2, $01 ; $4070
	dw Sfx2d_Trk0 ; $4072
	snd_channel 3, $00 ; $4074
	dw Sfx2d_Trk1 ; $4076
	snd_channel 4, $02 ; $4078
	dw Sfx2d_Trk2 ; $407a
	snd_channel 5, $03 ; $407c
	dw Sfx2d_Trk3 ; $407e
	snd_channel 0, $03 ; $4080
	dw Music53_Trk0 ; $4082
Sfx08_Trk0:
	INCBIN "data/bank_079/d_4084.bin" ; $4084, 794 bytes
Sfx08_Trk1:
	INCBIN "data/bank_079/d_439e.bin" ; $439e, 802 bytes
Sfx08_Trk2:
	INCBIN "data/bank_079/d_46c0.bin" ; $46c0, 414 bytes
Sfx08_Trk3:
	INCBIN "data/bank_079/d_485e.bin" ; $485e, 1590 bytes
Sfx09_Trk0:
	INCBIN "data/bank_079/d_4e94.bin" ; $4e94, 154 bytes
Sfx09_Trk1:
	INCBIN "data/bank_079/d_4f2e.bin" ; $4f2e, 154 bytes
Sfx09_Trk2:
	INCBIN "data/bank_079/d_4fc8.bin" ; $4fc8, 142 bytes
Sfx09_Trk3:
	INCBIN "data/bank_079/d_5056.bin" ; $5056, 804 bytes
Sfx0b_Trk0:
	INCBIN "data/bank_079/d_537a.bin" ; $537a, 210 bytes
Sfx0b_Trk1:
	INCBIN "data/bank_079/d_544c.bin" ; $544c, 210 bytes
Sfx0b_Trk2:
	INCBIN "data/bank_079/d_551e.bin" ; $551e, 224 bytes
Sfx0b_Trk3:
	INCBIN "data/bank_079/d_55fe.bin" ; $55fe, 834 bytes
Sfx0c_Trk0:
	INCBIN "data/bank_079/d_5940.bin" ; $5940, 120 bytes
Sfx0c_Trk1:
	INCBIN "data/bank_079/d_59b8.bin" ; $59b8, 122 bytes
Sfx0c_Trk2:
	INCBIN "data/bank_079/d_5a32.bin" ; $5a32, 300 bytes
Sfx0c_Trk3:
	INCBIN "data/bank_079/d_5b5e.bin" ; $5b5e, 878 bytes
Sfx0d_Trk0:
	INCBIN "data/bank_079/d_5ecc.bin" ; $5ecc, 168 bytes
Sfx0d_Trk1:
	INCBIN "data/bank_079/d_5f74.bin" ; $5f74, 406 bytes
Sfx0d_Trk2:
	INCBIN "data/bank_079/d_610a.bin" ; $610a, 204 bytes
Sfx0d_Trk3:
	INCBIN "data/bank_079/d_61d6.bin" ; $61d6, 950 bytes
Sfx0e_Trk0:
	INCBIN "data/bank_079/d_658c.bin" ; $658c, 522 bytes
Sfx0e_Trk1:
	INCBIN "data/bank_079/d_6796.bin" ; $6796, 526 bytes
Sfx0e_Trk2:
	INCBIN "data/bank_079/d_69a4.bin" ; $69a4, 1684 bytes
Sfx0e_Trk3:
	INCBIN "data/bank_079/d_7038.bin" ; $7038, 408 bytes
Sfx0f_Trk0:
	INCBIN "data/bank_079/d_71d0.bin" ; $71d0, 524 bytes
Sfx0f_Trk1:
	INCBIN "data/bank_079/d_73dc.bin" ; $73dc, 214 bytes
Sfx0f_Trk2:
	INCBIN "data/bank_079/d_74b2.bin" ; $74b2, 868 bytes
Sfx0f_Trk3:
	INCBIN "data/bank_079/d_7816.bin" ; $7816, 1654 bytes
Sfx2d_Trk0:
	INCBIN "data/bank_079/d_7e8c.bin" ; $7e8c, 108 bytes
Sfx2d_Trk1:
	INCBIN "data/bank_079/d_7ef8.bin" ; $7ef8, 98 bytes
Sfx2d_Trk2:
	INCBIN "data/bank_079/d_7f5a.bin" ; $7f5a, 34 bytes
Sfx2d_Trk3:
	INCBIN "data/bank_079/d_7f7c.bin" ; $7f7c, 74 bytes
Music53_Trk0:
	INCBIN "data/bank_079/d_7fc6.bin" ; $7fc6, 44 bytes
	; $7ff2, 14 bytes fill to bank end (linker-padded)

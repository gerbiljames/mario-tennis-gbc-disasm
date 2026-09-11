SoundTable_7a:
	snd_channel 2, $01 ; $4000
	dw Sfx10_Trk0 ; $4002
	snd_channel 3, $00 ; $4004
	dw Sfx10_Trk1 ; $4006
	snd_channel 4, $02 ; $4008
	dw Sfx10_Trk2 ; $400a
	snd_channel 5, $03 ; $400c
	dw Sfx10_Trk3 ; $400e
	snd_channel 2, $01 ; $4010
	dw Sfx11_Trk0 ; $4012
	snd_channel 3, $00 ; $4014
	dw Sfx11_Trk1 ; $4016
	snd_channel 4, $02 ; $4018
	dw Sfx11_Trk2 ; $401a
	snd_channel 5, $03 ; $401c
	dw Sfx11_Trk3 ; $401e
	snd_channel 2, $01 ; $4020
	dw Sfx12_Trk0 ; $4022
	snd_channel 3, $00 ; $4024
	dw Sfx12_Trk1 ; $4026
	snd_channel 4, $02 ; $4028
	dw Sfx12_Trk2 ; $402a
	snd_channel 5, $03 ; $402c
	dw Sfx12_Trk3 ; $402e
	snd_channel 2, $01 ; $4030
	dw Sfx13_Trk0 ; $4032
	snd_channel 3, $00 ; $4034
	dw Sfx13_Trk1 ; $4036
	snd_channel 4, $02 ; $4038
	dw Sfx13_Trk2 ; $403a
	snd_channel 5, $03 ; $403c
	dw Sfx13_Trk3 ; $403e
	snd_channel 2, $01 ; $4040
	dw Sfx14_Trk0 ; $4042
	snd_channel 3, $00 ; $4044
	dw Sfx14_Trk1 ; $4046
	snd_channel 4, $02 ; $4048
	dw Sfx14_Trk2 ; $404a
	snd_channel 5, $03 ; $404c
	dw Sfx14_Trk3 ; $404e
	snd_channel 2, $01 ; $4050
	dw Sfx15_Trk0 ; $4052
	snd_channel 3, $00 ; $4054
	dw Sfx15_Trk1 ; $4056
	snd_channel 4, $02 ; $4058
	dw Sfx15_Trk2 ; $405a
	snd_channel 5, $03 ; $405c
	dw Sfx15_Trk3 ; $405e
	snd_channel 2, $01 ; $4060
	dw Sfx2e_Trk0 ; $4062
	snd_channel 3, $00 ; $4064
	dw Sfx2e_Trk1 ; $4066
	snd_channel 4, $02 ; $4068
	dw Sfx2e_Trk2 ; $406a
Sfx10_Trk0:
	INCBIN "data/bank_07a/Sfx10_Trk0.bin" ; $406c, 850 bytes
Sfx10_Trk1:
	INCBIN "data/bank_07a/Sfx10_Trk1.bin" ; $43be, 628 bytes
Sfx10_Trk2:
	INCBIN "data/bank_07a/Sfx10_Trk2.bin" ; $4632, 1622 bytes
Sfx10_Trk3:
	INCBIN "data/bank_07a/Sfx10_Trk3.bin" ; $4c88, 780 bytes
Sfx11_Trk0:
	INCBIN "data/bank_07a/Sfx11_Trk0.bin" ; $4f94, 720 bytes
Sfx11_Trk1:
	INCBIN "data/bank_07a/Sfx11_Trk1.bin" ; $5264, 756 bytes
Sfx11_Trk2:
	INCBIN "data/bank_07a/Sfx11_Trk2.bin" ; $5558, 610 bytes
Sfx11_Trk3:
	INCBIN "data/bank_07a/Sfx11_Trk3.bin" ; $57ba, 752 bytes
Sfx12_Trk0:
	INCBIN "data/bank_07a/Sfx12_Trk0.bin" ; $5aaa, 1454 bytes
Sfx12_Trk1:
	INCBIN "data/bank_07a/Sfx12_Trk1.bin" ; $6058, 1246 bytes
Sfx12_Trk2:
	INCBIN "data/bank_07a/Sfx12_Trk2.bin" ; $6536, 320 bytes
Sfx12_Trk3:
	INCBIN "data/bank_07a/Sfx12_Trk3.bin" ; $6676, 672 bytes
Sfx13_Trk0:
	INCBIN "data/bank_07a/Sfx13_Trk0.bin" ; $6916, 520 bytes
Sfx13_Trk1:
	INCBIN "data/bank_07a/Sfx13_Trk1.bin" ; $6b1e, 610 bytes
Sfx13_Trk2:
	INCBIN "data/bank_07a/Sfx13_Trk2.bin" ; $6d80, 680 bytes
Sfx13_Trk3:
	INCBIN "data/bank_07a/Sfx13_Trk3.bin" ; $7028, 624 bytes
Sfx14_Trk0:
	INCBIN "data/bank_07a/Sfx14_Trk0.bin" ; $7298, 364 bytes
Sfx14_Trk1:
	INCBIN "data/bank_07a/Sfx14_Trk1.bin" ; $7404, 318 bytes
Sfx14_Trk2:
	INCBIN "data/bank_07a/Sfx14_Trk2.bin" ; $7542, 370 bytes
Sfx14_Trk3:
	INCBIN "data/bank_07a/Sfx14_Trk3.bin" ; $76b4, 678 bytes
Sfx15_Trk0:
	INCBIN "data/bank_07a/Sfx15_Trk0.bin" ; $795a, 406 bytes
Sfx15_Trk1:
	INCBIN "data/bank_07a/Sfx15_Trk1.bin" ; $7af0, 382 bytes
Sfx15_Trk2:
	INCBIN "data/bank_07a/Sfx15_Trk2.bin" ; $7c6e, 294 bytes
Sfx15_Trk3:
	INCBIN "data/bank_07a/Sfx15_Trk3.bin" ; $7d94, 364 bytes
Sfx2e_Trk0:
	INCBIN "data/bank_07a/Sfx2e_Trk0.bin" ; $7f00, 94 bytes
Sfx2e_Trk1:
	INCBIN "data/bank_07a/Sfx2e_Trk1.bin" ; $7f5e, 76 bytes
Sfx2e_Trk2:
	INCBIN "data/bank_07a/Sfx2e_Trk2.bin" ; $7faa, 70 bytes
	; $7ff0, 16 bytes fill to bank end (linker-padded)

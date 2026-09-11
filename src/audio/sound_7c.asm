SoundTable_7c:
	snd_channel 2, $01 ; $4000
	dw Sfx20_Trk0 ; $4002
	snd_channel 3, $00 ; $4004
	dw Sfx20_Trk1 ; $4006
	snd_channel 4, $02 ; $4008
	dw Sfx20_Trk2 ; $400a
	snd_channel 5, $03 ; $400c
	dw Sfx20_Trk3 ; $400e
	snd_channel 2, $01 ; $4010
	dw Sfx21_Trk0 ; $4012
	snd_channel 3, $00 ; $4014
	dw Sfx21_Trk1 ; $4016
	snd_channel 4, $02 ; $4018
	dw Sfx21_Trk2 ; $401a
	snd_channel 5, $03 ; $401c
	dw Sfx21_Trk3 ; $401e
	snd_channel 2, $01 ; $4020
	dw Sfx22_Trk0 ; $4022
	snd_channel 3, $00 ; $4024
	dw Sfx22_Trk1 ; $4026
	snd_channel 4, $02 ; $4028
	dw Sfx22_Trk2 ; $402a
	snd_channel 5, $03 ; $402c
	dw Sfx22_Trk3 ; $402e
	snd_channel 2, $01 ; $4030
	dw Sfx23_Trk0 ; $4032
	snd_channel 3, $00 ; $4034
	dw Sfx23_Trk1 ; $4036
	snd_channel 4, $02 ; $4038
	dw Sfx23_Trk2 ; $403a
	snd_channel 5, $03 ; $403c
	dw Sfx23_Trk3 ; $403e
	snd_channel 2, $01 ; $4040
	dw Sfx24_Trk0 ; $4042
	snd_channel 3, $00 ; $4044
	dw Sfx24_Trk1 ; $4046
	snd_channel 4, $02 ; $4048
	dw Sfx24_Trk2 ; $404a
	snd_channel 5, $03 ; $404c
	dw Sfx24_Trk3 ; $404e
	snd_channel 0, $03 ; $4050
	dw Music54_Trk0 ; $4052
	snd_channel 0, $03 ; $4054
	dw Music55_Trk0 ; $4056
	snd_channel 0, $03 ; $4058
	dw Music56_Trk0 ; $405a
	snd_channel 0, $03 ; $405c
	dw Music57_Trk0 ; $405e
	snd_channel 0, $03 ; $4060
	dw Music58_Trk0 ; $4062
	snd_channel 0, $03 ; $4064
	dw Music59_Trk0 ; $4066
	snd_channel 0, $03 ; $4068
	dw Music5b_Trk0 ; $406a
Sfx20_Trk0:
	INCBIN "data/bank_07c/Sfx20_Trk0.bin" ; $406c, 454 bytes
Sfx20_Trk1:
	INCBIN "data/bank_07c/Sfx20_Trk1.bin" ; $4232, 1212 bytes
Sfx20_Trk2:
	INCBIN "data/bank_07c/Sfx20_Trk2.bin" ; $46ee, 1048 bytes
Sfx20_Trk3:
	INCBIN "data/bank_07c/Sfx20_Trk3.bin" ; $4b06, 738 bytes
Sfx21_Trk0:
	INCBIN "data/bank_07c/Sfx21_Trk0.bin" ; $4de8, 424 bytes
Sfx21_Trk1:
	INCBIN "data/bank_07c/Sfx21_Trk1.bin" ; $4f90, 692 bytes
Sfx21_Trk2:
	INCBIN "data/bank_07c/Sfx21_Trk2.bin" ; $5244, 490 bytes
Sfx21_Trk3:
	INCBIN "data/bank_07c/Sfx21_Trk3.bin" ; $542e, 1272 bytes
Sfx22_Trk0:
	INCBIN "data/bank_07c/Sfx22_Trk0.bin" ; $5926, 654 bytes
Sfx22_Trk1:
	INCBIN "data/bank_07c/Sfx22_Trk1.bin" ; $5bb4, 652 bytes
Sfx22_Trk2:
	INCBIN "data/bank_07c/Sfx22_Trk2.bin" ; $5e40, 616 bytes
Sfx22_Trk3:
	INCBIN "data/bank_07c/Sfx22_Trk3.bin" ; $60a8, 422 bytes
Sfx23_Trk0:
	INCBIN "data/bank_07c/Sfx23_Trk0.bin" ; $624e, 498 bytes
Sfx23_Trk1:
	INCBIN "data/bank_07c/Sfx23_Trk1.bin" ; $6440, 502 bytes
Sfx23_Trk2:
	INCBIN "data/bank_07c/Sfx23_Trk2.bin" ; $6636, 534 bytes
Sfx23_Trk3:
	INCBIN "data/bank_07c/Sfx23_Trk3.bin" ; $684c, 1274 bytes
Sfx24_Trk0:
	INCBIN "data/bank_07c/Sfx24_Trk0.bin" ; $6d46, 566 bytes
Sfx24_Trk1:
	INCBIN "data/bank_07c/Sfx24_Trk1.bin" ; $6f7c, 570 bytes
Sfx24_Trk2:
	INCBIN "data/bank_07c/Sfx24_Trk2.bin" ; $71b6, 1682 bytes
Sfx24_Trk3:
	INCBIN "data/bank_07c/Sfx24_Trk3.bin" ; $7848, 1648 bytes
Music54_Trk0:
	INCBIN "data/bank_07c/Music54_Trk0.bin" ; $7eb8, 42 bytes
Music55_Trk0:
	INCBIN "data/bank_07c/Music55_Trk0.bin" ; $7ee2, 54 bytes
Music56_Trk0:
	INCBIN "data/bank_07c/Music56_Trk0.bin" ; $7f18, 40 bytes
Music57_Trk0:
	INCBIN "data/bank_07c/Music57_Trk0.bin" ; $7f40, 56 bytes
Music58_Trk0:
	INCBIN "data/bank_07c/Music58_Trk0.bin" ; $7f78, 40 bytes
Music59_Trk0:
	INCBIN "data/bank_07c/Music59_Trk0.bin" ; $7fa0, 48 bytes
Music5b_Trk0:
	INCBIN "data/bank_07c/Music5b_Trk0.bin" ; $7fd0, 22 bytes
	; $7fe6, 26 bytes fill to bank end (linker-padded)

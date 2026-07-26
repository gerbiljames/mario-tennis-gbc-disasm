SECTION "ROM Bank $7f", ROMX[$4000], BANK[$7f]

SoundTable_7f:
	dw $0000 ; $4000
	dw Music96_Trk0 ; $4002
	dw $0220 ; $4004
	dw Music96_Trk1 ; $4006
	dw $0000 ; $4008
	dw Music97_Trk0 ; $400a
	dw $0000 ; $400c
	dw Music98_Trk0 ; $400e
	dw $0300 ; $4010
	dw Music99_Trk0 ; $4012
	dw $0000 ; $4014
	dw Music9d_Trk0 ; $4016
	dw $0000 ; $4018
	dw Music9e_Trk0 ; $401a
	dw $0000 ; $401c
	dw Music9f_Trk0 ; $401e
	dw $0000 ; $4020
	dw Musica0_Trk0 ; $4022
	dw $0000 ; $4024
	dw Musica1_Trk0 ; $4026
	dw $0000 ; $4028
	dw Musica2_Trk0 ; $402a
	dw $0000 ; $402c
	dw Musica3_Trk0 ; $402e
	dw $0000 ; $4030
	dw Musica4_Trk0 ; $4032
	dw $0000 ; $4034
	dw Musica5_Trk0 ; $4036
	dw $0000 ; $4038
	dw Musica6_Trk0 ; $403a
	dw $0000 ; $403c
	dw Musica7_Trk0 ; $403e
	dw $0000 ; $4040
	dw Musica8_Trk0 ; $4042
	dw $0000 ; $4044
	dw Musica9_Trk0 ; $4046
	dw $0000 ; $4048
	dw Musicaa_Trk0 ; $404a
	dw $0000 ; $404c
	dw Musicab_Trk0 ; $404e
	dw $0000 ; $4050
	dw Musicac_Trk0 ; $4052
	dw $0000 ; $4054
	dw Musicad_Trk0 ; $4056
	dw $0000 ; $4058
	dw Musicae_Trk0 ; $405a
	dw $0000 ; $405c
	dw Musicaf_Trk0 ; $405e
	dw $0000 ; $4060
	dw Musicb0_Trk0 ; $4062
	dw $0000 ; $4064
	dw Musicb1_Trk0 ; $4066
	dw $0000 ; $4068
	dw Musicb2_Trk0 ; $406a
	dw $0000 ; $406c
	dw Musicb3_Trk0 ; $406e
	dw $0000 ; $4070
	dw Musicb4_Trk0 ; $4072
	dw $0000 ; $4074
	dw Musicb5_Trk0 ; $4076
	dw $0000 ; $4078
	dw Musicb6_Trk0 ; $407a
	dw $0000 ; $407c
	dw Musicb7_Trk0 ; $407e
	dw $0000 ; $4080
	dw Musicb8_Trk0 ; $4082
	dw $0000 ; $4084
	dw Musicb9_Trk0 ; $4086
	dw $0020 ; $4088
	dw Musicba_Trk0 ; $408a
	dw $0020 ; $408c
	dw Musicbb_Trk0 ; $408e
	dw $0020 ; $4090
	dw Musicbc_Trk0 ; $4092
	dw $0020 ; $4094
	dw Musicbd_Trk0 ; $4096
	dw $0020 ; $4098
	dw Musicbe_Trk0 ; $409a
	dw $0020 ; $409c
	dw Musicbf_Trk0 ; $409e
	dw $0020 ; $40a0
	dw Musicc0_Trk0 ; $40a2
	dw $0000 ; $40a4
	dw Musicc1_Trk0 ; $40a6
Music96_Trk0:
	INCBIN "data/bank_07f/d_40a8.bin" ; $40a8, 36 bytes
Music96_Trk1:
	INCBIN "data/bank_07f/d_40cc.bin" ; $40cc, 44 bytes
Music97_Trk0:
	INCBIN "data/bank_07f/d_40f8.bin" ; $40f8, 72 bytes
Music98_Trk0:
	INCBIN "data/bank_07f/d_4140.bin" ; $4140, 72 bytes
Music99_Trk0:
	INCBIN "data/bank_07f/d_4188.bin" ; $4188, 26 bytes
Music9d_Trk0:
	INCBIN "data/bank_07f/d_41a2.bin" ; $41a2, 12 bytes
Music9e_Trk0:
	INCBIN "data/bank_07f/d_41ae.bin" ; $41ae, 12 bytes
Music9f_Trk0:
	INCBIN "data/bank_07f/d_41ba.bin" ; $41ba, 12 bytes
Musica0_Trk0:
	INCBIN "data/bank_07f/d_41c6.bin" ; $41c6, 12 bytes
Musica1_Trk0:
	INCBIN "data/bank_07f/d_41d2.bin" ; $41d2, 12 bytes
Musica2_Trk0:
	INCBIN "data/bank_07f/d_41de.bin" ; $41de, 12 bytes
Musica3_Trk0:
	INCBIN "data/bank_07f/d_41ea.bin" ; $41ea, 12 bytes
Musica4_Trk0:
	INCBIN "data/bank_07f/d_41f6.bin" ; $41f6, 12 bytes
Musica5_Trk0:
	INCBIN "data/bank_07f/d_4202.bin" ; $4202, 12 bytes
Musica6_Trk0:
	INCBIN "data/bank_07f/d_420e.bin" ; $420e, 12 bytes
Musica7_Trk0:
	INCBIN "data/bank_07f/d_421a.bin" ; $421a, 12 bytes
Musica8_Trk0:
	INCBIN "data/bank_07f/d_4226.bin" ; $4226, 12 bytes
Musica9_Trk0:
	INCBIN "data/bank_07f/d_4232.bin" ; $4232, 12 bytes
Musicaa_Trk0:
	INCBIN "data/bank_07f/d_423e.bin" ; $423e, 12 bytes
Musicab_Trk0:
	INCBIN "data/bank_07f/d_424a.bin" ; $424a, 12 bytes
Musicac_Trk0:
	INCBIN "data/bank_07f/d_4256.bin" ; $4256, 12 bytes
Musicad_Trk0:
	INCBIN "data/bank_07f/d_4262.bin" ; $4262, 12 bytes
Musicae_Trk0:
	INCBIN "data/bank_07f/d_426e.bin" ; $426e, 12 bytes
Musicaf_Trk0:
	INCBIN "data/bank_07f/d_427a.bin" ; $427a, 12 bytes
Musicb0_Trk0:
	INCBIN "data/bank_07f/d_4286.bin" ; $4286, 12 bytes
Musicb1_Trk0:
	INCBIN "data/bank_07f/d_4292.bin" ; $4292, 12 bytes
Musicb2_Trk0:
	INCBIN "data/bank_07f/d_429e.bin" ; $429e, 12 bytes
Musicb3_Trk0:
	INCBIN "data/bank_07f/d_42aa.bin" ; $42aa, 12 bytes
Musicb4_Trk0:
	INCBIN "data/bank_07f/d_42b6.bin" ; $42b6, 12 bytes
Musicb5_Trk0:
	INCBIN "data/bank_07f/d_42c2.bin" ; $42c2, 12 bytes
Musicb6_Trk0:
	INCBIN "data/bank_07f/d_42ce.bin" ; $42ce, 12 bytes
Musicb7_Trk0:
	INCBIN "data/bank_07f/d_42da.bin" ; $42da, 12 bytes
Musicb8_Trk0:
	INCBIN "data/bank_07f/d_42e6.bin" ; $42e6, 12 bytes
Musicb9_Trk0:
	INCBIN "data/bank_07f/d_42f2.bin" ; $42f2, 12 bytes
Musicba_Trk0:
	INCBIN "data/bank_07f/d_42fe.bin" ; $42fe, 72 bytes
Musicbb_Trk0:
	INCBIN "data/bank_07f/d_4346.bin" ; $4346, 72 bytes
Musicbc_Trk0:
	INCBIN "data/bank_07f/d_438e.bin" ; $438e, 72 bytes
Musicbd_Trk0:
	INCBIN "data/bank_07f/d_43d6.bin" ; $43d6, 72 bytes
Musicbe_Trk0:
	INCBIN "data/bank_07f/d_441e.bin" ; $441e, 72 bytes
Musicbf_Trk0:
	INCBIN "data/bank_07f/d_4466.bin" ; $4466, 72 bytes
Musicc0_Trk0:
	INCBIN "data/bank_07f/d_44ae.bin" ; $44ae, 72 bytes
Musicc1_Trk0:
	INCBIN "data/bank_07f/d_44f6.bin" ; $44f6, 12 bytes
	; $4502, 15102 bytes fill to bank end (linker-padded)

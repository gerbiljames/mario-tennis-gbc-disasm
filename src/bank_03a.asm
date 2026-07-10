INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $3a", ROMX[$4000], BANK[$3a]

DataPtr_3a_00:
	dw TennisDictionaryTiles ; $4000
DataPtr_3a_02:
	dw TennisDictionaryListTiles ; $4002
DataPtr_3a_04:
	dw Lz_3a_53fb ; $4004
DataPtr_3a_06:
	dw Lz_3a_53fb ; $4006
DataPtr_3a_08:
	dw Lz_3a_53fb ; $4008
DataPtr_3a_0a:
	dw Lz_3a_53fb ; $400a
DataPtr_3a_0c:
	dw Lz_3a_53fb ; $400c
DataPtr_3a_0e:
	dw Lz_3a_53fb ; $400e
DataPtr_3a_10:
	dw Lz_3a_53fb ; $4010
DataPtr_3a_12:
	dw Lz_3a_53fb ; $4012
DataPtr_3a_14:
	dw Lz_3a_53fb ; $4014
DataPtr_3a_16:
	dw Lz_3a_5468 ; $4016
DataPtr_3a_18:
	dw Lz_3a_54d8 ; $4018
DataPtr_3a_1a:
	dw Lz_3a_5545 ; $401a
DataPtr_3a_1c:
	dw Lz_3a_53fb ; $401c
DataPtr_3a_1e:
	dw Lz_3a_53fb ; $401e
DataPtr_3a_20:
	dw Lz_3a_53fb ; $4020
DataPtr_3a_22:
	dw Lz_3a_53fb ; $4022
DataPtr_3a_24:
	dw Lz_3a_55af ; $4024
DataPtr_3a_26:
	dw Lz_3a_5a21 ; $4026
DataPtr_3a_28:
	dw Lz_3a_5afa ; $4028
DataPtr_3a_2a:
	dw Data_3a_5b67 ; $402a
DataPtr_3a_2c:
	dw Lz_3a_5ba7 ; $402c
DataPtr_3a_2e:
	dw Lz_3a_6249 ; $402e
DataPtr_3a_30:
	dw Lz_3a_6348 ; $4030
DataPtr_3a_32:
	dw Data_3a_63bf ; $4032
DataPtr_3a_34:
	dw Lz_3a_63ff ; $4034
DataPtr_3a_36:
	dw Lz_3a_6a71 ; $4036
DataPtr_3a_38:
	dw Lz_3a_6b7d ; $4038
DataPtr_3a_3a:
	dw Data_3a_6bf6 ; $403a
DataPtr_3a_3c:
	dw Lz_3a_6c36 ; $403c
DataPtr_3a_3e:
	dw Lz_3a_6d42 ; $403e
DataPtr_3a_40:
	dw Lz_3a_6dbd ; $4040
DataPtr_3a_42:
	dw Lz_3a_7034 ; $4042
DataPtr_3a_44:
	dw Lz_3a_70c9 ; $4044
DataPtr_3a_46:
	dw Data_3a_7134 ; $4046
DataPtr_3a_48:
	dw Lz_3a_7174 ; $4048
DataPtr_3a_4a:
	dw Lz_3a_759f ; $404a
DataPtr_3a_4c:
	dw Lz_3a_7645 ; $404c
DataPtr_3a_4e:
	dw Data_3a_76cf ; $404e
DataPtr_3a_50:
	dw Lz_3a_770f ; $4050
DataPtr_3a_52:
	dw Lz_3a_7c6f ; $4052
DataPtr_3a_54:
	dw Lz_3a_7d5e ; $4054
DataPtr_3a_56:
	dw Data_3a_7dba ; $4056
DataPtr_3a_58:
	dw Lz_3a_7dfa ; $4058
TennisDictionaryTiles:
	INCBIN "data/bank_03a/lz_405a.bin" ; $405a, 2621 bytes
TennisDictionaryListTiles:
	INCBIN "data/bank_03a/lz_4a97.bin" ; $4a97, 2404 bytes
Lz_3a_53fb:
	INCBIN "data/bank_03a/lz_53fb.bin" ; $53fb, 109 bytes
Lz_3a_5468:
	INCBIN "data/bank_03a/lz_5468.bin" ; $5468, 112 bytes
Lz_3a_54d8:
	INCBIN "data/bank_03a/lz_54d8.bin" ; $54d8, 109 bytes
Lz_3a_5545:
	INCBIN "data/bank_03a/lz_5545.bin" ; $5545, 106 bytes
Lz_3a_55af:
	INCBIN "data/bank_03a/lz_55af.bin" ; $55af, 1138 bytes
Lz_3a_5a21:
	INCBIN "data/bank_03a/lz_5a21.bin" ; $5a21, 217 bytes
Lz_3a_5afa:
	INCBIN "data/bank_03a/lz_5afa.bin" ; $5afa, 109 bytes
Data_3a_5b67:
	INCBIN "data/bank_03a/d_5b67.bin" ; $5b67, 64 bytes
Lz_3a_5ba7:
	INCBIN "data/bank_03a/lz_5ba7.bin" ; $5ba7, 1698 bytes
Lz_3a_6249:
	INCBIN "data/bank_03a/lz_6249.bin" ; $6249, 255 bytes
Lz_3a_6348:
	INCBIN "data/bank_03a/lz_6348.bin" ; $6348, 119 bytes
Data_3a_63bf:
	INCBIN "data/bank_03a/d_63bf.bin" ; $63bf, 64 bytes
Lz_3a_63ff:
	INCBIN "data/bank_03a/lz_63ff.bin" ; $63ff, 1650 bytes
Lz_3a_6a71:
	INCBIN "data/bank_03a/lz_6a71.bin" ; $6a71, 268 bytes
Lz_3a_6b7d:
	INCBIN "data/bank_03a/lz_6b7d.bin" ; $6b7d, 121 bytes
Data_3a_6bf6:
	INCBIN "data/bank_03a/d_6bf6.bin" ; $6bf6, 64 bytes
Lz_3a_6c36:
	INCBIN "data/bank_03a/lz_6c36.bin" ; $6c36, 268 bytes
Lz_3a_6d42:
	INCBIN "data/bank_03a/lz_6d42.bin" ; $6d42, 123 bytes
Lz_3a_6dbd:
	INCBIN "data/bank_03a/lz_6dbd.bin" ; $6dbd, 631 bytes
Lz_3a_7034:
	INCBIN "data/bank_03a/lz_7034.bin" ; $7034, 149 bytes
Lz_3a_70c9:
	INCBIN "data/bank_03a/lz_70c9.bin" ; $70c9, 107 bytes
Data_3a_7134:
	INCBIN "data/bank_03a/d_7134.bin" ; $7134, 64 bytes
Lz_3a_7174:
	INCBIN "data/bank_03a/lz_7174.bin" ; $7174, 1067 bytes
Lz_3a_759f:
	INCBIN "data/bank_03a/lz_759f.bin" ; $759f, 166 bytes
Lz_3a_7645:
	INCBIN "data/bank_03a/lz_7645.bin" ; $7645, 138 bytes
Data_3a_76cf:
	INCBIN "data/bank_03a/d_76cf.bin" ; $76cf, 64 bytes
Lz_3a_770f:
	INCBIN "data/bank_03a/lz_770f.bin" ; $770f, 1376 bytes
Lz_3a_7c6f:
	INCBIN "data/bank_03a/lz_7c6f.bin" ; $7c6f, 239 bytes
Lz_3a_7d5e:
	INCBIN "data/bank_03a/lz_7d5e.bin" ; $7d5e, 92 bytes
Data_3a_7dba:
	INCBIN "data/bank_03a/d_7dba.bin" ; $7dba, 64 bytes
Lz_3a_7dfa:
	INCBIN "data/bank_03a/lz_7dfa.bin" ; $7dfa, 227 bytes
	INCBIN "data/bank_03a/d_7edd.bin" ; $7edd, 291 bytes

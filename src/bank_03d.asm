INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $3d", ROMX[$4000], BANK[$3d]

DataPtr_3d_00:
	dw Lz_3d_406e ; $4000
DataPtr_3d_02:
	dw Lz_3d_416f ; $4002
DataPtr_3d_04:
	dw Lz_3d_4271 ; $4004
DataPtr_3d_06:
	dw Lz_3d_4371 ; $4006
DataPtr_3d_08:
	dw Lz_3d_4467 ; $4008
DataPtr_3d_0a:
	dw Lz_3d_451b ; $400a
DataPtr_3d_0c:
	dw Lz_3d_45de ; $400c
DataPtr_3d_0e:
	dw Lz_3d_4682 ; $400e
DataPtr_3d_10:
	dw Lz_3d_475c ; $4010
DataPtr_3d_12:
	dw Lz_3d_4830 ; $4012
DataPtr_3d_14:
	dw Lz_3d_4830 ; $4014
DataPtr_3d_16:
	dw Lz_3d_4830 ; $4016
DataPtr_3d_18:
	dw Lz_3d_4830 ; $4018
DataPtr_3d_1a:
	dw Lz_3d_4830 ; $401a
DataPtr_3d_1c:
	dw Lz_3d_48e3 ; $401c
DataPtr_3d_1e:
	dw Lz_3d_499e ; $401e
DataPtr_3d_20:
	dw Lz_3d_4a55 ; $4020
DataPtr_3d_22:
	dw Lz_3d_4afc ; $4022
DataPtr_3d_24:
	dw Lz_3d_4b8d ; $4024
DataPtr_3d_26:
	dw Lz_3d_4c3d ; $4026
DataPtr_3d_28:
	dw Lz_3d_4ccd ; $4028
DataPtr_3d_2a:
	dw Lz_3d_4d97 ; $402a
DataPtr_3d_2c:
	dw Lz_3d_4e3a ; $402c
DataPtr_3d_2e:
	dw Lz_3d_4ef4 ; $402e
DataPtr_3d_30:
	dw Lz_3d_5073 ; $4030
DataPtr_3d_32:
	dw Lz_3d_5148 ; $4032
DataPtr_3d_34:
	dw Lz_3d_567d ; $4034
DataPtr_3d_36:
	dw Lz_3d_576e ; $4036
DataPtr_3d_38:
	dw Data_3d_57e1 ; $4038
DataPtr_3d_3a:
	dw Lz_3d_5821 ; $403a
DataPtr_3d_3c:
	dw Lz_3d_5ce1 ; $403c
DataPtr_3d_3e:
	dw Lz_3d_5e25 ; $403e
DataPtr_3d_40:
	dw Data_3d_5eaa ; $4040
DataPtr_3d_42:
	dw Lz_3d_5eea ; $4042
DataPtr_3d_44:
	dw Lz_3d_5f99 ; $4044
DataPtr_3d_46:
	dw Lz_3d_67fd ; $4046
DataPtr_3d_48:
	dw Lz_3d_6966 ; $4048
DataPtr_3d_4a:
	dw Data_3d_69c8 ; $404a
DataPtr_3d_4c:
	dw Lz_3d_6b92 ; $404c
DataPtr_3d_4e:
	dw Lz_3d_6cde ; $404e
DataPtr_3d_50:
	dw Lz_3d_6a08 ; $4050
DataPtr_3d_52:
	dw Lz_3d_6b29 ; $4052
DataPtr_3d_54:
	dw Lz_3d_6d39 ; $4054
DataPtr_3d_56:
	dw Lz_3d_6e2e ; $4056
DataPtr_3d_58:
	dw Lz_3d_4fd6 ; $4058
DataPtr_3d_5a:
	dw Lz_3d_6f28 ; $405a
DataPtr_3d_5c:
	dw Lz_3d_7725 ; $405c
DataPtr_3d_5e:
	dw Lz_3d_77c6 ; $405e
DataPtr_3d_60:
	dw Data_3d_7830 ; $4060
DataPtr_3d_62:
	dw Lz_3d_7870 ; $4062
DataPtr_3d_64:
	dw Lz_3d_788a ; $4064
DataPtr_3d_66:
	dw Lz_3d_7a5b ; $4066
DataPtr_3d_68:
	dw Data_3d_7ace ; $4068
DataPtr_3d_6a:
	dw Lz_3d_7b0e ; $406a
DataPtr_3d_6c:
	dw Lz_3d_7c59 ; $406c
Lz_3d_406e:
	INCBIN "data/bank_03d/lz_406e.bin" ; $406e, 257 bytes
Lz_3d_416f:
	INCBIN "data/bank_03d/lz_416f.bin" ; $416f, 258 bytes
Lz_3d_4271:
	INCBIN "data/bank_03d/lz_4271.bin" ; $4271, 256 bytes
Lz_3d_4371:
	INCBIN "data/bank_03d/lz_4371.bin" ; $4371, 246 bytes
Lz_3d_4467:
	INCBIN "data/bank_03d/lz_4467.bin" ; $4467, 180 bytes
Lz_3d_451b:
	INCBIN "data/bank_03d/lz_451b.bin" ; $451b, 195 bytes
Lz_3d_45de:
	INCBIN "data/bank_03d/lz_45de.bin" ; $45de, 164 bytes
Lz_3d_4682:
	INCBIN "data/bank_03d/lz_4682.bin" ; $4682, 218 bytes
Lz_3d_475c:
	INCBIN "data/bank_03d/lz_475c.bin" ; $475c, 212 bytes
Lz_3d_4830:
	INCBIN "data/bank_03d/lz_4830.bin" ; $4830, 179 bytes
Lz_3d_48e3:
	INCBIN "data/bank_03d/lz_48e3.bin" ; $48e3, 187 bytes
Lz_3d_499e:
	INCBIN "data/bank_03d/lz_499e.bin" ; $499e, 183 bytes
Lz_3d_4a55:
	INCBIN "data/bank_03d/lz_4a55.bin" ; $4a55, 167 bytes
Lz_3d_4afc:
	INCBIN "data/bank_03d/lz_4afc.bin" ; $4afc, 145 bytes
Lz_3d_4b8d:
	INCBIN "data/bank_03d/lz_4b8d.bin" ; $4b8d, 176 bytes
Lz_3d_4c3d:
	INCBIN "data/bank_03d/lz_4c3d.bin" ; $4c3d, 144 bytes
Lz_3d_4ccd:
	INCBIN "data/bank_03d/lz_4ccd.bin" ; $4ccd, 202 bytes
Lz_3d_4d97:
	INCBIN "data/bank_03d/lz_4d97.bin" ; $4d97, 163 bytes
Lz_3d_4e3a:
	INCBIN "data/bank_03d/lz_4e3a.bin" ; $4e3a, 186 bytes
Lz_3d_4ef4:
	INCBIN "data/bank_03d/lz_4ef4.bin" ; $4ef4, 226 bytes
Lz_3d_4fd6:
	INCBIN "data/bank_03d/lz_4fd6.bin" ; $4fd6, 157 bytes
Lz_3d_5073:
	INCBIN "data/bank_03d/lz_5073.bin" ; $5073, 213 bytes
Lz_3d_5148:
	INCBIN "data/bank_03d/lz_5148.bin" ; $5148, 1333 bytes
Lz_3d_567d:
	INCBIN "data/bank_03d/lz_567d.bin" ; $567d, 241 bytes
Lz_3d_576e:
	INCBIN "data/bank_03d/lz_576e.bin" ; $576e, 115 bytes
Data_3d_57e1:
	INCBIN "data/bank_03d/d_57e1.bin" ; $57e1, 64 bytes
Lz_3d_5821:
	INCBIN "data/bank_03d/lz_5821.bin" ; $5821, 1216 bytes
Lz_3d_5ce1:
	INCBIN "data/bank_03d/lz_5ce1.bin" ; $5ce1, 324 bytes
Lz_3d_5e25:
	INCBIN "data/bank_03d/lz_5e25.bin" ; $5e25, 133 bytes
Data_3d_5eaa:
	INCBIN "data/bank_03d/d_5eaa.bin" ; $5eaa, 64 bytes
Lz_3d_5eea:
	INCBIN "data/bank_03d/lz_5eea.bin" ; $5eea, 175 bytes
Lz_3d_5f99:
	INCBIN "data/bank_03d/lz_5f99.bin" ; $5f99, 2148 bytes
Lz_3d_67fd:
	INCBIN "data/bank_03d/lz_67fd.bin" ; $67fd, 361 bytes
Lz_3d_6966:
	INCBIN "data/bank_03d/lz_6966.bin" ; $6966, 98 bytes
Data_3d_69c8:
	INCBIN "data/bank_03d/d_69c8.bin" ; $69c8, 64 bytes
Lz_3d_6a08:
	INCBIN "data/bank_03d/lz_6a08.bin" ; $6a08, 289 bytes
Lz_3d_6b29:
	INCBIN "data/bank_03d/lz_6b29.bin" ; $6b29, 105 bytes
Lz_3d_6b92:
	INCBIN "data/bank_03d/lz_6b92.bin" ; $6b92, 332 bytes
Lz_3d_6cde:
	INCBIN "data/bank_03d/lz_6cde.bin" ; $6cde, 91 bytes
Lz_3d_6d39:
	INCBIN "data/bank_03d/lz_6d39.bin" ; $6d39, 245 bytes
Lz_3d_6e2e:
	INCBIN "data/bank_03d/lz_6e2e.bin" ; $6e2e, 250 bytes
Lz_3d_6f28:
	INCBIN "data/bank_03d/lz_6f28.bin" ; $6f28, 2045 bytes
Lz_3d_7725:
	INCBIN "data/bank_03d/lz_7725.bin" ; $7725, 161 bytes
Lz_3d_77c6:
	INCBIN "data/bank_03d/lz_77c6.bin" ; $77c6, 106 bytes
Data_3d_7830:
	INCBIN "data/bank_03d/d_7830.bin" ; $7830, 64 bytes
Lz_3d_7870:
	INCBIN "data/bank_03d/lz_7870.bin" ; $7870, 26 bytes
Lz_3d_788a:
	INCBIN "data/bank_03d/lz_788a.bin" ; $788a, 465 bytes
Lz_3d_7a5b:
	INCBIN "data/bank_03d/lz_7a5b.bin" ; $7a5b, 115 bytes
Data_3d_7ace:
	INCBIN "data/bank_03d/d_7ace.bin" ; $7ace, 64 bytes
Lz_3d_7b0e:
	INCBIN "data/bank_03d/lz_7b0e.bin" ; $7b0e, 331 bytes
Lz_3d_7c59:
	INCBIN "data/bank_03d/lz_7c59.bin" ; $7c59, 102 bytes
	INCBIN "data/bank_03d/d_7cbf.bin" ; $7cbf, 833 bytes

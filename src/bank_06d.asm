INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6d", ROMX[$4000], BANK[$6d]

DataPtr_6d_00:
	dw Lz_6d_4094 ; $4000
DataPtr_6d_02:
	dw Lz_6d_4148 ; $4002
DataPtr_6d_04:
	dw Lz_6d_4215 ; $4004
DataPtr_6d_06:
	dw Lz_6d_42e3 ; $4006
DataPtr_6d_08:
	dw Lz_6d_43c8 ; $4008
DataPtr_6d_0a:
	dw Lz_6d_44a8 ; $400a
DataPtr_6d_0c:
	dw Lz_6d_4581 ; $400c
DataPtr_6d_0e:
	dw Lz_6d_4656 ; $400e
DataPtr_6d_10:
	dw Lz_6d_4714 ; $4010
DataPtr_6d_12:
	dw Lz_6d_4d3d ; $4012
DataPtr_6d_14:
	dw Lz_6d_5340 ; $4014
DataPtr_6d_16:
	dw Lz_6d_546b ; $4016
	INCBIN "data/bank_06d/d_4018.bin" ; $4018, 2 bytes
DataPtr_6d_1a:
	dw Lz_6d_54f3 ; $401a
DataPtr_6d_1c:
	dw Lz_6d_5f18 ; $401c
DataPtr_6d_1e:
	dw Lz_6d_6061 ; $401e
	INCBIN "data/bank_06d/d_4020.bin" ; $4020, 2 bytes
DataPtr_6d_22:
	dw Lz_6d_6144 ; $4022
DataPtr_6d_24:
	dw Lz_6d_6250 ; $4024
	INCBIN "data/bank_06d/d_4026.bin" ; $4026, 2 bytes
DataPtr_6d_28:
	dw Lz_6d_6ac8 ; $4028
	INCBIN "data/bank_06d/d_402a.bin" ; $402a, 6 bytes
DataPtr_6d_30:
	dw Lz_6d_62d5 ; $4030
	INCBIN "data/bank_06d/d_4032.bin" ; $4032, 2 bytes
DataPtr_6d_34:
	dw Lz_6d_6b13 ; $4034
DataPtr_6d_36:
	dw Lz_6d_6b5b ; $4036
DataPtr_6d_38:
	dw Lz_6d_6ba2 ; $4038
DataPtr_6d_3a:
	dw Lz_6d_6be5 ; $403a
DataPtr_6d_3c:
	dw Lz_6d_6c26 ; $403c
DataPtr_6d_3e:
	dw Lz_6d_6c69 ; $403e
DataPtr_6d_40:
	dw Lz_6d_6cb0 ; $4040
DataPtr_6d_42:
	dw Lz_6d_6cf8 ; $4042
DataPtr_6d_44:
	dw Lz_6d_6d41 ; $4044
DataPtr_6d_46:
	dw Lz_6d_6d89 ; $4046
DataPtr_6d_48:
	dw Lz_6d_6dd1 ; $4048
DataPtr_6d_4a:
	dw Lz_6d_6e16 ; $404a
DataPtr_6d_4c:
	dw Lz_6d_6e59 ; $404c
DataPtr_6d_4e:
	dw Lz_6d_6e9e ; $404e
DataPtr_6d_50:
	dw Lz_6d_6ee6 ; $4050
DataPtr_6d_52:
	dw Lz_6d_6f2e ; $4052
	INCBIN "data/bank_06d/d_4054.bin" ; $4054, 32 bytes
DataPtr_6d_74:
	dw Lz_6d_6fd3 ; $4074
DataPtr_6d_76:
	dw Lz_6d_7087 ; $4076
DataPtr_6d_78:
	dw Lz_6d_7132 ; $4078
DataPtr_6d_7a:
	dw Lz_6d_71e0 ; $407a
DataPtr_6d_7c:
	dw Lz_6d_728f ; $407c
DataPtr_6d_7e:
	dw Lz_6d_731f ; $407e
DataPtr_6d_80:
	dw Lz_6d_73d9 ; $4080
DataPtr_6d_82:
	dw Lz_6d_745b ; $4082
	INCBIN "data/bank_06d/d_4084.bin" ; $4084, 16 bytes
Lz_6d_4094:
	INCBIN "data/bank_06d/lz_4094.bin" ; $4094, 179 bytes
	INCBIN "data/bank_06d/d_4147.bin" ; $4147, 1 bytes
Lz_6d_4148:
	INCBIN "data/bank_06d/lz_4148.bin" ; $4148, 204 bytes
	INCBIN "data/bank_06d/d_4214.bin" ; $4214, 1 bytes
Lz_6d_4215:
	INCBIN "data/bank_06d/lz_4215.bin" ; $4215, 205 bytes
	INCBIN "data/bank_06d/d_42e2.bin" ; $42e2, 1 bytes
Lz_6d_42e3:
	INCBIN "data/bank_06d/lz_42e3.bin" ; $42e3, 228 bytes
	INCBIN "data/bank_06d/d_43c7.bin" ; $43c7, 1 bytes
Lz_6d_43c8:
	INCBIN "data/bank_06d/lz_43c8.bin" ; $43c8, 223 bytes
	INCBIN "data/bank_06d/d_44a7.bin" ; $44a7, 1 bytes
Lz_6d_44a8:
	INCBIN "data/bank_06d/lz_44a8.bin" ; $44a8, 216 bytes
	INCBIN "data/bank_06d/d_4580.bin" ; $4580, 1 bytes
Lz_6d_4581:
	INCBIN "data/bank_06d/lz_4581.bin" ; $4581, 212 bytes
	INCBIN "data/bank_06d/d_4655.bin" ; $4655, 1 bytes
Lz_6d_4656:
	INCBIN "data/bank_06d/lz_4656.bin" ; $4656, 189 bytes
	INCBIN "data/bank_06d/d_4713.bin" ; $4713, 1 bytes
Lz_6d_4714:
	INCBIN "data/bank_06d/lz_4714.bin" ; $4714, 1576 bytes
	INCBIN "data/bank_06d/d_4d3c.bin" ; $4d3c, 1 bytes
Lz_6d_4d3d:
	INCBIN "data/bank_06d/lz_4d3d.bin" ; $4d3d, 1538 bytes
	INCBIN "data/bank_06d/d_533f.bin" ; $533f, 1 bytes
Lz_6d_5340:
	INCBIN "data/bank_06d/lz_5340.bin" ; $5340, 298 bytes
	INCBIN "data/bank_06d/d_546a.bin" ; $546a, 1 bytes
Lz_6d_546b:
	INCBIN "data/bank_06d/lz_546b.bin" ; $546b, 71 bytes
	INCBIN "data/bank_06d/d_54b2.bin" ; $54b2, 65 bytes
Lz_6d_54f3:
	INCBIN "data/bank_06d/lz_54f3.bin" ; $54f3, 2596 bytes
	INCBIN "data/bank_06d/d_5f17.bin" ; $5f17, 1 bytes
Lz_6d_5f18:
	INCBIN "data/bank_06d/lz_5f18.bin" ; $5f18, 328 bytes
	INCBIN "data/bank_06d/d_6060.bin" ; $6060, 1 bytes
Lz_6d_6061:
	INCBIN "data/bank_06d/lz_6061.bin" ; $6061, 162 bytes
	INCBIN "data/bank_06d/d_6103.bin" ; $6103, 65 bytes
Lz_6d_6144:
	INCBIN "data/bank_06d/lz_6144.bin" ; $6144, 267 bytes
	INCBIN "data/bank_06d/d_624f.bin" ; $624f, 1 bytes
Lz_6d_6250:
	INCBIN "data/bank_06d/lz_6250.bin" ; $6250, 132 bytes
	INCBIN "data/bank_06d/d_62d4.bin" ; $62d4, 1 bytes
Lz_6d_62d5:
	INCBIN "data/bank_06d/lz_62d5.bin" ; $62d5, 1961 bytes
	INCBIN "data/bank_06d/d_6a7e.bin" ; $6a7e, 74 bytes
Lz_6d_6ac8:
	INCBIN "data/bank_06d/lz_6ac8.bin" ; $6ac8, 75 bytes
Lz_6d_6b13:
	INCBIN "data/bank_06d/lz_6b13.bin" ; $6b13, 71 bytes
	INCBIN "data/bank_06d/d_6b5a.bin" ; $6b5a, 1 bytes
Lz_6d_6b5b:
	INCBIN "data/bank_06d/lz_6b5b.bin" ; $6b5b, 70 bytes
	INCBIN "data/bank_06d/d_6ba1.bin" ; $6ba1, 1 bytes
Lz_6d_6ba2:
	INCBIN "data/bank_06d/lz_6ba2.bin" ; $6ba2, 66 bytes
	INCBIN "data/bank_06d/d_6be4.bin" ; $6be4, 1 bytes
Lz_6d_6be5:
	INCBIN "data/bank_06d/lz_6be5.bin" ; $6be5, 64 bytes
	INCBIN "data/bank_06d/d_6c25.bin" ; $6c25, 1 bytes
Lz_6d_6c26:
	INCBIN "data/bank_06d/lz_6c26.bin" ; $6c26, 66 bytes
	INCBIN "data/bank_06d/d_6c68.bin" ; $6c68, 1 bytes
Lz_6d_6c69:
	INCBIN "data/bank_06d/lz_6c69.bin" ; $6c69, 70 bytes
	INCBIN "data/bank_06d/d_6caf.bin" ; $6caf, 1 bytes
Lz_6d_6cb0:
	INCBIN "data/bank_06d/lz_6cb0.bin" ; $6cb0, 71 bytes
	INCBIN "data/bank_06d/d_6cf7.bin" ; $6cf7, 1 bytes
Lz_6d_6cf8:
	INCBIN "data/bank_06d/lz_6cf8.bin" ; $6cf8, 72 bytes
	INCBIN "data/bank_06d/d_6d40.bin" ; $6d40, 1 bytes
Lz_6d_6d41:
	INCBIN "data/bank_06d/lz_6d41.bin" ; $6d41, 71 bytes
	INCBIN "data/bank_06d/d_6d88.bin" ; $6d88, 1 bytes
Lz_6d_6d89:
	INCBIN "data/bank_06d/lz_6d89.bin" ; $6d89, 71 bytes
	INCBIN "data/bank_06d/d_6dd0.bin" ; $6dd0, 1 bytes
Lz_6d_6dd1:
	INCBIN "data/bank_06d/lz_6dd1.bin" ; $6dd1, 69 bytes
Lz_6d_6e16:
	INCBIN "data/bank_06d/lz_6e16.bin" ; $6e16, 66 bytes
	INCBIN "data/bank_06d/d_6e58.bin" ; $6e58, 1 bytes
Lz_6d_6e59:
	INCBIN "data/bank_06d/lz_6e59.bin" ; $6e59, 69 bytes
Lz_6d_6e9e:
	INCBIN "data/bank_06d/lz_6e9e.bin" ; $6e9e, 71 bytes
	INCBIN "data/bank_06d/d_6ee5.bin" ; $6ee5, 1 bytes
Lz_6d_6ee6:
	INCBIN "data/bank_06d/lz_6ee6.bin" ; $6ee6, 71 bytes
	INCBIN "data/bank_06d/d_6f2d.bin" ; $6f2d, 1 bytes
Lz_6d_6f2e:
	INCBIN "data/bank_06d/lz_6f2e.bin" ; $6f2e, 164 bytes
	INCBIN "data/bank_06d/d_6fd2.bin" ; $6fd2, 1 bytes
Lz_6d_6fd3:
	INCBIN "data/bank_06d/lz_6fd3.bin" ; $6fd3, 179 bytes
	INCBIN "data/bank_06d/d_7086.bin" ; $7086, 1 bytes
Lz_6d_7087:
	INCBIN "data/bank_06d/lz_7087.bin" ; $7087, 170 bytes
	INCBIN "data/bank_06d/d_7131.bin" ; $7131, 1 bytes
Lz_6d_7132:
	INCBIN "data/bank_06d/lz_7132.bin" ; $7132, 173 bytes
	INCBIN "data/bank_06d/d_71df.bin" ; $71df, 1 bytes
Lz_6d_71e0:
	INCBIN "data/bank_06d/lz_71e0.bin" ; $71e0, 174 bytes
	INCBIN "data/bank_06d/d_728e.bin" ; $728e, 1 bytes
Lz_6d_728f:
	INCBIN "data/bank_06d/lz_728f.bin" ; $728f, 143 bytes
	INCBIN "data/bank_06d/d_731e.bin" ; $731e, 1 bytes
Lz_6d_731f:
	INCBIN "data/bank_06d/lz_731f.bin" ; $731f, 185 bytes
	INCBIN "data/bank_06d/d_73d8.bin" ; $73d8, 1 bytes
Lz_6d_73d9:
	INCBIN "data/bank_06d/lz_73d9.bin" ; $73d9, 130 bytes
Lz_6d_745b:
	INCBIN "data/bank_06d/lz_745b.bin" ; $745b, 172 bytes
	INCBIN "data/bank_06d/d_7507.bin" ; $7507, 2809 bytes

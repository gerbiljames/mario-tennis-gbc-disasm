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
	INCBIN "data/bank_03d/d_4012.bin" ; $4012, 92 bytes
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
	INCBIN "data/bank_03d/d_4830.bin" ; $4830, 14288 bytes

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
	INCBIN "data/bank_03d/lz_406e.bin" ; $406e, 256 bytes
	INCBIN "data/bank_03d/d_416e.bin" ; $416e, 1 bytes
Lz_3d_416f:
	INCBIN "data/bank_03d/lz_416f.bin" ; $416f, 257 bytes
	INCBIN "data/bank_03d/d_4270.bin" ; $4270, 1 bytes
Lz_3d_4271:
	INCBIN "data/bank_03d/lz_4271.bin" ; $4271, 255 bytes
	INCBIN "data/bank_03d/d_4370.bin" ; $4370, 1 bytes
Lz_3d_4371:
	INCBIN "data/bank_03d/lz_4371.bin" ; $4371, 245 bytes
	INCBIN "data/bank_03d/d_4466.bin" ; $4466, 1 bytes
Lz_3d_4467:
	INCBIN "data/bank_03d/lz_4467.bin" ; $4467, 179 bytes
	INCBIN "data/bank_03d/d_451a.bin" ; $451a, 1 bytes
Lz_3d_451b:
	INCBIN "data/bank_03d/lz_451b.bin" ; $451b, 194 bytes
	INCBIN "data/bank_03d/d_45dd.bin" ; $45dd, 1 bytes
Lz_3d_45de:
	INCBIN "data/bank_03d/lz_45de.bin" ; $45de, 163 bytes
	INCBIN "data/bank_03d/d_4681.bin" ; $4681, 1 bytes
Lz_3d_4682:
	INCBIN "data/bank_03d/lz_4682.bin" ; $4682, 218 bytes
Lz_3d_475c:
	INCBIN "data/bank_03d/lz_475c.bin" ; $475c, 211 bytes
	INCBIN "data/bank_03d/d_482f.bin" ; $482f, 14289 bytes

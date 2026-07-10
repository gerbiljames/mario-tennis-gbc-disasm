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
	INCBIN "data/bank_03d/d_4012.bin" ; $4012, 8 bytes
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
	INCBIN "data/bank_03d/d_4032.bin" ; $4032, 60 bytes
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
	INCBIN "data/bank_03d/d_4fd6.bin" ; $4fd6, 157 bytes
Lz_3d_5073:
	INCBIN "data/bank_03d/lz_5073.bin" ; $5073, 213 bytes
	INCBIN "data/bank_03d/d_5148.bin" ; $5148, 11960 bytes

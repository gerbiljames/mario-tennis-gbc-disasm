INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $7c", ROMX[$4000], BANK[$7c]

SoundTable_7c:
	dw $0140 ; $4000
	dw Data_7c_406c ; $4002
	dw $0060 ; $4004
	dw Data_7c_4232 ; $4006
	dw $0280 ; $4008
	dw Data_7c_46ee ; $400a
	dw $03a0 ; $400c
	dw Data_7c_4b06 ; $400e
	dw $0140 ; $4010
	dw Data_7c_4de8 ; $4012
	dw $0060 ; $4014
	dw Data_7c_4f90 ; $4016
	dw $0280 ; $4018
	dw Data_7c_5244 ; $401a
	dw $03a0 ; $401c
	dw Data_7c_542e ; $401e
	dw $0140 ; $4020
	dw Data_7c_5926 ; $4022
	dw $0060 ; $4024
	dw Data_7c_5bb4 ; $4026
	dw $0280 ; $4028
	dw Data_7c_5e40 ; $402a
	dw $03a0 ; $402c
	dw Data_7c_60a8 ; $402e
	dw $0140 ; $4030
	dw Data_7c_624e ; $4032
	dw $0060 ; $4034
	dw Data_7c_6440 ; $4036
	dw $0280 ; $4038
	dw Data_7c_6636 ; $403a
	dw $03a0 ; $403c
	dw Data_7c_684c ; $403e
	dw $0140 ; $4040
	dw Data_7c_6d46 ; $4042
	dw $0060 ; $4044
	dw Data_7c_6f7c ; $4046
	dw $0280 ; $4048
	dw Data_7c_71b6 ; $404a
	dw $03a0 ; $404c
	dw Data_7c_7848 ; $404e
	dw $0300 ; $4050
	dw Data_7c_7eb8 ; $4052
	dw $0300 ; $4054
	dw Data_7c_7ee2 ; $4056
	dw $0300 ; $4058
	dw Data_7c_7f18 ; $405a
	dw $0300 ; $405c
	dw Data_7c_7f40 ; $405e
	dw $0300 ; $4060
	dw Data_7c_7f78 ; $4062
	dw $0300 ; $4064
	dw Data_7c_7fa0 ; $4066
	dw $0300 ; $4068
	dw Data_7c_7fd0 ; $406a
Data_7c_406c:
	INCBIN "data/bank_07c/d_406c.bin" ; $406c, 454 bytes
Data_7c_4232:
	INCBIN "data/bank_07c/d_4232.bin" ; $4232, 1212 bytes
Data_7c_46ee:
	INCBIN "data/bank_07c/d_46ee.bin" ; $46ee, 1048 bytes
Data_7c_4b06:
	INCBIN "data/bank_07c/d_4b06.bin" ; $4b06, 738 bytes
Data_7c_4de8:
	INCBIN "data/bank_07c/d_4de8.bin" ; $4de8, 424 bytes
Data_7c_4f90:
	INCBIN "data/bank_07c/d_4f90.bin" ; $4f90, 692 bytes
Data_7c_5244:
	INCBIN "data/bank_07c/d_5244.bin" ; $5244, 490 bytes
Data_7c_542e:
	INCBIN "data/bank_07c/d_542e.bin" ; $542e, 1272 bytes
Data_7c_5926:
	INCBIN "data/bank_07c/d_5926.bin" ; $5926, 654 bytes
Data_7c_5bb4:
	INCBIN "data/bank_07c/d_5bb4.bin" ; $5bb4, 652 bytes
Data_7c_5e40:
	INCBIN "data/bank_07c/d_5e40.bin" ; $5e40, 616 bytes
Data_7c_60a8:
	INCBIN "data/bank_07c/d_60a8.bin" ; $60a8, 422 bytes
Data_7c_624e:
	INCBIN "data/bank_07c/d_624e.bin" ; $624e, 498 bytes
Data_7c_6440:
	INCBIN "data/bank_07c/d_6440.bin" ; $6440, 502 bytes
Data_7c_6636:
	INCBIN "data/bank_07c/d_6636.bin" ; $6636, 534 bytes
Data_7c_684c:
	INCBIN "data/bank_07c/d_684c.bin" ; $684c, 1274 bytes
Data_7c_6d46:
	INCBIN "data/bank_07c/d_6d46.bin" ; $6d46, 566 bytes
Data_7c_6f7c:
	INCBIN "data/bank_07c/d_6f7c.bin" ; $6f7c, 570 bytes
Data_7c_71b6:
	INCBIN "data/bank_07c/d_71b6.bin" ; $71b6, 1682 bytes
Data_7c_7848:
	INCBIN "data/bank_07c/d_7848.bin" ; $7848, 1648 bytes
Data_7c_7eb8:
	INCBIN "data/bank_07c/d_7eb8.bin" ; $7eb8, 42 bytes
Data_7c_7ee2:
	INCBIN "data/bank_07c/d_7ee2.bin" ; $7ee2, 54 bytes
Data_7c_7f18:
	INCBIN "data/bank_07c/d_7f18.bin" ; $7f18, 40 bytes
Data_7c_7f40:
	INCBIN "data/bank_07c/d_7f40.bin" ; $7f40, 56 bytes
Data_7c_7f78:
	INCBIN "data/bank_07c/d_7f78.bin" ; $7f78, 40 bytes
Data_7c_7fa0:
	INCBIN "data/bank_07c/d_7fa0.bin" ; $7fa0, 48 bytes
Data_7c_7fd0:
	INCBIN "data/bank_07c/d_7fd0.bin" ; $7fd0, 22 bytes
	ds 26, $ff ; $7fe6, fill

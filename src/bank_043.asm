INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $43", ROMX[$4000], BANK[$43]

	INCBIN "data/bank_043/d_4000.bin" ; $4000, 64 bytes
FarPtr_43_40:
	dw Func_43_5030 ; $4040
	INCBIN "data/bank_043/d_4042.bin" ; $4042, 4078 bytes
Func_43_5030:
	nop ; $5030
	nop ; $5031
	nop ; $5032
	nop ; $5033
	nop ; $5034
	nop ; $5035
	nop ; $5036
	nop ; $5037
	nop ; $5038
	nop ; $5039
	nop ; $503a
	nop ; $503b
	nop ; $503c
	nop ; $503d
	inc bc ; $503e
	inc bc ; $503f
	ld bc, $0701 ; $5040
	rlca ; $5043
	ld bc, $0001 ; $5044
	nop ; $5047
	nop ; $5048
	nop ; $5049
	nop ; $504a
	nop ; $504b
	nop ; $504c
	nop ; $504d
	nop ; $504e
	nop ; $504f
	nop ; $5050
	nop ; $5051
	ld bc, $0101 ; $5052
	ld bc, $0203 ; $5055
	inc bc ; $5058
	ld [bc], a ; $5059
	inc bc ; $505a
	inc bc ; $505b
	rlca ; $505c
	ld b, $07 ; $505d
	inc b ; $505f
	rlca ; $5060
	inc b ; $5061
	rlca ; $5062
	dec b ; $5063
	inc bc ; $5064
	inc bc ; $5065
	inc bc ; $5066
	inc bc ; $5067
	ld [bc], a ; $5068
	inc bc ; $5069
	rlca ; $506a
	dec b ; $506b
	rrca ; $506c
	ld c, $07 ; $506d
	rlca ; $506f
	nop ; $5070
	nop ; $5071
	nop ; $5072
	nop ; $5073
	nop ; $5074
	nop ; $5075
	nop ; $5076
	nop ; $5077
	nop ; $5078
	nop ; $5079
	nop ; $507a
	nop ; $507b
	nop ; $507c
	nop ; $507d
	add a, e ; $507e
	add a, e ; $507f
	rst Rst28 ; $5080
	rst Rst28 ; $5081
	rst Rst38 ; $5082
	rst Rst38 ; $5083
	rst Rst38 ; $5084
	rst Rst38 ; $5085
	rst Rst38 ; $5086
	add a, c ; $5087
	rst Rst38 ; $5088
	rst Rst38 ; $5089
	push hl ; $508a
	rst Rst38 ; $508b
	push hl ; $508c
	rst Rst38 ; $508d
	ld [hl], l ; $508e
	ld a, a ; $508f
	INCBIN "data/bank_043/d_5090.bin" ; $5090, 12067 bytes
	ds 77, $ff ; $7fb3, fill

INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1a", ROMX[$4000], BANK[$1a]

	INCBIN "data/bank_01a/d_4000.bin" ; $4000, 3127 bytes
	ret ; $4c37
	INCBIN "data/bank_01a/d_4c38.bin" ; $4c38, 11901 bytes
	ld a, [$cb00] ; $7ab5
	or a, a ; $7ab8
	ret nz ; $7ab9
	ld a, $06 ; $7aba
	ldh [$ff96], a ; $7abc
	ldh [rWBK], a ; $7abe
	xor a, a ; $7ac0
	ld hl, $d0ab ; $7ac1
	ld [hl+], a ; $7ac4
	ld [hl+], a ; $7ac5
	ld [hl+], a ; $7ac6
	ld [hl+], a ; $7ac7
	ld [hl+], a ; $7ac8
	ld [hl+], a ; $7ac9
	ld [hl+], a ; $7aca
	ld [hl+], a ; $7acb
	ld [hl+], a ; $7acc
	ld [hl+], a ; $7acd
	ld [hl+], a ; $7ace
	ld a, [wEquippedRacket] ; $7acf
	or a, a ; $7ad2
	ret z ; $7ad3
	rst Rst18 ; $7ad4
	ld [de], a ; $7ad5
	ld [bc], a ; $7ad6
	ld hl, $c920 ; $7ad7
	ld de, $d0a0 ; $7ada
	ld a, [hl+] ; $7add
	ld [de], a ; $7ade
	inc de ; $7adf
	ld a, [hl+] ; $7ae0
	ld [de], a ; $7ae1
	inc de ; $7ae2
	ld a, [hl+] ; $7ae3
	ld [de], a ; $7ae4
	inc de ; $7ae5
	ld a, [hl+] ; $7ae6
	ld [de], a ; $7ae7
	inc de ; $7ae8
	ld a, [hl+] ; $7ae9
	ld [de], a ; $7aea
	inc de ; $7aeb
	ld a, [hl+] ; $7aec
	ld [de], a ; $7aed
	inc de ; $7aee
	ld a, [hl+] ; $7aef
	ld [de], a ; $7af0
	inc de ; $7af1
	ld a, [hl+] ; $7af2
	ld [de], a ; $7af3
	inc de ; $7af4
	ld a, [hl+] ; $7af5
	ld [de], a ; $7af6
	inc de ; $7af7
	ld a, [hl+] ; $7af8
	ld [de], a ; $7af9
	inc de ; $7afa
	ld a, [hl] ; $7afb
	ld [de], a ; $7afc
	ld hl, $d0a0 ; $7afd
	ld c, [hl] ; $7b00
	ld a, [$d00e] ; $7b01
	dec a ; $7b04
	sub a, c ; $7b05
	ld [$d0ab], a ; $7b06
	ld hl, $d0a1 ; $7b09
	ld c, [hl] ; $7b0c
	ld a, [$d00f] ; $7b0d
	dec a ; $7b10
	sub a, c ; $7b11
	ld [$d0ac], a ; $7b12
	ld hl, $d0a2 ; $7b15
	ld c, [hl] ; $7b18
	ld a, [$d010] ; $7b19
	dec a ; $7b1c
	sub a, c ; $7b1d
	ld [$d0ad], a ; $7b1e
	ld hl, $d0a3 ; $7b21
	ld c, [hl] ; $7b24
	ld a, [$d011] ; $7b25
	dec a ; $7b28
	sub a, c ; $7b29
	ld [$d0ae], a ; $7b2a
	ld hl, $d0a4 ; $7b2d
	ld c, [hl] ; $7b30
	ld a, [$d012] ; $7b31
	dec a ; $7b34
	sub a, c ; $7b35
	ld [$d0af], a ; $7b36
	ld hl, $d0a5 ; $7b39
	ld c, [hl] ; $7b3c
	ld a, [$d013] ; $7b3d
	dec a ; $7b40
	sub a, c ; $7b41
	ld [$d0b0], a ; $7b42
	ld hl, $d0a6 ; $7b45
	ld c, [hl] ; $7b48
	ld a, [$d014] ; $7b49
	dec a ; $7b4c
	sub a, c ; $7b4d
	ld [$d0b1], a ; $7b4e
	ld hl, $d0a7 ; $7b51
	ld c, [hl] ; $7b54
	ld a, [$d015] ; $7b55
	dec a ; $7b58
	sub a, c ; $7b59
	ld [$d0b2], a ; $7b5a
	ld hl, $d0a8 ; $7b5d
	ld c, [hl] ; $7b60
	ld a, [$d016] ; $7b61
	dec a ; $7b64
	sub a, c ; $7b65
	ld [$d0b3], a ; $7b66
	ld hl, $d0a9 ; $7b69
	ld c, [hl] ; $7b6c
	ld a, [$d017] ; $7b6d
	dec a ; $7b70
	sub a, c ; $7b71
	ld [$d0b4], a ; $7b72
	ld hl, $d0aa ; $7b75
	ld c, [hl] ; $7b78
	ld a, [$d018] ; $7b79
	dec a ; $7b7c
	sub a, c ; $7b7d
	ld [$d0b5], a ; $7b7e
	rst Rst18 ; $7b81
	INCBIN "data/bank_01a/d_7b82.bin" ; $7b82, 3 bytes
	ld hl, $7e7e ; $7b85
	ld de, $0c02 ; $7b88
	call Func_00_05b0 ; $7b8b
	ld a, $01 ; $7b8e
	ldh [$ff96], a ; $7b90
	ldh [rWBK], a ; $7b92
	ld hl, $7e8e ; $7b94
	ld de, $d000 ; $7b97
	call DecompressData ; $7b9a
	ld hl, $d000 ; $7b9d
	ld de, $a780 ; $7ba0
	ld c, $02 ; $7ba3
	call Func_00_0480 ; $7ba5
	ld hl, $7e99 ; $7ba8
	ld de, $d000 ; $7bab
	call DecompressData ; $7bae
	ld hl, $d000 ; $7bb1
	ld de, $a7a0 ; $7bb4
	ld c, $02 ; $7bb7
	call Func_00_0480 ; $7bb9
	ld hl, $7ea4 ; $7bbc
	ld de, $d000 ; $7bbf
	call DecompressData ; $7bc2
	ld hl, $d000 ; $7bc5
	ld de, $a7c0 ; $7bc8
	ld c, $02 ; $7bcb
	call Func_00_0480 ; $7bcd
	ld hl, $7eaf ; $7bd0
	ld de, $d000 ; $7bd3
	call DecompressData ; $7bd6
	ld hl, $d000 ; $7bd9
	ld de, $a7e0 ; $7bdc
	ld c, $02 ; $7bdf
	call Func_00_0480 ; $7be1
	ret ; $7be4
	INCBIN "data/bank_01a/d_7be5.bin" ; $7be5, 1051 bytes

SECTION "ROM Bank $25", ROMX[$4000], BANK[$25]

FarPtr_FetchDialogueText_25:
	dw FetchDialogueText_25 ; $4000
FarPtr_FetchShortText_25:
	dw FetchShortText_25 ; $4002
Text_25_4004:
	INCLUDE "data/bank_025/text_4004.asm" ; $4004, 15156 bytes
FetchDialogueText_25:
	push af ; $7b38
	ld a, $00 ; $7b39
	call FetchText_25 ; $7b3b
	pop af ; $7b3e
	ret ; $7b3f
FetchShortText_25:
	push af ; $7b40
	ld a, $01 ; $7b41
	call FetchText_25 ; $7b43
	pop af ; $7b46
	ret ; $7b47
FetchText_25:
	push bc ; $7b48
	push de ; $7b49
	push hl ; $7b4a
	ld hl, $4004 ; $7b4b
	sla e ; $7b4e
	rl d ; $7b50
	add hl, de ; $7b52
	ld e, [hl] ; $7b53
	inc hl ; $7b54
	ld d, [hl] ; $7b55
	ld hl, $421a ; $7b56
	add hl, de ; $7b59
	or a, a ; $7b5a
	jr nz, Label_25_7b64 ; $7b5b
	ld de, wTextBuffer ; $7b5d
	ld c, $a0 ; $7b60
	jr Label_25_7b69 ; $7b62
Label_25_7b64:
	ld de, wShortTextBuffer ; $7b64
	ld c, $10 ; $7b67
Label_25_7b69:
	dec c ; $7b69
	jr z, Label_25_7b76 ; $7b6a
	ld a, [hl+] ; $7b6c
	ld [de], a ; $7b6d
	inc de ; $7b6e
	or a, a ; $7b6f
	jr nz, Label_25_7b69 ; $7b70
	pop hl ; $7b72
	pop de ; $7b73
	pop bc ; $7b74
	ret ; $7b75
Label_25_7b76:
	xor a, a ; $7b76
	ld [de], a ; $7b77
	ldh a, [$ff9e] ; $7b78
	or a, a ; $7b7a
	jr z, Label_25_7b7f ; $7b7b
	sound $2c ; $7b7d
Label_25_7b7f:
	pop hl ; $7b7f
	pop de ; $7b80
	pop bc ; $7b81
	ret ; $7b82
	ds 1149, $ff ; $7b83, fill

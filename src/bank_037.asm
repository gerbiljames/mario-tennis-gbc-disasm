INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $37", ROMX[$4000], BANK[$37]

FarPtr_37_00:
	dw FetchDialogueText_37 ; $4000
FarPtr_37_02:
	dw FetchShortText_37 ; $4002
Text_37_4004:
	INCLUDE "data/bank_037/text_4004.asm" ; $4004, 15130 bytes
FetchDialogueText_37:
	push af ; $7b1e
	ld a, $00 ; $7b1f
	call FetchText_37 ; $7b21
	pop af ; $7b24
	ret ; $7b25
FetchShortText_37:
	push af ; $7b26
	ld a, $01 ; $7b27
	call FetchText_37 ; $7b29
	pop af ; $7b2c
	ret ; $7b2d
FetchText_37:
	push bc ; $7b2e
	push de ; $7b2f
	push hl ; $7b30
	ld hl, $4004 ; $7b31
	sla e ; $7b34
	rl d ; $7b36
	add hl, de ; $7b38
	ld e, [hl] ; $7b39
	inc hl ; $7b3a
	ld d, [hl] ; $7b3b
	ld hl, $4204 ; $7b3c
	add hl, de ; $7b3f
	or a, a ; $7b40
	jr nz, Label_37_7b4a ; $7b41
	ld de, wTextBuffer ; $7b43
	ld c, $a0 ; $7b46
	jr Label_37_7b4f ; $7b48
Label_37_7b4a:
	ld de, wShortTextBuffer ; $7b4a
	ld c, $10 ; $7b4d
Label_37_7b4f:
	dec c ; $7b4f
	jr z, Label_37_7b5c ; $7b50
	ld a, [hl+] ; $7b52
	ld [de], a ; $7b53
	inc de ; $7b54
	or a, a ; $7b55
	jr nz, Label_37_7b4f ; $7b56
	pop hl ; $7b58
	pop de ; $7b59
	pop bc ; $7b5a
	ret ; $7b5b
Label_37_7b5c:
	xor a, a ; $7b5c
	ld [de], a ; $7b5d
	ldh a, [$ff9e] ; $7b5e
	or a, a ; $7b60
	jr z, Label_37_7b65 ; $7b61
	sound $2c ; $7b63
Label_37_7b65:
	pop hl ; $7b65
	pop de ; $7b66
	pop bc ; $7b67
	ret ; $7b68
	ds 1175, $ff ; $7b69, fill

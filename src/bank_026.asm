INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $26", ROMX[$4000], BANK[$26]

FarPtr_FetchDialogueText_26:
	dw FetchDialogueText_26 ; $4000
FarPtr_FetchShortText_26:
	dw FetchShortText_26 ; $4002
Text_26_4004:
	INCLUDE "data/bank_026/text_4004.asm" ; $4004, 15123 bytes
FetchDialogueText_26:
	push af ; $7b17
	ld a, $00 ; $7b18
	call FetchText_26 ; $7b1a
	pop af ; $7b1d
	ret ; $7b1e
FetchShortText_26:
	push af ; $7b1f
	ld a, $01 ; $7b20
	call FetchText_26 ; $7b22
	pop af ; $7b25
	ret ; $7b26
FetchText_26:
	push bc ; $7b27
	push de ; $7b28
	push hl ; $7b29
	ld hl, $4004 ; $7b2a
	sla e ; $7b2d
	rl d ; $7b2f
	add hl, de ; $7b31
	ld e, [hl] ; $7b32
	inc hl ; $7b33
	ld d, [hl] ; $7b34
	ld hl, $41f6 ; $7b35
	add hl, de ; $7b38
	or a, a ; $7b39
	jr nz, Label_26_7b43 ; $7b3a
	ld de, wTextBuffer ; $7b3c
	ld c, $a0 ; $7b3f
	jr Label_26_7b48 ; $7b41
Label_26_7b43:
	ld de, wShortTextBuffer ; $7b43
	ld c, $10 ; $7b46
Label_26_7b48:
	dec c ; $7b48
	jr z, Label_26_7b55 ; $7b49
	ld a, [hl+] ; $7b4b
	ld [de], a ; $7b4c
	inc de ; $7b4d
	or a, a ; $7b4e
	jr nz, Label_26_7b48 ; $7b4f
	pop hl ; $7b51
	pop de ; $7b52
	pop bc ; $7b53
	ret ; $7b54
Label_26_7b55:
	xor a, a ; $7b55
	ld [de], a ; $7b56
	ldh a, [$ff9e] ; $7b57
	or a, a ; $7b59
	jr z, Label_26_7b5e ; $7b5a
	sound $2c ; $7b5c
Label_26_7b5e:
	pop hl ; $7b5e
	pop de ; $7b5f
	pop bc ; $7b60
	ret ; $7b61
	ds 1182, $ff ; $7b62, fill

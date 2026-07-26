SECTION "ROM Bank $33", ROMX[$4000], BANK[$33]

	farptr FetchDialogueText_33 ; $4000
	farptr FetchShortText_33 ; $4002
FetchTextTable_33:
	INCBIN "data/bank_033/d_4004.bin" ; $4004, 442 bytes
Text_33_41be:
	INCLUDE "data/bank_033/text_41be.asm" ; $41be, 14604 bytes
FetchDialogueText_33:
	push af ; $7aca
	ld a, $00 ; $7acb
	call FetchText_33 ; $7acd
	pop af ; $7ad0
	ret ; $7ad1
FetchShortText_33:
	push af ; $7ad2
	ld a, $01 ; $7ad3
	call FetchText_33 ; $7ad5
	pop af ; $7ad8
	ret ; $7ad9
FetchText_33:
	push bc ; $7ada
	push de ; $7adb
	push hl ; $7adc
	ld hl, FetchTextTable_33 ; $7add
	sla e ; $7ae0
	rl d ; $7ae2
	add hl, de ; $7ae4
	ld e, [hl] ; $7ae5
	inc hl ; $7ae6
	ld d, [hl] ; $7ae7
	ld hl, Text_33_41be ; $7ae8
	add hl, de ; $7aeb
	or a, a ; $7aec
	jr nz, .nonZero ; $7aed
	ld de, wTextBuffer ; $7aef
	ld c, $a0 ; $7af2
	jr .loop ; $7af4
.nonZero:
	ld de, wShortTextBuffer ; $7af6
	ld c, $10 ; $7af9
.loop:
	dec c ; $7afb
	jr z, .countDone ; $7afc
	ld a, [hl+] ; $7afe
	ld [de], a ; $7aff
	inc de ; $7b00
	or a, a ; $7b01
	jr nz, .loop ; $7b02
	pop hl ; $7b04
	pop de ; $7b05
	pop bc ; $7b06
	ret ; $7b07
.countDone:
	xor a, a ; $7b08
	ld [de], a ; $7b09
	ldh a, [hDebugStepMode] ; $7b0a
	or a, a ; $7b0c
	jr z, .restore ; $7b0d
	sound $2c ; $7b0f
.restore:
	pop hl ; $7b11
	pop de ; $7b12
	pop bc ; $7b13
	ret ; $7b14
	; $7b15, 1259 bytes fill to bank end (linker-padded)

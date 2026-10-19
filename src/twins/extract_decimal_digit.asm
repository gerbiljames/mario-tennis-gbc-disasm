; Shared by ExtractDecimalDigit, ExtractDecimalDigitUnsigned (bank $00).

{TWIN_LABEL}:
	xor a
.loop:
	inc a
	add hl, bc
	jr c, .loop
	dec a
	ret

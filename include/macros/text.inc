; Game text: segments joined by control bytes.

; Game text (data/bank_XXX/text_*.asm): db segments joined by control bytes
; -- $01 new line, $02 new page, $03 end. `text` opens a string (or continues
; an overlong segment); `line`/`page` emit the control byte plus the segment.
MACRO text
	db \#
ENDM

MACRO line
	db $01, \#
ENDM

MACRO page
	db $02, \#
ENDM

MACRO done
	db $03
ENDM

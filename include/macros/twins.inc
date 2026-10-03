; Shared routine families (src/twins/).

; One routine copied into several banks lives once under src/twins/.
; `twin file, 25` includes src/twins/file.asm with {TWIN} = "25", so
; `FetchText_{TWIN}:` and the bank-local references become that bank's;
; `twin_named file, Label` sets {TWIN_LABEL} = Label for copies with
; different names.
MACRO twin
DEF TWIN EQUS "\2"
	INCLUDE "src/twins/\1.asm"
PURGE TWIN
ENDM

MACRO twin_named
DEF TWIN_LABEL EQUS "\2"
	INCLUDE "src/twins/\1.asm"
PURGE TWIN_LABEL
ENDM

; twin_in file, Label, bank: both at once, for a body that carries its own
; name in each bank and references that bank's tables by suffix.
MACRO twin_in
DEF TWIN_LABEL EQUS "\2"
DEF TWIN EQUS "\3"
	INCLUDE "src/twins/\1.asm"
PURGE TWIN
PURGE TWIN_LABEL
ENDM

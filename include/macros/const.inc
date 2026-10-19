; Enumerations: `const_def [start[, step]]` opens one, each `const NAME`
; takes the next value, and `const_value` is then the count, for NUM_*.

MACRO const_def
	IF _NARG >= 1
		DEF const_value = \1
	ELSE
		DEF const_value = 0
	ENDC
	IF _NARG >= 2
		DEF const_inc = \2
	ELSE
		DEF const_inc = 1
	ENDC
ENDM

MACRO const
	DEF \1 EQU const_value
	DEF const_value += const_inc
ENDM

MACRO const_skip
	IF _NARG >= 1
		DEF const_value += const_inc * (\1)
	ELSE
		DEF const_value += const_inc
	ENDC
ENDM

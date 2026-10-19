; --- Joypad buttons (standard GB layout) ---
; The per-character input byte (wCharInputBits, built by ReadCharPadInput) and
; the raw joypad shadow use the standard layout: buttons in the low nibble, d-pad
; in the high nibble. PADF_* are the bit masks; PADB_* the matching bit indices
; (for bit/set/res).
def PADF_A       equ $01
def PADF_B       equ $02
def PADF_SELECT  equ $04
def PADF_START   equ $08
def PADF_RIGHT   equ $10
def PADF_LEFT    equ $20
def PADF_UP      equ $40
def PADF_DOWN    equ $80
def PADF_BUTTONS equ PADF_A | PADF_B | PADF_SELECT | PADF_START
def PADF_DPAD    equ PADF_RIGHT | PADF_LEFT | PADF_UP | PADF_DOWN
	const_def
	const PADB_A      ; $00
	const PADB_B      ; $01
	const PADB_SELECT ; $02
	const PADB_START  ; $03
	const PADB_RIGHT  ; $04
	const PADB_LEFT   ; $05
	const PADB_UP     ; $06
	const PADB_DOWN   ; $07

; --- Debug stepper (hDebugStepMode) ---
; Nonzero arms the SELECT+START frame stepper in AdvanceFrame, where SELECT
; cycles 1-3. The mode also says how often UpdateDebugOverlay shows the debug
; console: the SELECT test meant for mode 1 discards its result.
	const_def
	const DEBUGSTEP_OFF           ; $00
	const DEBUGSTEP_CONSOLE_OFF   ; $01 console never shown
	const DEBUGSTEP_CONSOLE_BLINK ; $02 shown on even frames
	const DEBUGSTEP_CONSOLE_ON    ; $03
def NUM_DEBUGSTEP_MODES equ const_value

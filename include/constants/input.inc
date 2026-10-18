; --- Joypad buttons (standard GB layout) ---
; The per-character input byte ($df1f, built by ReadCharPadInput) and the raw
; joypad shadow use the standard layout: buttons in the low nibble, d-pad in the
; high nibble. PADF_* are the bit masks; PADB_* the matching bit indices (for
; bit/set/res).
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
def PADB_A       equ 0
def PADB_B       equ 1
def PADB_SELECT  equ 2
def PADB_START   equ 3
def PADB_RIGHT   equ 4
def PADB_LEFT    equ 5
def PADB_UP      equ 6
def PADB_DOWN    equ 7

; --- Debug stepper (hDebugStepMode) ---
; Nonzero arms the SELECT+START frame stepper in AdvanceFrame, where SELECT
; cycles 1-3. The mode also says how often UpdateDebugOverlay shows the debug
; console: the SELECT test meant for mode 1 discards its result.
def DEBUGSTEP_OFF           equ 0
def DEBUGSTEP_CONSOLE_OFF   equ 1 ; console never shown
def DEBUGSTEP_CONSOLE_BLINK equ 2 ; shown on even frames
def DEBUGSTEP_CONSOLE_ON    equ 3
def NUM_DEBUGSTEP_MODES     equ 4

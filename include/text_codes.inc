; Text control codes: a byte below $20 in a game string dispatches through
; ControlCodeHandlers_05 ($05:$548f) instead of printing (docs/screens_and_ui.md
; 7.2). $01 / $02 / $03 are spelled by the line / page / done macros; the rest
; appear in the generated data/<bank>/TextStrings_*.asm pools as these names.
; Hand-maintained; the values are the engine's, not extracted content.
def TX_ARG_STRING     equ $04 ; pop the string-argument queue into the text (PushTextArgString)
def TX_DELAY_30       equ $05 ; wait 30 frames, not skippable
def TX_DELAY_15       equ $06 ; wait 15 frames, aborts on input
def TX_PLAYER_NAME    equ $07 ; the story main character's name
def TX_SHORT_TEXT_ARG equ $08 ; a ret in the renderer; the measuring pass counts it as a short-text argument
def TX_ARG_NUMBER     equ $09 ; pop the number queue into the text (PushTextArgNumber)
def TX_NOP            equ $0a ; ret
def TX_PARTNER_NAME   equ $0b ; the story partner's name
def TX_DELAY_150      equ $0c ; wait 150 frames, skippable
def TX_NEXT_GLYPH_ROW equ $0d ; advance the glyph write pointer two tilemap rows
def TX_SHORT_TEXT     equ $0e ; one operand byte follows: roster short text $1b + n
def TX_NEWLINE_0F     equ $0f ; alias of $01 (TextCmdNewline)
def TX_NOP_10         equ $10 ; ret
def TX_NOP_11         equ $11 ; ret
def TX_NOP_12         equ $12 ; ret
def TX_NOP_13         equ $13 ; ret
def TX_NEWLINE_14     equ $14 ; aliases of $01 (TextCmdNewline)
def TX_NEWLINE_15     equ $15
def TX_NEWLINE_16     equ $16
def TX_NEWLINE_17     equ $17
def TX_NEWLINE_18     equ $18
def TX_NEWLINE_19     equ $19
def TX_NEWLINE_1A     equ $1a
def TX_NEWLINE_1B     equ $1b
def TX_NEWLINE_1C     equ $1c
def TX_NEWLINE_1D     equ $1d
def TX_DAKUTEN        equ $de ; remapped to code $1e: add a voiced-sound mark to the previous cell
def TX_HANDAKUTEN     equ $df ; remapped to code $1f: the semi-voiced mark

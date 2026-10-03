; Character sprite animation scripts.

; Two-byte entries read by AdvanceActorAnimation ($04, overworld actors) and
; StepCharAnimation ($08, on-court characters): low byte is a frame index or a
; command, high byte is its operand. Only bank $08 implements anim_flip; bank
; $04 treats any unrecognised $f0-$fd command as "hold this frame".
MACRO anim_frame     ; show frame \1 (index into the character's *SpriteFrames table) for \2 frames
	db \1, \2
ENDM

MACRO anim_loop      ; $ff restart the script at its base + \1
	db $ff, \1
ENDM

MACRO anim_set       ; $fe switch to animation \1
	db $fe, \1
ENDM

MACRO anim_flip      ; $fb replace the sprite's attribute high nibble (flip/priority bits) with \1 (match characters only)
	db $fb, \1
ENDM

; $f0-$fd (except $fb): set the frame delay to $ff and keep the current frame,
; i.e. hold it forever. One byte -- neither interpreter reads an operand.
MACRO anim_hold
	db \1
ENDM

; Sound channel scripts (data/bank_07x/<Track>.asm, generated at setup).

; A SoundTable entry's first word: which channel struct the track drives
; (StartSoundChannel indexes wSndChannels by the low byte, $20 per channel)
; and the byte it stores into that struct.
MACRO snd_channel
	db (\1) * $20, \2
ENDM

; Every command is two bytes, opcode then operand, and the driver steps them
; by command index (RunSoundChannelScript; docs/sound_engine.md "Script
; command set"). snd_call is the one four-byte command: its target word is a
; byte offset from the track start that snd_track names. Note names C_ .. B_
; are in include/constants/; the octave is how many times the driver halves the
; table period.
MACRO snd_track ; the track label the snd_call offsets are relative to
REDEF _snd_track EQUS "\1"
ENDM

MACRO snd_note ; note, octave, length in ticks
	db ((\2) << 4) | (\1), \3
ENDM

MACRO snd_hold ; octave nibble (unused), length: keeps the sounding note, or silence
	db ((\1) << 4) | $0f, \2
ENDM

MACRO snd_noise ; noise value (< $10 indexes NoiseNoteTable, else raw), length
	db \1, \2
ENDM

MACRO snd_volume ; volume nibble (applied through the channel envelope)
	db $a0, \1
ENDM

MACRO snd_wave ; wave-pattern id (wave channel) / sweep register value (pulse)
	db $a1, \1
ENDM

MACRO snd_duty ; duty (pulse) / envelope length (wave)
	db $a2, \1
ENDM

MACRO snd_note_length ; note-length reload; $fe clears it
	db $a3, \1
ENDM

MACRO snd_detune ; signed note offset, bit 7 = active
	db $a4, \1
ENDM

MACRO snd_pan ; stereo mask; $01 swaps the current mask's nibbles
	db $a5, \1
ENDM

MACRO snd_master_volume ; written straight to rAUDVOL
	db $a6, \1
ENDM

MACRO snd_glide ; note timer without a key-on
	db $a7, \1
ENDM

MACRO snd_instrument ; instrument-envelope index (high nibble also picks the wave set)
	db $a8, \1
ENDM

MACRO snd_transpose ; semitones; $f0-$f3 step the channel/global transpose, $fe/$ff read a jump table
	db $a9, \1
ENDM

MACRO snd_echo ; echo count (high nibble) and note offset (low); 0 clears
	db $aa, \1
ENDM

MACRO snd_call ; count, target -- run the block at target `count` times, snd_return comes back here
	db $ac, \1
	dw (\2) - {_snd_track}
ENDM

MACRO snd_return
	db $ad, $00
ENDM

MACRO snd_tone_flag ; bit 4 selects the upper octave of NotePeriodTable
	db $ae, \1
ENDM

MACRO snd_length_nibble ; note-length increment, low nibble of hSndToneCtrl
	db $af, \1
ENDM

MACRO snd_loop_point ; slot 0-15: remembers the next command for snd_loop / snd_jump
	db $fd, $f0 | (\1)
ENDM

MACRO snd_loop ; count 1-15, slot: go back to the slot's point until the block has run count + 1 times
	db $b0 | (\1), $f0 | (\2)
ENDM

MACRO snd_jump ; slot: go back to the slot's point unconditionally
	db $b0, $f0 | (\1)
ENDM

MACRO snd_envelope ; rate 0-15, length: instrument-envelope sweep
	db $c0 | (\1), \2
ENDM

MACRO snd_volume_up ; step 0-15, period: volume slide up
	db $d0 | (\1), \2
ENDM

MACRO snd_volume_down ; step 0-15, period: volume slide down
	db $e0 | (\1), \2
ENDM

MACRO snd_end
	db $ff, $ff
ENDM

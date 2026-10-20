; Sound channel scripts (data/audio/<Track>.asm, generated at setup).

; A SoundTable entry's first word: which channel struct the track drives
; (StartSoundChannel indexes wSndChannels by the low byte, $20 per channel)
; and the SNDCHANTYPE_* it stores into that struct's hSndChannelType.
MACRO snd_channel
	db (\1) * $20, \2
ENDM

; A track opens with snd_header; every command after it is two bytes, opcode
; then operand, and the driver steps them by command index (RunSoundChannelScript; docs/sound_engine.md "Script
; command set"). snd_call is the one four-byte command: its target word is a
; byte offset from the track start that snd_track names. Note names C_ .. B_
; are in include/constants/; the octave is how many times the driver halves the
; table period.
MACRO snd_track ; the track label the snd_call offsets are relative to
REDEF _snd_track EQUS "\1"
ENDM

; tempo: low nibble = how many of every 16 engine ticks the channel skips
;        (0 = full speed; the high nibble is ignored)
; duty:  bits 0-1 = pulse duty; on the wave channel the envelope length
; volume: low nibble = level, high nibble = envelope flags (nonzero
;        disables snd_envelope)
; wave:  wave-pattern id (wave channel, read only on a fresh start), the
;        sweep register (pulse 1); unused elsewhere
MACRO snd_header ; tempo, duty, volume, wave
	db \1, \2, \3, \4
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

MACRO snd_vibrato ; depth 0-14 (a SoundPitchTable row; 15 is off), delay in ticks (even, 0-30)
	ASSERT (\2) % 2 == 0 && (\2) < 32 && (((\1) << 4) | ((\2) / 2)) != $fe, "snd_vibrato: delay is even, 0-30; 15, 28 is snd_vibrato_off"
	db $a3, ((\1) << 4) | ((\2) / 2)
ENDM

MACRO snd_vibrato_off
	db $a3, $fe
ENDM

MACRO snd_gate ; ticks: -n releases each note n ticks before its end (at least 1 in), n >= 0 after n ticks
	db $a4, LOW(\1)
ENDM

MACRO snd_pan ; stereo mask; $01 swaps the current mask's nibbles
	db $a5, \1
ENDM

MACRO snd_master_volume ; written straight to rAUDVOL
	db $a6, \1
ENDM

MACRO snd_wait ; ticks: hold for that long without a key-on, no slide
	db $a7, \1
ENDM

MACRO snd_instrument ; instrument-envelope index (high nibble also picks the wave set)
	db $a8, \1
ENDM

MACRO snd_switch ; < $80 sets the channel's switch, $80+ the global one; $f0-$f3 step them, $fe/$ff jump through the index table that follows
	db $a9, \1
ENDM

MACRO snd_echo ; ticks 0-15 (0 clears), volume scale 0-15: the last ticks of each note play at (scale + 1) / 16 volume
	db $aa, ((\1) << 4) | (\2)
ENDM

MACRO snd_call ; count, target -- run the block at target `count` times, snd_return comes back here
	db $ac, \1
	dw (\2) - {_snd_track}
ENDM

MACRO snd_return
	db $ad, $00
ENDM

MACRO snd_quarter_tone ; 1: notes come from NotePeriodTable's second half, a quarter tone higher
	db $ae, (\1) << 4
ENDM

MACRO snd_tempo ; 0-15: the header's tempo nibble
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

MACRO snd_envelope ; shape 1-15 (a SoundEnvelopes row; 0 is off), length: instrument envelope
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

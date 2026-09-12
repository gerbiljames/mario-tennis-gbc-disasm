SndSilenceChannel:
	call AbortIfChannelTriggered ; $3afa
	ld a, $00 ; $3afd
	jp ApplyChannelEnvelope ; $3aff
SndReleaseChannel:
	call AbortIfChannelTriggered ; $3b02
	ld a, [wSndChannelBits] ; $3b05
	cpl ; $3b08
	ld b, a ; $3b09
	ld a, [wSndPanShadow] ; $3b0a
	and b ; $3b0d
	ld [wSndPanShadow], a ; $3b0e
	ret ; $3b11
AbortIfChannelTriggered:
	ld a, [wSndChannelBits] ; $3b12
	ld b, a ; $3b15
	ld a, [wSndActiveMask] ; $3b16
	and b ; $3b19
	ret z ; $3b1a
	pop af ; $3b1b
	ret ; $3b1c
NotePeriodTable:
	; $3b1d, 48 bytes (words:1)
	dw $07d4 ; record 0
	dw $0764 ; record 1
	dw $06f9 ; record 2
	dw $0695 ; record 3
	dw $0637 ; record 4
	dw $05dd ; record 5
	dw $0589 ; record 6
	dw $053a ; record 7
	dw $04f0 ; record 8
	dw $04a8 ; record 9
	dw $0465 ; record 10
	dw $0426 ; record 11
	dw $079c ; record 12
	dw $072e ; record 13
	dw $06c7 ; record 14
	dw $0666 ; record 15
	dw $060a ; record 16
	dw $05b3 ; record 17
	dw $0561 ; record 18
	dw $0515 ; record 19
	dw $04cc ; record 20
	dw $0486 ; record 21
	dw $0445 ; record 22
	dw $0408 ; record 23
SoundChannelMaskTable:
	INCLUDE "data/bank_000/SoundChannelMaskTable.asm" ; $3b4d, 256 bytes (sound_data)
SoundPitchTable:
	INCLUDE "data/bank_000/SoundPitchTable.asm" ; $3c4d, 240 bytes (sound_data)
LoadWavePatternIfChanged:
	ld a, [wSndLoadedWaveId] ; $3d3d
	ld b, a ; $3d40
	ldh a, [hSndWaveId] ; $3d41
	cp b ; $3d43
	ret z ; $3d44
	ld [wSndLoadedWaveId], a ; $3d45
	ld e, a ; $3d48
	swap e ; $3d49
	xor a ; $3d4b
	ldh [rAUD3ENA], a ; $3d4c
LoadWavePattern:
	ld d, a ; $3d4e
	ld hl, WavePatternTable ; $3d4f
	push de ; $3d52
	ldh a, [hSndInstrument] ; $3d53
	swap a ; $3d55
	and $0f ; $3d57
	add a ; $3d59
	ld e, a ; $3d5a
	ld d, $00 ; $3d5b
	add hl, de ; $3d5d
	ld a, [hl+] ; $3d5e
	ld h, [hl] ; $3d5f
	ld l, a ; $3d60
	pop de ; $3d61
	add hl, de ; $3d62
	ld de, rAUD3WAVE_0 ; $3d63
	ld b, $10 ; $3d66
.loop:
	ld a, [hl+] ; $3d68
	ld [de], a ; $3d69
	inc de ; $3d6a
	dec b ; $3d6b
	jr nz, .loop ; $3d6c
	ret ; $3d6e
GetChannelLoopSlot:
	ld a, [wSndChannelIndex] ; $3d6f
	add a ; $3d72
	ld c, a ; $3d73
	add a ; $3d74
	add c ; $3d75
	add a ; $3d76
	ld c, a ; $3d77
	ld a, b ; $3d78
	and $0f ; $3d79
	ld b, a ; $3d7b
	add a ; $3d7c
	add b ; $3d7d
	add c ; $3d7e
	ld hl, wSndLoopSlots ; $3d7f
	add l ; $3d82
	ld l, a ; $3d83
	ld a, $00 ; $3d84
	adc h ; $3d86
	ld h, a ; $3d87
	ret ; $3d88
ScaleEchoVolume:
	push de ; $3d89
	push bc ; $3d8a
	ldh a, [hSndEcho] ; $3d8b
	and $0f ; $3d8d
	inc a ; $3d8f
	ld d, a ; $3d90
	ld bc, $0000 ; $3d91
	ldh a, [hSndVolume] ; $3d94
	swap a ; $3d96
	and $0f ; $3d98
	inc a ; $3d9a
	ld e, a ; $3d9b
.loop:
	ld a, e ; $3d9c
	add c ; $3d9d
	ld c, a ; $3d9e
	ld a, $00 ; $3d9f
	adc b ; $3da1
	ld b, a ; $3da2
	dec d ; $3da3
	jr nz, .loop ; $3da4
	srl b ; $3da6
	rr c ; $3da8
	srl b ; $3daa
	rr c ; $3dac
	srl b ; $3dae
	rr c ; $3db0
	srl b ; $3db2
	rr c ; $3db4
	ld a, c ; $3db6
	and a ; $3db7
	jr nz, .nonZero ; $3db8
	ld c, $01 ; $3dba
.nonZero:
	swap c ; $3dbc
	ldh a, [hSndVolume] ; $3dbe
	ld d, a ; $3dc0
	and $f0 ; $3dc1
	ld e, a ; $3dc3
	ldh a, [hSndEcho] ; $3dc4
	and $0f ; $3dc6
	or e ; $3dc8
	ldh [hSndEcho], a ; $3dc9
	ld a, d ; $3dcb
	and $0f ; $3dcc
	or c ; $3dce
	ldh [hSndVolume], a ; $3dcf
	pop bc ; $3dd1
	pop de ; $3dd2
	ret ; $3dd3
WavePatternTable:
	; $3dd4, 2 bytes (records:2)
	dw WavePatterns ; record 0
WavePatterns:
	; $3dd6, 256 bytes (bytes:16)
	db $00, $01, $12, $35, $8a, $cd, $ee, $ff, $ff, $fe, $ed, $ca, $85, $32, $11, $00 ; 0x00
	db $01, $23, $45, $67, $89, $ab, $cd, $ef, $fe, $dc, $ba, $98, $76, $54, $32, $10 ; 0x10
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x20
	db $ff, $ee, $dd, $cc, $bb, $aa, $99, $88, $77, $66, $55, $44, $33, $22, $11, $00 ; 0x30
	db $ff, $ff, $de, $bd, $24, $12, $00, $00, $00, $00, $21, $42, $db, $ed, $ff, $ff ; 0x40
	db $ff, $ff, $ee, $ca, $53, $11, $00, $00, $00, $00, $11, $35, $ac, $ee, $ff, $ff ; 0x50
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00, $00, $00, $ff, $00 ; 0x60
	db $00, $00, $66, $aa, $bb, $dd, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x70
	db $ff, $ff, $ee, $ed, $dd, $cc, $cb, $ba, $a9, $98, $87, $65, $54, $43, $31, $10 ; 0x80
	db $ff, $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $aa, $bb, $cc, $dd, $ee, $ff, $ff ; 0x90
	db $00, $00, $00, $00, $aa, $aa, $bb, $cc, $dd, $dd, $ff, $ff, $ff, $ff, $00, $ff ; 0xa0
	db $00, $00, $00, $00, $aa, $aa, $bb, $cc, $dd, $dd, $ff, $ff, $ff, $ff, $aa, $ff ; 0xb0
	db $01, $12, $22, $33, $35, $55, $77, $99, $55, $99, $aa, $bb, $cc, $dd, $ee, $ff ; 0xc0
	db $fc, $dc, $ba, $90, $70, $50, $30, $15, $15, $15, $15, $22, $55, $77, $aa, $cc ; 0xd0
	db $ee, $ee, $cd, $ac, $35, $23, $11, $11, $11, $11, $32, $53, $ca, $dc, $ee, $ee ; 0xe0
	db $dd, $dd, $dd, $dd, $dd, $dd, $dd, $dd, $22, $22, $22, $22, $22, $22, $22, $22 ; 0xf0
SoundEnvelopeTable:
	INCLUDE "data/bank_000/SoundEnvelopeTable.asm" ; $3ed6, 2 bytes (sound_data)
SoundEnvelopes:
	INCLUDE "data/bank_000/SoundEnvelopes.asm" ; $3ed8, 240 bytes (sound_data)
	; $3fc8, 56 bytes fill to bank end (linker-padded)

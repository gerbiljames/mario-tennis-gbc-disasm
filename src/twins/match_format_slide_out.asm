; One body under 2 names (banks $3b, $3e), assembled through
; `twin_named match_format_slide_out, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	ld a, b
	or a
	jr z, .zero
	ld c, $00
.loop:
	call AdvanceFrame
	ld b, $03
	farcall RestoreMenuBgAndDrawPanel
	ld b, $00
	farcall FlushWram3MapRows
	ld a, c
	inc a
	ld c, a
	cp $0b
	jr nz, .loop
	ret
.zero:
	ld c, $0d
.loopB:
	call AdvanceFrame
	ld b, $02
	farcall RestoreMenuBgAndDrawPanel
	ld b, $00
	farcall FlushWram3MapRows
	ld a, c
	dec a
	ld c, a
	or a
	jr nz, .loopB
	ret

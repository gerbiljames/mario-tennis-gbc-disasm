; Shared by MatchFormatSlideOut, CloseMatchRulesPanel (banks $3b, $3e).

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

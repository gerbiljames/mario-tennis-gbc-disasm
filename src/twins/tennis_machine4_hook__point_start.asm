; Shared by TennisMachine4Hook_PointStart,
; TennisMachineHighScoreHook_PointStart (bank $0d).

{TWIN_LABEL}:
	farcall AdvanceMatchRng
	and $07
	inc a
	ld hl, wMinigameFeederPos
	add [hl]
	cp $09
	jr c, .store
	sub $09
.store:
	ld [hl], a
	call LaunchMinigameServe
	ret

; Shared by TennisMachine1Hook_MinigameStart, TennisMachine2Hook_MinigameStart (bank $0d).

{TWIN_LABEL}:
	ld a, $01
	ld [wMinigameFeederPos], a
	call StartMinigameMatch
	ret

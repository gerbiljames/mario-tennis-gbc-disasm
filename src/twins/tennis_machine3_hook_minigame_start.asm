; Shared by TennisMachine3Hook_MinigameStart, TennisMachine4Hook_MinigameStart, TennisMachineHighScoreHook_MinigameStart (bank $0d).

{TWIN_LABEL}:
	ld a, $04
	ld [wMinigameServeSlot], a
	call StartMinigameMatch
	ret

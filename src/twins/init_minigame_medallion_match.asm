; Shared by InitMinigame_MedallionMatch, InitMinigame_ShootingStar, InitMinigame_TargetShot, InitMinigame_TreasureBox (bank $0d).

{TWIN_LABEL}:
	ld a, $01
	ld [wMinigameUsesTennisMachine], a
	ld a, [wMinigameLevel]
	cp $02
	jr nz, .done
	ld a, $01
	ld [wMinigameHighScoreMode], a
.done:
	ret

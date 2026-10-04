; Gates: what the effective inventory opens.

; e = MARIOGAME_* -> a = nonzero if its grid cell is open
ApMinigameUnlocked:
	ld a, [ApOptMinigames]
	cp AP_MINIGAMES_EXCLUDED
	ret z
	ld a, e
	add ITEM_BOO_BLAST
	ld e, a
	jp ApItemCount

; e = MARIOGAME_*, d = its levels 1 and 2 cleared (0-2) -> a = the count the
; level select works from: under progressive, the game's copies owned - 1
ApMinigameLevels:
	ld a, [ApOptMinigames]
	cp AP_MINIGAMES_PROGRESSIVE
	ld a, d
	ret nz
	ld a, e
	add ITEM_BOO_BLAST
	ld e, a
	call ApItemCount
	and a
	ret z
	dec a
	cp 3
	ret c
	ld a, 2
	ret

; Empties the N64 transfer record the slot carries (EXP and trophy counts
; the N64 game writes into the cart), so slot entry awards nothing from it.
ApClearN64Transfer:
	ld hl, wPendingExpStory
	ld c, wN64TrophyCounts + 2 - wPendingExpStory
	xor a
.clear:
	ld [hl+], a
	dec c
	jr nz, .clear
	ret

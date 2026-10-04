; Gates: what the effective inventory opens.

; d = item id, e = a count -> nz if the player holds at least that many
ApItemAtLeast:
	push de
	ld e, d
	call ApItemCount
	pop de
	cp e
	jr c, .no
	or 1
	ret
.no:
	xor a
	ret

; d = AP_ARC_*, e = a count -> nz if that arc's class pass count reaches it
ApPassAtLeast:
	ld a, d
	cp AP_ARC_ACTIVE
	jr nz, .arc
	test_flag FLAG_DOUBLES
	ld a, AP_ARC_SINGLES
	jr z, .arc
	ld a, AP_ARC_DOUBLES
.arc:
	push de
	add ITEM_SINGLES_PASS
	ld e, a
	call ApItemCount
	pop de
	cp e
	jr c, .no
	or 1
	ret
.no:
	xor a
	ret

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

; -> a = the STORYRANK_* the active arc's class pass presents: 2 * the pass
; count (at most 4), plus 1 in doubles
ApRankingProgressIndex:
	test_flag FLAG_DOUBLES
	ld e, ITEM_SINGLES_PASS
	jr z, .count
	ld e, ITEM_DOUBLES_PASS
.count:
	call ApItemCount
	cp 5
	jr c, .tier
	ld a, 4
.tier:
	add a
	ld b, a
	ld a, e
	sub ITEM_SINGLES_PASS
	add b
	ret

; b = a drill's match item, c = the drill's FLAG_CLEARED_*_MATCH_1 -> nz if
; its coach has no match to offer: the first match not cleared is past the
; item count + 1
ApDrillMatchLocked:
	ld d, 0
	ld e, c
	ld c, 0
.count:
	push bc
	push de
	call TestGameFlagByNumber
	pop de
	pop bc
	jr z, .found
	inc e
	inc c
	ld a, c
	cp 3
	jr c, .count
.found:
	push bc
	ld e, b
	call ApItemCount
	pop bc
	cp c
	jr c, .locked
	xor a
	ret
.locked:
	or 1
	ret

; d = a Wall Practice or Tennis Machine item, e = the room's stage (its first
; level not cleared) -> nz if the items do not reach it: level n needs n - 1
; items, Master and the high-score levels all four
ApStageLocked:
	ld a, e
	cp 4
	jr c, .count
	ld e, 4
.count:
	push de
	ld e, d
	call ApItemCount
	pop de
	cp e
	jr c, .locked
	xor a
	ret
.locked:
	or 1
	ret

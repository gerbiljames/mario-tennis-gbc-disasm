; Gates: what the effective inventory opens.

; Through ApTestInline: e = its first argument byte, d = its second. Tests
; an item count (ap_has) or, with AP_TEST_PASS, a class pass (ap_pass).
ApTestInlineFar:
	ld a, e
	ld e, d
	ld d, a
	bit 7, d
	jr z, ApItemAtLeast
	res 7, d
	jr ApPassAtLeast

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

; Before ApplyPendingExpAwards: empties the N64 transfer record the slot
; carries (trophy EXP and counts the N64 game writes into the cart), so
; nothing is awarded from it, and names the story-EXP award, where EXP
; bundles collect (wPendingExpStory), in its message line (text record 13).
ApPrepareExpAwards:
	ld hl, wPendingExpTrophy
	ld c, wN64TrophyCounts + 2 - wPendingExpTrophy
	xor a
.clear:
	ld [hl+], a
	dec c
	jr nz, .clear
	ld hl, ApTextExpAward
	ld de, wApMessage
.copy:
	ld a, [hl+]
	ld [de], a
	inc de
	and a
	jr nz, .copy
	ret

ApTextExpAward:
	db "Archipelago items.", 0

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

; Sets FLAG_DOUBLES as story_arcs forces it (nothing under both).
ApForceStoryArc:
	ld a, [ApOptStoryArcs]
	cp AP_ARCS_SINGLES
	jr z, .singles
	cp AP_ARCS_DOUBLES
	ret nz
	set_flag FLAG_DOUBLES
	ret
.singles:
	clear_flag FLAG_DOUBLES
	ret

; A new game's first location: forces the arc. -> nz if skip_intro is on.
ApStartNewGame:
	call ApForceStoryArc
	ld a, [ApOptSkipIntro]
	and a
	ret

; Before the pause menu's ApplyPendingExpAwards: when there is EXP to award,
; reloads the menu font the award screens draw with, which the pause menu's
; graphics overwrite.
ApLoadAwardFont:
	ld hl, wPendingExpStory
	ld a, [hl+]
	or [hl]
	ld hl, wPendingExpExhibition
	or [hl]
	inc hl
	or [hl]
	ld hl, wPendingExpLinked
	or [hl]
	inc hl
	or [hl]
	ret z
	call DisableLCDSafely
	farcall LoadMenuFontGfx
	jp EnableLCD

; The front gate's question, in wApMessage for AP_MESSAGE_TEXT
ApComposeGatePrompt:
	ld hl, ApTextGatePrompt
	ld de, wApMessage
.copy:
	ld a, [hl+]
	ld [de], a
	inc de
	and a
	jr nz, .copy
	ret

ApTextGatePrompt:
	db "Fly to the", AP_TEXT_LINE, "Island Open?", 0

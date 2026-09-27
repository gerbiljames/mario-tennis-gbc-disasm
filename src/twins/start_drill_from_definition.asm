; One body under 2 names (banks $0b, $0d), assembled through
; `twin_named start_drill_from_definition, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	ld hl, DRILLDEF_OPPONENT
	add hl, bc
	ld a, [hl]
	ld [wMatchOpponentChar], a
	ld hl, DRILLDEF_COURT
	add hl, bc
	ld a, [hl]
	ld [wCurrentlyUsedCourt], a
	ld hl, DRILLDEF_CHARS
	add hl, bc
	ld a, [hl]
	ld [wOnCourtCharCount], a
	ld hl, DRILLDEF_MODE
	add hl, bc
	ld a, [hl]
	ld [wGameMode], a
	ld a, MATCHLIST_TRAINING
	ld [wCurrentMinigameStoryMatch], a
	ld hl, DRILLDEF_MATCH
	add hl, bc
	ld a, [hl]
	ld [wCurrentMinigameStoryMatch + 1], a
	ld hl, DRILLDEF_BGM
	add hl, bc
	ld a, [hl]
	ld [wMatchBGM], a
	push bc
	ld hl, DRILLDEF_PLAYER
	add hl, bc
	ld b, [hl]
	ld c, $00
	farcall InitCa00RecordFromCharId
	ld a, [wStoryModeMainCharacterOverworldSprite]
	ld [wMatchPlayerChar], a
	ld a, [wMatchOpponentChar]
	cp CHAR_NONE
	jr z, .restore
	ld b, a
	ld c, $02
	farcall InitCa00RecordFromCharId
.restore:
	pop bc
	ld hl, DRILLDEF_HOOKS
	add hl, bc
	ld a, [hl+]
	ld d, [hl]
	ld e, a
	ldh a, [hRomBank]
	farcall SetModeHookTable
	ld hl, DRILLDEF_POINT_TABLE
	add hl, bc
	ld a, [hl+]
	ld d, [hl]
	ld e, a
	farcall SetMinigamePointTable
	ld hl, DRILLDEF_INIT
	add hl, bc
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	ld a, h
	or l
	jr z, .done
	call JumpToHL
.done:
	ret

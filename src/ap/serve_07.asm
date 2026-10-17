; Archipelago: the three serves' ball paths, with wBallHeight held below the
; nice-serve band for the lookup and the flag when the serve's item lacks
; its second copy (ApClampServeHeight), then put back.
ApServeBallPath:
	ld hl, wBallHeight
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	push hl
	apcall ApClampServeHeight
	ld a, [wCurrentShotType]
	cp SHOTTYPE_SERVE_SLICE
	jr z, .slice
	cp SHOTTYPE_SERVE_FLAT
	jr z, .flat
	farcall ShotBallPathServeTopspin
	jr .flag
.slice:
	farcall ShotBallPathServeSlice
	jr .flag
.flat:
	farcall ShotBallPathServeFlat
.flag:
	call SetSpecialShotFlagFromBallHeight
	pop hl
	ld a, l
	ld [wBallHeight], a
	ld a, h
	ld [wBallHeight + 1], a
	ret

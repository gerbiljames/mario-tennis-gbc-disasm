; Archipelago: the three serves' ball paths. When the serve's item lacks its
; second copy, ApClampServeHeight first lowers the ball below the nice-serve
; band, so the path, the flag and the ball agree on a band-20 contact.
ApServeBallPath:
	apcall ApClampServeHeight
	ld a, [wCurrentShotType]
	cp SHOTTYPE_SERVE_SLICE
	jr z, .slice
	cp SHOTTYPE_SERVE_FLAT
	jr z, .flat
	farcall ShotBallPathServeTopspin
	jp SetPowerServeFlagFromTossHeight
.slice:
	farcall ShotBallPathServeSlice
	jp SetPowerServeFlagFromTossHeight
.flat:
	farcall ShotBallPathServeFlat
	jp SetPowerServeFlagFromTossHeight

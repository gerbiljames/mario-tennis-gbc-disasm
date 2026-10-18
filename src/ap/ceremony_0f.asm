; Archipelago: skip_ceremony. From CheckIslandOpenVictoryTransition once the
; final is won: no fireworks or Awards Ceremony, only the congratulations
; artwork and credits it ends with, then on to the principal's congratulations
; as the ceremony goes. -> a = 1, the transition's result
ApSkipAwardsCeremony_0f:
	test_flag FLAG_DOUBLES
	jr nz, .doubles
	set_flag FLAG_AWARDS_CEREMONY_SEEN_SINGLES
	ld a, [wStoryModeGenderOfMainCharacter]
	add $04
	ld c, a
	jr .scene
.doubles:
	set_flag FLAG_AWARDS_CEREMONY_SEEN_DOUBLES
	ld a, [wStoryModeGenderOfMainCharacter]
	ld d, a
	sla a
	ld c, a
	ld a, [wStoryModeGenderOfPartnerCharacter]
	xor d
	or c
	ld c, a
.scene:
	push bc
	ld c, 1
	call BeginFadeOut
	call WaitFadeEnd
	pop bc
	ld b, $01
	farcall RunStorySceneByMode
	ld a, STORYLOC_ACADEMY_WING
	ld [wStoryModeCurrentLocation], a
	ld a, $0f
	ld [wStoryModeEntryPoint], a
	ld a, $ff
	ld [wUnusedExitTriggerIdMirror], a
	ld [wStoryModeExitTriggerRequest], a
	ld a, $01
	ret

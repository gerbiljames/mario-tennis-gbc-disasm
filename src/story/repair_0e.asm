TrainingGymRunner0AWaitWaypointClear:
	script_get_actor_state $0c ; $4c37
	ld c, l ; $4c3c
	ld b, h ; $4c3d
	ld hl, $000e ; $4c3e
	add hl, bc ; $4c41
	ld a, [hl+] ; $4c42
	ld d, [hl] ; $4c43
	ld e, a ; $4c44
	ld hl, wMapScratch + 2 ; $4c45
	ld a, e ; $4c48
	ld [hl+], a ; $4c49
	ld [hl], d ; $4c4a
	ld hl, $000c ; $4c4b
	add hl, bc ; $4c4e
	ld a, [hl+] ; $4c4f
	ld d, [hl] ; $4c50
	ld e, a ; $4c51
	ld hl, wMapScratch ; $4c52
	ld a, e ; $4c55
	ld [hl+], a ; $4c56
	ld [hl], d ; $4c57
	script_get_actor_state $0a ; $4c58
	ld c, l ; $4c5d
	ld b, h ; $4c5e
	ld hl, $000a ; $4c5f
	add hl, bc ; $4c62
	ld a, [hl+] ; $4c63
	ld d, [hl] ; $4c64
	ld e, a ; $4c65
	ld hl, wMapScratch + 6 ; $4c66
	ld a, e ; $4c69
	ld [hl+], a ; $4c6a
	ld [hl], d ; $4c6b
	ld hl, $0008 ; $4c6c
	add hl, bc ; $4c6f
	ld a, [hl+] ; $4c70
	ld d, [hl] ; $4c71
	ld e, a ; $4c72
	ld hl, wMapScratch + 4 ; $4c73
	ld a, e ; $4c76
	ld [hl+], a ; $4c77
	ld [hl], d ; $4c78
	jp UnusedTrainingGymRunner0CClearWaypoint.checkTimer ; $4c79
; TrainingGymRunner0AWaitWaypointClear with ten extra instructions that fetch actor $0a's state and `res 0` its +5 flag before returning -- the clear-and-return variant of the wait. Nothing calls it.
UnusedTrainingGymRunner0AClearWaypoint:
	script_get_actor_state $0a ; $4c7c
	ld c, l ; $4c81
	ld b, h ; $4c82
	ld hl, $0005 ; $4c83
	add hl, bc ; $4c86
	res 0, [hl] ; $4c87
	ld b, $00 ; $4c89
	ld a, $00 ; $4c8b
	ret ; $4c8d
	script_get_actor_state $0a ; $4c8e
	ld c, l ; $4c93
	ld b, h ; $4c94
	ld hl, $000e ; $4c95
	add hl, bc ; $4c98
	ld a, [hl+] ; $4c99
	ld d, [hl] ; $4c9a
	ld e, a ; $4c9b
	ld hl, wMapScratch + 2 ; $4c9c
	ld a, e ; $4c9f
	ld [hl+], a ; $4ca0
	ld [hl], d ; $4ca1
	ld hl, $000c ; $4ca2
	add hl, bc ; $4ca5
	ld a, [hl+] ; $4ca6
	ld d, [hl] ; $4ca7
	ld e, a ; $4ca8
	ld hl, wMapScratch ; $4ca9
	ld a, e ; $4cac
	ld [hl+], a ; $4cad
	ld [hl], d ; $4cae
	script_get_actor_state $0b ; $4caf
	ld c, l ; $4cb4
	ld b, h ; $4cb5
	ld hl, $000a ; $4cb6
	add hl, bc ; $4cb9
	ld a, [hl+] ; $4cba
	ld d, [hl] ; $4cbb
	ld e, a ; $4cbc
	ld hl, wMapScratch + 6 ; $4cbd
	ld a, e ; $4cc0
	ld [hl+], a ; $4cc1
	ld [hl], d ; $4cc2
	ld hl, $0008 ; $4cc3
	add hl, bc ; $4cc6
	ld a, [hl+] ; $4cc7
	ld d, [hl] ; $4cc8
	ld e, a ; $4cc9
	ld hl, wMapScratch + 4 ; $4cca
	ld a, e ; $4ccd
	ld [hl+], a ; $4cce
	ld [hl], d ; $4ccf
	jp UnusedTrainingGymRunner0CClearWaypoint.checkTimer ; $4cd0
; The same clear-and-return variant as UnusedTrainingGymRunner0AClearWaypoint for actor $0b. Nothing calls it.
UnusedTrainingGymRunner0BClearWaypoint:
	script_get_actor_state $0b ; $4cd3
	ld c, l ; $4cd8
	ld b, h ; $4cd9
	ld hl, $0005 ; $4cda
	add hl, bc ; $4cdd
	res 0, [hl] ; $4cde
	ld b, $00 ; $4ce0
	ld a, $00 ; $4ce2
	ret ; $4ce4
	script_get_actor_state $0b ; $4ce5
	ld c, l ; $4cea
	ld b, h ; $4ceb
	ld hl, $000e ; $4cec
	add hl, bc ; $4cef
	ld a, [hl+] ; $4cf0
	ld d, [hl] ; $4cf1
	ld e, a ; $4cf2
	ld hl, wMapScratch + 2 ; $4cf3
	ld a, e ; $4cf6
	ld [hl+], a ; $4cf7
	ld [hl], d ; $4cf8
	ld hl, $000c ; $4cf9
	add hl, bc ; $4cfc
	ld a, [hl+] ; $4cfd
	ld d, [hl] ; $4cfe
	ld e, a ; $4cff
	ld hl, wMapScratch ; $4d00
	ld a, e ; $4d03
	ld [hl+], a ; $4d04
	ld [hl], d ; $4d05
	script_get_actor_state $0c ; $4d06
	ld c, l ; $4d0b
	ld b, h ; $4d0c
	ld hl, $000a ; $4d0d
	add hl, bc ; $4d10
	ld a, [hl+] ; $4d11
	ld d, [hl] ; $4d12
	ld e, a ; $4d13
	ld hl, wMapScratch + 6 ; $4d14
	ld a, e ; $4d17
	ld [hl+], a ; $4d18
	ld [hl], d ; $4d19
	ld hl, $0008 ; $4d1a
	add hl, bc ; $4d1d
	ld a, [hl+] ; $4d1e
	ld d, [hl] ; $4d1f
	ld e, a ; $4d20
	ld hl, wMapScratch + 4 ; $4d21
	ld a, e ; $4d24
	ld [hl+], a ; $4d25
	ld [hl], d ; $4d26
	jp UnusedTrainingGymRunner0CClearWaypoint.checkTimer ; $4d27
UnusedTrainingGymRunner0CClearWaypoint:
	script_get_actor_state $0c ; $4d2a
	ld c, l ; $4d2f
	ld b, h ; $4d30
	ld hl, $0005 ; $4d31
	add hl, bc ; $4d34
	res 0, [hl] ; $4d35
	ld b, $00 ; $4d37
	ld a, $00 ; $4d39
	ret ; $4d3b
.checkTimer:
	ld hl, wMapScratch + 2 ; $4d3c
	ld a, [hl+] ; $4d3f
	ld d, [hl] ; $4d40
	ld e, a ; $4d41
	ld hl, wMapScratch + 6 ; $4d42
	ld a, [hl+] ; $4d45
	ld h, [hl] ; $4d46
	ld l, a ; $4d47
	ld a, l ; $4d48
	sub e ; $4d49
	ld l, a ; $4d4a
	ld a, h ; $4d4b
	sbc d ; $4d4c
	ld h, a ; $4d4d
	bit 7, h ; $4d4e
	jr z, .checkX ; $4d50
	xor a ; $4d52
	sub l ; $4d53
	ld l, a ; $4d54
	sbc a ; $4d55
	sub h ; $4d56
	ld h, a ; $4d57
.checkX:
	ld a, h ; $4d58
	cp $05 ; $4d59
	jr nc, .outOfRange ; $4d5b
	ld hl, wMapScratch ; $4d5d
	ld a, [hl+] ; $4d60
	ld d, [hl] ; $4d61
	ld e, a ; $4d62
	ld hl, wMapScratch + 4 ; $4d63
	ld a, [hl+] ; $4d66
	ld h, [hl] ; $4d67
	ld l, a ; $4d68
	ld a, l ; $4d69
	sub e ; $4d6a
	ld l, a ; $4d6b
	ld a, h ; $4d6c
	sbc d ; $4d6d
	ld h, a ; $4d6e
	bit 7, h ; $4d6f
	jr z, .checkDepth ; $4d71
	xor a ; $4d73
	sub l ; $4d74
	ld l, a ; $4d75
	sbc a ; $4d76
	sub h ; $4d77
	ld h, a ; $4d78
.checkDepth:
	ld a, h ; $4d79
	cp $05 ; $4d7a
	jr nc, .outOfRange ; $4d7c
	ld b, $01 ; $4d7e
	ld a, $01 ; $4d80
	ret ; $4d82
.outOfRange:
	ld b, $00 ; $4d83
	ld a, $00 ; $4d85
	ret ; $4d87
RunRepairCounterDialogue:
	script_face_toward ACTOR_PLAYER, $0e ; $4d88
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $4d90
	jp z, .greeting ; $4d93
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $4d96
	jp z, .noRepair ; $4d99
	test_flag FLAG_WON_VARSITY_SINGLES_RANK_4 ; $4d9c
	jp z, .repairMenu ; $4d9f
	jp .repairMenu ; $4da2
.greeting:
	test_flag FLAG_DOUBLES ; $4da5
	jr nz, .doublesGreeting ; $4da8
	test_flag FLAG_REPAIR_COUNTER_GREETED ; $4daa
	jr z, .firstGreeting ; $4dad
	script_set_text Text_6e_228 ; $4daf
	jr .speak ; $4db5
.firstGreeting:
	script_set_text Text_6e_227 ; $4db7
	set_flag FLAG_REPAIR_COUNTER_GREETED ; $4dbd
.speak:
	script_speak $0e ; $4dc0
	script_face $0e, FACE_RIGHT ; $4dc5
	ret ; $4dcc
.doublesGreeting:
	test_flag FLAG_REPAIR_COUNTER_GREETED ; $4dcd
	jr z, .firstDoublesGreeting ; $4dd0
	script_set_text Text_6e_230 ; $4dd2
	jr .speak ; $4dd8
.firstDoublesGreeting:
	script_set_text Text_6e_229 ; $4dda
	set_flag FLAG_REPAIR_COUNTER_GREETED ; $4de0
	jr .speak ; $4de3
.repairMenu:
	set_flag FLAG_HAVE_LARGE_RACKET ; $4de5
	set_flag FLAG_HAVE_SMALL_RACKET ; $4de8
	set_flag FLAG_HAVE_LIGHT_SHOES ; $4deb
	script_set_text Text_6e_233 ; $4dee
	jr .done ; $4df4
	set_flag FLAG_HAVE_LARGE_RACKET ; $4df6
	set_flag FLAG_HAVE_SMALL_RACKET ; $4df9
	set_flag FLAG_HAVE_LIGHT_SHOES ; $4dfc
	set_flag FLAG_HAVE_IRON_RACKET ; $4dff
	set_flag FLAG_HAVE_IRON_SHOES ; $4e02
	script_set_text Text_6e_233 ; $4e05
	jr .done ; $4e0b
.noRepair:
	set_flag FLAG_HAVE_LARGE_RACKET ; $4e0d
	test_flag FLAG_REPAIR_COUNTER_EQUIP_CHANGED ; $4e10
	jr z, .repaired ; $4e13
	script_set_text Text_6e_233 ; $4e15
	jr .done ; $4e1b
.repaired:
	script_set_text Text_6e_231 ; $4e1d
	set_flag FLAG_REPAIR_COUNTER_EQUIP_CHANGED ; $4e23
.done:
	script_face_toward ACTOR_PLAYER, $0e ; $4e26
	ld a, $0e ; $4e2e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4e30
	farcall RunDialogueYesNoPrompt ; $4e33
	farcall ScriptCloseDialogueWindow ; $4e36
	script_wait_frames $05 ; $4e39
	and a ; $4e40
	jr z, RepairCounterFarewell.altLine ; $4e41
RepairCounterFarewell:
	script_set_text Text_6e_234 ; $4e43
	script_speak $0e ; $4e49
	ret ; $4e4e
.altLine:
	script_set_text Text_6e_235 ; $4e4f
	script_speak $0e ; $4e55
	script_wait_frames $05 ; $4e5a
RepairCounterServiceMenu:
	ld hl, Text_6e_236 ; $4e61
	ld de, $0101 ; $4e64
	farcall RunMenuFromText ; $4e67
.loop:
	ld [wMapScratch + 10], a ; $4e6a
	cp $ff ; $4e6d
	jp z, RepairCounterFarewell ; $4e6f
	cp $02 ; $4e72
	jp z, RepairCounterFarewell ; $4e74
	cp $00 ; $4e77
	jp z, RepairCounterChangeRackets ; $4e79
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $4e7c
	jp nz, RepairCounterChangeShoes ; $4e7f
	script_set_text Text_6e_232 ; $4e82
	script_speak $0e ; $4e88
	script_set_text Text_6e_242 ; $4e8d
	ld a, $0e ; $4e93
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4e95
	farcall RunDialogueYesNoPrompt ; $4e98
	farcall ScriptCloseDialogueWindow ; $4e9b
	script_wait_frames $05 ; $4e9e
	and a ; $4ea5
	jr z, RepairCounterServiceMenu ; $4ea6
	jr RepairCounterFarewell ; $4ea8
	script_face $0e, FACE_RIGHT ; $4eaa
	ret ; $4eb1
PrepareEquipmentSelectScreen:
	ld a, [wEquippedRacket] ; $4eb2
	ld [wMapScratch + 8], a ; $4eb5
	ld a, STORYLOC_TRAINING_CENTER ; $4eb8
	ld [wStoryModeCurrentLocation], a ; $4eba
	ld a, [wMapSceneStage2] ; $4ebd
	ld [wStoryModeEntryPoint], a ; $4ec0
	ld a, $ff ; $4ec3
	ld [wUnusedExitTriggerIdMirror], a ; $4ec5
	ld [wStoryModeExitTriggerRequest], a ; $4ec8
	ld c, $10 ; $4ecb
	call BeginFadeOut ; $4ecd
	call WaitFadeEnd ; $4ed0
	call ClearFrameTasks ; $4ed3
	call DisableLCDSafely ; $4ed6
	farcall LoadMenuFontGfx ; $4ed9
	xor a ; $4edc
	ldh [hBGColumnBlitPending], a ; $4edd
	ldh [hBGRowBlitPending], a ; $4edf
	ldh [hScrollY], a ; $4ee1
	ldh [hScrollX], a ; $4ee3
	ld [wCameraX + 1], a ; $4ee5
	ret ; $4ee8
RepairCounterChangeRackets:
	script_set_text Text_6e_237 ; $4ee9
	script_speak $0e ; $4eef
	call PrepareEquipmentSelectScreen ; $4ef4
	farcall RunRacketSelectScreen ; $4ef7
	and a ; $4efa
	jr nz, RestoreScreenAfterEquipSelect.advanceStage ; $4efb
	jr RestoreScreenAfterEquipSelect ; $4efd
RepairCounterChangeShoes:
	script_set_text Text_6e_238 ; $4eff
	script_speak $0e ; $4f05
	call PrepareEquipmentSelectScreen ; $4f0a
	farcall RunShoesSelectScreen ; $4f0d
	and a ; $4f10
	jr nz, RestoreScreenAfterEquipSelect.advanceStage ; $4f11
RestoreScreenAfterEquipSelect:
	call DisableLCDSafely ; $4f13
	farcall LoadMenuFontGfx ; $4f16
	call EnableLCD ; $4f19
	ret ; $4f1c
.advanceStage:
	ld a, [wMapSceneStage2] ; $4f1d
	add $02 ; $4f20
	ld [wMapSceneStage2], a ; $4f22
	ld a, STORYLOC_TRAINING_CENTER ; $4f25
	ld [wStoryModeCurrentLocation], a ; $4f27
	ld a, [wMapSceneStage2] ; $4f2a
	ld [wStoryModeEntryPoint], a ; $4f2d
	ld a, $ff ; $4f30
	ld [wUnusedExitTriggerIdMirror], a ; $4f32
	ld [wStoryModeExitTriggerRequest], a ; $4f35
	call RestoreScreenAfterEquipSelect ; $4f38
	ret ; $4f3b
FetchAndPushShortTextArg:
	push_wram_bank $07 ; $4f3c
	ld de, wTextArgFetchBuffer ; $4f45
	wram_bank $05 ; $4f48
	farcall FetchShortTextToBuffer ; $4f4e
	ld hl, wTextArgFetchBuffer ; $4f51
	farcall PushTextArgString ; $4f54
	pop_wram_bank ; $4f57
	ret ; $4f5c
GetEquippedRacketNibble:
	ld a, [wMapScratch + 10] ; $4f5d
	and a ; $4f60
	jr z, .lowNibble ; $4f61
	jr .highNibble ; $4f63
.lowNibble:
	ld a, [wEquippedRacket] ; $4f65
	and $0f ; $4f68
	ret ; $4f6a
.highNibble:
	ld a, [wEquippedRacket] ; $4f6b
	and $f0 ; $4f6e
	swap a ; $4f70
	ret ; $4f72
PushEquipmentNameTextArg:
	ld a, [wMapScratch + 10] ; $4f73
	and a ; $4f76
	jr z, .racket ; $4f77
	jr .shoes ; $4f79
.racket:
	call GetEquippedRacketNibble ; $4f7b
	ld hl, $00e5 ; $4f7e
	add l ; $4f81
	ld l, a ; $4f82
	jr nc, .pushRacket ; $4f83
	inc h ; $4f85
.pushRacket:
	call FetchAndPushShortTextArg ; $4f86
	ret ; $4f89
.shoes:
	call GetEquippedRacketNibble ; $4f8a
	ld hl, $00f4 ; $4f8d
	add l ; $4f90
	ld l, a ; $4f91
	jr nc, .pushShoes ; $4f92
	inc h ; $4f94
.pushShoes:
	call FetchAndPushShortTextArg ; $4f95
	ret ; $4f98
InitEquipmentHandoutDialogue:
	ld a, [wMapScratch + 10] ; $4f99
	and a ; $4f9c
	jr z, .racket ; $4f9d
	jr .shoes ; $4f9f
.racket:
	call GetEquippedRacketNibble ; $4fa1
	ld hl, $2403 ; $4fa4
	add l ; $4fa7
	ld l, a ; $4fa8
	jr nc, .setRacketCursor ; $4fa9
	inc h ; $4fab
.setRacketCursor:
	farcall InitDialogueTextCursor ; $4fac
	ret ; $4faf
.shoes:
	call GetEquippedRacketNibble ; $4fb0
	ld hl, $240a ; $4fb3
	add l ; $4fb6
	ld l, a ; $4fb7
	jr nc, .setShoesCursor ; $4fb8
	inc h ; $4fba
.setShoesCursor:
	farcall InitDialogueTextCursor ; $4fbb
	ret ; $4fbe
RepairCounterReturnA:
	ld a, $0b ; $4fbf
	ld [wMapSceneStage2], a ; $4fc1
	script_face_toward ACTOR_PLAYER, $0e ; $4fc4
	script_set_position ACTOR_PARTNER, $0f00, $0f00 ; $4fcc
	jp RepairCounterCheckEquipChanged ; $4fd7
	ret ; $4fda
RepairCounterReturnB:
	ld a, $0c ; $4fdb
	ld [wMapSceneStage2], a ; $4fdd
	farcall WaitPlayerMoveDone ; $4fe0
	script_player_speed $00f0 ; $4fe3
	script_move_player $0d00, $1100 ; $4fe9
	farcall WaitPlayerMoveDone ; $4ff3
	script_set_position ACTOR_PARTNER, $1300, $1300 ; $4ff6
	jp RepairCounterCheckEquipChanged ; $5001
	ret ; $5004

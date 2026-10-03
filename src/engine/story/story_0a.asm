SetSinglesRankingClearFlags:
	ld c, $09 ; $4e0e
	ld de, $0a00 ; $4e10
.clearLoop:
	push de ; $4e13
	call ClearGameFlag ; $4e14
	pop de ; $4e17
	ld hl, $0020 ; $4e18
	add hl, de ; $4e1b
	ld d, h ; $4e1c
	ld e, l ; $4e1d
	dec c ; $4e1e
	jr nz, .clearLoop ; $4e1f
	ld a, [wClearStatusFormat] ; $4e21
	or a ; $4e24
	jr z, .haveLevel ; $4e25
	ld a, [wClearStatusRank] ; $4e27
.haveLevel:
	ld b, a ; $4e2a
	ld a, [wClearStatusClass] ; $4e2b
	ld c, a ; $4e2e
	add a ; $4e2f
	add a ; $4e30
	add c ; $4e31
	ld c, a ; $4e32
	ld a, b ; $4e33
	add c ; $4e34
	ld c, a ; $4e35
	inc c ; $4e36
	ld hl, SinglesRankingClearFlagList_0a ; $4e37
.setLoop:
	ld a, [hl+] ; $4e3a
	ld d, [hl] ; $4e3b
	ld e, a ; $4e3c
	inc hl ; $4e3d
	dec c ; $4e3e
	jr z, .done ; $4e3f
	ld a, d ; $4e41
	or e ; $4e42
	jr z, .setLoop ; $4e43
	call SetGameFlag ; $4e45
	jr .setLoop ; $4e48
.done:
	ret ; $4e4a
SinglesRankingClearFlagList_0a:
	; $4e4b, 42 bytes (flag_ids)
	dw $0000 ; 0: none
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_4 ; 1
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_3 ; 2
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_2 ; 3
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_1 ; 4
	dw $0000 ; 5: none
	flag_id FLAG_WON_SENIOR_SINGLES_RANK_4 ; 6
	flag_id FLAG_WON_SENIOR_SINGLES_RANK_3 ; 7
	flag_id FLAG_WON_SENIOR_SINGLES_RANK_2 ; 8
	flag_id FLAG_WON_SENIOR_SINGLES_RANK_1 ; 9
	dw $0000 ; 10: none
	flag_id FLAG_WON_VARSITY_SINGLES_RANK_4 ; 11
	dw $0000 ; 12: none
	dw $0000 ; 13: none
	dw $0000 ; 14: none
	dw $0000 ; 15: none
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; 16
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; 17
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; 18
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; 19
	dw $ffff ; 20: end
SetDoublesRankingClearFlags:
	ld c, $09 ; $4e75
	ld de, $0a00 ; $4e77
.clearLoop:
	push de ; $4e7a
	call ClearGameFlag ; $4e7b
	pop de ; $4e7e
	ld hl, $0020 ; $4e7f
	add hl, de ; $4e82
	ld d, h ; $4e83
	ld e, l ; $4e84
	dec c ; $4e85
	jr nz, .clearLoop ; $4e86
	ld a, [wClearStatusClass] ; $4e88
	add a ; $4e8b
	add a ; $4e8c
	ld c, a ; $4e8d
	ld a, [wClearStatusRank] ; $4e8e
	add c ; $4e91
	ld c, a ; $4e92
	inc c ; $4e93
	ld hl, DoublesRankingClearFlagList_0a ; $4e94
.setLoop:
	ld a, [hl+] ; $4e97
	ld d, [hl] ; $4e98
	ld e, a ; $4e99
	inc hl ; $4e9a
	dec c ; $4e9b
	jr z, .done ; $4e9c
	ld a, d ; $4e9e
	or e ; $4e9f
	jr z, .setLoop ; $4ea0
	call SetGameFlag ; $4ea2
	jr .setLoop ; $4ea5
.done:
	ret ; $4ea7
DoublesRankingClearFlagList_0a:
	; $4ea8, 34 bytes (flag_ids)
	dw $0000 ; 0: none
	flag_id FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; 1
	flag_id FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; 2
	flag_id FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; 3
	dw $0000 ; 4: none
	flag_id FLAG_WON_SENIOR_DOUBLES_RANK_3 ; 5
	flag_id FLAG_WON_SENIOR_DOUBLES_RANK_2 ; 6
	flag_id FLAG_WON_SENIOR_DOUBLES_RANK_1 ; 7
	dw $0000 ; 8: none
	flag_id FLAG_WON_VARSITY_DOUBLES_RANK_2 ; 9
	dw $0000 ; 10: none
	dw $0000 ; 11: none
	dw $0000 ; 12: none
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; 13
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; 14
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; 15
	dw $ffff ; 16: end
GetClearStatusResultCode:
	ld hl, ClearStatusResultCodeIndexTable ; $4eca
	ld a, [wClearStatusFormat] ; $4ecd
	ld b, a ; $4ed0
	or a ; $4ed1
	jr z, .doublesRow ; $4ed2
	ld a, [wClearStatusClass] ; $4ed4
	inc a ; $4ed7
	inc a ; $4ed8
	add a ; $4ed9
	ld b, a ; $4eda
	ld a, [wClearStatusDoubles] ; $4edb
	jr .index ; $4ede
.doublesRow:
	ld a, [wClearStatusRank] ; $4ee0
.index:
	add b ; $4ee3
	add l ; $4ee4
	ld l, a ; $4ee5
	jr nc, .read ; $4ee6
	inc h ; $4ee8
.read:
	ld a, [hl] ; $4ee9
	ld [wClearStatusResultCode], a ; $4eea
	ret ; $4eed
ClearStatusResultCodeIndexTable:
	; $4eee, 10 bytes (bytes:10)
	db $01, $02, $03, $00, $04, $05, $06, $06, $07, $07 ; 0x00
ClearStatusSetupMenuEntry:
	call RunClearStatusSetupMenu ; $4ef8
	ret ; $4efb
DrawPlayerPositionDebugOverlay:
	test_flag FLAG_DEBUG_SHOW_PLAYER_POS ; $4efc
	jr z, .done ; $4eff
	wram_bank WRAM_ACTORS ; $4f01
	ld hl, wStoryModePlayersXPosition ; $4f07
	ld a, [hl+] ; $4f0a
	ld h, [hl] ; $4f0b
	ld l, a ; $4f0c
	push hl ; $4f0d
	push de ; $4f0e
	ld h, h ; $4f0f
	ld l, l ; $4f10
	ld_cell de, $10, $00 ; $4f11
	call PrintHexWord ; $4f14
	pop de ; $4f17
	pop hl ; $4f18
	ld hl, wStoryModePlayersYPosition ; $4f19
	ld a, [hl+] ; $4f1c
	ld h, [hl] ; $4f1d
	ld l, a ; $4f1e
	push hl ; $4f1f
	push de ; $4f20
	ld h, h ; $4f21
	ld l, l ; $4f22
	ld_cell de, $10, $01 ; $4f23
	call PrintHexWord ; $4f26
	pop de ; $4f29
	pop hl ; $4f2a
.done:
	ret ; $4f2b
RunStoryModeOverworld:
	xor a ; $4f2c
	ld [wOverworldEnterFlag], a ; $4f2d
.restart:
	call ClearFrameTasks ; $4f30
	ld a, $01 ; $4f33
	ld hl, DrawPlayerPositionDebugOverlay ; $4f35
	call RegisterFrameTask ; $4f38
	call RunStoryLocation ; $4f3b
	jr .restart ; $4f3e
RunStoryLocation:
	push af ; $4f40
	push bc ; $4f41
	push de ; $4f42
	push hl ; $4f43
	ld c, $0c ; $4f44
	call BeginFadeOut ; $4f46
	call ClearTemporaryStoryFlags ; $4f49
	call ClearStoryEventRequests ; $4f4c
	call LoadStoryLocationHeader ; $4f4f
	call LoadStoryEntryPointRecord ; $4f52
	ld a, GAMEMODE_NONE ; $4f55
	ld [wGameMode], a ; $4f57
	call AdvanceFrame ; $4f5a
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $4f5d
	jr nz, .loadLocation ; $4f60
	ld a, [wStoryLocationBGM] ; $4f62
	cp $ff ; $4f65
	jr z, .loadLocation ; $4f67
	ld a, [wStoryLocationBGM] ; $4f69
	call PlaySoundManaged ; $4f6c
.loadLocation:
	farcall ResetTextWindowState ; $4f6f
	ld hl, wMapActorsPtr ; $4f72
	ld a, [hl+] ; $4f75
	ld h, [hl] ; $4f76
	ld l, a ; $4f77
	ld a, [wStoryLocationBank] ; $4f78
	call InitLocationActors ; $4f7b
	ld hl, wActors ; $4f7e
	ld de, $0018 ; $4f81
	add hl, de ; $4f84
	ld [hl], $01 ; $4f85
	set_flag FLAG_HIDE_OVERWORLD_ACTORS ; $4f87
	call WaitFadeEnd ; $4f8a
	clear_flag FLAG_HIDE_OVERWORLD_ACTORS ; $4f8d
	farcall LoadStoryObjPalettes ; $4f90
	call DisableLCDSafely ; $4f93
	farcall ResetTextWindowState ; $4f96
	farcall InitSceneScroll ; $4f99
	ld a, [wStoryLocationScene] ; $4f9c
	farcall LoadStorySceneGraphics ; $4f9f
	ld a, $00 ; $4fa2
	farcall CopyScrolledSceneTilemapToVram ; $4fa4
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $4fa7
	jr nz, .enableLcd ; $4faa
	farcall LoadMenuFontGfx ; $4fac
.enableLcd:
	call EnableLCD ; $4faf
	ld a, [wStoryArrivalScript] ; $4fb2
	ld l, a ; $4fb5
	ld a, [wStoryArrivalScript + 1] ; $4fb6
	ld h, a ; $4fb9
	ld a, h ; $4fba
	or l ; $4fbb
	jr z, .runInitScript ; $4fbc
	ld a, [wStoryLocationBank] ; $4fbe
	call CallHLInBankA ; $4fc1
.runInitScript:
	call RunLocationInitScript ; $4fc4
	ld hl, wStoryModeExitTriggerRequest ; $4fc7
	ld a, [hl] ; $4fca
	and a ; $4fcb
	jr z, .fadeIn ; $4fcc
	ld [hl], $00 ; $4fce
	call RunLocationExit ; $4fd0
	jp .done ; $4fd3
.fadeIn:
	script_fade_in $08 ; $4fd6
	call WaitFadeEnd ; $4fdb
	ld a, [wStoryModeShowLocationName] ; $4fde
	and a ; $4fe1
	jr z, .noNamePopup ; $4fe2
	ld a, [wStoryModeLocationNameTextId] ; $4fe4
	ld l, a ; $4fe7
	ld a, [wStoryModeLocationNameTextId + 1] ; $4fe8
	ld h, a ; $4feb
	call ShowLocationNamePopup ; $4fec
	jr .frameLoop ; $4fef
.noNamePopup:
	wait_frames 4 ; $4ff1
.frameLoop:
	wram_bank WRAM_ACTORS ; $4ff5
	call CheckStoryEventRequests ; $4ffb
	and a ; $4ffe
	jp z, .waitForEvent ; $4fff
	ld bc, wActors ; $5002
	ld hl, ActorScript_0a ; $5005
	ldh a, [hRomBank] ; $5008
	farcall SetActorScript ; $500a
	ld hl, wActors ; $500d
	ld de, $0018 ; $5010
	add hl, de ; $5013
	ld [hl], $01 ; $5014
	ld hl, wStoryModeTriggerScript ; $5016
	ld a, [hl] ; $5019
	and a ; $501a
	jr z, .checkExit ; $501b
	ld [hl], $00 ; $501d
	call RunQueuedTriggerScript ; $501f
.checkExit:
	ld hl, wStoryModeExitTriggerRequest ; $5022
	ld a, [hl] ; $5025
	and a ; $5026
	jr z, .checkMenu ; $5027
	ld [hl], $00 ; $5029
	call RunLocationExit ; $502b
	jp .done ; $502e
.checkMenu:
	ld hl, wStoryModeMenuRequest ; $5031
	ld a, [hl] ; $5034
	and a ; $5035
	jr z, .checkInteract ; $5036
	ld [hl], $00 ; $5038
	call WaitPlayerMoveDone ; $503a
	test_flag FLAG_STORY_MENU_LOCKED ; $503d
	jr nz, .checkInteract ; $5040
	farcall RunStoryModeMenu ; $5042
	jp .frameLoop ; $5045
.checkInteract:
	xor a ; $5048
	ld [wStoryAutoInteractFired], a ; $5049
	ld hl, wStoryAutoInteractArmed ; $504c
	ld a, [hl] ; $504f
	and a ; $5050
	jr z, .runInteract ; $5051
	ld [hl], $00 ; $5053
	wram_bank WRAM_ACTORS ; $5055
	ld a, [wPlayerMoveAngleApplied] ; $505b
	and a ; $505e
	jr z, .runInteract ; $505f
	ld hl, wPlayerMoveAnglePrev ; $5061
	ld a, [wPlayerMoveAngleApplied] ; $5064
	cp [hl] ; $5067
	jr nz, .runInteract ; $5068
	ld hl, wPlayerMoving ; $506a
	ld a, [hl] ; $506d
	cp $1e ; $506e
	jr c, .runInteract ; $5070
	ld [hl], $00 ; $5072
	ld hl, wStoryAutoInteractFired ; $5074
	ld [hl], $ff ; $5077
	ld hl, wStoryModeInteractRequest ; $5079
	ld [hl], $01 ; $507c
.runInteract:
	xor a ; $507e
	ld [wStoryScriptRan], a ; $507f
	ld hl, wStoryModeInteractRequest ; $5082
	ld a, [hl] ; $5085
	and a ; $5086
	jr z, .nextFrame ; $5087
	ld [hl], $00 ; $5089
	call FindActorFacingPlayer ; $508b
	and a ; $508e
	jr z, .checkFacingTile ; $508f
	call RunNpcInteraction ; $5091
	ld a, [wStoryScriptRan] ; $5094
	and a ; $5097
	jr nz, .nextFrame ; $5098
.checkFacingTile:
	call GetFacingTileInteractionId ; $509a
	and a ; $509d
	jr z, .checkTileTrigger ; $509e
	call RunFacingTileScript ; $50a0
	ld a, [wStoryScriptRan] ; $50a3
	and a ; $50a6
	jr nz, .nextFrame ; $50a7
.checkTileTrigger:
	call GetTileTriggerAtPlayer ; $50a9
	and a ; $50ac
	jr z, .checkDebugMenu ; $50ad
	call RunTileTriggerScript ; $50af
	jr .nextFrame ; $50b2
.checkDebugMenu:
	ld a, [wStoryAutoInteractFired] ; $50b4
	and a ; $50b7
	jr nz, .nextFrame ; $50b8
	ldh a, [hDebugStepMode] ; $50ba
	and a ; $50bc
	jr z, .nextFrame ; $50bd
	call WaitPlayerMoveDone ; $50bf
	farcall RunDebugMenu ; $50c2
	jr .nextFrame ; $50c5
.nextFrame:
	jp .frameLoop ; $50c7
.waitForEvent:
	call WaitFadeEnd ; $50ca
	ld bc, wActors ; $50cd
	farcall AttachActorControllerScript ; $50d0
.eventWaitLoop:
	call AdvanceFrame ; $50d3
	call CheckStoryEventRequests ; $50d6
	and a ; $50d9
	jr z, .eventWaitLoop ; $50da
	jp .frameLoop ; $50dc
.done:
	pop hl ; $50df
	pop de ; $50e0
	pop bc ; $50e1
	pop af ; $50e2
	ret ; $50e3
ClearTemporaryStoryFlags:
	push af ; $50e4
	push hl ; $50e5
	ld hl, wGameFlagsTemp ; $50e6
	xor a ; $50e9
	ld [hl+], a ; $50ea
	ld [hl+], a ; $50eb
	ld [hl+], a ; $50ec
	ld [hl+], a ; $50ed
	pop hl ; $50ee
	pop af ; $50ef
	ret ; $50f0
ClearStoryEventRequests:
	push af ; $50f1
	push bc ; $50f2
	push de ; $50f3
	push hl ; $50f4
	ld hl, wStoryModeTriggerScript ; $50f5
	ld b, $06 ; $50f8
	xor a ; $50fa
.clearLoop:
	ld [hl+], a ; $50fb
	dec b ; $50fc
	jr nz, .clearLoop ; $50fd
	pop hl ; $50ff
	pop de ; $5100
	pop bc ; $5101
	pop af ; $5102
	ret ; $5103
CheckStoryEventRequests:
	push bc ; $5104
	push hl ; $5105
	ld hl, wStoryModeTriggerScript ; $5106
	ld b, $06 ; $5109
	xor a ; $510b
.orLoop:
	or [hl] ; $510c
	inc hl ; $510d
	dec b ; $510e
	jr nz, .orLoop ; $510f
	pop hl ; $5111
	pop bc ; $5112
	ret ; $5113
LoadStoryLocationHeader:
	push af ; $5114
	push bc ; $5115
	push de ; $5116
	push hl ; $5117
	ld a, [wStoryModeCurrentLocation] ; $5118
	call GetStoryLocationRecordPtr ; $511b
	jr .readHeader ; $511e
.readHeader:
	ld de, wStoryModeCurrentLocation ; $5120
	ld bc, $0006 ; $5123
	call CopyMemoryBC ; $5126
	ld hl, wStoryLocationMapScriptsSlot ; $5129
	ld a, [hl+] ; $512c
	ld h, [hl] ; $512d
	ld l, a ; $512e
	ld a, h ; $512f
	ld [wStoryLocationBank], a ; $5130
	ld hl, wStoryLocationMapScriptsSlot ; $5133
	ld a, [hl+] ; $5136
	ld h, [hl] ; $5137
	ld l, a ; $5138
	ld de, wMapEntryPointsPtr ; $5139
	ld bc, $000e ; $513c
	call CopyDataFromBank ; $513f
	ld a, [wStoryModeCurrentLocation] ; $5142
	add $79 ; $5145
	ld l, a ; $5147
	adc $01 ; $5148
	sub l ; $514a
	ld h, a ; $514b
	ld a, l ; $514c
	ld [wStoryModeLocationNameTextId], a ; $514d
	ld a, h ; $5150
	ld [wStoryModeLocationNameTextId + 1], a ; $5151
	ld a, [wStoryModeEntryPoint] ; $5154
	sub STORYENTRY_NONE ; $5157
	ld [wStoryModeShowLocationName], a ; $5159
	pop hl ; $515c
	pop de ; $515d
	pop bc ; $515e
	pop af ; $515f
	ret ; $5160
WriteStoryStateWord:
	push de ; $5161
	push hl ; $5162
	push hl ; $5163
	ld hl, wStoryModeCurrentLocation ; $5164
	add hl, de ; $5167
	pop de ; $5168
	ld [hl], e ; $5169
	inc hl ; $516a
	ld [hl], d ; $516b
	pop hl ; $516c
	pop de ; $516d
	ret ; $516e
LoadStoryEntryPointRecord:
	push af ; $516f
	push bc ; $5170
	push de ; $5171
	push hl ; $5172
	ld a, [wStoryModeEntryPoint] ; $5173
	cp STORYENTRY_NONE ; $5176
	jr z, .done ; $5178
	ld hl, wStoryModeEntryPoint ; $517a
	ld d, [hl] ; $517d
	ld hl, wMapEntryPointsPtr ; $517e
	ld a, [hl+] ; $5181
	ld h, [hl] ; $5182
	ld l, a ; $5183
.searchLoop:
	ld a, [wStoryLocationBank] ; $5184
	call FarReadByte ; $5187
	cp STORYENTRY_NONE ; $518a
	jr z, .notFound ; $518c
	cp d ; $518e
	jr z, .copyRecord ; $518f
	ld a, $08 ; $5191
	add l ; $5193
	ld l, a ; $5194
	jr nc, .next ; $5195
	inc h ; $5197
.next:
	jr .searchLoop ; $5198
.notFound:
	ld hl, wMapEntryPointsPtr ; $519a
	ld a, [hl+] ; $519d
	ld h, [hl] ; $519e
	ld l, a ; $519f
.copyRecord:
	ld a, [wStoryLocationBank] ; $51a0
	ld de, wStoryMapRecord ; $51a3
	ld bc, wStoryMapRecord_SIZE ; $51a6
	call FarCopyBytes ; $51a9
	ld a, [wStoryMapRecord + 1] ; $51ac
	ld [wStoryModeSpawnPosition + 4], a ; $51af
	ld hl, wStoryMapRecord + 2 ; $51b2
	ld de, wStoryModeSpawnPosition ; $51b5
	ld bc, $0004 ; $51b8
	call CopyMemoryBC ; $51bb
	ld a, [wStoryMapRecord + 6] ; $51be
	ld [wStoryArrivalScript], a ; $51c1
	ld a, [wStoryMapRecord + 7] ; $51c4
	ld [wStoryArrivalScript + 1], a ; $51c7
.done:
	pop hl ; $51ca
	pop de ; $51cb
	pop bc ; $51cc
	pop af ; $51cd
	ret ; $51ce

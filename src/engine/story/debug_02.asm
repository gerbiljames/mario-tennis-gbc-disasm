Unused_02_DebugStoryStatsScreen:
	sound BGM_DICTIONARY ; $4fa6
	wram_bank WRAM_STAGING ; $4fa8
	ld a, DEBUGSTEP_CONSOLE_ON ; $4fae
	ldh [hDebugStepMode], a ; $4fb0
	xor a ; $4fb2
	ld [wCurrentStorySlot], a ; $4fb3
	farcall InitTextWindows ; $4fb6
	call EnableLCD ; $4fb9
	script_fade_out 127 ; $4fbc
	script_fade_in 127 ; $4fc1
	farcall InitStoryModeState ; $4fc6
	ld d, $00 ; $4fc9
.reloadSlot:
	farcall CheckStorySlot ; $4fcb
	or a ; $4fce
	jr z, .slotOk ; $4fcf
	push de ; $4fd1
	ld hl, SaveResultFailedString_02 ; $4fd2
	ld_cell de, $08, $02 ; $4fd5
	call PrintString ; $4fd8
	pop de ; $4fdb
	jp .printString ; $4fdc
.slotOk:
	ld hl, SaveResultLoadedString_02 ; $4fdf
	ld_cell de, $08, $02 ; $4fe2
	call PrintString ; $4fe5
	call Unused_02_ValidateN64TransferRecord ; $4fe8
	or a ; $4feb
	jr z, .printString ; $4fec
	push de ; $4fee
	ld hl, wN64TransferMainExp ; $4fef
	ld a, [hl+] ; $4ff2
	ld h, [hl] ; $4ff3
	ld l, a ; $4ff4
	ld_cell de, $02, $10 ; $4ff5
	call Unused_00_PrintDecimalWord ; $4ff8
	ld hl, wN64TransferPartnerExp ; $4ffb
	ld a, [hl+] ; $4ffe
	ld h, [hl] ; $4fff
	ld l, a ; $5000
	ld_cell de, $0a, $10 ; $5001
	call Unused_00_PrintDecimalWord ; $5004
	pop de ; $5007
	ld hl, wN64TransferMainExp ; $5008
	ASSERT wN64TransferPartnerExp == wN64TransferMainExp + 2, "this code walks from wN64TransferMainExp into wN64TransferPartnerExp"
	ASSERT wN64TransferMarker == wN64TransferMainExp + 4, "this code walks from wN64TransferMainExp into wN64TransferMarker"
	ASSERT wN64TrophyCounts == wN64TransferMainExp + 5, "this code walks from wN64TransferMainExp into wN64TrophyCounts"
	xor a ; $500b
	ld [hl+], a ; $500c
	ld [hl+], a ; $500d
	ld [hl+], a ; $500e
	ld [hl+], a ; $500f
	ld [hl+], a ; $5010
	ld [hl+], a ; $5011
	ld [hl+], a ; $5012
	ld [hl+], a ; $5013
	jr .redraw ; $5014
.printString:
	push de ; $5016
	ld hl, SaveResultBlankString_02 ; $5017
	ld_cell de, $02, $10 ; $501a
	call PrintString ; $501d
	ld hl, SaveResultBlankString_02 ; $5020
	ld_cell de, $08, $10 ; $5023
	call PrintString ; $5026
	pop de ; $5029
.redraw:
	push de ; $502a
	ld bc, wStoryMain ; $502b
	ld a, [wCurrentStorySlot] ; $502e
	ld_cell de, $02, $02 ; $5031
	call PrintDecimalByte ; $5034
	ld hl, CHARREC_CHAR ; $5037
	add hl, bc ; $503a
	ld a, [hl] ; $503b
	ld_cell de, $02, $04 ; $503c
	call PrintDecimalByte ; $503f
	ld hl, CHARREC_LEVEL ; $5042
	add hl, bc ; $5045
	ld a, [hl] ; $5046
	ld_cell de, $02, $06 ; $5047
	call PrintDecimalByte ; $504a
	ld hl, CHARREC_SKILL_ICONS ; $504d
	add hl, bc ; $5050
	ld a, [hl+] ; $5051
	ld h, [hl] ; $5052
	ld l, a ; $5053
	ld_cell de, $02, $07 ; $5054
	call PrintHexWord ; $5057
	ld hl, CHARREC_PHYSICS_TEMPLATE ; $505a
	add hl, bc ; $505d
	ld a, [hl+] ; $505e
	ld h, [hl] ; $505f
	ld l, a ; $5060
	ld_cell de, $02, $09 ; $5061
	call PrintHexWord ; $5064
	ld hl, CHARREC_PHYSICS_TEMPLATE + 2 ; $5067
	add hl, bc ; $506a
	ld a, [hl+] ; $506b
	ld h, [hl] ; $506c
	ld l, a ; $506d
	ld_cell de, $02, $0a ; $506e
	call PrintHexWord ; $5071
	ld hl, CHARREC_PHYSICS_TEMPLATE + 4 ; $5074
	add hl, bc ; $5077
	ld a, [hl+] ; $5078
	ld h, [hl] ; $5079
	ld l, a ; $507a
	ld_cell de, $02, $0b ; $507b
	call PrintHexWord ; $507e
	ld hl, CHARREC_PHYSICS_TEMPLATE + 6 ; $5081
	add hl, bc ; $5084
	ld a, [hl+] ; $5085
	ld h, [hl] ; $5086
	ld l, a ; $5087
	ld_cell de, $02, $0c ; $5088
	call PrintHexWord ; $508b
	ld hl, CHARREC_LEFT_HANDED ; $508e
	add hl, bc ; $5091
	ld a, [hl] ; $5092
	ld_cell de, $02, $0e ; $5093
	call PrintDecimalByte ; $5096
	ld hl, CHARREC_TRAIN_LEVELS + TRAINSTAT_SPIN ; $5099
	add hl, bc ; $509c
	ld a, [hl] ; $509d
	ld_cell de, $07, $04 ; $509e
	call PrintDecimalByte ; $50a1
	ld hl, CHARREC_TRAIN_LEVELS + TRAINSTAT_POWER ; $50a4
	add hl, bc ; $50a7
	ld a, [hl] ; $50a8
	ld_cell de, $07, $06 ; $50a9
	call PrintDecimalByte ; $50ac
	ld hl, CHARREC_TRAIN_LEVELS + TRAINSTAT_CONTROL ; $50af
	add hl, bc ; $50b2
	ld a, [hl] ; $50b3
	ld_cell de, $07, $09 ; $50b4
	call PrintDecimalByte ; $50b7
	ld hl, CHARREC_TRAIN_LEVELS + TRAINSTAT_SPEED ; $50ba
	add hl, bc ; $50bd
	ld a, [hl] ; $50be
	ld_cell de, $07, $0b ; $50bf
	call PrintDecimalByte ; $50c2
	ld hl, CHARREC_STAT_TOP ; $50c5
	add hl, bc ; $50c8
	ld a, [hl] ; $50c9
	ld_cell de, $0c, $04 ; $50ca
	call PrintDecimalByte ; $50cd
	ld hl, CHARREC_STAT_SLICE ; $50d0
	add hl, bc ; $50d3
	ld a, [hl] ; $50d4
	ld_cell de, $0c, $05 ; $50d5
	call PrintDecimalByte ; $50d8
	ld hl, CHARREC_STAT_SERVE ; $50db
	add hl, bc ; $50de
	ld a, [hl] ; $50df
	ld_cell de, $0c, $06 ; $50e0
	call PrintDecimalByte ; $50e3
	ld hl, CHARREC_STAT_STROKE ; $50e6
	add hl, bc ; $50e9
	ld a, [hl] ; $50ea
	ld_cell de, $0c, $07 ; $50eb
	call PrintDecimalByte ; $50ee
	ld hl, CHARREC_STAT_VOLLEY ; $50f1
	add hl, bc ; $50f4
	ld a, [hl] ; $50f5
	ld_cell de, $0c, $08 ; $50f6
	call PrintDecimalByte ; $50f9
	ld hl, CHARREC_STAT_ANGLE ; $50fc
	add hl, bc ; $50ff
	ld a, [hl] ; $5100
	ld_cell de, $0c, $09 ; $5101
	call PrintDecimalByte ; $5104
	ld hl, CHARREC_STAT_PLACEMENT ; $5107
	add hl, bc ; $510a
	ld a, [hl] ; $510b
	ld_cell de, $0c, $0a ; $510c
	call PrintDecimalByte ; $510f
	ld hl, CHARREC_STAT_SPEED ; $5112
	add hl, bc ; $5115
	ld a, [hl] ; $5116
	ld_cell de, $0c, $0b ; $5117
	call PrintDecimalByte ; $511a
	ld hl, CHARREC_STAT_DASH ; $511d
	add hl, bc ; $5120
	ld a, [hl] ; $5121
	ld_cell de, $0c, $0c ; $5122
	call PrintDecimalByte ; $5125
	ld hl, CHARREC_STAT_REACTION ; $5128
	add hl, bc ; $512b
	ld a, [hl] ; $512c
	ld_cell de, $0c, $0d ; $512d
	call PrintDecimalByte ; $5130
	ld hl, CHARREC_STAT_STOP ; $5133
	add hl, bc ; $5136
	ld a, [hl] ; $5137
	ld_cell de, $0c, $0e ; $5138
	call PrintDecimalByte ; $513b
	pop de ; $513e
.inputLoop:
	call AdvanceFrame ; $513f
	call AdvanceRandomSeed ; $5142
	ldh a, [hInputRepeat] ; $5145
	bit PADB_UP, a ; $5147
	jr z, .checkLeft ; $5149
	push de ; $514b
	ld a, STORYREC_MAIN ; $514c
	ld d, TRAINSTAT_SPIN ; $514e
	call LevelUpPlayer ; $5150
	pop de ; $5153
	sound SFX_MENU_MOVE ; $5154
	jp .redraw ; $5156
.checkLeft:
	bit PADB_LEFT, a ; $5159
	jr z, .checkRight ; $515b
	push de ; $515d
	ld a, STORYREC_MAIN ; $515e
	ld d, TRAINSTAT_POWER ; $5160
	call LevelUpPlayer ; $5162
	pop de ; $5165
	sound SFX_MENU_MOVE ; $5166
	jp .redraw ; $5168
.checkRight:
	bit PADB_RIGHT, a ; $516b
	jr z, .checkDown ; $516d
	push de ; $516f
	ld a, STORYREC_MAIN ; $5170
	ld d, TRAINSTAT_CONTROL ; $5172
	call LevelUpPlayer ; $5174
	pop de ; $5177
	sound SFX_MENU_MOVE ; $5178
	jp .redraw ; $517a
.checkDown:
	bit PADB_DOWN, a ; $517d
	jr z, .checkB ; $517f
	push de ; $5181
	ld a, STORYREC_MAIN ; $5182
	ld d, TRAINSTAT_SPEED ; $5184
	call LevelUpPlayer ; $5186
	pop de ; $5189
	sound SFX_MENU_MOVE ; $518a
	jp .redraw ; $518c
.checkB:
	bit PADB_B, a ; $518f
	jr z, .checkA ; $5191
	push de ; $5193
	ld a, DEBUGSTEP_CONSOLE_OFF ; $5194
	ldh [hDebugStepMode], a ; $5196
	sound BGM_DICTIONARY ; $5198
	ld a, DEBUGSTEP_CONSOLE_ON ; $519a
	ldh [hDebugStepMode], a ; $519c
	pop de ; $519e
	jp .redraw ; $519f
.checkA:
	bit PADB_A, a ; $51a2
	jr z, .checkSelect ; $51a4
	push af ; $51a6
	push bc ; $51a7
	push de ; $51a8
	push hl ; $51a9
	farcall InitStoryModeState ; $51aa
	pop hl ; $51ad
	pop de ; $51ae
	pop bc ; $51af
	pop af ; $51b0
	ld a, d ; $51b1
	inc a ; $51b2
	and $07 ; $51b3
	ld d, a ; $51b5
	xor a ; $51b6
	push de ; $51b7
	res 2, d ; $51b8
	call InitPlayerRecordFromTemplate ; $51ba
	pop de ; $51bd
	bit 2, d ; $51be
	jp z, .redraw ; $51c0
	ld a, $01 ; $51c3
	ld [wStoryMainLeftHanded], a ; $51c5
	jp .redraw ; $51c8
.checkSelect:
	bit PADB_SELECT, a ; $51cb
	jr z, .checkStart ; $51cd
	sound SFX_MENU_SELECT ; $51cf
	ld a, [wCurrentStorySlot] ; $51d1
	inc a ; $51d4
	cp NUM_STORY_SLOTS ; $51d5
	jr c, .store ; $51d7
	xor a ; $51d9
.store:
	ld [wCurrentStorySlot], a ; $51da
	jp .reloadSlot ; $51dd
.checkStart:
	bit PADB_START, a ; $51e0
	jr z, .skipSave ; $51e2
	sound SFX_MENU_SELECT ; $51e4
	push de ; $51e6
	ld hl, SaveResultSavedString_02 ; $51e7
	ld_cell de, $08, $02 ; $51ea
	call PrintString ; $51ed
	farcall SaveStorySlotWithTimer ; $51f0
	pop de ; $51f3
	jp .redraw ; $51f4
.skipSave:
	jp .inputLoop ; $51f7
SaveResultFailedString_02:
	INCLUDE "data/engine/story/SaveResultFailedString_02.asm" ; $51fa, 8 bytes (text)
SaveResultLoadedString_02:
	INCLUDE "data/engine/story/SaveResultLoadedString_02.asm" ; $5202, 8 bytes (text)
SaveResultSavedString_02:
	INCLUDE "data/engine/story/SaveResultSavedString_02.asm" ; $520a, 8 bytes (text)
Unused_02_SaveResultDeletedString:
	INCLUDE "data/engine/story/Unused_02_SaveResultDeletedString.asm" ; $5212, 8 bytes (text)
SaveResultBlankString_02:
	INCLUDE "data/engine/story/SaveResultBlankString_02.asm" ; $521a, 8 bytes (text)
Unused_02_ByteRamp:
	; $5222, 13 bytes (bytes:13)
	db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d ; 0x00
	; $522f, 8 bytes (fill)
	ds 8, $00
Unused_02_MarioGolfSignature:
	INCLUDE "data/engine/story/Unused_02_MarioGolfSignature.asm" ; $5237, 16 bytes (text)
LoadStorySlot:
	push de ; $5247
	ld hl, wStorySlotData ; $5248
	ld b, a ; $524b
	ld c, a ; $524c
	push bc ; $524d
	ld [wCurrentStorySlot], a ; $524e
	farcall CheckStorySlot ; $5251
	pop bc ; $5254
	pop de ; $5255
	or a ; $5256
	jr z, .slotOk ; $5257
	ld a, [wLinkSessionActive] ; $5259
	or a ; $525c
	ld a, h ; $525d
	jr nz, .linkSessionNoChar ; $525e
	ld a, CHAR_EMPTY_SLOT ; $5260
	ld [wPlayer1MainChar], a ; $5262
	ld a, $03 ; $5265
	ld [wPlayer1MainPalette], a ; $5267
	ld a, b ; $526a
	ld [wCurrentStorySlot], a ; $526b
	ret ; $526e
.linkSessionNoChar:
	ld a, CHAR_NONE ; $526f
	ld [wPlayer1MainChar], a ; $5271
	ret ; $5274
.slotOk:
	push bc ; $5275
	push de ; $5276
	xor a ; $5277
	ld [wCurrentStorySlot], a ; $5278
	ld_char_rec bc, CHAR_STORY_MAIN, MATCHREC_P1_MAIN ; $527b
	call InitMatchRecordFromCharId ; $527e
	pop de ; $5281
	pop bc ; $5282
	ret ; $5283
Unused_02_StorySlotVariant:
	push de ; $5284
	ld hl, wStorySlotData ; $5285
	ld b, a ; $5288
	ld c, a ; $5289
	push bc ; $528a
	ld [wCurrentStorySlot], a ; $528b
	farcall CheckStorySlot ; $528e
	pop bc ; $5291
	pop de ; $5292
	or a ; $5293
	jr z, .slotOk ; $5294
	ld a, CHAR_NONE ; $5296
	ld [wPlayer1MainChar], a ; $5298
	ld a, $ff ; $529b
	ret ; $529d
.slotOk:
	push bc ; $529e
	push de ; $529f
	ld_char_rec bc, CHAR_STORY_MAIN, MATCHREC_P1_MAIN ; $52a0
	call InitMatchRecordFromCharId ; $52a3
	pop de ; $52a6
	pop bc ; $52a7
	xor a ; $52a8
	ret ; $52a9
LoadPlayer2MainRecord:
	push af ; $52aa
	push bc ; $52ab
	push de ; $52ac
	push hl ; $52ad
	bit 7, a ; $52ae
	jr z, .positive ; $52b0
	res 7, a ; $52b2
	call LoadStorySlot ; $52b4
	ld hl, wPlayer1Main ; $52b7
	ld de, wPlayer2Main ; $52ba
	ld c, (2 * CHAR_RECORD_SIZE) / 16 ; $52bd
	call CopyMemoryFast ; $52bf
	jr .restore ; $52c2
.positive:
	ld b, a ; $52c4
	ld c, MATCHREC_P2_MAIN ; $52c5
	call InitMatchRecordFromCharId ; $52c7
.restore:
	pop hl ; $52ca
	pop de ; $52cb
	pop bc ; $52cc
	pop af ; $52cd
	ret ; $52ce
StoryCharacterRecords_02:
	; $52cf, 2900 bytes (char_stats_row)
; 100 records x 29 bytes
; char_stats_row strategy, reach_h, reach_x, smash_jump, dive, tier, swing,
;                delay_near, delay_far, tracking, aim_away, difficulty,
;                Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop,
;                speed_bonus
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $00 Alex
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $01 Nina
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $02 Harry
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $03 Kate
	char_stats_row 1, $0080, $00a0, $0800, $000c, 2, $0080, 27, 18, 14, 70, 0,  0, 0, 0, 0, 1, 0, 1, 3, 4, 0, 0,  0 ; $04 Allie
	char_stats_row 1, $0080, $00a0, $0800, $000c, 2, $0080, 25, 19, 10, 80, 0,  0, 2, 0, 0, 1, 5, 7, 0, 0, 1, 1,  0 ; $05 Joy
	char_stats_row 1, $0080, $00a0, $0800, $000c, 2, $0080, 30, 28, 13, 30, 0,  3, 2, 2, 2, 1, 2, 2, 2, 2, 3, 2,  0 ; $06 Brian
	char_stats_row 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 18, 10, 160, 0,  2, 2, 0, 1, 2, 5, 4, 1, 2, 1, 0,  0 ; $07 Pam
	char_stats_row 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 18, 10, 160, 0,  3, 1, 6, 5, 3, 0, 0, 0, 1, 1, 2,  0 ; $08 Bob
	char_stats_row 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 17, 10, 160, 0,  2, 0, 1, 2, 1, 2, 1, 6, 7, 3, 2,  0 ; $09 Beth
	char_stats_row 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  2, 1, 5, 6, 4, 2, 2, 2, 3, 2, 3,  0 ; $0a Fay
	char_stats_row 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  7, 8, 3, 2, 1, 3, 2, 1, 2, 1, 2,  0 ; $0b Curt
	char_stats_row 1, $0080, $00a0, $0800, $000c, 4, $0080, 15, 10, 8, 170, 0,  3, 2, 3, 4, 3, 4, 3, 4, 3, 3, 3,  0 ; $0c Mark
	char_stats_row 1, $0080, $00a0, $0800, $000c, 5, $0080, 10, 9, 5, 200, 0,  3, 3, 4, 3, 2, 4, 5, 4, 4, 3, 3,  0 ; $0d Sean
	char_stats_row 1, $0080, $00a0, $0800, $000c, 5, $0080, 10, 9, 5, 200, 0,  1, 4, 2, 3, 4, 8, 7, 4, 3, 2, 3,  0 ; $0e Sammi
	char_stats_row 1, $0080, $00a0, $0800, $000c, 5, $0080, 10, 9, 5, 200, 0,  4, 1, 3, 5, 4, 4, 2, 7, 6, 4, 3,  0 ; $0f Elden
	char_stats_row 1, $0080, $00a0, $0800, $000c, 5, $0280, 10, 9, 5, 230, 8,  4, 4, 5, 4, 3, 5, 4, 4, 4, 3, 3,  0 ; $10 Spike
	char_stats_row 1, $0080, $00a0, $0800, $0012, 5, $0080, 8, 7, 3, 220, 3,  4, 2, 3, 4, 5, 4, 3, 7, 8, 5, 4,  0 ; $11 Emily
	char_stats_row 1, $0080, $00a0, $0800, $000c, 5, $0080, 10, 9, 5, 180, 0,  7, 1, 7, 8, 5, 2, 3, 3, 2, 2, 4,  0 ; $12 B. Coz
	char_stats_row 1, $0080, $00a0, $0800, $000c, 5, $0180, 8, 7, 3, 255, 7,  9, 9, 3, 4, 5, 4, 3, 4, 2, 3, 3,  0 ; $13 A. Coz
	char_stats_row 1, $0080, $00a0, $0800, $000c, 5, $0080, 9, 8, 4, 220, 0,  4, 3, 3, 4, 4, 7, 6, 5, 4, 4, 5,  0 ; $14 Kevin
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 9, 9, 1, 9, 9, 9,  0 ; $15 Not used
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $16 Not used
	char_stats_row 1, $0090, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  0, 3, 4, 5, 8, 4, 5, 4, 6, 3, 3,  0 ; $17 Luigi
	char_stats_row 1, $0090, $00b0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  0, 2, 6, 7, 4, 2, 3, 4, 5, 0, 3,  0 ; $18 DK
	char_stats_row 1, $0070, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  3, 2, 5, 5, 6, 8, 7, 5, 6, 5, 9,  0 ; $19 Baby M.
	char_stats_row 1, $0080, $00a0, $0900, $000c, 5, $0080, 32, 28, 14, 60, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $1a Mario
	char_stats_row 2, $00a0, $00a6, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  0, 3, 4, 4, 8, 1, 8, 3, 6, 6, 3,  0 ; $1b Waluigi
	char_stats_row 0, $0080, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  2, 3, 4, 5, 4, 5, 7, 6, 8, 3, 5,  0 ; $1c Yoshi
	char_stats_row 0, $0090, $00b0, $0780, $000b, 5, $0080, 32, 28, 14, 60, 0,  2, 0, 6, 7, 4, 3, 5, 4, 2, 3, 3,  0 ; $1d Bowser
	char_stats_row 1, $0080, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  3, 0, 6, 7, 5, 5, 6, 5, 4, 4, 5,  0 ; $1e Wario
	char_stats_row 1, $0080, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  1, 3, 4, 4, 6, 5, 9, 4, 7, 7, 8,  0 ; $1f Peach
	char_stats_row 1, $0080, $00a0, $0800, $000c, 2, $0080, 22, 18, 10, 160, 0,  2, 1, 5, 4, 2, 0, 0, 0, 0, 0, 1,  0 ; $20 Ranker 32
	char_stats_row 1, $0080, $00a0, $0800, $000c, 2, $0080, 24, 20, 11, 150, 0,  2, 0, 1, 2, 1, 1, 0, 4, 5, 2, 1,  0 ; $21 Ranker 33
	char_stats_row 1, $0080, $00a0, $0800, $000c, 2, $0080, 26, 24, 12, 120, 0,  5, 6, 2, 1, 0, 2, 1, 0, 1, 0, 1,  0 ; $22 Ranker 34
	char_stats_row 1, $0080, $00a0, $0800, $000c, 2, $0080, 31, 31, 14, 40, 0,  2, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1,  0 ; $23 Ranker 35
	char_stats_row 1, $0080, $00a0, $0800, $000c, 2, $0080, 30, 28, 13, 30, 0,  3, 2, 2, 2, 1, 2, 2, 2, 2, 3, 2,  0 ; $24 Ranker 36
	char_stats_row 1, $0080, $00a0, $0800, $000c, 2, $0080, 31, 24, 10, 50, 0,  1, 0, 3, 4, 2, 0, 0, 0, 1, 0, 1,  0 ; $25 Ranker 37
	char_stats_row 1, $0080, $00a0, $0800, $000c, 2, $0080, 27, 18, 14, 70, 0,  0, 0, 0, 0, 1, 0, 1, 3, 4, 0, 0,  0 ; $26 Ranker 38
	char_stats_row 1, $0080, $00a0, $0800, $000c, 2, $0080, 25, 19, 10, 80, 0,  0, 2, 0, 0, 1, 5, 7, 0, 0, 1, 1,  0 ; $27 Ranker 39
	char_stats_row 1, $0080, $00a0, $0800, $000c, 3, $0080, 18, 12, 10, 170, 0,  1, 0, 4, 5, 3, 2, 2, 1, 2, 1, 2,  0 ; $28 Ranker 40
	char_stats_row 1, $0080, $00a0, $0800, $000c, 3, $0080, 19, 14, 10, 160, 0,  1, 2, 0, 1, 2, 1, 2, 6, 7, 4, 2,  0 ; $29 Ranker 41
	char_stats_row 1, $0080, $00a0, $0800, $000c, 3, $0080, 20, 16, 10, 160, 0,  1, 3, 1, 0, 2, 6, 7, 1, 1, 2, 2,  0 ; $2a Ranker 42
	char_stats_row 1, $0080, $00a0, $0800, $000c, 3, $0080, 21, 17, 10, 160, 0,  3, 2, 2, 2, 1, 2, 2, 2, 2, 3, 2,  0 ; $2b Ranker 43
	char_stats_row 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 17, 10, 160, 0,  2, 0, 1, 2, 1, 2, 1, 6, 7, 3, 2,  0 ; $2c Ranker 44
	char_stats_row 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 17, 10, 160, 0,  6, 7, 2, 1, 0, 2, 1, 0, 1, 0, 1,  0 ; $2d Ranker 45
	char_stats_row 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 18, 10, 160, 0,  3, 1, 6, 5, 3, 0, 0, 0, 1, 1, 2,  0 ; $2e Ranker 46
	char_stats_row 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 18, 10, 160, 0,  2, 2, 1, 2, 2, 3, 2, 3, 2, 1, 1,  0 ; $2f Ranker 47
	char_stats_row 1, $0080, $00a0, $0800, $000c, 4, $0080, 15, 10, 10, 180, 0,  4, 3, 3, 4, 4, 7, 6, 5, 4, 4, 5,  0 ; $30 Kevin
	char_stats_row 1, $0080, $00a0, $0800, $000c, 4, $0080, 16, 11, 10, 170, 0,  4, 2, 3, 4, 5, 3, 2, 7, 8, 5, 4,  0 ; $31 Emily
	char_stats_row 1, $0080, $00a0, $0800, $000c, 4, $0080, 15, 10, 8, 170, 0,  3, 2, 3, 4, 3, 4, 3, 4, 3, 3, 3,  0 ; $32 Mark
	char_stats_row 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  5, 1, 7, 6, 4, 1, 1, 1, 2, 2, 3,  0 ; $33 Bob
	char_stats_row 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  2, 1, 5, 6, 4, 2, 2, 2, 3, 2, 3,  0 ; $34 Fay
	char_stats_row 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  7, 8, 3, 2, 1, 3, 2, 1, 2, 1, 2,  0 ; $35 Curt
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $36
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 32, 10, 200, 0,  4, 5, 5, 4, 4, 2, 2, 1, 0, 0, 1,  0 ; $37 Drill Service Match 1
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 44, 10, 200, 0,  9, 9, 9, 8, 8, 6, 6, 1, 0, 0, 1,  0 ; $38 Drill Service Match 2
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 25, 10, 200, 0,  9, 9, 9, 8, 8, 7, 7, 3, 2, 2, 3,  0 ; $39 Drill Service Match 3
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 250, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $3a Drill Service Practice 1
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 250, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $3b Drill Service Practice 2
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 250, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $3c Drill Service Practice 3
	char_stats_row 3, $0080, $00a0, $0800, $000c, 1, $0080, 36, 6, 18, 40, 0,  0, 1, 0, 0, 1, 0, 1, 6, 7, 4, 4,  0 ; $3d Drill Net Game Match 1
	char_stats_row 4, $0080, $00a0, $0800, $000c, 1, $0080, 36, 8, 0, 40, 5,  1, 2, 2, 2, 3, 2, 3, 6, 7, 4, 4,  0 ; $3e Drill Net Game Match 2
	char_stats_row 3, $0080, $00a0, $0800, $000c, 1, $0080, 30, 0, 10, 40, 0,  2, 3, 0, 0, 1, 3, 4, 6, 7, 4, 4,  0 ; $3f Drill Net Game Match 3
	char_stats_row 0, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 10, 40, 0,  0, 0, 0, 0, 0, 0, 1, 6, 7, 4, 4,  0 ; $40 Drill Net Game Practice 1
	char_stats_row 4, $0080, $00a0, $0800, $000c, 1, $0080, 36, 0, 10, 40, 5,  1, 1, 0, 1, 0, 2, 3, 7, 8, 5, 5,  0 ; $41 Drill Net Game Practice 2
	char_stats_row 5, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 10, 120, 5,  2, 2, 1, 2, 1, 3, 4, 8, 9, 6, 6,  0 ; $42 Drill Net Game Practice 3
	char_stats_row 5, $0080, $00a0, $0800, $000c, 1, $0080, 18, 20, 10, 50, 3,  0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0,  0 ; $43 Drill Stroke Match 1
	char_stats_row 6, $0080, $00a0, $0500, $000c, 1, $0080, 18, 24, 12, 40, 0,  1, 2, 4, 2, 3, 2, 3, 3, 4, 4, 4,  4 ; $44 Drill Stroke Match 2
	char_stats_row 6, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $45 Drill Stroke Match 3
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $46 Drill Stroke Practice 1
	char_stats_row 6, $0080, $00a0, $0200, $000c, 1, $0080, 40, 0, 12, 40, 1,  1, 2, 4, 2, 3, 2, 3, 9, 9, 4, 4,  0 ; $47 Drill Stroke Practice 2
	char_stats_row 6, $0060, $00a0, $0200, $000c, 1, $0080, 40, 0, 12, 40, 3,  1, 2, 2, 2, 3, 2, 3, 9, 9, 9, 4,  0 ; $48 Drill Stroke Practice 3
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $49
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4a
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4b
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 20, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4c
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4d
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4e
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4f
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 20, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $50
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $51
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $52
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $53
	char_stats_row 3, $0080, $00a0, $0800, $000c, 1, $0080, 32, 0, 18, 40, 0,  0, 1, 0, 0, 1, 0, 1, 9, 9, 6, 6,  0 ; $54 Drill Net Game Match 1 Serving
	char_stats_row 2, $0080, $00a0, $0800, $000c, 1, $0080, 24, 0, 12, 40, 4,  1, 2, 2, 2, 3, 2, 3, 9, 9, 6, 6,  0 ; $55 Drill Net Game Match 2 Serving
	char_stats_row 3, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 10, 120, 0,  2, 3, 4, 4, 5, 4, 5, 9, 9, 6, 6,  0 ; $56 Drill Net Game Match 3 Serving
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $57
	char_stats_row 5, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 0, 200, 5,  0, 4, 0, 5, 0, 0, 0, 6, 6, 7, 6,  0 ; $58 Drill Stroke Match 2 Receiving
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $59 Drill Stroke Match 3 Receiving
	char_stats_row 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $5a
	char_stats_row 1, $0080, $00a0, $0900, $000c, 5, $0080, 8, 7, 3, 190, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $5b Dream Hard
	char_stats_row 1, $0080, $00a0, $0900, $000c, 6, $0080, 2, 2, 0, 230, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $5c Dream Intense
	char_stats_row 1, $0080, $00a0, $0900, $000c, 7, $0080, 0, 0, 0, 255, 0,  4, 3, 6, 7, 6, 5, 7, 7, 6, 4, 4,  0 ; $5d Dream Max
	char_stats_row 1, $0080, $00a0, $0900, $000c, 5, $0080, 8, 7, 3, 190, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $5e Dream Doubles Hard
	char_stats_row 1, $0080, $00a0, $0900, $000c, 6, $0080, 2, 2, 0, 230, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $5f Dream Doubles Intense
	char_stats_row 1, $0080, $00a0, $0900, $000c, 7, $0080, 0, 0, 0, 255, 0,  4, 3, 6, 7, 6, 5, 7, 7, 6, 4, 4,  0 ; $60 Dream Doubles Max
	char_stats_row 1, $0080, $00a0, $0800, $000c, 5, $0080, 8, 7, 3, 190, 0,  1, 3, 4, 4, 6, 5, 9, 4, 7, 7, 8,  0 ; $61 Dream Doubles Hard Partner
	char_stats_row 1, $0080, $00a0, $0800, $000c, 6, $0080, 2, 2, 0, 230, 0,  1, 3, 4, 4, 6, 5, 9, 4, 7, 7, 8,  0 ; $62 Dream Doubles Intense Partner
	char_stats_row 1, $0080, $00a0, $0800, $000c, 7, $0080, 0, 0, 0, 255, 0,  2, 4, 5, 5, 7, 6, 9, 5, 8, 8, 9,  0 ; $63 Dream Doubles Max Partner
AiShotMixTable_02:
	; $5e23, 144 bytes (AISHOT_* x 16 per wAiDifficulty)
	db AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_NEUTRAL, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_NEUTRAL ; difficulty 0
	db AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_NEUTRAL, AISHOT_SLICE, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_NEUTRAL ; difficulty 1
	db AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_NEUTRAL, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_NEUTRAL, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_LOB, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_DROP ; difficulty 2
	db AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_SLICE, AISHOT_TOPSPIN, AISHOT_LOB, AISHOT_DROP ; difficulty 3
	db AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL ; difficulty 4
	db AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB ; difficulty 5
	db AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP ; difficulty 6
	db AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_SLICE, AISHOT_POWER_SLICE, AISHOT_NEUTRAL, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB ; difficulty 7
	db AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_NEUTRAL, AISHOT_POWER_SLICE, AISHOT_LOB, AISHOT_LOB, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP ; difficulty 8
GetAiShotMixEntry:
	add a ; $5eb3
	add a ; $5eb4
	add a ; $5eb5
	add a ; $5eb6
	ld_hl_indexed AiShotMixTable_02 ; $5eb7
	ld a, b ; $5ebe
	and $0f ; $5ebf
	add_hl_a ; $5ec1
	ld a, [hl] ; $5ec6
	ret ; $5ec7
Unused_02_AiShotMixRowHasNeutral:
	add a ; $5ec8
	add a ; $5ec9
	add a ; $5eca
	add a ; $5ecb
	ld_hl_indexed AiShotMixTable_02 ; $5ecc
	ld b, $10 ; $5ed3
.loop:
	ld a, [hl+] ; $5ed5
	cp $30 ; $5ed6
	jr z, .found ; $5ed8
	dec b ; $5eda
	jr nz, .loop ; $5edb
	xor a ; $5edd
	ret ; $5ede
.found:
	ld a, $01 ; $5edf
	ret ; $5ee1
AiShotMixRowContains:
	add a ; $5ee2
	add a ; $5ee3
	add a ; $5ee4
	add a ; $5ee5
	ld_hl_indexed AiShotMixTable_02 ; $5ee6
	ld c, $10 ; $5eed
.loop:
	ld a, [hl+] ; $5eef
	cp b ; $5ef0
	jr z, .found ; $5ef1
	dec c ; $5ef3
	jr nz, .loop ; $5ef4
	xor a ; $5ef6
	ret ; $5ef7
.found:
	ld a, $01 ; $5ef8
	ret ; $5efa
	; $5efb, 8453 bytes fill to bank end (linker-padded)

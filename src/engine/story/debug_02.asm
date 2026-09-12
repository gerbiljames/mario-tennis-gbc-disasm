DebugStoryStatsScreen:
	sound BGM_DICTIONARY ; $4fa6
	wram_bank WRAM_STAGING ; $4fa8
	ld a, $03 ; $4fae
	ldh [hDebugStepMode], a ; $4fb0
	xor a ; $4fb2
	ld [wCurrentStorySlot], a ; $4fb3
	farcall InitTextWindows ; $4fb6
	call EnableLCD ; $4fb9
	ld c, $7f ; $4fbc
	call BeginFadeOut ; $4fbe
	script_fade_in $7f ; $4fc1
	farcall InitStoryModeState ; $4fc6
	ld d, $00 ; $4fc9
.loop:
	farcall CheckStorySlot ; $4fcb
	or a ; $4fce
	jr z, .zero ; $4fcf
	push de ; $4fd1
	ld hl, MenuTilemaps_02 ; $4fd2
	lb de, $08, $02 ; $4fd5 column, row
	call PrintString ; $4fd8
	pop de ; $4fdb
	jp .printString ; $4fdc
.zero:
	ld hl, DebugStoryStatsScreenString0 ; $4fdf
	lb de, $08, $02 ; $4fe2 column, row
	call PrintString ; $4fe5
	call ValidateN64TransferRecord ; $4fe8
	or a ; $4feb
	jr z, .printString ; $4fec
	push de ; $4fee
	ld hl, wPendingExpStory ; $4fef
	ld a, [hl+] ; $4ff2
	ld h, [hl] ; $4ff3
	ld l, a ; $4ff4
	ld de, $0210 ; $4ff5
	call PrintDecimalWord ; $4ff8
	ld hl, wPendingExpTrophy ; $4ffb
	ld a, [hl+] ; $4ffe
	ld h, [hl] ; $4fff
	ld l, a ; $5000
	ld de, $0a10 ; $5001
	call PrintDecimalWord ; $5004
	pop de ; $5007
	ld hl, wPendingExpStory ; $5008
	xor a ; $500b
	ld [hl+], a ; $500c
	ld [hl+], a ; $500d
	ld [hl+], a ; $500e
	ld [hl+], a ; $500f
	ld [hl+], a ; $5010
	ld [hl+], a ; $5011
	ld [hl+], a ; $5012
	ld [hl+], a ; $5013
	jr .loopB ; $5014
.printString:
	push de ; $5016
	ld hl, DebugStoryStatsScreenString2 ; $5017
	lb de, $02, $10 ; $501a column, row
	call PrintString ; $501d
	ld hl, DebugStoryStatsScreenString2 ; $5020
	lb de, $08, $10 ; $5023 column, row
	call PrintString ; $5026
	pop de ; $5029
.loopB:
	push de ; $502a
	ld bc, wStoryModeNameOfMainCharacter ; $502b
	ld a, [wCurrentStorySlot] ; $502e
	ld de, $0202 ; $5031
	call PrintDecimalByte ; $5034
	ld hl, $000b ; $5037
	add hl, bc ; $503a
	ld a, [hl] ; $503b
	ld de, $0204 ; $503c
	call PrintDecimalByte ; $503f
	ld hl, $0018 ; $5042
	add hl, bc ; $5045
	ld a, [hl] ; $5046
	ld de, $0206 ; $5047
	call PrintDecimalByte ; $504a
	ld hl, $0019 ; $504d
	add hl, bc ; $5050
	ld a, [hl+] ; $5051
	ld h, [hl] ; $5052
	ld l, a ; $5053
	ld de, $0207 ; $5054
	call PrintHexWord ; $5057
	ld hl, $0030 ; $505a
	add hl, bc ; $505d
	ld a, [hl+] ; $505e
	ld h, [hl] ; $505f
	ld l, a ; $5060
	ld de, $0209 ; $5061
	call PrintHexWord ; $5064
	ld hl, $0032 ; $5067
	add hl, bc ; $506a
	ld a, [hl+] ; $506b
	ld h, [hl] ; $506c
	ld l, a ; $506d
	ld de, $020a ; $506e
	call PrintHexWord ; $5071
	ld hl, $0034 ; $5074
	add hl, bc ; $5077
	ld a, [hl+] ; $5078
	ld h, [hl] ; $5079
	ld l, a ; $507a
	ld de, $020b ; $507b
	call PrintHexWord ; $507e
	ld hl, $0036 ; $5081
	add hl, bc ; $5084
	ld a, [hl+] ; $5085
	ld h, [hl] ; $5086
	ld l, a ; $5087
	ld de, $020c ; $5088
	call PrintHexWord ; $508b
	ld hl, $000e ; $508e
	add hl, bc ; $5091
	ld a, [hl] ; $5092
	ld de, $020e ; $5093
	call PrintDecimalByte ; $5096
	ld hl, $0038 ; $5099
	add hl, bc ; $509c
	ld a, [hl] ; $509d
	ld de, $0704 ; $509e
	call PrintDecimalByte ; $50a1
	ld hl, $0039 ; $50a4
	add hl, bc ; $50a7
	ld a, [hl] ; $50a8
	ld de, $0706 ; $50a9
	call PrintDecimalByte ; $50ac
	ld hl, $003a ; $50af
	add hl, bc ; $50b2
	ld a, [hl] ; $50b3
	ld de, $0709 ; $50b4
	call PrintDecimalByte ; $50b7
	ld hl, $003b ; $50ba
	add hl, bc ; $50bd
	ld a, [hl] ; $50be
	ld de, $070b ; $50bf
	call PrintDecimalByte ; $50c2
	ld hl, $0020 ; $50c5
	add hl, bc ; $50c8
	ld a, [hl] ; $50c9
	ld de, $0c04 ; $50ca
	call PrintDecimalByte ; $50cd
	ld hl, $0021 ; $50d0
	add hl, bc ; $50d3
	ld a, [hl] ; $50d4
	ld de, $0c05 ; $50d5
	call PrintDecimalByte ; $50d8
	ld hl, $0022 ; $50db
	add hl, bc ; $50de
	ld a, [hl] ; $50df
	ld de, $0c06 ; $50e0
	call PrintDecimalByte ; $50e3
	ld hl, $0023 ; $50e6
	add hl, bc ; $50e9
	ld a, [hl] ; $50ea
	ld de, $0c07 ; $50eb
	call PrintDecimalByte ; $50ee
	ld hl, $0024 ; $50f1
	add hl, bc ; $50f4
	ld a, [hl] ; $50f5
	ld de, $0c08 ; $50f6
	call PrintDecimalByte ; $50f9
	ld hl, $0025 ; $50fc
	add hl, bc ; $50ff
	ld a, [hl] ; $5100
	ld de, $0c09 ; $5101
	call PrintDecimalByte ; $5104
	ld hl, $0026 ; $5107
	add hl, bc ; $510a
	ld a, [hl] ; $510b
	ld de, $0c0a ; $510c
	call PrintDecimalByte ; $510f
	ld hl, $0027 ; $5112
	add hl, bc ; $5115
	ld a, [hl] ; $5116
	ld de, $0c0b ; $5117
	call PrintDecimalByte ; $511a
	ld hl, $0028 ; $511d
	add hl, bc ; $5120
	ld a, [hl] ; $5121
	ld de, $0c0c ; $5122
	call PrintDecimalByte ; $5125
	ld hl, $0029 ; $5128
	add hl, bc ; $512b
	ld a, [hl] ; $512c
	ld de, $0c0d ; $512d
	call PrintDecimalByte ; $5130
	ld hl, $002a ; $5133
	add hl, bc ; $5136
	ld a, [hl] ; $5137
	ld de, $0c0e ; $5138
	call PrintDecimalByte ; $513b
	pop de ; $513e
.loop2:
	call AdvanceFrame ; $513f
	call AdvanceRandomSeed ; $5142
	ldh a, [hInputPressed] ; $5145
	bit PADB_UP, a ; $5147
	jr z, .levelUpPlayer ; $5149
	push de ; $514b
	ld a, $00 ; $514c
	ld d, $00 ; $514e
	call LevelUpPlayer ; $5150
	pop de ; $5153
	sound SFX_MENU_MOVE ; $5154
	jp .loopB ; $5156
.levelUpPlayer:
	bit 5, a ; $5159
	jr z, .bit5Clear ; $515b
	push de ; $515d
	ld a, $00 ; $515e
	ld d, $01 ; $5160
	call LevelUpPlayer ; $5162
	pop de ; $5165
	sound SFX_MENU_MOVE ; $5166
	jp .loopB ; $5168
.bit5Clear:
	bit 4, a ; $516b
	jr z, .bit4Clear ; $516d
	push de ; $516f
	ld a, $00 ; $5170
	ld d, $02 ; $5172
	call LevelUpPlayer ; $5174
	pop de ; $5177
	sound SFX_MENU_MOVE ; $5178
	jp .loopB ; $517a
.bit4Clear:
	bit 7, a ; $517d
	jr z, .positive ; $517f
	push de ; $5181
	ld a, $00 ; $5182
	ld d, $03 ; $5184
	call LevelUpPlayer ; $5186
	pop de ; $5189
	sound SFX_MENU_MOVE ; $518a
	jp .loopB ; $518c
.positive:
	bit 1, a ; $518f
	jr z, .bit1Clear ; $5191
	push de ; $5193
	ld a, $01 ; $5194
	ldh [hDebugStepMode], a ; $5196
	sound BGM_DICTIONARY ; $5198
	ld a, $03 ; $519a
	ldh [hDebugStepMode], a ; $519c
	pop de ; $519e
	jp .loopB ; $519f
.bit1Clear:
	bit 0, a ; $51a2
	jr z, .bit0Clear ; $51a4
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
	jp z, .loopB ; $51c0
	ld a, $01 ; $51c3
	ld [wStoryModeMainCharacterLeftHanded], a ; $51c5
	jp .loopB ; $51c8
.bit0Clear:
	bit 2, a ; $51cb
	jr z, .bit2Clear ; $51cd
	sound SFX_MENU_SELECT ; $51cf
	ld a, [wCurrentStorySlot] ; $51d1
	inc a ; $51d4
	cp NUM_STORY_SLOTS ; $51d5
	jr c, .store ; $51d7
	xor a ; $51d9
.store:
	ld [wCurrentStorySlot], a ; $51da
	jp .loop ; $51dd
.bit2Clear:
	bit 3, a ; $51e0
	jr z, .skipSave ; $51e2
	sound SFX_MENU_SELECT ; $51e4
	push de ; $51e6
	ld hl, DebugStoryStatsScreenString1 ; $51e7
	lb de, $08, $02 ; $51ea column, row
	call PrintString ; $51ed
	farcall SaveStorySlotWithTimer ; $51f0
	pop de ; $51f3
	jp .loopB ; $51f4
.skipSave:
	jp .loop2 ; $51f7
MenuTilemaps_02:
	; $51fa, 8 bytes (bytes:16)
	db $46, $41, $49, $4c, $45, $44, $20, $00 ; 0x00
DebugStoryStatsScreenString0:
	INCLUDE "data/bank_002/DebugStoryStatsScreenString0.asm" ; $5202, 8 bytes
DebugStoryStatsScreenString1:
	INCLUDE "data/bank_002/DebugStoryStatsScreenString1.asm" ; $520a, 16 bytes
DebugStoryStatsScreenString2:
	; $521a, 45 bytes (bytes:16)
	db $20, $20, $20, $20, $20, $20, $00, $00, $01, $02, $03, $04, $05, $06, $07, $08 ; 0x00
	db $09, $0a, $0b, $0c, $0d, $00, $00, $00, $00, $00, $00, $00, $00, $4d, $41, $52 ; 0x10
	db $49, $4f, $20, $47, $4f, $4c, $46, $20, $47, $42, $20, $43, $48 ; 0x20
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
	jr z, .zero ; $5257
	ld a, [wLinkSessionActive] ; $5259
	or a ; $525c
	ld a, h ; $525d
	jr nz, .storePlayer1CurrentMainCharacter ; $525e
	ld a, $3f ; $5260
	ld [wPlayer1CurrentMainCharacter], a ; $5262
	ld a, $03 ; $5265
	ld [wPlayer1MainPalette], a ; $5267
	ld a, b ; $526a
	ld [wCurrentStorySlot], a ; $526b
	ret ; $526e
.storePlayer1CurrentMainCharacter:
	ld a, CHAR_NONE ; $526f
	ld [wPlayer1CurrentMainCharacter], a ; $5271
	ret ; $5274
.zero:
	push bc ; $5275
	push de ; $5276
	xor a ; $5277
	ld [wCurrentStorySlot], a ; $5278
	ld bc, $8000 ; $527b
	call InitCa00RecordFromCharId ; $527e
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
	jr z, .zero ; $5294
	ld a, CHAR_NONE ; $5296
	ld [wPlayer1CurrentMainCharacter], a ; $5298
	ld a, $ff ; $529b
	ret ; $529d
.zero:
	push bc ; $529e
	push de ; $529f
	ld bc, $8000 ; $52a0
	call InitCa00RecordFromCharId ; $52a3
	pop de ; $52a6
	pop bc ; $52a7
	xor a ; $52a8
	ret ; $52a9
LoadCharacterRecordToCa80:
	push af ; $52aa
	push bc ; $52ab
	push de ; $52ac
	push hl ; $52ad
	bit 7, a ; $52ae
	jr z, .positive ; $52b0
	res 7, a ; $52b2
	call LoadStorySlot ; $52b4
	ld hl, wPlayer1MainName ; $52b7
	ld de, wPlayer2MainName ; $52ba
	ld c, $08 ; $52bd
	call CopyMemoryFast ; $52bf
	jr .restore ; $52c2
.positive:
	ld b, a ; $52c4
	ld c, $02 ; $52c5
	call InitCa00RecordFromCharId ; $52c7
.restore:
	pop hl ; $52ca
	pop de ; $52cb
	pop bc ; $52cc
	pop af ; $52cd
	ret ; $52ce
StoryCharacterRecords_02:
	; $52cf, 2900 bytes (char_record)
; 100 records x 29 bytes
; char_record strategy, reach_h, reach_x, smash_jump, dive, tier, swing,
;             delay_near, delay_far, tracking, aim_away, serve_style,
;             Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop,
;             speed_bonus
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $00 Alex
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $01 Nina
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $02 Harry
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $03 Kate
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 27, 18, 14, 70, 0,  0, 0, 0, 0, 1, 0, 1, 3, 4, 0, 0,  0 ; $04 Allie
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 25, 19, 10, 80, 0,  0, 2, 0, 0, 1, 5, 7, 0, 0, 1, 1,  0 ; $05 Joy
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 30, 28, 13, 30, 0,  3, 2, 2, 2, 1, 2, 2, 2, 2, 3, 2,  0 ; $06 Brian
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 18, 10, 160, 0,  2, 2, 0, 1, 2, 5, 4, 1, 2, 1, 0,  0 ; $07 Pam
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 18, 10, 160, 0,  3, 1, 6, 5, 3, 0, 0, 0, 1, 1, 2,  0 ; $08 Bob
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 17, 10, 160, 0,  2, 0, 1, 2, 1, 2, 1, 6, 7, 3, 2,  0 ; $09 Beth
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  2, 1, 5, 6, 4, 2, 2, 2, 3, 2, 3,  0 ; $0a Fay
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  7, 8, 3, 2, 1, 3, 2, 1, 2, 1, 2,  0 ; $0b Curt
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 15, 10, 8, 170, 0,  3, 2, 3, 4, 3, 4, 3, 4, 3, 3, 3,  0 ; $0c Mark
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 10, 9, 5, 200, 0,  3, 3, 4, 3, 2, 4, 5, 4, 4, 3, 3,  0 ; $0d Sean
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 10, 9, 5, 200, 0,  1, 4, 2, 3, 4, 8, 7, 4, 3, 2, 3,  0 ; $0e Sammi
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 10, 9, 5, 200, 0,  4, 1, 3, 5, 4, 4, 2, 7, 6, 4, 3,  0 ; $0f Elden
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0280, 10, 9, 5, 230, 8,  4, 4, 5, 4, 3, 5, 4, 4, 4, 3, 3,  0 ; $10 Spike
	char_record 1, $0080, $00a0, $0800, $0012, 5, $0080, 8, 7, 3, 220, 3,  4, 2, 3, 4, 5, 4, 3, 7, 8, 5, 4,  0 ; $11 Emily
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 10, 9, 5, 180, 0,  7, 1, 7, 8, 5, 2, 3, 3, 2, 2, 4,  0 ; $12 B. Coz
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0180, 8, 7, 3, 255, 7,  9, 9, 3, 4, 5, 4, 3, 4, 2, 3, 3,  0 ; $13 A. Coz
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 9, 8, 4, 220, 0,  4, 3, 3, 4, 4, 7, 6, 5, 4, 4, 5,  0 ; $14 Kevin
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 9, 9, 1, 9, 9, 9,  0 ; $15 Not used
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $16 Not used
	char_record 1, $0090, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  0, 3, 4, 5, 8, 4, 5, 4, 6, 3, 3,  0 ; $17 Luigi
	char_record 1, $0090, $00b0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  0, 2, 6, 7, 4, 2, 3, 4, 5, 0, 3,  0 ; $18 DK
	char_record 1, $0070, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  3, 2, 5, 5, 6, 8, 7, 5, 6, 5, 9,  0 ; $19 Baby M.
	char_record 1, $0080, $00a0, $0900, $000c, 5, $0080, 32, 28, 14, 60, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $1a Mario
	char_record 2, $00a0, $00a6, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  0, 3, 4, 4, 8, 1, 8, 3, 6, 6, 3,  0 ; $1b Waluigi
	char_record 0, $0080, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  2, 3, 4, 5, 4, 5, 7, 6, 8, 3, 5,  0 ; $1c Yoshi
	char_record 0, $0090, $00b0, $0780, $000b, 5, $0080, 32, 28, 14, 60, 0,  2, 0, 6, 7, 4, 3, 5, 4, 2, 3, 3,  0 ; $1d Bowser
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  3, 0, 6, 7, 5, 5, 6, 5, 4, 4, 5,  0 ; $1e Wario
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  1, 3, 4, 4, 6, 5, 9, 4, 7, 7, 8,  0 ; $1f Peach
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 22, 18, 10, 160, 0,  2, 1, 5, 4, 2, 0, 0, 0, 0, 0, 1,  0 ; $20 Ranker 32
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 24, 20, 11, 150, 0,  2, 0, 1, 2, 1, 1, 0, 4, 5, 2, 1,  0 ; $21 Ranker 33
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 26, 24, 12, 120, 0,  5, 6, 2, 1, 0, 2, 1, 0, 1, 0, 1,  0 ; $22 Ranker 34
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 31, 31, 14, 40, 0,  2, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1,  0 ; $23 Ranker 35
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 30, 28, 13, 30, 0,  3, 2, 2, 2, 1, 2, 2, 2, 2, 3, 2,  0 ; $24 Ranker 36
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 31, 24, 10, 50, 0,  1, 0, 3, 4, 2, 0, 0, 0, 1, 0, 1,  0 ; $25 Ranker 37
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 27, 18, 14, 70, 0,  0, 0, 0, 0, 1, 0, 1, 3, 4, 0, 0,  0 ; $26 Ranker 38
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 25, 19, 10, 80, 0,  0, 2, 0, 0, 1, 5, 7, 0, 0, 1, 1,  0 ; $27 Ranker 39
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 18, 12, 10, 170, 0,  1, 0, 4, 5, 3, 2, 2, 1, 2, 1, 2,  0 ; $28 Ranker 40
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 19, 14, 10, 160, 0,  1, 2, 0, 1, 2, 1, 2, 6, 7, 4, 2,  0 ; $29 Ranker 41
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 20, 16, 10, 160, 0,  1, 3, 1, 0, 2, 6, 7, 1, 1, 2, 2,  0 ; $2a Ranker 42
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 21, 17, 10, 160, 0,  3, 2, 2, 2, 1, 2, 2, 2, 2, 3, 2,  0 ; $2b Ranker 43
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 17, 10, 160, 0,  2, 0, 1, 2, 1, 2, 1, 6, 7, 3, 2,  0 ; $2c Ranker 44
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 17, 10, 160, 0,  6, 7, 2, 1, 0, 2, 1, 0, 1, 0, 1,  0 ; $2d Ranker 45
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 18, 10, 160, 0,  3, 1, 6, 5, 3, 0, 0, 0, 1, 1, 2,  0 ; $2e Ranker 46
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 18, 10, 160, 0,  2, 2, 1, 2, 2, 3, 2, 3, 2, 1, 1,  0 ; $2f Ranker 47
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 15, 10, 10, 180, 0,  4, 3, 3, 4, 4, 7, 6, 5, 4, 4, 5,  0 ; $30 Kevin
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 16, 11, 10, 170, 0,  4, 2, 3, 4, 5, 3, 2, 7, 8, 5, 4,  0 ; $31 Emily
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 15, 10, 8, 170, 0,  3, 2, 3, 4, 3, 4, 3, 4, 3, 3, 3,  0 ; $32 Mark
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  5, 1, 7, 6, 4, 1, 1, 1, 2, 2, 3,  0 ; $33 Ellis
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  2, 1, 5, 6, 4, 2, 2, 2, 3, 2, 3,  0 ; $34 Frank
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  7, 8, 3, 2, 1, 3, 2, 1, 2, 1, 2,  0 ; $35 Edgar
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $36
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 32, 10, 200, 0,  4, 5, 5, 4, 4, 2, 2, 1, 0, 0, 1,  0 ; $37
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 44, 10, 200, 0,  9, 9, 9, 8, 8, 6, 6, 1, 0, 0, 1,  0 ; $38
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 25, 10, 200, 0,  9, 9, 9, 8, 8, 7, 7, 3, 2, 2, 3,  0 ; $39
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 250, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $3a
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 250, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $3b
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 250, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $3c
	char_record 3, $0080, $00a0, $0800, $000c, 1, $0080, 36, 6, 18, 40, 0,  0, 1, 0, 0, 1, 0, 1, 6, 7, 4, 4,  0 ; $3d
	char_record 4, $0080, $00a0, $0800, $000c, 1, $0080, 36, 8, 0, 40, 5,  1, 2, 2, 2, 3, 2, 3, 6, 7, 4, 4,  0 ; $3e
	char_record 3, $0080, $00a0, $0800, $000c, 1, $0080, 30, 0, 10, 40, 0,  2, 3, 0, 0, 1, 3, 4, 6, 7, 4, 4,  0 ; $3f
	char_record 0, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 10, 40, 0,  0, 0, 0, 0, 0, 0, 1, 6, 7, 4, 4,  0 ; $40
	char_record 4, $0080, $00a0, $0800, $000c, 1, $0080, 36, 0, 10, 40, 5,  1, 1, 0, 1, 0, 2, 3, 7, 8, 5, 5,  0 ; $41
	char_record 5, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 10, 120, 5,  2, 2, 1, 2, 1, 3, 4, 8, 9, 6, 6,  0 ; $42
	char_record 5, $0080, $00a0, $0800, $000c, 1, $0080, 18, 20, 10, 50, 3,  0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0,  0 ; $43
	char_record 6, $0080, $00a0, $0500, $000c, 1, $0080, 18, 24, 12, 40, 0,  1, 2, 4, 2, 3, 2, 3, 3, 4, 4, 4,  4 ; $44
	char_record 6, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $45
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $46
	char_record 6, $0080, $00a0, $0200, $000c, 1, $0080, 40, 0, 12, 40, 1,  1, 2, 4, 2, 3, 2, 3, 9, 9, 4, 4,  0 ; $47
	char_record 6, $0060, $00a0, $0200, $000c, 1, $0080, 40, 0, 12, 40, 3,  1, 2, 2, 2, 3, 2, 3, 9, 9, 9, 4,  0 ; $48
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $49
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4a
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4b
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 20, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4c
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4d
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4e
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4f
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 20, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $50
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $51
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $52
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $53
	char_record 3, $0080, $00a0, $0800, $000c, 1, $0080, 32, 0, 18, 40, 0,  0, 1, 0, 0, 1, 0, 1, 9, 9, 6, 6,  0 ; $54
	char_record 2, $0080, $00a0, $0800, $000c, 1, $0080, 24, 0, 12, 40, 4,  1, 2, 2, 2, 3, 2, 3, 9, 9, 6, 6,  0 ; $55
	char_record 3, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 10, 120, 0,  2, 3, 4, 4, 5, 4, 5, 9, 9, 6, 6,  0 ; $56
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $57
	char_record 5, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 0, 200, 5,  0, 4, 0, 5, 0, 0, 0, 6, 6, 7, 6,  0 ; $58
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $59
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $5a
	char_record 1, $0080, $00a0, $0900, $000c, 5, $0080, 8, 7, 3, 190, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $5b
	char_record 1, $0080, $00a0, $0900, $000c, 6, $0080, 2, 2, 0, 230, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $5c
	char_record 1, $0080, $00a0, $0900, $000c, 7, $0080, 0, 0, 0, 255, 0,  4, 3, 6, 7, 6, 5, 7, 7, 6, 4, 4,  0 ; $5d
	char_record 1, $0080, $00a0, $0900, $000c, 5, $0080, 8, 7, 3, 190, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $5e
	char_record 1, $0080, $00a0, $0900, $000c, 6, $0080, 2, 2, 0, 230, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $5f
	char_record 1, $0080, $00a0, $0900, $000c, 7, $0080, 0, 0, 0, 255, 0,  4, 3, 6, 7, 6, 5, 7, 7, 6, 4, 4,  0 ; $60
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 8, 7, 3, 190, 0,  1, 3, 4, 4, 6, 5, 9, 4, 7, 7, 8,  0 ; $61
	char_record 1, $0080, $00a0, $0800, $000c, 6, $0080, 2, 2, 0, 230, 0,  1, 3, 4, 4, 6, 5, 9, 4, 7, 7, 8,  0 ; $62
	char_record 1, $0080, $00a0, $0800, $000c, 7, $0080, 0, 0, 0, 255, 0,  2, 4, 5, 5, 7, 6, 9, 5, 8, 8, 9,  0 ; $63
CharGroupTable_02:
	; $5e23, 144 bytes (AISHOT_* x 16 per serve style)
	db AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_NEUTRAL, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_NEUTRAL ; serve style 0
	db AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_NEUTRAL, AISHOT_SLICE, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_NEUTRAL ; serve style 1
	db AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_NEUTRAL, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_NEUTRAL, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_LOB, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_DROP ; serve style 2
	db AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_SLICE, AISHOT_TOPSPIN, AISHOT_LOB, AISHOT_DROP ; serve style 3
	db AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL ; serve style 4
	db AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB ; serve style 5
	db AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP ; serve style 6
	db AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_SLICE, AISHOT_POWER_SLICE, AISHOT_NEUTRAL, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB ; serve style 7
	db AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_NEUTRAL, AISHOT_POWER_SLICE, AISHOT_LOB, AISHOT_LOB, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP ; serve style 8
GetCharGroupEntry:
	add a ; $5eb3
	add a ; $5eb4
	add a ; $5eb5
	add a ; $5eb6
	add $23 ; $5eb7
	ld l, a ; $5eb9
	adc $5e ; $5eba
	sub l ; $5ebc
	ld h, a ; $5ebd
	ld a, b ; $5ebe
	and $0f ; $5ebf
	add l ; $5ec1
	ld l, a ; $5ec2
	jr nc, .read ; $5ec3
	inc h ; $5ec5
.read:
	ld a, [hl] ; $5ec6
	ret ; $5ec7
Unused_02_CharGroupFind:
	add a ; $5ec8
	add a ; $5ec9
	add a ; $5eca
	add a ; $5ecb
	ld_hl_indexed CharGroupTable_02 ; $5ecc
	ld b, $10 ; $5ed3
.loop:
	ld a, [hl+] ; $5ed5
	cp $30 ; $5ed6
	jr z, .eq30 ; $5ed8
	dec b ; $5eda
	jr nz, .loop ; $5edb
	xor a ; $5edd
	ret ; $5ede
.eq30:
	ld a, $01 ; $5edf
	ret ; $5ee1
DoesCharGroupRowContain:
	add a ; $5ee2
	add a ; $5ee3
	add a ; $5ee4
	add a ; $5ee5
	ld_hl_indexed CharGroupTable_02 ; $5ee6
	ld c, $10 ; $5eed
.loop:
	ld a, [hl+] ; $5eef
	cp b ; $5ef0
	jr z, .zero ; $5ef1
	dec c ; $5ef3
	jr nz, .loop ; $5ef4
	xor a ; $5ef6
	ret ; $5ef7
.zero:
	ld a, $01 ; $5ef8
	ret ; $5efa
	; $5efb, 8453 bytes fill to bank end (linker-padded)

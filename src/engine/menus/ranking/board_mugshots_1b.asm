Unused_1b_ClearWram3Row64:
	push_wram_bank WRAM_SCREEN ; $4403
	xor a ; $440c
	ld c, $40 ; $440d
.clearLoop:
	ld [hl+], a ; $440f
	dec c ; $4410
	jr nz, .clearLoop ; $4411
	pop_wram_bank ; $4413
	ret ; $4418
Unused_1b_ClearWram3Row64Alt:
	push_wram_bank WRAM_SCREEN ; $4419
	ld a, $00 ; $4422
	ld c, $40 ; $4424
.clearLoop:
	ld [hl+], a ; $4426
	dec c ; $4427
	jr nz, .clearLoop ; $4428
	pop_wram_bank ; $442a
	ret ; $442f
UpdateAnimatedTilesTask:
	farcall UpdateAnimatedTiles ; $4430
	ret ; $4433
	twin_in draw_name_with_diacritics, DrawNameWithDiacritics_1b, 1b ; $4434 DrawNameWithDiacritics_1b
	twin_in draw_decimal_number, Unused_1b_DrawDecimalNumber, 1b ; $446d Unused_1b_DrawDecimalNumber
Unused_1b_DrawAsciiDigitString:
	ld a, [hl+] ; $448e
	and a ; $448f
	jr z, .done ; $4490
	call Unused_1b_DrawAsciiDigitChar ; $4492
	jr Unused_1b_DrawAsciiDigitString ; $4495
.done:
	ret ; $4497
	twin_in draw_ascii_digit_char, Unused_1b_DrawAsciiDigitChar, 1b ; $4498 Unused_1b_DrawAsciiDigitChar
MugshotGfxAlex_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxAlex_1b.bin" ; $44b1, 158 bytes
MugshotGfxNina_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxNina_1b.bin" ; $454f, 163 bytes
MugshotGfxHarry_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxHarry_1b.bin" ; $45f2, 146 bytes
MugshotGfxKate_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxKate_1b.bin" ; $4684, 165 bytes
MugshotGfxMario_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxMario_1b.bin" ; $4729, 162 bytes
MugshotGfxWaluigi_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxWaluigi_1b.bin" ; $47cb, 158 bytes
MugshotGfxYoshi_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxYoshi_1b.bin" ; $4869, 139 bytes
MugshotGfxBowser_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxBowser_1b.bin" ; $48f4, 165 bytes
MugshotGfxWario_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxWario_1b.bin" ; $4999, 162 bytes
MugshotGfxPeach_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxPeach_1b.bin" ; $4a3b, 153 bytes
MugshotGfxEmptySlot1_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxEmptySlot1_1b.bin" ; $4ad4, 110 bytes
MugshotGfxEmptySlot2_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxEmptySlot2_1b.bin" ; $4b42, 147 bytes
MugshotGfxEmptySlot3_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxEmptySlot3_1b.bin" ; $4bd5, 153 bytes
MugshotGfxPlaceholder_1b:
	INCBIN "data/engine/menus/ranking/lz_MugshotGfxPlaceholder_1b.bin" ; $4c6e, 126 bytes
CharMugshotGfxPointers:
	; $4cec, 288 bytes (mugshot_ptr_table)
	dw MugshotGfxAlex_1b, .unused ; $00 Alex
	dw MugshotGfxNina_1b, .unused ; $01 Nina
	dw MugshotGfxHarry_1b, .unused ; $02 Harry
	dw MugshotGfxKate_1b, .unused ; $03 Kate
	dw MugshotGfxPlaceholder_1b, .unused ; $04 Allie
	dw MugshotGfxPlaceholder_1b, .unused ; $05 Joy
	dw MugshotGfxPlaceholder_1b, .unused ; $06 Brian
	dw MugshotGfxPlaceholder_1b, .unused ; $07 Pam
	dw MugshotGfxPlaceholder_1b, .unused ; $08 Bob
	dw MugshotGfxPlaceholder_1b, .unused ; $09 Beth
	dw MugshotGfxPlaceholder_1b, .unused ; $0a Fay
	dw MugshotGfxPlaceholder_1b, .unused ; $0b Curt
	dw MugshotGfxPlaceholder_1b, .unused ; $0c Mark
	dw MugshotGfxPlaceholder_1b, .unused ; $0d Sean
	dw MugshotGfxPlaceholder_1b, .unused ; $0e Sammi
	dw MugshotGfxPlaceholder_1b, .unused ; $0f Elden
	dw MugshotGfxPlaceholder_1b, .unused ; $10 Spike
	dw MugshotGfxPlaceholder_1b, .unused ; $11 Emily
	dw MugshotGfxPlaceholder_1b, .unused ; $12 B. Coz
	dw MugshotGfxPlaceholder_1b, .unused ; $13 A. Coz
	dw MugshotGfxPlaceholder_1b, .unused ; $14 Kevin
	dw MugshotGfxPlaceholder_1b, .unused ; $15 Not used
	dw MugshotGfxPlaceholder_1b, .unused ; $16 Not used
	dw MugshotGfxPlaceholder_1b, .unused ; $17 Luigi
	dw MugshotGfxPlaceholder_1b, .unused ; $18 DK
	dw MugshotGfxPlaceholder_1b, .unused ; $19 Baby M.
	dw MugshotGfxMario_1b, .unused ; $1a Mario
	dw MugshotGfxWaluigi_1b, .unused ; $1b Waluigi
	dw MugshotGfxYoshi_1b, .unused ; $1c Yoshi
	dw MugshotGfxBowser_1b, .unused ; $1d Bowser
	dw MugshotGfxWario_1b, .unused ; $1e Wario
	dw MugshotGfxPeach_1b, .unused ; $1f Peach
	dw MugshotGfxPlaceholder_1b, .unused ; $20 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $21 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $22 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $23 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $24 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $25 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $26 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $27 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $28 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $29 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $2a no character
	dw MugshotGfxPlaceholder_1b, .unused ; $2b no character
	dw MugshotGfxPlaceholder_1b, .unused ; $2c no character
	dw MugshotGfxPlaceholder_1b, .unused ; $2d no character
	dw MugshotGfxPlaceholder_1b, .unused ; $2e no character
	dw MugshotGfxPlaceholder_1b, .unused ; $2f no character
	dw MugshotGfxPlaceholder_1b, .unused ; $30 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $31 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $32 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $33 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $34 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $35 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $36 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $37 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $38 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $39 no character
	dw MugshotGfxPlaceholder_1b, .unused ; $3a no character
	dw MugshotGfxPlaceholder_1b, .unused ; $3b no character
	dw MugshotGfxPlaceholder_1b, .unused ; $3c no character
	dw MugshotGfxPlaceholder_1b, .unused ; $3d no character
	dw MugshotGfxPlaceholder_1b, .unused ; $3e no character
	dw MugshotGfxPlaceholder_1b, .unused ; $3f CHAR_EMPTY_SLOT (remapped to $40 + save slot)
	dw MugshotGfxEmptySlot1_1b, .unusedAlt ; $40 empty save slot 1
	dw MugshotGfxEmptySlot2_1b, .unusedAlt ; $41 empty save slot 2
	dw MugshotGfxEmptySlot3_1b, .unusedAlt ; $42 empty save slot 3
.unused:
	dw $6400, $00ff
.unusedAlt:
	dw $6400, $00ff
.trailer: ; unreferenced
	dw $d600, $d690, $d720, $0000, $0090, $0120
StubNop_1b_0:
	ret ; $4e0c
Unused_1b_ResetMugshotPalettes:
	ld a, $ff ; $4e0d
	ld [wModeScratch], a ; $4e0f
	ld d, $03 ; $4e12
	farcall Unused_18_LoadAllIndexedPalettes ; $4e14
	ret ; $4e17
Unused_1b_SetMugshotAttrs:
	push af ; $4e18
	push de ; $4e19
	push hl ; $4e1a
	and $07 ; $4e1b
	add $03 ; $4e1d
	or $08 ; $4e1f
	ld hl, wDecompBufferHigh tile 64 ; $4e21
	add hl, de ; $4e24
	ld de, $001d ; $4e25
	ld [hl+], a ; $4e28
	ld [hl+], a ; $4e29
	ld [hl+], a ; $4e2a
	add hl, de ; $4e2b
	ld [hl+], a ; $4e2c
	ld [hl+], a ; $4e2d
	ld [hl+], a ; $4e2e
	add hl, de ; $4e2f
	ld [hl+], a ; $4e30
	ld [hl+], a ; $4e31
	ld [hl+], a ; $4e32
	pop hl ; $4e33
	pop de ; $4e34
	pop af ; $4e35
	ret ; $4e36
LoadCharMugshotToBuffer:
	cp $40 ; $4e37
	ret nc ; $4e39
	push de ; $4e3a
	ld de, wMugshotBuffer ; $4e3b
	call DecompressCharMugshot ; $4e3e
	pop de ; $4e41
	ret ; $4e42
Unused_1b_StubNop0:
	ret ; $4e43
Unused_1b_StubNop1:
	ret ; $4e44
Unused_1b_StubNop2:
	ret ; $4e45
CopyMugshotBufferToVram:
	push af ; $4e46
	push bc ; $4e47
	push de ; $4e48
	push hl ; $4e49
	ld hl, wMugshotBuffer ; $4e4a
	ld c, 9 ; $4e4d
	call QueueVRAMCopy ; $4e4f
	pop hl ; $4e52
	pop de ; $4e53
	pop bc ; $4e54
	pop af ; $4e55
	ret ; $4e56
Unused_1b_StubNop3:
	ret ; $4e57
LoadIndexedPaletteThunk:
	farcall LoadIndexedPalette_18 ; $4e58
	ret ; $4e5b
DecompressCharMugshot:
	push af ; $4e5c
	push de ; $4e5d
	push hl ; $4e5e
	call StubNop_1b_0 ; $4e5f
	cp CHAR_EMPTY_SLOT ; $4e62
	jr nz, .gotIndex ; $4e64
	ld b, a ; $4e66
	ld a, [wCurrentStorySlot] ; $4e67
	add b ; $4e6a
	inc a ; $4e6b
.gotIndex:
	ld l, a ; $4e6c
	ld h, $00 ; $4e6d
	add hl, hl ; $4e6f
	add hl, hl ; $4e70
	ld bc, CharMugshotGfxPointers ; $4e71
	add hl, bc ; $4e74
	ld a, [hl+] ; $4e75
	ld h, [hl] ; $4e76
	ld l, a ; $4e77
	call DecompressData ; $4e78
	pop hl ; $4e7b
	pop de ; $4e7c
	pop af ; $4e7d
	ret ; $4e7e
Unused_1b_StubNop4:
	ret ; $4e7f
Unused_1b_StubNop5:
	ret ; $4e80
ShowRankingBoard:
	wram_bank WRAM_SCREEN ; $4e81
	xor a ; $4e87
	ld [wRankingBoardSilent], a ; $4e88
	ld a, b ; $4e8b
	ld [wRankingBoardDoubles], a ; $4e8c
	ld a, c ; $4e8f
	ld [wRankingBoardRound], a ; $4e90
	ld a, d ; $4e93
	ld [wRankingBoardMode], a ; $4e94
	cp RANKINGBOARD_SILENT ; $4e97
	jr nz, .checkWin ; $4e99
	xor a ; $4e9b
	ld [wRankingBoardMode], a ; $4e9c
	ld a, $01 ; $4e9f
	ld [wRankingBoardSilent], a ; $4ea1
.checkWin:
	ld a, [wRankingBoardMode] ; $4ea4
	cp RANKINGBOARD_WIN ; $4ea7
	jr nz, .checkLose ; $4ea9
	sound BGM_ISLAND_OPEN_WIN ; $4eab
	jr .draw ; $4ead
.checkLose:
	cp RANKINGBOARD_LOSE ; $4eaf
	jr nz, .draw ; $4eb1
	sound BGM_ISLAND_OPEN_LOSE ; $4eb3
.draw:
	call DisableLCDSafely ; $4eb5
	call BuildRankingBoardScreen ; $4eb8
	call EnableLCD ; $4ebb
	script_fade_in 4 ; $4ebe
	call WaitFadeEnd ; $4ec3
	wram_bank WRAM_SCREEN ; $4ec6
	call DispatchRankingBoardAnim ; $4ecc
	wait_frames 30 ; $4ecf
	call WaitForAOrBPress ; $4ed3
	ld c, $20 ; $4ed6
	ld a, [wRankingBoardMode] ; $4ed8
	or a ; $4edb
	jr nz, .fadeOut ; $4edc
	ld a, [wRankingBoardSilent] ; $4ede
	or a ; $4ee1
	jr nz, .fadeOut ; $4ee2
	sound SFX_RANKING_BOARD ; $4ee4
	ld c, 2 ; $4ee6
.fadeOut:
	call BeginFadeOut ; $4ee8
	call WaitFadeEnd ; $4eeb
	call ClearFrameTasks ; $4eee
	ret ; $4ef1
BuildRankingBoardScreen:
	xor a ; $4ef2
	ldh [hScrollX], a ; $4ef3
	ldh [hScrollY], a ; $4ef5
	ld [wCameraX], a ; $4ef7
	ld [wCameraX + 1], a ; $4efa
	ld [wCameraY], a ; $4efd
	ld [wCameraY + 1], a ; $4f00
	farcall LoadMenuFontGfx ; $4f03
	farcall PrepareGlyphBuffer ; $4f06
	wram_bank WRAM_SCREEN ; $4f09
	xor a ; $4f0f
	ld [wRankingBannerAnimFrame], a ; $4f10
	ld [wRankingAnimStateDone], a ; $4f13
	ld hl, wRankingMarkerSlots ; $4f16
	ld bc, $0053 ; $4f19
	call ClearBytes ; $4f1c
	call ClearRankingMarkerSlots ; $4f1f
	call LoadRankingMarkerCoords ; $4f22
	ld a, [wRankingBoardDoubles] ; $4f25
	or a ; $4f28
	jr z, .singles ; $4f29
	ld c, SCREENASSET_TournamentBracketDoubles ; $4f2b
	farcall LoadScreenAssetRecord ; $4f2d
	wram_bank WRAM_SCREEN ; $4f30
	call DrawDoublesRankingNames ; $4f36
	call DrawDoublesRoundBracketLines ; $4f39
	jr .loadRankingBoardTiles ; $4f3c
.singles:
	ld c, SCREENASSET_TournamentBracketSingles ; $4f3e
	farcall LoadScreenAssetRecord ; $4f40
	wram_bank WRAM_SCREEN ; $4f43
	call DrawSinglesRankingNames ; $4f49
	call DrawSinglesRoundBracketLines ; $4f4c
.loadRankingBoardTiles:
	call LoadRankingBoardTiles ; $4f4f
	ld hl, RankingBoardScreenPalettes ; $4f52
	ld_obj_pals de, 0, 6 ; $4f55
	call LoadPaletteShadow ; $4f58
	frame_task DrawRankingMarkersTask ; $4f5b
	ld a, [wRankingBoardMode] ; $4f63
	cp RANKINGBOARD_LOSE ; $4f66
	jr nz, .queueWram3MapToVRAM ; $4f68
	frame_task RankingGameOverBobTask ; $4f6a
.queueWram3MapToVRAM:
	farcall QueueWram3MapToVRAM ; $4f72
	ret ; $4f75
RankingBoardScreenPalettes:
	INCLUDE "data/engine/menus/ranking/RankingBoardScreenPalettes.asm" ; $4f76, 48 bytes (palettes)
LoadRankingBoardTiles:
	push_wram_bank WRAM_STAGING ; $4fa6
	ld_slot hl, DataPtr_RankingBoardBallMarkerTiles ; $4faf
	ld de, wDecompBuffer ; $4fb2
	call DecompressDataFromBank ; $4fb5
	ld hl, wDecompBuffer ; $4fb8
	ld de, vTiles0 + VRAM_BANK1 ; $4fbb
	ld c, 16 ; $4fbe
	call QueueVRAMCopy ; $4fc0
	ld_slot hl, DataPtr_CongratulationsSpriteTiles ; $4fc3
	ld de, wDecompBuffer ; $4fc6
	call DecompressDataFromBank ; $4fc9
	ld hl, wDecompBuffer ; $4fcc
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $4fcf
	ld c, 16 ; $4fd2
	call QueueVRAMCopy ; $4fd4
	ld_slot hl, DataPtr_GameOverSpriteTiles ; $4fd7
	ld de, wDecompBuffer ; $4fda
	call DecompressDataFromBank ; $4fdd
	ld hl, wDecompBuffer ; $4fe0
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $4fe3
	ld c, 16 ; $4fe6
	call QueueVRAMCopy ; $4fe8
	pop_wram_bank ; $4feb
	ret ; $4ff0
DispatchRankingBoardAnim:
	ld a, [wRankingBoardSilent] ; $4ff1
	or a ; $4ff4
	ret nz ; $4ff5
	ld a, [wRankingBoardMode] ; $4ff6
	cp RANKINGBOARD_LOSE ; $4ff9
	ret z ; $4ffb
	ld a, [wRankingBoardDoubles] ; $4ffc
	or a ; $4fff
	jr nz, .doubles ; $5000
	ld a, [wRankingBoardMode] ; $5002
	or a ; $5005
	jr nz, .singlesWin ; $5006
	ld a, [wRankingBoardRound] ; $5008
	add a ; $500b
	ld hl, RankingBoardSinglesPlainAnimHandlers ; $500c
	add_hl_a ; $500f
	ld a, [hl+] ; $5014
	ld h, [hl] ; $5015
	ld l, a ; $5016
	jp hl ; $5017
.singlesWin:
	ld a, [wRankingBoardRound] ; $5018
	add a ; $501b
	ld hl, RankingBoardSinglesWinAnimHandlers ; $501c
	add_hl_a ; $501f
	ld a, [hl+] ; $5024
	ld h, [hl] ; $5025
	ld l, a ; $5026
	jp hl ; $5027
.doubles:
	ld a, [wRankingBoardMode] ; $5028
	or a ; $502b
	jr nz, .doublesWin ; $502c
	ld a, [wRankingBoardRound] ; $502e
	add a ; $5031
	ld hl, RankingBoardDoublesPlainAnimHandlers ; $5032
	add_hl_a ; $5035
	ld a, [hl+] ; $503a
	ld h, [hl] ; $503b
	ld l, a ; $503c
	jp hl ; $503d
.doublesWin:
	ld a, [wRankingBoardRound] ; $503e
	add a ; $5041
	ld hl, RankingBoardDoublesWinAnimHandlers ; $5042
	add_hl_a ; $5045
	ld a, [hl+] ; $504a
	ld h, [hl] ; $504b
	ld l, a ; $504c
	jp hl ; $504d
RankingBoardAnimNop_1b:
	ret ; $504e
RankingBoardSinglesWinAnimHandlers:
	; $504f, 10 bytes (records:2)
	dw RankingAnimSinglesClimbRound01 ; record 0
	dw RankingAnimSinglesClimbRound01 ; record 1
	dw RankingAnimSinglesClimbRound2 ; record 2
	dw RankingAnimSinglesClimbRound3 ; record 3
	dw RankingAnimSinglesClimbRound4 ; record 4
RankingBoardSinglesPlainAnimHandlers:
	; $5059, 10 bytes (records:2)
	dw RankingAnimSinglesMarkRound01 ; record 0
	dw RankingAnimSinglesMarkRound01 ; record 1
	dw RankingAnimSinglesMarkRound2 ; record 2
	dw RankingAnimSinglesMarkRound3 ; record 3
	dw RankingAnimSinglesMarkRound4 ; record 4
RankingBoardDoublesWinAnimHandlers:
	; $5063, 10 bytes (records:2)
	dw RankingAnimDoublesClimbRound01 ; record 0
	dw RankingAnimDoublesClimbRound01 ; record 1
	dw RankingAnimDoublesClimbRound2 ; record 2
	dw RankingAnimDoublesClimbRound3 ; record 3
	dw RankingAnimDoublesClimbRound4 ; record 4
RankingBoardDoublesPlainAnimHandlers:
	; $506d, 10 bytes (records:2)
	dw RankingAnimDoublesMarkRound01 ; record 0
	dw RankingAnimDoublesMarkRound01 ; record 1
	dw RankingAnimDoublesMarkRound2 ; record 2
	dw RankingAnimDoublesMarkRound3 ; record 3
	dw RankingAnimDoublesMarkRound4 ; record 4
RankingAnimSinglesClimbRound01:
	frame_task RankingCongratsSlideTask ; $5077
	wait_frames 140 ; $507f
	sound SFX_MARKER ; $5083
	ld c, $00 ; $5085
	call GetRankingMarkerSlot ; $5087
	ld de, RankingAnimSinglesClimbRound01Plus12 ; $508a
	call StartRankingMarkerSlideY0 ; $508d
	ld c, $01 ; $5090
	call GetRankingMarkerSlot ; $5092
	ld de, RankingAnimSinglesClimbRound01Minus8 ; $5095
	call StartRankingMarkerSlideX1 ; $5098
	ld b, $01 ; $509b
	call DrawSinglesBracketLine ; $509d
	call PushRankingBoardTilemapRows ; $50a0
	wait_frames 30 ; $50a3
	sound SFX_RANKING_HIGHLIGHT ; $50a7
	ld c, $03 ; $50a9
	call GetRankingMarkerSlot ; $50ab
	ld de, RankingAnimSinglesClimbRound01Plus8 ; $50ae
	call StartRankingMarkerSlideX0 ; $50b1
	ld c, $04 ; $50b4
	call GetRankingMarkerSlot ; $50b6
	ld de, RankingAnimSinglesClimbRound01Plus8 ; $50b9
	call StartRankingMarkerSlideX1 ; $50bc
	wait_frames 90 ; $50bf
	sound SFX_MARKER ; $50c3
	ld c, $03 ; $50c5
	call GetRankingMarkerSlot ; $50c7
	ld de, RankingAnimSinglesClimbRound01Plus12 ; $50ca
	call StartRankingMarkerSlideY0 ; $50cd
	ld c, $04 ; $50d0
	call GetRankingMarkerSlot ; $50d2
	ld de, RankingAnimSinglesClimbRound01Minus8 ; $50d5
	call StartRankingMarkerSlideX1 ; $50d8
	ld b, $02 ; $50db
	call DrawSinglesBracketLine ; $50dd
	call PushRankingBoardTilemapRows ; $50e0
	wait_frames 30 ; $50e3
	sound SFX_RANKING_HIGHLIGHT ; $50e7
	ld c, $06 ; $50e9
	call GetRankingMarkerSlot ; $50eb
	ld de, RankingAnimSinglesClimbRound01Minus7 ; $50ee
	call StartRankingMarkerSlideX0 ; $50f1
	ld c, $07 ; $50f4
	call GetRankingMarkerSlot ; $50f6
	ld de, RankingAnimSinglesClimbRound01Minus7 ; $50f9
	call StartRankingMarkerSlideX1 ; $50fc
	wait_frames 90 ; $50ff
	sound SFX_MARKER ; $5103
	ld c, $06 ; $5105
	call GetRankingMarkerSlot ; $5107
	ld de, RankingAnimSinglesClimbRound01Plus12 ; $510a
	call StartRankingMarkerSlideY0 ; $510d
	ld c, $07 ; $5110
	call GetRankingMarkerSlot ; $5112
	ld de, RankingAnimSinglesClimbRound01Plus7 ; $5115
	call StartRankingMarkerSlideX1 ; $5118
	ld b, $03 ; $511b
	call DrawSinglesBracketLine ; $511d
	call PushRankingBoardTilemapRows ; $5120
	wait_frames 30 ; $5123
	sound SFX_RANKING_HIGHLIGHT ; $5127
	ld c, $09 ; $5129
	call GetRankingMarkerSlot ; $512b
	ld de, RankingAnimSinglesClimbRound01Minus7 ; $512e
	call StartRankingMarkerSlideX0 ; $5131
	ld c, $0a ; $5134
	call GetRankingMarkerSlot ; $5136
	ld de, RankingAnimSinglesClimbRound01Minus7 ; $5139
	call StartRankingMarkerSlideX1 ; $513c
	wait_frames 90 ; $513f
	sound SFX_MARKER ; $5143
	ld c, $09 ; $5145
	call GetRankingMarkerSlot ; $5147
	ld de, RankingAnimSinglesClimbRound01Plus12 ; $514a
	call StartRankingMarkerSlideY0 ; $514d
	ld c, $0a ; $5150
	call GetRankingMarkerSlot ; $5152
	ld de, RankingAnimSinglesClimbRound01Plus7 ; $5155
	call StartRankingMarkerSlideX1 ; $5158
	ld b, $04 ; $515b
	call DrawSinglesBracketLine ; $515d
	call PushRankingBoardTilemapRows ; $5160
	wait_frames 30 ; $5163
	ld a, $01 ; $5167
	ld [wRankingAnimStateDone], a ; $5169
	jp RankingBoardAnimNop_1b ; $516c
RankingAnimSinglesClimbRound2:
	frame_task RankingCongratsSlideTask ; $516f
	wait_frames 140 ; $5177
	sound SFX_MARKER ; $517b
	ld c, $00 ; $517d
	call GetRankingMarkerSlot ; $517f
	ld de, RankingAnimSinglesClimbRound2Plus16 ; $5182
	call StartRankingMarkerSlideY0 ; $5185
	ld c, $02 ; $5188
	call GetRankingMarkerSlot ; $518a
	ld de, RankingAnimSinglesClimbRound2Minus16 ; $518d
	call StartRankingMarkerSlideX1 ; $5190
	ld b, $05 ; $5193
	call DrawSinglesBracketLine ; $5195
	call PushRankingBoardTilemapRows ; $5198
	wait_frames 30 ; $519b
	sound SFX_RANKING_HIGHLIGHT ; $519f
	ld c, $05 ; $51a1
	call GetRankingMarkerSlot ; $51a3
	ld de, RankingAnimSinglesClimbRound2Plus16 ; $51a6
	call StartRankingMarkerSlideX1 ; $51a9
	wait_frames 4 ; $51ac
	ld c, $03 ; $51b0
	call GetRankingMarkerSlot ; $51b2
	ld de, RankingAnimSinglesClimbRound2Plus8 ; $51b5
	call StartRankingMarkerSlideX0 ; $51b8
	wait_frames 120 ; $51bb
	sound SFX_MARKER ; $51bf
	ld c, $05 ; $51c1
	call GetRankingMarkerSlot ; $51c3
	ld de, RankingAnimSinglesClimbRound2Minus16 ; $51c6
	call StartRankingMarkerSlideY1 ; $51c9
	ld c, $03 ; $51cc
	call GetRankingMarkerSlot ; $51ce
	ld de, RankingAnimSinglesClimbRound2Minus8 ; $51d1
	call StartRankingMarkerSlideX0 ; $51d4
	ld b, $06 ; $51d7
	call DrawSinglesBracketLine ; $51d9
	call PushRankingBoardTilemapRows ; $51dc
	wait_frames 30 ; $51df
	sound SFX_RANKING_HIGHLIGHT ; $51e3
	ld c, $08 ; $51e5
	call GetRankingMarkerSlot ; $51e7
	ld de, RankingAnimSinglesClimbRound2Minus15 ; $51ea
	call StartRankingMarkerSlideX1 ; $51ed
	wait_frames 4 ; $51f0
	ld c, $06 ; $51f4
	call GetRankingMarkerSlot ; $51f6
	ld de, RankingAnimSinglesClimbRound2Minus8 ; $51f9
	call StartRankingMarkerSlideX0 ; $51fc
	wait_frames 90 ; $51ff
	sound SFX_MARKER ; $5203
	ld c, $08 ; $5205
	call GetRankingMarkerSlot ; $5207
	ld de, RankingAnimSinglesClimbRound2Minus16 ; $520a
	call StartRankingMarkerSlideY1 ; $520d
	ld c, $06 ; $5210
	call GetRankingMarkerSlot ; $5212
	ld de, RankingAnimSinglesClimbRound2Plus8 ; $5215
	call StartRankingMarkerSlideX0 ; $5218
	ld b, $07 ; $521b
	call DrawSinglesBracketLine ; $521d
	call PushRankingBoardTilemapRows ; $5220
	wait_frames 30 ; $5223
	sound SFX_RANKING_HIGHLIGHT ; $5227
	ld c, $0b ; $5229
	call GetRankingMarkerSlot ; $522b
	ld de, RankingAnimSinglesClimbRound2Minus15 ; $522e
	call StartRankingMarkerSlideX1 ; $5231
	wait_frames 4 ; $5234
	ld c, $09 ; $5238
	call GetRankingMarkerSlot ; $523a
	ld de, RankingAnimSinglesClimbRound2Minus8 ; $523d
	call StartRankingMarkerSlideX0 ; $5240
	wait_frames 90 ; $5243
	sound SFX_MARKER ; $5247
	ld c, $0b ; $5249
	call GetRankingMarkerSlot ; $524b
	ld de, RankingAnimSinglesClimbRound2Plus15 ; $524e
	call StartRankingMarkerSlideX1 ; $5251
	ld c, $09 ; $5254
	call GetRankingMarkerSlot ; $5256
	ld de, RankingAnimSinglesClimbRound2Plus16 ; $5259
	call StartRankingMarkerSlideY0 ; $525c
	ld b, $08 ; $525f
	call DrawSinglesBracketLine ; $5261
	call PushRankingBoardTilemapRows ; $5264
	wait_frames 30 ; $5267
	ld a, $01 ; $526b
	ld [wRankingAnimStateDone], a ; $526d
	jp RankingBoardAnimNop_1b ; $5270
RankingAnimSinglesClimbRound3:
	frame_task RankingCongratsSlideTask ; $5273
	wait_frames 140 ; $527b
	sound SFX_MARKER ; $527f
	ld c, $00 ; $5281
	call GetRankingMarkerSlot ; $5283
	ld de, RankingAnimSinglesClimbRound3Plus36 ; $5286
	call StartRankingMarkerSlideY0 ; $5289
	ld c, $05 ; $528c
	call GetRankingMarkerSlot ; $528e
	ld de, RankingAnimSinglesClimbRound2Minus8 ; $5291
	call StartRankingMarkerSlideX0 ; $5294
	ld b, $09 ; $5297
	call DrawSinglesBracketLine ; $5299
	call PushRankingBoardTilemapRows ; $529c
	wait_frames 90 ; $529f
	sound SFX_RANKING_HIGHLIGHT ; $52a3
	ld c, $08 ; $52a5
	call GetRankingMarkerSlot ; $52a7
	ld de, RankingAnimSinglesClimbRound2Minus8 ; $52aa
	call StartRankingMarkerSlideX0 ; $52ad
	ld c, $09 ; $52b0
	call GetRankingMarkerSlot ; $52b2
	ld de, RankingAnimSinglesClimbRound2Minus8 ; $52b5
	call StartRankingMarkerSlideX1 ; $52b8
	wait_frames 90 ; $52bb
	sound SFX_MARKER ; $52bf
	ld c, $08 ; $52c1
	call GetRankingMarkerSlot ; $52c3
	ld de, RankingAnimSinglesClimbRound01Plus7 ; $52c6
	call StartRankingMarkerSlideX0 ; $52c9
	ld c, $09 ; $52cc
	call GetRankingMarkerSlot ; $52ce
	ld de, RankingAnimSinglesClimbRound3Minus36 ; $52d1
	call StartRankingMarkerSlideY1 ; $52d4
	ld b, $0a ; $52d7
	call DrawSinglesBracketLine ; $52d9
	call PushRankingBoardTilemapRows ; $52dc
	wait_frames 30 ; $52df
	ld a, $01 ; $52e3
	ld [wRankingAnimStateDone], a ; $52e5
	jp RankingBoardAnimNop_1b ; $52e8
RankingAnimSinglesClimbRound4:
	frame_task RankingCongratsSlideTask ; $52eb
	wait_frames 140 ; $52f3
	ld a, $01 ; $52f7
	ld [wRankingAnimStateDone], a ; $52f9
	jp RankingBoardAnimNop_1b ; $52fc
RankingAnimSinglesMarkRound01:
	wait_frames 20 ; $52ff
	sound SFX_RANKING_HIGHLIGHT ; $5303
	ld c, $00 ; $5305
	call GetRankingMarkerSlot ; $5307
	ld de, RankingAnimSinglesClimbRound01Plus8 ; $530a
	call StartRankingMarkerSlideX0 ; $530d
	ld c, $01 ; $5310
	call GetRankingMarkerSlot ; $5312
	ld de, RankingAnimSinglesClimbRound01Plus8 ; $5315
	call StartRankingMarkerSlideX1 ; $5318
	wait_frames 20 ; $531b
	jp RankingBoardAnimNop_1b ; $531f
RankingAnimSinglesMarkRound2:
	wait_frames 10 ; $5322
	sound SFX_RANKING_HIGHLIGHT ; $5326
	ld c, $02 ; $5328
	call GetRankingMarkerSlot ; $532a
	ld de, RankingAnimSinglesClimbRound2Plus16 ; $532d
	call StartRankingMarkerSlideX1 ; $5330
	wait_frames 4 ; $5333
	ld c, $00 ; $5337
	call GetRankingMarkerSlot ; $5339
	ld de, RankingAnimSinglesClimbRound2Plus8 ; $533c
	call StartRankingMarkerSlideX0 ; $533f
	wait_frames 20 ; $5342
	jp RankingBoardAnimNop_1b ; $5346
RankingAnimSinglesMarkRound3:
	wait_frames 20 ; $5349
	sound SFX_RANKING_HIGHLIGHT ; $534d
	ld c, $00 ; $534f
	call GetRankingMarkerSlot ; $5351
	ld de, RankingAnimSinglesClimbRound01Plus8 ; $5354
	call StartRankingMarkerSlideX0 ; $5357
	ld c, $05 ; $535a
	call GetRankingMarkerSlot ; $535c
	ld de, RankingAnimSinglesClimbRound01Plus8 ; $535f
	call StartRankingMarkerSlideX1 ; $5362
	jp RankingBoardAnimNop_1b ; $5365
RankingAnimSinglesMarkRound4:
	wait_frames 30 ; $5368
	sound SFX_RANKING_HIGHLIGHT ; $536c
	ld c, $00 ; $536e
	call GetRankingMarkerSlot ; $5370
	ld de, RankingAnimSinglesMarkRound4Plus4 ; $5373
	call StartRankingMarkerSlideX0 ; $5376
	ld c, $09 ; $5379
	call GetRankingMarkerSlot ; $537b
	ld de, RankingAnimSinglesMarkRound4Minus4 ; $537e
	call StartRankingMarkerSlideX1 ; $5381
	jp RankingBoardAnimNop_1b ; $5384
RankingAnimDoublesClimbRound01:
	frame_task RankingCongratsSlideTask ; $5387
	wait_frames 140 ; $538f
	sound SFX_MARKER ; $5393
	ld c, $00 ; $5395
	call GetRankingMarkerSlot ; $5397
	ld de, RankingAnimDoublesClimbRound01Plus20 ; $539a
	call StartRankingMarkerSlideY0 ; $539d
	ld c, $01 ; $53a0
	call GetRankingMarkerSlot ; $53a2
	ld de, RankingAnimSinglesClimbRound2Minus8 ; $53a5
	call StartRankingMarkerSlideX1 ; $53a8
	ld b, $01 ; $53ab
	call DrawDoublesBracketLine ; $53ad
	call PushRankingBoardTilemapRows ; $53b0
	wait_frames 90 ; $53b3
	sound SFX_RANKING_HIGHLIGHT ; $53b7
	ld c, $03 ; $53b9
	call GetRankingMarkerSlot ; $53bb
	ld de, RankingAnimSinglesClimbRound2Minus8 ; $53be
	call StartRankingMarkerSlideX0 ; $53c1
	ld c, $04 ; $53c4
	call GetRankingMarkerSlot ; $53c6
	ld de, RankingAnimSinglesClimbRound01Minus7 ; $53c9
	call StartRankingMarkerSlideX1 ; $53cc
	wait_frames 90 ; $53cf
	sound SFX_MARKER ; $53d3
	ld c, $03 ; $53d5
	call GetRankingMarkerSlot ; $53d7
	ld de, RankingAnimDoublesClimbRound01Plus20 ; $53da
	call StartRankingMarkerSlideY0 ; $53dd
	ld c, $04 ; $53e0
	call GetRankingMarkerSlot ; $53e2
	ld de, RankingAnimDoublesClimbRound01Plus6 ; $53e5
	call StartRankingMarkerSlideX1 ; $53e8
	ld b, $02 ; $53eb
	call DrawDoublesBracketLine ; $53ed
	call PushRankingBoardTilemapRows ; $53f0
	wait_frames 90 ; $53f3
	jp RankingBoardAnimNop_1b ; $53f7
RankingAnimDoublesClimbRound2:
	frame_task RankingCongratsSlideTask ; $53fa
	wait_frames 140 ; $5402
	sound SFX_MARKER ; $5406
	ld c, $00 ; $5408
	call GetRankingMarkerSlot ; $540a
	ld de, RankingAnimDoublesClimbRound2Plus28 ; $540d
	call StartRankingMarkerSlideY0 ; $5410
	ld c, $02 ; $5413
	call GetRankingMarkerSlot ; $5415
	ld de, RankingAnimSinglesClimbRound2Minus16 ; $5418
	call StartRankingMarkerSlideX1 ; $541b
	ld b, $03 ; $541e
	call DrawDoublesBracketLine ; $5420
	call PushRankingBoardTilemapRows ; $5423
	wait_frames 90 ; $5426
	sound SFX_RANKING_HIGHLIGHT ; $542a
	ld c, $03 ; $542c
	call GetRankingMarkerSlot ; $542e
	ld de, RankingAnimSinglesClimbRound2Minus8 ; $5431
	call StartRankingMarkerSlideX0 ; $5434
	ld c, $05 ; $5437
	call GetRankingMarkerSlot ; $5439
	ld de, RankingAnimSinglesClimbRound2Minus16 ; $543c
	call StartRankingMarkerSlideX1 ; $543f
	wait_frames 140 ; $5442
	sound SFX_MARKER ; $5446
	ld c, $03 ; $5448
	call GetRankingMarkerSlot ; $544a
	ld de, RankingAnimDoublesClimbRound2Plus28 ; $544d
	call StartRankingMarkerSlideY0 ; $5450
	ld c, $05 ; $5453
	call GetRankingMarkerSlot ; $5455
	ld de, RankingAnimSinglesClimbRound2Plus16 ; $5458
	call StartRankingMarkerSlideX1 ; $545b
	ld b, $04 ; $545e
	call DrawDoublesBracketLine ; $5460
	call PushRankingBoardTilemapRows ; $5463
	wait_frames 30 ; $5466
	jp RankingBoardAnimNop_1b ; $546a
RankingAnimDoublesClimbRound3:
	frame_task RankingCongratsSlideTask ; $546d
	wait_frames 140 ; $5475
	sound SFX_MARKER ; $5479
	ld c, $00 ; $547b
	call GetRankingMarkerSlot ; $547d
	ld de, RankingAnimDoublesClimbRound3Plus4 ; $5480
	call StartRankingMarkerSlideX0 ; $5483
	ld c, $03 ; $5486
	call GetRankingMarkerSlot ; $5488
	ld de, RankingAnimSinglesClimbRound01Plus8 ; $548b
	call StartRankingMarkerSlideX1 ; $548e
	ld b, $06 ; $5491
	call DrawDoublesBracketLine ; $5493
	call PushRankingBoardTilemapRows ; $5496
	wait_frames 30 ; $5499
	jp RankingBoardAnimNop_1b ; $549d
RankingAnimDoublesClimbRound4:
	jp RankingBoardAnimNop_1b ; $54a0
RankingAnimDoublesMarkRound01:
	wait_frames 30 ; $54a3
	sound SFX_RANKING_HIGHLIGHT ; $54a7
	ld c, $00 ; $54a9
	call GetRankingMarkerSlot ; $54ab
	ld de, RankingAnimSinglesClimbRound01Plus8 ; $54ae
	call StartRankingMarkerSlideX0 ; $54b1
	ld c, $01 ; $54b4
	call GetRankingMarkerSlot ; $54b6
	ld de, RankingAnimSinglesClimbRound01Plus8 ; $54b9
	call StartRankingMarkerSlideX1 ; $54bc
	jp RankingBoardAnimNop_1b ; $54bf
RankingAnimDoublesMarkRound2:
	wait_frames 30 ; $54c2
	sound SFX_RANKING_HIGHLIGHT ; $54c6
	ld c, $02 ; $54c8
	call GetRankingMarkerSlot ; $54ca
	ld de, RankingAnimSinglesClimbRound2Plus16 ; $54cd
	call StartRankingMarkerSlideX1 ; $54d0
	wait_frames 8 ; $54d3
	ld c, $00 ; $54d7
	call GetRankingMarkerSlot ; $54d9
	ld de, RankingAnimSinglesClimbRound01Plus8 ; $54dc
	call StartRankingMarkerSlideX0 ; $54df
	jp RankingBoardAnimNop_1b ; $54e2
RankingAnimDoublesMarkRound3:
	wait_frames 30 ; $54e5
	sound SFX_RANKING_HIGHLIGHT ; $54e9
	ld c, $00 ; $54eb
	call GetRankingMarkerSlot ; $54ed
	ld de, RankingAnimSinglesClimbRound01Plus8 ; $54f0
	call StartRankingMarkerSlideX0 ; $54f3
	ld c, $03 ; $54f6
	call GetRankingMarkerSlot ; $54f8
	ld de, RankingAnimSinglesClimbRound01Minus7 ; $54fb
	call StartRankingMarkerSlideX1 ; $54fe
	jp RankingBoardAnimNop_1b ; $5501
RankingAnimDoublesMarkRound4:
	jp RankingBoardAnimNop_1b ; $5504

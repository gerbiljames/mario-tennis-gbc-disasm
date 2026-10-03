Unused_1b_ClearWram3Row64:
	push_wram_bank WRAM_SCREEN ; $4403
	xor a ; $440c
	ld c, $40 ; $440d
.loop2:
	ld [hl+], a ; $440f
	dec c ; $4410
	jr nz, .loop2 ; $4411
	pop_wram_bank ; $4413
	ret ; $4418
Unused_1b_ClearWram3Row64Alt:
	push_wram_bank WRAM_SCREEN ; $4419
	ld a, $00 ; $4422
	ld c, $40 ; $4424
.loop3:
	ld [hl+], a ; $4426
	dec c ; $4427
	jr nz, .loop3 ; $4428
	pop_wram_bank ; $442a
	ret ; $442f
UpdateAnimatedTilesTask:
	farcall UpdateAnimatedTiles ; $4430
	ret ; $4433
; Instruction-identical to Unused_17_DrawNameWithDiacritics and Unused_3e_DrawNameWithDiacritics (one copy per bank); a change here belongs in every copy.
	twin_in draw_name_with_diacritics, DrawNameWithDiacritics_1b, 1b ; $4434 DrawNameWithDiacritics_1b
; Instruction-identical to Unused_17_DrawDecimalNumber, Unused_3b_DrawDecimalNumber and Unused_3e_DrawDecimalNumber (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in draw_decimal_number, Unused_1b_DrawDecimalNumber, 1b ; $446d Unused_1b_DrawDecimalNumber
Unused_1b_DrawAsciiDigitString:
	ld a, [hl+] ; $448e
	and a ; $448f
	jr z, .done ; $4490
	call Unused_1b_DrawAsciiDigitChar ; $4492
	jr Unused_1b_DrawAsciiDigitString ; $4495
.done:
	ret ; $4497
; Instruction-identical to Unused_16_DrawAsciiDigitChar, Unused_17_DrawAsciiDigitChar, Unused_3b_DrawAsciiDigitChar and Unused_3e_DrawAsciiDigitChar (one copy per bank); a change here belongs in every copy.
	twin_in draw_ascii_digit_char, Unused_1b_DrawAsciiDigitChar, 1b ; $4498 Unused_1b_DrawAsciiDigitChar
MugshotGfxAlex_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxAlex_1b.bin" ; $44b1, 158 bytes
MugshotGfxNina_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxNina_1b.bin" ; $454f, 163 bytes
MugshotGfxHarry_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxHarry_1b.bin" ; $45f2, 146 bytes
MugshotGfxKate_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxKate_1b.bin" ; $4684, 165 bytes
MugshotGfxMario_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxMario_1b.bin" ; $4729, 162 bytes
MugshotGfxWaluigi_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxWaluigi_1b.bin" ; $47cb, 158 bytes
MugshotGfxYoshi_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxYoshi_1b.bin" ; $4869, 139 bytes
MugshotGfxBowser_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxBowser_1b.bin" ; $48f4, 165 bytes
MugshotGfxWario_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxWario_1b.bin" ; $4999, 162 bytes
MugshotGfxPeach_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxPeach_1b.bin" ; $4a3b, 153 bytes
MugshotGfxStorySlot1_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxStorySlot1_1b.bin" ; $4ad4, 110 bytes
MugshotGfxStorySlot2_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxStorySlot2_1b.bin" ; $4b42, 147 bytes
MugshotGfxStorySlot3_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxStorySlot3_1b.bin" ; $4bd5, 153 bytes
MugshotGfxPlaceholder_1b:
	INCBIN "data/bank_01b/lz_MugshotGfxPlaceholder_1b.bin" ; $4c6e, 126 bytes
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
	dw MugshotGfxPlaceholder_1b, .unused ; $3f story hero (remapped to $40 + save slot)
	dw MugshotGfxStorySlot1_1b, .unusedAlt ; $40 story hero, save slot 1
	dw MugshotGfxStorySlot2_1b, .unusedAlt ; $41 story hero, save slot 2
	dw MugshotGfxStorySlot3_1b, .unusedAlt ; $42 story hero, save slot 3
.unused:
	dw $6400, $00ff
.unusedAlt:
	dw $6400, $00ff
.trailer: ; unreferenced
	dw $d600, $d690, $d720, $0000, $0090, $0120
StubNop_1b_00:
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
	ld hl, wTextTileBuffer + 64 * TILE_SIZE ; $4e21
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
Unused_1b_StubNop_1b_01:
	ret ; $4e43
Unused_1b_StubNop_1b_02:
	ret ; $4e44
Unused_1b_StubNop_1b_03:
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
Unused_1b_StubNop_1b_04:
	ret ; $4e57
LoadIndexedPaletteThunk:
	farcall LoadIndexedPalette_18 ; $4e58
	ret ; $4e5b
DecompressCharMugshot:
	push af ; $4e5c
	push de ; $4e5d
	push hl ; $4e5e
	call StubNop_1b_00 ; $4e5f
	cp $3f ; $4e62
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
Unused_1b_StubNop_1b_05:
	ret ; $4e7f
Unused_1b_StubNop_1b_06:
	ret ; $4e80
ShowRankingBoard:
	wram_bank WRAM_SCREEN ; $4e81
	xor a ; $4e87
	ld [wRankingBoardSilent], a ; $4e88
	ld a, b ; $4e8b
	ld [wRankingBoardDoubles], a ; $4e8c
	ld a, c ; $4e8f
	ld [wRankingBoardPlayerRow], a ; $4e90
	ld a, d ; $4e93
	ld [wRankingBoardMode], a ; $4e94
	cp $03 ; $4e97
	jr nz, .checkFanfare ; $4e99
	xor a ; $4e9b
	ld [wRankingBoardMode], a ; $4e9c
	ld a, $01 ; $4e9f
	ld [wRankingBoardSilent], a ; $4ea1
.checkFanfare:
	ld a, [wRankingBoardMode] ; $4ea4
	cp $01 ; $4ea7
	jr nz, .checkSecondFanfare ; $4ea9
	sound BGM_ISLAND_OPEN_WIN ; $4eab
	jr .draw ; $4ead
.checkSecondFanfare:
	cp $02 ; $4eaf
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
	jr z, .zero ; $4f29
	ld c, SCREENASSET_TournamentBracketDoubles ; $4f2b
	farcall LoadScreenAssetRecord ; $4f2d
	wram_bank WRAM_SCREEN ; $4f30
	call DrawDoublesRankingNames ; $4f36
	call HighlightDoublesRankingRows ; $4f39
	jr .loadRankingBoardTiles ; $4f3c
.zero:
	ld c, SCREENASSET_TournamentBracketSingles ; $4f3e
	farcall LoadScreenAssetRecord ; $4f40
	wram_bank WRAM_SCREEN ; $4f43
	call DrawSinglesRankingNames ; $4f49
	call HighlightSinglesRankingRows ; $4f4c
.loadRankingBoardTiles:
	call LoadRankingBoardTiles ; $4f4f
	ld hl, RankingBoardScreenPalettes ; $4f52
	ld_obj_pals de, 0, 6 ; $4f55
	call LoadPaletteShadow ; $4f58
	ld a, $01 ; $4f5b
	ld hl, DrawRankingMarkersTask ; $4f5d
	call RegisterFrameTask ; $4f60
	ld a, [wRankingBoardMode] ; $4f63
	cp $02 ; $4f66
	jr nz, .queueWram3MapToVRAM ; $4f68
	ld a, $01 ; $4f6a
	ld hl, RankingCursorBobTask ; $4f6c
	call RegisterFrameTask ; $4f6f
.queueWram3MapToVRAM:
	farcall QueueWram3MapToVRAM ; $4f72
	ret ; $4f75
RankingBoardScreenPalettes:
	INCLUDE "data/bank_01b/RankingBoardScreenPalettes.asm" ; $4f76, 48 bytes (palettes)
LoadRankingBoardTiles:
	push_wram_bank WRAM_STAGING ; $4fa6
	ld_slot hl, DataPtr_BracketCharIcon00 ; $4faf
	ld de, wDecompBuffer ; $4fb2
	call DecompressDataFromBank ; $4fb5
	ld hl, wDecompBuffer ; $4fb8
	ld de, vTiles0 + VRAM_BANK1 ; $4fbb
	ld c, 16 ; $4fbe
	call QueueVRAMCopy ; $4fc0
	ld_slot hl, DataPtr_BracketCharIcon01 ; $4fc3
	ld de, wDecompBuffer ; $4fc6
	call DecompressDataFromBank ; $4fc9
	ld hl, wDecompBuffer ; $4fcc
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $4fcf
	ld c, 16 ; $4fd2
	call QueueVRAMCopy ; $4fd4
	ld_slot hl, DataPtr_BracketCharIcon02 ; $4fd7
	ld de, wDecompBuffer ; $4fda
	call DecompressDataFromBank ; $4fdd
	ld hl, wDecompBuffer ; $4fe0
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $4fe3
	ld c, 16 ; $4fe6
	call QueueVRAMCopy ; $4fe8
	pop_wram_bank ; $4feb
	ret ; $4ff0
DispatchRankingBoardAnim:
	ld a, [wRankingBoardSilent] ; $4ff1
	or a ; $4ff4
	ret nz ; $4ff5
	ld a, [wRankingBoardMode] ; $4ff6
	cp $02 ; $4ff9
	ret z ; $4ffb
	ld a, [wRankingBoardDoubles] ; $4ffc
	or a ; $4fff
	jr nz, .nonZero2 ; $5000
	ld a, [wRankingBoardMode] ; $5002
	or a ; $5005
	jr nz, .nonZero ; $5006
	ld a, [wRankingBoardPlayerRow] ; $5008
	add a ; $500b
	ld hl, RankingBoardAnimHandlers2_1b ; $500c
	add l ; $500f
	ld l, a ; $5010
	jr nc, .read ; $5011
	inc h ; $5013
.read:
	ld a, [hl+] ; $5014
	ld h, [hl] ; $5015
	ld l, a ; $5016
	jp hl ; $5017
.nonZero:
	ld a, [wRankingBoardPlayerRow] ; $5018
	add a ; $501b
	ld hl, RankingBoardAnimHandlers1_1b ; $501c
	add l ; $501f
	ld l, a ; $5020
	jr nc, .readB ; $5021
	inc h ; $5023
.readB:
	ld a, [hl+] ; $5024
	ld h, [hl] ; $5025
	ld l, a ; $5026
	jp hl ; $5027
.nonZero2:
	ld a, [wRankingBoardMode] ; $5028
	or a ; $502b
	jr nz, .nonZero3 ; $502c
	ld a, [wRankingBoardPlayerRow] ; $502e
	add a ; $5031
	ld hl, RankingBoardAnimHandlers4_1b ; $5032
	add l ; $5035
	ld l, a ; $5036
	jr nc, .read2 ; $5037
	inc h ; $5039
.read2:
	ld a, [hl+] ; $503a
	ld h, [hl] ; $503b
	ld l, a ; $503c
	jp hl ; $503d
.nonZero3:
	ld a, [wRankingBoardPlayerRow] ; $503e
	add a ; $5041
	ld hl, RankingBoardAnimHandlers3_1b ; $5042
	add l ; $5045
	ld l, a ; $5046
	jr nc, .read3 ; $5047
	inc h ; $5049
.read3:
	ld a, [hl+] ; $504a
	ld h, [hl] ; $504b
	ld l, a ; $504c
	jp hl ; $504d
RankingBoardAnimNop_1b:
	ret ; $504e
RankingBoardAnimHandlers1_1b:
	; $504f, 10 bytes (records:2)
	dw RankingBoardAnimState_5077_1b ; record 0
	dw RankingBoardAnimState_5077_1b ; record 1
	dw RankingBoardAnimState_516f_1b ; record 2
	dw RankingBoardAnimState_5273_1b ; record 3
	dw RankingBoardAnimState_52eb_1b ; record 4
RankingBoardAnimHandlers2_1b:
	; $5059, 10 bytes (records:2)
	dw RankingBoardAnimState_52ff_1b ; record 0
	dw RankingBoardAnimState_52ff_1b ; record 1
	dw RankingBoardAnimState_5322_1b ; record 2
	dw RankingBoardAnimState_5349_1b ; record 3
	dw RankingBoardAnimState_5368_1b ; record 4
RankingBoardAnimHandlers3_1b:
	; $5063, 10 bytes (records:2)
	dw RankingBoardAnimState_5387_1b ; record 0
	dw RankingBoardAnimState_5387_1b ; record 1
	dw RankingBoardAnimState_53fa_1b ; record 2
	dw RankingBoardAnimState_546d_1b ; record 3
	dw RankingBoardAnimState_54a0_1b ; record 4
RankingBoardAnimHandlers4_1b:
	; $506d, 10 bytes (records:2)
	dw RankingBoardAnimState_54a3_1b ; record 0
	dw RankingBoardAnimState_54a3_1b ; record 1
	dw RankingBoardAnimState_54c2_1b ; record 2
	dw RankingBoardAnimState_54e5_1b ; record 3
	dw RankingBoardAnimState_5504_1b ; record 4
RankingBoardAnimState_5077_1b:
	ld a, $01 ; $5077
	ld hl, RankingBoardAnimTask_1b ; $5079
	call RegisterFrameTask ; $507c
	wait_frames 140 ; $507f
	sound SFX_MARKER ; $5083
	ld c, $00 ; $5085
	call GetRankingMarkerSlot ; $5087
	ld de, RankingBoardAnimState_5077Table3 ; $508a
	call StartRankingMarkerAnim2 ; $508d
	ld c, $01 ; $5090
	call GetRankingMarkerSlot ; $5092
	ld de, RankingBoardAnimState_5077Table4 ; $5095
	call StartRankingMarkerAnim1 ; $5098
	ld b, $01 ; $509b
	call HighlightRankingRow ; $509d
	call PushRankingBoardTilemapRows ; $50a0
	wait_frames 30 ; $50a3
	sound SFX_RANKING_HIGHLIGHT ; $50a7
	ld c, $03 ; $50a9
	call GetRankingMarkerSlot ; $50ab
	ld de, RankingBoardAnimState_5077Table0 ; $50ae
	call StartRankingMarkerAnim0 ; $50b1
	ld c, $04 ; $50b4
	call GetRankingMarkerSlot ; $50b6
	ld de, RankingBoardAnimState_5077Table0 ; $50b9
	call StartRankingMarkerAnim1 ; $50bc
	wait_frames 90 ; $50bf
	sound SFX_MARKER ; $50c3
	ld c, $03 ; $50c5
	call GetRankingMarkerSlot ; $50c7
	ld de, RankingBoardAnimState_5077Table3 ; $50ca
	call StartRankingMarkerAnim2 ; $50cd
	ld c, $04 ; $50d0
	call GetRankingMarkerSlot ; $50d2
	ld de, RankingBoardAnimState_5077Table4 ; $50d5
	call StartRankingMarkerAnim1 ; $50d8
	ld b, $02 ; $50db
	call HighlightRankingRow ; $50dd
	call PushRankingBoardTilemapRows ; $50e0
	wait_frames 30 ; $50e3
	sound SFX_RANKING_HIGHLIGHT ; $50e7
	ld c, $06 ; $50e9
	call GetRankingMarkerSlot ; $50eb
	ld de, RankingBoardAnimState_5077Table2 ; $50ee
	call StartRankingMarkerAnim0 ; $50f1
	ld c, $07 ; $50f4
	call GetRankingMarkerSlot ; $50f6
	ld de, RankingBoardAnimState_5077Table2 ; $50f9
	call StartRankingMarkerAnim1 ; $50fc
	wait_frames 90 ; $50ff
	sound SFX_MARKER ; $5103
	ld c, $06 ; $5105
	call GetRankingMarkerSlot ; $5107
	ld de, RankingBoardAnimState_5077Table3 ; $510a
	call StartRankingMarkerAnim2 ; $510d
	ld c, $07 ; $5110
	call GetRankingMarkerSlot ; $5112
	ld de, RankingBoardAnimState_5077Table1 ; $5115
	call StartRankingMarkerAnim1 ; $5118
	ld b, $03 ; $511b
	call HighlightRankingRow ; $511d
	call PushRankingBoardTilemapRows ; $5120
	wait_frames 30 ; $5123
	sound SFX_RANKING_HIGHLIGHT ; $5127
	ld c, $09 ; $5129
	call GetRankingMarkerSlot ; $512b
	ld de, RankingBoardAnimState_5077Table2 ; $512e
	call StartRankingMarkerAnim0 ; $5131
	ld c, $0a ; $5134
	call GetRankingMarkerSlot ; $5136
	ld de, RankingBoardAnimState_5077Table2 ; $5139
	call StartRankingMarkerAnim1 ; $513c
	wait_frames 90 ; $513f
	sound SFX_MARKER ; $5143
	ld c, $09 ; $5145
	call GetRankingMarkerSlot ; $5147
	ld de, RankingBoardAnimState_5077Table3 ; $514a
	call StartRankingMarkerAnim2 ; $514d
	ld c, $0a ; $5150
	call GetRankingMarkerSlot ; $5152
	ld de, RankingBoardAnimState_5077Table1 ; $5155
	call StartRankingMarkerAnim1 ; $5158
	ld b, $04 ; $515b
	call HighlightRankingRow ; $515d
	call PushRankingBoardTilemapRows ; $5160
	wait_frames 30 ; $5163
	ld a, $01 ; $5167
	ld [wRankingAnimStateDone], a ; $5169
	jp RankingBoardAnimNop_1b ; $516c
RankingBoardAnimState_516f_1b:
	ld a, $01 ; $516f
	ld hl, RankingBoardAnimTask_1b ; $5171
	call RegisterFrameTask ; $5174
	wait_frames 140 ; $5177
	sound SFX_MARKER ; $517b
	ld c, $00 ; $517d
	call GetRankingMarkerSlot ; $517f
	ld de, RankingBoardAnimState_516fTable0 ; $5182
	call StartRankingMarkerAnim2 ; $5185
	ld c, $02 ; $5188
	call GetRankingMarkerSlot ; $518a
	ld de, RankingBoardAnimState_516fTable3 ; $518d
	call StartRankingMarkerAnim1 ; $5190
	ld b, $05 ; $5193
	call HighlightRankingRow ; $5195
	call PushRankingBoardTilemapRows ; $5198
	wait_frames 30 ; $519b
	sound SFX_RANKING_HIGHLIGHT ; $519f
	ld c, $05 ; $51a1
	call GetRankingMarkerSlot ; $51a3
	ld de, RankingBoardAnimState_516fTable0 ; $51a6
	call StartRankingMarkerAnim1 ; $51a9
	wait_frames 4 ; $51ac
	ld c, $03 ; $51b0
	call GetRankingMarkerSlot ; $51b2
	ld de, RankingBoardAnimState_516fTable2 ; $51b5
	call StartRankingMarkerAnim0 ; $51b8
	wait_frames 120 ; $51bb
	sound SFX_MARKER ; $51bf
	ld c, $05 ; $51c1
	call GetRankingMarkerSlot ; $51c3
	ld de, RankingBoardAnimState_516fTable3 ; $51c6
	call StartRankingMarkerAnim3 ; $51c9
	ld c, $03 ; $51cc
	call GetRankingMarkerSlot ; $51ce
	ld de, RankingBoardAnimState_516fTable5 ; $51d1
	call StartRankingMarkerAnim0 ; $51d4
	ld b, $06 ; $51d7
	call HighlightRankingRow ; $51d9
	call PushRankingBoardTilemapRows ; $51dc
	wait_frames 30 ; $51df
	sound SFX_RANKING_HIGHLIGHT ; $51e3
	ld c, $08 ; $51e5
	call GetRankingMarkerSlot ; $51e7
	ld de, RankingBoardAnimState_516fTable4 ; $51ea
	call StartRankingMarkerAnim1 ; $51ed
	wait_frames 4 ; $51f0
	ld c, $06 ; $51f4
	call GetRankingMarkerSlot ; $51f6
	ld de, RankingBoardAnimState_516fTable5 ; $51f9
	call StartRankingMarkerAnim0 ; $51fc
	wait_frames 90 ; $51ff
	sound SFX_MARKER ; $5203
	ld c, $08 ; $5205
	call GetRankingMarkerSlot ; $5207
	ld de, RankingBoardAnimState_516fTable3 ; $520a
	call StartRankingMarkerAnim3 ; $520d
	ld c, $06 ; $5210
	call GetRankingMarkerSlot ; $5212
	ld de, RankingBoardAnimState_516fTable2 ; $5215
	call StartRankingMarkerAnim0 ; $5218
	ld b, $07 ; $521b
	call HighlightRankingRow ; $521d
	call PushRankingBoardTilemapRows ; $5220
	wait_frames 30 ; $5223
	sound SFX_RANKING_HIGHLIGHT ; $5227
	ld c, $0b ; $5229
	call GetRankingMarkerSlot ; $522b
	ld de, RankingBoardAnimState_516fTable4 ; $522e
	call StartRankingMarkerAnim1 ; $5231
	wait_frames 4 ; $5234
	ld c, $09 ; $5238
	call GetRankingMarkerSlot ; $523a
	ld de, RankingBoardAnimState_516fTable5 ; $523d
	call StartRankingMarkerAnim0 ; $5240
	wait_frames 90 ; $5243
	sound SFX_MARKER ; $5247
	ld c, $0b ; $5249
	call GetRankingMarkerSlot ; $524b
	ld de, RankingBoardAnimState_516fTable1 ; $524e
	call StartRankingMarkerAnim1 ; $5251
	ld c, $09 ; $5254
	call GetRankingMarkerSlot ; $5256
	ld de, RankingBoardAnimState_516fTable0 ; $5259
	call StartRankingMarkerAnim2 ; $525c
	ld b, $08 ; $525f
	call HighlightRankingRow ; $5261
	call PushRankingBoardTilemapRows ; $5264
	wait_frames 30 ; $5267
	ld a, $01 ; $526b
	ld [wRankingAnimStateDone], a ; $526d
	jp RankingBoardAnimNop_1b ; $5270
RankingBoardAnimState_5273_1b:
	ld a, $01 ; $5273
	ld hl, RankingBoardAnimTask_1b ; $5275
	call RegisterFrameTask ; $5278
	wait_frames 140 ; $527b
	sound SFX_MARKER ; $527f
	ld c, $00 ; $5281
	call GetRankingMarkerSlot ; $5283
	ld de, RankingBoardAnimState_5273Table0 ; $5286
	call StartRankingMarkerAnim2 ; $5289
	ld c, $05 ; $528c
	call GetRankingMarkerSlot ; $528e
	ld de, RankingBoardAnimState_516fTable5 ; $5291
	call StartRankingMarkerAnim0 ; $5294
	ld b, $09 ; $5297
	call HighlightRankingRow ; $5299
	call PushRankingBoardTilemapRows ; $529c
	wait_frames 90 ; $529f
	sound SFX_RANKING_HIGHLIGHT ; $52a3
	ld c, $08 ; $52a5
	call GetRankingMarkerSlot ; $52a7
	ld de, RankingBoardAnimState_516fTable5 ; $52aa
	call StartRankingMarkerAnim0 ; $52ad
	ld c, $09 ; $52b0
	call GetRankingMarkerSlot ; $52b2
	ld de, RankingBoardAnimState_516fTable5 ; $52b5
	call StartRankingMarkerAnim1 ; $52b8
	wait_frames 90 ; $52bb
	sound SFX_MARKER ; $52bf
	ld c, $08 ; $52c1
	call GetRankingMarkerSlot ; $52c3
	ld de, RankingBoardAnimState_5077Table1 ; $52c6
	call StartRankingMarkerAnim0 ; $52c9
	ld c, $09 ; $52cc
	call GetRankingMarkerSlot ; $52ce
	ld de, RankingBoardAnimState_5273Table1 ; $52d1
	call StartRankingMarkerAnim3 ; $52d4
	ld b, $0a ; $52d7
	call HighlightRankingRow ; $52d9
	call PushRankingBoardTilemapRows ; $52dc
	wait_frames 30 ; $52df
	ld a, $01 ; $52e3
	ld [wRankingAnimStateDone], a ; $52e5
	jp RankingBoardAnimNop_1b ; $52e8
RankingBoardAnimState_52eb_1b:
	ld a, $01 ; $52eb
	ld hl, RankingBoardAnimTask_1b ; $52ed
	call RegisterFrameTask ; $52f0
	wait_frames 140 ; $52f3
	ld a, $01 ; $52f7
	ld [wRankingAnimStateDone], a ; $52f9
	jp RankingBoardAnimNop_1b ; $52fc
RankingBoardAnimState_52ff_1b:
	wait_frames 20 ; $52ff
	sound SFX_RANKING_HIGHLIGHT ; $5303
	ld c, $00 ; $5305
	call GetRankingMarkerSlot ; $5307
	ld de, RankingBoardAnimState_5077Table0 ; $530a
	call StartRankingMarkerAnim0 ; $530d
	ld c, $01 ; $5310
	call GetRankingMarkerSlot ; $5312
	ld de, RankingBoardAnimState_5077Table0 ; $5315
	call StartRankingMarkerAnim1 ; $5318
	wait_frames 20 ; $531b
	jp RankingBoardAnimNop_1b ; $531f
RankingBoardAnimState_5322_1b:
	wait_frames 10 ; $5322
	sound SFX_RANKING_HIGHLIGHT ; $5326
	ld c, $02 ; $5328
	call GetRankingMarkerSlot ; $532a
	ld de, RankingBoardAnimState_516fTable0 ; $532d
	call StartRankingMarkerAnim1 ; $5330
	wait_frames 4 ; $5333
	ld c, $00 ; $5337
	call GetRankingMarkerSlot ; $5339
	ld de, RankingBoardAnimState_516fTable2 ; $533c
	call StartRankingMarkerAnim0 ; $533f
	wait_frames 20 ; $5342
	jp RankingBoardAnimNop_1b ; $5346
RankingBoardAnimState_5349_1b:
	wait_frames 20 ; $5349
	sound SFX_RANKING_HIGHLIGHT ; $534d
	ld c, $00 ; $534f
	call GetRankingMarkerSlot ; $5351
	ld de, RankingBoardAnimState_5077Table0 ; $5354
	call StartRankingMarkerAnim0 ; $5357
	ld c, $05 ; $535a
	call GetRankingMarkerSlot ; $535c
	ld de, RankingBoardAnimState_5077Table0 ; $535f
	call StartRankingMarkerAnim1 ; $5362
	jp RankingBoardAnimNop_1b ; $5365
RankingBoardAnimState_5368_1b:
	wait_frames 30 ; $5368
	sound SFX_RANKING_HIGHLIGHT ; $536c
	ld c, $00 ; $536e
	call GetRankingMarkerSlot ; $5370
	ld de, RankingBoardAnimState_5368Table0 ; $5373
	call StartRankingMarkerAnim0 ; $5376
	ld c, $09 ; $5379
	call GetRankingMarkerSlot ; $537b
	ld de, RankingBoardAnimState_5368Table1 ; $537e
	call StartRankingMarkerAnim1 ; $5381
	jp RankingBoardAnimNop_1b ; $5384
RankingBoardAnimState_5387_1b:
	ld a, $01 ; $5387
	ld hl, RankingBoardAnimTask_1b ; $5389
	call RegisterFrameTask ; $538c
	wait_frames 140 ; $538f
	sound SFX_MARKER ; $5393
	ld c, $00 ; $5395
	call GetRankingMarkerSlot ; $5397
	ld de, RankingBoardAnimState_5387Table1 ; $539a
	call StartRankingMarkerAnim2 ; $539d
	ld c, $01 ; $53a0
	call GetRankingMarkerSlot ; $53a2
	ld de, RankingBoardAnimState_516fTable5 ; $53a5
	call StartRankingMarkerAnim1 ; $53a8
	ld b, $01 ; $53ab
	call HighlightDoublesRankingRow ; $53ad
	call PushRankingBoardTilemapRows ; $53b0
	wait_frames 90 ; $53b3
	sound SFX_RANKING_HIGHLIGHT ; $53b7
	ld c, $03 ; $53b9
	call GetRankingMarkerSlot ; $53bb
	ld de, RankingBoardAnimState_516fTable5 ; $53be
	call StartRankingMarkerAnim0 ; $53c1
	ld c, $04 ; $53c4
	call GetRankingMarkerSlot ; $53c6
	ld de, RankingBoardAnimState_5077Table2 ; $53c9
	call StartRankingMarkerAnim1 ; $53cc
	wait_frames 90 ; $53cf
	sound SFX_MARKER ; $53d3
	ld c, $03 ; $53d5
	call GetRankingMarkerSlot ; $53d7
	ld de, RankingBoardAnimState_5387Table1 ; $53da
	call StartRankingMarkerAnim2 ; $53dd
	ld c, $04 ; $53e0
	call GetRankingMarkerSlot ; $53e2
	ld de, RankingBoardAnimState_5387Table0 ; $53e5
	call StartRankingMarkerAnim1 ; $53e8
	ld b, $02 ; $53eb
	call HighlightDoublesRankingRow ; $53ed
	call PushRankingBoardTilemapRows ; $53f0
	wait_frames 90 ; $53f3
	jp RankingBoardAnimNop_1b ; $53f7
RankingBoardAnimState_53fa_1b:
	ld a, $01 ; $53fa
	ld hl, RankingBoardAnimTask_1b ; $53fc
	call RegisterFrameTask ; $53ff
	wait_frames 140 ; $5402
	sound SFX_MARKER ; $5406
	ld c, $00 ; $5408
	call GetRankingMarkerSlot ; $540a
	ld de, RankingBoardAnimState_53faTable ; $540d
	call StartRankingMarkerAnim2 ; $5410
	ld c, $02 ; $5413
	call GetRankingMarkerSlot ; $5415
	ld de, RankingBoardAnimState_516fTable3 ; $5418
	call StartRankingMarkerAnim1 ; $541b
	ld b, $03 ; $541e
	call HighlightDoublesRankingRow ; $5420
	call PushRankingBoardTilemapRows ; $5423
	wait_frames 90 ; $5426
	sound SFX_RANKING_HIGHLIGHT ; $542a
	ld c, $03 ; $542c
	call GetRankingMarkerSlot ; $542e
	ld de, RankingBoardAnimState_516fTable5 ; $5431
	call StartRankingMarkerAnim0 ; $5434
	ld c, $05 ; $5437
	call GetRankingMarkerSlot ; $5439
	ld de, RankingBoardAnimState_516fTable3 ; $543c
	call StartRankingMarkerAnim1 ; $543f
	wait_frames 140 ; $5442
	sound SFX_MARKER ; $5446
	ld c, $03 ; $5448
	call GetRankingMarkerSlot ; $544a
	ld de, RankingBoardAnimState_53faTable ; $544d
	call StartRankingMarkerAnim2 ; $5450
	ld c, $05 ; $5453
	call GetRankingMarkerSlot ; $5455
	ld de, RankingBoardAnimState_516fTable0 ; $5458
	call StartRankingMarkerAnim1 ; $545b
	ld b, $04 ; $545e
	call HighlightDoublesRankingRow ; $5460
	call PushRankingBoardTilemapRows ; $5463
	wait_frames 30 ; $5466
	jp RankingBoardAnimNop_1b ; $546a
RankingBoardAnimState_546d_1b:
	ld a, $01 ; $546d
	ld hl, RankingBoardAnimTask_1b ; $546f
	call RegisterFrameTask ; $5472
	wait_frames 140 ; $5475
	sound SFX_MARKER ; $5479
	ld c, $00 ; $547b
	call GetRankingMarkerSlot ; $547d
	ld de, RankingBoardAnimState_546dTable ; $5480
	call StartRankingMarkerAnim0 ; $5483
	ld c, $03 ; $5486
	call GetRankingMarkerSlot ; $5488
	ld de, RankingBoardAnimState_5077Table0 ; $548b
	call StartRankingMarkerAnim1 ; $548e
	ld b, $06 ; $5491
	call HighlightDoublesRankingRow ; $5493
	call PushRankingBoardTilemapRows ; $5496
	wait_frames 30 ; $5499
	jp RankingBoardAnimNop_1b ; $549d
RankingBoardAnimState_54a0_1b:
	jp RankingBoardAnimNop_1b ; $54a0
RankingBoardAnimState_54a3_1b:
	wait_frames 30 ; $54a3
	sound SFX_RANKING_HIGHLIGHT ; $54a7
	ld c, $00 ; $54a9
	call GetRankingMarkerSlot ; $54ab
	ld de, RankingBoardAnimState_5077Table0 ; $54ae
	call StartRankingMarkerAnim0 ; $54b1
	ld c, $01 ; $54b4
	call GetRankingMarkerSlot ; $54b6
	ld de, RankingBoardAnimState_5077Table0 ; $54b9
	call StartRankingMarkerAnim1 ; $54bc
	jp RankingBoardAnimNop_1b ; $54bf
RankingBoardAnimState_54c2_1b:
	wait_frames 30 ; $54c2
	sound SFX_RANKING_HIGHLIGHT ; $54c6
	ld c, $02 ; $54c8
	call GetRankingMarkerSlot ; $54ca
	ld de, RankingBoardAnimState_516fTable0 ; $54cd
	call StartRankingMarkerAnim1 ; $54d0
	wait_frames 8 ; $54d3
	ld c, $00 ; $54d7
	call GetRankingMarkerSlot ; $54d9
	ld de, RankingBoardAnimState_5077Table0 ; $54dc
	call StartRankingMarkerAnim0 ; $54df
	jp RankingBoardAnimNop_1b ; $54e2
RankingBoardAnimState_54e5_1b:
	wait_frames 30 ; $54e5
	sound SFX_RANKING_HIGHLIGHT ; $54e9
	ld c, $00 ; $54eb
	call GetRankingMarkerSlot ; $54ed
	ld de, RankingBoardAnimState_5077Table0 ; $54f0
	call StartRankingMarkerAnim0 ; $54f3
	ld c, $03 ; $54f6
	call GetRankingMarkerSlot ; $54f8
	ld de, RankingBoardAnimState_5077Table2 ; $54fb
	call StartRankingMarkerAnim1 ; $54fe
	jp RankingBoardAnimNop_1b ; $5501
RankingBoardAnimState_5504_1b:
	jp RankingBoardAnimNop_1b ; $5504

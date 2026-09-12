ClearMatchStatsNumberArea:
	ld de, wShadowAttrmap + 11 * TILEMAP_WIDTH + 1 ; $5f61
	ld b, $05 ; $5f64
	ld c, $06 ; $5f66
	ld h, $00 ; $5f68
	farcall FillTilemapRect ; $5f6a
	ld de, wShadowAttrmap + 11 * TILEMAP_WIDTH + 14 ; $5f6d
	ld b, $05 ; $5f70
	ld c, $06 ; $5f72
	ld h, $00 ; $5f74
	farcall FillTilemapRect ; $5f76
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 1 ; $5f79
	ld b, $05 ; $5f7c
	ld c, $06 ; $5f7e
	ld h, $20 ; $5f80
	farcall FillTilemapRect ; $5f82
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 14 ; $5f85
	ld b, $05 ; $5f88
	ld c, $06 ; $5f8a
	ld h, $20 ; $5f8c
	farcall FillTilemapRect ; $5f8e
	ret ; $5f91
CopyMatchStatsHeaderRects:
	ld de, FLAG_DOUBLES ; $5f92
	call TestGameFlagByNumber ; $5f95
	ret nz ; $5f98
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $5f99
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH ; $5f9c
	ld b, $08 ; $5f9f
	ld c, $04 ; $5fa1
	farcall CopyTilemapRect ; $5fa3
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 12 ; $5fa6
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 12 ; $5fa9
	ld b, $08 ; $5fac
	ld c, $04 ; $5fae
	farcall CopyTilemapRect ; $5fb0
	ld hl, wShadowAttrmap + 18 * TILEMAP_WIDTH ; $5fb3
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $5fb6
	ld b, $08 ; $5fb9
	ld c, $04 ; $5fbb
	farcall CopyTilemapRect ; $5fbd
	ld hl, wShadowAttrmap + 18 * TILEMAP_WIDTH + 12 ; $5fc0
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 12 ; $5fc3
	ld b, $08 ; $5fc6
	ld c, $04 ; $5fc8
	farcall CopyTilemapRect ; $5fca
	ret ; $5fcd
PrintMatchSetScores:
	ld a, [wPlayer1SetsWon] ; $5fce
	ld h, $00 ; $5fd1
	ld l, a ; $5fd3
	ld de, $1c48 ; $5fd4
	farcall DrawDecimalNumberSprites_39 ; $5fd7
	ld a, [wPlayer2SetsWon] ; $5fda
	ld h, $00 ; $5fdd
	ld l, a ; $5fdf
	ld de, $8448 ; $5fe0
	farcall DrawDecimalNumberSprites_39 ; $5fe3
	ret ; $5fe6
LoadResultScreenPortraits:
	ld a, c ; $5fe7
	or a ; $5fe8
	jr nz, .checkPlayer1CurrentMainCharacter ; $5fe9
	ld a, [wGameMode] ; $5feb
	cp GAMEMODE_LINK_MATCH ; $5fee
	jr nz, .checkPlayer1CurrentMainCharacter ; $5ff0
	ld a, [wLinkMatchRole] ; $5ff2
	cp LINKSTATE_SLAVE ; $5ff5
	jr z, .checkPlayer1CurrentMainCharacter2 ; $5ff7
.checkPlayer1CurrentMainCharacter:
	ld a, [wPlayer1CurrentMainCharacter] ; $5ff9
	ld d, a ; $5ffc
	ld a, [wPlayer1MainPalette] ; $5ffd
	ld b, a ; $6000
	ld c, $00 ; $6001
	call LoadResultPortraitSlot ; $6003
	ld a, [wPlayer2CurrentMainCharacter] ; $6006
	ld d, a ; $6009
	ld a, [wPlayer2MainPalette] ; $600a
	ld b, a ; $600d
	ld c, $02 ; $600e
	call LoadResultPortraitSlot ; $6010
	ld de, FLAG_DOUBLES ; $6013
	call TestGameFlagByNumber ; $6016
	jr z, .done ; $6019
	ld a, [wPlayer1CurrentPartnerCharacter] ; $601b
	ld d, a ; $601e
	ld a, [wPlayer1PartnerPalette] ; $601f
	ld b, a ; $6022
	ld c, $01 ; $6023
	call LoadResultPortraitSlot ; $6025
	ld a, [wPlayer2CurrentPartnerCharacter] ; $6028
	ld d, a ; $602b
	ld a, [wPlayer2PartnerPalette] ; $602c
	ld b, a ; $602f
	ld c, $03 ; $6030
	call LoadResultPortraitSlot ; $6032
.done:
	ret ; $6035
.checkPlayer1CurrentMainCharacter2:
	ld a, [wPlayer1CurrentMainCharacter] ; $6036
	ld d, a ; $6039
	ld a, [wPlayer1MainPalette] ; $603a
	ld b, a ; $603d
	ld c, $02 ; $603e
	call LoadResultPortraitSlot ; $6040
	ld a, [wPlayer2CurrentMainCharacter] ; $6043
	ld d, a ; $6046
	ld a, [wPlayer2MainPalette] ; $6047
	ld b, a ; $604a
	ld c, $00 ; $604b
	call LoadResultPortraitSlot ; $604d
	ld de, FLAG_DOUBLES ; $6050
	call TestGameFlagByNumber ; $6053
	jr z, .doneB ; $6056
	ld a, [wPlayer1CurrentPartnerCharacter] ; $6058
	ld d, a ; $605b
	ld a, [wPlayer1PartnerPalette] ; $605c
	ld b, a ; $605f
	ld c, $03 ; $6060
	call LoadResultPortraitSlot ; $6062
	ld a, [wPlayer2CurrentPartnerCharacter] ; $6065
	ld d, a ; $6068
	ld a, [wPlayer2PartnerPalette] ; $6069
	ld b, a ; $606c
	ld c, $01 ; $606d
	call LoadResultPortraitSlot ; $606f
.doneB:
	ret ; $6072
LoadResultPortraitSlot:
	push de ; $6073
	push bc ; $6074
	ld a, c ; $6075
	add $04 ; $6076
	ld d, a ; $6078
	ld a, b ; $6079
	farcall LoadIndexedPalette_18 ; $607a
	pop bc ; $607d
	pop de ; $607e
	ld b, d ; $607f
	ld a, c ; $6080
	add a ; $6081
	ld hl, ResultPortraitSlotTable ; $6082
	add l ; $6085
	ld l, a ; $6086
	jr nc, .readDest ; $6087
	inc h ; $6089
.readDest:
	ld a, [hl+] ; $608a
	ld d, [hl] ; $608b
	ld e, a ; $608c
	push de ; $608d
	ld a, c ; $608e
	cp $02 ; $608f
	jr z, .fixedVariant ; $6091
	cp $03 ; $6093
	jr z, .fixedVariant ; $6095
	jr .checkOutcome ; $6097
.fixedVariant:
	ld c, $00 ; $6099
	jr .decompress ; $609b
.checkOutcome:
	ld a, [wResultScreenMode] ; $609d
	or a ; $60a0
	jr z, .winner ; $60a1
	ld c, $00 ; $60a3
	jr .decompress ; $60a5
.winner:
	ld c, $01 ; $60a7
	ld a, [wMatchWinLoseFlag] ; $60a9
	cp WINLOSE_LOSE ; $60ac
	jr nz, .decompress ; $60ae
	ld c, $02 ; $60b0
.decompress:
	pop de ; $60b2
	call DecompressResultPortrait ; $60b3
	ret ; $60b6
ResultPortraitSlotTable:
	; $60b7, 9 bytes (records:2)
	dw $8c00 ; record 0
	dw $8d00 ; record 1
	dw $8e00 ; record 2
	dw $8f00 ; record 3
	db $c9
DecompressResultPortrait:
	ld a, c ; $60c0
	or a ; $60c1
	jr z, .compare ; $60c2
	call DecompressWinLosePortraitVariant ; $60c4
	ret ; $60c7
.compare:
	cp $20 ; $60c8
	jr c, .decompressCharacterPortrait ; $60ca
	ld a, b ; $60cc
	farcall RemapExtendedCharId ; $60cd
	ld b, a ; $60d0
.decompressCharacterPortrait:
	call DecompressCharacterPortrait ; $60d1
	ret ; $60d4
DecompressWinLosePortraitVariant:
	ld a, b ; $60d5
	add a ; $60d6
	and $07 ; $60d7
	ld b, a ; $60d9
	ld a, c ; $60da
	cp $01 ; $60db
	ld a, b ; $60dd
	jr z, .eq01 ; $60de
	inc a ; $60e0
.eq01:
	ld hl, WinLosePortraitVariantTable_16 ; $60e1
	add a ; $60e4
	add l ; $60e5
	ld l, a ; $60e6
	jr nc, .read ; $60e7
	inc h ; $60e9
.read:
	ld a, [hl+] ; $60ea
	ld h, [hl] ; $60eb
	ld l, a ; $60ec
	call DecompressData ; $60ed
	ret ; $60f0
WinLosePortraitVariantTable_16:
	; $60f1, 16 bytes (lz_ptr_table)
	dw WinLosePortrait0 ; 0
	dw WinLosePortrait1 ; 1
	dw WinLosePortrait2 ; 2
	dw WinLosePortrait3 ; 3
	dw WinLosePortrait4 ; 4
	dw WinLosePortrait5 ; 5
	dw WinLosePortrait6 ; 6
	dw WinLosePortrait7 ; 7
WinLosePortrait0:
	INCBIN "data/bank_016/lz_WinLosePortrait0.bin" ; $6101, 275 bytes
WinLosePortrait1:
	INCBIN "data/bank_016/lz_WinLosePortrait1.bin" ; $6214, 257 bytes
WinLosePortrait2:
	INCBIN "data/bank_016/lz_WinLosePortrait2.bin" ; $6315, 269 bytes
WinLosePortrait3:
	INCBIN "data/bank_016/lz_WinLosePortrait3.bin" ; $6422, 276 bytes
WinLosePortrait4:
	INCBIN "data/bank_016/lz_WinLosePortrait4.bin" ; $6536, 254 bytes
WinLosePortrait5:
	INCBIN "data/bank_016/lz_WinLosePortrait5.bin" ; $6634, 243 bytes
WinLosePortrait6:
	INCBIN "data/bank_016/lz_WinLosePortrait6.bin" ; $6727, 291 bytes
WinLosePortrait7:
	INCBIN "data/bank_016/lz_WinLosePortrait7.bin" ; $684a, 267 bytes
DecompressCharacterPortrait:
	ld a, b ; $6955
	and $1f ; $6956
	add a ; $6958
	ld hl, CharacterPortraitTable_16 ; $6959
	add l ; $695c
	ld l, a ; $695d
	jr nc, .read ; $695e
	inc h ; $6960
.read:
	ld a, [hl+] ; $6961
	ld h, [hl] ; $6962
	ld l, a ; $6963
	call DecompressData ; $6964
	ret ; $6967
CharacterPortraitTable_16:
	; $6968, 64 bytes (char_lz_ptr_table)
	dw PortraitGfxAlex_16 ; $00 Alex
	dw PortraitGfxNina_16 ; $01 Nina
	dw PortraitGfxHarry_16 ; $02 Harry
	dw PortraitGfxKate_16 ; $03 Kate
	dw PortraitGfxAllie_16 ; $04 Allie
	dw PortraitGfxJoy_16 ; $05 Joy
	dw PortraitGfxBrian_16 ; $06 Brian
	dw PortraitGfxPam_16 ; $07 Pam
	dw PortraitGfxBob_16 ; $08 Bob
	dw PortraitGfxBeth_16 ; $09 Beth
	dw PortraitGfxFay_16 ; $0a Fay
	dw PortraitGfxCurt_16 ; $0b Curt
	dw PortraitGfxMark_16 ; $0c Mark
	dw PortraitGfxSean_16 ; $0d Sean
	dw PortraitGfxSammi_16 ; $0e Sammi
	dw PortraitGfxElden_16 ; $0f Elden
	dw PortraitGfxSpike_16 ; $10 Spike
	dw PortraitGfxEmily_16 ; $11 Emily
	dw PortraitGfxBCoz_16 ; $12 B. Coz
	dw PortraitGfxACoz_16 ; $13 A. Coz
	dw PortraitGfxPlaceholder_16 ; $14 Kevin
	dw PortraitGfxPlaceholder_16 ; $15 Not used
	dw PortraitGfxPlaceholder_16 ; $16 Not used
	dw PortraitGfxLuigi_16 ; $17 Luigi
	dw PortraitGfxDK_16 ; $18 DK
	dw PortraitGfxBabyMario_16 ; $19 Baby M.
	dw PortraitGfxMario_16 ; $1a Mario
	dw PortraitGfxWaluigi_16 ; $1b Waluigi
	dw PortraitGfxYoshi_16 ; $1c Yoshi
	dw PortraitGfxBowser_16 ; $1d Bowser
	dw PortraitGfxWario_16 ; $1e Wario
	dw PortraitGfxPeach_16 ; $1f Peach
PortraitGfxAlex_16:
	INCBIN "data/bank_016/lz_PortraitGfxAlex_16.bin" ; $69a8, 158 bytes
PortraitGfxNina_16:
	INCBIN "data/bank_016/lz_PortraitGfxNina_16.bin" ; $6a46, 163 bytes
PortraitGfxHarry_16:
	INCBIN "data/bank_016/lz_PortraitGfxHarry_16.bin" ; $6ae9, 146 bytes
PortraitGfxKate_16:
	INCBIN "data/bank_016/lz_PortraitGfxKate_16.bin" ; $6b7b, 165 bytes
PortraitGfxAllie_16:
	INCBIN "data/bank_016/lz_PortraitGfxAllie_16.bin" ; $6c20, 134 bytes
PortraitGfxJoy_16:
	INCBIN "data/bank_016/lz_PortraitGfxJoy_16.bin" ; $6ca6, 148 bytes
PortraitGfxBrian_16:
	INCBIN "data/bank_016/lz_PortraitGfxBrian_16.bin" ; $6d3a, 144 bytes
PortraitGfxPam_16:
	INCBIN "data/bank_016/lz_PortraitGfxPam_16.bin" ; $6dca, 137 bytes
PortraitGfxBob_16:
	INCBIN "data/bank_016/lz_PortraitGfxBob_16.bin" ; $6e53, 141 bytes
PortraitGfxBeth_16:
	INCBIN "data/bank_016/lz_PortraitGfxBeth_16.bin" ; $6ee0, 147 bytes
PortraitGfxFay_16:
	INCBIN "data/bank_016/lz_PortraitGfxFay_16.bin" ; $6f73, 147 bytes
PortraitGfxCurt_16:
	INCBIN "data/bank_016/lz_PortraitGfxCurt_16.bin" ; $7006, 161 bytes
PortraitGfxMark_16:
	INCBIN "data/bank_016/lz_PortraitGfxMark_16.bin" ; $70a7, 161 bytes
PortraitGfxSean_16:
	INCBIN "data/bank_016/lz_PortraitGfxSean_16.bin" ; $7148, 157 bytes
PortraitGfxSammi_16:
	INCBIN "data/bank_016/lz_PortraitGfxSammi_16.bin" ; $71e5, 150 bytes
PortraitGfxElden_16:
	INCBIN "data/bank_016/lz_PortraitGfxElden_16.bin" ; $727b, 149 bytes
PortraitGfxSpike_16:
	INCBIN "data/bank_016/lz_PortraitGfxSpike_16.bin" ; $7310, 162 bytes
PortraitGfxEmily_16:
	INCBIN "data/bank_016/lz_PortraitGfxEmily_16.bin" ; $73b2, 151 bytes
PortraitGfxBCoz_16:
	INCBIN "data/bank_016/lz_PortraitGfxBCoz_16.bin" ; $7449, 147 bytes
PortraitGfxACoz_16:
	INCBIN "data/bank_016/lz_PortraitGfxACoz_16.bin" ; $74dc, 121 bytes
PortraitGfxPlaceholder_16:
	INCBIN "data/bank_016/lz_PortraitGfxPlaceholder_16.bin" ; $7555, 126 bytes
PortraitGfxLuigi_16:
	INCBIN "data/bank_016/lz_PortraitGfxLuigi_16.bin" ; $75d3, 154 bytes
PortraitGfxDK_16:
	INCBIN "data/bank_016/lz_PortraitGfxDK_16.bin" ; $766d, 156 bytes
PortraitGfxBabyMario_16:
	INCBIN "data/bank_016/lz_PortraitGfxBabyMario_16.bin" ; $7709, 155 bytes
PortraitGfxMario_16:
	INCBIN "data/bank_016/lz_PortraitGfxMario_16.bin" ; $77a4, 162 bytes
PortraitGfxWaluigi_16:
	INCBIN "data/bank_016/lz_PortraitGfxWaluigi_16.bin" ; $7846, 158 bytes
PortraitGfxYoshi_16:
	INCBIN "data/bank_016/lz_PortraitGfxYoshi_16.bin" ; $78e4, 139 bytes
PortraitGfxBowser_16:
	INCBIN "data/bank_016/lz_PortraitGfxBowser_16.bin" ; $796f, 165 bytes
PortraitGfxWario_16:
	INCBIN "data/bank_016/lz_PortraitGfxWario_16.bin" ; $7a14, 162 bytes
PortraitGfxPeach_16:
	INCBIN "data/bank_016/lz_PortraitGfxPeach_16.bin" ; $7ab6, 153 bytes
	; $7b4f, 1201 bytes fill to bank end (linker-padded)

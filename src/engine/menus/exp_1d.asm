ExpBarFillTiles_1d:
	; $6f35, 9 bytes (bytes:9)
	db $0d, $1d, $2d, $0e, $1e, $2e, $0f, $1f, $2f ; 0x00
RunExpDistributionLoop:
	wram_bank WRAM_SCENE ; $6f3e
	ld a, [wCharDataViewOnly] ; $6f44
	or a ; $6f47
	jr z, .tick ; $6f48
	xor a ; $6f4a
	ld [wCharDataViewOnly], a ; $6f4b
	jp CheckExpLevelDown.step2 ; $6f4e
.tick:
	wram_bank WRAM_SCENE ; $6f51
	ld a, [wExpInputRepeating] ; $6f57
	and $08 ; $6f5a
	or a ; $6f5c
	jr z, .checkRepeat ; $6f5d
	ld a, [wExpRepeatDelay] ; $6f5f
	or a ; $6f62
	jr z, .checkRepeat ; $6f63
	dec a ; $6f65
	ld [wExpRepeatDelay], a ; $6f66
	xor a ; $6f69
	ld [wExpInputRepeating], a ; $6f6a
.checkRepeat:
	ld a, [wExpRedrawPending] ; $6f6d
	or a ; $6f70
	jr z, .frame ; $6f71
	dec a ; $6f73
	ld [wExpRedrawPending], a ; $6f74
.frame:
	call TickLevelUpJingle ; $6f77
	call UploadExpScreenTilemapRows ; $6f7a
	call AdvanceFrame ; $6f7d
	ldh a, [hPlayerInputFlags] ; $6f80
	bit PADB_B, a ; $6f82
	jr z, .checkButtons ; $6f84
	push af ; $6f86
	wram_bank WRAM_SCENE ; $6f87
	xor a ; $6f8d
	ld [wExpRedrawPending], a ; $6f8e
	pop af ; $6f91
.checkButtons:
	bit 5, a ; $6f92
	jp nz, .decrease ; $6f94
	bit 4, a ; $6f97
	jp nz, .increase ; $6f99
	bit 0, a ; $6f9c
	jp nz, .increase ; $6f9e
	wram_bank WRAM_SCENE ; $6fa1
	ld a, $a8 ; $6fa7
	ld [wExpBarMarkerX], a ; $6fa9
	ld a, $08 ; $6fac
	ld [wExpRepeatDelay], a ; $6fae
	xor a ; $6fb1
	ld [wExpInputRepeating], a ; $6fb2
	ld hl, wExpCursorChar ; $6fb5
	res 1, [hl] ; $6fb8
	ldh a, [hInputRisingEdge] ; $6fba
	bit PADB_UP, a ; $6fbc
	jr nz, .selectMainChar ; $6fbe
	bit 7, a ; $6fc0
	jr nz, .selectPartner ; $6fc2
	jp RunExpDistributionLoop ; $6fc4
.selectMainChar:
	wram_bank WRAM_SCENE ; $6fc7
	ld a, [wStoryCharacterSlot] ; $6fcd
	or a ; $6fd0
	jp z, RunExpDistributionLoop ; $6fd1
	sound SFX_MENU_MOVE ; $6fd4
	xor a ; $6fd6
	ld [wStoryCharacterSlot], a ; $6fd7
	call UpdateExpScreenSelectionPalettes ; $6fda
	ld hl, SlideExpCursorToPartnerTask ; $6fdd
	call UnregisterFrameTask ; $6fe0
	ld a, $01 ; $6fe3
	ld hl, SlideExpCursorToMainCharTask ; $6fe5
	call RegisterFrameTask ; $6fe8
	ld hl, wExpCursorChar ; $6feb
	set 0, [hl] ; $6fee
	jp RunExpDistributionLoop ; $6ff0
.selectPartner:
	wram_bank WRAM_SCENE ; $6ff3
	ld a, [wStoryCharacterSlot] ; $6ff9
	or a ; $6ffc
	jp nz, RunExpDistributionLoop ; $6ffd
	sound SFX_MENU_MOVE ; $7000
	ld a, $01 ; $7002
	ld [wStoryCharacterSlot], a ; $7004
	call UpdateExpScreenSelectionPalettes ; $7007
	ld hl, SlideExpCursorToMainCharTask ; $700a
	call UnregisterFrameTask ; $700d
	ld a, $01 ; $7010
	ld hl, SlideExpCursorToPartnerTask ; $7012
	call RegisterFrameTask ; $7015
	ld hl, wExpCursorChar ; $7018
	set 0, [hl] ; $701b
	jp RunExpDistributionLoop ; $701d
.decrease:
	wram_bank WRAM_SCENE ; $7020
	ld a, [wExpCursorChar] ; $7026
	bit 0, a ; $7029
	jp nz, RunExpDistributionLoop ; $702b
	ld hl, wExpInputRepeating ; $702e
	inc [hl] ; $7031
	ld a, [wExpRedrawPending] ; $7032
	or a ; $7035
	jr nz, .decreaseRepeat ; $7036
	call UnassignExpPointFromChar ; $7038
	or a ; $703b
	jr z, .decreaseFailed ; $703c
	sound SFX_MENU_CANCEL ; $703e
	wram_bank WRAM_SCENE ; $7040
	ld a, [wExpRepeatDelay] ; $7046
	or a ; $7049
	jr nz, .applyDecrease ; $704a
	call UnassignExpPointFromChar ; $704c
.applyDecrease:
	ld hl, wExpCursorChar ; $704f
	set 1, [hl] ; $7052
	ld a, [wExpRepeatDelay] ; $7054
	ld [wExpRedrawPending], a ; $7057
	call RefreshExpScreenReadouts ; $705a
	call SweepExpBarMarkerLeft ; $705d
	jp RunExpDistributionLoop ; $7060
.decreaseFailed:
	ld hl, wExpCursorChar ; $7063
	res 1, [hl] ; $7066
	ld a, $a8 ; $7068
	ld [wExpBarMarkerX], a ; $706a
	jp RunExpDistributionLoop ; $706d
.decreaseRepeat:
	call SweepExpBarMarkerLeft ; $7070
	jp RunExpDistributionLoop ; $7073
.increase:
	wram_bank WRAM_SCENE ; $7076
	ld a, [wExpCursorChar] ; $707c
	bit 0, a ; $707f
	jp nz, RunExpDistributionLoop ; $7081
	ld hl, wExpInputRepeating ; $7084
	inc [hl] ; $7087
	ld a, [wExpRedrawPending] ; $7088
	or a ; $708b
	jr nz, .increaseRepeat ; $708c
	call AssignExpPointToChar ; $708e
	or a ; $7091
	jr z, .increaseFailed ; $7092
	sound SFX_MENU_SELECT ; $7094
	wram_bank WRAM_SCENE ; $7096
	ld a, [wExpRepeatDelay] ; $709c
	or a ; $709f
	jr nz, .applyIncrease ; $70a0
	call AssignExpPointToChar ; $70a2
.applyIncrease:
	ld hl, wExpCursorChar ; $70a5
	set 1, [hl] ; $70a8
	ld a, [wExpRepeatDelay] ; $70aa
	ld [wExpRedrawPending], a ; $70ad
	call RefreshExpScreenReadouts ; $70b0
	call SweepExpBarMarkerRight ; $70b3
	jp RunExpDistributionLoop ; $70b6
.increaseFailed:
	ld hl, wExpCursorChar ; $70b9
	res 1, [hl] ; $70bc
	ld a, $a8 ; $70be
	ld [wExpBarMarkerX], a ; $70c0
	jp CheckExpLevelDown.step2 ; $70c3
.increaseRepeat:
	call SweepExpBarMarkerRight ; $70c6
	jp RunExpDistributionLoop ; $70c9
SlideExpCursorToMainCharTask:
	wram_bank WRAM_SCENE ; $70cc
	ld a, [wExpCursorSlide] ; $70d2
	dec a ; $70d5
	ld [wExpCursorSlide], a ; $70d6
	ret nz ; $70d9
	ld hl, wExpCursorChar ; $70da
	res 0, [hl] ; $70dd
	ld hl, SlideExpCursorToMainCharTask ; $70df
	call UnregisterFrameTask ; $70e2
	ret ; $70e5
SlideExpCursorToPartnerTask:
	wram_bank WRAM_SCENE ; $70e6
	ld a, [wExpCursorSlide] ; $70ec
	inc a ; $70ef
	ld [wExpCursorSlide], a ; $70f0
	cp $18 ; $70f3
	ret nz ; $70f5
	ld hl, wExpCursorChar ; $70f6
	res 0, [hl] ; $70f9
	ld hl, SlideExpCursorToPartnerTask ; $70fb
	call UnregisterFrameTask ; $70fe
	ret ; $7101
SweepExpBarMarkerLeft:
	call GetExpBarSweepStep ; $7102
	wram_bank WRAM_SCENE ; $7105
	ld a, [wExpBarMarkerX] ; $710b
	cp $a8 ; $710e
	jr z, .checkStoryCharacterSlot ; $7110
	sub b ; $7112
	ld [wExpBarMarkerX], a ; $7113
	cp $18 ; $7116
	ret nc ; $7118
	ld a, $a8 ; $7119
	ld [wExpBarMarkerX], a ; $711b
	ret ; $711e
.checkStoryCharacterSlot:
	ld a, [wStoryCharacterSlot] ; $711f
	or a ; $7122
	jr nz, .nonZero ; $7123
	ld a, [wExpScreenCharStats + 3] ; $7125
	jr .getExpBarSweepStep ; $7128
.nonZero:
	ld a, [wExpScreenCharStats + 18] ; $712a
.getExpBarSweepStep:
	add $36 ; $712d
	ld [wExpBarMarkerX], a ; $712f
	ret ; $7132
SweepExpBarMarkerRight:
	call GetExpBarSweepStep ; $7133
	wram_bank WRAM_SCENE ; $7136
	ld a, [wExpBarMarkerX] ; $713c
	cp $a8 ; $713f
	jr z, .eqa8 ; $7141
	add b ; $7143
	ld [wExpBarMarkerX], a ; $7144
	ld b, a ; $7147
	ld a, [wStoryCharacterSlot] ; $7148
	or a ; $714b
	jr nz, .nonZero ; $714c
	ld a, [wExpScreenCharStats + 3] ; $714e
	jr .step2 ; $7151
.nonZero:
	ld a, [wExpScreenCharStats + 18] ; $7153
.step2:
	add $36 ; $7156
	ld c, a ; $7158
	ld a, b ; $7159
	cp c ; $715a
	ret c ; $715b
	ld a, $a8 ; $715c
	ld [wExpBarMarkerX], a ; $715e
	ret ; $7161
.eqa8:
	ld a, $18 ; $7162
	ld [wExpBarMarkerX], a ; $7164
	ret ; $7167
GetExpBarSweepStep:
	wram_bank WRAM_SCENE ; $7168
	ld a, [wStoryCharacterSlot] ; $716e
	or a ; $7171
	jr nz, .nonZero ; $7172
	ld a, [wExpScreenCharStats + 3] ; $7174
	jr .step2 ; $7177
.nonZero:
	ld a, [wExpScreenCharStats + 18] ; $7179
.step2:
	add $18 ; $717c
	srl a ; $717e
	srl a ; $7180
	srl a ; $7182
	srl a ; $7184
	inc a ; $7186
	ld b, a ; $7187
	ret ; $7188
UpdateExpScreenSelectionPalettes:
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $7189
	ld_bg_pals de, 1, 1 ; $718c
	farcall LoadIndexedPaletteThunk ; $718f
	ld a, [wStoryModePartnerCharacterOverworldSpriteColor] ; $7192
	ld_bg_pals de, 2, 1 ; $7195
	farcall LoadIndexedPaletteThunk ; $7198
	wram_bank WRAM_SCENE ; $719b
	ld a, [wExpScreenCharStats + 10] ; $71a1
	ld [wBGPalettes + 58], a ; $71a4
	ld a, [wExpScreenCharStats + 11] ; $71a7
	ld [wBGPalettes + 59], a ; $71aa
	ld a, [wExpScreenCharStats + 25] ; $71ad
	ld [wBGPalettes + 34], a ; $71b0
	ld a, [wExpScreenCharStats + 26] ; $71b3
	ld [wBGPalettes + 35], a ; $71b6
	ld a, [wStoryCharacterSlot] ; $71b9
	or a ; $71bc
	jr nz, .grayOut ; $71bd
	ld hl, wBGPalettes + 16 ; $71bf
	call GrayscalePaletteColorInPlace ; $71c2
	ld hl, wBGPalettes + 18 ; $71c5
	call GrayscalePaletteColorInPlace ; $71c8
	ld hl, wBGPalettes + 20 ; $71cb
	call GrayscalePaletteColorInPlace ; $71ce
	ld hl, wBGPalettes + 22 ; $71d1
	call GrayscalePaletteColorInPlace ; $71d4
	ld a, $08 ; $71d7
	ld [wBGPalettes + 34], a ; $71d9
	ld a, $21 ; $71dc
	ld [wBGPalettes + 35], a ; $71de
	ret ; $71e1
.grayOut:
	ld hl, wBGPalettes + 8 ; $71e2
	call GrayscalePaletteColorInPlace ; $71e5
	ld hl, wBGPalettes + 10 ; $71e8
	call GrayscalePaletteColorInPlace ; $71eb
	ld hl, wBGPalettes + 12 ; $71ee
	call GrayscalePaletteColorInPlace ; $71f1
	ld hl, wBGPalettes + 14 ; $71f4
	call GrayscalePaletteColorInPlace ; $71f7
	ld a, $08 ; $71fa
	ld [wBGPalettes + 58], a ; $71fc
	ld a, $21 ; $71ff
	ld [wBGPalettes + 59], a ; $7201
	ret ; $7204
GrayscalePaletteColorInPlace:
	ld a, [hl+] ; $7205
	ld d, [hl] ; $7206
	ld e, a ; $7207
	call ConvertColorToGrayscale ; $7208
	dec hl ; $720b
	ld a, e ; $720c
	ld [hl+], a ; $720d
	ld [hl], d ; $720e
	ret ; $720f
; Averages a CGB colour's three components into a grey.
;
; Buggy in the shipped game: the blue component is stored to $0002 instead of
; $d002, so $d002 is never written and the average is red plus green plus a
; stale byte. The stray write lands on the MBC cartridge-RAM gate, which is
; harmless only because the save engine re-enables SRAM before using it.
; See docs/bugs.md.
ConvertColorToGrayscale:
	push hl ; $7210
	push_wram_bank WRAM_STAGING ; $7211
	ld a, e ; $721a
	and $1f ; $721b
	ld [wDecompBuffer], a ; $721d
	ld a, d ; $7220
	and $03 ; $7221
	rlca ; $7223
	rlca ; $7224
IF DEF(FIXES)
	rlca
ENDC
	ld [wDecompBuffer + 1], a ; $7225
	ld a, e ; $7228
	and $e0 ; $7229
	rlca ; $722b
	rlca ; $722c
	rlca ; $722d
	ld b, a ; $722e
	ld a, [wDecompBuffer + 1] ; $722f
	or b ; $7232
	ld [wDecompBuffer + 1], a ; $7233
	ld a, d ; $7236
	and $7c ; $7237
	rrca ; $7239
	rrca ; $723a
IF DEF(FIXES)
	ld [wDecompBuffer + 2], a
ELSE
	ld [rRAMG + 2], a ; $723b
ENDC
	ld a, [wDecompBuffer] ; $723e
	ld hl, wDecompBuffer + 1 ; $7241
	add [hl] ; $7244
IF DEF(FIXES)
	add [hl]
ENDC
	inc hl ; $7245
	add [hl] ; $7246
	srl a ; $7247
IF DEF(FIXES)
	srl a
ENDC
	and $1f ; $7249
	ld [wDecompBuffer + 3], a ; $724b
	ld e, a ; $724e
	rrca ; $724f
	rrca ; $7250
	rrca ; $7251
	and $e0 ; $7252
	or e ; $7254
	ld e, a ; $7255
	ld a, [wDecompBuffer + 3] ; $7256
	rrca ; $7259
	rrca ; $725a
	rrca ; $725b
	and $03 ; $725c
	ld d, a ; $725e
	ld a, [wDecompBuffer + 3] ; $725f
	rlca ; $7262
	rlca ; $7263
	or d ; $7264
	ld d, a ; $7265
	pop_wram_bank ; $7266
	pop hl ; $726b
	ret ; $726c
AssignExpPointToChar:
	wram_bank WRAM_SCENE ; $726d
	ld a, [wExpPoolRemaining] ; $7273
	ld d, a ; $7276
	ld a, [wExpPoolRemaining + 1] ; $7277
	or d ; $727a
	ld a, $00 ; $727b
	ret z ; $727d
	ld hl, wExpPoolRemaining ; $727e
	ld a, [hl+] ; $7281
	ld d, [hl] ; $7282
	ld e, a ; $7283
	dec de ; $7284
	dec hl ; $7285
	ld a, e ; $7286
	ld [hl+], a ; $7287
	ld [hl], d ; $7288
	ld a, [wStoryCharacterSlot] ; $7289
	or a ; $728c
	jr nz, .nonZero ; $728d
	ld hl, wExpScreenCharStats + 6 ; $728f
	ld a, [hl+] ; $7292
	ld d, [hl] ; $7293
	ld e, a ; $7294
	inc de ; $7295
	dec hl ; $7296
	ld a, e ; $7297
	ld [hl+], a ; $7298
	ld [hl], d ; $7299
	ld hl, wExpScreenCharStats + 4 ; $729a
	ld a, [hl+] ; $729d
	ld d, [hl] ; $729e
	ld e, a ; $729f
	inc de ; $72a0
	dec hl ; $72a1
	ld a, e ; $72a2
	ld [hl+], a ; $72a3
	ld [hl], d ; $72a4
	ld hl, wExpScreenCharStats + 8 ; $72a5
	ld a, [hl+] ; $72a8
	ld d, [hl] ; $72a9
	ld e, a ; $72aa
	dec de ; $72ab
	dec hl ; $72ac
	ld a, e ; $72ad
	ld [hl+], a ; $72ae
	ld [hl], d ; $72af
	call CheckExpLevelUp ; $72b0
	ld a, $01 ; $72b3
	ret ; $72b5
.nonZero:
	ld hl, wExpScreenCharStats + 21 ; $72b6
	ld a, [hl+] ; $72b9
	ld d, [hl] ; $72ba
	ld e, a ; $72bb
	inc de ; $72bc
	dec hl ; $72bd
	ld a, e ; $72be
	ld [hl+], a ; $72bf
	ld [hl], d ; $72c0
	ld hl, wExpScreenCharStats + 19 ; $72c1
	ld a, [hl+] ; $72c4
	ld d, [hl] ; $72c5
	ld e, a ; $72c6
	inc de ; $72c7
	dec hl ; $72c8
	ld a, e ; $72c9
	ld [hl+], a ; $72ca
	ld [hl], d ; $72cb
	ld hl, wExpScreenCharStats + 23 ; $72cc
	ld a, [hl+] ; $72cf
	ld d, [hl] ; $72d0
	ld e, a ; $72d1
	dec de ; $72d2
	dec hl ; $72d3
	ld a, e ; $72d4
	ld [hl+], a ; $72d5
	ld [hl], d ; $72d6
	call CheckExpLevelUp ; $72d7
	ld a, $01 ; $72da
	ret ; $72dc

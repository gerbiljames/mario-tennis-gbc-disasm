SECTION "ROM Bank $01", ROMX[$4000], BANK[$01]

FarPtr_01_00:
	dw Func_01_4018 ; $4000
FarPtr_01_02:
	dw Func_01_6030 ; $4002
FarPtr_01_04:
	dw Func_01_5062 ; $4004
FarPtr_01_06:
	dw Func_01_5076 ; $4006
FarPtr_01_08:
	dw Func_01_5050 ; $4008
FarPtr_01_0a:
	dw Func_01_50e2 ; $400a
FarPtr_01_0c:
	dw Func_01_5176 ; $400c
FarPtr_01_0e:
	dw Func_01_5188 ; $400e
FarPtr_01_10:
	dw Func_01_519a ; $4010
FarPtr_01_12:
	dw Func_01_50d6 ; $4012
FarPtr_01_14:
	dw Func_01_50ec ; $4014
FarPtr_01_16:
	dw Func_01_6a5b ; $4016
Func_01_4018:
	call InitSerialLink ; $4018
	push de ; $401b
	ld de, $07e0 ; $401c
	farcall FarPtr_ClearSaveFlag ; $401f
	pop de ; $4022
	call DisableLCDSafely ; $4023
	wram_bank $01 ; $4026
	ld hl, $d000 ; $402c
	ld c, $00 ; $402f
	call ClearMemory16 ; $4031
	wram_bank $02 ; $4034
	ld hl, $d000 ; $403a
	ld c, $00 ; $403d
	call ClearMemory16 ; $403f
	wram_bank $03 ; $4042
	ld hl, $d000 ; $4048
	ld c, $00 ; $404b
	call ClearMemory16 ; $404d
	wram_bank $04 ; $4050
	ld hl, $d000 ; $4056
	ld c, $00 ; $4059
	call ClearMemory16 ; $405b
	wram_bank $05 ; $405e
	ld hl, $d000 ; $4064
	ld c, $00 ; $4067
	call ClearMemory16 ; $4069
	wram_bank $06 ; $406c
	ld hl, $d000 ; $4072
	ld c, $00 ; $4075
	call ClearMemory16 ; $4077
	ld hl, $c000 ; $407a
	ld c, $0a ; $407d
	call ClearMemory16 ; $407f
	call ClearDebugTextBuffer ; $4082
	call Func_01_50e2 ; $4085
	call Func_01_5188 ; $4088
	farcall FarPtr_ValidateSaveRam ; $408b
	farcall FarPtr_RepairAllSaveSlots ; $408e
	farcall FarPtr_03_2e ; $4091
	farcall FarPtr_UpdateUnlockablesSaveBlock ; $4094
	farcall FarPtr_InitStoryModeState ; $4097
	farcall FarPtr_InitDefaultMatchSettings ; $409a
	call EnableLCD ; $409d
	ld c, $7f ; $40a0
	call BeginFadeIn ; $40a2
Label_01_40a5:
	ld hl, wStoryModeCurrentLocation ; $40a5
	ld [hl], $00 ; $40a8
	ld hl, $c295 ; $40aa
	ld [hl], $0a ; $40ad
	farcall FarPtr_0a_5c ; $40af
Label_01_40b2:
	ld hl, $0153 ; $40b2
	ld de, $0511 ; $40b5
	call PrintString ; $40b8
	ld a, $03 ; $40bb
	ldh [hDebugStepMode], a ; $40bd
Label_01_40bf:
	ldh a, [hInputPressed] ; $40bf
	bit 0, a ; $40c1
	jr z, Label_01_40cf ; $40c3
	push de ; $40c5
	ld de, $07e0 ; $40c6
	farcall FarPtr_SetSaveFlag ; $40c9
	pop de ; $40cc
	jr Label_01_40d8 ; $40cd
Label_01_40cf:
	bit 3, a ; $40cf
	jr nz, Label_01_40d8 ; $40d1
	call AdvanceFrame ; $40d3
	jr Label_01_40bf ; $40d6
Label_01_40d8:
	ld a, $00 ; $40d8
	ldh [hDebugStepMode], a ; $40da
	ld hl, wStoryModeCurrentLocation ; $40dc
	ld [hl], $00 ; $40df
	ld hl, $c295 ; $40e1
	ld [hl], $0a ; $40e4
	farcall FarPtr_0a_5c ; $40e6
	jp Label_01_40b2 ; $40e9
Unused_01_MenuRedraw:
	ld hl, $0153 ; $40ec
	ld de, $0511 ; $40ef
	call PrintString ; $40f2
	ld a, $03 ; $40f5
	ldh [hDebugStepMode], a ; $40f7
Label_01_40f9:
	ldh a, [hInputPressed] ; $40f9
	bit 3, a ; $40fb
	jr z, Label_01_4113 ; $40fd
	ld a, $01 ; $40ff
	ldh [hDebugStepMode], a ; $4101
	ld hl, wStoryModeCurrentLocation ; $4103
	ld [hl], $00 ; $4106
	ld hl, $c295 ; $4108
	ld [hl], $0a ; $410b
	farcall FarPtr_0a_5c ; $410d
	jp Label_01_40a5 ; $4110
Label_01_4113:
	bit 2, a ; $4113
	jr z, Label_01_411a ; $4115
	farcall FarPtr_01_16 ; $4117
Label_01_411a:
	bit 0, a ; $411a
	jr z, Label_01_4127 ; $411c
	ld a, $01 ; $411e
	ldh [hDebugStepMode], a ; $4120
Label_01_4122:
	farcall FarPtr_RunDebugTestMatch ; $4122
	jr Label_01_4122 ; $4125
Label_01_4127:
	bit 1, a ; $4127
	jr z, Label_01_4138 ; $4129
	ld a, $01 ; $412b
	ldh [hDebugStepMode], a ; $412d
Label_01_412f:
	farcall FarPtr_3b_00 ; $412f
	farcall FarPtr_RunMatch ; $4132
	jp Label_01_412f ; $4135
Label_01_4138:
	bit 6, a ; $4138
	jp z, Label_01_41c2 ; $413a
	ld a, $01 ; $413d
	ldh [hDebugStepMode], a ; $413f
	ld a, $00 ; $4141
	ld [$c36c], a ; $4143
	farcall FarPtr_CheckStorySlot ; $4146
	ld b, $00 ; $4149
	ld c, $04 ; $414b
	farcall FarPtr_3b_1c ; $414d
	ld b, $01 ; $4150
	ld c, $02 ; $4152
	farcall FarPtr_3b_1c ; $4154
	ld a, $01 ; $4157
	ld [wCurrentMinigameStoryMatch], a ; $4159
	ld a, $11 ; $415c
	ld [$c8f7], a ; $415e
	ld a, $01 ; $4161
	ld [wMatchWinLoseFlag], a ; $4163
	ld a, $00 ; $4166
	ld [$c36c], a ; $4168
	farcall FarPtr_CheckStorySlot ; $416b
	ld a, $17 ; $416e
	ld [wPlayer1CurrentMainCharacter], a ; $4170
	ld a, $18 ; $4173
	ld [wPlayer1CurrentPartnerCharacter], a ; $4175
	ld a, $19 ; $4178
	ld [wPlayer2CurrentMainCharacter], a ; $417a
	ld a, $1a ; $417d
	ld [wPlayer2CurrentPartnerCharacter], a ; $417f
	ld a, $03 ; $4182
	ld [$cb0c], a ; $4184
	ld de, $002f ; $4187
	call SetGameFlagByNumber ; $418a
	ld a, $00 ; $418d
	ld [$c8f7], a ; $418f
Label_01_4192:
	farcall FarPtr_RunMatchWinLoseScreen ; $4192
	ld a, [$c8f7] ; $4195
	inc a ; $4198
	ld [$c8f7], a ; $4199
	jr Label_01_4192 ; $419c
Unused_01_MatchSetup:
	farcall FarPtr_3e_10 ; $419e
	ld de, $002f ; $41a1
	call ClearGameFlagByNumber ; $41a4
	ld a, $04 ; $41a7
	ld [wGameMode], a ; $41a9
	farcall FarPtr_RunMatchStatsScreen ; $41ac
	farcall FarPtr_3e_12 ; $41af
	farcall FarPtr_3e_04 ; $41b2
	farcall FarPtr_3e_0e ; $41b5
	farcall FarPtr_3e_0c ; $41b8
	ld a, $01 ; $41bb
	ldh [hDebugStepMode], a ; $41bd
	farcall FarPtr_1a_08 ; $41bf
Label_01_41c2:
	bit 7, a ; $41c2
	jr z, Label_01_41db ; $41c4
	ld a, $01 ; $41c6
	ldh [hDebugStepMode], a ; $41c8
	ld a, $00 ; $41ca
	ldh [hDebugStepMode], a ; $41cc
Label_01_41ce:
	farcall FarPtr_6b_00 ; $41ce
	farcall FarPtr_6b_02 ; $41d1
	jr Label_01_41ce ; $41d4
Unused_01_41d6:
	jp Label_01_40a5 ; $41d6
	db $18 ; $41d9
	db $ef ; $41da
Label_01_41db:
	bit 4, a ; $41db
	jr z, Label_01_41f5 ; $41dd
	ld a, $01 ; $41df
	ldh [hDebugStepMode], a ; $41e1
	ld hl, wStoryModeCurrentLocation ; $41e3
	ld [hl], $03 ; $41e6
	ld hl, $c295 ; $41e8
	ld [hl], $0a ; $41eb
	ld a, $00 ; $41ed
	ld [wStoryModeMainCharacterOverworldSprite], a ; $41ef
	farcall FarPtr_0a_5c ; $41f2
Label_01_41f5:
	bit 5, a ; $41f5
	jr z, Label_01_4209 ; $41f7
	ld a, $01 ; $41f9
	ldh [hDebugStepMode], a ; $41fb
	farcall FarPtr_1a_08 ; $41fd
	ld a, $00 ; $4200
	ldh [hDebugStepMode], a ; $4202
Label_01_4204:
	call AdvanceFrame ; $4204
	jr Label_01_4204 ; $4207
Label_01_4209:
	call AdvanceFrame ; $4209
	jp Label_01_40f9 ; $420c
MenuTilesA_01:
	INCBIN "data/bank_001/d_420f.bin" ; $420f, 257 bytes
	ds 256, $00 ; $4310, fill
MenuTilesB_01:
	INCBIN "data/bank_001/d_4410.bin" ; $4410, 3136 bytes
Func_01_5050:
	push af ; $5050
	push bc ; $5051
	push de ; $5052
	push hl ; $5053
	ld hl, $5010 ; $5054
	ld de, $0001 ; $5057
	call LoadPaletteShadow ; $505a
	pop hl ; $505d
	pop de ; $505e
	pop bc ; $505f
	pop af ; $5060
	ret ; $5061
Func_01_5062:
	push af ; $5062
	push bc ; $5063
	push de ; $5064
	push hl ; $5065
	ld hl, $4210 ; $5066
	ld de, $9000 ; $5069
	ld c, $10 ; $506c
	call QueueVRAMCopy ; $506e
	pop hl ; $5071
	pop de ; $5072
	pop bc ; $5073
	pop af ; $5074
	ret ; $5075
Func_01_5076:
	push af ; $5076
	push bc ; $5077
	push de ; $5078
	push hl ; $5079
	ld hl, MenuTilesB_01 ; $507a
	ld de, $9200 ; $507d
	ld c, $60 ; $5080
	call QueueVRAMCopy ; $5082
	ld hl, $4a10 ; $5085
	ld de, $8800 ; $5088
	ld c, $60 ; $508b
	call QueueVRAMCopy ; $508d
	pop hl ; $5090
	pop de ; $5091
	pop bc ; $5092
	pop af ; $5093
	ret ; $5094
Func_01_5095:
	push af ; $5095
	push bc ; $5096
	push de ; $5097
	push hl ; $5098
	ld hl, MenuTilesB_01 ; $5099
	ld de, $9200 ; $509c
	ld c, $20 ; $509f
	call QueueVRAMCopy ; $50a1
	call AdvanceFrame ; $50a4
	ld hl, $4610 ; $50a7
	ld de, $9400 ; $50aa
	ld c, $20 ; $50ad
	call QueueVRAMCopy ; $50af
	call AdvanceFrame ; $50b2
	ld hl, $4810 ; $50b5
	ld de, $9600 ; $50b8
	ld c, $20 ; $50bb
	call QueueVRAMCopy ; $50bd
	call AdvanceFrame ; $50c0
	ld hl, $5010 ; $50c3
	ld de, $8e00 ; $50c6
	ld c, $20 ; $50c9
	call QueueVRAMCopy ; $50cb
	call AdvanceFrame ; $50ce
	pop hl ; $50d1
	pop de ; $50d2
	pop bc ; $50d3
	pop af ; $50d4
	ret ; $50d5
Func_01_50d6:
	ld hl, $4610 ; $50d6
	ld de, $9400 ; $50d9
	ld c, $20 ; $50dc
	call QueueVRAMCopy ; $50de
	ret ; $50e1
Func_01_50e2:
	call Func_01_5050 ; $50e2
	call Func_01_5062 ; $50e5
	call Func_01_5076 ; $50e8
	ret ; $50eb
Func_01_50ec:
	call Func_01_5050 ; $50ec
	call Func_01_5062 ; $50ef
	call Func_01_5095 ; $50f2
	ret ; $50f5
DebugMenuPalettes_01:
	; $50f6, 128 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $2928, $7fff, $39ce, $0000 ; pal 0: #414a52 #ffffff #737373 #000000
	dw $294a, $294a, $294a, $294a ; pal 1: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 2: #525252 #525252 #525252 #525252
	dw $1adc, $6bff, $1e40, $0000 ; pal 3: #e6b431 #ffffd5 #009439 #000000
	dw $225f, $6bff, $505c, $0000 ; pal 4: #ff9441 #ffffd5 #e610a4 #000000
	dw $331f, $6bff, $01df, $0000 ; pal 5: #ffc562 #ffffd5 #ff7300 #000000
	dw $5a9f, $6bff, $001f, $0000 ; pal 6: #ffa4b4 #ffffd5 #ff0000 #000000
	dw $3acc, $6bff, $7d4a, $0000 ; pal 7: #62b473 #ffffd5 #5252ff #000000
	dw $6e43, $679f, $258f, $0000 ; pal 8: #1894de #ffe6cd #7b624a #000000
	dw $294a, $294a, $294a, $294a ; pal 9: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 10: #525252 #525252 #525252 #525252
	dw $01ff, $011f, $7fff, $0000 ; pal 11: #ff7b00 #ff4100 #ffffff #000000
	dw $01ff, $011f, $7fff, $0000 ; pal 12: #ff7b00 #ff4100 #ffffff #000000
	dw $01ff, $011f, $7fff, $0000 ; pal 13: #ff7b00 #ff4100 #ffffff #000000
	dw $01ff, $011f, $7fff, $0000 ; pal 14: #ff7b00 #ff4100 #ffffff #000000
	dw $01ff, $011f, $7fff, $0000 ; pal 15: #ff7b00 #ff4100 #ffffff #000000
Func_01_5176:
	push af ; $5176
	push bc ; $5177
	push de ; $5178
	push hl ; $5179
	ld hl, $87c8 ; $517a
	ld de, $0305 ; $517d
	call LoadPaletteShadow ; $5180
	pop hl ; $5183
	pop de ; $5184
	pop bc ; $5185
	pop af ; $5186
	ret ; $5187
Func_01_5188:
	push af ; $5188
	push bc ; $5189
	push de ; $518a
	push hl ; $518b
	ld hl, $87c8 ; $518c
	ld de, $0b05 ; $518f
	call LoadPaletteShadow ; $5192
	pop hl ; $5195
	pop de ; $5196
	pop bc ; $5197
	pop af ; $5198
	ret ; $5199
Func_01_519a:
	ld a, b ; $519a
	add a, a ; $519b
	add a, a ; $519c
	add a, a ; $519d
	add a, $f6 ; $519e
	ld l, a ; $51a0
	adc a, $50 ; $51a1
	sub a, l ; $51a3
	ld h, a ; $51a4
	ld e, $01 ; $51a5
	call LoadPaletteShadow ; $51a7
	ret ; $51aa
UnusedTiles_01_51ab:
	INCBIN "data/bank_001/d_51ab.bin" ; $51ab, 261 bytes
	ds 256, $00 ; $52b0, fill
UnusedTiles_01_53b0:
	INCBIN "data/bank_001/d_53b0.bin" ; $53b0, 3200 bytes
Func_01_6030:
	ld a, $00 ; $6030
	ldh [rLCDC], a ; $6032
	ld hl, MenuGfxLZ_01 ; $6034
	ld de, $d000 ; $6037
	call DecompressData ; $603a
	ld hl, $d000 ; $603d
	ld de, $9000 ; $6040
	ld c, $80 ; $6043
	call CopyMemoryFast ; $6045
	ld hl, $d800 ; $6048
	ld de, $8800 ; $604b
	ld c, $80 ; $604e
	call CopyMemoryFast ; $6050
	ld hl, MenuGfxLZ2_01 ; $6053
	ld de, $d000 ; $6056
	call DecompressData ; $6059
	ld hl, $d000 ; $605c
	ld de, $9800 ; $605f
	ld c, $40 ; $6062
	call CopyMemoryFast ; $6064
	ld a, $e4 ; $6067
	ldh [rBGP], a ; $6069
	xor a, a ; $606b
	ldh [rIF], a ; $606c
	ld a, $00 ; $606e
	ldh [rIE], a ; $6070
	ld a, $c1 ; $6072
	ldh [rLCDC], a ; $6074
	ei ; $6076
Label_01_6077:
	call AdvanceFrame ; $6077
	jr Label_01_6077 ; $607a
MenuGfxLZ_01:
	INCBIN "data/bank_001/d_607c.bin" ; $607c, 2183 bytes
MenuGfxLZ2_01:
	INCBIN "data/bank_001/d_6903.bin" ; $6903, 344 bytes
Func_01_6a5b:
	push af ; $6a5b
	push bc ; $6a5c
	push de ; $6a5d
	push hl ; $6a5e
	ld a, [$ca00] ; $6a5f
	ld d, a ; $6a62
	ld a, [$ca01] ; $6a63
	ld e, a ; $6a66
	ld b, $00 ; $6a67
	ldh a, [hDebugStepMode] ; $6a69
	push af ; $6a6b
	ld a, $03 ; $6a6c
	ldh [hDebugStepMode], a ; $6a6e
	push hl ; $6a70
	push de ; $6a71
	ld hl, SoundTestStrings_01 ; $6a72
	ld de, $0d09 ; $6a75
	call PrintString ; $6a78
	pop de ; $6a7b
	pop hl ; $6a7c
	push hl ; $6a7d
	push de ; $6a7e
	ld hl, $6b6a ; $6a7f
	ld de, $0d0b ; $6a82
	call PrintString ; $6a85
	pop de ; $6a88
	pop hl ; $6a89
Label_01_6a8a:
	call AdvanceFrame ; $6a8a
	ldh a, [hInputPressed] ; $6a8d
	and a, $c0 ; $6a8f
	jr z, Label_01_6a97 ; $6a91
	ld a, b ; $6a93
	xor a, $01 ; $6a94
	ld b, a ; $6a96
Label_01_6a97:
	ld a, b ; $6a97
	or a, a ; $6a98
	jr nz, Label_01_6abd ; $6a99
	ldh a, [hInputPressed] ; $6a9b
	bit 4, a ; $6a9d
	jr z, Label_01_6aa4 ; $6a9f
	inc d ; $6aa1
	jr Label_01_6aa9 ; $6aa2
Label_01_6aa4:
	bit 5, a ; $6aa4
	jr z, Label_01_6add ; $6aa6
	dec d ; $6aa8
Label_01_6aa9:
	ld a, d ; $6aa9
	cp a, $ff ; $6aaa
	jr nz, Label_01_6ab2 ; $6aac
	ld d, $3e ; $6aae
	jr Label_01_6add ; $6ab0
Label_01_6ab2:
	ld a, d ; $6ab2
	cp a, $3e ; $6ab3
	jr c, Label_01_6add ; $6ab5
	jr z, Label_01_6add ; $6ab7
	ld d, $00 ; $6ab9
	jr Label_01_6add ; $6abb
Label_01_6abd:
	ldh a, [hInputPressed] ; $6abd
	bit 4, a ; $6abf
	jr z, Label_01_6ac6 ; $6ac1
	inc e ; $6ac3
	jr Label_01_6acb ; $6ac4
Label_01_6ac6:
	bit 5, a ; $6ac6
	jr z, Label_01_6add ; $6ac8
	dec e ; $6aca
Label_01_6acb:
	ld a, e ; $6acb
	cp a, $ff ; $6acc
	jr nz, Label_01_6ad4 ; $6ace
	ld e, $71 ; $6ad0
	jr Label_01_6add ; $6ad2
Label_01_6ad4:
	ld a, e ; $6ad4
	cp a, $71 ; $6ad5
	jr c, Label_01_6add ; $6ad7
	jr z, Label_01_6add ; $6ad9
	ld e, $00 ; $6adb
Label_01_6add:
	ld a, b ; $6add
	or a, a ; $6ade
	jr nz, Label_01_6afd ; $6adf
	push hl ; $6ae1
	push de ; $6ae2
	ld hl, $6b71 ; $6ae3
	ld de, $0c09 ; $6ae6
	call PrintString ; $6ae9
	pop de ; $6aec
	pop hl ; $6aed
	push hl ; $6aee
	push de ; $6aef
	ld hl, $6b73 ; $6af0
	ld de, $0c0b ; $6af3
	call PrintString ; $6af6
	pop de ; $6af9
	pop hl ; $6afa
	jr Label_01_6b17 ; $6afb
Label_01_6afd:
	push hl ; $6afd
	push de ; $6afe
	ld hl, $6b71 ; $6aff
	ld de, $0c0b ; $6b02
	call PrintString ; $6b05
	pop de ; $6b08
	pop hl ; $6b09
	push hl ; $6b0a
	push de ; $6b0b
	ld hl, $6b73 ; $6b0c
	ld de, $0c09 ; $6b0f
	call PrintString ; $6b12
	pop de ; $6b15
	pop hl ; $6b16
Label_01_6b17:
	push de ; $6b17
	push af ; $6b18
	ld a, d ; $6b19
	ld de, $0e0a ; $6b1a
	call PrintDecimalByte ; $6b1d
	pop af ; $6b20
	pop de ; $6b21
	push de ; $6b22
	push af ; $6b23
	ld a, e ; $6b24
	ld de, $0e0c ; $6b25
	call PrintDecimalByte ; $6b28
	pop af ; $6b2b
	pop de ; $6b2c
	ldh a, [hInputPressed] ; $6b2d
	bit 0, a ; $6b2f
	jr z, Label_01_6b61 ; $6b31
	bit 0, b ; $6b33
	jr nz, Label_01_6b4d ; $6b35
	push af ; $6b37
	push bc ; $6b38
	push de ; $6b39
	push hl ; $6b3a
	ld a, d ; $6b3b
	add a, $75 ; $6b3c
	ld l, a ; $6b3e
	adc a, $6b ; $6b3f
	sub a, l ; $6b41
	ld h, a ; $6b42
	ld a, [hl] ; $6b43
	call PlaySoundManaged ; $6b44
	pop hl ; $6b47
	pop de ; $6b48
	pop bc ; $6b49
	pop af ; $6b4a
	jr Label_01_6b61 ; $6b4b
Label_01_6b4d:
	push af ; $6b4d
	push bc ; $6b4e
	push de ; $6b4f
	push hl ; $6b50
	ld a, e ; $6b51
	add a, $b4 ; $6b52
	ld l, a ; $6b54
	adc a, $6b ; $6b55
	sub a, l ; $6b57
	ld h, a ; $6b58
	ld a, [hl] ; $6b59
	call PlaySoundManaged ; $6b5a
	pop hl ; $6b5d
	pop de ; $6b5e
	pop bc ; $6b5f
	pop af ; $6b60
Label_01_6b61:
	jp Label_01_6a8a ; $6b61
SoundTestStrings_01:
	; $6b64, 17 bytes (bytes:16)
	db $4d, $55, $53, $49, $43, $00, $45, $46, $46, $45, $43, $54, $00, $3e, $00, $20 ; 0x00
	db $00 ; 0x10
SoundTestSoundsA_01:
	; $6b75, 63 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x00
	db $10, $11, $12, $13, $14, $15, $16, $17, $18, $16, $11, $12, $14, $19, $13, $15 ; 0x10
	db $14, $1a, $1b, $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24, $25, $26, $27, $28 ; 0x20
	db $29, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $32, $41, $42, $43, $44, $45 ; 0x30
SoundTestSoundsB_01:
	; $6bb4, 114 bytes (bytes:16)
	db $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f ; 0x00
	db $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6a, $6b, $6c, $6d, $6e, $6f ; 0x10
	db $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7a, $7b, $7c, $7d, $7e, $7f ; 0x20
	db $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f ; 0x30
	db $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f ; 0x40
	db $a0, $a1, $a2, $a3, $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af ; 0x50
	db $b0, $b1, $b2, $b3, $b4, $b5, $b6, $b7, $b8, $b9, $ba, $bb, $bc, $bd, $be, $bf ; 0x60
	db $c0, $c1 ; 0x70
	ds 5082, $ff ; $6c26, fill

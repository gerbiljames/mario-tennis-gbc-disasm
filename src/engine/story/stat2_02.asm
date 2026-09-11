EquipStatDeltaPtrs_02:
	; $46eb, 4 bytes (records:2)
	dw RacketStatDeltas_02 ; record 0
	dw ShoeStatDeltas_02 ; record 1
RacketStatDeltas_02:
	; $46ef, 112 bytes (equip_stat_deltas)
; equip_stat_deltas Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
	equip_stat_deltas 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 0 Normal
	equip_stat_deltas -2, -2, -1, -1, 0, 2, 1, 0, 0, 0, 0 ; 1 Large
	equip_stat_deltas 1, 1, 2, 1, 0, -2, -2, 0, 0, 0, 0 ; 2 Small
	equip_stat_deltas 0, 0, -2, -2, -2, 0, 0, 0, 0, 0, 0 ; 3 Iron
	equip_stat_deltas 0, 0, 2, 2, -1, -1, 0, 0, 0, 0, 0 ; 4 Gold
	equip_stat_deltas 0, 0, -1, -1, 3, 1, 1, 0, 0, 0, 0 ; 5 Silver
	equip_stat_deltas 3, 0, -2, -2, 0, 0, 0, 0, 0, 0, 0 ; 6 Drive
ShoeStatDeltas_02:
	; $475f, 48 bytes (equip_stat_deltas)
; equip_stat_deltas Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
	equip_stat_deltas 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 0 Normal
	equip_stat_deltas 0, 0, 0, 0, 0, 0, 0, -2, -2, -2, -2 ; 1 Iron
	equip_stat_deltas 0, 0, 0, 0, 0, 0, 0, 2, 2, -2, -2 ; 2 Light
RefreshMainCharacterStats:
	ld bc, wStoryModeNameOfMainCharacter ; $478f
	call RecomputeCharacterStats ; $4792
	ld hl, wStoryModeNameOfMainCharacter ; $4795
	ld de, wStorySlotData ; $4798
	ld c, $08 ; $479b
	call CopyMemoryFast ; $479d
	ld a, [wMainCharEquipmentBits] ; $47a0
	ld b, a ; $47a3
	and $0f ; $47a4
	cp $03 ; $47a6
	jr nz, .checkHighNibble ; $47a8
	ld a, b ; $47aa
	and $f0 ; $47ab
	ld b, a ; $47ad
.checkHighNibble:
	ld a, b ; $47ae
	swap a ; $47af
	and $0f ; $47b1
	cp $01 ; $47b3
	jr nz, .store ; $47b5
	ld a, b ; $47b7
	and $0f ; $47b8
	ld b, a ; $47ba
.store:
	ld a, b ; $47bb
	ld [wMainCharEquipmentBits], a ; $47bc
	ld bc, wStorySlotData ; $47bf
	call RecomputeCharacterStats ; $47c2
	ret ; $47c5
RecomputeStatsWithoutRacket:
	ld hl, wEquippedRacket ; $47c6
	ld a, [hl] ; $47c9
	push af ; $47ca
	xor a ; $47cb
	ld [hl], a ; $47cc
	ld bc, wStoryModeNameOfMainCharacter ; $47cd
	call RecomputeCharacterStats ; $47d0
	pop af ; $47d3
	ld [wEquippedRacket], a ; $47d4
	ret ; $47d7
EquipData_02:
	; $47d8, 26 bytes (bytes:16)
	db $f5, $21, $0b, $00, $09, $7e, $e6, $03, $87, $c6, $f2, $6f, $ce, $47, $95, $67 ; 0x00
	db $2a, $66, $6f, $f1, $85, $6f, $30, $01, $24, $c9 ; 0x10
StatArchetypePtrs_02:
	; $47f2, 8 bytes (records:2)
	dw StatArchetype0_02 ; record 0
	dw StatArchetype1_02 ; record 1
	dw StatArchetype2_02 ; record 2
	dw StatArchetype3_02 ; record 3
StatArchetype0_02:
	; $47fa, 113 bytes (stat archetype)
	db 1 ; level / class tier -> record +$18
	db $79, $00, $a0, $00, $99, $09, $0d, $00 ; physics template -> record +$30-+$37
	db 0, 0, 0, 0 ; Spin, Power, Control, Speed levels -> record +$38-+$3b
	stat_thresholds 2, 5, 8, 11, 13, 16, 19, 23, 28 ; Top
	stat_thresholds 4, 7, 10, 13, 15, 18, 21, 25, 30 ; Slice
	stat_thresholds 3, 8, 11, 15, 18, 22, 26, 31, 38 ; Serve
	stat_thresholds -3, 2, 6, 9, 13, 17, 21, 27, 34 ; Stroke
	stat_thresholds 2, 7, 11, 14, 18, 21, 26, 31, 38 ; Volley
	stat_thresholds 3, 8, 11, 14, 18, 21, 25, 31, 37 ; Angle
	stat_thresholds 4, 9, 13, 16, 20, 23, 28, 33, 40 ; Placement
	stat_thresholds 2, 5, 8, 10, 12, 15, 18, 21, 26 ; Speed
	stat_thresholds -6, -2, 1, 4, 7, 10, 14, 18, 24 ; Dash
	stat_thresholds 4, 7, 10, 13, 15, 18, 21, 25, 30 ; Reaction
	stat_thresholds 3, 8, 11, 15, 18, 22, 26, 31, 38 ; Stop
	db $ff
StatArchetype1_02:
	; $486b, 113 bytes (stat archetype)
	db 1 ; level / class tier -> record +$18
	db $80, $00, $a0, $00, $33, $09, $0e, $00 ; physics template -> record +$30-+$37
	db 0, 0, 0, 0 ; Spin, Power, Control, Speed levels -> record +$38-+$3b
	stat_thresholds 4, 8, 11, 14, 17, 20, 24, 28, 34 ; Top
	stat_thresholds 3, 7, 9, 12, 15, 17, 21, 25, 30 ; Slice
	stat_thresholds 5, 10, 14, 17, 21, 25, 29, 35, 42 ; Serve
	stat_thresholds 3, 7, 10, 13, 16, 20, 23, 28, 34 ; Stroke
	stat_thresholds 2, 6, 9, 12, 15, 18, 22, 26, 32 ; Volley
	stat_thresholds 2, 6, 9, 12, 15, 17, 21, 25, 31 ; Angle
	stat_thresholds -3, 1, 4, 7, 10, 13, 17, 21, 27 ; Placement
	stat_thresholds 3, 6, 9, 12, 14, 17, 20, 24, 29 ; Speed
	stat_thresholds 4, 7, 9, 11, 13, 16, 18, 22, 26 ; Dash
	stat_thresholds -4, 1, 5, 9, 13, 16, 21, 27, 34 ; Reaction
	stat_thresholds 2, 6, 10, 13, 16, 20, 24, 29, 35 ; Stop
	db $ff
StatArchetype2_02:
	; $48dc, 113 bytes (stat archetype)
	db 1 ; level / class tier -> record +$18
	db $90, $00, $a3, $00, $99, $07, $0b, $00 ; physics template -> record +$30-+$37
	db 0, 0, 0, 0 ; Spin, Power, Control, Speed levels -> record +$38-+$3b
	stat_thresholds -3, 2, 6, 10, 14, 18, 23, 29, 36 ; Top
	stat_thresholds 2, 8, 12, 16, 20, 24, 29, 35, 42 ; Slice
	stat_thresholds -8, -2, 3, 8, 12, 17, 23, 29, 38 ; Serve
	stat_thresholds 1, 7, 11, 15, 19, 24, 29, 35, 43 ; Stroke
	stat_thresholds 3, 9, 14, 18, 22, 27, 32, 39, 47 ; Volley
	stat_thresholds -2, 4, 8, 13, 17, 21, 27, 33, 41 ; Angle
	stat_thresholds 3, 9, 13, 17, 21, 25, 30, 36, 44 ; Placement
	stat_thresholds -4, 3, 9, 14, 19, 24, 31, 38, 48 ; Speed
	stat_thresholds 2, 9, 14, 19, 24, 29, 35, 43, 52 ; Dash
	stat_thresholds 3, 9, 13, 17, 21, 26, 31, 37, 45 ; Reaction
	stat_thresholds 6, 14, 20, 26, 32, 38, 45, 54, 65 ; Stop
	db $ff
StatArchetype3_02:
	; $494d, 113 bytes (stat archetype)
	db 1 ; level / class tier -> record +$18
	db $86, $00, $a9, $00, $c2, $07, $0b, $00 ; physics template -> record +$30-+$37
	db 0, 0, 0, 0 ; Spin, Power, Control, Speed levels -> record +$38-+$3b
	stat_thresholds 2, 8, 12, 16, 20, 24, 29, 35, 42 ; Top
	stat_thresholds -4, 2, 6, 10, 14, 19, 24, 30, 38 ; Slice
	stat_thresholds -2, 4, 9, 14, 18, 23, 29, 35, 44 ; Serve
	stat_thresholds 4, 10, 14, 18, 22, 27, 32, 38, 46 ; Stroke
	stat_thresholds 2, 7, 11, 15, 19, 22, 27, 33, 40 ; Volley
	stat_thresholds -10, -2, 4, 10, 16, 21, 29, 37, 48 ; Angle
	stat_thresholds 2, 8, 12, 16, 20, 24, 29, 35, 42 ; Placement
	stat_thresholds 3, 9, 14, 18, 22, 27, 32, 39, 47 ; Speed
	stat_thresholds -3, 4, 9, 13, 18, 23, 29, 36, 45 ; Dash
	stat_thresholds 4, 10, 15, 19, 23, 28, 33, 40, 48 ; Reaction
	stat_thresholds 6, 11, 15, 18, 22, 25, 30, 35, 42 ; Stop
	db $ff
LevelUpPlayer:
	call GetPlayerRecordPtr ; $49be
LevelUpPlayerRecord:
	ld hl, $0018 ; $49c1
	add hl, bc ; $49c4
	ld a, [hl] ; $49c5
	cp $63 ; $49c6
	jp nc, .done ; $49c8
	ld a, d ; $49cb
	or a ; $49cc
	jr nz, .compare ; $49cd
	ld hl, $0038 ; $49cf
	add hl, bc ; $49d2
	inc [hl] ; $49d3
	jr .recomputeCharacterStats ; $49d4
.compare:
	cp $01 ; $49d6
	jr nz, .compare2 ; $49d8
	ld hl, $0039 ; $49da
	add hl, bc ; $49dd
	inc [hl] ; $49de
	jr .recomputeCharacterStats ; $49df
.compare2:
	cp $02 ; $49e1
	jr nz, .compare3 ; $49e3
	ld hl, $003a ; $49e5
	add hl, bc ; $49e8
	inc [hl] ; $49e9
	jr .recomputeCharacterStats ; $49ea
.compare3:
	cp $03 ; $49ec
	jr nz, .recomputeCharacterStats ; $49ee
	ld hl, $003b ; $49f0
	add hl, bc ; $49f3
	inc [hl] ; $49f4
	jr .recomputeCharacterStats ; $49f5
.recomputeCharacterStats:
	ld hl, $0018 ; $49f7
	add hl, bc ; $49fa
	inc [hl] ; $49fb
	call RecomputeCharacterStats ; $49fc
.done:
	ret ; $49ff
ComputeLevelUpStatDeltas:
	ld e, a ; $4a00
	ld a, l ; $4a01
	ldh [hStatDeltaOutPtr], a ; $4a02
	ld a, h ; $4a04
	ldh [hStatDeltaOutPtr + 1], a ; $4a05
	add sp, -64 ; $4a07
	ld hl, sp + 0 ; $4a09
	ld a, l ; $4a0b
	ldh [hStatDeltaRecordCopy], a ; $4a0c
	ld a, h ; $4a0e
	ldh [hStatDeltaRecordCopy + 1], a ; $4a0f
	ld a, e ; $4a11
	call GetPlayerRecordPtr ; $4a12
	push bc ; $4a15
	push bc ; $4a16
	push de ; $4a17
	ld e, l ; $4a18
	ld d, h ; $4a19
	ld l, c ; $4a1a
	ld h, b ; $4a1b
	ld bc, $0004 ; $4a1c
	call CopyMemoryFast ; $4a1f
	pop de ; $4a22
	pop bc ; $4a23
	call LevelUpPlayerRecord ; $4a24
	ld hl, hStatDeltaRecordCopy ; $4a27
	ld a, [hl+] ; $4a2a
	ld h, [hl] ; $4a2b
	ld l, a ; $4a2c
	ld de, $0020 ; $4a2d
	add hl, de ; $4a30
	ld d, [hl] ; $4a31
	ld hl, $0020 ; $4a32
	add hl, bc ; $4a35
	ld a, [hl] ; $4a36
	sub d ; $4a37
	ld d, a ; $4a38
	ld hl, hStatDeltaOutPtr ; $4a39
	ld a, [hl+] ; $4a3c
	ld h, [hl] ; $4a3d
	ld l, a ; $4a3e
	ld [hl], d ; $4a3f
	inc hl ; $4a40
	ld a, l ; $4a41
	ldh [hStatDeltaOutPtr], a ; $4a42
	ld a, h ; $4a44
	ldh [hStatDeltaOutPtr + 1], a ; $4a45
	ld hl, hStatDeltaRecordCopy ; $4a47
	ld a, [hl+] ; $4a4a
	ld h, [hl] ; $4a4b
	ld l, a ; $4a4c
	ld de, $0021 ; $4a4d
	add hl, de ; $4a50
	ld d, [hl] ; $4a51
	ld hl, $0021 ; $4a52
	add hl, bc ; $4a55
	ld a, [hl] ; $4a56
	sub d ; $4a57
	ld d, a ; $4a58
	ld hl, hStatDeltaOutPtr ; $4a59
	ld a, [hl+] ; $4a5c
	ld h, [hl] ; $4a5d
	ld l, a ; $4a5e
	ld [hl], d ; $4a5f
	inc hl ; $4a60
	ld a, l ; $4a61
	ldh [hStatDeltaOutPtr], a ; $4a62
	ld a, h ; $4a64
	ldh [hStatDeltaOutPtr + 1], a ; $4a65
	ld hl, hStatDeltaRecordCopy ; $4a67
	ld a, [hl+] ; $4a6a
	ld h, [hl] ; $4a6b
	ld l, a ; $4a6c
	ld de, $0022 ; $4a6d
	add hl, de ; $4a70
	ld d, [hl] ; $4a71
	ld hl, $0022 ; $4a72
	add hl, bc ; $4a75
	ld a, [hl] ; $4a76
	sub d ; $4a77
	ld d, a ; $4a78
	ld hl, hStatDeltaOutPtr ; $4a79
	ld a, [hl+] ; $4a7c
	ld h, [hl] ; $4a7d
	ld l, a ; $4a7e
	ld [hl], d ; $4a7f
	inc hl ; $4a80
	ld a, l ; $4a81
	ldh [hStatDeltaOutPtr], a ; $4a82
	ld a, h ; $4a84
	ldh [hStatDeltaOutPtr + 1], a ; $4a85
	ld hl, hStatDeltaRecordCopy ; $4a87
	ld a, [hl+] ; $4a8a
	ld h, [hl] ; $4a8b
	ld l, a ; $4a8c
	ld de, $0023 ; $4a8d
	add hl, de ; $4a90
	ld d, [hl] ; $4a91
	ld hl, $0023 ; $4a92
	add hl, bc ; $4a95
	ld a, [hl] ; $4a96
	sub d ; $4a97
	ld d, a ; $4a98
	ld hl, hStatDeltaOutPtr ; $4a99
	ld a, [hl+] ; $4a9c
	ld h, [hl] ; $4a9d
	ld l, a ; $4a9e
	ld [hl], d ; $4a9f
	inc hl ; $4aa0
	ld a, l ; $4aa1
	ldh [hStatDeltaOutPtr], a ; $4aa2
	ld a, h ; $4aa4
	ldh [hStatDeltaOutPtr + 1], a ; $4aa5
	ld hl, hStatDeltaRecordCopy ; $4aa7
	ld a, [hl+] ; $4aaa
	ld h, [hl] ; $4aab
	ld l, a ; $4aac
	ld de, $0024 ; $4aad
	add hl, de ; $4ab0
	ld d, [hl] ; $4ab1
	ld hl, $0024 ; $4ab2
	add hl, bc ; $4ab5
	ld a, [hl] ; $4ab6
	sub d ; $4ab7
	ld d, a ; $4ab8
	ld hl, hStatDeltaOutPtr ; $4ab9
	ld a, [hl+] ; $4abc
	ld h, [hl] ; $4abd
	ld l, a ; $4abe
	ld [hl], d ; $4abf
	inc hl ; $4ac0
	ld a, l ; $4ac1
	ldh [hStatDeltaOutPtr], a ; $4ac2
	ld a, h ; $4ac4
	ldh [hStatDeltaOutPtr + 1], a ; $4ac5
	ld hl, hStatDeltaRecordCopy ; $4ac7
	ld a, [hl+] ; $4aca
	ld h, [hl] ; $4acb
	ld l, a ; $4acc
	ld de, $0025 ; $4acd
	add hl, de ; $4ad0
	ld d, [hl] ; $4ad1
	ld hl, $0025 ; $4ad2
	add hl, bc ; $4ad5
	ld a, [hl] ; $4ad6
	sub d ; $4ad7
	ld d, a ; $4ad8
	ld hl, hStatDeltaOutPtr ; $4ad9
	ld a, [hl+] ; $4adc
	ld h, [hl] ; $4add
	ld l, a ; $4ade
	ld [hl], d ; $4adf
	inc hl ; $4ae0
	ld a, l ; $4ae1
	ldh [hStatDeltaOutPtr], a ; $4ae2
	ld a, h ; $4ae4
	ldh [hStatDeltaOutPtr + 1], a ; $4ae5
	ld hl, hStatDeltaRecordCopy ; $4ae7
	ld a, [hl+] ; $4aea
	ld h, [hl] ; $4aeb
	ld l, a ; $4aec
	ld de, $0026 ; $4aed
	add hl, de ; $4af0
	ld d, [hl] ; $4af1
	ld hl, $0026 ; $4af2
	add hl, bc ; $4af5
	ld a, [hl] ; $4af6
	sub d ; $4af7
	ld d, a ; $4af8
	ld hl, hStatDeltaOutPtr ; $4af9
	ld a, [hl+] ; $4afc
	ld h, [hl] ; $4afd
	ld l, a ; $4afe
	ld [hl], d ; $4aff
	inc hl ; $4b00
	ld a, l ; $4b01
	ldh [hStatDeltaOutPtr], a ; $4b02
	ld a, h ; $4b04
	ldh [hStatDeltaOutPtr + 1], a ; $4b05
	ld hl, hStatDeltaRecordCopy ; $4b07
	ld a, [hl+] ; $4b0a
	ld h, [hl] ; $4b0b
	ld l, a ; $4b0c
	ld de, $0027 ; $4b0d
	add hl, de ; $4b10
	ld d, [hl] ; $4b11
	ld hl, $0027 ; $4b12
	add hl, bc ; $4b15
	ld a, [hl] ; $4b16
	sub d ; $4b17
	ld d, a ; $4b18
	ld hl, hStatDeltaOutPtr ; $4b19
	ld a, [hl+] ; $4b1c
	ld h, [hl] ; $4b1d
	ld l, a ; $4b1e
	ld [hl], d ; $4b1f
	inc hl ; $4b20
	ld a, l ; $4b21
	ldh [hStatDeltaOutPtr], a ; $4b22
	ld a, h ; $4b24
	ldh [hStatDeltaOutPtr + 1], a ; $4b25
	ld hl, hStatDeltaRecordCopy ; $4b27
	ld a, [hl+] ; $4b2a
	ld h, [hl] ; $4b2b
	ld l, a ; $4b2c
	ld de, $0028 ; $4b2d
	add hl, de ; $4b30
	ld d, [hl] ; $4b31
	ld hl, $0028 ; $4b32
	add hl, bc ; $4b35
	ld a, [hl] ; $4b36
	sub d ; $4b37
	ld d, a ; $4b38
	ld hl, hStatDeltaOutPtr ; $4b39
	ld a, [hl+] ; $4b3c
	ld h, [hl] ; $4b3d
	ld l, a ; $4b3e
	ld [hl], d ; $4b3f
	inc hl ; $4b40
	ld a, l ; $4b41
	ldh [hStatDeltaOutPtr], a ; $4b42
	ld a, h ; $4b44
	ldh [hStatDeltaOutPtr + 1], a ; $4b45
	ld hl, hStatDeltaRecordCopy ; $4b47
	ld a, [hl+] ; $4b4a
	ld h, [hl] ; $4b4b
	ld l, a ; $4b4c
	ld de, $0029 ; $4b4d
	add hl, de ; $4b50
	ld d, [hl] ; $4b51
	ld hl, $0029 ; $4b52
	add hl, bc ; $4b55
	ld a, [hl] ; $4b56
	sub d ; $4b57
	ld d, a ; $4b58
	ld hl, hStatDeltaOutPtr ; $4b59
	ld a, [hl+] ; $4b5c
	ld h, [hl] ; $4b5d
	ld l, a ; $4b5e
	ld [hl], d ; $4b5f
	inc hl ; $4b60
	ld a, l ; $4b61
	ldh [hStatDeltaOutPtr], a ; $4b62
	ld a, h ; $4b64
	ldh [hStatDeltaOutPtr + 1], a ; $4b65
	ld hl, hStatDeltaRecordCopy ; $4b67
	ld a, [hl+] ; $4b6a
	ld h, [hl] ; $4b6b
	ld l, a ; $4b6c
	ld de, $002a ; $4b6d
	add hl, de ; $4b70
	ld d, [hl] ; $4b71
	ld hl, $002a ; $4b72
	add hl, bc ; $4b75
	ld a, [hl] ; $4b76
	sub d ; $4b77
	ld d, a ; $4b78
	ld hl, hStatDeltaOutPtr ; $4b79
	ld a, [hl+] ; $4b7c
	ld h, [hl] ; $4b7d
	ld l, a ; $4b7e
	ld [hl], d ; $4b7f
	inc hl ; $4b80
	ld a, l ; $4b81
	ldh [hStatDeltaOutPtr], a ; $4b82
	ld a, h ; $4b84
	ldh [hStatDeltaOutPtr + 1], a ; $4b85
	pop bc ; $4b87
	ld hl, hStatDeltaRecordCopy ; $4b88
	ld a, [hl+] ; $4b8b
	ld h, [hl] ; $4b8c
	ld l, a ; $4b8d
	ld e, c ; $4b8e
	ld d, b ; $4b8f
	ld bc, $0004 ; $4b90
	call CopyMemoryFast ; $4b93
	add sp, 64 ; $4b96
	ret ; $4b98
Unused_02_ListForEach:
	add a ; $4b99
	add a ; $4b9a
	ld hl, Unused_02_4b99_Table ; $4b9b
	add l ; $4b9e
	ld l, a ; $4b9f
	jr nc, .levelUpPlayer ; $4ba0
	inc h ; $4ba2
.levelUpPlayer:
	push hl ; $4ba3
	ld d, $ff ; $4ba4
	call LevelUpPlayer ; $4ba6
	pop hl ; $4ba9
	ld a, [hl+] ; $4baa
.loop:
	or a ; $4bab
	jr z, .read ; $4bac
	push af ; $4bae
	push hl ; $4baf
	ld d, $00 ; $4bb0
	call LevelUpPlayer ; $4bb2
	pop hl ; $4bb5
	pop af ; $4bb6
	dec a ; $4bb7
	jr .loop ; $4bb8
.read:
	ld a, [hl+] ; $4bba
.loopB:
	or a ; $4bbb
	jr z, .readB ; $4bbc
	push af ; $4bbe
	push hl ; $4bbf
	ld d, $01 ; $4bc0
	call LevelUpPlayer ; $4bc2
	pop hl ; $4bc5
	pop af ; $4bc6
	dec a ; $4bc7
	jr .loopB ; $4bc8
.readB:
	ld a, [hl+] ; $4bca
.loop2:
	or a ; $4bcb
	jr z, .read2 ; $4bcc
	push af ; $4bce
	push hl ; $4bcf
	ld d, $02 ; $4bd0
	call LevelUpPlayer ; $4bd2
	pop hl ; $4bd5
	pop af ; $4bd6
	dec a ; $4bd7
	jr .loop2 ; $4bd8
.read2:
	ld a, [hl+] ; $4bda
.loop3:
	or a ; $4bdb
	jr z, .zero ; $4bdc
	push af ; $4bde
	push hl ; $4bdf
	ld d, $03 ; $4be0
	call LevelUpPlayer ; $4be2
	pop hl ; $4be5
	pop af ; $4be6
	dec a ; $4be7
	jr .loop3 ; $4be8
.zero:
	xor a ; $4bea
	ld hl, CharDataPtr_02 ; $4beb
	add l ; $4bee
	ld l, a ; $4bef
	jr nc, .read3 ; $4bf0
	inc h ; $4bf2
.read3:
	ld a, [hl+] ; $4bf3
	ld d, [hl] ; $4bf4
	ld e, a ; $4bf5
	ld hl, $0018 ; $4bf6
	add hl, bc ; $4bf9
	ld a, [hl] ; $4bfa
	cp $01 ; $4bfb
	jr z, .done ; $4bfd
	ld h, d ; $4bff
	ld l, e ; $4c00
	ld d, a ; $4c01
	add a ; $4c02
	add d ; $4c03
	add l ; $4c04
	ld l, a ; $4c05
	jr nc, .gotPtr ; $4c06
	inc h ; $4c08
.gotPtr:
	ld d, h ; $4c09
	ld e, l ; $4c0a
	ld hl, $002c ; $4c0b
	add hl, bc ; $4c0e
	ld a, [de] ; $4c0f
	ld [hl+], a ; $4c10
	inc de ; $4c11
	ld a, [de] ; $4c12
	ld [hl+], a ; $4c13
	inc de ; $4c14
	ld a, [de] ; $4c15
	ld [hl], a ; $4c16
.done:
	ret ; $4c17
Unused_02_4b99_Table:
	; $4c18, 64 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $07, $03, $05, $03, $0a, $08, $06, $05, $12, $09, $0d, $06, $10, $06, $08, $04 ; 0x10
	db $00, $00, $00, $00, $08, $02, $04, $01, $0f, $03, $06, $02, $10, $0b, $0a, $08 ; 0x20
	db $06, $00, $01, $01, $07, $02, $03, $02, $13, $15, $11, $0a, $18, $0c, $0f, $07 ; 0x30

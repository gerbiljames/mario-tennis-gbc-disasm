RemapExtendedCharId:
	cp $20 ; $4c58
	ret c ; $4c5a
	push hl ; $4c5b
	sub $20 ; $4c5c
	and $7f ; $4c5e
	ld_hl_indexed NameTextRemap_02 ; $4c60
	ld a, [hl] ; $4c67
	pop hl ; $4c68
	ret ; $4c69
NameTextRemap_02:
	; $4c6a, 71 bytes (bytes:16)
	db $08, $09, $0b, $07, $06, $0a, $04, $05, $0a, $04, $05, $06, $09, $0b, $08, $07 ; 0x00
	db $14, $11, $0c, $08, $0a, $0b, $09, $08, $08, $08, $0b, $0b, $0b, $06, $06, $06 ; 0x10
	db $09, $09, $09, $04, $04, $04, $08, $08, $08, $0c, $0c, $0c, $0c, $0c, $0c, $0c ; 0x20
	db $0c, $1a, $1a, $1f, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $1a, $1a, $1a, $1a, $1a ; 0x30
	db $1a, $1f, $1f, $1f, $1a, $1a, $1a ; 0x40
SetStorySlotFlagB:
	push af ; $4cb1
	ld a, [wCurrentStorySlot] ; $4cb2
	add a ; $4cb5
	ld_hl_indexed StorySlotFlagBIds_02 ; $4cb6
	ld a, [hl+] ; $4cbd
	ld d, [hl] ; $4cbe
	ld e, a ; $4cbf
	pop af ; $4cc0
	and a ; $4cc1
	jr nz, .setSaveFlag ; $4cc2
	farcall ClearSaveFlag ; $4cc4
	ret ; $4cc7
.setSaveFlag:
	farcall SetSaveFlag ; $4cc8
	ret ; $4ccb
StorySlotFlagBIds_02:
	; $4ccc, 8 bytes (save_flag_ids)
	dw SAVEFLAG_STORY_SLOT0_B ; 0
	dw SAVEFLAG_STORY_SLOT1_B ; 1
	dw SAVEFLAG_STORY_SLOT2_B ; 2
	dw $04e0 ; 3: flag $04, 7
TestStorySlotFlagB:
	ld a, [wCurrentStorySlot] ; $4cd4
	add a ; $4cd7
	ld_hl_indexed StorySlotFlagBIds_02 ; $4cd8
	ld a, [hl+] ; $4cdf
	ld d, [hl] ; $4ce0
	ld e, a ; $4ce1
	farcall TestSaveFlag ; $4ce2
	jr z, .zero ; $4ce5
	ld a, $01 ; $4ce7
	ret ; $4ce9
.zero:
	ld a, $00 ; $4cea
	ret ; $4cec
SetStorySlotFlagA:
	push af ; $4ced
	ld a, [wCurrentStorySlot] ; $4cee
	add a ; $4cf1
	ld_hl_indexed StorySlotFlagAIds_02 ; $4cf2
	ld a, [hl+] ; $4cf9
	ld d, [hl] ; $4cfa
	ld e, a ; $4cfb
	pop af ; $4cfc
	and a ; $4cfd
	jr nz, .setSaveFlag ; $4cfe
	farcall ClearSaveFlag ; $4d00
	ret ; $4d03
.setSaveFlag:
	farcall SetSaveFlag ; $4d04
	ret ; $4d07
StorySlotFlagAIds_02:
	; $4d08, 8 bytes (save_flag_ids)
	dw SAVEFLAG_STORY_SLOT0_A ; 0
	dw SAVEFLAG_STORY_SLOT1_A ; 1
	dw SAVEFLAG_STORY_SLOT2_A ; 2
	dw $0460 ; 3: flag $04, 3
TestStorySlotFlagA:
	ld a, [wCurrentStorySlot] ; $4d10
	add a ; $4d13
	ld_hl_indexed StorySlotFlagAIds_02 ; $4d14
	ld a, [hl+] ; $4d1b
	ld d, [hl] ; $4d1c
	ld e, a ; $4d1d
	farcall TestSaveFlag ; $4d1e
	jr z, .zero ; $4d21
	ld a, $01 ; $4d23
	ret ; $4d25
.zero:
	ld a, $00 ; $4d26
	ret ; $4d28
; The gate on awarding EXP: Unused_02_AddExpToCa00RecordChecked calls it and returns on
; z. It cannot return z -- `xor a` / `dec a` sets the flags from $ff and the
; following `ld a, c` restores the caller's a without touching them -- so the
; gate always passes and the award always happens. Whatever condition it was
; meant to test is not in the ROM.
Unused_02_CheckExpAwardAllowed:
	push bc ; $4d29
	ld c, a ; $4d2a
	xor a ; $4d2b
	dec a ; $4d2c
	ld a, c ; $4d2d
	pop bc ; $4d2e
	ret ; $4d2f
AddExpCapped:
	ld a, [hl] ; $4d30
	add e ; $4d31
	ld [hl+], a ; $4d32
	ld a, [hl] ; $4d33
	adc d ; $4d34
	ld [hl+], a ; $4d35
	ld a, [hl] ; $4d36
	adc $00 ; $4d37
	ld [hl], a ; $4d39
	dec hl ; $4d3a
	dec hl ; $4d3b
	ld de, Value100000_02 ; $4d3c
	call Compare24Bit ; $4d3f
	ret z ; $4d42
	dec hl ; $4d43
	dec hl ; $4d44
	dec de ; $4d45
	dec de ; $4d46
	ld a, [de] ; $4d47
	ld [hl+], a ; $4d48
	inc de ; $4d49
	ld a, [de] ; $4d4a
	ld [hl+], a ; $4d4b
	inc de ; $4d4c
	ld a, [de] ; $4d4d
	ld [hl], a ; $4d4e
	ret ; $4d4f
Value100000_02:
	; $4d50, 4 bytes (bytes:4)
	db $9f, $86, $01, $c9 ; 0x00
Compare24Bit:
	ld a, [de] ; $4d54
	inc de ; $4d55
	sub [hl] ; $4d56
	inc hl ; $4d57
	ld a, [de] ; $4d58
	inc de ; $4d59
	sbc [hl] ; $4d5a
	inc hl ; $4d5b
	ld a, [de] ; $4d5c
	sbc [hl] ; $4d5d
	bit 7, a ; $4d5e
	ret ; $4d60
Unused_02_ClearCa00RecordExp:
	call GetCa00RecordPtr ; $4d61
	ld hl, CHARREC_EXP ; $4d64
	add hl, bc ; $4d67
	xor a ; $4d68
	ld [hl+], a ; $4d69
	ld [hl+], a ; $4d6a
	ld [hl+], a ; $4d6b
	ret ; $4d6c
Unused_02_AddExpToCa00RecordChecked:
	call Unused_02_CheckExpAwardAllowed ; $4d6d
	ret z ; $4d70
Unused_02_AddExpToCa00RecordHooked:
	call Unused_02_StubNop ; $4d71
Unused_02_AddExpToCa00Record:
	call GetCa00RecordPtr ; $4d74
	ld hl, CHARREC_EXP ; $4d77
	add hl, bc ; $4d7a
	jp AddExpCapped ; $4d7b
Unused_02_StubNop:
	ret ; $4d7e
Table_02:
	; $4d7f, 16 bytes (bytes:16)
	db $02, $02, $03, $04, $05, $07, $07, $07, $02, $02, $02, $03, $02, $02, $02, $02 ; 0x00
AddPlayerExp:
	call GetPlayerRecordPtr ; $4d8f
	ld hl, CHARREC_EXP ; $4d92
	add hl, bc ; $4d95
	jp AddExpCapped ; $4d96
HasReachedNextLevelExp:
	call GetPlayerRecordPtr ; $4d99
	ld hl, CHARREC_LEVEL ; $4d9c
	add hl, bc ; $4d9f
	ld a, [hl] ; $4da0
	cp $63 ; $4da1
	jp nc, .ge63 ; $4da3
	ld h, $00 ; $4da6
	ld l, a ; $4da8
	ld d, h ; $4da9
	ld e, l ; $4daa
	add hl, hl ; $4dab
	add hl, de ; $4dac
	push hl ; $4dad
	xor a ; $4dae
	ld hl, CharDataPtr_02 ; $4daf
	add l ; $4db2
	ld l, a ; $4db3
	jr nc, .read ; $4db4
	inc h ; $4db6
.read:
	ld a, [hl+] ; $4db7
	ld h, [hl] ; $4db8
	ld l, a ; $4db9
	pop de ; $4dba
	add hl, de ; $4dbb
	ld a, $2c ; $4dbc
	add c ; $4dbe
	ld e, a ; $4dbf
	ld d, b ; $4dc0
	jp Compare24Bit ; $4dc1
.ge63:
	ld a, $80 ; $4dc4
	or a ; $4dc6
	ret ; $4dc7
GetExpRemainingToNextLevel:
	call GetPlayerRecordPtr ; $4dc8
	ld hl, CHARREC_LEVEL ; $4dcb
	add hl, bc ; $4dce
	ld a, [hl] ; $4dcf
	cp $63 ; $4dd0
	jp nc, .maxLevel ; $4dd2
	ld h, $00 ; $4dd5
	ld l, a ; $4dd7
	ld d, h ; $4dd8
	ld e, l ; $4dd9
	add hl, hl ; $4dda
	add hl, de ; $4ddb
	push hl ; $4ddc
	xor a ; $4ddd
	ld hl, CharDataPtr_02 ; $4dde
	add l ; $4de1
	ld l, a ; $4de2
	jr nc, .readTable ; $4de3
	inc h ; $4de5
.readTable:
	ld a, [hl+] ; $4de6
	ld h, [hl] ; $4de7
	ld l, a ; $4de8
	pop de ; $4de9
	add hl, de ; $4dea
	ld a, [hl+] ; $4deb
	ld h, [hl] ; $4dec
	ld l, a ; $4ded
	push hl ; $4dee
	ld hl, CHARREC_EXP ; $4def
	add hl, bc ; $4df2
	ld a, [hl+] ; $4df3
	ld d, [hl] ; $4df4
	ld e, a ; $4df5
	pop hl ; $4df6
	ld a, l ; $4df7
	sub e ; $4df8
	ld l, a ; $4df9
	ld a, h ; $4dfa
	sbc d ; $4dfb
	ld h, a ; $4dfc
	ret ; $4dfd
.maxLevel:
	ld hl, $0000 ; $4dfe
	ret ; $4e01
GetExpProgressInCurrentLevel:
	call GetPlayerRecordPtr ; $4e02
	ld hl, CHARREC_LEVEL ; $4e05
	add hl, bc ; $4e08
	ld a, [hl] ; $4e09
	cp $63 ; $4e0a
	jr nc, .ge63 ; $4e0c
	dec a ; $4e0e
	ld h, $00 ; $4e0f
	ld l, a ; $4e11
	ld d, h ; $4e12
	ld e, l ; $4e13
	add hl, hl ; $4e14
	add hl, de ; $4e15
	push hl ; $4e16
	xor a ; $4e17
	ld hl, CharDataPtr_02 ; $4e18
	add l ; $4e1b
	ld l, a ; $4e1c
	jr nc, .read ; $4e1d
	inc h ; $4e1f
.read:
	ld a, [hl+] ; $4e20
	ld h, [hl] ; $4e21
	ld l, a ; $4e22
	pop de ; $4e23
	add hl, de ; $4e24
	ld a, [hl+] ; $4e25
	ld d, [hl] ; $4e26
	ld e, a ; $4e27
	ld hl, CHARREC_EXP ; $4e28
	add hl, bc ; $4e2b
	ld a, [hl+] ; $4e2c
	ld h, [hl] ; $4e2d
	ld l, a ; $4e2e
	ld a, l ; $4e2f
	sub e ; $4e30
	ld l, a ; $4e31
	ld a, h ; $4e32
	sbc d ; $4e33
	ld h, a ; $4e34
	ret ; $4e35
.ge63:
	ld hl, $0000 ; $4e36
	ret ; $4e39
GetExpRequiredForLevel:
	push af ; $4e3a
	dec a ; $4e3b
	ld h, $00 ; $4e3c
	ld l, a ; $4e3e
	ld d, h ; $4e3f
	ld e, l ; $4e40
	add hl, hl ; $4e41
	add hl, de ; $4e42
	push hl ; $4e43
	xor a ; $4e44
	ld hl, CharDataPtr_02 ; $4e45
	add l ; $4e48
	ld l, a ; $4e49
	jr nc, .readPrevTable ; $4e4a
	inc h ; $4e4c
.readPrevTable:
	ld a, [hl+] ; $4e4d
	ld h, [hl] ; $4e4e
	ld l, a ; $4e4f
	pop de ; $4e50
	add hl, de ; $4e51
	ld a, [hl+] ; $4e52
	ld d, [hl] ; $4e53
	ld e, a ; $4e54
	pop af ; $4e55
	push de ; $4e56
	ld h, $00 ; $4e57
	ld l, a ; $4e59
	ld d, h ; $4e5a
	ld e, l ; $4e5b
	add hl, hl ; $4e5c
	add hl, de ; $4e5d
	push hl ; $4e5e
	xor a ; $4e5f
	ld hl, CharDataPtr_02 ; $4e60
	add l ; $4e63
	ld l, a ; $4e64
	jr nc, .readTable ; $4e65
	inc h ; $4e67
.readTable:
	ld a, [hl+] ; $4e68
	ld h, [hl] ; $4e69
	ld l, a ; $4e6a
	pop de ; $4e6b
	add hl, de ; $4e6c
	ld a, [hl+] ; $4e6d
	ld h, [hl] ; $4e6e
	ld l, a ; $4e6f
	pop de ; $4e70
	ld a, l ; $4e71
	sub e ; $4e72
	ld l, a ; $4e73
	ld a, h ; $4e74
	sbc d ; $4e75
	ld h, a ; $4e76
	ret ; $4e77
CharDataPtr_02:
	; $4e78, 2 bytes (records:2)
	dw ExpLevelThresholds_02 ; record 0
ExpLevelThresholds_02:
	; $4e7a, 300 bytes (exp_threshold)
	exp_threshold 0 ; level 1
	exp_threshold 15 ; level 2
	exp_threshold 45 ; level 3
	exp_threshold 90 ; level 4
	exp_threshold 144 ; level 5
	exp_threshold 204 ; level 6
	exp_threshold 270 ; level 7
	exp_threshold 341 ; level 8
	exp_threshold 417 ; level 9
	exp_threshold 498 ; level 10
	exp_threshold 585 ; level 11
	exp_threshold 678 ; level 12
	exp_threshold 777 ; level 13
	exp_threshold 882 ; level 14
	exp_threshold 993 ; level 15
	exp_threshold 1111 ; level 16
	exp_threshold 1236 ; level 17
	exp_threshold 1369 ; level 18
	exp_threshold 1510 ; level 19
	exp_threshold 1659 ; level 20
	exp_threshold 1817 ; level 21
	exp_threshold 1984 ; level 22
	exp_threshold 2161 ; level 23
	exp_threshold 2349 ; level 24
	exp_threshold 2548 ; level 25
	exp_threshold 2759 ; level 26
	exp_threshold 2983 ; level 27
	exp_threshold 3220 ; level 28
	exp_threshold 3471 ; level 29
	exp_threshold 3737 ; level 30
	exp_threshold 4019 ; level 31
	exp_threshold 4315 ; level 32
	exp_threshold 4623 ; level 33
	exp_threshold 4943 ; level 34
	exp_threshold 5276 ; level 35
	exp_threshold 5619 ; level 36
	exp_threshold 5969 ; level 37
	exp_threshold 6319 ; level 38
	exp_threshold 6669 ; level 39
	exp_threshold 7019 ; level 40
	exp_threshold 7369 ; level 41
	exp_threshold 7719 ; level 42
	exp_threshold 8069 ; level 43
	exp_threshold 8419 ; level 44
	exp_threshold 8769 ; level 45
	exp_threshold 9119 ; level 46
	exp_threshold 9469 ; level 47
	exp_threshold 9819 ; level 48
	exp_threshold 10169 ; level 49
	exp_threshold 10519 ; level 50
	exp_threshold 10869 ; level 51
	exp_threshold 11219 ; level 52
	exp_threshold 11569 ; level 53
	exp_threshold 11919 ; level 54
	exp_threshold 12269 ; level 55
	exp_threshold 12619 ; level 56
	exp_threshold 12969 ; level 57
	exp_threshold 13319 ; level 58
	exp_threshold 13669 ; level 59
	exp_threshold 14019 ; level 60
	exp_threshold 14369 ; level 61
	exp_threshold 14719 ; level 62
	exp_threshold 15069 ; level 63
	exp_threshold 15419 ; level 64
	exp_threshold 15769 ; level 65
	exp_threshold 16119 ; level 66
	exp_threshold 16469 ; level 67
	exp_threshold 16819 ; level 68
	exp_threshold 17169 ; level 69
	exp_threshold 17519 ; level 70
	exp_threshold 17869 ; level 71
	exp_threshold 18219 ; level 72
	exp_threshold 18569 ; level 73
	exp_threshold 18919 ; level 74
	exp_threshold 19269 ; level 75
	exp_threshold 19619 ; level 76
	exp_threshold 19969 ; level 77
	exp_threshold 20319 ; level 78
	exp_threshold 20669 ; level 79
	exp_threshold 21019 ; level 80
	exp_threshold 21369 ; level 81
	exp_threshold 21719 ; level 82
	exp_threshold 22069 ; level 83
	exp_threshold 22419 ; level 84
	exp_threshold 22769 ; level 85
	exp_threshold 23119 ; level 86
	exp_threshold 23469 ; level 87
	exp_threshold 23819 ; level 88
	exp_threshold 24169 ; level 89
	exp_threshold 24519 ; level 90
	exp_threshold 24869 ; level 91
	exp_threshold 25219 ; level 92
	exp_threshold 25569 ; level 93
	exp_threshold 25919 ; level 94
	exp_threshold 26269 ; level 95
	exp_threshold 26619 ; level 96
	exp_threshold 26969 ; level 97
	exp_threshold 27319 ; level 98
	exp_threshold 27669 ; level 99
	db $ff, $ff, $ff ; end

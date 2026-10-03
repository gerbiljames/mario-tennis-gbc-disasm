SetSpecialShotFlagFromBallHeight:
	ld hl, wBallHeight ; $5a01
	ld a, [hl+] ; $5a04
	ld h, [hl] ; $5a05
	ld l, a ; $5a06
	xor a ; $5a07
	sub l ; $5a08
	ld l, a ; $5a09
	sbc a ; $5a0a
	sub h ; $5a0b
	ld h, a ; $5a0c
	add hl, hl ; $5a0d
	add hl, hl ; $5a0e
	add hl, hl ; $5a0f
	add hl, hl ; $5a10
	ld a, h ; $5a11
	and $1f ; $5a12
	ld_hl_indexed SpecialShotFlagTable_07 ; $5a14
	ld a, [hl] ; $5a1b
	ld [wSpecialShotFlag], a ; $5a1c
	ld [wLastShotWasPowerShot], a ; $5a1f
	ret ; $5a22
SpecialShotFlagTable_07:
	; $5a23, 32 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 0x10
LookupCharSpriteSet:
	push hl ; $5a43
	and $3f ; $5a44
	ld_hl_indexed CharSpriteSetTable ; $5a46
	ld a, [hl] ; $5a4d
	pop hl ; $5a4e
	ret ; $5a4f
CharSpriteSetTable:
	; $5a50, 32 bytes (bytes:1, one per character id)
	db $00 ; $00 Alex
	db $01 ; $01 Nina
	db $03 ; $02 Harry
	db $02 ; $03 Kate
	db $0c ; $04 Allie
	db $16 ; $05 Joy
	db $0d ; $06 Brian
	db $17 ; $07 Pam
	db $0f ; $08 Bob
	db $18 ; $09 Beth
	db $19 ; $0a Fay
	db $0e ; $0b Curt
	db $05 ; $0c Mark
	db $07 ; $0d Sean
	db $06 ; $0e Sammi
	db $09 ; $0f Elden
	db $08 ; $10 Spike
	db $04 ; $11 Emily
	db $0b ; $12 B. Coz
	db $0a ; $13 A. Coz
	db $0a ; $14 Kevin
	db $1a ; $15 Not used
	db $0c ; $16 Not used
	db $1b ; $17 Luigi
	db $1c ; $18 DK
	db $1d ; $19 Baby M.
	db $10 ; $1a Mario
	db $11 ; $1b Waluigi
	db $12 ; $1c Yoshi
	db $13 ; $1d Bowser
	db $15 ; $1e Wario
	db $14 ; $1f Peach
SetupCharacterSprite:
	push de ; $5a70
	farcall SetupCharSpriteFromObjectDef ; $5a71
	pop de ; $5a74
	ld a, e ; $5a75
	ld [wCharGfxBank], a ; $5a76
	ld a, [wCharIndex] ; $5a79
	add $04 ; $5a7c
	ld [wCharSpriteAttr], a ; $5a7e
	ld a, [wCharIndex] ; $5a81
	ld_hl_indexed SetupCharacterSprite_CharTileBaseTable ; $5a84
	ld a, [hl] ; $5a8b
	ld [wCharTileBase], a ; $5a8c
	ld a, [wCharIndex] ; $5a8f
	add a ; $5a92
	ld_hl_indexed CharFrameGfxDest_07 ; $5a93
	ld a, [hl+] ; $5a9a
	ld d, [hl] ; $5a9b
	ld e, a ; $5a9c
	ld hl, wCharFrameVramDest ; $5a9d
	ld a, e ; $5aa0
	ld [hl+], a ; $5aa1
	ld [hl], d ; $5aa2
	farcall ReloadCharFrameGfx ; $5aa3
	ret ; $5aa6
CharFrameGfxDest_07:
	; $5aa7, 8 bytes (records:2)
	dw $a000 ; record 0
	dw $a100 ; record 1
	dw $a200 ; record 2
	dw $a300 ; record 3
SetupCharacterSprite_CharTileBaseTable:
	INCBIN "data/bank_007/SetupCharacterSprite_CharTileBaseTable.bin" ; $5aaf, 4 bytes
; Copies one character's attribute record into the per-character struct: the
; reach box CheckCharBallContact tests against, the jump-smash and dive speeds,
; and the six AI parameters at record +$0f and +$1b-$1f -- home-position
; strategy, the two reaction delays, ball tracking, aim-away chance and serve
; style. OverrideCharStatsForDebug rewrites the same six.
LoadCharacterAttributes:
	ld a, [wCharIndex] ; $5ab3
	add a ; $5ab6
	ld_hl_indexed CharAttrStructPtrs_07 ; $5ab7
	ld a, [hl+] ; $5abe
	ld d, [hl] ; $5abf
	ld e, a ; $5ac0
	ld hl, CHARREC_REACH ; $5ac1
	add hl, de ; $5ac4
	ld a, [hl+] ; $5ac5
	ld b, [hl] ; $5ac6
	ld c, a ; $5ac7
	ld hl, $fff0 ; $5ac8
	add hl, bc ; $5acb
	ld c, l ; $5acc
	ld b, h ; $5acd
	ld hl, wCharReachHeight ; $5ace
	ld a, c ; $5ad1
	ld [hl+], a ; $5ad2
	ld [hl], b ; $5ad3
	ld hl, CHARREC_REACH + 2 ; $5ad4
	add hl, de ; $5ad7
	ld a, [hl+] ; $5ad8
	ld b, [hl] ; $5ad9
	ld c, a ; $5ada
	ld hl, wCharReachX ; $5adb
	ld a, c ; $5ade
	ld [hl+], a ; $5adf
	ld [hl], b ; $5ae0
	ld hl, CHARREC_REACH + 4 ; $5ae1
	add hl, de ; $5ae4
	ld a, [hl+] ; $5ae5
	ld b, [hl] ; $5ae6
	ld c, a ; $5ae7
	ld hl, $0200 ; $5ae8
	add hl, bc ; $5aeb
	ld c, l ; $5aec
	ld b, h ; $5aed
	ld hl, wCharSmashJumpSpeed ; $5aee
	ld a, c ; $5af1
	ld [hl+], a ; $5af2
	ld [hl], b ; $5af3
	ld hl, CHARREC_REACH + 6 ; $5af4
	add hl, de ; $5af7
	ld a, [hl+] ; $5af8
	ld b, [hl] ; $5af9
	ld c, a ; $5afa
	ld hl, wCharDiveSpeed ; $5afb
	ld a, c ; $5afe
	ld [hl+], a ; $5aff
	ld [hl], b ; $5b00
	ld hl, CHARREC_SWING ; $5b01
	add hl, de ; $5b04
	ld a, [hl+] ; $5b05
	ld b, [hl] ; $5b06
	ld c, a ; $5b07
	ld hl, wCharSwingAttrWord ; $5b08
	ld a, c ; $5b0b
	ld [hl+], a ; $5b0c
	ld [hl], b ; $5b0d
	ld hl, CHARREC_LEVEL ; $5b0e
	add hl, de ; $5b11
	ld a, [hl] ; $5b12
	ld [wCharExpTier], a ; $5b13
	ld b, $00 ; $5b16
	ld hl, CHARREC_LEFT_HANDED ; $5b18
	add hl, de ; $5b1b
	ld a, [hl] ; $5b1c
	and a ; $5b1d
	jr z, .storeHandedness ; $5b1e
	ld b, $20 ; $5b20
.storeHandedness:
	ld a, b ; $5b22
	ld [wCharMirrorAttrMask], a ; $5b23
	ld hl, CHARREC_STAT_SPEED ; $5b26
	add hl, de ; $5b29
	ld a, [hl] ; $5b2a
	add a ; $5b2b
	ld_hl_indexed CharStatTable_07_0 ; $5b2c
	ld a, [hl+] ; $5b33
	ld b, [hl] ; $5b34
	ld c, a ; $5b35
	ld hl, wCharMaxSpeedX ; $5b36
	ld a, c ; $5b39
	ld [hl+], a ; $5b3a
	ld [hl], b ; $5b3b
	ld hl, CHARREC_STAT_SPEED ; $5b3c
	add hl, de ; $5b3f
	ld a, [hl] ; $5b40
	ld hl, CHARREC_SPEED_BONUS ; $5b41
	add hl, de ; $5b44
	add [hl] ; $5b45
	add a ; $5b46
	jr nc, .clampSpin ; $5b47
	xor a ; $5b49
	jr .readPlacementTable ; $5b4a
.clampSpin:
	rra ; $5b4c
	cp $0a ; $5b4d
	jr c, .readPlacementTable ; $5b4f
	ld a, $0a ; $5b51
	dec a ; $5b53
.readPlacementTable:
	add a ; $5b54
	ld_hl_indexed CharStatTable_07_0 ; $5b55
	ld a, [hl+] ; $5b5c
	ld b, [hl] ; $5b5d
	ld c, a ; $5b5e
	ld hl, wCharMaxSpeedDepth ; $5b5f
	ld a, c ; $5b62
	ld [hl+], a ; $5b63
	ld [hl], b ; $5b64
	ld hl, CHARREC_STAT_DASH ; $5b65
	add hl, de ; $5b68
	ld a, [hl] ; $5b69
	add a ; $5b6a
	ld_hl_indexed CharStatTable_07_1 ; $5b6b
	ld a, [hl+] ; $5b72
	ld b, [hl] ; $5b73
	ld c, a ; $5b74
	ld hl, wCharAcceleration ; $5b75
	ld a, c ; $5b78
	ld [hl+], a ; $5b79
	ld [hl], b ; $5b7a
	ld hl, CHARREC_STAT_STOP ; $5b7b
	add hl, de ; $5b7e
	ld a, [hl] ; $5b7f
	add a ; $5b80
	ld_hl_indexed CharStatTable_07_2 ; $5b81
	ld a, [hl+] ; $5b88
	ld b, [hl] ; $5b89
	ld c, a ; $5b8a
	ld hl, wCharDeceleration ; $5b8b
	ld a, c ; $5b8e
	ld [hl+], a ; $5b8f
	ld [hl], b ; $5b90
	ld hl, CHARREC_STAT_REACTION ; $5b91
	add hl, de ; $5b94
	ld a, [hl] ; $5b95
	ld_hl_indexed CharStatTable_07_3 ; $5b96
	ld a, [hl] ; $5b9d
	ld [wCharFacingEaseRate], a ; $5b9e
	ld hl, CHARREC_STAT_ANGLE ; $5ba1
	add hl, de ; $5ba4
	ld a, [hl] ; $5ba5
	ld_hl_indexed CharStatTable_07_4 ; $5ba6
	ld a, [hl] ; $5bad
	ld [wCharAimOffsetScale], a ; $5bae
	ld hl, CHARREC_STAT_PLACEMENT ; $5bb1
	add hl, de ; $5bb4
	ld a, [hl] ; $5bb5
	ld_hl_indexed CharStatTable_07_5 ; $5bb6
	ld a, [hl] ; $5bbd
	ld [wCharAimJitterScale], a ; $5bbe
	ld hl, CHARREC_STAT_STROKE ; $5bc1
	add hl, de ; $5bc4
	ld a, [hl] ; $5bc5
	ld [wGroundStrokeSpeedIndex], a ; $5bc6
	ld hl, CHARREC_STAT_SERVE ; $5bc9
	add hl, de ; $5bcc
	ld a, [hl] ; $5bcd
	ld [wSmashServeSpeedIndex], a ; $5bce
	ld hl, CHARREC_STAT_VOLLEY ; $5bd1
	add hl, de ; $5bd4
	ld a, [hl] ; $5bd5
	ld [wReachSpeedIndex], a ; $5bd6
	ld hl, CHARREC_STAT_SLICE ; $5bd9
	add hl, de ; $5bdc
	ld a, [hl] ; $5bdd
	ld [wSlicePlacementIndex], a ; $5bde
	ld hl, CHARREC_STAT_TOP ; $5be1
	add hl, de ; $5be4
	ld a, [hl] ; $5be5
	ld [wTopspinPlacementIndex], a ; $5be6
	ld hl, CHARREC_PHYSICS ; $5be9
	add hl, de ; $5bec
	ld a, [hl] ; $5bed
	ld [wAiPositionStrategy], a ; $5bee
	ld hl, CHARREC_AI_PARAMS ; $5bf1
	add hl, de ; $5bf4
	ld a, [hl] ; $5bf5
	ld [wAiReactionDelayNear], a ; $5bf6
	ld hl, CHARREC_AI_PARAMS + 1 ; $5bf9
	add hl, de ; $5bfc
	ld a, [hl] ; $5bfd
	ld [wAiReactionDelayFar], a ; $5bfe
	ld hl, CHARREC_AI_PARAMS + 2 ; $5c01
	add hl, de ; $5c04
	ld a, [hl] ; $5c05
	ld [wAiTrackingParam], a ; $5c06
	ld hl, CHARREC_AI_PARAMS + 3 ; $5c09
	add hl, de ; $5c0c
	ld a, [hl] ; $5c0d
	ld [wAiAimAwayChance], a ; $5c0e
	ld hl, CHARREC_AI_PARAMS + 4 ; $5c11
	add hl, de ; $5c14
	ld a, [hl] ; $5c15
	ld [wAiServeStyle], a ; $5c16
	ld a, $00 ; $5c19
	ld hl, wCharSwingAttrWord + 1 ; $5c1b
	bit 0, [hl] ; $5c1e
	jr z, .storeLobIndex ; $5c20
	ld a, $01 ; $5c22
.storeLobIndex:
	ld [wLobPlacementIndex], a ; $5c24
	ld a, $00 ; $5c27
	ld hl, wCharSwingAttrWord + 1 ; $5c29
	bit 1, [hl] ; $5c2c
	jr z, .storeDropIndex ; $5c2e
	ld a, $01 ; $5c30
.storeDropIndex:
	ld [wDropPlacementIndex], a ; $5c32
	ld a, [wDebugMatchFlags] ; $5c35
	bit 1, a ; $5c38
	ret z ; $5c3a
	ld a, [wCharIndex] ; $5c3b
	call OverrideCharStatsForDebug ; $5c3e
	ret ; $5c41
CharAttrStructPtrs_07:
	; $5c42, 8 bytes (ram_ptrs:0)
	dw wPlayer1MainName ; record 0
	dw wPlayer2MainName ; record 1
	dw wPlayer1PartnerName ; record 2
	dw wPlayer2PartnerName ; record 3
CharStatTable_07_0:
	; $5c4a, 20 bytes (records:2)
	dw $0a00 ; record 0
	dw $0a80 ; record 1
	dw $0b00 ; record 2
	dw $0b80 ; record 3
	dw $0c00 ; record 4
	dw $0c80 ; record 5
	dw $0d00 ; record 6
	dw $0d80 ; record 7
	dw $0e00 ; record 8
	dw $0e80 ; record 9
CharStatTable_07_1:
	; $5c5e, 20 bytes (records:2)
	dw $0030 ; record 0
	dw $003c ; record 1
	dw $0048 ; record 2
	dw $0054 ; record 3
	dw $0060 ; record 4
	dw $006c ; record 5
	dw $0078 ; record 6
	dw $0084 ; record 7
	dw $0090 ; record 8
	dw $009c ; record 9
CharStatTable_07_2:
	; $5c72, 20 bytes (records:2)
	dw $0040 ; record 0
	dw $0060 ; record 1
	dw $0080 ; record 2
	dw $00a0 ; record 3
	dw $00c0 ; record 4
	dw $00e0 ; record 5
	dw $0100 ; record 6
	dw $0120 ; record 7
	dw $0140 ; record 8
	dw $0160 ; record 9
CharStatTable_07_3:
	; $5c86, 10 bytes (bytes:10)
	db $06, $07, $08, $09, $0a, $0b, $0c, $0e, $10, $18 ; 0x00
CharStatTable_07_4:
	; $5c90, 10 bytes (bytes:10)
	db $75, $84, $93, $a3, $b2, $c1, $d1, $e0, $ef, $ff ; 0x00
CharStatTable_07_5:
	; $5c9a, 10 bytes (bytes:10)
	db $0c, $0b, $0a, $09, $08, $07, $06, $05, $04, $03 ; 0x00
CharStatPresets_07:
	; $5ca4, 80 bytes (bytes:16)
	db $01, $01, $01, $01, $01, $05, $09, $09, $09, $09, $09, $09, $00, $00, $00, $00 ; 0x00
	db $09, $09, $00, $00, $09, $05, $00, $09, $09, $00, $04, $09, $00, $00, $00, $00 ; 0x10
	db $07, $07, $07, $04, $04, $04, $00, $00, $01, $00, $04, $04, $00, $00, $00, $00 ; 0x20
	db $05, $05, $09, $04, $09, $05, $05, $00, $02, $00, $04, $09, $00, $00, $00, $00 ; 0x30
	db $05, $00, $07, $04, $04, $04, $00, $00, $03, $00, $04, $04, $00, $00, $00, $00 ; 0x40
OverrideCharStatsForDebug:
	push af ; $5cf4
	ld a, $04 ; $5cf5
	ld [wAiReactionDelayNear], a ; $5cf7
	ld a, $04 ; $5cfa
	ld [wAiReactionDelayFar], a ; $5cfc
	ld a, $00 ; $5cff
	ld [wAiTrackingParam], a ; $5d01
	ld a, $ff ; $5d04
	ld [wAiAimAwayChance], a ; $5d06
	ld a, $02 ; $5d09
	ld [wAiServeStyle], a ; $5d0b
	ld a, $00 ; $5d0e
	ld [wCharAimJitterScale], a ; $5d10
	ld a, $01 ; $5d13
	ld [wAiPositionStrategy], a ; $5d15
	ld a, $01 ; $5d18
	ld a, $01 ; $5d1a
	pop af ; $5d1c
	ret ; $5d1d
Unused_07_ApplyCharStatPreset:
	add a ; $5d1e
	add a ; $5d1f
	add a ; $5d20
	add a ; $5d21
	ld_hl_indexed CharStatPresets_07 ; $5d22
	ld a, [hl+] ; $5d29
	push hl ; $5d2a
	add a ; $5d2b
	ld_hl_indexed CharStatTable_07_0 ; $5d2c
	ld a, [hl+] ; $5d33
	ld d, [hl] ; $5d34
	ld e, a ; $5d35
	ld hl, $0060 ; $5d36
	add hl, bc ; $5d39
	ld a, e ; $5d3a
	ld [hl+], a ; $5d3b
	ld [hl], d ; $5d3c
	pop hl ; $5d3d
	ld a, [hl+] ; $5d3e
	push hl ; $5d3f
	add a ; $5d40
	ld_hl_indexed CharStatTable_07_0 ; $5d41
	ld a, [hl+] ; $5d48
	ld d, [hl] ; $5d49
	ld e, a ; $5d4a
	ld hl, $0062 ; $5d4b
	add hl, bc ; $5d4e
	ld a, e ; $5d4f
	ld [hl+], a ; $5d50
	ld [hl], d ; $5d51
	pop hl ; $5d52
	ld a, [hl+] ; $5d53
	push hl ; $5d54
	add a ; $5d55
	ld_hl_indexed CharStatTable_07_1 ; $5d56
	ld a, [hl+] ; $5d5d
	ld d, [hl] ; $5d5e
	ld e, a ; $5d5f
	ld hl, $0064 ; $5d60
	add hl, bc ; $5d63
	ld a, e ; $5d64
	ld [hl+], a ; $5d65
	ld [hl], d ; $5d66
	pop hl ; $5d67
	ld a, [hl+] ; $5d68
	push hl ; $5d69
	add a ; $5d6a
	ld_hl_indexed CharStatTable_07_2 ; $5d6b
	ld a, [hl+] ; $5d72
	ld d, [hl] ; $5d73
	ld e, a ; $5d74
	ld hl, $0066 ; $5d75
	add hl, bc ; $5d78
	ld a, e ; $5d79
	ld [hl+], a ; $5d7a
	ld [hl], d ; $5d7b
	pop hl ; $5d7c
	ld a, [hl+] ; $5d7d
	push hl ; $5d7e
	ld_hl_indexed CharStatTable_07_3 ; $5d7f
	ld a, [hl] ; $5d86
	ld hl, $0068 ; $5d87
	add hl, bc ; $5d8a
	ld [hl], a ; $5d8b
	pop hl ; $5d8c
	ld a, [hl+] ; $5d8d
	push hl ; $5d8e
	ld_hl_indexed CharStatTable_07_4 ; $5d8f
	ld a, [hl] ; $5d96
	ld hl, $0069 ; $5d97
	add hl, bc ; $5d9a
	ld [hl], a ; $5d9b
	pop hl ; $5d9c
	ld a, [hl+] ; $5d9d
	push hl ; $5d9e
	ld_hl_indexed CharStatTable_07_5 ; $5d9f
	ld a, [hl] ; $5da6
	ld hl, $006a ; $5da7
	add hl, bc ; $5daa
	ld [hl], a ; $5dab
	pop hl ; $5dac
	ld a, $6b ; $5dad
	add c ; $5daf
	ld e, a ; $5db0
	ld d, b ; $5db1
	ld a, [hl+] ; $5db2
	ld [de], a ; $5db3
	ld a, $6c ; $5db4
	add c ; $5db6
	ld e, a ; $5db7
	ld d, b ; $5db8
	ld a, [hl+] ; $5db9
	ld [de], a ; $5dba
	ld a, $6d ; $5dbb
	add c ; $5dbd
	ld e, a ; $5dbe
	ld d, b ; $5dbf
	ld a, [hl+] ; $5dc0
	ld [de], a ; $5dc1
	ld a, $6e ; $5dc2
	add c ; $5dc4
	ld e, a ; $5dc5
	ld d, b ; $5dc6
	ld a, [hl+] ; $5dc7
	ld [de], a ; $5dc8
	ld a, $6f ; $5dc9
	add c ; $5dcb
	ld e, a ; $5dcc
	ld d, b ; $5dcd
	ld a, [hl+] ; $5dce
	ld [de], a ; $5dcf
	ld hl, $0070 ; $5dd0
	add hl, bc ; $5dd3
	ld de, $0080 ; $5dd4
	ld a, e ; $5dd7
	ld [hl+], a ; $5dd8
	ld [hl], d ; $5dd9
	ld hl, $0072 ; $5dda
	add hl, bc ; $5ddd
	ld de, $00a0 ; $5dde
	ld a, e ; $5de1
	ld [hl+], a ; $5de2
	ld [hl], d ; $5de3
	ld hl, $0074 ; $5de4
	add hl, bc ; $5de7
	ld de, $0800 ; $5de8
	ld a, e ; $5deb
	ld [hl+], a ; $5dec
	ld [hl], d ; $5ded
	ld hl, $0076 ; $5dee
	add hl, bc ; $5df1
	ld de, $000c ; $5df2
	ld a, e ; $5df5
	ld [hl+], a ; $5df6
	ld [hl], d ; $5df7
	ret ; $5df8

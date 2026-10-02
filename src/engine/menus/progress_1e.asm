FillProgressListRowTiles:
	ld hl, wShadowTilemapPtr ; $79e8
	ld a, [hl+] ; $79eb
	ld h, [hl] ; $79ec
	ld l, a ; $79ed
	ld e, $09 ; $79ee
.loop:
	ld a, $2e ; $79f0
	ld b, $2f ; $79f2
	ld c, $0a ; $79f4
.loopB:
	ld [hl+], a ; $79f6
	ld [hl], b ; $79f7
	inc hl ; $79f8
	dec c ; $79f9
	jr nz, .loopB ; $79fa
	ld bc, $000c ; $79fc
	add hl, bc ; $79ff
	ld a, $3e ; $7a00
	ld b, $3f ; $7a02
	ld c, $0a ; $7a04
.loop2:
	ld [hl+], a ; $7a06
	ld [hl], b ; $7a07
	inc hl ; $7a08
	dec c ; $7a09
	jr nz, .loop2 ; $7a0a
	ld bc, $000c ; $7a0c
	add hl, bc ; $7a0f
	dec e ; $7a10
	jr nz, .loop ; $7a11
	ret ; $7a13
FillProgressListRowAttrs:
	ld hl, wShadowTilemapPtr ; $7a14
	ld a, [hl+] ; $7a17
	ld h, [hl] ; $7a18
	ld l, a ; $7a19
	ld de, $0400 ; $7a1a
	add hl, de ; $7a1d
	ld a, $09 ; $7a1e
	ld e, $12 ; $7a20
.loop:
	ld c, $14 ; $7a22
.loopB:
	ld [hl+], a ; $7a24
	dec c ; $7a25
	jr nz, .loopB ; $7a26
	ld bc, $000c ; $7a28
	add hl, bc ; $7a2b
	dec e ; $7a2c
	jr nz, .loop ; $7a2d
	ret ; $7a2f
UnusedCopyProgressListTilemap:
	ld hl, $d060 ; $7a30
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH ; $7a33
	ld c, $1e ; $7a36
	call QueueVRAMCopy ; $7a38
	ret ; $7a3b
DrawProgressEntryDefaultIcon:
	push af ; $7a3c
	push bc ; $7a3d
	push de ; $7a3e
	push hl ; $7a3f
	ld a, b ; $7a40
	add a ; $7a41
	add $05 ; $7a42
	add a ; $7a44
	add a ; $7a45
	add a ; $7a46
	ld hl, hScrollY ; $7a47
	sub [hl] ; $7a4a
	add $03 ; $7a4b
	ld e, a ; $7a4d
	ld d, $8c ; $7a4e
	ldh a, [hVBlankCounter] ; $7a50
	rrca ; $7a52
	rrca ; $7a53
	rrca ; $7a54
	and $03 ; $7a55
	ld a, $03 ; $7a57
	add a ; $7a59
	add a ; $7a5a
	add $00 ; $7a5b
	ld c, a ; $7a5d
	ld b, OAM_BANK1 | 2 ; $7a5e
	call QueueSprite16 ; $7a60
	pop hl ; $7a63
	pop de ; $7a64
	pop bc ; $7a65
	pop af ; $7a66
	ret ; $7a67
DrawProgressEntryTrophyIcon:
	push af ; $7a68
	push bc ; $7a69
	push de ; $7a6a
	push hl ; $7a6b
	ld a, b ; $7a6c
	add a ; $7a6d
	add $05 ; $7a6e
	add a ; $7a70
	add a ; $7a71
	add a ; $7a72
	ld hl, hScrollY ; $7a73
	sub [hl] ; $7a76
	add $03 ; $7a77
	ld e, a ; $7a79
	ld d, $8c ; $7a7a
	ld a, c ; $7a7c
	add a ; $7a7d
	add a ; $7a7e
	ld c, $20 ; $7a7f
	add c ; $7a81
	ld c, a ; $7a82
	ld b, OAM_BANK1 | 2 ; $7a83
	call QueueSprite16 ; $7a85
	pop hl ; $7a88
	pop de ; $7a89
	pop bc ; $7a8a
	pop af ; $7a8b
	ret ; $7a8c
DrawProgressScreenSprites:
	xor a ; $7a8d
	ld [wCharPosHeight + 1], a ; $7a8e
	ld [wCharPosHeight + 2], a ; $7a91
	ld a, [wProgressVisibleCount] ; $7a94
	sub $07 ; $7a97
	ld b, a ; $7a99
	ld a, [wProgressListIndex] ; $7a9a
	or a ; $7a9d
	jr z, .compare ; $7a9e
	ld [wCharPosHeight + 1], a ; $7aa0
.compare:
	cp b ; $7aa3
	jr nc, .nonZero ; $7aa4
	ld a, $01 ; $7aa6
	ld [wCharPosHeight + 2], a ; $7aa8
.nonZero:
	ld a, [wCharPosHeight + 1] ; $7aab
	or a ; $7aae
	jr z, .zero ; $7aaf
	ld d, $0a ; $7ab1
	ld e, $18 ; $7ab3
	ld c, $00 ; $7ab5
	farcall ApplySpriteBobOffsetY ; $7ab7
	ld c, $20 ; $7aba
	ld b, $00 ; $7abc
	ld h, $02 ; $7abe
	farcall QueueStackedSpritePair ; $7ac0
.zero:
	ld a, [wCharPosHeight + 2] ; $7ac3
	or a ; $7ac6
	jr z, .zero2 ; $7ac7
	ld d, $0a ; $7ac9
	ld e, $86 ; $7acb
	ld c, $01 ; $7acd
	farcall ApplySpriteBobOffsetY ; $7acf
	ld c, $20 ; $7ad2
	ld b, $00 ; $7ad4
	ld h, $03 ; $7ad6
	farcall QueueStackedSpritePair ; $7ad8
.zero2:
	ld hl, wProgressVisibleEntries ; $7adb
	ld a, [wProgressListIndex] ; $7ade
	add l ; $7ae1
	ld l, a ; $7ae2
	jr nc, .gotPtr ; $7ae3
	inc h ; $7ae5
.gotPtr:
	ld c, $07 ; $7ae6
	ld b, $00 ; $7ae8
.loop:
	ld a, [hl+] ; $7aea
	cp $ff ; $7aeb
	jr z, .next ; $7aed
	ld d, a ; $7aef
	call GetProgressEntryEarned ; $7af0
	or a ; $7af3
	jr z, .next ; $7af4
	ld a, d ; $7af6
	cp $00 ; $7af7
	jr z, .drawProgressEntryTrophyIcon ; $7af9
	cp $0b ; $7afb
	jr nc, .drawProgressEntryDefaultIcon ; $7afd
	dec a ; $7aff
	srl a ; $7b00
	or a ; $7b02
	jr z, .drawProgressEntryTrophyIcon ; $7b03
	cp $01 ; $7b05
	jr z, .eq01 ; $7b07
	cp $02 ; $7b09
	jr z, .eq02 ; $7b0b
	cp $03 ; $7b0d
	jr z, .eq03 ; $7b0f
	cp $04 ; $7b11
	jr z, .eq04 ; $7b13
.drawProgressEntryDefaultIcon:
	call DrawProgressEntryDefaultIcon ; $7b15
	jr .next ; $7b18
.drawProgressEntryTrophyIcon:
	push bc ; $7b1a
	ld c, $00 ; $7b1b
	call DrawProgressEntryTrophyIcon ; $7b1d
	pop bc ; $7b20
	jr .next ; $7b21
.eq01:
	push bc ; $7b23
	ld c, $01 ; $7b24
	call DrawProgressEntryTrophyIcon ; $7b26
	pop bc ; $7b29
	jr .next ; $7b2a
.eq02:
	push bc ; $7b2c
	ld c, $02 ; $7b2d
	call DrawProgressEntryTrophyIcon ; $7b2f
	pop bc ; $7b32
	jr .next ; $7b33
.eq03:
	push bc ; $7b35
	ld c, $03 ; $7b36
	call DrawProgressEntryTrophyIcon ; $7b38
	pop bc ; $7b3b
	jr .next ; $7b3c
.eq04:
	push bc ; $7b3e
	ld c, $04 ; $7b3f
	call DrawProgressEntryTrophyIcon ; $7b41
	pop bc ; $7b44
	jr .next ; $7b45
.next:
	inc b ; $7b47
	dec c ; $7b48
	jr nz, .loop ; $7b49
	ret ; $7b4b
LoadProgressScreenIconTiles:
	ld de, vTiles0 + $20 * TILE_SIZE ; $7b4c
	farcall LoadMenuArrowSpriteTiles ; $7b4f
	ld b, $08 ; $7b52
	ld c, $0f ; $7b54
	farcall LoadIndexedPalette ; $7b56
	ret ; $7b59
	; $7b5a, 1190 bytes fill to bank end (linker-padded)

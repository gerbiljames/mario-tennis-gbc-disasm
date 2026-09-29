Unused_03_InvalidateStorySlot:
	push hl ; $4aff
	push de ; $4b00
	push bc ; $4b01
	ld a, b ; $4b02
	cp $03 ; $4b03
	jr nc, .ge03 ; $4b05
	sla a ; $4b07
	ld b, a ; $4b09
	call InvalidateSaveBlock ; $4b0a
	or a ; $4b0d
	jr nz, .restore ; $4b0e
	inc b ; $4b10
	call InvalidateSaveBlock ; $4b11
	jr .restore ; $4b14
.ge03:
	ld a, $ff ; $4b16
.restore:
	pop bc ; $4b18
	pop de ; $4b19
	pop hl ; $4b1a
	ret ; $4b1b
InvalidateSaveBlock:
	push hl ; $4b1c
	push de ; $4b1d
	push bc ; $4b1e
	ld a, $0a ; $4b1f
	ld [rRAMG], a ; $4b21
	ld a, $00 ; $4b24
	ldh [hSramBank], a ; $4b26
	ld [rRAMB], a ; $4b28
	call InitSaveHeader ; $4b2b
	ld a, b ; $4b2e
	call GetSaveBlockDirEntry ; $4b2f
	xor a ; $4b32
	ld [bc], a ; $4b33
	ld de, $0000 ; $4b34
	ld hl, $0006 ; $4b37
	add hl, bc ; $4b3a
	ld [hl], e ; $4b3b
	inc hl ; $4b3c
	ld [hl], d ; $4b3d
	inc hl ; $4b3e
	ld c, $08 ; $4b3f
	xor a ; $4b41
.clearLoop:
	ld [hl+], a ; $4b42
	dec c ; $4b43
	jr nz, .clearLoop ; $4b44
	call MirrorSaveHeaderToBank1 ; $4b46
	xor a ; $4b49
	push af ; $4b4a
	xor a ; $4b4b
	ld [rRAMG], a ; $4b4c
	pop af ; $4b4f
	pop bc ; $4b50
	pop de ; $4b51
	pop hl ; $4b52
	ret ; $4b53
Unused_03_ResetAllSaveBlocks:
	ld a, $00 ; $4b54
	ld [wCurrentStorySlot], a ; $4b56
	ld a, $00 ; $4b59
	call EraseStorySlotSaveData ; $4b5b
	ld a, $01 ; $4b5e
	ld [wCurrentStorySlot], a ; $4b60
	ld a, $00 ; $4b63
	call EraseStorySlotSaveData ; $4b65
	ld a, $02 ; $4b68
	ld [wCurrentStorySlot], a ; $4b6a
	ld a, $00 ; $4b6d
	call EraseStorySlotSaveData ; $4b6f
	ld a, $00 ; $4b72
	ld [wCurrentStorySlot], a ; $4b74
	ld b, $36 ; $4b77
	call InvalidateSaveBlock ; $4b79
	ld b, $37 ; $4b7c
	call InvalidateSaveBlock ; $4b7e
	ld a, $0a ; $4b81
	ld [rRAMG], a ; $4b83
	ld a, $00 ; $4b86
	ldh [hSramBank], a ; $4b88
	ld [rRAMB], a ; $4b8a
	call Unused_03_ClearSaveFlagsArea ; $4b8d
	call InitSaveHeader ; $4b90
	call MirrorSaveHeaderToBank1 ; $4b93
	xor a ; $4b96
	ld [rRAMG], a ; $4b97
	ret ; $4b9a
ReadSaveBlock:
	push hl ; $4b9b
	push de ; $4b9c
	push bc ; $4b9d
	ld a, $0a ; $4b9e
	ld [rRAMG], a ; $4ba0
	ld a, $00 ; $4ba3
	ldh [hSramBank], a ; $4ba5
	ld [rRAMB], a ; $4ba7
	ld a, b ; $4baa
	call GetSaveBlockDirEntry ; $4bab
	ld a, [bc] ; $4bae
	or a ; $4baf
	jp nz, .present ; $4bb0
	ld a, $fe ; $4bb3
	jp .done ; $4bb5
.present:
	push bc ; $4bb8
	push hl ; $4bb9
	ld hl, $0001 ; $4bba
	add hl, bc ; $4bbd
	ld c, [hl] ; $4bbe
	push bc ; $4bbf
	inc hl ; $4bc0
	ld a, [hl+] ; $4bc1
	ld e, a ; $4bc2
	ld a, [hl+] ; $4bc3
	ld d, a ; $4bc4
	ld a, [hl+] ; $4bc5
	ld b, [hl] ; $4bc6
	ld c, a ; $4bc7
	ld hl, $a000 ; $4bc8
	add hl, de ; $4bcb
	ld d, h ; $4bcc
	ld e, l ; $4bcd
	pop hl ; $4bce
	ld a, l ; $4bcf
	ldh [hSramBank], a ; $4bd0
	ld [rRAMB], a ; $4bd2
	pop hl ; $4bd5
	push hl ; $4bd6
	push bc ; $4bd7
.copyLoop:
	ld a, [de] ; $4bd8
	ld [hl+], a ; $4bd9
	inc de ; $4bda
	dec bc ; $4bdb
	ld a, b ; $4bdc
	or c ; $4bdd
	jr nz, .copyLoop ; $4bde
	pop bc ; $4be0
	pop hl ; $4be1
	ld de, $0000 ; $4be2
.checksumLoop:
	ld a, [hl+] ; $4be5
	add e ; $4be6
	ld e, a ; $4be7
	ld a, d ; $4be8
	adc $00 ; $4be9
	ld d, a ; $4beb
	dec bc ; $4bec
	ld a, b ; $4bed
	or c ; $4bee
	jr nz, .checksumLoop ; $4bef
	ld a, $00 ; $4bf1
	ldh [hSramBank], a ; $4bf3
	ld [rRAMB], a ; $4bf5
	pop bc ; $4bf8
	ld hl, $0006 ; $4bf9
	add hl, bc ; $4bfc
	ld a, [hl+] ; $4bfd
	ld h, [hl] ; $4bfe
	ld l, a ; $4bff
	ld a, h ; $4c00
	xor d ; $4c01
	ld h, a ; $4c02
	ld a, l ; $4c03
	xor e ; $4c04
	or h ; $4c05
	jr z, .done ; $4c06
	ld a, $ff ; $4c08
.done:
	push af ; $4c0a
	xor a ; $4c0b
	ld [rRAMG], a ; $4c0c
	pop af ; $4c0f
	pop bc ; $4c10
	pop de ; $4c11
	pop hl ; $4c12
	ret ; $4c13
VerifySaveBlock:
	push hl ; $4c14
	push de ; $4c15
	push bc ; $4c16
	ld a, $0a ; $4c17
	ld [rRAMG], a ; $4c19
	ld a, $00 ; $4c1c
	ldh [hSramBank], a ; $4c1e
	ld [rRAMB], a ; $4c20
	ld a, b ; $4c23
	call GetSaveBlockDirEntry ; $4c24
	ld a, [bc] ; $4c27
	or a ; $4c28
	jp nz, .present ; $4c29
	ld a, $fe ; $4c2c
	jp .done ; $4c2e
.present:
	push bc ; $4c31
	push hl ; $4c32
	ld hl, $0001 ; $4c33
	add hl, bc ; $4c36
	ld c, [hl] ; $4c37
	push bc ; $4c38
	inc hl ; $4c39
	ld a, [hl+] ; $4c3a
	ld e, a ; $4c3b
	ld a, [hl+] ; $4c3c
	ld d, a ; $4c3d
	ld a, [hl+] ; $4c3e
	ld b, [hl] ; $4c3f
	ld c, a ; $4c40
	ld hl, $a000 ; $4c41
	add hl, de ; $4c44
	ld d, h ; $4c45
	ld e, l ; $4c46
	pop hl ; $4c47
	ld a, l ; $4c48
	ldh [hSramBank], a ; $4c49
	ld [rRAMB], a ; $4c4b
	pop hl ; $4c4e
	push de ; $4c4f
	push bc ; $4c50
.compareLoop:
	ld a, [de] ; $4c51
	cp [hl] ; $4c52
	jr z, .next ; $4c53
	ld a, $00 ; $4c55
	ldh [hSramBank], a ; $4c57
	ld [rRAMB], a ; $4c59
	add sp, 6 ; $4c5c
	ld a, $fd ; $4c5e
	jp .done ; $4c60
.next:
	inc hl ; $4c63
	inc de ; $4c64
	dec bc ; $4c65
	ld a, b ; $4c66
	or c ; $4c67
	jr nz, .compareLoop ; $4c68
	pop bc ; $4c6a
	pop hl ; $4c6b
	ld de, $0000 ; $4c6c
.checksumLoop:
	ld a, [hl+] ; $4c6f
	add e ; $4c70
	ld e, a ; $4c71
	ld a, d ; $4c72
	adc $00 ; $4c73
	ld d, a ; $4c75
	dec bc ; $4c76
	ld a, b ; $4c77
	or c ; $4c78
	jr nz, .checksumLoop ; $4c79
	ld a, $00 ; $4c7b
	ldh [hSramBank], a ; $4c7d
	ld [rRAMB], a ; $4c7f
	pop bc ; $4c82
	ld hl, $0006 ; $4c83
	add hl, bc ; $4c86
	ld a, [hl+] ; $4c87
	ld h, [hl] ; $4c88
	ld l, a ; $4c89
	ld a, h ; $4c8a
	xor d ; $4c8b
	ld h, a ; $4c8c
	ld a, l ; $4c8d
	xor e ; $4c8e
	or h ; $4c8f
	jr z, .done ; $4c90
	ld a, $ff ; $4c92
.done:
	push af ; $4c94
	xor a ; $4c95
	ld [rRAMG], a ; $4c96
	pop af ; $4c99
	pop bc ; $4c9a
	pop de ; $4c9b
	pop hl ; $4c9c
	ret ; $4c9d
ReadSaveBlockTag:
	push hl ; $4c9e
	push de ; $4c9f
	push bc ; $4ca0
	ld a, $0a ; $4ca1
	ld [rRAMG], a ; $4ca3
	ld a, $00 ; $4ca6
	ldh [hSramBank], a ; $4ca8
	ld [rRAMB], a ; $4caa
	ld a, b ; $4cad
	call GetSaveBlockDirEntry ; $4cae
	ld a, [bc] ; $4cb1
	or a ; $4cb2
	jp nz, .nonZero ; $4cb3
	ld a, $fe ; $4cb6
	jp .loopB ; $4cb8
.nonZero:
	ld a, $08 ; $4cbb
	add c ; $4cbd
	ld e, a ; $4cbe
	ld d, b ; $4cbf
	ld c, $08 ; $4cc0
.loop:
	ld a, [de] ; $4cc2
	ld [hl+], a ; $4cc3
	inc de ; $4cc4
	dec c ; $4cc5
	jr nz, .loop ; $4cc6
	xor a ; $4cc8
.loopB:
	push af ; $4cc9
	xor a ; $4cca
	ld [rRAMG], a ; $4ccb
	pop af ; $4cce
	pop bc ; $4ccf
	pop de ; $4cd0
	pop hl ; $4cd1
	ret ; $4cd2
; ReadSaveBlockTag reading a 2-byte field (`ld c, $02`) where the live one reads 8. Nothing calls it.
Unused_03_ReadSaveBlockTagWord:
	push hl ; $4cd3
	push de ; $4cd4
	push bc ; $4cd5
	ld a, $0a ; $4cd6
	ld [rRAMG], a ; $4cd8
	ld a, $00 ; $4cdb
	ldh [hSramBank], a ; $4cdd
	ld [rRAMB], a ; $4cdf
	ld a, b ; $4ce2
	call GetSaveBlockDirEntry ; $4ce3
	ld a, [bc] ; $4ce6
	or a ; $4ce7
	jp nz, .nonZero2 ; $4ce8
	ld a, $fe ; $4ceb
	jp ReadSaveBlockTag.loopB ; $4ced
.nonZero2:
	ld a, $08 ; $4cf0
	add c ; $4cf2
	ld e, a ; $4cf3
	ld d, b ; $4cf4
	ld c, $02 ; $4cf5
.loop2:
	ld a, [de] ; $4cf7
	ld [hl+], a ; $4cf8
	inc de ; $4cf9
	dec c ; $4cfa
	jr nz, .loop2 ; $4cfb
	xor a ; $4cfd
	push af ; $4cfe
	xor a ; $4cff
	ld [rRAMG], a ; $4d00
	pop af ; $4d03
	pop bc ; $4d04
	pop de ; $4d05
	pop hl ; $4d06
	ret ; $4d07
SaveStorySlot:
	ld a, [wCurrentStorySlot] ; $4d08
	cp NUM_STORY_SLOTS ; $4d0b
	ret nc ; $4d0d
	jr SaveStorySlotWithTimer.checkCurrentStorySlot ; $4d0e
SaveStorySlotWithTimer:
	ld a, [wCurrentStorySlot] ; $4d10
	cp NUM_STORY_SLOTS ; $4d13
	ret nc ; $4d15
	call SaveGameTimer ; $4d16
.checkCurrentStorySlot:
	ld a, [wCurrentStorySlot] ; $4d19
	add a ; $4d1c
	ld b, a ; $4d1d
	ld hl, wStorySlotData ; $4d1e
	ld de, $0000 ; $4d21
	call WriteSaveBlock ; $4d24
	or a ; $4d27
	ret nz ; $4d28
	ld a, [wCurrentStorySlot] ; $4d29
	add a ; $4d2c
	ld b, a ; $4d2d
	ld hl, wStorySlotData ; $4d2e
	call VerifySaveBlock ; $4d31
	or a ; $4d34
	ret nz ; $4d35
	ld a, [wCurrentStorySlot] ; $4d36
	add a ; $4d39
	add $1b ; $4d3a
	ld b, a ; $4d3c
	ld hl, wStorySlotData ; $4d3d
	ld de, wTextBuffer ; $4d40
	call WriteSaveBlock ; $4d43
	or a ; $4d46
	ret nz ; $4d47
	ld a, [wCurrentStorySlot] ; $4d48
	add a ; $4d4b
	add $1b ; $4d4c
	ld b, a ; $4d4e
	ld hl, wStorySlotData ; $4d4f
	call VerifySaveBlock ; $4d52
	or a ; $4d55
	ret nz ; $4d56
	call UpdateUnlockablesSaveBlock ; $4d57
	xor a ; $4d5a
	ret ; $4d5b
	pop_wram_bank ; $4d5c
	ld a, $ff ; $4d61
	ret ; $4d63
CheckStorySlot:
	push bc ; $4d64
	push de ; $4d65
	push hl ; $4d66
	ld a, [wCurrentStorySlot] ; $4d67
	cp NUM_STORY_SLOTS ; $4d6a
	jr nc, .noSlot ; $4d6c
	add a ; $4d6e
	ld b, a ; $4d6f
	ld hl, wStorySlotData ; $4d70
	call ReadSaveBlock ; $4d73
	jr .done ; $4d76
.noSlot:
	ld a, $fe ; $4d78
.done:
	pop hl ; $4d7a
	pop de ; $4d7b
	pop bc ; $4d7c
	ret ; $4d7d
SaveFlagMaskTable_03:
	; $4d7e, 8 bytes (bytes:8)
	db $80, $40, $20, $10, $08, $04, $02, $01 ; 0x00
TestSaveFlag:
	push hl ; $4d86
	push de ; $4d87
	push bc ; $4d88
	ld b, a ; $4d89
	ld a, $0a ; $4d8a
	ld [rRAMG], a ; $4d8c
	ld a, $00 ; $4d8f
	ldh [hSramBank], a ; $4d91
	ld [rRAMB], a ; $4d93
	ld hl, SaveFlagMaskTable_03 ; $4d96
	ld a, e ; $4d99
	rlca ; $4d9a
	rlca ; $4d9b
	rlca ; $4d9c
	add l ; $4d9d
	ld l, a ; $4d9e
	jr nc, .gotMask ; $4d9f
	inc h ; $4da1
.gotMask:
	ld a, [hl] ; $4da2
	ld hl, sSaveFlags ; $4da3
	ld e, d ; $4da6
	ld d, $00 ; $4da7
	add hl, de ; $4da9
	and [hl] ; $4daa
	push af ; $4dab
	xor a ; $4dac
	ld [rRAMG], a ; $4dad
	pop af ; $4db0
	ld a, b ; $4db1
	pop bc ; $4db2
	pop de ; $4db3
	pop hl ; $4db4
	ret ; $4db5
SetSaveFlag:
	push hl ; $4db6
	push af ; $4db7
	ld a, $0a ; $4db8
	ld [rRAMG], a ; $4dba
	ld a, $00 ; $4dbd
	ldh [hSramBank], a ; $4dbf
	ld [rRAMB], a ; $4dc1
	ld hl, SaveFlagMaskTable_03 ; $4dc4
	ld a, e ; $4dc7
	rlca ; $4dc8
	rlca ; $4dc9
	rlca ; $4dca
	add l ; $4dcb
	ld l, a ; $4dcc
	jr nc, .gotMask ; $4dcd
	inc h ; $4dcf
.gotMask:
	ld a, [hl] ; $4dd0
	ld hl, sSaveFlags ; $4dd1
	ld e, d ; $4dd4
	ld d, $00 ; $4dd5
	add hl, de ; $4dd7
	or [hl] ; $4dd8
	ld [hl], a ; $4dd9
	call UpdateSaveHeaderChecksum ; $4dda
	xor a ; $4ddd
	ld [rRAMG], a ; $4dde
	pop af ; $4de1
	pop hl ; $4de2
	ret ; $4de3
ClearSaveFlag:
	push hl ; $4de4
	push af ; $4de5
	ld a, $0a ; $4de6
	ld [rRAMG], a ; $4de8
	ld a, $00 ; $4deb
	ldh [hSramBank], a ; $4ded
	ld [rRAMB], a ; $4def
	ld hl, SaveFlagMaskTable_03 ; $4df2
	ld a, e ; $4df5
	rlca ; $4df6
	rlca ; $4df7
	rlca ; $4df8
	add l ; $4df9
	ld l, a ; $4dfa
	jr nc, .gotMask ; $4dfb
	inc h ; $4dfd
.gotMask:
	ld a, [hl] ; $4dfe
	ld hl, sSaveFlags ; $4dff
	ld e, d ; $4e02
	ld d, $00 ; $4e03
	add hl, de ; $4e05
	cpl ; $4e06
	and [hl] ; $4e07
	ld [hl], a ; $4e08
	call UpdateSaveHeaderChecksum ; $4e09
	xor a ; $4e0c
	ld [rRAMG], a ; $4e0d
	pop af ; $4e10
	pop hl ; $4e11
	ret ; $4e12

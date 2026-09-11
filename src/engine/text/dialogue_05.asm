ShowDialogueAtPosition:
	push af ; $59b0
	push bc ; $59b1
	push de ; $59b2
	ld b, a ; $59b3
	push_wram_bank $05 ; $59b4
	xor a ; $59bd
	ld [wTextArgStringWriteIndex], a ; $59be
	ld [wTextArgStringMeasureIndex], a ; $59c1
	ld [wTextArgNumberWriteIndex], a ; $59c4
	ld [wTextArgNumberMeasureIndex], a ; $59c7
	ld [wTextArgShortTextWriteIndex], a ; $59ca
	ld [wTextArgShortTextMeasureIndex], a ; $59cd
	call AddTextIdOffset ; $59d0
	ld a, b ; $59d3
	bit 7, a ; $59d4
	ld b, $08 ; $59d6
	jr nz, .applyMessageSpeed ; $59d8
	call GetSpeakerVoice ; $59da
	ld b, a ; $59dd
.applyMessageSpeed:
	ld a, b ; $59de
	ld [wDialogueVoice], a ; $59df
	call ApplyMessageSpeed ; $59e2
	ld a, [wDialogueWindowId] ; $59e5
	cp DIALOGUEWIN_NONE ; $59e8
	jr nz, .loop ; $59ea
	call OpenDialogueWindowCentered ; $59ec
	call RefreshShadowTilemapFromMapBuffer ; $59ef
.loop:
	xor a ; $59f2
	ld [wGlyphRowStartCol], a ; $59f3
	ld [wGlyphFlushedCol], a ; $59f6
	push_wram_bank $07 ; $59f9
	call ClearGlyphBuffer ; $5a02
	call UploadGlyphBufferFull ; $5a05
	pop_wram_bank ; $5a08
	call SetActiveWindowTextId ; $5a0d
	ld a, [wDialogueWindowId] ; $5a10
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $5a13
	call DrawTextWindowFrame ; $5a16
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $5a19
	call RedrawWindowRowsPadded ; $5a1c
	call RenderActiveWindowText ; $5a1f
	ld a, [wTextPageBreakRequest] ; $5a22
	or a ; $5a25
	jr nz, .loop ; $5a26
	ld a, [wDialogueWindowId] ; $5a28
	call CloseWindow ; $5a2b
	ld a, DIALOGUEWIN_NONE ; $5a2e
	ld [wDialogueWindowId], a ; $5a30
	xor a ; $5a33
	ld [wTextArgStringWriteIndex], a ; $5a34
	ld [wTextArgStringMeasureIndex], a ; $5a37
	ld [wTextArgNumberWriteIndex], a ; $5a3a
	ld [wTextArgNumberMeasureIndex], a ; $5a3d
	ld [wTextArgShortTextWriteIndex], a ; $5a40
	ld [wTextArgShortTextMeasureIndex], a ; $5a43
	pop_wram_bank ; $5a46
	pop de ; $5a4b
	pop bc ; $5a4c
	pop af ; $5a4d
	ret ; $5a4e
DrawDialogueAtPosition:
	push af ; $5a4f
	push bc ; $5a50
	push de ; $5a51
	ld a, d ; $5a52
	sub $0a ; $5a53
	ld d, a ; $5a55
	ld a, e ; $5a56
	sub $09 ; $5a57
	ld e, a ; $5a59
	ld b, a ; $5a5a
	push_wram_bank $05 ; $5a5b
	ld a, b ; $5a64
	bit 7, a ; $5a65
	ld a, $08 ; $5a67
	jr nz, .store ; $5a69
	call GetSpeakerVoice ; $5a6b
.store:
	ld [wDialogueVoice], a ; $5a6e
	ld a, [wDialogueWindowId] ; $5a71
	cp DIALOGUEWIN_NONE ; $5a74
	jr nz, .loop ; $5a76
	call OpenDialogueWindowCentered ; $5a78
.loop:
	call SetActiveWindowTextId ; $5a7b
	call RestoreShadowTilemap ; $5a7e
	call StubNop_05_0 ; $5a81
	ld a, [wTextPageBreakRequest] ; $5a84
	or a ; $5a87
	jr nz, .loop ; $5a88
	pop_wram_bank ; $5a8a
	pop de ; $5a8f
	pop bc ; $5a90
	pop af ; $5a91
	ret ; $5a92
CloseActiveDialogueWindow:
	push af ; $5a93
	push_wram_bank $05 ; $5a94
	ld a, [wDialogueWindowId] ; $5a9d
	call CloseWindow ; $5aa0
	ld a, DIALOGUEWIN_NONE ; $5aa3
	ld [wDialogueWindowId], a ; $5aa5
	pop_wram_bank ; $5aa8
	pop af ; $5aad
	ret ; $5aae
OpenSpeechBubble:
	push af ; $5aaf
	push bc ; $5ab0
	push de ; $5ab1
	push hl ; $5ab2
	push hl ; $5ab3
	ld b, a ; $5ab4
	ldh a, [hWramBank] ; $5ab5
	push af ; $5ab7
	ld a, b ; $5ab8
	and $3f ; $5ab9
	ld e, a ; $5abb
	rl b ; $5abc
	jr nc, .getObjectSlotPointer ; $5abe
	jr .step2 ; $5ac0
.getObjectSlotPointer:
	call GetObjectSlotPointer ; $5ac2
	ld a, [wCameraY + 1] ; $5ac5
	ld b, a ; $5ac8
	ld a, l ; $5ac9
	ldh [hActorPtr], a ; $5aca
	ld a, h ; $5acc
	ldh [hActorPtr + 1], a ; $5acd
	wram_bank $04 ; $5acf
	ld hl, hActorPtr ; $5ad5
	ld a, [hl+] ; $5ad8
	ld h, [hl] ; $5ad9
	add $0e ; $5ada
	ld l, a ; $5adc
	inc hl ; $5add
	ld a, [hl] ; $5ade
	sub b ; $5adf
	cp $0a ; $5ae0
	jr c, .lt0a ; $5ae2
	ld e, $00 ; $5ae4
	ld b, $00 ; $5ae6
	jr .step2 ; $5ae8
.lt0a:
	ld e, $0a ; $5aea
	ld b, $01 ; $5aec
.step2:
	wram_bank $05 ; $5aee
	ld a, b ; $5af4
	ld [wSpeechBubbleLowerHalf], a ; $5af5
	pop_wram_bank ; $5af8
	ld b, $14 ; $5afd
	ld c, $07 ; $5aff
	ld d, $00 ; $5b01
	call CreateDialogueWindow ; $5b03
	pop hl ; $5b06
	call FetchDialogueText ; $5b07
	call FitWindowToText ; $5b0a
	xor a ; $5b0d
	ld [wTextArgStringMeasureIndex], a ; $5b0e
	ld [wTextArgShortTextMeasureIndex], a ; $5b11
	ld a, [wDialogueWindowId] ; $5b14
	call GetWindowStructPtr ; $5b17
	wram_bank $05 ; $5b1a
	ld a, [wDialogueWindowCol] ; $5b20
	add $08 ; $5b23
	and $1f ; $5b25
	ld d, a ; $5b27
	ld a, [wDialogueWindowRow] ; $5b28
	add $02 ; $5b2b
	and $1f ; $5b2d
	ld e, a ; $5b2f
	ld b, $03 ; $5b30
	ld c, $03 ; $5b32
	ld a, $08 ; $5b34
	inc hl ; $5b36
	inc hl ; $5b37
	ld a, [hl] ; $5b38
	rr a ; $5b39
	jr c, .carry ; $5b3b
	inc b ; $5b3d
.carry:
	dec hl ; $5b3e
	dec hl ; $5b3f
	call RestoreShadowTilemap ; $5b40
	push af ; $5b43
	ld a, [wWindowId] ; $5b44
	call SaveWindowStruct ; $5b47
	pop af ; $5b4a
.loop:
	push af ; $5b4b
	ld a, [wWindowId] ; $5b4c
	call GetWindowStructPtr ; $5b4f
	call SetWindowRect ; $5b52
	ld a, [wWindowId] ; $5b55
	call DrawTextWindowFrame ; $5b58
	ld hl, wSavedWindowStruct ; $5b5b
	ld a, [wWindowId] ; $5b5e
	call RedrawWindowRowsPadded ; $5b61
	ld a, d ; $5b64
	cp [hl] ; $5b65
	jr z, .step4 ; $5b66
	dec a ; $5b68
	and $1f ; $5b69
	ld d, a ; $5b6b
.step4:
	jr .next ; $5b6c
	dec d ; $5b6e
	bit 7, d ; $5b6f
	jr z, .next ; $5b71
	ld d, $00 ; $5b73
.next:
	inc hl ; $5b75
	dec e ; $5b76
	ld a, e ; $5b77
	sub [hl] ; $5b78
	bit 7, a ; $5b79
	jr z, .positive ; $5b7b
	ld a, [hl] ; $5b7d
	ld e, a ; $5b7e
.positive:
	inc hl ; $5b7f
	inc b ; $5b80
	inc b ; $5b81
	ld a, [hl] ; $5b82
	cp b ; $5b83
	jr nc, .countLeft ; $5b84
	ld b, a ; $5b86
.countLeft:
	inc hl ; $5b87
	inc c ; $5b88
	ld a, [hl] ; $5b89
	cp c ; $5b8a
	jr nc, .countLeft2 ; $5b8b
	ld c, a ; $5b8d
.countLeft2:
	dec hl ; $5b8e
	dec hl ; $5b8f
	dec hl ; $5b90
	pop af ; $5b91
	dec a ; $5b92
	jr nz, .loop ; $5b93
	ld a, [wDialogueWindowId] ; $5b95
	call RestoreWindowStruct ; $5b98
	pop hl ; $5b9b
	pop de ; $5b9c
	pop bc ; $5b9d
	pop af ; $5b9e
	ret ; $5b9f
OpenDialogueWindowCentered:
	push af ; $5ba0
	push bc ; $5ba1
	push de ; $5ba2
	push hl ; $5ba3
	push de ; $5ba4
	push hl ; $5ba5
	ld de, $0000 ; $5ba6
	ld b, $14 ; $5ba9
	ld c, $07 ; $5bab
	call CreateDialogueWindow ; $5bad
	pop hl ; $5bb0
	call FetchDialogueText ; $5bb1
	call FitWindowToText ; $5bb4
	pop de ; $5bb7
	ld a, [wDialogueWindowId] ; $5bb8
	call GetWindowStructPtr ; $5bbb
	inc hl ; $5bbe
	inc hl ; $5bbf
	ld a, d ; $5bc0
	ld d, [hl] ; $5bc1
	sra d ; $5bc2
	sub d ; $5bc4
	and $1f ; $5bc5
	ld d, a ; $5bc7
	inc hl ; $5bc8
	ld a, e ; $5bc9
	ld e, [hl] ; $5bca
	sra e ; $5bcb
	sub e ; $5bcd
	and $1f ; $5bce
	ld e, a ; $5bd0
	dec hl ; $5bd1
	dec hl ; $5bd2
	ld [hl-], a ; $5bd3
	ld [hl], d ; $5bd4
	ldh a, [hScrollY] ; $5bd5
	ld b, a ; $5bd7
	srl b ; $5bd8
	srl b ; $5bda
	srl b ; $5bdc
	srl b ; $5bde
	srl b ; $5be0
	srl b ; $5be2
	ld a, e ; $5be4
	sub b ; $5be5
	dec hl ; $5be6
	push hl ; $5be7
	ld a, [hl+] ; $5be8
	ld d, [hl] ; $5be9
	inc hl ; $5bea
	ld e, [hl] ; $5beb
	inc hl ; $5bec
	ld b, [hl] ; $5bed
	inc hl ; $5bee
	ld c, [hl] ; $5bef
	pop hl ; $5bf0
	ld a, [wWindowId] ; $5bf1
	call DrawTextWindowFrame ; $5bf4
	pop hl ; $5bf7
	pop de ; $5bf8
	pop bc ; $5bf9
	pop af ; $5bfa
	ret ; $5bfb
MeasureDialogueWidthTiles:
	push bc ; $5bfc
	push_wram_bank $05 ; $5bfd
	call FetchDialogueText ; $5c06
	call FitWindowToText ; $5c09
	ld a, [wFitTextWidthCells] ; $5c0c
	ld b, a ; $5c0f
	pop_wram_bank ; $5c10
	ld a, b ; $5c15
	pop bc ; $5c16
	ret ; $5c17
FetchDialogueText:
	push af ; $5c18
	push bc ; $5c19
	push de ; $5c1a
	push hl ; $5c1b
	bit 7, h ; $5c1c
	jr nz, FetchDialogueTextFromSram ; $5c1e
	ld d, h ; $5c20
	ld e, l ; $5c21
	ld b, d ; $5c22
	ld a, d ; $5c23
	and $03 ; $5c24
	ld d, a ; $5c26
	ld a, b ; $5c27
	srl a ; $5c28
	srl a ; $5c2a
	and $0f ; $5c2c
	ld hl, DialogueTextFetchers_05 ; $5c2e
	add a ; $5c31
	add l ; $5c32
	ld l, a ; $5c33
	jr nc, .readFetcher ; $5c34
	inc h ; $5c36
.readFetcher:
	ld a, [hl+] ; $5c37
	ld h, [hl] ; $5c38
	ld l, a ; $5c39
	jp hl ; $5c3a
DialogueTextFetchers_05:
	; $5c3b, 32 bytes (records:2)
	dw FetchDialogueTextBank30 ; record 0
	dw FetchDialogueTextBank31 ; record 1
	dw FetchDialogueTextBank32 ; record 2
	dw FetchDialogueTextBank33 ; record 3
	dw FetchDialogueTextBank34 ; record 4
	dw FetchDialogueTextBank35 ; record 5
	dw FetchDialogueTextBank36 ; record 6
	dw FetchDialogueTextBank37 ; record 7
	dw FetchDialogueText_6eThunk ; record 8
	dw FetchDialogueText_1fThunk ; record 9
	dw FetchDialogueText_25Thunk ; record 10
	dw FetchDialogueText_26Thunk ; record 11
	dw FetchDialogueText_5eThunk ; record 12
	dw FetchDialogueTextBank30 ; record 13
	dw FetchDialogueTextBank30 ; record 14
	dw FetchDialogueTextBank30 ; record 15
FetchDialogueTextBank30:
	farcall FetchDialogueText_30 ; $5c5b
	jr FetchDialogueTextDone ; $5c5e
FetchDialogueTextBank31:
	farcall FetchDialogueText_31 ; $5c60
	jr FetchDialogueTextDone ; $5c63
FetchDialogueTextBank32:
	farcall FetchDialogueText_32 ; $5c65
	jr FetchDialogueTextDone ; $5c68
FetchDialogueTextBank33:
	farcall FetchDialogueText_33 ; $5c6a
	jr FetchDialogueTextDone ; $5c6d
FetchDialogueTextBank34:
	farcall FetchDialogueText_34 ; $5c6f
	jr FetchDialogueTextDone ; $5c72
FetchDialogueTextBank35:
	farcall FetchDialogueText_35 ; $5c74
	jr FetchDialogueTextDone ; $5c77
FetchDialogueTextBank36:
	farcall FetchDialogueText_36 ; $5c79
	jr FetchDialogueTextDone ; $5c7c
FetchDialogueTextBank37:
	farcall FetchDialogueText_37 ; $5c7e
	jr FetchDialogueTextDone ; $5c81
FetchDialogueText_6eThunk:
	farcall FetchDialogueText_6e ; $5c83
	jr FetchDialogueTextDone ; $5c86
FetchDialogueText_1fThunk:
	farcall FetchDialogueText_1f ; $5c88
	jr FetchDialogueTextDone ; $5c8b
FetchDialogueText_25Thunk:
	farcall FetchDialogueText_25 ; $5c8d
	jr FetchDialogueTextDone ; $5c90
FetchDialogueText_26Thunk:
	farcall FetchDialogueText_26 ; $5c92
	jr FetchDialogueTextDone ; $5c95
FetchDialogueText_5eThunk:
	farcall FetchDialogueText_5e ; $5c97
	jr FetchDialogueTextDone ; $5c9a
FetchDialogueTextFromSram:
	ld a, h ; $5c9c
	and $03 ; $5c9d
	ld h, a ; $5c9f
	call FetchSRAMDialogueText ; $5ca0
FetchDialogueTextDone:
	pop hl ; $5ca3
	pop de ; $5ca4
	pop bc ; $5ca5
	pop af ; $5ca6
	ret ; $5ca7
FetchShortText:
	push af ; $5ca8
	push bc ; $5ca9
	push de ; $5caa
	push hl ; $5cab
	ld d, h ; $5cac
	ld e, l ; $5cad
	ld b, d ; $5cae
	ld a, d ; $5caf
	and $03 ; $5cb0
	ld d, a ; $5cb2
	ld a, b ; $5cb3
	srl a ; $5cb4
	srl a ; $5cb6
	and $0f ; $5cb8
	ld hl, ShortTextFetchers_05 ; $5cba
	add a ; $5cbd
	add l ; $5cbe
	ld l, a ; $5cbf
	jr nc, .read ; $5cc0
	inc h ; $5cc2
.read:
	ld a, [hl+] ; $5cc3
	ld h, [hl] ; $5cc4
	ld l, a ; $5cc5
	jp hl ; $5cc6
ShortTextFetchers_05:
	; $5cc7, 32 bytes (records:2)
	dw FetchShortTextBank30 ; record 0
	dw FetchShortTextBank31 ; record 1
	dw FetchShortTextBank32 ; record 2
	dw FetchShortTextBank33 ; record 3
	dw FetchShortTextBank34 ; record 4
	dw FetchShortTextBank35 ; record 5
	dw FetchShortTextBank36 ; record 6
	dw FetchShortTextBank37 ; record 7
	dw FetchShortText_6eThunk ; record 8
	dw FetchShortText_1fThunk ; record 9
	dw FetchShortText_25Thunk ; record 10
	dw FetchShortText_26Thunk ; record 11
	dw FetchShortText_5eThunk ; record 12
	dw FetchShortTextBank30 ; record 13
	dw FetchShortTextBank30 ; record 14
	dw FetchShortTextBank30 ; record 15
FetchShortTextBank30:
	farcall FetchShortText_30 ; $5ce7
	jr FetchShortText_5eThunk.restore ; $5cea
FetchShortTextBank31:
	farcall FetchShortText_31 ; $5cec
	jr FetchShortText_5eThunk.restore ; $5cef
FetchShortTextBank32:
	farcall FetchShortText_32 ; $5cf1
	jr FetchShortText_5eThunk.restore ; $5cf4
FetchShortTextBank33:
	farcall FetchShortText_33 ; $5cf6
	jr FetchShortText_5eThunk.restore ; $5cf9
FetchShortTextBank34:
	farcall FetchShortText_34 ; $5cfb
	jr FetchShortText_5eThunk.restore ; $5cfe
FetchShortTextBank35:
	farcall FetchShortText_35 ; $5d00
	jr FetchShortText_5eThunk.restore ; $5d03
FetchShortTextBank36:
	farcall FetchShortText_36 ; $5d05
	jr FetchShortText_5eThunk.restore ; $5d08
FetchShortTextBank37:
	farcall FetchShortText_37 ; $5d0a
	jr FetchShortText_5eThunk.restore ; $5d0d
FetchShortText_6eThunk:
	farcall FetchShortText_6e ; $5d0f
	jr FetchShortText_5eThunk.restore ; $5d12
FetchShortText_1fThunk:
	farcall FetchShortText_1f ; $5d14
	jr FetchShortText_5eThunk.restore ; $5d17
FetchShortText_25Thunk:
	farcall FetchShortText_25 ; $5d19
	jr FetchShortText_5eThunk.restore ; $5d1c
FetchShortText_26Thunk:
	farcall FetchShortText_26 ; $5d1e
	jr FetchShortText_5eThunk.restore ; $5d21
FetchShortText_5eThunk:
	farcall FetchShortText_5e ; $5d23
.restore:
	pop hl ; $5d26
	pop de ; $5d27
	pop bc ; $5d28
	pop af ; $5d29
	ret ; $5d2a
AddTextIdOffset:
	bit 7, h ; $5d2b
	ret nz ; $5d2d
	push af ; $5d2e
	push bc ; $5d2f
	push de ; $5d30
	add sp, -2 ; $5d31
	push hl ; $5d33
	ld b, $00 ; $5d34
	ld c, a ; $5d36
	ld a, h ; $5d37
	ld e, h ; $5d38
	and $03 ; $5d39
	ld h, a ; $5d3b
	add hl, bc ; $5d3c
	ld b, h ; $5d3d
	ld c, l ; $5d3e
	ld a, e ; $5d3f
	and $3c ; $5d40
	ld e, a ; $5d42
	ld a, h ; $5d43
	or e ; $5d44
	ld d, a ; $5d45
	ld e, l ; $5d46
	ld hl, sp + 2 ; $5d47
	ld [hl], e ; $5d49
	inc hl ; $5d4a
	ld [hl], d ; $5d4b
	pop hl ; $5d4c
	ld a, h ; $5d4d
	and $3c ; $5d4e
	sra a ; $5d50
	ld e, a ; $5d52
	ld d, $00 ; $5d53
	ld hl, AddTextIdOffsetWordLookupTable ; $5d55
	add hl, de ; $5d58
	ld e, [hl] ; $5d59
	inc hl ; $5d5a
	ld d, [hl] ; $5d5b
	ld a, b ; $5d5c
	xor $ff ; $5d5d
	ld b, a ; $5d5f
	ld a, c ; $5d60
	xor $ff ; $5d61
	ld c, a ; $5d63
	inc bc ; $5d64
	ld h, d ; $5d65
	ld l, e ; $5d66
	add hl, bc ; $5d67
	push hl ; $5d68
	ld hl, sp + 2 ; $5d69
	ld c, [hl] ; $5d6b
	inc hl ; $5d6c
	ld b, [hl] ; $5d6d
	pop hl ; $5d6e
	ld a, l ; $5d6f
	or h ; $5d70
	jr z, .underflow ; $5d71
	bit 7, h ; $5d73
	jr z, .done ; $5d75
.underflow:
	ld a, b ; $5d77
	and $3c ; $5d78
	add $04 ; $5d7a
	ld d, a ; $5d7c
	ld a, b ; $5d7d
	and $c0 ; $5d7e
	or d ; $5d80
	ld b, a ; $5d81
	ld a, h ; $5d82
	xor $ff ; $5d83
	ld h, a ; $5d85
	ld a, l ; $5d86
	xor $ff ; $5d87
	ld l, a ; $5d89
	inc hl ; $5d8a
	ld a, h ; $5d8b
	and $03 ; $5d8c
	or b ; $5d8e
	ld b, a ; $5d8f
	ld c, l ; $5d90
.done:
	ld h, b ; $5d91
	ld l, c ; $5d92
	add sp, 2 ; $5d93
	pop de ; $5d95
	pop bc ; $5d96
	pop af ; $5d97
	ret ; $5d98
AddTextIdOffsetWordLookupTable:
	; $5d99, 26 bytes (records:2)
	dw $0230 ; record 0
	dw $015b ; record 1
	dw $00bb ; record 2
	dw $00dd ; record 3
	dw $011f ; record 4
	dw $010e ; record 5
	dw $02c7 ; record 6
	dw $0100 ; record 7
	dw $00f2 ; record 8
	dw $00bd ; record 9
	dw $010b ; record 10
	dw $00f9 ; record 11
	dw $0143 ; record 12

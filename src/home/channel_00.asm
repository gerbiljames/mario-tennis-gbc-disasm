NoiseNoteTable:
	; $3836, 16 bytes (bytes:16)
	db $00, $01, $11, $12, $14, $23, $07, $15, $17, $32, $33, $60, $61, $45, $53, $62 ; 0x00
SndTriggerNoteBody:
	xor a ; $3846
	ldh [hSndRestFlag], a ; $3847
	ld a, [wSndChannelType] ; $3849
	cp SNDCHANTYPE_WAVE ; $384c
	jr z, .checkPeriod ; $384e
	ldh a, [hSndPeriodHi] ; $3850
	and $7f ; $3852
	jp z, SndSilenceChannel ; $3854
	ret ; $3857
.checkPeriod:
	ldh a, [hSndPeriodHi] ; $3858
	and $7f ; $385a
	ret nz ; $385c
	call AbortIfChannelTriggered ; $385d
	xor a ; $3860
	ldh [rAUD3ENA], a ; $3861
	ret ; $3863
SndTriggerNote:
	ld b, a ; $3864
	ldh a, [hSndEchoCtrl] ; $3865
	and $f0 ; $3867
	jr z, .read ; $3869
	push de ; $386b
	ldh a, [hSndEchoCtrl] ; $386c
	and $0f ; $386e
	ldh [hSndEchoTimer], a ; $3870
	ld c, a ; $3872
	ld a, [hl] ; $3873
	sub c ; $3874
	ldh [hSndPortamentoTimer], a ; $3875
	pop de ; $3877
	jr .step ; $3878
.read:
	ld a, [hl] ; $387a
	ldh [hSndPortamentoTimer], a ; $387b
.step:
	push bc ; $387d
	ld c, a ; $387e
	ldh a, [hSndNoteOffset] ; $387f
	bit 7, a ; $3881
	jr z, .restore ; $3883
	add c ; $3885
	jr z, .zero ; $3886
	jr c, .restore ; $3888
.zero:
	ld a, $01 ; $388a
.restore:
	pop bc ; $388c
	ldh [hSndRestFlag], a ; $388d
	ld a, [wSndChannelType] ; $388f
	cp SNDCHANTYPE_NOISE ; $3892
	jr nz, .ne03 ; $3894
	ld a, b ; $3896
	cp $1f ; $3897
	jr z, SndTriggerNoteBody ; $3899
	cp $10 ; $389b
	jr nc, .ge10 ; $389d
	ld hl, NoiseNoteTable ; $389f
	add l ; $38a2
	ld l, a ; $38a3
	ld a, h ; $38a4
	adc $00 ; $38a5
	ld h, a ; $38a7
	ld l, [hl] ; $38a8
	ld h, $00 ; $38a9
	jr .abortIfChannelTriggered ; $38ab
.ge10:
	ld l, a ; $38ad
	ld h, $00 ; $38ae
	jr .abortIfChannelTriggered ; $38b0
.ne03:
	ld a, b ; $38b2
	and $0f ; $38b3
	cp $0c ; $38b5
	jr nc, SndTriggerNoteBody ; $38b7
	add a ; $38b9
	ld e, a ; $38ba
	ldh a, [hSndToneCtrl] ; $38bb
	and $10 ; $38bd
	jr z, .maskClear ; $38bf
	ld a, e ; $38c1
	add $18 ; $38c2
	ld e, a ; $38c4
.maskClear:
	ld d, $00 ; $38c5
	ld hl, NotePeriodTable ; $38c7
	add hl, de ; $38ca
	ld a, [hl+] ; $38cb
	ld h, [hl] ; $38cc
	ld l, a ; $38cd
	ld a, b ; $38ce
	swap a ; $38cf
	and $0f ; $38d1
	jr z, .maskClear2 ; $38d3
	ld b, a ; $38d5
.loop:
	srl h ; $38d6
	rr l ; $38d8
	dec b ; $38da
	jr nz, .loop ; $38db
.maskClear2:
	ld a, $00 ; $38dd
	sub l ; $38df
	ld l, a ; $38e0
	ld a, $08 ; $38e1
	sbc h ; $38e3
	ld h, a ; $38e4
.abortIfChannelTriggered:
	xor a ; $38e5
	ldh [hSndEnvPos], a ; $38e6
	call AbortIfChannelTriggered ; $38e8
	ld a, [wSndChannelType] ; $38eb
	cp SNDCHANTYPE_WAVE ; $38ee
	jr nz, .ne02 ; $38f0
	call LoadWavePatternIfChanged ; $38f2
	ld a, $80 ; $38f5
	ldh [rAUD3ENA], a ; $38f7
.ne02:
	push hl ; $38f9
	call ApplyChannelVolumeEnvelope ; $38fa
	pop hl ; $38fd
	ld a, [wSndChannelType] ; $38fe
	and a ; $3901
	ldh a, [hSndWaveId] ; $3902
	ld c, $10 ; $3904
	call z, WriteChannelReg ; $3906
	ld a, l ; $3909
	ld c, $13 ; $390a
	call WriteChannelReg ; $390c
	ld a, l ; $390f
	cp $02 ; $3910
	jr c, .lt02 ; $3912
	cp $fe ; $3914
	jr c, .store ; $3916
	ld a, $fd ; $3918
	jr .store ; $391a
.lt02:
	ld a, $02 ; $391c
.store:
	ldh [hSndPeriodLo], a ; $391e
	ld a, [wSndChannelType] ; $3920
	cp SNDCHANTYPE_WAVE ; $3923
	jr z, .eq02 ; $3925
	cp SNDCHANTYPE_WAVE ; $3927
	jr nc, .loopB ; $3929
	ldh a, [hSndToneCtrl] ; $392b
	and $c0 ; $392d
	or $3f ; $392f
	ld c, $11 ; $3931
	call WriteChannelReg ; $3933
.loopB:
	ld a, h ; $3936
	and $07 ; $3937
	or $80 ; $3939
.loop2:
	or $20 ; $393b
	ldh [hSndPeriodHi], a ; $393d
	ld c, $14 ; $393f
	call WriteChannelReg ; $3941
	call ResetChannelLength ; $3944
.checkSndChannelPanMask:
	ld a, [wSndChannelPanMask] ; $3947
	ld b, a ; $394a
	cpl ; $394b
	ld c, a ; $394c
	ldh a, [hSndPanMask] ; $394d
	and b ; $394f
	ld b, a ; $3950
	ld a, [wSndPanShadow] ; $3951
	and c ; $3954
	or b ; $3955
	ld [wSndPanShadow], a ; $3956
	ret ; $3959
.eq02:
	xor a ; $395a
	ldh [rAUD3LEN], a ; $395b
	ldh a, [rAUDENA] ; $395d
	and $04 ; $395f
	jr z, .loopB ; $3961
	ld a, h ; $3963
	and $07 ; $3964
	jr .loop2 ; $3966
TickVolumeSlide:
	ld a, [wSndChannelType] ; $3968
	cp SNDCHANTYPE_WAVE ; $396b
	ret z ; $396d
	ldh a, [hSndVolSlide] ; $396e
	and a ; $3970
	ret z ; $3971
	ld hl, hSndVolSlideTimer ; $3972
	dec [hl] ; $3975
	ret nz ; $3976
	ldh a, [hSndVolume] ; $3977
	swap a ; $3979
	cp $10 ; $397b
	ret nc ; $397d
	and $0f ; $397e
	ld b, a ; $3980
	ldh a, [hSndVolSlideReload] ; $3981
	ldh [hSndVolSlideTimer], a ; $3983
	ld hl, $ffe0 ; $3985
	ld a, [hl] ; $3988
	bit 7, a ; $3989
	jr nz, .bump ; $398b
	dec [hl] ; $398d
	ld a, b ; $398e
	cp $0f ; $398f
	ret z ; $3991
	ldh a, [hSndVolume] ; $3992
	add $10 ; $3994
	ldh [hSndVolume], a ; $3996
	jp ApplyChannelEnvelope ; $3998
.bump:
	inc [hl] ; $399b
	ld a, b ; $399c
	and a ; $399d
	ret z ; $399e
	ldh a, [hSndVolume] ; $399f
	sub $10 ; $39a1
	ldh [hSndVolume], a ; $39a3
	jr ApplyChannelEnvelope ; $39a5
TickVibrato:
	call AbortIfChannelTriggered ; $39a7
	ld a, [wSndChannelType] ; $39aa
	cp SNDCHANTYPE_NOISE ; $39ad
	ret z ; $39af
	ldh a, [hSndNoteLenTimer] ; $39b0
	and a ; $39b2
	ret nz ; $39b3
	ldh a, [hSndChannelType] ; $39b4
	and $f0 ; $39b6
	ret z ; $39b8
	sub $10 ; $39b9
	ld b, a ; $39bb
	ld a, [wSndFrameCounter] ; $39bc
	and $0f ; $39bf
	or b ; $39c1
	ld e, a ; $39c2
	ld d, $00 ; $39c3
	ld hl, SoundPitchTable ; $39c5
	add hl, de ; $39c8
	ldh a, [hSndPeriodLo] ; $39c9
	add [hl] ; $39cb
	ld c, $13 ; $39cc
	jr WriteChannelReg ; $39ce
ApplyChannelVolumeEnvelope:
	ld a, [wSndChannelType] ; $39d0
	cp SNDCHANTYPE_WAVE ; $39d3
	jr z, WriteChannelReg.writeChannelReg ; $39d5
	ldh a, [hSndEnvRate] ; $39d7
	and a ; $39d9
	jp nz, TickInstrumentEnvelope.eq02 ; $39da
	ldh a, [hSndVolume] ; $39dd
ApplyChannelEnvelope:
	ld b, a ; $39df
	and $f0 ; $39e0
	jr z, .checkRate ; $39e2
	ldh a, [hSndRestFlag] ; $39e4
	or a ; $39e6
	jr nz, .checkRate ; $39e7
	ld a, b ; $39e9
	rrca ; $39ea
	rrca ; $39eb
	add $10 ; $39ec
	and $f0 ; $39ee
	ld c, a ; $39f0
	ld a, b ; $39f1
	and $0f ; $39f2
	or c ; $39f4
	ld b, a ; $39f5
.checkRate:
	ld a, b ; $39f6
	and $07 ; $39f7
	jr nz, .writeReg ; $39f9
	ld a, b ; $39fb
	or $08 ; $39fc
	ld b, a ; $39fe
.writeReg:
	ld a, [wSndRegBase] ; $39ff
	add $12 ; $3a02
	ld c, a ; $3a04
	ldh a, [c] ; $3a05
	cp b ; $3a06
	ret z ; $3a07
	ld a, b ; $3a08
	ldh [c], a ; $3a09
	ldh a, [hSndPeriodHi] ; $3a0a
	ld c, $14 ; $3a0c
	call WriteChannelReg ; $3a0e
	jp ResetChannelLength ; $3a11
WriteChannelReg:
	ld b, a ; $3a14
	ld a, [wSndRegBase] ; $3a15
	add c ; $3a18
	ld c, a ; $3a19
	ld a, b ; $3a1a
	ldh [c], a ; $3a1b
	ret ; $3a1c
.writeChannelReg:
	ldh a, [hSndVolume] ; $3a1d
	ld c, $12 ; $3a1f
	jr WriteChannelReg ; $3a21
ResetChannelLength:
	ld c, $11 ; $3a23
	ld a, [wSndRegBase] ; $3a25
	add c ; $3a28
	ld c, a ; $3a29
	ldh a, [c] ; $3a2a
	and $c0 ; $3a2b
	ldh [c], a ; $3a2d
	ret ; $3a2e
.loop:
	ld a, e ; $3a2f
	srl a ; $3a30
	add $02 ; $3a32
	swap a ; $3a34
	ld hl, hSndVolume ; $3a36
	cp [hl] ; $3a39
	ret c ; $3a3a
	and $60 ; $3a3b
	ldh [rAUD3LEVEL], a ; $3a3d
	ret ; $3a3f
TickInstrumentEnvelope:
	call AbortIfChannelTriggered ; $3a40
	ldh a, [hSndPeriodHi] ; $3a43
	and $7f ; $3a45
	jp z, SndSilenceChannel ; $3a47
	ld a, [wSndChannelType] ; $3a4a
	cp SNDCHANTYPE_WAVE ; $3a4d
	jr z, .eq02 ; $3a4f
	ldh a, [hSndEnvRate] ; $3a51
	and a ; $3a53
	ret z ; $3a54
.eq02:
	ldh a, [hSndEnvLength] ; $3a55
	and a ; $3a57
	ret z ; $3a58
	ld e, $00 ; $3a59
	ld c, a ; $3a5b
	ldh a, [hSndEnvPos] ; $3a5c
	ld b, $04 ; $3a5e
.loop:
	add a ; $3a60
	cp c ; $3a61
	jr c, .carry ; $3a62
	sub c ; $3a64
.carry:
	ccf ; $3a65
	rl e ; $3a66
	dec b ; $3a68
	jr nz, .loop ; $3a69
	ld a, [wSndChannelType] ; $3a6b
	cp SNDCHANTYPE_WAVE ; $3a6e
	jr z, ResetChannelLength.loop ; $3a70
	ldh a, [hSndEnvRate] ; $3a72
	or e ; $3a74
	ld e, a ; $3a75
	ld d, $00 ; $3a76
	push de ; $3a78
	ldh a, [hSndInstrument] ; $3a79
	and $0f ; $3a7b
	ld de, SoundEnvelopeTable ; $3a7d
	sla a ; $3a80
	add e ; $3a82
	ld e, a ; $3a83
	ld a, $00 ; $3a84
	adc d ; $3a86
	ld d, a ; $3a87
	ld a, [de] ; $3a88
	ld l, a ; $3a89
	inc de ; $3a8a
	ld a, [de] ; $3a8b
	ld h, a ; $3a8c
	pop de ; $3a8d
	ld a, l ; $3a8e
	sub $10 ; $3a8f
	ld l, a ; $3a91
	ld a, h ; $3a92
	sbc $00 ; $3a93
	ld h, a ; $3a95
	add hl, de ; $3a96
	ldh a, [hSndVolume] ; $3a97
	swap a ; $3a99
	ld e, a ; $3a9b
	ld a, [hl] ; $3a9c
	ld h, a ; $3a9d
	and $f0 ; $3a9e
	or e ; $3aa0
	ld e, a ; $3aa1
	bit 2, h ; $3aa2
	jr nz, .checkDirection ; $3aa4
	inc b ; $3aa6
	ld a, c ; $3aa7
	swap a ; $3aa8
	and $0f ; $3aaa
	jr z, .checkDirection ; $3aac
	ld b, a ; $3aae
	bit 3, e ; $3aaf
	jr nz, .checkVolume ; $3ab1
	sla b ; $3ab3
	bit 2, e ; $3ab5
	jr nz, .checkVolume ; $3ab7
	sla b ; $3ab9
	bit 1, e ; $3abb
	jr z, .bit1Clear ; $3abd
.checkVolume:
	ld a, b ; $3abf
	cp $08 ; $3ac0
	jr c, .checkDirection ; $3ac2
.bit1Clear:
	ld b, $00 ; $3ac4
.checkDirection:
	bit 1, h ; $3ac6
	jr z, .combine ; $3ac8
	ld a, b ; $3aca
	jr z, .combine ; $3acb
	srl b ; $3acd
.combine:
	ld a, h ; $3acf
	and $08 ; $3ad0
	or b ; $3ad2
	ld b, a ; $3ad3
	bit 0, h ; $3ad4
	jr z, .bit0Clear ; $3ad6
	ld hl, SoundChannelMaskTable ; $3ad8
	add hl, de ; $3adb
	ld a, [hl] ; $3adc
	or b ; $3add
	jp ApplyChannelEnvelope ; $3ade
.bit0Clear:
	ld c, $12 ; $3ae1
	ld a, [wSndRegBase] ; $3ae3
	add c ; $3ae6
	ld c, a ; $3ae7
	ldh a, [c] ; $3ae8
	and $08 ; $3ae9
	ld l, a ; $3aeb
	ld a, h ; $3aec
	and $08 ; $3aed
	cp l ; $3aef
	ret z ; $3af0
	ld hl, SoundChannelMaskTable ; $3af1
	add hl, de ; $3af4
	ld a, [hl] ; $3af5
	or b ; $3af6
	jp ApplyChannelEnvelope ; $3af7

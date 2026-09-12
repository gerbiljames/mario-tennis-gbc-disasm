PlaySoundCmd:
	push af ; $2fb3
	push bc ; $2fb4
	push de ; $2fb5
	push hl ; $2fb6
	ld hl, sp + 8 ; $2fb7
	ld e, [hl] ; $2fb9
	inc hl ; $2fba
	ld d, [hl] ; $2fbb
	dec hl ; $2fbc
	ld a, [de] ; $2fbd
	inc de ; $2fbe
	ld [hl], e ; $2fbf
	inc hl ; $2fc0
	ld [hl], d ; $2fc1
.loop:
	cp $50 ; $2fc2
	jr nc, JingleSoundIds.ge50 ; $2fc4
	cp $40 ; $2fc6
	jr c, JingleSoundIds.lt40 ; $2fc8
	ld hl, hMusic ; $2fca
	bit 0, [hl] ; $2fcd
	jr nz, JingleSoundIds.restore ; $2fcf
	ldh [hActiveJingle], a ; $2fd1
	sub $40 ; $2fd3
	ld hl, JingleSoundIds ; $2fd5
	add l ; $2fd8
	ld l, a ; $2fd9
	jr nc, .read ; $2fda
	inc h ; $2fdc
.read:
	ld a, [hl] ; $2fdd
	jr JingleSoundIds.step3 ; $2fde
JingleSoundIds:
	INCLUDE "data/bank_000/JingleSoundIds.asm" ; $2fe0, 6 bytes (sound_data)
.lt40:
	ld d, a ; $2fe6
	ldh a, [hActiveJingle] ; $2fe7
	or a ; $2fe9
	ld a, d ; $2fea
	jr z, .zero ; $2feb
	ld hl, wCurrentBGM ; $2fed
	ld [hl], a ; $2ff0
	jr .restore ; $2ff1
.zero:
	ld hl, wCurrentBGM ; $2ff3
	cp [hl] ; $2ff6
	jr z, .restore ; $2ff7
	ld [hl], a ; $2ff9
.step3:
	ld hl, hMusic ; $2ffa
	bit 0, [hl] ; $2ffd
	jr nz, .restore ; $2fff
	ld h, a ; $3001
	ldh a, [hWramBank] ; $3002
	push af ; $3004
	ld a, h ; $3005
	call PlaySound ; $3006
	pop_wram_bank ; $3009
	jr .restore ; $300e
.ge50:
	ld h, a ; $3010
	ldh a, [hWramBank] ; $3011
	push af ; $3013
	ld a, h ; $3014
	call PlaySound ; $3015
	pop_wram_bank ; $3018
	jr .restore ; $301d
.restore:
	pop hl ; $301f
	pop de ; $3020
	pop bc ; $3021
	pop af ; $3022
	ret ; $3023
PlaySoundManaged:
	push af ; $3024
	push bc ; $3025
	push de ; $3026
	push hl ; $3027
	jr PlaySoundCmd.loop ; $3028
WaitJingleEnd:
	push af ; $302a
	push bc ; $302b
	push de ; $302c
	push hl ; $302d
	ldh a, [hActiveJingle] ; $302e
	or a ; $3030
	jr z, .restore ; $3031
.loop:
	call AdvanceFrame ; $3033
	ldh a, [hPlayerInputFlags] ; $3036
	or a ; $3038
	jr nz, .nonZero ; $3039
	ldh a, [hActiveJingle] ; $303b
	or a ; $303d
	jr nz, .loop ; $303e
.nonZero:
	xor a ; $3040
	ldh [hActiveJingle], a ; $3041
	ld hl, hMusic ; $3043
	bit 0, [hl] ; $3046
	jr nz, .restore ; $3048
	ldh a, [hWramBank] ; $304a
	push af ; $304c
	ld a, [wCurrentBGM] ; $304d
	call PlaySound ; $3050
	pop_wram_bank ; $3053
.restore:
	pop hl ; $3058
	pop de ; $3059
	pop bc ; $305a
	pop af ; $305b
	ret ; $305c
ResumeBGMAfterJingle:
	call CheckMusicChannelsIdle ; $305d
	ret nz ; $3060
	ldh a, [hActiveJingle] ; $3061
	or a ; $3063
	ret z ; $3064
	ld a, e ; $3065
	and $0f ; $3066
	ret nz ; $3068
	xor a ; $3069
	ldh [hActiveJingle], a ; $306a
	ld hl, hMusic ; $306c
	bit 0, [hl] ; $306f
	ret nz ; $3071
	ld a, [wCurrentBGM] ; $3072
	jp PlaySound ; $3075
InitAudioEngine:
	wram_bank WRAM_SOUND ; $3078
	ld bc, $0000 ; $307e
	call SetChannelUpdateRequest ; $3081
	ld a, $80 ; $3084
	ldh [rAUDENA], a ; $3086
	xor a ; $3088
	ldh [rAUDTERM], a ; $3089
	ld [wSndPanShadow], a ; $308b
	ld a, $77 ; $308e
	ldh [rAUDVOL], a ; $3090
	ld hl, wSndChannels ; $3092
	ld b, $06 ; $3095
	ld a, $ff ; $3097
.loop:
	ld [hl+], a ; $3099
	ld [hl-], a ; $309a
	ld de, $0020 ; $309b
	add hl, de ; $309e
	dec b ; $309f
	jr nz, .loop ; $30a0
	ld hl, wSndLoopSlots ; $30a2
	ld b, $48 ; $30a5
	xor a ; $30a7
.loopB:
	ld [hl+], a ; $30a8
	dec b ; $30a9
	jr nz, .loopB ; $30aa
	xor a ; $30ac
	ld [wSndFirstChannel], a ; $30ad
	ld [wSndWaveReloadPending], a ; $30b0
	ret ; $30b3
SetChannelUpdateRequest:
	ld a, b ; $30b4
	ld [wSndUpdateReqMask], a ; $30b5
	ld a, c ; $30b8
	ld [wSndUpdateReqData], a ; $30b9
	xor a ; $30bc
	ld [wSndUpdateReqAck], a ; $30bd
	ret ; $30c0
MarkCurrentChannelUpdated:
	ld a, [wSndChannelIndex] ; $30c1
	inc a ; $30c4
	ld b, a ; $30c5
	ld a, $01 ; $30c6
.loop:
	dec b ; $30c8
	jr z, .countDone ; $30c9
	add a ; $30cb
	jr .loop ; $30cc
.countDone:
	ld b, a ; $30ce
	ld a, [wSndUpdateReqAck] ; $30cf
	or b ; $30d2
	ld [wSndUpdateReqAck], a ; $30d3
	ret ; $30d6
ApplyChannelUpdateRequest:
	ld a, [wSndUpdateReqAck] ; $30d7
	ld hl, wSndUpdateReqMask ; $30da
	and [hl] ; $30dd
	cp [hl] ; $30de
	jr nz, .clearSndUpdateReqAck ; $30df
	ld hl, wSndChannels + 6 ; $30e1
	ld a, [wSndUpdateReqData] ; $30e4
	and $0f ; $30e7
	ld b, a ; $30e9
	ld a, [wSndUpdateReqMask] ; $30ea
.loop:
	srl a ; $30ed
	ld [wSndUpdateReqAck], a ; $30ef
	jr nc, .noCarry ; $30f2
	ld a, [hl] ; $30f4
	and $f0 ; $30f5
	or b ; $30f7
	ld [hl], a ; $30f8
.noCarry:
	ld a, l ; $30f9
	add $20 ; $30fa
	ld l, a ; $30fc
	ld a, h ; $30fd
	adc $00 ; $30fe
	ld h, a ; $3100
	ld a, [wSndUpdateReqAck] ; $3101
	and a ; $3104
	jr nz, .loop ; $3105
	xor a ; $3107
	ld [wSndUpdateReqMask], a ; $3108
.clearSndUpdateReqAck:
	xor a ; $310b
	ld [wSndUpdateReqAck], a ; $310c
	ret ; $310f
CheckMusicChannelsIdle:
	wram_bank WRAM_SOUND ; $3110
	ld hl, wSndChannels + 64 ; $3116
	ld de, $0020 ; $3119
	ld b, $04 ; $311c
.loop:
	ld a, [hl+] ; $311e
	inc a ; $311f
	ret nz ; $3120
	ld a, [hl-] ; $3121
	inc a ; $3122
	ret nz ; $3123
	add hl, de ; $3124
	dec b ; $3125
	jr nz, .loop ; $3126
	ret ; $3128
StopMusic:
	push af ; $3129
	push bc ; $312a
	push de ; $312b
	push hl ; $312c
	wram_bank WRAM_SOUND ; $312d
	ld a, $ff ; $3133
	ld hl, wSndChannels + 64 ; $3135
	ld de, $0020 ; $3138
	ld b, $04 ; $313b
.loop:
	ld [hl+], a ; $313d
	ld [hl-], a ; $313e
	add hl, de ; $313f
	dec b ; $3140
	jr nz, .loop ; $3141
	ld hl, wSndLoopSlots + 24 ; $3143
	ld bc, $0030 ; $3146
	call ClearBytes ; $3149
	pop hl ; $314c
	pop de ; $314d
	pop bc ; $314e
	pop af ; $314f
	ret ; $3150
MusicIndexTable:
	INCLUDE "data/bank_000/MusicIndexTable.asm" ; $3151, 100 bytes (sound_index)
SfxIndexTable:
	INCLUDE "data/bank_000/SfxIndexTable.asm" ; $31b5, 226 bytes (sound_index)
PlaySound:
	and a ; $3297
	jp z, StopMusic ; $3298
	push bc ; $329b
	push de ; $329c
	push hl ; $329d
	ld hl, MusicIndexTable ; $329e
	cp $50 ; $32a1
	jr c, .music ; $32a3
	ld hl, SfxIndexTable ; $32a5
	push af ; $32a8
	push hl ; $32a9
	wram_bank WRAM_SOUND ; $32aa
	ld a, $ff ; $32b0
	ld hl, wSndChannels ; $32b2
	ld [hl+], a ; $32b5
	ld [hl], a ; $32b6
	ld hl, wSndChannels + 32 ; $32b7
	ld [hl+], a ; $32ba
	ld [hl], a ; $32bb
	ld hl, wSndLoopSlots ; $32bc
	ld bc, $0018 ; $32bf
	call ClearBytes ; $32c2
	pop hl ; $32c5
	pop af ; $32c6
	sub $50 ; $32c7
	jr nz, .lookupEntry ; $32c9
	pop hl ; $32cb
	pop de ; $32cc
	pop bc ; $32cd
	ret ; $32ce
.music:
	call StopMusic ; $32cf
.lookupEntry:
	dec a ; $32d2
	add a ; $32d3
	jr nc, .addIndex ; $32d4
	inc h ; $32d6
.addIndex:
	add l ; $32d7
	ld l, a ; $32d8
	jr nc, .startChannels ; $32d9
	inc h ; $32db
.startChannels:
	ldh a, [hRomBank] ; $32dc
	push af ; $32de
	ld a, [hl] ; $32df
	and $0f ; $32e0
	or $70 ; $32e2
	ldh [hRomBank], a ; $32e4
	ld [rROMB0], a ; $32e6
	ld a, [hl+] ; $32e9
	swap a ; $32ea
	and $0f ; $32ec
	ld b, a ; $32ee
	ld l, [hl] ; $32ef
	ld h, $00 ; $32f0
	add hl, hl ; $32f2
	add hl, hl ; $32f3
	set 6, h ; $32f4
	ld e, l ; $32f6
	ld d, h ; $32f7
	di ; $32f8
.channelLoop:
	push bc ; $32f9
	push de ; $32fa
	call StartSoundChannel ; $32fb
	pop de ; $32fe
	ld hl, $0004 ; $32ff
	add hl, de ; $3302
	ld e, l ; $3303
	ld d, h ; $3304
	pop bc ; $3305
	dec b ; $3306
	jr nz, .channelLoop ; $3307
	ei ; $3309
	pop af ; $330a
	ldh [hRomBank], a ; $330b
	ld [rROMB0], a ; $330d
	pop hl ; $3310
	pop de ; $3311
	pop bc ; $3312
	ret ; $3313
StartSoundChannel:
	ld a, [de] ; $3314
	inc de ; $3315
	ld c, a ; $3316
	ld b, $00 ; $3317
	ld hl, wSndChannels ; $3319
	add hl, bc ; $331c
	ld a, [hl] ; $331d
	cp $ff ; $331e
	jr z, .eqff ; $3320
	inc hl ; $3322
	ld a, [hl-] ; $3323
	ld b, $ee ; $3324
	and $03 ; $3326
	jr z, .checkSndPanShadow ; $3328
	ld b, $dd ; $332a
	cp $01 ; $332c
	jr z, .checkSndPanShadow ; $332e
	ld b, $bb ; $3330
	cp $02 ; $3332
	jr z, .checkSndPanShadow ; $3334
	ld b, $77 ; $3336
.checkSndPanShadow:
	ld a, [wSndPanShadow] ; $3338
	and b ; $333b
	ld [wSndPanShadow], a ; $333c
.eqff:
	xor a ; $333f
	ld [hl+], a ; $3340
	ld [hl+], a ; $3341
	ld a, [de] ; $3342
	inc de ; $3343
	ld [hl+], a ; $3344
	ld a, [de] ; $3345
	inc de ; $3346
	ld [hl+], a ; $3347
	ld a, [de] ; $3348
	inc de ; $3349
	ld [hl+], a ; $334a
	ldh a, [hRomBank] ; $334b
	ld [hl], a ; $334d
	inc hl ; $334e
	inc hl ; $334f
	inc hl ; $3350
	inc hl ; $3351
	inc hl ; $3352
	ld a, $ff ; $3353
	ld [hl+], a ; $3355
	xor a ; $3356
	push de ; $3357
	ld de, $000e ; $3358
	add hl, de ; $335b
	pop de ; $335c
	push hl ; $335d
	ld [hl+], a ; $335e
	ld [hl+], a ; $335f
	ld [hl-], a ; $3360
	dec hl ; $3361
	dec hl ; $3362
	dec hl ; $3363
	dec hl ; $3364
	dec hl ; $3365
	ld [hl-], a ; $3366
	ld [hl], $80 ; $3367
	pop hl ; $3369
	inc hl ; $336a
	inc hl ; $336b
	inc hl ; $336c
	xor a ; $336d
	ld [hl+], a ; $336e
	ld [hl+], a ; $336f
	ld [hl+], a ; $3370
	ld [hl+], a ; $3371
	ret ; $3372
; Runs the sound driver over a 32-byte window of HRAM ($ffd0-$ffef) that four
; other subsystems also use. It copies the whole window out to $d000 in WRAM
; bank $07 on entry and copies it back on exit, so the pool is context-switched
; rather than merely time-shared: a value living there survives an audio update
; untouched. That is what lets hMatchFrameCounter and hSoundEngineBusy share
; bytes with the driver's channel state.
RunSoundEngine:
	wram_bank WRAM_SOUND ; $3373
	ld hl, hSndScriptPtr ; $3379
	ld de, wSndHramSave ; $337c
	ld c, $02 ; $337f
	call CopyMemoryFast ; $3381
	call UpdateSoundChannels ; $3384
	ld hl, wSndHramSave ; $3387
	ld de, hSndScriptPtr ; $338a
	ld c, $02 ; $338d
	jp CopyMemoryFast ; $338f
UpdateSoundChannels:
	ldh a, [hRomBank] ; $3392
	push af ; $3394
	ld a, [wSndFirstChannel] ; $3395
	ld [wSndChannelIndex], a ; $3398
	xor a ; $339b
	ld [wSndActiveMask], a ; $339c
	ld hl, wSndFrameCounter ; $339f
	inc [hl] ; $33a2
	ld hl, wSndChannels ; $33a3
.loop:
	ld a, [hl+] ; $33a6
	ld b, a ; $33a7
	ld a, [hl-] ; $33a8
	and b ; $33a9
	inc a ; $33aa
	jp z, .countDone ; $33ab
	push hl ; $33ae
	ld de, hSndScriptPtr ; $33af
	ld c, $02 ; $33b2
	call CopyMemoryFast ; $33b4
	ldh a, [hSndDataBank] ; $33b7
	ldh [hRomBank], a ; $33b9
	ld [rROMB0], a ; $33bb
	ldh a, [hSndChannelType] ; $33be
	and $03 ; $33c0
	ld [wSndChannelType], a ; $33c2
	ld b, a ; $33c5
	add a ; $33c6
	add a ; $33c7
	add b ; $33c8
	ld [wSndRegBase], a ; $33c9
	inc b ; $33cc
	ld a, $88 ; $33cd
.loopB:
	rlca ; $33cf
	dec b ; $33d0
	jr nz, .loopB ; $33d1
	ld [wSndChannelBits], a ; $33d3
	ld [wSndChannelPanMask], a ; $33d6
	ldh a, [hSndScriptPtr] ; $33d9
	ld b, a ; $33db
	ldh a, [hSndScriptPtr + 1] ; $33dc
	or b ; $33de
	and a ; $33df
	jp z, .zero2 ; $33e0
	call TickVibrato ; $33e3
	call TickInstrumentEnvelope ; $33e6
	ldh a, [hSndEnvLength] ; $33e9
	ld b, a ; $33eb
	ldh a, [hSndEnvPos] ; $33ec
	inc a ; $33ee
	cp b ; $33ef
	jr c, .store ; $33f0
	ld a, b ; $33f2
.store:
	ldh [hSndEnvPos], a ; $33f3
	ld hl, hSndLengthAccum ; $33f5
	ldh a, [hSndToneCtrl] ; $33f8
	and $0f ; $33fa
	add [hl] ; $33fc
	cp $10 ; $33fd
	jr c, .store2 ; $33ff
	sub $10 ; $3401
	ld [hl], a ; $3403
	jr .checkSndWaveReloadPending ; $3404
.store2:
	ld [hl], a ; $3406
	call TickVolumeSlide ; $3407
	ldh a, [hSndNoteLenTimer] ; $340a
	and a ; $340c
	jr z, .zero ; $340d
	dec a ; $340f
	ldh [hSndNoteLenTimer], a ; $3410
.zero:
	ldh a, [hSndPortamentoTimer] ; $3412
	and a ; $3414
	jr nz, .nonZero ; $3415
	ldh a, [hSndEchoCtrl] ; $3417
	and $f0 ; $3419
	jr z, .loop2 ; $341b
	ld hl, hSndEchoTimer ; $341d
	dec [hl] ; $3420
	jr nz, .countLeft ; $3421
	ldh a, [hSndEcho] ; $3423
	and $f0 ; $3425
	ld c, a ; $3427
	ldh a, [hSndVolume] ; $3428
	and $0f ; $342a
	or c ; $342c
	ldh [hSndVolume], a ; $342d
.loop2:
	call MarkCurrentChannelUpdated ; $342f
.loop3:
	ldh a, [hSndNoteLenReload] ; $3432
	ldh [hSndNoteLenTimer], a ; $3434
	call RunSoundChannelScript ; $3436
	jr .checkSndWaveReloadPending ; $3439
.countLeft:
	ldh a, [hSndEchoCtrl] ; $343b
	and $0f ; $343d
	dec a ; $343f
	cp [hl] ; $3440
	jr nz, .checkSndWaveReloadPending ; $3441
	call ScaleEchoVolume ; $3443
	ldh a, [hSndVolume] ; $3446
	call ApplyChannelEnvelope ; $3448
	jr .checkSndWaveReloadPending ; $344b
.nonZero:
	dec a ; $344d
	ldh [hSndPortamentoTimer], a ; $344e
	push af ; $3450
	ldh a, [hSndRestFlag] ; $3451
	or a ; $3453
	jr z, .restore ; $3454
	dec a ; $3456
	ldh [hSndRestFlag], a ; $3457
.restore:
	pop af ; $3459
	jr nz, .checkSndWaveReloadPending ; $345a
	ldh a, [hSndEchoCtrl] ; $345c
	and $f0 ; $345e
	jr nz, .checkSndWaveReloadPending ; $3460
	jr .loop2 ; $3462
.checkSndWaveReloadPending:
	ld a, [wSndWaveReloadPending] ; $3464
	and a ; $3467
	jr z, .checkSndChannelBits ; $3468
	ld a, [wSndChannelType] ; $346a
	cp SNDCHANTYPE_WAVE ; $346d
	jr nz, .checkSndChannelBits ; $346f
	ld a, [wSndChannelIndex] ; $3471
	cp $02 ; $3474
	jr c, .checkSndChannelBits ; $3476
	ld a, [wSndChannelBits] ; $3478
	ld b, a ; $347b
	ld a, [wSndActiveMask] ; $347c
	and b ; $347f
	jr nz, .checkSndChannelBits ; $3480
	ld a, [wSndLoadedWaveId] ; $3482
	ld b, a ; $3485
	ldh a, [hSndWaveId] ; $3486
	cp b ; $3488
	jr z, .checkSndChannelBits ; $3489
	ld e, a ; $348b
	ld [wSndLoadedWaveId], a ; $348c
	swap e ; $348f
	xor a ; $3491
	ld [wSndWaveReloadPending], a ; $3492
	ldh [rAUD3ENA], a ; $3495
	ld d, a ; $3497
	call LoadWavePattern ; $3498
	ld a, $80 ; $349b
	ldh [rAUD3ENA], a ; $349d
.checkSndChannelBits:
	ld a, [wSndChannelBits] ; $349f
	ld b, a ; $34a2
	ld a, [wSndActiveMask] ; $34a3
	or b ; $34a6
	ld [wSndActiveMask], a ; $34a7
	pop hl ; $34aa
	push hl ; $34ab
	ld e, l ; $34ac
	ld d, h ; $34ad
	ld c, $02 ; $34ae
	ld hl, hSndScriptPtr ; $34b0
	call CopyMemoryFast ; $34b3
	pop hl ; $34b6
.countDone:
	ld de, $0020 ; $34b7
	add hl, de ; $34ba
	ld a, [wSndChannelIndex] ; $34bb
	inc a ; $34be
	ld [wSndChannelIndex], a ; $34bf
	cp $06 ; $34c2
	jp c, .loop ; $34c4
	ld a, [wSndActiveMask] ; $34c7
	ld b, a ; $34ca
	ld a, [wSndPanShadow] ; $34cb
	and b ; $34ce
	ld [wSndPanShadow], a ; $34cf
	ldh [rAUDTERM], a ; $34d2
	pop af ; $34d4
	ldh [hRomBank], a ; $34d5
	ld [rROMB0], a ; $34d7
	jp ApplyChannelUpdateRequest ; $34da
.zero2:
	ldh a, [hSndDataPtr] ; $34dd
.step6:
	ld l, a ; $34df
	ldh a, [hSndDataPtr + 1] ; $34e0
	ld h, a ; $34e2
	ld a, [hl+] ; $34e3
	and $0f ; $34e4
	ld d, a ; $34e6
	ldh [hSndLengthAccum], a ; $34e7
	ld a, [wSndChannelType] ; $34e9
	cp SNDCHANTYPE_WAVE ; $34ec
	jr z, .read ; $34ee
	ld a, [hl+] ; $34f0
	rrca ; $34f1
	rrca ; $34f2
	and $c0 ; $34f3
	or d ; $34f5
.loop4:
	ldh [hSndToneCtrl], a ; $34f6
	ld a, [hl+] ; $34f8
	swap a ; $34f9
	ldh [hSndVolume], a ; $34fb
	ld a, [wSndChannelType] ; $34fd
	cp SNDCHANTYPE_WAVE ; $3500
	jr z, .eq02 ; $3502
	ld a, [hl+] ; $3504
	ldh [hSndWaveId], a ; $3505
.loop5:
	ld a, $ff ; $3507
	ldh [hSndNoteOffset], a ; $3509
	xor a ; $350b
	ldh [hSndTranspose], a ; $350c
	ldh [hSndEnvRate], a ; $350e
	ldh [hSndVolSlide], a ; $3510
	ldh [hSndScriptPtr + 1], a ; $3512
	dec a ; $3514
	ldh [hSndPanMask], a ; $3515
	ld a, $02 ; $3517
	ldh [hSndScriptPtr], a ; $3519
	jp .loop3 ; $351b
.read:
	ld a, [hl+] ; $351e
	ldh [hSndEnvLength], a ; $351f
	ld a, d ; $3521
	jr .loop4 ; $3522
.eq02:
	xor a ; $3524
	ldh [rAUD3ENA], a ; $3525
	ld d, a ; $3527
	ldh a, [hSndWaveId] ; $3528
	ld e, a ; $352a
	cp $ff ; $352b
	jr nz, .store3 ; $352d
	ld e, [hl] ; $352f
	ld a, e ; $3530
	ldh [hSndWaveId], a ; $3531
.store3:
	ld [wSndLoadedWaveId], a ; $3533
	swap e ; $3536
	ld hl, WavePatternTable ; $3538
	push de ; $353b
	ldh a, [hSndInstrument] ; $353c
	swap a ; $353e
	and $0f ; $3540
	add a ; $3542
	ld e, a ; $3543
	ld d, $00 ; $3544
	add hl, de ; $3546
	ld a, [hl+] ; $3547
	ld h, [hl] ; $3548
	ld l, a ; $3549
	pop de ; $354a
	add hl, de ; $354b
	ld c, LOW(_AUD3WAVERAM) ; $354c
	ld b, $10 ; $354e
.loop6:
	ld a, [hl+] ; $3550
	ldh [c], a ; $3551
	inc c ; $3552
	dec b ; $3553
	jr nz, .loop6 ; $3554
	jr .loop5 ; $3556
RunSoundChannelScript:
	ldh a, [hSndScriptPtr] ; $3558
	ld l, a ; $355a
	ldh a, [hSndScriptPtr + 1] ; $355b
	ld h, a ; $355d
	add hl, hl ; $355e
	ldh a, [hSndDataPtr] ; $355f
	ld e, a ; $3561
	ldh a, [hSndDataPtr + 1] ; $3562
	ld d, a ; $3564
	add hl, de ; $3565
.nextCommand:
	ldh a, [hSndScriptPtr] ; $3566
	add $01 ; $3568
	ldh [hSndScriptPtr], a ; $356a
	ldh a, [hSndScriptPtr + 1] ; $356c
	adc $00 ; $356e
	ldh [hSndScriptPtr + 1], a ; $3570
	ld a, [hl+] ; $3572
	cp $d0 ; $3573
	jr nc, .cmdD0 ; $3575
	cp $b0 ; $3577
	jp nc, .cmdB0 ; $3579
	cp $a0 ; $357c
	jp nc, .cmdA0 ; $357e
	jp SndTriggerNote ; $3581
.cmdF0:
	cp $fd ; $3584
	jr z, .setLoopPoint ; $3586
	cp $ff ; $3588
	jr z, .endScript ; $358a
	jr .skipOperand ; $358c
.setLoopPoint:
	push hl ; $358e
	ld b, [hl] ; $358f
	call GetChannelLoopSlot ; $3590
	xor a ; $3593
	ld [hl+], a ; $3594
	ldh a, [hSndScriptPtr] ; $3595
	ld [hl+], a ; $3597
	ldh a, [hSndScriptPtr + 1] ; $3598
	ld [hl], a ; $359a
	pop hl ; $359b
.skipOperand:
	inc hl ; $359c
	jr .nextCommand ; $359d
.endScript:
	ldh [hSndScriptPtr], a ; $359f
	ldh [hSndScriptPtr + 1], a ; $35a1
	ld a, [wSndChannelType] ; $35a3
	cp SNDCHANTYPE_WAVE ; $35a6
	jr nz, .release ; $35a8
	ld a, [wSndChannelIndex] ; $35aa
	cp $02 ; $35ad
	jr nc, .release ; $35af
	ld a, $ff ; $35b1
	ld [wSndWaveReloadPending], a ; $35b3
.release:
	jp SndReleaseChannel ; $35b6
.cmdD0:
	cp $f0 ; $35b9
	jr nc, .cmdF0 ; $35bb
	cp $e0 ; $35bd
	jr nc, .volSlideDown ; $35bf
	and $0f ; $35c1
	jr .storeVolSlide ; $35c3
.volSlideDown:
	and $0f ; $35c5
	cpl ; $35c7
	inc a ; $35c8
.storeVolSlide:
	ld b, a ; $35c9
	ld a, [wSndChannelType] ; $35ca
	cp SNDCHANTYPE_WAVE ; $35cd
	jr z, .volSlideDone ; $35cf
	ld a, b ; $35d1
	ldh [hSndVolSlide], a ; $35d2
	ld a, [hl] ; $35d4
	ldh [hSndVolSlideReload], a ; $35d5
	ldh [hSndVolSlideTimer], a ; $35d7
.volSlideDone:
	inc hl ; $35d9
	jp .nextCommand ; $35da
.cmdC0:
	and $0f ; $35dd
	ld b, a ; $35df
	ld a, [wSndChannelType] ; $35e0
	cp SNDCHANTYPE_WAVE ; $35e3
	jr z, .envelopeDone ; $35e5
	ldh a, [hSndVolume] ; $35e7
	and $0f ; $35e9
	jr nz, .envelopeDone ; $35eb
	ld a, [hl] ; $35ed
	ldh [hSndEnvLength], a ; $35ee
	ld a, b ; $35f0
	swap a ; $35f1
	ldh [hSndEnvRate], a ; $35f3
.envelopeDone:
	inc hl ; $35f5
	jp .nextCommand ; $35f6
.cmdB0:
	cp $c0 ; $35f9
	jr nc, .cmdC0 ; $35fb
	and $0f ; $35fd
	jp z, .loopSlotJump ; $35ff
	ld e, a ; $3602
	ld b, [hl] ; $3603
	push hl ; $3604
	call GetChannelLoopSlot ; $3605
	inc [hl] ; $3608
	ld a, [hl+] ; $3609
	inc e ; $360a
	cp e ; $360b
	jr nc, .loopNotTaken ; $360c
	ld a, [hl+] ; $360e
	ldh [hSndScriptPtr], a ; $360f
	ld a, [hl] ; $3611
	ldh [hSndScriptPtr + 1], a ; $3612
.loopNotTaken:
	pop hl ; $3614
	jp RunSoundChannelScript ; $3615
.loopSlotJump:
	ld a, [hl] ; $3618
	ld b, a ; $3619
	and $f0 ; $361a
	cp $f0 ; $361c
	jp nz, .skipByte ; $361e
	ld b, [hl] ; $3621
	push hl ; $3622
	call GetChannelLoopSlot ; $3623
	inc hl ; $3626
	ld a, [hl+] ; $3627
	ldh [hSndScriptPtr], a ; $3628
	ld a, [hl] ; $362a
	ldh [hSndScriptPtr + 1], a ; $362b
	pop hl ; $362d
	jp RunSoundChannelScript ; $362e
.skipByte:
	inc hl ; $3631
	jp .nextCommand ; $3632
.cmdA0:
	cp $a0 ; $3635
	jr nz, .setWaveId ; $3637
	ld a, [hl+] ; $3639
	swap a ; $363a
	ldh [hSndVolume], a ; $363c
	ld a, [wSndChannelBits] ; $363e
	ld b, a ; $3641
	ld a, [wSndActiveMask] ; $3642
	and b ; $3645
	jp nz, .nextCommand ; $3646
	call ApplyChannelEnvelope ; $3649
	jp .nextCommand ; $364c
.setWaveId:
	cp $a1 ; $364f
	jr nz, .setDuty ; $3651
	ld a, [wSndChannelType] ; $3653
	cp SNDCHANTYPE_WAVE ; $3656
	jr z, .loadWave ; $3658
	ld a, [hl+] ; $365a
	ldh [hSndWaveId], a ; $365b
	jp .nextCommand ; $365d
.loadWave:
	ld a, [hl+] ; $3660
	ld e, a ; $3661
	ldh [hSndWaveId], a ; $3662
	ld a, [wSndChannelBits] ; $3664
	ld b, a ; $3667
	ld a, [wSndActiveMask] ; $3668
	and b ; $366b
	jr z, .uploadWave ; $366c
	jp .nextCommand ; $366e
.uploadWave:
	xor a ; $3671
	ldh [rAUD3ENA], a ; $3672
	ld d, a ; $3674
	push hl ; $3675
	ld a, e ; $3676
	ld [wSndLoadedWaveId], a ; $3677
	swap e ; $367a
	ld hl, WavePatternTable ; $367c
	push de ; $367f
	ldh a, [hSndInstrument] ; $3680
	swap a ; $3682
	and $0f ; $3684
	add a ; $3686
	ld e, a ; $3687
	ld d, $00 ; $3688
	add hl, de ; $368a
	ld a, [hl+] ; $368b
	ld h, [hl] ; $368c
	ld l, a ; $368d
	pop de ; $368e
	add hl, de ; $368f
	ld c, LOW(_AUD3WAVERAM) ; $3690
	ld b, $10 ; $3692
.waveCopyLoop:
	ld a, [hl+] ; $3694
	ldh [c], a ; $3695
	inc c ; $3696
	dec b ; $3697
	jr nz, .waveCopyLoop ; $3698
	pop hl ; $369a
	jp .nextCommand ; $369b
.setDuty:
	cp $a2 ; $369e
	jr nz, .setNoteLength ; $36a0
	ld a, [wSndChannelType] ; $36a2
	cp SNDCHANTYPE_WAVE ; $36a5
	jr z, .setEnvLength ; $36a7
	ld a, [hl+] ; $36a9
	rrca ; $36aa
	rrca ; $36ab
	and $c0 ; $36ac
	ld d, a ; $36ae
	ldh a, [hSndToneCtrl] ; $36af
	and $3f ; $36b1
	or d ; $36b3
	ldh [hSndToneCtrl], a ; $36b4
	jp .nextCommand ; $36b6
.setEnvLength:
	ld a, [hl+] ; $36b9
	ldh [hSndEnvLength], a ; $36ba
	jp .nextCommand ; $36bc
.setNoteLength:
	cp $a3 ; $36bf
	cp $a3 ; $36c1
	jr nz, .setNoteOffset ; $36c3
	ld a, [hl+] ; $36c5
	cp $fe ; $36c6
	jr z, .clearNoteLength ; $36c8
	ld b, a ; $36ca
	and $0f ; $36cb
	add a ; $36cd
	ldh [hSndNoteLenReload], a ; $36ce
	ldh [hSndNoteLenTimer], a ; $36d0
	ld a, b ; $36d2
	add $10 ; $36d3
	and $f0 ; $36d5
	ld e, a ; $36d7
	ldh a, [hSndChannelType] ; $36d8
	and $0f ; $36da
	or e ; $36dc
.storeChannelType:
	ldh [hSndChannelType], a ; $36dd
	jp .nextCommand ; $36df
.clearNoteLength:
	ldh a, [hSndChannelType] ; $36e2
	and $0f ; $36e4
	jr .storeChannelType ; $36e6
.setNoteOffset:
	cp $a4 ; $36e8
	jr nz, .setPan ; $36ea
	ld a, [hl+] ; $36ec
	ldh [hSndNoteOffset], a ; $36ed
	jp .nextCommand ; $36ef
.setPan:
	cp $a5 ; $36f2
	jr nz, .setMasterVolume ; $36f4
	ld a, [hl+] ; $36f6
	cp $01 ; $36f7
	jr nz, .storePan ; $36f9
	ldh a, [hSndPanMask] ; $36fb
	swap a ; $36fd
.storePan:
	ldh [hSndPanMask], a ; $36ff
	jp .nextCommand ; $3701
.setMasterVolume:
	cp $a6 ; $3704
	jr nz, .setPortamento ; $3706
	ld a, [hl+] ; $3708
	ldh [rAUDVOL], a ; $3709
	jp .nextCommand ; $370b
.setPortamento:
	cp $a7 ; $370e
	jr nz, .setInstrument ; $3710
	ld a, [hl] ; $3712
	ldh [hSndPortamentoTimer], a ; $3713
	jp SndTriggerNote.checkSndChannelPanMask ; $3715
.setInstrument:
	cp $a8 ; $3718
	jr nz, .transpose ; $371a
	ld a, [hl+] ; $371c
	ld c, a ; $371d
	and $0f ; $371e
	ld b, a ; $3720
	ld a, c ; $3721
	and $f0 ; $3722
	or b ; $3724
	ldh [hSndInstrument], a ; $3725
	jp .nextCommand ; $3727
.transpose:
	cp $a9 ; $372a
	jp nz, .setEcho ; $372c
	ld a, [hl+] ; $372f
	cp $f0 ; $3730
	jr z, .transposeInc ; $3732
	cp $f1 ; $3734
	jr z, .transposeDec ; $3736
	cp $f2 ; $3738
	jr z, .globalTransposeInc ; $373a
	cp $f3 ; $373c
	jr z, .globalTransposeDec ; $373e
	cp $fe ; $3740
	jr z, .transposeFromGlobal ; $3742
	cp $ff ; $3744
	jr nz, .setTranspose ; $3746
	ldh a, [hSndTranspose] ; $3748
	jr .transposeJumpTable ; $374a
.transposeFromGlobal:
	ld a, [wSndTranspose] ; $374c
.transposeJumpTable:
	sla a ; $374f
	add l ; $3751
	ld l, a ; $3752
	ld a, h ; $3753
	adc $00 ; $3754
	ld h, a ; $3756
	ld a, [hl+] ; $3757
	ldh [hSndScriptPtr], a ; $3758
	ld a, [hl] ; $375a
	ldh [hSndScriptPtr + 1], a ; $375b
	jp RunSoundChannelScript ; $375d
.setTranspose:
	cp $80 ; $3760
	jr nc, .setGlobalTranspose ; $3762
	ldh [hSndTranspose], a ; $3764
	jp .nextCommand ; $3766
.setGlobalTranspose:
	sub $80 ; $3769
	ld [wSndTranspose], a ; $376b
	jp .nextCommand ; $376e
.transposeInc:
	ldh a, [hSndTranspose] ; $3771
	inc a ; $3773
	ldh [hSndTranspose], a ; $3774
	jp .nextCommand ; $3776
.transposeDec:
	ldh a, [hSndTranspose] ; $3779
	dec a ; $377b
	ldh [hSndTranspose], a ; $377c
	jp .nextCommand ; $377e
.globalTransposeInc:
	ld a, [wSndTranspose] ; $3781
	inc a ; $3784
	ld [wSndTranspose], a ; $3785
	jp .nextCommand ; $3788
.globalTransposeDec:
	ld a, [wSndTranspose] ; $378b
	dec a ; $378e
	ld [wSndTranspose], a ; $378f
	jp .nextCommand ; $3792
.setEcho:
	cp $aa ; $3795
	jr nz, .loopBlock ; $3797
	ld a, [hl+] ; $3799
	ld c, a ; $379a
	and $f0 ; $379b
	jr z, .clearEcho ; $379d
	swap a ; $379f
	ldh [hSndEchoTimer], a ; $37a1
	or $f0 ; $37a3
	ldh [hSndEchoCtrl], a ; $37a5
	ld a, c ; $37a7
	and $0f ; $37a8
	ld c, a ; $37aa
	ldh a, [hSndEcho] ; $37ab
	and $f0 ; $37ad
	or c ; $37af
	ldh [hSndEcho], a ; $37b0
	jp .nextCommand ; $37b2
.clearEcho:
	xor a ; $37b5
	ldh [hSndEchoTimer], a ; $37b6
	ldh [hSndEcho], a ; $37b8
	ldh [hSndEchoCtrl], a ; $37ba
	jp .nextCommand ; $37bc
.loopBlock:
	cp $ac ; $37bf
	jr nz, .loopReturn ; $37c1
	ldh a, [hSndLoopCount] ; $37c3
	sub $01 ; $37c5
	jr z, .loopFinished ; $37c7
	jr nc, .storeLoopCount ; $37c9
	ld a, [hl] ; $37cb
.storeLoopCount:
	ldh [hSndLoopCount], a ; $37cc
	ldh a, [hSndScriptPtr] ; $37ce
	sub $01 ; $37d0
	ldh [hSndLoopReturnPtr], a ; $37d2
	ldh a, [hSndScriptPtr + 1] ; $37d4
	sbc $00 ; $37d6
	ldh [hSndLoopReturnPtr + 1], a ; $37d8
	inc hl ; $37da
	ld a, [hl+] ; $37db
	ld h, [hl] ; $37dc
	ld l, a ; $37dd
	srl h ; $37de
	rr l ; $37e0
	ld a, l ; $37e2
	ldh [hSndScriptPtr], a ; $37e3
	ld a, h ; $37e5
	ldh [hSndScriptPtr + 1], a ; $37e6
	jp RunSoundChannelScript ; $37e8
.loopFinished:
	xor a ; $37eb
	ldh [hSndLoopCount], a ; $37ec
	ldh a, [hSndScriptPtr] ; $37ee
	add $01 ; $37f0
	ldh [hSndScriptPtr], a ; $37f2
	ldh a, [hSndScriptPtr + 1] ; $37f4
	adc $00 ; $37f6
	ldh [hSndScriptPtr + 1], a ; $37f8
	jp RunSoundChannelScript ; $37fa
.loopReturn:
	cp $ad ; $37fd
	jr nz, .setSweepFlag ; $37ff
	ldh a, [hSndLoopReturnPtr] ; $3801
	ldh [hSndScriptPtr], a ; $3803
	ldh a, [hSndLoopReturnPtr + 1] ; $3805
	ldh [hSndScriptPtr + 1], a ; $3807
	jp RunSoundChannelScript ; $3809
.setSweepFlag:
	cp $ae ; $380c
	jr nz, .setToneLength ; $380e
	ld a, [hl+] ; $3810
	and $10 ; $3811
	ld b, a ; $3813
	ldh a, [hSndToneCtrl] ; $3814
	and $ef ; $3816
	or b ; $3818
	ldh [hSndToneCtrl], a ; $3819
	jp .nextCommand ; $381b
.setToneLength:
	cp $af ; $381e
	jr nz, .skipUnknown ; $3820
	ld a, [hl+] ; $3822
	and $0f ; $3823
	ldh [hSndLengthAccum], a ; $3825
	ld b, a ; $3827
	ldh a, [hSndToneCtrl] ; $3828
	and $f0 ; $382a
	or b ; $382c
	ldh [hSndToneCtrl], a ; $382d
	jp .nextCommand ; $382f
.skipUnknown:
	inc hl ; $3832
	jp .nextCommand ; $3833

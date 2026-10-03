FaceActorsTowardEachOther:
	push af ; $466f
	push bc ; $4670
	push de ; $4671
	push hl ; $4672
	ld d, a ; $4673
	call GetActorStateAddr ; $4674
	inc h ; $4677
	dec h ; $4678
	jp z, .done ; $4679
	ld a, b ; $467c
	call GetActorStateAddr ; $467d
	inc h ; $4680
	dec h ; $4681
	jp z, .done ; $4682
	push hl ; $4685
	ld a, l ; $4686
	ldh [hActorPtr], a ; $4687
	ld a, h ; $4689
	ldh [hActorPtr + 1], a ; $468a
	wram_bank WRAM_ACTORS ; $468c
	ld hl, hActorPtr ; $4692
	ld a, [hl+] ; $4695
	ld h, [hl] ; $4696
	add $0c ; $4697
	ld l, a ; $4699
	ld c, [hl] ; $469a
	inc hl ; $469b
	ld b, [hl] ; $469c
	inc hl ; $469d
	push bc ; $469e
	ld c, [hl] ; $469f
	inc hl ; $46a0
	ld b, [hl] ; $46a1
	push bc ; $46a2
	ld a, d ; $46a3
	call GetActorStateAddr ; $46a4
	ld a, l ; $46a7
	ldh [hActorPtr], a ; $46a8
	ld a, h ; $46aa
	ldh [hActorPtr + 1], a ; $46ab
	ld hl, hActorPtr ; $46ad
	ld a, [hl+] ; $46b0
	ld h, [hl] ; $46b1
	add $0e ; $46b2
	ld l, a ; $46b4
	ld a, [hl+] ; $46b5
	ld h, [hl] ; $46b6
	ld l, a ; $46b7
	ld d, h ; $46b8
	ld e, l ; $46b9
	pop hl ; $46ba
	ld a, l ; $46bb
	sub e ; $46bc
	ld l, a ; $46bd
	ld a, h ; $46be
	sbc d ; $46bf
	ld h, a ; $46c0
	ld b, h ; $46c1
	ld c, l ; $46c2
	ld hl, hActorPtr ; $46c3
	ld a, [hl+] ; $46c6
	ld h, [hl] ; $46c7
	add $0c ; $46c8
	ld l, a ; $46ca
	ld a, [hl+] ; $46cb
	ld h, [hl] ; $46cc
	ld l, a ; $46cd
	ld d, h ; $46ce
	ld e, l ; $46cf
	pop hl ; $46d0
	ld a, l ; $46d1
	sub e ; $46d2
	ld l, a ; $46d3
	ld a, h ; $46d4
	sbc d ; $46d5
	ld h, a ; $46d6
	ld d, h ; $46d7
	ld e, l ; $46d8
	ld h, b ; $46d9
	ld l, c ; $46da
	call AngleFromVectorCoarse ; $46db
	push af ; $46de
	ld hl, hActorPtr ; $46df
	ld a, [hl+] ; $46e2
	ld h, [hl] ; $46e3
	add $14 ; $46e4
	ld l, a ; $46e6
	pop af ; $46e7
	ld [hl], a ; $46e8
	add $80 ; $46e9
	pop hl ; $46eb
	ld d, a ; $46ec
	ld a, l ; $46ed
	ldh [hActorPtr], a ; $46ee
	ld a, h ; $46f0
	ldh [hActorPtr + 1], a ; $46f1
	ld hl, hActorPtr ; $46f3
	ld a, [hl+] ; $46f6
	ld h, [hl] ; $46f7
	add $14 ; $46f8
	ld l, a ; $46fa
	ld a, d ; $46fb
	ld [hl], a ; $46fc
.done:
	pop hl ; $46fd
	pop de ; $46fe
	pop bc ; $46ff
	pop af ; $4700
	ret ; $4701
ScriptSetActorAnimation:
	call GetActorStateAddr ; $4702
	ld c, l ; $4705
	ld b, h ; $4706
	farcall SetActorAnimationChecked ; $4707
	ret ; $470a
ScriptWaitActorIdle:
	test_flag FLAG_CUTSCENE_FAST_FORWARD ; $470b
	jr nz, .done ; $470e
	call GetActorStateAddr ; $4710
	ld c, l ; $4713
	ld b, h ; $4714
	call WaitActorIdle ; $4715
.done:
	ret ; $4718
ScriptSetActorJumpVelocity:
	call GetActorStateAddr ; $4719
	ret z ; $471c
	wram_bank WRAM_ACTORS ; $471d
	ld a, ACTORF_JUMP_VEL ; $4723
	add l ; $4725
	ld l, a ; $4726
	jr nc, .read ; $4727
	inc h ; $4729
.read:
	ld a, e ; $472a
	ld [hl+], a ; $472b
	ld [hl], d ; $472c
	ret ; $472d
SetActorActive:
	call GetActorStateAddr ; $472e
	ret z ; $4731
	wram_bank WRAM_ACTORS ; $4732
	ld a, $20 ; $4738
	add l ; $473a
	ld l, a ; $473b
	jr nc, .read ; $473c
	inc h ; $473e
.read:
	ld [hl], b ; $473f
	ret ; $4740
UnusedSubDEFromHL:
	ld a, d ; $4741
	or e ; $4742
	ret z ; $4743
	ld a, e ; $4744
	cpl ; $4745
	add $01 ; $4746
	ld e, a ; $4748
	ld a, d ; $4749
	sbc $00 ; $474a
	cpl ; $474c
	ld d, a ; $474d
	add hl, de ; $474e
	ret ; $474f
UnusedSetActorMoveTarget:
	inc h ; $4750
	dec h ; $4751
	ret z ; $4752
	push af ; $4753
	push hl ; $4754
	ld a, $16 ; $4755
	add l ; $4757
	ld l, a ; $4758
	ld [hl], e ; $4759
	inc hl ; $475a
	ld [hl], d ; $475b
	pop hl ; $475c
	pop af ; $475d
	ret ; $475e
Unused_0a_1:
	; $475f, 7 bytes (bytes:7)
	db $0c, $ff, $ff, $0b, $0c, $fe, $ff ; 0x00
ActorScript_0a:
	; $4766, 6 bytes (actor_script)
	as_halt
	as_set_field ACTORF_MODE, $0000
	as_halt
IsActorBusy:
	xor a ; $476c
	inc h ; $476d
	dec h ; $476e
	ret z ; $476f
	push de ; $4770
	push hl ; $4771
	wram_bank WRAM_ACTORS ; $4772
	ld de, $002e ; $4778
	add hl, de ; $477b
	ld a, [hl] ; $477c
	cp $00 ; $477d
	jr z, .busy ; $477f
	cp $01 ; $4781
	jr z, .busy ; $4783
	ld a, $01 ; $4785
	jr .done ; $4787
.busy:
	xor a ; $4789
.done:
	pop hl ; $478a
	pop de ; $478b
	ret ; $478c
WaitActorIdle:
	push af ; $478d
	push bc ; $478e
	ld bc, $00f0 ; $478f
.waitLoop:
	call IsActorBusy ; $4792
	and a ; $4795
	jr z, .done ; $4796
	call AdvanceFrame ; $4798
	dec bc ; $479b
	ld a, b ; $479c
	or c ; $479d
	jr nz, .waitLoop ; $479e
.done:
	pop bc ; $47a0
	pop af ; $47a1
	ret ; $47a2
SetPlayerMoveSpeed:
	push af ; $47a3
	push hl ; $47a4
	wram_bank WRAM_ACTORS ; $47a5
	ld hl, wActors + 1 * ACTOR_SIZE + 6 ; $47ab
	ld a, c ; $47ae
	ld [hl+], a ; $47af
	ld [hl], b ; $47b0
	pop hl ; $47b1
	pop af ; $47b2
	ret ; $47b3
MovePlayerToPosition:
	push af ; $47b4
	push bc ; $47b5
	push de ; $47b6
	push hl ; $47b7
	add sp, -4 ; $47b8
	ld hl, sp + 0 ; $47ba
	ld [hl], c ; $47bc
	inc hl ; $47bd
	ld [hl], b ; $47be
	inc hl ; $47bf
	ld [hl], e ; $47c0
	inc hl ; $47c1
	ld [hl], d ; $47c2
	ld hl, sp + 0 ; $47c3
	ld b, h ; $47c5
	ld c, l ; $47c6
	ld d, a ; $47c7
	ld hl, wActors + 1 * ACTOR_SIZE ; $47c8
	ld a, l ; $47cb
	ldh [hActorPtr], a ; $47cc
	ld a, h ; $47ce
	ldh [hActorPtr + 1], a ; $47cf
	wram_bank WRAM_ACTORS ; $47d1
	ld a, d ; $47d7
	or a ; $47d8
	jr nz, .waitLoop ; $47d9
	call SetActorMoveTargetRaw ; $47db
	jr .done ; $47de
.waitLoop:
	push af ; $47e0
	push bc ; $47e1
	push de ; $47e2
	push hl ; $47e3
	ld c, 127 ; $47e4
	call BeginFadeOut ; $47e6
	call WaitFadeEnd ; $47e9
	pop hl ; $47ec
	pop de ; $47ed
	pop bc ; $47ee
	pop af ; $47ef
	ld a, l ; $47f0
	ldh [hActorPtr], a ; $47f1
	ld a, h ; $47f3
	ldh [hActorPtr + 1], a ; $47f4
	call SetActorPositionRaw ; $47f6
	call AdvanceFrame ; $47f9
	farcall RestoreShadowTilemap ; $47fc
	ld b, $05 ; $47ff
	call AdvanceFrame ; $4801
	script_fade_in 127 ; $4804
	call WaitFadeEnd ; $4809
.done:
	add sp, 4 ; $480c
	pop hl ; $480e
	pop de ; $480f
	pop bc ; $4810
	pop af ; $4811
	ret ; $4812
MovePlayerToActor:
	cp $ff ; $4813
	ret z ; $4815
	push af ; $4816
	push bc ; $4817
	push de ; $4818
	push hl ; $4819
	push af ; $481a
	wram_bank WRAM_ACTORS ; $481b
	pop af ; $4821
	add sp, -4 ; $4822
	ld hl, sp + 0 ; $4824
	call GetActorStateAddr ; $4826
	ld a, l ; $4829
	ldh [hActorPtr], a ; $482a
	ld a, h ; $482c
	ldh [hActorPtr + 1], a ; $482d
	ld hl, hActorPtr ; $482f
	ld a, [hl+] ; $4832
	ld h, [hl] ; $4833
	add $0c ; $4834
	ld l, a ; $4836
	ld a, b ; $4837
	ld c, [hl] ; $4838
	inc hl ; $4839
	ld b, [hl] ; $483a
	inc hl ; $483b
	ld e, [hl] ; $483c
	inc hl ; $483d
	ld d, [hl] ; $483e
	ld hl, sp + 0 ; $483f
	ld [hl], c ; $4841
	inc hl ; $4842
	ld [hl], b ; $4843
	inc hl ; $4844
	ld [hl], e ; $4845
	inc hl ; $4846
	ld [hl], d ; $4847
	ld hl, sp + 0 ; $4848
	ld b, h ; $484a
	ld c, l ; $484b
	ld d, a ; $484c
	ld hl, wActors + 1 * ACTOR_SIZE ; $484d
	ld a, l ; $4850
	ldh [hActorPtr], a ; $4851
	ld a, h ; $4853
	ldh [hActorPtr + 1], a ; $4854
	ld a, d ; $4856
	or a ; $4857
	jr nz, .waitLoop ; $4858
	call SetActorMoveTargetRaw ; $485a
	jr .done ; $485d
.waitLoop:
	push af ; $485f
	push bc ; $4860
	push de ; $4861
	push hl ; $4862
	ld c, 127 ; $4863
	call BeginFadeOut ; $4865
	call WaitFadeEnd ; $4868
	pop hl ; $486b
	pop de ; $486c
	pop bc ; $486d
	pop af ; $486e
	ld a, l ; $486f
	ldh [hActorPtr], a ; $4870
	ld a, h ; $4872
	ldh [hActorPtr + 1], a ; $4873
	call SetActorPositionRaw ; $4875
	call AdvanceFrame ; $4878
	farcall RestoreShadowTilemap ; $487b
	ld b, $05 ; $487e
	call AdvanceFrame ; $4880
	script_fade_in 127 ; $4883
	call WaitFadeEnd ; $4888
.done:
	add sp, 4 ; $488b
	pop hl ; $488d
	pop de ; $488e
	pop bc ; $488f
	pop af ; $4890
	ret ; $4891
WaitPlayerMoveDone:
	push af ; $4892
	push bc ; $4893
	push hl ; $4894
	ld bc, $0258 ; $4895
	ld hl, wActors + 1 * ACTOR_SIZE ; $4898
	ld a, l ; $489b
	ldh [hActorPtr], a ; $489c
	ld a, h ; $489e
	ldh [hActorPtr + 1], a ; $489f
	wram_bank WRAM_ACTORS ; $48a1
	ld a, $05 ; $48a7
	add l ; $48a9
	ld l, a ; $48aa
	jr nc, .waitLoop ; $48ab
	inc h ; $48ad
.waitLoop:
	ld a, $01 ; $48ae
	call WaitScriptFrames ; $48b0
	bit 7, [hl] ; $48b3
	jr z, .done ; $48b5
	dec bc ; $48b7
	ld a, c ; $48b8
	or b ; $48b9
	jr nz, .waitLoop ; $48ba
.done:
	pop hl ; $48bc
	pop bc ; $48bd
	pop af ; $48be
	ret ; $48bf
SetScreenShake:
	push af ; $48c0
	push bc ; $48c1
	push de ; $48c2
	push hl ; $48c3
	ld b, a ; $48c4
	ldh a, [hWramBank] ; $48c5
	push af ; $48c7
	ld a, b ; $48c8
	or a ; $48c9
	jr z, .stop ; $48ca
	push af ; $48cc
	ld a, [wScreenShakeMagnitude] ; $48cd
	inc a ; $48d0
	jr nz, .clampMagnitude ; $48d1
	ld a, $01 ; $48d3
	ld hl, UpdateScreenShake ; $48d5
	call RegisterFrameTask ; $48d8
.clampMagnitude:
	pop af ; $48db
	cp $04 ; $48dc
	jr c, .store ; $48de
	ld a, $03 ; $48e0
	jr .store ; $48e2
.stop:
	ld a, [wScreenShakeMagnitude] ; $48e4
	inc a ; $48e7
	ld a, $00 ; $48e8
	jr z, .store ; $48ea
	xor a ; $48ec
	ld [wScreenShakeOffsetX], a ; $48ed
	ld [wScreenShakeOffsetY], a ; $48f0
	ld hl, UpdateScreenShake ; $48f3
	call UnregisterFrameTask ; $48f6
	ld a, $ff ; $48f9
.store:
	ld [wScreenShakeMagnitude], a ; $48fb
	pop_wram_bank ; $48fe
	pop hl ; $4903
	pop de ; $4904
	pop bc ; $4905
	pop af ; $4906
	ret ; $4907
UpdateScreenShake:
	push af ; $4908
	push bc ; $4909
	push de ; $490a
	push hl ; $490b
	ld a, [wScreenShakeMagnitude] ; $490c
	ld c, $00 ; $490f
.buildPattern:
	scf ; $4911
	rl c ; $4912
	dec a ; $4914
	jr nz, .buildPattern ; $4915
	call AdvanceRandomSeed ; $4917
	ld a, h ; $491a
	and c ; $491b
IF DEF(FIXES)
	bit 7, h
	jr z, .negate
ELSE
	jr nc, .negate ; $491c
ENDC
	cpl ; $491e
	inc a ; $491f
.negate:
	ld [wScreenShakeOffsetX], a ; $4920
	ld a, l ; $4923
	and c ; $4924
IF DEF(FIXES)
	bit 7, l
	jr z, .store
ELSE
	jr nc, .store ; $4925
ENDC
	cpl ; $4927
	inc a ; $4928
.store:
	ld [wScreenShakeOffsetY], a ; $4929
	pop hl ; $492c
	pop de ; $492d
	pop bc ; $492e
	pop af ; $492f
	ret ; $4930

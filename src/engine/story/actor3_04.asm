TryPickRandomReachableTarget:
	push bc ; $48c3
	ld hl, hActorPtr ; $48c4
	ld a, [hl+] ; $48c7
	ld b, [hl] ; $48c8
	ld c, a ; $48c9
	call AdvanceRandomSeed ; $48ca
	ld a, l ; $48cd
	and $fc ; $48ce
	ld [wActorProbeAngle], a ; $48d0
	ld hl, $0100 ; $48d3
	call ProjectPointFromActor ; $48d6
	push de ; $48d9
	push hl ; $48da
	ld e, d ; $48db
	ld d, h ; $48dc
	ld hl, $0016 ; $48dd
	add hl, bc ; $48e0
	ld a, [hl+] ; $48e1
	ld b, [hl] ; $48e2
	ld c, a ; $48e3
	ld a, [wActorRandBoxHalfWidth] ; $48e4
	ld h, a ; $48e7
	ld a, [wActorRandBoxHalfDepth] ; $48e8
	ld l, a ; $48eb
	call TestPointInBox ; $48ec
	pop hl ; $48ef
	pop de ; $48f0
	and a ; $48f1
	jr nz, .failed ; $48f2
	push de ; $48f4
	push hl ; $48f5
	ld a, [wActorProbeAngle] ; $48f6
	ld bc, $00e0 ; $48f9
	call OffsetPointByPolarVector ; $48fc
	call IsTerrainBlockedAtPoint ; $48ff
	pop hl ; $4902
	pop de ; $4903
	and a ; $4904
	jr nz, .failed ; $4905
	push de ; $4907
	push hl ; $4908
	ld a, [wActorProbeAngle] ; $4909
	add $20 ; $490c
	ld bc, $00e0 ; $490e
	call OffsetPointByPolarVector ; $4911
	call IsTerrainBlockedAtPoint ; $4914
	pop hl ; $4917
	pop de ; $4918
	and a ; $4919
	jr nz, .failed ; $491a
	push de ; $491c
	push hl ; $491d
	ld a, [wActorProbeAngle] ; $491e
	add $e0 ; $4921
	ld bc, $00e0 ; $4923
	call OffsetPointByPolarVector ; $4926
	call IsTerrainBlockedAtPoint ; $4929
	pop hl ; $492c
	pop de ; $492d
	and a ; $492e
	jr nz, .failed ; $492f
	push hl ; $4931
	ld hl, hActorPtr ; $4932
	ld a, [hl+] ; $4935
	ld b, [hl] ; $4936
	ld c, a ; $4937
	pop hl ; $4938
	call SetActorMoveTarget ; $4939
	ld hl, $0005 ; $493c
	add hl, bc ; $493f
	set 7, [hl] ; $4940
	ld a, $01 ; $4942
	jr .done ; $4944
.failed:
	xor a ; $4946
.done:
	pop bc ; $4947
	ret ; $4948
ActorScriptOp_WaitMove2:
	ld hl, hActorPtr ; $4949
	ld a, [hl+] ; $494c
	ld h, [hl] ; $494d
	add $05 ; $494e
	ld l, a ; $4950
	bit 7, [hl] ; $4951
	jr nz, .setWait ; $4953
	ld hl, hActorPtr ; $4955
	ld a, [hl+] ; $4958
	ld h, [hl] ; $4959
	add $03 ; $495a
	ld l, a ; $495c
	ld [hl], $28 ; $495d
	inc de ; $495f
	jr .done ; $4960
.setWait:
	ld hl, hActorPtr ; $4962
	ld a, [hl+] ; $4965
	ld h, [hl] ; $4966
	add $05 ; $4967
	ld l, a ; $4969
	bit 6, [hl] ; $496a
	jr z, .done ; $496c
	ld hl, hActorPtr ; $496e
	ld a, [hl+] ; $4971
	ld h, [hl] ; $4972
	add $03 ; $4973
	ld l, a ; $4975
	ld [hl], $0a ; $4976
	inc de ; $4978
.done:
	xor a ; $4979
	ret ; $497a
Unused_04_ActorScriptOpMoveVector:
	inc de ; $497b
	push de ; $497c
	ld a, [wActorScriptBank] ; $497d
	ld l, e ; $4980
	ld h, d ; $4981
	call FarReadWord ; $4982
	push bc ; $4985
	inc hl ; $4986
	inc hl ; $4987
	ld a, [wActorScriptBank] ; $4988
	call FarReadWord ; $498b
	push bc ; $498e
	inc hl ; $498f
	inc hl ; $4990
	call FarReadByte ; $4991
	push af ; $4994
	push hl ; $4995
	ld hl, hActorPtr ; $4996
	ld a, [hl+] ; $4999
	ld b, [hl] ; $499a
	ld c, a ; $499b
	ld hl, $000c ; $499c
	add hl, bc ; $499f
	ld a, [hl+] ; $49a0
	ld h, [hl] ; $49a1
	ld l, a ; $49a2
	pop de ; $49a3
	push hl ; $49a4
	ld hl, $000e ; $49a5
	add hl, bc ; $49a8
	ld a, [hl+] ; $49a9
	ld h, [hl] ; $49aa
	ld l, a ; $49ab
	pop de ; $49ac
	call AngleFromVectorCoarse ; $49ad
	pop hl ; $49b0
	ld l, h ; $49b1
	ld h, $00 ; $49b2
	call VectorFromLengthAndAngleRaw ; $49b4
	pop bc ; $49b7
	add hl, bc ; $49b8
	ld c, l ; $49b9
	ld b, h ; $49ba
	pop hl ; $49bb
	add hl, de ; $49bc
	ld e, l ; $49bd
	ld d, h ; $49be
	ld hl, hActorPtr ; $49bf
	ld a, [hl+] ; $49c2
	ld h, [hl] ; $49c3
	add $08 ; $49c4
	ld l, a ; $49c6
	ld [hl], c ; $49c7
	inc hl ; $49c8
	ld [hl], b ; $49c9
	inc hl ; $49ca
	ld [hl], e ; $49cb
	inc hl ; $49cc
	ld [hl], d ; $49cd
	pop bc ; $49ce
	ld hl, $0005 ; $49cf
	add hl, bc ; $49d2
	ld c, l ; $49d3
	ld b, h ; $49d4
	ld hl, $0005 ; $49d5
	add hl, bc ; $49d8
	set 7, [hl] ; $49d9
	ld a, $01 ; $49db
	ret ; $49dd
ActorScriptOp_Flag:
	push bc ; $49de
	inc de ; $49df
	ld a, [wActorScriptBank] ; $49e0
	ld l, e ; $49e3
	ld h, d ; $49e4
	call FarReadByte ; $49e5
	inc de ; $49e8
	push af ; $49e9
	ld l, e ; $49ea
	ld h, d ; $49eb
	ld a, [wActorScriptBank] ; $49ec
	call FarReadByte ; $49ef
	inc de ; $49f2
	push af ; $49f3
	ld a, [wActorScriptBank] ; $49f4
	ld l, e ; $49f7
	ld h, d ; $49f8
	call FarReadByte ; $49f9
	inc de ; $49fc
	ld_hl_indexed BitMaskTable_04 ; $49fd
	ld c, [hl] ; $4a04
	pop af ; $4a05
	ld hl, hActorPtr ; $4a06
	add [hl] ; $4a09
	inc hl ; $4a0a
	ld h, [hl] ; $4a0b
	ld l, a ; $4a0c
	pop af ; $4a0d
	cp $01 ; $4a0e
	jr z, .setBits ; $4a10
	ld a, c ; $4a12
	xor $ff ; $4a13
	and [hl] ; $4a15
	jr .store ; $4a16
.setBits:
	ld a, c ; $4a18
	or [hl] ; $4a19
.store:
	ld [hl], a ; $4a1a
	pop bc ; $4a1b
	ld a, $01 ; $4a1c
	ret ; $4a1e
BitMaskTable_04:
	; $4a1f, 8 bytes (bytes:8)
	db $01, $02, $04, $08, $10, $20, $40, $80 ; 0x00
ComputeSpriteScrollOffset:
	ld hl, wCameraX ; $4a27
	ld a, [hl+] ; $4a2a
	ld d, [hl] ; $4a2b
	ld e, a ; $4a2c
	ld a, [wScreenShakeOffsetX] ; $4a2d
	ld l, a ; $4a30
	ld h, $00 ; $4a31
	bit 7, l ; $4a33
	jr z, .scale ; $4a35
	ld h, $ff ; $4a37
.scale:
	add hl, hl ; $4a39
	add hl, hl ; $4a3a
	add hl, hl ; $4a3b
	add hl, hl ; $4a3c
	add hl, hl ; $4a3d
	add hl, de ; $4a3e
	xor a ; $4a3f
	sub l ; $4a40
	ld l, a ; $4a41
	sbc a ; $4a42
	sub h ; $4a43
	ld h, a ; $4a44
	ld c, l ; $4a45
	ld b, h ; $4a46
	ld hl, wActorScreenOriginX ; $4a47
	ld a, c ; $4a4a
	ld [hl+], a ; $4a4b
	ld [hl], b ; $4a4c
	ld hl, wCameraY ; $4a4d
	ld a, [hl+] ; $4a50
	ld d, [hl] ; $4a51
	ld e, a ; $4a52
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $4a53
	jr z, .clamp ; $4a56
	ld hl, wRasterScrollStartLY ; $4a58
	ld a, [hl+] ; $4a5b
	ld h, [hl] ; $4a5c
	ld l, a ; $4a5d
	add hl, de ; $4a5e
	ld d, h ; $4a5f
	ld e, l ; $4a60
.clamp:
	ld a, [wScreenShakeOffsetY] ; $4a61
	ld l, a ; $4a64
	ld h, $00 ; $4a65
	bit 7, l ; $4a67
	jr z, .done ; $4a69
	ld h, $ff ; $4a6b
.done:
	add hl, hl ; $4a6d
	add hl, hl ; $4a6e
	add hl, hl ; $4a6f
	add hl, hl ; $4a70
	add hl, hl ; $4a71
	add hl, de ; $4a72
	xor a ; $4a73
	sub l ; $4a74
	ld l, a ; $4a75
	sbc a ; $4a76
	sub h ; $4a77
	ld h, a ; $4a78
	ld c, l ; $4a79
	ld b, h ; $4a7a
	ld hl, wActorScreenOriginY ; $4a7b
	ld a, c ; $4a7e
	ld [hl+], a ; $4a7f
	ld [hl], b ; $4a80
	ret ; $4a81
DrawActors:
	test_flag FLAG_HIDE_OVERWORLD_ACTORS ; $4a82
	ret nz ; $4a85
	wram_bank $04 ; $4a86
	call ComputeSpriteScrollOffset ; $4a8c
	ld bc, wActors ; $4a8f
	ld e, $18 ; $4a92
.actorLoop:
	inc c ; $4a94
	ld a, [bc] ; $4a95
	dec c ; $4a96
	or a ; $4a97
	jr z, .next ; $4a98
	ld hl, $0031 ; $4a9a
	add hl, bc ; $4a9d
	ld a, [hl] ; $4a9e
	and a ; $4a9f
	jr z, .drawActor ; $4aa0
	dec [hl] ; $4aa2
	jr .next ; $4aa3
.drawActor:
	push de ; $4aa5
	ld hl, $0022 ; $4aa6
	add hl, bc ; $4aa9
	ld a, [hl] ; $4aaa
	ld [wActorScriptBank], a ; $4aab
	ld hl, $0020 ; $4aae
	add hl, bc ; $4ab1
	ld a, [hl] ; $4ab2
	cp $02 ; $4ab3
	call z, DrawAndAnimateActor ; $4ab5
	pop de ; $4ab8
.next:
	ld hl, $0040 ; $4ab9
	add hl, bc ; $4abc
	ld c, l ; $4abd
	ld b, h ; $4abe
	dec e ; $4abf
	jr nz, .actorLoop ; $4ac0
	ret ; $4ac2
LoadActorObjectDefIfValid:
	inc b ; $4ac3
	dec b ; $4ac4
	ret z ; $4ac5
LoadActorObjectDef:
	push af ; $4ac6
	push de ; $4ac7
	push hl ; $4ac8
	wram_bank $04 ; $4ac9
	ld hl, $0021 ; $4acf
	add hl, bc ; $4ad2
	ld [hl], d ; $4ad3
	ld a, d ; $4ad4
	add a ; $4ad5
	ld_hl_indexed ObjectIdList_04 ; $4ad6
	ld a, [hl+] ; $4add
	ld h, [hl] ; $4ade
	ld l, a ; $4adf
	ld a, $22 ; $4ae0
	add c ; $4ae2
	ld e, a ; $4ae3
	ld d, b ; $4ae4
	ld a, h ; $4ae5
	ld [de], a ; $4ae6
	push bc ; $4ae7
	ld de, wActorObjDef ; $4ae8
	ld bc, $0010 ; $4aeb
	call CopyDataFromBank ; $4aee
	pop bc ; $4af1
	ld a, [wActorObjDef] ; $4af2
	ld hl, $0037 ; $4af5
	add hl, bc ; $4af8
	ld [hl], a ; $4af9
	ld a, [wActorObjDef + 1] ; $4afa
	ld hl, $0035 ; $4afd
	add hl, bc ; $4b00
	ld [hl], a ; $4b01
	ld hl, $0024 ; $4b02
	add hl, bc ; $4b05
	ld a, [wActorObjDef + 4] ; $4b06
	ld [hl+], a ; $4b09
	ld a, [wActorObjDef + 5] ; $4b0a
	ld [hl+], a ; $4b0d
	ld hl, $0028 ; $4b0e
	add hl, bc ; $4b11
	ld a, [wActorObjDef + 6] ; $4b12
	ld [hl+], a ; $4b15
	ld a, [wActorObjDef + 7] ; $4b16
	ld [hl+], a ; $4b19
	ld hl, $0038 ; $4b1a
	add hl, bc ; $4b1d
	ld a, [wActorObjDef + 10] ; $4b1e
	ld [hl+], a ; $4b21
	ld a, [wActorObjDef + 11] ; $4b22
	ld [hl+], a ; $4b25
	ld hl, $0037 ; $4b26
	add hl, bc ; $4b29
	ld a, [hl] ; $4b2a
	cp $63 ; $4b2b
	jr nz, .initFields ; $4b2d
	ld [hl], $02 ; $4b2f
	push bc ; $4b31
	ld hl, wActorObjDef + 8 ; $4b32
	ld a, [hl+] ; $4b35
	ld h, [hl] ; $4b36
	ld l, a ; $4b37
	ld a, $22 ; $4b38
	add c ; $4b3a
	ld e, a ; $4b3b
	ld d, b ; $4b3c
	ld a, [de] ; $4b3d
	ld de, wActorObjDef ; $4b3e
	ld bc, $0008 ; $4b41
	call FarCopyBytes ; $4b44
	ld hl, wActorObjDef ; $4b47
	lb de, $0a, $01 ; $4b4a palette index, count
	call LoadPalettesMasterOnly ; $4b4d
	pop bc ; $4b50
.initFields:
	ld hl, $0020 ; $4b51
	add hl, bc ; $4b54
	ld [hl], $02 ; $4b55
	ld hl, $0032 ; $4b57
	add hl, bc ; $4b5a
	ld a, $ff ; $4b5b
	ld [hl+], a ; $4b5d
	ld [hl+], a ; $4b5e
	ld d, $00 ; $4b5f
	call SetActorAnimation ; $4b61
	pop hl ; $4b64
	pop de ; $4b65
	pop af ; $4b66
	ret ; $4b67
SetupCharSpriteFromObjectDef:
	ld a, d ; $4b68
	ld [wCharObjectDefId], a ; $4b69
	add a ; $4b6c
	ld_hl_indexed ObjectIdList_04 ; $4b6d
	ld a, [hl+] ; $4b74
	ld h, [hl] ; $4b75
	ld l, a ; $4b76
	ld a, h ; $4b77
	ld [wCharObjectBank], a ; $4b78
	ld de, wActorObjDef ; $4b7b
	ld bc, $0010 ; $4b7e
	call CopyDataFromBank ; $4b81
	ld a, [wActorObjDef] ; $4b84
	ld [wCharSpriteAttr], a ; $4b87
	ld [wCharGfxBank], a ; $4b8a
	ld hl, wCharFrameTablePtr ; $4b8d
	ld a, [wActorObjDef + 4] ; $4b90
	ld [hl+], a ; $4b93
	ld a, [wActorObjDef + 5] ; $4b94
	ld [hl+], a ; $4b97
	ld hl, wCharAnimTablePtr ; $4b98
	ld a, [wActorObjDef + 6] ; $4b9b
	ld [hl+], a ; $4b9e
	ld a, [wActorObjDef + 7] ; $4b9f
	ld [hl+], a ; $4ba2
	ld hl, wCharShadowTablePtr ; $4ba3
	ld a, [wActorObjDef + 10] ; $4ba6
	ld [hl+], a ; $4ba9
	ld a, [wActorObjDef + 11] ; $4baa
	ld [hl+], a ; $4bad
	ld hl, wCharFacingOctant ; $4bae
	ld a, $ff ; $4bb1
	ld [hl+], a ; $4bb3
	ld [hl+], a ; $4bb4
	ld d, CHARANIM_IDLE ; $4bb5
	farcall SetCharAnimation ; $4bb7
	ret ; $4bba

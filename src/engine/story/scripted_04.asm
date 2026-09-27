SetActorAnimationChecked:
	inc b ; $4bbb
	dec b ; $4bbc
	ret z ; $4bbd
SetActorAnimation:
	push af ; $4bbe
	push de ; $4bbf
	push hl ; $4bc0
	wram_bank WRAM_ACTORS ; $4bc1
	ld hl, $002e ; $4bc7
	add hl, bc ; $4bca
	ld a, [hl] ; $4bcb
	cp d ; $4bcc
	jr z, .done ; $4bcd
	ld [hl], d ; $4bcf
	ld hl, $002f ; $4bd0
	add hl, bc ; $4bd3
	ld [hl], $00 ; $4bd4
	ld hl, wCharSpriteAttr ; $4bd6
	ld a, [hl] ; $4bd9
	and $0f ; $4bda
	ld [hl], a ; $4bdc
	push bc ; $4bdd
	ld hl, ACTORF_ANIM_TABLE ; $4bde
	add hl, bc ; $4be1
	ld a, [hl+] ; $4be2
	ld h, [hl] ; $4be3
	ld l, a ; $4be4
	ld a, d ; $4be5
	add a ; $4be6
	add l ; $4be7
	ld l, a ; $4be8
	jr nc, .readEntry ; $4be9
	inc h ; $4beb
.readEntry:
	push hl ; $4bec
	ld hl, $0022 ; $4bed
	add hl, bc ; $4bf0
	ld a, [hl] ; $4bf1
	pop hl ; $4bf2
	call FarReadWord ; $4bf3
	ld e, c ; $4bf6
	ld d, b ; $4bf7
	pop bc ; $4bf8
	ld hl, $002a ; $4bf9
	add hl, bc ; $4bfc
	ld a, e ; $4bfd
	ld [hl+], a ; $4bfe
	ld [hl], d ; $4bff
	ld hl, $002c ; $4c00
	add hl, bc ; $4c03
	ld a, e ; $4c04
	ld [hl+], a ; $4c05
	ld [hl], d ; $4c06
.done:
	pop hl ; $4c07
	pop de ; $4c08
	pop af ; $4c09
	ret ; $4c0a
GetObjectDefCount:
	push bc ; $4c0b
	push hl ; $4c0c
	ld hl, ObjectIdList_04 ; $4c0d
	ld c, $ff ; $4c10
.searchLoop:
	inc c ; $4c12
	ld a, [hl+] ; $4c13
	ld b, a ; $4c14
	ld a, [hl+] ; $4c15
	or b ; $4c16
	jr nz, .searchLoop ; $4c17
	ld a, c ; $4c19
	pop hl ; $4c1a
	pop bc ; $4c1b
	ret ; $4c1c
GetCharObjectId:
	push hl ; $4c1d
	ld hl, CharObjectIdTable ; $4c1e
	add l ; $4c21
	ld l, a ; $4c22
	jr nc, .read ; $4c23
	inc h ; $4c25
.read:
	ld a, [hl] ; $4c26
	pop hl ; $4c27
	ret ; $4c28
CharObjectIdTable:
	; $4c29, 32 bytes: the overworld object id of each CHAR_* id
	db OBJ_ALEX ; CHAR_ALEX
	db OBJ_NINA ; CHAR_NINA
	db OBJ_HARRY ; CHAR_HARRY
	db OBJ_KATE ; CHAR_KATE
	db OBJ_ALLIE ; CHAR_ALLIE
	db OBJ_JOY ; CHAR_JOY
	db OBJ_BRIAN ; CHAR_BRIAN
	db OBJ_PAM ; CHAR_PAM
	db OBJ_BOB ; CHAR_BOB
	db OBJ_BETH ; CHAR_BETH
	db OBJ_FAY ; CHAR_FAY
	db OBJ_CURT ; CHAR_CURT
	db OBJ_MARK ; CHAR_MARK
	db OBJ_SEAN ; CHAR_SEAN
	db OBJ_SAMMI ; CHAR_SAMMI
	db OBJ_ELDEN ; CHAR_ELDEN
	db OBJ_SPIKE ; CHAR_SPIKE
	db OBJ_EMILY ; CHAR_EMILY
	db OBJ_B_COZ ; CHAR_B_COZ
	db OBJ_A_COZ ; CHAR_A_COZ
	db OBJ_KEVIN ; CHAR_KEVIN
	db OBJ_WALK_73_15 ; CHAR_UNUSED_15
	db OBJ_WALK_73_15 ; CHAR_UNUSED_16
	db OBJ_LUIGI ; CHAR_LUIGI
	db OBJ_DK ; CHAR_DK
	db OBJ_BABY_MARIO ; CHAR_BABY_MARIO
	db OBJ_MARIO ; CHAR_MARIO
	db OBJ_WALUIGI ; CHAR_WALUIGI
	db OBJ_YOSHI ; CHAR_YOSHI
	db OBJ_BOWSER ; CHAR_BOWSER
	db OBJ_WARIO ; CHAR_WARIO
	db OBJ_PEACH ; CHAR_PEACH
EvalFlagCondition:
	ld a, e ; $4c49
	or d ; $4c4a
	ret z ; $4c4b
	bit 7, d ; $4c4c
	jr nz, .negated ; $4c4e
	call TestGameFlag ; $4c50
	ret ; $4c53
.negated:
	res 7, d ; $4c54
	call TestGameFlag ; $4c56
	jr z, .true ; $4c59
	xor a ; $4c5b
	ret ; $4c5c
.true:
	xor a ; $4c5d
	inc a ; $4c5e
	ret ; $4c5f
SpawnActorFromTemplate:
	push af ; $4c60
	push de ; $4c61
	push hl ; $4c62
	ld b, a ; $4c63
	push de ; $4c64
	ld a, [hl+] ; $4c65
	ld e, a ; $4c66
	ld a, [hl+] ; $4c67
	ld d, a ; $4c68
	call EvalFlagCondition ; $4c69
	pop de ; $4c6c
	jr z, .withFields ; $4c6d
	ldh a, [hRomBank] ; $4c6f
	ld hl, ActorScript_Idle ; $4c71
	call SpawnActor ; $4c74
	jr .done ; $4c77
.withFields:
	ld a, [hl+] ; $4c79
	ld e, a ; $4c7a
	ld a, [hl+] ; $4c7b
	ld d, a ; $4c7c
	ld a, b ; $4c7d
	push hl ; $4c7e
	ld l, e ; $4c7f
	ld h, d ; $4c80
	call SpawnActor ; $4c81
	pop hl ; $4c84
	inc b ; $4c85
	dec b ; $4c86
	jr z, .done ; $4c87
	ld a, ACTORF_X ; $4c89
	add c ; $4c8b
	ld e, a ; $4c8c
	ld d, b ; $4c8d
	ld a, [hl+] ; $4c8e
	ld [de], a ; $4c8f
	inc de ; $4c90
	ld a, [hl-] ; $4c91
	ld [de], a ; $4c92
	ld a, ACTORF_TARGET_X ; $4c93
	add c ; $4c95
	ld e, a ; $4c96
	ld d, b ; $4c97
	ld a, [hl+] ; $4c98
	ld [de], a ; $4c99
	inc de ; $4c9a
	ld a, [hl+] ; $4c9b
	ld [de], a ; $4c9c
	ld a, ACTORF_Y ; $4c9d
	add c ; $4c9f
	ld e, a ; $4ca0
	ld d, b ; $4ca1
	ld a, [hl+] ; $4ca2
	ld [de], a ; $4ca3
	inc de ; $4ca4
	ld a, [hl-] ; $4ca5
	ld [de], a ; $4ca6
	ld a, ACTORF_TARGET_Y ; $4ca7
	add c ; $4ca9
	ld e, a ; $4caa
	ld d, b ; $4cab
	ld a, [hl+] ; $4cac
	ld [de], a ; $4cad
	inc de ; $4cae
	ld a, [hl+] ; $4caf
	ld [de], a ; $4cb0
	ld a, ACTORF_HEADING ; $4cb1
	add c ; $4cb3
	ld e, a ; $4cb4
	ld d, b ; $4cb5
	ld a, [hl+] ; $4cb6
	ld [de], a ; $4cb7
	inc hl ; $4cb8
	ld a, [hl+] ; $4cb9
	ld d, a ; $4cba
	call LoadActorObjectDef ; $4cbb
	ld a, [hl+] ; $4cbe
	ld d, a ; $4cbf
	call SetActorAnimation ; $4cc0
	ld a, [hl] ; $4cc3
	cp $00 ; $4cc4
	jr z, .setFlags ; $4cc6
	ld a, ACTORF_OAM_ATTR ; $4cc8
	add c ; $4cca
	ld e, a ; $4ccb
	ld d, b ; $4ccc
	ld a, [hl] ; $4ccd
	ld [de], a ; $4cce
.setFlags:
	inc hl ; $4ccf
	inc hl ; $4cd0
	ld hl, ACTORF_FLAGS ; $4cd1
	add hl, bc ; $4cd4
	set ACTORFLAGB_SOLID, [hl] ; $4cd5
	set ACTORFLAGB_TALKABLE, [hl] ; $4cd7
	ld l, c ; $4cd9
	ld h, b ; $4cda
	add hl, hl ; $4cdb
	add hl, hl ; $4cdc
	ld a, h ; $4cdd
	and $0f ; $4cde
	ld hl, $0031 ; $4ce0
	add hl, bc ; $4ce3
	ld [hl], a ; $4ce4
	ld hl, $0018 ; $4ce5
	add hl, bc ; $4ce8
	ld a, $01 ; $4ce9
	ld [hl], a ; $4ceb
	ld hl, $0019 ; $4cec
	add hl, bc ; $4cef
	ld a, $02 ; $4cf0
	ld [hl], a ; $4cf2
.done:
	pop hl ; $4cf3
	pop de ; $4cf4
	pop af ; $4cf5
	ret ; $4cf6
SpawnActorsFromList:
	push af ; $4cf7
	push bc ; $4cf8
	push de ; $4cf9
	push hl ; $4cfa
	ld b, a ; $4cfb
	push_wram_bank WRAM_ACTORS ; $4cfc
	ld a, b ; $4d05
.spawnLoop:
	push af ; $4d06
	ld de, wActorTemplate ; $4d07
	ld bc, $000e ; $4d0a
	call FarCopyBytes ; $4d0d
	ld a, [wActorTemplate + 9] ; $4d10
	inc a ; $4d13
	jr z, .done ; $4d14
	pop af ; $4d16
	push hl ; $4d17
	ld hl, wActorTemplate ; $4d18
	call SpawnActorFromTemplate ; $4d1b
	pop hl ; $4d1e
	jr .spawnLoop ; $4d1f
.done:
	pop af ; $4d21
	pop_wram_bank ; $4d22
	pop hl ; $4d27
	pop de ; $4d28
	pop bc ; $4d29
	pop af ; $4d2a
	ret ; $4d2b
Unused_04_SpawnScriptedActorScene:
	ldh a, [hRomBank] ; $4d2c
	ld hl, ActorList_04_1 ; $4d2e
	call SpawnActorFromTemplate ; $4d31
	call AttachActorControllerScript ; $4d34
	ldh a, [hRomBank] ; $4d37
	ld hl, ActorScript_Idle ; $4d39
	call SpawnActor ; $4d3c
	ld hl, $1700 ; $4d3f
	ld de, $1d00 ; $4d42
	call SetActorPosition ; $4d45
	ld de, $d000 ; $4d48
	call AttachActorWaypointFollower ; $4d4b
	ldh a, [hRomBank] ; $4d4e
	ld hl, ScriptedActorSceneActorList0 ; $4d50
	call SpawnActorFromTemplate ; $4d53
	ld de, $d000 ; $4d56
	call AttachActorStepMover ; $4d59
	ld hl, ScriptedActorSceneActorList1 ; $4d5c
	call SpawnActorsFromList ; $4d5f
	ret ; $4d62
ActorList_04_0:
	; $4d63, 66 bytes (actor_list)
	map_actor $0000, ActorScript_Idle, $0100, $0100, FACE_DOWN, OBJ_MATCH_NINA, ANIM_WALK, $00
	map_actor $0000, ActorScript_Idle, $1700, $1d00, FACE_DOWN, OBJ_MATCH_ALEX, ANIM_WALK, $00
	map_actor $0000, ActorScript_Idle, $0e00, $1900, FACE_RIGHT, OBJ_MATCH_ALEX, ANIM_WALK, $00
	map_actor $0000, ActorScript_Idle, $2200, $1900, FACE_LEFT, OBJ_MATCH_ALEX, ANIM_WALK, $00
	map_actor_end
ActorList_04_1:
	; $4da5, 24 bytes (actor_list)
	map_actor $0000, ActorScript_Idle, $1900, $2500, FACE_DOWN, OBJ_ALEX, ANIM_WALK, $00
	map_actor_end
ScriptedActorList0_04:
	; $4dbd, 24 bytes (actor_list)
	map_actor $0000, ActorScript_Idle, $1900, $2500, FACE_DOWN, OBJ_NINA, ANIM_WALK, $00
	map_actor_end
ScriptedActorList1_04:
	; $4dd5, 24 bytes (actor_list)
	map_actor $0000, ActorScript_Idle, $1900, $2500, FACE_DOWN, OBJ_HARRY, ANIM_WALK, $00
	map_actor_end
ScriptedActorList2_04:
	; $4ded, 24 bytes (actor_list)
	map_actor $0000, ActorScript_Idle, $1900, $2500, FACE_DOWN, OBJ_KATE, ANIM_WALK, $00
	map_actor_end
ScriptedActorSceneActorList0:
	; $4e05, 24 bytes (actor_list)
	map_actor $0000, ActorScript_Idle, $1d00, $2900, FACE_DOWN, OBJ_MARIO, ANIM_WALK, $00
	map_actor_end
ScriptedActorSceneActorList1:
	; $4e1d, 66 bytes (actor_list)
	map_actor $0000, ActorScript_Idle, $1700, $1500, FACE_DOWN, OBJ_MARIO, ANIM_WALK, $00
	map_actor $0000, ActorScript_Idle, $1700, $1900, FACE_DOWN, OBJ_MARIO, ANIM_WALK, $00
	map_actor $0000, ActorScript_Idle, $1700, $1d00, FACE_DOWN, OBJ_MARIO, ANIM_WALK, $00
	map_actor $0000, ActorScript_Idle, $1700, $2100, FACE_DOWN, OBJ_MARIO, ANIM_WALK, $00
	map_actor_end
ScriptedActorListPtrs_04:
	; $4e5f, 8 bytes (records:2)
	dw ActorList_04_1 ; record 0
	dw ScriptedActorList0_04 ; record 1
	dw ScriptedActorList1_04 ; record 2
	dw ScriptedActorList2_04 ; record 3
	; $4e67, 4 bytes (bytes:4)
	db $0b, $0c, $fe, $ff ; 0x00
SpawnMainCharacterActor:
	push af ; $4e6b
	push bc ; $4e6c
	push de ; $4e6d
	push hl ; $4e6e
	wram_bank WRAM_ACTORS ; $4e6f
	push hl ; $4e75
	push bc ; $4e76
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4e77
	and $03 ; $4e7a
	add a ; $4e7c
	ld_hl_indexed ScriptedActorListPtrs_04 ; $4e7d
	ld a, [hl+] ; $4e84
	ld h, [hl] ; $4e85
	ld l, a ; $4e86
	ldh a, [hRomBank] ; $4e87
	call SpawnActorFromTemplate ; $4e89
	pop bc ; $4e8c
	ld a, c ; $4e8d
	ld [wActors + ACTORF_HEADING], a ; $4e8e
	ld [wPlayerMoveAngle], a ; $4e91
	pop hl ; $4e94
	ld bc, wActors ; $4e95
	call SetActorPosition ; $4e98
	push de ; $4e9b
	push hl ; $4e9c
	ldh a, [hRomBank] ; $4e9d
	ld de, ActorScript_Idle ; $4e9f
	call SpawnActor ; $4ea2
	ld a, $01 ; $4ea5
	call SetActorMode ; $4ea7
	ld de, wActors ; $4eaa
	call AttachActorWaypointFollower ; $4ead
	pop hl ; $4eb0
	pop de ; $4eb1
	call SetActorPosition ; $4eb2
	ld hl, wStoryModeMainCharacterOverworldSpriteColor ; $4eb5
	ld a, [hl] ; $4eb8
	add $03 ; $4eb9
	ld bc, wActors ; $4ebb
	ld hl, ACTORF_OAM_ATTR ; $4ebe
	add hl, bc ; $4ec1
	ld [hl], a ; $4ec2
	pop hl ; $4ec3
	pop de ; $4ec4
	pop bc ; $4ec5
	pop af ; $4ec6
	ret ; $4ec7
CompanionActorPartnerActorList0:
	; $4ec8, 24 bytes (actor_list)
	map_actor $0000, ActorScript_Idle, $0100, $0100, FACE_DOWN, OBJ_HARRY, ANIM_WALK, $00
	map_actor_end
CompanionActorPartnerActorList1:
	; $4ee0, 24 bytes (actor_list)
	map_actor $0000, ActorScript_Idle, $0100, $0100, FACE_DOWN, OBJ_KATE, ANIM_WALK, $00
	map_actor_end
CompanionActorPartnerActorList2:
	; $4ef8, 24 bytes (actor_list)
	map_actor $01e0, ActorScript_Deactivate, $0100, $0100, FACE_DOWN, OBJ_WALK_71_02, ANIM_WALK, $00
	map_actor_end
SpawnCompanionActor:
	push af ; $4f10
	push bc ; $4f11
	push de ; $4f12
	push hl ; $4f13
	wram_bank WRAM_ACTORS ; $4f14
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $4f1a
	or a ; $4f1d
	jr nz, .partnerSlot ; $4f1e
	ld hl, CompanionActorPartnerActorList0 ; $4f20
	ld a, $02 ; $4f23
	test_flag FLAG_DOUBLES ; $4f25
	jr nz, .spawn ; $4f28
	jr .singlesList ; $4f2a
.partnerSlot:
	ld hl, CompanionActorPartnerActorList1 ; $4f2c
	ld a, $03 ; $4f2f
	test_flag FLAG_DOUBLES ; $4f31
	jr nz, .spawn ; $4f34
.singlesList:
	ld hl, CompanionActorPartnerActorList2 ; $4f36
	ld a, $ff ; $4f39
.spawn:
	ld [wCompanionActorSlot], a ; $4f3b
	ldh a, [hRomBank] ; $4f3e
	call SpawnActorFromTemplate ; $4f40
	ld a, [wCompanionActorSlot] ; $4f43
	cp $ff ; $4f46
	jr z, .done ; $4f48
	ld de, wActors ; $4f4a
	call AttachActorStepMover ; $4f4d
	ld de, wActors ; $4f50
	ld hl, $0014 ; $4f53
	add hl, de ; $4f56
	ld a, [hl] ; $4f57
	ld hl, ACTORF_HEADING ; $4f58
	add hl, bc ; $4f5b
	ld [hl], a ; $4f5c
	ld hl, $000c ; $4f5d
	add hl, de ; $4f60
	push hl ; $4f61
	ld hl, $000e ; $4f62
	add hl, de ; $4f65
	ld a, [hl+] ; $4f66
	ld d, [hl] ; $4f67
	ld e, a ; $4f68
	pop hl ; $4f69
	ld a, [hl+] ; $4f6a
	ld h, [hl] ; $4f6b
	ld l, a ; $4f6c
	call SetActorPosition ; $4f6d
.done:
	pop hl ; $4f70
	pop de ; $4f71
	pop bc ; $4f72
	pop af ; $4f73
	ret ; $4f74

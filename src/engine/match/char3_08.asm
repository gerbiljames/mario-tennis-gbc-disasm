SetMinigamePointTable:
	push hl ; $6728
	ld hl, wMinigamePointTable ; $6729
	ld a, e ; $672c
	ld [hl+], a ; $672d
	ld [hl], d ; $672e
	pop hl ; $672f
	ret ; $6730
SetBallGatePoint1:
	ld c, l ; $6731
	ld b, h ; $6732
	ld hl, wDrillGate1 + 2 ; $6733
	ld a, e ; $6736
	ld [hl+], a ; $6737
	ld [hl], d ; $6738
	ld hl, wDrillGate1 ; $6739
	ld a, c ; $673c
	ld [hl+], a ; $673d
	ld [hl], b ; $673e
	ret ; $673f
SetBallGatePoint2:
	ld c, l ; $6740
	ld b, h ; $6741
	ld hl, wDrillGate2 + 2 ; $6742
	ld a, e ; $6745
	ld [hl+], a ; $6746
	ld [hl], d ; $6747
	ld hl, wDrillGate2 ; $6748
	ld a, c ; $674b
	ld [hl+], a ; $674c
	ld [hl], b ; $674d
	ret ; $674e
SetTargetZoneCorner1:
	ld c, l ; $674f
	ld b, h ; $6750
	ld hl, wTargetZoneDepth1 ; $6751
	ld a, e ; $6754
	ld [hl+], a ; $6755
	ld [hl], d ; $6756
	ld hl, wTargetZoneX1 ; $6757
	ld a, c ; $675a
	ld [hl+], a ; $675b
	ld [hl], b ; $675c
	ret ; $675d
SetTargetZoneCorner2:
	ld c, l ; $675e
	ld b, h ; $675f
	ld hl, wTargetZoneDepth2 ; $6760
	ld a, e ; $6763
	ld [hl+], a ; $6764
	ld [hl], d ; $6765
	ld hl, wTargetZoneX2 ; $6766
	ld a, c ; $6769
	ld [hl+], a ; $676a
	ld [hl], b ; $676b
	ret ; $676c
DidBallCrossGate:
	ld hl, wDrillGate1 + 2 ; $676d
	ld a, [hl+] ; $6770
	ld b, [hl] ; $6771
	ld c, a ; $6772
	ld hl, wBallPrevDepth ; $6773
	ld a, [hl+] ; $6776
	ld d, [hl] ; $6777
	ld e, a ; $6778
	ld a, e ; $6779
	sub c ; $677a
	ld e, a ; $677b
	ld a, d ; $677c
	sbc b ; $677d
	ld d, a ; $677e
	ld hl, wBallDepth ; $677f
	ld a, [hl+] ; $6782
	ld h, [hl] ; $6783
	ld l, a ; $6784
	ld a, l ; $6785
	sub c ; $6786
	ld l, a ; $6787
	ld a, h ; $6788
	sbc b ; $6789
	ld h, a ; $678a
	ld a, h ; $678b
	xor d ; $678c
	bit 7, a ; $678d
	jr z, .no ; $678f
	ld hl, wDrillGate1 ; $6791
	ld a, [hl+] ; $6794
	ld d, [hl] ; $6795
	ld e, a ; $6796
	ld hl, wBallX ; $6797
	ld a, [hl+] ; $679a
	ld h, [hl] ; $679b
	ld l, a ; $679c
	ld a, l ; $679d
	sub e ; $679e
	ld l, a ; $679f
	ld a, h ; $67a0
	sbc d ; $67a1
	ld h, a ; $67a2
	bit 7, h ; $67a3
	jr nz, .no ; $67a5
	ld hl, wDrillGate2 ; $67a7
	ld a, [hl+] ; $67aa
	ld d, [hl] ; $67ab
	ld e, a ; $67ac
	ld hl, wBallX ; $67ad
	ld a, [hl+] ; $67b0
	ld h, [hl] ; $67b1
	ld l, a ; $67b2
	ld a, l ; $67b3
	sub e ; $67b4
	ld l, a ; $67b5
	ld a, h ; $67b6
	sbc d ; $67b7
	ld h, a ; $67b8
	bit 7, h ; $67b9
	jr z, .no ; $67bb
	xor a ; $67bd
	inc a ; $67be
	ret ; $67bf
.no:
	xor a ; $67c0
	ret ; $67c1
IsBallInTargetZone:
	push_wram_bank WRAM_ACTORS ; $67c2
	ld hl, wTargetZoneX1 ; $67cb
	ld a, [hl+] ; $67ce
	ld d, [hl] ; $67cf
	ld e, a ; $67d0
	ld hl, $fff0 ; $67d1
	add hl, de ; $67d4
	ld e, l ; $67d5
	ld d, h ; $67d6
	ld hl, wBallX ; $67d7
	ld a, [hl+] ; $67da
	ld h, [hl] ; $67db
	ld l, a ; $67dc
	ld a, l ; $67dd
	sub e ; $67de
	ld l, a ; $67df
	ld a, h ; $67e0
	sbc d ; $67e1
	ld h, a ; $67e2
	bit 7, h ; $67e3
	jr nz, .outside ; $67e5
	ld hl, wTargetZoneX2 ; $67e7
	ld a, [hl+] ; $67ea
	ld d, [hl] ; $67eb
	ld e, a ; $67ec
	ld hl, $0010 ; $67ed
	add hl, de ; $67f0
	ld e, l ; $67f1
	ld d, h ; $67f2
	ld hl, wBallX ; $67f3
	ld a, [hl+] ; $67f6
	ld h, [hl] ; $67f7
	ld l, a ; $67f8
	ld a, l ; $67f9
	sub e ; $67fa
	ld l, a ; $67fb
	ld a, h ; $67fc
	sbc d ; $67fd
	ld h, a ; $67fe
	bit 7, h ; $67ff
	jr z, .outside ; $6801
	ld hl, wTargetZoneDepth1 ; $6803
	ld a, [hl+] ; $6806
	ld d, [hl] ; $6807
	ld e, a ; $6808
	ld hl, $fff0 ; $6809
	add hl, de ; $680c
	ld e, l ; $680d
	ld d, h ; $680e
	ld hl, wBallDepth ; $680f
	ld a, [hl+] ; $6812
	ld h, [hl] ; $6813
	ld l, a ; $6814
	ld a, l ; $6815
	sub e ; $6816
	ld l, a ; $6817
	ld a, h ; $6818
	sbc d ; $6819
	ld h, a ; $681a
	bit 7, h ; $681b
	jr nz, .outside ; $681d
	ld hl, wTargetZoneDepth2 ; $681f
	ld a, [hl+] ; $6822
	ld d, [hl] ; $6823
	ld e, a ; $6824
	ld hl, $0010 ; $6825
	add hl, de ; $6828
	ld e, l ; $6829
	ld d, h ; $682a
	ld hl, wBallDepth ; $682b
	ld a, [hl+] ; $682e
	ld h, [hl] ; $682f
	ld l, a ; $6830
	ld a, l ; $6831
	sub e ; $6832
	ld l, a ; $6833
	ld a, h ; $6834
	sbc d ; $6835
	ld h, a ; $6836
	bit 7, h ; $6837
	jr z, .outside ; $6839
	pop_wram_bank ; $683b
	xor a ; $6840
	inc a ; $6841
	ret ; $6842
.outside:
	pop_wram_bank ; $6843
	xor a ; $6848
	ret ; $6849
InitChar:
	ld [wCharIndex], a ; $684a
	ld a, d ; $684d
	ld [wCharId], a ; $684e
	ld a, [wCharId] ; $6851
	farcall RemapExtendedCharId ; $6854
	ld [wCharSpriteSetId], a ; $6857
	ld a, [wCharSpriteSetId] ; $685a
	farcall LookupCharSpriteSet ; $685d
	ld d, a ; $6860
	ld a, e ; $6861
	add $03 ; $6862
	ld e, a ; $6864
	farcall SetupCharacterSprite ; $6865
	farcall LoadCharacterAttributes ; $6868
	ld a, CHARSTATE_INERT ; $686b
	call SetCharState ; $686d
	ld hl, $03c0 ; $6870
	ld de, $0000 ; $6873
	call SetCharPosAndTarget ; $6876
	ld a, $01 ; $6879
	ld [wCharInputSource], a ; $687b
	ret ; $687e
InitAllChars:
	wram_bank WRAM_CHAR3 ; $687f
	ld hl, wCharPosX ; $6885
	ld c, $10 ; $6888
	call ClearMemory16 ; $688a
	wram_bank WRAM_CHAR2 ; $688d
	ld hl, wCharPosX ; $6893
	ld c, $10 ; $6896
	call ClearMemory16 ; $6898
	wram_bank WRAM_CHAR1 ; $689b
	ld hl, wCharPosX ; $68a1
	ld c, $10 ; $68a4
	call ClearMemory16 ; $68a6
	wram_bank WRAM_CHAR0 ; $68a9
	ld hl, wCharPosX ; $68af
	ld c, $10 ; $68b2
	call ClearMemory16 ; $68b4
	ld b, $00 ; $68b7
	ld a, [wMatchIsDoubles] ; $68b9
	and a ; $68bc
	jr nz, .storeShadowFlag ; $68bd
	ld a, [wLinkSessionActive] ; $68bf
	and a ; $68c2
	jr nz, .storeShadowFlag ; $68c3
	ld b, $01 ; $68c5
.storeShadowFlag:
	ld a, b ; $68c7
	ld [wStandingShadowsEnabled], a ; $68c8
	ld a, [wOnCourtCharCountMinus1] ; $68cb
	rst Rst00 ; $68ce
	dw InitAllChars.char1 ; $68cf jumptable
	dw InitAllChars.char2 ; $68d1 jumptable
	dw InitAllChars.char3 ; $68d3 jumptable
	dw InitAllChars.char4 ; $68d5 jumptable
.char4:
	wram_bank WRAM_SCENE ; $68d7
	ld a, [wPlayer1CurrentPartnerCharacter] ; $68dd
	ld d, a ; $68e0
	ld a, [wPlayer1PartnerPalette] ; $68e1
	ld e, a ; $68e4
	ld a, $02 ; $68e5
	call InitChar ; $68e7
.char3:
	wram_bank WRAM_SOUND ; $68ea
	ld a, [wPlayer2CurrentPartnerCharacter] ; $68f0
	ld d, a ; $68f3
	ld a, [wPlayer2PartnerPalette] ; $68f4
	ld e, a ; $68f7
	ld a, $03 ; $68f8
	call InitChar ; $68fa
.char2:
	wram_bank WRAM_TEXT ; $68fd
	ld a, [wPlayer2CurrentMainCharacter] ; $6903
	ld d, a ; $6906
	ld a, [wPlayer2MainPalette] ; $6907
	ld e, a ; $690a
	ld a, $01 ; $690b
	call InitChar ; $690d
.char1:
	wram_bank WRAM_CHAR0 ; $6910
	ld a, [wPlayer1CurrentMainCharacter] ; $6916
	ld d, a ; $6919
	ld a, [wPlayer1MainPalette] ; $691a
	ld e, a ; $691d
	ld a, $00 ; $691e
	call InitChar ; $6920
	ld a, $00 ; $6923
	ld [wCharInputSource], a ; $6925
	farcall LoadOnCourtCharacterGfx ; $6928
	ret ; $692b
UpdateAllChars:
	wram_bank WRAM_CHAR0 ; $692c
	call UpdateChar ; $6932
	wram_bank WRAM_CHAR1 ; $6935
	call UpdateChar ; $693b
	wram_bank WRAM_CHAR2 ; $693e
	call UpdateChar ; $6944
	wram_bank WRAM_CHAR3 ; $6947
	call UpdateChar ; $694d
	wram_bank WRAM_CHAR0 ; $6950
	ret ; $6956
StubNop_08:
	ret ; $6957
UpdateChar:
	ld a, [wCharObjectBank] ; $6958
	and a ; $695b
	ret z ; $695c
	call UpdateCharBallGeometry ; $695d
	call ReadCharInput ; $6960
	call UpdateCharStateMachine ; $6963
	call CheckCharBallContact ; $6966
	call UpdateCharVelocityFromInput ; $6969
	call StepCharMovement ; $696c
	call StepCharJumpPhysics ; $696f
	call EaseCharFacing ; $6972
	call StepCharAnimation ; $6975
	call UpdateCharFacingOctant ; $6978
	call ReloadCharFacingTiles ; $697b
	call BuildCharSpriteSlots ; $697e
	call UpdateChargeFlash ; $6981
	call BuildAirborneShadowSlot ; $6984
	ret ; $6987
SetCharPosAndTarget:
	ld c, l ; $6988
	ld b, h ; $6989
	ld hl, wCharPosDepth ; $698a
	xor a ; $698d
	ld [hl+], a ; $698e
	ld a, e ; $698f
	ld [hl+], a ; $6990
	ld [hl], d ; $6991
	ld hl, wCharWalkTargetDepth ; $6992
	ld a, e ; $6995
	ld [hl+], a ; $6996
	ld [hl], d ; $6997
	ld hl, wCharPosX ; $6998
	xor a ; $699b
	ld [hl+], a ; $699c
	ld a, c ; $699d
	ld [hl+], a ; $699e
	ld [hl], b ; $699f
	ld hl, wCharWalkTargetX ; $69a0
	ld a, c ; $69a3
	ld [hl+], a ; $69a4
	ld [hl], b ; $69a5
	ld hl, wCharPosHeight ; $69a6
	xor a ; $69a9
	ld [hl+], a ; $69aa
	ld [hl+], a ; $69ab
	ld [hl+], a ; $69ac
	ret ; $69ad
SetCharTarget:
	ld c, l ; $69ae
	ld b, h ; $69af
	ld hl, wCharWalkTargetDepth ; $69b0
	ld a, e ; $69b3
	ld [hl+], a ; $69b4
	ld [hl], d ; $69b5
	ld hl, wCharWalkTargetX ; $69b6
	ld a, c ; $69b9
	ld [hl+], a ; $69ba
	ld [hl], b ; $69bb
	ld hl, wCharWalkTargetFlag ; $69bc
	ld [hl], $00 ; $69bf
	ret ; $69c1
ReloadCharFrameGfx:
	ld a, [wCharSpriteAttr] ; $69c2
	and $07 ; $69c5
	add $08 ; $69c7
	ld d, a ; $69c9
	ld a, [wCharGfxBank] ; $69ca
	ld b, a ; $69cd
	ld hl, $0110 ; $69ce
	call FarCallVector ; $69d1
	ret ; $69d4
LoadCharChargeFlashGfx:
	ld a, [wCharSpriteAttr] ; $69d5
	and $07 ; $69d8
	add $08 ; $69da
	ld d, a ; $69dc
	ld a, [wCharGfxBank] ; $69dd
	add $08 ; $69e0
	ld b, a ; $69e2
	ld hl, $0110 ; $69e3
	call FarCallVector ; $69e6
	ret ; $69e9
SetCharAnimation:
	ld hl, wCharAnimId ; $69ea
	ld a, [hl] ; $69ed
	cp d ; $69ee
	ret z ; $69ef
	ld [hl], d ; $69f0
	xor a ; $69f1
	ld [wCharAnimDelay], a ; $69f2
	ld hl, wCharSpriteAttr ; $69f5
	ld a, [hl] ; $69f8
	and $0f ; $69f9
	ld [hl], a ; $69fb
	ld hl, wCharAnimTablePtr ; $69fc
	ld a, [hl+] ; $69ff
	ld h, [hl] ; $6a00
	ld l, a ; $6a01
	ld a, d ; $6a02
	add a ; $6a03
	add l ; $6a04
	ld l, a ; $6a05
	jr nc, .readAnimPtr ; $6a06
	inc h ; $6a08
.readAnimPtr:
	ld a, [wCharObjectBank] ; $6a09
	call FarReadWordDI ; $6a0c
	ld hl, wCharAnimScriptBase ; $6a0f
	ld a, c ; $6a12
	ld [hl+], a ; $6a13
	ld [hl], b ; $6a14
	ld hl, wCharAnimScriptPtr ; $6a15
	ld a, c ; $6a18
	ld [hl+], a ; $6a19
	ld [hl], b ; $6a1a
	ret ; $6a1b
SetCharState:
	ld hl, wCharState ; $6a1c
	ld [hl+], a ; $6a1f
	xor a ; $6a20
	ld [hl+], a ; $6a21
	ld [hl+], a ; $6a22
	ld hl, wCharFreezeTimer ; $6a23
	ld [hl+], a ; $6a26
	ld hl, wAiActionTimer ; $6a27
	ld [hl+], a ; $6a2a
	ret ; $6a2b
SetCharFacing:
	ld [wCharFacingDesired], a ; $6a2c
	ld [wCharFacingShown], a ; $6a2f
	ret ; $6a32
FlipCharPositionCode:
	ld hl, wCharCourtPos ; $6a33
	ld a, [hl] ; $6a36
	xor b ; $6a37
	ld [hl], a ; $6a38
	ret ; $6a39
ForEachCharBank:
	push hl ; $6a3a
	wram_bank WRAM_CHAR3 ; $6a3b
	call JumpToHL ; $6a41
	pop hl ; $6a44
	push hl ; $6a45
	wram_bank WRAM_CHAR2 ; $6a46
	call JumpToHL ; $6a4c
	pop hl ; $6a4f
	push hl ; $6a50
	wram_bank WRAM_CHAR1 ; $6a51
	call JumpToHL ; $6a57
	pop hl ; $6a5a
	wram_bank WRAM_CHAR0 ; $6a5b
	jp hl ; $6a61
UpdateCharStateMachine:
	xor a ; $6a62
	ld [wCharScriptedMove], a ; $6a63
	ld hl, wCharFreezeTimer ; $6a66
	ld a, [hl] ; $6a69
	and a ; $6a6a
	jr z, .dispatch ; $6a6b
	dec [hl] ; $6a6d
	ret ; $6a6e
.dispatch:
	ld hl, wCharShotComboTimer ; $6a6f
	ld a, [hl] ; $6a72
	and a ; $6a73
	jr z, .runState ; $6a74
	dec [hl] ; $6a76
.runState:
	ld a, [wCharState] ; $6a77
	rst Rst00 ; $6a7a
	dw AdvanceCharStatePhase.done ; $6a7b jumptable
	dw CharRallyState ; $6a7d jumptable
	dw CharServeStrikePhase.dispatch ; $6a7f jumptable
	dw CharServeState ; $6a81 jumptable
	dw CharAwaitServeState ; $6a83 jumptable
	dw CharStandbyState ; $6a85 jumptable
	dw CharWalkState ; $6a87 jumptable
	dw CharPointEndState ; $6a89 jumptable
AdvanceCharStatePhase:
	ld hl, wCharStatePhase ; $6a8b
	inc [hl] ; $6a8e
.done:
	ret ; $6a8f
CharRallyEndState:
	ld a, [wCharAnimId] ; $6a90
	cp CHARANIM_FOREHAND ; $6a93
	jr z, .clearShot ; $6a95
	cp CHARANIM_BACKHAND ; $6a97
	jr z, .clearShot ; $6a99
	cp CHARANIM_OVERHEAD ; $6a9b
	jr z, .clearShot ; $6a9d
	cp CHARANIM_FOREHAND_QUICK ; $6a9f
	jr z, .clearShot ; $6aa1
	cp CHARANIM_BACKHAND_QUICK ; $6aa3
	jr z, .clearShot ; $6aa5
	cp CHARANIM_OVERHEAD_QUICK ; $6aa7
	jr z, .clearShot ; $6aa9
	cp CHARANIM_DIVE ; $6aab
	jr z, .clearShot ; $6aad
	ld hl, wCharFlags ; $6aaf
	bit CHARB_AIRBORNE, [hl] ; $6ab2
	jr nz, .clearShot ; $6ab4
	xor a ; $6ab6
	ld [wCharShotButton1], a ; $6ab7
	ld [wCharShotButton2], a ; $6aba
	ld [wCharLastShotButton], a ; $6abd
	ld [wCharSwingFrames], a ; $6ac0
	ld hl, wCharFlags ; $6ac3
	res CHARB_RECOIL, [hl] ; $6ac6
	res CHARB_DIVING, [hl] ; $6ac8
	res CHARB_CHARGING, [hl] ; $6aca
	ld hl, wCharStatePhase ; $6acc
	inc [hl] ; $6acf
.clearShot:
	xor a ; $6ad0
	ld [wCharShotButton1], a ; $6ad1
	ld [wCharShotButton2], a ; $6ad4
	ld [wCharRallyReady], a ; $6ad7
	xor a ; $6ada
	ld [wCharChargeFlashOn], a ; $6adb
	call EndChargeFlash ; $6ade
	ret ; $6ae1
CharServeState:
	ld a, [wCharStatePhase] ; $6ae2
	rst Rst00 ; $6ae5
	dw CharServeInitPhase ; $6ae6 jumptable
	dw CharServeInitPhase.waitAnim ; $6ae8 jumptable
	dw CharServeTossPhase ; $6aea jumptable
	dw CharServeSwingWindowPhase ; $6aec jumptable
	dw CharServeStrikePhase ; $6aee jumptable
	dw AdvanceCharStatePhase.done ; $6af0 jumptable
CharServeInitPhase:
	call ResetBallState ; $6af2
	xor a ; $6af5
	ld [wCharShotButton1], a ; $6af6
	ld [wCharShotButton2], a ; $6af9
	ld [wCharLastShotButton], a ; $6afc
	ld hl, wCharFlags ; $6aff
	res CHARB_RECOIL, [hl] ; $6b02
	res CHARB_DIVING, [hl] ; $6b04
	ld a, [wMinigameUsesTennisMachine] ; $6b06
	and a ; $6b09
	jr nz, .startAnim ; $6b0a
	ld a, [wMinigameUsesWall] ; $6b0c
	and a ; $6b0f
	jr nz, .startAnim ; $6b10
	ld a, [wMinigameIsBooBlast] ; $6b12
	and a ; $6b15
	jr nz, .startAnim ; $6b16
	push_wram_bank WRAM_CHAR0 ; $6b18
	farcall SpawnServeIndicatorObjs ; $6b21
	pop_wram_bank ; $6b24
.startAnim:
	ld d, CHARANIM_SERVE_PREP ; $6b29
	call SetCharAnimation ; $6b2b
	ld hl, wCharStatePhase ; $6b2e
	inc [hl] ; $6b31
	ret ; $6b32
.waitAnim:
	ld a, [wCharAnimId] ; $6b33
	cp CHARANIM_SERVE_READY ; $6b36
	jr nz, .done ; $6b38
	ld hl, wCharStatePhase ; $6b3a
	inc [hl] ; $6b3d
.done:
	ret ; $6b3e
CharServeTossPhase:
	call HandleServePositioning ; $6b3f
	ld a, [wCharInputBits] ; $6b42
	and PADF_A | PADF_B ; $6b45
	jr z, .done ; $6b47
	ld bc, rWBK ; $6b49
	ld hl, wCharPosDepth + 1 ; $6b4c
	ld a, [hl+] ; $6b4f
	ld d, [hl] ; $6b50
	ld e, a ; $6b51
	ld hl, wCharPosX + 1 ; $6b52
	ld a, [hl+] ; $6b55
	ld h, [hl] ; $6b56
	ld l, a ; $6b57
	call SetBallPosition ; $6b58
	ld hl, $0b00 ; $6b5b
	ld bc, $c000 ; $6b5e
	ld de, $0000 ; $6b61
	call SetBallVelocityPolar ; $6b64
	ld a, $01 ; $6b67
	ld [wBallSpriteEnabled], a ; $6b69
	ld [wBallShadowEnabled], a ; $6b6c
	ld [wBallTrailEnabled], a ; $6b6f
	push_wram_bank WRAM_CHAR0 ; $6b72
	farcall DismissServeIndicatorObjs ; $6b7b
	pop_wram_bank ; $6b7e
	ld d, CHARANIM_OVERHEAD_READY ; $6b83
	call SetCharAnimation ; $6b85
	ld hl, wCharStatePhase ; $6b88
	inc [hl] ; $6b8b
.done:
	ret ; $6b8c
CharServeSwingWindowPhase:
	ld hl, wBallVelocityHeight + 1 ; $6b8d
	bit 7, [hl] ; $6b90
	jr nz, .checkButton ; $6b92
	ld hl, wCharReachHeight ; $6b94
	ld a, [hl+] ; $6b97
	ld b, [hl] ; $6b98
	ld c, a ; $6b99
	ld hl, wBallHeight ; $6b9a
	ld a, [hl+] ; $6b9d
	ld h, [hl] ; $6b9e
	ld l, a ; $6b9f
	add hl, bc ; $6ba0
	jr nc, .checkButton ; $6ba1
	ld hl, wCharStatePhase ; $6ba3
	ld [hl], $00 ; $6ba6
	ret ; $6ba8
.checkButton:
	call BufferShotButtonPress ; $6ba9
	and a ; $6bac
	jr z, .done ; $6bad
	ld a, CHARANIM_OVERHEAD ; $6baf
	ld [wCharSwingAnim], a ; $6bb1
	ld d, a ; $6bb4
	call SetCharAnimation ; $6bb5
	ld hl, wCharStatePhase ; $6bb8
	inc [hl] ; $6bbb
	ld hl, wCourtViewLocked ; $6bbc
	set 1, [hl] ; $6bbf
.done:
	ret ; $6bc1
CharServeStrikePhase:
	call BufferShotButtonPress ; $6bc2
	ld a, [wCharShotComboTimer] ; $6bc5
	and a ; $6bc8
	jr nz, .done ; $6bc9
	call CaptureServeAim ; $6bcb
	call SelectServeShotType ; $6bce
	farcall ExecuteShot ; $6bd1
	ld hl, wCharStatePhase ; $6bd4
	inc [hl] ; $6bd7
.done:
	ret ; $6bd8
.dispatch:
	ld a, [wCharStatePhase] ; $6bd9
	rst Rst00 ; $6bdc
	dw CharRallyEndState ; $6bdd jumptable
	dw CharServeStrikePhase.runMovement ; $6bdf jumptable
	dw AdvanceCharStatePhase.done ; $6be1 jumptable
.runMovement:
	call ApplyCharMovementInput ; $6be3
	call UpdateCharRunAnimation ; $6be6
	ret ; $6be9
CharRallyState:
	ld a, [wCharStatePhase] ; $6bea
	rst Rst00 ; $6bed
	dw CharRallyEndState ; $6bee jumptable
	dw CharRallyReadyPhase ; $6bf0 jumptable
	dw CharSwingWindupPhase ; $6bf2 jumptable
	dw CharSwingContactPhase ; $6bf4 jumptable
	dw AdvanceCharStatePhase.done ; $6bf6 jumptable
CharRallyReadyPhase:
	ld a, $01 ; $6bf8
	ld [wCharRallyReady], a ; $6bfa
	call ApplyCharMovementInput ; $6bfd
	call UpdateCharRunAnimation ; $6c00
	call BufferShotButtonPress ; $6c03
	and a ; $6c06
	jr z, .done ; $6c07
	call SelectForehandBackhand ; $6c09
	ld hl, wCharSwingAnim ; $6c0c
	ld a, $08 ; $6c0f
	add [hl] ; $6c11
	ld d, a ; $6c12
	call SetCharAnimation ; $6c13
	ld hl, wCharFlags ; $6c16
	set CHARB_CHARGING, [hl] ; $6c19
	xor a ; $6c1b
	ld [wCharSwingFrames], a ; $6c1c
	ld [wCharSwingHoldButton], a ; $6c1f
	ld [wCharSwingHoldFrames], a ; $6c22
	ld a, $01 ; $6c25
	ld [wCharChargeFlashOn], a ; $6c27
	ld hl, wCharStatePhase ; $6c2a
	inc [hl] ; $6c2d
.done:
	ret ; $6c2e
CharSwingWindupPhase:
	ld hl, wCharSwingFrames ; $6c2f
	inc [hl] ; $6c32
	call ApplyCharMovementInput ; $6c33
	call BufferShotButtonPress ; $6c36
	call CheckSwingRelease ; $6c39
	and a ; $6c3c
	jr nz, .abort ; $6c3d
	ld hl, wCharBallReachFlags ; $6c3f
	bit 0, [hl] ; $6c42
	jr nz, .startSwing ; $6c44
	ret ; $6c46
.startSwing:
	call StartCharSwing ; $6c47
	ld hl, wCharSwingAnim ; $6c4a
	ld d, [hl] ; $6c4d
	call SetCharAnimation ; $6c4e
	sound SFX_SWING_CHARGE ; $6c51
	xor a ; $6c53
	ld [wCharChargeFlashOn], a ; $6c54
	call EndChargeFlash ; $6c57
	ld hl, wCharStatePhase ; $6c5a
	inc [hl] ; $6c5d
	ret ; $6c5e
.abort:
	ld hl, wCharFlags ; $6c5f
	res CHARB_CHARGING, [hl] ; $6c62
	xor a ; $6c64
	ld [wCharChargeFlashOn], a ; $6c65
	call EndChargeFlash ; $6c68
	xor a ; $6c6b
	ld [wCharShotButton1], a ; $6c6c
	ld [wCharShotButton2], a ; $6c6f
	ld [wCharLastShotButton], a ; $6c72
	ld hl, wCharStatePhase ; $6c75
	dec [hl] ; $6c78
	ret ; $6c79
CharSwingContactPhase:
	ld hl, wCharSwingFrames ; $6c7a
	inc [hl] ; $6c7d
	call ApplyCharMovementInput ; $6c7e
	call CaptureShotAim ; $6c81
	call ResetSwingAnimation ; $6c84
	ld hl, wCharBallReachFlags ; $6c87
	bit 1, [hl] ; $6c8a
	jr z, .done ; $6c8c
	call SelectRallyShotType ; $6c8e
	farcall ExecuteShot ; $6c91
	ld hl, wCharStatePhase ; $6c94
	inc [hl] ; $6c97
.done:
	ret ; $6c98

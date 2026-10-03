CheckBallContactWindow:
	ld hl, wBallRelCharDepth ; $6fa7
	ld a, [hl+] ; $6faa
	ld h, [hl] ; $6fab
	ld l, a ; $6fac
	bit 7, h ; $6fad
	jr z, .checkHeight ; $6faf
	xor a ; $6fb1
	sub l ; $6fb2
	ld l, a ; $6fb3
	sbc a ; $6fb4
	sub h ; $6fb5
	ld h, a ; $6fb6
.checkHeight:
	ld de, $ffa0 ; $6fb7
	add hl, de ; $6fba
	ret c ; $6fbb
	ld hl, wCharReachX ; $6fbc
	ld a, [hl+] ; $6fbf
	ld h, [hl] ; $6fc0
	ld l, a ; $6fc1
	ld e, l ; $6fc2
	ld d, h ; $6fc3
	ld a, [wCharFlags] ; $6fc4
	bit CHARB_DIVING, a ; $6fc7
	jr z, .checkState ; $6fc9
	ld l, e ; $6fcb
	ld h, d ; $6fcc
	sra d ; $6fcd
	rr e ; $6fcf
	sra d ; $6fd1
	rr e ; $6fd3
	add hl, de ; $6fd5
	ld e, l ; $6fd6
	ld d, h ; $6fd7
	jr .checkX ; $6fd8
.checkState:
	ld a, [wCharAnimId] ; $6fda
	cp CHARANIM_FOREHAND ; $6fdd
	jr z, .checkX ; $6fdf
	cp CHARANIM_BACKHAND ; $6fe1
	jr z, .checkX ; $6fe3
	cp CHARANIM_FOREHAND_QUICK ; $6fe5
	jr z, .checkX ; $6fe7
	cp CHARANIM_BACKHAND_QUICK ; $6fe9
	jr z, .checkX ; $6feb
.checkX:
	ld hl, wBallRelCharX ; $6fed
	ld a, [hl+] ; $6ff0
	ld h, [hl] ; $6ff1
	ld l, a ; $6ff2
	bit 7, h ; $6ff3
	jr z, .compare ; $6ff5
	xor a ; $6ff7
	sub l ; $6ff8
	ld l, a ; $6ff9
	sbc a ; $6ffa
	sub h ; $6ffb
	ld h, a ; $6ffc
.compare:
	ld a, l ; $6ffd
	sub e ; $6ffe
	ld l, a ; $6fff
	ld a, h ; $7000
	sbc d ; $7001
	ld h, a ; $7002
	ret nc ; $7003
	ld hl, wCharReachHeight ; $7004
	ld a, [hl+] ; $7007
	ld h, [hl] ; $7008
	ld l, a ; $7009
	add hl, hl ; $700a
	ld e, l ; $700b
	ld d, h ; $700c
	ld hl, wBallRelCharHeight ; $700d
	ld a, [hl+] ; $7010
	ld h, [hl] ; $7011
	ld l, a ; $7012
	bit 7, h ; $7013
	jr z, .done ; $7015
	xor a ; $7017
	sub l ; $7018
	ld l, a ; $7019
	sbc a ; $701a
	sub h ; $701b
	ld h, a ; $701c
.done:
	ld a, l ; $701d
	sub e ; $701e
	ld l, a ; $701f
	ld a, h ; $7020
	sbc d ; $7021
	ld h, a ; $7022
	ret nc ; $7023
	ld hl, wCharBallReachFlags ; $7024
	set 1, [hl] ; $7027
	ret ; $7029
CheckBallInSwingRange:
	ld hl, wBallRelCharDepth ; $702a
	ld a, [hl+] ; $702d
	ld h, [hl] ; $702e
	ld l, a ; $702f
	bit 7, h ; $7030
	jr z, .checkDepth ; $7032
	xor a ; $7034
	sub l ; $7035
	ld l, a ; $7036
	sbc a ; $7037
	sub h ; $7038
	ld h, a ; $7039
.checkDepth:
	ld de, $ff60 ; $703a
	add hl, de ; $703d
	ret c ; $703e
	ld hl, wCharReachX ; $703f
	ld a, [hl+] ; $7042
	ld h, [hl] ; $7043
	ld l, a ; $7044
	ld e, l ; $7045
	ld d, h ; $7046
	sra d ; $7047
	rr e ; $7049
	add hl, de ; $704b
	ld e, l ; $704c
	ld d, h ; $704d
	ld hl, wBallRelCharX ; $704e
	ld a, [hl+] ; $7051
	ld h, [hl] ; $7052
	ld l, a ; $7053
	bit 7, h ; $7054
	jr z, .done ; $7056
	xor a ; $7058
	sub l ; $7059
	ld l, a ; $705a
	sbc a ; $705b
	sub h ; $705c
	ld h, a ; $705d
.done:
	ld a, l ; $705e
	sub e ; $705f
	ld l, a ; $7060
	ld a, h ; $7061
	sbc d ; $7062
	ld h, a ; $7063
	ret nc ; $7064
	ld hl, wCharBallReachFlags ; $7065
	set 0, [hl] ; $7068
	ret ; $706a
SelectServeShotType:
	ld a, [wCharShotButton1] ; $706b
	ld_hl_indexed SelectServeShotType_CharShotTypeTable ; $706e
	ld a, [hl] ; $7075
	ld [wCharShotType], a ; $7076
	ret ; $7079
SelectServeShotType_CharShotTypeTable:
	; $707a, 4 bytes (enum:SHOTTYPE:4)
	db SHOTTYPE_SERVE_TOPSPIN, SHOTTYPE_SERVE_TOPSPIN, SHOTTYPE_SERVE_SLICE, SHOTTYPE_SERVE_FLAT ; 0x00
SelectRallyShotType:
	ld a, [wCharShotButton2] ; $707e
	add a ; $7081
	add a ; $7082
	ld d, a ; $7083
	ld a, [wCharShotButton1] ; $7084
	add d ; $7087
	ld e, a ; $7088
	ld d, $00 ; $7089
	ld hl, wCharBallReachFlags ; $708b
	bit 4, [hl] ; $708e
	jr z, SelectRallyShotType.neutralTable ; $7090
	ld hl, RallyShotTypeTable0 ; $7092
	add hl, de ; $7095
	ld a, [hl] ; $7096
	ld [wCharShotType], a ; $7097
	ret ; $709a
RallyShotTypeTable0:
	; $709b, 16 bytes (enum:SHOTTYPE:4)
	db SHOTTYPE_REACH_BASIC, SHOTTYPE_REACH_BASIC, SHOTTYPE_REACH_BASIC, SHOTTYPE_NEUTRAL ; 0x00
	db SHOTTYPE_REACH_BASIC, SHOTTYPE_REACH_POWER_TOPSPIN, SHOTTYPE_DROP, SHOTTYPE_NEUTRAL ; 0x04
	db SHOTTYPE_REACH_BASIC, SHOTTYPE_LOB, SHOTTYPE_REACH_POWER_SLICE, SHOTTYPE_NEUTRAL ; 0x08
	db SHOTTYPE_NEUTRAL, SHOTTYPE_NEUTRAL, SHOTTYPE_NEUTRAL, SHOTTYPE_NEUTRAL ; 0x0c
SelectRallyShotType.neutralTable:
	ld hl, RallyShotTypeTable1 ; $70ab
	add hl, de ; $70ae
	ld a, [hl] ; $70af
	ld [wCharShotType], a ; $70b0
	ret ; $70b3
RallyShotTypeTable1:
	; $70b4, 16 bytes (enum:SHOTTYPE:4)
	db SHOTTYPE_TOPSPIN, SHOTTYPE_TOPSPIN, SHOTTYPE_SLICE, SHOTTYPE_NEUTRAL ; 0x00
	db SHOTTYPE_TOPSPIN, SHOTTYPE_POWER_TOPSPIN, SHOTTYPE_DROP, SHOTTYPE_NEUTRAL ; 0x04
	db SHOTTYPE_TOPSPIN, SHOTTYPE_LOB, SHOTTYPE_POWER_SLICE, SHOTTYPE_NEUTRAL ; 0x08
	db SHOTTYPE_NEUTRAL, SHOTTYPE_NEUTRAL, SHOTTYPE_NEUTRAL, SHOTTYPE_NEUTRAL ; 0x0c
Unused_08_ComputeBallEtaToChar:
	ld hl, wBallVelocityDepth ; $70c4
	ld a, [hl+] ; $70c7
	ld d, [hl] ; $70c8
	ld e, a ; $70c9
	ld hl, wBallRelCharDepth + 1 ; $70ca
	bit 7, [hl] ; $70cd
	jr nz, .farSide ; $70cf
	ld l, $00 ; $70d1
	ld a, [wBallRelCharDepth] ; $70d3
	ld h, a ; $70d6
	ld a, [wBallRelCharDepth + 1] ; $70d7
	call DivAHLByDE ; $70da
	ld e, l ; $70dd
	ld d, h ; $70de
	ret ; $70df
.farSide:
	ld l, $ff ; $70e0
	ld a, [wBallRelCharDepth] ; $70e2
	cpl ; $70e5
	ld h, a ; $70e6
	ld a, [wBallRelCharDepth + 1] ; $70e7
	cpl ; $70ea
	call DivAHLByDE ; $70eb
	ld e, l ; $70ee
	ld d, h ; $70ef
	ret ; $70f0
UnusedComputeBallEtaToCharWrapper:
	call Unused_08_ComputeBallEtaToChar ; $70f1
	ret ; $70f4
PredictBallLateralOffset:
	ld hl, wBallHeadingAngle ; $70f5
	ld a, [hl+] ; $70f8
	ld b, [hl] ; $70f9
	ld c, a ; $70fa
	ld hl, wBallRelCharDepth ; $70fb
	ld a, [hl+] ; $70fe
	ld h, [hl] ; $70ff
	ld l, a ; $7100
	xor a ; $7101
	sub l ; $7102
	ld l, a ; $7103
	sbc a ; $7104
	sub h ; $7105
	ld h, a ; $7106
	call MulHLByTangent ; $7107
	ld hl, wBallRelCharX ; $710a
	ld a, [hl+] ; $710d
	ld h, [hl] ; $710e
	ld l, a ; $710f
	add hl, de ; $7110
	ret ; $7111
BufferShotButtonPress:
	ld a, [wCharInputBits] ; $7112
	and PADF_A | PADF_B ; $7115
	ret z ; $7117
	ld b, a ; $7118
	cp PADF_A | PADF_B ; $7119
	jr z, .done ; $711b
	ld a, [wCharShotComboTimer] ; $711d
	and a ; $7120
	jr z, .startSwing ; $7121
	ld a, [wCharLastShotButton] ; $7123
	cp b ; $7126
	jr z, .startSwing ; $7127
	ld b, $03 ; $7129
	jr .done ; $712b
.startSwing:
	ld a, b ; $712d
	ld [wCharLastShotButton], a ; $712e
	ld a, $05 ; $7131
	ld [wCharShotComboTimer], a ; $7133
	ld a, [wCharShotButton1] ; $7136
	and a ; $7139
	jr z, .done ; $713a
	ld a, [wCharShotButton2] ; $713c
	and a ; $713f
	jr z, .storeShot ; $7140
	ret ; $7142
.storeShot:
	ld a, b ; $7143
	ld [wCharShotButton2], a ; $7144
	xor a ; $7147
	ld [wCharShotComboTimer], a ; $7148
	ret ; $714b
.done:
	ld a, b ; $714c
	ld [wCharShotButton1], a ; $714d
	ret ; $7150
CaptureServeAim:
	ld a, [wCharInputBits] ; $7151
	ld b, $01 ; $7154
	bit PADB_RIGHT, a ; $7156
	jr nz, .store ; $7158
	ld b, $ff ; $715a
	bit PADB_LEFT, a ; $715c
	jr nz, .store ; $715e
	ld b, $00 ; $7160
.store:
	ld a, b ; $7162
	ld [wCharAimOffset], a ; $7163
	ret ; $7166
CaptureShotAim:
	ld a, [wCharInputBits] ; $7167
	cp PADF_LEFT ; $716a
	jr z, .aimFarLeft ; $716c
	bit PADB_LEFT, a ; $716e
	jr nz, .aimLeft ; $7170
	cp PADF_RIGHT ; $7172
	jr z, .aimFarRight ; $7174
	bit PADB_RIGHT, a ; $7176
	jr nz, .aimRight ; $7178
	jr .aimCentre ; $717a
.aimFarLeft:
	ld a, $fe ; $717c
	ld [wCharAimOffset], a ; $717e
	ret ; $7181
.aimLeft:
	ld a, $ff ; $7182
	ld [wCharAimOffset], a ; $7184
	ret ; $7187
.aimCentre:
	ld a, $00 ; $7188
	ld [wCharAimOffset], a ; $718a
	ret ; $718d
.aimRight:
	ld a, $01 ; $718e
	ld [wCharAimOffset], a ; $7190
	ret ; $7193
.aimFarRight:
	ld a, $02 ; $7194
	ld [wCharAimOffset], a ; $7196
	ret ; $7199
ApplyCharMovementInput:
	ld a, [wCharInputBits] ; $719a
	and $f0 ; $719d
	jr z, .done ; $719f
	swap a ; $71a1
	ld_hl_indexed DpadToFacingTable_08 ; $71a3
	ld a, [hl] ; $71aa
	cp $ff ; $71ab
	jr z, .done ; $71ad
	ld [wCharFacingDesired], a ; $71af
	ld a, [wCharFacingDesired] ; $71b2
	ld hl, wCharFacingShown ; $71b5
	sub [hl] ; $71b8
	bit 7, a ; $71b9
	jr z, .checkTurnLimit ; $71bb
	cpl ; $71bd
	inc a ; $71be
.checkTurnLimit:
	cp $30 ; $71bf
	jp nc, .done ; $71c1
	ld a, [wCharInputBits] ; $71c4
	and PADF_RIGHT | PADF_LEFT ; $71c7
	jr z, .checkVertical ; $71c9
	ld hl, wCharBallReachFlags ; $71cb
	set 6, [hl] ; $71ce
.checkVertical:
	ld a, [wCharInputBits] ; $71d0
	and PADF_UP | PADF_DOWN ; $71d3
	jr z, .done ; $71d5
	ld hl, wCharBallReachFlags ; $71d7
	set 7, [hl] ; $71da
.done:
	ret ; $71dc
HandleServePositioning:
	ld a, [wMinigameUsesWall] ; $71dd
	and a ; $71e0
	jr nz, .receiver ; $71e1
	ld a, [wCharInputBits] ; $71e3
	and PADF_RIGHT | PADF_LEFT ; $71e6
	jr z, .done ; $71e8
	swap a ; $71ea
	ld_hl_indexed DpadToFacingTable_08 ; $71ec
	ld a, [hl] ; $71f3
	cp $ff ; $71f4
	jr z, .done ; $71f6
	ld hl, $000a ; $71f8
	call VectorFromLengthAndAngleRaw ; $71fb
	ld c, l ; $71fe
	ld b, h ; $71ff
	ld hl, wCharPosX + 1 ; $7200
	ld a, [hl+] ; $7203
	ld h, [hl] ; $7204
	ld l, a ; $7205
	add hl, bc ; $7206
	bit 7, h ; $7207
	jr z, .stepToward ; $7209
	xor a ; $720b
	sub l ; $720c
	ld l, a ; $720d
	sbc a ; $720e
	sub h ; $720f
	ld h, a ; $7210
.stepToward:
	push hl ; $7211
	ld de, $ffe0 ; $7212
	add hl, de ; $7215
	pop hl ; $7216
	jr nc, .done ; $7217
	ld de, $fe80 ; $7219
	add hl, de ; $721c
	jr c, .done ; $721d
	ld hl, wCharPosX + 1 ; $721f
	ld a, [hl] ; $7222
	add c ; $7223
	ld [hl+], a ; $7224
	ld a, [hl] ; $7225
	adc b ; $7226
	ld [hl+], a ; $7227
.done:
	ret ; $7228
.receiver:
	ld a, [wCharInputBits] ; $7229
	and PADF_RIGHT | PADF_LEFT ; $722c
	jr z, .receiverDone ; $722e
	swap a ; $7230
	ld_hl_indexed DpadToFacingTable_08 ; $7232
	ld a, [hl] ; $7239
	cp $ff ; $723a
	jr z, .receiverDone ; $723c
	ld hl, $000a ; $723e
	call VectorFromLengthAndAngleRaw ; $7241
	ld c, l ; $7244
	ld b, h ; $7245
	ld hl, wCharPosX + 1 ; $7246
	ld a, [hl+] ; $7249
	ld h, [hl] ; $724a
	ld l, a ; $724b
	add hl, bc ; $724c
	bit 7, h ; $724d
	jr z, .receiverStep ; $724f
	xor a ; $7251
	sub l ; $7252
	ld l, a ; $7253
	sbc a ; $7254
	sub h ; $7255
	ld h, a ; $7256
.receiverStep:
	ld de, $fe80 ; $7257
	add hl, de ; $725a
	jr c, .receiverDone ; $725b
	ld hl, wCharPosX + 1 ; $725d
	ld a, [hl] ; $7260
	add c ; $7261
	ld [hl+], a ; $7262
	ld a, [hl] ; $7263
	adc b ; $7264
	ld [hl+], a ; $7265
.receiverDone:
	ret ; $7266
CheckSwingRelease:
	ld a, [wCharInputBits] ; $7267
	and PADF_SELECT ; $726a
	jr z, UnusedLatchSwingHoldButton.tickTimer ; $726c
	xor a ; $726e
	ld [wCharSwingHoldButton], a ; $726f
	ld [wCharSwingHoldFrames], a ; $7272
	ld a, $01 ; $7275
	ret ; $7277

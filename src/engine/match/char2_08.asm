StartCharChangeoverWalk:
	ld a, CHARSTATE_WALK ; $5fe5
	call SetCharState ; $5fe7
	ld a, $80 ; $5fea
	call SetCharFacing ; $5fec
	call GetCharChangeoverPosition ; $5fef
	call SetCharPosAndTarget ; $5ff2
	call GetCharBaseCourtPosition ; $5ff5
	call SetCharTarget ; $5ff8
	ld hl, wCharFlags ; $5ffb
	res CHARB_DIVING, [hl] ; $5ffe
	res CHARB_RECOIL, [hl] ; $6000
	ret ; $6002
PlaceCharAtBasePosition:
	call GetCharBaseCourtPosition ; $6003
	call SetCharPosAndTarget ; $6006
	ld a, [wCharBaseFacing] ; $6009
	call SetCharFacing ; $600c
	ret ; $600f
WalkCharsOffCourt:
	ld a, $01 ; $6010
	ld [wPauseDisabled], a ; $6012
	xor a ; $6015
	ld [wOffscreenArrowsEnabled], a ; $6016
	call GetServeCameraTarget ; $6019
	call SetCameraTarget ; $601c
	ld hl, StartCharWalkOffCourt ; $601f
	call ForEachCharBank ; $6022
.waitLoop:
	call StepMatchFrame ; $6025
	call ReadMatchInputPressed ; $6028
	and $0b ; $602b
	jr nz, .settle ; $602d
	call CheckAllCharsPhaseDone ; $602f
	jr z, .waitLoop ; $6032
.settle:
	ld a, $14 ; $6034
	call StepMatchFrames ; $6036
	call GetServeCameraTarget ; $6039
	call SnapCameraTo ; $603c
	ld hl, ParkCharOffCourt ; $603f
	call ForEachCharBank ; $6042
	ret ; $6045
StartCharWalkOffCourt:
	ld a, CHARSTATE_WALK ; $6046
	call SetCharState ; $6048
	call GetCharChangeoverPosition ; $604b
	call SetCharTarget ; $604e
	ld hl, wCharFlags ; $6051
	res CHARB_DIVING, [hl] ; $6054
	res CHARB_RECOIL, [hl] ; $6056
	ret ; $6058
ParkCharOffCourt:
	ld hl, $0fe0 ; $6059
	ld de, $0fe0 ; $605c
	call SetCharPosAndTarget ; $605f
	ret ; $6062
CheckAllCharsPhaseDone:
	ld de, wCharStatePhase ; $6063
	ld b, $ff ; $6066
	ld a, [wOnCourtCharCountMinus1] ; $6068
	rst Rst00 ; $606b
	dw CheckAllCharsPhaseDone.char1 ; $606c jumptable
	dw CheckAllCharsPhaseDone.char2 ; $606e jumptable
	dw CheckAllCharsPhaseDone.char3 ; $6070 jumptable
	dw CheckAllCharsPhaseDone.char4 ; $6072 jumptable
.char4:
	wram_bank $06 ; $6074
	ld a, [de] ; $607a
	and b ; $607b
	ld b, a ; $607c
.char3:
	wram_bank $07 ; $607d
	ld a, [de] ; $6083
	and b ; $6084
	ld b, a ; $6085
.char2:
	wram_bank $05 ; $6086
	ld a, [de] ; $608c
	and b ; $608d
	ld b, a ; $608e
.char1:
	wram_bank $04 ; $608f
	ld a, [de] ; $6095
	and b ; $6096
	ret ; $6097
GetCharBaseCourtPosition:
	ld a, [wCharServeRole] ; $6098
	add a ; $609b
	add a ; $609c
	ld_hl_indexed GetCharBaseCourtPositionTable ; $609d
	ld a, [hl+] ; $60a4
	ld c, a ; $60a5
	ld a, [hl+] ; $60a6
	ld b, a ; $60a7
	ld a, [hl+] ; $60a8
	ld d, [hl] ; $60a9
	ld e, a ; $60aa
	ld l, c ; $60ab
	ld h, b ; $60ac
	ld a, [wCharCourtPos] ; $60ad
	and $02 ; $60b0
	jr z, .checkSide ; $60b2
	xor a ; $60b4
	sub e ; $60b5
	ld e, a ; $60b6
	sbc a ; $60b7
	sub d ; $60b8
	ld d, a ; $60b9
.checkSide:
	ld a, [wCharCourtPos] ; $60ba
	and $01 ; $60bd
	jr z, .done ; $60bf
	xor a ; $60c1
	sub l ; $60c2
	ld l, a ; $60c3
	sbc a ; $60c4
	sub h ; $60c5
	ld h, a ; $60c6
.done:
	ret ; $60c7
GetCharBaseCourtPositionTable:
	; $60c8, 16 bytes (records:4)
; 4 records x 4 bytes
	dw $0120, $04e0 ; record 0
	dw $0140, $0460 ; record 1
	dw $00c0, $01c0 ; record 2
	dw $00c0, $0300 ; record 3
GetCharChangeoverPosition:
	ld a, [wCharServeRole] ; $60d8
	add a ; $60db
	add a ; $60dc
	ld_hl_indexed GetCharChangeoverPositionTable ; $60dd
	ld a, [hl+] ; $60e4
	ld c, a ; $60e5
	ld a, [hl+] ; $60e6
	ld b, a ; $60e7
	ld a, [hl+] ; $60e8
	ld d, [hl] ; $60e9
	ld e, a ; $60ea
	ld l, c ; $60eb
	ld h, b ; $60ec
	ld a, [wCharCourtPos] ; $60ed
	and $02 ; $60f0
	jr z, .checkFlip ; $60f2
	xor a ; $60f4
	sub e ; $60f5
	ld e, a ; $60f6
	sbc a ; $60f7
	sub d ; $60f8
	ld d, a ; $60f9
.checkFlip:
	ld a, [wCourtViewFlipped] ; $60fa
	and a ; $60fd
	jr z, .done ; $60fe
	xor a ; $6100
	sub l ; $6101
	ld l, a ; $6102
	sbc a ; $6103
	sub h ; $6104
	ld h, a ; $6105
.done:
	ret ; $6106
GetCharChangeoverPositionTable:
	; $6107, 16 bytes (records:4)
; 4 records x 4 bytes
	dw $0300, $0240 ; record 0
	dw $0300, $0240 ; record 1
	dw $0300, $0180 ; record 2
	dw $0300, $0180 ; record 3
PlayCourtIntro:
	ld b, $44 ; $6117
	ld a, [wMatchContext] ; $6119
	and a ; $611c
	jr z, .playFanfare ; $611d
	ld b, $45 ; $611f
.playFanfare:
	ld a, b ; $6121
	call PlaySoundManaged ; $6122
	ld a, [wGameMode] ; $6125
	cp GAMEMODE_ISLAND_OPEN ; $6128
	jr z, .panCamera ; $612a
	ld a, [wMatchContext] ; $612c
	and a ; $612f
	jr nz, .done ; $6130
.panCamera:
	ld d, $00 ; $6132
	ld e, $00 ; $6134
	ld a, d ; $6136
	ldh [hScrollX], a ; $6137
	ld a, e ; $6139
	ldh [hScrollY], a ; $613a
	ld a, $05 ; $613c
	call StepMatchFrames ; $613e
	ld b, $30 ; $6141
	ld hl, $0200 ; $6143
	call PanCamera ; $6146
	jr nz, .done ; $6149
	ld b, $38 ; $614b
	ld hl, $0002 ; $614d
	call PanCamera ; $6150
	jr nz, .done ; $6153
	ld b, $30 ; $6155
	ld hl, $fe00 ; $6157
	call PanCamera ; $615a
	jr nz, .done ; $615d
	ld b, $1e ; $615f
	ld hl, $00fe ; $6161
	call PanCamera ; $6164
	jr nz, .done ; $6167
	ld b, $1a ; $6169
	ld hl, $0200 ; $616b
	call PanCamera ; $616e
.done:
	call ResetCameraForServe ; $6171
	call UpdateMatchCamera ; $6174
	ret ; $6177
PanCamera:
	ld a, d ; $6178
	ldh [hScrollX], a ; $6179
	ld a, e ; $617b
	ldh [hScrollY], a ; $617c
	ld a, d ; $617e
	add h ; $617f
	ld d, a ; $6180
	ld a, e ; $6181
	add l ; $6182
	ld e, a ; $6183
	call ReadMatchInputPressed ; $6184
	and $0b ; $6187
	jr nz, .done ; $6189
	call StepMatchFrame ; $618b
	dec b ; $618e
	jr nz, PanCamera ; $618f
.done:
	ret ; $6191
ResetCameraForServe:
	call GetServeCameraTarget ; $6192
	call SnapCameraTo ; $6195
	ret ; $6198
GetServeCameraTarget:
	ld a, [wServingCharCourtPos] ; $6199
	and $02 ; $619c
	ld de, $fe80 ; $619e
	jr z, .done ; $61a1
	ld de, $f880 ; $61a3
.done:
	ld hl, $0000 ; $61a6
	ret ; $61a9
; Instruction-identical to SnapCameraTo_0d (one copy per bank); a change here belongs in every copy.
SnapCameraTo:
	ld c, l ; $61aa
	ld b, h ; $61ab
	ld hl, wMatchCameraX ; $61ac
	ld a, c ; $61af
	ld [hl+], a ; $61b0
	ld [hl], b ; $61b1
	ld hl, wMatchCameraTargetX ; $61b2
	ld a, c ; $61b5
	ld [hl+], a ; $61b6
	ld [hl], b ; $61b7
	ld hl, wMatchCameraY ; $61b8
	ld a, e ; $61bb
	ld [hl+], a ; $61bc
	ld [hl], d ; $61bd
	ld hl, wMatchCameraTargetY ; $61be
	ld a, e ; $61c1
	ld [hl+], a ; $61c2
	ld [hl], d ; $61c3
	xor a ; $61c4
	ld [wCameraFollowBall], a ; $61c5
	ret ; $61c8
SetCameraTarget:
	ld c, l ; $61c9
	ld b, h ; $61ca
	ld hl, wMatchCameraTargetX ; $61cb
	ld a, c ; $61ce
	ld [hl+], a ; $61cf
	ld [hl], b ; $61d0
	ld hl, wMatchCameraTargetY ; $61d1
	ld a, e ; $61d4
	ld [hl+], a ; $61d5
	ld [hl], d ; $61d6
	xor a ; $61d7
	ld [wCameraFollowBall], a ; $61d8
	ret ; $61db
UpdateMatchCamera:
	ld a, [wCameraFollowBall] ; $61dc
	and a ; $61df
	jr z, .easeX ; $61e0
	ld hl, wBallGroundProjX ; $61e2
	ld de, wMatchCameraTargetX ; $61e5
	ld a, [hl+] ; $61e8
	ld [de], a ; $61e9
	inc de ; $61ea
	ld a, [hl+] ; $61eb
	ld [de], a ; $61ec
	inc de ; $61ed
	ld a, [hl+] ; $61ee
	ld [de], a ; $61ef
	inc de ; $61f0
	ld a, [hl+] ; $61f1
	ld [de], a ; $61f2
	inc de ; $61f3
.easeX:
	ld hl, wMatchCameraX ; $61f4
	ld a, [hl+] ; $61f7
	ld b, [hl] ; $61f8
	ld c, a ; $61f9
	ld hl, wMatchCameraTargetX ; $61fa
	ld a, [hl+] ; $61fd
	ld h, [hl] ; $61fe
	ld l, a ; $61ff
	ld a, l ; $6200
	sub c ; $6201
	ld l, a ; $6202
	ld a, h ; $6203
	sbc b ; $6204
	ld h, a ; $6205
	ld e, l ; $6206
	ld d, h ; $6207
	ld hl, wMatchCameraY ; $6208
	ld a, [hl+] ; $620b
	ld b, [hl] ; $620c
	ld c, a ; $620d
	ld hl, wMatchCameraTargetY ; $620e
	ld a, [hl+] ; $6211
	ld h, [hl] ; $6212
	ld l, a ; $6213
	ld a, l ; $6214
	sub c ; $6215
	ld l, a ; $6216
	ld a, h ; $6217
	sbc b ; $6218
	ld h, a ; $6219
	push hl ; $621a
	push de ; $621b
	call AngleFromVectorCoarse ; $621c
	ld hl, $0040 ; $621f
	call VectorFromLengthAndAngleRaw ; $6222
	ld c, l ; $6225
	ld b, h ; $6226
	ld hl, wMatchCameraX ; $6227
	ld a, [hl] ; $622a
	add c ; $622b
	ld [hl+], a ; $622c
	ld a, [hl] ; $622d
	adc b ; $622e
	ld [hl+], a ; $622f
	ld hl, wMatchCameraY ; $6230
	ld a, [hl] ; $6233
	add e ; $6234
	ld [hl+], a ; $6235
	ld a, [hl] ; $6236
	adc d ; $6237
	ld [hl+], a ; $6238
	ld hl, wMatchCameraX ; $6239
	ld a, [hl+] ; $623c
	ld b, [hl] ; $623d
	ld c, a ; $623e
	ld hl, wMatchCameraTargetX ; $623f
	ld a, [hl+] ; $6242
	ld h, [hl] ; $6243
	ld l, a ; $6244
	ld a, l ; $6245
	sub c ; $6246
	ld l, a ; $6247
	ld a, h ; $6248
	sbc b ; $6249
	ld h, a ; $624a
	pop af ; $624b
	xor h ; $624c
	bit 7, a ; $624d
	jr z, .easeY ; $624f
	ld hl, wMatchCameraTargetX ; $6251
	ld a, [hl+] ; $6254
	ld d, [hl] ; $6255
	ld e, a ; $6256
	ld hl, wMatchCameraX ; $6257
	ld a, e ; $625a
	ld [hl+], a ; $625b
	ld [hl], d ; $625c
.easeY:
	ld hl, wMatchCameraY ; $625d
	ld a, [hl+] ; $6260
	ld b, [hl] ; $6261
	ld c, a ; $6262
	ld hl, wMatchCameraTargetY ; $6263
	ld a, [hl+] ; $6266
	ld h, [hl] ; $6267
	ld l, a ; $6268
	ld a, l ; $6269
	sub c ; $626a
	ld l, a ; $626b
	ld a, h ; $626c
	sbc b ; $626d
	ld h, a ; $626e
	pop af ; $626f
	xor h ; $6270
	bit 7, a ; $6271
	jr z, .clampX ; $6273
	ld hl, wMatchCameraTargetY ; $6275
	ld a, [hl+] ; $6278
	ld d, [hl] ; $6279
	ld e, a ; $627a
	ld hl, wMatchCameraY ; $627b
	ld a, e ; $627e
	ld [hl+], a ; $627f
	ld [hl], d ; $6280
.clampX:
	ld hl, wMatchCameraX ; $6281
	ld a, [hl+] ; $6284
	ld h, [hl] ; $6285
	ld l, a ; $6286
	sra h ; $6287
	rr l ; $6289
	ld de, $f610 ; $628b
	add hl, de ; $628e
	ld de, $1010 ; $628f
	add hl, de ; $6292
	ld a, h ; $6293
	bit 7, a ; $6294
	jr z, .clampY ; $6296
	ld hl, $0000 ; $6298
.clampY:
	sub $0c ; $629b
	bit 7, a ; $629d
	jr nz, .done ; $629f
	ld h, $0c ; $62a1
	ld l, $00 ; $62a3
.done:
	ld a, l ; $62a5
	and $e0 ; $62a6
	ld e, a ; $62a8
	ld d, h ; $62a9
	ld l, e ; $62aa
	ld h, d ; $62ab
	add hl, hl ; $62ac
	add hl, hl ; $62ad
	add hl, hl ; $62ae
	ld a, h ; $62af
	ldh [hScrollX], a ; $62b0
	xor a ; $62b2
	sub e ; $62b3
	ld e, a ; $62b4
	sbc a ; $62b5
	sub d ; $62b6
	ld d, a ; $62b7
	ld hl, $1010 ; $62b8
	add hl, de ; $62bb
	ld e, l ; $62bc
	ld d, h ; $62bd
	ld hl, wCameraOffsetX ; $62be
	ld a, e ; $62c1
	ld [hl+], a ; $62c2
	ld [hl], d ; $62c3
	ld hl, wMatchCameraY ; $62c4
	ld a, [hl+] ; $62c7
	ld h, [hl] ; $62c8
	ld l, a ; $62c9
	sra h ; $62ca
	rr l ; $62cc
	sra h ; $62ce
	rr l ; $62d0
	ld e, l ; $62d2
	ld d, h ; $62d3
	sra d ; $62d4
	rr e ; $62d6
	add hl, de ; $62d8
	ld de, $f710 ; $62d9
	add hl, de ; $62dc
	ld de, $1010 ; $62dd
	add hl, de ; $62e0
	ld a, l ; $62e1
	and $e0 ; $62e2
	ld e, a ; $62e4
	ld d, h ; $62e5
	ld l, e ; $62e6
	ld h, d ; $62e7
	add hl, hl ; $62e8
	add hl, hl ; $62e9
	add hl, hl ; $62ea
	ld a, h ; $62eb
	ldh [hScrollY], a ; $62ec
	xor a ; $62ee
	sub e ; $62ef
	ld e, a ; $62f0
	sbc a ; $62f1
	sub d ; $62f2
	ld d, a ; $62f3
	ld hl, $1010 ; $62f4
	add hl, de ; $62f7
	ld e, l ; $62f8
	ld d, h ; $62f9
	ld hl, wCameraOffsetY ; $62fa
	ld a, e ; $62fd
	ld [hl+], a ; $62fe
	ld [hl], d ; $62ff
	ret ; $6300

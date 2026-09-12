CheckAllProgressComplete:
	push af ; $6f8d
	push bc ; $6f8e
	push de ; $6f8f
	push hl ; $6f90
	ld c, $24 ; $6f91
	ld hl, AllProgressFlagList_1e ; $6f93
.loop:
	push hl ; $6f96
	ld a, [hl+] ; $6f97
	ld d, [hl] ; $6f98
	ld e, a ; $6f99
	call TestGameFlag ; $6f9a
	pop hl ; $6f9d
	jr z, .restore ; $6f9e
	inc hl ; $6fa0
	inc hl ; $6fa1
	dec c ; $6fa2
	jr nz, .loop ; $6fa3
	push de ; $6fa5
	ld de, SAVEFLAG_COURT_STAR ; $6fa6
	farcall SetSaveFlag ; $6fa9
	pop de ; $6fac
.restore:
	pop hl ; $6fad
	pop de ; $6fae
	pop bc ; $6faf
	pop af ; $6fb0
	ret ; $6fb1
ShowIslandOpenRankingBoard:
	ld a, [wGameMode] ; $6fb2
	cp GAMEMODE_ISLAND_OPEN ; $6fb5
	ret nz ; $6fb7
	call SetupRankingBoardArgs ; $6fb8
	farcall ShowRankingBoard ; $6fbb
	ret ; $6fbe
SetupRankingBoardArgs:
	ld a, [wCurrentMinigameStoryMatch] ; $6fbf
	and $01 ; $6fc2
	ld b, a ; $6fc4
	or a ; $6fc5
	jr nz, .nonZero ; $6fc6
	ld a, [wCurrentMinigameStoryMatch + 1] ; $6fc8
	sub $13 ; $6fcb
	add $04 ; $6fcd
	and $07 ; $6fcf
	ld c, a ; $6fd1
	jr .checkMatchWinLoseFlag ; $6fd2
.nonZero:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $6fd4
	sub $13 ; $6fd7
	add $03 ; $6fd9
	and $03 ; $6fdb
	ld c, a ; $6fdd
.checkMatchWinLoseFlag:
	ld a, [wMatchWinLoseFlag] ; $6fde
	cp WINLOSE_WIN ; $6fe1
	jr nz, .ne01 ; $6fe3
	ld d, $01 ; $6fe5
	ret ; $6fe7
.ne01:
	ld d, $02 ; $6fe8
	ret ; $6fea
GetTrophyExpValue:
	add a ; $6feb
	add a ; $6fec
	add a ; $6fed
	add b ; $6fee
	ld hl, TrophyExpValueTable ; $6fef
	add l ; $6ff2
	ld l, a ; $6ff3
	jr nc, .read ; $6ff4
	inc h ; $6ff6
.read:
	ld a, [hl+] ; $6ff7
	ld b, [hl] ; $6ff8
	ld c, a ; $6ff9
	ret ; $6ffa
ComputeTrophyExpAwards:
	push af ; $6ffb
	push bc ; $6ffc
	push de ; $6ffd
	push_wram_bank WRAM_SCENE ; $6ffe
	ld hl, $0000 ; $7007
	call ComputeTrophyExpGroup0 ; $700a
	push hl ; $700d
	ld hl, wTrophyExpGroup0 ; $700e
	ld a, c ; $7011
	ld [hl+], a ; $7012
	ld [hl], b ; $7013
	pop hl ; $7014
	add hl, bc ; $7015
	call ComputeTrophyExpGroup1 ; $7016
	push hl ; $7019
	ld hl, wTrophyExpByGroup ; $701a
	ld a, c ; $701d
	ld [hl+], a ; $701e
	ld [hl], b ; $701f
	pop hl ; $7020
	add hl, bc ; $7021
	call ComputeTrophyExpGroup2 ; $7022
	push hl ; $7025
	ld hl, wTrophyExpByGroup + 2 ; $7026
	ld a, c ; $7029
	ld [hl+], a ; $702a
	ld [hl], b ; $702b
	pop hl ; $702c
	add hl, bc ; $702d
	call ComputeTrophyExpGroup3 ; $702e
	push hl ; $7031
	ld hl, wTrophyExpByGroup + 4 ; $7032
	ld a, c ; $7035
	ld [hl+], a ; $7036
	ld [hl], b ; $7037
	pop hl ; $7038
	add hl, bc ; $7039
	call ComputeTrophyExpGroup4 ; $703a
	push hl ; $703d
	ld hl, wTrophyExpByGroup + 6 ; $703e
	ld a, c ; $7041
	ld [hl+], a ; $7042
	ld [hl], b ; $7043
	pop hl ; $7044
	add hl, bc ; $7045
	call ComputeTrophyExpGroup5 ; $7046
	push hl ; $7049
	ld hl, wTrophyExpByGroup + 8 ; $704a
	ld a, c ; $704d
	ld [hl+], a ; $704e
	ld [hl], b ; $704f
	pop hl ; $7050
	add hl, bc ; $7051
	push hl ; $7052
	ld b, h ; $7053
	ld c, l ; $7054
	ld hl, wTrophyExpTotal ; $7055
	ld a, c ; $7058
	ld [hl+], a ; $7059
	ld [hl], b ; $705a
	pop hl ; $705b
	pop_wram_bank ; $705c
	pop de ; $7061
	pop bc ; $7062
	pop af ; $7063
	ret ; $7064
UnusedSetPendingTrophyExpAwards:
	push_wram_bank WRAM_SCENE ; $7065
	ld hl, wTrophyExpGroup0 ; $706e
	ld a, [hl+] ; $7071
	ld d, [hl] ; $7072
	ld e, a ; $7073
	ld a, d ; $7074
	or e ; $7075
	jr z, .sumGroup1 ; $7076
	ld b, $04 ; $7078
	ld c, $00 ; $707a
	farcall SetPendingExpAward ; $707c
.sumGroup1:
	ld hl, wTrophyExpByGroup ; $707f
	ld a, [hl+] ; $7082
	ld d, [hl] ; $7083
	ld e, a ; $7084
	ld a, d ; $7085
	or e ; $7086
	jr z, .sumGroup2 ; $7087
	ld b, $04 ; $7089
	ld c, $01 ; $708b
	farcall SetPendingExpAward ; $708d
.sumGroup2:
	ld hl, wTrophyExpByGroup + 2 ; $7090
	ld a, [hl+] ; $7093
	ld d, [hl] ; $7094
	ld e, a ; $7095
	ld a, d ; $7096
	or e ; $7097
	jr z, .sumGroup3 ; $7098
	ld b, $04 ; $709a
	ld c, $02 ; $709c
	farcall SetPendingExpAward ; $709e
.sumGroup3:
	ld hl, wTrophyExpByGroup + 4 ; $70a1
	ld a, [hl+] ; $70a4
	ld d, [hl] ; $70a5
	ld e, a ; $70a6
	ld a, d ; $70a7
	or e ; $70a8
	jr z, .sumGroup4 ; $70a9
	ld b, $04 ; $70ab
	ld c, $03 ; $70ad
	farcall SetPendingExpAward ; $70af
.sumGroup4:
	ld hl, wTrophyExpByGroup + 6 ; $70b2
	ld a, [hl+] ; $70b5
	ld d, [hl] ; $70b6
	ld e, a ; $70b7
	ld a, d ; $70b8
	or e ; $70b9
	jr z, .sumGroup5 ; $70ba
	ld b, $04 ; $70bc
	ld c, $04 ; $70be
	farcall SetPendingExpAward ; $70c0
.sumGroup5:
	ld hl, wTrophyExpByGroup + 8 ; $70c3
	ld a, [hl+] ; $70c6
	ld d, [hl] ; $70c7
	ld e, a ; $70c8
	ld a, d ; $70c9
	or e ; $70ca
	jr z, .restore ; $70cb
	ld b, $04 ; $70cd
	ld c, $05 ; $70cf
	farcall SetPendingExpAward ; $70d1
.restore:
	pop_wram_bank ; $70d4
	ret ; $70d9
ComputeTrophyExpGroup0:
	ld a, $00 ; $70da
	call ComputeTrophyExpForGroup ; $70dc
	ret ; $70df
ComputeTrophyExpGroup1:
	ld a, $01 ; $70e0
	call ComputeTrophyExpForGroup ; $70e2
	ret ; $70e5
ComputeTrophyExpGroup2:
	ld a, $02 ; $70e6
	call ComputeTrophyExpForGroup ; $70e8
	ret ; $70eb
ComputeTrophyExpGroup3:
	ld a, $03 ; $70ec
	call ComputeTrophyExpForGroup ; $70ee
	ret ; $70f1
ComputeTrophyExpGroup4:
	ld a, $04 ; $70f2
	call ComputeTrophyExpForGroup ; $70f4
	ret ; $70f7
ComputeTrophyExpGroup5:
	ld a, $05 ; $70f8
	call ComputeTrophyExpForGroup ; $70fa
	ret ; $70fd
ComputeTrophyExpForGroup:
	push af ; $70fe
	push de ; $70ff
	push hl ; $7100
	ld c, a ; $7101
	push_wram_bank WRAM_SCENE ; $7102
	ld a, c ; $710b
	ld [wTrophyExpGroup], a ; $710c
	ld hl, TrophyExpForGroupTable4 ; $710f
	add l ; $7112
	ld l, a ; $7113
	jr nc, .readThreshold ; $7114
	inc h ; $7116
.readThreshold:
	ld b, [hl] ; $7117
	ld a, c ; $7118
	ld hl, TrophyExpForGroupTable5 ; $7119
	add l ; $711c
	ld l, a ; $711d
	jr nc, .readMask ; $711e
	inc h ; $7120
.readMask:
	ld c, [hl] ; $7121
	xor a ; $7122
	ld hl, wTrophyExpGroupAccum ; $7123
	ld [hl+], a ; $7126
	ld [hl], a ; $7127
	ld a, [wN64TrophyCounts] ; $7128
	and c ; $712b
	cp b ; $712c
	jr c, .tier2 ; $712d
	ld a, [wTrophyExpGroup] ; $712f
	add a ; $7132
	add a ; $7133
	add a ; $7134
	ld hl, TrophyExpForGroupTable0 ; $7135
	add l ; $7138
	ld l, a ; $7139
	jr nc, .readFlag1 ; $713a
	inc h ; $713c
.readFlag1:
	ld a, [hl+] ; $713d
	ld d, [hl] ; $713e
	ld e, a ; $713f
	push de ; $7140
	call TestGameFlag ; $7141
	pop de ; $7144
	jr nz, .tier2 ; $7145
	call SetGameFlag ; $7147
	push bc ; $714a
	ld b, $00 ; $714b
	ld a, [wTrophyExpGroup] ; $714d
	call GetTrophyExpValue ; $7150
	ld hl, wTrophyExpGroupAccum ; $7153
	ld a, [hl+] ; $7156
	ld h, [hl] ; $7157
	ld l, a ; $7158
	add hl, bc ; $7159
	ld b, h ; $715a
	ld c, l ; $715b
	ld hl, wTrophyExpGroupAccum ; $715c
	ld a, c ; $715f
	ld [hl+], a ; $7160
	ld [hl], b ; $7161
	pop bc ; $7162
.tier2:
	ld a, [wN64TrophyCounts] ; $7163
	swap a ; $7166
	and c ; $7168
	cp b ; $7169
	jr c, .tier3 ; $716a
	ld a, [wTrophyExpGroup] ; $716c
	add a ; $716f
	add a ; $7170
	add a ; $7171
	ld hl, TrophyExpForGroupTable1 ; $7172
	add l ; $7175
	ld l, a ; $7176
	jr nc, .readFlag2 ; $7177
	inc h ; $7179
.readFlag2:
	ld a, [hl+] ; $717a
	ld d, [hl] ; $717b
	ld e, a ; $717c
	push de ; $717d
	call TestGameFlag ; $717e
	pop de ; $7181
	jr nz, .tier3 ; $7182
	call SetGameFlag ; $7184
	push bc ; $7187
	ld b, $04 ; $7188
	ld a, [wTrophyExpGroup] ; $718a
	call GetTrophyExpValue ; $718d
	ld hl, wTrophyExpGroupAccum ; $7190
	ld a, [hl+] ; $7193
	ld h, [hl] ; $7194
	ld l, a ; $7195
	add hl, bc ; $7196
	ld b, h ; $7197
	ld c, l ; $7198
	ld hl, wTrophyExpGroupAccum ; $7199
	ld a, c ; $719c
	ld [hl+], a ; $719d
	ld [hl], b ; $719e
	pop bc ; $719f
.tier3:
	ld a, [wN64TrophyCounts + 1] ; $71a0
	and c ; $71a3
	cp b ; $71a4
	jr c, .tier4 ; $71a5
	ld a, [wTrophyExpGroup] ; $71a7
	add a ; $71aa
	add a ; $71ab
	add a ; $71ac
	ld hl, TrophyExpForGroupTable2 ; $71ad
	add l ; $71b0
	ld l, a ; $71b1
	jr nc, .readFlag3 ; $71b2
	inc h ; $71b4
.readFlag3:
	ld a, [hl+] ; $71b5
	ld d, [hl] ; $71b6
	ld e, a ; $71b7
	push de ; $71b8
	call TestGameFlag ; $71b9
	pop de ; $71bc
	jr nz, .tier4 ; $71bd
	call SetGameFlag ; $71bf
	push bc ; $71c2
	ld b, $02 ; $71c3
	ld a, [wTrophyExpGroup] ; $71c5
	call GetTrophyExpValue ; $71c8
	ld hl, wTrophyExpGroupAccum ; $71cb
	ld a, [hl+] ; $71ce
	ld h, [hl] ; $71cf
	ld l, a ; $71d0
	add hl, bc ; $71d1
	ld b, h ; $71d2
	ld c, l ; $71d3
	ld hl, wTrophyExpGroupAccum ; $71d4
	ld a, c ; $71d7
	ld [hl+], a ; $71d8
	ld [hl], b ; $71d9
	pop bc ; $71da
.tier4:
	ld a, [wN64TrophyCounts + 1] ; $71db
	swap a ; $71de
	and c ; $71e0
	cp b ; $71e1
	jr c, .done ; $71e2
	ld a, [wTrophyExpGroup] ; $71e4
	add a ; $71e7
	add a ; $71e8
	add a ; $71e9
	ld hl, TrophyExpForGroupTable3 ; $71ea
	add l ; $71ed
	ld l, a ; $71ee
	jr nc, .readFlag4 ; $71ef
	inc h ; $71f1
.readFlag4:
	ld a, [hl+] ; $71f2
	ld d, [hl] ; $71f3
	ld e, a ; $71f4
	push de ; $71f5
	call TestGameFlag ; $71f6
	pop de ; $71f9
	jr nz, .done ; $71fa
	call SetGameFlag ; $71fc
	push bc ; $71ff
	ld b, $06 ; $7200
	ld a, [wTrophyExpGroup] ; $7202
	call GetTrophyExpValue ; $7205
	ld hl, wTrophyExpGroupAccum ; $7208
	ld a, [hl+] ; $720b
	ld h, [hl] ; $720c
	ld l, a ; $720d
	add hl, bc ; $720e
	ld b, h ; $720f
	ld c, l ; $7210
	ld hl, wTrophyExpGroupAccum ; $7211
	ld a, c ; $7214
	ld [hl+], a ; $7215
	ld [hl], b ; $7216
	pop bc ; $7217
.done:
	ld hl, wTrophyExpGroupAccum ; $7218
	ld a, [hl+] ; $721b
	ld b, [hl] ; $721c
	ld c, a ; $721d
	pop_wram_bank ; $721e
	pop hl ; $7223
	pop de ; $7224
	pop af ; $7225
	ret ; $7226
TrophyExpForGroupTable0:
	; $7227, 2 bytes (bytes:2)
	db $00, $11 ; 0x00
TrophyExpForGroupTable1:
	; $7229, 2 bytes (bytes:2)
	db $20, $11 ; 0x00
TrophyExpForGroupTable2:
	; $722b, 2 bytes (bytes:2)
	db $40, $11 ; 0x00
TrophyExpForGroupTable3:
	; $722d, 42 bytes (bytes:16)
	db $60, $11, $80, $11, $a0, $11, $c0, $11, $e0, $11, $00, $12, $20, $12, $40, $12 ; 0x00
	db $60, $12, $80, $12, $a0, $12, $c0, $12, $e0, $12, $00, $13, $20, $13, $40, $13 ; 0x10
	db $60, $13, $80, $13, $a0, $13, $c0, $13, $e0, $13 ; 0x20
TrophyExpForGroupTable4:
	; $7257, 6 bytes (bytes:6)
	db $01, $02, $03, $04, $08, $0c ; 0x00
TrophyExpForGroupTable5:
	; $725d, 6 bytes (bytes:6)
	db $03, $03, $03, $0c, $0c, $0c ; 0x00

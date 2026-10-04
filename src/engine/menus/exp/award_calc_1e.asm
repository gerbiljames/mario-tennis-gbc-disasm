TrophyExpValueTable:
	; $67a7, 48 bytes (bytes:16)
	db $32, $00, $32, $00, $32, $00, $32, $00, $64, $00, $64, $00, $64, $00, $64, $00 ; 0x00
	db $c8, $00, $c8, $00, $c8, $00, $c8, $00, $c8, $00, $c8, $00, $c8, $00, $c8, $00 ; 0x10
	db $90, $01, $90, $01, $90, $01, $90, $01, $bc, $02, $bc, $02, $bc, $02, $bc, $02 ; 0x20
MatchStatsRewardTable0:
	; $67d7, 8 bytes (bytes:8)
	db $02, $03, $04, $05, $06, $07, $08, $00 ; 0x00
MatchStatsRewardTable1:
	; $67df, 8 bytes (bytes:8)
	db $01, $02, $04, $08, $0c, $10, $14, $00 ; 0x00
MatchStatsRewardTable2:
	; $67e7, 8 bytes (bytes:8)
	db $01, $02, $03, $06, $09, $0c, $0f, $00 ; 0x00
MatchStatsRewardTable3:
	; $67ef, 8 bytes (bytes:8)
	db $01, $02, $03, $04, $05, $06, $07, $00 ; 0x00
MatchStatsRewardTable4:
	; $67f7, 8 bytes (bytes:8)
	db $01, $02, $03, $03, $04, $04, $05, $00 ; 0x00
MatchStatsRewardTable5:
	; $67ff, 8 bytes (bytes:8)
	db $01, $02, $03, $03, $04, $04, $05, $00 ; 0x00
GetScoreBonus:
	ld de, $0000 ; $6807
	ld a, [wMinigameHighScoreMode] ; $680a
	or a ; $680d
	ret z ; $680e
	push hl ; $680f
	ld hl, wMinigamesCurrentScore ; $6810
	ld a, [hl+] ; $6813
	ld d, [hl] ; $6814
	ld e, a ; $6815
	ld hl, $03e7 ; $6816
	ld a, l ; $6819
	sub e ; $681a
	ld l, a ; $681b
	ld a, h ; $681c
	sbc d ; $681d
	ld h, a ; $681e
	bit 7, h ; $681f
	jr z, .positive ; $6821
	ld de, $01f4 ; $6823
	jr .restore ; $6826
.positive:
	ld hl, $01f3 ; $6828
	ld a, l ; $682b
	sub e ; $682c
	ld l, a ; $682d
	ld a, h ; $682e
	sbc d ; $682f
	ld h, a ; $6830
	bit 7, h ; $6831
	jr z, .positive2 ; $6833
	ld de, $00fa ; $6835
	jr .restore ; $6838
.positive2:
	ld hl, $0063 ; $683a
	ld a, l ; $683d
	sub e ; $683e
	ld l, a ; $683f
	ld a, h ; $6840
	sbc d ; $6841
	ld h, a ; $6842
	bit 7, h ; $6843
	jr z, .positive3 ; $6845
	ld de, $0032 ; $6847
	jr .restore ; $684a
.positive3:
	ld de, $0000 ; $684c
.restore:
	pop hl ; $684f
	ret ; $6850
ComputeMatchStatsReward:
	ld a, [wCharId] ; $6851
	cp $04 ; $6854
	ret nc ; $6856
	push hl ; $6857
	call GetPlayerExpTier ; $6858
	pop de ; $685b
	ld hl, MatchStatsRewardTable0 ; $685c
	ld a, [wTotalGamesWonInMatch] ; $685f
	call AccumulateStatExp ; $6862
	ld l, e ; $6865
	ld h, d ; $6866
	ld a, [wGameMode] ; $6867
	cp GAMEMODE_LINK_MATCH ; $686a
	ret z ; $686c
	push hl ; $686d
	call GetOpponentExpTier ; $686e
	pop de ; $6871
	ld hl, MatchStatsRewardTable1 ; $6872
	ld a, [wCharacter1ServiceAces] ; $6875
	call AccumulateStatExp ; $6878
	ld hl, MatchStatsRewardTable1 ; $687b
	ld a, [wCharacter3ServiceAces] ; $687e
	call AccumulateStatExp ; $6881
	ld hl, MatchStatsRewardTable2 ; $6884
	ld a, [wCharacter1ReturnAces] ; $6887
	call AccumulateStatExp ; $688a
	ld hl, MatchStatsRewardTable2 ; $688d
	ld a, [wCharacter3ReturnAces] ; $6890
	call AccumulateStatExp ; $6893
	ld hl, MatchStatsRewardTable3 ; $6896
	ld a, [wCharacter1SmashAces] ; $6899
	call AccumulateStatExp ; $689c
	ld hl, MatchStatsRewardTable3 ; $689f
	ld a, [wCharacter3SmashAces] ; $68a2
	call AccumulateStatExp ; $68a5
	ld hl, MatchStatsRewardTable4 ; $68a8
	ld a, [wCharacter1LobShotWinners] ; $68ab
	call AccumulateStatExp ; $68ae
	ld hl, MatchStatsRewardTable4 ; $68b1
	ld a, [wCharacter3LobShotWinners] ; $68b4
	call AccumulateStatExp ; $68b7
	ld hl, MatchStatsRewardTable5 ; $68ba
	ld a, [wCharacter1DropShotWinners] ; $68bd
	call AccumulateStatExp ; $68c0
	ld hl, MatchStatsRewardTable5 ; $68c3
	ld a, [wCharacter3DropShotWinners] ; $68c6
	call AccumulateStatExp ; $68c9
	ld l, e ; $68cc
	ld h, d ; $68cd
	ret ; $68ce
AccumulateStatExp:
	ld b, $00 ; $68cf
	add hl, bc ; $68d1
	ld l, [hl] ; $68d2
	ld h, $00 ; $68d3
	call MulHLByA ; $68d5
	add hl, de ; $68d8
	ld e, l ; $68d9
	ld d, h ; $68da
	ret ; $68db
ApplyMatchSettingsExpBonus:
	ld b, $00 ; $68dc
	ld a, d ; $68de
	and $0f ; $68df
	cp $03 ; $68e1
	jr nz, .checkSets ; $68e3
	inc b ; $68e5
.checkSets:
	ld a, d ; $68e6
	swap a ; $68e7
	and $0f ; $68e9
	cp $01 ; $68eb
	jr nz, .applyBonus ; $68ed
	inc b ; $68ef
.applyBonus:
	ld a, b ; $68f0
	and a ; $68f1
	ret z ; $68f2
	cp $02 ; $68f3
	jr z, .doubleExp ; $68f5
	ld e, l ; $68f7
	ld d, h ; $68f8
	sra d ; $68f9
	rr e ; $68fb
	add hl, de ; $68fd
	ret ; $68fe
.doubleExp:
	add hl, hl ; $68ff
	ret ; $6900
GetOpponentExpTier:
	push_wram_bank WRAM_TEXT ; $6901
	call LookupExpTierForChar ; $690a
	ld a, [wMatchIsDoubles] ; $690d
	and a ; $6910
	jr z, .zero ; $6911
	push bc ; $6913
	wram_bank WRAM_SOUND ; $6914
	call LookupExpTierForChar ; $691a
	ld a, c ; $691d
	pop bc ; $691e
	add c ; $691f
	inc a ; $6920
	srl a ; $6921
	ld c, a ; $6923
.zero:
	ld a, c ; $6924
	cp $06 ; $6925
	jr c, .lt06 ; $6927
	ld a, $06 ; $6929
.lt06:
	ld c, a ; $692b
	pop_wram_bank ; $692c
	ret ; $6931
GetPlayerExpTier:
	call LookupExpTierForChar ; $6932
	ld a, c ; $6935
	cp $06 ; $6936
	jr c, .lt06 ; $6938
	ld a, $06 ; $693a
.lt06:
	ld c, a ; $693c
	ret ; $693d
LookupExpTierForChar:
	ld a, [wCharExpTier] ; $693e
	ld c, a ; $6941
	ld a, [wCharId] ; $6942
	cp $04 ; $6945
	jr nc, LookupExpTierForChar.ge04 ; $6947
	ld l, c ; $6949
	xor a ; $694a
	ld h, a ; $694b
	ld e, $0a ; $694c
	call DivAHLByE ; $694e
	ld a, l ; $6951
	ld_hl_indexed LookupExpTierForCharTable ; $6952
	ld c, [hl] ; $6959
	ret ; $695a
LookupExpTierForCharTable:
	; $695b, 10 bytes (bytes:10)
	db $00, $01, $02, $03, $04, $04, $05, $05, $06, $06 ; 0x00
LookupExpTierForChar.ge04:
	dec c ; $6965
	ret ; $6966
AwardExhibitionMatchExp:
	ld d, h ; $6967
	ld e, l ; $6968
	ld hl, wPendingExpExhibition ; $6969
	ld a, e ; $696c
	ld [hl+], a ; $696d
	ld [hl], d ; $696e
	ld a, [wMatchSlotCharRefs] ; $696f
	bit 7, a ; $6972
	jr z, .recordExhibitionVictory ; $6974
	call ShowExpAwardForExhibition ; $6976
	ld a, [wCurrentStorySlot] ; $6979
	push af ; $697c
	ld hl, wPendingExpExhibition ; $697d
	ld a, [hl+] ; $6980
	ld h, [hl] ; $6981
	ld l, a ; $6982
	ld a, [wMatchSlotCharRefs] ; $6983
	srl a ; $6986
	and $03 ; $6988
	ld [wCurrentStorySlot], a ; $698a
	farcall CheckStorySlot ; $698d
	ld d, h ; $6990
	ld e, l ; $6991
	ld hl, wPendingExpExhibition ; $6992
	ld a, [hl+] ; $6995
	ld h, [hl] ; $6996
	ld l, a ; $6997
	add hl, de ; $6998
	jr nc, .noCarry ; $6999
	ld hl, rIE ; $699b
.noCarry:
	ld d, h ; $699e
	ld e, l ; $699f
	ld hl, wPendingExpExhibition ; $69a0
	ld a, e ; $69a3
	ld [hl+], a ; $69a4
	ld [hl], d ; $69a5
	farcall SaveStorySlot ; $69a6
	pop af ; $69a9
	ld [wCurrentStorySlot], a ; $69aa
.recordExhibitionVictory:
	farcall RecordExhibitionVictory ; $69ad
	farcall ReadExhibitionSaveBlock ; $69b0
	ret ; $69b3
AwardLinkedPlayMatchExp:
	ld d, h ; $69b4
	ld e, l ; $69b5
	ld hl, wPendingExpLinked ; $69b6
	ld a, e ; $69b9
	ld [hl+], a ; $69ba
	ld [hl], d ; $69bb
	ld hl, wMatchSlotCharRefs ; $69bc
	ld a, [wLinkMatchRole] ; $69bf
	srl a ; $69c2
	sla a ; $69c4
	add l ; $69c6
	ld l, a ; $69c7
	jr nc, .read ; $69c8
	inc h ; $69ca
.read:
	ld a, [hl] ; $69cb
	bit 7, a ; $69cc
	jr z, .done ; $69ce
	cp $ff ; $69d0
	jr z, .done ; $69d2
	call ShowExpAwardForLinkedPlay ; $69d4
	ld a, [wCurrentStorySlot] ; $69d7
	push af ; $69da
	ld hl, wMatchSlotCharRefs ; $69db
	ld a, [wLinkMatchRole] ; $69de
	and $03 ; $69e1
	srl a ; $69e3
	sla a ; $69e5
	add l ; $69e7
	ld l, a ; $69e8
	jr nc, .readB ; $69e9
	inc h ; $69eb
.readB:
	ld a, [hl] ; $69ec
	srl a ; $69ed
	and $03 ; $69ef
	ld [wCurrentStorySlot], a ; $69f1
	farcall CheckStorySlot ; $69f4
	ld hl, wPendingExpLinked ; $69f7
	ld a, [hl+] ; $69fa
	ld h, [hl] ; $69fb
	ld l, a ; $69fc
	add hl, de ; $69fd
	jr nc, .noCarry ; $69fe
	ld hl, rIE ; $6a00
.noCarry:
	ld d, h ; $6a03
	ld e, l ; $6a04
	ld hl, wPendingExpLinked ; $6a05
	ld a, e ; $6a08
	ld [hl+], a ; $6a09
	ld [hl], d ; $6a0a
	farcall SaveStorySlot ; $6a0b
	pop af ; $6a0e
	ld [wCurrentStorySlot], a ; $6a0f
.done:
	ret ; $6a12
ShowExpAwardForMinigame:
	ld a, e ; $6a13
	or d ; $6a14
	ret z ; $6a15
	push af ; $6a16
	push bc ; $6a17
	push de ; $6a18
	push hl ; $6a19
	ldh a, [hWramBank] ; $6a1a
	push af ; $6a1c
	farcall ClearPendingExpAwards ; $6a1d
	ld b, $03 ; $6a20
	ld c, $01 ; $6a22
	farcall SetPendingExpAward ; $6a24
	ld c, $01 ; $6a27
	call ShowMatchResultsScreen ; $6a29
	pop_wram_bank ; $6a2c
	pop hl ; $6a31
	pop de ; $6a32
	pop bc ; $6a33
	pop af ; $6a34
	ret ; $6a35
ShowExpAwardForMatch:
	ld a, e ; $6a36
	or d ; $6a37
	ret z ; $6a38
	push af ; $6a39
	push bc ; $6a3a
	push de ; $6a3b
	push hl ; $6a3c
	ldh a, [hWramBank] ; $6a3d
	push af ; $6a3f
	farcall ClearPendingExpAwards ; $6a40
	ld b, $03 ; $6a43
	ld c, $00 ; $6a45
	ld a, [wGameMode] ; $6a47
	cp GAMEMODE_ISLAND_OPEN ; $6a4a
	jr nz, .compare ; $6a4c
	ld c, $02 ; $6a4e
.compare:
	cp GAMEMODE_PRACTICE_MATCH ; $6a50
	jr nz, .compare2 ; $6a52
	ld c, $03 ; $6a54
.compare2:
	cp GAMEMODE_DREAM_MATCH ; $6a56
	jr nz, .setPendingExpAward ; $6a58
	ld c, $04 ; $6a5a
.setPendingExpAward:
	farcall SetPendingExpAward ; $6a5c
	ld c, $01 ; $6a5f
	call ShowMatchResultsScreen ; $6a61
	pop_wram_bank ; $6a64
	pop hl ; $6a69
	pop de ; $6a6a
	pop bc ; $6a6b
	pop af ; $6a6c
	ret ; $6a6d
ShowExpAwardForExhibition:
	ld a, e ; $6a6e
	or d ; $6a6f
	ret z ; $6a70
	push af ; $6a71
	push bc ; $6a72
	push de ; $6a73
	push hl ; $6a74
	ldh a, [hWramBank] ; $6a75
	push af ; $6a77
	farcall ClearPendingExpAwards ; $6a78
	ld b, $01 ; $6a7b
	ld c, $00 ; $6a7d
	farcall SetPendingExpAward ; $6a7f
	xor a ; $6a82
	test_flag FLAG_DOUBLES ; $6a83
	jr z, .notDoubles ; $6a86
	ld a, $01 ; $6a88
.notDoubles:
	push af ; $6a8a
	clear_flag FLAG_DOUBLES ; $6a8b
	ld c, $01 ; $6a8e
	call ShowMatchResultsScreen ; $6a90
	pop af ; $6a93
	or a ; $6a94
	jr z, .restore ; $6a95
	set_flag FLAG_DOUBLES ; $6a97
.restore:
	pop_wram_bank ; $6a9a
	pop hl ; $6a9f
	pop de ; $6aa0
	pop bc ; $6aa1
	pop af ; $6aa2
	ret ; $6aa3
ShowExpAwardForLinkedPlay:
	ld a, e ; $6aa4
	or d ; $6aa5
	ret z ; $6aa6
	push af ; $6aa7
	push bc ; $6aa8
	push de ; $6aa9
	push hl ; $6aaa
	ldh a, [hWramBank] ; $6aab
	push af ; $6aad
	farcall ClearPendingExpAwards ; $6aae
	ld b, $02 ; $6ab1
	ld c, $00 ; $6ab3
	farcall SetPendingExpAward ; $6ab5
	xor a ; $6ab8
	test_flag FLAG_DOUBLES ; $6ab9
	jr z, .notDoubles ; $6abc
	ld a, $01 ; $6abe
.notDoubles:
	push af ; $6ac0
	clear_flag FLAG_DOUBLES ; $6ac1
	ld c, $01 ; $6ac4
	call ShowMatchResultsScreen ; $6ac6
	pop af ; $6ac9
	or a ; $6aca
	jr z, .restore ; $6acb
	set_flag FLAG_DOUBLES ; $6acd
.restore:
	pop_wram_bank ; $6ad0
	pop hl ; $6ad5
	pop de ; $6ad6
	pop bc ; $6ad7
	pop af ; $6ad8
	ret ; $6ad9
; ShowExpAwardForMinigame with b = 0, c = 0 in place of b = 3, c = 1: the Transfer Pak (N64 records) award variant of the same screen. Nothing calls it, so no N64 EXP award is ever shown.
UnusedShowExpAwardForN64:
	ld a, e ; $6ada
	or d ; $6adb
	ret z ; $6adc
	push af ; $6add
	push bc ; $6ade
	push de ; $6adf
	push hl ; $6ae0
	ldh a, [hWramBank] ; $6ae1
	push af ; $6ae3
	farcall ClearPendingExpAwards ; $6ae4
	ld b, $00 ; $6ae7
	ld c, $00 ; $6ae9
	farcall SetPendingExpAward ; $6aeb
	ld c, $01 ; $6aee
	call ShowMatchResultsScreen ; $6af0
	pop_wram_bank ; $6af3
	pop hl ; $6af8
	pop de ; $6af9
	pop bc ; $6afa
	pop af ; $6afb
	ret ; $6afc
ApplyPendingExpAwards:
	apcall ApPrepareExpAwards
	push af ; $6afd
	push bc ; $6afe
	push de ; $6aff
	push hl ; $6b00
	ldh a, [hWramBank] ; $6b01
	push af ; $6b03
	ld a, [wGameMode] ; $6b04
	push af ; $6b07
	ld a, GAMEMODE_NONE ; $6b08
	ld [wGameMode], a ; $6b0a
	ld hl, wPendingExpStory ; $6b0d
	ld a, [hl+] ; $6b10
	ld d, [hl] ; $6b11
	ld e, a ; $6b12
	ld hl, wPendingExpTrophy ; $6b13
	ld a, [hl+] ; $6b16
	ld h, [hl] ; $6b17
	ld l, a ; $6b18
	add hl, de ; $6b19
	jr c, .sumAwards ; $6b1a
	ld d, h ; $6b1c
	ld e, l ; $6b1d
	call ScaleExpByPlayerLevel ; $6b1e
	call ComputeTrophyExpAwards ; $6b21
	add hl, de ; $6b24
	jr c, .sumAwards ; $6b25
	ld d, h ; $6b27
	ld e, l ; $6b28
	ld hl, wPendingExpExhibition ; $6b29
	ld a, [hl+] ; $6b2c
	ld h, [hl] ; $6b2d
	ld l, a ; $6b2e
	add hl, de ; $6b2f
	jr c, .sumAwards ; $6b30
	ld d, h ; $6b32
	ld e, l ; $6b33
	ld hl, wPendingExpLinked ; $6b34
	ld a, [hl+] ; $6b37
	ld h, [hl] ; $6b38
	ld l, a ; $6b39
	add hl, de ; $6b3a
	jr nc, .noCarry ; $6b3b
.sumAwards:
	ld hl, rIE ; $6b3d
.noCarry:
	ld a, h ; $6b40
	or l ; $6b41
	jp z, .restore2 ; $6b42
	push hl ; $6b45
	farcall ClearPendingExpAwards ; $6b46
	ld hl, wPendingExpStory ; $6b49
	ld a, [hl+] ; $6b4c
	ld d, [hl] ; $6b4d
	ld e, a ; $6b4e
	ld hl, wPendingExpTrophy ; $6b4f
	ld a, [hl+] ; $6b52
	ld h, [hl] ; $6b53
	ld l, a ; $6b54
	add hl, de ; $6b55
	ld d, h ; $6b56
	ld e, l ; $6b57
	jr nc, .scaleExpByPlayerLevel ; $6b58
	ld de, $ffff ; $6b5a
.scaleExpByPlayerLevel:
	call ScaleExpByPlayerLevel ; $6b5d
	jr nc, .setPendingExpAward ; $6b60
	ld de, $ffff ; $6b62
.setPendingExpAward:
	ld a, d ; $6b65
	or e ; $6b66
	jr z, .award2 ; $6b67
	ld b, $00 ; $6b69
	ld c, $00 ; $6b6b
	farcall SetPendingExpAward ; $6b6d
.award2:
	ld hl, wPendingExpExhibition ; $6b70
	ld a, [hl+] ; $6b73
	ld d, [hl] ; $6b74
	ld e, a ; $6b75
	ld a, d ; $6b76
	or e ; $6b77
	jr z, .award3 ; $6b78
	ld b, $01 ; $6b7a
	ld c, $00 ; $6b7c
	farcall SetPendingExpAward ; $6b7e
.award3:
	ld hl, wPendingExpLinked ; $6b81
	ld a, [hl+] ; $6b84
	ld d, [hl] ; $6b85
	ld e, a ; $6b86
	ld a, d ; $6b87
	or e ; $6b88
	jr z, .applyToRecord ; $6b89
	ld b, $02 ; $6b8b
	ld c, $00 ; $6b8d
	farcall SetPendingExpAward ; $6b8f
.applyToRecord:
	wram_bank WRAM_SCENE ; $6b92
	ld hl, wTrophyExpTotal ; $6b98
	ld a, [hl+] ; $6b9b
	ld d, [hl] ; $6b9c
	ld e, a ; $6b9d
	ld a, d ; $6b9e
	or e ; $6b9f
	jr z, .checkDoubles ; $6ba0
	ld b, $04 ; $6ba2
	ld c, $00 ; $6ba4
	farcall SetPendingExpAward ; $6ba6
.checkDoubles:
	xor a ; $6ba9
	test_flag FLAG_DOUBLES ; $6baa
	jr nz, .isDoubles ; $6bad
	ld a, $01 ; $6baf
.isDoubles:
	push af ; $6bb1
	set_flag FLAG_DOUBLES ; $6bb2
	ld c, $01 ; $6bb5
	call ShowMatchResultsScreen ; $6bb7
	pop af ; $6bba
	or a ; $6bbb
	jr z, .restore ; $6bbc
	clear_flag FLAG_DOUBLES ; $6bbe
.restore:
	pop hl ; $6bc1
	farcall RunExpDistributionFlow ; $6bc2
	ld c, $00 ; $6bc5
	farcall CharDataScreen_Show ; $6bc7
	ld c, $01 ; $6bca
	farcall CharDataScreen_Show ; $6bcc
	call ApplyStatGapProgressFlag ; $6bcf
	xor a ; $6bd2
	ld hl, wPendingExpStory ; $6bd3
	ld [hl+], a ; $6bd6
	ld [hl], a ; $6bd7
	ld hl, wPendingExpTrophy ; $6bd8
	ld [hl+], a ; $6bdb
	ld [hl], a ; $6bdc
	ld hl, wPendingExpExhibition ; $6bdd
	ld [hl+], a ; $6be0
	ld [hl], a ; $6be1
	ld hl, wPendingExpLinked ; $6be2
	ld [hl+], a ; $6be5
	ld [hl], a ; $6be6
	pop af ; $6be7
	ld [wGameMode], a ; $6be8
	farcall SaveStorySlot ; $6beb
	pop_wram_bank ; $6bee
	pop hl ; $6bf3
	pop de ; $6bf4
	pop bc ; $6bf5
	pop af ; $6bf6
	ld a, $01 ; $6bf7
	ret ; $6bf9
.restore2:
	pop af ; $6bfa
	ld [wGameMode], a ; $6bfb
	pop_wram_bank ; $6bfe
	pop hl ; $6c03
	pop de ; $6c04
	pop bc ; $6c05
	pop af ; $6c06
	xor a ; $6c07
	ret ; $6c08
ScaleExpByPlayerLevel:
	ld a, [wStoryMainCharExpTier] ; $6c09
	ld b, a ; $6c0c
	ld a, [wStoryPartnerCharExpTier] ; $6c0d
	add b ; $6c10
	srl a ; $6c11
	cp $0a ; $6c13
	jr nc, .compare ; $6c15
	ccf ; $6c17
	ret ; $6c18
.compare:
	cp $14 ; $6c19
	jr nc, .compare2 ; $6c1b
	ld h, d ; $6c1d
	ld l, e ; $6c1e
	srl d ; $6c1f
	rr e ; $6c21
	add hl, de ; $6c23
	ld d, h ; $6c24
	ld e, l ; $6c25
	ret ; $6c26
.compare2:
	cp $1e ; $6c27
	jr nc, .compare3 ; $6c29
	ld h, d ; $6c2b
	ld l, e ; $6c2c
	add hl, de ; $6c2d
	ld d, h ; $6c2e
	ld e, l ; $6c2f
	ret ; $6c30
.compare3:
	cp $28 ; $6c31
	jr nc, .compare4 ; $6c33
	ld h, d ; $6c35
	ld l, e ; $6c36
	srl d ; $6c37
	rr e ; $6c39
	add hl, hl ; $6c3b
	add hl, de ; $6c3c
	ld d, h ; $6c3d
	ld e, l ; $6c3e
	ret ; $6c3f
.compare4:
	cp $32 ; $6c40
	jr nc, .compare5 ; $6c42
	ld h, d ; $6c44
	ld l, e ; $6c45
	add hl, hl ; $6c46
	add hl, de ; $6c47
	ld d, h ; $6c48
	ld e, l ; $6c49
	ret ; $6c4a
.compare5:
	cp $3c ; $6c4b
	jr nc, .ge3c ; $6c4d
	ld h, d ; $6c4f
	ld l, e ; $6c50
	add hl, hl ; $6c51
	add hl, de ; $6c52
	srl d ; $6c53
	rr e ; $6c55
	add hl, de ; $6c57
	ld d, h ; $6c58
	ld e, l ; $6c59
	ret ; $6c5a
.ge3c:
	ld h, d ; $6c5b
	ld l, e ; $6c5c
	add hl, hl ; $6c5d
	add hl, hl ; $6c5e
	ld d, h ; $6c5f
	ld e, l ; $6c60
	ret ; $6c61

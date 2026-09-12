RunMatchPlayLoop:
	ld a, [wGameMode] ; $4714
	cp GAMEMODE_ISLAND_OPEN ; $4717
	jr z, .markChangeEnds ; $4719
	ld a, [wMatchContext] ; $471b
	and a ; $471e
	jr nz, .setLoop ; $471f
.markChangeEnds:
	ld hl, wChangeoverSkipBanner ; $4721
	ld [hl], $01 ; $4724
.setLoop:
	call PlaySet ; $4726
	ld a, [wMatchAbortFlag] ; $4729
	and MATCHABORT_MATCH ; $472c
	jr nz, .done ; $472e
	ld a, [wMatchWinLoseFlag] ; $4730
	and a ; $4733
	jr z, .setLoop ; $4734
.done:
	ret ; $4736
PlaySet:
	ld hl, CheckSetComplete ; $4737
	push hl ; $473a
	ld a, [wTiebreakerIndicator] ; $473b
	and a ; $473e
	jp z, CheckSetComplete.playGame ; $473f
	jp CheckSetComplete.tiebreak ; $4742
CheckSetComplete:
	ld a, [wMatchAbortFlag] ; $4745
	and MATCHABORT_MATCH ; $4748
	jr nz, .done ; $474a
	ld a, [wSetWinLoseFlag] ; $474c
	and a ; $474f
	jr z, PlaySet ; $4750
	ld a, $01 ; $4752
	ld [wChangeoverSkipBanner], a ; $4754
.done:
	ret ; $4757
.playGame:
	xor a ; $4758
	ld [wScoreDisplayIsTiebreak], a ; $4759
	call AssignCourtPositions ; $475c
	call RefreshCourtAfterEndChange ; $475f
	call RunChangeoverSequence ; $4762
.pointLoop:
	call AssignCourtPositions ; $4765
	call PlayPoint ; $4768
	ld a, [wMatchAbortFlag] ; $476b
	and MATCHABORT_MATCH ; $476e
	jr nz, .gameDone ; $4770
	ld a, [wGameWinLoseFlag] ; $4772
	and a ; $4775
	jr z, .pointLoop ; $4776
	ld a, [wTiebreakerIndicator] ; $4778
	and a ; $477b
	jr z, .gameDone ; $477c
	call WalkCharsOffCourt ; $477e
.gameDone:
	ret ; $4781
.tiebreak:
	ld a, $01 ; $4782
	ld [wScoreDisplayIsTiebreak], a ; $4784
	call InitTiebreakPointCounter ; $4787
	ld a, $01 ; $478a
	ld [wChangeoverSkipBanner], a ; $478c
	sound BGM_TIEBREAK ; $478f
	ld a, $0f ; $4791
	farcall ShowCourtBanner ; $4793
	ld a, $50 ; $4796
	call StepMatchFrames ; $4798
	farcall HideCourtBanner ; $479b
	ld a, $0f ; $479e
	call StepMatchFrames ; $47a0
.tiebreakChangeover:
	call AssignCourtPositions ; $47a3
	call RefreshCourtAfterEndChange ; $47a6
	call RunChangeoverSequence ; $47a9
	call PlayPoint ; $47ac
	ld a, [wMatchAbortFlag] ; $47af
	and MATCHABORT_MATCH ; $47b2
	jr nz, .tiebreakDone ; $47b4
	ld hl, wTotalPointsScoredInCurrentGame ; $47b6
	ld a, [hl] ; $47b9
	cp $18 ; $47ba
	jr c, .storeCounter ; $47bc
	ld [hl], $00 ; $47be
.storeCounter:
	ld a, [wGameWinLoseFlag] ; $47c0
	and a ; $47c3
	jr z, .tiebreakChangeover ; $47c4
.tiebreakDone:
	ld a, [wMatchBGM] ; $47c6
	call PlaySoundManaged ; $47c9
	ret ; $47cc
InitTiebreakPointCounter:
	ld a, [wTotalGamesWonInMatch] ; $47cd
	and $03 ; $47d0
	ld_hl_indexed InitTiebreakPointCounterTable ; $47d2
	ld a, [hl] ; $47d9
	ld [wTotalPointsScoredInCurrentGame], a ; $47da
	ret ; $47dd
InitTiebreakPointCounterTable:
	; $47de, 4 bytes (bytes:4)
	db $00, $12, $0c, $06 ; 0x00
AssignCourtPositions:
	ld hl, FinalizeServeSideOrientation ; $47e2
	push hl ; $47e5
	ld a, [wTiebreakerIndicator] ; $47e6
	and a ; $47e9
	jp nz, FlipFarBothCharPositions.done ; $47ea
	jr GetGamePositionHandler ; $47ed
FinalizeServeSideOrientation:
	call CheckServerEndChanged ; $47ef
	call UpdateViewFlipState ; $47f2
	call FlipAllCharPositions ; $47f5
	call IdentifyServingPlayer ; $47f8
	ld hl, SetCharFacingFromCourtPos ; $47fb
	call ForEachCharBank ; $47fe
	wram_bank WRAM_ACTORS ; $4801
	ret ; $4807
GetGamePositionHandler:
	ld a, [wOnCourtCharCountMinus1] ; $4808
	add a ; $480b
	ld_hl_indexed GamePositionPtrs ; $480c
	ld a, [hl+] ; $4813
	ld h, [hl] ; $4814
	ld l, a ; $4815
	ld a, [wTotalGamesWonInMatch] ; $4816
	and $03 ; $4819
	call LoadPositionRecord ; $481b
	ld a, [wTotalPointsScoredInCurrentGame] ; $481e
	rrca ; $4821
	ret nc ; $4822
	ld hl, FlipPartnerCourtPositions ; $4823
	push hl ; $4826
	ld a, [wOnCourtCharCountMinus1] ; $4827
	rst Rst00 ; $482a
	dw FlipNearCharPosition ; $482b jumptable
	dw FlipNearCharPosition ; $482d jumptable
	dw FlipNearCharPosition ; $482f jumptable
	dw FlipBothCharPositions ; $4831 jumptable
FlipPartnerCourtPositions:
	ld a, [wOnCourtCharCountMinus1] ; $4833
	rst Rst00 ; $4836
	dw FlipFarCharPosition ; $4837 jumptable
	dw FlipFarCharPosition ; $4839 jumptable
	dw FlipFarBothCharPositions ; $483b jumptable
	dw FlipFarBothCharPositions ; $483d jumptable
GamePositionPtrs:
	; $483f, 8 bytes (records:2)
	dw GamePositionTables ; record 0
	dw GamePositionTables ; record 1
	dw GamePosition1 ; record 2
	dw GamePosition0 ; record 3
FlipNearCharPosition:
	ld b, $01 ; $4847
	wram_bank WRAM_CHAR0 ; $4849
	call FlipCharPositionCode ; $484f
	ret ; $4852
FlipBothCharPositions:
	wram_bank WRAM_CHAR0 ; $4853
	ld a, [wCharServeRole] ; $4859
	and $01 ; $485c
	jr nz, .toggleRows ; $485e
	ld b, $01 ; $4860
	wram_bank WRAM_CHAR0 ; $4862
	call FlipCharPositionCode ; $4868
	wram_bank WRAM_CHAR2 ; $486b
	call FlipCharPositionCode ; $4871
	ret ; $4874
.toggleRows:
	wram_bank WRAM_CHAR0 ; $4875
	call ToggleCharCourtRow ; $487b
	wram_bank WRAM_CHAR2 ; $487e
	call ToggleCharCourtRow ; $4884
	ret ; $4887
FlipFarCharPosition:
	ld b, $01 ; $4888
	wram_bank WRAM_CHAR1 ; $488a
	call FlipCharPositionCode ; $4890
	ret ; $4893
FlipFarBothCharPositions:
	wram_bank WRAM_CHAR0 ; $4894
	ld a, [wCharServeRole] ; $489a
	and $01 ; $489d
	jr z, .toggleRows ; $489f
	ld b, $01 ; $48a1
	wram_bank WRAM_CHAR1 ; $48a3
	call FlipCharPositionCode ; $48a9
	wram_bank WRAM_CHAR3 ; $48ac
	call FlipCharPositionCode ; $48b2
	ret ; $48b5
.toggleRows:
	wram_bank WRAM_TEXT ; $48b6
	call ToggleCharCourtRow ; $48bc
	wram_bank WRAM_SOUND ; $48bf
	call ToggleCharCourtRow ; $48c5
	ret ; $48c8
.done:
	ld a, [wOnCourtCharCountMinus1] ; $48c9
	add a ; $48cc
	ld_hl_indexed TiebreakPositionPtrs ; $48cd
	ld a, [hl+] ; $48d4
	ld h, [hl] ; $48d5
	ld l, a ; $48d6
	ld a, [wTotalGamesWonInMatch] ; $48d7
	bit 1, a ; $48da
	ld a, [wTotalPointsScoredInCurrentGame] ; $48dc
	jp z, LoadPositionRecord ; $48df
	jp LoadPositionRecord.doubles ; $48e2
TiebreakPositionPtrs:
	; $48e5, 8 bytes (records:2)
	dw TiebreakPositionTables ; record 0
	dw TiebreakPositionTables ; record 1
	dw TiebreakPosition1 ; record 2
	dw TiebreakPosition0 ; record 3
LoadPositionRecord:
	add a ; $48ed
	add a ; $48ee
	add a ; $48ef
	add l ; $48f0
	ld l, a ; $48f1
	jr nc, .singles ; $48f2
	inc h ; $48f4
.singles:
	ld de, wCharCourtPos ; $48f5
	wram_bank WRAM_CHAR0 ; $48f8
	ld a, [hl+] ; $48fe
	ld [de], a ; $48ff
	wram_bank WRAM_CHAR1 ; $4900
	ld a, [hl+] ; $4906
	ld [de], a ; $4907
	wram_bank WRAM_CHAR2 ; $4908
	ld a, [hl+] ; $490e
	ld [de], a ; $490f
	wram_bank WRAM_CHAR3 ; $4910
	ld a, [hl+] ; $4916
	ld [de], a ; $4917
	jr .done ; $4918
.doubles:
	add a ; $491a
	add a ; $491b
	add a ; $491c
	add l ; $491d
	ld l, a ; $491e
	jr nc, .doublesEntry ; $491f
	inc h ; $4921
.doublesEntry:
	ld de, wCharCourtPos ; $4922
	wram_bank WRAM_CHAR0 ; $4925
	ld a, [hl+] ; $492b
	xor $03 ; $492c
	ld [de], a ; $492e
	wram_bank WRAM_CHAR1 ; $492f
	ld a, [hl+] ; $4935
	xor $03 ; $4936
	ld [de], a ; $4938
	wram_bank WRAM_CHAR2 ; $4939
	ld a, [hl+] ; $493f
	xor $03 ; $4940
	ld [de], a ; $4942
	wram_bank WRAM_CHAR3 ; $4943
	ld a, [hl+] ; $4949
	xor $03 ; $494a
	ld [de], a ; $494c
.done:
	ld de, wCharServeRole ; $494d
	wram_bank WRAM_CHAR0 ; $4950
	ld a, [hl+] ; $4956
	ld [de], a ; $4957
	wram_bank WRAM_CHAR1 ; $4958
	ld a, [hl+] ; $495e
	ld [de], a ; $495f
	wram_bank WRAM_CHAR2 ; $4960
	ld a, [hl+] ; $4966
	ld [de], a ; $4967
	wram_bank WRAM_CHAR3 ; $4968
	ld a, [hl+] ; $496e
	ld [de], a ; $496f
	ret ; $4970
ToggleCharCourtRow:
	ld hl, wCharServeRole ; $4971
	ld a, [hl] ; $4974
	xor $02 ; $4975
	ld [hl], a ; $4977
	ret ; $4978
GamePositionTables:
	; $4979, 32 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions $00, $03, $09, $09, $00, $01, $09, $09 ; record 0
	court_positions $03, $00, $09, $09, $01, $00, $09, $09 ; record 1
	court_positions $03, $00, $09, $09, $00, $01, $09, $09 ; record 2
	court_positions $00, $03, $09, $09, $01, $00, $09, $09 ; record 3
GamePosition0:
	; $4999, 32 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions $00, $03, $01, $02, $00, $01, $02, $03 ; record 0
	court_positions $03, $00, $02, $01, $01, $00, $03, $02 ; record 1
	court_positions $02, $00, $03, $01, $02, $01, $00, $03 ; record 2
	court_positions $00, $02, $01, $03, $01, $02, $03, $00 ; record 3
GamePosition1:
	; $49b9, 32 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions $00, $03, $09, $02, $00, $01, $09, $03 ; record 0
	court_positions $03, $00, $09, $01, $01, $00, $09, $02 ; record 1
	court_positions $03, $00, $09, $01, $00, $01, $09, $03 ; record 2
	court_positions $00, $02, $09, $03, $01, $02, $09, $00 ; record 3
TiebreakPositionTables:
	; $49d9, 192 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions $00, $03, $09, $09, $00, $01, $09, $09 ; record 0
	court_positions $01, $02, $09, $09, $01, $00, $09, $09 ; record 1
	court_positions $00, $03, $09, $09, $01, $00, $09, $09 ; record 2
	court_positions $01, $02, $09, $09, $00, $01, $09, $09 ; record 3
	court_positions $00, $03, $09, $09, $00, $01, $09, $09 ; record 4
	court_positions $01, $02, $09, $09, $01, $00, $09, $09 ; record 5
	court_positions $03, $00, $09, $09, $01, $00, $09, $09 ; record 6
	court_positions $02, $01, $09, $09, $00, $01, $09, $09 ; record 7
	court_positions $03, $00, $09, $09, $00, $01, $09, $09 ; record 8
	court_positions $02, $01, $09, $09, $01, $00, $09, $09 ; record 9
	court_positions $03, $00, $09, $09, $01, $00, $09, $09 ; record 10
	court_positions $02, $01, $09, $09, $00, $01, $09, $09 ; record 11
	court_positions $00, $03, $09, $09, $00, $01, $09, $09 ; record 12
	court_positions $01, $02, $09, $09, $01, $00, $09, $09 ; record 13
	court_positions $00, $03, $09, $09, $01, $00, $09, $09 ; record 14
	court_positions $01, $02, $09, $09, $00, $01, $09, $09 ; record 15
	court_positions $00, $03, $09, $09, $00, $01, $09, $09 ; record 16
	court_positions $01, $02, $09, $09, $01, $00, $09, $09 ; record 17
	court_positions $03, $00, $09, $09, $01, $00, $09, $09 ; record 18
	court_positions $02, $01, $09, $09, $00, $01, $09, $09 ; record 19
	court_positions $03, $00, $09, $09, $00, $01, $09, $09 ; record 20
	court_positions $02, $01, $09, $09, $01, $00, $09, $09 ; record 21
	court_positions $03, $00, $09, $09, $01, $00, $09, $09 ; record 22
	court_positions $02, $01, $09, $09, $00, $01, $09, $09 ; record 23
TiebreakPosition0:
	; $4a99, 192 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions $00, $03, $01, $02, $00, $01, $02, $03 ; record 0
	court_positions $00, $02, $01, $03, $03, $00, $01, $02 ; record 1
	court_positions $00, $03, $01, $02, $01, $00, $03, $02 ; record 2
	court_positions $00, $03, $01, $02, $02, $03, $00, $01 ; record 3
	court_positions $01, $03, $00, $02, $02, $01, $00, $03 ; record 4
	court_positions $00, $03, $01, $02, $03, $02, $01, $00 ; record 5
	court_positions $03, $01, $02, $00, $01, $02, $03, $00 ; record 6
	court_positions $02, $00, $03, $01, $00, $03, $02, $01 ; record 7
	court_positions $03, $00, $02, $01, $00, $01, $02, $03 ; record 8
	court_positions $03, $01, $02, $00, $03, $00, $01, $02 ; record 9
	court_positions $03, $00, $02, $01, $01, $00, $03, $02 ; record 10
	court_positions $03, $00, $02, $01, $02, $03, $00, $01 ; record 11
	court_positions $01, $03, $00, $02, $02, $01, $00, $03 ; record 12
	court_positions $00, $03, $01, $02, $03, $02, $01, $00 ; record 13
	court_positions $00, $02, $01, $03, $01, $02, $03, $00 ; record 14
	court_positions $01, $03, $00, $02, $00, $03, $02, $01 ; record 15
	court_positions $00, $03, $01, $02, $00, $01, $02, $03 ; record 16
	court_positions $00, $02, $01, $03, $03, $00, $01, $02 ; record 17
	court_positions $03, $00, $02, $01, $01, $00, $03, $02 ; record 18
	court_positions $03, $00, $02, $01, $02, $03, $00, $01 ; record 19
	court_positions $02, $00, $03, $01, $02, $01, $00, $03 ; record 20
	court_positions $03, $00, $02, $01, $03, $02, $01, $00 ; record 21
	court_positions $03, $01, $02, $00, $01, $02, $03, $00 ; record 22
	court_positions $02, $00, $03, $01, $00, $03, $02, $01 ; record 23
TiebreakPosition1:
	; $4b59, 192 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions $00, $03, $09, $02, $00, $01, $09, $03 ; record 0
	court_positions $01, $02, $09, $03, $01, $00, $09, $02 ; record 1
	court_positions $00, $03, $09, $02, $01, $00, $09, $02 ; record 2
	court_positions $01, $03, $09, $02, $00, $03, $09, $01 ; record 3
	court_positions $00, $03, $09, $02, $00, $01, $09, $03 ; record 4
	court_positions $01, $03, $09, $02, $01, $02, $09, $00 ; record 5
	court_positions $03, $01, $09, $00, $01, $02, $09, $00 ; record 6
	court_positions $02, $00, $09, $01, $00, $03, $09, $01 ; record 7
	court_positions $03, $00, $09, $01, $00, $01, $09, $03 ; record 8
	court_positions $02, $01, $09, $00, $01, $00, $09, $02 ; record 9
	court_positions $03, $00, $09, $01, $01, $00, $09, $02 ; record 10
	court_positions $02, $00, $09, $01, $00, $03, $09, $01 ; record 11
	court_positions $00, $03, $09, $02, $00, $01, $09, $03 ; record 12
	court_positions $01, $03, $09, $02, $01, $02, $09, $00 ; record 13
	court_positions $00, $02, $09, $03, $01, $02, $09, $00 ; record 14
	court_positions $01, $03, $09, $02, $00, $03, $09, $01 ; record 15
	court_positions $00, $03, $09, $02, $00, $01, $09, $03 ; record 16
	court_positions $01, $02, $09, $03, $01, $00, $09, $02 ; record 17
	court_positions $03, $00, $09, $01, $01, $00, $09, $02 ; record 18
	court_positions $02, $00, $09, $01, $00, $03, $09, $01 ; record 19
	court_positions $03, $00, $09, $01, $00, $01, $09, $03 ; record 20
	court_positions $02, $00, $09, $01, $01, $02, $09, $00 ; record 21
	court_positions $03, $01, $09, $00, $01, $02, $09, $00 ; record 22
	court_positions $02, $00, $09, $01, $00, $03, $09, $01 ; record 23
CheckServerEndChanged:
	wram_bank WRAM_CHAR0 ; $4c19
	ld a, [wCharCourtPos] ; $4c1f
	ld b, a ; $4c22
	ld hl, wPrevCourtPos ; $4c23
	ld a, [hl] ; $4c26
	ld [hl], b ; $4c27
	xor b ; $4c28
	and $02 ; $4c29
	jr z, .done ; $4c2b
	ld a, $01 ; $4c2d
	ld [wChangeEndsPending], a ; $4c2f
.done:
	ret ; $4c32
UpdateViewFlipState:
	ld c, $00 ; $4c33
	ld a, [wCourtViewOption] ; $4c35
	and a ; $4c38
	jr z, .store ; $4c39
	ld a, [wPrevCourtPos] ; $4c3b
	and $02 ; $4c3e
	jr z, .store ; $4c40
	ld c, $01 ; $4c42
.store:
	ld hl, wCourtViewFlipped ; $4c44
	ld a, [hl] ; $4c47
	ld [hl], c ; $4c48
	sub c ; $4c49
	ld [wCourtViewFlipChanged], a ; $4c4a
	ret ; $4c4d
FlipAllCharPositions:
	ld a, [wCourtViewFlipped] ; $4c4e
	and a ; $4c51
	ret z ; $4c52
	ld b, $03 ; $4c53
	wram_bank WRAM_CHAR3 ; $4c55
	call FlipCharPositionCode ; $4c5b
	wram_bank WRAM_CHAR2 ; $4c5e
	call FlipCharPositionCode ; $4c64
	wram_bank WRAM_CHAR1 ; $4c67
	call FlipCharPositionCode ; $4c6d
	wram_bank WRAM_ACTORS ; $4c70
	call FlipCharPositionCode ; $4c76
	ret ; $4c79
IdentifyServingPlayer:
	call FindServerCharBank ; $4c7a
	ld a, b ; $4c7d
	wram_bank ; $4c7e
	ld a, b ; $4c82
	ld [wServingCharWramBank], a ; $4c83
	ld a, [wCharIndex] ; $4c86
	ld [wCurrentServingPlayer], a ; $4c89
	ld a, [wCharCourtPos] ; $4c8c
	ld [wServingCharCourtPos], a ; $4c8f
	wram_bank WRAM_CHAR0 ; $4c92
	ret ; $4c98
SetCharFacingFromCourtPos:
	ld a, [wCharCourtPos] ; $4c99
	ld_hl_indexed CourtPosFacingTable_08 ; $4c9c
	ld a, [hl] ; $4ca3
	ld [wCharBaseFacing], a ; $4ca4
	ld [wCharFacingDesired], a ; $4ca7
	ld [wCharFacingShown], a ; $4caa
	ret ; $4cad
CourtPosFacingTable_08:
	; $4cae, 4 bytes (bytes:4)
	db $c0, $c0, $40, $40 ; 0x00
MoveCharToBaseCourtPosition:
	call GetCharBaseCourtPosition ; $4cb2
	call SetCharPosAndTarget ; $4cb5
	ret ; $4cb8

ComputeAimBaseOffset:
	ld hl, wAimSpreadBase ; $56b7
	ld a, [hl+] ; $56ba
	ld d, [hl] ; $56bb
	ld e, a ; $56bc
	ld hl, wCharPosDepth + 1 ; $56bd
	ld a, [hl+] ; $56c0
	ld h, [hl] ; $56c1
	ld l, a ; $56c2
	abs_hl ; $56c3
	sra h ; $56cd
	rr l ; $56cf
	sra h ; $56d1
	rr l ; $56d3
	sra h ; $56d5
	rr l ; $56d7
	add hl, de ; $56d9
	ld a, [wCharAimOffsetScale] ; $56da
	call MulHLByAFrac ; $56dd
	ld e, l ; $56e0
	ld d, h ; $56e1
	ret ; $56e2
ClampShotTargetX:
	ld hl, wCourtLimitX ; $56e3
	ld a, [hl+] ; $56e6
	ld h, [hl] ; $56e7
	ld l, a ; $56e8
	ld bc, $0020 ; $56e9
	add hl, bc ; $56ec
	neg_hl ; $56ed
	ld c, l ; $56f3
	ld b, h ; $56f4
	ld l, e ; $56f5
	ld h, d ; $56f6
	sub_hl_bc ; $56f7
	bit 7, h ; $56fd
	jr nz, .applyJitter ; $56ff
	ld e, c ; $5701
	ld d, b ; $5702
.applyJitter:
	call GetRandomAimJitter ; $5703
	ld a, e ; $5706
	sub h ; $5707
	ld e, a ; $5708
	jr nc, .done ; $5709
	dec d ; $570b
.done:
	ret ; $570c
GetRandomAimJitter:
	farcall AdvanceMatchRng ; $570d
	ld l, a ; $5710
	ld h, $00 ; $5711
	ld a, [wCharAimJitterScale] ; $5713
	call MulHLByA ; $5716
	add hl, hl ; $5719
	add hl, hl ; $571a
	add hl, hl ; $571b
	add hl, hl ; $571c
	ret ; $571d
ComputeShotTrajectory:
	ld a, [wCharCourtPos] ; $571e
	and $02 ; $5721
	jr nz, .aimReady ; $5723
	neg_bc ; $5725
.aimReady:
	ld hl, wShotAimTargetDepth ; $572b
	ld a, c ; $572e
	ld [hl+], a ; $572f
	ld [hl], b ; $5730
	ld hl, wBallDepth ; $5731
	ld a, [hl+] ; $5734
	ld h, [hl] ; $5735
	ld l, a ; $5736
	ld a, c ; $5737
	sub l ; $5738
	ld c, a ; $5739
	ld a, b ; $573a
	sbc h ; $573b
	ld b, a ; $573c
	ld hl, wShotAimDeltaDepth ; $573d
	ld a, c ; $5740
	ld [hl+], a ; $5741
	ld [hl], b ; $5742
	call ComputeShotTargetX ; $5743
	ld hl, wShotAimTargetX ; $5746
	ld a, e ; $5749
	ld [hl+], a ; $574a
	ld [hl], d ; $574b
	ld hl, wBallX ; $574c
	ld a, [hl+] ; $574f
	ld h, [hl] ; $5750
	ld l, a ; $5751
	ld a, e ; $5752
	sub l ; $5753
	ld e, a ; $5754
	ld a, d ; $5755
	sbc h ; $5756
	ld d, a ; $5757
	ld hl, wShotAimDeltaX ; $5758
	ld a, e ; $575b
	ld [hl+], a ; $575c
	ld [hl], d ; $575d
	ld hl, wShotAimDeltaDepth ; $575e
	ld a, [hl+] ; $5761
	ld h, [hl] ; $5762
	ld l, a ; $5763
	call AngleFromVector16 ; $5764
	ld hl, wShotAimAngle ; $5767
	ld a, c ; $576a
	ld [hl+], a ; $576b
	ld [hl], b ; $576c
	ld hl, wShotAimAngle ; $576d
	ld a, [hl+] ; $5770
	ld b, [hl] ; $5771
	ld c, a ; $5772
	ld hl, wBallDepth ; $5773
	ld a, [hl+] ; $5776
	ld h, [hl] ; $5777
	ld l, a ; $5778
	abs_hl ; $5779
	ld de, $0140 ; $5783
	add hl, de ; $5786
	call DivBySin ; $5787
	abs_hl ; $578a
	ld e, l ; $5794
	ld d, h ; $5795
	add hl, hl ; $5796
	add hl, hl ; $5797
	ld a, h ; $5798
	ld [wShotTrajRowMin], a ; $5799
	ld hl, wShotDistMin ; $579c
	ld a, e ; $579f
	ld [hl+], a ; $57a0
	ld [hl], d ; $57a1
	ld hl, wShotAimAngle ; $57a2
	ld a, [hl+] ; $57a5
	ld b, [hl] ; $57a6
	ld c, a ; $57a7
	ld hl, wBallDepth ; $57a8
	ld a, [hl+] ; $57ab
	ld h, [hl] ; $57ac
	ld l, a ; $57ad
	abs_hl ; $57ae
	ld de, $0480 ; $57b8
	add hl, de ; $57bb
	call DivBySin ; $57bc
	abs_hl ; $57bf
	ld e, l ; $57c9
	ld d, h ; $57ca
	add hl, hl ; $57cb
	add hl, hl ; $57cc
	ld a, h ; $57cd
	ld [wShotTrajRowMax], a ; $57ce
	ld hl, wShotDistMax ; $57d1
	ld a, e ; $57d4
	ld [hl+], a ; $57d5
	ld [hl], d ; $57d6
	ld hl, wShotAimAngle ; $57d7
	ld a, [hl+] ; $57da
	ld b, [hl] ; $57db
	ld c, a ; $57dc
	ld l, e ; $57dd
	ld h, d ; $57de
	call MulSinCos ; $57df
	abs_hl ; $57e2
	ld c, l ; $57ec
	ld b, h ; $57ed
	ld hl, -32 ; $57ee
	add hl, bc ; $57f1
	jr nc, .solveHeight ; $57f2
	ld hl, wCourtLimitX ; $57f4
	ld a, [hl+] ; $57f7
	ld h, [hl] ; $57f8
	ld l, a ; $57f9
	ld de, $0020 ; $57fa
	add hl, de ; $57fd
	ld e, l ; $57fe
	ld d, h ; $57ff
	ld a, [wShotAimAngle + 1] ; $5800
	add $40 ; $5803
	bit 7, a ; $5805
	jr z, .absLimitX ; $5807
	neg_de ; $5809
.absLimitX:
	ld hl, wBallX ; $580f
	ld a, [hl+] ; $5812
	ld h, [hl] ; $5813
	ld l, a ; $5814
	add hl, de ; $5815
	abs_hl ; $5816
	ld e, l ; $5820
	ld d, h ; $5821
	sub_hl_bc ; $5822
	bit 7, h ; $5828
	jr z, .solveHeight ; $582a
	push de ; $582c
	ld l, $00 ; $582d
	ld a, [wShotDistMax] ; $582f
	ld h, a ; $5832
	ld a, [wShotDistMax + 1] ; $5833
	ld e, c ; $5836
	ld d, b ; $5837
	call DivAHLByDESigned ; $5838
	pop de ; $583b
	call MulHLByDE ; $583c
	ld h, l ; $583f
	ldh a, [hMulResult + 1] ; $5840
	ld l, a ; $5842
	ld e, l ; $5843
	ld d, h ; $5844
	add hl, hl ; $5845
	add hl, hl ; $5846
	ld a, h ; $5847
	ld [wShotTrajRowMax], a ; $5848
	ld hl, wShotDistMax ; $584b
	ld a, e ; $584e
	ld [hl+], a ; $584f
	ld [hl], d ; $5850
.solveHeight:
	ld hl, wBallHeight ; $5851
	ld a, [hl+] ; $5854
	ld d, [hl] ; $5855
	ld e, a ; $5856
	neg_de ; $5857
	ld hl, wShotSolverNegHeight ; $585d
	ld a, e ; $5860
	ld [hl+], a ; $5861
	ld [hl], d ; $5862
	ld hl, wShotAimTargetX ; $5863
	ld de, wBallTargetX ; $5866
	ld a, [hl+] ; $5869
	ld [de], a ; $586a
	inc de ; $586b
	ld a, [hl+] ; $586c
	ld [de], a ; $586d
	inc de ; $586e
	ld a, [hl+] ; $586f
	ld [de], a ; $5870
	inc de ; $5871
	ld a, [hl+] ; $5872
	ld [de], a ; $5873
	inc de ; $5874
	ret ; $5875
NormalizeBallHeightForShot:
	ld hl, wBallHeight ; $5876
	ld a, [hl+] ; $5879
	ld d, [hl] ; $587a
	ld e, a ; $587b
	ld hl, $0060 ; $587c
	add hl, de ; $587f
	bit 7, h ; $5880
	jr nz, .done ; $5882
	ld hl, $0060 ; $5884
	add hl, de ; $5887
	sra h ; $5888
	rr l ; $588a
	ld a, e ; $588c
	sub l ; $588d
	ld e, a ; $588e
	ld a, d ; $588f
	sbc h ; $5890
	ld d, a ; $5891
	ld hl, wBallHeight ; $5892
	ld a, e ; $5895
	ld [hl+], a ; $5896
	ld [hl], d ; $5897
.done:
	ret ; $5898
RaiseBallHeightForLob:
	ld hl, wBallHeight ; $5899
	ld a, [hl+] ; $589c
	ld d, [hl] ; $589d
	ld e, a ; $589e
	ld hl, $0080 ; $589f
	add hl, de ; $58a2
	bit 7, h ; $58a3
	jr nz, .raise ; $58a5
	ld de, $ffa0 ; $58a7
	ld hl, wBallHeight ; $58aa
	ld a, e ; $58ad
	ld [hl+], a ; $58ae
	ld [hl], d ; $58af
	ret ; $58b0
.raise:
	ld hl, $0020 ; $58b1
	add hl, de ; $58b4
	ld e, l ; $58b5
	ld d, h ; $58b6
	ld hl, wBallHeight ; $58b7
	ld a, e ; $58ba
	ld [hl+], a ; $58bb
	ld [hl], d ; $58bc
	ret ; $58bd
ExecuteShotTopspin:
	ld a, SHOTTYPE_TOPSPIN ; $58be
	ld [wCurrentShotType], a ; $58c0
	call NormalizeBallHeightForShot ; $58c3
	call ApplyShotTypePresets ; $58c6
	call WeakenShotByCharge ; $58c9
	call ComputeShotTrajectory ; $58cc
	farcall ShotBallPathTopspin ; $58cf
	ret ; $58d2
ExecuteShotPowerTopspin:
	ld hl, wCharFlags ; $58d3
	bit CHARB_DIVING, [hl] ; $58d6
	jr nz, ExecuteShotTopspin ; $58d8
	ld a, $01 ; $58da
	ld [wLastShotWasPowerShot], a ; $58dc
	call NormalizeBallHeightForShot ; $58df
	call ApplyShotTypePresets ; $58e2
	call ComputeShotTrajectory ; $58e5
	farcall ShotBallPathPowerTopspin ; $58e8
	ret ; $58eb
ExecuteShotSlice:
	ld a, SHOTTYPE_SLICE ; $58ec
	ld [wCurrentShotType], a ; $58ee
	call NormalizeBallHeightForShot ; $58f1
	call ApplyShotTypePresets ; $58f4
	call WeakenShotByCharge ; $58f7
	call ComputeShotTrajectory ; $58fa
	farcall ShotBallPathSlice ; $58fd
	ret ; $5900
ExecuteShotPowerSlice:
	ld hl, wCharFlags ; $5901
	bit CHARB_DIVING, [hl] ; $5904
	jr nz, ExecuteShotSlice ; $5906
	ld a, $01 ; $5908
	ld [wLastShotWasPowerShot], a ; $590a
	call NormalizeBallHeightForShot ; $590d
	call ApplyShotTypePresets ; $5910
	call ComputeShotTrajectory ; $5913
	farcall ShotBallPathPowerSlice ; $5916
	ret ; $5919
ExecuteShotLob:
	call RaiseBallHeightForLob ; $591a
	call ApplyShotTypePresets ; $591d
	call BoostShotByCharge ; $5920
	call NudgeShotByPlayerMomentum ; $5923
	farcall ComputeShotTrajectory ; $5926
	farcall ShotBallPathLob ; $5929
	ret ; $592c
ExecuteShotDrop:
	call RaiseBallHeightForLob ; $592d
	call ApplyShotTypePresets ; $5930
	call WeakenShotByCharge ; $5933
	call ComputeShotTrajectory ; $5936
	farcall ShotBallPathDrop ; $5939
	ret ; $593c
ExecuteShotReachBasic:
	call CheckBallInSmashRange ; $593d
	jr z, ExecuteShotReach ; $5940
	call NormalizeBallHeightForShot ; $5942
	call ApplyShotTypePresets ; $5945
	call WeakenShotByCharge ; $5948
	call ComputeShotTrajectory ; $594b
	farcall ProjectShotPlacement0 ; $594e
	ret ; $5951
ExecuteShotReachPowerTopspin:
	call CheckBallInSmashRange ; $5952
	jr z, ExecuteShotReach ; $5955
	call NormalizeBallHeightForShot ; $5957
	call ApplyShotTypePresets ; $595a
	call WeakenShotByCharge ; $595d
	call ComputeShotTrajectory ; $5960
	farcall ProjectShotPlacement1 ; $5963
	ret ; $5966
ExecuteShotReachPowerSlice:
	call CheckBallInSmashRange ; $5967
	jr z, ExecuteShotReach ; $596a
	call NormalizeBallHeightForShot ; $596c
	call ApplyShotTypePresets ; $596f
	call WeakenShotByCharge ; $5972
	call ComputeShotTrajectory ; $5975
	farcall ProjectShotPlacement2 ; $5978
	ret ; $597b
ExecuteShotReach:
	ld a, SHOTTYPE_REACH ; $597c
	ld [wCurrentShotType], a ; $597e
	call NormalizeBallHeightForShot ; $5981
	call ApplyShotTypePresets ; $5984
	call WeakenShotByCharge ; $5987
	call ComputeShotTrajectory ; $598a
	farcall ShotBallPathReach ; $598d
	ret ; $5990
ExecuteShotSmash:
	ld a, SHOTTYPE_SMASH ; $5991
	ld [wCurrentShotType], a ; $5993
	ld a, $01 ; $5996
	ld [wLastShotWasPowerShot], a ; $5998
	call NormalizeBallHeightForShot ; $599b
	call ApplyShotTypePresets ; $599e
	call ComputeShotTrajectory ; $59a1
	farcall ShotBallPathSmash ; $59a4
	ret ; $59a7
ExecuteShotNeutral:
	call CheckBallInSmashRange ; $59a8
	jr z, .neutralShot ; $59ab
	ld a, [wCharSwingAnim] ; $59ad
	cp CHARANIM_OVERHEAD ; $59b0
	jr z, ExecuteShotSmash ; $59b2
	cp CHARANIM_SMASH ; $59b4
	jr z, ExecuteShotSmash ; $59b6
.neutralShot:
	call NormalizeBallHeightForShot ; $59b8
	call ApplyShotTypePresets ; $59bb
	call ComputeShotTrajectory ; $59be
	farcall ShotBallPathNeutral ; $59c1
	ret ; $59c4
ExecuteShotServeTopspin:
	call ApplyShotTypePresets ; $59c5
	call ComputeShotTrajectory ; $59c8
	farcall ShotBallPathServeTopspin ; $59cb
	call SetSpecialShotFlagFromBallHeight ; $59ce
	ret ; $59d1
ExecuteShotServeSlice:
	call ApplyShotTypePresets ; $59d2
	call ComputeShotTrajectory ; $59d5
	farcall ShotBallPathServeSlice ; $59d8
	call SetSpecialShotFlagFromBallHeight ; $59db
	ret ; $59de
ExecuteShotServeFlat:
	call ApplyShotTypePresets ; $59df
	call ComputeShotTrajectory ; $59e2
	farcall ShotBallPathServeFlat ; $59e5
	call SetSpecialShotFlagFromBallHeight ; $59e8
	ret ; $59eb
Unused_07_SetSpecialShotFlagThreshold:
	ld hl, wBallHeight ; $59ec
	ld a, [hl+] ; $59ef
	ld h, [hl] ; $59f0
	ld l, a ; $59f1
	ld de, $0140 ; $59f2
	add hl, de ; $59f5
	jr c, .done ; $59f6
	ld a, $01 ; $59f8
	ld [wSpecialShotFlag], a ; $59fa
	ld [wLastShotWasPowerShot], a ; $59fd
.done:
	ret ; $5a00

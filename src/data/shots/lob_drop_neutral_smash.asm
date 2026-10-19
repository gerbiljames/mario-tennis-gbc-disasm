	farptr ShotBallPathLob ; $4000
	farptr ShotBallPathDrop ; $4002
	farptr ApplyFallbackBallTrajectory_24 ; $4004
	farptr ShotBallPathNeutral ; $4006
	farptr ShotBallPathSmash ; $4008
	farptr Unused_24_StubNop ; $400a
	farptr ShotBallPathReach ; $400c
	twin_in ball_traj_entry_ptr6, BallTrajEntryPtr6_24, 24 ; $400e BallTrajEntryPtr6_24
	twin_in ball_traj_entry_ptr4, BallTrajEntryPtr4_24, 24 ; $401e BallTrajEntryPtr4_24
	twin_in seek_ball_traj_entry6, Unused_24_SeekBallTrajEntry6, 24 ; $402b Unused_24_SeekBallTrajEntry6
	twin_in seek_ball_traj_entry4, SeekBallTrajEntry4_24, 24 ; $404a SeekBallTrajEntry4_24
	twin_in set_ball_velocity_from_entry6, SetBallVelocityFromEntry6_24, 24 ; $4069 SetBallVelocityFromEntry6_24
	twin_in set_ball_velocity_from_entry4, SetBallVelocityFromEntry4_24, 24 ; $4090 SetBallVelocityFromEntry4_24
	twin_in set_ball_target_by_prediction, Unused_24_SetBallTargetByPrediction, 24 ; $40a4 Unused_24_SetBallTargetByPrediction
	twin_in apply_ball_trajectory6_capped, Unused_24_ApplyBallTrajectory6Capped, 24 ; $410e Unused_24_ApplyBallTrajectory6Capped
	twin_in apply_ball_trajectory6, Unused_24_ApplyBallTrajectory6, 24 ; $4141 Unused_24_ApplyBallTrajectory6
	twin_in apply_ball_trajectory_capped, ApplyBallTrajectoryCapped_24, 24 ; $4169 ApplyBallTrajectoryCapped_24
	twin_in apply_ball_trajectory4_capped, ApplyBallTrajectory4Capped_24, 24 ; $41a2 ApplyBallTrajectory4Capped_24
	twin_in apply_ball_trajectory4, Unused_24_ApplyBallTrajectory4, 24 ; $41d5 Unused_24_ApplyBallTrajectory4
	twin_in set_ball_target_from_aim, SetBallTargetFromAim_24, 24 ; $4201 SetBallTargetFromAim_24
	twin_in lookup_ball_pos_by_aim_24, LookupBallPosByAim_24, 24 ; $422d LookupBallPosByAim_24
	twin lookup_ball_pos_by_height, 24 ; $4258 LookupBallPosByHeight_24
	twin lookup_ball_pos_by_shot_index, 24 ; $427a LookupBallPosByShotIndex_24
BallPosDataLob_24:
	INCLUDE "data/shots/BallPosDataLob_24.asm" ; $4289, 768 bytes (traj:6)
ShotBallPathLob:
	farcall ComputeShotPlacement ; $4589
	ld hl, BallPosDataLob_24 ; $458c
	ld bc, BallPosBlockOffsetsLob_24 ; $458f
	ld a, [wLobPlacementIndex] ; $4592
	call LookupBallPosByShotIndex_24 ; $4595
	call ApplyBallTrajectoryCapped_24 ; $4598
	ret ; $459b
BallPosBlockOffsetsLob_24:
	INCLUDE "data/shots/BallPosBlockOffsetsLob_24.asm" ; $459c, 4 bytes (words:1)
BallPosDataDrop_24:
	INCLUDE "data/shots/BallPosDataDrop_24.asm" ; $45a0, 3072 bytes (traj:6)
ShotBallPathDrop:
	farcall ComputeShotPlacement ; $51a0
	ld hl, BallPosDataDrop_24 ; $51a3
	ld bc, BallPosAimOffsetsDrop_24 ; $51a6
	call LookupBallPosByAim_24 ; $51a9
	ld bc, BallPosBlockOffsetsDrop_24 ; $51ac
	ld a, [wDropPlacementIndex] ; $51af
	call LookupBallPosByShotIndex_24 ; $51b2
	call ApplyBallTrajectoryCapped_24 ; $51b5
	ret ; $51b8
BallPosAimOffsetsDrop_24:
	INCLUDE "data/shots/BallPosAimOffsetsDrop_24.asm" ; $51b9, 64 bytes (words:1)
BallPosBlockOffsetsDrop_24:
	INCLUDE "data/shots/BallPosBlockOffsetsDrop_24.asm" ; $51f9, 4 bytes (words:1)
BallPosDataFallback_24:
	INCLUDE "data/shots/BallPosDataFallback_24.asm" ; $51fd, 1536 bytes (traj:6)
ApplyFallbackBallTrajectory_24:
	ld a, $01 ; $57fd
	ld [wFallbackTrajectoryFlag], a ; $57ff
	xor a ; $5802
	ld [wBallTrailColor], a ; $5803
	xor a ; $5806
	ld hl, wBallTopspin ; $5807
	ASSERT wBallSideSpin == wBallTopspin + 2, "this code walks from wBallTopspin into wBallSideSpin"
	ld [hl+], a ; $580a
	ld [hl+], a ; $580b
	ld [hl+], a ; $580c
	ld [hl+], a ; $580d
	ld a, d ; $580e
	srl a ; $580f
	ld bc, $0280 ; $5811
	cp $04 ; $5814
	jr c, .solve ; $5816
	ld a, $03 ; $5818
	ld bc, $0140 ; $581a
	jr z, .solve ; $581d
	ld a, $00 ; $581f
	ld bc, $00e0 ; $5821
.solve:
	push af ; $5824
	farcall ComputeShotTrajectory ; $5825
	pop af ; $5828
	add a ; $5829
	ld_hl_indexed BallPosFallbackOffsets_24 ; $582a
	ld a, [hl+] ; $5831
	ld d, [hl] ; $5832
	ld e, a ; $5833
	ld hl, BallPosDataFallback_24 ; $5834
	add hl, de ; $5837
	call ApplyBallTrajectoryCapped_24 ; $5838
	ret ; $583b
BallPosFallbackOffsets_24:
	INCLUDE "data/shots/BallPosFallbackOffsets_24.asm" ; $583c, 8 bytes (words:1)
BallPosDataNeutral_24:
	INCLUDE "data/shots/BallPosDataNeutral_24.asm" ; $5844, 3584 bytes (traj:4:64)
ShotBallPathNeutral:
	farcall ComputeShotPlacement ; $6644
	push bc ; $6647
	ld hl, BallPosDataNeutral_24 ; $6648
	ld bc, BallPosHeightOffsetsNeutral_24 ; $664b
	call LookupBallPosByHeight_24 ; $664e
	pop bc ; $6651
	call ApplyBallTrajectory4Capped_24 ; $6652
	ret ; $6655
BallPosHeightOffsetsNeutral_24:
	; $6656, 64 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0100 ; record 3
	dw $0200 ; record 4
	dw $0300 ; record 5
	dw $0400 ; record 6
	dw $0500 ; record 7
	dw $0600 ; record 8
	dw $0700 ; record 9
	dw $0800 ; record 10
	dw $0900 ; record 11
	dw $0a00 ; record 12
	dw $0b00 ; record 13
	dw $0c00 ; record 14
	dw $0d00 ; record 15
	dw $0d00 ; record 16
	dw $0d00 ; record 17
	dw $0d00 ; record 18
	dw $0d00 ; record 19
	dw $0d00 ; record 20
	dw $0d00 ; record 21
	dw $0d00 ; record 22
	dw $0d00 ; record 23
	dw $0d00 ; record 24
	dw $0d00 ; record 25
	dw $0d00 ; record 26
	dw $0d00 ; record 27
	dw $0d00 ; record 28
	dw $0d00 ; record 29
	dw $0d00 ; record 30
	dw $0d00 ; record 31
ShotBallPathSmash:
	farcall ComputeShotPlacement ; $6696
	push bc ; $6699
	ld hl, wShotDistMax ; $669a
	ld a, [hl+] ; $669d
	ld d, [hl] ; $669e
	ld e, a ; $669f
	ld hl, wBallDepth ; $66a0
	ld a, [hl+] ; $66a3
	ld h, [hl] ; $66a4
	ld l, a ; $66a5
	bit 7, h ; $66a6
	jr z, .offset ; $66a8
	xor a ; $66aa
	sub l ; $66ab
	ld l, a ; $66ac
	sbc a ; $66ad
	sub h ; $66ae
	ld h, a ; $66af
.offset:
	add hl, de ; $66b0
	ld e, l ; $66b1
	ld d, h ; $66b2
	ld hl, wBallHeight ; $66b3
	ld a, [hl+] ; $66b6
	ld h, [hl] ; $66b7
	ld l, a ; $66b8
	xor a ; $66b9
	sub l ; $66ba
	ld l, a ; $66bb
	sbc a ; $66bc
	sub h ; $66bd
	ld h, a ; $66be
	ld c, l ; $66bf
	ld b, h ; $66c0
	sra b ; $66c1
	rr c ; $66c3
	add hl, bc ; $66c5
	call AngleFromVector16 ; $66c6
	ld a, [wSmashServeSpeedIndex] ; $66c9
	add a ; $66cc
	ld_hl_indexed SmashElevationBySpeed_24 ; $66cd
	ld a, [hl+] ; $66d4
	ld h, [hl] ; $66d5
	ld l, a ; $66d6
	add hl, bc ; $66d7
	ld c, l ; $66d8
	ld b, h ; $66d9
	ld hl, wShotAimAngle ; $66da
	ld a, [hl+] ; $66dd
	ld d, [hl] ; $66de
	ld e, a ; $66df
	pop hl ; $66e0
	farcall SetBallVelocityPolar ; $66e1
	ld hl, wShotDistMax ; $66e4
	ld a, [hl+] ; $66e7
	ld d, [hl] ; $66e8
	ld e, a ; $66e9
	ld hl, $ff00 ; $66ea
	add hl, de ; $66ed
	call SetBallTargetFromAim_24 ; $66ee
	ret ; $66f1
SmashElevationBySpeed_24:
	; $66f2, 20 bytes (records:2)
	dw $fa60 ; record 0
	dw $faf0 ; record 1
	dw $fb80 ; record 2
	dw $fc10 ; record 3
	dw $fca0 ; record 4
	dw $fd30 ; record 5
	dw $fdc0 ; record 6
	dw $fe50 ; record 7
	dw $fee0 ; record 8
	dw $ff70 ; record 9
Unused_24_StubNop:
	ret ; $6706
BallPosDataReach_24:
	INCLUDE "data/shots/BallPosDataReach_24.asm" ; $6707, 4096 bytes (traj:4:64)
ShotBallPathReach:
	farcall ComputeShotPlacement ; $7707
	push bc ; $770a
	ld hl, BallPosDataReach_24 ; $770b
	ld bc, BallPosHeightOffsetsReach_24 ; $770e
	call LookupBallPosByHeight_24 ; $7711
	pop bc ; $7714
	call ApplyBallTrajectory4Capped_24 ; $7715
	ret ; $7718
BallPosHeightOffsetsReach_24:
	INCLUDE "data/shots/BallPosHeightOffsetsReach_24.asm" ; $7719, 64 bytes (words:1)
	; $7759, 2215 bytes fill to bank end (linker-padded)

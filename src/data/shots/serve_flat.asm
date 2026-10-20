	farptr ShotBallPathServeFlat ; $4000
	twin_in ball_traj_entry_ptr6, Unused_2b_BallTrajEntryPtr6, 2b ; $4002 Unused_2b_BallTrajEntryPtr6
	twin_in ball_traj_entry_ptr4, Unused_2b_BallTrajEntryPtr4, 2b ; $4012 Unused_2b_BallTrajEntryPtr4
	twin_in seek_ball_traj_entry6, Unused_2b_SeekBallTrajEntry6, 2b ; $401f Unused_2b_SeekBallTrajEntry6
	twin_in seek_ball_traj_entry4, Unused_2b_SeekBallTrajEntry4, 2b ; $403e Unused_2b_SeekBallTrajEntry4
	twin_in set_ball_velocity_from_entry6, Unused_2b_SetBallVelocityFromEntry6, 2b ; $405d Unused_2b_SetBallVelocityFromEntry6
	twin_in set_ball_velocity_from_entry4, Unused_2b_SetBallVelocityFromEntry4, 2b ; $4084 Unused_2b_SetBallVelocityFromEntry4
	twin_in set_ball_target_by_prediction, SetBallTargetByPrediction_2b, 2b ; $4098 SetBallTargetByPrediction_2b
	twin_in apply_ball_trajectory6_capped, Unused_2b_ApplyBallTrajectory6Capped, 2b ; $4102 Unused_2b_ApplyBallTrajectory6Capped
	twin_in apply_ball_trajectory6, Unused_2b_ApplyBallTrajectory6, 2b ; $4135 Unused_2b_ApplyBallTrajectory6
	twin_in apply_ball_trajectory_capped, Unused_2b_ApplyBallTrajectoryCapped, 2b ; $415d Unused_2b_ApplyBallTrajectoryCapped
	twin_in apply_ball_trajectory4_capped, Unused_2b_ApplyBallTrajectory4Capped, 2b ; $4196 Unused_2b_ApplyBallTrajectory4Capped
	twin_in apply_ball_trajectory4, Unused_2b_ApplyBallTrajectory4, 2b ; $41c9 Unused_2b_ApplyBallTrajectory4
	twin_in set_ball_target_from_aim, Unused_2b_SetBallTargetFromAim, 2b ; $41f5 Unused_2b_SetBallTargetFromAim
	twin_in lookup_ball_pos_by_aim, Unused_2b_LookupBallPosByAim, 2b ; $4221 Unused_2b_LookupBallPosByAim
	twin lookup_ball_pos_by_height, 2b ; $424c LookupBallPosByHeight_2b
	twin lookup_ball_pos_by_shot_index, 2b ; $426e LookupBallPosByShotIndex_2b
BallPosDataServeFlat_2b:
	INCLUDE "data/shots/BallPosDataServeFlat_2b.asm" ; $427d, 7200 bytes (traj:6)
ShotBallPathServeFlat:
	farcall ComputeShotPlacement ; $5e9d
	ld hl, BallPosDataServeFlat_2b ; $5ea0
	ld bc, BallPosBlockOffsetsServeFlat_2b ; $5ea3
	xor a ; $5ea6
	call LookupBallPosByShotIndex_2b ; $5ea7
	ld bc, BallPosSubOffsetsServeFlat_2b ; $5eaa
	ld a, [wSmashServeSpeedIndex] ; $5ead
	call LookupBallPosByShotIndex_2b ; $5eb0
	ld bc, BallPosHeightOffsetsServeFlat_2b ; $5eb3
	call LookupBallPosByHeight_2b ; $5eb6
	call SetBallTargetByPrediction_2b ; $5eb9
	ret ; $5ebc
BallPosBlockOffsetsServeFlat_2b:
	; $5ebd, 20 bytes (records:2)
	dw $0000 ; record 0
	dw $02d0 ; record 1
	dw $05a0 ; record 2
	dw $0870 ; record 3
	dw $0b40 ; record 4
	dw $0e10 ; record 5
	dw $10e0 ; record 6
	dw $13b0 ; record 7
	dw $1680 ; record 8
	dw $1950 ; record 9
BallPosSubOffsetsServeFlat_2b:
	; $5ed1, 20 bytes (records:2)
	dw $0000 ; record 0
	dw $0048 ; record 1
	dw $0090 ; record 2
	dw $00d8 ; record 3
	dw $0120 ; record 4
	dw $0168 ; record 5
	dw $01b0 ; record 6
	dw $01f8 ; record 7
	dw $0240 ; record 8
	dw $0288 ; record 9
BallPosHeightOffsetsServeFlat_2b:
	; $5ee5, 64 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0000 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0000 ; record 7
	dw $0000 ; record 8
	dw $0000 ; record 9
	dw $0000 ; record 10
	dw $0000 ; record 11
	dw $0006 ; record 12
	dw $000c ; record 13
	dw $0012 ; record 14
	dw $0018 ; record 15
	dw $001e ; record 16
	dw $0024 ; record 17
	dw $002a ; record 18
	dw $0030 ; record 19
	dw $0036 ; record 20
	dw $003c ; record 21
	dw $0042 ; record 22
	dw $0042 ; record 23
	dw $0042 ; record 24
	dw $0042 ; record 25
	dw $0042 ; record 26
	dw $0042 ; record 27
	dw $0042 ; record 28
	dw $0042 ; record 29
	dw $0042 ; record 30
	dw $0042 ; record 31
	; $5f25, 8411 bytes fill to bank end (linker-padded)

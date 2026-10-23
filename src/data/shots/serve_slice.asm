	farptr ShotBallPathServeSlice ; $4000
	twin_in ball_traj_entry_ptr6, Unused_2a_BallTrajEntryPtr6, 2a ; $4002 Unused_2a_BallTrajEntryPtr6
	twin_in ball_traj_entry_ptr4, Unused_2a_BallTrajEntryPtr4, 2a ; $4012 Unused_2a_BallTrajEntryPtr4
	twin_in seek_ball_traj_entry6, Unused_2a_SeekBallTrajEntry6, 2a ; $401f Unused_2a_SeekBallTrajEntry6
	twin_in seek_ball_traj_entry4, Unused_2a_SeekBallTrajEntry4, 2a ; $403e Unused_2a_SeekBallTrajEntry4
	twin_in set_ball_velocity_from_entry6, Unused_2a_SetBallVelocityFromEntry6, 2a ; $405d Unused_2a_SetBallVelocityFromEntry6
	twin_in set_ball_velocity_from_entry4, Unused_2a_SetBallVelocityFromEntry4, 2a ; $4084 Unused_2a_SetBallVelocityFromEntry4
	twin_in set_ball_target_by_prediction, SetBallTargetByPrediction_2a, 2a ; $4098 SetBallTargetByPrediction_2a
	twin_in apply_ball_trajectory6_capped, Unused_2a_ApplyBallTrajectory6Capped, 2a ; $4102 Unused_2a_ApplyBallTrajectory6Capped
	twin_in apply_ball_trajectory6, Unused_2a_ApplyBallTrajectory6, 2a ; $4135 Unused_2a_ApplyBallTrajectory6
	twin_in apply_ball_trajectory_capped, Unused_2a_ApplyBallTrajectoryCapped, 2a ; $415d Unused_2a_ApplyBallTrajectoryCapped
	twin_in apply_ball_trajectory4_capped, Unused_2a_ApplyBallTrajectory4Capped, 2a ; $4196 Unused_2a_ApplyBallTrajectory4Capped
	twin_in apply_ball_trajectory4, Unused_2a_ApplyBallTrajectory4, 2a ; $41c9 Unused_2a_ApplyBallTrajectory4
	twin_in set_ball_target_from_aim, Unused_2a_SetBallTargetFromAim, 2a ; $41f5 Unused_2a_SetBallTargetFromAim
	twin_in lookup_ball_pos_by_aim, Unused_2a_LookupBallPosByAim, 2a ; $4221 Unused_2a_LookupBallPosByAim
	twin lookup_ball_pos_by_height, 2a ; $424c LookupBallPosByHeight_2a
	twin lookup_ball_pos_by_shot_index, 2a ; $426e LookupBallPosByShotIndex_2a
BallPosDataServeSlice_2a:
	INCLUDE "data/shots/BallPosDataServeSlice_2a.asm" ; $427d, 7200 bytes (traj:6)
ShotBallPathServeSlice:
	farcall ComputeShotPlacement ; $5e9d
	ld hl, BallPosDataServeSlice_2a ; $5ea0
	ld bc, BallPosBlockOffsetsServeSlice_2a ; $5ea3
	ld a, [wSlicePlacementIndex] ; $5ea6
	call LookupBallPosByShotIndex_2a ; $5ea9
	ld bc, BallPosSubOffsetsServeSlice_2a ; $5eac
	ld a, [wSmashServeSpeedIndex] ; $5eaf
	call LookupBallPosByShotIndex_2a ; $5eb2
	ld bc, BallPosHeightOffsetsServeSlice_2a ; $5eb5
	call LookupBallPosByHeight_2a ; $5eb8
	call SetBallTargetByPrediction_2a ; $5ebb
	ret ; $5ebe
BallPosBlockOffsetsServeSlice_2a:
	; $5ebf, 20 bytes (records:2)
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
BallPosSubOffsetsServeSlice_2a:
	; $5ed3, 20 bytes (records:2)
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
BallPosHeightOffsetsServeSlice_2a:
	; $5ee7, 64 bytes (records:2)
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
	; $5f27, 8409 bytes fill to bank end (linker-padded)

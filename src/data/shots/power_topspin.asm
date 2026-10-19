	farptr ShotBallPathPowerTopspin ; $4000
	twin_in ball_traj_entry_ptr6, BallTrajEntryPtr6_23, 23 ; $4002 BallTrajEntryPtr6_23
	twin_in ball_traj_entry_ptr4, Unused_23_BallTrajEntryPtr4, 23 ; $4012 Unused_23_BallTrajEntryPtr4
	twin_in seek_ball_traj_entry6, SeekBallTrajEntry6_23, 23 ; $401f SeekBallTrajEntry6_23
	twin_in seek_ball_traj_entry4, Unused_23_SeekBallTrajEntry4, 23 ; $403e Unused_23_SeekBallTrajEntry4
	twin_in set_ball_velocity_from_entry6, SetBallVelocityFromEntry6_23, 23 ; $405d SetBallVelocityFromEntry6_23
	twin_in set_ball_velocity_from_entry4, Unused_23_SetBallVelocityFromEntry4, 23 ; $4084 Unused_23_SetBallVelocityFromEntry4
	twin_in set_ball_target_by_prediction, Unused_23_SetBallTargetByPrediction, 23 ; $4098 Unused_23_SetBallTargetByPrediction
	twin_in apply_ball_trajectory6_capped, ApplyBallTrajectory6Capped_23, 23 ; $4102 ApplyBallTrajectory6Capped_23
	twin_in apply_ball_trajectory6, Unused_23_ApplyBallTrajectory6, 23 ; $4135 Unused_23_ApplyBallTrajectory6
	twin_in apply_ball_trajectory_capped, Unused_23_ApplyBallTrajectoryCapped, 23 ; $415d Unused_23_ApplyBallTrajectoryCapped
	twin_in apply_ball_trajectory4_capped, Unused_23_ApplyBallTrajectory4Capped, 23 ; $4196 Unused_23_ApplyBallTrajectory4Capped
	twin_in apply_ball_trajectory4, Unused_23_ApplyBallTrajectory4, 23 ; $41c9 Unused_23_ApplyBallTrajectory4
	twin_in set_ball_target_from_aim, SetBallTargetFromAim_23, 23 ; $41f5 SetBallTargetFromAim_23
	twin_in lookup_ball_pos_by_aim, Unused_23_LookupBallPosByAim, 23 ; $4221 Unused_23_LookupBallPosByAim
	twin lookup_ball_pos_by_height, 23 ; $424c LookupBallPosByHeight_23
	twin lookup_ball_pos_by_shot_index, 23 ; $426e LookupBallPosByShotIndex_23
BallPosData_23:
	INCLUDE "data/shots/BallPosData_23.asm" ; $427d, 15360 bytes (traj:6:64)
	twin_in shot_ball_path_topspin, ShotBallPathPowerTopspin, 23 ; $7e7d
BallPosHeightOffsets_23:
	; $7e98, 64 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0000 ; record 4
	dw $0000 ; record 5
	dw $0f00 ; record 6
	dw $0f00 ; record 7
	dw $0f00 ; record 8
	dw $1e00 ; record 9
	dw $1e00 ; record 10
	dw $1e00 ; record 11
	dw $2d00 ; record 12
	dw $2d00 ; record 13
	dw $2d00 ; record 14
	dw $2d00 ; record 15
	dw $2d00 ; record 16
	dw $2d00 ; record 17
	dw $2d00 ; record 18
	dw $2d00 ; record 19
	dw $2d00 ; record 20
	dw $2d00 ; record 21
	dw $2d00 ; record 22
	dw $2d00 ; record 23
	dw $2d00 ; record 24
	dw $2d00 ; record 25
	dw $2d00 ; record 26
	dw $2d00 ; record 27
	dw $2d00 ; record 28
	dw $2d00 ; record 29
	dw $2d00 ; record 30
	dw $2d00 ; record 31
BallPosBlockOffsets_23:
	; $7ed8, 20 bytes (records:2)
	dw $0000 ; record 0
	dw $0180 ; record 1
	dw $0300 ; record 2
	dw $0480 ; record 3
	dw $0600 ; record 4
	dw $0780 ; record 5
	dw $0900 ; record 6
	dw $0a80 ; record 7
	dw $0c00 ; record 8
	dw $0d80 ; record 9
	; $7eec, 276 bytes fill to bank end (linker-padded)

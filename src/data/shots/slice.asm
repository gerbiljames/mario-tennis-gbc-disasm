	farptr ShotBallPathSlice ; $4000
	twin_in ball_traj_entry_ptr6, BallTrajEntryPtr6_20, 20 ; $4002 BallTrajEntryPtr6_20
	twin_in ball_traj_entry_ptr4, Unused_20_BallTrajEntryPtr4, 20 ; $4012 Unused_20_BallTrajEntryPtr4
	twin_in seek_ball_traj_entry6, SeekBallTrajEntry6_20, 20 ; $401f SeekBallTrajEntry6_20
	twin_in seek_ball_traj_entry4, Unused_20_SeekBallTrajEntry4, 20 ; $403e Unused_20_SeekBallTrajEntry4
	twin_in set_ball_velocity_from_entry6, SetBallVelocityFromEntry6_20, 20 ; $405d SetBallVelocityFromEntry6_20
	twin_in set_ball_velocity_from_entry4, Unused_20_SetBallVelocityFromEntry4, 20 ; $4084 Unused_20_SetBallVelocityFromEntry4
	twin_in set_ball_target_by_prediction, Unused_20_SetBallTargetByPrediction, 20 ; $4098 Unused_20_SetBallTargetByPrediction
	twin_in apply_ball_trajectory6_capped, ApplyBallTrajectory6Capped_20, 20 ; $4102 ApplyBallTrajectory6Capped_20
	twin_in apply_ball_trajectory6, Unused_20_ApplyBallTrajectory6, 20 ; $4135 Unused_20_ApplyBallTrajectory6
	twin_in apply_ball_trajectory_capped, Unused_20_ApplyBallTrajectoryCapped, 20 ; $415d Unused_20_ApplyBallTrajectoryCapped
	twin_in apply_ball_trajectory4_capped, Unused_20_ApplyBallTrajectory4Capped, 20 ; $4196 Unused_20_ApplyBallTrajectory4Capped
	twin_in apply_ball_trajectory4, Unused_20_ApplyBallTrajectory4, 20 ; $41c9 Unused_20_ApplyBallTrajectory4
	twin_in set_ball_target_from_aim, SetBallTargetFromAim_20, 20 ; $41f5 SetBallTargetFromAim_20
	twin_in lookup_ball_pos_by_aim, Unused_20_LookupBallPosByAim, 20 ; $4221 Unused_20_LookupBallPosByAim
	twin lookup_ball_pos_by_height, 20 ; $424c LookupBallPosByHeight_20
	twin lookup_ball_pos_by_shot_index, 20 ; $426e LookupBallPosByShotIndex_20
BallPosData_20:
	INCLUDE "data/shots/BallPosData_20.asm" ; $427d, 15360 bytes (traj:6:64)
	twin_in shot_ball_path_slice, ShotBallPathSlice, 20 ; $7e7d
BallPosHeightOffsets_20:
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
BallPosBlockOffsets_20:
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

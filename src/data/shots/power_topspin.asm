	farptr ShotBallPathPowerTopspin ; $4000
; Instruction-identical to BallTrajEntryPtr6_20, BallTrajEntryPtr6_21, BallTrajEntryPtr6_22, BallTrajEntryPtr6_24, Unused_29_BallTrajEntryPtr6, Unused_2a_BallTrajEntryPtr6, Unused_2b_BallTrajEntryPtr6 and BallTrajEntryPtr6_2c (one copy per bank); a change here belongs in every copy.
	twin_in ball_traj_entry_ptr6, BallTrajEntryPtr6_23, 23 ; $4002 BallTrajEntryPtr6_23
; Instruction-identical to Unused_20_BallTrajEntryPtr4, Unused_21_BallTrajEntryPtr4, Unused_22_BallTrajEntryPtr4, BallTrajEntryPtr4_24, Unused_29_BallTrajEntryPtr4, Unused_2a_BallTrajEntryPtr4, Unused_2b_BallTrajEntryPtr4 and BallTrajEntryPtr4_2c (one copy per bank); a change here belongs in every copy.
	twin_in ball_traj_entry_ptr4, Unused_23_BallTrajEntryPtr4, 23 ; $4012 Unused_23_BallTrajEntryPtr4
; Instruction-identical to SeekBallTrajEntry6_20, SeekBallTrajEntry6_21, SeekBallTrajEntry6_22, Unused_24_SeekBallTrajEntry6, Unused_29_SeekBallTrajEntry6, Unused_2a_SeekBallTrajEntry6, Unused_2b_SeekBallTrajEntry6 and SeekBallTrajEntry6_2c (one copy per bank); a change here belongs in every copy.
	twin_in seek_ball_traj_entry6, SeekBallTrajEntry6_23, 23 ; $401f SeekBallTrajEntry6_23
; Instruction-identical to Unused_20_SeekBallTrajEntry4, Unused_21_SeekBallTrajEntry4, Unused_22_SeekBallTrajEntry4, SeekBallTrajEntry4_24, Unused_29_SeekBallTrajEntry4, Unused_2a_SeekBallTrajEntry4, Unused_2b_SeekBallTrajEntry4 and SeekBallTrajEntry4_2c (one copy per bank); a change here belongs in every copy.
	twin_in seek_ball_traj_entry4, Unused_23_SeekBallTrajEntry4, 23 ; $403e Unused_23_SeekBallTrajEntry4
; Instruction-identical to SetBallVelocityFromEntry6_20, SetBallVelocityFromEntry6_21, SetBallVelocityFromEntry6_22, SetBallVelocityFromEntry6_24, Unused_29_SetBallVelocityFromEntry6, Unused_2a_SetBallVelocityFromEntry6, Unused_2b_SetBallVelocityFromEntry6 and SetBallVelocityFromEntry6_2c (one copy per bank); a change here belongs in every copy.
	twin_in set_ball_velocity_from_entry6, SetBallVelocityFromEntry6_23, 23 ; $405d SetBallVelocityFromEntry6_23
; Instruction-identical to Unused_20_SetBallVelocityFromEntry4, Unused_21_SetBallVelocityFromEntry4, Unused_22_SetBallVelocityFromEntry4, SetBallVelocityFromEntry4_24, Unused_29_SetBallVelocityFromEntry4, Unused_2a_SetBallVelocityFromEntry4, Unused_2b_SetBallVelocityFromEntry4 and SetBallVelocityFromEntry4_2c (one copy per bank); a change here belongs in every copy.
	twin_in set_ball_velocity_from_entry4, Unused_23_SetBallVelocityFromEntry4, 23 ; $4084 Unused_23_SetBallVelocityFromEntry4
; Instruction-identical to Unused_20_SetBallTargetByPrediction, Unused_21_SetBallTargetByPrediction, Unused_22_SetBallTargetByPrediction, Unused_24_SetBallTargetByPrediction, SetBallTargetByPrediction_29, SetBallTargetByPrediction_2a, SetBallTargetByPrediction_2b and Unused_2c_SetBallTargetByPrediction (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in set_ball_target_by_prediction, Unused_23_SetBallTargetByPrediction, 23 ; $4098 Unused_23_SetBallTargetByPrediction
; Instruction-identical to ApplyBallTrajectory6Capped_20, ApplyBallTrajectory6Capped_21, ApplyBallTrajectory6Capped_22, Unused_24_ApplyBallTrajectory6Capped, Unused_29_ApplyBallTrajectory6Capped, Unused_2a_ApplyBallTrajectory6Capped, Unused_2b_ApplyBallTrajectory6Capped and Unused_2c_ApplyBallTrajectory6Capped (one copy per bank); a change here belongs in every copy.
	twin_in apply_ball_trajectory6_capped, ApplyBallTrajectory6Capped_23, 23 ; $4102 ApplyBallTrajectory6Capped_23
; Instruction-identical to Unused_20_ApplyBallTrajectory6, Unused_21_ApplyBallTrajectory6, Unused_22_ApplyBallTrajectory6, Unused_24_ApplyBallTrajectory6, Unused_29_ApplyBallTrajectory6, Unused_2a_ApplyBallTrajectory6, Unused_2b_ApplyBallTrajectory6 and ApplyBallTrajectory6_2c (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory6, Unused_23_ApplyBallTrajectory6, 23 ; $4135 Unused_23_ApplyBallTrajectory6
; Instruction-identical to Unused_20_ApplyBallTrajectoryCapped, Unused_21_ApplyBallTrajectoryCapped, Unused_22_ApplyBallTrajectoryCapped, ApplyBallTrajectoryCapped_24, Unused_2a_ApplyBallTrajectoryCapped, Unused_2b_ApplyBallTrajectoryCapped and Unused_2c_ApplyBallTrajectoryCapped (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory_capped, Unused_23_ApplyBallTrajectoryCapped, 23 ; $415d Unused_23_ApplyBallTrajectoryCapped
; Instruction-identical to Unused_20_ApplyBallTrajectory4Capped, Unused_21_ApplyBallTrajectory4Capped, Unused_22_ApplyBallTrajectory4Capped, ApplyBallTrajectory4Capped_24, Unused_29_ApplyBallTrajectory4Capped, Unused_2a_ApplyBallTrajectory4Capped, Unused_2b_ApplyBallTrajectory4Capped and Unused_2c_ApplyBallTrajectory4Capped (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory4_capped, Unused_23_ApplyBallTrajectory4Capped, 23 ; $4196 Unused_23_ApplyBallTrajectory4Capped
; Instruction-identical to Unused_20_ApplyBallTrajectory4, Unused_21_ApplyBallTrajectory4, Unused_22_ApplyBallTrajectory4, Unused_24_ApplyBallTrajectory4, Unused_29_ApplyBallTrajectory4, Unused_2a_ApplyBallTrajectory4, Unused_2b_ApplyBallTrajectory4 and ApplyBallTrajectory4_2c (one copy per bank); a change here belongs in every copy.
	twin_in apply_ball_trajectory4, Unused_23_ApplyBallTrajectory4, 23 ; $41c9 Unused_23_ApplyBallTrajectory4
; Instruction-identical to SetBallTargetFromAim_20, SetBallTargetFromAim_21, SetBallTargetFromAim_22, SetBallTargetFromAim_24, Unused_29_SetBallTargetFromAim, Unused_2a_SetBallTargetFromAim, Unused_2b_SetBallTargetFromAim and SetBallTargetFromAim_2c (one copy per bank); a change here belongs in every copy.
	twin_in set_ball_target_from_aim, SetBallTargetFromAim_23, 23 ; $41f5 SetBallTargetFromAim_23
; Instruction-identical to Unused_20_LookupBallPosByAim, Unused_21_LookupBallPosByAim, Unused_22_LookupBallPosByAim, Unused_29_LookupBallPosByAim, Unused_2a_LookupBallPosByAim and Unused_2b_LookupBallPosByAim (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in lookup_ball_pos_by_aim, Unused_23_LookupBallPosByAim, 23 ; $4221 Unused_23_LookupBallPosByAim
; Instruction-identical to LookupBallPosByHeight_20, LookupBallPosByHeight_21, LookupBallPosByHeight_22, LookupBallPosByHeight_24, LookupBallPosByHeight_29, LookupBallPosByHeight_2a, LookupBallPosByHeight_2b and LookupBallPosByHeight_2c (one copy per bank); a change here belongs in every copy.
	twin lookup_ball_pos_by_height, 23 ; $424c LookupBallPosByHeight_23
; Instruction-identical to LookupBallPosByShotIndex_20, LookupBallPosByShotIndex_21, LookupBallPosByShotIndex_22, LookupBallPosByShotIndex_24, LookupBallPosByShotIndex_29, LookupBallPosByShotIndex_2a and LookupBallPosByShotIndex_2b (one copy per bank); a change here belongs in every copy.
	twin lookup_ball_pos_by_shot_index, 23 ; $426e LookupBallPosByShotIndex_23
BallPosData_23:
	INCLUDE "data/bank_023/BallPosData_23.asm" ; $427d, 15360 bytes (traj:6:64)
; Instruction-identical to ShotBallPathTopspin (one copy per bank); a change here belongs in every copy.
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

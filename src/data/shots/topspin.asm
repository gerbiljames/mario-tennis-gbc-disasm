	farptr ShotBallPathTopspin ; $4000
; Instruction-identical to BallTrajEntryPtr6_20, BallTrajEntryPtr6_21, BallTrajEntryPtr6_23, BallTrajEntryPtr6_24, BallTrajEntryPtr6_29, BallTrajEntryPtr6_2a, BallTrajEntryPtr6_2b and BallTrajEntryPtr6_2c (one copy per bank); a change here belongs in every copy.
	twin ball_traj_entry_ptr6, 22 ; $4002 BallTrajEntryPtr6_22
; Instruction-identical to BallTrajEntryPtr4_20, BallTrajEntryPtr4_21, BallTrajEntryPtr4_23, BallTrajEntryPtr4_24, BallTrajEntryPtr4_29, BallTrajEntryPtr4_2a, BallTrajEntryPtr4_2b and BallTrajEntryPtr4_2c (one copy per bank); a change here belongs in every copy.
	twin ball_traj_entry_ptr4, 22 ; $4012 BallTrajEntryPtr4_22
; Instruction-identical to SeekBallTrajEntry6_20, SeekBallTrajEntry6_21, SeekBallTrajEntry6_23, SeekBallTrajEntry6_24, SeekBallTrajEntry6_29, SeekBallTrajEntry6_2a, SeekBallTrajEntry6_2b and SeekBallTrajEntry6_2c (one copy per bank); a change here belongs in every copy.
	twin seek_ball_traj_entry6, 22 ; $401f SeekBallTrajEntry6_22
; Instruction-identical to SeekBallTrajEntry4_20, SeekBallTrajEntry4_21, SeekBallTrajEntry4_23, SeekBallTrajEntry4_24, SeekBallTrajEntry4_29, SeekBallTrajEntry4_2a, SeekBallTrajEntry4_2b and SeekBallTrajEntry4_2c (one copy per bank); a change here belongs in every copy.
	twin seek_ball_traj_entry4, 22 ; $403e SeekBallTrajEntry4_22
; Instruction-identical to SetBallVelocityFromEntry6_20, SetBallVelocityFromEntry6_21, SetBallVelocityFromEntry6_23, SetBallVelocityFromEntry6_24, SetBallVelocityFromEntry6_29, SetBallVelocityFromEntry6_2a, SetBallVelocityFromEntry6_2b and SetBallVelocityFromEntry6_2c (one copy per bank); a change here belongs in every copy.
	twin set_ball_velocity_from_entry6, 22 ; $405d SetBallVelocityFromEntry6_22
; Instruction-identical to SetBallVelocityFromEntry4_20, SetBallVelocityFromEntry4_21, SetBallVelocityFromEntry4_23, SetBallVelocityFromEntry4_24, SetBallVelocityFromEntry4_29, SetBallVelocityFromEntry4_2a, SetBallVelocityFromEntry4_2b and SetBallVelocityFromEntry4_2c (one copy per bank); a change here belongs in every copy.
	twin set_ball_velocity_from_entry4, 22 ; $4084 SetBallVelocityFromEntry4_22
; Instruction-identical to Unused_20_SetBallTargetByPrediction, Unused_21_SetBallTargetByPrediction, Unused_23_SetBallTargetByPrediction, Unused_24_SetBallTargetByPrediction, SetBallTargetByPrediction_29, SetBallTargetByPrediction_2a, SetBallTargetByPrediction_2b and Unused_2c_SetBallTargetByPrediction (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in set_ball_target_by_prediction, Unused_22_SetBallTargetByPrediction, 22 ; $4098 Unused_22_SetBallTargetByPrediction
; Instruction-identical to ApplyBallTrajectory6Capped_20, ApplyBallTrajectory6Capped_21, ApplyBallTrajectory6Capped_23, Unused_24_ApplyBallTrajectory6Capped, Unused_29_ApplyBallTrajectory6Capped, Unused_2a_ApplyBallTrajectory6Capped, Unused_2b_ApplyBallTrajectory6Capped and Unused_2c_ApplyBallTrajectory6Capped (one copy per bank); a change here belongs in every copy.
	twin_in apply_ball_trajectory6_capped, ApplyBallTrajectory6Capped_22, 22 ; $4102 ApplyBallTrajectory6Capped_22
; Instruction-identical to Unused_20_ApplyBallTrajectory6, Unused_21_ApplyBallTrajectory6, Unused_23_ApplyBallTrajectory6, Unused_24_ApplyBallTrajectory6, Unused_29_ApplyBallTrajectory6, Unused_2a_ApplyBallTrajectory6, Unused_2b_ApplyBallTrajectory6 and ApplyBallTrajectory6_2c (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory6, Unused_22_ApplyBallTrajectory6, 22 ; $4135 Unused_22_ApplyBallTrajectory6
; Instruction-identical to Unused_20_ApplyBallTrajectoryCapped, Unused_21_ApplyBallTrajectoryCapped, Unused_23_ApplyBallTrajectoryCapped, ApplyBallTrajectoryCapped_24, Unused_2a_ApplyBallTrajectoryCapped, Unused_2b_ApplyBallTrajectoryCapped and Unused_2c_ApplyBallTrajectoryCapped (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory_capped, Unused_22_ApplyBallTrajectoryCapped, 22 ; $415d Unused_22_ApplyBallTrajectoryCapped
; Instruction-identical to Unused_20_ApplyBallTrajectory4Capped, Unused_21_ApplyBallTrajectory4Capped, Unused_23_ApplyBallTrajectory4Capped, ApplyBallTrajectory4Capped_24, Unused_29_ApplyBallTrajectory4Capped, Unused_2a_ApplyBallTrajectory4Capped, Unused_2b_ApplyBallTrajectory4Capped and Unused_2c_ApplyBallTrajectory4Capped (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory4_capped, Unused_22_ApplyBallTrajectory4Capped, 22 ; $4196 Unused_22_ApplyBallTrajectory4Capped
; Instruction-identical to ApplyBallTrajectory4_20, ApplyBallTrajectory4_21, ApplyBallTrajectory4_23, ApplyBallTrajectory4_24, ApplyBallTrajectory4_29, ApplyBallTrajectory4_2a, ApplyBallTrajectory4_2b and ApplyBallTrajectory4_2c (one copy per bank); a change here belongs in every copy.
	twin apply_ball_trajectory4, 22 ; $41c9 ApplyBallTrajectory4_22
; Instruction-identical to SetBallTargetFromAim_20, SetBallTargetFromAim_21, SetBallTargetFromAim_23, SetBallTargetFromAim_24, SetBallTargetFromAim_29, SetBallTargetFromAim_2a, SetBallTargetFromAim_2b and SetBallTargetFromAim_2c (one copy per bank); a change here belongs in every copy.
	twin set_ball_target_from_aim, 22 ; $41f5 SetBallTargetFromAim_22
; Instruction-identical to Unused_20_LookupBallPosByAim, Unused_21_LookupBallPosByAim, Unused_23_LookupBallPosByAim, Unused_29_LookupBallPosByAim, Unused_2a_LookupBallPosByAim and Unused_2b_LookupBallPosByAim (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in lookup_ball_pos_by_aim, Unused_22_LookupBallPosByAim, 22 ; $4221 Unused_22_LookupBallPosByAim
; Instruction-identical to LookupBallPosByHeight_20, LookupBallPosByHeight_21, LookupBallPosByHeight_23, LookupBallPosByHeight_24, LookupBallPosByHeight_29, LookupBallPosByHeight_2a, LookupBallPosByHeight_2b and LookupBallPosByHeight_2c (one copy per bank); a change here belongs in every copy.
	twin lookup_ball_pos_by_height, 22 ; $424c LookupBallPosByHeight_22
; Instruction-identical to LookupBallPosByShotIndex_20, LookupBallPosByShotIndex_21, LookupBallPosByShotIndex_23, LookupBallPosByShotIndex_24, LookupBallPosByShotIndex_29, LookupBallPosByShotIndex_2a and LookupBallPosByShotIndex_2b (one copy per bank); a change here belongs in every copy.
	twin lookup_ball_pos_by_shot_index, 22 ; $426e LookupBallPosByShotIndex_22
BallPosData_22:
	INCLUDE "data/bank_022/BallPosData_22.asm" ; $427d, 15360 bytes (traj:6:64)
; Instruction-identical to ShotBallPathPowerTopspin (one copy per bank); a change here belongs in every copy.
	twin_in shot_ball_path_topspin, ShotBallPathTopspin, 22 ; $7e7d
BallPosHeightOffsets_22:
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
BallPosBlockOffsets_22:
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

	farptr ShotBallPathServeSlice ; $4000
; Instruction-identical to BallTrajEntryPtr6_20, BallTrajEntryPtr6_21, BallTrajEntryPtr6_22, BallTrajEntryPtr6_23, BallTrajEntryPtr6_24, BallTrajEntryPtr6_29, BallTrajEntryPtr6_2b and BallTrajEntryPtr6_2c (one copy per bank); a change here belongs in every copy.
	twin ball_traj_entry_ptr6, 2a ; $4002 BallTrajEntryPtr6_2a
; Instruction-identical to BallTrajEntryPtr4_20, BallTrajEntryPtr4_21, BallTrajEntryPtr4_22, BallTrajEntryPtr4_23, BallTrajEntryPtr4_24, BallTrajEntryPtr4_29, BallTrajEntryPtr4_2b and BallTrajEntryPtr4_2c (one copy per bank); a change here belongs in every copy.
	twin ball_traj_entry_ptr4, 2a ; $4012 BallTrajEntryPtr4_2a
; Instruction-identical to SeekBallTrajEntry6_20, SeekBallTrajEntry6_21, SeekBallTrajEntry6_22, SeekBallTrajEntry6_23, SeekBallTrajEntry6_24, SeekBallTrajEntry6_29, SeekBallTrajEntry6_2b and SeekBallTrajEntry6_2c (one copy per bank); a change here belongs in every copy.
	twin seek_ball_traj_entry6, 2a ; $401f SeekBallTrajEntry6_2a
; Instruction-identical to SeekBallTrajEntry4_20, SeekBallTrajEntry4_21, SeekBallTrajEntry4_22, SeekBallTrajEntry4_23, SeekBallTrajEntry4_24, SeekBallTrajEntry4_29, SeekBallTrajEntry4_2b and SeekBallTrajEntry4_2c (one copy per bank); a change here belongs in every copy.
	twin seek_ball_traj_entry4, 2a ; $403e SeekBallTrajEntry4_2a
; Instruction-identical to SetBallVelocityFromEntry6_20, SetBallVelocityFromEntry6_21, SetBallVelocityFromEntry6_22, SetBallVelocityFromEntry6_23, SetBallVelocityFromEntry6_24, SetBallVelocityFromEntry6_29, SetBallVelocityFromEntry6_2b and SetBallVelocityFromEntry6_2c (one copy per bank); a change here belongs in every copy.
	twin set_ball_velocity_from_entry6, 2a ; $405d SetBallVelocityFromEntry6_2a
; Instruction-identical to SetBallVelocityFromEntry4_20, SetBallVelocityFromEntry4_21, SetBallVelocityFromEntry4_22, SetBallVelocityFromEntry4_23, SetBallVelocityFromEntry4_24, SetBallVelocityFromEntry4_29, SetBallVelocityFromEntry4_2b and SetBallVelocityFromEntry4_2c (one copy per bank); a change here belongs in every copy.
	twin set_ball_velocity_from_entry4, 2a ; $4084 SetBallVelocityFromEntry4_2a
; Instruction-identical to Unused_20_SetBallTargetByPrediction, Unused_21_SetBallTargetByPrediction, Unused_22_SetBallTargetByPrediction, Unused_23_SetBallTargetByPrediction, Unused_24_SetBallTargetByPrediction, SetBallTargetByPrediction_29, SetBallTargetByPrediction_2b and Unused_2c_SetBallTargetByPrediction (one copy per bank); a change here belongs in every copy.
	twin_in set_ball_target_by_prediction, SetBallTargetByPrediction_2a, 2a ; $4098 SetBallTargetByPrediction_2a
; Instruction-identical to ApplyBallTrajectory6Capped_20, ApplyBallTrajectory6Capped_21, ApplyBallTrajectory6Capped_22, ApplyBallTrajectory6Capped_23, Unused_24_ApplyBallTrajectory6Capped, Unused_29_ApplyBallTrajectory6Capped, Unused_2b_ApplyBallTrajectory6Capped and Unused_2c_ApplyBallTrajectory6Capped (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory6_capped, Unused_2a_ApplyBallTrajectory6Capped, 2a ; $4102 Unused_2a_ApplyBallTrajectory6Capped
; Instruction-identical to Unused_20_ApplyBallTrajectory6, Unused_21_ApplyBallTrajectory6, Unused_22_ApplyBallTrajectory6, Unused_23_ApplyBallTrajectory6, Unused_24_ApplyBallTrajectory6, Unused_29_ApplyBallTrajectory6, Unused_2b_ApplyBallTrajectory6 and ApplyBallTrajectory6_2c (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory6, Unused_2a_ApplyBallTrajectory6, 2a ; $4135 Unused_2a_ApplyBallTrajectory6
; Instruction-identical to Unused_20_ApplyBallTrajectoryCapped, Unused_21_ApplyBallTrajectoryCapped, Unused_22_ApplyBallTrajectoryCapped, Unused_23_ApplyBallTrajectoryCapped, ApplyBallTrajectoryCapped_24, Unused_2b_ApplyBallTrajectoryCapped and Unused_2c_ApplyBallTrajectoryCapped (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory_capped, Unused_2a_ApplyBallTrajectoryCapped, 2a ; $415d Unused_2a_ApplyBallTrajectoryCapped
; Instruction-identical to Unused_20_ApplyBallTrajectory4Capped, Unused_21_ApplyBallTrajectory4Capped, Unused_22_ApplyBallTrajectory4Capped, Unused_23_ApplyBallTrajectory4Capped, ApplyBallTrajectory4Capped_24, Unused_29_ApplyBallTrajectory4Capped, Unused_2b_ApplyBallTrajectory4Capped and Unused_2c_ApplyBallTrajectory4Capped (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory4_capped, Unused_2a_ApplyBallTrajectory4Capped, 2a ; $4196 Unused_2a_ApplyBallTrajectory4Capped
; Instruction-identical to ApplyBallTrajectory4_20, ApplyBallTrajectory4_21, ApplyBallTrajectory4_22, ApplyBallTrajectory4_23, ApplyBallTrajectory4_24, ApplyBallTrajectory4_29, ApplyBallTrajectory4_2b and ApplyBallTrajectory4_2c (one copy per bank); a change here belongs in every copy.
	twin apply_ball_trajectory4, 2a ; $41c9 ApplyBallTrajectory4_2a
; Instruction-identical to SetBallTargetFromAim_20, SetBallTargetFromAim_21, SetBallTargetFromAim_22, SetBallTargetFromAim_23, SetBallTargetFromAim_24, SetBallTargetFromAim_29, SetBallTargetFromAim_2b and SetBallTargetFromAim_2c (one copy per bank); a change here belongs in every copy.
	twin set_ball_target_from_aim, 2a ; $41f5 SetBallTargetFromAim_2a
; Instruction-identical to Unused_20_LookupBallPosByAim, Unused_21_LookupBallPosByAim, Unused_22_LookupBallPosByAim, Unused_23_LookupBallPosByAim, Unused_29_LookupBallPosByAim and Unused_2b_LookupBallPosByAim (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in lookup_ball_pos_by_aim, Unused_2a_LookupBallPosByAim, 2a ; $4221 Unused_2a_LookupBallPosByAim
; Instruction-identical to LookupBallPosByHeight_20, LookupBallPosByHeight_21, LookupBallPosByHeight_22, LookupBallPosByHeight_23, LookupBallPosByHeight_24, LookupBallPosByHeight_29, LookupBallPosByHeight_2b and LookupBallPosByHeight_2c (one copy per bank); a change here belongs in every copy.
	twin lookup_ball_pos_by_height, 2a ; $424c LookupBallPosByHeight_2a
; Instruction-identical to LookupBallPosByShotIndex_20, LookupBallPosByShotIndex_21, LookupBallPosByShotIndex_22, LookupBallPosByShotIndex_23, LookupBallPosByShotIndex_24, LookupBallPosByShotIndex_29 and LookupBallPosByShotIndex_2b (one copy per bank); a change here belongs in every copy.
	twin lookup_ball_pos_by_shot_index, 2a ; $426e LookupBallPosByShotIndex_2a
BallPosData_2a:
	INCLUDE "data/bank_02a/BallPosData_2a.asm" ; $427d, 7200 bytes (traj:6)
ShotBallPathServeSlice:
	farcall ComputeShotPlacement ; $5e9d
	ld hl, BallPosData_2a ; $5ea0
	ld bc, BallPosBlockOffsets_2a ; $5ea3
	ld a, [wSlicePlacementIndex] ; $5ea6
	call LookupBallPosByShotIndex_2a ; $5ea9
	ld bc, BallPosSubOffsets_2a ; $5eac
	ld a, [wSmashServeSpeedIndex] ; $5eaf
	call LookupBallPosByShotIndex_2a ; $5eb2
	ld bc, BallPosHeightOffsets_2a ; $5eb5
	call LookupBallPosByHeight_2a ; $5eb8
	call SetBallTargetByPrediction_2a ; $5ebb
	ret ; $5ebe
BallPosBlockOffsets_2a:
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
BallPosSubOffsets_2a:
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
BallPosHeightOffsets_2a:
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

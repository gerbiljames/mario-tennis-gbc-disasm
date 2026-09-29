	farptr ShotBallPathServeFlat ; $4000
; Instruction-identical to BallTrajEntryPtr6_20, BallTrajEntryPtr6_21, BallTrajEntryPtr6_22, BallTrajEntryPtr6_23, BallTrajEntryPtr6_24, Unused_29_BallTrajEntryPtr6, Unused_2a_BallTrajEntryPtr6 and BallTrajEntryPtr6_2c (one copy per bank); a change here belongs in every copy.
	twin_in ball_traj_entry_ptr6, Unused_2b_BallTrajEntryPtr6, 2b ; $4002 Unused_2b_BallTrajEntryPtr6
; Instruction-identical to Unused_20_BallTrajEntryPtr4, Unused_21_BallTrajEntryPtr4, Unused_22_BallTrajEntryPtr4, Unused_23_BallTrajEntryPtr4, BallTrajEntryPtr4_24, Unused_29_BallTrajEntryPtr4, Unused_2a_BallTrajEntryPtr4 and BallTrajEntryPtr4_2c (one copy per bank); a change here belongs in every copy.
	twin_in ball_traj_entry_ptr4, Unused_2b_BallTrajEntryPtr4, 2b ; $4012 Unused_2b_BallTrajEntryPtr4
; Instruction-identical to SeekBallTrajEntry6_20, SeekBallTrajEntry6_21, SeekBallTrajEntry6_22, SeekBallTrajEntry6_23, Unused_24_SeekBallTrajEntry6, Unused_29_SeekBallTrajEntry6, Unused_2a_SeekBallTrajEntry6 and SeekBallTrajEntry6_2c (one copy per bank); a change here belongs in every copy.
	twin_in seek_ball_traj_entry6, Unused_2b_SeekBallTrajEntry6, 2b ; $401f Unused_2b_SeekBallTrajEntry6
; Instruction-identical to Unused_20_SeekBallTrajEntry4, Unused_21_SeekBallTrajEntry4, Unused_22_SeekBallTrajEntry4, Unused_23_SeekBallTrajEntry4, SeekBallTrajEntry4_24, Unused_29_SeekBallTrajEntry4, Unused_2a_SeekBallTrajEntry4 and SeekBallTrajEntry4_2c (one copy per bank); a change here belongs in every copy.
	twin_in seek_ball_traj_entry4, Unused_2b_SeekBallTrajEntry4, 2b ; $403e Unused_2b_SeekBallTrajEntry4
; Instruction-identical to SetBallVelocityFromEntry6_20, SetBallVelocityFromEntry6_21, SetBallVelocityFromEntry6_22, SetBallVelocityFromEntry6_23, SetBallVelocityFromEntry6_24, Unused_29_SetBallVelocityFromEntry6, Unused_2a_SetBallVelocityFromEntry6 and SetBallVelocityFromEntry6_2c (one copy per bank); a change here belongs in every copy.
	twin_in set_ball_velocity_from_entry6, Unused_2b_SetBallVelocityFromEntry6, 2b ; $405d Unused_2b_SetBallVelocityFromEntry6
; Instruction-identical to Unused_20_SetBallVelocityFromEntry4, Unused_21_SetBallVelocityFromEntry4, Unused_22_SetBallVelocityFromEntry4, Unused_23_SetBallVelocityFromEntry4, SetBallVelocityFromEntry4_24, Unused_29_SetBallVelocityFromEntry4, Unused_2a_SetBallVelocityFromEntry4 and SetBallVelocityFromEntry4_2c (one copy per bank); a change here belongs in every copy.
	twin_in set_ball_velocity_from_entry4, Unused_2b_SetBallVelocityFromEntry4, 2b ; $4084 Unused_2b_SetBallVelocityFromEntry4
; Instruction-identical to Unused_20_SetBallTargetByPrediction, Unused_21_SetBallTargetByPrediction, Unused_22_SetBallTargetByPrediction, Unused_23_SetBallTargetByPrediction, Unused_24_SetBallTargetByPrediction, SetBallTargetByPrediction_29, SetBallTargetByPrediction_2a and Unused_2c_SetBallTargetByPrediction (one copy per bank); a change here belongs in every copy.
	twin_in set_ball_target_by_prediction, SetBallTargetByPrediction_2b, 2b ; $4098 SetBallTargetByPrediction_2b
; Instruction-identical to ApplyBallTrajectory6Capped_20, ApplyBallTrajectory6Capped_21, ApplyBallTrajectory6Capped_22, ApplyBallTrajectory6Capped_23, Unused_24_ApplyBallTrajectory6Capped, Unused_29_ApplyBallTrajectory6Capped, Unused_2a_ApplyBallTrajectory6Capped and Unused_2c_ApplyBallTrajectory6Capped (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory6_capped, Unused_2b_ApplyBallTrajectory6Capped, 2b ; $4102 Unused_2b_ApplyBallTrajectory6Capped
; Instruction-identical to Unused_20_ApplyBallTrajectory6, Unused_21_ApplyBallTrajectory6, Unused_22_ApplyBallTrajectory6, Unused_23_ApplyBallTrajectory6, Unused_24_ApplyBallTrajectory6, Unused_29_ApplyBallTrajectory6, Unused_2a_ApplyBallTrajectory6 and ApplyBallTrajectory6_2c (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory6, Unused_2b_ApplyBallTrajectory6, 2b ; $4135 Unused_2b_ApplyBallTrajectory6
; Instruction-identical to Unused_20_ApplyBallTrajectoryCapped, Unused_21_ApplyBallTrajectoryCapped, Unused_22_ApplyBallTrajectoryCapped, Unused_23_ApplyBallTrajectoryCapped, ApplyBallTrajectoryCapped_24, Unused_2a_ApplyBallTrajectoryCapped and Unused_2c_ApplyBallTrajectoryCapped (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory_capped, Unused_2b_ApplyBallTrajectoryCapped, 2b ; $415d Unused_2b_ApplyBallTrajectoryCapped
; Instruction-identical to Unused_20_ApplyBallTrajectory4Capped, Unused_21_ApplyBallTrajectory4Capped, Unused_22_ApplyBallTrajectory4Capped, Unused_23_ApplyBallTrajectory4Capped, ApplyBallTrajectory4Capped_24, Unused_29_ApplyBallTrajectory4Capped, Unused_2a_ApplyBallTrajectory4Capped and Unused_2c_ApplyBallTrajectory4Capped (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in apply_ball_trajectory4_capped, Unused_2b_ApplyBallTrajectory4Capped, 2b ; $4196 Unused_2b_ApplyBallTrajectory4Capped
; Instruction-identical to Unused_20_ApplyBallTrajectory4, Unused_21_ApplyBallTrajectory4, Unused_22_ApplyBallTrajectory4, Unused_23_ApplyBallTrajectory4, Unused_24_ApplyBallTrajectory4, Unused_29_ApplyBallTrajectory4, Unused_2a_ApplyBallTrajectory4 and ApplyBallTrajectory4_2c (one copy per bank); a change here belongs in every copy.
	twin_in apply_ball_trajectory4, Unused_2b_ApplyBallTrajectory4, 2b ; $41c9 Unused_2b_ApplyBallTrajectory4
; Instruction-identical to SetBallTargetFromAim_20, SetBallTargetFromAim_21, SetBallTargetFromAim_22, SetBallTargetFromAim_23, SetBallTargetFromAim_24, Unused_29_SetBallTargetFromAim, Unused_2a_SetBallTargetFromAim and SetBallTargetFromAim_2c (one copy per bank); a change here belongs in every copy.
	twin_in set_ball_target_from_aim, Unused_2b_SetBallTargetFromAim, 2b ; $41f5 Unused_2b_SetBallTargetFromAim
; Instruction-identical to Unused_20_LookupBallPosByAim, Unused_21_LookupBallPosByAim, Unused_22_LookupBallPosByAim, Unused_23_LookupBallPosByAim, Unused_29_LookupBallPosByAim and Unused_2a_LookupBallPosByAim (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in lookup_ball_pos_by_aim, Unused_2b_LookupBallPosByAim, 2b ; $4221 Unused_2b_LookupBallPosByAim
; Instruction-identical to LookupBallPosByHeight_20, LookupBallPosByHeight_21, LookupBallPosByHeight_22, LookupBallPosByHeight_23, LookupBallPosByHeight_24, LookupBallPosByHeight_29, LookupBallPosByHeight_2a and LookupBallPosByHeight_2c (one copy per bank); a change here belongs in every copy.
	twin lookup_ball_pos_by_height, 2b ; $424c LookupBallPosByHeight_2b
; Instruction-identical to LookupBallPosByShotIndex_20, LookupBallPosByShotIndex_21, LookupBallPosByShotIndex_22, LookupBallPosByShotIndex_23, LookupBallPosByShotIndex_24, LookupBallPosByShotIndex_29 and LookupBallPosByShotIndex_2a (one copy per bank); a change here belongs in every copy.
	twin lookup_ball_pos_by_shot_index, 2b ; $426e LookupBallPosByShotIndex_2b
BallPosData_2b:
	INCLUDE "data/bank_02b/BallPosData_2b.asm" ; $427d, 7200 bytes (traj:6)
ShotBallPathServeFlat:
	farcall ComputeShotPlacement ; $5e9d
	ld hl, BallPosData_2b ; $5ea0
	ld bc, BallPosBlockOffsets_2b ; $5ea3
	xor a ; $5ea6
	call LookupBallPosByShotIndex_2b ; $5ea7
	ld bc, BallPosSubOffsets_2b ; $5eaa
	ld a, [wSmashServeSpeedIndex] ; $5ead
	call LookupBallPosByShotIndex_2b ; $5eb0
	ld bc, BallPosHeightOffsets_2b ; $5eb3
	call LookupBallPosByHeight_2b ; $5eb6
	call SetBallTargetByPrediction_2b ; $5eb9
	ret ; $5ebc
BallPosBlockOffsets_2b:
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
BallPosSubOffsets_2b:
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
BallPosHeightOffsets_2b:
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

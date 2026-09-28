	farptr ShotBallPathServeFlat ; $4000
; Instruction-identical to BallTrajEntryPtr6_20, BallTrajEntryPtr6_21, BallTrajEntryPtr6_22, BallTrajEntryPtr6_23, BallTrajEntryPtr6_24, BallTrajEntryPtr6_29, BallTrajEntryPtr6_2a and BallTrajEntryPtr6_2c (one copy per bank); a change here belongs in every copy.
	twin ball_traj_entry_ptr6, 2b ; $4002 BallTrajEntryPtr6_2b
; Instruction-identical to BallTrajEntryPtr4_20, BallTrajEntryPtr4_21, BallTrajEntryPtr4_22, BallTrajEntryPtr4_23, BallTrajEntryPtr4_24, BallTrajEntryPtr4_29, BallTrajEntryPtr4_2a and BallTrajEntryPtr4_2c (one copy per bank); a change here belongs in every copy.
	twin ball_traj_entry_ptr4, 2b ; $4012 BallTrajEntryPtr4_2b
; Instruction-identical to SeekBallTrajEntry6_20, SeekBallTrajEntry6_21, SeekBallTrajEntry6_22, SeekBallTrajEntry6_23, SeekBallTrajEntry6_24, SeekBallTrajEntry6_29, SeekBallTrajEntry6_2a and SeekBallTrajEntry6_2c (one copy per bank); a change here belongs in every copy.
	twin seek_ball_traj_entry6, 2b ; $401f SeekBallTrajEntry6_2b
; Instruction-identical to SeekBallTrajEntry4_20, SeekBallTrajEntry4_21, SeekBallTrajEntry4_22, SeekBallTrajEntry4_23, SeekBallTrajEntry4_24, SeekBallTrajEntry4_29, SeekBallTrajEntry4_2a and SeekBallTrajEntry4_2c (one copy per bank); a change here belongs in every copy.
	twin seek_ball_traj_entry4, 2b ; $403e SeekBallTrajEntry4_2b
; Instruction-identical to SetBallVelocityFromEntry6_20, SetBallVelocityFromEntry6_21, SetBallVelocityFromEntry6_22, SetBallVelocityFromEntry6_23, SetBallVelocityFromEntry6_24, SetBallVelocityFromEntry6_29, SetBallVelocityFromEntry6_2a and SetBallVelocityFromEntry6_2c (one copy per bank); a change here belongs in every copy.
	twin set_ball_velocity_from_entry6, 2b ; $405d SetBallVelocityFromEntry6_2b
; Instruction-identical to SetBallVelocityFromEntry4_20, SetBallVelocityFromEntry4_21, SetBallVelocityFromEntry4_22, SetBallVelocityFromEntry4_23, SetBallVelocityFromEntry4_24, SetBallVelocityFromEntry4_29, SetBallVelocityFromEntry4_2a and SetBallVelocityFromEntry4_2c (one copy per bank); a change here belongs in every copy.
	twin set_ball_velocity_from_entry4, 2b ; $4084 SetBallVelocityFromEntry4_2b
; Instruction-identical to SetBallTargetByPrediction_20, SetBallTargetByPrediction_21, SetBallTargetByPrediction_22, SetBallTargetByPrediction_23, SetBallTargetByPrediction_24, SetBallTargetByPrediction_29, SetBallTargetByPrediction_2a and SetBallTargetByPrediction_2c (one copy per bank); a change here belongs in every copy.
	twin set_ball_target_by_prediction, 2b ; $4098 SetBallTargetByPrediction_2b
; Instruction-identical to ApplyBallTrajectory6Capped_20, ApplyBallTrajectory6Capped_21, ApplyBallTrajectory6Capped_22, ApplyBallTrajectory6Capped_23, ApplyBallTrajectory6Capped_24, ApplyBallTrajectory6Capped_29, ApplyBallTrajectory6Capped_2a and ApplyBallTrajectory6Capped_2c (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin apply_ball_trajectory6_capped, 2b ; $4102 ApplyBallTrajectory6Capped_2b
; Instruction-identical to ApplyBallTrajectory6_20, ApplyBallTrajectory6_21, ApplyBallTrajectory6_22, ApplyBallTrajectory6_23, ApplyBallTrajectory6_24, ApplyBallTrajectory6_29, ApplyBallTrajectory6_2a and ApplyBallTrajectory6_2c (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin apply_ball_trajectory6, 2b ; $4135 ApplyBallTrajectory6_2b
; Instruction-identical to ApplyBallTrajectoryCapped_20, ApplyBallTrajectoryCapped_21, ApplyBallTrajectoryCapped_22, ApplyBallTrajectoryCapped_23, ApplyBallTrajectoryCapped_24, ApplyBallTrajectoryCapped_2a and ApplyBallTrajectoryCapped_2c (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin apply_ball_trajectory_capped, 2b ; $415d ApplyBallTrajectoryCapped_2b
; Instruction-identical to ApplyBallTrajectory4Capped_20, ApplyBallTrajectory4Capped_21, ApplyBallTrajectory4Capped_22, ApplyBallTrajectory4Capped_23, ApplyBallTrajectory4Capped_24, ApplyBallTrajectory4Capped_29, ApplyBallTrajectory4Capped_2a and ApplyBallTrajectory4Capped_2c (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin apply_ball_trajectory4_capped, 2b ; $4196 ApplyBallTrajectory4Capped_2b
; Instruction-identical to ApplyBallTrajectory4_20, ApplyBallTrajectory4_21, ApplyBallTrajectory4_22, ApplyBallTrajectory4_23, ApplyBallTrajectory4_24, ApplyBallTrajectory4_29, ApplyBallTrajectory4_2a and ApplyBallTrajectory4_2c (one copy per bank); a change here belongs in every copy.
	twin apply_ball_trajectory4, 2b ; $41c9 ApplyBallTrajectory4_2b
; Instruction-identical to SetBallTargetFromAim_20, SetBallTargetFromAim_21, SetBallTargetFromAim_22, SetBallTargetFromAim_23, SetBallTargetFromAim_24, SetBallTargetFromAim_29, SetBallTargetFromAim_2a and SetBallTargetFromAim_2c (one copy per bank); a change here belongs in every copy.
	twin set_ball_target_from_aim, 2b ; $41f5 SetBallTargetFromAim_2b
; Instruction-identical to LookupBallPosByAim_20, LookupBallPosByAim_21, LookupBallPosByAim_22, LookupBallPosByAim_23, LookupBallPosByAim_29 and LookupBallPosByAim_2a (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin lookup_ball_pos_by_aim, 2b ; $4221 LookupBallPosByAim_2b
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

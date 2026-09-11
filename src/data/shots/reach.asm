	farptr ProjectShotPlacement0 ; $4000
	farptr ProjectShotPlacement1 ; $4002
	farptr ProjectShotPlacement2 ; $4004
; Instruction-identical to BallTrajEntryPtr6_20, BallTrajEntryPtr6_21, BallTrajEntryPtr6_22, BallTrajEntryPtr6_23, BallTrajEntryPtr6_24, BallTrajEntryPtr6_29, BallTrajEntryPtr6_2a and BallTrajEntryPtr6_2b (one copy per bank); a change here belongs in every copy.
	twin ball_traj_entry_ptr6, 2c ; $4006 BallTrajEntryPtr6_2c
; Instruction-identical to BallTrajEntryPtr4_20, BallTrajEntryPtr4_21, BallTrajEntryPtr4_22, BallTrajEntryPtr4_23, BallTrajEntryPtr4_24, BallTrajEntryPtr4_29, BallTrajEntryPtr4_2a and BallTrajEntryPtr4_2b (one copy per bank); a change here belongs in every copy.
	twin ball_traj_entry_ptr4, 2c ; $4016 BallTrajEntryPtr4_2c
; Instruction-identical to SeekBallTrajEntry6_20, SeekBallTrajEntry6_21, SeekBallTrajEntry6_22, SeekBallTrajEntry6_23, SeekBallTrajEntry6_24, SeekBallTrajEntry6_29, SeekBallTrajEntry6_2a and SeekBallTrajEntry6_2b (one copy per bank); a change here belongs in every copy.
	twin seek_ball_traj_entry6, 2c ; $4023 SeekBallTrajEntry6_2c
; Instruction-identical to SeekBallTrajEntry4_20, SeekBallTrajEntry4_21, SeekBallTrajEntry4_22, SeekBallTrajEntry4_23, SeekBallTrajEntry4_24, SeekBallTrajEntry4_29, SeekBallTrajEntry4_2a and SeekBallTrajEntry4_2b (one copy per bank); a change here belongs in every copy.
	twin seek_ball_traj_entry4, 2c ; $4042 SeekBallTrajEntry4_2c
; Instruction-identical to SetBallVelocityFromEntry6_20, SetBallVelocityFromEntry6_21, SetBallVelocityFromEntry6_22, SetBallVelocityFromEntry6_23, SetBallVelocityFromEntry6_24, SetBallVelocityFromEntry6_29, SetBallVelocityFromEntry6_2a and SetBallVelocityFromEntry6_2b (one copy per bank); a change here belongs in every copy.
	twin set_ball_velocity_from_entry6, 2c ; $4061 SetBallVelocityFromEntry6_2c
; Instruction-identical to SetBallVelocityFromEntry4_20, SetBallVelocityFromEntry4_21, SetBallVelocityFromEntry4_22, SetBallVelocityFromEntry4_23, SetBallVelocityFromEntry4_24, SetBallVelocityFromEntry4_29, SetBallVelocityFromEntry4_2a and SetBallVelocityFromEntry4_2b (one copy per bank); a change here belongs in every copy.
	twin set_ball_velocity_from_entry4, 2c ; $4088 SetBallVelocityFromEntry4_2c
; Instruction-identical to SetBallTargetByPrediction_20, SetBallTargetByPrediction_21, SetBallTargetByPrediction_22, SetBallTargetByPrediction_23, SetBallTargetByPrediction_24, SetBallTargetByPrediction_29, SetBallTargetByPrediction_2a and SetBallTargetByPrediction_2b (one copy per bank); a change here belongs in every copy.
	twin set_ball_target_by_prediction, 2c ; $409c SetBallTargetByPrediction_2c
; Instruction-identical to ApplyBallTrajectory6Capped_20, ApplyBallTrajectory6Capped_21, ApplyBallTrajectory6Capped_22, ApplyBallTrajectory6Capped_23, ApplyBallTrajectory6Capped_24, ApplyBallTrajectory6Capped_29, ApplyBallTrajectory6Capped_2a and ApplyBallTrajectory6Capped_2b (one copy per bank); a change here belongs in every copy.
	twin apply_ball_trajectory6_capped, 2c ; $4106 ApplyBallTrajectory6Capped_2c
; Instruction-identical to ApplyBallTrajectory6_20, ApplyBallTrajectory6_21, ApplyBallTrajectory6_22, ApplyBallTrajectory6_23, ApplyBallTrajectory6_24, ApplyBallTrajectory6_29, ApplyBallTrajectory6_2a and ApplyBallTrajectory6_2b (one copy per bank); a change here belongs in every copy.
	twin apply_ball_trajectory6, 2c ; $4139 ApplyBallTrajectory6_2c
; Instruction-identical to ApplyBallTrajectoryCapped_20, ApplyBallTrajectoryCapped_21, ApplyBallTrajectoryCapped_22, ApplyBallTrajectoryCapped_23, ApplyBallTrajectoryCapped_24, ApplyBallTrajectoryCapped_2a and ApplyBallTrajectoryCapped_2b (one copy per bank); a change here belongs in every copy.
	twin apply_ball_trajectory_capped, 2c ; $4161 ApplyBallTrajectoryCapped_2c
; Instruction-identical to ApplyBallTrajectory4Capped_20, ApplyBallTrajectory4Capped_21, ApplyBallTrajectory4Capped_22, ApplyBallTrajectory4Capped_23, ApplyBallTrajectory4Capped_24, ApplyBallTrajectory4Capped_29, ApplyBallTrajectory4Capped_2a and ApplyBallTrajectory4Capped_2b (one copy per bank); a change here belongs in every copy.
	twin apply_ball_trajectory4_capped, 2c ; $419a ApplyBallTrajectory4Capped_2c
; Instruction-identical to ApplyBallTrajectory4_20, ApplyBallTrajectory4_21, ApplyBallTrajectory4_22, ApplyBallTrajectory4_23, ApplyBallTrajectory4_24, ApplyBallTrajectory4_29, ApplyBallTrajectory4_2a and ApplyBallTrajectory4_2b (one copy per bank); a change here belongs in every copy.
	twin apply_ball_trajectory4, 2c ; $41cd ApplyBallTrajectory4_2c
; Instruction-identical to SetBallTargetFromAim_20, SetBallTargetFromAim_21, SetBallTargetFromAim_22, SetBallTargetFromAim_23, SetBallTargetFromAim_24, SetBallTargetFromAim_29, SetBallTargetFromAim_2a and SetBallTargetFromAim_2b (one copy per bank); a change here belongs in every copy.
	twin set_ball_target_from_aim, 2c ; $41f9 SetBallTargetFromAim_2c
; Instruction-identical to LookupBallPosByAim_24 (one copy per bank); a change here belongs in every copy.
	twin lookup_ball_pos_by_aim_24, 2c ; $4225 LookupBallPosByAim_2c
; Instruction-identical to LookupBallPosByHeight_20, LookupBallPosByHeight_21, LookupBallPosByHeight_22, LookupBallPosByHeight_23, LookupBallPosByHeight_24, LookupBallPosByHeight_29, LookupBallPosByHeight_2a and LookupBallPosByHeight_2b (one copy per bank); a change here belongs in every copy.
	twin lookup_ball_pos_by_height, 2c ; $4250 LookupBallPosByHeight_2c
LookupBallPosByShotIndex_2c:
	ld e, l ; $4272
	ld d, h ; $4273
	add a ; $4274
	ld l, c ; $4275
	ld h, b ; $4276
	add l ; $4277
	ld l, a ; $4278
	jr nc, .readB ; $4279
	inc h ; $427b
.readB:
	ld a, [hl+] ; $427c
	ld h, [hl] ; $427d
	ld l, a ; $427e
	add hl, de ; $427f
	ret ; $4280
ShotPlacementData0_2c:
	INCBIN "data/bank_02c/ShotPlacementData0_2c.bin" ; $4281, 3072 bytes
ShotPlacementData1_2c:
	INCBIN "data/bank_02c/ShotPlacementData1_2c.bin" ; $4e81, 4608 bytes
ShotPlacementData2_2c:
	INCBIN "data/bank_02c/ShotPlacementData2_2c.bin" ; $6081, 4608 bytes
ProjectShotPlacement0:
	farcall ComputeShotPlacement ; $7281
	push bc ; $7284
	ld hl, ShotPlacementData0_2c ; $7285
	ld bc, ShotPlacementOffsets0_2c ; $7288
	call LookupBallPosByHeight_2c ; $728b
	pop bc ; $728e
	call ApplyBallTrajectory4_2c ; $728f
	ret ; $7292
ShotPlacementOffsets0_2c:
	; $7293, 64 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0000 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0100 ; record 7
	dw $0200 ; record 8
	dw $0300 ; record 9
	dw $0400 ; record 10
	dw $0500 ; record 11
	dw $0600 ; record 12
	dw $0700 ; record 13
	dw $0800 ; record 14
	dw $0900 ; record 15
	dw $0a00 ; record 16
	dw $0b00 ; record 17
	dw $0b00 ; record 18
	dw $0b00 ; record 19
	dw $0b00 ; record 20
	dw $0b00 ; record 21
	dw $0b00 ; record 22
	dw $0b00 ; record 23
	dw $0b00 ; record 24
	dw $0b00 ; record 25
	dw $0b00 ; record 26
	dw $0b00 ; record 27
	dw $0b00 ; record 28
	dw $0b00 ; record 29
	dw $0b00 ; record 30
	dw $0b00 ; record 31
ProjectShotPlacement1:
	farcall ComputeShotPlacement ; $72d3
	push bc ; $72d6
	ld hl, ShotPlacementData1_2c ; $72d7
	ld bc, ShotPlacementOffsets1_2c ; $72da
	call LookupBallPosByHeight_2c ; $72dd
	pop bc ; $72e0
	call ApplyBallTrajectory6_2c ; $72e1
	ret ; $72e4
ShotPlacementOffsets1_2c:
	; $72e5, 64 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0000 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0180 ; record 7
	dw $0300 ; record 8
	dw $0480 ; record 9
	dw $0600 ; record 10
	dw $0780 ; record 11
	dw $0900 ; record 12
	dw $0a80 ; record 13
	dw $0c00 ; record 14
	dw $0d80 ; record 15
	dw $0f00 ; record 16
	dw $1080 ; record 17
	dw $1080 ; record 18
	dw $1080 ; record 19
	dw $1080 ; record 20
	dw $1080 ; record 21
	dw $1080 ; record 22
	dw $1080 ; record 23
	dw $1080 ; record 24
	dw $1080 ; record 25
	dw $1080 ; record 26
	dw $1080 ; record 27
	dw $1080 ; record 28
	dw $1080 ; record 29
	dw $1080 ; record 30
	dw $1080 ; record 31
ProjectShotPlacement2:
	farcall ComputeShotPlacement ; $7325
	push bc ; $7328
	ld hl, ShotPlacementData2_2c ; $7329
	ld bc, ShotPlacementOffsets2_2c ; $732c
	call LookupBallPosByHeight_2c ; $732f
	pop bc ; $7332
	call ApplyBallTrajectory6_2c ; $7333
	ret ; $7336
ShotPlacementOffsets2_2c:
	; $7337, 64 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0000 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0180 ; record 7
	dw $0300 ; record 8
	dw $0480 ; record 9
	dw $0600 ; record 10
	dw $0780 ; record 11
	dw $0900 ; record 12
	dw $0a80 ; record 13
	dw $0c00 ; record 14
	dw $0d80 ; record 15
	dw $0f00 ; record 16
	dw $1080 ; record 17
	dw $1080 ; record 18
	dw $1080 ; record 19
	dw $1080 ; record 20
	dw $1080 ; record 21
	dw $1080 ; record 22
	dw $1080 ; record 23
	dw $1080 ; record 24
	dw $1080 ; record 25
	dw $1080 ; record 26
	dw $1080 ; record 27
	dw $1080 ; record 28
	dw $1080 ; record 29
	dw $1080 ; record 30
	dw $1080 ; record 31
	; $7377, 3209 bytes fill to bank end (linker-padded)

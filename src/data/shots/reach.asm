	farptr ProjectShotPlacement0 ; $4000
	farptr ProjectShotPlacement1 ; $4002
	farptr ProjectShotPlacement2 ; $4004
	twin_in ball_traj_entry_ptr6, BallTrajEntryPtr6_2c, 2c ; $4006 BallTrajEntryPtr6_2c
	twin_in ball_traj_entry_ptr4, BallTrajEntryPtr4_2c, 2c ; $4016 BallTrajEntryPtr4_2c
	twin_in seek_ball_traj_entry6, SeekBallTrajEntry6_2c, 2c ; $4023 SeekBallTrajEntry6_2c
	twin_in seek_ball_traj_entry4, SeekBallTrajEntry4_2c, 2c ; $4042 SeekBallTrajEntry4_2c
	twin_in set_ball_velocity_from_entry6, SetBallVelocityFromEntry6_2c, 2c ; $4061 SetBallVelocityFromEntry6_2c
	twin_in set_ball_velocity_from_entry4, SetBallVelocityFromEntry4_2c, 2c ; $4088 SetBallVelocityFromEntry4_2c
	twin_in set_ball_target_by_prediction, Unused_2c_SetBallTargetByPrediction, 2c ; $409c Unused_2c_SetBallTargetByPrediction
	twin_in apply_ball_trajectory6_capped, Unused_2c_ApplyBallTrajectory6Capped, 2c ; $4106 Unused_2c_ApplyBallTrajectory6Capped
	twin_in apply_ball_trajectory6, ApplyBallTrajectory6_2c, 2c ; $4139 ApplyBallTrajectory6_2c
	twin_in apply_ball_trajectory_capped, Unused_2c_ApplyBallTrajectoryCapped, 2c ; $4161 Unused_2c_ApplyBallTrajectoryCapped
	twin_in apply_ball_trajectory4_capped, Unused_2c_ApplyBallTrajectory4Capped, 2c ; $419a Unused_2c_ApplyBallTrajectory4Capped
	twin_in apply_ball_trajectory4, ApplyBallTrajectory4_2c, 2c ; $41cd ApplyBallTrajectory4_2c
	twin_in set_ball_target_from_aim, SetBallTargetFromAim_2c, 2c ; $41f9 SetBallTargetFromAim_2c
	twin_in lookup_ball_pos_by_aim_24, Unused_2c_LookupBallPosByAim, 2c ; $4225 Unused_2c_LookupBallPosByAim
	twin lookup_ball_pos_by_height, 2c ; $4250 LookupBallPosByHeight_2c
Unused_2c_LookupBallPosByShotIndex:
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
	INCLUDE "data/shots/ShotPlacementData0_2c.asm" ; $4281, 3072 bytes (traj:4)
ShotPlacementData1_2c:
	INCLUDE "data/shots/ShotPlacementData1_2c.asm" ; $4e81, 4608 bytes (traj:6)
ShotPlacementData2_2c:
	INCLUDE "data/shots/ShotPlacementData2_2c.asm" ; $6081, 4608 bytes (traj:6)
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

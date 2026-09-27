SetupGymActorsForProgress:
	ld a, [wMapSceneStage] ; $4681
	sra a ; $4684
	cp STORYTIER_JUNIOR_CHAMP ; $4686
	jr z, .stage1 ; $4688
	cp STORYTIER_ISLAND_OPEN ; $468a
	jr z, .stage2 ; $468c
	cp STORYTIER_COMPLETE ; $468e
	jr z, .done ; $4690
	ret ; $4692
.stage1:
	script_set_objdef OBJ_WALK_71_07, ACTOR_TRAINING_GYM_WEIGHTLIFTER_B ; $4693
	script_set_anim ACTOR_TRAINING_GYM_WEIGHTLIFTER_A, ANIM_WALK ; $469f
	script_set_position ACTOR_TRAINING_GYM_WEIGHTLIFTER_B, $2700, $0f00 ; $46a6
	script_face ACTOR_TRAINING_GYM_WEIGHTLIFTER_B, FACE_RIGHT ; $46b1
	ret ; $46b8
.stage2:
	script_set_position ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1, $2900, $0700 ; $46b9
	script_set_position ACTOR_TRAINING_GYM_JUMPING_JACKS_A, $2700, $0500 ; $46c4
	script_set_position ACTOR_TRAINING_GYM_JUMPING_JACKS_B_2, $2500, $0700 ; $46cf
	script_get_actor_state ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1 ; $46da
	ld a, $01 ; $46df
	ld e, l ; $46e1
	ld d, h ; $46e2
	ld hl, $0018 ; $46e3
	add hl, de ; $46e6
	ld [hl], a ; $46e7
	ret ; $46e8
.done:
	script_set_position ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1, $2900, $0700 ; $46e9
	script_set_position ACTOR_TRAINING_GYM_JUMPING_JACKS_A, $2700, $0500 ; $46f4
	script_set_position ACTOR_TRAINING_GYM_JUMPING_JACKS_B_2, $2500, $0700 ; $46ff
	script_set_anim ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1, ANIM_BOUNCE ; $470a
	ret ; $4711
ActorScript_0e_00:
	; $4712, 439 bytes (actor_script)
	as_set_target $2100, $0d00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0e00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_flag $01, $05, $02
	as_set_target $2100, $0f00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1000
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1100
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1200
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1300
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1400
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1500
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1600
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2200, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2300, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2400, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2500, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2600, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2700, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2800, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2900, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2a00, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2b00, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2c00, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1700
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1600
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1500
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1400
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1300
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1200
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1100
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1000
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0f00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0e00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0d00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0c00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2c00, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2b00, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2a00, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2900, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2800, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2700, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2600, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2500, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2400, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2300, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2200, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0b00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0c00
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_jump ActorScript_0e_00
ActorScript_0e_01:
	; $48c9, 439 bytes (actor_script)
	as_set_target $2b00, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2a00, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_flag $01, $05, $02
	as_set_target $2900, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2800, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2700, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2600, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2500, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2400, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2300, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2200, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0c00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0d00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0e00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0f00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1000
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1100
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1200
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1300
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1400
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1500
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1600
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2200, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2300, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2400, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2500, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2600, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2700, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2800, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2900, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2a00, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2b00, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2c00, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1700
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1600
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1500
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1400
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1300
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1200
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1100
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1000
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0f00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0e00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0d00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0c00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target $2c00, $0b00
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_jump ActorScript_0e_01
ActorScript_0e_02:
	; $4a80, 439 bytes (actor_script)
	as_set_target $2d60, $1600
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1500
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_flag $01, $05, $02
	as_set_target $2d60, $1400
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1300
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1200
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1100
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1000
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0f00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0e00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0d00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0c00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2c00, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2b00, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2a00, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2900, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2800, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2700, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2600, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2500, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2400, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2300, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2200, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0b00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0c00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0d00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0e00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $0f00
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1000
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1100
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1200
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1300
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1400
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1500
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1600
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2100, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2200, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2300, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2400, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2500, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2600, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2700, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2800, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2900, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2a00, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2b00, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2c00, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target $2d60, $1700
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_jump ActorScript_0e_02

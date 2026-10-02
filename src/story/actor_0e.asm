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
	script_set_position ACTOR_TRAINING_GYM_WEIGHTLIFTER_B, 39.0, 15.0 ; $46a6
	script_face ACTOR_TRAINING_GYM_WEIGHTLIFTER_B, FACE_RIGHT ; $46b1
	ret ; $46b8
.stage2:
	script_set_position ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1, 41.0, 7.0 ; $46b9
	script_set_position ACTOR_TRAINING_GYM_JUMPING_JACKS_A, 39.0, 5.0 ; $46c4
	script_set_position ACTOR_TRAINING_GYM_JUMPING_JACKS_B_2, 37.0, 7.0 ; $46cf
	script_get_actor_state ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1 ; $46da
	ld a, $01 ; $46df
	ld e, l ; $46e1
	ld d, h ; $46e2
	ld hl, $0018 ; $46e3
	add hl, de ; $46e6
	ld [hl], a ; $46e7
	ret ; $46e8
.done:
	script_set_position ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1, 41.0, 7.0 ; $46e9
	script_set_position ACTOR_TRAINING_GYM_JUMPING_JACKS_A, 39.0, 5.0 ; $46f4
	script_set_position ACTOR_TRAINING_GYM_JUMPING_JACKS_B_2, 37.0, 7.0 ; $46ff
	script_set_anim ACTOR_TRAINING_GYM_JUMPING_JACKS_B_1, ANIM_BOUNCE ; $470a
	ret ; $4711
ActorScript_0e_00:
	; $4712, 439 bytes (actor_script)
	as_set_target 33.0, 13.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 14.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_flag $01, $05, $02
	as_set_target 33.0, 15.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 16.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 17.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 18.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 19.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 20.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 21.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 22.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 34.0, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 35.0, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 36.0, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 37.0, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 38.0, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 39.0, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 40.0, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 41.0, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 42.0, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 43.0, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 44.0, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 23.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 22.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 21.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 20.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 19.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 18.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 17.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 16.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 15.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 14.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 13.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 12.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 44.0, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 43.0, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 42.0, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 41.0, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 40.0, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 39.0, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 38.0, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 37.0, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 36.0, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 35.0, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 34.0, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 11.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 12.0
	as_call TrainingGymRunner0AWaitWaypointClear
	as_wait_move
	as_jump ActorScript_0e_00
ActorScript_0e_01:
	; $48c9, 439 bytes (actor_script)
	as_set_target 43.0, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 42.0, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_flag $01, $05, $02
	as_set_target 41.0, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 40.0, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 39.0, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 38.0, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 37.0, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 36.0, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 35.0, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 34.0, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 12.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 13.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 14.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 15.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 16.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 17.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 18.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 19.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 20.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 21.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 22.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 34.0, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 35.0, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 36.0, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 37.0, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 38.0, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 39.0, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 40.0, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 41.0, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 42.0, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 43.0, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 44.0, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 23.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 22.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 21.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 20.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 19.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 18.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 17.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 16.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 15.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 14.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 13.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 12.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_set_target 44.0, 11.0
	as_call TrainingGymRunner0BWaitWaypointClear
	as_wait_move
	as_jump ActorScript_0e_01
ActorScript_0e_02:
	; $4a80, 439 bytes (actor_script)
	as_set_target 45.375, 22.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 21.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_flag $01, $05, $02
	as_set_target 45.375, 20.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 19.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 18.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 17.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 16.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 15.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 14.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 13.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 12.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 44.0, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 43.0, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 42.0, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 41.0, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 40.0, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 39.0, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 38.0, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 37.0, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 36.0, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 35.0, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 34.0, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 11.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 12.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 13.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 14.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 15.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 16.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 17.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 18.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 19.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 20.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 21.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 22.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 33.0, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 34.0, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 35.0, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 36.0, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 37.0, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 38.0, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 39.0, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 40.0, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 41.0, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 42.0, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 43.0, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 44.0, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_set_target 45.375, 23.0
	as_call TrainingGymRunner0CWaitWaypointClear
	as_wait_move
	as_jump ActorScript_0e_02

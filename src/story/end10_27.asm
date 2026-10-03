ActorScript_27_05:
	; $5557, 7 bytes (actor_script)
	as_anim ANIM_OVERHEAD_SWING
	as_wait 60
	as_jump ActorScript_27_05
ActorScript_27_06:
	; $555e, 18 bytes (actor_script)
	as_set_field $18, $0006
	as_anim ANIM_SWING_LOOP
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
; Sixteen bytes: $0080, $5520, $7ea0, $4460, then $2508 four times, read
; as words. Three of those look like bank-$27 addresses but each lands
; mid-object rather than on any labelled start, so it is not a pointer
; record. Named for its shape only -- what it holds is not established.
;
; No code anywhere reaches it: no 16-bit immediate load, no add LOW/adc
; HIGH split base, no 8-bit register pair, and no dw word -- searched over
; the raw ROM (so unproven code inside blobs counts) for every address
; inside it, not just its start, with cross-bank byte coincidences filtered
; out. Driving the character-select and CPU-difficulty screens under a
; trace added no coverage here either.
Unused_27_Record:
	; $5570, 16 bytes (bytes:16)
	db $80, $00, $20, $55, $a0, $7e, $60, $44, $08, $25, $08, $25, $08, $25, $08, $25 ; 0x00
End11TrainingCourtInitScriptPalette0_27:
	INCLUDE "data/bank_027/End11TrainingCourtInitScriptPalette0_27.asm" ; $5580, 64 bytes (palettes)
End11TrainingCourtInitScriptPalette1_27:
	INCLUDE "data/bank_027/End11TrainingCourtInitScriptPalette1_27.asm" ; $55c0, 48 bytes (palettes)
End10VarsityCourtMapScripts_27:
	; $55f0, 14 bytes (map_tree)
	dw End10VarsityCourtEntryPoints_27 ; slot 0 EntryPoints
	dw End10VarsityCourtExitTriggers_27 ; slot 1 ExitTriggers
	dw End10VarsityCourtActors_27 ; slot 2 Actors
	dw End10VarsityCourtNpcScripts_27 ; slot 3 NpcScripts
	dw End10VarsityCourtFacingScripts_27 ; slot 4 FacingScripts
	dw End10VarsityCourtTileTriggers_27 ; slot 5 TileTriggers
	dw End10VarsityCourtInitScript_27 ; slot 6 InitScript
End10VarsityCourtActors_27:
	; $55fe, 10 bytes (map_actors)
	map_actor_end
End10VarsityCourtEntryPoints_27:
	; $5608, 9 bytes (map_entries)
	map_entry $01, FACE_UP, 15.0, 31.0, $0000
	db $ff
End10VarsityCourtExitTriggers_27:
	; $5611, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, $0000, STORYLOC_END10_VARSITY_COURT, $01
	db $ff
End10VarsityCourtNpcScripts_27:
	ds 1, $ff ; $561a, fill
End10VarsityCourtFacingScripts_27:
	ds 1, $ff ; $561b, fill
End10VarsityCourtTileTriggers_27:
	ds 1, $ff ; $561c, fill
End10VarsityCourtInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $561d
	cp $01 ; $5620
	jp z, End10VarsityCourtEntry01Scene ; $5622
	ret ; $5625
SetPartnerObjDefByGender_27:
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5626
	or a ; $5629
	jr nz, .done ; $562a
	script_set_objdef OBJ_HARRY, $0d ; $562c
	script_set_anim $0d, ANIM_WALK ; $5638
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $563f
.done:
	ret ; $5642
End10VarsityCourtEntry01Scene:
	test_flag FLAG_DOUBLES ; $5643
	jr z, .notDoubles ; $5646
	jp .scriptRespawnLocationActors ; $5648
.notDoubles:
	wram_bank WRAM_SCENE ; $564b
	ldh a, [hRomBank] ; $5651
	ld hl, End10VarsityCourtActorsAlt_27 ; $5653
	farcall ScriptRespawnLocationActors ; $5656
	script_null_script ACTOR_PLAYER_SHADOW ; $5659
	script_player_speed 7.5 ; $565e
	call SetPartnerObjDefByGender_27 ; $5664
	script_set_position ACTOR_PLAYER, 11.0, 29.0 ; $5667
	script_set_position ACTOR_PARTNER, 13.0, 35.0 ; $5672
	script_face ACTOR_PLAYER, FACE_UP ; $567d
	script_face ACTOR_PARTNER, FACE_UP ; $5684
	script_move_player 11.0, 17.0 ; $568b
	farcall WaitPlayerMoveDone ; $5695
	script_fade_in $04 ; $5698
	script_player_speed 1.0 ; $569d
	script_move_player 11.0, 23.0 ; $56a3
	farcall WaitPlayerMoveDone ; $56ad
	script_move_target ACTOR_END10_VARSITY_COURT_ALT_BOB, 11.0, 23.0 ; $56b0
	script_wait_move ACTOR_END10_VARSITY_COURT_ALT_BOB ; $56bb
	sound SFX_EMOTE ; $56c0
	script_set_position ACTOR_END10_VARSITY_COURT_ALT_BALLOON_QUESTION, 12.25, 27.75 ; $56c2
	script_wait_frames 40 ; $56cd
	script_set_position ACTOR_END10_VARSITY_COURT_ALT_BALLOON_QUESTION, 63.0, 63.0 ; $56d4
	script_face ACTOR_PLAYER, FACE_RIGHT ; $56df
	script_move_player_to_actor ACTOR_END10_VARSITY_COURT_ALT_KATE ; $56e6
	script_set_actor_script ACTOR_END10_VARSITY_COURT_ALT_EMILY, ActorScript_27_07 ; $56ed
	script_set_actor_script ACTOR_END10_VARSITY_COURT_ALT_MARK, ActorScript_27_11 ; $56f8
	script_set_actor_script ACTOR_END10_VARSITY_COURT_ALT_KATE, ActorScript_27_10 ; $5703
	script_wait_frames 10 ; $570e
	script_set_actor_script ACTOR_END10_VARSITY_COURT_ALT_KEVIN, ActorScript_27_09 ; $5715
	script_wait_frames 30 ; $5720
	script_move_player_to_actor ACTOR_PLAYER ; $5727
	farcall WaitPlayerMoveDone ; $572e
	script_wait_actor_script ACTOR_END10_VARSITY_COURT_ALT_KEVIN ; $5731
	script_face_toward ACTOR_PLAYER, ACTOR_END10_VARSITY_COURT_ALT_KATE ; $5736
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $573e
	jr z, .animate ; $5741
	script_set_anim ACTOR_END10_VARSITY_COURT_ALT_KATE, ANIM_BOUNCE ; $5743
	script_wait_idle ACTOR_END10_VARSITY_COURT_ALT_KATE ; $574a
	script_face_toward ACTOR_END10_VARSITY_COURT_ALT_KATE, ACTOR_PLAYER ; $574f
	jr .animate2 ; $5757
.animate:
	script_set_anim $0d, ANIM_BOUNCE ; $5759
	script_wait_idle $0d ; $5760
	script_face_toward $0d, ACTOR_PLAYER ; $5765
.animate2:
	script_set_anim ACTOR_END10_VARSITY_COURT_ALT_MARK, ANIM_SHAKE ; $576d
	script_wait_idle ACTOR_END10_VARSITY_COURT_ALT_MARK ; $5774
	script_face_toward ACTOR_END10_VARSITY_COURT_ALT_MARK, ACTOR_PLAYER ; $5779
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $5781
	script_wait_idle ACTOR_PLAYER ; $5788
	script_wait_frames 20 ; $578d
	script_move_target ACTOR_END10_VARSITY_COURT_ALT_EMILY, 10.0, 31.0 ; $5794
	script_wait_move ACTOR_END10_VARSITY_COURT_ALT_EMILY ; $579f
	script_wait_frames 20 ; $57a4
	script_face_toward ACTOR_END10_VARSITY_COURT_ALT_EMILY, ACTOR_PLAYER ; $57ab
	script_face_toward ACTOR_END10_VARSITY_COURT_ALT_EMILY, $0d ; $57b3
	script_wait_frames 20 ; $57bb
	script_wait_frames 20 ; $57c2
	script_move_target ACTOR_END10_VARSITY_COURT_ALT_KEVIN, 12.0, 31.0 ; $57c9
	script_wait_move ACTOR_END10_VARSITY_COURT_ALT_KEVIN ; $57d4
	script_wait_frames 20 ; $57d9
	script_set_anim ACTOR_END10_VARSITY_COURT_ALT_KEVIN, ANIM_BOUNCE ; $57e0
	script_wait_idle ACTOR_END10_VARSITY_COURT_ALT_KEVIN ; $57e7
	script_set_anim $0d, ANIM_BOUNCE ; $57ec
	script_wait_idle $0d ; $57f3
	script_face_toward ACTOR_PLAYER, $0d ; $57f8
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5800
	jr z, .face ; $5803
.face:
	script_face_toward $0d, ACTOR_PLAYER ; $5805
	script_wait_frames 10 ; $580d
	script_face_toward ACTOR_END10_VARSITY_COURT_ALT_EMILY, ACTOR_PLAYER ; $5814
	script_wait_frames 10 ; $581c
	ld a, $01 ; $5823
	ld [wUnusedExitTriggerIdMirror], a ; $5825
	ld [wStoryModeExitTriggerRequest], a ; $5828
	ret ; $582b
.scriptRespawnLocationActors:
	ldh a, [hRomBank] ; $582c
	ld hl, End10VarsityCourtActorsAltB_27 ; $582e
	farcall ScriptRespawnLocationActors ; $5831
	farcall BeginCutsceneScriptMode ; $5834
	call SetPartnerObjDefByGender_27 ; $5837
	script_null_script ACTOR_PARTNER ; $583a
	script_null_script ACTOR_PLAYER_SHADOW ; $583f
	script_player_speed 7.5 ; $5844
	script_set_position ACTOR_PLAYER, 11.0, 29.0 ; $584a
	ld a, $02 ; $5855
	ld bc, $0d00 ; $5857
	ld de, $2300 ; $585a
SceneSharedData_27:
	farcall ScriptSetActorPosition ; $585d
	script_face ACTOR_PLAYER, FACE_UP ; $5860
	script_face ACTOR_PARTNER, FACE_UP ; $5867
	script_move_player 11.0, 17.0 ; $586e
	farcall WaitPlayerMoveDone ; $5878
	script_fade_in $04 ; $587b
	script_player_speed 1.0 ; $5880
	script_move_player 11.0, 23.0 ; $5886
	farcall WaitPlayerMoveDone ; $5890
	script_move_target ACTOR_PARTNER, 13.0, 29.0 ; $5893
	script_move_target $09, 11.0, 23.0 ; $589e
	script_wait_move $09 ; $58a9
	script_set_anim $09, ANIM_SHAKE ; $58ae
	script_wait_idle $09 ; $58b5
	script_set_anim $04, ANIM_BOUNCE ; $58ba
	script_wait_idle $04 ; $58c1
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $58c6
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $58cd
	script_wait_idle ACTOR_PLAYER ; $58d4
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $58d9
	script_wait_frames 30 ; $58e1
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $58e8
	script_wait_idle ACTOR_PARTNER ; $58ef
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $58f4
	jp z, CeremonyDoublesReaction_27 ; $58f7
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $58fa
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $5902
	script_wait_idle ACTOR_PARTNER ; $5909
	script_face ACTOR_PLAYER, FACE_LEFT ; $590e
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $5915
	sound SFX_APPEAR2 ; $591c
	script_set_position $0a, 12.0, 27.5 ; $591e
	script_wait_frames 40 ; $5929
	script_set_position $0a, 63.0, 63.0 ; $5930
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $593b
	script_wait_frames 10 ; $5943
	script_lock_facing ACTOR_PLAYER ; $594a
	script_wait_frames 10 ; $5951
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0100 ; $5958
	script_wait_move ACTOR_PLAYER ; $5962
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $5967
	script_wait_idle ACTOR_PLAYER ; $596e
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0100 ; $5973
	script_wait_move ACTOR_PLAYER ; $597d
	script_get_actor_state ACTOR_PARTNER ; $5982
	ld de, $0018 ; $5987
	add hl, de ; $598a
	ld [hl], $04 ; $598b
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $598d
	script_wait_idle ACTOR_PARTNER ; $5994
	script_face ACTOR_PARTNER, FACE_UP ; $5999
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $59a0
	script_wait_idle ACTOR_PARTNER ; $59a7
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $59ac
	script_wait_idle ACTOR_PARTNER ; $59b3
	script_face ACTOR_PARTNER, FACE_DOWN ; $59b8
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $59bf
	script_wait_idle ACTOR_PARTNER ; $59c6
	script_face ACTOR_PARTNER, FACE_UP ; $59cb
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $59d2
	script_wait_idle ACTOR_PARTNER ; $59d9
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $59de
	script_wait_idle ACTOR_PARTNER ; $59e5
	script_get_actor_state ACTOR_PARTNER ; $59ea
	ld de, $0018 ; $59ef
	add hl, de ; $59f2
	ld [hl], $01 ; $59f3
	script_face ACTOR_PARTNER, FACE_LEFT ; $59f5
	script_wait_frames 20 ; $59fc
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $5a03
	script_wait_idle ACTOR_PARTNER ; $5a0a
	script_wait_frames 20 ; $5a0f
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5a16
	script_wait_idle ACTOR_PLAYER ; $5a1d
	jp CeremonyDoublesReaction_27.continue ; $5a22
CeremonyDoublesReaction_27:
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $5a25
	script_wait_idle ACTOR_PARTNER ; $5a2c
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $5a31
	sound SFX_APPEAR2 ; $5a39
	script_set_position $0a, 12.0, 27.5 ; $5a3b
	script_wait_frames 40 ; $5a46
	script_set_position $0a, 63.0, 63.0 ; $5a4d
	script_wait_frames 10 ; $5a58
	script_lock_facing ACTOR_PLAYER ; $5a5f
	script_wait_frames 10 ; $5a66
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0100 ; $5a6d
	script_wait_move ACTOR_PLAYER ; $5a77
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $5a7c
	script_wait_idle ACTOR_PLAYER ; $5a83
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0100 ; $5a88
	script_wait_move ACTOR_PLAYER ; $5a92
	script_get_actor_state ACTOR_PARTNER ; $5a97
	ld de, $0018 ; $5a9c
	add hl, de ; $5a9f
	ld [hl], $03 ; $5aa0
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $5aa2
	script_wait_idle ACTOR_PARTNER ; $5aa9
	script_face ACTOR_PARTNER, FACE_DOWN ; $5aae
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $5ab5
	script_wait_idle ACTOR_PARTNER ; $5abc
	script_wait_frames 40 ; $5ac1
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $5ac8
	script_wait_idle ACTOR_PARTNER ; $5acf
	script_get_actor_state ACTOR_PARTNER ; $5ad4
	ld de, $0018 ; $5ad9
	add hl, de ; $5adc
	ld [hl], $01 ; $5add
	script_face ACTOR_PARTNER, FACE_LEFT ; $5adf
	script_wait_frames 20 ; $5ae6
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $5aed
	script_wait_idle ACTOR_PARTNER ; $5af4
	script_wait_frames 20 ; $5af9
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5b00
	script_wait_idle ACTOR_PLAYER ; $5b07
.continue:
	script_wait_frames 20 ; $5b0c
	script_unlock_facing ACTOR_PLAYER ; $5b13
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5b1a
	script_face ACTOR_PARTNER, FACE_RIGHT ; $5b21
	script_set_actor_script $08, ActorScript_27_07 ; $5b28
	script_set_actor_script $03, ActorScript_27_08 ; $5b33
	script_wait_frames 20 ; $5b3e
	script_set_actor_script $09, ActorScript_27_12 ; $5b45
	script_move_player 11.0, 29.0 ; $5b50
	farcall WaitPlayerMoveDone ; $5b5a
	script_wait_actor_script $09 ; $5b5d
	script_face_toward ACTOR_PLAYER, $09 ; $5b62
	script_face_toward $03, ACTOR_PARTNER ; $5b6a
	script_set_anim $09, ANIM_SHAKE ; $5b72
	script_wait_idle $09 ; $5b79
	script_face_toward $09, ACTOR_PLAYER ; $5b7e
	script_move_target $08, 10.0, 31.0 ; $5b86
	script_wait_move $08 ; $5b91
	script_face_toward $08, ACTOR_PLAYER ; $5b96
	script_face_toward $03, ACTOR_PARTNER ; $5b9e
	script_set_anim $08, ANIM_NOD ; $5ba6
	script_wait_idle $08 ; $5bad
	script_move_target $03, 12.0, 31.0 ; $5bb2
	script_wait_move $03 ; $5bbd
	script_set_anim $03, ANIM_BOUNCE ; $5bc2
	script_wait_idle $03 ; $5bc9
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $5bce
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $5bd6
	script_wait_idle ACTOR_PARTNER ; $5bdd
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5be2
	jr z, .facePartner ; $5be5
.facePartner:
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $5be7
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5bef
	script_wait_idle ACTOR_PLAYER ; $5bf6
	script_wait_frames 10 ; $5bfb
	script_face_toward $08, ACTOR_PLAYER ; $5c02
	script_face_toward $03, ACTOR_PARTNER ; $5c0a
	script_wait_frames 10 ; $5c12
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5c19
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $5c20
	ld a, $01 ; $5c27
	ld [wUnusedExitTriggerIdMirror], a ; $5c29
	ld [wStoryModeExitTriggerRequest], a ; $5c2c
	ret ; $5c2f
ActorScript_27_07:
	; $5c30, 29 bytes (actor_script)
	as_set_target 17.0, 29.0
	as_wait_move
	as_set_target 17.0, 35.0
	as_wait_move
	as_set_target 10.0, 35.0
	as_wait_move
	as_set_target 10.0, 33.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_27_08:
	; $5c4d, 29 bytes (actor_script)
	as_set_target 17.0, 29.0
	as_wait_move
	as_set_target 17.0, 35.0
	as_wait_move
	as_set_target 12.0, 35.0
	as_wait_move
	as_set_target 12.0, 33.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_27_09:
	; $5c6a, 35 bytes (actor_script)
	as_set_target 25.0, 29.0
	as_wait_move
	as_set_target 17.0, 29.0
	as_wait_move
	as_set_target 17.0, 35.0
	as_wait_move
	as_set_target 12.0, 35.0
	as_wait_move
	as_set_target 12.0, 33.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_27_10:
	; $5c8d, 7 bytes (actor_script)
	as_set_target 13.0, 29.0
	as_wait_move
	as_halt
ActorScript_27_11:
	; $5c94, 34 bytes (actor_script)
	as_set_target 17.0, 29.0
	as_wait_move
	as_set_target 17.0, 35.0
	as_wait_move
	as_set_target 7.0, 35.0
	as_wait_move
	as_set_target 7.0, 29.0
	as_set_target 9.0, 29.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_27_12:
	; $5cb6, 23 bytes (actor_script)
	as_set_target 7.0, 23.0
	as_wait_move
	as_set_target 7.0, 29.0
	as_wait_move
	as_set_target 9.0, 29.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
End10VarsityCourtActorsAlt_27:
	; $5ccd, 164 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, 25.0, 31.0, FACE_LEFT, OBJ_KEVIN, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_KEVIN
	map_actor $0000, ActorScript_27_27, 11.0, 19.0, FACE_DOWN, OBJ_BOB, ANIM_WALK, $07, END10_VARSITY_COURT_ALT_BOB
	map_actor $0000, ActorScript_27_27, 19.0, 33.0, FACE_LEFT, OBJ_FAY, ANIM_WALK, $03, END10_VARSITY_COURT_ALT_FAY
	map_actor $0000, ActorScript_27_27, 19.0, 35.0, FACE_LEFT, OBJ_CURT, ANIM_WALK, $06, END10_VARSITY_COURT_ALT_CURT
	map_actor $0000, ActorScript_27_27, 19.0, 23.0, FACE_LEFT, OBJ_BETH, ANIM_WALK, $06, END10_VARSITY_COURT_ALT_BETH
	map_actor $0000, ActorScript_27_27, 27.0, 29.0, FACE_LEFT, OBJ_EMILY, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_EMILY
	map_actor $0000, ActorScript_27_27, 25.0, 29.0, FACE_LEFT, OBJ_MARK, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_MARK
	map_actor $0000, ActorScript_27_27, 61.0, 61.0, FACE_LEFT, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_BALLOON_SWEAT
	map_actor $0000, ActorScript_27_27, 61.0, 61.0, FACE_LEFT, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_BALLOON_EXCLAIM
	map_actor $0000, ActorScript_27_27, 61.0, 61.0, FACE_LEFT, OBJ_BALLOON_QUESTION, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_BALLOON_QUESTION
	map_actor $0000, ActorScript_27_27, 23.0, 29.0, FACE_LEFT, OBJ_KATE, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_KATE
	map_actor_end
End10VarsityCourtActorsAltB_27:
	; $5d71, 164 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, 25.0, 29.0, FACE_LEFT, OBJ_KEVIN, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_B_KEVIN
	map_actor $0000, ActorScript_27_27, 13.0, 23.0, FACE_DOWN, OBJ_BOB, ANIM_WALK, $07, END10_VARSITY_COURT_ALT_B_BOB
	map_actor $0000, ActorScript_27_27, 19.0, 33.0, FACE_LEFT, OBJ_FAY, ANIM_WALK, $03, END10_VARSITY_COURT_ALT_B_FAY
	map_actor $0000, ActorScript_27_27, 19.0, 35.0, FACE_LEFT, OBJ_CURT, ANIM_WALK, $06, END10_VARSITY_COURT_ALT_B_CURT
	map_actor $0000, ActorScript_27_27, 19.0, 23.0, FACE_LEFT, OBJ_BETH, ANIM_WALK, $06, END10_VARSITY_COURT_ALT_B_BETH
	map_actor $0000, ActorScript_27_27, 23.0, 29.0, FACE_LEFT, OBJ_EMILY, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_B_EMILY
	map_actor $0000, ActorScript_27_27, 11.0, 19.0, FACE_DOWN, OBJ_MARK, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_B_MARK
	map_actor $0000, ActorScript_27_27, 61.0, 61.0, FACE_LEFT, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_B_BALLOON_SWEAT
	map_actor $0000, ActorScript_27_27, 61.0, 61.0, FACE_LEFT, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_B_BALLOON_EXCLAIM_1
	map_actor $0000, ActorScript_27_27, 61.0, 61.0, FACE_LEFT, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_B_BALLOON_EXCLAIM_2
	map_actor $0000, ActorScript_27_27, 61.0, 61.0, FACE_LEFT, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, END10_VARSITY_COURT_ALT_B_BALLOON_EXCLAIM_3
	map_actor_end
End8SrCourtMapScripts_27:
	; $5e15, 14 bytes (map_tree)
	dw End8SrCourtEntryPoints_27 ; slot 0 EntryPoints
	dw End8SrCourtExitTriggers_27 ; slot 1 ExitTriggers
	dw End8SrCourtActors_27 ; slot 2 Actors
	dw End8SrCourtNpcScripts_27 ; slot 3 NpcScripts
	dw End8SrCourtFacingScripts_27 ; slot 4 FacingScripts
	dw End8SrCourtTileTriggers_27 ; slot 5 TileTriggers
	dw End8SrCourtInitScript_27 ; slot 6 InitScript
End8SrCourtActors_27:
	; $5e23, 94 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, 43.0, 39.0, FACE_UP, OBJ_EMILY, ANIM_WALK, $00, END8_SR_COURT_EMILY
	map_actor $0000, ActorScript_27_27, 34.0, 15.0, FACE_DOWN, OBJ_FAY, ANIM_WALK, $07, END8_SR_COURT_FAY
	map_actor $0000, ActorScript_27_27, 45.0, 19.0, FACE_RIGHT, OBJ_JOY, ANIM_WALK, $04, END8_SR_COURT_JOY
	map_actor $0000, ActorScript_27_27, 27.0, 13.0, FACE_LEFT, OBJ_BRIAN, ANIM_WALK, $06, END8_SR_COURT_BRIAN
	map_actor $0000, ActorScript_27_27, 41.0, 19.0, FACE_LEFT, OBJ_RACKET_STUDENT, ANIM_WALK, $05, END8_SR_COURT_RACKET_STUDENT_1
	map_actor $0000, ActorScript_27_27, 41.0, 25.0, FACE_LEFT, OBJ_RACKET_STUDENT, ANIM_WALK, $00, END8_SR_COURT_RACKET_STUDENT_2
	map_actor_end
End8SrCourtActorsAlt_27:
	; $5e81, 66 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, 43.0, 39.0, FACE_UP, OBJ_EMILY, ANIM_WALK, $00, END8_SR_COURT_ALT_EMILY
	map_actor $0000, ActorScript_27_27, 37.0, 15.0, FACE_DOWN, OBJ_FAY, ANIM_WALK, $07, END8_SR_COURT_ALT_FAY
	map_actor $0000, ActorScript_27_27, 35.0, 19.0, FACE_DOWN, OBJ_ALLIE, ANIM_WALK, $05, END8_SR_COURT_ALT_ALLIE
	map_actor $0000, ActorScript_27_27, 27.0, 13.0, FACE_LEFT, OBJ_BETH, ANIM_WALK, $05, END8_SR_COURT_ALT_BETH
	map_actor_end
End8SrCourtEntryPoints_27:
	; $5ec3, 9 bytes (map_entries)
	map_entry $01, FACE_UP, 36.0, 21.0, $0000
	db $ff
End8SrCourtExitTriggers_27:
	; $5ecc, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_END8_SR_COURT, $01
	db $ff
End8SrCourtNpcScripts_27:
	ds 1, $ff ; $5ed5, fill
End8SrCourtFacingScripts_27:
	ds 1, $ff ; $5ed6, fill
End8SrCourtTileTriggers_27:
	ds 1, $ff ; $5ed7, fill
End8SrCourtInitScript_27:
	test_flag FLAG_DOUBLES ; $5ed8
	jp z, .notDoubles ; $5edb
	ldh a, [hRomBank] ; $5ede
	ld hl, End8SrCourtActorsAlt_27 ; $5ee0
	farcall ScriptRespawnLocationActors ; $5ee3
	farcall BeginCutsceneScriptMode ; $5ee6
	jr .step ; $5ee9
	ret ; $5eeb
.step:
	script_null_script ACTOR_PARTNER ; $5eec
	script_set_position ACTOR_PLAYER, 37.0, 27.0 ; $5ef1
	script_face ACTOR_PLAYER, FACE_UP ; $5efc
	script_set_position ACTOR_PARTNER, 35.0, 27.0 ; $5f03
	script_face ACTOR_PARTNER, FACE_UP ; $5f0e
	script_face ACTOR_END8_SR_COURT_ALT_EMILY, FACE_LEFT ; $5f15
	xor a ; $5f1c
	ld [wStoryModeShowLocationName], a ; $5f1d
	script_fade_in $04 ; $5f20
	script_move_target ACTOR_END8_SR_COURT_ALT_FAY, 37.0, 19.0 ; $5f25
	script_wait_move ACTOR_END8_SR_COURT_ALT_FAY ; $5f30
	script_face_pair ACTOR_END8_SR_COURT_ALT_ALLIE, ACTOR_END8_SR_COURT_ALT_FAY ; $5f35
	script_set_anim ACTOR_END8_SR_COURT_ALT_FAY, ANIM_BOUNCE ; $5f3d
	script_delay 50 ; $5f44
	script_face ACTOR_END8_SR_COURT_ALT_ALLIE, FACE_DOWN ; $5f49
	script_set_anim ACTOR_END8_SR_COURT_ALT_ALLIE, ANIM_SHAKE ; $5f50
	script_wait_idle ACTOR_END8_SR_COURT_ALT_ALLIE ; $5f57
	script_delay 50 ; $5f5c
	script_set_anim ACTOR_END8_SR_COURT_ALT_FAY, ANIM_BOUNCE ; $5f61
	script_set_anim ACTOR_END8_SR_COURT_ALT_ALLIE, ANIM_BOUNCE ; $5f68
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $5f6f
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $5f76
	script_face ACTOR_PLAYER, FACE_DOWN ; $5f7d
	script_face ACTOR_PARTNER, FACE_DOWN ; $5f84
	script_face ACTOR_END8_SR_COURT_ALT_FAY, FACE_DOWN ; $5f8b
	script_delay 30 ; $5f92
	script_player_speed 1.5 ; $5f97
	script_set_speed ACTOR_END8_SR_COURT_ALT_EMILY, 0.5 ; $5f9d
	script_move_player 43.0, 31.0 ; $5fa5
	script_move_target ACTOR_END8_SR_COURT_ALT_EMILY, 43.0, 32.0 ; $5faf
	script_delay 90 ; $5fba
	script_player_speed 0.5 ; $5fbf
	script_move_player 36.0, 27.0 ; $5fc5
	script_move_target ACTOR_END8_SR_COURT_ALT_EMILY, 37.0, 31.0 ; $5fcf
	script_wait_move ACTOR_END8_SR_COURT_ALT_EMILY ; $5fda
	script_face ACTOR_END8_SR_COURT_ALT_EMILY, FACE_UP ; $5fdf
	script_set_anim ACTOR_END8_SR_COURT_ALT_EMILY, ANIM_BOUNCE ; $5fe6
	script_wait_idle ACTOR_END8_SR_COURT_ALT_EMILY ; $5fed
	script_delay 20 ; $5ff2
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $5ff7
	script_delay 40 ; $5fff
	script_face ACTOR_PLAYER, FACE_DOWN ; $6004
	script_face ACTOR_PARTNER, FACE_DOWN ; $600b
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $6012
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $6019
	script_wait_idle ACTOR_PLAYER ; $6020
	script_set_anim ACTOR_END8_SR_COURT_ALT_EMILY, ANIM_NOD ; $6025
	script_wait_idle ACTOR_END8_SR_COURT_ALT_EMILY ; $602c
	script_delay 20 ; $6031
	script_move_target ACTOR_END8_SR_COURT_ALT_EMILY, 37.0, 29.0 ; $6036
	script_wait_move ACTOR_END8_SR_COURT_ALT_EMILY ; $6041
	script_set_anim ACTOR_END8_SR_COURT_ALT_EMILY, ANIM_BOUNCE ; $6046
	script_wait_idle ACTOR_END8_SR_COURT_ALT_EMILY ; $604d
	script_wait_frames 30 ; $6052
	script_set_anim ACTOR_END8_SR_COURT_ALT_EMILY, ANIM_NOD ; $6059
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $6060
	script_wait_idle ACTOR_PLAYER ; $6067
	ld a, $01 ; $606c
	ld [wUnusedExitTriggerIdMirror], a ; $606e
	ld [wStoryModeExitTriggerRequest], a ; $6071
	ret ; $6074
.notDoubles:
	script_set_speed ACTOR_END8_SR_COURT_ALT_FAY, 0.75 ; $6075
	script_set_position ACTOR_PLAYER, 36.0, 27.0 ; $607d
	script_face ACTOR_PLAYER, FACE_UP ; $6088
	xor a ; $608f
	ld [wStoryModeShowLocationName], a ; $6090
	script_fade_in $04 ; $6093
	script_move_target ACTOR_END8_SR_COURT_ALT_FAY, 36.0, 19.0 ; $6098
	script_wait_move ACTOR_END8_SR_COURT_ALT_FAY ; $60a3
	script_delay 20 ; $60a8
	script_delay 40 ; $60ad
	script_set_anim ACTOR_END8_SR_COURT_ALT_FAY, ANIM_BOUNCE ; $60b2
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $60b9
	script_wait_idle ACTOR_PLAYER ; $60c0
	script_face ACTOR_PLAYER, FACE_DOWN ; $60c5
	script_delay 30 ; $60cc
	script_player_speed 1.5 ; $60d1
	script_set_speed ACTOR_END8_SR_COURT_ALT_EMILY, 0.5 ; $60d7
	script_move_player 43.0, 31.0 ; $60df
	script_move_target ACTOR_END8_SR_COURT_ALT_EMILY, 43.0, 31.0 ; $60e9
	script_delay 90 ; $60f4
	script_player_speed 0.5 ; $60f9
	script_move_player 36.0, 27.0 ; $60ff
	script_wait_move ACTOR_END8_SR_COURT_ALT_EMILY ; $6109
	script_move_target ACTOR_END8_SR_COURT_ALT_EMILY, 36.0, 31.0 ; $610e
	script_wait_move ACTOR_END8_SR_COURT_ALT_EMILY ; $6119
	script_move_target ACTOR_END8_SR_COURT_ALT_EMILY, 36.0, 30.0 ; $611e
	script_wait_move ACTOR_END8_SR_COURT_ALT_EMILY ; $6129
	script_move_target ACTOR_END8_SR_COURT_ALT_EMILY, 36.0, 29.0 ; $612e
	script_wait_move ACTOR_END8_SR_COURT_ALT_EMILY ; $6139
	script_delay 30 ; $613e
	script_set_anim ACTOR_END8_SR_COURT_ALT_EMILY, ANIM_BOUNCE ; $6143
	script_wait_idle ACTOR_END8_SR_COURT_ALT_EMILY ; $614a
	script_delay 30 ; $614f
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $6154
	script_wait_idle ACTOR_PLAYER ; $615b
	script_delay 20 ; $6160
	script_set_anim ACTOR_END8_SR_COURT_ALT_EMILY, ANIM_NOD ; $6165
	script_wait_idle ACTOR_END8_SR_COURT_ALT_EMILY ; $616c
	script_delay 40 ; $6171
	ld a, $01 ; $6176
	ld [wUnusedExitTriggerIdMirror], a ; $6178
	ld [wStoryModeExitTriggerRequest], a ; $617b
	ret ; $617e

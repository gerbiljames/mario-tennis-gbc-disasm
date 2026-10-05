; After the Varsity victory cutscene: back to the Courtyard where it ended,
; not to the main-menu break and the trip to the Island Open
ApReturnToCourtyard_13:
	ld hl, wStoryModePlayersXPosition
	ld de, wStoryModeSpawnPosition
	ld bc, wStoryModeSpawnPosition_SIZE
	call CopyMemoryBC
	ld a, STORYLOC_COURTYARD
	ld [wStoryModeCurrentLocation], a
	ld a, STORYENTRY_NONE
	ld [wStoryModeEntryPoint], a
	ld [wUnusedExitTriggerIdMirror], a
	ld [wStoryModeExitTriggerRequest], a
	ret

; The Varsity court once its match is won, until the arc's third pass opens
; the Island Open
ApVarsityWonSingles_13:
	ldh a, [hRomBank]
	ld hl, VarsityCourtActorsA_13
	farcall ScriptRespawnLocationActors
	ld hl, ApVarsityWonNpcScriptsA_13
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation
	farcall WriteStoryStateWord
	ret

ApVarsityWonDoubles_13:
	ldh a, [hRomBank]
	ld hl, VarsityCourtActorsB_13
	farcall ScriptRespawnLocationActors
	ld hl, ApVarsityWonNpcScriptsB_13
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation
	farcall WriteStoryStateWord
	ret

ApVarsityWonNpcScriptsA_13:
	map_script ACTOR_VARSITY_COURT_A_KEVIN, FACEMASK_ANY, $0000, Text_31_0, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_A_BOB, FACEMASK_ANY, $0000, Text_30_554, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_A_FAY, FACEMASK_ANY, $0000, VarsityCourtANpc05_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_A_CURT, FACEMASK_ANY, $0000, Text_30_542, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_VARSITY_COURT_A_BETH, FACEMASK_ANY, $0000, Text_30_543, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff

ApVarsityWonNpcScriptsB_13:
	map_script ACTOR_VARSITY_COURT_B_KEVIN, FACEMASK_ANY, $0000, Text_31_31, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_B_BOB, FACEMASK_ANY, $0000, Text_31_22, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_B_FAY, FACEMASK_ANY, $0000, VarsityCourtBNpc05_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_B_CURT, FACEMASK_ANY, $0000, Text_31_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_B_BETH, FACEMASK_ANY, $0000, Text_31_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_VARSITY_COURT_B_MARK, FACEMASK_ANY, $0000, Text_31_29, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff

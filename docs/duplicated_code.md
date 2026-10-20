# Duplicated code: live routines with identical copies

The ROM assembles some routines into several banks, and a few several times
into one bank. A fix to one copy has to reach them all. This page lists
every group of live routines that are instruction-identical once the bank
suffix on names is ignored (`FetchText_25` and `FetchText_26` call
`FetchText`-shaped helpers of their own bank): the output of
`tools/twins.py`, with a floor of ten instructions. Dead copies are in
`docs/unused_code.md`. Copies that serve different screens or minigames
keep their own names (`IsBallInMedallionMatchHitZone` /
`IsBallInTreasureBoxHitZone`, the seven `*AwardPointToSide` minigame
handlers); the shared `twin` line says they are the same code.

## Shared files

A family is one file under `src/twins/`, assembled into each bank where a
copy sits, so a fix lands in every bank while the bytes stay each copy's own
(`make compare` holds). Three forms:

* `twin fetch_text, 25` includes `src/twins/fetch_text.asm` with `{TWIN}` =
  `25`, so `FetchText_{TWIN}:` and every bank-local reference in the body
  (`FetchTextTable_{TWIN}`) become that bank's;
* `twin_named file, Label` includes a file whose first line is
  `{TWIN_LABEL}:`, for copies with different names;
* `twin_in file, Label, bank` sets both, for copies with different names
  that read their own bank's table (`ShotBallPathSlice`/`ShotBallPathPowerSlice`,
  the topspin pair), and names a dead copy `Unused_<bank>_<Name>`.

The shared bodies carry no per-instruction address comments; the `twin` line
has the copy's start address.
`tools/banksrc.py` expands the `twin` lines, so the tools and tests see every
bank whole.

A file can hold more copies than its live group below, since dead copies are
included too. `apply_sprite_wobble_x`, `draw_ascii_digit_char`,
`draw_corner_brackets`, `draw_decimal_number`,
`compute_ranking_progress_index_13`, `get_cell_index_from_cursor_ptr`,
`get_menu_cursor_index_from_ptr`, `set_menu_cursor_from_index_to_ptr`,
`lookup_ball_pos_by_aim`, `move_menu_cursor2_grid_remote`,
`move_menu_cursor_grid_remote`, `move_menu_cursor_grid_from_link_input` and
`move_menu_cursor_grid_from_link_input_17` have no live copy at all.

Four look-alikes stay separate because they differ: the Island Open NPC
scripts `IslandOpenFinalDoublesNpc0BBCoz_0f` / `IslandOpenRound1DoublesNpc0BSean_0f`,
and the `Npc0D` pair, set different text ids. The table also has the
families under the ten-instruction floor (`twins.py --min 4`).

| file | routine | banks |
|---|---|---|
| `src/twins/academy_main_bldg_arrival01.asm` | `RestaurantArrival01_10`, `AcademyMainBldgArrival01_10`, `MapArrivalWalk_11`, `DormEntranceArrival01_12`, `RestaurantPlazaFromCourtyard_13` | $10, $10, $11, $12, $13 |
| `src/twins/academy_main_bldg_arrival02.asm` | `AcademyMainBldgArrival02_10`, `AcademyEntranceArrival01_11`, `DormEntranceArrival02_12` | $10, $11, $12 |
| `src/twins/academy_wing_close_door.asm` | `AcademyWingCloseDoor_<bank>` | $10, $27 |
| `src/twins/academy_wing_open_door.asm` | `AcademyWingOpenDoor_<bank>` | $10, $27 |
| `src/twins/advance_plane_frame_counter.asm` | `AdvancePlaneFrameCounter_14`, `AdvancePlaneFrameCounter2_14` | $14 |
| `src/twins/apply_ball_trajectory4.asm` | `ApplyBallTrajectory4_<bank>` | $20-$24, $29-$2c |
| `src/twins/apply_ball_trajectory4_capped.asm` | `ApplyBallTrajectory4Capped_<bank>` | $20-$24, $29-$2c |
| `src/twins/apply_ball_trajectory6.asm` | `ApplyBallTrajectory6_<bank>` | $20-$24, $29-$2c |
| `src/twins/apply_ball_trajectory6_capped.asm` | `ApplyBallTrajectory6Capped_<bank>` | $20-$24, $29-$2c |
| `src/twins/apply_ball_trajectory_capped.asm` | `ApplyBallTrajectoryCapped_<bank>` | $20-$24, $2a-$2c |
| `src/twins/apply_sprite_wobble_x.asm` | `Unused_<bank>_ApplySpriteWobbleX` | $16, $17 |
| `src/twins/apply_sprite_wobble_y.asm` | `ApplySpriteWobbleY_<bank>` | $16, $17 |
| `src/twins/ball_traj_entry_ptr4.asm` | `BallTrajEntryPtr4_<bank>` | $20-$24, $29-$2c |
| `src/twins/ball_traj_entry_ptr6.asm` | `BallTrajEntryPtr6_<bank>` | $20-$24, $29-$2c |
| `src/twins/banana_bunch_reflect_ball_and_record_cell.asm` | `BananaBunchReflectBallAndRecordCell`, `FruitFantasyReflectBallAndRecordCell` | $0d |
| `src/twins/close_restaurant_ent_door.asm` | `CloseRestaurantEntDoor_<bank>` | $13, $27 |
| `src/twins/compute_ranking_progress_index.asm` | `ComputeRankingProgressIndex_<bank>` | $0e, $11, $12, $27 |
| `src/twins/compute_ranking_progress_index_13.asm` | `Unused_<bank>_ComputeRankingProgressIndex` | $13, $14, $15 |
| `src/twins/compute_story_rank_tier.asm` | `ComputeStoryRankTier_<bank>` | $13, $15 |
| `src/twins/development_facing01.asm` | `DevelopmentFacing01_10`, `Test2Facing01_10`, `WallPracticeRoomFacing01_12`, `DormRoomFacing01_13` | $10, $10, $12, $13 |
| `src/twins/development_tile01.asm` | `DevelopmentTile01_10`, `Test2Tile01_10` | $10 |
| `src/twins/dorm_room_departure_morning_scene.asm` | `DormRoomDepartureMorningAltScene`, `DormRoomDepartureMorningScene` | $13 |
| `src/twins/draw_ascii_digit_char.asm` | `Unused_<bank>_DrawAsciiDigitChar` | $16, $17, $1b, $3b, $3e |
| `src/twins/draw_confirm_selection_cursor.asm` | `DrawConfirmSelectionCursor_<bank>` | $1a, $1c, $1d |
| `src/twins/draw_corner_brackets.asm` | `Unused_<bank>_DrawCornerBrackets` | $1b, $38, $3b, $3e |
| `src/twins/draw_decimal_number.asm` | `Unused_<bank>_DrawDecimalNumber` | $17, $1b, $3b, $3e |
| `src/twins/draw_name_with_diacritics.asm` | `DrawNameWithDiacritics_<bank>` | $17, $1b, $3e |
| `src/twins/draw_name_with_diacritics_38.asm` | `DrawNameWithDiacritics_<bank>` | $38, $3b |
| `src/twins/extract_decimal_digit.asm` | `ExtractDecimalDigit`, `ExtractDecimalDigitUnsigned` | $00 |
| `src/twins/fetch_text.asm` | `FetchText_<bank>` | the thirteen text banks |
| `src/twins/flush_match_format_row_to_vram.asm` | `FlushMatchFormatRowToVram`, `FlushLinkMatchFormatRowAttrs` | $3b, $3e |
| `src/twins/get_cell_index_from_cursor_ptr.asm` | `Unused_<bank>_GetCellIndexFromCursorPtr` | $16, $3b, $3e |
| `src/twins/get_menu_cursor_index.asm` | `GetMenuCursorIndex_<bank>` | $16, $1b, $38, $3b, $3e |
| `src/twins/get_menu_cursor_index_from_ptr.asm` | `Unused_<bank>_GetMenuCursorIndexFromPtr` | $1b, $38 |
| `src/twins/init_minigame_medallion_match.asm` | the four `InitMinigame_*` tennis-machine setups | $0d |
| `src/twins/intro_cutscene_state00_update.asm` | `IntroCutsceneState00Update_6b`, `IntroCutsceneState16Update_6b` | $6b |
| `src/twins/intro_cutscene_state03_exit.asm` | `IntroCutsceneState03Exit_6b`, `IntroCutsceneState05Exit_6b` | $6b |
| `src/twins/intro_cutscene_state07_update.asm` | `IntroCutsceneState07Update_6b`, `IntroCutsceneState09Update_6b` | $6b |
| `src/twins/intro_cutscene_state11_update.asm` | `IntroCutsceneState11Update_6b`, `IntroCutsceneState12Update_6b` | $6b |
| `src/twins/intro_cutscene_state13_update.asm` | `IntroCutsceneState13Update_6b`, `IntroCutsceneState14Update_6b` | $6b |
| `src/twins/is_ball_in_medallion_match_hit_zone.asm` | `IsBallInTreasureBoxHitZone`, `IsBallInMedallionMatchHitZone` | $0d |
| `src/twins/island_open_round_doubles_npc04_emily.asm` | `IslandOpenRoundSinglesNpc04Emily_0f`, `IslandOpenRoundDoublesNpc04Emily_0f` | $0f |
| `src/twins/junior_class_court_singles_npc03_junior_coach_face_up.asm` | `JuniorClassCourtSinglesNpc03JuniorCoachFaceUp_11`, `JuniorClassCourtDoublesNpc03JuniorCoachFaceUp_11` | $11 |
| `src/twins/load_player_partner_obj_defs.asm` | `LoadPlayerPartnerObjDefs_<bank>` | $11, $14, $15 |
| `src/twins/lookup_ball_pos_by_aim.asm` | `Unused_<bank>_LookupBallPosByAim` | $20-$23, $29-$2b |
| `src/twins/lookup_ball_pos_by_aim_24.asm` | `LookupBallPosByAim_<bank>` | $24, $2c |
| `src/twins/lookup_ball_pos_by_height.asm` | `LookupBallPosByHeight_<bank>` | $20-$24, $29-$2c |
| `src/twins/lookup_ball_pos_by_shot_index.asm` | `LookupBallPosByShotIndex_<bank>` | $20-$24, $29-$2b |
| `src/twins/match_format_slide_out.asm` | `MatchFormatSlideOut`, `CloseLinkMatchFormatPanel` | $3b, $3e |
| `src/twins/mirror_player_sprite_if_left_handed.asm` | `MirrorPlayerSpriteIfLeftHanded`, `TogglePlayerSpriteXFlip` | $0e, $15 |
| `src/twins/move_menu_cursor2_grid_remote.asm` | `Unused_<bank>_MoveMenuCursor2GridRemote` | $16, $3e |
| `src/twins/move_menu_cursor_grid.asm` | `MoveMenuCursorGrid_<bank>` | $38, $3b, $3e |
| `src/twins/move_menu_cursor_grid_17.asm` | `MoveMenuCursorGrid_<bank>` | $17, $1b |
| `src/twins/move_menu_cursor_grid_from_link_input.asm` | `Unused_<bank>_MoveMenuCursorGridFromLinkInput` | $16, $38, $3e |
| `src/twins/move_menu_cursor_grid_from_link_input_17.asm` | `Unused_<bank>_MoveMenuCursorGridFromLinkInput` | $17, $1b |
| `src/twins/move_menu_cursor_grid_remote.asm` | `Unused_<bank>_MoveMenuCursorGridRemote` | $16, $38, $3e |
| `src/twins/net_game_match1_award_point_to_side.asm` | the seven `*AwardPointToSide` minigame handlers | $0b |
| `src/twins/net_game_practice1_handle_point_end.asm` | `NetGamePractice1/2/3HandlePointEnd` | $0b |
| `src/twins/net_game_practice2_hook_minigame_start.asm` | `NetGamePractice2/3Hook_MinigameStart` | $0b |
| `src/twins/open_restaurant_ent_door.asm` | `OpenRestaurantEntDoor_<bank>` | $13, $27 |
| `src/twins/project_medallion_match_world_position.asm` | `ProjectTreasureBoxWorldPosition`, `ProjectMedallionMatchWorldPosition` | $0d |
| `src/twins/push_short_text_arg.asm` | `PushShortTextArg_<bank>` | $0e, $0f, $12 |
| `src/twins/queue_caption_row_to_vram.asm` | `QueueCaptionRowToVRAM`, `FlushLinkMessageRows` | $17, $3e |
| `src/twins/read_scene_tilemap_tile.asm` | `ReadSceneTilemapTile_<bank>` | $0f, $10 |
| `src/twins/restaurant_plaza_from_training_court.asm` | `RestaurantPlazaFromTrainingCourt_13`, `Court2EntryWalkIn` | $13, $14 |
| `src/twins/seek_ball_traj_entry4.asm` | `SeekBallTrajEntry4_<bank>` | $20-$24, $29-$2c |
| `src/twins/seek_ball_traj_entry6.asm` | `SeekBallTrajEntry6_<bank>` | $20-$24, $29-$2c |
| `src/twins/service_match1_hook_point_start.asm` | `ServiceMatch1/3Hook_PointStart` | $0b |
| `src/twins/service_practice1_hook_bounce.asm` | `ServicePractice1/3Hook_Bounce` | $0b |
| `src/twins/set_ball_target_by_prediction.asm` | `SetBallTargetByPrediction_<bank>` | $20-$24, $29-$2c |
| `src/twins/set_ball_target_from_aim.asm` | `SetBallTargetFromAim_<bank>` | $20-$24, $29-$2c |
| `src/twins/set_ball_velocity_from_entry4.asm` | `SetBallVelocityFromEntry4_<bank>` | $20-$24, $29-$2c |
| `src/twins/set_ball_velocity_from_entry6.asm` | `SetBallVelocityFromEntry6_<bank>` | $20-$24, $29-$2c |
| `src/twins/set_menu_cursor_from_index.asm` | `SetMenuCursorFromIndex_<bank>` | $16, $38, $3b, $3e |
| `src/twins/set_menu_cursor_from_index_to_ptr.asm` | `Unused_<bank>_SetMenuCursorFromIndexToPtr` | $16, $38, $3e |
| `src/twins/set_partner_obj_def_by_gender.asm` | `SetPartnerObjDefByGender_<bank>` | $13, $27 |
| `src/twins/set_roommate_singles_no_reply_text.asm` | `SetRoommateSinglesNoReplyText_13`, `SetRoommateSinglesYesReplyText_13` | $13 |
| `src/twins/shot_ball_path_slice.asm` | `ShotBallPathSlice`, `ShotBallPathPowerSlice` (`twin_in`) | $20, $21 |
| `src/twins/shot_ball_path_topspin.asm` | `ShotBallPathTopspin`, `ShotBallPathPowerTopspin` (`twin_in`) | $22, $23 |
| `src/twins/snap_camera_to.asm` | `SnapCameraTo_<bank>` | $08, $0d |
| `src/twins/start_drill_from_definition.asm` | `StartDrillFromDefinition`, `InitMinigameFromConfig` | $0b, $0d |
| `src/twins/stroke_practice1_cases2.asm` | `StrokePractice1Cases2`, `StrokePractice3Cases2` | $0b |
| `src/twins/stroke_practice1_evaluate_result.asm` | `StrokePractice1EvaluateResult`, `StrokePractice3EvaluateResult` | $0b |
| `src/twins/stroke_practice1_handle_point_end.asm` | `StrokePractice1HandlePointEnd`, `StrokePractice3HandlePointEnd` | $0b |
| `src/twins/stroke_practice1_hook_minigame_start.asm` | `StrokePractice1/3Hook_MinigameStart` | $0b |
| `src/twins/tennis_machine1_hook_minigame_start.asm` | `TennisMachine1/2Hook_MinigameStart` | $0d |
| `src/twins/tennis_machine3_hook_minigame_start.asm` | `TennisMachine3/4Hook_MinigameStart`, `TennisMachineHighScoreHook_MinigameStart` | $0d |
| `src/twins/tennis_machine4_hook__point_start.asm` | `TennisMachine4Hook_PointStart`, `TennisMachineHighScoreHook_PointStart` | $0d |
| `src/twins/varsity_court_npc03_face_up.asm` | `VarsityCourtSinglesNpc03FaceUp_13`, `VarsityCourtDoublesNpc03FaceUp_13` | $13 |
| `src/twins/wait_script_frames_save_a.asm` | `WaitScriptFramesSaveA_<bank>` (five instructions, under the floor; `script_delay` picks its bank's copy) | $0f, $27 |

## The families

* **Ball trajectory (banks `$20`-`$24`, `$29`-`$2c`).** Every shot-solver bank
  carries the same helpers: the five `ApplyBallTrajectory*` shapes,
  `SeekBallTrajEntry4/6`, `SetBallVelocityFromEntry4/6`, `BallTrajEntryPtr4/6`,
  the three `LookupBallPos*` and the two `SetBallTarget*`. The banks differ in
  their shot tables, not their code (`docs/match_engine.md`). Most copies are
  `Unused`; the live ones are the groups below.
* **Text fetch (thirteen text banks).** `FetchText_<bank>` is the same 40
  instructions in every bank that holds a string pool.
* **Menu cursor and name drawing (banks `$1b`, `$38`, `$3b`, `$3e`).** The
  grid-cursor mover, the index converters and the diacritic-aware name
  drawer -- a UI library each menu bank got a copy of. The link and remote
  movers, the corner-bracket drawer and the ASCII digit printer were copied
  too, but no copy of them is live, and of the decimal printer only
  `DrawDecimalNumber` in bank `$38` is. Two variants of the mover exist
  (`$17`/`$1b` against `$38`/`$3b`/`$3e`); only `MoveMenuCursorGrid_1b` of
  the first is live.
* **Story helpers (banks `$0e`-`$15`).** `ComputeRankingProgressIndex`
  and `ComputeStoryRankTier`, the shared-include pattern that also produced
  the dead copies in `docs/unused_code.md`; plus arrival walk scripts that
  several locations share verbatim.
* **Minigame handlers (banks `$0b`, `$0d`).** Point-award, point-end and
  result evaluators duplicated per minigame variant, and the medallion /
  treasure-box hit-zone pair.

## The groups

| copies | instructions | banks | routines |
|---|---|---|---|
| 13 | 40 | $1f, $25, $26, $30, $31, $32, $33, $34, $35, $36, $37, $5e, $6e | `FetchText_*` |
| 9 | 30 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `LookupBallPosByHeight_*` |
| 8 | 14 | $20, $21, $22, $23, $24, $29, $2a, $2b | `LookupBallPosByShotIndex_*` |
| 7 | 22 | $0b | `NetGameMatch1AwardPointToSide`, `NetGameMatch2AwardPointToSide`, `NetGameMatch3AwardPointToSide`, `ServiceMatch2AwardPointToSide`, `ServiceMatch3AwardPointToSide`, `StrokeMatch2AwardPointToSide`, `StrokeMatch3AwardPointToSide` |
| 6 | 15 | $20, $21, $22, $23, $24, $2c | `BallTrajEntryPtr6_*` |
| 6 | 30 | $20, $21, $22, $23, $24, $2c | `SetBallTargetFromAim_*` |
| 6 | 32 | $20, $21, $22, $23, $24, $2c | `SetBallVelocityFromEntry6_*` |
| 5 | 13 | $10, $11, $12, $13 | `AcademyMainBldgArrival01_10`, `RestaurantArrival01_10`, `MapArrivalWalk_11`, `DormEntranceArrival01_12`, `RestaurantPlazaFromCourtyard_13` |
| 5 | 22 | $20, $21, $22, $23, $2c | `SeekBallTrajEntry6_*` |
| 4 | 12 | $1b, $38, $3b, $3e | `GetMenuCursorIndex_*` |
| 3 | 13 | $10, $11, $12 | `AcademyMainBldgArrival02_10`, `AcademyEntranceArrival01_11`, `DormEntranceArrival02_12` |
| 3 | 31 | $0e, $11, $12 | `ComputeRankingProgressIndex_*` |
| 3 | 12 | $1a, $1c, $1d | `DrawConfirmSelectionCursor_*` |
| 3 | 74 | $38, $3b, $3e | `MoveMenuCursorGrid_*` |
| 3 | 30 | $0b | `NetGamePractice1HandlePointEnd`, `NetGamePractice2HandlePointEnd`, `NetGamePractice3HandlePointEnd` |
| 3 | 79 | $29, $2a, $2b | `SetBallTargetByPrediction_*` |
| 3 | 11 | $38, $3b, $3e | `SetMenuCursorFromIndex_*` |
| 2 | 12 | $24, $2c | `BallTrajEntryPtr4_*` |
| 2 | 24 | $13, $15 | `ComputeStoryRankTier_*` |
| 2 | 43 | $38, $3b | `DrawNameWithDiacritics_*` |
| 2 | 28 | $3b, $3e | `FlushMatchFormatRowToVram`, `FlushLinkMatchFormatRowAttrs` |
| 2 | 10 | $13 | `DormRoomDepartureMorningAltScene`, `DormRoomDepartureMorningScene` |
| 2 | 14 | $6b | `IntroCutsceneState00Update_6b`, `IntroCutsceneState16Update_6b` |
| 2 | 72 | $0d | `IsBallInMedallionMatchHitZone`, `IsBallInTreasureBoxHitZone` |
| 2 | 11 | $0f | `IslandOpenRoundDoublesNpc04Emily_0f`, `IslandOpenRoundSinglesNpc04Emily_0f` |
| 3 | 21 | $11, $14, $15 | `LoadPlayerPartnerObjDefs_11`, `LoadPlayerPartnerObjDefs_14`, `LoadPlayerPartnerObjDefs_15` |
| 2 | 27 | $3b, $3e | `MatchFormatSlideOut`, `CloseLinkMatchFormatPanel` |
| 2 | 12 | $0e, $15 | `MirrorPlayerSpriteIfLeftHanded`, `TogglePlayerSpriteXFlip` |
| 2 | 14 | $0d | `ProjectMedallionMatchWorldPosition`, `ProjectTreasureBoxWorldPosition` |
| 2 | 19 | $0f, $10 | `ReadSceneTilemapTile_*` |
| 2 | 13 | $13, $14 | `RestaurantPlazaFromTrainingCourt_13`, `Court2EntryWalkIn` |
| 2 | 22 | $24, $2c | `SeekBallTrajEntry4_*` |
| 2 | 16 | $24, $2c | `SetBallVelocityFromEntry4_*` |
| 2 | 11 | $20, $21 | `ShotBallPathSlice`, `ShotBallPathPowerSlice` |
| 2 | 11 | $22, $23 | `ShotBallPathTopspin`, `ShotBallPathPowerTopspin` |
| 2 | 21 | $08, $0d | `SnapCameraTo_08`, `SnapCameraTo_0d` |
| 2 | 64 | $0b, $0d | `StartDrillFromDefinition`, `InitMinigameFromConfig` |
| 2 | 29 | $0b | `StrokePractice1Cases2`, `StrokePractice3Cases2` |
| 2 | 34 | $0b | `StrokePractice1EvaluateResult`, `StrokePractice3EvaluateResult` |
| 2 | 30 | $0b | `StrokePractice1HandlePointEnd`, `StrokePractice3HandlePointEnd` |
| 2 | 11 | $0d | `TennisMachine4Hook_PointStart`, `TennisMachineHighScoreHook_PointStart` |

# Duplicated code: live routines with identical copies

The ROM assembles the same routine into several banks and, in a few cases,
several times into one bank. A modder fixing one copy has to fix them all,
and nothing at the call sites says a twin exists. This page lists every
group of live routines that are instruction-identical once the bank suffix
on names is ignored (`FetchText_25` and `FetchText_26` call `FetchText`-shaped
helpers of their own bank), measured by `tools/twins.py` over the source
with a floor of ten instructions. `Unused*` routines are left to
`docs/unused_code.md`, which covers the dead copies of the same families.

The note above each member in `src/` names its twins, so the fact is visible
where the routine is read; on 2026-09-11 the copies whose names had
drifted apart (`MoveMenuCursorBox` / `MoveMenuCursor` / `MoveMenuCursorGrid_3e`,
`PrintNumberString_3b` / `DrawDecimalNumber_17`, `ComputeSeniorCourtStageB` /
`ComputeRankingProgressIndex`) were renamed to one base name plus bank suffix.
Names that differ because the copies serve different screens or minigames
(`IsBallInMedallionMatchHitZone` / `IsBallInTreasureBoxHitZone`, the seven
`*AwardPointToSide` minigame handlers) keep them; the note says they are the
same code.

## The families

* **Ball trajectory (banks `$20`-`$24`, `$29`-`$2c`).** Every shot-solver bank
  carries the same fifteen helpers: the four `ApplyBallTrajectory*` shapes,
  `SeekBallTrajEntry4/6`, `SetBallVelocityFromEntry4/6`, `BallTrajEntryPtr4/6`,
  the three `LookupBallPos*` and the two `SetBallTarget*`. The banks differ in
  their shot tables, not their code (`docs/match_engine.md`).
* **Text fetch (thirteen text banks).** `FetchText_<bank>` is the same 40
  instructions in every bank that holds a string pool.
* **Menu cursor and number drawing (banks `$16`, `$17`, `$1b`, `$38`, `$3b`,
  `$3e`).** The grid-cursor mover in its local, link and remote forms, the
  index/pointer converters, the corner-bracket drawer, the ASCII digit and
  decimal printers and the diacritic-aware name drawer -- a UI library each
  menu bank got a copy of. Two variants of the mover exist (`$17`/`$1b`
  against `$38`/`$3b`/`$3e`); the groups below keep them apart.
* **Story helpers (banks `$0e`-`$15`, `$27`).** `ComputeRankingProgressIndex`
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
| 9 | 32 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `ApplyBallTrajectory4Capped_*` |
| 9 | 25 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `ApplyBallTrajectory4_*` |
| 9 | 32 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `ApplyBallTrajectory6Capped_*` |
| 9 | 23 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `ApplyBallTrajectory6_*` |
| 9 | 12 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `BallTrajEntryPtr4_*` |
| 9 | 15 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `BallTrajEntryPtr6_*` |
| 9 | 30 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `LookupBallPosByHeight_*` |
| 9 | 22 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `SeekBallTrajEntry4_*` |
| 9 | 22 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `SeekBallTrajEntry6_*` |
| 9 | 79 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `SetBallTargetByPrediction_*` |
| 9 | 30 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `SetBallTargetFromAim_*` |
| 9 | 16 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `SetBallVelocityFromEntry4_*` |
| 9 | 32 | $20, $21, $22, $23, $24, $29, $2a, $2b, $2c | `SetBallVelocityFromEntry6_*` |
| 8 | 38 | $20, $21, $22, $23, $24, $2a, $2b, $2c | `ApplyBallTrajectoryCapped_*` |
| 8 | 14 | $20, $21, $22, $23, $24, $29, $2a, $2b | `LookupBallPosByShotIndex_*` |
| 7 | 31 | $20, $21, $22, $23, $29, $2a, $2b | `LookupBallPosByAim_*` |
| 7 | 22 | $0b | `NetGameMatch1AwardPointToSide`, `NetGameMatch2AwardPointToSide`, `NetGameMatch3AwardPointToSide`, `ServiceMatch2AwardPointToSide`, `ServiceMatch3AwardPointToSide`, `StrokeMatch2AwardPointToSide`, `StrokeMatch3AwardPointToSide` |
| 5 | 13 | $10, $11, $12, $13 | `AcademyMainBldgArrival01_10`, `RestaurantArrival01_10`, `MapArrivalWalk_11`, `DormEntranceArrival01_12`, `RestaurantPlazaArrival04_13` |
| 5 | 15 | $16, $17, $1b, $3b, $3e | `DrawAsciiDigitChar_*` |
| 5 | 12 | $16, $1b, $38, $3b, $3e | `GetMenuCursorIndex_*` |
| 4 | 31 | $0e, $11, $12, $27 | `ComputeRankingProgressIndex_*` |
| 4 | 43 | $1b, $38, $3b, $3e | `DrawCornerBrackets_*` |
| 4 | 26 | $17, $1b, $3b, $3e | `DrawDecimalNumber_*` |
| 4 | 11 | $16, $38, $3b, $3e | `SetMenuCursorFromIndex_*` |
| 3 | 13 | $10, $11, $12 | `AcademyMainBldgArrival02_10`, `AcademyArrivalArrival01_11`, `DormEntranceArrival02_12` |
| 3 | 31 | $13, $14, $15 | `ComputeRankingProgressIndex_*` |
| 3 | 12 | $1a, $1c, $1d | `DrawConfirmSelectionCursor_*` |
| 3 | 43 | $17, $1b, $3e | `DrawNameWithDiacritics_*` |
| 3 | 14 | $16, $3b, $3e | `GetCellIndexFromCursorPtr_*` |
| 3 | 74 | $16, $38, $3e | `MoveMenuCursorGridFromLinkInput_*` |
| 3 | 113 | $16, $38, $3e | `MoveMenuCursorGridRemote_*` |
| 3 | 74 | $38, $3b, $3e | `MoveMenuCursorGrid_*` |
| 3 | 30 | $0b | `NetGamePractice1HandlePointEnd`, `NetGamePractice2HandlePointEnd`, `NetGamePractice3HandlePointEnd` |
| 3 | 11 | $16, $38, $3e | `SetMenuCursorFromIndexToPtr_*` |
| 2 | 20 | $16, $17 | `ApplySpriteWobbleX_*` |
| 2 | 20 | $16, $17 | `ApplySpriteWobbleY_*` |
| 2 | 24 | $13, $15 | `ComputeStoryRankTier_*` |
| 2 | 43 | $38, $3b | `DrawNameWithDiacritics_*` |
| 2 | 28 | $3b, $3e | `FlushMatchFormatRowToVram`, `FlushMatchRuleRowAttrs` |
| 2 | 14 | $1b, $38 | `GetMenuCursorIndexFromPtr_*` |
| 2 | 14 | $6b | `IntroCutsceneState00Update_6b`, `IntroCutsceneState19Update_6b` |
| 2 | 72 | $0d | `IsBallInMedallionMatchHitZone`, `IsBallInTreasureBoxHitZone` |
| 2 | 11 | $0f | `IslandOpenFinalDoublesNpc0B_0f`, `IslandOpenRound1DoublesNpc0B_0f` |
| 2 | 11 | $0f | `IslandOpenRound1DoublesNpc0D_0f`, `IslandOpenSemifinalDoublesNpc0D_0f` |
| 2 | 11 | $0f | `IslandOpenRoundDoublesNpc04_0f`, `IslandOpenRoundSinglesNpc04_0f` |
| 2 | 21 | $14, $15 | `LoadCourtPlayerPartnerObjDefs_14`, `SetPlayerPartnerActorSprites` |
| 2 | 31 | $24, $2c | `LookupBallPosByAim_*` |
| 2 | 27 | $3b, $3e | `MatchFormatSlideOut`, `CloseMatchRulesPanel` |
| 2 | 12 | $0e, $15 | `MirrorPlayerSpriteIfLeftHanded`, `TogglePlayerSpriteXFlip` |
| 2 | 112 | $16, $3e | `MoveMenuCursor2GridRemote_*` |
| 2 | 74 | $17, $1b | `MoveMenuCursorGridFromLinkInput_*` |
| 2 | 74 | $17, $1b | `MoveMenuCursorGrid_*` |
| 2 | 14 | $0d | `ProjectMedallionMatchWorldPosition`, `ProjectTreasureBoxWorldPosition` |
| 2 | 19 | $0f, $10 | `ReadSceneTilemapTile_*` |
| 2 | 13 | $13, $14 | `RestaurantPlazaArrival06_13`, `Court2EntryWalkIn` |
| 2 | 11 | $20, $21 | `ShotBallPathSlice`, `ShotBallPathPowerSlice` |
| 2 | 11 | $22, $23 | `ShotBallPathTopspin`, `ShotBallPathPowerTopspin` |
| 2 | 21 | $08, $0d | `SnapCameraTo`, `SnapCameraTo_0d` |
| 2 | 64 | $0b, $0d | `StartDrillFromDefinition`, `InitMinigameFromConfig` |
| 2 | 29 | $0b | `StrokePractice1Cases2`, `StrokePractice3Cases2` |
| 2 | 34 | $0b | `StrokePractice1EvaluateResult`, `StrokePractice3EvaluateResult` |
| 2 | 30 | $0b | `StrokePractice1HandlePointEnd`, `StrokePractice3HandlePointEnd` |
| 2 | 11 | $0d | `TennisMachine4Hook_PointStart`, `TennisMachineHighScoreHook_PointStart` |

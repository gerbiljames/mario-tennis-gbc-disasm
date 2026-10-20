; Data records and pointer tables: slot tables, tile blocks, the tunable record rows, menus, sprite templates.

; One (slot, bank) word per argument, naming a $4000-table slot by its
; FarPtr_*/DataPtr_* label -- farcall's operand encoding. Used by slot-record
; tables such as ScreenAssetRecordTable.
MACRO dslot
	REPT _NARG
	db LOW(\1), BANK(\1)
	ASSERT HIGH(\1) == SLOT_TABLE_PAGE, "\1 is outside its bank's $4000 slot table"
	SHIFT
	ENDR
ENDM

; One row of TileBlockPtrs_39, the table LoadCompressedTileBlock indexes with
; b: the slot word for DataPtr_<name>, and TILEBLOCK_<name>, its index (`ld b,
; TILEBLOCK_WinLoseArrowGfx`). Inserting a row renumbers the rows after it.
MACRO tileblock
DEF TILEBLOCK_\1 EQU (@ - TileBlockPtrs_39) / 2
EXPORT TILEBLOCK_\1
	dslot DataPtr_\1
ENDM

; One row of ScreenAssetRecordTable, the table LoadScreenAssetRecord indexes
; with c: `screen_asset Name, tiles, tilemap, attrmap, palettes` writes the
; four slot words and SCREENASSET_Name, the record's index.
MACRO screen_asset
DEF SCREENASSET_\1 EQU (@ - ScreenAssetRecordTable) / 8
EXPORT SCREENASSET_\1
	dslot \2, \3, \4, \5
ENDM

; One StoryCharacterRecords_02 row: the 29 bytes InitMatchRecordFromCharId
; copies into a character record at +$0f-+$2b and LoadCharacterAttributes
; turns into the wChar*/wAi* fields (docs/match_engine.md "Character stats
; into the engine").
;   char_stats_row strategy, reach_h, reach_x, smash_jump, dive, tier, swing,
;                  delay_near, delay_far, tracking, aim_away, serve_style,
;                  Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed,
;                  Dash, Reaction, Stop, speed_bonus
MACRO char_stats_row
	db \1
	dw \2, \3, \4, \5
	db \6
	dw \7
	db \8, \9, \<10>, \<11>, \<12>
	db \<13>, \<14>, \<15>, \<16>, \<17>, \<18>, \<19>, \<20>, \<21>, \<22>, \<23>
	db \<24>
ENDM

; One ShotTypePresets_07 row, read by ApplyShotTypePresets: the contact sound,
; the ApplyShotRecoil variant, the SetBallTrailColor index and the nominal
; landing depth past the net that ComputeShotTrajectory aims at.
;   shot_preset sound, recoil, trail, depth
MACRO shot_preset
	db \1, \2, \3
	dw \4
ENDM

; One CpuDifficultyParams* row: the four AI bytes ApplyCpuDifficultyToCharRecords
; writes to a CPU record's +$1b-+$1e (frames of inertness after a stroke near
; the net and away from it, the tracking countdown, the aim-away RNG threshold),
; then the partner's difficulty and EXP tier.
;   cpu_difficulty delay_near, delay_far, tracking, aim_away, partner_difficulty, partner_tier
MACRO cpu_difficulty
	db \1, \2, \3, \4, \5, \6
ENDM

; One equipment row (RacketStatDeltas_02 / ShoeStatDeltas_02): the signed
; delta ApplyStatModifierRow adds to each of the eleven stat bars, padded to
; the 16-byte stride.
;   equip_stat_deltas Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
MACRO equip_stat_deltas
	db \1, \2, \3, \4, \5, \6, \7, \8, \9, \<10>, \<11>, 0, 0, 0, 0, 0
ENDM

; One stat's nine ascending signed thresholds in a StatArchetype*_02 table:
; LookupStatBarLevel counts how many the scaled level clears, which is the
; 0-9 bar.
MACRO stat_thresholds
	db \1, \2, \3, \4, \5, \6, \7, \8, \9
ENDM

; One ExpLevelThresholds_02 entry: the cumulative EXP that reaches the level,
; as the 24-bit little-endian accumulator AddExpCapped keeps.
MACRO exp_threshold
	db LOW(\1), HIGH(\1), (\1) >> 16
ENDM

; One story match's settings (Singles/DoublesMatchSettingsTable_0a, indexed
; by STORYMATCH_* id; LoadMatchSettingsFromTable): the game mode, the opponent
; (a CHAR_* id), the court, sets and games (one packed byte), and the music.
;   match_settings mode, opponent, court, sets, games, bgm
MACRO match_settings
	db \1, \2, \3, ((\4) << 4) | (\5), \6
ENDM

; A training drill's per-outcome rows: ten entries indexed by wPointOutcome --
; 0 undecided, then POINTOUTCOME_FAULT, DOUBLE_FAULT, LET, NET, OUT, WINNER,
; SERVE_VOLLEYED, WRONG_RECEIVER, BALL_HIT_PLAYER. *Messages rows hold the
; DRILLMSG_* id for the player serving (QueueDrillResultMessage adds an offset
; otherwise); *Verdicts rows hold the WINLOSE_* the point gives.
MACRO drill_messages
	ASSERT _NARG == 10, "drill_messages takes 10 entries"
	db \1, \2, \3, \4, \5, \6, \7, \8, \9, \<10>
ENDM

MACRO drill_verdicts
	ASSERT _NARG == 10, "drill_verdicts takes 10 entries"
	db \1, \2, \3, \4, \5, \6, \7, \8, \9, \<10>
ENDM

; One court-position record (GamePosition*, TiebreakPosition*; LoadPositionRecord),
; and one point of a minigame point table (*PointTable; LoadMinigamePointLayout
; installs it, stopping at a first byte of $ff): the COURTPOS_* code
; (wCharCourtPos) for characters 0-3, then their SERVEROLE_* codes
; (wCharServeRole).
;   court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
MACRO court_positions
	db \1, \2, \3, \4, \5, \6, \7, \8
ENDM

; One point of a training drill's *GatePositions table
; (SetDrillGateForPoint): the two ball-gate points the drill sets for
; that point, each an X and a depth in court units. The list ends on $ff, $ff.
;   drill_gates x1, depth1, x2, depth2
MACRO drill_gates
	dw \1, \2, \3, \4
ENDM

; One training drill (DrillDefinitionPtrs; StartDrillFromDefinition reads it
; through the DRILLDEF_* offsets). Bytes 6, 14 and 15 are never read.
;   drill_def opponent, court, chars, mode, match, bgm, player, hooks, point_table, init
MACRO drill_def
	db \1, \2, \3, \4, \5, \6, $00, \7
	dw \8, \9
	SHIFT
	dw \9
	db $00, $00
ENDM

; One Target Shot scoring rule (TargetShotScoreRules; LookupMinigameShotResult
; walks them to the first match): the target zone (wMinigameTargetZone), the
; button combination (wLastShotButtons), the shot type it applies to
; (SHOTTYPE_*, or $ff for any) and the points awarded. The list ends on $ff.
;   score_rule zone, buttons, shot, points
MACRO score_rule
	db \1, \2, \3, \4
ENDM

; One match-screen object template (bank $09's *ObjTemplate* tables;
; LoadObjTemplate_09 copies it into a wObjSlot): where the object appears,
; the sprite template it draws (0 = set by the caller), the per-frame
; update routine and the move curve it steps (MoveCurveTable_09 index), the
; routine and curve StartObjExitAnim switches to when the object leaves,
; the sound played when it appears (0 = none), and the draw mode (0 = at
; the stored position, 1 = relative to the serving character).
;   obj_template x, y, sprite_template, update, curve, exit_update, exit_curve, sound, draw_mode
MACRO obj_template
	db \1, \2
	dw \3, \4, \5, \6, \7, \8, \9
ENDM

; One CourtSceneDataTable row, indexed by court id: the two surface damping
; bytes LoadCourtSceneData stores (wCourtSurfaceFriction, wCourtSurfaceBounce),
; the scene index handed to LoadCourtSceneGraphics, and a byte nothing reads.
;   court_scene friction, bounce, scene, unused
MACRO court_scene
	db \1, \2, \3, \4
ENDM

; One row of ObjectIdList_04, the table LoadActorObjectDef indexes with an
; object id: the slot word of the object's header and OBJ_<name>, its index,
; exported so a map_actor row or a load reads `OBJ_HARRY`. The index is the
; row's position, so inserting a row renumbers everything after it.
MACRO object_id
DEF OBJ_\1 EQU (@ - ObjectIdList_04) / 2
EXPORT OBJ_\1
	dslot \2
ENDM

; One $4000 pointer-table entry: defines the FarPtr_<suffix> label and the dw
; slot that farcall's operand bytes index. One arg when the target symbol is
; the suffix (farptr RunMatch -> FarPtr_RunMatch: dw RunMatch); two when they
; differ (farptr 24_0a, Unused_24_StubNop).
MACRO farptr
IF _NARG == 1
FarPtr_\1: dw \1
ELSE
FarPtr_\1: dw \2
ENDC
ENDM

; One entry of a flag-id list (the `flag_ids` data spec): the same two bytes
; a set_flag/test_flag operand carries, as a word.
; Usage: `flag_id FLAG_NAME` or `flag_id byte_index, bit`.
MACRO flag_id
IF _NARG == 1
	ASSERT (\1) < NUM_GAME_FLAGS, "game flag \1 is past wGameFlags"
	dw (((\1) / 8) << 8) | (((\1) % 8) << 5)
ELSE
	dw ((\1) << 8) | ((\2) << 5)
ENDC
ENDM

; Sound/music index entry (PlaySound): the first byte packs the voice count
; (high nibble) and the data bank's low nibble (bank = $70 | nibble); the
; second is the first of `voices` consecutive records in that bank's
; SoundTable_*.
; Usage: sound_entry bank, voices, record
MACRO sound_entry
	db ((\2) << 4) | ((\1) & $0f), \3
ENDM

; palette r,g,b, r,g,b, r,g,b, r,g,b -- one CGB palette, four colours of
; 5-bit components, as BGR555 words. A palette whose words use bit 15 stays
; a plain dw.
MACRO palette
	ASSERT _NARG == 12, "palette takes four colours of three components"
	FOR _CH, 1, 13
		ASSERT 0 <= (\<_CH>) && (\<_CH>) <= 31, "palette: component {d:_CH} out of 0-31"
	ENDR
	dw (\1) | ((\2) << 5) | ((\3) << 10), (\4) | ((\5) << 5) | ((\6) << 10), (\7) | ((\8) << 5) | ((\9) << 10), (\<10>) | ((\<11>) << 5) | ((\<12>) << 10)
ENDM

; One rules screen's page list (ShowRulesPageSequence): the page
; offsets, added to the screen's base text id, that it walks until the $ff
; terminator. The lists sit in a fixed-stride array, so `rules_pages_stride`
; declares the stride once and `rules_pages` pads each list out to it with the
; terminator byte.
; Usage: rules_pages_stride bytes / rules_pages page, ...
MACRO rules_pages_stride
DEF _RP_W = \1
ENDM

MACRO rules_pages
	ASSERT _NARG < _RP_W, "rules_pages: no room for the $ff terminator"
	db \#
	ds _RP_W - _NARG, $ff
ENDM

; One menu of the match/story pause menu system: the item ids it lists, in
; display order. The 8-byte record is {id0..id3, count, $00 x3}; the count
; (read at +4 by GetMatchMenuItemCount/GetStoryMenuItemCount) is derived from
; the arguments.
; Usage: menu_def item, ... (1-4 items)
MACRO menu_def
	db \#
	ds 4 - _NARG, $00
	db _NARG
	ds 3, $00
ENDM

; The tile and attribute blocks of one rectangle whose geometry is fixed by the
; drawing code rather than stored (e.g. the 3x2 menu item labels, drawn with
; `ld bc, $0302`). One record per menu item id.
; Usage: rect_ptrs tiles, attrs
MACRO rect_ptrs
	dw \1, \2
ENDM

; CopyTextRectPair descriptor: the geometry plus the tile and attribute blocks
; of one rectangle (both `tilemap_begin width, height` blocks of the same size).
; Usage: rect_pair height, width, tiles, attrs
MACRO rect_pair
	db \1, \2
	dw \3, \4
ENDM

; QueueSpriteTemplate sprite record: one hardware sprite as {dy, dx,
; tile, attr} deltas added to the base position/tile/attr passed in the call.
; A list ends with oam_sprite_end (a $80 dy byte, which the loader stops on).
; Usage: oam_sprite dy, dx, tile, attr
MACRO oam_sprite
	db \1, \2, \3, \4
ENDM

MACRO oam_sprite_end
	db $80
ENDM

; Match-result graphics set (bank $16 loader): three LZ tile streams
; decompressed to VRAM $8900, $8a40, $9140 (20 tiles each). Records live in
; MatchResultBannerSetTable and are selected by the remapped match gfx index.
; Usage: gfx_set series_line, event_line, round_label
MACRO gfx_set
	dw \1, \2, \3
ENDM

; One run of a tilemap patch list: copy `length` bytes from the source row
; (bc) + `src` to cell (`col`, `row`) of wCharDataScreenCell, tile and
; attribute planes. The readers are BlitTilemapRunsFromTable,
; ApplyTilemapPatchListExpScreen, ApplyTilemapPatchList and its _1a copy.
; A $ff byte ends the list.
;   blit_run col, row, src, length
MACRO blit_run
	ASSERT (\1) < TILEMAP_WIDTH && (\2) * TILEMAP_WIDTH + (\1) < $ff00, "blit_run: bad cell"
	db HIGH((\2) * TILEMAP_WIDTH + (\1)), LOW((\2) * TILEMAP_WIDTH + (\1)), \3, \4
ENDM

; One run of a bank $09 move curve (MoveCurveTable_09; GetNextMoveCurveValue):
; the signed X offset, in pixels, of each step of the object's slide.
; move_curve_hold ($80) keeps the object where the curve left it;
; move_curve_end ($81) frees its slot.
; Usage: move_curve dx, ...
MACRO move_curve
	REPT _NARG
	ASSERT (\1) >= -126 && (\1) <= 127, "move_curve: \1 would read as the hold or end marker"
	db \1
	SHIFT
	ENDR
ENDM

MACRO move_curve_hold
	db $80
ENDM

MACRO move_curve_end
	db $81
ENDM

; Bytes 2-5 of a story scene config, the only ones LoadStorySceneGraphics
; reads: the scroll origin (wMapScrollMinX/Y) and the map size in tiles
; (wMapWidthTiles/HeightTiles).
; Usage: scene_bounds min_x, min_y, width, height
MACRO scene_bounds
	db \1, \2, \3, \4
ENDM

; The tile-animation list from byte 8 of a story scene config
; (InitSceneTileAnimations, AdvanceSceneTileAnimation). One step copies
; `count` tiles from tile `src` of the scene's slot-6 sheet to tile `dest` of
; vTiles2 + VRAM_BANK1 and holds for `delay` frames. Init finds the markers by
; scanning single bytes, so no field may be $fe or $ff.
; Usage: scene_tile_anim src, count, dest, delay
MACRO scene_tile_anim
	REPT 4
	ASSERT (\1) < $fe, "scene_tile_anim: \1 would read as a list marker"
	db \1
	SHIFT
	ENDR
ENDM

; Closes an animation (it loops to its first step). The next animation's first
; step waits first_delay + 1 frames; the byte is consumed even before the end.
; Usage: scene_tile_anim_loop first_delay
MACRO scene_tile_anim_loop
	db $ff, \1
ENDM

MACRO scene_tile_anim_end
	db $fe
ENDM

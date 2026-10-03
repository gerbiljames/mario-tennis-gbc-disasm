; The idioms the code is built from, each expanding to the original bytes
; (README "Reading the source"). Hand-maintained.

; Bank-switched call through the FarCall trampoline ($01b6, vectored from
; rst $18): two inline operand bytes select a dw entry in the target bank's
; pointer table at $4000 (FarPtr_* labels). The trampoline switches banks,
; dispatches through the table, and patches the return address past the
; operands.
MACRO farcall
	rst Rst18
	db LOW(FarPtr_\1), BANK(FarPtr_\1)
	ASSERT HIGH(FarPtr_\1) == SLOT_TABLE_PAGE, "FarPtr_\1 is outside its bank's $4000 slot table"
ENDM

; A SoundTable entry's first word: which sound-engine channel struct the
; track drives (StartSoundChannel indexes wSndChannels by the low byte, which
; is always $20-aligned) and the byte it stores into that struct. Written as
; the decoded fields so the row is derived structure, not a ROM value.
MACRO snd_channel
	db (\1) * $20, \2
ENDM

; Sound/music command (handler $2fb3): one inline id byte.
MACRO sound
	rst Rst08
	db \1
ENDM

; One (slot, bank) word per argument, referencing a $4000-table slot by its
; FarPtr_*/DataPtr_* label -- the same encoding as farcall's operand bytes.
; Used by slot-record tables (e.g. ScreenAssetRecordTable) whose loaders
; read the words through RAM.
MACRO dslot
	REPT _NARG
	db LOW(\1), BANK(\1)
	ASSERT HIGH(\1) == SLOT_TABLE_PAGE, "\1 is outside its bank's $4000 slot table"
	SHIFT
	ENDR
ENDM

; One row of TileBlockPtrs_39, the table LoadCompressedTileBlock indexes with
; b: the slot word for DataPtr_<name>, and TILEBLOCK_<name>, its index,
; exported so a call site reads `ld b, TILEBLOCK_MatchWinLoseGfx`. The index
; is the row's position, so inserting a row renumbers everything after it
; and every site follows.
MACRO tileblock
DEF TILEBLOCK_\1 EQU (@ - TileBlockPtrs_39) / 2
EXPORT TILEBLOCK_\1
	dslot DataPtr_\1
ENDM

; One row of ScreenAssetRecordTable, the table LoadScreenAssetRecord indexes
; with c: `screen_asset Name, tiles, tilemap, attrmap, palettes` writes the
; four slot words and SCREENASSET_Name, the record's index, exported so a
; call site reads `ld c, SCREENASSET_TitleScreen`.
MACRO screen_asset
DEF SCREENASSET_\1 EQU (@ - ScreenAssetRecordTable) / 8
EXPORT SCREENASSET_\1
	dslot \2, \3, \4, \5
ENDM

; --- Shot-solver trajectory rows (data/bank_02x/<Table>.asm, generated at setup) ---
; One row of a ballistic-solution table (docs/match_engine.md "The trajectory
; tables"): the launch speed magnitude, which the row search keys on and
; which rises with the row, the launch elevation angle, and, in the six-byte
; tables, the lateral aim delta added to wShotAimAngle. Rows are 64 units of
; distance apart; a block is one contact-height band or placement variant.
MACRO traj_row ; speed, elevation, lateral delta
	dw \1, \2, \3
ENDM

MACRO traj_row4 ; speed, elevation
	dw \1, \2
ENDM

; --- Sound channel scripts (data/bank_07x/<Track>.asm, generated at setup) ---
; Every command is two bytes, opcode then operand, and the driver steps them
; by command index (RunSoundChannelScript $00:$3558; docs/sound_engine.md
; "Script command set"). snd_call is the one four-byte command: its target
; word is the byte offset of a command from the track's start, which
; snd_track supplies. Note names C_ .. B_ are in constants.inc; the octave
; is how many times the driver halves the table period.
MACRO snd_track ; the track label the snd_call offsets are relative to
REDEF _snd_track EQUS "\1"
ENDM

MACRO snd_note ; note, octave, length in ticks
	db ((\2) << 4) | (\1), \3
ENDM

MACRO snd_hold ; octave nibble (unused), length: keeps the sounding note, or silence
	db ((\1) << 4) | $0f, \2
ENDM

MACRO snd_noise ; noise value (< $10 indexes NoiseNoteTable, else raw), length
	db \1, \2
ENDM

MACRO snd_volume ; volume nibble (applied through the channel envelope)
	db $a0, \1
ENDM

MACRO snd_wave ; wave-pattern id (wave channel) / sweep register value (pulse)
	db $a1, \1
ENDM

MACRO snd_duty ; duty (pulse) / envelope length (wave)
	db $a2, \1
ENDM

MACRO snd_note_length ; note-length reload; $fe clears it
	db $a3, \1
ENDM

MACRO snd_detune ; signed note offset, bit 7 = active
	db $a4, \1
ENDM

MACRO snd_pan ; stereo mask; $01 swaps the current mask's nibbles
	db $a5, \1
ENDM

MACRO snd_master_volume ; written straight to rAUDVOL
	db $a6, \1
ENDM

MACRO snd_glide ; note timer without a key-on
	db $a7, \1
ENDM

MACRO snd_instrument ; instrument-envelope index (high nibble also picks the wave set)
	db $a8, \1
ENDM

MACRO snd_transpose ; semitones; $f0-$f3 step the channel/global transpose, $fe/$ff read a jump table
	db $a9, \1
ENDM

MACRO snd_echo ; echo count (high nibble) and note offset (low); 0 clears
	db $aa, \1
ENDM

MACRO snd_call ; count, target -- run the block at target `count` times, snd_return comes back here
	db $ac, \1
	dw (\2) - {_snd_track}
ENDM

MACRO snd_return
	db $ad, $00
ENDM

MACRO snd_tone_flag ; bit 4 selects the upper octave of NotePeriodTable
	db $ae, \1
ENDM

MACRO snd_length_nibble ; note-length increment, low nibble of hSndToneCtrl
	db $af, \1
ENDM

MACRO snd_loop_point ; slot 0-15: remembers the next command for snd_loop / snd_jump
	db $fd, $f0 | (\1)
ENDM

MACRO snd_loop ; count 1-15, slot: go back to the slot's point until the block has run count + 1 times
	db $b0 | (\1), $f0 | (\2)
ENDM

MACRO snd_jump ; slot: go back to the slot's point unconditionally
	db $b0, $f0 | (\1)
ENDM

MACRO snd_envelope ; rate 0-15, length: instrument-envelope sweep
	db $c0 | (\1), \2
ENDM

MACRO snd_volume_up ; step 0-15, period: volume slide up
	db $d0 | (\1), \2
ENDM

MACRO snd_volume_down ; step 0-15, period: volume slide down
	db $e0 | (\1), \2
ENDM

MACRO snd_end
	db $ff, $ff
ENDM

; --- Shared routine families (src/twins/) ---
; The ROM assembles the same routine into several banks. Each such family is
; one file under src/twins/, and every bank that holds a copy assembles it
; here: `twin file, 25` includes src/twins/file.asm with {TWIN} = "25", so
; `FetchText_{TWIN}:` and the bank-local references in the body become that
; bank's; `twin_named file, Label` includes it with {TWIN_LABEL} = Label for
; the copies that carry different names. The bytes are the copies' own.
MACRO twin
DEF TWIN EQUS "\2"
	INCLUDE "src/twins/\1.asm"
PURGE TWIN
ENDM

MACRO twin_named
DEF TWIN_LABEL EQUS "\2"
	INCLUDE "src/twins/\1.asm"
PURGE TWIN_LABEL
ENDM

; twin_in file, Label, bank: both at once, for a body that carries its own
; name in each bank and references that bank's tables by suffix.
MACRO twin_in
DEF TWIN_LABEL EQUS "\2"
DEF TWIN EQUS "\3"
	INCLUDE "src/twins/\1.asm"
PURGE TWIN
PURGE TWIN_LABEL
ENDM

; --- Tunable record tables (one macro row per record, fields in order) ---

; One StoryCharacterRecords_02 row: the 29 bytes InitCa00RecordFromCharId
; copies into a character record at +$0f-+$2b and LoadCharacterAttributes
; turns into the wChar*/wAi* struct fields (docs/match_engine.md "Character
; stats into the engine"). Words are little-endian.
;   char_record strategy, reach_h, reach_x, smash_jump, dive, tier, swing,
;               delay_near, delay_far, tracking, aim_away, serve_style,
;               Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed,
;               Dash, Reaction, Stop, speed_bonus
MACRO char_record
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
; by the STORYMATCH_* id; LoadMatchSettingsFromTable): the game mode,
; the opponent (a CHAR_* id, extended ones included), the court, sets and games (one packed byte), and the music.
;   match_settings mode, opponent, court, sets, games, bgm
MACRO match_settings
	db \1, \2, \3, ((\4) << 4) | (\5), \6
ENDM

; A training drill's per-outcome byte row: ten entries indexed by
; wPointOutcome -- 0 undecided, then POINTOUTCOME_FAULT, DOUBLE_FAULT, LET,
; NET, OUT, WINNER, SERVE_VOLLEYED, WRONG_RECEIVER, BALL_HIT_PLAYER -- a
; message id ($ff = none) in the *DrillShotTable rows, a signed verdict in
; the SignedTable_0b_* rows.
MACRO drill_outcomes
	db \1, \2, \3, \4, \5, \6, \7, \8, \9, \<10>
ENDM

; One court-position record (GamePosition*, TiebreakPosition*; LoadPositionRecord),
; and one point of a minigame point table (*PointTable; LoadMinigamePointLayout
; installs it and stops at a record whose first byte is $ff): the
; court-position code (wCharCourtPos: bit 1 = which end, bit 0 = which
; lateral half) for characters 0-3, then their serve/side role codes
; (wCharServeRole: 0 server, 1 receiver, 2/3 partners, $09 unused slot).
;   court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
MACRO court_positions
	db \1, \2, \3, \4, \5, \6, \7, \8
ENDM

; One point of a training drill's *PointStartDrillPositions table
; (IndexDrillTableByPoint): the two ball-gate points the drill sets for
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
; walks them to the first match): the shot roll (wMinigameShotRoll), the
; button combination (wLastShotButtons), the shot type it applies to
; (SHOTTYPE_*, or $ff for any) and the points awarded. The list ends on $ff.
;   score_rule roll, buttons, shot, points
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

; ld_slot hl, DataPtr_X: hl = the (slot, bank) pair of a $4000-table entry,
; the operand LoadCompressedTileBlock-style loaders take in a register.
MACRO ld_slot
	ld \1, (BANK(\2) << 8) | LOW(\2)
	ASSERT HIGH(\2) == SLOT_TABLE_PAGE, "\2 is outside its bank's $4000 slot table"
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

; Game text (see the generated data/bank_XXX/text_*.asm): a string is db
; segments joined by control bytes -- $01 starts a new on-screen line, $02 a
; new page, $03 terminates. `text` opens a string (or continues an
; overlong segment), `line`/`page` emit the control byte plus the segment.
MACRO text
	db \#
ENDM

MACRO line
	db $01, \#
ENDM

MACRO page
	db $02, \#
ENDM

MACRO done
	db $03
ENDM

; rst $20/$28/$30 ($255e/$256b/$2551): set/clear/test a bit in the
; wGameFlags array ($c9c0+). Two inline operand bytes: the bit selector in
; the top 3 bits of the first (the handlers apply mask $80 >> bit to
; wGameFlags[byte]), the flag byte index in the second.
; Usage: `set_flag FLAG_NAME` (flag number, flag_constants.inc) or
; `set_flag byte_index, bit` where the flag has no name yet. A flag number
; is byte * 8 + bit, the same numbering *GameFlagByNumber ($24ef) takes.
MACRO set_flag
	rst Rst20
IF _NARG == 1
	db ((\1) % 8) << 5, (\1) / 8
ELSE
	db (\2) << 5, \1
ENDC
ENDM

MACRO clear_flag
	rst Rst28
IF _NARG == 1
	db ((\1) % 8) << 5, (\1) / 8
ELSE
	db (\2) << 5, \1
ENDC
ENDM

MACRO test_flag
	rst Rst30
IF _NARG == 1
	db ((\1) % 8) << 5, (\1) / 8
ELSE
	db (\2) << 5, \1
ENDC
ENDM

; One entry of a flag-id list (the `flag_ids` data spec): the same two bytes
; a set_flag/test_flag operand carries, as a word.
; Usage: `flag_id FLAG_NAME` or `flag_id byte_index, bit`.
MACRO flag_id
IF _NARG == 1
	dw (((\1) / 8) << 8) | (((\1) % 8) << 5)
ELSE
	dw ((\1) << 8) | ((\2) << 5)
ENDC
ENDM

; Sound/music index entry (PlaySound, $3297): selects one sound. The first
; byte packs the voice count (high nibble) and the data-bank low nibble
; (bank = $70 | nibble, i.e. $78-$7f); the second is the first channel
; record's index into that bank's SoundTable_* ((length, pointer) records,
; one per voice, `voices` consecutive records per sound).
; Usage: sound_entry bank, voices, record
MACRO sound_entry
	db ((\2) << 4) | ((\1) & $0f), \3
ENDM

; WRAM bank switch: writes rWBK (rSVBK) plus its HRAM shadow hWramBank.
; With an argument the bank id is loaded into a first -- a WRAM_* constant
; (constants.inc): the bank's owner (WRAM_TEXT, WRAM_SCENE, ...) or, in the
; match engine, the on-court character whose struct lives there (WRAM_CHAR0-3
; are banks 4-7). The bare form switches to the bank already in a.
MACRO wram_bank
	IF _NARG == 1
	ld a, \1
	ENDC
	ldh [hWramBank], a
	ldh [rWBK], a
ENDM

; Save the current WRAM bank on the stack and select another: the prologue
; nearly every banked routine opens with (`ldh a, [hWramBank] / push af /
; wram_bank N`). pop_wram_bank is the matching epilogue (`pop af / wram_bank`).
MACRO push_wram_bank
	ldh a, [hWramBank]
	push af
	wram_bank \1
ENDM

MACRO pop_wram_bank
	pop af
	wram_bank
ENDM

; hl =  + a. The split-base table index the game uses everywhere: the two
; halves of the address are 8-bit immediates, added with carry propagation
; (`sub l` recovers the carry from the low add), so the pair assembles to
; exactly the five instructions it replaces.
MACRO ld_hl_indexed
	add LOW(\1)
	ld l, a
	adc HIGH(\1)
	sub l
	ld h, a
ENDM

; de / bc = \1 + a: the same split-base index, landing in the other pairs.
MACRO ld_de_indexed
	add LOW(\1)
	ld e, a
	adc HIGH(\1)
	sub e
	ld d, a
ENDM
MACRO ld_bc_indexed
	add LOW(\1)
	ld c, a
	adc HIGH(\1)
	sub c
	ld b, a
ENDM

; WaitFramesCmd takes its frame count as an inline byte after the call and
; returns past it; the byte is an argument, not the next instruction.
MACRO wait_frames
	call WaitFramesCmd
	db \1
ENDM

; palette r,g,b, r,g,b, r,g,b, r,g,b -- one CGB palette, four colours of
; 5-bit components, assembled to the BGR555 words the hardware takes. A
; palette whose words use bit 15 (five in the ROM) stays a plain dw.
MACRO palette
	dw (\1) | ((\2) << 5) | ((\3) << 10), (\4) | ((\5) << 5) | ((\6) << 10), (\7) | ((\8) << 5) | ((\9) << 10), (\<10>) | ((\<11>) << 5) | ((\<12>) << 10)
ENDM

; lb pair, hi, lo -- load two bytes into a register pair with one 16-bit
; immediate. The building block of the named pair macros below (ld_xy,
; ld_cell, ld_oam, ld_size, ld_tile_run, ld_bg_pals/ld_obj_pals); a site whose
; callee reads the halves separately uses the one that names them.
MACRO lb
	ld \1, ((\2) << 8) | (\3)
ENDM

; ld_xy pair, x, y -- a sprite's screen position as the sprite routines take
; it: x in the high register, y in the low. QueueSprite writes e (+$0c) as
; the OAM Y byte and d (+$04) as the X byte; every helper that offsets a
; position on its way there follows the same order.
MACRO ld_xy
	lb \1, \2, \3
ENDM

; ld_oam pair, attr, tile -- a sprite's OAM attribute byte and tile id as
; QueueSprite and QueueSpriteTemplate take them: the attribute in the high
; register (CGB palette in bits 0-2, plus OAM_BANK1 / OAM_XFLIP / OAM_YFLIP /
; OAM_PRIO from hardware.inc), the tile in the low. QueueSpriteTemplate adds
; both to every entry of the template, and bit 5 picks its mirrored copy.
MACRO ld_oam
	lb \1, \2, \3
ENDM

; ld_size pair, width, height -- a rectangle in tile cells as the window and
; text-rect routines take it (CreateWindow, CopyTextRect, ...): the width in
; the high register, the height in the low.
MACRO ld_size
	lb \1, \2, \3
ENDM

; ld_tile_run pair, tile, count -- FillTilemapRun's arguments: the tile id it
; writes to each cell in the high register, the number of cells in the low.
MACRO ld_tile_run
	lb \1, \2, \3
ENDM

; The same pairs where the code loads the halves with two instructions
; instead of one: the macro names the order it emits them in.
; rect_size width, height -- ld b, width / ld c, height (FillTilemapRect,
; CopyTilemapRect, CreateWindowFromScreenRect: the width is the inner loop)
MACRO rect_size
	ld b, \1
	ld c, \2
ENDM
; rect_cell column, row -- ld d, column / ld e, row: a screen-rect origin
MACRO rect_cell
	ld d, \1
	ld e, \2
ENDM
; map_cell x, y -- ld d, x / ld e, y: a story-map tile, the high byte of a
; map position (WriteBehaviorMapCell halves both for the 16-pixel cells)
MACRO map_cell
	ld d, \1
	ld e, \2
ENDM
; sprite_xy x, y -- ld d, x / ld e, y (QueueSprite and friends)
MACRO sprite_xy
	ld d, \1
	ld e, \2
ENDM
; sprite_attr_tile attr, tile -- ld b, attr / ld c, tile
MACRO sprite_attr_tile
	ld b, \1
	ld c, \2
ENDM
; sprite_tile_attr tile, attr -- ld c, tile / ld b, attr
MACRO sprite_tile_attr
	ld c, \1
	ld b, \2
ENDM

; ld_bg_pals pair, first, count / ld_obj_pals pair, first, count -- a run of
; CGB palettes as LoadPaletteShadow and its siblings take it: the palette
; index in the high register (0-7 background, 8-15 objects; the loader tests
; bit 3 to pick the half) and the count in the low.
MACRO ld_bg_pals
	ASSERT (\2) + (\3) <= 8, "background palettes run past 7"
	lb \1, \2, \3
ENDM
MACRO ld_obj_pals
	ASSERT (\2) + (\3) <= 8, "object palettes run past 7"
	lb \1, 8 + (\2), \3
ENDM

; ld_cell pair, column, row -- a tile cell as the text and window routines
; take it, on the background map or inside a window: the column in the high
; register, the row in the low.
MACRO ld_cell
	lb \1, \2, \3
ENDM

; ld_flag_id pair, FLAG_NAME -- the (byte << 8) | (bit << 5) form of a game
; flag that Set/Clear/TestGameFlag take in de, from the flag number the
; *ByNumber helpers and set_flag/test_flag use.
MACRO ld_flag_id
	ld \1, ((((\2) / 8) << 8) | (((\2) % 8) << 5))
ENDM

; --- Story-mode map-script tables (banks $0e-$15) ---
; Each story location owns a 7-word directory (a map_tree) copied to $c286.
; The words point at the location's sub-tables, one per slot, consumed by the
; bank $0a overworld engine:
;   0 EntryPoints (map_entry)    - spawn record per entry point / warp id
;   1 ExitTriggers (map_script)  - RunLocationExit
;   2 Actors (map_actor)         - the location's NPC/prop actor list
;   3 NpcScripts (map_script)    - RunNpcInteraction (talk)
;   4 FacingScripts (map_script) - RunFacingTileScript (action button vs tile)
;   5 TileTriggers (map_script)  - RunTileTriggerScript (step-on)
;   6 InitScript                 - RunLocationInitScript (code)
; Slots with no table point at a shared $ff (an empty list) or at slot 6's
; init code.

; Actor spawn template (14 bytes, list terminated by a $ff sentinel byte).
; SpawnActorFromTemplate ($04:$4c60) spawns `objdef` unless `cond` is met,
; then seeds the actor's position, facing, object id, animation, and (if
; nonzero) a palette override. `facing` is a FACE_* constant (constants.inc).
; Usage: map_actor cond, objdef, x, y, facing, obj_id, anim, palette[, NAME]
; InitLocationActors spawns the player, its shadow and the companion into
; slots 0-2 and then the list in order, a row whose cond fails still taking
; its slot as an idle actor, so row n is actor slot 3 + n. NAME defines
; ACTOR_NAME as that slot, and the scripts address the actor by it: inserting
; or reordering rows renumbers them.
MACRO map_actor
IF !DEF(_MAP_ACTOR_ROW)
DEF _MAP_ACTOR_ROW = 0
ENDC
IF _NARG == 9
DEF ACTOR_\9 EQU _MAP_ACTOR_ROW + 3
EXPORT ACTOR_\9
ENDC
DEF _MAP_ACTOR_ROW += 1
	map_pos \3, \4
	dw \1, \2, (\3) >> 8, (\4) >> 8
	db \5, $00, \6, \7, \8, $00
ENDM

; Names an actor slot by what it is for in a scene, where the lists that can
; be active there hold different actors (or the same character under different
; scripts) in it: `actor_role ISLAND_OPEN_OPPONENT, $0a, List, List...` defines
; ACTOR_ROLE_ISLAND_OPEN_OPPONENT = $0a. The lists are not assembled;
; tools/actorslots.py holds every use to them (include/actor_roles.inc).
MACRO actor_role
DEF ACTOR_ROLE_\1 EQU \2
ENDM

; Terminates a map_actor list: nine $00 bytes then the $ff sentinel that
; SpawnActorsFromList ($04:$4cf7) stops on (it reads template byte 9).
MACRO map_actor_end
DEF _MAP_ACTOR_ROW = 0
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff
ENDM

; --- Actor-script bytecode (the `objdef` blobs a map_actor points at) ---
; SpawnActor ($04:$4055) installs the blob as the actor's script pointer
; (state +$00/+$01 = address, +$02 = bank). StepActorScript ($04:$4229) runs it
; each frame: it reads a 1-byte opcode and dispatches through the 22-entry
; handler table at $04:$447d. Each opcode advances the script pointer past its
; operands; a handler returns 0 to yield for this frame or nonzero to run the
; next opcode immediately. A script is a pool of fragments, each ending in an
; as_jump back-edge (an infinite loop); different actors/states enter at
; different offsets. Coordinates are 16-bit fixed-point map units. See
; docs/actor_script.md for the full opcode reference.
MACRO as_halt        ; $00 inert: yield forever (no pointer advance)
	db $00
ENDM
MACRO as_wait        ; $01 wait `n` frames (state +$03 = n-1), then yield
	db $01, \1
ENDM
MACRO as_wait_move   ; $02 yield until the current move finishes (+$05 bit7)
	db $02
ENDM
MACRO as_set_pos     ; $03 teleport: set current position -> state +$0c/+$0e, clears the +$05 bit7 move flag
	map_pos \1, \2
	db $03
	dw (\1) >> 8, (\2) >> 8
ENDM
MACRO as_set_target  ; $04 set move target -> state +$08/+$0a, sets the +$05 bit7 move flag
	map_pos \1, \2
	db $04
	dw (\1) >> 8, (\2) >> 8
ENDM
MACRO as_halt5       ; $05 inert (handler alias of $00)
	db $05
ENDM
MACRO as_target_rel  ; $06 offset the move target by (dx, dy), in tiles with a point (4.0, -2.0)
	map_offset \1, \2
	db $06
	dw (\1) >> 8, (\2) >> 8
ENDM
MACRO as_move        ; $07 move by angle (byte) + distance (word), absolute
	db $07, \1
	dw \2
ENDM
MACRO as_move_rel    ; $08 move by angle + distance, angle relative to facing
	db $08, \1
	dw \2
ENDM
MACRO as_rand_box    ; $09 pick a random reachable point in a box (gated on +$30 bit7)
	db $09, \1, \2
ENDM
MACRO as_step        ; $0a step one tick toward the target waypoint (+$16), then yield
	db $0a
ENDM
MACRO as_follow_wp   ; $0b advance along the waypoint list at +$16, then yield
	db $0b
ENDM
; --- character sprite animation scripts -------------------------------------
; Two-byte entries read by AdvanceActorAnimation ($04, overworld actors) and
; StepCharAnimation ($08, on-court characters): low byte is a frame index or a
; command, high byte is its operand. Only bank $08 implements anim_flip; bank
; $04 treats any unrecognised $f0-$fd command as "hold this frame".
MACRO anim_frame     ; show frame \1 (index into the character's *SpriteFrames table) for \2 frames
	db \1, \2
ENDM
MACRO anim_loop      ; $ff restart the script at its base + \1
	db $ff, \1
ENDM
MACRO anim_set       ; $fe switch to animation \1
	db $fe, \1
ENDM
MACRO anim_flip      ; $fb replace the sprite's attribute high nibble (flip/priority bits) with \1 (match characters only)
	db $fb, \1
ENDM
; $f0-$fd (except $fb): set the frame delay to $ff and keep the current frame,
; i.e. hold it forever. One byte -- neither interpreter reads an operand.
MACRO anim_hold
	db \1
ENDM
MACRO as_jump        ; $0c jump to `target` (signed rel16, relative to the operand)
	db $0c
	dw \1 - @
ENDM
MACRO as_set_field   ; $0d write a state field (selector byte, value word; type table $04:$47fd). Selector $14 = facing (FACE_* value)
	db $0d, \1
	dw \2
ENDM
MACRO as_add_field   ; $0e add to / set a state field (selector byte, value word)
	db $0e, \1
	dw \2
ENDM
MACRO as_halt15      ; $0f inert (handler alias of $00)
	db $0f
ENDM
MACRO as_anim        ; $10 set animation id
	db $10, \1
ENDM
MACRO as_sound       ; $11 play sound id
	db $11, \1
ENDM
MACRO as_call        ; $12 call a same-bank function (actor state in bc); yield+retry if busy
	db $12
	dw \1
ENDM
MACRO as_begin_path  ; $13 seed the path target (+$16) from the current position
	db $13
ENDM
MACRO as_wait_move2  ; $14 wait for the move to finish / countdown
	db $14
ENDM
MACRO as_flag        ; $15 set or clear a state flag bit (mode: $01 set, else clear; field offset; bit index)
	db $15, \1, \2, \3
ENDM

; Entry-point spawn record (8 bytes, table terminated by $ff). Selected by
; wStoryModeEntryPoint; places the main character (facing a FACE_* direction,
; constants.inc) and runs `arrival_script`.
; Usage: map_entry id, facing, x, y, arrival_script
MACRO map_entry
	map_pos \3, \4
	db \1, \2
	dw (\3) >> 8, (\4) >> 8, \5
ENDM

; Story-script record (8 bytes, table terminated by $ff). FindStoryScriptEntry
; ($0a:$53e4) matches `id` (and `facing_mask`, a FACEMASK_* constant in
; constants.inc, against the actor's facing), checks `flag_cond`, then runs
; `handler` with the two arg bytes. What the args mean belongs to the map_tree
; slot the table sits in, not to the record: in an ExitTriggers table (slot 1)
; RunLocationExit ($0a:$5637) copies `arg0` into wStoryModeCurrentLocation --
; a STORYLOC_* id -- and `arg1` into wStoryModeEntryPoint, which indexes the
; destination's own map_entry list. In the other three slots they are whatever
; the handler reads them as.
; Usage: map_script id, facing_mask, flag_cond, handler, arg0, arg1
MACRO map_script
	db \1, \2
	dw \3, \4
	db \5, \6
ENDM

; Story match launcher: store the 16-bit big-endian match id into
; wCurrentMinigameStoryMatch ($c8f6/$c8f7), then load that match's settings via
; FarPtr_LoadMatchSettingsFromTable. The high byte is the category
; (0 singles, 1 doubles, 2 minigame/practice) and the low byte the match; see
; the wCurrentMinigameStoryMatch id table in docs/ram_map.md. The standalone
; launcher stubs follow it with a ret; some callers continue with more setup.
; Usage: load_match_settings MATCHLIST_*, STORYMATCH_* (or one 16-bit id)
MACRO load_match_settings
IF _NARG == 2
	ld a, \1
	ld [wCurrentMinigameStoryMatch], a
	ld a, \2
ELSE
	ld a, HIGH(\1)
	ld [wCurrentMinigameStoryMatch], a
	ld a, LOW(\1)
ENDC
	ld [wCurrentMinigameStoryMatch + 1], a
	farcall LoadMatchSettingsFromTable
ENDM

; Story location record (6 bytes) in bank $0a's StoryLocationTable, indexed by
; wStoryModeCurrentLocation (GetStoryLocationRecordPtr). `map_scripts` is a
; slot in the target bank's $4000 directory (a DataPtr_*MapScripts label); the
; engine copies its 7-word map_tree to $c286 (LoadStoryLocationHeader), loads
; `scene` graphics (LoadStorySceneGraphics), and plays `bgm` (a BGM_* id;
; BGM_UNCHANGED, $ff, keeps what is playing).
; Usage: story_location id, scene, map_scripts, bgm
MACRO story_location
	db \1, \2
	dslot \3
	db \4, $00
ENDM

; map_pos x, y -- assert that a map position is written in tiles with a
; point (18.0, 17.5): the game keeps positions in 1/256 tile (ACTORF_X), and
; the macros below store `x >> 8` of the Q16.16 literal, so an integer would
; silently land 256 times too close to the origin.
MACRO map_pos
	ASSERT (\1) % 256 == 0 && (\1) < 256.0, "map position \1: write tiles with a point, e.g. 18.0"
	ASSERT (\2) % 256 == 0 && (\2) < 256.0, "map position \2: write tiles with a point, e.g. 18.0"
ENDM
; map_offset dx, dy -- the same for a signed move in tiles (-4.0, 2.0).
MACRO map_offset
	ASSERT (\1) % 256 == 0 && (\1) >= -128.0 && (\1) < 128.0, "map offset \1: write tiles with a point, e.g. -4.0"
	ASSERT (\2) % 256 == 0 && (\2) >= -128.0 && (\2) < 128.0, "map offset \2: write tiles with a point, e.g. -4.0"
ENDM

; Cutscene script commands. Story cutscenes are hand-written native code: fixed
; register setups feeding farcalls into the script engine (FarPtr_Script*, bank
; $0a). Each macro collapses one setup+farcall; the disassembler emits them via
; script_cmd_seq. `actor` is the target actor slot (ACTOR_PLAYER = the player).
; Usage: script_move_target actor, x, y
MACRO script_move_target
	map_pos \2, \3
	ld a, \1
	ld bc, (\2) >> 8
	ld de, (\3) >> 8
	farcall ScriptSetActorMoveTarget
ENDM
; Instantly places an actor (no walking).
; Usage: script_set_position actor, x, y
MACRO script_set_position
	map_pos \2, \3
	ld a, \1
	ld bc, (\2) >> 8
	ld de, (\3) >> 8
	farcall ScriptSetActorPosition
ENDM
; Usage: script_move_angle actor, angle, distance  (angle is a FACE_* cardinal;
; distance in tiles with a point, like a map position)
MACRO script_move_angle
	ASSERT (\3) % 256 == 0 && (\3) >= 0 && (\3) < 256.0, "distance \3: write tiles with a point, e.g. 2.0"
	ld a, \1
	ld b, \2
	ld de, (\3) >> 8
	farcall MoveActorByAngle
ENDM
; px_speed speed -- assert a move speed is written in pixels per frame with a
; point (1.0, 0.75). The actor mover steps the position (1/256 tile) by the
; speed every update, so 1 px is $20; the macros store `speed >> 11` of the
; Q16.16 literal, which needs a multiple of 1/32 px.
MACRO px_speed
	ASSERT (\1) % 2048 == 0 && (\1) >= 0 && (\1) < 2048.0, "speed \1: write pixels per frame with a point, in 1/32 px"
ENDM
; Usage: script_set_speed actor, speed (pixels per frame)
MACRO script_set_speed
	px_speed \2
	ld a, \1
	ld bc, (\2) >> 11
	farcall ScriptSetActorMoveSpeed
ENDM
; Starts an actor's jump: velocity in pixels per frame, negative = up. Height
; is 64 units to the pixel and gravity adds 1/4 px per frame every frame, so
; -2.0 rises 8 px and lands 16 frames later.
; Usage: script_jump_velocity actor, velocity
MACRO script_jump_velocity
	ASSERT (\2) % 1024 == 0 && (\2) >= -512.0 && (\2) < 512.0, "jump velocity \2: write pixels per frame with a point, in 1/64 px"
	ld a, \1
	ld de, ((\2) >> 10) & $ffff
	farcall ScriptSetActorJumpVelocity
ENDM
; Usage: script_move_player x, y (moves actor $00, the player)
MACRO script_move_player
	map_pos \1, \2
	xor a
	ld bc, (\1) >> 8
	ld de, (\2) >> 8
	farcall MovePlayerToPosition
ENDM
; Usage: script_player_speed speed (pixels per frame)
MACRO script_player_speed
	px_speed \1
	ld bc, (\1) >> 11
	farcall SetPlayerMoveSpeed
ENDM
; Usage: script_set_text text_id (sets the next dialogue's text)
MACRO script_set_text
	ld hl, \1
	farcall InitDialogueTextCursor
ENDM
; Usage: script_set_anim actor, anim
MACRO script_set_anim
	ld a, \1
	ld d, \2
	farcall ScriptSetActorAnimation
ENDM
; Installs object definition `objdef` into `actor`: fetch the actor's state
; pointer into bc, then LoadActorObjectDefIfValid(bc, d = objdef).
; Usage: script_set_objdef objdef, actor
MACRO script_set_objdef
	ld d, \1
	ld a, \2
	farcall GetActorStateAddr
	ld c, l
	ld b, h
	farcall LoadActorObjectDefIfValid
ENDM
; Fetch `actor`'s state-struct address ($d000 + actor*$40) into hl. Callers
; then copy it into bc/de to read or write state fields. GetActorStateAddr
; ($0a:$4311).
; Usage: script_get_actor_state actor
MACRO script_get_actor_state
	ld a, \1
	farcall GetActorStateAddr
ENDM
; Usage: script_face actor, facing  (facing is a FACE_* constant)
MACRO script_face
	ld a, \1
	ld b, \2
	farcall SetActorFacing
ENDM
; Turns two actors to face each other (actor1 in b, actor2 in a).
; Usage: script_face_pair actor1, actor2
MACRO script_face_pair
	ld a, \1
	ld b, a
	ld a, \2
	farcall FaceActorsTowardEachOther
ENDM
; Turns `actor` (in b) to face `target` (in a); only `actor` turns.
; Usage: script_face_toward actor, target
MACRO script_face_toward
	ld a, \1
	ld b, a
	ld a, \2
	farcall FaceActorTowardActor
ENDM
; ScriptSetActorFacingLock with b != 0: sets bit 0 of the actor's +$30, so it
; keeps its facing while it walks.
; Usage: script_lock_facing actor
MACRO script_lock_facing
	ld a, \1
	ld b, $01
	farcall ScriptSetActorFacingLock
ENDM
; ScriptSetActorFacingLock with b = 0: clears the lock bit and copies the
; actor's facing (+$14) into +$34.
; Usage: script_unlock_facing actor
MACRO script_unlock_facing
	ld a, \1
	ld b, $00
	farcall ScriptSetActorFacingLock
ENDM
; Writes `state` to the actor's activity byte (state struct +$20).
; Usage: script_set_active actor, state
MACRO script_set_active
	ld a, \1
	ld b, \2
	farcall SetActorActive
ENDM
; Walks the player to `actor` (b is a position offset, always $00 here).
; Usage: script_move_player_to_actor actor
MACRO script_move_player_to_actor
	ld a, \1
	ld b, $00
	farcall MovePlayerToActor
ENDM
; Usage: script_speak actor
MACRO script_speak
	ld a, \1
	farcall ScriptShowSpeakerDialogue
ENDM
; script_speak, then restores the background the speaker's window covered.
; Usage: script_speak_restore actor
MACRO script_speak_restore
	ld a, \1
	farcall ScriptShowSpeakerDialogueRestoreBG
ENDM
; Usage: script_wait_idle actor
MACRO script_wait_idle
	ld a, \1
	farcall ScriptWaitActorIdle
ENDM
; Usage: script_wait_move actor
MACRO script_wait_move
	ld a, \1
	farcall ScriptWaitActorMoveDone
ENDM
; Blocks the cutscene until `actor`'s script finishes (CheckActorScriptEnd),
; advancing a frame each poll, with a ~600-frame timeout. WaitActorScriptDone
; ($0a:$4372).
; Usage: script_wait_actor_script actor
MACRO script_wait_actor_script
	ld a, \1
	farcall WaitActorScriptDone
ENDM
; Detaches `actor`'s script: installs the shared null/idle script ($0a:$4766)
; via SetActorScript so the actor stops running its own bytecode and the
; cutscene can drive it directly. SetActorNullScript ($0a:$4364).
; Usage: script_null_script actor
MACRO script_null_script
	ld a, \1
	farcall SetActorNullScript
ENDM
; Waits `frames` frames, preserving a (callers hold an actor id there while the
; wait clobbers it with the frame count).
; Usage: script_wait_frames frames
MACRO script_wait_frames
	push af
	ld a, \1
	farcall WaitScriptFrames
	pop af
ENDM

; Copy a width x height tile rectangle between two scene-tilemap cells
; (CopySceneTilemapRect, $0a:$619e -- CopyMemoryBC of `width` tiles per row for
; `height` rows). Source cell is (src_col, src_row), dest cell (dst_col,
; dst_row); addresses via GetSceneTilemapAddr ($d000 + col + row*$40).
; Usage: script_copy_scene_rect src_col, src_row, dst_col, dst_row, width, height
MACRO script_copy_scene_rect
	ld b, \1
	ld c, \2
	ld d, \3
	ld e, \4
	ld h, \5
	ld l, \6
	farcall CopySceneTilemapRect
ENDM

; Wait `frames` frames through WaitScriptFramesSaveA ($27:$7856), the
; af-preserving subroutine wrapper around FarPtr_WaitScriptFrames.
; Usage: script_delay frames
MACRO script_delay
	ld a, \1
	call WaitScriptFramesSaveA
ENDM

; Start a screen fade-in at speed `speed` (BeginFadeIn, $00:$1d2e; speed 0 is
; treated as 1). Usage: script_fade_in speed
MACRO script_fade_in
	ld c, \1
	call BeginFadeIn
ENDM

; Set actor `actor`'s script to `script`, a code pointer in the current bank
; (captured through hRomBank into b). ScriptSetActorScript ($0a:$434f).
; Usage: script_set_actor_script actor, script
MACRO script_set_actor_script
	ldh a, [hRomBank]
	ld b, a
	ld a, \1
	ld de, \2
	farcall ScriptSetActorScript
ENDM

; Match-result tilemap-copy record (routine at $16:$4a71, via CopyTilemapRect):
; copy a `rows`-tall, 2-tile-wide rectangle from `src` to `dest` in the BG
; tilemap shadow. Lists live in MatchResultTilemapScripts_16, one per result
; layout, and end with a tilemap_copy_end sentinel.
; Usage: tilemap_copy dest, src, rows
MACRO tilemap_copy
	dw \1, \2
	db \3
ENDM

; Terminates a tilemap_copy list: an all-zero record (the routine stops when a
; record's dest word is $0000; the remaining record bytes are unread).
MACRO tilemap_copy_end
	ds 5, $00
ENDM

; Tilemap-assembly record (dispatch at $39:$4e11, via CopyTilemapRect): copy a
; `height`x`width` rectangle from `src` to `dest` in the tilemap shadow (and
; again at a +$0400 buffer offset). Lists end with tilemap_rect_end (a record
; whose height byte is 0, which the loop stops on).
; Usage: tilemap_rect src, dest, height, width
MACRO tilemap_rect
	dw \1, \2
	db \3, \4
ENDM

MACRO tilemap_rect_end
	ds 6, $00
ENDM

; A rectangular block of tilemap (or attrmap) bytes, stored row-major and
; copied by CopyTextRect/CopyTextRectPair. `tilemap_begin` declares the
; geometry, one `tilemap_row` follows per row (rgbasm checks that its argument
; count matches the declared width), and `tilemap_end` checks the row count and
; the total size -- so a mis-carved width fails the build instead of quietly
; rendering ragged rows.
; Usage: tilemap_begin width, height / tilemap_row ... / tilemap_end
MACRO tilemap_begin
DEF _TM_W = \1
DEF _TM_H = \2
DEF _TM_ROWS = 0
DEF _TM_START = @
ENDM

MACRO tilemap_row
	ASSERT _NARG == _TM_W, "tilemap_row: {d:_NARG} bytes, width is {d:_TM_W}"
	db \#
DEF _TM_ROWS += 1
ENDM

MACRO tilemap_end
	ASSERT _TM_ROWS == _TM_H, "tilemap_end: {d:_TM_ROWS} rows, height is {d:_TM_H}"
	ASSERT @ - _TM_START == _TM_W * _TM_H, "tilemap_end: size mismatch"
ENDM

; One rules screen's page list (ShowRulesPageSequence $06:$4316): the page
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
; display order. The 8-byte record is {id0..id3, count, $00 x3} -- the count is
; derived from the argument list (GetMatchMenuItemCount/GetStoryMenuItemCount
; read it at +4), so a menu cannot disagree with its own length.
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

; QueueSpriteTemplate ($1e9d) sprite record: one hardware sprite as {dy, dx,
; tile, attr} deltas added to the base position/tile/attr passed in the call.
; A list ends with oam_sprite_end (a $80 dy byte, which the loader stops on).
; Usage: oam_sprite dy, dx, tile, attr
MACRO oam_sprite
	db \1, \2, \3, \4
ENDM

MACRO oam_sprite_end
	db $80
ENDM

; Match-result graphics set (loader $16:$4e54): three LZ tile streams
; decompressed to VRAM $8900, $8a40, $9140 (20 tiles each). Records live in
; GfxSetPointerTable_16 and are selected by the remapped match gfx index.
; Usage: gfx_set tiles_lo, tiles_mid, tiles_hi
MACRO gfx_set
	dw \1, \2, \3
ENDM

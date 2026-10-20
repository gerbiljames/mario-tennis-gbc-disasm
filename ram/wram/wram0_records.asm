; WRAM0 $c800-$caff: the story slot image (saved whole) and the character records.

; [buffer] Base of the story-slot state image ($c800-$caff): the main character, game mode, match settings and roster fields, saved whole as save block 2N (docs/save_format.md) and reloaded on slot load
wStorySlotData::
; Saved-slot copies of the story records at $c900/$c940, kept in step by a
; 128-byte copy in RefreshMainCharacterStats, which also normalises
; wSavedMainEquipment before the stats are recomputed: a low nibble of 3
; clears the low nibble, a high nibble of 1 the high one.
	char_record wSavedMain

	char_record wSavedPartner

; [4 bytes] Signature that tells story saves apart. CacheStorySlotSummaries copies each slot's to $d400 + slot * 4, CheckStorySignatureCollision compares them, GenerateUniqueStorySaveSignature rerolls from wStoryRandomBytes until no slot matches
wStorySaveSignature:: ds 4

; [3 bytes] Tag InitStoryModeState stamps on a fresh story slot: $56 then two zero bytes
wStorySlotBlockTag:: ds 3
	ds 7

; [4 bytes] Copy of wGameTimer taken by SaveGameTimer with interrupts off, so a screen that stops the clock can restore it (RestoreGameTimer). Its minutes and hours are what CharDataValuesSyncTask shows when wCharDataSyncSource is clear and what the save-slot summaries store
wSavedGameTimer:: ds 4
	ds 17

; [8-bit] Sound options. SOUNDOPTB_MUSIC_OFF: Unused_1a_ToggleMusicSetting flips it and Unused_00_SyncMusicMuteOption copies it into hMusicFlags' MUSICB_MUTED, stopping the BGM when set. Other bits are preserved
wSoundOptionBits:: db

; [8-bit] Message speed: MSGSPEED_FAST/NORMAL/SLOW in bits 0-6 (ApplyMessageSpeed). Bit 7, MSGSPEEDB_INSTANT, draws text at once whatever the speed: set by ShowLocationNamePopup, the Tennis Dictionary redraw, Unused_1a_ForceInstantMessageSpeed and ToggleCutsceneFastForward (as it clears FLAG_CUTSCENE_FAST_FORWARD), tested by ApplyMessageSpeed, FlushGlyphRow and UploadLastGlyphTiles, and cleared before saving
wMessageSpeed:: db

; [8-bit] Set to 1 by the Save & Quit entries of the match and story pause menus (MatchQuitMenu_SaveAndQuit, StoryPauseMenu_SaveQuit, the story menu's confirm prompt), which also call SaveStoryReturnPoint. Bank $10's post-match code then shows the results screen and saves the slot, and clears it with wMatchSuspendedFlag
wSaveAndQuitRequest:: db

; [8-bit] Game Mode
;
; 0x00 - Not playing tennis
; 0x01 - Story Mode - Ranking Match
; 0x02 - Story Mode - Island Open Match
; 0x03 - Story Mode - Practice Match
; 0x04 - Exhibition Mode
; 0x05 - Story Mode - Training Court Minigames
; 0x06 - Story Mode - Tennis Machine
; 0x07 - Story Mode - Wall Practice
; 0x08 - Mario Minigames
; 0x09 - Link-cable Versus Match
; 0x0a - Story Mode - Dream Match
;
; See GAMEMODE_* in include/constants/. Bank $38 sets GAMEMODE_LINK_MATCH right after RunLinkCharSelectScreen. SaveQuitMenuIdByGameMode and ScoreboardModeGfxPointers index it unguarded, 11 entries each
wGameMode:: db

; [8-bit] A match was suspended by Save & Quit and can be resumed; saved with the slot image. Set to 1 by MatchQuitMenu_SaveAndQuit and Unused_07_RunDebugTestMatch. While set, ResetMatchState keeps the per-character match stats (then clears it), ProcessMatchRewards gives no rewards, RunStoryFileFlow resumes with ResumeSuspendedStoryMatch on continue, RunExhibitionModeFlow skips the menus and restarts the match, and UploadGlyphBufferQueued / UploadLastGlyphTiles clamp the glyph upload to columns $60/$5f instead of $80/$7f. Also cleared by InitDefaultMatchSettings, RunMinigameModeFlow, ConfirmDiscardSuspendedExhibMatch and the bank $0a/$10 post-match paths
wMatchSuspendedFlag:: db

; [8-bit] Nonzero selects VictoryScoreTableSaveQuit over VictoryScoreTable in GetVictoryScore; RunExhibitionModeFlow sets it when an exhibition match ends by Save & Quit and clears it when a fresh exhibition starts
wVictoryScoreTableAlt:: db

; [8-bit] Location SaveStoryReturnPoint recorded to return to; called with b = $ff it snapshots the live position instead of a door
wStoryReturnLocation:: db

; [8-bit] Entry point paired with wStoryReturnLocation, or $ff = no door, restore wStoryReturnPosition (RestoreStoryReturnPoint)
wStoryReturnEntryPoint:: db

; [5 bytes] Player X, Y and facing saved with the return point, in the wStoryModeSpawnPosition layout it is copied back into
wStoryReturnPosition:: ds 5
	export_size wStoryReturnPosition
	ds 1

; [16-bit] EXP an exhibition match earned, held by AwardExhibitionMatchExp until ApplyPendingExpAwards runs after the results screens
wPendingExpExhibition:: dw

; [16-bit] The same for a linked-play match (AwardLinkedPlayMatchExp)
wPendingExpLinked:: dw

; [4 bytes] Per player slot, the character the suspended or link match was set up with, from wCharSelectSlotChars (StoreLinkMatchCharInfo) or the exhibition save block (CopyExhibitionCharSlotIds). Bit 7 marks a created story character, the low bits its story slot
wMatchSlotCharRefs:: ds 4

; [8-bit] hLinkState as StoreLinkMatchCharInfo saw it when the link match's characters were committed. The results and EXP screens turn it into the local player's per-character WRAM bank with `srl a / add a, $04`
wLinkMatchRole:: db

; [8-bit] Byte +$02 of the chosen created-character record, saved by StoreLinkMatchCharInfo for the EXP screen panels
wLinkMatchCharLevel:: db

; [4 bytes] Random bytes stirred by RollStoryRandomByte; GenerateUniqueStorySaveSignature copies them into wStorySaveSignature
wStoryRandomBytes:: ds 4
	ds 1

; Match statistics per on-court character, read by the results and EXP
; screens.
	match_stats wCharacter1
	ds 1
	match_stats wCharacter2

; [8-bit] wCharCourtPos as of last frame. CheckServerEndChanged swaps the new value in and raises wChangeEndsPending when bit 1 differs; UpdateViewFlipState reads it for the flipped view
wPrevCourtPos:: db
	match_stats wCharacter3
	ds 1
	match_stats wCharacter4
	ASSERT wCharacter4ServiceAces - wCharacter1ServiceAces == 3 * MATCH_STATS_STRIDE

; [8-bit] Match RNG state: seeded from hVBlankCounter at match start, stirred by AdvanceMatchRng (+$73 plus ball position bytes)
wMatchRngState:: db

; [8-bit] Player 1 Sets Won (0x00-0x03)
wPlayer1SetsWon:: db

; [8-bit] Player 2 Sets Won (0x00-0x03)
wPlayer2SetsWon:: db

; [8-bit] Player 1 Games Won (0x00-0x07)
wPlayer1GamesWon:: db

; [8-bit] Player 2 Games Won (0x00-0x07)
wPlayer2GamesWon:: db

; [8-bit] Player 1 Points Won
;
; 0x00 - 0
; 0x01 - 15
; 0x02 - 30
; 0x03 - 40
; 0x04 - Advantage/Deuce
; 0x05-0x07 - Tiebreaker only
wPlayer1PointsWon:: db

; [8-bit] Player 2 Points Won; values as wPlayer1PointsWon
wPlayer2PointsWon:: db

; [8-bit] Deuce Indicator (0x01 when deuce, 0x00 otherwise)
wDeuceIndicator:: db

; [8-bit] Tiebreaker Indicator (0x01 when tiebreaker, 0x00 otherwise)
wTiebreakerIndicator:: db

; [8-bit] Match Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise)
wMatchWinLoseFlag:: db

; [8-bit] Set Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise)
wSetWinLoseFlag:: db

; [8-bit] Game Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise)
wGameWinLoseFlag:: db

; [8-bit] Point Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise)
wPointWinLoseFlag:: db

; [8-bit] Total Games Won In Match
wTotalGamesWonInMatch:: db

; [8-bit] Total Points Scored In Current Game; a drill ends at DRILL_LESSON_POINTS or DRILL_MATCH_POINTS
wTotalPointsScoredInCurrentGame:: db

; [8-bit] 1 after a first-serve fault (the next fault is a double fault, point outcome 2); cleared on double fault and at match reset
wServeFaultFlag:: db
	ds 1

; [8-bit] Match Type - Number Of Sets (0x01, 0x03, 0x05)
wMatchTypeNumberOfSets:: db

; [8-bit] Match Type - Number Of Games (0x02, 0x06)
wMatchTypeNumberOfGames:: db

; [8-bit] Nonzero when the current match is doubles; selects the wider court bound and 4 on-court characters
wMatchIsDoubles:: db

; [8-bit] Number of characters on court (2 singles, 4 doubles, 3 in Two-On-One); one banked WRAM struct each in banks 4-7
wOnCourtCharCount:: db

; [8-bit] Currently Used Court
;
; 0x00 - Hard Court
; 0x01 - Clay Court
; 0x02 - Grass Court (Exhibition)
; 0x03 - Composition Court
; 0x04 - Star Court
; 0x05 - Castle Court
; 0x06 - Tropics Court
; 0x07 - Jungle Court
; 0x08 - Warehouse Court
; 0x09 - Training Court (Practice)
; 0x0a - Tennis Machine
; 0x0b - Wall Practice
; 0x0c - Center Court (Island Open Finals)
; 0x0d - Grass Court (Island Open)
; 0x0f - Target Shot
; 0x10 - Shooting Star
; 0x11 - Banana Bunch
; 0x12 - Boo Blast
; 0x13 - Perfect Shot
; 0x14 - Treasure Box
; 0x15 - Medallion Match
; 0x16 - Fruit Fantasy
; 0x17 - Two-On-One
; 0x18 - Training Court (Match)
wCurrentlyUsedCourt:: db

; [8-bit] Kind of match running: 0 = exhibition (cleared by RestoreOverworldAfterMatch), 1 = story match (InitStoryMatchSettings), 2 = minigame/drill (InitMinigameMatchSettings, RunDoublesDrillMatch). At 2, SelectScoreboardLayout forces the doubles scoreboard and InitViewFlipPreference the fixed court view
wMatchContext:: db

UNION
; [16-bit BE] Current Minigame/Story Match: wCurrentMatchList, then wCurrentMatchIndex
;
; 0x0000 - Singles Junior Practice Match
; 0x0001 - Singles Junior #4
; 0x0002 - Singles Junior #3
; 0x0003 - Singles Junior #2
; 0x0004 - Singles Junior #1
; 0x0005 - Singles Senior Practice Match
; 0x0006 - Singles Senior #4
; 0x0007 - Singles Senior #3
; 0x0008 - Singles Senior #2
; 0x0009 - Singles Senior #1
; 0x000a - Singles Varsity Practice Match
; 0x000b - Singles Varsity #4
; 0x0010 - Singles Island Open Round 1
; 0x0011 - Singles Island Open Round 2
; 0x0012 - Singles Island Open Semifinals
; 0x0013 - Singles Island Open Finals
; 0x0016 - Singles Dream Match (MAX)
; 0x0017 - Singles Dream Match (Intense)
; 0x0018 - Singles Dream Match (Hard/First time)
; 0x0100 - Doubles Junior Practice Match
; 0x0102 - Doubles Junior #3
; 0x0103 - Doubles Junior #2
; 0x0104 - Doubles Junior #1
; 0x0105 - Doubles Senior Practice Match
; 0x0107 - Doubles Senior #3
; 0x0108 - Doubles Senior #2
; 0x0109 - Doubles Senior #1
; 0x010a - Doubles Varsity Practice Match
; 0x010d - Doubles Varsity #2
; 0x0111 - Doubles Island Open Round 1
; 0x0112 - Doubles Island Open Semifinals
; 0x0113 - Doubles Island Open Finals
; 0x0116 - Doubles Dream Match (MAX)
; 0x0117 - Doubles Dream Match (Intense)
; 0x0118 - Doubles Dream Match (Hard/First time)
; 0x0200 - Service Match 1
; 0x0201 - Service Match 2
; 0x0202 - Service Match 3
; 0x0203 - Service Practice 1
; 0x0204 - Service Practice 2
; 0x0205 - Service Practice 3
; 0x0206 - Net Play Match 1
; 0x0207 - Net Play Match 2
; 0x0208 - Net Play Match 3
; 0x0209 - Net Play Practice 1
; 0x020a - Net Play Practice 2
; 0x020b - Net Play Practice 3
; 0x020c - Stroke Match 1
; 0x020d - Stroke Match 2
; 0x020e - Stroke Match 3
; 0x020f - Stroke Practice 1
; 0x0210 - Stroke Practice 2
; 0x0211 - Stroke Practice 3
; 0x0212 - Tennis Machine 1
; 0x0213 - Tennis Machine 2
; 0x0214 - Tennis Machine 3
; 0x0215 - Tennis Machine 4
; 0x0216 - Wall Practice 1
; 0x0217 - Wall Practice 2
; 0x0218 - Wall Practice 3
; 0x0219 - Wall Practice 4
; 0x021a - Tennis Machine High Score
; 0x021b - Wall Practice High Score
; 0x021c - Boo Blast
; 0x021d - Shooting Star
; 0x021e - Perfect Shot
; 0x021f - Target Shot
; 0x0220 - Fruit Fantasy
; 0x0221 - Banana Bunch
; 0x0222 - Treasure Box
; 0x0223 - Medallion Match
; 0x0224 - Two-On-One
wCurrentMinigameStoryMatch:: dw
NEXTU
; [8-bit] Match list (MATCHLIST_*), the word's high byte
wCurrentMatchList:: db
; [8-bit] Match within the list, the low byte: STORYMATCH_* under the singles and doubles lists, MINIGAME_* under MATCHLIST_TRAINING
wCurrentMatchIndex:: db
ENDU

; [8-bit] BGM id (wCurrentBGM values) for the current match/court; a tiebreak overrides it with $0e
wMatchBGM:: db
	ds 7

; The live story records, main character and partner. The character id
; (+$0b) also picks the overworld sprite.
	char_record wStoryMain

	char_record wStoryPartner
	ds 48

; [16-bit] Head of the N64 transfer record that wN64TransferMarker ends (Unused_02_ValidateN64TransferRecord checksums it). No ROM code stores a nonzero value; story matches award through SetPendingExpAward_Match. ApplyPendingExpAwards sums it with wN64TransferPartnerExp, scales by player level and awards it as EXPAWARD_N64; the old debug path shows it against the main character
wN64TransferMainExp:: dw

; [16-bit] Second N64 transfer EXP word, summed with wN64TransferMainExp; the old debug path shows it against the partner
wN64TransferPartnerExp:: dw

; [8-bit] Marker byte of the N64 transfer record at $c9b0: Unused_02_ValidateN64TransferRecord rejects the record unless it is $64, then checksums the bytes around it
wN64TransferMarker:: db

; [2 bytes] Trophies transferred from the N64 game, two bits per trophy (0-3) for eight trophies. DecodeTrophyCounts unpacks them into the trophy screen's cells; the EXP award path walks them tier by tier to pick a TrophyExpTierFlags row
wN64TrophyCounts:: dw
	ds 9

; [32 bytes] Per-story-slot progress flags, $c9c0-$c9df, saved as the slot's +$1c0 block. rst $20/$28/$30 (SetGameFlag/ClearGameFlag/TestGameFlag) take d = byte index, e = bit << 5 and apply mask $80 >> bit; the *GameFlagByNumber wrappers take the flat number byte * 8 + bit, as held by the FLAG_* constants in include/flag_constants.inc. The array is only accessed through these, so the named entries below are views of the same storage: byte $05 = doubles, $06/$07 = Island Open + Dream Match, $08-$0b = class rank wins, $0c/$0d = equipment owned, $18-$1b = training-drill clears, $1c-$1f = temporary (wGameFlagsTemp)
UNION
wGameFlags:: flag_array NUM_GAME_FLAGS
NEXTU
	ds 5

; [8-bit] Singles/Doubles Indicator (Story & Exhibition Mode)
;
; 0x00 - Singles
; 0x01 - Doubles
wSinglesDoublesIndicator:: db

; [Lower4] Story Mode - Match Completion Flags (1/6)
;
; Bit 0 - Doubles Island Open Round 1
; Bit 1 - Doubles Island Open Semifinals
; Bit 2 - Doubles Island Open Finals
; Bit 3 - Doubles Dream Match
wStoryModeMatchCompletionFlags1:: db

; [8-bit] Story Mode - Match Completion Flags (2/6)
;
; Bit 0 - Singles Island Open Round 1
; Bit 1 - Singles Island Open Round 2
; Bit 2 - Singles Island Open Semifinals
; Bit 3 - Singles Island Open Finals
; Bit 4 - Singles Dream Match
wStoryModeMatchCompletionFlags2:: db

; [8-bit] Story Mode - Match Completion Flags (3/6)
;
; Bit 7 - Doubles Junior Rank 3
; Bit 6 - Doubles Junior Rank 2
; Bit 5 - Doubles Junior Rank 1
; Bit 3 - Doubles Senior Rank 3
; Bit 2 - Doubles Senior Rank 2
; Bit 1 - Doubles Senior Rank 1
wStoryModeMatchCompletionFlags3:: db

; [Upper4] Story Mode - Match Completion Flags (4/6)
;
; Bit 7 - Doubles Varsity Rank 2
wStoryModeMatchCompletionFlags4:: db

; [8-bit] Story Mode - Match Completion Flags (5/6)
;
; Bit 7 - Singles Junior Rank 4
; Bit 6 - Singles Junior Rank 3
; Bit 5 - Singles Junior Rank 2
; Bit 4 - Singles Junior Rank 1
; Bit 3 - Singles Senior Rank 4
; Bit 2 - Singles Senior Rank 3
; Bit 1 - Singles Senior Rank 2
; Bit 0 - Singles Senior Rank 1
wStoryModeMatchCompletionFlags5:: db

; [Upper4] Story Mode - Match Completion Flags (6/6)
;
; Bit 7 - Singles Varsity Rank 4
wStoryModeMatchCompletionFlags6:: db

; [8-bit] Story Mode - Equipment Flags (1/2)
;
; Bit 6 - Large Racket
; Bit 5 - Small Racket
; Bit 4 - Iron Racket
; Bit 3 - Silver Racket
; Bit 2 - Gold Racket
; Bit 1 - Drive Racket
; Bit 0 - Iron Shoes
wStoryModeEquipmentFlags1:: db

; [Upper4] Story Mode - Equipment Flags (2/2)
;
; Bit 7 - Light Shoes
wStoryModeEquipmentFlags2:: db

; [3 bytes] wGameFlags bytes $0e-$10 (flags 112-135): NPC talked/moved/turned and scene-seen flags (FLAG_*_TALKED_*, FLAG_*_MOVED, FLAG_REPAIR_COUNTER_*, FLAG_AWARDS_CEREMONY_SEEN_*, ...; include/flag_constants.inc)
wStoryModeNpcEventFlags:: ds 3

; [3 bytes] wGameFlags bytes $11-$13 (flags 136-159): FLAG_TROPHY_EXP_GROUP_*_TIER_*, the once-only N64 trophy-EXP tiers ComputeTrophyExpForGroup awards (TrophyExpTierFlags)
wGameFlagsSpare:: ds 3

; [2 bytes] wGameFlags bytes $14-$15 (flags 160-175): FLAG_CHEAT_UNLOCK_0-12 (set by the unlock-everything cheat, never read), then FLAG_REACHED_ISLAND_OPEN_SINGLES/DOUBLES
wCheatUnlockFlags:: dw

; [2 bytes] wGameFlags bytes $16-$17 (flags 176-191): FLAG_STORY_COMPLETE_*, FLAG_REACHED_MARIO_WORLD_*, FLAG_ENDING_SEEN_*, FLAG_ISLAND_OPEN_IN_PROGRESS, the three *_CHALLENGER_DEFEATED and three *_COACH_GREETED bits
wStoryProgressFlags:: dw

; [8-bit] Story Mode - Minigame Completion Flags (1/4)
;
; Bit 7 - Service Match 1
; Bit 6 - Service Match 2
; Bit 5 - Service Match 3
; Bit 4 - Service Practice 1
; Bit 3 - Service Practice 2
; Bit 2 - Service Practice 3
; Bit 1 - Net Play Match 1
; Bit 0 - Net Play Match 2
wStoryModeMinigameCompletionFlags1:: db

; [8-bit] Story Mode - Minigame Completion Flags (2/4)
;
; Bit 7 - Net Play Match 3
; Bit 6 - Net Play Practice 1
; Bit 5 - Net Play Practice 2
; Bit 4 - Net Play Practice 3
; Bit 3 - Stroke Match 1
; Bit 2 - Stroke Match 2
; Bit 1 - Stroke Match 3
; Bit 0 - Stroke Practice 1
wStoryModeMinigameCompletionFlags2:: db

; [8-bit] Story Mode - Minigame Completion Flags (3/4)
;
; Bit 7 - Stroke Practice 2
; Bit 6 - Stroke Practice 3
; Bit 5 - Machine Level 1
; Bit 4 - Machine Level 2
; Bit 3 - Machine Level 3
; Bit 2 - Machine Level 4
; Bit 1 - Wall Level 1
; Bit 0 - Wall Level 2
wStoryModeMinigameCompletionFlags3:: db

; Story Mode - Minigame Completion Flags (4/4)
;
; Bit 7 - Wall Level 3
; Bit 6 - Wall Level 4
; Bit 5 - Tennis Machine master (FLAG_CLEARED_MACHINE_MASTER)
; Bit 4 - Wall master
; Bit 3 - Tennis Machine expert
; Bit 2 - Wall expert
wStoryModeMinigameCompletionFlags4:: db

; [4 bytes] wGameFlags bytes $1c-$1f (flags $e0-$ff), temporary: ClearTemporaryStoryFlags zeroes them at the top of RunStoryLocation, so they last until the next location load. Used for per-location NPC/scene-variant state ($1c) and the screen-mode bits the progress and results screens set and clear ($1f)
wGameFlagsTemp:: ds 4
ENDU
	ds 32

; The four on-court records: player 1's main character and partner, then
; player 2's. The results screen prints the names; LoadCharacterAttributes
; copies each record's physics and AI attributes into that character's
; banked struct. ExchangeLinkUnlockFlags borrows the main records'
; LinkCourtMask for the peer's bonus-court unlock mask: the one matching
; the link role goes to wLinkPartnerCourtMask, then both are cleared. The
; CPU menus set Difficulty on the three records the player does not pick
; for. Boo Blast's setup writes wPlayer2MainPhysics, which nothing reads.
	char_record wPlayer1Main
	char_record wPlayer1Partner
	char_record wPlayer2Main
	char_record wPlayer2Partner

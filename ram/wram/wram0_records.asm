; WRAM0 $c800-$caff: the story slot image (saved whole) and the character records.

; [buffer] Base of the story-slot state image ($c800-$caff): the main character, game mode, match settings and roster fields, saved whole as save block 2N (docs/save_format.md) and reloaded on slot load
wStorySlotData:: db

; [6 bytes] Bytes 1-6 of the saved-slot mirror's main character name (record +$01-$06); byte 0 is wStorySlotData. The mirror pair at $c800/$c840 is kept in step with the live records at $c900/$c940 by a 128-byte copy ($02:$4795)
wSavedMainCharacterName:: ds 6

; [4 bytes] Saved-slot mirror record +$07-$0a: name terminator and padding after the 7-character name
wStoryModeMainCharacterNamePad:: ds 4

; [8-bit] Saved-slot mirror record +$0b: character id (after RemapExtendedCharId), mirror of $c90b
wSavedMainCharacterId:: db

; [8-bit] Saved-slot mirror of the main character record +$0c: palette index (GetCharPaletteIndex)
wSavedMainCharacterPaletteIndex:: db

; [8-bit] Saved-slot mirror of the main character record +$0d: gender, 0 male, 1 female
wSavedMainCharacterGender:: db

; [8-bit] Saved-slot mirror of the main character record +$0e: left-handed flag
wSavedMainCharacterLeftHanded:: db

; [9 bytes] Saved-slot mirror record +$0f-$17: AI and physics attributes from StoryCharacterRecords_02: +$0f personality byte, +$10-$17 reach windows, smash and dive speeds and reaction delays, refreshed by RecomputeCharacterStats from the +$30 template
wStoryModeMainCharacterPhysics:: ds 9

; [8-bit] Story Mode - Main Character Level (0x01-0x63)
wStoryModeMainCharacterLevel:: db

; [2 bytes] Saved-slot mirror record +$19-$1a: swing attribute word
wStoryModeMainCharacterSwingAttrWord:: dw

; [5 bytes] Saved-slot mirror record +$1b-$1f: AI personality parameters (docs/story_mode.md, "The character record")
wStoryModeMainCharacterAiParams:: ds 5

; [8-bit] Story Mode - Main Character Top Stat (0x00-0x09)
wStoryModeMainCharacterTopStat:: db

; [8-bit] Story Mode - Main Character Slice Stat (0x00-0x09)
wStoryModeMainCharacterSliceStat:: db

; [8-bit] Story Mode - Main Character Serve Stat (0x00-0x09)
wStoryModeMainCharacterServeStat:: db

; [8-bit] Story Mode - Main Character Stroke Stat (0x00-0x09)
wStoryModeMainCharacterStrokeStat:: db

; [8-bit] Story Mode - Main Character Volley Stat (0x00-0x09)
wStoryModeMainCharacterVolleyStat:: db

; [8-bit] Story Mode - Main Character Angle Stat (0x00-0x09)
wStoryModeMainCharacterAngleStat:: db

; [8-bit] Story Mode - Main Character Placement Stat (0x00-0x09)
wStoryModeMainCharacterPlacementStat:: db

; [8-bit] Story Mode - Main Character Speed Stat (0x00-0x09)
wStoryModeMainCharacterSpeedStat:: db

; [8-bit] Story Mode - Main Character Dash Stat (0x00-0x09)
wStoryModeMainCharacterDashStat:: db

; [8-bit] Story Mode - Main Character Reaction Stat (0x00-0x09)
wStoryModeMainCharacterReactionStat:: db

; [8-bit] Story Mode - Main Character Stop Stat (0x00-0x09)
wStoryModeMainCharacterStopStat:: db
; [8-bit] Character record +$2b of the saved-slot mirror: speed bonus (see wStoryMainCharSpeedBonus)
wStoryModeMainCharacterSpeedBonus:: db

; [3 bytes] Story Mode - Main Character EXP, capped at 99999 by AddExpCapped
wStoryModeMainCharacterEXP:: ds 3
; [8-bit] Character record +$2f of the saved-slot mirror: write-only build tag (see wStoryMainCharBuildKind)
wStoryModeMainCharacterBuildKind:: db

; [8 bytes] Saved-slot mirror record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wStoryModeMainCharacterPhysicsTemplate:: ds 8

; [8-bit] Story Mode - Main Character Spin Level
wStoryModeMainCharacterSpinLevel:: db

; [8-bit] Story Mode - Main Character Power Level
wStoryModeMainCharacterPowerLevel:: db

; [8-bit] Story Mode - Main Character Control Level
wStoryModeMainCharacterControlLevel:: db

; [8-bit] Story Mode - Main Character Speed Level
wStoryModeMainCharacterSpeedLevel:: db

; [8-bit] Main character's equipment nibbles, normalised by RefreshMainCharacterStats before the stats are recomputed: a low nibble of 3 clears the low nibble, a high nibble of 1 clears the high one
wMainCharEquipmentBits:: db
	ds 3

; [7 bytes] Saved-slot mirror of the partner record +$00-$06: the 7-character name, NUL-padded
wSavedPartnerCharacterName:: ds 7

; [4 bytes] Saved-slot mirror partner record +$07-$0a: name terminator and padding after the 7-character name
wStoryModePartnerCharacterNamePad:: ds 4

; [8-bit] Saved-slot mirror partner record +$0b: character id (after RemapExtendedCharId), mirror of $c94b
wSavedPartnerCharacterId:: db

; [8-bit] Saved-slot mirror of the partner record +$0c: palette index (GetCharPaletteIndex)
wSavedPartnerCharacterPaletteIndex:: db

; [8-bit] Saved-slot mirror of the partner record +$0d: gender, 0 male, 1 female
wSavedPartnerCharacterGender:: db

; [8-bit] Saved-slot mirror of the partner record +$0e: left-handed flag
wSavedPartnerCharacterLeftHanded:: db

; [9 bytes] Saved-slot mirror partner record +$0f-$17: AI and physics attributes from StoryCharacterRecords_02: +$0f personality byte, +$10-$17 reach windows, smash and dive speeds and reaction delays, refreshed by RecomputeCharacterStats from the +$30 template
wStoryModePartnerCharacterPhysics:: ds 9

; [8-bit] Story Mode - Partner Character Level (0x01-0x63)
wStoryModePartnerCharacterLevel:: db

; [2 bytes] Saved-slot mirror partner record +$19-$1a: swing attribute word
wStoryModePartnerCharacterSwingAttrWord:: dw

; [5 bytes] Saved-slot mirror partner record +$1b-$1f: AI personality parameters (docs/story_mode.md, "The character record")
wStoryModePartnerCharacterAiParams:: ds 5

; [8-bit] Story Mode - Partner Character Top Stat (0x00-0x09)
wStoryModePartnerCharacterTopStat:: db

; [8-bit] Story Mode - Partner Character Slice Stat (0x00-0x09)
wStoryModePartnerCharacterSliceStat:: db

; [8-bit] Story Mode - Partner Character Serve Stat (0x00-0x09)
wStoryModePartnerCharacterServeStat:: db

; [8-bit] Story Mode - Partner Character Stroke Stat (0x00-0x09)
wStoryModePartnerCharacterStrokeStat:: db

; [8-bit] Story Mode - Partner Character Volley Stat (0x00-0x09)
wStoryModePartnerCharacterVolleyStat:: db

; [8-bit] Story Mode - Partner Character Angle Stat (0x00-0x09)
wStoryModePartnerCharacterAngleStat:: db

; [8-bit] Story Mode - Partner Character Placement Stat (0x00-0x09)
wStoryModePartnerCharacterPlacementStat:: db

; [8-bit] Story Mode - Partner Character Speed Stat (0x00-0x09)
wStoryModePartnerCharacterSpeedStat:: db

; [8-bit] Story Mode - Partner Character Dash Stat (0x00-0x09)
wStoryModePartnerCharacterDashStat:: db

; [8-bit] Story Mode - Partner Character Reaction Stat (0x00-0x09)
wStoryModePartnerCharacterReactionStat:: db

; [8-bit] Story Mode - Partner Character Stop Stat (0x00-0x09)
wStoryModePartnerCharacterStopStat:: db
; [8-bit] Character record +$2b of the saved-slot mirror: speed bonus (see wStoryMainCharSpeedBonus)
wStoryModePartnerCharacterSpeedBonus:: db

; [3 bytes] Story Mode - Partner Character EXP, capped at 99999 by AddExpCapped
wStoryModePartnerCharacterEXP:: ds 3
; [8-bit] Character record +$2f of the saved-slot mirror: write-only build tag (see wStoryMainCharBuildKind)
wStoryModePartnerCharacterBuildKind:: db

; [8 bytes] Saved-slot mirror partner record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wStoryModePartnerCharacterPhysicsTemplate:: ds 8

; [8-bit] Story Mode - Partner Character Spin Level
wStoryModePartnerCharacterSpinLevel:: db

; [8-bit] Story Mode - Partner Character Power Level
wStoryModePartnerCharacterPowerLevel:: db

; [8-bit] Story Mode - Partner Character Control Level
wStoryModePartnerCharacterControlLevel:: db

; [8-bit] Story Mode - Partner Character Speed Level
wStoryModePartnerCharacterSpeedLevel:: db
	ds 4

; [4 bytes] Signature that tells story saves apart. CacheStorySlotSummaries copies each slot's to $d400 + slot * 4, CheckStorySignatureCollision compares them, GenerateUniqueStorySaveSignature rerolls from wStoryRandomBytes until no slot matches
wStorySaveSignature:: ds 4

; [3 bytes] Tag InitStoryModeState stamps on a fresh story slot: $56 then two zero bytes
wStorySlotBlockTag:: ds 3
	ds 7

; [4 bytes] Copy of wGameTimer taken by SaveGameTimer with interrupts off, so a screen that stops the clock can restore it (RestoreGameTimer)
wSavedGameTimer:: dw

; [2 bytes] The pair CharDataValuesSyncTask pushes into the character-data screen at $d14c when $d149 is clear (wGameTimer + 2 when set)
wCharDataSyncValues:: dw
	ds 17

; [8-bit] Sound options. Bit 0 is music on/off: Unused_1a_ToggleMusicSetting flips it and Unused_00_SyncBGMEnableFlag mirrors it into hMusic bit 0, stopping the BGM when clear. Other bits are preserved
wSoundOptionBits:: db

; [8-bit] Message Speed
;
; 0x00 - Fast
; 0x01 - Normal
; 0x02 - Slow
wMessageSpeed:: db

; [8-bit] Set to 1 by the Save & Quit entries of the match and story pause menus (MatchQuitMenu_SaveAndQuit, StoryPauseMenu_SaveQuit, the story menu's confirm prompt), which also call SaveStoryReturnPoint. Bank $10's post-match code then shows the results screen and saves the slot, and clears it with wKeepMatchStatsFlag
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
; See GAMEMODE_* in include/constants/. Bank $38 sets 0x09 right after RunLinkCharSelectScreen. SaveQuitMenuIdByGameMode and ScoreboardModeGfxPointers index it unguarded, 11 entries each
wGameMode:: db

; [8-bit] Nonzero makes ResetMatchState keep the per-character match stats (set by MatchQuitMenu_SaveAndQuit so a resumed match keeps them); cleared after use
wKeepMatchStatsFlag:: db

; [8-bit] Nonzero selects VictoryScoreTable1 over VictoryScoreTable in GetVictoryScore; set on two paths of the match-select handler
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

; [8-bit] Character 1 Service Aces
wCharacter1ServiceAces:: db

; [8-bit] Character 1 Return Aces
wCharacter1ReturnAces:: db

; [8-bit] Character 1 Smash Aces
wCharacter1SmashAces:: db

; [8-bit] Character 1 Lob Shot Winners
wCharacter1LobShotWinners:: db

; [8-bit] Character 1 Drop Shot Winners
wCharacter1DropShotWinners:: db

; [8-bit] Character 1 Faults
wCharacter1Faults:: db

; [8-bit] Character 1 Double Faults
wCharacter1DoubleFaults:: db
	ds 1

; [8-bit] Character 2 Service Aces
wCharacter2ServiceAces:: db

; [8-bit] Character 2 Return Aces
wCharacter2ReturnAces:: db

; [8-bit] Character 2 Smash Aces
wCharacter2SmashAces:: db

; [8-bit] Character 2 Lob Shot Winners
wCharacter2LobShotWinners:: db

; [8-bit] Character 2 Drop Shot Winners
wCharacter2DropShotWinners:: db

; [8-bit] Character 2 Faults
wCharacter2Faults:: db

; [8-bit] Character 2 Double Faults
wCharacter2DoubleFaults:: db

; [8-bit] wCharCourtPos as of last frame. CheckServerEndChanged swaps the new value in and raises wChangeEndsPending when bit 1 differs; UpdateViewFlipState reads it for the flipped view
wPrevCourtPos:: db

; [8-bit] Character 3 Service Aces
wCharacter3ServiceAces:: db

; [8-bit] Character 3 Return Aces
wCharacter3ReturnAces:: db

; [8-bit] Character 3 Smash Aces
wCharacter3SmashAces:: db

; [8-bit] Character 3 Lob Shot Winners
wCharacter3LobShotWinners:: db

; [8-bit] Character 3 Drop Shot Winners
wCharacter3DropShotWinners:: db

; [8-bit] Character 3 Faults (sixth byte of the stat block; the label repeats DropShotWinners)
wCharacter3Faults:: db

; [8-bit] Character 3 Double Faults
wCharacter3DoubleFaults:: db
	ds 1

; [8-bit] Character 4 Service Aces
wCharacter4ServiceAces:: db

; [8-bit] Character 4 Return Aces
wCharacter4ReturnAces:: db

; [8-bit] Character 4 Smash Aces
wCharacter4SmashAces:: db

; [8-bit] Player 4 Lob Shot Winners
wCharacter4LobShotWinners:: db

; [8-bit] Character 4 Drop Shot Winners
wCharacter4DropShotWinners:: db

; [8-bit] Character 4 Faults
wCharacter4Faults:: db

; [8-bit] Character 4 Double Faults
wCharacter4DoubleFaults:: db

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

; [8-bit] Total Points Scored In Current Game
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

; [16-bit BE] Current Minigame/Story Match
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

; [8-bit] BGM id (wCurrentBGM values) for the current match/court; a tiebreak overrides it with $0e
wMatchBGM:: db
	ds 7

; [ASCII, 7 Bytes] Story Mode - Name of Main Character
wStoryModeNameOfMainCharacter:: ds 7

; [4 bytes] Live main character record +$07-$0a: name terminator and padding after the 7-character name
wStoryMainCharNamePad:: ds 4

; [8-bit] Story Mode - Main Character Overworld Sprite
;
; 0x00 - Alex
; 0x01 - Nina
; 0x02 - Harry
; 0x03 - Kate
; Loops for all other values
wStoryModeMainCharacterOverworldSprite:: db

; [8-bit] Story Mode - Main Character Overworld Sprite Color
;
; 0x00 - Green
; 0x01 - Pink
; 0x02 - Yellow
; 0x03 - Red
; 0x04 - Blue
; All other values result in glitched sprite
wStoryModeMainCharacterOverworldSpriteColor:: db

; [8-bit] Main character's gender: $00 = male, $01 = female. Set from StoryCharGenderTable by InitPlayerRecordFromTemplate, read-only after. Selects gendered dialogue lines through AdvanceDialogueTextCursor (e.g. $30:433/$30:434 "him"/"her", $31:60/$31:61 "He's"/"She's") and the overworld object def ($56 + gender)
wStoryModeGenderOfMainCharacter:: db

; [8-bit] Nonzero when the main character is left-handed (record +$0e). Written from wCharSelectHandedness by bank $38 and, on bank $02's new-game path, from bit 2 of the character id. Bank $17 swaps the spin-serve briefing between $36:696 and its mirror $36:697 on it
wStoryModeMainCharacterLeftHanded:: db

; [9 bytes] Live main character record +$0f-$17: AI and physics attributes from StoryCharacterRecords_02: +$0f personality byte, +$10-$17 reach windows, smash and dive speeds and reaction delays, refreshed by RecomputeCharacterStats from the +$30 template
wStoryMainCharPhysics:: ds 9

; [8-bit] EXP tier of the main character's record (+$18, the field LoadCharacterAttributes turns into wCharExpTier on court). ScaleExpByPlayerLevel averages it with wStoryPartnerCharExpTier and scales match EXP down against $0a
wStoryMainCharExpTier:: db

; [2 bytes] Live main character record +$19-$1a: swing attribute word
wStoryMainCharSwingAttrWord:: dw

; [5 bytes] Live main character record +$1b-$1f: AI personality parameters (docs/story_mode.md, "The character record")
wStoryMainCharAiParams:: ds 5

; [11 bytes] The eleven 0-9 stats of the main character's record (+$20): Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
wStoryMainCharStats:: ds 11
; [8-bit] Record +$2b: speed bonus, the last byte InitCa00RecordFromCharId copies from the roster row; LoadCharacterAttributes adds it to the Speed stat to pick the shot-placement row
wStoryMainCharSpeedBonus:: db

; [3 bytes] EXP in the main character's record (+$2c), capped at 99999 by AddExpCapped
wStoryMainCharExp:: ds 3
; [8-bit] Record +$2f: written by InitCa00RecordFromCharId ($02 roster, $03 story main character, $00 cleared); nothing reads it
wStoryMainCharBuildKind:: db

; [8 bytes] Live main character record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wStoryMainCharPhysicsTemplate:: ds 8

; [8-bit] Spin level (record +$38); the four levels shown on character select start here
wStoryMainCharSpinLevel:: db

; [8-bit] Power level, the record's +$39
wStoryMainCharPowerLevel:: db

; [8-bit] Control level, the record's +$3a
wStoryMainCharControlLevel:: db

; [8-bit] Speed level, the record's +$3b
wStoryMainCharSpeedLevel:: db

; [Lower4] Equipped Racket
;
; 0x0 - Normal Racket
; 0x1 - Large Racket
; 0x2 - Small Racket
; 0x3 - Iron Racket
; 0x4 - Gold Racket
; 0x5 - Silver Racket
; 0x6 - Drive Racket
;
; [Upper4] Equipped Shoes
;
; 0x0 - Normal Shoes
; 0x1 - Iron Shoes
; 0x2 - Light Shoes
wEquippedRacket:: db
	ds 3

; [ASCII, 7 Bytes] Story Mode - Name of Partner Character
wStoryModeNameOfPartnerCharacter:: ds 7

; [4 bytes] Live partner record +$07-$0a: name terminator and padding after the 7-character name
wStoryPartnerCharNamePad:: ds 4

; [8-bit] Partner Character Overworld Sprite; values as wStoryModeMainCharacterOverworldSprite
wStoryModePartnerCharacterOverworldSprite:: db

; [8-bit] Partner Character Overworld Sprite Color; values as wStoryModeMainCharacterOverworldSpriteColor
wStoryModePartnerCharacterOverworldSpriteColor:: db

; [8-bit] Doubles partner's gender ($00 male, $01 female). Selects the partner object def ($58 + gender) and, with the main character's, the four-way scene key (main << 1) | (main XOR partner) passed to RunStorySceneByMode in bank $13
wStoryModeGenderOfPartnerCharacter:: db

; [8-bit] Partner's left-handed flag (record +$0e), written by the same character-select path as wStoryModeMainCharacterLeftHanded
wStoryModePartnerCharacterLeftHanded:: db

; [9 bytes] Live partner record +$0f-$17: AI and physics attributes, as wStoryMainCharPhysics
wStoryPartnerCharPhysics:: ds 9

; [8-bit] EXP tier of the partner's record (+$18), the partner half of wStoryMainCharExpTier
wStoryPartnerCharExpTier:: db

; [2 bytes] Live partner record +$19-$1a: swing attribute word
wStoryPartnerCharSwingAttrWord:: dw

; [5 bytes] Live partner record +$1b-$1f: AI personality parameters
wStoryPartnerCharAiParams:: ds 5

; [11 bytes] Live partner record +$20-$2a: the eleven 0-9 stats, order as wStoryMainCharStats
wStoryPartnerCharStats:: ds 11
; [8-bit] Record +$2b: speed bonus (see wStoryMainCharSpeedBonus)
wStoryPartnerCharSpeedBonus:: db

; [3 bytes] EXP in the partner's record (+$2c), capped at 99999 by AddExpCapped
wStoryPartnerCharExp:: ds 3
; [8-bit] Record +$2f: build tag, write-only (see wStoryMainCharBuildKind)
wStoryPartnerCharBuildKind:: db

; [8 bytes] Live partner record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wStoryPartnerCharPhysicsTemplate:: ds 8

; [8-bit] Spin level (record +$38)
wStoryPartnerCharSpinLevel:: db

; [8-bit] Power level, the record's +$39
wStoryPartnerCharPowerLevel:: db

; [8-bit] Control level, the record's +$3a
wStoryPartnerCharControlLevel:: db

; [8-bit] Speed level, the record's +$3b
wStoryPartnerCharSpeedLevel:: db
	ds 52

; [16-bit] EXP a story match earned, pending like wPendingExpExhibition / wPendingExpLinked. ApplyPendingExpAwards adds it to wPendingExpTrophy, scales the total by player level and folds in the trophy awards
wPendingExpStory:: dw

; [16-bit] Trophy half of the pending award, summed with wPendingExpStory before scaling. Unused_02_ValidateN64TransferRecord and the debug stats screen treat the pair as the head of the N64 transfer record that wN64TransferMarker ends
wPendingExpTrophy:: dw

; [8-bit] Marker byte of the N64 transfer record at $c9b0: Unused_02_ValidateN64TransferRecord rejects the record unless it is $64, then checksums the bytes around it
wN64TransferMarker:: db

; [2 bytes] Trophies transferred from the N64 game, two bits per trophy (0-3) for eight trophies. DecodeTrophyCounts unpacks them into the trophy screen's cells; the EXP award path walks them tier by tier to pick a TrophyExpTierFlags row
wN64TrophyCounts:: dw
	ds 9

; [32 bytes] Per-story-slot progress flags, $c9c0-$c9df, saved as the slot's +$1c0 block. rst $20/$28/$30 (SetGameFlag/ClearGameFlag/TestGameFlag) take d = byte index, e = bit << 5 and apply mask $80 >> bit; the *GameFlagByNumber wrappers take the flat number byte * 8 + bit, as held by the FLAG_* constants in include/flag_constants.inc. The array is only accessed through these, so the named entries below are views of the same storage: byte $05 = doubles, $06/$07 = Island Open + Dream Match, $08-$0b = class rank wins, $0c/$0d = equipment owned, $18-$1b = training-drill clears, $1c-$1f = temporary (wGameFlagsTemp)
wGameFlags:: ds 5

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

; [Upper4] Story Mode - Minigame Completion Flags (4/4)
;
; Bit 7 - Wall Level 3
; Bit 6 - Wall Level 4
wStoryModeMinigameCompletionFlags4:: db

; [4 bytes] wGameFlags bytes $1c-$1f (flags $e0-$ff), temporary: ClearTemporaryStoryFlags zeroes them at the top of RunStoryLocation, so they last until the next location load. Used for per-location NPC/scene-variant state ($1c) and the screen-mode bits the progress and results screens set and clear ($1f)
wGameFlagsTemp:: ds 4
	ds 32

; [7 bytes] Display name of the player-1 main character, base of its $40-byte on-court character record. The results screen draws it via CopyStringToTextBuffer; LoadCharacterAttributes copies the record's physics and AI attributes into the character's banked struct
wPlayer1MainName:: ds 7

; [3 bytes] Player-1 main record +$07-$09: name terminator and padding
wPlayer1MainNamePad:: ds 3

; [8-bit] Record +$0a of the player-1 main record, borrowed by ExchangeLinkUnlockFlags as the cell the peer's bonus-court unlock mask arrives in. Whichever of this and wPlayer2MainLinkCourtMask matches the link role is copied to wLinkPartnerCourtMask, then both are cleared
wPlayer1MainLinkCourtMask:: db

; [8-bit] Player 1 Current Main Character
;
; 0x00 - Alex
; 0x01 - Nina
; 0x02 - Harry
; 0x03 - Kate
; 0x04 - Allie
; 0x05 - Joy
; 0x06 - Brian
; 0x07 - Pam
; 0x08 - Bob
; 0x09 - Beth
; 0x0a - Fay
; 0x0b - Curt
; 0x0c - Mark
; 0x0d - Sean
; 0x0e - Sammi
; 0x0f - Elden
; 0x10 - Spike
; 0x11 - Emily
; 0x12 - B. Coz
; 0x13 - A. Coz
; 0x14 - Kevin (dummied out)
; 0x15 - Tennis Machine
; 0x16 - Allie 2
; 0x17 - Luigi
; 0x18 - Donkey Kong
; 0x19 - Baby Mario
; 0x1a - Mario
; 0x1b - Waluigi
; 0x1c - Yoshi
; 0x1d - Bowser
; 0x1e - Wario
; 0x1f - Peach
wPlayer1CurrentMainCharacter:: db

; [8-bit] Palette index of the player-1 main character: LoadResultPortraitSlot passes it to LoadIndexedPalette_18; InitChar passes it plus 3 to SetupCharacterSprite as the OBJ palette
wPlayer1MainPalette:: db
; [8-bit] Record +$0d: gender, 0 male / 1 female (InitPlayerRecordFromTemplate; StoryCharGenderTable for story records)
wPlayer1MainGender:: db

; [8-bit] Nonzero mirrors the player-1 main character: LoadCharacterAttributes turns it into wCharMirrorAttrMask ($20, OAM X-flip) and the results-screen portrait XORs the same bit. ApplyStarFlagsToCharRecords seeds it from wCharSelectSlotStar
wPlayer1MainLeftHanded:: db

; [9 bytes] Player-1 main record +$0f-$17: AI and physics attributes, as wStoryMainCharPhysics
wPlayer1MainPhysics:: ds 9

; [8-bit] EXP tier of the player-1 main character (record +$18): the level (1-99) for a player character, the class tier for a roster NPC
wPlayer1MainExpTier:: db

; [2 bytes] Player-1 main record +$19-$1a: swing attribute word
wPlayer1MainSwingAttrWord:: dw

; [5 bytes] Player-1 main record +$1b-$1f: AI personality parameters (docs/story_mode.md, "The character record")
wPlayer1MainAiParams:: ds 5

; [11 bytes] Player-1 main record +$20-$2a: the eleven 0-9 stats, order as wStoryMainCharStats
wPlayer1MainStats:: ds 11
; [8-bit] Record +$2b: speed bonus (see wStoryMainCharSpeedBonus)
wPlayer1MainSpeedBonus:: db

; [3 bytes] Player-1 main record +$2c-$2e: EXP, capped at 99999 by AddExpCapped
wPlayer1MainExp:: ds 3
; [8-bit] Record +$2f: build tag, write-only (see wStoryMainCharBuildKind)
wPlayer1MainBuildKind:: db

; [8 bytes] Player-1 main record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wPlayer1MainPhysicsTemplate:: ds 8

; [4 bytes] Player-1 main record +$38-$3b: the four trainable levels: Spin, Power, Control, Speed
wPlayer1MainTrainLevels:: ds 4

; [8-bit] Equipment nibbles of the player-1 main character (as wEquippedRacket in the story record). ApplyMatchSettingsExpBonus gives a handicap EXP bonus: low nibble $03 is one step, high nibble $01 another, two steps double the match EXP
wPlayer1MainEquipment:: db
	ds 3

; [7 bytes] Display name and record base of the player-1 partner (doubles counterpart of wPlayer1MainName)
wPlayer1PartnerName:: ds 7

; [4 bytes] Player-1 partner record +$07-$0a: name terminator and padding
wPlayer1PartnerNamePad:: ds 4

; [8-bit] Player 1 Current Partner Character; values as wPlayer1CurrentMainCharacter
wPlayer1CurrentPartnerCharacter:: db

; [8-bit] Palette index of the player-1 partner (see wPlayer1MainPalette)
wPlayer1PartnerPalette:: db
; [8-bit] Record +$0d: gender, 0 male / 1 female (see wPlayer1MainGender)
wPlayer1PartnerGender:: db

; [8-bit] Mirror flag of the player-1 partner (see wPlayer1MainLeftHanded)
wPlayer1PartnerLeftHanded:: db

; [9 bytes] Player-1 partner record +$0f-$17: AI and physics attributes, as wStoryMainCharPhysics
wPlayer1PartnerPhysics:: ds 9

; [8-bit] EXP tier of the player-1 partner (record +$18). ApplyCpuDifficultyToCharRecords writes it from the difficulty row unless the slot is a created character, which keeps its earned tier
wPlayer1PartnerExpTier:: db

; [2 bytes] Player-1 partner record +$19-$1a: swing attribute word
wPlayer1PartnerSwingAttrWord:: dw

; [4 bytes] Four of the player-1 partner's six AI personality parameters (record +$1b-$1e; +$0f and +$1f are the others). ApplyCpuDifficultyToCharRecords copies them from the difficulty row; OverrideCharStatsForDebug rewrites this block
wPlayer1PartnerAiParams:: ds 4

; [8-bit] Exhibition Mode - Player Partner Character Difficulty
;
; 0x00 - Easy
; 0x01 - Normal
; 0x02 - Hard
; 0x03 - Intense
wExhibitionModePlayerPartnerCharacterDifficulty:: db

; [11 bytes] Player-1 partner record +$20-$2a: the eleven 0-9 stats, order as wStoryMainCharStats
wPlayer1PartnerStats:: ds 11
; [8-bit] Record +$2b: speed bonus (see wStoryMainCharSpeedBonus)
wPlayer1PartnerSpeedBonus:: db

; [3 bytes] Player-1 partner record +$2c-$2e: EXP, capped at 99999 by AddExpCapped
wPlayer1PartnerExp:: ds 3
; [8-bit] Record +$2f: build tag, write-only (see wStoryMainCharBuildKind)
wPlayer1PartnerBuildKind:: db

; [8 bytes] Player-1 partner record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wPlayer1PartnerPhysicsTemplate:: ds 8

; [4 bytes] Player-1 partner record +$38-$3b: the four trainable levels: Spin, Power, Control, Speed
wPlayer1PartnerTrainLevels:: ds 4
	ds 4

; [7 bytes] Display name and record base of the player-2 main character
wPlayer2MainName:: ds 7

; [3 bytes] Player-2 main record +$07-$09: name terminator and padding
wPlayer2MainNamePad:: ds 3

; [8-bit] The player-2 main record's copy of the unlock-mask exchange cell (see wPlayer1MainLinkCourtMask)
wPlayer2MainLinkCourtMask:: db

; [8-bit] Player 2 Current Main Character; values as wPlayer1CurrentMainCharacter
wPlayer2CurrentMainCharacter:: db

; [8-bit] Palette index of the player-2 main character (see wPlayer1MainPalette)
wPlayer2MainPalette:: db
; [8-bit] Record +$0d: gender, 0 male / 1 female (see wPlayer1MainGender)
wPlayer2MainGender:: db

; [8-bit] Mirror flag of the player-2 main character (see wPlayer1MainLeftHanded)
wPlayer2MainLeftHanded:: db

; [8-bit] Record +$0f: last byte of BooBlastInitParams, stored as the minigame is set up; nothing reads it back
wPlayer2MainInitByte:: db

; [8 bytes] Player-2 main record +$10-$17: reach windows, smash and dive speeds and reaction delays (as wStoryMainCharPhysics +1)
wPlayer2MainPhysicsFrom10:: ds 8

; [8-bit] EXP tier of the player-2 main character (see wPlayer1PartnerExpTier)
wPlayer2MainExpTier:: db

; [2 bytes] Player-2 main record +$19-$1a: swing attribute word
wPlayer2MainSwingAttrWord:: dw

; [4 bytes] Player-2 main character's AI parameter block (see wPlayer1PartnerAiParams); the bank $0b and $0d minigame setups write it to give a drill opponent a fixed personality
wPlayer2MainAiParams:: ds 4

; [8-bit] Exhibition Mode - CPU Main Character Difficulty; values as wExhibitionModePlayerPartnerCharacterDifficulty
wExhibitionModeCPUMainCharacterDifficulty:: db

; [11 bytes] Player-2 main record +$20-$2a: the eleven 0-9 stats, order as wStoryMainCharStats
wPlayer2MainStats:: ds 11
; [8-bit] Record +$2b: speed bonus (see wStoryMainCharSpeedBonus)
wPlayer2MainSpeedBonus:: db

; [3 bytes] Player-2 main record +$2c-$2e: EXP, capped at 99999 by AddExpCapped
wPlayer2MainExp:: ds 3
; [8-bit] Record +$2f: build tag, write-only (see wStoryMainCharBuildKind)
wPlayer2MainBuildKind:: db

; [8 bytes] Player-2 main record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wPlayer2MainPhysicsTemplate:: ds 8

; [4 bytes] Player-2 main record +$38-$3b: the four trainable levels: Spin, Power, Control, Speed
wPlayer2MainTrainLevels:: ds 4

; [8-bit] Equipment of the player-2 main character (see wPlayer1MainEquipment); read by the link-match EXP path when the local player is player 2
wPlayer2MainEquipment:: db
	ds 3

; [7 bytes] Display name and record base of the player-2 partner
wPlayer2PartnerName:: ds 7

; [4 bytes] Player-2 partner record +$07-$0a: name terminator and padding
wPlayer2PartnerNamePad:: ds 4

; [8-bit] Player 2 Current Partner Character; values as wPlayer1CurrentMainCharacter
wPlayer2CurrentPartnerCharacter:: db

; [8-bit] Palette index of the player-2 partner (see wPlayer1MainPalette)
wPlayer2PartnerPalette:: db
; [8-bit] Record +$0d: gender, 0 male / 1 female (see wPlayer1MainGender)
wPlayer2PartnerGender:: db

; [8-bit] Mirror flag of the player-2 partner (see wPlayer1MainLeftHanded)
wPlayer2PartnerLeftHanded:: db

; [9 bytes] Player-2 partner record +$0f-$17: AI and physics attributes, as wStoryMainCharPhysics
wPlayer2PartnerPhysics:: ds 9

; [8-bit] EXP tier of the player-2 partner (see wPlayer1PartnerExpTier)
wPlayer2PartnerExpTier:: db

; [2 bytes] Player-2 partner record +$19-$1a: swing attribute word
wPlayer2PartnerSwingAttrWord:: dw

; [4 bytes] The player-2 partner's AI parameter block (see wPlayer1PartnerAiParams)
wPlayer2PartnerAiParams:: ds 4

; [8-bit] Exhibition Mode - CPU Partner Character Difficulty; values as wExhibitionModePlayerPartnerCharacterDifficulty
wExhibitionModeCPUPartnerCharacterDifficulty:: db

; [11 bytes] Player-2 partner record +$20-$2a: the eleven 0-9 stats, order as wStoryMainCharStats
wPlayer2PartnerStats:: ds 11
; [8-bit] Record +$2b: speed bonus (see wStoryMainCharSpeedBonus)
wPlayer2PartnerSpeedBonus:: db

; [3 bytes] Player-2 partner record +$2c-$2e: EXP, capped at 99999 by AddExpCapped
wPlayer2PartnerExp:: ds 3
; [8-bit] Record +$2f: build tag, write-only (see wStoryMainCharBuildKind)
wPlayer2PartnerBuildKind:: db

; [8 bytes] Player-2 partner record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wPlayer2PartnerPhysicsTemplate:: ds 8

; [4 bytes] Player-2 partner record +$38-$3b: the four trainable levels: Spin, Power, Control, Speed
wPlayer2PartnerTrainLevels:: ds 4
	ds 4

# Mario Tennis (GBC) RAM Map

Source: [RetroAchievements Code Notes for Mario Tennis (Game Boy Color)](https://retroachievements.org/game/5043) - community-contributed RAM addresses ("Code Notes"), downloaded 2026-07-10.

Game: Mario Tennis (Game Boy Color). Addresses are real GBC CPU addresses: cartridge SRAM `$a000`-`$bfff`, WRAM `$c000`-`$dfff`, HRAM `$ff80`-`$fffe`.

| Address | Region | Name | Note |
|---|---|---|---|
| `0xa042` | SRAM | `sMarioMinigameCompletionFlags1` | [Lower4] Mario Minigame Completion Flags (1/4)<br><br>Bit 3 - Boo Blast Level 1<br>Bit 2 - Boo Blast Level 2<br>Bit 1 - Boo Blast Level 3<br>Bit 0 - Shooting Star Level 1 |
| `0xa043` | SRAM | `sMarioMinigameCompletionFlags2` | [8-bit] Mario Minigame Completion Flags (2/4)<br><br>Bit 7 - Shooting Star Level 2<br>Bit 6 - Shooting Star Level 3<br>Bit 5 - Perfect Shot Level 1<br>Bit 4 - Perfect Shot Level 2<br>Bit 3 - Perfect Shot Level 3<br>Bit 2 - Target Shot Level 1<br>Bit 1 - Target Shot Level 2<br>Bit 0 - Target Shot Level 3 |
| `0xa045` | SRAM | `sMarioMinigameCompletionFlags3` | [8-bit] Mario Minigame Completion Flags (3/4)<br><br>Bit 7 - Fruit Fantasy Level 1<br>Bit 6 - Fruit Fantasy Level 2<br>Bit 5 - Fruit Fantasy Level 3<br>Bit 4 - Banana Bunch Level 1<br>Bit 3 - Banana Bunch Level 2<br>Bit 2 - Banana Bunch Level 3<br>Bit 1 - Treasure Box Level 1<br>Bit 0 - Treasure Box Level 2 |
| `0xa046` | SRAM | `sMarioMinigameCompletionFlags4` | [8-bit] Mario Minigame Completion Flags (4/4)<br><br>Bit 7 - Treasure Box Level 3<br>Bit 6 - Medallion Match Level 1<br>Bit 5 - Medallion Match Level 2<br>Bit 4 - Medallion Match Level 3<br>Bit 3 - Two-On-One Level 1<br>Bit 2 - Two-On-One Level 2<br>Bit 1 - Two-On-One Level 3 |
| `0xa047` | SRAM | `sCourtUnlockFlags` | [8-bit] Court Unlock Flags<br><br>Bit 6 - Star Court<br>Bit 5 - Castle Court<br>Bit 4 - Tropics Court<br>Bit 3 - Jungle Court<br>Bit 2 - Warehouse Court |
| `0xc280` | WRAM | `wStoryModeCurrentLocation` | [8-bit] Story Mode - Current Location<br><br>0x00 - Not in Story Mode<br>0x05 - Academy Main Building<br>0x06 - Academy Wing<br>0x07 - Courtyard<br>0x08 - Restaurant Plaza<br>0x09 - Dorm Entrance<br>0x0a - Dormitory<br>0x0b, 0x0c - Junior Class Court<br>0x0d - Restaurant<br>0x0e - Cafeteria<br>0x0f - Training Court<br>0x10 - Senior Class Court<br>0x11 - Training Center<br>0x12 - Tennis Machine Room<br>0x13 - Wall Practice Room<br>0x14 - Academy Entrance<br>0x15 - Tournament Courtyard<br>0x16 - Court #1<br>0x17 - Court #2<br>0x18 - Center Court<br>0x19 - Tournament<br>0x1a - Awards Ceremony<br>0x1b - Plane Cutscene<br>0x1c - Castle Court<br>0x1d - Peach's Castle<br>0x1e-0x29 - Final Credits Sequence |
| `0xc2b4` | WRAM | `wWaterSpriteMinigameTimer` | [16-bit] Water Sprite Minigame - Timer (Frames) |
| `0xc2b6` | WRAM | `wWaterSpriteMinigameSwingCount` | [16-bit] Water Sprite Minigame - Swing Count |
| `0xc2ba` | WRAM | `wWaterSpriteMinigameFlag` | [8-bit] Water Sprite Minigame Flag (0x17 when in minigame) |
| `0xc2d0` | WRAM | `wStoryModePlayersXPosition` | [16-bit] Story Mode - Player's X Position |
| `0xc2d2` | WRAM | `wStoryModePlayersYPosition` | [16-bit] Story Mode - Player's Y Position |
| `0xc33e` | WRAM | `wCurrentBGM` | [8-bit] Current BGM<br><br>0x00 - Silence<br>0x01 - Intro Cutscene<br>0x02 - Title Screen<br>0x03 - Main Menu<br>0x04 - Status Screen<br>0x05 - Dictionary<br>0x06 - Exhibition Match<br>0x07 - Unused<br>0x08 - Mario Minigame Screen<br>0x09 - You Win<br>0x0a - You Lose<br>0x0b - Earning EXP<br>0x0c - Distributing EXP<br>0x0d - Distributing Stats<br>0x0e - Tiebreaker<br>0x0f - Set/Match Point<br>0x10 - Game Point<br>0x11 - Star Court<br>0x12 - Castle Court/Peach's Castle<br>0x13 - Tropic Court/Fruit Fantasy<br>0x14 - Warehouse Court/Treasure Box<br>0x15 - Two-on-One<br>0x16 - Jungle Court/Banana Bunch<br>0x17 - Unused<br>0x18 - Unused<br>0x19 - Shooting Star/Target Shot/Medallion Match<br>0x1a - Academy Main Building<br>0x1b - Story Mode Outdoors<br>0x1c - Dormitory<br>0x1d - Story Mode Indoors<br>0x1e - Tennis Machine<br>0x1f - Wall Practice<br>0x20 - Practice Match<br>0x21 - Junior Ranking Match<br>0x22 - Senior Ranking Match<br>0x23 - Varsity Ranking Match<br>0x24 - Training Court Match<br>0x25 - Training Court Practice<br>0x26 - Island Open Beginning Rounds<br>0x27 - Island Open Semifinals<br>0x28 - Island Open Finals<br>0x29 - Dream Match<br>0x2a - Unused<br>0x2b - Island Open Congratulations<br>0x2c - Credits<br>0x2d - The End<br>0x2e - Done For The Day<br>0x2f - Level Up<br>0x30 - High Score<br>0x31 - Exhibition Match Start<br>0x32 - Story Match Start |
| `0xc376` | WRAM | `wMinigameLevel` | [8-bit] Minigame Level (0x00-0x03)<br><br>Value is current minigame level - 1 |
| `0xc47c` | WRAM | `wMinigamesCurrentScore` | [16-bit] Minigames - Current Score |
| `0xc47e` | WRAM | `wMinigamesTargetScore` | [16-bit] Minigames - Target Score |
| `0xc4b6` | WRAM | `wRallyLength` | [8-bit] Rally Length; number of times the ball was hit in the span of a point |
| `0xc4d3` | WRAM | `wCurrentServingPlayer` | [8-bit] Current Serving Player (0x00-0x03) |
| `0xc818` | WRAM | `wStoryModeMainCharacterLevel` | [8-bit] Story Mode - Main Character Level (0x01-0x63) |
| `0xc820` | WRAM | `wStoryModeMainCharacterTopStat` | [8-bit] Story Mode - Main Character Top Stat (0x00-0x09) |
| `0xc821` | WRAM | `wStoryModeMainCharacterSliceStat` | [8-bit] Story Mode - Main Character Slice Stat (0x00-0x09) |
| `0xc822` | WRAM | `wStoryModeMainCharacterServeStat` | [8-bit] Story Mode - Main Character Serve Stat (0x00-0x09) |
| `0xc823` | WRAM | `wStoryModeMainCharacterStrokeStat` | [8-bit] Story Mode - Main Character Stroke Stat (0x00-0x09) |
| `0xc824` | WRAM | `wStoryModeMainCharacterVolleyStat` | [8-bit] Story Mode - Main Character Volley Stat (0x00-0x09) |
| `0xc825` | WRAM | `wStoryModeMainCharacterAngleStat` | [8-bit] Story Mode - Main Character Angle Stat (0x00-0x09) |
| `0xc826` | WRAM | `wStoryModeMainCharacterPlacementStat` | [8-bit] Story Mode - Main Character Placement Stat (0x00-0x09) |
| `0xc827` | WRAM | `wStoryModeMainCharacterSpeedStat` | [8-bit] Story Mode - Main Character Speed Stat (0x00-0x09) |
| `0xc828` | WRAM | `wStoryModeMainCharacterDashStat` | [8-bit] Story Mode - Main Character Dash Stat (0x00-0x09) |
| `0xc829` | WRAM | `wStoryModeMainCharacterReactionStat` | [8-bit] Story Mode - Main Character Reaction Stat (0x00-0x09) |
| `0xc82a` | WRAM | `wStoryModeMainCharacterStopStat` | [8-bit] Story Mode - Main Character Stop Stat (0x00-0x09) |
| `0xc82c` | WRAM | `wStoryModeMainCharacterEXP` | [16-bit] Story Mode - Main Character EXP |
| `0xc838` | WRAM | `wStoryModeMainCharacterSpinLevel` | [8-bit] Story Mode - Main Character Spin Level |
| `0xc839` | WRAM | `wStoryModeMainCharacterPowerLevel` | [8-bit] Story Mode - Main Character Power Level |
| `0xc83a` | WRAM | `wStoryModeMainCharacterControlLevel` | [8-bit] Story Mode - Main Character Control Level |
| `0xc83b` | WRAM | `wStoryModeMainCharacterSpeedLevel` | [8-bit] Story Mode - Main Character Speed Level |
| `0xc858` | WRAM | `wStoryModePartnerCharacterLevel` | [8-bit] Story Mode - Partner Character Level (0x01-0x63) |
| `0xc860` | WRAM | `wStoryModePartnerCharacterTopStat` | [8-bit] Story Mode - Partner Character Top Stat (0x00-0x09) |
| `0xc861` | WRAM | `wStoryModePartnerCharacterSliceStat` | [8-bit] Story Mode - Partner Character Slice Stat (0x00-0x09) |
| `0xc862` | WRAM | `wStoryModePartnerCharacterServeStat` | [8-bit] Story Mode - Partner Character Serve Stat (0x00-0x09) |
| `0xc863` | WRAM | `wStoryModePartnerCharacterStrokeStat` | [8-bit] Story Mode - Partner Character Stroke Stat (0x00-0x09) |
| `0xc864` | WRAM | `wStoryModePartnerCharacterVolleyStat` | [8-bit] Story Mode - Partner Character Volley Stat (0x00-0x09) |
| `0xc865` | WRAM | `wStoryModePartnerCharacterAngleStat` | [8-bit] Story Mode - Partner Character Angle Stat (0x00-0x09) |
| `0xc866` | WRAM | `wStoryModePartnerCharacterPlacementStat` | [8-bit] Story Mode - Partner Character Placement Stat (0x00-0x09) |
| `0xc867` | WRAM | `wStoryModePartnerCharacterSpeedStat` | [8-bit] Story Mode - Partner Character Speed Stat (0x00-0x09) |
| `0xc868` | WRAM | `wStoryModePartnerCharacterDashStat` | [8-bit] Story Mode - Partner Character Dash Stat (0x00-0x09) |
| `0xc869` | WRAM | `wStoryModePartnerCharacterReactionStat` | [8-bit] Story Mode - Partner Character Reaction Stat (0x00-0x09) |
| `0xc86a` | WRAM | `wStoryModePartnerCharacterStopStat` | [8-bit] Story Mode - Partner Character Stop Stat (0x00-0x09) |
| `0xc86c` | WRAM | `wStoryModePartnerCharacterEXP` | [16-bit] Story Mode - Partner Character EXP |
| `0xc878` | WRAM | `wStoryModePartnerCharacterSpinLevel` | [8-bit] Story Mode - Partner Character Spin Level |
| `0xc879` | WRAM | `wStoryModePartnerCharacterPowerLevel` | [8-bit] Story Mode - Partner Character Power Level |
| `0xc87a` | WRAM | `wStoryModePartnerCharacterControlLevel` | [8-bit] Story Mode - Partner Character Control Level |
| `0xc87b` | WRAM | `wStoryModePartnerCharacterSpeedLevel` | [8-bit] Story Mode - Partner Character Speed Level |
| `0xc8a4` | WRAM | `wMessageSpeed` | [8-bit] Message Speed<br><br>0x00 - Fast<br>0x01 - Normal<br>0x02 - Slow |
| `0xc8a6` | WRAM | `wGameMode` | [8-bit] Game Mode<br><br>0x00 - Not playing tennis<br>0x01 - Story Mode - Ranking Match<br>0x02 - Story Mode - Island Open Match<br>0x03 - Story Mode - Practice Match<br>0x04 - Exhibition Mode<br>0x05 - Story Mode - Training Court Minigames<br>0x06 - Story Mode - Tennis Machine<br>0x07 - Story Mode - Wall Practice<br>0x08 - Mario Minigames<br>0x0a - Story Mode - Dream Match |
| `0xc8c0` | WRAM | `wCharacter1ServiceAces` | [8-bit] Character 1 Service Aces |
| `0xc8c1` | WRAM | `wCharacter1ReturnAces` | [8-bit] Character 1 Return Aces |
| `0xc8c2` | WRAM | `wCharacter1SmashAces` | [8-bit] Character 1 Smash Aces |
| `0xc8c3` | WRAM | `wCharacter1LobShotWinners` | [8-bit] Character 1 Lob Shot Winners |
| `0xc8c4` | WRAM | `wCharacter1DropShotWinners` | [8-bit] Character 1 Drop Shot Winners |
| `0xc8c5` | WRAM | `wCharacter1Faults` | [8-bit] Character 1 Faults |
| `0xc8c6` | WRAM | `wCharacter1DoubleFaults` | [8-bit] Character 1 Double Faults |
| `0xc8c8` | WRAM | `wCharacter2ServiceAces` | [8-bit] Character 2 Service Aces |
| `0xc8c9` | WRAM | `wCharacter2ReturnAces` | [8-bit] Character 2 Return Aces |
| `0xc8ca` | WRAM | `wCharacter2SmashAces` | [8-bit] Character 2 Smash Aces |
| `0xc8cb` | WRAM | `wCharacter2LobShotWinners` | [8-bit] Character 2 Lob Shot Winners |
| `0xc8cc` | WRAM | `wCharacter2DropShotWinners` | [8-bit] Character 2 Drop Shot Winners |
| `0xc8cd` | WRAM | `wCharacter2Faults` | [8-bit] Character 2 Faults |
| `0xc8ce` | WRAM | `wCharacter2DoubleFaults` | [8-bit] Character 2 Double Faults |
| `0xc8d0` | WRAM | `wCharacter3ServiceAces` | [8-bit] Character 3 Service Aces |
| `0xc8d1` | WRAM | `wCharacter3ReturnAces` | [8-bit] Character 3 Return Aces |
| `0xc8d2` | WRAM | `wCharacter3SmashAces` | [8-bit] Character 3 Smash Aces |
| `0xc8d3` | WRAM | `wCharacter3LobShotWinners` | [8-bit] Character 3 Lob Shot Winners |
| `0xc8d4` | WRAM | `wCharacter3DropShotWinners` | [8-bit] Character 3 Drop Shot Winners |
| `0xc8d5` | WRAM | `wCharacter3DropShotWinners2` | [8-bit] Character 3 Drop Shot Winners |
| `0xc8d6` | WRAM | `wCharacter3DoubleFaults` | [8-bit] Character 3 Double Faults |
| `0xc8d8` | WRAM | `wCharacter4ServiceAces` | [8-bit] Character 4 Service Aces |
| `0xc8d9` | WRAM | `wCharacter4ReturnAces` | [8-bit] Character 4 Return Aces |
| `0xc8da` | WRAM | `wCharacter4SmashAces` | [8-bit] Character 4 Smash Aces |
| `0xc8db` | WRAM | `wPlayer4LobShotWinners` | [8-bit] Player 4 Lob Shot Winners |
| `0xc8dc` | WRAM | `wCharacter4DropShotWinners` | [8-bit] Character 4 Drop Shot Winners |
| `0xc8dd` | WRAM | `wCharacter4Faults` | [8-bit] Character 4 Faults |
| `0xc8de` | WRAM | `wCharacter4DoubleFaults` | [8-bit] Character 4 Double Faults |
| `0xc8e0` | WRAM | `wPlayer1SetsWon` | [8-bit] Player 1 Sets Won (0x00-0x03) |
| `0xc8e1` | WRAM | `wPlayer2SetsWon` | [8-bit] Player 2 Sets Won (0x00-0x03) |
| `0xc8e2` | WRAM | `wPlayer1GamesWon` | [8-bit] Player 1 Games Won (0x00-0x07) |
| `0xc8e3` | WRAM | `wPlayer2GamesWon` | [8-bit] Player 2 Games Won (0x00-0x07) |
| `0xc8e4` | WRAM | `wPlayer1PointsWon` | [8-bit] Player 1 Points Won<br><br>0x00 - 0<br>0x01 - 15<br>0x02 - 30<br>0x03 - 40<br>0x04 - Advantage/Deuce<br>0x05-0x07 - Tiebreaker only |
| `0xc8e5` | WRAM | `wPlayer2PointsWon` | [8-bit] Player 2 Points Won; for values see 0xc8e4 |
| `0xc8e6` | WRAM | `wDeuceIndicator` | [8-bit] Deuce Indicator (0x01 when deuce, 0x00 otherwise) |
| `0xc8e7` | WRAM | `wTiebreakerIndicator` | [8-bit] Tiebreaker Indicator (0x01 when tiebreaker, 0x00 otherwise) |
| `0xc8e8` | WRAM | `wMatchWinLoseFlag` | [8-bit] Match Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise) |
| `0xc8e9` | WRAM | `wSetWinLoseFlag` | [8-bit] Set Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise) |
| `0xc8ea` | WRAM | `wGameWinLoseFlag` | [8-bit] Game Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise)) |
| `0xc8eb` | WRAM | `wPointWinLoseFlag` | [8-bit] Point Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise) |
| `0xc8ec` | WRAM | `wTotalGamesWonInMatch` | [8-bit] Total Games Won In Match |
| `0xc8ed` | WRAM | `wTotalPointsScoredInCurrentGame` | [8-bit] Total Points Scored In Current Game |
| `0xc8f0` | WRAM | `wMatchTypeNumberOfSets` | [8-bit] Match Type - Number Of Sets (0x01, 0x03, 0x05) |
| `0xc8f1` | WRAM | `wMatchTypeNumberOfGames` | [8-bit] Match Type - Number Of Games (0x02, 0x06) |
| `0xc8f4` | WRAM | `wCurrentlyUsedCourt` | [8-bit] Currently Used Court<br><br>0x00 - Hard Court<br>0x01 - Clay Court<br>0x02 - Grass Court (Exhibition)<br>0x03 - Composition Court<br>0x04 - Star Court<br>0x05 - Castle Court<br>0x06 - Tropics Court<br>0x07 - Jungle Court<br>0x08 - Warehouse Court<br>0x09 - Training Court (Practice)<br>0x0a - Tennis Machine<br>0x0b - Wall Practice<br>0x0c - Center Court (Island Open Finals)<br>0x0d - Grass Court (Island Open)<br>0x0f - Target Shot<br>0x10 - Shooting Star<br>0x11 - Banana Bunch<br>0x12 - Boo Blast<br>0x13 - Perfect Shot<br>0x14 - Treasure Box<br>0x15 - Medallion Match<br>0x16 - Fruit Fantasy<br>0x17 - Two-On-One<br>0x18 - Training Court (Match) |
| `0xc8f6` | WRAM | `wCurrentMinigameStoryMatch` | [16-bit BE] Current Minigame/Story Match<br><br>0x0000 - Singles Junior Practice Match<br>0x0001 - Singles Junior #4<br>0x0002 - Singles Junior #3<br>0x0003 - Singles Junior #2<br>0x0004 - Singles Junior #1<br>0x0005 - Singles Senior Practice Match<br>0x0006 - Singles Senior #4<br>0x0007 - Singles Senior #3<br>0x0008 - Singles Senior #2<br>0x0009 - Singles Senior #1<br>0x000a - Singles Varsity Practice Match<br>0x000b - Singles Varsity #4<br>0x0010 - Singles Island Open Round 1<br>0x0011 - Singles Island Open Round 2<br>0x0012 - Singles Island Open Semifinals<br>0x0013 - Singles Island Open Finals<br>0x0016 - Singles Dream Match (MAX)<br>0x0017 - Singles Dream Match (Intense)<br>0x0018 - Singles Dream Match (Hard/First time)<br>0x0100 - Doubles Junior Practice Match<br>0x0102 - Doubles Junior #3<br>0x0103 - Doubles Junior #2<br>0x0104 - Doubles Junior #1<br>0x0105 - Doubles Senior Practice Match<br>0x0107 - Doubles Senior #3<br>0x0108 - Doubles Senior #2<br>0x0109 - Doubles Senior #1<br>0x010a - Doubles Varsity Practice Match<br>0x010d - Doubles Varsity #2<br>0x0111 - Doubles Island Open Round 1<br>0x0112 - Doubles Island Open Semifinals<br>0x0113 - Doubles Island Open Finals<br>0x0116 - Doubles Dream Match (MAX)<br>0x0117 - Doubles Dream Match (Intense)<br>0x0118 - Doubles Dream Match (Hard/First time)<br>0x0200 - Service Match 1<br>0x0201 - Service Match 2<br>0x0202 - Service Match 3<br>0x0203 - Service Practice 1<br>0x0204 - Service Practice 2<br>0x0205 - Service Practice 3<br>0x0206 - Net Play Match 1<br>0x0207 - Net Play Match 2<br>0x0208 - Net Play Match 3<br>0x0209 - Net Play Practice 1<br>0x020a - Net Play Practice 2<br>0x020b - Net Play Practice 3<br>0x020c - Stroke Match 1<br>0x020d - Stroke Match 2<br>0x020e - Stroke Match 3<br>0x020f - Stroke Practice 1<br>0x0210 - Stroke Practice 2<br>0x0211 - Stroke Practice 3<br>0x0212 - Tennis Machine 1<br>0x0213 - Tennis Machine 2<br>0x0214 - Tennis Machine 3<br>0x0215 - Tennis Machine 4<br>0x0216 - Wall Practice 1<br>0x0217 - Wall Practice 2<br>0x0218 - Wall Practice 3<br>0x0219 - Wall Practice 4<br>0x021a - Tennis Machine High Score<br>0x021b - Wall Practice High Score<br>0x021c - Boo Blast<br>0x021d - Shooting Star<br>0x021e - Perfect Shot<br>0x021f - Target Shot<br>0x0220 - Fruit Fantasy<br>0x0221 - Banana Bunch<br>0x0222 - Treasure Box<br>0x0223 - Medallion Match<br>0x0224 - Two-On-One |
| `0xc900` | WRAM | `wStoryModeNameOfMainCharacter` | [ASCII, 7 Bytes] Story Mode - Name of Main Character |
| `0xc90b` | WRAM | `wStoryModeMainCharacterOverworldSprite` | [8-bit] Story Mode - Main Character Overworld Sprite<br><br>0x00 - Alex<br>0x01 - Nina<br>0x02 - Harry<br>0x03 - Kate<br>Loops for all other values |
| `0xc90c` | WRAM | `wStoryModeMainCharacterOverworldSpriteColor` | [8-bit] Story Mode - Main Character Overworld Sprite Color<br><br>0x00 - Green<br>0x01 - Pink<br>0x02 - Yellow<br>0x03 - Red<br>0x04 - Blue<br>All other values result in glitched sprite |
| `0xc93c` | WRAM | `wEquippedRacket` | [Lower4] Equipped Racket<br><br>0x0 - Normal Racket<br>0x1 - Large Racket<br>0x2 - Small Racket<br>0x3 - Iron Racket<br>0x4 - Gold Racket<br>0x5 - Silver Racket<br>0x6 - Drive Racket<br><br>[Upper4] Equipped Shoes<br><br>0x0 - Normal Shoes<br>0x1 - Iron Shoes<br>0x2 - Light Shoes |
| `0xc940` | WRAM | `wStoryModeNameOfPartnerCharacter` | [ASCII, 7 Bytes] Story Mode - Name of Partner Character |
| `0xc94b` | WRAM | `wStoryModePartnerCharacterOverworldSprite` | [8-bit] Story Mode - Partner Character Overworld Sprite; for values see 0x00c90b |
| `0xc94c` | WRAM | `wStoryModePartnerCharacterOverworldSpriteColor` | [8-bit] Story Mode - Partner Character Overworld Sprite Color; for values see 0x00c90c |
| `0xc9c5` | WRAM | `wSinglesDoublesIndicator` | [8-bit] Singles/Doubles Indicator (Story & Exhibition Mode)<br><br>0x00 - Singles<br>0x01 - Doubles |
| `0xc9c6` | WRAM | `wStoryModeMatchCompletionFlags1` | [Lower4] Story Mode - Match Completion Flags (1/6)<br><br>Bit 0 - Doubles Island Open Round 1<br>Bit 1 - Doubles Island Open Semifinals<br>Bit 2 - Doubles Island Open Finals<br>Bit 3 - Doubles Dream Match |
| `0xc9c7` | WRAM | `wStoryModeMatchCompletionFlags2` | [8-bit] Story Mode - Match Completion Flags (2/6)<br><br>Bit 0 - Singles Island Open Round 1<br>Bit 1 - Singles Island Open Round 2<br>Bit 2 - Singles Island Open Semifinals<br>Bit 3 - Singles Island Open Finals<br>Bit 4 - Singles Dream Match |
| `0xc9c8` | WRAM | `wStoryModeMatchCompletionFlags3` | [8-bit] Story Mode - Match Completion Flags (3/6)<br><br>Bit 7 - Doubles Junior Rank 3<br>Bit 6 - Doubles Junior Rank 2<br>Bit 5 - Doubles Junior Rank 1<br>Bit 3 - Doubles Senior Rank 3<br>Bit 2 - Doubles Senior Rank 2<br>Bit 1 - Doubles Senior Rank 1 |
| `0xc9c9` | WRAM | `wStoryModeMatchCompletionFlags4` | [Upper4] Story Mode - Match Completion Flags (4/6)<br><br>Bit 7 - Doubles Varsity Rank 2 |
| `0xc9ca` | WRAM | `wStoryModeMatchCompletionFlags5` | [8-bit] Story Mode - Match Completion Flags (5/6)<br><br>Bit 7 - Singles Junior Rank 4<br>Bit 6 - Singles Junior Rank 3<br>Bit 5 - Singles Junior Rank 2<br>Bit 4 - Singles Junior Rank 1<br>Bit 3 - Singles Senior Rank 4<br>Bit 2 - Singles Senior Rank 3<br>Bit 1 - Singles Senior Rank 2<br>Bit 0 - Singles Senior Rank 1 |
| `0xc9cb` | WRAM | `wStoryModeMatchCompletionFlags6` | [Upper4] Story Mode - Match Completion Flags (6/6)<br><br>Bit 7 - Singles Varsity Rank 4 |
| `0xc9cc` | WRAM | `wStoryModeEquipmentFlags1` | [8-bit] Story Mode - Equipment Flags (1/2)<br><br>Bit 6 - Large Racket<br>Bit 5 - Small Racket<br>Bit 4 - Iron Racket<br>Bit 3 - Silver Racket<br>Bit 2 - Gold Racket<br>Bit 1 - Drive Racket<br>Bit 0 - Iron Shoes |
| `0xc9cd` | WRAM | `wStoryModeEquipmentFlags2` | [Upper4] Story Mode - Equipment Flags (2/2)<br><br>Bit 7 - Light Shoes |
| `0xc9d8` | WRAM | `wStoryModeMinigameCompletionFlags1` | [8-bit] Story Mode - Minigame Completion Flags (1/4)<br><br>Bit 7 - Service Match 1<br>Bit 6 - Service Match 2<br>Bit 5 - Service Match 3<br>Bit 4 - Service Practice 1<br>Bit 3 - Service Practice 2<br>Bit 2 - Service Practice 3<br>Bit 1 - Net Play Match 1<br>Bit 0 - Net Play Match 2 |
| `0xc9d9` | WRAM | `wStoryModeMinigameCompletionFlags2` | [8-bit] Story Mode - Minigame Completion Flags (2/4)<br><br>Bit 7 - Net Play Match 3<br>Bit 6 - Net Play Practice 1<br>Bit 5 - Net Play Practice 2<br>Bit 4 - Net Play Practice 3<br>Bit 3 - Stroke Match 1<br>Bit 2 - Stroke Match 2<br>Bit 1 - Stroke Match 3<br>Bit 0 - Stroke Practice 1 |
| `0xc9da` | WRAM | `wStoryModeMinigameCompletionFlags3` | [8-bit] Story Mode - Minigame Completion Flags (3/4)<br><br>Bit 7 - Stroke Practice 2<br>Bit 6 - Stroke Practice 3<br>Bit 5 - Machine Level 1<br>Bit 4 - Machine Level 2<br>Bit 3 - Machine Level 3<br>Bit 2 - Machine Level 4<br>Bit 1 - Wall Level 1<br>Bit 0 - Wall Level 2 |
| `0xc9db` | WRAM | `wStoryModeMinigameCompletionFlags4` | [Upper4] Story Mode - Minigame Completion Flags (4/4)<br><br>Bit 7 - Wall Level 3<br>Bit 6 - Wall Level 4 |
| `0xca0b` | WRAM | `wPlayer1CurrentMainCharacter` | [8-bit] Player 1 Current Main Character<br><br>0x00 - Alex<br>0x01 - Nina<br>0x02 - Harry<br>0x03 - Kate<br>0x04 - Allie<br>0x05 - Joy<br>0x06 - Brian<br>0x07 - Pam<br>0x08 - Bob<br>0x09 - Beth<br>0x0a - Fay<br>0x0b - Curt<br>0x0c - Mark<br>0x0d - Sean<br>0x0e - Sammi<br>0x0f - Elden<br>0x10 - Spike<br>0x11 - Emily<br>0x12 - B. Coz<br>0x13 - A. Coz<br>0x14 - Kevin (dummied out)<br>0x15 - Tennis Machine<br>0x16 - Allie 2 (never shows up?)<br>0x17 - Luigi<br>0x18 - Donkey Kong<br>0x19 - Baby Mario<br>0x1a - Mario<br>0x1b - Waluigi<br>0x1c - Yoshi<br>0x1d - Bowser<br>0x1e - Wario<br>0x1f - Peach |
| `0xca4b` | WRAM | `wPlayer1CurrentPartnerCharacter` | [8-bit] Player 1 Current Partner Character; for values see 0xca0b |
| `0xca5f` | WRAM | `wExhibitionModePlayerPartnerCharacterDifficulty` | [8-bit] Exhibition Mode - Player Partner Character Difficulty<br><br>0x00 - Easy<br>0x01 - Normal<br>0x02 - Hard<br>0x03 - Intense |
| `0xca8b` | WRAM | `wPlayer2CurrentMainCharacter` | [8-bit] Player 2 Current Main Character; for values see 0xca0b |
| `0xca9f` | WRAM | `wExhibitionModeCPUMainCharacterDifficulty` | [8-bit] Exhibition Mode - CPU Main Character Difficulty; for values see 0x00ca5f |
| `0xcacb` | WRAM | `wPlayer2CurrentPartnerCharacter` | [8-bit] Player 2 Current Partner Character; for values see 0xca0b |
| `0xcadf` | WRAM | `wExhibitionModeCPUPartnerCharacterDifficulty` | [8-bit] Exhibition Mode - CPU Partner Character Difficulty; for values see 0x00ca5f |
| `0xcb41` | WRAM | `wIntroCutsceneCheck` | [8-bit] Intro Cutscene Check (0x00 when in intro cutscene, 0x01 otherwise) |
| `0xff90` | HRAM | `hPlayerInputFlags` | [8-bit] Player Input Flags<br><br>Bit 7 - Down<br>Bit 6 - Up<br>Bit 5 - Left<br>Bit 4 - Right<br>Bit 3 - Start<br>Bit 2 - Select<br>Bit 1 - B<br>Bit 0 - A |
| `0xffce` | HRAM | `hMusic` | [8-bit] Music (0x00 - on, 0x01 - off) |

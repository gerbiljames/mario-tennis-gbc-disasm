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

## Project-identified addresses (not in the RA notes)

Addresses named by this project from disassembly evidence; also in
`ram_map.json` so `disasm.py` renders them symbolically.

| Address | Region | Name | Note |
|---|---|---|---|
| `0xc295` | WRAM | `wStoryModeEntryPoint` | [8-bit] Story Mode - entry point / spawn-door ID for the location being loaded; $ff = none (keep saved player position). LoadStoryEntryPointRecord searches the location's entry table with it |
| `0xc296` | WRAM | `wStoryModeSpawnPosition` | [5 bytes] Story Mode - player spawn/return buffer: X (16-bit), Y (16-bit), facing; filled from the matched entry-point record or backed up from wStoryModePlayersXPosition before a submode |
| `0xc2a0` | WRAM | `wStoryModeTriggerScript` | [8-bit] Story Mode - queued tile trigger-script id (behavior-map cell with low nibble 1 stores its high nibble here); nonzero makes the overworld loop run RunQueuedTriggerScript |
| `0xc2a1` | WRAM | `wStoryModeExitLocationRequest` | [8-bit] Story Mode - nonzero requests leaving the current location loop (RunLocationExit + reload); one of the event-request flags at $c2a0-$c2a5 cleared by ClearStoryEventRequests |
| `0xc2a4` | WRAM | `wStoryModeInteractRequest` | [8-bit] Story Mode - set to 1 on an A-press in the overworld; the event loop then tries NPC interaction (FindActorFacingPlayer), facing-tile script, and tile trigger |
| `0xc2a5` | WRAM | `wStoryModeMenuRequest` | [8-bit] Story Mode - set to 1 on a Start-press in the overworld; opens the story-mode menu (RunStoryModeMenu) |
| `0xc2d5` | WRAM | `wStoryModeShowLocationName` | [8-bit] Story Mode - nonzero shows the location-name popup after fade-in (derived from wStoryModeEntryPoint != $ff; name pointer at $c2d6/$c2d7) |
| `0xc2d6` | WRAM | `wStoryModeLocationNameTextId` | [16-bit] Story Mode - text id of the current location's name, passed in hl to ShowLocationNamePopup when wStoryModeShowLocationName is set |
| `0xc32e` | WRAM | `wCurrentScene` | [8-bit] Current story-cutscene scene index; indexes SceneGfxSlotTable (index*16) and drives LoadAndDisplayScene / InitSceneTileAnimations |
| `0xc36c` | WRAM | `wCurrentStorySlot` | [8-bit] Active story save-slot index (0-2); selects which SRAM story slot CheckStorySlot / SaveStorySlotWithTimer operate on |
| `0xc3b0` | WRAM | `wMatchPlayerChar` | [8-bit] Character id (see 0xca0b values) assigned to court slot 0 (player's main character) during match setup; also used for portraits/sprites |
| `0xc3b1` | WRAM | `wMatchOpponentChar` | [8-bit] Character id assigned to court slot 2 (opponent's main character) during match setup ($ff = none); set via SetStoryMatchOpponent |
| `0xc3b3` | WRAM | `wShadowTilemapBank` | [8-bit] WRAM bank of the shadow (off-screen) tilemap buffer; paired with wShadowTilemapPtr |
| `0xc3b4` | WRAM | `wShadowTilemapPtr` | [16-bit] Base pointer of the shadow tilemap buffer (in bank wShadowTilemapBank); tiles at base, attributes at base+$0400 |
| `0xc3b6` | WRAM | `wWindowTileAttr` | [8-bit] CGB BG attribute byte applied to window/glyph tiles when drawing (default $80 = BG priority) |
| `0xc3b7` | WRAM | `wGlyphPenX` | [16-bit] Glyph-stream horizontal pen position (sub-pixel fixed point); advanced per glyph by DrawStreamGlyph |
| `0xc402` | WRAM | `wBallX` | [16-bit] Ball X position, integer part (lateral, signed) |
| `0xc406` | WRAM | `wBallDepth` | [16-bit] Ball depth position, integer part (signed, net at 0) |
| `0xc40a` | WRAM | `wBallHeight` | [16-bit] Ball height above the court, integer part |
| `0xc421` | WRAM | `wBallVelocityX` | [16-bit] Ball X velocity, integer part (24-bit fixed-point triple $c420-$c422, fraction byte at $c420); decayed by ApplyBallAirDrag |
| `0xc424` | WRAM | `wBallVelocityDepth` | [16-bit] Ball depth velocity, integer part (triple $c423-$c425); curved by ApplyBallSpin |
| `0xc427` | WRAM | `wBallVelocityHeight` | [16-bit] Ball height (vertical) velocity, integer part (triple $c426-$c428) |
| `0xc43a` | WRAM | `wShotAimAngle` | [16-bit] Aim angle of the shot being launched (high byte = angle, $100 per turn; low byte = fraction, top nibble used by MulSinCos); projected from ball position into wBallTargetX/Depth |
| `0xc450` | WRAM | `wBallTargetX` | [16-bit] Projected ball target/landing X (same world units as wBallX) |
| `0xc452` | WRAM | `wBallTargetDepth` | [16-bit] Projected ball target/landing depth (companion to wBallTargetX; net at 0) |
| `0xc460` | WRAM | `wBounceEffectX` | [16-bit] Projected X of the ball-bounce dust effect (cached at bounce time) |
| `0xc462` | WRAM | `wBounceEffectY` | [16-bit] Projected Y of the ball-bounce dust effect |
| `0xc464` | WRAM | `wHitEffectX` | [16-bit] Projected X of the swing-hit effect (cached at hit time) |
| `0xc466` | WRAM | `wHitEffectY` | [16-bit] Projected Y of the swing-hit effect |
| `0xc478` | WRAM | `wCameraOffsetX` | [16-bit] Camera X offset added before the <<3 screen projection (Func_08_59bb) |
| `0xc47a` | WRAM | `wCameraOffsetY` | [16-bit] Camera Y offset added before the <<3 screen projection |
| `0xc480` | WRAM | `wLandingMarkerX` | [16-bit] Projected X of the lob landing marker |
| `0xc482` | WRAM | `wLandingMarkerY` | [16-bit] Projected Y of the lob landing marker |
| `0xc492` | WRAM | `wMatchFramesAbort` | [8-bit] Companion abort flag to wMatchAbortFlag ($ff set by every quit-menu action): makes StepMatchFrames return immediately and suppresses result jingles |
| `0xc4a0` | WRAM | `wCurrentShotType` | [8-bit] Shot-type code of the shot in flight. Selected from the A/B button sequence by `SelectRallyShotType`/`SelectServeShotType` (`$08`) and dispatched via the rst00 jumptable at `$07:$5445`. Codes: $00 topspin (A), $01 power topspin (A->A), $02 slice (B), $03 power slice (B->B), $04 neutral, $05-$08 reach/smash-range variants, $09 smash (A+B), $0a lob (A->B), $0b drop (B->A), $0c-$0e serves (topspin/slice/flat by first button). See `SHOTTYPE_*` in `include/constants.inc`. |
| `0xc4a8` | WRAM | `wBounceEffectTimer` | [8-bit] Frames left of the ball-bounce dust effect (starts at $14) |
| `0xc4a9` | WRAM | `wHitSparkTimer` | [8-bit] Frames left of the normal swing-hit spark (starts at $10) |
| `0xc4aa` | WRAM | `wSpecialHitTimer` | [8-bit] Frames left of the special-shot hit flash (starts at $10; drives the bank $28 screen effect) |
| `0xc4ba` | WRAM | `wBallSpriteEnabled` | [8-bit] Nonzero draws the ball sprite slot |
| `0xc4bb` | WRAM | `wBallShadowEnabled` | [8-bit] Nonzero draws the ball ground-shadow slot |
| `0xc4bc` | WRAM | `wBallTrailEnabled` | [8-bit] Nonzero draws the ball trail afterimages from the position history ring |
| `0xc4bd` | WRAM | `wBallTrailColor` | [8-bit] Trail palette index into BallTrailPalettes; nonzero also extends the trail from 2 to 5 ghosts |
| `0xc4c3` | WRAM | `wMatchAbortFlag` | [8-bit] $ff = abort the match (bit 7 breaks the point/game/set/match loops); set by every pause/quit-menu action, cleared per point by ResetPointState |
| `0xc4c4` | WRAM | `wOffscreenArrowsEnabled` | [8-bit] Nonzero draws edge arrows for off-screen characters (set during the rally) |
| `0xc4c7` | WRAM | `wMatchExitRequest` | [8-bit] Nonzero when the player chose Retry / Select New Level / Quit in the quit menu (discriminated by wMatchRetryRequest/wMatchSelectNewLevelRequest); outer mode loops branch on it |
| `0xc4ca` | WRAM | `wStandingShadowsEnabled` | [8-bit] Set in singles only; enables the wide flickering ground shadow under grounded characters |
| `0xc4cf` | WRAM | `wOnCourtCharCountMinus1` | [8-bit] `wOnCourtCharCount` - 1 (0x00-0x03); jumptable index for the match engine's per-character-count dispatches (e.g. `$4ff5`, `$6063` in bank $08) |
| `0xc4d0` | WRAM | `wServiceAceFlag` | [8-bit] Set when the point ended as a service ace (point outcome 6 with rally length 1); credited to the winner's ServiceAces stat |
| `0xc4d1` | WRAM | `wReturnAceFlag` | [8-bit] Set when the point ended as a return ace (point outcome 6 with rally length 2); credited to the winner's ReturnAces stat |
| `0xc4d5` | WRAM | `wMatchPointFlag` | [8-bit] Match-point indicator: $01/$ff = P1/P2 side wins the match by taking the next point, 0 = none (EvaluatePointSituation simulates the next point) |
| `0xc4d6` | WRAM | `wSetPointFlag` | [8-bit] Set-point indicator ($01/$ff/0, same scheme as wMatchPointFlag) |
| `0xc4d7` | WRAM | `wGamePointFlag` | [8-bit] Game-point indicator ($01/$ff/0, same scheme as wMatchPointFlag) |
| `0xc4d8` | WRAM | `wPointOutcome` | [8-bit] 0 while the rally runs; point-end cause code once the point resolves |
| `0xc4d9` | WRAM | `wPointOutcomeSide` | [8-bit] Side/sign code stored alongside wPointOutcome when a point-ending event fires ($01/$ff); negated through the court-side parity bits to decide which side won the point |
| `0xc4de` | WRAM | `wMatchRetryRequest` | [8-bit] Set to 1 by MatchQuitMenu_Retry; reruns the current drill/minigame (RunTrainingDrillByID) |
| `0xc4df` | WRAM | `wMatchSelectNewLevelRequest` | [8-bit] Set to 1 by MatchQuitMenu_SelectNewLevel; returns to the level-select screen after the match teardown |
| `0xc4e0` | WRAM | `wMatchMenuSelection` | [8-bit] Pause/quit menu selection (rst00 jumptable index: check rules / review controls / change options / save-quit); $ff = cancelled |
| `0xc78c` | WRAM | `wTargetZoneEnabled` | [8-bit] Nonzero draws the 4-corner court target zone (training drills) |
| `0xc790` | WRAM | `wTargetZoneX1` | [16-bit] Target zone X bound 1 (world units) |
| `0xc792` | WRAM | `wTargetZoneDepth1` | [16-bit] Target zone depth bound 1 (world units) |
| `0xc794` | WRAM | `wTargetZoneX2` | [16-bit] Target zone X bound 2 (world units) |
| `0xc796` | WRAM | `wTargetZoneDepth2` | [16-bit] Target zone depth bound 2 (world units) |
| `0xc7b2` | WRAM | `wModeHookTable` | [16-bit] Pointer to the current game mode's callback table (indexed by CallModeHook) |
| `0xc7b4` | WRAM | `wModeHookBank` | [8-bit] ROM bank of the mode callback table (0 = no hooks registered) |
| `0xc800` | WRAM | `wStorySlotData` | [buffer] Base of the story-slot state image (WRAM `$c800-$caff`): the live region holding the `wStoryModeMainCharacter*`/`wGameMode`/match-settings/roster fields, saved wholesale as save block 2N (see docs/save_format.md) |
| `0xc8a7` | WRAM | `wKeepMatchStatsFlag` | [8-bit] Nonzero makes ResetMatchState skip clearing the per-character match stats (set by MatchQuitMenu_SaveAndQuit so a resumed match keeps its stats); cleared after use |
| `0xc8df` | WRAM | `wMatchRngState` | [8-bit] Match RNG state: seeded from hVBlankCounter at match start, stirred by AdvanceMatchRng (+$73 plus ball position bytes) |
| `0xc8ee` | WRAM | `wServeFaultFlag` | [8-bit] 1 after a first-serve fault (the next fault becomes a double fault, point outcome 2); cleared on double fault and at match reset |
| `0xc8f2` | WRAM | `wMatchIsDoubles` | [8-bit] Nonzero when the current match is doubles; selects the wider court bound ($0320 vs $0220 at `$4104` in bank $08) and 4 on-court characters |
| `0xc8f3` | WRAM | `wOnCourtCharCount` | [8-bit] Number of characters on court: 2 singles, 4 doubles, 3 in Two-On-One; defaults to 2, set by each mode's setup code before entering the match engine |
| `0xc8f8` | WRAM | `wMatchBGM` | [8-bit] BGM id (see wCurrentBGM values) played for the current match/court; tiebreak overrides it with $0e |
| `0xcb06` | WRAM | `wMenuCursor2X` | [8-bit] Secondary menu cursor column (parallel to wMenuCursorX; second selection region of the shared menu-input handler) |
| `0xcb07` | WRAM | `wMenuCursor2Y` | [8-bit] Secondary menu cursor row (parallel to wMenuCursorY) |
| `0xcb08` | WRAM | `wMenuCursorLockFlags` | [8-bit] Menu cursor lock flags: bit 0 / bit 1 freeze the primary / secondary cursor's movement (set on confirm) in the shared menu-input handler |
| `0xcb0e` | WRAM | `wMatchFormatDoubles` | [8-bit] Match-format menu: singles (0) / doubles (1) selection; copied to wMatchIsDoubles |
| `0xcb0f` | WRAM | `wMatchFormatGames` | [8-bit] Match-format menu: games-per-set selection index; table-mapped to wMatchTypeNumberOfGames |
| `0xcb10` | WRAM | `wMatchFormatSets` | [8-bit] Match-format menu: number-of-sets selection index (0-2); table-mapped to wMatchTypeNumberOfSets |
| `0xcb11` | WRAM | `wMenuSlideDirection` | [8-bit] Menu transition direction (1 = forward into submenu, 0 = back); direction arg to the *SlideIn/*SlideOut menu transitions |
| `0xcb3f` | WRAM | `wCutsceneStep` | [8-bit] Bank $6b cutscene driver (intro/title/award ceremony): current step index, dispatched through the per-scene jumptable |
| `0xcb40` | WRAM | `wCutsceneStepTimer` | [8-bit] Bank $6b cutscene driver: frame counter for the current step; incremented per frame and compared against per-step thresholds to advance wCutsceneStep |
| `0xcb42` | WRAM | `wCutsceneScrollX` | [8-bit] Bank $6b cutscene driver: accumulated horizontal pan position, copied to hScrollX each frame |
| `0xff96` | HRAM | `hWramBank` | [8-bit] Shadow of the current WRAM bank (last value written to `rSVBK`); always written together with `rSVBK` |
| `0xff97` | HRAM | `hSramBank` | [8-bit] Shadow of the current SRAM bank (always written together with the MBC RAM-bank register at $4000) |
| `0xffc0` | HRAM | `hLinkRxByte` | [8-bit] Last byte received over the serial link (captured from rSB in the serial interrupt) |
| `0xffc1` | HRAM | `hLinkTxByte` | [8-bit] Next byte to transmit over the serial link (copied to rSB) |
| `0xffc2` | HRAM | `hLinkState` | [8-bit] Serial link state/role (0 = idle, 1/2 = connected roles); gates the encode/decode paths |
| `0xffc8` | HRAM | `hLinkCounter` | [8-bit] Serial link exchange/frame counter; increments per exchange and caps at 8 |

## Union overlays (`ram_unions.json`)

Some RAM ranges are reused by several subsystems that never run at the same
time. These are modeled as RGBDS `UNION`/`NEXTU` overlays in the generated
`ram/*.asm`, driven by `ram_unions.json`: each variant carries its own symbols
plus the code *scopes* where it applies. A scope is `{bank[, start, end]}`
(the referencing code's ROM location) and/or `{wram_bank: N}` (the WRAM bank
provably selected at the site, inferred by `disasm.py`'s `compute_wram_bank`
CFG dataflow). Constraints within one scope AND; scopes within a variant OR.
`disasm.py` substitutes a variant's names only where a scope matches; a variant
marked `default` applies everywhere outside every scoped variant's ROM ranges.
Sites in unproven consumers — including any WRAMX access whose bank can't be
proven — keep the numeric address.

`wram_bank: N` is the tool for banked WRAMX (`$d000-$dfff`): the same offset
means different things per WRAM bank, so a global `ram_map.json` name would
leak across banks. (The `$dfxx` match-engine structs below predate this and
stay documentation-only, but are a candidate for per-bank `wram_bank` scoping.)

| range | variant (scope) | symbols |
|---|---|---|
| `$c780-$c784` | character select (bank `$1b`) | `wCharSelectChar`/`PrevChar`/`Col`/`Row` — cursor state over the roster grid at `$c7a0` |
| `$ffd0-$ffef` | serial-link input slots (default) | `hLinkInput` (merged effective input, also the scripted-input feed), `hLinkRemoteInput`, `hLinkRemoteInputBuf` |
| | sound driver (bank 0 `$3373-$3de0`) | full per-channel HRAM working set: `hSndScriptPtr`, `hSndVolume`, `hSndInstrument`, `hSndEnvRate/Length/Pos`, `hSndVolSlide*`, `hSndEcho*`, `hSndLoop*`, `hSndRestFlag`, … (28 fields) |
| | sprite queue (bank 0 `$2ced-$2d9f`) | `hSpriteBlitY`, `hSpriteBlitX` |
| | story actor engine (banks `$04/$05/$0a`) | `hActorPtr` |
| `$d100-$d219` | sound engine (`wram_bank $07`, + bank-0 `$2f00-$3de0`) | channel state blocks `wSndChannels`, loop stack `wSndLoopSlots`, per-pass globals `wSndActiveMask`/`wSndChannelType`/`wSndRegBase`/`wSndPanShadow`/… |
| `$df00-$df96` | match char struct (`wram_bank $04/$05/$06/$07`, + match banks `$07`/`$08`) | per-character fields `wCharPosX`/`wCharState`/`wCharVel*`/`wCharSpriteSlot`/… (32); one name each, bank = character |
| | text-arg fetch buffer (banks `$0e`/`$0f`/`$12`) | `wTextArgFetchBuffer` — `$df00` reused as a text-arg string scratch while the match is idle (higher priority than the char variant so those sites don't read as `wCharPosX`) |
| `$dd00-$dd23` | match ball renderer (`wram_bank $04`, + bank `$08`) | `wBallHistory` — ball position-history ring (six 6-byte records) |
| `$de00-$de1f` | match ball renderer (`wram_bank $04`, + bank `$08`) | `wNetBallSlot`, `wBallSlot`, `wBallShadowSlot`, `wBallTrailSlots` (4-byte sprite-slot records) |
| `$a020-$a03f`, `$a060-$a76f` | save engine (bank `$03`) | `sSaveSignature`, `sSaveMasterChecksum`, `sSaveFormatVersion`, `sSaveBlockDirectory` |

Interior bytes of a multi-byte scoped field render as `name + k` (same
expansion `ram_map.json` symbols get), so `$dd1e` reads `wBallHistory + 30` and
`$ffd1` reads `hSndScriptPtr + 1`, under the same scope as the base.


## Match engine per-character structs (WRAM banks 4-7)

The match engine (bank $08) keeps one character struct per **banked WRAM
bank**, all at the same `$dfxx` addresses; code selects a character by writing
4-7 to `rSVBK`/`hWramBank`. `ForEachCharBank` ($6a3a) runs a callback in banks
7,6,5,4 (leaving 4 active). Bank assignment (from the dispatch ladders at
`$6063`/`$4ff5`, indexed by `wOnCourtCharCountMinus1`):

| Bank | Character | Active when count is |
|---|---|---|
| 4 | near-side player 1 | 1, 2, 3, 4 |
| 5 | far-side player 1 | 2, 3, 4 |
| 6 | near-side partner | 4 |
| 7 | far-side partner | 3 (Two-On-One), 4 |

Known fields (addresses valid only while a bank 4-7 is mapped). These are named
via a `wram_bank`-scoped union in `ram_unions.json` (see "Union overlays"
above): one `wChar*` name per field, rendered only where the WRAM bank is
provably 4-7 or inside match banks `$07`/`$08`. Other WRAM banks reuse `$dfxx`
for unrelated data and stay numeric — e.g. bank `$38`'s non-char `$dfxx`
accesses, and the text-arg scratch reuse of `$df00` in menu banks (named
`wTextArgFetchBuffer` instead):

| Address | Field |
|---|---|
| `$df00-02` | X position (lateral), 24-bit fixed point: fraction byte, then signed 16-bit integer part |
| `$df03-05` | depth position, same format; signed, net at 0, the two court sides have opposite signs |
| `$df06-08` | height above court, same format (zeroed by `SetCharPosAndTarget`) |
| `$df09` | serve/side role code, from byte 4-7 of the court-position record (`GamePositionTables`); XORed with 2 to swap court side per point, mapped through the `$4fa0` table to a char state at point start |
| `$df0a` | court position code, from byte 0-3 of the court-position record (XORed with 3 on the tiebreak side-swap path) |
| `$df0b` | character index 0-3 (== bank - 4); bit 0 set = far side, so `CharPointEndReaction` negates `wPointWinLoseFlag` through it for `$df57`, and it selects the off-screen edge-arrow sprite (index * 8) |
| `$df0d`/`$df0e` | facing direction: desired / displayed (eased toward desired in `$75c0` by at most `$df68` per frame) |
| `$df0f` bit 2 | airborne flag: set on jump (`$6dd5`, with `sound $5c`), cleared on landing; selects which shadow slot is drawn |
| `$df18-1a` | state machine index + substate (jumptable at `$6a77`; set via `SetCharState`) |
| `$df22` | active flag (`UpdateChar` exits when 0) |
| `$df40-45` | velocity, 3 x 16-bit (zeroed on placement and at point end) |
| `$df46/47` | walk-target X (integer part) |
| `$df48/49` | walk-target depth; `MoveCharTowardTarget` ($7541) walks toward the target and snaps when `CheckCharNearTarget` ($78be) sees both deltas < $18 |
| `$df53/54` | last projected screen X/Y (`BuildCharSpriteSlots`, $7672) |
| `$df57` | point result from this character's perspective (signed `wPointWinLoseFlag`) |
| `$df1b-1d` | sprite frame data pointer (hi/lo) + h-flip flag, consumed by `DrawCharSprite` ($650a) |
| `$df80-83` | sprite-slot record for the character sprite (see below) |
| `$df88-8b` | sprite-slot record for the airborne shadow: tiles `$50/$52/$54/$56` shrink with jump height, drawn only while `$df0f` bit 2 is set |
| `$df8c-8f` | sprite-slot record for the standing shadow: tile `$58` through the 3-sprite-wide `StandingShadowOamTemplate` ($6301), drawn on alternate frames (flicker transparency) while grounded, singles only (`wStandingShadowsEnabled`) |
| `$df96` | draw-order depth key: `(depth * 8) >> 8 + $80`; `DrawActorsByDepth` compares teammates' keys to paint back-to-front |

## Match renderer sprite slots (WRAM bank 4, `$dd00`/`$de00`)

The match engine queues every court sprite through 4-byte **slot records**
`[tile, attr, screenY, screenX]`; `$ff` in the tile byte means empty.
`ClearSpriteSlots` ($630e) resets them all each frame; gameplay code fills
them; the draw stage flushes them into the shadow OAM buffer via
`QueueSprite` ($1f51), `QueueSprite16` ($1e55), or `QueueSpriteTemplate`
($1e9d). Fixed slots (in WRAM bank 4, alongside the per-character `$df80+`
slots above):

| Address | Symbol | Slot |
|---|---|---|
| `$de00` | `wNetBallSlot` | ball-at-net marker: tile `$4e`, drawn after the point resolves when the ball rests within `$1e0` of the net, with a 1px X jitter per frame (`BuildNetBallSlot`) |
| `$de04` | `wBallSlot` | the ball itself: tile picked by height band / off-screen state (`$40/$42/$44`), gated by `wBallSpriteEnabled` (`BuildBallSlot`) |
| `$de08` | `wBallShadowSlot` | ball ground shadow: tile `$46` at the ball's height-0 projection, gated by `wBallShadowEnabled` (`BuildBallShadowSlot`) |
| `$de0c-$de1f` | `wBallTrailSlots` | 5 ball-trail afterimages (tile = ball tile + 8), fed from the position history ring; slots 3-5 only when `wBallTrailColor` is nonzero (`BuildBallTrailSlots`) |

`$dd00-$dd23` (bank 4) is the **ball position history ring** (`wBallHistory`): six 6-byte
records `[projX word, projY word, tile+8, attr]`; `UpdateBallVisuals`
($5153) shifts it down one record per frame and `BuildBallSlot` writes the
newest at `$dd1e`. `SetBallTrailColor` ($5189) picks one of the 8 OBJ
palettes in `BallTrailPalettes` ($50dc) for the trail (shot-type colors).

Effects drawn directly (no slot): swing-hit spark (tiles `$68-$6e`,
`wHitSparkTimer`), special-shot flash (tile `$74` + bank $28 screen effect,
`wSpecialHitTimer`), bounce dust (tiles `$60/$62`, `wBounceEffectTimer`),
lob landing marker (tile `$7c`, `wLandingMarkerX/Y`, started by
`StartLandingMarker` with `sound $6d`), the 4-corner training target zone
(tiles `$20-$26`, `wTargetZone*`), and off-screen character edge arrows
(`DrawOffscreenCharArrow`, gated by `wOffscreenArrowsEnabled`).

Frame flow: `DrawActorsByDepth` ($6429) draws the two team pairs and the
ball group in painter's order using the `$df96` keys (`DrawNearTeamChars`,
`DrawFarTeamChars`, `DrawBallAndEffects`), then `DrawMarkersAndShadows`
($6481) flushes markers, trail, and shadow slots. Modes hook extra draws
via `SetModeHookTable`/`CallModeHook` (`wModeHookBank`/`wModeHookTable`).

**Doubles spacing:** at point end, `StartPointEndReactions` ($4fb8) makes every
character face the result (`CharPointEndReaction` sets state 7 and target :=
current position), then `SpreadTeammateTargets` ($4ff5) adjusts the walk-target
depths per team pair — banks (4,6) and (5,7) — via `ComputePairSpread` ($506e):
teammates whose depths are within $200 of each other get targets exactly $200
apart, centered on the pair's midpoint but never closer than $100 to the net;
pairs already $200+ apart keep their positions. Singles skips this entirely
(the jumptable's count-1/count-2 slots point at a bank-0 `ret`).

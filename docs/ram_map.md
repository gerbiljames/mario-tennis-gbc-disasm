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

Addresses named by this project from disassembly evidence. The declarations
in `ram/wram.asm`, `ram/hram.asm` and `ram/sram.asm` are the source of truth
and carry the same notes; this table mirrors the entries not in the RA table
above, so add a name there first and then its row here.

| Address | Region | Name | Note |
|---|---|---|---|
| `0xc0a0` | WRAM | `wVRAMCopyQueue` | [80 bytes] VBlank VRAM copy queue: 10 x 8-byte entries [rom bank, wram bank, size hi, size lo, vbk, dest hi, dest lo, src?]; processed by ProcessVRAMCopyQueues |
| `0xc0f0` | WRAM | `wGameTimer` | [4 bytes] Play timer: frames (0-59), seconds, minutes, hours (caps at 99) |
| `0xc100` | WRAM | `wBGPalettes` | [64 bytes] Live BG palette buffer, uploaded in VBlank when hPaletteDirtyFlags bit 0 set |
| `0xc140` | WRAM | `wOBJPalettes` | [64 bytes] Live OBJ palette buffer, uploaded in VBlank when hPaletteDirtyFlags bit 1 set |
| `0xc180` | WRAM | `wTileWriteQueue` | [64 bytes] VBlank single-tile write queue: 16 x 4-byte entries [addr hi, addr lo, tile (VBK0), attr (VBK1)] |
| `0xc1c0` | WRAM | `wFrameTasks` | [64 bytes] Frame task list: 4-byte records [id, ptr lo, ptr hi, rom bank] of banked callbacks run each frame (RegisterFrameTask / ClearFrameTasks) |
| `0xc200` | WRAM | `wMasterPalettes` | [128 bytes] Master palette copy (BG+OBJ); fades scale this into wBGPalettes/wOBJPalettes |
| `0xc295` | WRAM | `wStoryModeEntryPoint` | [8-bit] Story Mode - entry point / spawn-door ID for the location being loaded; $ff = none (keep saved player position). LoadStoryEntryPointRecord searches the location's entry table with it |
| `0xc296` | WRAM | `wStoryModeSpawnPosition` | [5 bytes] Story Mode - player spawn/return buffer: X (16-bit), Y (16-bit), facing; filled from the matched entry-point record or backed up from wStoryModePlayersXPosition before a submode |
| `0xc2a0` | WRAM | `wStoryModeTriggerScript` | [8-bit] Story Mode - queued tile trigger-script id (behavior-map cell with low nibble 1 stores its high nibble here); nonzero makes the overworld loop run RunQueuedTriggerScript |
| `0xc2a1` | WRAM | `wStoryModeExitTriggerRequest` | [8-bit] Story Mode - nonzero requests leaving the current location loop (RunLocationExit + reload); one of the event-request flags at $c2a0-$c2a5 cleared by ClearStoryEventRequests. The value is an exit-trigger id, not a location: RunLocationExit ($0a:$560b) passes it in d to FindStoryScriptEntry, which matches it against the id column of the location's ExitTriggers table (map_tree slot 1), and the destination STORYLOC_* id is that row's arg0. So the same $01 leaves different locations for different places |
| `0xc2a4` | WRAM | `wStoryModeInteractRequest` | [8-bit] Story Mode - set to 1 on an A-press in the overworld; the event loop then tries NPC interaction (FindActorFacingPlayer), facing-tile script, and tile trigger |
| `0xc2a5` | WRAM | `wStoryModeMenuRequest` | [8-bit] Story Mode - set to 1 on a Start-press in the overworld; opens the story-mode menu (RunStoryModeMenu) |
| `0xc2d5` | WRAM | `wStoryModeShowLocationName` | [8-bit] Story Mode - nonzero shows the location-name popup after fade-in (derived from wStoryModeEntryPoint != $ff; name pointer at $c2d6/$c2d7) |
| `0xc2d6` | WRAM | `wStoryModeLocationNameTextId` | [16-bit] Story Mode - text id of the current location's name, passed in hl to ShowLocationNamePopup when wStoryModeShowLocationName is set |
| `0xc320` | WRAM | `wCameraX` | [16-bit] BG scroll-buffer camera X (tiles<<3?) |
| `0xc322` | WRAM | `wCameraY` | [16-bit] BG scroll-buffer camera Y |
| `0xc326` | WRAM | `wBGRowBlitDest` | [16-bit] Tilemap address for the queued BG row blit |
| `0xc328` | WRAM | `wBGColumnBlitX` | [8-bit] Tilemap column for the queued BG column blit |
| `0xc32e` | WRAM | `wCurrentScene` | [8-bit] Current story-cutscene scene index; indexes SceneGfxSlotTable (index*16) and drives LoadAndDisplayScene / InitSceneTileAnimations |
| `0xc36c` | WRAM | `wCurrentStorySlot` | [8-bit] Active story save-slot index (0-2); selects which SRAM story slot CheckStorySlot / SaveStorySlotWithTimer operate on |
| `0xc3a7` | WRAM | `wSpriteBufferPage` | [8-bit] High byte of current OAM shadow buffer ($c0/$c5); toggled each frame, OAM DMA source |
| `0xc3b0` | WRAM | `wMatchPlayerChar` | [8-bit] Character id (see 0xca0b values) assigned to court slot 0 (player's main character) during match setup; also used for portraits/sprites |
| `0xc3b1` | WRAM | `wMatchOpponentChar` | [8-bit] Character id assigned to court slot 2 (opponent's main character) during match setup ($ff = none); set via SetStoryMatchOpponent |
| `0xc3b2` | WRAM | `wWindowFrameAttr` | [8-bit] BG attribute written for window-frame cells ($80 = BG priority) |
| `0xc3b3` | WRAM | `wShadowTilemapBank` | [8-bit] WRAM bank of the shadow (off-screen) tilemap buffer; paired with wShadowTilemapPtr |
| `0xc3b4` | WRAM | `wShadowTilemapPtr` | [16-bit] Base pointer of the shadow tilemap buffer (in bank wShadowTilemapBank); tiles at base, attributes at base+$0400 |
| `0xc3b6` | WRAM | `wWindowTileAttr` | [8-bit] CGB BG attribute byte applied to window/glyph tiles when drawing (default $80 = BG priority) |
| `0xc3b7` | WRAM | `wGlyphPenX` | [16-bit] Glyph-stream horizontal pen position (sub-pixel fixed point); advanced per glyph by DrawStreamGlyph |
| `0xc402` | WRAM | `wBallX` | [16-bit] Ball X position, integer part (lateral, signed) |
| `0xc406` | WRAM | `wBallDepth` | [16-bit] Ball depth position, integer part (signed, net at 0) |
| `0xc40a` | WRAM | `wBallHeight` | [16-bit] Ball height above the court, integer part |
| `0xc40e` | WRAM | `wBallHeadingAngle` | [16-bit] Ball physics - horizontal heading angle of the ball's velocity (same $100-per-turn encoding as wShotAimAngle). Written by UpdateBallAnglesAndSpeed ($08:$45f1) as AngleFromVector16(de=wBallVelocityX, hl=wBallVelocityDepth); read by ApplyBallSpin ($08:$5724, MulSinCosSigned to split the topspin term back onto the X/depth axes) and by PredictBallLateralOffset ($08:$70f5). |
| `0xc416` | WRAM | `wBallPrevDepth` | [16-bit] Ball depth at the start of the frame (integer part). StepBallPhysics ($08:$576b) copies the whole 12-byte position block $c400-$c40b to $c410-$c41b before adding velocity, so $c410/$c414/$c418 mirror the wBallX/wBallDepth/wBallHeight 32-bit triples; only the depth integer part is ever read back. HandleBallNetCrossing ($08:$581c) XORs wBallDepth+1 with $c417 and tests bit 7 to detect the net crossing; DidBallCrossGate ($08:$6773) reads the full word. |
| `0xc41c` | WRAM | `wBallTopspin` | [16-bit] Ball physics - top/backspin coefficient (rotation about the lateral axis). Set from bc by SetBallSpinComponents ($08:$45de). ApplyBallSpin ($08:$56a9-$5765): while nonzero it multiplies wBallVelocityHeight by it and adds the (negated) product along wBallHeadingAngle into the X/depth velocities ($c420/$c423), and multiplies wBallSpeedHorizontal by it and adds that into the height velocity ($c426) - i.e. a Magnus rotation of the (horizontal, vertical) velocity pair. Decayed by 3/256 per frame at $08:$574a-$5765. |
| `0xc41e` | WRAM | `wBallSideSpin` | [16-bit] Ball physics - sidespin/curve coefficient (rotation about the vertical axis). Set from de by SetBallSpinComponents ($08:$45d8). ApplyBallSpin ($08:$5613-$56a8): while nonzero it adds +k*wBallVelocityDepth to the X velocity ($c420) and -k*wBallVelocityX to the depth velocity ($c423), curving the ball laterally; then decays itself by 3/256 per frame ($08:$568d-$56a8). |
| `0xc421` | WRAM | `wBallVelocityX` | [16-bit] Ball X velocity, integer part (24-bit fixed-point triple $c420-$c422, fraction byte at $c420); decayed by ApplyBallAirDrag |
| `0xc424` | WRAM | `wBallVelocityDepth` | [16-bit] Ball depth velocity, integer part (triple $c423-$c425); curved by ApplyBallSpin |
| `0xc427` | WRAM | `wBallVelocityHeight` | [16-bit] Ball height (vertical) velocity, integer part (triple $c426-$c428) |
| `0xc42a` | WRAM | `wBallSpeedHorizontal` | [16-bit] Magnitude of the ball's horizontal (X,depth) velocity, integer part of the 24-bit triple $c429-$c42b (fraction byte at $c429). Written by UpdateBallAnglesAndSpeed ($08:$4606) as VectorLengthFromAngle(bc=wBallHeadingAngle, hl=wBallVelocityDepth, de=wBallVelocityX); read by ApplyBallSpin ($08:$56ed) as the horizontal-speed factor of the topspin lift term. |
| `0xc430` | WRAM | `wShotAimTargetX` | [16-bit] World X the shot is aimed at, in the same units as wBallX. Written by ComputeShotTrajectory ($07:$5746) from ComputeShotTargetX, copied on to wBallTargetX at $07:$5863, and drawn as a world-space marker sprite at $08:$54f3 (ProjectWorldToScreen + QueueSprite). Cleared with $c432 by ResetBallState ($08:$5149). |
| `0xc432` | WRAM | `wShotAimTargetDepth` | [16-bit] World depth the shot is aimed at (companion to wShotAimTargetX; net at 0, sign already corrected for the hitter's court side at $07:$5725). Written by ComputeShotTrajectory ($07:$572b), copied on to wBallTargetDepth at $07:$5863, read as the depth of the aim marker sprite at $08:$54ed. |
| `0xc434` | WRAM | `wShotAimDeltaX` | [16-bit] wShotAimTargetX - wBallX, the lateral leg of the ball->target vector. Written by ComputeShotTrajectory ($07:$5758). Read by every court bank's SetBallTargetByPrediction ($20/$21/$22/$23/$2a/$2b/$2c:$40a3, $24:$40af, $29:$40a3) and by the trajectory-length path at $20:$416a, where it is passed as the hl argument of VectorLengthFromAngle together with wShotAimDeltaDepth in de. |
| `0xc436` | WRAM | `wShotAimDeltaDepth` | [16-bit] wShotAimTargetDepth - wBallDepth, the depth leg of the ball->target vector. Written by ComputeShotTrajectory ($07:$573d) and immediately fed to AngleFromVector16 at $07:$5764 (with wShotAimDeltaX in de) to produce wShotAimAngle; read again as the de argument of VectorLengthFromAngle at $20:$4164 and in the other court banks. |
| `0xc43a` | WRAM | `wShotAimAngle` | [16-bit] Aim angle of the shot being launched (high byte = angle, $100 per turn; low byte = fraction, top nibble used by MulSinCos); projected from ball position into wBallTargetX/Depth |
| `0xc43e` | WRAM | `wAimSpreadBase` | [16-bit] Base lateral aim spread used to place a rally shot's target: $0220 in singles, $0320 in doubles ($08:$4104-$4111, at match init). ComputeAimBaseOffset ($07:$56b7) returns (this + \|wCharPosDepth\|/8) scaled by the character's aim stat $df69, which ComputeShotTargetX then adds to / subtracts from wBallX before clamping. |
| `0xc440` | WRAM | `wMatchCameraX` | [16-bit] Match camera current X (projected space). SnapCameraTo ($08:$61ac) sets it and the target together; UpdateMatchCamera eases it toward wMatchCameraTargetX ($08:$61f4-$625c) and then derives wCameraOffsetX from it at $08:$6281-$62c3. |
| `0xc442` | WRAM | `wMatchCameraY` | [16-bit] Match camera current Y (projected space); eased toward wMatchCameraTargetY and shifted into wCameraOffsetY at $08:$62c4. |
| `0xc444` | WRAM | `wMatchCameraTargetX` | [16-bit] Match camera target X. Written by SetCameraTarget ($08:$61cb) and SnapCameraTo ($08:$61b2, plus the bank $0d copy SnapCameraTo_0d $4942), overwritten every frame from wBallGroundProjX while wCameraFollowBall is set; UpdateMatchCamera steps wMatchCameraX toward it with a fixed $0040 step (VectorFromLengthAndAngleRaw at $08:$6222). |
| `0xc446` | WRAM | `wMatchCameraTargetY` | [16-bit] Match camera target Y (companion to wMatchCameraTargetX; same writers and the same snap-on-overshoot logic at $08:$6263-$6280). |
| `0xc448` | WRAM | `wBallRelCharX` | [16-bit] Ball X minus the current character's X (wBallX - wCharPosX+1), signed. Written by UpdateCharBallGeometry ($08:$6e6a-$6e75) for whichever character bank is mapped; read by AiSteerTowardBall ($08:$7944) as the de leg of AngleFromVectorCoarse and by the swing/contact range checks at $08:$6ef2/$6fed/$704e. |
| `0xc44a` | WRAM | `wBallRelCharDepth` | [16-bit] Ball depth minus the current character's depth, signed (same struct as wBallRelCharX). Read by CheckBallContactWindow ($08:$6fa7), CheckBallInSwingRange ($08:$702a), ComputeBallEtaToChar ($08:$70ca-$70e7, divided by wBallVelocityDepth to get frames-to-arrival), PredictBallLateralOffset ($08:$70fb) and the AI at $08:$7b99. |
| `0xc44c` | WRAM | `wBallRelCharHeight` | [16-bit] Ball height minus the current character's height, signed (third word of the same struct). Read by the reach/height gates at $08:$6f12 and $08:$700d, each comparing \|value\| against the character's reach field $df70. |
| `0xc450` | WRAM | `wBallTargetX` | [16-bit] Projected ball target/landing X (same world units as wBallX) |
| `0xc452` | WRAM | `wBallTargetDepth` | [16-bit] Projected ball target/landing depth (companion to wBallTargetX; net at 0) |
| `0xc460` | WRAM | `wBounceEffectX` | [16-bit] Projected X of the ball-bounce dust effect (cached at bounce time) |
| `0xc462` | WRAM | `wBounceEffectY` | [16-bit] Projected Y of the ball-bounce dust effect |
| `0xc464` | WRAM | `wHitEffectX` | [16-bit] Projected X of the swing-hit effect (cached at hit time) |
| `0xc466` | WRAM | `wHitEffectY` | [16-bit] Projected Y of the swing-hit effect |
| `0xc46c` | WRAM | `wBallGroundProjX` | [16-bit] Projected screen-space X of the ball's ground (shadow) position, from ProjectWorldToScreen(wBallX, wBallDepth) in BuildBallShadowSlot ($08:$5267). UpdateMatchCamera ($08:$61e2) copies $c46c-$c46f into the camera target $c444-$c447 whenever wCameraFollowBall is set. |
| `0xc46e` | WRAM | `wBallGroundProjY` | [16-bit] Projected screen-space Y of the ball's ground position (companion to wBallGroundProjX, from the bc return of ProjectWorldToScreen at $08:$526d). |
| `0xc478` | WRAM | `wCameraOffsetX` | [16-bit] Camera X offset added before the <<3 screen projection (Func_08_59bb) |
| `0xc47a` | WRAM | `wCameraOffsetY` | [16-bit] Camera Y offset added before the <<3 screen projection |
| `0xc480` | WRAM | `wLandingMarkerX` | [16-bit] Projected X of the lob landing marker |
| `0xc482` | WRAM | `wLandingMarkerY` | [16-bit] Projected Y of the lob landing marker |
| `0xc484` | WRAM | `wCourtLimitX` | [16-bit] In-bounds lateral limit, stored as the two's-complement negative of the \|X\| bound: $fe50 (= -$1b0) in singles, $fdc0 (= -$240) in doubles ($08:$40e8, $08:$4300-$430d, $0d:$4690). CheckBallOutOfBounds ($08:$463c) adds it to \|wBallX\| and treats the carry as 'out'; ClampShotTargetX ($07:$56e3) clamps the aim target to (-value - $20); ComputeShotTrajectory ($07:$57f4) uses the same figure to shorten wShotDistMax when the aim line would leave the court sideways. |
| `0xc486` | WRAM | `wCourtLimitDepth` | [16-bit] In-bounds depth limit, also stored negated: $fb20 (= -$4e0, the baseline) normally, tightened to $fd60 (= -$2a0, the service line) while a serve is in flight ($08:$4cff) and restored at $08:$40ee / $0d:$4bd2. CheckBallOutOfBounds ($08:$4657) adds it to \|wBallDepth\| and sets bit 1 of the out-of-bounds mask on carry. |
| `0xc488` | WRAM | `wNetHeight` | [16-bit] Height of the net in ball-height units ($0060 in a normal match, $08:$40f7; $0000 for the solo minigames that have no net, $0d:$4b0b). HandleBallNetCrossing ($08:$5830-$5853) adds it to wBallHeight at the moment the ball crosses depth 0 and, if the sum is still non-negative (heights are negative-up), plays sound $5a, starts the bounce effect, sets wBallHasBouncedFlag and negates the depth position and velocity - i.e. the ball clipped the net. |
| `0xc48a` | WRAM | `wShotDistMin` | [16-bit] Shot solver - minimum distance along the aim line, i.e. the distance from the ball to where the aim line crosses depth $0140 past the net. ComputeShotTrajectory ($07:$5783-$57a1) computes \|wBallDepth\| + $0140, divides by sin(wShotAimAngle) (DivBySin, $07:$5787), takes the absolute value and stores it here; $c48e caches value>>6. Every court bank's ApplyBallTrajectory ($20:$4108, $4135, $419c, $41cf and the same offsets in $21-$24, $29-$2c) loads it into de and passes it to BallTrajEntryPtr6/4 as the starting row of the trajectory table. |
| `0xc48c` | WRAM | `wShotDistMax` | [16-bit] Shot solver - maximum distance along the aim line: distance to where the aim line crosses depth $0480 (just inside the baseline at $4e0), computed the same way at $07:$57b8-$57d6, then shortened at $07:$582c-$5850 to the distance at which the aim line would cross the sideline (wCourtLimitX + $0020) if that comes first. $c48f caches value>>6. Read by the court banks at $20:$4175/$4183 (and the same offsets elsewhere) to clamp the actual ball->target length before selecting a trajectory row. |
| `0xc48e` | WRAM | `wShotTrajRowMin` | [8-bit] wShotDistMin >> 6 - the first row index of the per-court ball-trajectory table to consider. Written at $07:$5799 as the high byte of (wShotDistMin << 2). Loaded into d as the loop counter by every court bank's SeekBallTrajEntry6/4 ($20:$401f and $20:$403e, mirrored in $21-$24, $29-$2c). |
| `0xc48f` | WRAM | `wShotTrajRowMax` | [8-bit] wShotDistMax >> 6 - the last row index the trajectory search may reach. Written at $07:$57ce and re-written at $07:$5848 when wShotDistMax is shortened by the sideline clamp. Loaded into e by SeekBallTrajEntry6/4, which stops as soon as d (wShotTrajRowMin, incremented per row) reaches it. |
| `0xc491` | WRAM | `wPointWinnerShotType` | [8-bit] Winning-shot type for the point just won: 0=none, 1=service ace, 2=return ace, 3=smash ace, 4=lob winner, 5=drop-shot winner. Reset to 0 in the per-point state clear ($08:$4cd5); set by the Record*Stat functions ($08:$5c5f+) which also credit the matching wCharacterN stat. The on-court winner banner is ShowCourtBanner(value+$17) at $08:$4e75, i.e. banner ids 24-28 (SERVICE/RETURN/SMASH ACE, LOB, DROP SHOT) - confirmed in-game. |
| `0xc492` | WRAM | `wMatchFramesAbort` | [8-bit] Companion abort flag to wMatchAbortFlag ($ff set by every quit-menu action): makes StepMatchFrames return immediately and suppresses result jingles |
| `0xc494` | WRAM | `wScoreboardLayout` | [8-bit] Scoreboard layout/caption style code, 0-7. Chosen by Func_08_454b ($08:$454b) from wOnCourtCharCount (singles/doubles) or, for minigames ($c8f5 == 2), from $c7ba/$c7bb as 3/4/7. Used as an rst00 jumptable index by DrawScoreboardCaption ($06:$477a) and DrawScoreboard ($06:$49c0), as a table index at $06:$49ae and $06:$507b, and checked against 3 by the bank $09 serve-indicator spawner ($09:$4133, $09:$425a). |
| `0xc4a0` | WRAM | `wCurrentShotType` | [8-bit] Shot-type code of the shot in flight (rst00 jumptable in ExecuteShot; $09 smash, $0a lob, $0b drop - checked by RecordSmashAce/Lob/DropShot) |
| `0xc4a2` | WRAM | `wShotChargeLevel` | [8-bit] Charge level of the shot being executed, 0-$3f. Snapshotted from the hitter's $df4b and clamped to $3f in ExecuteShot ($07:$5413-$541c). Scales the shot speed in AddChargeSpeedBonus / AddChargeSpeedBonusHalf ($07:$5345, $535c, both offsetting by $ffe0 first) and in WeakenShotByCharge / BoostShotByCharge ($07:$54de, $54ed); $08:$53f9 compares it against $3f (fully charged) to pick the special hit flash instead of the normal spark. |
| `0xc4a5` | WRAM | `wSpecialShotFlag` | [8-bit] Nonzero when the shot just struck counts as a special/power hit. Cleared at the top of ExecuteShot ($07:$53e6); set to 1 at $07:$59f8 when the ball is struck above height $0140, and set from the 32-entry toss-height table at $07:$5a1c on the serve paths. Read at $08:$53f3, where it forces the special-shot flash (wSpecialHitTimer) instead of the normal swing spark, and at $08:$42d4, where a nonzero value on the first shot of the rally shows court banner $0e. |
| `0xc4a7` | WRAM | `wShotAimMirror` | [8-bit] 0/1 parity flag: when 1, the shot's lateral aim offsets are negated. Written by ExecuteShot ($07:$540d) as the low bit of a count of four conditions (hitter state $df15 == 6, == $0a, $df94 nonzero, wRallyLength == 0). Read by LoadShotPlacementEntry ($07:$52b5) to negate the placement entry's angle offset before storing it at $c41e, and by every court bank's SetBallVelocityFromEntry6 ($20:$406a, $2a:$40c7 and the same offsets in the other court banks) to negate the table entry's angle delta before adding it to wShotAimAngle. |
| `0xc4a8` | WRAM | `wBounceEffectTimer` | [8-bit] Frames left of the ball-bounce dust effect (starts at $14) |
| `0xc4a9` | WRAM | `wHitSparkTimer` | [8-bit] Frames left of the normal swing-hit spark (starts at $10) |
| `0xc4aa` | WRAM | `wSpecialHitTimer` | [8-bit] Frames left of the special-shot hit flash (starts at $10; drives the bank $28 screen effect) |
| `0xc4ab` | WRAM | `wBallTouchCharTimer` | [8-bit] Frames left of the 'ball hit a character' effect; started at $28 by StartBallTouchCharEffect ($08:$547c), ticked and used as an animation-table index by DrawBallTouchCharEffect ($08:$5482-$54bb). |
| `0xc4ac` | WRAM | `wCourtSurfaceFriction` | [8-bit] Court surface horizontal bounce damping (8-bit fraction, e.g. $cd = 0.80 on court 0). Loaded per court from the 4-byte-per-court table at $08:$5dc4 ($08:$5e3e). ApplyCourtBounceDamping ($08:$46b3, $46c5) multiplies both horizontal velocity triples ($c420 = X, $c423 = depth) by it. |
| `0xc4ad` | WRAM | `wCourtSurfaceBounce` | [8-bit] Court surface vertical restitution (8-bit fraction), loaded from the same per-court record at $08:$5e42. ApplyCourtBounceDamping ($08:$46d7) multiplies the height velocity triple $c426 by it. |
| `0xc4ae` | WRAM | `wBallTouchCharFlag` | [8-bit] Set to 1 at $08:$6f30 when the ball reaches a character's body (the same site sets bit 2 of $df50 and forces the character to state 0). HandleBallTouchCharEvent ($08:$43d3) consumes it once per frame: clears it, plays sound $77, starts the effect and calls ApplyBallTouchOutcome. Cleared by ResetPointState ($08:$4cc6). |
| `0xc4af` | WRAM | `wBallTouchCharIndex` | [8-bit] Character index (0-3) of the character the ball touched, stored from wCharIndex alongside wBallTouchCharFlag at $08:$6f36. DrawBallTouchCharEffect ($08:$5487) maps it through CharIndexToWramBank to read that character's screen position; $08:$5dbc turns its low bit into the +1/-1 side sign for the point outcome. |
| `0xc4b0` | WRAM | `wBallCourtQuadrant` | [8-bit] Which quadrant of the court the ball is currently over: bit 1 = sign of wBallDepth (which side of the net), bit 0 = sign of wBallX (which half laterally). Rebuilt every frame by StepBallPhysics ($08:$5798-$57a9) by rotating the two sign bits into b; forced to $02 by the bank $0d wall-practice setup ($0d:$480f). |
| `0xc4b2` | WRAM | `wBallBounceCount` | [8-bit] Number of bounces since the last time the ball was struck, saturating at $0a. Zeroed by HandleBallHitEvent ($08:$42c5) and by ResetPointState ($08:$4cbd); incremented by HandleBallBounceEvent ($08:$4360-$4368). Read as 'first bounce' (== 1) by EvaluateBounceOutcome ($08:$4389), the fault check ($08:$4342), the drill graders in bank $0b ($41e6, $5e55, $6d75, $721f) and $0d:$47d0. |
| `0xc4b3` | WRAM | `wBallBounceEvent` | [8-bit] Per-frame bounce event code, cleared at the top of StepBallPhysics ($08:$5768): 1 = the ball reached the ground this frame ($08:$57e8, set right after GetBallHeightSign), 2 = the ball bounced off a court fence/wall ($08:$597e and $08:$59b4, inside BounceBallOffCourtFences after ApplyCourtBounceDamping). HandleBallBounceEvent ($08:$4352) returns immediately when it is 0. |
| `0xc4b4` | WRAM | `wBallCrossedNetFlag` | [8-bit] Set to 1 for the single frame in which the ball crosses the net plane; cleared at the top of HandleBallNetCrossing ($08:$5815) and set at $08:$5827 once the wBallDepth sign flip is detected. Read by TickRallyTimers ($08:$4242), by AiTrackBallPhase ($08:$7d77) and by the minigame target checks CheckBallHitsMinigameTarget ($0a:$672d) and CheckBallHitsMinigameTargetAlt ($0a:$6df4). |
| `0xc4b7` | WRAM | `wBallHitEvent` | [8-bit] Set to 1 by ExecuteShot ($07:$53b8), which also refuses to run twice while it is set ($07:$53b0-$53b5). HandleBallHitEvent ($08:$427a) consumes it once per frame: increments wRallyLength, clears it, clears wBallHasBouncedFlag and wLandingMarkerActive, then starts the landing marker and hit effect and pokes every character's state. Cleared by ResetPointState ($08:$4cc3). |
| `0xc4b8` | WRAM | `wLastShotCharIndex` | [8-bit] Character index (0-3) of the character who hit the ball, snapshotted from wCharIndex by ExecuteShot ($07:$53be). Used at $08:$5cb2 to select the wCharacterN stat block (index * 8) when crediting an ace/winner, at $08:$5da9 to turn the low bit into the point-outcome side sign, and by the bank $0d minigames ($4e80, $5292, $56f0) to test whether the player or the machine hit. |
| `0xc4b9` | WRAM | `wLastShotServeRole` | [8-bit] wCharServeRole of the character who hit the ball, snapshotted by ExecuteShot ($07:$53c4). Read once, at $08:$4337 in DetectServeAceOutcome: on the second hit of a point, role 1 (the receiver) with the ball still unbounced gives POINTOUTCOME_SERVE_VOLLEYED, and any other role gives POINTOUTCOME_WRONG_RECEIVER |
| `0xc4ba` | WRAM | `wBallSpriteEnabled` | [8-bit] Nonzero draws the ball sprite slot |
| `0xc4bb` | WRAM | `wBallShadowEnabled` | [8-bit] Nonzero draws the ball ground-shadow slot |
| `0xc4bc` | WRAM | `wBallTrailEnabled` | [8-bit] Nonzero draws the ball trail afterimages from the position history ring |
| `0xc4bd` | WRAM | `wBallTrailColor` | [8-bit] Trail palette index into BallTrailPalettes; nonzero also extends the trail from 2 to 5 ghosts |
| `0xc4be` | WRAM | `wBallQuadrantAtHit` | [8-bit] wBallCourtQuadrant captured at the moment the shot was struck ($07:$53df-$53e2). EvaluateBounceOutcome XORs it against the live wBallCourtQuadrant and tests bit 1 ($08:$4394-$439b, did the ball reach the other side of the net) and bit 0 ($08:$43b4-$43bb, did it change lateral half - the serve's diagonal-box rule). The bank $0d wall-practice bounce flips its bit 1 manually at $0d:$4b7c. |
| `0xc4bf` | WRAM | `wBallHasBouncedFlag` | [8-bit] Set to 1 when the ball bounces on the court ($08:$5848, in the net-crossing/ground-contact path that also fires StartBounceEffect); cleared by HandleBallHitEvent ($08:$428c) and ResetPointState ($08:$4cc9). Read by EvaluateBounceOutcome ($08:$43c3), by TickRallyTimers ($08:$4262) and by AiTrackBallPhase ($08:$7d73). |
| `0xc4c0` | WRAM | `wMatchSimFrozen` | [8-bit] Nonzero freezes the per-frame match simulation: UpdateMatchFrame skips ClearSpriteSlots/UpdateMatchCamera/UpdateAllChars/ball events/UpdateBallVisuals/timers and the mode hook. Set $ff during match setup and while the pause menu is open, cleared before the play loop |
| `0xc4c1` | WRAM | `wMatchDrawFrozen` | [8-bit] Nonzero freezes actor drawing: UpdateMatchFrame skips DrawActorsByDepth. Set $ff alongside wMatchSimFrozen while the pause menu is open |
| `0xc4c2` | WRAM | `wPauseDisabled` | [8-bit] Nonzero blocks the pause menu: HandlePauseMenu ($08:$449c) returns immediately when it is set. Set to 1 during match setup ($08:$40d2), for the whole changeover sequence (RunChangeoverSequence $08:$5f8e) and while the characters walk off court (WalkCharsOffCourt $08:$6012); cleared by ResetPointState ($08:$4ce3) and by PlayMinigameCountdown ($0d:$48d5). |
| `0xc4c3` | WRAM | `wMatchAbortFlag` | [8-bit] $ff = abort the match (bit 7 breaks the point/game/set/match loops); set by every pause/quit-menu action, cleared per point by ResetPointState |
| `0xc4c4` | WRAM | `wOffscreenArrowsEnabled` | [8-bit] Nonzero draws edge arrows for off-screen characters (set during the rally) |
| `0xc4c6` | WRAM | `wFallbackTrajectoryFlag` | [8-bit] Set to 1 by ApplyFallbackBallTrajectory_24 ($24:$57ff), the shared handler the court banks jump to when the requested trajectory row is out of range; cleared at the top of ExecuteShot ($07:$53ec). Read by StartLandingMarker ($08:$52e1), which then draws the lob landing marker, and by AiIsIncomingLobShot ($08:$79e7), which treats it like SHOTTYPE_LOB. |
| `0xc4c7` | WRAM | `wMatchExitRequest` | [8-bit] Nonzero when the player chose Retry / Select New Level / Quit in the quit menu (discriminated by wMatchRetryRequest/wMatchSelectNewLevelRequest); outer mode loops branch on it |
| `0xc4c9` | WRAM | `wCameraFollowBall` | [8-bit] Nonzero makes UpdateMatchCamera ($08:$61dc) overwrite the camera target from wBallGroundProjX/Y each frame instead of holding the target set by SetCameraTarget. Cleared by SetCameraTarget and SnapCameraTo ($08:$61c5, $61d8, $0d:$4955); set to 1 when the rally starts ($08:$425f), by the bank $0d wall bounce ($0d:$4b72), and explicitly cleared by KeepMinigameCameraFixed ($0d:$47be). |
| `0xc4ca` | WRAM | `wStandingShadowsEnabled` | [8-bit] Set in singles only; enables the wide flickering ground shadow under grounded characters |
| `0xc4cb` | WRAM | `wCourtViewFlipped` | [8-bit] Nonzero when the court view is mirrored so the human player stays on the near side. Recomputed by UpdateViewFlipState ($08:$4c33-$4c4a) as (wCourtViewOption != 0) && (bit 1 of $c8cf). FlipAllCharPositions ($08:$4c4e) skips flipping every character's court-position code when it is 0, and RefreshCourtScoreboard ($08:$5e99) picks the mirrored scoreboard column layout when it is set. |
| `0xc4cd` | WRAM | `wChangeEndsPending` | [8-bit] Set to 1 at $08:$4c2f when bit 1 of the game-count state $c8cf toggles, i.e. the players must change ends. RunChangeoverSequence ($08:$5f97) shows court banner $00 and walks the characters to their new ends when it is set, then clears it with $c4cc at $08:$5fb8; also cleared during match setup ($08:$4177). |
| `0xc4ce` | WRAM | `wCourtViewFlipChanged` | [8-bit] Nonzero when wCourtViewFlipped changed on the last UpdateViewFlipState pass - computed there as old minus new ($08:$4c44-$4c4a). RefreshCourtAfterEndChange ($08:$5f43) returns immediately when it is 0, and ReinitPointAfterPause ($08:$44c5) uses it to decide whether the court needs redrawing after the pause menu. |
| `0xc4cf` | WRAM | `wOnCourtCharCountMinus1` | [8-bit] wOnCourtCharCount - 1 (0x00-0x03); jumptable index for the match engine's per-character-count dispatches |
| `0xc4d0` | WRAM | `wServiceAceFlag` | [8-bit] Set when the point ended as a service ace (point outcome 6 with rally length 1); credited to the winner's ServiceAces stat |
| `0xc4d1` | WRAM | `wReturnAceFlag` | [8-bit] Set when the point ended as a return ace (point outcome 6 with rally length 2); credited to the winner's ReturnAces stat |
| `0xc4d2` | WRAM | `wServingCharWramBank` | [8-bit] WRAM bank (4-7) of the character currently serving, stored by IdentifyServingPlayer ($08:$4c83) from FindServerCharBank. Read once, at $08:$44dc, where ReinitPointAfterPause maps that bank in to put the server back into the serve state. |
| `0xc4d4` | WRAM | `wServingCharCourtPos` | [8-bit] wCharCourtPos of the serving character, stored by IdentifyServingPlayer ($08:$4c8f). Bit 1 (which side of the net the server is on) selects the serve camera target in GetServeCameraTarget ($08:$6199) and the ace-banner offset at $08:$42df; bank $09 uses the whole value as the serve-indicator object template index ($09:$4248, $4261, $4310) and mixes it with wServeFaultFlag at $09:$6c54. |
| `0xc4d5` | WRAM | `wMatchPointFlag` | [8-bit] Match-point indicator: $01/$ff = P1/P2 side wins the match by taking the next point, 0 = none (EvaluatePointSituation simulates the next point) |
| `0xc4d6` | WRAM | `wSetPointFlag` | [8-bit] Set-point indicator ($01/$ff/0, same scheme as wMatchPointFlag) |
| `0xc4d7` | WRAM | `wGamePointFlag` | [8-bit] Game-point indicator ($01/$ff/0, same scheme as wMatchPointFlag) |
| `0xc4d8` | WRAM | `wPointOutcome` | [8-bit] 0 while the rally runs; point-end cause code once the point resolves |
| `0xc4d9` | WRAM | `wPointOutcomeSide` | [8-bit] Side/sign code stored alongside wPointOutcome when a point-ending event fires ($01/$ff); negated through the court-side parity bits to decide which side won the point |
| `0xc4da` | WRAM | `wLandingMarkerActive` | [8-bit] Nonzero while the lob landing marker is shown. Set to 1 with sound $6d by StartLandingMarker ($08:$533c) right after it fills wLandingMarkerX/Y; DrawLandingMarker ($08:$5342) returns when it is 0. Cleared by HandleBallHitEvent ($08:$428f), HandleBallBounceEvent ($08:$436a), EndPointBallEffects ($08:$4fad), ResetPointState ($08:$4cd2) and $0d:$4bc9; the AI reads it at $08:$7b7b as 'a lob is coming'. |
| `0xc4db` | WRAM | `wRulesSetsIndex` | [8-bit] wMatchTypeNumberOfSets >> 1, stored during match setup ($08:$4120). ShowMatchRulesPages ($06:$4137) combines it as (this * 2 + wRulesGamesIndex) to form wRulesPageListIndex, selecting one of the six MatchRulesPageLists records. |
| `0xc4dc` | WRAM | `wRulesGamesIndex` | [8-bit] Bit 2 of wMatchTypeNumberOfGames, stored during match setup ($08:$412a); the low half of the wRulesPageListIndex computation at $06:$4133. |
| `0xc4dd` | WRAM | `wCourtViewOption` | [8-bit] The saved 'camera / court view' option. Loaded from story save-slot flag B at $08:$4526 (forced to 0 for minigames and game mode 8 at $08:$4530), edited by MatchPauseMenu_CameraSelect ($06:$441e/$4433, which writes it back with SetStorySlotFlagB). UpdateViewFlipState ($08:$4c35) only mirrors the court when it is nonzero. |
| `0xc4de` | WRAM | `wMatchRetryRequest` | [8-bit] Set to 1 by MatchQuitMenu_Retry; reruns the current drill/minigame (RunTrainingDrillByID) |
| `0xc4df` | WRAM | `wMatchSelectNewLevelRequest` | [8-bit] Set to 1 by MatchQuitMenu_SelectNewLevel; returns to the level-select screen after the match teardown |
| `0xc4e0` | WRAM | `wMatchMenuSelection` | [8-bit] Pause/quit menu selection (rst00 jumptable index: check rules / review controls / change options / save-quit); $ff = cancelled |
| `0xc4e1` | WRAM | `wStoryMenuFirstItem` | [8-bit] Item id of the first entry of the story option submenu about to be drawn ($04 court view, $06 message speed, $09 music, $0b save; $0e for the story pause root at $06:$6fec). RunStoryTwoOptionMenu ($06:$70cc) and RunStoryThreeOptionMenu ($06:$717a) draw this id, +1 and +2, add wMatchMenuSelection to it to pick the caption text ($0162 + n) and to load the highlighted item graphics. |
| `0xc4e2` | WRAM | `wTilemapDirtyFlag` | [8-bit] Nonzero means the shadow tilemap needs flushing to VRAM. FlushTilemapToVramIfDirty ($06:$45f3) returns when it is 0 and FlushTilemapToVram clears it at $06:$45f9; set to 1 by the debug stats editor after redrawing ($06:$6c0f). |
| `0xc4e3` | WRAM | `wScoreboardOrigin` | [16-bit] Packed base position of the match scoreboard layout (low byte $c4e3, high byte $c4e4), added to the fixed offsets of each element. Set by PrepareScoreboardGfx ($06:$4917/$491c, to $0002 or $0202 depending on wScoreboardLayout) and to 5 in the low byte by ShowMatchScoreboardScreen ($06:$48bb). Read as a coordinate pair by all four ScoreboardCaption_* handlers ($06:$478e, $47a1, $47b4, $47df), by DrawScoreboard ($06:$49a8), by the pip drawers ($06:$4a13, $4a3d, $4a57) and, as h/l shifted left 3, by the sprite helpers Func_06_506a ($06:$506a) and Func_06_69c8 ($06:$69ca). |
| `0xc4e5` | WRAM | `wRulesPageListIndex` | [8-bit] Which rules/description page list to display. Set by ShowMatchRulesPages ($06:$413c, from wRulesSetsIndex/wRulesGamesIndex), ShowTrainingRulesPages ($06:$4180, from wCurrentMinigameStoryMatch+1) and the minigame variant at $06:$422a (drill id * 3 + wMinigameLevel). Each of those then indexes a 4-byte-per-record page list (MatchRulesPageLists at $06:$4165 and its siblings) with it. |
| `0xc4e6` | WRAM | `wPauseMenuId` | [8-bit] Which menu_def record the pause menu system should run. Set before every RunMatchMenu / RunMatchQuitMenu / RunStoryMenu call in bank $06 ($06:$404c, $40c7, $43fd, $4426, $4443, $4470, $447b, $6fc9, $6ff1). GetMatchMenuItemCount ($06:$4820) and GetStoryMenuItemCount ($06:$6d8a) both index their 8-byte menu_def tables with it. |
| `0xc4e7` | WRAM | `wPauseMenuItemCount` | [8-bit] Number of items in the menu currently being run. RunMatchMenu ($06:$46ea) and RunStoryMenu ($06:$6d13) store the result of Get*MenuItemCount here; it is the wrap modulus passed to MoveCursorHorizontal ($06:$4724, $6d3e), the loop counter in DrawMatchMenuItems / DrawStoryMenuItems ($06:$483d, $6da7) and the index into the per-count item-position tables ($06:$482f, $4873, $6d99, $6ddd). |
| `0xc4e8` | WRAM | `wRulesFirstPageTextId` | [16-bit] Text id of the first body page of the rules sequence being shown ($2c62 for match rules at $06:$414f, $2c6a for training rules at $06:$4193, or a per-minigame value loaded from a table at $06:$424a). ShowRulesPageSequence adds the current page number to it at $06:$4342 to get the page's text id. |
| `0xc4ea` | WRAM | `wRulesTitleTextId` | [16-bit] Text id of the caption/title shown above the rules pages, computed as a fixed base plus wRulesPageListIndex ($2c25 + n at $06:$4146, $2c2b + n at $06:$418a, $2c47 + n at $06:$4234). Read at $06:$432d and passed to DrawMenuCaptionWindow. |
| `0xc4ec` | WRAM | `wMinigameHighScore` | [16-bit] The saved best score for the current minigame, copied out of the record ReadMinigameRecord returns in WRAM bank 7 at $de00 ($0d:$4107). $06:$50cf draws it instead of wMinigamesTargetScore when $c7bc marks a high-score attempt, and $0d:$41fc compares the current score against it. |
| `0xc4ee` | WRAM | `wDebugMatchFlags` | [8-bit] Flag byte for the built-in debug test match; set to $fe by RunDebugTestMatch ($07:$5e9a). Bit 1 makes the character setup call OverrideCharStatsForDebug ($07:$5c35); bit 0 makes the frame-stepping loop at $08:$4447 ignore the input wait. |
| `0xc600` | WRAM | `wTextBuffer` | Dialogue string buffer (160 bytes); text-bank fetch routines copy string N here when called with a = 0 |
| `0xc6c0` | WRAM | `wInlineTextBuffer` | 32-byte staging buffer for inline text args (player name, arg strings, short texts) rendered via RenderInlineString |
| `0xc78c` | WRAM | `wTargetZoneEnabled` | [8-bit] Nonzero draws the 4-corner court target zone (training drills) |
| `0xc790` | WRAM | `wTargetZoneX1` | [16-bit] Target zone X bound 1 (world units) |
| `0xc792` | WRAM | `wTargetZoneDepth1` | [16-bit] Target zone depth bound 1 (world units) |
| `0xc794` | WRAM | `wTargetZoneX2` | [16-bit] Target zone X bound 2 (world units) |
| `0xc796` | WRAM | `wTargetZoneDepth2` | [16-bit] Target zone depth bound 2 (world units) |
| `0xc7b2` | WRAM | `wModeHookTable` | [16-bit] Pointer to the current game mode's callback table (indexed by CallModeHook) |
| `0xc7b4` | WRAM | `wModeHookBank` | [8-bit] ROM bank of the mode callback table (0 = no hooks registered) |
| `0xc800` | WRAM | `wStorySlotData` | [buffer] Base of the story-slot state image (WRAM $c800-$caff): the live region holding the wStoryModeMainCharacter*/wGameMode/match-settings/roster fields, saved wholesale as save block 2N (see docs/save_format.md) and reloaded from it on slot load |
| `0xc8a7` | WRAM | `wKeepMatchStatsFlag` | [8-bit] Nonzero makes ResetMatchState skip clearing the per-character match stats (set by MatchQuitMenu_SaveAndQuit so a resumed match keeps its stats); cleared after use |
| `0xc8df` | WRAM | `wMatchRngState` | [8-bit] Match RNG state: seeded from hVBlankCounter at match start, stirred by AdvanceMatchRng (+$73 plus ball position bytes) |
| `0xc8ee` | WRAM | `wServeFaultFlag` | [8-bit] 1 after a first-serve fault (the next fault becomes a double fault, point outcome 2); cleared on double fault and at match reset |
| `0xc8f2` | WRAM | `wMatchIsDoubles` | [8-bit] Nonzero when the current match is doubles; selects the wider court bound and 4 on-court characters |
| `0xc8f3` | WRAM | `wOnCourtCharCount` | [8-bit] Number of characters on court (2 singles, 4 doubles, 3 in Two-On-One); one banked WRAM struct each in banks 4-7 |
| `0xc8f8` | WRAM | `wMatchBGM` | [8-bit] BGM id (see wCurrentBGM values) played for the current match/court; tiebreak overrides it with $0e |
| `0xc90d` | WRAM | `wStoryModeGenderOfMainCharacter` | [8-bit] Story Mode - main character's gender: $00 = male, $01 = female. Copied from StoryCharGenderTable by InitPlayerRecordFromTemplate ($02:$43db) and read-only thereafter. Proven by the dialogue pairs it selects via AdvanceDialogueTextCursor: $30:433 "Take good care of him, OK?" vs $30:434 "...of her, OK?" ($10:$7844), and $31:60 "He's , the Academy's newest student." vs $31:61 "She's ..." ($13:$49b8). Also picks the gendered overworld object defs ($56 + gender). |
| `0xc90e` | WRAM | `wStoryModeMainCharacterLeftHanded` | [8-bit] Story Mode - nonzero when the main character plays left-handed. Written from wCharSelectHandedness at $38:$48ba (record offset +$0e) and, on the bank $02 new-game path, from bit 2 of the character id ($02:$51c5). Bank $17 uses it to swap the spin-serve briefing text between $36:696 ("serve to the right with topspin and to the left with slice") and $36:697, its mirror image. |
| `0xc94d` | WRAM | `wStoryModeGenderOfPartnerCharacter` | [8-bit] Story Mode - doubles partner's gender ($00 male, $01 female), the partner record's copy of the field at the $40 stride. Selects the partner object def ($58 + gender) and, with the main character's gender, the four-way scene key (main << 1) \| (main XOR partner) that $13:$78c4 passes to RunStorySceneByMode. |
| `0xc94e` | WRAM | `wStoryModePartnerCharacterLeftHanded` | [8-bit] Story Mode - the partner record's copy of the left-handed flag (record offset +$0e at the $40 stride); written by the same character-select path as wStoryModeMainCharacterLeftHanded. |
| `0xc9c0` | WRAM | `wGameFlags` | Event flag bit-array; rst $20/$28/$30 set/clear/test wGameFlags[byte] with mask $80 >> bit |
| `0xcb00` | WRAM | `wStoryCharacterSlot` | [8-bit] Story Mode - which of the two story character records the character-select / name-entry / char-data screens are acting on: 0 = main character, 1 = partner. Used as a $40-stride index into the wStoryModeMainCharacter*/wStoryModePartnerCharacter* pair (GetActiveStoryNameBuffer at $38:$73fa returns wStoryModeNameOfMainCharacter or ...OfPartnerCharacter straight off it). |
| `0xcb04` | WRAM | `wMenuCursorX` | [8-bit] Menu cursor column; MoveMenuCursorGrid_3b wraps it at the column count in b |
| `0xcb05` | WRAM | `wMenuCursorY` | [8-bit] Menu cursor row; MoveMenuCursorGrid_3b wraps it at the row count in c |
| `0xcb06` | WRAM | `wMenuCursor2X` | [8-bit] Secondary menu cursor column (parallel to wMenuCursorX; second selection region of the shared menu-input handler) |
| `0xcb07` | WRAM | `wMenuCursor2Y` | [8-bit] Secondary menu cursor row (parallel to wMenuCursorY) |
| `0xcb08` | WRAM | `wMenuCursorLockFlags` | [8-bit] Menu cursor lock flags: bit 0 / bit 1 freeze the primary / secondary cursor's movement (set on confirm) in the shared menu-input handler |
| `0xcb0b` | WRAM | `wAnimatedTileSet` | [8-bit] Which animated-tile set the shared UpdateAnimatedTiles frame task ($39:$4342) cycles: masked with $03 and used as the index into the two pointer tables at $39:$4403 and $39:$440b. Written (values $00-$03 only) by the screen setup routines that install the task: $10:$4f92 (main menu, 0), $17:$44a6/$44f5 (court diagram, 0), $17:$6f4c (1), $1b:$73e7 (1), $1e:$7333 (1), $3b:$44b3/$496d/$4d03/$5151 (0), $3b:$7a03 (star-chart results, 1), $3e:$49f7/$4abc/$4c2b (link screens, 0), $16:$4a18/$4a30 (match result: 2 on win, 3 on lose, alongside the matching palette load). |
| `0xcb0c` | WRAM | `wAnimatedTilePeriod` | [8-bit] Frame period of the animated-tile task: $cb0a counts 0,1,..,period-1 and the animation only steps on the frame it wraps to 0 ($39:$434e-$4363). Written with $03 by almost every caller, $05 at $3e:$4ac1, $06 at $16:$4a6c. |
| `0xcb0d` | WRAM | `wMenuInputPressed` | [8-bit] Menu loop's copy of hInputPressed (same bit layout as hPlayerInputFlags) |
| `0xcb0e` | WRAM | `wMatchFormatDoubles` | [8-bit] Match-format menu: singles (0) / doubles (1) selection; copied to wMatchIsDoubles |
| `0xcb0f` | WRAM | `wMatchFormatGames` | [8-bit] Match-format menu: games-per-set selection index; table-mapped to wMatchTypeNumberOfGames |
| `0xcb10` | WRAM | `wMatchFormatSets` | [8-bit] Match-format menu: number-of-sets selection index (0-2); table-mapped to wMatchTypeNumberOfSets |
| `0xcb11` | WRAM | `wMenuSlideDirection` | [8-bit] Menu transition direction (1 = forward into submenu, 0 = back); direction arg to the *SlideIn/*SlideOut menu transitions |
| `0xcb26` | WRAM | `wPauseMenuWindowId` | [8-bit] Window handle owned by bank $1a's menu code. Stored from the return value of CreateMenuWindowFromText ($1a:$403c) and CreateWindow ($1a:$43c0), then passed in a to RunMenuSelectionShared ($1a:$404b), CloseWindow ($1a:$4070, $1a:$444d), WriteStringToWindow ($1a:$43df/$43f9) and GetWindowStructPtr ($1a:$4149). |
| `0xcb27` | WRAM | `wMenuInitialRow` | [8-bit] Preset cursor row for the next RunMenuSelectionShared ($05:$4aa8) call: at menu open it is copied into the live row variable ($d830, WRAM bank $05) and then cleared to 0 ($05:$4ad1-$4ad8), so it defaults to row 0. Bank $1a writes the last selected row here ($1a:$41b8/$41ca/$4203/$4232) before rebuilding the pause menu so re-entry restores the cursor; $1a:$4093 clears it when the menu closes for good. |
| `0xcb28` | WRAM | `wMenuAdjustRowMask` | [8-bit] Per-row mask of menu rows on which LEFT/RIGHT act as a value adjust: bit 7 = mask present, bits 0-6 = one bit per row (tested by rotating right ($d830)+1 times, $05:$4c77-$4c8e and $05:$4ca3-$4cba). Gates the LEFT/RIGHT branch of the menu driver (Func_05_4c76, called at $05:$4bd5) and makes AnimateMenuScrollArrowsTask draw the left/right arrows on that row. Set by bank $1a: $83 (rows 0-1) for the pause menu at $1a:$4249, $8c (rows 2-3) for the minigame pause menu at $1a:$4386; cleared at $1a:$4096. |
| `0xcb29` | WRAM | `wMenuKeepOpenRowMask` | [8-bit] Per-row mask (same bit7-present + rotate-by-row encoding as $cb28) of menu rows that must NOT close the menu window when chosen: after RunMenuSelectionShared returns, $1a:$4057-$406e tests the bit for the chosen row and jumps past the CloseWindow call at $1a:$4070 when set. Written with the same values as $cb28 ($83 at $1a:$424e, $8c at $1a:$4389); cleared at $1a:$409c. |
| `0xcb2d` | WRAM | `wTennisDictScrollTop` | [8-bit] Study Vocabulary / Tennis Dictionary screen (bank $3f): index of the first entry shown in the 6-row scrolling term list. Absolute entry = ($cb2d + $cb2e) mod $cb2f (Func_3f_517b, $3f:$5181). Advanced/wrapped against $cb2f when the cursor runs off the top/bottom ($3f:$56d6-$56e2, $3f:$5700-$570c), recomputed by the page-jump helpers Func_3f_5192/Func_3f_520f, and used as the render start in Func_3f_5261 ($3f:$528d). Cleared on screen entry at $3f:$40c8. |
| `0xcb2e` | WRAM | `wTennisDictCursorRow` | [8-bit] Study Vocabulary screen (bank $3f): cursor row within the visible page. On the scrolling term list it is clamped to 0-5 ($3f:$56c6-$56f8) and scrolls $cb2d past those limits; on the 9-cell category index page it is clamped to 0-8 ($3f:$55b0-$55de). Drives the highlight row (stride $80 = 4 tilemap rows, Func_3f_54c8) and the hand-cursor sprite Y (stride $10 px, $3f:$4f9a-$4fab). Cleared at $3f:$40cb and reset to 0 by the page-jump helpers ($3f:$51a2, $3f:$522c, $3f:$5495). |
| `0xcb2f` | WRAM | `wTennisDictEntryCount` | [8-bit] Study Vocabulary screen (bank $3f): number of list entries that pass the current category filter. Computed by Func_3f_50f7 ($3f:$5102-$5116) by counting bytes of SelectionMaskGrid_3f that AND with $cb32 (up to the $40 terminator), and used as the wrap modulus for the scroll offset ($3f:$5181, $3f:$5700, $3f:$51ac). |
| `0xcb32` | WRAM | `wTennisDictCategoryMask` | [8-bit] Study Vocabulary screen (bank $3f): category filter mask. Set from the screen mode at $3f:$40be - $01/$02/$04/$08/$10 for modes 0-4, $1f (all categories) for mode 5 and any other value. Every list walk ANDs it against the per-entry category byte in SelectionMaskGrid_3f to decide whether an entry is listed ($3f:$5102, $3f:$5295, $3f:$5339, $3f:$5422, $3f:$547c, $3f:$51a5, $3f:$522f, $3f:$5625). |
| `0xcb34` | WRAM | `wTennisDictMode` | [8-bit] Study Vocabulary screen (bank $3f): the mode argument passed in a to TennisDictionaryScreen, stored at $3f:$4082. Modes 0-5 pick the category mask in $cb32 and open the term list directly; mode 6 (the only value used in the retail flow, $10:$54b8) opens the 9-cell category index page instead - checked at $3f:$40f0, $3f:$412a, $3f:$4ed4 (index-page sprite animation) and $3f:$56ab (B-button return code $10 vs $01). |
| `0xcb37` | WRAM | `wTennisDictFlags` | [8-bit] Study Vocabulary screen (bank $3f) display flags, cleared at $3f:$40c5. bit 0 = a description window is open: set at $3f:$5620 before CreateDialogueWindow, cleared at $3f:$5699/$413a, and freezes the hand-cursor animation counter $cb3e ($3f:$4f8c). bit 1 = the scrolling term list is on screen (set $3f:$414d/$41d0, cleared $3f:$421a for the index page); gates drawing of the cursor sprites ($3f:$4f85) and shifts the index-page sprites by $10 px ($3f:$4f1f/$4f3a/$4f55/$4f70). bit 2 / bit 3 = flash the left / right page arrow this frame - set on LEFT ($3f:$571b) and RIGHT ($3f:$5731), drawn from SpriteTemplate_3f_5006 at X $18 / $88 ($3f:$4fc9/$4fdc), and both cleared at the top of every input tick ($3f:$560a). |
| `0xcb3f` | WRAM | `wCutsceneStep` | [8-bit] Bank $6b cutscene driver (intro/title/award ceremony): current step index, dispatched through the per-scene jumptable |
| `0xcb40` | WRAM | `wCutsceneStepTimer` | [8-bit] Bank $6b cutscene driver: frame counter for the current step; incremented per frame and compared against per-step thresholds to advance wCutsceneStep |
| `0xcb42` | WRAM | `wCutsceneScrollX` | [8-bit] Bank $6b cutscene driver: accumulated horizontal pan position, copied to hScrollX each frame |
| `0xcb4a` | WRAM | `wIntroCutsceneScrollY` | [16-bit] Intro cutscene (bank $6b): world-space vertical scroll/camera position, little-endian. Initialised to $0120 at the start of scenes 00/12/19 ($6b:$41bf, $6b:$4916, $6b:$4c65) and decremented every frame by the per-frame delta table at $6b:$4cc1 indexed by wCutsceneStepTimer ($6b:$4caa-$4cbd). Consumers: ApplyCutsceneScrollToSpriteX ($6b:$5191) subtracts it from the sprite base coordinate that QueueSpriteTemplate treats as Y (the sp+0 slot, $00:$1ebf - so despite the existing label it is the Y axis), and SetCameraYFromScrollPos ($6b:$60d5) shifts it left 5 into wCameraY. $6b:$60fe uses ($cb48 - $cb4a) as the on-screen Y of the object drawn by QueueIntroSpriteBlock. |
| `0xcb50` | WRAM | `wCharSelectHandedness` | [8-bit] Story-mode character-select screen (bank $38): handedness toggle, 0 = default, 1 = mirrored (left-handed). Cleared on entry ($38:$4815, $38:$4984, $38:$4a82) and flipped by START ($38:$48fc `xor $01`) - the on-screen prompt for that row is text 30:118 'START: Change Hands' ($38:$4b0c). When non-zero, Func_38_4bac sets bit 5 (OAM X-flip) in wCharSpriteSlot+1 for all four displayed characters ($38:$4c6f-$4ca6), and Func_38_4e23 draws the marker sprite with tile base $00 instead of $02 ($38:$4e3c). The chosen value is written into the story character record at +$0e ($38:$48ba). |
| `0xcb52` | WRAM | `wCharSelectIsPartner` | [8-bit] Story-mode character-select screen (bank $38): which pick is in progress - 0 = main character, 1 = partner. Stored from the b argument of RunCharacterSelectScreen ($38:$47d0; callers pass 0 at $10:$40bb and $1b:$61fa, 1 at $1b:$629b). Selects the prompt text (0 -> text 30:117 'Pick a Character' at $38:$4ae8, 1 -> text 30:119 'Choose Partner' at $38:$4afb), swaps in mugshots 2/3 and repositions the two character sprites ($38:$4a27, $38:$4c13), and is doubled into the character id: id = 2*$cb52 + cursor ($38:$4896, $38:$4958, $38:$4e09). |
| `0xcb53` | WRAM | `wLinkPartnerCourtMask` | [8-bit] Court-select: the link partner's bonus-court unlock mask, received over the cable. Cleared at $10:$5171 for local play; set at $38:$75ef/$75f7 from the received link block ($ca8a or $ca0a depending on hLinkState) right after the block-$26 exchange that sends our own $cb54 ($38:$759c). ORed with $cb54 before StoreCourtUnlockBits ($3e:$5d18, $3e:$65db) and before choosing the 9-court vs 4-court menu ($38:$748d). |
| `0xcb54` | WRAM | `wUnlockedCourtMask` | [8-bit] Bitmask of the five unlockable bonus courts (court ids 4-8; courts 0-3 are always available per IsCourtUnlocked $3e:$697b). Built from the save flags by ComputeUnlockedCourtFlags ($3e:$69a0-$69c9, one bit per row of the 5-entry table at $3e:$69ca) and cleared at $10:$5174. Passed in b to StoreCourtUnlockBits ($3e:$695a), which explodes it into the five per-court bytes at $d000 in WRAM bank $02; also decides whether the 9-court or the 4-court select menu runs ($10:$5199, $38:$7489) and is the payload of link block $26 ($38:$759c). |
| `0xcb61` | WRAM | `wBgMapShadowDirty` | Dirty flags for the bank $18 BG map shadow buffers: low nibble set -> queue $d800->$9800 tilemap copy, high nibble -> $dc00->VRAM1 $9800 attrmap copy (FlushBgMapShadowToVram clears it). |
| `0xcb62` | WRAM | `wDebugCharViewerPage` | [8-bit] Debug character viewer (Func_1a_67d4, reachable only from the unused debug path at $01:$41bf/$41fd with hDebugStepMode set): page of the 2x16 character grid, 0 or 1. Cleared at $1a:$67d5, incremented/decremented when the cursor wraps off the bottom/top row ($1a:$695f, $1a:$698f), and combined into the selected character id as ($cb62 << 4) + $cb63 -> $d002 ($1a:$69d0-$69dc), which is then fed to LoadOnCourtCharTilesA ($1a:$6837). |
| `0xcb63` | WRAM | `wDebugCharViewerIndex` | [8-bit] Debug character viewer (Func_1a_67d4): cursor index 0-15 within the current page - LEFT/RIGHT step by 1 and wrap inside the current row of 8 ($1a:$691b-$692d, $1a:$6934-$6945), UP/DOWN step by 8 and roll into $cb62 ($1a:$694c, $1a:$6979). Selected character id = ($cb62 << 4) + $cb63 ($1a:$69d8). Also indexes the cursor-sprite position table at $1a:$6b0f ($1a:$6af9). |
| `0xcb76` | WRAM | `wGlyphTileWritePtr` | VRAM tile-data write pointer for the proportional-glyph renderer (bank $05 text engine) |
| `0xcc00` | WRAM | `wDebugTextBuffer` | [576 bytes] Debug text console tilemap buffer, DMAed to $9d00 rows when active |
| `0xd841` | WRAM | `wTextArrowBlinkCounter` | WRAM5: frame counter for the text continue-arrow blink task (bit 4 selects tile) |
| `0xd847` | WRAM | `wTextArgStringWriteIndex` | WRAM5: write index into wTextArgStringQueue (max 16) |
| `0xd849` | WRAM | `wTextArgShortTextWriteIndex` | WRAM5: write index for the short-text-id arg queue |
| `0xd84a` | WRAM | `wTextArgStringCount` | WRAM5: count of queued arg strings (mirrors wTextArgStringWriteIndex) |
| `0xd850` | WRAM | `wTextPageBreakRequest` | WRAM5: set by TextCmdWaitButtonPage; TextInterpreterLoop saves resume offset to $d84e/f and returns |
| `0xd864` | WRAM | `wGlyphVramDest` | WRAM5: current VRAM destination address for glyph tiles (lo/hi) |
| `0xd869` | WRAM | `wTextStreamPtr` | WRAM5: current read pointer into the text byte stream |
| `0xd880` | WRAM | `wShortTextBuffer` | Short string buffer (16 bytes); text-bank fetch routines copy here when called with a != 0 |
| `0xd8b0` | WRAM | `wTextArgStringQueue` | WRAM5: 16 x 2-byte string pointers queued by PushTextArgString (hi nibble = WRAM bank tag) |
| `0xd8d0` | WRAM | `wTextArgNumberQueue` | WRAM5: 16 x 2-byte values queued by PushTextArgNumber for TextCmdPrintArgNumber |
| `0xff8a` | HRAM | `hScrollY` | [8-bit] SCY shadow, applied in VBlank |
| `0xff8b` | HRAM | `hScrollX` | [8-bit] SCX shadow, applied in VBlank |
| `0xff8c` | HRAM | `hVBlankCounter` | [8-bit] Increments every VBlank |
| `0xff8d` | HRAM | `hVBlankOccurred` | [8-bit] Set at end of VBlank handler; AdvanceFrame waits on it |
| `0xff8e` | HRAM | `hDebugTextDirty` | [8-bit] Nonzero = wDebugTextBuffer needs re-upload |
| `0xff8f` | HRAM | `hFrameTasksReady` | [8-bit] Nonzero when wFrameTasks is consistent; cleared while the list is mutated so the frame hook skips it |
| `0xff91` | HRAM | `hInputPressed` | [8-bit] Buttons newly pressed this frame (same bit layout as hPlayerInputFlags) |
| `0xff92` | HRAM | `hInputRepeatButtons` | [8-bit] Buttons held for key-repeat tracking |
| `0xff93` | HRAM | `hInputRepeatTimer` | [8-bit] Frames until next key-repeat fire |
| `0xff94` | HRAM | `hInputRisingEdge` | [8-bit] Buttons newly pressed this frame (raw, before repeat processing) |
| `0xff95` | HRAM | `hRomBank` | [8-bit] Shadow of the current ROM bank (written together with the MBC register at $2000) |
| `0xff96` | HRAM | `hWramBank` | [8-bit] Shadow of the current WRAM bank (last value written to rSVBK); match engine swaps banks 4-7 for per-character data |
| `0xff97` | HRAM | `hSramBank` | [8-bit] Shadow of the current SRAM bank (always written together with the MBC RAM-bank register at $4000) |
| `0xff98` | HRAM | `hShowDebugConsole` | [8-bit] 1 = VBlank switches BG map to the debug console view |
| `0xff99` | HRAM | `hVRAMQueueDirty` | [8-bit] Nonzero = VRAM copy / tile-write queues have pending entries |
| `0xff9b` | HRAM | `hSpriteQueueIndex` | [8-bit] Write offset into the OAM shadow buffer (max $a0) |
| `0xff9c` | HRAM | `hSpriteQueueBase` | [8-bit] OAM shadow offset where per-frame sprites start (entries below persist) |
| `0xff9d` | HRAM | `hPaletteDirtyFlags` | [8-bit] Bit 0 = BG palettes dirty, bit 1 = OBJ palettes dirty |
| `0xff9e` | HRAM | `hDebugStepMode` | [8-bit] Debug pause/frame-step mode (0 = off, 1-3) |
| `0xffa0` | HRAM | `hPeakLY` | [8-bit] Peak LY at end-of-frame (frame time meter shown on debug console) |
| `0xffa1` | HRAM | `hPeakLYFrames` | [8-bit] Frames until hPeakLY decays |
| `0xffa2` | HRAM | `hFadeState` | [8-bit] Bit 0 = fading out, bit 1 = fading in, bit 7 = fade to white |
| `0xffa3` | HRAM | `hFadeSpeed` | [8-bit] Fade step per frame |
| `0xffa4` | HRAM | `hFadeCounter` | [8-bit] Fade progress counter (starts at $7c) |
| `0xffa6` | HRAM | `hInputRepeatDelay` | [8-bit] Key-repeat interval reload value |
| `0xffa7` | HRAM | `hMathSign` | [8-bit] Sign scratch for signed multiply/divide wrappers |
| `0xffa8` | HRAM | `hMulResult` | [32-bit] Full 32-bit product from MulHLByDE |
| `0xffb8` | HRAM | `hBGRowBlitPending` | [8-bit] Nonzero = row in wBGRowBlitBuffer awaits VBlank blit |
| `0xffb9` | HRAM | `hBGColumnBlitPending` | [8-bit] Nonzero = column in wBGColumnBlitBuffer awaits VBlank blit |
| `0xffba` | HRAM | `hBGColumnBlitDone` | [8-bit] Set when the slow column blit ran this VBlank (skips VRAM queue) |
| `0xffbc` | HRAM | `hFadedOut` | [8-bit] Nonzero = screen currently faded out |
| `0xffc0` | HRAM | `hLinkRxByte` | [8-bit] Last byte received over the serial link (captured from rSB in the serial interrupt) |
| `0xffc1` | HRAM | `hLinkTxByte` | [8-bit] Next byte to transmit over the serial link (copied to rSB) |
| `0xffc2` | HRAM | `hLinkState` | [8-bit] Serial link state/role (0 = idle, 1/2 = connected roles); gates the encode/decode paths |
| `0xffc8` | HRAM | `hLinkCounter` | [8-bit] Serial link exchange/frame counter; increments per exchange and caps at 8 |
| `0xffcd` | HRAM | `hActiveJingle` | [8-bit] Jingle sound id currently overriding BGM (0 = none) |
| `0xfffc` | HRAM | `hRandomSeed` | [16-bit] RNG state (x*5 + $3573 per VBlank) |
| `0xfffe` | HRAM | `hIsCGB` | [8-bit] 1 = running on Game Boy Color hardware |

## Union overlays

Some RAM ranges are reused by several subsystems that never run at the same
time. These are RGBDS `UNION`/`NEXTU` overlays in `ram/*.asm`: each variant
carries its own symbols, and its note says which code owns it. When the
source was generated, a variant's names were substituted only at sites whose
*scope* matched — the referencing code's ROM bank and range, and/or the WRAM
bank provably selected at the site by a control-flow dataflow or a traced
run — so the same `$dxxx` offset reads as a different symbol in different
routines, and a site whose bank could not be proven kept the numeric address
(97 remain, all inside `Unused_*` routines nothing reaches). That
attribution is now simply what the source says: an edit that moves an
access from one owner to another changes the operand by hand, and the
assembler accepts any variant's symbol anywhere, so the notes on the
variants are the guide to which one a routine may touch.

The WRAM-bank scoping matters for banked WRAMX (`$d000-$dfff`): the same
offset means different things per WRAM bank, so a global name would leak
across banks.

### Mirrored variants

The opposite case also occurs: one address range holding a *parallel copy* in
each of several WRAM banks, where the address names the cell and the selected
bank picks which copy. The character-data screen keeps its stat pages that way,
tiles in bank `$03` and CGB attributes in bank `$02`, so a save is one copy per
bank to the very same word:

```asm
	wram_bank $03
	ld hl, wShadowTilemap
	ld de, wCharDataPageSlot1
	call CopyMemoryFast
	wram_bank $02
	ld hl, wScreenAttrmap
	ld de, wCharDataPageSlot1     ; same address, other plane
	call CopyMemoryFast
```

No per-bank name is right for that operand, and requiring a provable bank
leaves it numeric. A variant marked `"mirrored": true` names the whole set: it
matches when the site's bank is any of the banks its scopes list **or when the
bank cannot be proved at all**, and still loses to a bank proved to be outside
the set — one ROM bank often drives several WRAM banks over the same addresses.
Because the claim is that wide, every scope must carry a ROM `bank`, and at
least two distinct `wram_bank`s must be named; `load_ram_unions` rejects both
mistakes.

A mirrored variant **allocates nothing**. Each of its banks already declares
those bytes in its own union, so a second allocation would double-book the
section. It is emitted instead as an EQU into the generated
`include/ram_mirrored.inc`, which is preincluded for every bank — an EQU is
assembly-time only, so unlike an exported `::` label it has to be visible while
each bank is assembled rather than at link time.

A bare `$dxxx` operand left in the source is a candidate for one: one
address, several banks, one routine.

### Bank-tagged copies

A structure that is genuinely replicated — the match engine keeps one
per-character struct in each of WRAM banks 4-7 — gets both forms. Each bank
declares its own copy under a bank-tagged name (`w4CharPosX`, `w5CharPosX`, …)
in its own `BANK[n]` section, and the untagged `wCharPosX` is the EQU the
disassembly uses, because which copy a site means is decided by the WRAM bank
selected at run time.

The tagged labels are what put the structure in `build/mariotennis.sym`: EQUs
do not reach the symbol file, so this is what lets an emulator debugger resolve
the right name for whichever bank it is stopped in — 328 correct entries rather
than 82 registered against bank 4 alone. A bank whose own section already runs
past those addresses is skipped, since it declares them already. (The `$dfxx` match-engine structs below predate this and
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
expansion the global symbols get), so `$dd1e` reads `wBallHistory + 30` and
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
via a union variant in `ram/wram.asm` (see "Union overlays" above): one `wChar*` name per field, rendered only where the WRAM bank is
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

### Reading a bank at a glance

Each banked `SECTION` in the generated `ram/*.asm` opens with a one-line-per-
region summary. A bank is 4 KiB of overlapping claims — bank `$03` alone has 99
symbols across 19 overlay variants — so the section body tells you what is there
only once you have read all of it:

```
; WRAMX bank 2 at a glance (ram/wram.asm):
;
;   $d000-$dfff  match court planes / overworld scroll buffers / screen attribute plane
;   $d400-$d7df  wCharDataPagePlane  [mirrored with bank 3]
;   $d7e0-$da1f  wCharDataPageSlot1  [mirrored with bank 3]
```

Overlay variants collapse to their `context` strings; a range with more than
three lists the first three and a count. This is also the only place mirrored
structures appear in the layout at all — they allocate nothing, so no symbol in
either bank's section would otherwise mention them.

## Free RAM

What a modder can take without displacing anything, measured two ways on
2026-09-11. `tools/ram_free.py` walks the generated `ram/` the way the
assembler does and lists every byte no symbol covers and no raw literal in
`src/` addresses (the top 512 bytes of WRAM0 are the stack, which grows down
from `STACK_TOP` `$d000` and has no symbol; the deepest reach seen is
`$cf34`). That list is only "unnamed", so each byte in it was then
*poisoned* -- set to `$5a` in a BizHawk savestate -- and seven scripted flows
were replayed from the poisoned and the clean state and compared byte for
byte: the main menu and exhibition setup, a singles match with a pause menu,
the developer Test map (walking, three NPC talks), the N64 status screens,
the lesson menu, the ending credits, and a story doubles match launched from
the Test map. A byte still holding `$5a` afterwards was never written; in
every flow but one the run was identical in every named byte and on screen,
so nothing read the poison either. (The exception is the story character
record: poisoning its undeclared fields at `$c907-$c90a` and `$c90f-$c913`
changed the player's overworld sprite attributes, so those are live fields,
not padding.) The written bytes were then checked against every saved state
of the session: a byte that was written but is zero in all of them was only
ever *cleared*.

Three classes came out of the 4,404 bytes the static pass lists once the
tile-animation buffer, the second shadow-OAM page, the character records'
documented field groups and the mirror records' name, id, palette, gender
and handedness fields are declared (all of which the first pass had counted
as unnamed):

* **Untouched (2,591 bytes).** Neither written nor read in any flow. Safe to
  allocate; the ones eight bytes or longer:

| bank | range | bytes |
|---|---|---|
| WRAM0 | `$c2a6-$c2af` | 10 |
| WRAM0 | `$c2c8-$c2cf` | 8 |
| WRAM0 | `$c2f0-$c2f7` | 8 |
| WRAM0 | `$c377-$c37f` | 9 |
| WRAM0 | `$c3a8-$c3af` | 8 |
| WRAM0 | `$c3e0-$c3ff` | 32 |
| WRAM0 | `$cb79-$cbef` | 119 |
| WRAM0 | `$cbf2-$cbff` | 14 |
| WRAM4 | `$d690-$d7ff` | 368 |
| WRAM6 | `$dc90-$ddc0` | 305 |
| WRAM6 | `$ddc2-$dddf` | 30 |
| WRAM6 | `$dde2-$de00` | 31 |
| WRAM6 | `$de02-$deff` | 254 |
| WRAM7 | `$d020-$d057` | 56 |
| WRAM7 | `$d098-$d0d6` | 63 |
| WRAM7 | `$d21a-$d27f` | 102 |
| WRAM7 | `$db00-$db25` | 38 |
| WRAM7 | `$db28-$db53` | 44 |
| WRAM7 | `$db61-$db7f` | 31 |
| WRAM7 | `$db81-$dbff` | 127 |
| WRAM7 | `$dc0b-$ddc0` | 438 |
| WRAM7 | `$ddc2-$dddf` | 30 |
| WRAM7 | `$dde2-$ddff` | 30 |
| WRAM7 | `$de02-$deff` | 254 |

  plus 29 shorter gaps (63 bytes) and 23 bytes of HRAM in twelve
  one-to-four-byte holes. The banks `$06`/`$07` ranges at `$dc90-$deff`
  mirror bank `$04`'s ball and minigame slots and stayed untouched even in
  the doubles match; `$d690-$d7ff` in bank `$04` is untouched everywhere.

* **Cleared only (1,616 bytes).** Written, but never with anything but
  zero: they sit inside a block clear and nothing else reaches them. The
  whole of WRAM bank `$05` is cleared by `ResetTextWindowState` (`$05:$6e09`,
  two `ClearMemory16` runs of `$800` bytes from `$d000` and from `$d800`)
  every time a text screen starts, and every WRAMX bank is cleared at boot
  (`$01:$402c`-`$4075`); `$df00-$dfff` of each character bank is cleared at
  match setup (`$08:$68a1`, `$38:$47f5`). So the "text-engine buffers" the
  first pass reported in bank `$05` are nothing of the kind: the window
  engine's state is what is already named there (`$d800-$d8ff`,
  `$dc00-$dc7f`), and the rest of the bank is zeroed scratch. Usable, with
  the rule that the clear will take it back at the next screen or match
  init. Eight bytes or longer:

| bank | range | bytes | cleared by |
|---|---|---|---|
| WRAM0 | `$c495-$c49f` | 11 | boot / screen init |
| WRAM0 | `$c778-$c77f` | 8 | boot / screen init |
| WRAM0 | `$c7d8-$c7ff` | 40 | boot / screen init |
| WRAM0 | `$c892-$c8a2` | 17 | boot / screen init |
| WRAM0 | `$c97c-$c9af` | 52 | boot / screen init |
| WRAM0 | `$c9b7-$c9bf` | 9 | boot / screen init |
| WRAM0 | `$c9e0-$c9ff` | 32 | boot / screen init |
| WRAM5 | `$d810-$d81f` | 16 | ResetTextWindowState, boot |
| WRAM5 | `$d870-$d87f` | 16 | ResetTextWindowState, boot |
| WRAM5 | `$d890-$d8af` | 32 | ResetTextWindowState, boot |
| WRAM5 | `$db08-$db0f` | 8 | ResetTextWindowState, boot |
| WRAM5 | `$db14-$db53` | 64 | ResetTextWindowState, boot |
| WRAM5 | `$db61-$db7f` | 31 | ResetTextWindowState, boot |
| WRAM5 | `$db81-$dbff` | 127 | ResetTextWindowState, boot |
| WRAM5 | `$dc80-$ddc0` | 321 | ResetTextWindowState, boot |
| WRAM5 | `$ddc2-$dddf` | 30 | ResetTextWindowState, boot |
| WRAM5 | `$dde2-$de00` | 31 | ResetTextWindowState, boot |
| WRAM5 | `$de02-$deff` | 254 | ResetTextWindowState, boot |
| WRAM5 | `$df97-$dfff` | 105 | match setup ($df00 clear), boot |
| WRAM6 | `$df97-$dfff` | 105 | match setup ($df00 clear), boot |
| WRAM7 | `$df97-$dfff` | 105 | match setup ($df00 clear), boot |

* **Holds data (209 bytes).** Written with real values somewhere in the
  session. What was left of this class once the record fields were named
  is two things, each now understood: `$c6e0-$c6ff`, `$c705` and
  `$c730-$c75f` are leftovers of the save engine's staging copy --
  `MirrorSaveHeaderToBank1` runs each 512-byte SRAM header region through
  `$c600-$c7ff` on its way to SRAM bank 1, so the tail of the block
  directory stays behind under the debug-menu variables (`wTextBuffer`'s
  note); `$d2b0-$d2ff` of bank `$07` are five glyph tiles the text engine
  writes *below* `wGlyphTileBuffer` when the pen goes negative, seen on the
  lesson menu's second page (`docs/bugs.md`). (The four bytes at `$df84`
  of the character banks that an earlier pass left unexplained are
  `wCharSpriteSlotFrame`: the single-character screens park the frame
  descriptor after the sprite slot, and only they write it.)

Not exercised: the minigames, link play, the N64 transfer screens and the
story scenes beyond the Test map, so a range here is free for those modes
only as far as the static pass says -- nothing addresses it by name.

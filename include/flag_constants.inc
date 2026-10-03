; Game-flag names (docs/story_mode.md).
; FLAG_* = a bit of the per-story-slot wGameFlags array ($c9c0, 32 bytes).
; The value is the flag number: byte * 8 + bit, where the handlers apply
; mask $80 >> bit to wGameFlags[byte]. Pass it to `set_flag`/`clear_flag`/
; `test_flag`/`flag_id` (one-argument form) or to *GameFlagByNumber.

def FLAG_NEW_GAME_CLEARED_BIT equ 14 ; wGameFlags byte $01 bit 6
def FLAG_NEW_GAME_SET_BIT equ 15 ; wGameFlags byte $01 bit 7

def FLAG_DEBUG_NOCLIP equ 16 ; wGameFlags byte $02 bit 0
def FLAG_PLAYER_RUNNING equ 17 ; wGameFlags byte $02 bit 1
def FLAG_HIDE_OVERWORLD_ACTORS equ 20 ; wGameFlags byte $02 bit 4
def FLAG_DEBUG_SKIP_LOCATION_EXIT equ 21 ; wGameFlags byte $02 bit 5
def FLAG_CUTSCENE_FAST_FORWARD equ 22 ; wGameFlags byte $02 bit 6

def FLAG_VRAM_UPDATE_BUSY equ 24 ; wGameFlags byte $03 bit 0
def FLAG_TEXT_WAITING_FOR_BUTTON equ 25 ; wGameFlags byte $03 bit 1
def FLAG_DEBUG_FREEZE_TILE_ANIM equ 26 ; wGameFlags byte $03 bit 2
def FLAG_DEBUG_STATIC_TEXT_WINDOW equ 27 ; wGameFlags byte $03 bit 3
def FLAG_CHAR_DATA_START_EXITS equ 28 ; wGameFlags byte $03 bit 4
def FLAG_DRILL_FROM_MENU equ 30 ; wGameFlags byte $03 bit 6
def FLAG_DEBUG_FLAG_EDITOR_OPEN equ 31 ; wGameFlags byte $03 bit 7

def FLAG_DEBUG_SHOW_PLAYER_POS equ 32 ; wGameFlags byte $04 bit 0
def FLAG_DEBUG_KEEP_MATCH_SETTINGS equ 33 ; wGameFlags byte $04 bit 1
def FLAG_DEBUG_SHORT_GLYPH_UPLOAD equ 34 ; wGameFlags byte $04 bit 2
def FLAG_TEXT_RENDER_ACTIVE equ 35 ; wGameFlags byte $04 bit 3
def FLAG_PROPORTIONAL_TEXT_MODE equ 36 ; wGameFlags byte $04 bit 4

def FLAG_STORY_MENU_LOCKED equ 46 ; wGameFlags byte $05 bit 6
def FLAG_DOUBLES equ 47 ; wGameFlags byte $05 bit 7

def FLAG_PAUSE_OPTIONS_MENU_OPEN equ 48 ; wGameFlags byte $06 bit 0
def FLAG_MINIGAME_PAUSE_MENU_OPEN equ 49 ; wGameFlags byte $06 bit 1
def FLAG_WON_DREAM_MATCH_DOUBLES equ 52 ; wGameFlags byte $06 bit 4
def FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL equ 53 ; wGameFlags byte $06 bit 5
def FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL equ 54 ; wGameFlags byte $06 bit 6
def FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 equ 55 ; wGameFlags byte $06 bit 7

def FLAG_WON_DREAM_MATCH_SINGLES equ 59 ; wGameFlags byte $07 bit 3
def FLAG_WON_ISLAND_OPEN_SINGLES_FINAL equ 60 ; wGameFlags byte $07 bit 4
def FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL equ 61 ; wGameFlags byte $07 bit 5
def FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 equ 62 ; wGameFlags byte $07 bit 6
def FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 equ 63 ; wGameFlags byte $07 bit 7

def FLAG_WON_JUNIOR_DOUBLES_RANK_3 equ 64 ; wGameFlags byte $08 bit 0
def FLAG_WON_JUNIOR_DOUBLES_RANK_2 equ 65 ; wGameFlags byte $08 bit 1
def FLAG_WON_JUNIOR_DOUBLES_RANK_1 equ 66 ; wGameFlags byte $08 bit 2
def FLAG_WON_SENIOR_DOUBLES_RANK_3 equ 68 ; wGameFlags byte $08 bit 4
def FLAG_WON_SENIOR_DOUBLES_RANK_2 equ 69 ; wGameFlags byte $08 bit 5
def FLAG_WON_SENIOR_DOUBLES_RANK_1 equ 70 ; wGameFlags byte $08 bit 6

def FLAG_WON_VARSITY_DOUBLES_RANK_2 equ 72 ; wGameFlags byte $09 bit 0
def FLAG_ISLAND_SKY_SCENE_ACTIVE equ 79 ; wGameFlags byte $09 bit 7

def FLAG_WON_JUNIOR_SINGLES_RANK_4 equ 80 ; wGameFlags byte $0a bit 0
def FLAG_WON_JUNIOR_SINGLES_RANK_3 equ 81 ; wGameFlags byte $0a bit 1
def FLAG_WON_JUNIOR_SINGLES_RANK_2 equ 82 ; wGameFlags byte $0a bit 2
def FLAG_WON_JUNIOR_SINGLES_RANK_1 equ 83 ; wGameFlags byte $0a bit 3
def FLAG_WON_SENIOR_SINGLES_RANK_4 equ 84 ; wGameFlags byte $0a bit 4
def FLAG_WON_SENIOR_SINGLES_RANK_3 equ 85 ; wGameFlags byte $0a bit 5
def FLAG_WON_SENIOR_SINGLES_RANK_2 equ 86 ; wGameFlags byte $0a bit 6
def FLAG_WON_SENIOR_SINGLES_RANK_1 equ 87 ; wGameFlags byte $0a bit 7

def FLAG_WON_VARSITY_SINGLES_RANK_4 equ 88 ; wGameFlags byte $0b bit 0

def FLAG_HAVE_LARGE_RACKET equ 97 ; wGameFlags byte $0c bit 1
def FLAG_HAVE_SMALL_RACKET equ 98 ; wGameFlags byte $0c bit 2
def FLAG_HAVE_IRON_RACKET equ 99 ; wGameFlags byte $0c bit 3
def FLAG_HAVE_SILVER_RACKET equ 100 ; wGameFlags byte $0c bit 4
def FLAG_HAVE_GOLD_RACKET equ 101 ; wGameFlags byte $0c bit 5
def FLAG_HAVE_DRIVE_RACKET equ 102 ; wGameFlags byte $0c bit 6
def FLAG_HAVE_IRON_SHOES equ 103 ; wGameFlags byte $0c bit 7

def FLAG_HAVE_LIGHT_SHOES equ 104 ; wGameFlags byte $0d bit 0
def FLAG_ENDING_CREDITS_PENDING equ 109 ; wGameFlags byte $0d bit 5
def FLAG_ENDING_CREDITS_RUNNING equ 110 ; wGameFlags byte $0d bit 6
def FLAG_ACTORS_FROZEN equ 111 ; wGameFlags byte $0d bit 7

def FLAG_SENIOR_COURT_NPC03_TURNED equ 116 ; wGameFlags byte $0e bit 4
def FLAG_TOURNAMENT_NPC05_TALKED_SINGLES equ 118 ; wGameFlags byte $0e bit 6
def FLAG_TOURNAMENT_NPC05_TALKED_DOUBLES equ 119 ; wGameFlags byte $0e bit 7

def FLAG_COURT2_SPECTATORS_TALKED_SINGLES equ 120 ; wGameFlags byte $0f bit 0
def FLAG_COURT2_SPECTATORS_TALKED_DOUBLES equ 121 ; wGameFlags byte $0f bit 1
def FLAG_RESTAURANT_NPC08_MOVED equ 123 ; wGameFlags byte $0f bit 3
def FLAG_SENIOR_COURT_TILE01_TRIGGERED equ 124 ; wGameFlags byte $0f bit 4
def FLAG_PRACTICE_ROOM_SESSION_ACTIVE equ 125 ; wGameFlags byte $0f bit 5
def FLAG_REPAIR_COUNTER_GREETED equ 126 ; wGameFlags byte $0f bit 6
def FLAG_REPAIR_COUNTER_EQUIP_CHANGED equ 127 ; wGameFlags byte $0f bit 7

def FLAG_SWING_PRACTICE_KID_PLACED equ 128 ; wGameFlags byte $10 bit 0
def FLAG_JUNIOR_COURT_NPC0A_TALKED equ 130 ; wGameFlags byte $10 bit 2
def FLAG_AWARDS_CEREMONY_SEEN_SINGLES equ 131 ; wGameFlags byte $10 bit 3
def FLAG_AWARDS_CEREMONY_SEEN_DOUBLES equ 132 ; wGameFlags byte $10 bit 4

def FLAG_CHEAT_UNLOCK_0 equ 160 ; wGameFlags byte $14 bit 0
def FLAG_CHEAT_UNLOCK_1 equ 161 ; wGameFlags byte $14 bit 1
def FLAG_CHEAT_UNLOCK_2 equ 162 ; wGameFlags byte $14 bit 2
def FLAG_CHEAT_UNLOCK_3 equ 163 ; wGameFlags byte $14 bit 3
def FLAG_CHEAT_UNLOCK_4 equ 164 ; wGameFlags byte $14 bit 4
def FLAG_CHEAT_UNLOCK_5 equ 165 ; wGameFlags byte $14 bit 5
def FLAG_CHEAT_UNLOCK_6 equ 166 ; wGameFlags byte $14 bit 6
def FLAG_CHEAT_UNLOCK_7 equ 167 ; wGameFlags byte $14 bit 7

def FLAG_CHEAT_UNLOCK_8 equ 168 ; wGameFlags byte $15 bit 0
def FLAG_CHEAT_UNLOCK_11 equ 169 ; wGameFlags byte $15 bit 1
def FLAG_CHEAT_UNLOCK_12 equ 170 ; wGameFlags byte $15 bit 2
def FLAG_CHEAT_UNLOCK_9 equ 171 ; wGameFlags byte $15 bit 3
def FLAG_CHEAT_UNLOCK_10 equ 172 ; wGameFlags byte $15 bit 4
def FLAG_REACHED_ISLAND_OPEN_SINGLES equ 174 ; wGameFlags byte $15 bit 6
def FLAG_REACHED_ISLAND_OPEN_DOUBLES equ 175 ; wGameFlags byte $15 bit 7

def FLAG_STORY_COMPLETE_SINGLES equ 176 ; wGameFlags byte $16 bit 0
def FLAG_STORY_COMPLETE_DOUBLES equ 177 ; wGameFlags byte $16 bit 1
def FLAG_REACHED_MARIO_WORLD_SINGLES equ 178 ; wGameFlags byte $16 bit 2
def FLAG_REACHED_MARIO_WORLD_DOUBLES equ 179 ; wGameFlags byte $16 bit 3
def FLAG_ENDING_SEEN_SINGLES equ 183 ; wGameFlags byte $16 bit 7

def FLAG_ENDING_SEEN_DOUBLES equ 184 ; wGameFlags byte $17 bit 0
def FLAG_ISLAND_OPEN_IN_PROGRESS equ 185 ; wGameFlags byte $17 bit 1
def FLAG_SERVE_CHALLENGER_DEFEATED equ 186 ; wGameFlags byte $17 bit 2
def FLAG_NET_CHALLENGER_DEFEATED equ 187 ; wGameFlags byte $17 bit 3
def FLAG_STROKE_CHALLENGER_DEFEATED equ 188 ; wGameFlags byte $17 bit 4
def FLAG_SERVE_COACH_GREETED equ 189 ; wGameFlags byte $17 bit 5
def FLAG_NET_COACH_GREETED equ 190 ; wGameFlags byte $17 bit 6
def FLAG_RETURN_COACH_GREETED equ 191 ; wGameFlags byte $17 bit 7

def FLAG_CLEARED_SERVICE_MATCH_1 equ 192 ; wGameFlags byte $18 bit 0
def FLAG_CLEARED_SERVICE_MATCH_2 equ 193 ; wGameFlags byte $18 bit 1
def FLAG_CLEARED_SERVICE_MATCH_3 equ 194 ; wGameFlags byte $18 bit 2
def FLAG_CLEARED_SERVICE_PRACTICE_1 equ 195 ; wGameFlags byte $18 bit 3
def FLAG_CLEARED_SERVICE_PRACTICE_2 equ 196 ; wGameFlags byte $18 bit 4
def FLAG_CLEARED_SERVICE_PRACTICE_3 equ 197 ; wGameFlags byte $18 bit 5
def FLAG_CLEARED_NET_GAME_MATCH_1 equ 198 ; wGameFlags byte $18 bit 6
def FLAG_CLEARED_NET_GAME_MATCH_2 equ 199 ; wGameFlags byte $18 bit 7

def FLAG_CLEARED_NET_GAME_MATCH_3 equ 200 ; wGameFlags byte $19 bit 0
def FLAG_CLEARED_NET_GAME_PRACTICE_1 equ 201 ; wGameFlags byte $19 bit 1
def FLAG_CLEARED_NET_GAME_PRACTICE_2 equ 202 ; wGameFlags byte $19 bit 2
def FLAG_CLEARED_NET_GAME_PRACTICE_3 equ 203 ; wGameFlags byte $19 bit 3
def FLAG_CLEARED_STROKE_MATCH_1 equ 204 ; wGameFlags byte $19 bit 4
def FLAG_CLEARED_STROKE_MATCH_2 equ 205 ; wGameFlags byte $19 bit 5
def FLAG_CLEARED_STROKE_MATCH_3 equ 206 ; wGameFlags byte $19 bit 6
def FLAG_CLEARED_STROKE_PRACTICE_1 equ 207 ; wGameFlags byte $19 bit 7

def FLAG_CLEARED_STROKE_PRACTICE_2 equ 208 ; wGameFlags byte $1a bit 0
def FLAG_CLEARED_STROKE_PRACTICE_3 equ 209 ; wGameFlags byte $1a bit 1
def FLAG_CLEARED_MACHINE_LEVEL_1 equ 210 ; wGameFlags byte $1a bit 2
def FLAG_CLEARED_MACHINE_LEVEL_2 equ 211 ; wGameFlags byte $1a bit 3
def FLAG_CLEARED_MACHINE_LEVEL_3 equ 212 ; wGameFlags byte $1a bit 4
def FLAG_CLEARED_MACHINE_LEVEL_4 equ 213 ; wGameFlags byte $1a bit 5
def FLAG_CLEARED_WALL_LEVEL_1 equ 214 ; wGameFlags byte $1a bit 6
def FLAG_CLEARED_WALL_LEVEL_2 equ 215 ; wGameFlags byte $1a bit 7

def FLAG_CLEARED_WALL_LEVEL_3 equ 216 ; wGameFlags byte $1b bit 0
def FLAG_CLEARED_WALL_LEVEL_4 equ 217 ; wGameFlags byte $1b bit 1
def FLAG_CLEARED_MACHINE_MASTER equ 218 ; wGameFlags byte $1b bit 2
def FLAG_CLEARED_WALL_MASTER equ 219 ; wGameFlags byte $1b bit 3
def FLAG_CLEARED_MACHINE_EXPERT equ 220 ; wGameFlags byte $1b bit 4
def FLAG_CLEARED_WALL_EXPERT equ 221 ; wGameFlags byte $1b bit 5

def FLAG_TEMP_SCENE_VARIANT_A equ 224 ; wGameFlags byte $1c bit 0
def FLAG_TEMP_SCENE_VARIANT_B equ 225 ; wGameFlags byte $1c bit 1

def FLAG_TEMP_WIDE_GLYPH_STREAM equ 253 ; wGameFlags byte $1f bit 5
def FLAG_TEMP_PROGRESS_SCREEN_OPEN equ 254 ; wGameFlags byte $1f bit 6
def FLAG_TEMP_RESULTS_SCREEN_OPEN equ 255 ; wGameFlags byte $1f bit 7

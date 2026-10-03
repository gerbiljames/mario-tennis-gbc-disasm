; --- Notes (snd_note in a sound channel script: the low nibble of the note byte) ---
; Index into NotePeriodTable's twelve semitones; snd_tone_flag picks which
; of the table's two octaves, and the note's octave argument halves the
; period that many times.
def C_ equ 0
def C# equ 1
def D_ equ 2
def D# equ 3
def E_ equ 4
def F_ equ 5
def F# equ 6
def G_ equ 7
def G# equ 8
def A_ equ 9
def A# equ 10
def B_ equ 11

; --- Sound ids (a to PlaySound / PlaySoundManaged / `sound`) ---
; One 8-bit id space covers both music and sound effects, split at $50.
; PlaySound reads $3151 + (id - 1) * 2 for id < $50 and $31b5 +
; (id - $50 - 1) * 2 above: ids $01-$32 are the 50 entries of the first index
; table and $51-$c1 the 113 of the second. Each entry names a voice count and a
; row in bank ($70 | nibble)'s SoundTable_*; the first table's entries are 3-4
; voices on channels 2-5 (songs), the second's 1-2 voices on channels 0-1
; (effects). Id $00 stops the music (StopAllSound clears channels 2-5) and id
; $50 the effects (clears channels 0-1). Ids $33-$4f would index past the
; first table, but the `sound` macro's handler ($2fb3) claims $40-$4f as
; jingles first. That handler also latches every id below $40 into
; wCurrentBGM, so wCurrentBGM holds these BGM_* ids.
; Unused_01_RunSoundTest lists ids $00-$32 plus the five jingles on one axis,
; $50-$c1 on the other.

; Music. Selected by CourtSelectBgmIds_3e (court-select index -> wMatchBGM),
; the story_location records' BGM field, MinigameConfigTable's records (+5),
; DrillDefinitionPtrs' records, Singles/DoublesMatchSettingsTable_0a (+4) and
; SetPointSituationBgm.
def BGM_NONE                 equ $00 ; silence: stops the four music channels
def BGM_UNCHANGED            equ $ff ; story_location: keep whatever is playing (the location loop skips the start)
def BGM_INTRO                equ $01 ; RunIntroCutscene
def BGM_TITLE_SCREEN         equ $02 ; RunTitleScreen
def BGM_MENU                 equ $03 ; shared theme of ~20 menu screens (main menu, character/court/format select, save and N64 flows)
def BGM_STATUS_SCREEN        equ $04 ; character/minigame data, game progress, trophies, N64 record screens
def BGM_DICTIONARY           equ $05 ; TennisDictionaryScreen
def BGM_EXHIBITION_MATCH     equ $06 ; CourtSelectBgmIds_3e rows 0-3: the four standard courts
def BGM_EXHIBITION_MATCH_LINK equ $07 ; the same four rows of CourtSelectBgmIdsLink_3e (link play)
def BGM_MARIO_MINIGAME       equ $08 ; Special Court story_location + the minigame select/level menus
def BGM_WIN                  equ $09 ; match/point won (ShowMinigamePointResult, RunMatchWinLoseScreen)
def BGM_LOSE                 equ $0a ; the .lostPoint branch of the same two
def BGM_EXP_AWARD            equ $0b ; BeginNextExpAward
def BGM_EXP_DISTRIBUTION     equ $0c ; ShowExpDistributionScreen, TickLevelUpJingle
def BGM_STAT_DISTRIBUTION    equ $0d ; AnimateCharDataStatsReveal, SetupCharDataScreen
def BGM_TIEBREAK             equ $0e ; SetPointSituationBgm, wTiebreakerIndicator set
def BGM_SET_POINT            equ $0f ; same, wMatchPointFlag or wSetPointFlag set
def BGM_GAME_POINT           equ $10 ; same, wGamePointFlag set
def BGM_COURT_STAR           equ $11 ; CourtSelectBgmIds_3e row 4; also Boo Blast and InitDefaultMatchSettings
def BGM_COURT_CASTLE         equ $12 ; row 5; the Peach's Castle story_location and Perfect Shot use it
def BGM_COURT_TROPIC         equ $13 ; row 6; MinigameConfig_FruitFantasy
def BGM_COURT_WAREHOUSE      equ $14 ; row 8; MinigameConfig_TreasureBox
def BGM_TWO_ON_ONE           equ $15 ; RunDoublesDrillMatch
def BGM_COURT_JUNGLE         equ $16 ; row 7; MinigameConfig_BananaBunch
def BGM_TARGET_MINIGAMES     equ $19 ; the drill_defs of Medallion Match, Shooting Star and Target Shot
def BGM_ACADEMY_BUILDING     equ $1a ; story_location: the Academy Main Building and the Academy Wing
def BGM_ACADEMY_OUTDOORS     equ $1b ; story_location: the courtyards, entrances, class courts, Court #1/#2, the awards ceremony and the island flyover (13 locations)
def BGM_DORM_ROOM            equ $1c ; DormRoomInitScript_13 / DormRoomNpc03_13
def BGM_ACADEMY_ROOMS        equ $1d ; story_location: the restaurant, cafeteria, training rooms, the Center Court and the tournament (7 locations)
def BGM_TENNIS_MACHINE       equ $1e ; the Tennis Machine Room's drill_defs
def BGM_WALL_PRACTICE        equ $1f ; the Wall Practice Room's drill_defs
def BGM_PRACTICE_MATCH       equ $20 ; the story practice matches (GAMEMODE_PRACTICE_MATCH rows of the match settings tables)
def BGM_JUNIOR_RANKING       equ $21 ; the Junior class ranking matches (hard court)
def BGM_SENIOR_RANKING       equ $22 ; MatchSettingsTable records 6-9; reused by the intro character showcase and the trophy cheat screen
def BGM_VARSITY_RANKING      equ $23 ; the Varsity ranking matches (composition court)
def BGM_DRILL_MATCH          equ $24 ; the match drills' drill_def (COURT_TRAINING_MATCH)
def BGM_DRILL_PRACTICE       equ $25 ; the practice drills' drill_def (COURT_TRAINING_PRACTICE)
def BGM_ISLAND_OPEN          equ $26 ; the Island Open's early rounds
def BGM_ISLAND_OPEN_SEMIFINAL equ $27
def BGM_ISLAND_OPEN_FINAL    equ $28 ; on the Center Court
def BGM_DREAM_MATCH          equ $29 ; the Dream Matches on the castle court
def BGM_ISLAND_OPEN_LOSE     equ $2a ; ShowRankingBoard with wRankingBoardMode 2, which SetupRankingBoardArgs sets when wMatchWinLoseFlag != 1
def BGM_ISLAND_OPEN_WIN      equ $2b ; the same board with mode 1 (match won)
def BGM_CREDITS              equ $2c ; RunEndingCreditsSequence, the End1 story_location, and the debug text-overflow alarm
def BGM_THE_END              equ $2d ; the still screen after each credit scroll (PlayScreenSequence1/2)
def BGM_LEVEL_UP             equ $2f ; TickLevelUpJingle

; Jingles ($40-$45, PlaySoundManaged only). The handler stores the id in
; hActiveJingle, plays JingleSoundIds[id - $40] (a music id) and leaves
; ResumeBGMAfterJingle/WaitJingleEnd to restore wCurrentBGM when the music
; channels fall idle. Only one is used.
def JINGLE_LEVEL_CLEARED     equ $42 ; the LEVEL n CLEARED court banners (CourtBannerObjTemplates_09 rows 18-21)
def JINGLE_HIGH_SCORE        equ $43 ; the HIGH SCORE court banner (row 22)
def JINGLE_DONE_FOR_THE_DAY  equ $41 ; going to bed (DormRoomNpc03_13) and the save-slot debug editor

; Sound effects, named for the event they play for.
def SFX_STOP                 equ $50 ; silences the two effect channels
; The racket-contact sounds, one per shot type in ShotTypePresets_07
; (ApplyShotTypePresets plays the row's first byte at contact), named for the
; stroke family that uses each; the smash shares the slice sound.
def SFX_HIT_TOPSPIN          equ $51 ; topspin, power topspin, neutral and the reach strokes
def SFX_HIT_DROP             equ $52
def SFX_HIT_LOB              equ $53
def SFX_HIT_SERVE            equ $54 ; all three serves
def SFX_HIT_SLICE            equ $57 ; slice, power slice and the smash
def SFX_BALL_BOUNCE          equ $5b ; HandleBallBounceEvent
def SFX_SWING                equ $5c ; racket swing (StartCharSwing)
def SFX_BALL_CONTACT         equ $77 ; the ball connecting with a scoring object: HandleBallTouchCharEvent, HandleMinigameTargetHit, MinigameTargetTypeScores
def SFX_MENU_MOVE            equ $5e ; every menu's "the cursor moved" branch
def SFX_MENU_SELECT          equ $5f ; A accepted, menu continues
def SFX_MENU_DECIDE          equ $60 ; A accepted the screen's final choice (fades out after it)
def SFX_MENU_LOCKED          equ $61 ; choice refused (IsCourtUnlocked returned 0, locked minigame level)
def SFX_MENU_CANCEL          equ $62 ; B pressed / selection retreated
def SFX_PAUSE_MENU           equ $63 ; RunMatchPauseMenu, RunStoryModeMenu
def SFX_IMPACT               equ $70 ; collision cue, always followed by SetScreenShake
def SFX_DOOR                 equ $71 ; gym, dorm and restaurant doors (open and close)
def SFX_COUNTDOWN            equ $74 ; each digit of PlayMinigameCountdown
def SFX_COUNTDOWN_GO         equ $75 ; the "GO" banner that ends it
def SFX_DOOR_ALT             equ $79 ; academy wing and principal's office doors
def SFX_PLANE                equ $7b ; the island-sky plane, retriggered every other frame
def SFX_SPLASH               equ $7e ; UpdateWaterSplash0/1_14
def SFX_FIREWORK             equ $81 ; UpdateFirework0/1_14 burst phase
def SFX_TWINKLE              equ $84 ; PlayTwinkleAnimation_14
def SFX_TIMER_TICK           equ $af ; one per second of the secondary countdown
def SFX_TIMER_UP             equ $b0 ; that countdown reaching zero
; A seven-step ladder indexed by wMinigameHitStreak (the three *HitStreakSounds
; tables in bank $0d); Treasure Box takes every other step.
def SFX_SCORE_STEP1          equ $c0
def SFX_SCORE_STEP2          equ $bf
def SFX_SCORE_STEP3          equ $be
def SFX_SCORE_STEP4          equ $bd
def SFX_SCORE_STEP5          equ $bc
def SFX_SCORE_STEP6          equ $bb
def SFX_SCORE_STEP7          equ $ba

; Effects named for where they play, not what they sound like.
def SFX_SPECIAL_HIT            equ $55 ; the special-shot hit spark (StartHitEffect $08)
def SFX_SWING_CHARGE           equ $59 ; a character starting a swing windup (CharSwingWindupPhase $08)
def SFX_NET_CORD               equ $5a ; the ball clipping the net (HandleBallNetCrossing $08)
; The on-court object cues, from the *ObjTemplate* tables of bank $09 (the
; sound field LoadObjTemplate_09 plays as the object appears).
def SFX_SCORE_DISPLAY          equ $66 ; the point-score digit objects appearing (ObjTemplates_09, the game-score display)
def SFX_BANNER_WINNER          equ $67 ; the SERVICE/RETURN/SMASH ACE, LOB and DROP SHOT banners (rows 24-28)
def SFX_BANNER_POINT_SITUATION equ $68 ; the BREAK/GAME/SET/MATCH POINT banners (rows 7-10)
def SFX_BANNER_FAULT           equ $6a ; the FAULT and DOUBLE FAULT banners (rows 1-2)
def SFX_BANNER_GAME_WON        equ $6b ; the GAME, SET MATCH and MATCH banners (rows 11-13)
def SFX_BANNER_CALL            equ $6c ; the LET, NET, OUT and START banners (rows 3-6)
def SFX_LOGO_JINGLE            equ $65 ; the intro logo screen, and TriggerCheatUnlock
def SFX_DEUCE                  equ $69 ; the deuce call after a point (DelayAfterPointResolution $08)
def SFX_LANDING_MARKER         equ $6d ; the landing marker appearing (StartLandingMarker $08)
def SFX_DEBUG_ALARM            equ $6f ; QueueVRAMCopy on queue overflow, debug step mode only
def SFX_BEEP                   equ $72 ; link-input decode errors (SerialEncode/DecodeInput), the debug window demo
def SFX_CAPTION                equ $73 ; an EXP-screen caption appearing (Unused_1a_DrawExpScreenCaption $1a)
def SFX_BALL_LAUNCH            equ $76 ; the minigame ball launcher (LaunchBall $0d)
def SFX_MARKER                 equ $78 ; a marker landing: the ranking-board marker (RankingBoardAnimate*), the on-court score digits and banner row 15 (CourtBannerObjTemplates_09)
def SFX_FIREWORK_LAUNCH        equ $7a ; the island sky scene: firework ascent, the plane pass (bank $14)
def SFX_FIREWORK_SPARKLE       equ $7d ; the island sky scene: twinkle and plane cues (bank $14)
def SFX_RANKING_BOARD          equ $7f ; the ranking board opening (ShowRankingBoard $1b, unless wRankingBoardSilent)
def SFX_RANKING_HIGHLIGHT      equ $80 ; a ranking row highlighted (RankingBoardAnimState_* $1b)
def SFX_STOMP                  equ $83 ; the cutscene stomp with screen shake (CutsceneStompScreenShake $0f)
def SFX_THUD                   equ $86 ; a minigame hit scored (ScoreBallHit $0d) and a Mario World NPC landing from a jump
def SFX_VOICE_YOSHI            equ $87 ; Yoshi speaking in Mario World (MarioWorldNpc09Yoshi_0e)
def SFX_PEACH_FANFARE          equ $88 ; before "Princess Peach!" in Mario World (MarioWorldNpc0C_0e)
def SFX_VOICE_BABY_MARIO       equ $89 ; Baby Mario speaking in Mario World (MarioWorldNpc0ABabyMario_0e)
def SFX_WATER_SPRITE_MAGIC     equ $8a ; the water sprite's palette flash (WaterSpriteRacketRewardScene $15)
def SFX_CONTEST_WIN            equ $8c ; winning the water-sprite swing contest (WaterSpriteSwingContestScene $15)
def SFX_CONTEST_FINISH         equ $8d ; the swing contest ending (WaterSpriteSwingContestScene $15)
def SFX_WATER_SPRITE_APPEAR    equ $8e ; the water sprite appearing after the fade (WaterSpriteRacketRewardScene $15)
def SFX_WATER_SPRITE_FLY       equ $8f ; the water sprite flying off (WaterSpriteRacketRewardScene $15)
def SFX_RACKET_GET             equ $90 ; receiving the water sprite's racket (WaterSpriteRacketRewardScene $15)
def SFX_GRID_CLEAR             equ $94 ; the target grid clearing (AnimateTargetGridClear $0d)
def SFX_APPEAR2                equ $96 ; the second of the two pop sounds cutscenes alternate as actors are placed one by one (arrivals, match returns, academy init)
def SFX_CHIME                  equ $97 ; a minigame target hit / score popup, and a success cue in cutscenes
def SFX_EMOTE                  equ $98 ; an emote actor placed after a line, held $78 frames (academy greeting, crash, coach intro cutscenes)
def SFX_APPEAR1                equ $99 ; the first of the two pop sounds cutscenes alternate as actors are placed one by one; also after a stomp
def SFX_OPTION_TOGGLE          equ $9b ; a music/sound option toggled (Unused_1a_MusicSettingHandler0/1 $1a)
def SFX_STORY_CUE              equ $a2 ; the MapScriptPlaySoundA2 handler every story bank carries

; --- Sound channel type (wSndChannelType) ---
; `hSndChannelType & 3`, latched by RunSoundChannelScript with
; `wSndRegBase = type * 5` (the stride of the four sound-register blocks), so
; the type is the hardware channel. The wave channel loads wave RAM and skips
; duty, volume slide and instrument envelope; the noise channel sends the note
; through NoiseNoteTable and skips vibrato.
def SNDCHANTYPE_SQUARE1      equ $00 ; $ff10 block -- the only one with a sweep unit (NR10)
def SNDCHANTYPE_SQUARE2      equ $01 ; $ff15 block; takes every default path
def SNDCHANTYPE_WAVE         equ $02 ; $ff1a block
def SNDCHANTYPE_NOISE        equ $03 ; $ff1f block

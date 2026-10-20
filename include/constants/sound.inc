; --- Notes (snd_note in a sound channel script: the low nibble of the note byte) ---
; Index into NotePeriodTable's twelve semitones; snd_quarter_tone picks the
; table's second half, the same twelve a quarter tone higher, and the note's
; octave argument halves the period that many times.
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
; (effects). Id $00 stops the music (StopMusic clears channels 2-5) and id
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
	const_def $01
	const BGM_INTRO                 ; $01 RunIntroCutscene
	const BGM_TITLE_SCREEN          ; $02 RunTitleScreen
	const BGM_MENU                  ; $03 shared theme of ~20 menu screens (main menu, character/court/format select, save and N64 flows)
	const BGM_STATUS_SCREEN         ; $04 character/minigame data, game progress, trophies, N64 record screens
	const BGM_DICTIONARY            ; $05 TennisDictionaryScreen
	const BGM_EXHIBITION_MATCH      ; $06 CourtSelectBgmIds_3e rows 0-3: the four standard courts
	const BGM_EXHIBITION_MATCH_LINK ; $07 the same four rows of CourtSelectBgmIdsLink_3e (link play)
	const BGM_MARIO_MINIGAME        ; $08 Special Court story_location + the minigame select/level menus
	const BGM_WIN                   ; $09 match/point won (ShowMinigamePointResult, RunMatchWinLoseScreen)
	const BGM_LOSE                  ; $0a the .lostPoint branch of the same two
	const BGM_EXP_AWARD             ; $0b BeginNextExpAward
	const BGM_EXP_DISTRIBUTION      ; $0c ShowExpDistributionScreen, TickLevelUpJingle
	const BGM_STAT_DISTRIBUTION     ; $0d AnimateCharDataStatsReveal, SetupCharDataScreen
	const BGM_TIEBREAK              ; $0e SetPointSituationBgm, wTiebreakerIndicator set
	const BGM_SET_POINT             ; $0f same, wMatchPointFlag or wSetPointFlag set
	const BGM_GAME_POINT            ; $10 same, wGamePointFlag set
	const BGM_COURT_STAR            ; $11 CourtSelectBgmIds_3e row 4; also Boo Blast and InitDefaultMatchSettings
	const BGM_COURT_CASTLE          ; $12 row 5; the Peach's Castle story_location and Perfect Shot use it
	const BGM_COURT_TROPIC          ; $13 row 6; MinigameConfig_FruitFantasy
	const BGM_COURT_WAREHOUSE       ; $14 row 8; MinigameConfig_TreasureBox
	const BGM_TWO_ON_ONE            ; $15 RunDoublesDrillMatch
	const BGM_COURT_JUNGLE          ; $16 row 7; MinigameConfig_BananaBunch
	const_def $19
	const BGM_TARGET_MINIGAMES      ; $19 the drill_defs of Medallion Match, Shooting Star and Target Shot
	const BGM_ACADEMY_BUILDING      ; $1a story_location: the Academy Main Building and the Academy Wing
	const BGM_ACADEMY_OUTDOORS      ; $1b story_location: the courtyards, entrances, class courts, Court #1/#2, the awards ceremony and the island flyover (13 locations)
	const BGM_DORM_ROOM             ; $1c DormRoomInitScript_13 / DormRoomTourEndScene
	const BGM_ACADEMY_ROOMS         ; $1d story_location: the restaurant, cafeteria, training rooms, the Center Court and the tournament (7 locations)
	const BGM_TENNIS_MACHINE        ; $1e the Tennis Machine Room's drill_defs
	const BGM_WALL_PRACTICE         ; $1f the Wall Practice Room's drill_defs
	const BGM_PRACTICE_MATCH        ; $20 the story practice matches (GAMEMODE_PRACTICE_MATCH rows of the match settings tables)
	const BGM_JUNIOR_RANKING        ; $21 the Junior class ranking matches (hard court)
	const BGM_SENIOR_RANKING        ; $22 MatchSettingsTable records 6-9; reused by the trophy cheat screen and the unused placeholder screen (Unused_6d_ShowPlaceholderScreen)
	const BGM_VARSITY_RANKING       ; $23 the Varsity ranking matches (composition court)
	const BGM_DRILL_MATCH           ; $24 the match drills' drill_def (COURT_TRAINING_MATCH)
	const BGM_DRILL_PRACTICE        ; $25 the practice drills' drill_def (COURT_TRAINING_PRACTICE)
	const BGM_ISLAND_OPEN           ; $26 the Island Open's early rounds
	const BGM_ISLAND_OPEN_SEMIFINAL ; $27
	const BGM_ISLAND_OPEN_FINAL     ; $28 on the Center Court
	const BGM_DREAM_MATCH           ; $29 the Dream Matches on the castle court
	const BGM_ISLAND_OPEN_LOSE      ; $2a ShowRankingBoard with wRankingBoardMode 2, which SetupRankingBoardArgs sets when wMatchWinLoseFlag != 1
	const BGM_ISLAND_OPEN_WIN       ; $2b the same board with mode 1 (match won)
	const BGM_CREDITS               ; $2c RunEndingCreditsSequence, the End1 story_location, and the debug text-overflow alarm
	const BGM_THE_END               ; $2d the still screen after each credit scroll (PlayAwardsCeremonyScene, PlayDreamMatchEpilogueScene)
def BGM_LEVEL_UP             equ $2f ; TickLevelUpJingle

; Jingles ($40-$45), through the `sound` macro or PlaySoundManaged. The
; handler stores the id in hActiveJingle, plays JingleSoundIds[id - $40] (a
; music id) and leaves ResumeBGMAfterJingle/WaitJingleEnd to restore
; wCurrentBGM when the music channels fall idle. $40 maps to music $00.
def JINGLE_LEVEL_CLEARED     equ $42 ; the LEVEL n CLEARED court banners (CourtBannerObjTemplates_09 rows 18-21)
def JINGLE_HIGH_SCORE        equ $43 ; the HIGH SCORE court banner (row 22)
def JINGLE_DONE_FOR_THE_DAY  equ $41 ; going to bed (DormRoomTourEndScene, DormRoomReturnFromEntranceScene) and the save-slot debug editor
def JINGLE_COURT_INTRO_EXHIBITION equ $44 ; PlayCourtIntro, exhibition matches
def JINGLE_COURT_INTRO       equ $45 ; PlayCourtIntro, story and minigame matches

; Sound effects, named for the event they play for.
def SFX_STOP                 equ $50 ; silences the two effect channels
; The racket-contact sounds, one per shot type in ShotTypePresets_07
; (ApplyShotTypePresets plays the row's first byte at contact), named for the
; stroke family that uses each; the smash shares the slice sound.
	const_def $51
	const SFX_HIT_TOPSPIN ; $51 topspin, power topspin, neutral and the reach strokes
	const SFX_HIT_DROP    ; $52
	const SFX_HIT_LOB     ; $53
	const SFX_HIT_SERVE   ; $54 all three serves
def SFX_HIT_SLICE            equ $57 ; slice, power slice and the smash
def SFX_BALL_BOUNCE          equ $5b ; HandleBallBounceEvent
def SFX_LEAP                 equ $5c ; a jump smash or dive starting (StartCharSwing)
def SFX_BALL_CONTACT         equ $77 ; the ball connecting with a scoring object: HandleBallTouchCharEvent, HandleMinigameTargetHit, MinigameTargetTypeScores
	const_def $5e
	const SFX_MENU_MOVE   ; $5e every menu's "the cursor moved" branch
	const SFX_MENU_SELECT ; $5f A accepted, menu continues
	const SFX_MENU_DECIDE ; $60 A accepted the screen's final choice (fades out after it)
	const SFX_MENU_LOCKED ; $61 choice refused (IsCourtUnlocked returned 0, locked minigame level)
	const SFX_MENU_CANCEL ; $62 B pressed / selection retreated
	const SFX_PAUSE_MENU  ; $63 RunMatchPauseMenu, RunStoryModeMenu
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
def SFX_SWING                  equ $59 ; every swing, as CharSwingWindupPhase calls StartCharSwing ($08)
def SFX_NET_CORD               equ $5a ; the ball clipping the net (HandleBallNetCrossing $08)
; The on-court object cues, from the *ObjTemplate* tables of bank $09 (the
; sound field LoadObjTemplate_09 plays as the object appears).
	const_def $66
	const SFX_SCORE_DISPLAY          ; $66 the point-score digit objects appearing (ObjTemplates_09, the game-score display)
	const SFX_BANNER_WINNER          ; $67 the SERVICE/RETURN/SMASH ACE, LOB and DROP SHOT banners (rows 24-28)
	const SFX_BANNER_POINT_SITUATION ; $68 the BREAK/GAME/SET/MATCH POINT banners (rows 7-10)
	const_def $6a
	const SFX_BANNER_FAULT    ; $6a the FAULT and DOUBLE FAULT banners (rows 1-2)
	const SFX_BANNER_GAME_WON ; $6b the GAME, SET MATCH and MATCH banners (rows 11-13)
	const SFX_BANNER_CALL     ; $6c the LET, NET, OUT and START banners (rows 3-6)
def SFX_LOGO_JINGLE            equ $65 ; the intro logo screen, and TriggerCheatUnlock
def SFX_DEUCE                  equ $69 ; the deuce call after a point (ShowPointScoreSequence $08)
def SFX_LANDING_MARKER         equ $6d ; the landing marker appearing (StartLandingMarker $08)
def SFX_DEBUG_ALARM            equ $6f ; QueueVRAMCopy on queue overflow, debug step mode only
def SFX_BEEP                   equ $72 ; link-input decode errors (SerialEncode/DecodeInput), the debug window demo
def SFX_CAPTION                equ $73 ; an EXP-screen caption appearing (Unused_1a_DrawExpScreenCaption $1a)
def SFX_BALL_LAUNCH            equ $76 ; the minigame ball launcher (LaunchBall $0d)
def SFX_MARKER                 equ $78 ; a marker landing: the ranking-board marker (RankingAnim*), the on-court score digits and banner row 15 (CourtBannerObjTemplates_09)
def SFX_PLANE_START            equ $7a ; the island-sky plane flight starting, after the fade-in (bank $14)
def SFX_PLANE_STOP             equ $7d ; the island-sky plane's last move ending, before the fade-out or touchdown roll (bank $14)
def SFX_RANKING_BOARD          equ $7f ; the ranking board opening (ShowRankingBoard $1b, unless wRankingBoardSilent)
def SFX_RANKING_HIGHLIGHT      equ $80 ; a ranking row highlighted (RankingBoardAnimState_* $1b)
def SFX_STOMP                  equ $83 ; the cutscene stomp with screen shake (CutsceneStompScreenShake $0f)
	const_def $86
	const SFX_VOICE_BOO          ; $86 Boo speaking in Mario World (MarioWorldNpc0DBoo_0e, the welcome cutscene) and a Boo Blast hit (ScoreBallHit $0d)
	const SFX_VOICE_YOSHI        ; $87 Yoshi speaking in Mario World (MarioWorldNpc09Yoshi_0e)
	const SFX_VOICE_DK           ; $88 Donkey Kong speaking in Mario World (MarioWorldNpc0CDonkeyKong_0e)
	const SFX_VOICE_BABY_MARIO   ; $89 Baby Mario speaking in Mario World (MarioWorldNpc0ABabyMario_0e)
	const SFX_WATER_SPRITE_MAGIC ; $8a the water sprite's palette flash (WaterSpriteRacketRewardScene $15)
	const_def $8c
	const SFX_CONTEST_COUNTDOWN   ; $8c each beep of the swing contest's 3-2-1 countdown (WaterSpriteSwingContestScene $15)
	const SFX_CONTEST_FINISH      ; $8d the swing contest ending (WaterSpriteSwingContestScene $15)
	const SFX_WATER_SPRITE_APPEAR ; $8e the water sprite appearing after the fade (WaterSpriteRacketRewardScene $15)
	const SFX_WATER_SPRITE_FLY    ; $8f the water sprite flying off (WaterSpriteRacketRewardScene $15)
	const SFX_RACKET_GET          ; $90 receiving the water sprite's racket (WaterSpriteRacketRewardScene $15)
	const SFX_SWING_THROUGH       ; $91 the player trying out a newly equipped racket at the repair counter (ActorScript_0e_03)
	const SFX_SIDESTEP            ; $92 each sidestep of the player trying out newly equipped shoes there (ActorScript_0e_04)
def SFX_GRID_CLEAR             equ $94 ; the target grid clearing (AnimateTargetGridClear $0d)
	const_def $96
	const SFX_APPEAR2 ; $96 the second of the two pop sounds cutscenes alternate as actors are placed one by one (arrivals, match returns, academy init)
	const SFX_CHIME   ; $97 a minigame target hit / score popup, and a success cue in cutscenes
	const SFX_EMOTE   ; $98 an emote actor placed after a line, held $78 frames (academy greeting, crash, coach intro cutscenes)
	const SFX_APPEAR1 ; $99 the first of the two pop sounds cutscenes alternate as actors are placed one by one; also after a stomp
def SFX_OPTION_TOGGLE          equ $9b ; a music/sound option toggled (Unused_1a_MusicSettingHandler0/1 $1a)
def SFX_STORY_CUE              equ $a2 ; only the Unused_<bank>_MapScriptPlayStoryCue copies play it

; --- Music flags (hMusicFlags) ---
def MUSICB_MUTED equ 0 ; PlaySoundCmd drops BGM and jingle requests
def MUSICF_MUTED equ 1 << MUSICB_MUTED

; --- Sound options (wSoundOptionBits) ---
; Unused_00_SyncMusicMuteOption copies bit 0 into MUSICB_MUTED.
def SOUNDOPTB_MUSIC_OFF equ 0
def SOUNDOPTF_MUSIC_OFF equ 1 << SOUNDOPTB_MUSIC_OFF

; --- Sound channel type (wSndChannelType) ---
; `hSndChannelType & 3` (snd_channel's second operand), latched by
; UpdateSoundChannels with `wSndRegBase = type * 5` (the stride of the four
; sound-register blocks), so the type is the hardware channel. The wave
; channel loads wave RAM and skips duty, volume slide and instrument envelope;
; the noise channel sends the note through NoiseNoteTable and skips vibrato.
	const_def
	const SNDCHANTYPE_SQUARE1 ; $00 $ff10 block -- the only one with a sweep unit (NR10)
	const SNDCHANTYPE_SQUARE2 ; $01 $ff15 block; takes every default path
	const SNDCHANTYPE_WAVE    ; $02 $ff1a block
	const SNDCHANTYPE_NOISE   ; $03 $ff1f block

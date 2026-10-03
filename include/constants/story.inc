; --- Story locations (wStoryModeCurrentLocation, wStoryReturnLocation) ---
; A location id indexes StoryLocationTable_0a, 42 six-byte records ($00-$29).
; Its name popup (LoadStoryLocationHeader, DrawStoryResultsHeader) is text id
; $0179 + id (string bank $30 index 377 + id); the names below are those
; strings. Ids $0b/$0c share "Junior Class Court" (singles and doubles maps).
; Ids $1e-$29 are the ending cutscene's re-dressed locations and keep the
; strings' scene numbers. Ids $01-$04 are development leftovers; only $03 is
; still reached, by bank $01's debug menu.
def STORYLOC_MAIN_MENU                  equ $00 ; no location loaded (title/main menu)
def STORYLOC_DEVELOPMENT                equ $01 ; "Development"
def STORYLOC_SMALL_CHAR_TEST            equ $02 ; "Small Char. Test"
def STORYLOC_TEST                       equ $03 ; "Test" (bank $01's debug map)
def STORYLOC_TEST_2                     equ $04 ; "Test 2"
def STORYLOC_ACADEMY_MAIN_BLDG          equ $05 ; "Academy Main Bldg."
def STORYLOC_ACADEMY_WING               equ $06 ; "Academy Wing"
def STORYLOC_COURTYARD                  equ $07 ; "Courtyard"
def STORYLOC_RESTAURANT_PLAZA           equ $08 ; "Restaurant Plaza"
def STORYLOC_DORM_ENTRANCE              equ $09 ; "Dorm Entrance"
def STORYLOC_DORM_ROOM                  equ $0a ; "Dorm Room" (the story return point)
def STORYLOC_JUNIOR_CLASS_COURT_SINGLES equ $0b ; "Junior Class Court", singles map
def STORYLOC_JUNIOR_CLASS_COURT_DOUBLES equ $0c ; "Junior Class Court", doubles map
def STORYLOC_RESTAURANT                 equ $0d ; "Restaurant"
def STORYLOC_CAFETERIA                  equ $0e ; "Cafeteria"
def STORYLOC_TRAINING_COURT             equ $0f ; "Training Court"
def STORYLOC_SENIOR_CLASS_COURT         equ $10 ; "Senior Class Court"
def STORYLOC_TRAINING_CENTER            equ $11 ; "Training Center"
def STORYLOC_TENNIS_MACHINE_ROOM        equ $12 ; "Tennis Machine Room"
def STORYLOC_WALL_PRACTICE_ROOM         equ $13 ; "Wall Practice Room"
def STORYLOC_ACADEMY_ENTRANCE           equ $14 ; "Academy Entrance"
def STORYLOC_TOURNAMENT_COURTYARD       equ $15 ; "Tournament Courtyard"
def STORYLOC_COURT_1                    equ $16 ; "Court #1"
def STORYLOC_COURT_2                    equ $17 ; "Court #2"
def STORYLOC_CENTER_COURT               equ $18 ; "Center Court"
def STORYLOC_TOURNAMENT                 equ $19 ; "Tournament" (Island Open bracket screen)
def STORYLOC_AWARDS_CEREMONY            equ $1a ; "Awards Ceremony"
def STORYLOC_ISLAND_SKY                 equ $1b ; "Island Sky" (the plane cutscene)
def STORYLOC_SPECIAL_COURT              equ $1c ; "Special Court"
def STORYLOC_PEACHS_CASTLE              equ $1d ; "Peach's Castle"
def STORYLOC_END1_MAIN_BLDG             equ $1e ; "End1 Main Bldg"
def STORYLOC_END_RESTAURANT_ENT         equ $1f ; "End Restaurant Ent." (unnumbered)
def STORYLOC_END3_DORM_ENT              equ $20 ; "End3 Dorm Ent."
def STORYLOC_END4_JR_COURT              equ $21 ; "End4 Jr. Court"
def STORYLOC_END5_SERVICE_ACE           equ $22 ; "End5 Service Ace"
def STORYLOC_END7_TRAINING_CTR          equ $23 ; "End7 Training Ctr."
def STORYLOC_END8_SR_COURT              equ $24 ; "End8 Sr. Court"
def STORYLOC_END10_VARSITY_COURT        equ $25 ; "End10 Varsity Court"
def STORYLOC_END11_TRAINING_COURT       equ $26 ; "End11 Training Court"
def STORYLOC_END12_PRINCIPALS_OFFICE    equ $27 ; "End12 Principal's Office"
def STORYLOC_END16_BEFORE_FINALS        equ $28 ; "End16 Before Finals"
def STORYLOC_END17_AWARD_CEREMONY       equ $29 ; "End17 Award Ceremony"

; --- Story save slot (wCurrentStorySlot) ---
; Slots 0-2 are the three story files; the byte doubles as an index into
; StorySlotBlockIds_03 (a slot saves as block 2N, backup at +$1b), so the real
; ids stay numeric. Value 3 means "not a story file" -- exhibition, link,
; mini-game and the two debug screens set it, and StorySlotBlockIds_03[3] is
; the exhibition block. It equals the slot count, the bound in the same
; `cp $03` guard, so both names exist.
def STORYSLOT_NONE           equ $03 ; not a story file: set by exhibition, link, mini-game and debug setup, and mapped to the exhibition save block
def NUM_STORY_SLOTS          equ $03 ; the three story files, as a bound: `cp $03 / ret nc` in SaveStorySlot/CheckStorySlot, and the debug stats screen's page wrap

; --- Story entry point sentinel (wStoryModeEntryPoint) ---
; Entry point ids are location-scoped: each location's map_tree carries its
; own `map_entry` table (8-byte records keyed by their first byte), which
; LoadStoryEntryPointRecord searches, falling back to its first record. Only
; the sentinel is engine-wide.
def STORYENTRY_NONE          equ $ff ; no entry point: keep the saved position (LoadStoryEntryPointRecord returns early), suppress the location-name popup, and terminate a map_entry table

; --- Story progress rank (wMapSceneStage in the story locations) ---
; $c2b0-$c2bf is per-location scratch; this is the family nine locations
; share. ComputeRankingProgressIndex (and eight byte-identical copies) walks
; the ranking flags from the top down and stores 2 * tier + isDoubles, so the
; singles and doubles ladders interleave. Consumers are 10-entry text-id
; tables.
def STORYRANK_SINGLES_ACADEMY      equ $00 ; no junior title yet
def STORYRANK_DOUBLES_ACADEMY      equ $01
def STORYRANK_SINGLES_JUNIOR_CHAMP equ $02 ; FLAG_WON_JUNIOR_SINGLES_RANK_1
def STORYRANK_DOUBLES_JUNIOR_CHAMP equ $03
def STORYRANK_SINGLES_SENIOR_CHAMP equ $04 ; FLAG_WON_SENIOR_SINGLES_RANK_1
def STORYRANK_DOUBLES_SENIOR_CHAMP equ $05
def STORYRANK_SINGLES_ISLAND_OPEN  equ $06 ; FLAG_REACHED_ISLAND_OPEN_SINGLES
def STORYRANK_DOUBLES_ISLAND_OPEN  equ $07
def STORYRANK_SINGLES_COMPLETE     equ $08 ; FLAG_STORY_COMPLETE_SINGLES
def STORYRANK_DOUBLES_COMPLETE     equ $09

; --- Story tier (STORYRANK_* >> 1) ---
; STORYRANK_* with the singles/doubles bit shifted out (`sra a`): a
; format-independent tier. The Cafeteria and Restaurant init scripts store it
; in wMapSceneStage2; the Training Gym and Academy main building shift at each
; reader; ComputeTrainingCourtProgressIndex writes it directly.
def STORYTIER_ACADEMY        equ $00
def STORYTIER_JUNIOR_CHAMP   equ $01
def STORYTIER_SENIOR_CHAMP   equ $02
def STORYTIER_ISLAND_OPEN    equ $03
def STORYTIER_COMPLETE       equ $04

; --- Senior Class Court stage (wMapSceneStage2 in bank $12) ---
; Written by ComputeSeniorCourtStage. StartSeniorRankingMatch does `sub $02`
; into a seven-entry jumptable, one slot per senior ranking match (four
; singles, three doubles); SeniorCourtExit01_12 does `sub $09` before indexing
; its text-id table. The names say which opponent is next.
def SENIORCOURTSTAGE_SINGLES_PRE_JUNIOR   equ $00 ; not junior champion yet
def SENIORCOURTSTAGE_DOUBLES_PRE_JUNIOR   equ $01
def SENIORCOURTSTAGE_SINGLES_RANK4        equ $02 ; jumptable slot 0
def SENIORCOURTSTAGE_SINGLES_RANK3        equ $03
def SENIORCOURTSTAGE_SINGLES_RANK2        equ $04
def SENIORCOURTSTAGE_SINGLES_RANK1        equ $05
def SENIORCOURTSTAGE_DOUBLES_RANK3        equ $06 ; doubles has three ranking matches
def SENIORCOURTSTAGE_DOUBLES_RANK2        equ $07
def SENIORCOURTSTAGE_DOUBLES_RANK1        equ $08 ; last jumptable slot
def SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP equ $09 ; base of SeniorCourtExit01TextIds
def SENIORCOURTSTAGE_DOUBLES_SENIOR_CHAMP equ $0a
def SENIORCOURTSTAGE_SINGLES_ISLAND_OPEN  equ $0b
def SENIORCOURTSTAGE_DOUBLES_ISLAND_OPEN  equ $0c
def SENIORCOURTSTAGE_SINGLES_COMPLETE     equ $0d
def SENIORCOURTSTAGE_DOUBLES_COMPLETE     equ $0e

; --- Wall Practice stage (wMapSceneStage in the Wall Practice Room) ---
; SetupWallPracticeLevelSigns is the only writer: it walks the
; FLAG_CLEARED_WALL_* flags upward, drawing one cleared-level sign per step, so
; the value names the next challenge. Readers: WallPracticeRoomNpc05/Npc07,
; WallPracticeLevelResultScript, WallPracticeRoomInitScript_12.
def WALLPRACTICESTAGE_LEVEL1   equ $00 ; level 1 not cleared yet
def WALLPRACTICESTAGE_LEVEL2   equ $01 ; FLAG_CLEARED_WALL_LEVEL_1
def WALLPRACTICESTAGE_LEVEL3   equ $02
def WALLPRACTICESTAGE_LEVEL4   equ $03
def WALLPRACTICESTAGE_MASTER   equ $04 ; all four levels cleared; the score-attack Master level is next
def WALLPRACTICESTAGE_EXPERT   equ $05 ; FLAG_CLEARED_WALL_MASTER; Npc07 shows the record
def WALLPRACTICESTAGE_COMPLETE equ $06 ; FLAG_CLEARED_WALL_EXPERT

; --- Machine Court stage (wMapSceneStage in the Tennis Machine Room) ---
; ComputeMachineCourtProgress is the only writer, the machine-room twin of
; SetupWallPracticeLevelSigns; the value names the next challenge. Readers:
; TennisMachineRoomNpc04/Npc05, MachineCourtStartLevelScene.
def MACHINECOURTSTAGE_LEVEL1   equ $00 ; level 1 not cleared yet
def MACHINECOURTSTAGE_LEVEL2   equ $01 ; FLAG_CLEARED_MACHINE_LEVEL_1
def MACHINECOURTSTAGE_LEVEL3   equ $02
def MACHINECOURTSTAGE_LEVEL4   equ $03
def MACHINECOURTSTAGE_MASTER   equ $04 ; all four levels cleared; Master next
def MACHINECOURTSTAGE_EXPERT   equ $05 ; FLAG_CLEARED_MACHINE_MASTER; Npc05 shows the record
def MACHINECOURTSTAGE_COMPLETE equ $06 ; FLAG_CLEARED_MACHINE_EXPERT

; --- Island Open bracket position ---
; Both count the bracket flags that are set and name the match that comes
; next. ISLANDOPENSTAGE_* is Center Court's (bank $11), singles and doubles in
; one space; ISLANDOPENROUND_* is the tournament site's (bank $0f), where
; FLAG_DOUBLES already gives the format. Doubles has no second round.
def ISLANDOPENSTAGE_SINGLES_ROUND1    equ $00 ; no bracket flag set yet
def ISLANDOPENSTAGE_SINGLES_ROUND2    equ $01 ; FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1
def ISLANDOPENSTAGE_SINGLES_SEMIFINAL equ $02
def ISLANDOPENSTAGE_SINGLES_FINAL     equ $03
def ISLANDOPENSTAGE_DOUBLES_ROUND1    equ $04
def ISLANDOPENSTAGE_DOUBLES_SEMIFINAL equ $05
def ISLANDOPENSTAGE_DOUBLES_FINAL     equ $06
def ISLANDOPENROUND_ROUND1            equ $00
def ISLANDOPENROUND_ROUND2            equ $01 ; singles only -- doubles goes straight to the semi-final
def ISLANDOPENROUND_SEMIFINAL         equ $02
def ISLANDOPENROUND_FINAL             equ $03

; --- Academy Wing stage (wMapSceneStage in the Academy Wing) ---
; SetAcademyWingDialogueStage_10 is the only writer; it maps the singles and
; doubles flags to the same four values, starting at the senior title (unlike
; STORYTIER_*).
def ACADEMYWINGSTAGE_PRE_SENIOR_CHAMP equ $00 ; senior rank 1 not won yet
def ACADEMYWINGSTAGE_SENIOR_CHAMP     equ $01 ; FLAG_WON_{SINGLES,DOUBLES}_SENIOR_RANK_1
def ACADEMYWINGSTAGE_ISLAND_OPEN      equ $02 ; FLAG_REACHED_ISLAND_OPEN_*
def ACADEMYWINGSTAGE_COMPLETE         equ $03 ; FLAG_STORY_COMPLETE_*

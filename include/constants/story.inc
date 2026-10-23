; --- Story locations (wStoryModeCurrentLocation, wStoryReturnLocation) ---
; A location id indexes StoryLocationTable_0a, 42 six-byte records ($00-$29).
; Its name popup (LoadStoryLocationHeader, DrawStorySuspendedMatchHeader) is text id
; $0179 + id (string bank $30 index 377 + id); the names below are those
; strings. Ids $0b/$0c share "Junior Class Court" (singles and doubles maps).
; Ids $1e-$29 are the ending cutscene's re-dressed locations and keep the
; strings' scene numbers. Ids $01-$04 are development leftovers; only $03 is
; still reached, by bank $01's debug menu.
	const_def
	const STORYLOC_MAIN_MENU                  ; $00 no location loaded (title/main menu)
	const STORYLOC_DEVELOPMENT                ; $01 "Development"
	const STORYLOC_SMALL_CHAR_TEST            ; $02 "Small Char. Test"
	const STORYLOC_TEST                       ; $03 "Test" (bank $01's debug map)
	const STORYLOC_TEST_2                     ; $04 "Test 2"
	const STORYLOC_ACADEMY_MAIN_BLDG          ; $05 "Academy Main Bldg."
	const STORYLOC_ACADEMY_WING               ; $06 "Academy Wing"
	const STORYLOC_COURTYARD                  ; $07 "Courtyard"
	const STORYLOC_RESTAURANT_PLAZA           ; $08 "Restaurant Plaza"
	const STORYLOC_DORM_ENTRANCE              ; $09 "Dorm Entrance"
	const STORYLOC_DORM_ROOM                  ; $0a "Dorm Room" (the story return point)
	const STORYLOC_JUNIOR_CLASS_COURT_SINGLES ; $0b "Junior Class Court", singles map
	const STORYLOC_JUNIOR_CLASS_COURT_DOUBLES ; $0c "Junior Class Court", doubles map
	const STORYLOC_RESTAURANT                 ; $0d "Restaurant"
	const STORYLOC_CAFETERIA                  ; $0e "Cafeteria"
	const STORYLOC_TRAINING_COURT             ; $0f "Training Court"
	const STORYLOC_SENIOR_CLASS_COURT         ; $10 "Senior Class Court"
	const STORYLOC_TRAINING_CENTER            ; $11 "Training Center"
	const STORYLOC_TENNIS_MACHINE_ROOM        ; $12 "Tennis Machine Room"
	const STORYLOC_WALL_PRACTICE_ROOM         ; $13 "Wall Practice Room"
	const STORYLOC_ACADEMY_ENTRANCE           ; $14 "Academy Entrance"
	const STORYLOC_TOURNAMENT_COURTYARD       ; $15 "Tournament Courtyard"
	const STORYLOC_COURT_1                    ; $16 "Court #1"
	const STORYLOC_COURT_2                    ; $17 "Court #2"
	const STORYLOC_CENTER_COURT               ; $18 "Center Court"
	const STORYLOC_TOURNAMENT                 ; $19 "Tournament" (Island Open bracket screen)
	const STORYLOC_AWARDS_CEREMONY            ; $1a "Awards Ceremony"
	const STORYLOC_ISLAND_SKY                 ; $1b "Island Sky" (the plane cutscene)
	const STORYLOC_SPECIAL_COURT              ; $1c "Special Court"
	const STORYLOC_PEACHS_CASTLE              ; $1d "Peach's Castle"
	const STORYLOC_END1_MAIN_BLDG             ; $1e "End1 Main Bldg"
	const STORYLOC_END_RESTAURANT_ENT         ; $1f "End Restaurant Ent." (unnumbered)
	const STORYLOC_END3_DORM_ENT              ; $20 "End3 Dorm Ent."
	const STORYLOC_END4_JR_COURT              ; $21 "End4 Jr. Court"
	const STORYLOC_END5_SERVICE_ACE           ; $22 "End5 Service Ace"
	const STORYLOC_END7_TRAINING_CTR          ; $23 "End7 Training Ctr."
	const STORYLOC_END8_SR_COURT              ; $24 "End8 Sr. Court"
	const STORYLOC_END10_VARSITY_COURT        ; $25 "End10 Varsity Court"
	const STORYLOC_END11_TRAINING_COURT       ; $26 "End11 Training Court"
	const STORYLOC_END12_PRINCIPALS_OFFICE    ; $27 "End12 Principal's Office"
	const STORYLOC_END16_BEFORE_FINALS        ; $28 "End16 Before Finals"
	const STORYLOC_END17_AWARD_CEREMONY       ; $29 "End17 Award Ceremony"

; --- Story save slot (wCurrentStorySlot) ---
; Slots 0-2 are the three story files; the byte doubles as an index into
; StorySlotBlockIds_03 (a slot saves as block 2N, backup at +$1b), so the real
; ids stay numeric. Value 3 means "not a story file" -- exhibition, link,
; mini-game and the two debug screens set it, and StorySlotBlockIds_03[3] is
; the exhibition block. It equals the slot count, the bound in the same
; `cp $03` guard, so both names exist.
def STORYSLOT_NONE           equ $03 ; not a story file: set by exhibition, link, mini-game and debug setup, and mapped to the exhibition save block
def NUM_STORY_SLOTS          equ $03 ; the three story files, as a bound: `cp $03 / ret nc` in SaveStorySlot/ReadCurrentStorySlot, and the debug stats screen's page wrap

; --- Story entry point sentinel (wStoryModeEntryPoint) ---
; Entry point ids are location-scoped: each location's map_tree carries its
; own `map_entry` table (8-byte records keyed by their first byte), which
; LoadStoryEntryPointRecord searches, falling back to its first record. Only
; the sentinel is engine-wide; the ENTRY_<location>_* and EXIT_<location>_*
; names are defined by the map tables (include/macros/story_maps.inc).
def EXITTRIGGER_DIRECT       equ $ff ; wStoryModeExitTriggerRequest: matches no exit row (it ends the list), so the loop reloads wStoryModeCurrentLocation at wStoryModeEntryPoint as the caller set them
def STORYENTRY_NONE          equ $ff ; no entry point: keep the saved position (LoadStoryEntryPointRecord returns early), suppress the location-name popup, and terminate a map_entry table

; --- Story progress rank (wMapSceneStage in the story locations) ---
; $c2b0-$c2bf is per-location scratch; this is the family nine locations
; share. ComputeRankingProgressIndex (and eight byte-identical copies) walks
; the ranking flags from the top down and stores 2 * tier + isDoubles, so the
; singles and doubles ladders interleave. Consumers are 10-entry text-id
; tables.
	const_def
	const STORYRANK_SINGLES_ACADEMY      ; $00 no junior title yet
	const STORYRANK_DOUBLES_ACADEMY      ; $01
	const STORYRANK_SINGLES_JUNIOR_CHAMP ; $02 FLAG_WON_JUNIOR_SINGLES_RANK_1
	const STORYRANK_DOUBLES_JUNIOR_CHAMP ; $03
	const STORYRANK_SINGLES_SENIOR_CHAMP ; $04 FLAG_WON_SENIOR_SINGLES_RANK_1
	const STORYRANK_DOUBLES_SENIOR_CHAMP ; $05
	const STORYRANK_SINGLES_ISLAND_OPEN  ; $06 FLAG_REACHED_ISLAND_OPEN_SINGLES
	const STORYRANK_DOUBLES_ISLAND_OPEN  ; $07
	const STORYRANK_SINGLES_COMPLETE     ; $08 FLAG_STORY_COMPLETE_SINGLES
	const STORYRANK_DOUBLES_COMPLETE     ; $09
def NUM_STORYRANKS equ const_value

; --- Story tier (STORYRANK_* >> 1) ---
; STORYRANK_* with the singles/doubles bit shifted out (`sra a`): a
; format-independent tier. The Cafeteria and Restaurant init scripts store it
; in wMapSceneStage2; the Training Gym and Academy main building shift at each
; reader; ComputeStoryRankTier_15 writes it directly.
	const_def
	const STORYTIER_ACADEMY      ; $00
	const STORYTIER_JUNIOR_CHAMP ; $01
	const STORYTIER_SENIOR_CHAMP ; $02
	const STORYTIER_ISLAND_OPEN  ; $03
	const STORYTIER_COMPLETE     ; $04
def NUM_STORYTIERS equ const_value

; --- Senior Class Court stage (wMapSceneStage2 in bank $12) ---
; Written by ComputeSeniorCourtStage. StartSeniorRankingMatch does `sub $02`
; into a seven-entry jumptable, one slot per senior ranking match (four
; singles, three doubles); SpeakEmilyPostChampionLine does `sub $09` before
; indexing its text-id table. The names say which opponent is next.
	const_def
	const SENIORCOURTSTAGE_SINGLES_PRE_JUNIOR   ; $00 not junior champion yet
	const SENIORCOURTSTAGE_DOUBLES_PRE_JUNIOR   ; $01
	const SENIORCOURTSTAGE_SINGLES_RANK4        ; $02 jumptable slot 0
	const SENIORCOURTSTAGE_SINGLES_RANK3        ; $03
	const SENIORCOURTSTAGE_SINGLES_RANK2        ; $04
	const SENIORCOURTSTAGE_SINGLES_RANK1        ; $05
	const SENIORCOURTSTAGE_DOUBLES_RANK3        ; $06 doubles has three ranking matches
	const SENIORCOURTSTAGE_DOUBLES_RANK2        ; $07
	const SENIORCOURTSTAGE_DOUBLES_RANK1        ; $08
	const SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP ; $09 base of EmilyPostChampionTextIds
	const SENIORCOURTSTAGE_DOUBLES_SENIOR_CHAMP ; $0a last jumptable slot
	const SENIORCOURTSTAGE_SINGLES_ISLAND_OPEN  ; $0b
	const SENIORCOURTSTAGE_DOUBLES_ISLAND_OPEN  ; $0c
	const SENIORCOURTSTAGE_SINGLES_COMPLETE     ; $0d
	const SENIORCOURTSTAGE_DOUBLES_COMPLETE     ; $0e
def NUM_SENIORCOURTSTAGES equ const_value

; --- Wall Practice stage (wMapSceneStage in the Wall Practice Room) ---
; SetupWallPracticeLevelSigns is the only writer: it walks the
; FLAG_CLEARED_WALL_* flags upward, drawing one cleared-level sign per step, so
; the value names the next challenge. Readers: WallPracticeRoomNpc05/Npc07,
; WallPracticeLevelResultScript, WallPracticeRoomInitScript_12.
	const_def
	const WALLPRACTICESTAGE_LEVEL1   ; $00 level 1 not cleared yet
	const WALLPRACTICESTAGE_LEVEL2   ; $01 FLAG_CLEARED_WALL_LEVEL_1
	const WALLPRACTICESTAGE_LEVEL3   ; $02
	const WALLPRACTICESTAGE_LEVEL4   ; $03
	const WALLPRACTICESTAGE_MASTER   ; $04 all four levels cleared; the score-attack Master level is next
	const WALLPRACTICESTAGE_EXPERT   ; $05 FLAG_CLEARED_WALL_MASTER; Npc07 shows the record
	const WALLPRACTICESTAGE_COMPLETE ; $06 FLAG_CLEARED_WALL_EXPERT
def NUM_WALLPRACTICESTAGES equ const_value

; --- Machine Court stage (wMapSceneStage in the Tennis Machine Room) ---
; ComputeMachineCourtProgress is the only writer, the machine-room twin of
; SetupWallPracticeLevelSigns; the value names the next challenge. Readers:
; TennisMachineRoomNpc04/Npc05, MachineCourtStartLevelScene.
	const_def
	const MACHINECOURTSTAGE_LEVEL1   ; $00 level 1 not cleared yet
	const MACHINECOURTSTAGE_LEVEL2   ; $01 FLAG_CLEARED_MACHINE_LEVEL_1
	const MACHINECOURTSTAGE_LEVEL3   ; $02
	const MACHINECOURTSTAGE_LEVEL4   ; $03
	const MACHINECOURTSTAGE_MASTER   ; $04 all four levels cleared; Master next
	const MACHINECOURTSTAGE_EXPERT   ; $05 FLAG_CLEARED_MACHINE_MASTER; Npc05 shows the record
	const MACHINECOURTSTAGE_COMPLETE ; $06 FLAG_CLEARED_MACHINE_EXPERT
def NUM_MACHINECOURTSTAGES equ const_value

; --- Island Open bracket position ---
; Both count the bracket flags that are set and name the match that comes
; next. ISLANDOPENSTAGE_* is Center Court's (bank $11), singles and doubles in
; one space; ISLANDOPENROUND_* is the tournament site's (bank $0f), where
; FLAG_DOUBLES already gives the format. Doubles has no second round.
	const_def
	const ISLANDOPENSTAGE_SINGLES_ROUND1    ; $00 no bracket flag set yet
	const ISLANDOPENSTAGE_SINGLES_ROUND2    ; $01 FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1
	const ISLANDOPENSTAGE_SINGLES_SEMIFINAL ; $02
	const ISLANDOPENSTAGE_SINGLES_FINAL     ; $03
	const ISLANDOPENSTAGE_DOUBLES_ROUND1    ; $04
	const ISLANDOPENSTAGE_DOUBLES_SEMIFINAL ; $05
	const ISLANDOPENSTAGE_DOUBLES_FINAL     ; $06
def NUM_ISLANDOPENSTAGES equ const_value
	const_def
	const ISLANDOPENROUND_ROUND1    ; $00
	const ISLANDOPENROUND_ROUND2    ; $01 singles only -- doubles goes straight to the semi-final
	const ISLANDOPENROUND_SEMIFINAL ; $02
	const ISLANDOPENROUND_FINAL     ; $03

; --- Academy Wing stage (wMapSceneStage in the Academy Wing) ---
; SetAcademyWingDialogueStage_10 is the only writer; it maps the singles and
; doubles flags to the same four values, starting at the senior title (unlike
; STORYTIER_*).
	const_def
	const ACADEMYWINGSTAGE_PRE_SENIOR_CHAMP ; $00 senior rank 1 not won yet
	const ACADEMYWINGSTAGE_SENIOR_CHAMP     ; $01 FLAG_WON_{SINGLES,DOUBLES}_SENIOR_RANK_1
	const ACADEMYWINGSTAGE_ISLAND_OPEN      ; $02 FLAG_REACHED_ISLAND_OPEN_*
	const ACADEMYWINGSTAGE_COMPLETE         ; $03 FLAG_STORY_COMPLETE_*

; Game constants. Hand-maintained (not generated). Preincluded for every bank
; via the Makefile PRELUDE, alongside hardware.inc / macros.inc.

; --- VRAM bank in a copy destination ---
; QueueVRAMCopy takes its destination in de and carries the VRAM bank in bit 13
; of it: `bit 5, d` selects rVBK, and `res 5, d` recovers the real address. So a
; destination of $b800 means $9800 in VRAM bank 1, and the disassembly writes
; that as `$9800 + VRAM_BANK1` rather than hiding the bank inside a literal.
def VRAM_BANK1 equ $2000

; --- Absent cell in a table of tilemap addresses ---
; The character-select PlayerSlotBoxAddrs* tables hold one shadow-tilemap cell
; per player slot, and a layout that does not show a slot stores zero for it.
; Nothing checks the fetched address, so the zero is a placeholder the code
; relies on never selecting rather than a guard value -- which is exactly why
; it wants a name instead of a bare $0000.
def NO_BOX equ $0000

; --- Overworld actor slot stride ---
; wActors is 24 records of this size in WRAM bank $04. The engine walks them
; with `ld de, $0040 / add hl, de`, and SpawnActor turns an actor id into a
; slot with two `srl h / rra` pairs -- id * 64 -- so the stride is the one
; number that ties an actor id to an address.
def ACTOR_SIZE equ $40

; --- Joypad buttons (standard GB layout) ---
; The per-character input byte ($df1f, built by ReadCharPadInput) and the raw
; joypad shadow use the standard layout: buttons in the low nibble, d-pad in the
; high nibble. PADF_* are the bit masks; PADB_* the matching bit indices (for
; bit/set/res).
def PADF_A       equ $01
def PADF_B       equ $02
def PADF_SELECT  equ $04
def PADF_START   equ $08
def PADF_RIGHT   equ $10
def PADF_LEFT    equ $20
def PADF_UP      equ $40
def PADF_DOWN    equ $80
def PADB_A       equ 0
def PADB_B       equ 1
def PADB_SELECT  equ 2
def PADB_START   equ 3
def PADB_RIGHT   equ 4
def PADB_LEFT    equ 5
def PADB_UP      equ 6
def PADB_DOWN    equ 7

; --- Overworld actor facing (map_actor `facing`, map_entry `sprite`) ---
; The facing byte stored in an actor's state ($daXX). Its top 2 bits are a
; direction index (0-3); CheckTriggerFacingMask ($0a:$53bd) shifts them out and
; looks them up in a table -> PADF bit to test against a FACEMASK_* below. The
; byte doubles as the movement angle fed to as_move (0/64/128/192 on a 256-unit
; circle). These are the NPC/overworld facings, deliberately distinct from the
; PADF_* joypad masks even where the value coincides.
def FACE_RIGHT   equ $00
def FACE_DOWN    equ $40
def FACE_LEFT    equ $80
def FACE_UP      equ $c0

; --- Cutscene actor slots ---
; The actor an overworld/cutscene `script_*` command targets (index into the
; actor state array at $d000, stride $40). Slots are filled in a fixed order
; when a story location loads (InitLocationActors, $0a:$5485): the player and
; two paired system actors first, then the location's `map_actor` list in order
; (SpawnActor always takes the first free slot, so list entry i -> slot 3+i).
; Only the three reserved system slots have a stable name; the rest are
; scene-local (see the per-scene actor ids). ACTOR_PLAYER_SHADOW and
; ACTOR_PARTNER both run the $04:$41d1 follower script.
def ACTOR_PLAYER        equ $00 ; the main character sprite
def ACTOR_PLAYER_SHADOW equ $01 ; player's paired follower actor ($41d1)
def ACTOR_PARTNER       equ $02 ; companion/doubles partner (Func_04_4f10)

; --- Story-script facing mask (map_script `facing_mask`) ---
; The direction an actor must face for FindStoryScriptEntry ($0a:$53e4) to run
; the record. PADF-layout bits (matched against the facing->PADF table lookup);
; FACEMASK_ANY ($ff) matches every facing.
def FACEMASK_ANY   equ $ff
def FACEMASK_RIGHT equ $10
def FACEMASK_LEFT  equ $20
def FACEMASK_UP    equ $40
def FACEMASK_DOWN  equ $80

; --- Shot types (wCurrentShotType, $c4a0) ---
; Selected from the A/B button sequence by SelectRallyShotType /
; SelectServeShotType ($08:$707e/$706b), which index the button (df16) x
; second-button (df17) tables. Base strokes: A = topspin, B = slice,
; A->B = lob, B->A = drop, A+B = smash; doubling a button gives its "power"
; variant. When the ball is in smash range (df50 bit 4) the ground strokes are
; swapped for their "reach" variants ($06/$07/$08, dispatched to bank $2c's
; ProjectShotPlacement0-2). Serves mirror the ground strokes by first button:
; A -> topspin serve, B -> slice serve, A+B -> flat serve (SelectServeShotType).
def SHOTTYPE_TOPSPIN            equ $00 ; A
def SHOTTYPE_POWER_TOPSPIN      equ $01 ; A -> A
def SHOTTYPE_SLICE              equ $02 ; B
def SHOTTYPE_POWER_SLICE        equ $03 ; B -> B
def SHOTTYPE_NEUTRAL            equ $04 ; no valid button combo (table fallback)
def SHOTTYPE_REACH              equ $05 ; reach attempted, ball not in smash range
def SHOTTYPE_REACH_POWER_TOPSPIN equ $06 ; A -> A, ball smashable
def SHOTTYPE_REACH_POWER_SLICE equ $07 ; B -> B, ball smashable
def SHOTTYPE_REACH_BASIC       equ $08 ; A / B, ball smashable
def SHOTTYPE_SMASH             equ $09 ; A + B
def SHOTTYPE_LOB               equ $0a ; A -> B
def SHOTTYPE_DROP              equ $0b ; B -> A
def SHOTTYPE_SERVE_TOPSPIN     equ $0c ; serve, A
def SHOTTYPE_SERVE_SLICE       equ $0d ; serve, B
def SHOTTYPE_SERVE_FLAT        equ $0e ; serve, A+B

; --- Point outcome (wPointOutcome, $c4d8) — MATCH context ---
; ResolvePointOutcome ($08:$4df4) dispatches `rst Rst00` on wPointOutcome:
; 1-5 -> ShowCourtBanner(wPointOutcome) (banner id == the value), 6 -> the
; winner banner ShowCourtBanner(wPointWinnerShotType+$17), 7/8 -> text popups.
; So the low banner tileset ids equal these codes.
def POINTOUTCOME_FAULT          equ 1
def POINTOUTCOME_DOUBLE_FAULT   equ 2
def POINTOUTCOME_LET            equ 3
def POINTOUTCOME_NET            equ 4
def POINTOUTCOME_OUT            equ 5
def POINTOUTCOME_WINNER         equ 6

; --- Winning-shot type (wPointWinnerShotType, $c491) ---
; Set by the Record*Stat functions ($08:$5c5f+); the winner court banner is
; ShowCourtBanner(value + $17) -> banner ids 24-28. Confirmed in-game.
def POINTWINNER_SERVICE_ACE     equ 1
def POINTWINNER_RETURN_ACE      equ 2
def POINTWINNER_SMASH_ACE       equ 3
def POINTWINNER_LOB             equ 4
def POINTWINNER_DROP_SHOT       equ 5

; --- Match pause-menu item ids (MatchMenuDefs $06:$466f) ---
; GetMatchMenuItemId returns one of these; they index MatchMenuItemGfxPointers
; (the selected item's word art), MatchMenuItemRectPointers (its 3x2 label in
; the list) and the item caption at text id $013f + id (bank $30, 319+id).
; The names follow those captions; the comment gives the word art when it
; differs, and several ids deliberately share one graphic.
def MATCHMENUITEM_RULES              equ $00 ; "RULES"
def MATCHMENUITEM_CONTROLS           equ $01 ; "CONTROLS"
def MATCHMENUITEM_OPTIONS            equ $02 ; "OPTIONS"
def MATCHMENUITEM_SAVE               equ $03 ; "SAVE" (opens the save/quit menu)
def MATCHMENUITEM_CAMERA_MODE        equ $04 ; "CAMERA MODE"
def MATCHMENUITEM_MUSIC              equ $05 ; "MUSIC"
def MATCHMENUITEM_CAMERA_NORMAL      equ $06 ; "NORMAL"
def MATCHMENUITEM_CAMERA_PLAYER      equ $07 ; "PLAYER"
def MATCHMENUITEM_MUSIC_ON           equ $08 ; "ON"
def MATCHMENUITEM_MUSIC_OFF          equ $09 ; "OFF"
def MATCHMENUITEM_CANCEL             equ $0a ; "CANCEL"
def MATCHMENUITEM_SAVE_GAME          equ $0b ; "SAVE" (narrow; performs the save)
def MATCHMENUITEM_TO_MAIN_MENU       equ $0c ; "TO MAIN MENU"
def MATCHMENUITEM_TO_LEVEL_SELECT    equ $0d ; "TO LEVEL SELECT"
def MATCHMENUITEM_RETRY_MINIGAME     equ $0e ; "TRY AGAIN"
def MATCHMENUITEM_RETRY_PRACTICE     equ $0f ; "TRY AGAIN"
def MATCHMENUITEM_RETRY_MACHINE      equ $10 ; "TRY AGAIN"
def MATCHMENUITEM_RETRY_PRACTICE_ALT equ $11 ; "TRY AGAIN"
def MATCHMENUITEM_RETRY_GAME         equ $12 ; "TRY AGAIN"
def MATCHMENUITEM_QUIT_GAME          equ $13 ; "QUIT MATCH"
def MATCHMENUITEM_QUIT_MATCH         equ $14 ; "QUIT MINI-GAME"
def MATCHMENUITEM_QUIT_PRACTICE      equ $15 ; "QUIT MINI-GAME"
def MATCHMENUITEM_QUIT_MACHINE       equ $16 ; "QUIT MINI-GAME"
def MATCHMENUITEM_QUIT_PRACTICE_ALT  equ $17 ; "QUIT MINI-GAME"

; --- Story pause-menu item ids (StoryMenuDefs $06:$6ce0) ---
; Same shape for the story-mode pause menu: StoryMenuItemGfxPointers,
; StoryMenuItemRectPointers, caption at text id $0162 + id (bank $30, 354+id).
def STORYMENUITEM_STATUS        equ $00 ; "STATUS"
def STORYMENUITEM_CLEAR_STATUS  equ $01 ; "CLEAR STATUS" (game progress)
def STORYMENUITEM_OPTIONS       equ $02 ; "OPTIONS"
def STORYMENUITEM_SAVE          equ $03 ; "SAVE" (opens the save/quit menu)
def STORYMENUITEM_MESSAGES      equ $04 ; "MESSAGES"
def STORYMENUITEM_MUSIC         equ $05 ; "MUSIC"
def STORYMENUITEM_MSG_SLOW      equ $06 ; "SLOW"
def STORYMENUITEM_MSG_NORMAL    equ $07 ; "NORMAL"
def STORYMENUITEM_MSG_FAST      equ $08 ; "FAST"
def STORYMENUITEM_MUSIC_ON      equ $09 ; "ON"
def STORYMENUITEM_MUSIC_OFF     equ $0a ; "OFF"
def STORYMENUITEM_SAVE_GAME     equ $0b ; "SAVE" (narrow; performs the save)
def STORYMENUITEM_TO_MAIN_MENU  equ $0c ; "TO MAIN MENU"
def STORYMENUITEM_CANCEL        equ $0d ; "CANCEL" (continue game)
def STORYMENUITEM_CHAR_DATA     equ $0e ; "CHAR. DATA"
def STORYMENUITEM_ITEMS         equ $0f ; "ITEMS"

; --- Global save flags (SRAM $a040-$a05f, 256 bits) ---
; Test/Set/ClearSaveFlag (bank $03) take the id in de: high byte = array byte
; index, low byte = bit << 5, and the mask is $80 >> bit -- the same encoding
; the wGameFlags rst vectors use, but a different, *global* array (see
; docs/save_format.md). Flag number = byte * 8 + bit is quoted per line.
; Numbers 0-31 double as the character-unlock bits: CheckCharacterUnlocked
; ($18:$452a) tests flag number = character id, so the event that sets a bit
; and the character it unlocks are the same bit (ids 0-3 are always unlocked).

def SAVEFLAG_OPENING_SEEN                equ $0120 ; #9; set when the title/opening sequence finishes
def SAVEFLAG_UNLOCKED_FAY                equ $0140 ; #10 = char id $0a; granted by N64 transfer records
def SAVEFLAG_UNLOCKED_CURT               equ $0160 ; #11 = char id $0b; granted by N64 transfer records
def SAVEFLAG_UNLOCKED_MARK               equ $0180 ; #12 = char id $0c; granted by N64 transfer records
def SAVEFLAG_UNLOCKED_SEAN               equ $01a0 ; #13 = char id $0d; granted by N64 transfer records
def SAVEFLAG_UNLOCKED_SAMMI              equ $01c0 ; #14 = char id $0e; granted by the singles Dream Match
def SAVEFLAG_UNLOCKED_ELDEN              equ $01e0 ; #15 = char id $0f; granted by the doubles Dream Match
def SAVEFLAG_CLEARED_BOO_BLAST_1         equ $0280 ; #20 = char id $14, so clearing it unlocks Kevin
def SAVEFLAG_CLEARED_BOO_BLAST_2         equ $02a0 ; #21 = char id $15, so clearing it unlocks unused roster slot
def SAVEFLAG_CLEARED_BOO_BLAST_3         equ $02c0 ; #22 = char id $16, so clearing it unlocks unused roster slot
def SAVEFLAG_CLEARED_SHOOTING_STAR_1     equ $02e0 ; #23 = char id $17, so clearing it unlocks Luigi
def SAVEFLAG_CLEARED_SHOOTING_STAR_2     equ $0300 ; #24 = char id $18, so clearing it unlocks Donkey Kong
def SAVEFLAG_CLEARED_SHOOTING_STAR_3     equ $0320 ; #25 = char id $19, so clearing it unlocks Baby Mario
def SAVEFLAG_CLEARED_PERFECT_SHOT_1      equ $0340 ; #26 = char id $1a, so clearing it unlocks Mario
def SAVEFLAG_CLEARED_PERFECT_SHOT_2      equ $0360 ; #27 = char id $1b, so clearing it unlocks Waluigi
def SAVEFLAG_CLEARED_PERFECT_SHOT_3      equ $0380 ; #28 = char id $1c, so clearing it unlocks Yoshi
def SAVEFLAG_CLEARED_TARGET_SHOT_1       equ $03a0 ; #29 = char id $1d, so clearing it unlocks Bowser
def SAVEFLAG_CLEARED_TARGET_SHOT_2       equ $03c0 ; #30 = char id $1e, so clearing it unlocks Wario
def SAVEFLAG_CLEARED_TARGET_SHOT_3       equ $03e0 ; #31 = char id $1f, so clearing it unlocks Peach
def SAVEFLAG_STORY_SLOT0_A               equ $0400 ; #32; SetStorySlotFlagA, cleared when the slot is erased
def SAVEFLAG_STORY_SLOT1_A               equ $0420 ; #33; SetStorySlotFlagA, cleared when the slot is erased
def SAVEFLAG_STORY_SLOT2_A               equ $0440 ; #34; SetStorySlotFlagA, cleared when the slot is erased
def SAVEFLAG_STORY_SLOT0_B               equ $0480 ; #36; SetStorySlotFlagB, cleared when the slot is erased
def SAVEFLAG_STORY_SLOT1_B               equ $04a0 ; #37; SetStorySlotFlagB, cleared when the slot is erased
def SAVEFLAG_STORY_SLOT2_B               equ $04c0 ; #38; SetStorySlotFlagB, cleared when the slot is erased
def SAVEFLAG_CLEARED_FRUIT_FANTASY_1     equ $0500 ; #40
def SAVEFLAG_CLEARED_FRUIT_FANTASY_2     equ $0520 ; #41
def SAVEFLAG_CLEARED_FRUIT_FANTASY_3     equ $0540 ; #42
def SAVEFLAG_CLEARED_BANANA_BUNCH_1      equ $0560 ; #43
def SAVEFLAG_CLEARED_BANANA_BUNCH_2      equ $0580 ; #44
def SAVEFLAG_CLEARED_BANANA_BUNCH_3      equ $05a0 ; #45
def SAVEFLAG_CLEARED_TREASURE_BOX_1      equ $05c0 ; #46
def SAVEFLAG_CLEARED_TREASURE_BOX_2      equ $05e0 ; #47
def SAVEFLAG_CLEARED_TREASURE_BOX_3      equ $0600 ; #48
def SAVEFLAG_CLEARED_MEDALLION_MATCH_1   equ $0620 ; #49
def SAVEFLAG_CLEARED_MEDALLION_MATCH_2   equ $0640 ; #50
def SAVEFLAG_CLEARED_MEDALLION_MATCH_3   equ $0660 ; #51
def SAVEFLAG_CLEARED_TWO_ON_ONE_1        equ $0680 ; #52
def SAVEFLAG_CLEARED_TWO_ON_ONE_2        equ $06a0 ; #53
def SAVEFLAG_CLEARED_TWO_ON_ONE_3        equ $06c0 ; #54
def SAVEFLAG_COURT_STAR                  equ $0720 ; #57
def SAVEFLAG_COURT_CASTLE                equ $0740 ; #58
def SAVEFLAG_COURT_TROPICS               equ $0760 ; #59
def SAVEFLAG_COURT_JUNGLE                equ $0780 ; #60
def SAVEFLAG_COURT_WAREHOUSE             equ $07a0 ; #61
def SAVEFLAG_N64_RECORDS_PRESENT         equ $07c0 ; #62; set when save block $0b holds N64 transfer data
def SAVEFLAG_DEBUG_TEST_MENU             equ $07e0 ; #63; toggled by bank $01's debug menu

; --- Story locations (wStoryModeCurrentLocation $c280, wStoryReturnLocation) ---
; A location id indexes StoryLocationTable_0a ($0a:$4ab2), 42 six-byte records
; (GetStoryLocationCount returns $2a), so the id space is exactly $00-$29 and
; the record at index i describes location i. Each id also names itself: the
; popup LoadStoryLocationHeader ($0a:$5142) queues is text id $0179 + id
; (`add $79 / adc $01`, string bank $30 index 377 + id), and the names below are
; those strings turned into identifiers -- so they are the game's own wording,
; not a guess. wStoryReturnLocation holds one of the same ids and is fed to the
; same $0179 + id lookup by DrawStoryResultsHeader ($1e:$448c).
;
; Two of the strings need judgement. Ids $0b/$0c are both spelled "Junior Class
; Court": they are the singles and doubles variants of one room, so they take
; the _SINGLES/_DOUBLES suffix already used by their map_scripts labels. Ids
; $1e-$29 are the ending cutscene's re-dressed locations and their strings carry
; the cutscene's own scene numbers ("End1 Main Bldg", "End10 Varsity Court");
; those numbers are kept, and id $1f keeps the unnumbered "End Restaurant Ent."
; spelling the string actually uses. Ids $01-$04 are development leftovers whose
; strings are what they are; only $03 is still reached, by bank $01's debug menu.
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

; --- Game mode (wGameMode, $c8a6) ---
; What kind of tennis is being played. The id space is closed at $00-$0a by
; SaveQuitMenuIdByGameMode ($06:$44f3), an 11-byte table the pause menu indexes
; with wGameMode unguarded, and by ScoreboardModeGfxPointers ($06:$5cc9), 11
; words of scoreboard word art indexed the same way -- and that word art is what
; proves each id, because it spells the mode out on screen: RankingMatch,
; IslandOpen, PracticeMatch, Exhibition, MiniGames, TennisMachine, WallPractice,
; MarioMiniGames, LinkedMatch. The six results-screen headers dispatched at
; $1e:$4319 agree, as does a third, independent source: the mode byte is field 0
; of Singles/DoublesMatchSettingsTable ($0a:$4ab2/$4b2f) and field 3 of the
; drill and minigame configs ($0b:$4002/$0d:$4006), and RewardFlagListMode0_1e
; ($1e:$6d1c) hands the same 25 match indices their completion flags -- the
; mode-$01 rows get FLAG_WON_*_RANK_*, the mode-$02 rows FLAG_WON_ISLAND_OPEN_*,
; and the three mode-$0a rows FLAG_WON_DREAM_MATCH_SINGLES/DOUBLES.
; wGameMode lives inside wStorySlotData, so it is saved with the story slot and
; the mode a results screen reopened from the main menu renders is the saved one.
def GAMEMODE_NONE           equ $00 ; no match; the story overworld (RunStoryLocation clears it)
def GAMEMODE_RANKING_MATCH  equ $01 ; story class-ranking match (Junior/Senior/Varsity)
def GAMEMODE_ISLAND_OPEN    equ $02 ; story Island Open tournament match
def GAMEMODE_PRACTICE_MATCH equ $03 ; story practice match
def GAMEMODE_EXHIBITION     equ $04 ; exhibition mode (outside story mode)
def GAMEMODE_TRAINING_DRILL equ $05 ; Training Court lesson/drill (bank $0b definitions)
def GAMEMODE_TENNIS_MACHINE equ $06 ; Tennis Machine Room (FLAG_CLEARED_MACHINE_MASTER)
def GAMEMODE_WALL_PRACTICE  equ $07 ; Wall Practice Room (FLAG_CLEARED_WALL_MASTER)
def GAMEMODE_MARIO_MINIGAME equ $08 ; a Mario mini-game (bank $0d configs)
def GAMEMODE_LINK_MATCH     equ $09 ; link-cable versus match (set beside wLinkMatchRole)
def GAMEMODE_DREAM_MATCH    equ $0a ; story Dream Match against the Mario cast

; --- Character ids (character record byte +$0b, wMatchPlayerChar/OpponentChar) ---
; The 32-entry roster, in the order every character-indexed table takes:
; CharSpriteSetTable ($07:$5a50), CharPaletteIndexTable ($02:$417e),
; CharacterPortraitTable_16 and the bank $1b menu mugshots. The name is text id
; $001b + id (bank $30 strings from index $1b), fetched two instructions after
; InitCa00RecordFromCharId ($02:$4066) stores it at record +$0b -- so the names are
; the ROM's own, with punctuation dropped to make identifiers. Ids 0-3 are
; always unlocked; for 4-31 CheckCharacterUnlocked ($18:$452a) tests *save flag
; number = character id*, which is why the SAVEFLAG_UNLOCKED_*/_CLEARED_* block
; above names the same characters.
def CHAR_ALEX       equ $00
def CHAR_NINA       equ $01
def CHAR_HARRY      equ $02
def CHAR_KATE       equ $03
def CHAR_ALLIE      equ $04
def CHAR_JOY        equ $05
def CHAR_BRIAN      equ $06
def CHAR_PAM        equ $07
def CHAR_BOB        equ $08
def CHAR_BETH       equ $09
def CHAR_FAY        equ $0a
def CHAR_CURT       equ $0b
def CHAR_MARK       equ $0c
def CHAR_SEAN       equ $0d
def CHAR_SAMMI      equ $0e
def CHAR_ELDEN      equ $0f
def CHAR_SPIKE      equ $10
def CHAR_EMILY      equ $11
def CHAR_B_COZ      equ $12 ; "B. Coz"
def CHAR_A_COZ      equ $13 ; "A. Coz"
def CHAR_KEVIN      equ $14
def CHAR_UNUSED_15  equ $15 ; roster slot reading "Not used"; see below
def CHAR_UNUSED_16  equ $16 ; roster slot reading "Not used"
def CHAR_LUIGI      equ $17
def CHAR_DK         equ $18
def CHAR_BABY_MARIO equ $19 ; "Baby M."
def CHAR_MARIO      equ $1a
def CHAR_WALUIGI    equ $1b
def CHAR_YOSHI      equ $1c
def CHAR_BOWSER     equ $1d
def CHAR_WARIO      equ $1e
def CHAR_PEACH      equ $1f

; --- Character-id sentinels (values outside the roster) ---
; InitCa00RecordFromCharId ($02:$4066) branches on the id before using it as a
; roster index: $ff clears the slot and stamps $ff at record +$0b, and any id
; with bit 7 set names a *story* character record instead of a roster entry --
; bit 0 selects $c900 (main) or $c940 (partner). Roster ids $20 and up are the
; story-mode opponents and are remapped back into 4-31 by RemapExtendedCharId
; ($02:$4c58) for their name and portrait, so they have no constants here.
; CHAR_UNUSED_15 doubles as a "no visible opponent / locked" marker: it is the
; opponent of every Tennis Machine config and of Shooting Star, and
; GetUnlockedMarioCastCharAtGridSlot ($3b:$66b5) returns it for a Mario-cast
; grid slot whose character is still locked.
def CHAR_NONE          equ $ff ; empty court slot
def CHAR_STORY_MAIN    equ $80 ; the story slot's own character ($c900 record)
def CHAR_STORY_PARTNER equ $81 ; its doubles partner ($c940 record)

; --- Court ids (wCurrentlyUsedCourt, $c8f4) ---
; The one index the match setup passes to pick a court. Its only reader is
; LoadCourtSceneData ($08:$5e28), which multiplies it by 4 into the 25-row
; LoadCourtSceneDataTable ($08:$5dc4) and takes the row's surface friction,
; surface restitution and court-scene graphics id -- so a court id is exactly
; "one row of bounce/friction/scene", and ids that only differ in scene are
; skins of the same surface ($0d is $02's row byte for byte).
; Proof of the names, in order of strength:
; ids 4-8 -- ComputeUnlockedCourtFlags ($3e:$69a0) builds wUnlockedCourtMask
; from CourtUnlockFlagIds_3e, StoreCourtUnlockBits explodes it one byte per
; court and IsCourtUnlocked ($3e:$697b) reads byte (id - 4), which pins
; SAVEFLAG_COURT_STAR/_CASTLE/_TROPICS/_JUNGLE/_WAREHOUSE onto 4/5/6/7/8;
; ids $09/$0a/$0b/$18 -- every drill definition in bank $0b carries court $18
; (Match) or $09 (Practice), and the Tennis Machine / Wall Practice configs in
; bank $0d carry $0a / $0b;
; ids $0f-$17 -- each Mario minigame's bank $0d config names its own court;
; ids $00-$03 -- the four always-available courts of the exhibition court
; select (IsCourtUnlocked returns "unlocked" below 4); the surface names follow
; the community RAM map and are consistent with the friction/restitution pairs
; (clay slowest, composition fastest).
def COURT_HARD              equ $00
def COURT_CLAY              equ $01
def COURT_GRASS             equ $02
def COURT_COMPOSITION       equ $03
def COURT_STAR              equ $04 ; first of the five unlockable bonus courts
def COURT_CASTLE            equ $05 ; also the Dream Match court
def COURT_TROPICS           equ $06
def COURT_JUNGLE            equ $07
def COURT_WAREHOUSE         equ $08
def COURT_TRAINING_PRACTICE equ $09 ; Training Court, Practice drills
def COURT_TENNIS_MACHINE    equ $0a
def COURT_WALL_PRACTICE     equ $0b
def COURT_CENTER            equ $0c ; Island Open final
def COURT_GRASS_ISLAND_OPEN equ $0d ; Island Open early rounds; $02's surface
def COURT_UNUSED_0E         equ $0e ; no code or table ever selects it
def COURT_TARGET_SHOT       equ $0f
def COURT_SHOOTING_STAR     equ $10
def COURT_BANANA_BUNCH      equ $11
def COURT_BOO_BLAST         equ $12
def COURT_PERFECT_SHOT      equ $13
def COURT_TREASURE_BOX      equ $14
def COURT_MEDALLION_MATCH   equ $15
def COURT_FRUIT_FANTASY     equ $16
def COURT_TWO_ON_ONE        equ $17
def COURT_TRAINING_MATCH    equ $18 ; Training Court, Match drills

; --- Match-list category (wCurrentMinigameStoryMatch high byte, $c8f6) ---
; The 16-bit selector at $c8f6 is (category, index). The category decides which
; list the index means: 0/1 pick a row of SinglesMatchSettingsTable_0a /
; DoublesMatchSettingsTable_0a ($0a:$4ab2/$4b2f, chosen by `cp $01` at
; $0a:$4a62), 2 means the index is a MINIGAME_* id below. Every drill and
; minigame setup path writes 2 here ($0b:$4022, $0d:$4026).
def MATCHLIST_SINGLES  equ $00
def MATCHLIST_DOUBLES  equ $01
def MATCHLIST_TRAINING equ $02

; --- Training/minigame ids (wCurrentMinigameStoryMatch low byte, $c8f7) ---
; The argument of RunTrainingDrillByID ($0b:$4705), which is the single entry
; point for everything in MATCHLIST_TRAINING: below $12 it indexes
; DrillDefinitionPtrs ($0b:$47b4), otherwise it hands the id to
; StartMinigameByID ($0d:$407f), which indexes MinigameConfigTable as id - $12
; ($24 is special-cased into RunDoublesDrillMatch, $0b:$7258).
; The 18 drill names come from the debug drill list (text 31:141-31:147, four
; items per string, item order == id) and are corroborated three ways: the
; Match drills all run on COURT_TRAINING_MATCH and the Practice drills on
; COURT_TRAINING_PRACTICE; the story lesson menus add $03/$09/$0f to a 0-2
; menu pick ($10:$4534/$456c/$45a4); and bank $15's Match challenge scenes pass
; exactly 0-2, 6-8 and $0c-$0e. (The ROM's own menu string for id 3 reads
; "Service Match 1" where 4 and 5 read "Service Practice 2/3" -- a typo.)
; $12-$1b are the Tennis Machine and Wall Practice levels plus their two
; high-score ("Master Lvl") variants, from the same menu and from the tables
; MachineCourtStartLevelSceneTable ($14:$45f8) and
; LaunchWallPracticeMinigameTable ($12:$52b9).
; $1c-$24 are the nine Mario minigames. SetMinigameClearFlag ($1e:$6edc)
; indexes MinigameClearFlagTable_1e by (id - $1c) * 3 + level, tying each id to
; its three SAVEFLAG_CLEARED_* bits, and independently each id's bank $0d
; config carries the player character that the Mario-minigame select grid shows
; in the matching slot (MarioCastCharAtGridSlotTable, $3b:$66e9).
def MINIGAME_SERVICE_MATCH_1           equ $00
def MINIGAME_SERVICE_MATCH_2           equ $01
def MINIGAME_SERVICE_MATCH_3           equ $02
def MINIGAME_SERVICE_PRACTICE_1        equ $03
def MINIGAME_SERVICE_PRACTICE_2        equ $04
def MINIGAME_SERVICE_PRACTICE_3        equ $05
def MINIGAME_NET_GAME_MATCH_1          equ $06
def MINIGAME_NET_GAME_MATCH_2          equ $07
def MINIGAME_NET_GAME_MATCH_3          equ $08
def MINIGAME_NET_GAME_PRACTICE_1       equ $09
def MINIGAME_NET_GAME_PRACTICE_2       equ $0a
def MINIGAME_NET_GAME_PRACTICE_3       equ $0b
def MINIGAME_STROKE_MATCH_1            equ $0c
def MINIGAME_STROKE_MATCH_2            equ $0d
def MINIGAME_STROKE_MATCH_3            equ $0e
def MINIGAME_STROKE_PRACTICE_1         equ $0f
def MINIGAME_STROKE_PRACTICE_2         equ $10
def MINIGAME_STROKE_PRACTICE_3         equ $11
def MINIGAME_TENNIS_MACHINE_1          equ $12 ; "Machine Lvl 1"
def MINIGAME_TENNIS_MACHINE_2          equ $13
def MINIGAME_TENNIS_MACHINE_3          equ $14
def MINIGAME_TENNIS_MACHINE_4          equ $15
def MINIGAME_WALL_PRACTICE_1           equ $16 ; "Wall Lvl 1"
def MINIGAME_WALL_PRACTICE_2           equ $17
def MINIGAME_WALL_PRACTICE_3           equ $18
def MINIGAME_WALL_PRACTICE_4           equ $19
def MINIGAME_TENNIS_MACHINE_HIGH_SCORE equ $1a ; "Machine Master Lvl"
def MINIGAME_WALL_PRACTICE_HIGH_SCORE  equ $1b ; "Wall Master Lvl"
def MINIGAME_BOO_BLAST                 equ $1c ; first Mario minigame
def MINIGAME_SHOOTING_STAR             equ $1d
def MINIGAME_PERFECT_SHOT              equ $1e
def MINIGAME_TARGET_SHOT               equ $1f
def MINIGAME_FRUIT_FANTASY             equ $20
def MINIGAME_BANANA_BUNCH              equ $21
def MINIGAME_TREASURE_BOX              equ $22
def MINIGAME_MEDALLION_MATCH           equ $23
def MINIGAME_TWO_ON_ONE                equ $24

; --- Mario-minigame select slot (wSelectedMinigame, $cb20) ---
; A second, smaller space: the cell index of the 3x3 Mario-minigame grid
; ($3b:$62c7 stores it, $10:$5271 turns it into a MINIGAME_* id through
; MinigameDrillIdTable). The same index picks the character shown in the cell
; (MarioCastCharAtGridSlotTable, $3b:$66e9) and the rules page (slot * 3 +
; wMinigameLevel), and CheckMinigameGridExpanded ($3b:$66f2) asks whether slot
; 6 is unlocked to decide between the 6-cell and 9-cell grids.
def MARIOGAME_BOO_BLAST       equ $00 ; Mario
def MARIOGAME_SHOOTING_STAR   equ $01 ; Luigi
def MARIOGAME_PERFECT_SHOT    equ $02 ; Peach
def MARIOGAME_TARGET_SHOT     equ $03 ; Baby Mario
def MARIOGAME_FRUIT_FANTASY   equ $04 ; Yoshi
def MARIOGAME_BANANA_BUNCH    equ $05 ; DK
def MARIOGAME_TREASURE_BOX    equ $06 ; Wario; first cell of the expanded grid
def MARIOGAME_MEDALLION_MATCH equ $07 ; Waluigi
def MARIOGAME_TWO_ON_ONE      equ $08 ; Bowser

; --- Sound ids (a to PlaySound $3297 / PlaySoundManaged $3024 / `sound`) ---
; One 8-bit id space covers both music and sound effects; the routine splits it
; at $50. PlaySound reads $3151 + (id - 1) * 2 for id < $50 and $31b5 +
; (id - $50 - 1) * 2 above, so ids $01-$32 are the 50 entries of the first index
; table and $51-$c1 the 113 of the second. Each entry names a voice count and a
; row in bank ($70 | nibble)'s SoundTable_*; the first table's entries are 3-4
; voices on channels 2-5 (songs), the second's 1-2 voices on channels 0-1
; (effects) -- which is why id $00 stops the music (`jp z, StopAllSound` clears
; channels 2-5) and id $50 stops the effects (clears channels 0-1 and returns
; before the lookup). Ids $33-$4f index past the end of the first table into the
; second; nothing reaches them, because the `sound` macro's handler ($2fb3)
; claims $40-$4f as jingles first. That handler also latches every id below $40
; into wCurrentBGM, so the wCurrentBGM values are exactly these BGM_* ids.
; The sound test (RunSoundTest, $01:$6a5b) lists the same two spaces: ids
; $00-$32 plus the five jingles on one axis, $50-$c1 on the other.

; Music. Proven per id from the tables that select one: CourtSelectBgmIds_3e
; (court-select index -> wMatchBGM), the story_location records' BGM field,
; MinigameConfigTable's records (+5 -> wMatchBGM), DrillDefinitionPtrs' records,
; Singles/DoublesMatchSettingsTable_0a (+4), and SetPointSituationBgm.
def BGM_NONE                 equ $00 ; silence: stops the four music channels
def BGM_INTRO                equ $01 ; RunIntroCutscene ($6b:$4041)
def BGM_TITLE_SCREEN         equ $02 ; RunTitleScreen ($6b:$7647)
def BGM_MENU                 equ $03 ; shared theme of ~20 menu screens (main menu, character/court/format select, save and N64 flows)
def BGM_STATUS_SCREEN        equ $04 ; character/minigame data, game progress, trophies, N64 record screens
def BGM_DICTIONARY           equ $05 ; TennisDictionaryScreen ($3f:$410f)
def BGM_EXHIBITION_MATCH     equ $06 ; CourtSelectBgmIds_3e rows 0-3: the four standard courts
def BGM_EXHIBITION_MATCH_LINK equ $07 ; the same four rows of CourtSelectBgmIdsLink_3e (link play)
def BGM_MARIO_MINIGAME       equ $08 ; Special Court story_location + the minigame select/level menus
def BGM_WIN                  equ $09 ; match/point won (ShowMinigamePointResult, RunMatchWinLoseScreen)
def BGM_LOSE                 equ $0a ; the .lostPoint branch of the same two
def BGM_EXP_AWARD            equ $0b ; BeginNextExpAward ($1e:$5b22)
def BGM_EXP_DISTRIBUTION     equ $0c ; ShowExpDistributionScreen, TickLevelUpJingle
def BGM_STAT_DISTRIBUTION    equ $0d ; AnimateCharDataStatsReveal, SetupCharDataScreen
def BGM_TIEBREAK             equ $0e ; SetPointSituationBgm, wTiebreakerIndicator set
def BGM_SET_POINT            equ $0f ; same, wMatchPointFlag or wSetPointFlag set
def BGM_GAME_POINT           equ $10 ; same, wGamePointFlag set
def BGM_COURT_STAR           equ $11 ; CourtSelectBgmIds_3e row 4; also Boo Blast and InitDefaultMatchSettings
def BGM_COURT_CASTLE         equ $12 ; row 5; the Peach's Castle story_location and Perfect Shot use it
def BGM_COURT_TROPIC         equ $13 ; row 6; MinigameConfig_FruitFantasy
def BGM_COURT_WAREHOUSE      equ $14 ; row 8; MinigameConfig_TreasureBox
def BGM_TWO_ON_ONE           equ $15 ; RunDoublesDrillMatch ($0b:$726b -> wMatchBGM)
def BGM_COURT_JUNGLE         equ $16 ; row 7; MinigameConfig_BananaBunch
def BGM_DORM_ROOM            equ $1c ; DormRoomInitScript_13 / DormRoomNpc03_13
def BGM_SENIOR_RANKING       equ $22 ; MatchSettingsTable records 6-9; reused by the intro character showcase and the trophy cheat screen
def BGM_ISLAND_OPEN_LOSE     equ $2a ; ShowRankingBoard with wRankingBoardMode 2, which SetupRankingBoardArgs sets when wMatchWinLoseFlag != 1
def BGM_ISLAND_OPEN_WIN      equ $2b ; the same board with mode 1 (match won)
def BGM_CREDITS              equ $2c ; RunEndingCreditsSequence, the End1 story_location, and the debug text-overflow alarm
def BGM_THE_END              equ $2d ; the still screen after each credit scroll (PlayScreenSequence1/2)
def BGM_LEVEL_UP             equ $2f ; TickLevelUpJingle ($1d:$77c5)

; Jingles ($40-$45, PlaySoundManaged only). The handler stores the id in
; hActiveJingle, plays JingleSoundIds[id - $40] (a music id) and leaves
; ResumeBGMAfterJingle/WaitJingleEnd to restore wCurrentBGM when the music
; channels fall idle. Only one is used.
def JINGLE_DONE_FOR_THE_DAY  equ $41 ; going to bed (DormRoomNpc03_13) and the save-slot debug editor

; Sound effects. Named from the event the call site plays them for.
def SFX_STOP                 equ $50 ; silences the two effect channels
def SFX_BALL_BOUNCE          equ $5b ; HandleBallBounceEvent ($08:$435e)
; The next two were confirmed on the emulator rather than from the call sites,
; by hooking PlaySound.startChannels ($32dc) -- `hl` there is the index-table
; entry, so it survives the hook's register dedup where the id in `a` does not --
; and then performing one identifiable action at a time.
def SFX_SWING                equ $5c ; racket swing: both sites are in StartCharSwing ($08:$6df1, $6e29), captured mid-rally under ROM bank $08
def SFX_BALL_CONTACT         equ $77 ; the ball connecting with a scoring object: HandleBallTouchCharEvent ($08:$43dc), HandleMinigameTargetHit ($0a:$671f), MinigameTargetTypeScores ($0d:$5612); captured as a Medallion Match deflect
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

; --- On-court character animation ids (wCharAnimId $df2e, wCharSwingAnim $df15) ---
; One id space, not two. SetCharAnimation ($08:$69ea) stores its argument in
; wCharAnimId and indexes wCharAnimTablePtr by it; that table is the 19-entry
; <Char>SpriteAnims list every character bank ($40-$5d) opens with, so an id is
; a direct index into <Char>SpriteAnim00-18 and the space is exactly $00-$12.
; wCharSwingAnim is not a separate encoding -- it is the id of the swing being
; built, copied into wCharAnimId by CharSwingWindupPhase ($08:$6c4a). The debug
; character viewer confirms the range: CharViewerInputLoopTable ($1a:$792f)
; feeds SetCharAnimation an identity list $00..$12.
;
; Two structural rules generate most of the table, and both are visible in the
; scripts themselves (Alex's, but every character bank is laid out identically):
;   swing + $08 = the held "ready" pose  -- CharRallyReadyPhase ($08:$6c0f)
;                 plays `wCharSwingAnim + $08` while the button is down, and
;                 SpriteAnim0d/0e/0f are each a single frame, held with delay
;                 $ff, that is the frame immediately before SpriteAnim05/06/07.
;   swing + $04 = the quick (uncharged) variant -- StartCharSwing.startSwing
;                 ($08:$6e37) adds 4 when fewer than 5 windup frames elapsed,
;                 and SpriteAnim09/0a/0b/0c are each the *first* frame of
;                 SpriteAnim05/06/07/08 alone before chaining back to idle.
; That is why CharRallyEndState ($08:$6a90) tests the seven-value set
; $05 $06 $07 $09 $0a $0b $12: it is "a ground swing or a dive is still
; playing", i.e. all four strokes in both their charged and quick forms, plus
; the dive. The smash is missing from the set only because the airborne bit
; ($df0f bit 2) is tested on the next line and covers it.
def CHARANIM_STAND           equ $00 ; frame 0, held; the parked pose on the character-select screen
def CHARANIM_IDLE            equ $01 ; the ready bob; UpdateCharRunAnimation's not-moving case, and what every swing chains back to
def CHARANIM_RUN             equ $02 ; UpdateCharRunAnimation's moving case (wCharFlags bit 4)
def CHARANIM_CELEBRATE       equ $03 ; CharPointReactionPhase, wCharPointResult >= 0; also both characters on the results screen ($1e:$49e5)
def CHARANIM_DEJECTED        equ $04 ; CharPointReactionPhase, wCharPointResult < 0
def CHARANIM_FOREHAND        equ $05 ; SelectForehandBackhand ($08:$6e58)
def CHARANIM_BACKHAND        equ $06 ; SelectForehandBackhand ($08:$6e5e); ExecuteShot counts it toward wShotAimMirror
def CHARANIM_OVERHEAD        equ $07 ; the high ground stroke ($08:$6dd1) and the serve swing ($08:$6baf)
def CHARANIM_SMASH           equ $08 ; the jumping smash ($08:$6def); the script holds its last frame until the character lands
def CHARANIM_FOREHAND_QUICK  equ $09
def CHARANIM_BACKHAND_QUICK  equ $0a ; counted toward wShotAimMirror alongside $06
def CHARANIM_OVERHEAD_QUICK  equ $0b
def CHARANIM_SMASH_QUICK     equ $0c ; only ResetSwingAnimation and the debug viewer reach it -- StartCharSwing returns before the +$04 step on the smash path
def CHARANIM_FOREHAND_READY  equ $0d
def CHARANIM_BACKHAND_READY  equ $0e
def CHARANIM_OVERHEAD_READY  equ $0f ; also the serve toss pose (CharServeTossPhase, $08:$6b83)
def CHARANIM_SERVE_READY     equ $10 ; held serve stance; CharServeInitPhase.waitAnim and AiServeWalkToSpot both block until it is current
def CHARANIM_SERVE_PREP      equ $11 ; the pre-serve flourish, which ends in an anim_set to $10
def CHARANIM_DIVE            equ $12 ; StartCharSwing.dive ($08:$6df7)

; --- On-court character state (wCharState, $df18) ---
; The index UpdateCharStateMachine ($08:$6a62) dispatches on through the
; 8-entry jumptable at $08:$6a7b; SetCharState ($08:$6a1c) is the only writer
; and zeroes wCharStatePhase/wAiPhase with it. The names are the handler labels
; that jumptable points at. The AI's three parallel tables ($08:$7886/$789a/
; $78ae) index the same value and only implement slots 1, 2 and 3.
; Two data tables map into this space and cannot carry the names, being `db`
; rows rather than instructions: ServeRoleCharStateTable_08 ($08:$4fa0) is
; serve role -> state at the start of a point ($03 $05 $04 $05), and
; SetCharStateOnBallHitTable ($08:$431e) is the state every character is
; remapped through on every strike ($00 $02 $01 $02 $02 $01 $06 $07).
def CHARSTATE_INERT          equ 0 ; slot points at the shared `ret` -- InitChar, ResetCharForPoint, and a character the ball hits
def CHARSTATE_RALLY          equ 1 ; CharRallyState: ready -> windup -> contact
def CHARSTATE_RECOVER        equ 2 ; CharServeStrikePhase.dispatch: let the swing finish, then movement only. Whoever struck the ball is put here
def CHARSTATE_SERVE          equ 3 ; CharServeState: indicator, toss, swing window, strike
def CHARSTATE_AWAIT_SERVE    equ 4 ; CharAwaitServeState
def CHARSTATE_STANDBY        equ 5 ; CharStandbyState: end-state, then state 4's movement phase
def CHARSTATE_WALK           equ 6 ; CharWalkState: the scripted changeover and walk-off walks
def CHARSTATE_POINT_END      equ 7 ; CharPointEndState: walk to target, then the win/lose reaction

; --- On-court character flags (wCharFlags, $df0f) ---
; Bit indices only: every one of the 40 sites is a `bit`/`res`/`set`, so the
; masks would have no user. Bits 3 and 7 are never touched.
def CHARB_RECOIL             equ 0 ; set by ApplyShotRecoil ($07:$546e) after every stroke and by CheckCharBallContact on a body hit; UpdateCharVelocityFromInput ($08:$73d7) is the only reader and drops the steering intent
def CHARB_DIVING             equ 1 ; StartCharSwing.dive sets it. Widens the contact window to 1.25x wCharReachX, flattens the brake, freezes the facing ease, costs -$0c00 shot speed, and turns both power strokes back into their base shots
def CHARB_AIRBORNE           equ 2 ; set for the smash jump, cleared by StepCharJumpPhysics on landing; also picks the airborne shadow over the ground one
def CHARB_MOVING             equ 4 ; the velocity came out nonzero this frame (or MoveCharTowardTarget stepped); UpdateCharRunAnimation reads it to choose run over idle
def CHARB_CHARGING           equ 5 ; a swing is winding up: StepCharMovement ($08:$72ed) shifts both velocities right 3, so speed / 8
def CHARB_MOVE_BLOCKED       equ 6 ; StepCharMovement refused an axis at the court bound instead of clamping it. Written at four sites and read at none

; --- Match abort flag (wMatchAbortFlag, $c4c3) ---
; Two independent bits rather than a code, which is why the masks and not the
; values are what the code tests: every reader is an `and` (or one `bit 7`),
; and the two bits break different loops. docs/match_engine.md describes the
; same split. Note that the quit-menu writes $ff, not $81 -- it sets every bit
; rather than the two defined ones, so that value needs a name of its own.
def MATCHABORT_POINT         equ $01 ; give up the current rally: tested `and $01` by PlayPoint.rallyLoop ($08:$4d2c) and PlayMinigamePoint.rallyLoop
def MATCHABORT_MATCH         equ $80 ; break out of the point/game/set/match loops: tested `and $80` in RunMatchPlayLoop, CheckSetComplete and RunMinigameLoop
def MATCHABORT_ALL           equ $ff ; every bit set, written by the four MatchQuitMenu_* actions, StoryPauseMenu_ReturnToMainMenu and TargetZonePointEndHook_07
def MATCHABORTB_MATCH        equ 7   ; bit-index form of MATCHABORT_MATCH, for the one `bit 7, a` consumer ($16:$447a)

; --- Story save slot (wCurrentStorySlot, $c8a5) ---
; Slots 0-2 are the three story files; the byte doubles as an index
; (GetCurrentSlotBlockId $03:$529d reads StorySlotBlockIds_03[slot], and a slot
; saves as block 2N with its backup at +$1b), so the real ids stay numeric. The
; out-of-range value is the one worth naming: it means "not a story file at
; all" -- exhibition, link, mini-game and the two debug screens set it, and
; StorySlotBlockIds_03[3] is the exhibition block. It shares its value with the
; slot count, which is the bound in the same `cp $03` guard, so both names
; exist and each site takes the one that says what that site is doing.
def STORYSLOT_NONE           equ $03 ; not a story file: set by exhibition, link, mini-game and debug setup, and mapped to the exhibition save block
def NUM_STORY_SLOTS          equ $03 ; the three story files, as a bound: `cp $03 / ret nc` in SaveStorySlot/CheckStorySlot, and the debug stats screen's page wrap

; --- Story entry point sentinel (wStoryModeEntryPoint, $c295) ---
; The entry point is *location-scoped*, not a global id space: each location's
; map_tree carries its own `map_entry` table (8-byte records keyed by their
; first byte), and LoadStoryEntryPointRecord ($0a:$516f) linearly searches that
; table, falling back to its first record on no match. So the same $0f means
; one door at the Senior Class Court and another at the Junior one -- the ids
; belong to the tables, which already name themselves, and only the sentinel is
; engine-wide.
def STORYENTRY_NONE          equ $ff ; no entry point: keep the saved position (LoadStoryEntryPointRecord returns early), suppress the location-name popup ($0a:$5154), and terminate a map_entry table

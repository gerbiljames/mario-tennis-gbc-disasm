; --- Match pause-menu item ids (MatchMenuDefs) ---
; GetMatchMenuItemId returns one of these; they index MatchMenuItemGfxPointers
; (the selected item's word art), MatchMenuItemRectPointers (its 3x2 label in
; the list) and the item caption at text id $013f + id (bank $30, 319+id).
; Names follow the captions; the comment gives the word art, which several
; ids share.
	const_def
	const MATCHMENUITEM_RULES              ; $00 "RULES"
	const MATCHMENUITEM_CONTROLS           ; $01 "CONTROLS"
	const MATCHMENUITEM_OPTIONS            ; $02 "OPTIONS"
	const MATCHMENUITEM_SAVE               ; $03 "SAVE" (opens the save/quit menu)
	const MATCHMENUITEM_CAMERA_MODE        ; $04 "CAMERA MODE"
	const MATCHMENUITEM_MUSIC              ; $05 "MUSIC"
	const MATCHMENUITEM_CAMERA_NORMAL      ; $06 "NORMAL"
	const MATCHMENUITEM_CAMERA_PLAYER      ; $07 "PLAYER"
	const MATCHMENUITEM_MUSIC_ON           ; $08 "ON"
	const MATCHMENUITEM_MUSIC_OFF          ; $09 "OFF"
	const MATCHMENUITEM_CANCEL             ; $0a "CANCEL"
	const MATCHMENUITEM_SAVE_GAME          ; $0b "SAVE" (narrow; performs the save)
	const MATCHMENUITEM_TO_MAIN_MENU       ; $0c "TO MAIN MENU"
	const MATCHMENUITEM_TO_LEVEL_SELECT    ; $0d "TO LEVEL SELECT"
	const MATCHMENUITEM_RETRY_MINIGAME     ; $0e "TRY AGAIN"
	const MATCHMENUITEM_RETRY_PRACTICE     ; $0f "TRY AGAIN"
	const MATCHMENUITEM_RETRY_MACHINE      ; $10 "TRY AGAIN"
	const MATCHMENUITEM_RETRY_PRACTICE_ALT ; $11 "TRY AGAIN"
	const MATCHMENUITEM_RETRY_GAME         ; $12 "TRY AGAIN"
	const MATCHMENUITEM_QUIT_GAME          ; $13 "QUIT MATCH"
	const MATCHMENUITEM_QUIT_MATCH         ; $14 "QUIT MINI-GAME"
	const MATCHMENUITEM_QUIT_PRACTICE      ; $15 "QUIT MINI-GAME"
	const MATCHMENUITEM_QUIT_MACHINE       ; $16 "QUIT MINI-GAME"
	const MATCHMENUITEM_QUIT_PRACTICE_ALT  ; $17 "QUIT MINI-GAME"
def NUM_MATCHMENUITEMS equ const_value

; --- Match pause menus (wPauseMenuId, rows of MatchMenuDefs) ---
; The save/quit menu comes from SaveQuitMenuIdByGameMode, indexed by wGameMode.
	const_def
	const MATCHMENU_PAUSE            ; $00 free camera: RULES / CONTROLS / OPTIONS / SAVE
	const MATCHMENU_PAUSE_FIXED_VIEW ; $01 wCourtViewLocked: MUSIC replaces OPTIONS
	const MATCHMENU_OPTIONS          ; $02
	const MATCHMENU_CAMERA           ; $03
	const MATCHMENU_MUSIC            ; $04
	const MATCHMENU_QUIT_STORY       ; $05 story matches
	const MATCHMENU_QUIT_EXHIBITION  ; $06
	const MATCHMENU_QUIT_DRILL       ; $07
	const MATCHMENU_QUIT_LESSON      ; $08 wDrillIsPracticeLesson
	const MATCHMENU_QUIT_MACHINE     ; $09
	const MATCHMENU_QUIT_WALL        ; $0a
	const MATCHMENU_QUIT_MINIGAME    ; $0b
	const MATCHMENU_QUIT_LINK        ; $0c
	const MATCHMENU_QUIT_NO_MODE     ; $0d GAMEMODE_NONE
	const MATCHMENU_MINIGAME_END     ; $0e RunMinigameEndMenu: no CANCEL
def NUM_MATCHMENUS equ const_value

; --- Story pause menus (wPauseMenuId, rows of StoryMenuDefs) ---
	const_def
	const STORYMENU_PAUSE         ; $00
	const STORYMENU_STATUS        ; $01 CHAR. DATA / ITEMS
	const STORYMENU_OPTIONS       ; $02
	const STORYMENU_MESSAGE_SPEED ; $03
	const STORYMENU_MUSIC         ; $04
	const STORYMENU_SAVE_QUIT     ; $05
def NUM_STORYMENUS equ const_value

; --- Story pause-menu item ids (StoryMenuDefs) ---
; Same shape for the story-mode pause menu: StoryMenuItemGfxPointers,
; StoryMenuItemRectPointers, caption at text id $0162 + id (bank $30, 354+id).
	const_def
	const STORYMENUITEM_STATUS       ; $00 "STATUS"
	const STORYMENUITEM_CLEAR_STATUS ; $01 "CLEAR STATUS" (game progress)
	const STORYMENUITEM_OPTIONS      ; $02 "OPTIONS"
	const STORYMENUITEM_SAVE         ; $03 "SAVE" (opens the save/quit menu)
	const STORYMENUITEM_MESSAGES     ; $04 "MESSAGES"
	const STORYMENUITEM_MUSIC        ; $05 "MUSIC"
	const STORYMENUITEM_MSG_SLOW     ; $06 "SLOW"
	const STORYMENUITEM_MSG_NORMAL   ; $07 "NORMAL"
	const STORYMENUITEM_MSG_FAST     ; $08 "FAST"
	const STORYMENUITEM_MUSIC_ON     ; $09 "ON"
	const STORYMENUITEM_MUSIC_OFF    ; $0a "OFF"
	const STORYMENUITEM_SAVE_GAME    ; $0b "SAVE" (narrow; performs the save)
	const STORYMENUITEM_TO_MAIN_MENU ; $0c "TO MAIN MENU"
	const STORYMENUITEM_CANCEL       ; $0d "CANCEL" (continue game)
	const STORYMENUITEM_CHAR_DATA    ; $0e "CHAR. DATA"
	const STORYMENUITEM_ITEMS        ; $0f "ITEMS"
def NUM_STORYMENUITEMS equ const_value

; --- Character-select mode (wCharSelectMode) ---
; Six modes, indexing four parallel 6-record tables (CharSelectSlotRing0-5
; and friends). RunExhibitionCharSelectScreen takes modes 0-1 in b from
; wMatchFormatDoubles; RunLinkCharSelectScreen stores the link modes from
; wMatchIsDoubles and hLinkState. The P2 modes start the cursor at seat 2.
	const_def
	const CHARSELECTMODE_EXHIBITION_SINGLES ; $00
	const CHARSELECTMODE_EXHIBITION_DOUBLES ; $01
	const CHARSELECTMODE_LINK_SINGLES_P1    ; $02
	const CHARSELECTMODE_LINK_SINGLES_P2    ; $03
	const CHARSELECTMODE_LINK_DOUBLES_P1    ; $04
	const CHARSELECTMODE_LINK_DOUBLES_P2    ; $05
def NUM_CHARSELECTMODES equ const_value

; --- Character-grid handedness (wCharGridHandedness) ---
; START toggles it with `xor 1` (unchosen becomes left) for Mario-cast
; characters; the label under the portrait reads it.
	const_def
	const HAND_RIGHT    ; $00
	const HAND_LEFT     ; $01
	const HAND_UNCHOSEN ; $02

; --- Character-select result (wCharSelectExitCode), polled by the frame loop ---
	const_def
	const CHARSELECT_RUNNING   ; $00
	const CHARSELECT_DONE      ; $01
	const CHARSELECT_CANCELLED ; $02

; --- Equipment screen item kind (wEquipItemKind) ---
def EQUIPKIND_RACKETS equ $00
def EQUIPKIND_SHOES   equ $01

; --- Menu selection sentinel (wMatchMenuSelection) ---
; A row in whatever menu is up (match pause, story pause, debug stats), not an
; item id: GetMatchMenuItemId maps it via `MatchMenuDefs + wPauseMenuId * 8 +
; row`. Only the B-pressed value is named.
def MATCHMENUSEL_CANCELLED   equ $ff ; B pressed: no row chosen

; --- Dialogue window sentinel (wDialogueWindowId, WRAM bank $05) ---
; Real values are window-struct indices from CreateWindowFromScreenRect; the
; speaker-dialogue helpers test this sentinel before opening a window
; (FitWindowToText substitutes window 0) and store it after CloseWindow.
def DIALOGUEWIN_NONE         equ $ff ; no dialogue window open

; --- Window struct fields (wWindowStructs, WRAM bank $05) ---
; NUM_WINDOWS records, reached through GetWindowStructPtr (id & 7, << 3).
	rsreset
def WINDOW_COL     rb ; $00 wrapped to $1f by SetWindowRect
def WINDOW_ROW     rb ; $01 wrapped to $1f by SetWindowRect
def WINDOW_WIDTH   rb ; $02 cells
def WINDOW_HEIGHT  rb ; $03 cells
def WINDOW_STATE   rb ; $04 a WINDOWSTATE_* (GetWindowState / SetWindowState)
	rb_skip 1         ; $05
def WINDOW_TEXT_ID rw ; $06 SetWindowTextId
def WINDOW_SIZE equ _RS
	ASSERT WINDOW_SIZE == 8
def NUM_WINDOWS equ 8

; --- Window state (WINDOW_STATE) ---
; Zero from FreeWindow for a plain window. Both menu states have bit 1 set,
; which the redraw paths test (and WINDOWSTATE_MENU) to indent the text one
; column past the cursor arrow.
def WINDOWSTATE_MENU       equ $02 ; CreateMenuWindowFromText
def WINDOWSTATE_PAGED_MENU equ $03 ; CreateMenuWindowPaged: Left/Right page a long list
def WINDOWSTATE_HIDDEN     equ $ff ; DrawTextWindowFrame skips it; ResetWindowState sets it before FreeWindow

; --- Message speed (wMessageSpeed) ---
; Bits 0-6 hold the speed; bit 7 draws text instantly whatever the speed
; (ApplyMessageSpeed, FlushGlyphRow) and is cleared before saving.
	const_def
	const MSGSPEED_FAST   ; $00
	const MSGSPEED_NORMAL ; $01 the new-game default
	const MSGSPEED_SLOW   ; $02
def NUM_MSGSPEEDS equ const_value
def MSGSPEEDB_INSTANT equ 7
def MSGSPEEDF_INSTANT equ 1 << MSGSPEEDB_INSTANT
def MSGSPEED_MASK     equ $7f

; --- Menu transition direction (wMenuSlideDirection) ---
def MENUSLIDE_BACK           equ $00
def MENUSLIDE_FORWARD        equ $01 ; into a submenu

; --- Menu cursor locks (wMenuCursorLockFlags) ---
; A locks a cursor; B unlocks it, or, when neither is locked, sets its
; CANCEL bit, which nothing reads.
	const_def
	const CURSORLOCKB_PRIMARY          ; $00
	const CURSORLOCKB_SECONDARY        ; $01
	const CURSORLOCKB_PRIMARY_CANCEL   ; $02
	const CURSORLOCKB_SECONDARY_CANCEL ; $03
def CURSORLOCKF_PRIMARY          equ 1 << CURSORLOCKB_PRIMARY
def CURSORLOCKF_SECONDARY        equ 1 << CURSORLOCKB_SECONDARY
def CURSORLOCKF_PRIMARY_CANCEL   equ 1 << CURSORLOCKB_PRIMARY_CANCEL
def CURSORLOCKF_SECONDARY_CANCEL equ 1 << CURSORLOCKB_SECONDARY_CANCEL

; --- Sprite bob/bounce/wobble direction (c of ApplyCursorBounceX/Y,
; ApplySpriteBobOffsetX/Y, ApplySelectionBoxWobbleX/Y and kin) ---
; The routines add the hVBlankCounter-driven offset to d (X) or e (Y).
def BOBDIR_NEG equ $00 ; subtract: up/left
def BOBDIR_POS equ $01 ; add: down/right

; --- Briefing caption prompt (AdvanceFrameCheckInput's c) ---
def BRIEFPROMPT_SHOW equ $00 ; draw the blinking prompt
def BRIEFPROMPT_NONE equ $01 ; last caption: no prompt

; --- Menu panel slide animations (RestoreMenuBgAndDrawPanel's b) ---
; Rows of TilemapAssemblyDispatch_39; c picks the frame within the row.
	const_def
	const PANELANIM_MAIN_MENU_IN          ; $00
	const PANELANIM_MAIN_MENU_OUT         ; $01
	const PANELANIM_MATCH_FORMAT_IN       ; $02
	const PANELANIM_MATCH_FORMAT_OUT      ; $03
	const PANELANIM_MINIGAME_GRID9_IN     ; $04
	const PANELANIM_MINIGAME_GRID9_OUT    ; $05
	const PANELANIM_UNUSED_PANEL_IN       ; $06 only Unused_3b_SlideMenuPanel_1
	const PANELANIM_UNUSED_PANEL_OUT      ; $07
	const PANELANIM_SAVED_DATA_PICKER_IN  ; $08
	const PANELANIM_SAVED_DATA_PICKER_OUT ; $09
	const PANELANIM_THREE_CHOICE_IN       ; $0a
	const PANELANIM_THREE_CHOICE_OUT      ; $0b
	const_skip 4                          ; $0c-$0f never passed: copies of CHOICE_TAB_IN
	const PANELANIM_CHOICE_TAB_IN         ; $10
	const PANELANIM_CHOICE_TAB_OUT        ; $11
	const PANELANIM_COURT_SELECT4_IN      ; $12
	const PANELANIM_COURT_SELECT4_OUT     ; $13
	const PANELANIM_COURT_SELECT9_IN      ; $14
	const PANELANIM_COURT_SELECT9_OUT     ; $15
	const PANELANIM_MINIGAME_GRID6_IN     ; $16
	const PANELANIM_MINIGAME_GRID6_OUT    ; $17
def NUM_PANELANIMS equ const_value

; --- Panel row flush layouts (FlushWram3MapRows' b) ---
; Rows 0-1 plus 3-row bands starting at the rows named, tilemap and attrmap.
	const_def
	const MAPROWS_BANDS_3_7_11 ; $00
	const MAPROWS_BANDS_4_10   ; $01 never passed
	const MAPROWS_BANDS_4_9    ; $02
	const MAPROWS_BAND_7       ; $03

; --- Attribute-rect highlight (c of the option-cell and tab attr fillers) ---
; SetMatchRuleOptionAttrRect, FillMatchFormatOptionCell, SetChoiceTabAttrRect,
; SetCourtSelect4/9TabAttrRect, SetSelectPanelAttrRect(3) and
; FillN64RecordTypeCell test c for zero: any nonzero value fills with the
; selected attribute, zero with the inactive $0d.
def ATTRRECT_INACTIVE equ $00
def ATTRRECT_SELECTED equ $01

; --- Match-format screen rows (cursor row; FlushMatchFormatRowToVram's b) ---
	const_def
	const MATCHFMTROW_MODE  ; $00 singles / doubles (wMatchFormatDoubles)
	const MATCHFMTROW_GAMES ; $01 wMatchFormatGames
	const MATCHFMTROW_SETS  ; $02 wMatchFormatSets
def NUM_MATCHFMTROWS equ const_value

; --- Match-format option cells (FillMatchFormatOptionCell's b) ---
; A row's cells run from its base: the selected cell is the base plus the
; row's variable (`add MATCHFMTOPT_GAMES`).
def MATCHFMTOPT_SINGLES equ $00
def MATCHFMTOPT_DOUBLES equ $01
def MATCHFMTOPT_GAMES   equ $02 ; + wMatchFormatGames (2 choices)
def MATCHFMTOPT_SETS    equ $04 ; + wMatchFormatSets (3 choices)
def NUM_MATCHFMTOPTS    equ MATCHFMTOPT_SETS + 3

; --- Character select slot (wCharSelectSlot) ---
def CHARSELECTSLOT_DONE equ $04 ; every player slot is filled: the screen shows the wait banner
def CHARSELECTSLOT_BACKED_OUT equ $ff ; B on the first slot (CharSelectSlotRingTable): leave the screen

; --- Character-data screen cursor (wCharDataPage) ---
; The four level-up choices (the training levels, CHARREC_TRAIN_LEVELS order),
; then the confirm cell.
def CHARDATAPAGE_SPIN    equ TRAINSTAT_SPIN
def CHARDATAPAGE_POWER   equ TRAINSTAT_POWER
def CHARDATAPAGE_CONTROL equ TRAINSTAT_CONTROL
def CHARDATAPAGE_SPEED   equ TRAINSTAT_SPEED
def CHARDATAPAGE_CONFIRM equ NUM_TRAINSTATS

; --- Tennis Dictionary mode (wTennisDictMode) ---
; Modes 0-4 open the term list filtered to category bit 1 << mode. Only
; TENNISDICT_INDEX is ever passed.
	const_def
	const TENNISDICT_TERMS        ; $00
	const TENNISDICT_CATEGORY1    ; $01 no entries carry its bit
	const TENNISDICT_CATEGORY2    ; $02 no entries carry its bit
	const TENNISDICT_TECHNIQUE    ; $03
	const TENNISDICT_COURT        ; $04
	const TENNISDICT_SINGLE_ENTRY ; $05 all categories, one fixed entry
	const TENNISDICT_INDEX        ; $06 the 9-cell category index page

; --- Tennis Dictionary category bits (wTennisDictCategoryMask, TennisDictEntryCategories) ---
def TDICTCAT_TERMS     equ 1 << TENNISDICT_TERMS     ; rules, scoring, shots, formations
def TDICTCAT_1         equ 1 << TENNISDICT_CATEGORY1
def TDICTCAT_2         equ 1 << TENNISDICT_CATEGORY2
def TDICTCAT_TECHNIQUE equ 1 << TENNISDICT_TECHNIQUE ; strokes, spin, grip, footwork
def TDICTCAT_COURT     equ 1 << TENNISDICT_COURT     ; lines, areas, surfaces
def TDICTCAT_ALL       equ $1f

; --- Tennis Dictionary display flags (wTennisDictFlags) ---
	const_def
	const TDICTFLAGB_WINDOW_OPEN ; $00 a description window is open
	const TDICTFLAGB_LIST_SHOWN  ; $01 the term list is on screen
	const TDICTFLAGB_LEFT_ARROW  ; $02 flash the left page arrow this frame
	const TDICTFLAGB_RIGHT_ARROW ; $03 flash the right page arrow this frame

; --- Ranking board presentation (wRankingBoardMode) ---
	const_def
	const RANKINGBOARD_PLAIN     ; $00
	const RANKINGBOARD_FANFARE   ; $01 plays fanfare $2b and the marker climb
	const RANKINGBOARD_CURSOR    ; $02 the second fanfare and RankingCursorBobTask; no marker animation
	const RANKINGBOARD_SILENT    ; $03 ShowRankingBoard argument only: stored as PLAIN with wRankingBoardSilent set

; --- EXP award lines (SetPendingExpAward's b; wPendingExpAwardAmounts words) ---
	const_def
	const EXPAWARD_N64        ; $00 "Mario Tennis for N64."
	const EXPAWARD_EXHIBITION ; $01 "Exhibition Mode."
	const EXPAWARD_LINKED     ; $02 "Linked Play."
	const EXPAWARD_MATCH      ; $03 a story match or minigame; c picks the wording
	const EXPAWARD_TROPHY     ; $04 "winning the trophy."
def NUM_EXPAWARDS equ const_value

; --- EXP award screen record (wExpScreenCharStats) ---
; One per story character, slot 1 at + EXPSTAT_SIZE; filled by
; InitExpScreenCharStats.
	rsreset
def EXPSTAT_LEVEL        rb   ; $00 1-100
def EXPSTAT_LEVEL_EXP    rw   ; $01 GetExpRequiredForLevel
def EXPSTAT_BAR          rb   ; $03 filled pixels of the level bar
def EXPSTAT_EXP_IN_LEVEL rw   ; $04
def EXPSTAT_ASSIGNED     rw   ; $06 points given this visit, passed to AddPlayerExp
def EXPSTAT_EXP_TO_NEXT  rw   ; $08 CheckExpLevelUp/Down act when it runs out
def EXPSTAT_SAVED_COLOR  rw   ; $0a BG colour the screen greys out and restores
def EXPSTAT_EXP          rb 3 ; $0c CHARREC_EXP, copied back to wStory*Exp
def EXPSTAT_SIZE equ _RS
	ASSERT EXPSTAT_SIZE == 15

; --- EXP screen busy flags (wExpScreenBusyFlags), cleared when the screen opens ---
	const_def
	const EXPBUSYB_CURSOR_SLIDING ; $00 the cursor slide task is running: blocks point changes and DrawExpToNextLevelTask
	const EXPBUSYB_POINT_MOVED    ; $01 the last press moved a point. Never read
	const EXPBUSYB_CONFIRM_OPEN   ; $02 the confirm prompt is open: blocks DrawExpToNextLevelTask

; --- Scoreboard layout (wScoreboardLayout) ---
; Chosen by SelectScoreboardLayout: wOnCourtCharCount - 2 outside minigame
; context, else by the drill/minigame flags. Indexes the caption and drawer
; jumptables and the tilemap and sprite-template tables in bank $06.
	const_def
	const SCOREBOARD_SINGLES     ; $00
	const SCOREBOARD_THREE_CHARS ; $01
	const SCOREBOARD_DOUBLES     ; $02
	const SCOREBOARD_LESSON      ; $03 wDrillIsPracticeLesson
	const SCOREBOARD_DRILL       ; $04 drill matches and the other Mario minigames: result rows
	const SCOREBOARD_POINT_PIPS  ; $05 Stroke Match 1
	const SCOREBOARD_SCORE       ; $06 wall, Tennis Machine and Boo Blast: score to a target
	const SCOREBOARD_HIGH_SCORE  ; $07 wMinigameHighScoreMode

; --- Results player panel (DrawPlayerNameAndLevel) ---
; CopyTilesAndAttrsRun reads each cell's attribute this far past its tile id,
; so the panel's 8x5 attribute plane is decompressed there.
def RESULTS_PANEL_ATTRS equ 200

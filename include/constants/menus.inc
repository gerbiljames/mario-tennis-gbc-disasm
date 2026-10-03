; --- Match pause-menu item ids (MatchMenuDefs) ---
; GetMatchMenuItemId returns one of these; they index MatchMenuItemGfxPointers
; (the selected item's word art), MatchMenuItemRectPointers (its 3x2 label in
; the list) and the item caption at text id $013f + id (bank $30, 319+id).
; Names follow the captions; the comment gives the word art, which several
; ids share.
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

; --- Story pause-menu item ids (StoryMenuDefs) ---
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

; --- Character-select mode (wCharSelectMode) ---
; Six modes, indexing four parallel 6-record tables (CharSelectSlotRing0-5
; and friends). RunExhibitionCharSelectScreen takes modes 0-1 in b from
; wMatchFormatDoubles; RunLinkCharSelectScreen stores the link modes from
; wMatchIsDoubles and hLinkState. The P2 modes start the cursor at seat 2.
def CHARSELECTMODE_EXHIBITION_SINGLES equ $00
def CHARSELECTMODE_EXHIBITION_DOUBLES equ $01
def CHARSELECTMODE_LINK_SINGLES_P1    equ $02
def CHARSELECTMODE_LINK_SINGLES_P2    equ $03
def CHARSELECTMODE_LINK_DOUBLES_P1    equ $04
def CHARSELECTMODE_LINK_DOUBLES_P2    equ $05

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

; --- Menu transition direction (wMenuSlideDirection) ---
def MENUSLIDE_BACK           equ $00
def MENUSLIDE_FORWARD        equ $01 ; into a submenu

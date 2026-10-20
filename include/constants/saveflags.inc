; --- Global save flags (SRAM $a040-$a05f, 256 bits) ---
; Test/Set/ClearSaveFlag (bank $03) take the id in de: high byte = array byte
; index, low byte = bit << 5, and the mask is $80 >> bit -- the wGameFlags
; encoding, but a separate global array (docs/save_format.md). Flag number =
; byte * 8 + bit is quoted per line. The character grid reads #10-#15
; through CharUnlockSaveFlags by Mario-cast grid slot. CheckCharacterUnlocked's
; flag number = character id lookup is reached only from unused code.

def SAVEFLAG_OPENING_SEEN                equ $0120 ; #9; set when the title/opening sequence finishes
def SAVEFLAG_UNLOCKED_WALUIGI            equ $0140 ; #10; granted by N64 transfer records
def SAVEFLAG_UNLOCKED_YOSHI              equ $0160 ; #11; granted by N64 transfer records
def SAVEFLAG_UNLOCKED_BOWSER             equ $0180 ; #12; granted by N64 transfer records
def SAVEFLAG_UNLOCKED_WARIO              equ $01a0 ; #13; granted by N64 transfer records
def SAVEFLAG_UNLOCKED_MARIO              equ $01c0 ; #14; granted by the singles Dream Match
def SAVEFLAG_UNLOCKED_PEACH              equ $01e0 ; #15; granted by the doubles Dream Match
def SAVEFLAG_CLEARED_BOO_BLAST_1         equ $0280 ; #20
def SAVEFLAG_CLEARED_BOO_BLAST_2         equ $02a0 ; #21
def SAVEFLAG_CLEARED_BOO_BLAST_3         equ $02c0 ; #22
def SAVEFLAG_CLEARED_SHOOTING_STAR_1     equ $02e0 ; #23
def SAVEFLAG_CLEARED_SHOOTING_STAR_2     equ $0300 ; #24
def SAVEFLAG_CLEARED_SHOOTING_STAR_3     equ $0320 ; #25
def SAVEFLAG_CLEARED_PERFECT_SHOT_1      equ $0340 ; #26
def SAVEFLAG_CLEARED_PERFECT_SHOT_2      equ $0360 ; #27
def SAVEFLAG_CLEARED_PERFECT_SHOT_3      equ $0380 ; #28
def SAVEFLAG_CLEARED_TARGET_SHOT_1       equ $03a0 ; #29
def SAVEFLAG_CLEARED_TARGET_SHOT_2       equ $03c0 ; #30
def SAVEFLAG_CLEARED_TARGET_SHOT_3       equ $03e0 ; #31
def SAVEFLAG_STORY_SLOT0_MUSIC_MUTED               equ $0400 ; #32; SetStorySlotMusicMuted, cleared when the slot is erased
def SAVEFLAG_STORY_SLOT1_MUSIC_MUTED               equ $0420 ; #33; SetStorySlotMusicMuted, cleared when the slot is erased
def SAVEFLAG_STORY_SLOT2_MUSIC_MUTED               equ $0440 ; #34; SetStorySlotMusicMuted, cleared when the slot is erased
def SAVEFLAG_STORY_SLOT3_MUSIC_MUTED               equ $0460 ; #35; SetStorySlotMusicMuted for slot 3 (exhibition)
def SAVEFLAG_STORY_SLOT0_COURT_VIEW               equ $0480 ; #36; SetStorySlotCourtView, cleared when the slot is erased
def SAVEFLAG_STORY_SLOT1_COURT_VIEW               equ $04a0 ; #37; SetStorySlotCourtView, cleared when the slot is erased
def SAVEFLAG_STORY_SLOT2_COURT_VIEW               equ $04c0 ; #38; SetStorySlotCourtView, cleared when the slot is erased
def SAVEFLAG_STORY_SLOT3_COURT_VIEW               equ $04e0 ; #39; SetStorySlotCourtView for slot 3 (exhibition)
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

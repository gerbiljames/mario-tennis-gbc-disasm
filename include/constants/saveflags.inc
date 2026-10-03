; --- Global save flags (SRAM $a040-$a05f, 256 bits) ---
; Test/Set/ClearSaveFlag (bank $03) take the id in de: high byte = array byte
; index, low byte = bit << 5, and the mask is $80 >> bit -- the wGameFlags
; encoding, but a separate global array (docs/save_format.md). Flag number =
; byte * 8 + bit is quoted per line. Numbers 0-31 double as the
; character-unlock bits: CheckCharacterUnlocked tests flag number = character
; id (ids 0-3 always unlocked).

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

SECTION "WRAMX bank 1", WRAMX[$d000], BANK[1]

; WRAMX bank 1 at a glance:
;
;   $d000-$dfff  cutscene text scroll buffer / character record copy / VRAM staging

; WRAM bank $01 is VRAM staging: every screen decompresses into it and
; QueueVRAMCopies out of it, so an offset means whatever the current screen
; put there (tile graphics, a tilemap plane, its attribute plane). Offsets
; in use are multiples of TILE_SIZE.
; The one fixed overlay is bank $1b's character-record copy:
; LoadCharacterRecordToBuffer writes $d580 in whichever bank the caller
; selected, and bank $1b selects this one while building the new-game roster.
; ShowDmgLockoutScreen (bank $01) also stages here: on a DMG $d000-$dfff is
; the single upper WRAM half, the bytes a CGB calls bank 1.
UNION
; cutscene text scroll buffer (bank $03)
; [640 bytes] Eight 80-column rows of rendered cutscene text: DrawCutsceneTextLines draws each line from column 19 of row 1, and BlitCutsceneTextWindow copies a 20-column window of it, one column further per call, into wWindowShadowTilemap to scroll the text. Both select the bank themselves
wCutsceneTextScrollBuffer:: ds 640
	ds 3456
NEXTU
; character record copy (bank $1b)
	ds 1408
; [128 bytes] Copy of a character record LoadCharacterRecordToBuffer takes from wPlayer2MainName, so one character's fields can be read without disturbing the live records. CheckCharacterUnlocked tests +$0b (the id) against $ff; RunNewGameSetup reads +$0c and +$0e of each starting character
wCharRecordBuffer:: ds 128
NEXTU
; VRAM staging (WRAM bank $01)
; [2048 bytes] Where DecompressData lands and QueueVRAMCopy reads from. A screen may slice it several ways: the cutscene frame loaders keep six frames at tiles 0, 4, 8, 12, 14 and 16; the EXP screen puts a tilemap plane at tile 0 and its attributes at tile 64. Unused_00_CopyMapToScrollBuffers expands map planes from it into WRAM bank $02
wDecompBuffer:: ds 2048
; [2048 bytes] The other half: Unused_1a_DrawStringToTileBuffer renders strings here as tile data (the EXP screen's captions and bonus messages), uploaded like any other graphics
wTextTileBuffer:: ds 2048
	export_size wTextTileBuffer
ENDU

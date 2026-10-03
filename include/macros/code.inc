; Code idioms: far calls, WRAM banking, flags, waits and the paired-operand loads.

; Bank-switched call through rst $18 (FarCall, $01b6): two inline operand
; bytes select a FarPtr_* entry in the target bank's $4000 pointer table; the
; trampoline returns past the operands.
MACRO farcall
	rst Rst18
	db LOW(FarPtr_\1), BANK(FarPtr_\1)
	ASSERT HIGH(FarPtr_\1) == SLOT_TABLE_PAGE, "FarPtr_\1 is outside its bank's $4000 slot table"
ENDM

; Sound/music command (handler $2fb3): one inline id byte.
MACRO sound
	rst Rst08
	db \1
ENDM

; ld_slot hl, DataPtr_X: hl = the (slot, bank) pair of a $4000-table entry,
; the operand LoadCompressedTileBlock-style loaders take in a register.
MACRO ld_slot
	ld \1, (BANK(\2) << 8) | LOW(\2)
	ASSERT HIGH(\2) == SLOT_TABLE_PAGE, "\2 is outside its bank's $4000 slot table"
ENDM

; rst $20/$28/$30: set/clear/test a bit of wGameFlags. Two inline operand
; bytes: the bit in the top 3 bits of the first (mask $80 >> bit), the flag
; byte index in the second.
; Usage: `set_flag FLAG_NAME` (flag number, flag_constants.inc) or
; `set_flag byte_index, bit` where the flag has no name yet. A flag number
; is byte * 8 + bit, the numbering *GameFlagByNumber takes.
MACRO set_flag
	rst Rst20
IF _NARG == 1
	db ((\1) % 8) << 5, (\1) / 8
ELSE
	db (\2) << 5, \1
ENDC
ENDM

MACRO clear_flag
	rst Rst28
IF _NARG == 1
	db ((\1) % 8) << 5, (\1) / 8
ELSE
	db (\2) << 5, \1
ENDC
ENDM

MACRO test_flag
	rst Rst30
IF _NARG == 1
	db ((\1) % 8) << 5, (\1) / 8
ELSE
	db (\2) << 5, \1
ENDC
ENDM

; WRAM bank switch: writes rWBK and its shadow hWramBank. The argument, if
; given, is loaded into a first -- a WRAM_* constant (include/constants/), e.g.
; WRAM_TEXT or WRAM_CHAR0-3 (banks 4-7, one per on-court character). The
; bare form switches to the bank already in a.
MACRO wram_bank
	IF _NARG == 1
	ld a, \1
	ENDC
	ldh [hWramBank], a
	ldh [rWBK], a
ENDM

; Save the current WRAM bank on the stack and select another;
; pop_wram_bank restores it.
MACRO push_wram_bank
	ldh a, [hWramBank]
	push af
	wram_bank \1
ENDM

MACRO pop_wram_bank
	pop af
	wram_bank
ENDM

; hl = \1 + a: the split-base table index, the address added as two 8-bit
; immediates (`sub l` recovers the carry from the low add).
MACRO ld_hl_indexed
	add LOW(\1)
	ld l, a
	adc HIGH(\1)
	sub l
	ld h, a
ENDM

; de / bc = \1 + a.
MACRO ld_de_indexed
	add LOW(\1)
	ld e, a
	adc HIGH(\1)
	sub e
	ld d, a
ENDM

MACRO ld_bc_indexed
	add LOW(\1)
	ld c, a
	adc HIGH(\1)
	sub c
	ld b, a
ENDM

; WaitFramesCmd takes its frame count as an inline byte after the call.
MACRO wait_frames
	call WaitFramesCmd
	db \1
ENDM

; lb pair, hi, lo -- load two bytes into a register pair with one 16-bit
; immediate. Sites whose callee reads the halves separately use the named
; forms below (ld_xy, ld_cell, ld_oam, ld_size, ld_tile_run, ld_*_pals).
MACRO lb
	ld \1, ((\2) << 8) | (\3)
ENDM

; ld_xy pair, x, y -- a sprite's screen position as the sprite routines take
; it: x in the high register, y in the low (QueueSprite writes d as OAM X and
; e as OAM Y).
MACRO ld_xy
	lb \1, \2, \3
ENDM

; ld_oam pair, attr, tile -- a sprite's OAM attribute byte and tile id as
; QueueSprite and QueueSpriteTemplate take them: the attribute in the high
; register (CGB palette in bits 0-2, plus OAM_* flags from hardware.inc), the
; tile in the low. QueueSpriteTemplate adds both to every template entry, and
; bit 5 picks its mirrored copy.
MACRO ld_oam
	lb \1, \2, \3
ENDM

; ld_size pair, width, height -- a rectangle in tile cells as the window and
; text-rect routines take it (CreateWindow, CopyTextRect, ...): the width in
; the high register, the height in the low.
MACRO ld_size
	lb \1, \2, \3
ENDM

; ld_tile_run pair, tile, count -- FillTilemapRun's arguments: the tile id it
; writes to each cell in the high register, the number of cells in the low.
MACRO ld_tile_run
	lb \1, \2, \3
ENDM

; Two-instruction forms of the same pairs, named in the order they emit.
; rect_size width, height -- ld b, width / ld c, height (FillTilemapRect,
; CopyTilemapRect, CreateWindowFromScreenRect: the width is the inner loop)
MACRO rect_size
	ld b, \1
	ld c, \2
ENDM

; rect_cell column, row -- ld d, column / ld e, row: a screen-rect origin
MACRO rect_cell
	ld d, \1
	ld e, \2
ENDM

; map_cell x, y -- ld d, x / ld e, y: a story-map tile, the high byte of a
; map position (WriteBehaviorMapCell halves both for the 16-pixel cells)
MACRO map_cell
	ld d, \1
	ld e, \2
ENDM

; sprite_xy x, y -- ld d, x / ld e, y (QueueSprite and friends)
MACRO sprite_xy
	ld d, \1
	ld e, \2
ENDM

; sprite_attr_tile attr, tile -- ld b, attr / ld c, tile
MACRO sprite_attr_tile
	ld b, \1
	ld c, \2
ENDM

; sprite_tile_attr tile, attr -- ld c, tile / ld b, attr
MACRO sprite_tile_attr
	ld c, \1
	ld b, \2
ENDM

; ld_bg_pals pair, first, count / ld_obj_pals pair, first, count -- a run of
; CGB palettes as LoadPaletteShadow and its siblings take it: the palette
; index in the high register (0-7 background, 8-15 objects; the loader tests
; bit 3 to pick the half) and the count in the low.
MACRO ld_bg_pals
	ASSERT (\2) + (\3) <= 8, "background palettes run past 7"
	lb \1, \2, \3
ENDM

MACRO ld_obj_pals
	ASSERT (\2) + (\3) <= 8, "object palettes run past 7"
	lb \1, 8 + (\2), \3
ENDM

; ld_cell pair, column, row -- a tile cell as the text and window routines
; take it, on the background map or inside a window: the column in the high
; register, the row in the low.
MACRO ld_cell
	lb \1, \2, \3
ENDM

; ld_flag_id pair, FLAG_NAME -- the (byte << 8) | (bit << 5) form of a game
; flag that Set/Clear/TestGameFlag take in de, from the flag number the
; *ByNumber helpers and set_flag/test_flag use.
MACRO ld_flag_id
	ld \1, ((((\2) / 8) << 8) | (((\2) % 8) << 5))
ENDM

; Story match launcher: store the 16-bit big-endian match id into
; wCurrentMinigameStoryMatch, then farcall LoadMatchSettingsFromTable. The
; high byte is the category (0 singles, 1 doubles, 2 minigame/practice), the
; low byte the match.
; Usage: load_match_settings MATCHLIST_*, STORYMATCH_* (or one 16-bit id)
MACRO load_match_settings
IF _NARG == 2
	ld a, \1
	ld [wCurrentMinigameStoryMatch], a
	ld a, \2
ELSE
	ld a, HIGH(\1)
	ld [wCurrentMinigameStoryMatch], a
	ld a, LOW(\1)
ENDC
	ld [wCurrentMinigameStoryMatch + 1], a
	farcall LoadMatchSettingsFromTable
ENDM

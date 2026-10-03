# RAM map

Cartridge SRAM is `$a000`-`$bfff`, WRAM `$c000`-`$dfff` (banks 1-7 at
`$d000`), HRAM `$ff80`-`$fffe`. Every symbol is declared in `ram/wram.asm`,
`ram/hram.asm` or `ram/sram.asm`, or as an EQU in `include/ram_mirrored.inc`,
and its comment there is the per-address note: size, meaning, writers and
readers, and the value lists (locations, BGM ids, game modes, courts,
character ids, the `wCurrentMinigameStoryMatch` match ids). The save-flag
bits are on the `SAVEFLAG_*` constants (`include/constants.inc`, see
`docs/save_format.md`). Where the
[RetroAchievements Code Notes](https://retroachievements.org/game/5043) named
an address, the symbol keeps that name; the rest are named from the code.

This page covers what the declarations do not show one at a time: how the
overlays are scoped, the per-character WRAM banks, the match renderer's
sprite slots, and the free RAM.

## Union overlays

RAM that several subsystems use at different times is an RGBDS
`UNION`/`NEXTU` overlay in `ram/*.asm`, one variant per owner, each with its
own symbols and a note naming the code that owns it. A variant's names appear
only at sites whose scope matches: the referencing code's ROM bank and range,
and/or the WRAM bank proven selected there (by dataflow or a traced run). So
the same `$dxxx` offset reads as different symbols in different routines,
and a site whose bank could not be proven keeps the number (97, all inside
`Unused_*` routines nothing reaches). The assembler accepts any variant's
symbol anywhere, so when an edit moves an access to another owner, change the
operand by hand; the variant notes say which one a routine may touch.

WRAM-bank scoping is what keeps banked WRAMX (`$d000-$dfff`) apart: the same
offset means different things per bank, and a global name would leak across
banks.

### Mirrored variants

The opposite case: one address range holding a *parallel copy* in each of
several WRAM banks, where the address names the cell and the selected bank
picks the copy. The character-data screen keeps its stat pages that way,
tiles in bank `$03` and CGB attributes in bank `$02`, so a save is one copy
per bank to the same word:

```asm
	wram_bank WRAM_SCREEN         ; $03
	ld hl, wShadowTilemap
	ld de, wCharDataPageSlot1
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16
	call CopyMemoryFast
	wram_bank WRAM_COURT_PLANES   ; $02
	ld hl, wScreenAttrmap
	ld de, wCharDataPageSlot1     ; same address, other plane
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16
	call CopyMemoryFast
```

No per-bank name fits that operand. A mirrored symbol names the whole set:
one EQU in `include/ram_mirrored.inc`, whose `; in WRAM banks` line lists the
banks holding a copy (`tools/ram_free.py` reads it), used where the site's
bank is any of those or cannot be proven. It **allocates nothing** -- each
bank already declares the bytes in its own union -- and, being an EQU, it has
to be visible while each bank is assembled, so the Makefile preincludes the
file (`-P`). A bare `$dxxx` operand left in the source is a candidate for
one: one address, several banks, one routine.

### Bank-tagged copies

A genuinely replicated structure -- the match engine's per-character struct
in each of WRAM banks 4-7 -- gets both forms: each bank declares its copy
under a bank-tagged name (`w4CharPosX`, `w5CharPosX`, ...) in its own
`BANK[n]` section, and the untagged EQU `wCharPosX` is what the code uses,
since the bank selected at run time decides which copy a site means. The
tagged labels put the structure in `build/mariotennis.sym` (EQUs do not
reach it), so an emulator debugger resolves the right name in whichever bank
it is stopped in: 416 entries, 104 per bank. A bank whose own section
already runs past those addresses is skipped.

### Scoped ranges

| range | variant (scope) | symbols |
|---|---|---|
| `$c780-$c784` | character select (bank `$1b`) | `wCharSelectChar`/`PrevChar`/`Col`/`Row` — cursor state over the roster grid at `$c7a0` |
| `$ffd0-$ffef` | serial-link input slots (default) | `hLinkInput` (merged effective input, also the scripted-input feed), `hLinkRemoteInput`, `hLinkRemoteInputBuf` |
| | sound driver (bank 0 `$3373-$3de0`) | full per-channel HRAM working set: `hSndScriptPtr`, `hSndVolume`, `hSndInstrument`, `hSndEnvRate/Length/Pos`, `hSndVolSlide*`, `hSndEcho*`, `hSndLoop*`, `hSndRestFlag`, … (29 fields) |
| | sprite queue (bank 0 `$2ced-$2d9f`) | `hSpriteBlitX`, `hSpriteBlitY` |
| | story actor engine (banks `$04/$05/$0a`) | `hActorPtr` |
| `$d100-$d219` | sound engine (`wram_bank $07`, + bank-0 `$2f00-$3de0`) | channel state blocks `wSndChannels`, loop stack `wSndLoopSlots`, per-pass globals `wSndActiveMask`/`wSndChannelType`/`wSndRegBase`/`wSndPanShadow`/… |
| `$df00-$df96` | match char struct (`wram_bank $04/$05/$06/$07`, + match banks `$07`/`$08`) | per-character fields `wCharPosX`/`wCharState`/`wCharVel*`/`wCharSpriteSlot`/… (96); one name each, bank = character |
| | text-arg fetch buffer (banks `$0e`/`$0f`/`$12`) | `wTextArgFetchBuffer` — `$df00` reused as a text-arg string scratch while the match is idle (higher priority than the char variant so those sites don't read as `wCharPosX`) |
| `$dd00-$dd23` | match ball renderer (`wram_bank $04`, + bank `$08`) | `wBallHistory` — ball position-history ring (six 6-byte records) |
| `$de00-$de1f` | match ball renderer (`wram_bank $04`, + bank `$08`) | `wNetBallSlot`, `wBallSlot`, `wBallShadowSlot`, `wBallTrailSlots` (4-byte sprite-slot records) |
| `$a020-$a76f` | save engine (bank `$03`) | `sSaveSignature`, `sSaveMasterChecksum`, `sSaveFormatVersion`, `sSaveFlags`, `sSaveFlagsUnused`, `sSaveBlockDirectory` |

Interior bytes of a multi-byte scoped field render as `name + k` under the
same scope as the base (`$dd1e` is `wBallHistory + 30`, `$ffd1`
`hSndScriptPtr + 1`).

### Reading a bank at a glance

Each banked `SECTION` in `ram/*.asm` opens with a one-line-per-region
summary, since a bank is 4 KiB of overlapping claims (bank `$03` alone has
117 symbols across 28 variants):

```
; WRAMX bank 2 at a glance (ram/wram.asm):
;
;   $d000-$dfff  5 overlays: N64 block presence probe / match court planes / overworld scroll buffers / +2 more
;   $d400-$d7df  wCharDataPagePlane  [mirrored with bank 3]
;   $d7e0-$da1f  wCharDataPageSlot1  [mirrored with bank 3]
```

Overlays collapse to their owners; a range with more than three gives the
first three and "+N more". It is the only place mirrored structures appear
in the layout, since they allocate nothing.

## Match engine per-character structs (WRAM banks 4-7)

The match engine (bank `$08`) keeps one character struct per banked WRAM
bank, all at the same `$dfxx` addresses, and selects a character by writing
4-7 to `rSVBK`/`hWramBank`. `ForEachCharBank` (`$6a3a`) runs a callback in
banks 7, 6, 5, 4 (leaving 4 active). Bank assignment, from the dispatch
ladders at `$6063`/`$4ff5` indexed by `wOnCourtCharCountMinus1`:

| Bank | Character | Active when count is |
|---|---|---|
| 4 | near-side player 1 | 1, 2, 3, 4 |
| 5 | far-side player 1 | 2, 3, 4 |
| 6 | near-side partner | 4 |
| 7 | far-side partner | 3 (Two-On-One), 4 |

The fields are the untagged `wChar*` EQUs in `include/ram_mirrored.inc`
(used where the WRAM bank is 4-7 or inside match banks `$07`/`$08`), with
`w4Char*`...`w7Char*` in `ram/wram.asm` for the symbol file;
`docs/match_engine.md` describes them. Other WRAM banks reuse `$dfxx` for
unrelated data (bank `$38`'s non-char accesses stay numeric; the menu banks'
text-arg scratch at `$df00` is `wTextArgFetchBuffer`). The main fields:

| Address | Field |
|---|---|
| `$df00-02` | X position (lateral), 24-bit fixed point: fraction byte, then signed 16-bit integer part |
| `$df03-05` | depth position, same format; signed, net at 0, the two court sides have opposite signs |
| `$df06-08` | height above court, same format (zeroed by `SetCharPosAndTarget`) |
| `$df09` | serve/side role code, from byte 4-7 of the court-position record (`GamePositionTables`); XORed with 2 to swap court side per point, mapped through the `$4fa0` table to a char state at point start |
| `$df0a` | court position code, from byte 0-3 of the court-position record (XORed with 3 on the tiebreak side-swap path) |
| `$df0b` | character index 0-3 (== bank - 4); bit 0 set = far side, so `CharPointEndReaction` negates `wPointWinLoseFlag` through it for `$df57`, and it selects the off-screen edge-arrow sprite (index * 8) |
| `$df0d`/`$df0e` | facing direction: desired / displayed (eased toward desired in `$75c0` by at most `$df68` per frame) |
| `$df0f` bit 2 | airborne flag: set on jump (`$6dd5`, with `sound $5c`), cleared on landing; selects which shadow slot is drawn |
| `$df18-1a` | state machine index + substate (jumptable at `$6a77`; set via `SetCharState`) |
| `$df22` | object bank (`wCharObjectBank`); 0 means no object is loaded, and `UpdateChar` exits on it |
| `$df40-45` | velocity, 3 x 16-bit (zeroed on placement and at point end) |
| `$df46/47` | walk-target X (integer part) |
| `$df48/49` | walk-target depth; `MoveCharTowardTarget` ($7541) walks toward the target and snaps when `CheckCharNearTarget` ($78be) sees both deltas < $18 |
| `$df53/54` | last projected screen X/Y (`BuildCharSpriteSlots`, $7672) |
| `$df57` | point result from this character's perspective (signed `wPointWinLoseFlag`) |
| `$df1b-1d` | sprite frame data pointer (hi/lo) + h-flip flag, consumed by `DrawCharSprite` ($650a) |
| `$df80-83` | sprite-slot record for the character sprite (see below) |
| `$df88-8b` | sprite-slot record for the airborne shadow: tiles `$50/$52/$54/$56` shrink with jump height, drawn only while `$df0f` bit 2 is set |
| `$df8c-8f` | sprite-slot record for the standing shadow: tile `$58` through the 3-sprite-wide `StandingShadowOamTemplate` ($6301), drawn on alternate frames (flicker transparency) while grounded, singles only (`wStandingShadowsEnabled`) |
| `$df96` | draw-order depth key: `(depth * 8) >> 8 + $80`; `DrawActorsByDepth` compares teammates' keys to paint back-to-front |

## Match renderer sprite slots (WRAM bank 4, `$dd00`/`$de00`)

The match engine queues every court sprite through 4-byte **slot records**
`[tile, attr, screenY, screenX]`, `$ff` in the tile byte meaning empty.
`ClearSpriteSlots` (`$630e`) resets them each frame, gameplay code fills
them, and the draw stage flushes them into shadow OAM via `QueueSprite`
(`$1f51`), `QueueSprite16` (`$1e55`) or `QueueSpriteTemplate` (`$1e9d`).
Fixed slots, beside the per-character `$df80+` slots above:

| Address | Symbol | Slot |
|---|---|---|
| `$de00` | `wNetBallSlot` | ball-at-net marker: tile `$4e`, drawn after the point resolves when the ball rests within `$1e0` of the net, with a 1px X jitter per frame (`BuildNetBallSlot`) |
| `$de04` | `wBallSlot` | the ball itself: tile picked by height band / off-screen state (`$40/$42/$44`), gated by `wBallSpriteEnabled` (`BuildBallSlot`) |
| `$de08` | `wBallShadowSlot` | ball ground shadow: tile `$46` at the ball's height-0 projection, gated by `wBallShadowEnabled` (`BuildBallShadowSlot`) |
| `$de0c-$de1f` | `wBallTrailSlots` | 5 ball-trail afterimages (tile = ball tile + 8), fed from the position history ring; slots 3-5 only when `wBallTrailColor` is nonzero (`BuildBallTrailSlots`) |

`$dd00-$dd23` is the **ball position history ring** (`wBallHistory`): six
6-byte records `[projX word, projY word, tile+8, attr]`; `UpdateBallVisuals`
(`$5153`) shifts it down a record per frame and `BuildBallSlot` writes the
newest at `$dd1e`. `SetBallTrailColor` (`$5189`) picks one of the 8 OBJ
palettes in `BallTrailPalettes` (`$50dc`) for the trail (shot-type colours).

Drawn directly, with no slot: the swing-hit spark (tiles `$68-$6e`,
`wHitSparkTimer`), the special-shot flash (tile `$74` + bank `$28` screen
effect, `wSpecialHitTimer`), bounce dust (tiles `$60/$62`,
`wBounceEffectTimer`), the lob landing marker (tile `$7c`,
`wLandingMarkerX/Y`, started by `StartLandingMarker` with `sound $6d`), the
4-corner training target zone (tiles `$20-$26`, `wTargetZone*`) and the
off-screen character edge arrows (`DrawOffscreenCharArrow`, gated by
`wOffscreenArrowsEnabled`).

Frame flow: `DrawActorsByDepth` (`$6429`) draws the two team pairs and the
ball group in painter's order by the `$df96` keys (`DrawNearTeamChars`,
`DrawFarTeamChars`, `DrawBallAndEffects`), then `DrawMarkersAndShadows`
(`$6481`) flushes markers, trail and shadow slots. Modes hook extra draws
via `SetModeHookTable`/`CallModeHook` (`wModeHookBank`/`wModeHookTable`).

**Doubles spacing:** at point end `StartPointEndReactions` (`$4fb8`) makes
every character face the result (`CharPointEndReaction` sets state 7 and
target := current position), then `SpreadTeammateTargets` (`$4ff5`) adjusts
the walk-target depths per team pair -- banks (4,6) and (5,7) -- via
`ComputePairSpread` (`$506e`): teammates within `$200` of each other get
targets exactly `$200` apart around the pair's midpoint, never closer than
`$100` to the net; pairs already `$200`+ apart keep their positions. Singles
skips this (the jumptable's count-1/count-2 slots point at a bank-0 `ret`).

## Free RAM

What a modder can take without displacing anything.
`tools/ram_free.py` lists every byte no symbol covers and no raw literal in
`src/` addresses; `tools/ramaudit.py free` checks that list at run time by
poisoning every listed byte with `$5a` and playing each flow twice, poisoned
and clean. The flows cover every story state at every location and entry
point, the Test and Test2 maps, the main menu, exhibition matches, the Mario
minigames, link sessions, the N64 Transfer Pak record screens, both unlock
codes and every `NpcScripts` handler (237 flows; runs that crash, such as
impossible warps, are left out).

**Totals: 4,360 free bytes -- 2,704 untouched, 1,598 cleared only, 58
holding data, all explained.** No flow reads a free byte; the only poison
read ever seen, besides the since-declared speed bonus below, was in the
Test 2 map's debug scratch at `$c71a-$c75f`.

Not free, though `ram_free.py` cannot know it: the top 512 bytes of WRAM0
are the stack, growing down from `STACK_TOP` (`$d000`) with no symbol (deepest
reach seen `$cf34`); the story character record's undeclared bytes
`$c907-$c90a` and `$c90f-$c913` are live (poisoning them changes the player's
overworld sprite attributes).

### Untouched

Neither written nor read in any flow; safe to allocate. Ranges of eight
bytes or more:

| bank | range | bytes |
|---|---|---|
| WRAM0 | `$c2a6-$c2af` | 10 |
| WRAM0 | `$c2c8-$c2cf` | 8 |
| WRAM0 | `$c2f0-$c2f7` | 8 |
| WRAM0 | `$c377-$c37f` | 9 |
| WRAM0 | `$c3a8-$c3af` | 8 |
| WRAM0 | `$c3e0-$c3ff` | 32 |
| WRAM0 | `$cb79-$cbef` | 119 (Test2 debug screens write it, see below) |
| WRAM0 | `$cbf2-$cbff` | 14 (Test2 debug screens write it) |
| WRAM4 | `$d690-$d7ff` | 368 |
| WRAM6 | `$dc90-$ddc0` | 305 |
| WRAM6 | `$ddc2-$dddf` | 30 |
| WRAM6 | `$dde2-$de00` | 31 |
| WRAM6 | `$de02-$deff` | 254 |
| WRAM7 | `$d020-$d057` | 56 |
| WRAM7 | `$d098-$d0d6` | 63 |
| WRAM7 | `$d21a-$d27f` | 102 |
| WRAM7 | `$db00-$db25` | 38 (Test2 debug screens write `$db00-$db1f`) |
| WRAM7 | `$db28-$db53` | 44 |
| WRAM7 | `$db61-$db7f` | 31 |
| WRAM7 | `$db81-$dbff` | 127 |
| WRAM7 | `$dc0b-$ddc0` | 438 |
| WRAM7 | `$ddc2-$dddf` | 30 |
| WRAM7 | `$dde2-$ddff` | 30 |
| WRAM7 | `$de02-$deff` | 254 |

plus 29 shorter gaps (63 bytes) and 23 bytes of HRAM in twelve
one-to-four-byte holes. The bank `$06`/`$07` ranges at `$dc90-$deff` mirror
bank `$04`'s ball and minigame slots and stay untouched even in a doubles
match; `$d690-$d7ff` in bank `$04` is untouched everywhere.

The Test2 debug screens' glyph underrun (`docs/bugs.md`) sprays text pixels
over `$cb35-$cbff` in WRAM0 and `$db00-$db1f` in bank `$07`: free as far as
the retail game goes, but those debug screens write them.

### Cleared only

Written, but only ever with zero: they sit inside a block clear nothing else
reaches. All of WRAM bank `$05` is cleared by `ResetTextWindowState`
(`$05:$6e09`, two `ClearMemory16` runs of `$800` bytes from `$d000` and
`$d800`) every time a text screen starts; every WRAMX bank is cleared at boot
(`$01:$402c`-`$4075`); `$df00-$dfff` of each character bank is cleared at
match setup (`$08:$68a1`, `$38:$47f5`). Bank `$05`'s window-engine state is
what is named there (`$d800-$d8ff`, `$dc00-$dc7f`); the rest of the bank is
zeroed scratch. Usable, as long as the clear may take it back at the next
screen or match init. Eight bytes or longer:

| bank | range | bytes | cleared by |
|---|---|---|---|
| WRAM0 | `$c495-$c49f` | 11 | boot / screen init |
| WRAM0 | `$c778-$c77f` | 8 | boot / screen init |
| WRAM0 | `$c7d8-$c7ff` | 40 | boot / screen init; `$c7d8-$c7f7` holds data (save staging) |
| WRAM0 | `$c892-$c8a2` | 17 | boot / screen init |
| WRAM0 | `$c97c-$c9af` | 52 | boot / screen init |
| WRAM0 | `$c9b7-$c9bf` | 9 | boot / screen init |
| WRAM0 | `$c9e0-$c9ff` | 32 | boot / screen init |
| WRAM5 | `$d810-$d81f` | 16 | ResetTextWindowState, boot |
| WRAM5 | `$d870-$d87f` | 16 | ResetTextWindowState, boot; `$d872-$d87f` written by window code |
| WRAM5 | `$d890-$d8af` | 32 | ResetTextWindowState, boot; `$d892-$d896` written by window code |
| WRAM5 | `$db08-$db0f` | 8 | ResetTextWindowState, boot |
| WRAM5 | `$db14-$db53` | 64 | ResetTextWindowState, boot |
| WRAM5 | `$db61-$db7f` | 31 | ResetTextWindowState, boot |
| WRAM5 | `$db81-$dbff` | 127 | ResetTextWindowState, boot |
| WRAM5 | `$dc80-$ddc0` | 321 | ResetTextWindowState, boot |
| WRAM5 | `$ddc2-$dddf` | 30 | ResetTextWindowState, boot |
| WRAM5 | `$dde2-$de00` | 31 | ResetTextWindowState, boot |
| WRAM5 | `$de02-$deff` | 254 | ResetTextWindowState, boot |
| WRAM5 | `$df97-$dfff` | 105 | match setup ($df00 clear), boot |
| WRAM6 | `$df97-$dfff` | 105 | match setup ($df00 clear), boot |
| WRAM7 | `$df97-$dfff` | 105 | match setup ($df00 clear), boot |

### Holds data

Free bytes that are written with real values, each explained:

* `$c6e0-$c6ff`, `$c705`, `$c730-$c75f` and `$c7d8-$c7f7`: leftovers of the
  save engine's staging copy. `MirrorSaveHeaderToBank1` runs each 512-byte
  SRAM header region through `$c600-$c7ff` on its way to SRAM bank 1, so the
  tail of the block directory stays behind under the debug-menu variables
  (`wTextBuffer`'s note).
* `$d2b0-$d2ff` of bank `$07`: five glyph tiles the text engine writes
  *below* `wGlyphTileBuffer` when the pen goes negative, seen on the lesson
  menu's second page (`docs/bugs.md`).
* `$d83f` of bank `$05`: where a seventh nested menu's stack frame lands.
  `wMenuStack` holds six and `CreateMenuWindowFromText` does not check
  `wMenuDepth` (`docs/bugs.md`). `$d872-$d87f` and `$d892-$d896`, beside
  `wShortTextBuffer`, are written by the same window code.

Bytes once counted free that are now declared: record fields `+$2b` (speed
bonus, which `LoadCharacterAttributes` adds to the Speed stat), `+$0d`
(gender, in the match records too) and `+$2f` (write-only build tag) in all
eight `$40`-byte records; the game progress screen's five lists in bank
`$05`'s `$df00` page (`wProgressEntryUnlocked`, `wProgressVisibleEntries`,
...); and `$df84` of the character banks, `wCharSpriteSlotFrame`, where the
single-character screens park the frame descriptor after the sprite slot.

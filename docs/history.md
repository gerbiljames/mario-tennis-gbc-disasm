# Project history — the dated log (2026-07-09 to 2026-08-08)

This is the chronological working log that used to be `docs/STATUS.md`: every
session's findings, in the order they were found, with the reasoning that led
there. It is kept verbatim for reference, so numbers and names in it are as
they stood on the day and some have since been corrected (the subsystem docs
say where). The current state of the project is `docs/STATUS.md`.

# Project status — 2026-08-08

## Where things stand

**~160.9K instructions / 422,676 bytes of proven code+structured source
(20.2% of the 2 MiB ROM) disassembled; everything rebuilds byte-perfect**
(`make compare` → OK against SHA-1
`414ba58340a27fc27b127bc01455b32764151ff0`). 59 of 128 banks contain
code; the other 69 are data (graphics/audio/tilemaps/text) — but most of that
data is now *carved into named streams and records* rather than left as
anonymous blobs. The repo contains no ROM bytes: all data is extracted from a
user-supplied `baserom.gbc` by `./setup.sh` per `data.manifest`.

(The byte count is down 2,359 from the 2026-07-22 figure of 400,026: bank
`$06`'s two LZ payloads used to sit inside `records:2`/`bytes:14` data tables,
which the metric counted as structured source even though `dw`/`db` rows over
compressed graphics are not structure. They are now named `INCBIN` streams --
less "proven" by the counter, more correct in the source.)

**Every remaining anonymous blob has been classified as code, table, or data**
(see "Blob classification pass" below): a ROM-wide code-shape screen of all
5,000-odd INCBINs finds no uncarved code; what stays binary is graphics,
resource descriptors, record arrays, or fill. That screen missed eight
routines, all found later by the graphics-blob pass below -- it flagged
shape, not *twins*, and the shot banks are near-identical copies of each
other, so a routine only one bank failed to execute reads as ordinary data
until you diff it against its siblings.

Everything below is **committed** (HEAD `a6c7566`); the whole history
rebuilds byte-perfect. Per-bank progress at any time: `python3
tools/progress.py` (proven-code bytes, fill runs, label counts, human-named
counts) and `tools/progress.py --unnamed <bank>` to list still-auto-named
symbols. **20,391 of 21,971 labels are human-named** (up from 4,816 on
2026-07-23; the count went *down* on 2026-08-07 because 21 phantom labels
were deleted), and the remaining 1,580 are all generator-*derived* names --
`$4000` slot labels spelled after their curated target (`FarPtr_InitAndRunGame`)
and structures named for what they are (`SoundTable_78`). **No symbol anywhere
in `src/` states only an address any more**: `tools/progress.py`'s `auto` column
is 0, and `--unnamed <bank>` returns nothing for every bank.

### Local labels inside functions (2026-07-26)

`Label_bb_aaaa` is the generator's name for a jump target it found by descent.
Nothing distinguishes an intra-function loop head from a real entry point, so
until now every one of them was a *global* symbol -- 7,800-odd of them, each
one a wall the reader has to climb over mid-function.

They are now expressible as RGBDS **local labels**. A `labels.json` value that
starts with a dot (`"0x0492": ".queue"`) names a jump target inside the
function it sits in:

```
QueueVRAMCopy:
        ldh a, [rLCDC]
        add a, a
        jr c, .queue          ; LCD on -> queue the copy for VBlank
        xor a
        bit 5, d
        jr z, .setVramBank
        res 5, d
        inc a
.setVramBank:
        ldh [rVBK], a
        jp StartVRAMDMAFromHL
.queue:
        ...
```

**The scoping is resolved by the generator, not left to rgbasm.** A bare
`.name` in RGBDS binds to whatever global label precedes it, so the same name
in two functions is two different symbols -- which is the point (`.done` and
`.loop` repeat freely) -- but it also means a reference from *outside* the
owning function has to be spelled `Parent.name`. `LabelScopes` (in
`disasmlib/labels.py`) computes each local's owning global label, and the
emitter renders every *reference* through a qualified name table while
*definitions* keep the short form. Where two functions share a tail this shows
up directly in the source:

```
BeginFadeOut:
        ...
        jr nz, BeginFadeIn.done     ; the shared tail lives in the sibling
        jr BeginFadeIn.setSpeed
BeginFadeIn:
        ...
        jr z, .done                 ; same target, same-scope spelling
```

Getting a scope wrong is not silent: a bare `.name` that binds to the wrong
parent either fails to assemble or assembles to a different address, so
`make compare` is a real check on the whole scheme.

**3,949 local labels** are now named. The first pass worked down the ROM-wide
call-frequency list (everything called four times or more); a second pass then
took two whole subsystems to completion. What the names buy is mostly
structure that was previously invisible:

* **`DecompressData`** (220 callers) reads as the LZ decoder it is:
  `.nextControlByte` / `.nextFlag` for the 8-flag control byte, then
  `.match` -> `.match2` / `.match4` / `.match8` / `.match16` / `.matchTail`
  for the unrolled copy, whose lengths come from the low 5 bits of the match
  token being consumed one bit at a time.
* **`MulHLByA`** (21 locals) is a shift-and-add multiply that *dispatches on
  the highest set bit* of the multiplier: `.top7` ... `.top1` are the entry
  points, `.step6` ... `.step1` the per-bit shift-adds, `.finish6` ...
  `.finish1` the remaining doublings once the multiplier runs out, and
  `.mul128` the `a == $80` special case. `MulHLByAFrac` is its mirror image,
  scanning up from the *lowest* set bit (`.low0` ... `.low6`) and rotating
  right into a fractional result.
* **`AdvanceFrame`** (419 callers) splits cleanly into the normal frame wait
  (`.waitFrame` / `.haltLoop` / `.linkLoop`) and the SELECT+START debug
  single-step mode (`.stepLoop` / `.storeStepMode` / `.stepHaltLoop` /
  `.stepLinkLoop`), which is otherwise hard to see is a *second* frame-wait
  nested inside the first.
* **`CopyScrolledSceneTilemapToVram`** turns out to be one copy loop written
  twice -- once for the attribute plane (VBK 1, WRAM bank 2) and once for
  tiles (VBK 0, WRAM bank 3) -- which the `.attr*` / `.tile*` prefixes make
  obvious at a glance.

More of the same shape, further down the list:

* **`RunSoundChannelScript`** (50 locals) is the sound driver's command
  interpreter, and the opcode ranges now read off the labels: `.cmdA0` for the
  extended commands, `.cmdB0` loop counters, `.cmdC0` envelopes, `.cmdD0`
  volume slides, `.cmdF0` loop-point/end -- with `.setWaveId`, `.transpose`,
  `.setEcho`, `.loopBlock` and friends underneath.
* **The division helpers.** `DivHLByDE` is a restoring division with eight
  unrolled steps per result byte (`.hiBit6` ... `.loBit0`); `DivAHLByE` and
  `DivAHLByDE` are the 24-bit versions, one step per bit (`.bit22` ...
  `.bit0`). `AngleFromVector16` turns out to be a *binary search* down a
  tangent table -- `.sub7`/`.add7`/`.setBit7` per angle bit.
* **Bank `$3e`'s four menu-cursor grid walkers.** They are the same routine
  four times over -- local pad input, the link-frame input snapshot, and the
  remote player's input for cursor 1 and cursor 2 -- which only became obvious
  once `.wrapRight`/`.checkLeft`/`.storeDown` repeated verbatim in each. Three
  of the four had no name at all before this pass.

Naming the locals also flushed out a dozen **routines sitting unnamed next to
their callers**, since a local label can only exist inside a named function:
`WaitFadeEndLinked`, `QueueSpriteGrid`, `CopyMemoryReverseBC`,
`FillMemoryCFast`, `WriteStatModifierToTileBuffer`, `AddSignedDEToMem24`,
`DrawWindowGlyphRun`, `AllocWindowSlotBit`, `SendByteAwaitReplyMaster`,
`TestUnlockFlagById`, `MoveMenuCursorGridFromLinkInput_3e`,
`MoveMenuCursorGridRemote_3e`, `MoveMenuCursor2GridRemote_3e`, and the six
`Draw*ResultsHeader` handlers dispatched on `wGameMode` in bank `$1e`.

`tools/progress.py` used to skip every symbol containing a `.` (the macro and
text emitters generate their own `.L4`/`.s17` anchors). It now keeps the ones
whose offset is curated in `labels.json`, so named locals count toward the
naming metric -- hence 8,319 named, up from 6,800 with the same source.

### The character sprite banks are named, and the animation format decoded (2026-07-26)

`Data_*` is what is left auto-named, and the first 2,250 of them fell out
cleanly. **All 30 character banks (`$40`-`$5d`) share one layout**: 56 tile
blobs at `$4130`-`$7560` (240 bytes each, two strides of 240/320) and 19
animation scripts from `$7f4a`. So a blob's *address order* is a stable pose
index that means the same thing for every character -- `MarioSpriteFrame07`
and `PeachSpriteFrame07` are the same pose. Named accordingly:
`<Char>SpriteFrame00`-`55` and `<Char>SpriteAnim00`-`18`.

The index is address order rather than slot order deliberately: each
`*SpriteFrames` table has **145 slots over those 56 blobs**, because poses
repeat between animations (some appear in five slots). Slot order would need
five names for one blob.

**The animation scripts are 2-byte entries**, confirmed against both
interpreters:

| entry | meaning |
| --- | --- |
| `nn dd` (`nn` < `$f0`) | show frame `nn` for `dd` frames |
| `ff dd` | loop: restart at the script base + `dd` |
| `fe aa` | switch to animation `aa` |
| `fb mm` | XOR the flip bits with `mm` (match characters only) |

Two interpreters read them: `AdvanceActorAnimation` (bank `$04`) for overworld
actors, and `StepCharAnimation` (bank `$08`) for on-court characters -- only
the latter implements `$fb`, which is why the flip command appears in the
character banks and not in the overworld ones. Decoded, `AlexSpriteAnim01` is
`02 0c 04 06 03 0c 04 07 ff 00` = frames 2,4,3,4 held 12/6/12/7 frames, looping
from the top. 569 of the 570 render as `anim_*` macros rather than `INCBIN`
(`sprite_anim` spec + macros in `macros.py`), so an animation reads directly:

```
AlexSpriteAnim03:
        ; $7f5d, 34 bytes (sprite_anim)
        anim_flip $20
        anim_frame $17, $14
        anim_frame $18, $0a
        ...
        anim_flip $00          ; the same seven frames again, mirrored
        anim_frame $17, $14
        ...
        anim_loop $00
```

The renderer returns `None` on an odd length or an unimplemented command, so a
mis-declared region falls back to plain bytes rather than rendering a lie.

**The 267 code-loaded blobs are named after the function that loads them.**
A loader's name already says what the data is for, so `LoadMenuHandCursorGfx`'s
blob becomes `MenuHandCursorGfx`, `LookupScreen0AssetId`'s becomes
`Screen0AssetIdTable`, and a loader that pulls several numbers them in address
order (`RulesBorderAnimTiles0`-`5`). 246 of them replaced a *pinned* auto-style
name -- `labels.json` holds 326 entries that force a label at an offset using
the `Data_`/`Gfx_` convention, and those are exactly the ones worth replacing.

What remains auto-named, by family:

| count | family | to name it you first need |
| --- | --- | --- |
| 1,095 | blobs under `OamPtrs_*` tables (banks `$6a`, `$6f`-`$77`) | the OAM tables named -- i.e. which NPC each sprite set belongs to |
| ~~479~~ 212 | not in any `dw` table | **done for the 267 loaded from code** -- see below; 93 unreferenced remain |
| 363 | `$4000`-table slot targets | nothing: slot names auto-derive, so naming the blob improves both |
| 351 | `SoundTable_*` entries (banks `$0c`, `$78`-`$7f`) | the sound-id tables mapped to `PlaySound` ids |

### No `Label_*` is left in the ROM (2026-07-26)

`grep -c '^Label_' src/*.asm` is **zero**. Every jump target the disassembler
found by descent now has a curated name: **7,700 are local labels** scoped to
the function they sit in, and the rest became functions -- code that was only
ever reached by a `jr`/`jp` and so never got a `Func_` name of its own. Only
`Data_*` (4,178 data runs) remains auto-named, which is the next frontier.

The last two thirds went bank by bank with a generator rather than by hand:
`auto.py` proposes a name per label (followed only by `ret` -> `.done`; jumped
to from a *later* address -> `.loop`; block opens with `call Foo` -> `.foo`;
opens by reading `wFoo` -> `.checkFoo`; `xor a` + store -> `.clearFoo`), and
roughly a fifth then needed a hand name. Two structural rules mattered:

* **Never name a label whose enclosing global is a data symbol.** It would
  render `ServiceMatch2JudgePointDrillShotTable.rally1` -- worse than the auto name. Bank
  `$0b`'s 296 stragglers were all of this shape: each drill `*JudgePoint`
  routine has its per-result case blocks *after* the table it indexes. Naming
  the block (`ServiceMatch2Cases1`, from the routine that references the
  table) turned them into ordinary functions, and their labels into locals.
* **The filter for "is this owner a data symbol" has to be anchored.** A
  substring test skipped `HandleTennisDictionaryListInput`,
  `LoadCutsceneAnimFrameGfx_00_08` and every `FetchText_*` -- all real
  functions -- because their names merely contain `List`/`Gfx_`/`Text_`.

### The match engine and story mode (2026-07-26)

**Fifteen banks are now completely free of auto-named labels**: the match
engine (`$04` actors/AI, `$07` shot physics and the serial link, `$08` the
match simulation, `$09` court objects) and story mode (`$0a` the overworld
loop, `$0e`-`$15` the location scripts, `$18` screen sequences, `$38`
character select and link setup). `grep -c '^Label_' src/bank_0{04,07,08,09,0a,0e,0f,10,11,12,13,14,15,18,38}.asm`
is zero across all of them.

What surfaced on the way through:

* **The serial link is a nibble protocol.** `ExchangeNibbleBlockMaster` and
  `ExchangeNibbleBlockSlave` are mirror images: handshake, then one nibble per
  serial round with a 2-bit tag in the top bits, then a checksum compare that
  restarts the whole block (`.startBlock`) on a mismatch. `UnpackBytesToNibbles`
  / `PackNibblesToBytes` are the codec either side of it, and
  `ExchangeChecksumMaster`/`Slave` shift the checksum across four nibbles.
* **`StepCharMovement` refuses moves rather than clamping them.** Each axis is
  stepped into a scratch register first; if the result leaves the playable box
  the step is dropped and bit 6 of `wCharFlags` is set (`.blockX` /
  `.blockDepth`), which is what makes a character slide along a wall instead of
  stopping dead.
* **The AI is a phase machine.** `AiChoosePositionByStrategy` dispatches to
  `.behindLanding` / `.lateralMove` / `.midCourt` / `.nearNet` / `.adaptive`,
  and each phase ends by calling `AiAdvancePhase` -- which is why the
  otherwise-anonymous `Label_08_796c` turned out to be a shared no-op tail
  (`AiPhaseNoop`) that several jumptable slots point at.
* **`RunStoryLocation` is the whole overworld loop** in one function:
  `.runInitScript`, `.fadeIn`, then a `.frameLoop` that checks, in order, an
  exit request, a menu request, an interact request, the facing tile, the tile
  the player stands on, and finally the debug menu.
* **Bank `$3e`'s four cursor walkers have twins in `$38`, `$3b` and `$18`.**
  Naming the locals made the duplication impossible to miss: eight copies of
  the same `.wrapRight`/`.checkLeft`/`.storeDown` walk, differing only in which
  input source they read and which cursor variable they write.

The tail of each bank was finished with a small generator
(`auto.py`/`refine.py` in the scratch dir): a label followed only by `ret` is
`.done`, one jumped to from a *later* address is a `.loop`, and the rest are
named from the first instruction of their block (`script_speak` -> `.speak`,
`script_set_position` -> `.placeActors`, ...). Roughly a fifth needed a hand
name afterwards. Collisions inside one scope get a numeric suffix, which is
why a few `.placeActors2`/`.applySlot2` names appear.

That generator left **1,894 locals as a bare `.step`** -- its fallback when no
rule matched. A follow-up pass cut those to **138** by naming each from the
*branch condition that reaches it*, which is both more informative and
checkable against the source:

| reached by | name |
| --- | --- |
| `cp a, $05` + `jr z` / `jr nz` | `.eq05` / `.ne05` |
| `cp a, $05` + `jr c` / `jr nc` | `.lt05` / `.ge05` |
| `bit 7, h` + `jr z` / `jr nz` | `.positive` / `.negative` |
| `bit 4, a` + `jr z` / `jr nz` | `.bit4Clear` / `.bit4Set` |
| `or a, a` + `jr z` / `jr nz` | `.zero` / `.nonZero` |
| `test_flag FLAG_DOUBLES` + `jr z` | `.notDoubles` |
| `add a, l` + `jr nc` | `.gotPtr` |

Where a label has several reference sites there is no single condition, so the
block itself is used instead: a leading `call Foo` gives `.foo`, a store to a
named variable gives `.storeFoo`, `xor a` + `ldh [hFoo], a` gives `.clearFoo`.
Repeated exact shapes across the drill banks (`xor a / ret` -> `.returnZero`,
`ld a, [$c2e3] / rst Rst00` -> `.dispatchStage`) went last.

The 138 that remain are genuinely hard -- unrolled math and rendering steps
with nothing to distinguish one from the next -- and 15 of them are
deliberate: `MulHLByA`, `AngleFromVector` and `AngleFromVector16` use
`.step6`...`.step1` as a *bit index*, keyed to the `.topN`/`.finishN` names
around them. The sweep briefly rewrote `MulHLByA`'s as `.noCarryN`, which was
true of the branch but lost that index; they were restored.

At the time of this pass 3,813 `Label_*` were still left, in the menu/UI banks
(`$05`, `$1a`-`$1e`, `$39`-`$3f`), the minigame banks (`$0b`, `$0d`, `$17`) and
ROM0; the generator pass above finished those off.

Process notes worth keeping:

* A bare flat offset in `labels.json` is `bank*0x4000 + cpu - 0x4000`, not
  `bank*0x4000 + cpu`. Two entries were written with the wrong formula, landed
  past the end of the ROM and were **silently dropped** -- the build stayed
  byte-perfect because the label simply never emitted. The apply path now
  rejects offsets past 2 MiB and accepts a `bb:aaaa` form instead.
* A curated *global* label placed inside a data blob splits that blob, so the
  manifest grows a file `data/` does not have and the build dies with "No rule
  to make target". Put the label on the routine's first code byte. Related:
  `make compare 2>&1 | grep OK | tail -1` **cannot fail** -- `tail` always
  exits 0 -- so a verification wrapper has to test the grep itself.
* A curated name at an offset that never emits (a wrong bank in `labels.json`)
  used to break silently *and* corrupt scoping: `LoadActorObjectDefChecked`
  sat at `$14ac3` when it meant `$10ac3`, so locals scoped to it emitted
  `Parent.local` references rgbasm could not resolve. The emitter now checks
  every local's owning global was actually written, and fails naming the
  offending offset.
* Two locals with the same name under one global label are an rgbasm
  redefinition error. This bites where a function is followed by *unnamed*
  sibling routines, because their `Label_` heads sit in the same scope; the
  fix is to name the sibling, not to invent a unique local name.

### No `Func_*` label is left in the ROM (2026-07-25)

Every function in the disassembly now has a curated name: the last **61
`Func_bb_aaaa` labels** across 24 banks were named from their call sites, and
the count is **zero ROM-wide** (`grep -c '^Func_' src/*.asm`). What remains
auto-named is `Label_*` (7,804 local jump targets, not worth naming) and
`Data_*` (4,287 data runs) -- the latter is now the biggest naming frontier.

The pass was one read per function plus its callers. Some highlights, since
each name is only as good as its evidence:

* **Bank `$02`'s stat pipeline.** `RecomputeCharacterStats` runs each raw stat
  through `ScaleStatForBarLevel` (`stat * 5 - (record[$18] - 1)`, clamped to
  ±$7f) and then `LookupStatBarLevel`, which walks 9 signed thresholds and
  returns how many the value clears -- the 0-9 bar level stored at record
  `+$20`/`+$21`/`+$22`. `CheckStorySignatureCollision` (`$42d6`) is the
  uniqueness test behind `GenerateUniqueStorySaveSignature`: it returns `$ff`
  when the candidate 4-byte signature is all-zero or already matches one of
  the three save slots' signatures at `$d400`/`$d404`/`$d408`.
* **Bank `$03`'s scrolling cutscene text.** `PlayScrollingStoryCutscene` gets
  its four helpers: `DrawCutsceneTextPage` (looks the page up in
  `TextPageDescriptors_03`), `DrawCutsceneTextLines`, `ScrollCutsceneTextWindow`
  and `BlitCutsceneTextWindow` (copies the visible 20x8 window out of the tall
  WRAM-bank-1 text buffer and queues it to the window map at `$9c00`).
* **The win/lose screen's four marker queuers** (`$16:$4d96`-`$4dc7`). Read
  together with `QueueResultPortraitTop`/`Bottom` they decode cleanly: tile
  block `$00` is the *player's* portrait (it always blinks, palette 0↔2 on
  `hVBlankCounter` bit 4), `$20` the opponent's, and the winner is always drawn
  top-left. The single-sprite markers pair with them by position -- tile `$40`
  beside the top-left portrait, `$42` beside the bottom-right -- so the four
  are `QueueWinnerMarkerForPlayer`, `QueueLoserMarkerForPlayer`,
  `QueueWinnerMarkerForOpponent` and `QueueLoserMarkerForOpponent`.
* **Bank `$18`'s confirm screen.** `InitConfirmScreen` builds the box, font,
  cursor and score panel; `DrawYesNoLabels` writes the two 3x2 tile words
  (`$dd,$de,$df` over `$ed,$ee,$ef`, and `$bd,$be,$bf` over `$cd,$ce,$cf`) into
  rows `$d9e1`/`$da01` with their attribute rows. Its caller renders text ids
  `$046a`/`$046b`/`$046d`/`$0471` = `31:106`/`107`/`109`/`113` = "Erase?",
  "Erase it? Really?", "Continue?", "Is this correct?".
* **Bank `$39`'s two shared menu helpers.** `LoadMenuArrowSpriteTiles` loads
  tile blocks `$17`-`$1a` (4 tiles each) into consecutive VRAM destinations --
  the four arrow directions bank `$3b`'s scroll-arrow task queues with
  `h = $00`-`$03`; `LoadMenuSpritePalettePair` points two OBJ palette slots at
  the same 4-colour palette.
* **Mechanism-only names where the meaning isn't pinned.** Bank `$17`'s three
  briefing-diagram sprites are `DrawBriefingMarkerHFlip` / `VFlip` / `Rotated`
  (they differ only in which OAM flip bits a state byte selects), and three
  routines with no reader or no caller are marked as such:
  `Unused_02_CharIdRemapLookup` (+ its table), `Unused_05_SetTextVar` (writes
  `$d85d`, which nothing reads) and `Unused_06_DrawMusicMenuRow`.

Stubs follow the existing convention (`StubNop_<bank>_<addr>`): five more bare
`ret`s picked one up (`$07`, `$1a`, `$1b`, `$24`, `$3b`).

### Bank $1e's reward tables were data all along (2026-07-25)

The 61st "function", `Func_1e_6d82`, was not code: `CheckAllProgressComplete`
reads it as **36 two-byte game-flag ids**. Pulling that thread found three
pointer tables in bank `$1e` -- named `RewardSubHandlers{A,B,C}_1e` by an
earlier pass -- whose targets are all data, plus a
`coverage/bank01e_static_code.json` entry that had seeded **12 of those data
addresses as static code entries**. 250-odd bytes of the bank were decoding as
nonsense instructions (`ld [$0ae0], sp`, stray `nop` runs) with two blobs
(`Data_1e_6d99`, `Data_1e_6ded`) carved out of the middle of them.

What the three tables actually hold, from the code that reads them:

| table (was) | now | targets |
| --- | --- | --- |
| `RewardSubHandlersA_1e` `$66f7` | `FirstClearExpTablePtrs_1e` | 3 x 25-entry `dw` EXP tables (`GetFirstClearRewardExp` returns the word in `de`) |
| `RewardSubHandlersB_1e` `$6d14` | `RewardFlagListPtrs_1e` | 3 flag-id lists (`SetRewardGameFlag`/`TestRewardGameFlag` pass the word to `SetGameFlag`/`TestGameFlag`) |
| `RewardSubHandlersC_1e` `$7445` | `RewardCategoryEntryListPtrs_1e` | 6 `$ff`-terminated entry-id lists (`RunRewardCategoryList` walks them into `$df10`) |

All three are selected by `wCurrentMinigameStoryMatch` byte 0 (the mode) and
indexed by `GetRewardTableIndex`, so the flag lists and the EXP tables are
`Mode0`/`Mode1`/`Mode2` siblings of each other.

**A new `flag_ids` data-table spec** renders the lists the way the rst
`set_flag`/`test_flag` pseudo-ops print their operands -- low byte = bit << 5,
high byte = flag byte index:

```
RewardFlagListMode2_1e:
	; $6d96, 60 bytes (flag_ids)
	dw $1800 ; 0: flag $18, 0
	dw $1820 ; 1: flag $18, 1
```

Mode 2's list is exactly flags `$18` bit 0 through `$1b` bit 5 in order --
30 sequential unlock bits, which is what makes the mis-decode obvious in
hindsight.

**Two views deliberately share storage**, which the source can only segment one
way: `ProgressEntryFlagList_1e` (`$6d80`, what `TestProgressEntryFlag` indexes)
is one entry ahead of `AllProgressFlagList_1e` (`$6d82`, the 36 flags
`CheckAllProgressComplete` requires), and that 36-entry span runs on through
`RewardFlagListMode2_1e`. The labels mark each entry point; the overlap is
recorded here rather than in a comment the generator would overwrite.

### Bank $1c's character-data screen tables (2026-07-25)

With no `Func_*` left, `Data_*` is the frontier -- 4,287 labels, but 3,600 of
them are the OAM/frame arrays of the sprite and object banks. The interesting
ones live in the UI banks, and bank `$1c` (the character-data screen) is now
done: **48 labels**, and no `Data_1c_*` is left in the bank.

They are all one shape. `BlitTilemapRunsFromTable` walks 4-byte records
(`dest offset hi, lo, source index, length`, `$ff`-terminated) and copies runs
into a tilemap band; the screen has **nine bands** and each is revealed a step
at a time, so the tables form a band x step grid:

| band | dest | steps | drawn by |
| --- | --- | --- | --- |
| 0-3 | `$d240`/`$d280`/`$d2d0`/`$d310` | 6-7 | `AnimateCharDataStatsReveal`, and the last step by `SetupCharDataScreen`/`DrawCharStatRows` |
| 4-6 | `$d370`/`$d380`/`$d3a0` | 3 | the reveal's second phase |
| 7-8 | `$d3e0`/`$d410` | 3-4 | `CharDataScreen_InputLoop`, forwards to open the confirm prompt and backwards to close it |

Hence `CharDataBand<N>RunsStep<M>_1c`, with the step number in animation order
(step 1 is the smallest run list, the last step is the full band). The four
D-pad tables `MoveCharDataScreenSelection` indexes by the current page are
`CharDataPage{Up,Down,Left,Right}Targets_1c` (`$ff` = no move).

**Nine labels in banks `$17`/`$1c`/`$1d` were not pointers at all.** They came
from `ld de, imm` sites feeding `QueueSprite`, whose `de` is a *screen
position* (`d` = x, `e` = y) -- so `ld de, $7a0c` was rendered
`ld de, Data_1d_7a0c` and the label split a graphics blob at a meaningless
offset. Dropping the nine merges three blobs back together (bank `$17`'s
`d_4f02`/`d_508c` into one 1,637-byte stream, bank `$1c`'s `d_59cc`/`d_5c44`
likewise) and the operands read as the coordinates they are. The generator's
own pointer-load gate still accepts a `push de` after such a load as evidence
(six labels in bank `$1a`), which is the remaining instance of this shape.

One table came out of the wash: `CharDataPageRightTargets_1c` is 5 bytes, not
the 69 the blob boundary implied. The 64 bytes after it are 26 words stepping
by `$40` (`$6880`-`$7040`) that nothing in the ROM reads, now `Unused_1c_0`.

### Bank $3e's menu tables, and two helpers hiding in them (2026-07-25)

Bank `$3e` (court select, match rules, racket/shoe choice, equipment) is the
second `Data_*` bank cleared: **45 tables named**, and the naming falls out of
the routine that indexes each one, because every menu in the bank is built the
same way. A cursor task reads three parallel tables by cursor index --
`<Menu>CursorPositions` (y,x pairs), `<Menu>CursorTiles` (the `c` argument to
`QueueSpriteTemplate`) and `<Menu>CursorAttrs` (the `b` argument) -- while the
tab highlighter reads a list of shadow-attrmap addresses
(`<Menu>TabAttrAddrs`). The two court-select variants (4 courts and 9) each
have a full set, plus a `<Menu>LabelYOffsets` table whose byte becomes
`hl = value << 8 | $f8` added to the cursor position -- the offset to the
court-name sprite drawn beside it.

`ComputeUnlockedCourtFlags`' table is five game-flag ids (`$07` bits 5 down to
1), so it renders under the `flag_ids` spec added for bank `$1e`.

**Two of the 47 were not tables.** `$43db` and `$440b`/`$4421` are
*byte-identical* relocated copies of bank `$3b`'s `GetCellIndexFromCursorPtr`
(`$43cb`) and `ClearWram3Row64` (`$43fb`) with its `ld a, $00` twin -- the two
menu banks share a helper prologue, shifted `$10` in `$3e`. Nothing in the ROM
references the `$3e` copies, so descent never reached them and they sat as
`Data_` blobs decoding as garbage. They are seeded in
`coverage/bank03e_static2.json` (which already carried seven neighbouring
stranded heads) and named; byte-identity with an already-named routine is what
makes that seed safe, per the caution in the bank `$1e` section above.

### Story flags named, pokecrystal-style (2026-07-25)

`wGameFlags` (`$c9c0`) is the game's event-flag array and it was one line in
the RAM map. It is **32 bytes / 256 flags**, saved as the story slot's `+$1c0`
block, and the three rst vectors address a bit as `d` = byte, `e` = bit `<< 5`
(mask `$80 >> bit`). The `*GameFlagByNumber` wrappers (`$00:$24ef`) shift a
flat **flag number** (`byte * 8 + bit`) into that pair -- which is exactly
pokecrystal's `wEventFlags` / `EVENT_*` numbering, so the same shape works
here:

| pokecrystal | here |
| --- | --- |
| `constants/event_flags.asm` (`const_def` + `const EVENT_*`) | `flags.json` -> generated `include/flag_constants.inc` (`def FLAG_* equ <number>`) |
| `wEventFlags:: flag_array NUM_EVENTS` | `wGameFlags` + `wGameFlagsTemp`, documented as one 32-byte array |
| `checkevent EVENT_FOO` | `test_flag FLAG_FOO` |
| first 8 events reset on map reload | flags `$e0-$ff` (bytes `$1c-$1f`) zeroed by `ClearTemporaryStoryFlags` on every location load |

`set_flag`/`clear_flag`/`test_flag` now take **either** form -- `test_flag
FLAG_DOUBLES` where the flag has a name, or the old `test_flag $05, 7` where it
does not (`IF _NARG == 1` in the macro reassembles the same two operand bytes),
and a new `flag_id` macro does the same for the bank `$1e` flag-list tables.
**820 of the 984 rst sites now read symbolically**; the 164 left are the
engine-internal bits (text/VRAM/window state in bytes `$01-$04`) that want
their own pass.

**86 flags named**, and the interesting part is that two independent
derivations agreed. Working only from the code:

* The three bank `$1e` reward lists are indexed by `GetRewardTableIndex`, so
  list entry *k* is "the flag for story match/drill *k*" -- that alone orders
  the class ladders (`$08`-`$0b`), the Island Open rounds (`$06`/`$07`) and the
  30 training-drill clears (`$18`-`$1b`).
* The drill ids were already pinned by the 2026-07-25 drill pass, and
  **flag number = 192 + drill id** falls straight out: `SetupWallPracticeLevelSigns`
  tests flags `$d6`-`$d9` = ids 22-25 = "Wall Lvl 1-4", `ComputeMachineCourtProgress`
  tests `$d2`-`$d5` = ids 18-21, and bank `$15`'s three practice coaches test
  exactly the contiguous triples of their own drill family.

Then the RetroAchievements notes already sitting in `ram_map.json` for the same
bytes (`wStoryModeMinigameCompletionFlags1-4`, `...MatchCompletionFlags1-6`,
`...EquipmentFlags1-2`) turned out to describe **the same bits**, in the
opposite bit convention (their "Bit N" is mask `1 << N`, i.e. this engine's bit
`7 - N`). Every drill flag matched; the ranks and equipment corrected my
first-pass guesses:

* The rank ladders count **down**: `$0a,0` is Junior Rank 4 (the first
  opponent) and `$0a,3` Junior Rank 1 (the champion). Singles has 4 ranks per
  class, doubles 3 -- which is why the doubles reward list starts one entry
  later than the singles one.
* Bytes `$0c`/`$0d` are **equipment owned**, not progress:
  `FLAG_HAVE_LARGE_RACKET` ... `FLAG_HAVE_LIGHT_SHOES`. That explains the
  cluster nothing ever `test_flag`s: `RunRepairCounterDialogue` and
  `ApplyClassProgressRule1/2/3` hand out rackets and shoes on each class
  clear. It also settles the swing contest -- bank `$15` checks
  `FLAG_HAVE_SILVER_RACKET`/`FLAG_HAVE_GOLD_RACKET`, skips the reward if you
  own either, and otherwise needs 100 swings.
* `$06,4`/`$07,3` are the **Dream Match** (the Mario-cast final), not another
  Island Open round.

**The one odd flag site turned out to be dead code (resolved 2026-07-26).**
Bank `$07`'s `ModeHookTable_07` slot 4 set `FLAG_HAVE_SILVER_RACKET` on a
ball-hit event, which made no sense next to bank `$15` handing the racket out
for the swing contest. The table belongs to a **self-contained target-zone test
mode** at `$5ea1`, now `RunTargetZoneTestMode_07`, and nothing in the game
reaches it:

* no word `$5ea1` exists anywhere in bank `$07`, so no table dispatches to it;
* no `$4000` farptr slot points at it, which is the only way another bank could
  farcall in;
* no execution trace ever entered `$5ea1-$5f93` -- the traces stop at `$5e9d`,
  the `farcall RunMatch` in its neighbour `RunDebugTestMatch` (itself reachable
  only from bank `$01`'s debug menu). The region is in the source at all only
  because `coverage/bank007_static_code.json` seeds it.

It is plainly test scaffolding: it forces court 2, two on-court characters,
Mario (`$1a`) against Yoshi (`$1c`), enables `wTargetZoneEnabled`, and calls
`RunN64ExhibData` -- a *menu screen* -- in the middle of the match setup. Its
hooks are a small target-practice loop: point-start places the ball gate and
the first target zone, the bounce hook re-rolls the zone through
`AdvanceMatchRng` whenever the ball lands inside it, point-end shows a message
window and aborts once the two ace counters diverge, and the ball-hit hook
raises a **hit-stop request** that the routine now called
`TargetZoneHitStopHook_07` consumes by freezing `wMatchSimFrozen` for 20 frames
-- except the table's per-frame slot points at the bare `ret` in front of it
(`ModeHookNop_07`), so even in the dead mode the effect is switched off.

So the bit is genuinely the Silver Racket flag; this mode just borrows the
storage. Rather than let the name assert a meaning that is wrong there,
`flags.json` grew a `_raw_sites` list: the three sites keep the numeric
`test_flag $0c, 4` form while every real story site stays symbolic.

**Correction (2026-07-26):** this section first claimed the training-court
coach labels `InitServeCoachScene`/`InitNetCoachScene` were "one family out of
step" with flags `$bd`/`$be`/`$bf`. They are not -- the labels are right and
the claim was an artefact of the flag-inventory script, which attributed each
`set_flag` to the nearest preceding *top-level* label. The three flags are set
inside `rst $00` jumptable-target fragments that happen to sit after the
previous coach's `Init` routine, so each setter was credited to the wrong
function. Each fragment in fact opens with `call Init<X>CoachScene`, and the
whole chain agrees per actor:

| actor | init scene | lessons | flag | NPC script |
| --- | --- | --- | --- | --- |
| `$07` | `InitServeCoachScene` | `ServeCoach{Junior,Senior,Varsity}LessonScene` | `FLAG_SERVE_COACH_GREETED` | `TrainingCourtNpc07_15`, which branches on Service Practice 1-3 |
| `$12` | `InitNetCoachScene` | `NetCoach{Volley,Smash,DropShot}LessonScene` | `FLAG_NET_COACH_GREETED` | `TrainingCourtNpc12_15`, Net Game Practice 1-3 |
| `$0d` | `InitReturnCoachScene` | `ReturnCoach{Return,Lob,PassingShot}LessonScene` | `FLAG_RETURN_COACH_GREETED` | `TrainingCourtNpc0D_15`, Stroke Practice 1-3 |

The flags are renamed onto the bank's own Serve/Net/Return coach vocabulary
(they had been named after the drill family instead), and the three fragments
that set them -- entry 0 of each coach's result-dispatch table, the first-visit
branch -- are now `ServeCoachIntroDialogue_15`, `NetCoachIntroDialogue_15` and
`ReturnCoachIntroDialogue_15` rather than bare `Label_15_*`. The lesson for the
next flag pass: attribute a `set_flag` to the fragment that *reaches* it, not
to the nearest label above it.

### The rest of the flags, and the save-flag array (2026-07-26)

**Game flags: 120 named, 979 of the 984 rst sites symbolic.** The engine bits
in bytes `$01`-`$06` fell out once `RunDebugFlagEditor` (`$05:$65a2`) was read
properly: it is a full **256-bit editor** -- three windows of hex, a D-pad
cursor, A to toggle, START to page through four pages of 64 -- and
`DebugToggleSelectedFlag` feeds `page * 64 + row * 8 + col` straight to
`Set/Clear/TestGameFlagByNumber`. So **a flag with no writer anywhere in the
ROM is a developer switch**, not dead storage, and each one's single test site
says what it does:

| flag | effect when set |
| --- | --- |
| `FLAG_DEBUG_NOCLIP` (`$02,0`) | `UpdatePlayerControl` jumps past every `IsPointBlocked` probe -- wall collision, the ±$20/$40 slide checks and the blocked-tile event trigger |
| `FLAG_DEBUG_SHOW_PLAYER_POS` (`$04,0`) | `DrawPlayerPositionDebugOverlay` draws instead of returning |
| `FLAG_DEBUG_KEEP_MATCH_SETTINGS` (`$04,1`) | `LoadMatchSettingsFromTable` skips the table read |
| `FLAG_DEBUG_SKIP_LOCATION_EXIT` (`$02,5`) | the bank `$10` story flows save but never request the location exit |
| `FLAG_DEBUG_FREEZE_TILE_ANIM` (`$03,2`) | second inhibit gate in `UpdateSceneTileAnimations` |
| `FLAG_DEBUG_STATIC_TEXT_WINDOW` (`$03,3`) | suppresses the text-window redraw and moves the continue arrow |

The rest are ordinary engine state -- `FLAG_VRAM_UPDATE_BUSY` (`$03,0`, set
around every bulk tilemap write, and the reason tile animation pauses),
`FLAG_TEXT_RENDER_ACTIVE`, `FLAG_PROPORTIONAL_TEXT_MODE`,
`FLAG_PLAYER_RUNNING` (B held), `FLAG_HIDE_OVERWORLD_ACTORS` -- plus a run of
per-location scene bits. Two of those turned out to be **singles/doubles pairs
selected by `FLAG_DOUBLES`**, the same shape as the rank ladders: the awards
ceremony (`$10,3`/`$10,4`), the tournament courtyard NPC (`$0e,6`/`$0e,7`) and
the Court 2 spectators (`$0f,0`/`$0f,1`) each have one flag per match format.

Only `$01,6`/`$01,7` are left raw: `InitStoryModeState` clears one and sets the
other, and nothing in the ROM ever reads either -- not through the rst vectors,
not by number, and not as a byte.

**Save flags: the global array is now symbolic too.** SRAM `$a040-$a05f` is a
second 256-bit array with the same `d` = byte / `e` = bit `<< 5` addressing,
reached through `Test/Set/ClearSaveFlag` (bank `$03`). 47 `SAVEFLAG_*`
constants now cover it, all 53 immediate call sites render by name, and the
three id tables render under a new `save_flag_ids` spec.

`MinigameClearFlagTable_1e` settles the layout: `SetMinigameClearFlag` indexes
it by `(minigame id - $1c) * 3 + level`, and its 27 entries run from flag 20
upward, **skipping byte `$04`** -- which is exactly where the per-slot story
flags live (`EraseStorySlotSaveData` clears `$04,0`/`$04,4` for slot 0,
`$04,1`/`$04,5` for slot 1, `$04,2`/`$04,6` for slot 2). Laid against the
RetroAchievements notes for the same bytes, all 27 match bit for bit: Boo
Blast, Shooting Star, Perfect Shot, Target Shot, Fruit Fantasy, Banana Bunch,
Treasure Box, Medallion Match, Two-On-One, three levels each.

The nicest part is what that collides with. `CheckCharacterUnlocked`
(`$18:$452a`) returns "unlocked" for character ids 0-3 and otherwise tests
**save flag number = character id**. Numbers 0-31 are therefore *both* the
minigame-clear flags and the character-unlock bits -- clearing Shooting Star
Lvl 1 does not merely unlock Luigi, it *is* Luigi's unlock bit (id `$17` = 23).
The whole roster falls out of the overlap: Shooting Star 1/2/3 -> Luigi /
Donkey Kong / Baby Mario, Perfect Shot -> Mario / Waluigi / Yoshi, Target Shot
-> Bowser / Wario / Peach, and the N64 transfer records (`ApplyN64RecordsUnlockFlags`)
grant flags 10-13 = Fay, Curt, Mark and Sean. It also explains
`ApplyUnlockEverythingCheat`: it sets levels 1 and 2 of every minigame and
skips level 3, so the level-3 characters stay locked.


**SRAM naming followed from it.** The array had no symbol at all: `$a040` was a
bare literal at its four bank `$03` sites, and the five RetroAchievements byte
names sat in `ram_map.json` at *global* scope -- the hazard the SRAM header and
block directory are already scoped against, since a dozen banks use `$a0xx` as
VRAM-bank-1 copy destinations. It is now one scoped union (bank `$03`):
`sSaveFlags` (`$a040`, 8 bytes) carrying the byte-by-byte layout, and
`sSaveFlagsUnused` (`$a048`, 24 bytes) -- **only 64 of the 256 bits exist**.
Every immediate id in the ROM is `$01xx`-`$07xx` and the three computed callers
are bounded (character ids stop at `$1f`, `MinigameClearFlagTable_1e` and
`UnlockConditionFlagRows_03` both at #54), while `ClearSaveFlagsArea` zeroes all
32 bytes. `docs/save_format.md` now carries the full table.

`UnlockConditionFlagRows_03` deserves its own line: its nine bytes are
`$16 $19 $1c $1f $2a $2d $30 $33 $36` = flags 22, 25, 28, 31, 42, 45, 48, 51,
54 -- the **level-3 flag of each of the nine minigames**, in table order, which
is a third independent confirmation of the run. Bank `$18`'s sibling
`CheckUnlockFlag` reads a 32-entry table that would pick per-entry between the
game-flag and save-flag arrays (bit 0 of the id selects), but the table
(`UnlockFlagIds_18`, `$18:$458a`) is **all zeros** in the retail ROM, so it
always reports "no condition".

One process note: the byte-perfect compare caught the union's `end` field being
off by one (it is exclusive, and the extra byte pushed `sSaveBlockDirectory` to
`$a061`, changing 126 assembled bytes in `InitSaveHeader`). RAM metadata is not
supposed to be able to break the build, and it did -- worth remembering that
symbol *addresses* feed real operands.

### The generator split into `tools/disasmlib/` (2026-07-25)

`tools/disasm.py` had grown to 4,668 lines around one 1,500-line `Disassembly`
class and one 740-line `emit()`. It is now a 71-line command line over a
package, with no change to its behaviour: regeneration produces
**byte-identical** `src/` and `data.manifest`, and `make compare` still passes.

The split follows the three stages the tool already ran in:

| stage | modules |
| --- | --- |
| analysis | `core.py` (decode, seed, descend, farcall/jump-table inference), `slots.py` ($4000 data-slot proving), `carve.py` (structure carving + stub-shape code recovery), composed in `disassembly.py`, ordered by `pipeline.py` |
| naming | `labels.py`, `ram.py`, `config.py`, `seeds.py` |
| emission | `emit.py`, with `operands.py`, `idioms.py`, `datatables.py`, `macros.py`, `constants.py`, `textids.py` |

`emit()` became an `Emitter` whose construction resolves the output-global
facts (which offsets are table slots, which blobs anchor labels, what each is
named) and whose `run()` renders bank by bank through one `_emit_*` method per
kind of offset. Its two duplicated data-table dispatch chains collapsed into
`_render_table_spec` (specs valid anywhere) and `_render_record_spec` (specs
that only apply to a table declared in an unclassified run — a proven blob of
the same shape keeps `extract.py`'s plain rendering, which is why the two
chains differed in the first place). Eight record renderers moved to
`datatables.py` beside their siblings, and the pass ordering that was buried in
`main()` is now `pipeline.prove_code`/`prove_data`, comments intact.

### The menu mugshot table symbolicated (2026-07-25)

`CharMugshotGfxPointers` rendered as 72 rows of raw `dw $44b1, $4df8`
over one 2,107-byte `Gfx_1b_44b1` blob. It is now a `mugshot_ptr_table`: 67
records whose word 0 names its portrait stream and whose row comment names the
character, over 14 separately labeled LZ streams.

**What indexes it.** `DecompressCharMugshot` (`$1b:$4e5c`) does
`hl = table + id*4`, follows word 0 and calls `DecompressData`; the id is the
character record's byte `+$0b`, written by `InitCa00RecordFromCharId`
(`$02:$40e5`) from `RemapExtendedCharId`. The same byte drives the name fetch
two instructions later as text id `$001b + id`, so **character id = bank `$30`
string index - 27** — the same id space `CharSpriteSetTable` (`$07:$5a50`)
uses. That gives the roster outright: `$00`-`$03` are Alex/Nina/Harry/Kate,
`$04`-`$14` the story cast, `$15`/`$16` "Not used", `$17`-`$1f` are
Luigi/DK/Baby M./Mario/Waluigi/Yoshi/Bowser/Wario/Peach.

**What it holds.** Only 13 of the 67 rows have their own graphics — the four
kids and the six characters unlocked by play (`$1a`-`$1f`), plus three numeral
badges at `$40`-`$42`. Every other row shares one "?" stream. The badges are
reached only through the loader's remap: id `$3f` (the story hero, who has no
face) becomes `$3f + wCurrentStorySlot + 1`, so the hero's portrait is the
save slot's numeral — which is what the file-select screen at `$3b:$5719`
draws for slots 0/1/2.

**Identification** was by decompressing each stream (144 bytes = 3x3 tiles,
matching `SetMugshotAttrs`' 3x3 attribute write) and rendering it. The names
are confirmed independently: bank `$16`'s `CharacterPortraitTable_16` (`$6968`)
is the *full* 32-entry version of the same table (`DecompressCharacterPortrait`
masks the id with `and a, $1f`), and its streams for ids `$00`-`$03`/`$1a`-`$1f`
are **byte-identical** to bank `$1b`'s.

**Bank `$16` named from the same roster.** All 30 of its `Lz_16_*` portrait
blobs are now `PortraitGfx<Name>_16`, and the table renders under a new
`char_lz_ptr_table` spec (`lz_ptr_table` plus roster row comments): every
character has a portrait there *except* Kevin (`$14`), who shares the "?"
stream with the two "Not used" slots. The sibling `WinLosePortraitVariantTable_16`
(`$60f1`) is left alone -- its 8 entries are win/lose variants, not char ids.

**Word 1 of every record is dead.** It points at one of two 4-byte constants
(`dw $6400, $00ff`, twice) sitting just past the last record; no code in the
ROM reads it, and the 12 bytes after those (`$d600, $d690, $d720, $0000`,
`$0090, $0120` — the mugshot buffer addresses and sizes) are unreferenced too.
Both render as local labels (`.unused`, `.unusedAlt`, `.trailer`) so the table
self-delimits rather than over-running into them. Byte-perfect.

### Bank $0b's 120 unnamed functions named from the call graph (2026-07-25)

With the drills named, bank `$0b` had **120 `Func_0b_*` labels and now has
zero** — the per-drill logic the init seeds unlocked. Naming it was a call-graph
walk plus shape matching, not 120 individual reads.

**Attribution first.** Walking calls out from each drill's eight named hooks
and its init routine assigns an owner to every function: **104 of 120 are
reachable from exactly one drill**, 7 are shared, and 9 sit below `$482c`
(where the first drill definition starts) and are bank-wide helpers.

**Then shape.** The per-drill functions repeat a small set of forms, and the
role names come from the four labels a previous session had already placed
(`Drill09JudgePoint`, `Drill09HandlePointEnd`, `Drill09EvaluateResult`,
`Drill15*`):

| Shape | Role |
|---|---|
| `ld a, $N` / `call X` / `ld [$c2ff], a` / `ret` | `<Drill>JudgeShot<N>`, and X is `<Drill>JudgePoint` |
| `ld b, a` / `ld a, [$c2ff]` / `or a, a` / `ret nz` + `rst Rst00` on `wRallyLength` | `<Drill>JudgePoint` |
| opens `farcall UpdateScorePanelDisplay` | `<Drill>HandlePointEnd` |
| writes `$c2e3` | `<Drill>EvaluateResult` |
| opens `ld a, [wPointWinLoseFlag]` | `<Drill>AwardPointToSide` |
| opens `ld a, [wPointOutcome]` | `<Drill>QueueOutcomeMessage` |
| opens `ld a, [wRallyLength]` | `<Drill>SetupShotTarget` |

The eight legacy `Drill<NN>*` labels were renamed onto the drill-name
convention (`Drill09JudgePoint` → `NetGamePractice1JudgePoint`) so the bank
reads consistently.

The bank-wide helpers got semantic names where the code says what they do —
`SetDrillMessageByServer` and `SetDrillMessageByRallyParity` (the pair at
`$4545`/`$4558` that pick a message id by who is serving vs. rally parity),
`CountDrillResultBitsSet` (a `rr`/`adc` popcount over `$c2e4`),
`LoadDrillOpponentBySide`, `QueueDrillMarker1_0b`/`2_0b` (both project a
world position and queue `DrillSpriteTemplate_0b`), and the two
`StrokePractice*TargetZoneDelayTask` frame tasks that re-enable
`wTargetZoneEnabled` and then unregister themselves.

**One name is mechanism-only:** `TestCharStateBit4` (`$4447`) switches to
WRAM bank `$04 + slot`, reads `[$df50]` and returns bit 4. Nine drills use it
to decide pass/fail, but which condition that bit represents is not pinned
down, so the name describes what it reads rather than guessing.

Bank `$0b` is now 79.6% proven code with 395 of 972 labels named.

### The 18 training drills named end to end (2026-07-25)

Carving bank `$0b` left 122 mode-hook handlers as bare addresses — the
tables rendered `dw $4e08` because nothing had a label. They are now all
named, along with the definitions, hook tables, init routines and point
tables: **172 labels**, and the drill list is identified by name.

**Where the names come from.** `RunDrillMatchListMenu` (`$10:$4450`) calls
`RunPagedTextMenu` with `hl = $048d`, `a = $09` — nine text ids at
`31:141`-`31:149`, four menu lines each, 34 items total. That count is
exactly 18 drills + 4 machine levels + 4 wall levels + 2 master levels +
6 "64 Mini" levels, and item order pins each drill id:

| id | Drill | id | Drill | id | Drill |
|---|---|---|---|---|---|
| 0-2 | Service Match 1-3 | 6-8 | Net Game Match 1-3 | 12-14 | Stroke Match 1-3 |
| 3-5 | Service Practice 1-3 | 9-11 | Net Game Practice 1-3 | 15-17 | Stroke Practice 1-3 |

Three independent things agree with that mapping:

- **Court and point table split on it exactly.** Every Match drill runs on
  court `$18`, every Practice drill on court `$09`; ids 0-2/6-8 share
  `MatchDrillPointTable`, 3-5/9-11 share `PracticeDrillPointTable`, and the
  Stroke pair get their own two.
- **The story scenes already carried the names.** `$15` passes drill 0 from
  `ServiceAceMatchChallengeScene`, 1 from `CenterLineServeMatchChallengeScene`,
  7 from `SmashMatchChallengeScene`, 8 from `DropShotMatchChallengeScene`,
  12-14 from `Stroke`/`Lob`/`ReturnMatchChallengeScene` — all landing in the
  right family.
- **The non-drill tail checks out too.** Bank `$12` passes ids 22-25 from
  `WallPracticeRoomTile03`-`06_12` (menu items "Wall Lvl 1-4") and id 27 from
  `RelaunchWallPracticeMasterLevel` ("Wall Master Lvl").

One oddity recorded rather than smoothed over: menu item 3 reads
`"Service Match 1"` in the ROM where items 4 and 5 read `"Service Practice 2"`
and `"Service Practice 3"`. Everything else about drill 3 (court `$09`,
`PracticeDrillPointTable`) says it is Service Practice 1, so the label is
`ServicePractice1Drill` and the menu string looks like a ROM typo.

Hook slot names follow the convention bank `$0d` already uses
(`CallModeHook`'s event slots), so the tables now read:

```
ServicePractice1Hooks:
	; $4df8, 16 bytes (mode_hooks)
	dw ServicePractice1Hook_PerFrame ; record 0
	dw ServicePractice1Hook_PointStart ; record 1
	dw ServicePractice1Hook_PointEnd ; record 2
	dw RetStub ; record 3
```

### Every blob in the ROM is now named (2026-07-25)

**All 4,938 remaining `INCBIN`s carry a label.** The pass that finished it
covered banks `$17`-`$1e`, `$24`-`$3f`, `$6a`/`$6b` and the `$70`-`$77`
sprite banks — 324 unlabelled blobs when the sweep started, zero now.

These are asset banks, so the blobs were always going to stay binary; the
value is **exact extents and names derived from how each region is used**.
A script does both: for every same-bank `ld hl/de, $XXXX` that lands inside
an unlabelled blob it looks ahead a few lines for the consumer call and
splits the blob there, naming the piece after what reads it —

| Consumer | Name | Spec |
|---|---|---|
| `LoadPaletteShadow` / `LoadPalettesImmediate` | `Palette_*` | `palettes` |
| `QueueVRAMCopy` / `CopyMemoryFast` | `Gfx_*` | — |
| `DecompressData` | `Lz_*` | — |
| `SetModeHookTable` | `ModeHooks_*` | `mode_hooks` |
| `SetMinigamePointTable` | `PointTable_*` | `bytes:4` |
| `QueueSpriteTemplate` / `SetObjSpriteTemplate` | `SpriteTemplate_*` | `sprite_template` |
| `PrintString` / `WriteStringToWindow` | `String_*` | `ascii` |

A leading run before the first reference becomes `Padding_*` + `fill` when
it is one repeated byte, otherwise `Data_*` (with a `bytes:N` rendering under
64 bytes) or `Gfx_*`. That turned e.g. bank `$18`'s 41 pieces and bank
`$1c`'s 83 out of six blobs, and every `palettes` split re-renders as
readable `dw` colors.

**Caveat on the naming metric.** `progress.py`'s human-named count jumped
from 6,199 to 6,332 in this pass, but the new entries are *usage-derived
placeholders* (`MenuHandCursorPalette`, `Gfx_1c_7541`), not semantic names. They
say what reads the data, not what it is. Treat that part of the count
accordingly — the underlying win is that nothing is anonymous any more, so
naming a region now means editing one `labels.json` entry rather than first
working out where it starts and ends.

Two more stranded functions fell out of the decode screen on the way:
`$18:$7bba`, a jump-table target reached through `jp hl`, and `$1a:$4521`,
a stranded `call`/`jp` pair. The screen also flagged `$1b:$5f7c`, but that
is signed ramp data whose `$ff` bytes decode as `rst $38` — left as data.

### Story banks $0f-$16 cleared with a decode-based blob screen (2026-07-25)

Banks `$0f`-`$16` are the story-mode map/scene family, and their blobs turned
out to be the same handful of shapes repeated per bank. All eight are now
free of unlabelled blobs.

**A decode screen made this tractable.** Rather than reading each blob by
hand, a script tries a linear SM83 decode of every unlabelled region
(honouring the project's `rst` pseudo-ops, which carry inline operands) and
asks: does it decode to *exactly* its last byte, ending on a terminal
instruction? Random data essentially never does, so a full-extent clean
decode is strong evidence of stranded code. That found the per-bank
map-script helper stubs — `ret` / `xor a; ld [$c2da], a; ret` /
`sound $a2` / `xor a; ld [$c2d5], a; ret`, byte-identical across banks —
sitting between the actor scripts and the data that follows them.

**Behind those stubs were four more actor-script pools.** With the stubs
seeded, the data starting `10 01 06 00 04 00 02 02 0d 14 40 00` is the same
bytecode bank `$0e` yielded on 2026-07-24; banks `$11` and `$12` already had
theirs declared, and `$0f`, `$10`, `$13`, `$14` and `$15` now do too — 558,
486, 411, 438 and 419 bytes of `as_*` opcodes:

```
ActorScript_0f_12:
	; $7b8d, 558 bytes (actor_script)
	as_anim $01
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field $14, FACE_DOWN
```

Each pool is followed by the same 120-byte pair of `test_flag`-driven
routines; bank `$14`'s copy is byte-identical to bank `$0f`'s, which is what
justified seeding it.

The rest was routine once the references were followed: `LoadPaletteShadow`
and `QueueVRAMCopy` call sites split every remaining blob into
alignment padding + tiles + palettes (bank `$14`'s island and firework
assets, bank `$13`'s tour pointer, bank `$15`'s water-sprite HUD), a
`map_actors` table at `$14:$6675` reached through
`ScriptRespawnLocationActors`, a `mode_hooks` table plus its six handlers at
`$10:$4bd8`, several `FACE_*` direction tables now rendered as
`enum:FACE`, and a scattering of text-id `dw` tables.

**One false positive worth recording:** the screen flagged `$14:$6ea1` (79
bytes) as code, but its only reference is `LoadPaletteShadow` with
`de = $0904` — four palettes. Palette data decodes as plausible instructions
more often than you would expect, so a clean decode is evidence, not proof;
every seed in this pass was cross-checked against how the region is actually
referenced.

### Bank $0b: drill definitions unlock 7.7K of hidden code (2026-07-25)

Bank `$0b` (training drills) had 25 unlabelled blobs, 9,532 bytes — and
carving it added **3,836 instructions / 7,723 bytes of proven code**, the
largest single jump in a while. It has zero blobs left.

The key is `Data_0b_47b4`, 18 words that `RunTrainingDrillByID` indexes for
drill ids `$00`-`$11`. Each points at a 16-byte **drill definition**, whose
layout falls straight out of `StartDrillFromDefinition` (`$4002`): eight
setup bytes (opponent, court, character count, game mode, story-match slot,
BGM, -, player) then three same-bank pointers — a mode-hook table, a point
table, and an optional init routine invoked through `JumpToHL`. A new
`drill_definition` data-table kind renders them with all three resolved:

```
DrillDefinition_0b_00:
	; $482c, 16 bytes (drill_definition)
	db $37, $18, $02, $05, $00, $24, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw DrillModeHooks_0b_00, DrillPointTable_0b_427e, $0000 ; mode hooks, point table, init
	db $00, $00
```

Those 18 definitions yield 18 `mode_hooks` tables and 9 init routines, and
**the init routines were the unlock**: nothing statically references them, so
descent had never entered them, and seeding the 9 pulled in thousands of
instructions of per-drill logic that had been sitting inside the two big
blobs. A second sweep over what was left classified 25 more stranded
fragments as code by shape (`ld a, n` / `call` / `ld [nn], a` ending in
`ret`) and named the rest: 36 ten-byte shot tables, six `records:4` target
position lists ending `$ff $ff`, and the four `$ff`-terminated drill point
tables shared across the 18 drills.

One extent bug fell out too: `DrillMessageTextIds_0b` was declared 274 bytes
and had swallowed 56 bytes of code past its real end at `$469e` — the
give-away was records 110+ rendering as `dw $8bfa` / `dw $a7c7` where every
real entry is `$28xx`/`$2cxx`.

### Banks $09 and $0a: every blob now named (2026-07-25)

**Bank $09** (match objects) had 10 unlabelled blobs. Four are 16-byte
object-template arrays for `LoadObjTemplate_09` (which indexes `a * 16`):
`ServeIndicatorObjTemplates_09`, `WinLoseResultObjTemplate_09`,
`ServeIndicatorSideObjTemplates_09`, and `CourtBannerObjTemplates_09` —
29 records, exactly matching the 29 entries of `VramTileset_09`. Three more
are stranded code (two obj-flag togglers and a `res 0, [hl]` fragment).

The last four are pointer tables whose targets are `sprite_template`
regions **inside the following blob**: `$7112`/`$7129` (serve indicators) and
`$71a4`/`$71bb` (character icons), each 4 words picked by
`wOnCourtCharCountMinus1`. The nine templates they reach account for every
byte — `$7129`'s 108 bytes are 8 bytes of table plus 4 x 25, and `$71bb`'s
93 are 8 plus 9 + 17 + 9 + 17 + 33 — and one of them, `$71f7`, is also
referenced from the object-template table.

`TilesetTiles_09` stays one INCBIN on purpose: its 29 `VramTileset_09`
entries **overlap** (records 12-15 share ranges and record 17 re-points at
`$4900`), so there is no partition to carve it into.

**Bank $0a** (court scene + minigame targets) had 26. The find was a second
small script VM: `$6809` is a 9-word opcode table
(`MinigameTargetOpHandlers_0a`), and seeding its handlers recovered three
more blobs that were opcode implementations. The 922-byte `$68e1` blob is
its **script pool**: nine pointer tables at `$6c96`-`$6d48` name 57 entry
points that partition the pool exactly, from `$68e1` to the last script
ending at `$6c7b`. Scripts are mostly 10 bytes, with the last of each group
running longer.

Also carved there: a pair-swap index table, `DPadMoveVectors_0a` (16
direction combos of `{dx, dy}`, indexed by `hPlayerInputFlags >> 2 & $3c`),
two palette blocks, a `FACEMASK_*` table, and four more stranded helpers —
one of which is a byte-for-byte copy of bank `$04`'s `EvalFlagCondition`.

### Banks $05 and $07 carved; $06 was already clean (2026-07-25)

**Bank $05** (debug menus + the proportional font) went from 7 blobs to 2,
both of them imagery: `FontGlyphs` (102 glyphs x 16 bytes, already labelled)
and 12 palette-editor cursor tiles. What came out of the rest:

| Address | Size | Now |
|---|---|---|
| `$53a2` | 12 | `PowersOfTen_05` is 5 words (1, 10, 100, 1000, 10000) plus two stray `ret`s |
| `$5f94` | 42 | `TextControlCodeHandlers_05` — 16 words for codes `$00`-`$0f`, plus two handlers reached only through it |
| `$6582` | 32 | the debug editor's two hex-digit header rows, `"0 1 2 3 4 5 6 7"` / `"8 9 A B C D E F"` |
| `$67b7`, `$69bb` | 13, 10 | `"- ENTER NO -"` and `"--R--G--B"` |
| `$6886` | 202 | 10 bytes of padding then 12 cursor tiles |
| `$7f80` | 96 | `GlyphWidths_05`, the table `GetGlyphWidthByIndex` reads (4-7 pixels per glyph) |

The two stranded handlers are the text engine's own: code `$01` emits `$0d`
and continues (`TextCodeLineBreak_05`), the default emits the character
literally (`TextCodeLiteral_05`), and codes `$00`/`$03` share
`TextCodeEnd_05` — which matches the `$03`/`$00` terminators the string
dumper already assumes.

**Bank $06** needed nothing: all 41 blobs are LZ menu-item graphics that were
already carved and named in the 2026-07-22 pass.

**Bank $07** (link cable + shot physics) went from 25 blobs to 16; the 16 are
character graphics streams already named. The nine that resolved are all
lookup tables found by grepping for their index arithmetic
(`add a, $xx` / `adc a, $5c`), which split the 178-byte `$5c42` blob into
eight sub-tables that account for every byte:

| Address | Size | Now |
|---|---|---|
| `$54ca`/`$54d4` | 10/10 | `ShotRecoilVarPtrs_07` (5 `$dfxx` words) and the recoil magnitudes it selects |
| `$559e` | 75 | `ShotTypePresets_07` — 15 5-byte records {sound, recoil index, trail color, c, b} |
| `$562e`/`$5636`/`$563e` | 8 each | `CourtSideOffsets_07_*`, picked by `wCharCourtPos & 1` |
| `$5a23` | 32 | `SpecialShotFlagTable_07` |
| `$5aa7` | 12 | `CharFrameGfxDest_07` |
| `$5c42` | 8 | `CharAttrStructPtrs_07` — `$ca00`/`$ca80`/`$ca40`/`$cac0`, the four on-court character structs |
| `$5c4a`-`$5c9a` | 20/20/20/10/10/10 | six 10-entry stat tables indexed by character-struct fields `+$27`/`+$28`/`+$2a` |
| `$5ca4` | 80 | `CharStatPresets_07` — 5 records of 16, indexed `a * 16`, whose bytes index the tables above |
| `$5efc` | 17 | `ModeHookTable_07` is a `mode_hooks` table; hook 0 points at the `ret` byte immediately after it, now `ModeHookNop_07` |
| `$5f94` | 162 | three `MinigamePointTable_07_*` blocks of 4-byte records, `$ff`-terminated |

The six stat tables keep address-suffixed names: their shapes are certain
(10 entries, indexed by a character-struct field) but which stat each one
holds is not yet pinned down.

### Bank $04 is blob-free; the actor-script dispatch table is symbolic (2026-07-24)

The actor engine's 10 blobs (681 bytes) are all gone. The keystone was
`$447d`, a 44-byte blob that is the **actor-script opcode dispatch table** —
22 words, one per `as_*` opcode, in the exact order of `ACTOR_SCRIPT_OPS`.
Seeding all 20 distinct targets as code turned four of the other blobs into
the opcode handlers they always were, and every entry now reads
`dw ActorScriptOp_SetPos`. Opcodes `$00`/`$05`/`$0f` (`as_halt`/`as_halt5`/
`as_halt15`) share one handler, which is consistent with them being aliases.

| Address | Size | Now |
|---|---|---|
| `$40f4` | 84 | two stranded helpers (`inc b` / `dec b` / `ret z` guard, then `wram_bank $04` and a write to actor `+$08`/`+$0a`) |
| `$447d` | 44 | `ActorScriptOpHandlers_04` |
| `$44eb`, `$4556` | 21, 37 | the `as_move_rel` and `as_set_pos` handlers, stranded |
| `$47fd` | 39 | `ActorFieldTypeTable_04` (35 entries: `$01` = byte field, `$02` = word) plus the tail of the `as_anim` handler at `$4820` |
| `$4a1f` | 8 | `BitMaskTable_04` — `1 << i`, the LSB-first counterpart to bank `$00`'s `$80 >> i` |
| `$4d63`, `$4ec8` | 264, 72 | ten actor spawn lists |
| `$5072` | 96 | `ActorMoveVectors_04` — 3 speed tiers x 8 compass directions of `{dx, dy}`; radii `$0120`/`$0140`/`$0110` with the diagonals at `$00cb` (288 x cos 45 = 203.6) |
| `$56b3` | 16 | `DirectionToFacing_04` — 16 directions to `FACE_*`, now `enum:FACE:8` |

**Actor spawn lists get their own renderer.** `SpawnActorsFromList`
(`$4cf7`) copies 14 bytes per step to `$dac0` and stops when byte 9 of the
record is `$ff`, and `SpawnActorFromTemplate` (`$4c60`) walks those 14 bytes
as `{flag condition, script, x, y, facing, -, obj def, anim, extra, -}` —
note x is written to both the position (`+$08`) and target (`+$0c`) fields.
Because the copy always reads 14 bytes but only byte 9 is tested, the stored
terminator is just the 10 bytes up to the `$ff`, which is why single-entry
lists are 24 bytes and not 28. A new `actor_list` data-table kind renders
them with the script pointer and facing resolved:

```
ActorList_04_0:
	; $4d63, 66 bytes (actor_list)
	dw $0000, ActorScript_Idle, $0100, $0100 ; actor 0: cond, script, x, y
	db FACE_DOWN, $00, $01, $01, $00, $00 ; facing, -, obj def, anim, extra, -
	...
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; list end
```

### Bank $03: 54 cutscene frames carved out of a mis-seeded blob (2026-07-24)

Bank `$03` (save engine + the scrolling-text cutscene) had 13 blobs,
3,048 bytes. All of it resolved; what is left binary is one 2-tile cursor
graphic and 54 exactly-sized compressed frames.

**The big one was `$6633`, 2,114 bytes.** 51 sites do `ld hl, $XXXX` /
`ld de, $d000` / `call DecompressData`, and running the LZ codec from each
start shows the streams **tile the region with no gaps**: 54 streams from
`$65d0` to `$6e74`, the last ending flush against `SpriteTemplate_03_6e75`.
The handler chain `LoadCutsceneAnimFrameGfx_00_08` … `_2D_35` dispatches on a
frame counter at `$06:$d000` that runs `$00`-`$35` (`sub a, $36` /
`jp nc` caps it), and the frame-to-stream mapping is one-to-one in address
order, so they are now `CutsceneAnimFrameLZ_00` … `_35`. Frames `$00`-`$1a`
decompress to 64 bytes (4 tiles), `$1b`-`$35` to 32 bytes (2 tiles).

Three of those streams (`$65d0`, `$65fa`, `$6628`) were not even in the blob:
they were being **disassembled as code**. A single stray coverage sample at
flat `0xe619` in `story6_restaurant_traingame.json` seeded a descent that
decoded 27 bytes of compressed graphics as instructions (`or a, b` / `nop` /
`rst Rst38` / `ld a, [$31e7]`), and the `palettes` run before it had been
stretched to 93 bytes to reach it. `0xE619` is now in `BAD_SEEDS`; the real
palette block is two 8-byte OBJ palettes at `$65bc`/`$65c4`
(`SetupSceneAnimationPalettes` loads them into shadow slots `$0a`/`$0b`) plus
4 bytes aligning `$65d0` to a tile boundary.

The rest of the bank:

| Address | Size | Now |
|---|---|---|
| `$4d5c`, `$4fe2` | 8 each | stranded code — `pop af` / `wram_bank` / `ld a, $ff` / `ret`, the restore-bank-and-fail epilogue, twice |
| `$4d7e` | 8 | `SaveFlagMaskTable_03` — `$80 >> i`, the bank's own copy |
| `$526d` | 3 | stranded code — `xor a` / `dec a` / `ret`, returns `$ff` |
| `$52af` | 4 | `StorySlotBlockIds_03` — `GetCurrentSlotBlockId` indexes it by `wCurrentStorySlot & 3` |
| `$52e3` | 13 | padding aligning the next block |
| `$52f0` | 32 | `SaveEditorCursorTiles_03` — 2 tiles, an underline cursor |
| `$54b0` | 93 | five UI strings (`"FAILED"`, `"LOADED"`, `"SAVED"`, `"DELETED"`, blank), a `$01`-`$0d` ramp, and `MarioGolfSignature_03` = `"MARIO GOLF GB CH"` |
| `$5957` | 30 | `TestCartIdString_03` — `"TESTCARTID"` three times, unreferenced |
| `$5b20` | 8 | `ScrollTextPalette_03` |
| `$708e`-`$729f` | 530 | 2 bytes padding, `WindowSolidTile_03` (`ds 16, $ff`), `WindowAttrMap_03` (`ds 256, $80`), `WindowTileMap_03` (`ds 256, $20`) |
| `$7301` | 50 | `WindowSlideStepTable_03` — 25 `{scroll delta, window delta}` pairs |
| `$7370` | 147 | `TextPageDescriptors_03` — 21 7-byte records: a count plus up to three `{text-id offset, line count}` pairs |

`$54b0`'s strings would otherwise have been auto-detected as game text and
emitted as generated `text_*.asm` includes; declaring them `ascii` keeps them
inline as `db "FAILED     ", $00`, which is what a five-string UI pool wants.

### Bank $01: the boot/debug bank's assets identified (2026-07-24)

Bank `$01` holds the debug test menu, the shared menu font/window tileset and
its loaders, the DMG lockout screen, and the sound test. Its six blobs were
named but only loosely (`MenuTilesA_01`, `UnusedTiles_01_51ab`); rendering
them settled what each one is, and two of them turned out to be a duplicate
asset set.

**`ShowDebugGfxScreenAndHang` is the DMG lockout screen.** Its single caller
is `$00:$25a5` — `ldh a, [hIsCGB]` / `or a, a` / `jr nz` past the `farcall`.
Decompressing its two streams confirms it: `$607c` is the Mario Tennis logo
over "MARIO TENNIS (TM) This game can be played only on Game Boy (R) Color.",
`$6903` its 32x18 tilemap. It then zeroes `rIE` and spins on `AdvanceFrame`
forever. Renamed `ShowDmgLockoutScreen`, with
`DmgLockoutTilesLZ_01` / `DmgLockoutTilemapLZ_01`.

**The menu tileset is ASCII-addressed.** With `rLCDC` = `$c1` the BG uses the
signed `$8800` base, so the three copies land on contiguous tile ids:

| Source | VRAM | Tiles | Tile ids | Now |
|---|---|---|---|---|
| `$4210` | `$9000` | 16 | `$00`-`$0f` | `MenuWindowTiles_01` — box frame, cursor arrow, up/down/left/right triangles |
| `$4410` | `$9200` | 96 | `$20`-`$7f` | `MenuFontTiles_01` — **tile id = ASCII code**, `$20` space through `$7f` |
| `$4a10` | `$8800` | 96 | `$80`-`$df` | `MenuFontFillTiles_01` — 96 copies of one solid color-1 tile |
| `$5010` | — | — | — | `MenuFontPalettes_01`, 8 palettes (`LoadMenuFontPalette` loads slot 0) |

`MenuFontFillTiles_01` is 1,536 bytes of `$ff, $00` repeated, so it is now a
one-line `ds 1536, $ff, $00` via a new `pattern` data-table kind rather than a
blob. The old `MenuTilesA_01` label sat one byte early, on the `$00` that
aligns `$4210` to a tile boundary; `LoadMenuTilesA` always loaded `$4210`.

**`$51ab`-`$602f` is the same asset set with the Japanese font.** Nothing
references it. It has the identical shape — alignment padding (5 bytes here),
16 window tiles, 256 bytes of slack, the font block, 64 bytes of palettes —
and its window tiles are **byte-identical** to `$4210`. The font is not: it
keeps ASCII `$20`-`$5f` in the same slots and then runs hiragana and katakana
through tile `$e3`, where the USA set has lowercase and the solid fill.
Renamed `UnusedJpWindowTiles_01` / `UnusedJpFontTiles_01` /
`UnusedJpFontPalettes_01`.

**One thing that looks wrong.** `LoadMenuTilesBStaged` (`$5095`) splits
`LoadMenuTilesB`'s first 96-tile copy into three 32-tile chunks with an
`AdvanceFrame` between each, then does a fourth chunk from `$5010` to `$8e00`
— but `$5010` is `MenuFontPalettes_01`, and 32 tiles from there runs 512 bytes
into the code that follows. The address is exactly one chunk past where a
four-chunk walk of the `$4a10` block would have ended (`$4a10 + $600` =
`$5010`, `$8800 + $600` = `$8e00`), so the three chunks that should have
covered `$8800`-`$8dff` appear to be missing. Whatever was intended, the
source is not tile data. `LoadMenuFontGfxStaged` is reached from bank `$06`
(`$6ea0`), so this is live code.

### Bank $00 carved down to the Nintendo logo (2026-07-24)

Bank `$00` had nine anonymous `INCBIN`s left, 828 bytes between them. All
nine were identifiable and eight are now structured source; the ninth is the
Nintendo logo, which stays an `INCBIN` on purpose. Bank `$00` is now 98.1%
proven code+structure, with 48 bytes of blob and 268 bytes of fill.

| Address | Size | Now | What it is |
|---|---|---|---|
| `$0104` | 48 | `NintendoLogo` (INCBIN) | the boot logo — ROM content, so it stays extracted |
| `$0134` | 28 | `cart_header` | title `"CGBTENNIS "`, code `BM8E`, CGB-only, MBC5+RAM+BATTERY, 2 MiB / 32 KiB SRAM, checksums |
| `$0153` | 11 | `BuildStamp` | `db "10011171737"` — printed by bank `$01` |
| `$0ab4` | 17 | `ArcTanTable` | `tan(i * 5.625°) * 16`, i = 0-16, `$ff` sentinel |
| `$1ff7` | 186 | `NumberFontGlyph_0`-`_9`, `_0a` + `NumberFontGlyphPtrs` | a 6x8 2bpp digit font |
| `$2113` | 8 | `PixelMaskTable` | `$80 >> i` |
| `$2497` | 8 | `FlagMaskTable` | `$80 >> i`, for the game-flag API |
| `$2fe0` | 6 | `JingleSoundIds` | |
| `$3836` | 16 | `NoiseNoteTable` | NR43 polynomial-counter bytes |
| `$3dd4` | 500 | `WavePatternTable` + `WavePatterns`, `SoundEnvelopeTable` + `SoundEnvelopes` | two tables, not one |

**The `$1ff7` font.** 11 records of 14 bytes (`db width, height` then 12
bytes of bitmap) followed by a 16-entry pointer table at `$2091`.
`RenderGlyphToTiles` (`$211b`) reads the two size bytes into `$c0f8`/`$c0f9`
and then consumes **2 bits per pixel, MSB first, with no byte alignment
between rows** — first bit to the low bitplane (`ld [hl+]`), second to the
high (`ld [hl-]`). At width 6 that is 12 bits per row, so 3 bytes cover
exactly 2 rows, which is how the new `font_glyph` renderer groups them:

```
NumberFontGlyph_8:
	; $2067, 14 bytes (font_glyph)
	db $06, $08 ; 6 x 8, 2bpp
	db $3f, $cd, $a7 ; .####. #+oo+#
	db $ef, $bd, $a7 ; #o##o# #+oo+#
	db $ef, $be, $fb ; #o##o# #o##o#
	db $da, $73, $fc ; #+oo+# .####.
```

`RenderTextToTiles` (`$20e5`) indexes the pointer table with
`(char - $30) & $1f`, so records 0-9 are `'0'`-`'9'` and all six trailing
slots alias record 10 — the out-of-range fallback. Record 10 sits where
`':'` would be but does not decode as a colon (a digit-like top over a small
hollow box), so it keeps the neutral name `NumberFontGlyph_0a`. Characters
below `'0'` skip the lookup entirely and just advance x by 6, which confirms
the 6-pixel advance.

**`$3dd4` was two tables.** The label covered 500 bytes, but the sound engine
reaches them through two separate one-entry pointer tables:

- `$3dd4` `WavePatternTable`: `dw WavePatterns`, indexed by the *high* nibble
  of `hSndInstrument` (`$3538`, `$367c`, `$3d4f`)
- `$3dd6` `WavePatterns`: 16 patterns x 16 bytes, indexed by `waveId << 4`.
  Entry 0 is a sine, 1 a triangle, 2 a square.
- `$3ed6` `SoundEnvelopeTable`: `dw SoundEnvelopes`, indexed by the *low*
  nibble of `hSndInstrument` (`ld de, $3ed6` at `$3a7d`)
- `$3ed8` `SoundEnvelopes`: 15 envelopes x 16 steps. The reader computes
  `hl = ptr - $10 + idx`, so `idx` runs `$10`-`$ff` and the last step lands on
  the final byte at `$3fc7`. Each byte is volume in the high nibble, control
  flags in the low (`bit 2` is tested at `$3aa2`).

Both pointer tables holding a single entry that points at the bytes right
after them reads as a generic multi-instrument-bank driver shipping with one
bank populated.

**`$2497`'s indexing.** `TestGameFlag`/`SetGameFlag`/`ClearGameFlag` do
`ld a, e` + `rlca` x3 (confirmed `07 07 07` in the ROM, not `rrca`) before
indexing an 8-byte table, which looks out of range until you read
`TestGameFlagByNumber` (`$24ef`): it shifts `de` left by 5 first, so `e`'s
top 3 bits hold the bit number and `d` the byte offset. The three rotates
land the bit number in the low 3 bits with everything else zero. Flag bit 0
is the MSB of its byte.

**Tooling.** Three new `data_tables.json` kinds — `ascii`, `cart_header`,
`font_glyph` — plus `records:2` now resolving symbolically in bank `$00`
(it was gated to `bank > 0` because the ROMX word-to-flat mapping is wrong
for bank 0; ROM0 words now map 1:1). That last change exposed a trap:
`render_operand` used to inline *any* ROM0 label into *any* bank's
`ld r16, imm`, and the new bank-`$00` labels sit exactly where banked code
keeps text ids (`$2000`-`$2100`) and packed y/x pairs (`$0104`), so bank
`$05`/`$15`/`$3b` sprouted five bogus pointer names. ROM0 immediates loaded
from ROMX now stay numeric unless the offset is listed in
`disasm.py`'s `ROM0_FAR_POINTERS`; `$0153` is the only genuine one, and no
pre-existing label was affected.

### Bank-end $ff padding is now automatic (2026-07-24)

Every bank used to end with an explicit `ds <count>, $ff ; $xxxx, fill`
directive, so carving anything near a bank end meant restating a byte count
that had to be exactly right or the ROM shifted. That count is now the
linker's job: `rgblink -p 0xff` pads every byte no section covers, and a
bank's section simply stops after its last real byte. `tools/disasm.py`
(`bank_end_fill`) leaves a comment in its place —

```
	INCBIN "data/bank_07f/d_44f6.bin" ; $44f6, 12 bytes
	; $4502, 15102 bytes fill to bank end (linker-padded)
```

— so the unused tail stays visible in the source, and `tools/progress.py`
counts it alongside real `ds` runs (the progress table is unchanged). Where a
`dw` slot names the trailing fill (banks `$60`-`$67`), the label is still
emitted; it resolves to the section end, i.e. the same address as before.
Interior fills — the `$00` runs in bank `$01`, the inter-vector gaps in bank
`$00`, mid-bank `$ff` runs — are still assembled as `ds`; only the run that
reaches `$8000` is dropped. 124 bank files lost their fill directive and
`make compare` is still OK.

### Bank $0e's last two blobs carved (2026-07-24)

Bank `$0e` had exactly two anonymous `INCBIN`s left, 1,246 bytes between
them. Both were identifiable, and 830 of those bytes are now structured
source; the remaining 416 are named tile streams.

**`d_72ce.bin` (808 bytes) is the star-warp transition's asset bundle.**
`PlayStarWarpTransition` (`$7150`) consumes the first three pieces directly
and `UpdateStarWarpSprite` / `OffsetStarWarpPathPoint` read the rest, so the
808 bytes decompose with nothing left over:

| Address | Size | Label | Read by |
|---|---|---|---|
| `$72ce` | 8 | `StarWarpPalette` | `ld de,$0901` + `LoadPaletteShadow` — `e=$01` makes `c = 4` colors, `d=$09` targets shadow slot 9 (`$c148`), an OBJ palette |
| `$72d6` | 10 | — | `$00` padding up to the tile stream (`fill`) |
| `$72e0` | 384 | `StarWarpTiles` | `QueueVRAMCopy` with `c=$18` — 24 tiles to `$a000` |
| `$7460` | 32 | `StarWarpSparkleTiles` | `QueueVRAMCopy` with `c=$02` — 2 tiles to `$a180`, contiguous with the block above |
| `$7480` | 12 | `StarWarpFrameSprites` | `$7200`: `[$d000] * 2`, and `$d000` cycles 0-5 — six frames, two sprite ids each (`$00,$02` … `$14,$16`) |
| `$748c` | 181 | `StarWarpPathY` | `OffsetStarWarpPathPoint` `$724a`, indexed `$748c + [$d001]` |
| `$7541` | 181 | `StarWarpPathX` | `OffsetStarWarpPathPoint` `$725a`, indexed `$7541 + [$d001]` |

The two 181-byte curves are the flight path. `$d001` steps by 2 per frame
across the 90-frame (`$5a`) countdown in `$d002`, so the live index range is
0-178 and 181 entries covers it exactly. Both read as smooth signed ramps —
X sweeps `$00 → $ea → $40 → $13 → $62 → $27`, the looping arc the star
traces before the fade-out at `$71e2`. The palette decodes to white /
yellow-white / orange, and the `$7460` pair is a small four-point sparkle,
which is what `UpdateStarWarpTrailSparkles` queues (`ld c,$18` at `$72bc`,
the template right after the six frame pairs).

**`d_7ca4.bin` (438 bytes) was actor-script bytecode, not data.** It decodes
as `as_*` opcodes consuming 438 of 438 bytes and ending flush against
`ComputeTrainingGymProgressIndex` at `$7e5a`. It is a pool of six
independent loops, each closed by its own back-edge `as_jump`, now six
`actor_script` regions: `ActorScript_0e_23`, `_7d0b`, `_7d72`, `_7ddb`,
`_7e3e`, `_7e4b`.

The first four share one shape — `as_anim $01` → `as_target_rel ±$0400, dy`
→ `as_wait_move` → `as_set_field $14, <facing>` → `as_anim $05` →
`as_wait $4b`, six times, then jump back. `$7ca4`/`$7d72` set `FACE_DOWN`
and `$7d0b`/`$7ddb` set `FACE_UP`, and the X shuttle is ±4 tiles: two pairs
of actors volleying across a net. `$7e3e` and `$7e4b` are plain animation
loops (`as_anim $03`/`$04` behind long waits). Three fall-through-only
fragments (`$7d07`, `$7d6e`, `$7dd5`) do `as_anim $00` plus a wait before
dropping into the next loop, so they stay inline rather than getting their
own labels.

**Caveat: nothing in `src/` points at any of the six entry points** — no
`map_actor`, no `script_set_actor_script`, no `dw` table anywhere in the
ROM. They are either installed through a runtime-computed pointer or dead
content; the bytecode decode is what identifies them, not a reference.

### MinigameConfigTable symbolicated (bank $0d, 2026-07-24)

`MinigameConfigTable` (`$0d:$4090`) rendered as 63 bytes of raw `dw`s over
an over-run extent. It is really **18 words plus three 9-byte tables**, and
the 63 bytes now decompose exactly (36 + 9 + 9 + 9), ending flush against
`InitMinigameScore` at `$40cf`.

`StartMinigameByID` indexes it as `id - $12` (ids below `$12` are drills,
routed through bank `$0b`'s directory instead; id `$24` is special-cased by
the caller, which is why the table stops at 18). Each entry is a 14-byte
config that `InitMinigameFromConfig` unpacks: `+$00` opponent char, `+$01`
court, `+$02` on-court character count, `+$03` game mode, `+$04` the low
byte of `wCurrentMinigameStoryMatch` (high byte always `$02`), `+$05` BGM,
`+$07` player char, `+$08` mode-hook table, `+$0a` point-layout table,
`+$0c` an optional init routine called through `JumpToHL`.

That `+$04` byte names every entry outright against the
`wCurrentMinigameStoryMatch` id list: `$12`-`$15` are Tennis Machine 1-4,
`$16`-`$19` Wall Practice 1-4, `$1a`/`$1b` the two high-score variants, and
`$1c`-`$23` Boo Blast, Shooting Star, Perfect Shot, Target Shot, Fruit
Fantasy, Banana Bunch, Treasure Box and Medallion Match. The other fields
corroborate: the Tennis Machine entries all carry opponent `$15`, court
`$0a` and 2 on-court characters, the Wall Practice ones opponent `$00`,
court `$0b` and 1 character, and each real minigame has its own court and
BGM.

The three tail tables are the `+$0a` point layouts, read by
`LoadMinigamePointLayout` (`$08:$6662`) as an 8-byte row indexed by
`wTotalPointsScoredInCurrentGame * 8`, with `$ff` at row 1 ending the
sequence. They split cleanly by on-court character count, which is how they
are named: `MinigamePointLayoutSolo` (`$40b4`) is used by every 1-character
config, `MinigamePointLayoutDuo` (`$40bd`) by every 2-character one, and
`MinigamePointLayoutBooBlast` (`$40c6`) only by Boo Blast.

### Minigame mode-hook tables and handlers carved (bank $0d, 2026-07-24)

Each config's `+$08` field points at an 8-slot mode-hook table, and all 18
are now carved with every slot symbolic. The slot roles are read off the
`CallModeHook` (`$08:$66f1`) call sites rather than guessed: `d` = 0
per-frame (`UpdateMatchFrame`), 1 point start and 2 point end (either side
of `PlayMinigamePoint` in `RunMinigamePointLoop`), 3 minigame start (top of
that loop), 4 ball hit (after `StartHitEffect`/`SetCharStateOnBallHit`), 5
bounce (after the bounce sound and `wBallBounceCount`), 6 rally tick (the
tail of `TickRallyTimers`, which returns early unless the ball crossed the
net), and 7 draw (`DrawBallAndEffects`). Handlers are named
`<Minigame>Hook_<Role>`.

New `mode_hooks` data-table spec in `disasm.py`: it renders like
`records:2` and its 8 slots are seeded as code, since the handlers run only
through that indirect dispatch and recursive descent never reaches them.
124 distinct handlers were carved out of what had been data blobs — all of
them decode as code, and most are one- or two-call thunks over the shared
minigame routines (`StartMinigameMatch`, `DrawMinigameScoreHud`,
`LaunchMinigameServe`, `AwardMinigamePointAndEnd`, ...). The remaining 20
slots point at `$00:$03ae`, a bare `ret` in ROM0 now named `RetStub`; the
`mode_hooks` renderer resolves ROM0 words too, because every slot in this
table is known to be a code pointer.

Two pre-existing mis-decodes fell out and are fixed. Eleven **static seeds
across `coverage/bank00d_static2.json` and `coverage/bank_misc_static.json`
pointed into the hook tables themselves** — an earlier pass had read them
as "object-template behavior entries ... named by the 16-byte headers", so
16 of the 18 tables were being disassembled as instructions. Those seeds
are removed and the file comment corrected. Separately, a 3-byte level
table at `$58a3` (read as `[$58a3 + wMinigameLevel]` at `$0d:$5892`, now
`PerfectShotLevelHasTargets`) was also seeded as code, and its decode
straddled the PerfectShot hook table's first word, which is why that table
had no label at all.

Carving the handlers surfaced 21 further functions (their callees), which
are named too, so **bank `$0d` now has no auto-named functions left at
all** — 166 labels / 70 named before the pass, 345 / 263 after. Highlights:
`FreezeMinigameOpponentOnReturn` is the BallHit hook of all nine
2-character minigames and writes `$28` into the WRAM-bank-`$05` hold timer
`UpdateCharStateMachine` honours, freezing the opponent for 40 frames after
the player's first return; `HideLandingMarkerAndExtendSoloCourt` is the
solo equivalent, pushing `wCourtLimitDepth` back out to `$fb20` on the
serve stroke (`ResetPointState` leaves it at the `$fd60` service line);
and `UpdateBooBlastHitStreak` is pinned by the multiplier table at `$57f5`
being `01 02 04 08 10 20 40 80`.

The `$53ce`/`$53d8`/`$540a` trio is named `QueueMinigameHitBurst*` from
geometry rather than art: the 192-byte table at `$542c` decodes as 12 rows
= 6 sprite (x, y) offset pairs with the column being the animation phase
`$0f - (timer & $0f)`, x alternating 0..+15 / 0..-15 and y tracing a
parabola. The scatter is certain; the tile art was not rendered, so the
name describes the motion, not the sprite.

### Bank $0d fully carved; a jump-table runaway guard (2026-07-24)

A table-by-table pass over bank `$0d` took it from **30 INCBIN blobs to 6**
and from 37.2% to **49.2% proven code**. The Treasure Box and Medallion
Match state machines turned out to be near-exact structural clones of the
Shooting Star one, so every function in them fell out as a twin of an
already-named routine (`Advance*ActorState`, `IsBallIn*HitZone`,
`Award*HitScore`, `Draw*Sprite`, `Draw*HitCountdown`,
`Project*WorldPosition`), and their score tables corroborate it — Treasure
Box's box values are `05 0a 32 64` with multipliers `01 02 04 08` and an
`IncrementCappedCounter` cap of exactly 4, matching the table length.
`d_5d2c` (6 bytes) is an **orphan**: `$0064, $012c, $270f` is byte-identical
to the first three words of `MinigameTargetScores` row 7 — the Medallion
Match row (100 / 300 / 9999) — and nothing in the ROM references it. No
inline base computes it, no register load names it, and the `ret` at
`$5d2b` in front of it means nothing falls through either. It sits in the
gap between two hook handlers, so it looks like a leftover from a layout
where each minigame's targets lived beside its own code before they were
consolidated into the central table. Declared `records:2` as
`Unused_0d` so the source states that rather than leaving a mystery
blob; **bank `$0d` now has no INCBIN blobs at all.**

The last real blob, `d_5b4b.bin` (122 bytes), is the Treasure Box spawn
data, and the state-0 handler at `$5adf` reads all of it: two 16-entry
**box-type pools** picked by testing `[$c780] - 11`'s sign, so the
100-point box (type 3, per `TreasureBoxValuesByType` = 5/10/50/100) only
enters the pool after 11 shots; then a 5-word table indexed by the
target-zone id `[$c7a5]`, each pointing at four (X, depth) **spawn points**
one of which `AdvanceMatchRng & $03` selects. The five 16-byte blocks fill
exactly up to `IsBallInTreasureBoxHitZone`.

Carving them also surfaced a `cp a, $09` against `wCurrentShotType` that
the enum pass had missed because the routine was still a data blob; it is
now `SHOTTYPE_SMASH`, matching its Shooting Star twin. Three declarations were simply
wrong and are corrected (see the commit log): `$427f` was two tables (cell
tiles + cell attrs, proved by the two inline bases
`DrawMinigameGridCell` builds and the tile-vs-attribute shadow buffers each
pair is copied into), `$4f06`/`$5000` had a 5-byte stride where
`CopyTextRect` uses `bc = $0a05` = 10 wide x 5 tall, and `$5941` was 56
bytes where both readers take exactly `$18`.

`d_4546.bin` (306 bytes) turned out to be **seven** tables, delimited by
the index expression at `$46f7` (`$c784 = min(shotCount / 10, 25)`, which
pins the 26-row extent): the shot difficulty ramp, shot interval by tempo,
the 9x16 aim pools sampled by `rng & $0f`, the spin pool, a 3x3 court
coordinate grid that renders self-evidently once carved, and the ball
launch heights and speeds — ending flush at `$4678`.

Two mechanisms were added to `disasm.py`, both mirroring `mode_hooks`:

* **`minigame_configs`** — walks a config pointer table and seeds each
  config's `+$0c` init routine, which `InitMinigameFromConfig` calls
  through `JumpToHL`. All 18 were buried inside their config's blob. The
  configs themselves are now `bytes:16`, so each renders as one readable
  row rather than an opaque INCBIN.
* **Actor handlers are seeded *before* the jump-table fixpoint**, not
  after. A handler's body opens with a `rst Rst00` jumptable, so seeding it
  afterwards left the dispatch targets undecoded — which is why the
  Treasure Box and Medallion Match state machines sat in 538- and 320-byte
  blobs.

That reordering exposed a latent trap worth recording. Both of those
jumptables **over-run by one entry** into the `ld hl, $dc72 / inc [hl] /
ret` helper that follows them, reading its `21 72` bytes as a target of
`$7221` — which lands in the bank's 4,647-byte `$ff` fill. Because `$ff`
decodes as a valid one-byte `rst $38` that does not end flow, descent from
there ran to the end of the bank and turned 3,551 filler bytes into
instructions (`rst Rst38` ROM-wide went 20 -> 3,571) while still building
byte-perfect. The Shooting Star handler had escaped this only because its
helper was already proven code, so the walk stopped on a `code_bytes` hit.
`Disassembly._target_in_fill` now rejects any jump-table entry whose target
begins a run of 16+ `$ff` bytes; that is never a real handler, and it makes
the walk's termination independent of what happens to be decoded yet.

**`rst Rst38` in the generated source is a good ROM-wide smell test for
this class of bug** — an `$ff` data byte decoded as an opcode. It found the
bank `$17` and bank `$38` problems below, and caught this regression
immediately.

### Minigame actor handlers and score tables (bank $0d, 2026-07-24)

`SetMinigameActorHandler` stores its `de` argument for the actor engine to
call each frame, so the pointer is never dereferenced at the load site and
`pointer_load_targets`' use-gate skipped it — four `ld de, $xxxx` installs
stayed numeric and two of their handlers sat inside data blobs.
`ACTOR_HANDLER_INSTALL` + `actor_handler_sites`/`_targets` in `disasm.py`
now mirror the `RegisterFrameTask` treatment: the sites are seeded as code,
labelled, and merged into `ptr_sites` so the install renders symbolically.
Each target is a minigame's actor state machine, dispatching on the actor
state byte `$dc72` through an `rst Rst00` jumptable —
`ShootingStarTargetActorHandler`, `BooBlastControllerActorHandler`,
`TreasureBoxTargetActorHandler` and `MedallionMatchTargetActorHandler`.

`$537e` is `TargetReticleAnimFrames`: 32 entries indexed by
`hVBlankCounter & $1f`, which `DrawTargetReticleSprite` uses to upload a
new reticle tile frame on phases 0/8/16/24 (frames 0, 1, 2, 1; `$ff`
elsewhere means "no upload this frame", and the tiles persist in VRAM in
between). So it is a four-step ping-pong at 8 frames per step, not a blink.
Note the upload goes through `QueueMatchSpriteFrameA` (`$28:$606c`), which
is a VRAM tile copy, not an OAM queue.

The 92-byte blob at `$414a` is **two** target-score tables, picked between
by id in `GetMinigameTargetScore`:
`MinigamePracticeTargetScores` (`$414a`, 10 words, ids `$12`-`$1b`) —
Tennis Machine 1-4 escalate 15/30/60/100, Wall Practice 1-4 are all 50,
and the two High Score modes are `$270f`; and `MinigameTargetScores`
(`$415e`), indexed `(id - $1c) * 4 + wMinigameLevel`, rendering as 9 rows
of 4 words, one per minigame. `InitMinigameScore` stores the result in
`wMinigamesTargetScore`. `$270f` is the score *ceiling* rather than a real
target — `AddToMinigameScore` clamps there on overflow, and it is what both
endless High Score modes use.

### Actor-script `as_set_pos` / `as_set_target` were swapped (2026-07-24)

Actor-script opcodes `$03` and `$04` had their macro names the wrong way
round, in `include/macros.inc`, `disasm.py`'s `ACTOR_SCRIPT_OPS` and
`docs/actor_script.md` alike. Their two handlers are byte-identical apart
from two bytes:

```
$04:$4556 (op $03)  ... c6 0c ...  cb be ...   add a,$0c / res 7,[hl]
$04:$457b (op $04)  ... c6 08 ...  cb fe ...   add a,$08 / set 7,[hl]
```

The raw setters settle which field is which: `SetActorPositionRaw`
(`$0a:$43d8`) writes `+$0c` and `SetActorMoveTargetRaw` (`$0a:$441f`)
writes `+$08`. So op `$03` writes the *current position* and clears the
`+$05` bit7 move flag (a teleport), while op `$04` writes the *move
target* and sets that flag (starts a move) — the opposite of what the
names said. Swapped in all three places; 582 call sites re-render and the
build stays byte-perfect. The `as_set_target` / `as_wait_move` patrol
idiom now reads correctly.

### Ball-physics RAM named; the court's world scale (2026-07-24)

The `$c4xx` page is the ball-physics / shot-solver core, and 66 of its
addresses are now named. The world scale falls out of `$c484`/`$c486`
(`wCourtLimitX`/`wCourtLimitDepth`), which hold the in-bounds limits
**negated**: `$fe50` = -`$1b0` singles sideline, `$fdc0` = -`$240` doubles,
`$fb20` = -`$4e0` baseline, tightened to `$fd60` = -`$2a0` (the service
line) while a serve is in flight.

That answers what the shot solver's `$0140` and `$0480` constants are —
a small margin past the net, and a point just inside the baseline, i.e.
the near and far bounds of the legal landing region. So `$c48a`/`$c48c`
are `wShotDistMin`/`wShotDistMax`, the distances to those bounds along the
aim line, and `$c48e`/`$c48f` are the same values `>> 6`: the first and
last row indices `SeekBallTrajEntry6`/`4` walks between, matching the
`(de*4)>>8` the `BallTrajEntryPtr*` helpers compute. `$c48c` is
additionally clamped to the sideline crossing when the aim line would
leave the court before reaching `$0480` (`$07:$582c`).

`$c488` is `wNetHeight` (`$0060`; zero in netless minigames): `$08:$5830`
adds it to `wBallHeight` at the net crossing and, when the ball is not
clear, plays the net sound and negates the depth velocity.

Also named: the spin pair driving `ApplyBallSpin`'s two rotations, the
previous-frame ball position snapshot, the ball-to-character delta vector,
the shot aim target and delta, the match camera position/target pairs
(`wMatchCamera*` — `wCameraX`/`wCameraY` are already the BG scroll
buffer), the bounce/net/hit event flags, court surface friction and
restitution, and the pause-menu, rules-page and scoreboard state.

Left numeric on purpose: `$c4c8` (bits mean different things per
subsystem), `$c4cc` (set at three different set/tiebreak boundaries), the
write-only addresses, and the `$c400`/`$c420` struct bases whose integer
parts are already named.

### Bank $1e graphics streams identified (2026-07-24)

All 15 of bank `$1e`'s LZ streams were decompressed and rendered, and each
of its three screens turned out to have a clean gfx / tilemap / attrmap
set. The word art reads directly: `ResultsScreenGfx_1e` (176 tiles)
carries 7x2 plates spelling **SINGLES** and **DOUBLES**, and
`GameProgressHeaderGfx_1e` spells **CLEAR STATUS** — cross-confirmed by
the label tilemaps, which are literally those plates' tile indices
(`$09`-`$0f`/`$19`-`$1f`, `$29`-`$2f`/`$39`-`$3f`, and rows `$02`-`$09` /
`$12`-`$19`). `ExpDigitSpriteGfx_1e` is a 20-tile 8x16 sprite digit font
that `GetDigitSpriteTile` (`$5afa`: `sub $30` / `rlca` / `add $6c`)
indexes for the counting-up EXP total; it loads to `$86c0`, below `$8800`,
so it can only be OBJ tiles. `PanelFrameGfx_1e` is shared by the results
and EXP screens — the 8-piece window border whose tiles `$02`-`$09` are
the corners and edges those screens' panel builders write.

### Naming sweep: menu, results, story and dictionary banks (2026-07-24)

A twenty-bank naming pass took human-named symbols from 4,816 to 5,476
(+660), split between ROM labels in `labels.json` and 93 RAM addresses in
`ram_map.json`/`ram_unions.json`. Config-only throughout — no hand edits
to `src/`, which is fully generated — plus two `data_tables.json` widths;
byte-perfect at every step.

After this pass only about 55 auto-named functions remain ROM-wide, the
worst bank holding 10 — down from 123 in bank `$38` alone.

A later wave covered the tail: banks `$09`/`$11`/`$06`/`$2c` (46), banks
`$04`/`$0e`/`$0a`/`$18`/`$05` (31, including bank `$04`'s complete
per-frame actor pipeline and bank `$0e`'s star-warp transition to Peach's
court), bank `$1e`'s 15 graphics streams, and the
`$c4xx` physics page (66 RAM addresses, above). Bank `$2c` came almost
free — banks `$21`-`$24` and `$29`-`$2b` are the same ball-path code
already named, so its ten functions map instruction-for-instruction onto
curated siblings. Two more curated misnomers fell out: **actor field
`+$37` is the OAM attribute byte**, which resolves `Func_11_4d68` as
`KnockPlayerAirborneFlipped_11` (`xor $40` = hardware bit 6, the Y-flip,
on a player launched upward in `LateStudentCrashCutscene`); and
`UpdateGameScoreDisplay` never reads `wPlayer*GamesWon` at all — it and
its sibling both render the *point* score, differing only in widget
(`$8780` digits vs the `$8300` panel, where the DEUCE/AD art also goes),
so they are now `UpdatePointDigitsDisplay` and `UpdateScorePanelDisplay`.

Per bank: `$38` 123 (match-format menu, story character/partner picker,
exhibition and link character grids, name entry), `$1e` 99 (match results,
EXP award, game-progress checklist), `$1d` 74 (character-data carousel,
post-match EXP distribution), `$10` 69 (match-select handler tree, 35
`load_match_settings` launcher stubs, Restaurant/Academy maps), `$1a` 58
(minigame pause menu, debug EXP editor, EXP-gain screen, debug character
viewer), `$3f` 23 (Tennis Dictionary), `$13`/`$14` 44 (dorm and courtyard
scenes, Island Sky fireworks), `$15`/`$27`/`$0f`/`$01` 56, `$17` 13
(rules/briefing diagrams), `$0d` 8 (minigame hook tables).

Things that fell out of the pass and are worth keeping:

* **Minigame mode hooks.** Each bank `$0d` minigame config's `+$08`
  pointer is an 8-slot `CallModeHook` table: 0 per-frame, 1 point start,
  2 point end, 3 minigame start, 4 ball hit, 5 bounce, 6 rally tick,
  7 draw.
* **Tile-trigger encoding.** The behavior byte a story scene writes to arm
  a tile trigger is `(trigger_id << 4) | 1`, cross-checked across banks
  `$13`, `$11` and `$0f`.
* **Actor field `+$37` is the OAM attribute byte** — bit 5 X-flip, bit 6
  Y-flip, low bits the palette taken from
  `wStoryModeMainCharacterOverworldSpriteColor`.
* **Match-select bug.** Singles menu slot 8 ("Varsity-S Rank 4")
  dispatches to a duplicate of the Junior #3 launcher (`$0002`) instead
  of `$000b`, so that handler is named `LoadMatchSinglesJunior3Alias`
  rather than after its caption.
* Two curated labels were **misidentified and corrected**:
  `TileGrid3x3_1d_6f35` is not a 3x3 grid but the 9-entry fill ramp for
  the 8-cell level bar (now `ExpBarFillTiles_1d`, `data_tables.json` width
  3 → 9), and `DrillDisplayData2_1d` is a frame of the EXP-screen confirm
  window, not drill data (now `ExpPromptWindowFrame_1d`). `StoryCmdHandlersC_13`
  (`$13:$526a`) is not a command-handler table either: the curated
  `SetRandomDormRoomNpc04Script_13` right above it picks a random index 0-7
  and reads it through the `add a,$6a` / `adc a,$52` inline-base trick, so
  it is the dorm NPC's idle-script list (now `DormRoomNpc04IdleScripts_13`).

Deliberately left alone: `Func_38_591b` (three prerendered label strips
that could not be identified), the bank `$1e` flag-group cluster at
`$6c62`-`$6c93`, and `Func_1e_6d82` — that one is the *body* of the
progress-entry flag-id table starting at `$6d80`, so it wants a carving
fix rather than a rename.

### Story character record fields + scoped HRAM scratch (2026-07-24)

`$cb00` is `wStoryCharacterSlot`: which of the two story character records
the character-select, name-entry and character-data screens act on
(0 = main, 1 = partner). Every consumer uses it as a `$40`-stride index
into the `wStoryModeMainCharacter*`/`wStoryModePartnerCharacter*` pair, and
`GetActiveStoryNameBuffer` (`$38:$73fa`) returns
`wStoryModeNameOfMainCharacter` or `...OfPartnerCharacter` straight off it.
184 sites across banks `$0a`, `$18`, `$1a`, `$1b`, `$1c`, `$1d`, `$38`.

That in turn opened up the story character record layout. Offset **`+$0e`
is a left-handed flag** (`$c90e`/`$c94e`, now
`wStoryMode*CharacterLeftHanded`), proven three ways: character select
writes `wCharSelectHandedness` there (`$38:$48ba`); the bank `$02`
new-game path sets it from bit 2 of the character id (`$02:$51c5`, which
is why the id is masked `and a,$07` then `res 2,d`); and bank `$17` reads
it to swap the spin-serve briefing between `$36:696` ("So serve to the
right with topspin and to the left with slice.") and `$36:697`, its exact
mirror. `wCharSelectHandedness` (`$cb50`) is itself pinned by text
`$30:118` "START: Change Hands", by START being its only writer
(`xor $01` at `$38:$48fc`), and by its only effect being OAM bit 5
(X-flip) on the four character sprites.

Offset **`+$0d` is the character's gender** (`$00` male, `$01` female):
`$c90d` is `wStoryModeGenderOfMainCharacter`, `$c94d` is
`wStoryModeGenderOfPartnerCharacter`. `InitPlayerRecordFromTemplate`
copies it out of `StoryCharGenderTable` (`$02:$441b`), and it is read-only
thereafter — 24 + 28 absolute reads, no writes, persisting through the
save. Two text pairs prove it, each selected by advancing the dialogue
cursor one entry on the flag:

```
$10:$7844   30:433  This is .\nTake good care\nof him, OK?     gender 0
            30:434  This is .\nTake good care\nof her, OK?     gender 1
$13:$49b8   31:60   He's , the\nAcademy's newest\nstudent.     gender 0
            31:61   She's , the\nAcademy's newest\nstudent.    gender 1
```

Everything else lines up: banks `$0f`/`$11`/`$14`/`$15`/`$27` use it as
`objdef $56 + gender` (player), `$58 + gender` (partner) and
`$26 + gender` (NPC) to pick male/female overworld sprites,
`SpawnCompanionActor` (`$04:$4f10`) picks between two actor blobs on it,
`$12:$4158` sends you to a different dorm on it, and `$13:$78c4` builds
`(main << 1) | (main XOR partner)` — a four-way M/M, M/F, F/M, F/F scene
key.

The table itself was over-run: only entries 0-3 are reachable (the id is
masked `and a,$03` at `$43a5`, and `GetPlayerRecordPtr` only ever selects
the main/partner records), and they read `$00, $01, $00, $01` for
Alex/Nina/Harry/Kate. The 28 bytes that followed were swept into the same
blob only because the next label is 32 bytes away; nothing in the ROM
references them and their values contradict gender for the wider roster
(Curt, Sean, Luigi, Mario and Bowser are 1; Allie, Pam, Fay, Sammi, Emily
and Peach are 0). They are now split off as `Unused_02`.

`$ffb0-$ffb3` is a pair of 16-bit HRAM slots each caller repurposes, so it
is modeled as a `ram_unions.json` overlay rather than named globally:
bank `$02` uses it in `ComputeLevelUpStatDeltas` (`hStatDeltaOutPtr`, the
caller-supplied output pointer, and `hStatDeltaRecordCopy`, pointing at
the 64-byte stack copy of the player record taken before
`LevelUpPlayerRecord`), and bank `$03` keeps `hSaveEditorCursor` there —
`SaveSlotDebugEditor`'s cursor offset into the `$d300` block, wrapped to
`$400` by masking the high byte with `$03`. `Func_03_524f` is that
editor's cursor helper (`MoveSaveEditorCursor`); its four D-pad branches
pass `bc` = (value step, cursor step): up `$f0f8`, left `$ffff`, right
`$0101`, down `$1008`. Scoping matters here — banks `$0f` and `$10` load
`$ffb0` as the immediate constant −80, not as an address, and correctly
stay numeric.

The `$cbxx` page turned out to be several disjoint tenants rather than one
subsystem, so the rest could be named globally: the animated-tile task
inputs (`$cb0b`/`$cb0c`), the bank `$1a` menu-window handle and
`RunMenuSelectionShared`'s per-row masks (`$cb26`-`$cb29`), the Study
Vocabulary scroll model (`$cb2d`-`$cb37`), the intro-cutscene scroll
position (`$cb4a`, 16-bit), the court unlock masks (`$cb53`/`$cb54`), the
character-select handedness and partner-pick flags (`$cb50`/`$cb52`), and
the debug character viewer's page/index (`$cb62`/`$cb63`).

Left unnamed on purpose, for the same reason `$c2b0-$c2ff` is:
**`$cb2a`** mixes a menu LEFT/RIGHT adjust direction (low nibble) with a
debug-HUD enable (bit 5), and **`$cb44`-`$cb47`** is intro-cutscene
per-state scratch whose meaning changes between states of the same state
machine (`$cb44` is a sprite X in states 01-05 but is copied to
`hScrollY` in states 17-18). The **`$c4xx` page is the ball-physics /
shot-solver core** and wants its own pass: `$c48a`+`$c48c` are 16-bit
aim-line distances computed at `$07:$5787`/`$07:$57bc` as
`(|wBallDepth| + $0140 or $0480) / sin(wShotAimAngle)`, with
`$c48e`/`$c48f` holding the same values ÷64 — the row index the per-court
`BallTrajEntryPtr*` helpers derive.

### Open questions from the 2026-07-24 pass

* **What are the 28 bytes of `Unused_02`?** Nothing references them
  and they match no attribute I could find. Labelled unused rather than
  guessed at.
* **The `$14` "WaterSprite" object is a plane** (settled 2026-07-24).
  `SpriteTemplate_14_5e50` is a 4-column x 2-row block of 8x16 sprites — a
  32x32 image in four scale steps whose tile base (`$00`/`$10`/`$20`/`$30`)
  `QueuePlaneSpriteByHeight_14` picks from altitude, stepping up and back
  down as the object approaches and recedes. Assembling both tilesets that
  way renders an unmistakable aircraft from two view angles: fuselage,
  full-span wing, tail fin and engine nacelles. So the four labels tied to
  those graphics are renamed `LoadPlaneObjGfx_14`, `LoadPlaneObjGfx2_14`,
  `GetSceneObjectScreenPos_14` and `PlayPlaneMoveSfx_14`.

  Still open: the *other* `WaterSprite*` cluster in the same bank
  (`RunWaterSpriteSwingContestAndReward`, `WaterSpriteSwingCountTask`,
  `DrawWaterSpriteMinigameCounters`, ...) is a separate swing-count
  subsystem that nothing here disproves, and it is tied to the
  RetroAchievements-sourced `wWaterSpriteMinigame*` RAM names — which
  STATUS already flags as mis-scoped into the `$c2b0-$c2ff` story-script
  scratch pool. Left alone pending its own pass.

### Pause-menu rules pages carved (bank $06, 2026-07-22)

Split bank `$06`'s 180-byte `$4262` blob into the two tables
`ShowMinigameRulesPages` (`$421d`) indexes with the inline
`add a,lo / adc a,hi / sub a,l` base trick (which leaves no label reference for
the auto-carver to follow): `MinigameRulesTextIdBases` (`$4262`, 9 words) and
`MinigameRulesPageLists` (`$4274`, 27 x 6 bytes = 9 minigames x 3 levels, each
a `$ff`-terminated list of page offsets added to the base id). Also named the
sibling lists `MatchRulesPageLists` (`$4165`) and `TrainingRulesPageLists`
(`$41a9`), fed to the same `ShowRulesPageSequence` (`$4316`). All three now use
the `rules_pages` macro (below), which writes just the page offsets and pads
each list out to the array stride with the `$ff` terminator. The base ids
decode (bank `$26`) to each minigame's rules text and confirm the layout:
Boo Blast `26:135`, Shooting Star `26:141`, Perfect Shot `26:146`, Target Shot
`26:150`, Fruit Fantasy `26:159`, Banana Bunch `26:162`, Treasure Box `26:165`,
Medallion Match `26:177`, Two-on-One `26:189`; captions come from `26:71+slot`
(the "<Minigame>: Level N" strings). Config-only; byte-perfect.

### Match menu item graphics carved (bank $06, 2026-07-22)

Split bank `$06`'s 2,630-byte `$5244` blob — another inline-base table
(`LoadMatchMenuItemGfx` `$5219`) — into `MatchMenuItemGfxPointers` (`$5244`,
24 words, one per menu item id, now rendering symbolically), 12 bytes of
alignment padding, `ScoreboardModeGfxTail` (`$5280`, 4 raw tiles copied to VRAM
`$8640`, continuing the 20 tiles `LoadScoreboardModeGfx` decompresses to
`$8500`), and 17 distinct LZ streams. Each stream was decompressed and rendered
to identify the word art, so they carry real names:
`MatchMenuItemGfx_Rules`/`_Controls`/`_Options`/`_Save`/`_CameraMode`/`_Music`/
`_Normal`/`_Player`/`_On`/`_Off`/`_Cancel`/`_SaveNarrow`/`_ToMainMenu`/
`_ToLevelSelect`/`_TryAgain`/`_QuitMatch`/`_QuitMinigame`. Item ids 14-18 share
the "TRY AGAIN" stream and 20-23 share "QUIT MINI-GAME", which matches the menu
tables at `$466f` (ids `$00-$17`) and the item captions at text `$013f + id`
(bank `$30` indices 319-342). Byte-perfect.

### Vector-called directory slots (2026-07-23)

Two `$4000` directory slots held a code pointer that no `farcall` operand
references — they are entered through `CallVectorEntryA` (`$00:$01e6`) with a
computed slot index — so nothing proved their kind and the entry bytes rendered
as two loose `db`s between their labeled neighbours. `STATIC_CODE_SLOTS` in
`disasm.py` now registers them, and both slots read as `farptr`:

* `$18:$4090` -> `DebugScreenAssetViewer` (`$7659`): a leftover viewer that
  cycles screen-asset records `$2c`-`$43`, one per button press, forever. Its
  record list is now `DebugScreenAssetViewerRecords` (`$769c`), which also
  freed the stray `ret` at `$769b` from the same blob.
* `$6d:$4026` -> `ShowIntroCharacterScreen` (`$6a7f`): loads screen-asset
  record 40 (a 4-tile blank background), the intro character tiles/palette and
  sprite block 3 via `IntroCharacterScreenFrameTask` (`$6abf`), then waits for
  A/B. Bank `$6b` drives the real intro cutscene with these same assets, so
  this looks like a leftover single-screen viewer.

The registration deliberately does not go into `inferred_entries`: that set
also tells `scan_data_slots` which banks hold code tables, and marking bank
`$6d` as one costs its unproven data slots their acceptance (slot `$20`, the
intro palettes, regressed to raw bytes when tried that way). The emitter merges
the curated entries in separately.

### Rest of bank $06 carved (2026-07-22)

Swept every remaining blob in the match/story menu bank. A regex pass over the
bank's inline-base idiom (`add a,lo / ld l,a / adc a,hi / sub a,l`) found all
23 code-computed table bases, and each was resolved to a pointer table plus its
payload:

* **Scoreboard window tilemaps** (`$4a83`, was one 1,474-byte `bytes:4` blob):
  `ScoreboardPipTiles`/`ScoreboardPipAttrs` (2x2 rects), the three
  `ScoreboardPip*Rect` descriptors `DrawScoreboardPip*` loads, six
  `ScoreboardTilemap0-5` + six `ScoreboardAttrmap0-5` (19x7, 19x5, 19x14 -- now
  rendering as real window frames row by row), the six-record
  `ScoreboardTilemapDesc0-5` array (`{height, width, tiles, attrs}`, verified by
  chaining each pointer to the next map) and `ScoreboardTilemapPointers`
  (`$5035`, by `$c494`).
* **Scoreboard sprite layouts**: `ScoreboardSpriteTemplatePointers` (`$509c`)
  over seven `SpriteTemplate_06_*` lists (`$50e2`-`$5218`) -- the `$80`
  terminators meant the old `bytes:4` stride rendered them shifted.
* **Mode banners**: `ScoreboardModeGfxPointers` (`$5cc9`, 11 by game mode) and
  `ScoreboardMinigameGfxPointers` (`$5cdf`, 42 by story match) over 15 LZ
  streams, each decompressed and read off the tiles:
  `ScoreboardModeGfx_RankingMatch`/`_IslandOpen`/`_PracticeMatch`/`_Exhibition`/
  `_MiniGames`/`_TennisMachine`/`_WallPractice`/`_MarioMiniGames`/
  `_LinkedMatch`/`_ServiceMatch`/`_ServicePractice`/`_NetPlayMatch`/
  `_NetPlayPractice`/`_StrokeMatch`/`_StrokePractice`.
* **Story menu item graphics**: `StoryMenuItemGfxPointers` (`$72ae`) over eight
  new streams (`_Status`, `_ClearStatus`, `_Messages`, `_Slow`, `_Fast`,
  `_CharData`, `_Items`, `_Normal`) plus eight shared with the match menu, which
  now show up as cross-references to the `MatchMenuItemGfx_*` labels.
* **Menu geometry**: `MatchMenuDefs`/`StoryMenuDefs` (`$466f`/`$6ce0`), whose
  8-byte records now use a `menu_def` macro that takes just the item ids and
  derives the stored count from the argument list (see below), `SaveQuitMenuIdByGameMode` (`$44f3`), the
  item/cursor position pools split by menu size (`*Pos2Items`/`3Items`/
  `4Items`), the three story cursor-position tables, and the item rect arrays
  `MatchMenuItemRectPointers` (`$6835`, 24 items over 16 `MatchMenuItemRect_*`
  + `MatchMenuItemAttr_*` pairs, rendered with a `rect_ptrs` record per item)
  and `StoryMenuItemRectPointers` (`$77cb`), whose 16 targets are
  labeled per item (`StoryMenuItemRect_Status` ... `_Items`, same suffixes as
  the `StoryMenuItemGfx_*` streams since both tables share the item-id space)
  and render as 3x2 `tilemap` blocks. `StoryMenuDefs` confirms the mapping:
  its menus are contiguous id runs that group exactly as the graphics do --
  {0-3} = STATUS/CLEAR STATUS/OPTIONS/SAVE, {14,15} = CHAR. DATA/ITEMS,
  {4,5} = MESSAGES/MUSIC, {6,7,8} = SLOW/NORMAL/FAST, {9,10} = ON/OFF,
  {11,12,13} = SAVE/TO MAIN MENU/CANCEL.
* **`DebugStatNamePointers`** (`$6a39`): a 15-word table that had been swallowed
  into the following text stream and rendered as ASCII garbage. Each of its
  strings (" SPEED"/" ADD"/.../"@DIVE") is now labeled `DebugStatName_*`, so
  the table reads symbolically. Two `disasm.py` changes back this: a text run
  starting at a labeled offset keeps the curated label instead of the generated
  `Text_bb_xxxx` one, and a *labeled* short all-ASCII run (3-31 bytes, below
  the auto-detection floors) now renders as a text include rather than a binary
  blob. The latter also turned three previously opaque blobs elsewhere into
  readable strings: `SaveSignature` ("CAMELOTGBTENNIS"), `HexDigitChars_05`
  ("0123456789ABCDEF") and `EnterNameText_38` ("Enter Name").
* **44 bytes of stranded code** at `$698b` (draws a 12x2 caption rect pair, then
  menu item `$05` when `$c4c8` is set) sat inside the `$6835` blob; seeded via
  `coverage/bank006_static2.json`. Nothing in the bank references it, so it is
  either dead or entered through RAM dispatch.

Bank `$06` now has no unlabeled data outside three alignment-padding runs.
Byte-perfect.

### tilemap / rect_pair macros (2026-07-22)

Two new data specs, so rectangular tilemap data reads as a rectangle and the
assembler checks the carve:

* `tilemap:W` renders a block as `tilemap_begin W, H` + one `tilemap_row` per
  row + `tilemap_end`. `tilemap_row` asserts its argument count equals the
  declared width, and `tilemap_end` asserts the row count and total size -- so
  a mis-guessed width now fails the build (`tilemap_row: 19 bytes, width is
  18`) instead of quietly rendering ragged rows. The macros emit only the row
  bytes, so the data round-trips unchanged.
* `rect_pair` renders a `{height, width, tiles, attrs}` CopyTextRectPair
  descriptor with both pointers resolved to their block labels; `rect_ptrs` is
  its pointer-only sibling for rectangles whose geometry lives in the code.
* `rules_pages:<stride>` renders a rules-screen page list as just its page
  offsets; `rules_pages_stride` declares the array stride once per table and
  the macro pads each list with the `$ff` terminator, asserting there is room
  for one. Lists whose tail isn't clean `$ff` padding stay literal `db` rows
  (none in bank `$06`: all 6 + 29 + 27 lists fit).
* `menu_def:<PREFIX>` renders a pause-menu record as just its item ids, named
  from the `<PREFIX>_*` constants: `menu_def MATCHMENUITEM_SAVE_GAME,
  MATCHMENUITEM_QUIT_GAME, MATCHMENUITEM_CANCEL`. The macro emits the ids,
  pads the unused id slots, and writes the stored count as `_NARG` -- so the
  count can no longer disagree with the list (adding an id to a menu and
  rebuilding changes the count byte too). Records that don't fit the shape
  (count out of range, non-zero padding) fall back to a literal `db` row, and
  all 21 records in bank `$06` fit. The two id sets are documented as
  `MATCHMENUITEM_*` / `STORYMENUITEM_*` in `constants.inc`, each name taken
  from the item's own caption text (`$013f + id` / `$0162 + id`, bank `$30`),
  with the word art noted in a trailing comment where it differs.

Applied to bank `$06`'s scoreboard windows (six tilemap/attrmap pairs, the
three score pips, the three 12x2 caption rects) and their nine descriptors.
Both specs live in `render_spec` (`tools/extract.py`), so they work for inline
`data_tables.json` runs and for extracted blob files alike.

### Match ball renderer WRAM + scoped interior-byte expansion (2026-07-22)

Named the bank-4 ball-renderer state via `wram_bank $04` scoping (+ bank `$08`
renderer range): `wBallHistory` (`$dd00`, the 36-byte position-history ring) and
the ball sprite slots `wNetBallSlot`/`wBallSlot`/`wBallShadowSlot`/
`wBallTrailSlots` (`$de00-$de1f`). The same `$dd`/`$de` offsets are heavily
aliased — ~11 other banks touch them under non-4 WRAM banks — and all correctly
stay numeric. Also extended scoped-union symbols to **interior-byte expansion**
(previously only `ram_map.json` symbols expanded): a reference to an interior
byte of a multi-byte scoped field renders `name + k`, so `$dd1e` reads
`wBallHistory + 30`, and retroactively the sound/char unions' 16-bit pointers
and multi-byte fields (`hSndScriptPtr + 1`, `wCharPosX + 1`) now read
symbolically too. 48 ball-renderer references across match banks `$08`/`$0a`/
`$0d`; byte-perfect.

### Match per-character struct named via WRAM-bank scoping (2026-07-22)

Applied the new `wram_bank` scoping (below) to the match engine's per-character
struct at `$df00-$df96`, replicated across WRAM banks 4-7 (bank = character:
4 near-P1, 5 far-P1, 6 near-partner, 7 far-partner). 32 fields named once each
(`wCharPosX`/`wCharPosDepth`/`wCharPosHeight`, `wCharState`, `wCharActive`,
`wCharVel*`, `wCharWalkTarget*`, `wCharFacing*`, `wCharSpriteSlot`/shadow slots,
`wCharDepthKey`, the shot speed/placement indices, …) — **306 references across
10 match banks**, up from 7 leak-prone globals. The 7 pre-existing fields
(`wGroundStrokeSpeedIndex` etc.) moved out of `ram_map.json` (where they leaked
into every bank) into the scoped union. Scope: `wram_bank $04-$07` (catches the
statically-banked accesses anywhere, incl. bank `$38` whose 13 *non-char*
`$dfxx` accesses correctly stay numeric) plus match banks `$07`/`$08` as ROM
ranges (their char accesses run through `ForEachCharBank`'s `jp hl`, which the
dataflow can't follow). A second, higher-priority union variant names `$df00`
`wTextArgFetchBuffer` in menu banks `$0e`/`$0f`/`$12`, where the idle char
struct is reused as a text-arg scratch buffer — so those 6 sites read correctly
instead of as `wCharPosX`. Config-only; byte-perfect. See docs/ram_map.md.

### WRAM-bank-aware RAM symbol scoping (2026-07-22)

Banked WRAMX (`$d000-$dfff`) and SRAM (`$a000-$bfff`) are bank-switched, but
`ram_map.json` names are bank-blind — a `$dxxx` name rendered in every bank,
which mislabeled ~18 banks that reuse the sound engine's `$d1xx` offsets in
their own WRAM bank. `ram_unions.json` scopes now accept `{"wram_bank": N}`
in addition to (or combined with) the ROM-location `{bank, start, end}`.
`disasm.py`'s new `compute_wram_bank` runs a forward control-flow dataflow
that tracks the WRAM bank (`$ff70`/rSVBK) provably selected at each
instruction — seeded by the `wram_bank`/`ld a,N; ldh [rWBK],a` idiom, `a`
tracked through it, calls assumed to preserve the bank (return edge keeps the
pre-call bank; the caller's bank flows into the callee so single-context
helpers inherit it). Where the bank is unknown or conflicting, the name stays
numeric. This is a text-only concern (RAM operands never change assembled
bytes), so a wrong inference can only mislabel, never break the byte-perfect
compare. The sound-engine WRAM union uses `wram_bank $07` (with the bank-0
code range retained as a fallback for the few driver sites where an
assume-preserved call — e.g. `PlaySound`'s SFX path through `StopAllSound`,
which leaves bank 7 selected — defeats the dataflow).

### Bank 0 sound engine mapped (2026-07-22)

Reverse-engineered the bank-0 music/SFX driver (`$3078`–`$3ddf`) and named its
state. The per-channel state is a 32-byte block (`wSndChannels` `$d100`, 6
slots) mirrored into an HRAM working set at `$ffd0` while a channel is serviced;
all 28 HRAM fields (`hSndScriptPtr` … `hSndRestFlag`) are now named in the
sound-driver variant of the `$ffd0` union (`ram_unions.json`, scoped to
`$3373`–`$3de0`, extended to `$fff0` to cover the loop/rest bytes), and the
per-pass globals `$d208`–`$d219` (`wSndActiveMask`, `wSndChannelType`,
`wSndRegBase`, `wSndPanShadow`, …). The whole `$d100`–`$d219` block is a
`wram_bank $07`-scoped union (see the WRAM-bank section above), so the same
offsets in other WRAM banks stay numeric. Named the per-tick effect
`TickInstrumentEnvelope` (`$3a40`, was `Func_00_3a40`) plus the `SndTriggerNote`
/ `SndSilenceChannel` / `SndReleaseChannel` script handlers. Config-only
(labels.json + ram_map.json + ram_unions.json); byte-perfect. Full architecture,
HRAM/global field tables, and the `$a0`–`$ef` command set are in
[docs/sound_engine.md](sound_engine.md).

### Relative labels for interior bytes of multi-byte RAM vars (2026-07-21)

`load_ram_map` now expands each sized `ram_map.json` variable so a reference to
an *interior* byte renders as `name + k` instead of a raw address -- e.g. the
low byte of the 16-bit BE `wCurrentMinigameStoryMatch` ($c8f6) reads
`[wCurrentMinigameStoryMatch + 1]` at all 61 sites. An interior byte that is
itself a named symbol keeps its own name (`setdefault` never overwrites an
explicit entry). Flows through both operand paths (`[$addr]` and pointer-setup
immediates) with no signature change; 305 references across 42 banks now read
symbolically (`wCameraX + 1`, `wShotAimAngle + 1`, `wBGPalettes + 34`, ...).
Byte-perfect.

### Carve code-indexed data tables (2026-07-21)

Swept every raw-INCBIN `Data_*` blob that a `ld hl/de/bc, imm` site loads as a
**table base** (28 candidates ROM-wide) and carved the 22 that are genuine
tables: each gets a `data_tables.json` render spec (so it emits structured
`db`/`dw` rows instead of an anonymous INCBIN) and a `labels.json` semantic
name (so the load reads symbolically). 21 blobs leave `data.manifest`; adding
the sibling `MatchSettingsTable_0a_4ab2` (whose raw `ld de, $4ab2` now resolves)
makes 23 new names across banks $03-$3f. Highlights: `MinigameClearFlagTable_1e`
(27 `SetSaveFlag` ids indexed `[(minigameId-$1c)*3 + level]`, set on a win by the
new `SetMinigameClearFlag`; `$c8f7` is the low byte of the BE
`wCurrentMinigameStoryMatch`, so $1c-$24 = the 9 minigames), `SramTextOffsetTable_05`
(16 `$a800`-relative offsets), `DpadMaskToAngleTable_04` (d-pad bitmask → 8-way
angle, $20 units), the `RankingFlagList_0a_*` `SetGameFlag` word lists, the
`{Singles,Doubles}MatchSettingsTable_0a` 5-byte record tables (chosen by the
category byte of `wCurrentMinigameStoryMatch`), `ObjectArrayASpawnTable`
(16 × 11-byte descriptors), `CharMugshotGfxPointers`, and the
`MatchUiTilemap{Tiles,Attrs}_0d` layer pair. Two blobs are name-only (kept as
INCBIN): `SelectionMaskGrid_3f` (a `$00`/`$40`-delimited bitmask stream,
not fixed-stride) and `ObjectArrayBSpawnTable` (16 records + a mixed tail).
Byte-perfect.

The 6 bank-$1a `ld de, $64xx` "candidates" (`$642c/643c/6454/6464/6474/6484`)
are **false positives**, left untouched: `QueueSprite` treats `de` as an OAM
*position* (e→Y, d→X), and the low bytes `$2c,$3c,$54,$64,$74,$84` are the
successive Y rows of a sprite column — coincidental 16-bit constants that alias
into a graphics blob, never dereferenced. They slip past `_pointer_load_used`
only because the `push de` that passes the position to `QueueSprite` matches the
computed-jump heuristic; tightening that gate is future work.

### Label obvious same-bank pointer loads (2026-07-21)

Swept every `ld bc/de/hl, imm` whose immediate is a same-bank pointer and named
its target so the load reads symbolically. `pointer_load_targets` in `disasm.py`
gates each site on a **pointer-use** test (`_pointer_load_used`): the loaded
value must be dereferenced (`[hl`/`[de]`/`[bc]`), dispatched (`jp hl`), pushed
for a computed jump, or used as a table base (`add hl, de/bc` then a deref).
This rejects coincidental 16-bit constants that alias an in-bank address -- e.g.
`ld de, $4000` before `add hl, de; jr c` (an overflow check), never
dereferenced. Targets landing mid-instruction are also rejected.

Naming is split by what emit can reliably define. Code targets (instruction
starts) get a `Func_` label; `data_tables` starts (e.g. the `$6b:$40bd` intro
cutscene jump table, loaded by three `ld de` sites) a `Data_` label. Pointers
into **unlabeled raw data** (`ptr_data_targets`) are split out of their blob and
named `Data_*` by emit's seg-loop -- but only when they are *not* interior to a
typed run (`data_tables` spec or slot-record table), so a table like the
`$3f:$444f` `records:2` block is never truncated (its `$4487` sub-pointer stays
raw). A final `resolve_pointer_loads` post-pass rewrites each load against the
label emit *actually* emitted (built by pairing every label line with the
following `; $cpu`), so text-table pointers resolve to their existing `Text_*`
label (`$37:$4004` -> `Text_37_4004`) and a target with no emitted label is left
as raw hex rather than an undefined symbol. 77 loads across 31 banks now read
symbolically (46 `Data_`, 18 `Func_`, 13 `Text_`; 36 new labels); the raw-blob
splits conserve bytes in `data.manifest`. Byte-perfect.

### Carve the intro-cutscene state dispatch ($6b:$40bd) (2026-07-21)

The `$6b:$40bd` blob the pointer-load pass had flattened to one 156-byte
`records:2` list is really a **two-level state-machine dispatch**, indexed by
`wCutsceneStep`: an 18-entry step->record pointer table (`$40bd..$40e0`, whose
entries point *back into* the same region -- the "references into the table"),
then 20 six-byte `{Init, Update, Exit}` handler records (`$40e1..$4159`). The
three loaders confirm it -- all do `table[step]` then jump through the record at
offset +0/+2/+4: `Func_6b_406a`=Init, `Label_6b_407c`=Update,
`Label_6b_4099`=Exit (each a double indirection ending in `jp hl`). Carved
config-only: typed `$40bd` (18-word step table) and each of the 20 record starts
as `records:2`. Named by **pool-index state + word-position role** (a record's
word 0/1/2 is Init/Update/Exit): `IntroCutsceneStateTable_6b` + 20
`IntroCutsceneState{00..19}_6b` records + 60
`IntroCutsceneState{NN}{Init,Update,Exit}_6b` handlers (the 54 not already
labelled were decoded code reached only via the computed `jp hl`, so descent
never named them). This supersedes the prior `Unused_6b_State11/12_*` labels:
`wCutsceneStep` inits to 0 and only increments, so the step sequence visits states
{0-10,13-19} and skips pool-records 11/12 -- but those are real defined states in
the machine (referenced by the record pool), not dead code, so they are named like
the rest. The step table now reads `dw IntroCutsceneState{NN}_6b` (making the
step->state remap explicit -- step 1 -> State15, step 9 -> State13, ...) and each
record is three role-named handler `dw`s. Byte-perfect.

### Map-table facing constants (2026-07-20)

Replaced the raw facing bytes in the three story map tables with named
constants. The `facing` field of `map_actor` and the (previously `sprite`,
now correctly labelled `facing`) field of `map_entry` hold an actor facing
byte whose top 2 bits are a direction index — verified against
`CheckTriggerFacingMask` (`$0a:$53bd`) and its `$0a:$53b9` index→PADF table
`[$10,$80,$20,$40]`: `$00`=Right, `$40`=Down, `$80`=Left, `$c0`=Up. Added
`FACE_RIGHT/DOWN/LEFT/UP` to `constants.inc`, plus `FACEMASK_ANY` (`$ff`) and
`FACEMASK_RIGHT/LEFT/UP/DOWN` (PADF-layout bits) for the `map_script`
`facing_mask` field. Deliberately separate names from the `PADF_*` joypad
masks even where values coincide (these are NPC/overworld facings, not
controls). `disasm.py`'s `render_map_table` emits them symbolically
(`ACTOR_FACING_NAMES`/`FACING_MASK_NAMES`); 1496 facing + 623 facing_mask
fields across banks `$0e-$15`, `$16`, `$1a`, `$27` now read as constants. The
existing `...FaceRight`/`...FaceUp` handler labels corroborate the compass
mapping. Byte-perfect.

Extended the same `FACE_*` constants to the actor-script bytecode: the
`as_set_field` opcode's selector `$14` is the actor facing field (state
+$14), and its 267 value words are exactly `$0000/$0040/$0080/$00c0`.
`render_actor_script` now emits `as_set_field $14, FACE_*` (the `dw` still
assembles to the same word). The `flag_cond`/`cond` words in these tables were
left raw: they decode to a (flag-byte, bit, negate-bit-15) triple via
`EvalFlagCondition`/`TestGameFlag`, but only ~7 distinct event flags appear and
their in-game meanings aren't recoverable without per-flag tracing, so named
constants would obscure rather than clarify.

Also applied `FACE_*` to the cutscene `script_*` commands that set a cardinal
facing/angle: `script_face` and `script_facing_lock` (facing arg) and
`script_move_angle` (the byte doubles as the movement angle). `script_cmd_seq`
maps arg 1 of those macros to a `FACE_*` name (~1100 sites, all `$00/$40/$80/
$c0`). Byte-perfect.

Named the cutscene actor slot `$00` `ACTOR_PLAYER` (constants.inc). The actor
array (`$d000`, stride `$40`) is slot 0 = player, other slots = the scene's
own actors in spawn order — so only slot 0 has a stable name. `script_cmd_seq`
renders the target-actor arg of the 20 actor-targeting `script_*` commands as
`ACTOR_PLAYER` when it is `$00` (`ACTOR_SLOT_ARGS` maps each macro to its
actor-slot arg positions — e.g. `script_set_objdef`'s actor is arg 1, and
`script_face_toward` has two). 1679 sites; other slots stay literal. An audit
of the remaining `as_*`/`script_*` args found no further clean global enums:
animation ids index each actor's own table (per-objdef), obj_id/coords/speeds/
timers are per-instance data, and the activity byte / state-field selectors /
flag words aren't nameable without deeper tracing. Byte-perfect.

### Name the actor frame tasks + resolve RegisterFrameTask sites (2026-07-21)

Named the two per-frame tasks `InitActorEngine` registers: `UpdateActors`
($04:$41e7, iterates all 24 actor slots -> `StepActorScript` + movement each
frame, then syncs the player position out) and `DrawActors` ($04:$4a82,
`ComputeSpriteScrollOffset` then `DrawActorSprite`/`AdvanceActorAnimation` per
active actor). Their registration sites read `ld hl, UpdateActors` etc.

Generalised that: a `ld hl, n16` immediately before a `call` to a frame-task
helper (`RegisterFrameTask`/`UnregisterFrameTask`) loads a task-function
pointer, but the target is reached only through the task dispatcher so recursive
descent never labelled it (like the `map_scripts` handlers). `build_labels`
seeds a `Func_*` label at each such target (`frame_task_targets`) and the emit
loop resolves the load to it. Then **carved** the task functions that coverage
never executed: `main` seeds those pointers so they decode -- 12 `INCBIN` blobs
into 24 frame-task functions, several self-documenting (e.g. `Func_1d_4e76`
decrements a timer then `ld hl, Func_1d_4e76 / call UnregisterFrameTask` to
remove itself; mid-blob functions split their data prefix off cleanly). All
427/427 `RegisterFrameTask` and 95/95 `UnregisterFrameTask` sites now name their
task. Two correctness points: the seed runs *after* the jump-table descent
fixpoint (some registration sites surface late), and it seeds only
`RegisterFrameTask` targets -- `RunFrameTasks` executes the registered pointer
so it is code, whereas an `UnregisterFrameTask` key can be a stale pointer into
data (`RulesScreenTiles`, an LZ graphics stream, is unregistered but never
registered; seeding it would wrongly carve the graphics as code). Byte-perfect.

### Name actor-engine functions from the spawn analysis (2026-07-20)

Used the actor spawn/facing reverse-engineering to name six previously
anonymous symbols in `labels.json` (renames propagate to the auto-derived
`FarPtr_*` slot labels and every `farcall`/operand site; byte-perfect):
`SpawnCompanionActor` ($04:$4f10, the slot-2 companion spawn), the three
built-in follower/controller installers `AttachActorControllerScript`
/`AttachActorWaypointFollower`/`AttachActorStepMover` ($04:$415b/$417b/$41a6,
which `SetActorScript` the `$41d1`-pool entry points `$41d2`/`$41d8`/`$41dc`),
`FollowerActorScript_04` ($04:$41d1, the follower script pool — its `ld hl`
load sites now read the label), and `FacingToPadBitTable` ($0a:$53b9, the
`[$10,$80,$20,$40]` facing-dir->PADF table behind `CheckTriggerFacingMask`,
split out of its data blob). Story cutscenes turned out to `farcall` the
step-mover installer, so those sites now read meaningfully too.

Then identified the movement/geometry helper cluster the follower/facing code
leans on (10 more `labels.json` names, byte-perfect): `UpdatePlayerControl`
($04:$516b, the per-frame player input handler — A=interact, START=menu, d-pad
=move; the script the `$41d2` pool entry `as_call`s), `CheckTileTriggerAtPoint`
($5141, reads the behavior map and raises `wStoryModeTriggerScript`/
`ExitLocationRequest`), `IsPointBlocked` ($533d) = `IsTerrainBlockedAtPoint`
($534b, collision map) + `FindActorAtPoint` ($53d7, scans the nearby-actor list
at $da00), `IsPointNearPlayer` ($537a, distance² vs threshold),
`ProjectPointFromActor` ($5113, via `VectorFromLengthAndAngle`),
`GetPointAheadOfActorFixed`/`Ranged` ($50d2/$50dc, look up
`ActorHeadingOffsetTable` at $5072). These are the primitives the actor
obstacle-avoidance loop ($5227+) and NPC-interaction detection use.

Finally carved bank $04's only actor-script bytecode -- the 22-byte pool at
$41d1 (every bank-4 spawn template's `objdef` points into it) -- from an opaque
`INCBIN` into readable `as_*` macros, one `actor_script` spec + label per entry
point: `ActorScript_Idle` ($41d1, `as_halt`; the default an actor gets before a
behavior is attached), `ActorScript_PlayerControl` ($41d2, `as_call
UpdatePlayerControl` loop), `ActorScript_FollowWaypoints` ($41d8, `as_follow_wp`
loop), `ActorScript_StepToTarget` ($41dc, `as_step`/`as_wait` loop), and
`ActorScript_Deactivate` ($41e2, `as_set_field $20,$0` then halt). The
`AttachActor*` installers now read as installing the matching script, closing
the loop with those names. Byte-perfect.

### Reserved actor-slot constants (2026-07-20)

Extended the actor-slot naming to the other two reserved system slots, adopting
pokecrystal's reserved-`PLAYER` idiom. `InitLocationActors` ($0a:$5485) always
spawns, in order, the player (slot 0) + its `$04:$41d1` follower (slot 1) + a
companion (slot 2, `Func_04_4f10`, singles/doubles template variants but always
one slot) before `SpawnActorsFromList` — so the location's `map_actor` list
starts at slot 3 (`SpawnActor` allocates the first free slot; base verified from
the spawn code). Added `ACTOR_PLAYER_SHADOW = $01` (15 sites, all
`script_null_script`) and `ACTOR_PARTNER = $02` (802 sites); `RESERVED_ACTOR_SLOTS`
in `script_cmd_seq` renders all three. Slots 3+ are scene-local (name = base +
list index) and stay literal — they'd need pokecrystal-style per-scene
`object_const_def` machinery (a separate, larger pass). Byte-perfect.

### Symbolic dialogue text ids (2026-07-20)

Made dialogue text references read symbolically instead of as raw hex. A text id
(passed in hl to `FetchDialogueText`) is a `(fetcher, index)` code, not an
address — so it can't be a label, and the string itself can't live in the
committed tree (no ROM bytes). `disasm.py` now decodes each id to its text
`bank:string-index` coordinate and renders it as `Text_<bank>_<index>`, backed
by a generated `include/text_ids.inc` (`def Text_bb_iii equ $xxxx`; value = the
raw id, so bytes are unchanged), added to the Makefile `PRELUDE`. Wired into the
two unambiguous sites — `script_set_text` operands and `map_script` handlers
`<$4000` (the dialogue-id handlers `RunStoryScriptOrDialogue` routes to
`ShowSpeakerDialogue`). 586 ids named; read one with
`tools/strings.py --index --bank <bank>` (e.g. `Text_5e_151` = "Yoshi!"). The
per-NPC `records:2` dialogue tables (`dw $0c3b`) are still raw — they'd need a
per-table text-id spec. Byte-perfect.

### Identify story NPCs (2026-07-20)

Investigated who the overworld map NPCs are. An NPC script picks its dialogue
text id from a per-NPC `records:2` table indexed by the story-progress counter
`[$c2b0]`, then `InitDialogueTextCursor` + `script_speak`. Resolving those ids
(via the [[text-id-decoding]] fetcher math) shows **most map NPCs are anonymous
academy students/staff** giving tennis tips/flavor (e.g. the Cafeteria set,
bank `$33`) — so the `<Loc>Npc<id>` object-id naming is the right level; no
dialogue name-drops a character. The **named cast is a separate roster/name
table** at bank `$30` `$466d` (Alex, Nina, Harry, Kate, Allie, Joy, Brian, Pam,
Bob, Beth, Fay, Curt, Mark, Sean, Sammi, Elden, Spike, Emily, B. Coz, A. Coz,
Kevin, then the Mario cast + Rankers) used by match/ranking screens, not the
overworld. The exception is **Peach's Castle** (MarioWorld, loc 29): its NPCs
are the Mario cast, each with a signature voice line (bank `$5e`) — renamed the
seven unmistakable ones (`MarioWorldNpc09Yoshi`/`0ABabyMario`/`0BLuigi`/
`0EWaluigi`/`0FBowser`/`10Wario`/`12Mario_0e`). Probable but not renamed:
Npc0C=DK ("Oo-hoo"), Npc11=Peach (castle host greeting), Npc13/14 = flavor/exit
Toads. Byte-perfect (labels-only).

### Name story-location tree scripts (2026-07-19)

Named 264 of the 270 `Func_*` story-script handlers reached through the 42
`story_location` map_trees (banks `$0e`-`$15`/`$27`), keyed off which `map_tree`
slot references each handler and the record's id field. Scheme:
`<Location><Role><Id>` — e.g. `DormRoomNpc03_13`, `Court1Tile01_14`,
`AcademyWingFacing01_10`, `CafeteriaNpc07_10` (role from slot:
NpcScripts→`Npc`, FacingScripts→`Facing`, ExitTriggers→`Exit`,
TileTriggers→`Tile`, EntryPoints→`Arrival`). The flag-selected NpcScript
variant tables get their variant in the name (`IslandOpenRound1DoublesNpc0A_0f`,
`VarsityCourtCNpc03_13`, `JuniorClassCourtDoublesDNpc0A_11`). Same-NPC records
that share an id but differ by approach direction / story flag are disambiguated
by the record's `facing_mask` (and `flag_cond` where facing collides):
`MarioWorldNpc08FaceUp/Down/Left/Right_0e`, `SeniorCourtNpc03FaceUpFlag0000/0840_12`.
The `facing_mask` direction was decoded from the engine
(`CheckTriggerFacingMask` `$0a:$53bd`; table `$0a:$53b9` + d-pad→facing table
`$04:$532d`): mask `$10`=facing Right, `$20`=Left, `$40`=Up, `$80`=Down,
`$ff`=any.
Also named the per-bank no-op exit handlers (`MapScriptNop_0f/_11/_12/_13/_15`),
the two `Development` respawn-actor scripts, the shared `RestaurantPlaza`
arrival walk, `TournamentExit_0f`, `Court2SpectatorChat_14`, and the two shared
arrival-walk animations (`MapArrivalWalkPair_10`, `MapArrivalWalk_11`).
Config-only (labels.json); byte-perfect. Left as `Func_`: the four
`MatchSelectHandlerTable_10` slots (that tree is a menu dispatch, not NPC
scripts) and the two near-identical bank-`$10` exit-walk helpers
(`Func_10_7ae6`/`_7b1f`).

### Carve bank $24's ball-path data tables (2026-07-19)

Split bank `$24`'s data blobs into 12 named per-shot tables so the five entries'
`ld hl,$xxxx`/`ld bc,$xxxx` pointers resolve: `BallPosDataLob_24` +
`BallPosBlockOffsetsLob_24`; `BallPosDataDrop_24` + `BallPosAimOffsetsDrop_24` +
`BallPosBlockOffsetsDrop_24`; `BallPosDataNeutral_24` +
`BallPosHeightOffsetsNeutral_24`; `BallPosDataReach_24` +
`BallPosHeightOffsetsReach_24`; the shared-fallback `BallPosDataFallback_24` +
`BallPosFallbackOffsets_24`; and `SmashVelocityBySpeed_24` (smash indexes it by
`wSmashServeSpeedIndex`). The `BlockOffsets` tables are 4 bytes each — the
lob/drop placement index is just 0/1. Carve is label-driven: `disasm.py`
rewrites `data.manifest` from the curated labels, so the split needs no manual
manifest edit (only a re-extract). Two tables are reached by computed addressing
(`add a,n`/`adc a,n`) so their label documents the address without a pointer to
rewrite. The two remaining blobs (`d_410e`, `d_4d47`) are unreferenced — dead
copies of the stride-6 `ApplyBallTrajectory` code this bank doesn't enter. This
completes bank `$24` and the whole shot pipeline. Byte-perfect.

### Name bank $24's ball-path code (2026-07-19)

Bank `$24` (the shared multi-entry ball-path bank for lob/drop/neutral/smash/
reach) runs the same engine as `$20`-`$23` but relocated +0xc (its 7-entry
`FarPtr` table pushes the code down); the first 0x10f bytes are byte-identical.
Mapped and named its eight shared helpers (`BallTrajEntryPtr6`/`4`,
`SeekBallTrajEntry4`, `SetBallVelocityFromEntry6`/`4`, `SetBallTargetFromAim`,
`LookupBallPosByHeight`/`ByShotIndex` — each verified byte-identical to the `$22`
copy) plus four bank-specific ones: `ApplyBallTrajectory_24` (stride-4 worker,
used by neutral/reach), `ApplyBallTrajectoryCapped_24` (clamps range at `$c48c`,
used by lob/drop), `LookupBallPosByAim_24` (index via `VectorLengthFromAngle`),
and `ApplyFallbackBallTrajectory_24` — the `FarPtr_24_04` every engine bank jumps
to on the out-of-range carry path. Byte-perfect. (The per-shot `BallPos*` data
tables in `$24`'s blobs are still raw `ld hl,$xxxx` pointers — a data-carving
follow-up.)

### Name the ball-path engine helpers (2026-07-19)

Banks `$20`-`$23` and `$29`/`$2a`/`$2b` (the non-`$24` `ShotBallPath*` banks)
share a **byte-identical** ball-trajectory engine — confirmed by comparing the
`$4002`-`$4278` code region across all seven (identical; `$24` differs). Named
its 11 helpers once by observed behavior and applied them per bank (`_XX`
suffix, only where each offset is actually referenced): `LookupBallPosByHeight`
(indexes `BallPosData` by `wBallHeight`) / `LookupBallPosByShotIndex` (by the
shot's placement index) — the two calls the entry makes; `ApplyBallTrajectory`
(the main worker); `SeekBallTrajEntry6`/`4` + `BallTrajEntryPtr6`/`4` (walk the
stride-6/4 trajectory tables); `SetBallVelocityFromEntry6`/`4` (-> `farcall
SetBallVelocityPolar`); and the two target solvers `SetBallTargetFromAim` (via
`MulSinCos`) and `SetBallTargetByPrediction` (via `PredictBallXAtDepth`). 67
labels across the 7 banks. The `BallPos*` data tables were already carved in
prior passes. (Bank `$24`, a shared 5-shot multi-entry bank with its own code,
is left for a later pass.) Byte-perfect.

### Name the shot-placement index RAM (2026-07-19)

The `ShotPlacement<Type>` handlers each pass two indices to
`LoadShotPlacementEntry`: `d` selects a placement/target row (bytes 0-3, incl. a
court-side-signed lateral offset) and `e` selects a speed row (bytes 4-5). Traced
which `$df` byte feeds each and named them in `ram_map.json` (per-character
banked struct, WRAM4-7): `wTopspinPlacementIndex`/`wSlicePlacementIndex` (the `d`
inputs, shared with the matching serves), `wLobPlacementIndex`/
`wDropPlacementIndex` (`d` for lob/drop, set from `df91` bits 0/1),
`wGroundStrokeSpeedIndex`/`wSmashServeSpeedIndex`/`wReachSpeedIndex` (the `e`
inputs per shot group). All are loaded as a block from the character's stat
struct at point setup (`$07:$5be6`). Byte-perfect.

### Name the per-shot-type ball-path banks (2026-07-19)

The executor table's last step per shot type is `farcall FarPtr_XX_00` into a
dedicated ball-path bank; each target was confirmed to have exactly one caller
(its `ExecuteShot<Type>` handler) and follows the same shape (`farcall
ComputeShotPlacement` then apply the bank's `BallPos*` tables). Named the 12
entry points `ShotBallPath<Type>`: `$20`=Slice, `$21`=PowerSlice, `$22`=Topspin,
`$23`=PowerTopspin; bank `$24`'s multi-entry table = Lob(`_00`)/Drop(`_02`)/
Neutral(`_06`)/Smash(`_08`)/Reach(`_0c`); `$29`/`$2a`/`$2b` = the three serves.
(`FarPtr_24_04` is a 9-caller shared helper and `FarPtr_24_0a` is unused — left
unnamed.)

Also completed the executor jump table itself: it has 15 entries like
`ComputeShotPlacement`, and the `$0c`-`$0e` serve slots were still
`Label_07_*` -> `ExecuteShotServe{Topspin,Slice,Flat}` (they dispatch into
`$29`/`$2a`/`$2b`). Byte-perfect.

### Carve the shot-placement sub-tables (2026-07-19)

The `$07:$4d21` blob (1088 bytes) was the backing data for the 15
`ShotPlacement<Type>` handlers: each does `ld hl, <base>` then
`LoadShotPlacementEntry`, which indexes 8-byte rows (`d`=row -> bytes 0-3 =
two scalars + a signed 16-bit; `e`=row -> bytes 4-5). The 15 bases are spaced
0x50 (10 rows) apart, except Lob (`$5051`) and Drop (`$5061`) at 0x10 (2 rows).
Split the blob at those bases into `ShotPlacementData<Type>_07` (13x80 + 2x16),
so every handler's base pointer now resolves. The blob's leading 16 bytes turned
out not to be placement data at all — it's a pointer-pair table indexed by
`[$ffdd]` and dereferenced by `ComposeLinkStateByte` (`$4cfe`), carved off as
`LinkStateBytePtrs_07`. Byte-perfect.

### Name the shot-type dispatch handlers (2026-07-19)

Two `$07` jump tables dispatch directly on `wCurrentShotType` (`ld a,
[wCurrentShotType]` / `rst Rst00`), so each entry is uniquely identified by its
shot-type index. Named all their targets: the 12-entry executor table at `$5445`
(applies per-type ball-height/preset/trajectory then farcalls the shot's physics
bank) -> `ExecuteShot{Topspin,PowerTopspin,Slice,PowerSlice,Neutral,Reach,
ReachPowerTopspin,ReachPowerSlice,ReachBasic,Smash,Lob,Drop}`; and the 15-entry
`ComputeShotPlacement` table at `$5165` (each loads a distinct per-type placement
sub-table from the `$4d21` blob via `LoadShotPlacementEntry`, then computes shot
speed) -> `ShotPlacement<Type>`, including the three serves
(`ServeTopspin`/`ServeSlice`/`ServeFlat`). Byte-perfect.

### Apply shot-type / joypad constants ROM-wide (2026-07-19)

Swept every bank for sites that operate on a known input value or
`wCurrentShotType` and tagged them in `constants.json` so the source reads
symbolically. Input sites were found with a straight-line taint scan: an
`ld a,[<input>]` from a standard-layout byte (`hPlayerInputFlags`,
`hInputPressed`, `hInputRepeatButtons`, `hInputRisingEdge`, `wMenuInputPressed`)
taints `a`, and the first `and`/`or`/`xor`/`cp a, n8` or `bit`/`res`/`set N, a`
before any branch, label, or `a`-write is tagged — 172 sites across banks
`$00`-`$7f` now read e.g. `bit PADB_A, a`, `and a, PADF_START`,
`and a, PADF_A | PADF_B`. Whole-nibble masks (`$f0`/`$0f`/`$f3`) are left raw —
they select a nibble, not a button. Also tagged four more `wCurrentShotType`
compares (`StartLandingMarker` lob check `$08:$52dd`, the drop/lob AI checks
`$08:$79dc/$79e3`, the smash check `$0d:$5304`).

Renamed the two AI shot-class predicates whose old names disagreed with the
confirmed codes ($0a=lob, $0b=drop): `AiIsIncomingDropShot` (which tests $0a)
-> `AiIsIncomingLobShot`, and its drop-then-lob entry point
`AiIsIncomingDropOrShortShot` -> `AiIsIncomingDropOrLobShot`. Byte-perfect.

### Joypad button constants (2026-07-19)

`$df1f` (the per-character input byte from `ReadCharPadInput`) uses the standard
GB joypad layout — buttons in the low nibble, d-pad in the high. Added `PADF_*`
(masks) and `PADB_*` (bit indices) to `constants.inc` and extended the
immediate-constant mechanism to also rewrite `bit`/`set`/`res` index operands
(the index is baked into the opcode, so it's a pure text change). Constant values
may now be expressions — tagged the shot-input aim/button sites in `$08`
(`BufferShotButtonPress`, `CaptureServeAim`, `CaptureShotAim`) so e.g.
`and a, $03` reads `and a, PADF_A | PADF_B` and `bit 4, a` reads
`bit PADB_RIGHT, a`. Byte-perfect.

### Shot-type constants + disassembler constant mechanism (2026-07-19)

Identified the `wCurrentShotType` codes by decoding the button-sequence
selection tables in `SelectRallyShotType`/`SelectServeShotType` (`$08`): the
`df16` (first button) x `df17` (second button) tables give A=topspin ($00),
B=slice ($02), A->B=lob ($0a), B->A=drop ($0b), A+B=smash ($09), a "power"
variant per doubled button ($01/$03), the ball-smashable "reach" variants
($05-$08 -> bank `$2c` ProjectShotPlacement), and three serve codes ($0c-$0e);
$09/$0a/$0b independently confirmed by the `Record{Smash,Lob,DropShot}Stat` `cp`
checks.

Added a general **immediate-operand constant mechanism** to the disassembler:
`constants.json` maps an instruction's flat offset to a named constant, and
`render_operand` substitutes it into the `ld r, n8` / `cp a, n8` operand (keyed
by exact offset, so a wrong tag fails the byte-perfect compare). Constants live
in the new hand-maintained `include/constants.inc`, preincluded for every bank
via the Makefile `PRELUDE`. Defined `SHOTTYPE_*` for all 15 codes and tagged the
7 highest-confidence sites (the four handler writes in `$07`, the three
`Record*Stat` checks in `$08`). Byte-perfect.

Also added an `enum:<PREFIX>:<cols>` **data-table spec**: it renders each byte of
a table as a constant of that group (parsed from `constants.inc`), `cols` per
row, falling back to `$xx` for unnamed values. Retyped the three shot-select
tables (`$08:$707a/$709b/$70b4`) from `bytes:4` to `enum:SHOTTYPE:4`, so the
`SelectServeShotType`/`SelectRallyShotType` button x direction maps now read as
their `SHOTTYPE_*` results directly in the source. Byte-perfect.

Identified the three serve types: `BufferShotButtonPress` masks `$df1f & $03`
into the first-button field `$df16` (A=1, B=2, A+B=3), which `SelectServeShotType`
indexes — so serves mirror the ground strokes by first button. Renamed
`SHOTTYPE_SERVE_0/1/2` -> `SHOTTYPE_SERVE_TOPSPIN/SLICE/FLAT` ($0c/$0d/$0e; A+B is
smash in a rally but flat/power on serve). Byte-perfect.

### Label bank $2c shot-placement offset tables (2026-07-19)

The three parallel `$2c` handlers at `$7281`/`$72d3`/`$7325` each do `ld bc,
<table>; call Func_2c_4250` (which indexes the table by ball height). The three
64-byte `records:2` tables (`$7293`/`$72e5`/`$7337`) were already typed but
unlabeled, so the `ld bc` sites rendered as bare `$xxxx`. Named them
`ShotPlacementOffsets0-2_2c` so the references resolve. The paired `ld hl,
$4281`/`$4e81`/`$6081` bases were the only three references into the 12 KB
`$4281` blob, so split it there into `ShotPlacementData0-2_2c`
(3072/4608/4608 bytes) — every handler is now fully symbolic. Byte-perfect.

Then named the three handlers themselves: they are slots 0-2 of bank `$2c`'s
farcall table, dispatched from bank `$7`'s `wCurrentShotType` jumptable (types
6/7/8, all gated on `CheckBallInSmashRange`) and each projecting a shot's
on-screen placement via its paired data/offset tables. Named them
`ProjectShotPlacement0-2` with matching `FarPtr_ProjectShotPlacement0-2` slots,
so the bank-`$7` `farcall` sites and the dispatch table read meaningfully.
Byte-perfect.

### Carve VarsityCourtTourCutsceneBody_13 (2026-07-19)

The 918-byte `$13:$667a` blob (reached only by dynamic dispatch, never in
coverage) was uncarved code + data. Decoded it into:

- **`DecompressVarsityCourtTourRecords_13`** (`$667a`) — loops 4x, `DecompressData`
  each LZ block into `$d000` then `QueueVRAMCopy`s `$10` bytes to `$a000+i*$100`,
  then `LoadPaletteShadow` from the trailing palette.
- **`QueueVarsityCourtTourSprites_13`** (`$66c3`) — indexes a 4-entry table and
  `QueueSpriteTemplate`s the selected sprite block.
- Two `records:2` pointer tables (`VarsityCourtTourSpritePtrs_13` `$66ff`,
  `VarsityCourtTourLzPtrs_13` `$678b`), each resolving to its four labeled blocks:
  4x 33-byte sprite blocks, 4 LZ blocks, and an 8-byte palette (`$6a08`).

Seeded the two routine entries (`bank013_static_code.json`), declared the two
tables (`data_tables.json`), and labeled every sub-block (`labels.json`). All the
data blocks stay raw INCBIN, so no LZ round-trip is needed. Byte-perfect.

### script_get_actor_state macro (2026-07-19)

Added a `script_get_actor_state actor` command: `ld a, actor; farcall
FarPtr_GetActorStateAddr` (`GetActorStateAddr`, `$0a:$4311` — returns the
actor's state-struct address, `$d000 + actor*$40`, in hl; callers copy it into
bc/de to read/write state fields). Same two-step shape as `script_wait_move`.
Collapses 132 of 136 sites across banks $0e-$15/$27; the 4 holdouts load the
actor id from `$c2b1` (3) or are a shared function entry (1). `script_set_objdef`
(which embeds the same farcall after a leading `ld d`) is unaffected — it anchors
earlier, so its 38 sites still collapse whole. Byte-perfect.

### script_wait_actor_script macro (2026-07-19)

Added a `script_wait_actor_script actor` command: `ld a, actor; farcall
FarPtr_WaitActorScriptDone` (`WaitActorScriptDone`, `$0a:$4372` — blocks the
cutscene, advancing a frame per poll until the actor's script ends, ~600-frame
timeout). Same two-step shape as `script_wait_move`. Collapses all 81 sites
across banks $0e/$0f/$11/$12/$13/$15/$27. Byte-perfect.

### Audit StoryLocationTable trees end-to-end (2026-07-19)

Walked all 42 `story_location` map_scripts pointers and, recursively, every
`map_tree` slot (294) and its sub-references. Findings and fixes:

- **Root naming:** five trees reached via `story_location` were named
  `…Scene_11`/`…StoryCmds_12` though structurally identical `map_tree`s; renamed
  to the `…MapScripts_NN` convention (the `DataPtr_` wrappers auto-derive).
- **Slot naming:** all 294 slots follow `<Base><Role>_<bank>` except the
  match-select "Test" screen, which repurposes the tree — slot 3 keeps the
  descriptive `MatchSelectHandlerTable_10` (a menu dispatch, not NPC scripts),
  and slot 6's generic `Func_10_4190` was renamed `MatchSelectInitScript_10`.
- **`map_script` handler `$12:$4ce9`:** the static-code seed sat one byte late
  (`$4cea`), so the handler decoded as data (`db $ff, $3e`) with no label. Moved
  the seed to `$4ce9`; it now carves as `Func_12_4ce9` and the leading `ld a,$00`
  folds into a `script_move_target` macro. The other 226 raw `<$4000` handlers
  are dialogue/text ids (`ShowSpeakerDialogue`), correctly left literal.
- **`map_actor` script `$11:$6e16`:** a runtime-selected variant entry point
  absorbed into `ActorScript_11_28`'s run; declared `actor_script` +
  `ActorScript_11_29` so the `map_actor` resolves symbolically.

Config-only (labels.json + data_tables.json + one seed offset); byte-perfect.
(Out of scope: 4 `map_actor` raw script refs in bank `$1a`, not reached from any
story-location tree.)

### Decode actor-script bytecode (2026-07-19)

The `map_actor` `objdef` blobs are not object-definition structs but **actor
scripts**: a 1-byte-opcode bytecode run each frame by `StepActorScript`
(`$04:$4229`), dispatched through the 22-entry handler table at `$04:$447d`.
Derived the full opcode set (operand widths confirmed by round-tripping every
blob through `rgbasm`) and documented it in `docs/actor_script.md`. New `as_*`
opcode macros + a `render_actor_script`/`actor_script` spec in `disasm.py` turn
the blobs into readable listings (e.g. a patrol loop of `as_set_target`/
`as_wait_move`/`as_wait`/`as_jump`) with local labels at jump targets; the
relative `as_jump` back-edge assembles as `dw target - @`. Renamed
`ActorObjDef_*` → `ActorScript_*` (supersedes the "Label map_actor objdef
sub-tables" naming below). The decoder is a partial decode: it renders the clean
script prefix and emits any trailing non-opcode bytes as an `unclassified tail`
blob (five blobs; the tail bytes are *not* assumed to be code — nothing in the
traces or references classifies them yet). Corrected an over-seed: the four
`StoryCmdHandlersC_13` ($13:$526a) "handler" targets were actor-script fragment
entry points inside one blob, not code — reclassified `$585f`/`$5877`/`$5881`/
`$588b` as `actor_script`. Byte-perfect. Full reference in
`docs/actor_script.md`.

### Decode all installed actor scripts (2026-07-19)

Swept every `script_set_actor_script actor, addr` site (the macro for
`ScriptSetActorScript`): its `addr` operand is an actor script in that bank.
Labelled all 190 previously-unlabelled targets `ActorScript_*` and registered
them `actor_script`. Most are overlapping entry points into shared blobs (one
region holds ~20, like `$11:$5b14…$5d27`), so the renderer now emits a global
label reference for an `as_jump` that crosses into another entry point (fragments
fall through or jump between each other). Fixed one more code over-seed
(`$10:$741c`, a `script_set_actor_script` target mis-seeded as a jump-table
handler). ActorScript labels: 48 → 238; all 238 decode. Byte-perfect. Five
story-bank blobs decode cleanly as scripts but have **no** traceable
install/jump/call/table/`map_actor` reference (`$0e:$7ca4`, `$13:$62db`,
`$14:$78e7`, `$15:$7a23`, `$27:$4b41`) — left unclassified pending evidence, not
labelled on decode-shape alone. Also caught one pre-existing mislabel:
`SceneFrameDataHi_27` ($27:$51d0) was an install target already (wrongly) named
as frame data — renamed `ActorScript_27_04`. A sweep over all 238 script
targets (map_actor objdefs + install sites, literal and label operands) confirms
no other non-`ActorScript_` targets remain.

### Sprite-template spec + game-wide sweep (2026-07-19)

`QueueSpriteTemplate` ($00:$1e9d) reads 4-byte {dy, dx, tile, attr} OAM records
ended by a $80 dy byte. New `sprite_template` render spec + `oam_sprite`/
`oam_sprite_end` macros give them a readable form. `carve_sprite_templates` in
`disasm.py` auto-finds every `call QueueSpriteTemplate`, backtracks to the
nearest same-bank `ld hl, imm` that sets the pointer (rejecting cases where hl
is indexed/dereferenced first — those are pointer tables, not templates), sizes
the list by its $80 terminator, and carves it as a labeled `SpriteTemplate_bb_cccc`
blob — splitting the packed runs (e.g. bank $03's 54 back-to-back templates)
that otherwise sat in one anonymous blob. **135 templates carved across ~20
banks**; the `ld hl` load sites resolve to the labels. One dynamic-length list
with no $80 terminator ($1b:$6572, bounded by the sprite-queue cap) is left as a
blob. Match-result pair keeps curated names (`ResultSpriteTemplateLeft/Right_16`).

### Label map_actor objdef sub-tables (2026-07-19)

Every `map_actor` record's 2nd field is a pointer to an actor object-definition
(`SpawnActorFromTemplate` → `SpawnActor`), but these rendered as bare numbers. 44
distinct objdefs are referenced across the story banks ($0e-$15/$27), all shared
and unlabeled. Added generic labels for each (since renamed `ActorScript_bb_cccc`,
see "Decode actor-script bytecode" above) so the records read `map_actor $0000,
ActorScript_0f_09, …`; overlapping defs (e.g. `$7b2f` inside `$7b25`'s blob)
split into separate labeled blobs. Byte-perfect.

### Fix mis-seeded bank $13 map_actor lists (2026-07-19)

Two TravelingTeam `map_actor` spawn lists (loaded via `ld hl,addr; farcall
ScriptRespawnLocationActors`) each had a static code seed sitting on the *list
start* — decoding the 11 actor records as garbage code. In both cases the seed
was meant for the code that *follows* the list but was placed a list-length too
early: `$78d7` (→ init script `$797b`) and `$739c` (→ dispatcher `$7440`). Moved
each seed past its list, declared the lists as `map_actors`
(`DoublesTravelingTeamActors_13`/`SinglesTravelingTeamActors_13`), and labeled
the trailing code. Byte-perfect.

### Story-scene directories + respawn variant tables as macros (2026-07-19)

The story "scene" tables reached via `story_location`'s DataPtr
(`AcademyArrivalMapScripts_11`, `JuniorClassCourtSingles/DoublesMapScripts_11`,
`WallPracticeRoomMapScripts_12`) are each a full 7-word `map_tree` — same layout
as a location directory — but were seeded as generic `records:2` headers with
`records:8`/`bytes:14`/`bytes:16` slots. Retyped the four headers `map_tree` and
their slots `map_entries`/`map_scripts`/`map_actors`, with `<Scene><Role>` slot
labels; the arrival/handler pointers now carve as `script_*` cutscene code.

Then swept every flag-selected variant table installed at runtime — NpcScript
tables via `WriteStoryStateWord de=$000c` (map-tree slot 3) and actor lists via
`ScriptRespawnLocationActors`:

- **map_scripts (NpcScript variants):** 8 in bank `$11`
  (`JuniorClassCourt{Singles,Doubles}NpcScripts{A-D}_11`), 5 in bank `$13`
  (`VarsityCourtNpcScripts{A-E}_13`). Each `ld hl,table` dispatch now resolves
  symbolically.
- **map_actors (respawn variants):** 11 scene actor lists retagged from
  `bytes:14` (`$10`/`$11`/`$12`/`$1a`), plus ~19 more that were raw blobs across
  banks `$12`/`$13`/`$27`. The embedded ones sit inside larger uncarved code
  blobs, so a curated label at each list start (which splits the enclosing data
  run) plus a bounding label at the two chain tails not already on a
  label/code boundary keeps each list rendering as exactly its `map_actor`
  records + `map_actor_end`.
- **split fixes:** two `map_scripts` tables (`$12:$4cc0`, `$15:$505b`) had an
  interior `records:8` key that truncated the run mid-table; dropped the keys so
  every record renders as `map_script`.

All config-only (data_tables.json + labels.json); byte-perfect throughout.

### SeniorCourt story location (2026-07-19)

The `$12:$52f7` story-location map_tree (`SeniorCourtMapScripts_12`) and its seven
sub-tables were left as `records:2`/`bytes:14` raw data — the bank's other
location (`$4006`) was already tagged but this one was missed. Retyped the
data_tables specs (`map_tree` + `map_actors`/`map_entries`/`map_scripts` per
slot) and named the sub-tables `SeniorCourt<Role>_12`, so the tree renders as 7
labeled slots and the sub-tables as `map_*` macros (Actors is several
`map_actor` lists; the InitScript is code). Config-only; byte-perfect.

### Seed map-script/entry code targets (2026-07-19)

`map_script_code_targets` yields the handler/arrival-script pointers embedded in
`map_scripts`/`map_entries` tables, but it was only wired into labeling
(naming targets descent already reached). Now `main` also *seeds* them before a
re-descend, so a handler reached only through its table's indirect dispatch gets
decoded instead of falling into the table's data blob. Surgical in effect —
only `AcademyMainBldgEntryPoints_10` ($10:$74f9) had such a handler: its two
arrival scripts (`Func_10_7532`/`Func_10_7578`) were buried after the `$ff`
terminator, so the table over-ran to 197 bytes; now 57 bytes (7 records) with
the arrival scripts decoded as `script_*` cutscene code. Byte-perfect.

### script_set_actor_script macro (2026-07-19)

Added a `script_set_actor_script actor, script` command:
`ldh a,[hRomBank]; ld b,a; ld a,actor; ld de,script; farcall
FarPtr_ScriptSetActorScript` (`ScriptSetActorScript`, `$0a:$434f` — sets an
actor's script to a pointer in the current bank). Needed a new `'p'` step kind
(16-bit pointer operand resolved to a label when known). Collapses 327 of 328
sites across banks $0e-$15/$27; the lone holdout loads `de` from a table, not an
immediate. Byte-perfect.

### script_fade_in macro (2026-07-19)

Added a `script_fade_in speed` command: `ld c, speed; call BeginFadeIn`
(`$00:$1d2e`). Extended the `'C'` step kind to resolve ROM0 call targets
(cpu < $4000) as well as same-bank ones. Collapses all 218 `BeginFadeIn` call
sites game-wide. Byte-perfect.

### script_delay macro (2026-07-19)

Added a `script_delay frames` command: `ld a, frames; call WaitScriptFramesSaveA`
(`$27:$7856`, the af-preserving wrapper around `FarPtr_WaitScriptFrames`). This
needed a new `'C'` step kind in `script_cmd_seq` — a `call` to a curated
same-bank label (the existing steps only matched farcalls). Collapses all 83
cutscene sites in bank $27. Byte-perfect.

### script_copy_scene_rect macro (2026-07-19)

Added a `script_copy_scene_rect src_col, src_row, dst_col, dst_row, width, height`
command to `SCRIPT_COMMANDS`: the six `ld b/c/d/e/h/l` immediates feeding
`farcall FarPtr_CopySceneTilemapRect` (`CopySceneTilemapRect`, `$0a:$619e`, which
copies a tile rectangle between two scene-tilemap cells via `GetSceneTilemapAddr`).
Collapses all 61 call sites across banks $0e/$0f/$10/$12/$13/$14/$27. Byte-perfect.

### Bank $39 tilemap-assembly dispatch (2026-07-19)

`$39:$4e60` was a `records:2` blob (L1/L2 pointer tables) plus a separate
`bytes:6` pool of record lists. The indexer at `$39:$4e11` does a two-level
lookup: L1 table (by `b`) → L2 tables (by `c`) → lists of 6-byte
{src, dest, height, width} `CopyTilemapRect` records (height-0 terminated).
`carve_tilemap_dispatch` merges both into one `tilemap_dispatch` blob
(`TilemapAssemblyDispatch_39`); `render_tilemap_dispatch` emits the two pointer
levels as `.l2_N`/`.rl_N` locals and the records as `tilemap_rect`/
`tilemap_rect_end` macros — 24 L1 entries, 20 L2 tables, 214 record lists (6
unused slots point past the pool at the following code). Still byte-perfect.

### Bank $39 tile-block slot table (2026-07-19)

`TileBlockPtrs_39` ($39:$46b7, 244 bytes) was a `records:2` blob of bare words.
`LoadCompressedTileBlock` ($39:$468b) indexes it by `b*2` and feeds each word to
`DecompressDataFromBank` as `h:l` — i.e. each entry is a `(bank, slot)` pair into
that bank's $4000 pointer table. Retyped it as a `SLOT_RECORD_RENDERS` table (1
slot word/record) so all 122 entries render as `dslot DataPtr_bb_ss` referencing
their target slots (banks $18/$1b/$39/$3c/$3d/$3e/$3f/$6c/$6d). Registered the
three slots only reached through this table ($18:$92/$94, $3f:$78) as LZ data
slots so they resolve too.

### Bank $15 tour-scene actor list (2026-07-19)

`$15:$5c4f` was a 164-byte `bytes:14` blob — actually the `map_actor` spawn
list `TrainingCourtIntroTourScene` passes to `ScriptRespawnLocationActors`
(`ld hl,$5c4f`): 11 `{cond, objdef, x, y, facing, obj_id, anim, palette}`
records + a `map_actor_end` sentinel. Retyped to `map_actors`
(`TrainingCourtTourActors_15`); renders as `map_actor` macros.

### Bank $18 frame-task callbacks (2026-07-19)

`$18:$7a57` was a 375-byte `bytes:4` blob that had swallowed three
`RegisterFrameTask` callbacks — code descent never reaches (they're registered
via `ld hl,addr; call RegisterFrameTask`, not called): `TaskFadeInPalette_18`
(`$7a81`, steps a 16-entry palette fade from `PaletteFadeTable_18` at `$7ab5`),
`TaskDrawObjectSprites_18` (`$7b36`) and `TaskUpdateObjects_18` (`$7b6e`, object
update loops over the `$d800` table). Seeded the three entry points in
`coverage/bank018_static_code.json`; the template blob shrinks to the 42-byte
sprite template it actually is, and the palette table carves as `palettes`.

### Match-result graphics selector (2026-07-19)

`$16:$4e9d` (was a 3444-byte `records:2` blob) is the two-level table the
match-result gfx loader (`$16:$4e54`, `LoadMatchResultGfxSet`) indexes by the
remapped match gfx index: a self-delimiting `dw` pointer table
(`GfxSetPointerTable_16`) → 6-byte descriptor records → a contiguous pool of 21
LZ tile streams (each decompresses to 20 tiles at VRAM $8900/$8a40/$9140).
`carve_gfx_pointer_sets` in `disasm.py` walks the table, registers the pool as
labeled `Lz_16_*` blobs (extracted, gitignored), and shrinks the table region
to a `gfx_ptr_table` data table: `render_gfx_ptr_table` emits the pointers as
`.recN` locals and each record as a `gfx_set` of three stream labels. The same
method also carves two one-level `dw` tables straight into stream pools,
rendered by `render_lz_ptr_table` as `dw Lz_16_*` entries:
`$16:$60f1` (`WinLosePortraitVariantTable_16`, loader
`DecompressWinLosePortraitVariant` at `$60d5`, 8 streams) and
`$16:$6968` (`CharacterPortraitTable_16`, loader `DecompressCharacterPortrait`
at `$6955`, 32 entries / 30 streams). Still byte-perfect.

### Match-result tilemap scripts (2026-07-19)

`$16:$4abd` (480 bytes) was a `records:2` blob — really a 20-entry `dw` pointer
table (`MatchResultTilemapScripts_16`) plus the copy lists it indexes. The
routine at `$16:$4a71` (`BuildMatchResultTilemap`) selects a list by
`wCurrentMinigameStoryMatch`'s low byte (`$c8f7`) and walks it, farcalling
`CopyTilemapRect` (width fixed at 2 tiles) per record. A `tilemap_scripts`
render spec (`render_tilemap_scripts` in `disasm.py`) now emits the pointers as
`.scriptN` locals and each list as `tilemap_copy dest, src, rows` macro records
ended by a `tilemap_copy_end` sentinel (an all-zero 5-byte record — the routine
stops on a `$0000` dest word). Still byte-perfect.

### Cutscene script macros (2026-07-18)

Story cutscenes are hand-written native code — long runs of a fixed register
setup then a `farcall` into the script engine (`FarPtr_Script*`, bank $0a).
`script_cmd_seq` in `disasm.py` recognizes twenty of these idioms and emits
readable `script_*` macros (defined in the generated `include/macros.inc`):
`script_move_target/set_position/move_angle/move_player/move_player_to_actor`, `script_set_speed/player_speed`, `script_jump_velocity`,
`script_set_anim`, `script_set_objdef`, `script_face`, `script_face_pair`, `script_face_toward`, `script_facing_lock`, `script_set_active`, `script_speak`, `script_set_text`,
`script_wait_idle/wait_move/wait_frames`. Commands are step lists (register setups and farcalls); one
(`script_set_objdef`) spans two farcalls. The command is keyed by the farcall's
resolved slot name, and a sequence only collapses when no label or data note
lands inside it (past the first instruction), so nothing is hidden.
`script_wait_frames` also folds in the `push af`/`pop af` that brackets all
1216 of its sites (it clobbers `a` while callers hold an actor id there). **7,139
instances** across the story banks ($0e-$15, $27), turning ~18.6k lines of
`ld`/`farcall` boilerplate into ~7.3k lines of script. Each macro re-emits the
identical instructions; still byte-perfect. Example (`TournamentSiteArrivalScene`,
$15): `script_move_target $03, $1200, $2900` / `script_speak $03` /
`script_set_anim $04, $03` / `script_wait_idle $00`.

### Story-location map_trees carved in banks $12/$13/$15 (2026-07-18)

Six "StoryCmdHandlers*" tables were misidentified: they are the 7-slot
**`map_tree` location directories** that the bank $0a `story_location` records
point at (`DormEntrance` $12:$4006, `RestaurantPlaza` $13:$4006, `DormRoom`
$13:$4e20, `Courtyard` $13:$5c78, `TournamentCourtyard` $15:$4004,
`TrainingCourt` $15:$4796) — the same structure the bank $0e/$0f/$27 pass
already handled, just never extended to these banks. Each was typed `records:2`
and its sublists (EntryPoints/ExitTriggers/Actors/NpcScripts/FacingScripts/
TileTriggers) rendered as garbage disassembly. Retyped the directories `map_tree`
and each sublist `map_entries`/`map_scripts`/`map_actors`, renamed to
`<Loc><Role>_<bank>`. The story-script handlers referenced by the records — and
the InitScript slot-6 code — were only ever reached by linear decode from the old
blanket data-start seeds; those were replaced with precise per-handler code seeds
(the record pointer fields + the code following each list's `$ff` terminator), so
handlers now carve cleanly and the record lists get exact extents. Net +135
instructions, still byte-perfect. `StoryCmdHandlersC_13` ($13:$526a) was **left
alone**: it has no `$4000` DataPtr slot and no `story_location` reference, its
slots overlap, and its "InitScript" isn't code — it is not a real directory.
The `map_actors` renderer was also taught that one Actors slot can hold several
back-to-back sentinel-terminated lists (runtime-selected variants — Courtyard
holds five, 28 actors total); it now emits every list instead of the first plus
a raw `db` tail.

### Bank $1b $402e "table" split into farcall data slots + stranded cursor code (2026-07-18)

The 159-byte `records:2` blob at **`$1b:$402e`** was two things run together. The
first 18 bytes are the **data-pointer tail of the bank's `$4000` farcall table**:
the table is 32 slots (`$4000`–`$403f`), slots 0–22 code far-pointers, slots
23–31 (`$402e`–`$403e`) data pointers into the `$78bd` region — reached only by
slot index through `FarCall` (`$01b6`), which is why no literal `ld hl,$402e`
reader exists. Registered in `add_static_data_slots` (bank `$1b`, slots
`$2e`–`$3e`, `lz` kind), they now render as `DataPtr_1b_2e`…`DataPtr_1b_3e` over
nine **LZ-compressed 2bpp graphics streams** (`Lz_1b_78bd`…`Lz_1b_7e6f`, the
`$78bd` blob split 1→9). Each decompresses to a whole tile count — six ×16
tiles, two ×40, one ×20 — confirming they're tile assets; the three near-identical
16-tile streams (`$7a78`/`$7ab5`/`$7af6`) are colour/shape variants of one small
icon. The runtime consumer computes the slot address dynamically (no static
`ld hl,$402e` site), so which screen loads them isn't pinned down yet.

Everything after `$4040` was stranded code the far-call dispatcher reached but
recursive descent never seeded: `DrawMenuCursorCorners` (`$4040`) queues the four
bobbing corner sprites of the menu selection cursor via `QueueSprite` (`$1f51`),
applying a per-axis 1px bob from `ApplyCursorBobOffsetX` (`$40a3`, X/`d`) and the
existing `ApplyArrowBobOffset` (`$40cd`, Y/`e`), each indexing a 16-byte
`(hVBlankCounter & $0f)` ramp (`CursorBobOffsetTableX` at `$40bd`). A code seed
for `$4040` (`coverage/bank01b_static_code.json`) plus a `bytes:16` override for
the bob table carve it cleanly; the `$40f7` sibling that draws the alternate
cursor style is now `DrawMenuCursorCornersAlt`. Still byte-perfect.

### Map-script tables made readable (2026-07-18)

The story-location tables in banks **$0e/$0f** now render through dedicated
macros instead of raw `db`/`dw` hex. Each location owns a 7-word **`map_tree`**
directory (copied to `$c286` by the bank $0a overworld engine) whose slots are
named by role: `EntryPoints`, `ExitTriggers`, `Actors`, `NpcScripts`,
`FacingScripts`, `TileTriggers`, `InitScript`. Every slot is a labeled pointer,
including slots that point at an empty (immediately `$ff`-terminated) list — the
`ds`-fill emitter path is now label-aware so a curated label on a fill byte is
emitted instead of dropped. The three record formats got macros in
`include/macros.inc`:
- **`map_actor`** cond, objdef, x, y, facing, obj_id, anim, palette — the
  14-byte actor spawn template `SpawnActorFromTemplate` ($04:$4c60) expands;
  each list ends with **`map_actor_end`** (the shared 9×`$00` + `$ff` sentinel
  `SpawnActorsFromList` stops on).
- **`map_entry`** id, sprite, x, y, arrival_script — 8-byte entry-point spawn
  record selected by `wStoryModeEntryPoint`.
- **`map_script`** id, facing_mask, flag_cond, handler, arg0, arg1 — 8-byte
  story-script record matched by `FindStoryScriptEntry` ($0a:$53e4).

Three bank $0f regions had been carved as a single actor table in an earlier
pass but actually hold two back-to-back structures; they were split into
separate labeled tables (with the second, code-referenced table now symbolic):
`$41e9` = `AwardsCeremonyActors_0f` + `AwardsCeremonyActorsDoubles_0f` (`$430b`,
the doubles arrangement); `$65c2`/`$7842` = `IslandOpenRoundActors_0f`/
`…Doubles` + their paired `…Scripts` tables (`$65f6`/`$78a0`). `$7842`'s script
handlers were stranded cutscene code — `$78cc` was already seeded, `$78b1` was
added to `coverage/bank00f_static_code.json` (+one 11-instruction routine).
`MarioWorldNpcScripts_0e` referenced four handlers (`$633d`/`$63f4`/`$64a4`/
`$654f`, the NPC-$08 approach-from-4-directions scripts, each ending
`jp PromptExhibitionMatch`) that were stranded as code inside blobs interleaved
with `04 00` actor-script data; seeded into `coverage/bank00e_static_code.json`
(+402 bytes code), carved cleanly between the surviving data records.
The per-round Island Open rosters reached by `ld hl` in `LoadIslandOpenRoundNpcs`
(keyed on `$c2b0` = round 1/2/3, singles vs doubles by flag `$05.7`) are named
`IslandOpenRound{1,2,3}[Doubles]{Actors,Scripts}_0f`, plus the singles round-call
pair `IslandOpenRound{Actors,Scripts}Singles_0f` (`$75b7`/`$7615`) and
`AwardsCeremonyScriptsDoubles_0f` (`$5b04`) — every `map_actors`/`map_scripts`
table in $0e/$0f is now labeled.

The trees are reached from **`StoryLocationTable_0a`** (`$0a:$564f`, 42×6-byte
records indexed by `GetStoryLocationRecordPtr`): each record is
`story_location id, scene, map_scripts, bgm`, where `map_scripts` is a
`dslot` into the target bank's `$4000` directory — rendered as the
`DataPtr_*MapScripts` label when that slot is a known data-pointer (all the
$0e-$13/$15 trees resolve, e.g. loc 17 → `TrainingGymMapScripts_0e`, loc 26 →
`AwardsCeremonyMapScripts_0f`). Bank $14's four map-script trees (`$4008`/`$4a39`/`$4fac`/`$5221`, = the
Tennis Machine Room / Court #1/#2 / fountain locations 18/22/23/27) are
registered as `$4000` data slots in `add_static_data_slots` and **fully carved
like $0e/$0f**: all 7 slots per tree retagged to `map_tree`/`map_entries`/
`map_actors`/`map_scripts`, sub-tables + init scripts labeled `Loc{18,22,23,27}
<Role>_14` (handlers/init were already code in `bank014_static_code.json`), plus
the two per-scene respawn actor lists `Loc23ActorsAlt_14`/`Loc22ActorsAlt_14`
(a false internal data-table boundary at `$4efa` inside the `$4eb4` list was
removed). The location table now reads `DataPtr_Loc18MapScripts_14` etc.
The four bank-$14 trees are named from the in-game location-name popup
(`ShowLocationNamePopup` text id `$0179+loc` = string bank $30 index `377+loc`):
`TennisMachineRoom`/`Court1`/`Court2`/`IslandSky` (locs 18/22/23/27). Decoding
that name block identified all 42 story locations, now emitted as a comment on
each `StoryLocationTable_0a` record (`STORY_LOCATION_NAMES` in disasm.py) —
locs 30-41 are the End1-End17 ending tour. The Restaurant/Cafeteria trees
(bank $10, locs 13/14) and Center Court tree (bank $11, loc 24) are also carved
like $0e/$0f/$14 (three handlers seeded: `Func_10_5cb0` + the `Func_11_4199`/
`_41a3` no-op rets). The Academy Main Bldg. / Academy Wing trees (bank $10,
locs 5/6) are carved too — three more handlers seeded (`Func_10_623b`/`_6372`/
`_63e0`) and the Wing's Tile table `$6361` fixed from a `bytes:16`
mis-classification to `map_scripts`. The Test 2 / Development dev maps (bank
$10, locs 4/1) are carved as well (four `farcall`-headed handlers seeded); the
Main Menu (loc 0) and Test (loc 3) entries reuse the match-select structures
(`$4e6c` = `MatchSelectHandlersA_10`, `$4010` = the match-select main tree) and
are left resolving to those. The Test 2 exit table `$478e` had been over-sized
to 457 bytes; it is really 8 records, and the ~392 trailing bytes were 16
back-to-back exit/warp script routines (`$47cf`-`$4ade`, tiling exactly to the
Npc table) seeded as code. Its exit handler `$7bf9` is another `MapScriptNop`
(now `MapScriptNop_10` + `MapScriptClearActiveFlag_10`). Bank $27's `$4000`
(what had been curated as `SceneFramePtrs_27`) is really a 12-tree map-script
directory for the End1-End17 ending tour (locs 30-41): all 12 trees are carved
(`End<n><name>MapScripts_27`), the 12 staging scripts and shared exit no-op
`MapScriptNop_27` (`$7885`) were seeded from the old `SceneFrameData_27` blob
(+3780 instructions of real cutscene code; every data blob still ends on a
`ret`, so no misframing), and three lumped respawn actor lists split out. The
story location table is now fully resolved to named trees for all 42 locations.
The last two (loc 0 Main Menu `$4e6c`, loc 3 Test/character-select `$4010`) were
mislabeled `MatchSelect*` by an earlier pass — `$4e6c` had even been seeded as a
jump table, mis-decoding its data slots as code. They are now carved as
`MainMenuMapScripts_10` / `MatchSelectMapScripts_10` (false jump-table seeds
dropped, the off-by-2 `MatchSelectEntries_10` framing replaced by the real
`MatchSelectActors_10` = the 9 selectable characters). `render_map_table` also
learned `map_tree` so directories reached as data-slot marks render symbolically.

All six trees (Training Gym / Mario World / Special Court in $0e; Small Char.
Test / Awards Ceremony / Tournament in $0f) have their sub-tables labeled
(`<Tree><Role>_0X` in `labels.json`, +34), so the directory reads symbolically.
The record handlers/arrival scripts are indirect-dispatch code heads (reached
via `CallHLInBankA`), so recursive descent never labeled them; `disasm.py` now
seeds a `Func_` label for each (`map_script_code_targets`) and the macros
reference them by name. Implementation: `data_tables.json` retags $0e/$0f
tables to `map_tree`/`map_actors`/`map_entries`/`map_scripts`; `disasm.py`
renders them via `render_map_table` (pointer fields resolve to same-bank
labels). Rebuild stays byte-perfect (`make compare` → OK); only $0e/$0f change.

### Blob classification pass (2026-07-16)

A systematic sweep classified every remaining anonymous blob (code vs table vs
data), raising proven source from 282 KB to 388 KB and cutting the manifest
from 5,288 to ~5,000 entries. Highlights:

- **Shared menu-screen architecture** discovered and carved across banks
  $0e/$0f/$10/$11/$12/$14/$15 (each now 75-92% code): 7-slot dw trees whose
  slots are 14-byte entry records, `{id,$ff,0,dw handler,...}` handler tables,
  and a slot-6 code entry; every in-bank handler target was decode-verified
  and seeded (`coverage/bank0XX_static_code.json`), tables render inline via
  `data_tables.json`. Each bank ends with a ~600-byte resource-descriptor
  blob (`$10`-headed, $f9ff/$fbff/$fcff terminators) that the entry records
  point into — some with embedded 1-5 byte micro-handlers (seeded).
- **Bank $0c is an unreferenced leftover music bank**: same 4-channel
  `(channel word, stream ptr)` song format as $78-$7f, but `PlaySound` can
  only bank-switch to `$70|nibble` and no code anywhere switches to $0c.
- **Banks $2d/$2e/$2f** were already-named math tables (SineTable,
  CosecantTable, PerspectiveScaleTable, ViewScaleTableA/B).
- **Scene banks $5f-$69**: per-scene (metatile map, 8-palette set) groups —
  36 palette blobs render via `palettes`; pointer-targeted all-$ff tails
  (unused $4000-slot targets) now collapse to `ds N, $ff` in the emitter.
- **Ball-position twins $24/$29/$2c** carry local helper code ahead of their
  6-byte record payloads (seeded), like $20-$23/$2a/$2b.
- **Stub farms and continuation heads** in the engine/screen banks
  ($03/$04/$05/$06/$0a/$0b/$0d/$13/$16/$17/$18/$1a/$1b/$1c/$1d/$38/$39/$3e/$3f)
  were bulk-seeded after perfect-tiling verification
  (`coverage/bank_misc_static.json` et al). Bank $16 went 15%→83%, $06
  27%→89%, $12 26%→86%, $39 16%→70%.
- **What remains binary is data**: 2bpp graphics, the menu resource
  descriptors, `04 00`-family param records, OAM coordinate lists, level
  definitions (bank $0b's $47b4 directory), zeroed buffer templates and
  fill. Known deliberate hold-out: bank $0e `$71e9` (code head that flows
  into embedded data with no terminator — needs runtime coverage).
- Verification loop per bank: pattern carver (handler-table / record-run /
  dw-table detectors) → decode-verify every candidate before seeding →
  regen with `--hooks` → `make compare` → re-screen; a final ROM-wide
  code-shape screen over all blobs returns only known data.

### Code structure — solved conventions

**Farcall convention:** `rst $18` + two inline operand bytes (`db slot, bank`)
dispatch through a per-bank pointer table at $4000 via the FarCall trampoline
($01b6). `tools/disasm.py` emits these as `farcall FarPtr_bb_ss` (macro in
`include/macros.inc`), renders the tables as labeled `dw` entries, and seeds
descent from every table target. This gave the cross-bank call graph.
6,441 farcall sites. **Slot names derive from curated targets
automatically**: a table slot whose function or data target is named in
`labels.json` is emitted as `FarPtr_<Name>`/`DataPtr_<Name>` (extra
slots for the same target get `<Name>Alias1`, `Alias2`, ...), so call sites read
`farcall FarPtr_ClearSpriteSlots` and data-loader notes read
`-> DataPtr_CourtDiagramTiles` — naming a target names its slot everywhere,
with no extra annotation. `infer_tables()` exploits the self-delimiting layout of
dense banks to recover unused entries (+24 KB of statically proven code).

**All rst vectors decoded** as inline-operand pseudo-ops (macros in
include/macros.inc):
- `rst $00` → JumpTableDispatch ($06c4): inline `dw` jump table, indexed by `a`.
- `rst $08` → sound/music command ($2fb3), one id byte: `sound $xx` (451 sites).
- `rst $20/$28/$30` → three commands sharing an operand fetcher ($253d) that
  reads an inline `dw` pointer into de: `rst20/rst28/rst30 $xxxx`.
- `Func_00_07c5` is a register-based far dispatcher — runtime-computed, not
  statically exploitable.

**Inline-argument calls** (`INLINE_ARG_CALLS`): `Func_00_2725` is a ROM0 helper
that reads the byte at its return address (a repeat count) and steps the return
past it, so every `call $2725` is followed by one inline data byte. `decode_at`
emits it as a 4-byte pseudo-op rendering `call Func_00_2725` + `db $xx ; inline
arg` (mirrors the rst08/farcall inline handling). Fixed 33 mis-decoded sites
across 12 banks (the arg byte had been swallowing the next real instruction).

**Match-launcher stubs** (`seed_launcher_stubs`): banks $10/$0e hold runs of
uniform 14-byte functions that store a match id into
`wCurrentMinigameStoryMatch` and `farcall FarPtr_0a_5a` (the match starter),
reached via dw tables read through RAM. The rigid shape is scanned and
seeded statically (runs of 3+), and the launcher dw tables render as
labeled `ptr_words` entries — 41 stubs + a 35-entry table in bank $10's
story match-select data. The 5-instruction body (set match + court `$c8f7`,
`farcall FarPtr_LoadMatchSettingsFromTable`) now collapses to the
`load_match_settings match, court` macro via `match_launcher_seq` (70 sites
across banks $0e-$13: the 41 ret-stubs plus 29 inline callers).

**WRAM bank switches** render as the `wram_bank` macro (macros.inc): the
`ldh [hWramBank], a` + `ldh [rWBK], a` shadow-write pair, with an optional
immediate (`wram_bank $04`) when preceded by `ld a, imm`. All 2,020 pairs in
the ROM collapse (1,596 immediate + 424 bare, e.g. after `pop af`); a
peephole in `disasm.py`'s emitter (`wram_bank_seq`) skips sites where a jump
target lands mid-sequence — none exist today.

**Twin data banks:** groups of data banks carry relocated copies of the same
bank-local helper, dispatched via farcall slot 0. Confirmed: an OAM-frame
loader in $1f/$25/$26/$30-$37/$5e/$6e (one bank per character's animation
frames); `infer_twin_tables()` fingerprints slot-0 targets by opcode shape.

Largest code banks: $08 (match engine, 99.6% code), $05, $00, $13 (story
engine), $6b, $03 (save engine), $0a, $07.

### Data banks — carved and named

- **30 character-sprite banks ($40-$5d)** named after their owners (Mario,
  Peach, etc.); $5a is the **training ball machine**, not a character.
- **Sound banks** ($0c, $78-$7f) carved.
- **Sprite/object banks ($6a, $6f, $70-$77)** fully decoded from bank $04's
  $4f75 dispatch table: each record is a 16-byte header (count/flags + `dw`
  body pointers), an inline `.frames` pointer array to its 16x16 frame
  graphics, and an `OamPtrs` array to per-frame OAM sublists. All 92 records'
  header/array structure renders in-source; only the leaf frame-graphics and
  OAM bytes stay as gitignored blobs. `disasm.py`: `add_object_header_slots` /
  `split_object_bodies` / `follow_oam_arrays` / `follow_frame_arrays`.
- **Bank $2d is the trig ROM**: `SineTable` ($4000, 2048 words,
  sin(i*pi/2048) in 1.15 fixed point over a half turn) and `CosecantTable`
  ($5000, 2048 words, 0.5/sin clamped to 1.0). Consumed only by the bank-0
  trig suite at $1332-$13c9 (`MulSinCos`, `MulSin`, `DivBySin`/`DivByCos`,
  and `VectorLengthFromAngle`, which picks the better-conditioned reciprocal
  by quadrant) — used by the match engine's trajectory math. Angle unit:
  256 = full turn in b, fraction in c.
- **Banks $2e/$2f complete the 3D pipeline's tables**: `ViewScaleTableA`/
  `ViewScaleTableB` ($2f: linear multiply LUTs, slopes 103/128 and 234/128)
  and `PerspectiveScaleTable` ($2e: byte reciprocal, indexed view-depth +
  $2000). `ProjectWorldToScreen` ($2d8c) combines them: screen-Y from
  A*depth + B*height, screen-X from X, both scaled by
  PerspectiveScaleTable[B*depth - A*height] — a fixed-pitch camera
  (pitch = atan(A/B) ~ 24 deg) with table-driven multiplies throughout.
- **Menu / court / cutscene graphics streams** named; `tools/gfxdump.py`
  renders PNG contact sheets of the carved LZ streams for identification.
- **Menu/status screen assets decoded**: `ScreenAssetRecordTable`
  ($39:$40f5, 70 records x 4 slot words, rendered in-source as `dslot` lines of FarPtr_/DataPtr_ slot labels — the farcall operand encoding — so records read as their targets' curated names) — each
  record is (LZ tiles, LZ tilemap, LZ attrmap, 64-byte BG palette set) for
  one full screen; `LoadScreenAssetRecord` ($39:$407e, `farcall
  FarPtr_LoadScreenAssetRecord`, 20+ sites) walks a record per screen id
  and feeds the palettes to `LoadPaletteShadow`. The records read their
  slot words through RAM, invisible to static backtracking, so
  `disasm.py`'s `add_slot_record_tables` walks the table, anchored on the curated label and delimited by proven code: +252
  proven slots across banks $17-$19/$3a/$3c-$3f/$6d etc. (7 placeholder
  records skipped). All 70 records rendered offline and identified: the
  full menu/UI screen set (title, company logos, intro attract slides,
  play-mode / exhibition / equipment selects, link screens, tournament +
  N64-tournament charts, brackets, Ring Shot HUD, rules, Varsity Team
  Chart) plus the story cutscene sets (victory poses, shop scenes, award
  ceremony, champion medal + photos) — every record's
  tilemap/attrmap/palette blob is named after its curated tile stem, and
  all palette sets render in-source via the `palettes` blob spec. The
  proven slots are also fed to `infer_tables` as ground truth: a data
  target whose bytes decode as instructions is no longer claimed as an
  unused code entry (this retracted ~230 false instructions in bank $6b
  that had eaten the title-screen tilemap/attrmap/palettes and the
  ceremony maps).
- **Match-scene graphics system mapped**: `SceneGfxSlotTable` ($0a:$59d9,
  37 records x 8 slot words, rendered as `dslot` slot-label lines) covers banks $5f-$69.
  Slot layout: +$0 scene config (camera scroll bounds -> $c329-$c32c at
  struct offset 2, plus court-line lists; second half is the mirrored
  swapped-ends copy), +$2 = 8 BG palettes (courts use 2-7), +$4/+$6 = LZ
  tilemap/attrmap (32x32 for courts, 64x64 for story maps; attrs all VRAM
  bank 1), +$e = LZ tiles, +$c dead (never read — formulaically points at
  the next scene's data or bank filler). Slots +$8/+$a are dual-purpose:
  `LoadCourtSceneGraphics` ($0a:$62f8, the match loader, verified live via
  the hook log) copies them raw as the 80-byte court parameter pair to
  wram4:$de80/$dea8 (courts point +$8 back at the +$0 config), while
  `LoadStorySceneGraphics` ($0a:$585d, the story loader, matches the
  session2 story-drive hook trail) LZ-decompresses them to wram6:$d000/$d400
  as an auxiliary 32x32 map/attr layer (collision-like for interiors).
  `GetSceneSlotPtr` ($0a:$5d0b) fetches one slot word.
- **All 18 court/scene images in banks $5f-$63 identified and named**
  (scene id: name): 0-1 ClubhouseScene/CourtyardScene ($5f); 2-5 the four
  exhibition surfaces GrassCourt/HardCourt/ClayCourt/CompositionCourt
  ($60; hard verified live); 6 MachineCourt (ball-machine training court,
  matches bank $5a's machine sprites), 7 CenterCourt, 8 PracticeCourt
  (plain fenced court w/ scoreboard; name inferred), 9 YoshiCourt (Fruit
  Fantasy fruit borders) ($61); 10 StarCourt (Shooting Star), 11
  BowserCourt (lava castle, Two-on-One), 12 WarioCourt (Treasure Box
  crates + biplane), 13 PeachCourt (Perfect Shot winged-heart panels)
  ($62); 14 IslandOpenCourt (videoboard stadium), 15 DKCourt (Banana
  Bunch), 16 StarPatternBg (star-wallpaper backdrop, loaded via the match
  loader in session1 — likely a minigame/ceremony backdrop), 17
  DormInterior (64x64 RPG interior map; slots $30-$3e of bank $63's
  32-slot table, proven by the iterative slot scan — acceptance recomputes
  table extents until a pass adds nothing, since a newly proven slot's
  target can delimit the table; the old `DormInteriorScenePtrs` numeric
  rendering is superseded) ($63). Minigame court themes match the minigame host text (Yoshi=Fruit
  Fantasy, Peach=Perfect Shot, Bowser=Two-on-One, DK=Banana Bunch,
  Wario=Treasure Box).
  Generator: curated labels now split anonymous data runs (disasm.py), so
  streams reached only through non-slot pointers carve out of blobs.
- **All 19 story-mode scene maps in banks $64-$69 (records 18-36) identified
  and named**, rendered offline full-color (tilemap + attrmap palette-select
  + tiles decompressed from the ROM). These are 64x64 overworld/interior maps
  (vs the 32x32 courts), each with a 32x32 aux tilemap/attr layer at slots
  +$8/+$a. (record: name): 18 DormBedroom (player room interiors, pink/blue),
  19 Countryside (field + cottage + road), 20 AcademyGrounds (campus court +
  buildings) ($64); 21 Seaside (ocean/island/boat), 22 HedgeCourt, 23
  ClayCourtGrounds ($65); 24 HardCourtGrounds, 25 SpaResort (pink resort), 26
  MainBuilding (grand hall + courts), 27 GardenPavilion ($66); 28
  FountainCourt, 29 CafeCourt, 30 CourtComplex (mixed courts + lake) ($67);
  31 ClubCourt, 32 StadiumGrounds (grandstand stadium), 33 CeremonyHall
  (trophy/award hall) ($68); 34 TrainingHall (Lv1-4 court-select interior),
  35 CenterCourtHall (CENTER A/B courts + pool interior), 36 ClubroomInterior
  ($69). Names are descriptive (tile-derived), not confirmed canonical.
- **Duplicate $4000-table pointer entries are alias-named.** When several
  slots point at one target (dual-purpose/dead scene slots that alias a real
  asset; defaulted fan-in ranges like bank $39's 18 slots -> `Lz_39_47ab`),
  the first entry is `DataPtr_<Target>`/`FarPtr_<Target>` and the rest are
  `<Target>Alias1`, `Alias2`, ... (`disasm.py assign_slot_names`), so every
  duplicate reads back to its target instead of an opaque `DataPtr_bb_ss`.
  158 duplicate entries across 16 banks ($39/$3a/$3d-$3f/$5f-$69/$6d) now
  carry a target-derived name; singletons whose target isn't curated keep
  their numeric slot name.
- Raw blobs are split at interior slot-table targets, overlapping copy blobs
  clipped, and LZ stream extents carved exactly (incl. the 3-byte terminator).

### Text / string system — fully symbolic

Game text renders through `text` / `line` / `page` / `done` macros with
label-based index tables. Text-bank string index tables are decoded and the
fetch stubs proven. `tools/strings.py` dumps text by bank; `--index` lists it
by bank and string-table index. Text regions are emitted as generated `db`
source under gitignored `data/`.

### Battery save format — fully reversed (`docs/save_format.md`)

32 KiB SRAM, 4 banks. Engine named (bank 3: `InitSaveHeader`,
`WriteSaveBlock`, `SaveStorySlot`, `ValidateSaveRam`, ...). Header signature
`"CAMELOTGBTENNIS\0"`, master + per-block checksums, a bank-1 mirror, block
directory, and story-slot layout (character records: name/level/11 stats/EXP)
all documented. **Global 256-bit flag array at `$a040`** holds character-roster
and mini-game unlocks. `tools/savetool.py` verifies / dumps / edits saves
(recomputing all checksums + the mirror); `savetool.py unlock` sets the flag
array to unlock every character and mini-game (verified in-emulator). Noted a
real game bug: `ValidateSaveRam`'s mirror re-check compares the wrong signature
offset, so a corrupt header always falls through to a full wipe.

2026-07-18 pass: the full 113-entry block directory extracted from
`InitSaveHeader` (most of it never written — including blocks addressing
SRAM banks 4-14 that don't exist on the 32 KiB cart); minigame-record
blocks `$38-$3d`, the 9×9 star-exhibition victory grid (block `$3e`,
`Read/WriteStarVictoryGrid`), and the N64 Transfer Pak records block
(`$0b`: presence word + per-char unlock flags) reversed; header fields
named as bank-3-scoped SRAM symbols (`sSaveSignature`,
`sSaveMasterChecksum`, `sSaveFormatVersion`, `sSaveBlockDirectory` via
`ram_unions.json`); all WRAM staging buffers mapped (WRAM7
`$d480/$d500/$de00`, WRAM6 `$d400`, WRAM3 `$d900`, WRAM1/2 `$d000`) —
see the expanded `docs/save_format.md`.

## Pipeline (all working, all documented in README.md)

1. Coverage collection — two paths:
   - **BizHawk native Trace Logger** (fast gameplay) → `tools/tracelog2cov.py`
     (handles auto-split `_N.log` segments, resolves banks by opcode-byte
     matching, rejects DMA/halt-bug corrupted lines).
   - **gbc-disasm MCP connector** (autonomous driving, slower) →
     `dump_coverage` writes `coverage/<name>.json` directly from the Lua.
   Data-loader arguments are also captured at runtime (hook captures) and
   ingested as data slots.
2. `tools/disasm.py baserom.gbc coverage/*.json` — regenerates `src/` from
   coverage seeds + conservative recursive descent. Symbol sources: fixed
   vector names, `labels.json`, hardware.inc registers, and `ram_map.json`
   (RetroAchievements-documented RAM → `ram.asm` +
   `ram/{sram,wram,hram}.asm`, one fixed-address SECTION per region with
   `::`-exported labels the linker resolves into every bank). Fails
   early on unsupported RGBDS versions; enforces a naming-convention lint.
3. `tools/extract.py` + `make clean && make -j compare` — verify byte-perfect.

Supporting tools: `sm83.py` (opcode tables), `lz.py` (LZ codec), `strings.py`,
`gfxdump.py`, `savetool.py`, `progress.py`, `hook_client.py`, `trace_client.py`.
RGBDS 1.0.1 binaries in `tools/rgbds/` (gitignored); Makefile defaults there.

## Autonomous driving

The `/drive-coverage` skill captures the full playbook: pause_emulation for
deterministic input timing, screenshot navigation, savestate checkpoints, SRAM
safety rules, cursor-jiggle before A, serve timing, and match telemetry via
`read_memory` at $c8e0. The gbc-disasm MCP server lives at
`~/code/gbc-disasm-mcp` (uncommitted, not a git repo). If BizHawk or the MCP
server restarts, reload `lua/disasm_connector.lua` + `/mcp` reconnect.

## Coverage inventory (`coverage/`)

- `clean_session1.json` — human menu/match play (post-pairing-fix, clean).
- `native_seg*.json`, `native2_seg*.json` — two human Trace Logger sessions.
- `autodrive1.json`, `autodrive2_*.json` — autonomous drives (dictionary,
  status, Shooting Star minigame, doubles, exhibition options/camera, serve,
  match results, clay court, difficulty select).
- `story_intro.json` — human story-mode intro (145 segments, 217M traced
  instructions, 22 GB of logs unioned; +11,973 seeds). Story engine lit up
  banks $04/$05/$0a/$10-$15/$1c/$1d/$38.
- `story2_overworld.json` — autonomous story drive: save-continue, story pause
  menu, Restaurant + NPC dialogue, dorm/plaza/training maps, Harry dorm event,
  and the full **Stroke Practice drill engine** in $1d.
- `story3_drillwin.json` — human: winning the stroke-practice drill (success
  handlers in $1d) + reward flow ($1c/$1d/$1e/$02).
- `story4_servevolley.json` — human: serve-and-volley drill ($17/$15/$0b, $25).
- `story5_netplay.json` — autonomous: Net Play Practice drill (only 3 new seeds).
- `story6_restaurant_traingame.json` — human: restaurant + a training game
  ($0e/$0a/$10/$12 tennis-machine/$0d, first code in $6e).
- `story7_rankingmatch.json` — human: full junior ranking match, won ($11
  ranking flow, $16 EXP earn/distribute first code, $1e/$08/$2c/$24/$32).
- `session3_status_menus.json`, `session3_story.json` — autonomous drives:
  status-screen menus and story overworld.
- `session4_native.json` — human Trace Logger session (42 segments, 6.4 GB of
  logs unioned; 32.0K distinct offsets). All 577 offsets not in prior traces
  were already carved by recursive descent (mostly bank $12 tennis-machine and
  $1d/$1e drill code), so `src/` is unchanged — pure confirmation coverage.
- `contaminated/` — pre-fix dumps with phantom seeds; never union these.

Phantom-code cleanups since then: banks 42/43 were zero-filled farcall targets
(rejected), a misattributed seed in bank 65 was denylisted, and rst38-padding /
zero-filled farcall targets are now filtered. Build stays byte-perfect.

## Not yet covered (biggest wins first)

1. **Rest of story mode** — ranking matches beyond the first (senior/varsity),
   level-up/stat-distribution details, Wall Practice room engine, Academy Main
   Building/Wing maps, later areas (tournament, Peach's castle). (Covered:
   stroke + net-play drills, tennis machine, restaurant/cafeteria, first junior
   ranking match with EXP screens.)
2. Match-point → ceremony transition, tiebreaks, deuce.
3. Remaining minigames (locked behind story), Game Boy Tower, tournament.
4. Grass court init; 6-games/3-sets match configs; more characters.

## Annotation state

**Human-named symbols: 6,789 of 20,708 labels** (`tools/progress.py`; the rest
are auto-generated `Label_/Data_/FarPtr_` names — no `Func_` is left). Bank 0: 56 named routines
(docs/bank0_notes.md) — FarCall trampoline, OAM DMA stub, joypad, LZ
decompressor, sound engine entries, OAM sprite queuers, SoftReset, interrupt
handlers. Bank 3: save engine (23 named, docs/save_format.md). RAM:
docs/ram_map.md (280 entries in `ram_map.json`: 129 RetroAchievements-sourced
plus project-identified ones — match ball position/velocity/target, shot
type/aim, renderer effect/marker state, mode-hook table, story-mode location
entry/spawn/exit state, save-slot index + `wSaveBlockBuffer` staging buffer,
shadow-tilemap far pointer + glyph-pen text state, match-format menu
selections, serial-link HRAM vars, `hSramBank`/`hWramBank`, point-situation
flags (`wMatchPointFlag`/`wSetPointFlag`/`wGamePointFlag` via
`EvaluatePointSituation`'s simulate-next-point trick), ace/fault flags,
`wMatchRngState`, bank $6b cutscene driver step/timer/scroll).
A 2026-07-18 pass swept the hottest unnamed addresses per subsystem;
deliberately left unnamed: the story-script scratch pool `$c2b0-$c2ff`
(meaning changes per location script) and unproven mode-local bytes.
**Union overlays**: ranges reused by non-concurrent subsystems are modeled
via `ram_unions.json` → RGBDS `UNION`/`NEXTU` blocks in `ram/*.asm`, with
*scope-aware* operand substitution in `disasm.py` (a variant's names render
only at code sites inside its declared scopes; a `default` variant covers
everything outside scoped ranges; unproven consumers keep numeric addresses).
A scope is `{bank[, start, end]}` (ROM location) and/or `{wram_bank: N}`
(the WRAM bank provably selected at the site, from `compute_wram_bank`'s CFG
dataflow — see the dated section below); constraints in one scope AND, scopes
within a variant OR. Current overlays: `$ffd0-$ffef` (serial-link input slots
default; bank-0 sound driver, sprite queue, story actor engine scoped),
`$d100-$d219` (sound-engine WRAM, `wram_bank $07` + bank-0 range),
`$c780-$c784` (char-select cursor, bank `$1b`), and the bank-`$03` save
header/directory. See docs/ram_map.md "Union overlays".
`disasm.py` now also inlines curated RAM symbols into `ld hl/de/bc, imm`
pointer setups (same curated-only rule as data labels), so 16-bit fields
read via pointer render symbolically. Data banks:
character/sound/walk-sprite/graphics streams named as above.

The match engine's **per-character WRAM-bank structs are mapped**
(docs/ram_map.md "Match engine per-character structs"): banks 4-7 each hold
one on-court character at the same `$dfxx` addresses (4/6 = near-side pair,
5/7 = far-side pair; `ForEachCharBank` $6a3a iterates them). Known fields:
24-bit fixed-point X/depth/height at `$df00/03/06`, state machine at `$df18`,
walk targets at `$df46/48`, velocity at `$df40`. 15 routines named around
this: the walk-to-target loop (`MoveCharTowardTarget`/`CheckCharNearTarget`),
char state/facing/placement setters, and the point-end doubles-spacing chain
(`StartPointEndReactions` → `SpreadTeammateTargets` → `ComputePairSpread`,
which spreads a team pair's target depths $200 apart, min $100 from the net).

The **match sprite renderer is mapped** (docs/ram_map.md "Match renderer
sprite slots"): everything on court funnels through 4-byte slot records
`[tile, attr, Y, X]` ($ff = empty) cleared per frame by `ClearSpriteSlots` —
ball / ball shadow / trail slots at `$de00+` (bank 4), per-character sprite +
airborne-shadow + standing-shadow slots at `$df80+` — flushed back-to-front
by `DrawActorsByDepth` using the `$df96` depth keys. The ball keeps a
6-record position history ring at `$dd00` for the trail afterimages
(`BallTrailPalettes` at $50dc colors them by shot type). Direct-draw effects
(hit spark, special-shot flash, bounce dust, lob landing marker, training
target zone, off-screen arrows) and the per-mode draw hook
(`SetModeHookTable`/`CallModeHook`) are named too — 38 routines in this
pass, plus the bank-0 OAM queuers (`QueueSprite`/`QueueSprite16`/
`QueueSpriteTemplate`) and `TickTimer`.

Bank $08's 39 embedded blobs were classified (data table / stranded code /
padding). The ~281 bytes of code stranded behind computed jumps were recovered
as static seeds (`coverage/bank08_static_code.json`), taking the bank from
94.7% to 96.4% code. The 24 genuine data tables were then structured via
`data_tables.json` render specs (a `records:2` jump table, `records:4/5/8` and
`bytes:4/8` lookup/record tables) — `disasm.py` now renders these inline as
committed `db`/`dw` in the bank `.asm` (not gitignored INCBIN blobs). Strides were verified against the reading code where a direct
`ld hl,$xxxx` exists (e.g. `$709b`/`$70b4` are indexed `hl + i*4`; `$55a0`
strides by 5); tables reached only through computed pointers (`$5dc4`,
rendered `bytes:4` as a 25×4 grid) got their stride from the byte layout.
`$7a9d` was split into its two structures — a 16-entry `dw` pointer table and
its 32-byte payload (4×8-byte rows; the pointers land on rows +0/+8/+16/+24) —
by teaching `disasm.py` to end a data segment at any mid-run `data_tables.json`
key, so one region can hold back-to-back tables.

**Bank $08 now has zero data blobs — every byte is committed source.** The
last four INCBINs fell to three fixes: (1) a 672-byte region at `$4979` that
had been *misdecoded as code* was reclassified — the rst $00 jumptable at
`$4836` has only 4 live entries (index = char count - 1), but the parser had
extended it over the 8 dead pointer bytes at `$483f`, seeding descent into
data. `parse_jumptables` now stops at any declared `data_tables.json` offset,
and the region renders as the **court-position tables**: `GamePositionPtrs`/
`TiebreakPositionPtrs` (per-char-count `dw`, read via split add/adc at
`$480c`/`$48cd`) into `GamePositionTables` (3 blocks x 4 games x 8-byte
records) and `TiebreakPositionTables` (3 blocks x 24 points x 8 bytes); each
record is 4 per-char `$df0a` position codes + 4 per-char `$df09` serve/side
codes, applied by `AssignCourtPositions`/`LoadPositionRecord`. (2) Two
stranded `ret` bytes (`$6957`, `$6d26`) joined the static code seeds. (3) A
$ff run that reaches the bank end is now emitted as `ds` fill regardless of
length (previously needed 64+; this also converted short trailing fills in
13 other banks).

**Bank $3b got the same treatment — zero blobs, 98.0% code** (was 77.8% with
67 blobs). Blob classification found ~1.6 KB of genuinely stranded code (70
static seeds in `coverage/bank3b_static_code.json`): sprite-row renderers
calling `QueueSprite`, a 529-byte cursor/menu handler at `$41a8` reading
`$cb04/$cb05`, `wram_bank $03` helpers, and functions reached only via
`ld hl, addr` + `jp hl` dispatch (e.g. `$6cac` loads `$6f5b`). The other 65
regions were structured via `data_tables.json`: WRAM `dw` pointer lists,
self-referencing pointer-table + payload pairs, OAM sprite-template rows
(`bytes:4` with `$80` terminators), 16-byte permutation tables, and small
byte lookups; mixed blobs (data + code + data, e.g. `$5278`, `$734f`,
`$79b6`) were split at exact boundaries. First semantics are in: the shared
**menu cursor system** (`MoveMenuCursor`/`MoveMenuCursorRepeat` on
`wMenuCursorX/Y`, fed by `hInputPressed`), the stat-number printer
`PrintNumberRightAligned` (36 call sites in bank $16's match-stats code),
and the **star-unlock records**: `RecordExhibitionVictory` keeps a 9x9
best-victory matrix (Mario cast vs Mario cast, scored by difficulty via
`VictoryScoreTable`) in a save block, and `UpdateStarUnlocks` awards a
star when a character has beaten all eight others. Bank 0 gained the
banked **frame-task registry** (`RegisterFrameTask`/`ClearFrameTasks`,
`wFrameTasks` at $c1c0, gated by `hFrameTasksReady`) — the computed
dispatch that stranded several of the recovered callbacks — plus
`FormatDecimalNumber`, `hRomBank` ($ff95), and `hInputPressed` ($ff91).
Bank $3b's interactive screen builders (the story pause-menu 3x3 grid and
its sub-screens) still need a live BizHawk session to identify visually.

**Bank $00's remaining blobs were classified** (math tables / stranded code /
sound tables). ~679 instructions of code reached only through computed
dispatch (pointer tables, farcall trampolines) were recovered as static seeds
(`coverage/bank00_static_code.json`): `AngleFromVector` (an atan2-style CORDIC,
the inverse of the `MulSinCos` suite), six banked-dispatch trampolines
(`FarDispatchIndexed`/`FarCopyIndexed`/`FarCallIndexed1..3`/`FarReadPtrIndexed`,
each mapping a bank into `H` and calling/copying via its `$4000` table), the
world-to-screen sprite transform (`PositionSpriteWorld`/`2` — camera-subtract,
cull against 22x20 tiles, x8 to pixels, then `QueueSprite`), and the tilemap
scroll blitters (`GetScrollBufferAddr`/`BlitBGStrip`/`2`). Two of these blobs
were code with embedded data tables interleaved; descent split them at the
exact `ret` boundaries. The genuine data tables were named and, where the
stride was clear, structured inline via `data_tables.json`: `SquaresTable`
(i² for i=0..255 + an `$ffff` sentinel, used for squared-distance checks via
the `$106e` lookup — emitted as a compile-time `FOR i, 256 / dw (i * i) &
$ffff` loop, `squares` spec, since the exact integer formula rebuilds
byte-perfect), `TangentTable` (signed 8.8 fixed-point, clamped ±$7fff near
90°, read by `Func_00_1767` — kept as literal `dw` because it's a
game-generated table whose custom rounding and overflow tail no compile-time
`tan` reproduces exactly), and the sound driver's `SfxIndexTable`/
`MusicIndexTable` (split at ID $50 by `PlaySound`). The sound engine's internal
`NotePeriodTable` (12-semitone GB period values, octave-shifted then subtracted
from 2048 to form the frequency register), `SoundChannelMaskTable`, and
`SoundPitchTable` were named and structured inline (`records:2`/`bytes:16`).
The `SfxIndexTable`/`MusicIndexTable` entries index `SoundTable_$78..$7f` — the
same `(length, pointer)` format as `SoundTable_0c` — in per-sound groups of
`voices` channel records. They render through a new `sound_entry bank, voices,
record` macro (`data_tables.json` spec `sound_index`, macro in
`include/macros.inc`) instead of opaque bytes, e.g. `sound_entry $78, 4, 0`.

A second pass took bank $00 from 51 data blobs to 9. ~600 more instructions
of stranded utility code were seeded (`coverage/bank00_static_code.json`, now
68 entries) — bank-switch/dispatch trampolines, VRAM/tilemap clears, the
number/hex formatters, the interrupt-config family at `$2a1a`, and
`JoypadInterrupt` (`$0060`, a `jp JumpTableDispatch` stranded in the vector
table). Each blob was verified to decode as clean code that tiles to its
boundary and whose descent never leaks into a protected data region; blobs
holding back-to-back functions got one seed per post-`ret` entry. The
rst/interrupt vector padding now renders as `ds` (an all-`$ff` unclassified
run is fill at any length, not just >=64). `HexDigits` (the `FormatHexWord`
nibble table) and `QuarterSineTable` (a `128*sin` easing curve) were named
and structured. The 9 remaining blobs are genuine data: the cartridge
header/logo, the sprite-transform's embedded tables, small sound lookups, and
the `$3dd4` sound block.

**Banks $2a/$2b (each 4 blobs -> 1)** are twin ball-height positioning banks
called from the match engine (bank $07's `FarPtr_2{a,b}_00` -> `Func_2*_5e9d`,
dispatched the same way; their `$4002`-`$424b` helpers are byte-identical).
Each opening `$4000` "table" is a single live farcall slot followed by
stranded multiply/scale helpers, now seeded as code
(`coverage/bank02{a,b}_static_code.json`). The real pointer tables are
`BallPos{Block,Sub,Height}Offsets_2{a,b}` (`$5ebf`/`$5ebd`) — three `dw`
offset arrays into `BallPosData_2{a,b}` (`$427d`), a 7200-byte block addressed
as `[10 outer][10 sub][12 ball-height] x 6-byte position records`
(`10*720 = 7200` exactly). `Func_2*_426e`/`424c` do `BallPosData + word[table
+ index*2]`; ball height (`wBallHeight`, scaled `& $1f`) selects the innermost
record. The one twin difference: $2a indexes the outer block by `$df6f`, while
$2b hardcodes it to 0 (`xor a`), so $2b's tables sit two bytes earlier.

**Bank $17 (serve-volley drill / menu bank) — code recovered** (50.1% →
58.6% code; 32 → 31 blobs). Seeded a big dispatcher (`$40bd` 841 B) + `$440a`
and, in a second pass, 10 more **cursor/menu handler** blobs (`$4016`-`$4443`,
reading `$cb04/$cb05` + bank-switch stubs) that the first classification had
mislabeled as data because they follow data tables. The remaining 31 blobs are
genuine data: uniform position/animation record arrays (`55 00 44 00 3a 00 …`,
several byte-identical — per-character/frame tables), LZ graphics, and OAM
templates. Lesson reinforced: after the first seed pass, re-scan the *new*
blobs — splitting a dispatcher exposes handler code that pattern-matches
(`fa 04 cb …` cursor reads, `f0 96 f5` bank swaps) but wasn't reached.

**Bank $0e (story match/launcher bank) — code recovered** (51.6% → 60.5%
code; 29 → 22 blobs). Seeded 8 stranded code blobs + farcall scripts (`$5bba`
774 B / 95 farcalls, `$43a6`, `$5422`). The big pointer-tables (`$75f6`,
`$5248`) and `$4006`'s targets were verified to point at `01 c0 00 …` data
records (not code) and left as data. Two bank-switch **code heads** (`$71e9`,
`$7c0c`) were tried but *reverted*: they run code straight into embedded data
with no `ret`, so seeding them misframed the adjacent `$75f6` data table into
`jp`/code — the recurring interleave trap (byte-perfect doesn't catch it). Left
as blobs pending runtime coverage.

**Bank $10 (story match-select) — code recovered** (31.9% → 39.5% code;
37 → 27 blobs). Seeded 16 stranded code blobs + two jump tables
(`MatchSelectHandlers{A,B}_10` at `$4e6c`/`$4fc6`) and several farcall
"scripts" (`$448d` 435 B, `$4450`, `$7443`, `$7472`, `$7bfa`)
(`coverage/bank010_static_code.json`). The remaining blobs are genuine
match-select **data**: big self-referential pointer-table + record structures
(`$61b1` 3649 B, `$468d`, `$74a9`, `$5a80` — each entry a `dw` into a
`01 40 00 …`-header record, verified *not* code before declining to seed) and
`$0cXX`-valued lookup tables (`$5ddc`/`$5f30`/`$5c34`/`$5899`/`$5982`).

**Bank $10 `$4000` header + `$4010` handler tree fully carved.** The bank's
`$4000` table is an 8-slot directory of match-select sub-tables; hooks proved
slots `$02-$06`, and `add_static_data_slots` resolves slots `$00`/`$08-$0e` (RAM-
dispatched, so no capture) as `DataPtr_10_*` over labeled sub-tables. Slot 0's
`$4010` was mis-decoded as code by a coarse `$4010` static seed that swept in the
whole pointer table and flowed into the setup routine that follows; the seed was
moved to its real entry (`$40b0`). `$4010` is now a 7-`dw` pointer table +
`MatchSelectEntries_10` (nine 14-byte records) + tail, all rendered inline.
Entry [3] `$4145` = `MatchSelectHandlerTable_10` (9 records `{id,$ff,$0000,dw
handler,$0000}`) whose handlers (`$40b0/$4195/$41da/$4450/$448d/$44cc/$4640/
`$40ef/$4137`, now `Func_10_*`) were carved out of the `d_40ef` blob.

**Bank $09 tileset de-blobbed.** The VRAM tileset at `$488a` (29-record
`{dw src, db tiles, db 0}` descriptor + `$4900-$60ff` tiles → VRAM `$8200`, loaded
by `Func_09_4873`) was split into three blobs by two lone coverage seeds
(`$24f99`/`$252b5`) that are data reads during the copy, not execution; added to
`BAD_SEEDS`, it is now one `VramTileset_09` + descriptor table. Also named
`MoveCurveTable_09`, `VramGfxPtrTable_09`, `ServeGfxPtrTable_09`.

**Bank $13 (story engine, biggest story bank) de-blobbed** (56.0% → 70.8%
code; 29 → 16 blobs). The bulk of its "data" was **story-command handler code**
reached through four small dispatch tables (`StoryCmdHandlers{A,B,C,D}_13` at
`$4006/$4e20/$526a/$5c78`, 7-8 `dw` entries each) whose targets point into the
data blobs — seeding those targets recovered the handlers
(`coverage/bank013_static_code.json`). A second pass recovered a run of
~22-byte story-command handler stubs (`$5968-$5a1a`), farcall "script"
sequences (`$6a89`, `$43a1`, `$4357`), small routines (`$7b4e`/`$7b53`,
`$5c27`), and code behind a 5-byte pointer header (`$4ef4`). The 16 remaining
blobs are genuine story data: scene/actor records (`$472c`/`$4c7e`/`$6638`
share a `00 00 25 7b …` record header), coordinate tables, and small lookups.
See [[stranded-code-carving]].

**Bank $1b (dispatch bank) — code recovered, dispatch tables remain**
(38.2% → 45.1% code). Seeded 11 stranded handler blobs
(`coverage/bank01b_static_code.json`, function starts + internal flow targets);
the two code+data-interleaved ones (`$5f5f`, `$664b`) split correctly, leaving
their embedded tables (`$5f69`, `$6035`, `$6671`) as data. The bank's bulk is
large irregular **jump-table + inline-handler** regions (`$504e` 1219 B,
`$5856` 987 B stride-16 stubs, `$5c8d` 708 B stride-48, `$402e` resource-pointer
table) and a 2.4 KB `$446d` blob — each is a few leading `dw` pointers then
runs of handler stubs, reached via `jp hl`. These need per-table extent
analysis (or runtime coverage) to seed safely and were left for a later pass.

**Bank $1e (reward/results screen-resource bank) fully identified**
(52.7% → 61.5% code). Turned out to be a screen-resource bank: sequences of
LZ-compressed graphics streams (loaded via `ld hl,src; call DecompressData`)
and small palette sets (`call LoadPaletteShadow`, `de` low byte = palette
count) bundled per reward/results screen. Three giant opaque blobs ($4c40 2 KB,
$5be1 2.4 KB, $75a6 1 KB) were carved into **21 exactly-bounded named streams**
(`Lz_1e_*` × 15, `Palettes_1e_*` × 6) by enumerating every DecompressData/
LoadPaletteShadow source and labeling each — the streams chain contiguously,
so label-splitting yields the exact compressed length (verified against
`tools/lz.py`, e.g. `Lz_1e_4c70` = 1455 B comp / 2816 decomp). Loaders now read
`ld hl, Lz_1e_4c70` / `ld hl, ResultsScreenPalettes`, and palette sets render inline
as BGR555 colors. Also recovered the stranded handler code (bank-swap/VRAM
copiers, a farcall stub) and structured three jump tables
(`RewardSubHandlers{A,B,C}_1e`). Remaining blobs are small coordinate/OAM/
lookup tables. See [[stranded-code-carving]].

**Bank $1d (stroke-practice drill engine) — partial, careful carve.**
Recovered the clean stranded code (bank-swap routine `$4e5e` — its `$4e76`
data table correctly left as data — and the `$7cd9` `jp hl` jump table's 5
handler targets incl. `$7d0f`, structured as `DrillSubHandlers_1d`) and named
the drill's display-data tables: `DrillDisplayData_1d` (`$5c25`, 3079 B,
loaded from 7 sites, WRAM-offset records copied to `$d000`+ via
`Func_1d_4bb6`) and `DrillDisplayData2_1d` (`$77c8`). **`$57d2` (453 B) was
deliberately left as a blob**: it interleaves sprite-drawing code with inline
OAM/sprite-template data (`ld de,$591c/$5944`) with no `ret` before the data,
so static seeding decodes straight through the templates and misframes them
(a data pointer lands mid-instruction) — this needs runtime coverage to
separate, not a static seed. The remaining blobs are genuine drill data
(display records, tile-id/curve lookup tables). Net code % barely moved
because the big code region was correctly declined; see
[[stranded-code-carving]].

**Bank $38 (interactive story-screen bank) de-blobbed** (46 blobs → 37;
70.7% → 79.0% code). Its stranded "data" was menu/cursor handler code
(reading `$cb04/$cb05/$cb0e` + input `$ffd4/$ffd5`, kin to bank $3b's
pause-menu builders) reached only through computed dispatch, now seeded
(`coverage/bank038_static_code.json`, function starts + internal call/jump
targets — *not* blind per-byte entries, so trailing data tables like the
`$45ff` parameter table are left as data). Five **6-entry `dw` jump tables +
their inline handler runs** were structured and named
(`SubHandlers_38_{56c9,59ba,5c8f,5feb,69c1}`, loaded via `ld hl,SubHandlers…`
from multiple sites) and their handler targets seeded. `EnterNameText_38`
(`$7171`, "Enter Name") named. The 37 remaining blobs are genuine data: menu
cursor coordinate grids (x,y pairs), OAM/position record tables, tile-id
lists, and self-referential pointer-table+record structures (e.g. `$4695`).
Caution learned here: seeding *every* per-byte "entry" a linear decoder emits
can decode a code-adjacent data table as instructions (it briefly mislabeled
`$45ff` as `jr` code); seed function starts + internal flow targets instead.

**Bank $05 (text control-code engine) largely de-blobbed** (42 blobs → 12;
69.9% → 85.4% code). Most "data" blobs were stranded handler code reached
only through the engine's control-code jump tables (read via `jp hl` through
pointers, invisible to static descent), now seeded
(`coverage/bank005_static_code.json`, ~105 entries): bank-swap copiers,
input-wait loops, array initializers, and the per-source **text-fetch handler
stubs** (5-byte `farcall $bb:02` + `jr`, one per text bank
`$31-$37/$6e/$1f/$25/$26/$5e`). Four dispatch tables were structured inline as
`dw` and named: `ControlCodeHandlers_05` (`$548f`, 32 entries, the main
control-code table loaded by `ld hl,$548f`; its 5 leading `$c9` bytes are
no-op `ret` handlers), `DialogueTextFetchers_05`/`ShortTextFetchers_05`
(`$5c3b`/`$5cc7`, 16 each), and `TextSubcmdHandlers_05` (`$66de`). Two data
tables named: `PowersOfTen_05` (`$53a2`, 1/10/100/1000/10000 for decimal
formatting) and `HexDigitChars_05` (`$6488`, "0123456789ABCDEF"). The 12
remaining blobs are genuine data: font/glyph tiles (`$7942` 1694 B, `$6886`),
a glyph-width table (`$60cb`, id/width pairs), small parameter/word tables,
and text strings (e.g. `$67b7` "- ENTER NO -").

**Bank $07's stranded code was recovered** (14 blobs → 8 genuine data tables;
36.5% → 40.3% code). Its "data" blobs held ~600 bytes of code reached only
through computed dispatch, now seeded (`coverage/bank007_static_code.json`):
a link-cable serial-exchange stub (`$45f8`, drives `[$ff01]`/`[$ff02]`), a
match-id clamp (`$4cb1`), a sprite-field table blitter (`$5d1e`), a
delay/serial stub (`$41b1`), a ball-height guard (`$59ec`), and a
**self-contained target-zone mode implementation at `$5ea1`**: the setup
routine puts 2 chars on court, sets `wTargetZoneEnabled`, and installs a
mode-hook table (`ModeHookTable_07` at `$5efc`, via `SetModeHookTable`) plus
its FarPtr_08_4a data at `$5ff6`; the seven hook callbacks/stubs
(`$5ed2/$5ed3/$5f0d/$5f24/$5f25/$5f49/$5f4d/$5f75/$5f8e`) interleave with those
tables and were seeded around them. The 8 remaining blobs are genuine data:
`$4d21` (1088 B, indexed `$4d21 + [$ffdd]*4` by `Func_07_4cfe`),
`CharSpriteSetTable` (`$5a50`, already named), the `$5f94` mode data, and
five small lookup tables.

**Banks $20/$21/$22/$23 are four more ball-position banks** in the same
family as $2a/$2b — each dispatched from the same bank-7 shot-placement
selector (`FarPtr_20/21/22/23_00` at $58fd/$5916/…, alongside `_2a`/`_2b`),
so the selector picks one of six placement tables per shot/mode. Each is a
15360-byte position table (`BallPosData_2{0-3}` at `$427d`) addressed as
`base + heightOffset[ballHeightBand] + blockOffset[$df6f]` then a 6-byte
record. The two offset tables (byte-identical across all four banks, and to
each other's structure) are carved inline: `BallPosHeightOffsets` ($7e98, 32
words; ball height `& $1f` quantizes to 4 bands `{0, $0f00, $1e00, $2d00}`,
each = 3840 bytes) and `BallPosBlockOffsets` ($7ed8, 10 words, step $180 =
384 bytes/block). So 15360 = 4 bands × 10 blocks × 384 = 4×10×64 six-byte
records. Everything else ($4012-$424b) is stranded per-axis
coordinate-projection helper code (variants of `Func_2*_4102`: `MulSinCos`
placement, stride-4/stride-6 table search, record scale), reached only
through computed dispatch — seeded as static code
(`coverage/bank02{0,1,2,3}_static_code.json`, byte-identical helpers). Each
bank went from 5 helper-code blobs + 2 anonymous offset tables down to just
the named `BallPosData` INCBIN (94% of the bank). $2a/$2b differ only in
using a third (sub) offset dimension and a 7200-byte table.

**Bank $27** is a self-contained story presentation/cutscene: a script that
stages VRAM graphics/tilemap loads through bank $0a's DMA queue
(`FarPtr_0a_22`/`_24`, dest tile-pages `$3180`/`$3500`/`$3b00`/`$3f00`), plays
`sound $96`/`$79`, frame-delays via `Func_27_7856`, and branches on story flag
`$05.7` between two variants (the second, `$4ff0`-`$516a`, was stranded code
now seeded in `coverage/bank027_static_code.json`). Its opening `$4000` is a
12-entry `dw` pointer table (`SceneFramePtrs_27`) into 12 frame records, each
with a 6-pointer header, split across `SceneFrameData_27` (`$4018`) and
`SceneFrameDataHi_27` (`$51d0`) with the script code between; `SceneSharedData_27`
(`$785d`) is referenced by every record's tail. The exact record field layout
and which cutscene it is (flag `$05.7`-gated) are not yet pinned down.

**Bank $28** is a story-match/minigame graphics loader: a proper 9-slot
farcall table (`FarPtr_28_00`..`_10`, called from the match engine $08 and
story $06/$0d) of functions that load tiles + palettes into VRAM for the
current match (dispatched off `wCurrentMinigameStoryMatch`, `$c8f5`/`$c8f7`).
Each function decompresses an LZ tile stream (`MatchGfxTilesA_28`/`B` at
`$45e0`/`$6180`) and applies palette sets via `LoadPaletteShadow`. Three
palette blocks are carved to inline `palettes` source
(`MatchGfxPalettes{A,B,C}_28` = 10/16/9 palettes); the LZ tiles and raw
tilemap copies stay gitignored graphics blobs. The two unproven farcall slots
(`$0e`/`$10` -> `$60a0`/`$6086`, small SRAM-record copiers interleaved with
their index tables) were seeded as code.

**Bank $6b (intro cutscene / title / award-ceremony driver)** carved: 40 -> 28
blobs, 28.6% -> 30.7% code. The bank is a state machine — `$cb3f` indexes an
18-word state->record pointer table at `$40bd` into 20 x 6-byte
`{init,update,exit}` handler records, and the records' handlers sat inside data
blobs (the two-level indirection is invisible to descent). 13 static seeds
(`coverage/bank06b_static_code.json`, function starts + internal flow targets)
recovered them: state 17's live exit/init/update tail (`$415c`/`$4166`/`$416e`,
which folded the `$40bd` blob down to a clean 156-byte table) and three
farcall/computed-reached helpers (`$51a5` button-wait loop, `$545e`
decompress-setup sibling of `Func_6b_53fc`, `$7691` teardown). Decoding the
full table exposed dead content: **records 11 and 12 are targeted by no state**
(their `$4885`/`$48f2` handler trio is a complete but unwired intro segment that
decompresses + scrolls character/logo tiles), and two orphaned handler snippets
(`$4159`/`$415f`) flank the live `$415c`. These decode as clean, function-calling
handlers (not data), so they are disassembled and marked `Unused_6b_*` rather
than hidden in blobs. Seven palette blobs
(`$42b2/475a/4c00/525a/60c5/756f/794f`) render inline via the `palettes` spec
and are named `Palettes_6b_*`, so their `LoadPaletteShadow` call sites read
symbolically. The remaining blobs are genuine data — LZ tile/tilemap streams,
metasprite templates, and frame-indexed animation curves.

**Bank $02 (story-mode character/roster/equipment manager) has zero data
blobs — 19.8% -> 48.4% committed source.** It owns the player character record
(`wStoryModeNameOfMainCharacter`, `$c800`), a 100-entry roster DB, equipment,
and save flags, exporting ~34 functions via `FarPtr_02`. All 18 blobs were
classified and structured (`data_tables.json`): `StoryCharacterRecords_02`
(`$52cf`, 100 x 29-byte records; stride proven by `Func_02_41ee` + the
`ld c,$1d` copy) followed by `CharGroupTable_02` (`$5e23`, 9 x 16-byte group
rows, searched by `Func_02_5eb3`/`5ee2`); `EquipRecordPtrs_02`/`EquipRecords_02`
(`$47f2` 4-ptr table -> 4 x 113-byte records); two `SaveFlagPtrs_02` word
tables (feeding Clear/Set/TestSaveFlag); `CharIconMasks_02`, `NameTextRemap_02`,
`MenuTilemaps_02` (null-terminated tile strings via `Func_00_1906`), and the
`Value100000_02` 24-bit cap constant. Four stranded-but-valid helpers unreferenced
anywhere (`coverage/bank002_static_code.json`) were carved as code and, like
bank $6b's dead handlers, labeled `Unused_02_*`: `SignExtendL`, `ListForEach`
(indexes a 64-byte table, left as data), `StorySlotVariant` (near-dup of
`Func_02_5247`), and `CharGroupFind`.

**Bank $01 (hidden debug/developer test menu)** partially carved, 6.3% ->
8.6% code, 10 -> 6 blobs. `Func_01_4018` is a button dispatcher into test modes
(match test -> `FarPtr_16_00`, intro/title test -> `FarPtr_6b`, story-location
tests) plus a sound test (`Func_01_6a5b`: adjust two hex indices on the d-pad
and play sounds). Converted to committed source: `DebugMenuPalettes_01`
(`$50f6`, 16 palettes, selected by `Func_01_519a`) and the sound-test tables
(`SoundTestStrings_01` tilemap labels + `SoundTestSoundsA_01`/`B` sound-id
tables read at `$6b3c`/`$6b52`). Three unreferenced handler fragments carved as
code, labeled `Unused_01_*` (`coverage/bank001_static_code.json`): `MenuRedraw`,
`MatchSetup`, `$41d6`. The remaining 6 blobs are tile/LZ graphics that stay
gitignored (no ROM bytes) but are now named: `MenuTilesA_01`/`MenuTilesB_01`,
the two LZ streams `MenuGfxLZ_01`/`MenuGfxLZ2_01` (split out of one blob, refs
now symbolic), and `UnusedTiles_01_51ab`/`_53b0` (~3.4 KB of graphics
referenced by nothing).

**Status/records viewer (banks $1a/$1b/$1c) identified via live driving.**
Driving the game to Status → file → Character Data (the two-panel per-character
stat screen, Alex/Harry) under an MCP execution trace pinned the subsystem:
bank $1b is the menu shell/state machine, bank $1a holds the per-screen
renderers (reached through the `FarPtr_1a` dispatch table), bank $1c the draw
helpers. The Character-Data screen's handlers are named from observed coverage:
`CharDataScreen_LoadGfx`/`_LoadScreen` (decompress tiles+sprites into VRAM),
`CharDataScreen_BuildStats`/`_DrawStats` (compute base+modifier per stat, format
digits, write gauge bars into the parallel bank-3 tile / bank-2 attribute
buffers), and the shared `CopyWram1ToWram2`/`CopyWram1ToWram3` block copiers.

The bank-0 **number-formatting subsystem** was named as signed/unsigned pairs:
`FormatDecimalNumber` (signed, pre-existing) + `FormatDecimalNumberUnsigned`
(`$1a27`) are near-duplicate value→padded-ASCII formatters differing only in
sign handling, each with its own inlined digit extractor
(`ExtractDecimalDigit`/`ExtractDecimalDigitUnsigned`, whose loop bodies now use
`.loop` locals). Five draw-to-tilemap wrappers sit on top (`PrintHexByte`,
`PrintHexWord`, `PrintDecimalByte`, `PrintDecimalWord`, and dead-code
`Unused_00_PrintDecimalByteSigned`), all sharing a tail that renders the
formatted string via `Func_00_1906`. `tools/disasm.py`'s labels.json validator
now accepts `.local` labels alongside PascalCase (the internal-label convention).

Bank $08's core match-loop API is now named: `StepMatchFrame` (`$4465`,
vblank-sync + one update step, 40 call sites) and its multi-frame wrapper
`StepMatchFrames` (`$4428`, early-exits on the `$c492` point-over flag), plus
the input readers `ReadMatchInputPressed` (`$4415`, `$ff94` edge-pressed) and
`ReadMatchInputRepeat` (`$441d`, `hInputPressed` autorepeat) — both fall back to
`$ffd3` in link mode. Names propagate through the `FarPtr_08` slots to all
call sites automatically.

**Broad function-naming pass (subagent-driven, +343 names).** A sweep across
the code banks named ~343 functions whose purpose is unambiguous from the code,
leaving deep physics/AI/scene-scripting and screen-specific builders (which need
runtime/visual identification) unnamed. Highlights:
- **Match engine ($08):** the full scoring/flow state machine — RunMatch ->
  RunMatchPlayLoop -> PlaySet -> PlayPoint; tennis win-by-2 scoring (Award/Check
  Point/Game/Set/Match, EvalWinByTwo, deuce/advantage); the 9 match-statistic
  recorders; ball physics head (StepBallPhysics, HandleBallNetCrossing); court
  camera; and the per-character state machine (UpdateCharStateMachine,
  Step/SetCharAnimation, CheckCharBallContact, ReadCharInput).
- **Story/roster ($02, $04, $06, $0d):** the overworld actor engine (spawn/
  script-VM/animation/camera in $04), the parallel match/story menu system ($06),
  the roster/EXP/stat manager ($02 — record getters, RecomputeCharacterStats, the
  EXP arithmetic family, per-slot save flags), and the minigame engine ($0d —
  scoring, actors, ball, countdown, score popups).
- **Screens:** match win/lose + statistics ($16), EXP-gain/Status char-data
  ($1a — ShowExpGainScreen, confirming Func_00_086c builds its two-panel
  row-doubled tilemap), reward/results ($1e), rules ($17), name-entry + match-type
  menus ($38), and the drill result/level-up screens ($1d).
- **Core/engine ($00, $03, $05, $09, $0a):** bank-0 utilities (sign-extend,
  mul/div, AdvanceRandomSeed, the frame-task registry, game timer, frame sync,
  window-frame drawing, the Format/Print number family), the save engine's
  block read/clear/restore helpers ($03), the text control-code interpreter
  ($05 — RenderTextString, DispatchControlCode, glyph-width measurement), VRAM
  gfx/object loaders ($09), and the scene tilemap scroll/blit system ($0a).
All applied via `labels.json` and verified byte-perfect each wave. Names were
gated on concrete in-code evidence and spot-checked against the source.

**Bank $00 deep-naming pass (2026-07-17, +116 names + 42 RAM labels).** A full
read-through of the home bank named every remaining identifiable Func_00_*:
the far-call/vector plumbing (CallHLInBankA, CallVectorEntryA/E, FarCallVector,
FarReadByte/Word, FarCopyBytes), the VBlank transfer system (QueueVRAMCopy,
QueueBGTileWrite, ProcessVRAMCopyQueues, the BG row/column blit queues and
their 64x64 map-buffer variants), the palette system (live $c100 / master
$c200 buffers, LoadPalettes*, fade state machine BeginFadeOut/In,
UpdateFadeIn/Out, ApplyWhiteFade, per-component color adjust), the math
library (MulHLByDE/32, MulHLByAFrac*, DivAHL*, sin/cos multiply family,
AngleFromVector16/Coarse, GetTangent), the leftover debug console
(wDebugTextBuffer at $cc00 -> $9d00, PrintString/PrintHex*, frame-time meter,
frame-step via hDebugStepMode), sprite queueing (QueueSprite24x32/32x32,
double-buffered OAM via wSpriteBufferPage), the serial-link input exchange
(SerialHandler, SerialEncode/DecodeInput, WaitSerialTransfer), music control
(PlaySoundCmd/PlaySoundManaged, jingle override via hActiveJingle), and the
sound-engine internals (RunSoundChannelScript command interpreter, vibrato/
volume-slide/echo ticks, wave-pattern loading). 42 matching HRAM/WRAM names
landed in ram_map.json (hFadeState, hVRAMQueueDirty, wCameraX/Y, wGameTimer,
hRandomSeed, hIsCGB, ...). Bank $00 is now 245/901 human-named; what remains
is mostly interior branch labels.

**Cross-bank naming pass round 2 (2026-07-17, +256 names).** Continued with a
mix of direct reading and per-bank subagent proposals (each verified against
the source before applying):
- **Bank $05 is now fully mapped as the text/window engine** (+141): the
  window-struct allocator ($dc00, 7 x 8-byte slots, mask $dc70), shadow
  tilemap under-window save/restore, the dirty-row flush pipeline
  (MarkWindowRowsDirty -> BuildDirtyRowRuns -> CopyDirtyRowSpanToVRAM), menu
  selection loops (RunMenuSelection, paged variants), the text-argument
  substitution lists (PushTextArgString/Number/ShortTextId + measurement),
  speaker dialogue/speech-bubble display, the dynamic glyph-tile streaming
  system (WRAM7 $d300 buffer -> $8800), SRAM text fetch, and a large leftover
  debug suite (flag editor, palette editor, warp menu, window demo).
- **Bank $07 identified and named** (+76): the link-play protocol engine
  (master/slave handshakes, per-frame input exchange with duplicate
  detection, nibble-block bulk transfer with checksums, command encode/
  decode) and the shot-execution engine (ExecuteShot, per-shot-type speed
  composition, ComputeShotTrajectory, recoil, smash-range check, aim
  jitter), plus RunDebugTestMatch.
- **Bank $0a story-script layer** (+27): script commands over the WRAM4
  actor records (position/move-target/polar movement, facing, screen shake,
  player teleport with fade, dialogue-sequence wrappers).
- **Bank $18 helpers** (+7): grid-cursor movement, unlock-flag test,
  bobbing cursor offsets, two-option prompt.
Named symbol count grew from 1,338 to 1,725. A follow-up mini-pass used the
text-id decode trick (see auto-memory text-id-decoding: text id hl -> bank
(h>>2)&$f + $30, index (h&3)*256+l, read with tools/strings.py --index) to
identify menus by their strings: bank $1b's character-select/mugshot cluster,
RunNewGameSetup, the Level Up/Status/Trophies menu, a leftover debug
"Saved Data/Mini-Game Flags" menu, and bank $10's singles/doubles/drill
match-list and minigame-select menus. Two offset-arithmetic mishaps
(labels landing in the wrong bank) were caught by blob-count changes and a
name clash; the fix and the safe recipe are recorded in the auto-memory
(naming-pass-workflow).

**Cross-bank naming pass round 3 (2026-07-17, +216 names).** Subagent proposals
(one per bank, evidence-gated, spot-checked) over the story-scene banks, driven
by text-id decoding. Named symbols: 1,735 -> 1,951. What each bank turned out
to be:
- **Bank $0e = training gym + Mario World.** The Repair Counter equipment-change
  flow (service menu, racket/shoe select via FarPtr_3e_0c/0e, handout/confirm
  dialogue, the $c295 return-path handlers) and the post-game Mario World
  exhibition-match story (arrival cutscenes singles/doubles, Peach's exhibition
  prompt with Hard/Intense/MAX select, decline tantrum, the 6
  LoadExhibitionMatchSettings stubs and HandleExhibitionMatchResult).
- **Bank $0f = Island Open tournament site.** Three map-script trees:
  Tournament (loc $19), Awards Ceremony (loc $1a), and the leftover dev map
  "Small Char. Test" (loc $02). Round computation from story
  flags, per-round NPC loads, round-call/break/arrival cutscenes, podium
  announcement, and the victory transition to the plane cutscene (location $1b).
- **Bank $11 = Academy arrival + junior-class ranking courts.** The game-opening
  greeting/tour scenes and late-student crash cutscene, plus the singles and
  doubles ranking-match offer/opponent flows (the doubles twins of the
  already-named StartNextRankingMatch/LoadRankingOpponentGraphics fork on story
  flag $05.7).
- **Bank $12 = Wall Practice Room + senior-class court.** Wall practice level
  signs/launch/result/record scripts (9999-hit counter cap, Master Level), and
  the senior ranking ladder: stage computation ($c2b1 from the story-flag
  cascade), offer/confirm scenes, practicing NPC pairs, victory dispatch.
- **Bank $14 = Tennis Machine Room + Island Open courts + water sprite.** All
  four machine-level result/practice/retry scripts, the Expert System record
  flow, Court #1/#2 gallery scenes, and the fountain water-sprite loaders.
- **Bank $15 = training courts + tournament site trees.** The three coaches
  (serve $07, net $12: volley/smash/drop shot, return $0d: return/lob/passing
  shot) with their lesson scenes/retry prompts/walk-to-court starters, the
  three challenger NPCs (serve/net/stroke match chains), and the pond
  side-story (swing-practice kid, water-sprite 10-second swing contest,
  Gold/Silver Racket reward).
- **Bank $0b = training-drill engine** (direct + agent): RunTrainingDrillByID
  ($47b4 14-byte drill-definition directory, ids >= $12 route to minigames),
  the drill result-message system ($45c4 text-id table, queue/show helpers),
  target-zone record/check helpers, and the per-drill judge/evaluate/point-end
  trios for drills 9 (serve-and-volley), 15 and 17.
- **Bank $39/$18 screen helpers** (direct): CopyTilemapRect/FillTilemapRect
  (the rect blitters behind 38 bank-$16 stats-screen farcall sites),
  LoadIndexedPalette (+ bank $18 twin), QueueWram3MapToVRAM, and RAM
  wBgMapShadowDirty ($cb61).
- Fixes: text-id fetcher mapping corrected (fetchers 8-12 = banks
  $6e/$1f/$25/$26/$5e, not $38+); disasm.py now dedupes consecutive identical
  label lines (a curated name on an offset with both a data-mark and a segment
  label emitted twice and broke assembly).
- **Bank $16 = win/lose + match-stats screens** (+17): the result-portrait
  pipeline (DecompressCharacterPortrait 32-entry table, win/lose face
  variants, palette-to-BG-slot-4-7 attr fills), per-match graphics loads
  indexed by wCurrentMinigameStoryMatch, banner sprite wobble helpers, and
  MaybeInvertMatchWinLoseFlag (link-mode side swap). The story EXP screens
  turned out to live elsewhere; $16's remainder is compressed graphics.
- **Bank $13 cutscene layer** (+15): academy courts tour (with the bobbing
  pointer-sprite frame task), Service Ace restaurant coach intro, door
  open/close animation pair, the daily "play doubles today?" prompt (sets
  wMatchIsDoubles + story flag $05,7), the academy questions menu, narrator
  scenes, the singles/doubles traveling-team victory cutscenes, and
  ComputeStoryRankTier_13. Noted: wWaterSpriteMinigameFlag is reused as
  generic scratch by $13's actor position save/restore — the RA-sourced name
  is mis-scoped.

Named symbols after the $13/$16 follow-up: 1,983.

### Naming pass round 4 (2026-07-17, later)

- **Bank $05 text engine fully decoded**: TextInterpreterLoop + all 20
  control-code handlers named (TextCmd*: newline, wait-button page break,
  arg-string/arg-number/short-text printers via the PushTextArg* queues,
  player/partner name inserts, dakuten/handakuten combining marks, three
  delay variants, nops) plus the continue-arrow blink task. Eleven WRAM5
  text-engine variables named in ram_map.json (wTextArgStringQueue,
  wTextStreamPtr, wGlyphVramDest, wTextPageBreakRequest, ...). Caution
  learned: $d82a/$d82b are the text cursor only under WRAM bank 5 — bank
  $17 uses the same addresses in WRAM bank 3 as target-box dims, so they
  stay unnamed.
- **Generator**: `records:2` data tables now emit `dw <label>` when a word
  resolves to a labeled same-bank offset — dispatch tables (e.g.
  ControlCodeHandlers_05) self-document as handlers get named.
- **Bank $06** (agent): match pause menu tree (rules pages per game mode,
  controls review, camera/music options, per-mode quit menus), scoreboard
  system (pips, captions, per-mode gfx), story pause tree (message speed,
  save/quit), shadow-tilemap addressing helpers, and RunDebugStatsEditor
  (FarPtr_06_02): a leftover hex editor for the $df00 player struct with
  ASCII field labels SPEED/ADD/BRAKE/TURN/ANGLE/PLACE/STROKE/SERVE/VOLLEY.
- **Bank $1b** (agent): academy ranking-board screens (singles/doubles
  12-name ladders, highlight + marker-coord tables, rank-change jingles),
  char-select roster/nav-grid/mugshot machinery, minigame level picker
  (2/3-panel variants gated on save flags), saved-data viewer (Exhibition
  vs Mini-Game Data, scrolling clear/star/high-score list), and another
  debug tree: char-unlock-flag toggle grid (writes save block $0b),
  'No N64 data was found.' screen, Trophies placeholder.
- **Bank $17** (agent): the nine training-drill briefing screens
  (DrillBriefing_*: serve-to-targets, spin serve, poles, serve+volley,
  two serve+smash, three return drills) — each an animated court-diagram
  with per-phase sprite-position record tables and 36:688+/37:3+ captions;
  the diagram sprite task suite (figures, ball, swing anim, poles, spot
  marker, target brackets, palette cycler); minigame rules pages; rules
  border animation. Twin cursor-grid helpers suffixed _17 (twins of the
  bank $1b set).
- **ROM0**: MulNegHLByA/MulPosHLByA (signed-multiply core), soft-reset
  combo checks, DrawHalvedWordDecimal, QueueTileCopyAdvance, sound-engine
  channel-update request trio + ApplyChannelVolumeEnvelope.
- **Bank $02**: GetCharPaletteIndex (+CharPaletteIndexTable feeding
  LoadIndexedPalette), RemapExtendedCharId, ValidateN64TransferRecord
  (checksummed $c9b0 transfer-pak record), stubbed EXP-gate helpers.
- **Banks $1c/$1d/$1e** (direct): ShowCharDataScreen + values-sync task +
  Backup/RestoreCharData pairs; ShowMatchResultsScreen, ProcessMatchRewards
  (per-mode reward/unlock recording), ShowGameProgressScreen tree;
  GrayscalePaletteColorInPlace/ConvertColorToGrayscale — note the original
  game bug: the blue component is stored to ROM $0002 (no-op), so the
  grayscale ignores fresh blue.

Named symbols after round 4: 2,294 (labels.json 2,209 + ram_map 225).

### Naming pass round 5 (2026-07-17, agent fleet restart)

- **Bank $0a fully mapped (agent): the story-overworld engine.**
  RunStoryModeOverworld/RunStoryLocation (6-byte location records at $564f,
  $0e-byte pointer headers at $c286, event-request polling $c2a0-$c2a5),
  FindStoryScriptEntry (8-byte trigger/exit/NPC records with facing masks +
  flag conditions), Begin/EndCutsceneScriptMode, the WRAM6 collision ($d000)
  and behavior ($d400) map accessors, scene tile animations + debug scene
  viewer, the 15-slot minigame moving-target pool with its own movement
  bytecode interpreter (RunMinigameTargetScript), story-match glue
  (AssignStoryMatchCharacters), and RunEndingCreditsSequence (End1-End17
  location tour with FreezeAllActors).
- **Bank $3b (agent): main menu + records front-end.** RunMainMenu (3x3 grid
  with save-slot mugshot cells), RunMatchFormatSelect, RunMinigameSelect
  (6/9-slot portrait grids), the saved-data source/erase pickers, the N64
  Transfer Pak record screens (Tnmt/Exhib/Ring Shot charts decoded from save
  block $0b), ShowTournamentBracket, RunStarCharExhibResults, and
  **a hidden cheat**: on the Trophies screen the game counts Right presses
  ($d900) and Left presses ($d901); exactly 12 Rights + 34 Lefts then
  A+Select runs ApplyUnlockEverythingCheat (sets all star-char/court/misc
  save flags for all three slots) and saves.
- **Bank $3e (agent): secondary menus.** Link match-rules/status/error
  screens, erase-data confirmations, the story equipment suite (racket/shoes
  choice + select + status screens with stat-mod readouts, owned lists from
  game flags, wEquippedRacket nibble equip), and the 4-court/9-court select
  grids (local + link variants, unlock gating via save flags into $cb54,
  per-court BGM through $c8f8).
- **Direct**: bank $04 actor helpers (IsTileBlockedAt, WaitActorsIdleTimeout,
  LoadOverworldSpriteDef), bank $0d GetDefaultMinigameRecordValue (+ save
  blocks $38+slot), bank $39 shared screen hub (LoadCompressedTileBlock —
  the 152-site tile-block loader — menu bg scroll, staged map flush, digit
  sprites), bank $18 char-select cursor/roster helpers.

Named symbols after round 5: 2,736 (labels.json 2,652 + ram_map 225 - overlap).

- **Bank $08 (agent): the match engine decoded.** Ball physics
  (SetBallVelocityPolar, ApplyBallAirDrag — drag proportional to speed,
  ApplyBallSpin — Magnus curve with 3/256-per-frame spin decay,
  ApplyCourtBounceDamping from per-court factors, BounceBallOffCourtFences,
  the 24/32-bit fixed-point integrator suite AddVel24ToPos32 etc.), the
  character state machine (serve toss/swing-window/strike phases, rally
  ready/windup/contact, changeover walks, point-end reactions), input
  handling (the two-press topspin/slice buffer $df16/$df17 with 5-frame
  window, charge flash after 20 held frames), movement (per-stat
  accelerate/brake/clamp per axis from the $df60+ stat block), and the
  complete CPU AI: singles and doubles state machines with strategy-driven
  positioning (baseliner vs net-rusher home spots), ball-intercept
  prediction (PredictBallXAtDepth = X + tan(heading) x depth-delta), skill-
  gated serve timing, shot-button personality tables via char groups, aim-
  away-from-opponent logic, and doubles poaching (AiNetPlayerPoachCheck).

Named symbols after round 5 complete: 2,898.

Next annotation targets: bank $08's remaining ~120 physics/AI routines (velocity
integrators, the CPU-AI behaviour state machine — need runtime traces), bank
$3b's screen-specific pause-menu builders, bank $0a story-overworld engine,
bank $03's remaining save farcall slots (FarPtr_03_18/24/26/2a/2c/...), bank
$1a EXP-screen internals, bank $13/$15's scene-scripting beats, sound-command
enum for the 451 `sound $xx` sites, WRAM map expansion from ram_map gaps.

## The 13 `Gfx_*` blobs (2026-07-26)

The last auto-named symbols carrying a `Gfx_` prefix were 13 blobs the
generator had labelled as graphics on position alone. Only three of them
actually were graphics; the prefix was wrong on the other ten.

**Eight were undisassembled code.** The shot banks `$20`-`$2c` hold five
near-identical trajectory routines each, at `$4102`/`$4135`/`$415d`/`$4196`/
`$41c9` (plus a small per-bank shift). Banks `$20`-`$23`, `$2a` and `$2b` have
all five proven by trace coverage; `$24`, `$29` and `$2c` do not, and their
unexecuted copies sat as blobs. Grepping the ROM for the shared opening
`af 91 4f 9f 90 47 fa 8a c4 5f` (`xor a / sub c / ld c,a / sbc a / sub b /
ld b,a / ld a,[wShotDistMin] / ld e,a`) locates every copy in every bank and
turns "is this code?" into "does the twin bank disassemble it?". Static seeds
in `coverage/bank02{4,9,c}_static_code.json` decode all of them:

| bank | seeded | name |
| --- | --- | --- |
| `$24` | `$410e`, `$4141` | `ApplyBallTrajectory6Capped_24`, `ApplyBallTrajectory6_24` |
| `$29` | `$4135`, `$415d`, `$4196`, `$41c9` | `ApplyBallTrajectory6_29`, `ApplyBallTrajectoryCapped_29`, `ApplyBallTrajectory4Capped_29`, `ApplyBallTrajectory4_29` |
| `$2c` | `$4106`, `$419a` | `ApplyBallTrajectory6Capped_2c`, `ApplyBallTrajectory4Capped_2c` |

The naming now separates the two axes the five routines vary on: entry stride
(`...6` = the 6-byte `BallTrajEntryPtr6` table, `...4` = the 4-byte one) and
whether the carry from the table walk falls back to
`ApplyFallbackBallTrajectory_24` (`...Capped`).

Two more were code outside the shot banks:

* `$18:$5527` `DrawThreeOptionLabels` -- the three-option sibling of
  `DrawYesNoLabels`, six 11-byte tile labels into `$d9c1`/`$d9e1`/`$da01` and
  `$ddc1`/`$dde1`/`$de01` after `DrawConfirmScreenBox`. Only the 32 bytes
  before it (`$5507`, a `ff fe fd fc fd fe ff` ramp + zero padding) are data,
  now `Unused_18_5507`.
* `$27:$7a49` `SetStoryRankSceneIndex` and `$27:$7a90` `SetStoryRankTier` --
  two `rst Rst30` (`TestGameFlagCmd`) ladders that walk the story-completion
  flags and store a progress index in `$c2b0` (0-9 with singles even /
  doubles odd; 0-4 as a plain tier). `rst $30` takes a two-byte inline
  argument, which is why the region decoded as noise until seeded.

**Two were mis-split by bad trace seeds**, both single misattributed coverage
points sitting inside proven data (added to `Core.BAD_SEEDS`):

* `$1c:$6182` sits 1,974 bytes into the LZ stream at `$59cc`, which
  `tools/lz.py` proves runs 2,618 bytes to `$6406` -- exactly where the next
  referenced stream starts. `CharDataScreenGfx0_1c` is now one 2,618-byte
  blob instead of three pieces with a 7-byte "function" wedged in.
* `$1c:$6f11` decoded forwards to a `jr nz` that jumped *backwards*, so
  descent fabricated a 64-byte routine out of raw tile bytes at `$6eea`.

A third of the same kind turned up while checking the result: `$24:$4cab`,
1,803 bytes into `BallPosDataDrop_24`, decoding as `call z, $a0f1` on repeat.
Removing it merges that table back into one 3,072-byte (512 x 6-byte) run.
The lesson generalises -- a lone trace seed with no caller, landing mid-blob
and decoding as nonsense, is a bank-misattributed trace line, not code.

**One was actor bytecode.** `$27:$6b94` is four `actor_script` blobs
(20/26/20/26 bytes) that the carver had not been told about; they now decode
as ordinary `as_*` walk-and-face scripts alongside `ActorScript_27_24`.

**Three were genuinely graphics or data**, renamed off the misleading prefix:

| offset | name | what it is |
| --- | --- | --- |
| `$17:$4f02` | `CourtDiagramGfxStreams` | 20 back-to-back LZ streams filling all 1,637 bytes, exactly the 20 source pointers in `CourtDiagramGraphicsList` that `DecompressGraphicsList` walks into VRAM `$8000`+ |
| `$1c:$6f2a` | `CharDataScreenTiles_1c` | raw 2bpp tiles (they render as legible glyphs) between the char-data screen's compressed streams |
| `$1c:$4fe9` | `RadialOffsetRamps_1c` | a 4-entry pointer table into four 22-byte ramps of `(+-8, +-8)` steps -- one diagonal each, consumed by the `add a,d / ld d,a / ld a,[hl] / add a,e` helper just above it |

Two resisted identification and keep neutral auto-style names rather than a
wrong one: `Data_14_56ea` (870 bytes of sparse binary before
`IslandObjTiles_14`; not a whole number of tiles, renders as nothing legible)
and `Data_18_59fe` (a 4-entry pointer table into four 17-byte records, shape
clear, role not). `$38:$4695` is named `MatchTypeLabelSpriteLayouts` from its
neighbours -- four `db y, x, tile, attr` strips terminated by `$80`, sitting
directly before `DrawMatchTypeOptionLabel` -- which fits the bytes but has no
call site to confirm it.

Net: zero `Gfx_*`, zero `Label_*`, zero `Func_*` and zero locals scoped under
a data symbol anywhere in the ROM; 17,146 of 20,761 labels human-named.


## ROM-wide sweep for uncarved code and mis-split data (2026-07-26)

Five detectors run over all 4,400-odd blobs. Scripts live only in the session
scratch, but each is a dozen lines and the recipe is the point.

**1. Byte-identical twin scan.** Index every proven instruction start; for each
blob, look for a 16-byte window that also occurs at one of those offsets.
Found bank `$16`'s entire shared menu-cursor helper block, `$40cd`-`$4470`,
which banks `$17`, `$1b`, `$38`, `$3b`, `$3e` all execute and `$16` never did:
`DrawCornerBrackets_16`, `MoveMenuCursorGrid_16`,
`MoveMenuCursorGridFromLinkInput_16`, `MoveMenuCursorGridRemote_16`,
`MoveMenuCursor2GridRemote_16`, `GetMenuCursorIndex_16`,
`GetCellIndexFromCursorPtr_16`, `SetMenuCursorFromIndex_16`,
`SetMenuCursorFromIndexToPtr_16`, `ClearWram3Row64_16`,
`ClearWram3Row64Alt_16`. Also `$3e:$40ff` `DrawCornerBrackets_3e`, 59 bytes of
code that had been swallowed by `SelectionBoxWobbleYTable_3e`'s extent.

**The trap in that block is worth recording.** The blob boundaries the
generator had produced were *16 bytes later* than the real function starts,
and earlier passes had put names (`MoveMenuCursorGrid_17` etc.) on those
boundaries. Seeding them decoded from inside an instruction -- `fa 04 cb`
(`ld a, [$cb04]`) read from its second byte gives `04 cb 3c` (`inc b` /
`srl h`) -- and **`make compare` still passed**, because a mis-aligned decode
re-assembles to the same bytes. Byte-perfect rebuild is not a check on where
a routine starts.

The fix is to align against a *labelled* twin by opcode sequence rather than
by raw bytes (the copies differ in constants): decode 12 instructions from
each bank-`$3e` function start, slide over bank `$16` looking for the same
`(opcode, length)` tuple. Every one of the ten mapped to exactly one address.
The same walk then transfers all 72 of the twin's local labels
(`.wrapRight`, `.storeLeft`, `.checkUp`, ...) instruction-for-instruction.

**2. Opcode-signature twin scan.** Same idea, but signatures instead of bytes,
so copies with different constants match. 71,884 distinct 12-instruction
signatures indexed; **zero** blobs contain one after the bank-`$16` fix.

**3. Intrinsic code shape.** Scan inside every blob for a run of >=8
instructions ending in `ret` whose `call`/`jp` targets are all known function
starts and whose `jr` targets stay in range: **zero**. Treat this one as
weak evidence -- a self-test on three known routines found only one of them,
because short routines and ones that only call ROM0 helpers score nothing.
The twin scans are the load-bearing detectors.

**4. Unreferenced code islands between data blobs.** 61 places in the ROM have
code sandwiched between two `INCBIN`s; 15 are short. Every one of them is a
referenced, named function (`LoadTilesetGfx`, `ShotBallPathDrop`,
`DecompressCharacterPortrait`, ...). No false-code islands remain beyond the
three already in `BAD_SEEDS`.

**5. LZ extent audit.** Decompress every `lz_` blob and compare the stream
length to the recorded extent. Four mismatches, all real:

* Bank `$16`'s character-portrait chain had three *function-sounding* labels
  (`RulesBorderAnimTask` `$7420`, `RulesSpinningBallSpriteTask` `$74db`,
  `RulesScrollArrowSpriteTask` `$755e`) sitting **inside** LZ streams, which
  truncated `PortraitGfxEmily_16` (110 -> 151 bytes), `PortraitGfxBCoz_16`
  (146 -> 147) and `PortraitGfxUnknown_16` (9 -> 126). Removed; the region is
  now an unbroken chain of streams that each decompress to 144 bytes.
* `TennisDictionaryListData` (`$3f:$459c`) carried 163 bytes of slop past its
  367-byte stream -- a second, unreferenced 1,152-byte payload, now
  `TennisDictionaryListDataAlt`.

Also carved: `$17:$4f02`, the 1,637-byte run that turned out to be 20
back-to-back LZ streams, is now 20 named blobs `CourtDiagramGfx0`-`19`,
one per pointer in `CourtDiagramGraphicsList`.

Clean after the sweep: 0 byte-twin hits, 0 signature-twin hits, 0 shape hits,
0 unreferenced islands, 0 LZ extent mismatches, 0 unresolved `farptr`, 0
adjacent `INCBIN` pairs without a label between them, and 0 `Gfx_`/`Label_`/
`Func_` symbols. 17,241 of 20,856 labels human-named.


## Identifying the remaining data (2026-07-26)

Started at 387,569 bytes of blob under an auto `Data_`/`Lz_` name (18.5% of
the ROM); ended at 51,668 (2.5%). Three structures accounted for nearly all
of it, and all three were resolvable statically once the indexing code was
read -- the emulator's contribution was confirming behaviour, not finding it.

### Sound (banks `$78`-`$7f`, ~130 KB)

`PlaySound` (`$3297`) takes a sound id, splits it at `$50` (below = SFX,
above = music), and indexes `SfxIndexTable` (`$3151`) or `MusicIndexTable`
(`$31b5`) at `(id - base - 1) * 2`. Each 2-byte entry is
`db (channelCount << 4) | (bank & $0f), tableIndex`, and the bank is
reconstituted as **`$70 | low nibble`** -- which is why all the music lives in
`$78`-`$7f`. `tableIndex * 4` then indexes the bank's `SoundTable_bb` at
`$4000`; `StartSoundChannel` consumes 4 bytes per channel (channel-struct
offset, a flag, and a pointer to that channel's script).

Resolving all 163 ids lands on **315 blob starts exactly, with zero malformed
entries** -- the check that the decode is right. Every channel script is now
`Music<id>_Trk<n>` / `Sfx<id>_Trk<n>`.

Two things fall out of the table layout:

* **The two index tables overlap.** `SfxIndexTable` + `$45 * 2` runs past
  `$31b5`, so SFX ids `$41`-`$45` resolve to music entries `$5f`-`$63`. The
  sound test's own list confirms it -- it offers SFX `$00`-`$32` and then
  jumps to `$41`-`$45`, skipping the range that would collide. Driving the
  game showed `Sfx $41` firing on every menu confirm, so the aliases are live,
  not vestigial.
* **Bank `$0c` is a leftover sound bank.** It has the same 36-entry table
  shape and all 36 of its pointers land on blob starts, but `or a, $70` means
  no id can ever select it. 17 of its 36 scripts appear byte-identically in
  the live banks. Named `UnusedSnd0c_*`.

### Overworld walk sprites (banks `$6a`, `$6f`, `$70`-`$77`, ~117 KB)

Banks `$6a`/`$6f`/`$77` already carried a `WalkSprites_*` slot table; `$70`-`$76`
have the identical object headers behind per-slot `DataPtr_` labels. Each
header is `db count, flags` + `dw .frames, OamPtrs_*, .frames`. Walking that
structure names all **1,297** blobs `WalkSprite_<bank>_<slot>_Gfx<n>` /
`_Oam<n>`. Rendering a frame as 8x16 GB objects (not as a 4x4 tile grid --
that reading is unreadable noise) shows four 16x16 character poses per
256-byte blob, which is what makes them walk sprites rather than tilesets.

Worth noting for future hook work: these banks never appear in a
`CopyDataFromBank`/`DecompressDataFromBank` capture from the menus. They are
read in place during play, so a hook-based sweep of the menus will not see
them however long you drive.

### Character banks `$40`-`$5d` (~68 KB)

All thirty share one descriptor at `$4002`; its sixth word (`$400c`) is
`$7ce0` in every bank and the emitted header already annotates it "per-slot
OAM data" -- so those 580-byte blobs are `<Char>SpriteOam`.

The 1,680-byte run at `$7650` is unreferenced: the frame table's 145 entries
resolve to exactly 56 distinct frames ending at `$7650`, and nothing in the
ROM points into it. It is 7 x 240 bytes and **all seven chunks are
byte-identical to frames the table already references** -- unreferenced
duplicates, named `<Char>SpriteFramesUnused`.

### Generator fix

Several emitters declare a label for the same offset (the fill/segment path
that runs up to a blob, and the blob's own mark). Most guard on `lines[-1]`;
a curated name at such an offset slipped through both and emitted the label
twice, which rgbasm rejects as a redefinition. Identical consecutive label
lines are now collapsed in `_emit_bank`.

### What is left

51,668 bytes in 270 blobs, no longer dominated by any one structure: bank
`$3c` (8.9K, mode-select/stadium screens), `$6d` (5.9K), `$16` (5.4K), `$3d`
(5.0K), `$3f` (4.0K), and single large blobs in `$64`/`$65`/`$68`/`$69`.
18,949 of 20,856 labels human-named.


## Every blob identified (2026-07-26)

The 51,668 bytes still under an auto `Data_`/`Lz_` name after the sound and
sprite passes are now **zero**. Every one of them turned out to be the target
of a `$4000` slot, so the work was finding the code that computes the slot
number -- three dispatchers cover almost all of it.

**`LoadCompressedTileBlock` (`$39:$468b`)** takes a block id in `b`, indexes
`TileBlockPtrs_39` (122 one-slot records) and decompresses that slot into
VRAM. All **156** call sites in the ROM set `b` from a constant, so
backtracking each one yields (block id, enclosing loader) and names the
target: `LoadMainMenuGfx` -> `MainMenuGfx0`-`7`, `LoadCourtSelectGraphics` ->
`CourtSelectGfx0`-`9`, `LoadCutsceneTileset` -> `CutsceneGfx0`-`6`, and so on
for 110 blobs across nine banks. Blocks pulled in by several unrelated
loaders are shared UI furniture and keep a neutral `SharedMenuGfx<nn>`.

**`LoadScreenAssetRecord` (`$39:$407e`)** takes a record id in `c` and
consumes a 4-slot `dslot` record (Tiles, Tilemap, Attrmap, Palettes) from
`ScreenAssetRecordTable`. Only ten of its 70 records still held unnamed
slots, and the same `ld c, $NN` backtrack named them -- most usefully
`SetupCharacterSelectScreen` -> record 5 -> bank `$3c` slots `$70`-`$76`.

**The story scene banks** (`$5f`-`$69`) use `SceneGfxSlotTable` in bank `$0a`:
8 slots per scene -- config, palettes, tilemap, attrmap, aux tilemap, aux
attrmap, one more, tiles. The loader pushes slots 1-7 and pops them into
WRAM1 `$d000` (64 raw bytes = the palettes, which pins the mapping), WRAM3
`$d000`, WRAM2 `$d000`, WRAM6 `$d000`/`$d400` (the collision and behaviour
maps) and WRAM6 `$d800` -- **and pops one slot into `hl` and immediately
overwrites it**. That discarded slot is index 6, whose targets are not LZ
streams and which no other code reads; they are named
`<Scene>SceneUnusedSlot`. In **8 of the 14 scenes it points at the start of
the bank's trailing `$ff` padding**, which is the clearest evidence that the
field is vestigial. The fill itself was always handled correctly -- the
section stops and `rgblink -p 0xff` pads the rest, so no bytes are emitted --
but the pointer still needs a label to resolve, and `emit.py` now stems such a
target `Fill_` rather than `Data_` when it has no curated name.

For the runs with no named caller, the *decompressed output size* names the
role, and the run length identifies the set: 64 bytes = a 16x16 icon, 240 = a
15-tile label strip, 256 = an icon set, 1024 = a tilemap or attrmap, 4096 = a
tileset. Three runs are exactly one item per roster entry or bracket seat --
bank `$18` slots `$48`-`$86` are **32** consecutive 64-byte icons
(`CharRosterIcon00`-`31`, matching the 32-name roster), bank `$3f` slots
`$30`-`$54` hold **16** (`BracketCharIcon00`-`15`) and bank `$6d` slots
`$32`-`$50` another **16** (`IntroCharacterIcon00`-`15`).

Two stragglers were worth the extra look:

* **The char-select cursor** (`$18:$59fe`, 108 bytes) decodes completely:
  `DrawCharSelectCursor` reads a 32-entry animation table with
  `hVBlankCounter & $1f`, adds a state bit, indexes a 4-entry pointer table at
  `$5a1e` and queues the 17-byte sprite template it points at. The blob is now
  `CharSelectCursorAnimTable` + `CharSelectCursorTemplatePtrs` +
  `CharSelectCursorTemplate0`-`3`. `ApplySpriteBobOffset_18` reads a 64-entry
  ramp at `$5a79`, which makes the unreferenced 7-entry ramp at `$5507` an
  unused one of the same kind.
* **`$14:$56ea`**, the blob that resisted two earlier passes, is graphics
  after all. `LoadPlaneObjGfx_14` copies from `$5650` exactly as
  `LoadPlaneObjGfx2_14` copies `IslandObjTiles_14` from `$5a50`; an
  `actor_script` spec had over-run 154 bytes past its real end and buried the
  start. Labelling `$5650` recovers one clean 1024-byte `PlaneObjTiles_14`,
  the same size as its twin. **A blob that looks unidentifiable is often just
  a blob whose start is wrong.**

Result: **0 unidentified blobs; 100% of raw blob bytes sit under a curated
name**, 89.3% of the non-fill ROM overall. What is left auto-named is 211
labels on structures already rendered inline in the source (mostly
`SpriteTemplate_*`) plus 10 on bank-end fill. 19,226 of 20,861 labels
human-named.


## Palettes moved out of the repository (2026-07-26)

The project's rule is that no copyrighted ROM content is committed: graphics,
audio and text all live in the gitignored `data/` tree, extracted from the
user's ROM by `./setup.sh`. Game text already had a middle path -- it is fully
*decoded*, but the decoded source is generated into `data/*/text_*.asm` and
`INCLUDE`d, so the repository carries the structure without the strings.

Palettes now get the same treatment. 146 palette tables, **8,619 bytes of
literal BGR555 colour values**, used to be committed as inline `dw` rows in
`src/*.asm`; they are colour choices, which is graphics by any plain reading,
and they were the largest thing in the source that reproduced ROM bytes
verbatim. `emit.py` gained a `GENERATED_SPECS` set: a declared spec listed
there is emitted as
`INCLUDE "data/bank_XXX/palettes_XXXX.asm"` plus a manifest entry carrying the
spec, and `tools/extract.py` renders it at setup with the same
`render_palettes` used before -- so the source reads identically, the build is
still byte-perfect, and nothing changes except where the values live.

The distinction the set encodes: a spec stays **inline** when its rows are
layout the assembler recomputes -- label arithmetic, pointer symbols, record
structure -- and moves **out** when its rows are ROM values. Literal bytes
committed in `src/` dropped from 38,380 to **29,761** (1.4% of the ROM). What
is left under that measure is mostly `map_actors` (11.6K), `actor_script`
(9.8K), `records:2` (8.5K) and `tilemap_dispatch` (8.0K) -- decoded game logic
rather than assets, which is the side of the line the README's wording
("graphics, audio, text, and any code not yet analyzed") puts them on.

**Sound got the same treatment.** The 130 KB of channel scripts were always
INCBINs of gitignored `data/`, and they stay that way -- decoding them into
`snd_*` macros would put the music sequences into the repository as committed
source, so the identification is the deliverable and the bytes stay with the
user's ROM. What *was* still inline is now out too: `sound_index` (the
`SfxIndexTable`/`MusicIndexTable` directory, 326 bytes) and a new `sound_data`
spec covering the driver's `SoundPitchTable`, `SoundEnvelopes`,
`SoundChannelMaskTable`, `SoundEnvelopeTable`, `JingleSoundIds` and the
sound-test id/label lists -- **1,264 bytes across ten tables**.

That left the `SoundTable_*` pointer tables, whose rows alternate a symbolic
stream pointer (`dw Music51_Trk0` -- recomputed from layout, reproduces
nothing) with a literal channel word. Moving the whole table out would have
deleted 315 stream names for the sake of 702 bytes, so the word is now
*decoded* instead: `snd_channel 2, $01` renders the channel-struct index the
low byte selects (always `$20`-aligned) and the byte stored into that struct,
reassembling `dw $0140` exactly. Derived structure, like `set_flag FLAG_NAME`.

Literal ROM bytes committed in `src/`: 38,380 before the palette move, 29,761
after it, **28,123** now.


## The `records:2` tables (2026-07-26)

`records:2` was the generator's catch-all for 2-byte-record tables -- 297 of
them, 8,513 bytes -- and it was covering three different things. 141 were
named; the other 156 are now resolved too.

**The addressing idiom was the blocker.** A first pass backtracked
`ld hl, $xxxx` and found loaders for only 52 of the 154 anonymous tables. The
rest are reached with a split base:

    add a, $bd    ; LOW(table)
    ld l, a
    adc a, $43    ; HIGH(table)
    sub a, l
    ld h, a

so the table's address never appears as a word anywhere in the source.
Searching for the **byte pair** instead found the loader for 98 of the
remaining 102.

**81 of those are dialogue tables.** The loader derefs the entry and calls
`InitDialogueTextCursor` or `script_speak`, and the index is `$c2b0` -- the
story-rank value `SetStoryRankSceneIndex` writes. A new `text_ids` spec
renders each word through the existing `Text_<bank>_<index>` mechanism, so a
row now names the string it selects:

    TrainingGymNpc03TextIds:
        dw Text_35_169 ; record 0

Checked against `tools/strings.py`: 35:169/179/189 are that NPC's
weight-training lines, which is what a training-gym NPC should say as the
player ranks up -- and it confirms the `$c2b0` rank index independently.

**Note on a test that did not work.** Deciding "is this a text-id table?" from
the *values* is useless: `text_id_name` accepts any word whose fetcher nibble
is 0-12, so 243 of the 297 tables "decode", including `PowersOfTen_05` and
`NotePeriodTable`. The consumer is the only reliable discriminator.

The other groups: 59 jump-table targets named (32 from the single
`farcall`/`jp` they contain, so `DialogueTextFetchers_05` now reads
`dw FetchDialogueTextBank30`), and four tables whose extent swallowed their
own targets -- scanning words in order and stopping at the lowest target gives
the real length, turning `$1b:$5c8d` from a 708-byte blur into a 10-byte
5-entry table addressing 48-byte `RankingMarkerCoordSet` blocks.

**291 of 297 tables named**; 4 unlabeled, 155 bytes.


## Pointers that survive an edit (2026-07-26)

A disassembly you can *change* needs every pointer to be a symbol. 770 were
not: 316 `dw $xxxx` words and 445 `ld hl/de/bc, $xxxx` immediates whose target
had no label, because it landed inside an `INCBIN` blob or inside a declared
table. They assemble to the right bytes, but they are addresses frozen at
their 2001 values -- insert one byte ahead of the target and the pointer
quietly aims at the wrong place. **84 are left, and all but a handful are
not pointers at all.**

Three things were missing.

**Labels could only be placed between structures, not inside one.** The
existing `ptr_data_targets` mechanism splits an anonymous run at a pointer
target, but a target *interior* to a declared table was deliberately skipped
-- cutting the run there would have truncated the table and left the remainder
without its spec. Now a region is rendered in *pieces*: `_emit_spec_pieces`
cuts `[start, end)` at every interior target and renders each piece under the
same spec, with the auto `Data_bb_aaaa` label between them. Splitting is
allowed only for specs whose rendering is a run of independent rows
(`is_splittable`: `bytes:N`, `records:N`, `tilemap:N`, `palettes`,
`sound_data`, `fill`, `pattern`, `text_ids`, `flag_ids`); bytecode, a decoded
header or a table whose rows reference their own base stays whole and its
pointer stays numeric. `INCBIN` blobs split the same way, into one file per
piece. So does a generated spec -- a palette array cut in two becomes two
`INCLUDE`s of two generated files, which keeps the rule that no ROM values
land in the repository:

    CourtDiagramPalettes:
        INCLUDE "data/bank_017/palettes_4ec2.asm" ; $4ec2, 16 bytes (palettes)
    Data_17_4ed2:
        INCLUDE "data/bank_017/palettes_4ed2.asm" ; $4ed2, 48 bytes (palettes)

**Pointer *tables* were never a source of targets.** Only `ld rr, imm` sites
were. `pointer_table_targets` now walks every all-pointer word table
(`records:2`, `mode_hooks`, `minigame_configs`) and yields its words, so the
rows name what they point at. The table's extent is not known until emit lays
the bank out, so the walk stops at the first word that is not an in-bank
address or at whatever claims the next offset -- over-running only costs a
label nothing points at. One case needed its own rule: record 0 of a pointer
table nearly always aims at the row array immediately *after* it, which is a
declared table in its own right and so never a cut point; those are named
where they are declared instead. `EquipRecordPtrs_02` now reads as its four
records rather than `dw $486b`.

**The `ld rr, imm` use-gate rejected two whole idioms.** It walks forward
looking for a dereference, and gave up on:

* *Argument passing.* `ld hl, table; call LoadPaletteShadow` -- the deref is in
  the callee. `callee_pointer_regs` now scans every call target to see which of
  hl/de/bc *it* dereferences, and a call to such a routine counts as a use.
  Iterated twice so a helper that forwards its argument counts too. This is
  also what keeps the false positives out: `ld de, $964a; call QueueSprite`
  stays numeric, because QueueSprite reads d and e as a y/x pair and never
  dereferences them.
* *Split-base indexing.* `add a, l; ld l, a; jr nc, .x; inc h` reads as a
  clobber of `l` unless you know the `add` came first; the scan now carries
  that across the pair, which is what unlocked bank `$3b`'s table lookups.

Sizes are checked, not assumed: **`make compare` is still OK**, from clean.
4,592 blobs became 4,831 and 430 new labels were emitted; the naming pass
below then gave 361 of them real names.

What is left is mostly not fixable by naming: 118 of the remaining 122 `ld`
immediates fail the use-gate because they are *not* pointers (`ld de, $4000`
before an overflow check, QueueSprite coordinate pairs). Only 10 `dw` words
are still bare, in `records:4`/`records:16` object templates where just some
columns are pointers and the column layout is not modelled yet.


## Naming the pointer targets (2026-07-26)

The 430 labels the pass above created were auto `Data_bb_aaaa` names. **361 now
have real ones**, and none of them needed guesswork: a pointer target is
defined by what reads it, so the *consumer* names the data.

Two derivations cover everything:

* **A row of a pointer table** takes the table's name minus `Ptrs`/`Pointers`,
  numbered in address order -- `EquipRecordPtrs_02` gives `EquipRecord0`-`2`,
  `CharDataScreen_DrawStatBarPtrs` (33 words) gives
  `CharDataScreenStatBar00`-`32` over 33 five-byte rows.
* **A `ld rr, imm` target** takes its routine's name minus the leading verb,
  plus a suffix read off the helper the pointer is handed to:
  `ApplyTilemapPatchList` -> `...TilemapPatch`, `LoadPaletteShadow` ->
  `...Palettes`, `DecompressData` -> `...Gfx`, `PrintString` -> `...String`,
  `CopyMemory*` -> `...Data`, and the split-base `add a, l` index idiom ->
  `...Table`. Where several routines share a blob the common tail of their
  names is used, which is why the char-data screen ends up with
  `MainCharStatPageTilemapPatch*`, `PartnerStatPageTilemapPatch*` and a shared
  `StatPageTilemapPatch*` set rather than one arbitrary owner's name.

Where a derived name already existed the series continues past it
(`ExpScreenGfx5`-`8`), which is itself a check: the rule independently
reproduced names a human had already chosen for the siblings.

Left auto (69): targets with no resolvable reference, targets whose referring
table is itself auto-named, six whose derived name is already taken by a
different offset, and two whose enclosing label is data rather than a routine.

`Unused_1c_0`'s 32 rows were the one group worth looking at directly.
Rendering the 64-byte payloads as 2bpp shows one image redrawn a pixel further
along in each -- a pre-shifted sprite set, so `UnusedShiftGfx00`-`31`.

**Three emitter bugs surfaced, all from naming an offset that had only been an
auto label before.** A curated name is not cosmetic; it changes how the bytes
around it are classified.

* A curated label on a short printable run made it *text*. The rule exists so
  one label can split a string out of a pool, but `bbebb` -- five tile ids for
  a stat bar -- is printable too, and 23 record rows became prose. It now also
  requires a terminator and more than one letter, which the three real strings
  in the batch (`EFFECT`, `LOADED `, `SAVED  `/`DELETED`) have and the records
  do not.
* A curated label *ends* a region, so the bytes after it lost the enclosing
  table's spec: 95 payloads (2,172 bytes) fell out as anonymous blobs. Fixed by
  declaring the 63 byte-table payloads in `data_tables.json` -- the label names
  a structure, so the structure gets its own declaration. The `records:2`
  payloads were deliberately *not* declared: that spec asserts every word is a
  pointer, and bank `$1b`'s `RankingMarkerCoordSet*` arrays are coordinates,
  which rendered as 71 bogus pointer words when the spec reached them.
* Letting a spec carry across a cut is only safe for some kinds. `fill` and
  `pattern` assert that one exact run is padding, and propagating one turned
  1,472 bytes of bank `$28` tile graphics into `ds` runs -- wrong, and it would
  have written ROM pixel values into the committed source. They are no longer
  splittable, and a cut inside a `records:N`/`palettes` run must land on a
  record boundary (`bytes:N` counts display columns, not records, so its rows
  simply regroup).

The last two are why the numbers moved twice: naming pushed the bare `dw` count
from 42 down to **10** (the coordinate arrays stopped pretending to be pointer
tables), while structured source settled at 413,371 bytes. `make compare` is OK
from clean throughout.


## Repo state

All work is committed (HEAD `d694abd`); every commit rebuilds byte-perfect.
Gitignored: baserom.gbc, data/, build/, tools/rgbds/, *.o, *.gbc, *.sav.

## Tail calls, and three tables that lied about their length (2026-07-26)

The pointer work above left 132 bare addresses. **95 remain, and exactly one
`dw` pointer row is among them** -- `TangentTable` record 254, whose value
`$62ca` is a tangent, not an address. (That framing was too kind to the table;
see "A maths table is not a pointer table" below -- six *other* records of it
were resolving to labels, which the bare-address count could not see because a
resolved row is not bare.)

**Tail calls.** The use-gate followed a pointer into a `call`ed routine but not
a `jp`, which is how the VRAM helpers pass their argument down: `QueueVRAMCopy`
never touches `hl`, it `jp`s to `StartVRAMDMAFromHL`, which does `ld b, h` /
`ld c, l` and `jr`s to `StartVRAMDMATransfer`, which writes `bc` into the VRAM
DMA source registers. Three things were missing, and all three are needed for
that one chain: tail calls count as handing the value on, `ld b, h; ld c, l`
carries the pointer to another pair, and `StartVRAMDMATransfer` is seeded as
taking an address in `bc` (`POINTER_ARG_ROUTINES`) because writing a pair to
`$ff51`/`$ff52` *is* the dereference, and no scan can see that. The map now
iterates three rounds to get from the seed back up to the call sites. That
resolved all 14 `QueueVRAMCopy` sites and several singletons.

**The table extents.** Each of the remaining `dw` groups was a declaration
wrong about where its table ends, and each failed differently:

* **Bank `$0f`** was declared one byte late. The reader's split base is
  `add a, $91` / `adc a, $76` = `$7691`, but `records:2` sat at `$7692`, so
  every word was rendered from the wrong byte pair and the "pointers"
  (`$4f28`, `$5228`) were nonsense that landed mid-instruction. Read from
  `$7691` the entries are `$2847`, `$284b`, `$284f` ... -- nine values sharing
  a fetcher nibble, and the consumer is `InitDialogueTextCursor`, so it is a
  `text_ids` table: `Text_25_70`-`82`. The off-by-one had also pushed the
  following instruction a byte late.
* **Bank `$10`**'s `WaterSpriteModeHooks_10` was fine; the *walk* was not. It
  stopped at the first word outside the bank window, and slot 3 is the shared
  ROM0 `ret` stub, so slots 4-6 were never yielded. They point at `$4beb`,
  `$4bea` and `$4be9` -- the handler plus two of the three consecutive `ret`
  bytes at `$4be8`, one address per slot. A `mode_hooks` table is always eight
  slots, so the walk now runs all eight and skips ROM0 words.
* **Bank `$1a`**'s `records:2` run at `$4ab4` was declared 107 bytes -- an odd
  length for a word table, which is the tell. It is 32 tilemap addresses in
  four rows of eight (`$0b38`-`$0b3f`, `$0b48`-`$0b4f`, ...); at +64 the words
  become `$c5f5`, `$e5d5` -- `push bc` / `push af` / `push hl` / `push de`, a
  routine prologue. Bounded to 64 bytes; the 43-byte remainder is a blob rather
  than asserted code, since no trace has executed it.

`$76a3`, the byte between the bank `$0f` table and the next instruction, is
declared `bytes:1`: the instruction at `$76a4` is trace-proven, so the byte
before it is a leftover, not the start of anything.

18 more targets were named from their consumers, including the six whose
derived name collided with an adjacent sibling table -- each turned out to be a
genuine pair (`VictoryScoreTable` is `03 05 07 09`, and `VictoryScoreTable1`
right after it is `02 04 06 08`), so they take the next index.

Left: 94 `ld` immediates, of which 17 QueueSprite coordinate pairs, 15
`ApplySlideOffsetToSpriteX` byte pairs, 17 with no pointer use at all and the
rest of the same shape are simply not pointers. The genuine ones left are 9
`ScriptRespawnLocationActors` actor lists (targets interior to a `map_actors`
run, which cannot be cut) and a dozen singletons.

## Targeting the interior of an actor list (2026-07-26)

Nine `ld hl, list; farcall ScriptRespawnLocationActors` sites were the last
sizeable group of unresolved pointers, and the diagnosis that they were all
interior to a `map_actors` run was wrong -- eight of them were something
simpler, and only one needed the interior work.

**The farcall path was dead code.** A `farcall` is `rst $18`, and
`Disassembly.decode_at` gives it `target=None` because the bank and entry it
resolves to live in `dis.farcalls`, not in the operand. The use-gate's callee
check was written `if ins.target is not None and (ins.is_call or ...)`, so it
skipped every farcall in the ROM -- no cross-bank argument could ever resolve.
Both the check and the entry collection now go through a `_call_target` helper
that consults `dis.farcalls` first. That alone resolved eight of the nine (the
targets are declared `map_actors` tables, which get a `Data_` label the moment
the load is vetted), plus the `ApplySpriteBobOffset` and `SpawnActorsFromList`
sites.

**Cut validity is now structural, not arithmetic.** The ninth target,
`$10:4ce3`, really is inside a `map_actors` run: a slot can hold several
back-to-back actor lists (runtime-selected variants), each a run of 14-byte
records ended by the 9x$00 + $ff sentinel `SpawnActorsFromList` stops on, and a
pointer into the run selects one of them. A stride check cannot express that,
so `_valid_cuts` replaced `_stride` as the gatekeeper: for `map_actors` it
walks the records exactly as `render_map_table` does and allows a cut only
where a new list begins. The Development map's slot holds two empty lists, and
the second one now reads:

```
DevelopmentActors_10:
        ; $4cd9, 10 bytes (map_actors)
        map_actor_end
DevelopmentRespawnActorList_10:
        ; $4ce3, 10 bytes (map_actors)
        map_actor_end
```

Nine more targets named from the script that respawns them
(`AcademyWingInitActors0`/`1_10`, `CenterCourtSceneVariantActors_11`,
`CharViewerSceneActors_1a`), so a story script now reads
`ld hl, AcademyWingInitActors1_10` instead of a bare address.

**84 bare operands left**, none of them a `dw` pointer row except
`TangentTable`'s tangent value: 17 QueueSprite coordinate pairs, 15
`ApplySlideOffsetToSpriteX` byte pairs, 17 with no pointer use at all, and
singletons of the same kind.

## The unnamed functions, and what they turned out to be (2026-07-27)

19 `Func_*` labels were left after the pointer passes -- notable because the
2026-07-26 naming pass had got that count to zero, so every one of them was
created by the pointer work itself. Reading them splits three ways.

**Nine are real, and all nine are the same thing**: per-character callbacks run
through `ForEachCharBank`, which iterates the four on-court character WRAM
banks. Each is installed as `ld hl, fn; call ForEachCharBank`, so the routine
that installs it names the moment and the body names the action:

| offset | name | body |
| --- | --- | --- |
| `$4274` | `SetCharStateForRallyTick` | state $05, from `TickRallyTimers` |
| `$4c99` | `SetCharFacingFromCourtPos` | indexes `CourtPosFacingTable_08` |
| `$4cb2` | `MoveCharToBaseCourtPosition` | base position -> pos and target |
| `$4f6f` | `ResetCharForPoint` | state 0, base pos, anim 1, zero velocity |
| `$4f91` | `SetCharStateFromServeRole` | indexes `ServeRoleCharStateTable_08` |
| `$5fe5` | `StartCharChangeoverWalk` | state 6, face left, walk to base |
| `$6003` | `PlaceCharAtBasePosition` | base pos + the facing saved at `$df0c` |
| `$6046` | `StartCharWalkOffCourt` | state 6, target the changeover spot |
| `$6059` | `ParkCharOffCourt` | pos and target to the fixed `$0fe0` spot |

The two 4-byte tables they index are named with them:
`CourtPosFacingTable_08` (`$c0 $c0 $40 $40` -- up, up, down, down by court
position) and `ServeRoleCharStateTable_08` (`$03 $05 $04 $05`).

**Two were a false positive I had introduced.** `ld de, $4404; call
DrawDecimalNumberSprites` was reading as a pointer setup because
`callee_pointer_regs` counts a `push` of the tracked register as pointer use --
and `DrawDecimalNumberSprites` opens `push af; push bc; push hl; ... push de`.
At a *call site* pushing the value is a dispatch and the rule is right; at a
routine *entry* it is a prologue saving a register, so the entry scan no longer
counts it. `$4404` is a y/x pair, and now renders as one.

Dropping that rule would have cost the actor-list chain, which depends on
`InitLocationActors` holding its argument across its setup -- so the scan now
also tracks **push/pop symmetry**: a `pop` matching an earlier `push` of a
tracked register restores it rather than clobbering it, which is how
`InitLocationActors` carries the list from its prologue to
`farcall SpawnActorsFromList` 20 instructions later. The entry window went from
24 to 32 instructions to reach it.

**Eight are not functions at all.** Every one is the base of a split-base
lookup table -- the consumer does `add a, l; ld l, a; jr nc, .read` and
dereferences -- and the bytes say the same: `$17:$40bd` and `$1b:$40e7` are the
identical 16-byte table `00 00 00 01 01 01 01 01 01 01 01 00 00 00 00 00` with
the real routine (`push de; push bc; ld c, $00; ld b, $09`) starting right
after it, and `$38:$6a27` is six pointer words (`$6a33` x4, `$6a37` x2) read
with `ld a, [hl+]; ld h, [hl]`. They carry a `Func_` name only because an
offset inside them is decoded as code: five of the eight are *trace-seeded*,
which on this evidence means phantom trace lines of the kind `BAD_SEEDS`
already documents, not executed code. Left alone for now -- each needs its own
entry and reasoning there, and getting it wrong un-proves real code.

## The eight false functions were bad seeds of our own (2026-07-27)

The eight `Func_*` labels that were not functions all traced back to one cause,
and it was not the traces: **seven of the eight offsets are in this repo's own
`coverage/bank*_static_code.json` files**. Those are the curated seed lists the
project uses for code no trace reaches, and each of these had been aimed at a
*table* rather than at the routine after it, so the seed swept the table in as
instructions and descent carried on through it. (`load_coverage` reads the
static files alongside the real dumps, which is why an earlier check here
reported them as "trace-seeded" -- they are seeded, but by hand.)

Every one is a split-base lookup whose consumer sits immediately before it:

| seed was | is really | code starts |
| --- | --- | --- |
| `$05:$5e39` | 16 handler words `RenderProportionalTextAt` dispatches control codes through (`cp a, $20; jr nc, .glyph`) | 5 handlers |
| `$10:$54ec` | 5 handler words `RunEraseSavedDataFlow` `jp hl`s through | 3 handlers |
| `$17:$40bd` | 16-byte `hVBlankCounter & $0f` offset table | `$40cd` |
| `$1b:$40e7` | the same table | `$40f7` |
| `$38:$40bf` | the same table | `$40cf` |
| `$17:$46c2` | 8 unreferenced bytes after a `ret` | -- |
| `$17:$46ca` | 12-word symmetric ramp for `CycleDiagramTargetPalette` | `$46e2` |
| `$17:$4a75` | six 6-byte records for `DrawDiagramTargetPatch` | `$4a99` |
| `$38:$6a27` | 6 pointer words `AdvanceRemotePlayerSlot` indexes by `[$d813]` | `$6a3c` |

The three `$40bd`/`$40e7`/`$40bf` tables are the same 16 bytes in three banks,
and the routines after them are **byte-identical for 911 bytes** -- a relocated
copy, like the OAM-frame loader twins `infer_twin_tables` already handles. Only
bank `$38`'s copy has call sites, so simply dropping the seeds would have lost
the other two: each file now seeds the routine's real entry instead, and for
the two jump tables it seeds every distinct handler target, which is what the
existing bank `$10` file already does for its handler tables.

All nine regions are declared in `data_tables.json` and named, so the tables
read as what they are and the two dispatch tables resolve their handlers:

```
ProportionalTextCodeHandlers_05:
        ; $5e39, 32 bytes (records:2)
        dw Label_05_5ecd ; record 0
        dw Label_05_5e72 ; record 1
```

**No `Func_*` labels remain**, and 141 bytes stopped being counted as proven
code -- the correct direction, since they never were. `make compare` OK from
clean.

## Bank $12's senior-court cutscenes (2026-07-27)

The 21 unnamed `Label_*` in bank `$12` were the largest remaining cluster, and
they are one structure: the handlers of three dispatch tables, all indexed the
same way. `$c2b1` is the senior-court stage, and `ComputeSeniorCourtStage`
(`$7756`) derives it from the story flags:

| stage | flag reached |
| --- | --- |
| `$02`-`$05` | senior **singles** ranks 4, 3, 2, 1 |
| `$06`-`$08` | senior **doubles** ranks 3, 2, 1 |
| `$09` / `$0a` | Island Open singles / doubles |

All three dispatchers do `ld a, [$c2b1]; sub a, $02; add a, a` and index their
table with it, so record N is stage N+2 -- which names every handler:

* `SeniorRankingMatchIntroPtrs` (7) -> `SeniorSinglesRank4Intro` ...
  `SeniorDoublesRank1Intro`
* `ResumeSeniorOpponentScriptsPtrs` (7) ->
  `ResumeSeniorSinglesRank4Opponents` ... `ResumeSeniorDoublesRank1Opponents`
* `SeniorMatchVictorySceneDispatchPtrs` (9) -> the victory cutscenes

The mapping predicts which handlers are doubles, and the scripts confirm it:
record 4 of the intro table (stage `$06`, senior doubles rank 3) is the first
one that drives `ACTOR_PARTNER`, and the singles handlers never mention it.

Two victory handlers are shared and keep names that say so:
`SeniorSinglesRank4And3Victory` serves stages `$02` and `$03`, and
`SeniorSharedVictoryScene` serves stage `$06` (senior doubles rank 3) and
stage `$09` (Island Open singles) -- a generic walk-to-position scene, which is
what its body is.

**Bank `$12` now has 316 of 319 labels named**; the three left are the
`DataPtr_*MapScripts_12` slot words, which derive from their targets' names.

## Bank $38: four routines that were never carved, and one more seeded table (2026-07-27)

Bank `$38` (link/menu) held 15 unnamed symbols, and reading them turned up both
kinds of error at once.

**Four fragments were code all along.** Three are proven by twins: the same
bytes are carved and *named* in bank `$16`, where the traces run them, and sat
as `bytes:16` blobs here.

| bank `$38` | identical to | for |
| --- | --- | --- |
| `$42d0` | `MoveMenuCursor2GridRemote_16` | 398 bytes |
| `$43db` | `ClearWram3Row64_16` | 131 bytes |
| `$43f1` | `ClearWram3Row64Alt_16` | 109 bytes |

Bank `$1b` has the same two gaps (`$42f8`, `$4419`), so five fragments in total
are now seeded with the twin justification recorded in each bank's static-code
file. Their internal jump targets take bank `$16`'s local names, so
`.asMaster`/`.asSlave` now read the same in all three copies.

The fourth, `$38:$6bc2`, needs no twin: its three `jr z` branches all land
exactly on `$6bd5`, which was already carved, and it ends in `ret`. It calls
`IsMarioCastCharacter` and then gates on `$d814` -- the equipment-panel category
that bank `$3e` sets to `$01` for rackets and `$02` for shoes -- so it is
`CheckStarCharacterEquipCategory`, with `$6bd5` as its `.returnFalse` tail.

**And six more static seeds were aimed at a table.** `$56d5`, `$56df`, `$56e9`,
`$56f3`, `$56fd` and `$5707` were seeded as handlers; they are the six 5-word
sub-tables `GetPlayerSlotBoxAddress` reaches:

```
        ld a, [$d813]        ; remote player slot -> outer index
        ld hl, PlayerSlotBoxAddrPtrs_38
        ...
        ld a, [$d814]        ; equip category -> inner index
        ...
        ld a, [hl+]          ; -> a WRAM box address in bc
```

Every word in them is a WRAM address (`$d0cd`, `$d0d0`, `$d12d`, `$d130`,
`$d131`, or `$0000` for "none"), which is what a two-level address table looks
like and not what a handler looks like. The old name `SubHandlers_38_56c9`
said otherwise and is now `PlayerSlotBoxAddrPtrs_38` over
`PlayerSlotBoxAddrs0`-`5`. Two stray curated labels *inside* the outer table
(a `.loop` at `$56ca` and a pinned `Data_38_56ce`, both artefacts of the same
mis-decode) had been truncating it to one byte; removed, it renders as its six
records.

Seven small fragments are left unnamed on purpose: nothing in the ROM
references them -- no `ld rr` load and no split-base `add a, lo` / `adc a, hi`
pair -- so there is no evidence to name them from. Two of them (`$560a`,
`$5672`, identical 4-word tables of the same `$d0xx` family) are at least
declared `records:2` so they read as the addresses they are.

**Bank `$38`: 781 of 800 labels named; bank `$1b` gained the same two
routines.**

## Naming a cut point un-structures what follows (2026-07-27)

`RemotePlayerSlotList0`/`1` came back as `INCBIN` blobs after being named, and
they were not alone: **34 regions had silently lost their structure the same
way** across the naming passes.

The cause is the rule from the naming pass above -- a curated label *ends* a
declared table, so the bytes after it no longer carry its spec. That rule is
right (it is what stops a `records:2` pointer spec bleeding into bank `$1b`'s
coordinate arrays), but it means every named cut point needs its own
declaration, and the build stays byte-perfect either way, so forgetting one is
invisible.

Finding them needed a differential measurement rather than a guess: regenerate
with this session's 450 names removed, and diff the manifest. A region that was
structured then and is a `d_*.bin` blob now lost its spec by being named. That
produced exactly 37 offsets -- 34 real, plus two that were *inside* a bigger
blob and merely split it (which is the intended behaviour) and
`Data_1a_4af4`, which bounds an over-running table on purpose. All 34 are now
declared with the spec they used to render under: `records:2` for eighteen,
`palettes` for fourteen, `bytes:4` and `map_actors` for one each.

`RemotePlayerSlotList0`/`1` themselves are `bytes:4`/`bytes:5` -- byte cycle
lists (`$ff, $00, $02, $ff`) that `AdvanceRemotePlayerSlot` scans for the
current value and takes the next byte from, which is why the outer table has
six pointers into just two lists.

**The generator now reports the situation** instead of leaving it silent: after
each bank is laid out, any *pointer target* named exactly at the end of a
declared splittable table, whose payload rendered as a blob, is counted and
listed. The pointer-target test matters -- a name at a table's natural end is
just the next thing starting, and flagging those made the check fire 27 times
on legitimate layout. Verified by removing one declaration and watching the
count go 24 -> 25. The 24 standing cases are older than this session and are
opportunities rather than regressions, so the note is one compact line.

## The text offset tables are layout, so they are source now (2026-07-27)

Each of the 13 text banks opens with an 8,218-byte-total blob at `$4004` that
was carried as raw `d_4004.bin`. It is not text and it is not content:
`FetchText_<bank>` reads it as a *pointer into the pool that follows it*.

```
        ld hl, FetchTextTable
        sla e / rl d              ; text id * 2
        add hl, de
        ld e, [hl] / ld d, [hl]   ; offset = table[id]
        ld hl, TextStrings_1f     ; base = the string pool
        add hl, de                ; string = pool + offset
```

The shape is identical in all 13 banks: table at `$4004`, the pool starting at
the byte after it, every offset list ascending and inside the pool. That is the
same construct `render_text` already recomputes when the table happens to sit
*inside* a text region (`dw .s0 - .strings`); these 13 were split out only
because the fetch routine takes the pool's address, which makes it a pointer
target and cuts the region in two.

So the offsets are **recomputed layout**, and by the repository's own rule
(inline = layout the assembler rebuilds, generated into `data/` = ROM values)
they belong in committed source. Two new specs do it:

* `text_offsets` renders the table inline as the difference of two labels --
  **4,109 of 4,109 words resolve symbolically**, no numeric fallbacks:

```
FetchTextTable:
        ; $4004, 378 bytes (text_offsets)
        dw TextStrings_1f.s0 - TextStrings_1f ; 0
        dw TextStrings_1f.s1 - TextStrings_1f ; 1
```

* `text_pool` renders the strings, in the gitignored tree as always, with an
  `.sN` anchor on each so the table above can name them.

The point is not tidiness. **Editing a string used to corrupt the table
silently** -- every offset after the edit pointed into the middle of a string.
Now the assembler recomputes them. Verified by lengthening string 0 of bank
`$1f` by 11 characters and reading the built ROM back: offset 0 stayed `$0000`
and offsets 1, 2, 3 moved `$0014`->`$001f`, `$004f`->`$005a`, `$0089`->`$0094`,
exactly +11 each. Restored, `make compare` is OK again.

Structured source is up 8.2 KB to 421,788 bytes (20.1%) and 13 more blobs are
gone.

## Text ids at the call sites (2026-07-27)

A dialogue text id already renders as `Text_<bank>_<index>` inside
`script_set_text` operands and map-script handler fields. Plain code that loads
one did not: `ld hl, $04ee` stayed a number even though `$04ee` names a string.

The value cannot decide this. `text_id_name` accepts any word whose fetcher
nibble is 0-12, so `$0001`, `$0012` and `$0300` all "decode" -- the top hits for
a value-based scan are `ld de, $0001` into `LoadPaletteShadow` and
`ld bc, $0012` into `QueueVRAMCopy`, which are a palette count and a width.
**The consumer is the whole test.**

So the sinks are curated and each was read first: `FetchDialogueText` and
`AddTextIdOffset` both open `bit 7, h` -- the SRAM-string flag of the id
encoding -- and `CreateWindowWithTextId` says so in its name. (That signature
is not enough on its own to find them: 19 routines test `bit 7, h`, and 16 are
signed multiplies testing a sign bit.) From those three, `text_id_consumers`
grows the set through wrappers that hand `hl` straight on, reaching **20
routines**, all of them text ones by name: `ShowSpeakerDialogue`,
`InitDialogueTextCursor`, `RunMenuFromText`, `MeasureDialogueWidthTiles`,
`ShowLocationNamePopup` and so on.

`ld hl, imm` sites that reach one with `hl` untouched then render as the
constant -- 503 sites, of which 414 sit inside `script_set_text` sequences that
already printed the name, so **89 loads change**, one for one, from a hex word
to the string it selects.

Checked against the strings rather than assumed, and every sample matches what
its routine is for:

| site | id | string |
| --- | --- | --- |
| `DrawCharGridSlotPrompt` | `Text_30_149` | "CPU Difficulty" |
| `WriteBracketDoublesNames` | `Text_30_76` | "Emily" |
| `DrawSavedDataSourceCaption` | `Text_30_201` | "Mario Char. Data" |
| `BuildResultsScreenPanels` | `Text_31_214` | "No" |
| `CreateMenuWindowFromText` sites | `Text_34_215`/`217` | "Set/Continue", "Mini-Game/Ranking Match" |

`tools/strings.py --index` needed fixing to go with it: it read the offset
table with `solve_table`, which only finds a table *inside* a text region, and
it split manifest lines on exactly three fields. Both broke when the offset
tables became their own `text_offsets` regions. It now pairs each `text_pool`
with its table through `data_tables.json`.

## The LZ encoder, and the two streams it found broken (2026-07-27)

`tools/lz.py` could read the game's compressed streams but not write them, so
1.33 MB of graphics was inspectable and un-editable -- the largest remaining
gap for using this as a modding base. It encodes now.

The format constrains the encoder in one non-obvious way: a reference stores
`d = 0x800 - distance`, so `d = 0` (distance 2048) at the minimum length *is*
the `$0000` terminator. Capping distance at 2047 keeps every emitted reference
distinguishable from the end of the stream.

Greedy longest-match over the 2 KiB window, matches allowed to overlap the
write position (which is how runs encode). **All 619 streams in the ROM
round-trip**, and the encoder's total output is 261,856 bytes against the
original encoder's 261,919 -- 99.98%, so nothing has to grow to be re-encoded.

Two streams would not decode at all inside their declared extent, and the cause
was mine: `RulesNextPageArrowSprite_17` and
`ConfirmCursorSpriteTaskCursorSprites` were named during the pointer pass,
*before* the prologue-push rule was fixed, and both offsets sit **inside an LZ
stream** -- `$17:$7888` is 118 bytes into a 309-byte stream that decodes to a
clean 1024-byte tilemap. Neither routine dereferences the register: both
`ApplySpriteWobbleY_17` and `QueueEraseConfirmCursorSprites` treat `de` as a
y/x pair (`add a, e; ld e, a`). The names were stale evidence from a superseded
analysis, and being curated they truncated the streams by 29 and 160 bytes.
Removed; 619/619 now decode. These were the two offsets the earlier
lost-structure audit waved through as "merely splitting a blob" -- they were
splitting compressed data, which is not the same thing.

End-to-end check, because a codec that only round-trips in isolation proves
little: decoded `$17:$7770` to its 1024 bytes, inverted 64 of them, re-encoded
(309 -> 323 bytes), rebuilt, and read the stream back out of the built ROM --
it decodes to exactly the edited bytes. The stream growing 14 bytes was
absorbed because the bank had room and every pointer past it is a symbol.
Restored, `make compare` is OK.

README now has a Modding section covering the four editable kinds and the one
trap: `data/` is generated, so extraction overwrites edits made in place.

## Copy counts follow their blob now (2026-07-27)

Pointers survive an edit; sizes did not. `ld hl, Tiles; ld c, $20; call
QueueVRAMCopy` copies 32 tiles because that blob happens to be 512 bytes long,
and enlarging the blob leaves the literal quietly wrong -- the new tiles simply
never reach VRAM. It is the same defect class as the text offset tables, one
step further along.

A scan for `ld hl/de, <named blob>` followed by a count whose value is exactly
the blob's size found **38 sites, 34 with an unambiguous consumer**: 31
`QueueVRAMCopy` and 3 `CopyMemoryFast`, all taking `c` as a count of 16-byte
tiles (`StartVRAMDMATransfer` writes `c - 1` to the HDMA length register, which
transfers `(n + 1) * 16` bytes).

**33 of the 34 already had a label at the blob's end**, so a post-pass rewrites
the count as the difference of two labels and invents no symbols:

```
        ld hl, MenuFontTiles_01
        ld de, $9200
        ld c, (MenuTilesBStagedTiles0 - MenuFontTiles_01) / 16
```

Verified the way the text tables were: appended one 16-byte tile to
`MenuFontTiles_01` (512 -> 528 bytes), rebuilt, and read the assembled operand
back out of the ROM -- **32 became 33** on its own. (The first read of that
test looked like garbage because the code after the blob had shifted 16 bytes;
the count was right, the address was stale.) Restored, `make compare` is OK.

The one site left numeric has no label at its blob's end; inventing one is
possible but would be the only new symbol in the pass, so it stays as it is.

## The header checksum, which silently bricks an edited ROM (2026-07-27)

The cart header renders as source, so the title, cart type and RAM size are all
editable -- and `$014d`, the header checksum, is a literal `db $a5` sitting
right beneath them. The CGB boot ROM *verifies* that byte and refuses to run a
cart whose value is wrong, so any header edit produces a ROM that builds
cleanly, compares as changed, and then does nothing on hardware or in an
accurate emulator.

Demonstrated rather than assumed: changing `CGBTENNIS` to `CGBTENNIX` and
rebuilding gives `$014d = $a5` where `$a0` is now required. `rgbfix -v`
recomputes it (and the global checksum) and the cart boots again.

`make` now runs `rgbfix -v` after the link. It is byte-neutral on the
unmodified build -- same SHA-1, `make compare` still OK from clean -- because
the checksums it computes are the ones already there. It only does anything
once something in the header has moved, which is exactly when it is needed.

## `make check` — the invariants the byte compare cannot see (2026-07-27)

`make compare` proves the bytes come back. It says nothing about whether the
*structure* the source claims is true, and every structural defect this week
had exactly that shape: the build stayed byte-perfect while the source lied.
Two curated names sat inside LZ streams and truncated them by 29 and 160 bytes;
an offset table was declared one byte late so every word was read from the
wrong byte pair; a `records:2` run reached 43 bytes into a routine. None of
that moves a single output byte.

`tools/check.py` turns the checks into ones that run:

| check | what it asserts |
| --- | --- |
| `lz` | each declared stream decodes *exactly* within its extent, and a re-encode decodes back to the same bytes |
| `lz-labels` | no symbol lands inside a compressed stream |
| `text` | every `text_offsets` word is a string start in its pool, and entry 0 addresses the first string |
| `regions` | extracted regions stay inside their bank and do not overlap |

Currently 619 + 619 + 13 + 4,828 checks, all passing.

Each check was written against a defect and then **tested by reintroducing
it**, because a check that cannot fail is worthless: re-adding
`RulesNextPageArrowSprite_17` is caught as "280 bytes inside
bank_017/lz_7770.bin, which truncates it", and shortening that stream's extent
in the manifest is caught as "does not decode inside its 256-byte extent".

The text check needed two rounds to become real. Its first version derived the
pool's scan window from the table's own entries, so a bogus entry simply
widened the window until it looked valid; it now bounds the window by the
pool's extracted length. Even then, shifting a table's base by one word still
passed -- dropping entry 0 leaves every remaining word a valid string start --
so it also asserts that entry 0 addresses the pool's first string, which holds
in all 13 banks.

## Structuring what the truncation note was reporting (2026-07-27)

The `make`-time note listed 24 pointer targets named at the end of a declared
table, whose payload therefore rendered as an anonymous blob. They are not all
the same thing, and the distinction is the no-ROM-content rule: **a `bytes:N`
declaration inlines the bytes into committed source**, which is right for a
small table and wrong for graphics.

Sorting them by size and name splits cleanly. `FireworkObjTiles_14` (2,048
bytes), `ScoreboardModeGfx_RankingMatch` (181), `ConfirmScreenGfx3` (206) and
the other `Gfx`/`Lz` names are bulk content and stay binary in `data/`. Seven
are tables and are now declared: `UnlockDebugRosterTable`,
`EquipSelectTextRows_3e`, `CharDataPageRightTargets_1c`,
`MainMenuCursorSpriteTask1`, `CourtSelect4CursorSpriteTask1`,
`ItemStatModList1`, and `ItemStatModListPtrTable` (`records:2` -- its name says
what it holds).

Left alone deliberately: the `records:2` payloads whose contents are not
pointers. That spec asserts every word is one, which is what put 71 bogus
pointer words into bank `$1b`'s coordinate arrays earlier; `RankingMarkerCoordSet0`
is the same shape and stays a blob.

`UnlockDebugRosterTable` took a second look after declaring. It went in as
`bytes:16` -- the width of the table it was cut from -- but its rows are
8 bytes with an ascending character id in byte 0 (`$1a`-`$1f`, `$12`-`$15`,
`$ff` terminating), so it is 11 records, not 5.5. Declared `bytes:8`, it reads
one record per line. Inheriting the parent's width would have been a plausible
lie.

24 notes down to 18, all remaining ones bulk content.

## Split-base table addresses now relocate (2026-07-27)

The pointer work left one relocation hole, and it was the biggest one. The game
usually reaches a table not with `ld hl, table` but by adding an index to the
address in halves:

```
        add a, $4a      ; LOW(CharStatTable_07_0)
        ld l, a
        adc a, $5c      ; HIGH(...)
        sub a, l
        ld h, a
        ld a, [hl]
```

Those two 8-bit immediates *are* the address, and unlike a `ld hl` they never
moved when the table did -- which is exactly why an earlier pass had to search
for the byte pair to find these tables at all. **564 full idioms exist; 270
compute an address that carries a label** and now render as
`add LOW(Name)` / `adc HIGH(Name)`, assembling to the same bytes and
following the table thereafter. 234 distinct tables are addressed this way.

Gated like a pointer load: the whole five-instruction shape, a label at the
computed address, and a dereference of `hl` afterwards.

Two guards came out of the compare failing rather than from foresight. The
first version matched 272 sites and broke two bytes in bank `$1b`: the pair
there computes `$c7xx`, a WRAM address, whose bogus flat offset still landed on
a label, so the address must be checked to be in ROM (`$0100`-`$7fff`) before
it means anything. The label it landed on was `DrawFourTileFlagLabel.nonZero` --
a *qualified local*, which my "skip locals" test missed because it only looked
for a leading dot. A local names a point inside a routine and is never a table
base.

Verified by moving a table: growing a blob before `CharStatTable_07_0` by
one byte moves it to `$5c4b`, and the assembled immediate follows, `$4a` ->
`$4b`. Before this it would have stayed `$4a` and read one byte early, which no
build error would have caught.

## Seeding the tables only split-base arithmetic can see (2026-07-27)

Rewriting the split-base idiom to `LOW()`/`HIGH()` covered the 270 sites whose
address already carried a label. The other 130 gated sites pointed at 119
addresses **nothing in the analysis had ever seen** -- that is the point of the
idiom: the address is never a word, so no pointer pass, no slot table and no
`dw` reaches it. 72 of them were in bank `$17` alone.

`split_base_targets` now yields them during naming, exactly like a pointer
load's target, so the tables get labels and the rewrite then covers their
sites too: **270 -> 389 symbolic halves over 343 distinct tables**.

Two failures taught the guards, and both were link errors rather than anything
a review would have caught:

* **Data only.** The first version accepted a hit inside code. The idiom builds
  a table base, so that is a false positive by construction -- and naming an
  offset inside a routine re-parents any curated local after it into a region
  whose label lines are never emitted.
* **LabelScopes has to see the cut labels.** `Table_14` is a 12-byte table
  addressed at three different offsets, so the new labels split it into
  `Table_14` / `Data_14_64d9` / `Data_14_64dd`. The curated local
  `.scriptRespawnLocationActors` that follows was still being *spelled*
  `Table_14.scriptRespawnLocationActors`, because LabelScopes only saw the
  labels from naming and not the ones emit was about to generate for cut
  points. It now seeds them before resolving scopes. This was a latent bug in
  every cut label, not just these.

Structured source is 421,788 bytes over 4,908 blobs; `make compare` OK from
clean and `make check` passes.

## RAM the new table names identify (2026-07-27)

Naming 343 tables made a class of RAM variable identifiable: **the byte that
indexes a named table is defined by that table**. 73 unnamed addresses feed
one, 47 index exactly one. Fourteen are now named, each read before naming.

From the index relation:

* `wStorySceneAssetIndex` (`$cb6d`) -- `RunStorySceneByMode` stores it from `c`
  and every `LookupScreen<N>AssetId` indexes its own `Screen<N>AssetIdTable`.
* `wTrophyExpGroup` (`$d038`, WRAM 6), `wResultScreenMode` (`$d801`, WRAM 3),
  `wRulesScreenAnimFrame` (`$dc00`, WRAM 3) -- each scoped to the bank
  `compute_wram_bank` proves at every one of its sites.
* `wShotRecoilVariant` (`$c4a1`) -- `ApplyShotTypePresets` stores it out of a
  `ShotTypePresets_07` record; `ApplyShotRecoil` indexes `ShotRecoilVarPtrs_07`.
* `wCharInputSource`/`wCharInputBits` (`$df1e`/`$df1f`) in the per-character
  struct: the first picks a handler from `CharInputPtrs`, the second is the
  word `ReadCharPadInput` builds from `hPlayerInputFlags` and
  `hInputRisingEdge` -- confirmed by `StartCharSwing` testing `PADB_RIGHT` on it.

Three serial-link bytes went into the `$ffd0-$ffef` union's default variant:
`hLinkTransferDone` (`$ffd7`, set by `SerialHandler`, spun on by
`WaitSerialTransfer`), `hLinkExchangeActive` (`$ffd8`, non-zero across a block
exchange -- which is why `AdvanceFrame` skips the SELECT+START single-step
while it is set) and `hLinkCursorPage` (`$ffe3`). The overlay is what makes
these safe: inside the sound driver's range the same bytes still render
`hSndLengthAccum`/`hSndVolume`/`hSndPeriodLo`, so a global name would have been
wrong in one subsystem or the other.

Runs of consecutive unnamed addresses find structures rather than scalars. Two
resolved completely:

* `$cb12`-`$cb19` is the scrolling menu background: two lanes with a Y, tile
  and attribute each (`wMenuBgScrollY`/`Tile`/`Attr`, size 2), a shared
  `wMenuBgScrollX`, and `wMenuBgScrollLane` alternating which lane
  `TickMenuBgScroll` queues.
* `$c714`-`$c716` is the debug flag editor's cursor, and the arithmetic names
  the fields exactly: `DebugToggleSelectedFlag` computes
  `wDebugFlagPage * 64 + wDebugFlagByte * 8 + wDebugFlagBit`, which is the
  game's own `byte * 8 + bit` flag numbering.

Two signals turned out to be exhausted: no unnamed address is used with a named
constant (those all already have names), and the remaining single-table indexes
point at auto-named `Data_*` tables, which name nothing. 754 -> 733 distinct
unnamed RAM addresses; the rest need per-address reading.

## Checking the RAM names against the running game (2026-07-27)

The names above were derived from the code. BizHawk can say whether they are
*true*, which is a different question, and it also answers ones static reading
cannot.

**`wMenuBgScroll*` confirmed live.** On the main menu, `$cb12`-`$cb19` reads
`19 8f 00 00 00 01 01 01`: two different lane Y values, both attributes `$01`
exactly as `InitMenuBgScroll` sets them. Stepping a single frame gives
`18 8e 00 00 00 01 01 00` -- both lane Ys decremented and the lane toggle
flipped, which is precisely what `TickMenuBgScroll` claims to do. On the title
screen the whole block is zero, so the scroll belongs to the main menu, not the
title.

**SVBK reads `$fb` on the menus** -- WRAM bank 3, the bank `compute_wram_bank`
had proved statically for `wResultScreenMode` and `wRulesScreenAnimFrame`.

**`$c294` turned out to be dead.** Watching `$c290`-`$c29f` across a screen
change showed `$c295` moving `$0a` -> `$02`, which is `wStoryModeEntryPoint`
being reused during the transition -- a false lead, but it put `$c294` under a
microscope. It is written **204 times and read zero times, in any form**:
every one of those writes is immediately followed by the same value going to
`wStoryModeExitLocationRequest` at `$c2a1` (the single apparent exception just
reloads `$ff` into `a` between the two stores). It is a write-only mirror, so
it is now `wUnusedExitLocationMirror` -- worth naming precisely because it
tells anyone modifying story transitions not to bother with it.

A caution for future sessions: the emulator free-runs between MCP calls, so the
first navigation attempt overshot the title screen into the attract intro.
`pause_emulation` makes stepping exact -- after it, a 120-frame step advances
the counter by exactly 120.

## Driving story mode to find the EXP screen's structure (2026-07-27)

Loading the story save (Alex, LV99) drops straight into the EXP award screen,
which is where the `$d15x`-`$d18x` block lives -- 432 references that static
reading had not attributed.

The live read pinned the bank before anything else: SVBK is `$fe` there, so
**WRAM bank 6**, which `compute_wram_bank` agrees with (159 of 171 accesses to
that range are bank 6) and which `RunExpDistributionLoop` states outright with
`wram_bank $06`. Reading `$d154` at that moment gave `$15` while the screen
read "EXP Pts 21".

Note for anyone repeating this: SVBK is back to bank 3 at every frame boundary,
because the EXP routines switch to 6 and back *within* a frame. Stepping single
frames never catches bank 6, so the useful read was the opportunistic one taken
as the screen loaded, and everything after it had to come from the code.

What the code then gave up is a structure rather than a scalar.
`CheckExpLevelUp` selects `$d169` or `$d178` on `wStoryCharacterSlot`, 15 bytes
apart; `InitExpScreenCharStats` fills `$d161`-`$d16f` from a `ld de, $d161`
base; and `DrawExpScreenLevelNumber`, `DrawExpScreenLevelBar` and the
`SweepExpBarMarker*` pair use `$d161`/`$d170` and `$d164`/`$d173`
interchangeably. That is two 15-byte per-character records, now
`wExpScreenCharStats` (size 30) as a WRAM-bank-6 variant of the `$d100`-`$d21a`
union the sound engine already shares. 113 sites render through it, and the
stride is visible on the page:

```
        ld hl, wExpScreenCharStats + 6
        ld hl, wExpScreenCharStats + 21
        ld hl, wExpScreenCharStats + 12
        ld hl, wExpScreenCharStats + 27
```

`$d0b6` was tempting -- the EXP loop tests and clears it -- but bank `$1c`'s
character-data screen uses it too, so it is shared state rather than an EXP
flag, and it stays unnamed until that is pinned down.

## Walking around the overworld to finish a struct (2026-07-27)

Story mode reached (Alex, LV99, dorm room), and moving the player is enough to
identify overworld state directly. Reading `$c2a0`-`$c2ff`, walking right for
40 frames and reading again changes exactly three bytes; walking down changes a
different pair. The values name themselves:

| address | right | down | meaning |
| --- | --- | --- | --- |
| `$c2d1` | `$0b` -> `$0d` | unchanged | X, high byte of an 8.8 position |
| `$c2d3` | unchanged | `$0d` -> `$12` | Y |
| `$c2d4` | `$c0` -> `$00` | `$00` -> `$40` | facing: `FACE_UP`, `FACE_RIGHT`, `FACE_DOWN` |

The coordinate space is the one the actor scripts already use --
`script_move_player $0b00, $1100` writes exactly these units -- and `$c2d0`
/`$c2d2` turned out to be `wStoryModePlayersXPosition`/`YPosition` already,
so the live read confirms two existing names.

`$c2d4` was the unnamed third member, and the code agrees once you know to
look: `UpdateActors` copies four bytes (X and Y) out of the player actor at
`$d00c` into `wStoryModePlayersXPosition`, then copies the actor's `$d032`
straight into it. It is `wStoryModePlayerFacing`.

That also exposes two fields of the actor record itself -- `+$0c` position,
`+$32` facing -- inside the `$d000`-`$d029` block (432 references) that is
still unmapped; naming those needs the actor engine's WRAM bank pinned first.

Navigation notes for next time: a button held across `step_frames` can register
as two presses in menus (an 8-frame A press walked past the screen I wanted),
so tap with 2-3 frames; and `pause_emulation` does not survive very long steps,
where the emulator free-runs anyway.

## The two blocks that were used but never named (2026-07-28)

`ram/wram.asm` opened at `$c0a0` and `ram/hram.asm` at `$ff8a`. Neither was a
region base -- both were just the lowest address anyone had named, and the gap
below each was in constant use.

`$c000`-`$c09f` is **shadow OAM**, and the DMA trampoline names the page. Ten
bytes at ROM0 `$06ba` are copied into `$ff80` by `CopyOAMDMARoutineToHRAM`:

```
        ld a, $c0
        ldh [rDMA], a
        ld a, $28      ; 40-iteration wait
```

The length is confirmed independently by the boot path, which clears the
buffer as its own unit (`ld hl, $c000` / `ld c, $0a` / `ClearMemory16` = 10 x
16 = 160 bytes = 40 OAM entries) separately from the `ld c, $ff` bulk clear of
`$c000`-`$cfef`. So `wShadowOAM` (160 bytes) and `hOAMDMARoutine` (10 bytes).

Neither had shown up in the unnamed-address counts, because shadow OAM is only
ever written through pointers -- there is not one direct `[$c0xx]` operand in
the ROM.

**Naming them found the double buffer.** With `$ff80` symbolic, the VBlank path
reads:

```
        ld a, [wSpriteBufferPage]
        xor a, $05
        ldh [hOAMDMARoutine + 1], a
        call $ff80
```

which patches the trampoline's `ld a, $c0` operand in place every frame,
toggling the DMA source between page `$c0` and page `$c5`. There is a second
160-byte OAM buffer at `$c500`, and `wSpriteBufferPage` is its selector.

### Round addresses are constants more often than pointers

The first regen renamed 16 sites and **13 were wrong**. `operands.py` treats a
word immediate equal to a named RAM address as a pointer setup, which is right
for `ld hl, DataTable` and wrong for `$ff80`, which is -128:

```
        ld de, $ff80
        add hl, de
        jr c, .returnZero      ; a range clamp, not a pointer
```

Eleven of those, plus the stat-page scroll offsets stored beside `ld de,
$0060`, plus `ld bc, $c000` at `08:$6b5e`, which is a `SetBallVelocityPolar`
magnitude. `RAM_IMM_IS_CONSTANT` in `tools/disasmlib/operands.py` lists the 13
flat offsets that must stay numeric -- keyed by exact instruction offset, the
same shape as `ROM0_FAR_POINTERS`. The bracket form `[$xxxx]` is safe; the bare
`ld rr, n16` form is the one to audit after naming any round address.

### Sections start at region bases now

`write_ram_layout` used to open each SECTION at its first named symbol, so
naming a lower address moved the SECTION directive -- which is what `$c0a0`
and `$ff8a` were. It now always emits the region's own base address and a
leading `ds` for the gap. SRAM went from `SECTION "SRAM $a020"` to `$a000` +
`ds 32`, and WRAMX from `$d038` to `$d000` + `ds 56`; the symbol addresses are
unchanged and the ROM still compares byte-identical.

RAM metadata is not assembled, so none of this moves a byte: `make compare` is
OK and `make check` passes 619 lz / 13 text / 4,908 regions. Identification is
unchanged too -- these 170 bytes were already understood, just not symbolic.
The 660 genuinely unidentified addresses (376 of them in WRAMX) still stand.

## Banked WRAM names itself now (2026-07-28)

`../pokecrystal` names banked WRAM it has not identified `w3_d000`, `w4_d000`,
`w5_dc00` -- bank plus address. The address alone is ambiguous (`$d000` is
eight different variables, one per WRAM bank), so the bank belongs in the name
even when the purpose is not known. We had the bank for a lot of addresses and
were throwing it away: every unidentified banked address rendered as a bare
`$d82e`.

`compute_wram_bank` already proves the bank at most sites. Across every
`[$dxxx]` operand no curated entry claims:

```
unnamed WRAMX addresses referenced: 388
  every site agrees on one bank : 205
  one bank + some unknown sites :  84
  sites disagree (multi-bank)   :  24
  bank never provable           :  75
```

`auto_banked_wram_names` (in `disasmlib/ram.py`) names the 289 with a single
provable bank, minus the 92 that fall inside a curated union's span, leaving
**197 addresses auto-named, covering 929 references**: bank 3: 72, bank 6: 72,
bank 4: 26, bank 5: 23, banks 1/7: 2 each. They are generator output, not
metadata -- derived from the dataflow, regenerated every run, and a curated
name in `ram_map.json`/`ram_unions.json` always wins because covered addresses
are skipped.

Three deliberate restrictions:

* **Only the `[$dxxx]` operand form.** A word immediate that equals a RAM
  address is more often arithmetic -- the lesson `RAM_IMM_IS_CONSTANT` records.
* **Addresses whose sites disagree stay numeric.** All 24 of them: `$df7e`,
  `$df82`, `$df83` are claimed by banks 4, 5, 6 *and* 7, which is the
  per-character struct -- they are new fields of it, not new variables.
  `$d000`-`$d003` are mostly bank 6 but have bank 1/2/3 sites, and
  `$d820`-`$d831` split between 5 and 3. Those want a human.
* **Registered scoped, not globally.** A site whose bank is not provable still
  renders the bare address. 64 addresses therefore appear both ways in the
  source (`ld a, [w3_d811]` in one place, `ld a, [$d811]` in another, 530 such
  references): the raw spelling marks exactly where the dataflow gives out.

Distinct raw WRAMX addresses in `src/`: 398 -> 265.

**The actor block is bank 6, mostly.** STATUS said naming the `$d000`-`$d029`
actor record "needs the actor engine's WRAM bank pinned first". Every provable
site on `$d004`-`$d029` says bank 6, and those are named now -- but `$d000`
through `$d003` are exactly the contested ones (43 bank-6 references against 5
from bank 2, 2 from bank 1, 2 from bank 3), so the record's first four bytes
are reached from more than one bank and the question is only half answered.

The 92 skipped addresses are the next increment: they sit inside curated union
spans (mostly `$d100`-`$d21a`, where the bank-6 EXP-screen variant is one
symbol wide against the sound engine's seventeen), so naming them means
extending those union variants by hand rather than auto-generating into a
UNION block, where a symbol would belong to one variant instead of all of them.

`make compare` OK, `make check` clean -- RAM naming is text and cannot move a
byte.

## One SECTION per WRAM bank (2026-07-28)

Auto-naming 197 banked addresses made `ram/wram.asm` harder to read, not
easier: one address-ordered list from `$d000` to `$dfff` interleaving six
banks, where `w3_d814` sits between `w6_d80f` and `w5_d820` and nothing groups
them. WRAMX is emitted one SECTION per WRAM bank now:

```
SECTION "WRAMX bank 1", WRAMX[$d000], BANK[1]
SECTION "WRAMX bank 3", WRAMX[$d000], BANK[3]
SECTION "WRAMX bank 4", WRAMX[$d000], BANK[4]
SECTION "WRAMX bank 5", WRAMX[$d000], BANK[5]
SECTION "WRAMX bank 6", WRAMX[$d000], BANK[6]
SECTION "WRAMX bank 7", WRAMX[$d000], BANK[7]
SECTION "WRAMX banks 4-7", WRAMX[$df00]
```

Each bank's section owns the whole region and opens at `$d000`; RGBDS is happy
to place several WRAMX sections at the same address in different banks, which
is exactly what the hardware does.

**A union whose variants sit in different banks now splits across them.**
`$d100`-`$d21a` was a UNION only because the sound engine (bank 7) and
`wExpScreenCharStats` (bank 6) overlap in address. Once the banks separate
them the addresses no longer collide, so each side keeps only its own variants
and lands in its own section. That was the one union that existed purely as a
bank artifact.

**What cannot be split stays honest.** The per-character struct
`$df00`-`$df96` is one copy in each of banks 4-7 simultaneously -- 34 symbols,
and RGBDS has no way to say "this address, in four banks". It goes to a
`BANK`-less section that the linker parks in a free bank, with a comment saying
why. The same applies to the ROM-scoped `wTextArgFetchBuffer` variant. This
section opens at its first symbol rather than `$d000` so it fits alongside a
banked section instead of competing for a whole bank.

The bank comes from `wram_bank` on the `ram_map.json` entry (added to the ten
text-engine symbols, all WRAM 5), from a union variant's `wram_bank` scope, or
from the dataflow for an auto-named symbol. A WRAMX entry with no bank now
warns -- there are none.

Byte-identical, `make check` clean. Note that a bank recorded here is not
checked by anything: nothing in the source calls `BANK()`, so a wrong
`wram_bank` places a section silently. It has to be earned from
`compute_wram_bank` or a hook capture, same standard as a name.

Following from that: **`UNION` is now emitted only for a range that actually
has overlapping variants.** A range left with one -- either it always had one,
or splitting by WRAM bank gave each bank its own -- emits its symbols plainly.
Eleven of the fourteen blocks were single-variant wrappers declaring an overlay
of one thing against nothing. Three real overlays remain, and all three are
genuine: the `$ffb0`-`$ffb3` HRAM pointer scratch, the shared HRAM scratch pool
(serial/sound/sprite/actor), and `$df00`-`$df96`, where the per-character
struct and the menus' `wTextArgFetchBuffer` really do share bytes.

The scoping is untouched by this -- it lives in `ScopedRamNames` and decides
which name renders at a site. `UNION` was only ever the layout half, i.e. how
overlapping variants share addresses; a single variant never needed it.

## SRAM is banked too (2026-07-28)

`SRAM is 4 banks of 8 KiB` (docs/save_format.md), selected exactly the way WRAM
is -- `ldh [hSramBank], a` beside `ld [$4000], a`, the MBC RAM-bank register --
and the block directory stores an SRAM bank per block, so `$a000` means four
different things. The layout said nothing about it.

`BANK_KEY` now names the json field that gives a symbol's bank per region
(`wram_bank` for WRAMX, `sram_bank` for SRAM), and everything downstream --
grouping, the per-bank SECTION, the missing-bank warning -- is driven off that
map rather than off `mem == "WRAMX"`. SRAM emits as:

```
SECTION "SRAM bank 0", SRAM[$a000], BANK[0]
```

The bank sits on the *union*, not on a scope, and that difference is real: a
`wram_bank` scope both places the section and narrows which sites the name
renders at, because `compute_wram_bank` proves the bank per site. Nothing
proves the SRAM bank per site -- the save engine sets it by hand around each
block copy -- so `sram_bank` only names the section. Inventing an
`sram_bank` *scope* would imply a matcher that does not exist.

All six SRAM symbols are the bank-0 header, flag array and block directory, so
there is one section today. The point is the other three banks: the directory
addresses blocks in banks 0-3 (and nominally 4-14, which the MBC masks back
down), and when those blocks get named they will land in their own sections
instead of colliding at `$a000` with the header.

No `compute_sram_bank` to match `compute_wram_bank`, and no case for one yet:
exactly one unnamed `$axxx` address is referenced by a direct operand in the
whole ROM. The save engine reaches SRAM through `hl`, the same reason shadow
OAM never appeared in the unnamed counts.

## The DMA routine's ROM copy (2026-07-28)

`hOAMDMARoutine` named the HRAM destination but not the source. The ten bytes
at ROM0 `$06ba` -- data to their only reader, which copies them into HRAM to be
executed there -- had no label, so the copy read `ld hl, $06ba` and the call
read `call $ff80`. Both ends are symbolic now:

```
CopyOAMDMARoutineToHRAM:
        ld c, $80
        ld b, $0a
        ld hl, OAMDMARoutine
...
        ldh [hOAMDMARoutine + 1], a
        call hOAMDMARoutine
```

Two mechanisms, because the two operand forms deserve different trust:

* `IMM_CODE_POINTERS` (`operands.py`) is curated per site, like
  `ROM0_FAR_POINTERS` and `RAM_IMM_IS_CONSTANT` beside it. A word immediate
  that equals some routine's address is usually a constant -- `$ff80` is -128 at
  thirteen sites in this same ROM -- so a code label is never inferred into one.
* A **branch** target that is not a ROM offset now resolves against the RAM
  names generally, no curation. `call`/`jp` operands are unambiguous in a way
  immediates are not: the operand is always an address, and no ROM offset can
  collide because `target_to_offset` resolves those first. `call $ff80` was the
  only such site in the ROM, which is why the diff is three lines.

### The destination was hiding in the same routine

`ld c, $80` is the other half of the same copy -- the routine reaches its
destination through `ldh [c]`, so the address is never written down and `$80`
is `LOW(hOAMDMARoutine)`. `LOW_BYTE_SITES` renders it, and a sweep for the
shape found the whole class is five instructions in the ROM, all in bank `$00`:

| site | was | is |
| --- | --- | --- |
| `$028b` | `ld c, $6b` | `LOW(rOBPD)` -- 64 bytes out through the palette port |
| `$06ac` | `ld c, $80` | `LOW(hOAMDMARoutine)` |
| `$354c`, `$3690` | `ld c, $30` | `LOW(_AUD3WAVERAM)` -- 16 bytes of wave pattern |
| `$2592` | `ld c, $80` | left numeric |

`$2592` is the interesting one. `SoftReset` sets `c` to `$80` and `b` to `$70`
and walks `ldh [c]` over all of HRAM; the first byte it clears *is*
`hOAMDMARoutine`, so `LOW(hOAMDMARoutine)` would assemble correctly and read as
a claim the code does not make. It stays `$80`. That asymmetry is why these are
curated rather than inferred from the `ld c, N` ... `ldh [c]` shape, which is
otherwise perfectly detectable -- the byte cannot say which symbol it is the low
half of, and at one site in five the honest answer is "none of them".

This is a different mechanism from `_resolve_split_base` in `emit.py`, which
rewrites the `add LOW(x)` / `adc HIGH(x)` pair: there the two halves
corroborate each other into a full address, which is what lets that one be
inferred from shape. Here the high half is implicit in the `ldh`, so there is
nothing to corroborate.

Still not done: `ld b, $0a` would read better as
`OAMDMARoutineEnd - OAMDMARoutine` (pokecrystal's idiom, and recomputed layout
rather than a magic length), but `labels.json` is one name per address and
`$06c4` is already `JumpTableDispatch`, so there is nowhere to put the end
label. The sound driver's `ld c, $12` / `ld c, $11` (`rAUD1ENV` / `rAUD1LEN`)
are a related judgement call left alone: there `c` is a channel-1 register
index that `wSndRegBase` is added to, not an address being used as one.

`make compare` OK, `make check` clean.


## The screens were all sharing one block of RAM (2026-07-28)

Splitting WRAMX by bank left 3,496 raw `[$xxxx]` WRAM operands in `src/`, and
the shape of what was left only became visible once the layout said which bank
each address belonged to. They are **not one variable each**. Two blocks --
`$d000`-`$d3ff` and `$d800`-`$d83f` in WRAM bank `$03`, and the same addresses
again in banks `$05` and `$06` -- are *screen-local scratch*: every full-screen
UI in the game reuses them for whatever it needs, and the same byte is a
different variable in each bank and often in each screen of the same bank.

`ld hl, $d800` appears in ten ROM banks. In bank `$38` it is the name being
typed; in bank `$3e` the list of rackets you own; in bank `$18` an object
array; in bank `$1b` a decompression staging area. Bank `$17` writes
`$d810`-`$d82e` as a sprite parameter block, bank `$16` uses `$d810` as a digit
buffer, bank `$05` keeps the menu cursor at `$d830`. None of that is visible
from an address.

**So the names are scoped to the owning ROM bank, not the WRAM bank.** That is
the opposite of what the previous pass concluded for `wSndChannels` and
`wExpScreenCharStats`, and for a specific reason: those subsystems select their
WRAM bank at the reference, so `compute_wram_bank` proves it. A screen selects
its bank once, in a callee -- `LoadCourtDiagramScreen` does `wram_bank $03` and
returns, so the bank is not provable anywhere in `ShowCourtDiagramTestScreen`
even though every `[$d81x]` in it is bank `$03`. A `{"bank": "0x17"}` scope
names all 527 of them; `{"wram_bank": "0x03"}` would name almost none. Where
one ROM bank runs several screens the scope narrows further to a code range
(`{"bank": "0x3e", "start": "0x5400", "end": "0x5c00"}` for equipment select,
so the erase-data screen's own use of `$d800` two thousand bytes earlier is
left alone).

### What the blocks turned out to be

**Drill briefings (bank `$17`, WRAM bank `$03`).** `ShowCourtDiagramTestScreen`
is a debug screen that walks the whole block: it seeds a pair of bytes, then
registers the drawer that reads them as a frame task, over and over. That makes
the layout read straight off:

```
        ld a, $50
        ld [wBriefingPlayerX], a
        ld a, $40
        ld [wBriefingPlayerY], a
        ld a, $01
        ld hl, DrawBriefingPlayerSprite
        call RegisterFrameTask
```

Eleven such pairs (player, opponent, ball, two poles, four markers, the swing
animation, the target bracket), plus the flip selectors that pick each marker's
OAM attribute, `wBriefingBracketWidth`/`Height` -- the four corner sprites sit
at X, X+width+3 and Y, Y+height-5 -- and the `wBriefingAnimTimer` /
`wBriefingAnimStep` pair that every `DrillBriefing_*` sequence ticks at `$78`
frames and wraps `and $03`.

**Window and menu engine (bank `$05`, WRAM bank `$05`).** `wMenuStack` at
`$d832` is the find here: six two-byte frames indexed by `wMenuDepth * 2`,
holding `[wMenuRowCount << 4 | cursor row, window id]`. Pushing is three
instructions in `CreateMenuWindowFromText`; the unwind reads back the packed
byte, `and $0f` for the cursor and four `sra a` for the row count. That is how
backing out of a submenu puts the cursor back where its parent left it, and it
is invisible while the addresses are numeric. Beside it:
`wDialogueWindow{Id,Col,Row,Width,Height}`, `wGlyphWindowId`, and
`wTextRedrawGuard`, which is why `TextCmdDelay30` can call
`RedrawActiveTextWindow` without recursing through its own delay.

**Character-data screen (WRAM bank `$06`).** `wCharDataStats` is eleven bytes
loaded from story-record `+$20`-`$2a` with 1 added to each, in the order
`wStoryModeMainCharacterTopStat` onwards; `wCharDataStatDeltas` is eleven more
right after it, filled by `ComputeLevelUpStatDeltas`, one up/down arrow each.
`wCharDataChoiceLog` is 100 bytes recording which of the four stats the player
picked at every level-up of the visit, appended one byte at a time by the input
loop.

**Character-select grid (bank `$38`)**, **equipment select (bank `$3e`)**,
**match results (bank `$16`)**, **name entry (bank `$38`, `$6e00`-`$7500`)`**
and the **ranking board** each got their own variant of whichever half they
use.

### Two corrections the pass forced

`wResultScreenMode` was scoped `{"wram_bank": "0x03"}` and nothing else. That
is a *nine-bank* claim: `$d801` renders as `wResultScreenMode` anywhere WRAM
bank `$03` is provable, and banks `$00`, `$18`, `$1a`, `$38`, `$39`, `$3b`,
`$3e`, `$6b` and `$1b` all mean something else by it -- bank `$1b`'s ranking
board reads it as "singles or doubles". It is scoped to bank `$16` now. The
general rule that came out of it: a `wram_bank`-only scope is right for a
subsystem that owns its bank outright, and wrong for a block that many
subsystems share, which is most of `$d000`-`$d8ff`.

The other is a generator hazard. A union that *overlaps* another union does not
error -- `_group_by_bank` buckets them by bank and `_emit_section` fills the gap
after each one from its own `end`, so the second union's symbols are emitted
after the first instead of inside it. `wCharDataChoiceLog`'s 100 bytes span
`$d038`, where the trophy-EXP union already sat, and the result was
`wTrophyExpGroup` landing at `$d08e`, everything after it shifted up 86 bytes,
and **369 changed ROM bytes** in five banks. RAM metadata is not assembled, but
the symbol *values* are, so a layout mistake is a real byte mistake. `make
compare` caught it immediately; the two are now one union with the accumulator
as a bank-`$1e` variant.

### WRAM0 as well

The same pass took the flat region while the call sites were open.
`wMapSceneStage` (462 references) is the biggest single name in the ROM's RAM:
each story location's init script derives it from the save flags
(`SetupCenterCourtSceneVariant`, `ComputeIslandOpenRound`,
`SetStoryRankSceneIndex`, ...) and every NPC at that location indexes its own
per-stage text-id table with it, which is the whole mechanism by which one NPC
says a different line as the story advances.

The bank `$0b` drill block came with it -- `wDrillTargetZoneHitBits` and
`wDrillGateCrossBits` (one bit per point of the drill),
`wDrillShotResultBits` (two bits per shot, which bank `$06` draws as the
scoreboard pip rows), `wDrillMessageId`, and `wDrillLessonResult`, which is how
the bank `$15` training-court coaches know which follow-up line to speak after
a lesson -- along with the minigame-kind flags at `$c7b8`-`$c7bc` that the
shared match engine branches on (`wMinigameUsesTennisMachine`,
`wMinigameUsesWall`, `wMinigameHighScoreMode`, ...), the bank `$0d` minigame
scratch (`wMinigameHitStreak`, which indexes both a sound table and a score
table so a longer streak sounds different and is worth more), the overworld
camera clamp (`wMapWidthTiles`/`wMapHeightTiles`, confirmed by the `- $14` and
`- $12` the clamp subtracts for the 20x18 screen), and `wActorScriptBank`,
which every `ActorScriptOp_*` passes to `FarReadByte`.

Raw `[$xxxx]` WRAM operands in `src/`: **3,496 -> 1,560**, over 476 distinct
addresses, and 400 more addresses moved from the generator's `w<bank>_<addr>`
placeholder to a real name. `make compare` OK, `make check` clean.


## The match character struct, field by field (2026-07-28)

The per-character struct at `$df00` -- one copy in each of WRAM banks `$04`-`$07`
-- had 34 named fields and about 190 references still numeric. It is the
densest single structure in the ROM, and the call sites name most of it for you
once you read the routines that own each group.

**The animation format falls out of two routines.** `SetCharAnimation` and
`StepCharAnimation` between them define it:

```
wCharAnimTablePtr   -> indexed by wCharAnimId, in wCharObjectBank
wCharAnimScriptBase -> where $ff (rewind) jumps back to
wCharAnimScriptPtr  -> cursor; commands are words:
                         < $f0  [delay, frame]
                         $ff    jump to base + d
                         $fe    switch animation
                         $fb    xor d into the flip bits of wCharSpriteAttr
```

A frame change sets bit 6 of `wCharSpriteDirty`, which `ReloadCharFacingTiles`
clears after uploading. `wCharSpriteAttr` is doing double duty and that is worth
saying out loud: its low three bits are the CGB OBJ palette (`wCharIndex + 4`)
*and* the VRAM tile-block index `ReloadCharFrameGfx` uploads into (`& $07`,
`+ $08`), while the high bits are the flip bits the `$fb` command toggles and
`SetCharAnimation` clears with `and $0f`.

**The shot buttons are a 2-D table index.** `wCharShotButton1` and
`wCharShotButton2` are the two presses inside `wCharShotComboTimer`'s five-frame
window, and the pair indexes `RallyShotTypeTable0/1` -- which is how A+B
combinations become lobs, drops and power shots. `wCharBallReachFlags` bit 4
picks between the normal table and the stretching one, so the same buttons mean
a different shot when you are reaching.

**The AI's personality is six bytes of the character record.** `+$0f` and
`+$1b`-`$1f` become `wAiPositionStrategy` (an RST00 index -- baseline, net, or
mid-court), `wAiReactionDelayNear` / `wAiReactionDelayFar` (separate, so a
stretching return can be made deliberately slower than a comfortable one),
`wAiTrackingParam`, `wAiAimAwayChance` (an RNG threshold: higher places more
shots away from the opponent) and `wAiServeStyle`. That this is exactly the
block `OverrideCharStatsForDebug` rewrites is the corroboration.

**A correction.** `$df22` was `wCharActive`. It is the ROM bank of the
character's object data: `GetPerspectiveScale` writes it straight to `hRomBank`
and `$2000`, and `SetCharAnimation` passes it to `FarReadWordDI`. It is
`wCharObjectBank` now, and the zero test `UpdateChar` exits on is "no object
loaded" rather than an active flag.

**The scope grew too.** The nine shot banks (`$20`-`$24`, `$29`-`$2c`) and the
results/EXP screens read the struct with the WRAM bank already selected by their
caller, so `compute_wram_bank` cannot prove it and every field read as numeric
there. Adding their ROM banks named 54 more references without changing what a
single address means -- the same lesson as the screen blocks: a `wram_bank`
scope needs a subsystem that selects its own bank.

### The water-sprite names were three cells of a shared block

`wWaterSpriteMinigameTimer`, `wWaterSpriteMinigameSwingCount` and
`wWaterSpriteMinigameFlag` came from the RetroAchievements notes and sat in
`ram_map.json` at global scope. STATUS flagged them as mis-scoped twice and left
them "pending its own pass". They are `$c2b4`/`$c2b6`/`$c2ba`, three bytes of the
`$c2b0`-`$c2bf` location scratch block, and 25 references in banks
`$0e`/`$0f`/`$10`/`$13`/`$14` carried a name for a minigame they have nothing to
do with.

What is there is an overlay of two shapes, which is also why the old names
looked 16-bit:

| | bank `$14` island cutscenes | bank `$15` swing contest |
| --- | --- | --- |
| `$c2b2` | `wCutsceneObjX` [2] | — |
| `$c2b4` | `wCutsceneObjY` [2] | `wSwingContestTimer` [16-bit] |
| `$c2b6` | `wCutsceneObjPhase` [2] | `wSwingContestSwings` [16-bit] |
| `$c2b8` | `wCutsceneObjTimer` [2] | `wSwingContestPrevInput` |
| `$c2ba` | `wCutsceneObjLimit` [2] | `wSwingContestHudMode` |

The cutscene side is **two sprite slots as parallel byte arrays** -- X, Y,
phase, timer, limit, rise timer, active, each a two-byte array indexed by slot.
The water splashes use both slots; the fireworks use the same seven fields for
their own version of the same roles; the plane sequence has no second object, so
it borrows slot 0's X byte as a frame counter. The contest side is two 16-bit
counters over the same bytes, which is exactly the pair the RA notes recorded.
Both are variants of one union now, and the scratch use in the other four banks
is numeric again rather than wrong.

### wShadowTilemap, and the cells

The full-screen UIs assemble their BG map at `$d000` in WRAM bank `$03` and
`QueueVRAMCopy` it to `$9800`; `wShadowTilemapBank` / `wShadowTilemapPtr` point
the text engine at it (bank `$03` for screens, `$05` for text windows, `$02` for
the match). Rows are `$20` cells apart, so a cell is `$d000 + row * $20 + col` --
which is what hundreds of `$d0xx`-`$d3xx` addresses across the screen banks
actually are, and the attribute plane is the same geometry `$400` higher
(`CopyTilemapRect` steps rows by `$0020`; `SetWinLosePortraitPaletteAttrs`
writes `$d48b` for the cell whose tile byte is `$d08b`).

**The cells render as coordinates.** `ld de, $d151` is a tilemap cell and says
so to nobody, and there are ~760 of them. They are now

```
        ld [wShadowTilemap + 19], a
        ld [wShadowTilemap + 4 * TILEMAP_WIDTH], a
        ld [wShadowTilemap + 4 * TILEMAP_WIDTH + 19], a
```

which is `BuildResultsScreenPanels` drawing a box at columns 0 and 19 of rows 0
and 4 -- six stores that read as six unrelated addresses until the arithmetic is
written down.

A pokecrystal-style `hlcoord` macro cannot serve here, and it is worth saying
why: RGBDS has no expression-returning macro, so `hlcoord` is a *statement*
macro that emits the whole `ld hl, ...`. These addresses also appear as
`ld [addr], a` and inside the `dw` rows of `tilemap_rect`, which such a macro
cannot reach. A folded expression is the one form every operand position
accepts, and rgbasm reduces it to the same word -- so `make compare` still
checks the arithmetic, which is the reason to write it out rather than
precompute it.

The mechanism is a `stride` entry on a `ram_unions.json` symbol, carrying both
the constant to multiply by and the value to divide by so a wrong pairing cannot
hide. Only the two tilemap planes use it. Not every screen pairs the planes this
way -- the bank `$03` cutscenes keep the attribute plane at `$d000` in WRAM bank
`$02` -- which is why the names are scoped to a provable WRAM bank `$03` rather
than to the addresses.

The four bytes below the character-data screen's working set turned out to be a
smaller scratch three screens overlay, so they took range-scoped variants: the
debug character viewer (`wCharViewerRow` toggles with `xor $01` between the
character grid and the palette row, and `wCharViewerSavedCursor` is why coming
back lands on the same character) and the results continue prompt.

Also this pass, in WRAM0: the four saved menu cursors at `$cb1b`-`$cb1e` -- how
each menu reopens where you left it, and why they are cleared together when a
new game starts -- `wSelectedMinigame`, the tennis dictionary's mascot animation
pair, `wDrillGateActive`, and `wShotAimRow`, an aim index every shot bank stores
and none reads (the value is used from `a`, so the store is a leftover).

### Earning a WRAM bank from the dispatcher

Bank `$0d`'s minigame actors are eight 16-byte records at `$dc00`-`$dc7f`, and
the layout comes straight off the three helpers, which all address a record
through `bc`: `+$00` flags, `+$02` state, `+$03` timer, `+$06`/`+$08` world
position, `+$0a`/`+$0c` the projected screen position, `+$0e` handler pointer.
`ClearMinigameActors` clears exactly seven of them; the eighth is the object the
minigame itself drives -- the shot target, the Boo, the treasure box -- and the
only one the code addresses by literal address, which is why
`wMinigameSceneActor`'s fields render as `+ n`.

The WRAM bank was the obstacle, and it is worth writing down how it was
resolved, because `compute_wram_bank` cannot help here at all: the minigame
hooks are reached through a far pointer, so no dataflow edge reaches them. Bank
`$0d` never executes `wram_bank $03` and the references disagree. But the
*dispatcher* does: `RunMinigamePointLoop` and `UpdateMatchFrame` in bank `$08`
both `wram_bank $04` immediately before `CallModeHook`, and
`ClearMinigameActors`, `SetMinigameActorHandler` and `SetMinigameActorPosition`
each select it again on entry. The bank is a property of how the code is
*called*, and reading the caller is as good a proof as reading the reference.
That is a different move from the screen blocks above, where the fix was a
ROM-bank scope because the bank was selected in a callee; here it is selected in
the caller, and the answer only shows up if you go looking one frame up the
stack.

Raw `[$xxxx]` WRAM operands in `src/`: **1,560 -> 1,012** over 390 distinct
addresses, ~760 tilemap cells now carry their row and column, and 25 mislabelled references are gone. `make compare` OK, `make
check` clean.


## A maths table is not a pointer table (2026-07-28)

`TangentTable` and `NotePeriodTable` were declared `records:2`, which routes a
table through `render_pointer_words`. In ROM0 that renderer resolves *any* word
below `$4000` against the label map -- correctly, because ROM0 pointer tables do
hold ROM0 addresses. The consequence for a table of numbers:

```
        dw VBlankInterrupt ; record 40      <- a tangent of $0040
        dw ClearVRAMCopyQueue ; record 10   <- an APU note period of $0465
```

Seven rows across the two tables. Both assemble to the right bytes, which is why
`make compare` never objected and why the earlier pointer pass counted only
*one* problem here (record 254's `$62ca`, which stayed bare): a row that
resolves to a label is not a bare address, so the metric that found the tail
could not see the head.

The corrected values corroborate themselves. The tangent table is monotonic
again across records 39-41 (`$003e`, `$0040`, `$0041`), and `$0465` sits where
it belongs between `$04a8` and `$0426` in the semitone sequence -- the false
labels were interruptions in two obviously smooth series.

`words:N` is the declaration for a table of numbers: the same `dw` rows, no
label lookup. Only these two tables need it, and the reason is worth keeping.
A *banked* table resolves a word only when it lands in `$4000`-`$7fff`, so a
maths table in a banked ROM is safe by accident. ROM0 is where the eagerness
bites, and it bites hardest on small values -- which is exactly what a lookup
table near zero is made of. A sweep for the signature (a `records:2` table where
fewer than a quarter of the rows resolve) finds no others.


## The serial link's half of the shared HRAM pool (2026-07-28)

`InitSerialLink` and `ResetSerialState` clear 22 bytes each, and 14 of them read
as bare addresses. Not because they were unnamed -- the `$ffd0` pool's
sound-driver variant owns every one of them -- but because the serial path is a
*separate tenant* of the same bytes and had no names of its own. The pool's
variants named the sound driver's view and left the link's view literal.

Named into the serial (default) variant: `hLinkTxInput`, which
`SerialEncodeInput` drains a few bits per frame (all four low bits -> `$3f`,
else bit 3 -> `$30`, bit 2 -> `$0c`, else the low pair) so a burst of presses is
sent over several frames; `hLinkTxSeqBits`, the two top bits inverted each frame
and OR'd into every transmitted byte, which is how the peer tells a fresh frame
from a repeat; `hLinkLastRxByte`, which `ExchangeLinkFrameByte*` compares
against for exactly that; `hLinkPayloadKind`, set by the match and story pause
menus so the link sends the payload the current screen expects;
`hLinkPlayerCount`; and `hVBlankSuppressed`, which the resync sets so
`VBlankHandler` does nothing at all while it busy-waits on the serial line.

Three of the cleared bytes are dead, and saying so is worth as much as a name:
`hUnusedLinkByte` and `hUnusedLinkSlot` are written and never read, and
`hLinkErrorFlags` at `$ffc3` is read once -- `AdvanceFrame` tests its top three
bits and resets the link if any is set -- but nothing in the ROM ever sets them.

`$ffe9` is `hMatchFrameCounter`, and getting there took a correction. It looked
like a byte every subsystem clears and none increments -- so, the reasoning went,
what the match renderer reads with `and $0f` and `and $01` is whatever the last
subsystem left behind, and that is more honest left visible than named.

Both halves of that were wrong. It *is* incremented, four times over: bank `$08`'s
local frame driver does it after `AdvanceFrame` + `UpdateMatchFrame`, and all
three link frame drivers in bank `$07` do it too, so the count advances
identically whether the match is local or linked. The increments use
`ld hl, $ffe9` / `inc [hl]`, and the search that missed them had only covered the
`ldh` and `[$ffe9]` forms -- the same bare-`ld rr, n16` blind spot as the
immediates above, this time causing a miss rather than a false name.

The "left over" half was wrong for a better reason. `RunSoundEngine` copies all
32 bytes of the pool out to `$d000` in WRAM bank `$07` on entry and copies them
back on exit. The pool is *context-switched*, not merely time-shared, so a value
living here survives an audio update untouched -- which is what lets a counter
live in it at all.

The readers are cheap periodic effects: `and $0f` cycles the landing marker's
16-frame animation, and `and $01` draws the ground shadow and the
offscreen-character arrow on alternate frames, the usual Game Boy way to fake a
translucent sprite.

### Naming a round address, again

`RAM_IMM_IS_CONSTANT` exists because a word immediate equal to a named RAM
address is usually a pointer setup and sometimes a number. Naming `$ffe0` found
the limit of doing that per site: `$ffe0` is -32, *one tilemap row back*, and it
appears in every blit and slide loop in the game. Twelve new false names
appeared the moment `hLinkTxPending` existed, and a newly carved blit loop would
have quietly acquired more.

`RAM_IMM_NEVER` keys the rule by address instead, for the HRAM bytes whose every
immediate is arithmetic: `$ffa0` (-96), `$ffc0` (-64), `$ffdf` (-33), `$ffe0`
(-32), `$fffd` (-3, an interior byte of `hRandomSeed`). All 43 sites feed
`add hl, rr` or get stored as a 16-bit delta; not one is dereferenced. It has to
stay curated per address rather than become a blanket HRAM rule, because
`ld hl, hActorPtr` is a genuine pointer setup at 82 sites.

**Three of those five were already wrong before this pass** -- `hPeakLY`,
`hLinkRxByte` and `hLinkAckRequired` were rendering at 30 arithmetic sites. The
audit rule stated when `RAM_IMM_IS_CONSTANT` was introduced ("the bracket form
is safe; the bare `ld rr, n16` form is what to audit after naming a round
address") was only ever run against the addresses being named at the time, so
the class kept growing quietly.

The hardware-register renderer had the same defect, and there an address rule
cannot work: `ld hl, rIE` is a real pointer setup at 74 sites, and `rLCDC`
appears in both roles. Those 18 sites are curated by offset in
`HWADDR_IMM_IS_CONSTANT` -- `ld de, rJOYP` was -256 and `ld hl, rWBK` -144.

Nothing of this shape is left in the ROM: no `ld rr, <name>` is followed by
`add hl, rr`. That check is cheap and worth re-running after any pass that names
a round address.


## The object slots FinishObjSlotUpdate works on (2026-07-28)

`FinishObjSlotUpdate` addressed one 16-byte record entirely by literal --
`$ddf0` through `$ddff`, thirty-odd operands -- and the five slots it is copied
to and from were literals too. The reason it reads that way is an indirection
worth writing down:

```
ProcessObjSlot:   copy wObjSlot<n> -> wObjSlotWork
                  push DrawObjSlot as the return address
                  jp [wObjSlotWork + 8]      ; the slot's handler
FinishObjSlotUpdate:
                  copy wObjSlotWork -> wObjSlot<n>
```

Every handler therefore addresses one *fixed* record rather than indexing `bc`,
which is why the whole subsystem read as a pile of unrelated addresses instead
of a struct. `UpdateAllObjSprites` walks five of them at `$dd80`-`$ddcf` --
serve indicators, the court banner, the point-situation banner, special-shot
effects -- and each spawner claims a fixed slot.

The record: id (`$ff` = free), a draw flag, the `QueueSpriteTemplate` arguments
(template pointer, attribute, base tile), an X/Y offset pair, the handler
pointer, a second X/Y pair the move curve drives, a handler sub-state, a curve
step and curve id, and an anchor byte choosing between drawing at the offsets as
they stand and adding the serving character's `wCharScreenX`/`Y` first.
`GetNextMoveCurveValue` walks `MoveCurveTable_09` until it hits `$80` (hold) or
`$81`, and writing `$ff` into the working copy's `+$00` is how it frees the slot.

Scoped to banks `$08`/`$09` as well as WRAM bank `$04`: the spawners pass a slot
base in `bc` without selecting the bank at the reference, and `$ddd0`-`$ddef`
just above the slots belongs to the bank `$18`/`$1b` menu screens.

**Four local labels were renamed on the strength of it**, which is the part
worth noting. They were descent-time guesses, and the record contradicts them:
`.applyCurve` applies no curve (it is the draw path that uses the offsets as
they stand) and `.checkExit` checks no exit (it is the draw path that anchors to
the server); `.freeSlot` frees nothing, it steps the curve, and `.keepSlot`
advances the sub-state. A name that survived because nobody could read the code
around it is worth re-checking once the code becomes readable.


## Sweeping for the last raw addresses (2026-07-28)

Counting `[$xxxx]` operands only ever measured one of three forms. A sweep over
all of them -- bracket, `ldh`, and `ld rr, $xxxx` -- puts the remaining raw
addresses in their real proportions, and two of the three turn out to be
*correctly* raw.

| form | count | what it is |
| --- | --- | --- |
| bracket | 997 | genuinely unnamed WRAM variables (`WRAM0` 507, `WRAMX` 490) |
| `ldh` | 0 | HRAM is fully named |
| `ld rr, n16` | 2,358 | WRAM bases where the bank is not provable -- `$d000` is seven different buffers |
| | 875 | VRAM and VRAM-bank-1 destinations, not RAM at all |
| | 109 | HRAM/IO values used as negative constants (see `RAM_IMM_NEVER`) |

**HRAM finished.** 47 references over 12 addresses: `hDebugStepPaused` (distinct
from the existing `hDebugStepMode`, which is the master enable SELECT cycles
1-3 while paused), `hSavedIE`, `DivAHLByDE`'s three scratch bytes -- the
dividend's high byte and the quotient bytes collected at bit 15 and bit 7, which
is why the result comes back as `a:hl` like the dividend went in -- the
nibble-block transfer's accumulator, offset and checksum, `hLinkPhaseDelay`, and
`hSoundEngineBusy`, a re-entrancy guard that works only because `RunSoundEngine`
saves and restores the pool around itself.

One mechanism gap surfaced: a **default** variant's multi-byte field never
interior-expanded, because `load_ram_unions` did not pass the size to
`ScopedRamNames.add` for defaults. `hLinkBlockChecksum`'s second byte stayed
numeric. Defaults register sized entries now, masked the same way their base is.

### Two of the last "addresses" were not addresses

`ldh [$ff0e], a` in bank `$0f` is two argument bytes of a `clear_flag` decoded
as an instruction, and `ld a, [$bb5e]` in bank `$0b` is two bytes of
`NetGamePractice2Hooks`, a `mode_hooks` table. Both were caused by
**hand-authored coverage seeds**, and in opposite ways:

* `bank00f_static_code.json` seeded `$76ea`, *one byte into* a `clear_flag`'s
  argument, and nothing seeded the `rst` at `$76e9` -- which is a real entry
  point, the target of `jp z, $76e9`. Moving that seed back one byte makes the
  pair read as the two `clear_flag`s they are.
* `bank00b_static_code.json` seeded `$5eab` as a behaviour entry when it is the
  hook table itself. A code seed beats the hook-table inference, so the one
  table rendered as instructions while its two siblings rendered as `dw` rows.
  Dropping the entry was the whole fix.

Both are the trap STATUS already records for bank `$0d`: a nonsense decode is as
likely to come from a seed file as from descent, and `make compare` cannot see
either, because the bytes are identical whichever way they are rendered. The
bank `$0b` fix drops the instruction count by 12 and code bytes by 16 -- the
direction that says false code was removed rather than real code lost.


## Putting the VRAM bank back in the operand (2026-07-28)

VRAM is reached through exactly one door -- `QueueVRAMCopy`, 613 call sites, and
**not one direct `ld [$8xxx], a` in the ROM**. It takes source in `hl`,
destination in `de`, length in `c` as 16-byte blocks, and branches on the LCD:
off, it starts a GDMA immediately; on, it takes a slot in `wVRAMCopyQueue` for
`ProcessVRAMCopyQueues` to drain in VBlank. A slot turns out to be literally the
five CGB VDMA registers plus the two banks needed to reach the source, and
writing the last byte to `$ff55` is what starts the transfer -- the note that
called `+$02`/`+$03` the size and `+$07` "src?" had those backwards.

The interesting part is the destination. **The VRAM bank rides in bit 13 of it**:

```
        bit 5, d           ; bit 13 of de
        jr z, .setVramBank
        res 5, d           ; clear it -> the real VRAM address
        inc a              ; ...and select VRAM bank 1
```

So `$b800` means `$9800` in bank 1, and roughly half the graphics traffic is
bank 1 -- attributes and the second tile bank. 418 sites now render as
`$9800 + VRAM_BANK1`, which rgbasm folds to the same word. (A folded expression
again rather than a macro: RGBDS has no expression-returning macro, the same
constraint the tilemap coordinates ran into.)

### Three ways to decide which immediates get it

The value cannot say, because `$a000` is *both* the SRAM base and VRAM bank 1's
`$8000`, and `make compare` cannot referee -- it assembles the same either way.

* **A call-site peephole** -- an `ld rr, $[ab]xxx` followed by a call to a known
  VRAM helper -- catches 374 of 434 and misses a whole class: destinations that
  are *computed*. `CopyVisibleTilemapToVRAM` does `ld hl, $b800 / add hl, bc /
  ld d, h / ld e, l`, and bank `$13` does `ld hl, $a000 / add hl, de`; both are
  as much VRAM addresses as the direct ones, and no forward scan for a call
  finds them.
* **Curating the 418 VRAM sites** by offset works but grows with every carve.
* **Curating the SRAM sites instead** is the one that holds, and it holds for a
  reason that is a property of the ROM rather than of the code shape: *only bank
  `$03` ever enables SRAM*. Every `ld a, $0a` / `ld [$0000], a` in the game is in
  the save engine, so outside it the range cannot be SRAM. The exception list is
  bank `$03`'s flat range plus one offset -- `FetchSRAMText` at `$05:$6d49`,
  which reads text out of the save at `$a800` while bank `$03` has SRAM enabled.

Fourteen exclusions instead of four hundred inclusions, and the check that the
split is right is independent of the compare: bank `$03` has zero conversions and
`FetchSRAMText` is untouched.


## $2000 is the mapper, not the VRAM bank (2026-07-28)

A reasonable guess, given the bank encoding above, is that the ROM's raw
`$2000`s are the VRAM bank offset. They are not: **57 of the 99 are
`ld [$2000], a`**, the MBC5 ROM bank register. Only 3 are the VRAM offset --
`ld hl, $2000 / add hl, de` in the tilemap and glyph upload paths, where `de` is
already a VRAM address -- and the rest are world coordinates in actor scripts.

Counting the other command windows, 136 writes to the mapper were rendering as
stores to ROM addresses. A write through a bracket operand below `$8000` is
never a memory store: ROM space *is* the MBC's command interface. No instruction
in the ROM reads a bracket operand from that range, so matching the write form
alone is enough, and the windows name themselves:

| | | |
| --- | --- | --- |
| `[$0000]` | 29 | `rRAMG` -- cartridge RAM gate |
| `[$2000]` | 57 | `rROMB0` -- ROM bank |
| `[$4000]` | 49 | `rRAMB` -- RAM bank |

so the bank-switch idiom reads `ldh [hRomBank], a` / `ld [rROMB0], a`.

### The 136th write is a bug in the shipped game (already known)

`ConvertColorToGrayscale` (bank `$1d`) splits a CGB colour into red at `$d000`,
green at `$d001`, and blue at -- `$0002`. It then reads all three back to
average them:

```
        ld a, [$d000]
        ld hl, $d001
        add [hl]
        inc hl          ; -> $d002
        add [hl]
        srl a
```

The blue channel never reaches `$d002`. The average is red plus green plus
whatever was already in `$d002`, and the write lands on the cartridge-RAM gate
instead, where its low nibble incidentally toggles SRAM access. It is a `d`
dropped from `$d002` in the original source, and it renders as
`ld [rRAMG + 2], a` now -- visibly wrong, rather than looking like an ordinary
store to a low address.

This was **already recorded**, in the 2026-07-17 naming pass far above, which
called the write a no-op. It is not: `$0000-$1fff` is the cartridge-RAM gate, so
the write sets it to the blue value's low nibble, and the effect is benign only
because the save engine re-enables SRAM before touching it. Game defects now
live in `docs/bugs.md` rather than scattered through this log.


## A generated tree can carry prose now (2026-07-28)

The one thing hand-written assembly buys that this generated tree could not was
an explanation next to the code. `labels.json` values were bare strings, so
everything a *name* cannot say -- why a routine exists, what its arguments mean,
what is wrong with it -- had nowhere to go but this file, which by now is 6,274
lines of chronological log and the wrong shape for "what does
`FinishObjSlotUpdate` do".

A `labels.json` value may now be `{"name": ..., "note": ...}`, and the note
renders as a comment block above the label:

```
; The only way anything reaches VRAM: 613 call sites, and not one direct
; `ld [$8xxx], a` in the ROM. hl = source, de = destination, c = length in
; 16-byte blocks.
;
; The VRAM bank rides in bit 13 of the destination -- `bit 5, d` selects it and
; `res 5, d` recovers the address ...
QueueVRAMCopy:
```

This is exactly what `ram_map.json` has always done for RAM symbols, where the
notes are the most useful documentation in the repository; code just did not
have the same channel. `load_label_overrides` still returns `{key: name}` so the
eight places that read overrides by name are untouched, and `load_label_notes`
reads the other half.

One detail worth keeping: both label-emitting paths share `_emit_label_note`,
and it fires only when the label is actually written. Emitting the comment first
and *then* discovering the label was already on the previous line would strand a
paragraph above unrelated code.

Twelve routines annotated to start, all of them worked out in the passes above:
the two VRAM routines, `RunSoundEngine` (it context-switches the shared HRAM
pool, which is what lets a counter live there), `SerialEncodeInput`,
`AdvanceFrame` (the debug stepper and its dead link-error check), the
object-slot trio, `StepCharAnimation`, `LoadCharacterAttributes`,
`ConvertColorToGrayscale` and one stubbed drill judge.

### Why this rather than hand-editing the output

The question that prompted it was whether the disassembly has reached the point
where `src/` should be maintained by hand instead of generated. Not yet, and the
reason is visible in this session's own diffs: rendering changes touched 13,529
lines (short-form ALU), 762 (tilemap coordinates), 418 (`VRAM_BANK1`) and 136
(MBC registers), and several of those were not improvements but *corrections of
systematic errors* -- 42 sites rendering `ld de, hPeakLY` for the constant -96,
seven maths-table rows rendering as code labels. In a hand-maintained tree those
would be frozen in, and each fix would be a four-hundred-site edit with no
`make compare` to catch a slip. Discovery is still live too: two seed
corrections this session changed which bytes decode as code at all.

The answer flips when discovery is finished and a regeneration stops changing
lines. Then the right move is to generate once, commit that as the source of
truth, and keep the generator as a verifier. Until then every improvement is
retroactive across the whole tree, which is the entire value of the arrangement
-- and the missing comment channel was the one real argument on the other side.


## The drill judges are per-event (2026-07-28)

`<Drill>JudgeShot0`-`3` were named on the assumption that the 0-3 they pass to
`JudgePoint` is a shot index. It is an *event* code, and the mapping is exact
across all 52 call sites: each drill has four of these routines, one per hook —
`Hook_PointEnd` passes 0, `Hook_BallHit` 1, `Hook_Bounce` 2, `Hook_RallyTick` 3.
They are `JudgeOnPointEnd` / `JudgeOnBallHit` / `JudgeOnBounce` /
`JudgeOnRallyTick` now.

The claim built on the old names was wrong as well as the names. `docs/bugs.md`
said "the same pair is stubbed in every drill, so a drill only ever judges shots
0 and 1". It is neither the same pair nor every drill: of 13 drills, 7 disable
`JudgeOnRallyTick` only, 5 disable `JudgeOnBounce` and `JudgeOnRallyTick`, and
`ServiceMatch2` disables `JudgeOnBounce` while leaving `JudgeOnRallyTick` live.
No drill disables `PointEnd` or `BallHit`.

With the right names that reads as a per-drill choice of which events may score
a point — a sensible thing to vary between a serve drill and a stroke drill.
That is *consistent with* deliberate stubbing and does not establish it: a
leading `ret` looks identical whether it was written as configuration or left
behind by an edit, and nothing in the ROM distinguishes the two. `docs/bugs.md`
records the behaviour and stops asserting the intent, and its section heading
changed from "Stubs — deliberate, not defects" to "Routines that return before
their body".

Worth generalising: the wrong name made the wrong conclusion easy. "JudgeShot2"
invites "the second shot is not judged", which is a claim about gameplay;
"JudgeOnBounce" invites "this drill does not judge on a bounce", which is a
claim about configuration.

### Names chosen for a leading `ret`

Following that through the rest of the ROM: 36 labels were named `Stub*`, and
six of them had a real body the name was hiding. Two were drill judges, which is
why the counts above were first written as thirteen drills and 52 judges — it is
fifteen and 60.

| was | is |
| --- | --- |
| `StubNop_0b_5d63` | `NetGamePractice1JudgeOnRallyTick` |
| `StubNop_0b_6ceb` | `StrokePractice1JudgeOnRallyTick` |
| `StubLoadFontTiles` | `LoadFontTiles` |
| `StubNop_1b_664a` | `LoadUnlockDebugNavGridGfx` |
| `StubAlwaysNotZero` | `CheckExpAwardAllowed` |
| `StubNop_05_49dc` | `PagedMenuFrameTask` |

The thirty others have a bare `ret` for a body, where `StubNop` is accurate.

Those two drills also turned up a *third* naming scheme for the same routines —
`NetGamePractice1` and `StrokePractice1` had their other three judges as
`Drill09`/`Drill15JudgePointMode0-2`. Each is called from exactly one hook, so
they are `<Drill>JudgeOn<Hook>` now and all 60 judges use one convention.

Two of the six renames are findings rather than tidying. **`CheckExpAwardAllowed`
cannot return z**: `xor a` / `dec a` sets the flags from `$ff` and the following
`ld a, c` restores the caller's `a` without touching them, so
`AddExpToCa00RecordChecked`'s `ret z` never fires and the EXP award is ungated.
**`PagedMenuFrameTask` runs and does nothing**: it is genuinely registered and
unregistered as a per-frame task, so the plumbing is real, but the body reads
`wMenuCursorRow` into `a` and `pop af` discards it.


## The other half of the RAM map (2026-07-28)

The HRAM sweep finished HRAM; the same sweep counted **507 bracket references
over 202 unnamed WRAM0 addresses**, which is the biggest single block of raw
addresses left in the source. WRAM0 (`$c000-$cfff`) is unbanked, so unlike
`$dxxx` it takes plain `ram_map.json` names with no scope machinery -- the work
is entirely in reading the code and being sure. **111 addresses named across
five passes; 507 references are now 154 over 71 addresses.** Every pass
regenerated, `make compare`d OK and passed `make check`.

Some of it was structure that the *macro comments already documented* while the
RAM side had no names at all. `include/macros.inc` has said since the map-tree
work that "each story location owns a 7-word directory (a map_tree) copied to
`$c286`" and has spelled out both record layouts (`map_entry id, facing, x, y,
arrival_script`; `map_script id, facing_mask, flag_cond, handler, arg0, arg1`).
Naming `wMapEntryPointsPtr` … `wMapInitScriptPtr` and `wStoryMapRecord` makes
the bank `$0a` overworld engine read as the table walker it is:

| was | is |
| --- | --- |
| `ld hl, $c286` | `ld hl, wMapEntryPointsPtr` |
| `ld de, $c2c0` … `call FarCopyBytes` | `ld de, wStoryMapRecord` |
| `ld hl, $c2c4` | `ld hl, wStoryMapRecord + 4` |

`wStoryMapRecord` is deliberately one 8-byte array rather than eight fields: the
two record shapes disagree about `+4`-`+7` (a `map_entry`'s Y and arrival script
against a `map_script`'s handler and its two argument bytes), so interior
offsets are the honest rendering.

### The four on-court character records

`CharAttrStructPtrs_07` is `dw $ca00, $ca80, $ca40, $cac0` -- player-1 main,
player-2 main, player-1 partner, player-2 partner -- and `LoadCharacterAttributes`
already carried a prose note describing what it copies out of them. Cross-reading
that against the story character records at `$c900`/`$c940` (already named down
to gender and handedness) settles the shared `$40`-byte layout:

| offset | field | how it was proven |
| --- | --- | --- |
| `+$00` | display name, 7 bytes | `DrawSinglesPlayerNames` copies it through `CopyStringToTextBuffer` |
| `+$0b` | character id | already named `wPlayer1CurrentMainCharacter` etc. |
| `+$0c` | palette index | `LoadIndexedPalette_18`, and `SetupCharacterSprite` with `+3` |
| `+$0e` | left-handed | becomes `wCharMirrorAttrMask`: the `$20` OAM X-flip *and* the forehand/backhand swap |
| `+$18` | EXP tier | `ld [wCharExpTier], a` |
| `+$1b`-`+$1e` | four AI personality parameters | written from the CPU-difficulty row |
| `+$1f` | difficulty | already named `wExhibitionMode*Difficulty` |
| `+$3c` | equipment nibbles | `ApplyMatchSettingsExpBonus` |

That last one is a gameplay finding rather than a rename. The handicap gear pays
for itself: `ApplyMatchSettingsExpBonus` scores one step for the low nibble being
`$03` and another for the high nibble being `$01`, and **two steps double the
match EXP** (one step adds a half).

### The `Star*` family was two things, and neither was a star (2026-07-28)

`IsStarCharacter` returns true for character ids `$17`-`$1f`, and
`id = bank $30 string index - 27` puts those at indices 50-58 -- Luigi through
Peach, the nine Mario-series characters. `GetStarCharIndex` corroborates the
extent independently: it does `sub $17` into a nine-entry table, so the block is
exactly those ids and nothing else. It is `IsMarioCastCharacter` now.

Renaming it exposed a bigger family -- 43 labels plus a RAM symbol -- and
following it through showed the prefix had been carrying **two unrelated
meanings**:

* **who**: the nine transfer-pak characters. `GetMarioCastIndex`,
  `MarioCastOrderTable`, `Get`/`GetUnlockedMarioCastCharAtGridSlot` and their
  tables, `BuildMarioCastUnlockMask`, `UpdateMarioCastUnlocks`,
  `Read`/`WriteMarioCastVictoryGrid` (a 9x9 chart in save block `$3e` of who has
  beaten whom, one full row unlocking `SAVEFLAG_COURT_WAREHOUSE`),
  `CompactMarioCastGridEntries`, `CheckMarioCastEquipCategory`, the three
  `*MarioCastExhib*` screen builders, and the thirteen `MarioCastChart*`
  routines that draw and scroll it.
* **what**: a **handedness** flag. `wCharSelectSlotStar` is
  `wCharSelectSlotLeftHanded`, `ApplyStarFlagsToCharRecords` is
  `ApplyHandednessToCharRecords`, and the two `Draw*SlotStarMark` routines are
  `Draw*SlotLeftHandedMark`.

The second half is the part worth recording, because the mechanic was not
visible under the old name. Both character grids reach their toggle on
`bit 3` -- START -- and refuse it unless `IsMarioCastCharacter` returns 1, so
**only the Mario cast can be flipped left-handed**; created characters set
handedness at name entry instead. The prompt row the grid draws is text
`30:118` "START: Change Hands", and `DrawCharSelectSlotLabel` swaps a word in it
for one of three pre-rendered labels on `$df00`'s three values -- `30:150`,
`30:151`, `30:152` being "START: Right-Handed", "START: Left-Handed" and
"START: Change Hands". On confirm the flag reaches the match record's `+$0e`,
which becomes `wCharMirrorAttrMask`: the OAM X-flip bit *and* the
forehand/backhand swap in `SelectForehandBackhand`.

Two guards on the sweep. The game's own text never calls those characters star
characters -- every `star` string in the ROM belongs to Shooting Star, the
Perfect Shot panels or Star Court -- but there **is** a genuine star elsewhere:
`LoadMinigameStarFlags` reads nine save flags into `$d812` and
`DrawMinigameStarMarks`/`DrawStarLegendMark` draw a cleared-mark per minigame
row. That group, `ShootingStar*`, `StarWarp*`, `StarCourt*` and
`StarPatternBg*` kept their names. A blind `s/Star/MarioCast/` would have
renamed 40 identifiers that were right.

The reasoning lives on `IsMarioCastCharacter` as a `labels.json` note, so it
renders above the function in `src/bank_038.asm` rather than only here.

### Screen shake, and a second clock

Two subsystems were entirely anonymous. **Screen shake** is `SetScreenShake`
(magnitude `$ff` = off, otherwise clamped to 1-3) plus `UpdateScreenShake`,
which turns the magnitude into a mask of that many bits, ANDs it with a fresh
random word and signs each half: `wScreenShakeOffsetX`/`Y` then bias `hScrollX`
and `hScrollY` in `UpdateSceneScroll`, and bank `$04`'s
`ComputeSpriteScrollOffset` sign-extends the same two bytes so objects shake
with the background.

**A second clock** sits right after `wGameTimer`: `wSecondaryTimer` (frames,
seconds, minutes) ticked by `TickSecondaryTimer` while `wSecondaryTimerMode`
reads exactly 1, saturating at 9:59 rather than wrapping. The same three bytes
are run *downwards* by a stranded routine at `$00:$240a` -- no label, nothing
references it -- which plays `sound $af` per second and `sound $b0` at zero, and
writes `$ff` into the mode byte on expiry. A countdown timer that shipped
unreachable.

### Write-only is a common shape here

Naming forced the question "what reads this?" more often than expected, and the
answer is frequently *nothing*. `$c458`-`$c45f` is the shot-speed sum broken
into its four terms -- the ball's contribution, the striker's momentum, the
charge bonus, and the clamped result -- each stored by the routine that computes
it and never read back. So are `wLastShotAimOffset`, `wLastShotWasPowerShot`,
`wBallOutOfBoundsBits`, `wMatchEndLinkState` and `wRallyNetFrames`. They are
named for what they hold, with "write-only" in the note; the `wUnused*`
convention is kept for bytes whose *only* interest is that nothing reads them.

### Shared scratch, again

The `$dxxx` screens taught that a block of RAM can mean different things in
different banks. WRAM0 does it too, and three blocks had to be left partly
numeric rather than named wrongly:

* `$c700-$c709` is `wDebugMenuWindowId`/`wDebugWarpWindowId` in one debug
  submenu, the `"RRRGGGBBB"` decimal buffer in the colour editor, and a save
  slot for eight bytes of `wCharPosX` in the stats editor. `$c703` is both the
  warp menu's cursor row and the green component's string, so it stays numeric.
* `$cb02`/`$cb03` are the LCD STAT handler's scanline band bounds in banks
  `$00`/`$16`/`$6b` and a 16-bit camera offset in banks `$03`/`$04`/`$0a`. Only
  `$cb01` -- always the `rSCX` value -- is named.
* `$c780-$c78c` was already a `ram_unions.json` mode-local union; the scoreboard's
  use of `$c78a` went in as a bank `$18` variant rather than a global name, and
  the generator caught the attempt to do it globally (`ram_map/ram_unions
  conflict: $c78a inside union $c780-$c78c`) before it could render.

### A size field worth eight references

`wTextBuffer` had the note "(160 bytes)" and no `size`, so `[$c601]`-`[$c604]`
rendered as bare addresses in the EXP digit drawing. Setting `"size": 160`
renders them `wTextBuffer + 1` … `+ 4` and cost nothing else. Worth checking the
rest of the map for notes that describe a length the `size` field does not.

`tools/progress.py` also crashed on start since labels.json entries gained
prose: it reads the values as strings to find curated `.local` names, and a
`{"name": …, "note": …}` value is a dict. It unwraps both shapes now.


## A `dw` table of RAM addresses is layout too (2026-07-28)

`PlayerSlotBoxAddrs0` and its five siblings render as `dw $d0d0` — the question
of whether those are addresses at all is what started this. They are:
`ClearPlayerSlotPortrait` hands the word straight to `FillTilemapRect` as `de`
and reaches the attribute plane by adding **`$0400`**, which is exactly
`wShadowAttrmap - wShadowTilemap`. The flush after it copies
`wShadowTilemap + 6 * TILEMAP_WIDTH` to `$98c0` = `$9800 + 6 * 32`, so the
shadow map sits 1:1 over the BG map and row 6 really is row 6.

**Why they stayed numeric** is two separate gaps. `render_pointer_words` only
resolves ROM labels — same-bank `$4000-$7fff` or ROM0 — so there was no RAM path
for a `dw` row at all. And even with one, `wShadowTilemap`'s union variant is
scoped `{"wram_bank": "0x03"}`, which is a `compute_wram_bank` fact about a
*code* site; a data word has no dataflow, so the scope could never fire.

The fix is a new render spec, **`ram_ptrs:<wram bank>[:<zero name>]`**. The bank
is the human assertion the dataflow cannot make, and `resolve()` takes it as an
override. Bank `0` asserts nothing — for a WRAM0 table, or where the covering
union is scoped by the referencing code's ROM bank instead, which matches on the
word's own offset and needs no assertion. That last case worked out of the box:
`ShotRecoilVarPtrs_07` sits in bank `$07`, inside the match-struct union's ROM
scope, so its words came back `wGroundStrokeSpeedIndex` / `wReachSpeedIndex` /
`wSmashServeSpeedIndex` with nothing declared but `ram_ptrs:0`.

This is a *no-ROM-content* improvement as well as a readability one. `dw $d0d0`
is a ROM value sitting in the repository; `dw wShadowTilemap + 6 * TILEMAP_WIDTH
+ 16` is layout the assembler recomputes, and `make compare` still checks the
arithmetic folds back to the same word.

### The sweep

Counting `dw` words that land in a RAM range found 247 across 49 tables, and the
first lesson was that **two thirds of the regions were not RAM at all**. Every
`$ffxx` hit — `ActorMoveVectors_04`, `DPadMoveVectors_0a`,
`MinigameBallLaunchHeights`, `SmashVelocityBySpeed_24`, `CourtSideOffsets_07_*`
— is a *negative 16-bit number*: `$ffc0` is −64, not an HRAM address. That is
the `RAM_IMM_NEVER` hazard in a new operand position, and it is why the spec is
opt-in per table rather than a blanket fallback on `records:2`.

Of what remained, 27 tables were declared:

| what | tables | words |
| --- | --- | --- |
| character-select slot boxes (bank `$38`) | 8 | 40 |
| menu / bracket / ranking cell tables (`$1b`, `$39`, `$3b`) | 16 | 105 |
| WRAM0 and char-struct pointer tables (`$07`, `$0b`) | 3 | 11 |

Each was checked the same way: every word either zero or inside
`$d000-$d7ff` (the shadow tilemap and attrmap, and nothing else lives there in
WRAM bank `$03`), and the consumer proven to write the tilemap under that bank.
`DrawSinglesRankingNames` corroborates its own table exactly — it does
`wram_bank $03` and writes `wShadowTilemap + 1 * TILEMAP_WIDTH + 1`, which is
`SinglesRankingEntryTable1`'s first entry.

The renderer also picks the *plane* correctly without being told:
`BracketPlayerRowTable0` came back `wShadowAttrmap + 9 * TILEMAP_WIDTH + 5`,
which is right — `HighlightBracketPlayerRow` fills an attribute rect with a
palette in `h`.

**Four tables were deliberately left numeric**, all for the same reason: they are
not flat arrays of addresses. `TennisDictionaryClearList`/`2` are 4-byte
`{address, length}` records — and in WRAM bank **`$02`**, not `$03`, so a blind
declaration would have named them wrongly twice over.
`DiagramTargetPatchRecords_17` is 6-byte mixed records and
`CharMugshotGfxPointers` 4-byte ones.

### `NO_BOX`

The six slot-box tables store `$0000` for a slot their layout does not show, and
**nothing checks the fetched address** — none of the five callers tests `bc`, so
a zero would be written straight into ROM. It is a placeholder the code relies on
never selecting rather than a guard value, which is exactly the case for naming
it: `def NO_BOX equ $0000`, emitted by the spec's optional zero-name field. The
bracket tables reuse it for page 0, which has no row.

What the six tables say once they render is the screen's geometry, which was
invisible before: singles centres one 2x2 portrait box per side at column 16,
doubles pairs them at columns 13 and 17, rows 6 and 9 are the two sides, and the
four link layouts light one box or one row depending on which side you are.

## What was left in WRAM bank $05 (2026-07-28)

Bank `$05` held 19 `w5_dxxx` auto-names and, either side of them, four gaps the
auto-namer could not even see: a 2 KiB one at `$d000`, a 4-byte-per-window table
at `$d800`, and everything from `$dc00` up. **All of it is the text and window
engine**, and it now renders as 39 named symbols across five unions.

**The queues came in threes.** `wTextArgStringWriteIndex` /
`wTextArgStringCount` / `wTextArgStringQueue` were named; their two siblings
were not, and once the three rings are side by side the layout reads itself:

| | strings | numbers | short-text ids |
| --- | --- | --- | --- |
| cursor | `$d847` | `$d848` | `$d849` |
| count | `$d84a` | `$d84b` | `$d84c` |
| measure cursor | `$d866` | `$d867` | `$d868` |
| queue | `$d8b0` (16x2) | `$d8d0` (16x2) | `$d8f0` (16x1) |

The third row is the part that needed explaining. `PushTextArgNumber` writes at
the cursor *and* keeps the count in step, which makes the two look redundant —
until `FitWindowToText` walks the whole message to size the window before a
glyph is drawn, popping arguments as it measures. That pass needs its own cursor
per queue, which is why the dialogue entry points reset **six** bytes in one
run, in the order `$d847, $d866, $d848, $d867, $d849, $d868`: three pairs, not
two triples.

**`ld bc, $d8f0` is −10000.** `MeasureNextArgNumberWidth` divides by repeated
subtraction, and its first divisor is two instructions away from a real
`wTextArgShortTextQueue` pointer setup in the same routine. One flat offset in
`RAM_IMM_IS_CONSTANT` (`0x1531d`) keeps them apart.

### Scoping, and four names that were wrong before

The bank-`$05` text entries lived in `ram_map.json`, which is **global** — its
`wram_bank` field picks the section to emit into, not the sites that may use the
name. That was already leaking. Bank `$1b`'s ranking-marker animation channels
keep four 16-bit fields over `$d840-$d853` in a different WRAM bank, and they
were rendering as `wTextArgStringCount` and `wTextPageBreakRequest`; banks
`$18`/`$1a`/`$1b`/`$6b` address `$d8bx`/`$d8fx`/`$d880` as tilemap cells and were
picking up queue names. Moving the block into `ram_unions.json` under scopes
`{bank $05, $0a, $0b}` + `{wram_bank $05}` fixes all of them and *adds*
coverage: the engine saves and restores an unknown bank around its glyph-buffer
work, so a WRAM-bank scope alone would have lost the reset runs at the end of
every `Show*Dialogue`.

Two details the scope had to bend around:

- **`wShortTextBuffer` gets its own union.** The copy into `$d880` lives in the
  *string* banks — `$1f`, `$25`, `$26`, `$30-$37`, `$5e`, `$6e` all end with the
  same `FetchShortText` tail — so it is scoped to those 16 banks, not the three
  the engine runs in. Bank `$6b`'s intro cutscene addresses the same bytes as
  tilemap rows and is kept out.
- **The run breaks at `$d855-$d85b`.** A union's whole span is off limits to the
  auto-namer, and bank `$1b` keeps three provable WRAM-bank-`$03` bytes in that
  hole. Covering them would have silently deleted `w3_d855` / `w3_d858` /
  `w3_d85a`, so the block is split either side of it.

Likewise `$dc00-$dc7f` is scoped to bank `$05` **in two ranges**:
`WriteStringToTilemapStreamed` (`$6bf0-$6c4f`) keeps a cursor at `$dc05-$dc0a`
in *the caller's* WRAM bank — it writes glyphs straight to a tilemap the caller
selected — so those bytes are not windows.

### The window system, which was entirely anonymous

`$dc00` is `wWindowStructs`: eight 8-byte records, `GetWindowStructPtr` masking
the id to 3 bits and shifting left 3. Column, row, height, width, state at
`+$04`, text id at `+$06` — and `$03` in that id's high byte is a "no text"
sentinel `RenderWindowText` bails on. Above them `wTilemapRowDirty` (32 flags,
one per row) and `wTilemapRowRuns` (the `(row, length)` run list
`BuildDirtyRowRuns` folds them into, runs capped at 7 so one pass fits a
VBlank) are the whole of the shadow-tilemap flush, and `wSavedWindowStruct` at
`$dc78` is the copy `OpenSpeechBubble` compares against while it grows the
bubble outward a cell at a time.

`$d000-$d7ff` is that shadow tilemap: the same 32x32 cell plane plus attribute
plane the full-screen UIs keep in WRAM bank `$03`, cleared by
`ResetTextWindowState`, which then points `wShadowTilemapPtr` /
`wShadowTilemapBank` at `$d000` / `$05`. Scoped to a provable WRAM bank `$05`
alone — bank `$05` is full of `$d000`/`$d400` literals that mean whichever plane
the current screen owns. That scope turned out to name more than the engine:
bank `$3f`'s tennis-dictionary rows, bank `$6b`'s intro tilemaps and bank
`$1a`'s pause-menu number formatting all select bank `$05` and draw into the
same plane.

### Three bytes nothing reads

`wSpeechBubbleLowerHalf` (which half of the screen the bubble landed on),
`wWindowTextEmpty` (whether `RenderWindowText` bailed) and `wUnusedTextByte`
(all `Unused_05_SetTextVar` does) are written and never read. Named anyway:
"written by nothing else and read by nothing" is a fact about the ROM, and a
`ds 1` cannot say it.

`wFixedMenuWindowId` is stranger. `SetFixedMenuWindowTextId` loads `hWramBank`
into `b` before calling `SetWindowTextId`, which takes the window id *in* `b` —
so the id it stores, and that `RunFixedTextMenu` later passes to `CloseWindow`,
is really the WRAM bank number. Both routines are exported through the bank
`$05` farptr table and neither is called.

## WRAM bank $07, and a union bug that was hiding 20 names (2026-07-28)

Bank `$07` was the sound engine (`$d100-$d21a`) and 2,316 bytes of `ds`. The
gap is the **glyph tile buffer**: `$d300`, 2 KiB, 128 proportional-font tiles
laid out 1:1 against VRAM `$8800`, so tile *n* is at `+ n * TILE_SIZE` and
uploads to `$8800 + n * TILE_SIZE`. Every literal that looked arbitrary is a
tile index once it renders that way — `UploadGlyphTilesPartial` copies 27 tiles
and resumes at `wGlyphTileBuffer + 27 * TILE_SIZE`; bank `$3f`'s dictionary rows
are tiles 54, 78 and 102 going to `$8800 + $360/$4e0/$660`.

Three more, all previously anonymous:

- `$d000` `wSndHramSave` — where `RunSoundEngine` parks `$ffd0-$ffef` for the
  duration of an audio update. That copy-out/copy-back is why four subsystems
  can keep live bytes in that HRAM window (see the `$ffd0` union).
- `$d480` `wMinigameRecordBlock` / `$d500` `wSaveBlockBuffer` — the bank `$03`
  save engine's block staging, **overlaying the glyph buffer**. `docs/save_format.md`
  listed both as deliberately unnamed because they are "multiplexed with other
  uses"; a union is exactly the mechanism for that, so they are named now and
  the doc points at them.
- `$de00` `wMinigameRecordValue` — the 16-bit in/out parameter of
  `ReadMinigameRecord`/`WriteMinigameRecord`, which seven banks read by selecting
  WRAM bank `$07` around two bytes. It is a second variant of the `$de00` union
  whose first variant is the match ball sprite slots in WRAM bank `$04`.

### A scope needs both halves

The glyph/save union is the first where **every scope carries a ROM bank *and* a
WRAM bank**, and the first attempt showed why. Scoped by WRAM bank alone, the two
overlays cannot be told apart: `$d502` is an interior byte of both
`wGlyphTileBuffer` and `wSaveBlockBuffer`, and interior lookup takes whichever
was registered first. Scoped by ROM bank alone, a 2 KiB extent is far too greedy
— it claimed `$d800` and `$d822` in banks `$05`/`$3f`, which are the window
engine's own WRAM bank `$05` bytes and a bank `$01` decompression buffer. With
both constraints on each scope the 15 real sites resolve and nothing else does.

### The bug: a union's span blocked every bank

`load_ram_map` took a union's whole address span off limits to the auto-namer,
on the reasoning that an auto symbol inside a union would have to be emitted
inside the `UNION` block. **That only holds within the union's own WRAM bank.**
Another bank's copy of the same addresses is a different `SECTION` — there is no
layout to collide with — and `_group_by_bank` already splits unions across banks.

Blocking regardless of bank was silently deleting names. The new `$d300-$db00`
union alone would have taken out 16 (`w3_d855`, `w4_dad0`, ...), and the fix
turned up 20 more that unions committed earlier had been suppressing all along,
in WRAM banks `$01`, `$03`, `$04` and `$06`. `covered` is now a per-bank map,
and `write_ram_layout`'s conflict check compares banks the same way. That also
let the bank `$05` text block, split in two the previous pass precisely to dodge
three `w3_*` names, go back to being one union.

**What is left in bank `$07`** is `$db26`/`$db27`, two bytes
`RunStoryDataConfirmMenu` sets to 0 and `$0c` before registering a frame task
whose body is `ret`. Nothing reads them, and with the task stubbed out nothing
ever will, so they keep their auto-names.

## No auto-named WRAM address is left (2026-07-28)

`w<bank>_<addr>` is the generator's name for a banked-WRAM byte whose purpose
is unknown but whose WRAM bank every reference agrees on. **The count is now
zero**, down from 36 — and 36 was itself up from 17, because fixing the
union-span bug in the pass above surfaced 20 that had been suppressed.

### WRAM bank $04 — the actor array

`$d000` is `wActors`: **24 records of `ACTOR_SIZE`**, the array `SpawnActor`
allocates from. `GetActorStateAddr` turns an actor id into a slot with two
`srl h / rra` pairs — id * 64 — and the per-frame loop walks it with
`ld de, $0040 / add hl, de`. Five auto-names were the same field in four
different actors: `w4_d037`, `w4_d077`, `w4_d0b7`, `w4_d0f7` are
`wActors + n * ACTOR_SIZE + 55` for n = 0-3, which is what
`SetupCharViewerScene` sets on the four characters it poses.

The rest of the bank was the actor engine's plumbing:

| | |
|---|---|
| `$da00` `wNearbyActorList` | pointers to the live nearby slots, zero-terminated |
| `$dac0` `wActorTemplate` | one `map_actor` record staged out of ROM |
| `$dad0` `wActorObjDef` | the 16-byte object definition, then distributed into the slot |
| `$dae0`/`$dae2` `wActorScreenOrigin*` | negated camera + shake, added to get a screen coordinate |
| `$dcf0` `wMinigameTargetWork` | the target record being updated, the `wObjSlotWork` pattern again |

Naming `wActors` also exposed a **false name**: the debug character viewer's
union variant was scoped by ROM range alone, so `wCharViewerRow` was rendering
at `$d000` inside `SetupCharViewerScene` — which selects WRAM bank `$04` to
place its actors. Its scope now requires the WRAM bank over that part of the
range. Same lesson as the glyph/save overlay, from the opposite direction.

### The other thirty

| bank | what it turned out to be |
|---|---|
| `$06` | the **EXP award screen** at `$d230-$d259`: the gauge total and running count, the level-up latch, and two four-byte `{X, Y, first digit tile, attribute}` records that say how each number is drawn as sprites |
| `$03` | `wCreatedCharRecords`/`wCharGridEntries` (bank `$38`), `wN64RecordsBlock` (bank `$3b`, the screen's own copy of save block `$0b`), the ranking-board banner animation, `wRingShotEntryList`, two screen-sequence counters in bank `$18` |
| `$01` | `wCharRecordBuffer`, the 128-byte character-record copy `LoadCharacterRecordToBuffer` makes |
| `$07` | `wStubbedPromptTaskState` — two bytes `RunStoryDataConfirmMenu` sets before registering a frame task whose body is `ret` |

Three of these needed the overlay treatment: `$d900-$daff` in WRAM bank `$03`
is three different screens' buffers, and `$d230` is the scrolling-text screen
*and* the EXP gauge, with banks `$1c`/`$1d` putting `$40`-byte stat blocks over
the top of both — those stay numeric, being neither.

Where the evidence ran out the name says so rather than guessing:
`wStubbedPromptTaskState`, and `wPlayerObjDefPending` in bank `$04`, are written
and never read. That is a fact about the ROM, and it is worth more than a `ds 1`.

## Bare RAM references, WRAM0 half cleared (2026-07-28)

With no auto-named address left, what remained were the *numeric* ones — an
address the generator could not attribute at all. WRAM0 is the tractable half:
it is unbanked, so a name there is unambiguous and needs no scope. It held
**135 addresses across 453 references**; it now holds **81 across 213**.

Almost none of them were in a gap between unrelated things. The great majority
were fields of structures whose neighbours were already named, and reading them
that way is what identified them:

**The ball's fixed point.** `wBallX`, `wBallDepth` and `wBallHeight` sit four
bytes apart, and the bare addresses were the four bytes *between* them.
`SetBallPosition` writes each axis as two zero bytes followed by a 16-bit
integer: **position is 16.16 fixed point**, and the three axes are one 12-byte
block. The velocities are the same trick at a different width — `wBallVelocityX`
at `$c421` with a bare `$c420` below it is a 24-bit `8.16` triple. The notes had
said as much for years ("fraction byte at `$c420`"); now the fractions have
names, and `StepBallPhysics`'s block copy reads as
`wBallXFrac` → `wBallPrevXFrac` instead of `$c400` → `$c410`.

**Blit buffers in pairs.** `$c300`/`$c340` and `$c380`/`$c3c0` are the row and
column BG blit sources, and each pair is attributes-then-tiles because
`ProcessBGBlitQueue` sets `rVBK` to 1 before the first and 0 before the second.
Rows go out by VRAM DMA, columns by a byte loop.

**One that is not an address.** `ld bc, $c350` in `WaitSerialTransfer` is a
timeout counted down with `dec bc`. It sits 16 bytes inside what is now
`wBGRowBlitTiles`, so naming that buffer would have turned a loop counter into
`wBGRowBlitTiles + 16`. It joins `RAM_IMM_IS_CONSTANT` — the fifth site in the
ROM where a word immediate merely looks like RAM.

**Overlays needed scoping, as ever.** `$ce40` is the serial link's nibble
staging in bank `$07` and the character-select roster in bank `$1b`; `$c7be` is
minigame target state in banks `$0a`/`$0d` and the character-select cursor in
bank `$1b`. Both became unions scoped by ROM bank. One attempt failed loudly and
usefully: a union over `$c7a0-$c7d7` tripped the `ram_map/ram_unions conflict`
check on `$c7a5`, because the mode flags in between are already global names.
Bank `$1b`'s 32-byte nav grid genuinely overlays them, so that one use keeps its
numeric address — there is no symbol it could be given without unpicking eleven
proven ones.

**The story-script scratch, by default.** `$c2b2` alone had 30 references. The
union there already had variants for the two screens with a fixed layout (bank
`$14`'s cutscene sprite slots, bank `$15`'s swing contest); everything else in
banks `$0e-$13` uses the block for whatever that location needs. That is what a
*default* variant is for, and `wMapScratch` — one 14-byte symbol, offsets left
unnamed — cleared 74 references on its own. Naming the block without pretending
to name its fields is the honest shape for scratch.

What is left in WRAM0 is mostly the same kind of per-mode scratch at `$c7xx`,
the story character record's unnamed fields at `$c8xx`/`$c9xx`, and the menu and
cutscene bytes at `$cbxx` — each needing its own owner established first. The
banked halves ($dxxx immediates, ~3,000 references) are dominated by screen
tilemap buffers and remain a separate problem.

## WRAM0 down to eleven addresses (2026-07-28)

Continuing the bare-reference pass: **81 addresses / 213 references → 11 / 23**.
Combined with the previous session that is 135 → 11, and what is left is not
work still to do — it is nine deliberate cases and two genuine oddities.

The three clusters that remained were all screen and mode state, and reading
them went the same way each time: find the one routine that writes a byte,
find the one that reads it, and the name follows.

- **`$cbxx`, the menu and cutscene band.** `$cb02`/`$cb03` are the raster
  split's start and end scanlines — `LCDStatHandler` applies `wRasterScrollX`
  between them, and the win/lose screen, the ending credits and the intro each
  set their own pair. `$cb55`/`$cb59` are the two sides of the link unlock-flag
  exchange, `$cb48` the intro's scroll accumulator, `$cb30` the tennis
  dictionary's list-end pointer — **stored high byte first**, which is worth a
  note because nothing else in the ROM does that.
- **`$c7xx`, per-mode scratch.** `$c798` and `$c79c` are the two drill gates,
  four bytes each. Naming them as *pairs* rather than four coordinates is
  deliberate: `SetBallGatePoint1` takes one point in `hl` and one in `de` and
  nothing in the routine says which axis is which, so the block gets a name and
  the offsets do not.
- **`$c9xx`, the story character records.** `$c920`, `$c92c` and `$c938-$c93b`
  are the stats, EXP and four levels of the record at `$c900` — the same field
  offsets already named on the `$c800` copy, which is how they were recognised.
  `$c9b0`/`$c9b2` turned out to be the story and trophy halves of the pending
  EXP award, completing the set with `wPendingExpExhibition` and
  `wPendingExpLinked` from the previous pass.

### What is left, and why

| | |
|---|---|
| `$c000`, `$c350` | not addresses — a `SetBallVelocityPolar` magnitude and a `dec bc` timeout, both already in `RAM_IMM_IS_CONSTANT` |
| `$c2b2` x3 | bank `$14`/`$15` sites, where the scoped variants win over `wMapScratch` and those two screens' own layouts apply |
| `$c780`, `$c783`, `$c78b`, `$c7a0` | mode-local scratch referenced from a mode with no named variant — the union's whole point is that those stay numeric |
| `$c706`, `$c709` | the debug colour-component viewer formats digits over `wDebugWarpEntryPoint` and its neighbours; there is no symbol to give them that would not lie about the bytes underneath |
| `$cfb3`, `$cff0` | the dictionary index cursor walks these `$40` at a time, straight out of WRAM0 and on into banked WRAM. A WRAM0 name would describe only the first row |

Two guards were needed along the way. `ram_map/ram_unions conflict: $c78c` —
extending the `$c780` mode-scratch union to cover its last three bytes ran into
`wTargetZoneEnabled`, a global name sitting in the middle, so those three got a
union of their own. And rgbasm caught `wTennisDictSpriteTimer already defined`:
`$cb3e` is a *second* animation counter three bytes above the first, and the
obvious name was taken. Both failures were loud, which is the point of having
them.

## The banked half: WRAM bank $01 is one buffer (2026-07-28)

WRAM0 done, the same census over `$dxxx` says something different. Grouping
every bare banked reference by the WRAM bank `compute_wram_bank` can prove at
the site gives **2,080 attributable references**, and they are not spread thin:

| bank | refs | what it is |
|---|---|---|
| `$01` | 633 | VRAM staging — **named this pass** |
| `$06` | 685 | the character-data / EXP screens |
| unknown | 431 | the bank is not provable at the reference |
| `$02` | 162 | the 64-wide scroll buffers |
| `$03` | 131 | screen tilemaps (mostly already named) |
| `$04`/`$05`/`$07` | 38 | the remainder of banks already done |

**Bank `$01` is one buffer, and that is the whole finding.** Every screen in
the game decompresses into it and `QueueVRAMCopy`s out of it: `ld de, $d000` /
`DecompressData` / `ld hl, $d000` / `QueueVRAMCopy`, over and over, from twenty
ROM banks. What an offset *means* depends on what the current screen put there
— the cutscene loaders keep six animation frames at tiles 0, 4, 8, 12, 14 and
16, while the EXP screen puts a tilemap plane at tile 0 and its attributes at
tile 64 — so the two halves get names and the offsets do not. That is the
`wMapScratch` shape again, and it cleared 633 references with two symbols.

Every offset in use turned out to be a whole multiple of `TILE_SIZE`, so they
render as tile indices rather than byte counts, which is what they are.

### Two unions over the same bytes

`wCharRecordBuffer` (`$d580`, bank `$01`) was already a union of its own, and it
sits *inside* the new staging span. The layout writer checked ram_map symbols
against union spans but never unions against each other, so it emitted both, one
after the other, and the section grew past the end of the bank. rgbasm caught it
— `Section "WRAMX bank 1" grew too big` — but a long way from the cause. The
overlap check is now explicit, and the fix was to make the record copy a
*variant* of the staging union, which is what it actually is: bank `$1b` selects
bank `$01`, so the record lands on top of the buffer while the new-game roster
is being built.

Variant **order** then mattered for a reason worth recording: an interior byte
resolves to whichever sized symbol was registered first, and `wDecompBuffer`
covers everything. The narrower, doubly-scoped overlay has to come first in the
variants list or `wCharRecordBuffer + 11` silently becomes
`wDecompBuffer + 88 * TILE_SIZE`.

### What bank $06 turned out to be

Not what the reference shapes suggest. `ld bc, $d7e0` in the character-data
screens looks like a tilemap cell, but `ApplyTilemapPatchList` selects WRAM bank
`$06` and uses `bc` as a **source** pointer — its destination is `$d000 + de`
from the patch list, in whatever bank the caller left. So `$d7e0`, `$d8e0`,
`$d9e0` and the `$da20`-`$de60` run are arrays of patch bytes in bank `$06`,
and segmenting them is its own pass rather than a name.

## Bank $06, and a third of it is not bank $06 (2026-07-28)

WRAM bank `$06` is the character-data and EXP screens' working set — banks
`$1a`, `$1c` and `$1d`. The survey put 685 bare references there. **About 240 of
them are not in bank `$06` at all**, and finding that out was most of the work.

`ld bc, $d7e0` in `SlideToMainCharStatPage` looks like a variable. It is an
*argument*. `ApplyTilemapPatchList` takes a destination offset from its ROM
patch list and a source cell in `bc`, and its copy loop is this:

```
.copyLoop:
	wram_bank $03      ; tile plane
	ld a, [hl]
	ld [de], a
	wram_bank $02      ; attribute plane
	ld a, [hl+]
	ld [de], a
	inc de
```

The **same** source and destination addresses are read and written in two
different WRAM banks, one for each plane. So `$d7e0` denotes a cell in bank
`$03` *and* the matching cell in bank `$02`, and the `wram_bank $06` earlier in
the routine is there only because the temporary pointer it parks lives in bank
`$06` — which is exactly why `compute_wram_bank` attributes the call sites to
bank `$06` and why they must not be named as bank `$06` variables.

The same holds for `ld de, $d251` in `CharDataScreen_DrawStats`: a cell address
handed to a drawing routine that picks the bank itself.

**What that reveals is the screen's geometry.** `FlushCharDataTilemapChunk`
copies `wShadowTilemap + 15 * TILEMAP_WIDTH` to `$99e0` and `$d1e0` in bank `$02`
to the same address in VRAM bank 1 — so the visible map is 32 wide at `$d000`,
tiles in bank `$03` and attributes in bank `$02`, and `$d251` is row 18 column
17. The page images the slide animation patches from sit above them, up past
`$d800` in both banks. That is a real layout finding; it is not a set of names,
because the union model keys a symbol to one bank and these operands mean two.

### What was named

| | |
|---|---|
| `$d08e` `wCharDataNumberBuffer` | declared 2 bytes, actually **6** — `FormatExp24BitDecimal` puts a 24-bit value's top byte at +$00 and formats the low word to five places from +$01 |
| `$d0a0` `wCharDataStatsNoRacket` | the eleven stats recomputed as if nothing were equipped |
| `$d0ab` `wCharDataRacketDeltas` | what the racket is worth per stat, cleared first so an unequipped character shows no arrows |
| `$d145`/`$d147` | the two page-slide X offsets, one for the stat digits and one for the value column |

685 → 543 references, and roughly 240 of what remains is the argument-address
case above.

**The overlap guard added in the previous pass paid for itself immediately.**
`$d145` sits inside the `$d100-$d21a` union — the sound engine's WRAM, which
already carries a bank-`$06` variant because the EXP award screen reuses those
bytes. A new union there would have emitted both and overrun the bank; instead
the run stopped with `ram_unions overlap: $d145-$d149 and $d100-$d21a`, and the
offsets went into the variant that was already the right home for them.

## WRAM bank $02 had no SECTION at all (2026-07-28)

Of the seven WRAMX banks, `$02` was the only one with **no section in
`ram/wram.asm`** — zero symbols, zero named bytes, 162 bare references from
seventeen ROM banks. It was the most unknown bank by the plain measure, and the
reason it had stayed that way is that `$d000` means three different things.

| who | `$d000` | `$d400` | `$d800` | `$dc00` |
|---|---|---|---|---|
| the match (bank `$08`) | court tilemap | court attrmap | saved tilemap | saved attrmap |
| the overworld (bank 0) | 64-wide scroll plane | — | second scroll plane | — |
| every full-screen UI | attribute plane paired with `wShadowTilemap` in bank `$03` | page storage | | |

The match pair is proven by `UploadCourtTilemap` sending `$d000` to `$9800` in
VRAM bank 0 and `UploadCourtAttrmap` sending `$d400` to the same address in bank
1, with `SnapshotCourtTilemaps` copying `$d800`/`$dc00` back over both when the
players change ends. The screen pairing is proven by `FlushCharDataTilemapChunk`
sending `wShadowTilemap + 15 * TILEMAP_WIDTH` (bank `$03`) and `$d1e0` (bank
`$02`) to `$99e0` in VRAM banks 0 and 1. 141 references now render as cells.

### The default variant was wrong, twice over

The obvious shape was a **default** variant for the common screen case with the
match and overworld scoped over it. It assembled, it was byte-perfect, and it
was wrong — a default variant applies outside every *ROM range* the other
variants claim, and carries no WRAM-bank constraint at all. So it named:

- bank `$03`'s debug save-editor window at `$d300` — which is WRAM bank `$07`,
  the glyph buffer, identified two passes ago — as an attribute cell;
- and, via a whole-bank-`$08` scope on the match variant,
  `RefreshCourtScoreboard`'s `$de9x` bytes as `wCourtAttrmapSaved`, when bank
  `$08` reaches WRAM bank `$04` there. The give-away was `ld de, wObjSlot1 + 10`
  rendering in the same instruction pair: two symbols from two different WRAM
  banks, side by side, both claiming to be right.

The fix is the rule this pass has now hit four times: **every scope carries both
halves**, and the common case is scoped on `wram_bank` rather than left as a
default. That drops the reach from 419 references to 141 — and the 141 are the
ones where the bank is actually provable.

Worth stating plainly, because it is counter-intuitive: a default variant is
*less* safe than a scoped one, not more. It is the right tool only where the
alternatives are also scoped by ROM range and the whole union sits in one WRAM
bank by construction — `wMapScratch` qualifies, this did not.

## Bank $06 continued: a palette engine hiding under the stats (2026-07-28)

Picking up the 184 direct accesses left in WRAM bank `$06` turned up something
the previous pass had got wrong. Bank `$03`'s palette fade engine keeps its
buffers in bank `$06`, and its working buffer starts at **`$d0a0` — the same
address as `wCharDataStatsNoRacket`**, named last pass from
`CharDataScreen_BuildStats`. That name was scoped `{wram_bank: $06}` alone, so
it was rendering across five sites in `BackupMasterPalettes`,
`ClearWorkingPaletteBuffer` and `DesaturateWorkingPalettes`, where the bytes are
64 CGB colours and not eleven tennis stats.

The same over-reach had `wCharDataChoiceLog` — 100 bytes — claiming addresses in
banks `$03`, `$0e` and `$1e` that belong to none of it. Both are fixed by the
rule the last three passes keep arriving at: the character-data variant is now
scoped to banks `$1a`/`$1c`/`$1d` **and** WRAM bank `$06`.

**The palette engine, once separated, is legible:**

| | |
|---|---|
| `$d0a0` `wWorkingPalettes` | 128 bytes — the 16 palettes being faded |
| `$d140` `wMasterPalettesBackup` | the untouched copy taken at the same moment, so a fade always has an endpoint |
| `$d1e0` `wPaletteFadeMask` | one flag per palette, set from the bits of `b`, bit 7 = palette 0 |
| `$d1f0`/`$d1f9` | how far through the fade, and that divided by `$1f` — the per-component step |
| `$d1f2` `wPaletteColorSplit` | the two colours mid-interpolation, unpacked to r/g/b |

Its two 128-byte buffers straddle `$d0b7`, which was the boundary between two
unions, so those merged into one spanning `$d02a-$d21a`.

**The EXP distribution screen** (bank `$1d`) accounts for most of the rest:
`wExpPoolRemaining`/`wExpPoolTotal` are the point pool and its denominator —
`InitLevelUpScreenState` seeds both from `hl` and `AssignExpPointToChar`
decrements the first; `wExpBarMarkerX` sweeps from `$a8` home to `$18` and snaps
back; `wExpLevelUpFanfare` is `$ff` for one frame when a level is gained. It is
scoped to bank `$1d` alone because bank `$1a` keeps a different byte at `$d151`
— the high half of the pool total to one screen, a flags byte to the other.

Direct accesses in bank `$06`: **184 → 102**, across 45 → 31 addresses. What
remains there is the `$d000-$d003` block, which ten ROM banks share for the star
warp transition, cutscene text, the character viewer and the character-data
screen — four more variants, each needing its owner established first.

## Bank $06 finished off (2026-07-28)

Direct accesses in WRAM bank `$06`: **184 → 29**, across 45 → 7 addresses. Four
more subsystems came out of it, and the pattern by now is familiar enough to
state as a method: find the routine that *initialises* a block, and the block
names itself.

- **Trophy EXP** (bank `$1e`) — `ComputeTrophyExpAwards` writes one 16-bit word
  per trophy group while carrying a running sum in `hl`, so `$d02a` is five
  groups' awards, `$d034` is the per-group accumulator and `$d036` the total.
  Group 0's word lands two bytes lower, on the byte the character-data screen
  calls `wCharDataLevelPreview` — which is why the array is declared from
  `$d02a` and not from its real base.
- **The stat pages** (bank `$1d`) — `$d122` and `$d12f` are two 13-byte records
  thirteen bytes apart, main character and partner: four Spin/Power/Control/Speed
  levels, six values copied to `wCharStatPageShown` as the page slides in, three
  more the sync task reads. Spotting the stride is what made them a pair rather
  than two loose runs.
- **The star warp transition** (bank `$0e`) — a frame counter, a `$5a` countdown
  that starts the fade at `$1e`, and sixteen sparkle life counters that
  `UpdateStarWarpTrailSparkles` scans for the first free slot.
- **The EXP award screen** (bank `$1e`) — `wExpAwardRunningTotal` ticking up one
  point and one sound per frame against `wExpAwardAmount` counting down.

### Narrowing a scope is how the false names surfaced

Every one of these needed its variant scoped to a ROM bank *and* WRAM bank `$06`,
and each narrowing exposed names that had been wrong:

| symbol | was claiming |
|---|---|
| `wCharDataChoiceLog` (100 bytes) | addresses in banks `$03`, `$0e`, `$1e` belonging to none of it |
| `wCharDataNewLevels`, `wCharDataPage` | bank `$1e`'s EXP award total and message index |
| `wTrophyExpByGroup` | bank `$1e`'s shadow-tilemap cells, until the scope gained `wram_bank` |

The last was caught by the diff rather than by reasoning: `ld [wTrophyExpByGroup
+ 9], a` appeared in the middle of a run of `ld [wShadowTilemap + N *
TILEMAP_WIDTH + 19], a`, which is not a thing that happens.

### And two more merges the guard refused

The trophy array wanted to start at `$d028`, two bytes below a union boundary,
so the natural move was to merge the unions either side. The overlap guard
refused: the `$d02a-$d21a` union carries the sound driver's variant, whose scope
covers WRAM bank `$07` as well as `$06`, so merging down to `$d000` would have
made it collide with `wSndHramSave`. A union's bank set is the union of its
*variants'* banks, and that can be wider than the bank it is filed under.

**What remains in bank `$06`** is 286 argument-address references — the case
documented earlier, addresses passed to routines that pick their own bank — plus
`$d001`, which bank `$03`'s cutscene text window and bank `$0e`'s star warp both
write, and a handful of singletons.

## The guard that was missing (2026-07-28)

Bank `$06`'s direct accesses are down to **22 across 3 addresses** — the
character-data screen's backup pair (`wCharDataEditBackup` and the 101-byte
`wCharDataChoiceBackup`, which is how cancelling a level-up forgets every point
provisionally spent) and the value-sync pair. What is left is `$d001`, which the
cutscene text window and the star warp both write, and the argument addresses.

The interesting part of this pass is a bug I wrote and the compare caught.

Declaring `wCharDataEditState` as **6 bytes at `$d003`** looked right —
`BackupCharData` copies exactly six bytes from there. But `wCharDataLevel` and
`wCharDataNewLevels` are *inside* that run, already named, and
`_emit_union_block` lays a variant's symbols out sequentially:

```
if addr > cursor:  ds addr - cursor
emit symbol
cursor = addr + size
```

An oversized symbol makes `addr > cursor` false for the next one, so no padding
is emitted and **every symbol after it lands later than the address it was
declared at**. Nothing warns. The symbols still assemble, the section still
fits, and any ROM operand naming one of the shifted symbols quietly assembles to
a different word — which is why the only sign of it was `mariotennis.gbc` and
`baserom.gbc` differing at byte 335.

The emitter now refuses:

```
ram_unions: wCharDataLevel at $d004 starts inside the previous symbol,
which runs to $d009 -- shrink that one or make the two a single symbol
```

That message is from re-introducing the mistake deliberately to check the guard
fires on it. The real fix was smaller than the wrong one: `$d003` is a single
byte, `wCharDataPointsWorking`, and the six-byte backup unit is a fact for the
note rather than a size — the block is that byte plus two symbols that already
had names.

Three guards now stand between a plausible-looking union edit and a silently
wrong ROM: ram_map-inside-union, union-overlaps-union, and symbol-overruns-
symbol. All three were added after the mistake they catch, and all three were
found by a diff or a compare rather than by reading the JSON.

## `$d001`, three screens deep (2026-07-28)

One address, three owners, and the union model earns its keep:

| bank | name | what it is |
|---|---|---|
| `$0e` | `wStarWarpPathIndex` | how far the star has travelled, stepped by two a frame; `OffsetStarWarpPathPoint` indexes `StarWarpPathY`/`X` with it |
| `$03` | `wCutsceneTextScrollRows` | first byte of the current `TextPageDescriptors_03` entry — how many rows the page scrolls. `ScrollCutsceneTextWindow` masks it to two bits and reads zero as one, so a descriptor that forgets the field still scrolls a single row |
| `$1a`/`$1c`/`$1d` | `wCharDataAnimSubStep` | cleared at screen open and read by nothing in those banks |

That takes bank `$06`'s direct accesses to **15 references at a single address**,
`$d000` — and those are almost all argument addresses: `BlitCutsceneTextWindow`
loads `$d000` twice as source and destination and then reads it under WRAM bank
`$01` and writes it under bank `$05`, so neither operand belongs to bank `$06`
at all. Bank `$06` is done as far as names can take it.

### One thing left open, deliberately

Bank `$1e`'s continue prompt draws text at `$d021`, `$d041` and `$d061` — 32
bytes apart, so rows 1, 2 and 3 of a tilemap buffer at `$d000` — and then
uploads 128 bytes from `$d000` to `$9800`. But `$d000-$d003` already carry
`wContinuePromptKind`, `wContinuePromptRow`, `wContinuePromptPage` and
`wContinuePromptResult`, written as ordinary state in the same routine. Both
readings cannot be right: either those four names are wrong, or the prompt
uploads its own state bytes as the first four tiles of row 0.

Three references are not worth guessing over, so they keep their numeric
addresses until someone establishes which it is. Naming them either way would
bury the question.

## Bank $03's screens (2026-07-28)

WRAM bank `$03` is the screen-tilemap bank and was already 74% named, so what
was left there was per-screen state above the two planes: **131 bare references
→ 70**.

- **`$d840` `wCharUnlockFlags`** (bank `$38`) — 40 bytes, one per character.
  `BuildCharUnlockFlags` marks a character either because its
  `CharUnlockFlagsTable0` entry reads `$ffff` (always available) or because
  `TestSaveFlag` says so; `PackUnlockFlagsForLink` folds eight at a time into a
  bit each for the link exchange. The array runs straight through the
  ranking-banner bytes named two passes ago, so those became variants of one
  union rather than two unions side by side.
- **`$df00` `wCharGridHandedness`** — 0 right, 1 left, 2 not yet chosen. START
  toggles it with `xor $01`, but only when `IsMarioCastCharacter` passes, and 2
  becomes 1 on the first press. It picks one of the three pre-rendered labels
  30:150/151/152 that `IsMarioCastCharacter`'s own note describes.
- **`$db00` `wChartRows`** (bank `$3b`) — sixteen rows of seventeen bytes, a
  flag plus sixteen cells. Seventeen, not sixteen: `InitChartRowFlags` steps
  `$11` between row heads. That makes the array `$110` long, so it reaches
  `$dc0f` and its last row runs into the block below — which is exactly why
  `wChartColumnList` starts at `$dc01` and not `$dc00`.

### Two names were already taken, and both times that was the finding

`wCharSelectSlot` and then `wCharSelectHandedness` each failed to assemble as
duplicates. Neither was a naming collision to work around:

- `wCharSelectSlot` already exists at `$d814` and *is* the slot index, so `$df00`
  had to be something else — which is what sent me back to
  `HandleCharGridButtons` and turned up the handedness toggle.
- `wCharSelectHandedness` already exists at `$cb50`, the **story mode** screen's
  copy of the same idea. `$df00` is the exhibition and link grids' copy. Two
  screens, two bytes, one concept — so `wCharGridHandedness` for the grid, and
  both notes now point at each other.

rgbasm refusing a duplicate symbol is a weak check that keeps doing strong work:
twice in two passes it has caught a name that was wrong about *what the byte is*,
not merely about what to call it.

### Left open

`$dc20` is 64 bytes of expanded bits (`ExpandRowBytesToBits` clears four
16-byte units and fills them eight at a time) and it overlaps
`wRingShotEntryList` at `$dc40` — both in bank `$3b`. A ROM-bank scope cannot
separate two screens in the same bank, so this one needs code ranges, and 3
references are not enough to justify guessing at the boundaries.

## compute_wram_bank was one dict-ordering change from useless (2026-07-28)

The remaining bare references are dominated not by any bank but by the 431
sites where `compute_wram_bank` cannot prove a bank at all, so the next lever
was the analysis rather than more names. Two things were wrong with it, and the
smaller one is the interesting one.

**The idiom it could not follow.** Every routine in this ROM saves and restores
the bank the same way:

```
ldh a, [hWramBank]
push af
wram_bank $05
...
pop af
wram_bank
```

`ldh a, [hWramBank]` was treated as clobbering `a`, and the stack was not
tracked, so everything after the restore was unknown. Since the `wram_bank`
macro writes `hWramBank` and `rWBK` from the same `a` -- the only two raw
`ldh [rWBK], a` writes in the ROM are the boot clear and one preceded by the
shadow write across a label -- the shadow is a faithful copy, so reading it back
recovers the bank. Adding that plus a bounded push/pop stack (with `add sp`,
`ld sp` and `rst` dropping it to unknown rather than guessing a depth) makes the
restore resolve.

**The bug underneath it.** `ldh [rWBK], a` did `a if a is not NOINFO else UNK`.
NOINFO means *not reached yet*, not *unknown* -- and this lattice only descends,
so an instruction visited before its predecessors had settled was pinned to
unknown for good. With the stack in play NOINFO now propagates much further, and
the first attempt at all of this gained almost nothing because of it.

The consequence was worse than imprecision. Shuffling the worklist order:

| | provable instructions |
|---|---|
| before, natural order | 59,386 |
| before, shuffled | **8,640** |
| after, natural order | 59,820 |
| after, shuffled | 59,477 |

The old analysis produced a usable answer only because `deque(instrs)` happened
to walk in address order. Any change to how `instrs` iterates -- a different
dict ordering, a new pipeline stage inserting instructions out of order -- would
have silently collapsed WRAM-bank resolution to a seventh of what it was, and
the only symptom would have been thousands of operands quietly reverting to
numeric. The worklist is now `deque(sorted(instrs))`, explicitly, with a comment
saying the order is part of the answer.

**The gain in names is four operands.** That is the honest number, and it is
small because the real limit is elsewhere: the save/restore idiom restores *the
bank the routine was entered with*, and most routines are entered with an
unknown bank because they are called from several contexts. Getting past that
needs context sensitivity -- cloning the analysis per call site -- which is a
different piece of work. What this pass bought is that the 37% the analysis does
resolve is now robust rather than accidental.

## The tracer now records the WRAM bank, and it caught the analysis lying (2026-07-28)

The static dataflow had gone as far as it usefully could: 37% of instructions,
limited by context-insensitivity rather than by anything fixable. So the
connector now records the fact the disassembler cannot derive.

**Connector v3** (`gbc-disasm-mcp`): `TRACE_GET`/`TRACE_DUMP` carry
`rom_wram_bank`, a bitmask per `rom` entry with bit N set if bank N was selected
there at least once. One System Bus read per traced instruction. On this side,
`load_traced_wram_banks` reads the masks and `merge_traced_wram_banks` folds
single-bank observations in — filling gaps only, never overriding a static
proof, and reporting rather than silently resolving a disagreement.

**One short session** — main menu, exhibition, character select, a match —
19,066 instructions observed, of which 12,494 ran under exactly one bank.
**5,412 sites resolved that the dataflow could not.**

### Verifying the tracer before trusting it

The whole thing turns on *when* the exec callback fires. If it ran after the
instruction, every bank would be recorded one instruction early and the data
would be subtly wrong everywhere. `RunSoundEngine`'s `wram_bank $07` settles it:

| | observed banks |
|---|---|
| `$3373` `ld a, $07` (before the switch) | 1,2,3,4,5,6,7 |
| `$3377` `ldh [rWBK], a` (the switch itself) | 1,2,3,4,5,6,7 |
| `$3379` (after) | **7** |

The switch instruction still shows its callers' banks and only the instruction
after it is pinned to 7 — so the callback fires *before* execution and the value
recorded is the bank the instruction itself sees. That is the reading the merge
assumes.

### 142 places where the dataflow is confidently wrong

With the tracer verified, a disagreement means the *static* answer is wrong.
There are 142. They cluster in shared helpers -- `VectorFromLengthAndAngle` in
ROM0 (25), `SetupCharGridScreen` (27), `OffsetFromBallLanding` (17) -- which
points at the interprocedural propagation: a callee inherits the meet over the
call sites the CFG happens to contain, and any caller the descent never found is
silently excluded, so the meet looks unanimous when it is not.

Disabling that propagation is not the answer: it costs 22,679 provable sites and
removes only 24 of the 142. The other 118 have a cause I have not established,
and I would rather record that than guess at it.

**The blast radius today is zero, and for a reason worth naming.** Of the 142
disagreeing sites, nine carry a RAM symbol and all nine are WRAM0 names, where
the bank is irrelevant. Not one banked name rests on a wrong bank -- because
every scoped union written this week carries a ROM bank *as well as* a WRAM
bank. The rule that kept catching false names in review is also what kept an
unsound analysis from doing damage.

### It settled a question I had left open

Two passes ago I could not scope `RefreshCourtScoreboard`'s `$de9x` bytes and
wrote that they "are not court planes at all", reasoning from `ld de, wObjSlot1
+ 10` rendering beside them. The trace says the routine runs in WRAM bank `$02`
and those addresses *are* the saved court planes -- my tentative reading was
backwards, and `wObjSlot1 + 10` was itself the false name, from a bank-`$09`
union variant scoped by ROM bank alone. Its bank `$08` scope now carries
`wram_bank $04`; bank `$09` keeps the ROM-only scope, because that bank is the
object engine and never selects another.

## A second session, and the trace overrules the analysis (2026-07-28)

More driving -- the pause menu and rules screen, save-and-quit, the file select,
and the character-data screens whose WRAM bank `$06` took two passes to name.
Observations went 19,066 -> 25,683 and resolved sites 5,412 -> 5,756.

**Disagreements went 142 -> 885.** That is 3.4% of everything observed, and the
jump with only 6,617 more observations says the first sample had been flattering.
The dataflow is wrong far more often than one session suggested.

So the merge policy changed: **the observation now wins.** The reasoning is not
that traces are nicer than analysis, it is that these two claims are not the same
kind of claim. `compute_wram_bank` propagates a caller's bank into a callee, so a
routine inherits the meet over the call sites the CFG happens to contain -- any
caller the descent never found is silently excluded, and the meet looks unanimous
when it is not. A trace is what the hardware did, and the callback timing was
verified against a known switch before any of this was trusted.

### The audit found a name of mine that was wrong

Of the 885, exactly one carried a banked name: `1d:$4624`,
`ld hl, wShadowAttrmap + 3 * TILEMAP_WIDTH + 19`. The dataflow proved WRAM bank
`$03`; the hardware ran it in bank `$02`. Bank `$02` is right, and it is right
for a reason already written down two passes earlier -- the character-data
screens pair bank `$03` tiles with bank `$02` attributes, which is exactly what
`FlushCharDataTilemapChunk` demonstrates. The name was wrong, my own, and no
amount of reading would have caught it: the union trusted a dataflow result that
looked like a proof.

With the observation preferred it drops to a numeric `$d473`, because bank
`$02`'s `$d400` region is the page storage this project deliberately left
unnamed. An honest number in place of a confident falsehood.

The same change turned ~30 of bank `$1d`'s `ApplyTilemapPatchList` arguments into
`wScreenAttrmap + row * TILEMAP_WIDTH + col`. Those are the addresses documented
as unnameable because they denote a cell in two banks at once -- and they still
do, but the trace settles which bank is selected *at the call site*, which is the
question the scoping model actually asks.

### Where this leaves the two sources

The static analysis is now the fallback and the trace is the authority, for the
33% of the ROM a session reaches. That is the right way round: one is an
inference from a CFG known to be incomplete, the other is a record of what
happened. Every further session both extends the coverage and re-audits the
59,815 sites the dataflow still claims on its own.

## Third session: the trophies, the dictionary, the equipment screens (2026-07-29)

More driving -- clear status and the trophy list, the racket/shoes equipment
screens, the tennis dictionary and its entries, the file select, story mode as
far as name entry. **32,333 instructions observed, 6,853 resolved, 1,203
corrected.**

The corrections are now the interesting half, because they keep landing on
operands that had a *plausible* name rather than no name:

| site | was | is |
|---|---|---|
| bank `$1d` patch lists | `wDecompBuffer + 36 * TILE_SIZE` | `wScreenAttrmap + 18 * TILEMAP_WIDTH` |
| bank `$3e` equipment | numeric `$d1a0` | `wShadowTilemap + 13 * TILEMAP_WIDTH` |

The first is the one to look at twice. Those `ApplyTilemapPatchList` arguments
were rendering as offsets into the WRAM bank `$01` decompression buffer -- a
sensible-looking name, wrong by a whole bank. They are attribute-plane cells,
and now they read as the row and column they are.

That is the third time in three sessions that observation has replaced a
confident name rather than filled a blank, and it is the argument for keeping
this up: the value of a trace is not only the operands it names, it is the
operands it un-names.

## Story mode reached, with pause and a RAM read (2026-07-29)

The name-entry keyboard had defeated three attempts at free-run speed. The fix
was the two tools already there for it: **`pause_emulation`**, so a `step_frames`
runs exactly the frames asked and a d-pad tap moves the cursor exactly one cell,
and **`read_memory`**, to stop guessing the cursor position off a 160x144
screenshot.

`RunNameEntryScreen` reads `wMenuCursorY` and treats `$05` as the bottom row,
then indexes `NameEntryBottomRowActionTable` with `wMenuCursorX`: 0-9 is DEL,
10-14 is accept. Reading `$cb04` said X was already 10 and Y was 1 -- so the
cursor had been on the END *column* the whole time, four rows too high. (My
first read had been at `$cb64`, an arithmetic slip, which is why the pair looked
stuck at zero.) Setting the pair and pressing A walked straight through.

Two verifications fell out of it. `$d800` read back `AlexA6(` -- that is
`wNameEntryBuffer`, named this week, confirmed against hardware. And holding a
direction across consecutive `step_frames` calls counts as **one** press, not a
repeat; a tap needs a press step and a release step.

**Story mode is now traced**: the overworld, the actor engine, the map scripts,
the speech bubbles. `wActors + 1 * ACTOR_SIZE` appears in bank `$38` where the
address had been a bare `$d040`.

Four sessions now: 37,313 distinct instructions observed, **8,921 resolved that
the dataflow could not, 1,255 corrected**. Bare banked references are 3,034,
from 4,300 when the banked half was first surveyed.

One correction went the other way and is worth recording: `ld bc, wCharPosX`
became `ld bc, $df00`. `$df00` is the per-character match struct in WRAM banks
`$04-$07` and the character-select handedness byte in bank `$03`; the trace says
that site runs in neither, so the name it had was wrong and a number is the
honest answer until something proves otherwise.

## A check, not an abstraction (2026-07-29)

The recurring problem all week has been a union variant scoped by ROM bank
alone: it matches every site in that bank whatever WRAM bank is selected there.
Four false names came from it, each caught by hand or by a trace. The obvious
response is a better way to *express* multi-bank structures -- the per-character
struct at `$df00` declares its four banks plus sixteen ROM banks as twenty
separate scopes, which is verbose and easy to get wrong.

Measuring first said otherwise. Of the references naming a field of that struct:
353 sit where WRAM bank 4-7 is provable, **0 sit where another bank is
provable**, and 458 rest on the ROM-bank scopes at sites where the bank cannot
be proved. Those scopes are load-bearing -- deleting them would cost 458 real
names -- and they are not currently lying. The verbosity is a wart; the hazard
is latent.

So the useful thing was not a new abstraction but a **check**:
`audit_rom_only_scopes` reports any scoped symbol that renders where the
provable WRAM bank is not one its union claims. It only fires where the bank is
*provable*, so it stays silent about the sites a ROM-only scope legitimately
covers, and every hit is either a false name or a bank set that wants widening.
Traced banks are what give it teeth -- before this week most of these sites had
no provable bank at all.

It found **36 false references on the first run**, in two variants that had
never been suspected:

| symbol | was naming |
|---|---|
| `wContinuePromptKind` (bank `$06`) | the results screen's tilemap planes in banks `$01`, `$02`, `$03` |
| `wCharViewerRow` (bank `$06`) | the same, in the debug character viewer |

Adding `wram_bank $06` to both scopes fixed all 36, and **not one became a bare
number** -- every single one resolved to the name it should always have had:
`wDecompBuffer`, `wScreenAttrmap`, `wShadowTilemap`. The audit is clean now, and
it runs on every regeneration.

That is the fourth guard of this kind: ram_map-inside-union, union-overlaps-
union, symbol-overruns-symbol, and now scope-names-the-wrong-bank. Each was
added after the mistake it catches, and each turns a class of silent error into
a line of output.

## Mirrored WRAM structures

Some structures are not one bank's, and not several banks' separately: they are
one address range holding a *parallel copy* in each of several WRAM banks. The
character-data screen keeps its stat pages this way -- tiles in bank `$03`,
CGB attributes in bank `$02` -- so saving a page is one copy per bank to the
very same word:

```asm
	wram_bank $03
	ld hl, wShadowTilemap
	ld de, wCharDataPageSlot1
	call CopyMemoryFast
	wram_bank $02
	ld hl, wScreenAttrmap
	ld de, wCharDataPageSlot1     ; same address, other plane
	call CopyMemoryFast
```

Before this pass the first `ld de` rendered as `wShadowAttrmap + 31 *
TILEMAP_WIDTH` and the second stayed a bare `$d7e0`, which read as two
unrelated addresses and hid the one fact that matters. Neither name was right:
that range is not an attribute map at all, it is page storage that happens to
sit where `wShadowAttrmap` sits on every other screen.

A variant marked `"mirrored": true` names the whole set. It matches when the
site's bank is any of the banks its scopes list **or when the bank cannot be
proved**, and still loses to a bank proved to be outside the set -- ROM bank
`$1d` alone drives WRAM banks 2, 3 and 6 over these same addresses, so dropping
the constraint outright would hand `$d4xx` the wrong name. Because the claim is
that wide, every scope must carry a ROM `bank` and at least two distinct
`wram_bank`s must be named; both mistakes are rejected at load.

The subtle part is that a mirrored variant **allocates nothing**. Each of its
banks already declares those bytes in its own union, so the first attempt --
filing it under one bank's SECTION -- tripped the union-overlap guard, exactly
as it should have. It is emitted instead as an EQU into the generated
`include/ram_mirrored.inc`, preincluded for every bank, because an EQU is
assembly-time only and unlike an exported `::` label has to be visible while
each bank is assembled.

Two declarations (the base plane, and three 576-byte page slots at `$d7e0`,
`$da20`, `$dc60` whose rows sit `8 * TILEMAP_WIDTH` apart) took the bare
banked-WRAM operand count from **827 to 745**, byte-perfect throughout.

## What is left, and which fix each part wants

`tools/ram_gaps.py` splits every remaining bare `$dxxx` operand into buckets,
because each wants a different fix and the split is what makes the rest
mechanical:

| bucket | count | the fix |
|---|---|---|
| unproven | 615 | no trace covers the site and the dataflow cannot pin the bank -- nothing to name it from |
| unclaimed | 70 | bank proved, nothing names the address yet: ordinary naming work, bank already settled |
| rom-scoped | 30 | a variant covers it in the proven bank but is scoped to other ROM banks -- widen it, or add a variant if it is a different subsystem's overlay |
| mirrored | 30 | genuinely several banks at once: declare a mirrored variant |

The tool also lists mirrored candidates directly -- one address, several
observed banks, one routine -- which is how the page slots were found:

```
$d000  banks 2,6  from $1d:ApplyTilemapPatchList
$da20  banks 2,3  from $1d:SaveWorkTilemapToPage
$dc60  banks 2,3  from $1d:SaveWorkTilemapToPage
$d580  banks 1,2,3  from $18:LoadCharacterRecordToBuffer
$d600  banks 2,3,4  from $1b:CopyMugshotBufferToVram
```

The `unproven` 615 dominate, and only more coverage moves them: instruction
coverage across the ROM is 29%, and these sites are in screens no trace has
reached (the save editor, the exp screen, most minigames).

## Bank-tagged copies, and what a symbol file can hold

The per-character match struct at `$df00` lives in all of WRAM banks 4-7 at
once, one copy per character. It used to be a single `SECTION` with no `BANK[]`,
left for the linker to park somewhere -- and it parked it in bank 4. That was
tidy but not true, and the symbol file showed the cost: 82 entries, every one
tagged `04:`, so a debugger stopped with bank 6 selected could not resolve
`wCharPosX` at all.

The fix is both forms at once. Each bank declares its own copy under a
bank-tagged name in its own `BANK[n]` section:

```
04:df00 w4CharPosX      ; near-P1
05:df00 w5CharPosX      ; far-P1
06:df00 w6CharPosX      ; near-partner
07:df00 w7CharPosX      ; far-partner
```

and the untagged `wCharPosX` survives as an EQU, because which copy a site
means is decided by the WRAM bank selected at run time. `src/*.asm` is
unchanged -- not one operand moved -- while `build/mariotennis.sym` goes from
82 entries that are right a quarter of the time to **328 that are always
right**.

The reservation this restores is the lesser half of it. Nothing was ever at
risk of being placed on those bytes: every other WRAMX section fixes both its
address and its bank, so there was no floating section for the linker to
misplace. What the tagged labels actually buy is symbol-file coverage, which
EQUs cannot give -- they never reach `.sym` at all. A bank whose own section
already runs past the addresses is skipped, which is why the mirrored
character-data pages get no such sections: banks 2 and 3 already declare those
bytes.

## The unclaimed bucket, emptied

`unclaimed` -- an address whose WRAM bank is proved but which nothing names --
is now **0**, down from 70. What the work turned up is worth more than the
count:

- **Ten "bank $06 variables" were not variables at all.** `CharDataScreen_-`
  `WriteStatNumber` writes its `de` argument under bank `$03` and then `$02`,
  so the bank live at the call site (`$06`, the screen's own working set)
  describes the caller and not the operand. The same holds for `DrawStatBar`
  and the tilemap-patch routines: 33 references were screen cells all along.
- **`CopyScoreboardTileColumn` reads under bank `$04` and writes under `$02`.**
  Neither operand belongs to the call site's bank, and three `ld hl` operands
  were already rendering as `wCourtAttrmapSaved` cells when they are scoreboard
  columns in a different bank entirely. That one was a wrong name, not a
  missing one.
- **`wCharQuickSwing` was declared on a menu-bank variant** of the character
  struct, where no site could reach it -- it rendered nowhere in the ROM.
- **Three bytes are vestigial**: `$df4d`, `$df4e` and `$df55` are written on
  three paths each and read on none. They are named for what the writes do,
  with the absence of any reader recorded.
- **`$d8f0` at `00:$199d` and `00:$1a40` is -10000**, not an address; it sits
  beside the `ld bc, $2710` it pairs with. Curated numeric, like the twin site
  already listed in `RAM_IMM_IS_CONSTANT`.

Two addresses are identified but deliberately left numeric. `$cfb3` and
`$cff0` in the tennis dictionary are *pre-step* bases: their loops add `$80`
and `$40` before storing, so the first byte actually written is at `$d033` and
`$d030` -- `wShadowTilemap + 1 * TILEMAP_WIDTH + 19` and `+ 16` under the
`wram_bank $03` set two instructions earlier. The operand points below `$d000`,
at no variable at all, and any name given to it would be a fiction.

`tools/ram_gaps.py` now also excludes WRAM0, which is not bank-switched and so
has no "which bank?" question, and the curated arithmetic constants, which are
not addresses. Bare banked-WRAM operands: **827 at the start of this work, 590
now**, byte-perfect throughout.

## Curated labels no longer state their own address (2026-07-29)

`CharStatTable_07_5c4a` is a name that asserts where the table is. Insert
sixteen bytes ahead of it and it is at `$5c5a`, still called `_5c4a`, and the
name is now a lie the assembler will not catch -- the whole point of this tree
being relocatable is that addresses move. **648 curated labels carried an
address suffix; none do now.**

Two schemes, picked per label:

* **Owner-derived (229).** Where a label has exactly one distinct referencing
  routine or table, it takes its name from that consumer -- the convention
  already used for graphics blobs ("strip the verb from the loading function").
  `DrillShotTable_0b_4b8d` is loaded by `ServiceMatch2JudgePoint` and nothing
  else, so it is `ServiceMatch2JudgePointDrillShotTable`. The derivation
  chains: the nine `SpawnMinigameTargetFormationN` routines name their pointer
  tables `MinigameTargetFormationNScriptPtrs`, and those in turn name the 57
  scripts they point at `MinigameTargetFormationNScriptM`, so a formation reads
  as one family:

  ```
  MinigameTargetFormation1ScriptPtrs:
          dw MinigameTargetFormation1Script0
          dw MinigameTargetFormation1Script1
          ...
  ```

* **Bank + ordinal (419).** Everything else: unreferenced blobs, labels with
  several unrelated consumers, and the families where uniformity is worth more
  than per-item derivation -- `ActorScript` (256), `Padding`, `StubNop`,
  `Unused`. `ActorScript_0e_5f2a` becomes `ActorScript_0e_03`, numbered in
  address order within its bank. The ordinal is still positional, but it is an
  *index into a family*, which is what these are, rather than a claim about
  where the bytes sit.

### What the derivation had to be taught

The naive `<owner><stem>` join produces stutter, and the stutter is where the
information already was: `MinigameTargetFormation0` + `MinigameTargetScript`
gives `MinigameTargetFormation0MinigameTargetScript0`. The join now drops the
word overlap between the two -- whether it sits at the tail of the owner
(`Player1ServeIndicatorSprite` + `SpriteTemplate` ->
`Player1ServeIndicatorSpriteTemplate0`) or at its head (the formation case
above, -> `...Formation0Script0`) -- and drops the noun entirely when it says
nothing the owner does not: `LookupTileId` + `TileIdLookup` is just
`TileIdLookup`. Plural and singular count as the same word, or
`LoadCourtDiagramObjPalettes` would have produced
`CourtDiagramObjPalettesPalette`.

Two rules keep it honest rather than merely tidy. An owner that is itself only
ordinal-named contributes nothing, so its dependents fall back to ordinals
instead of inheriting a number twice (`ActorList_11_0ActorList` was the first
draft of one of these). And any name that collides with an existing symbol
falls back to the ordinal -- three did, including a `TitleScreenPalettes` that
already existed.

### The 38 auto-style pins are deliberately untouched

`Data_14_5ed0` and its 37 siblings are curated *entries* whose value is an
auto-style *name*: they exist to anchor a label at an offset the generator
would not otherwise split, and the auto style is what marks them as still
unidentified -- `tools/progress.py` counts them as unnamed, which is correct.
Renaming them would have inflated the naming metric with fiction.

### What is left

408 address-suffixed labels remain in `src/`, and none of them come from
`labels.json`: 180 are the generator's own `Data_`/`Label_` autonames, and 228
are synthesized by the *naming stage* -- `SpriteTemplate_*` (136, spread over
29 banks) and `OamPtrs_*` (92, the walk-sprite banks) -- from the offset the
blob was split at. Those want a generator change, not curation; the section
below is that change.

Byte-perfect throughout; `make check` unchanged (619 LZ streams, 13 text pools,
4,908 regions).

## The generator stops naming blobs after their offset (2026-07-29)

The 228 above were the last address-suffixed names that no amount of curation
could remove: they are minted in `build_labels`, one per carved blob, and any
`labels.json` entry for them would be 228 hand-written names for something the
generator can derive. It now derives it. **Non-auto address-suffixed labels in
`src/`: 0** (180 `Func_`/`Label_`/`Data_` autonames remain, which is what
"unnamed" looks like).

One helper does both families, `name_owned` in `disasmlib/labels.py`: a blob
with exactly one owner whose own name is not itself auto-generated becomes
`<owner>_<stem>`, numbered when one owner holds several; everything else falls
back to `<stem>_<bank>_<N>`. The underscore join is the convention the
walk-sprite records already used for their `_Gfx00`/`_Oam00` blobs.

* **Sprite templates** (`call QueueSpriteTemplate` operands) take the routine
  that loads them. `carve_sprite_templates` already backtracked each call to
  the `ld hl, imm` that set the pointer; it now records that site, and the
  naming stage resolves it to the enclosing global code label by bisecting the
  code labels it has assigned so far. `SpriteTemplate_0a_670e` ->
  `DrawMinigameTarget_SpriteTemplate`. 131 of the 136 were named this way; the
  other five were already curated.
* **OAM pointer arrays** take their object header: `OamPtrs_70_4c40` ->
  `WalkSprite_70_00_OamPtrs`, so the header reads
  `dw .frames, WalkSprite_70_00_OamPtrs, .frames` and the array's own contents
  (`WalkSprite_70_00_Oam00`...) are visibly the same record. All 92 resolved.

### Where the name has to live

The OAM array is the one label that is *not* in `labels`: `follow_oam_arrays`
deletes its data blob and registers the name in `dis.ptr_labels`, because that
is the table the object-header renderer reads to spell its own `dw`. Putting
the derived name in `labels` alone gave a definition and a reference that
disagreed -- a label rgbasm would not resolve. So `follow_oam_arrays` no longer
names anything (it just records array -> header), and the naming stage writes
into `ptr_labels`, which keeps definition and reference the same string by
construction. The first attempt also silently did nothing at all, because
`name_owned` skips targets that already carry a name and carve had already put
one there.

Byte-perfect, `data.manifest` unchanged (no blob boundary moved), `make check`
clean, and `tools/progress.py` reports the same 19,921 of 21,680 named --
`SpriteTemplate_*`/`OamPtrs_*` never matched its auto-name pattern, so the
metric was already counting them as named. That is the argument for the change
being a real one rather than a cosmetic one: the names were passing for
knowledge and were not carrying any.

## The autonames, identified (2026-07-29)

179 labels in `src/` still carried the generator's own `Data_`/`Label_` name.
**161 of them are now named, and three of them were not data at all.** What is
left is 18, and they are all the same shape -- see the end of this section.

### The `Label_*` were all dispatch slots (25 of 25)

Every one was a `dw` in a named pointer table, so each names itself from the
table and its slot index: `ProportionalTextCodeHandler4_05` (which serves slots
4, 7, 8, 9 and 11 of `ProportionalTextCodeHandlers_05`),
`CharInputHandler1_08`, `EraseSavedDataFlowHandler0_10`,
`MessageSpeedSettingHandler4`, `MinigameLevelSelectGfxHandler0`.

`WaterSpriteModeHooks_10`'s six got role names instead of indices, because
`CallModeHook`'s slot roles are established: `WaterSpriteHook_Frame`,
`_PointStart`, `_PointEnd`, `_BallHit`, `_Bounce`, `_RallyTick`. Three of them
are the consecutive `ret` bytes at `$4be8`, `$4be9` and `$4bea` -- three
separate one-byte stubs, because a table slot needs its own address even when
the hook does nothing.

### Bank $17 was 76 of the 179, and one pattern

The drill-briefing animations are driven by per-step tables, one table per
animated element, indexed by `wBriefingAnimStep`. Each table's meaning is
whatever field the routine stores its value into, so the name comes from
there -- `SpinServeBriefing_AdvanceAnim_BracketPosTable` is read into
`wBriefingBracketX`/`Y`, `..._HMarkerUnflippedTable` into
`wBriefingHMarkerUnflipped`. Where both animation phases of a briefing share
one table the phase drops out of the name
(`SpinServeBriefing_RotMarkerDirTable`). The three tables whose value goes
straight to `DrawDiagramTargetOverlay` in `b` rather than into a variable are
`..._TargetOverlayTable`. 72 named this way.

A side finding: several of those tables render as `INCLUDE
"data/bank_017/text_*.asm"`, i.e. the text classifier claimed them. They are
16-byte coordinate tables whose bytes pair up as `<value>, $00`, which is
exactly what an ASCII string with `$00` terminators looks like. Byte-identical
either way, but `tools/strings.py` will list them as game text, and they should
be declared `bytes:4`.

### The other 52 name themselves from their one consumer

A blob read by exactly one routine takes that routine's name, plus the field it
feeds when the value has a single destination: `SelectServeShotType_-`
`CharShotTypeTable`, `SetupCharacterSprite_CharTileBaseTable`,
`DrawLandingMarkerTable`. Where the value fans out to several variables the
field says nothing about the table, so the routine name carries it alone
(`LaunchBallTable`, `LoadCourtSceneDataTable`).

Four are read by two routines each, and are named for their content instead:
`DpadToFacingTable_08` (d-pad nibble -> `wCharFacingDesired`, `$ff` meaning "no
change"), `AngleToDpadTable_08` (the 16 coarse angles from
`AngleFromVectorCoarse` back into `wCharInputBits`),
`CharDataArrowBobOffsetTable_1d`, `IslandOpenSinglesStageTextPtrs_0f`.

### Three were code, and one table was a record short

* **`$43b9` and `$43cb`** are the two-instruction prologues (`ld d, $00` /
  `ld a, c`) of twin linear-index-to-grid divides. The loops that follow were
  already proven code; the entries were never executed, so three bytes of each
  routine sat in front of it as a `bytes:3` blob. Seeded as code, they are now
  `SetMenuCursorFromLinearIndex_17` (remainder -> `wMenuCursorX`, quotient ->
  `wMenuCursorY`) and `WriteGridPosFromLinearIndex_17` (same divide, stored
  through the caller's `hl`).
* **`$4a1b`** was a 23-byte blob that decodes as `ld c, $04` / `ld b, $09` /
  `ld hl, $4a29` / `ld de, $2020` / `call QueueSpriteTemplate` / `ret`,
  followed at `$4a29` by two `oam_sprite` records and an `$80` terminator.
  Seeding the entry was enough: the sprite-template carver found the call,
  and the naming pass named the list after the routine
  (`QueueSpritePair_17_SpriteTemplate`). None of the three has a proven caller,
  which is recorded in each one's note rather than guessed at.
* **`$4a94`** was five bytes after `DiagramTargetPatchRecords_17`, which was
  declared as five 6-byte records. Six records is 36 bytes and reaches exactly
  to `DecompressGraphicsList` at `$4a99`; the sixth record reads
  `dw $d300, $d0e7, $0206`, in the pattern of its five siblings. Dropping the
  boundary makes the table whole.

### The 18 that are left, and why

Every one is a table declared in `data_tables.json` whose reader is not in
proven code: `Data_38_4971`, `Data_38_560a`, `Data_38_5672`, `Data_38_57d7`,
`Data_38_5b6f`, `Data_38_5ffe`, `Data_38_7063`, `Data_27_4b41`,
`Data_27_5570`, `Data_27_7886`, `Data_1b_69cd`, `Data_1b_7349`,
`Data_1a_4af4`, `Data_29_4221`, `Data_6b_615e`, plus `Data_5f_4020`,
`Data_5f_4c63` and `Data_6d_6104`, which are `$4000`-slot targets in data banks.

The searches that found the other 161 all come up empty on these: no `ld hl`,
no `dw`, no `add LOW`/`adc HIGH` pair, and no raw `$xxxx` immediate anywhere in
any bank. Their extents were established by an earlier structural pass without
a reader being recorded, so naming them would be naming a guess. They are the
honest remainder: **the places where the disassembly knows the shape of the data
and not yet who reads it.**

Human-named symbols: **20,082 of 21,680** (from 19,921). Byte-perfect
throughout; `make check` clean.

## Three of the eighteen unreferenced tables, identified (2026-07-29)

"No reference in proven code" is itself a lead: if nothing proven loads the
address, the code that does is *not proven*, so it is sitting inside a data
blob. Two searches follow from that, and between them they resolved three of
the eighteen -- and two of the three were not tables at all.

### Search 1: the address as an immediate, anywhere in the ROM

Scan all 2 MiB for every form that materialises the address -- `ld hl/de/bc,
nn`, the `add a, LOW` / `adc a, HIGH` split-base pair, `ld l` / `ld h` -- and
report whether each hit lands in an extracted blob or in code the disassembly
already covers. **Thirteen of the eighteen are never loaded as an immediate
anywhere in the ROM**, and the handful of hits that did turn up are byte
coincidences inside graphics banks (`$01 $49 $73` reads as `ld bc, $7349`).

That result is worth more than it looks: an address that is never materialised
is not reached by a pointer load at all. It is reached as an offset from some
other base -- which is what a false table boundary looks like, and is exactly
how `DiagramTargetPatchRecords_17` turned out to be a record short.

### Search 2: the same bytes in a sibling bank

Several of these banks are near-copies of each other, so take 48 bytes of
context around the table and look for it in all 127 other banks; where it
turns up, report the label at the matching offset and whether the sibling
proved those bytes as code. Two hits, both decisive:

* **`Data_29_4221`** -- the same bytes sit at the same address in banks `$20`,
  `$21`, `$22`, `$23`, `$2a`, `$2b` and `$2c`, in every one of them as proven
  code. Decoded, it is `push hl` / `push bc` / `ld hl, wShotAimAngle` / ... /
  `call VectorLengthFromAngle` -- the aim-row lookup that follows
  `SetBallTargetFromAim`. Bank `$29`'s traces never entered it, so 16 bytes of
  it read as data. Seeded, it also surfaced the jump target at `$4247`, which
  the four twins already curate as `.readEntry`.
* **`Data_27_7886`** -- 32 bytes matching banks `$0e`-`$13`, where they are
  `MapScriptClearActiveFlag_10` and the two three-byte primitives after it.
  Bank `$27` has its own `MapScriptNop_27` immediately above, so this is the
  same trio one bank over: `MapScriptClearActiveFlag_27`, a sound-and-return,
  and a clear-show-location-name. Three seeds, thirteen bytes of code.

Nothing else has a byte-identical sibling, at 48 bytes of context or at 10.

### One named from its shape

**`Data_38_5b6f`** is 36 bytes of `$01` with `$00` at slots `$09`-`$0e`. It
sits immediately in front of `CharGridFromUnlockFlagsTable`, and it is exactly
the thing `BuildCharGridFromUnlockFlags` reads through `hl`: one byte per grid
slot, `or a` deciding unlocked, 32 iterations. Named `CharGridUnlockMask_38`
for that format, with a note saying so and saying that no proven code loads it,
so *which* caller passes it -- and whether the six zeroed slots are a default
roster or a debug one -- is not established.

### What the remaining fifteen need

`Data_38_4971`, `_560a`, `_5672`, `_57d7`, `_5ffe`, `_7063`, `Data_27_4b41`,
`Data_27_5570`, `Data_1b_69cd`, `Data_1b_7349`, `Data_1a_4af4`,
`Data_6b_615e`, and the `$4000`-slot targets `Data_5f_4020`, `Data_5f_4c63`,
`Data_6d_6104`.

Static analysis is out of moves on these: no immediate load, no sibling, and no
base within 256 bytes whose indexing reaches them. What is left is the thing
that proved every other byte in this disassembly -- **execution coverage**. The
banks say which screens to drive: `$38` is character select and name entry,
`$1b` the saved-data and unlock-debug screens, `$1a` the EXP screen, `$27` a
training-court scene, `$6b` the intro cutscene. Proving the reader makes the
reference appear, and then the table names itself the way the other 161 did.

`Data_38_5ffe` is the one with a structural smell rather than a coverage one:
it is 19 bytes past `CpuDifficultyToCharRecordsSubHandlers`, a `records:2`
table, and 19 is not a multiple of 2 -- the boundary is in the wrong place, the
way `$4a94` was.

Autonames in `src/`: **15**, from 179. Byte-perfect throughout.

## Driving the game disproved the coverage theory (2026-07-29)

The previous section said the fifteen unreferenced tables needed execution
coverage of the screens that use them. **That was wrong, and driving the game
is what showed it.**

Traced a full run into bank `$38`'s territory: main menu -> Exhibition -> play
menu -> character select (cursor moves, the START handedness toggle, both
player slots) -> the CPU Difficulty submenu (all four options) -> court select
-> grass court -> match start. 14,562 ROM addresses executed, 2,019 of them in
bank `$38`.

**The regeneration produced a zero diff.** `src/` unchanged, `data.manifest`
unchanged, bank `$38` still 13,540 bytes at 82.6%. Every address the session
executed was already proven; the whole path -- including the grass-court init
that the skill's open-targets list still names -- was covered by earlier
sessions. Not one of the six bank-`$38` tables gained a reference.

In hindsight the earlier search had already ruled coverage out and I misread
what it meant. If **no instruction anywhere in the ROM** loads an address as an
immediate -- and that search reads raw ROM bytes, so it sees unproven code
inside blobs just as well as proven code -- then no amount of proving code can
make a reference appear. There is no reference to find. The right conclusion
from that search was "these are not reached by a pointer load", not "the
pointer load is in code we have not proven yet".

### The search that was actually missing

Every earlier search looked for the address as the *operand of a load*. None
looked for it as a bare `dw` word in a pointer table that is itself still an
INCBIN blob. Searching the raw byte pair ROM-wide, and reporting which blob or
in-source region each hit lands in, found the three that were reachable all
along -- all in their own bank's `$4000` slot table:

| was | is | evidence |
| --- | --- | --- |
| `Data_5f_4020` | `ClubhouseScenePalettes` | slot 1 of the clubhouse group |
| `Data_5f_4c63` | `CourtyardScenePalettes` | slot 1 of the courtyard group |
| `Data_6d_6104` | `IntroCharactersPalettes` | bank `$6d` slot `$20` |

All three are 64-byte `palettes` blobs. Bank `$5f` holds two 8-slot scene
groups whose roles line up by position -- aux tilemap, **palettes**, tilemap,
attrmap, aux tilemap, aux attrmap, spare, tiles -- and *both* groups' slot 1
points at a palette set, which is what fixes the role. Bank `$6d` settles its
own case: the group above holds `IntroGreatestPlayer` Tiles/Tilemap/Attrmap/
**Palettes**, so the slot sitting right after `IntroCharactersAttrmap` is that
group's palette set. The contents agree (character colours with grey filler in
the three unused palettes).

A side finding in bank `$5f`: the clubhouse group's slot 6 -- the slot the
courtyard group leaves unused -- points at the *courtyard's* palette set. Reuse
rather than intent, most likely.

And the reason nothing named them automatically: **no observed call site ever
requests those slots.** Bank `$6d` slot `$20` is absent from both hook dumps,
whose `l` values step `$1e` -> `$22` straight past it. The slots are proven (a
pointer in a proven table extent that decodes as valid data); the request is
not. Each name records that in its note, so the basis is position and content
rather than a caller.

### Twelve left, and what they actually are

`Data_38_4971`, `_560a`, `_5672`, `_57d7`, `_5ffe`, `_7063`, `Data_27_4b41`,
`Data_27_5570`, `Data_1b_69cd`, `Data_1b_7349`, `Data_1a_4af4`,
`Data_6b_615e`.

No immediate load, no `dw` in any bank, no byte-identical sibling, no base
within 256 bytes that reaches them, and -- now demonstrated for the six in bank
`$38` -- no missing coverage. What is left is one of two things, and both are
structural rather than observational: a false boundary inside a larger object
(`Data_38_5ffe` sits 19 bytes past a `records:2` table, and 19 is odd), or data
nothing reads. Naming them means proving which, table by table, against the
code that surrounds them.

Autonames in `src/`: **12**, from 179. Byte-perfect; `make check` clean.

## The last twelve: three tables were a lie, two blobs were routines (2026-07-29)

**Every autoname in `src/` is gone.** The twelve that survived every search
split three ways, and the largest group was not "unread data" at all -- it was
data the disassembly had already claimed as *code*.

### Three "SubHandlers" tables in bank $38 were never handler tables

`Data_38_5ffe` was a 3-byte crumb wedged between two `SubHandler*` functions,
19 bytes past a `records:2` table -- and 19 is odd, which is what made it worth
pulling on. What came out is that **all three** of bank `$38`'s `SubHandlers`
tables are pointer tables to *records*, and their thirteen "handler functions"
were nonsense decodes standing on hand-authored static-code seeds.

The discriminator is one instruction. All four candidate tables do the same
dereference -- `ld a, [hl+]` / `ld h, [hl]` / `ld l, a` -- and then:

| table | after the dereference | verdict |
| --- | --- | --- |
| `DrillSubHandlers_1d` | `jp hl` | **genuine** handler table |
| `CharGridSlotIconListPtrs_38` | walks 4-byte records to `WriteSlotIconTiles` | data |
| `CpuDifficultyParamPtrs_38` | `[hl+]` into `wPlayer*PartnerAiParams` | data |
| `RemoteSlotBoxAddrPtrs_38` | indexes again, reads one word | data |

`jp hl` means code. Reading bytes means records. Thirteen seeds removed, 108
bytes of false code gone, and the structures now read as themselves:

* **`CpuDifficultyParamPtrs_38`** -> five 6-byte records: four AI parameters,
  the difficulty byte, and an EXP tier read only for non-created characters.
  Records 1-4 ramp monotonically -- reaction delays 28/18/10/2, tracking
  60/120/190/230, difficulty 0/1/2/3, tier 1/3/5/7 -- which is what names them
  `CpuDifficultyParams{Easy,Normal,Hard,Intense}`. Slot 0 duplicates INTENSE
  and is what an unset difficulty selects. That table is the CPU difficulty
  submenu, in six bytes a row.
* **`RemoteSlotBoxAddrPtrs_38`** -> `RemoteSlotBoxAddrs0-3`, `ram_ptrs`
  tables that now render `dw wShadowTilemap + 6 * TILEMAP_WIDTH + 16` and
  `dw NO_BOX`. It is the exact remote-player twin of the already-correct
  `PlayerSlotBoxAddrPtrs_38` -> `PlayerSlotBoxAddrs0-5`, which is what made it
  obvious once the fake code was out of the way.
* **`CharGridSlotIconListPtrs_38`** -> four `$00`-terminated lists of 4-byte
  icon records, indexed by `wCharSelectMode`.

### Two blobs were complete routines

* **`Data_1a_4af4`** (43 bytes) decodes as one push/pop-balanced routine that
  walks the 32-word table immediately above it -- `c` over rows `$0b`-`$0e`,
  `b` over columns `$01`-`$08`, 4 x 8 = exactly 32 entries -- calling
  `WriteTileBufferCell` per cell. Now `FillTileBufferBlockFromTable_1a` and
  `TileBufferBlockCells_1a`, with its four loop targets as locals. Its own
  `ld hl, $4ab4` landing exactly on that previously-unnamed table is the
  corroboration.
* **`Data_6b_615e`** (30 bytes) decodes as a routine that guards on
  `wCutsceneStepTimer` and `[$c323]`, then reads `$c322`/`$c323` into `hl` and
  writes both back unchanged -- a **no-op**. Now `RewriteCutsceneCameraY_6b`,
  and written up in `docs/bugs.md`: the read/write-back pair is what a
  read-modify-write looks like with the modify deleted.

### Nine are genuinely unread, and now say so

Named for their contents under `Unused_<bank>_<what>`, each note carrying the
negative result rather than implying a caller:

| label | contents |
| --- | --- |
| `Unused_38_PortraitCellAddrs0` / `1` | four slot-portrait cells (rows 6/9, cols 14/16), byte-identical, one behind `ClearPlayerSlotPortrait` and one behind `DrawPlayerSlotPortrait` -- both of which reach their cells through unrolled per-slot branches instead. The live `PlayerSlotBoxAddrs0-5` family uses columns 13/17, so these read as the superseded version. |
| `Unused_38_StatDrawOrder` | `$00 $02 $04 $01 $03 $05` -- six stat rows column-major, in front of `DrawCreatedCharStats` |
| `Unused_38_SlotIndexOrder` | `$03 $01 $02 $00`; the palette routine above it computes its index arithmetically instead |
| `Unused_38_NameEntryBlank` | four order bytes then ten `$3f` and a `$00` -- eleven bytes, exactly `wNameEntryBuffer`, but `SetupNameEntryScreen` copies its eleven from `GetActiveStoryNameBuffer` |
| `Unused_27_ActorLists` | two lists of three 6-byte records, `$00`-terminated, differing in one byte |
| `Unused_27_Record` | sixteen bytes; three words look like bank addresses but each lands mid-object, so not a pointer record. Shape only. |
| `Unused_1b_StubRetAndFill` | a lone `ret` then `$ff $36` four times, in front of `StubNop_1b_09` |
| `Unused_1b_SavedDataCursorCells` | three same-row cursor positions plus three tile ids, in front of `RedrawSavedDataTypeSelect` |

What "unread" rests on: for every address *inside* each blob -- not just its
start -- no 16-bit immediate load, no `add LOW`/`adc HIGH` split base, no 8-bit
register pair in either order, and no `dw` word, searched over the raw ROM so
that unproven code inside blobs counts too, with cross-bank byte coincidences
filtered out. Plus, for bank `$38`, a traced play session through the screens
that use it which added no coverage at all.

### Where the naming stands

**Address-suffixed labels in `src/`: 0**, from 1,056 three passes ago. The 915
symbols `tools/progress.py` still counts as auto-named are 903 `FarPtr_`/
`DataPtr_` slot labels, which derive from their targets' curated names by
design, and 12 derived table names (`SpriteDesc_*`, `SoundTable_*`,
`WalkSprites_*`). Byte-perfect throughout; `make check` clean (4,907 regions
now -- one fewer blob, because one of them turned out to be a routine).

## The naming metric was counting finished work as unfinished (2026-07-30)

`tools/progress.py` had one `AUTO_RE` doing two jobs: computing the
`named` column and driving `--unnamed <bank>`, the naming worklist. It matched
`^(?:FarPtr|DataPtr)_` unconditionally, with a comment admitting the clause
covered "slot names derived from curated targets".

That was fair when most targets were unnamed. It is not fair now. Of the 1,580
symbols the regex flagged, **1,568 are slot labels spelled after a curated
target** (`FarPtr_RunDebugTestMenu`, `DataPtr_ClubhouseScenePalettes`) and 12 are
structures named for what they are (`SoundTable_0c`, `WalkSprites_6a`). Zero
still stated only an address. So the worklist had become 1,580 entries of pure
noise -- and worse, entries **nobody is allowed to action**: a slot label is
re-derived from its target on every regeneration, so the only way to change one
is to name its target. The metric was pointing at work that does not exist and
hiding the fact that the real work had run out.

Rather than delete the clause, the regex is split in two, because the two
groups need different treatment:

* `AUTO_RE` -- still says nothing but where it is. Address-suffixed names, plus
  a slot label **only while it exposes an address**: a numeric slot
  (`DataPtr_5f_02`) or one derived from an auto-named target
  (`DataPtr_Data_5f_4c63`). That condition is what makes the worklist
  self-maintaining: a future pass that carves a new unnamed target puts the
  slot back on it automatically, with no regex edit.
* `DERIVED_RE` -- generated but carrying its meaning. Reported in a new
  `derived` column instead of being folded into the unnamed remainder.

The `named` figure is unchanged by this -- it already excluded both groups --
so the series in this document stays comparable: 21,683 labels = 20,103 named +
1,580 derived + **0 auto**. What changes is that the remainder is now labelled
honestly, `--unnamed` is empty for every bank (which is the true state), and
`--derived <bank>` exists for looking at the other group.

Seventeen representative names were checked against both patterns, including
the regressions that matter: `DataPtr_5f_02`, `DataPtr_Data_5f_4c63` and
`FarPtr_Func_10_4abc` must all still count as work, and do.

## The immediates start naming themselves (2026-07-30)

Every *symbol* in the ROM has had a curated name since 2026-07-26. The
*immediates* did not: `include/constants.inc` defined 144 names in six families
(joypad bits, actor facing, shot types, point outcomes, two menu-item id sets,
save flags) and `constants.json` applied them at 266 sites. Everything else the
game dispatches on — which court, which character, which location, which
mini-game, which piece of music — was a bare `$xx` at every site.

This pass names four more id spaces and applies them: **363 defs (up from 144),
530 curated sites (up from 266), plus 443 sound-command operands** named by
value rather than by site. Byte-perfect throughout, `tools/check.py` clean.

| family | defs | sites | keyed on |
| --- | --- | --- | --- |
| `STORYLOC_*` | 42 (the whole space) | 103 | `wStoryModeCurrentLocation`, `wStoryReturnLocation` |
| `GAMEMODE_*` | 11 (the whole space) | 49 | `wGameMode` |
| `CHAR_*` + sentinels | 41 | 29 | character record `+$0b` |
| `COURT_*` | 9 | 8 | `wCurrentlyUsedCourt` |
| `MINIGAME_*` / `MATCHLIST_*` / `MARIOGAME_*` | 43 | 75 | `wCurrentMinigameStoryMatch`, `wSelectedMinigame` |
| `BGM_*` / `SFX_*` / `JINGLE_*` | 57 | 443 | the `sound` command's inline byte |

The site rule was the same in each case and it is deliberately narrow: an
immediate is only tagged where the *code* proves it is an id of that family —
the instruction directly before the store into the variable, a `cp` reachable
from the load without `a` being clobbered in between, or a table row whose
consumer indexes by it. `ld a, $05` in a routine that never touches the
variable is not a location id, and this project has already been bitten once by
a name applied to something that turned out to be a screen cell.

### Two id spaces close, which is itself the evidence

`GetStoryLocationRecordPtr` (`0a:$574e`) turns an id into
`StoryLocationTable_0a + id*6`, the table is 252 bytes = 42 records, and
`GetStoryLocationCount` returns `$2a` — so the space is exactly `$00`-`$29`,
with record *i* describing location *i*. Better, each id **names itself
in-game**: `LoadStoryLocationHeader` (`0a:$5142`) computes the popup's text id
as `$0179 + id`, so the constants are the game's own wording rather than an
inference. `DrawStoryResultsHeader` (`1e:$448c`) runs the same arithmetic on
`wStoryReturnLocation`, which is how that variable is known to hold ids from
the same space.

`wGameMode` closes the same way: two tables index it **unguarded** and both are
exactly 11 entries long (`SaveQuitMenuIdByGameMode` at `06:$44f3`,
`ScoreboardModeGfxPointers` at `06:$5cc9`), so mode `$0b` does not exist. What
each value *means* came from the scoreboard word-art the second table selects —
the graphic spells the mode out — cross-checked against two independent
sources: `Singles/DoublesMatchSettingsTable_0a`'s mode field paired with
`RewardFlagListMode{0,1}_1e`'s per-match completion flags (mode `$02` rows get
`FLAG_WON_ISLAND_OPEN_*`, the three mode-`$0a` rows get
`FLAG_WON_DREAM_MATCH_*`), and the drill/mini-game configs, which copy record
byte `+3` into `wGameMode` (`$05` for all 18 bank-`$0b` drills, `$06`/`$07`/`$08`
for the Tennis Machine, Wall Practice and Mario mini-game configs).

One slot in `ScoreboardModeGfxPointers` is unreachable filler: record 0
duplicates record 1, but `LoadScoreboardModeGfx` only runs while a match is
being set up and mode 0 means *no* match. It is not evidence that mode 0 is a
ranking match.

### The community RAM notes are wrong in two places

`docs/ram_map.md` carries RetroAchievements code notes for the same two
variables, and where they disagree with the code the code decides:

* **Location `$1c` is "Special Court", not "Castle Court".** That is the popup
  string for `$1c`; the note's own BGM list puts Castle Court's music (`$12`) on
  id `$1d`, and `$1c`'s record selects BGM `$08`. A mix-up between adjacent ids.
* **`wGameMode $09` is missing from the notes entirely.** It is the link-cable
  versus match: set at `38:$7448`, one instruction after
  `farcall RunLinkCharSelectScreen`, and every mode-`$09` test in banks
  `$08`/`$16`/`$1e` either reads `wLinkMatchRole` immediately or bypasses the
  story/save path.

`ram_map.json`'s descriptions still carry both errors, and `ram/wram.asm`'s
comments are generated from it, so the source now contradicts itself in two
comments until that is fixed.

### The sound ids needed a renderer, not a curated site list

The sound id space decodes cleanly: **one 8-bit space split at `$50`**.
`PlaySound` (`$3297`) reads `$3151 + (id - 1) * 2` below `$50` and
`$31b5 + (id - $50 - 1) * 2` above, so `$01`-`$32` are the 50 entries of the
first index table (3-4 voices on channels 2-5: songs) and `$51`-`$c1` the 113 of
the second (1-2 voices on channels 0-1: effects). Id `$00` stops the music and
`$50` stops the effects, each clearing its own half. `$40`-`$45` are jingles,
claimed by the command handler (`$2fb3`) before the table lookup; that handler
also latches every id below `$40` into `wCurrentBGM`, which is what makes the
`wCurrentBGM` values *the same numbers* — so the RA note's BGM list and the
`BGM_*` constants describe one space, not two.

What blocked applying it is structural, and worth recording because it is not
obvious from the id space: **`constants.json` cannot reach these sites.** Only
two immediates in the whole ROM feed a sound id to a call the curated-offset
mechanism can tag. The other 630 go through the `sound` macro — `rst $08` plus
one inline byte, rendered in `core.py`'s decoder — whose operand is not an
instruction immediate at all.

So the substitution belongs to the *value*, not the site, which is exactly
right for a global id space: `render_operand` now takes a `{id: name}` map built
in the emitter from `constants.inc`'s `BGM_`/`SFX_`/`JINGLE_` defs (via the
existing `_enum_values` helper), and a curated `constants.json` entry still wins
above it for a site the id space does not explain. Adding a def to
`constants.inc` now names every site of that id with no further work — and
because the three prefixes cover one space, `_sound_id_names` **raises** rather
than silently picking a winner if two of them ever claim one value.

**443 of the 630 `sound` sites are named; 187 are not**, and the unnamed set is
concentrated: `$96`-`$99` (101 sites, all in cutscene and location init
scripts), `$78` and `$80` (32, all in bank `$1b`'s `RankingBoardAnimState_*`),
`$a2` (9), `$72` (7, oddly in the serial encode/decode routines). Each of those
appears in several sibling contexts that do not discriminate between them, so
they need the sound test or the emulator, not more reading.

## The pointer targets that fell out of their tables (2026-07-30)

The generator has been printing this note for a while:

> note: 18 pointer targets are named at the end of a declared table, so what
> they point at renders as an anonymous blob (…); declaring them in
> data_tables.json keeps the structure.

All 18 are now declared, and the note is gone: **blobs 4,907 → 4,863**, and
1,144 bytes moved from anonymous `INCBIN` to structured source (`records:2`,
`bytes:4`, `sprite_template`, `save_flag_ids` and friends), with 11 new labels
for the sub-tables that surfaced — bank `$1b`'s ranking-marker coordinate sets
are three tables of four 4-byte sets each, which was invisible while the whole
run was one blob.

The load-bearing part is what was *not* declared. A truncated pointer target is
only missing a spec if it is really structure; if the bytes are a graphics
payload, a named `INCBIN` is already the correct rendering and a `records:`
declaration over it would be a lie — the same mistake that cost 2,359 bytes of
fake "structured source" in bank `$06` on 2026-07-22. The check that separates
them now lives in the emitter (`_is_payload`) and takes both proofs from the
*consumer* rather than from the bytes looking plausible:

* the stream LZ-decodes using exactly its own extent (so it is what
  `DecompressData` is given), or
* the bank sizes it with `(next - name) / 16` — the 16-byte tile count
  `QueueVRAMCopy` takes, so it is a raw tile stream.

Payloads that pass either test are no longer reported as truncated at all,
which is why the note went to zero without 18 new declarations.

### Both self-reports now name names

Two generator notes counted things without identifying them, and both were
hiding work:

* The truncated-target note listed three names and `+15 more`. It now prints
  every offset, name and enclosing spec.
* `note: N coverage seeds decoded invalid/conflicting; skipped` printed only
  `N`. It now prints each offset, why it was rejected, and **which dump claimed
  it** — `load_coverage` collects `{offset: [dump name, …]}` for exactly this.

That immediately settled one of them. `0x6dfe2` (`$1b:$5fe2`) was the *low
operand byte* of the `ld hl, CharSelectRosterTable` that opens
`LoadCharSelectRosterTable` at `$5fe1` — already seeded on the line above — in a
hand-authored static seed file. Removed, with the reason recorded in the file's
`_comment`. **The count is 9 → 8**, and the survivors are now addressable:
`0x1d1a0` is the long-known phantom, and the other seven are two sites in bank
`$07` and five in bank `$08`/`$1e`, every one of them contributed by a
`tracelog2cov` conversion (`native_seg*.json`, `session4_native.json`,
`story*.json`) rather than by a Lua dump — which points at the converter's
line-rejection rather than at the ROM.

### All eight were one bug: `min()` guessing a bank for a lone `rst $18` (2026-07-30)

The eight are not eight questions. Every one of them sits on a `$df` byte that
is the *high operand byte* of a `[$dfxx]` absolute — `fa 6e df`, `ea 4b df` —
so the seed is mid-instruction and the conflict is correct. `$df` is also
`rst $18`, the FarCall opcode, and that is the whole mechanism.

The native tracer logs `rst $18` as its opcode byte alone, one byte, because
the two inline operands are read by the trampoline rather than fetched as part
of the instruction. `tracelog2cov` resolves banks by intersecting the logged
bytes across a *run* of consecutive banked lines, and a run ends whenever
execution leaves `$4000-$7fff`. A farcall leaves twice over: the `rst` goes to
ROM0, and the callee runs in a third bank. So a farcall that follows another
farcall, or that opens a function, is alone in its run — **one byte of bank
evidence** — and `min(candidates)` awarded it to the lowest bank that happens
to hold `$df` at that in-bank offset. Banks `$07`/`$08` are low and dense with
`[$dfxx]` operands, so they collect the phantoms.

Each phantom's real site is an existing `farcall` at the same in-bank address
in a higher bank, and the *same dump* that claimed the phantom also contains
that site's neighbouring instructions, which pins the bank beyond argument:

| phantom | true site | dump evidence |
|---|---|---|
| `$1d1a0` `$07:$51a0` | `$24:$51a0` `farcall ComputeShotPlacement` (`ShotBallPathDrop`) | 5/5 follow-ons, all 5 dumps |
| `$1d469` `$07:$5469` | `$1e:$5469` `farcall InitActorEngine` | 6/6, all 4 dumps |
| `$22afb` `$08:$6afb` | `$12:$6afb` `farcall RunDialogueYesNoPrompt` | 3/4 |
| `$22afe` `$08:$6afe` | `$12:$6afe` `farcall ScriptCloseDialogueWindow` | 3/4 |
| `$22c9b` `$08:$6c9b` | `$0b:$6c9b` `farcall AwardPoint` | 5/5 (`story3_drillwin`) |
| `$22fc6` `$08:$6fc6` | `$38:$6fc6` `farcall DrawTextWindowFrame` | 7/7 (`story_intro`) |
| `$235cf` `$08:$75cf` | `$1d:$75cf` `farcall RestoreCharDataScreenRow` | 6/6; the other two `$df` candidates (`$11`, `$3b`) score 0/6 and 0/7 |
| `$789df` `$1e:$49df` | `$38:$49df` `farcall DrawTextWindowFrame` | 7/7 (`story_intro`) |

It is a clean one-for-one substitution: in **every** dump, the phantom offset is
present and the true offset is *absent*. `session4_native.json` shows the hole
shape exactly — bank `$12`'s script stretch has `$6af1`, `$6af6`, `$6af8`,
`$6b01`, `$6b08` and is missing `$6af3`, `$6afb`, `$6afe`, which are the three
lone `farcall` lines in it. `$6af8` survives because the instruction before it
(`ld a, $03`) stayed in the bank, so its run had evidence; `$6afb` and `$6afe`
follow farcalls and had none.

The attributions read correctly as a story too: the drill dump names
`AwardPoint`, the intro dump names `DrawTextWindowFrame` twice, the match dumps
name `ShotBallPathDrop`. **None of the eight is a real instruction start in the
bank it was filed under, and no region is decoded at the wrong boundary.** The
traced dumps are left untouched — they are evidence, and the mistake is not in
them; the eight go in `BAD_SEEDS` with the table above recorded there. All eight
true sites were already disassembled, so the instruction and byte counts do not
move: 160,888 instructions / 316,563 bytes code, before and after. **The
rejected-seed note is 8 → 0.**

`tracelog2cov.py` no longer produces the shape. Two changes:

* A run now survives an excursion out of the bank when execution returns to the
  address *after* the instruction that left. That is sound rather than
  heuristic: a caller can only resume at its own next address if its bank is
  still mapped. Resuming past a `rst` needs the game's inline-operand
  conventions (`rst $18` +2, `rst $08` +1, the flag rsts +2, `rst $00` never
  resumes, `call Func_00_2725` +1), which the converter now knows.
* A run that is still ambiguous with only one instruction in it is **dropped
  instead of guessed**. One opcode byte cannot choose a bank.

Checked against a synthetic trace log built from two of the real paths
(`$1e:$5459…$546f` around `call ClearSpriteQueue`, and `$24:$51a0` entered by
farcall): the old converter emits both `$1d1a0` and `$1d469`, the new one emits
neither — and *correctly* resolves `$1e:$5469`, because the merge rule rejoins
the farcall to the four instructions before it.

### The 22,976 dropped coverage entries are WRAM data addresses, not WRAM code

`load_coverage`'s other standing note. All 22,976 (5,723 distinct) come from
five dumps — `banktrace6`–`9` and `charselect_cpudiff_grass` — and every one has
the shape `0xc00000 | v` with `v` in `$c000-$fd88`. The tag `$c0` is 192 and the
ROM has 128 banks, so no interpretation makes these ROM offsets; dropping them
is right, and there are no sign-extended negatives left in any dump.

They are **not executed code**, which retires the standing note that ~3 KB of
WRAM-resident code needed a copier found. 345 of the addresses are named WRAM
variables — starting with `$c000` = `wShadowOAM`, the shadow-OAM buffer
rewritten every frame, and including `$c286` `wMapEntryPointsPtr` and `$df51`
`wCharShotButton2`, all of them data that cannot be instructions. They are also
scattered in short clusters across the whole of `$c000-$dfff` rather than
forming a copied block. The only RAM-resident code in the game is
`OAMDMARoutine`, copied to `$ff80` by `CopyOAMDMARoutineToHRAM` and called at
`$00:$2795` — exactly the six `$ff80-$ff89` entries these dumps carry in
`other`, and the only `call`/`jp` to a RAM address anywhere in `src/` is that
`call hOAMDMARoutine`. (`src/bank_00b.asm`'s `call c, $e06d` is inside
`StrokePractice2Hooks`, a mode-hook table, not code.) So the answer to "which
routine copies that code into WRAM" is that there is no such code: these are
WRAM *data* touches recorded alongside the exec trace.

## Driving the game found no new code, and that is the answer (2026-07-30)

A trace of a complete exhibition match — set-up, the match itself, the loss, the
win/lose ceremony, the stats screen and the way back to the menu — plus an
overworld capture added **43 new coverage seeds and zero new instructions**.
Every byte those two sessions executed was already proven code.

That is the expected result now, and it is worth stating plainly: the 2026-07-24
ROM-wide code-shape screen and the twin-bank pass between them found the code
the traces had missed, so *new coverage is no longer a source of new code*. What
it is still a source of is **WRAM-bank evidence**, and there the two dumps did
pay: sites with an observed bank went 53,723 → **54,610**, and the number of
sites where the trace resolves a bank the dataflow could not went 14,913 →
**15,332**.

None of those 419 landed on one of the 572 bare `$dxxx` operands, so
`tools/ram_gaps.py` is unchanged (524 unproven / 28 rom-scoped / 20 mirrored).
That is consistent rather than contradictory: knowing a site's bank only changes
the rendering if a union *names* that address in that bank, and these sites are
in code whose addresses are already named. The remaining 524 need coverage of
the screens nobody has driven — the save editor, the exp screen, most
mini-games — not more coverage of the match.

## Three subsystem references (2026-07-30)

`docs/` held six files against an 8,200-line `STATUS.md`, which is a
*chronological log*: everything known about the match engine or story mode was
in it, in discovery order, findable only by grep. Three references now cover the
three biggest subsystems, organised for a reader opening the source cold:

| file | lines | covers |
| --- | --- | --- |
| `docs/match_engine.md` | 1,583 | the match state machine and frame order; fixed-point formats, world scale and sign conventions; the ball and its physics step; the swing → trajectory chain and the bank `$20` trajectory tables; the 15 shot types; the per-character struct and state machine; the AI; scoring; doubles; the serial link |
| `docs/screens_and_ui.md` | 1,179 | the frame loop and VBlank order; `QueueVRAMCopy` as the only door into VRAM; the tilemap pipeline and its two plane-pairing conventions; the `$4000` slot convention and bank `$39`'s shared screen library; shadow OAM; palettes and fades; the text/window engine; menu trees and cursor walkers |
| `docs/story_mode.md` | 806 | entry and top-level flow; the location loop; the location record and the `map_tree`'s four record grammars (`map_entry`, `map_actor`, `map_script`); scenes, collision and camera; NPCs; the pause menu; the two flag spaces; the ranking ladder and tournament arc; the character record, stats, EXP and the save signature |

Each ends with its own limitations section, and none of it was confirmed by
running the game — all three are static reading, and they say so.

They were checked mechanically before being committed, because a reference
nobody can verify is worse than no reference: of **1,081 symbol-shaped citations
across the three files, every one resolves** to a label in `src/`, an entry in
`labels.json`, or a def in the includes, once macro names, data-spec kinds and
record field names are excluded. Six citations in `match_engine.md` were spelled
without their bank suffix (`SetBallTargetFromAim` for `SetBallTargetFromAim_20`)
and were corrected. Sampled substantive claims hold too — the "unreachable
queue-compaction tail" at `$00:$0595`-`$05ae` really does sit after a `ret` with
no label of its own, so nothing can reach it.

### What this session did not do

Stated because the absence is easy to mistake for a clean bill of health:

* **The `mirrored` (20) and `rom-scoped` (28) `ram_gaps.py` buckets are
  untouched.** They remain the two actionable WRAM naming buckets.
* **No new entries in `docs/bugs.md`.** A systematic sweep for write-only
  variables, unreachable routines and low-address stores was started and
  produced nothing verified. The three new references each carry an
  oddities/open-questions section whose contents are candidates for it — the
  bank `$00` queue tail above, `CopyMapToScrollBuffers` clearing the region it
  just expanded, and two declared `map_actor` extents that run past their
  `$ff` sentinel.
* **`ram_map.json` still carries the two wrong descriptions** above.
* **Three renames are recommended and not applied**:
  `DrawMarioExhibitionResultsHeader` (`1e:$4336`) handles mode `$0a`, the Dream
  Match; `EndingCreditsSequenceTileList` (`0a:$6e40`) holds no tiles but 21
  `(location, entry point)` pairs and an `$ffff` terminator.
* **The `map_scripts` spec cannot express a location id.** `RunLocationExit`
  (`0a:$5637`) copies `map_script` field `arg0` into
  `wStoryModeCurrentLocation`, so most location transitions live in
  ExitTriggers tables — which is why 23 of the 42 location ids have no code
  site at all. One spec covers all four `map_script` roles and `arg0` only
  means a location in one of them, so tagging them needs a `role` parameter on
  `render_map_table`.

## Five sound symbols named the opposite of what they do (2026-07-30)

Naming the sound ids meant reading `PlaySound` closely enough to notice that its
two index tables are labelled the wrong way round — and once they are swapped,
three more names go with them.

`PlaySound` loads `$3151` first and replaces it with `$31b5` only when the id is
`>= $50`, so **`$3151` serves the ids below `$50`**. Three independent checks
agree that half is music:

* **The entry data.** Each index entry's high nibble is the channel count. The
  `$3151` table's entries want 3-4 channels; the `$31b5` table's want 1. Music
  uses 3-4 voices, an effect 1-2.
* **The channels each half clears.** The `id >= $50` path clears channel structs
  0 and 1 before its lookup; `StopMusic` (id `$00`) clears structs 2-5. The two
  halves own different channels.
* **`wCurrentBGM`.** The command handler latches every id below `$40` into it,
  and its documented values run `$00`-`$32` — exactly the 50 entries of the
  `$3151` table.

So `$3151` is `MusicIndexTable`, `$31b5` is `SfxIndexTable`, and `PlaySound`'s
`.sfx` branch — the one taken when the id is *below* `$50` — is `.music`.

Two more names came from the same confusion. `CheckSfxChannelsIdle` walks four
channel structs from `wSndChannels + 64`, i.e. channels 2-5, the *music*
channels; its one caller is `ResumeBGMAfterJingle`, which restarts `wCurrentBGM`
once they fall idle — once the jingle playing on the music channels has ended.
It is `CheckMusicChannelsIdle`. And `StopAllSound` clears only those same four
structs plus `wSndLoopSlots + 24`, leaving the effect channels running: it is
`StopMusic`, and id `$50` is what silences the effects.

Worth noting how this surfaced. The byte-perfect compare cannot see a wrong
name, and none of these five had looked suspicious in three years of passes over
this bank — `SfxIndexTable` sitting next to `MusicIndexTable` above `PlaySound`
reads perfectly well until you check which one the `jr c` actually takes. What
forced the check was needing to state, in `constants.inc`, *which id range is
which*: a constant has to commit to a claim that a label can leave vague.

## The location ids came out of the tables, not the code (2026-07-30)

The `STORYLOC_*` pass left 23 of its 42 constants with **no site anywhere in
`src/`** — a def with nothing to name. That was not a gap in the site rule; it
is where location transitions actually live. `RunLocationExit` (`$0a:$5637`)
copies a `map_script` record's `arg0` into `wStoryModeCurrentLocation` and
`arg1` into `wStoryModeEntryPoint`, so most of the game's map graph is **data**,
in the ExitTriggers tables. Two renderers later, **41 of the 42 constants have a
site and the STORYLOC site count is 103 → 232**.

### A spec that covers four roles cannot name a field

`map_scripts` is one spec used for four of the seven `map_tree` slots
(ExitTriggers, NpcScripts, FacingScripts, TileTriggers — 137 tables), and
`arg0` is a location id in exactly one of them; in the others it is whatever the
record's handler reads it as. So the *slot* is now part of the declaration:
`map_scripts:exit`, a `role` parameter on `render_map_table`. Role `exit` names
`arg0` `STORYLOC_*`; there is no other role, and an unrecognised one raises
rather than rendering silently.

Which tables get the role is **derived, not listed**. A `map_tree` declares its
slots in a fixed order, so the word at `+2` of any of the 42 trees is that
location's ExitTriggers table by construction. Following those words gives 38
`map_scripts` tables (108 records) and 4 pointers to a lone `$ff` — the empty
list, correctly not a declared table. Every one of the 38 already had an
`*ExitTriggers*` name, which is a check on the derivation rather than a reason
to have hand-listed them.

`arg1` is deliberately **not** named. It indexes the *destination's* `map_entry`
list — a different id space that happens to overlap the location ids ($0f is the
commonest value, 21 records) — and this is the same trap that made a whole-table
`enum:STORYLOC:2` wrong for the ending playlist, because `render_enum_table`
names every byte in a row.

### The ending playlist is a location list

`EndingCreditsSequenceTileList` (`$0a:$6e40`) holds no tiles: 21
`(location, entry point)` pairs plus an `$ffff` terminator, walked by
`RunEndingCreditsSequence` (`$6e9f`-`$6eb0`), which stores byte 0 into
`wStoryModeCurrentLocation` and byte 1 into `wStoryModeEntryPoint` — the same
pair `RunLocationExit` builds, stored directly. Renamed
**`EndingCutsceneLocationList`**, and a small `location_entries` spec renders it
as the twelve bank-`$27` "End\*" rooms plus Island Sky, Center Court, Peach's
Castle and Special Court, in order. Two rooms appear twice with different entry
points (`END7_TRAINING_CTR`, `END11_TRAINING_COURT`), which is what the second
`arg1` column is for.

That leaves **one** siteless constant: `STORYLOC_SMALL_CHAR_TEST` (`$02`). No
code writes it, no ExitTriggers record targets it, and its own ExitTriggers slot
is the empty `$ff` — the debug map is reachable only by writing the variable.

### Two community RAM notes corrected in the source

`ram_map.json` feeds `ram/wram.asm`'s comments, so the two errors the constants
pass found were contradicting `include/constants.inc` inside the generated
source. Both are now fixed *and* attributed: the note is quoted as wrong rather
than silently rewritten, because `docs/ram_map.md` is the downloaded
RetroAchievements archive and stays verbatim.

* `wStoryModeCurrentLocation` `$1c` is **Special Court**, not "Castle Court".
  `LoadStoryLocationHeader`'s `$0179 + id` lands on the string "Special Court"
  (and there is no "Castle Court" string in the ROM at all); the note's own BGM
  list puts Castle Court's music `$12` on `$1d`, whose record selects it.
* `wGameMode` **`$09` is the link-cable versus match**, missing from the note
  entirely. `ScoreboardModeGfxPointers` record 9 is
  `ScoreboardModeGfx_LinkedMatch` — the scoreboard word-art spells the mode out
  — and bank `$38` sets the mode one instruction after
  `farcall RunLinkCharSelectScreen`.

### $ffff is not rIE

Eight `ld bc/de, $ffff` sites rendered as `ld bc, rIE`, because `$ffff` is the
register's address. None of the eight dereferences the pair, so all eight are
now in `HWADDR_IMM_IS_CONSTANT`: two are the `b = $ff` "no door, save the
*current* location and position" sentinel `SaveStoryReturnPoint` tests, two seed
a loop counter that `inc bc`/`inc c` lifts to 0 before first use, one is the
`(-1, -1)` cursor delta whose sibling call sites pass `$0101` and `$1008`, and
three are a saturated 16-bit result. Only two are the sentinel, so it stays a
literal rather than earning a name.

### One recommended rename declined

`DrawMarioExhibitionResultsHeader` (`$1e:$4336`) *is* the mode-`$0a` handler and
mode `$0a` *is* the match `RewardFlagListMode{0,1}_1e` rows 22-24 tag with
`FLAG_WON_DREAM_MATCH_*` — `Singles/DoublesMatchSettingsTable_0a` records 22-24
are the only mode-`$0a` rows and they select BGM `$29`, "Dream Match" in the RA
BGM list. But the rename to `DrawDreamMatchResultsHeader` was **not** applied,
because the existing name is the better-sourced one: the routine's own body calls
`DrawMarioExhibitionLabel`, which draws text id `$04ea` = string `$31`:234,
literally **"Mario Exhibition"**, and nothing else in the ROM draws it. "Dream
Match" appears in no string in the ROM; it comes from the RetroAchievements flag
notes. The suspicion that the name was copied from the scoreboard art mode `$04`
shares does not survive `git log`: `DrawMarioExhibitionLabel` predates the
header's name. `GAMEMODE_DREAM_MATCH` and `FLAG_WON_DREAM_MATCH_*` are the
community wording for the same mode; the two vocabularies coexisting is worth
knowing, but it is not a reason to overwrite the game's own.

## Ten defects in the shipped game (2026-07-30)

`docs/bugs.md` goes from 205 lines to 519. The file's three-way split — bugs,
dead stores, and routines that return before their body — is unchanged; the new
entries append into it. What makes the yield possible is that every reference to
every address can now be enumerated, so "nothing reads this" and "nothing can
reach this" become searches rather than hunches.

Five of the seven bugs were verified independently against the source before the
entries were accepted, because `docs/bugs.md` is only worth having if a future
session can trust it. Two are worth restating here.

**`UpdateScreenShake` (`$0a:$4908`) never negates the shake.** It builds a mask
from the magnitude, takes a random byte, and then:

```
        ld a, h
        and c                   ; <- clears carry
        jr nc, .negate          ; so this is unconditional
        cpl                     ; unreachable
        inc a                   ; unreachable
.negate:
        ld [wScreenShakeOffsetX], a
```

`and` fixes carry at 0, so both negation arms are dead and the offsets are
always `0..mask` — the view shakes in **one direction only**, with mean
`+mask/2` instead of being centred on zero. That the intent was signed is not a
guess: both consumers sign-extend the bytes (`ComputeSpriteScrollOffset` tests
`bit 7, l` and loads `ld h, $ff`), which makes those sign-extension arms dead
too. No reordering fixes it; the `and` is what destroys the carry the branch
wants.

**`LoadMenuTilesBStaged` (`$01:$5095`) uploads its own machine code to VRAM.**
The staged loader splits the 96 font tiles into three 32-tile chunks with an
`AdvanceFrame` between them — correct — and then does:

```
        ld hl, MenuFontPalettes_01   ; $5010, 64 bytes of palette data
        ld de, $8e00
        ld c, $20                    ; 32 tiles = 512 bytes
        call QueueVRAMCopy
```

`MenuFontPalettes_01` is a real palette (`LoadMenuFontPalette` hands it to
`LoadPaletteShadow`), and 512 bytes from `$5010` runs to `$5210` — 64 bytes of
palette followed by 448 bytes of *executable code*, including
`LoadMenuFontPalette` at `$5050` and this routine itself at `$5095`. Meanwhile
the fourth upload its non-staged twin `LoadMenuTilesB` performs —
`MenuFontFillTiles_01` to `$8800` — never happens. The edit is legible in the
destination run `$9200, $9400, $9600, … $8e00`: the survivor kept the wrong
source label and the wrong destination. It is live code, reached through
`LoadMenuFontGfxStaged` (farptr slot `$4014`, farcalled from `$06:$6ea0`).

The other five bugs: a discarded `farcall ReadCollisionMapCell` return value
(`$04:$5215` overwrites it with `ld a, $00` before testing it, so terrain type
`$0b` — half-speed ground — never engages anywhere in story mode, while the
sibling consumer 300 bytes later uses the value correctly); the white fade,
which cannot be selected because the only writer that sets bit 7 of
`hFadeState` sits in an unlabelled fragment at `$00:$1d0f` that nothing
references and that is preceded by an unconditional `jr`, so every fade in the
game is a fade to black; a missing `jr nz` after the debug console's
`bit PADB_SELECT, a` (`$00:$18bc`); an unconditional debug `PrintHexByte` in
`ReadBehaviorMapCell` (`$0a:$5f65`), on the overworld movement path; and a
glyph-buffer "keep" branch (`$05:$72e9`) that is dead because its counter's only
producer, `DrawTileAttrRect`, has no callers at all.

### The nulls are the other half of the result

A sweep that only reports hits cannot be distinguished from a sweep that got
lucky, so the searches that found nothing are recorded too:

* **Stores to `$0000`-`$7fff`** — the grayscale bug's signature. 138 absolute
  writes, every one accounted for (57 `rROMB0` in the bank-switch layer, 77
  `rRAMG`/`rRAMB` in the save engine, the known `rRAMG + 2`, and two
  `ld [$xxxx], sp` that are data mis-decoded as code), plus 2,653 low
  immediates into `hl`/`de`/`bc` swept for the indirect form: **zero** stores
  through a low pointer. That lead is exhausted — the grayscale write is the
  only instance in the ROM.
* **Carry-flag dead branches.** Dataflow over ~1.03M lines: 5,040
  carry-clearing ops, 655 `jr c`, 1,365 `jr nc`. Yield: the two
  `UpdateScreenShake` sites and nothing else. 0 of 75 `cp $00` are followed by
  a carry branch; no `and`/`or`/`xor` → `jr c`; no `scf` → `jr nc`.
* **Impossible comparisons against the four newly closed id spaces.** For
  `wGameMode`, all 16 writers and every `cp` were enumerated: written set =
  compared set = `$00`-`$0a`, with nothing compared-but-never-written and no
  comparison at or above 11. That makes `constants.inc`'s "closed" claim
  load-bearing rather than decorative. `STORYLOC_*`, `CHAR_*` and the court ids
  are null too — the court ids have no `cp` anywhere in the ROM.
* **Signed/unsigned on the negated court limits**, which `match_engine.md`
  flagged as a worry: all five readers checked against their writers, and every
  one either absolutes first or tests `bit 7, h`. The worry does not cash out.
* **`ret`-first routines with a live body**: 103 of 13,237 labels start with an
  unconditional `ret`, 74 with empty bodies, and of the 28 with real bodies all
  but one were already known or are missing labels rather than early returns.

### Two candidates were refuted, and both refutations are findings

**The unreachable queue tail at `$00:$0595` has no consequence.** It is a
*compaction*: given a slot base and the count of slots left, it steps to the
next 8-byte boundary, copies the remaining entries down to the front of
`wVRAMCopyQueue` and re-terminates — "this slot is empty, close the hole". The
hole cannot occur, because `QueueVRAMCopy` fills the first free slot scanning
`l = $a0, $a8, … $e8` in order and the drain consumes from slot 0 zeroing as it
goes, so the queue is always packed from the front. The code is redundant as
well as unreachable, which is why it belongs in the UI reference as dead
framework rather than in `bugs.md`.

**`CopyMapToScrollBuffers`' over-long clears are the initialisation the caller
depends on**, not collateral damage. The expected finding was that the second
1024 bytes of each `ClearMemory16` trample `wCharDataPageSlot2`/`3`; in fact
`ShowExpGainScreen` draws into exactly those bytes afterwards and needs them
zeroed. So the entry that survives is about the *expansions* — `CopyMapRows32To64`
writes 1024 bytes per plane and the clear immediately zeroes 2048 from the same
base, discarding 3,072 bytes of copying per call — and not about the clear.

### Disassembly defects the sweep turned up on the way

Not game bugs, so recorded here rather than in `bugs.md`:

* **Two data blobs decode as code in bank `$0d`** (`ld [$191f], sp` at `$4d8e`
  inside `MinigameConfig_TargetShot`; `ld [$2010], sp` at `$57f8`). Opcode `$08`
  in a config table; both want `db`/`dw`.
* **Five missing labels in the story banks' map-script no-op template.** The
  template is four handlers — bare `ret`; `xor a`/store/`ret`; `sound $a2`/`ret`;
  `xor a`/store/`ret` — and banks `$0e`/`$14` label all four while `$10`-`$13`,
  `$15` and `$27` label only the first. That makes `MapScriptNop_11` and its
  siblings *look* like routines that return before their body when they are
  nothing of the kind. Related: the three follow-on handlers have zero
  references in all nine story banks; only the leading `ret` is ever selected.
* **Seven unlabelled orphan fragments inside `StubNop_1b_09`'s span**
  (`$1b:$69d9`-`$6aa0`, ~76 instructions): a near-duplicate of
  `RunStoryDataConfirmMenu`, five confirm-screen text draws, and an `hh:mm:ss`
  renderer of `wGameTimer`. The label itself is three one-byte `ret`s used as a
  no-op frame task, so the span wants splitting, not renaming.
* **`SceneGfxSlotTable` slots 4 and 5** are named `*AuxTilemap`/`*AuxAttrmap`
  but hold the collision and behaviour maps.
* Three `ld a, a` no-ops (`$0a:$5644`, `$0a:$5f67`, `$0b:$444e`) sitting exactly
  where an operand-carrying instruction would have been — edit residue, not
  decode errors.

### Open, and worth a future pass

Fourteen sites branch to the label immediately following them — two wasted bytes
each, a strong fossil signal. Five were read by hand and none had an observable
effect, but several are `test_flag FLAG_DOUBLES` or `FLAG_TEMP_SCENE_VARIANT_A`
gates, which would mean a scene that should differ between singles and doubles
no longer does. `$08:$6514` (`CheckBallContactWindow`, the fourth arm of a
four-way animation test whose other three arms do skip work) is the one to read
first.

## Both actionable WRAM buckets are empty (2026-07-30)

`tools/ram_gaps.py`:

```
                    before   after
bare $dxxx operands    572     516
  unproven             524     516
  rom-scoped            28       0
  mirrored              20       0
```

All 48 sites in the two actionable buckets are settled, and eight `unproven`
sites fell out with them (same routines, same structures). 61 operands changed:
56 were bare and became names, and **five were wrong names corrected**.

### What the mirrored bucket turned out to be

* **The overworld's map buffer is one 64x64 structure, not two planes.**
  `wMapBuffer64` at `$d000`, 4096 bytes, mirrored across WRAM banks `$02` and
  `$03`. Every consumer dereferences the pointer *twice*, once per bank:
  `BlitBGRowFrom64` calls `GetMapBufferAddr64`, copies a row under
  `wram_bank $02`, then copies the same row again from the pushed pointer under
  `wram_bank $03`; `CopyScrolledSceneTilemapToVram` pairs bank `$02` with
  `rVBK = 1` and bank `$03` with `rVBK = 0`. The geometry agrees — row stride
  `$40`, both axes masked `and $3f`, and a `res 5, h / set 4, h` that wraps the
  pointer inside `$d000-$dfff`, i.e. 64 rows of 64 cells filling a whole bank —
  and so does the producer: `LoadStorySceneGraphics` decompresses the tile plane
  into bank `$03` and the attributes into bank `$02` at the same address. The
  existing `wMapScrollPlane0/1` and `wShadowTilemap`/`wScreenScratch` names are
  halves of this buffer seen from `CopyMapToScrollBuffers`' side; the new union
  says so rather than renaming them.
* **Bank `$06`'s two plane getters serve two screens.** `GetShadowTilemapAddr`
  and `GetShadowAttrmapAddr` are called only from bank `$06`, from
  `ShowMessageWindow` with WRAM bank `$02` selected (the court planes) and from
  `DrawStoryMenuCaption` with bank `$05` (the window engine's planes). Same
  structure, one copy per screen context, so no per-bank name is right.
  Bank `$03` is deliberately excluded: it is a third home of a plane pair, but
  nothing reaches these getters with it selected, and including it would stop a
  site *proved* to be bank `$03` from staying honestly numeric.
* **Character select drives the match character struct.** Bank `$38` runs
  `UpdateCharSelectCharSprite` once per preview character with
  `wram_bank $04/$05/$06/$07` in turn, so those are ordinary `wCharPosX` /
  `wCharFacingOctant` references. Fixed with *instruction-range* scopes rather
  than a whole-bank `{bank: 0x38}` one, because bank `$38`'s own `$df00` is
  `wCharSelectHandedness` in WRAM bank `$03` at nine sites and the char-struct
  union is consulted first — a whole-bank scope would have stolen all nine.
* **Two match-struct fields had no symbol at all** (not a scope problem):
  `wCharChargeFlashGfxLoaded` (`$df52`), the latch that makes each half of the
  `wCharSwingFrames and $04` cycle load its tiles once, and
  `wCharScriptedMove` (`$df56`), which `UpdateCharVelocityFromInput` tests to
  return early — a scripted walk overrides the stick for that frame.
* **`wCharRecordScratch`** (`$d580`, 128 bytes, WRAM bank `$02`) and
  **`wMugshotBuffer`** (`$d600`, 144 bytes = nine tiles, mirrored across banks
  `$02`/`$03`/`$04`). The scratch buffer's bank is stated out loud in exactly one
  place: `BuildSaveSlotSummaries` runs `wram_bank $02` before the call *and*
  again before reading `$d58b` back.

### The rom-scoped bucket was mostly one shape

Eleven of the 28 were character-data page-plane cells in bank `$1d` whose
variant was scoped `wram_bank $02`/`$03` while the bank live at the reference is
`$06` — the screen's own working set — because the operand is handed to
`CharDataScreen_WriteStatNumber`, which writes it under `$03` and then `$02`.
That is the callee-selected-argument shape the sibling `wCharDataScreenCell`
variant already documents, and the neighbouring already-named lines prove it:
`$4570` sits three instructions from a `wCharDataPagePlane + 1 * TILEMAP_WIDTH + 15`.

Eight more were bank `$06`'s in-match UI reaching the court planes from a bank
nobody had enumerated — `RestoreBgTilemap` copies `$d800 -> $d000` and
`$dc00 -> $d400`, exactly `wCourtTilemapSaved -> wCourtTilemap`. And one was not
a scope problem at all: **`wNameEntryBuffer` was declared 8 bytes and is 11**,
which bank `$38` copies with `ld bc, $000b` at three separate sites and an
existing comment in the same file already said out loud.

### Five wrong names, and where they came from

Three `$d000` operands in bank `$06` were rendering as `wScreenAttrmap` when
`FlushTilemapToVram` queues that exact address to `$9800` with no
`VRAM_BANK1` bit — VRAM bank 0, the tile plane. They are `wCourtTilemap`.

The other two are better: `GetCollisionMapCellAddr`'s base was rendering as
**`wActors`**, and `GetBehaviorMapCellAddr`'s as `wActors + 16 * ACTOR_SIZE`.
Both are `$d000`/`$d400` in WRAM bank `$06`, which the routines' own
`wram_bank $06` wrappers prove, and both compute
`base + (y & ~1) * 16 + (x & ~1) / 2` — 32 columns of half-tiles, 1024 bytes.
They are now `wCollisionMap` and `wBehaviorMap`, declared in a union placed
*before* the actor-slot union so its ROM-range scopes are consulted first. That
also settles why `wStorySceneUnusedBuffer` at `$d800` is dead: both maps are
accounted for below it.

### The audit guard had a hole, and this work walked into it

`audit_rom_only_scopes` exists because a variant scoped by ROM bank alone
matches every site in that bank whatever WRAM bank is selected — the looseness
that let four false names into this project before a bank-annotated trace
exposed them. An instruction-range scope naming no `wram_bank` is exempt by
construction, since declaring a callee-selected argument *is* "a name from a
bank the site does not select".

But the exemption was computed **per variant** (`any(...)` over its scopes), so
adding one such scope to an existing variant silently dropped that variant's
*whole-bank* scopes out of the audit too — and this pass added exactly that
shape to four variants. The split is now per scope: the two groups are
registered separately, which leaves resolution identical (the matcher lists are
disjoint and `_match` takes the first that fits) while keeping the audited group
audited. **Symbols under audit go from 325 to 455**, and the audit is silent on
all of them.

### Left open, with the reason

`ScopedRamNames.resolve` walks each address's matchers in **file order**, so an
earlier union's `wram_bank`-only scope wins before a later union's instruction
range is consulted. Three names are wrong and blocked by that ordering, not by
missing evidence: `$05:$4422` should be `wWindowShadowTilemap` (the write
happens after a `wram_bank $05` that follows the matched bank-`$03` scope), and
`$06:$5224`/`$06:$728e` should both be `wDecompBuffer` (each is a
`DecompressData` destination immediately followed by `wram_bank $01`). Fixing
them needs either a union reorder or a resolve-order override the schema does
not have.

### And the `unproven` label is now slightly wrong

54 bare operands in `src/bank_01d.asm` (`$50ab` onward) sit in the `unproven`
bucket but **need no coverage at all**: `wCharDataPageSlot1/2/3` have exactly
the shape fixed above, and each bare `ld bc, $dxxx` sits between two
already-named `wCharDataScreenCell + n * TILEMAP_WIDTH` siblings. The evidence
is in the routine. So of the 516 remaining, a known 54 are ordinary curation
work rather than something only the emulator can settle.

## Driving the uncovered screens: 100 operands proved, and 30 of them are now workable (2026-07-30)

Fourteen traced dumps: all nine mini-games on the select grid played to a
scoring or result screen (including Two-on-One's pause menu), a fresh Tour save
driven through a full story ranking match to a loss — which is what reaches the
**match-result → EXP-award → EXP-distribution / stat-allocation chain**, the
screens no trace had ever entered — plus the overworld Status/Records/Options
menus and an overworld walk.

Zero new instructions again, as expected since 2026-07-24. The result is in the
bank evidence:

```
                    before   after
bare $dxxx operands    516     446
  unproven             516     416
  rom-scoped             0      24
  unclaimed              0       4
  resolvable now         0       1
  mirrored               0       1
```

Traced sites with an observed WRAM bank: 54,610 → **64,677**; sites where the
trace resolves a bank the dataflow could not: 15,332 → **18,333**.

The shape of that table is the point. 100 operands left `unproven`, 70 of them
by rendering as a symbol outright, and **30 moved into buckets that need no
emulator at all** — a bank the dataflow could not pin is now pinned, so what
remains is ordinary curation. The new work is concentrated: seven `$d410` and
two `$d430` references from bank `$1c`, six `$d1xx`/`$d2xx` from bank `$1d`,
three from `$1e`, four `$d5xx`/`$d9xx`/`$dd2b` from bank `$0d`, four unclaimed
addresses in WRAM bank `$04`, and one fresh mirrored candidate
(`$d000` under banks `1,6` from `$1e:DrawExpMessageWindow`). Together with the
54 bank-`$1d` page-slot operands identified in the previous pass, **84 of the
446 are known desk work**.

### Two sound ids named from the emulator, and one deliberately not

The 187 numeric `sound` operands cannot be named by ear, but they can be named
by experiment: hook `PlaySound.startChannels` (`$32dc`), where `hl` is the
index-table entry and therefore survives the hook's register-based dedup — the
id in `a` does not, which is why hooking `PlaySound` itself collapses every call
into one capture — then perform one identifiable action and read the id back.

* **`$5c` is the racket swing.** Both static sites are inside `StartCharSwing`,
  and the capture came mid-rally under ROM bank `$08`. Named `SFX_SWING`.
* **`$77` is the ball connecting with a scoring object**, captured as a
  Medallion Match deflect. Its three sites — `HandleBallTouchCharEvent`,
  `HandleMinigameTargetHit`, `MinigameTargetTypeScores` — are all that event,
  so `SFX_BALL_CONTACT` is true at each. 448 of 630 `sound` sites are now named.

**`$97` was confirmed empirically and still not named**, which is the more
interesting outcome. The capture is unambiguous — it fires once per revealed
panel in Perfect Shot, exactly as the on-screen grid advances — but the id has
30 sites, and most of them are cutscene and location init scripts
(`AcademyWingInitScript_10`, `LateStudentCrashCutscene`, `Court2SpectatorChat_14`).
A sound id is *one sound*; a name has to be true at every site. `SFX_TARGET_HIT`
would be a lie in a spectator-chat script, and naming it for what it sounds like
needs ears this method does not have. Same reasoning parks `$78`: it was
captured at a point conclusion during the live match, while the static sites are
bank `$1b`'s `RankingBoardAnimState_*` — plausibly one shared flourish cue, but
"plausibly" is not the standard.

Also logged for a future pass, from the hook captures rather than from the
source: `$a6`-`$ad` fire in a fixed cycle while the player walks (a footstep or
surface-tap family, four variants doubled for a two-frame gait), and
`$66`-`$6d` fire during rallies as shot-impact variants. Neither family reaches
the ROM through a `sound` command, so neither is in the numeric remainder — they
are played from tables, and naming them means naming the tables.

### Not reached

Wall Practice and the Tennis Machine, the Dictionary, the ranking-board screen
(which would settle `$80`), the story cutscenes that carry `$96`/`$98`/`$99`,
and the map-script tile that triggers `$a2`. The debug test menu was not reached
either, and the agent's static reading suggests it may be genuinely unreachable
rather than merely unvisited — which, if true, is a `docs/bugs.md` entry rather
than a driving target. The save was altered as permitted: a Tour slot advanced
from level 1 to 3 with one recorded loss; no erase, no save-or-quit.

## The four actionable WRAM buckets are empty again (2026-07-30)

`tools/ram_gaps.py`:

```
                    before   after
bare $dxxx operands    392     354
  unproven             362     352
  rom-scoped            24       1
  unclaimed              4       0
  resolvable now         1       1
  mirrored               1       0
```

Twenty-eight of the 30 settled; 38 operands changed in all, because ten
`unproven` neighbours fell out with them. **Two names were corrected** and two
sites are honestly unsettled (both in `InitExpAwardScreenState`, below).

### `CopyMemoryFast`'s `c` counts 16-byte blocks, not bytes

Worth stating on its own, because it changed the answer at four sites. Bank
`$1c`'s `BackupCharDataScreenRow` does `ld c, $24 / call CopyMemoryFast`, which
reads as 36 bytes and is 576 — `$24` blocks of 16. So `$d430` is not a saved
*row* borrowed from the page plane's corner, it is
**`wCharDataScreenBackup`, a 576-byte snapshot of the whole visible screen**
(18 rows x 32 cells), mirrored across WRAM banks `$02` and `$03` and the same
size as `wCharDataPageSlot1-3`. `AnimateCharDataStatsReveal` takes it once and
copies it back before every step of the reveal, so each step redraws its bands
over the same clean background. It lands inside `wCharDataPagePlane`'s extent,
which is why it needs a variant of its own rather than a wider scope — and why
the bank `$03` side, previously spelled
`wShadowAttrmap + 1 * TILEMAP_WIDTH + 16`, was the **first corrected name**.
The routine labels `Backup`/`RestoreCharDataScreenRow` are misnomers for the
same reason and are left for a naming pass.

### What the rest turned out to be

* **`$d410` x7 in bank `$1c` really is a page-plane cell.** The eight reveal
  bands hand `BlitTilemapRunsFromTable` a *source* base, and they walk `$d240`,
  `$d280`, `$d2d0`, `$d310`, `$d370`, `$d3e0`, `$d410` — rows 18 to 32 of one
  continuous plane, alternating column 0 and column 16. Bank `$1d` writes the
  same address as `wCharDataPagePlane + 2 * TILEMAP_WIDTH + 16` two routines
  away. Scope widened to bank `$1c`, banks `$02`/`$03`.
* **Bank `$0d` names all four court planes in one routine.**
  `LoadMatchUiCourtTilemap` pushes the target-zone overlay's tile and attribute
  halves twice each and `CopyTextRect`s them to `$d12b`, `$d92b`, `$d52b`,
  `$dd2b` — tiles to `wCourtTilemap`/`wCourtTilemapSaved`, attributes to
  `wCourtAttrmap`/`wCourtAttrmapSaved`. `QueueMinigameHudVRAMCopy` says the same
  with the VRAM bank bit: `$d120 -> $9920`, `$d520 -> $9920 + VRAM_BANK1`. The
  `$d12b` and `$d120` operands were rendering as `wScreenAttrmap` — the **second
  corrected name**, and the same mistake the previous pass found in bank `$06`.
* **The results screen's pending-EXP list is a 15-byte pair.**
  `wPendingExpAwardAmounts` (`$d152`, five 16-bit amounts: story, exhibition,
  linked, match/minigame, trophy) and `wPendingExpAwardVariants` (`$d15c`, one
  byte per line, added to that line's base text id). `RecordDrillResult` takes
  the line in `b` and dispatches through `DrillSubHandlers_1d`;
  `DrawNextExpAwardMessage` reads the word back with split-base addressing
  (`add $52 / adc $d1`) and `HasPendingExpAwards` ORs all five to decide whether
  the screen is worth showing. The five handlers are reached by `jp hl`, so their
  bank is unprovable and only handler 3 was traced —
  `RecordDrillResult` runs `wram_bank $06` at its head and never changes it,
  which an instruction-range scope now states. The `Drill*` labels are misnomers
  too: every caller passes EXP.
* **Three bank `$1d` EXP-screen cells** (`$d201`, `$d20c`, `$d1b1`) go to
  `WriteExpScreenStringTiles`, which stores the tile under WRAM bank `$03` and
  the attribute under `$02` — the callee-selected-argument shape. `$d20c` is
  already spelled `wCharDataScreenCell + 16 * TILEMAP_WIDTH + 12` at the
  parallel slot-1 routine 240 bytes away.
* **Four bank `$1e` cells** (`$d1c2`, `$d000`, `$d022` x2, `$d062`) are the same
  shape through `FillTilemapRun`, `WriteTextToTilemap` and
  `RenderProportionalTextAt`. Named `wScreenAttrmap + ...` to match the 64
  siblings in that bank, not `wCharDataScreenCell`: their later cells in the same
  routines already render from a provable bank `$02`, but only because
  `FillTilemapRun` happens to leave it selected on return.
* **`wMinigameTargets`** (`$dc00`, 210 bytes, WRAM bank `$04`, bank `$0a`):
  fifteen 14-byte target records, walked with `ld de, $000e` between them. It
  overlays bank `$0d`'s `wMinigameActors` (seven 16-byte records) at the same
  address — both use bit 0 of `+$00` as the live flag, but the strides and the
  pointer fields differ (`+$04` versus `+$0e`), so they are two overlays and not
  one structure. `InitMinigameTargets` clears 256 bytes, past the array and over
  `wMinigameTargetWork` as well.
* **`$d8f1` is not an address.** Both bank `$0d` sites are
  `ld hl, $d8f1 / add hl, de` on `wMinigamesCurrentScore`: `$d8f1` is -9999, the
  score cap, one site testing equality and the other branching on the carry to
  clamp to `ld de, $270f`. Added to `RAM_IMM_IS_CONSTANT`, which is what emptied
  the `unclaimed` bucket's fourth entry rather than a name.

### The two that are not settled

`InitExpAwardScreenState` (`$1e:$54bb`) selects WRAM bank `$06` and fills
`$d004`-`$d027` in a pattern that fits no declared layout: 5 zero bytes, then
`$20 $20 $20 $20 $30`, 11 zero, `$20 $20 $20 $20 $30`, 10 zero, then `1` into
`$d000`. The `$20`/`$30` runs read as two right-aligned 5-cell digit strings
("    0"), and the zero runs' boundaries land exactly on
`wCharDataLevel + wCharDataNewLevels` and on `wCharDataStats`, but the digit runs
straddle `wCharDataPointsLeft`/`wCharDataLevels` and
`wCharDataStatDeltas`, so neither reading holds all the way. Nothing in bank
`$1e` reads `$d009`-`$d023`, and no other bank references those addresses at all,
so there is no consumer to name them from. `$d004` stays `rom-scoped` and `$d000`
stays `resolvable now`; the latter is a `ram_gaps.py` artifact, since the variant
it thinks covers `$d000` for bank `$1e` is scoped `$4000-$4d00` and this site is
at `$54ec`.

`audit_rom_only_scopes` is silent throughout, `tools/check.py` is clean, and
`make compare` prints `mariotennis.gbc: OK`.

### `ram_gaps.py` was reporting range-scoped sites as already resolvable

`load_symbols` recorded each scope as `(rom bank, symbols)` and dropped its
`start`/`end`. A scope that pins an instruction range covers only the sites
inside it, so treating one as whole-bank coverage reported a site *outside* the
range as `resolvable now` — the opposite of true, and the reason that bucket
held a phantom entry through two passes. The range is carried now, and the
phantom resolves into the honest classification: `$1e:$54ec`'s `$d000` is
`rom-scoped`, one of the two genuinely unsettled sites above.

## `RunDebugTestMenu` was the boot routine (2026-07-30)

Looking for a way to reach the screens no trace has entered turned up a name that
had it backwards. `RunDebugTestMenu` (`$01:$4018`) is **the retail boot
routine**, renamed `InitAndRunGame`:

* `Start` (`$00:$2578`) falls straight into `SoftReset`, which farcalls it
  unconditionally at `$262c` and follows the call with `stop`.
* Its body clears every WRAM bank, then `ValidateSaveRam`, `RepairAllSaveSlots`,
  `ApplyN64RecordsUnlockFlags`, `UpdateUnlockablesSaveBlock`,
  `InitStoryModeState`, `InitDefaultMatchSettings`, `EnableLCD`, a fade in — and
  then `.loop` sets `wStoryModeCurrentLocation` to `STORYLOC_MAIN_MENU` and calls
  `RunStoryModeOverworld`, which is the whole game. The main menu is itself a
  story location, which is why the location space has a `STORYLOC_MAIN_MENU` at
  all.

The "debug test menu" the old name described is real but sits *after* that call
(`$01:$40ec` onward, already labelled `Unused_01_*`) and is unreachable: nothing
jumps to it, and the only way in is for `RunStoryModeOverworld` to return, which
it never does. It is a full dispatcher — one subsystem per button, from
`RunSoundTest` through the tournament bracket, the win/lose screen, the intro and
title screens, the character viewer, and the equipment/stats/link/shoes/racket
screens. Written up in `docs/bugs.md`, along with the detail that makes it worth
recording: **`SAVEFLAG_DEBUG_TEST_MENU` is cleared at boot and set when A is
held, and no instruction in the ROM ever reads it**, so the gesture writes a bit
to battery-backed SRAM that nothing consumes.

### The lever that *is* live, and it is one byte

`RunStoryLocation`'s frame loop calls `RunDebugMenu` (`$05:$66a0`) whenever
`wStoryAutoInteractFired` is zero and **`hDebugStepMode` (`$ff9e`) is nonzero**
(`$0a:$50b4`). That menu's four handlers are `RunDebugWarpMenuThunk`, a text
subcommand, `StartDebugPaletteEditorThunk` and `RunDebugFlagEditorThunk` — a warp
menu and a flag editor, which is exactly the machinery for reaching unvisited
locations.

Nothing in the retail build sets `hDebugStepMode` except the unreachable
dispatcher, so it is dead in normal play — but dead by one byte rather than by a
missing jump, and that byte is writable from the emulator. The connector refuses
ROM writes (and System-Bus writes below `$8000`, which hit the MBC), so RAM is
the only way in; this is the one place where that is enough.

Verified live: the byte persists once written, and the debug menu does **not**
open on the main-menu location, because standing on a menu icon makes
`GetTileTriggerAtPlayer` return nonzero every frame and the loop takes the
tile-trigger branch before reaching the debug check. It needs a real overworld
location with the player on a plain tile.

The unreachable dispatcher stays useful either way: it records what state each
otherwise-unenterable screen needs (`wCurrentStorySlot` + `CheckStorySlot` +
`b`/`c` before `ShowTournamentBracket`; `wCurrentMinigameStoryMatch`,
`wMatchWinLoseFlag` and four character ids before `RunMatchWinLoseScreen`), which
makes it a recipe list for setting up those screens by hand.

## The docs had rotted before the ink dried (2026-07-30)

Nine symbols were renamed this session, three reference documents were written
before those renames landed, and two older docs had been carrying dead
references for longer than that. A citation sweep over every file in `docs/`
(excluding this one, which is a historical log and should keep the names it used
at the time) found and fixed them.

The one that mattered was not a name at all. **`docs/sound_engine.md` had the
channel roles backwards** — "Channels 0–1 carry music, 2–5 carry SFX" — which is
the same swap the ROM0 labels had, and for the same reason: the document was
written from `SfxIndexTable`/`MusicIndexTable` when those two labels were the
wrong way round. Corrected, with the direction now stated from the code that
proves it (`CheckMusicChannelsIdle`/`StopMusic` walk four blocks from
`wSndChannels + 64`, i.e. channel 2, while the effect half of `PlaySound` clears
blocks 0 and 1). `docs/bank0_notes.md` had the matching claim that `StopAllSound`
"silences all sound channels"; it stops the music half only, and id `$50` is what
stops the effects.

Two references pointed at symbols that do not exist:

* `docs/save_format.md` cited `ReadStarVictoryGrid` / `WriteStarVictoryGrid` /
  `LoadStarCharExhibGrid`. Those are pre-rename names; the routines at the
  addresses the doc gives are `ReadMarioCastVictoryGrid`,
  `WriteMarioCastVictoryGrid` and `LoadMarioCastExhibGrid`. The addresses were
  right, which is what made the fix mechanical — a reference with an address
  survives a rename in a way a bare name does not.
* `docs/bugs.md` described `DrawTileAttrRect`'s only reference as the directory
  slot `FarPtr_DrawTileAttrRect`. The substance is right but that spelling
  appears nowhere: a bank's `$4000` directory renders as `farptr <target>` macro
  calls, and `FarPtr_*` labels are the *other* convention, for `$4000`
  pointer-table slots. Now cited as `farptr DrawTileAttrRect` at `$05:$4020`.

`RunDebugTestMenu` → `InitAndRunGame` was updated in `story_mode.md` and
`screens_and_ui.md`. Worth noting that both docs described that routine
*correctly* — one calls it "the game's boot manager first and a debug harness
second" — while the label said otherwise. Two independent readers got the
behaviour right and neither questioned the name, which is a reasonable argument
for citing addresses alongside names everywhere.

The sweep is cheap to repeat: extract every `` `Symbol` `` from each doc and
check it against the labels in `src/`, `labels.json`, `include/*.inc` and
`ram/*.asm`. Everything still unresolved afterwards is a macro name, a data-spec
kind, a deliberate placeholder (`FetchDialogueText_XX`), a third-party RAM note,
or an ordinary English word in backticks.

## Three name families that described the wrong thing (2026-07-30)

### The `Drill*` routines in bank `$1d` are the EXP-award writer

`ClearDrillResultBuffer` / `RecordDrillResult` / `DrillSubHandler0`-`4` write the
two arrays a WRAM pass had just identified as `wPendingExpAwardAmounts` and
`wPendingExpAwardVariants`, and every caller passes EXP. Renamed
`ClearPendingExpAwards`, `SetPendingExpAward` and `SetPendingExpAward_<line>`,
with the two curated local labels (`.recordDrillResult`) following.

The five lines are not guessed. `DrawNextExpAwardMessage` takes each line's base
text id from `DrawNextExpAwardMessageTable` and **adds that line's variant byte
to it**, so the strings name the lines directly:

| line | id | string |
| --- | --- | --- |
| 0 | `31:201` | `Mario Tennis for N64.` |
| 1 | `31:202` | `Exhibition Mode.` |
| 2 | `31:203` | `Linked Play.` |
| 3 | `31:204` (+1..+4) | `the ranking match.` / `the Mini-Game.` / `the Island Open` / `the practice match` / `the exhibition match` |
| 4 | `31:209` | `winning the trophy.` |

Line 3's variant byte is the clincher: four independent `wGameMode` comparisons
in `ShowExpAwardForMatch` select `c` = 0/2/3/4, landing on four consecutive
strings that name those exact modes.

Line 0 is `_N64` rather than `_Story`, which is a deliberate departure from what
the task asked for. Its amount does come from `wPendingExpStory` — but it is
`wPendingExpStory + wPendingExpTrophy` scaled by player level, and the line the
player reads is "Mario Tennis for N64.". The string is what is provable.

### `SceneGfxSlotTable` slots 4 and 5 are the collision and behaviour maps

`LoadStorySceneGraphics` pushes slots 0-6 and pops them in reverse, so the pop
order names them: slot 5 into `wBehaviorMap` (`$d400`) and slot 4 into
`wCollisionMap` (`$d000`), both under WRAM bank `$06` — the same 1024-byte bases
`GetCollisionMapCellAddr` and `GetBehaviorMapCellAddr` index. Four of the other
pops land on slots already named `*Attrmap`, `*Tilemap`, `*Palettes` and
`*SceneConfig`, which confirms the stride and the numbering rather than assuming
them. Every one of the 21 slot-4/slot-5 payloads decompresses to **exactly 1024
bytes**, and nothing else in the record does. So `*AuxTilemap`/`*AuxAttrmap`
become `*CollisionMap`/`*BehaviorMap` across banks `$63`-`$69`.

**Two of the 23 pairs were wrong in the other direction.** The Clubhouse and
Courtyard records point slot 4 back at *slot 0* — the emitted source says
`dw ClubhouseSceneConfig` at both `$4000` and `$4008` — and give slot 5 the
40-byte blob after it. Neither blob is even an LZ stream, so neither can be a
1024-byte map. That is exactly the shape of the 14 match-court records, whose
slots are already `*SceneConfig` / `*SceneConfigAlias1` / `*SceneConfigB`, so
those four labels became config records. Those two scenes have no collision or
behaviour map of their own.

### `Unused_05` is a stub, and the stub numbering shifted

`$05:$53ac` is two bare `ret`s. Nothing reaches it: the bank's `$4000` directory
points at `$53ae`, and a ROM-wide scan for the little-endian word and the
`farptr` byte pair finds only graphics-bank coincidences and a `call $53ac` in
bank `$08` that targets bank `$08`'s own address. So it is not a farptr'd
deliberate no-op and not a routine that returns before its body — it is
`StubNop_05_2`, and the old `StubNop_05_2` at `$6581` becomes `_3`, since every
bank's stub numbering ascends by address.

That also caught a stale sentence in `docs/bugs.md`, which said "the thirty other
`StubNop_*` labels" when there were already 33. Now 32 others, counted from the
source.

### Left open

`LoadSceneGraphicsDirect` (`$0a:$5d2a`) indexes the same `SceneGfxSlotTable`
with a stride of **18**, not 16, reading nine words per record. 592 bytes is
`37 * 16` and not a multiple of 18, and an 18-byte stride would break the
`*Palettes`/`*Tilemap`/`*Attrmap`/`*Tiles` agreement across all 37 records — yet
its own pop order agrees about the roles. Either the stride is a bug or the table
has a second interpretation; not settled here.

## Union resolution is ordered by specificity now, not by file position (2026-07-30)

Four names were wrong and known to be wrong, blocked because
`ScopedRamNames.resolve` walked an address's matchers in **`ram_unions.json`
order**. Ten variants claim `$d000-$d7ff` across three WRAM banks, so leaving
that to file position makes every curation decision really a decision about line
numbers. Two passes had offered a union reorder and both correctly refused it.

`_matcher_precedence` now returns a sort key, most specific first:

1. a **site scope** — a `start`/`end` range at most 16 bytes wide
2. **bank consistency** — the variant's declared WRAM banks contain the bank
   provable at the site
3. the **ROM constraint**, narrowest first: explicit range > whole bank > none
4. the **WRAM constraint**: one proved bank > a mirrored variant's bank set > none
5. tie: registration order, i.e. file order — still the tiebreak, but only the
   tiebreak, and stated rather than incidental

### The obvious ladder is wrong in both directions

The one this project would have written by hand — range > bank+wram_bank >
bank > wram_bank — was implemented first and **broke 90 operands**. Variants
scoped `{bank $1c/$1d, wram_bank $06}` (`wCharDataStats`, `wCharDataLevels`,
`wExpScreenCharStats` …) were swallowed by `wCharDataScreenCell`, whose scopes
are *routine-sized* ROM ranges — `{bank $1d, $4ad2-$5440}` is 2.4 KiB. A range
that big says no more about any one operand in it than a whole-bank scope does.

Inverting it, so a proved `wram_bank` outranks every ROM constraint, **breaks 71
the other way**: `wNameEntryBuffer`, `wEquipItemList`, `wRankingBoardDoubles` and
others lose to their union's catch-all variant, because those unions are built
the opposite way round — the ROM scope is the discriminator and the bare
`wram_bank` variant is the fallback. `ram_unions.json` says so in as many words,
labelling one *"screen scratch (any other screen, where WRAM bank `$03` is
provable)"*.

So ROM has to outrank WRAM, and the two cases that must escape that are lifted
above it. Tier 1 carries the four fixes: an instruction range naming no
`wram_bank` is the declared form for an address whose bank the *callee* selects,
so the bank provable at the site is precisely the fact it exists to overrule.
Tier 2 keeps the routine-sized ranges in their place without the width threshold
having to do that work — and it is not a new judgement, it is exactly what
`audit_rom_only_scopes` reports, used to *choose* rather than to warn, so it can
only reduce audit hits.

The 16-byte threshold is measured, not tuned. The file's ranges fall into two
cleanly separated populations — 35 per-site scopes of 3 to 11 bytes, then
nothing until 28 bytes and on up to 11 KiB — and every value from 3 to 128 gives
byte-identical output. The first value that changes a name is 248.

### The check that makes the diff trustworthy

With the tool change alone and no new scopes, **`git diff src/` was empty**.
That is the strongest available evidence the ordering reproduces the old
file-order behaviour everywhere curation does not deliberately ask it to differ,
and it means every renamed operand is attributable to a scope added on purpose.
Four scopes were then added and exactly four operands moved:

| site | was | is |
| --- | --- | --- |
| `$05:$4422` | `wShadowTilemap` | `wWindowShadowTilemap` |
| `$06:$5224` | `wScreenAttrmap` | `wDecompBuffer` |
| `$06:$728e` | `wWindowShadowTilemap` | `wDecompBuffer` |
| `$1d:$6df6` | `wCharDataNumberBuffer + 3` | `wCharDataScreenCell + 4 * TILEMAP_WIDTH + 17` |

The `$05:$4422` case is the tidiest: the `wWindowShadowTilemap` union's comment
already documented `RestoreShadowTilemapRow` as the reason for its one
instruction-range scope — but that scope covers the *attrmap* half at
`$4479-$447c`, and the tilemap half at `$4422` was simply never added.

**The rule for future curation:** to pin one operand, write a `start`/`end`
range of exactly that instruction and name no `wram_bank`. That now beats
everything, including a proved bank. A wider range reads as a subsystem claim
and competes on ROM narrowness alone, below bank consistency.

## Three more shipped defects, and eleven that were not (2026-07-30)

The fourteen "branch to the next label" sites are settled. Three went into
`docs/bugs.md`; the other eleven are harmless and are recorded as such so the
lead is closed rather than re-opened by the next sweep.

* **`RegisterFrameTask` walks 22 records over a 16-record table.** The collapsed
  branch was only the missing table-full handler; following it up found the real
  defect. `wFrameTasks` is 64 bytes and `ClearFrameTasks` clears exactly
  `4 * 16`; `RunFrameTasks`, `UnregisterFrameTask` and `SortFrameTasks` all say
  16. Only the insert loop says `ld c, $16` — 22 — so records 16-21 land on
  `wMasterPalettes` at `$c200`, the copy that fades scale into the live
  palettes. An overflow task also never runs and cannot be unregistered.
* **`GetActorStateAddr` destroys the flag it computes.** `ld a, [hl]` / `cp $00`
  reads the activity byte, then `pop hl` / `inc h` / `dec h` / `ret` overwrites Z
  with a test of the pointer's high byte — always `$d0`-`$d5`, never zero.
  Eleven call sites branch on Z and none can fire. What proves it is a mistake
  rather than an idiom is that it *is* the idiom: `CheckActorScriptEnd`,
  `IsActorBusy` and the routine at `$0a:$4750` all use `inc h`/`dec h`/`ret z` as
  their **first** instruction, a null-pointer guard. Here the halves are in the
  wrong order.
* **`CheckBallContactWindow`'s animation-state test does nothing** — all four
  `cp` arms target the instruction after the last of them, so the hitting box is
  identical in every animation state. The sibling arm above it adjusts reach by
  `wCharFlags` bit 1, and `CharRallyEndState` runs the same four-way membership
  test with a real body, so the shape is intact elsewhere.

Two entries in the lead I handed over were **not** collapsed branches at all
(they were the live conditional one instruction earlier), and one real site was
missing from it — found by re-deriving the sweep from scratch rather than
working the list.

### A naming convention this exposes

Auto-derived local labels on a collapsed branch name a block that does not
exist: `.lose` at `$14:$278`, `.variantB` at `$27:$1320`, `.checkX` at
`$08:$6515`. A reader skimming `MachineCourtResultScene` will believe there is a
lose path. Left as-is for now, but a `.same`/`.nop` convention would stop the
label asserting something the code does not.

And two dead-decision shapes this sweep cannot see, for whoever re-runs it: a
conditional whose two arms are byte-identical (`$27:$1117`), and a test all of
whose outcomes are `ret` (`$08:$6316`).

### One inverted pair of labels, fixed

`$38:$63e1` reads `ld a, [wMatchIsDoubles]` / `or a` / `jr nz, .singles` — and
the `nz` path is the *doubles* path. It sets `wCharSelectMode` 4 or 5, whose
rings (`CharSelectSlotRing4`/`5`) carry two slots per side, i.e. four
characters; the `z` path sets modes 2/3, one slot each. Renamed `.doubles`, with
`.slave4`/`.slave2` — which set modes `$03` and `$05`, so their names were wrong
about the mode as well as the side — becoming `.singlesSlave`/`.doublesSlave`.

### The collapsed branches, pinned rather than renamed wholesale (2026-07-30)

Acting on the naming problem the branch sweep exposed turned out to need less
renaming than expected, because most of the labels were not lying.

Re-deriving the set with **per-function scoping** matters: local labels repeat —
`.done` appears 34 times in bank `$00` — so resolving a target by name alone
gives whichever `.done` came first in the file. A first attempt without scoping
found 6 of the 14 and would have renamed the wrong labels.

Of the 14, nine have the collapsed branch as their label's *only* reference, so
only those could be renamed at all. Reading the block each one heads, **five of
the nine describe their block correctly**: `.advanceTextId` really does
`inc hl` into `wScriptDialogueTextId`, `.walkPlayer` opens with
`script_move_target ACTOR_PLAYER`, `.face` with `script_face_toward`,
`.checkCutsceneStepTimer` reads `wCutsceneStepTimer`, and `$12:$5e35`'s `.done`
heads a bare `ret`. A label names a *location*, not a branch — those are honest,
and it is the branch that is inert.

Four asserted a path that does not exist and were renamed from their block's
content, following the convention the rest of the ROM's local labels already
use (`call Foo` → `.foo`, `xor a` + store → `.clearFoo`):

| site | was | is |
| --- | --- | --- |
| `$14:$4301` | `.lose` | `.clearShowLocationName` |
| `$1b:$5a0a` | `.nonZero` | `.setBobOffset` |
| `$27:$5be7` | `.variantB` | `.facePartner` |
| `$38:$67f1` | `.done` | `.drawSlotPrompt` |

`.lose` was the worst of them: a reader skimming `MachineCourtResultScene` would
believe there is a lose path, and the block is the scene's ordinary
continuation.

The other five sites' labels are shared with real branches from elsewhere
(`CheckBallContactWindow`'s `.checkX` has four other references, three of which
are live jumps over the remaining comparisons), so the label is accurate and
renaming would have been the error.

**The inertness is now checked instead of encoded in a name.** `tools/check.py`
grows a `branches` check that finds every conditional branch whose target is the
instruction after it and compares the set against a curated list of the 14. A
new one is a failure, and so is a listed one that stops being collapsed — the
first means a curation change invented a branch that decides nothing (far more
likely a mis-carve than a discovery), the second means the list is stale. Both
directions were tested by breaking them deliberately, because a check that
cannot fail is worse than no check: this project has already been bitten by
`make compare | grep OK | tail -1`, which always exits 0.

## A sanitiser dropped the field the whole session was for (2026-07-30)

A driving session reached the Dictionary, Wall Practice, the Tennis Machine
Room, the Awards Ceremony and **all twelve `End*` locations** — and reported
that `tools/ram_gaps.py` had not moved by a single site. Its diagnosis was that
the MCP's `dump_coverage` does not emit `rom_wram_bank`, and its recommendation
was that no further driving is worth doing until the connector is changed.

**The diagnosis was wrong and the recommendation would have been costly.**
`dump_coverage` emits the mask; two earlier sessions' dumps carry it, which is
checkable in the committed files. What happened is that the session's *own
sanitiser* — dropping the out-of-range `0xc00000 | v` entries — rebuilt each
file as `{"rom": ..., "other": ...}` and discarded the parallel array. The
symptom then looks exactly like a missing feature, because `load_traced_wram_banks`
takes `if len(masks) != len(rom): continue`: a file whose mask is absent *or
merely the wrong length* contributes nothing, silently.

The recovery was one call. The session never restarted its trace, so BizHawk's
coverage buffer still held all of it: a fresh `dump_coverage` returned 20,587
offsets **with** 20,587 masks, every one non-zero. Re-sanitised properly —
filtering `rom` and `rom_wram_bank` in lockstep — it is byte-for-byte the same
set of in-range offsets the session had, 16,740 of them, with the evidence
restored.

| | before | after |
| --- | --- | --- |
| sites with an observed WRAM bank | 64,677 | **66,167** |
| resolved that the dataflow could not | 18,333 | **18,966** |
| `unproven` | 352 | **343** |
| actionable (`unclaimed`/`mirrored`/`rom-scoped`) | 2 | **12** |

So the session's work was not wasted; only its output file was. The lesson is
narrow and worth keeping: **a coverage dump is two parallel arrays, and any
filter must cut both.** A future sanitiser should assert `len(rom) ==
len(rom_wram_bank)` on the way out rather than trusting the shape.

### One name got worse, honestly

The recovered evidence made `$0a:$4898` and `$0a:$622f` render as bare `$d040`
and `$d000` where they had said `wActors + 1 * ACTOR_SIZE` and `wActors`. That
is the trace overruling the dataflow, which is the documented precedence, and it
is an improvement: both sites are now `mirrored` candidates observed under banks
**3 and 4** (`GetSceneTilemapAddr`, `WaitPlayerMoveDone`), so a single
bank-`$04` name was asserting more than the evidence supports. The bare-operand
total went 354 → 355 for that reason; a bare address is honest ignorance and a
wrong name is not. A third operand, `$0f:$5621`, gained `wActors` from the same
data.

### The debug-menu lever, confirmed and written down

The one-byte gate works, and the recipe is now specific enough to reuse:

* Set `hDebugStepMode` (`$ff9e`) non-zero, be in a real overworld location, and
  **tap A once on an empty tile in a freshly loaded room**. Idle frames do not
  open it and neither does holding a direction (movement never settles). That
  was 100% reliable across ~15 uses.
* The menu's four handlers are **Scene** (the warp), **Level Up** (applies
  instantly, no sub-screen), **Pallette** (a full-screen tile/attribute test
  pattern, not an interactive picker) and **Flags** (a grid editor, rows for
  flag groups 0-3 and columns 0-F).
* In Scene, Left/Right adjust the location number in short taps — longer holds
  double-step — Down moves to `ENTER NO`, and A commits: `$c280` changes
  immediately and the target's init code runs, even though the overlay still
  shows the previous room's stale framebuffer. Control returns to the *top*
  level, so chaining warps means re-entering Scene each time.

Also corrected: **the main menu's whole middle row is Mario Tour** — three
story-mode save slots, not one story slot flanked by other modes. The earlier
guess that row 2 centre was an exhibition mode was wrong.

### What the warp still cannot reach

`ShowRankingBoard` is not a `STORYLOC_*` destination at all — it is farcalled
from match-result and tournament-end code after the caller sets
`wRankingBoardMode`, `wRankingBoardDoubles`, `wRankingBoardPlayerRow` and
`wRankingBoardSilent`. No Scene warp reaches it, so sound id `$80` stays
unidentified until a real ranking match is driven to its end. The twelve `End*`
rooms were reached as bare per-room loads rather than through
`RunEndingCreditsSequence`, so the credits captions and cross-room chaining did
not run.

## The twelve actionable sites, worked (2026-07-30)

The recovered WRAM-bank masks turned two actionable sites into twelve. Ten are
now named; the two that remain are the ones a previous pass deliberately left,
and nothing about this work changes their reason.

```
                    before   after
bare $dxxx operands    355     345
  unproven             343     343
  unclaimed              8       0
  mirrored               2       0
  rom-scoped             2       2
```

### The eight unclaimed were one subsystem

All eight — `$db10` (five sites), `$db12` (two) and `$d900` — are
`UpdateSceneTileAnimations` (`$0a:$6460`), which selects WRAM bank `$05` itself
at `$6474`. They are the three variables of one loop: seed a cursor with a
buffer base, fetch a 2-byte far source pointer out of the scene's slot 6 record,
`FarCopyBytes` the tile data to the cursor, `QueueVRAMCopy` it out, advance the
cursor by the length copied. So `wSceneTileAnimBuffer`,
`wSceneTileAnimBufferPtr` and `wSceneTileAnimSrcPtr`.

Two things kept this honest. First, **all eight `$d9xx`/`$dbxx` references in
bank `$0a` are these sites**, so a `{bank $0a, wram_bank $05}` scope captures
them and nothing else — and because the routine selects the bank itself, both
halves are provable and the scope stays inside the audit rather than needing the
exempt form.

Second, the generator refused the first attempt: `ram_unions overlap:
$da80-$db08 and $d900-$dc00 cover the same bytes`. That existing union is
`wSceneTileAnimHeader`/`wSceneTileAnimEntries` — *the same subsystem*, under the
same scope, put there by an earlier pass. The two pointers belong in it, so it
widened to `$db14` instead, and only the buffer needed a span of its own. The
overlap check turned a clumsy declaration into the right one.

The buffer's extent is not proven — no length for it appears anywhere — so it is
declared as "at most `$180` bytes, bounded by `wSceneTileAnimHeader` above it",
which is a fact rather than a guess.

### Both mirrored candidates were single-bank after all

Neither is really mirrored; both are the documented trap that **the bank live at
an operand need not be the bank it means**, and both were rendering bare because
the recovered trace observed two banks at them.

* **`$0a:$4898`** loads the actor slot-1 pointer and only executes
  `wram_bank $04` **two instructions later**, so the bank seen at the operand is
  whatever the caller had. It is `wActors + 1 * ACTOR_SIZE`, and the name it
  briefly lost was right.
* **`$0a:$622f`** is in `GetSceneTilemapAddr`, which returns `base + cell`
  *without dereferencing anything*, so no bank is live at it at all. Its caller
  `CopySceneTilemapRect` selects `wram_bank $02` and then copies with a `$40`
  row stride — the 64-wide map buffer's geometry. It is **`wMapBuffer64`**, and
  the `wActors` it used to say was a false name: the same error class as
  `GetCollisionMapCellAddr`'s base, which said `wActors` until earlier today.

Both are pinned with per-site scopes, which the new specificity ordering makes
the top tier precisely so that a site whose bank the code contradicts can be
stated outright.

### The two left, and why

`$1e:$54ec`'s `$d000` and `$d004` stay numeric. `InitExpAwardScreenState` fills
`$d004`-`$d027` with a pattern that fits the character-data block exactly at its
zero runs and not at all at its `$20`/`$30` runs, and fits right-aligned digit
strings except that the routine which formats those writes somewhere else. The
missing evidence is a *consumer*: nothing in bank `$1e` reads `$d009`-`$d023`,
and no other bank references them. More coverage does not help — the question is
semantic, not a bank question — so they stay honestly numeric.

## Bank $1b's stranded confirm screen, and what is left to drive (2026-07-30)

With the debug-menu warp working, the obvious question is how much of the
remaining 343 `unproven` operands it can reach. Measuring where they actually
are answers it, and the answer is "a minority":

| bank | sites | what they are in |
| --- | --- | --- |
| `$1b` | **125** | the ranking board, minigame data rows, and a stranded confirm screen |
| `$03` | 37 | `RestoreStoryBlockFromBackup` — the save-repair path |
| `$3b` | 30 | `DecodeTrophyCounts`, the N64 transfer records |
| `$05` | 22 | `WriteStringToTilemapStreamed` |
| `$1e` | 21 | mostly `DrawExpDoubles{Player,Partner}Panel` |

Almost none of that is a *story location*, which is the only thing the Scene
warp selects, so the warp is one lever among several rather than the answer.
Four different obstacles are in play: screens that are farcalled from
match-result code and are not locations at all (the ranking board, the biggest
single cluster); screens that need game *state* rather than a place (the doubles
EXP panels want a completed doubles story match; `RestoreStoryBlockFromBackup`
wants a corrupted save); a screen that only runs on non-colour hardware
(`ShowDmgLockoutScreen`); and code that cannot run at all.

### Eleven of the 343 are unreachable, permanently

`$1b:$69d9`-`$6aa0` is seven complete routines with no way in — a confirm-screen
suite: a screen setup that sets `wMinigameHighScoreMode` and calls
`InitConfirmScreen`, five prompt drawers ("Erase?", "Erase it? Really?",
"Continue?", "Is this correct?", "Char. and item data.") each with its Yes/No
labels, and an `hh:mm:ss` renderer of `wGameTimer` that writes the `$3a` colon
glyph between the fields.

They sit immediately after `StubNop_1b_09`, whose three bare `ret`s *are*
legitimately used as a no-op frame task, so the emitter attributed the whole run
to that label and the fragments read as stub filler. A ROM-wide scan of all 200
candidate entry addresses — as a same-bank `dw` or a `farptr`-shaped word
followed by bank `$1b` — yields seven hits and all seven are coincidences
(`11 6a d0` is a neighbouring `ld de, $d06a`; `cd ae 6a` is a call inside the
span; the rest are graphics bytes in banks `$2f`/`$36`/`$70`). They are now
named `Unused_1b_*` and split out of the stub's span, and recorded in
`docs/bugs.md`.

So 11 of the `unproven` sites can never be proven by driving, and any future
session should stop counting them.

### The DMG lockout screen needs one HRAM byte, not a Game Boy

`ShowDmgLockoutScreen` (6 sites in bank `$01`) runs when `hIsCGB` is zero
(`$00:$25a8`). `Start` computes that byte — and then falls into `SoftReset`,
which is what the in-game A+B+SELECT+START combo jumps to (`$00:$27bd`), so
**`hIsCGB` is never recomputed on a soft reset**. `SoftReset`'s HRAM clear runs
`$70` bytes from `$ff80`, i.e. up to `$ffef`, and `hIsCGB` lives at **`$fffe`**,
outside it. Writing `$fffe = 0` and hitting the reset combo should therefore
land in the lockout screen on real CGB hardware emulation.

**The lever is confirmed, and its coverage is not capturable this way.** Setting
the byte and hitting the combo does reach the screen: `ShowDmgLockoutScreen` ends
in `.loop: call AdvanceFrame / jr .loop` and never returns, so the game hangs on
it -- which is exactly what an observer reports as a crash, and recovering by
power-cycling is what put `hIsCGB` back to `$01`.

What cannot be done is *tracing* it. A traced `step_frames` that crosses
`SoftReset` kills the Lua connector, reproduced twice out of two attempts: under
hooks the reset path clears every WRAM bank, validates SRAM and LZ-decompresses
the screen, far more work than the step timeout allows, and once the step times
out the accept loop stops -- the listener keeps a pending connection with a zero
backlog while BizHawk is still alive, and only a Lua Console reload recovers it,
losing the trace buffer with it.

So the six operands in `ShowDmgLockoutScreen` need either an untraced reset
followed by a trace that starts *inside* the screen -- too late, since the setup
code is what references them -- or a capture path that survives a reset. They are
parked, not solved. The rule worth keeping is narrower than this screen: **do not
trace across a reset.**

### The stride-18 question, settled (2026-07-30)

The open question left by the `SceneGfxSlotTable` work — why
`LoadSceneGraphicsDirect` (`$0a:$5d2a`) indexes a 16-byte-record table with a
stride of 18 — is a **bug**, and it is in `docs/bugs.md` now.

The arithmetic is not ambiguous: `2a` is saved in `de`, `hl` is shifted to
`16a`, and `add hl, de` makes `18a`. The sibling `GetSceneSlotPtr` twenty bytes
earlier does it correctly with four `add hl, hl` and a `+ 2 * slot`. So the read
slides one slot further into the table per scene id — scene 0 is right, scene 8
lands on record 9 and loads another scene's graphics.

What makes it invisible is the call graph: the only caller is
`LoadAndDisplayScene`, whose four callers are all the **scene viewer**
(`SceneViewerSelectScene`, `InitSceneViewer`, `InitSceneViewerDefault`), which
hangs off `RunSceneSelectDebugMenu` and is reachable only through the debug menu
that nothing in the retail build opens. Its `$4078` directory slot is never
farcalled from another bank.

That is the second defect this week found in code that only the unreachable
debug harness can run, after the `$1b` confirm screen — a reminder that "no
observable consequence" and "no defect" are different findings, and the file
records which one applies.

## The on-court character's state and animation ids (2026-07-30)

`constants.json` goes 530 → 638 and `include/constants.inc` gains 34 defs in
three families: `CHARANIM_*` (48 sites), `CHARB_*` (45) and `CHARSTATE_*` (15).

The first question — are `wCharAnimId` and `wCharSwingAnim` two id spaces? —
resolved the other way from how it was posed. They are **one** space:
`SetCharAnimation` (`$08:$69ea`) takes the id in `d`, stores it in
`wCharAnimId`, and `wCharSwingAnim` is copied straight into it
(`ld hl, wCharSwingAnim / ld d, [hl] / call SetCharAnimation` at `$08:$6c4a`).

### The names come from the animation scripts, not from inference

`SetCharAnimation` indexes `wCharAnimTablePtr`, which
`SetupCharSpriteFromObjectDef` fills from the object definition's `+6/+7` word —
for a match character that is `<Char>SpriteAnims`, the 19-entry table at the head
of every character bank. So an id *is* `<Char>SpriteAnim00`-`18` and the space is
exactly `$00`-`$12`. The debug character viewer's input table confirms it
independently by feeding `SetCharAnimation` the identity list `$00`..`$12`.

Two arithmetic rules in bank `$08` generate most of the table, and each is
matched by a structural rule in the scripts themselves:

| rule | code | what the scripts show |
| --- | --- | --- |
| `swing + $08` = the held "ready" pose | `ld a, $08 / add [hl]` at `$08:$6c0f` | `Anim0d/0e/0f` are each one frame held with delay `$ff`, and that frame is the one immediately *before* the corresponding swing's frames |
| `swing + $04` = the quick, uncharged variant | `ld a, $04 / add [hl]` at `$08:$6e37` | `Anim09/0a/0b/0c` are each the *first frame only* of `Anim05/06/07/08`, held longer, then `anim_set $01` back to idle |

That is what makes `CharRallyEndState`'s otherwise-odd membership test over
`$05 $06 $07 $09 $0a $0b $12` legible: it is "a ground swing or a dive is still
playing", all three strokes in both charged and quick form, plus the dive. The
smash (`$08`) is absent only because the next instruction tests the airborne
flag instead — the smash script holds its last frame until the character lands.

One id breaks the pattern and is named from its own evidence:
`CHARANIM_SERVE_READY` (`$10`) is not `smash + $08`, it is a serve-specific pose
that `CharServeInitPhase.waitAnim` and `AiServeWalkToSpot` both block on.

### Two states are unreachable from any instruction

`CHARSTATE_RECOVER` (2) and `CHARSTATE_AWAIT_SERVE` (4) have **zero** instruction
sites: they are only ever entered through `SetCharStateOnBallHitTable` and
`ServeRoleCharStateTable_08`, and `render_operand` rewrites instruction operands
only — a `db` row cannot carry a constant. They are defined anyway so the enum is
complete, which the file already does for 79 other members.

### Five corrections to `docs/match_engine.md`

The doc is a week old and already had errors, which is the argument for checking
a reference against the source rather than trusting it:

* **`wCharFlags` bit 0 is not "struck by the ball (stunned)".** The doc listed
  only the body-hit writer; the dominant one is `ApplyShotRecoil` (`$07:$546e`),
  pushed as `ExecuteShot`'s return address so it runs after *every* stroke. The
  bit means "movement input suspended".
* **The dive reach multiplier is `1.25 ×`, not `1.125 ×`** — `$08:$6fcb` copies
  `de` to `hl`, shifts `de` right *twice*, and adds.
* **`SetCharStateOnBallHitTable` is `00 02 01 02 02 01 06 07`** — it does not
  merely swap 1 and 2; it also maps 3 → 2, 4 → 2 and 5 → 1, leaving only
  0/6/7 alone.
* **`CheckBallContactWindow`'s animation test is dead code** — independently
  rederived here, having been found by the collapsed-branch sweep from the other
  direction. Two agents converging on it from unrelated starting points is worth
  more than either finding alone.
* The doc never explained the seven-member set or what `$09`/`$0a`/`$0b` are;
  its "animation `$0a`" condition in the shot section is the quick backhand, not
  a separate case.

The first three are applied; the doc now carries the corrected values with their
addresses.

## The animation scripts have a fifth command, and it is one byte (2026-07-30)

`render_sprite_anim` parsed 2-byte entries and returned `None` on anything else,
so **211 of the 570 declared scripts fell back to plain `db`** — and this
document claimed all 570 rendered as macros, which had been wrong since the
`sprite_anim` spec landed.

The missing command is the fall-through case in both interpreters. After
testing `$ff`, `$fe` and `$fb`, `StepCharAnimation` (`$08:$77a8`) does
`ld a, $ff / ld [wCharAnimDelay], a / jr .keepFrame` — it sets the delay to its
maximum and keeps the current frame **without reading an operand**. So any
`$f0`-`$fd` other than `$fb` is a *one-byte* "hold this frame forever". That is
exactly why so many scripts failed to parse: a one-byte command leaves the rest
of the region at an odd offset, and a script that ends in a hold is an odd
length outright. `include/macros.inc` had described the behaviour in prose all
along; nothing implemented it.

With `anim_hold` added, **569 of 570 render as macros** and the build stays
byte-perfect. The standing pose now reads as what it is:

```
AlexSpriteAnim00:
        anim_frame $00, $ff
        anim_hold $fd
```

which is `CHARANIM_STAND` from the constants work an hour earlier — the two
passes met in the middle without either knowing about the other.

**The one script that still falls back is a finding, not a gap.**
`SeanSpriteAnim04` is declared 8 bytes and holds `1a 14 | 1b 14 | 1c 14 | fd`,
i.e. seven bytes of script and a trailing `$00` pad. The renderer refusing it is
the designed behaviour — it returns `None` rather than inventing a reading — and
the declared extent is what is one byte long, the same shape as the `map_actor`
extents recorded earlier.

## A fourth driving session: the status and trophy screens (2026-07-30)

Six dumps, all with their masks intact this time (the sanitiser filtered `rom`
and `rom_wram_bank` in lockstep and asserted equal lengths per file — the check
that a previous session's loss made mandatory).

```
                    before   after
bare $dxxx operands    345     344
  unproven             343     316
  rom-scoped             2      28
```

**27 of the 343 unproven sites moved**, 26 into `rom-scoped` and one to a name
outright. Traced sites went 66,167 → 68,201 and dataflow-beating resolutions
18,966 → 19,370. The new `rom-scoped` cluster is `$d803`-`$d82b` in WRAM bank 3,
referenced from ROM banks `$1b` and `$3b` — exactly the trophy and N64 screens
the session drove.

Screens reached: the character/partner data pages, the **game-progress
checklist** (which turns out to *be* the "trophies" screen — `RunTrophiesScreen`
/ `DecodeTrophyCounts` in bank `$3b` draw a scrollable cleared-tournament list,
not a trophy case), the N64 tournament-data star chart, the Mario-cast
exhibition and mini-game data screens, the equipment screens, and the
Dictionary.

### Why the doubles EXP panels stayed unreachable, with the reason nailed down

`DrawExpDoublesPlayerPanel`/`PartnerPanel` are gated by `FLAG_DOUBLES` tested
once at the results screen's setup (`$1e:$4022`) and latched into
`FLAG_TEMP_RESULTS_SCREEN_OPEN` for the rest of that screen's life — and
exhibition matches do not route through that flow at all, which is gated deeper
by `wSaveAndQuitRequest` coming from real match completion. So it needs a
completed **story** doubles match, not merely a doubles match.

The Flags editor settled why this save cannot provide one: flags 59-63 are set
(Dream Match Singles, all Island Open Singles rounds) and 52-55 are clear — the
save completed the singles campaign and none of the doubles equivalents.

### The Flags editor's layout, which is the reusable part

Confirmed by poking a known bit and reopening: the grid pages in rows of 16
flags, each row-group `N?` covering flags `16N`..`16N+15` as two sub-lines
(columns `0`-`7` = byte `2N`, columns `8`-`F` = byte `2N+1`), with column
position being the bit **MSB-first** — column 0 is mask `$80` — the same bit
order as the `test_flag`/`set_flag` encoding. A circled glyph means set. The
screen is **drawn once on open, not live**, so a `write_memory` poke only shows
after backing out and reopening.

### Save status

Written to twice, with no content change intended. `RunSavedDataMenuFlow`'s
racket- and shoes-select screens both `farcall SaveStorySlot` **unconditionally
on return**, even when the player only views and cancels — worth knowing before
any future session browses the equipment menu. The session's calibration poke of
`FLAG_DOUBLES` had self-cleared before the final save, which was verified by
reading the byte immediately before backing out.

## The save-repair path needs no reset, because those operands are not in it (2026-07-30)

The open question was whether `RestoreStoryBlockFromBackup` (37 `unproven`
operands attributed to bank `$03`, 18 to that label) could be reached without a
reset — the repair runs from the boot routine, and tracing across a reset kills
the connector.

The question dissolves. `ValidateSaveRam` and `RepairAllSaveSlots` are indeed
called from exactly one place each, `InitAndRunGame` at `$01:$408b`/`$408e`, so
the repair path *is* boot-only. But **`RestoreStoryBlockFromBackup`'s own body
already resolves** — it renders `wDecompBuffer` throughout. All 18 bare operands
are in unlabelled code *after* its `ret`, in a run of **eight unreachable
routines** (`$553b`-`$5669`) that no reference reaches.

They are the superseded version of the repair: five copies of one routine with
the save-block id hardcoded (`$06` through `$0a`), plus three helpers. What
replaced them sits one label below — `RepairAllSaveSlots` calls the surviving
routine three times with `b` = 0, 2, 4 and lets it derive the backup block with
`ld a, $1b / add b`.

The reference scan needed care, and my first attempt got it wrong. Treating
"address followed by `$03`" as a far pointer flagged two hits inside
`JuniorClassCourtDoublesNpcScripts_11` — but a `map_script` row is
`(actor, mask, flag, handler, arg0, arg1)`, and the byte after the handler is
`arg0`, which happened to be `$03`. Re-run against bank `$03` only, requiring a
same-bank `dw` or a `call`/`jp` opcode immediately before, five hits remain and
every one is a coincidence: `41 56` is the "AV" of the ASCII string `"SAVED"`,
`2a 56` is an `ld a, [hl+]` / `ld d, [hl]` pair at three sites, and `21 56` is an
`ld hl` operand byte.

Named `Unused_03_*` and split out of `RestoreStoryBlockFromBackup`'s span, so the
routine stops looking half-analysed when it was complete.

### Which changes the count of what driving can ever reach

With bank `$1b`'s confirm screen (11) and this run (18), **29 of the 316
remaining `unproven` operands are in code that cannot execute**. Any future
session should subtract them before judging a driving run — and the shape is now
familiar enough to look for deliberately: unlabelled code between a `ret` and the
next label, attributed to whichever label precedes it.

## Sweeping for stranded code, and the real denominator (2026-07-30)

Two unreachable families turned up this week by accident — bank `$1b`'s
confirm screen and bank `$03`'s superseded save-repair routines — both found
only because someone chased an operand into them. The shape is mechanical
enough to search for: **unlabelled code immediately after an unconditional
terminator**, which the emitter therefore attributes to whatever label precedes
it. Descent creates a label for every reference it finds, so "no label of its
own" already means "nothing the descent could see reaches it".

Sweeping all 128 banks for runs of three or more instructions starting right
after a `ret`/`reti`/unconditional `jp`/`jr`, with no global *or* local label at
the entry:

```
stranded runs found                        273
bare $dxxx operands inside them             15
runs carrying those operands                  9
of those 9, zero reference-shaped hits        7
```

The two families already named do not appear, because naming them gave their
code labels — which is the check that the sweep measures what it claims to.

**So the denominator is now known.** With the 29 operands already confirmed
unreachable (11 in bank `$1b`, 18 in bank `$03`) and at most 15 more here,
**at most 44 of the 316 remaining `unproven` operands — under 14% — are in code
that cannot execute.** The other ~272 are genuinely reachable, so driving is
still the right tool for them; it just is not the tool for these.

The nine candidates, largest first, for a pass that wants to name them:

| site | instructions | operands | attributed to |
| --- | --- | --- | --- |
| `$05:$41f8` | 36 | 2 | `QueueFullAttrmapCopy` |
| `$1b:$60bd` | 34 | 2 | `DrawCharSelectMugshots` |
| `$0b:$412f` | 19 | 1 | `Unused_0b_0` |
| `$1b:$664b` | 14 | 2 | `LoadUnlockDebugNavGridGfx` |
| `$38:$6920` | 11 | 1 | `DrawRemoteSlotLeftHandedMark` |
| `$17:$4a05`/`$4a06` | 9/8 | 2 each | `QueueCaptionRowToVRAM` |
| `$0a:$5e52` | 8 | 2 | `SceneViewerSelectScene` |
| `$1e:$7a30` | 5 | 1 | `FillProgressListRowAttrs` |

Spot-checked `$05:$41f8`: a real routine (`push af / ld a, b / wram_bank /
pop af / and $1f`) beginning one byte after `QueueFullAttrmapCopy`'s `ret`, with
no label. They are not artefacts.

Two caveats on the sweep, so nobody over-reads it. The reference test cannot see
a target reached through a computed jump or an unfollowed data table, so a
zero-hit run is *strong* evidence rather than proof — the bank `$03` case needed
a manual pass to reject five coincidences (`41 56` inside the ASCII `"SAVED"`,
an `ld a, [hl+]` / `ld d, [hl]` pair, an `ld hl` operand byte). And ROM0's
stranded runs sit near the RST and interrupt vectors, which are reached by
mechanisms a `call`/`jp` scan does not model; they carry no WRAM operands, so
they do not affect the count either way.

The 273 runs are themselves the larger prize: most carry no `$dxxx` operand at
all, so `ram_gaps.py` never mentions them, but they are unlabelled code
attributed to a neighbour — the same reason `RestoreStoryBlockFromBackup` looked
half-analysed when it was complete.

## The doubles EXP panels, reached by forcing the score (2026-07-30)

The target that three sessions had failed to reach is done.
`DrawExpDoublesPlayerPanel` and `DrawExpDoublesPartnerPanel` ran, and **all 16 of
their bare operands resolved** to `wScreenAttrmap`/`wShadowTilemap` cells.

```
                    before   after
bare $dxxx operands    344     328
  unproven             316     300
```

The lever was writing the scoreboard rather than playing tennis: the block at
`$c8e0`-`$c8ec` is fully named, so a match collapses to a few rallies. What it
bought, in one match: a natural tiebreak, the SET POINT and MATCH POINT banners,
the win/lose result screen, the EXP calculation screen, and the doubles panels
with their skill-allocation confirm dialog.

### What the forcing writes actually do

The reusable part is which writes the engine honours, which it ignores, and
when:

| write | effect |
| --- | --- |
| sets / games / points (`$c8e0`-`$c8e5`) | always taken, shown at the next HUD refresh |
| games straight to 6/6 | **ignored** for the tiebreak — `wTiebreakerIndicator` stays 0, because the transition is only evaluated *at the moment a game concludes* |
| games 6/5, then let the trailing side win a point | works: the natural transition fires and the indicator goes to 1 |
| points forced mid-rally | takes, but the situational banner does not appear for *that* point — `EvaluatePointSituation` precomputes the banners once per point, ahead of the rally |
| the win/lose flags (`$c8e8`-`$c8eb`) | never written directly; leaving stale bytes from an earlier scenario produced one incoherent read (`matchflag $01` beside `pointflag $ff`), so zero the whole 13-byte block before each new setup |

### A warp into flagged content hangs, and why

The finding worth keeping. Warping straight into
`STORYLOC_JUNIOR_CLASS_COURT_DOUBLES` and triggering the challenge NPC plays the
dialogue correctly and then **soft-locks the walk-on cutscene forever** at
`script_wait_actor_script ACTOR_PLAYER`.

`LoadRankingOpponentGraphics` (`$11:$730a`) opens with
`test_flag FLAG_DOUBLES / jp nz, LoadDoublesRankingOpponentGraphics`, and the
flag is normally latched by story progression a debug warp skips. With it clear
the shared routine takes the *singles* branch while the surrounding script
positions actors for doubles, and the actor script waits on a condition that
never resolves. Setting game-flag `$2f` (`$c9c5` bit 0) first fixes it —
A/B tested, hangs twice without and plays twice with.

Generalise it: **a raw warp lands in content whose flags were never set**, so
check what the destination's shared loaders branch on before blaming the warp.

### The ranking board is gated on the mode, not on the match

A correction to the plan I gave. The brief assumed finishing any story ranking
match would reach `ShowRankingBoard`; it does not.
`ShowIslandOpenRankingBoard` (`$1e:$6fb2`) is

```
        ld a, [wGameMode]
        cp GAMEMODE_ISLAND_OPEN
        ret nz
```

so a class-court ranking win runs straight through and returns. The bank `$0f`
callers are Island Open tournament-room code behind the same gate, and bank
`$10`'s unconditional callers live in `MatchSelectHandlerTable_10`, the
development test room, whose actors did not respond to interaction from the
Scene warp.

That leaves bank `$1b`'s cluster — still the largest — reachable only through
the Island Open (gated behind `FLAG_WON_ISLAND_OPEN_*_FINAL`), or by **forcing
`wGameMode` to `GAMEMODE_ISLAND_OPEN` at the moment a match result is
processed**, which the score-forcing technique now makes a reasonable next
experiment.

### Save status

The save was written: the EXP flow ends in an unconditional
`farcall SaveStorySlotWithTimer`, so the slot now records a won Junior Doubles
ranking match and the partner levelled 42 → 43. `FLAG_DOUBLES` was force-set by
`write_memory` rather than earned, and that fed into the save when the match
completed normally. Restorable from `maxed-unlocked.sav`.

## The ranking board was reached, and the capture was lost (2026-07-30)

The forcing recipe works. From a mid-EXP-screen checkpoint of a won doubles
match, writing `wGameMode` = `$02`, `wCurrentMinigameStoryMatch` = a Doubles
Island Open index, `wMatchWinLoseFlag` = `$01`, and a partner name of six or
more characters, then letting the flow run, reaches `ShowIslandOpenRankingBoard`
and through it `ShowRankingBoard` — confirmed by `get_registers` showing
`ROMX BANK` = 27 (`$1b`) with `wGameMode` still `$02`, i.e. genuinely inside the
farcall.

**No coverage survived.** The session traced ~700 frames through the board's
setup and marker animation in ≤8-frame chunks, never dumping, and the connector
dropped on the call before the first `dump_coverage`. Buckets are unchanged at
328 total / 300 unproven.

### Two lessons, one of them new

**The connector does not only die on resets.** No reset was crossed here and
every step was ≤8 frames, yet it dropped with the same signature (listener with
a pending connection and a zero backlog, BizHawk alive). *(Corrected the next
day: the likelier cause is not the tracing but the debug features the session
was using — see "The crashes were the debug features" below.)* So the rule needs a second half: **dump coverage
incrementally, every ~100 traced frames, to numbered files.** A drop then costs
one segment instead of a session, which is exactly the difference between this
session yielding nothing and yielding most of the board.

**The EXP screen has a UI trap that eats sessions.** `RunExpDistributionLoop`
(`$1d`) shows a "Continue? YES/NO" prompt whenever a character's EXP pool
empties, and its cursor **defaults to NO** (`wExpPromptCursorRow` is set to `$01`
immediately before the loop). Tapping A confirms NO, which loops back into
allocation, immediately fails again because the pool is still empty, and reopens
the same prompt — forever. One **Down** tap before A is the whole fix.

### The parameter map, which is the reusable output

Read out of `SetupRankingBoardArgs` and `DispatchRankingBoardAnim`, this says
which runs are needed to cover the family rather than discovering it by replay:

* **Doubles** (`wCurrentMinigameStoryMatch` high byte `$01`), low byte
  `$11`/`$12`/`$13` → player row 1/2/3 → anim states `5387`/`53fa`/`546d`.
  Rows **2 and 3 together cover all six `DrawDoublesRankingMarker*`**; row 1 is
  redundant. Pair each with win and loss (`wMatchWinLoseFlag` 1/2).
* **Singles** (high byte `$00`), low byte `$10`-`$13` → rows 1-4. Rows **1, 2
  and 3 cover all of `DrawRankingRow0` and `2`-`11`**; row 4 adds nothing.
* Only the *singles* anim states call `StartRankingMarkerAnim3`, so
  `UpdateScriptedOffsetChannel3` needs a singles run — a doubles-only session
  cannot reach it.
* The partner name must be **six characters or more** or
  `RenderNameTopRow`/`RenderNameBottomRow` never run; the save's "Alex" and
  "Harry" are too short.

Projected: two doubles runs plus three singles runs would cover **76 of the 113**
bank-`$1b` sites. That is a plan, not a result — none of it executed under a
surviving trace.

Two checkpoints survive in `drops/emu6/checkpoints/`: `pre_board_common.state`
(mid-EXP-screen with the forcing writes applied, reusable for any row/outcome by
rewriting two bytes) and `at_board_entry.state` (advanced to the confirmed
bank-`$1b` entry, saved *before* `trace_start`). The next attempt can load the
second and trace immediately, skipping everything that made this one expensive.

## tracelog2cov derives the WRAM bank now (2026-07-31)

The capture problem this week had a shape worth naming: the method that
survives a long session cannot produce the evidence the session is for. Lua
per-instruction hooks give `rom_wram_bank` masks but destabilise the emulator —
three connector losses in a day, the last of them with the game executing
almost entirely outside the ROM image (1,022 of 1,065 offsets out of range) and
the resulting dump *reducing* resolutions by 23, which is what a crashed CPU's
arbitrary bank readings do. BizHawk's native Trace Logger is stable but logged
no bank at all.

It can, though, because the game switches banks with a fixed idiom whose
immediate is in the logged opcode bytes:

```
        ld a, N            ; 3e NN
        ldh [hWramBank], a ; e0 96
        ldh [rWBK], a      ; e0 70
```

So a write to `rWBK` two instructions after an `ld a, imm` names the new bank
outright, with no register state needed. `tools/tracelog2cov.py` now tracks that
and emits `rom_wram_bank` parallel to `rom`.

**It refuses to guess.** Any other route to that write — `A` from a `pop`, from
memory, from the shadow byte — sets the bank to *unknown*, and instructions
executed while it is unknown get a zero mask, which `load_traced_wram_banks`
skips. A missing mask costs nothing; a wrong one silently corrupts every name
derived from it, which is precisely the failure that made today's last dump
unusable.

Verified on synthetic logs built from **real ROM bytes**, since the converter
byte-matches against the image and invented instructions are rejected outright
(the first attempt at a negative test failed for exactly that reason):

* Bank `$0a`'s `wram_bank $05` at `$6474`: the two instructions before the write
  are unknown, and from the write onward the mask is bank 5 — which
  independently matches `wSceneTileAnimBuffer`/`wSceneTileAnimBufferPtr` at
  `$647a`/`$647d`, named by hand from the other direction earlier.
* Bank `$02`'s save/restore at `$4119`-`$4127`, a real sequence:
  `ldh a, [hWramBank]` / `push af` / `ld a, $06` / … / `ldh [rWBK], a` sets bank
  6, and after the matching `pop af` / `ldh [rWBK], a` the mask correctly goes
  back to **unknown** rather than carrying 6 forward.

A possible extension, deliberately not taken: modelling the `hWramBank` shadow
byte would let the restore sites resolve too, since `ldh a, [hWramBank]` reads a
value the log has seen written. It is left out because the model would only be
sound if every write to that byte goes through the same idiom, and being wrong
there reintroduces exactly the hazard this conservatism avoids.

## The crashes were the debug features, not the tracing (2026-07-31)

I attributed three connector losses to per-instruction Lua hooks destabilising
the emulator. That is probably wrong, and the better explanation was already
sitting in this document: **every one of those sessions was driving the game
through dead code that the shipped build never executes, and forcing engine
states its normal flow never produces.**

Two mechanisms are already proven here, and neither needs tracing to explain a
crash:

* **Warping lands in content whose progression flags were never set.** Proven
  directly: a Scene warp into `STORYLOC_JUNIOR_CLASS_COURT_DOUBLES` soft-locks
  the walk-on cutscene forever, because `LoadRankingOpponentGraphics` branches
  on `FLAG_DOUBLES` and takes the singles path while the script positions actors
  for doubles. One flag was enough to fix that one; nothing says the other warps
  are clean, and a hang is the *visible* end of that spectrum.
* **The scene viewer reads past its table.** `LoadSceneGraphicsDirect` indexes
  the 37-record, 16-byte-stride `SceneGfxSlotTable` with a stride of **18** — a
  defect recorded in `docs/bugs.md` this week. It is reached only from
  `LoadAndDisplayScene`, whose callers are all the debug scene viewer. Feeding
  arbitrary words to a graphics loader as pointers, and decompressing from
  wherever they point, is a mechanism for exactly the kind of corruption
  observed: a dump in which 1,022 of 1,065 executed offsets were outside the
  ROM image.

The debug harness in this game is *unreachable in the retail build* — the
dispatcher at `$01:$40ec`, the in-game menu behind `hDebugStepMode`, the scene
viewer. Unreachable means never exercised in the shipped configuration, so its
bugs survived shipping. We have been using it as if it were a supported
interface. The scene viewer's stride bug is the proof that at least one of its
paths is actively unsafe.

**What this changes.** "Do not trace across a reset" stands — that one is
mechanically clear, since the reset does an enormous amount of work under hooks.
But "long traced sessions kill the connector" is no longer supported by the
evidence: the run that produced it had been through a debug warp, a forced
`wGameMode`, a forced match index, a forced win flag and a patched partner name
before a single frame was traced. The dump's own numbers say the machine was
already unwell.

The practical rules that follow are different from the ones I wrote yesterday:

* Treat a crash after debug-menu use as **the game's fault, not the tool's**,
  and check the emulator state before blaming the capture path.
* **Incremental dumping is still right**, but for a better reason than tool
  fragility: it bounds the loss when the *game* dies, which is now the expected
  failure.
* Prefer reaching a screen through the paths the retail build actually uses,
  even when they are slower. Forced state is a last resort, and every forced
  value is a hypothesis about what the engine can tolerate.
* A dump whose out-of-range fraction is far above the usual 0-19% is evidence
  the run was unsound. Check it before merging — and check whether the regen's
  "resolved that the dataflow could not" count *falls*, which is what
  contradictory bank masks look like.

## The native trace logs were re-convertible, and they carry registers (2026-07-31)

Two assumptions turned out to be wrong, both in the useful direction.

**The original trace logs still exist** — 42 of them, 6.2 GB, in BizHawk's
`Tools/` directory. The coverage JSONs converted from them are in the repo; the
logs themselves were never deleted, so every past capture is re-convertible with
no emulator involvement at all.

**And the logs carry the register file.** Their header says so:
`PC, opcode, registers (A, F, B, C, D, E, H, L, LY, SP, CY)`. That makes the
`ld a, imm` look-back heuristic added an hour earlier unnecessary — the `A` on a
`ldh [rWBK], a` line *is* the byte that write stores, so the bank can be read
directly, covering every form including the `pop af` restores the idiom cannot
see. The heuristic stays as the fallback for logs configured without those
columns; the converter reports which source it used.

On a real 158 MB log: 1,483,724 instructions parsed, **2,869 rWBK writes all
resolved from the logged A, none unresolved, WRAM bank known at 5,015 of 5,015
offsets — 100%**. That is also the end-to-end validation against a real log that
the synthetic tests could not give.

### What re-converting all 42 actually bought

```
                                    before    after
sites with an observed WRAM bank    69,841   71,201
resolved that the dataflow could not 19,404   19,448
bare $dxxx operands                    328      327
```

**One operand.** Worth stating plainly, because the headline number promised
more: 14,581 of the 78,699 covered offsets had no mask, and the re-conversion
filled only 1,358 of them. The rest belong to logs that no longer exist, or sit
at offsets the *fixed* converter no longer produces — the pre-fix version
mis-attributed banks (the bug behind the eight phantom seeds), so its output and
the current output are not the same set. Those 13,223 offsets cannot be given
masks without their source logs.

The lasting value is not the single operand: 32,027 offsets now carry
authoritative bank evidence permanently, 44 more sites have a trace-resolved
bank than before, and the count of sites where the trace *contradicts* the
dataflow fell from 1,843 to 1,796 — the new masks agree with the analysis more
often than the old evidence did.

### Why this matters more than its yield

It changes what a future capture costs. A native-logger session runs at full
speed with no per-instruction Lua hooks, through **ordinary gameplay** — no
debug menu, no warps, no forced state — and now still produces the WRAM-bank
evidence that was the whole point of driving. Given that the debug harness is
the likely cause of this week's crashes, a capture path that does not need it is
worth more than the operands it happened to resolve today.

## A fresh native capture, and what ordinary gameplay is worth (2026-07-31)

61 new trace logs, captured in a five-minute window and converted with the
register-reading derivation: **every one at 100% mask coverage**, 28,834
distinct offsets across **32 banks** — a much broader spread than the previous
set, which was concentrated in a handful.

```
                                    before    after
sites with an observed WRAM bank    71,201   71,938
resolved that the dataflow could not 19,448   19,508
bare $dxxx operands                    327      325
```

Two operands resolved, both `wActors` cells in the story banks
(`$12:$653d`, `$13:$536d`). Zero new instructions, and the rejected-seed count
stayed at zero — the fixed converter is not producing phantoms.

Worth recording precisely, because it calibrates what this capture path yields:
599 offsets were entirely new to the coverage set, yet **none of them was new
code** — they were already-proven instructions that no previous trace had
executed. And only 138 of the 13,223 still-maskless offsets were covered, so
that backlog is essentially permanent: those offsets belong to logs that were
overwritten (BizHawk reuses the auto-split names, and this capture overwrote the
42 originals) or sit at attributions the pre-fix converter produced and the
current one does not.

### The honest conclusion about driving

An ordinary-gameplay session now costs nothing risky — no debug menu, no warps,
no forced state, no per-instruction hooks, and it produces full bank evidence —
but it yields **one or two operands**. The remaining 297 unproven sites are not
waiting on a better capture path; they are waiting on *specific screens* that
ordinary play does not visit: the save editor, the Island Open ranking board,
the link-cable flows, the trophy screens' deeper paths.

So the bottleneck has moved. It used to be "we cannot capture bank evidence
safely"; that is solved. It is now "the screens that remain need either a long
legitimate playthrough or the debug harness, and the debug harness is what
breaks the game". Of those two, the playthrough is the one that does not
corrupt anything — and with the Trace Logger it can now run at full speed for as
long as someone is willing to play.

## Ordinary gameplay has saturated (2026-07-31)

A third native capture: 27 logs, 29,317 offsets across 29 banks, **100% mask
coverage** again, and this one exercised the character-data and EXP screens
heavily (`$1c` 2,559 offsets, `$1d` 1,658, `$1e` 1,287).

```
                                    before    after
sites with an observed WRAM bank    71,938   72,475
bare $dxxx operands                    325      324
```

**One operand** — another `wActors` cell. Three consecutive captures have now
returned 2, 2 and 1. That is saturation, and the `$1c` result shows why: the
session covered 2,559 offsets in that bank and its unproven count did not move
from 12, because the routines holding bare operands were not among the paths
taken. Coverage of a *bank* is not coverage of the *routines that need it*.

Where the remaining 296 sit:

| bank | sites | what stands between us and them |
| --- | ---: | --- |
| `$1b` | 113 | the Island Open ranking board; 5 are provably unreachable |
| `$03` | 37 | **18 are provably unreachable** (the superseded save-repair family) |
| `$05` | 22 | text paths ordinary dialogue does not take |
| `$3b` | 16 | deeper trophy/N64 screens |
| `$1c` | 12 | `SetupCharDataScreen`, not on the visited paths |
| rest | ~96 | one or two per routine, spread thin |

Subtracting the 29 sites proven to be in code that cannot execute leaves ~267
genuinely reachable, and the largest single block of those needs one specific
thing: **a legitimate Island Open run**, which would take a real bite out of the
113 in bank `$1b` without any forced state.

The tooling side is finished. Three captures, 130 logs, every one converted at
100% mask coverage with zero rejected seeds and zero new instructions. What
remains is not a capture problem — it is that the unvisited screens are
unvisited, and the cheapest honest way to reach the biggest cluster is to play
the tournament with the Trace Logger running.

## The immediates, second pass: eight id spaces and a check that can see them (2026-07-31)

Driving has saturated, so this pass went at the *other* unnamed thing: the bare
`$xx` immediates. A scan of every `ld a, $xx` / `ld [wVar], a` pair and every
`ld a, [wVar]` / `cp $xx` pair in `src/` ranks the WRAM variables by how many of
their sites are still bare hex, which is a direct work-list. Five of the top
candidates were researched to a verdict; **460 sites are now named** (638 →
1,098 curated entries, 398 → 459 defs), byte-perfect throughout.

| family | defs | sites | what it is |
| --- | ---: | ---: | --- |
| `STORYRANK_*` | 10 | 102 | `2 * tier + isDoubles` over the ranking ladder |
| `POINTOUTCOME_*` (7-9, `$0b`) | 4 | 75 | the codes above the six already named |
| `WINLOSE_*` | 3 | 56 | one tri-state sign shared by two flags |
| `MATCHABORT_*` | 4 | 67 | two independent bits, not a code |
| `ISLANDOPENSTAGE_*` | 7 | 35 | Center Court's bracket position |
| `SENIORCOURTSTAGE_*` | 15 | 33 | fifteen values, `$02`-`$08` pinned by a jumptable |
| `STORYENTRY_NONE` | 1 | 32 | the one engine-wide value of a per-location space |
| `CHARSELECTMODE_*` | 6 | 28 | exhibition/link × singles/doubles × side |
| `ISLANDOPENROUND_*` | 4 | 13 | the tournament site's copy of the bracket |
| `STORYSLOT_NONE`, `NUM_STORY_SLOTS` | 2 | 13 | one value, two roles |
| `STORYTIER_*` | 5 | 6 | `STORYRANK >> 1`, format-independent |

### Three of the five candidates were not id spaces, and that is the result

The site rule this project uses — tag only the immediate that feeds the store,
the `cp` reachable from the load, or the table row whose consumer indexes by it
— is a filter, and it is supposed to reject things:

* **`wStoryModeEntryPoint`** (201 bare sites, the biggest single candidate) is
  *location-scoped*. `LoadStoryEntryPointRecord` (`$0a:$516f`) linearly searches
  the loading location's own `map_entry` table and falls back to its first
  record, so `$0f` is one door at the Senior Class Court and a different one at
  the Junior. 42 tables, 126 records, ids `$01`-`$0f`, and the same value means
  different things in each — `EraseSavedDataFlowHandler4_10` resolves one
  "return from a story match" event to five different `(location, entry)` pairs.
  Only `$ff` is engine-wide.
* **`wMenuSlideDirection`** (66 sites) is a boolean: every consumer opens
  `ld a, b / or a / jr z`, and no third value exists in any bank.
* **`wDrillLessonResult`** (45 sites) is nine *per-drill* critique codes that
  bank `$15`'s per-coach jump tables interpret; `$03` is "missed targets" in one
  drill and a fall-through in another. The one cross-drill invariant (`$00` =
  perfect) is written only by `xor a`, so it has no immediate to tag anyway.
* **`wUnusedExitLocationMirror`** (161 sites) is not location ids either — see
  below — and **`wMinigameLevel`** is an ordinal the consumers do arithmetic on
  (`+$12`, `id*3+level`), not a symbolic set.

### The exit request was named after the wrong column

`wStoryModeExitLocationRequest` holds an exit-*trigger* id. `RunLocationExit`
(`$0a:$560b`) passes it in `d` to `FindStoryScriptEntry`, which matches it
against the **id** column of the location's `ExitTriggers` table; the
destination `STORYLOC_*` is that row's `arg0`, a different column. So `$01`
leaves the Training Gym for the Courtyard and leaves somewhere else for
somewhere else. Renamed to `wStoryModeExitTriggerRequest`, and its write-only
mirror at `$c294` to `wUnusedExitTriggerIdMirror`. (That mirror is genuinely
dead: all 204 references are stores, and `RunLocationExit`'s first instruction
writes a *second* dead mirror at `$c2db`.)

`wLastShotServeRole`'s note was wrong in the same way: role 1 is the receiver,
not the server, and the outcome it selects is `POINTOUTCOME_SERVE_VOLLEYED`
("Return the serve after it bounces"), not a fault.

### The Island Open tables were named for the round just won

`LoadIslandOpenRoundNpcs` (`$0f:$6651`) swaps the tournament site's actor and
script lists as bracket flags come in, and the lists were numbered by the flag
that selects them. The dialogue says otherwise: the list loaded once
`FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1` is set contains *"You play Spike in the
second round"*, *"You did great in Round One"* and *"Round Two is next!"*; the
next one says semi-finals, and the one after that says finals. Fourteen labels
renamed to the match their NPCs are talking about (`IslandOpenRound1Actors_0f`
→ `IslandOpenRound2Actors_0f`, `Round2` → `Semifinal`, `Round3` → `Final`, and
the same shift on the doubles side, where the *first* list really is round 1
because doubles has no second round). The `ISLANDOPENSTAGE_*` /
`ISLANDOPENROUND_*` constants now say the same thing as the labels.

### `make check` can see a mis-keyed constant now

`constants.json` is keyed by the flat ROM offset of the instruction
(`bank * 0x4000 + cpu - 0x4000`), and getting that wrong has no symptom: the
entry addresses a byte inside some other instruction, renders nothing, and the
build still matches the ROM. The new `constants` check decodes every entry's
offset, requires it to be an emitted instruction *boundary* with a
named-immediate operand, and compares the operand against the `constants.inc`
value. Seeded faults — an off-by-one key, a key inside a data blob, a real
instruction holding a different value, an undefined name — are all caught; the
first version of the check caught only one of them, because a `break` in the
data-region loop skipped the instruction test for every offset below the first
blob. All 1,098 entries verify.

### Fourteen routines were inside an actor script's label scope

Scanning for global labels whose body mixes `as_*` bytecode with CPU
instructions found fourteen. A routine emitted right after an actor-script blob,
with nothing naming its entry, lands inside that script's scope, so its
`.loop`/`.done` belong to the script's symbol.

Six are named: four are byte-identical copies of `ComputeRankingProgressIndex`
(the same 78 bytes appear in eight banks; `$0f`/`$13`/`$14`/`$15` had no label),
and two are the Junior Class Court's post-match returns, which share their
prologue with `SeniorCourtPostMatchReturn` and the two Island Open ones — the
doubles variant being the one that positions `ACTOR_PARTNER`. The remaining
eight are pinned in a new `scopes` check, so a curation change that strands
something new fails instead of passing quietly:

| where | what it looks like |
| --- | --- |
| `$0e:$4c37` | reads an actor's state block into `wMapScratch` |
| `$0f:$7b7f` | three one-line handlers (clear `wStoryScriptRan`, play `$a2`, clear the location-name flag) |
| `$12:$6d8a` | sets location = Senior Class Court, entry `$0d` |
| `$14:$4813` | reads a minigame record, then sets location = Tennis Machine Room |
| `$15:$66ef`, `$15:$6b8e` | the `script_speak` tail of a lesson scene |
| `$27:$48f0`, `$27:$760e` | ending-cutscene bodies |

### Where the naming stands

**20,135 of 21,715 labels are human-named**; the remaining 1,580 are still all
generator-derived. 459 constant defs cover 1,098 sites plus the value-keyed
sound ids. The next passes with a clear work-list are the eight stranded
routines above, and the next tier of the bare-immediate scan (`wCharDataPage`,
`wDialogueWindowId`, `wPauseMenuId`, `wSndChannelType`, `wCutsceneObjPhase` —
tens of sites each, not hundreds).

## The stranded routines are all named, and four more id spaces (2026-07-31)

Second half of the same day's work: the eight routines the new `scopes` check
had pinned are now named, so `KNOWN_STRANDED_IN_SCRIPT` is **empty** and that
check has turned into a ratchet — a curation change that strands something new
fails, and there is no backlog behind it. Fifty more curated immediates landed
alongside (1,098 → 1,148 sites, 459 → 470 defs), byte-perfect throughout.

### What the eight turned out to be

| where | name | how it is reached |
| --- | --- | --- |
| `$0e:$4c37` | `TrainingGymRunner0AWaitWaypointClear` | 48 `as_call`s from the gym jogger's own actor script |
| `$0f:$7b7f`+ | `MapScriptNopAlt_0f`, `MapScriptClearActiveFlag_0f`, `MapScriptPlaySoundA2_0f`, `MapScriptHideLocationName_0f` | nothing — the per-bank library tail, replicated |
| `$12:$6d8a` | `SeniorCourtReloadIntoVictoryScene` | `SeniorCourtInitScript_12`'s `cp $0e / jp z` |
| `$14:$4813` | `UnusedMachineRecordOverrideAndReturn_14` | nothing |
| `$15:$66ef` | `SpeakServeCoachDeclineLine` | the `jr nz` of six lesson scenes |
| `$15:$6b8e` | `SpeakStrokeChallengerDeclineLine` | the `jr nz` of six challenge scenes |
| `$27:$48f0` | `SetEnd16BeforeFinalsDoublesWalkScripts_27` | one `jr nz` — a branch arm of the routine above it |
| `$27:$760e` | `End1MainBldgGroupDepartureCutscene_27` | `End1MainBldgInitScript_27`'s `jp z` on entry point `$02` |

Three things are worth keeping from that table. The bank `$0f` case is **four**
entry points, not one, and it identifies itself: banks `$0e`, `$10`, `$14` and
`$27` already carry exactly those four names in the same order, so it is the
same library tail copied per bank — which is also why nothing references it.
The two bank `$27` entries are not routines at all but **branch arms** of the
routine above them, separated from their owner by the actor-script blob the
assembler emitted in between; a local label cannot reach across a global, so a
global label is the only fix the source can express. And
`UnusedMachineRecordOverrideAndReturn_14` reads tennis-machine record `$01`,
discards it for a constant `$0050`, and never calls `UpdateMinigameRecord`, so
even if something did call it the value would not persist — the reasoning is in
its `labels.json` note rather than in the name.

### The four id spaces

| family | defs | sites | the finding |
| --- | ---: | ---: | --- |
| `SNDCHANTYPE_*` | 4 | 18 | the type *is* the hardware channel |
| `MATCHMENUSEL_CANCELLED` | 1 | 17 | the byte is a row, not an item id |
| `ACADEMYWINGSTAGE_*` | 4 | 11 | a fourth ladder in `wMapSceneStage` |
| `TILEATTR_PRIORITY`/`_PAL1` | 2 | 4 | a CGB attribute byte |

`wSndChannelType` decodes cleanly because `wSndRegBase` is computed as
`type * 5` one instruction later, which is the stride of the Game Boy's four
sound-register blocks (`$ff10`/`$ff15`/`$ff1a`/`$ff1f`). Every site that tests
it is doing something only that channel needs: loading wave RAM and poking
`rAUD3ENA` for the wave channel (which also skips duty, volume slide and
instrument envelope, having no envelope generator), and routing the note through
`NoiseNoteTable` for noise (which has no period, so vibrato returns early).
Square 1 is pinned separately by the `and a`-gated write to NR10, the sweep
register only it has; square 2 has no site of its own and is declared to close
the space.

**`wMatchMenuSelection` is the trap this pass was most at risk of.** It looks
like the existing `MATCHMENUITEM_*` space and it is not: `GetMatchMenuItemId`
(`$06:$480a`) reads `MatchMenuDefs + wPauseMenuId * 8 + row` — the variable is
the *row*, the constant family is what the lookup *returns*, and the two sit on
opposite sides of it. The same byte is also the story pause menu's row and the
debug stats screen's cursor. Only `$ff`, written by every B-pressed branch, is
engine-wide.

`ACADEMYWINGSTAGE_*` is a fourth family in `wMapSceneStage`, after
`STORYRANK_*`, `STORYTIER_*` and `SENIORCOURTSTAGE_*`:
`SetAcademyWingDialogueStage_10` is the region's only writer and walks both
ladders to the *same* four values, starting at the senior title rather than the
junior one — which is exactly what makes it neither of the two spaces it
resembles.

### Three variables that should stay bare

`wShadowTilemapBank` holds literal WRAM bank ids (`$02`/`$03`/`$05`) that go
straight to the `wram_bank` macro, which already renders a bank as a number —
naming them would make one number look like two different things.
`wDrillIsPracticeLesson` is a boolean whose four readers all use `and a`.
`wCutsceneObjPhase` is reused by four bank-`$14` animations for two unrelated
purposes: a sprite tile-base offset advanced by `add $04`, and a plain 0-3
sequencer counter.

### The Tournament Site tables had the Island Open bug

`TournamentSiteScripts1_15` through `6` were numbered by the flag that selects
them, like the bank `$0f` tables fixed earlier the same day. The dialogue
settles it the same way: the table loaded once `ROUND_1` is won contains
*"Everyone from Union lost in the first round…"*, and the next one *"Three
Academy members and A. Costello have made the semi-finals!"*. Renamed to
`TournamentSiteRound2Scripts_15` / `…Semifinal…` / `…Final…` and the three
doubles siblings, so each label now says what the `ISLANDOPENSTAGE_*` constant
stored beside it says.

### One more shipped defect

`TrainingCourtInitScript_15` (`$15:$532e`) normalises its stage byte with
`cp $05 / jr c, .fromLesson` and then `sub $06` — but
`ComputeTrainingCourtProgressIndex`, called on the instruction before, maxes out
at `$04` on both ladders. The branch is always taken and the subtraction can
never run. It is the shape of a second id space that used to live in the same
byte (`$06 + n`), and the compute call would now overwrite it anyway.
Written up in `docs/bugs.md`.

### Where the naming stands

**20,141 of 21,721 labels are human-named**; the 1,580 generator-derived names
are unchanged. 470 constant defs cover 1,148 sites plus the value-keyed sound
ids. What is left on the bare-immediate work-list is mostly *proven* not to be
nameable — `wStoryModeEntryPoint`'s 171 location-scoped sites,
`wUnusedExitTriggerIdMirror`'s 161 dead trigger ids, `wMenuSlideDirection`'s
boolean, `wDrillLessonResult`'s per-drill codes, and the `wBriefing*` screen
coordinates — so the pass has reached the point where the remaining bare hex is
bare for a reason.

## Scanning for unknown blobs: the streams were glued to what followed them (2026-07-31)

A blob-by-blob audit, on the theory that "every blob is classified" is a claim
about *labels* and not about *bytes*. Three scans, and the second one found a
systemic defect.

**Scan 1 — does every blob have a name?** Yes: of 4,636 `INCBIN`s, exactly one
did not start at a label (13 bytes of RST-vector padding under `Rst08`), and
the only vaguely-named ones were three, now identified (below). So the label
side of the claim held.

**Scan 2 — does each blob's content match what its name says?** For compressed
data this is decidable, and it is where the claim broke. A blob holding an LZ
stream was carved to the *next reference*, not to the end of the stream, so
anything sitting between the two was silently glued onto it — and because the
blob was then not named `lz_`, `make check` never decoded it, so nothing could
notice. `tools/disasmlib/carve.py` now backtracks from every
`call DecompressData` to the `ld hl, imm` that set the source and decodes it:
**173 streams sized from their own call sites, 786 → 790 machine-verified where
619 were before.** Six are demoted again by a validation pass because a later
carve puts a boundary inside them — believe the boundary, drop the claim.

What the splits exposed, every byte of it previously part of some other symbol:

| where | what it is |
| --- | --- |
| `$6b:$7561` | an 8-byte routine: `ld a, [wCutsceneStepTimer] / inc a / ld [..], a / ret` |
| `$18:$57f4` | a 14-sprite `QueueSpriteTemplate` strip, `$80` terminator and all |
| `$1c` ×5 | one page-column tilemap per character-data page |
| `$28:$6d14` | eight bytes that read as one 4-colour palette, next to the palette block |
| ×3 | runs of `$00` alignment padding, now `ds` instead of extracted ROM bytes |

The bank `$1c` five are what prove the mechanism rather than merely suggesting
it: each begins at *exactly* the byte after its stream's last, and
`CharDataScreen_DrawPageColumnsTable1` — a 10-byte opaque blob until now — is
the `dw` table that points at all five. It is declared `records:2` now, along
with three more pointer tables that were sitting as `INCBIN`s (two stat-bar
tables and the char-data flush-chunk table, whose structured siblings sat
directly above them in the same file) and `CharSelectCursorTemplatePtrs`, whose
four targets turn out to be one corner sprite drawn four times with the flip
bits — the whole selection box is 4 records and a terminator.

**Scan 3 — the names that admitted they were guesses.** `PortraitGfxUnknown_16`
and `MugshotGfxUnknown_1b` are the *same* 126-byte stream, and rendering it
answers the question: a framed question mark, the placeholder every roster id
without art of its own points at. `CharSelectMiscGfx` decompresses to ten tiles
of Japanese label glyphs, reading as court-surface stats (ball pace, bounce) —
what the court-select screen shows in English. It is record 10 of
`TileBlockPtrs_39`, no call site passes that record number, and it now sits
with the other unused JP tiles as `UnusedJpCourtStatLabelTiles_18`.

### What the scans say is left

Sixty blobs decode cleanly as whole LZ streams but are reached through pointer
tables rather than an `ld hl, imm`, so the call-site pass cannot see them and
their extents are fixed at emit time rather than in the carve. They are already
correctly named and sized — `MatchMenuItemGfx_*`, the scoreboard word art —
and what they would gain is automated verification, not structure. Promoting
them wants the emitter's boundary calculation, not another heuristic.

Two invariants worth stating now that the sweep is done: no blob's content
contradicts its name that any content-shape test can detect, and every declared
LZ stream in the ROM decodes exactly within its extent.

### The sixty, promoted (2026-07-31)

The follow-up above is done, and the reason it needed the emitter rather than
another carve heuristic is worth stating: those blobs have **no extent until the
run scan gives them one**. They are pointer targets with curated labels but no
`data_blobs` entry, so at carve time there is nothing to test a decode against;
`_data_run_end` fixes their end, and only then is there a span to check.

So the test lives in `_emit_data_run` and `_emit_raw_segment` now, as
`_decodes_exactly(start, end)`: one LZ stream, ending on the run's last byte,
expanding by at least a fifth, at least 32 bytes long. **46 more streams
declared, 836 verified in total** — up from 619 before today. A fresh sweep for
blobs that decode exactly but are not declared returns **zero**.

What promoted is exactly the class the scan predicted: the match pause-menu word
art (17 items), the scoreboard mode word art (15), the story pause-menu items
(8), four Varsity Court cutscene streams that were already *named* `Lz` by hand,
a court diagram and the tennis dictionary's alternate list data — which expands
7× into a tilemap, so the "ListData" in its name is a screen, not a table.

The exact-end rule is what makes this safe to run over every blob in the ROM:
the codec would have to run out of input precisely where a boundary derived from
an unrelated reference falls. A run that merely *starts* with a decodable prefix
is the glued-stream case, and where to split it is evidence the carve has and
the emitter does not.

## The second-tier immediates, and the seeds the labels forgot (2026-08-06)

Two passes, one planned and one found along the way.

### The bare-immediate scan, third tier

The ranked scan was rebuilt and the next eight candidates researched to a
verdict, four by parallel agents. Two new id spaces came out of
`wMapSceneStage`, both twins of a shape already named: the **Wall Practice
Room** and **Tennis Machine Room** walk their `FLAG_CLEARED_*` flags to the
same next-challenge ladder the Senior Court uses, so `WALLPRACTICESTAGE_*` /
`MACHINECOURTSTAGE_*` (7 defs each) name what the signs on the wall show.
`wDialogueWindowId` gets the one name it can carry — the real values are
window-struct indices handed out by `CreateWindowFromScreenRect`, so only
`DIALOGUEWIN_NONE` is literal (11 sites). Ten more sites of `STORYTIER_*` /
`ISLANDOPENROUND_*` were hiding behind `sra`-at-the-reader — the Training Gym
and Academy main building shift the rank at each compare instead of storing
the tier — which also closes `STORYTIER_SENIOR_CHAMP`'s "no compare site"
note. Three `cp $03` bound tests joined `NUM_STORY_SLOTS`, and
`wStoryMenuFirstItem`'s five stores turned out to hold `STORYMENUITEM_*` ids.
**1,148 → 1,200 curated sites, 470 → 485 defs.**

Proven bare and left that way, which is the result as much as the defs are:
`wPauseMenuId` is the pause-menu *page* index but mode-scoped — the identical
value indexes `MatchMenuDefs` (15 rows) or `StoryMenuDefs` (6 rows) depending
on which `Run*Menu` runs next, with $00-$05 live in both, so $02 is
camera/music options in a match and messages/music options in story mode.
`wMatchSimFrozen` writes $ff and $01 interchangeably and every reader is
`and a` — a boolean with two spellings, not a tri-state.
`wCharGridHandedness` is 0/1/2 (right/left/unchosen) but is toggled with
`xor $01` and its destination byte (+$0e of the match records) doubles as the
OAM mirror flag, so a `HAND_*` name would lie at those writers. The char-grid
page, slot and data-page bytes are ordinals their consumers do arithmetic on
($04 in `wCharSelectSlot` being a *pseudo-slot* injected from the mode's
slot-ring data, not a count). And the bank $13/$14 cutscene uses of the
scene-stage pair are world pixel coordinates — `GetSceneObjectScreenPos_14`
subtracts the scroll registers from them.

### Four dead launchers in the story-menu code

The `wStoryMenuFirstItem` chase exposed four unreachable fragments sitting
unlabeled between their live siblings in bank $06 — code after a `ret` with no
label and no reference, each a menu launcher that was written and never wired:
`UnusedStoryMenuRedrawReentry`, `UnusedRunStoryPlayerDataMenu`,
`UnusedRunMessagesMusicMenu` and `UnusedRunSaveQuitMenu` (the last three are
one-instruction variants of `RunMessageSpeedMenu` / `RunMusicOnOffMenu` that
nothing calls).

### The seeds the labels forgot

Those fragments generalised. Every hand-authored static seed in
`coverage/*static*.json` asserts "code starts here", but a seed only *decodes*
an offset — nothing ever demanded it get a label, and `progress.py` counts
labels, so an entry point with no label at all was invisible to every naming
metric. A sweep found **361 seed offsets with no symbol, 290 of them at a flow
boundary** (directly after a `ret`/`jp`/`jr` — function-start shaped).

The biggest coherent family is named: the ball-trajectory twin banks
$20-$24/$29-$2c each carry the same six shot-solver helpers, but each bank
only ever got labels for the ones its own tail entry exercises, so the
routine that is `SetBallTargetByPrediction_29` in one bank was an unlabeled
instruction run in eight others. **42 labels added**, every one verified
instruction-for-instruction against its labeled sibling
(`SetBallTargetByPrediction`, `ApplyBallTrajectory6`/`6Capped`/`Capped`/`4`/
`4Capped`, `LookupBallPosByAim`, `LookupBallPosByShotIndex_2c`).

### What is left on this list

~248 flow-boundary seed offsets in the other banks. They are not uniform:
some are dead bodies under an existing label (bank $0b's disabled
`ServiceMatch*Judge*` handlers — `Label: ret` with the original body still
behind it, already in `docs/bugs.md`), some are unreachable routines wanting
an `Unused*` label (the bank $10 run of eleven consecutive `ret` stubs and a
dead exit-request setter at $4da6), and some are live computed-dispatch
entries whose dispatcher names them (the court banks were this kind). Each
needs that three-way classification before a name is right, which is why they
were not batch-named here.

## The 247 unlabeled seeds, classified to zero (2026-08-06)

The work-list from the morning's sweep is done: nine parallel agents took the
flow-boundary seed offsets bank by bank, and every one now has a verdict. The
split: **179 unreachable routines named** (`Unused_*`, `StubNop_*`, or their
byte-identical labeled twin's stem with this bank's suffix), **18
computed-dispatch entries named** (the map-script stub trio replicated into
banks `$10`-`$15`/`$27`, `AcademyTopicTopRanked`, and bank `$18`'s
`ObjectUpdateLoopTail_18`), and **46 dead bodies left deliberately unlabeled**
— each is the unreachable remainder of the labeled routine directly above it
(the 20 disabled drill judges `docs/bugs.md` inventories, orphaned error
epilogues in the save engine, branch arms sealed off by an earlier `jr`), and
a label would cut it off from the routine it belongs to. Re-running the sweep
now returns exactly those 46 plus one trampoline whose address is pushed
inline — the list is a stable remainder, not a backlog.

### Five seeds were sitting on data

The classification's real yield was the seeds that were wrong. Four decoded
tables as code: `$10:$6150` (five game-flag words the Restaurant NPC's
split-base read indexes — now `RestaurantNpc12StageFlagTable_10`, declared
`flag_ids`), `$0d:$57f5` (a `$01..$80` bit-mask table, unreferenced),
`$0d:$5866` (the per-hit-streak table whose decode had also swept the
*declared* `MinigameConfig_PerfectShot` record in as code), and `$13:$5928`
(the 7-entry `dw` table `RunAcademyQuestionsMenu` dispatches through — now
`AcademyTopicHandlerTable`, which also moved `AcademyTopicSinglesRank` to its
real entry at `$5936` and named the seventh handler). A fifth seed was off by
one byte: `$3b:$6978` is the last byte of the `bytes:2` table above it, and
the routine is `Unused_3b_SlideMenuPanel_1` at `$6979`.

### And one blob was hiding live code

Bank `$18`'s `d_7d88.bin` was three things fused: the `ObjectArrayBSpawnTable`
records (`records:11`, same shape as the A table beside it) and the two
per-object movement callbacks the spawn records carry at `+$09` —
`TaskUpdateObjects_18` dispatches into them by `jp hl`, and both end by
jumping to `ObjectUpdateLoopTail_18`, which is how the agent found them: the
`jp $7bba` bytes were sitting in the blob. Carving them surfaced their two
index tables (`ObjectArrayAWaveTable_18`, `ObjectArrayBDriftTable_18`) and a
shipped defect — callback B ends its animation-nibble update with
`ld [hl], d` where the A copy stores the combined value from `a`.

### What the orphans turned out to be

Whole abandoned features, not just fragments: a second debug drill-launcher
NPC family in bank `$10` (`Unused_10_Test2Npc04`-`0A` — the shipped table
rebinds their ids to plain dialogue), a water-sprite minigame launcher
(`Unused_10_RunWaterSpriteMinigame`, grass court, Mario vs Allie, its own
mode-hook table), a standalone character-select screen in bank `$1b`, the
singles half of the traveling-team victory pair in bank `$13`, both halves of
an abandoned per-player serve-target stat in bank `$0b` (writer at `$4f19`,
reader at `$4484`, nothing in between), a white-fade arming routine in ROM0
that `docs/bugs.md` had already described, and interrupt-enable / decimal-draw
/ signed-multiply helper families in ROM0 that nothing ever called.
`docs/bugs.md` gains the two new dead-value defects (`ProjectBallSprite`
discarding its table read; the callback-B register slip).

**20,405 of 21,985 labels are human-named**, auto is back to 0, and the seed
files now carry correction notes for every mis-seed the pass found.

## Every raw address operand followed to its consumer (2026-08-07)

Two sweeps over what still spells an address in hex, both generalising finds
from the seed pass.

### Split-base pairs: all fourteen resolved

A scan for raw `add $xx / adc $yy` pairs found fourteen. The resolver learned
what the real ones needed: a base a few bytes inside a labeled table renders
as `LOW(Name + n)` (`MatchMenuItemRectPointers + 2` is the second pointer
column; the story banks' partner walk-off routines bias into their
`WalkInFacings` tables), a pointer handed straight to a callee counts as a
dereference (the minigame hit-burst pair, `LoadIndexedPalette_18`), and a word
table indexed by a doubled byte has a `+$100` high half (`SquaresTable`). Bank
`$28`'s three effect-tile regions wanted labels instead — carved out of
`MatchGraphicsGfx` after their loaders (`SpecialHitEffectTiles_28`,
`BallTouchCharEffectTilesA/B_28`). A companion scan of blob bytes for
`jp`/`call` opcodes targeting labeled code (the pattern that exposed the bank
`$18` callbacks) returned only coincidences inside verified LZ streams — no
more code hides in blobs.

### The 87 raw pointer loads: 78 constants, 9 findings, 6 phantom labels

Every remaining `ld rr, $4xxx-$7xxx` was followed to its consumer by three
agents. The constants are overwhelmingly `QueueSprite` position pairs, several
proven by sibling branches whose values sit above `$8000` where no ROM pointer
can. Two immediates were pointers after all: `InitObjSlot`'s default slot
handler is `FinishObjSlotUpdate.done` (rendered via `IMM_CODE_POINTERS`), and
its template pointer reaches 107 bytes of `oam_sprite` records glued into
`ServeGfxPtrTable_09`, now `ObjSlotSpriteTemplate_09`.
`ShotBallPathServeTopspinTable` is really three concatenated word tables —
placement, speeds, and the 32-entry `wBallHeight` lookup, now labeled — and
the bracket blink task's zero-phase palette is
`BracketHighlightBlinkTaskPalettes0`.

**The teardown matters more than the labels.** `StatChangeArrows0`-`5` never
existed: the six "labels" were X=`$64` sprite-column positions the
pointer-load heuristic minted as data labels, and their blob splits had
chopped the tail off `ExpScreenGfx4` — which is 576 bytes again, the same
size as its three siblings. The sites live in a new `DATA_IMM_IS_CONSTANT`
set that suppresses both the rendering and the label derivation, alongside
`$1d:$4c4f`, an arrow position that collided with a real template label the
same way. This is the `wrong names survive byte-perfect` hazard in its purest
form — nothing but following the consumer can catch it.

Two leads left for an emitter mechanism, not curation: bank `$3b`'s three
packed `(bank << 8) | directory-slot` selectors for `DecompressDataFromBank`
(the check evaluator only handles flat names, so a curated expression cannot
verify), and bank `$39`'s 32 stride-2 pointers into the
`TilemapAssemblyDispatch_39` stream.

## Both emitter leads followed, and both dissolved into the same pattern (2026-08-07)

Yesterday's two "wants an emitter mechanism" leads are closed, and neither
needed what the note guessed.

### The packed selectors render now

An hl handed to `DecompressDataFromBank` is `(bank << 8) | LOW(directory
slot)`, which the helper splits back apart. `slots.py` had already resolved
every call site statically — the emitter just said so in a comment. The
operand now renders as `(BANK(DataPtr_X) << 8) | LOW(DataPtr_X)`, which
assembles to the same word and survives the slot moving within its directory:
33 sites across seven banks, and the `-> DataPtr` arrow comments are gone.

Doing that exposed a **second phantom-label family**: the fifteen
`IntroCutsceneState*InitGfx*` "labels" in bank `$6b` sat at the in-bank
addresses the packed selectors alias, chopping two- and four-byte fragments
out of the `TitleSceneGraphicsGfx` blobs — each referenced only by the
operand that minted it. They are deleted, the blobs are whole (two more LZ
streams machine-verify as a result, 836 → 838), and
`pointer_load_targets` now skips any site `slots.py` resolved as a packed
selector, so the class cannot regenerate.

### The bank $39 "interior pointers" never existed

The other lead said `AnimatedTilesTable1` held 32 stride-2 pointers into the
`TilemapAssemblyDispatch_39` stream. Reading the consumer disproved the
premise: `UpdateAnimatedTiles` reads each word as h:l straight into
`DecompressDataFromBank`, so every row is a packed selector too, and the
`$6dxx` rows alias the dispatch stream by coincidence — the same trap one
level up. All four frame tables now render through the existing
`SLOT_RECORD_RENDERS` mechanism, and the `dslot` rows name what the
animations actually cycle: the intro character icons (bank `$6d`), the
roster icons (bank `$18`), and bank `$3f`'s streams.

A closing ROM-wide sweep tested all 237 raw `dw` rows whose value decodes as
a plausible `(bank, slot)` pair. Exactly two more tables were real —
`MatchRulesMenuGraphicsTable` and `CourtSelectGraphicsTable`, whose loaders
do the same h:l read, now `dslot` rows — and the other 200-odd are the
coincidence base rate, sitting in tables whose names are already numeric
(`TangentTable`, `NotePeriodTable`, the ball-position offsets). Which is the
session's moral, twice over: the packed reading is proven at the consumer,
never inferred from the value.

## The record-table pointers, the last unbanked WRAM, and one more lying scope (2026-08-08)

### `records:N:ptrK`

A fixed-stride record table can carry one embedded same-bank pointer that the
generic renderer printed as two loose bytes. The new `records:<stride>:ptr<off>`
spec renders the byte fields as `db` and the pointer as its label, so the bank
`$18` spawn tables' rows now name the `ObjectArrayA/BUpdateCallback_18` they
dispatch to. A ROM-wide scan for other record tables with consistently-labeled
embedded words found none. Alongside: a sym-wide audit confirms **zero labels
end in their own address** (the walk-sprite `SpriteTemplate_*` debt noted on
2026-07-29 was already paid), and HRAM has no raw operands at all.

### The eleven raw `$cxxx` operands, researched to a verdict

Unbanked WRAM was the one RAM surface `ram_gaps.py` does not track (it counts
banked operands). Two of the eleven are constants — a polar velocity magnitude
and `WaitSerialTransfer`'s 50000-iteration timeout — and two are loop-biased
pointers that only ever access `wShadowTilemap` rows from `$d030` up. The rest
are named, and the findings outrank the names:

* **The bank `$15` swing-contest union scope was lying**: the Training Court
  challenger scenes reuse `$c2b4-$c2bb` as four 16-bit dialogue-id slots, so
  the challenger machinery rendered as contest timers — and one seed wrote a
  word across two byte-wide HUD names. A range-scoped challenger variant
  (`wChallengerLose/Win/Draw/FollowupTextId`) wins by specificity now, and the
  raw `$c2b2` write is a vestigial duplicate of the lose slot, write-only.
* **`ClearMemory16` clears `c * 16` bytes**, so the match engine's supposed
  8-byte clears at `$08:$4084`/`$41ad` actually zero the whole `$c780-$c7ff`
  mode page — which is what resets every mode-local union between modes. The
  earlier blob-audit reading of those sites was wrong and the union comment
  now records the real behaviour.
* **`wNavGridBuffer`** (`$c7a0`): the menu shell's 4x8 cursor grid, copied
  deliberately over the minigame variable block — dead while menus run.
* Bank `$18`'s dead high-score confirm screen (only caller:
  `Unused_1b_ShowHighScoreConfirmScreen`) gets its panel state named, its
  score word provably writer-less with the high byte running into
  `wTargetZoneEnabled`.
* The debug colour editor's RGB digit string gets its two free addresses, and
  `wDebugWarpNumber` is renamed **`wDebugWarpCursorRow`** — it is the warp
  menu's field selector; the location number lives in `$c700`.

One emitter gotcha for the record: a union symbol's *size derives from its
note's leading `[N bytes]` tag*, so tagging the nav grid `[32 bytes]` inside a
5-byte union silently grew the RAM section and shifted every address above it.
`make compare` caught it as a 3,914-byte diff; the fix is tagging the base
byte and putting the extent in prose.

## A driven session under the v3 connector: bank proof for 28,413 offsets (2026-08-08)

The v3 Lua connector's `rom_wram_bank` bitmask records which WRAM banks were
selected while each ROM offset executed — the runtime fact the 238 bare
banked operands have been waiting on, and one a disassembler cannot derive.
One traced session gathered it across: the title attract cycle (the bank
`$03` cutscene frame loaders), a soft reset, the whole GB DATA status tree
(char/partner data, clear status, equipment select, the N64 tournament
trophy grid), and a story tour steered by the game's own debug menu — the
palette colour editor (watching `wDebugColorBlueDigits` earn its name in
live RGB digits), the warp menu, Island Sky's plane cutscene, the Awards
Ceremony map, the Tennis Machine Room, the Wall Practice Room with its
coach dialogue, the Dorm Room partner scene, and the `End1`-`End4` ending
maps the warp list exposes past the last `STORYLOC` constant.

**79,664 instructions now carry bank observations** (was 77,033), 23,737 of
them resolving what static dataflow could not — and the corrections caught
two more wrong names surviving byte-perfect:
`DrawPlayerNameAndLevel`'s copies at `$1e:$48c4`/`$48cc` write
`wScreenAttrmap` rows, not the `wDecompBuffer` tiles the single-bank guess
had inferred.

`ram_gaps` finally shows actionable rows instead of a wall: `SoftReset`'s
`ld sp, $d000` is the stack top misread as a data reference (wants `ld sp`
skipped as a class), `InitAndRunGame`'s bank-6 page clear wants the palette
union's ROM scope widened to bank `$01`, and one bank `$1b` site proved
WRAM bank 7 and awaits a name. The rest of the 234 still-unproven sites sit
in flows the session did not reach — the ranking-board rows (the attendant
interaction kept losing to the debug lever and wandering NPCs), match
results, minigame scoring, and the link screens — a concrete drive list for
next time, now that the warp menu makes any location three inputs away.

## A native trace of the doubles semi-final: the ranking board, and a dead routine confirmed (2026-08-08)

A user-captured BizHawk native Trace Logger run of **winning the Island Open
doubles semi-final** -- 8.5 GB across 56 auto-split `_N.log` segments, 83.6M
instructions. `tools/tracelog2cov.py` grew a glob input that streams every
segment in numeric order as one continuous trace (a banked run straddling a
split still resolves), which is what made a 56-segment capture convertible.
It produced 36,031 ROM offsets with the WRAM bank resolved at **100%** of them.

This trace reached the story match-result flow that ordinary driving could
not, and it settled two open questions:

* **`BuildMatchResultTilemap` ($16:$4a71) is dead code, not "story-only".**
  Earlier I could not reach it and guessed it needed a story ranking match.
  It does *not* execute even in a real doubles result -- the live result
  screen is `RunMatchWinLoseScreen` + `RunMatchStatsScreen` +
  `ShowMatchResultsScreen` (all hit), and `BuildMatchResultTilemap` has no
  caller of any kind. Its `$d3c7` doubles-branch operand is in unreachable
  code. It is *not* the Island Open bracket either -- that is
  `ShowTournamentBracket`, a separate bank $3b routine (not hit here).
* **`ShowRankingBoard` runs**, resolving the two doubles ranking-board
  markers: `DrawDoublesRankingMarker3`/`4`'s `$d248`/`$d066` and
  `$d24c`/`$d06a` are `wShadowTilemap` cells in WRAM bank 3, now rendered
  `wShadowTilemap + row * TILEMAP_WIDTH + col`. **234 -> 230 unproven banked
  operands**, byte-perfect.

The lesson the whole arc taught: ordinary interactive driving is saturated,
but a *native full-session trace of a real story match* reaches flows the
menus and exhibition never touch -- and it is now a one-command convert. The
remaining 230 want more such captures (singles ranking matches, the other
tournament rounds, link play), not more driving.

# Recent changes, 2026-08-07 to 2026-09-30 (archived from STATUS)

The "Recent changes" list `docs/STATUS.md` kept after the log above moved
here, newest first, verbatim as written on the day. Numbers in it are as
they stood then; STATUS has the current ones.

* **2026-09-30** — actor role names. A slot whose actor changes with the
  active list, but whose part in the scene does not, is now named for its
  part: `ACTOR_ROLE_ISLAND_OPEN_OPPONENT` is this round's opponent, whoever
  that is, and `ACTOR_ROLE_SENIOR_COURT_FAY` is Fay in any of the Senior
  Court's three lists. Each role is declared in `include/actor_roles.inc`
  with the lists it holds for. `make check` (slots) fails a use where
  another list is possible, tested by planting Court #2's spectator in a
  Senior Court script, and the runtime slot audit checks the same thing in
  play. Ten roles name 48 operands and 7 `NpcScripts` ids. 105 and 17
  numbers remain, none of which has a single part.

* **2026-09-30** — crashes counted, and the RAM audit as a tool. The event
  test now tells a game crash from a PyBoy wedge. After each frame it stops
  a run whose stack has left RAM. A watchdog in each worker catches a
  `tick()` that never returns and checks whether the game is executing RAM
  or an opcode the CPU does not have. Crashes in both builds are counted,
  and crashes in one build listed. The Test2 chunks that had stayed
  inconclusive are now six entries where both builds crash, with nothing
  inconclusive left. `tools/ramaudit.py` makes the free-RAM poison check
  (`free`) and the first-writer search (`writer`) repeatable over any
  eventtest target, story chunk or link session. "What is still open"
  above is rewritten for where things now stand.

* **2026-09-30** — free RAM re-checked for the new flows, and the Test2
  crash explained. The poison-and-replay check of the free-RAM inventory
  now covers link play (both games), the N64 record screens, both unlock
  codes, the minigames and the run-time NpcScripts tables. No free byte is
  a live variable (`docs/ram_map.md`). The Test2 debug location's crash,
  the last inconclusive event-test chunks, is the glyph underrun in
  `docs/bugs.md` at full strength. The line-break code seeds the pen from
  the row's glyph-tile column with a signed shift, so a row at column `$80`
  or above draws below `wGlyphTileBuffer`. By column `$c8` the writes reach
  the stack. The bug entry had blamed the row width and called the underrun
  harmless; both corrected.

* **2026-09-30** — the PyBoy wedges. The event test's inconclusive chunks
  (52 in the last full sweep) had two causes. Location `$13`, every state:
  the sweep enters the Wall Practice room "returning from a match" with the
  saved state's stale win, and `WallPracticeLevelResultScript` indexes its
  jump table with the stage minus one, reading past its end. The original
  lands in an `rst $38` loop, while the padded build lands somewhere that
  stops PyBoy completing a frame. `chunk` and the handler warps now enter
  with the last match lost and nothing pending, a state every story state
  allows; that also ended the false `CopyTextString` sighting. The rest were
  a PyBoy bug: a breakpoint hit on the cycle a frame ends re-fires forever
  without its instruction running. PyBoy swallows callback exceptions, so
  `eventtest` moves PC off the address on the third identical re-fire
  (registers, DIV, TIMA, LY and STAT unchanged, so no cycles have passed)
  and puts it back after the frame. A full story sweep now leaves 7
  inconclusive chunks, all at the Test2 location: the game crashes there
  itself. Its debug "clear status" screens run the glyph pen negative at a
  line break, and the underrun reaches the stack (`docs/bugs.md`).

* **2026-09-30** — two reachable routines left unrun. Steering now
  follows jump-table entries into the middle of routines (the lesson-result
  dispatch), picks the branch that reaches its goal soonest (so a loop
  exits), steers mode hooks at `CallModeHook` while each minigame runs (new
  `minigame0`-`8` targets), and runs in `linktest --steer` for link
  routines. `linktest` also gained `--keys`, `--unplug-after` (pull the
  cable) and a locked-courts save, which reached the four-court select menu
  and the link error screen by play. Of the 158 routines no play reaches,
  all but two have run under steering or a warp. Both wait on flags nothing
  sets (`ApplyWhiteFade`, `TickSecondaryTimer`; `docs/unused_code.md`).

* **2026-09-30** — steering the last routines. `tools/steer.py` runs a
  reachable routine no session entered by replaying a session that entered
  a routine above it, forcing each branch condition, jump-table index and
  table jump on the way down and nothing else; `eventtest --units` records
  which session entered what, and `eventtest` takes plugins for the hooks.
  The handler targets also cover the NpcScripts tables scripts install,
  and enter Test2 by the one entry point its init script stays for. Of the
  173 routines play still missed, 141 ran under steering (none of them
  led into an `Unused` routine); 32 remain, mostly link-play menus that
  need a partner and long story-scene chains (`docs/unused_code.md`). A
  full sweep, 36 story states, 18 menu sessions and 273 targets, compared
  a shifted build clean over 11.8 million events.

* **2026-09-30** — the N64 screens and two unlock codes. `eventtest`'s
  handler targets now cover tile triggers too, and five menu targets start
  from the main menu: three forge N64 Transfer Pak records into save block
  `$0b` and open the tournament, exhibition and ring-shot record screens
  (33 routines no run had entered), and two enter button codes nothing had
  documented, both of which call `ApplyUnlockEverythingCheat`: 29 presses
  then A on the main menu, and Right ×12, Left ×34, Select+A on the
  trophies screen (`docs/save_format.md`). A shifted build agrees with the
  original over all 58 targets. Reachable routines no run has entered:
  233 → 191.

* **2026-09-29** — link play, emulated. PyBoy has no link cable (its serial
  port drops what is written and never finishes an external transfer), so
  `tools/linktest.py` runs two games and makes the cable out of hooks on
  each game's own serial code; the games then run their own protocol --
  the master/slave handshake, the rules screen, the unlock exchange,
  character select and link matches. 97 routines ran for the first time.
  With the story handler targets, the reachable routines no run has
  entered fell from 366 to 233 (`docs/unused_code.md`, "Reachability"):
  `tools/reach.py` now also knows that nothing runs after an unconditional
  `ret` or `jp` without a label, which makes the in-match debug stats editor
  (behind a hotkey check that returns at once) 16 more `Unused` routines.
  The one of them the sweep saw run was a wild jump from a state play
  cannot reach, a Wall Practice win at level 1.

* **2026-09-29** — stage-picked actor lists, and story handlers on demand.
  The Senior Court and the Tournament Site pick their actor lists from a
  stage number computed from story flags, so `tools/actorslots.py` now ties
  each of those lists to its stage (`wMapSceneStage2` for the court,
  `wMapSceneStage`, the Island Open round, for the site): a branch on the
  stage narrows the list, and a stage-indexed jump table runs each entry
  under its own stage's lists. The site's round-call tile triggers exist
  only once `LoadIslandOpenRoundNpcs` has written their cells, so they run
  only under the round lists it installs. 182 more operands are names
  (4,781 in all); 153 stay numbers, which hold a different actor in each
  possible list (the Island Open opponent slots change every round).
  `make slot-audit`: 665,903 hits on 351 names, no disagreement.
  `eventtest --handlers N` plays each of the 180 story NPC and facing
  handlers: it warps to the handler's location, then hands the interaction
  loop that handler's table, facing, flag condition and id. Of the 41
  handlers no earlier run had entered, 34 ran; the other 7 are the Test2
  location's, whose init script never finishes.

* **2026-09-29** — the routines no run entered, explained. A coverage
  sweep (15.7 million events, no difference) left 1,059 never entered.
  `tools/reach.py` follows every reference from the reset, interrupt and
  `rst` vectors -- macro bodies, slot aliases, fall-through, local-label
  jumps -- and found 330 more routines nothing live can reach: many were
  named only by their own slot-table row, or called only from `Unused`
  code. They are `Unused_<bank>_...` now (697 routines in all), and `make
  check` (`reach`) fails whenever a name and reachability disagree. The
  428 reachable routines no run entered each sit below a routine that did,
  which names the missing condition: link play and the N64 Transfer Pak,
  story handlers random walks miss, the practice drills 2-3, a damaged
  save, debug hotkeys (`docs/unused_code.md`, "Reachability"). eventtest
  then gained targets for two of those: six damaged saves booted from
  power-on (the header, its mirror, a story slot, its backup, block `$36`,
  N64 records) and every drill and minigame-room id the drill list does not
  offer, swapped in at the launcher. 318 sessions compared clean, and 366
  reachable routines remain unentered, mostly link play, the Transfer Pak
  and story handlers.

* **2026-09-29** — the full event test after the edited-build tool changes
  (eventtest now places its hooks through build addresses): 36 states × 42
  locations, 90 main-menu and 240 targeted sessions, 13.13 million events,
  no difference; 52 runs inconclusive on PyBoy timeouts, 36 of them at
  location `$13`. The sweeps' temp copies now live in one run directory
  that is removed at exit -- killed workers had left 4,978 of them in
  `/tmp`, enough to fill it.

* **2026-09-29** — a real mod, and what it broke. On a throwaway branch:
  the grayscale conversion fixed (it had three faults, not one: see
  `docs/bugs.md`), a bounds guard on the menu stack, and a longer string
  through `mods/`; both fixes confirmed in PyBoy against the original. The
  pipeline assumed an unmodified ROM in more places than expected, and
  those fixes are on main: the `lz` and `lz-labels` checks read the
  original's offsets (every label after an edit looked like it truncated a
  stream), the branch and scope checks keyed on address comments (new code
  has none), the runtime tools hooked the addresses in those comments
  (stale after a size change: `banksrc.build_addresses` places a line from
  its nearest label instead), `rgbfix` warned on every edited build, and
  removing a mod left the edit in `data/` (the overlay now keeps and restores
  the extracted file). On the edited tree `make check`, `make test` and
  `make shift-test` pass and an event-test state compares clean.

* **2026-09-29** — the slot analysis is a tool and a check.
  `tools/actorslots.py` is the control-flow analysis that named the actor
  slots; it now also follows inline `rst Rst00` jump tables, which settled
  134 more operands in the lesson-result scenes and proved the nine coach
  scene names that had rested on the old rule alone. `make check` gains
  `slots`: a name whose slot holds another actor in a list the analysis
  finds possible fails (tried on a same-numbered name from another list:
  the build still compared OK and `slots` failed). `make slot-audit` runs
  its PyBoy sweep of every name: 665,785 hits on 347 names over 36 story
  states and every location, no disagreement. `requirements.txt` pins
  Pillow and PyBoy and `make venv` installs them into `.venv`, which
  `event-test` and `slot-audit` use. 4,599 script operands and 436
  `NpcScripts` ids are names; 335 and 97 numbers. Most of the rest are the
  Senior Court's and the Island Open's scenes, picked by a stage number the
  location computes from story flags; tracking the flags themselves along
  paths settled one more, so they stay numbers.

* **2026-09-29** — 1,030 more actor slots, by following control flow. The
  slot resolver now tracks which (actor list, `NpcScripts` table) pairs can
  be active at each line: a variant installed on one branch of an init
  script only covers that branch, a location starts from its default list
  and table, `JumpToHL` dispatch tables are followed into the ranking-match
  intros and victory scenes, and an `NpcScripts` handler runs only under
  the lists its own table is installed with. 903 script operands and 127
  `NpcScripts` ids became names; none of the 3,348 names already there that
  the analysis reaches disagreed. A PyBoy sweep of 36 story states × every location hooked each
  new site: 1,435 hits, all on the list the name comes from. Now 4,465
  script operands and 436 ids are names, 469 and 97 numbers
  (`docs/story_mode.md`, "map_actor").

* **2026-09-28** — the last animation ids. Ids 5 and up depend on the
  sprite's `AnimPtrs` layout (fifteen layouts across the walk sprites), so
  each new name says which sprites it holds for: `ANIM_EXERCISE`, `ANIM_HOP`,
  `ANIM_SWING_LOOP`, `ANIM_TROPHY_SINGLES`, `ANIM_TROPHY_SMALL`,
  `ANIM_DISTANT`, `ANIM_OVERHEAD_SWING`, `ANIM_SWING_BACK`,
  `ANIM_SWING_THROUGH`, `ANIM_SIDESTEP`. The awards scenes swap sprites with
  `script_set_objdef` before animating, so each site was resolved to the
  sprite it animates, and a PyBoy sweep (36 story states × every location,
  a hook on `SetActorAnimation`) confirmed every site it reached ran on that
  sprite. The trophy's ids pick which trophy it shows: the doubles trophy,
  the singles cup, the small ones. No `as_anim`, `script_set_anim` or
  `map_actor` animation is a number now, and the sprite scripts' `anim_set`
  operands are `ANIM_WALK`, `CHARANIM_IDLE` or `CHARANIM_SERVE_READY`. The
  character records still unnamed (`$36`, `$49`-`$53`, `$57`, `$5a`) are
  loaded by nothing.

* **2026-09-28** — drills and 381 more actor slots. Nine eventtest targets
  pick each drill from the Test map's list; 240 targeted sessions match the
  original, and 2,155 routines have now been entered. The actor-slot rule no
  longer counts a variant that a visit-ending scene installs (the three court
  tours, the Tournament Site arrival, one ending scene): the player is never
  in control under it. That names 360 more script operands and 21 more
  `NpcScripts` ids, and all 593 runtime hits on them matched the active list.
  3,877 slot references are names now, about 880 still numbers
  (`docs/story_mode.md`).

* **2026-09-28** — beyond the story, and a coverage pass. `make event-test`
  now also plays long seeded sessions from each of the main menu's nine items
  (exhibition, minigames, match select, the story-slot screens, the
  dictionary, link play). Story sweep plus 360 sessions: 18.96 million
  events, no difference between the padded ROM and the original. With
  `--coverage` the same run records the routines it entered, and
  `tools/coverage.py` reports on them: 1,929 of the 3,227 observable routines
  ran, and no `Unused*` routine did. 158 of those that never ran also have no
  reference in the source. All 158 are now `Unused_<bank>_…` (467 labels in
  all). For the 68 that are twin-group copies, their 19 templates were moved
  to `twin_in` so each copy names itself (`docs/unused_code.md`).
  `--targets` adds eleven starts random play cannot reach: the intro and
  attract loop, the debug menu, and each Test-map NPC's flow (match and drill
  lists, lessons, minigames, epilogue, credits). 132 sessions: no difference,
  and 2,102 routines entered in all. These runs found a third layout-dependent
  original-game path: the collision and behavior map reads have no bounds
  check, so an actor off the map (easy on the Test map's open edges) reads echo
  RAM (`docs/bugs.md`).

* **2026-09-27** — the padded ROM played through every story state.
  `tools/eventtest.py` (`make event-test`) boots both builds, enters every
  location at each entry point under 36 story-flag states, and compares the
  ordered code labels entered, actor lists, talks and character records. It
  hooks each build by name through its own `.sym`. Inputs are fed per logic
  frame, and a VBlank that lands inside a lagging frame is undone, so the one-
  or two-cycle differences a shift causes cannot move either game a frame.
  It found faults no static check had: `CallHLInBankA` built its return address
  from two literal bytes, so every native story script returned into moved
  code; the pause menu took text id `$0162` as `CallHLInBankA + 4`; five
  pointer tables sat inside `INCBIN` blobs (the match objects' move curves, the
  score and serve graphics, the character screen's radial ramps, the court-select
  cursor templates); the trig, view-scale, perspective and sound tables are
  read through a computed high byte and now `ASSERT` their placement; and two
  `TangentTable` pointers were numbers. Each class is now a `literals` rule in
  `make check`. It also found two original-game paths whose outcome depends on
  where code sits (`docs/bugs.md`: `GetSpeakerVoice`'s stack slip and the
  Courtyard walk-in over-read); a run that takes one is compared only up to it.
  Final sweep: 36 states × 42 locations, 14.66 million events, no difference;
  161 entries stop at one of those two paths, and 48 of the 1,512 location
  runs are inconclusive because PyBoy wedged (a chained breakpoint), not
  because either build did.

* **2026-09-27** — the free-RAM inventory re-checked at runtime. Every free
  byte poisoned, each run played twice under the same inputs across the story
  states, menus, exhibition matches and minigames (`docs/ram_map.md`, "Free
  RAM"). The only poison read was record `+$2b`, which the docs had called a
  dead store: it is the speed bonus `LoadCharacterAttributes` adds to the
  Speed stat, now `CHARREC_SPEED_BONUS` and declared in all eight records
  (with `+$0d` gender and the write-only `+$2f`). Tracing each unexplained
  write to its routine (a hook on every code label for the one frame the
  byte changes) found the game progress screen's five lists in bank `$05`'s
  `$df00` page, more of the save engine's staging leftovers, and a menu-stack
  overflow: a seventh nested menu overwrites `wMenuDepth` (`docs/bugs.md`).
  All the old *untouched* ranges held. 4,360 free bytes remain.
* **2026-09-27** — the audit run through story states, and a correction.
  Writing `wGameFlags` before each warp recreated 36 story states (every
  step of the singles and doubles progress chains: class ranks, Island Open
  rounds, story completion, Peach's Castle, the Dream Match), each visited
  at every location and entry point, 1,512 runs in separate PyBoy processes
  (nine hung on inconsistent flag mixes). It exposed a flaw in the
  actor-slot rule: a variant list installed by a location's *init* script
  (the Courtyard's varsity variants, the Training Court's tour, the Senior
  Court and tournament variants) stays active for the whole visit, so the
  location's NPC and scene scripts can run under it -- the audit caught
  `ACTOR_COURTYARD_KEVIN` running where the variant has someone else in
  that slot. With the init-installed variants added to each location's
  candidates, 617 script operands and 40 `NpcScripts` ids were no longer
  certain and are slot numbers again; 3,202 names remain, and every one the
  runs reached (1,853 sites) agrees. The states also loaded record `$62`
  in the doubles Dream Match, which led to `PairSwapIndexTable_0a`: it is
  `DoublesPartnerTable_0a`, the doubles partner of each opponent id
  (`AssignStoryMatchCharacters`), now written as character names, and
  `$61`-`$63` are the Dream Match doubles partners. No `Unused*` routine ran
  in any state.
* **2026-09-27** — a runtime audit. `tools/runtime_audit.py` (needs PyBoy)
  plays the game headless from a save -- every story location entered at
  each of its entry points through the game's own `$ff` reload request, then
  walked about at random, and a long random session from the Test map,
  whose debug NPCs launch story matches -- with hooks that check the
  source's claims against what runs. On 3.5 million frames: none of the
  206 `Unused*` routines executed; every actor-slot name reached (1,553
  distinct script sites, about 19,700 executions, and 164 NPC talks) ran
  under a list holding the same actor in that slot as the list its name
  comes from, with no disagreement; and the character records loaded were
  the ones their constants say (the drill partners for their drills, Mark
  and Ellis for doubles Varsity #2, `$5b`/`$5c` for Dream Match Hard and
  Intense). `$5b`-`$60` are now `CHAR_DREAM_HARD` ... `CHAR_DREAM_DOUBLES_MAX`.
  A record the audit saw load during Net Game Match 1, `$54`, led to
  LoadDrillOpponentBySide: the net-game and stroke match drills swap the
  opponent's record by server at every point, which a hook on it confirmed
  (the player serving loads the drill's own partner, the opponent serving
  `$54`). `$54`-`$56` are `CHAR_DRILL_NET_GAME_MATCH_n_SERVING`, `$58`/`$59`
  `CHAR_DRILL_STROKE_MATCH_n_RECEIVING`; `$57` is Stroke Match 1's empty slot.
  Coverage is what random play reaches: scenes gated behind story states
  the save is past (most of the ranking-match intros and victory scenes,
  `AcademyWingInitScript_10`'s stage branches) never ran, so the ~600 actor
  slots still written as numbers were not resolved this way.
* **2026-09-27** — the padded ROM boots and plays. Running it (BizHawk,
  then headless PyBoy) found what the static checks could not. It hung
  before the Nintendo logo because nineteen tables were addressed as
  split-base `add $lo / ld l, a / adc $hi / sub l / ld h, a` with raw
  operands (fixed in the previous commit). Then the main menu's caption box
  came out garbled: VRAM DMA ignores the low four bits of its source, so
  graphics the game copies straight from ROM must stay 16-byte aligned, and
  a 3-byte shift misaligned them. Every aligned uncompressed graphics or
  tilemap blob and every direct DMA source (2,363) now has `ds ALIGN[4]`
  before it -- no bytes today, padding after an edit -- and the `dma` check
  fails on a DMA source without one. `tools/playtest.py` runs a ROM and the
  original side by side in PyBoy under one seeded input sequence from a
  save and reports persistent screen mismatches; the fully padded ROM
  agrees through the intro, title, menus and into an exhibition match
  (11,000 frames), apart from transient timing drift: a shifted build is not
  cycle-identical, since page-crossing lookups and lag frames move.
  `shifttest.py` takes `--banks` and `--out`, maps each byte through the
  symbol tables (the shift is 3 before a bank's first alignment and 16
  after), and needs 18 free bytes to pad a bank.
* **2026-09-27** — a correction to the 2026-09-12 music names. The match
  settings tables are indexed by story match (`STORYMATCH_*`, new: the
  class rankings counting down to #1, the Island Open rounds, the three
  Dream Matches), not by `MINIGAME_*` id as their row comments claimed, so
  the seven tunes named from those rows were wrong: they are
  `BGM_PRACTICE_MATCH`, `BGM_JUNIOR_RANKING`, `BGM_VARSITY_RANKING`,
  `BGM_ISLAND_OPEN` (and `_SEMIFINAL`, `_FINAL`) and `BGM_DREAM_MATCH`. The
  real drill, machine and wall tunes come from the drill definitions, now
  `drill_def` rows in both banks (`$0b`'s eighteen training drills and
  `$0d`'s eighteen minigame and room configs, seven of which had been
  decoded as instructions): `BGM_DRILL_MATCH`, `BGM_DRILL_PRACTICE`,
  `BGM_TENNIS_MACHINE`, `BGM_WALL_PRACTICE`, `BGM_TARGET_MINIGAMES`. The
  drills' opponents are records `$37`-`$48`, `CHAR_DRILL_*`; the 70
  `load_match_settings` calls name their match.
* **2026-09-27** — a pass over known values the source still spelled as
  numbers. Struct fields: `ACTORF_*` (the actor record, with its flag and
  status bits — heading at `+$14`, facing at `+$34` following it unless
  locked, the drawn `FACE_*` at `+$32`), `CHARREC_*` (the `$40`-byte
  character record, the eleven stats by name) and `OBJSLOT_*` (bank `$09`'s
  object slots), about 330 sites. Ids: the extended character ids
  `CHAR_RANKER_32`-`47` and the six named opponents (their own names in the
  roster's name pool, though RemapExtendedCharId shows them as roster
  characters), 97 more text ids (the challenger dialogue, base-plus-offset
  loads, the ranking boards' name tables), the bank `$04` actor lists as
  `map_actor` rows, `as_set_field`'s selectors (actor record offsets). Two
  corrections: `script_facing_lock`'s operand was a lock flag, not a facing
  (now `script_lock_facing` / `script_unlock_facing`), and the actor-field
  opcode handlers reached `ActorFieldTypeTable_04` through a split `add $fd`
  / `ld a, $47` / `adc $00` that `literals` now catches. `$c780` is
  `wModeScratch`. Left as numbers on purpose: animation ids (what id 3, the
  common one, depicts would need the frames identified), the unnamed
  character records `$36`-`$63`, and slots that more than one actor list
  could fill.
* **2026-09-27** — actor slots are named by row. `map_actor` takes a
  ninth argument, and the macro defines `ACTOR_<name>` as `3 + row` (a row
  whose condition fails still takes its slot, so row order is the slot map).
  All 79 lists name their rows after location and object, and 4,153 slot
  numbers in the story scripts and `NpcScripts` tables became names where
  the active list is certain (`docs/story_mode.md`, "map_actor"); about 600
  stay numbers because more than one list could be active.
* **2026-09-27** — the last hardcoded ROM addresses. A scan for ROM
  addresses written as numbers (4-digit literals in address operands,
  split `LOW`/`HIGH` halves, literal banks beside cross-bank labels, and
  label-valued words inside the untyped blobs) found three. The Training
  Gym joggers' actor scripts made 96 `as_call`s to `$4c8e` and `$4ce5`,
  two unlabelled wait routines inside `Unused…ClearWaypoint` bodies: they
  are `TrainingGymRunner0BWaitWaypointClear` and
  `TrainingGymRunner0CWaitWaypointClear`, and the tail all three waits jump
  to, filed as `.checkTimer` under an unused label, is the proximity test
  `TrainingGymRunnerCheckClearance`. `VramTileset_09`'s 29 source words
  are offsets into `TilesetTiles_09`, and six rows of
  `TilemapAssemblyDispatch_39` point one byte past the last rect list
  (`.pastEnd`). Everything else the scan raised was coordinates, sizes,
  colours or text ids.
  A `make check` class, `literals`, now fails on a numeric `jp`/`call`
  target, a number in a macro argument that elsewhere always takes a label,
  and an `ld rr`/`dw` literal equal to a same-bank label. Its first run
  found `StrokePractice2Hooks`, the one drill hook table still decoded as
  instructions (`call c, $e06d`), now eight `dw` rows like its siblings. The
  `$4000` slot encodings `farcall`, `dslot` and the new `ld_slot` (33
  `(BANK(x) << 8) | LOW(x)` loads) assert their label is in the slot table,
  since only its low byte is stored.
  `make shift-test` (`tools/shifttest.py`) rebuilds a copy with 3 bytes of
  padding at the top of every bank with room (123; the five full data
  banks `$2f`, `$64`, `$68`, `$69`, `$7f` stay put) and checks every byte
  that changed is a moved reference: 43,694 low bytes and 157 carried high
  bytes, nothing else. It cannot see a hardcoded address (those bytes do
  not change), which is what `literals` is for; booting the padded ROM it
  leaves behind is the remaining proof, not yet done. The twelve slot
  lookups in bank `$00` load `h` with `SLOT_TABLE_PAGE`, the constant the
  asserts check against, and no ROM table is indexed without carrying into
  the high byte, so none depends on staying inside a 256-byte page.
  Going through the slot consumers turned up 117 more hardcoded slots:
  `ObjectIdList_04` stored `db slot, bank` bytes into banks whose slot words
  had no label, so a shifted build would have loaded the wrong header for
  every object without a byte of the diff changing. The character banks'
  and walk-sprite banks' slots are labelled, the list is `object_id` rows
  defining `OBJ_*` (`docs/graphics_formats.md` §4.3), and every `map_actor`
  row, `script_set_objdef` and object load names its object. The table the
  generator had called `TileIdLookup` is `CharObjectIdTable`, the game's own
  map from `CHAR_*` to walk sprite, which names 31 of them. Seven menu
  label-tile tables and four `FarCallVector` calls held raw slot pairs too;
  they are `dslot` rows and `ld_slot` loads, and `literals` fails on a
  numeric `hl` handed to any slot consumer.
* **2026-09-12** — the last unnamed sound ids. The ids carried by tables
  rather than `sound` sites are named for what they accompany: the seven
  drill and lesson themes the match-settings tables select
  (`BGM_TRAINING_DRILL`, `BGM_SERVICE_DRILL`, `BGM_STROKE_MATCH`,
  `BGM_STROKE_PRACTICE`, `BGM_TENNIS_MACHINE_A/B`, `BGM_WALL_PRACTICE`),
  the three story-location themes (`BGM_ACADEMY_BUILDING`,
  `BGM_ACADEMY_OUTDOORS`, `BGM_ACADEMY_ROOMS`) and the `BGM_UNCHANGED`
  sentinel, the six on-court cues the object templates play
  (`SFX_SCORE_DISPLAY`, the five `SFX_BANNER_*` by banner row) and the two
  level jingles. `SFX_RANKING_MARKER` is `SFX_MARKER`: the same cue lands the
  score digits and a banner. The court-select music rows and the two raw
  `wMatchBGM` stores use the names too.
* **2026-09-12** — the minigame point tables and the drill gate tables have
  named fields. The eight `*PointTable`s are the court-position record shape
  (`court_positions`, one row per point; the old rendering had split each
  record in half), with their `$ff` terminators already carved as one-byte
  fills. The eight `*PointStartDrillPositions` tables are `drill_gates x1,
  depth1, x2, depth2` rows, the two ball-gate points `IndexDrillTableByPoint`
  sets per point, ending on `$ff, $ff`.
* **2026-09-12** — the match-screen object templates have named fields.
  Bank `$09`'s seven `*ObjTemplate*` tables (45 records: the score display,
  the serve indicators, the win/lose result, the 29 court banners) render as
  `obj_template x, y, sprite_template, update, curve, exit_update,
  exit_curve, sound, draw_mode`, the layout read from `LoadObjTemplate_09`
  and `StartObjExitAnim`. Their update-routine words were entry points
  inside an unlabelled tail of `FinishObjSlotUpdate`, now `ObjUpdateShow`,
  `ObjUpdateHide` and `ObjUpdateRunCurve`; and six of their sprite-template
  words pointed into the last 24 bytes of the `ServeGfxPtrTable_09` blob
  and part-way into the region after it, which turned out to be one
  8-row column template entered at different rows to draw fewer objects
  (`ObjColumn8SpriteTemplate_09` with `.rows7`-`.rows2` entries), followed
  by two more templates the generator had left as raw bytes. The blob is
  24 bytes shorter and the three templates are rows.
* **2026-09-12** — four more table families have named fields: every story
  and minigame match's settings (`match_settings mode, opponent, court,
  sets, games, bgm`, the two 25-row tables, each row commented with its
  `MINIGAME_*` id), the training drills' per-outcome rows (`drill_outcomes`,
  38 tables indexed by `POINTOUTCOME_*`), the six court-position record
  tables (`court_positions`, the four `wCharCourtPos` codes then the four
  `wCharServeRole` codes) and the Target Shot scoring rules (`score_rule`).
  The remaining raw tables are a long tail of screen geometry, sprite offset
  lists and per-screen scratch, worth a macro only when someone edits one.
* **2026-09-12** — polish across the tree. 77 fragments whose dominant-word
  names misled were renamed for what they hold (`vectors_00`, `vblank_00`,
  `decompress_00`, `trig_00`, `boot_01`, `courtselect_3e`, `dictionary_3f`,
  ...), the bank `$03` save routines moved under `src/engine/save/` and the
  sound note trigger under `src/audio/`. The docs' `file:line` citations
  are file names only; the routine each sentence names is the stable key,
  and the address comments give the original location. The two
  `ShotBallPath` pairs share a source through a third macro form,
  `twin_in file, Label, bank`, leaving four copies separate (the Island
  Open NPC scripts). `hSndPortamentoTimer` is `hSndNoteTimer`: the note
  command's length operand sets it. The debug test menu needs no build
  flag: `InitAndRunGame` sets `SAVEFLAG_DEBUG_TEST_MENU` when A is held
  at boot.
* **2026-09-12** — the trajectory tables are source. The fifteen
  ballistic-solution tables of the nine shot banks (15,360 bytes each in
  the four stroke banks, 7,200 in the three serve banks, the lob, drop,
  fallback, neutral, reach and three stretch tables) are extracted to
  `data/bank_02x/<Table>.asm` as `traj_row` / `traj_row4` rows with block
  separators where the offset tables index in 64-row blocks, and the five
  small offset blobs of bank `$24` as `dw` rows; the banks `INCLUDE` them.
  `make check` (`traj`) proves each renders back to its bytes.
* **2026-09-12** — WRAM bank switches say what they reach for. The 1,725
  `wram_bank` / `push_wram_bank` sites use `WRAM_*` constants: the bank's
  owner (`WRAM_STAGING`, `WRAM_COURT_PLANES`, `WRAM_SCREEN`, `WRAM_ACTORS`,
  `WRAM_TEXT`, `WRAM_SCENE`, `WRAM_SOUND`) or, where the code goes on to
  touch the on-court character struct at `$df00` (or is a bare switch in
  the match engine), `WRAM_CHAR0`-`WRAM_CHAR3` for banks 4-7. Same
  numbers, so the bytes are unchanged.
* **2026-09-12** — a fork can commit its edits. `mods/` mirrors `data/`:
  an edited PNG, grid, text file or track lives there at the same relative
  path (tracked), and `tools/mods.py apply` copies it over `data/` before
  every `make` (at Makefile parse time, so no target races it) and after
  every extraction; `tools/mods.py collect baserom.gbc` brings every file
  edited in `data/` into `mods/` by comparing against a fresh extraction.
  ROM content stays out of the repository; only the fork's own changes go
  in.
* **2026-09-12** — the sound scripts are source. Reading the driver
  settled the format: every command is two bytes and the interpreter
  steps by command index, the one four-byte command (`$ac`) carrying a
  byte offset from the track's start; loops go through per-channel slots.
  All 315 channel scripts decode over exactly their extents, and
  `extract.py` now renders each to `data/bank_07x/<Track>.asm` as `snd_*`
  macro rows (`snd_note C#, 3, 8`, `snd_call 2, .call0`; noise-channel
  tracks as `snd_noise`), which the sound banks `INCLUDE` in place of the
  `INCBIN`s. `tools/snd.py` is the codec, `make check` (`sound`) proves
  the round trip, and `docs/sound_engine.md` has the command reference.
  Eight tracks end on a note and run on into what follows; the rendering
  says so. The emulator gives no audio, so the command names come from
  what the driver does with each operand, not from listening.
* **2026-09-11** — the scene blob families are named after their scene.
  Each of the 37 scenes' blobs (config, palettes, tiles, tilemap, attribute
  map, collision and behaviour maps, and the `DataPtr_` slots and aliases)
  now carry the `SCENE_*` name in CamelCase, in the source, `data.manifest`,
  `data.previews`, the extracted `data/` files and the docs: 440 labels.
  Nine families had been named by a wrong visual guess (`SpaResort*` was
  the restaurant, `CeremonyHall*` Peach's Castle, `Countryside*` the
  restaurant plaza, `Clubhouse*` and `Courtyard*` the two minigame courts,
  and the `HardCourt`/`CompositionCourt`/`PracticeCourt`/`IslandOpenCourt`
  families were the training, hard, composition and wall-practice courts);
  the rest were renamed for consistency (`YoshiCourt*` → `TropicsCourt*`,
  `CafeCourt*` → `Court1*`, `StadiumGrounds*` → `CenterCourtMap*`, ...).
* **2026-09-11** — the twin families share one source. 60 families, 271
  of the 279 instruction-identical live routines, are now one file each
  under `src/twins/`, assembled into every member bank through
  `twin file, <bank>` (labels and bank-local references take the bank
  suffix through `{TWIN}`) or `twin_named file, Label` for identical bodies
  under different names. The bytes are unchanged; the shared bodies drop
  the per-instruction address comments and the `twin` line carries the
  copy's start. Three labels gained the suffix their family used
  (`FetchTextTable_1f`, `Unused_1b_DrawAsciiDigitString`,
  `SpriteWobbleXTable_17`). Eight copies stay separate: the two
  `ShotBallPath*` pairs reference different tables under different names,
  and four Island Open NPC scripts differ only in a text id, which the
  twins tool had mistaken for a bank suffix (fixed). Also fixed: the split
  commit had left `src/data/` untracked because `.gitignore`'s `data/`
  matched it; the pattern is now anchored and the 76 files are in.
* **2026-09-11** — the source is split by subsystem. Each
  `src/bank_XXX.asm` is now a holder — the `SECTION` line, the
  decoded-length includes, and an ordered `INCLUDE` list — and the
  contents live in 400 fragment files under `src/home/`,
  `src/engine/<subsystem>/`, `src/story/`, `src/audio/` and
  `src/data/<kind>/`, each named `<topic>_<bank>.asm` after the routines
  that dominate it (cut at label boundaries where the topic changes,
  400-1000 lines each; the pure data banks are one file apiece, named for
  what they hold). The bytes are unchanged, the holder's include order is
  the bank's layout, and `tools/banksrc.py` gives the tools a bank whole.
  Make dependencies come from `tools/deps.py` (`build/deps.mk`). The docs'
  `src/bank_XXX.asm:line` references were mapped to the fragment files.
* **2026-09-11** — the id pass. The big families (character, court,
  game-mode, location, minigame, shot-type, sound) were already applied
  where the generator's constants keyed them; a data-flow scan from each
  family's carrier symbol found 290 more sites, and four new families:
  `SCENE_*` (the 37 scene-table records, named for what loads them, used by
  the `story_location` and `court_scene` rows), `LINKSTATE_*` and
  `LINKMSG_*` (the link roles and the ten `$c0`-`$cd` control tokens),
  `MATCHCONTEXT_*` and `MENUSLIDE_*`; the 40 serial-control writes use
  `hardware.inc`'s `SC_*` bits, and the 42 story entry-point sentinels
  `STORYENTRY_NONE`. What stays literal is mostly per-location stage
  scratch, whose meaning changes by bank, and the numbered entry points.
  The scene blob families named by visual guess were renamed the same day
  (below).
* **2026-09-11** — the tunable tables have named fields. One macro row per
  record, field order in the macro's comment: the 100 character records
  (`char_record`, each with the character's name), the racket and shoe
  bonuses (`equip_stat_deltas`), the four stat archetypes
  (`stat_thresholds`), the EXP curve (`exp_threshold`, in decimal), the
  shot-type presets (`shot_preset`, with five new `SFX_HIT_*` ids), the CPU
  difficulty rows (`cpu_difficulty`), the court surface table
  (`court_scene`, named per court) and the AI shot habits (`AISHOT_*`
  codes). Labels renamed for what they hold: `RacketStatDeltas_02`,
  `ShoeStatDeltas_02`, `StatArchetype0-3_02`, `ExpLevelThresholds_02`,
  `CourtSceneDataTable`. Also fixed `strings.py --index`, which had listed
  strings in pool order rather than text-id order since the retirement.
* **2026-09-11** — screen assets are referenced by name. The two bank
  `$39` dispatch tables define their own indices: `tileblock Name` rows
  (122) export `TILEBLOCK_Name`, `screen_asset Name, ...` rows (70) export
  `SCREENASSET_Name`, and all 153 `LoadCompressedTileBlock` sites and 38
  `LoadScreenAssetRecord` sites, plus the five cutscene id lists in bank
  `$18`, use them. The 139 tile-block copies that take the whole decoded
  block now say `Blob_SIZE / 16` (the `.inc` included at the top of the
  using bank); the 13 partial ones say which tiles of which blob.
* **2026-09-11** — the generator is retired and `src/` is the source of
  truth. A final run reproduced the committed tree byte for byte, the tag
  `generator-final` was placed on it, and `tools/disasm.py`, `disasmlib/`,
  the six JSON inputs, `coverage/`, `hooks/`, the coverage-pipeline clients,
  `sm83.py`, `progress.py`, `ram_gaps.py` and the generator's tests left
  the tree. What stayed was made independent of them: `check.py` reads
  symbols from the build's `.sym` (and dropped the text-table and curated-
  constant checks, which the assembler now makes), `strings.py --index`
  reads the extracted text source, `ram_free.py` reads
  `include/ram_mirrored.inc`, and the "do not edit by hand" headers are
  gone. From here a change to a name, note, union or table is an edit to
  the assembly.

* **2026-09-11** — every sound call names its id. The 33 ids that were
  still literal at 182 sites are named from their call sites in
  `include/constants.inc` (`SFX_NET_CORD`, `SFX_RANKING_MARKER`,
  `SFX_VOICE_YOSHI`, the two cutscene pop sounds, ...); the comments say
  where each plays, since the emulator gives no audio to say what it
  sounds like.
* **2026-09-11** — two readability changes for modders. VRAM addresses are
  named at the 760 sites a VRAM consumer takes them (`vTiles0 + $10 *
  TILE_SIZE`, `vBGMap0 + 15 * TILEMAP_WIDTH`, `+ VRAM_BANK1`), the 51 words
  in that range that are sign bits or coordinates left literal. And the
  generated palette files use a `palette` macro of four `r,g,b` 5-bit
  triples instead of `dw` words, except the five palettes whose words use
  bit 15.
* **2026-09-11** — screen layouts are editable. The 213 tile and attribute
  planes (200 of them LZ streams) carry a `tilemap:W` manifest tag and are
  extracted a second time as `.tilemap` text grids, one `tilemap_row` per
  row at the loader's width (64 for the story scroll buffers, 32 for the
  screen planes); `make` re-encodes an edited grid and recompresses it,
  `make check` round-trips all 213, and each of the 37 scenes gets a
  view-only picture composed from its planes, tiles and palettes
  (`data.previews`, `make previews`). Proving it exposed that two banks ended
  in a *labelled* `ds` fill, which left them no room to grow; a labelled
  tail is now left to the linker's padding like any other.
* **2026-09-11** — text control codes are named. `include/text_codes.inc`
  gives every byte below `$20` its `TX_*` name (player and partner name,
  the string and number argument pops, the three delays, the short-text
  code and its operand, the newline aliases and the no-ops) and the pool
  renderer writes them, so a string reads `text TX_PLAYER_NAME, " won"`
  instead of `text $07, " won"`, and a roster name inserted into a string
  is `TX_SHORT_TEXT, CHAR_EMILY`. The include is in the build prelude; a
  test round-trips a string through the renderer and rgbasm.
* **2026-09-11** — the RAM the poison run found in use is named. The
  character records' documented field groups are declared in all eight
  records (physics attributes, swing word, AI parameters, stat bars, the
  3-byte EXP accumulators, physics template, trainable levels, name
  padding), the saved-slot mirror records get their name, id, palette,
  gender and handedness fields, the flag bytes 14-23 of `wGameFlags` are
  named by content, and `wPlayer1MainExpTier` fills its gap. The rest was
  not variables: the "records" at `$c6e0`/`$c730` are the save engine's
  staging copy passing through `$c600-$c7ff`, and bank `$07` `$d2b0-$d2ff`
  is the text engine writing five glyph tiles below `wGlyphTileBuffer`
  when the pen goes negative (`docs/bugs.md`); and the four bytes after
  each character's sprite slot are `wCharSpriteSlotFrame`, the frame
  descriptor the status, results and EXP screens park there. Static
  unnamed RAM is down to 4,404 bytes: 2,591 untouched, 1,616 cleared only,
  the rest explained; nothing the poison run found in use is left unnamed.
* **2026-09-11** — the "text-engine buffers" were block clears. Checking
  every written-but-unnamed byte against all seventeen saved states showed
  the 1,455 bytes of WRAM bank `$05` (and `$df97-$dfff` of banks `$05`-`$07`,
  and 286 WRAM0 bytes) never hold anything but zero: `ResetTextWindowState`
  clears the whole bank on every text-screen init, boot clears every WRAMX
  bank, and match setup clears each character bank's `$df00` page. The
  inventory now has three classes -- untouched (2,495 bytes), cleared only
  (1,620, usable as per-screen scratch), holds data (786, the naming
  targets) -- and `wSceneTileAnimBuffer` is declared at its real 384 bytes.
* **2026-09-11** — a verified free-RAM inventory (`docs/ram_map.md`, "Free
  RAM"). `tools/ram_free.py` lists the 5,106 bytes no symbol covers; every
  one was poisoned in a savestate and seven scripted flows (menus, a
  singles and a doubles match, the Test map, the status screens, the
  lesson menu, the credits) replayed against the clean state. 2,495 bytes
  were never touched and are the list to allocate from; 2,771 were
  written, among them the second shadow-OAM page, now `wShadowOAM2`, and
  1,455 bytes of still-unnamed WRAM bank `$05` text-engine buffers; the
  story character record's undeclared fields turned out to be read. The
  top 512 bytes of WRAM0 are the stack (`STACK_TOP` `$d000`, deepest reach
  `$cf34`) and are excluded.
* **2026-09-11** — `tools/extract.py --keep`: a re-extraction that leaves an
  edited file alone (a `.bin` or generated `.asm` that differs from the ROM,
  or a PNG that no longer encodes to its blob) and deletes nothing, so the
  tree can be regenerated around a modder's changes.
* **2026-09-11** — live twins are marked. `tools/twins.py` fingerprints the
  generated source and finds 64 groups of instruction-identical live
  routines, 279 in all (the shot solver's fifteen helpers in nine banks,
  `FetchText` in thirteen, the menu-cursor library in six, story-bank
  helpers, per-minigame handlers). Every member's note names its copies,
  39 whose names had drifted apart were renamed to one base plus bank
  suffix (`MoveMenuCursorBox` is `MoveMenuCursorGrid_38`,
  `PrintNumberString_3b` is `Unused_3b_DrawDecimalNumber`), and
  `docs/duplicated_code.md` lists the groups.
* **2026-09-11** — two modding fixes. Data files are named after their
  labels (`data/bank_040/AlexSpriteFrame00.png`, `lz_MenuFontTiles_01.bin`,
  `MatchResultPalettes.asm`; only unnamed blobs keep `d_XXXX`). And VRAM
  copy counts follow their blobs: the 92 whole copies of a decompressed
  stream are `ld c, Blob_SIZE / 16`, with the decoded length in a `.inc`
  that `make` derives from the blob (`lz.py --size-inc`), on top of the 34
  raw whole copies written `(Next - Blob) / 16`; 26 partial copies say
  which tiles of which blob they take. A plain PNG now grows its blob when
  drawn past its end, and an end-to-end edit (a tile added to
  `ConfirmScreenGfx3`) rebuilt with the copy at 33 tiles.
* **2026-09-11** — sprite frames in the PNGs are drawn assembled. A blob
  that is a run of frames carries a layout in the manifest (`gfx:2x2` for
  the 570 walk-sprite blobs, four 16x16 facings side by side; `gfx:3x4+3`
  and `gfx:4x4+4` for the 1,710 character frames, the 24x32 or 32x32 body
  as 4-tile columns with the standing-shadow tiles beneath), taken from the
  object queues' tile order rather than from templates, so it is a fixed
  permutation and encodes back exactly (`docs/graphics_formats.md` §0).
* **2026-09-11** — the last `db` fallbacks in the rendered data are gone.
  The 34 animation scripts that end on a byte the macros cannot spell (a
  hold's unread `$00` operand; the five-byte walk script whose bare loop
  command takes its operand from the next script's first byte) render as
  macros plus one commented `db` (`docs/graphics_formats.md` §4.4). The
  "padding byte" after `CharViewerSceneActors_1a` is the one-opcode
  `as_halt` script its four records point at, now `ActorScript_1a_CharViewer`;
  the one after `FireworkMapActors_14` is padding before the aligned tile
  blob, and is labelled as such.
* **2026-09-11** — a test suite, `make test` (`tests/`, stdlib `unittest`,
  47 tests): the codecs (LZ and tile-image round trips, the SM83 decoder's
  self-test, every idiom macro assembled and compared to the bytes it
  stands for), the emitter's idiom collapse and packed-argument rendering
  on synthetic listings, the curated inputs' structure (unique names, union
  bounds, flag and constant shapes), the analysis on a synthetic ROM
  (descent, the WRAM-bank dataflow through push/pop, the text-id walkers),
  and, when `baserom.gbc` is present, pins on the generated source and the
  analysis (instruction, macro, text-id and manifest counts, every curated
  label on an instruction start) plus `check.py` and `ram_gaps.py` runs.
  The last pin caught one stale curated label (`.fromCallerPtr` at
  `$38:$69aa`, inside an instruction, nothing referencing it), removed.
* **2026-09-11** — the PNG pipeline: the manifest tags the 2,724 blobs that
  are whole 8x8-tile graphics `gfx`, `extract.py` decodes each to a
  four-colour indexed PNG beside its `.bin` (LZ streams decompressed
  first, the tile count stored in the file), the Makefile re-encodes a blob
  whose PNG is newer, and `make check` round-trips every image. Editing a
  tile is now editing an image.
  Setting it up caught one mis-carve and one mis-name: the Academy Main
  Building interior's tile set (scene record 17, loaded by location 5 and
  the ending's Principal's Office) was a raw blob because its stream
  expands too little for the exact-extent promotion; a data-copy hook
  capture of that load classifies it, and the record family it belongs
  to, named `DormInterior*` until now, is `AcademyMainBldg*`.
* **2026-09-11** — packed call arguments: a raw `ld rr, $hhll` whose callee
  reads the pair as two bytes renders as `lb rr, $hh, $ll` with the halves
  named at the site (440 sites: palette index/count, sprite x/y and
  attr/tile, tilemap tile/count, text column/row, rect width/rows); a
  game-flag id handed to Set/Clear/TestGameFlag renders as
  `ld_flag_id de, FLAG_*` and one handed to a `*ByNumber` helper as the
  constant; `RunPagedTextMenu` joins the text-id sinks (13 menu ids named,
  605 → 619). The seventeen game flags that had no name are named for
  their only writers: the ending-seen pair `PlayScreenSequence2` tests and
  sets, the new-game pair `InitStoryModeState` writes, and the thirteen
  per-slot flags the unlock-everything cheat sets that nothing reads. Every
  game-flag operand in the source is symbolic now except three loop bases.
* **2026-09-11** — three idiom macros: `push_wram_bank N` / `pop_wram_bank`
  for the bank prologue and epilogue (351 / 452 sites), `ld_hl_indexed T`
  for the five-instruction split-base table index (414), and `wait_frames N`
  for WaitFramesCmd's inline argument (79). Each expands to the original
  bytes; a label or note landing inside a sequence keeps it raw.
* **2026-09-11** — the questions of intent, worked through: the three
  odd-sized palette regions were over-declared and hid a stray `ret`, a
  47-byte unreferenced firework reset and three padding bytes (carved);
  header bytes +2/+3 are a per-family constant; the scene record is read
  only to `+5`; the Star Court is granted by `CheckAllProgressComplete`
  once all 36 progress flags are set; the record fields are dead stores.
  Two genuine intent questions remain in the graphics doc.
* **2026-09-11** — two emulator experiments close the graphics doc's
  testable questions: the collision map is a 32 × 32 grid of 2 × 2-tile
  cells (the rounded `e * 16` is `(e >> 1) * 32`), drawn live it is the
  Tournament Courtyard; and the bank `$00` fade is a fade to white, seen
  mid-fade with the palettes at master + 20 per component.
* **2026-09-10** — the last 67 live sites, all on the desk: 39 story-script
  loads of actor slot 0/1 handed to helpers that select WRAM bank 4, the
  five digit-drawer copies, the link grid's handedness toggle, the screen
  sequence object list, the ring-shot chart, a scroll-buffer base and the
  char-data patch list, each a range scope on the union that already named
  the address; the ten ranking rows/markers no board argument selects,
  scoped on their traced siblings; and five more routines reachable only
  from the dead debug save flow or a farptr nothing calls, named Unused_.
  160 → 97, every one of them dead.
* **2026-09-10** — the DMG lockout screen, from a native trace of the ROM
  booted in DMG mode: the game hangs there, so the connector could not
  capture it, and on a DMG there is no WRAM bank register for the converter
  to read — the screen's five staging-buffer sites are scoped to the WRAM
  bank 1 union by range, the single upper WRAM half a DMG has. 165 → 160.
* **2026-09-10** — the desk pass after the emulator session: the cutscene
  text-scroll buffer, the continue prompt's tilemap rows, the link-error
  palette, the exhibition grid bits and the character-data blit sources
  named through range-scoped union variants; the bank `$18` sequence union
  no longer reaches into the dead confirm-label drawers; `ram_gaps --static`
  reports dataflow-known-but-unnamed sites (22 found, all resolved). 188 → 165
  bare banked operands, 72 of them live.
* **2026-09-10** — an emulator session: eleven coverage dumps under the v4
  connector (erase-confirm prompt, the N64 Tennis Data screens with a forged
  save block, the developer Test map's lesson menu, epilogue, ending credits
  and an Island Open singles match to its EXP screens). `ram_gaps` gained a
  `dead` bucket and sixteen unreferenced routines their `Unused_` names;
  seven new union variants name what the screens touch. Bare banked
  operands 230 → 188, of which 94 are live.
* **2026-09-10** — the text-id walker follows `push hl` / `pop hl` pairs, so
  `RenderProportionalTextAt` (which parks the id while it sets the glyph
  pointer) and the five caption helpers built on it count as consumers: 102
  more `ld hl, Text_*` sites, 503 → 605, every caption in the briefing,
  menu, link and clear-status screens named. A survey of the other forward
  walkers found one more gap — the load-site walk had no push/pop tracking,
  a five-instruction limit and only recognised `call` hand-offs — worth one
  site (606). `_scan_ptr_use` and the WRAM-bank dataflow already track the
  stack; the nine derived consumers that call something while the id sits
  in `hl` all call routines that park it (`push hl` first thing).
* **2026-09-10** — the desk pass over everything the docs had flagged as
  wrong: object-header word 1 renamed `AnimPtrs` and its 635 scripts rendered
  as `anim_*` macros; bank `$03`'s fade buffers renamed the right way round
  (`wPaletteFadeTarget` / `wPaletteFadeLive`, 16-byte mask, frame delay);
  the clear-status tool's flag writers renamed for what they clear and its
  menu state given its own union; the two "Maybe" routines renamed
  (`ApplyLinkRoleToWinLoseFlag`, `AiRollAimAwayFromChar`); three stray
  `ret`s carved in bank `$11`; `WRAMX_BASE` / `STACK_TOP` for the page
  clears; `gfxdump` palette sheet fixed; `docs/STATUS.md` split into this
  page and `docs/history.md`.
* **2026-08-08** — a native trace of the Island Open doubles semi-final: the
  ranking board reached, `BuildMatchResultTilemap` proven dead, 234 → 230
  unproven operands.
* **2026-08-07/08** — every raw address operand followed to its consumer;
  packed selectors rendered; `records:N:ptrK`; the last unbanked WRAM named.
* Earlier — see `docs/history.md`.

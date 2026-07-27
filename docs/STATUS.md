# Project status — 2026-07-26

## Where things stand

**~161.0K instructions / 424,745 bytes of proven code+structured source
(20.3% of the 2 MiB ROM) disassembled; everything rebuilds byte-perfect**
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

Everything below is **committed** (HEAD `1a37c90`); the whole history
rebuilds byte-perfect. Per-bank progress at any time: `python3
tools/progress.py` (proven-code bytes, fill runs, label counts, human-named
counts) and `tools/progress.py --unnamed <bank>` to list still-auto-named
symbols. **19,921 of 21,568 labels are human-named** (see the caveat in the
auto-split section below) (up from 4,816 on 2026-07-23); what is left is
data blobs.

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
        xor a, a
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
from the top. All 570 now render as `anim_*` macros rather than `INCBIN`
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
  render `DrillShotTable_0b_4b8d.rally1` -- worse than the auto name. Bank
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
by `$40` (`$6880`-`$7040`) that nothing in the ROM reads, now `Unused_1c_5679`.

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

`CharMugshotGfxPointers_1b_4cec` rendered as 72 rows of raw `dw $44b1, $4df8`
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
placeholders* (`Palette_18_42e0`, `Gfx_1c_7541`), not semantic names. They
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
ActorScript_0f_7b8d:
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
ActorList_04_4d63:
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
`actor_script` regions: `ActorScript_0e_7ca4`, `_7d0b`, `_7d72`, `_7ddb`,
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
`Unused_0d_5d2c` so the source states that rather than leaving a mystery
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
and Peach are 0). They are now split off as `Unused_02_441f`.

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

* **What are the 28 bytes of `Unused_02_441f`?** Nothing references them
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
category byte of `wCurrentMinigameStoryMatch`), `ObjectSpawnTable_18_7c53`
(16 × 11-byte descriptors), `CharMugshotGfxPointers_1b_4cec`, and the
`MatchUiTilemap{Tiles,Attrs}_0d` layer pair. Two blobs are name-only (kept as
INCBIN): `SelectionMaskGrid_3f_539e` (a `$00`/`$40`-delimited bitmask stream,
not fixed-stride) and `ObjectSpawnTable_18_7d88` (16 records + a mixed tail).
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
  absorbed into `ActorScript_11_6e07`'s run; declared `actor_script` +
  `ActorScript_11_6e16` so the `map_actor` resolves symbolically.

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
as frame data — renamed `ActorScript_27_51d0`. A sweep over all 238 script
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
ActorScript_0f_7b57, …`; overlapping defs (e.g. `$7b2f` inside `$7b25`'s blob)
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
`MoveCurveTable_09`, `VramGfxPtrTable_09_616d`, `ServeGfxPtrTable_09`.

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
`ld hl, Lz_1e_4c70` / `ld hl, Palettes_1e_4c40`, and palette sets render inline
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
as ordinary `as_*` walk-and-face scripts alongside `ActorScript_27_6bf0`.

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

`Unused_1c_5679`'s 32 rows were the one group worth looking at directly.
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

All work is committed (HEAD `1a37c90`); every commit rebuilds byte-perfect.
Gitignored: baserom.gbc, data/, build/, tools/rgbds/, *.o, *.gbc, *.sav.

## Tail calls, and three tables that lied about their length (2026-07-26)

The pointer work above left 132 bare addresses. **95 remain, and exactly one
`dw` pointer row is among them** -- `TangentTable` record 254, whose value
`$62ca` is a tangent, not an address.

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
`IsStarCharacter` and then gates on `$d814` -- the equipment-panel category
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
        add a, $4a      ; LOW(CharStatTable_07_5c4a)
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
`add a, LOW(Name)` / `adc a, HIGH(Name)`, assembling to the same bytes and
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

Verified by moving a table: growing a blob before `CharStatTable_07_5c4a` by
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
* **LabelScopes has to see the cut labels.** `Table_14_64d5` is a 12-byte table
  addressed at three different offsets, so the new labels split it into
  `Table_14_64d5` / `Data_14_64d9` / `Data_14_64dd`. The curated local
  `.scriptRespawnLocationActors` that follows was still being *spelled*
  `Table_14_64d5.scriptRespawnLocationActors`, because LabelScopes only saw the
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

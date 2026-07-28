# Bugs and dead code in the shipped game

Defects in Mario Tennis (GBC) itself, as distinct from mistakes in this
disassembly. Everything here is in the released cartridge and reproduces from
`baserom.gbc`.

A disassembly finds these for free — a routine that reads a byte nothing writes,
or writes one nothing reads, is obvious once every reference to an address can be
listed. It is worth separating three things that all *look* like defects, because
only the first is one:

* **Bugs** — the code does something other than what it plainly intends.
* **Dead stores** — a value is written and never read. Harmless, but usually the
  fossil of an edit, and occasionally the visible half of a bug.
* **Stubs** — code deliberately disabled, most often by inserting a `ret` at the
  top of a routine rather than deleting it. Not defects.

Cross-references point at `docs/STATUS.md` where a find is written up in more
detail.

## Bugs

### Grayscale conversion drops the blue channel

`ConvertColorToGrayscale` (bank `$1d`, `$7210`) splits a CGB colour into its
three components, then averages them:

```
        ld a, e / and $1f            ; red
        ld [$d000], a
        ...                          ; green
        ld [$d001], a
        ld a, d / and $7c / rrca / rrca   ; blue
        ld [rRAMG + 2], a            ; <- should be [$d002]
        ld a, [$d000]
        ld hl, $d001
        add [hl]
        inc hl                       ; -> $d002
        add [hl]
        srl a
```

The blue component is stored to `$0002` instead of `$d002` — a `d` dropped in the
original source. `$d002` is never written, so the average is red plus green plus
whatever the byte happened to hold, and every grayscale palette the routine
produces is wrong.

The stray write is not inert, though it is harmless in practice: `$0000-$1fff`
is the MBC5 cartridge-RAM gate, so the write sets the gate to the blue value's
low nibble (usually disabling SRAM, since only `$xa` enables it). Nothing breaks
because the save engine in bank `$03` always re-enables SRAM before touching it.

Recorded earlier in STATUS's 2026-07-17 naming pass, which called the write a
no-op; it is a RAM-gate write whose *effect* is benign. It renders as
`ld [rRAMG + 2], a` since the MBC registers were named, which makes it visibly
wrong rather than looking like an ordinary store to a low address.

### The save mirror re-check compares the wrong signature

The header region `$a000-$a7ff` is mirrored into SRAM bank 1 after every write.
On boot `ValidateSaveRam` (bank `$03`) checks the signature and master checksum;
on failure it restores bank 1's mirror and re-checks — but the re-check compares
the signature at `$a000` instead of `$a020`, so it always fails.

The recovery path is therefore dead: a corrupt header always falls through to a
full wipe and re-init, and the mirror it just restored is discarded. See
`docs/save_format.md`.

### The link-error check can never fire

`AdvanceFrame` (ROM0, `$2635`) guards every frame with:

```
        ldh a, [hLinkCounter]
        or a
        jr z, .linkOk
        ldh a, [hLinkErrorFlags]
        and $e0                  ; top three bits
        jp nz, LinkErrorReset
```

`hLinkErrorFlags` (`$ffc3`) is written in exactly two places, `InitSerialLink`
and `ResetSerialState`, and both clear it with `xor a`. No instruction in the
ROM ever sets any of its bits, so the `jp nz` is unreachable and the link never
resets through this path. Either the code that raised the flags was removed, or
it was never written.

### Match-select slot 8 launches the wrong match

On the singles match-select menu, slot 8 ("Varsity-S Rank 4") dispatches to a
duplicate of the Junior #3 launcher (`$0002`) rather than its own (`$000b`). The
handler is named `LoadMatchSinglesJunior3Alias` in this disassembly rather than
after its caption, because the caption is not what it does. See STATUS.

## Dead stores

Values written and never read. None of these change behaviour; they are listed
because each one is a loose end that a future reader will otherwise re-derive,
and because the class is worth watching — the grayscale bug above is a dead
store with a missing counterpart.

| symbol | where | note |
| --- | --- | --- |
| `wShotAimRow` | every shot bank | the aim row is computed, stored, and used from `a`; the store is a leftover |
| `wUnusedDrillPointStartByte` | bank `$0b` | cleared by `ServiceMatch2Hook_PointStart` |
| `wUnusedExitLocationMirror` | story engine | write-only mirror of `wStoryModeExitLocationRequest` |
| `wCharObjectDefId` | bank `$04` | the object-def id `SetupCharSpriteFromObjectDef` was handed |
| `hUnusedLinkByte`, `hUnusedLinkSlot` | serial init | cleared by both link init routines, read by nothing |
| `hLinkLastRxMirror` | bank `$07` | written beside `hLinkLastRxByte`, never compared |
| `hUnusedLinkSelectByte` | bank `$38` | written twice by `RunLinkCharSelectScreen` |

## Routines that return before their body

Twenty-four routines in the ROM are *called* but begin with `ret`, so their
bodies never run. Eighteen of them are one family, and they are listed here
rather than under Bugs because what they do is coherent — but the intent behind
them is not something the code can settle, so this section claims only what is
observable.

Each drill in bank `$0b` has four judging routines, one per hook, which pass an
event code to that drill's `JudgePoint`:

| routine | hook | event code |
| --- | --- | --- |
| `<Drill>JudgeOnPointEnd` | `Hook_PointEnd` | 0 |
| `<Drill>JudgeOnBallHit` | `Hook_BallHit` | 1 |
| `<Drill>JudgeOnBounce` | `Hook_Bounce` | 2 |
| `<Drill>JudgeOnRallyTick` | `Hook_RallyTick` | 3 |

`JudgePoint` dispatches on `wRallyLength` and then on the event code, and
returns early if `wDrillPointJudgement` is already set, so the first event to
judge a point wins.

18 of the 52 begin with `ret`, and **which** ones varies by drill:

* most drills disable only `JudgeOnRallyTick`;
* the serve and net-game match drills disable `JudgeOnBounce` as well;
* `ServiceMatch2` disables `JudgeOnBounce` but leaves `JudgeOnRallyTick` live.

So the effect is a per-drill choice of which events are allowed to score a
point, which is a sensible thing to vary between a serve drill and a stroke
drill. That the pattern differs per drill rather than being one blanket edit is
consistent with it being deliberate; it is not proof of it, and a leading `ret`
looks the same whether it was written as configuration or left behind by an
edit. Nothing else in the ROM distinguishes the two.

Several routines of the same shape elsewhere were named `StubNop_*` and
`StubLoadFontTiles` by earlier passes — those names carry the same assumption
and are worth re-examining on the same grounds.

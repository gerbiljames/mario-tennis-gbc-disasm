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
* **Routines that return before their body** — a `ret` at the top of a called
  routine. The effect is observable; whether it was written as configuration or
  left behind by an edit generally is not, so they are recorded rather than
  judged.

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

## A routine whose body is a no-op

`RewriteCutsceneCameraY_6b` (bank `$6b`, `$615e`) guards on
`wCutsceneStepTimer >= $14` and on `[$c323]` being nonzero, then does this:

```
        ld a, [$c323] / ld h, a       ; h = high byte
        ld a, [$c322] / ld l, a       ; l = low byte  ($c322 = wCameraY)
        ld a, h / ld [$c323], a       ; write h back
        ld a, l / ld [$c322], a       ; write l back
        ret
```

It reads the two camera bytes into `hl` and writes exactly those values back, so
past the guards the routine has no effect whatsoever. Whatever the write-back
was meant to transform -- a shift, an add, a clamp -- is not there.

Nothing calls it in any traced run, and no proven code takes its address, so it
may simply be an abandoned edit rather than a live no-op. It is recorded here
because the shape is a bug's fingerprint: the read/write-back pair is what a
read-modify-write looks like with the modify deleted. Found by seeding it as
code, which is why it read as 30 bytes of data until 2026-07-29.

## Routines that return before their body

Routines in the ROM that are *called* but begin with `ret`, so their bodies
never run. Twenty of them are one family, and they are listed here rather than
under Bugs because what they do is coherent — but the intent behind them is not
something the code can settle, so this section claims only what is observable.

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

Fifteen drills, four judges each, 20 of the 60 beginning with `ret` — and
**which** ones varies:

* 9 drills disable `JudgeOnRallyTick` only (the stroke and net-game practice
  drills);
* 5 disable `JudgeOnBounce` and `JudgeOnRallyTick` (`ServiceMatch1`/`3`,
  `NetGameMatch1`/`2`/`3`);
* 1 disables `JudgeOnBounce` while leaving `JudgeOnRallyTick` live
  (`ServiceMatch2`).

No drill disables `JudgeOnPointEnd` or `JudgeOnBallHit`.

So the effect is a per-drill choice of which events are allowed to score a
point, which is a sensible thing to vary between a serve drill and a stroke
drill. That the pattern differs per drill rather than being one blanket edit is
consistent with it being deliberate; it is not proof of it, and a leading `ret`
looks the same whether it was written as configuration or left behind by an
edit. Nothing else in the ROM distinguishes the two.

### The names were hiding some of them

Six routines of this shape were named after the `ret` rather than the body, and
two of those were drill judges — which is why the counts above were first
written as thirteen drills and 52 judges instead of fifteen and 60. They are
named for what they do now, with the leading `ret` recorded in the note:

| was | is | body |
| --- | --- | --- |
| `StubNop_0b_5d63` | `NetGamePractice1JudgeOnRallyTick` | the drill's fourth judge |
| `StubNop_0b_6ceb` | `StrokePractice1JudgeOnRallyTick` | the drill's fourth judge |
| `StubLoadFontTiles` | `LoadFontTiles` | copies `FontTiles` to `$9000` |
| `StubNop_1b_664a` | `LoadUnlockDebugNavGridGfx` | decompresses and uploads debug-screen artwork |
| `StubAlwaysNotZero` | `CheckExpAwardAllowed` | the EXP-award gate — see below |
| `StubNop_05_49dc` | `PagedMenuFrameTask` | a live frame task whose body has no effect |

The thirty other `StubNop_*` labels have a bare `ret` for a body and keep the
name, which for them is accurate.

`CheckExpAwardAllowed` is worth its own line. `AddExpToCa00RecordChecked` calls
it and returns on z, but it cannot return z: `xor a` / `dec a` sets the flags
from `$ff` and the following `ld a, c` restores the caller's `a` without
touching them. The gate always passes and the award always happens. Whatever
condition it was meant to test is not in the ROM.

`PagedMenuFrameTask` is the other interesting one: it is genuinely registered
per frame by `RunPagedTextMenuAutoSize` and unregistered when the menu closes,
so the plumbing around it is real — but the body reads `wMenuCursorRow` into `a`
and then `pop af` discards it. The task runs and does nothing.

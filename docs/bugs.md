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

## Stubs — deliberate, not defects

Twenty-four routines in the ROM are *called* but begin with `ret`, so their
bodies never run. Twenty of them are one family: the third and fourth shot
judgements of every drill.

```
ServiceMatch1JudgeShot2:
        ret
        ld a, $02
        call ServiceMatch1JudgePoint
        ld [wDrillPointJudgement], a
        ret
```

`ServiceMatch1JudgeShot2` and `JudgeShot3` are both called from
`ServiceMatch1Hook_PointEnd`, and the same pair is stubbed in
`ServiceMatch2/3`, `NetGameMatch1/2/3`, `NetGamePractice2/3` and
`StrokeMatch1/2/3` — so a drill only ever judges shots 0 and 1.

That this is systematic across every drill, rather than appearing once, is what
says it is a decision and not an accident; several of the same shape elsewhere
were already named `StubNop_*` and `StubLoadFontTiles` by earlier passes. The
bodies are kept here rather than cut, because what they would have done is part
of what the drill system was designed to do.

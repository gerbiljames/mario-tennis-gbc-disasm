# Bank 0 annotation notes

Routines identified in bank 0 (`src/home/`, with the sound driver in
`src/audio/*_00.asm`, all included by `src/bank_000.asm`).
Bank 0 is the fixed home bank: it holds the reset vectors, all interrupt
handlers, the far-call/bank-switch trampolines, core memory/VRAM/OAM
helpers, the joypad driver, the sound engine, and the soft-reset routine
that the VBlank handler jumps to when it detects the reset button combo.

## Engine structure

- `Rst00` (`$0000`) jumps to `JumpTableDispatch` (`$06c4`), a classic
  `rst $00` jump-table dispatcher: it pops the return address (which
  points at a table of `dw` targets right after the `rst 0` call site),
  indexes it by `a * 2`, loads the target address, and falls into
  `JumpToHL` (`$06ce`, `jp hl`).
- `Rst18` jumps to `FarCall` (`$01b6`), the bank-switch "far call"
  trampoline (the `farcall` macro): it reads two inline bytes after the
  `rst` -- a slot in the target bank's `$4000` pointer table, then the
  bank -- saves/restores the ROM bank shadow byte at `$ff95` and the
  `$2000` MBC bank register, and calls through that slot. The bytes at
  `$0010` are also a `jp FarCall`, but they sit unlabelled inside the
  padding under `Rst08` and nothing executes `rst $10`.
  `CopyDataFromBank` (`$021a`) and `DecompressDataFromBank` (`$0234`)
  are the same bank-switch-then-call pattern, but take the bank in `h`
  and the `$4000`-table slot in `l` instead of inline bytes, used to
  fetch a `CopyMemoryBC`/`DecompressData` routine's arguments from
  another bank.
- `Rst08` reaches `PlaySoundCmd` (`$2fb3`), which reads one inline
  sound-id byte after the call site (the `sound` macro) and dispatches
  into the sound engine — the sound-effect/music trigger call.
- The three low interrupt vectors (`VBlankInterrupt` $0040,
  `LCDStatInterrupt` $0048, `TimerInterrupt` $0050) each just `jp` to
  their real handler bodies, which are now named `VBlankHandler`
  (`$2749`), `LCDStatHandler` (`$27f5`) and `TimerHandler` (`$27d7`).
  `VBlankHandler` is the busiest: it applies scroll/window changes,
  runs `ApplyPendingPaletteUpdates`, flushes queued VRAM DMA transfers,
  polls the joypad (`ReadJoypad`), and — if the current buttons read
  `$0f` — jumps to `SoftReset` (`$2582`), which reinitializes the
  stack, LCD, HRAM/VRAM, OAM DMA stub, sound engine and interrupts from
  scratch (this is the classic all-face-buttons soft-reset combo).
- `SoftReset` calls `CopyOAMDMARoutineToHRAM` (`$06ac`), which copies a
  10-byte OAM DMA stub into HRAM at `$ff80`; the VBlank handler later
  does `call $ff80` to kick off sprite DMA every frame, since OAM DMA
  code must execute from HRAM.

## Named routines

| Name | Address | Purpose |
|---|---|---|
| `FarCall` | `$01b6` | Bank-switch trampoline used by `rst $18` (`farcall`); saves/restores the ROM bank via `$ff95`/`$2000` around a far call. |
| `CopyDataFromBank` | `$021a` | Switches to bank `h`, looks up a pointer in a table at `$4000`, and memcpy's via `CopyMemoryBC`. |
| `DecompressDataFromBank` | `$0234` | Same as above but decompresses via `DecompressData`. |
| `ClearBothVRAMBanks` | `$024e` | Clears a full 8 KB VRAM bank (`$8000`-`$9fff`) in both GBC VRAM banks (VBK 1 then VBK 0). |
| `LoadBGPaletteData` | `$027f` | Copies 64 bytes to `rBGPD` with auto-increment — loads the full BG palette RAM. |
| `LoadOBJPaletteData` | `$0287` | Same as above but for `rOBPD` (OBJ palette RAM). |
| `SwitchCPUSpeed` | `$02a3` | The standard GBC double-speed switch sequence: check `rSPD` bit 7, arm the switch, disable interrupts/joypad matrix, `stop`. |
| `ReadJoypad` | `$02eb` | Polls `rJOYP` with the `$20`/`$10` nibble selects, combines D-pad/buttons, and updates held/pressed/repeat state bytes. |
| `DisableLCDSafely` | `$0346` | Waits for `rLY == $91`, then clears `rLCDC` bit 7, following the documented safe-LCD-off procedure. |
| `EnableLCD` | `$0376` | Sets `rLCDC` bit 7, hides the unused OAM slots (`ClearUnusedSprites`) and clears `hVBlankOccurred`. |
| `ClearVRAMBank` | `$0383` | Clears the 8 KB of VRAM; on CGB (`hIsCGB`) it clears both banks via `ClearBothVRAMBanks`. |
| `ClearBytes` | `$03a7` | Simple `bc`-counted byte-at-a-time zero-fill loop. |
| `ClearMemory16` | `$03af` | Zero-fill loop, unrolled 16x per iteration, counted by `c` (chunks of 16 bytes). |
| `ClearMemoryBC16` | `$03c4` | Same unrolled zero-fill body but counted by 16-bit `bc`; used to clear a full VRAM bank. |
| `CopyMemoryBC` | `$03db` | `hl`→`de` memcpy counted by `bc`. |
| `CopyMemoryFast` | `$03f3` | `hl`→`de` memcpy with an alignment-optimized unrolled path. |
| `ApplyPendingPaletteUpdates` | `$060d` | Checks flag bits and re-applies queued BG/OBJ palette writes via `LoadBGPaletteData`/`LoadOBJPaletteData`. |
| `CopyOAMDMARoutineToHRAM` | `$06ac` | Copies the 10-byte OAM DMA transfer stub into HRAM at `$ff80`. |
| `JumpTableDispatch` | `$06c4` | `rst $00` jump-table dispatcher: indexes a `dw` table following the call site by `a`. |
| `JumpToHL` | `$06ce` | Tail of `JumpTableDispatch`; plain `jp hl`. |
| `DecompressData` | `$1797` | Bit-stream/back-reference decompressor (literal vs. copy-from-earlier-in-output control bits) — an LZ-style decompressor used for compressed tile/map data. |
| `FormatHexWord` | `$1935` | Converts `hl` into 4 ASCII hex digit characters (+ null terminator) written to `[de]`; a debug/number-display helper. |
| `StartVRAMDMATransfer` | `$18d7` | Programs the GBC HDMA registers (`rVDMA_SRC_HIGH` etc.) with `bc`=source, `de`=dest, `a`=length/mode to start a VRAM DMA transfer. |
| `SoftReset` | `$2582` | Full hardware re-init (stack, LCD off, VRAM/HRAM clear, OAM DMA stub, sound engine, interrupts) triggered by the reset button combo. |
| `VBlankHandler` | `$2749` | Body of the VBlank interrupt: scroll/window updates, palette flush, VRAM DMA flush, joypad read, soft-reset check. |
| `TimerHandler` | `$27d7` | Body of the Timer interrupt: services the sound engine when the LCD is off or serial transfer is pending. |
| `LCDStatHandler` | `$27f5` | Body of the LCD STAT interrupt: split-scroll effect that changes `rSCX` partway down the screen based on `rLY`. |
| `UpdateSoundEngine` | `$2f1a` | Gated per-frame sound engine tick (guards against re-entry with a busy flag). |
| `InitAudioEngine` | `$3078` | One-time sound hardware init: enables `rAUDENA`, clears `rAUDTERM`, sets `rAUDVOL`, clears wave/channel RAM. |
| `StopMusic` | `$3129` | Silences the four *music* channels (blocks 2-5) by writing `$ff` into their channel state RAM. Effects are unaffected; sound id `$50` stops those. |
| `PlaySound` | `$3297` | Starts the sound or song whose id is in `a`. One id space split at `$50`: `$01`-`$32` are music (`MusicIndexTable`, `$3151`), `$51`-`$c1` effects (`SfxIndexTable`, `$31b5`); id 0 stops the music via `StopMusic`, id `$50` stops the effects. |
| `RunSoundEngine` | `$3373` | Per-tick driver: mirrors each channel's state to HRAM `$ffd0`, runs the effect chain, steps the script. See [sound_engine.md](sound_engine.md). |
| `RunSoundChannelScript` | `$3558` | Script interpreter — decodes one command opcode (`$00`-`$ef`) per note step. |
| `SndTriggerNote` | `$3864` | Note-on: computes the APU period and keys the channel. |
| `TickInstrumentEnvelope` | `$3a40` | Per-tick: advances the `hSndInstrument`-selected volume-envelope sequence. |

The bank-0 music/SFX driver (`$3078`-`$3ddf`) is documented in full — channel
state block, HRAM working set, per-pass globals, and the command set — in
[docs/sound_engine.md](sound_engine.md).

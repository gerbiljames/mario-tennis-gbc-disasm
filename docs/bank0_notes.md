# Bank 0 notes

Bank 0 is the fixed home bank (`src/home/`, with the sound driver in
`src/audio/*_00.asm`, all included by `src/bank_000.asm`): the reset and
interrupt vectors, the far-call trampolines, memory/VRAM/OAM helpers, the
joypad driver, the sound engine ([sound_engine.md](sound_engine.md)) and
the soft reset.

## Engine structure

- `Rst00` (`$0000`) jumps to `JumpTableDispatch` (`$06c4`): it pops the
  return address, which points at a `dw` table right after the `rst 0`,
  indexes it by `a * 2` and falls into `JumpToHL` (`$06ce`, `jp hl`).
- `Rst18` jumps to `FarCall` (`$01b6`, the `farcall` macro): it reads two
  inline bytes after the `rst` -- a slot in the target bank's `$4000` pointer
  table, then the bank -- and calls through that slot, saving and restoring
  the ROM bank shadow at `$ff95` and the `$2000` MBC register. The bytes at
  `$0010` are also a `jp FarCall`, but they sit unlabelled in the padding
  under `Rst08` and nothing executes `rst $10`. `CopyDataFromBank` and
  `DecompressDataFromBank` are the same pattern with the bank in `h` and the
  slot in `l` instead of inline bytes, fetching a `CopyMemoryBC` /
  `DecompressData` routine's arguments from another bank.
- `Rst08` reaches `PlaySoundCmd` (`$2fb3`), which reads one inline sound-id
  byte (the `sound` macro) and dispatches into the sound engine.
- The interrupt vectors (`VBlankInterrupt` `$0040`, `LCDStatInterrupt`
  `$0048`, `TimerInterrupt` `$0050`) each `jp` to their handler body. The
  VBlank handler applies scroll/window changes, runs
  `ApplyPendingPaletteUpdates`, flushes queued VRAM DMA, reads the joypad,
  calls the OAM DMA stub at `$ff80`, and jumps to `SoftReset` when the
  buttons read `$0f` (the all-face-buttons combo).
- `SoftReset` reinitialises the stack, LCD, HRAM/VRAM, sound engine and
  interrupts, and calls `CopyOAMDMARoutineToHRAM` to put the 10-byte OAM DMA
  stub at `$ff80`, since OAM DMA code must run from HRAM.

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

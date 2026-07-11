# Mario Tennis (GBC) disassembly

A disassembly of **Mario Tennis (USA)** for the Game Boy Color, built with
[RGBDS](https://rgbds.gbdev.io/).

The repository contains **no copyrighted ROM content**. All game data
(graphics, audio, text, and any code not yet analyzed) is extracted from a
user-supplied base ROM at setup time, and the build reproduces that ROM
byte-for-byte.

## Building

1. Obtain a legal copy of Mario Tennis (USA). Expected file:
   - SHA-1 `414ba58340a27fc27b127bc01455b32764151ff0` (2,097,152 bytes,
     `CGBTENNIS`, MBC5+RAM+BATTERY)
2. Install [RGBDS](https://rgbds.gbdev.io/install) (or place its binaries in
   `tools/rgbds/`; the Makefile looks there by default — override with
   `make RGBDS=`). Requires v1.0.0 or newer; `.rgbds-version` records the
   version the byte-perfect build is verified against, and `rgbdscheck.asm`
   fails the build early on older assemblers.
3. Extract the data and build:

   ```sh
   ./setup.sh path/to/rom.gbc   # verifies the ROM, populates data/
   make                         # builds mariotennis.gbc
   make compare                 # confirms SHA-1 matches the original
   ```

## Layout

- `src/bank_XXX.asm` — one file per 16 KiB ROM bank (128 banks). Proven code
  is disassembled; everything else is an `INCBIN` of a blob in `data/`,
  except long constant-byte padding runs (`$ff`, and `$00` past 256 bytes),
  which are emitted as `ds` fill directives — unused ROM space, visible as
  such in the source. Pointer tables (`FarPtr`/`DataPtr`/jump tables) and the
  sprite/object records of the `$6a`/`$6f`/`$70`-`$77` banks — the 16-byte
  headers (`db` count/flags + `dw` body pointers), their inline `.frames`
  pointer arrays, and the `OamPtrs` arrays they reach — render as in-source
  `dw`/`db` structure. That is layout metadata, not bulk data, so the frame
  graphics and OAM data those pointers target stay in the extracted
  (gitignored) blobs.
- `data.manifest` — offset/length list consumed by `tools/extract.py` to
  slice the base ROM into `data/` (gitignored).
- `labels.json` — symbol name overrides (`{"0x1234": "SomeName"}`, keys are
  flat ROM offsets) applied on regeneration.
- `data_tables.json` — render overrides for carved data tables
  (`{"0x1234": "palettes"}`, keys are flat ROM offsets); `disasm.py` renders
  the region inline as readable structured `db`/`dw` source (committed in the
  bank `.asm`) instead of a raw INCBIN blob. Kinds: `palettes` (BGR555 `dw`
  colors), `records:N` (fixed N-byte records), `bytes:C` (byte table, C per
  row).
- `include/hardware.inc` — standard Game Boy hardware definitions (CC0).
- `tools/` — the disassembly tooling (see below).

## Workflow: growing the disassembly

Code is identified by **execution coverage** from a real run of the game, not
guesswork: addresses that the CPU actually executed are code, and a
conservative recursive descent extends them through direct branch targets
within the same bank. Everything unproven stays data.

### Option A: BizHawk's native Trace Logger (fastest gameplay)

1. Tools → Trace Logger → log **to file** (not the window — its scrollback is
   truncated), play, stop logging. Expect roughly 60 MB per emulated second.
2. Convert the log: `python3 tools/tracelog2cov.py baserom.gbc trace.log
   coverage/<name>.json`. Banked addresses are resolved by matching the
   logged opcode bytes against every bank, intersected across instruction
   runs; lines corrupted by OAM-DMA bus conflicts or the halt bug are
   rejected by the byte check.
3. Regenerate (below).

### Option B: the `gbc-disasm` Lua connector / MCP server

Slower during gameplay (the per-instruction Lua hook costs ~4x realtime) but
needs no log files:

1. Load the ROM in BizHawk with the connector script running.
2. Start a trace (`trace_start`), play the game (menus, matches, modes —
   more variety means more code coverage), then write the coverage with
   `dump_coverage` to an absolute path in `coverage/` (the Lua writes the
   JSON file directly; `get_coverage` is only needed for summaries).
3. Regenerate and verify:

   ```sh
   python3 tools/disasm.py baserom.gbc coverage/*.json
   python3 tools/extract.py baserom.gbc data.manifest data/
   make clean && make compare
   ```

Regeneration overwrites `src/`, so durable annotations belong in
`labels.json` (names) or in the generator, not in hand-edits to `src/`.

Note on the tracer's address format: raw coverage values are **flat ROM
offsets** (`banked` pairs reassemble as `tag*0x10000 + value`); values at
`$ff00+` in `fixed` are HRAM execution (the OAM DMA stub), not ROM. This was
validated by decode-chain scoring in `tools/disasm.py`'s loader.

## Tools

- `tools/sm83.py` — exhaustive SM83 decoder emitting RGBDS syntax that
  round-trips byte-exactly through rgbasm (verified encodings: `ldh` vs `ld`,
  `stop` padding, no auto-`nop` after `halt`, two-operand ALU forms).
- `tools/disasm.py` — coverage + ROM → `src/*.asm` + `data.manifest`. Besides
  code, it classifies `$4000` pointer-table slots holding *data* pointers:
  call sites of `CopyDataFromBank`/`DecompressDataFromBank` are backtracked
  for constant `h = bank, l = slot` setups, and remaining slots in proven
  table extents are accepted when their pointer decodes as a valid LZ stream
  overlapping no code. Proven blobs get `Data_`/`Lz_` labels and exact-extent
  INCBINs (stream length for LZ, `bc` for copies).
- `tools/lz.py` — codec for the game's LZ format (used by `DecompressData`,
  `$1797`); also a CLI to decompress a stream from the ROM for inspection.
- `tools/strings.py` — dumps the game text (ASCII; `$01` line break, `$02`
  page break, `$03`/`$00` terminators) from the user's ROM for local
  inspection. Text regions are emitted as generated `data/*/text_*.asm`
  source: the per-bank string index tables as label arithmetic
  (`dw .sN - .strings`) and the strings via the `text`/`line`/`page`/`done`
  macros — readable and editable (the tables recompute on edit), while the
  strings themselves stay out of the repository like all other ROM content.
- `tools/extract.py` — `data.manifest` + base ROM → `data/` blobs.
- `tools/tracelog2cov.py` — BizHawk native Trace Logger file → coverage JSON.
- `tools/progress.py` — per-bank report of proven-code bytes and label-naming
  progress (`--unnamed XX` lists a bank's auto-named symbols).
- `tools/gfxdump.py` — renders every carved LZ stream to PNG contact sheets
  (2bpp tiles, palette swatches, `--composites` for tilemap×tilesheet
  pairing) under gitignored `data/gfx/` for identifying and naming assets.
- `tools/hook_client.py` — captures the arguments of every distinct
  `CopyDataFromBank`/`DecompressDataFromBank` call while the game runs
  (connector script v2+ register hooks), i.e. the pointer-table slots that
  dynamically-computed call sites consume. Feed dumps back with
  `tools/disasm.py --hooks hooks/*.json`; they classify table slots the
  static backtracking can't reach.
- `tools/trace_client.py` — standalone client for the BizHawk connector
  (note: the connector accepts a single client; disconnect the MCP server
  first).

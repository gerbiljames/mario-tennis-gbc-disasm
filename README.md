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

## Modding

The build is a normal RGBDS project, so a change is an edit plus `make`; only
`make compare` (which asserts the original SHA-1) is expected to fail after
one. What makes edits *safe* is that the layout is recomputed rather than
restated:

- **Code and data may change size.** Pointers are symbols, so inserting bytes
  moves what follows and every reference follows it. Each bank's section stops
  at its last real byte and `rgblink -p 0xff` pads the rest, so the trailing
  space (185 KiB across 122 banks) is free for new code.
- **Text.** Edit the strings in `data/<bank>/text_pool_*.asm`; the per-bank
  offset table is `dw Pool.sN - Pool` in the bank source, so the assembler
  recomputes every offset. Find a string with
  `tools/strings.py baserom.gbc --index --bank <bank>`.
- **Compressed graphics.** `tools/lz.py rom <offset> out.bin` to decode,
  edit, `tools/lz.py -c out.bin data/<bank>/lz_<addr>.bin` to encode back. The
  new stream need not be the same size.
- **Tables.** Stats, physics constants, mode hooks, map actors and animation
  scripts render as structured source with named fields — see docs/STATUS.md.
- **Copy counts follow their source.** A VRAM copy whose length equalled its
  blob's size is written `ld c, (Next - Blob) / 16`, so growing the blob copies
  the extra tiles instead of silently truncating.
- **The header is fixed up.** `make` runs `rgbfix -v`, so editing the title or
  cart type cannot leave a header checksum the CGB boot ROM rejects. It changes
  nothing in the unmodified build, which is why `make compare` still holds.

`make check` verifies the structural claims a byte-perfect build cannot: that
every declared LZ stream decodes inside its extent and survives a re-encode,
that no symbol sits inside a compressed stream (which would truncate it), that
every text offset table addresses real strings in its pool, that every
`constants.json` immediate lands on an instruction actually holding that value,
and that the extracted regions stay in-bank and do not overlap.

The constants check exists because that one failure is otherwise invisible: an
entry is keyed by the flat ROM offset of the instruction
(`bank * 0x4000 + cpu - 0x4000`), and an offset off by one — or one pointing
into a data blob — renders nothing at all while the build still matches the
ROM. The symptom is a name that silently never appears.

One caveat: `data/` is generated, so `./setup.sh` and `tools/extract.py`
overwrite it (and now delete files the manifest no longer lists). Keep modified
assets outside the tree and copy them in, or do not re-run extraction.

## Layout

- `src/bank_XXX.asm` — one file per 16 KiB ROM bank (128 banks). Proven code
  is disassembled; everything else is an `INCBIN` of a blob in `data/`,
  except long constant-byte padding runs (`$ff`, and `$00` past 256 bytes),
  which are emitted as `ds` fill directives — unused ROM space, visible as
  such in the source. Trailing `$ff` fill is the exception: a bank's section
  simply stops at its last real byte and `rgblink -p 0xff` pads the rest, so
  carving at the end of a bank needs no fill-count bookkeeping. Pointer tables (`FarPtr`/`DataPtr`/jump tables) and the
  sprite/object records of the `$6a`/`$6f`/`$70`-`$77` banks — the 16-byte
  headers (`db` count/flags + `dw` body pointers), their inline `.frames`
  pointer arrays, and the `<record>_OamPtrs` arrays they reach — render as in-source
  `dw`/`db` structure. That is layout metadata, not bulk data, so the frame
  graphics and OAM data those pointers target stay in the extracted
  (gitignored) blobs.
- `data.manifest` — offset/length list consumed by `tools/extract.py` to
  slice the base ROM into `data/` (gitignored).
- `labels.json` — symbol name overrides (`{"0x1234": "SomeName"}`, keys are
  flat ROM offsets) applied on regeneration. A value may instead be
  `{"name": ..., "note": ...}`; the note is rendered as a comment block
  immediately above the label, which is where an explanation of a routine
  belongs — what it does, what its arguments mean, what is wrong with it.
  Newlines in the note become separate comment lines and a blank line becomes
  a bare `;`. A name beginning with a dot
  (`".copyLoop"`) is an RGBDS local label: it names a jump target *inside* a
  function, scoped to the function it sits in. The emitter writes `.copyLoop:`
  at the definition and spells references from other functions
  `Parent.copyLoop`, so a local name only has to be unique within its own
  function.
- `data_tables.json` — render overrides for carved data tables
  (`{"0x1234": "palettes"}`, keys are flat ROM offsets); `disasm.py` renders
  the region as readable structured `db`/`dw` source instead of a raw INCBIN
  blob. Most kinds render inline in the bank `.asm`, because their rows are
  layout the assembler recomputes (label arithmetic, pointer symbols, record
  structure). Kinds listed in `GENERATED_SPECS` are different: their rows are
  ROM *values*, so — like game text — they are generated into the gitignored
  `data/` tree at setup and `INCLUDE`d, keeping that content out of the
  repository. `palettes` (BGR555 `dw` colors), `sound_index` (the sound-id
  directory) and `sound_data` (the driver's pitch/envelope/mask tables) are
  generated this way. Inline kinds: `records:N` (fixed N-byte records),
  `ram_ptrs:<wram bank>[:<zero name>]` (a `dw` table whose words are RAM
  addresses rather than ROM pointers — the bank has to be stated because a
  data word has no dataflow for `compute_wram_bank` to read; bank `0` asserts
  nothing, for WRAM0 or where a ROM-bank-scoped union already covers the
  addresses), `bytes:C` (byte table, C per
  row), `ascii` (a quoted string), `font_glyph` (a `db width, height` glyph
  record, drawn as pixel art in the comments), `cart_header` (the header
  fields after the Nintendo logo), `pattern` (a repeated byte pattern, as one
  `ds count, v1, v2, ...`), `fill` (padding, rendered as `ds` runs).
- `include/hardware.inc` — standard Game Boy hardware definitions (CC0).
- `docs/` — `STATUS.md` is the running log of what has been worked out and how;
  `bugs.md` collects defects in the *game* (as opposed to in this disassembly),
  with the dead stores and deliberately-stubbed routines kept separate from
  them; `save_format.md`, `ram_map.md`, `sound_engine.md`, `actor_script.md`
  and `bank0_notes.md` document one subsystem each.
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
`labels.json` (names, and prose via its `note` field), `ram_map.json` /
`ram_unions.json` (RAM symbols and their notes), or the generator — not in
hand-edits to `src/`.

Note on the tracer's address format: raw coverage values are **flat ROM
offsets** (`banked` pairs reassemble as `tag*0x10000 + value`); values at
`$ff00+` in `fixed` are HRAM execution (the OAM DMA stub), not ROM. This was
validated by decode-chain scoring in `tools/disasm.py`'s loader.

## Tools

- `tools/sm83.py` — exhaustive SM83 decoder emitting RGBDS syntax that
  round-trips byte-exactly through rgbasm (verified encodings: `ldh` vs `ld`,
  `stop` padding, no auto-`nop` after `halt`, short-form ALU ops).
- `tools/disasm.py` — coverage + ROM → `src/*.asm` + `data.manifest`. Besides
  code, it classifies `$4000` pointer-table slots holding *data* pointers:
  call sites of `CopyDataFromBank`/`DecompressDataFromBank` are backtracked
  for constant `h = bank, l = slot` setups, and remaining slots in proven
  table extents are accepted when their pointer decodes as a valid LZ stream
  overlapping no code. Proven blobs get `Data_`/`Lz_` labels and exact-extent
  INCBINs (stream length for LZ, `bc` for copies). A blob with exactly one owner
  is named after that owner rather than after its offset — a sprite template
  after the routine whose `ld hl` loads it
  (`DrawMinigameTarget_SpriteTemplate`), an OAM pointer array after its object
  header (`WalkSprite_70_00_OamPtrs`) — so no generated name states an address
  that inserting bytes ahead of it would falsify.
- `tools/disasmlib/` — the generator itself; `disasm.py` is only its command
  line. Three stages, in `pipeline.py` order: **analysis** (`core.py` decoding
  and descent, `slots.py` data-slot proving, `carve.py` structure carving, all
  composed onto one object in `disassembly.py`), **naming** (`labels.py`,
  `ram.py`, `config.py`), and **emission** (`emit.py`, with the renderers in
  `operands.py`, `idioms.py`, `datatables.py`, `macros.py`). The package
  docstring has the full module map.
- `tools/lz.py` — codec for the game's LZ format (used by `DecompressData`,
  `$1797`), **both directions**. `lz.py rom <offset> [out]` decodes a stream;
  `lz.py -c <in> <out>` encodes one the game reads back, which is what makes
  the compressed graphics editable. The encoder is verified by round-tripping
  all 619 streams in the ROM, and its output totals 99.98% of the original
  encoder's size.
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

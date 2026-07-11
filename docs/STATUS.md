# Project status — 2026-07-11

## Where things stand

**~117K instructions / 247,098 bytes of proven code (11.8% of the 2 MiB ROM)
disassembled; everything rebuilds byte-perfect** (`make compare` → OK against
SHA-1 `414ba58340a27fc27b127bc01455b32764151ff0`). 59 of 128 banks contain
code; the other 69 are data (graphics/audio/tilemaps/text) — but most of that
data is now *carved into named streams and records* rather than left as
anonymous blobs. The repo contains no ROM bytes: all data is extracted from a
user-supplied `baserom.gbc` by `./setup.sh` per `data.manifest`.

Everything below is **committed** (HEAD `42a301b`); the whole history rebuilds
byte-perfect. Per-bank progress at any time: `python3 tools/progress.py`
(proven-code bytes, fill runs, label counts, human-named counts) and
`tools/progress.py --unnamed <bank>` to list still-auto-named symbols.

### Code structure — solved conventions

**Farcall convention:** `rst $18` + two inline operand bytes (`db slot, bank`)
dispatch through a per-bank pointer table at $4000 via the FarCall trampoline
($01b6). `tools/disasm.py` emits these as `farcall FarPtr_bb_ss` (macro in
`include/macros.inc`), renders the tables as labeled `dw` entries, and seeds
descent from every table target. This gave the cross-bank call graph.
6,441 farcall sites. `infer_tables()` exploits the self-delimiting layout of
dense banks to recover unused entries (+24 KB of statically proven code).

**All rst vectors decoded** as inline-operand pseudo-ops (macros in
include/macros.inc):
- `rst $00` → JumpTableDispatch ($06c4): inline `dw` jump table, indexed by `a`.
- `rst $08` → sound/music command ($2fb3), one id byte: `sound $xx` (451 sites).
- `rst $20/$28/$30` → three commands sharing an operand fetcher ($253d) that
  reads an inline `dw` pointer into de: `rst20/rst28/rst30 $xxxx`.
- `Func_00_07c5` is a register-based far dispatcher — runtime-computed, not
  statically exploitable.

**Twin data banks:** groups of data banks carry relocated copies of the same
bank-local helper, dispatched via farcall slot 0. Confirmed: an OAM-frame
loader in $1f/$25/$26/$30-$37/$5e/$6e (one bank per character's animation
frames); `infer_twin_tables()` fingerprints slot-0 targets by opcode shape.

Largest code banks: $08 (match engine, 94.7% code), $05, $00, $13 (story
engine), $6b, $03 (save engine), $0a, $07.

### Data banks — carved and named

- **30 character-sprite banks ($40-$5d)** named after their owners (Mario,
  Peach, etc.); $5a is the **training ball machine**, not a character.
- **Sound banks** ($0c, $78-$7f) and **walk-sprite banks** ($6a, $6f, $77)
  carved.
- **Menu / court / cutscene graphics streams** named; `tools/gfxdump.py`
  renders PNG contact sheets of the carved LZ streams for identification.
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
   (RetroAchievements-documented RAM → `include/ram_constants.asm`). Fails
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

**Human-named symbols: 380 of 14,882 labels** (`tools/progress.py`; the rest
are auto-generated `Func_/Label_/FarPtr_` names). Bank 0: 52 named routines
(docs/bank0_notes.md) — FarCall trampoline, OAM DMA stub, joypad, LZ
decompressor, sound engine entries, SoftReset, interrupt handlers. Bank 3:
save engine (23 named, docs/save_format.md). RAM: docs/ram_map.md (129
RetroAchievements-sourced entries). Data banks: character/sound/walk-sprite/
graphics streams named as above.

Next annotation targets: bank $08 (match engine, biggest & densest code bank),
bank $13 (biggest story bank), bank $1e, sound-command enum for the 451
`sound $xx` sites, WRAM map expansion from ram_map gaps.

## Repo state

All work is committed (HEAD `42a301b`); every commit rebuilds byte-perfect.
Gitignored: baserom.gbc, data/, build/, tools/rgbds/, *.o, *.gbc, *.sav.

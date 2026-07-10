# Project status — 2026-07-10

## Where things stand

**116,972 instructions (~221 KB of code) disassembled across 65 of 128 banks;
everything rebuilds byte-perfect** (`make compare` → OK against SHA-1
`414ba58340a27fc27b127bc01455b32764151ff0`). The remaining banks are so far
pure data (graphics/audio/tilemaps). The repo contains no ROM bytes: all data
is extracted from a user-supplied `baserom.gbc` by `./setup.sh` per
`data.manifest`.

**Farcall convention decoded (2026-07-10):** `rst $18` + two inline operand
bytes (`db slot, bank`) dispatch through a per-bank pointer table at $4000
via the FarCall trampoline ($01b6). `tools/disasm.py` now emits these as
`farcall FarPtr_bb_ss` (macro in `include/macros.inc`, expands to identical
bytes via `LOW()`/`BANK()`), renders the tables as labeled `dw` entries, and
uses every table target as a static descent seed — that alone added ~14.6 KB
of code (first code in banks $43, $5f, $6b) and gave us the cross-bank call
graph. 6,441 farcall sites, 3 fall back to raw bytes (slot bytes overlap
misdecoded code). The old instruction count (105,327) isn't comparable:
each farcall site now counts as one 3-byte pseudo-op instead of 1-3 bogus
ops decoded from its operand bytes.

**Table inference (2026-07-10):** the tables are contiguous and (in dense
banks) self-delimiting — the lowest pointer target is the first byte after
the table. `infer_tables()` exploits this: interior gaps between used slots
are always inferable; the extension past the last used slot is inferred
only when the bank's lowest used target lands within the one-byte slot
window ($4000-$4100), shrunk to a fixed point where every entry points
at-or-after the table end. 199 unused entries inferred (135 new code
seeds) → +12,470 instructions / ~24 KB more static code, biggest gains in
banks $05, $38, $1a, $03, $07. Banks with no delimitation evidence
(sparse single-slot tables like $20-$37, $43, $5f) are left alone.

**All rst vectors decoded (2026-07-10).** Every rst is an inline-operand
construct, now emitted as pseudo-ops (macros in include/macros.inc):
- `rst $00` → JumpTableDispatch ($06c4): inline dw jump table follows the
  site, indexed by `a`; flow never resumes past the rst. Parsed with the
  same lowest-forward-target delimitation as the farcall tables, iterated
  with descent to a fixed point: 465 entries across 70+ sites (`dw` lines
  tagged `jumptable`), 147 new code seeds, +5.3K instructions.
- `rst $08` → sound/music command ($2fb3), one id byte: `sound $xx`
  (451 sites). A sound-id enum would make these self-documenting.
- `rst $20/$28/$30` → three commands ($255e/$256b/$2551) sharing an
  operand fetcher ($253d) that reads an inline dw pointer into de:
  `rst20/rst28/rst30 $xxxx` (83/57/366 sites). Semantics not yet named;
  operands look like data pointers (tilemap/copy sources?).
- `Func_00_07c5` is a register-based far dispatcher (bank in h, same
  $4000 tables) — runtime-computed, not statically exploitable.

**Twin data banks (2026-07-10):** groups of data banks carry relocated
copies of the same bank-local helper, dispatched via farcall slot 0.
Confirmed group: an OAM-frame loader (indexes a second dw table at $4004,
copies $a0 bytes toward $c600) in banks $1f, $25, $26, $30-$37, $5e, $6e —
13 copies; likely one bank per character's animation frames. disasm.py's
`infer_twin_tables()` fingerprints traced slot-0 targets (opcode shape,
operands wildcarded) and matches untraced banks' slot-0 candidates: found
$1f and $5e statically. Groups with identical slot-0 targets ($20-$23 →
$7e7d, $29-$2b → $5e9d) are other such families.

Largest code banks: $08 (match engine), $00, $13 (story engine), $05, $1e,
$1d (story practice-drill engine), $0f, $38, $3b, $0a.

## Pipeline (all working, all documented in README.md)

1. Coverage collection — two paths:
   - **BizHawk native Trace Logger** (fast gameplay) → `tools/tracelog2cov.py`
     converts logs (handles auto-split `_N.log` segments, resolves banks by
     opcode-byte matching, rejects DMA/halt-bug corrupted lines).
   - **gbc-disasm MCP connector** (autonomous driving, slower) →
     `dump_coverage` writes `coverage/<name>.json` directly from the Lua.
2. `tools/disasm.py baserom.gbc coverage/*.json` — regenerates `src/` from
   coverage seeds + conservative recursive descent. Symbol sources: fixed
   vector names, `labels.json` (31 named bank-0 routines), hardware.inc
   registers, and `ram_map.json` (129 RetroAchievements-documented RAM
   addresses → `include/ram_constants.asm`, e.g. `wPlayer1GamesWon`).
3. `tools/extract.py` + `make clean && make -j compare` — verify byte-perfect.

RGBDS 1.0.1 binaries in `tools/rgbds/` (gitignored); Makefile defaults there.

## Autonomous driving

The `/drive-coverage` skill (.claude/skills/drive-coverage/SKILL.md) captures
the full playbook: pause_emulation for deterministic input timing, screenshot
navigation, savestate checkpoints, SRAM safety rules, cursor-jiggle before A
on select screens, serve timing, and match telemetry via `read_memory` at
$c8e0 (score block from ram_map.json).

The gbc-disasm MCP integration (~/code/gbc-disasm-mcp, **uncommitted, not a
git repo**) was heavily fixed/extended this session: honest flat-offset
coverage with raw/translated callback pairing, trace survives disconnects,
step timeouts scale, inputs/screenshot/savestates/pause/set_speed/dump
commands. 39 tests pass. If BizHawk or the MCP server restarts, reload
`lua/disasm_connector.lua` + `/mcp` reconnect.

## Coverage inventory (`coverage/`)

- `clean_session1.json` — human menu/match play (post-pairing-fix, clean)
- `native_seg*.json`, `native2_seg*.json` — two human Trace Logger sessions
- `autodrive1.json` — first autonomous drive (dictionary, status, minigame
  Shooting Star, link-error path, doubles setup + match)
- `autodrive2_pausemenu_serve.json`, `autodrive2_ceremony_clay.json` — second
  drive (exhibition pause menu/options/camera, serve, match results screens,
  singles + difficulty select, clay court, behind-player camera)
- `story_intro.json` — human story-mode intro playthrough (2026-07-10),
  captured with the native Trace Logger (145 auto-split segments, 217M
  traced instructions, 22 GB of logs) and unioned into one file by
  tracelog2cov.py + a merge. Added 11,973 new seeds; the RPG engine lit up
  banks $04, $05, $0a, $10-$15, $1c, $1d, $38 (story overworld, dialogue,
  NPCs). The raw logs live in the BizHawk Tools/ dir and can be deleted —
  this JSON is the durable artifact.
- `story2_overworld.json` — autonomous story-mode drive (2026-07-10, MCP
  connector): save-slot continue path, story pause menu (status/clear
  status/options/messages/music), Restaurant interior + NPC dialogue
  branches, Dorm Entrance/Restaurant Plaza/Training Court maps, Harry
  dorm event, coach dialogue, and the full **Stroke Practice drill engine**
  in bank $1d (serve cams, hit/miss branches, star/fail feedback, results
  board, retry loop — all 4-attempt rounds failed, so the drill *success*
  handler is still uncovered). +6,326 new seeds; first code in banks $06,
  $09, $17, $24, $33, $37, $3e.
- `story3_drillwin.json` — human native-tracer session (2026-07-10):
  **winning the stroke-practice drill** (success handlers in $1d) plus
  whatever followed; big new territory in banks $1c (+1,916 — likely the
  post-practice story/reward flow), $1d (+1,770), $1e (+746), $02 (+427).
  Union of 42 auto-split segments.
- `story4_servevolley.json` — human native-tracer session (2026-07-10):
  the serve-and-volley drill. +945 new seeds — drill framework was already
  covered, new specifics in banks $17 (+372), $15 (+256), $0b (+250), and
  first code in $25. Union of segments 41-91 of the same tracer session
  as story3.
- `story5_netplay.json` — autonomous session (2026-07-10): Net Play
  Practice drill fails/results/retry-decline, coach feedback dialogue.
  Only 3 new seeds (the user's story4 win had covered the drill).
- `story6_restaurant_traingame.json` — human native-tracer session
  (2026-07-10): restaurant visit + a training game. +1,927 new seeds:
  banks $0e (+501), $0a (+478), $10 (+257), $12 (+214 — tennis-machine
  location), $0d (+193, Restaurant), first code in $6e. Segments 91-158.
- `story7_rankingmatch.json` — human native-tracer session (2026-07-10):
  a full junior ranking match, won. +1,498 new seeds: banks $11 (+395,
  ranking-match flow), $16 (+311, first code — likely EXP earn/distribute),
  $1e (+202), $08 (+167 match engine), $2c, $24, $32 (first code).
  Segments 158-353.
- `contaminated/` — pre-fix dumps with phantom seeds; never union these.

Known artifact: exactly 6 skipped seeds — the old phantom at rom 0x1d1a0
plus five ambiguous-banked-run fallbacks from the two native story traces
(0x1d469, 0x22c9b, 0x22fc6, 0x235cf, 0x789df); the conflict filter rejects
them all and the build stays byte-perfect.

## Not yet covered (biggest wins first)

1. **Rest of story mode** — ranking matches beyond the first (senior/
   varsity flows), level-up/stat-distribution details, Wall Practice room
   engine, Academy Main Building/Wing maps, later areas (tournament,
   Peach's castle). Unlocks the 5 locked minigames. (Covered so far:
   stroke + net-play drills, tennis machine, restaurant/cafeteria, first
   junior ranking match with EXP screens.)
2. Match-point → ceremony transition, tiebreaks, deuce.
3. Remaining minigames (locked behind story), Game Boy Tower, tournament.
4. Grass court init; 6-games/3-sets match configs (Play Menu selection UI
   now traced, matches themselves not); more characters.

## Story-mode driving notes (2026-07-10 session)

- RAM: $c280 = location id (RA map has the full list), $c2d0/$c2d2 =
  overworld X/Y — use these to detect blocked movement instead of
  screenshot-diffing. Dialogue: FAST message speed is set in the save.
- The stroke-practice drill: coach serves 4 balls/round; swing = A tap
  (~10-frame window) when the ball is a body-length away — press too early
  and Alex whiffs (no hold-to-charge auto-swing in this engine). The
  "target area" for the return appears to be a star-marked spot on her
  court; all my returns missed it. Savestate replays of the drill are NOT
  input-deterministic (serve placement varies after load).
- The dorm-room bottom door sometimes exits to the main menu (story exit)
  — walk it deliberately and re-Continue if that happens.

## Repo state

Initial commit 058ffee holds the pre-story-mode state. The story-intro
coverage + regenerated sources are uncommitted on top of it. Gitignored:
baserom.gbc, data/, build/, tools/rgbds/, *.gbc.

## Annotation state

Bank 0: 31 named routines (docs/bank0_notes.md) — FarCall trampoline, OAM DMA
stub, joypad, LZ decompressor, sound engine entries, SoftReset, interrupt
handler bodies. RAM: docs/ram_map.md (129 entries, RetroAchievements-sourced).
Next annotation targets: bank $08 (biggest code bank — likely the match
engine), bank $13 (biggest story-mode bank), bank $1e, the minigame bank,
WRAM map expansion from ram_map gaps.

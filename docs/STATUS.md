# Project status — 2026-07-10

## Where things stand

**100,836 instructions (~167 KB of code) disassembled across 57 of 128 banks;
everything rebuilds byte-perfect** (`make compare` → OK against SHA-1
`414ba58340a27fc27b127bc01455b32764151ff0`). The remaining banks are so far
pure data (graphics/audio/tilemaps). The repo contains no ROM bytes: all data
is extracted from a user-supplied `baserom.gbc` by `./setup.sh` per
`data.manifest`.

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
- `contaminated/` — pre-fix dumps with phantom seeds; never union these.

Known artifact: exactly 6 skipped seeds — the old phantom at rom 0x1d1a0
plus five ambiguous-banked-run fallbacks from the two native story traces
(0x1d469, 0x22c9b, 0x22fc6, 0x235cf, 0x789df); the conflict filter rejects
them all and the build stays byte-perfect.

## Not yet covered (biggest wins first)

1. **Rest of story mode** — story matches (EXP earn/distribute, level-up
   flow), Tennis Machine room ($12) and Wall Practice room ($13 location)
   engines in the Training Center (building entrance not yet found — the
   fence-gap gate at Training Court X≈0x1e leads to the courts, not the
   building), Academy Main Building/Wing/Junior Class Court maps, later
   areas. Unlocks the 5 locked minigames. (Stroke-practice success path
   is now covered — story3_drillwin.json.)
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

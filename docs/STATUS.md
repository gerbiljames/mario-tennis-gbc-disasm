# Project status — 2026-07-10

## Where things stand

**85,767 instructions (~139 KB of code) disassembled across 54 of 128 banks;
everything rebuilds byte-perfect** (`make compare` → OK against SHA-1
`414ba58340a27fc27b127bc01455b32764151ff0`). The remaining banks are so far
pure data (graphics/audio/tilemaps). The repo contains no ROM bytes: all data
is extracted from a user-supplied `baserom.gbc` by `./setup.sh` per
`data.manifest`.

Largest code banks: $08 (7,982 instrs — match engine), $00 (7,223), $13
(5,732), $05 (4,643), $1e (4,533), $0f (4,469), $38 (4,391), $3b (4,152),
$0a (4,133), $11 (3,089).

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
- `contaminated/` — pre-fix dumps with phantom seeds; never union these.

Known artifact: exactly 3 skipped seeds — the old phantom at rom 0x1d1a0,
plus 0x22fc6 and 0x789df from the story trace (ambiguous banked runs that
fell back to the wrong bank; the conflict filter rejects them).

## Not yet covered (biggest wins first)

1. **Rest of story mode / Mario Tour** — the intro is now covered (save
   data exists); the bulk of the RPG (matches vs academy ranks, leveling,
   later areas) is not. Unlocks the 5 locked minigames.
2. Match-point → ceremony transition (missed by a polling overshoot; results
   screens themselves are covered), tiebreaks, deuce.
3. Remaining minigames (locked behind story), Game Boy Tower, tournament.
4. Grass court init; 6-games/3-sets match configs; more characters.

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

# Project status — 2026-07-10

## Where things stand

**67,727 instructions (~114 KB of code) disassembled across 37 of 128 banks;
everything rebuilds byte-perfect** (`make compare` → OK against SHA-1
`414ba58340a27fc27b127bc01455b32764151ff0`). The other 91 banks are so far
pure data (graphics/audio/tilemaps). The repo contains no ROM bytes: all data
is extracted from a user-supplied `baserom.gbc` by `./setup.sh` per
`data.manifest`.

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
- `contaminated/` — pre-fix dumps with phantom seeds; never union these.

Known artifact: exactly 1 skipped seed (phantom at rom 0x1d1a0 from a
pre-fix session); fresh dumps produce 0.

## Not yet covered (biggest wins first)

1. **Story mode / Mario Tour** — the RPG engine (overworld, dialogue, NPCs,
   leveling). Untouched because entering it creates save data — **needs
   user's explicit OK**. Save slots are currently all empty. Unlocks the 5
   locked minigames.
2. Match-point → ceremony transition (missed by a polling overshoot; results
   screens themselves are covered), tiebreaks, deuce.
3. Remaining minigames (locked behind story), Game Boy Tower, tournament.
4. Grass court init; 6-games/3-sets match configs; more characters.

## Repo state

git initialized, **nothing committed yet** (user hasn't asked). Untracked:
all sources, tools, coverage, docs, skill. Gitignored: baserom.gbc, data/,
build/, tools/rgbds/, *.gbc.

## Annotation state

Bank 0: 31 named routines (docs/bank0_notes.md) — FarCall trampoline, OAM DMA
stub, joypad, LZ decompressor, sound engine entries, SoftReset, interrupt
handler bodies. RAM: docs/ram_map.md (129 entries, RetroAchievements-sourced).
Next annotation targets: bank $08 (biggest code bank — likely the match
engine), bank $1e, the minigame bank, WRAM map expansion from ram_map gaps.

---
name: drive-coverage
description: Autonomously drive Mario Tennis (GBC) in BizHawk via the gbc-disasm MCP to capture execution-coverage traces and grow the disassembly. Use when asked to drive/play the game for coverage, capture traces, explore game screens, or convert play sessions into disassembled code.
---

# Drive the game to capture coverage

Grow the disassembly by making the game execute new code under a trace, then
regenerating `src/` from the coverage. Executed = code; everything else stays
data. Byte-perfect rebuild (`make compare`) is the invariant after every
regeneration.

## Setup

1. Load the MCP tool schemas via ToolSearch (they are deferred):
   `status, screenshot, step_frames, save_state, load_state, trace_start,
   trace_stop, get_coverage, dump_coverage, set_speed, pause_emulation,
   resume_emulation`.
2. `status` must show the ROM (SHA-1 414ba58340a27fc27b127bc01455b32764151ff0).
   If the connector is down, ask the user to reload `disasm_connector.lua` in
   BizHawk's Lua Console and run `/mcp` → reconnect.
3. **Immediately `save_state`** to a scratchpad checkpoint before any input.

## SRAM safety (hard rules)

- NEVER activate options that write battery save: main-menu **Erase Saved
  Data** (the cursor often rests on it!), the minigame pause-menu **"Save or
  quit"**, or any story-mode save prompt.
- Story mode / character creation creates save data — only enter with the
  user's explicit permission.

## Driving loop

- **See**: `screenshot` to a scratchpad path, then Read the PNG.
- **Act**: `step_frames` with `buttons` — taps are 4-8 frames
  (`{"A": true}`); holds for gameplay 25-40 frames (can combine directions
  with A/B). Buttons: Up/Down/Left/Right/A/B/Start/Select.
- **Settle**: after a confirm, idle `step_frames` 30-60 before screenshotting
  — screens need transition time.
- **Pause for gameplay**: `pause_emulation` before any timing-sensitive play
  (serves, rallies, minigames) — while paused, the stepped frames are the
  only frames that run, so input timing is deterministic. Menus don't need
  it (unpaused, the emulator free-runs a few hundred frames between MCP
  calls; menus are stable, but anything timed will drift).
  `resume_emulation` when done or when handing control back to the user.
- **Stuck?** Verify the UI responds (move the cursor, screenshot). Character
  selects reject duplicate picks. On select screens A often only registers
  after the cursor has moved at least once — jiggle (Right, idle 10, A for 8)
  rather than re-pressing A. Don't guess a B-stack backout — `load_state` the
  checkpoint (coverage survives loads). Remember where the cursor lands after
  loading.
- **Match telemetry**: don't screenshot to track score — `read_memory` 13
  bytes at $c8e0 (System Bus): sets P1/P2, games P1/P2, points P1/P2 (0-3 =
  0/15/30/40), deuce, tiebreak, then match/set/game/point win-lose flags
  ($01 win / $ff lose). Per-symbol notes in `ram/*.asm`.
  Poll in ≤400-frame chunks near game/match point or you'll overshoot the
  moment you wanted to trace (points resolve fast when idling).
- **Serving** (tennis): A tap (4f) → 18 idle frames → A tap (4f) hits the
  toss reliably under pause. When idling through CPU points, your doubles
  partner is CPU-controlled and can extend rallies for 1000+ frames.
- Menu map (grid): Exhibition | Mini-Games | Linked Play / Tour slots 1 2 3 /
  Status | Dictionary | **Erase Saved Data (danger)**.

## Tracing discipline

- `trace_start` **resets the coverage buffer** — before starting a new trace,
  dump any unsaved coverage first.
- Traced stepping costs ~1.4 s/frame; keep single steps ≤ 120 frames.
  Navigate known territory with the trace off, trace only new content
  (transitions into a screen run its init code — enter screens *while*
  tracing).
- Coverage accumulates across `load_state`, so one trace can span many
  checkpoint-hopping captures.
- Collect with `dump_coverage` pointing at an **absolute path** into
  `coverage/<name>.json` (BizHawk's working directory differs, so relative
  paths land elsewhere) — the Lua writes the JSON to disk directly, nothing
  large crosses the wire. Then `trace_stop`. (`get_coverage` remains for
  quick summaries/inspection.)
- Coverage note: `rom` = flat ROM offsets, `other` = RAM/HRAM execution
  (normally just the six OAM-DMA stub addresses at $ff80+).

## Regenerate and verify

```sh
python3 tools/disasm.py baserom.gbc coverage/*.json
python3 tools/extract.py baserom.gbc data.manifest data/
make clean && make -j compare   # must end "mariotennis.gbc: OK"
```

Report the instruction/byte delta. A tiny number of skipped seeds is a known
artifact (one pre-fix phantom at rom 0x1d1a0); zero is expected for fresh
dumps. Never union files from `coverage/contaminated/`.

## Alternative for long sessions

If the user will play for more than a minute or two, prefer BizHawk's native
Trace Logger (Tools → Trace Logger → log **to file**; the window's scrollback
truncates) — gameplay stays fast. Convert each segment:
`python3 tools/tracelog2cov.py baserom.gbc <log> coverage/<name>.json`
(handles the auto-split `_N.log` segments; rejects DMA/halt-bug corrupted
lines by byte-matching against the ROM).

## Coverage targets still open

Story mode (RPG engine — needs user permission), the five locked minigames
(unlock via story), tiebreaks, match victory/defeat ceremonies, options in
the minigame pause menu (except save), Game Boy Tower, tournament flows.

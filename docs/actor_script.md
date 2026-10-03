# Actor-Script Bytecode

Overworld/story actors (placed by `map_actor` records) run a small stack-less
bytecode: 1-byte opcodes, each followed by 0–4 operand bytes. Script blobs are
labelled `ActorScript_*` and written with the `as_*` macros
(`include/macros/`).

This is unrelated to the 16-byte *object definition* selected by
`map_actor`'s `obj_id` via the `$04:$4f75` table (`LoadActorObjectDef`,
`$04:$4ac6`), which carries sprite/animation/palette pointers. The blob a
`map_actor` *points at* (its `objdef` field) is a script.

## Installation and execution

1. `SpawnActorFromTemplate` (`$04:$4c60`) → `SpawnActor` (`$04:$4055`) takes
   a free slot (24 of `$40` bytes from `$d000`, WRAM bank $04) and stores the
   script pointer: `+$00/+$01` address, `+$02` bank, `+$03` wait counter (0).
2. `UpdateActors` (`$04:$41e7`) calls **`StepActorScript`** (`$04:$4229`) per
   live slot, slot base in `bc` and in `hActorPtr` (`$ffea/$ffeb`).
3. `StepActorScript` yields if `+$05` bit0 is set (paused) or while the
   `+$03` counter is nonzero (decrementing it); otherwise it dispatches the
   opcode through the 22-entry table at **`$04:$447d`**.
4. Each handler advances past its operands and returns `a`: **0** = yield
   for this frame, **nonzero** = run the next opcode now. The pointer is
   written back to `+$00/+$01`.

## Opcode reference

Handlers are in bank `$04`. "Size" includes the opcode. "Cont?": *yield*
stops for the frame, *cont* runs the next opcode, *cond* depends on state.

| Op | Macro | Size | Cont? | Handler | Meaning |
|----|-------|------|-------|---------|---------|
| `$00` | `as_halt` | 1 | yield* | `$460a` | Inert — yields without advancing the pointer (idles forever) |
| `$01` | `as_wait n` | 2 | yield | `$460c` | Set the wait counter `+$03 = n-1`, then yield |
| `$02` | `as_wait_move` | 1 | cond | `$45f8` | Yield until the current move finishes (`+$05` bit7 clear) |
| `$03` | `as_set_pos x, y` | 5 | cont | `$4556` | Teleport: set the current position → `+$0c/+$0e`, and clear the `+$05` bit7 move flag |
| `$04` | `as_set_target x, y` | 5 | cont | `$457b` | Set the move target → `+$08/+$0a`, and set the `+$05` bit7 move flag (starts a move) |
| `$05` | `as_halt5` | 1 | yield* | `$460a` | Inert (handler alias of `$00`) |
| `$06` | `as_target_rel dx, dy` | 5 | cont | `$45a0` | Offset the move target by (dx, dy), both signed words |
| `$07` | `as_move angle, dist` | 4 | cont | `$44df` | Move by angle (byte) + distance (word), absolute angle |
| `$08` | `as_move_rel angle, dist` | 4 | cont | `$44eb` | Move by angle + distance, angle relative to the heading (`+$14`) |
| `$09` | `as_rand_box p0, p1` | 3 | cond | `$4886` | Pick a random reachable point in a box (half-width `p0`, half-depth `p1`), gated on `+$30` bit7; yields if four tries all fail |
| `$0a` | `as_step` | 1 | yield | `$46b0` | Step one tick toward the target waypoint (`+$16`), then yield |
| `$0b` | `as_follow_wp` | 1 | yield | `$4623` | Advance along the waypoint list at `+$16`, then yield |
| `$0c` | `as_jump target` | 3 | cont | `$44d0` | Jump: signed rel16 added to the operand's own address |
| `$0d` | `as_set_field sel, val` | 4 | cont | `$477f` | Write a state field (selector byte, word value; type table `$47fd`) |
| `$0e` | `as_add_field sel, val` | 4 | cont | `$47ba` | Add to / set a state field (selector byte, word value) |
| `$0f` | `as_halt15` | 1 | yield* | `$460a` | Inert (handler alias of `$00`) |
| `$10` | `as_anim id` | 2 | cont | `$4824` | Set animation id (`SetActorAnimation`) |
| `$11` | `as_sound id` | 2 | cont | `$483d` | Play sound id (`PlaySoundManaged`) |
| `$12` | `as_call fn` | 3 | cond | `$44a9` | Call a same-bank function (actor state in `bc`); yield+retry if it reports busy |
| `$13` | `as_begin_path` | 1 | yield | `$484e` | Seed the path target `+$16` from the current position, set path flags |
| `$14` | `as_wait_move2` | 1 | yield | `$4949` | Once the move has finished (`+$05` bit7 clear), set a 40-frame wait and advance; while moving, advance with a 10-frame wait only if `+$05` bit6 is set |
| `$15` | `as_flag mode, field, bit` | 4 | cont | `$49de` | Set (`mode=$01`) or clear bit `bit` of state field `field`; `bit` indexes the mask table `$4a1f` |

\* Returns `a = 0` **without** advancing, so the opcode is re-read every
frame: a permanent idle.

Coordinates are written in tiles with a point (`map_pos`) and stored as
little-endian words in 1/256 tile: `39.0` → `$2700`, `17.5` → `$1180`.
`as_jump` emits `dw target - @`.

## Example

`ActorScript_0f_08`, a two-point patrol:

```
ActorScript_0f_08:
	as_flag $01, $05, $02
	as_set_field $06, $0006
.L8:
	as_set_target 39.0, 19.0
	as_wait_move
	as_wait 75
	as_set_target 41.0, 19.0
	as_wait_move
	as_wait 120
	as_jump .L8
```

The first two lines run once; the body loops between `(39, 19)` and
`(41, 19)`, waiting 75 and 120 frames after each move.

## Where script pointers come from

- **`map_actor`** — the `objdef` field (initial script).
- **`script_set_actor_script actor, addr`** (`ScriptSetActorScript`) — a
  script installed at runtime; every target is labelled `ActorScript_*`.
- **`dw` selector tables** — e.g. `DormRoomNpc04IdleScripts_13`
  (`$13:$526a`), indexed by `SetRandomDormRoomNpc04Script_13` with a random
  0-7 to pick one of four entry points.

## Fragments and multiple entry points

A blob is a pool of fragments, each ending in an `as_jump` back-edge
that loops forever. Actors and animation states enter one blob at different
offsets, so a blob may start with `as_halt` (an inert prop) yet hold a live
loop others jump into. Each entry point gets an `ActorScript_*` label; other
in-blob jump targets get `.L<off>` locals. Fragments fall through or jump
into each other, and a jump to another entry point names its global label
(`as_jump ActorScript_11_02`).

`DormRoomNpc04IdleScripts_13` lands at offsets 0/24/34/44 of one 95-byte run
(`ActorScript_13_00`…`_03`, `$13:$585f`-`$58bd`: a wander loop, two
one-shots, a patrol loop); the shared body at `$11:$5b14…$5d27` has 19 entry
points.

## Unreferenced script-shaped blobs

Five story-bank blobs decode as clean looping scripts with no outside
reference. Two are rendered as scripts, referenced only by their own
`as_jump`: `ActorScript_0e_23` (`$0e:$7ca4`) and `ActorScript_14_4`
(`$14:$78e7`). Three stay `db` rows: `Table_13` (`$13:$62db`), `Table_15`
(`$15:$7a23`), `Unused_27_ActorLists` (`$27:$4b41`).

## What follows a script

| Script | Followed by |
|--------|-------------|
| `ActorScript_0f_11` | four `Unused_0f_MapScript*` routines, then `ActorScript_0f_12` |
| `ActorScript_12_44` | more scripts (`ActorScript_12_45` onward) |
| `ActorScript_15_25` | `Unused_15_ComputeRankingProgressIndex` and `ComputeStoryRankTier_15` |
| `ActorScript_27_05` | `ActorScript_27_06`, then `Unused_27_Record` (16 bytes, contents not established) and palettes |
| `ActorScript_27_33` | `Unused_27_ComputeRankingProgressIndex` and `Unused_27_SetStoryRankTier` |

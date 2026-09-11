# Actor-Script Bytecode

Overworld/story actors (the entities placed by `map_actor` records) are driven
by a small stack-less bytecode interpreter. Each actor's behaviour is a script:
a variable-length blob of 1-byte opcodes, each followed by 0–4 operand bytes.
These blobs were previously labelled `ActorObjDef_*` and dumped as `INCBIN`; they
are now labelled `ActorScript_*` and rendered with the `as_*` macros
(`include/macros.inc`).

Note this is unrelated to the 16-byte *object definition* record selected by
`map_actor`'s `obj_id` field via the `$04:$4f75` table (`LoadActorObjectDef`,
`$04:$4ac6`) — that one carries the sprite/animation/palette pointers. The
blobs a `map_actor` record *points at* (its `objdef` field) are scripts.

## Installation and execution

`map_actor cond, objdef, x, y, facing, obj_id, anim, palette` — the `objdef`
field is a pointer to a script blob.

1. `SpawnActorFromTemplate` (`$04:$4c60`) → `SpawnActor` (`$04:$4055`) finds a
   free actor slot (24 slots of `$40` bytes from `$d000`, WRAM bank $04) and
   stores the script pointer into the slot: `+$00/+$01` = address, `+$02` =
   bank, `+$03` = wait counter (0).
2. The per-frame actor loop (`$04:$41e7`) calls **`StepActorScript`**
   (`$04:$4229`) for each live slot, with the slot base in `bc` and its low
   byte cached in `hActorPtr` (`$ffea/$ffeb`).
3. `StepActorScript` yields immediately if `+$05` bit0 is set (paused) or while
   the `+$03` wait counter is nonzero (decrementing it). Otherwise it reads the
   opcode at the script pointer and dispatches through the 22-entry handler
   table at **`$04:$447d`** (the `as_*` macros in `include/macros.inc`, one per opcode).
4. Each handler advances the script pointer past its own operands and returns
   `a`: **0** = stop stepping this frame (yield), **nonzero** = run the next
   opcode immediately. The updated pointer is written back to `+$00/+$01`.

A script is really a **pool of fragments**, each ending in an `as_jump`
back-edge that loops it forever. Different actors and animation states enter the
same blob at different offsets, so a blob may begin with `as_halt` (an inert
static prop) yet still contain a live movement loop that other entrants jump
into. The disassembler emits a local label (`.L<off>`) at every in-blob jump
target.

## Opcode reference

Handler addresses are in bank `$04`. "Size" is the whole instruction
(opcode + operands). "Cont?" is the `a` return: *yield* stops stepping for the
frame, *cont* runs the next opcode immediately, *cond* depends on state.

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
| `$08` | `as_move_rel angle, dist` | 4 | cont | `$44eb` | Move by angle + distance, angle relative to facing |
| `$09` | `as_rand_box p0, p1` | 3 | cont | `$4886` | Pick a random reachable point in a box, gated on `+$30` bit7 |
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
| `$14` | `as_wait_move2` | 1 | cond | `$4949` | Wait for the move to finish / run a countdown |
| `$15` | `as_flag field, mode, bit` | 4 | cont | `$49de` | Set (`mode=$01`) or clear an actor flag bit; `bit` indexes the mask table `$4a1f` |

\* `$00`/`$05`/`$0f` return `a = 0` **without** advancing the pointer, so the
actor re-reads the same opcode every frame — a permanent idle.

Coordinates are 16-bit fixed-point map units, little-endian (`as_set_target
$2700, $1300`). `as_jump`'s operand is `target - operand_address`; the macro emits
`dw target - @`.

## Example

`ActorScript_0f_08` — a two-point patrol:

```
ActorScript_0f_08:
	as_flag $01, $05, $02
	as_set_field $06, $0006
.L8:
	as_set_target $2700, $1300
	as_wait_move
	as_wait $4b
	as_set_target $2900, $1300
	as_wait_move
	as_wait $78
	as_jump .L8
```

The two `as_flag`/`as_set_field` lines run once, then the body loops: move to
`($2700,$1300)`, wait for the move and 75 frames, move to `($2900,$1300)`, wait
for the move and 120 frames, repeat.

## Where script pointers come from

- **`map_actor`** — the `objdef` field (an actor's initial script).
- **`script_set_actor_script actor, addr`** — the macro for
  `ScriptSetActorScript`; `addr` is a script installed at runtime. Every such
  site's target is labelled `ActorScript_*`.
- **`dw` selector tables** — e.g. `StoryCmdHandlersC_13` (`$13:$526a`), where an
  index picks one of several entry points.

## Multiple entry points

A blob can be entered at several offsets — overlapping scripts that share a tail.
`StoryCmdHandlersC_13` lands at offsets 0/24/34/44 inside one 95-byte blob (a
wander loop, two one-shots, a patrol loop); the shared body at `$11:$5b14…$5d27`
has ~20 entry points. Each entry point gets its own `ActorScript_*` label, and
the blob splits into one `actor_script` region per label. Execution flows from
one labelled fragment into the next (fall-through) or jumps between them: an
`as_jump` whose target is another entry point renders as that global label
(`as_jump ActorScript_11_04`) rather than a local `.L`. `decode_actor_script`
accepts a jump target that is a known script label even when it lands outside the
current segment. (`StoryCmdHandlersC_13` was originally mis-seeded as code — its
"handlers" are script fragments, not routines; likewise `$10:$741c`.)

## Blobs that decode as scripts but are unreferenced

Five story-bank blobs decode as clean looping scripts yet have **no** traceable
reference — nothing installs, jumps to, calls, or points at them
(`$0e:$7ca4`, `$13:$62db`, `$14:$78e7`, `$15:$7a23`, `$27:$4b41`). Decoding as a
script is suggestive but not proof, so they are left `INCBIN` (unclassified)
rather than labelled on shape alone. Candidates for a future pass if a reference
turns up (e.g. a computed or cross-bank pointer).

## Blobs with an unclassified tail

Five blobs are a script followed by a run of bytes that are **not** actor-script
opcodes. What those tail bytes are has not been established — they were never hit
in the available execution traces and nothing points at them — so they are left
**unclassified** (`INCBIN`, tagged `unclassified tail`), *not* assumed to be
code or data:

| Blob | Script prefix | Tail |
|------|---------------|------|
| `ActorScript_0f_11` | 10 B | 572 B |
| `ActorScript_12_44` | 123 B | 3 B |
| `ActorScript_15_25` | 28 B | 71 B |
| `ActorScript_27_05` | 25 B | 128 B |
| `ActorScript_27_33` | 133 B | 120 B |

The generator decoded the clean prefix and stopped at the first non-opcode
byte, emitting the prefix as `as_*` macros and the remainder as the tail
blob (`decode_actor_script` in `tools/disasmlib/datatables.py` at tag
`generator-final`). Classifying the tails is future work, now done by hand
in the source.

"""Collapsing fixed instruction sequences into their source macros.

The game builds several operations out of the same rigid run of register
setups and farcalls; rendering that run as the macro it is keeps the assembled
bytes identical while making the source read as the operation. Each collapser
returns (text, byte size), or None when the sequence is not an exact match or
when a label/data note lands inside it (which would be hidden by the macro).
"""
from .constants import ACTOR_FACING_NAMES
from .rom import BANK_SIZE
from .textids import text_id_name


# Cutscene script commands. Each is (macro, steps) where the source is a fixed
# instruction sequence — register setups plus one or more farcalls into the
# story script engine. A step is either a plain instruction (opcode, size, kind)
# or a farcall ('F', FarPtr slot label). kinds: 'b' = 1-byte immediate arg,
# 'w' = 2-byte immediate arg, 'x' = no-operand op (no arg), 'z' = 1-byte
# immediate fixed at $00 (no arg; only matches that value). Immediate args are
# emitted to the macro in source order.
SCRIPT_COMMANDS = (
    ("script_move_target",
        ((0x3E, 2, 'b'), (0x01, 3, 'w'), (0x11, 3, 'w'),
         ('F', "FarPtr_ScriptSetActorMoveTarget"))),
    ("script_set_position",
        ((0x3E, 2, 'b'), (0x01, 3, 'w'), (0x11, 3, 'w'),
         ('F', "FarPtr_ScriptSetActorPosition"))),
    ("script_move_angle",
        ((0x3E, 2, 'b'), (0x06, 2, 'b'), (0x11, 3, 'w'),
         ('F', "FarPtr_MoveActorByAngle"))),
    ("script_set_speed",
        ((0x3E, 2, 'b'), (0x01, 3, 'w'), ('F', "FarPtr_ScriptSetActorMoveSpeed"))),
    ("script_jump_velocity",
        ((0x3E, 2, 'b'), (0x11, 3, 'w'), ('F', "FarPtr_ScriptSetActorJumpVelocity"))),
    ("script_set_anim",
        ((0x3E, 2, 'b'), (0x16, 2, 'b'), ('F', "FarPtr_ScriptSetActorAnimation"))),
    ("script_face",
        ((0x3E, 2, 'b'), (0x06, 2, 'b'), ('F', "FarPtr_SetActorFacing"))),
    ("script_face_pair",
        ((0x3E, 2, 'b'), (0x47, 1, 'x'), (0x3E, 2, 'b'),
         ('F', "FarPtr_FaceActorsTowardEachOther"))),
    ("script_face_toward",
        ((0x3E, 2, 'b'), (0x47, 1, 'x'), (0x3E, 2, 'b'),
         ('F', "FarPtr_FaceActorTowardActor"))),
    ("script_facing_lock",
        ((0x3E, 2, 'b'), (0x06, 2, 'b'), ('F', "FarPtr_ScriptSetActorFacingLock"))),
    ("script_set_active",
        ((0x3E, 2, 'b'), (0x06, 2, 'b'), ('F', "FarPtr_SetActorActive"))),
    # Set an actor's object definition: fetch its state pointer into bc, then
    # LoadActorObjectDefIfValid(bc, d = objdef). Args: objdef (d), then actor (a).
    ("script_set_objdef",
        ((0x16, 2, 'b'), (0x3E, 2, 'b'), ('F', "FarPtr_GetActorStateAddr"),
         (0x4D, 1, 'x'), (0x44, 1, 'x'),
         ('F', "FarPtr_LoadActorObjectDefIfValid"))),
    ("script_get_actor_state",
        ((0x3E, 2, 'b'), ('F', "FarPtr_GetActorStateAddr"))),
    ("script_move_player_to_actor",
        ((0x3E, 2, 'b'), (0x06, 2, 'z'), ('F', "FarPtr_MovePlayerToActor"))),
    ("script_move_player",
        ((0xAF, 1, 'x'), (0x01, 3, 'w'), (0x11, 3, 'w'),
         ('F', "FarPtr_MovePlayerToPosition"))),
    ("script_player_speed",
        ((0x01, 3, 'w'), ('F', "FarPtr_SetPlayerMoveSpeed"))),
    ("script_set_text",
        ((0x21, 3, 'w'), ('F', "FarPtr_InitDialogueTextCursor"))),
    ("script_speak",
        ((0x3E, 2, 'b'), ('F', "FarPtr_ScriptShowSpeakerDialogue"))),
    ("script_wait_idle",
        ((0x3E, 2, 'b'), ('F', "FarPtr_ScriptWaitActorIdle"))),
    ("script_wait_move",
        ((0x3E, 2, 'b'), ('F', "FarPtr_ScriptWaitActorMoveDone"))),
    ("script_wait_actor_script",
        ((0x3E, 2, 'b'), ('F', "FarPtr_WaitActorScriptDone"))),
    ("script_null_script",
        ((0x3E, 2, 'b'), ('F', "FarPtr_SetActorNullScript"))),
    # Always bracketed by push af / pop af (it clobbers a with the frame count
    # while the caller holds an actor id there); the pair are ordinary steps.
    ("script_wait_frames",
        ((0xF5, 1, 'x'), (0x3E, 2, 'b'), ('F', "FarPtr_WaitScriptFrames"),
         (0xF1, 1, 'x'))),
    # Copy a width x height tile rectangle between two scene-tilemap cells:
    # source (b=col, c=row) -> dest (d=col, e=row), h=width, l=height.
    ("script_copy_scene_rect",
        ((0x06, 2, 'b'), (0x0E, 2, 'b'), (0x16, 2, 'b'), (0x1E, 2, 'b'),
         (0x26, 2, 'b'), (0x2E, 2, 'b'), ('F', "FarPtr_CopySceneTilemapRect"))),
    # Wait `frames` frames via the af-preserving WaitScriptFramesSaveA wrapper
    # (bank $27's cutscenes call it instead of inlining script_wait_frames).
    ("script_delay",
        ((0x3E, 2, 'b'), ('C', "WaitScriptFramesSaveA"))),
    # Start a fade-in at speed c (BeginFadeIn, $00:$1d2e).
    ("script_fade_in",
        ((0x0E, 2, 'b'), ('C', "BeginFadeIn"))),
    # Set actor `actor`'s script to `script` (a pointer in the current bank,
    # captured via hRomBank -> b). ScriptSetActorScript ($0a:$434f).
    ("script_set_actor_script",
        ((0xF0, 2, 'x'), (0x47, 1, 'x'), (0x3E, 2, 'b'), (0x11, 3, 'p'),
         ('F', "FarPtr_ScriptSetActorScript"))),
)


# Cutscene script macros whose arg 1 is a FACE_* cardinal (facing or angle).
FACING_ARG_MACROS = {"script_face", "script_facing_lock", "script_move_angle"}

# The three reserved system actor slots (see constants.inc). Slots 3+ are
# scene-local and stay literal.
RESERVED_ACTOR_SLOTS = {"$00": "ACTOR_PLAYER", "$01": "ACTOR_PLAYER_SHADOW",
                        "$02": "ACTOR_PARTNER"}

# Cutscene script macros -> the emitted-arg indices that are actor slots (a
# reserved slot renders as its ACTOR_* name). Only the target-actor immediates;
# slot ids elsewhere in the arg list stay literal.
ACTOR_SLOT_ARGS = {
    "script_move_target": (0,), "script_set_position": (0,),
    "script_move_angle": (0,), "script_set_speed": (0,),
    "script_jump_velocity": (0,), "script_set_anim": (0,),
    "script_face": (0,), "script_face_pair": (0, 1),
    "script_face_toward": (0, 1), "script_facing_lock": (0,),
    "script_set_active": (0,), "script_set_objdef": (1,),
    "script_get_actor_state": (0,), "script_move_player_to_actor": (0,),
    "script_speak": (0,), "script_wait_idle": (0,), "script_wait_move": (0,),
    "script_wait_actor_script": (0,), "script_null_script": (0,),
    "script_set_actor_script": (0,),
}


def script_cmd_seq(dis, rom, off, labels, far_slot_names):
    """Collapse a cutscene script command (a fixed run of register setups and
    farcalls into the FarPtr_Script* engine) into a script_* macro. Steps are
    matched in order; farcall steps must resolve to the named FarPtr slot. Only
    fires when no label or data note lands inside the sequence past its first
    instruction (so nothing is hidden)."""
    def plain(o):
        return (o in dis.instrs and o not in labels
                and o not in dis.data_site_notes)
    if off in dis.data_site_notes:
        return None
    for macro, steps in SCRIPT_COMMANDS:
        p, args, ok = off, [], True
        for step in steps:
            if p != off and not plain(p):
                ok = False
                break
            if step[0] == 'F':
                if p not in dis.farcalls:
                    ok = False
                    break
                fbank, slot, _entry, _tgt = dis.farcalls[p]
                if far_slot_names.get((fbank, slot)) != step[1]:
                    ok = False
                    break
                p += 3  # rst18 + slot + bank
            elif step[0] == 'C':  # `call` to a named ROM0 / same-bank helper
                if p + 3 > len(rom) or rom[p] != 0xCD:
                    ok = False
                    break
                cpu = rom[p + 1] | (rom[p + 2] << 8)
                tgt = cpu if cpu < BANK_SIZE else \
                    (p // BANK_SIZE) * BANK_SIZE + cpu - BANK_SIZE
                if labels.get(tgt) != step[1]:
                    ok = False
                    break
                p += 3
            else:
                opc, size, kind = step
                if p + size > len(rom) or rom[p] != opc:
                    ok = False
                    break
                if kind == 'z' and rom[p + 1] != 0x00:
                    ok = False
                    break
                if kind == 'b':
                    args.append(f"${rom[p + 1]:02x}")
                elif kind == 'w':
                    args.append(f"${rom[p + 1] | (rom[p + 2] << 8):04x}")
                elif kind == 'p':  # 16-bit pointer -> label if one is known
                    v = rom[p + 1] | (rom[p + 2] << 8)
                    tgt = ((p // BANK_SIZE) * BANK_SIZE + v - BANK_SIZE
                           if BANK_SIZE <= v < 0x8000 else v)
                    args.append(labels.get(tgt, f"${v:04x}"))
                p += size
        if ok:
            if macro == "script_set_text" and len(args) == 1:
                name = text_id_name(int(args[0][1:], 16))
                if name:
                    args[0] = name
            # The facing byte (arg 1) of the facing/angle setters is the FACE_*
            # cardinal encoding shared with the map tables (the byte doubles as
            # the movement angle for script_move_angle).
            if macro in FACING_ARG_MACROS and len(args) >= 2 \
                    and args[1].startswith("$"):
                args[1] = ACTOR_FACING_NAMES.get(int(args[1][1:], 16), args[1])
            for ai in ACTOR_SLOT_ARGS.get(macro, ()):
                if ai < len(args) and args[ai] in RESERVED_ACTOR_SLOTS:
                    args[ai] = RESERVED_ACTOR_SLOTS[args[ai]]
            return (f"{macro} " + ", ".join(args)).rstrip(), p - off
    return None


def wram_bank_seq(dis, rom, off, labels):
    """Collapse the WRAM bank-switch idiom into the wram_bank macro:
    ldh [$ff96],a + ldh [rWBK],a, optionally preceded by ld a,imm. Only
    fires when the follow-on instructions are plain proven code with no
    label or data-site note landing inside the sequence (a mid-sequence
    jump target keeps its raw instructions). Returns (text, size)."""
    def plain(o):
        return (o in dis.instrs and o not in labels
                and o not in dis.data_site_notes)
    if off in dis.data_site_notes:
        return None
    if (rom[off] == 0x3E and rom[off + 2:off + 6] == b"\xe0\x96\xe0\x70"
            and plain(off + 2) and plain(off + 4)):
        return f"wram_bank ${rom[off + 1]:02x}", 6
    if rom[off:off + 4] == b"\xe0\x96\xe0\x70" and plain(off + 2):
        return "wram_bank", 4
    return None


def match_launcher_seq(dis, rom, off, labels):
    """Collapse the story match-launcher idiom into load_match_settings: the
    two immediates are the high/low bytes of the 16-bit wCurrentMinigameStoryMatch
    id ($c8f6/$c8f7), then farcall FarPtr_LoadMatchSettingsFromTable (slot $5a
    bank $0a). 41 standalone launcher stubs (each then ret) plus inline callers
    share it. Only fires when no label/data note lands mid-sequence."""
    def plain(o):
        return (o in dis.instrs and o not in labels
                and o not in dis.data_site_notes)
    if off in dis.data_site_notes:
        return None
    if (rom[off] == 0x3E and rom[off + 2] == 0xEA and rom[off + 3] == 0xF6
            and rom[off + 4] == 0xC8 and rom[off + 5] == 0x3E
            and rom[off + 7] == 0xEA and rom[off + 8] == 0xF7
            and rom[off + 9] == 0xC8 and rom[off + 10] == 0xDF
            and rom[off + 11] == 0x5A and rom[off + 12] == 0x0A
            and plain(off + 2) and plain(off + 5) and plain(off + 7)
            and plain(off + 10)):
        return (f"load_match_settings "
                f"${(rom[off + 1] << 8) | rom[off + 6]:04x}"), 13
    return None

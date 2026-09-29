#!/usr/bin/env python3
"""Play the game headless and check claims the source makes against what
actually runs.

    python3 tools/runtime_audit.py --save maxed-unlocked.sav [--frames N]

needs PyBoy (`pip install pyboy`). It boots mariotennis.gbc with the given
battery save, reaches the story overworld through the main menu, and then
plays: every story location is entered at each of its entry points (by
writing the location and entry and a `$ff` exit request, the game's own
reload path) and walked about at random, and long random sessions run from
the Test map (whose debug NPCs launch story matches) and from boot. Hooks
record:

  * every `Unused*` routine entry that executes -- each is a claim that
    nothing reaches it, so any hit is a wrong label;
  * the actor list InitLocationActors installs, and at every script site
    that names an actor slot (`ACTOR_<list>_<object>`), whether the list
    active at that moment holds the same actor (script and object) in that
    slot as the list the name comes from;
  * the NpcScripts id of every talk, checked the same way;
  * every character record InitCa00RecordFromCharId loads, with the
    location, game mode and match id around it.

Coverage is what random play reaches: scenes behind story states the save
is past never run, so a clean report is evidence, not proof.
"""
import argparse
import collections
import io
import random
import re
import shutil
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from banksrc import bank_lines, bank_of, build_addresses, holders

ROOT = Path(__file__).resolve().parent.parent
MNEMONICS = set("adc add and bit call ccf cp cpl daa dec di ei halt inc jp jr ld ldh "
                "nop or pop push res ret reti rl rla rlc rlca rr rra rrc rrca rst sbc "
                "scf set sla sra srl stop sub swap xor".split())


def symbols():
    out = {}
    for line in (ROOT / "build" / "mariotennis.sym").read_text().splitlines():
        m = re.match(r"([0-9a-f]{2}):([0-9a-f]{4}) (\S+)", line)
        if m:
            out.setdefault(m.group(3), (int(m.group(1), 16), int(m.group(2), 16)))
    return out


def targets(sym):
    unused, rows, defs, named, npc_tables, locs = [], collections.defaultdict(list), {}, [], {}, []
    banks = [(bank_of(h), bank_lines(h)[0]) for h in holders()]
    for bank, lines in banks:
        cur = last = None
        for i, line in enumerate(lines):
            m = re.match(r"^([A-Za-z_]\w*):", line)
            if m:
                last = m.group(1)
                nxt = next((x for x in lines[i + 1:i + 6] if x.strip() and not x.strip().startswith(";")), "")
                op = re.match(r"^\t(\w+)", nxt)
                if last.startswith("Unused") and op and (op.group(1) in MNEMONICS or "_" in op.group(1)) \
                        and not op.group(1).startswith(("INC", "ds")) and last in sym:
                    unused.append((last,) + sym[last])
            if line.startswith("\tmap_actor "):
                cur = cur or last
                a = [x.strip() for x in line.split(";")[0].replace("map_actor", "", 1).split(",")]
                rows[cur].append((a[1], a[5]))
                if len(a) == 9:
                    defs["ACTOR_" + a[8]] = (cur, len(rows[cur]) - 1)
            elif line.startswith("\tmap_actor_end"):
                cur = None
            mm = re.match(r"\tmap_script (\w+),", line)
            if mm and last and "NpcScripts" in last:
                npc_tables.setdefault(last, []).append(mm.group(1))
    for bank, lines in banks:
        placed = build_addresses(bank, lines, sym)
        for i, line in enumerate(lines):
            m = re.match(r"\t(script_\w+) ([^;]*)", line)
            if m and i in placed:
                for const in re.findall(r"\b(ACTOR_\w+)", m.group(2)):
                    if const in defs:
                        named.append((bank, placed[i], const))
    scene = (ROOT / "src" / "engine" / "story" / "scene_0a.asm").read_text()
    text = "\n".join("\n".join(l) for _, l in banks)
    for i, tree in enumerate(re.findall(r"story_location [^,]+, \w+, DataPtr_(\w+)", scene)):
        m = re.search(rf"^{tree}:\n(?:\t;[^\n]*\n)?\tdw (\w+) ; slot 0 EntryPoints", text, re.M)
        ents = []
        if m:
            t = re.search(rf"^{m.group(1)}:\n((?:\t[^\n]*\n)+?)(?=^\S)", text, re.M)
            if t:
                ents = [int(x, 16) for x in re.findall(r"map_entry \$([0-9a-f]{2}),", t.group(1))]
        locs.append((i, ents or [1]))
    return unused, rows, defs, named, npc_tables, locs


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--save", required=True)
    ap.add_argument("--frames", type=int, default=1000000, help="frames per long session")
    ap.add_argument("--per-location", type=int, default=6000)
    args = ap.parse_args()
    try:
        from pyboy import PyBoy
    except ImportError:
        sys.exit("needs PyBoy: pip install pyboy")

    sym = symbols()
    unused, rows, defs, named, npc_tables, locs = targets(sym)
    lists = {f"{b:02x}:{a:04x}": n for n, (b, a) in sym.items() if n in rows}
    addr_name = {f"{a:04x}": n for n, (b, a) in sym.items() if n in npc_tables}
    w = {n: sym[n][1] for n in ("wStoryModeCurrentLocation", "wStoryModeEntryPoint",
                                "wStoryModeExitTriggerRequest", "wGameMode",
                                "wCurrentMinigameStoryMatch", "wMapNpcScriptsPtr")}
    hits, cur = collections.Counter(), {"list": None}
    agree, disagree, chars = collections.Counter(), [], collections.Counter()

    tmp = Path(tempfile.mkdtemp(prefix="audit-"))
    rom = tmp / "audit.gbc"
    shutil.copy(ROOT / "mariotennis.gbc", rom)
    shutil.copy(args.save, str(rom) + ".ram")
    pb = PyBoy(str(rom), window="null", sound_emulated=False, log_level="ERROR")
    pb.set_emulation_speed(0)
    rf, mem = pb.register_file, pb.memory
    hooks = collections.defaultdict(list)

    def same_actor(const, active, slot_row):
        lst, row = defs[const]
        if active not in rows:
            return None
        got = rows[active][slot_row] if slot_row < len(rows[active]) else None
        return got == rows[lst][row]

    for name, b, a in unused:
        hooks[(b, a)].append(lambda n=name: hits.update([n]))

    def on_init():
        cur["list"] = lists.get(f"{rf.A:02x}:{rf.HL:04x}")
    hooks[sym["InitLocationActors"]].append(on_init)

    for b, a, const in named:
        def on_named(c=const):
            ok = same_actor(c, cur["list"], defs[c][1])
            if ok:
                agree["script"] += 1
            elif ok is False:
                disagree.append((c, cur["list"]))
        hooks[(b, a)].append(on_named)

    def on_npc():
        table = addr_name.get(f"{mem[w['wMapNpcScriptsPtr'] + 1]:02x}{mem[w['wMapNpcScriptsPtr']]:02x}")
        for const in npc_tables.get(table, []):
            if const in defs and defs[const][1] + 3 == rf.A:
                ok = same_actor(const, cur["list"], defs[const][1])
                if ok:
                    agree["talk"] += 1
                elif ok is False:
                    disagree.append((const, cur["list"]))
    hooks[sym["RunNpcInteraction"]].append(on_npc)

    def on_char():
        chars[(rf.B, mem[w["wStoryModeCurrentLocation"]], mem[w["wGameMode"]],
               mem[w["wCurrentMinigameStoryMatch"]] << 8 | mem[w["wCurrentMinigameStoryMatch"] + 1])] += 1
    hooks[sym["InitCa00RecordFromCharId"]].append(on_char)

    for (b, a), fns in hooks.items():
        pb.hook_register(b, a, lambda fs: [f() for f in fs], fns)

    rnd = random.Random(1)

    def tap(button, hold=6, after=20):
        pb.button_press(button)
        pb.tick(hold, False)
        pb.button_release(button)
        pb.tick(after, False)

    def play(frames):
        f = 0
        while f < frames:
            r = rnd.random()
            if r < 0.45:
                b, h = rnd.choice(["up", "down", "left", "right"]), rnd.choice([8, 16, 32, 48])
            else:
                b, h = ("a" if r < 0.85 else "b" if r < 0.95 else "start"), 6
            g = rnd.choice([4, 10, 20])
            tap(b, h, g)
            f += h + g

    # boot -> main menu -> story save slot 1
    pb.tick(1000, False)
    tap("start", after=90)
    tap("a", after=90)
    tap("down", after=30)
    for _ in range(6):
        tap("a", after=150)
    story = io.BytesIO()
    pb.save_state(story)
    for loc, ents in locs:
        for entry in ents:
            story.seek(0)
            pb.load_state(story)
            cur["list"] = None
            mem[w["wStoryModeCurrentLocation"]] = loc
            mem[w["wStoryModeEntryPoint"]] = entry
            mem[w["wStoryModeExitTriggerRequest"]] = 0xff
            play(args.per_location)
    story.seek(0)
    pb.load_state(story)
    mem[w["wStoryModeCurrentLocation"]], mem[w["wStoryModeEntryPoint"]] = 3, 1
    mem[w["wStoryModeExitTriggerRequest"]] = 0xff
    play(args.frames)
    pb.stop(save=False)
    shutil.rmtree(tmp)

    print(f"Unused routines executed: {len(hits)} of {len(unused)}")
    for name, n in hits.most_common():
        print(f"    {name} ({n} times)")
    print(f"actor names checked against the active list: {agree['script']} script "
          f"sites, {agree['talk']} talks agree; {len(disagree)} disagree")
    for const, lst in sorted(set(disagree)):
        print(f"    {const} ran under {lst}")
    ids = collections.defaultdict(set)
    for (cid, loc, mode, match), _n in chars.items():
        ids[cid].add((loc, mode, match))
    print("character records loaded (id: location, game mode, match id):")
    for cid in sorted(ids):
        ctx = ", ".join(f"${l:02x}/{m}/${x:04x}" for l, m, x in sorted(ids[cid])[:4])
        print(f"    ${cid:02x}: {ctx}")
    return 1 if hits or disagree else 0


if __name__ == "__main__":
    sys.exit(main())

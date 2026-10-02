#!/usr/bin/env python3
"""Which actor list a story script addresses at each slot operand.

    python3 tools/actorslots.py            report what is resolved and what is not
    python3 tools/actorslots.py --apply    rename every slot number the analysis settles
    python3 tools/actorslots.py --runtime --save maxed-unlocked.sav
                                           check the names against a PyBoy sweep

A story script names an actor by its slot (`script_speak $05`, a
`map_script $05` row), and a slot means a row of whichever `map_actor` list
is active: the location's default list, or a variant a script installed with
`ScriptRespawnLocationActors`. `ACTOR_<list>_<object>` names that row, so a
slot operand may be a name only where the list active at that line is
certain -- or every candidate holds the same actor there.

The analysis follows control flow through the story code carrying the set of
(list, NpcScripts table, exit requested) triples that can hold at each line:

* a location loads with its default list and NpcScripts table; the entry
  point's arrival script runs next, then the init script, each from what the
  step before can leave;
* `ScriptRespawnLocationActors` after `ld hl, <list>` replaces the list on
  that path, and `WriteStoryStateWord` into `wMapNpcScriptsPtr` the table; a
  callee's effect on the pair reaches its caller (per-routine summaries);
* what the player can be walking around under is what the init script and
  every handler can leave, repeated to a fixpoint; a path that has written
  `wStoryModeExitTriggerRequest` ends the visit and leaves nothing;
* facing, tile and exit handlers and actor-script `as_call` routines run
  under any of those, an NpcScripts handler only under the triples holding
  its own table, and a routine dispatched through a `JumpToHL` table of
  labels under what its dispatcher had.

A routine that can also be entered from a place the analysis does not
follow (an unwalked caller, a pointer it does not resolve) only yields names
that do not depend on its entry state. `make check` runs `check()`: a name
whose slot holds a different actor in some list the analysis finds possible
at that line is a failure.
"""
import argparse
import atexit
import collections
import io
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from banksrc import bank_lines, bank_of, build_addresses, holders  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
ANY = "*"
# (macro, argument index) of every script macro argument that is an actor slot
ACTOR_ARGS = {
    ("script_speak", 0), ("script_speak_restore", 0), ("script_set_anim", 0), ("script_face", 0), ("script_wait_idle", 0),
    ("script_set_position", 0), ("script_move_target", 0), ("script_wait_move", 0),
    ("script_set_actor_script", 0), ("script_face_toward", 0), ("script_face_toward", 1),
    ("script_set_speed", 0), ("script_get_actor_state", 0), ("script_wait_actor_script", 0),
    ("script_null_script", 0), ("script_jump_velocity", 0), ("script_face_pair", 0),
    ("script_face_pair", 1), ("script_move_player_to_actor", 0), ("script_set_active", 0),
    ("script_move_angle", 0), ("script_set_objdef", 1), ("script_lock_facing", 0),
    ("script_unlock_facing", 0),
}
FIXED = {"ACTOR_PLAYER", "ACTOR_PLAYER_SHADOW", "ACTOR_PARTNER"}
# The Senior Court's init script picks its list from the same story flags
# ComputeSeniorCourtStage turns into wMapSceneStage2, and neither changes
# during a visit (the matches that change them end it): list A exactly at
# the singles stages after the junior title, B at the doubles ones, the
# default list before either. So a jump on the stage also says which list
# is active. Only ComputeSeniorCourtStage writes the stage in bank $12.
# The Tournament's round lists are installed by LoadIslandOpenRoundNpcs,
# which sets wMapSceneStage to the round alongside; the default list
# survives there only at round 1.
STAGE_LISTS = {
    "SeniorCourtActors_12": ("wMapSceneStage2", {0x00, 0x01}),
    "SeniorCourtActorsA_12": ("wMapSceneStage2", {0x02, 0x03, 0x04, 0x05, 0x09, 0x0b, 0x0d}),
    "SeniorCourtActorsB_12": ("wMapSceneStage2", {0x06, 0x07, 0x08, 0x0a, 0x0c, 0x0e}),
    "TournamentActors_0f": ("wMapSceneStage", {0x00}),
    "IslandOpenRound2Actors_0f": ("wMapSceneStage", {0x01}),
    "IslandOpenSemifinalActors_0f": ("wMapSceneStage", {0x02}),
    "IslandOpenFinalActors_0f": ("wMapSceneStage", {0x03}),
    "IslandOpenRound1ActorsDoubles_0f": ("wMapSceneStage", {0x00}),
    "IslandOpenSemifinalActorsDoubles_0f": ("wMapSceneStage", {0x02}),
    "IslandOpenFinalActorsDoubles_0f": ("wMapSceneStage", {0x03}),
}
STAGE_VARS = {v for v, _ in STAGE_LISTS.values()}
# A tile trigger whose cell is not in the map's own behaviour data runs only
# under the lists installed by the routine that writes the cell:
# LoadIslandOpenRoundNpcs writes trigger $0f for singles, $0e for doubles.
TILE_LISTS = {
    "TournamentTile0F_0f": {"TournamentActors_0f", "IslandOpenRound2Actors_0f",
                            "IslandOpenSemifinalActors_0f", "IslandOpenFinalActors_0f"},
    "TournamentTile0E_0f": {"IslandOpenRound1ActorsDoubles_0f", "IslandOpenSemifinalActorsDoubles_0f",
                            "IslandOpenFinalActorsDoubles_0f"},
}


def constants():
    out = {}
    for inc in (ROOT / "include").glob("*.inc"):
        for m in re.finditer(r"^def (\w+)\s+equ \$([0-9a-f]+)", inc.read_text(), re.M | re.I):
            out[m.group(1)] = int(m.group(2), 16)
    return out


def stage_filter(st, var, ok):
    """Keep the states whose list is not bound to var's stage, or has a stage ok() accepts."""
    return frozenset(x for x in st if STAGE_LISTS.get(x[0], (None,))[0] != var
                     or any(ok(v) for v in STAGE_LISTS[x[0]][1]))
DATA = re.compile(r"\t(db|dw|dn|ds|map_\w+|as_\w+|dslot|INCBIN|INCLUDE|anim_\w+|char_record|"
                  r"story_location|obj_template)\b")
GLOBAL = re.compile(r"^([A-Za-z_]\w*):")
LOCAL = re.compile(r"^\.(\w+):")


class Source:
    def __init__(self):
        self.banks = {bank_of(h): bank_lines(h) for h in holders()}
        self.funcs, self.lab_at, self.owner = {}, {}, {}
        for b, (L, O) in self.banks.items():
            g, starts = None, []
            for i, line in enumerate(L):
                m = GLOBAL.match(line)
                if m:
                    g = m.group(1)
                    self.lab_at[(b, g)] = i
                    starts.append((i, g))
                else:
                    m = LOCAL.match(line)
                    if m and g:
                        self.lab_at[(b, g + "." + m.group(1))] = i
                self.owner[(b, i)] = g
            for k, (i, n) in enumerate(starts):
                self.funcs[n] = (b, i, starts[k + 1][0] if k + 1 < len(starts) else len(L))
        self.lists, self.rowname, self.trees = {}, {}, {}
        for n, (b, i, e) in self.funcs.items():
            body = self.banks[b][0][i + 1:e]
            rows = [x for x in body if x.startswith("\tmap_actor ")]
            if rows and any(x.startswith("\tmap_actor_end") for x in body):
                args = [[a.strip() for a in x.split(";")[0].replace("map_actor", "", 1).split(",")]
                        for x in rows]
                self.lists[n] = [(a[1], a[5]) for a in args]
                self.rowname[n] = [a[8] if len(a) > 8 else None for a in args]
            if any("(map_tree)" in x for x in body[:2]):
                self.trees[n] = {m.group(3): m.group(1) for m in
                                 (re.match(r"\tdw (\w+) ; slot (\d) (\w+)", x) for x in body) if m}
        self.slot_of = {}
        for n, names in self.rowname.items():
            for k, name in enumerate(names):
                if name:
                    self.slot_of["ACTOR_" + name] = (n, k + 3)
        # ACTOR_ROLE_ names: slot and the lists each may be used under
        self.roles = {}
        for m in re.finditer(r"^\tactor_role (\w+), \$([0-9a-f]+), (.*)$",
                             (ROOT / "include" / "actor_roles.inc").read_text(), re.M):
            self.roles["ACTOR_ROLE_" + m.group(1)] = (int(m.group(2), 16),
                                                      {x.strip() for x in m.group(3).split(",")})

    def body(self, name):
        b, i, e = self.funcs[name]
        return self.banks[b][0][i + 1:e]

    def is_story(self, name):
        if name not in self.funcs:
            return False
        b, i, e = self.funcs[name]
        f = str(self.banks[b][1][i][0])
        return "/src/story/" in f or "/src/twins/" in f

    def entry(self, name):
        b, i, e = self.funcs[name]
        return (b, i)

    def handlers(self, table):
        """The code handlers of a map_script / map_entry table."""
        if table not in self.funcs:
            return []
        out = []
        for x in self.body(table):
            m = re.match(r"\tmap_(script|entry) (.*)", x.split(";")[0])
            if m:
                a = [y.strip() for y in m.group(2).split(",")]
                h = a[3] if m.group(1) == "script" else a[4]
                if self.is_story(h):
                    out.append(h)
        return out

    def ident(self, lst, slot):
        rows = self.lists[lst]
        return rows[slot - 3] if 0 <= slot - 3 < len(rows) else None

    def is_table(self, name):
        """A label whose first statement is data: referenced, not entered."""
        for x in self.body(name):
            c = x.split(";")[0].strip()
            if c and not LOCAL.match(c):
                return bool(DATA.match("\t" + c))
        return True


def dispatch(info, st):
    """Jump-table targets with the states that reach each: a stage-indexed
    table's entry only runs at its own stage."""
    out = []
    for t in info:
        if isinstance(t[1], tuple) or (len(t) == 2 and isinstance(t[0], tuple)):
            entry, (var, stage) = t
            out.append((entry, stage_filter(st, var, lambda x, stage=stage: x == stage)))
        else:
            out.append((t, st))
    return out


def entry_of_target(t):
    return t[0] if isinstance(t[0], tuple) else t


class Flow:
    def __init__(self, src):
        self.s = src
        self.tables = {t["NpcScripts"] for t in src.trees.values() if "NpcScripts" in t}
        for n in src.funcs:
            if src.is_story(n):
                for k, x in enumerate(src.body(n)):
                    if "WriteStoryStateWord" in x:
                        m = re.findall(r"ld hl, (\w+)", " ".join(src.body(n)[max(0, k - 3):k]))
                        if m and m[-1] in src.funcs:
                            self.tables.add(m[-1])
        self.cache, self.summ, self.stack = {}, {}, set()
        self.consts = constants()

    def resolve(self, b, i, target):
        s = self.s
        if target.startswith("."):
            return (b, s.lab_at.get((b, s.owner[(b, i)] + target)))
        if (b, target) in s.lab_at:
            return (b, s.lab_at[(b, target)])
        if target in s.funcs:
            return s.entry(target)
        return None

    def step(self, b, i):
        if (b, i) not in self.cache:
            self.cache[(b, i)] = self._step(b, i)
        return self.cache[(b, i)]

    def stage_base(self, prev):
        """If the lines before a dispatch load a stage and subtract one,
        (stage variable, the stage its first entry stands for)."""
        for k in range(len(prev) - 1, -1, -1):
            m = re.match(r"ld a, \[(\w+)\]$", prev[k])
            if m and m.group(1) in STAGE_VARS:
                subs = [re.match(r"sub (\w+)$", x) for x in prev[k + 1:]]
                subs = [m.group(1) for m in subs if m]
                base = self.consts.get(subs[0], None) if subs else 0
                return None if base is None else (m.group(1), base)
        return None

    def stage_compare(self, L, i):
        """(cond, stage, variable) when line i branches on a compare of a loaded stage."""
        code = L[i].split(";")[0].strip()
        m = re.match(r"(?:jr|jp|ret) (nz|z|nc|c)\b", code)
        if not m:
            return None
        k, cmp = i - 1, None
        while k >= 0:
            c = L[k].split(";")[0].strip()
            if not c:
                k -= 1
                continue
            mm = re.match(r"cp (\S+)$", c)
            if mm and cmp is None:
                cmp = mm.group(1)
            elif re.match(r"ld a, \[(\w+)\]$", c) and c[7:-1] in STAGE_VARS:
                var = c[7:-1]
                break
            elif not (mm or re.match(r"(jr|jp) (nz|z|nc|c),", c)):
                return None
            k -= 1
        if k < 0 or cmp is None:
            return None
        value = self.consts.get(cmp, int(cmp.lstrip("$"), 16) if re.match(r"\$[0-9a-f]+$", cmp) else None)
        return None if value is None else (m.group(1), value, var)

    def _step(self, b, i):
        s = self.s
        L = s.banks[b][0]
        code = L[i].split(";")[0].strip()
        if not code or re.match(r"^\.?\w+:", code):
            return ("nop", None)
        if DATA.match("\t" + code):
            return ("data", None)
        prev = [x.split(";")[0].strip() for x in L[max(0, i - 8):i]]
        if code == "rst Rst00":
            # JumpTableDispatch pops the return address: the dw rows after it
            # are jump targets, and their returns are this routine's
            tg = []
            for x in L[i + 1:]:
                mm = re.match(r"\tdw (\S+)", x.split(";")[0])
                if not mm:
                    break
                r = self.resolve(b, i, mm.group(1))
                if not (r and r[1] is not None and s.is_story(mm.group(1).split(".")[0])):
                    return ("jump_out", None)
                tg.append(r)
            base = self.stage_base(prev)
            if tg and base is not None:
                tg = [(t, (base[0], base[1] + k)) for k, t in enumerate(tg)]
            return ("multitail", tg) if tg else ("jump_out", None)
        m = re.match(r"(call|farcall) (\w+(?:\.\w+)?)$", code)
        if m:
            t = m.group(2)
            if "RespawnLocationActors" in t:
                lm = re.findall(r"ld hl, (\w+)", " ".join(prev[-3:]))
                return ("install", lm[-1] if lm and lm[-1] in s.lists else ANY)
            if t == "WriteStoryStateWord":
                if any("wMapNpcScriptsPtr" in x for x in prev[-3:]):
                    lm = re.findall(r"ld hl, (\w+)", " ".join(prev[-3:]))
                    return ("table", lm[-1] if lm and lm[-1] in self.tables else ANY)
                return ("nop", None)
            if t in ("JumpToHL", "CallHLInBankA"):
                for x in reversed(prev):
                    mm = re.match(r"(?:ld_hl_indexed|ld hl,) (\w+)$", x)
                    if mm:
                        tb = mm.group(1)
                        if tb in s.funcs and t == "JumpToHL":
                            tg = [y for z in s.body(tb) for y in re.findall(r"\bdw (\w+)", z.split(";")[0])]
                            if tg and all(s.is_story(y) for y in tg):
                                base = self.stage_base(prev)
                                entries = [s.entry(y) for y in tg]
                                if base is not None:
                                    entries = [(e, (base[0], base[1] + k)) for k, e in enumerate(entries)]
                                return ("multicall", entries)
                        break
                return ("unknown_call", None)
            r = self.resolve(b, i, t)
            if r and r[1] is not None and s.is_story(t.split(".")[0]):
                return ("call", r)
            return ("nop", None)
        m = re.match(r"(jp|jr) (?:(nz|z|nc|c), )?(\S+)$", code)
        if m:
            cond, t = m.group(2), m.group(3)
            if t == "hl":
                return ("jump_out", None)
            r = self.resolve(b, i, t)
            if r is None or r[1] is None:
                return ("cjump_out" if cond else "jump_out", None)
            tail = r[0] != b or s.owner[r] != s.owner[(b, i)]
            if tail and not s.is_story(t.split(".")[0]):
                return ("cjump_out" if cond else "jump_out", None)
            if tail:
                return ("ctail" if cond else "tail", r)
            return ("cjump" if cond else "jump", r)
        if re.match(r"reti?$", code):
            return ("ret", None)
        if re.match(r"ret (nz|z|nc|c)$", code):
            return ("cret", None)
        if code == "ld [wStoryModeExitTriggerRequest], a":
            return ("exit_clear" if prev and prev[-1] == "xor a" else "exit_set", None)
        return ("nop", None)

    @staticmethod
    def poison(st):
        return {(ANY, t, e) for (_, t, e) in st} | {(l, ANY, e) for (l, _, e) in st}

    def run(self, entry, state, record=None, calls=None):
        """Dataflow from entry; returns the triples at its returns."""
        s = self.s
        out, seen = set(), {}
        work = [(entry, frozenset(state))]
        while work:
            (b, i), st = work.pop()
            L = s.banks[b][0]
            while i < len(L):
                old = seen.get((b, i), frozenset())
                if st <= old:
                    break
                st = old | st
                seen[(b, i)] = st
                if record is not None:
                    record.setdefault((b, i), set()).update(st)
                kind, info = self.step(b, i)
                if kind == "data":
                    break
                cmp = self.stage_compare(L, i) if kind in ("cjump", "ctail", "cret", "cjump_out") else None
                if cmp:
                    cond, v, var = cmp
                    test = {"z": lambda x: x == v, "nz": lambda x: x != v,
                            "c": lambda x: x < v, "nc": lambda x: x >= v}[cond]
                    taken = stage_filter(st, var, test)
                    st = stage_filter(st, var, lambda x: not test(x))
                    if kind == "cjump":
                        work.append((info, taken))
                    elif kind == "ctail":
                        if calls is not None:
                            calls.append((info, taken))
                        out |= self.apply(info, taken)
                    elif kind == "cret":
                        out |= taken
                    else:
                        out |= self.poison(taken)
                    kind = "nop"
                if kind == "install":
                    st = frozenset((info, t, e) for (_, t, e) in st)
                elif kind == "table":
                    st = frozenset((l, info, e) for (l, _, e) in st)
                elif kind == "exit_set":
                    st = frozenset((l, t, True) for (l, t, _) in st)
                elif kind == "exit_clear":
                    st = frozenset((l, t, False) for (l, t, _) in st)
                elif kind in ("call", "multicall"):
                    res = set()
                    for ce, cs in (dispatch(info, st) if kind == "multicall" else [(info, st)]):
                        if calls is not None:
                            calls.append((ce, cs))
                        res |= self.apply(ce, cs)
                    st = frozenset(res)
                elif kind == "unknown_call":
                    st = frozenset(set(st) | self.poison(st))
                elif kind == "multitail":
                    for ce, cs in dispatch(info, st):
                        if calls is not None:
                            calls.append((ce, cs))
                        out |= self.apply(ce, cs)
                    break
                elif kind in ("tail", "ctail"):
                    if calls is not None:
                        calls.append((info, st))
                    out |= self.apply(info, st)
                    if kind == "tail":
                        break
                elif kind in ("jump", "cjump"):
                    work.append((info, st))
                    if kind == "jump":
                        break
                elif kind == "jump_out":
                    out |= self.poison(st)
                    break
                elif kind == "cjump_out":
                    out |= self.poison(st)
                elif kind == "ret":
                    out |= st
                    break
                elif kind == "cret":
                    out |= st
                ni = i + 1
                if ni < len(L) and GLOBAL.match(L[ni]):
                    nxt = L[ni].split(":")[0]
                    if not s.is_story(nxt):
                        out |= self.poison(st)
                        break
                    if calls is not None:
                        calls.append(((b, ni), st))
                    out |= self.apply((b, ni), st)
                    break
                i = ni
        return out

    def apply(self, entry, st):
        if entry not in self.summ:
            if entry in self.stack:
                return set(st) | self.poison(st)
            self.stack.add(entry)
            self.summ[entry] = self.run(entry, {("IN", "IN", False)})
            self.stack.discard(entry)
        out = set()
        for (l, t, e) in self.summ[entry]:
            for (cl, ct, ce) in st:
                out.add((cl if l == "IN" else l, ct if t == "IN" else t, ce or e))
        return out

    def analyse(self):
        s = self.s
        entry_states = collections.defaultdict(set)
        self.visits = {}
        for tname, tree in s.trees.items():
            default = tree.get("Actors")
            if default not in s.lists:
                continue
            start = {(default, tree.get("NpcScripts"), False)}
            init_in = set(start)
            for h in s.handlers(tree.get("EntryPoints")):
                entry_states[s.entry(h)] |= start
                init_in |= {(l, t, False) for (l, t, e) in self.run(s.entry(h), start) if not e}
            init = tree.get("InitScript")
            if s.is_story(init):
                entry_states[s.entry(init)] |= init_in
                visit = {x for x in self.run(s.entry(init), init_in) if not x[2]}
            else:
                visit = set(init_in)
            common = sum((s.handlers(tree.get(r)) for r in ("FacingScripts", "TileTriggers", "ExitTriggers")), [])
            while True:
                before = set(visit)
                vin = {(l, t, False) for (l, t, _) in visit}
                roots = [(h, {x for x in vin if x[0] in TILE_LISTS[h]} if h in TILE_LISTS else vin)
                         for h in common]
                for tb in {t for (_, t, _) in visit if t in s.funcs}:
                    sub = {x for x in vin if x[1] == tb}
                    roots += [(h, sub) for h in s.handlers(tb)]
                roots += [(h, vin) for h in self.actor_calls({l for (l, _, _) in visit if l in s.lists})]
                for h, sin in roots:
                    visit |= {x for x in self.run(s.entry(h), sin) if not x[2]}
                if visit == before:
                    break
            self.visits[tname] = visit
            for h, sin in roots:
                entry_states[s.entry(h)] |= sin
        self.record, done = {}, {}
        work = list(entry_states.items())
        while work:
            ent, st = work.pop()
            st = frozenset(st)
            old = done.get(ent, frozenset())
            if st <= old:
                continue
            done[ent] = st = old | st
            calls = []
            self.run(ent, st, record=self.record, calls=calls)
            work += [(ce, set(cs)) for ce, cs in calls]
        self.entered = done
        self.find_taint()

    def actor_calls(self, lists):
        s = self.s
        out, seen = set(), set()
        stack = [r[0] for l in lists for r in s.lists[l] if r[0] in s.funcs]
        while stack:
            a = stack.pop()
            if a in seen:
                continue
            seen.add(a)
            for x in s.body(a):
                m = re.match(r"\t(as_call|as_jump) (\w+)", x)
                if m and m.group(2) in s.funcs:
                    if m.group(1) == "as_call" and not m.group(2).startswith("ActorScript"):
                        if s.is_story(m.group(2)):
                            out.add(m.group(2))
                    else:
                        stack.append(m.group(2))
        return out

    def find_taint(self):
        """Routines that can be entered from somewhere the flow did not walk,
        and every routine they call: their names must not depend on entry."""
        s = self.s
        walked = set(self.record)
        modelled = set()
        for tree in s.trees.values():
            for role in ("EntryPoints", "NpcScripts", "FacingScripts", "TileTriggers", "ExitTriggers"):
                modelled |= set(s.handlers(tree.get(role)))
            modelled.add(tree.get("InitScript"))
        for t in self.tables:
            modelled |= set(s.handlers(t))
        dispatched = set()
        for (b, i) in walked:
            k, info = self.step(b, i)
            if k in ("multicall", "multitail"):
                dispatched |= {s.owner[entry_of_target(x)] for x in info}
        ext = set()
        for b, (L, O) in s.banks.items():
            for i, line in enumerate(L):
                code = line.split(";")[0]
                if not code.strip() or re.match(r"^\.?\w+:", code):
                    continue
                k, _ = self.step(b, i)
                if (b, i) in walked and k in ("call", "multicall", "multitail", "tail", "ctail", "jump", "cjump"):
                    continue
                if re.match(r"\s*(map_|as_call|as_jump)", code) or s.owner[(b, i)] in s.trees:
                    continue
                for n in re.findall(r"\b([A-Z]\w+)(?:\.\w+)?\b", code):
                    if n == s.owner[(b, i)] or not s.is_story(n) or n in s.lists or n in s.trees:
                        continue
                    if n.startswith("ActorScript") or s.is_table(n):
                        continue
                    if n in dispatched and re.match(r"\s*dw ", code):
                        continue
                    ext.add(n)
        callees = collections.defaultdict(set)
        for (b, i) in walked:
            k, info = self.step(b, i)
            for t in ([entry_of_target(x) for x in info] if k in ("multicall", "multitail")
                      else [info] if k in ("call", "tail", "ctail") else []):
                callees[s.owner[(b, i)]].add(s.owner[t])
        self.tainted, stack = set(), list(ext)
        while stack:
            f = stack.pop()
            if f not in self.tainted:
                self.tainted.add(f)
                stack += callees[f]
        self.entry_dependent = set()
        for f in self.tainted & {s.owner[k] for k in walked}:
            rec = {}
            self.run(s.entry(f), {("IN", "IN", False)}, record=rec)
            self.entry_dependent |= {k for k, sts in rec.items() if any(l == "IN" for (l, _, _) in sts)}

    def sites(self):
        """Every actor-slot operand the flow reached, with its candidate lists:
        yields (bank, line, macro, arg index, operand, lists or None)."""
        s = self.s
        for (b, k), sts in sorted(self.record.items()):
            m = re.match(r"\t(\w+) (.*)$", s.banks[b][0][k].split(";")[0])
            if not m:
                continue
            args = [a.strip() for a in m.group(2).split(",")]
            ls = {l for (l, _, _) in sts}
            known = ANY not in ls and ls and (b, k) not in self.entry_dependent
            for pos, a in enumerate(args):
                if (m.group(1), pos) in ACTOR_ARGS:
                    yield b, k, m.group(1), pos, a, (sorted(ls) if known else None)
        for tb in sorted(self.tables):
            ls = {l for v in self.visits.values() for (l, t, _) in v if t == tb}
            if not ls or tb not in s.funcs:
                continue
            b, i, e = s.funcs[tb]
            for k in range(i + 1, e):
                m = re.match(r"\tmap_script (\$[0-9a-f]{2}|ACTOR_\w+),", s.banks[b][0][k])
                if m:
                    yield b, k, "map_script", 0, m.group(1), (None if ANY in ls else sorted(ls))


def evaluate(src, flow):
    """(renames, conflicts, counts): renames are (file, line, macro, arg, old, new)."""
    renames, conflicts, counts = [], [], collections.Counter()
    for b, k, op, pos, a, ls in flow.sites():
        f, ln = src.banks[b][1][k]
        twin = src.banks[b][0][k] != Path(f).read_text().split("\n")[ln - 1]
        if a in FIXED:
            continue
        if a in src.roles:
            counts["names"] += 1
            if ls is not None:
                bad = [l for l in ls if l not in src.roles[a][1]]
                if bad:
                    conflicts.append((f, ln, a, bad))
            continue
        if a.startswith("ACTOR_"):
            counts["names"] += 1
            if ls is None:
                continue
            l0, slot = src.slot_of[a]
            bad = [l for l in ls if src.ident(l, slot) != src.ident(l0, slot)]
            if bad:
                conflicts.append((f, ln, a, bad))
        elif re.match(r"\$[0-9a-f]{2}$", a) and int(a[1:], 16) >= 3:
            slot = int(a[1:], 16)
            counts["numbers"] += 1
            if ls is None:
                counts["unknown"] += 1
                continue
            ids = {src.ident(l, slot) for l in ls}
            if None in ids or len(ids) != 1:
                counts["ambiguous"] += 1
            elif twin:
                counts["twin"] += 1
            else:
                renames.append((f, ln, op, pos, a, "ACTOR_" + src.rowname[ls[0]][slot - 3]))
    return renames, conflicts, counts


def check(fail):
    """For tools/check.py: every slot name the flow reaches is consistent."""
    src = Source()
    flow = Flow(src)
    flow.analyse()
    renames, conflicts, counts = evaluate(src, flow)
    for f, ln, name, bad in conflicts:
        fail("slots", f"{Path(f).relative_to(ROOT)}:{ln}: {name} does not hold in {', '.join(bad)}")
    return counts["names"]


def apply_renames(renames):
    by = collections.defaultdict(lambda: collections.defaultdict(list))
    for f, ln, op, pos, a, name in renames:
        by[f][ln].append((pos, a, name))
    for f, lines in by.items():
        p = Path(f)
        T = p.read_text().split("\n")
        for ln, eds in lines.items():
            code, sep, com = T[ln - 1].partition(" ;")
            m = re.match(r"(\t\w+ )(.*)$", code)
            args = [x.strip() for x in m.group(2).split(",")]
            for pos, a, name in eds:
                assert args[pos] == a, (f, ln, T[ln - 1])
                args[pos] = name
            T[ln - 1] = m.group(1) + ", ".join(args) + (sep + com if sep else "")
        p.write_text("\n".join(T))


# ---- runtime: hook every named site and compare with the list installed

def runtime_job(sym_path, save, state, si, li, frames):
    import eventtest as E
    src = Source()
    sites = collections.defaultdict(list)
    tab_ids = collections.defaultdict(dict)
    sym = E.symbols(sym_path)
    for b, (L, O) in src.banks.items():
        tbl = None
        placed = build_addresses(b, L, sym)
        for i, line in enumerate(L):
            m = GLOBAL.match(line)
            if m:
                tbl = m.group(1)
            m = re.match(r"\t(\w+) ([^;]*)", line)
            if m and i in placed:
                args = [a.strip() for a in m.group(2).split(",")]
                for pos, a in enumerate(args):
                    if (m.group(1), pos) in ACTOR_ARGS and (a in src.slot_of or a in src.roles):
                        sites[(b, placed[i])].append(a)
            m = re.match(r"\tmap_script (ACTOR_\w+),", line)
            if m and m.group(1) in src.slot_of:
                tab_ids[tbl][src.slot_of[m.group(1)][1]] = m.group(1)
    E.code_labels = lambda: []
    g = E.Game(str(ROOT / "mariotennis.gbc"), sym_path, save, 20, set())
    cur = {"list": None}
    res = collections.Counter()

    def judge(name, lst):
        if name in src.roles:
            ok = lst in src.roles[name][1]
        else:
            l0, slot = src.slot_of[name]
            ok = lst in src.lists and src.ident(lst, slot) == src.ident(l0, slot)
        res[(name, lst, ok)] += 1
    olog = g.log

    def log(kind, value):
        if kind == "list":
            cur["list"] = value[:-2] if value.endswith("+0") else None
        elif kind == "talk" and cur["list"]:
            table, idv = value.split("/")
            name = tab_ids.get(table[:-2] if table.endswith("+0") else None, {}).get(int(idv, 16))
            if name:
                judge(name, cur["list"])
        olog(kind, value)
    g.log = log
    for (b, a), names in sites.items():
        def cb(_, names=names):
            if cur["list"]:
                for n in names:
                    judge(n, cur["list"])
        try:
            g.pb.hook_register(b, a, cb, None)
        except ValueError:
            pass
    story = Path(state).read_bytes()
    dbl, on = E.states()[si]
    loc, entries = g.locs[li]
    m, flags = g.mem, g.sym["wGameFlags"][1]
    for entry in entries:
        g.pb.load_state(io.BytesIO(story))
        cur["list"] = None
        for n in E.SINGLES + E.DOUBLES + E.ALWAYS_CLEAR + [E.FLAG_DOUBLES]:
            addr, bit = flags + n // 8, 0x80 >> (n % 8)
            want = n in on or (n == E.FLAG_DOUBLES and dbl)
            m[addr] = (m[addr] | bit) if want else (m[addr] & ~bit & 0xff)
        m[g.sym["wStoryModeCurrentLocation"][1]] = loc
        m[g.sym["wStoryModeEntryPoint"][1]] = entry
        m[g.sym["wStoryModeExitTriggerRequest"][1]] = 0xff
        g.run(E.plan(si * 10000 + li * 100 + entry, frames), frames, 4 * frames)
    g.close()
    return [[n, l, ok, c] for (n, l, ok), c in res.items()]


def runtime(save, jobs, frames, timeout):
    import concurrent.futures
    import eventtest as E
    from runtime_audit import targets
    sym = ROOT / "build" / "mariotennis.sym"
    tmp = Path(tempfile.mkdtemp(prefix="actorslots-"))
    os.environ["EVENTTEST_TMP"] = str(tmp)
    atexit.register(shutil.rmtree, tmp, True)
    state = tmp / "story.state"
    E.boot(str(ROOT / "mariotennis.gbc"), str(sym), save, str(state))
    nloc = len(targets(E.symbols(sym))[5])
    work = [(si, li) for si in range(len(E.states())) for li in range(nloc)]

    def one(job):
        out = tmp / f"{job[0]}_{job[1]}.json"
        try:
            subprocess.run([sys.executable, __file__, "--runtime-job", str(sym), save, str(state),
                            str(job[0]), str(job[1]), str(frames), str(out)],
                           timeout=timeout, capture_output=True)
            return json.loads(out.read_text())
        except (subprocess.TimeoutExpired, OSError, ValueError):
            return None
    total, bad, lost = collections.Counter(), collections.Counter(), 0
    with concurrent.futures.ThreadPoolExecutor(jobs) as ex:
        for r in ex.map(one, work):
            if r is None:
                lost += 1
                continue
            for n, l, ok, c in r:
                (total if ok else bad)[(n, l)] += c
    shutil.rmtree(tmp, True)
    print(f"{sum(total.values())} hits on {len({n for n, _ in total})} names agreed, "
          f"{sum(bad.values())} disagreed; {lost} of {len(work)} runs lost (PyBoy wedges)")
    for (n, l), c in bad.most_common():
        print(f"    {n} under {l}: {c}")
    return 1 if bad else 0


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--apply", action="store_true", help="rename the slot numbers the analysis settles")
    ap.add_argument("--list", action="store_true", help="print each unresolved number and its candidates")
    ap.add_argument("--runtime", action="store_true", help="check the names in a PyBoy sweep")
    ap.add_argument("--save", default=str(ROOT / "maxed-unlocked.sav"))
    ap.add_argument("--jobs", type=int, default=8)
    ap.add_argument("--frames", type=int, default=3000, help="logic frames per entry point")
    ap.add_argument("--timeout", type=int, default=240, help="seconds per (state, location) run")
    ap.add_argument("--runtime-job", nargs=7, help=argparse.SUPPRESS)
    a = ap.parse_args()
    if a.runtime_job:
        sym, save, state, si, li, frames, out = a.runtime_job
        Path(out).write_text(json.dumps(runtime_job(sym, save, state, int(si), int(li), int(frames))))
        return 0
    if a.runtime:
        return runtime(a.save, a.jobs, a.frames, a.timeout)
    src = Source()
    flow = Flow(src)
    flow.analyse()
    renames, conflicts, counts = evaluate(src, flow)
    print(f"{counts['names']} names reached, {len(conflicts)} contradicted; "
          f"{counts['numbers']} numbers reached: {len(renames)} resolvable, {counts['ambiguous']} ambiguous, "
          f"{counts['unknown']} unknown state, {counts['twin']} in twin files")
    for f, ln, name, bad in conflicts:
        print(f"    {Path(f).relative_to(ROOT)}:{ln}: {name} does not hold in {', '.join(bad)}")
    if a.list:
        for b, k, op, pos, arg, ls in flow.sites():
            if re.match(r"\$[0-9a-f]{2}$", arg) and int(arg[1:], 16) >= 3:
                f, ln = src.banks[b][1][k]
                print(f"{Path(f).relative_to(ROOT)}:{ln}: {op} {arg}: {', '.join(ls) if ls else '?'}")
    if a.apply and renames:
        apply_renames(renames)
        print(f"renamed {len(renames)}")
    return 1 if conflicts else 0


if __name__ == "__main__":
    sys.exit(main())

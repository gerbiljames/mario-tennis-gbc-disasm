from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import Location

from .ids import LOCATIONS
from .items import GAME, MINIGAMES

if TYPE_CHECKING:
    from .world import MarioTennisGBCWorld

LOCATION_NAME_TO_ID = {name: loc_id for loc_id, _, name in LOCATIONS}
LOCATION_CONSTANT = {name: const for _, const, name in LOCATIONS}

SINGLES = {
    "Junior Singles": [f"Junior Singles Rank {n}" for n in (4, 3, 2, 1)],
    "Senior Singles": [f"Senior Singles Rank {n}" for n in (4, 3, 2, 1)],
    "Varsity Singles": ["Varsity Singles Rank 4"],
    "Island Open Singles": ["Island Open Singles Round 1", "Island Open Singles Round 2",
                            "Island Open Singles Semifinal", "Island Open Singles Final"],
    "Peach's Castle Singles": ["Singles Dream Match"],
}
DOUBLES = {
    "Junior Doubles": [f"Junior Doubles Rank {n}" for n in (3, 2, 1)],
    "Senior Doubles": [f"Senior Doubles Rank {n}" for n in (3, 2, 1)],
    "Varsity Doubles": ["Varsity Doubles Rank 2"],
    "Island Open Doubles": ["Island Open Doubles Round 1", "Island Open Doubles Semifinal",
                            "Island Open Doubles Final"],
    "Peach's Castle Doubles": ["Doubles Dream Match"],
}
# the regions in pass order: a region needs that many copies of its arc's pass
TIERS = ["Junior", "Senior", "Varsity", "Island Open", "Peach's Castle"]

DRILL_TYPES = ["Service", "Net Game", "Stroke"]
DRILLS = [f"{t} {kind} {n}" for t in DRILL_TYPES for kind in ("Match", "Lesson") for n in (1, 2, 3)]
DRILLS += [f"Tennis Machine Level {n}" for n in (1, 2, 3, 4)] + ["Tennis Machine Master"]
DRILLS += [f"Wall Practice Level {n}" for n in (1, 2, 3, 4)] + ["Wall Practice Master"]
SWING_CONTEST = ["Swing Contest Low Score", "Swing Contest High Score"]
MINIGAME_CLEARS = [f"{game} Level {n}" for game in MINIGAMES for n in (1, 2, 3)]
MINIGAME_RECORDS = ["Shooting Star Record", "Target Shot Record", "Banana Bunch Record"]

FINALS = {"singles": "Island Open Singles Final", "doubles": "Island Open Doubles Final"}
DREAM_MATCHES = {"singles": "Singles Dream Match", "doubles": "Doubles Dream Match"}


class MarioTennisGBCLocation(Location):
    game = GAME


def story_regions(world: MarioTennisGBCWorld) -> dict[str, list[str]]:
    out = {}
    if world.plays_singles:
        out.update(SINGLES)
    if world.plays_doubles:
        out.update(DOUBLES)
    return out


def location_regions(world: MarioTennisGBCWorld) -> dict[str, list[str]]:
    """Region name -> the names of its locations, under the world's options."""
    out = story_regions(world)
    out["Training Court"] = DRILLS + SWING_CONTEST
    if world.options.minigames != world.options.minigames.option_excluded:
        out["Mini-Games"] = MINIGAME_CLEARS + MINIGAME_RECORDS
    return out


def active_location_names(world: MarioTennisGBCWorld) -> list[str]:
    return [name for names in location_regions(world).values() for name in names]


def _groups() -> dict[str, set[str]]:
    groups = {
        "Singles": {n for names in SINGLES.values() for n in names},
        "Doubles": {n for names in DOUBLES.values() for n in names},
        "Ranking Matches": {n for region in (SINGLES, DOUBLES) for k, names in region.items()
                            if k.split()[0] in ("Junior", "Senior", "Varsity") for n in names},
        "Island Open": set(SINGLES["Island Open Singles"] + DOUBLES["Island Open Doubles"]),
        "Dream Match": set(DREAM_MATCHES.values()),
        "Drills": set(DRILLS),
        "Wall Practice": {n for n in DRILLS if n.startswith("Wall")},
        "Tennis Machine": {n for n in DRILLS if n.startswith("Tennis Machine")},
        "Swing Contest": set(SWING_CONTEST),
        "Training Court": set(DRILLS + SWING_CONTEST),
        "Mini-Games": set(MINIGAME_CLEARS + MINIGAME_RECORDS),
        "Mini-Game Records": set(MINIGAME_RECORDS),
    }
    for region in (SINGLES, DOUBLES):
        for name, names in region.items():
            if name.split()[0] in ("Junior", "Senior", "Varsity"):
                groups[name] = set(names)
    for t in DRILL_TYPES:
        groups[t] = {n for n in DRILLS if n.startswith(t + " ")}
    for game in MINIGAMES:
        groups[game] = {n for n in MINIGAME_CLEARS + MINIGAME_RECORDS if n.startswith(game + " ")}
    return groups


LOCATION_NAME_GROUPS = _groups()

assert set(LOCATION_NAME_TO_ID) == {n for g in (SINGLES, DOUBLES) for names in g.values() for n in names} \
    | set(DRILLS + SWING_CONTEST + MINIGAME_CLEARS + MINIGAME_RECORDS), "locations.py and ids.py disagree"

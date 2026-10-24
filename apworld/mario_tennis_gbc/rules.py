from __future__ import annotations

from typing import TYPE_CHECKING

from rule_builder.rules import And, CanReachLocation, Has, HasAny, HasFromList, Or, Rule

from .items import DRILL_LESSONS, DRILL_MATCHES, DROP_SHOT, LOB, MACHINE, MINIGAME_ITEMS, MINIGAMES, SERVES, \
    SHOT_COPIES, STROKES, UT_GLITCH, WALL
from .locations import DREAM_MATCHES, DRILL_TYPES, FINALS, active_location_names, story_regions

if TYPE_CHECKING:
    from .world import MarioTennisGBCWorld


def location_rules(world: MarioTennisGBCWorld) -> dict[str, Rule]:
    """Rules beyond the region a location is in."""
    rules = {}
    for kind, items in (("Match", DRILL_MATCHES), ("Lesson", DRILL_LESSONS)):
        for drill, item in zip(DRILL_TYPES, items):
            for n in (2, 3):
                rules[f"{drill} {kind} {n}"] = Has(item, count=n - 1)
    for room, item in (("Wall Practice", WALL), ("Tennis Machine", MACHINE)):
        for n in (2, 3, 4):
            rules[f"{room} Level {n}"] = Has(item, count=n - 1)
        rules[f"{room} Master"] = Has(item, count=4)
    rules["Swing Contest Low Score"] = Has("Iron Racket")
    rules["Swing Contest High Score"] = Has("Iron Racket")
    minigames = world.options.minigames
    if minigames == minigames.option_progressive:
        for game in MINIGAMES:
            for n in (1, 2, 3):
                rules[f"{game} Level {n}"] = Has(MINIGAME_ITEMS[game], count=n)
    elif minigames == minigames.option_vanilla:
        for game in MINIGAMES:
            for n in (1, 2, 3):
                rules[f"{game} Level {n}"] = Has(MINIGAME_ITEMS[game])
    if world.options.shot_items:
        for name, rule in shot_rules(world).items():
            rules[name] = And(rules[name], rule) if name in rules else rule
    # a coach or room only offers its first level not cleared (ApDrillMatchLocked, the coach scripts, the room
    # stage), so each level also needs the one before it
    tracks = [[f"{drill} {kind} {n}" for n in (1, 2, 3)] for kind in ("Match", "Lesson") for drill in DRILL_TYPES]
    tracks += [[f"{room} Level {n}" for n in (1, 2, 3, 4)] + [f"{room} Master"]
               for room in ("Wall Practice", "Tennis Machine")]
    for track in tracks:
        for before, name in zip(track, track[1:]):
            if before in rules:
                rules[name] = And(rules[before], rules[name]) if name in rules else rules[before]
    return rules


TOPSPIN, SLICE, FLAT_SHOT = STROKES
TOPSPIN_SERVE, SLICE_SERVE, FLAT_SERVE = SERVES
# shots (copies of the shot items, the starting two included) a story tier wants; placeholders to tune in play
TIER_SHOTS = {"Senior": 3, "Varsity": 5, "Island Open": 8, "Peach's Castle": 11}


def shot_rules(world: MarioTennisGBCWorld) -> dict[str, Rule]:
    """What the shot items add: drills that judge a shot, Target Shot's combos, and a shot count per story tier."""
    volley = HasAny(TOPSPIN, SLICE)
    nice_serve = Or(*(Has(serve, count=2) for serve in SERVES))
    # can't be done without the shot: the drill checks it on every point that counts
    rules: dict[str, Rule] = {
        "Stroke Lesson 2": Has(LOB),
        "Stroke Match 2": Has(LOB),
        "Service Lesson 2": And(Has(TOPSPIN_SERVE), Has(SLICE_SERVE)),
        "Service Lesson 3": nice_serve,
        "Net Game Lesson 2": Has(FLAT_SHOT, count=2),
    }
    if world.options.minigames != world.options.minigames.option_excluded:
        # playtested: Perfect Shot can't be scored in without lobbing, nor Target Shot's later levels without
        # the drop shot
        rules.update({f"Perfect Shot Level {n}": Has(LOB) for n in (1, 2, 3)})
        rules.update({f"Target Shot Level {n}": Has(DROP_SHOT) for n in (2, 3)})
    # possible without, through aces, coach errors or a lower score, just not reliably: out of logic, and
    # Universal Tracker shows them as glitched
    possible = {
        "Net Game Match 1": volley,
        "Net Game Lesson 1": volley,
        "Net Game Match 2": And(Has(FLAT_SHOT, count=2), Has(LOB)),
        "Net Game Lesson 3": Has(DROP_SHOT),
        **{f"Service Match {n}": nice_serve for n in (1, 2, 3)},
    }
    if world.options.minigames != world.options.minigames.option_excluded:
        possible.update({f"Target Shot Level {n}": Has(LOB) for n in (2, 3)})
        # a match against two opponents at once: as hard as the Dream Match
        possible.update({f"Two-on-One Level {n}": HasFromList(*SHOT_COPIES, count=TIER_SHOTS["Peach's Castle"])
                         for n in (1, 2, 3)})
    for region, names in story_regions(world).items():
        tier = next((t for t in TIER_SHOTS if region.startswith(t)), None)
        if tier:
            possible.update({name: HasFromList(*SHOT_COPIES, count=TIER_SHOTS[tier]) for name in names})
    for name, rule in possible.items():
        rule = Or(rule, Has(UT_GLITCH))
        rules[name] = And(rules[name], rule) if name in rules else rule
    return rules


def goal_locations(world: MarioTennisGBCWorld) -> list[str]:
    goal = world.options.goal
    if goal == goal.option_completionist:
        return active_location_names(world)
    table = FINALS if goal == goal.option_island_open else DREAM_MATCHES
    return [table[arc] for arc in world.arcs]


def set_all_rules(world: MarioTennisGBCWorld) -> None:
    for name, rule in location_rules(world).items():
        try:
            location = world.get_location(name)
        except KeyError:
            continue
        world.set_rule(location, rule)
    world.set_completion_rule(And(*(CanReachLocation(name) for name in goal_locations(world))))


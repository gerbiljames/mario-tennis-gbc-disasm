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
        for game in ("Shooting Star", "Target Shot", "Banana Bunch"):
            rules[f"{game} Record"] = Has(MINIGAME_ITEMS[game], count=3)
    elif minigames == minigames.option_vanilla:
        for game in MINIGAMES:
            for n in (1, 2, 3):
                rules[f"{game} Level {n}"] = Has(MINIGAME_ITEMS[game])
        for game in ("Shooting Star", "Target Shot", "Banana Bunch"):
            rules[f"{game} Record"] = Has(MINIGAME_ITEMS[game])
    if world.options.shot_items:
        for name, rule in shot_rules(world).items():
            rules[name] = And(rules[name], rule) if name in rules else rule
    return rules


TOPSPIN, SLICE, FLAT_SHOT = STROKES
TOPSPIN_SERVE, SLICE_SERVE, FLAT_SERVE = SERVES
# shots (copies of the shot items, the starting two included) a story tier wants; placeholders to tune in play
TIER_SHOTS = {"Senior": 3, "Varsity": 5, "Island Open": 8, "Peach's Castle": 11}


def shot_rules(world: MarioTennisGBCWorld) -> dict[str, Rule]:
    """What the shot items add: drills that judge a shot, Target Shot's combos, and a shot count per story tier."""
    volley = HasAny(TOPSPIN, SLICE)
    rules = {
        "Net Game Match 1": volley,
        "Net Game Lesson 1": volley,
        "Net Game Match 2": And(Has(FLAT_SHOT, count=2), Has(LOB)),
        "Net Game Lesson 2": Has(FLAT_SHOT, count=2),
        "Net Game Lesson 3": Has(DROP_SHOT),
        "Stroke Match 2": Has(LOB),
        "Stroke Lesson 2": Has(LOB),
        "Service Lesson 2": And(Has(TOPSPIN_SERVE), Has(SLICE_SERVE)),
        "Service Lesson 3": Or(*(Has(serve, count=2) for serve in SERVES)),
    }
    if world.options.minigames != world.options.minigames.option_excluded:
        for name in ("Target Shot Level 2", "Target Shot Level 3", "Target Shot Record"):
            rules[name] = And(Has(LOB), Has(DROP_SHOT))
    # a story match can be won with fewer shots, just not reliably: out of logic, and Universal Tracker says so
    for region, names in story_regions(world).items():
        tier = next((t for t in TIER_SHOTS if region.startswith(t)), None)
        if tier:
            rule = Or(HasFromList(*SHOT_COPIES, count=TIER_SHOTS[tier]), Has(UT_GLITCH))
            rules.update({name: rule for name in names})
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


from __future__ import annotations

from typing import TYPE_CHECKING

from rule_builder.rules import And, CanReachLocation, Has, Rule

from .items import DRILL_LESSONS, DRILL_MATCHES, MACHINE, MINIGAME_ITEMS, MINIGAMES, WALL
from .locations import DREAM_MATCHES, DRILL_TYPES, FINALS, active_location_names

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


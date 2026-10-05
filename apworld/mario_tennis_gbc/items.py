from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import Item, ItemClassification

from .ids import ITEMS

if TYPE_CHECKING:
    from .world import MarioTennisGBCWorld

GAME = "Mario Tennis GBC"

ITEM_NAME_TO_ID = {name: item_id for item_id, _, name in ITEMS}
ITEM_CONSTANT = {name: const for _, const, name in ITEMS}

SINGLES_PASS = "Progressive Singles Pass"
DOUBLES_PASS = "Progressive Doubles Pass"
PASS_COPIES = 4

DRILL_MATCHES = ["Progressive Service Match", "Progressive Net Game Match", "Progressive Stroke Match"]
DRILL_LESSONS = ["Progressive Service Lesson", "Progressive Net Game Lesson", "Progressive Stroke Lesson"]
WALL = "Progressive Wall Practice"
MACHINE = "Progressive Tennis Machine"
DRILL_COPIES = {**{name: 2 for name in DRILL_MATCHES + DRILL_LESSONS}, WALL: 4, MACHINE: 4}

MINIGAMES = ["Boo Blast", "Shooting Star", "Perfect Shot", "Target Shot", "Fruit Fantasy", "Banana Bunch",
             "Treasure Box", "Medallion Match", "Two-on-One"]
MINIGAME_ITEMS = {game: f"Progressive {game}" for game in MINIGAMES}
RACKETS = ["Large Racket", "Small Racket", "Iron Racket", "Silver Racket", "Gold Racket", "Drive Racket"]
SHOES = ["Iron Shoes", "Light Shoes"]
FILLER = "EXP Bundle"

ITEM_NAME_GROUPS = {
    "Class Passes": {SINGLES_PASS, DOUBLES_PASS},
    "Drills": set(DRILL_COPIES),
    "Drill Matches": set(DRILL_MATCHES),
    "Drill Lessons": set(DRILL_LESSONS),
    "Wall and Machine": {WALL, MACHINE},
    "Mini-Games": set(MINIGAME_ITEMS.values()),
    "Rackets": set(RACKETS),
    "Shoes": set(SHOES),
    "Equipment": set(RACKETS + SHOES),
}

PROGRESSION = {SINGLES_PASS, DOUBLES_PASS, *DRILL_COPIES, *MINIGAME_ITEMS.values(), "Iron Racket"}


class MarioTennisGBCItem(Item):
    game = GAME


def classification(name: str) -> ItemClassification:
    if name in PROGRESSION:
        return ItemClassification.progression
    if name == FILLER:
        return ItemClassification.filler
    return ItemClassification.useful


def create_item(world: MarioTennisGBCWorld, name: str) -> MarioTennisGBCItem:
    return MarioTennisGBCItem(name, classification(name), ITEM_NAME_TO_ID[name], world.player)


def item_counts(world: MarioTennisGBCWorld) -> dict[str, int]:
    """The pool before filler, under the world's options."""
    counts = {}
    if world.plays_singles:
        counts[SINGLES_PASS] = PASS_COPIES
    if world.plays_doubles:
        counts[DOUBLES_PASS] = PASS_COPIES
    counts.update(DRILL_COPIES)
    minigames = world.options.minigames
    if minigames == minigames.option_progressive:
        counts.update({name: 3 for name in MINIGAME_ITEMS.values()})
    elif minigames == minigames.option_vanilla:
        counts.update({name: 1 for name in MINIGAME_ITEMS.values()})
    counts.update({name: 1 for name in RACKETS + SHOES})
    return counts


def create_all_items(world: MarioTennisGBCWorld) -> None:
    pool = [create_item(world, name) for name, n in item_counts(world).items() for _ in range(n)]
    locations = len(world.multiworld.get_unfilled_locations(world.player))
    pool += [create_item(world, FILLER) for _ in range(locations - len(pool))]
    world.multiworld.itempool += pool

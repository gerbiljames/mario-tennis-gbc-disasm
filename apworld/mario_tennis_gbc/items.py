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
# Universal Tracker collects this to show what is possible but out of logic; it is never in the pool
UT_GLITCH = "ut_glitch"
STROKES = ["Progressive Topspin", "Progressive Slice", "Progressive Flat Shot"]
LOB, DROP_SHOT = "Lob", "Drop Shot"
SERVES = ["Progressive Topspin Serve", "Progressive Slice Serve", "Progressive Flat Serve"]
# each copy is one shot: the stroke or serve, then its power shot, smash or nice serve
SHOT_COPIES = {**{name: 2 for name in STROKES}, LOB: 1, DROP_SHOT: 1, **{name: 2 for name in SERVES}}

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
    "Shots": set(SHOT_COPIES),
    "Strokes": set(STROKES),
    "Serves": set(SERVES),
}

PROGRESSION = {SINGLES_PASS, DOUBLES_PASS, *DRILL_COPIES, *MINIGAME_ITEMS.values(), "Iron Racket", *SHOT_COPIES}


class MarioTennisGBCItem(Item):
    game = GAME


def classification(name: str) -> ItemClassification:
    if name in PROGRESSION:
        return ItemClassification.progression
    if name == FILLER:
        return ItemClassification.filler
    return ItemClassification.useful


def create_item(world: MarioTennisGBCWorld, name: str) -> MarioTennisGBCItem:
    if name == UT_GLITCH:
        return MarioTennisGBCItem(name, ItemClassification.progression, None, world.player)
    return MarioTennisGBCItem(name, classification(name), ITEM_NAME_TO_ID[name], world.player)


def starting_shots(world: MarioTennisGBCWorld) -> list[str]:
    """One random stroke and one random serve, or none without shot items."""
    if not world.options.shot_items:
        return []
    return [world.random.choice(STROKES), world.random.choice(SERVES)]


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
    if world.options.shot_items:
        counts.update(SHOT_COPIES)
        for name in world.starting_shots:
            counts[name] -= 1
    return counts


def overflow(world: MarioTennisGBCWorld, counts: dict[str, int], locations: int) -> list[str]:
    """The items that go to the start inventory because the pool outgrows the locations: random non-progression
    ones (3, for doubles with shot items and progressive or excluded mini-games)."""
    surplus = sum(counts.values()) - locations
    if surplus <= 0:
        return []
    spare = sorted(name for name, n in counts.items() if name not in PROGRESSION for _ in range(n))
    if surplus > len(spare):
        raise Exception(f"{world.player_name}: {surplus} more items than locations, {len(spare)} can start")
    return world.random.sample(spare, surplus)


def create_all_items(world: MarioTennisGBCWorld) -> None:
    counts = item_counts(world)
    locations = len(world.multiworld.get_unfilled_locations(world.player))
    spare = overflow(world, counts, locations)
    for name in spare:
        counts[name] -= 1
    for name in world.starting_shots + spare:
        world.multiworld.push_precollected(create_item(world, name))
    pool = [create_item(world, name) for name, n in counts.items() for _ in range(n)]
    pool += [create_item(world, FILLER) for _ in range(locations - len(pool))]
    world.multiworld.itempool += pool

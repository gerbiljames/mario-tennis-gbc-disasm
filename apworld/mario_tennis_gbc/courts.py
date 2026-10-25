from __future__ import annotations

from typing import TYPE_CHECKING

from .rom_addresses import constants

if TYPE_CHECKING:
    from .world import MarioTennisGBCWorld

HARD, CLAY, GRASS, COMPOSITION, STAR, CASTLE, TROPICS, JUNGLE, WAREHOUSE = range(9)
CENTER = 0x0c
GRASS_ISLAND_OPEN = 0x0d
# the exhibition courts and Center Court; the rest are drill, mini-game or duplicate grass scenes
POOL = [HARD, CLAY, GRASS, COMPOSITION, STAR, CASTLE, TROPICS, JUNGLE, WAREHOUSE, CENTER]

_ = None
# each match settings row's court (singles rows, then doubles); None: a row no match plays
VANILLA = [
    HARD, HARD, HARD, HARD, HARD, CLAY, CLAY, CLAY, CLAY, CLAY, COMPOSITION, COMPOSITION, _, _, _,
    GRASS, GRASS_ISLAND_OPEN, GRASS_ISLAND_OPEN, GRASS_ISLAND_OPEN, CENTER, GRASS, _, CASTLE, CASTLE, CASTLE,

    HARD, _, HARD, HARD, HARD, CLAY, _, CLAY, CLAY, CLAY, COMPOSITION, _, _, COMPOSITION, COMPOSITION,
    GRASS, _, GRASS_ISLAND_OPEN, GRASS_ISLAND_OPEN, CENTER, GRASS, _, CASTLE, CASTLE, CASTLE,
]
assert len(VANILLA) == 2 * constants["AP_STORY_MATCH_ROWS"]


def court_table(world: MarioTennisGBCWorld) -> bytes:
    """ApCourtTable: each story match's court, or AP_COURT_VANILLA."""
    option, rng = world.options.court_shuffle, world.random
    keep = constants["AP_COURT_VANILLA"]
    if option == option.option_shuffled:
        # the Island Open's grass is the exhibition grass under another id
        story = sorted({GRASS if c == GRASS_ISLAND_OPEN else c for c in VANILLA if c is not None})
        mapping = dict(zip(story, rng.sample(story, len(story))))
        mapping[GRASS_ISLAND_OPEN] = mapping[GRASS]
        return bytes(keep if c is None else mapping[c] for c in VANILLA)
    if option == option.option_randomized:
        return bytes(keep if c is None else rng.choice(POOL) for c in VANILLA)
    return bytes([keep] * len(VANILLA))

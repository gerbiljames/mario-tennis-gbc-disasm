from __future__ import annotations

from typing import TYPE_CHECKING

from . import courts
from .rom_addresses import constants

if TYPE_CHECKING:
    from .world import MarioTennisGBCWorld

# wAiPositionStrategy values; each pairs a rally positioning with a home position between shots
POOL = range(8)

# the singles match settings rows a story match plays
PLAYED = [court is not None for court in courts.VANILLA[:constants["AP_STORY_MATCH_ROWS"]]]


def strategy_table(world: MarioTennisGBCWorld) -> bytes:
    """ApStrategyTable: each singles story match opponent's strategy, or AP_STRATEGY_VANILLA."""
    option, rng = world.options.opponent_strategy, world.random
    keep = constants["AP_STRATEGY_VANILLA"]
    if option == option.option_randomized:
        return bytes(rng.choice(POOL) if played else keep for played in PLAYED)
    return bytes([keep] * len(PLAYED))

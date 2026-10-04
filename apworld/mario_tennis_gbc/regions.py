from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import Region
from rule_builder.rules import Has, True_

from .items import DOUBLES_PASS, SINGLES_PASS
from .locations import LOCATION_NAME_TO_ID, TIERS, MarioTennisGBCLocation, location_regions

if TYPE_CHECKING:
    from .world import MarioTennisGBCWorld

ORIGIN = "Menu"
ACADEMY = "Academy"


def create_and_connect_regions(world: MarioTennisGBCWorld) -> None:
    menu = Region(ORIGIN, world.player, world.multiworld)
    academy = Region(ACADEMY, world.player, world.multiworld)
    world.multiworld.regions += [menu, academy]
    world.create_entrance(menu, academy, True_())
    regions = {}
    for name, names in location_regions(world).items():
        region = Region(name, world.player, world.multiworld)
        for loc in names:
            region.locations.append(MarioTennisGBCLocation(world.player, loc, LOCATION_NAME_TO_ID[loc], region))
        world.multiworld.regions.append(region)
        regions[name] = region
    for arc, pass_item in (("Singles", SINGLES_PASS), ("Doubles", DOUBLES_PASS)):
        for tier, tier_name in enumerate(TIERS):
            region = regions.get(f"{tier_name} {arc}")
            if region is None:
                continue
            world.create_entrance(academy, region, Has(pass_item, count=tier) if tier else True_())
    world.create_entrance(academy, regions["Training Court"], True_())
    if "Mini-Games" in regions:
        world.create_entrance(menu, regions["Mini-Games"], True_())

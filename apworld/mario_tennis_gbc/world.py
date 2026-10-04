from __future__ import annotations

from collections.abc import Mapping
from typing import Any, ClassVar

import settings

from worlds.AutoWorld import World

from . import items, locations, regions, rom, rules, web_world
from . import options as mtgbc_options
from .rom import MarioTennisGBCProcedurePatch


class MarioTennisGBCSettings(settings.Group):
    class RomFile(settings.UserFilePath):
        """File name of the Mario Tennis (USA) Game Boy Color ROM"""
        description = "Mario Tennis (USA) GBC ROM File"
        copy_to = "Mario Tennis (USA).gbc"
        md5s = [MarioTennisGBCProcedurePatch.hash]

    rom_file: RomFile = RomFile(RomFile.copy_to)


class MarioTennisGBCWorld(World):
    """
    Mario Tennis for the Game Boy Color: a tennis RPG. Climb the academy's singles and doubles ladders, train in
    the drills and Mario mini-games, and win the Island Open.
    """
    game = items.GAME
    web = web_world.MarioTennisGBCWebWorld()
    settings_key = "mario_tennis_gbc_options"
    settings: ClassVar[MarioTennisGBCSettings]
    options_dataclass = mtgbc_options.MarioTennisGBCOptions
    options: mtgbc_options.MarioTennisGBCOptions
    location_name_to_id = locations.LOCATION_NAME_TO_ID
    item_name_to_id = items.ITEM_NAME_TO_ID
    item_name_groups = items.ITEM_NAME_GROUPS
    location_name_groups = locations.LOCATION_NAME_GROUPS
    origin_region_name = regions.ORIGIN
    ut_can_gen_without_yaml = True

    auth: bytes

    def generate_early(self) -> None:
        passthrough = getattr(self.multiworld, "re_gen_passthrough", {}).get(self.game)
        if passthrough:
            for name in mtgbc_options.LOGIC_OPTIONS:
                getattr(self.options, name).value = passthrough[name]

    @staticmethod
    def interpret_slot_data(slot_data: dict[str, Any]) -> dict[str, Any]:
        return slot_data

    @property
    def arcs(self) -> list[str]:
        return [arc for arc, plays in (("singles", self.plays_singles), ("doubles", self.plays_doubles)) if plays]

    @property
    def plays_singles(self) -> bool:
        return self.options.story_arcs != self.options.story_arcs.option_doubles

    @property
    def plays_doubles(self) -> bool:
        return self.options.story_arcs != self.options.story_arcs.option_singles

    def create_regions(self) -> None:
        regions.create_and_connect_regions(self)

    def set_rules(self) -> None:
        rules.set_all_rules(self)

    def create_items(self) -> None:
        items.create_all_items(self)

    def create_item(self, name: str) -> items.MarioTennisGBCItem:
        return items.create_item(self, name)

    def get_filler_item_name(self) -> str:
        return items.FILLER

    def generate_basic(self) -> None:
        self.auth = self.random.randbytes(16)

    def generate_output(self, output_directory: str) -> None:
        rom.generate_output(self, output_directory)

    def modify_multidata(self, multidata: dict[str, Any]) -> None:
        import base64
        multidata["connect_names"][base64.b64encode(self.auth).decode()] = \
            multidata["connect_names"][self.player_name]

    def fill_slot_data(self) -> Mapping[str, Any]:
        return self.options.as_dict(*mtgbc_options.LOGIC_OPTIONS)



from __future__ import annotations

import os
import pkgutil
from typing import TYPE_CHECKING

import settings
from worlds.Files import APProcedurePatch, APTokenMixin, APTokenTypes

from .items import ITEM_NAME_TO_ID, GAME
from .locations import LOCATION_NAME_TO_ID, active_location_names
from .rom_addresses import constants, rom_addresses
from .text import fit

if TYPE_CHECKING:
    from .world import MarioTennisGBCWorld

BASE_MD5 = "50af67f7321d84bd052f0e793ee0613c"
NAME_SIZE = constants["AP_NAME_LENGTH"] + 1
NAMES_SIZE = 2 * NAME_SIZE


class MarioTennisGBCProcedurePatch(APProcedurePatch, APTokenMixin):
    hash = BASE_MD5
    game = GAME
    patch_file_ending = ".apmtgbc"
    result_file_ending = ".gbc"
    procedure = [
        ("apply_bsdiff4", ["basepatch.bsdiff4"]),
        ("apply_tokens", ["tokens.bin"]),
    ]

    @classmethod
    def get_source_data(cls) -> bytes:
        return get_base_rom_bytes()

    def write_bytes(self, offset: int, value: bytes | list[int] | int) -> None:
        if isinstance(value, int):
            value = [value]
        self.write_token(APTokenTypes.WRITE, offset, bytes(value))


def get_base_rom_bytes() -> bytes:
    # the settings group checks the file against RomFile.md5s and asks for it if missing
    with open(settings.get_settings()["mario_tennis_gbc_options"]["rom_file"], "rb") as f:
        return f.read()


def option_bytes(world: MarioTennisGBCWorld) -> dict[str, int]:
    o = world.options
    return {
        "ApOptSkipIntro": int(o.skip_intro.value),
        "ApOptStoryArcs": o.story_arcs.value,
        "ApOptMinigames": o.minigames.value,
        "ApOptRemoteItems": int(o.remote_items.value),
        "ApOptGoal": o.goal.value,
        "ApOptMatchSets": o.story_match_sets.value,
        "ApOptMatchGames": o.story_match_games.value,
        "ApOptSwingLow": 60 if o.nerf_swing_contest else 0,
        "ApOptSwingHigh": 90 if o.nerf_swing_contest else 0,
        "ApOptLocationCount": len(active_location_names(world)),
        # the game's wMessageSpeed (Fast 0, Normal 1, Slow 2) + 1
        "ApOptTextSpeed": {o.default_text_speed.option_fast: 1, o.default_text_speed.option_normal: 2,
                           o.default_text_speed.option_slow: 3}[o.default_text_speed.value],
    }


def placement_tables(world: MarioTennisGBCWorld) -> tuple[bytes, bytes]:
    """(ApPlacements, ApLocationNames) for every location id."""
    absent, remote = constants["AP_ITEM_ABSENT"], world.options.remote_items
    placements = bytearray([absent] * len(LOCATION_NAME_TO_ID))
    names = bytearray(NAMES_SIZE * len(LOCATION_NAME_TO_ID))
    for name in active_location_names(world):
        index = LOCATION_NAME_TO_ID[name] - 1
        item = world.get_location(name).item
        placements[index] = constants["AP_ITEM_NONE"]
        if item.player == world.player:
            if not remote:
                placements[index] = ITEM_NAME_TO_ID[item.name]
            # remote: the server sends it back, and that message says so
            continue
        player = world.multiworld.get_player_name(item.player)
        base = index * NAMES_SIZE
        item_name = fit(item.name, "!")
        player_name = fit(player, "to !")
        names[base:base + len(item_name)] = item_name
        names[base + NAME_SIZE:base + NAME_SIZE + len(player_name)] = player_name
    return bytes(placements), bytes(names)


def start_inventory(world: MarioTennisGBCWorld) -> bytes:
    counts = bytearray(constants["AP_ITEM_SLOTS"])
    if not world.options.remote_items:
        for item in world.multiworld.precollected_items[world.player]:
            code = ITEM_NAME_TO_ID[item.name]
            counts[code] = min(counts[code] + 1, 255)
    return bytes(counts[:len(ITEM_NAME_TO_ID) + 1])


def generate_output(world: MarioTennisGBCWorld, output_directory: str) -> None:
    patch = MarioTennisGBCProcedurePatch(player=world.player, player_name=world.player_name)
    patch.write_file("basepatch.bsdiff4", pkgutil.get_data(__name__, "basepatch.bsdiff4"))
    for label, value in option_bytes(world).items():
        patch.write_bytes(rom_addresses[label], value)
    patch.write_bytes(rom_addresses["ApSlotAuth"], world.auth)
    patch.write_bytes(rom_addresses["ApStartInventory"], start_inventory(world))
    placements, names = placement_tables(world)
    patch.write_bytes(rom_addresses["ApPlacements"], placements)
    patch.write_bytes(rom_addresses["ApLocationNames"], names)
    patch.write_file("tokens.bin", patch.get_token_binary())
    out = os.path.join(output_directory, f"{world.multiworld.get_out_file_name_base(world.player)}"
                                         f"{patch.patch_file_ending}")
    patch.write(out)

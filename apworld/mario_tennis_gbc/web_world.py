from BaseClasses import Tutorial
from worlds.AutoWorld import WebWorld

from .options import option_groups


class MarioTennisGBCWebWorld(WebWorld):
    game = "Mario Tennis GBC"
    setup_en = Tutorial(
        "Multiworld Setup Guide",
        "A guide to setting up Mario Tennis GBC for Archipelago.",
        "English",
        "setup_en.md",
        "setup/en",
        ["gerbiljames"],
    )
    tutorials = [setup_en]
    option_groups = option_groups

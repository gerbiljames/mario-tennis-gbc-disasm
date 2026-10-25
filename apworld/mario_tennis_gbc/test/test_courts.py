from ..courts import GRASS, GRASS_ISLAND_OPEN, POOL, VANILLA, court_table
from ..rom_addresses import constants
from . import MarioTennisGBCTestBase

KEEP = constants["AP_COURT_VANILLA"]


class TestCourtShuffle(MarioTennisGBCTestBase):
    def table(self, value: int) -> bytes:
        self.world.options.court_shuffle.value = value
        return court_table(self.world)

    def test_vanilla_keeps_every_court(self) -> None:
        self.assertEqual(self.table(0), bytes([KEEP] * len(VANILLA)))

    def test_shuffled_maps_each_story_court_to_its_own(self) -> None:
        for _ in range(20):
            table = self.table(1)
            mapping = {}
            for vanilla, court in zip(VANILLA, table):
                if vanilla is None:
                    self.assertEqual(court, KEEP)
                    continue
                self.assertIn(court, POOL)
                self.assertEqual(mapping.setdefault(GRASS if vanilla == GRASS_ISLAND_OPEN else vanilla, court), court)
            self.assertEqual(len(set(mapping.values())), len(mapping))

    def test_randomized_picks_from_the_pool(self) -> None:
        table = self.table(2)
        for vanilla, court in zip(VANILLA, table):
            self.assertIn(court, [KEEP] if vanilla is None else POOL)

from ..courts import POOL, VANILLA, court_table
from ..rom_addresses import constants
from . import MarioTennisGBCTestBase

KEEP = constants["AP_COURT_VANILLA"]


class TestCourtShuffle(MarioTennisGBCTestBase):
    def table(self, value: int) -> bytes:
        self.world.options.court_shuffle.value = value
        return court_table(self.world)

    def test_vanilla_keeps_every_court(self) -> None:
        self.assertEqual(self.table(0), bytes([KEEP] * len(VANILLA)))

    def test_shuffled_moves_the_story_courts_between_matches(self) -> None:
        table = self.table(1)
        self.assertEqual([c for v, c in zip(VANILLA, table) if v is None], [KEEP] * VANILLA.count(None))
        self.assertEqual(sorted(c for v, c in zip(VANILLA, table) if v is not None),
                         sorted(c for c in VANILLA if c is not None))

    def test_randomized_picks_from_the_pool(self) -> None:
        table = self.table(2)
        for vanilla, court in zip(VANILLA, table):
            self.assertIn(court, [KEEP] if vanilla is None else POOL)

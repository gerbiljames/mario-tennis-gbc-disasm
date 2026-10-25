from ..rom_addresses import constants
from ..strategies import PLAYED, POOL, strategy_table
from . import MarioTennisGBCTestBase

KEEP = constants["AP_STRATEGY_VANILLA"]


class TestOpponentStrategy(MarioTennisGBCTestBase):
    def table(self, value: int) -> bytes:
        self.world.options.opponent_strategy.value = value
        return strategy_table(self.world)

    def test_vanilla_keeps_every_strategy(self) -> None:
        self.assertEqual(self.table(0), bytes([KEEP] * len(PLAYED)))

    def test_randomized_picks_from_the_pool(self) -> None:
        table = self.table(1)
        for played, strategy in zip(PLAYED, table):
            self.assertIn(strategy, POOL if played else [KEEP])

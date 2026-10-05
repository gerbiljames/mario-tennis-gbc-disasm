from __future__ import annotations

import base64
import logging
from typing import TYPE_CHECKING

from NetUtils import ClientStatus
from worlds._bizhawk import get_cores, guarded_write, read
from worlds._bizhawk.client import BizHawkClient

from .items import GAME
from .rom_addresses import BASEPATCH_ID, constants, ram_addresses, rom_addresses
from .text import fit

if TYPE_CHECKING:
    from worlds._bizhawk.context import BizHawkClientContext

logger = logging.getLogger("Client")

TITLE = b"CGBTENNISAP"
ID_MAGIC = b"MTAP"
LEDGER_MAGIC = b"MTAP"
SEED = constants["AP_CHECKSUM_SEED"]
ITEM_SLOTS = constants["AP_ITEM_SLOTS"]
RECENT = constants["AP_RECENT_ITEMS"]
NAME_LENGTH = constants["AP_NAME_LENGTH"]
RECENT_SIZE = 1 + NAME_LENGTH + 1
LOCATION_BYTES = constants["AP_LOCATION_BYTES"]


def ram(label: str) -> int:
    return ram_addresses[label][1]


def checksum(data: bytes) -> bytes:
    return ((SEED + sum(data)) & 0xffff).to_bytes(2, "little")


def valid(region: bytes) -> bool:
    return checksum(region[:-2]) == region[-2:]


def done_locations(game_region: bytes) -> set[int]:
    """Archipelago ids of the done bits in a game region."""
    bits = game_region[:LOCATION_BYTES]
    return {i + 1 for i in range(LOCATION_BYTES * 8) if bits[i // 8] >> (i % 8) & 1}


def client_region(items: list[tuple[int, str]]) -> bytes:
    """The client region for this list of (item id, sender name) received so far."""
    counts = bytearray(ITEM_SLOTS)
    recent = bytearray(RECENT * RECENT_SIZE)
    for n, (item, sender) in enumerate(items):
        counts[item] = min(counts[item] + 1, 255)
        entry = bytes([item]) + fit(sender, "from !") if sender else bytes([item])
        base = (n % RECENT) * RECENT_SIZE
        recent[base:base + RECENT_SIZE] = entry.ljust(RECENT_SIZE, b"\0")
    body = len(items).to_bytes(2, "little") + bytes(counts) + bytes(recent)
    return body + checksum(body)


class MarioTennisGBCClient(BizHawkClient):
    game = GAME
    system = "GBC"
    patch_suffix = ".apmtgbc"

    async def validate_rom(self, ctx: BizHawkClientContext) -> bool:
        title, ident, remote = await read(ctx.bizhawk_ctx, [
            (0x134, len(TITLE), "ROM"),
            (rom_addresses["ApBasepatchId"], 8, "ROM"),
            (rom_addresses["ApOptRemoteItems"], 1, "ROM"),
        ])
        if title != TITLE:
            if title.startswith(b"CGBTENNIS"):
                logger.info("This is an unpatched Mario Tennis ROM: open your .apmtgbc patch file instead.")
            return False
        if ident[:4] != ID_MAGIC or ident[4:] != BASEPATCH_ID:
            logger.info("This ROM was patched by a different version of the Mario Tennis GBC apworld.")
            return False
        core = (await get_cores(ctx.bizhawk_ctx)).get("GBC")
        if core not in (None, "Gambatte"):
            logger.info(f"Mario Tennis GBC needs BizHawk's Gambatte core for GBC (it is set to {core}).")
            return False
        ctx.game = self.game
        ctx.items_handling = 0b111 if remote[0] else 0b001
        return True

    async def set_auth(self, ctx: BizHawkClientContext) -> None:
        auth = (await read(ctx.bizhawk_ctx, [(rom_addresses["ApSlotAuth"], 16, "ROM")]))[0]
        ctx.auth = base64.b64encode(auth).decode()

    async def game_watcher(self, ctx: BizHawkClientContext) -> None:
        if ctx.server is None or ctx.slot is None:
            return
        header_size = ram("sApHeaderEnd") - ram("sApHeader")
        game_size = ram("sApGameRegionEnd") - ram("sApGameRegion")
        client_size = ram("sApClientRegionEnd") - ram("sApClientRegion")
        header, game, client = await read(ctx.bizhawk_ctx, [
            (ram("sApHeader"), header_size, "CartRAM"),
            (ram("sApGameRegion"), game_size, "CartRAM"),
            (ram("sApClientRegion"), client_size, "CartRAM"),
        ])
        auth = base64.b64decode(ctx.auth) if ctx.auth else b""
        if not valid(header) or header[:4] != LEDGER_MAGIC or header[4:20] != auth:
            return  # the game has not validated this cart's ledger yet
        if valid(game):
            await ctx.check_locations(done_locations(game))
            if game[ram("sApGoal") - ram("sApGameRegion")] and not ctx.finished_game:
                await ctx.send_msgs([{"cmd": "StatusUpdate", "status": ClientStatus.CLIENT_GOAL}])
                ctx.finished_game = True
        received = int.from_bytes(client[:2], "little") if valid(client) else 0
        if received < len(ctx.items_received) or not valid(client):
            items = [(item.item, "" if item.player == ctx.slot else ctx.player_names[item.player])
                     for item in ctx.items_received]
            await guarded_write(ctx.bizhawk_ctx,
                                [(ram("sApClientRegion"), client_region(items), "CartRAM")],
                                [(ram("sApHeader"), header, "CartRAM")])

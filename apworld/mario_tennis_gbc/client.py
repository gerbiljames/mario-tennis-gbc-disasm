from __future__ import annotations

import base64
import logging
import time
from typing import TYPE_CHECKING, Any

from NetUtils import ClientStatus
from Utils import async_start
from worlds._bizhawk import NotConnectedError, RequestFailedError, guarded_write, read
from worlds._bizhawk.client import BizHawkClient

from .items import GAME
from .rom_addresses import BASEPATCH_ID, constants, ram_addresses, rom_addresses
from .text import fit

if TYPE_CHECKING:
    from CommonClient import ClientCommandProcessor
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
DEATH_LEVELS = {"off": 0, "point": constants["AP_DEATHLINK_POINT"], "game": constants["AP_DEATHLINK_GAME"],
                "match": constants["AP_DEATHLINK_MATCH"]}
DEATH_LEVEL_NAMES = {v: k for k, v in DEATH_LEVELS.items()}
# the text width inside ApDeathLinkWindow
DEATH_LINE_WIDTH = (19 - 2) * 8
LOSSES = {DEATH_LEVELS["point"]: "lost a point", DEATH_LEVELS["game"]: "lost a game",
          DEATH_LEVELS["match"]: "lost a match"}


def ram(label: str) -> int:
    return ram_addresses[label][1]


def wram(label: str) -> tuple[int, str]:
    domain, offset = ram_addresses[label]
    return offset, domain


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


def server_up(ctx: BizHawkClientContext) -> bool:
    """Whether a message sent now reaches the server (CommonContext.send_msgs drops it otherwise)."""
    socket = getattr(ctx.server, "socket", None)
    return socket is not None and getattr(socket, "open", True) and not getattr(socket, "closed", False)


def death_link_command(processor: ClientCommandProcessor, which: str, level: str) -> None:
    ctx = processor.ctx
    handler = getattr(ctx, "client_handler", None)
    if not isinstance(handler, MarioTennisGBCClient) or handler.death_levels is None or not server_up(ctx):
        processor.output("Connect to the server with Mario Tennis GBC loaded first.")
        return
    if not level:
        processor.output(f"DeathLink {which}: {DEATH_LEVEL_NAMES[handler.death_levels[which]]}")
        return
    if level.lower() not in DEATH_LEVELS:
        processor.output("Choose off, point, game or match.")
        return
    handler.set_death_levels(ctx, **{which: DEATH_LEVELS[level.lower()]})
    processor.output(f"DeathLink {which}: {level.lower()}")


def cmd_deathlink_send(self: ClientCommandProcessor, level: str = "") -> None:
    """Shows or sets the smallest loss that sends a death: off, point, game or match."""
    death_link_command(self, "send", level)


def cmd_deathlink_receive(self: ClientCommandProcessor, level: str = "") -> None:
    """Shows or sets what a received death costs you: off, point, game or match."""
    death_link_command(self, "receive", level)


COMMANDS = {"deathlink_send": cmd_deathlink_send, "deathlink_receive": cmd_deathlink_receive}


class MarioTennisGBCClient(BizHawkClient):
    game = GAME
    system = "GBC"
    patch_suffix = ".apmtgbc"

    def __init__(self) -> None:
        super().__init__()
        # {"send": level, "receive": level} once connected and the stored levels are back
        self.death_levels: dict[str, int] | None = None
        # slot_data's levels, until data storage answers
        self.death_defaults: dict[str, int] = {}
        # the source of a death received and not yet handed to the game
        self.death_source: str | None = None
        # the times of the deaths we sent, which tell our own apart from another client's on this slot
        self.deaths_sent: set[float] = set()

    @staticmethod
    def death_levels_key(ctx: BizHawkClientContext) -> str:
        return f"mario_tennis_gbc_deathlink_{ctx.team}_{ctx.slot}"

    def set_death_levels(self, ctx: BizHawkClientContext, store: bool = True, **levels: int) -> None:
        self.death_levels = {**(self.death_levels or {"send": 0, "receive": 0}), **levels}
        # the tag only routes deaths to us; sending works without it
        async_start(ctx.update_death_link(bool(self.death_levels["receive"])))
        if store:
            async_start(ctx.send_msgs([{"cmd": "Set", "key": self.death_levels_key(ctx), "default": {},
                                        "want_reply": False,
                                        "operations": [{"operation": "replace", "value": self.death_levels}]}]))

    def on_package(self, ctx: BizHawkClientContext, cmd: str, args: dict[str, Any]) -> None:
        if cmd == "Connected":
            slot_data = args.get("slot_data") or {}
            self.death_source, self.death_levels = None, None
            self.death_defaults = {"send": slot_data.get("death_link_send", 0),
                                   "receive": slot_data.get("death_link_receive", 0)}
            async_start(ctx.send_msgs([{"cmd": "Get", "keys": [self.death_levels_key(ctx)]}]))
        elif cmd == "Retrieved" and self.death_levels_key(ctx) in args.get("keys", {}):
            stored = args["keys"][self.death_levels_key(ctx)]
            levels = dict(self.death_defaults)
            if isinstance(stored, dict):
                levels.update({k: stored[k] for k in ("send", "receive") if stored.get(k) in DEATH_LEVEL_NAMES})
            self.set_death_levels(ctx, store=False, **levels)
        elif cmd == "Bounced" and "DeathLink" in args.get("tags", []):
            data = args.get("data", {})
            source = str(data.get("source", ""))
            own_slot = source == ctx.player_names.get(ctx.slot)
            if own_slot and data.get("time") in self.deaths_sent:
                return
            if self.death_levels and self.death_levels["receive"]:
                self.death_source = "your partner" if own_slot else source

    async def validate_rom(self, ctx: BizHawkClientContext) -> bool:
        title, ident, remote = await read(ctx.bizhawk_ctx, [
            (0x134, len(TITLE), "ROM"),
            (rom_addresses["ApBasepatchId"], 8, "ROM"),
            (rom_addresses["ApOptRemoteItems"], 1, "ROM"),
        ])
        if title != TITLE:
            for name in COMMANDS:
                ctx.command_processor.commands.pop(name, None)
            if title.startswith(b"CGBTENNIS"):
                logger.info("This is an unpatched Mario Tennis ROM: open your .apmtgbc patch file instead.")
            return False
        if ident[:4] != ID_MAGIC or ident[4:] != BASEPATCH_ID:
            logger.info("This ROM was patched by a different version of the Mario Tennis GBC apworld.")
            return False
        ctx.game = self.game
        ctx.items_handling = 0b111 if remote[0] else 0b001
        ctx.command_processor.commands.update(COMMANDS)
        return True

    async def set_auth(self, ctx: BizHawkClientContext) -> None:
        auth = (await read(ctx.bizhawk_ctx, [(rom_addresses["ApSlotAuth"], 16, "ROM")]))[0]
        ctx.auth = base64.b64encode(auth).decode()

    async def game_watcher(self, ctx: BizHawkClientContext) -> None:
        try:
            await self.watch(ctx)
        except (RequestFailedError, NotConnectedError) as exc:
            # uncaught, this would end the watcher task; the next tick retries
            logger.info(f"Lost connection to BizHawk: {exc}")

    async def watch(self, ctx: BizHawkClientContext) -> None:
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
        await self.death_link(ctx)
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

    async def send_death(self, ctx: BizHawkClientContext, cause: str) -> None:
        """ctx.send_death, but noting the time before the Bounce goes out, so the echo can't beat it."""
        ctx.last_death_link = time.time()
        self.deaths_sent.add(ctx.last_death_link)
        logger.info("DeathLink: Sending death to your friends...")
        await ctx.send_msgs([{"cmd": "Bounce", "tags": ["DeathLink"], "data": {
            "time": ctx.last_death_link, "source": ctx.player_names[ctx.slot], "cause": cause}}])

    async def death_link(self, ctx: BizHawkClientContext) -> None:
        """Sends the game's reported loss if it is big enough, and hands it a received death while it is in a match
        (dropped otherwise)."""
        if self.death_levels is None or not server_up(ctx):
            return  # a loss waits in wApDeathOut until it can be sent
        in_match_at, domain = wram("wApDeathInMatch")
        in_match, out, pending = await read(ctx.bizhawk_ctx, [
            (in_match_at, 1, domain), (ram("wApDeathOut"), 1, domain), (ram("wApDeathIn"), 1, domain)])
        if out[0] and await guarded_write(ctx.bizhawk_ctx, [(ram("wApDeathOut"), [0], domain)],
                                          [(ram("wApDeathOut"), out, domain)]):
            if out[0] in LOSSES and self.death_levels["send"] and out[0] >= self.death_levels["send"]:
                await self.send_death(ctx, f"{ctx.player_names[ctx.slot]} {LOSSES[out[0]]}.")
        if self.death_source is None:
            return
        source, self.death_source = self.death_source, None
        level = self.death_levels["receive"]
        if not level:
            return
        if not in_match[0]:
            logger.info("DeathLink: not in a match, mini-game or drill, so it does nothing.")
        elif pending[0]:
            logger.info("DeathLink: the last death has not happened yet, so this one does nothing.")
        elif not await guarded_write(
                ctx.bizhawk_ctx,
                [(ram("wApDeathSource"), fit(source, "from !", DEATH_LINE_WIDTH) + b"\0", domain), (ram("wApDeathIn"), [level], domain)],
                [(in_match_at, in_match, domain), (ram("wApDeathIn"), [0], domain)]):
            logger.info("DeathLink: the match ended first, so it does nothing.")

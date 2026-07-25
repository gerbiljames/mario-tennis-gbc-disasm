"""Execution-coverage dumps -> verified instruction-start offsets."""
import json
from pathlib import Path

from .rom import BANK_SIZE


def load_coverage(paths, nbanks):
    """Return a set of ROM offsets that are verified instruction starts.

    Accepts three dump shapes, auto-detected per file:

    - Old connector/MCP dump (`fixed`/`banked`, kept for coverage_raw*.json
      already checked into this repo): addresses are flat ROM offsets
      (validated by decode-chain scoring). `banked` pairs/groups reassemble
      as tag*0x10000 + value, and `fixed` values are flat offsets too,
      except >= $ff00 which is genuine HRAM execution (the OAM DMA stub) and
      not part of the ROM image.
    - Interim mixed dump (`addrs`): one flat list of raw exec-callback
      values, best-effort classified here (0xff00-0xffff is the top-of-bus
      I/O/HRAM/IE window, never ROM; everything else under rom_size counts
      as a flat ROM offset).
    - Current dump (`rom`/`other`): both trace_client.py and
      get_coverage(summarize=False) emit this. `rom` is a clean list of flat
      ROM offsets; the connector pairs the raw and domain-translated
      exec-callback invocations, so RAM/HRAM execution lands in `other`
      instead of leaking into `rom`.

    NOTE: dumps captured before the connector-side pairing fix -- all
    `fixed`/`banked` and `addrs` files, and any `rom`/`other` file written
    while the pre-fix Lua was still loaded (e.g. coverage_match1.json) --
    came from a tracer subject to BizHawk's exec-callback double-fire: every
    instruction reported BOTH its raw CPU bus address AND its
    domain-translated offset, so they contain phantom seeds (e.g. HRAM stub
    execution also appearing as ROM offsets 0x00-0x7e, and banked execution
    also appearing as bank-1-range offsets 0x4000-0x7fff). They still parse,
    and seed()'s invalid/conflict filtering plus the INCBIN fallback keep
    the build byte-perfect, but expect a higher invalid/conflicting seed
    count from them.
    """
    seeds = set()
    dropped = 0
    rom_size = nbanks * BANK_SIZE
    for p in paths:
        d = json.loads(Path(p).read_text())
        flat = []
        if "addrs" in d:
            flat = [v for v in d["addrs"] if not (0xff00 <= v <= 0xffff)]
        elif "rom" in d or "other" in d:
            flat = list(d.get("rom", []))
        else:
            banked = d.get("banked", {})
            if isinstance(banked, dict):  # MCP dump: {"tag": [values...]}
                for tag, vals in banked.items():
                    flat += [int(tag) * 0x10000 + v for v in vals]
            else:  # raw connector: [[tag, value], ...]
                flat += [tag * 0x10000 + v for tag, v in banked]
            flat += [v for v in d.get("fixed", []) if v < 0xff00]
        for v in flat:
            if v < rom_size:
                seeds.add(v)
            else:
                dropped += 1
    if dropped:
        print(f"note: dropped {dropped} out-of-range coverage entries")
    return seeds

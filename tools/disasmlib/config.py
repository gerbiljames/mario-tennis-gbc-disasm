"""Side inputs: the include/*.inc symbol tables and the curated JSON files.

The JSON files are the durable annotations regeneration must not lose --
labels.json (symbol names), data_tables.json (render specs) and
constants.json (named immediates) -- all keyed by flat ROM offset.
"""
import json
import re
from pathlib import Path


def load_hwregs(path):
    """Map $ff00-$ffff addresses to hardware.inc register names."""
    regs = {}
    if not Path(path).exists():
        return regs
    for m in re.finditer(r"^DEF\s+(r\w+)\s+EQU\s+\$(ff[0-9a-f]{2})\b",
                         Path(path).read_text(), re.MULTILINE | re.IGNORECASE):
        regs.setdefault(int(m.group(2), 16), m.group(1))
    return regs


def load_const_defs(path):
    """Map constant name -> value from constants.inc (`def NAME equ $xx`).
    Used to render `enum:<PREFIX>:<cols>` data tables symbolically."""
    defs = {}
    if not Path(path).exists():
        return defs
    for m in re.finditer(r"^def\s+(\w+)\s+equ\s+\$([0-9a-f]+)\b",
                         Path(path).read_text(), re.MULTILINE | re.IGNORECASE):
        defs[m.group(1)] = int(m.group(2), 16)
    return defs


def load_offset_map(path):
    """A curated `{"0x1234": value}` file as {flat offset: value}; {} if absent."""
    if not Path(path).exists():
        return {}
    return {int(k, 0): v
            for k, v in json.loads(Path(path).read_text()).items()}


def load_flag_names(path):
    """flags.json as {flag number: FLAG_NAME}. A flag number is
    `byte * 8 + bit` -- the numbering the *GameFlagByNumber helpers take, and
    the operand the one-argument set_flag/test_flag macro form assembles."""
    if not Path(path).exists():
        return {}
    return {int(k, 0): v
            for k, v in json.loads(Path(path).read_text()).items()
            if not k.startswith("_")}


def load_label_overrides(path):
    """labels.json verbatim ({"0x1234": "Name"}, string keys); {} if absent.

    The keys stay strings: overrides are matched by name (curated helper
    lookups) as often as by offset, and the offset conversion is one call away
    where it is needed.
    """
    if not Path(path).exists():
        return {}
    return json.loads(Path(path).read_text())

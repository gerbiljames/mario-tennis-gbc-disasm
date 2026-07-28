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
    """flags.json -> ({flag number: FLAG_NAME}, {flat offset opt-outs}).

    A flag number is `byte * 8 + bit` -- the numbering the *GameFlagByNumber
    helpers take, and the operand the one-argument set_flag/test_flag macro
    form assembles. `_raw_sites` lists the flag-op sites that must keep the
    numeric `$byte, bit` form because the code there is using the bit as
    scratch rather than for the meaning the name asserts."""
    if not Path(path).exists():
        return {}, set()
    raw = json.loads(Path(path).read_text())
    return ({int(k, 0): v for k, v in raw.items() if not k.startswith("_")},
            {int(o, 0) for o in raw.get("_raw_sites", {})})


def _label_entries(path):
    if not Path(path).exists():
        return {}
    return json.loads(Path(path).read_text())


def load_label_overrides(path):
    """labels.json as {"0x1234": "Name"}, string keys; {} if absent.

    A value may be the bare name or {"name": ..., "note": ...} -- the note is
    dropped here so every consumer keeps seeing a plain name, and
    load_label_notes reads the other half.

    The keys stay strings: overrides are matched by name (curated helper
    lookups) as often as by offset, and the offset conversion is one call away
    where it is needed.
    """
    return {k: (v["name"] if isinstance(v, dict) else v)
            for k, v in _label_entries(path).items()}


def load_label_notes(path):
    """{flat offset: note} for the labels.json entries that carry prose.

    A note is what the address comment and the name together cannot say: why a
    routine exists, what its arguments mean, what is wrong with it. The emitter
    renders it as a comment block above the label, the same way ram_map.json
    notes appear above a RAM symbol -- so an explanation lives at the point of
    use rather than in the changelog.
    """
    return {int(k, 0): v["note"] for k, v in _label_entries(path).items()
            if isinstance(v, dict) and v.get("note")}

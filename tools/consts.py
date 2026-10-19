"""The numeric constants of include/, by name: `def NAME equ <number>` lines
and the `const_def` / `const` / `const_skip` enumerations, with the
`def NUM_* equ const_value` counts that close them."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
_DEF_RE = re.compile(r"def (\w+)\s+equ (\$[0-9a-f]+|%[01]+|\d+|const_value)$", re.I)


def _num(s):
    s = s.strip()
    if s.startswith("$"):
        return int(s[1:], 16)
    if s.startswith("%"):
        return int(s[1:], 2)
    return int(s)


def constants(files=None):
    """{name: value} over `files` (default: every include/**/*.inc)."""
    out = {}
    for f in files or sorted((ROOT / "include").rglob("*.inc")):
        value, step = 0, 1
        for line in Path(f).read_text().splitlines():
            code = line.split(";")[0].strip()
            m = _DEF_RE.match(code)
            if m:
                out[m.group(1)] = value if m.group(2) == "const_value" else _num(m.group(2))
                continue
            m = re.match(r"const_def(?:\s+([^,]+?)(?:,\s*(\S+))?)?$", code)
            if m:
                value = _num(m.group(1)) if m.group(1) else 0
                step = _num(m.group(2)) if m.group(2) else 1
                continue
            m = re.match(r"const (\w+)$", code)
            if m:
                out[m.group(1)] = value
                value += step
                continue
            m = re.match(r"const_skip(?:\s+(\S+))?$", code)
            if m:
                value += step * (_num(m.group(1)) if m.group(1) else 1)
    return out

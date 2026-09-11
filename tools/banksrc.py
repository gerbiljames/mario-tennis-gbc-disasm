"""The source of one ROM bank, across its fragment files.

`src/bank_XXX.asm` holds the bank's SECTION line and an ordered list of
`INCLUDE "src/<subsystem>/<topic>_XX.asm"` lines; the code and data live in
those fragments. Tools that read a bank as text use `bank_lines`, which
expands the INCLUDEs in place so line-based analyses see the bank whole, and
`bank_files` to know which files that was."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
_FRAG_RE = re.compile(r'^INCLUDE "(src/[^"]+\.asm)"')
_TWIN_RE = re.compile(r"^\t(twin|twin_named) (\w+), (\w+)")


def _twin_lines(kind, name, arg):
    """The shared routine src/twins/<name>.asm as the bank sees it."""
    body = (ROOT / "src" / "twins" / f"{name}.asm").read_text().split("\n")
    key = "{TWIN}" if kind == "twin" else "{TWIN_LABEL}"
    return [l.replace(key, arg) for l in body]


def holders():
    """The 128 holder files, in bank order."""
    return sorted((ROOT / "src").glob("bank_*.asm"))


def bank_of(holder):
    return int(Path(holder).stem.split("_")[1], 16)


def bank_files(holder):
    """[holder, fragment, fragment, ...] as Paths, in include order."""
    out = [Path(holder)]
    for line in Path(holder).read_text().split("\n"):
        m = _FRAG_RE.match(line)
        if m:
            out.append(ROOT / m.group(1))
    return out


def bank_lines(holder):
    """The bank's source lines with every fragment INCLUDE expanded in place,
    and, per line, the (file, line number) it came from."""
    lines, origin = [], []
    for line in Path(holder).read_text().split("\n"):
        m = _FRAG_RE.match(line)
        if m:
            frag = ROOT / m.group(1)
            for k, fl in enumerate(frag.read_text().split("\n")):
                t = _TWIN_RE.match(fl)
                if t:
                    for tl in _twin_lines(t.group(1), t.group(2), t.group(3)):
                        lines.append(tl)
                        origin.append((frag, k + 1))
                    continue
                lines.append(fl)
                origin.append((frag, k + 1))
        else:
            lines.append(line)
            origin.append((Path(holder), len(lines)))
    return lines, origin


def bank_text(holder):
    return "\n".join(bank_lines(holder)[0])

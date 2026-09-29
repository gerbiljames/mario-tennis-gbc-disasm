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
_TWIN_RE = re.compile(r"^\t(twin|twin_named|twin_in) (\w+), (\w+)(?:, (\w+))?")


def _twin_lines(kind, name, arg, arg2=None):
    """The shared routine src/twins/<name>.asm as the bank sees it."""
    body = (ROOT / "src" / "twins" / f"{name}.asm").read_text().split("\n")
    if kind == "twin":
        subs = {"{TWIN}": arg}
    elif kind == "twin_named":
        subs = {"{TWIN_LABEL}": arg}
    else:
        subs = {"{TWIN_LABEL}": arg, "{TWIN}": arg2}
    out = []
    for l in body:
        for k, v in subs.items():
            l = l.replace(k, v)
        out.append(l)
    return out


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
                    for tl in _twin_lines(t.group(1), t.group(2), t.group(3), t.group(4)):
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


_ADDR_COMMENT = re.compile(r"; \$([0-9a-f]{4})\b")
_LABEL = re.compile(r"^([A-Za-z_]\w*|\.\w+):")


def build_addresses(bank, lines, sym):
    """Where each line that carries an address comment sits in the build.

    The comments give the original ROM's addresses, which an edit that
    changes size leaves stale. Each line is placed relative to the nearest
    label before it (`sym` maps a symbol to (bank, address) in the build):
    its address is the label's plus the line's original offset from it. A
    line with code between that label and itself that carries no comment
    (an inserted or rewritten stretch) is left out rather than guessed.
    Returns {line index: address}."""
    out = {}
    glob = anchor = None
    anchor_orig = None
    dirty = False
    for i, line in enumerate(lines):
        m = _LABEL.match(line)
        if m:
            name = m.group(1)
            if not name.startswith("."):
                glob = name
            full = name if not name.startswith(".") else f"{glob}{name}"
            got = sym.get(full)
            anchor = got[1] if got and got[0] == bank else None
            anchor_orig, dirty = None, False
            continue
        code = line.split(";")[0].strip()
        c = _ADDR_COMMENT.search(line)
        if not code:
            continue
        if not c:
            dirty = True
            continue
        orig = int(c.group(1), 16)
        if anchor_orig is None:
            anchor_orig = orig
        if anchor is not None and not dirty:
            out[i] = anchor + orig - anchor_orig
    return out


def placed_original(bank, lines, sym, orig):
    """The build address of the line whose address comment is `orig`, or
    None when that line is gone or sits in an edited stretch."""
    placed = build_addresses(bank, lines, sym)
    for i, addr in placed.items():
        c = _ADDR_COMMENT.search(lines[i])
        if c and int(c.group(1), 16) == orig:
            return addr
    return None

"""The source of one ROM bank, across its fragment files.

`main.asm` holds one `SECTION "ROM Bank $XX"` per bank, each followed by the
bank's ordered `INCLUDE "src/<subsystem>/<topic>_XX.asm"` lines; the code and
data live in those fragments. `holders()` gives one `Bank` per SECTION. Tools
that read a bank as text use `bank_lines`, which expands the INCLUDEs in place
so line-based analyses see the bank whole, and `bank_files` to know which
files that was."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
_FRAG_RE = re.compile(r'^INCLUDE "(src/[^"]+\.asm)"')
_TWIN_RE = re.compile(r"^\t(twin|twin_named|twin_in) (\w+), (\w+)(?:, (\w+))?")


_EQUS_RE = re.compile(r'^DEF (\w+) EQUS "(.*)"')
_INTERP_RE = re.compile(r"\{(\w+)\}")


def _twin_lines(kind, name, arg, arg2=None, equs=None):
    """The shared routine src/twins/<name>.asm as the bank sees it: {TWIN}
    and {TWIN_LABEL} substituted, then any {SYMBOL} the bank's holder
    defines with EQUS (the per-bank names templates call one another by)."""
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
        while equs and _INTERP_RE.search(l) and any(m in equs for m in _INTERP_RE.findall(l)):
            l = _INTERP_RE.sub(lambda m: equs.get(m.group(1), m.group(0)), l)
        out.append(l)
    return out


MAIN = ROOT / "main.asm"
_SECTION_RE = re.compile(r'^SECTION "ROM Bank \$([0-9a-f]{2})"')


class Bank:
    """One bank's part of main.asm: its SECTION line and what follows, up to
    the next bank's."""

    def __init__(self, bank, lines, start):
        self.bank, self.lines, self.start = bank, lines, start
        self.name = f"main.asm bank ${bank:02x}"

    def __repr__(self):
        return f"<{self.name}>"


def holders():
    """The 128 banks of main.asm, in bank order (the list index is the bank)."""
    out, cur = [], None
    for i, line in enumerate(MAIN.read_text().split("\n")):
        m = _SECTION_RE.match(line)
        if m:
            cur = Bank(int(m.group(1), 16), [], i + 1)
            out.append(cur)
        if cur:
            cur.lines.append(line)
    return sorted(out, key=lambda b: b.bank)


def bank_of(holder):
    return holder.bank


def bank_files(holder):
    """[main.asm, fragment, fragment, ...] as Paths, in include order."""
    out = [MAIN]
    for line in holder.lines:
        m = _FRAG_RE.match(line)
        if m:
            out.append(ROOT / m.group(1))
    return out


def bank_lines(holder):
    """The bank's source lines with every fragment INCLUDE expanded in place,
    and, per line, the (file, line number) it came from."""
    lines, origin = [], []
    equs = {}
    for n, line in enumerate(holder.lines):
        e = _EQUS_RE.match(line)
        if e:
            equs[e.group(1)] = e.group(2)
        m = _FRAG_RE.match(line)
        if m:
            frag = ROOT / m.group(1)
            for k, fl in enumerate(frag.read_text().split("\n")):
                t = _TWIN_RE.match(fl)
                if t:
                    for tl in _twin_lines(t.group(1), t.group(2), t.group(3), t.group(4), equs):
                        lines.append(tl)
                        origin.append((frag, k + 1))
                    continue
                lines.append(fl)
                origin.append((frag, k + 1))
        else:
            lines.append(line)
            origin.append((MAIN, holder.start + n))
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

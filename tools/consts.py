"""The numeric constants of include/, by name: `def NAME equ <number>` lines
and the `const_def` / `const` / `const_skip` enumerations, with the
`def NUM_* equ const_value` counts that close them, and the `rsreset` /
`rsset` / `rb` / `rw` record layouts with `def *_SIZE equ _RS`. A value may be
an expression over numbers and names already read (`|`, `&`, `^`, `+`, `-`,
`*`, `/`, `%`, `<<`, `>>`, `~`, parentheses); one it cannot evaluate is
skipped."""
import ast
import operator
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
_DEF_RE = re.compile(r"def (\w+)\s+equ\s+(.+)$", re.I)
_RS_RE = re.compile(r"def (\w+)\s+(rb|rw|rl)(?:\s+(.+))?$", re.I)
_TOKEN_RE = re.compile(r"\s*(?:(\$[0-9a-f]+)|(%[01]+)|(\d+)|([A-Za-z_][\w.]*)|(<<|>>|[-+*/%|&^~()]))", re.I)
_BINOPS = {ast.BitOr: operator.or_, ast.BitAnd: operator.and_, ast.BitXor: operator.xor,
           ast.Add: operator.add, ast.Sub: operator.sub, ast.Mult: operator.mul,
           ast.LShift: operator.lshift, ast.RShift: operator.rshift,
           ast.Div: lambda a, b: int(a / b), ast.Mod: lambda a, b: a - b * int(a / b)}
_UNOPS = {ast.USub: operator.neg, ast.UAdd: operator.pos, ast.Invert: operator.invert}


def _num(s):
    s = s.strip()
    if s.startswith("$"):
        return int(s[1:], 16)
    if s.startswith("%"):
        return int(s[1:], 2)
    return int(s)


def _eval(node):
    if isinstance(node, ast.Constant) and type(node.value) is int:
        return node.value
    if isinstance(node, ast.BinOp) and type(node.op) in _BINOPS:
        return _BINOPS[type(node.op)](_eval(node.left), _eval(node.right))
    if isinstance(node, ast.UnaryOp) and type(node.op) in _UNOPS:
        return _UNOPS[type(node.op)](_eval(node.operand))
    raise ValueError


def evaluate(expr, names):
    """The value of an RGBDS expression over `names`, or None."""
    out, pos, expr = [], 0, expr.strip()
    while pos < len(expr):
        m = _TOKEN_RE.match(expr, pos)
        if not m or m.end() == pos:
            return None
        pos = m.end()
        hexa, binary, dec, name, op = m.groups()
        if name is not None:
            if name not in names:
                return None
            out.append(f"({names[name]})")
        elif op is not None:
            out.append(op)
        else:
            out.append(str(_num(hexa or binary or dec)))
    try:
        return _eval(ast.parse(" ".join(out), mode="eval").body)
    except (SyntaxError, ValueError, ZeroDivisionError):
        return None


def constants(files=None):
    """{name: value} over `files` (default: every include/**/*.inc)."""
    out = {}
    for f in files or sorted((ROOT / "include").rglob("*.inc")):
        value, step, rs = 0, 1, 0
        for line in Path(f).read_text().splitlines():
            code = line.split(";")[0].strip()
            m = _DEF_RE.match(code)
            if m:
                v = evaluate(m.group(2), {**out, "const_value": value} | ({} if rs is None else {"_RS": rs}))
                if v is not None:
                    out[m.group(1)] = v
                continue
            m = _RS_RE.match(code)
            if m:
                n = evaluate(m.group(3), out) if m.group(3) else 1
                if rs is not None:
                    out[m.group(1)] = rs
                rs = None if rs is None or n is None else rs + {"rb": 1, "rw": 2, "rl": 4}[m.group(2).lower()] * n
                continue
            if code.lower() == "rsreset":
                rs = 0
                continue
            m = re.match(r"rsset\s+(.+)$", code, re.I)
            if m:
                rs = evaluate(m.group(1), out | ({} if rs is None else {"_RS": rs}))
                continue
            m = re.match(r"rb_skip(?:\s+(.+))?$", code)
            if m:
                n = evaluate(m.group(1), out) if m.group(1) else 1
                rs = None if rs is None or n is None else rs + n
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

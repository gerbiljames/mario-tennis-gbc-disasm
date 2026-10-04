"""Names in the game's dialogue font: GlyphWidths_05 ($05:$7f80) for ASCII $20-$7a, in pixels."""

WIDTHS = bytes([
    5, 4, 6, 6, 6, 6, 7, 4, 4, 4, 6, 6, 4, 6, 4, 6,
    6, 4, 6, 6, 6, 6, 6, 6, 6, 6, 4, 4, 5, 6, 5, 6,
    8, 6, 6, 6, 6, 6, 6, 6, 6, 4, 5, 6, 6, 8, 6, 7,
    6, 7, 6, 6, 6, 6, 6, 8, 6, 6, 6, 4, 6, 4, 6, 6,
    5, 7, 6, 6, 6, 6, 4, 6, 6, 3, 4, 6, 4, 8, 6, 6,
    6, 6, 5, 6, 4, 6, 6, 8, 6, 6, 6,
])
LINE_WIDTH = 144
NAME_LENGTH = 24
_MAP = {"`": "'", "{": "(", "}": ")", "|": "/", "~": "-"}


def to_font(name: str) -> str:
    out = []
    for ch in name:
        ch = _MAP.get(ch, ch)
        if ord(ch) < 0x20:
            ch = " "
        elif ord(ch) > 0x7a:
            ch = "?"
        out.append(ch)
    return "".join(out)


def width(text: str) -> int:
    return sum(WIDTHS[ord(ch) - 0x20] for ch in text)


def fit(name: str, fixed: str = "") -> bytes:
    """`name` in the font, cut with "..." so that it and `fixed` (the line's other text) fit a line."""
    name = to_font(name)
    room = LINE_WIDTH - width(fixed)
    if len(name) <= NAME_LENGTH and width(name) <= room:
        return name.encode()
    while name and (len(name) + 3 > NAME_LENGTH or width(name + "...") > room):
        name = name[:-1]
    return (name.rstrip() + "...").encode()

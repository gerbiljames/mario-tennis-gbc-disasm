"""Codec for the sound driver's channel scripts (docs/sound_engine.md).

A script is a run of two-byte commands, opcode then operand, stepped by
RunSoundChannelScript ($00:$3558), which keeps its position as a command
index and reads the command at base + index * 2. One command is four bytes:
`$ac count, target` (snd_call), whose target word is the byte offset of a
command from the track's start. `decode` turns a track's bytes into
commands and refuses anything that does not fit exactly; `render` writes
them as `snd_*` macro rows (include/macros/) that assemble back to the
same bytes; `encode` reads such rows back, which is what `make check` uses
to prove the round trip.

usage: snd.py decode <file.bin> [pulse|wave|noise]   print the rendering
"""
import re
import sys

NOTE_NAMES = ["C_", "C#", "D_", "D#", "E_", "F_", "F#", "G_", "G#", "A_", "A#", "B_"]
NOTE_VALUE = {n: i for i, n in enumerate(NOTE_NAMES)}

# opcode -> (macro, operand rendering); the operand is rendered raw as $xx
SIMPLE = {
    0xa0: "snd_volume", 0xa1: "snd_wave", 0xa2: "snd_duty", 0xa3: "snd_note_length",
    0xa4: "snd_detune", 0xa5: "snd_pan", 0xa6: "snd_master_volume", 0xa7: "snd_glide",
    0xa8: "snd_instrument", 0xa9: "snd_transpose", 0xaa: "snd_echo",
    0xae: "snd_tone_flag", 0xaf: "snd_length_nibble",
}
SIMPLE_OP = {v: k for k, v in SIMPLE.items()}


class Cmd:
    __slots__ = ("off", "op", "arg", "target")

    def __init__(self, off, op, arg, target=None):
        self.off, self.op, self.arg, self.target = off, op, arg, target

    @property
    def size(self):
        return 4 if self.op == 0xac else 2


def decode(data, start=0, end=None):
    """[Cmd] covering data[start:end] exactly, else ValueError."""
    end = len(data) if end is None else end
    cmds, i = [], start
    while i < end:
        if i + 1 >= end:
            raise ValueError(f"odd byte at {i - start}")
        op, arg = data[i], data[i + 1]
        if op == 0xac:
            if i + 3 >= end:
                raise ValueError(f"truncated snd_call at {i - start}")
            cmds.append(Cmd(i - start, op, arg, data[i + 2] | (data[i + 3] << 8)))
            i += 4
        else:
            cmds.append(Cmd(i - start, op, arg))
            i += 2
    starts = {c.off for c in cmds}
    for c in cmds:
        if c.target is not None and c.target not in starts:
            raise ValueError(f"snd_call at {c.off} targets {c.target}, not a command")
    return cmds


def render(data, label, kind="pulse"):
    """The track as macro rows. `kind` is the hardware channel the SoundTable
    row assigns the track to: noise notes are table indices, not pitches."""
    cmds = decode(data)
    targets = sorted({c.target for c in cmds if c.target is not None})
    lab = {t: f".call{n}" for n, t in enumerate(targets)}
    out = [f"\tsnd_track {label}"]
    for c in cmds:
        if c.off in lab:
            out.append(f"{lab[c.off]}:")
        out.append("\t" + render_cmd(c, kind, lab))
    last = cmds[-1] if cmds else None
    if last is not None and not (last.op in (0xff, 0xad, 0xb0) or last.op == 0xac):
        out.append("\t; no terminator: the script runs on into whatever follows")
    return "\n".join(out) + "\n"


def render_cmd(c, kind, lab):
    op, a = c.op, c.arg
    hx = f"${a:02x}"
    if op < 0xa0:
        if kind == "noise":
            return f"snd_noise ${op:02x}, {a}"
        oct_, n = op >> 4, op & 0x0f
        if n < 12:
            return f"snd_note {NOTE_NAMES[n]}, {oct_}, {a}"
        if n == 15:
            return f"snd_hold {oct_}, {a}"
        return f"db ${op:02x}, {hx} ; hold, low nibble {n}"
    if op in SIMPLE:
        return f"{SIMPLE[op]} {hx}"
    if op == 0xac:
        return f"snd_call {a}, {lab[c.target]}"
    if op == 0xad:
        return "snd_return" if a == 0 else f"db $ad, {hx} ; snd_return with a stray operand"
    if op == 0xb0:
        if a >> 4 == 0xf:
            return f"snd_jump {a & 0x0f}"
        return f"db $b0, {hx} ; jump without the $f marker: skipped"
    if 0xb1 <= op <= 0xbf:
        if a >> 4 == 0xf:
            return f"snd_loop {op & 0x0f}, {a & 0x0f}"
        return f"db ${op:02x}, {hx} ; loop without the $f marker"
    if 0xc0 <= op <= 0xcf:
        return f"snd_envelope {op & 0x0f}, {hx}"
    if 0xd0 <= op <= 0xdf:
        return f"snd_volume_up {op & 0x0f}, {hx}"
    if 0xe0 <= op <= 0xef:
        return f"snd_volume_down {op & 0x0f}, {hx}"
    if op == 0xfd:
        if a >> 4 == 0xf:
            return f"snd_loop_point {a & 0x0f}"
        return f"db $fd, {hx} ; loop point without the $f marker"
    if op == 0xff:
        return "snd_end" if a == 0xff else f"db $ff, {hx} ; end with a stray operand"
    return f"db ${op:02x}, {hx} ; unassigned opcode, skipped"


_NUM = re.compile(r"^\$([0-9a-f]+)$|^(\d+)$")


def _num(s):
    s = s.strip()
    m = _NUM.match(s)
    if not m:
        raise ValueError(f"not a number: {s}")
    return int(m.group(1), 16) if m.group(1) is not None else int(m.group(2))


def encode(text):
    """Macro rows (as `render` writes them) back to bytes."""
    lines = [l.split(";")[0].rstrip() for l in text.split("\n")]
    # pass 1: offsets of local labels
    labels, off = {}, 0
    items = []
    for l in lines:
        s = l.strip()
        if not s:
            continue
        if s.endswith(":") and s.startswith("."):
            labels[s[:-1]] = off
            continue
        word, _, rest = s.partition(" ")
        args = [x.strip() for x in rest.split(",")] if rest else []
        size = 4 if word == "snd_call" else (2 if word != "snd_track" else 0)
        items.append((word, args))
        off += size
    out = bytearray()
    for word, args in items:
        if word == "snd_track":
            continue
        if word == "db":
            out += bytes(_num(x) for x in args)
        elif word == "snd_note":
            out += bytes([(_num(args[1]) << 4) | NOTE_VALUE[args[0]], _num(args[2])])
        elif word == "snd_hold":
            out += bytes([(_num(args[0]) << 4) | 0x0f, _num(args[1])])
        elif word == "snd_noise":
            out += bytes([_num(args[0]), _num(args[1])])
        elif word in SIMPLE_OP:
            out += bytes([SIMPLE_OP[word], _num(args[0])])
        elif word == "snd_call":
            t = labels[args[1]]
            out += bytes([0xac, _num(args[0]), t & 0xff, t >> 8])
        elif word == "snd_return":
            out += b"\xad\x00"
        elif word == "snd_jump":
            out += bytes([0xb0, 0xf0 | _num(args[0])])
        elif word == "snd_loop":
            out += bytes([0xb0 | _num(args[0]), 0xf0 | _num(args[1])])
        elif word == "snd_envelope":
            out += bytes([0xc0 | _num(args[0]), _num(args[1])])
        elif word == "snd_volume_up":
            out += bytes([0xd0 | _num(args[0]), _num(args[1])])
        elif word == "snd_volume_down":
            out += bytes([0xe0 | _num(args[0]), _num(args[1])])
        elif word == "snd_loop_point":
            out += bytes([0xfd, 0xf0 | _num(args[0])])
        elif word == "snd_end":
            out += b"\xff\xff"
        else:
            raise ValueError(f"unknown row: {word}")
    return bytes(out)


def main():
    if len(sys.argv) < 3 or sys.argv[1] != "decode":
        print(__doc__)
        return 1
    data = open(sys.argv[2], "rb").read()
    kind = sys.argv[3] if len(sys.argv) > 3 else "pulse"
    sys.stdout.write(render(data, "Track", kind))
    return 0


if __name__ == "__main__":
    sys.exit(main())

"""Codec for the sound driver's channel scripts (docs/sound_engine.md).

A track opens with a four-byte header (tempo, duty or envelope length,
volume, wave or sweep id) that UpdateSoundChannels.loadHeader ($00:$34dd)
reads before setting the command index to 2. The rest is a run of two-byte
commands, opcode then operand, stepped by RunSoundChannelScript ($00:$3558),
which keeps its position as a command index and reads the command at
base + index * 2. One command is four bytes:
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
from pathlib import Path

NOTE_NAMES = ["C_", "C#", "D_", "D#", "E_", "F_", "F#", "G_", "G#", "A_", "A#", "B_"]
NOTE_VALUE = {n: i for i, n in enumerate(NOTE_NAMES)}

HEADER = 4

# opcode -> macro whose operand is rendered raw as $xx
SIMPLE = {
    0xa0: "snd_volume", 0xa1: "snd_wave", 0xa2: "snd_duty", 0xa5: "snd_pan",
    0xa6: "snd_master_volume", 0xa8: "snd_instrument", 0xa9: "snd_switch",
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
    """[Cmd] covering data[start + HEADER:end] exactly, else ValueError.
    Offsets count from `start`, the header's first byte."""
    end = len(data) if end is None else end
    if end - start < HEADER:
        raise ValueError("shorter than the track header")
    cmds, i = [], start + HEADER
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
    out = [f"\tsnd_track {label}", "\t" + render_header(data)]
    for c in cmds:
        if c.off in lab:
            out.append(f"{lab[c.off]}:")
        out.append("\t" + render_cmd(c, kind, lab))
    last = cmds[-1] if cmds else None
    if last is not None and not (last.op in (0xff, 0xad, 0xb0) or last.op == 0xac):
        out.append("\t; no terminator: the script runs on into whatever follows")
    return "\n".join(out) + "\n"


def _small(v):
    return str(v) if v < 0x10 else f"${v:02x}"


def render_header(data):
    tempo, duty, volume, wave = data[:HEADER]
    return f"snd_header {_small(tempo)}, ${duty:02x}, {_small(volume)}, ${wave:02x}"


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
    if op == 0xa3:
        return "snd_vibrato_off" if a == 0xfe else f"snd_vibrato {a >> 4}, {(a & 0x0f) * 2}"
    if op == 0xa4:
        return f"snd_gate {a - 0x100 if a & 0x80 else a}"
    if op == 0xa7:
        return f"snd_wait {a}"
    if op == 0xaa:
        return f"snd_echo {a >> 4}, {a & 0x0f}"
    if op == 0xae:
        if a & ~0x10:
            return f"db $ae, {hx} ; snd_quarter_tone with stray bits"
        return f"snd_quarter_tone {a >> 4}"
    if op == 0xaf:
        return f"snd_tempo {a}" if a < 0x10 else f"db $af, {hx} ; snd_tempo with a high nibble"
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


_NUM = re.compile(r"^\$([0-9a-f]+)$|^(-?\d+)$")


def _num(s):
    s = s.strip()
    m = _NUM.match(s)
    if not m:
        raise ValueError(f"not a number: {s}")
    return int(m.group(1), 16) if m.group(1) is not None else int(m.group(2))


SIZES = {"snd_track": 0, "snd_header": HEADER, "snd_call": 4}


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
        size = SIZES.get(word, 2)
        items.append((word, args))
        off += size
    out = bytearray()
    for word, args in items:
        if word == "snd_track":
            continue
        if word == "db":
            out += bytes(_num(x) for x in args)
        elif word == "snd_header":
            out += bytes(_num(x) for x in args)
        elif word == "snd_vibrato":
            out += bytes([0xa3, (_num(args[0]) << 4) | (_num(args[1]) >> 1)])
        elif word == "snd_vibrato_off":
            out += b"\xa3\xfe"
        elif word == "snd_gate":
            out += bytes([0xa4, _num(args[0]) & 0xff])
        elif word == "snd_wait":
            out += bytes([0xa7, _num(args[0])])
        elif word == "snd_echo":
            out += bytes([0xaa, (_num(args[0]) << 4) | _num(args[1])])
        elif word == "snd_quarter_tone":
            out += bytes([0xae, _num(args[0]) << 4])
        elif word == "snd_tempo":
            out += bytes([0xaf, _num(args[0])])
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
    data = Path(sys.argv[2]).read_bytes()
    kind = sys.argv[3] if len(sys.argv) > 3 else "pulse"
    sys.stdout.write(render(data, "Track", kind))
    return 0


if __name__ == "__main__":
    sys.exit(main())

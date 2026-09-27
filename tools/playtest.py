#!/usr/bin/env python3
"""Play two ROMs side by side under the same inputs and report where their
screens stop agreeing.

The companion to `make shift-test`: build a padded ROM with
`tools/shifttest.py --out padded.gbc`, then

    python3 tools/playtest.py padded.gbc [--save file.sav] [--frames N]

runs it and mariotennis.gbc headless in PyBoy (an optional dependency:
`pip install pyboy pillow numpy`) for N frames with one deterministic,
seeded sequence of button presses, starting from the given battery save.

A shifted build is not cycle-identical to the original -- a table that moves
across a 256-byte page changes when an `add l / jr nc / inc h` lookup takes
its branch, and a frame near the CPU limit can lag -- so a frame counts as
matching when it is within 2% of any original frame up to --window frames
away, and only a mismatch lasting 60 frames or more is reported. Random
input can still diverge honestly once a lag frame moves a press relative to
the game, so a report is where to start looking, and the images written
beside it show the two runs at that point.
"""
import argparse
import os
import random
import shutil
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BUTTONS = ["a", "a", "a", "start", "b", "up", "down", "left", "right", "right", "up"]


def plan(seed, frames, start=900):
    r = random.Random(seed)
    events, f = [], start
    while f < frames:
        events.append((f, r.choice(BUTTONS), r.choice([4, 6, 10, 30])))
        f += r.choice([8, 15, 30, 60, 90])
    return events


def run(rom, save, frames, seed):
    from pyboy import PyBoy
    tmp = Path(tempfile.mkdtemp(prefix="playtest-"))
    copy = tmp / Path(rom).name
    shutil.copy(rom, copy)
    if save:
        shutil.copy(save, str(copy) + ".ram")
    pb = PyBoy(str(copy), window="null", sound_emulated=False, log_level="ERROR")
    pb.set_emulation_speed(0)
    events, k, held, out = plan(seed, frames), 0, [], []
    for f in range(frames):
        while k < len(events) and events[k][0] == f:
            pb.button_press(events[k][1])
            held.append((f + events[k][2], events[k][1]))
            k += 1
        for h in [h for h in held if h[0] == f]:
            pb.button_release(h[1])
            held.remove(h)
        pb.tick(1, True)
        out.append(pb.screen.ndarray[:, :, :3].copy())
    pb.stop(save=False)
    shutil.rmtree(tmp)
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("rom")
    ap.add_argument("--base", default=str(ROOT / "mariotennis.gbc"))
    ap.add_argument("--save", help="battery save to start both runs from")
    ap.add_argument("--frames", type=int, default=20000)
    ap.add_argument("--seed", type=int, default=1)
    ap.add_argument("--window", type=int, default=15)
    args = ap.parse_args()
    try:
        import numpy  # noqa: F401
        from PIL import Image
    except ImportError:
        sys.exit("needs PyBoy, Pillow and numpy: pip install pyboy pillow numpy")

    a = run(args.base, args.save, args.frames, args.seed)
    b = run(args.rom, args.save, args.frames, args.seed)
    limit = 160 * 144 // 50
    streak, transient, bad = 0, 0, None
    for i in range(0, args.frames, 10):
        near = range(max(0, i - args.window), min(args.frames, i + args.window + 1))
        best = min(int((b[i] != a[j]).any(axis=2).sum()) for j in near)
        if best > limit:
            streak += 1
            start = i if streak == 1 else start
            if streak >= 6:
                bad = start
                break
        else:
            transient += bool(streak)
            streak = 0
    print(f"{transient} transient mismatches")
    if bad is None:
        print(f"screens agree for {args.frames} frames")
        return 0
    print(f"persistent mismatch from frame {bad}")
    shots = [max(0, bad - 60), bad, min(args.frames - 1, bad + 60)]
    sheet = Image.new("RGB", (len(shots) * 164, 2 * 148), "white")
    for k, f in enumerate(shots):
        sheet.paste(Image.fromarray(a[f]), (k * 164, 0))
        sheet.paste(Image.fromarray(b[f]), (k * 164, 148))
    out = Path(args.rom).with_suffix(".playtest.png")
    sheet.save(out)
    print(f"base (top) and ROM (bottom) around it: {out}")
    return 1


if __name__ == "__main__":
    sys.exit(main())

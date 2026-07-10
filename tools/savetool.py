#!/usr/bin/env python3
"""Inspect and edit Mario Tennis (GBC) battery saves (32 KiB .sav/SaveRAM).

Format (see docs/save_format.md; engine in bank 3, `WriteSaveBlock` et al.):
header signature at 0x20, a master 16-bit byte-sum of 0x38-0x76f stored at
0x30, a block directory at 0x60 (16-byte entries: valid, SRAM bank, offset,
length, block checksum, tag), and a full mirror of 0x000-0x7ff in SRAM bank 1
(file offset 0x2000). Story slot N lives in block 2N (a 0x300 image of WRAM
c800-caff) with a backup in block 2N+27; character records are 0x40 bytes
(name, +0x18 level, +0x20 eleven 0-9 stats, +0x2c 16-bit EXP, +0x38
spin/power/control/speed levels); the wGameFlags array sits at +0x1c0.

usage: savetool.py file.sav verify
       savetool.py file.sav dump [slot]
       savetool.py file.sav set slot FIELD VALUE [FIELD VALUE ...]
       savetool.py file.sav flag slot INDEX BIT 0|1
       savetool.py file.sav fix

`set` fields: level, exp, top, slice, serve, stroke, volley, angle,
placement, speed, dash, reaction, stop, spinlv, powerlv, controllv, speedlv
(prefix with `partner-` for the partner record). `fix` recomputes every
checksum and the bank-1 mirror after external hex edits. Edits are written
in place; keep a copy if you care about the original.
"""
import argparse
import sys
from pathlib import Path

SIG_OFF, CK_OFF, DIR_OFF = 0x20, 0x30, 0x60
MASTER_LO, MASTER_HI = 0x38, 0x770
NDIR = 0x36 + 27 + 1
SIG = b"CAMELOTGBTENNIS\x00"
BACKUP_DELTA = 27

STATS = ["top", "slice", "serve", "stroke", "volley", "angle",
         "placement", "speed", "dash", "reaction", "stop"]
LEVELS = ["spinlv", "powerlv", "controllv", "speedlv"]


def rd16(b, o):
    return b[o] | (b[o + 1] << 8)


def wr16(b, o, v):
    b[o] = v & 0xFF
    b[o + 1] = (v >> 8) & 0xFF


def entry(sav, i):
    e = DIR_OFF + i * 16
    return {"i": i, "eoff": e, "valid": sav[e], "bank": sav[e + 1],
            "off": rd16(sav, e + 2), "len": rd16(sav, e + 4),
            "ck": rd16(sav, e + 6), "tag": (sav[e + 8] << 8) | sav[e + 9],
            "data": sav[e + 1] * 0x2000 + rd16(sav, e + 2)}


def block_sum(sav, ent):
    return sum(sav[ent["data"]:ent["data"] + ent["len"]]) & 0xFFFF


def fix(sav):
    for i in range(NDIR):
        ent = entry(sav, i)
        if ent["valid"]:
            wr16(sav, ent["eoff"] + 6, block_sum(sav, ent))
    wr16(sav, CK_OFF, sum(sav[MASTER_LO:MASTER_HI]) & 0xFFFF)
    sav[0x2000:0x2800] = sav[0x0000:0x0800]


def verify(sav):
    ok = True
    if bytes(sav[SIG_OFF:SIG_OFF + 16]) != SIG:
        print("signature: BAD")
        ok = False
    m = sum(sav[MASTER_LO:MASTER_HI]) & 0xFFFF
    if rd16(sav, CK_OFF) != m:
        print(f"master checksum: stored {rd16(sav, CK_OFF):#06x} != {m:#06x}")
        ok = False
    if sav[0x2000:0x2800] != sav[0x0000:0x0800]:
        print("bank-1 mirror: DIFFERS")
        ok = False
    for i in range(NDIR):
        ent = entry(sav, i)
        if ent["valid"] and ent["ck"] != block_sum(sav, ent):
            print(f"block {i}: stored {ent['ck']:#06x} != {block_sum(sav, ent):#06x}")
            ok = False
    print("all checksums OK" if ok else "problems found")
    return ok


def char_fields(sav, base):
    name = bytes(sav[base:base + 12]).split(b"\0")[0].decode("ascii", "replace")
    f = {"name": name, "level": sav[base + 0x18], "exp": rd16(sav, base + 0x2c)}
    for k, s in enumerate(STATS):
        f[s] = sav[base + 0x20 + k]
    for k, s in enumerate(LEVELS):
        f[s] = sav[base + 0x38 + k]
    return f


def slot_block(sav, slot):
    ent = entry(sav, slot * 2)
    if not ent["valid"]:
        sys.exit(f"slot {slot} is empty")
    return ent


def dump(sav, slot):
    ent = slot_block(sav, slot)
    for who, off in (("main", 0), ("partner", 0x40)):
        f = char_fields(sav, ent["data"] + off)
        print(f"slot {slot} {who}: {f}")
    flags = sav[ent["data"] + 0x1c0:ent["data"] + 0x200]
    print(f"slot {slot} flags: {bytes(flags).hex()}")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("sav")
    ap.add_argument("cmd", choices=["verify", "dump", "set", "flag", "fix"])
    ap.add_argument("args", nargs="*")
    args = ap.parse_args()
    path = Path(args.sav)
    sav = bytearray(path.read_bytes())
    if len(sav) != 0x8000:
        sys.exit(f"expected 32768-byte save, got {len(sav)}")

    if args.cmd == "verify":
        sys.exit(0 if verify(sav) else 1)
    if args.cmd == "dump":
        slots = [int(args.args[0])] if args.args else range(3)
        for s in slots:
            if entry(sav, s * 2)["valid"]:
                dump(sav, s)
            else:
                print(f"slot {s}: empty")
        return
    if args.cmd == "set":
        slot = int(args.args[0])
        ent = slot_block(sav, slot)
        pairs = args.args[1:]
        if len(pairs) % 2:
            sys.exit("set needs FIELD VALUE pairs")
        for field, val in zip(pairs[::2], pairs[1::2]):
            val = int(val, 0)
            base = ent["data"]
            if field.startswith("partner-"):
                field, base = field[8:], base + 0x40
            if field == "level":
                assert 1 <= val <= 0x63
                sav[base + 0x18] = val
            elif field == "exp":
                wr16(sav, base + 0x2c, val)
            elif field in STATS:
                assert 0 <= val <= 9
                sav[base + 0x20 + STATS.index(field)] = val
            elif field in LEVELS:
                sav[base + 0x38 + LEVELS.index(field)] = val
            else:
                sys.exit(f"unknown field {field}")
    elif args.cmd == "flag":
        slot, idx, bit, val = (int(x, 0) for x in args.args)
        ent = slot_block(sav, slot)
        mask = 0x80 >> bit
        o = ent["data"] + 0x1c0 + idx
        sav[o] = (sav[o] | mask) if val else (sav[o] & ~mask)

    # propagate the edited primary into its bank-1 backup block
    if args.cmd in ("set", "flag"):
        slot = int(args.args[0])
        pri, bak = entry(sav, slot * 2), entry(sav, slot * 2 + BACKUP_DELTA)
        if bak["valid"] and bak["len"] == pri["len"]:
            sav[bak["data"]:bak["data"] + bak["len"]] = \
                sav[pri["data"]:pri["data"] + pri["len"]]
    fix(sav)
    path.write_bytes(sav)
    print("written; checksums fixed")


if __name__ == "__main__":
    main()

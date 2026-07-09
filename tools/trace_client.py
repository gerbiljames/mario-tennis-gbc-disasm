#!/usr/bin/env python3
"""Coverage collection client for the BizHawk gbc-disasm Lua connector.

Talks the line-delimited JSON protocol directly so long traced runs don't
time out, and writes raw coverage straight to a JSON file.

usage: trace_client.py collect <out.json> [--frames N] [--chunk N] [--no-start]
"""
import argparse
import json
import socket
import sys
import time


def connect(timeout=600.0):
    last = None
    for port in range(43300, 43310):
        try:
            s = socket.create_connection(("127.0.0.1", port), timeout=5.0)
            s.settimeout(timeout)
            f = s.makefile("rwb")
            req(f, {"cmd": "PING"})
            return s, f
        except OSError as e:
            last = e
    raise SystemExit(f"no connector on 43300-43309: {last}")


def req(f, obj):
    f.write((json.dumps(obj) + "\n").encode())
    f.flush()
    resp = json.loads(f.readline())
    if not resp.get("ok", False):
        raise RuntimeError(f"{obj['cmd']} failed: {resp.get('error')}")
    return resp


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("out")
    ap.add_argument("--frames", type=int, default=3600)
    ap.add_argument("--chunk", type=int, default=120)
    ap.add_argument("--no-start", action="store_true")
    args = ap.parse_args()

    s, f = connect()
    if not args.no_start:
        req(f, {"cmd": "TRACE_START"})
    done = 0
    t0 = time.time()
    while done < args.frames:
        n = min(args.chunk, args.frames - done)
        req(f, {"cmd": "STEP", "frames": n})
        done += n
        print(f"{done}/{args.frames} frames, {time.time()-t0:.0f}s", flush=True)
    cov = req(f, {"cmd": "TRACE_GET", "clear": False})
    req(f, {"cmd": "TRACE_STOP"})
    with open(args.out, "w") as fh:
        json.dump(cov, fh)
    print(f"wrote {args.out}: rom={len(cov.get('rom', []))} other={len(cov.get('other', []))}")


if __name__ == "__main__":
    main()

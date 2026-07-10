#!/usr/bin/env python3
"""Data-loader argument capture via the BizHawk gbc-disasm Lua connector.

Hooks the entries of CopyDataFromBank ($021a) and DecompressDataFromBank
($0234) and logs the registers of every distinct call, i.e. the h = bank /
l = slot pointer-table arguments (plus bc/de) that the static backtracking
in disasm.py cannot see at dynamically-computed call sites. Requires
connector script version 2+ (HOOKS_* commands); the connector accepts one
client, so disconnect the MCP server first.

usage: hook_client.py start            install hooks, leave them running
       hook_client.py dump <out.json>  fetch snapshots captured so far
       hook_client.py stop             remove hooks
       hook_client.py run <out.json> [--seconds N]
                                       hooks + free-run capture in one go
"""
import argparse
import json
import socket
import time

HELPERS = {0x021A: "copy", 0x0234: "lz"}


def connect(timeout=600.0):
    last = None
    for port in range(43300, 43310):
        try:
            s = socket.create_connection(("127.0.0.1", port), timeout=5.0)
            s.settimeout(timeout)
            f = s.makefile("rwb")
            resp = req(f, {"cmd": "PING"})
            if resp.get("version", 1) < 2:
                raise SystemExit("connector script is v1; reload the updated "
                                 "disasm_connector.lua in BizHawk")
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


def dump(f, path):
    resp = req(f, {"cmd": "HOOKS_GET", "clear": False})
    entries = resp.get("entries") or []
    for e in entries:
        e["kind"] = HELPERS.get(e.get("addr"), "?")
    with open(path, "w") as fh:
        json.dump(entries, fh, indent=1)
    kinds = {}
    for e in entries:
        kinds[e["kind"]] = kinds.get(e["kind"], 0) + 1
    print(f"wrote {path}: {len(entries)} distinct calls {kinds}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("mode", choices=["start", "dump", "stop", "run"])
    ap.add_argument("out", nargs="?")
    ap.add_argument("--seconds", type=int, default=60)
    args = ap.parse_args()
    if args.mode in ("dump", "run") and not args.out:
        ap.error(f"{args.mode} requires an output path")

    s, f = connect()
    if args.mode in ("start", "run"):
        resp = req(f, {"cmd": "HOOKS_START", "addresses": sorted(HELPERS)})
        print(f"hooks installed: {resp}")
    if args.mode == "run":
        req(f, {"cmd": "RESUME"})
        t0 = time.time()
        while time.time() - t0 < args.seconds:
            time.sleep(5)
            n = req(f, {"cmd": "HOOKS_GET", "clear": False}).get("count", 0)
            print(f"{time.time()-t0:3.0f}s: {n} distinct calls", flush=True)
    if args.mode in ("dump", "run"):
        dump(f, args.out)
    if args.mode == "stop":
        print(req(f, {"cmd": "HOOKS_STOP"}))
    s.close()


if __name__ == "__main__":
    main()

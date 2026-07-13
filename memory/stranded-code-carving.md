---
name: stranded-code-carving
description: How to de-blob code banks — recover stranded code + structure dispatch tables, and the over-seeding pitfall
metadata:
  type: project
---

Many code banks carry INCBIN "data" blobs that are actually **stranded code**
reached only through computed dispatch (jump tables read via `jp hl`/`ld hl`
through RAM, invisible to static descent). Proven pattern (banks $20-$23, $07,
$05, $38 all de-blobbed this way; see [[mario-tennis-disasm-project]]):

1. Classify blobs farcall-aware (rst $18/$20/$28/$30 eat 2 inline operand
   bytes). "Code-like" = decodes 0-invalid, tiles to a `ret`/flow boundary,
   sits right after a `ret`. Confirm with idioms (farcalls, known RAM addrs)
   and/or that it's a call/jump/table target.
2. Seed as static code via `coverage/bank0XX_static_code.json`
   (`{"rom":[flat offsets], "other":[]}`, flat = bank*0x4000 + (cpu-0x4000)).
3. Structure dispatch tables: add a `labels.json` name + `data_tables.json`
   `records:2` at the table's flat offset; seed its in-bank targets as code.
   Common shapes: control-code jump tables ($05), N-entry dw table immediately
   followed by its inline handlers ($38's `SubHandlers_38_*`).
4. Regen with `python3 tools/disasm.py baserom.gbc coverage/*.json --hooks
   hooks/*.json`, then `extract.py` + `make clean && make compare` → must stay
   byte-perfect. The pre-existing "6 coverage seeds ... skipped" note is
   baseline noise, not your seeds — confirm it doesn't grow.

**Over-seeding pitfall (bank $38):** do NOT seed every per-byte "entry" a
linear decoder emits. A code blob with a trailing/embedded data table (e.g.
`ld hl,$45ff` reading a param table within the same blob) will have that table
decode as valid-looking instructions; blind seeding decodes it as code
(mislabeled `$45ff` as `jr`). byte-perfect does NOT catch this (bytes
unchanged) — it's a classification error. Instead seed **function starts +
internal call/jump targets only**, and let descent stop at `ret`; data-only
regions (reached via `ld hl`/`ld de`, not control flow) stay data. Recover
externally-dispatched handlers by seeding jump-table targets, not by blind
per-byte seeding.

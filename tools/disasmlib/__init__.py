"""Base ROM + execution coverage -> per-bank RGBDS source.

The pipeline runs in three stages, driven by tools/disasm.py:

  1. analysis  -- pipeline.analyse() proves what is code (core), which
                  $4000-table slots point at data (slots), and what shape the
                  remaining data has (carve), all recorded on one Disassembly.
  2. naming    -- pipeline.resolve_labels() plus ram/config turn proven
                  offsets into symbols.
  3. emission  -- emit.emit() renders each bank, using operands/idioms for
                  code and datatables for carved structures.

Module map:

  rom          flat offsets, CPU addresses, and the mapping between them
  coverage     tracer dumps -> verified instruction-start seeds
  core         decoding, seeding, descent, dispatch-table inference
  slots        $4000 pointer-table data-slot proving
  carve        bulk data-structure carving and shape-matched code recovery
  disassembly  the composed Disassembly object
  seeds        code targets reachable only through indirect dispatch
  labels       symbol naming
  ram          RAM symbol resolution and the generated RAM layout files
  config       side inputs (include/*.inc symbols, curated JSON)
  constants    game constant tables shared by the renderers
  textids      dialogue text-id naming
  operands     instruction operand rendering
  idioms       instruction-sequence -> macro collapsing
  datatables   carved data-table renderers
  macros       the generated include/macros.inc
  emit         per-bank source emission
  pipeline     pass ordering
"""
import sys
from pathlib import Path

# lz, sm83 and extract are standalone tools alongside this package rather than
# part of it, so tools/ has to be importable however disasmlib was reached.
_TOOLS = str(Path(__file__).resolve().parent.parent)
if _TOOLS not in sys.path:
    sys.path.insert(0, _TOOLS)

"""The composed Disassembly object."""
from .carve import StructureCarvingMixin
from .core import DisassemblyBase
from .slots import SlotProvingMixin


class Disassembly(StructureCarvingMixin, SlotProvingMixin, DisassemblyBase):
    """ROM + coverage -> proven code, proven data blobs, and the structure
    tying them together. The passes are ordered by tools/disasmlib/pipeline.py;
    each one only ever adds knowledge, so a pass that finds nothing is a no-op.
    """

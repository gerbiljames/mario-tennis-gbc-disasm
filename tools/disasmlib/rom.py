"""ROM geometry: flat offsets, CPU addresses, and the mapping between them.

A *flat offset* indexes the whole ROM image; a *CPU address* is what the SM83
sees with a bank mapped at $4000. Analysis works in flat offsets throughout and
converts only when rendering source.
"""

BANK_SIZE = 0x4000


def offset_to_cpu(off):
    return off if off < BANK_SIZE else BANK_SIZE + off % BANK_SIZE


def target_to_offset(target, cur_off):
    """Map a CPU-address branch target to a ROM offset, or None if unknowable."""
    if target < BANK_SIZE:
        return target
    if target < 0x8000:
        if cur_off >= BANK_SIZE:  # same switchable bank as the referrer
            return (cur_off // BANK_SIZE) * BANK_SIZE + target - BANK_SIZE
        return None  # bank 0 code jumping into an unknown mapped bank
    return None  # RAM

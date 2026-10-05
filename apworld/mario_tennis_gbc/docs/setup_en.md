# Mario Tennis GBC Setup Guide

## Required software

- [Archipelago](https://github.com/ArchipelagoMW/Archipelago/releases) 0.6.8 or later
- [BizHawk](https://tasvideos.org/BizHawk/ReleaseHistory)
- Your own Mario Tennis (USA) Game Boy Color ROM

## Playing

1. Open your `.apmtgbc` patch file with the Archipelago Launcher. The first time, it asks for your ROM.
2. Open the patched `.gbc` in BizHawk, then open the BizHawk Client from the launcher and run
   `connector_bizhawk_generic.lua` from BizHawk's Lua console.
3. Connect the client to the server. The ROM already knows its slot.

A cart patched for a different seed erases its save data on boot and starts over.

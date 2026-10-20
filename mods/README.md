# mods/

Edited data files, at the path they have under `data/`:

```
mods/sprites/AlexSpriteFrame00.png       an edited sprite frame
mods/text/TextStrings_25.asm             edited dialogue
mods/scenes/lz_GrassCourtTilemap.tilemap
mods/audio/Sfx5d_Trk0.asm              an edited track
```

`data/` is extracted from the ROM and is not committed; this directory is.
Every file here is copied over `data/` before each `make` and after each
extraction, so a fork commits only the files it changed. Edit a file in
`data/` and run `python3 tools/mods.py collect baserom.gbc` to bring every
edited file here, or put files here directly. Sidecars `make` derives (a
`.bin` from a PNG or grid, a `.inc`, a scene preview) do not belong here.
Collect again after each further edit in `data/`: `make` refuses to overwrite one.

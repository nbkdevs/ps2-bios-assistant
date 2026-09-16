# App icon

Original mark: a teal microchip / file glyph. It is not a PlayStation, Sony, PCSX2, AetherSX2, or NetherSX2 logo.

## Source

- Vector adaptive foreground: `android/app/src/main/res/drawable/ic_launcher_foreground.xml`
- Background color: `@color/ic_launcher_background` (`#12363C`)
- Raster source: `assets/icon/app_icon.png` (1024×1024)

## Where Android reads the icon

- Adaptive (API 26+): `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml`
- Legacy densities: `android/app/src/main/res/mipmap-*/ic_launcher.png`

## Regenerating rasters

```bash
python3 tool/generate_icon.py
```

Replace `app_icon.png` with final artwork if you commission a designer, then copy scaled PNGs into the mipmap folders (or use a launcher-icon generator). Keep the adaptive XML in sync with the new artwork.

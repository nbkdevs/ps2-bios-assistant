# Browser extensions — PS2 BIOS Checker

Local utility extensions that mirror the Android app’s core feature: inspect a PS2 BIOS file **in the browser**.

## What it does

- Select or drop a BIOS dump from your computer
- Calculate **MD5** and **SHA-1** on-device (in the popup)
- Show file size and a basic size check (2 / 4 / 8 / 16 MiB)
- Paste an expected hash to compare
- No uploads, no account, **no host permissions**

It does **not** distribute BIOS files. Hash or size matches are reference checks only — not proof a file is official, genuine, or legal.

## Directories

| Folder | Store / browser |
|--------|------------------|
| `chrome/` | Chrome Web Store / Chromium |
| `firefox/` | Firefox Add-ons (AMO) |
| `edge/` | Microsoft Edge Add-ons |
| `_shared/` | Source copies used to sync UI/assets |

## Load unpacked (development)

### Chrome
1. Open `chrome://extensions`
2. Enable **Developer mode**
3. **Load unpacked** → choose `extensions/chrome`

### Edge
1. Open `edge://extensions`
2. Enable **Developer mode**
3. **Load unpacked** → choose `extensions/edge`

### Firefox
1. Open `about:debugging#/runtime/this-firefox`
2. **Load Temporary Add-on…**
3. Select `extensions/firefox/manifest.json`

For a persistent Firefox install during development you can also use `about:addons` → gear → **Debug Add-ons**, or package as `.zip` for AMO.

## Package for store submission

From each browser folder, zip the **contents** (not the parent folder name):

```bash
cd extensions/chrome && zip -r ../ps2-bios-checker-chrome.zip . -x '*.DS_Store'
cd ../firefox && zip -r ../ps2-bios-checker-firefox.zip . -x '*.DS_Store'
cd ../edge && zip -r ../ps2-bios-checker-edge.zip . -x '*.DS_Store'
```

Firefox already includes `browser_specific_settings.gecko` with:

- `id`: `ps2-bios-checker@allps2bios.com`
- `strict_min_version`: `109.0`
- `data_collection_permissions.required`: `["none"]`

## Syncing UI changes

Edit files in `_shared/`, then copy into each browser folder:

```bash
for b in chrome firefox edge; do
  cp extensions/_shared/popup.html extensions/_shared/popup.css \
     extensions/_shared/popup.js extensions/_shared/md5.js \
     "extensions/$b/"
done
```

Do **not** overwrite browser-specific `manifest.json` files.

## Privacy

- `permissions`: none
- No background service worker required
- No network calls from the extension code (the footer link opens allps2bios.com in a normal browser tab)

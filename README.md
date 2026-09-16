# PS2 BIOS & Emulator Assistant

A small Android utility for people who already have a PlayStation 2 BIOS dump on their device and need to inspect it while setting up an emulator.

The app calculates checksums locally, explains basic file-size checks, and includes short notes for PCSX2, AetherSX2, and NetherSX2. It does **not** distribute PS2 BIOS files.

## What it does

- Select a local file through the Android system picker
- Read that file on-device
- Show file name, size, MD5, and SHA-1
- Run conservative size checks (not authenticity claims)
- Provide short BIOS, setup, and troubleshooting notes

## Privacy

- No account or login
- No backend
- Selected files are processed on the device
- File contents are not uploaded
- No analytics SDK is included in this project

The About screen links to [AllPS2BIOS](https://allps2bios.com/) for additional reading. That link opens in the device browser and does not send BIOS files.

## Technology

- Flutter / Dart
- Material 3
- Android (`com.allps2bios.assistant`)
- `file_picker` for the system document picker
- `crypto` / `convert` for streaming MD5 and SHA-1
- `url_launcher` to open the AllPS2BIOS website

## Features

- **BIOS Checker:** local checksums and basic size validation
- **BIOS Guide:** short explanations of firmware, regions, and versions
- **Emulator Setup:** concise PCSX2 / AetherSX2 / NetherSX2 notes
- **Troubleshooting:** common “BIOS not found” and related issues

## Requirements

- Flutter 3.24 or newer (tested against current stable Android tooling)
- Android SDK with compile/target API 36 (Google Play’s current phone/tablet target)
- JDK 17

## Development

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

First-time Android setup still follows the official Flutter Android install guide, including accepting Android licenses.

## Build

Debug:

```bash
flutter build apk --debug
```

Release App Bundle for Play Console:

```bash
flutter build appbundle --release
```

Release APK:

```bash
flutter build apk --release
```

Release signing uses `android/key.properties` when that file exists. Copy `android/key.properties.example` and point it at your upload keystore. Do not commit keystores or passwords. If `key.properties` is missing, the Gradle release build falls back to the debug keystore so local machines can still compile.

If `android/gradle/wrapper/gradle-wrapper.jar` is missing on a fresh checkout, generate it with a local Gradle install (`gradle wrapper` inside `android/`) or by running a Flutter Android build after the Flutter SDK is installed. The wrapper properties already pin Gradle 8.12.

## Testing

```bash
flutter test
```

Tests cover MD5/SHA-1, streaming hashes, file size, empty files, unexpected sizes, and checker error handling.

## Project structure

```
lib/
  main.dart
  app.dart
  models/
  screens/
  services/
  theme/
  widgets/
test/
android/
assets/icon/          # 1024px source icon
tool/generate_icon.py # regenerates mipmap PNGs
```

## App icon

The launcher uses an original chip/file motif (not a PlayStation, Sony, or emulator logo). Source art:

- `assets/icon/app_icon.png`
- Android adaptive icon: `android/app/src/main/res/drawable/ic_launcher_foreground.xml`
- Mipmaps: `android/app/src/main/res/mipmap-*/ic_launcher.png`

Regenerate PNGs with `python3 tool/generate_icon.py`.

## Permissions

The main manifest does not request storage or internet permission. Files are opened through the system picker (Storage Access Framework). `INTERNET` appears only in the debug/profile manifests so Flutter’s observatory can connect.

`url_launcher` uses a `https` intent query so Android 11+ can open the browser.

## Disclaimer

This project is an informational helper. It does not provide BIOS files, game dumps, or circumvention tools. Matching a common file size or checksum does **not** mean a file is official, genuine, or legal. Obtain firmware only in ways that are lawful for you.

PlayStation 2 and related names are trademarks of their owners. This app is not affiliated with Sony Interactive Entertainment.

## License

MIT. See [LICENSE](LICENSE).

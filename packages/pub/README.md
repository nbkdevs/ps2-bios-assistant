# ps2_bios_checksum (pub.dev)

Dart helpers for inspecting a local PS2 BIOS dump: MD5, SHA-1, and basic dump-size checks.

Does **not** include or download BIOS files.

## Install

```yaml
dependencies:
  ps2_bios_checksum: ^1.0.0
```

## Usage

```dart
import 'package:ps2_bios_checksum/ps2_bios_checksum.dart';

final result = await hashFile('SCPH-70000.bin');
print(result.md5);
print(result.validation.summary);
```

## Homepage

NetherSX2 BIOS setup notes: [https://allps2bios.com/ps2-bios-nethersx2/](https://allps2bios.com/ps2-bios-nethersx2/)

## License

MIT

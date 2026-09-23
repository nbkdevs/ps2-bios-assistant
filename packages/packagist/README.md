# allps2bios/ps2-bios-checksum (Packagist)

PHP helpers for inspecting a local PS2 BIOS dump: MD5, SHA-1, and basic dump-size checks.

Does **not** include or download BIOS files.

## Install

```bash
composer require allps2bios/ps2-bios-checksum
```

## Usage

```php
use AllPs2Bios\Checksum\BiosChecksum;

$result = BiosChecksum::hashFile('SCPH-70000.bin');
echo $result['md5'], ' ', $result['validation']['summary'];
```

## Docs

NetherSX2 BIOS setup notes: [https://allps2bios.com/ps2-bios-nethersx2/](https://allps2bios.com/ps2-bios-nethersx2/)

## License

MIT

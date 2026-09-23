# ps2-bios-checksum (PyPI)

Python helpers for inspecting a local PS2 BIOS dump: MD5, SHA-1, and basic dump-size checks.

Does **not** ship or download BIOS files. Results are reference checks only.

## Install

```bash
pip install ps2-bios-checksum
```

## Usage

```python
from ps2_bios_checksum import hash_file

result = hash_file("SCPH-70000.bin")
print(result.md5, result.sha1, result.validation.summary)
```

CLI:

```bash
ps2-bios-checksum SCPH-70000.bin
```

## Homepage

PS2 BIOS and emulator guides: [https://allps2bios.com/](https://allps2bios.com/)

## License

MIT

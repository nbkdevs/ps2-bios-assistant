# ps2-bios-checksum (npm)

Local helpers for inspecting a PS2 BIOS dump on your machine: MD5, SHA-1, size formatting, and basic dump-size checks.

This package does **not** include or download BIOS files. Hash and size matches are reference checks only.

## Install

```bash
npm install ps2-bios-checksum
```

## Usage

```js
import { hashFile, hashBuffer, validateBiosSize } from "ps2-bios-checksum";

const result = await hashFile("./SCPH-70000.bin");
console.log(result.md5, result.sha1, result.validation.summary);
```

CLI:

```bash
npx ps2-bios-checksum ./SCPH-70000.bin
```

## Homepage

PS2 BIOS and emulator guides: [https://allps2bios.com/](https://allps2bios.com/)

## License

MIT

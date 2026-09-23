# Ps2BiosChecksum (NuGet)

.NET helpers for inspecting a local PS2 BIOS dump: MD5, SHA-1, and basic dump-size checks.

Does **not** include or download BIOS files.

## Install

```bash
dotnet add package Ps2BiosChecksum
```

## Usage

```csharp
using Ps2BiosChecksum;

var result = BiosChecksum.HashFile("SCPH-70000.bin");
Console.WriteLine($"{result.Md5} {result.Validation.Summary}");
```

## Docs

NetherSX2 BIOS setup notes: [https://allps2bios.com/ps2-bios-nethersx2/](https://allps2bios.com/ps2-bios-nethersx2/)

## License

MIT

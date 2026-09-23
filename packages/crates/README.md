# ps2_bios_checksum (crates.io)

Rust helpers and a small CLI for inspecting a local PS2 BIOS dump: MD5, SHA-1, and basic dump-size checks.

Does **not** include or download BIOS files.

## Install

```bash
cargo add ps2_bios_checksum
# or CLI:
cargo install ps2_bios_checksum
```

## Usage

```rust
use ps2_bios_checksum::hash_file;

let result = hash_file("SCPH-70000.bin")?;
println!("{} {}", result.md5, result.validation.summary);
```

## Homepage

NetherSX2 BIOS setup notes: [https://allps2bios.com/ps2-bios-nethersx2/](https://allps2bios.com/ps2-bios-nethersx2/)

## License

MIT

# ps2_bios_checksum (RubyGems)

Ruby helpers for inspecting a local PS2 BIOS dump: MD5, SHA-1, and basic dump-size checks.

Does **not** include or download BIOS files.

## Install

```bash
gem install ps2_bios_checksum
```

## Usage

```ruby
require "ps2_bios_checksum"

result = Ps2BiosChecksum.hash_file("SCPH-70000.bin")
puts "#{result[:md5]} #{result[:validation][:summary]}"
```

## Docs

RetroArch PS2 BIOS notes: [https://allps2bios.com/ps2-bios-retroarch/](https://allps2bios.com/ps2-bios-retroarch/)

## License

MIT

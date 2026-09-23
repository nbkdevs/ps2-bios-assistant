# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "ps2_bios_checksum"
  spec.version       = "1.0.0"
  spec.authors       = ["AllPS2BIOS"]
  spec.email         = ["support@allps2bios.com"]

  spec.summary       = "Local PS2 BIOS checksum helpers (MD5, SHA-1, size checks)."
  spec.description   = "Hash a local PS2 BIOS dump and run basic dump-size checks. Does not include BIOS files."
  spec.homepage      = "https://allps2bios.com/ps2-bios-retroarch/"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/allps2bios/ps2-bios-checksum"
  spec.metadata["changelog_uri"] = "https://github.com/allps2bios/ps2-bios-checksum"

  spec.files = Dir["lib/**/*", "README.md", "LICENSE"]
  spec.require_paths = ["lib"]
end

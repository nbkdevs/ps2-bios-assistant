# Registry packages — PS2 BIOS Checksum

Real, useful **local BIOS checksum** libraries/CLIs/skills for multiple ecosystems.  
Same core behavior as the Android app and browser extension: MD5, SHA-1, size, basic dump-size checks.

**Does not include or download BIOS files.**

## Link map (one docs URL per package)

| Package | Platform | Docs URL |
|---------|----------|----------|
| `packages/npm` | npm | https://allps2bios.com/ |
| `packages/pypi` | PyPI | https://allps2bios.com/ |
| `packages/docker` | Docker Hub | https://allps2bios.com/ |
| `packages/huggingface-space` | Hugging Face Space | https://allps2bios.com/ |
| `packages/pub` | pub.dev | https://allps2bios.com/ps2-bios-nethersx2/ |
| `packages/crates` | crates.io | https://allps2bios.com/ps2-bios-nethersx2/ |
| `packages/nuget` | NuGet | https://allps2bios.com/ps2-bios-nethersx2/ |
| `packages/packagist` | Packagist | https://allps2bios.com/ps2-bios-nethersx2/ |
| `packages/rubygems` | RubyGems | https://allps2bios.com/ps2-bios-retroarch/ |
| `packages/smithery` | Smithery (SKILL.md) | https://allps2bios.com/ps2-bios-retroarch/ |
| `packages/clawhub` | ClawHub (SKILL.md) | https://allps2bios.com/ps2-bios-retroarch/ |


## Publish commands (after you create registry accounts)

### npm
```bash
cd packages/npm && npm login && npm publish --access public
```

### PyPI
```bash
cd packages/pypi
python -m pip install build twine
python -m build
twine upload dist/*
```

### pub.dev
```bash
cd packages/pub
# set homepage/repository in pubspec if needed
dart pub publish
```

### crates.io
```bash
cd packages/crates
cargo login
cargo publish
```

### NuGet
```bash
cd packages/nuget
dotnet pack -c Release
dotnet nuget push bin/Release/*.nupkg --api-key <KEY> --source https://api.nuget.org/v3/index.json
```

### Packagist
Push the `packagist/` tree to a public GitHub repo, then submit the repo URL at https://packagist.org/packages/submit

### RubyGems
```bash
cd packages/rubygems
gem build ps2_bios_checksum.gemspec
gem push ps2_bios_checksum-1.0.0.gem
```

### Docker Hub
```bash
cd packages/docker
docker build -t allps2bios/ps2-bios-checksum:1.0.0 .
docker login
docker push allps2bios/ps2-bios-checksum:1.0.0
```

### Hugging Face Space
Create a Space (Gradio), upload `packages/huggingface-space/*`, set README metadata as provided.

### Smithery / ClawHub
Upload or sync the folder that contains `SKILL.md` per each platform’s skill publishing flow.

## Shared behavior

- Empty file → fail basic check  
- Sizes 2 / 4 / 8 / 16 MiB → “Basic checks passed”  
- Never claims authenticity/legality from a hash match  

## License

MIT for all packages in this folder.

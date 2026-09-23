# ps2-bios-checksum (Docker Hub)

Containerized CLI that hashes a **local** PS2 BIOS dump (MD5 / SHA-1) and runs a basic size check.

Does **not** include BIOS files. Mount your own dump at runtime.

## Pull / run

```bash
docker build -t ps2-bios-checksum .
docker run --rm -v "$PWD:/data:ro" ps2-bios-checksum /data/SCPH-70000.bin
```

Example Docker Hub image name once published: `allps2bios/ps2-bios-checksum`

## Homepage

PS2 BIOS and emulator guides: [https://allps2bios.com/](https://allps2bios.com/)

## License

MIT

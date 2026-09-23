from __future__ import annotations

import argparse
import sys

from . import format_file_size, hash_file


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        prog="ps2-bios-checksum",
        description="Calculate MD5/SHA-1 and basic size checks for a local PS2 BIOS file.",
    )
    parser.add_argument("file", help="Path to a local BIOS dump")
    args = parser.parse_args(argv)

    try:
        result = hash_file(args.file)
    except OSError as exc:
        print(f"Couldn't read file: {exc}", file=sys.stderr)
        return 1

    print(f"File:   {result.path}")
    print(f"Size:   {format_file_size(result.size_bytes)}")
    print(f"MD5:    {result.md5}")
    print(f"SHA-1:  {result.sha1}")
    print(f"Status: {result.validation.summary}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

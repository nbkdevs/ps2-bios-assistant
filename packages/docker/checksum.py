#!/usr/bin/env python3
"""Hash a local PS2 BIOS dump: MD5, SHA-1, and basic size checks."""

from __future__ import annotations

import argparse
import hashlib
import sys
from pathlib import Path

COMMON = {
    2 * 1024 * 1024,
    4 * 1024 * 1024,
    8 * 1024 * 1024,
    16 * 1024 * 1024,
}


def format_size(n: int) -> str:
    if n < 1024:
        return f"{n} B"
    kib = n / 1024
    if kib < 1024:
        return f"{kib:.2f} KB"
    return f"{kib / 1024:.2f} MB"


def validate(n: int) -> str:
    if n <= 0:
        return "File is empty"
    if n in COMMON:
        return "Basic checks passed"
    return "File size does not match common BIOS sizes"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("file", help="Path to a local BIOS dump (bind-mount into the container)")
    args = parser.parse_args()
    path = Path(args.file)
    try:
        data = path.read_bytes()
    except OSError as exc:
        print(f"Couldn't read file: {exc}", file=sys.stderr)
        return 1
    print(f"File:   {path}")
    print(f"Size:   {format_size(len(data))}")
    print(f"MD5:    {hashlib.md5(data).hexdigest()}")
    print(f"SHA-1:  {hashlib.sha1(data).hexdigest()}")
    print(f"Status: {validate(len(data))}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

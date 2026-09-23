"""Local PS2 BIOS checksum and size-check helpers."""

from __future__ import annotations

import hashlib
from dataclasses import dataclass
from pathlib import Path

COMMON_BIOS_SIZES = frozenset(
    {
        2 * 1024 * 1024,
        4 * 1024 * 1024,
        8 * 1024 * 1024,
        16 * 1024 * 1024,
    }
)


@dataclass(frozen=True)
class BiosValidation:
    ok: bool
    summary: str
    detail: str


@dataclass(frozen=True)
class BiosChecksumResult:
    size_bytes: int
    md5: str
    sha1: str
    validation: BiosValidation
    path: str | None = None


def format_file_size(size_bytes: int) -> str:
    if size_bytes < 1024:
        return f"{size_bytes} B"
    kib = size_bytes / 1024
    if kib < 1024:
        return f"{kib:.2f} KB"
    return f"{kib / 1024:.2f} MB"


def validate_bios_size(size_bytes: int) -> BiosValidation:
    if size_bytes <= 0:
        return BiosValidation(
            False,
            "File is empty",
            "An empty file cannot be used as a BIOS image. Basic check only.",
        )
    if size_bytes in COMMON_BIOS_SIZES:
        return BiosValidation(
            True,
            "Basic checks passed",
            "Size matches a commonly reported PS2 BIOS dump size. Not proof of authenticity.",
        )
    return BiosValidation(
        False,
        "File size does not match common BIOS sizes",
        "Common sizes are 2, 4, 8, or 16 MiB. Unexpected size may mean incomplete or non-BIOS data.",
    )


def hash_bytes(data: bytes, path: str | None = None) -> BiosChecksumResult:
    return BiosChecksumResult(
        size_bytes=len(data),
        md5=hashlib.md5(data).hexdigest(),
        sha1=hashlib.sha1(data).hexdigest(),
        validation=validate_bios_size(len(data)),
        path=path,
    )


def hash_file(path: str | Path) -> BiosChecksumResult:
    file_path = Path(path)
    data = file_path.read_bytes()
    return hash_bytes(data, path=str(file_path))

#!/usr/bin/env python3
"""Generate launcher and splash PNGs (stdlib only)."""

from __future__ import annotations

import struct
import zlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BG = "12363C"


def png(width: int, height: int, rgba_rows: list[bytes]) -> bytes:
    def chunk(tag: bytes, data: bytes) -> bytes:
        return (
            struct.pack(">I", len(data))
            + tag
            + data
            + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF)
        )

    raw = b"".join(b"\x00" + row for row in rgba_rows)
    return b"".join(
        [
            b"\x89PNG\r\n\x1a\n",
            chunk(b"IHDR", struct.pack(">IIBBBBB", width, height, 8, 6, 0, 0, 0)),
            chunk(b"IDAT", zlib.compress(raw, 9)),
            chunk(b"IEND", b""),
        ]
    )


def color(hex_color: str, alpha: int = 255) -> bytes:
    hex_color = hex_color.lstrip("#")
    r, g, b = (int(hex_color[i : i + 2], 16) for i in (0, 2, 4))
    return bytes((r, g, b, alpha))


def draw(size: int, *, transparent_bg: bool = False) -> bytes:
    bg = color(BG, 0 if transparent_bg else 255)
    frame = color("1F6F7A")
    body = color("0E3C43")
    face = color("D7EDE8")
    pin = color("8FCBD0")
    ink = color("0E3C43")
    pixels = [bytearray(bg * size) for _ in range(size)]

    def fill(x0: int, y0: int, x1: int, y1: int, c: bytes) -> None:
        x0, y0 = max(0, x0), max(0, y0)
        x1, y1 = min(size, x1), min(size, y1)
        for y in range(y0, y1):
            row = pixels[y]
            for x in range(x0, x1):
                row[x * 4 : x * 4 + 4] = c

    m = size // 6
    fill(m, m, size - m, size - m, frame)
    inner = m + size // 12
    fill(inner, inner, size - inner, size - inner, body)
    face_m = inner + size // 10
    fill(face_m, face_m, size - face_m, size - face_m, face)

    bar_h = max(2, size // 28)
    bar_w = (size - 2 * face_m) * 2 // 3
    fill(face_m + size // 32, size // 2 - bar_h * 2, face_m + bar_w, size // 2 - bar_h, ink)
    fill(
        face_m + size // 32,
        size // 2 + bar_h,
        face_m + bar_w - size // 16,
        size // 2 + bar_h * 2,
        ink,
    )

    pin_w = max(2, size // 18)
    pin_h = max(6, size // 10)
    for i in range(4):
        y = inner + (i + 1) * (size - 2 * inner) // 5
        fill(m - pin_w, y, inner, y + pin_h // 2, pin)
        fill(size - inner, y, size - m + pin_w, y + pin_h // 2, pin)
        x = inner + (i + 1) * (size - 2 * inner) // 5
        fill(x, m - pin_w, x + pin_h // 2, inner, pin)
        fill(x, size - inner, x + pin_h // 2, size - m + pin_w, pin)

    return png(size, size, [bytes(row) for row in pixels])


def write(path: Path, data: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(data)


def main() -> None:
    res = ROOT / "android/app/src/main/res"
    launcher = {
        "mipmap-mdpi": 48,
        "mipmap-hdpi": 72,
        "mipmap-xhdpi": 96,
        "mipmap-xxhdpi": 144,
        "mipmap-xxxhdpi": 192,
    }
    for folder, size in launcher.items():
        image = draw(size)
        write(res / folder / "ic_launcher.png", image)
        write(res / folder / "ic_launcher_round.png", image)

    splash = {
        "drawable-mdpi": 192,
        "drawable-hdpi": 288,
        "drawable-xhdpi": 384,
        "drawable-xxhdpi": 576,
        "drawable-xxxhdpi": 768,
    }
    for folder, size in splash.items():
        write(res / folder / "splash_icon.png", draw(size, transparent_bg=True))

    source = ROOT / "assets/icon"
    write(source / "app_icon.png", draw(1024))
    write(source / "splash_icon.png", draw(1024, transparent_bg=True))
    print("Wrote launcher and splash icons")


if __name__ == "__main__":
    main()

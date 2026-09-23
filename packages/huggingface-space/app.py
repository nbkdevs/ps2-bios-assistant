import hashlib
from pathlib import Path

import gradio as gr

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
        return "Basic checks passed (common dump size). Not proof of authenticity."
    return "File size does not match common BIOS sizes (2/4/8/16 MiB)."


def analyze(file_obj):
    if file_obj is None:
        return "No file selected.", "", "", "", ""
    path = Path(file_obj.name if hasattr(file_obj, "name") else file_obj)
    data = path.read_bytes()
    if len(data) > 64 * 1024 * 1024:
        return "File larger than 64 MB rejected.", "", "", "", ""
    return (
        path.name,
        format_size(len(data)),
        hashlib.md5(data).hexdigest(),
        hashlib.sha1(data).hexdigest(),
        validate(len(data)),
    )


demo = gr.Interface(
    fn=analyze,
    inputs=gr.File(label="Local BIOS dump"),
    outputs=[
        gr.Textbox(label="File name"),
        gr.Textbox(label="Size"),
        gr.Textbox(label="MD5"),
        gr.Textbox(label="SHA-1"),
        gr.Textbox(label="Status"),
    ],
    title="PS2 BIOS Checksum",
    description=(
        "Hash a BIOS file you already have. Nothing here provides BIOS downloads. "
        "Docs: https://allps2bios.com/"
    ),
    allow_flagging="never",
)

if __name__ == "__main__":
    demo.launch()

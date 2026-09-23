FROM python:3.12-slim

LABEL org.opencontainers.image.title="ps2-bios-checksum"
LABEL org.opencontainers.image.description="CLI to hash a local PS2 BIOS dump (MD5/SHA-1) and run basic size checks."
LABEL org.opencontainers.image.url="https://allps2bios.com/"
LABEL org.opencontainers.image.source="https://github.com/allps2bios/ps2-bios-checksum"
LABEL org.opencontainers.image.licenses="MIT"

WORKDIR /app
COPY checksum.py /app/checksum.py

ENTRYPOINT ["python", "/app/checksum.py"]

# Google Play listing draft

Review this copy against the shipped binary before publishing. Do not claim capabilities the app does not have.

## App title

PS2 BIOS & Emulator Assistant

(30 characters. If a shorter store title is required, use **PS2 BIOS Assistant**.)

## Short description

Check a local PS2 BIOS file for size and checksums, with short emulator setup notes.

## Full description

PS2 BIOS & Emulator Assistant is a small on-device utility for people setting up a PlayStation 2 emulator on Android.

Select a BIOS file that is already stored on your phone. The app reads it locally and shows:

• File name and size
• MD5 checksum
• SHA-1 checksum
• A basic file-size check against commonly reported dump sizes

Your file stays on the device. The app does not upload BIOS contents and does not include BIOS files.

It also keeps short reference notes for:

• What a PS2 BIOS is, and why emulators ask for one
• Region and version differences at a high level
• BIOS setup pointers for PCSX2, AetherSX2, and NetherSX2
• Practical troubleshooting when an emulator cannot find or recognize a BIOS file

These checks cannot prove that a file is authentic, complete, or legal. Use them as a convenience while configuring software you already have.

Additional PS2 BIOS and emulator articles are published at allps2bios.com. The in-app link opens that site in your browser.

This app is not affiliated with Sony Interactive Entertainment or with any emulator project.

## Suggested category

Tools

## Suggested tags

Use only if the Play Console still offers tags, and only if they describe the app:

- file checker
- checksum
- emulation
- utilities

Do not stuff repeated “PS2 BIOS” phrases into tags.

## Privacy and Data safety (based on this repository)

Inspected implementation:

- No account system
- No first-party backend
- No analytics, ads, crash-reporting, or social SDKs in `pubspec.yaml`
- BIOS files are hashed on device
- The only network-related behavior is opening https://allps2bios.com/ in an external browser via Android intents

Play Console Data safety form (proposed answers for this codebase):

- Data collected: No
- Data shared: No
- Encrypted in transit: Not applicable (no account or uploaded user content)
- Users can request deletion: Not applicable
- Optional: note that the user may leave the app to view a website, which then follows that website’s own policy

If you later add Firebase, ads, or other SDKs, this section must be rewritten before shipping.

See also `PRIVACY.md`.

## Content rating questionnaire (expected)

Utility / reference. No user-generated content, no location, no ads in the current project.

## Screenshot plan

Capture on a phone (and a 7" tablet if you support it):

1. Home — title, short description, Check BIOS File
2. BIOS Checker — empty state with Select BIOS File
3. BIOS Checker — results for a local file (file name, size, MD5, SHA-1, status). Use a file you own; do not show copyrighted dumps you do not have rights to display
4. PS2 BIOS Guide — one expanded section
5. Emulator Setup — PCSX2 / AetherSX2 / NetherSX2 list
6. Troubleshooting — one expanded FAQ
7. About — version and AllPS2BIOS link

Use the system light and dark themes for at least one pair of screenshots if you have room.

Feature graphic concept (1024×500): dark teal field, original chip icon, title “PS2 BIOS & Emulator Assistant”, subtitle “Check local BIOS files on device”. Do not use Sony, PlayStation, or emulator logos.

## Release notes (1.0.0)

First release: local BIOS checksum checker, short setup notes, and troubleshooting. No BIOS files included.

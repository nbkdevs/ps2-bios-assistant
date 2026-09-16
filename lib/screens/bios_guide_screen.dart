import 'package:flutter/material.dart';

import '../widgets/expandable_section.dart';
import '../widgets/screen_padding.dart';

class BiosGuideScreen extends StatelessWidget {
  const BiosGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PS2 BIOS Guide')),
      body: ScreenPadding(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: const [
            ExpandableSection(
              title: 'What is a PlayStation 2 BIOS?',
              children: [
                GuideParagraph(
                  'A BIOS file is firmware dumped from a PlayStation 2 console. Emulators use it to reproduce low-level console behavior that games expect, such as startup routines and hardware initialization.',
                ),
              ],
            ),
            ExpandableSection(
              title: 'Why emulators need a BIOS',
              children: [
                GuideParagraph(
                  'Most PS2 emulators do not include console firmware. They expect you to provide a BIOS file from hardware you own, then point the emulator at that file or folder.',
                ),
              ],
            ),
            ExpandableSection(
              title: 'What BIOS regions mean',
              children: [
                GuideParagraph(
                  'PlayStation 2 consoles were sold in regions such as NTSC-U/C (North America), PAL (Europe/Australia), and NTSC-J (Japan). BIOS dumps usually match the console they came from.',
                ),
                GuideParagraph(
                  'Using a BIOS from a different region than a game can sometimes cause language, video mode, or compatibility differences. Match the BIOS to the software you intend to run when you can.',
                ),
              ],
            ),
            ExpandableSection(
              title: 'Why different versions exist',
              children: [
                GuideParagraph(
                  'Sony released many console models over the PS2 lifespan. Firmware revisions differ by model and region, so dumps are often labeled with a chassis code such as SCPH-39001.',
                ),
                GuideParagraph(
                  'Emulators may work with several versions. If one dump behaves poorly with a title, another version from a console you own is sometimes more compatible.',
                ),
              ],
            ),
            ExpandableSection(
              title: 'Obtaining a BIOS file',
              children: [
                GuideParagraph(
                  'Where applicable, obtain BIOS files from hardware or software you legally own, and follow the laws that apply to you. This app does not provide BIOS files.',
                ),
              ],
            ),
            ExpandableSection(
              title: 'Unknown download sources',
              children: [
                GuideParagraph(
                  'BIOS files from unknown websites can be incomplete, renamed, or bundled with malware. Prefer dumps you created yourself, and verify checksums on the device before you trust a file in an emulator.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

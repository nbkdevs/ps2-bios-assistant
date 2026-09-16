import 'package:flutter/material.dart';

import '../widgets/expandable_section.dart';
import '../widgets/screen_padding.dart';

class EmulatorSetupScreen extends StatelessWidget {
  const EmulatorSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emulator Setup')),
      body: ScreenPadding(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: const [
            ExpandableSection(
              title: 'PCSX2',
              children: [
                GuideParagraph(
                  'PCSX2 is a widely used PlayStation 2 emulator, mainly on desktop platforms. It needs a BIOS file you supply; it does not ship console firmware.',
                ),
                GuideParagraph(
                  'BIOS files are normally placed in the emulator’s BIOS folder, then selected in the BIOS settings (the exact menu label varies by PCSX2 version). After you add files, refresh the BIOS list so the emulator can see them.',
                ),
                GuideParagraph(
                  'Typical first-run path: install PCSX2, create or confirm the BIOS directory, copy your dump there, pick it in settings, then test with a game you own.',
                ),
                GuideParagraph(
                  'If PCSX2 reports a missing BIOS, confirm the folder path, file name, and that the dump is not still inside an archive. Check the emulator log for the path it actually searched.',
                ),
              ],
            ),
            ExpandableSection(
              title: 'AetherSX2',
              children: [
                GuideParagraph(
                  'AetherSX2 is an Android-oriented PS2 emulator. Official distribution and updates have changed over time, so follow the build you actually installed.',
                ),
                GuideParagraph(
                  'BIOS configuration is usually a folder picker in the app settings. Grant the emulator access to that folder, then place your BIOS file inside it.',
                ),
                GuideParagraph(
                  'Keep the dump uncompressed. After selecting the folder, fully close and reopen the app if the BIOS list stays empty. Storage permission or folder access is a common first-run issue on Android.',
                ),
              ],
            ),
            ExpandableSection(
              title: 'NetherSX2',
              children: [
                GuideParagraph(
                  'NetherSX2 is a community-maintained Android build based on AetherSX2. Setup details can differ slightly by patch version.',
                ),
                GuideParagraph(
                  'Point the emulator at a dedicated BIOS folder you control, copy your dump there, and confirm the file appears in the BIOS list before launching a game.',
                ),
                GuideParagraph(
                  'Use a current, trusted build of the emulator itself. If BIOS detection fails, re-select the folder through the system picker rather than guessing a raw path.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

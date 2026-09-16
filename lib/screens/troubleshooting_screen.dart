import 'package:flutter/material.dart';

import '../widgets/expandable_section.dart';
import '../widgets/screen_padding.dart';

class TroubleshootingScreen extends StatelessWidget {
  const TroubleshootingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Troubleshooting')),
      body: ScreenPadding(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: const [
            ExpandableSection(
              title: 'My emulator says BIOS not found',
              children: [
                GuideParagraph(
                  'Confirm the file is still on the device and that you can open it in a file manager.',
                ),
                GuideParagraph(
                  'On Android, the emulator must have access to the folder you chose. Re-pick the BIOS directory with the system folder picker if access was lost after a reboot or app update.',
                ),
                GuideParagraph(
                  'Check that the emulator’s BIOS path setting matches the folder that actually contains the file, not a parent Downloads directory or an unextracted archive.',
                ),
              ],
            ),
            ExpandableSection(
              title: 'My BIOS file is not recognized',
              children: [
                GuideParagraph(
                  'The file may be the wrong dump, incomplete, or still compressed (.zip, .7z, .rar). Extract it first.',
                ),
                GuideParagraph(
                  'Corruption and truncated copies often show an unusual file size. Use this app’s checker to compare size and checksums against notes you trust.',
                ),
                GuideParagraph(
                  'Some emulators only list files with expected extensions such as .bin. Renaming a random file will not make it a BIOS image.',
                ),
              ],
            ),
            ExpandableSection(
              title: 'My game has a black screen',
              children: [
                GuideParagraph(
                  'Wait through long loading periods on first boot. If the screen stays black, try another BIOS version from a console you own, and confirm the game image itself is complete.',
                ),
                GuideParagraph(
                  'Update the emulator, disable unneeded fast-boot options if a title needs the BIOS intro, and check whether that game is a known problem title for your emulator version.',
                ),
                GuideParagraph(
                  'A black screen can also come from a graphics or renderer issue rather than the BIOS. Try the emulator’s default graphics backend before changing BIOS files again.',
                ),
              ],
            ),
            ExpandableSection(
              title: 'My emulator is slow',
              children: [
                GuideParagraph(
                  'PS2 emulation is demanding. Close background apps, keep the device cool, and start from the emulator’s default performance-oriented preset.',
                ),
                GuideParagraph(
                  'Lower internal resolution and disable extra rendering features if the device struggles. A faster dump of the same game will not fix a CPU or GPU bottleneck.',
                ),
                GuideParagraph(
                  'Wired controllers and airplane mode can reduce hitching on some phones, but hardware limits still apply.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

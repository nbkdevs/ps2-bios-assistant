import 'package:flutter/material.dart';

import '../widgets/screen_padding.dart';
import 'about_screen.dart';
import 'bios_guide_screen.dart';
import 'emulator_setup_screen.dart';
import 'troubleshooting_screen.dart';

class GuidesHubScreen extends StatelessWidget {
  const GuidesHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guides')),
      body: ScreenPadding(
        child: ListView(
          children: [
            _item(
              context,
              title: 'PS2 BIOS Guide',
              subtitle: 'BIOS files, regions, and versions',
              screen: const BiosGuideScreen(),
            ),
            _item(
              context,
              title: 'Emulator Setup',
              subtitle: 'PCSX2, AetherSX2, and NetherSX2',
              screen: const EmulatorSetupScreen(),
            ),
            _item(
              context,
              title: 'Troubleshooting',
              subtitle: 'Common emulator and BIOS problems',
              screen: const TroubleshootingScreen(),
            ),
            _item(
              context,
              title: 'About',
              subtitle: 'App version and additional resources',
              screen: const AboutScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Widget screen,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => screen),
        );
      },
    );
  }
}

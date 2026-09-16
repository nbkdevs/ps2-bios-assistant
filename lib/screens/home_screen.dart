import 'package:flutter/material.dart';

import '../app_info.dart';
import '../widgets/screen_padding.dart';
import 'about_screen.dart';
import 'bios_guide_screen.dart';
import 'emulator_setup_screen.dart';
import 'troubleshooting_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onCheckBios});

  final VoidCallback onCheckBios;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text(AppInfo.name)),
      body: ScreenPadding(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(
              'Inspect a local PS2 BIOS file and keep emulator setup notes in one place.',
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onCheckBios,
              icon: const Icon(Icons.folder_open),
              label: const Text('Check BIOS File'),
            ),
            const SizedBox(height: 16),
            Text(
              'Select a file already on this device to calculate MD5 and SHA-1 checksums and review basic file information. The file is not uploaded.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            Text('Guides', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            _GuideLink(
              title: 'BIOS Guide',
              subtitle: 'What a BIOS is and how regions and versions differ',
              onTap: () => _open(context, const BiosGuideScreen()),
            ),
            _GuideLink(
              title: 'Emulator Setup',
              subtitle: 'PCSX2, AetherSX2, and NetherSX2 BIOS setup notes',
              onTap: () => _open(context, const EmulatorSetupScreen()),
            ),
            _GuideLink(
              title: 'Troubleshooting',
              subtitle: 'Missing BIOS, unrecognized files, and common issues',
              onTap: () => _open(context, const TroubleshootingScreen()),
            ),
            _GuideLink(
              title: 'About',
              subtitle: 'Version, privacy notes, and additional reading',
              onTap: () => _open(context, const AboutScreen()),
            ),
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => screen),
    );
  }
}

class _GuideLink extends StatelessWidget {
  const _GuideLink({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

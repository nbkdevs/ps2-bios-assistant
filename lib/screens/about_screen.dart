import 'package:flutter/material.dart';

import '../app_info.dart';
import '../services/external_links.dart';
import '../widgets/screen_padding.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ScreenPadding(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(
              AppInfo.name,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Version ${AppInfo.version}', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            Text(
              'A small on-device helper for checking local PS2 BIOS files and reading concise emulator setup notes. It does not include BIOS files and does not upload the files you select.',
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 24),
            Text(
              'More PS2 BIOS and emulator guides are available at AllPS2BIOS.',
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () async {
                  final opened = await openExternalUrl(allPs2BiosUri);
                  if (!opened && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Couldn't open the website right now."),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: const Text('https://allps2bios.com/'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

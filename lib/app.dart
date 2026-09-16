import 'package:flutter/material.dart';

import 'app_info.dart';
import 'screens/shell_screen.dart';
import 'theme/app_theme.dart';

class Ps2BiosApp extends StatelessWidget {
  const Ps2BiosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppInfo.name,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const ShellScreen(),
    );
  }
}

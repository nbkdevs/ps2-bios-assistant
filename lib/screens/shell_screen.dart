import 'package:flutter/material.dart';

import 'checker_screen.dart';
import 'guides_hub_screen.dart';
import 'home_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;
  final _guidesKey = GlobalKey<NavigatorState>();

  void _openChecker() {
    setState(() => _index = 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(onCheckBios: _openChecker),
          const CheckerScreen(),
          Navigator(
            key: _guidesKey,
            onGenerateRoute: (settings) {
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (_) => const GuidesHubScreen(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) {
          if (_index == 2 && index == 2) {
            _guidesKey.currentState?.popUntil((route) => route.isFirst);
          }
          setState(() => _index = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.fact_check_outlined),
            selectedIcon: Icon(Icons.fact_check),
            label: 'BIOS Checker',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Guides',
          ),
        ],
      ),
    );
  }
}

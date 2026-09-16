import 'package:flutter/material.dart';

class ExpandableSection extends StatelessWidget {
  const ExpandableSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 4),
      childrenPadding: const EdgeInsets.fromLTRB(4, 0, 4, 16),
      title: Text(title, style: textTheme.titleMedium),
      children: children,
    );
  }
}

class GuideParagraph extends StatelessWidget {
  const GuideParagraph(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4),
      ),
    );
  }
}

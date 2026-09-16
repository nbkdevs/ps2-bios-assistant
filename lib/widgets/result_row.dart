import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultRow extends StatelessWidget {
  const ResultRow({
    super.key,
    required this.label,
    required this.value,
    this.monospace = false,
    this.copyable = false,
  });

  final String label;
  final String value;
  final bool monospace;
  final bool copyable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final valueStyle = monospace
        ? theme.textTheme.bodyMedium?.copyWith(
            fontFamily: 'monospace',
            height: 1.4,
          )
        : theme.textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SelectableText(value, style: valueStyle),
              ),
              if (copyable)
                IconButton(
                  tooltip: 'Copy',
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: value));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Copied $label'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.copy_outlined, size: 20),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/bios_check_result.dart';
import '../services/bios_checker_service.dart';
import '../services/bios_validator.dart';
import '../widgets/result_row.dart';
import '../widgets/screen_padding.dart';

class CheckerScreen extends StatefulWidget {
  const CheckerScreen({super.key, this.service});

  final BiosCheckerService? service;

  @override
  State<CheckerScreen> createState() => _CheckerScreenState();
}

class _CheckerScreenState extends State<CheckerScreen> {
  late final BiosCheckerService _service;
  bool _busy = false;
  BiosCheckResult? _result;
  String? _error;

  @override
  void initState() {
    super.initState();
    _service = widget.service ?? BiosCheckerService();
  }

  Future<void> _selectFile() async {
    setState(() {
      _busy = true;
      _error = null;
    });

    try {
      final result = await _service.checkSelectedFile();
      if (!mounted) {
        return;
      }
      setState(() {
        _busy = false;
        if (result != null) {
          _result = result;
        }
      });
    } on BiosCheckException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _busy = false;
        _error = error.userMessage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Check Your BIOS')),
      body: ScreenPadding(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(
              'Select a BIOS file stored on your device to calculate its checksums and inspect basic file information. Your file stays on your device.',
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _busy ? null : _selectFile,
              icon: const Icon(Icons.file_open_outlined),
              label: const Text('Select BIOS File'),
            ),
            if (_busy) ...[
              const SizedBox(height: 24),
              const Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Calculating checksums',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Reading the file and calculating checksums…',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ],
            if (_error != null) ...[
              const SizedBox(height: 20),
              Text(
                _error!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
            if (_result != null && !_busy) ...[
              const SizedBox(height: 28),
              _Results(result: _result!),
            ],
          ],
        ),
      ),
    );
  }
}

class _Results extends StatelessWidget {
  const _Results({required this.result});

  final BiosCheckResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final passed = result.validation.passedBasicChecks;
    final statusColor = passed
        ? theme.colorScheme.primary
        : theme.colorScheme.tertiary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResultRow(label: 'BIOS File', value: result.fileName, monospace: true),
        ResultRow(label: 'File Size', value: formatFileSize(result.sizeBytes)),
        ResultRow(
          label: 'MD5',
          value: result.md5,
          monospace: true,
          copyable: true,
        ),
        ResultRow(
          label: 'SHA-1',
          value: result.sha1,
          monospace: true,
          copyable: true,
        ),
        Text(
          'Status',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          result.validation.summary,
          style: theme.textTheme.titleMedium?.copyWith(color: statusColor),
        ),
        const SizedBox(height: 8),
        Text(
          result.validation.detail,
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
        ),
        const SizedBox(height: 16),
        Text(
          'These are basic on-device checks. A matching file size or checksum comparison does not mean a file is official, genuine, or legal.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

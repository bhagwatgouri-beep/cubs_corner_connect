import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'arrival_exception_dialog.dart';
import 'arrival_exception_tile.dart';

class ArrivalScreen extends StatefulWidget {
  final String classroomName;
  final int totalChildren;

  const ArrivalScreen({
    super.key,
    required this.classroomName,
    required this.totalChildren,
  });

  @override
  State<ArrivalScreen> createState() => _ArrivalScreenState();
}

class _ArrivalScreenState extends State<ArrivalScreen> {
  final List<ArrivalException> _exceptions = [];

  Future<void> _openExceptionDialog() async {
    final exception = await showDialog<ArrivalException>(
      context: context,
      builder: (_) => const ArrivalExceptionDialog(),
    );

    if (exception == null || !mounted) {
      return;
    }

    setState(() {
      _exceptions.add(exception);
    });
  }

  void _completeAttendance() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arrival'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ArrivalHeader(
                classroomName: widget.classroomName,
                totalChildren: widget.totalChildren,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _completeAttendance,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(60),
                  backgroundColor: AppColors.swayyamGreen,
                ),
                icon: const Icon(Icons.check_circle_rounded),
                label: const Text('Everyone Arrived'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _openExceptionDialog,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(58),
                ),
                icon: const Icon(Icons.warning_amber_rounded),
                label: Text('⚠ Exceptions (${_exceptions.length})'),
              ),
              if (_exceptions.isNotEmpty) ...[
                const SizedBox(height: 14),
                Text(
                  'Exceptions',
                  style: AppTextStyles.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._exceptions.map(
                  (exception) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ArrivalExceptionTile(exception: exception),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ArrivalHeader extends StatelessWidget {
  final String classroomName;
  final int totalChildren;

  const _ArrivalHeader({
    required this.classroomName,
    required this.totalChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.swayyamGreen.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                '🏫',
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning ☀️',
                    style: AppTextStyles.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    classroomName,
                    style: AppTextStyles.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$totalChildren Children',
                    style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Today's Arrival",
                    style: AppTextStyles.textTheme.titleMedium?.copyWith(
                      color: AppColors.swayyamGreen,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

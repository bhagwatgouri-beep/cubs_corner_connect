import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'models/flow_event.dart';
import 'widgets/current_task_card.dart';
import 'widgets/exception_dialog.dart';
import 'widgets/exception_tile.dart';

class FlowEventScreen extends StatefulWidget {
  final FlowEvent event;
  final String classroomName;
  final int totalChildren;
  final int presentChildren;

  const FlowEventScreen({
    super.key,
    required this.event,
    required this.classroomName,
    required this.totalChildren,
    required this.presentChildren,
  });

  @override
  State<FlowEventScreen> createState() => _FlowEventScreenState();
}

class _FlowEventScreenState extends State<FlowEventScreen> {
  final List<FlowEventException> _exceptions = [];

  Future<void> _openExceptionDialog() async {
    final exception = await showDialog<FlowEventException>(
      context: context,
      builder: (_) => const ExceptionDialog(),
    );

    if (exception == null || !mounted) {
      return;
    }

    setState(() {
      _exceptions.add(exception);
    });
  }

  Future<void> _completeStep() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.event.completionMessage),
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 450));

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ClassroomSummary(
                classroomName: widget.classroomName,
                totalChildren: widget.totalChildren,
                presentChildren: widget.presentChildren,
              ),
              const SizedBox(height: 12),
              CurrentTaskCard(
                event: widget.event,
                exceptionCount: _exceptions.length,
                onComplete: _completeStep,
                onAddException: _openExceptionDialog,
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
                    child: ExceptionTile(exception: exception),
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

class _ClassroomSummary extends StatelessWidget {
  final String classroomName;
  final int totalChildren;
  final int presentChildren;

  const _ClassroomSummary({
    required this.classroomName,
    required this.totalChildren,
    required this.presentChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            const Icon(
              Icons.class_rounded,
              color: AppColors.swayyamGreen,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    classroomName,
                    style: AppTextStyles.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$presentChildren present • $totalChildren total',
                    style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
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

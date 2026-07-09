import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'widgets/current_task_card.dart';
import 'widgets/exception_dialog.dart';
import 'widgets/exception_tile.dart';

class FlowEventScreen extends StatefulWidget {
  final String classroomName;
  final int totalChildren;
  final int presentChildren;

  const FlowEventScreen({
    super.key,
    required this.classroomName,
    required this.totalChildren,
    required this.presentChildren,
  });

  @override
  State<FlowEventScreen> createState() => _FlowEventScreenState();
}

class _FlowEventScreenState extends State<FlowEventScreen> {
  final Map<int, List<BreakfastException>> _exceptionsByEvent = {};
  int _currentEventIndex = 0;

  static const List<_TeacherFlowEvent> _flowEvents = [
    _TeacherFlowEvent(
      title: 'Breakfast',
      emoji: '🍎',
      detailsLabel: "Today's Menu",
      details: 'Milk • Poha • Banana',
      completeActionLabel: 'Everyone Had Breakfast',
      completedMessage: 'Breakfast Completed',
    ),
    _TeacherFlowEvent(
      title: 'Learning Activity',
      emoji: '🎨',
      detailsLabel: 'Activity',
      details: 'Story Time • Finger Painting',
      completeActionLabel: 'Complete Activity',
      completedMessage: 'Learning Activity Completed',
    ),
  ];

  _TeacherFlowEvent get _currentEvent => _flowEvents[_currentEventIndex];
  List<BreakfastException> get _currentExceptions =>
      _exceptionsByEvent[_currentEventIndex] ?? const [];

  Future<void> _openExceptionDialog() async {
    final exception = await showDialog<BreakfastException>(
      context: context,
      builder: (_) => const ExceptionDialog(),
    );

    if (exception == null || !mounted) {
      return;
    }

    setState(() {
      final exceptions = _exceptionsByEvent[_currentEventIndex] ?? [];
      _exceptionsByEvent[_currentEventIndex] = [
        ...exceptions,
        exception,
      ];
    });
  }

  void _completeCurrentEvent() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_currentEvent.completedMessage),
      ),
    );

    if (_currentEventIndex >= _flowEvents.length - 1) {
      return;
    }

    setState(() {
      _currentEventIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Workflow'),
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
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: CurrentTaskCard(
                  key: ValueKey(_currentEvent.title),
                  title: _currentEvent.title,
                  emoji: _currentEvent.emoji,
                  detailsLabel: _currentEvent.detailsLabel,
                  details: _currentEvent.details,
                  completeActionLabel: _currentEvent.completeActionLabel,
                  exceptionCount: _currentExceptions.length,
                  onComplete: _completeCurrentEvent,
                  onAddException: _openExceptionDialog,
                ),
              ),
              if (_currentExceptions.isNotEmpty) ...[
                const SizedBox(height: 14),
                Text(
                  'Exceptions',
                  style: AppTextStyles.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._currentExceptions.map(
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

class _TeacherFlowEvent {
  final String title;
  final String emoji;
  final String detailsLabel;
  final String details;
  final String completeActionLabel;
  final String completedMessage;

  const _TeacherFlowEvent({
    required this.title,
    required this.emoji,
    required this.detailsLabel,
    required this.details,
    required this.completeActionLabel,
    required this.completedMessage,
  });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning Teacher',
              style: AppTextStyles.textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _SummaryItem(
                    label: 'Classroom',
                    value: classroomName,
                    icon: Icons.class_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _SummaryItem(
                    label: 'Total',
                    value: totalChildren.toString(),
                    icon: Icons.groups_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _SummaryItem(
                    label: 'Present',
                    value: presentChildren.toString(),
                    icon: Icons.check_circle_rounded,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 64),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.swayyamGreen,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.textTheme.titleMedium,
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'arrival_screen.dart';
import 'flow_event_screen.dart';
import 'models/flow_event.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  bool _attendanceCompleted = false;
  int _currentFlowEventIndex = 0;

  FlowEvent get _currentFlowEvent =>
      FlowEvent.dailyEvents[_currentFlowEventIndex];

  Future<void> _openCurrentTask() async {
    if (!_attendanceCompleted) {
      await _openArrival();
      return;
    }

    final completed = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => FlowEventScreen(
          event: _currentFlowEvent,
          classroomName: 'Nursery A',
          totalChildren: 28,
          presentChildren: 28,
        ),
      ),
    );

    if (!mounted || completed != true) {
      return;
    }

    setState(() {
      if (_currentFlowEventIndex < FlowEvent.dailyEvents.length - 1) {
        _currentFlowEventIndex += 1;
      }
    });
  }

  Future<void> _openArrival() async {
    final completed = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => const ArrivalScreen(
          classroomName: 'Nursery A',
          totalChildren: 28,
        ),
      ),
    );

    if (!mounted || completed != true) {
      return;
    }

    setState(() {
      _attendanceCompleted = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Attendance Completed'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskTitle =
        _attendanceCompleted ? _currentFlowEvent.title : 'Arrival';
    final taskEmoji =
        _attendanceCompleted ? _currentFlowEvent.emoji : '🏫';
    final taskSubtitle = _attendanceCompleted
        ? _formatMenu(_currentFlowEvent)
        : "Today's Arrival";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Home'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.wb_sunny_rounded,
                        color: AppColors.cubsOrange,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Morning',
                              style: AppTextStyles.textTheme.titleLarge,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Nursery A • 28 Children',
                              style:
                                  AppTextStyles.textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Current Task',
                style: AppTextStyles.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              _TeacherTaskCard(
                emoji: taskEmoji,
                title: taskTitle,
                subtitle: taskSubtitle,
                onTap: _openCurrentTask,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatMenu(FlowEvent event) {
    if (event.menuItems.isEmpty) {
      return 'No Menu';
    }

    return event.menuItems.join(' • ');
  }
}

class _TeacherTaskCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _TeacherTaskCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
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
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../models/student.dart';

class AttendanceTab extends StatelessWidget {
  final Student student;

  const AttendanceTab({
    super.key,
    required this.student,
  });

  Widget _statCard(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 36),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: _statCard(
                context,
                'Present',
                '0',
                Icons.check_circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statCard(
                context,
                'Absent',
                '0',
                Icons.cancel,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _statCard(
                context,
                'Late',
                '0',
                Icons.schedule,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statCard(
                context,
                'Attendance',
                '0%',
                Icons.fact_check,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Attendance history will appear here.',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
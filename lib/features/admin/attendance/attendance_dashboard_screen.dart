import 'package:flutter/material.dart';

import '../../../models/attendance_record.dart';
import '../../../repositories/attendance_repository.dart';
import '../../../repositories/student_repository.dart';
import 'mark_attendance_screen.dart';

class AttendanceDashboardScreen extends StatefulWidget {
  const AttendanceDashboardScreen({super.key});

  @override
  State<AttendanceDashboardScreen> createState() =>
      _AttendanceDashboardScreenState();
}

class _AttendanceDashboardScreenState
    extends State<AttendanceDashboardScreen> {
  final AttendanceRepository _attendanceRepository =
      AttendanceRepository.instance;

  String _today() {
    final date = DateTime.now();

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final totalActiveStudents = StudentRepository.instance.activeStudents.length;

    final attendance = _attendanceRepository.todayAttendance();

    final presentToday = attendance
        .where((a) => a.status == AttendanceStatus.present)
        .length;

    final absentToday = attendance
        .where((a) => a.status == AttendanceStatus.absent)
        .length;

    final lateToday = attendance
        .where((a) => a.status == AttendanceStatus.late)
        .length;

    final attendancePercentage = totalActiveStudents == 0
        ? 0
        : (((presentToday + lateToday) / totalActiveStudents) * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            _today(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: [
              _SummaryCard(
                title: 'Total Active Students',
                value: totalActiveStudents.toString(),
                icon: Icons.people,
              ),
              _SummaryCard(
                title: 'Present Today',
                value: presentToday.toString(),
                icon: Icons.check_circle,
              ),
              _SummaryCard(
                title: 'Absent Today',
                value: absentToday.toString(),
                icon: Icons.cancel,
              ),
              _SummaryCard(
                title: 'Late Today',
                value: lateToday.toString(),
                icon: Icons.watch_later,
              ),
              _SummaryCard(
                title: 'Attendance Percentage',
                value: '$attendancePercentage%',
                icon: Icons.pie_chart,
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () async {
              final saved = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MarkAttendanceScreen(),
                ),
              );

              if (saved == true && mounted) {
                setState(() {});
              }
            },
            icon: const Icon(Icons.fact_check),
            label: const Text('Mark Attendance'),
          ),
          const SizedBox(height: 24),
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          _QuickActionCard(
            title: "Today's Attendance",
            icon: Icons.today,
            onTap: () async {
              final saved = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MarkAttendanceScreen(),
                ),
              );

              if (saved == true && mounted) {
                setState(() {});
              }
            },
          ),
          const SizedBox(height: 12),
          const _QuickActionCard(
            title: 'Attendance History',
            icon: Icons.history,
          ),
          const SizedBox(height: 12),
          const _QuickActionCard(
            title: 'Monthly Report',
            icon: Icons.assessment,
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const _QuickActionCard({
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(
          onTap == null ? Icons.lock_outline : Icons.arrow_forward_ios,
          size: onTap == null ? null : 16,
        ),
        enabled: onTap != null,
        onTap: onTap,
      ),
    );
  }
}
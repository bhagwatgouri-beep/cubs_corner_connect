import 'package:flutter/material.dart';

import '../../../repositories/student_repository.dart';

class AttendanceDashboardScreen extends StatelessWidget {
  const AttendanceDashboardScreen({super.key});

  String _today() {
    final date = DateTime.now();

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final totalActiveStudents = StudentRepository.instance.activeStudents.length;
    const presentToday = 0;
    final absentToday = totalActiveStudents;

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
              const _SummaryCard(
                title: 'Present Today',
                value: '$presentToday',
                icon: Icons.check_circle,
              ),
              _SummaryCard(
                title: 'Absent Today',
                value: absentToday.toString(),
                icon: Icons.cancel,
              ),
              const _SummaryCard(
                title: 'Attendance Percentage',
                value: '0%',
                icon: Icons.pie_chart,
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: null,
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
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Attendance marking will be available in ATT-002.'),
                ),
              );
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

import 'package:flutter/material.dart';

import '../../../repositories/classroom_repository.dart';
import 'add_classroom_screen.dart';
import 'classroom_directory_screen.dart';
import 'classroom_reports_screen.dart';

class ClassroomDashboardScreen extends StatelessWidget {
  const ClassroomDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ClassroomRepository.instance;

    final total = repository.totalClassrooms();
    final active = repository.totalActiveClassrooms();
    final inactive = repository.totalInactiveClassrooms();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom Management'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Overview',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Classrooms',
                  value: total.toString(),
                  icon: Icons.class_,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  title: 'Active',
                  value: active.toString(),
                  icon: Icons.check_circle,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Inactive',
                  value: inactive.toString(),
                  icon: Icons.cancel,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),

          const SizedBox(height: 32),

          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _MenuCard(
            title: 'Add Classroom',
            icon: Icons.add_home_work,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const AddClassroomScreen(),
                ),
              );
            },
          ),

          _MenuCard(
            title: 'Classroom Directory',
            icon: Icons.meeting_room,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const ClassroomDirectoryScreen(),
                ),
              );
            },
          ),

          _MenuCard(
            title: 'Reports',
            icon: Icons.assessment,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const ClassroomReportsScreen(),
                ),
              );
            },
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 34),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
        onTap: onTap,
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../repositories/teacher_repository.dart';

class TeacherReportsScreen extends StatelessWidget {
  const TeacherReportsScreen({super.key});

  Widget _reportTile({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text(
          value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repository = TeacherRepository.instance;

    final total = repository.totalTeachers();
    final active = repository.totalActiveTeachers();
    final inactive = repository.totalInactiveTeachers();

    final roles = <String, int>{};

    for (final teacher in repository.teachers) {
      roles.update(
        teacher.role,
            (count) => count + 1,
        ifAbsent: () => 1,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Reports'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _reportTile(
            context: context,
            title: 'Total Staff',
            value: total.toString(),
            icon: Icons.people,
          ),
          _reportTile(
            context: context,
            title: 'Active Staff',
            value: active.toString(),
            icon: Icons.check_circle,
          ),
          _reportTile(
            context: context,
            title: 'Inactive Staff',
            value: inactive.toString(),
            icon: Icons.cancel,
          ),
          const SizedBox(height: 24),
          Text(
            'Staff by Role',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (roles.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No staff available.'),
              ),
            )
          else
            ...roles.entries.map(
                  (entry) => Card(
                child: ListTile(
                  leading: const Icon(Icons.badge),
                  title: Text(entry.key),
                  trailing: Text(
                    entry.value.toString(),
                    style:
                    Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
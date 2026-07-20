import 'package:flutter/material.dart';

import '../../../repositories/classroom_repository.dart';

class ClassroomReportsScreen extends StatelessWidget {
  const ClassroomReportsScreen({super.key});

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
    final repository = ClassroomRepository.instance;

    final total = repository.totalClassrooms();
    final active = repository.totalActiveClassrooms();
    final inactive = repository.totalInactiveClassrooms();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom Reports'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _reportTile(
            context: context,
            title: 'Total Classrooms',
            value: total.toString(),
            icon: Icons.class_,
          ),
          _reportTile(
            context: context,
            title: 'Active Classrooms',
            value: active.toString(),
            icon: Icons.check_circle,
          ),
          _reportTile(
            context: context,
            title: 'Inactive Classrooms',
            value: inactive.toString(),
            icon: Icons.cancel,
          ),
          const SizedBox(height: 24),
          Text(
            'Classroom Capacity',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (repository.classrooms.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No classrooms available.'),
              ),
            )
          else
            ...repository.classrooms.map(
                  (classroom) => Card(
                child: ListTile(
                  leading: const Icon(Icons.meeting_room),
                  title: Text(classroom.name),
                  subtitle: Text(
                    '${classroom.currentStrength}/${classroom.capacity} Students',
                  ),
                  trailing: Text(
                    classroom.section,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
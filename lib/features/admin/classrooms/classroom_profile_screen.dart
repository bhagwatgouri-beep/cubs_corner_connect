import 'package:flutter/material.dart';

import '../../../models/classroom.dart';
import 'assign_teacher_screen.dart';
import 'edit_classroom_screen.dart';

class ClassroomProfileScreen extends StatelessWidget {
  final Classroom classroom;

  const ClassroomProfileScreen({
    super.key,
    required this.classroom,
  });

  Widget _infoTile(String title, String value) {
    return ListTile(
      dense: true,
      title: Text(title),
      subtitle: Text(
        value.isEmpty ? '-' : value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.class_,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    classroom.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),
                  Text(classroom.code),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(
                      '${classroom.ageGroup} - ${classroom.section}',
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Column(
              children: [
                _infoTile(
                  'Age Group',
                  classroom.ageGroup,
                ),
                _infoTile(
                  'Section',
                  classroom.section,
                ),
                _infoTile(
                  'Room Number',
                  classroom.roomNumber,
                ),
                _infoTile(
                  'Capacity',
                  classroom.capacity.toString(),
                ),
                _infoTile(
                  'Current Strength',
                  classroom.currentStrength.toString(),
                ),
                _infoTile(
                  'Teachers Assigned',
                  classroom.teacherIds.length.toString(),
                ),
                _infoTile(
                  'Remarks',
                  classroom.remarks,
                ),
                _infoTile(
                  'Status',
                  classroom.isActive
                      ? 'Active'
                      : 'Inactive',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text('Edit Classroom'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      EditClassroomScreen(
                        classroom: classroom,
                      ),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          FilledButton.icon(
            icon: const Icon(Icons.people),
            label: const Text('Assign Teachers'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      AssignTeacherScreen(
                        classroom: classroom,
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
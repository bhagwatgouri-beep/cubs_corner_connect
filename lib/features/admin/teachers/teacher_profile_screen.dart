import 'package:flutter/material.dart';

import '../../../models/teacher.dart';
import 'assign_class_screen.dart';
import 'edit_teacher_screen.dart';
import 'teacher_attendance_screen.dart';

class TeacherProfileScreen extends StatelessWidget {
  final Teacher teacher;

  const TeacherProfileScreen({
    super.key,
    required this.teacher,
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
        title: const Text('Staff Profile'),
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
                      Icons.person,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    teacher.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),
                  Text(
                    teacher.employeeCode,
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(teacher.role),
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
                  'Designation',
                  teacher.designation,
                ),
                _infoTile(
                  'Qualification',
                  teacher.qualification,
                ),
                _infoTile(
                  'Phone',
                  teacher.phoneNumber,
                ),
                _infoTile(
                  'Email',
                  teacher.email,
                ),
                _infoTile(
                  'Address',
                  teacher.address,
                ),
                _infoTile(
                  'Remarks',
                  teacher.remarks,
                ),
                _infoTile(
                  'Status',
                  teacher.isActive
                      ? 'Active'
                      : 'Inactive',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text('Edit Staff'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditTeacherScreen(
                    teacher: teacher,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          FilledButton.icon(
            icon: const Icon(Icons.class_),
            label: const Text('Assign Classes'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AssignClassScreen(
                    teacher: teacher,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          FilledButton.icon(
            icon: const Icon(Icons.fact_check),
            label: const Text('Attendance'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const TeacherAttendanceScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
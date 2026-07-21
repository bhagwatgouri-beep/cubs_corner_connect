import 'package:flutter/material.dart';

import '../../../../models/student.dart';

class OverviewTab extends StatelessWidget {
  final Student student;

  const OverviewTab({
    super.key,
    required this.student,
  });

  Widget _tile(String title, String value) {
    return ListTile(
      dense: true,
      title: Text(title),
      subtitle: Text(
        value.trim().isEmpty ? '-' : value,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 42,
                  child: Text(
                    student.firstName.isEmpty
                        ? '?'
                        : student.firstName[0].toUpperCase(),
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  student.fullName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(student.admissionNumber),
                const SizedBox(height: 12),
                Chip(
                  label: Text(student.classroomId),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              _tile(
                'Admission Number',
                student.admissionNumber,
              ),
              _tile(
                'Gender',
                student.gender,
              ),
              _tile(
                'Date of Birth',
                _formatDate(student.dateOfBirth),
              ),
              _tile(
                'Class',
                student.classroomId,
              ),
              _tile(
                'Centre',
                student.centreId,
              ),
              _tile(
                'Status',
                student.isActive ? 'Active' : 'Inactive',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
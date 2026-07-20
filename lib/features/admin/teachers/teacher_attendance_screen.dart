import 'package:flutter/material.dart';

import '../../../models/teacher.dart';
import '../../../repositories/teacher_repository.dart';

enum AttendanceStatus {
  present,
  absent,
  leave,
  halfDay,
}

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState
    extends State<TeacherAttendanceScreen> {
  final Map<String, AttendanceStatus> _attendance = {};

  @override
  Widget build(BuildContext context) {
    final teachers = TeacherRepository.instance.activeTeachers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Attendance'),
      ),
      body: teachers.isEmpty
          ? const Center(
        child: Text('No staff available'),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          final Teacher teacher = teachers[index];

          final status = _attendance[teacher.id] ??
              AttendanceStatus.present;

          return Card(
            margin:
            const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    teacher.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  Text(
                    teacher.employeeCode,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<
                      AttendanceStatus>(
                    initialValue: status,
                    decoration:
                    const InputDecoration(
                      border:
                      OutlineInputBorder(),
                      labelText: 'Status',
                    ),
                    items:
                    AttendanceStatus.values
                        .map(
                          (value) =>
                          DropdownMenuItem(
                            value: value,
                            child: Text(
                              switch (value) {
                                AttendanceStatus.present =>
                                'Present',
                                AttendanceStatus.absent =>
                                'Absent',
                                AttendanceStatus.leave =>
                                'Leave',
                                AttendanceStatus.halfDay =>
                                'Half Day',
                              },
                            ),
                          ),
                    )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        _attendance[
                        teacher.id] = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Attendance saved successfully',
              ),
            ),
          );
        },
        icon: const Icon(Icons.save),
        label: const Text('Save'),
      ),
    );
  }
}
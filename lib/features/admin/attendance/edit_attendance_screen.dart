import 'package:flutter/material.dart';

import '../../../models/attendance_record.dart';
import '../../../models/student.dart';
import '../../../repositories/attendance_repository.dart';
import '../../../repositories/student_repository.dart';

class EditAttendanceScreen extends StatefulWidget {
  const EditAttendanceScreen({super.key});

  @override
  State<EditAttendanceScreen> createState() =>
      _EditAttendanceScreenState();
}

class _EditAttendanceScreenState
    extends State<EditAttendanceScreen> {
  final AttendanceRepository _attendanceRepository =
      AttendanceRepository.instance;

  final StudentRepository _studentRepository =
      StudentRepository.instance;

  late final List<Student> _students;

  final Map<String, AttendanceStatus> _attendance = {};

  @override
  void initState() {
    super.initState();

    _students = _studentRepository.activeStudents;

    final today = DateTime.now();

    for (final student in _students) {
      final record = _attendanceRepository.attendanceForStudentOnDate(
        student.id,
        today,
      );

      _attendance[student.id] =
          record?.status ?? AttendanceStatus.present;
    }
  }

  Widget _statusChip(
      Student student,
      AttendanceStatus status,
      String label,
      ) {
    return ChoiceChip(
      label: Text(label),
      selected: _attendance[student.id] == status,
      onSelected: (_) {
        setState(() {
          _attendance[student.id] = status;
        });
      },
    );
  }

  void _save() {
    final now = DateTime.now();

    final records = _students.map((student) {
      return AttendanceRecord(
        id: '${now.microsecondsSinceEpoch}_${student.id}',
        studentId: student.id,
        date: now,
        status: _attendance[student.id]!,
        markedAt: now,
        markedBy: 'Teacher',
      );
    }).toList();

    _attendanceRepository.updateAttendance(records);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Today\'s Attendance'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text(
              'SAVE',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    student.fullName,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(student.admissionNumber),
                  Text('Class: ${student.classroomId}'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _statusChip(
                        student,
                        AttendanceStatus.present,
                        'Present',
                      ),
                      _statusChip(
                        student,
                        AttendanceStatus.absent,
                        'Absent',
                      ),
                      _statusChip(
                        student,
                        AttendanceStatus.late,
                        'Late',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
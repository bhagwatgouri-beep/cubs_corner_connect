import 'package:flutter/material.dart';

import '../../../models/attendance_record.dart';
import '../../../models/student.dart';
import '../../../repositories/attendance_repository.dart';
import '../../../repositories/student_repository.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState
    extends State<AttendanceHistoryScreen> {
  final AttendanceRepository _attendanceRepository =
      AttendanceRepository.instance;

  DateTime _selectedDate = DateTime.now();

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Student? _student(String id) {
    try {
      return StudentRepository.instance.students.firstWhere(
            (student) => student.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  Color _statusColor(BuildContext context, AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return Colors.green;
      case AttendanceStatus.absent:
        return Theme.of(context).colorScheme.error;
      case AttendanceStatus.late:
        return Colors.orange;
    }
  }

  String _statusText(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.absent:
        return 'Absent';
      case AttendanceStatus.late:
        return 'Late';
    }
  }

  @override
  Widget build(BuildContext context) {
    final records =
    _attendanceRepository.attendanceForDate(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(_formatDate(_selectedDate)),
            ),
          ),
          Expanded(
            child: records.isEmpty
                ? const Center(
              child: Text(
                'No attendance recorded for this date.',
              ),
            )
                : ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                final student = _student(record.studentId);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        student == null
                            ? '?'
                            : student.firstName[0].toUpperCase(),
                      ),
                    ),
                    title: Text(
                      student?.fullName ?? 'Unknown Student',
                    ),
                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          student?.admissionNumber ?? '-',
                        ),
                        Text(
                          'Class: ${student?.classroomId ?? '-'}',
                        ),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(
                        _statusText(record.status),
                      ),
                      backgroundColor:
                      _statusColor(context, record.status),
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
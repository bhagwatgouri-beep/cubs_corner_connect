import 'package:flutter/material.dart';

import '../../../models/attendance_record.dart';
import '../../../models/student.dart';
import '../../../repositories/attendance_repository.dart';
import '../../../repositories/student_repository.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() =>
      _AttendanceReportScreenState();
}

class _AttendanceReportScreenState
    extends State<AttendanceReportScreen> {
  final AttendanceRepository _attendanceRepository =
      AttendanceRepository.instance;

  DateTime _selectedMonth = DateTime.now();

  Future<void> _pickMonth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedMonth,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        _selectedMonth = DateTime(picked.year, picked.month);
      });
    }
  }

  Map<String, int> _summary(Student student) {
    final records = _attendanceRepository
        .attendanceForStudent(student.id)
        .where(
          (record) =>
      record.date.year == _selectedMonth.year &&
          record.date.month == _selectedMonth.month,
    )
        .toList();

    final present = records
        .where((r) => r.status == AttendanceStatus.present)
        .length;

    final absent = records
        .where((r) => r.status == AttendanceStatus.absent)
        .length;

    final late = records
        .where((r) => r.status == AttendanceStatus.late)
        .length;

    final total = records.length;

    final percentage = total == 0
        ? 0
        : (((present + late) / total) * 100).round();

    return {
      'present': present,
      'absent': absent,
      'late': late,
      'total': total,
      'percentage': percentage,
    };
  }

  @override
  Widget build(BuildContext context) {
    final students = StudentRepository.instance.activeStudents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Reports'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton.icon(
              onPressed: _pickMonth,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                '${_selectedMonth.month.toString().padLeft(2, '0')}/${_selectedMonth.year}',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                final summary = _summary(student);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(student.fullName),
                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(student.admissionNumber),
                        Text(
                          'Present: ${summary['present']}   '
                              'Absent: ${summary['absent']}   '
                              'Late: ${summary['late']}',
                        ),
                      ],
                    ),
                    trailing: CircleAvatar(
                      child: Text(
                        '${summary['percentage']}%',
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
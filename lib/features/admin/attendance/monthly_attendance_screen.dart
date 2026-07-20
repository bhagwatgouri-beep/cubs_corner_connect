import 'package:flutter/material.dart';

import '../../../models/attendance_record.dart';
import '../../../models/student.dart';
import '../../../repositories/attendance_repository.dart';
import '../../../repositories/student_repository.dart';

class MonthlyAttendanceScreen extends StatefulWidget {
  const MonthlyAttendanceScreen({super.key});

  @override
  State<MonthlyAttendanceScreen> createState() =>
      _MonthlyAttendanceScreenState();
}

class _MonthlyAttendanceScreenState
    extends State<MonthlyAttendanceScreen> {
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

  List<AttendanceRecord> _recordsForStudent(String studentId) {
    return _attendanceRepository
        .attendanceForStudent(studentId)
        .where(
          (record) =>
      record.date.year == _selectedMonth.year &&
          record.date.month == _selectedMonth.month,
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final students = StudentRepository.instance.activeStudents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Attendance'),
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
                final Student student = students[index];
                final records = _recordsForStudent(student.id);

                final present = records
                    .where((r) => r.status == AttendanceStatus.present)
                    .length;

                final absent = records
                    .where((r) => r.status == AttendanceStatus.absent)
                    .length;

                final late = records
                    .where((r) => r.status == AttendanceStatus.late)
                    .length;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(student.fullName),
                    subtitle: Text(student.admissionNumber),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('P: $present'),
                        Text('A: $absent'),
                        Text('L: $late'),
                      ],
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
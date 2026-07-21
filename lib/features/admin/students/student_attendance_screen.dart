import 'package:flutter/material.dart';

import '../../../models/attendance_record.dart';
import '../../../models/student.dart';
import '../../../repositories/attendance_repository.dart';

class StudentAttendanceScreen extends StatelessWidget {
  final Student student;

  const StudentAttendanceScreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    final attendance = AttendanceRepository.instance
        .attendanceForStudent(student.id);

    final total = attendance.length;

    final present = attendance
        .where((record) =>
    record.status == AttendanceStatus.present ||
        record.status == AttendanceStatus.late)
        .length;

    final percentage =
    total == 0 ? 0 : ((present / total) * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Attendance'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    child: Text(
                      student.firstName.isEmpty
                          ? '?'
                          : student.firstName[0].toUpperCase(),
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    student.fullName,
                    style:
                    Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(student.admissionNumber),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '$percentage%',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium,
                          ),
                          const Text('Attendance'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '$total',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium,
                          ),
                          const Text('Records'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Attendance History',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          if (attendance.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'No attendance records found.',
                  ),
                ),
              ),
            )
          else
            ...attendance.map(
                  (record) => Card(
                child: ListTile(
                  leading: Icon(
                    record.status == AttendanceStatus.present
                        ? Icons.check_circle
                        : record.status ==
                        AttendanceStatus.late
                        ? Icons.watch_later
                        : Icons.cancel,
                  ),
                  title: Text(
                    '${record.date.day.toString().padLeft(2, '0')}/'
                        '${record.date.month.toString().padLeft(2, '0')}/'
                        '${record.date.year}',
                  ),
                  subtitle: Text(
                    record.status.name.toUpperCase(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
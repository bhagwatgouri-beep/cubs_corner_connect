import 'package:flutter/material.dart';

import '../../../models/daycare_record.dart';
import '../../../models/student.dart';
import '../../../repositories/daycare_repository.dart';
import '../../../repositories/student_repository.dart';

class DaycareHistoryScreen extends StatelessWidget {
  const DaycareHistoryScreen({super.key});

  static final DaycareRepository _daycareRepository =
      DaycareRepository.instance;

  static final StudentRepository _studentRepository =
      StudentRepository.instance;

  Student? _student(String id) {
    try {
      return _studentRepository.students.firstWhere(
            (student) => student.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  String _time(DateTime? time) {
    if (time == null) return '-';

    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final records =
    _daycareRepository.recordsForDate(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daycare History'),
      ),
      body: records.isEmpty
          ? const Center(
        child: Text('No daycare records found.'),
      )
          : ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          final DaycareRecord record = records[index];
          final Student? student =
          _student(record.studentId);

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
                      : student.firstName[0]
                      .toUpperCase(),
                ),
              ),
              title: Text(
                student?.fullName ??
                    'Unknown Student',
              ),
              subtitle: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    student?.classroomId ?? '-',
                  ),
                  Text(
                    'Check In : ${_time(record.checkInTime)}',
                  ),
                  Text(
                    'Check Out : ${_time(record.checkOutTime)}',
                  ),
                  Text(
                    'Pickup : ${record.pickupPerson.isEmpty ? "-" : record.pickupPerson}',
                  ),
                ],
              ),
              trailing: Icon(
                record.isCheckedOut
                    ? Icons.check_circle
                    : Icons.schedule,
                color: record.isCheckedOut
                    ? Colors.green
                    : Colors.orange,
              ),
            ),
          );
        },
      ),
    );
  }
}
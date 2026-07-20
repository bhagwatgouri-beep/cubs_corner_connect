import 'package:flutter/material.dart';

import '../../../models/daycare_record.dart';
import '../../../models/student.dart';
import '../../../repositories/daycare_repository.dart';
import '../../../repositories/student_repository.dart';

class LiveDaycareBoardScreen extends StatefulWidget {
  const LiveDaycareBoardScreen({super.key});

  @override
  State<LiveDaycareBoardScreen> createState() =>
      _LiveDaycareBoardScreenState();
}

class _LiveDaycareBoardScreenState
    extends State<LiveDaycareBoardScreen> {
  final DaycareRepository _daycareRepository =
      DaycareRepository.instance;

  final StudentRepository _studentRepository =
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
    _daycareRepository.activeChildren(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Daycare Board'),
      ),
      body: records.isEmpty
          ? const Center(
        child: Text('No children currently checked in.'),
      )
          : ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          final DaycareRecord record = records[index];
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
                  Text(student?.classroomId ?? '-'),
                  Text(
                    'Checked In: ${_time(record.checkInTime)}',
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.circle,
                color: Colors.green,
              ),
            ),
          );
        },
      ),
    );
  }
}
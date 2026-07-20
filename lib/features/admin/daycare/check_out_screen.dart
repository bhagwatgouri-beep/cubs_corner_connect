import 'package:flutter/material.dart';

import '../../../models/daycare_record.dart';
import '../../../models/student.dart';
import '../../../repositories/daycare_repository.dart';
import '../../../repositories/student_repository.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final StudentRepository _studentRepository =
      StudentRepository.instance;

  final DaycareRepository _daycareRepository =
      DaycareRepository.instance;

  late final List<Student> _students;

  @override
  void initState() {
    super.initState();
    _students = _studentRepository.activeStudents;
  }

  DaycareRecord? _record(Student student) {
    return _daycareRepository.recordForStudentOnDate(
      student.id,
      DateTime.now(),
    );
  }

  bool _canCheckOut(Student student) {
    final record = _record(student);

    return record != null &&
        record.isCheckedIn &&
        !record.isCheckedOut;
  }

  void _checkOut(Student student) {
    final record = _record(student);

    if (record == null) return;

    final now = DateTime.now();

    final updated = record.copyWith(
      checkOutTime: now,
      checkedOutBy: 'Teacher',
      isCheckedOut: true,
      updatedAt: now,
    );

    _daycareRepository.saveRecord(updated);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${student.fullName} checked out'),
      ),
    );

    setState(() {});
  }

  String _time(DateTime? time) {
    if (time == null) return '-';

    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daycare Check-Out'),
      ),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];
          final record = _record(student);

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  student.firstName[0].toUpperCase(),
                ),
              ),
              title: Text(student.fullName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student.classroomId),
                  Text(
                    'Check In: ${_time(record?.checkInTime)}',
                  ),
                  Text(
                    'Check Out: ${_time(record?.checkOutTime)}',
                  ),
                ],
              ),
              trailing: FilledButton(
                onPressed: _canCheckOut(student)
                    ? () => _checkOut(student)
                    : null,
                child: Text(
                  record?.isCheckedOut == true
                      ? 'Done'
                      : 'Check Out',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../models/daycare_record.dart';
import '../../../models/student.dart';
import '../../../repositories/daycare_repository.dart';
import '../../../repositories/student_repository.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
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

  void _checkIn(Student student) {
    final now = DateTime.now();

    final record = DaycareRecord(
      id: '${now.microsecondsSinceEpoch}_${student.id}',
      studentId: student.id,
      date: now,
      checkInTime: now,
      checkedInBy: 'Teacher',
      isCheckedIn: true,
      isCheckedOut: false,
      createdAt: now,
      updatedAt: now,
    );

    _daycareRepository.saveRecord(record);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${student.fullName} checked in'),
      ),
    );

    setState(() {});
  }

  bool _alreadyCheckedIn(Student student) {
    final record = _daycareRepository.recordForStudentOnDate(
      student.id,
      DateTime.now(),
    );

    return record?.isCheckedIn == true &&
        record?.isCheckedOut == false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daycare Check-In'),
      ),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];
          final checkedIn = _alreadyCheckedIn(student);

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
              subtitle: Text(student.classroomId),
              trailing: FilledButton(
                onPressed: checkedIn
                    ? null
                    : () => _checkIn(student),
                child: Text(
                  checkedIn ? 'Checked In' : 'Check In',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../repositories/student_repository.dart';
import '../../../models/student.dart';

class StudentDirectoryScreen extends StatefulWidget {
  const StudentDirectoryScreen({super.key});

  @override
  State<StudentDirectoryScreen> createState() =>
      _StudentDirectoryScreenState();
}

class _StudentDirectoryScreenState
    extends State<StudentDirectoryScreen> {
  final repository = StudentRepository.instance;

  @override
  Widget build(BuildContext context) {
    final List<Student> students = repository.students;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Directory"),
      ),
      body: students.isEmpty
          ? const Center(
        child: Text("No students found"),
      )
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  student.firstName[0],
                ),
              ),
              title: Text(student.fullName),
              subtitle: Text(
                student.classroomId,
              ),
              trailing: student.isDaycareEnrolled
                  ? const Icon(
                Icons.child_care,
                color: Colors.green,
              )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
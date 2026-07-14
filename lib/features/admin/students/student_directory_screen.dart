import 'package:flutter/material.dart';

import '../../../models/student.dart';
import '../../../repositories/student_repository.dart';
import '../admissions/add_student_screen.dart';

class StudentDirectoryScreen extends StatefulWidget {
  const StudentDirectoryScreen({super.key});

  @override
  State<StudentDirectoryScreen> createState() =>
      _StudentDirectoryScreenState();
}

class _StudentDirectoryScreenState
    extends State<StudentDirectoryScreen> {
  final repository = StudentRepository.instance;

  Future<void> _openNewAdmission() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddStudentScreen(),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Student> students = repository.students;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Directory"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            tooltip: "New Admission",
            onPressed: _openNewAdmission,
          ),
        ],
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
                child: Text(student.firstName[0]),
              ),
              title: Text(student.fullName),
              subtitle: Text(student.classroomId),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openNewAdmission,
        icon: const Icon(Icons.person_add),
        label: const Text("New Admission"),
      ),
    );
  }
}
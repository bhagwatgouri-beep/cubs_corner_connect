import 'package:flutter/material.dart';

import '../../../models/student.dart';
import '../../../repositories/student_repository.dart';
import '../../../shared/widgets/app_search_bar.dart';
import '../admissions/add_student_screen.dart';
import 'student_profile_screen.dart';

class StudentDirectoryScreen extends StatefulWidget {
  const StudentDirectoryScreen({super.key});

  @override
  State<StudentDirectoryScreen> createState() =>
      _StudentDirectoryScreenState();
}

class _StudentDirectoryScreenState
    extends State<StudentDirectoryScreen> {
  final StudentRepository repository = StudentRepository.instance;

  String _search = '';

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

  Future<void> _openStudent(Student student) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StudentProfileScreen(
          student: student,
        ),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  int _calculateAge(DateTime dob) {
    final now = DateTime.now();

    int age = now.year - dob.year;

    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }

    return age;
  }

  @override
  Widget build(BuildContext context) {
    final allStudents = repository.students;

    final students = allStudents.where((student) {
      if (_search.isEmpty) return true;

      final query = _search.toLowerCase();

      return student.fullName.toLowerCase().contains(query) ||
          student.admissionNumber.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Directory"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openNewAdmission,
        icon: const Icon(Icons.person_add),
        label: const Text("New Admission"),
      ),
      body: Column(
        children: [
          AppSearchBar(
            hintText: "Search by name or admission no.",
            onChanged: (value) {
              setState(() {
                _search = value;
              });
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.people),
                ),
                title: const Text("Total Students"),
                trailing: Text(
                  students.length.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: students.isEmpty
                ? const Center(
              child: Text("No students found"),
            )
                : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    onTap: () => _openStudent(student),

                    leading: CircleAvatar(
                      child: Text(
                        student.firstName.isEmpty
                            ? "?"
                            : student.firstName[0]
                            .toUpperCase(),
                      ),
                    ),

                    title: Text(student.fullName),

                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.admissionNumber,
                        ),

                        Text(
                          "${_calculateAge(student.dateOfBirth)} years",
                        ),

                        Text(
                          student.classroomId,
                        ),
                      ],
                    ),

                    trailing: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        if (student.isDaycareEnrolled)
                          const Icon(
                            Icons.child_care,
                            color: Colors.green,
                          ),
                        if (student.usesTransport)
                          const Icon(
                            Icons.directions_bus,
                            color: Colors.blue,
                          ),
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
import 'package:flutter/material.dart';

import '../../../models/parent.dart';
import '../../../models/student.dart';
import '../../../repositories/parent_repository.dart';
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

class _StudentDirectoryScreenState extends State<StudentDirectoryScreen> {
  final StudentRepository repository = StudentRepository.instance;
  final ParentRepository _parentRepository = ParentRepository.instance;

  String _search = '';
  String? _selectedClass;
  String? _selectedStatus;

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

  Parent? _parentFor(Student student) {
    if (student.parentIds.isEmpty) return null;

    return _parentRepository.getParent(student.parentIds.first);
  }

  @override
  Widget build(BuildContext context) {
    final allStudents = repository.students;
    final classes = allStudents
        .map((student) => student.classroomId)
        .where((classroom) => classroom.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    final students = allStudents.where((student) {
      final parent = _parentFor(student);
      final query = _search.toLowerCase();
      final matchesSearch = query.isEmpty ||
          student.fullName.toLowerCase().contains(query) ||
          student.admissionNumber.toLowerCase().contains(query) ||
          (parent?.fullName.toLowerCase().contains(query) ?? false) ||
          (parent?.mobileNumber.contains(query) ?? false);
      final matchesClass =
          _selectedClass == null || student.classroomId == _selectedClass;
      final matchesStatus = _selectedStatus == null ||
          (_selectedStatus == 'Active' && student.isActive) ||
          (_selectedStatus == 'Inactive' && !student.isActive);

      return matchesSearch && matchesClass && matchesStatus;
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
            hintText: "Search student, parent or mobile",
            onChanged: (value) {
              setState(() {
                _search = value;
              });
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _selectedClass,
                    decoration: const InputDecoration(
                      labelText: "Class",
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text("All Classes"),
                      ),
                      ...classes.map(
                        (classroom) => DropdownMenuItem(
                          value: classroom,
                          child: Text(classroom),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedClass = value;
                      });
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _selectedStatus,
                    decoration: const InputDecoration(
                      labelText: "Status",
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: null,
                        child: Text("All Statuses"),
                      ),
                      DropdownMenuItem(
                        value: "Active",
                        child: Text("Active"),
                      ),
                      DropdownMenuItem(
                        value: "Inactive",
                        child: Text("Inactive"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

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
                      final parent = _parentFor(student);

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
                                  : student.firstName[0].toUpperCase(),
                            ),
                          ),
                          title: Text(student.fullName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(student.admissionNumber),
                              Text("Class: ${student.classroomId}"),
                              Text(
                                "Parent: ${parent?.fullName.trim().isEmpty ?? true ? '-' : parent!.fullName.trim()}",
                              ),
                              Text(
                                "Mobile: ${parent?.mobileNumber.isEmpty ?? true ? '-' : parent!.mobileNumber}",
                              ),
                            ],
                          ),
                          trailing: Text(
                            student.isActive ? "Active" : "Inactive",
                            style: TextStyle(
                              color: student.isActive
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.w600,
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

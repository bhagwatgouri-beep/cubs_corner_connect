import 'package:flutter/material.dart';

import '../../../models/teacher.dart';
import '../../../repositories/teacher_repository.dart';
import 'teacher_profile_screen.dart';

class TeacherDirectoryScreen extends StatefulWidget {
  const TeacherDirectoryScreen({super.key});

  @override
  State<TeacherDirectoryScreen> createState() =>
      _TeacherDirectoryScreenState();
}

class _TeacherDirectoryScreenState
    extends State<TeacherDirectoryScreen> {
  final TextEditingController _searchController =
  TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = TeacherRepository.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Directory'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search staff...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                final query =
                _searchController.text.trim().toLowerCase();

                final List<Teacher> teachers = repository.teachers
                    .where((teacher) {
                  return teacher.name
                      .toLowerCase()
                      .contains(query) ||
                      teacher.employeeCode
                          .toLowerCase()
                          .contains(query) ||
                      teacher.role
                          .toLowerCase()
                          .contains(query);
                }).toList();

                if (teachers.isEmpty) {
                  return const Center(
                    child: Text('No staff found'),
                  );
                }

                return ListView.builder(
                  itemCount: teachers.length,
                  itemBuilder: (context, index) {
                    final teacher = teachers[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            teacher.name.isNotEmpty
                                ? teacher.name[0]
                                .toUpperCase()
                                : '?',
                          ),
                        ),
                        title: Text(teacher.name),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              teacher.employeeCode,
                            ),
                            Text(
                              teacher.designation,
                            ),
                            Text(
                              teacher.phoneNumber,
                            ),
                          ],
                        ),
                        trailing: Icon(
                          teacher.isActive
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: teacher.isActive
                              ? Colors.green
                              : Colors.red,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  TeacherProfileScreen(
                                    teacher: teacher,
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
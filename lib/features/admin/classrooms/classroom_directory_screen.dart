import 'package:flutter/material.dart';

import '../../../models/classroom.dart';
import '../../../repositories/classroom_repository.dart';
import 'classroom_profile_screen.dart';

class ClassroomDirectoryScreen extends StatefulWidget {
  const ClassroomDirectoryScreen({super.key});

  @override
  State<ClassroomDirectoryScreen> createState() =>
      _ClassroomDirectoryScreenState();
}

class _ClassroomDirectoryScreenState
    extends State<ClassroomDirectoryScreen> {
  final TextEditingController _searchController =
  TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = ClassroomRepository.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom Directory'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search classroom...',
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
                final query = _searchController.text
                    .trim()
                    .toLowerCase();

                final classrooms = repository.classrooms
                    .where((classroom) {
                  return classroom.name
                      .toLowerCase()
                      .contains(query) ||
                      classroom.code
                          .toLowerCase()
                          .contains(query) ||
                      classroom.ageGroup
                          .toLowerCase()
                          .contains(query);
                }).toList();

                if (classrooms.isEmpty) {
                  return const Center(
                    child: Text('No classrooms found'),
                  );
                }

                return ListView.builder(
                  itemCount: classrooms.length,
                  itemBuilder: (context, index) {
                    final Classroom classroom =
                    classrooms[index];

                    return Card(
                      margin:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.class_),
                        ),
                        title: Text(classroom.name),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(classroom.code),
                            Text(
                              '${classroom.ageGroup} - Section ${classroom.section}',
                            ),
                            Text(
                              'Strength ${classroom.currentStrength}/${classroom.capacity}',
                            ),
                          ],
                        ),
                        trailing: Icon(
                          classroom.isActive
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: classroom.isActive
                              ? Colors.green
                              : Colors.red,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ClassroomProfileScreen(
                                    classroom: classroom,
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
import 'package:flutter/material.dart';

import '../../../models/classroom.dart';
import '../../../models/teacher.dart';
import '../../../repositories/classroom_repository.dart';
import '../../../repositories/teacher_repository.dart';

class AssignTeacherScreen extends StatefulWidget {
  final Classroom classroom;

  const AssignTeacherScreen({
    super.key,
    required this.classroom,
  });

  @override
  State<AssignTeacherScreen> createState() =>
      _AssignTeacherScreenState();
}

class _AssignTeacherScreenState
    extends State<AssignTeacherScreen> {
  late List<String> _assignedTeachers;

  @override
  void initState() {
    super.initState();
    _assignedTeachers =
    List<String>.from(widget.classroom.teacherIds);
  }

  void _toggleTeacher(String teacherId) {
    setState(() {
      if (_assignedTeachers.contains(teacherId)) {
        _assignedTeachers.remove(teacherId);
      } else {
        _assignedTeachers.add(teacherId);
      }
    });
  }

  void _save() {
    final updated = widget.classroom.copyWith(
      teacherIds: _assignedTeachers,
    );

    ClassroomRepository.instance.saveClassroom(updated);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Teachers assigned successfully',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final teachers =
        TeacherRepository.instance.activeTeachers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Teachers'),
      ),
      body: teachers.isEmpty
          ? const Center(
        child: Text('No teachers available'),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                final Teacher teacher =
                teachers[index];

                return CheckboxListTile(
                  title: Text(teacher.name),
                  subtitle: Text(
                    teacher.employeeCode,
                  ),
                  value: _assignedTeachers
                      .contains(teacher.id),
                  onChanged: (_) {
                    _toggleTeacher(
                      teacher.id,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text(
                  'Save Assignments',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
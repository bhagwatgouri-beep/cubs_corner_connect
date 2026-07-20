import 'package:flutter/material.dart';

import '../../../models/teacher.dart';
import '../../../repositories/teacher_repository.dart';

class AssignClassScreen extends StatefulWidget {
  final Teacher teacher;

  const AssignClassScreen({
    super.key,
    required this.teacher,
  });

  @override
  State<AssignClassScreen> createState() =>
      _AssignClassScreenState();
}

class _AssignClassScreenState
    extends State<AssignClassScreen> {
  late List<String> _assignedClasses;

  final List<String> _availableClasses = [
    'Playgroup',
    'Nursery',
    'Junior KG',
    'Senior KG',
    'Grade 1',
    'Grade 2',
    'Grade 3',
    'Grade 4',
    'Grade 5',
  ];

  @override
  void initState() {
    super.initState();
    _assignedClasses =
    List<String>.from(widget.teacher.classroomIds);
  }

  void _toggleClass(String className) {
    setState(() {
      if (_assignedClasses.contains(className)) {
        _assignedClasses.remove(className);
      } else {
        _assignedClasses.add(className);
      }
    });
  }

  void _save() {
    final updatedTeacher = widget.teacher.copyWith(
      classroomIds: _assignedClasses,
    );

    TeacherRepository.instance.saveTeacher(updatedTeacher);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Classes assigned successfully'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Classes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _availableClasses.length,
              itemBuilder: (context, index) {
                final className =
                _availableClasses[index];

                return CheckboxListTile(
                  title: Text(className),
                  value: _assignedClasses
                      .contains(className),
                  onChanged: (_) =>
                      _toggleClass(className),
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
                label: const Text('Save Assignments'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
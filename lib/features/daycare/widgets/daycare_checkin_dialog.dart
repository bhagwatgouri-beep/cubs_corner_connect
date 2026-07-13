import 'package:flutter/material.dart';

import '../../../models/student.dart';

class DaycareCheckInDialog extends StatelessWidget {
  final List<Student> students;

  const DaycareCheckInDialog({
    super.key,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Student'),
      content: SizedBox(
        width: 350,
        height: 400,
        child: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];

            return ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.child_care),
              ),
              title: Text(student.fullName),
              subtitle: Text(student.classroomId),
              onTap: () {
                Navigator.pop(context, student);
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
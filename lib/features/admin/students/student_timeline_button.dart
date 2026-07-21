import 'package:flutter/material.dart';

import '../../../models/student.dart';
import 'student_timeline_screen.dart';

class StudentTimelineButton extends StatelessWidget {
  final Student student;

  const StudentTimelineButton({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StudentTimelineScreen(
                student: student,
              ),
            ),
          );
        },
        icon: const Icon(Icons.timeline),
        label: const Text('Student Timeline'),
      ),
    );
  }
}
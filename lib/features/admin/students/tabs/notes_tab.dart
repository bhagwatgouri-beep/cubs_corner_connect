import 'package:flutter/material.dart';

import '../../../../models/student.dart';

class NotesTab extends StatelessWidget {
  final Student student;

  const NotesTab({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Notes Timeline',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'No notes available.',
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.note_add),
            label: const Text('Add Note'),
          ),
        ),
      ],
    );
  }
}
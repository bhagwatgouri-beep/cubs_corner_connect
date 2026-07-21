import 'package:flutter/material.dart';

import '../../../models/student.dart';

class StudentNotesScreen extends StatefulWidget {
  final Student student;

  const StudentNotesScreen({
    super.key,
    required this.student,
  });

  @override
  State<StudentNotesScreen> createState() =>
      _StudentNotesScreenState();
}

class _StudentNotesScreenState
    extends State<StudentNotesScreen> {
  final List<_StudentNote> _notes = [
    _StudentNote(
      date: '21 Jul 2026',
      note: 'Ate lunch well.',
    ),
    _StudentNote(
      date: '20 Jul 2026',
      note: 'Enjoyed outdoor play.',
    ),
    _StudentNote(
      date: '19 Jul 2026',
      note: 'Slept for 2 hours.',
    ),
  ];

  final TextEditingController _controller =
  TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _addNote() async {
    _controller.clear();

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Note'),
        content: TextField(
          controller: _controller,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Enter observation...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (saved != true) return;

    final text = _controller.text.trim();

    if (text.isEmpty) return;

    final now = DateTime.now();

    setState(() {
      _notes.insert(
        0,
        _StudentNote(
          date:
          '${now.day.toString().padLeft(2, '0')} '
              '${_month(now.month)} '
              '${now.year}',
          note: text,
        ),
      );
    });
  }

  String _month(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Notes'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNote,
        icon: const Icon(Icons.add),
        label: const Text('Add Note'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    child: Text(
                      widget.student.firstName.isEmpty
                          ? '?'
                          : widget.student.firstName[0]
                          .toUpperCase(),
                      style:
                      const TextStyle(fontSize: 28),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.student.fullName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(widget.student.admissionNumber),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ..._notes.map(
                (note) => Card(
              child: ListTile(
                leading: const Icon(Icons.note_alt),
                title: Text(note.date),
                subtitle: Text(note.note),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentNote {
  final String date;
  final String note;

  const _StudentNote({
    required this.date,
    required this.note,
  });
}
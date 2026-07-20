import 'package:flutter/material.dart';

import '../../../models/health_record.dart';
import '../../../repositories/health_repository.dart';

class EditHealthRecordScreen extends StatefulWidget {
  final HealthRecord record;

  const EditHealthRecordScreen({
    super.key,
    required this.record,
  });

  @override
  State<EditHealthRecordScreen> createState() =>
      _EditHealthRecordScreenState();
}

class _EditHealthRecordScreenState
    extends State<EditHealthRecordScreen> {
  late final TextEditingController _bloodGroup;
  late final TextEditingController _notes;

  @override
  void initState() {
    super.initState();

    _bloodGroup = TextEditingController(
      text: widget.record.bloodGroup,
    );

    _notes = TextEditingController(
      text: widget.record.emergencyNotes,
    );
  }

  @override
  void dispose() {
    _bloodGroup.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _save() {
    final updated = widget.record.copyWith(
      bloodGroup: _bloodGroup.text.trim(),
      emergencyNotes: _notes.text.trim(),
      updatedAt: DateTime.now(),
    );

    HealthRepository.instance.saveRecord(updated);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Health Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _bloodGroup,
              decoration: const InputDecoration(
                labelText: 'Blood Group',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notes,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Emergency Notes',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: const Text('Update Record'),
            ),
          ],
        ),
      ),
    );
  }
}
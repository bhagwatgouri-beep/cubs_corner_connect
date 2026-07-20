import 'package:flutter/material.dart';

import '../../../models/health_record.dart';
import '../../../models/student.dart';
import '../../../repositories/health_repository.dart';
import '../../../repositories/student_repository.dart';

class AddHealthRecordScreen extends StatefulWidget {
  const AddHealthRecordScreen({super.key});

  @override
  State<AddHealthRecordScreen> createState() =>
      _AddHealthRecordScreenState();
}

class _AddHealthRecordScreenState
    extends State<AddHealthRecordScreen> {
  Student? _student;

  final _bloodGroup = TextEditingController();
  final _allergies = TextEditingController();
  final _conditions = TextEditingController();
  final _medications = TextEditingController();
  final _height = TextEditingController();
  final _weight = TextEditingController();
  final _notes = TextEditingController();

  @override
  void dispose() {
    _bloodGroup.dispose();
    _allergies.dispose();
    _conditions.dispose();
    _medications.dispose();
    _height.dispose();
    _weight.dispose();
    _notes.dispose();
    super.dispose();
  }

  List<String> _split(String text) {
    return text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  void _save() {
    if (_student == null) return;

    final now = DateTime.now();

    final record = HealthRecord(
      id: now.microsecondsSinceEpoch.toString(),
      studentId: _student!.id,
      bloodGroup: _bloodGroup.text.trim(),
      allergies: _split(_allergies.text),
      medicalConditions: _split(_conditions.text),
      medications: _split(_medications.text),
      heightCm:
      double.tryParse(_height.text.trim()) ?? 0,
      weightKg:
      double.tryParse(_weight.text.trim()) ?? 0,
      emergencyNotes: _notes.text.trim(),
      createdAt: now,
      updatedAt: now,
    );

    HealthRepository.instance.saveRecord(record);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final students = StudentRepository.instance.activeStudents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Health Record'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<Student>(
            initialValue: _student,
            decoration: const InputDecoration(
              labelText: 'Student',
              border: OutlineInputBorder(),
            ),
            items: students
                .map(
                  (student) => DropdownMenuItem(
                value: student,
                child: Text(student.fullName),
              ),
            )
                .toList(),
            onChanged: (value) {
              setState(() {
                _student = value;
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _bloodGroup,
            decoration: const InputDecoration(
              labelText: 'Blood Group',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _allergies,
            decoration: const InputDecoration(
              labelText: 'Allergies (comma separated)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _conditions,
            decoration: const InputDecoration(
              labelText:
              'Medical Conditions (comma separated)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _medications,
            decoration: const InputDecoration(
              labelText:
              'Medications (comma separated)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _height,
            keyboardType:
            const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Height (cm)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _weight,
            keyboardType:
            const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Weight (kg)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _notes,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Emergency Notes',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: const Text('Save Health Record'),
          ),
        ],
      ),
    );
  }
}
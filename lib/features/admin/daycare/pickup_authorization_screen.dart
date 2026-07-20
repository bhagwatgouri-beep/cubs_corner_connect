import 'package:flutter/material.dart';

import '../../../models/daycare_record.dart';
import '../../../models/student.dart';
import '../../../repositories/daycare_repository.dart';
import '../../../repositories/student_repository.dart';

class PickupAuthorizationScreen extends StatefulWidget {
  const PickupAuthorizationScreen({super.key});

  @override
  State<PickupAuthorizationScreen> createState() =>
      _PickupAuthorizationScreenState();
}

class _PickupAuthorizationScreenState
    extends State<PickupAuthorizationScreen> {
  final DaycareRepository _daycareRepository =
      DaycareRepository.instance;

  final StudentRepository _studentRepository =
      StudentRepository.instance;

  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _relationController =
  TextEditingController();

  Student? _student(String id) {
    try {
      return _studentRepository.students.firstWhere(
            (student) => student.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  void _authorize(DaycareRecord record) {
    if (_nameController.text.trim().isEmpty ||
        _relationController.text.trim().isEmpty) {
      return;
    }

    final updated = record.copyWith(
      pickupPerson: _nameController.text.trim(),
      pickupRelation: _relationController.text.trim(),
      updatedAt: DateTime.now(),
    );

    _daycareRepository.saveRecord(updated);

    _nameController.clear();
    _relationController.clear();

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pickup authorized'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final records =
    _daycareRepository.activeChildren(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pickup Authorization'),
      ),
      body: records.isEmpty
          ? const Center(
        child: Text('No children awaiting pickup.'),
      )
          : ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          final student = _student(record.studentId);

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    student?.fullName ??
                        'Unknown Student',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Pickup Person',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _relationController,
                    decoration: const InputDecoration(
                      labelText: 'Relationship',
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => _authorize(record),
                    child: const Text(
                      'Authorize Pickup',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
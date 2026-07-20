import 'package:flutter/material.dart';

import '../../../models/daycare_record.dart';
import '../../../models/student.dart';
import '../../../repositories/daycare_repository.dart';
import '../../../repositories/student_repository.dart';

class DaycareReportsScreen extends StatefulWidget {
  const DaycareReportsScreen({super.key});

  @override
  State<DaycareReportsScreen> createState() =>
      _DaycareReportsScreenState();
}

class _DaycareReportsScreenState
    extends State<DaycareReportsScreen> {
  final DaycareRepository _daycareRepository =
      DaycareRepository.instance;

  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Student? _student(String id) {
    try {
      return StudentRepository.instance.students.firstWhere(
            (student) => student.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  String _time(DateTime? value) {
    if (value == null) return '-';

    return '${value.hour.toString().padLeft(2, '0')}:'
        '${value.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final records =
    _daycareRepository.recordsForDate(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daycare Reports'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                '${_selectedDate.day.toString().padLeft(2, '0')}/'
                    '${_selectedDate.month.toString().padLeft(2, '0')}/'
                    '${_selectedDate.year}',
              ),
            ),
          ),
          Expanded(
            child: records.isEmpty
                ? const Center(
              child: Text(
                'No daycare records found.',
              ),
            )
                : ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final DaycareRecord record = records[index];
                final student =
                _student(record.studentId);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(
                      student?.fullName ??
                          'Unknown Student',
                    ),
                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          student?.classroomId ?? '-',
                        ),
                        Text(
                          'In : ${_time(record.checkInTime)}',
                        ),
                        Text(
                          'Out : ${_time(record.checkOutTime)}',
                        ),
                        Text(
                          'Pickup : ${record.pickupPerson.isEmpty ? "-" : record.pickupPerson}',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
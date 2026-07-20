import 'package:flutter/material.dart';

import '../../../models/health_record.dart';
import '../../../models/student.dart';
import '../../../repositories/health_repository.dart';
import '../../../repositories/student_repository.dart';

class StudentHealthProfileScreen extends StatelessWidget {
  const StudentHealthProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final students = StudentRepository.instance.activeStudents;
    final repository = HealthRepository.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Health Profiles'),
      ),
      body: students.isEmpty
          ? const Center(
        child: Text('No students available'),
      )
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final Student student = students[index];
          final HealthRecord? record =
          repository.getRecord(student.id);

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  student.firstName[0].toUpperCase(),
                ),
              ),
              title: Text(student.fullName),
              subtitle: record == null
                  ? const Text('No health record')
                  : Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Blood Group: ${record.bloodGroup.isEmpty ? "-" : record.bloodGroup}',
                  ),
                  Text(
                    'Height: ${record.heightCm.toStringAsFixed(1)} cm',
                  ),
                  Text(
                    'Weight: ${record.weightKg.toStringAsFixed(1)} kg',
                  ),
                  Text(
                    'BMI: ${record.bmi.toStringAsFixed(1)}',
                  ),
                ],
              ),
              trailing: record == null
                  ? const Icon(
                Icons.warning,
                color: Colors.orange,
              )
                  : const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
          );
        },
      ),
    );
  }
}
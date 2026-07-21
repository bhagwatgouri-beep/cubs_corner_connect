import 'package:flutter/material.dart';

import '../../../../models/student.dart';

class HealthTab extends StatelessWidget {
  final Student student;

  const HealthTab({
    super.key,
    required this.student,
  });

  Widget _tile(
      String title,
      String value,
      IconData icon,
      ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _tile(
          'Blood Group',
          '-',
          Icons.bloodtype,
        ),
        _tile(
          'Allergies',
          '-',
          Icons.warning_amber,
        ),
        _tile(
          'Medical Conditions',
          '-',
          Icons.medical_services,
        ),
        _tile(
          'Vaccinations',
          '0',
          Icons.vaccines,
        ),
        _tile(
          'Incidents',
          '0',
          Icons.health_and_safety,
        ),
        _tile(
          'Current Medication',
          '-',
          Icons.medication,
        ),
        const SizedBox(height: 24),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Health records will appear here.',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
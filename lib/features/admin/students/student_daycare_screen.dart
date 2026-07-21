import 'package:flutter/material.dart';

import '../../../models/student.dart';

class StudentDaycareScreen extends StatelessWidget {
  final Student student;

  const StudentDaycareScreen({
    super.key,
    required this.student,
  });

  Widget _infoTile(
      String title,
      String value,
      IconData icon,
      ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daycare'),
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
                      student.firstName.isEmpty
                          ? '?'
                          : student.firstName[0].toUpperCase(),
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    student.fullName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(student.admissionNumber),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Card(
            color: Colors.green.shade50,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Checked In',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          _infoTile(
            'Check In Time',
            '09:15 AM',
            Icons.login,
          ),

          _infoTile(
            'Expected Pickup',
            '05:30 PM',
            Icons.schedule,
          ),

          _infoTile(
            'Authorized Pickup',
            'Mother',
            Icons.family_restroom,
          ),

          _infoTile(
            'Picked Up By',
            '-',
            Icons.person,
          ),

          _infoTile(
            'Pickup Status',
            'Waiting',
            Icons.hourglass_bottom,
          ),

          _infoTile(
            'Remarks',
            '-',
            Icons.notes,
          ),
        ],
      ),
    );
  }
}
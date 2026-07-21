import 'package:flutter/material.dart';

import '../../../models/student.dart';
class StudentDocumentsScreen extends StatelessWidget {
  final Student student;

  const StudentDocumentsScreen({
    super.key,
    required this.student,
  });

  Widget _documentTile(
      String title,
      bool uploaded,
      IconData icon,
      ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Chip(
          avatar: Icon(
            uploaded ? Icons.check : Icons.close,
            size: 16,
            color: Colors.white,
          ),
          backgroundColor:
          uploaded ? Colors.green : Colors.red,
          label: Text(
            uploaded ? 'Uploaded' : 'Missing',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Documents'),
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

          _documentTile(
            'Birth Certificate',
            false,
            Icons.description,
          ),

          _documentTile(
            'Aadhaar Card',
            false,
            Icons.badge,
          ),

          _documentTile(
            'Parent ID Proof',
            false,
            Icons.account_box,
          ),

          _documentTile(
            'Medical Certificate',
            false,
            Icons.medical_services,
          ),

          _documentTile(
            'Student Photograph',
            false,
            Icons.photo,
          ),
        ],
      ),
    );
  }
}
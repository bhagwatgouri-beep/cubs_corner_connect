import 'package:flutter/material.dart';

import '../../../../models/student.dart';

class DocumentsTab extends StatelessWidget {
  final Student student;

  const DocumentsTab({
    super.key,
    required this.student,
  });

  Widget _documentTile(
      String title,
      IconData icon,
      bool available,
      ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(
          available
              ? Icons.check_circle
              : Icons.upload_file,
          color:
          available ? Colors.green : Colors.orange,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _documentTile(
          'Birth Certificate',
          Icons.description,
          false,
        ),
        _documentTile(
          'Aadhaar Card',
          Icons.badge,
          false,
        ),
        _documentTile(
          'Passport',
          Icons.book,
          false,
        ),
        _documentTile(
          'Medical Certificate',
          Icons.medical_information,
          false,
        ),
        _documentTile(
          'Vaccination Record',
          Icons.vaccines,
          false,
        ),
        _documentTile(
          'Admission Form',
          Icons.assignment,
          false,
        ),
        _documentTile(
          'Parent Consent Form',
          Icons.fact_check,
          false,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload Document'),
          ),
        ),
      ],
    );
  }
}
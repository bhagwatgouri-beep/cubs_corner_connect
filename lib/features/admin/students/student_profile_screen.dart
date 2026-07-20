import 'package:flutter/material.dart';

import '../../../models/parent.dart';
import '../../../models/student.dart';
import '../../../repositories/parent_repository.dart';

class StudentProfileScreen extends StatelessWidget {
  final Student student;

  const StudentProfileScreen({
    super.key,
    required this.student,
  });

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String value,
  ) {
    final displayValue = value.trim().isEmpty ? '-' : value;

    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(displayValue),
    );
  }

  Parent? _parentForStudent() {
    if (student.parentIds.isEmpty) return null;

    return ParentRepository.instance.getParent(student.parentIds.first);
  }

  @override
  Widget build(BuildContext context) {
    final parent = _parentForStudent();
    final dob =
        '${student.dateOfBirth.day.toString().padLeft(2, '0')}/'
        '${student.dateOfBirth.month.toString().padLeft(2, '0')}/'
        '${student.dateOfBirth.year}';
    final admissionDate =
        '${student.createdAt.day.toString().padLeft(2, '0')}/'
        '${student.createdAt.month.toString().padLeft(2, '0')}/'
        '${student.createdAt.year}';

    return Scaffold(
      appBar: AppBar(
        title: Text(student.fullName),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Text(
                      student.firstName.isEmpty
                          ? '?'
                          : student.firstName[0].toUpperCase(),
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 16),
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

          _sectionTitle(context, 'Student Information'),
          Card(
            child: Column(
              children: [
                _infoTile(
                  Icons.badge,
                  'Admission Number',
                  student.admissionNumber,
                ),
                _infoTile(Icons.person, 'Full Name', student.fullName),
                _infoTile(Icons.person_outline, 'Gender', student.gender),
                _infoTile(Icons.cake, 'Date of Birth', dob),
                _infoTile(Icons.class_, 'Current Class', student.classroomId),
                _infoTile(
                  Icons.circle,
                  'Status',
                  student.isActive ? 'Active' : 'Inactive',
                ),
              ],
            ),
          ),

          _sectionTitle(context, 'Parent Information'),
          Card(
            child: Column(
              children: [
                _infoTile(Icons.person, 'Parent Name', parent?.fullName ?? ''),
                _infoTile(
                  Icons.family_restroom,
                  'Relationship',
                  parent?.relationship ?? '',
                ),
                _infoTile(Icons.phone, 'Mobile', parent?.mobileNumber ?? ''),
                _infoTile(Icons.email, 'Email', parent?.email ?? ''),
              ],
            ),
          ),

          _sectionTitle(context, 'Admission Information'),
          Card(
            child: Column(
              children: [
                _infoTile(Icons.event, 'Admission Date', admissionDate),
                _infoTile(
                  Icons.badge,
                  'Admission Number',
                  student.admissionNumber,
                ),
              ],
            ),
          ),

          _sectionTitle(context, 'Health'),
          Card(
            child: Column(
              children: [
                _infoTile(Icons.bloodtype, 'Blood Group', '-'),
                _infoTile(Icons.warning_amber, 'Allergies', student.allergies),
                _infoTile(
                  Icons.medical_information,
                  'Medical Notes',
                  student.medicalNotes,
                ),
              ],
            ),
          ),

          _sectionTitle(context, 'Emergency Contact'),
          Card(
            child: Column(
              children: [
                _infoTile(Icons.person, 'Name', '-'),
                _infoTile(Icons.phone, 'Phone', '-'),
              ],
            ),
          ),

          _sectionTitle(context, 'Actions'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit Student'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.calendar_month),
                          label: const Text('View Attendance'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.receipt_long),
                          label: const Text('Billing'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.folder_open),
                          label: const Text('Documents'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

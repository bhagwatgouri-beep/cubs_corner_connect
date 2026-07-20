import 'package:flutter/material.dart';

import '../../../models/parent.dart';
import '../../../models/student.dart';
import '../../../repositories/parent_repository.dart';
import '../../../repositories/student_repository.dart';
import 'edit_student_screen.dart';

class StudentProfileScreen extends StatefulWidget {
  final Student student;

  const StudentProfileScreen({
    super.key,
    required this.student,
  });

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  late Student _student;

  @override
  void initState() {
    super.initState();
    _student = widget.student;
  }

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
    if (_student.parentIds.isEmpty) return null;

    return ParentRepository.instance.getParent(_student.parentIds.first);
  }

  Future<void> _openEdit() async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => EditStudentScreen(
          student: _student,
          parent: _parentForStudent(),
        ),
      ),
    );

    if (saved == true && mounted) {
      final updatedStudent = StudentRepository.instance.getStudent(_student.id);

      if (updatedStudent != null) {
        setState(() {
          _student = updatedStudent;
        });
      }
    }
  }

  Future<void> _toggleActiveStatus() async {
    if (_student.isActive) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Archive Student'),
          content: const Text(
            'Are you sure you want to archive this student?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Archive'),
            ),
          ],
        ),
      );

      if (confirmed != true) return;
    }

    final updatedStudent = _student.copyWith(
      isActive: !_student.isActive,
      updatedAt: DateTime.now(),
    );

    StudentRepository.instance.updateStudent(updatedStudent);

    setState(() {
      _student = updatedStudent;
    });
  }

  @override
  Widget build(BuildContext context) {
    final parent = _parentForStudent();
    final dob =
        '${_student.dateOfBirth.day.toString().padLeft(2, '0')}/'
        '${_student.dateOfBirth.month.toString().padLeft(2, '0')}/'
        '${_student.dateOfBirth.year}';
    final admissionDate =
        '${_student.createdAt.day.toString().padLeft(2, '0')}/'
        '${_student.createdAt.month.toString().padLeft(2, '0')}/'
        '${_student.createdAt.year}';

    return Scaffold(
      appBar: AppBar(
        title: Text(_student.fullName),
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
                      _student.firstName.isEmpty
                          ? '?'
                          : _student.firstName[0].toUpperCase(),
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _student.fullName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(_student.admissionNumber),
                ],
              ),
            ),
          ),
          _sectionTitle(context, 'Student Information'),
          Card(
            child: Column(
              children: [
                _infoTile(Icons.badge, 'Admission Number', _student.admissionNumber),
                _infoTile(Icons.person, 'Full Name', _student.fullName),
                _infoTile(Icons.person_outline, 'Gender', _student.gender),
                _infoTile(Icons.cake, 'Date of Birth', dob),
                _infoTile(Icons.class_, 'Current Class', _student.classroomId),
                _infoTile(
                  Icons.circle,
                  'Status',
                  _student.isActive ? 'Active' : 'Inactive',
                ),
              ],
            ),
          ),
          _sectionTitle(context, 'Parent Information'),
          Card(
            child: Column(
              children: [
                _infoTile(Icons.person, 'Parent Name', parent?.fullName ?? ''),
                _infoTile(Icons.family_restroom, 'Relationship', parent?.relationship ?? ''),
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
                _infoTile(Icons.badge, 'Admission Number', _student.admissionNumber),
              ],
            ),
          ),
          _sectionTitle(context, 'Health'),
          Card(
            child: Column(
              children: [
                _infoTile(Icons.bloodtype, 'Blood Group', '-'),
                _infoTile(Icons.warning_amber, 'Allergies', _student.allergies),
                _infoTile(Icons.medical_information, 'Medical Notes', _student.medicalNotes),
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
                          onPressed: _openEdit,
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
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _toggleActiveStatus,
                      icon: Icon(
                        _student.isActive
                            ? Icons.archive
                            : Icons.check_circle,
                      ),
                      label: Text(
                        _student.isActive
                            ? 'Archive Student'
                            : 'Activate Student',
                      ),
                    ),
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

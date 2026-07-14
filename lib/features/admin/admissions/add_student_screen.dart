import 'package:flutter/material.dart';

import '../../../models/student.dart';
import '../../../repositories/student_repository.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _admissionController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _classController = TextEditingController();

  bool daycare = false;
  bool transport = false;

  @override
  void initState() {
    super.initState();

    final nextNumber =
        StudentRepository.instance.students.length + 1;

    _admissionController.text =
    "SEF26${nextNumber.toString().padLeft(4, '0')}";
  }

  @override
  void dispose() {
    _admissionController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _classController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final student = Student(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      admissionNumber: _admissionController.text,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      dateOfBirth: DateTime.now(),
      gender: '',
      classroomId: _classController.text.trim(),
      centreId: 'CENTRE01',
      parentIds: const [],
      profileImageUrl: '',
      isActive: true,
      isDaycareEnrolled: daycare,
      usesTransport: transport,
      pickupPersons: const [],
      medicalNotes: '',
      allergies: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    StudentRepository.instance.addStudent(student);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Admission'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _admissionController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Admission Number',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
                validator: (value) =>
                value == null || value.trim().isEmpty
                    ? 'Required'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                validator: (value) =>
                value == null || value.trim().isEmpty
                    ? 'Required'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _classController,
                decoration: const InputDecoration(
                  labelText: 'Classroom',
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Daycare Enrolled'),
                value: daycare,
                onChanged: (value) {
                  setState(() {
                    daycare = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Uses Transport'),
                value: transport,
                onChanged: (value) {
                  setState(() {
                    transport = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _save,
                child: const Text('SAVE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
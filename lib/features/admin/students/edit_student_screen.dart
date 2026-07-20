import 'package:flutter/material.dart';

import '../../../models/parent.dart';
import '../../../models/student.dart';
import '../../../repositories/parent_repository.dart';
import '../../../repositories/student_repository.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;
  final Parent? parent;

  const EditStudentScreen({
    super.key,
    required this.student,
    required this.parent,
  });

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _middleNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _classroomController;
  late final TextEditingController _parentNameController;
  late final TextEditingController _mobileController;
  late final TextEditingController _emailController;

  late DateTime _dateOfBirth;
  late String _gender;
  late String _relationship;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.student.firstName);
    _middleNameController = TextEditingController(text: widget.student.middleName);
    _lastNameController = TextEditingController(text: widget.student.lastName);
    _classroomController = TextEditingController(text: widget.student.classroomId);
    _parentNameController = TextEditingController(text: widget.parent?.fullName.trim() ?? '');
    _mobileController = TextEditingController(text: widget.parent?.mobileNumber ?? '');
    _emailController = TextEditingController(text: widget.parent?.email ?? '');
    _dateOfBirth = widget.student.dateOfBirth;
    _gender = widget.student.gender;
    _relationship = widget.parent?.relationship ?? '';
    _isActive = widget.student.isActive;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _classroomController.dispose();
    _parentNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  String? _validateMobile(String? value) {
    final mobile = value?.trim() ?? '';

    if (mobile.isEmpty) return 'Mobile Number is required';
    if (!RegExp(r'^\d{10}$').hasMatch(mobile)) {
      return 'Enter a valid 10-digit mobile number';
    }

    final matchingParent = ParentRepository.instance.getByMobile(mobile);

    if (matchingParent != null && matchingParent.id != widget.parent?.id) {
      return 'Mobile Number already belongs to another parent';
    }

    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final updatedStudent = widget.student.copyWith(
      firstName: _firstNameController.text.trim(),
      middleName: _middleNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      dateOfBirth: _dateOfBirth,
      gender: _gender,
      classroomId: _classroomController.text.trim(),
      isActive: _isActive,
      updatedAt: DateTime.now(),
    );

    StudentRepository.instance.updateStudent(updatedStudent);

    if (widget.parent != null) {
      final nameParts = _parentNameController.text.trim().split(RegExp(r'\s+'));
      final updatedParent = widget.parent!.copyWith(
        firstName: nameParts.first,
        lastName: nameParts.length > 1 ? nameParts.skip(1).join(' ') : '',
        mobileNumber: _mobileController.text.trim(),
        email: _emailController.text.trim(),
        relationship: _relationship,
        updatedAt: DateTime.now(),
      );

      ParentRepository.instance.updateParent(updatedParent);
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final dob = '${_dateOfBirth.day}/${_dateOfBirth.month}/${_dateOfBirth.year}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Student Information',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'First Name is required'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _middleNameController,
              decoration: const InputDecoration(
                labelText: 'Middle Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Last Name is required'
                  : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _gender.isEmpty ? null : _gender,
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              validator: (value) => value == null || value.isEmpty
                  ? 'Gender is required'
                  : null,
              onChanged: (value) {
                setState(() {
                  _gender = value ?? '';
                });
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(),
              ),
              title: const Text('Date of Birth'),
              subtitle: Text(dob),
              trailing: const Icon(Icons.calendar_month),
              onTap: _pickDate,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _classroomController,
              decoration: const InputDecoration(
                labelText: 'Classroom',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Classroom is required'
                  : null,
            ),
            SwitchListTile(
              value: _isActive,
              title: const Text('Active Student'),
              onChanged: (value) {
                setState(() {
                  _isActive = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Parent Information',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _parentNameController,
              decoration: const InputDecoration(
                labelText: 'Parent Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Parent Name is required'
                  : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _relationship.isEmpty ? null : _relationship,
              decoration: const InputDecoration(
                labelText: 'Relationship',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Mother', child: Text('Mother')),
                DropdownMenuItem(value: 'Father', child: Text('Father')),
                DropdownMenuItem(value: 'Grandparent', child: Text('Grandparent')),
                DropdownMenuItem(value: 'Guardian', child: Text('Guardian')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (value) {
                setState(() {
                  _relationship = value ?? '';
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
              validator: _validateMobile,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: const Text('SAVE'),
            ),
          ],
        ),
      ),
    );
  }
}

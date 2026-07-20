import 'package:flutter/material.dart';

import '../../../models/teacher.dart';
import '../../../repositories/teacher_repository.dart';
import '../../../shared/widgets/app_date_picker.dart';
import '../../../shared/widgets/app_dropdown.dart';
import '../../../shared/widgets/app_save_button.dart';
import '../../../shared/widgets/app_section_card.dart';
import '../../../shared/widgets/app_text_field.dart';

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({super.key});

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _addressController = TextEditingController();
  final _remarksController = TextEditingController();

  final _dobController = TextEditingController();
  final _joiningController = TextEditingController();

  String _role = 'Teacher';

  final List<String> _roles = [
    'Founder Director',
    'Principal',
    'Vice Principal',
    'Coordinator',
    'Teacher',
    'Assistant Teacher',
    'Daycare Teacher',
    'Counsellor',
    'Administrator',
    'Receptionist',
    'Office Assistant',
    'Support Staff',
  ];

  String _generateEmployeeCode() {
    final count = TeacherRepository.instance.totalTeachers() + 1;
    return 'SEF-T${count.toString().padLeft(3, '0')}';
  }

  void _saveTeacher() {
    if (!_formKey.currentState!.validate()) return;

    final teacher = Teacher(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      employeeCode: _generateEmployeeCode(),
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      role: _role,
      designation: _role,
      qualification: _qualificationController.text.trim(),
      dateOfBirth: null,
      joiningDate: null,
      address: _addressController.text.trim(),
      remarks: _remarksController.text.trim(),
      photoUrl: '',
      centreId: '',
      classroomIds: const [],
      isActive: true,
    );

    TeacherRepository.instance.saveTeacher(teacher);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Staff member added successfully'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _qualificationController.dispose();
    _addressController.dispose();
    _remarksController.dispose();
    _dobController.dispose();
    _joiningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Staff'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppSectionCard(
              title: 'Personal Information',
              child: Column(
                children: [
                  AppTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter full name';
                      }
                      return null;
                    },
                  ),
                  AppTextField(
                    controller: _phoneController,
                    label: 'Mobile Number',
                    keyboardType: TextInputType.phone,
                  ),
                  AppTextField(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  AppDatePicker(
                    controller: _dobController,
                    label: 'Date of Birth',
                  ),
                  AppTextField(
                    controller: _addressController,
                    label: 'Address',
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            AppSectionCard(
              title: 'Professional Information',
              child: Column(
                children: [
                  AppDropdown<String>(
                    label: 'Role',
                    value: _role,
                    items: _roles
                        .map(
                          (role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _role = value;
                        });
                      }
                    },
                  ),
                  AppTextField(
                    controller: _qualificationController,
                    label: 'Qualification',
                  ),
                  AppDatePicker(
                    controller: _joiningController,
                    label: 'Joining Date',
                  ),
                ],
              ),
            ),
            AppSectionCard(
              title: 'Additional Information',
              child: AppTextField(
                controller: _remarksController,
                label: 'Remarks',
                maxLines: 3,
              ),
            ),
            AppSaveButton(
              text: 'Save Staff Member',
              onPressed: _saveTeacher,
            ),
          ],
        ),
      ),
    );
  }
}
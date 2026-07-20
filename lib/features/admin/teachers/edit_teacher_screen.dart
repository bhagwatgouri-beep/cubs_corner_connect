import 'package:flutter/material.dart';

import '../../../models/teacher.dart';
import '../../../repositories/teacher_repository.dart';
import '../../../shared/widgets/app_dropdown.dart';
import '../../../shared/widgets/app_save_button.dart';
import '../../../shared/widgets/app_section_card.dart';
import '../../../shared/widgets/app_text_field.dart';

class EditTeacherScreen extends StatefulWidget {
  final Teacher teacher;

  const EditTeacherScreen({
    super.key,
    required this.teacher,
  });

  @override
  State<EditTeacherScreen> createState() =>
      _EditTeacherScreenState();
}

class _EditTeacherScreenState
    extends State<EditTeacherScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _qualificationController;
  late final TextEditingController _addressController;
  late final TextEditingController _remarksController;

  late String _role;

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

  @override
  void initState() {
    super.initState();

    _nameController =
        TextEditingController(text: widget.teacher.name);

    _phoneController =
        TextEditingController(text: widget.teacher.phoneNumber);

    _emailController =
        TextEditingController(text: widget.teacher.email);

    _qualificationController =
        TextEditingController(text: widget.teacher.qualification);

    _addressController =
        TextEditingController(text: widget.teacher.address);

    _remarksController =
        TextEditingController(text: widget.teacher.remarks);

    _role = widget.teacher.role;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _qualificationController.dispose();
    _addressController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final updated = widget.teacher.copyWith(
      name: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      qualification: _qualificationController.text.trim(),
      address: _addressController.text.trim(),
      remarks: _remarksController.text.trim(),
      role: _role,
      designation: _role,
    );

    TeacherRepository.instance.saveTeacher(updated);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Staff'),
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
                  ),
                  AppTextField(
                    controller: _phoneController,
                    label: 'Mobile Number',
                    keyboardType: TextInputType.phone,
                  ),
                  AppTextField(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType:
                    TextInputType.emailAddress,
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
                    controller:
                    _qualificationController,
                    label: 'Qualification',
                  ),
                ],
              ),
            ),
            AppSectionCard(
              title: 'Remarks',
              child: AppTextField(
                controller: _remarksController,
                label: 'Remarks',
                maxLines: 3,
              ),
            ),
            AppSaveButton(
              text: 'Update Staff',
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
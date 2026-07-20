import 'package:flutter/material.dart';

import '../../../models/classroom.dart';
import '../../../repositories/classroom_repository.dart';
import '../../../shared/widgets/app_dropdown.dart';
import '../../../shared/widgets/app_save_button.dart';
import '../../../shared/widgets/app_section_card.dart';
import '../../../shared/widgets/app_text_field.dart';

class AddClassroomScreen extends StatefulWidget {
  const AddClassroomScreen({super.key});

  @override
  State<AddClassroomScreen> createState() =>
      _AddClassroomScreenState();
}

class _AddClassroomScreenState
    extends State<AddClassroomScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _capacityController = TextEditingController();
  final _roomController = TextEditingController();
  final _remarksController = TextEditingController();

  String _ageGroup = 'Playgroup';
  String _section = 'A';

  final _ageGroups = [
    'Playgroup',
    'Nursery',
    'Junior KG',
    'Senior KG',
    'Grade 1',
    'Grade 2',
    'Grade 3',
    'Grade 4',
    'Grade 5',
  ];

  final _sections = [
    'A',
    'B',
    'C',
    'D',
  ];

  String _generateCode() {
    final count =
        ClassroomRepository.instance.totalClassrooms() + 1;

    return 'CLS-${count.toString().padLeft(3, '0')}';
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final classroom = Classroom(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(),
      code: _generateCode(),
      name: _nameController.text.trim(),
      ageGroup: _ageGroup,
      section: _section,
      centreId: '',
      teacherIds: const [],
      capacity:
      int.tryParse(_capacityController.text) ?? 0,
      roomNumber: _roomController.text.trim(),
      remarks: _remarksController.text.trim(),
      currentStrength: 0,
      isActive: true,
    );

    ClassroomRepository.instance.saveClassroom(classroom);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Classroom added successfully'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _capacityController.dispose();
    _roomController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Classroom'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppSectionCard(
              title: 'Classroom Information',
              child: Column(
                children: [
                  AppTextField(
                    controller: _nameController,
                    label: 'Classroom Name',
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Enter classroom name';
                      }
                      return null;
                    },
                  ),
                  AppDropdown<String>(
                    label: 'Age Group',
                    value: _ageGroup,
                    items: _ageGroups
                        .map(
                          (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _ageGroup = value;
                        });
                      }
                    },
                  ),
                  AppDropdown<String>(
                    label: 'Section',
                    value: _section,
                    items: _sections
                        .map(
                          (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _section = value;
                        });
                      }
                    },
                  ),
                  AppTextField(
                    controller: _capacityController,
                    label: 'Capacity',
                    keyboardType: TextInputType.number,
                  ),
                  AppTextField(
                    controller: _roomController,
                    label: 'Room Number',
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
              text: 'Save Classroom',
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../models/classroom.dart';
import '../../../repositories/classroom_repository.dart';
import '../../../shared/widgets/app_dropdown.dart';
import '../../../shared/widgets/app_save_button.dart';
import '../../../shared/widgets/app_section_card.dart';
import '../../../shared/widgets/app_text_field.dart';

class EditClassroomScreen extends StatefulWidget {
  final Classroom classroom;

  const EditClassroomScreen({
    super.key,
    required this.classroom,
  });

  @override
  State<EditClassroomScreen> createState() =>
      _EditClassroomScreenState();
}

class _EditClassroomScreenState
    extends State<EditClassroomScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _capacityController;
  late final TextEditingController _roomController;
  late final TextEditingController _remarksController;

  late String _ageGroup;
  late String _section;

  final List<String> _ageGroups = [
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

  final List<String> _sections = [
    'A',
    'B',
    'C',
    'D',
  ];

  @override
  void initState() {
    super.initState();

    _nameController =
        TextEditingController(text: widget.classroom.name);

    _capacityController = TextEditingController(
      text: widget.classroom.capacity.toString(),
    );

    _roomController =
        TextEditingController(text: widget.classroom.roomNumber);

    _remarksController =
        TextEditingController(text: widget.classroom.remarks);

    _ageGroup = widget.classroom.ageGroup;
    _section = widget.classroom.section;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _capacityController.dispose();
    _roomController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final updated = widget.classroom.copyWith(
      name: _nameController.text.trim(),
      ageGroup: _ageGroup,
      section: _section,
      capacity:
      int.tryParse(_capacityController.text.trim()) ??
          widget.classroom.capacity,
      roomNumber: _roomController.text.trim(),
      remarks: _remarksController.text.trim(),
    );

    ClassroomRepository.instance.saveClassroom(updated);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Classroom'),
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
              text: 'Update Classroom',
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../models/announcement.dart';
import '../../../repositories/communication_repository.dart';
import '../../../shared/widgets/app_dropdown.dart';
import '../../../shared/widgets/app_save_button.dart';
import '../../../shared/widgets/app_section_card.dart';
import '../../../shared/widgets/app_text_field.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  State<CreateAnnouncementScreen> createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState
    extends State<CreateAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  String _audience = 'All';

  final List<String> _audiences = [
    'All',
    'Parents',
    'Teachers',
    'Students',
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

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final announcement = Announcement(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(),
      title: _titleController.text.trim(),
      message: _messageController.text.trim(),
      audience: _audience,
      createdAt: DateTime.now(),
      createdBy: 'Admin',
      isPublished: true,
    );

    CommunicationRepository.instance
        .saveAnnouncement(announcement);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Announcement created successfully',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Announcement'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppSectionCard(
              title: 'Announcement Details',
              child: Column(
                children: [
                  AppTextField(
                    controller: _titleController,
                    label: 'Title',
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Enter title';
                      }
                      return null;
                    },
                  ),
                  AppDropdown<String>(
                    label: 'Audience',
                    value: _audience,
                    items: _audiences
                        .map(
                          (audience) =>
                          DropdownMenuItem(
                            value: audience,
                            child: Text(audience),
                          ),
                    )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _audience = value;
                        });
                      }
                    },
                  ),
                  AppTextField(
                    controller: _messageController,
                    label: 'Message',
                    maxLines: 6,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Enter message';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            AppSaveButton(
              text: 'Publish Announcement',
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
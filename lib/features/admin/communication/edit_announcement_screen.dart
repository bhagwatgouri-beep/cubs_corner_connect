import 'package:flutter/material.dart';

import '../../../models/announcement.dart';
import '../../../repositories/communication_repository.dart';
import '../../../shared/widgets/app_dropdown.dart';
import '../../../shared/widgets/app_save_button.dart';
import '../../../shared/widgets/app_section_card.dart';
import '../../../shared/widgets/app_text_field.dart';

class EditAnnouncementScreen extends StatefulWidget {
  final Announcement announcement;

  const EditAnnouncementScreen({
    super.key,
    required this.announcement,
  });

  @override
  State<EditAnnouncementScreen> createState() =>
      _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState
    extends State<EditAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _messageController;

  late String _audience;

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
  void initState() {
    super.initState();

    _titleController =
        TextEditingController(text: widget.announcement.title);

    _messageController =
        TextEditingController(text: widget.announcement.message);

    _audience = widget.announcement.audience;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final updated = widget.announcement.copyWith(
      title: _titleController.text.trim(),
      message: _messageController.text.trim(),
      audience: _audience,
    );

    CommunicationRepository.instance
        .saveAnnouncement(updated);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Announcement'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppSectionCard(
              title: 'Announcement',
              child: Column(
                children: [
                  AppTextField(
                    controller: _titleController,
                    label: 'Title',
                  ),
                  AppDropdown<String>(
                    label: 'Audience',
                    value: _audience,
                    items: _audiences
                        .map(
                          (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
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
                  ),
                ],
              ),
            ),
            AppSaveButton(
              text: 'Update Announcement',
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
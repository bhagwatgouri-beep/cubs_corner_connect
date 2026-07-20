import 'package:flutter/material.dart';

import '../../../models/announcement.dart';
import 'edit_announcement_screen.dart';

class AnnouncementDetailsScreen extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementDetailsScreen({
    super.key,
    required this.announcement,
  });

  Widget _infoTile(String title, String value) {
    return ListTile(
      dense: true,
      title: Text(title),
      subtitle: Text(
        value.isEmpty ? '-' : value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcement Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.campaign,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    announcement.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(announcement.audience),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                _infoTile(
                  'Audience',
                  announcement.audience,
                ),
                _infoTile(
                  'Created By',
                  announcement.createdBy,
                ),
                _infoTile(
                  'Date',
                  '${announcement.createdAt.day}/${announcement.createdAt.month}/${announcement.createdAt.year}',
                ),
                _infoTile(
                  'Status',
                  announcement.isPublished
                      ? 'Published'
                      : 'Draft',
                ),
                ListTile(
                  title: const Text('Message'),
                  subtitle: Text(
                    announcement.message,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text('Edit Announcement'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditAnnouncementScreen(
                    announcement: announcement,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
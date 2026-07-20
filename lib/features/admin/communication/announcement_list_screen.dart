import 'package:flutter/material.dart';

import '../../../models/announcement.dart';
import '../../../repositories/communication_repository.dart';
import 'announcement_details_screen.dart';

class AnnouncementListScreen extends StatelessWidget {
  const AnnouncementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final announcements =
        CommunicationRepository.instance.announcements;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
      ),
      body: announcements.isEmpty
          ? const Center(
        child: Text(
          'No announcements available.',
        ),
      )
          : ListView.builder(
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          final Announcement announcement =
          announcements[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.campaign),
              ),
              title: Text(announcement.title),
              subtitle: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement.audience,
                  ),
                  Text(
                    '${announcement.createdAt.day}/${announcement.createdAt.month}/${announcement.createdAt.year}',
                  ),
                ],
              ),
              trailing: Icon(
                announcement.isPublished
                    ? Icons.check_circle
                    : Icons.edit,
                color: announcement.isPublished
                    ? Colors.green
                    : Colors.orange,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        AnnouncementDetailsScreen(
                          announcement:
                          announcement,
                        ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
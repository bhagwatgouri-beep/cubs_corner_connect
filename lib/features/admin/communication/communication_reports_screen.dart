import 'package:flutter/material.dart';

import '../../../repositories/communication_repository.dart';

class CommunicationReportsScreen extends StatelessWidget {
  const CommunicationReportsScreen({super.key});

  Widget _reportTile({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text(
          value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repository = CommunicationRepository.instance;

    final total = repository.totalAnnouncements();
    final published = repository.totalPublished();
    final drafts = repository.totalDrafts();

    final audiences = <String, int>{};

    for (final announcement in repository.announcements) {
      audiences.update(
        announcement.audience,
            (count) => count + 1,
        ifAbsent: () => 1,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Communication Reports'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _reportTile(
            context: context,
            title: 'Total Announcements',
            value: total.toString(),
            icon: Icons.campaign,
          ),
          _reportTile(
            context: context,
            title: 'Published',
            value: published.toString(),
            icon: Icons.check_circle,
          ),
          _reportTile(
            context: context,
            title: 'Drafts',
            value: drafts.toString(),
            icon: Icons.edit_note,
          ),
          const SizedBox(height: 24),
          Text(
            'Audience Summary',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (audiences.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No announcements available.'),
              ),
            )
          else
            ...audiences.entries.map(
                  (entry) => Card(
                child: ListTile(
                  leading: const Icon(Icons.groups),
                  title: Text(entry.key),
                  trailing: Text(
                    entry.value.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../repositories/communication_repository.dart';
import 'announcement_list_screen.dart';
import 'communication_reports_screen.dart';
import 'create_announcement_screen.dart';

class CommunicationDashboardScreen extends StatelessWidget {
  const CommunicationDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = CommunicationRepository.instance;

    final total = repository.totalAnnouncements();
    final published = repository.totalPublished();
    final drafts = repository.totalDrafts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Communication Centre'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Overview',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Announcements',
                  value: total.toString(),
                  icon: Icons.campaign,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  title: 'Published',
                  value: published.toString(),
                  icon: Icons.check_circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Drafts',
                  value: drafts.toString(),
                  icon: Icons.edit_note,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _MenuCard(
            title: 'Create Announcement',
            icon: Icons.add_comment,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const CreateAnnouncementScreen(),
                ),
              );
            },
          ),
          _MenuCard(
            title: 'Announcement List',
            icon: Icons.list_alt,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const AnnouncementListScreen(),
                ),
              );
            },
          ),
          _MenuCard(
            title: 'Reports',
            icon: Icons.assessment,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const CommunicationReportsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 34),
            const SizedBox(height: 12),
            Text(
              value,
              style:
              Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing:
        const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
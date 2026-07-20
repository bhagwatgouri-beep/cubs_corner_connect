import 'package:flutter/material.dart';

class DaycareDashboardScreen extends StatelessWidget {
  const DaycareDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daycare Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            DateTime.now().day.toString().padLeft(2, '0') +
                '/' +
                DateTime.now().month.toString().padLeft(2, '0') +
                '/' +
                DateTime.now().year.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: const [
              _SummaryCard(
                title: 'Checked In',
                value: '0',
                icon: Icons.login,
              ),
              _SummaryCard(
                title: 'Checked Out',
                value: '0',
                icon: Icons.logout,
              ),
              _SummaryCard(
                title: 'Currently Inside',
                value: '0',
                icon: Icons.child_care,
              ),
              _SummaryCard(
                title: 'Pending Pickup',
                value: '0',
                icon: Icons.family_restroom,
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: null,
            icon: Icon(Icons.login),
            label: Text('Check In'),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: null,
            icon: Icon(Icons.logout),
            label: Text('Check Out'),
          ),
          const SizedBox(height: 24),
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          const _QuickActionCard(
            title: 'Live Daycare Board',
            icon: Icons.monitor,
          ),
          const SizedBox(height: 12),
          const _QuickActionCard(
            title: 'Pickup Authorization',
            icon: Icons.verified_user,
          ),
          const SizedBox(height: 12),
          const _QuickActionCard(
            title: 'Daycare Reports',
            icon: Icons.assessment,
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
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _QuickActionCard({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.lock_outline),
        enabled: false,
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../repositories/daycare_repository.dart';
import 'check_in_screen.dart';
import 'check_out_screen.dart';

class DaycareDashboardScreen extends StatelessWidget {
  const DaycareDashboardScreen({super.key});

  static final DaycareRepository _repository =
      DaycareRepository.instance;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    final records = _repository.recordsForDate(today);

    final checkedIn =
        records.where((r) => r.isCheckedIn).length;

    final checkedOut =
        records.where((r) => r.isCheckedOut).length;

    final currentlyInside =
        _repository.activeChildren(today).length;

    final pendingPickup =
        records.where(
              (r) => r.isCheckedIn && !r.isCheckedOut,
        ).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daycare Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${today.day.toString().padLeft(2, '0')}/'
                '${today.month.toString().padLeft(2, '0')}/'
                '${today.year}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 24),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: [
              _SummaryCard(
                title: 'Checked In',
                value: checkedIn.toString(),
                icon: Icons.login,
              ),
              _SummaryCard(
                title: 'Checked Out',
                value: checkedOut.toString(),
                icon: Icons.logout,
              ),
              _SummaryCard(
                title: 'Currently Inside',
                value: currentlyInside.toString(),
                icon: Icons.child_care,
              ),
              _SummaryCard(
                title: 'Pending Pickup',
                value: pendingPickup.toString(),
                icon: Icons.family_restroom,
              ),
            ],
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const CheckInScreen(),
                ),
              );
            },
            icon: const Icon(Icons.login),
            label: const Text('Check In'),
          ),

          const SizedBox(height: 12),

          FilledButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const CheckOutScreen(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Check Out'),
          ),

          const SizedBox(height: 24),

          Text(
            'Quick Actions',
            style: Theme.of(context)
                .textTheme
                .titleMedium,
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
    super.key,
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
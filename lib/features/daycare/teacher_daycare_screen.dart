import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'repositories/daycare_child_repository.dart';
import 'repositories/daycare_session_repository.dart';
import 'widgets/daycare_checkin_dialog.dart';

class TeacherDaycareScreen extends StatefulWidget {
  const TeacherDaycareScreen({super.key});

  @override
  State<TeacherDaycareScreen> createState() =>
      _TeacherDaycareScreenState();
}

class _TeacherDaycareScreenState extends State<TeacherDaycareScreen> {
  final sessionRepository = DaycareSessionRepository.instance;
  final childRepository = DaycareChildRepository.instance;

  Future<void> _checkIn() async {
    final child = await showDialog(
      context: context,
      builder: (_) => DaycareCheckInDialog(
        children: childRepository.enrolledChildren,
      ),
    );

    if (child == null) return;

    if (sessionRepository.getActiveSession(child.id) != null) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${child.name} is already checked in'),
        ),
      );
      return;
    }

    sessionRepository.checkIn(
      childId: child.id,
      childName: child.name,
    );

    setState(() {});
  }

  void _checkOut(String childId) {
    sessionRepository.checkOut(childId);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Child checked out successfully'),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final active = sessionRepository.activeSessions;
    final total = childRepository.enrolledCount;
    final checkedIn = active.length;
    final expected = total - checkedIn;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daycare Dashboard'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _checkIn,
        icon: const Icon(Icons.add),
        label: const Text('Check In Child'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [

                Expanded(
                  child: _DashboardCard(
                    title: 'Enrolled',
                    value: total.toString(),
                    color: Colors.blue,
                    icon: Icons.groups,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _DashboardCard(
                    title: 'Present',
                    value: checkedIn.toString(),
                    color: Colors.green,
                    icon: Icons.check_circle,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _DashboardCard(
                    title: 'Expected',
                    value: expected.toString(),
                    color: Colors.orange,
                    icon: Icons.schedule,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Children Currently in Daycare',
                style: AppTextStyles.textTheme.titleLarge,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: active.isEmpty
                  ? const Center(
                child: Text(
                  'No children are currently checked in.',
                ),
              )
                  : ListView.builder(
                itemCount: active.length,
                itemBuilder: (context, index) {
                  final session = active[index];

                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor:
                        AppColors.swayyamGreen,
                        child: Icon(
                          Icons.child_care,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(session.childName),
                      subtitle: Text(
                        'Checked In: '
                            '${session.checkInTime.hour.toString().padLeft(2, '0')}:'
                            '${session.checkInTime.minute.toString().padLeft(2, '0')}',
                      ),
                      trailing: FilledButton(
                        onPressed: () =>
                            _checkOut(session.childId),
                        child: const Text('Check Out'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 12,
        ),
        child: Column(
          children: [

            Icon(
              icon,
              color: color,
              size: 32,
            ),

            const SizedBox(height: 8),

            Text(
              value,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

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
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

class _TeacherDaycareScreenState
    extends State<TeacherDaycareScreen> {
  final DaycareSessionRepository sessionRepository =
      DaycareSessionRepository.instance;

  final DaycareChildRepository childRepository =
      DaycareChildRepository.instance;

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
          content: Text('${child.name} is already checked in.'),
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
        content: Text('Child checked out successfully.'),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final sessions = sessionRepository.activeSessions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daycare'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _checkIn,
        icon: const Icon(Icons.add),
        label: const Text('Check In'),
      ),
      body: sessions.isEmpty
          ? const Center(
        child: Text(
          'No children currently in daycare',
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];

          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.swayyamGreen,
                child: Icon(
                  Icons.child_care,
                  color: Colors.white,
                ),
              ),
              title: Text(
                session.childName,
                style:
                AppTextStyles.textTheme.titleMedium,
              ),
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
    );
  }
}
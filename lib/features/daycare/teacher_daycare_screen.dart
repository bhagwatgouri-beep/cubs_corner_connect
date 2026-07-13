import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'repositories/daycare_session_repository.dart';

class TeacherDaycareScreen extends StatefulWidget {
  const TeacherDaycareScreen({super.key});

  @override
  State<TeacherDaycareScreen> createState() =>
      _TeacherDaycareScreenState();
}

class _TeacherDaycareScreenState
    extends State<TeacherDaycareScreen> {
  final repository = DaycareSessionRepository.instance;

  @override
  Widget build(BuildContext context) {
    final sessions = repository.activeSessions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daycare'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Sprint 11.7
        },
        icon: const Icon(Icons.add),
        label: const Text('Check In'),
      ),
      body: sessions.isEmpty
          ? const Center(
        child: Text('No children currently in daycare'),
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
                onPressed: () {
                  repository.checkOut(session.childId);

                  setState(() {});
                },
                child: const Text('Check Out'),
              ),
            ),
          );
        },
      ),
    );
  }
}
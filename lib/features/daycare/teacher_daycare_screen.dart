import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import '../../repositories/student_repository.dart';
import 'repositories/daycare_session_repository.dart';
import 'widgets/daycare_checkin_dialog.dart';

class TeacherDaycareScreen extends StatefulWidget {
  const TeacherDaycareScreen({super.key});

  @override
  State<TeacherDaycareScreen> createState() =>
      _TeacherDaycareScreenState();
}

class _TeacherDaycareScreenState extends State<TeacherDaycareScreen> {
  final DaycareSessionRepository sessionRepository =
      DaycareSessionRepository.instance;

  final StudentRepository studentRepository =
      StudentRepository.instance;

  Future<void> _checkIn() async {
    final student = await showDialog(
      context: context,
      builder: (_) => DaycareCheckInDialog(
        students: studentRepository.daycareStudents,
      ),
    );

    if (student == null) return;

    if (sessionRepository.getActiveSession(student.id) != null) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${student.fullName} is already checked in.',
          ),
        ),
      );
      return;
    }

    sessionRepository.checkIn(
      childId: student.id,
      childName: student.fullName,
    );

    setState(() {});
  }

  void _checkOut(String childId) {
    sessionRepository.checkOut(childId);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Student checked out successfully.',
        ),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final activeSessions = sessionRepository.activeSessions;

    final totalStudents =
        studentRepository.daycareStudents.length;

    final checkedInStudents = activeSessions.length;

    final expectedStudents =
        totalStudents - checkedInStudents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daycare Dashboard'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _checkIn,
        icon: const Icon(Icons.add),
        label: const Text('Check In Student'),
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
                    value: totalStudents.toString(),
                    icon: Icons.groups,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DashboardCard(
                    title: 'Present',
                    value: checkedInStudents.toString(),
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DashboardCard(
                    title: 'Expected',
                    value: expectedStudents.toString(),
                    icon: Icons.schedule,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Students Currently in Daycare',
                style: AppTextStyles.textTheme.titleLarge,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: activeSessions.isEmpty
                  ? const Center(
                child: Text(
                  'No students are currently checked in.',
                ),
              )
                  : ListView.builder(
                itemCount: activeSessions.length,
                itemBuilder: (context, index) {
                  final session =
                  activeSessions[index];

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
                      title: Text(
                        session.childName,
                      ),
                      subtitle: Text(
                        'Checked In: '
                            '${session.checkInTime.hour.toString().padLeft(2, '0')}:'
                            '${session.checkInTime.minute.toString().padLeft(2, '0')}',
                      ),
                      trailing: FilledButton(
                        onPressed: () =>
                            _checkOut(
                              session.childId,
                            ),
                        child: const Text(
                          'Check Out',
                        ),
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
import 'package:flutter/material.dart';
import '../../models/attendance_record.dart';
import '../../repositories/attendance_repository.dart';
import '../../repositories/daycare_repository.dart';
import '../../repositories/student_repository.dart';

import '../admin/attendance/attendance_dashboard_screen.dart';
import '../admin/communication/communication_dashboard_screen.dart';
import '../admin/daycare/daycare_dashboard_screen.dart';

import 'my_class_screen.dart';

class TeacherHomeScreen extends StatelessWidget {
const TeacherHomeScreen({super.key});

@override
Widget build(BuildContext context) {
final studentRepository =
StudentRepository.instance;

final attendanceRepository =
AttendanceRepository.instance;

final daycareRepository =
DaycareRepository.instance;

final totalStudents =
studentRepository.activeStudents.length;

final presentToday = attendanceRepository
.todayAttendance()
.where(
(record) =>
record.status ==
AttendanceStatus.present ||
record.status ==
AttendanceStatus.late,
)
.length;

final daycareToday = daycareRepository
.activeChildren(DateTime.now())
.length;

return Scaffold(
appBar: AppBar(
title: const Text(
'Teacher Home',
),
centerTitle: true,
),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
Card(
child: Padding(
padding:
const EdgeInsets.all(20),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Text(
'Good Morning!',
style: Theme.of(context)
.textTheme
.headlineSmall,
),
const SizedBox(height: 8),
Text(
'Have a wonderful day.',
style: Theme.of(context)
.textTheme
.bodyLarge,
),
const SizedBox(height: 20),
Row(
children: [
Expanded(
child: _StatCard(
title: 'My Class',
value:
totalStudents.toString(),
icon:
Icons.groups,
),
),
const SizedBox(width: 12),
Expanded(
child: _StatCard(
title: 'Present',
value:
presentToday.toString(),
icon:
Icons.fact_check,
),
),
const SizedBox(width: 12),
Expanded(
child: _StatCard(
title: 'Daycare',
value:
daycareToday.toString(),
icon: Icons
.child_care,
),
),
],
),
],
),
),
),

const SizedBox(height: 24),

const Text(
"Today's Work",
style: TextStyle(
fontSize: 22,
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 16),
  _ActionCard(
    title: 'Attendance',
    subtitle: 'Mark and edit student attendance',
    icon: Icons.fact_check,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const AttendanceDashboardScreen(),
        ),
      );
    },
  ),

  _ActionCard(
    title: 'My Class',
    subtitle: 'View students in your classroom',
    icon: Icons.groups,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const MyClassScreen(),
        ),
      );
    },
  ),

  _ActionCard(
    title: 'Daycare',
    subtitle:
    'Manage check-in and check-out',
    icon: Icons.child_care,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const DaycareDashboardScreen(),
        ),
      );
    },
  ),

  _ActionCard(
    title: 'Communication',
    subtitle: 'View announcements',
    icon: Icons.campaign,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const CommunicationDashboardScreen(),
        ),
      );
    },
  ),

  const SizedBox(height: 24),

  Card(
    child: ListTile(
      leading: const Icon(
        Icons.lightbulb,
        color: Colors.orange,
      ),
      title: const Text(
        "Today's Reminder",
      ),
      subtitle: const Text(
        'Complete attendance before 10:00 AM.',
      ),
    ),
  ),

  const SizedBox(height: 24),

  FilledButton.icon(
    onPressed: () {},
    icon: const Icon(
      Icons.logout,
    ),
    label: const Text(
      'Logout',
    ),
  ),
],
),
);
}
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }
}
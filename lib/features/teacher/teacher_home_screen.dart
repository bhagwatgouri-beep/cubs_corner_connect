import 'package:flutter/material.dart';
import '../admin/communication/communication_dashboard_screen.dart';
import '../admin/attendance/attendance_dashboard_screen.dart';
import '../admin/daycare/daycare_dashboard_screen.dart';
import '../admin/students/student_directory_screen.dart';

class TeacherHomeScreen extends StatelessWidget {
const TeacherHomeScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Teacher Home'),
centerTitle: true,
),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
Card(
child: Padding(
padding: const EdgeInsets.all(20),
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
'Welcome back.',
style: Theme.of(context)
.textTheme
.bodyLarge,
),
],
),
),
),

const SizedBox(height: 20),

const Text(
"Today's Work",
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
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
title: 'Students',
subtitle: 'View student directory',
icon: Icons.people,
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
const StudentDirectoryScreen(),
),
);
},
),

_ActionCard(
title: 'Daycare',
subtitle: 'Manage check-in and check-out',
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
'Today\'s Reminder',
),
subtitle: const Text(
'Complete attendance before 10:00 AM.',
),
),
),

const SizedBox(height: 24),
FilledButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.logout),
  label: const Text('Logout'),
  ),
  ],
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
      margin: const EdgeInsets.only(bottom: 12),
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
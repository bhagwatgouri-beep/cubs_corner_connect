import 'package:flutter/material.dart';

import '../admissions/add_student_screen.dart';
import '../students/student_directory_screen.dart';
import '../parents/add_parent_screen.dart';
import '../parents/parent_directory_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swayyam Education Foundation"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Admissions",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _MenuCard(
            title: "New Admission",
            icon: Icons.person_add,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddStudentScreen(),
                ),
              );
            },
          ),

          _MenuCard(
            title: "Student Directory",
            icon: Icons.school,
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

          const SizedBox(height: 30),

          const Text(
            "Parents",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _MenuCard(
            title: "New Parent",
            icon: Icons.person_add_alt_1,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddParentScreen(),
                ),
              );
            },
          ),

          _MenuCard(
            title: "Parent Directory",
            icon: Icons.people,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const ParentDirectoryScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 30),

          const Text(
            "Operations",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _MenuCard(
            title: "Attendance",
            icon: Icons.fact_check,
            onTap: () {},
          ),

          _MenuCard(
            title: "Daycare",
            icon: Icons.child_care,
            onTap: () {},
          ),

          _MenuCard(
            title: "Billing",
            icon: Icons.receipt_long,
            onTap: () {},
          ),
        ],
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
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
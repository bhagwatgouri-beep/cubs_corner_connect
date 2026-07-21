import 'package:flutter/material.dart';

import '../../../repositories/billing_repository.dart';
import '../../../repositories/parent_repository.dart';
import '../../../repositories/student_repository.dart';
import '../../../repositories/attendance_repository.dart';
import '../admissions/add_student_screen.dart';
import '../attendance/attendance_dashboard_screen.dart';
import '../billing/billing_dashboard_screen.dart';
import '../daycare/daycare_dashboard_screen.dart';
import '../parents/add_parent_screen.dart';
import '../parents/parent_directory_screen.dart';
import '../students/student_directory_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  static final StudentRepository _studentRepository =
      StudentRepository.instance;

  static final ParentRepository _parentRepository =
      ParentRepository.instance;

  static final BillingRepository _billingRepository =
      BillingRepository.instance;

  static final _attendanceRepository =
      AttendanceRepository.instance;

  @override
  Widget build(BuildContext context) {
    final activeStudents =
        _studentRepository.activeStudents.length;

    final totalParents =
        _parentRepository.parents.length;

    final pendingInvoices =
        _billingRepository.pendingInvoices().length;

    final outstanding =
    _billingRepository.totalOutstanding();

    final presentToday =
        _attendanceRepository.todayAttendance().length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Swayyam Education Foundation'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Snapshot",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Children',
                          value: activeStudents.toString(),
                          icon: Icons.child_care,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          title: 'Parents',
                          value: totalParents.toString(),
                          icon: Icons.people,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Present',
                          value: presentToday.toString(),
                          icon: Icons.fact_check,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          title: 'Invoices',
                          value: pendingInvoices.toString(),
                          icon: Icons.receipt_long,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          title: 'Outstanding',
                          value: '₹${outstanding.toStringAsFixed(0)}',
                          icon: Icons.currency_rupee,
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
            'Admissions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _MenuCard(
            title: 'New Admission',
            icon: Icons.person_add,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const AddStudentScreen(),
                ),
              );
            },
          ),

          _MenuCard(
            title: 'Student Directory',
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
            'Parents',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _MenuCard(
            title: 'New Parent',
            icon: Icons.person_add_alt_1,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const AddParentScreen(),
                ),
              );
            },
          ),

          _MenuCard(
            title: 'Parent Directory',
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
            'Operations',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _MenuCard(
            title: 'Attendance',
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

          _MenuCard(
            title: 'Daycare',
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

          _MenuCard(
            title: 'Billing',
            icon: Icons.receipt_long,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const BillingDashboardScreen(),
                ),
              );
            },
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }
}
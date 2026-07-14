import 'package:flutter/material.dart';

import '../admin/dashboard/admin_dashboard_screen.dart';
import '../parent_story/parent_home_screen.dart';
import '../teacher/teacher_home.dart';

enum UserRole {
  teacher,
  parent,
  centreAdmin,
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    // DEVELOPMENT ONLY
    // Change this to test different modules.
    const role = UserRole.centreAdmin;

    switch (role) {
      case UserRole.teacher:
        return const TeacherHome();

      case UserRole.parent:
        return const ParentHomeScreen();

      case UserRole.centreAdmin:
        return const AdminDashboardScreen();
    }
  }
}
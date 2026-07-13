import 'package:flutter/material.dart';

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
    // Temporary until AuthenticationCoordinator is wired.
    const role = UserRole.teacher;

    switch (role) {
      case UserRole.teacher:
        return const TeacherHome();

      case UserRole.parent:
        return const ParentHomeScreen();

      case UserRole.centreAdmin:
        return const _CentreAdminPlaceholder();
    }
  }
}

class _CentreAdminPlaceholder extends StatelessWidget {
  const _CentreAdminPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centre Admin'),
      ),
      body: const Center(
        child: Text('Centre Admin Dashboard Coming Soon'),
      ),
    );
  }
}
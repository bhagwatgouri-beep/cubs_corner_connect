import 'package:flutter/material.dart';

import '../parent_story/parent_home_screen.dart';
import '../teacher/teacher_home.dart';

/// The roles the app currently knows about.
///
/// This will eventually be determined by a real signed-in user; for now
/// it exists so [AuthGate] has something concrete to route on.
enum UserRole {
  teacher,
  parent,
  centreAdmin,
}

/// Temporary authentication shell.
///
/// This does NOT perform real authentication. It exists to give the app
/// a single, role-based entry point instead of hardcoding a single home
/// screen in `main.dart`. Once real sign-in exists, `role` below should be
/// replaced with the signed-in user's actual role.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with the real signed-in user's role once authentication
    // is implemented (see Sprint 10+). Hardcoded for now.
    final role = UserRole.teacher;

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
      body: const SizedBox.shrink(),
    );
  }
}

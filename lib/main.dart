import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'features/teacher/teacher_home.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';
import 'firebase_options.dart';
import 'features/dashboard/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const CubsCornerConnectApp());
}

class CubsCornerConnectApp extends StatelessWidget {
  const CubsCornerConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cubs Corner Connect',
      theme: AppTheme.lightTheme,
      home: const TeacherHome(),
    );
  }
}
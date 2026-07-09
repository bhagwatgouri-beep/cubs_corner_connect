import 'package:flutter/material.dart';

void main() {
  runApp(const CubsCornerConnectApp());
}

class CubsCornerConnectApp extends StatelessWidget {
  const CubsCornerConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubs Corner Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B6E4F),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B6E4F),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Cubs Corner Connect"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.child_care,
              size: 90,
              color: Color(0xFF0B6E4F),
            ),
            SizedBox(height: 24),
            Text(
              "Welcome to",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Cubs Corner Connect",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B6E4F),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Powered by Swayyam Education",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
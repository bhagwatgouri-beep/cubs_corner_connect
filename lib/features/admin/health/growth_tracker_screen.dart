import 'package:flutter/material.dart';

class GrowthTrackerScreen extends StatelessWidget {
  const GrowthTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Growth Tracker'),
      ),
      body: const Center(
        child: Text(
          'Growth charts will be available here.',
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class IncidentLogScreen extends StatelessWidget {
  const IncidentLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incident Log'),
      ),
      body: const Center(
        child: Text(
          'Incident logging will be available here.',
        ),
      ),
    );
  }
}
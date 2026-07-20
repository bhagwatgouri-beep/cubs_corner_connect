import 'package:flutter/material.dart';

class VaccinationScreen extends StatelessWidget {
  const VaccinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccination Records'),
      ),
      body: const Center(
        child: Text(
          'Vaccination records will be available here.',
        ),
      ),
    );
  }
}
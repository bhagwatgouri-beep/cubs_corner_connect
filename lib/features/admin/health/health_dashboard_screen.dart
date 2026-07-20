import 'package:flutter/material.dart';

import '../../../repositories/health_repository.dart';
import 'add_health_record_screen.dart';
import 'growth_tracker_screen.dart';
import 'incident_log_screen.dart';
import 'medication_screen.dart';
import 'student_health_profile_screen.dart';
import 'vaccination_screen.dart';

class HealthDashboardScreen extends StatelessWidget {
  const HealthDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = HealthRepository.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.health_and_safety),
              title: const Text('Health Records'),
              trailing: Text(
                repository.records.length.toString(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const AddHealthRecordScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Health Record'),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const StudentHealthProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person),
            label: const Text('Student Health Profiles'),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const GrowthTrackerScreen(),
                ),
              );
            },
            icon: const Icon(Icons.monitor_weight),
            label: const Text('Growth Tracker'),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const VaccinationScreen(),
                ),
              );
            },
            icon: const Icon(Icons.vaccines),
            label: const Text('Vaccinations'),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const MedicationScreen(),
                ),
              );
            },
            icon: const Icon(Icons.medication),
            label: const Text('Medications'),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const IncidentLogScreen(),
                ),
              );
            },
            icon: const Icon(Icons.report),
            label: const Text('Incident Log'),
          ),
        ],
      ),
    );
  }
}
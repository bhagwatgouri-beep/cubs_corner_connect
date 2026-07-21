import 'package:flutter/material.dart';

import '../../../../models/student.dart';

class DaycareTab extends StatelessWidget {
  final Student student;

  const DaycareTab({
    super.key,
    required this.student,
  });

  Widget _tile(
      String title,
      String value,
      IconData icon,
      ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _tile(
          'Enrolled',
          'No',
          Icons.child_care,
        ),
        _tile(
          'Pickup Person',
          '-',
          Icons.person,
        ),
        _tile(
          'Pickup Time',
          '-',
          Icons.schedule,
        ),
        _tile(
          'Transport',
          '-',
          Icons.directions_bus,
        ),
        _tile(
          "Today's Attendance",
          '-',
          Icons.fact_check,
        ),
        const SizedBox(height: 24),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Daycare records will appear here.',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Students', Icons.school),
      ('Parents', Icons.people),
      ('Teachers', Icons.person),
      ('Classrooms', Icons.class_),
      ('Attendance', Icons.fact_check),
      ('Daycare', Icons.child_care),
      ('Billing', Icons.receipt_long),
      ('Reports', Icons.bar_chart),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Swayyam Education Foundation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final item = items[index];

            return Card(
              elevation: 3,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.$2,
                      size: 46,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.$1,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
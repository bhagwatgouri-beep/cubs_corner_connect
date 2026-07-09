import 'package:flutter/material.dart';

import 'controllers/dashboard_controller.dart';
import 'widgets/child_header.dart';
import 'widgets/journey_card.dart';
import 'widgets/memories_card.dart';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController();
    final child = controller.getCurrentChild();
    final journey = controller.getTodayJourney();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cubs Corner Connect"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ChildHeader(child: child),

            const SizedBox(height: 20),

            JourneyCard(journey: journey),
            const SizedBox(height: 20),

            MemoriesCard(
              memories: child.memoriesToday,
            ),
          ],
        ),
      ),
    );
  }
}
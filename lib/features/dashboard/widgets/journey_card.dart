import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class JourneyCard extends StatelessWidget {
  final List<Map<String, String>> journey;

  const JourneyCard({
    super.key,
    required this.journey,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🌈 Today's Journey",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            ...journey.map(
                  (item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['icon']!,
                      style: const TextStyle(fontSize: 22),
                    ),

                    const SizedBox(width: 16),

                    SizedBox(
                      width: 85,
                      child: Text(
                        item['time']!,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Text(
                        item['title']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
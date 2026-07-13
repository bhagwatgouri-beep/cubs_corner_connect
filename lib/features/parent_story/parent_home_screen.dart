import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'models/parent_story_item.dart';
import 'widgets/parent_header.dart';
import 'widgets/todays_highlights.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  List<ParentStoryItem> get _sampleHighlights {
    final now = DateTime.now();

    return [
      ParentStoryItem(
        id: 'arrival-${now.microsecondsSinceEpoch}',
        time: now.subtract(const Duration(minutes: 2)),
        emoji: '🟢',
        title: 'Arrived Safely',
        description: 'Arrived safely at daycare.',
        sourceEvent: 'Arrival',
      ),
      ParentStoryItem(
        id: 'breakfast-${now.microsecondsSinceEpoch}',
        time: now.subtract(const Duration(minutes: 32)),
        emoji: '🍎',
        title: 'Enjoyed Breakfast',
        description: 'Enjoyed breakfast.',
        sourceEvent: 'Breakfast',
      ),
      ParentStoryItem(
        id: 'memory-${now.microsecondsSinceEpoch}',
        time: now.subtract(const Duration(minutes: 58)),
        emoji: '📷',
        title: 'New Memories',
        description: "New photos from today's activities have been added.",
        sourceEvent: 'Memory',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final highlights = _sampleHighlights;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubs Corner Connect'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ParentHeader(
              childName: 'Aryan Bhagwat',
              classroom: 'Nursery A',
            ),
            const SizedBox(height: 16),
            Text(
              "Today's Highlights",
              style: AppTextStyles.textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 260,
              child: TodaysHighlights(items: highlights),
            ),
            const SizedBox(height: 16),
            const _MemoriesCard(),
            const SizedBox(height: 16),
            const _TeacherNoteCard(),
          ],
        ),
      ),
    );
  }
}

class _MemoriesCard extends StatelessWidget {
  const _MemoriesCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.cubsOrange.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.photo_library_rounded,
                color: AppColors.cubsOrange,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Memories",
                    style: AppTextStyles.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '4 Latest Photos',
                    style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeacherNoteCard extends StatelessWidget {
  const _TeacherNoteCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From Your Teacher',
              style: AppTextStyles.textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Aryan had a cheerful morning and participated happily during '
              'circle time. He especially enjoyed the story activity today.',
              style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

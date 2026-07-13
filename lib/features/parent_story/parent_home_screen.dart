import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'models/parent_story_item.dart';
import 'services/story_repository.dart';
import 'widgets/parent_header.dart';
import 'widgets/todays_highlights.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  List<ParentStoryItem> get _highlights {
    final items = StoryRepository.instance.getAll().toList();
    items.sort((a, b) => b.time.compareTo(a.time));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final highlights = _highlights;

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

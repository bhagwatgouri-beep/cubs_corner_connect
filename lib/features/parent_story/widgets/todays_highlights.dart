import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../models/parent_story_item.dart';

class TodaysHighlights extends StatelessWidget {
  final List<ParentStoryItem> items;

  const TodaysHighlights({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _EmptyHighlights();
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == items.length - 1 ? 0 : 12,
          ),
          child: _ParentStoryCard(item: items[index]),
        );
      },
    );
  }
}

class _ParentStoryCard extends StatelessWidget {
  final ParentStoryItem item;

  const _ParentStoryCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.swayyamGreen.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                item.emoji,
                style: const TextStyle(fontSize: 26),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: AppTextStyles.textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _formatTime(item.time),
                        style: AppTextStyles.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _EmptyHighlights extends StatelessWidget {
  const _EmptyHighlights();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No highlights yet',
        style: AppTextStyles.textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

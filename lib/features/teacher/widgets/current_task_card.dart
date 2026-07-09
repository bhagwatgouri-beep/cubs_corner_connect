import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../models/flow_event.dart';

class CurrentTaskCard extends StatelessWidget {
  final FlowEvent event;
  final int exceptionCount;
  final VoidCallback onComplete;
  final VoidCallback onAddException;

  const CurrentTaskCard({
    super.key,
    required this.event,
    required this.exceptionCount,
    required this.onComplete,
    required this.onAddException,
  });

  @override
  Widget build(BuildContext context) {
    final menuText = event.menuItems.isEmpty
        ? 'No Menu'
        : event.menuItems.join(' • ');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.cubsOrange.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    event.emoji,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Now',
                        style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        event.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'Menu',
              style: AppTextStyles.textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              menuText,
              style: AppTextStyles.textTheme.bodyLarge,
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: onComplete,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(58),
              ),
              icon: const Icon(Icons.check_rounded),
              label: const Text('Complete Step'),
            ),
            if (event.supportsExceptions) ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: onAddException,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(58),
                ),
                icon: const Icon(Icons.warning_amber_rounded),
                label: Text('⚠ Exceptions ($exceptionCount)'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class ParentHeader extends StatelessWidget {
  final String childName;
  final String classroom;
  final String status;
  final String updatedLabel;

  const ParentHeader({
    super.key,
    required this.childName,
    required this.classroom,
    this.status = '🟢 In Cubs Corner',
    this.updatedLabel = 'Updated 2 mins ago',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        childName,
                        style: AppTextStyles.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        classroom,
                        style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  updatedLabel,
                  style: AppTextStyles.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.swayyamGreen.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: AppTextStyles.textTheme.titleSmall?.copyWith(
                  color: AppColors.swayyamGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

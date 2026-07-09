import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'arrival_exception_dialog.dart';

class ArrivalExceptionTile extends StatelessWidget {
  final ArrivalException exception;

  const ArrivalExceptionTile({
    super.key,
    required this.exception,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: AppColors.warning,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exception.childName,
                    style: AppTextStyles.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    exception.reason,
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
}

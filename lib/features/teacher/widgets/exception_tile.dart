import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import 'exception_dialog.dart';

class ExceptionTile extends StatelessWidget {
  final BreakfastException exception;

  const ExceptionTile({
    super.key,
    required this.exception,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.warning.withValues(alpha: 0.16),
          child: const Icon(
            Icons.info_outline_rounded,
            color: AppColors.warning,
          ),
        ),
        title: Text(
          exception.childName,
          style: AppTextStyles.textTheme.titleMedium,
        ),
        subtitle: Text(
          exception.reason,
          style: AppTextStyles.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../models/memory.dart';

class MemorySummaryCard extends StatelessWidget {
  final MemoryRecord memory;

  const MemorySummaryCard({
    super.key,
    required this.memory,
  });

  @override
  Widget build(BuildContext context) {
    final audienceLabel = memory.isForEntireClass
        ? 'Entire Class'
        : memory.selectedChildren.join(', ');

    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.swayyamGreen,
          child: Icon(
            Icons.photo_library_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          '${memory.photos.length} photos',
          style: AppTextStyles.textTheme.titleMedium,
        ),
        subtitle: Text(
          audienceLabel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

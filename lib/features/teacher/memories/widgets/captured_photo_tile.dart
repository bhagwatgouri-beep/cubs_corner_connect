import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../models/memory.dart';

class CapturedPhotoTile extends StatelessWidget {
  final CapturedMemoryPhoto photo;
  final int index;
  final VoidCallback onRemove;

  const CapturedPhotoTile({
    super.key,
    required this.photo,
    required this.index,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.swayyamGreen.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.photo_camera_rounded,
                    color: AppColors.swayyamGreen,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Photo ${index + 1}',
                    style: AppTextStyles.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatTime(photo.capturedAt),
                    style: AppTextStyles.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: IconButton.filledTonal(
                onPressed: onRemove,
                icon: const Icon(Icons.close_rounded),
                tooltip: 'Remove photo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

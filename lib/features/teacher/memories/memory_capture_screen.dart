import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import 'models/memory.dart';
import 'services/local_memory_store.dart';
import 'widgets/captured_photo_tile.dart';
import 'widgets/memory_audience_dialog.dart';

class MemoryCaptureScreen extends StatefulWidget {
  const MemoryCaptureScreen({super.key});

  @override
  State<MemoryCaptureScreen> createState() => _MemoryCaptureScreenState();
}

class _MemoryCaptureScreenState extends State<MemoryCaptureScreen> {
  static const List<String> _children = [
    'Aryan',
    'Kabir',
    'Aarav',
    'Ira',
    'Mira',
  ];

  final List<CapturedMemoryPhoto> _photos = [];

  void _capturePhoto() {
    final capturedAt = DateTime.now();

    setState(() {
      _photos.add(
        CapturedMemoryPhoto(
          id: capturedAt.microsecondsSinceEpoch.toString(),
          capturedAt: capturedAt,
        ),
      );
    });
  }

  void _removePhoto(CapturedMemoryPhoto photo) {
    setState(() {
      _photos.remove(photo);
    });
  }

  Future<void> _finishCapture() async {
    if (_photos.isEmpty) {
      return;
    }

    final selection = await showDialog<MemoryAudienceSelection>(
      context: context,
      builder: (_) => const MemoryAudienceDialog(children: _children),
    );

    if (selection == null || !mounted) {
      return;
    }

    final createdAt = DateTime.now();
    LocalMemoryStore.instance.save(
      MemoryRecord(
        id: createdAt.microsecondsSinceEpoch.toString(),
        photos: List.unmodifiable(_photos),
        audience: selection.audience,
        selectedChildren: selection.selectedChildren,
        createdAt: createdAt,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Memory Saved'),
      ),
    );

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Memory'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _CaptureHeader(photoCount: _photos.length),
              const SizedBox(height: 12),
              Expanded(
                child: _photos.isEmpty
                    ? const _EmptyCaptureState()
                    : GridView.builder(
                        itemCount: _photos.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          final photo = _photos[index];
                          return CapturedPhotoTile(
                            photo: photo,
                            index: index,
                            onRemove: () => _removePhoto(photo),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _capturePhoto,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(60),
                ),
                icon: const Icon(Icons.photo_camera_rounded),
                label: const Text('Camera'),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _photos.isEmpty ? null : _finishCapture,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(58),
                ),
                icon: const Icon(Icons.done_rounded),
                label: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CaptureHeader extends StatelessWidget {
  final int photoCount;

  const _CaptureHeader({
    required this.photoCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(
              Icons.collections_rounded,
              color: AppColors.swayyamGreen,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Memory Capture',
                    style: AppTextStyles.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$photoCount photos captured',
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

class _EmptyCaptureState extends StatelessWidget {
  const _EmptyCaptureState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.photo_camera_back_rounded,
            color: AppColors.textSecondary.withValues(alpha: 0.6),
            size: 64,
          ),
          const SizedBox(height: 12),
          Text(
            'Press Camera to capture memories',
            textAlign: TextAlign.center,
            style: AppTextStyles.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

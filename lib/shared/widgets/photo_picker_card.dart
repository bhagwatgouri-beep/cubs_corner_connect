import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerCard extends StatefulWidget {
  final String imagePath;
  final ValueChanged<String> onImageSelected;
  final String title;

  const PhotoPickerCard({
    super.key,
    required this.imagePath,
    required this.onImageSelected,
    this.title = 'Student Photo',
  });

  @override
  State<PhotoPickerCard> createState() => _PhotoPickerCardState();
}

class _PhotoPickerCardState extends State<PhotoPickerCard> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pick(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1200,
    );

    if (image == null) return;

    widget.onImageSelected(image.path);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.imagePath.isNotEmpty;

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 20),

            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.grey.shade200,
              backgroundImage:
              hasImage ? FileImage(File(widget.imagePath)) : null,
              child: hasImage
                  ? null
                  : const Icon(
                Icons.person,
                size: 55,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _pick(ImageSource.camera),
                    icon: const Icon(Icons.photo_camera),
                    label: const Text("Camera"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _pick(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text("Gallery"),
                  ),
                ),
              ],
            ),

            if (hasImage) ...[
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () {
                  widget.onImageSelected('');
                  setState(() {});
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text("Remove Photo"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class DeleteInvoiceDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteInvoiceDialog({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Invoice'),
      content: const Text(
        'Are you sure you want to delete this invoice?\n\nThis action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            onDelete();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
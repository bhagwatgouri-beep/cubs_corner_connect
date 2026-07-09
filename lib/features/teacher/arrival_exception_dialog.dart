import 'package:flutter/material.dart';

class ArrivalException {
  final String childName;
  final String reason;

  const ArrivalException({
    required this.childName,
    required this.reason,
  });
}

class ArrivalExceptionDialog extends StatefulWidget {
  const ArrivalExceptionDialog({super.key});

  @override
  State<ArrivalExceptionDialog> createState() => _ArrivalExceptionDialogState();
}

class _ArrivalExceptionDialogState extends State<ArrivalExceptionDialog> {
  static const List<String> _children = [
    'Aryan',
    'Kabir',
    'Aarav',
    'Ira',
    'Mira',
  ];

  static const List<String> _reasons = [
    'Absent',
    'Late Arrival',
    'On Leave',
    'Medical Leave',
  ];

  String _selectedChild = _children.first;
  String _selectedReason = _reasons.first;

  void _save() {
    Navigator.of(context).pop(
      ArrivalException(
        childName: _selectedChild,
        reason: _selectedReason,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Exception'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedChild,
            decoration: const InputDecoration(
              labelText: 'Child',
            ),
            items: _children
                .map(
                  (child) => DropdownMenuItem<String>(
                    value: child,
                    child: Text(child),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }

              setState(() {
                _selectedChild = value;
              });
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedReason,
            decoration: const InputDecoration(
              labelText: 'Reason',
            ),
            items: _reasons
                .map(
                  (reason) => DropdownMenuItem<String>(
                    value: reason,
                    child: Text(reason),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }

              setState(() {
                _selectedReason = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _save,
          child: const Text('Save'),
        ),
      ],
    );
  }
}

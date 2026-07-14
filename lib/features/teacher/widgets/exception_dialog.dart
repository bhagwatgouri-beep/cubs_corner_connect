import 'package:flutter/material.dart';

class FlowEventException {
  final String childName;
  final String reason;

  const FlowEventException({
    required this.childName,
    required this.reason,
  });
}

class ExceptionDialog extends StatefulWidget {
  const ExceptionDialog({super.key});

  @override
  State<ExceptionDialog> createState() => _ExceptionDialogState();
}

class _ExceptionDialogState extends State<ExceptionDialog> {
  static const List<String> _children = [
    'Aarav Sharma',
    'Aryan Bhagwat',
    'Ira Mehta',
    'Kabir Rao',
    'Mira Joshi',
  ];

  static const List<String> _reasons = [
    'Did Not Participate',
    'Partial Completion',
    'Medical Reason',
    'Family Request',
  ];

  String _selectedChild = _children.first;
  String _selectedReason = _reasons.first;

  void _saveException() {
    Navigator.of(context).pop(
      FlowEventException(
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
            initialValue: _selectedChild,
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
            initialValue: _selectedReason,
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
          onPressed: _saveException,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
